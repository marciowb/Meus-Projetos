inherited frmLst_ContasReceber: TfrmLst_ContasReceber
  Caption = 'Listagem de contas a receber'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    inherited tsListagem: TcxTabSheet
      ExplicitWidth = 124
      inherited cxGrid1: TcxGrid
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
    end
  end
end
