inherited fmChooseListParamEditor: TfmChooseListParamEditor
  Caption = 'Choose list parameter editor'
  ClientHeight = 282
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBottom: TPanel
    Top = 242
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
        'This parameter allow users to select one among several items on ' +
        'a drop down list editor.'#13#10'The unique selected item apply all cor' +
        'responding parameter values to the query.'#13#10'Unselected items deac' +
        'tivates corresponding parameter values from query.'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 7
    Top = 247
  end
end
