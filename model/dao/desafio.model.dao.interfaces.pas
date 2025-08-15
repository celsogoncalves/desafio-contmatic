unit desafio.model.dao.interfaces;

interface

uses
  desafio.model.Entity.interfaces,
  desafio.model.Dto.interfaces;

type

  iProdutoDao = interface
  ['{E86541E5-4969-4B88-B68D-AE4E7B94E2EA}']
    function RetornarPorCodigo(const pCodigo: Integer): iEntity_Produto;
    function Listar: iEntity_LstProduto;
  end;

  iClienteDao = interface
  ['{5EA34750-B237-45B7-8B7A-4B07D6B145D8}']
    function RetornarPorCodigo(const pCodigo: Integer): iEntity_Cliente;
    function Listar: iEntity_LstCliente;
  end;

  iPedidoDao = interface
  ['{FE1B98C4-A21D-484B-9361-3DA162AE4B51}']
    function RetornarPorCodigo(const pCodigo: Integer): iEntity_Pedido;

    function Listar(const pCodPessoa: Integer): iEntity_LstPedido;
    function RetornarItens(const pCodigo: Integer): iEntity_LstPedidoItens;
    function RetornarItensCompleto(const pCodigo: Integer): iLstPedidoItens_dto;

    procedure Cancelar(const pCodigo: Integer);
    procedure CancelarItens(const pCodigo: Integer);

    procedure EditarItem(const pItem: iPedidoItem_dto);
    function  RetornarItemPorCodigo(const pCodigo: Integer): iEntity_PedidoItem;

    function Salvar(const pPedido: iPedido_dto): Integer;
    procedure SalvarItem(const pItem: iPedidoItem_dto);
  end;

implementation

end.
