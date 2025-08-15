unit desafio.model.dao.produto;

interface

uses
  System.SysUtils,
  desafio.model.dao.interfaces,
  desafio.model.connection.interfaces,
  desafio.model.Entity.interfaces;

type

   TProdutoDao = class(TInterfacedObject, iProdutoDao)
   strict private
     FConn  : iConexao;
     FQuery : iQuery;
   private
     constructor Create(const pConexao: iConexao);

     function _CriaProd(const pCod: Integer; const pDesc: String; const pPreco: Currency): iEntity_Produto;
   public
     function RetornarPorCodigo(const pCodigo: Integer): iEntity_Produto;
     function Listar: iEntity_LstProduto;

     class function New(const pConexao: iConexao): iProdutoDao;
   end;

implementation

{ TProdutoDao }

uses
  desafio.model.Entity,
  desafio.model.connection.FireDac.Query;

constructor TProdutoDao.Create(const pConexao: iConexao);
begin
  inherited Create;

  Self.FConn := pConexao;
  Self.FQuery := TMyFDQuery.New( pConexao );
end;

function TProdutoDao.Listar: iEntity_LstProduto;
begin
  Result := TEntity_LstProduto.New;
  with Self.FQuery.Open( 'SELECT CODIGO, DESCRICAO, PRECO_VENDA FROM PRODUTO', [] ) do
  while not Eof do
  begin
    Result.AddItem( _CriaProd(
      FieldByName('CODIGO').AsInteger,
      FieldByName('DESCRICAO').AsString,
      FieldByName('PRECO_VENDA').AsCurrency
      )
    );
    Next;
  end;
end;

class function TProdutoDao.New(const pConexao: iConexao): iProdutoDao;
begin
  Result := Self.Create( pConexao );
end;

function TProdutoDao.RetornarPorCodigo(const pCodigo: Integer): iEntity_Produto;
begin
  Result := TEntity_Produto.New;
  with Self.FQuery.Open( Format('SELECT CODIGO, DESCRICAO, PRECO_VENDA FROM PRODUTO WHERE CODIGO = %d', [pCodigo]), [] ) do
  if not IsEmpty then
  begin
    Result.codigo     := FieldByName('CODIGO').AsInteger;
    Result.descricao  := FieldByName('DESCRICAO').AsString;
    Result.precoVenda := FieldByName('PRECO_VENDA').AsCurrency;
  end;
end;

function TProdutoDao._CriaProd(const pCod: Integer; const pDesc: String;
  const pPreco: Currency): iEntity_Produto;
begin
  Result := TEntity_Produto.New;
  Result.codigo     := pCod;
  Result.descricao  := pDesc;
  Result.precoVenda := pPreco;
end;

end.
