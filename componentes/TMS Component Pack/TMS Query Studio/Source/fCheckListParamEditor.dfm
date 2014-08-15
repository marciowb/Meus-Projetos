inherited fmCheckListParamEditor: TfmCheckListParamEditor
  Caption = 'Check list parameter editor'
  ClientHeight = 281
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 241
  end
  inherited pnCaption: TPanel
    Top = 71
  end
  inherited pnItems: TPanel
    Top = 104
  end
  inherited pnInfo: TPanel
    Height = 51
    inherited lbInfo: TLabel
      Height = 39
      Caption = 
        'This parameter allow users to select one or more items on a drop' +
        ' down list editor.'#13#10'Each selected item apply all corresponding p' +
        'aram values to the query. '#13#10'Unselected items deactivates associa' +
        'ted parameter values from query.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 3
  end
end
