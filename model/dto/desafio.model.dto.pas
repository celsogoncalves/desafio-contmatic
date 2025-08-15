unit desafio.model.dto;

interface

uses
  desafio.model.dto.interfaces;

type

  TCliente_dto = class(TInterfacedObject, iCliente_dto)
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
    class function New: iCliente_dto;
  end;

  TLstCliente_dto = class(TInterfacedObject, iLstCliente_dto)
  strict private
    FItens : TArray<iCliente_dto>;
  private
    constructor Create;
    function getItens: TArray<iCliente_dto>;
    procedure setItens(const pValue: TArray<iCliente_dto>);
    procedure AddItem(const pValue: iCliente_dto);
  public
    class function New: iLstCliente_dto;
  end;

  TProduto_dto = class(TInterfacedObject, iProduto_dto)
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
    class function New: iProduto_dto;
  end;

  TLstProduto_dto = class(TInterfacedObject, iLstProduto_dto)
  strict private
    FItens : TArray<iProduto_dto>;
  private
    constructor Create;

    function getItens: TArray<iProduto_dto>;
    procedure setItens(const pValue: TArray<iProduto_dto>);
    procedure AddItem(const pValue: iProduto_dto);
  public
    class function New: iLstProduto_dto;
  end;

  TPedido_dto = class(TInterfacedObject, iPedido_dto)
  strict private
    FnumeroPedido  : Integer;
    FdataEmissao   : TDateTime;
    FcodigoCliente : Integer;
    FvalorTotal    : Currency;
  private
    {$Region '햞ea de Gets e Sets'}
    function getNumeroPedido: Integer;
    procedure setNumeroPedido(const pValue: Integer);

    function getDataEmissao: TDateTime;
    procedure setdataEmissao(const pValue: TDateTime);

    function getCodigoCliente: Integer;
    procedure setCodigoCliente(const pValue: Integer);

    function getValorTotal: Currency;
    procedure setValorTotal(const pValue: Currency);
    {$Endregion}
  public
    class function New: iPedido_dto;
  end;

  TLstPedido_dto = class(TInterfacedObject, iLstPedido_dto)
  strict private
    FItens : TArray<iPedido_dto>;
  private
    constructor Create;

    function getItens: TArray<iPedido_dto>;
    procedure setItens(const pValue: TArray<iPedido_dto>);
    procedure AddItem(const pValue: iPedido_dto);
  public
    class function New: iLstPedido_dto;
  end;

  TPedidoItem_dto = class(TInterfacedObject, iPedidoItem_dto)
  strict private
    Fid            : Integer;
    FnumeroPedido  : Integer;
    FcodigoProduto : Integer;
    Fquantidade    : Integer;
    FvalorUnitario : Currency;
    FvalorTotal    : Currency;
    FDescProduto   : String;
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

    function getDescProduto : String;
    procedure setDescProduto(const pValue: String);
    {$Endregion}
  public
    class function New: iPedidoItem_dto;
  end;

  TLstPedidoItens_dto = class(TInterfacedObject, iLstPedidoItens_dto)
  strict private
    FItens : TArray<iPedidoItem_dto>;

  private
    constructor Create;

    function getItens: TArray<iPedidoItem_dto>;
    procedure setItens(const pValue: TArray<iPedidoItem_dto>);
    procedure AddItem(const pValue: iPedidoItem_dto);

  public
    class function New: iLstPedidoItens_dto;
  end;


implementation

{ TCliente_dto }

function TCliente_dto.getCidade: String;
begin
  Result := Self.Fcidade;
end;

function TCliente_dto.getCodigo: Integer;
begin
  Result := Self.Fcodigo;
end;

function TCliente_dto.getNome: String;
begin
  Result := Self.Fnome;
end;

function TCliente_dto.getUF: String;
begin
  Result := Self.Fuf;
end;

class function TCliente_dto.New: iCliente_dto;
begin
  Result := Self.Create;
end;

procedure TCliente_dto.setCidade(const pValue: String);
begin
  Self.Fcidade := pValue;
end;

procedure TCliente_dto.setCodigo(const pValue: Integer);
begin
  Self.Fcodigo := pValue;
end;

procedure TCliente_dto.setNome(const pValue: String);
begin
  Self.Fnome := pValue;
end;

procedure TCliente_dto.setUF(const pValue: String);
begin
  Self.Fuf := pValue;
end;


{ TLstCliente_dto }

procedure TLstCliente_dto.AddItem(const pValue: iCliente_dto);
begin
  SetLength( Self.FItens, High(Self.FItens)+2 );
  Self.FItens[ High(Self.FItens)] := pValue;
end;

constructor TLstCliente_dto.Create;
begin
  inherited Create;

  SetLength(Self.FItens, 0);
end;

function TLstCliente_dto.getItens: TArray<iCliente_dto>;
begin
  Result := Self.FItens;
end;

class function TLstCliente_dto.New: iLstCliente_dto;
begin
  Result := Self.Create;
end;

procedure TLstCliente_dto.setItens(const pValue: TArray<iCliente_dto>);
begin
  Self.FItens := pValue;
end;

{ TProduto_dto }

function TProduto_dto.getCodigo: integer;
begin
  Result := Self.Fcodigo;
end;

function TProduto_dto.getDescricao: String;
begin
  Result := Self.Fdescricao;
end;

function TProduto_dto.getPrecoVenda: Currency;
begin
  Result := Self.FPrecoVenda;
end;

class function TProduto_dto.New: iProduto_dto;
begin
  Result := Self.Create;
end;

procedure TProduto_dto.setCodigo(const Value: integer);
begin
  Self.Fcodigo := Value;
