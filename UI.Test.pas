unit UI.Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmTest = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTest: TfmTest;

implementation

uses
  Models.L2;

{$R *.dfm}

procedure TfmTest.btn1Click(Sender: TObject);
var
  L2: TL2Line;
begin
  L2 := TL2Line.FromCSVString
    ('LocalTime=08:37:31.908,MarketTime=00:00:00.000,Mmid=,Side=s,Price=0,Volume=0,Depth=0,SequenceNumber=0');
  try

  finally
    L2.Free;
  end;
end;

end.
