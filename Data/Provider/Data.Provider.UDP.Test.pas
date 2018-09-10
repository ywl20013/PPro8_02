unit Data.Provider.UDP.Test;

interface

uses
  System.SysUtils,
  System.Classes,
  IdBaseComponent,
  IdComponent,
  IdUDPBase,
  IdUDPServer,
  Vcl.ExtCtrls;

type
  TdmProviderUDP = class( TDataModule )
    IdUDPServer1: TIdUDPServer;
    Timer1: TTimer;
    procedure Timer1Timer( Sender: TObject );
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

uses
  Models.L2;

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
  Timer1.Enabled                := Value;
end;

procedure TdmProviderUDP.Timer1Timer( Sender: TObject );
var
  L2: TL2Line;
begin
  L2                := TL2Line.Create;
  L2.LocalTime      := Now;
  L2.MarketTime     := Now;
  L2.Mmid           := 'ANON';
  L2.Side           := 's';
  L2.Price          := 1.65;
  L2.Volume         := 100;
  L2.Depth          := 1;
  L2.SequenceNumber := 27003;
  try
    self.IdUDPServer1.Send( '127.0.0.1', 7026, L2.ToCSVString );

    L2.LocalTime  := Now;
    L2.MarketTime := Now;
    L2.Side       := 'e';
    L2.Price      := 1.66;
    L2.Volume     := 200;
    self.IdUDPServer1.Send( '127.0.0.1', 7026, L2.ToCSVString );
  finally
    L2.Free;
  end;
end;

end.
