inherited frmVerificaUpdate: TfrmVerificaUpdate
  Caption = 'Aquarios Update'
  ClientHeight = 184
  ClientWidth = 466
  ExplicitWidth = 482
  ExplicitHeight = 222
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGeral: TPanel
    Left = 0
    Top = 116
    Width = 466
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btnVerificar: TBitBtn
      Left = 248
      Top = 9
      Width = 123
      Height = 25
      Caption = 'Verificar'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnVerificarClick
    end
    object BitBtn2: TBitBtn
      Left = 377
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Sair'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object btnInstalar: TBitBtn
      Left = 8
      Top = 9
      Width = 97
      Height = 25
      Caption = 'Instalar'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnClick = btnInstalarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 466
    Height = 116
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 0
      Top = 0
      Width = 466
      Height = 116
      Align = alClient
      TabOrder = 0
      object TvArquivos: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = DataArquivos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object TvArquivosNomeArquivo: TcxGridDBColumn
          Caption = 'Arquivo'
          DataBinding.FieldName = 'NomeArquivo'
          Width = 369
        end
        object TvArquivosTamanho: TcxGridDBColumn
          Caption = 'Tamanho (MB)'
          DataBinding.FieldName = 'Tamanho'
          Width = 93
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = TvArquivos
      end
    end
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 157
    Width = 466
    Height = 27
    Align = alBottom
    BevelKind = bkSoft
    TabOrder = 2
    Visible = False
    object lblStatus: TLabel
      Left = 1
      Top = 1
      Width = 41
      Height = 13
      Align = alClient
      Caption = 'lblStatus'
      WordWrap = True
    end
    object Panel4: TPanel
      Left = 232
      Top = 1
      Width = 229
      Height = 21
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object ProgressBar: TcxProgressBar
        Left = 0
        Top = 0
        Align = alClient
        TabOrder = 0
        Width = 229
      end
    end
  end
  object DataArquivos: TDataSource
    DataSet = CdsArquivos
    Left = 216
    Top = 48
  end
  object CdsArquivos: TpFIBClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Endereco'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'NomeArquivo'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'Tamanho'
        DataType = ftInteger
      end
      item
        Name = 'FlagDownload'
        DataType = ftBoolean
      end
      item
        Name = 'TamanhoReal'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 48
    Data = {
      900000009619E0BD010000001800000005000000000003000000900008456E64
      657265636F020049000000010005574944544802000200F4010B4E6F6D654172
      717569766F010049000000010005574944544802000200C8000754616D616E68
      6F04000100000000000C466C6167446F776E6C6F616402000300000000000B54
      616D616E686F5265616C04000100000000000000}
    object CdsArquivosEndereco: TStringField
      FieldName = 'Endereco'
      Size = 500
    end
    object CdsArquivosNomeArquivo: TStringField
      FieldName = 'NomeArquivo'
      Size = 200
    end
    object CdsArquivosTamanho: TIntegerField
      FieldName = 'Tamanho'
    end
    object CdsArquivosFlagDownload: TBooleanField
      FieldName = 'FlagDownload'
    end
    object CdsArquivosTamanhoReal: TIntegerField
      FieldName = 'TamanhoReal'
    end
  end
  object FTP: TIdFTP
    OnWork = FTPWork
    IPVersion = Id_IPv4
    AutoLogin = True
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 56
    Top = 32
  end
  object UnZip: TVCLUnZip
    ThisReleaseLevel = 'Release'
    RecreateDirs = True
    OverwriteMode = Always
    OnStartUnZip = UnZipStartUnZip
    Left = 48
    Top = 88
  end
end
