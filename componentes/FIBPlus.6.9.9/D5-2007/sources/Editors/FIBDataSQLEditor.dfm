object frmDstSQLedit: TfrmDstSQLedit
  Left = 89
  Top = 135
  Width = 717
  Height = 466
  Caption = 'frmDstSQLedit'
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
  object Panel1: TPanel
    Left = 0
    Top = 402
    Width = 709
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
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
  inline fSQLsEdit: TfDSSQLEdit
    Left = 0
    Top = 0
    Width = 709
    Height = 402
    Align = alClient
    TabOrder = 1
    TabStop = True
    inherited pgCtrl: TPageControl
      Width = 709
      Height = 402
      inherited shSelect: TTabSheet
        inherited SelectSQLEdit: TfSQLEdit
          inherited Panel1: TPanel
            inherited splPlan: TSplitter
              Top = 351
              Width = 449
            end
            inherited Panel10: TPanel
              Width = 449
              inherited btnGenSQL: TSpeedButton
                Left = 349
              end
            end
            inherited StatusBar1: TStatusBar
              Top = 354
              Width = 449
            end
          end
          inherited Panel6: TPanel
            inherited GroupBox1: TGroupBox
              inherited Panel2: TPanel
                inherited DBGrid2: TDBGrid
                  Height = 57
                end
                inherited Panel4: TPanel
                  Top = 150
                end
              end
            end
          end
        end
      end
      inherited shGenOptions: TTabSheet
        inherited Splitter1: TSplitter
          Height = 374
        end
        inherited Panel2: TPanel
          Height = 374
          inherited GroupBox1: TGroupBox
            Top = 326
          end
          inherited GroupBox2: TGroupBox
            Top = 242
          end
        end
        inherited Panel3: TPanel
          Height = 374
          inherited LstKeyFields: TListBox
            Height = 361
          end
        end
        inherited Panel5: TPanel
          Width = 343
          Height = 374
          inherited Label4: TLabel
            Width = 343
          end
          inherited LstUpdFields: TListBox
            Width = 343
            Height = 361
          end
        end
      end
      inherited shModifySQLs: TTabSheet
        inherited ModifySQLEdit: TfSQLEdit
          inherited Panel1: TPanel
            inherited splPlan: TSplitter
              Top = 315
              Width = 449
            end
            inherited Panel10: TPanel
              Width = 449
              inherited btnReplaceZv: TSpeedButton
                Visible = False
              end
            end
            inherited StatusBar1: TStatusBar
              Top = 318
              Width = 449
            end
          end
          inherited Panel6: TPanel
            inherited GroupBox1: TGroupBox
              inherited Panel2: TPanel
                inherited DBGrid2: TDBGrid
                  Height = 36
                end
                inherited Panel4: TPanel
                  Top = 114
                end
              end
            end
          end
        end
      end
    end
  end
end
