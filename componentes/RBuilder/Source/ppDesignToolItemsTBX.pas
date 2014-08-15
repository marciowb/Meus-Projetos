{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                   BBBBB   }

unit ppDesignToolItemsTBX;

interface

uses
  SysUtils,
  Windows,
  Types,
  Graphics,
  Classes,
  Dialogs,

  ppTB2Item,

  ppTBX,
  ppTBXExtItems,
  ppTBXLists,
  ppTBXToolPals,

  ppTypes,
  ppRTTI,
  ppUtils,
  ppPrintr,
  ppToolResources,
  ppDesignToolActions,
  ppToolbarTBX,
  ppDesignToolbar;


type

  {internal border drawing state types}
  TppBorderOrientationType = (botHorizontal, botVertical);
  TppCornerType = (ctLeftTop, ctRightTop, ctLeftBottom, ctRightBottom);

 // forward declaration
  TppBorderToolItem = class;


  {TppBorderToolChildItemViewer}
  TppBorderToolChildItemViewer = class(TppToolItemChildViewer)
  private
    FOrientation: TppBorderOrientationType;

  protected

  public
    destructor Destroy; override;

    procedure InitializeCanvasPenStyle(aCanvas: TCanvas);
    procedure Paint(aCanvas: TCanvas; aClientArea: TRect); override;

    property Orientation: TppBorderOrientationType read FOrientation write FOrientation;

  end;

  {TppBorderToolItemViewer}
  TppBorderToolItemViewer = class(TppToolItemParentViewer)
  private
    FItem: TppBorderToolItem;
    FBorderPositionsChanged: Boolean;
    FLeftBorder: TppBorderToolChildItemViewer;
    FTopBorder: TppBorderToolChildItemViewer;
    FRightBorder: TppBorderToolChildItemViewer;
    FBottomBorder: TppBorderToolChildItemViewer;
    FMouseUp: Boolean;

    procedure PaintCorners(aCanvas: TCanvas);
    function GetSelectedBorderPositions: TppBorderPositions;
    procedure UpdateSelectedBorders(aBorderPositions: TppBorderPositions);

  protected
    procedure CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer); override;
    procedure eh_BorderSelectedChanged(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Leaving; override;
    procedure MouseDown(Shift: TShiftState; X, Y: Integer;var MouseDownOnMenu: Boolean); override;
    procedure MouseMove(X, Y: Integer); override;
    procedure MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean); override;
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect; IsHoverItem, IsPushed, UseDisabledShadow: Boolean); override;

  public
    constructor Create(aView: TppTBView; aItem: TppTBCustomItem; aGroupLevel: Integer); override;
    destructor Destroy; override;

  end;

  {TppBorderPalette}
  TppBorderPalette = class(TppDesignToolPalette)
  private
    FAllButton: TppTBXItem;
    FAllButtonImage: TBitmap;
    FBorderItem: TppBorderToolItem;
    FNoneButton: TppTBXItem;
    FNoneButtonImage: TBitmap;
    FImageList: TppToolImageList;

    procedure DrawButtonImage(aBitmap: TBitmap; aColor: TColor; aCaption: String);

    function GetBorderPositions: TppBorderPositions;
    procedure SetBorderPositions(const Value: TppBorderPositions);

  protected
    procedure CreateControls(aParent: TppTBXSubmenuItem); override;

    procedure ehAllButton_Click(Sender: TObject);
    procedure ehNoneButton_Click(Sender: TObject);
    procedure ehBorderItem_PositionsChanged(Sender: TObject);
    procedure ExecuteAction; override;
    procedure SetAction(const Value: TBasicAction); override;

  public
    constructor Create(aParent: TppTBXSubmenuItem); override;
    destructor Destroy; override;

    procedure LanguageChanged; override;

  published
    property BorderPositions: TppBorderPositions read GetBorderPositions write SetBorderPositions;

  end;

  {TppSimpleColorPalette}
   TppSimpleColorPalette = class(TppDesignToolPalette)
   private
     FColor: TColor;
     FOnColorChange: TNotifyEvent;
     FMoreColorsButton: TppTBXItem;
     FTBXColorPalette: TppTBXColorPalette;
   protected
     procedure CreateControls(aParent: TppTBXSubmenuItem); override;
     procedure ehColorButton_Click(Sender: TObject); virtual;
     procedure ehMoreColorsButton_Click(Sender: TObject); virtual;
     procedure SetColor(aColor: TColor); virtual;
     function ShowColorDialog(var aColor: TColor): Boolean;
   public
     constructor Create(aParent: TppTBXSubmenuItem); override;
     procedure LanguageChanged; override;

     property MorColorsButton: TppTBXItem read FMoreColorsButton;
   published
     property Color: TColor read FColor write SetColor;
     property OnColorChange: TNotifyEvent read FOnColorChange write FOnColorChange;
   end;


  {TppColorPalette}
  TppColorPalette = class(TppSimpleColorPalette)
  private
    FAutoButton: TppTBXItem;
    FIsClear: Boolean;
    FColorType: TppColorButtonType;

    procedure SetIsClear(aValue: Boolean);
    procedure SetColorType(const aPaletteType: TppColorButtonType);

    {button event handlers}
    procedure ehAutoButton_Click(Sender: TObject);

  protected
    procedure CreateControls(aParent: TppTBXSubmenuItem); override;
    procedure ExecuteAction; override;
    procedure SetAction(const Value: TBasicAction); override;
    procedure SetColor(aColor: TColor); override;
  public
    procedure LanguageChanged; override;

    property AutoButton: TppTBXItem read FAutoButton;

  published
    property ColorType: TppColorButtonType read FColorType write SetColorType;
    property IsClear: Boolean read FIsClear write SetIsClear;

  end;


  {TppAnchorPalette}
  TppAnchorPalette = class(TppDesignToolPalette)
  private
    FAnchors: TppAnchors;
    FImageList: TppToolImageList;
    FTBXPalette: TppToolPaletteTBXMultiSelect;

    procedure AnchorsToPalette;
    procedure InitializeImageList;
    procedure SetAnchors(aAnchors: TppAnchors);
    procedure ehPaletteCell_Click(Sender: TppTBXCustomToolPalette; var aCol, aRow: Integer; var AllowChange: Boolean);
    procedure PaletteToAnchors;

  protected
    procedure ExecuteAction; override;
    
  public
    constructor Create(aParent: TppTBXSubmenuItem); override;
    destructor Destroy; override;

  published
    property Anchors: TppAnchors read FAnchors write SetAnchors;

  end;


  {TppLineThicknessPalette}
  TppLineThicknessPalette = class(TppDesignToolPalette)
  private
    FDoubleLines: Boolean;
    FLineStyle: TppLineStyleType;
    FLineThickness: Single;
    FImageList: TppToolImageList;

    procedure SetDoubleLines(const Value: Boolean);
    procedure SetLineStyle(aLineStyle: TppLineStyleType);
    procedure SetLineThickness(aLineThickness: Single);
    procedure UpdateButtonStates;

  protected
    procedure ehPaletteButton_Click(Sender: TObject); virtual;

    procedure CreateControls(aParent: TppTBXSubmenuItem); override;
    procedure ExecuteAction; override;

  public
    constructor Create(aParent: TppTBXSubmenuItem); override;
    destructor Destroy; override;
    
    procedure LanguageChanged; override;

  published
    property DoubleLines: Boolean read FDoubleLines write SetDoubleLines;
    property LineStyle: TppLineStyleType read FLineStyle write SetLineStyle;
    property LineThickness: Single read FLineThickness write SetLineThickness;
    
  end;


  {TppLineStylePalette}
  TppLineStylePalette  = class(TppDesignToolPalette)
  private
    FLineStyle: TPenStyle;
    FImageList: TppToolImageList;

    procedure SetLineStyle(aLineStyle: TPenStyle);

  protected
    procedure ehPaletteButton_Click(Sender: TObject); virtual;
    procedure CreateControls(aParent: TppTBXSubmenuItem); override;
    procedure ExecuteAction; override;
    procedure SetAction(const Value: TBasicAction); override;

  public
    constructor Create(aParent: TppTBXSubmenuItem); override;
    destructor Destroy; override;
    
    procedure LanguageChanged; override;

  published
    property LineStyle: TPenStyle read FLineStyle write SetLineStyle;
    
  end;

  {TppTBXBorderItem}
  TppBorderToolItem = class(TppTBXItem)
  private
    FBorderPositions: TppBorderPositions;
    FOnBorderPositionsChanged: TNotifyEvent;

    procedure SetBorderPositions(const Value: TppBorderPositions);

  protected
    function GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;

  public
    property BorderPositions: TppBorderPositions read FBorderPositions write SetBorderPositions;

    property OnBorderPositionsChanged: TNotifyEvent read FOnBorderPositionsChanged write FOnBorderPositionsChanged;

  end;

  {TppAnchorsButton}
  TppAnchorsPaletteButton = class(TppDesignPalettButton)
  private
    FPalette: TppAnchorPalette;
    function GetAnchors: TppAnchors;
    procedure SetAnchors(aAnchors: TppAnchors);
  protected
    function CreatePalette: TppToolPalette; override;

  published
    property Anchors: TppAnchors read GetAnchors write SetAnchors;
  end;

  {TppBorderButton}
  TppBorderPaletteButton = class(TppDesignPalettButton)
  private
    FPalette: TppBorderPalette;
    function GetBorderPositions: TppBorderPositions;
    procedure SetBorderPositions(const Value: TppBorderPositions);
  protected
    function CreatePalette: TppToolPalette; override;

  published
    property BorderPositions: TppBorderPositions read GetBorderPositions write SetBorderPositions;
  end;

  {TppLineStyleButton}
  TppLineStylePaletteButton = class(TppDesignPalettButton)
  private
    FPalette: TppLineStylePalette;

    function GetLineStyle: TPenStyle;
    procedure SetLineStyle(aLineStyle: TPenStyle);
    
  protected
    function CreatePalette: TppToolPalette; override;

  published
    property LineStyle: TPenStyle read GetLineStyle write SetLineStyle;
  end;

  {TppLineStyleButton}
  TppLineThicknessPaletteButton = class(TppDesignPalettButton)
  private
    FPalette: TppLineThicknessPalette;
    function GetDoubleLines: Boolean;
    function GetLineStyle: TppLineStyleType;
    function GetLineThickness: Single;
    procedure SetDoubleLines(const Value: Boolean);
    procedure SetLineStyle(aLineStyle: TppLineStyleType);
    procedure SetLineThickness(aLineThickness: Single);
  protected
    function CreatePalette: TppToolPalette; override;

  published
    property DoubleLines: Boolean read GetDoubleLines write SetDoubleLines;
    property LineStyle: TppLineStyleType read GetLineStyle write SetLineStyle;
    property LineThickness: Single read GetLineThickness write SetLineThickness;
  end;

  {TppColorButton}
  TppColorPaletteButton = class(TppDesignPalettButton)
  private
    FColorPalette: TppColorPalette;
    function GetColor: TColor;
    function GetIsClear: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetIsClear(const Value: Boolean);
  protected
    function CreatePalette: TppToolPalette; override;
    procedure SetPaletteAction(const Value: TBasicAction); override;

  public
    constructor Create(aOwner: TComponent); override;
    
  published
    property Color: TColor read GetColor write SetColor;
    property IsClear: Boolean read GetIsClear write SetIsClear;

  end;

  {TppFontNameToolItem}
  TppFontNameToolItem = class(TppDesignComboBoxToolItem)
  private
    FPrinterGraphic: TBitmap;
    FSelPrinterGraphic: TBitmap;
    FSelTrueTypeGraphic: TBitmap;
    FTrueTypeGraphic: TBitmap;

    procedure ehDropDown(Sender: TppTBCustomItem; FromLink: Boolean);
    procedure ehDrawItem(Sender: TppTBXCustomList; ACanvas: TCanvas; ARect: TRect; AIndex, AHoverIndex: Integer; var DrawDefault: Boolean);
    procedure ehMeasureHeight(Sender: TppTBXCustomList; ACanvas: TCanvas; var AHeight: Integer);
    function GetFontName: String;
    procedure InitializeFontGraphics;

    procedure SetFontName(aFontName: String);

  protected
    procedure InitializeFontList; virtual;
    function IsValid(aText: String): Boolean; override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property FontName: String read GetFontName write SetFontName;

  end;

  {TppFontSizeToolItem}
  TppFontSizeToolItem = class(TppDesignComboBoxToolItem)
  private
  protected
    function IsValid(aText: String): Boolean; override;
 end;


  {   GradientPaletteButton
         - GradentPalette
              - StyleDropDown
              - StartColorButton (GradientColorButton)
                 - SimpleColorPalette
              - EndColorButton (GradientColorButton)
                 - SimpleColorPalette

  }

  TppGradientColorButton = class;

  {TppGradientPalette}
  TppGradientPalette = class(TppDesignToolPalette)
  private
    FEndColorButton: TppGradientColorButton;
    FGradient: TppGradient;
    FOnChange: TNotifyEvent;
    FStartColorButton: TppGradientColorButton;
    FStyleDropDown: TppTBXComboBoxItem;
    FUpdating: Boolean;

    procedure SetGradient(const Value: TppGradient);

  protected
    procedure CreateControls(aParent: TppTBXSubmenuItem); override;
    procedure ehColor_Change(Sender: TObject);
    procedure ehStyle_Change(Sender: TObject; const aText: string);
    procedure ExecuteAction; override;
    procedure GradientToControls;
    procedure SetAction(const Value: TBasicAction); override;

  public
    constructor Create(aParent: TppTBXSubmenuItem); override;
    destructor Destroy; override;
    procedure LanguageChanged; override;

  published
    property Gradient: TppGradient read FGradient write SetGradient;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  end;


  {TppGradientColorButton}
  TppGradientColorButton = class(TppDesignPalettButton)
    private
      FColorPalette: TppSimpleColorPalette;
      FOnChange: TNotifyEvent;

      function GetColor: TColor;
      procedure ReplaceButtonImage(aColor: TColor);
      procedure SetColor(const Value: TColor);

    protected
      function CreatePalette: TppToolPalette; override;
      procedure ehPalette_ColorChange(Sender: TObject);
      procedure SetName(const NewName: TComponentName); override;

    public
      constructor Create(aOwner: TComponent); override;

    published
      property Color: TColor read GetColor write SetColor;
      property OnChange: TNotifyEvent read FOnChange write FOnChange;
    end;


  {TppGradientPaletteButton}
  TppGradientPaletteButton = class(TppDesignPalettButton)
  private
    FGradientPalette: TppGradientPalette;
    function GetGradient: TppGradient;
    procedure SetGradient(const Value: TppGradient);

  protected
    function CreatePalette: TppToolPalette; override;
    procedure SetPaletteAction(const Value: TBasicAction); override;

  public
    constructor Create(aOwner: TComponent); override;

  published
    property Gradient: TppGradient read GetGradient write SetGradient;
  end;

