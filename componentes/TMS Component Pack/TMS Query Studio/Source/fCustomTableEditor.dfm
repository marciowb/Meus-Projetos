inherited fmCustomTableEditor: TfmCustomTableEditor
  Left = 292
  Top = 77
  ActiveControl = edTableName
  Caption = 'Query table'
  ClientHeight = 233
  ClientWidth = 302
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnTableName: TPanel [0]
    Left = 0
    Top = 71
    Width = 302
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 6
      Top = 9
      Width = 59
      Height = 13
      Caption = 'Table name:'
    end
    object edTableName: TComboBox
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Color = 14737632
      ItemHeight = 13
      TabOrder = 0
      OnExit = edTableNameExit
    end
  end
  object pnTableAlias: TPanel [1]
    Left = 0
    Top = 100
    Width = 302
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label2: TLabel
      Left = 6
      Top = 9
      Width = 54
      Height = 13
      Caption = 'Table alias:'
    end
    object edTableAlias: TEdit
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Color = 14737632
      TabOrder = 0
    end
  end
  object pnJoinType: TPanel [2]
    Left = 0
    Top = 129
    Width = 302
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object Label4: TLabel
      Left = 6
      Top = 9
      Width = 45
      Height = 13
      Caption = 'Join type:'
    end
    object edJoinType: TComboBox
      Left = 79
      Top = 7
      Width = 150
      Height = 21
      Style = csDropDownList
      Color = 14737632
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      Items.Strings = (
        '(no join)'
        'Inner join'
        'Left outer join'
        'Right outer join')
    end
  end
  object pnJoinCondition: TPanel [3]
    Left = 0
    Top = 158
    Width = 302
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object Label3: TLabel
      Left = 6
      Top = 9
      Width = 68
      Height = 13
      Caption = 'Join condition:'
    end
    object edJoinCondition: TEdit
      Left = 79
      Top = 7
      Width = 205
      Height = 21
      Color = 14737632
      PopupMenu = PopupMenu1
      TabOrder = 0
    end
  end
  inherited pnBottom: TPanel
    Top = 193
    Width = 302
    TabOrder = 6
    inherited pnButton: TPanel
      Left = 58
    end
  end
  inherited pnTitle: TPanel
    Width = 302
  end
  inherited pnInfo: TPanel
    Width = 302
    Height = 51
    TabOrder = 1
    inherited lbInfo: TLabel
      Width = 290
      Height = 39
      Caption = 
        'Table indicated here is a data source for querying. One or more ' +
        'tables may be linked together to build a query.'#13#10'Join condition ' +
        'is used to link this table to other related tables.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Top = 185
  end
end
