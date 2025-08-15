unit desafio.model.dto.interfaces;

interface

type

  iCliente_dto = interface
  ['{F32F96E5-1581-4A94-AC64-9342C8EE13A0}']
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

  iLstCliente_dto = interface
  ['{5FA42606-A80D-4A83-9742-F428834C37AC}']
    function getItens: TArray<iCliente_dto>;
    procedure setItens(const pValue: TArray<iCliente_dto>);
    procedure AddItem(const pValue: iCliente_dto);

    property Itens : TArray<iCliente_dto> read getItens write setItens;
  end;

  iProduto_dto = interface
  ['{0F670EA5-1885-4E74-B0C4-A0262731DF4C}']
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

  iLstProduto_dto = interface
  ['{B2732D56-83D2-4B3D-B202-5590C1984282}']
  {privado}
    function getItens: TArray<iProduto_dto>;
    procedure setItens(const pValue: TArray<iProduto_dto>);
    procedure AddItem(const pValue: iProduto_dto);

    property Itens: TArray<iProduto_dto> read getItens write setItens;
  {publico}
  end;

  iPedido_dto = interface
  ['{8F182881-EAAD-4FA4-A190-9A98F4C7EABC}']
  {privado}
    function getNumeroPedido: Integer;
    procedure setNumeroPedido(const pValue: Integer);

    function getDataEmissao: TDateTime;
    procedure setdataEmissao(const pValue: TDateTime);

    function getCodigoCliente: Integer;
    procedure setCodigoCliente(const pValue: Integer);

    function getValorTotal: Currency;
    procedure setValorTotal(const pValue: Currency);
  {publico}
    property numeroPedido  : Integer   read getNumeroPedido  write setNumeroPedido;
    property dataEmissao   : TDateTime read getDataEmissao   write setDataEmissao;
    property codigoCliente : Integer   read getCodigoCliente write setCodigoCliente;
    property valorTotal    : Currency  read getValorTotal    write setValorTotal;
  end;

  iLstPedido_dto = interface
  ['{A6FC406E-7723-4ABA-B7AC-C4A95BB222A2}']
    function getItens: TArray<iPedido_dto>;
    procedure setItens(const pValue: TArray<iPedido_dto>);
    procedure AddItem(const pValue: iPedido_dto);

    property  Itens: TArray<iPedido_dto> read getItens write setItens;
  end;

  iPedidoItem_dto = interface
  ['{C0092084-2DAF-46B0-A430-EF76E188A648}']
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

    function getDescProduto : String;
    procedure setDescProduto(const pValue: String);

  {publico}
    property id            : Integer  read getId             write setId;
    property numeroPedido  : Integer  read getNumeroPedido   write setNumeroPedido;
    property codigoProduto : Integer  read getCodigoProduto  write setCodigoProduto;
    property DescProduto   : String   read getDescProduto    write setDescProduto;
    property quantidade    : Integer  read getQuantidade     write setQuantidade;
    property valorUnitario : Currency read getvalorUnitario  write setValorUnitario;
    property valorTotal    : Currency read getValorTotal     write setValorTotal;
  end;

  iLstPedidoItens_dto = interface
  ['{AAABF538-65FB-4CAA-ABBD-B08141280441}']
    function getItens: TArray<iPedidoItem_dto>;
    procedure setItens(const pValue: TArray<iPedidoItem_dto>);
    procedure AddItem(const pValue: iPedidoItem_dto);

    property  Itens: TArray<iPedidoItem_dto> read getItens write setItens;
  end;

implementation

end.
