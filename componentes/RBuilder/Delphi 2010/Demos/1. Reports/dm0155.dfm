object frm0155: Tfrm0155
  Left = 270
  Top = 152
  Width = 656
  Height = 908
  Caption = 'DB Archive Reader'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 465
    Width = 648
    Height = 5
    Cursor = crVSplit
    Align = alTop
    Constraints.MaxHeight = 5
    Constraints.MinHeight = 5
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 648
    Height = 465
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    DesignSize = (
      648
      465)
    object Label1: TLabel
      Left = 12
      Top = 69
      Width = 96
      Height = 13
      Caption = 'Report Archive Files'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 622
      Top = 22
      Width = 20
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object Label3: TLabel
      Left = 344
      Top = 71
      Width = 288
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Double click individual archives to load them to the database'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 89
      Top = 420
      Width = 230
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = '<-Transfer all selected archive files to database'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 11
      Top = 4
      Width = 137
      Height = 13
      Caption = 'Locate Archive File Directory'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object flbArchiveFileList: TFileListBox
      Left = 8
      Top = 84
      Width = 631
      Height = 324
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Mask = '*.raf'
      MultiSelect = True
      TabOrder = 1
      OnDblClick = flbArchiveFileListDblClick
    end
    object edtDirectory: TEdit
      Left = 8
      Top = 22
      Width = 615
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object btnPrintToArchive: TButton
      Left = 11
      Top = 416
      Width = 75
      Height = 24
      Anchors = [akLeft, akBottom]
      Caption = 'Copy All'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnPrintToArchiveClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 470
    Width = 648
    Height = 411
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    DesignSize = (
      648
      411)
    object Label2: TLabel
      Left = 9
      Top = 16
      Width = 126
      Height = 13
      Caption = 'Database Report Archives'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dbgArchiveRecords: TDBGrid
      Left = 8
      Top = 32
      Width = 631
      Height = 347
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsArchive
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbgArchiveRecordsCellClick
      OnDblClick = dbgArchiveRecordsDblClick
    end
    object btnEmptyDB: TButton
      Left = 9
      Top = 381
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Empty DB'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnEmptyDBClick
    end
    object btnPreview: TButton
      Left = 565
      Top = 382
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Preview'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnPreviewClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Archive Reports (*.raf)|*.raf'
    InitialDir = 'C:\Program Files\Borland\Delphi 6\RBuilder\Demos\1. Reports'
    Left = 337
    Top = 647
  end
  object dbArchive: TDatabase
    DatabaseName = 'dbArchive'
    DriverName = 'STANDARD'
    LoginPrompt = False
    Params.Strings = (
      'PATH='
      'DEFAULT DRIVER=PARADOX'
      'ENABLE BCD=FALSE')
    SessionName = 'Default'
    Left = 380
    Top = 645
  end
  object tblArchive: TTable
    DatabaseName = 'dbArchive'
    TableName = 'ArchiveItems.db'
    Left = 383
    Top = 695
  end
  object dsArchive: TDataSource
    DataSet = tblArchive
    Left = 381
    Top = 735
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = dsArchive
    UserName = 'DBPipeline1'
    Left = 384
    Top = 768
  end
  object ppDBArchiveReader1: TppDBArchiveReader
    DeviceType = 'Screen'
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zsPercentage
    SuppressOutline = False
    DatabaseSettings.DataPipeline = ppDBPipeline1
    DatabaseSettings.NameField = 'Name'
    DatabaseSettings.BLOBField = 'Archive'
    Left = 384
    Top = 808
    Version = '7.0'
  end
end
