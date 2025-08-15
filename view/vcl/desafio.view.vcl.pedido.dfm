object FormVisualizarPedidos: TFormVisualizarPedidos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Visualizar Pedidos'
  ClientHeight = 471
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 696
    Height = 471
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 569
      Height = 471
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object pnlCabecalho: TPanel
        Left = 0
        Top = 196
        Width = 569
        Height = 69
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblCliente: TLabel
          Left = 72
          Top = 17
          Width = 40
          Height = 15
          Caption = 'Cliente:'
        end
        object lblCodigoCliente: TLabel
          Left = 18
          Top = 17
          Width = 28
          Height = 15
          Caption = 'C'#243'd.:'
        end
        object lblCidade: TLabel
          Left = 277
          Top = 17
          Width = 40
          Height = 15
          Caption = 'Cidade:'
        end
        object lblUF: TLabel
          Left = 487
          Top = 17
          Width = 17
          Height = 15
          Caption = 'UF:'
        end
        object edtCodigoCliente: TEdit
          Left = 18
          Top = 38
          Width = 46
          Height = 23
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object edtUF: TEdit
          Left = 487
          Top = 38
          Width = 66
          Height = 23
          MaxLength = 2
          ReadOnly = True
          TabOrder = 1
          Text = 'RJ'
        end
        object edtCidade: TEdit
          Left = 279
          Top = 38
          Width = 191
          Height = 23
          MaxLength = 64
          ReadOnly = True
          TabOrder = 2
        end
        object edtCliente: TEdit
          Left = 72
          Top = 38
          Width = 196
          Height = 23
          MaxLength = 64
          ReadOnly = True
          TabOrder = 3
        end
      end
      object lvItens: TListView
        Left = 0
        Top = 265
        Width = 569
        Height = 155
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
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
      object lvPedidos: TListView
        Left = 0
        Top = 73
        Width = 569
        Height = 123
        Align = alTop
        Columns = <
          item
            Caption = 'Numero'
            Width = 80
          end
          item
            Caption = 'Cod Cliente'
            Width = 200
          end
          item
            Caption = 'Emissao'
            Width = 160
          end
          item
            Caption = 'Valor Total'
            Width = 100
          end>
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
        OnChange = lvPedidosChange
      end
      object pnlSuperior: TPanel
        Left = 0
        Top = 0
        Width = 569
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object lblFiltroCliente: TLabel
          Left = 18
          Top = 17
          Width = 94
          Height = 15
          Caption = 'Filtrar Por Cliente:'
        end
        object cbxCliente: TComboBox
          Left = 18
          Top = 38
          Width = 415
          Height = 23
          TabOrder = 0
        end
        object btnPesquisar: TButton
          Left = 460
          Top = 36
          Width = 93
          Height = 25
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = btnPesquisarClick
        end
      end
      object pnlRodape: TPanel
        Left = 0
        Top = 420
        Width = 569
        Height = 51
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 4
        object lblTotalRodape: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 12
          Width = 195
          Height = 36
          Margins.Top = 12
          Align = alLeft
          Caption = 'Quantidade de Pedidos: 0'
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
      Width = 127
      Height = 471
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object btnFechar: TButton
        AlignWithMargins = True
        Left = 5
        Top = 436
        Width = 117
        Height = 25
        Margins.Left = 5
        Margins.Right = 5
        Margins.Bottom = 10
        Align = alBottom
        Caption = 'Voltar'
        TabOrder = 0
        OnClick = btnFecharClick
      end
    end
  end
end
