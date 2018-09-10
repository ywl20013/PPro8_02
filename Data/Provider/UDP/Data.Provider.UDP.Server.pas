unit Data.Provider.UDP.Server;

interface

uses
  System.SysUtils,
  System.Classes,
  IdBaseComponent,
  IdComponent,
  IdUDPBase,
  IdUDPServer,
  IdGlobal,
  IdSocketHandle;

type
  TdmProviderUDPServer = class( TDataModule )
    IdUDPServer1: TIdUDPServer;
    procedure IdUDPServer1UDPRead( AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle );
  private
    FPort     : Word;
    FOnUDPRead: TUDPReadEvent;
    function GetActive: Boolean;
    procedure SetActive( const Value: Boolean );
  public
    property Active   : Boolean read GetActive write SetActive;
    property Port     : Word read FPort write FPort;
    property OnUDPRead: TUDPReadEvent read FOnUDPRead write FOnUDPRead;
  end;

var
  dmProviderUDPServer: TdmProviderUDPServer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmProviderUDPServer }

function TdmProviderUDPServer.GetActive: Boolean;
begin
  Result := self.IdUDPServer1.Active;
end;

procedure TdmProviderUDPServer.IdUDPServer1UDPRead(
  AThread: TIdUDPListenerThread; const AData: TIdBytes;
  ABinding: TIdSocketHandle );
begin
  if Assigned( self.FOnUDPRead ) then
      self.FOnUDPRead( AThread, AData, ABinding );
end;

procedure TdmProviderUDPServer.SetActive( const Value: Boolean );
begin
  self.IdUDPServer1.DefaultPort := self.FPort;
  self.IdUDPServer1.Active      := Value;
end;

end.
