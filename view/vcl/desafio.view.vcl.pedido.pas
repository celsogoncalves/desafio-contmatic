unit desafio.view.vcl.pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  desafio.controller.interfaces;

type
  TFormVisualizarPedidos = class(TForm)
    pnlPrincipal: TPanel;
    pnlDados: TPanel;
    pnlCabecalho: TPanel;
    lblCliente: TLabel;
    lblCodigoCliente: TLabel;
    edtCodigoCliente: TEdit;
    lvItens: TListView;
    pnlDireita: TPanel;
    btnFechar: TButton;
    lblCidade: TLabel;
    edtUF: TEdit;
    lblUF: TLabel;
    edtCidade: TEdit;
    lvPedidos: TListView;
    pnlSuperior: TPanel;
    lblFiltroCliente: TLabel;
    cbxCliente: TComboBox;
    btnPesquisar: TButton;
    edtCliente: TEdit;
    pnlRodape: TPanel;
    lblTotalRodape: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure lvPedidosChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    FCtrlPedido  : iControllerPedido;
    FCtrlCliente : iControllerCliente;
    FCtrlProduto : iControllerProduto;

    { Private declarations }
  public
    { Public declarations }

    procedure putCtrlPedido( const pCtrl: iControllerPedido );
    procedure putCtrlCliente( const pCtrl: iControllerCliente );

    procedure Inicializar;

    procedure PreencherComboCliente;
    procedure LimparCliente;
    procedure CarregarDados;
    procedure CarregarItens(const pCod: Integer);
  end;

var
  FormVisualizarPedidos: TFormVisualizarPedidos;

implementation

{$R *.dfm}

uses desafio.model.entity.interfaces, desafio.model.dto.interfaces;

procedure TFormVisualizarPedidos.btnPesquisarClick(Sender: TObject);
var
  lItem : TListItem;
  lPedido : iPedido_Dto;
begin
  lvPedidos.Clear;
  for lPedido in FCtrlPedido.Listar( integer(cbxCliente.Items.Objects[ cbxCliente.ItemIndex ] ) ).Itens do
  begin
    lItem := lvPedidos.Items.Add;
    lItem.Caption := IntToStr(lPedido.numeroPedido);
    lItem.SubItems.Add( IntToStr(lPedido.codigoCliente) );
    lItem.SubItems.Add( FormatDateTime('YYYY/MM/DD HH:MM:SS', lPedido.dataEmissao) );
    lItem.SubItems.Add( FloatToStr(lPedido.valorTotal) );
  end;

  lblTotalRodape.Caption :=  'Quantidade de Pedidos: ' + IntToStr( lvPedidos.Items.Count+1);
end;

procedure TFormVisualizarPedidos.CarregarDados;
begin
  if (lvPedidos.Items.Count > 0) and (StrToInt(lvPedidos.Items[lvPedidos.ItemIndex].SubItems[0]) > 0) then
  begin
    with FCtrlCliente.Retorna( StrToInt(lvPedidos.Items[lvPedidos.ItemIndex].SubItems[0]) ) do
    begin
      edtCodigoCliente.Text := IntToStr(codigo);
      edtCliente.Text       := nome;
      edtCidade.Text        := cidade;
      edtUF.Text            := uf;
    end;

    CarregarItens( StrToInt(lvPedidos.Items[lvPedidos.ItemIndex].Caption ) );
  end;
end;

procedure TFormVisualizarPedidos.CarregarItens(const pCod: Integer);
var
  lPedidoItem : iPedidoItem_dto;
  lItem : TListItem;
begin
  lvItens.Clear;
  for lPedidoItem in FCtrlPedido.RetornarItensCompletos(pCod).Itens do
  begin
    lItem := lvItens.Items.Add;
    lItem.Caption := IntToStr(lPedidoItem.Id);
    lItem.SubItems.Add( lPedidoItem.DescProduto );
    lItem.SubItems.Add( IntToStr(lPedidoItem.quantidade) );
    lItem.SubItems.Add( FormatFloat('R$ #,##0.00', lPedidoItem.valorUnitario) );
    lItem.SubItems.Add( FormatFloat('R$ #,##0.00', lPedidoItem.valorTotal) );
  end;
end;

procedure TFormVisualizarPedidos.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormVisualizarPedidos.Inicializar;
begin
  LimparCliente;
  PreencherComboCliente;
  cbxCliente.ItemIndex := 0;
end;

procedure TFormVisualizarPedidos.LimparCliente;
begin
  edtCodigoCliente.Text := '';
  edtCidade.Text        := '';
  edtUF.Text            := '';
  edtCliente.Text       := '';
end;

procedure TFormVisualizarPedidos.lvPedidosChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if (lvPedidos.ItemIndex >= 0) then
    CarregarDados;
end;

procedure TFormVisualizarPedidos.PreencherComboCliente;
begin
  cbxCliente.Items.Clear;
  cbxCliente.AddItem( 'Todos', TObject( -1 ) );
  for var lItem in  FCtrlCliente.Listar.Itens do
    cbxCliente.AddItem( litem.nome, TObject( lItem.codigo ) );
end;

procedure TFormVisualizarPedidos.putCtrlCliente( const pCtrl: iControllerCliente );
begin
  Self.FCtrlCliente := pCtrl;
end;

procedure TFormVisualizarPedidos.putCtrlPedido( const pCtrl: iControllerPedido );
begin
  Self.FCtrlPedido := pCtrl;
end;


end.

