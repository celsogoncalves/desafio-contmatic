unit desafio.controller.pedido;

interface

uses
  SysUtils,
  desafio.controller.interfaces,
  desafio.model.connection.interfaces,
  desafio.model.entity.interfaces,
  desafio.model.dto.interfaces,
  desafio.model.dao.interfaces;

type

  TControllerPedido = class(TinterfacedObject, iControllerPedido)
   strict private
     FPedidoDao : iPedidoDao;
     FQuery     : iQuery;
   private
     constructor Create( const pConexao: iConexao );
   public
     function Retorna(const pCodigo: Integer): iPedido_dto;
     function Listar(const pCodPessoa: Integer = 0): iLstPedido_dto;
     function RetornarItemPorCodigo(const pCodigo: Integer): iPedidoItem_dto;
     function RetornarItens(const pCodigo: Integer): iLstPedidoItens_dto;
     function RetornarItensCompletos(const pCodigo: Integer): iLstPedidoItens_dto;
     procedure Cancelar(const pCodigo: Integer);
     procedure EditarItem(const pItem: iEntity_PedidoItem);
     procedure Salvar(const pPedido: iEntity_Pedido);
     function CalcularTotal(const pLista: iEntity_LstPedidoItens): Currency;

     class function New( const pConexao: iConexao ): iControllerPedido;
   end;

implementation

{ TControllerPedido }

uses desafio.model.dao.pedido, desafio.model.adapter,
  desafio.model.connection.FireDac.Query;

function TControllerPedido.CalcularTotal(
  const pLista: iEntity_LstPedidoItens): Currency;
begin
  Result := pLista.getValorTotal;
end;

procedure TControllerPedido.Cancelar(const pCodigo: Integer);
begin
  try
    FQuery.StartTransaction;

    FPedidoDao.CancelarItens( pCodigo );
    FPedidoDao.Cancelar( pCodigo );

    FQuery.Commit;
  except
    On E:Exception do
    begin
      FQuery.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

constructor TControllerPedido.Create(const pConexao: iConexao);
begin
  inherited Create;

  Self.FQuery     := TMyFDQuery.New( pConexao );
  Self.FPedidoDao := TPedidoDao.New( Self.FQuery );
end;

procedure TControllerPedido.EditarItem(const pItem: iEntity_PedidoItem);
begin
  if (pItem.quantidade > 0) then
  begin
    pItem.valorTotal := pItem.quantidade * pitem.valorUnitario;
    FPedidoDao.EditarItem( TAdapterPedido.EntityItemToDtoItem( pItem ) )
  end
  else
    raise Exception.Create('A quantidade do item é inválida');
end;

function TControllerPedido.Listar(const pCodPessoa: Integer = 0): iLstPedido_dto;
begin
  Result := TAdapterPedido.LstEntityToLstDto( FPedidoDao.Listar( pCodPessoa ) );
end;

class function TControllerPedido.New(
  const pConexao: iConexao): iControllerPedido;
begin
  Result := Self.Create( pConexao );
end;

function TControllerPedido.Retorna(const pCodigo: Integer): iPedido_dto;
begin
  Result := TAdapterPedido.EntityToDto( FPedidoDao.RetornarPorCodigo( pCodigo ) );
end;

function TControllerPedido.RetornarItemPorCodigo(
  const pCodigo: Integer): iPedidoItem_dto;
begin
  Result := TAdapterPedido.ItemEntityToItemDto( FPedidoDao.RetornarItemPorCodigo( pCodigo ) );
  if (Result.id<=0) then
    raise Exception.Create('Item não encontrado no pedido');
end;

function TControllerPedido.RetornarItens(
  const pCodigo: Integer): iLstPedidoItens_dto;
begin
  Result := TAdapterPedido.LstItensEntityToLstItensDto( FPedidoDao.RetornarItens( pCodigo ) );
end;

function TControllerPedido.RetornarItensCompletos(
  const pCodigo: Integer): iLstPedidoItens_dto;
begin
  Result := FPedidoDao.RetornarItensCompleto( pCodigo ) ;
end;

procedure TControllerPedido.Salvar(const pPedido: iEntity_Pedido);
var
  lId : Integer;
begin
  try
    FQuery.StartTransaction;
    lId := FPedidoDao.Salvar( TAdapterPedido.EntityToDto( pPedido ) );

    for var lItem in pPedido.Itens.Itens do
    begin
      lItem.numeroPedido := lId;
      FPedidoDao.SalvarItem( TAdapterPedido.EntityItemToDtoItem( lItem ) );
    end;

    FQuery.Commit;
  except
    on E:Exception do
    begin
      FQuery.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
