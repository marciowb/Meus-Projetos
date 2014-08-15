{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPgSDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  ComCtrls,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Printers,
  Grids,

  ppClass,
  ppTypes,
  ppUtils,
  ppBands,
  ppPrintr,
  ppForms,
  ppDesignerForms,

  ppJVTabBar;

type

  TppPageImage = class(TShape)
    private
      FColumns: Integer;
      FPageImage: TBitMap;
      FPageDef: TppPageDef;
      FRowSpacing: Single;

      procedure DrawPage;

    protected
      procedure Paint; override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor  Destroy; override;
      procedure SetPageDimensions(aPageDef: TppPageDef);
      procedure SetLayout(aColumns: Integer; aRowSpacing: Single);

    end;

  TppPageSetupDialog = class(TppCustomPageSetupDialog)
    pnlAllPages: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    lblPaperSize: TLabel;
    lblWidth: TLabel;
    lblHeight: TLabel;
    cbxPaperNames: TComboBox;
    gbxOrientation: TGroupBox;
    imgLandScape: TImage;
    imgPortrait: TImage;
    rdbPortrait: TRadioButton;
    rdbLandscape: TRadioButton;
    edtPaperHeight: TEdit;
    edtPaperWidth: TEdit;
    lblPaperTray: TLabel;
    lbxBinNames: TListBox;
    lblPaperSource: TLabel;
    lblColumns: TLabel;
    lblColumnWidth: TLabel;
    edtColumns: TEdit;
    edtColumnWidth: TEdit;
    lblColumnPositions: TLabel;
    grdColPositions: TStringGrid;
    lblRowSpacing: TLabel;
    edtRowSpacing: TEdit;
    lblLayout: TLabel;
    lblMarginTop: TLabel;
    lblMarginBottom: TLabel;
    lblMarginLeft: TLabel;
    lblMarginRight: TLabel;
    edtMarginTop: TEdit;
    edtMarginBottom: TEdit;
    edtMarginLeft: TEdit;
    edtMarginRight: TEdit;
    lblMargins: TLabel;
    gbxPreview: TGroupBox;
    lblPrinterName: TLabel;
    lblCopies: TLabel;
    lblDocumentName: TLabel;
    lblDuplex: TLabel;
    cbxDuplex: TComboBox;
    edtCopies: TEdit;
    edtDocumentName: TEdit;
    cbxPrinterNames: TComboBox;
    lblCollate: TLabel;
    cbxCollate: TCheckBox;
    cbxColumnTraversal: TComboBox;
    lblColumnTraversal: TLabel;
    Notebook1: TNotebook;
    procedure edtPaperWidthChange(Sender: TObject);
    procedure edtPaperHeightChange(Sender: TObject);
    procedure rdbPortraitClick(Sender: TObject);
    procedure rdbLandscapeClick(Sender: TObject);
    procedure edtColumnsChange(Sender: TObject);
    procedure edtColumnWidthChange(Sender: TObject);
    procedure edtRowSpacingChange(Sender: TObject);
    procedure edtColumnWidthKeyPress(Sender: TObject; var Key: Char);
    procedure edtColumnsKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cbxPaperNamesChange(Sender: TObject);
    procedure edtPaperWidthKeyPress(Sender: TObject; var Key: Char);
    procedure edtPaperHeightKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelClick(Sender: TObject);
    procedure lbxBinNamesClick(Sender: TObject);
    procedure edtRowSpacingKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure grdColPositionsSelectCell(Sender: TObject; Col, Row: Longint; var CanSelect: Boolean);
    procedure grdColPositionsChange(Sender: TObject);
    procedure grdColPositionsKeyPress(Sender: TObject; var Key: Char);
    procedure grdColPositionsDrawCell(Sender: TObject; Col, Row: Longint; Rect: TRect; State: TGridDrawState);
    procedure edtMarginTopChange(Sender: TObject);
    procedure edtMarginTopKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarginBottomChange(Sender: TObject);
    procedure edtMarginBottomKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarginLeftChange(Sender: TObject);
    procedure edtMarginLeftKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarginRightChange(Sender: TObject);
    procedure edtMarginRightKeyPress(Sender: TObject; var Key: Char);
    procedure btnOKClick(Sender: TObject);
    procedure cbxPrinterNamesChange(Sender: TObject);
    procedure edtCopiesKeyPress(Sender: TObject; var Key: Char);
    procedure edtCopiesExit(Sender: TObject);
    procedure edtDocumentNameExit(Sender: TObject);
    procedure edtDocumentNameKeyPress(Sender: TObject; var Key: Char);
    procedure cbxDuplexChange(Sender: TObject);
    procedure cbxCollateClick(Sender: TObject);
    procedure cbxColumnTraversalChange(Sender: TObject);
  private
    FSaveColumns: Integer;
    FSaveColumnPositions: TStringList;
    FSaveColumnWidth: Single;
    FSaveColumnTraversal: TppColumnTraversalType;
    FSaveRowSpacing: Single;
    FSpinIncrement: Single;
    FMarginSpinIncrement: Single;
    FSavePrinterSetup: TppPrinterSetup;

    FSpinCopies: TppUpDown;
    FSpinPaperHeight: TppUpDown;
    FSpinPaperWidth: TppUpDown;
    FSpinColumns: TppUpDown;
    FSpinColumnWidth: TppUpDown;
    FSpinRowSpacing: TppUpDown;
    FSpinMarginTop: TppUpDown;
    FSpinMarginBottom: TppUpDown;
    FSpinMarginLeft: TppUpDown;
    FSpinMarginRight: TppUpDown;


    FColumnPositions: TStringList;
    FPreviewPage: TppPageImage;

    FCustomReport: TppCustomReport;
    FPrinterSetup: TppPrinterSetup;
    FDetailBand: TppDetailBand;

    FTabSet: TppJVTabBar;

    procedure CalcDefaultColumnPositions;
    procedure DrawColPositionsGrid;
    procedure LayoutChange;
    procedure PaperChange;
    procedure PrinterChange;


    procedure SpinCopiesClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinPaperHeightClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinPaperWidthClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinColumnsClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinColumnWidthClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinRowSpacingClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinMarginTopClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinMarginBottomClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinMarginLeftClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinMarginRightClick(Sender: TObject; Button: TUDBtnType);

  protected
    procedure ehTabSet_TabSelected(Sender: TObject; Item: TppJvTabBarItem);
    procedure LanguageChanged; override;
    procedure ReportAssigned; override;

  public
    property TabSet: TppJVTabBar read FTabSet;

  end;

var
  ppPageSetupDialog: TppPageSetupDialog;

implementation


{$R *.DFM}


{******************************************************************************
 *
 **  Tp p P a g e I m a g e
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPageImage.Create}

constructor TppPageImage.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FPageImage   := TBitMap.Create;
  FPageDef     := TppPageDef.Create;
  FColumns     := 0;
  
  Color := clBtnFace;

end;  {constructor, Create}

{------------------------------------------------------------------------------}
{ TppPageImage.Destroy}

destructor TppPageImage.Destroy;
begin
  FPageImage.Free;
  FPageDef.Free;
  inherited Destroy;

end;  {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppPageImage.SetPageDimensions}

procedure TppPageImage.SetPageDimensions(aPageDef: TppPageDef);

begin
  FPageDef.Assign(aPageDef);

  DrawPage;

end;  {procedure, SetPageDimensions}

{------------------------------------------------------------------------------}
{ TppPageImage.SetLayout}

procedure TppPageImage.SetLayout(aColumns: Integer; aRowSpacing: Single);
begin
  FColumns    := aColumns;
  FRowSpacing := aRowSpacing;
  DrawPage;
end; {procedure, SetLayout}

{------------------------------------------------------------------------------}
{ TppPageImage.DrawPage}

procedure TppPageImage.DrawPage;
var
  ldRatio: Double;
  liHeight,
  liWidth,
  liLeft,
  liTop,
  liRight,
  liBottom,
  liLineTop,
  liLineLeft,
  liLineWidth,
  liColumnSpace,
  liRowSpace: Integer;
  ldScaleWidth, ldScaleHeight: Double;
  liMarginTop: Integer;
  liMarginBottom: Integer;
  liMarginLeft: Integer;
  liMarginRight: Integer;

begin

  if (FPageDef.spWidth = 0) or (FPageDef.mmHeight = 0) then Exit;

  liRowSpace := 0;


  {compute page rectangle size}
  ldRatio := (FPageDef.mmWidth / FPageDef.mmHeight);

  liHeight := Height;
  liWidth  := Round(ldRatio * liHeight);

  while (liWidth >= Width) do
    begin
      liHeight := liHeight - 20;
      liWidth  := Round(ldRatio * liHeight);
    end;


  ldScaleWidth  := liWidth / FPageDef.spWidth;
  ldScaleHeight := liHeight / FPageDef.spHeight;

  liMarginTop    := Trunc(FPageDef.spMarginTop    * ldScaleHeight);
  liMarginBottom := Trunc(FPageDef.spMarginBottom * ldScaleHeight);
  liMarginLeft   := Trunc(FPageDef.spMarginLeft   * ldScaleWidth);
  liMarginRight  := Trunc(FPageDef.spMarginRight  * ldScaleWidth);


  {create and size new bitmap}
  FPageImage.Width  := Width;
  FPageImage.Height := Height;

  {draw grey background }
  FPageImage.Canvas.Brush.Style := bsSolid;
  FPageImage.Canvas.Brush.Color := clBtnFace;
  FPageImage.Canvas.FillRect(Rect(0,0,Width,Height));

  {calc position of page image within the bitmap }
  liLeft   := (Width - liWidth)   div 2;
  liTop    := (Height - liHeight) div 2;
  liRight  := liLeft + liWidth;
  liBottom := liTop + liHeight;

  {draw two grey notches at bottom left and top right}
  FPageImage.Canvas.FillRect(Rect(liLeft, liBottom - 2, liLeft+2, liBottom));
  FPageImage.Canvas.FillRect(Rect(liLeft + liWidth-2, liTop, liRight, liTop+2));

  {draw bottom and right shadow }
  FPageImage.Canvas.Brush.Color := clBlack;
  FPageImage.Canvas.FillRect(Rect(liLeft+3, liTop+liHeight-2, liRight, liBottom));
  FPageImage.Canvas.FillRect(Rect(liRight-2, liTop+3, liRight, liBottom));

  {draw page frame }
  FPageImage.Canvas.Brush.Color := clWindow;
  FPageImage.Canvas.Rectangle(liLeft, liTop, liRight-2, liBottom-2);

  {draw lines to simulate look of a report }
  liLeft      := liLeft   + 3 +  liMarginLeft;
  liTop       := liTop    + 2 +  liMarginTop;
  liRight     := liRight  - 3 -  liMarginRight;
  liBottom    := liBottom - 2  - liMarginBottom;

  liLineTop   := liTop;

  {set row spacing}
  if FRowSpacing = 0 then
    liRowSpace := 5
  else if FRowSpacing > 0 then
    liRowSpace := 8
  else if FRowSpacing < 0 then
    liRowSpace := 3;

  {set column width}
  liColumnSpace := 5;

  if FColumns > 1 then
    liLineWidth := ((liRight - liLeft) - (FColumns * liColumnSpace)) div FColumns
  else
    liLineWidth := 9;

  while liLineTop < liBottom do
    begin

      liLineLeft := liLeft;

      {draw a row}
      while liLineLeft < liRight-liLineWidth do
        begin
          FPageImage.Canvas.MoveTo(liLineLeft, liLineTop);
          FPageImage.Canvas.LineTo(liLineLeft+liLineWidth, liLineTop);
          liLineLeft := liLineLeft + liLineWidth + liColumnSpace;

        end;

      liLineTop := liLineTop + liRowSpace;
    end;

  Invalidate;

end;  {procedure, DrawPage}


{------------------------------------------------------------------------------}
{ TppPageImage.Paint}

procedure TppPageImage.Paint;
begin

  with Canvas do
    CopyRect(ClipRect, FPageImage.Canvas, ClipRect);

end; {procedure, Paint}


{******************************************************************************
 *
 ** T p p P a g e S e t u p D l g
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.FormCreate}

procedure TppPageSetupDialog.FormCreate(Sender: TObject);
begin

  FTabSet := TppJVTabBar.Create(Self);
  FTabSet.Parent := Self;
  FTabSet.CloseButton := False;
  FTabSet.Top := Notebook1.Top - FTabSet.Height;
  FTabSet.AddTab('Printer');
  FTabSet.AddTab('PaperSize');
  FTabSet.AddTab('PaperSource');
  FTabSet.AddTab('Layout');
  FTabSet.AddTab('Margins');
  FTabSet.OnTabSelected := ehTabSet_TabSelected;

  FTabSet.SelectedTab := FTabSet.Tabs[0];
  Notebook1.PageIndex := 0;

  FSaveColumns      := 0;
  FSaveColumnWidth  := 0.0;
  FSaveColumnPositions := TStringList.Create;

  FSaveRowSpacing      := 0.0;
  FSpinIncrement       := 0.1;
  FMarginSpinIncrement := 0.1;

  FSavePrinterSetup := TppPrinterSetup.Create(nil);

  FSpinCopies := TppUpDown.CreateForControl(edtCopies);
  FSpinCopies.OnClick := SpinCopiesClick;

  FSpinPaperWidth := TppUpDown.CreateForControl(edtPaperWidth);
  FSpinPaperWidth.OnClick := SpinPaperWidthClick;

  FSpinPaperHeight := TppUpDown.CreateForControl(edtPaperHeight);
  FSpinPaperHeight.OnClick := SpinPaperHeightClick;

  FSpinColumns := TppUpDown.CreateForControl(edtColumns);
  FSpinColumns.OnClick := SpinColumnsClick;

  FSpinColumnWidth := TppUpDown.CreateForControl(edtColumnWidth);
  FSpinColumnWidth.OnClick := SpinColumnWidthClick;

  FSpinRowSpacing := TppUpDown.CreateForControl(edtRowSpacing);
  FSpinRowSpacing.OnClick := SpinRowSpacingClick;

  FSpinMarginBottom := TppUpDown.CreateForControl(edtMarginBottom);
  FSpinMarginBottom.OnClick := SpinMarginBottomClick;

  FSpinMarginTop := TppUpDown.CreateForControl(edtMarginTop);
  FSpinMarginTop.OnClick := SpinMarginTopClick;

  FSpinMarginLeft := TppUpDown.CreateForControl(edtMarginLeft);
  FSpinMarginLeft.OnClick := SpinMarginLeftClick;

  FSpinMarginRight := TppUpDown.CreateForControl(edtMarginRight);
  FSpinMarginRight.OnClick := SpinMarginRightClick;

  FColumnPositions := TStringList.Create;
  FCustomReport := nil;

  FPreviewPage := TppPageImage.Create(Self);
  gbxPreview.InsertControl(FPreviewPage);
  with FPreviewPage do
    begin
      Left    := 5;
      Top     := 20;
      Width   := gbxPreview.Width-10;
      Height  := gbxPreview.Height-30;
    end;

  grdColPositions.ColWidths[0] := 5;


end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.FormDestroy}

