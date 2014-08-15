object fmObjectInspector: TfmObjectInspector
  Left = 640
  Top = 0
  ActiveControl = IDEInspector
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Object Inspector'
  ClientHeight = 463
  ClientWidth = 239
  Color = clBtnFace
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl1: TTabControl
    Left = 0
    Top = 26
    Width = 239
    Height = 437
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      'Properties'
      'Events')
    TabIndex = 0
    OnChange = TabControl1Change
    object IDEInspector: TIDEInspector
      Left = 4
      Top = 24
      Width = 231
      Height = 409
      Align = alClient
      BorderStyle = bsNone
      ParentColor = True
      TabOrder = 0
      OnUpdate = IDEInspectorUpdate
    end
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 239
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    OnResize = TopPanelResize
    object IDEComponentCombo: TIDEComponentComboBox
      Left = 2
      Top = 3
      Width = 208
      Height = 21
      Sorted = True
      TabOrder = 0
    end
  end
end
