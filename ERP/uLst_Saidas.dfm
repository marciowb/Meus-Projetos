inherited frmLst_Saidas: TfrmLst_Saidas
  Caption = 'Listagem de sa'#237'das'
  ClientHeight = 534
  ClientWidth = 880
  ExplicitWidth = 896
  ExplicitHeight = 573
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 880
    ExplicitWidth = 124
  end
  inherited Panel2: TPanel
    Width = 880
    ExplicitWidth = 124
  end
  inherited Status: TdxStatusBar
    Top = 514
    Width = 880
    ExplicitTop = -20
    ExplicitWidth = 124
  end
  inherited pnlCaption: TPanel
    Width = 880
    ExplicitWidth = 124
    inherited Panel4: TPanel
      Left = 529
      ExplicitLeft = -227
    end
  end
  inherited PageControl: TcxPageControl
    Width = 880
    Height = 426
    ExplicitWidth = 124
    ClientRectBottom = 426
    ClientRectRight = 880
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 124
      ExplicitHeight = 402
      inherited cxGrid1: TcxGrid
        Width = 880
        Height = 406
        ExplicitWidth = 124
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
    end
  end
end