procedure TppPageSetupDialog.FormDestroy(Sender: TObject);
begin
  FSavePrinterSetup.Free;
  FColumnPositions.Free;
  FPreviewPage.Free;
  FSaveColumnPositions.Free;
end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.ReportAssigned}

procedure TppPageSetupDialog.ReportAssigned;
begin

  if Report = nil then Exit;

  FCustomReport := TppCustomReport(Report);
  FPrinterSetup := FCustomReport.PrinterSetup;


  FDetailBand := TppDetailBand(FCustomReport.GetBand(btDetail, 0));


  {set increment for paper size spin controls based on Units }
  case FCustomReport.Units of
    utInches:        FSpinIncrement  := 0.5;
    utMillimeters:   FSpinIncrement  := 5.0;
    utScreenPixels:  FSpinIncrement  := 50.0;
    utPrinterPixels: FSpinIncrement  := 300.0;
    utMMThousandths: FSpinIncrement  := 5000.0;
  end;

  {set increment for margin spin controls based on Units }
  case FCustomReport.Units of
    utInches:        FMarginSpinIncrement  := 0.10;
    utMillimeters:   FMarginSpinIncrement  := 1;
    utScreenPixels:  FMarginSpinIncrement  := 1.0;
    utPrinterPixels: FMarginSpinIncrement  := 50.0;
    utMMThousandths: FMarginSpinIncrement  := 1000.0;
  end;


  with FCustomReport do
    begin
      {save layout properties}
      FSaveColumns     := Columns;
      FSaveColumnPositions.Assign(ColumnPositions);
      FSaveColumnWidth := ColumnWidth;

      if (FDetailBand <> nil) then
        begin
          FSaveRowSpacing  := FDetailBand.BottomOffset;
          FSaveColumnTraversal := FDetailBand.ColumnTraversal;
        end;

      if ((Columns > 1) and (ColumnPositions.Count = 0)) or
         ((Columns = 1) and (ColumnPositions.Count > 0)) then
         CalcDefaultColumnPositions
      else
        FColumnPositions.Assign(ColumnPositions);
         
      LayoutChange;

    end;

  {save printer setup properties }
  FSavePrinterSetup.Assign(FPrinterSetup);

  PrinterChange;