implementation


destructor TppBorderToolChildItemViewer.Destroy;
begin

  inherited;

end;

procedure TppBorderToolChildItemViewer.InitializeCanvasPenStyle(aCanvas: TCanvas);
begin

  {set pen style based upon state}
  if (MouseOver) and (Selected) then
    begin
      aCanvas.Pen.Style := psDot;
      aCanvas.Pen.Width := 1;
      aCanvas.Pen.Color := clDkGray;
    end
  else if not(MouseOver) and (Selected) then
    begin
      aCanvas.Pen.Style := psSolid;
      aCanvas.Pen.Width := 1;
      aCanvas.Pen.Color := clBlack;
    end
  else if (MouseOver) and not(Selected) then
    begin
      aCanvas.Pen.Style := psSolid;
      aCanvas.Pen.Width := 1;
      aCanvas.Pen.Color := clDkGray;
    end
  else
    begin
      aCanvas.Pen.Style := psDot;
      aCanvas.Pen.Width := 1;
      aCanvas.Pen.Color := clLtGray;
    end;

end;

procedure TppBorderToolChildItemViewer.Paint(aCanvas: TCanvas; aClientArea: TRect);
var
  liIndex: Integer;
  liLeft: Integer;
  liTop: Integer;
begin

  inherited;

{$IFDEF CodeSite}
//  gCodeSite.Send(IntToStr(aMousePos.X) + ' ' + IntToStr(Left));
{$ENDIF}


  InitializeCanvasPenStyle(aCanvas);

  {draw border lines}
  for liIndex := 0 to 1 do
    begin

      if (Orientation = botVertical) then
        begin
          liLeft := Left +(Width div 2) + liIndex;
          aCanvas.MoveTo(liLeft, Top);
          aCanvas.LineTo(liLeft, Top+Height);
        end
      else
        begin
          liTop :=  Top + (Height div 2) + liIndex;
          aCanvas.MoveTo(Left, liTop);
          aCanvas.LineTo(Left+Width, liTop);
        end;
    end;

