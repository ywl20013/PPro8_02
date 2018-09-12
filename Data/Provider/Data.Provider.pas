unit Data.Provider;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.DApt,
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
  FireDAC.Comp.Client;

type
  TDataProvider = class( TDataModule )
    Connection: TFDConnection;
  private
    function GetActive: Boolean;
    procedure SetActive( const Value: Boolean );
  public
    function DataExists( ASql: string ): Boolean;
    function ExecuteSql( ASql: string ): Boolean; overload;
    function ExecuteSql( ASql: string; const AParams: array of Variant ): Boolean; overload;

    function TableExists( TableName: string ): Boolean; virtual;
  published
    property Active: Boolean read GetActive write SetActive;
  end;

var
  DataProvider: TDataProvider;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataProvider }

function TDataProvider.DataExists( ASql: string ): Boolean;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create( self );
  try
    query.Connection := self.Connection;
    query.Open( ASql );
    Result := query.RecordCount > 0;
    query.Free;
  except
    Result := false;
    query.Free;
  end;
end;

function TDataProvider.ExecuteSql( ASql: string ): Boolean;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create( self );
  try
    query.Connection := self.Connection;
    query.Sql.Text   := ASql;
    query.ExecSQL;
    Result := true;
    query.Free;
  except
    Result := false;
    query.Free;
  end;
end;

function TDataProvider.ExecuteSql( ASql: string; const AParams: array of Variant ): Boolean;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create( self );
  try
    query.Connection := self.Connection;
    query.ExecSQL( ASql, AParams );
    Result := true;
    query.Free;
  except
    Result := false;
    query.Free;
  end;
end;

function TDataProvider.GetActive: Boolean;
begin
  Result := Connection.Connected;
end;

procedure TDataProvider.SetActive( const Value: Boolean );
begin
  Connection.Connected := Value;
end;

function TDataProvider.TableExists( TableName: string ): Boolean;
begin
  raise Exception.Create( 'TableExists �ڲ�����û��ʵ��' );
end;

end.
