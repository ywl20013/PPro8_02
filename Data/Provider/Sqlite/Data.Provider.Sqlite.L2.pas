unit Data.Provider.Sqlite.L2;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.Provider.Sqlite,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.Sqlite;

type
  TdmDataProviderSqliteL2 = class( TdmDataProviderSqlite )
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDataProviderSqliteL2: TdmDataProviderSqliteL2;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
