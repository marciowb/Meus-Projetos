object frmEditCheckStrings: TfrmEditCheckStrings
  Left = 197
  Top = 124
  Width = 474
  Height = 365
  Caption = 'Edit Conditions '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline fraEdConditions1: TfraEdConditions
    Width = 466
    Height = 331
    Align = alClient
    inherited Panel1: TPanel
      Width = 376
      Height = 331
      inherited Splitter1: TSplitter
        Top = 197
        Width = 368
      end
      inherited GroupBox2: TGroupBox
        Width = 368
        Height = 193
        inherited Panel3: TPanel
          Width = 364
          Height = 176
          inherited Memo1: TMemo
            Width = 356
            Height = 168
          end
        end
      end
      inherited GroupBox1: TGroupBox
        Top = 201
        Width = 368
        inherited Panel4: TPanel
          Width = 364
          inherited ListView1: TListView
            Width = 356
          end
        end
      end
    end
    inherited Panel2: TPanel
      Left = 376
      Height = 331
    end
  end
end
