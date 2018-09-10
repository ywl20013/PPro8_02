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
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfmMain = class( TForm )
    Memo1: TMemo;
    chkStoreToSqlite: TCheckBox;
    chkListening: TCheckBox;
    edtUDPPort: TEdit;
    procedure FormCreate( Sender: TObject );
    procedure chkListeningClick( Sender: TObject );
    procedure chkStoreToSqliteClick( Sender: TObject );
    procedure edtUDPPortChange( Sender: TObject );
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

  Net.UDP.Server,
  Data.Provider.Sqlite.L2;
{$R *.dfm}


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
  FUDPPort             := StrToUIntDef( edtUDPPort.Text, 7026 );
  chkListening.Caption := '监听本地UDP:' + FUDPPort.ToString + '端口';
end;

procedure TfmMain.FormCreate( Sender: TObject );
begin
  self.OnResize            := nil;
  self.Font.Name           := 'Consolas';
  self.Font.Size           := 10;
  self.Caption             := '获取PPro8 API 数据';
  self.Width               := 1000;
  edtUDPPort.Text          := '7026';
  chkListening.Caption     := '监听本地UDP:' + FUDPPort.ToString + '端口';
  chkStoreToSqlite.Caption := '保存数据到本地Sqlite库(ppro8.db)';

  self.Memo1.Clear;
end;

procedure TfmMain.IdUDPServerUDPRead( AThread: TIdUDPListenerThread;
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

procedure TfmMain.Init;
begin
  chkStoreToSqlite.Checked := True;
  chkListening.Checked     := True;
end;

end.
