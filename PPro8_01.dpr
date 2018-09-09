program PPro8_01;

uses
  Vcl.Forms,
  UI.Main in 'UI.Main.pas' {fmMain} ,
  Models.L2 in 'Models\Models.L2.pas',
  UI.Test in 'UI.Test.pas' {fmTest};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTest, fmTest);
  Application.Run;

end.
