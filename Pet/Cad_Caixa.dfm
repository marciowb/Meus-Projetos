inherited frmCad_Caixa: TfrmCad_Caixa
  ActiveControl = LabelDBEdit1
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Cadastro de caixa'
  ClientHeight = 200
  ClientWidth = 262
  ExplicitWidth = 270
  ExplicitHeight = 234
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 159
    Width = 262
    TabOrder = 1
    ExplicitTop = 159
    ExplicitWidth = 262
    inherited btnOk: TBitBtn
      Left = 32
      ExplicitLeft = 32
    end
    inherited btnCancelar: TBitBtn
      Left = 123
      ExplicitLeft = 123
    end
  end
  inherited Panel2: TPanel
    Width = 262
    Height = 159
    TabOrder = 0
    ExplicitWidth = 262
    ExplicitHeight = 159
    object Label1: TLabel
      Left = 136
      Top = 8
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object LabelDBEdit1: TLabelDBEdit
      Left = 8
      Top = 24
      Width = 121
      Height = 21
      DataField = 'valor'
      DataSource = frmLst_Caixa.DataListagem
      TabOrder = 0
      Titulo.Left = 8
      Titulo.Top = 9
      Titulo.Width = 24
      Titulo.Height = 13
      Titulo.Caption = 'Valor'
      IsNull = False
      PodeRepetir = True
      CorPrincipal = clWhite
      CorSecundaria = 11592447
      GravaEsteCampo = True
    end
    object edtData: TcxDBDateEdit
      Left = 136
      Top = 24
      DataBinding.DataField = 'data'
      DataBinding.DataSource = frmLst_Caixa.DataListagem
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 97
    end
    object LabelDBEdit2: TLabelDBEdit
      Left = 8
      Top = 64
      Width = 225
      Height = 21
      DataField = 'historico'
      DataSource = frmLst_Caixa.DataListagem
      TabOrder = 2
      Titulo.Left = 8
      Titulo.Top = 49
      Titulo.Width = 37
      Titulo.Height = 13
      Titulo.Caption = 'His'#243'rico'
      IsNull = False
      PodeRepetir = True
      CorPrincipal = clWhite
      CorSecundaria = 11592447
      GravaEsteCampo = True
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 8
      Top = 91
      Width = 225
      Height = 54
      Caption = ' Opera'#231#227'o '
      Columns = 2
      DataField = 'FLAGOPERACAO'
      DataSource = frmLst_Caixa.DataListagem
      Items.Strings = (
        'Cr'#233'dito'
        'D'#233'bito')
      ParentBackground = True
      TabOrder = 3
      Values.Strings = (
        'C'
        'D')
    end
  end
end
