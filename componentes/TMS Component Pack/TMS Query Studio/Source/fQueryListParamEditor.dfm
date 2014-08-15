inherited fmQueryListParamEditor: TfmQueryListParamEditor
  Left = 269
  Top = 99
  Caption = 'Query list parameter editor'
  ClientHeight = 306
  ClientWidth = 391
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 266
    Width = 391
    TabOrder = 5
    inherited pnButton: TPanel
      Left = 102
    end
  end
  inherited pnCaption: TPanel
    Top = 100
    Width = 391
    TabOrder = 3
    inherited edCaption: TEdit
      Width = 300
      OnEnter = edCaptionEnter
    end
  end
  object pnParamName: TPanel [2]
    Left = 0
    Top = 71
    Width = 391
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label2: TLabel
      Left = 6
      Top = 9
      Width = 62
      Height = 13
      Caption = 'Param name:'
    end
    object edParamName: TComboBox
      Left = 79
      Top = 7
      Width = 200
      Height = 21
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object pnMetaSql: TPanel [3]
    Left = 0
    Top = 129
    Width = 391
    Height = 135
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object Label1: TLabel
      Left = 6
      Top = 9
      Width = 51
      Height = 13
      Caption = 'Meta-SQL:'
    end
    object Bevel1: TBevel
      Left = 6
      Top = 26
      Width = 68
      Height = 25
    end
    object edMetaSql: TRichEdit
      Left = 80
      Top = 8
      Width = 300
      Height = 123
      Anchors = [akLeft, akTop, akBottom]
      Color = 14737632
      PlainText = True
      ScrollBars = ssBoth
      TabOrder = 1
      WordWrap = False
    end
    object btMetaSql: TBitBtn
      Left = 7
      Top = 27
      Width = 66
      Height = 23
      Caption = 'Wizard >>'
      Enabled = False
      TabOrder = 0
    end
  end
  inherited pnTitle: TPanel
    Width = 391
  end
  inherited pnInfo: TPanel
    Width = 391
    Height = 51
    inherited lbInfo: TLabel
      Width = 379
      Height = 39
      Caption = 
        'This parameter allow user to select a value from a drop down lis' +
        't. List items are fetched from this meta-sql query. The first fi' +
        'eld on such query should correspond to the field associated to t' +
        'his parameter.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 6
    Top = 172
  end
end
