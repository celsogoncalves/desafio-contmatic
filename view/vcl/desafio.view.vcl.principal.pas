unit desafio.view.vcl.principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, System.UITypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  desafio.controller.interfaces, desafio.model.entity.interfaces;

type
  TFormPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    pnlDados: TPanel;
    pnlCabecalho: TPanel;
    lblClienteNome: TLabel;
    lblClienteCidade: TLabel;
    lblClienteUF: TLabel;
    lblProdutoQtd: TLabel;
    lblProdutoDescricao: TLabel;
    lblProdutoValorUnit: TLabel;
    lblCodigoCliente: TLabel;
    lblCodProduto: TLabel;
    cbxCliente: TComboBox;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtQuantidade: TEdit;
    cbxProduto: TComboBox;
    edtValorUnitario: TEdit;
    btnIncluirSalvar: TButton;
    edtCodigoCliente: TEdit;
    edtCodigoProduto: TEdit;
    lvItens: TListView;
    pnlDireita: TPanel;
    btncancelarItem: TButton;
    btnEditarItem: TButton;
    btnCancelarPedido: TButton;
    btnSalvarPedido: TButton;
    pnlRodape: TPanel;
    btnVisualizarPedidos: TButton;
    lblTotalRodape: TLabel;
    procedure btnSalvarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxClienteChange(Sender: TObject);
    procedure cbxProdutoChange(Sender: TObject);
    procedure btnVisualizarPedidosClick(Sender: TObject);
    procedure btnIncluirSalvarClick(Sender: TObject);
    procedure btncancelarItemClick(Sender: TObject);
  private
    { Private declarations }

    FCtrlPedido  : iControllerPedido;
    FCtrlCliente : iControllerCliente;
    FCtrlProduto : iControllerProduto;

    FLstItens    : iEntity_LstPedidoItens;

    procedure Inicializar;
    procedure PreencherComboCliente;
    procedure PreencherComboProduto;

    procedure LimparCliente;
    procedure LimparProduto;

    function FormToEntity: iEntity_Pedido;
    procedure FormAddProduto;
    procedure AtualizaTotal;
    procedure MsgWarning(const pTexto: String);

    procedure PrepararFormAposFinalizar;
    procedure DeletarItemLista;
    procedure AtualizarItemDaLista;
    procedure ExibirBotaoCancelar;
    procedure EditandoItem(const pEmEdicao: Boolean);
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses
  desafio.controller.produto,
  desafio.model.connection.FireDac,
  desafio.controller.cliente, desafio.controller.pedido, desafio.model.entity,
  desafio.model.connection.interfaces, desafio.view.vcl.pedido;

procedure TFormPrincipal.AtualizarItemDaLista;
var
  lNovaLista : iEntity_LstPedidoItens;
  lSelecionado : integer;
begin
  lSelecionado := lvItens.ItemIndex;

  FlstItens.Itens[ lSelecionado ].quantidade := StrToInt(edtQuantidade.Text);
  FlstItens.Itens[ lSelecionado ].valorUnitario := StrToFloat(edtValorUnitario.Text);

  lvItens.Items[ lSelecionado ].SubItems[1] := edtQuantidade.Text;
  lvItens.Items[ lSelecionado ].SubItems[2] := edtValorUnitario.Text;
  lvItens.Items[ lSelecionado ].SubItems[3] := FormatFloat('#,##0.00', StrToInt(edtQuantidade.Text) * StrToFloat(edtValorUnitario.Text));

  AtualizaTotal;
end;

procedure TFormPrincipal.AtualizaTotal;
begin
  lblTotalRodape.Caption := FormatFloat('Valor Total: R$ #,##0.00', Flstitens.getValorTotal);
end;

