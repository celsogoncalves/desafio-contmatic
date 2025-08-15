unit desafio.model.entity;

interface

uses
  desafio.model.entity.interfaces;

type

  TEntity_Cliente = class(TInterfacedObject, iEntity_Cliente)
  strict private
    Fcodigo : Integer;
    Fnome   : String;
    Fcidade : String;
    Fuf     : String;
  private
    {$Region '햞ea de Gets e Sets'}
    function getCodigo: Integer;
    procedure setCodigo(const pValue: Integer);

    function getNome: String;
    procedure setNome(const pValue: String);

    function getCidade: String;
    procedure setCidade(const pValue: String);

    function getUF: String;
    procedure setUF(const pValue: String);
    {$Endregion}
  public
    class function New: iEntity_Cliente;
  end;

  TEntity_LstCliente = class(TInterfacedObject, iEntity_LstCliente)
  constructor Create;
  strict private
    FItens : TArray<iEntity_Cliente>;
  private
    function getItens: TArray<iEntity_Cliente>;
    procedure setItens(const pValue: TArray<iEntity_Cliente>);
    procedure AddItem(const pValue: iEntity_Cliente);
  public
    class function New: iEntity_LstCliente;
  end;

  TEntity_Produto = class(TInterfacedObject, iEntity_Produto)
  strict private
    Fcodigo     : integer;
    Fdescricao  : String;
    FprecoVenda : Currency;
  private
    {$Region '햞ea de Gets e Sets'}
    function  getCodigo: integer;
    function  getDescricao: String;
    function  getPrecoVenda: Currency;
    procedure setCodigo(const Value: integer);
    procedure setDescricao(const Value: String);
    procedure setPrecoVenda(const Value: Currency);
    {$Endregion}
  public
    class function New: iEntity_Produto;
  end;

  TEntity_LstProduto = class(TInterfacedObject, iEntity_LstProduto)
  constructor Create;
  strict private
    FItens : TArray<iEntity_Produto>;
  private
    function getItens: TArray<iEntity_Produto>;
    procedure setItens(const pValue: TArray<iEntity_Produto>);
    procedure AddItem(const pValue: iEntity_Produto);
  public
    class function New: iEntity_LstProduto;
  end;

  TEntity_Pedido = class(TInterfacedObject, iEntity_Pedido)
  strict private
    FnumeroPedido  : Integer;
    FdataEmissao   : TDateTime;
    FcodigoCliente : Integer;
    FvalorTotal    : Currency;
    FItens         : iEntity_LstPedidoItens;
  private
    constructor Create;

    {$Region '햞ea de Gets e Sets'}
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
    {$Endregion}
  public
    class function New: iEntity_Pedido;
  end;

  TEntity_LstPedido = class(TInterfacedObject, iEntity_LstPedido)
  strict private
    FItens : TArray<iEntity_Pedido>;
  private
    constructor Create;

    function getItens: TArray<iEntity_Pedido>;
    procedure setItens(const pValue: TArray<iEntity_Pedido>);
    procedure AddItem(const pValue: iEntity_Pedido);

  public
    class function New: iEntity_LstPedido;
  end;

  TEntity_PedidoItem = class(TInterfacedObject, iEntity_PedidoItem)
  strict private
    Fid            : Integer;
    FnumeroPedido  : Integer;
    FcodigoProduto : Integer;
    Fquantidade    : Integer;
    FvalorUnitario : Currency;
    FvalorTotal    : Currency;
  private
    {$Region '햞ea de Gets e Sets'}
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
    {$Endregion}
  public
    class function New: iEntity_PedidoItem;
  end;

  TEntity_LstPedidoItens = class(TInterfacedObject, iEntity_LstPedidoItens)
  strict private
    FItens : TArray<iEntity_PedidoItem>;
  private
    constructor Create;

    function getItens: TArray<iEntity_PedidoItem>;
    procedure setItens(const pValue: TArray<iEntity_PedidoItem>);
    procedure AddItem(const pValue: iEntity_PedidoItem);

    function getValorTotal: Currency;
  public
    class function New: iEntity_LstPedidoItens;
  end;



implementation

{ TCliente_dto }

function TEntity_Cliente.getCidade: String;
begin
  Result := Self.Fcidade;
