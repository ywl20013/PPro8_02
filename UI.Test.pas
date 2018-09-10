unit UI.Test;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TfmTest = class( TForm )
    btn1: TButton;
    btnStartUDP: TButton;
    procedure btn1Click( Sender: TObject );
    procedure FormCreate( Sender: TObject );
    procedure btnStartUDPClick( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTest: TfmTest;

implementation

uses
  Models.L2,
  Data.Provider.UDP;

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

procedure TfmTest.btnStartUDPClick( Sender: TObject );
begin
  dmProviderUDP        := TdmProviderUDP.Create( Application );
  dmProviderUDP.Port   := 7026;
  dmProviderUDP.Active := True;
end;

procedure TfmTest.FormCreate( Sender: TObject );
begin
  self.Caption := '≤‚ ‘';
  btn1.Caption := '≤‚ ‘Ω‚ŒˆLevel2 csv◊÷∑˚¥Æ';
end;

end.