end;

constructor TppBorderToolItemViewer.Create(aView: TppTBView; aItem: TppTBCustomItem; aGroupLevel: Integer);
begin

  inherited;

  FItem := TppBorderToolItem(aItem);

  FLeftBorder := TppBorderToolChildItemViewer.Create(Self);
  FLeftBorder.FOrientation := botVertical;
  FLeftBorder.Left := 7+5;
  FLeftBorder.Top := 16;
  FLeftBorder.Width := 10;
  FLeftBorder.Height := 33;
  FLeftBorder.OnSelectedChanged := eh_BorderSelectedChanged;

  FTopBorder := TppBorderToolChildItemViewer.Create(Self);
  FTopBorder.FOrientation := botHorizontal;
  FTopBorder.Left := 16+5;
  FTopBorder.Top := 7;
  FTopBorder.Width := 100-4;
  FTopBorder.Height := 10;
  FTopBorder.OnSelectedChanged := eh_BorderSelectedChanged;

  FRightBorder := TppBorderToolChildItemViewer.Create(Self);
  FRightBorder.FOrientation := botVertical;
  FRightBorder.Left := 114;
  FRightBorder.Top := 16;
  FRightBorder.Width := 10;
  FRightBorder.Height := 33;
  FRightBorder.OnSelectedChanged := eh_BorderSelectedChanged;

  FBottomBorder := TppBorderToolChildItemViewer.Create(Self);
  FBottomBorder.FOrientation := botHorizontal;
  FBottomBorder.Left := 16+5;
  FBottomBorder.Top := 46;
  FBottomBorder.Width := 100-4;
  FBottomBorder.Height := 10;
  FBottomBorder.OnSelectedChanged := eh_BorderSelectedChanged;


end;

destructor TppBorderToolItemViewer.Destroy;
begin

  FLeftBorder.Free;
  FTopBorder.Free;
  FRightBorder.Free;
  FBottomBorder.Free;

  inherited;
end;

{ TppTBXControlItemViewer }

procedure TppBorderToolItemViewer.CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer);
begin
  inherited;

  aWidth := 135;
  aHeight := 65;

end;

procedure TppBorderToolItemViewer.eh_BorderSelectedChanged(Sender: TObject);
begin

  FItem.BorderPositions := GetSelectedBorderPositions;

  FBorderPositionsChanged := True;

end;

function TppBorderToolItemViewer.GetSelectedBorderPositions: TppBorderPositions;
begin
  Result := [];

  if (FLeftBorder.Selected) then
    Result := Result + [bpLeft];

  if (FTopBorder.Selected) then
    Result := Result + [bpTop];

  if (FRightBorder.Selected) then
    Result := Result + [bpRight];

  if (FBottomBorder.Selected) then
    Result := Result + [bpBottom];

end;

procedure TppBorderToolItemViewer.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;


end;

procedure TppBorderToolItemViewer.Leaving;
begin

  // when mouse leaves, call mouse up to close window
  if (FMouseUp) then
    begin
      FBorderPositionsChanged := False;
      inherited MouseUp(0, 0, True);
    end;

  inherited;
  
end;

procedure TppBorderToolItemViewer.MouseDown(Shift: TShiftState; X, Y: Integer; var MouseDownOnMenu: Boolean);
begin

//  disable inherited mouse down
//  inherited;

  FLeftBorder.MouseDown(Shift, X, Y, MouseDownOnMenu);
  FTopBorder.MouseDown(Shift, X, Y, MouseDownOnMenu);
  FRightBorder.MouseDown(Shift, X, Y, MouseDownOnMenu);
  FBottomBorder.MouseDown(Shift, X, Y, MouseDownOnMenu);


end;

procedure TppBorderToolItemViewer.MouseMove(X, Y: Integer);
begin
  inherited;

  FLeftBorder.MouseMove(X, Y);
  FTopBorder.MouseMove(X, Y);
  FRightBorder.MouseMove(X, Y);
  FBottomBorder.MouseMove(X, Y);

end;

procedure TppBorderToolItemViewer.MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean);
begin

  // if border positions changed by user, do not allow mouse up to close the popup window
   if (FBorderPositionsChanged) then
    FMouseUp := True
   else
     inherited;

end;

procedure TppBorderToolItemViewer.Paint(const Canvas: TCanvas; const ClientAreaRect: TRect; IsHoverItem, IsPushed, UseDisabledShadow: Boolean);
//var
//  lFramRect: TRect;
begin
  inherited;

  // paint white background
  Canvas.Brush.Color := clWhite;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(ClientAreaRect);

  // paint frame
//  Canvas.Brush.Color := clBlack;
//  Canvas.Brush.Style := bsSolid;

//  lFramRect :=  ClientAreaRect;
//  lFramRect.Left := ClientAreaRect.Left + 5;
//  lFramRect.Right := ClientAreaRect.Right - 5;
//  Canvas.FrameRect(lFramRect);

//  Canvas.Brush.Color := clWhite;


  // paint corners
  PaintCorners(Canvas);

  UpdateSelectedBorders(FItem.BorderPositions);

  FLeftBorder.Paint(Canvas, ClientAreaRect);
  FTopBorder.Paint(Canvas, ClientAreaRect);
  FRightBorder.Paint(Canvas, ClientAreaRect);
  FBottomBorder.Paint(Canvas, ClientAreaRect);


end;

procedure TppBorderToolItemViewer.PaintCorners(aCanvas: TCanvas);
var
  liLeftOffSet: Integer;
begin

  inherited;

  liLeftOffSet := 5;

  aCanvas.Pen.Color := clDKGray;
  aCanvas.Pen.Style := psSolid;

  // left corner
  aCanvas.MoveTo(liLeftOffSet+12, 4);
  aCanvas.LineTo(liLeftOffSet+12, 12);
  aCanvas.LineTo(liLeftOffSet+4, 12);
  aCanvas.MoveTo(liLeftOffSet+13, 3);
  aCanvas.LineTo(liLeftOffSet+13, 13);
  aCanvas.LineTo(liLeftOffSet+3, 13);

  // right corner
  // xoffset = 118
  aCanvas.MoveTo(120, 4);
  aCanvas.LineTo(120, 12);
  aCanvas.LineTo(128, 12);
  aCanvas.MoveTo(119, 3);
  aCanvas.LineTo(119, 13);
  aCanvas.LineTo(129, 13);

  // left bottom
  // yoffset = 50
  aCanvas.MoveTo(liLeftOffSet+4, 52);
  aCanvas.LineTo(liLeftOffSet+12, 52);
  aCanvas.LineTo(liLeftOffSet+12, 60);
  aCanvas.MoveTo(liLeftOffSet+3, 51);
  aCanvas.LineTo(liLeftOffSet+13, 51);
  aCanvas.LineTo(liLeftOffSet+13, 61);

  // right bottom
  // xoffset = 118
  // yoffset = 50
  aCanvas.MoveTo(128, 52);
  aCanvas.LineTo(120, 52);
  aCanvas.LineTo(120, 60);
  aCanvas.MoveTo(129, 51);
  aCanvas.LineTo(119, 51);
  aCanvas.LineTo(119, 61);


end;

procedure TppBorderToolItemViewer.UpdateSelectedBorders(aBorderPositions:TppBorderPositions);
begin

  FLeftBorder.Selected    := bpLeft in aBorderPositions;
  FTopBorder.Selected     := bpTop in aBorderPositions;
  FRightBorder.Selected  := bpRight in aBorderPositions;
  FBottomBorder.Selected := bpBottom in aBorderPositions;

end;

{******************************************************************************
 *
 **  B o r d e r  P a l e t te  T B X
 *
{******************************************************************************}

constructor TppBorderPalette.Create(aParent: TppTBXSubmenuItem);
begin

  inherited;

  FImageList := TppToolImageList.CreateSize(135, 20);

  // all button image
  FAllButtonImage := TBitmap.Create;
  FAllButtonImage.Width  := 135;
  FAllButtonImage.Height := 20;
  DrawButtonImage(FAllButtonImage, clBlack, ppLoadStr(1155)); {All}

  // none button image
  FNoneButtonImage := TBitmap.Create;
  FNoneButtonImage.Width  := 135;
  FNoneButtonImage.Height := 20;
  DrawButtonImage(FNoneButtonImage, clSilver, ppLoadStr(474)); {None}

  CreateControls(aParent);

end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.Destroy}