end;

procedure TProduto_dto.setDescricao(const Value: String);
begin
  Self.Fdescricao := Value;
end;

procedure TProduto_dto.setPrecoVenda(const Value: Currency);
begin
  Self.FPrecoVenda := Value;
end;

{ TLstProduto_dto }

procedure TLstProduto_dto.AddItem(const pValue: iProduto_dto);
begin
  SetLength( Self.FItens, High(Self.FItens)+2 );
  Self.FItens[ High(Self.FItens)] := pValue;
end;

constructor TLstProduto_dto.Create;
begin
  inherited Create;
  SetLength( Self.FItens, 0 );
end;

function TLstProduto_dto.getItens: TArray<iProduto_dto>;
begin
  Result := Self.FItens;
end;

class function TLstProduto_dto.New: iLstProduto_dto;
begin
  Result := Self.Create;
end;

procedure TLstProduto_dto.setItens(const pValue: TArray<iProduto_dto>);
begin
  Self.FItens := pValue;
end;


{ TPedido_cabecalho_dto }

function TPedido_dto.getCodigoCliente: Integer;
begin
  Result := Self.FCodigoCliente;
end;

function TPedido_dto.getDataEmissao: TDateTime;
begin
  Result := Self.FdataEmissao;
end;

function TPedido_dto.getNumeroPedido: Integer;
begin
  Result := Self.FnumeroPedido;
end;

function TPedido_dto.getValorTotal: Currency;
begin
  Result := Self.FvalorTotal;
end;

class function TPedido_dto.New: iPedido_dto;
begin
  Result := Self.Create;
end;

procedure TPedido_dto.setCodigoCliente(const pValue: Integer);
begin
  Self.FcodigoCliente := pValue;
end;

procedure TPedido_dto.setdataEmissao(const pValue: TDateTime);
begin
  Self.FdataEmissao := pValue;
end;

procedure TPedido_dto.setNumeroPedido(const pValue: Integer);
begin
  Self.FnumeroPedido := pValue;
end;

procedure TPedido_dto.setValorTotal(const pValue: Currency);
begin
  Self.FvalorTotal := pValue;
end;

{ TPedido_Item_dto }

function TPedidoItem_dto.getCodigoProduto: Integer;
begin
  Result := Self.FcodigoProduto;
end;

function TPedidoItem_dto.getDescProduto: String;
begin
  Result := Self.FDescProduto;
end;

function TPedidoItem_dto.getId: Integer;
begin
  Result := Self.Fid;
end;

function TPedidoItem_dto.getNumeroPedido: Integer;
begin
  Result := Self.FnumeroPedido;
end;

function TPedidoItem_dto.getQuantidade: Integer;
begin
  Result := Self.Fquantidade;
end;

function TPedidoItem_dto.getValorTotal: Currency;
begin
  Result := Self.FvalorTotal;
end;

function TPedidoItem_dto.getValorUnitario: Currency;
begin
  Result := Self.FvalorUnitario;
end;

class function TPedidoItem_dto.New: iPedidoItem_dto;
begin
  Result := Self.Create;
end;

procedure TPedidoItem_dto.setCodigoProduto(const pValue: Integer);
begin
  Self.FcodigoProduto := pValue;
end;

procedure TPedidoItem_dto.setDescProduto(const pValue: String);
begin
  Self.FDescProduto := pValue;
end;

procedure TPedidoItem_dto.setId(const pValue: Integer);
begin
  Self.Fid := pValue;
end;

procedure TPedidoItem_dto.setNumeroPedido(const pValue: Integer);
begin
  Self.FnumeroPedido := pValue;
end;

procedure TPedidoItem_dto.setQuantidade(const pValue: Integer);
begin
  Self.Fquantidade := pValue;
end;

procedure TPedidoItem_dto.setValorTotal(const pValue: Currency);
begin
  Self.FvalorTotal := pValue;
end;

procedure TPedidoItem_dto.setValorUnitario(const pValue: Currency);
begin
  Self.FvalorUnitario := pValue;
end;

{ TLstPedido_Itens_dto }

procedure TLstPedidoItens_dto.AddItem(const pValue: iPedidoItem_dto);
begin
  SetLength( Self.FItens, High(Self.FItens)+2 );
  Self.FItens[ High(Self.FItens)] := pValue;
end;

constructor TLstPedidoItens_dto.Create;
begin
  inherited Create;
  SetLength( Self.FItens, 0 );
end;

function TLstPedidoItens_dto.getItens: TArray<iPedidoItem_dto>;
begin
  Result := Self.FItens;
end;

class function TLstPedidoItens_dto.New: iLstPedidoItens_dto;
begin
  Result := Self.Create;
end;

procedure TLstPedidoItens_dto.setItens(const pValue: TArray<iPedidoItem_dto>);
begin
  Self.FItens := pValue;
end;

{ TLstPedido_dto }

procedure TLstPedido_dto.AddItem(const pValue: iPedido_dto);
begin
  SetLength( Self.FItens, High(Self.FItens)+2 );
  Self.FItens[ High(Self.FItens)] := pValue;
end;

constructor TLstPedido_dto.Create;
begin
  inherited Create;
  SetLength( Self.FItens, 0 );
end;

function TLstPedido_dto.getItens: TArray<iPedido_dto>;
begin
  Result := Self.FItens;
end;

class function TLstPedido_dto.New: iLstPedido_dto;
begin
  Result := Self.Create;
end;

procedure TLstPedido_dto.setItens(const pValue: TArray<iPedido_dto>);
begin
  Self.FItens := pValue;
end;

end.
