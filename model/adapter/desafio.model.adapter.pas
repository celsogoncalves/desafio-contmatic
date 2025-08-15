unit desafio.model.adapter;

interface

uses desafio.model.dto.interfaces, desafio.model.entity.interfaces;

type

  TAdapterProduto = class
  public
    class function EntityToDto(const pEntity: iEntity_Produto): iProduto_dto;
    class function LstEntityToLstDto(const pEntity: iEntity_LstProduto): iLstProduto_dto;
  end;


  TAdapterCliente = class
  public
    class function EntityToDto(const pEntity: iEntity_Cliente): iCliente_dto;
    class function LstEntityToLstDto(const pEntity: iEntity_LstCliente): iLstCliente_dto;
  end;

  TAdapterPedido = class
  public
    class function DtoToEntity(const pDto: iPedido_dto): iEntity_Pedido;
    class function ItemEntityToItemDto(const pEntity: iEntity_PedidoItem ): iPedidoItem_dto;
    class function LstEntityToLstDto(const pEntity: iEntity_LstPedido): iLstPedido_dto;
    class function LstItensEntityToLstItensDto(const pEntity: iEntity_LstPedidoItens):iLstPedidoItens_dto ;

    class function EntityToDto(const pEntity: iEntity_Pedido): iPedido_dto;
    class function EntityItemToDtoItem(const pEntity: iEntity_PedidoItem): iPedidoItem_dto;
  end;

implementation

{ TAdapterProduto }

uses desafio.model.entity, desafio.model.dto;

class function TAdapterProduto.EntityToDto(const pEntity: iEntity_Produto): iProduto_dto;
begin
  Result            := TProduto_dto.New;
  Result.codigo     := pEntity.codigo;
  Result.descricao  := pEntity.descricao;
  Result.precoVenda := pEntity.precoVenda;
end;

class function TAdapterProduto.LstEntityToLstDto( const pEntity: iEntity_LstProduto): iLstProduto_dto;
begin
  Result := TLstProduto_dto.New;
  for var lItem in pEntity.Itens do
    Result.AddItem( EntityToDto( lItem ) );
end;

{ TAdapterCliente }

class function TAdapterCliente.EntityToDto(
  const pEntity: iEntity_Cliente): iCliente_dto;
begin
  Result        := TCliente_dto.New;
  Result.codigo := pEntity.codigo;
  Result.nome   := pEntity.nome;
  Result.cidade := pEntity.cidade;
  Result.uf     := pEntity.uf;
end;

class function TAdapterCliente.LstEntityToLstDto(
  const pEntity: iEntity_LstCliente ): iLstCliente_dto ;
begin
  Result := TLstCliente_dto.New;
  for var lItem in pEntity.Itens do
    Result.AddItem( EntityToDto( lItem ) );
end;

{ TAdapterPedido }

class function TAdapterPedido.DtoToEntity(
  const pDto: iPedido_dto): iEntity_Pedido;
begin
  Result               := TEntity_Pedido.New;
  Result.numeroPedido  := pDto.numeroPedido;
  Result.dataEmissao   := pDto.dataEmissao;
  Result.codigoCliente := pDto.codigoCliente;
  Result.valorTotal    := pDto.valorTotal;
end;

class function TAdapterPedido.EntityItemToDtoItem(
  const pEntity: iEntity_PedidoItem): iPedidoItem_dto;
begin
  Result                := TPedidoItem_dto.New;
  Result.id             := pEntity.id;
  Result.numeroPedido   := pEntity.numeroPedido;
  Result.codigoProduto  := pEntity.codigoProduto;
  Result.quantidade     := pEntity.quantidade;
  Result.valorUnitario  := pEntity.valorUnitario;
  Result.valorTotal     := pEntity.quantidade*pEntity.valorUnitario;
end;

class function TAdapterPedido.EntityToDto(
  const pEntity: iEntity_Pedido): iPedido_dto;
begin
  Result := TPedido_dto.New;
  Result.numeroPedido  := pEntity.numeroPedido;
  Result.dataEmissao   := pEntity.dataEmissao;
  Result.codigoCliente := pEntity.codigoCliente;
  Result.valorTotal    := pEntity.Itens.getValorTotal;
end;

class function TAdapterPedido.ItemEntityToItemDto(
  const pEntity: iEntity_PedidoItem ): iPedidoItem_dto ;
begin
  Result := TPedidoItem_dto.New;
  Result.id := pEntity.id;
  Result.numeroPedido  := pEntity.numeroPedido;
  Result.codigoProduto := pEntity.codigoProduto;
  Result.quantidade    := pEntity.quantidade;
  Result.valorUnitario := pEntity.valorUnitario;
  Result.valorTotal    := pEntity.valorTotal;
end;

class function TAdapterPedido.LstEntityToLstDto(
  const pEntity: iEntity_LstPedido): iLstPedido_dto;
begin
  Result := TLstPedido_dto.New;
  for var lItem in pEntity.Itens do
    Result.AddItem( EntityToDto( lItem ) );
end;

class function TAdapterPedido.LstItensEntityToLstItensDto(
  const pEntity: iEntity_LstPedidoItens): iLstPedidoItens_dto;
begin
  Result := TLstPedidoItens_dto.New;
  for var lItem in pEntity.Itens do
    Result.AddItem( ItemEntityToItemDto( lItem ) );
end;

end.