end; {procedure, ReportAssigned}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.btnOKClick}

procedure TppPageSetupDialog.btnOKClick(Sender: TObject);
begin
  ExitActiveControl;
end; {procedure, btnOKClick}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.btnCancelClick}

procedure TppPageSetupDialog.btnCancelClick(Sender: TObject);
begin

  if FCustomReport = nil then Exit;

  {restore old settings }
  FPrinterSetup.Assign(FSavePrinterSetup);

  FCustomReport.Columns         := FSaveColumns;
  FCustomReport.ColumnPositions := FSaveColumnPositions;
  FCustomReport.ColumnWidth     := FSaveColumnWidth;

  if (FDetailBand <> nil) then
    begin
      FDetailBand.BottomOffset    := FSaveRowSpacing;
      FDetailBand.ColumnTraversal := FSaveColumnTraversal;
    end;


end; {procedure, btnCancelClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.PrinterChange}

procedure TppPageSetupDialog.PrinterChange;
begin
  {initialise form controls}

  cbxPrinterNames.Items := FPrinterSetup.PrinterNames;
  cbxPaperNames.Items   := FPrinterSetup.PaperNames;
  lbxBinNames.Items     := FPrinterSetup.BinNames;

  cbxPrinterNames.ItemIndex := FPrinterSetup.PrinterNames.IndexOf(FPrinterSetup.PrinterName);

  if cbxPrinterNames.ItemIndex < 0 then
    cbxPrinterNames.ItemIndex := FPrinterSetup.PrinterNames.IndexOf(cDefault);

  PaperChange;

