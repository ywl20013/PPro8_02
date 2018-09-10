unit Data.Provider.Sqlite;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.Provider,
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
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite,
  Data.DB,
  FireDAC.Comp.Client;

type
  TdmDataProviderSqlite = class( TDataProvider )
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
  private
    { Private declarations }
  public
    constructor Create( AOwner: TComponent ); override;

    function TableExists( TableName: string ): Boolean; override;

  end;

var
  dmDataProviderSqlite: TdmDataProviderSqlite;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


constructor TdmDataProviderSqlite.Create( AOwner: TComponent );
begin
  inherited;
  Connection.DriverName      := 'SQLite';
  Connection.Params.Database := 'ppro8.db';
end;

function TdmDataProviderSqlite.TableExists( TableName: string ): Boolean;
begin
  Result := DataExists( Format( 'select 1 from sqlite_master where type = ''table'' ' +
    'and name = ''%s''', [ TableName ] ) );
end;

end.
