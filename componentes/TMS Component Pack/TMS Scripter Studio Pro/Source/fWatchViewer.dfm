object fmWatchViewer: TfmWatchViewer
  Left = 286
  Top = 186
  Width = 449
  Height = 136
  BorderStyle = bsSizeToolWin
  Caption = 'ScripterStudio - Watch List'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object List: TListBox
    Left = 0
    Top = 0
    Width = 441
    Height = 102
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = ListDblClick
    OnKeyDown = ListKeyDown
  end
end