end;

function TEntity_Cliente.getCodigo: Integer;
begin
  Result := Self.Fcodigo;
end;

function TEntity_Cliente.getNome: String;
begin
  Result := Self.Fnome;
end;

function TEntity_Cliente.getUF: String;
begin
  Result := Self.Fuf;
end;

class function TEntity_Cliente.New: iEntity_Cliente;
begin
  Result := Self.Create;
end;

procedure TEntity_Cliente.setCidade(const pValue: String);
begin
  Self.Fcidade := pValue;
end;

procedure TEntity_Cliente.setCodigo(const pValue: Integer);
begin
  Self.Fcodigo := pValue;
end;

procedure TEntity_Cliente.setNome(const pValue: String);
begin
  Self.Fnome := pValue;
end;

procedure TEntity_Cliente.setUF(const pValue: String);
begin
  Self.Fuf := pValue;
end;


{ TLstCliente_dto }

procedure TEntity_LstCliente.AddItem(const pValue: iEntity_Cliente);
begin
  SetLength( Self.FItens, High(Self.FItens)+2 );
  Self.FItens[ High(Self.FItens)] := pValue;
end;

constructor TEntity_LstCliente.Create;
begin
  inherited Create;

  SetLength(Self.FItens, 0);
end;

function TEntity_LstCliente.getItens: TArray<iEntity_Cliente>;
begin
  Result := Self.FItens;
end;

class function TEntity_LstCliente.New: iEntity_LstCliente;
begin
  Result := Self.Create;
end;

procedure TEntity_LstCliente.setItens(const pValue: TArray<iEntity_Cliente>);
begin
  Self.FItens := pValue;
end;

{ TProduto_dto }

function TEntity_Produto.getCodigo: integer;
begin
  Result := Self.Fcodigo;
end;

function TEntity_Produto.getDescricao: String;
begin
  Result := Self.Fdescricao;
end;

function TEntity_Produto.getPrecoVenda: Currency;
begin
  Result := Self.FPrecoVenda;
end;

class function TEntity_Produto.New: iEntity_Produto;
begin
  Result := Self.Create;
end;

procedure TEntity_Produto.setCodigo(const Value: integer);
begin
  Self.Fcodigo := Value;
end;

procedure TEntity_Produto.setDescricao(const Value: String);
begin
  Self.Fdescricao := Value;
end;

procedure TEntity_Produto.setPrecoVenda(const Value: Currency);
begin
  Self.FPrecoVenda := Value;
end;

{ TLstProduto_dto }

procedure TEntity_LstProduto.AddItem(const pValue: iEntity_Produto);
begin
  SetLength( Self.FItens, High(Self.FItens)+2 );
  Self.FItens[ High(Self.FItens)] := pValue;
end;

constructor TEntity_LstProduto.Create;
begin
  inherited Create;
  SetLength( Self.FItens, 0 );
end;

function TEntity_LstProduto.getItens: TArray<iEntity_Produto>;
begin
  Result := Self.FItens;
end;

class function TEntity_LstProduto.New: iEntity_LstProduto;
begin
  Result := Self.Create;
end;

procedure TEntity_LstProduto.setItens(const pValue: TArray<iEntity_Produto>);
begin
  Self.FItens := pValue;
end;


constructor TEntity_Pedido.Create;
begin
  inherited Create;

  Self.FItens := TEntity_LstPedidoItens.New;
end;

{ TPedido_cabecalho_dto }

function TEntity_Pedido.getCodigoCliente: Integer;
begin
  Result := Self.FCodigoCliente;
end;

function TEntity_Pedido.getDataEmissao: TDateTime;
begin
  Result := Self.FdataEmissao;
end;

function TEntity_Pedido.getItens: iEntity_LstPedidoItens;
begin
  Result := Self.FItens;
end;

function TEntity_Pedido.getNumeroPedido: Integer;
begin
  Result := Self.FNumeroPedido;
end;

function TEntity_Pedido.getValorTotal: Currency;
begin
  Result := Self.FvalorTotal;
end;

class function TEntity_Pedido.New: iEntity_Pedido;
begin
  Result := Self.Create;
end;

