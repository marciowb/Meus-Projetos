inherited cxCardViewEditor: TcxCardViewEditor
  Caption = 'cxCardViewEditor'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PViewEditor: TPanel
    inherited PageControl1: TPageControl
      inherited TSItems: TTabSheet
        Caption = '   Rows   '
      end
      inherited TSSummary: TTabSheet
        TabVisible = False
      end
    end
  end
end