end; {procedure, PrinterChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.PaperChange}

procedure TppPageSetupDialog.PaperChange;
begin


  edtDocumentName.Text  := FPrinterSetup.DocumentName;
  edtCopies.Text        := IntToStr(FPrinterSetup.Copies);
  cbxDuplex.ItemIndex   := Ord(FPrinterSetup.Duplex);
  cbxCollate.Checked    := FPrinterSetup.Collation;

  cbxPaperNames.ItemIndex   := FPrinterSetup.PaperNames.IndexOf(FPrinterSetup.PaperName);

  if cbxPaperNames.ItemIndex < 0 then
    cbxPaperNames.ItemIndex := FPrinterSetup.PaperNames.IndexOf(cCustom);


  {note: following format is compatible with the ObjectInspector formatting}
  edtPaperWidth.Text      := FloatToStrF(FPrinterSetup.PaperWidth,   ffGeneral,  7, 0);
  edtPaperHeight.Text     := FloatToStrF(FPrinterSetup.PaperHeight,  ffGeneral,  7, 0);
  edtMarginTop.Text       := FloatToStrF(FPrinterSetup.MarginTop,    ffGeneral,  7, 0);
  edtMarginBottom.Text    := FloatToStrF(FPrinterSetup.MarginBottom, ffGeneral,  7, 0);
  edtMarginLeft.Text      := FloatToStrF(FPrinterSetup.MarginLeft,   ffGeneral,  7, 0);
  edtMarginRight.Text     := FloatToStrF(FPrinterSetup.MarginRight,  ffGeneral,  7, 0);

  {update preview page image to reflect change}
  FPreviewPage.SetPageDimensions(FPrinterSetup.PageDef);

  rdbPortrait.Checked     := (FPrinterSetup.Orientation = poPortrait);
  rdbLandscape.Checked    := (FPrinterSetup.Orientation = poLandscape);
  imgPortrait.Visible     := (FPrinterSetup.Orientation = poPortrait);
  imgLandscape.Visible    := (FPrinterSetup.Orientation = poLandscape);

  lbxBinNames.ItemIndex   := FPrinterSetup.BinNames.IndexOf(FPrinterSetup.BinName);


end; {procedure, PaperChange}



{******************************************************************************
 *
 ** P R I N T E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.cbxPrinterNamesChange}

procedure TppPageSetupDialog.cbxPrinterNamesChange(Sender: TObject);
begin
  FPrinterSetup.PrinterName := cbxPrinterNames.Text;
  PrinterChange;
end; {procedure, cbxPrinterNamesChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtDocumentNameExit }

