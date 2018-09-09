unit UI.Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmTest = class(TForm)
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    Application.MessageBox(PChar(L2.CSVString), PChar(self.Caption));
  finally
    L2.Free;
  end;

  L2 := TL2Line.FromCSVString
    ('LocalTime=08:37:35.706,MarketTime=00:00:00.000,Mmid=,Side=e,Price=0,Volume=0,Depth=0,SequenceNumber=0');
  try
    Application.MessageBox(PChar(L2.CSVString), PChar(self.Caption));
  finally
    L2.Free;
  end;
end;

procedure TfmTest.btn2Click(Sender: TObject);
var
  strs: TArray<string>;
  str1, str2: string;
begin
  strs := 'Mmid='.Split(['=']);
  str1 := strs[0];
  str2 := strs[1];
  ShowMessage(str1 + ' ' + str2);
end;

procedure TfmTest.FormCreate(Sender: TObject);
begin
  self.Caption := '≤‚ ‘';
end;

end.
