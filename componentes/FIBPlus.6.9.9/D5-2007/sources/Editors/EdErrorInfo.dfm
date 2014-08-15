object frmErrors: TfrmErrors
  Left = 229
  Top = 175
  Caption = 'Edit Error Messages Table'
  ClientHeight = 446
  ClientWidth = 688
  Color = clBtnFace
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
  object Panel1: TPanel
    Left = 459
    Top = 0
    Width = 229
    Height = 446
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 354
      Width = 229
      Height = 92
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object btnCopyConstraints: TButton
        Left = 8
        Top = 57
        Width = 217
        Height = 25
        Hint = 'Copy constraint'
        Caption = '&Copy Constraints'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnCopyConstraintsClick
      end
      object chFilt: TCheckBox
        Left = 8
        Top = 33
        Width = 209
        Height = 17
        Caption = '&Filter by current constraint'
        TabOrder = 1
        OnClick = chFiltClick
      end
      object cmbKindObjs: TComboBox
        Left = 4
        Top = 5
        Width = 219
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbKindObjsChange
        Items.Strings = (
          'All'
          'PrimaryKeys'
          'UniqueConstraints '
          'ForeignKeys'
          'CheckConstraints'
          'UniqueIndices ')
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 229
      Height = 54
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object DBText1: TDBText
        Left = 60
        Top = 32
        Width = 50
        Height = 13
        AutoSize = True
        DataField = 'rdb$relation_name'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 5
        Top = 32
        Width = 50
        Height = 13
        Caption = 'On Table :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 5
        Top = 8
        Width = 28
        Height = 13
        Caption = 'Filter :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object EdFilter: TEdit
        Left = 40
        Top = 3
        Width = 182
        Height = 21
        Hint = 'FilterText'
        TabOrder = 0
        OnChange = EdFilterChange
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 54
      Width = 229
      Height = 300
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object sbDBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 229
        Height = 300
        Hint = 'List of Tables or Stored Procedures'
        Align = alClient
        DataSource = DataSource1
        Options = [dgColumnResize, dgRowSelect, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = sbDBGrid2DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'rdb$constraint_name'
            Visible = True
          end>
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 459
    Height = 446
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel5'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 459
      Height = 421
      Align = alClient
      DataSource = DataSource2
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CONSTRAINT_NAME'
          Width = 173
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MESSAGE_STRING'
          Title.Caption = 'MESSAGE'
          Width = 240
          Visible = True
        end>
    end
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 421
      Width = 459
      Height = 25
      DataSource = DataSource2
      Align = alBottom
      TabOrder = 1
    end
  end
  object qryConstraints: TpFIBDataSet
    SelectSQL.Strings = (
      'Select r.rdb$constraint_name,r.rdb$relation_name from'
      ' RDB$RELATION_CONSTRAINTS r'
      ''
      'where r.rdb$constraint_type =:T'
      'order by 1'
      '')
    Transaction = pFIBTransaction1
    OnFilterRecord = qryConstraintsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 397
    Top = 96
    poUseBooleanField = False
  end
  object pFIBTransaction1: TpFIBTransaction
    TimeoutAction = TACommitRetaining    
    Left = 392
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = qryConstraints
    OnDataChange = DataSource1DataChange
    Left = 400
    Top = 144
  end
  object qryErrorMessages: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE FIB$ERROR_MESSAGES SET '
      '    CONSTRAINT_NAME = :CONSTRAINT_NAME,'
      '    MESSAGE_STRING = :MESSAGE_STRING'
      ' WHERE     '
      '            CONSTRAINT_NAME = :OLD_CONSTRAINT_NAME'
      '    ')
    DeleteSQL.Strings = (
      'DELETE FROM '
      ' FIB$ERROR_MESSAGES '
      'WHERE     '
      '  CONSTRAINT_NAME = :OLD_CONSTRAINT_NAME'
      '    ')
    InsertSQL.Strings = (
      'INSERT INTO FIB$ERROR_MESSAGES('
      '    CONSTRAINT_NAME,'
      '    MESSAGE_STRING,'
      '    constr_type'
      ')'
      'VALUES('
      '    :CONSTRAINT_NAME,'
      '    :MESSAGE_STRING,'
      '    :constr_type'
      ')')
    RefreshSQL.Strings = (
      ' SELECT  CONSTRAINT_NAME, MESSAGE_STRING'
      ' FROM FIB$ERROR_MESSAGES M'
      ' WHERE(  M.constr_type = :T )'
      '    and ( (    '
      '            M.CONSTRAINT_NAME = :OLD_CONSTRAINT_NAME'
      '    ) )'
      '    '
      ''
      ''
      '')
    SelectSQL.Strings = (
      ' SELECT  CONSTRAINT_NAME, MESSAGE_STRING,constr_type'
      ' FROM FIB$ERROR_MESSAGES M'
      ' WHERE (M.constr_type = :T OR :T='#39'ALL  ERRORS'#39')'
      ''
      ''
      '')
    Transaction = pFIBTransaction1
    AutoCommit = True    
    OnFilterRecord = qryErrorMessagesFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 45
    Top = 40
    poUseBooleanField = False
  end
  object DataSource2: TDataSource
    DataSet = qryErrorMessages
    Left = 104
    Top = 40
  end
  object qryUniqueIndices: TpFIBDataSet
    SelectSQL.Strings = (
      'select'
      ' rdb$index_name rdb$constraint_name, rdb$relation_name'
      'from rdb$indices r'
      'where'
      
        ' rdb$unique_flag=1 and  (rdb$system_flag is null or rdb$system_f' +
        'lag=0)'
      ' and not exists'
      '  ('
      
        '   Select * from rdb$relation_constraints c where r.rdb$index_na' +
        'me=c.rdb$index_name'
      '  )'
      'order by 1')
    UpdateTransaction = pFIBTransaction1    
    OnFilterRecord = qryConstraintsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 397
    Top = 208
    poUseBooleanField = False
  end
  object qryAllErrors: TpFIBDataSet
    SelectSQL.Strings = (
      'select'
      ' rdb$index_name rdb$constraint_name, rdb$relation_name'
      'from rdb$indices r'
      'where'
      
        ' rdb$unique_flag=1 and  (rdb$system_flag is null or rdb$system_f' +
        'lag=0)'
      ' and not exists'
      '  ('
      
        '   Select * from rdb$relation_constraints c where r.rdb$index_na' +
        'me=c.rdb$index_name'
      '  )'
      'union'
      'Select r.rdb$constraint_name,r.rdb$relation_name from'
      ' RDB$RELATION_CONSTRAINTS r'
      ''
      ''
      'order by 1')
    UpdateTransaction = pFIBTransaction1    
    OnFilterRecord = qryConstraintsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    Left = 253
    Top = 232
    poUseBooleanField = False
  end
end