procedure TppPageSetupDialog.edtDocumentNameExit(Sender: TObject);
begin

  FPrinterSetup.DocumentName := edtDocumentName.Text;

end;  {procedure, edtDocumentNameExit}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtDocumentNameKeyPress }

procedure TppPageSetupDialog.edtDocumentNameKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtDocumentNameExit(Self);

end; {procedure, edtDocumentNameKeyPress}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.SpinCopiesClick }

procedure TppPageSetupDialog.SpinCopiesClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    FPrinterSetup.Copies := FPrinterSetup.Copies - 1
  else
    FPrinterSetup.Copies := FPrinterSetup.Copies + 1;

  PaperChange;

end; {procedure, SpinCopiesClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtCopiesKeyPress }

procedure TppPageSetupDialog.edtCopiesKeyPress(Sender: TObject; var Key: Char);
begin

  if (Key = chEnterKey) then
    edtCopiesExit(Self);

end; {procedure, edtCopiesKeyPress}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtCopiesExit }

procedure TppPageSetupDialog.edtCopiesExit(Sender: TObject);
var
  liCopies: Integer;

begin

 try
    liCopies := StrToInt(edtCopies.Text);
    if liCopies >= 1 then
      FPrinterSetup.Copies := StrToInt(edtCopies.Text);
  except on EConvertError do
    MessageDlg(LoadStr(LanguageIndex + 377), mtWarning, [mbOK], 0);
  end;

    
end; {procedure, edtCopiesExit}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.cbxCollateClick }

procedure TppPageSetupDialog.cbxCollateClick(Sender: TObject);
begin

  if Sender is TLabel then
   cbxCollate.Checked := not cbxCollate.Checked;
   
  FPrinterSetup.Collation := cbxCollate.Checked;

end; {procedure, cbxCollateClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.cbxDuplexChange }

procedure TppPageSetupDialog.cbxDuplexChange(Sender: TObject);
begin
  FPrinterSetup.Duplex := TppDuplexType(cbxDuplex.ItemIndex);

end; {procedure, cbxDuplexChange}




{******************************************************************************
 *
 ** P A P E R S I Z E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.cbxPaperNamesChange}

procedure TppPageSetupDialog.cbxPaperNamesChange(Sender: TObject);
begin
  FPrinterSetup.PaperName := cbxPaperNames.Text;
  PaperChange;
end; {procedure, cbxPaperNamesChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtPaperWidthChange}

procedure TppPageSetupDialog.edtPaperWidthChange(Sender: TObject);
begin

  if (ActiveControl = btnCancel) then Exit;

  try
    FPrinterSetup.PaperWidth := StrToFloat(edtPaperWidth.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

  PaperChange;

end; {procedure, edtPaperWidthChange}



{------------------------------------------------------------------------------}
{ TppPageSetupDialog.SpinPaperWidthClick }

procedure TppPageSetupDialog.SpinPaperWidthClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    FPrinterSetup.PaperWidth := FPrinterSetup.PaperWidth - FSpinIncrement
  else
    FPrinterSetup.PaperWidth := FPrinterSetup.PaperWidth + FSpinIncrement;

  PaperChange;

end; {procedure, SpinPaperWidthClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtPaperWidthKeyPress}

procedure TppPageSetupDialog.edtPaperWidthKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
     edtPaperWidthChange(Self);

end; {procedure, edtPaperWidthKeyPress}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtPaperHeightChange}

procedure TppPageSetupDialog.edtPaperHeightChange(Sender: TObject);
begin

  if (ActiveControl = btnCancel) then Exit;

  try
    FCustomReport.PrinterSetup.PaperHeight := StrToFloat(edtPaperHeight.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

  PaperChange;

end; {procedure, edtPaperHeightChange}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtPaperHeightKeyPress}

procedure TppPageSetupDialog.edtPaperHeightKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtPaperHeightChange(Self);

end; {procedure, edtPaperHeightKeyPress}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.SpinPaperHeightClick }

procedure TppPageSetupDialog.SpinPaperHeightClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    FPrinterSetup.PaperHeight := FPrinterSetup.PaperHeight - FSpinIncrement
  else
    FPrinterSetup.PaperHeight := FPrinterSetup.PaperHeight + FSpinIncrement;

  PaperChange;

end; {procedure, SpinPaperHeightClick}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.rdbPortraitClick}

procedure TppPageSetupDialog.rdbPortraitClick(Sender: TObject);
begin
  FCustomReport.PrinterSetup.Orientation := poPortrait;
  PaperChange;
end; {procedure, rdbPortraitClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.rdbLandscapeClick}

procedure TppPageSetupDialog.rdbLandscapeClick(Sender: TObject);
begin
   FCustomReport.PrinterSetup.Orientation := poLandscape;
  PaperChange;
end; {procedure, rdbLandscapeClick}



{******************************************************************************
 *
 ** P A P E R S O U R C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.lbxBinNamesClick}

procedure TppPageSetupDialog.lbxBinNamesClick(Sender: TObject);
begin
  FCustomReport.PrinterSetup.BinName := lbxBinNames.Items[lbxBinNames.ItemIndex];
end; {procedure, lbxBinNamesClick}



