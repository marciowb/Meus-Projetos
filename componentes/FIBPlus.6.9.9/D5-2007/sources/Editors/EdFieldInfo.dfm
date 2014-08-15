object frmFields: TfrmFields
  Left = 41
  Top = 183
  Width = 680
  Height = 455
  Caption = 's'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 446
    Top = 0
    Width = 226
    Height = 428
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 336
      Width = 226
      Height = 92
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object btnCopyFields: TButton
        Left = 8
        Top = 57
        Width = 200
        Height = 25
        Hint = 'Copy fields from current metaobject'
        Caption = '&Copy Fields'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnCopyFieldsClick
      end
      object chFilt: TCheckBox
        Left = 8
        Top = 33
        Width = 192
        Height = 17
        Caption = '&Filter by current metaobject'
        TabOrder = 1
        OnClick = chFiltClick
      end
      object cmbKindObjs: TComboBox
        Left = 8
        Top = 5
        Width = 201
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbKindObjsChange
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 226
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      OnResize = Panel3Resize
      object EdFilter: TEdit
        Left = 2
        Top = 3
        Width = 217
        Height = 21
        Hint = 'FilterText'
        TabOrder = 0
        OnChange = EdFilterChange
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 25
      Width = 226
      Height = 311
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object sbDBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 226
        Height = 311
        Hint = 'List of Tables or Stored Procedures'
        Align = alClient
        DataSource = DataSource2
        Options = [dgColumnResize, dgRowSelect, dgCancelOnExit]
        PopupMenu = PopupMenu1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = btnCopyFieldsClick
        Columns = <
          item
            Expanded = False
            FieldName = 'RDB$RELATION_NAME'
            Width = 185
            Visible = True
          end>
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 446
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Caption = 'Panel5'
    TabOrder = 1
    object sbDBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 444
      Height = 426
      Align = alClient
      DataSource = DataSource1
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object pFIBTransaction1: TpFIBTransaction
    TimeoutAction = TACommitRetaining
    Left = 48
    Top = 232
  end
  object qryFL: TpFIBDataSet
    DeleteSQL.Strings = (
      'DELETE FROM FIB$FIELDS_INFO'
      ' WHERE     '
      '            TABLE_NAME = ?OLD_TABLE_NAME'
      '     and FIELD_NAME = ?OLD_FIELD_NAME'
      '    ')
    SelectSQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      '    FIB$FIELDS_INFO '
      'ORDER BY TABLE_NAME,FIELD_NAME')
    AutoUpdateOptions.UpdateTableName = 'FIB$FIELDS_INFO'
    AutoUpdateOptions.KeyFields = 'TABLE_NAME;FIELD_NAME'
    AutoUpdateOptions.AutoReWriteSqls = True
    AutoUpdateOptions.GeneratorName = 'GEN_FIB$FIELDS_INFO'
    AfterDelete = qryFLAfterPost
    AfterOpen = qryFLAfterOpen
    AfterPost = qryFLAfterPost
    BeforeClose = qryFLBeforeClose
    OnNewRecord = qryFLNewRecord
    Transaction = pFIBTransaction1
    OnFilterRecord = qryFLFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 168
    Top = 216
  end
  object DataSource1: TDataSource
    DataSet = qryFL
    Left = 88
    Top = 296
  end
  object qryTabs: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT '
      ' CAST('#39'ALIAS'#39' AS CHAR( @@FIELD_LENGTH@ )) AS RDB$RELATION_NAME '
      'FROM '
      ' RDB$DATABASE'
      'UNION'
      'SELECT '
      ' RDB$RELATION_NAME'
      'FROM RDB$RELATIONS'
      'WHERE '
      ' RDB$FLAGS = 1'
      'ORDER BY 1')
    Transaction = pFIBTransaction1
    OnFilterRecord = qrySPsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 168
    Top = 280
    poUseBooleanField = False
    poImportDefaultValues = False
    poGetOrderInfo = False
  end
  object DataSource2: TDataSource
    DataSet = qryTabs
    OnDataChange = DataSource2DataChange
    Left = 312
    Top = 224
  end
  object qryTabFields: TpFIBDataSet
    SelectSQL.Strings = (
      ' Select RDB$FIELD_NAME from  RDB$RELATION_FIELDS'
      ' where  RDB$RELATION_NAME=?tabName'
      'order by RDB$FIELD_POSITION'
      '')
    BeforeOpen = qryTabFieldsBeforeOpen
    Transaction = pFIBTransaction1
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 317
    Top = 272
    poUseBooleanField = False
  end
  object qrySPs: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT '
      ' CAST('#39'ALIAS'#39' AS CHAR(@@FIELD_LENGTH@)) AS RDB$RELATION_NAME '
      'FROM '
      ' RDB$DATABASE'
      'UNION'
      'SELECT  '
      ' RDB$PROCEDURE_NAME RDB$RELATION_NAME'
      'FROM  RDB$PROCEDURES'
      'ORDER BY 1'
      ''
      ''
      '')
    Transaction = pFIBTransaction1
    OnFilterRecord = qrySPsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 421
    Top = 64
    poUseBooleanField = False
  end
  object PopupMenu1: TPopupMenu
    Left = 424
    Top = 136
    object miTables1: TMenuItem
      Caption = 'Tables'
      Checked = True
      OnClick = miProcedures1Click
    end
    object miProcedures1: TMenuItem
      Caption = 'Procedures'
      OnClick = miProcedures1Click
    end
    object miUserForms: TMenuItem
      Caption = 'User Forms'
      Visible = False
      OnClick = miProcedures1Click
    end
  end
  object qrySPFields: TpFIBDataSet
    SelectSQL.Strings = (
      'select RDB$PARAMETER_NAME,'
      'RDB$PARAMETER_NUMBER,'
      'RDB$PARAMETER_TYPE'
      ' from RDB$PROCEDURE_PARAMETERS'
      'WHERE RDB$PROCEDURE_NAME=?PN'
      '              AND RDB$PARAMETER_TYPE=1'
      ''
      ''
      '')
    BeforeOpen = qrySPFieldsBeforeOpen
    Transaction = pFIBTransaction1
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 421
    Top = 224
    poUseBooleanField = False
  end
end
