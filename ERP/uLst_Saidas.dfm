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
    ExplicitWidth = 880
  end
  inherited Panel2: TPanel
    Width = 880
    ExplicitWidth = 880
    inherited BitBtn1: TBitBtn
      Left = 766
    end
    inherited BitBtn9: TBitBtn
      Left = 675
    end
    object BitBtn11: TBitBtn
      Left = 536
      Top = 0
      Width = 139
      Height = 31
      Action = actContasReceber
      Align = alLeft
      Caption = 'Contas a Receber'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 10
      ExplicitLeft = 518
      ExplicitTop = 3
    end
  end
  inherited Status: TdxStatusBar
    Top = 514
    Width = 880
    ExplicitTop = 514
    ExplicitWidth = 880
  end
  inherited pnlCaption: TPanel
    Width = 880
    ExplicitWidth = 880
    inherited Panel4: TPanel
      Left = 529
      ExplicitLeft = 529
    end
  end
  inherited PageControl: TcxPageControl
    Width = 880
    Height = 426
    ExplicitWidth = 880
    ExplicitHeight = 426
    ClientRectBottom = 426
    ClientRectRight = 880
    inherited tsListagem: TcxTabSheet
      ExplicitWidth = 880
      ExplicitHeight = 406
      inherited cxGrid1: TcxGrid
        Width = 880
        Height = 406
        ExplicitWidth = 880
        ExplicitHeight = 406
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
    end
  end
  inherited ActionList1: TActionList
    object actContasReceber: TAction
      Caption = 'Contas a Receber'
      ImageIndex = 3
      OnExecute = actContasReceberExecute
    end
  end
end