{******************************************************************************
 *
 ** L A Y O U T
 *
{******************************************************************************}



{------------------------------------------------------------------------------}
{ TppPageSetupDlg.LayoutChange}

procedure TppPageSetupDialog.LayoutChange;
begin

  edtColumns.Text      := IntToStr(FCustomReport.Columns);
  edtColumnWidth.Text  := FloatToStrF(FCustomReport.ColumnWidth,    ffGeneral,  7, 0); 

  if (FDetailBand <> nil) then
    begin
      edtRowSpacing.Text   := FloatToStrF(FDetailBand.BottomOffset,   ffGeneral,  7, 0);
      cbxColumnTraversal.ItemIndex := Ord(FDetailBand.ColumnTraversal);
    end;

  lblColumnWidth.Enabled  := (FCustomReport.Columns > 1);
  edtColumnWidth.Enabled  := (FCustomReport.Columns > 1);
  FSpinColumnWidth.Enabled := (FCustomReport.Columns > 1);
  grdColPositions.Enabled := (FCustomReport.Columns > 1);
  lblColumnPositions.Enabled := (FCustomReport.Columns > 1);

  {update preview page image to reflect change}
  if (FDetailBand <> nil) then
    FPreviewPage.SetLayout(FCustomReport.Columns, FDetailBand.BottomOffset)
  else
    FPreviewPage.SetLayout(FCustomReport.Columns, 0);


  DrawColPositionsGrid;

end; {procedure, LayoutChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.DrawColPositionsGrid}

procedure TppPageSetupDialog.DrawColPositionsGrid;
var
  liCol: Integer;

begin

  with grdColPositions do
    begin

      if FCustomReport.Columns = 1 then
        ColCount := 5
      else
        ColCount := FCustomReport.Columns+1;

      for liCol := 1 to ColCount-1 do
        begin
          ColWidths[liCol] := 49;

          if FCustomReport.Columns = 1 then
            begin
              Cells[liCol,0] := '';
              Cells[liCol,1] := '';
            end
          else
            begin
              Cells[liCol,0] := ppLoadStr(372) + ' ' + IntToStr(liCol);
              Cells[liCol,1] := FColumnPositions[liCol-1];
            end;

        end;

    end; {with grdColPositions}


end; {procedure, DrawColPositionsGrid}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.CalcDefaultColumnPositions }

procedure TppPageSetupDialog.CalcDefaultColumnPositions;
var
  liCol: Integer;
  lColPosition: Single;
  
begin

  FColumnPositions.Clear;

  grdColPositions.ColCount := FCustomReport.Columns + 1;

  if FCustomReport.Columns > 1 then
    begin

      {calc positon of first column which starts at margin left}
      lColPosition := (FCustomReport.PrinterSetup.MarginLeft);

      with grdColPositions do
        for liCol := 1 to ColCount-1 do
          begin
            FColumnPositions.Add(FloatToStrF(lColPosition,   ffGeneral,  7, 0)); 
            lColPosition := lColPosition + FCustomReport.ColumnWidth;
          end;  {with grdColPositions}

    end; {if, Columns > 1 }

  FCustomReport.ColumnPositions := FColumnPositions;

end; {procedure, CalcDefaultColumnPositions}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtColumnsChange}

procedure TppPageSetupDialog.edtColumnsChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    FCustomReport.Columns := StrToInt(edtColumns.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

  CalcDefaultColumnPositions;
  LayoutChange;

end;  {procedure, edtColumnsChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtColumnsKeyPress}

procedure TppPageSetupDialog.edtColumnsKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtColumnsChange(Self);

end; {procedure, edtColumnsKeyPress}


{------------------------------------------------------------------------------}
{ TppPageSetupDialog.SpinColumnsClick }

procedure TppPageSetupDialog.SpinColumnsClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    FCustomReport.Columns := FCustomReport.Columns - 1
  else
    FCustomReport.Columns := FCustomReport.Columns + 1;

  CalcDefaultColumnPositions;
  LayoutChange;

end; {procedure, SpinColumnsClick}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtColumnWidthChange}

procedure TppPageSetupDialog.edtColumnWidthChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    FCustomReport.ColumnWidth := StrToFloat(edtColumnWidth.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

  CalcDefaultColumnPositions;
  LayoutChange;

end; {procedure, edtColumnWidthChange}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtColumnWidthKeyPress}

procedure TppPageSetupDialog.edtColumnWidthKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtColumnWidthChange(Self);

end; {procedure, edtColumnWidthKeyPress}


{------------------------------------------------------------------------------}
{ TppPageSetupDialog.SpinColumnWidthClick }

procedure TppPageSetupDialog.SpinColumnWidthClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    FCustomReport.ColumnWidth := FCustomReport.ColumnWidth - FMarginSpinIncrement
  else
    FCustomReport.ColumnWidth := FCustomReport.ColumnWidth + FMarginSpinIncrement;

  CalcDefaultColumnPositions;
  LayoutChange;

end; {procedure, SpinColumnWidthClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.cbxColumnTraversalChange }

procedure TppPageSetupDialog.cbxColumnTraversalChange(Sender: TObject);
begin
  FDetailBand.ColumnTraversal := TppColumnTraversalType(cbxColumnTraversal.ItemIndex);

end; {procedure, cbxColumnTraversalChange}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtRowSpacingChange}

procedure TppPageSetupDialog.edtRowSpacingChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    if (FDetailBand <> nil) then
      FDetailBand.BottomOffset := StrToFloat(edtRowSpacing.Text);

  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

  LayoutChange;

end; {procedure, edtRowSpacingChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtRowSpacingChange}

procedure TppPageSetupDialog.edtRowSpacingKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtRowSpacingChange(Self);

end; {procedure, edtRowSpacingKeyPress}


