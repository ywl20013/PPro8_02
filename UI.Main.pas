unit UI.Main;

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
  ComObj,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TfmMain = class( TForm )
    chkStoreToSqlite: TCheckBox;
    chkListening: TCheckBox;
    edtUDPPort: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    Splitter1: TSplitter;
    chkCalcLevel2: TCheckBox;
    procedure FormCreate( Sender: TObject );
    procedure chkListeningClick( Sender: TObject );
    procedure chkStoreToSqliteClick( Sender: TObject );
    procedure edtUDPPortChange( Sender: TObject );
    procedure FormDestroy( Sender: TObject );
    procedure Button1Click( Sender: TObject );
    private
      FDataProvider: TDataProvider;
      FUDPPort     : Word;

      procedure IdUDPServerUDPRead( AThread: TIdUDPListenerThread;
        const AData: TIdBytes; ABinding: TIdSocketHandle );
    public
      procedure Init;
  end;

var
  fmMain: TfmMain;

implementation

uses
  Models.L2,
  UI.Test,
  Net.UDP.Server,
  Data.Provider.Sqlite.L2;

var
  BL2s: TL2Levels;
  AL2s: TL2Levels;

{$R *.dfm}


procedure TfmMain.Button1Click( Sender: TObject );
begin
  if ( fmTest = nil ) then
    fmTest := TfmTest.Create( Application );
  fmTest.Show( );
end;

procedure TfmMain.chkListeningClick( Sender: TObject );
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

procedure TfmMain.chkStoreToSqliteClick( Sender: TObject );
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

procedure TfmMain.edtUDPPortChange( Sender: TObject );
begin
  FUDPPort             := StrToIntDef( edtUDPPort.Text, 7026 );
  chkListening.Caption := '监听本地UDP:' + FUDPPort.ToString + '端口';
end;

procedure TfmMain.FormCreate( Sender: TObject );
begin
  self.OnResize  := nil;
  self.Font.Name := 'Consolas';
  self.Font.Size := 10;
  self.Caption   := '获取PPro8 API 数据';
  // self.Width               := 1000;
  edtUDPPort.Text          := '4135';
  chkListening.Caption     := '监听本地UDP:' + FUDPPort.ToString + '端口';
  chkStoreToSqlite.Caption := '保存数据到本地Sqlite库(ppro8.db)';
  chkCalcLevel2.Caption    := '解析 Mark Depth 数据';
  self.Memo1.Clear;

  BL2s := TL2Levels.Create;
  AL2s := TL2Levels.Create;
end;

procedure TfmMain.FormDestroy( Sender: TObject );
begin
  BL2s.Destroy;
  AL2s.Destroy;
end;

procedure TfmMain.IdUDPServerUDPRead( AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle );
var
  sSource, sReplaced, guid: string;
  l2line                  : TL2Line;
  tick                    : Cardinal;
  done                    : boolean;
begin
  // guid      := CreateClassID;
  done      := False;
  tick      := GetTickCount;
  sSource   := BytesToString( AData );
  sReplaced := BytesToString( AData ).Replace( #13#10, '' ).Replace( #13, '' ).Replace( #10, '' );
  if chkCalcLevel2.Checked then
  begin
    l2line := TL2Line.FromCSVString( sReplaced );
    try
      if ( l2line.Side.ToLower = 'b' ) then
      begin
        BL2s.Parse( l2line );
      end;
      if ( l2line.Side.ToLower = 'a' ) then
      begin
        AL2s.Parse( l2line );
      end;

      if ( Assigned( FDataProvider ) ) then
      begin
        // l2line.RID := guid;
        if not l2line.SaveToDataBase( FDataProvider ) then
          raise Exception.Create( 'save error' );
      end;
      tick := GetTickCount - tick;
      done := True;
      if ( l2line.Side.ToLower = 'b' ) then
      begin
        BL2s.RenderToListBox( self.ListBox1 );
      end;
      if ( l2line.Side.ToLower = 'a' ) then
      begin
        AL2s.RenderToListBox( self.ListBox2 );
      end;
    finally
      l2line.Free;
    end;
  end;
  self.Memo1.Lines.Add( sSource );
  if ( done ) then
    self.Memo1.Lines.Add( 'used ' + tick.ToString + ' ms.' );
  // self.Memo1.Lines.Add( '' );
end;

procedure TfmMain.Init;
begin
  chkStoreToSqlite.Checked := True;
  chkListening.Checked     := True;
end;

end.
