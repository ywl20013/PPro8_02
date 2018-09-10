unit Data.Provider.UDP;

interface

uses
  System.SysUtils,
  System.Classes,
  IdBaseComponent,
  IdComponent,
  IdUDPBase,
  IdUDPServer;

type
  TdmProviderUDP = class( TDataModule )
    IdUDPServer1: TIdUDPServer;
  private
    FPort: Word;
    function GetActive: Boolean;
    procedure SetActive( const Value: Boolean );
    { Private declarations }
  public
    property Active: Boolean read GetActive write SetActive;
    property Port  : Word read FPort write FPort;
  end;

var
  dmProviderUDP: TdmProviderUDP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmProviderUDP }

function TdmProviderUDP.GetActive: Boolean;
begin
  Result := self.IdUDPServer1.Active;
end;

procedure TdmProviderUDP.SetActive( const Value: Boolean );
begin
  self.IdUDPServer1.DefaultPort := self.FPort;
  self.IdUDPServer1.Active      := Value;
end;

end.