{------------------------------------------------------------------------------}
{ TppPageSetupDialog.SpinRowSpacingClick }

procedure TppPageSetupDialog.SpinRowSpacingClick(Sender: TObject; Button: TUDBtnType);
begin

  if FDetailBand = nil then Exit;

  if (Button = btPrev) then
    FDetailBand.BottomOffset := FDetailBand.BottomOffset - FMarginSpinIncrement
  else
    FDetailBand.BottomOffset := FDetailBand.BottomOffset + FMarginSpinIncrement;

  LayoutChange;

end; {procedure, SpinRowSpacingClick}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.grdColPositionsSelectCell}

procedure TppPageSetupDialog.grdColPositionsSelectCell(Sender: TObject; Col,
                                                    Row: Longint; var CanSelect: Boolean);
var
  lsColPosition: String;
  liCurrentCol,
  liCurrentRow: Longint;
  
begin
  liCurrentCol := grdColPositions.Col;
  liCurrentRow := grdColPositions.Row;

  {can only edit row 1}
  CanSelect := grdColPositions.Enabled and (Row = 1) and
                                           (Col > 0) and (Col < grdColPositions.ColCount);

  {validate the current selected cell}
  if CanSelect and (liCurrentRow = 1) and (liCurrentCol > 0) and
                   (liCurrentCol < grdColPositions.ColCount) then
    try
      lsColPosition := grdColPositions.Cells[liCurrentCol,1];
      StrToFloat(lsColPosition);
      FColumnPositions[liCurrentCol-1] := lsColPosition;
      FCustomReport.ColumnPositions := FColumnPositions;

    except on EConvertError do
      begin
        CanSelect := False;
        WarningDlg(ppLoadStr(377));
      end;
    end;

end; {procedure, grdColPositionsSelectCell}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.grdColPositionsChange}

procedure TppPageSetupDialog.grdColPositionsChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;


  if (grdColPositions.Row <> 1) then Exit;

  try
    with grdColPositions do
      begin
        {try to convert to make sure we have a valid floating point number}
        StrToFloat(Cells[Col,1]);
        if (Col > 0) and (Col <= FColumnPositions.Count) then
          FColumnPositions[Col-1] := Cells[Col,1];
        FCustomReport.ColumnPositions := FColumnPositions;
      end;
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

  LayoutChange;

end; {procedure, grdColPositionsChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.grdColPositionsKeyPress}

procedure TppPageSetupDialog.grdColPositionsKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    grdColPositionsChange(Self);

end;  {procedure, grdColPositionsKeyPress}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.grdColPositionsDrawCell}

procedure TppPageSetupDialog.grdColPositionsDrawCell(Sender: TObject; Col,
                                                  Row: Longint; Rect: TRect; State: TGridDrawState);
begin

  {draw cells so they look disabled }
  if not grdColPositions.Enabled and (Row > 0) and (Col > 0) then
    with grdColPositions.Canvas do
      begin
        Pen.Color   := clBtnText;
        Brush.Color := clBtnFace;
        Rectangle(Rect.Left-1,Rect.Top-1,Rect.Right+1, Rect.Bottom+1);
      end;

end; {procedure, grdColPositionsDrawCell}




{******************************************************************************
 *
 ** M A R G I N S
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtMarginTopChange}


procedure TppPageSetupDialog.edtMarginTopChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    FCustomReport.PrinterSetup.MarginTop := StrToFloat(edtMarginTop.Text);
    PaperChange;
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtMarginTopChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtMarginTopKeyPress}

procedure TppPageSetupDialog.edtMarginTopKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtMarginTopChange(Self);
end;  {procedure, edtMarginTopKeyPress}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtMarginBottomChange}

procedure TppPageSetupDialog.edtMarginBottomChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    FCustomReport.PrinterSetup.MarginBottom := StrToFloat(edtMarginBottom.Text);
    PaperChange;
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtMarginBottomChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtMarginBottomKeyPress}

procedure TppPageSetupDialog.edtMarginBottomKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtMarginBottomChange(Self);

end; {procedure, edtMarginBottomKeyPress}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtMarginLeftChange}

procedure TppPageSetupDialog.edtMarginLeftChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    FCustomReport.PrinterSetup.MarginLeft := StrToFloat(edtMarginLeft.Text);
    PaperChange;
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtMarginLeftChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtMarginLeftKeyPress}

procedure TppPageSetupDialog.edtMarginLeftKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtMarginLeftChange(Self);

end; {procedure, edtMarginLeftKeyPress}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtMarginRightChange}

procedure TppPageSetupDialog.edtMarginRightChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    FCustomReport.PrinterSetup.MarginRight := StrToFloat(edtMarginRight.Text);
    PaperChange;
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtMarginRightChange}

{------------------------------------------------------------------------------}
{ TppPageSetupDlg.edtMarginRightKeyPress}

procedure TppPageSetupDialog.edtMarginRightKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtMarginRightChange(Self);

end; {procedure, edtMarginRightKeyPress}

{------------------------------------------------------------------------------}
{ TdaDataSettingsDialog.ehTabSet_TabSelected }

procedure TppPageSetupDialog.ehTabSet_TabSelected(Sender: TObject; Item: TppJvTabBarItem);
begin

  Notebook1.PageIndex := Item.Index;

  Notebook1.SetFocus;

end;

{------------------------------------------------------------------------------}
{ TppPageSetupDialog.SpinMarginBottomClick }

