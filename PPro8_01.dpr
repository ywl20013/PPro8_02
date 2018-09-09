program PPro8_01;

uses
  Vcl.Forms,
  UI.Main in 'UI.Main.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
