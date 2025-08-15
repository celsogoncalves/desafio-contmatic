unit desafio.model.dao.pedido;

interface

uses
  System.SysUtils,
  desafio.model.dao.interfaces,
  desafio.model.connection.interfaces,
  desafio.model.dto.interfaces,
  desafio.model.Entity.interfaces;

type

  TPedidoDao = class(TInterfacedObject, iPedidoDao)
   strict private
     FConn  : iConexao;
     FQuery : iQuery;
   private
     constructor Create(const pQuery: iQuery);

     function _CriarPedidoItem(const pCod, pCodPedido, pCodProd, pQtd: Integer;
       pVlrUnit, pVlrTotal: Currency ; const pDesc: String ): iEntity_PedidoItem;
     function _CriaPedido(const pNumPedido, pCodCli: Integer;
       const pDtEmissao: TDateTime; const pValorTotal: Currency): iEntity_Pedido;

     function _FloatToDB(const pValue: Currency): String;
   public
     function RetornarPorCodigo(const pCodigo: Integer): iEntity_Pedido;

     function Listar(const pCodPessoa: Integer): iEntity_LstPedido;
     function RetornarItens(const pCodigo: Integer): iEntity_LstPedidoItens;
     function RetornarItensCompleto(const pCodigo: Integer): iLstPedidoItens_dto;

     function  RetornarItemPorCodigo(const pCodigo: Integer): iEntity_PedidoItem;

     procedure Cancelar(const pCodigo: Integer);
     procedure CancelarItens(const pCodigo: Integer);

     procedure EditarItem(const pItem: iPedidoItem_dto);

     function Salvar(const pPedido: iPedido_dto): Integer;
     procedure SalvarItem(const pItem: iPedidoItem_dto);

     class function New(const pQuery: iQuery): iPedidoDao;
   end;

implementation

{ TPedidoDao }

uses desafio.model.connection.FireDac.Query, desafio.model.Entity, desafio.model.dto;

procedure TPedidoDao.Cancelar(const pCodigo: Integer);
const
  CMD_SQL = 'DELETE FROM PEDIDO WHERE NUMERO_PEDIDO = %d ';
begin
  try
    Self.FQuery.Exec( Format( CMD_SQL, [ pCodigo ]), [] );
  except
    on E:Exception do
      raise Exception.Create('Erro ao Cancelar Pedido: '+ E.Message);
  end;
end;

procedure TPedidoDao.CancelarItens(const pCodigo: Integer);
const
  CMD_SQL = 'DELETE FROM PEDIDOITENS WHERE CODIGO_PEDIDO = %d ';
begin
  try
    Self.FQuery.Exec( Format( CMD_SQL, [ pCodigo ]), [] );
  except
    on E:Exception do
      raise Exception.Create('Erro ao Cancelar Itens do Pedido: '+ E.Message);
  end;
end;

constructor TPedidoDao.Create(const pQuery: iQuery);
begin
  inherited Create;

  Self.FQuery := pQuery;
end;

procedure TPedidoDao.EditarItem(const pItem: iPedidoItem_dto);
const
  CMD_SQL = 'UPDATE PEDIDOITENS SET QUANTIDADE = %d, VALOR_UNITARIO = %d, VALOR_TOTAL = %d WHERE CODIGO = %d ';
begin
  try
    Self.FQuery.Exec( Format( CMD_SQL, [ pItem.quantidade, pItem.valorUnitario, pItem.valorTotal ]), [] );
  except
    on E:Exception do
      raise Exception.Create('Erro ao Cancelar Pedido: '+ E.Message);
  end;
end;

function TPedidoDao.Listar(const pCodPessoa: Integer): iEntity_LstPedido;
const
  CMD_WHERE = 'WHERE CODIGO_CLIENTE=%d';
  CMD_SQL   = 'SELECT NUMERO_PEDIDO, CODIGO_CLIENTE, DATA_EMISSAO, VALORTOTAL FROM PEDIDO %s';
var
  lWhere : String;
