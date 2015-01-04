inherited frmLst_Saidas: TfrmLst_Saidas
  Caption = 'Listagem de sa'#237'das'
  ClientHeight = 534
  ClientWidth = 1039
  ExplicitWidth = 1055
  ExplicitHeight = 573
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 1039
    ExplicitWidth = 1039
  end
  inherited Panel2: TPanel
    Width = 1039
    ExplicitWidth = 1039
    inherited BitBtn1: TBitBtn
      Left = 966
      ExplicitLeft = 966
    end
    inherited BitBtn9: TBitBtn
      Left = 875
      ExplicitLeft = 875
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
    end
    object BitBtn12: TBitBtn
      Left = 675
      Top = 0
      Width = 200
      Height = 31
      Action = acLotesDocumentos
      Align = alLeft
      Caption = 'Lotes de documentos fiscais'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 11
    end
  end
  inherited Status: TdxStatusBar
    Top = 514
    Width = 1039
    ExplicitTop = 514
    ExplicitWidth = 1039
  end
  inherited pnlCaption: TPanel
    Width = 1039
    ExplicitWidth = 1039
    inherited Panel4: TPanel
      Left = 688
      ExplicitLeft = 688
    end
  end
  inherited PageControl: TcxPageControl
    Width = 1039
    Height = 426
    ExplicitWidth = 1039
    ExplicitHeight = 426
    ClientRectBottom = 426
    ClientRectRight = 1039
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 1039
      ExplicitHeight = 406
      inherited cxGrid1: TcxGrid
        Width = 1039
        Height = 406
        ExplicitWidth = 1039
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
    object acLotesDocumentos: TAction
      Caption = 'Lotes de documentos fiscais'
      ImageIndex = 9
      OnExecute = acLotesDocumentosExecute
    end
  end
end
