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
    property Active: Boolean read GetActive write SetActive;
  end;

var
  dmDataProviderSqlite: TdmDataProviderSqlite;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TdmDataProviderSqlite.DataModuleCreate( Sender: TObject );
begin
  FDConnection1.DriverName      := 'SQLite';
  FDConnection1.Params.Database := 'ppro8.db';
end;

function TdmDataProviderSqlite.GetActive: Boolean;
begin
  Result := FDConnection1.Connected;
end;

procedure TdmDataProviderSqlite.SetActive( const Value: Boolean );
begin
  FDConnection1.Connected := Value;
end;

end.