procedure TFormPrincipal.btncancelarItemClick(Sender: TObject);
begin
  if (lvItens.ItemIndex >= 0) then
  begin
    if MessageDlg('Deseja realmente CANCELAR este item?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      DeletarItemLista;
  end;
end;

procedure TFormPrincipal.btnCancelarPedidoClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente DESISTIR deste pedido?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    PrepararFormAposFinalizar;
end;

procedure TFormPrincipal.btnEditarItemClick(Sender: TObject);
begin
  if (lvItens.ItemIndex >= 0) then
  begin
    if MessageDlg('Deseja realmente EDITAR este item?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if edtQuantidade.CanFocus then
        edtQuantidade.SetFocus;

      edtCodigoProduto.Text := lvItens.Items[ lvItens.ItemIndex ].Caption;
      cbxProduto.ItemIndex  := cbxproduto.Items.IndexOf( lvItens.Items[ lvItens.ItemIndex ].SubItems[0] );
      edtQuantidade.Text := lvItens.Items[ lvItens.ItemIndex ].SubItems[1];
      edtValorUnitario.Text := lvItens.Items[ lvItens.ItemIndex ].SubItems[2];
      EditandoItem(True)
    end;
  end;
end;

procedure TFormPrincipal.btnIncluirSalvarClick(Sender: TObject);
begin
  if ( StrToIntDef(edtQuantidade.Text,0) <= 0 ) then
  begin
    MsgWarning('Por favor, informe uma quantidade válida!');
    exit;
  end;

  if ( StrToFloatDef(edtValorUnitario.Text, 0) <= 0 ) then
  begin
    MsgWarning('Por favor, informe um valor unitário válido!');
    exit;
  end;

  if btnIncluirSalvar.Caption = 'Salvar' then
  begin
    AtualizarItemDaLista;
    lvItens.Enabled := True;
    EditandoItem(False);
  end
  else
    FormAddProduto;

  cbxProduto.ItemIndex := 0;
  LimparProduto;
end;

procedure TFormPrincipal.btnSalvarPedidoClick(Sender: TObject);
begin
  if (edtCodigoCliente.Text = '') then
  begin
     MsgWarning('Por favor, preencha o campo Cliente!');
     exit;
  end;

  if (lvItens.Items.Count <= 0) then
  begin
     MsgWarning('Por favor, adicione ao menos um produto!');
     exit;
  end;

  FCtrlPedido.Salvar( FormToEntity );

  PrepararFormAposFinalizar;

  MessageDlg('Pedido salvo com sucesso!', TMsgDlgType.mtInformation, [mbOk], 0);
end;

procedure TFormPrincipal.btnVisualizarPedidosClick(Sender: TObject);
var
  lFrmPedido: TFormVisualizarPedidos;
begin

  try
    lFrmPedido := TFormVisualizarPedidos.Create(nil);
    lFrmPedido.putCtrlPedido( Self.FCtrlPedido );
    lFrmPedido.putCtrlCliente( Self.FCtrlCliente );

    lFrmPedido.Inicializar;

    lFrmPedido.ShowModal;

  finally
    FreeAndNil(lFrmPedido);
  end;
end;

procedure TFormPrincipal.cbxClienteChange(Sender: TObject);
begin
  LimparCliente;
  if cbxCliente.Text <> '' then
  begin
    btnCancelarPedido.Visible := False;
    with FCtrlCliente.Retorna( integer(cbxCliente.Items.Objects[ cbxCliente.ItemIndex ]) ) do
    begin
      edtCodigoCliente.Text := IntToStr(codigo);
      edtCidade.Text        := cidade;
      edtUF.Text            := uf;
    end;
  end
  else
    btnCancelarPedido.Visible := High(FLstItens.Itens)>=0;
end;

procedure TFormPrincipal.cbxProdutoChange(Sender: TObject);
begin
  LimparProduto;
  if cbxProduto.Text <> '' then
  begin
    with FCtrlProduto.Retorna( integer(cbxproduto.Items.Objects[ cbxProduto.ItemIndex ]) ) do
    begin
      edtCodigoProduto.Text := IntToStr( codigo );
      edtQuantidade.Text    := '1';
      edtValorUnitario.Text := FloatToStr( precovenda );
    end;
  end;
end;

procedure TFormPrincipal.DeletarItemLista;
var
  lNovaLista   : iEntity_LstPedidoItens;
  lSelecionado : integer;
begin
  lSelecionado := lvItens.ItemIndex;
  lNovaLista := TEntity_LstPedidoItens.new;
  for var I := Low( FLstItens.Itens ) to High( FLstItens.Itens ) do
    if (lSelecionado <> I) then
      lNovaLista.AddItem( FLstItens.Itens[I] );

  lvItens.Items.Delete( lSelecionado );

  FLstItens.Itens := lNovaLista.Itens;

  ExibirBotaoCancelar;

  AtualizaTotal;
end;

procedure TFormPrincipal.EditandoItem(const pEmEdicao: Boolean);
begin
  if pEmEdicao then
    btnIncluirSalvar.Caption := 'Salvar'
  else
    btnIncluirSalvar.Caption := 'Incluir';

  cbxCliente.Enabled           := not pemEdicao;
  cbxProduto.Enabled           := not pEmEdicao;
  btnEditarItem.Enabled        := not pEmEdicao;
  btncancelarItem.Enabled      := not pEmEdicao;
  btnCancelarPedido.Enabled    := not pEmEdicao;
  btnSalvarPedido.Enabled      := not pEmEdicao;
  btnVisualizarPedidos.Enabled := not pEmEdicao;
  lvItens.Enabled              := not pEmEdicao;
end;

procedure TFormPrincipal.ExibirBotaoCancelar;
begin
  btnCancelarPedido.Visible := (High(FLstItens.Itens)>=0) and (cbxCliente.Text='');
end;

procedure TFormPrincipal.FormAddProduto;
var
  lItem : TListItem;
  lPedItem : iEntity_PedidoItem;
begin

  lPeditem := TEntity_PedidoItem.New;

  lPedItem.codigoProduto := StrToInt(edtCodigoProduto.Text);
  lPedItem.quantidade    := StrToint( edtQuantidade.Text);
  lPedItem.valorUnitario := StrToFloat( edtValorUnitario.Text );

  FLstItens.AddItem( lPedItem );

  lItem := lvItens.Items.Add;
  lItem.Caption := edtCodigoProduto.Text;
  lItem.SubItems.Add( cbxProduto.Text  );
  lItem.SubItems.Add( edtQuantidade.Text );
  lItem.SubItems.Add( edtValorUnitario.Text );
  lItem.SubItems.Add( FormatFloat('#,##0.00', StrToInt(edtQuantidade.Text) * StrToFloat(edtValorUnitario.Text)) );

  AtualizaTotal;
  ExibirBotaoCancelar;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

function TFormPrincipal.FormToEntity: iEntity_Pedido;
var
  litem : iEntity_PedidoItem;
begin
  Result := TEntity_Pedido.New;

  Result.codigoCliente := StrToInt(edtCodigoCliente.Text);

  for litem in FLstItens.Itens do
    Result.Itens.AddItem( litem );
end;

procedure TFormPrincipal.Inicializar;
var
  lConn : iConexao;
begin
  lConn := TFireDacConexao.New;
  FCtrlPedido  := TControllerPedido.New( lConn );
  FCtrlCliente := TControllerCliente.New( lConn );
  FCtrlProduto := TControllerProduto.New( lConn );
  LimparCliente;
  LimparProduto;
  PreencherComboCliente;
  PreencherComboProduto;
  FLstItens := TEntity_LstPedidoItens.New;
end;

procedure TFormPrincipal.LimparCliente;
begin
  edtCodigoCliente.Text := '';
  edtCidade.Text        := '';
  edtUF.Text            := '';
end;

procedure TFormPrincipal.LimparProduto;
begin
  edtCodigoProduto.Text := '';
  edtQuantidade.Text    := '0';
  edtValorUnitario.Text := '0';
end;

procedure TFormPrincipal.MsgWarning(const pTexto: String);
begin
  MessageDlg(pTexto, TMsgDlgType.mtWarning, [mbOk], 0);
end;

procedure TFormPrincipal.PreencherComboCliente;
begin
  cbxCliente.Items.Clear;
  cbxCliente.AddItem( '', TObject( -1 ) );
  for var lItem in  FCtrlCliente.Listar.Itens do
    cbxCliente.AddItem( litem.nome, TObject( lItem.codigo ) );
end;

procedure TFormPrincipal.PreencherComboProduto;
begin
  cbxProduto.Items.Clear;
  cbxProduto.AddItem( '', TObject( -1 ) );
  for var lItem in  FCtrlProduto.Listar.Itens do
    cbxProduto.AddItem( litem.descricao, TObject( lItem.codigo ) );
end;

procedure TFormPrincipal.PrepararFormAposFinalizar;
begin
  LimparProduto;
  LimparCliente;
  cbxCliente.ItemIndex := 0;
  cbxProduto.ItemIndex := 0;

  FLstItens := TEntity_LstPedidoItens.New;
  lvItens.Clear;
end;

end.
