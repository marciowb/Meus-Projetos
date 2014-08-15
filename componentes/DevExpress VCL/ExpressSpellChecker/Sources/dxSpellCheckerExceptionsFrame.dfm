object frmSpellCheckerExceptions: TfrmSpellCheckerExceptions
  Left = 0
  Top = 0
  Width = 320
  Height = 169
  AutoScroll = False
  TabOrder = 0
  object lbxList: TcxListBox
    Left = 8
    Top = 27
    Width = 211
    Height = 110
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    Style.TransparentBorder = False
    TabOrder = 0
    OnClick = lbxListClick
  end
  object teCandidate: TcxTextEdit
    Left = 8
    Top = 8
    Anchors = [akLeft, akTop, akRight]
    Properties.OnChange = teCandidatePropertiesEditValueChanged
    Style.TransparentBorder = False
    TabOrder = 1
    OnKeyDown = teCandidateKeyDown
    Width = 211
  end
  object btnAdd: TcxButton
    Left = 227
    Top = 8
    Width = 85
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'btnAdd'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnDelete: TcxButton
    Left = 227
    Top = 34
    Width = 85
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'btnDelete'
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object cbAutoInclude: TcxCheckBox
    Left = 8
    Top = 144
    Anchors = [akLeft, akBottom]
    Caption = 'cbAutoInclude'
    Style.TransparentBorder = False
    TabOrder = 4
    Transparent = True
    Width = 305
  end
end