destructor TppBorderPalette.Destroy;
begin

  FAllButtonImage.Free;
  FNoneButtonImage.Free;

  FImageList.Free;

  inherited;
end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.CreateControls}

procedure TppBorderPalette.CreateControls(aParent: TppTBXSubmenuItem);
begin

  // auto color button
  FAllButton := AddButton();
  FAllButton.Options := [tboToolbarStyle];
  FAllButton.Images := FImageList;
  FAllButton.ImageIndex := FImageList.AddMasked(FAllButtonImage, clRed);
  FAllButton.OnClick := ehAllButton_Click;

  FNoneButton := AddButton();
  FNoneButton.Options := [tboToolbarStyle];
  FNoneButton.Images := FImageList;
  FNoneButton.ImageIndex := FImageList.AddMasked(FNoneButtonImage, clRed);
  FNoneButton.OnClick := ehNoneButton_Click;

  FBorderItem := TppBorderToolItem.Create(nil);
  FBorderItem.OnBorderPositionsChanged := ehBorderItem_PositionsChanged;
  Parent.Add(FBorderItem);

end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.DrawButtonImage}

procedure TppBorderPalette.DrawButtonImage(aBitmap: TBitmap; aColor: TColor; aCaption: String);
var
  liLeft: Integer;
  liTop: Integer;
  liSide: Integer;
begin

  {draw a gray frame to outline the button}
  aBitmap.Canvas.Brush.Style := bsSolid;
  aBitmap.Canvas.Brush.Color := clGray;
  aBitmap.Canvas.FrameRect(Rect(2,2,aBitmap.Width-3, aBitmap.Height-2));

  liSide := aBitmap.Height - 5;
  aBitmap.Canvas.Brush.Color := aColor;
  aBitmap.Canvas.FrameRect(Rect(5, 4, liSide + 1, liSide));

  aBitmap.Canvas.Brush.Style := bsClear;
  aBitmap.Canvas.Pen.Style := psSolid;
  aBitmap.Canvas.Pen.Color := clSilver;
  aBitmap.Canvas.MoveTo(6, 9);
  aBitmap.Canvas.LineTo(liSide, 9);
  aBitmap.Canvas.MoveTo(10, 5);
  aBitmap.Canvas.LineTo(10, liSide-1);

  // draw caption
  aBitmap.Canvas.Font.Size  := 8;

  liLeft := (aBitmap.Width  - aBitmap.Canvas.TextWidth(aCaption)) div 2;
  liTop  := (aBitmap.Height - aBitmap.Canvas.TextHeight(aCaption)) div 2;

  aBitmap.Canvas.TextOut(liLeft, liTop, aCaption);

end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.ehAllButton_Click}

procedure TppBorderPalette.ehAllButton_Click(Sender: TObject);
begin
  FBorderItem.BorderPositions := [bpLeft, bpTop, bpRight, bpBottom];

end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.ehBorderItem_PositionsChanged}

procedure TppBorderPalette.ehBorderItem_PositionsChanged(Sender: TObject);
begin

  FAllButton.Checked  := FBorderItem.BorderPositions = [bpLeft, bpTop, bpRight, bpBottom];
  FNoneButton.Checked := FBorderItem.BorderPositions = [];

  ExecuteAction();
  
end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.ehNoneButton_Click}

procedure TppBorderPalette.ehNoneButton_Click(Sender: TObject);
begin
  FBorderItem.BorderPositions := [];

end;

{------------------------------------------------------------------------------}
{ TppColorPalette.ExecuteAction}

procedure TppBorderPalette.ExecuteAction;
begin

  if (Action is TppBorderAction) then
    TppBorderAction(Action).BorderPositions := FBorderItem.BorderPositions;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.GetBorderPositions}

function TppBorderPalette.GetBorderPositions: TppBorderPositions;
begin
  Result := FBorderItem.BorderPositions;
end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.LanguageChanged}

procedure TppBorderPalette.LanguageChanged;
begin

  DrawButtonImage(FAllButtonImage, clBlack, ppLoadStr(1155)); {All}
  DrawButtonImage(FNoneButtonImage, clSilver, ppLoadStr(474)); {None}

  FImageList.ReplaceMasked(FAllButton.ImageIndex, FAllButtonImage, clRed);
  FImageList.ReplaceMasked(FNoneButton.ImageIndex, FNoneButtonImage, clRed);

end;  {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppBorderPalette.SetAction}

procedure TppBorderPalette.SetAction(const Value: TBasicAction);
begin

  inherited;

  // update the palette line style
  if (Action is TppBorderAction) then
    SetBorderPositions(TppBorderAction(Action).BorderPositions);

end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.SetBorderPositions}

procedure TppBorderPalette.SetBorderPositions(const Value: TppBorderPositions);
begin

  FBorderItem.BorderPositions := Value;

end;

{------------------------------------------------------------------------------}
{ TppColorPalette.AutoButtonClickEvent}

procedure TppColorPalette.ehAutoButton_Click(Sender: TObject);
begin

  if (FColorType = ctFont) then
    SetColor(clWindowText)
  else
    SetColor(clWindow);

  ExecuteAction();

end; {procedure, AutoButtonClickEvent}

{------------------------------------------------------------------------------}
{ TppColorPalette.CreateControls}

procedure TppColorPalette.CreateControls(aParent: TppTBXSubmenuItem);
var
  lSeparator: TppTBXSeparatorItem;
begin

  // auto color button
  FAutoButton := AddButton();
  FAutoButton.OnClick := ehAutoButton_Click;
  FAutoButton.Checked := True;

  lSeparator := AddSeparator();
  lSeparator.Size := -1;
  lSeparator.Blank := True;

  inherited CreateControls(aParent);


end;

{------------------------------------------------------------------------------}
{ TppColorPalette.LanguageChanged}

procedure TppColorPalette.LanguageChanged;
var
  liAuto: Integer;
  liMoreColors: Integer;
begin

//  TitleBarHint := ppLoadStr(207);   {drag to make window float}

  case FColorType of

    ctFont:
      begin
        liAuto := 472;        {Automatic};
        liMoreColors := 473   {More Font Colors...}
      end;

    ctHighlight:
      begin
        liAuto := 474;        {None}
        liMoreColors := 475;  {More Highlight Colors...}
      end;

   ctFill:
      begin
        liAuto := 476;        {No Fill}
        liMoreColors := 477;  {More Fill Colors...}
      end;

   else {ptLine: }
      begin
        liAuto := 478;        {No Line}
        liMoreColors := 479;  {More Line Colors...}
      end

  end; {case, PaletteType}


  FAutoButton.Caption := ppLoadStr(liAuto);
  FMoreColorsButton.Caption  := ppLoadStr(liMoreColors);


end;  {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppColorPalette.ExecuteAction}

procedure TppColorPalette.ExecuteAction;
begin

  if (Action is TppColorAction) then
    begin
      TppColorAction(Action).Color := FColor;
      TppColorAction(Action).IsClear := FIsClear;
    end;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppColorPalette.SetAction}

procedure TppColorPalette.SetAction(const Value: TBasicAction);
begin

  inherited;

  if (Value is TppColorAction) then
    SetColorType(TppColorAction(Value).ColorType);

end;

{------------------------------------------------------------------------------}
{ TppColorPalette.SetCurrentColor}

procedure TppColorPalette.SetColor(aColor: TColor);
begin
  if (aColor = clNone) then
    begin
       if (FColorType = ctFont) then
        aColor := clWindowText
      else
        aColor := clWindow;
    end;

  if (FColor = aColor) then Exit;

  FColor := aColor;

  if (FColorType = ctFont) then
     FAutoButton.Checked := (FColor = clWindowText)
  else
     FAutoButton.Checked := (FColor = clWindow);


  if FAutoButton.Checked then
    begin
      if (FTBXColorPalette.Color <> FColor) then
        FTBXColorPalette.Color := clNone;
      FIsClear := (FColorType <> ctFont);
    end
  else
    begin
      if (FTBXColorPalette.Color <> FColor) then
        FTBXColorPalette.Color := FColor;
      FIsClear := False;
    end;


end; {procedure, SetCurrentColor}

{------------------------------------------------------------------------------}
{ TppColorPalette.SetIsClear}

procedure TppColorPalette.SetIsClear(aValue: Boolean);
begin

  if (FIsClear = aValue) then Exit;

  FIsClear := aValue;

  
end; {procedure, SetCurrentColor}

{------------------------------------------------------------------------------}
{ TppColorPalette.SetPaletteType}

procedure TppColorPalette.SetColorType(const aPaletteType:
    TppColorButtonType);
