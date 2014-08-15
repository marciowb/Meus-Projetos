inherited frmLst_FormaPagamento: TfrmLst_FormaPagamento
  Caption = 'Cadastro de forma de pagamento'
  ClientHeight = 324
  ExplicitWidth = 320
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 13
  inherited Status: TStatusBar
    Top = 305
    ExplicitTop = 305
  end
  inherited Panel1: TPanel
    Height = 305
    ExplicitHeight = 305
    inherited cxSplitter1: TcxSplitter
      Height = 275
      ExplicitHeight = 275
    end
    inherited Panel3: TPanel
      Height = 275
      ExplicitHeight = 275
      inherited Panel4: TPanel
        Top = 234
        ExplicitTop = 234
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 16
        Top = 152
        Width = 185
        Height = 73
        Caption = ' Tipo de pagamento '
        Columns = 2
        DataField = 'TIPOFORMAPAGAMENTO'
        DataSource = DataCadastro
        Items.Strings = (
          'Dinheiro'
          'Cheque'
          'Cart'#227'o'
          'Faturado')
        ParentBackground = True
        TabOrder = 2
        Values.Strings = (
          'D'
          'H'
          'C'
          'F')
      end
    end
    inherited ToolBar1: TToolBar
      inherited ToolButton1: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton2: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton3: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton4: TToolButton
        ExplicitWidth = 24
      end
      inherited btnNovo: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton9: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton10: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton11: TToolButton
        ExplicitWidth = 24
      end
    end
    inherited Panel2: TPanel
      Height = 275
      ExplicitHeight = 275
      inherited PageControl: TcxPageControl
        Height = 273
        ExplicitHeight = 273
        ClientRectBottom = 269
        inherited tsGrid: TcxTabSheet
          ExplicitLeft = 2
          ExplicitTop = 22
          ExplicitWidth = 295
          ExplicitHeight = 296
          inherited pnlGrid: TPanel
            Height = 247
            ExplicitHeight = 247
            inherited TvCadastro: TcxGrid
              Height = 247
              ExplicitHeight = 247
            end
          end
        end
        inherited tsTree: TcxTabSheet
          ExplicitLeft = 2
          ExplicitTop = 22
          ExplicitWidth = 295
          ExplicitHeight = 296
          inherited pnlTree: TPanel
            Height = 247
            ExplicitHeight = 247
            inherited TvTree: TcxDBTreeList
              Height = 247
              ExplicitHeight = 247
            end
          end
        end
      end
    end
  end
end
