inherited dxDBInspectorEditForm: TdxDBInspectorEditForm
  Left = 487
  Top = 105
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    TabOrder = 1
    inherited BRestore: TButton
      Top = 135
      TabOrder = 4
    end
    inherited cbDragDrop: TCheckBox
      Top = 168
      TabOrder = 5
    end
    object BWizard: TButton
      Left = 7
      Top = 103
      Width = 90
      Height = 23
      Caption = 'Add All &Fields...'
      TabOrder = 3
      OnClick = BWizardClick
    end
  end
  inherited Panel1: TPanel
    TabOrder = 0
    inherited dxInspector: TdxInspector
      Visible = False
    end
    object dxDBInspector: TdxDBInspector
      Left = 26
      Top = 24
      Width = 177
      Height = 123
      DefaultFields = False
      DragMode = dmAutomatic
      TabOrder = 2
      OnClick = dxInspectorClick
      OnDragDrop = dxInspectorDragDrop
      OnDragOver = dxInspectorDragOver
      OnEnter = dxInspectorEnter
      DividerPos = 84
      OnChangeNode = dxInspectorChangeNode
    end
  end
  inherited PopupMenu: TPopupMenu
    object N2: TMenuItem
      Caption = '-'
    end
    object miAddAllFields: TMenuItem
      Caption = 'Add All &Fields'
      OnClick = BWizardClick
    end
  end
end
