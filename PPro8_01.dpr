program PPro8_01;

uses
  Vcl.Forms,
  UI.Main in 'UI.Main.pas' {fmMain},
  Models.L2 in 'Models\Models.L2.pas',
  UI.Test in 'UI.Test.pas' {fmTest},
  Helper.TDateTime in 'Helper\Helper.TDateTime.pas',
  Net.UDP.Test in 'Net\UDP\Net.UDP.Test.pas' {dmProviderUDPTest: TDataModule},
  Net.UDP.Server in 'Net\UDP\Net.UDP.Server.pas' {dmProviderUDPServer: TDataModule},
  Data.Provider.Sqlite in 'Data\Provider\Sqlite\Data.Provider.Sqlite.pas' {dmDataProviderSqlite: TDataModule},
  Data.Provider.Sqlite.L2 in 'Data\Provider\Sqlite\Data.Provider.Sqlite.L2.pas' {dmDataProviderSqliteL2: TDataModule},
  Data.Provider in 'Data\Provider\Data.Provider.pas' {DataProvider: TDataModule};

{$R *.res}


begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  // Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTest, fmTest);
  Application.CreateForm(TDataProvider, DataProvider);
  Application.Run;

end.
