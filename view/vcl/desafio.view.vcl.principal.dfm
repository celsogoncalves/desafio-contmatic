object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Contmatic - Desafio'
  ClientHeight = 464
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 693
    Height = 464
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 569
      Height = 464
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 569
        Height = 129
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblClienteNome: TLabel
          Left = 72
          Top = 17
          Width = 40
          Height = 15
          Caption = 'Cliente:'
        end
        object lblClienteCidade: TLabel
          Left = 277
          Top = 17
          Width = 40
          Height = 15
          Caption = 'Cidade:'
        end
        object lblClienteUF: TLabel
          Left = 487
          Top = 17
          Width = 17
          Height = 15
          Caption = 'UF:'
        end
        object lblProdutoQtd: TLabel
          Left = 279
          Top = 72
          Width = 65
          Height = 15
          Caption = 'Quantidade:'
        end
        object lblProdutoDescricao: TLabel
          Left = 70
          Top = 72
          Width = 46
          Height = 15
          Caption = 'Produto:'
        end
        object lblProdutoValorUnit: TLabel
          Left = 376
          Top = 72
          Width = 74
          Height = 15
          Caption = 'Valor Unit'#225'rio:'
        end
        object lblCodigoCliente: TLabel
          Left = 18
          Top = 17
          Width = 28
          Height = 15
          Caption = 'C'#243'd.:'
        end
        object lblCodProduto: TLabel
          Left = 18
          Top = 72
          Width = 28
          Height = 15
          Caption = 'C'#243'd.:'
        end
        object cbxCliente: TComboBox
          Left = 70
          Top = 38
          Width = 195
          Height = 23
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbxClienteChange
        end
        object edtCidade: TEdit
          Left = 279
          Top = 38
          Width = 186
          Height = 23
          MaxLength = 64
          ReadOnly = True
          TabOrder = 1
        end
        object edtUF: TEdit
          Left = 487
          Top = 38
          Width = 66
          Height = 23
          MaxLength = 2
          ReadOnly = True
          TabOrder = 2
          Text = 'RJ'
        end
        object edtQuantidade: TEdit
          Left = 279
          Top = 93
          Width = 84
          Height = 23
          NumbersOnly = True
          TabOrder = 3
          Text = '1'
        end
        object cbxProduto: TComboBox
          Left = 70
          Top = 93
          Width = 195
          Height = 23
          Style = csDropDownList
          TabOrder = 4
          OnChange = cbxProdutoChange
        end
        object edtValorUnitario: TEdit
          Left = 376
          Top = 93
          Width = 89
          Height = 23
          NumbersOnly = True
          TabOrder = 5
          Text = '0'
        end
        object btnIncluirSalvar: TButton
          Left = 487
          Top = 92
          Width = 66
          Height = 25
          Caption = 'Incluir'
          TabOrder = 6
          OnClick = btnIncluirSalvarClick
        end
        object edtCodigoCliente: TEdit
          Left = 18
          Top = 38
          Width = 46
          Height = 23
          Enabled = False
          ReadOnly = True
          TabOrder = 7
        end
        object edtCodigoProduto: TEdit
          Left = 18
          Top = 93
          Width = 46
          Height = 23
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 8
        end
      end
      object lvItens: TListView
        Left = 0
        Top = 129
        Width = 569
        Height = 284
        Align = alClient
        Columns = <
          item
            Caption = 'Codigo'
            Width = 80
          end
          item
            Caption = 'Descricao'
            Width = 200
          end
          item
            Caption = 'Quantidade'
            Width = 80
          end
          item
            Caption = 'Valor Unitario'
            Width = 100
          end
          item
            Caption = 'Valor Total'
            Width = 100
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
      object pnlRodape: TPanel
        Left = 0
        Top = 413
        Width = 569
        Height = 51
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object lblTotalRodape: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 12
          Width = 144
          Height = 36
          Margins.Top = 12
          Align = alLeft
          Caption = 'Valor Total: R$ 0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 21
        end
      end
    end
    object pnlDireita: TPanel
      Left = 569
      Top = 0
      Width = 124
      Height = 464
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object btncancelarItem: TButton
        AlignWithMargins = True
        Left = 5
        Top = 10
        Width = 114
        Height = 30
        Margins.Left = 5
        Margins.Top = 10
        Margins.Right = 5
        Align = alTop
        Caption = 'Cancelar Item'
        TabOrder = 0
        OnClick = btncancelarItemClick
        ExplicitLeft = 6
        ExplicitTop = 11
        ExplicitWidth = 112
      end
      object btnEditarItem: TButton
        AlignWithMargins = True
        Left = 5
        Top = 46
        Width = 114
        Height = 30
        Margins.Left = 5
        Margins.Right = 5
        Align = alTop
        Caption = 'Editar item'
        TabOrder = 1
        OnClick = btnEditarItemClick
        ExplicitLeft = 6
        ExplicitTop = 42
        ExplicitWidth = 112
      end
      object btnCancelarPedido: TButton
        AlignWithMargins = True
        Left = 5
        Top = 352
        Width = 114
        Height = 30
        Margins.Left = 5
        Margins.Right = 5
        Align = alBottom
        Caption = 'Cancelar Pedido'
        TabOrder = 2
        Visible = False
        OnClick = btnCancelarPedidoClick
        ExplicitLeft = 8
        ExplicitTop = 315
        ExplicitWidth = 112
      end
      object btnSalvarPedido: TButton
        AlignWithMargins = True
        Left = 5
        Top = 424
        Width = 114
        Height = 30
        Margins.Left = 5
        Margins.Right = 5
        Margins.Bottom = 10
        Align = alBottom
        Caption = 'Salvar Pedido'
        TabOrder = 3
        OnClick = btnSalvarPedidoClick
        ExplicitLeft = 6
        ExplicitTop = 428
        ExplicitWidth = 112
      end
      object btnVisualizarPedidos: TButton
        AlignWithMargins = True
        Left = 5
        Top = 388
        Width = 114
        Height = 30
        Margins.Left = 5
        Margins.Right = 5
        Align = alBottom
        Caption = 'Visualizar Pedidos'
        TabOrder = 4
        WordWrap = True
        OnClick = btnVisualizarPedidosClick
        ExplicitLeft = 6
        ExplicitTop = 331
        ExplicitWidth = 112
      end
    end
  end
end
