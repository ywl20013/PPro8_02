unit UI.Test;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Data.Provider,
  IdUDPServer,
  IdGlobal,
  IdSocketHandle,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfmTest = class( TForm )
    btn1: TButton;
    Memo1: TMemo;
    chkListening: TCheckBox;
    chkSendTestUDPData: TCheckBox;
    tmrLabelFormSizeDisplay: TTimer;
    chkStoreToSqlite: TCheckBox;
    edtUDPPort: TEdit;
    procedure btn1Click( Sender: TObject );
    procedure FormCreate( Sender: TObject );
    procedure chkListeningClick( Sender: TObject );
    procedure chkSendTestUDPDataClick( Sender: TObject );
    procedure tmrLabelFormSizeDisplayTimer( Sender: TObject );
    procedure FormResize( Sender: TObject );
    procedure chkStoreToSqliteClick( Sender: TObject );
    procedure edtUDPPortChange( Sender: TObject );
  private
    FLabelFormSizeDisplay: TLabel;

    FDataProvider: TDataProvider;

    FUDPPort: Word;

    procedure IdUDPServerUDPRead( AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle );
  public
    procedure Init;
  end;

var
  fmTest: TfmTest;

implementation

uses
  Models.L2,
  Net.UDP.Test,
  Net.UDP.Server,
  Data.Provider.Sqlite.L2;

{$R *.dfm}


procedure TfmTest.btn1Click( Sender: TObject );
var
  L2: TL2Line;
begin
  L2 := TL2Line.FromCSVString
    ( 'LocalTime=08:37:31.908,MarketTime=00:00:00.000,Mmid=,Side=s,Price=0,Volume=0,Depth=0,SequenceNumber=0' );
  try
    Application.MessageBox( PChar( L2.ToCSVString ), PChar( self.Caption ) );
  finally
    L2.Free;
  end;

  L2 := TL2Line.FromCSVString
    ( 'LocalTime=08:37:35.706,MarketTime=00:00:00.000,Mmid=,Side=e,Price=0,Volume=0,Depth=0,SequenceNumber=0' );
  try
    Application.MessageBox( PChar( L2.ToCSVString ), PChar( self.Caption ) );
  finally
    L2.Free;
  end;
end;

procedure TfmTest.chkListeningClick( Sender: TObject );
begin
  if TCheckBox( Sender ).Checked then
  begin
    if ( not Assigned( dmProviderUDPServer ) ) then
    begin
      dmProviderUDPServer           := TdmProviderUDPServer.Create( Application );
      dmProviderUDPServer.OnUDPRead := self.IdUDPServerUDPRead;
    end;
    dmProviderUDPServer.Port   := FUDPPort;
    dmProviderUDPServer.Active := True;
  end
  else
  begin
    if ( Assigned( dmProviderUDPServer ) ) then
    begin
      dmProviderUDPServer.Active := False;
    end;
  end;
  edtUDPPort.Enabled := not TCheckBox( Sender ).Checked;
end;

procedure TfmTest.chkSendTestUDPDataClick( Sender: TObject );
begin
  if TCheckBox( Sender ).Checked then
  begin
    if ( not Assigned( dmProviderUDPTest ) ) then
    begin
      dmProviderUDPTest      := TdmProviderUDPTest.Create( Application );
      dmProviderUDPTest.Port := FUDPPort;
    end;
    dmProviderUDPTest.Active := True;
  end
  else
  begin
    if ( Assigned( dmProviderUDPTest ) ) then
    begin
      dmProviderUDPTest.Active := False;
    end;
  end;
end;

procedure TfmTest.chkStoreToSqliteClick( Sender: TObject );
begin
  if TCheckBox( Sender ).Checked then
  begin
    if ( not Assigned( FDataProvider ) ) then
    begin
      FDataProvider := TdmDataProviderSqliteL2.Create( Application );
    end;
    FDataProvider.Active := True;

    TdmDataProviderSqliteL2( FDataProvider ).CheckTables;
  end
  else
  begin
    if ( Assigned( FDataProvider ) ) then
    begin
      FDataProvider.Active := False;
    end;
  end;
end;

procedure TfmTest.edtUDPPortChange( Sender: TObject );
begin
  FUDPPort                   := StrToUIntDef( edtUDPPort.Text, 7026 );
  chkSendTestUDPData.Caption := '测试每1秒向本机UDP:' + FUDPPort.ToString + '端口发送Level2数据';
  chkListening.Caption       := '监听本地UDP:' + FUDPPort.ToString + '端口';

  if ( Assigned( dmProviderUDPTest ) ) then
  begin
    dmProviderUDPTest.Port := FUDPPort;
  end;
end;

procedure TfmTest.FormCreate( Sender: TObject );
begin
  self.OnResize  := nil;
  self.Font.Name := 'Consolas';
  self.Font.Size := 10;
  self.Caption   := '测试';
  self.Width     := 1000;
  btn1.Caption   := '测试解析Level2 csv字符串';

  edtUDPPort.Text            := '7026';
  chkSendTestUDPData.Caption := '测试每1秒向本机UDP:' + FUDPPort.ToString + '端口发送Level2数据';
  chkListening.Caption       := '监听本地UDP:' + FUDPPort.ToString + '端口';
  chkStoreToSqlite.Caption   := '保存数据到本地Sqlite库(ppro8.db)';

  self.Memo1.Clear;
  self.OnResize := self.FormResize;
end;

procedure TfmTest.FormResize( Sender: TObject );
begin

  if not Assigned( FLabelFormSizeDisplay ) then
  begin
    FLabelFormSizeDisplay        := TLabel.Create( self );
    FLabelFormSizeDisplay.Left   := 8;
    FLabelFormSizeDisplay.Top    := 8;
    FLabelFormSizeDisplay.Parent := self;
    FLabelFormSizeDisplay.BringToFront;
  end;
  if Assigned( FLabelFormSizeDisplay ) then
      FLabelFormSizeDisplay.Caption := Format( 'width=%d,height=%d', [ self.Width, self.Height ] );
  tmrLabelFormSizeDisplay.Enabled   := False;
  tmrLabelFormSizeDisplay.Enabled   := True;

end;

procedure TfmTest.IdUDPServerUDPRead( AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle );
var
  str   : string;
  l2line: TL2Line;
begin
  str := BytesToString( AData ).Replace( #13#10, '' ).Replace( #13, '' ).Replace( #10, '' );
  if ( Assigned( FDataProvider ) ) then
  begin
    l2line := TL2Line.FromCSVString( str );
    try
      if not l2line.SaveToDataBase( FDataProvider ) then
          raise Exception.Create( 'save error' );
    finally
      l2line.Free;
    end;
  end;

  self.Memo1.Lines.Add( str );
end;

procedure TfmTest.Init;
begin
  chkStoreToSqlite.Checked := True;
  chkListening.Checked     := True;
  // chkStoreToSqliteClick( chkStoreToSqlite );
  // chkListeningClick( chkListening );
end;

procedure TfmTest.tmrLabelFormSizeDisplayTimer( Sender: TObject );
begin
  if Assigned( FLabelFormSizeDisplay ) then
  begin
    FLabelFormSizeDisplay.Free;
    FLabelFormSizeDisplay := nil;
  end;

  TTimer( Sender ).Enabled := False;
end;

end.
