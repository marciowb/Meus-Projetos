object frmEdDataSetInfo: TfrmEdDataSetInfo
  Left = 191
  Top = 114
  Width = 600
  Height = 366
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Choose DataSet information '
  Color = clBtnFace
  Constraints.MinHeight = 216
  Constraints.MinWidth = 358
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 219
    Top = 0
    Width = 3
    Height = 299
    Cursor = crHSplit
  end
  object PageControl1: TPageControl
    Left = 222
    Top = 0
    Width = 370
    Height = 299
    ActivePage = TabSheet2
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Select'
      ImageIndex = 1
    end
    object TabSheet4: TTabSheet
      Caption = 'Insert'
      ImageIndex = 3
    end
    object TabSheet3: TTabSheet
      Caption = 'Update'
      ImageIndex = 2
    end
    object TabSheet7: TTabSheet
      Caption = 'Delete'
      ImageIndex = 6
    end
    object TabSheet5: TTabSheet
      Caption = 'Refresh'
      ImageIndex = 4
    end
    object TabSheet6: TTabSheet
      Caption = 'AutoUpdate Options'
      ImageIndex = 5
      object Label1: TLabel
        Left = 6
        Top = 7
        Width = 49
        Height = 13
        Caption = 'Key Field :'
      end
      object Label2: TLabel
        Left = 6
        Top = 29
        Width = 50
        Height = 13
        Caption = 'Generator:'
      end
      object Label3: TLabel
        Left = 7
        Top = 52
        Width = 65
        Height = 13
        Caption = 'UpdateTable:'
      end
      object DBEdit1: TDBEdit
        Left = 97
        Top = 5
        Width = 258
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'KEY_FIELD'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object DBEdit2: TDBComboBox
        Left = 97
        Top = 25
        Width = 258
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'NAME_GENERATOR'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 97
        Top = 45
        Width = 258
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'UPDATE_TABLE_NAME'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object DBCheckBox1: TDBCheckBox
        Left = 7
        Top = 76
        Width = 195
        Height = 17
        Caption = 'UpdateOnlyModifiedFields'
        DataField = 'UPDATE_ONLY_MODIFIED_FIELDS'
        DataSource = DataSource1
        TabOrder = 3
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Conditions'
      ImageIndex = 7
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 299
    Width = 592
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 434
      Top = 3
      Width = 75
      Height = 27
      Anchors = [akRight]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 514
      Top = 3
      Width = 75
      Height = 27
      Anchors = [akRight]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = Button2Click
    end
    object btnSave: TButton
      Left = 6
      Top = 3
      Width = 75
      Height = 27
      Caption = '&Save'
      Enabled = False
      TabOrder = 2
      OnClick = btnSaveClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 219
    Height = 299
    Align = alLeft
    Caption = 'Panel2'
    TabOrder = 2
    OnResize = Panel2Resize
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 217
      Height = 38
      Align = alTop
      Caption = 'Filter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Edit1: TEdit
        Left = 4
        Top = 12
        Width = 205
        Height = 21
        Anchors = [akLeft, akRight]
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = Edit1Change
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 39
      Width = 217
      Height = 259
      Align = alClient
      DataSource = DataSource1
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DS_ID'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRIPTION'
          Width = 131
          Visible = True
        end>
    end
  end
  object trDSInfo: TpFIBTransaction
    TimeoutAction = TACommitRetaining    
    Left = 312
    Top = 152
  end
  object qryDSInfo: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE FIB$DATASETS_INFO SET '
      '    DESCRIPTION = ?DESCRIPTION,'
      '    SELECT_SQL = ?SELECT_SQL,'
      '    UPDATE_SQL = ?UPDATE_SQL,'
      '    INSERT_SQL = ?INSERT_SQL,'
      '    DELETE_SQL = ?DELETE_SQL,'
      '    REFRESH_SQL = ?REFRESH_SQL,'
      '    NAME_GENERATOR = ?NAME_GENERATOR,'
      '    KEY_FIELD = ?KEY_FIELD,'
      '    UPDATE_TABLE_NAME=?UPDATE_TABLE_NAME,'
      '    UPDATE_ONLY_MODIFIED_FIELDS=?UPDATE_ONLY_MODIFIED_FIELDS,'
      '    CONDITIONS=?CONDITIONS'
      ''
      ' WHERE     '
      '            DS_ID = ?DS_ID'
      '    ')
    DeleteSQL.Strings = (
      'DELETE FROM FIB$DATASETS_INFO'
      ' WHERE     '
      '            DS_ID = ?OLD_DS_ID'
      '    ')
    InsertSQL.Strings = (
      'INSERT INTO FIB$DATASETS_INFO('
      '    DS_ID,'
      '    DESCRIPTION,'
      '    SELECT_SQL,'
      '    UPDATE_SQL,'
      '    INSERT_SQL,'
      '    DELETE_SQL,'
      '    REFRESH_SQL,'
      '    NAME_GENERATOR,'
      '    KEY_FIELD,'
      '    UPDATE_TABLE_NAME,'
      '    UPDATE_ONLY_MODIFIED_FIELDS,'
      '    CONDITIONS'
      ')'
      'VALUES('
      '    ?DS_ID,'
      '    ?DESCRIPTION,'
      '    ?SELECT_SQL,'
      '    ?UPDATE_SQL,'
      '    ?INSERT_SQL,'
      '    ?DELETE_SQL,'
      '    ?REFRESH_SQL,'
      '    ?NAME_GENERATOR,'
      '    ?KEY_FIELD,'
      '    ?UPDATE_TABLE_NAME,'
      '    ?UPDATE_ONLY_MODIFIED_FIELDS,'
      '    ?CONDITIONS'
      ')')
    RefreshSQL.Strings = (
      'SELECT'
      '    FIB.DS_ID,'
      '    FIB.DESCRIPTION,'
      '    FIB.SELECT_SQL,'
      '    FIB.UPDATE_SQL,'
      '    FIB.INSERT_SQL,'
      '    FIB.DELETE_SQL,'
      '    FIB.REFRESH_SQL,'
      '    FIB.NAME_GENERATOR,'
      '    FIB.KEY_FIELD,'
      '    FIB.UPDATE_TABLE_NAME,'
      '    FIB.UPDATE_ONLY_MODIFIED_FIELDS,'
      '    FIB.CONDITIONS'
      ''
      'FROM'
      '    FIB$DATASETS_INFO FIB'
      ' WHERE '
      '    (    '
      '            FIB.DS_ID = ?OLD_DS_ID'
      '    )')
    SelectSQL.Strings = (
      'SELECT'
      '    FIB.DS_ID,'
      '    FIB.DESCRIPTION,'
      '    FIB.SELECT_SQL,'
      '    FIB.UPDATE_SQL,'
      '    FIB.INSERT_SQL,'
      '    FIB.DELETE_SQL,'
      '    FIB.REFRESH_SQL,'
      '    FIB.NAME_GENERATOR,'
      '    FIB.KEY_FIELD,'
      '    FIB.UPDATE_TABLE_NAME,'
      '    FIB.UPDATE_ONLY_MODIFIED_FIELDS,'
      '    FIB.CONDITIONS,'
      '    FIB.FIB$VERSION'
      'FROM'
      '    FIB$DATASETS_INFO FIB'
      'ORDER BY 1')
    AutoUpdateOptions.UpdateTableName = 'FIB$DATASETS_INFO'
    AutoUpdateOptions.KeyFields = 'DS_ID'
    AfterDelete = qryDSInfoAfterDelete
    AfterEdit = qryDSInfoAfterInsert
    AfterInsert = qryDSInfoAfterInsert
    AfterScroll = qryDSInfoAfterScroll
    BeforeScroll = qryDSInfoBeforeScroll
    OnNewRecord = qryDSInfoNewRecord
    Transaction = trDSInfo    
    OnFilterRecord = qryDSInfoFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 272
    Top = 152
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    poAskRecordCount = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object DataSource1: TDataSource
    DataSet = qryDSInfo
    Left = 184
    Top = 152
  end
  object qryGenerators: TpFIBDataSet
    DeleteSQL.Strings = (
      ''
      '    ')
    SelectSQL.Strings = (
      'SELECT'
      '    RDB$GENERATOR_NAME'
      'FROM'
      '    RDB$GENERATORS'
      'WHERE RDB$SYSTEM_FLAG IS NULL or RDB$SYSTEM_FLAG <>1'
      'ORDER BY 1')
    Transaction = trDSInfo    
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 272
    Top = 200
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    poAskRecordCount = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
end