begin

  FColorType := aPaletteType;

  FIsClear      := (FColorType <> ctFont);
  FColor := clWindowText;

  {load button strings}
  LanguageChanged;

end; {procedure, SetPaletteType}


{------------------------------------------------------------------------------}
{ TppAnchorsPaletteButton.CreatePalette}

function TppAnchorsPaletteButton.CreatePalette: TppToolPalette;
begin

  FPalette := TppAnchorPalette.Create(Self);

  Result := FPalette;

end;

{------------------------------------------------------------------------------}
{ TppAnchorsPaletteButton.GetAnchors}

function TppAnchorsPaletteButton.GetAnchors: TppAnchors;
begin

  if (FPalette <> nil) then
    Result := FPalette.Anchors
  else
    Result := [];

end;

{------------------------------------------------------------------------------}
{ TppAnchorsPaletteButton.SetAnchors}

procedure TppAnchorsPaletteButton.SetAnchors(aAnchors: TppAnchors);
begin

  if (FPalette <> nil) then
    FPalette.Anchors := aAnchors;

end;


{------------------------------------------------------------------------------}
{ TppAnchorPalette.Create}

constructor TppAnchorPalette.Create(aParent: TppTBXSubmenuItem);
begin

  inherited Create(aParent);

  FImageList := TppToolImageList.Create(nil);

  InitializeImageList();

  FTBXPalette := TppToolPaletteTBXMultiSelect.Create(nil);
  FTBXPalette.RowCount := 3;
  FTBXPalette.ColCount := 3;
  FTBXPalette.Images := FImageList;
  FTBXPalette.OnCellClick := ehPaletteCell_Click;

  Parent.Add(FTBXPalette);

  FAnchors := [atLeft, atTop];

end;

{------------------------------------------------------------------------------}
{ TppAnchorPalette.Destroy}

destructor TppAnchorPalette.Destroy;
begin

  FImageList.Free;

  inherited Destroy;

end; {destructor, Destroy}

procedure TppAnchorPalette.AnchorsToPalette;
begin

  // LeftTop
  FTBXPalette.SelectedCells[0, 0] := (atLeft in FAnchors) and (atTop in FAnchors) and not(atBottom in FAnchors) and not(atRight in FAnchors);

  // RightTop
  FTBXPalette.SelectedCells[0, 2] := (atRight in FAnchors) and (atTop in FAnchors) and not(atBottom in FAnchors) and not(atLeft in FAnchors);

  // LeftBottom
  FTBXPalette.SelectedCells[2, 0] := (atLeft in FAnchors) and (atBottom in FAnchors) and not(atTop in FAnchors) and not(atRight in FAnchors);

  // RightBottom
  FTBXPalette.SelectedCells[2, 2] := (atRight in FAnchors) and (atBottom in FAnchors) and not(atTop in FAnchors) and not(atLeft in FAnchors);


  // Left
  FTBXPalette.SelectedCells[1, 0] := (atLeft in FAnchors) and not(FTBXPalette.SelectedCells[0, 0]) and not(FTBXPalette.SelectedCells[2, 0]);

  // Right
  FTBXPalette.SelectedCells[1, 2] := (atRight in FAnchors) and not(FTBXPalette.SelectedCells[0, 2]) and not(FTBXPalette.SelectedCells[2, 2]);


  // Top
  FTBXPalette.SelectedCells[0, 1] := (atTop in FAnchors) and not(FTBXPalette.SelectedCells[0, 0]) and not(FTBXPalette.SelectedCells[0, 2]);

  // Bottom
  FTBXPalette.SelectedCells[2, 1] := (atBottom in FAnchors) and not(FTBXPalette.SelectedCells[2, 0]) and not(FTBXPalette.SelectedCells[2, 2]);

  // center
  FTBXPalette.SelectedCells[1, 1] := False; // always de-select


end;

{------------------------------------------------------------------------------}
{ TppAnchorPalette.ehPaletteCell_Click}

procedure TppAnchorPalette.ehPaletteCell_Click(Sender: TppTBXCustomToolPalette; var aCol, aRow: Integer; var AllowChange: Boolean);
begin

  FAnchors := [];

  PaletteToAnchors;

  AnchorsToPalette;

  ExecuteAction();

end;

{------------------------------------------------------------------------------}
{ TppAnchorPalette.ExecuteAction}

procedure TppAnchorPalette.ExecuteAction;
begin

  if (Action is TppAnchorAction) then
    TppAnchorAction(Action).Anchors := FAnchors;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppAnchorPalette.InitializeImageList}

procedure TppAnchorPalette.InitializeImageList;
var
  liIndex: Integer;
  lBitmap: TBitmap;
  lMaskColor: TColor;
begin

  // get mask color from the first bitmap
  lBitmap := TBitmap.Create;

  try
    lBitmap.Handle := ppBitmapFromResource(cAnchorResNames[0]);
    lMaskColor := lBitmap.TransparentColor;
    
  finally
    lBitmap.Free;

  end;

  for liIndex := 0 to 8 do
    FImageList.AddTool(cAnchorResNames[liIndex], lMaskColor);

end;

procedure TppAnchorPalette.PaletteToAnchors;
var
  liRow: Integer;
  liCol: Integer;
begin

  FAnchors := [];

  if FTBXPalette.SelectedCells[1, 1] then Exit;

  // palette to anchors
  for liRow := 0 to FTBXPalette.RowCount - 1 do
    for liCol := 0 to FTBXPalette.ColCount - 1 do
      if FTBXPalette.SelectedCells[liRow, liCol] then
        FAnchors := FAnchors + cAnchors[liRow, liCol];

end;

{------------------------------------------------------------------------------}
{ TppAnchorPalette.SetAnchors}

procedure TppAnchorPalette.SetAnchors(aAnchors: TppAnchors);
begin

  if (FAnchors = aAnchors) then Exit;

  FAnchors := aAnchors;

  AnchorsToPalette();

  FTBXPalette.Invalidate;

end;

{******************************************************************************
 *
 **  Line Thickness Palette TBX
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.Create}

constructor TppLineThicknessPalette.Create(aParent: TppTBXSubmenuItem);
begin

  inherited;

  FImageList := TppToolImageList.Create(nil);
  FImageList.Height := 12;
  FImageList.Width := 125;

  CreateControls(aParent);

end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.Destroy}

destructor TppLineThicknessPalette.Destroy;
begin

  FImageList.Free;

  inherited;
end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.ButtonClickEvent}

procedure TppLineThicknessPalette.ehPaletteButton_Click(Sender: TObject);
var
  liIndex: Integer;
  lButton: TppTBXItem;
begin

  lButton := TppTBXItem(Sender);
  lButton.Checked := True;

  liIndex := lButton.Tag;

  FLineThickness := cLineThickness[liIndex];
  FLineStyle     := cLineThicknessStyle[liIndex];

  ExecuteAction();

end;  {procedure, ButtonClickEvent}

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.CreateControls}

procedure TppLineThicknessPalette.CreateControls(aParent: TppTBXSubmenuItem);
var
  liIndex: Integer;
  lButton: TppTBXItem;
begin

  for liIndex := 0 to 12 do
    begin

      {create button}
      lButton := AddButton();
      lButton.MinHeight := 16;
      lButton.MinWidth := 128;
      lButton.GroupIndex := 1;
      lButton.Tag := liIndex;
      lButton.OnClick := ehPaletteButton_Click;

      //load button image
      lButton.Images := FImagelist;
      lButton.ImageIndex := FImageList.AddTool(cLineThicknessResNames[liIndex]);

    end; {for each button}


end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.ExecuteAction}

procedure TppLineThicknessPalette.ExecuteAction;
begin

  if (Action is TppLineThicknessAction) then
    begin
      TppLineThicknessAction(Action).LineStyle := FLineStyle;
      TppLineThicknessAction(Action).LineThickness := FLineThickness;
    end;

  inherited;
end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.LanguageChanged}

procedure TppLineThicknessPalette.LanguageChanged;
begin


end;  {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.SetDoubleLines}

procedure TppLineThicknessPalette.SetDoubleLines(const Value: Boolean);
begin
  if FDoubleLines <> Value then
  begin
    FDoubleLines := Value;
    UpdateButtonStates;

  end;
end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.SetLineStyle}

procedure TppLineThicknessPalette.SetLineStyle(aLineStyle: TppLineStyleType);
begin

  if (FLineStyle = aLineStyle) then Exit;

  FLineStyle := aLineStyle;

  UpdateButtonStates;

