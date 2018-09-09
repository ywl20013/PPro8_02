program PPro8_01;

uses
  Vcl.Forms,
  UI.Main in 'UI.Main.pas' {fmMain} ,
  Models.L2 in 'Models\Models.L2.pas',
  UI.Test in 'UI.Test.pas' {fmTest} ,
  DateTimeHelper in 'DateTimeHelper.pas',
  Data.Provider.UDP in 'Data.Provider.UDP.pas' {dmProviderUDP: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  // Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTest, fmTest);
  Application.Run;

end.
