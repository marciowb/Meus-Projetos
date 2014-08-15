object frmSQLEdit: TfrmSQLEdit
  Left = 107
  Top = 129
  Width = 714
  Height = 471
  Caption = 'frmSQLEdit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inline fSQLEdit1: TfSQLEdit
    Width = 706
    Height = 407
    Align = alClient
    inherited Splitter2: TSplitter
      Left = 456
      Height = 407
    end
    inherited Panel1: TPanel
      Width = 456
      Height = 407
      inherited splPlan: TSplitter
        Top = 384
        Width = 454
      end
      inherited Panel10: TPanel
        Width = 454
      end
      inherited StatusBar1: TStatusBar
        Top = 387
        Width = 454
      end
    end
    inherited Panel6: TPanel
      Left = 459
      Height = 407
      inherited GroupBox1: TGroupBox
        Height = 339
        inherited Panel2: TPanel
          Height = 275
          inherited Splitter1: TSplitter
            Height = 3
          end
          inherited DBGrid2: TDBGrid
            Top = 92
            Height = 91
          end
          inherited Panel4: TPanel
            Top = 183
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 407
    Width = 706
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    OnResize = Panel1Resize
    object btnOK: TBitBtn
      Left = 546
      Top = 8
      Width = 73
      Height = 25
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
      NumGlyphs = 2
    end
    object btnCancel: TBitBtn
      Left = 626
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      NumGlyphs = 2
    end
  end
end
