inherited frmPesquisaAnimal: TfrmPesquisaAnimal
  Caption = 'Pesquisa de animais'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited GroupBox2: TGroupBox
      inherited ChkTempoReal: TCheckBox
        Checked = True
        State = cbChecked
      end
    end
  end
  inherited Panel2: TPanel
    inherited lblRegistros: TLabel
      Width = 67
    end
  end
  inherited PageControl: TcxPageControl
    inherited tsGrid: TcxTabSheet
      ExplicitLeft = 2
      ExplicitTop = 22
      ExplicitWidth = 786
      ExplicitHeight = 363
      inherited Panel3: TPanel
        Width = 786
        Height = 363
        ExplicitWidth = 786
        ExplicitHeight = 363
        inherited cxGrid1: TcxGrid
          Left = 225
          Width = 557
          Height = 334
          ExplicitLeft = 225
          ExplicitWidth = 782
          ExplicitHeight = 334
          inherited TvPesquisa: TcxGridDBTableView
            Styles.Inactive = nil
            Styles.Group = nil
          end
        end
        inherited Panel4: TPanel
          Width = 782
          ExplicitWidth = 782
          inherited chkGrupo: TCheckBox
            Left = 622
            ExplicitLeft = 622
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 25
          Width = 225
          Height = 334
          Align = alLeft
          TabOrder = 2
          object GroupBox3: TGroupBox
            Left = 1
            Top = 1
            Width = 223
            Height = 332
            Align = alClient
            Caption = ' Grupos '
            TabOrder = 0
            ExplicitLeft = 88
            ExplicitTop = 88
            ExplicitWidth = 185
            ExplicitHeight = 105
            object GridGrupo: TDBGrid
              Left = 2
              Top = 15
              Width = 219
              Height = 315
              Align = alClient
              DataSource = DataGrupo
              Options = [dgColumnResize, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              OnCellClick = GridGrupoCellClick
              Columns = <
                item
                  Expanded = False
                  FieldName = 'NOMEGRUPO'
                  Title.Caption = 'Grupo'
                  Width = 157
                  Visible = True
                end>
            end
          end
        end
      end
    end
    inherited TsTree: TcxTabSheet
      ExplicitLeft = 2
      ExplicitTop = 22
      ExplicitWidth = 786
      ExplicitHeight = 363
      inherited TvTree: TcxDBTreeList
        Width = 786
        Height = 363
        ExplicitWidth = 786
        ExplicitHeight = 363
      end
    end
  end
  object DataGrupo: TDataSource
    DataSet = CdsGrupo
    Left = 272
    Top = 344
  end
  object CdsGrupo: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 336
    Top = 352
  end
end
