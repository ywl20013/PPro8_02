unit Data.Provider.Sqlite;

interface

uses
  System.SysUtils,
  System.Classes,
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
  TdmDataProviderSqlite = class( TDataModule )
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDConnection1: TFDConnection;
    procedure DataModuleCreate( Sender: TObject );
  private
    function GetActive: Boolean;
    procedure SetActive( const Value: Boolean );
    { Private declarations }
  public
    function DataExists( ASql: string ): Boolean;
    function ExecuteSql( ASql: string ): Boolean;

    function TableExists( TableName: string ): Boolean;
  published
    property Active: Boolean read GetActive write SetActive;
  end;

var
  dmDataProviderSqlite: TdmDataProviderSqlite;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function TdmDataProviderSqlite.DataExists( ASql: string ): Boolean;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create( self );
  try
    query.Connection := self.FDConnection1;
    query.Open( ASql );
    Result := query.RecordCount > 0;
    query.Free;
  except
    Result := false;
    query.Free;
  end;
end;

procedure TdmDataProviderSqlite.DataModuleCreate( Sender: TObject );
begin
  FDConnection1.DriverName      := 'SQLite';
  FDConnection1.Params.Database := 'ppro8.db';
end;

function TdmDataProviderSqlite.ExecuteSql( ASql: string ): Boolean;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create( self );
  try
    query.Connection := self.FDConnection1;
    query.Sql.Text   := ASql;
    query.ExecSQL;
    Result := true;
    query.Free;
  except
    Result := false;
    query.Free;
  end;
end;

function TdmDataProviderSqlite.GetActive: Boolean;
begin
  Result := FDConnection1.Connected;
end;

procedure TdmDataProviderSqlite.SetActive( const Value: Boolean );
begin
  FDConnection1.Open( );
end;

function TdmDataProviderSqlite.TableExists( TableName: string ): Boolean;
begin
  // select * from sqlite_master where type = 'table' and name = 't_cmpt_cp'
  Result := DataExists( Format( 'select 1 from sqlite_master where type = ''table'' ' +
    'and name = ''%s''', [ TableName ] ) );
end;

end.