begin
  Result := TEntity_LstPedido.New;

  lWhere := '';
  if (pCodPessoa>0) then
    lWhere := Format( CMD_WHERE, [pCodPessoa] );

  with Self.FQuery.Open( Format( CMD_SQL, [lWhere]), [] ) do
  while not Eof do
  begin
    Result.AddItem( _CriaPedido(
      FieldByName('NUMERO_PEDIDO').AsInteger,
      FieldByName('CODIGO_CLIENTE').AsInteger,
      FieldByName('DATA_EMISSAO').AsDateTime,
      FieldByName('VALORTOTAL').AsCurrency
      )
    );
    Next;
  end;
end;

class function TPedidoDao.New(const pQuery: iQuery): iPedidoDao;
begin
  Result := Self.Create( pQuery );
end;


function TPedidoDao.RetornarItemPorCodigo(
  const pCodigo: Integer): iEntity_PedidoItem;
const
  CMD_SQL = 'SELECT I.CODIGO, I.CODIGO_PEDIDO, I.CODIGO_PRODUTO, ' +
            'I.QUANTIDADE, I.VALOR_UNITARIO, I.VALOR_TOTAL, P.DESCRICAO '+
            'FROM PEDIDOITENS I '+
            'INNER JOIN PRODUTO P ON (I.CODIGO_PRODUTO=P.CODIGO) '+
            'WHERE I.CODIGO = %d';
begin
  Result := TEntity_PedidoItem.New;
  with Self.FQuery.Open( Format(CMD_SQL, [pCodigo]), [] ) do
  while not Eof do
  begin
    Result := _CriarPedidoItem(
      FieldByName('CODIGO').AsInteger,
      FieldByName('CODIGO_PEDIDO').AsInteger,
      FieldByName('CODIGO_PRODUTO').AsInteger,
      FieldByName('QUANTIDADE').AsInteger,
      FieldByName('VALOR_UNITARIO').AsCurrency,
      FieldByName('VALOR_TOTAL').AsCurrency,
      FieldByName('DESCRICAO').AsString
    );
    Next;
  end;

end;

function TPedidoDao.RetornarItens(const pCodigo: Integer): iEntity_LstPedidoItens;
const
  CMD_SQL = 'SELECT I.CODIGO, I.CODIGO_PEDIDO, I.CODIGO_PRODUTO, ' +
            'I.QUANTIDADE, I.VALOR_UNITARIO, I.VALOR_TOTAL, P.DESCRICAO '+
            'FROM PEDIDOITENS I '+
            'INNER JOIN PRODUTO P ON (I.CODIGO_PRODUTO=P.CODIGO) '+
            'WHERE I.CODIGO_PEDIDO = %d';
begin
  Result := TEntity_LstPedidoItens.New;
  with Self.FQuery.Open( Format(CMD_SQL, [pCodigo]), [] ) do
  while not Eof do
  begin
    Result.AddItem( _CriarPedidoItem(
      FieldByName('CODIGO').AsInteger,
      FieldByName('CODIGO_PEDIDO').AsInteger,
      FieldByName('CODIGO_PRODUTO').AsInteger,
      FieldByName('QUANTIDADE').AsInteger,
      FieldByName('VALOR_UNITARIO').AsCurrency,
      FieldByName('VALOR_TOTAL').AsCurrency,
      FieldByName('DESCRICAO').AsString
      )
    );
    Next;
  end;
end;

function TPedidoDao.RetornarItensCompleto(
  const pCodigo: Integer): iLstPedidoItens_dto;
const
  CMD_SQL = 'SELECT I.CODIGO, I.CODIGO_PEDIDO, I.CODIGO_PRODUTO, ' +
            'I.QUANTIDADE, I.VALOR_UNITARIO, I.VALOR_TOTAL, P.DESCRICAO '+
            'FROM PEDIDOITENS I '+
            'INNER JOIN PRODUTO P ON (I.CODIGO_PRODUTO=P.CODIGO) '+
            'WHERE I.CODIGO_PEDIDO = %d';
var
  lItem : iPedidoItem_dto;
begin
  Result := TLstPedidoItens_dto.New;
  with Self.FQuery.Open( Format(CMD_SQL, [pCodigo]), [] ) do
  while not Eof do
  begin
    litem := TPedidoItem_dto.new;
    litem.id            := FieldByName('CODIGO').AsInteger;
    litem.codigoProduto := FieldByName('CODIGO_PRODUTO').AsInteger;
    litem.quantidade    := FieldByName('QUANTIDADE').AsInteger;
    litem.valorUnitario := FieldByName('VALOR_UNITARIO').AsCurrency;
    litem.valorTotal    := FieldByName('VALOR_TOTAL').AsCurrency;
    litem.DescProduto   := FieldByName('DESCRICAO').AsString;

    Result.AddItem( litem );

    Next;
  end;

