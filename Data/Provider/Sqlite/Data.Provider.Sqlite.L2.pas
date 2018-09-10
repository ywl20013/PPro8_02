unit Data.Provider.Sqlite.L2;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.Provider.Sqlite,
  FireDAC.DApt,
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
  FireDAC.Phys.Sqlite,
  Models.L2;

type
  TdmDataProviderSqliteL2 = class( TdmDataProviderSqlite )
  private
    { Private declarations }
  public
    function CheckTables: Boolean;
    // function SaveL2Line( L2Line: TL2Line ): Boolean;
  end;

var
  dmDataProviderSqliteL2: TdmDataProviderSqliteL2;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmDataProviderSqliteL2 }

function TdmDataProviderSqliteL2.CheckTables: Boolean;
var
  asql: string;
begin
  if not TableExists( 'L2Lines' ) then
  begin
    asql :=
      'CREATE TABLE L2Lines(' +
      '   ID INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,' +
      '   NAME           TEXT         NOT NULL,' +
      '   LOCALTIME      DATETIME     NOT NULL default (datetime(''now'', ''localtime'')),' +
      '   MARKETTIME     DATETIME     NOT NULL,' +
      '   MMID           TEXT         NOT NULL,' +
      '   SIDE           TEXT         NOT NULL,' +
      '   PRICE          NUMERIC      NOT NULL,' +
      '   VOLUME         INTEGER      NOT NULL,' +
      '   DEPTH          INTEGER,' +
      '   SEQUENCENUMBER INTEGER' +
      ')';
    Result := self.ExecuteSql( asql );
  end;
end;

// function TdmDataProviderSqliteL2.SaveL2Line( L2Line: TL2Line ): Boolean;
// begin
// Result := self.ExecuteSql( 'insert into L2Lines(NAME,LOCALTIME,MARKETTIME,MMID,SIDE,PRICE,VOLUME,DEPTH,SEQUENCENUMBER)' +
// ' values(:NAME,:LOCALTIME,:MARKETTIME,:MMID,:SIDE,:PRICE,:VOLUME,:DEPTH,:SEQUENCENUMBER)', [
// L2Line.Symbol, L2Line.LocalTime, L2Line.MarketTime, L2Line.Mmid, L2Line.Side, L2Line.Price, L2Line.Volume, L2Line.Depth, L2Line.SequenceNumber
// ] );
// end;

end.
