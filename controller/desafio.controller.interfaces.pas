unit desafio.controller.interfaces;

interface

uses
  desafio.model.entity.interfaces,
  desafio.model.dto.interfaces;
  // Precisa ficar o DTO

type

  iControllerProduto = interface
  ['{C2D30715-1C35-4609-913F-8F45117D0D3C}']
    function Retorna(const pCodigo: Integer): iProduto_dto;
    function Listar: iLstProduto_dto;
  end;

  iControllerCliente = interface
  ['{625E42A3-1155-4999-8207-B2FA8EBD3EA8}']
    function Retorna(const pCodigo: Integer): iCliente_dto;
    function Listar: iLstCliente_dto;
  end;

  iControllerPedido = interface
  ['{B7A6AE90-DD00-4FD9-8CB6-37D855A4DC09}']

    function Retorna(const pCodigo: Integer): iPedido_dto;
    function Listar(const pCodPessoa: Integer = 0): iLstPedido_dto;

    function RetornarItemPorCodigo(const pCodigo: Integer): iPedidoItem_dto;
    function RetornarItens(const pCodigo: Integer): iLstPedidoItens_dto;
    function RetornarItensCompletos(const pCodigo: Integer): iLstPedidoItens_dto;
    procedure Cancelar(const pCodigo: Integer);
    procedure EditarItem(const pItem: iEntity_PedidoItem);
    procedure Salvar(const pPedido: iEntity_Pedido);

    function CalcularTotal(const pLista: iEntity_LstPedidoItens): Currency;
  end;

implementation

end.