end;  {procedure, SetCurrentLineStyle}

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.SetLineThickness}

procedure TppLineThicknessPalette.SetLineThickness(aLineThickness: Single);
begin

  if (FLineThickness = aLineThickness) then Exit;

  FLineThickness := aLineThickness;

  UpdateButtonStates;

end;  {procedure, SetCurrentLineThickness}

{------------------------------------------------------------------------------}
{ TppLineThicknessPalette.UpdateButtonStates}

procedure TppLineThicknessPalette.UpdateButtonStates;
var
  liIndex: Integer;
begin

  Parent.Items[10].Enabled := FDoubleLines;
  Parent.Items[11].Enabled := FDoubleLines;
  Parent.Items[12].Enabled := FDoubleLines;

  for liIndex := 0 to Parent.Count-1 do
    if (cLineThickness[liIndex]      = FLineThickness) and
       (cLineThicknessStyle[liIndex] = FLineStyle) then
      Parent.Items[liIndex].Checked := True
    else
      Parent.Items[liIndex].Checked := False;


end;  {procedure, UpdateButtonStates}

{******************************************************************************
 *
 **  Line Style Palette TBX
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLineStylePalette.Create}

constructor TppLineStylePalette.Create(aParent: TppTBXSubmenuItem);
begin

  inherited;

  FImageList := TppToolImageList.Create(nil);
  FImageList.Height := 12;
  FImageList.Width := 94;

  CreateControls(aParent);

end;

{------------------------------------------------------------------------------}
{ TppLineStylePalette.Destroy}

destructor TppLineStylePalette.Destroy;
begin

  FImageList.Free;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppLineStylePalette.ButtonClickEvent}

procedure TppLineStylePalette.ehPaletteButton_Click(Sender: TObject);
var
  liIndex: Integer;
  lButton: TppTBXItem;
begin

  lButton := TppTBXItem(Sender);
  lButton.Checked := True;

  liIndex := lButton.Tag;

  SetLineStyle(cLineStyle[liIndex]);

  ExecuteAction();

end;  {procedure, ButtonClickEvent}

{------------------------------------------------------------------------------}
{ TppLineStylePalette.CreateControls}

procedure TppLineStylePalette.CreateControls(aParent: TppTBXSubmenuItem);
var
  liIndex: Integer;
  lButton: TppTBXItem;
begin

  for liIndex := 0 to 4 do
    begin

      {create button}
      lButton := AddButton();

      lButton.MinHeight := 14;
      lButton.MinWidth := 98;
      lButton.GroupIndex := 1;
      lButton.Tag := liIndex;
      lButton.OnClick := ehPaletteButton_Click;

      //load button image
      lButton.Images := FImagelist;
      lButton.ImageIndex := FImageList.AddTool(cLineStyleResNames[liIndex]);

    end; {for each button}

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TppLineStylePalette.ExecuteAction}

procedure TppLineStylePalette.ExecuteAction;
begin

  // update the action's line style and execute
  if (Action is TppLineStyleAction) then
    TppLineStyleAction(Action).LineStyle := FLineStyle;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppLineStylePalette.LanguageChanged}

procedure TppLineStylePalette.LanguageChanged;
begin


end;  {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppColorPalette.SetAction}

procedure TppLineStylePalette.SetAction(const Value: TBasicAction);
begin

  inherited;

  // update the palette line style
  if (Action is TppLineStyleAction) then
    SetLineStyle(TppLineStyleAction(Action).LineStyle);

end;

{------------------------------------------------------------------------------}
{ TppLineStylePalette.SetLineStyle}

procedure TppLineStylePalette.SetLineStyle(aLineStyle: TPenStyle);
var
  liIndex: Integer;
begin

  if (FLineStyle = aLineStyle) then Exit;

  // update the palette buttons
  FLineStyle := aLineStyle;

  for liIndex := 0 to Parent.Count-1 do
    if cLineStyle[liIndex] = aLineStyle then
      Parent.Items[liIndex].Checked := True;


end;  {procedure, SetCurrentLineStyle}


{******************************************************************************
 *
 **  Border Item
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBorderToolItem.GetItemViewerClass}

function TppBorderToolItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  Result := TppBorderToolItemViewer;

end;

{------------------------------------------------------------------------------}
{ TppBorderToolItem.SetBorderPositions}

procedure TppBorderToolItem.SetBorderPositions(const Value: TppBorderPositions);
begin

  if (FBorderPositions <> Value) then
    begin
      FBorderPositions := Value;
      Invalidate;

      if Assigned(FOnBorderPositionsChanged) then FOnBorderPositionsChanged(Self);

    end;

end;

{------------------------------------------------------------------------------}
{ TppLineStylePaletteButton.CreatePalette}

function TppLineStylePaletteButton.CreatePalette: TppToolPalette;
begin

  FPalette := TppLineStylePalette.Create(Self);
  Result := FPalette;

end;

{------------------------------------------------------------------------------}
{ TppLineStylePaletteButton.GetLineStyle}

function TppLineStylePaletteButton.GetLineStyle: TPenStyle;
begin

  if (FPalette <> nil) then
    Result := FPalette.LineStyle
  else
    Result := psSolid;

end;

{------------------------------------------------------------------------------}
{ TppLineStylePaletteButton.SetLineStyle}

procedure TppLineStylePaletteButton.SetLineStyle(aLineStyle: TPenStyle);
begin

  if (FPalette <> nil) then
    FPalette.LineStyle := aLineStyle;

end;  {procedure, SetCurrentLineStyle}

{------------------------------------------------------------------------------}
{ TppLineThicknessPaletteButton.CreatePalette}

function TppLineThicknessPaletteButton.CreatePalette: TppToolPalette;
begin

  FPalette := TppLineThicknessPalette.Create(Self);
  Result := FPalette;

end; 

{------------------------------------------------------------------------------}
{ TppLineThicknessPaletteButton.GetDoubleLines}

function TppLineThicknessPaletteButton.GetDoubleLines: Boolean;
begin
  if (FPalette <> nil) then
    Result := FPalette.DoubleLines
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPaletteButton.GetLineStyle}

function TppLineThicknessPaletteButton.GetLineStyle: TppLineStyleType;
begin
  if (FPalette <> nil) then
    Result := FPalette.LineStyle
  else
    Result := lsSingle;
end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPaletteButton.GetLineThickness}

function TppLineThicknessPaletteButton.GetLineThickness: Single;
begin
  if (FPalette <> nil) then
    Result := FPalette.LineThickness
  else
    Result := 1.0;
end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPaletteButton.SetDoubleLines}

procedure TppLineThicknessPaletteButton.SetDoubleLines(const Value: Boolean);
begin

  if (FPalette <> nil) then
    FPalette.DoubleLines := Value;

end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPaletteButton.SetLineStyle}

procedure TppLineThicknessPaletteButton.SetLineStyle(aLineStyle: TppLineStyleType);
begin

  if (FPalette <> nil) then
    FPalette.LineStyle := aLineStyle;

end;

{------------------------------------------------------------------------------}
{ TppLineThicknessPaletteButton.SetLineThickness}

procedure TppLineThicknessPaletteButton.SetLineThickness(aLineThickness: Single);
begin

  if (FPalette <> nil) then
    FPalette.LineThickness := aLineThickness;

end; 

{******************************************************************************
 *
 **  Color Button
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppColorPaletteButton.Create}

constructor TppColorPaletteButton.Create(aOwner: TComponent);
begin

  inherited;

  DropDownCombo := True;
  Options := [tboToolbarStyle, tboDropDownArrow];

end;

{------------------------------------------------------------------------------}
{ TppColorPaletteButton.CreatePalette}

function TppColorPaletteButton.CreatePalette: TppToolPalette;
begin

  FColorPalette := TppColorPalette.Create(Self);
  Result := FColorPalette;

end; {procedure, CreatePalette}

{------------------------------------------------------------------------------}
{ TppColorPaletteButton.GetColor}

function TppColorPaletteButton.GetColor: TColor;
begin

  if (FColorPalette <> nil) then
    Result := FColorPalette.Color
  else
    Result := clBlack;

end;

{------------------------------------------------------------------------------}
{ TppColorPaletteButton.GetIsClear}

function TppColorPaletteButton.GetIsClear: Boolean;
begin
  if (FColorPalette <> nil) then
    Result := FColorPalette.IsClear
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppColorPaletteButton.SetColor}

procedure TppColorPaletteButton.SetColor(const Value: TColor);
begin

  if (FColorPalette <> nil) then
    FColorPalette.Color := Value;

