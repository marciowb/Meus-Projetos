{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPSRELnk;

interface

{$I cxVer.inc}

uses
  Classes, Windows, Graphics, Controls, ComCtrls, RichEdit, dxPSCore, dxPSGlbl, 
  dxPrnPg, dxPSContainerLnk, cxDrawTextUtils, cxGeometry, dxPSReportRenderCanvas;

const
  dxDefaultRichEditVersion = {$IFDEF DELPHI12} 2 {$ELSE} 1 {$ENDIF};

type
  TAbstractdxRichEditReportLink = class;

  TdxPSCustomRichEditProducer = class(TdxPSContainerCustomWinControlProducer)
  protected
    function CreateImage: TGraphic; virtual;
    procedure InitializeItem(AnItem: TdxReportVisualItem); override;
    function ItemClass: TdxReportVisualItemClass; override;
  public
    function Control: TCustomRichEdit; reintroduce; overload;
    class function ControlClass: TControlClass; override;

    function ProducingObjectFriendlyName: string; override;
  end;

  TdxPSREPageRenderInfo = class(TdxPSPageRenderInfo)
  public
    FirstChar: Integer;
    LastChar: Integer;
    DetailsTwipsRect: TRect;
    procedure AdjustTwipsRect; virtual;
    procedure Calculate; override;
    procedure CalculateBounds; override;
  end;

  TdxPSREReportLinkRenderInfo = class(TdxPSReportRenderInfo)
  private
    FDetailsTwipsRect: TRect;
    FFormatRange: TFormatRange;
    FPageSize: TPoint;
    FPageTwipsRect: TRect;
    function GetPageRenderInfo(Index: Integer): TdxPSREPageRenderInfo;
    function GetREHandle: THandle;
    function GetReportLink: TAbstractdxRichEditReportLink;

    procedure DoFormatRichEdit;
    procedure FormatRichEdit;
    procedure PrepareFormatRange;
    procedure SetupFormatRangeForNonSelection;
    procedure UnprepareFormatRange;
  protected
    FirstChar: Integer;
    LastChar: Integer;

    procedure CalculatePageRenderInfos; override;
    procedure DoCalculate; override;
    procedure Refresh; override;

    function GetPageRenderInfoClass: TdxPSPageRenderInfoClass; override;
    function GetPageColCount: Integer; override;
    function GetPageRowCount: Integer; override;
    function GetPageSize: TPoint; override;
    function GetUnitsPerInch: Integer; override;
    function GetWindowScalePair: TdxWindowScalePair; override;

    function LoMetricValueToInternalUnits(Value: Integer): Integer; override;
    
    property PageRenderInfos[Index: Integer]: TdxPSREPageRenderInfo read GetPageRenderInfo;
    property REHandle: THandle read GetREHandle;
    property ReportLink: TAbstractdxRichEditReportLink read GetReportLink;
  end;

  TdxPSREReportRenderer = class(TdxPSReportRenderer)
  private
    function GetREHandle: THandle;
    function GetPageRenderInfo: TdxPSREPageRenderInfo;
    function GetRenderInfo: TdxPSREReportLinkRenderInfo;
    function GetReportLink: TAbstractdxRichEditReportLink;
  protected
    function GetUnitsPerInch: Integer; override;
    procedure PrepareRects;
    procedure PrepareRenderPage; override;
    procedure RenderPageContent; override;
    procedure UnprepareRects;
    procedure UnprepareRenderPage; override;

    property REHandle: THandle read GetREHandle;
    property PageRenderInfo: TdxPSREPageRenderInfo read GetPageRenderInfo;    
    property RenderInfo: TdxPSREReportLinkRenderInfo read GetRenderInfo;
    property ReportLink: TAbstractdxRichEditReportLink read GetReportLink;
  end;

  TdxRichEditVersion = 1..2;

  TAbstractdxRichEditReportLink = class(TBasedxReportLink, IdxPSNativeWin32ControlHandleSupport)
  private
    FOnlySelected: Boolean;
    FRichEditVersion: TdxRichEditVersion;
    function GetHasText: Boolean;
    procedure SetOnlySelected(Value: Boolean);
    procedure SetRichEditVersion(Value: TdxRichEditVersion);
    procedure GetCharRange(var ASelStart, ASelLength: Integer);
  protected
    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure DoCustomDrawPageHeaderOrFooter(AHFObject: TCustomdxPageObject;
      ACanvas: TCanvas; APageIndex: Integer; R: TRect;
      var ADefaultDrawText, ADefaultDrawBackground: Boolean); override;
    procedure DoCustomDrawPageTitle(ACanvas: TCanvas; R: TRect;
      var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
      var AColor: TColor; AFont: TFont; var ADone: Boolean); override;
    function GetRealScaleFactor: Integer; override;
    function GetRendererClass: TdxPSReportRendererClass; override;
    function GetRenderInfoClass: TdxPSReportRenderInfoClass; override;
    procedure InternalRestoreDefaults; override;

    { IdxPSNativeWin32ControlHandleSupport }
    function GetNativeHandle: THandle;
    procedure SetNativeHandle(Value: THandle);

    function GetRichEditHandle: THandle; virtual; abstract;
    function TryLoadRichEditDLL(AVersion: Integer): Boolean;

    property HasText: Boolean read GetHasText;
  public
    constructor Create(AOwner: TComponent); override;

    class function Aggregable: Boolean; override;
    class function CanBeUsedAsStub: Boolean; override;
    class function Serializable: Boolean; override;
    function SupportsScaling: Boolean; override;

    property REHandle: THandle read GetRichEditHandle;
  published
    property OnlySelected: Boolean read FOnlySelected write SetOnlySelected default False;
    property RichEditVersion: TdxRichEditVersion read FRichEditVersion write SetRichEditVersion default dxDefaultRichEditVersion;
  end;

  TCustomdxRichEditReportLink = class(TAbstractdxRichEditReportLink)
  protected
    function GetCustomRichEdit: TCustomRichEdit; virtual;
    function GetRichEditHandle: THandle; override;

    property CustomRichEdit: TCustomRichEdit read GetCustomRichEdit;
  end;
  
  TdxRichEditReportLink = class(TCustomdxRichEditReportLink)
  private
    function GetRichEdit: TRichEdit;
  public
    property RichEdit: TRichEdit read GetRichEdit;
  end;

function GetRichEditAsGraphic(AWnd: THandle;
  ABkColor: TColor; const AMargins: TRect; AGraphicClass: TGraphicClass = nil; {TMetafile}
  AWidth: Integer = -1; AHeight: Integer = -1; AMaxHeight: Integer = -1;
  ARefDC: HDC = 0; ARichEditVersion: Integer = 1): TGraphic; overload;

implementation

uses
  Types, SysUtils, Messages, Forms, dxPSUtl, dxCore;

{ Helpers }

function GetTextLengthEx(AHandle: HWND; const ATextLengthEx: TGetTextLengthEx): Integer;
begin
  Result := SendMessage(AHandle, EM_GETTEXTLENGTHEX, WPARAM(@ATextLengthEx), 0);
end;

function GetRichEditTextLenght(AHandle: HWND; ARichEditVersion: Integer): Integer;
var
  TextLenEx: TGetTextLengthEx;
begin
  if ARichEditVersion > 1 then
  begin
    with TextLenEx do
    begin
      Flags := GTL_DEFAULT;
      CodePage := CP_ACP;
    end;
    Result := GetTextLengthEx(AHandle, TextLenEx);
  end
  else
    Result := SendMessage(AHandle, WM_GETTEXTLENGTH, 0, 0);
end;

{ Utilities }

function GetRichEditAsGraphic(AWnd: THandle;
  ABkColor: TColor; const AMargins: TRect; AGraphicClass: TGraphicClass = nil; {TMetafile}
  AWidth: Integer = -1; AHeight: Integer = -1; AMaxHeight: Integer = -1;
  ARefDC: HDC = 0; ARichEditVersion: Integer = 1): TGraphic;
const
  TwipsPerInch = 1440;

  function CalculateRichEditHeight(DC: HDC; const APPI: TPoint; AWidth: Integer;
    out AMaxChars: Integer): Integer;

    function CalculateMaxHeight: Integer;
    begin
      Result := AMaxHeight;
      if Result <> -1 then
        Result := MulDiv(Result, TwipsPerInch, APPI.Y);
    end;

  var
    CharCount, MaxHeight: Integer;
    FormatRange: TFormatRange;
  begin
    CharCount := GetRichEditTextLenght(AWnd, ARichEditVersion);
    if CharCount = 0 then
    begin
      Result := 0;
      Exit; 
    end;

    MaxHeight := CalculateMaxHeight;

    FillChar(FormatRange, SizeOf(FormatRange), 0);
    if MaxHeight = -1 then
    begin
      Result := 0;
      repeat
        FormatRange.hdc := DC;
        FormatRange.hdcTarget := DC;
        FormatRange.rc.Right := MulDiv(AWidth - (AMargins.Left + AMargins.Right), TwipsPerInch, APPI.X);
        FormatRange.rc.Bottom := TwipsPerInch;
        FormatRange.rcPage := FormatRange.rc;
        FormatRange.chrg.cpMax := -1;

        FormatRange.chrg.cpMin := SendMessage(AWnd, EM_FORMATRANGE, 0, Longint(@FormatRange));
        Inc(Result, FormatRange.rc.Bottom - FormatRange.rc.Top);
      until (FormatRange.chrg.cpMin >= CharCount) or (FormatRange.chrg.cpMin = -1);
      AMaxChars := -1;
    end
    else
    begin
      FormatRange.hdc := DC;
      FormatRange.hdcTarget := DC;
      FormatRange.rc.Right := MulDiv(AWidth - 2 * dxTextSpace, TwipsPerInch, APPI.X);
      FormatRange.rc.Bottom := MaxHeight;
      FormatRange.rcPage := FormatRange.rc;
      FormatRange.chrg.cpMax := -1;
      AMaxChars := SendMessage(AWnd, EM_FORMATRANGE, 0, Longint(@FormatRange));
      if AMaxChars = 0 then
        AMaxChars := -1;
      Result := FormatRange.rc.Bottom - FormatRange.rc.Top;
    end;
    SendMessage(AWnd, EM_FORMATRANGE, 0, 0);
    Result := MulDiv(Result, APPI.Y, TwipsPerInch) + AMargins.Top + AMargins.Bottom;
  end;

  function PrepareFormatRange(DC: HDC; const APPI: TPoint; 
    AWidth, AHeight: Integer{In Twips}; AMaxChars: Integer): TFormatRange;

    function CalculateRenderBounds(const R: TRect): TRect;
    begin
      Result := R;
      with Result do
      begin
        Inc(Left, MulDiv(AMargins.Left, TwipsPerInch, APPI.X));
        Inc(Top, MulDiv(AMargins.Top, TwipsPerInch, APPI.Y));
        Dec(Right, MulDiv(AMargins.Right, TwipsPerInch, APPI.X));
        Dec(Bottom, MulDiv(AMargins.Bottom, TwipsPerInch, APPI.Y));
      end;  
    end;
    
  begin
    FillChar(Result, SizeOf(Result), 0);
    with Result do
    begin
      Result.hdc := DC;
      Result.hdcTarget := DC;
      Result.rcPage.Right := AWidth;
      Result.rcPage.Bottom := AHeight;
      Result.rc := CalculateRenderBounds(rcPage);
      Result.chrg.cpMin := 0;
      Result.chrg.cpMax := AMaxChars;
    end;  
  end;
  
  procedure RenderRichEdit(DC: HDC; const AFormatRange: TFormatRange);
  begin
    SetMapMode(DC, MM_TEXT);
    SendMessage(AWnd, EM_FORMATRANGE, 0, 0);
    try
      SendMessage(AWnd, EM_FORMATRANGE, 1, Longint(@AFormatRange));
    finally
      SendMessage(AWnd, EM_FORMATRANGE, 0, 0);
    end;
  end;
     
  function GetRichEditAsMetafile(DC: HDC; const APPI: TPoint; AWidth, AHeight: Integer; 
    AMaxChars: Integer): TMetafile;
  const
    HundredsMMPerInch = 2540;
  var
    MetaCanvas: TMetafileCanvas;
    FormatRange: TFormatRange;
    ACalcMMWidth, ACalcMMHeight: Integer;
  begin
    Result := TMetafile.Create;
    try
      ACalcMMWidth := MulDiv(AWidth, HundredsMMPerInch, APPI.X);
      ACalcMMHeight := MulDiv(AHeight, HundredsMMPerInch, APPI.Y);
      if IsWinVistaOrLater then
      begin
        Result.Width := AWidth;
        Result.Height := AHeight;
      end
      else
      begin
        Result.MMWidth := ACalcMMWidth;
        Result.MMHeight := ACalcMMHeight;
      end;
      MetaCanvas := TMetafileCanvas.Create(Result, DC);
      try
        MetaCanvas.Brush.Color := ABkColor;
        MetaCanvas.FillRect(Rect(0, 0,  AWidth + 1, AHeight + 1));
        AWidth := MulDiv(ACalcMMWidth, TwipsPerInch, HundredsMMPerInch);
        AHeight := MulDiv(ACalcMMHeight, TwipsPerInch, HundredsMMPerInch);
        FormatRange := PrepareFormatRange(MetaCanvas.Handle, APPI, AWidth, AHeight, AMaxChars);
        RenderRichEdit(MetaCanvas.Handle, FormatRange);
      finally
        MetaCanvas.Free;
      end;
    except
      FreeAndNil(Result);
      raise;
    end;
  end;
  
  function GetRichEditAsBitmap(DC: HDC; const APPI: TPoint; AWidth, AHeight: Integer; 
    AMaxChars: Integer): TBitmap;
  var
    FormatRange: TFormatRange;
  begin
    Result := TBitmap.Create;
    try
      Result.Width := AWidth;
      Result.Height := AHeight;

      Result.Canvas.Brush.Color := ABkColor;
      Result.Canvas.FillRect(Rect(0, 0,  AWidth, AHeight));
      
      AWidth := MulDiv(AWidth, TwipsPerInch, APPI.X);
      AHeight := MulDiv(AHeight, TwipsPerInch, APPI.Y);
      FormatRange := PrepareFormatRange(Result.Canvas.Handle, APPI, AWidth, AHeight, AMaxChars);
      Result.Canvas.Handle := CreateCompatibleDC(DC);
      RenderRichEdit(Result.Canvas.Handle, FormatRange);
      Result.HandleType := bmDIB;
    except
      FreeAndNil(Result);
      raise;
    end;  
  end;

var
  DC: HDC;
  PPI: TPoint;
  R: TRect;
  W, H, MaxChars: Integer;
  Bitmap: TBitmap;
begin
  DC := ARefDC;       
  if DC = 0 then DC := GetDC(0);
  try
    PPI.X := GetDeviceCaps(DC, LOGPIXELSX);
    PPI.Y := GetDeviceCaps(DC, LOGPIXELSY);    

    W := AWidth;
    H := AHeight;
    if (W = -1) or (H = -1) then
    begin
      GetWindowRect(AWnd, R);
      with R do
      begin 
        if W = -1 then W := Right - Left;
        if H = -1 then H := CalculateRichEditHeight(DC, PPI, W, MaxChars);
      end;
    end;    

    if (H = 0) or (W = 0) then
    begin
      Result := nil;
      Exit;
    end;

    if AGraphicClass = nil then AGraphicClass := TMetafile;
    if not AGraphicClass.InheritsFrom(TMetafile) then
    begin
      Bitmap := GetRichEditAsBitmap(DC, PPI, W, H, MaxChars);
      try
        if AGraphicClass <> TBitmap then
        begin
          Result := dxPSUtl.CreateGraphic(AGraphicClass);
          try
            Result.Assign(Bitmap);
          except
            FreeAndNil(Bitmap);
            FreeAndNil(Result);
            raise;
          end;
        end
        else
          Result := Bitmap;
      finally
        if AGraphicClass <> TBitmap then Bitmap.Free;
      end;
    end
    else
      Result := GetRichEditAsMetafile(DC, PPI, W, H, MaxChars);

  finally
    if ARefDC = 0 then ReleaseDC(0, DC);
  end;
end;

{ TdxPSCustomRichEditProducer }

function TdxPSCustomRichEditProducer.Control: TCustomRichEdit;
begin
  Result := inherited Control as TCustomRichEdit;
end;

class function TdxPSCustomRichEditProducer.ControlClass: TControlClass;
begin
  Result := TCustomRichEdit;
end;

function TdxPSCustomRichEditProducer.ProducingObjectFriendlyName: string; 
begin
  Result := '';
  if not IsDesigning and (RichEdit_GetLines(Control).Count <> 0) then 
    Result := dxPSContainerLnk.dxPSMakeFriendlyNameFromStrings(RichEdit_GetLines(Control));
  if Result = '' then 
    Result := inherited ProducingObjectFriendlyName;
end;

function TdxPSCustomRichEditProducer.CreateImage: TGraphic;

  function GetMargins: TRect;
  begin
    Result := Rect(dxTextSpace, dxTextSpace, dxTextSpace, dxTextSpace);
  end;
  
  function GetMaxHeight: Integer;
  begin
    if Definition.OptionsPlace.ExpandHeight then
      Result := -1
    else
      Result := Control.ClientHeight;
  end;

begin
  Result := GetRichEditAsGraphic(Control.Handle, Control_GetColor(Control),
    GetMargins, TMetafile, Control.ClientWidth, -1, GetMaxHeight, 0,
    dxDefaultRichEditVersion);
end;  

procedure TdxPSCustomRichEditProducer.InitializeItem(AnItem: TdxReportVisualItem);
var
  Graphic: TGraphic;
begin
  inherited;
  with TdxReportCellGraphic(AnItem) do 
  begin
    CellSides := BorderStyleMap[RichEdit_GetBorderStyle(Control)];
    Color := Control_GetColor(Control);
    Graphic := Self.CreateImage;
    try
      Image := Graphic;
    finally
      Graphic.Free;
    end;
    Transparent := False;
  end;
end;

function TdxPSCustomRichEditProducer.ItemClass: TdxReportVisualItemClass;
begin
  Result := TdxReportCellGraphic;
end;

{ TdxPSREPageRenderInfo }

procedure TdxPSREPageRenderInfo.AdjustTwipsRect;
begin
  if HasTitle then
    Inc(DetailsTwipsRect.Top, MulDiv(TitleHeight, 1440, RenderInfo.UnitsPerInch));
  if HasFootnotes then
    Dec(DetailsTwipsRect.Bottom, MulDiv(FootnotesHeight, 1440, RenderInfo.UnitsPerInch));
end;

procedure TdxPSREPageRenderInfo.Calculate;
begin
  CalculateBounds;
  CalculateOffsets;
end;

procedure TdxPSREPageRenderInfo.CalculateBounds;
begin
  DetailBounds := PrinterPage.PaintRectPixels;
end;

{ TdxPSREReportLinkRenderInfo }

procedure TdxPSREReportLinkRenderInfo.CalculatePageRenderInfos;
var
  I: Integer;
begin
  FormatRichEdit;
  for I := 0 to VirtualPageCount - 1 do
    PageRenderInfos[I].Calculate;
end;

procedure TdxPSREReportLinkRenderInfo.DoCalculate;
begin
  FPageSize := inherited GetPageSize;
  CalculateTitleBounds;
  CalculateFootnotesBounds;
  CalculateHeaderAndFooterBounds;
  CalculatePageHeaderAndFooterBounds;
  CalculatePageRenderInfos;
end;

procedure TdxPSREReportLinkRenderInfo.Refresh;
begin
  inherited;
  FillChar(FFormatRange, SizeOf(TFormatRange), 0);
  FirstChar := 0;
  LastChar := 0;
  FDetailsTwipsRect := cxNullRect;
  FPageTwipsRect := cxNullRect;
end;
                                                         
function TdxPSREReportLinkRenderInfo.GetPageRenderInfoClass: TdxPSPageRenderInfoClass;
begin
  Result := TdxPSREPageRenderInfo;
end;

function TdxPSREReportLinkRenderInfo.GetPageColCount: Integer;
begin
  Result := 1;
end;

function TdxPSREReportLinkRenderInfo.GetPageRowCount: Integer;
begin
  Result := VirtualPageCount;
end;

function TdxPSREReportLinkRenderInfo.GetPageSize: TPoint;
begin
  Result := FPageSize;
end;

function TdxPSREReportLinkRenderInfo.GetUnitsPerInch: Integer;
begin
  Result := Screen.PixelsPerInch;
end;

function TdxPSREReportLinkRenderInfo.GetWindowScalePair: TdxWindowScalePair;
begin
  Result.Numerator := 100;
  Result.Denominator := 100;
end;

function TdxPSREReportLinkRenderInfo.LoMetricValueToInternalUnits(Value: Integer): Integer;
begin
  // We don't have to take into account the ScaleFactor
  Result := MulDiv(Value, UnitsPerInch, 254);
end;

function TdxPSREReportLinkRenderInfo.GetPageRenderInfo(Index: Integer): TdxPSREPageRenderInfo;
begin
  Result := inherited PageRenderInfos[Index] as TdxPSREPageRenderInfo;
end;

function TdxPSREReportLinkRenderInfo.GetREHandle: THandle;
begin
  Result := ReportLink.REHandle;
end;

function TdxPSREReportLinkRenderInfo.GetReportLink: TAbstractdxRichEditReportLink;
begin
  Result := inherited ReportLink as TAbstractdxRichEditReportLink;
end;

procedure TdxPSREReportLinkRenderInfo.DoFormatRichEdit;
var
  PageRenderInfo: TdxPSREPageRenderInfo;
begin
  VirtualPageCount := 0;
  repeat
    PageRenderInfo := CreatePageRenderInfo(VirtualPageCount) as TdxPSREPageRenderInfo;
    if VirtualPageCount = 0 then
      PageRenderInfo.FirstChar := FirstChar
    else
      PageRenderInfo.FirstChar := PageRenderInfos[VirtualPageCount - 1].LastChar;

    FFormatRange.chrg.cpMin := PageRenderInfo.FirstChar;
    FFormatRange.rcPage := FPageTwipsRect;

    PageRenderInfo.DetailsTwipsRect := FDetailsTwipsRect;
    PageRenderInfo.AdjustTwipsRect;
    FFormatRange.rc := PageRenderInfo.DetailsTwipsRect;

    PageRenderInfo.LastChar := SendMessage(REHandle, EM_FORMATRANGE, 0, Longint(@FFormatRange));
    if PageRenderInfo.LastChar > LastChar then
      PageRenderInfo.LastChar := LastChar;
    Inc(VirtualPageCount);

  until (PageRenderInfo.LastChar >= LastChar) or (PageRenderInfo.LastChar = -1);
end;

procedure TdxPSREReportLinkRenderInfo.FormatRichEdit;
begin
  PrepareFormatRange;
  try
    if LastChar > 0 then
      DoFormatRichEdit;
  finally
    UnprepareFormatRange;
  end;
end;

procedure TdxPSREReportLinkRenderInfo.PrepareFormatRange;
var
  SelStart, SelLength: Integer;
begin
  FPageTwipsRect.BottomRight := ScalePoint(PrinterPage.RealPageSizeLoMetric, 1440, 254);
  FDetailsTwipsRect := ScaleRect(PrinterPage.PaintRectLoMetric, 1440, 254, 1440, 254);

  ReportLink.GetCharRange(SelStart, SelLength);
  if SelLength <> 0 then
  begin
    FirstChar := SelStart;
    LastChar := SelStart + SelLength;
  end
  else
    SetupFormatRangeForNonSelection;

  with FFormatRange do
  begin
    hDC := GetDC(0);
    hdcTarget := hDC;
    rc := FDetailsTwipsRect;
    rcPage := FPageTwipsRect;
    if SelLength = 0 then
      chrg.cpMax := -1
    else
      chrg.cpMax := LastChar;
  end;

  SendMessage(REHandle, EM_FORMATRANGE, 0, 0);
end;

procedure TdxPSREReportLinkRenderInfo.SetupFormatRangeForNonSelection;
begin
  FirstChar := 0;
  LastChar := GetRichEditTextLenght(REHandle, ReportLink.RichEditVersion);
end;

procedure TdxPSREReportLinkRenderInfo.UnprepareFormatRange;
begin
  SendMessage(REHandle, EM_FORMATRANGE, 0, 0);
  ReleaseDC(0, FFormatRange.hDC);
end;

{ TdxPSREReportLinkRenderInfo }

function TdxPSREReportRenderer.GetUnitsPerInch: Integer;
begin
  if Canvas.IsPrinterCanvas then
    Result := PixelsPerInch 
  else
    Result := inherited GetUnitsPerInch;
end;

procedure TdxPSREReportRenderer.PrepareRects;
begin
  RenderInfo.FPageSize.X := MulDiv(RenderInfo.FPageSize.X, PixelsPerInch, UnitsPerInch);
  RenderInfo.FPageSize.Y := MulDiv(RenderInfo.FPageSize.Y, PixelsPerInch, UnitsPerInch);
  RenderInfo.PageHeaderBounds := ScaleRect(RenderInfo.PageHeaderBounds,
    PixelsPerInch, UnitsPerInch, PixelsPerInch, UnitsPerInch);
  RenderInfo.PageFooterBounds := ScaleRect(RenderInfo.PageFooterBounds,
    PixelsPerInch, UnitsPerInch, PixelsPerInch, UnitsPerInch);
  RenderInfo.TitleBounds := ScaleRect(RenderInfo.TitleBounds,
    PixelsPerInch, UnitsPerInch, PixelsPerInch, UnitsPerInch);
  RenderInfo.FootnotesBounds := ScaleRect(RenderInfo.FootnotesBounds,
    PixelsPerInch, UnitsPerInch, PixelsPerInch, UnitsPerInch);
  PageRenderInfo.TitleOffset := ScalePoint(
    PageRenderInfo.TitleOffset, PixelsPerInch, UnitsPerInch);
  PageRenderInfo.FootnotesOffset := ScalePoint(
    PageRenderInfo.FootnotesOffset, PixelsPerInch, UnitsPerInch);
end;

procedure TdxPSREReportRenderer.PrepareRenderPage;
begin
  PrepareRects;
  inherited PrepareRenderPage;
end;

procedure TdxPSREReportRenderer.RenderPageContent;
var
  AFormatRange: TFormatRange;
  ALastChar: Integer;
  AMetaFile: TMetafile;
  AMetaFileCanvas: TMetafileCanvas;
begin
  AMetaFile := TMetafile.Create;
  try
    AMetaFile.Width := RenderInfo.PageSize.X;
    AMetaFile.Height := RenderInfo.PageSize.Y;
    AMetaFileCanvas := TMetafileCanvas.Create(AMetaFile, 0);
    try
      FillChar(AFormatRange, SizeOf(TFormatRange), 0);
      AFormatRange.hdc := AMetaFileCanvas.Handle;
      AFormatRange.hdcTarget := AFormatRange.hdc;
      AFormatRange.rc := PageRenderInfo.DetailsTwipsRect;
      AFormatRange.rcPage := RenderInfo.FPageTwipsRect;
      AFormatRange.chrg.cpMin := PageRenderInfo.FirstChar;
      AFormatRange.chrg.cpMax := PageRenderInfo.LastChar;

      SendMessage(REHandle, EM_FORMATRANGE, 0, 0);
      try
        ALastChar := SendMessage(REHandle, EM_FORMATRANGE, 1, Longint(@AFormatRange));
        if PageRenderInfo.LastChar <> ALastChar then
        begin
          PageRenderInfo.LastChar := ALastChar;
          if RenderingPageIndex < RenderInfo.VirtualPageCount - 1 then
            RenderInfo.PageRenderInfos[RenderingPageIndex + 1].FirstChar := ALastChar;

          // Small trick: because Print output does not equal Preview output,
          // we should invalidate Preview window after Print-Out
          if Canvas.IsPrinterCanvas and ReportLink.ComponentPrinter.PreviewExists then
            ReportLink.ComponentPrinter.PreviewWindow.InvalidatePage(RenderingPageIndex);
        end;
      finally
        SendMessage(REHandle, EM_FORMATRANGE, 0, 0);
      end;
    finally
      AMetaFileCanvas.Free;
    end;
    Canvas.DrawPicture(AMetaFile,
      Rect(0, 0, RenderInfo.PageSize.X, RenderInfo.PageSize.Y),
      ppmCenter, PixelsNumerator, PixelsDenominator);
  finally
    AMetaFile.Free;
  end;
end;

procedure TdxPSREReportRenderer.UnprepareRects;
begin
  RenderInfo.FPageSize.X := MulDiv(RenderInfo.FPageSize.X, UnitsPerInch, PixelsPerInch);
  RenderInfo.FPageSize.Y := MulDiv(RenderInfo.FPageSize.Y, UnitsPerInch, PixelsPerInch);
  RenderInfo.PageHeaderBounds := ScaleRect(RenderInfo.PageHeaderBounds,
    UnitsPerInch, PixelsPerInch, UnitsPerInch, PixelsPerInch);
  RenderInfo.PageFooterBounds := ScaleRect(RenderInfo.PageFooterBounds,
    UnitsPerInch, PixelsPerInch, UnitsPerInch, PixelsPerInch);
  RenderInfo.FootnotesBounds := ScaleRect(RenderInfo.FootnotesBounds,
    UnitsPerInch, PixelsPerInch, UnitsPerInch, PixelsPerInch);
  RenderInfo.TitleBounds := ScaleRect(RenderInfo.TitleBounds,
    UnitsPerInch, PixelsPerInch, UnitsPerInch, PixelsPerInch);
  PageRenderInfo.TitleOffset := ScalePoint(
    PageRenderInfo.TitleOffset, UnitsPerInch, PixelsPerInch);
  PageRenderInfo.FootnotesOffset := ScalePoint(
    PageRenderInfo.FootnotesOffset, UnitsPerInch, PixelsPerInch);
end;

procedure TdxPSREReportRenderer.UnprepareRenderPage;
begin
  inherited;
  UnprepareRects;
end;

function TdxPSREReportRenderer.GetREHandle: THandle;
begin
  Result := ReportLink.REHandle;
end;

function TdxPSREReportRenderer.GetPageRenderInfo: TdxPSREPageRenderInfo;
begin
  Result := inherited PageRenderInfo as TdxPSREPageRenderInfo;
end;

function TdxPSREReportRenderer.GetRenderInfo: TdxPSREReportLinkRenderInfo;
begin
  Result := inherited RenderInfo as TdxPSREReportLinkRenderInfo;
end;

function TdxPSREReportRenderer.GetReportLink: TAbstractdxRichEditReportLink;
begin
  Result := inherited ReportLink as TAbstractdxRichEditReportLink;
end;

{ TAbstractdxRichEditReportLink }

constructor TAbstractdxRichEditReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FRichEditVersion := dxDefaultRichEditVersion;
end;

class function TAbstractdxRichEditReportLink.Aggregable: Boolean;
begin
  Result := False;
end;

class function TAbstractdxRichEditReportLink.CanBeUsedAsStub: Boolean;
begin
  Result := False;
end;

class function TAbstractdxRichEditReportLink.Serializable: Boolean;
begin
  Result := False;
end;

function TAbstractdxRichEditReportLink.SupportsScaling: Boolean;
begin
  Result := False;
end;

procedure TAbstractdxRichEditReportLink.ConstructReport(AReportCells: TdxReportCells);
begin
end;

procedure TAbstractdxRichEditReportLink.DoCustomDrawPageHeaderOrFooter(
  AHFObject: TCustomdxPageObject; ACanvas: TCanvas; APageIndex: Integer;
  R: TRect; var ADefaultDrawText, ADefaultDrawBackground: Boolean);
var
  APixelsNumerator: Integer;
begin
  APixelsNumerator := Renderer.PixelsPerInch;
  DoParentCustomDrawPageHeaderOrFooter(AHFObject, ACanvas, APageIndex, R,
    ADefaultDrawText, ADefaultDrawBackground, APixelsNumerator);
  if ADefaultDrawText or ADefaultDrawBackground then
    if AHFObject is TdxPageHeader then
    begin
      if Assigned(OnCustomDrawPageHeader) then
        OnCustomDrawPageHeader(Self, ACanvas, APageIndex, R,
          APixelsNumerator, PixelsDenominator, ADefaultDrawText,
          ADefaultDrawBackground)
    end
    else
      if Assigned(OnCustomDrawPageFooter) then
        OnCustomDrawPageFooter(Self, ACanvas, APageIndex, R,
          APixelsNumerator, PixelsDenominator, ADefaultDrawText,
          ADefaultDrawBackground);
end;

procedure TAbstractdxRichEditReportLink.DoCustomDrawPageTitle(ACanvas: TCanvas;
  R: TRect; var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
  var AColor: TColor; AFont: TFont; var ADone: Boolean);
var
  APixelsNumerator: Integer;
begin
  APixelsNumerator := Renderer.PixelsPerInch;
  DoParentCustomDrawReportTitle(ACanvas, R, ATextAlignX, ATextAlignY,
    AColor, AFont, ADone, APixelsNumerator);
  if not ADone and Assigned(OnCustomDrawReportLinkTitle) then
    OnCustomDrawReportLinkTitle(Self, ACanvas, R, APixelsNumerator,
      PixelsDenominator, ATextAlignX, ATextAlignY, AColor, AFont, ADone);
end;

function TAbstractdxRichEditReportLink.GetRealScaleFactor: Integer;
begin
  Result := 100;
end;

function TAbstractdxRichEditReportLink.GetRendererClass: TdxPSReportRendererClass;
begin
  Result := TdxPSREReportRenderer;
end;

function TAbstractdxRichEditReportLink.GetRenderInfoClass: TdxPSReportRenderInfoClass;
begin
  Result := TdxPSREReportLinkRenderInfo;
end;

procedure TAbstractdxRichEditReportLink.InternalRestoreDefaults;
begin
  inherited;
  OnlySelected := False;
end;

{ IdxPSNativeWin32ControlHandleSupport }

function TAbstractdxRichEditReportLink.GetNativeHandle: THandle;
begin
  Result := REHandle;
end;

procedure TAbstractdxRichEditReportLink.SetNativeHandle(Value: THandle);
begin
end;
    
function TAbstractdxRichEditReportLink.TryLoadRichEditDLL(AVersion: Integer): Boolean;
const
  REVersions: array[Boolean] of string = ('RICHED32.DLL', 'RICHED20.DLL');
var
  OldError: Longint;
  LibHandle: THandle;
begin  
  OldError := SetErrorMode(SEM_NOOPENFILEERRORBOX);
  try
    LibHandle := LoadLibrary(PChar(REVersions[AVersion > 1]));
    try
      if (LibHandle > 0) and (LibHandle < HINSTANCE_ERROR) then 
        LibHandle := 0;
      Result := LibHandle <> 0;
    finally
      if LibHandle <> 0 then FreeLibrary(LibHandle);
    end;  
  finally
    SetErrorMode(OldError);
  end;
end;

function TAbstractdxRichEditReportLink.GetHasText: Boolean;
begin
  Result := (REHandle <> 0) and (GetRichEditTextLenght(REHandle, RichEditVersion) > 0);
end;

procedure TAbstractdxRichEditReportLink.SetOnlySelected(Value: Boolean);
begin
  if FOnlySelected <> Value then 
  begin
    FOnlySelected := Value;
    LinkModified(True);
  end;  
end;

procedure TAbstractdxRichEditReportLink.SetRichEditVersion(Value: TdxRichEditVersion);
begin
  if FRichEditVersion <> Value then 
    if TryLoadRichEditDLL(Value) then 
    begin
      FRichEditVersion := Value;
      LinkModified(True);
    end;  
end;

procedure TAbstractdxRichEditReportLink.GetCharRange(var ASelStart, ASelLength: Integer);
var
  CharRange: TCharRange;
begin
  ASelStart := 0;
  ASelLength := 0;
  if (REHandle <> 0) and OnlySelected and HasText then
  begin
    SendMessage(REHandle, EM_EXGETSEL, 0, Longint(@CharRange));
    ASelStart := CharRange.cpMin;
    ASelLength := CharRange.cpMax - CharRange.cpMin;
  end;  
end;

{ TCustomdxRichEditReportLink }
    
function TCustomdxRichEditReportLink.GetCustomRichEdit: TCustomRichEdit;
begin
  Result := TCustomRichEdit(Component);
end;

function TCustomdxRichEditReportLink.GetRichEditHandle: THandle;
begin
  if CustomRichEdit <> nil then
  begin
    CustomRichEdit.HandleNeeded;
    Result := CustomRichEdit.Handle;
  end  
  else
    Result := 0;
end;

{ TdxRichEditReportLink }

function TdxRichEditReportLink.GetRichEdit: TRichEdit;
begin
  Result := inherited Component as TRichEdit;
end;

{ Assistants }

procedure RegisterProducers;
begin
  TdxPSCustomRichEditProducer.Register;
end;

procedure UnregisterProducers;
begin
  TdxPSCustomRichEditProducer.Unregister;
end;

initialization
  dxPSRegisterReportLink(TdxRichEditReportLink, TRichEdit, nil);
  RegisterProducers;
  
finalization
  UnregisterProducers;
  dxPSUnregisterReportLink(TdxRichEditReportLink, TRichEdit, nil);
  
end.
