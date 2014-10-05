inherited frmLst_Entrada: TfrmLst_Entrada
  Caption = 'Listagem de entrada'
  ClientHeight = 532
  ClientWidth = 879
  ExplicitWidth = 895
  ExplicitHeight = 571
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 879
    ExplicitWidth = 879
  end
  inherited Panel2: TPanel
    Width = 879
    ExplicitWidth = 879
  end
  inherited Status: TdxStatusBar
    Top = 512
    Width = 879
    ExplicitTop = 512
    ExplicitWidth = 879
  end
  inherited pnlCaption: TPanel
    Width = 879
    ExplicitWidth = 879
    inherited Panel4: TPanel
      Left = 528
      ExplicitLeft = 528
    end
  end
  inherited PageControl: TcxPageControl
    Width = 879
    Height = 424
    ExplicitWidth = 879
    ExplicitHeight = 424
    ClientRectBottom = 424
    ClientRectRight = 879
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 879
      ExplicitHeight = 404
      inherited cxGrid1: TcxGrid
        Width = 879
        Height = 404
        ExplicitWidth = 879
        ExplicitHeight = 404
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
    end
  end
end
