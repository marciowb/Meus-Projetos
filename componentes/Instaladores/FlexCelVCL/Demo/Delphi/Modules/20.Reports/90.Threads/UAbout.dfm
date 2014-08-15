object About: TAbout
  Left = 191
  Top = 104
  Caption = 'Help'
  ClientHeight = 448
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelCommand: TPanel
    Left = 0
    Top = 0
    Width = 444
    Height = 25
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'About the Thread Demo'
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 0
    Top = 25
    Width = 444
    Height = 423
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      'This demo shows how to run FlexCel in separate threads.'
      ''
      'Each time you press the "New Report" button, a new report is '
      'generated, and added to the '
      
        'report list. You can cancel a running report by clicking on "Can' +
        'cel"'
      ''
      'Reports are created so they are big and they take some time to '
      'process, they don'#39't make '
      'any sense. They are automatically deleted after being generated.'
      ''
      
        'Sometimes you can get a "Share violation" error, this is because' +
        ' '
      'the file already exists.'
      ''
      
        'Note that we can'#39't really use BDE for multithreading, as it will' +
        ' '
      'complain '
      
        'about being "out of memory" as soon as you start having more tha' +
        'n '
      
        'a couple of threads in parallel. For this reason, we copy the da' +
        'ta to'
      'memory tables, and then use those memory tables to create the '
      'reports.'
      'THIS IS NOT something you would normally have to do, most '
      'database'
      'engines work fine in multithreaded environments.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
end
