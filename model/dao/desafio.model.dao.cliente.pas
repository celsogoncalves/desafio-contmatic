unit desafio.model.dao.cliente;

interface

uses
  System.SysUtils,
  desafio.model.dao.interfaces,
  desafio.model.connection.interfaces,
  desafio.model.Entity.interfaces;

type

  TClienteDao = class(TInterfacedObject, iClienteDao)
   strict private
     FConn  : iConexao;
     FQuery : iQuery;
   private
     constructor Create(const pConexao: iConexao);

     function _CriaCliente(const pCod: Integer; const pNome, pCidade, pUf: String): iEntity_Cliente;
   public
     function RetornarPorCodigo(const pCodigo: Integer): iEntity_Cliente;
     function Listar: iEntity_LstCliente;

     class function New(const pConexao: iConexao): iClienteDao;
   end;

implementation

uses
  desafio.model.Entity,
  desafio.model.connection.FireDac.Query;

{ TClienteDao }

constructor TClienteDao.Create(const pConexao: iConexao);
begin
  inherited Create;

  Self.FConn := pConexao;
  Self.FQuery := TMyFDQuery.New( pConexao );
end;

function TClienteDao.Listar: iEntity_LstCliente;
begin
  Result := TEntity_LstCliente.New;
  with Self.FQuery.Open( 'SELECT CODIGO, NOME, CIDADE, UF FROM CLIENTE', [] ) do
  while not Eof do
  begin
    Result.AddItem( _CriaCliente(
      FieldByName('CODIGO').AsInteger,
      FieldByName('NOME').AsString,
      FieldByName('CIDADE').AsString,
      FieldByName('UF').AsString
      )
    );
    Next;
  end;
end;

class function TClienteDao.New(const pConexao: iConexao): iClienteDao;
begin
  Result := Self.Create( pConexao );
end;

function TClienteDao.RetornarPorCodigo(const pCodigo: Integer): iEntity_Cliente;
begin
  Result := TEntity_Cliente.New;
  with Self.FQuery.Open( Format('SELECT CODIGO, NOME, CIDADE, UF FROM CLIENTE WHERE CODIGO = %d', [pCodigo]), [] ) do
  if not IsEmpty then
  begin
    Result.codigo := FieldByName('CODIGO').AsInteger;
    Result.nome   := FieldByName('NOME').AsString;
    Result.cidade := FieldByName('CIDADE').AsString;
    Result.uf     := FieldByName('UF').AsString;
  end;
end;

function TClienteDao._CriaCliente(const pCod: Integer; const pNome, pCidade,
  pUf: String): iEntity_Cliente;
begin
  Result        := TEntity_Cliente.New;
  Result.codigo := pCod;
  Result.nome   := pNome;
  Result.cidade := pCidade;
  Result.uf     := pUF;
end;

end.