end;

function TPedidoDao.RetornarPorCodigo(const pCodigo: Integer): iEntity_Pedido;
const
  CMD_SQL = 'SELECT NUMERO_PEDIDO, CODIGO_CLIENTE, DATA_EMISSAO, VALORTOTAL FROM PEDIDO WHERE NUMERO_PEDIDO = %d';
begin
  Result := TEntity_Pedido.New;
  with Self.FQuery.Open( Format( CMD_SQL, [pCodigo]), [] ) do
  if not IsEmpty then
  begin
    Result.numeroPedido  := FieldByName('NUMERO_PEDIDO').AsInteger;
    Result.codigoCliente := FieldByName('CODIGO_CLIENTE').AsInteger;
    Result.dataEmissao   := FieldByName('DATA_EMISSAO').AsDateTime;
    Result.valorTotal    := FieldByName('VALORTOTAL').AsCurrency;
  end;
end;

function TPedidoDao.Salvar(const pPedido: iPedido_dto): Integer;
const
  CMD_SQL = 'INSERT INTO PEDIDO (CODIGO_CLIENTE,VALORTOTAL) VALUES (%d,%s) ';
begin
  Result := -1;
  try
    Self.FQuery.Exec( Format( CMD_SQL, [ pPedido.codigoCliente, _FloatToDB(pPedido.valorTotal) ]), [] );
    with Self.FQuery.Open( 'SELECT MAX(NUMERO_PEDIDO) NUMERO_PEDIDO FROM PEDIDO' , [] ) do
      if not isEmpty then
        Result := FieldByName('NUMERO_PEDIDO').AsInteger;

  except
    on E:Exception do
    begin
      raise Exception.Create('Erro ao inserir Pedido: '+ E.Message);
    end;
  end;

end;

procedure TPedidoDao.SalvarItem(const pItem: iPedidoItem_dto);
const
  CMD_SQL = 'INSERT INTO PEDIDOITENS (CODIGO_PEDIDO,CODIGO_PRODUTO,QUANTIDADE,VALOR_UNITARIO,VALOR_TOTAL) VALUES (%d,%d,%d,%s,%s)';
begin
  try
    Self.FQuery.Exec( Format( CMD_SQL, [ pItem.numeroPedido, pItem.codigoProduto, pItem.quantidade,
                                        _FloatToDB( pItem.valorUnitario ),
                                        _FloatToDB(pItem.valorTotal) ]), [] );
  except
    on E:Exception do
      raise Exception.Create('Erro ao inserir Item: '+ E.Message);
  end;
end;

function TPedidoDao._CriaPedido(const pNumPedido, pCodCli: Integer;
  const pDtEmissao: TDateTime; const pValorTotal: Currency): iEntity_Pedido;
begin
  Result               := TEntity_Pedido.New;
  Result.numeroPedido  := pNumPedido;
  Result.codigoCliente := pCodCli;
  Result.dataEmissao   := pDtEmissao;
  Result.valorTotal    := pValorTotal;
end;

function TPedidoDao._CriarPedidoItem(const pCod, pCodPedido, pCodProd,
  pQtd: Integer; pVlrUnit, pVlrTotal: Currency; const pDesc: String ): iEntity_PedidoItem;
begin
  Result := TEntity_PedidoItem.New;
  Result.id            := pCod;
  Result.numeroPedido  := pCodPedido;
  Result.codigoProduto := pCodProd;
  Result.quantidade    := pQtd;
  Result.valorUnitario := pVlrUnit;
  Result.valorTotal    := pVlrTotal;
//  Result.DescProduto   := pDesc;
end;

function TPedidoDao._FloatToDB(const pValue: Currency): String;
begin
  Result := FloatToStr( pValue );
  Result := StringReplace( Result, '.', '',[rfReplaceAll]);
  Result := StringReplace( Result, ',','.',[rfReplaceAll]);
end;

end.
