object fSQLEdit: TfSQLEdit
  Left = 0
  Top = 0
  Width = 777
  Height = 456
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  object Splitter2: TSplitter
    Left = 527
    Top = 0
    Width = 3
    Height = 456
    Cursor = crHSplit
    Align = alRight
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 456
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object splPlan: TSplitter
      Left = 1
      Top = 452
      Width = 525
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      Visible = False
    end
    object Panel10: TPanel
      Left = 1
      Top = 1
      Width = 525
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      OnResize = Panel10Resize
      object SpeedButton1: TSpeedButton
        Left = 1
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Change Font'
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888888888888888888444488844444488887488888744
          7888888448888744888888874888844788888888444444488888888874884478
          8888888884484488888888888744478888888888884448888888888888747888
          8888888888848888888888888888888888888888888888888888}
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 24
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Find in SQL text'
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888800000888880000080F000888880F00080F000888880F
          0008000000080000000800F000000F00000800F000800F00000800F000800F00
          00088000000000000088880F00080F0008888800000800000888888000888000
          88888880F08880F0888888800088800088888888888888888888}
        OnClick = SpeedButton2Click
      end
      object btnCheck: TSpeedButton
        Left = 47
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Check SQL'
        Flat = True
        Glyph.Data = {
          6E020000424D6E0200000000000076000000280000002A000000150000000100
          040000000000F8010000CE0E0000C40E00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777777770000007777777777777777777777777777
          777777777777770000007777778888888888777777777FFFFFFFFFFF77777700
          000077780000000000087777777788888888888F7777770000007778FFFFFFFF
          FF08777777778F7777FF778F7777770000007778FFFFFF00FF08777777778F77
          7F88F78F7777770000007778FFFFF0000F08777777778F77F8888F8F77777700
          00007778FFFF80000F88777777778F7F88888F877777770000007778FFF80000
          0008777777778F78888888F77777770000007778FFF000F00008777777778F78
          887888F77777770000007778FFF00FFF0008777777778F78877788FF77777700
          00007778FFFFFFFF0008777777778F777777788F7777770000007778FFFFFFF8
          7000777777778F7777777888F777770000007778FFFFFFF8FF00877777778F77
          77778788F777770000007778FFFFFFF8F880077777778F7777778F888F777700
          00007778FFFFFFF88770087777778FFFFFF7887788F777000000777888888888
          777700777777888888888777788F770000007777777777777777707777777777
          77777777778F7700000077777777777777777777777777777777777777777700
          0000777777777777777777777777777777777777777777000000777777777777
          777777777777777777777777777777000000}
        NumGlyphs = 2
        OnClick = btnCheckClick
      end
      object btnGenSQL: TSpeedButton
        Left = 381
        Top = 1
        Width = 94
        Height = 22
        Caption = 'Generate SQL'
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          88888888888888888888888888888887178800000000088111880FFFFFFF0887
          17880F77777F088888880F7FFF7F088818880F77777F088717880FFFFFFF0881
          11880F77888F088111880FFFF000088111880F778080888111880FFFF0088881
          1188000000888881118888888888888818888888888888888888}
        OnClick = btnGenSQLClick
      end
      object btnReplaceZv: TSpeedButton
        Left = 70
        Top = 0
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888888888888888888888888888888888888888808888
          8888888808808808888888888080808888888888880008888888888000000000
          8888888888000888888888888080808888888888088088088888888888808888
          8888080888888888080808088888888808080808888888880808}
        OnClick = btnReplaceZvClick
      end
      object btnShowInCodeEditor: TSpeedButton
        Left = 93
        Top = 0
        Width = 23
        Height = 22
        Hint = 'To Code Editor'
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888800000000008888880FFFFFFFF08888880FFFFFFFF084
          88880F777777F04444880F7FFFF7F08488480F7FFFF7F08888480F777777F088
          88480FFFFFFFF08888880FFFFF00008000000FFFFF0F0880FFF00FFFFF008880
          FFF0000000088880F000888888888880F0088888888888800088}
        OnClick = btnShowInCodeEditorClick
      end
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 433
      Width = 525
      Height = 19
      Panels = <
        item
          Width = 80
        end
        item
          Width = 50
        end>
      SimplePanel = False
    end
  end
  object Panel6: TPanel
    Left = 530
    Top = 0
    Width = 247
    Height = 456
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object Panel7: TGroupBox
      Left = 0
      Top = 0
      Width = 247
      Height = 68
      Align = alTop
      Caption = 'Generate options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 3
        Top = 17
        Width = 58
        Height = 13
        Caption = 'SQL Kind:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 140
        Top = 17
        Width = 67
        Height = 13
        Caption = 'ParamSymbol:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LbTableSyn: TCheckBox
        Left = 5
        Top = 51
        Width = 90
        Height = 13
        Caption = 'Use table alias'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object chReplaceSQL: TCheckBox
        Left = 5
        Top = 34
        Width = 84
        Height = 17
        Caption = '&Replace SQL'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
      end
      object chOnlySelFields: TCheckBox
        Left = 100
        Top = 34
        Width = 140
        Height = 17
        Caption = 'Use Selected Fields Only '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object cmbKindSQL: TComboBox
        Left = 61
        Top = 12
        Width = 79
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        Items.Strings = (
          'Select'
          'Insert'
          'Update'
          'Delete'
          'Execute')
      end
      object cmbParamSymbol: TComboBox
        Left = 208
        Top = 12
        Width = 36
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbParamSymbolChange
        Items.Strings = (
          ':'
          '?')
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 68
      Width = 247
      Height = 388
      Align = alClient
      Caption = 'Database objects'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Panel2: TPanel
        Left = 2
        Top = 62
        Width = 243
        Height = 324
        Align = alClient
        Caption = 'Panel2'
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 1
          Top = 89
          Width = 241
          Height = 4
          Cursor = crVSplit
          Align = alTop
        end
        object DBGrid1: TDBGrid
          Left = 1
          Top = 1
          Width = 241
          Height = 88
          Align = alTop
          Color = clBtnFace
          DataSource = ds
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgAlwaysShowSelection]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = DBGrid1DblClick
          OnKeyDown = DBGrid1KeyDown
          OnMouseMove = DBGrid1MouseMove
          Columns = <
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = 'Tables'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 193
              Visible = True
            end>
        end
        object DBGrid2: TDBGrid
          Left = 1
          Top = 93
          Width = 241
          Height = 139
          Align = alClient
          Color = clBtnFace
          DataSource = dsFields
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgAlwaysShowSelection, dgCancelOnExit, dgMultiSelect]
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnMouseMove = DBGrid1MouseMove
          Columns = <
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Caption = 'Fields:'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clBlack
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 193
              Visible = True
            end>
        end
        object Panel4: TPanel
          Left = 1
          Top = 232
          Width = 241
          Height = 91
          Align = alBottom
          BorderStyle = bsSingle
          TabOrder = 2
          object Label3: TLabel
            Left = 8
            Top = 12
            Width = 43
            Height = 13
            Caption = 'Domain'
            FocusControl = edDomain
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 8
            Top = 40
            Width = 60
            Height = 13
            Caption = 'Field Type'
            FocusControl = edDomain
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edDomain: TDBEdit
            Left = 64
            Top = 8
            Width = 165
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            DataField = 'DOMAIN_NAME'
            DataSource = dsFields
            TabOrder = 0
          end
          object edFieldType: TEdit
            Left = 72
            Top = 35
            Width = 157
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ReadOnly = True
            TabOrder = 1
          end
          object chNotNull: TDBCheckBox
            Left = 8
            Top = 64
            Width = 97
            Height = 17
            Caption = 'Not NULL'
            DataField = 'rdb$null_flag'
            DataSource = dsFields
            TabOrder = 2
            ValueChecked = '1'
            ValueUnchecked = 'False'
          end
        end
      end
      object Panel3: TPanel
        Left = 2
        Top = 15
        Width = 243
        Height = 47
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        OnResize = Panel7Resize
        object Label4: TLabel
          Left = 4
          Top = 2
          Width = 65
          Height = 13
          Caption = 'Filter by name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Edit1: TEdit
          Left = 98
          Top = 0
          Width = 141
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = Edit1Change
        end
        object cmbTabsNameViews: TComboBox
          Left = 2
          Top = 23
          Width = 238
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ItemHeight = 13
          ParentFont = False
          TabOrder = 1
          OnChange = cmbTabsNameViewsChange
        end
      end
    end
  end
  object qryAllTables: TpFIBDataSet
    SelectSQL.Strings = (
      'select RDB$RELATION_NAME AS NAME'
      ' from RDB$RELATIONS'
      ' where RDB$FLAGS = 1'
      ''
      'order by 1'
      ''
      '')    
    Filtered = True
    OnFilterRecord = qrySPsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    DefaultFormats.DisplayFormatDate = 'dd.mm.YYYY'
    Left = 93
    Top = 178
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    poAskRecordCount = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object qrySPs: TpFIBDataSet
    SelectSQL.Strings = (
      'select RDB$PROCEDURE_NAME AS NAME'
      ' from RDB$PROCEDURES'
      'order by 1')    
    Filtered = True
    OnFilterRecord = qrySPsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    DefaultFormats.DisplayFormatDate = 'dd.mm.YYYY'
    Left = 93
    Top = 130
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    poAskRecordCount = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object ds: TDataSource
    DataSet = qryAllTables
    Left = 228
    Top = 120
  end
  object trTransaction: TpFIBTransaction
    TimeoutAction = TARollback    
    Left = 88
    Top = 232
  end
  object qryTabFields: TpFIBDataSet
    SelectSQL.Strings = (
      ' Select RF.rdb$field_name NAME, F.rdb$field_name DOMAIN_NAME,'
      ' F.rdb$field_type,F.rdb$field_length,F.rdb$null_flag'
      ' ,F.rdb$field_scale,F.rdb$field_sub_type'
      '  ,@@PREC%0 rdb$field_precision@'
      ' from  RDB$RELATION_FIELDS RF'
      ' join rdb$fields F on RF.rdb$field_source=F.rdb$field_name'
      ' where  RDB$RELATION_NAME=?NAME'
      ''
      'order by RDB$FIELD_POSITION')
    AfterScroll = qryTabFieldsAfterScroll
    BeforeOpen = qryTabFieldsBeforeOpen
    DataSource = ds    
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    DefaultFormats.DisplayFormatDate = 'dd.mm.YYYY'
    Left = 309
    Top = 235
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object qrySPparams: TpFIBDataSet
    SelectSQL.Strings = (
      'select RDB$PARAMETER_NAME,'
      'RDB$PARAMETER_NUMBER,'
      'RDB$PARAMETER_TYPE'
      ' from RDB$PROCEDURE_PARAMETERS'
      'WHERE RDB$PROCEDURE_NAME=?NAME'
      'order by 3 DESC ,2 ')    
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    DefaultFormats.DisplayFormatDate = 'dd.mm.YYYY'
    Left = 309
    Top = 179
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    poAskRecordCount = True
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsStrikeOut]
    MinFontSize = 0
    MaxFontSize = 0
    Left = 32
    Top = 72
  end
  object FindDialog1: TFindDialog
    Options = [frDown, frMatchCase, frDisableMatchCase, frDisableUpDown, frDisableWholeWord]
    OnFind = FindDialog1Find
    Left = 260
    Top = 248
  end
  object dsFields: TDataSource
    DataSet = qryTabFields
    Left = 360
    Top = 232
  end
  object qrySPFields: TpFIBDataSet
    SelectSQL.Strings = (
      'select'
      '  RDB$PARAMETER_NAME NAME,'
      
        '  F.rdb$field_name DOMAIN_NAME,F.rdb$null_flag,F.rdb$field_type,' +
        'F.rdb$field_length,'
      
        '  F.rdb$field_scale,  F.rdb$field_sub_type, 0 rdb$field_precisio' +
        'n'
      'from'
      '  RDB$PROCEDURE_PARAMETERS RF'
      ' join rdb$fields F on RF.rdb$field_source=F.rdb$field_name'
      'WHERE RDB$PROCEDURE_NAME=?NAME and'
      ' RDB$PARAMETER_TYPE=1'
      'order BY RDB$PARAMETER_NUMBER'
      ' ')
    AfterOpen = qrySPFieldsAfterOpen
    AfterScroll = qryTabFieldsAfterScroll
    DataSource = ds    
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    DefaultFormats.DisplayFormatDate = 'dd.mm.YYYY'
    Left = 381
    Top = 179
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object menuPlan: TPopupMenu
    Left = 160
    Top = 264
    object miHidePlan: TMenuItem
      Caption = 'Hide plan window'
      OnClick = miHidePlanClick
    end
  end
  object qryTabFields1: TpFIBDataSet
    SelectSQL.Strings = (
      'Select '
      ' RDB$FIELD_NAME NAME from  RDB$RELATION_FIELDS'
      'where  '
      ' RDB$RELATION_NAME=?NAME'
      'union '
      'select'
      '  RDB$PARAMETER_NAME NAME'
      'from'
      '  RDB$PROCEDURE_PARAMETERS'
      'WHERE'
      ' RDB$PROCEDURE_NAME=?NAME and RDB$PARAMETER_TYPE=1'
      'order BY 1')
    BeforeOpen = qryTabFieldsBeforeOpen    
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    DefaultFormats.DisplayFormatDate = 'dd.mm.YYYY'
    Left = 309
    Top = 299
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    poAskRecordCount = True
    WaitEndMasterScroll = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object qryAllTables1: TpFIBDataSet
    SelectSQL.Strings = (
      'select RDB$RELATION_NAME AS NAME, 0 T'
      ' from RDB$RELATIONS R'
      ' where RDB$FLAGS = 1 and RDB$VIEW_BLR IS NULL'
      'union'
      'select RDB$RELATION_NAME AS NAME, 1 T'
      ' from RDB$RELATIONS R'
      ' where RDB$FLAGS = 1 and NOT RDB$VIEW_BLR IS NULL'
      'union'
      'select RDB$PROCEDURE_NAME AS NAME,2 T'
      ' from RDB$PROCEDURES'
      ''
      ' order by 2,1')    
    Filtered = True
    OnFilterRecord = qrySPsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    DefaultFormats.DisplayFormatDate = 'dd.mm.YYYY'
    Left = 45
    Top = 282
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    poAskRecordCount = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
  object qryAllGenerators: TpFIBDataSet
    SelectSQL.Strings = (
      ' SELECT RDB$GENERATOR_NAME'
      ' FROM RDB$GENERATORS'
      ' WHERE  RDB$SYSTEM_FLAG IS NULL'
      ' ORDER BY 1')    
    Filtered = True
    OnFilterRecord = qrySPsFilterRecord
    DefaultFormats.DateTimeDisplayFormat = 'dd.mm.yyyy'
    DefaultFormats.DisplayFormatDate = 'dd.mm.YYYY'
    Left = 85
    Top = 354
    poImportDefaultValues = False
    poGetOrderInfo = False
    poSetRequiredFields = True
    poSetReadOnlyFields = True
    poAskRecordCount = True
    dcForceMasterRefresh = True
    dcForceOpen = True
  end
end