procedure TEntity_Pedido.setCodigoCliente(const pValue: Integer);
begin
  Self.FcodigoCliente := pValue;
end;

procedure TEntity_Pedido.setdataEmissao(const pValue: TDateTime);
begin
  Self.FdataEmissao := pValue;
end;

procedure TEntity_Pedido.setItens(const pValue: iEntity_LstPedidoItens);
begin
  Self.FItens := pValue;
end;

procedure TEntity_Pedido.setNumeroPedido(const pValue: Integer);
begin
  Self.FnumeroPedido := pValue;
end;

procedure TEntity_Pedido.setValorTotal(const pValue: Currency);
begin
  Self.FvalorTotal := pValue;
end;

{ TPedido_Item_dto }

function TEntity_PedidoItem.getCodigoProduto: Integer;
begin
  Result := Self.FcodigoProduto;
end;

function TEntity_PedidoItem.getId: Integer;
begin
  Result := Self.Fid;
end;

function TEntity_PedidoItem.getNumeroPedido: Integer;
begin
  Result := Self.FnumeroPedido;
end;

function TEntity_PedidoItem.getQuantidade: Integer;
begin
  Result := Self.Fquantidade;
end;

function TEntity_PedidoItem.getValorTotal: Currency;
begin
  Result := Self.FvalorTotal;
end;

function TEntity_PedidoItem.getValorUnitario: Currency;
begin
  Result := Self.FvalorUnitario;
end;

class function TEntity_PedidoItem.New: iEntity_PedidoItem;
begin
  Result := Self.Create;
end;

procedure TEntity_PedidoItem.setCodigoProduto(const pValue: Integer);
begin
  Self.FcodigoProduto := pValue;
end;

procedure TEntity_PedidoItem.setId(const pValue: Integer);
begin
  Self.Fid := pValue;
end;

procedure TEntity_PedidoItem.setNumeroPedido(const pValue: Integer);
begin
  Self.FnumeroPedido := pValue;
end;

procedure TEntity_PedidoItem.setQuantidade(const pValue: Integer);
begin
  Self.Fquantidade := pValue;
end;

procedure TEntity_PedidoItem.setValorTotal(const pValue: Currency);
begin
  Self.FvalorTotal := pValue;
end;

procedure TEntity_PedidoItem.setValorUnitario(const pValue: Currency);
begin
  Self.FvalorUnitario := pValue;
end;

{ TLstPedido_Itens_dto }

procedure TEntity_LstPedidoItens.AddItem(const pValue: iEntity_PedidoItem);
begin
  SetLength( Self.FItens, High(Self.FItens)+2 );
  Self.FItens[ High(Self.FItens)] := pValue;
end;

constructor TEntity_LstPedidoItens.Create;
begin
  inherited Create;
  SetLength( Self.FItens, 0 );
end;

function TEntity_LstPedidoItens.getItens: TArray<iEntity_PedidoItem>;
begin
  Result := Self.FItens;
end;

function TEntity_LstPedidoItens.getValorTotal: Currency;
begin
  Result := 0;
  for var lItem in Self.FItens  do
    Result := Result + (lItem.quantidade * lItem.valorUnitario);
end;

class function TEntity_LstPedidoItens.New: iEntity_LstPedidoItens;
begin
  Result := Self.Create;
end;

procedure TEntity_LstPedidoItens.setItens(const pValue: TArray<iEntity_PedidoItem>);
begin
  Self.FItens := pValue;
end;

{ TEntity_LstPedido }

procedure TEntity_LstPedido.AddItem(const pValue: iEntity_Pedido);
begin
  SetLength( Self.FItens, High(Self.FItens)+2 );
  Self.FItens[ High(Self.FItens)] := pValue;
end;

constructor TEntity_LstPedido.Create;
begin
  inherited Create;
  SetLength( Self.FItens, 0 );
end;

function TEntity_LstPedido.getItens: TArray<iEntity_Pedido>;
begin
  Result := Self.FItens;
end;

class function TEntity_LstPedido.New: iEntity_LstPedido;
begin
  Result := Self.Create;
end;

procedure TEntity_LstPedido.setItens(const pValue: TArray<iEntity_Pedido>);
begin
  Self.FItens := pValue;
end;

end.
