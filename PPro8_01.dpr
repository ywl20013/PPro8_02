program PPro8_01;

uses
  Vcl.Forms,
  UI.Main in 'UI.Main.pas' {fmMain},
  Models.L2 in 'Models\Models.L2.pas',
  UI.Test in 'UI.Test.pas' {fmTest},
  Helper.TDateTime in 'Helper\Helper.TDateTime.pas',
  Data.Provider.UDP.Test in 'Data\Provider\Data.Provider.UDP.Test.pas' {dmProviderUDPTest: TDataModule},
  Data.Provider.UDP.Server in 'Data\Provider\Data.Provider.UDP.Server.pas' {dmProviderUDPServer: TDataModule},
  Data.Provider.Sqlite in 'Data\Provider\Sqlite\Data.Provider.Sqlite.pas' {dmDataProviderSqlite: TDataModule};

{$R *.res}


begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  // Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTest, fmTest);
  Application.CreateForm(TdmDataProviderSqlite, dmDataProviderSqlite);
  Application.Run;

end.
