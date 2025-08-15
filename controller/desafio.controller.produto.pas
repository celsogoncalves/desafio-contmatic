unit desafio.controller.produto;

interface

uses
  SysUtils,
  desafio.controller.interfaces,
  desafio.model.connection.interfaces,
  desafio.model.dto.interfaces,
  desafio.model.dao.interfaces;

type

   TControllerProduto = class(TinterfacedObject, iControllerProduto)
   strict private
     FProdutoDao: iProdutoDao;
   private
     constructor Create( const pConexao: iConexao );
   public
     function Retorna(const pCodigo: Integer): iProduto_dto;
     function Listar: iLstProduto_dto;

     class function New( const pConexao: iConexao ): iControllerProduto;
   end;

implementation

{ TControllerProduto }

uses
  desafio.model.connection.FireDac.Query,
  desafio.model.entity,
  desafio.model.dao.produto, desafio.model.adapter;

constructor TControllerProduto.Create(const pConexao: iConexao);
begin
  inherited Create;

  Self.FProdutoDao := TProdutoDao.New( pConexao );
end;

function TControllerProduto.Listar: iLstProduto_dto;
begin
  Result := TAdapterProduto.LstEntityToLstDto( FProdutoDao.Listar );
end;

class function TControllerProduto.New(
  const pConexao: iConexao): iControllerProduto;
begin
  Result := Self.Create( pConexao );
end;

function TControllerProduto.Retorna(const pCodigo: Integer): iProduto_dto;
begin
  Result := TAdapterProduto.EntityToDto( FProdutoDao.RetornarPorCodigo( pCodigo ) );
end;

end.
