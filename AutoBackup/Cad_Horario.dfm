object frmCad_Horario: TfrmCad_Horario
  Left = 0
  Top = 0
  Caption = 'Cadastro de hor'#225'rios'
  ClientHeight = 119
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 78
    Width = 334
    Height = 41
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    object btnGravar: TBitBtn
      Left = 116
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Gravar'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCancelar: TBitBtn
      Left = 214
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 334
    Height = 78
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 168
      Top = 8
      Width = 23
      Height = 13
      Caption = 'Hora'
    end
    object Label1: TLabel
      Left = 10
      Top = 8
      Width = 70
      Height = 13
      Caption = 'Dia da semana'
    end
    object cmbDiaSemana: TDBComboBox
      Left = 9
      Top = 24
      Width = 145
      Height = 21
      Style = csDropDownList
      DataField = 'DisplayDia'
      DataSource = frmPrincipal_AutoBackup.DataHorarios
      Items.Strings = (
        'Domingo'
        'Segunda - Feira'
        'Ter'#231'a - Feira'
        'Quarta - Feira'
        'Quinta - Feira'
        'Sexta - Feira'
        'S'#225'bado')
      TabOrder = 0
    end
    object cxDBTimeEdit1: TcxDBTimeEdit
      Left = 168
      Top = 24
      DataBinding.DataField = 'Hora'
      DataBinding.DataSource = frmPrincipal_AutoBackup.DataHorarios
      Properties.AutoCorrectHours = False
      Properties.Circular = True
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      Properties.UseCtrlIncrement = True
      TabOrder = 1
      Width = 121
    end
  end
end
