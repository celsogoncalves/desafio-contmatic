unit desafio.model.connection.FireDac.Query;

interface

uses
  System.SysUtils, Data.DB,
  FireDAC.Comp.Client,
  desafio.model.connection.interfaces;

type

  TMyFDQuery = class(TInterfacedObject, iQuery)
  strict private
    FQuery : TFDQuery;

  private
    constructor Create(const pConn: iConexao);
    destructor Destroy; override;

    procedure _CarregarParams(const pValue: Array of Variant);
  public
    procedure Exec(const pStatement: String; const pParams: Array of Variant);
    function Open(const pStatement: String; const pParams: Array of Variant): TDataSet;

    procedure StartTransaction;
    procedure Rollback;
    procedure Commit;

    class function New(const pConn: iConexao): iQuery;
  end;

implementation


{ TMyFDQuery }

procedure TMyFDQuery.Commit;
begin
  FQuery.Connection.Commit;
end;

constructor TMyFDQuery.Create(const pConn: iConexao);
begin
  inherited Create;

  Self.FQuery := TFDQuery.Create(nil);
  Self.FQuery.Connection := TFDConnection( pConn.Conexao );
end;


destructor TMyFDQuery.Destroy;
begin
  FreeAndNil(FQuery);

  inherited;
end;

procedure TMyFDQuery.Exec(const pStatement: String;
  const pParams: array of Variant);
begin
  FQuery.Close;
  FQuery.SQL.Text := pStatement;
  _CarregarParams( pParams );

  FQuery.ExecSQL;
end;

class function TMyFDQuery.New(const pConn: iConexao): iQuery;
begin
  Result := Self.Create( pConn );
end;

function TMyFDQuery.Open(const pStatement: String;
  const pParams: array of Variant): TDataSet;
begin
  FQuery.Close;
  FQuery.SQL.Text := pStatement;
  _CarregarParams( pParams );

  FQuery.Open;
  Result := FQuery;
end;

procedure TMyFDQuery.Rollback;
begin
  FQuery.Connection.Rollback;
end;

procedure TMyFDQuery.StartTransaction;
begin
  FQuery.Connection.StartTransaction;
end;

procedure TMyFDQuery._CarregarParams(const pValue: array of Variant);
var
  lIdx: Integer;
begin
  for lIdx := Low(pValue) to High(pValue) do
  begin
    FQuery.Params.Add;
    FQuery.Params[ lIdx ].Value := pValue[ lIdx ];
  end;
end;


end.
