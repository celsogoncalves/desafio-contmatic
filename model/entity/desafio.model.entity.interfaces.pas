unit desafio.model.entity.interfaces;

interface

type

  iEntity_Cliente = interface
  ['{323011BA-08E4-4EE2-90FE-EDFA807B4D26}']
    function getCodigo: Integer;
    procedure setCodigo(const pValue: Integer);

    function getNome: String;
    procedure setNome(const pValue: String);

    function getCidade: String;
    procedure setCidade(const pValue: String);

    function getUF : String;
    procedure setUF(const pValue: String);

    property codigo : Integer read getCodigo write setCodigo;
    property nome   : String  read getNome   write setNome;
    property cidade : String  read getCidade write setCidade;
    property uf     : String  read getUF     write setUF;
  end;

  iEntity_LstCliente = interface
  ['{AACA6C70-E5F2-4432-9FB3-48B727BF785C}']
    function getItens: TArray<iEntity_Cliente>;
    procedure setItens(const pValue: TArray<iEntity_Cliente>);
    procedure AddItem(const pValue: iEntity_Cliente);

    property Itens : TArray<iEntity_Cliente> read getItens write setItens;
  end;

  iEntity_Produto = interface
  ['{EFBD4745-F2EF-48E1-9319-3192531E9A16}']
  {privado}
    function getCodigo: integer;
    function getDescricao: String;
    function getPrecoVenda: Currency;
    procedure setCodigo(const Value: integer);
    procedure setDescricao(const Value: String);
    procedure setPrecoVenda(const Value: Currency);
  {publico}
    property codigo     : integer  read getCodigo     write setCodigo;
    property descricao  : String   read getDescricao  write setDescricao;
    property precoVenda : Currency read getPrecoVenda write setPrecoVenda;
  end;

  iEntity_LstProduto = interface
  ['{632C4B13-CEAA-487D-823B-D7610CD2AADB}']
  {privado}
    function getItens: TArray<iEntity_Produto>;
    procedure setItens(const pValue: TArray<iEntity_Produto>);
    procedure AddItem(const pValue: iEntity_Produto);

    property Itens : TArray<iEntity_Produto> read getItens write setItens;
  {publico}
  end;

  iEntity_PedidoItem = interface
  ['{283AA1A5-E6F7-4249-AE55-F9A07A9DC446}']
  {privado}
    function getId : Integer;
    procedure setId(const pValue: Integer);

    function getNumeroPedido : Integer;
    procedure setNumeroPedido(const pValue: Integer);

    function getCodigoProduto : Integer;
    procedure setCodigoProduto(const pValue: Integer);

    function getQuantidade : Integer;
    procedure setQuantidade(const pValue: Integer);

    function getValorUnitario : Currency;
    procedure setValorUnitario(const pValue: Currency);

    function getValorTotal : Currency;
    procedure setValorTotal(const pValue: Currency);
  {publico}
    property id            : Integer  read getId             write setId;
    property numeroPedido  : Integer  read getNumeroPedido   write setNumeroPedido;
    property codigoProduto : Integer  read getCodigoProduto  write setCodigoProduto;
    property quantidade    : Integer  read getQuantidade     write setQuantidade;
    property valorUnitario : Currency read getvalorUnitario  write setValorUnitario;
    property valorTotal    : Currency read getValorTotal     write setValorTotal;
  end;

  iEntity_LstPedidoItens = interface
  ['{B3C6C033-328F-48FD-9BD3-28BFCA8A1D64}']
    function getItens: TArray<iEntity_PedidoItem>;
    procedure setItens(const pValue: TArray<iEntity_PedidoItem>);
    procedure AddItem(const pValue: iEntity_PedidoItem);

    function getValorTotal: Currency;

    property  Itens: TArray<iEntity_PedidoItem> read getItens write setItens;
  end;

  iEntity_Pedido = interface
  ['{9F4AE885-2013-430C-8898-9D1D03A12608}']
  {privado}
    function getNumeroPedido: Integer;
    procedure setNumeroPedido(const pValue: Integer);

    function getDataEmissao: TDateTime;
    procedure setdataEmissao(const pValue: TDateTime);

    function getCodigoCliente: Integer;
    procedure setCodigoCliente(const pValue: Integer);

    function getValorTotal: Currency;
    procedure setValorTotal(const pValue: Currency);

    function getItens: iEntity_LstPedidoItens;
    procedure setItens (const pValue : iEntity_LstPedidoItens);
  {publico}
    property numeroPedido  : Integer                read getNumeroPedido  write setNumeroPedido;
    property dataEmissao   : TDateTime              read getDataEmissao   write setDataEmissao;
    property codigoCliente : Integer                read getCodigoCliente write setCodigoCliente;
    property valorTotal    : Currency               read getValorTotal    write setValorTotal;
    property Itens         : iEntity_LstPedidoItens read getItens         write setItens;
  end;

  iEntity_LstPedido = interface
  ['{E244B46D-9912-439D-B6EA-576A7B9E0F60}']
    function getItens: TArray<iEntity_Pedido>;
    procedure setItens(const pValue: TArray<iEntity_Pedido>);
    procedure AddItem(const pValue: iEntity_Pedido);

    property  Itens: TArray<iEntity_Pedido> read getItens write setItens;
  end;



implementation

end.
