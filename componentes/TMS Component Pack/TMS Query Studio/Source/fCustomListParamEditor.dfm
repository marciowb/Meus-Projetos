inherited fmCustomListParamEditor: TfmCustomListParamEditor
  Caption = 'Custom list parameter editor'
  ClientHeight = 273
  ClientWidth = 450
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 233
    Width = 450
    TabOrder = 4
    inherited pnButton: TPanel
      Left = 131
    end
  end
  inherited pnCaption: TPanel
    Width = 450
    Height = 33
    inherited edCaption: TEdit
      Left = 60
      Width = 378
    end
  end
  object pnItems: TPanel [2]
    Left = 0
    Top = 90
    Width = 450
    Height = 136
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object lbParamValues: TLabel
      Left = 187
      Top = 4
      Width = 172
      Height = 13
      Caption = 'Corresponding condition parameters:'
    end
    object Label2: TLabel
      Left = 7
      Top = 4
      Width = 70
      Height = 13
      Caption = 'Drop down list:'
    end
    object edParamValues: TListView
      Left = 186
      Top = 18
      Width = 252
      Height = 114
      Anchors = [akLeft, akTop, akBottom]
      Color = 14737632
      Columns = <
        item
          Caption = 'Value'
          Width = 100
        end
        item
          Caption = 'Param name'
          Width = 130
        end>
      SortType = stData
      TabOrder = 1
      ViewStyle = vsReport
      OnCompare = edParamValuesCompare
      OnEdited = edParamValuesEdited
      OnEnter = edParamValuesEnter
      OnKeyDown = edParamValuesKeyDown
    end
    object edListItems: TListView
      Left = 7
      Top = 18
      Width = 173
      Height = 114
      Anchors = [akLeft, akTop, akBottom]
      Color = 14737632
      Columns = <
        item
          Caption = 'Item text'
          Width = 150
        end>
      HideSelection = False
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = edListItemsChange
      OnClick = edListItemsClick
      OnKeyDown = edListItemsKeyDown
    end
  end
  inherited pnTitle: TPanel
    Width = 450
  end
  inherited pnInfo: TPanel
    Width = 450
    inherited lbInfo: TLabel
      Width = 438
      Caption = ''
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 10
    Top = 239
  end
end