end;

{------------------------------------------------------------------------------}
{ TppColorPaletteButton.SetIsClear}

procedure TppColorPaletteButton.SetIsClear(const Value: Boolean);
begin
  if (FColorPalette <> nil) then
    FColorPalette.IsClear := Value;
end;

{------------------------------------------------------------------------------}
{ TppColorButton.SetPaletteAction}

procedure TppColorPaletteButton.SetPaletteAction(const Value: TBasicAction);
begin

  inherited;

  // when button is clicked, want to fire the color action
  Action := Value;

end;

{******************************************************************************
 *
 **  B o r d e r   B u t t o n
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBorderButton.CreatePalette}

function TppBorderPaletteButton.CreatePalette: TppToolPalette;
begin
  FPalette := TppBorderPalette.Create(Self);
  Result := FPalette;

end; {procedure, CreatePalette}

{------------------------------------------------------------------------------}
{ TppBorderPalette.GetBorderPositions}

function TppBorderPaletteButton.GetBorderPositions: TppBorderPositions;
begin
  if (FPalette <> nil) then
    Result := FPalette.BorderPositions
  else
    Result := [];

end;

{------------------------------------------------------------------------------}
{ TppBorderPalette.SetBorderPositions}

procedure TppBorderPaletteButton.SetBorderPositions(const Value: TppBorderPositions);
begin
  if (FPalette <> nil) then
    FPalette.BorderPositions := Value;

end;

{******************************************************************************
 *
 **  F o n t N a m e  C o m b o B o x
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.Create}

constructor TppFontNameToolItem.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FTrueTypeGraphic    := TBitmap.Create;
  FPrinterGraphic     := TBitmap.Create;
  FSelPrinterGraphic  := TBitmap.Create;
  FSelTrueTypeGraphic := TBitmap.Create;

  InitializeFontGraphics;

  MaxVisibleItems := 14;
  MinListWidth := 128;
  MaxListWidth := 256;

  {attache event handlers}
  OnDrawItem    := ehDrawItem;
  OnPopup        := ehDropDown;
  OnMeasureHeight := ehMeasureHeight;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.Destroy}

destructor TppFontNameToolItem.Destroy;
begin

  FTrueTypeGraphic.Free;
  FSelTrueTypeGraphic.Free;
  FPrinterGraphic.Free;
  FSelPrinterGraphic.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.InitializeFontList }

procedure TppFontNameToolItem.InitializeFontList;
begin

  if Action is (TppFontNameAction) then
    Strings.Assign(TppFontNameAction(Action).Items);

end;

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.ehDrawItem }

procedure TppFontNameToolItem.ehDrawItem(Sender: TppTBXCustomList; ACanvas: TCanvas; ARect: TRect; AIndex, AHoverIndex: Integer; var DrawDefault:Boolean);
var
  lsItem: string;
begin
  lsItem := Strings[AIndex];
  aCanvas.Font.Size := 12;
  aCanvas.Font.Name := lsItem;
  if ppEqual(lsItem, 'Symbol') or (Pos('ding', lsItem) > 0) then
    aCanvas.Font.Name := 'Tahoma';

end;

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.DropDownEvent}

procedure TppFontNameToolItem.ehDropDown(Sender: TppTBCustomItem; FromLink: Boolean);
begin
  InitializeFontList;

end; {procedure, DropDownEvent}

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.ehMeasureHeight }

procedure TppFontNameToolItem.ehMeasureHeight(Sender: TppTBXCustomList; ACanvas: TCanvas; var AHeight: Integer);
begin
  aHeight := aHeight * 3 div 2;
end;

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.GetFontName}

function TppFontNameToolItem.GetFontName: String;
begin

  Result := Text;

end; {function, GetFontName}

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.InitializeFontGraphics }

