inherited frmLst_Usuario: TfrmLst_Usuario
  Caption = 'Cadastro de usu'#225'rio'
  ClientHeight = 245
  ExplicitHeight = 279
  PixelsPerInch = 96
  TextHeight = 13
  inherited Status: TStatusBar
    Top = 226
  end
  inherited Panel1: TPanel
    Height = 226
    inherited cxSplitter1: TcxSplitter
      Height = 196
    end
    inherited Panel3: TPanel
      Height = 196
      inherited edtCodigo: TLabelDBEdit
        Width = 105
        DataField = 'LOGIN'
        Titulo.Width = 25
        Titulo.Caption = 'Login'
        Titulo.ExplicitWidth = 25
        ExplicitWidth = 105
      end
      inherited Panel4: TPanel
        Top = 155
      end
      object LabelDBEdit1: TLabelDBEdit
        Left = 127
        Top = 27
        Width = 50
        Height = 21
        DataField = 'SENHA'
        DataSource = DataCadastro
        PasswordChar = 'A'
        TabOrder = 2
        Titulo.Left = 127
        Titulo.Top = 12
        Titulo.Width = 30
        Titulo.Height = 13
        Titulo.Caption = 'Senha'
        IsNull = False
        PodeRepetir = False
        CorPrincipal = clWhite
        CorSecundaria = 11592447
        GravaEsteCampo = True
      end
      object LabelDBEdit2: TLabelDBEdit
        Left = 16
        Top = 72
        Width = 281
        Height = 21
        DataField = 'NOME'
        DataSource = DataCadastro
        TabOrder = 3
        Titulo.Left = 16
        Titulo.Top = 57
        Titulo.Width = 73
        Titulo.Height = 13
        Titulo.Caption = 'Nome completo'
        IsNull = True
        PodeRepetir = True
        CorPrincipal = clWhite
        CorSecundaria = 11592447
        GravaEsteCampo = True
      end
    end
    inherited Panel2: TPanel
      Height = 196
      inherited PageControl: TcxPageControl
        Height = 194
        ClientRectBottom = 190
        inherited tsGrid: TcxTabSheet
          inherited pnlGrid: TPanel
            Height = 168
            inherited TvCadastro: TcxGrid
              Height = 168
            end
          end
        end
        inherited tsTree: TcxTabSheet
          inherited pnlTree: TPanel
            Height = 168
            inherited TvTree: TcxDBTreeList
              Height = 168
            end
          end
        end
      end
    end
  end
end