procedure TppPageSetupDialog.SpinMarginBottomClick(Sender: TObject; Button: TUDBtnType);
begin

  if FDetailBand = nil then Exit;

  if (Button = btPrev) then
    FPrinterSetup.MarginBottom := FPrinterSetup.MarginBottom - FMarginSpinIncrement
  else
    FPrinterSetup.MarginBottom := FPrinterSetup.MarginBottom + FMarginSpinIncrement;

  PaperChange;

end; {procedure, SpinMarginBottomClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDialog.SpinMarginTopClick }

procedure TppPageSetupDialog.SpinMarginTopClick(Sender: TObject; Button: TUDBtnType);
begin

  if FDetailBand = nil then Exit;

  if (Button = btPrev) then
    FPrinterSetup.MarginTop := FPrinterSetup.MarginTop - FMarginSpinIncrement
  else
    FPrinterSetup.MarginTop := FPrinterSetup.MarginTop + FMarginSpinIncrement;

  PaperChange;

end; {procedure, SpinMarginTopClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDialog.SpinMarginLeftClick }

procedure TppPageSetupDialog.SpinMarginLeftClick(Sender: TObject; Button: TUDBtnType);
begin

  if FDetailBand = nil then Exit;

  if (Button = btPrev) then
    FPrinterSetup.MarginLeft := FPrinterSetup.MarginLeft - FMarginSpinIncrement
  else
    FPrinterSetup.MarginLeft := FPrinterSetup.MarginLeft + FMarginSpinIncrement;

  PaperChange;

end; {procedure, SpinMarginLeftClick}

{------------------------------------------------------------------------------}
{ TppPageSetupDialog.SpinMarginRightClick }

procedure TppPageSetupDialog.SpinMarginRightClick(Sender: TObject; Button: TUDBtnType);
begin

  if FDetailBand = nil then Exit;

  if (Button = btPrev) then
    FPrinterSetup.MarginRight := FPrinterSetup.MarginRight - FMarginSpinIncrement
  else
    FPrinterSetup.MarginRight := FPrinterSetup.MarginRight + FMarginSpinIncrement;

  PaperChange;

end; {procedure, SpinMarginRightClick}


{------------------------------------------------------------------------------}
{ TppPageSetupDlg.LanguageChanged}

procedure TppPageSetupDialog.LanguageChanged;
var
  liSaveIndex: Integer;
begin

  Caption := ppLoadStr(218);

  lblPrinterName.Caption  := ppLoadStr(25);   {Printer Name}
  lblDocumentName.Caption := ppLoadStr(1127); {Document Name}
  lblCopies.Caption       := ppLoadStr(7);
  lblCollate.Caption      := StringReplace(ppLoadStr(1015), '&', '',[]); {Collate}
  lblDuplex.Caption       := ppLoadStr(1128); {Duplex}

  liSaveIndex := cbxDuplex.ItemIndex;
  cbxDuplex.Items.Clear;
  cbxDuplex.Items.Add(ppLoadStr(474));  {'None'}
  cbxDuplex.Items.Add(ppLoadStr(626));  {'Vertical'}
  cbxDuplex.Items.Add(ppLoadStr(1129)); {'Horizontal'}

  cbxDuplex.ItemIndex := liSaveIndex;

  lblColumnTraversal.Caption  := ppLoadStr(1135); {'Column Traversal'}

  liSaveIndex := cbxColumnTraversal.ItemIndex;
  cbxColumnTraversal.Items.Clear;
  cbxColumnTraversal.Items.Add(ppLoadStr(1136)); {'Top to Bottom'}
  cbxColumnTraversal.Items.Add(ppLoadStr(1137)); {'Left to Right'}
  cbxColumnTraversal.ItemIndex := liSaveIndex;


  lblColumnPositions.Caption := ppLoadStr(212);
  lblColumnWidth.Caption     := ppLoadStr(213);
  lblColumns.Caption         := ppLoadStr(214);
  lblHeight.Caption          := ppLoadStr(184);
  lblLayout.Caption          := ppLoadStr(216);
  lblMargins.Caption         := ppLoadStr(376);
  gbxOrientation.Caption     := ppLoadStr(217);
  lblPaperSize.Caption       := ppLoadStr(219);
  lblPaperSource.Caption     := ppLoadStr(220);
  lblPaperTray.Caption       := ppLoadStr(221);
  gbxPreview.Caption         := ppLoadStr(186);
  lblRowSpacing.Caption      := ppLoadStr(222);
  lblWidth.Caption           := ppLoadStr(183);
  lblMarginTop.Caption       := ppLoadStr(182);
  lblMarginBottom.Caption    := ppLoadStr(325);
  lblMarginLeft.Caption      := ppLoadStr(181);
  lblMarginRight.Caption     := ppLoadStr(327);

  rdbPortrait.Caption        := ppLoadStr(148);
  rdbLandscape.Caption       := ppLoadStr(147);

  btnOK.Caption     := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

  FTabSet.Tabs[0].Caption := ppLoadStr(25);
  FTabSet.Tabs[1].Caption := lblPaperSize.Caption;
  FTabSet.Tabs[2].Caption := lblPaperSource.Caption;
  FTabSet.Tabs[3].Caption := lblLayout.Caption;
  FTabSet.Tabs[4].Caption := lblMargins.Caption;

end; {procedure, SetLanguage}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}



initialization

  ppRegisterForm(TppCustomPageSetupDialog, TppPageSetupDialog);

finalization

  ppUnRegisterForm(TppCustomPageSetupDialog);

end.