procedure TppFontNameToolItem.InitializeFontGraphics;
begin

  {create true type font graphics (normal and selected}
  FTrueTypeGraphic.Handle    := ppBitmapFromResource('PPTRUETYPEFONT');
  FSelTrueTypeGraphic.Handle := ppBitmapFromResource('PPTRUETYPEFONT');

  {fill white space in bitmap with the Window's Highlight color}
  FSelTrueTypeGraphic.Canvas.Brush.Color := clHighlight;
  FSelTrueTypeGraphic.Canvas.Brush.Style := bsSolid;
  FSelTrueTypeGraphic.Canvas.FloodFill(0,0,clWhite,fsSurface);
  FSelTrueTypeGraphic.Canvas.FloodFill(7,7,clWhite,fsSurface);
  FSelTrueTypeGraphic.Canvas.FloodFill(6,2,clWhite,fsSurface);


  {create printer font graphics (normal and selected) }
  FPrinterGraphic.Handle    := ppBitmapFromResource('PPPRINTERFONT');
  FSelPrinterGraphic.Handle := ppBitmapFromResource('PPPRINTERFONT');

  {fill white space in bitmap with the Window's Highlight color}
  FSelPrinterGraphic.Canvas.Brush.Color := clHighlight;
  FSelPrinterGraphic.Canvas.Brush.Style := bsSolid;
  FSelPrinterGraphic.Canvas.FloodFill(0,0,clWhite,fsSurface);

end; {procedure, InitializeFontGraphics}

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.IsValid}

function TppFontNameToolItem.IsValid(aText: String): Boolean;
begin
  Result := Strings.IndexOf(aText) >= 0;
end;

{------------------------------------------------------------------------------}
{ TppFontNameToolItem.SetFontName}

procedure TppFontNameToolItem.SetFontName(aFontName: String);
var
  liIndex: Integer;
begin

  InitializeFontList;

  liIndex := Strings.IndexOf(aFontName);

  if liIndex >= 0 then
   ItemIndex := liIndex;

  Text := aFontName;


end; {procedure, SetFontName}

{------------------------------------------------------------------------------}
{ TppFontSizeToolItem.IsValid}

function TppFontSizeToolItem.IsValid(aText: String): Boolean;
begin

  Result := Strings.IndexOf(aText) >= 0;

  if not Result then
    Result := StrToIntDef(aText, 0) > 0;

end;

{******************************************************************************
 *
 **  C o l o r   P a l e t te  T B X
 *
{******************************************************************************}

constructor TppSimpleColorPalette.Create(aParent: TppTBXSubmenuItem);
begin

  inherited;

  CreateControls(aParent);

end;

{------------------------------------------------------------------------------}
{ TppSimpleColorPalette.CreateControls}

procedure TppSimpleColorPalette.CreateControls(aParent: TppTBXSubmenuItem);
var
  lSeparator: TppTBXSeparatorItem;
begin

   // color palette button grid
  FTBXColorPalette := TppTBXColorPalette.Create(nil);
  FTBXColorPalette.OnChange := ehColorButton_Click;
  Parent.Add(FTBXColorPalette);

  lSeparator := AddSeparator();
  lSeparator.Size := 7;

  // more colors button
  FMoreColorsButton := AddButton();
  FMoreColorsButton.OnClick := ehMoreColorsButton_Click;

  LanguageChanged();



end;

{------------------------------------------------------------------------------}
{ TppSimpleColorPalette.ColorButtonClickEvent}

procedure TppSimpleColorPalette.ehColorButton_Click(Sender: TObject);
begin

  SetColor(FTBXColorPalette.Color);

  ExecuteAction();

end; {procedure, ColorButtonClickEvent}

{------------------------------------------------------------------------------}
{ TppSimpleColorPalette.ehMoreColorsButton_Click}

procedure TppSimpleColorPalette.ehMoreColorsButton_Click(Sender: TObject);
var
  lColor: TColor;
begin

  lColor := FColor;

  if ShowColorDialog(lColor) then
    begin
      SetColor(lColor);
      ExecuteAction();
    end;

end; {procedure, ehMoreColorsButton_Click}

{------------------------------------------------------------------------------}
{ TppSimpleColorPalette.LanguageChanged}

procedure TppSimpleColorPalette.LanguageChanged;
begin

//  TitleBarHint := ppLoadStr(207);   {drag to make window float}

    FMoreColorsButton.Caption := 'More Colors';
//  FMoreColorsButton.Caption  := ppLoadStr(liMoreColors);


end;  {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppSimpleColorPalette.SetCurrentColor}

procedure TppSimpleColorPalette.SetColor(aColor: TColor);
begin

  if (FColor = aColor) then Exit;

  FColor := aColor;

  if Assigned(FOnColorChange) then FOnColorChange(Self);


end; {procedure, SetCurrentColor}

{------------------------------------------------------------------------------}
{ TppSimpleColorPalette.ShowColorDialog}

function TppSimpleColorPalette.ShowColorDialog(var aColor: TColor): Boolean;
var
  ldlgColor: TColorDialog;
begin

  {create color dialog}
  ldlgColor := TColorDialog.Create(nil);

  try

    ldlgColor.Color := aColor;
    ldlgColor.CustomColors := TppDesignToolColors.GetCustomColors;  // use custom colors

    Result := ldlgColor.Execute;

    if Result then
      begin
        aColor := ldlgColor.Color;
        TppDesignToolColors.SetCustomColors(ldlgColor.CustomColors); // update custom colors
      end;

  finally
    ldlgColor.Free;

  end;

end;

{******************************************************************************
 *
 **  C o l o r   P a l e t te  T B X
 *
{******************************************************************************}

constructor TppGradientPalette.Create(aParent: TppTBXSubmenuItem);
begin

  inherited;

  FGradient := TppGradient.Create(nil);

  CreateControls(aParent);


end;

destructor TppGradientPalette.Destroy;
begin

  FGradient.Free;
  FGradient := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppGradientPalette.CreateControls}

procedure TppGradientPalette.CreateControls(aParent: TppTBXSubmenuItem);
begin

  // style drop down
  FStyleDropDown := TppTBXComboBoxItem.Create(nil);
  aParent.Add(FStyleDropDown);
  FStyleDropDown.DropDownList := True;
  FStyleDropDown.Strings.Add('None');
  FStyleDropDown.Strings.Add('Horizontal');
  FStyleDropDown.Strings.Add('Vertical');
  FStyleDropDown.Loaded;
  FStyleDropDown.ItemIndex := 0;
  FStyleDropDown.OnChange := ehStyle_Change;

  // separator
  AddSeparator();

  // start color drop down
  FStartColorButton := TppGradientColorButton.Create(nil);
  FStartColorButton.Name := 'GradientStartColor';
  FStartColorButton.Caption := 'Start Color';
  aParent.Add(FStartColorButton);
  FStartColorButton.OnChange := ehColor_Change;

  // separator
  AddSeparator();

  // end color drop down
  FEndColorButton := TppGradientColorButton.Create(nil);
  FEndColorButton.Name := 'GradientEndColor';
  FEndColorButton.Caption := 'End Color';
  aParent.Add(FEndColorButton);
  FEndColorButton.OnChange := ehColor_Change;

  LanguageChanged();

end;

procedure TppGradientPalette.ehColor_Change(Sender: TObject);
begin

  if FUpdating then Exit;

  // controls to gradient
  FGradient.StartColor := FStartColorButton.Color;
  FGradient.EndColor := FEndColorButton.Color;

  ExecuteAction();

end;

procedure TppGradientPalette.ehStyle_Change(Sender: TObject; const aText: string);
begin

  // controls to gradient
  FGradient.Style := TppGradientStyle(FStyleDropDown.ItemIndex);

  ExecuteAction();

end;

{------------------------------------------------------------------------------}
{ TppGradientPalette.ExecuteAction}

procedure TppGradientPalette.ExecuteAction;
begin


  if (Action is TppGradientAction) then
    TppGradientAction(Action).Gradient := FGradient;

  // inherited calls Action.Execute
  inherited;

  if Assigned(FOnChange) then FOnChange(Self);

end;

procedure TppGradientPalette.GradientToControls;
begin

  if FUpdating then Exit;

  FUpdating := True;

  try
    // UpdateControls
    FStyleDropDown.ItemIndex := Ord(FGradient.Style);
    FStartColorButton.Color := FGradient.StartColor;
    FEndColorButton.Color := FGradient.EndColor;

  finally
    FUpdating := False;

  end;

end;

procedure TppGradientPalette.LanguageChanged;
begin
  inherited;

  // TODO: Add lang strings
  FStyleDropDown.Strings[0] := 'None';
  FStyleDropDown.Strings[1] := 'Horizontal';
  FStyleDropDown.Strings[2] := 'Vertical';

  FStartColorButton.Caption := 'Start Color';
  FEndColorButton.Caption := 'End Color';

end;

{------------------------------------------------------------------------------}
{ TppGradientPalette.SetAction}

procedure TppGradientPalette.SetAction(const Value: TBasicAction);
begin

  inherited;

  // update the palette line style
  if (Action is TppGradientAction) then
    SetGradient(TppGradientAction(Action).Gradient);

end;

procedure TppGradientPalette.SetGradient(const Value: TppGradient);
begin
  if FGradient.IsEqualTo(Value) then Exit;


  FGradient.Assign(Value);

  GradientToControls();

  if Assigned(FOnChange) then FOnChange(Self);

end;

{------------------------------------------------------------------------------}
{ TppGradientColorButton.CreatePalette}

constructor TppGradientColorButton.Create(aOwner: TComponent);
begin
  inherited;

  DropDownCombo := True;
  Options := [tboToolbarStyle, tboDropDownArrow];
  Images := ToolImageList;
  DisplayMode := nbdmImageAndText;

end;

{------------------------------------------------------------------------------}
{ TppGradientColorButton.CreatePalette}

function TppGradientColorButton.CreatePalette: TppToolPalette;
begin

  FColorPalette := TppSimpleColorPalette.Create(Self);
  FColorPalette.OnColorChange := ehPalette_ColorChange;
  Result := FColorPalette;

end; {procedure, CreatePalette}

procedure TppGradientColorButton.ehPalette_ColorChange(Sender: TObject);
begin
  SetColor(FColorPalette.Color);
end;

{------------------------------------------------------------------------------}
{ TppGradientColorButton.GetColor}

function TppGradientColorButton.GetColor: TColor;
begin

  if (FColorPalette <> nil) then
    Result := FColorPalette.Color
  else
    Result := clWhite;

end;

{------------------------------------------------------------------------------}
{ TppColorButton.ReplaceButtonImage}

procedure TppGradientColorButton.ReplaceButtonImage(aColor: TColor);
var
  lBitmap: TBitmap;
begin

  lBitMap := TBitmap.Create;
  lBitMap.Width := ToolImageList.Width;
  lBitMap.Height := ToolImageList.Height;

  try
    lBitMap.Canvas.Brush.Style := bsSolid;
    lBitMap.Canvas.Brush.Color := clCream;
    lBitMap.Canvas.FillRect(Rect(0, 0,lBitMap.Width, lBitMap.Height));

    lBitMap.Canvas.Brush.Color := aColor;

    lBitMap.Canvas.FillRect(Rect(2, 2, 12, 12));

    ToolImageList.ReplaceMasked(ImageIndex, lBitMap, clCream);

  finally
    lBitmap.Free;

  end;

end; {procedure, DrawButtonGlyph}

{------------------------------------------------------------------------------}
{ TppGradientColorButton.SetColor}

procedure TppGradientColorButton.SetColor(const Value: TColor);
begin

  if (FColorPalette <> nil) and (FColorPalette.Color <> Value) then
    FColorPalette.Color := Value;

  ReplaceButtonImage(Value);

  if Assigned(FOnChange) then FOnChange(Self);

end;

{------------------------------------------------------------------------------}
{ TppGradientColorButton.SetName}

procedure TppGradientColorButton.SetName(const NewName: TComponentName);
begin

  if Name = NewName then Exit;

  inherited;

  ImageIndex := ToolImageList.AddTool(Name, clCream);

  SetColor(clWhite);


end;

constructor TppGradientPaletteButton.Create(aOwner: TComponent);
begin
  inherited;

  DropDownCombo := True;
  Options := [tboToolbarStyle, tboDropDownArrow];

end;

{------------------------------------------------------------------------------}
{ TppColorPaletteButton.CreatePalette}

function TppGradientPaletteButton.CreatePalette: TppToolPalette;
begin

  FGradientPalette := TppGradientPalette.Create(Self);
  Result := FGradientPalette;

end;

function TppGradientPaletteButton.GetGradient: TppGradient;
begin
  Result := FGradientPalette.Gradient;
end;

procedure TppGradientPaletteButton.SetGradient(const Value: TppGradient);
begin

  if not(FGradientPalette.Gradient.IsEqualTo(Value)) then
    FGradientPalette.Gradient := Value;

end;

{------------------------------------------------------------------------------}
{ TppGradientPaletteButton.SetPaletteAction}

procedure TppGradientPaletteButton.SetPaletteAction(const Value: TBasicAction);
begin

  inherited;

  // when button is clicked, want to fire the action
  Action := Value;

end;

end.
