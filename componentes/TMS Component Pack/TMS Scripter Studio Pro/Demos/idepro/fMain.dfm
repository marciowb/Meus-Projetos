object Form1: TForm1
  Left = 392
  Top = 170
  Width = 503
  Height = 287
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object IDEDialog1: TIDEDialog
    Engine = IDEEngine1
    Title = 'Scripter Studio Pro IDE Demo - %s'
    IDECloseAction = icaCloseAll
    Left = 8
    Top = 8
  end
  object IDEScripter1: TIDEScripter
    DefaultLanguage = slPascal
    SourceCode.Strings = (
      'var A, B: string;'
      'begin'
      '  A := '#39'Hello, '#39';'
      '  B := '#39'World!'#39';'
      '  ShowMessage(A + B);'
      'end;')
    SaveCompiledCode = False
    ShortBooleanEval = True
    LibOptions.SearchPath.Strings = (
      '$(CURDIR)'
      '$(APPDIR)')
    LibOptions.UseScriptFiles = False
    CallExecHookEvent = False
    Left = 8
    Top = 40
  end
  object IDEEngine1: TIDEEngine
    Scripter = IDEScripter1
    Options.AutoHideTabControl = True
    FileExtPascalUnit = '.psc'
    FileExtForm = '.sfm'
    FileExtBasicUnit = '.bsc'
    AutoStyler = True
    Left = 8
    Top = 72
  end
  object PopupMenu1: TPopupMenu
    Left = 96
    Top = 80
    object TMSScripterStudioProWebSite1: TMenuItem
      Caption = 'TMS Scripter Studio Pro - Web Site'
      OnClick = TMSScripterStudioProWebSite1Click
    end
    object TMSScripterStudioProSupport1: TMenuItem
      Caption = 'TMS Scripter Studio Pro - Support'
      OnClick = TMSScripterStudioProSupport1Click
    end
    object TMSScripterStudioPro1: TMenuItem
      Caption = '-'
    end
    object TMSSoftwareWebSite1: TMenuItem
      Caption = 'TMS Software Home'
      OnClick = TMSSoftwareWebSite1Click
    end
    object ContactUsemail1: TMenuItem
      Caption = 'Contact Us (e-mail)'
      OnClick = ContactUsemail1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object About1: TMenuItem
      Caption = 'About...'
      OnClick = About1Click
    end
  end
end
