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

unit dxPSPDFMetaFileParser;

interface

{$I cxVer.inc}

uses
  Types, Windows, Classes, SysUtils, Graphics, cxGraphics, dxPSCore, dxBkGnd,
  cxClasses, dxPSPDFExportCore, cxDrawTextUtils, cxGeometry, dxPSPDFExport,
  dxPSGlbl, dxPSFillPatterns, dxPSReportRenderCanvas;

type

  { TdxPSPDFMetaFileGdiObjectItem }

  TdxPSPDFMetaFileGdiObjectItem = class(TObject)
  private
    FColor: TColor;
    FHandle: THandle;
    FSourceObject: TObject;
  public
    constructor Create(AHandle: THandle; ASourceObject: TObject; AColor: TColor);
    destructor Destroy; override;
    //
    property Color: TColor read FColor;
    property Handle: THandle read FHandle;
    property SourceObject: TObject read FSourceObject;
  end;

  { TdxPSPDFMetaFileGdiObjectList }

  TdxPSPDFMetaFileGdiObjectList = class(TList)
  private
    function GetItem(Index: Integer): TdxPSPDFMetaFileGdiObjectItem;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    function CreateBrush(const ABrushInfo: TLogBrush): HBRUSH;
    function CreateFont(const AFontInfo: TExtLogFontW): HFONT;
    function CreatePen(const APenInfo: TLogPen): HPEN;
    function CreatePenEx(const APenInfo: TExtLogPen): HPEN;
    function FindObject(AHandle: THandle; var AObject: TdxPSPDFMetaFileGdiObjectItem): Boolean;
    //
    property Items[Index: Integer]: TdxPSPDFMetaFileGdiObjectItem read GetItem;
  end;

  { TdxPSPDFMetaFileCanvasState }

  TdxPSPDFMetaFileCanvasState = class(TObject)
  private
    FBackgroundColor: TColor;
    FBackgroundMode: Integer;
    FBrush: TBrush;
    FMapMode: Integer;
    FPen: TPen;
    FPolyFillMode: Integer;
    FTextColor: TColor;
    FTransform: TXForm;
    FViewPortExt: TSize;
    FViewPortOrg: TPoint;
    FWindowExt: TSize;
    FWindowOrg: TPoint;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(ASource: TdxPSPDFMetaFileCanvasState);
    function Clone: TdxPSPDFMetaFileCanvasState;
    //
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property BackgroundMode: Integer read FBackgroundMode write FBackgroundMode;
    property Brush: TBrush read FBrush;
    property MapMode: Integer read FMapMode write FMapMode;
    property Pen: TPen read FPen;
    property PolyFillMode: Integer read FPolyFillMode write FPolyFillMode;
    property TextColor: TColor read FTextColor write FTextColor;
    property Transform: TXForm read FTransform write FTransform;
    property ViewPortExt: TSize read FViewPortExt write FViewPortExt;
    property ViewPortOrg: TPoint read FViewPortOrg write FViewPortOrg;
    property WindowExt: TSize read FWindowExt write FWindowExt;
    property WindowOrg: TPoint read FWindowOrg write FWindowOrg;
  end;

  { TdxPSPDFMetaFileExportProvider }

  TdxPSPDFMetaFileExportProvider = class(TObject)
  private
    FBaseWindowOrg: TPoint;
    FGdiObjectList: TdxPSPDFMetaFileGdiObjectList;
    FMoveToPoint: TPoint;
    FPDFCanvas: TdxPSPDFReportRenderCanvas;
    FSavedStates: TcxObjectList;
    FScaleFactor: Single;
    FState: TdxPSPDFMetaFileCanvasState;
    function GetBackgroundColor: TColor;
    function GetBrush: TBrush;
    function GetHasBackground: Boolean;
    function GetPageContent: TdxPSPDFPageContent;
    function GetPatternColor: TColor;
    function GetPen: TPen;
    function GetPenWidth: Integer;
    function ValidateRect(const R: TRect): TRect;
  protected
    function CreateRegion(ARgnData: PRgnData; ARgnDataSize: Integer): TcxRegion;
    function ExctractBitmap(ARecordAddress: Pointer; const ARect: TRect;
      ABitmapInfoOffset, ABitmapBitsOffset, AColorUsage: Cardinal): TcxBitmap;
    procedure DrawBitmap(const ADest, ASource: TRect; ARecordAddress: Pointer;
      ABitmapInfoOffset, ABitmapBitsOffset, AColorUsage: Cardinal);
    //
    function ConvertPoint(const P: TPoint; AConvertPosition: Boolean = True): TPoint;
    function ConvertPoints(P: Pointer; ACount: Integer; AIsSmallPoints: Boolean): TPointArray;
    function ConvertRect(const R: TRect): TRect;
    function ConvertRegion(ARegion: HRGN): TcxRegion;
    function ConvertValue(AValue: Integer; AMapScale, AViewPortOffset: Single;
      AWorldOffset, AWorldScale: Single; AConvertPosition: Boolean = False): Integer;
    function ConvertValueX(AValue: Integer; AConvertPosition: Boolean = False): Integer;
    function ConvertValueY(AValue: Integer; AConvertPosition: Boolean = False): Integer;
    //
    procedure EmfAlphaBlend(const ARecord: PEMRAlphaBlend);
    procedure EmfBitBlt(const ARecord: PEMRBitBlt);
    procedure EmfCreateBrush(const ARecord: PEMRCreateBrushIndirect; ATable: PHandleTable);
    procedure EmfCreateFont(const ARecord: PEMRExtCreateFontIndirect; ATable: PHandleTable);
    procedure EmfCreatePen(const ARecord: PEMRCreatePen; ATable: PHandleTable);
    procedure EmfCreatePenEx(const ARecord: PEMRExtCreatePen; ATable: PHandleTable);
    procedure EmfDeleteObject(const ARecord: PEMRDeleteObject; ATable: PHandleTable);
    procedure EmfEllipse(R: TRect);
    procedure EmfExcludeClipRect(const ARecord: PEMRExcludeClipRect);
    procedure EmfExtTextOut(const ARecord: PEMRExtTextOut; AIsUnicode: Boolean);
    procedure EmfFillRgn(const ARecord: TEMRFillRgn; ATable: PHandleTable);
    procedure EmfIntersectClipRect(const ARecord: PEMRIntersectClipRect);
    procedure EmfLineTo(const ARecord: TEMRLineTo);
    procedure EmfMaskBlt(const ARecord: PEMRMaskBlt);
    procedure EmfModifyWorldTransform(const AInfo: PEMRModifyWorldTransform);
    procedure EmfPaintRgn(const ARecord: EMRPaintRgn);
    procedure EmfPie(const ARecord: EMRPie; ATable: PHandleTable);
    procedure EmfPolygon(const APolygon: PEMRPolyline; ASmallPoints: Boolean);
    procedure EmfPolyline(const APolyline: PEMRPolyline; ASmallPoints: Boolean);
    procedure EmfPolyPolygon(const APolygon: PEMRPolyPolygon; ASmallPoints: Boolean);
    procedure EmfPolyPolyline(const APolyline: PEMRPolyPolyline; ASmallPoints: Boolean);
    procedure EmfRectangle(R: TRect);
    procedure EmfRestoreState;
    procedure EmfRoundRect(R: TRect; ACorners: TSize);
    procedure EmfSaveState;
    procedure EmfSelectClipRgn(const ARecord: PEMRExtSelectClipRgn);
    procedure EmfSelectObject(const ARecord: PEMRSelectObject; ATable: PHandleTable);
    procedure EmfSetPixel(const ARecord: TEMRSetPixelV);
    procedure EmfSetWindowOrg(const ARecord: PEMRSetWindowOrgEx);
    procedure EmfStretctBlt(const ARecord: PEMRStretchBlt);
    procedure EmfStretctDIBits(const ARecord: PEMRStretchDIBits);
    procedure WriteMetaFileObject(ATable: PHandleTable;
      AObjectsInTable: Integer; const ARecord: PEnhMetaRecord);
    //
    property BackgroundColor: TColor read GetBackgroundColor;
    property BaseWindowOrg: TPoint read FBaseWindowOrg;
    property Brush: TBrush read GetBrush;
    property GdiObjectList: TdxPSPDFMetaFileGdiObjectList read FGdiObjectList;
    property HasBackground: Boolean read GetHasBackground;
    property PageContent: TdxPSPDFPageContent read GetPageContent;
    property PatternColor: TColor read GetPatternColor;
    property Pen: TPen read GetPen;
    property PenWidth: Integer read GetPenWidth;
    property ScaleFactor: Single read FScaleFactor;
    property State: TdxPSPDFMetaFileCanvasState read FState;
  public
    constructor Create(APDFCanvas: TdxPSPDFReportRenderCanvas); virtual;
    destructor Destroy; override;
    procedure Render(AMetaFile: TMetafile; const R: TRect; AScaleFactor: Single); virtual;
    //
    property PDFCanvas: TdxPSPDFReportRenderCanvas read FPDFCanvas;
  end;

procedure dxPDFExportMetaFile(APDFCanvas: TdxPSPDFReportRenderCanvas;
  AMetaFile: TMetafile; const R: TRect; ANumerator, ADenominator: Integer);
implementation

uses
  dxCore, Math;

function DefaultTransform: TXForm;
begin
  ZeroMemory(@Result, SizeOf(Result));
  Result.eM11 := 1;
  Result.eM22 := 1;
end;

procedure dxPDFExportMetaFile(APDFCanvas: TdxPSPDFReportRenderCanvas;
  AMetaFile: TMetafile; const R: TRect; ANumerator, ADenominator: Integer);

  function PrepareTempBuffer(DC: HDC; R: TRect): TMetafile;
  var
    AWidth, AHeight: Integer;
  begin
    AWidth := MulDiv(cxRectWidth(R), ADenominator, ANumerator);
    AHeight := MulDiv(cxRectHeight(R), ADenominator, ANumerator);
    R := cxRectProportionalStretch(Bounds(0, 0, GetDeviceCaps(DC, HORZRES),
      GetDeviceCaps(DC, VERTRES)), AWidth, AHeight);
    Result := TMetafile.Create;
    Result.Width := Min(cxRectWidth(R), AWidth);
    Result.Height := Min(cxRectHeight(R), AHeight);
    Result.Enhanced := True;
  end;

  procedure DoDraw(ASource, ADest: TMetafile);
  var
    ACanvas: TMetafileCanvas;
    R: TRect;
  begin
    R := Rect(0, 0, ADest.Width - 1, ADest.Height - 1); //before TMetafileCanvas.Create
    ACanvas := TMetafileCanvas.Create(ADest, 0);
    try
      ACanvas.StretchDraw(R, ASource);
    finally
      ACanvas.Free;
    end;
  end;

  procedure DoExport(AMetaFile: TMetafile);
  begin
    with TdxPSPDFMetaFileExportProvider.Create(APDFCanvas) do
    try
      Render(AMetaFile, R, cxRectWidth(R) / AMetaFile.Width);
    finally
      Free;
    end;
  end;

var
  ATemp: TMetafile;
begin
  if not IsRectEmpty(R) then
  begin
    ATemp := PrepareTempBuffer(APDFCanvas.Canvas.Handle, R);
    try
      DoDraw(AMetaFile, ATemp);
      DoExport(ATemp);
    finally
      ATemp.Free;
    end;
  end;
end;

function EnhMetaFileProc(DC: HDC; ATable: PHandleTable;
  const ARecord: PEnhMetaRecord; AObjectsCount: Integer;
  AProvider: TdxPSPDFMetaFileExportProvider): Integer; stdcall;
begin
  AProvider.WriteMetaFileObject(ATable, AObjectsCount, ARecord);
  Result := 1;
end;

{ TdxPSPDFMetaFileExportProvider }

constructor TdxPSPDFMetaFileExportProvider.Create(APDFCanvas: TdxPSPDFReportRenderCanvas);
begin
  inherited Create;
  FPDFCanvas := APDFCanvas;
  FSavedStates := TcxObjectList.Create;
  FGdiObjectList := TdxPSPDFMetaFileGdiObjectList.Create;
  FState := TdxPSPDFMetaFileCanvasState.Create;
end;

destructor TdxPSPDFMetaFileExportProvider.Destroy;
begin
  FreeAndNil(FState);
  FreeAndNil(FSavedStates);
  FreeAndNil(FGdiObjectList);
  inherited Destroy;
end;

function TdxPSPDFMetaFileExportProvider.ConvertPoint(
  const P: TPoint; AConvertPosition: Boolean = True): TPoint;
begin
  Result.X := ConvertValueX(P.X, AConvertPosition);
  Result.Y := ConvertValueY(P.Y, AConvertPosition);
end;

function TdxPSPDFMetaFileExportProvider.ConvertPoints(
  P: Pointer; ACount: Integer; AIsSmallPoints: Boolean): TPointArray;
const
  OffsetSizeMap: array[Boolean] of Integer = (SizeOf(TPoint), SizeOf(TSmallPoint));
var
  I: Integer;
begin
  SetLength(Result, ACount);
  for I := 0 to ACount - 1 do
  begin
    if AIsSmallPoints then
      Result[I] := ConvertPoint(SmallPointToPoint(PSmallPoint(P)^))
    else
      Result[I] := ConvertPoint(PPoint(P)^);
    Inc(Integer(P), OffsetSizeMap[AIsSmallPoints]);
  end;
end;

function TdxPSPDFMetaFileExportProvider.ConvertRect(const R: TRect): TRect;
begin
  Result.TopLeft := ConvertPoint(R.TopLeft);
  Result.BottomRight := ConvertPoint(R.BottomRight);
end;

function TdxPSPDFMetaFileExportProvider.ConvertRegion(ARegion: HRGN): TcxRegion;
var
  ARgnData: PRgnData;
  ARgnDataSize: Integer;
begin
  ARgnDataSize := GetRegionData(ARegion, 0, nil);
  ARgnData := AllocMem(ARgnDataSize);
  try
    if GetRegionData(ARegion, ARgnDataSize, ARgnData) <> 0 then
      Result := CreateRegion(ARgnData, ARgnDataSize)
    else
      Result := nil;
  finally
    FreeMem(ARgnData, ARgnDataSize);
  end;
end;

function TdxPSPDFMetaFileExportProvider.CreateRegion(
  ARgnData: PRgnData; ARgnDataSize: Integer): TcxRegion;
var
  ARgnRect: PRect;
  I: Integer;
begin
  Result := TcxRegion.Create(cxNullRect);
  ARgnRect := PRect(@ARgnData^.Buffer[0]);
  for I := 0 to ARgnData^.rdh.nCount - 1 do
  begin
    Result.Combine(TcxRegion.Create(ConvertRect(ARgnRect^)), roAdd);
    Inc(ARgnRect);
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfAlphaBlend(const ARecord: PEMRAlphaBlend);
var
  ASourceBitmap, ABitmap: TcxBitmap;
begin
  ASourceBitmap := ExctractBitmap(ARecord,
    Bounds(ARecord^.xSrc, ARecord^.ySrc, ARecord^.cxSrc, ARecord^.cySrc),
    ARecord^.offBmiSrc, ARecord^.offBitsSrc, ARecord^.iUsageSrc);
  try
    ABitmap := TcxBitmap.CreateSize(ASourceBitmap.ClientRect);
    try
      ABitmap.cxCanvas.FillRect(ABitmap.ClientRect, ARecord^.crBkColorSrc);
      if cxGetBitmapPixelFormat(ASourceBitmap) = 32 then
        cxAlphaBlend(ABitmap, ASourceBitmap, ABitmap.ClientRect, ASourceBitmap.ClientRect)
      else
      begin
        ASourceBitmap.Transparent := True;
        ABitmap.Canvas.Draw(0, 0, ASourceBitmap);
      end;
      PDFCanvas.DrawPicture(ABitmap,
        ConvertRect(Bounds(ARecord^.xDest, ARecord^.yDest, ARecord^.cxDest, ARecord^.cyDest)),
        ppmStretch, PixelsNumerator, PixelsDenominator);
    finally
      ABitmap.Free;
    end;
  finally
    ASourceBitmap.Free;
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfBitBlt(const ARecord: PEMRBitBlt);
var
  R: TRect;
begin
  R := ValidateRect(Bounds(ARecord^.xDest, ARecord^.yDest, ARecord^.cxDest, ARecord^.cyDest));
  if ARecord.cbBitsSrc = 0 then
    PDFCanvas.FillRect(ConvertRect(R), PatternColor)
  else
    DrawBitmap(R, Bounds(ARecord^.xSrc, ARecord^.ySrc, cxRectWidth(R), cxRectHeight(R)),
      ARecord, ARecord^.offBmiSrc, ARecord^.offBitsSrc, ARecord^.iUsageSrc);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfCreateBrush(
  const ARecord: PEMRCreateBrushIndirect; ATable: PHandleTable);
begin
  ATable^.objectHandle[ARecord^.ihBrush] := GdiObjectList.CreateBrush(ARecord^.lb);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfCreateFont(
  const ARecord: PEMRExtCreateFontIndirect; ATable: PHandleTable);
begin
  ATable^.objectHandle[ARecord^.ihFont] := GdiObjectList.CreateFont(ARecord^.elfw);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfCreatePen(
  const ARecord: PEMRCreatePen; ATable: PHandleTable);
begin
  ATable^.objectHandle[ARecord^.ihPen] := GdiObjectList.CreatePen(ARecord^.lopn);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfCreatePenEx(
  const ARecord: PEMRExtCreatePen; ATable: PHandleTable);
begin
  ATable^.objectHandle[ARecord^.ihPen] := GdiObjectList.CreatePenEx(ARecord^.elp);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfDeleteObject(
  const ARecord: PEMRDeleteObject; ATable: PHandleTable);
var
  AObject: TdxPSPDFMetaFileGdiObjectItem;
begin
  if GdiObjectList.FindObject(ATable^.ObjectHandle[ARecord^.ihObject], AObject) then
    GdiObjectList.Remove(AObject);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfExtTextOut(
  const ARecord: PEMRExtTextOut; AIsUnicode: Boolean);

  function CalculateTextWidth(const ARecord: PEMRExtTextOut; const ATextInfo: TEMRText): Integer;
  var
    AOffsets: PInteger;
    I: Integer;
  begin
    Result := 0;
    if ATextInfo.offDx > 0 then
    begin
      AOffsets := PInteger(DWORD(ARecord) + ATextInfo.offDx);
      for I := 0 to ATextInfo.nChars - 1 do
      begin
        Inc(Result, AOffsets^);
        Inc(AOffsets);
      end;
    end;
  end;

  function CalculateTextRect(const ARecord: PEMRExtTextOut; const ATextInfo: TEMRText): TRect;
  begin
    Result := ARecord^.rclBounds;
    if (Result.Right < 0) and (Result.Bottom < 0) then
    begin
      Result := Bounds(0, 0, CalculateTextWidth(ARecord, ATextInfo), Abs(PDFCanvas.Font.Size));
      Result := cxRectOffset(Result, ATextInfo.ptlReference);
    end;
    Inc(Result.Bottom, Abs(PDFCanvas.Font.Size));
  end;

  function ExtractText(const ARecord: PEMRExtTextOut; const ATextInfo: TEMRText): WideString;
  var
    ATextA: AnsiString;
  begin
    if AIsUnicode then
      SetString(Result, PWideChar(DWORD(ARecord) + ATextInfo.offString), ATextInfo.nChars)
    else
    begin
      SetString(ATextA, PAnsiChar(DWORD(ARecord) + ATextInfo.offString), ATextInfo.nChars);
      Result := dxAnsiStringToWideString(ATextA,
        dxGetCodePageFromCharset(PDFCanvas.Font.Charset));
    end;
  end;

var
  ATransform: TXForm;
  R: TRect;
begin
  if ARecord^.emrtext.nChars > 0 then
  begin
    ATransform := State.Transform;
    try
      State.Transform := DefaultTransform;
      R := ConvertRect(CalculateTextRect(ARecord, ARecord^.emrtext));
      PDFCanvas.DrawTextLine(R, R, cxRectWidth(R),
        ExtractText(ARecord, ARecord^.emrtext), State.TextColor);
    finally
      State.Transform := ATransform;
    end;
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfEllipse(R: TRect);
begin
  R := ConvertRect(R);
  if HasBackground then
    PDFCanvas.FillEllipse(R, BackgroundColor, State.TextColor, nil, Brush);
  PDFCanvas.DrawEllipseFrame(R, Pen.Color, PenWidth);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfRestoreState;
var
  ATempState: TdxPSPDFMetaFileCanvasState;
begin
  PDFCanvas.RestoreState;
  ATempState := TdxPSPDFMetaFileCanvasState(FSavedStates.Last);
  FSavedStates.Delete(FSavedStates.Count - 1);
  State.Assign(ATempState);
  ATempState.Free;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfSaveState;
begin
  PDFCanvas.SaveState;
  FSavedStates.Add(State.Clone);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfFillRgn(
  const ARecord: TEMRFillRgn; ATable: PHandleTable);
var
  AObject: TdxPSPDFMetaFileGdiObjectItem;
  ARegion: TcxRegion;
begin
  if GdiObjectList.FindObject(ATable^.ObjectHandle[ARecord.ihBrush], AObject) then
  begin
    ARegion := CreateRegion(@ARecord.RgnData[0], ARecord.cbRgnData);
    try
      PDFCanvas.FillRegion(ARegion.Handle, AObject.Color, clNone, TdxPSSolidFillPattern, nil);
    finally
      ARegion.Free;
    end;
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfExcludeClipRect(
  const ARecord: PEMRExcludeClipRect);
begin
  PDFCanvas.ExcludeClipRect(ConvertRect(ARecord^.rclClip));
end;

procedure TdxPSPDFMetaFileExportProvider.EmfIntersectClipRect(
  const ARecord: PEMRIntersectClipRect);
begin
  PDFCanvas.IntersectClipRgn(ConvertRect(ARecord^.rclClip));
end;

procedure TdxPSPDFMetaFileExportProvider.EmfLineTo(const ARecord: TEMRLineTo);
begin
  PDFCanvas.Polyline([ConvertPoint(FMoveToPoint), ConvertPoint(ARecord.ptl)], Pen.Color, PenWidth);
  FMoveToPoint := ARecord.ptl;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfMaskBlt(const ARecord: PEMRMaskBlt);

  procedure SetMaskRegion(AMask: TcxBitmap; ATransparentColor: TColor);
  var
    AMaskRegion: TcxRegion;
    ARegion: HRGN;
  begin
    ARegion := cxCreateRegionFromBitmap(AMask, ATransparentColor);
    AMaskRegion := ConvertRegion(ARegion);
    DeleteObject(ARegion);
    if Assigned(AMaskRegion) then
    begin
      AMaskRegion.Offset(ConvertPoint(Point(ARecord^.xDest, ARecord^.yDest)));
      AMaskRegion.Offset(cxPointInvert(PDFCanvas.WindowOrg));
      PDFCanvas.Region.Combine(AMaskRegion, roIntersect);
    end;
  end;

  function PrepareBitmap(const ARect: TRect): TcxBitmap;
  var
    ABitmap: TcxBitmap;
  begin
    Result := TcxBitmap.CreateSize(ARect, pf24bit);
    Result.cxCanvas.FillRect(Result.ClientRect, ARecord^.crBkColorSrc);

    ABitmap := ExctractBitmap(ARecord, Bounds(0, 0, ARecord^.cxDest, ARecord^.cyDest),
      ARecord^.offBmiSrc, ARecord^.offBitsSrc, ARecord^.iUsageSrc);
    try
      ABitmap.Transparent := True;
      Result.Canvas.Draw(0, 0, ABitmap);
      SetMaskRegion(Result, ARecord^.crBkColorSrc);
    finally
      ABitmap.Free;
    end;
  end;

var
  ABitmap: TcxBitmap;
  ARect: TRect;
begin
  PDFCanvas.SaveClipRgn;
  try
    ARect := Bounds(ARecord^.xDest, ARecord^.yDest, ARecord^.cxDest, ARecord^.cyDest);
    ABitmap := PrepareBitmap(ARect);
    try
      PDFCanvas.DrawPicture(ABitmap, ConvertRect(ARect), ppmStretch, PixelsNumerator, PixelsDenominator);
    finally
      ABitmap.Free;
    end;
  finally
    PDFCanvas.RestoreClipRgn;
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfModifyWorldTransform(
  const AInfo: PEMRModifyWorldTransform);

  function Multiply(const S, T: TXForm): TXForm;
  begin
    Result.eM11 := S.eM11 * T.eM11 + S.eM12 * T.eM21;
    Result.eM12 := S.eM11 * T.eM12 + S.eM12 * T.eM22;
    Result.eM21 := S.eM21 * T.eM11 + S.eM22 * T.eM21;
    Result.eM22 := S.eM21 * T.eM12 + S.eM22 * T.eM22;
    Result.eDx  := S.eDx  * T.eM11 + S.eDx  * T.eM21 + T.eDx;
    Result.eDy  := S.eDy  * T.eM12 + S.eDy  * T.eM22 + T.eDy;
  end;

begin
  case AInfo^.iMode of
    MWT_LEFTMULTIPLY:
      State.Transform := Multiply(AInfo^.xform, State.Transform);
    MWT_RIGHTMULTIPLY:
      State.Transform := Multiply(State.Transform, AInfo^.xform);
    else
      State.Transform := AInfo^.xform;
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfPaintRgn(const ARecord: EMRPaintRgn);
var
  ARegion: TcxRegion;
begin
  if HasBackground then
  begin
    ARegion := CreateRegion(@ARecord.RgnData[0], ARecord.cbRgnData);
    try
      PDFCanvas.FillRegion(ARegion.Handle, BackgroundColor, clNone, nil, Brush);
    finally
      ARegion.Free;
    end;
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfPolyline(
  const APolyline: PEMRPolyline; ASmallPoints: Boolean);
begin
  PDFCanvas.Polyline(
    ConvertPoints(@APolyLine^.aptl[0], APolyLine^.cptl, ASmallPoints),
    Pen.Color, PenWidth);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfPolyPolygon(
  const APolygon: PEMRPolyPolygon; ASmallPoints: Boolean);
const
  ElementSizeMap: array[Boolean] of Integer = (SizeOf(TPoint), SizeOf(TSmallPoint));
var
  ACount: Integer;
  ACursor: PByte;
  AElementSize: Cardinal;
  I: Integer;
  P: TPointArray;
begin
  ACount := Integer(APolygon^.nPolys);
  AElementSize := ElementSizeMap[ASmallPoints];
  ACursor := @APolygon.aPolyCounts[0];
  Inc(ACursor, SizeOf(Cardinal) * ACount);

  PageContent.SaveGraphicState;
  try
    PageContent.SelectClipRegion(PDFCanvas.Region.Handle, PDFCanvas.LogicalToPDFCoordinates);
    PageContent.SelectLineWidth(PDFCanvas.ConvertValue(PenWidth));
    for I := 0 to ACount - 1 do
    begin
      P := ConvertPoints(ACursor, APolygon^.aPolyCounts[I], ASmallPoints);
      PageContent.WritePoints(dxConvertPointsToPDFPoints(P,
        PDFCanvas.WindowOrg, PDFCanvas.LogicalToPDFCoordinates));
      Inc(ACursor, APolygon^.aPolyCounts[I] * AElementSize);
      P := nil;
    end;
    PageContent.FillPolygon(Pen.Color, BackgroundColor, State.PolyFillMode);
  finally
    PageContent.RestoreGraphicState;
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfPolyPolyline(
  const APolyline: PEMRPolyPolyline; ASmallPoints: Boolean);
const
  ElementSizeMap: array[Boolean] of Integer = (SizeOf(TPoint), SizeOf(TSmallPoint));
var
  ACount: Integer;
  ACursor: PByte;
  AElementSize: Cardinal;
  I: Integer;
  P: TPointArray;
begin
  ACount := Integer(APolyline^.nPolys);
  AElementSize := ElementSizeMap[ASmallPoints];
  ACursor := @APolyline.aPolyCounts[0];
  Inc(ACursor, SizeOf(Cardinal) * ACount);

  PageContent.SaveGraphicState;
  try
    PageContent.SelectClipRegion(PDFCanvas.Region.Handle, PDFCanvas.LogicalToPDFCoordinates);
    for I := 0 to ACount - 1 do
    begin
      P := ConvertPoints(ACursor, APolyline^.aPolyCounts[I], ASmallPoints);
      PageContent.Polyline(dxConvertPointsToPDFPoints(P,
        PDFCanvas.WindowOrg, PDFCanvas.LogicalToPDFCoordinates),
        PDFCanvas.ConvertValue(PenWidth), Pen.Color);
      Inc(ACursor, APolyline^.aPolyCounts[I] * AElementSize);
      P := nil;
    end;
  finally
    PageContent.RestoreGraphicState;
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfPie(
  const ARecord: EMRPie; ATable: PHandleTable);
begin
  PDFCanvas.Pie(ConvertRect(ARecord.rclBox),
    ConvertPoint(ARecord.ptlStart), ConvertPoint(ARecord.ptlEnd));
end;

procedure TdxPSPDFMetaFileExportProvider.EmfPolygon(
  const APolygon: PEMRPolyline; ASmallPoints: Boolean);
begin
  PDFCanvas.Polygon(
    ConvertPoints(@APolygon^.aptl[0], APolygon^.cptl, ASmallPoints),
    Pen.Color, BackgroundColor, PenWidth, State.PolyFillMode);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfRectangle(R: TRect);
begin
  R := ConvertRect(R);
  if HasBackground then
    PDFCanvas.FillRectEx(R, BackgroundColor, nil, Brush);
  if (BackgroundColor <> Pen.Color) and (Pen.Width <> 0) then
    PDFCanvas.DrawFrame(R, Pen.Color, Pen.Color, PenWidth);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfRoundRect(R: TRect; ACorners: TSize);
begin
  R := ConvertRect(R);
  ACorners.cx := ConvertValueX(ACorners.cx div 2);
  ACorners.cy := ConvertValueY(ACorners.cy div 2);
  if HasBackground then
  begin
    PDFCanvas.FillRoundRect(R, ACorners.cx, ACorners.cy,
      BackgroundColor, State.TextColor, nil, Brush);
  end;
  PDFCanvas.DrawRoundFrame(R, ACorners.cx, ACorners.cy, Pen.Color, PenWidth);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfSelectClipRgn(
  const ARecord: PEMRExtSelectClipRgn);

  function GetClipRegion(ARgnData: PRgnData; ARgnDataSize: Integer): TcxRegion;
  var
    ARgnRect: PRect;
    I: Integer;
    R: TRect;
  begin
    Result := TcxRegion.Create(cxNullRect);
    ARgnRect := PRect(@ARgnData^.Buffer[0]);
    for I := 0 to ARgnData^.rdh.nCount - 1 do
    begin
      R := ARgnRect^;

      R.Top := Round(R.Top * ScaleFactor);
      R.Bottom := Round(R.Bottom * ScaleFactor);
      R.Right := Round(R.Right * ScaleFactor);
      R.Left := Round(R.Left * ScaleFactor);

      Result.Combine(TcxRegion.Create(R), roAdd);
      Inc(ARgnRect);
    end;
  end;

var
  APoint: TPoint;
  ARegion: TcxRegion;
begin
  if ARecord.cbRgnData = 0 then
    PDFCanvas.ResetPageRegion
  else
  begin
    APoint := PDFCanvas.WindowOrg;
    Dec(APoint.X, BaseWindowOrg.X);
    Dec(APoint.Y, BaseWindowOrg.Y);
    ARegion := GetClipRegion(@ARecord.RgnData[0], ARecord.cbRgnData);
    ARegion.Offset(cxPointInvert(APoint));
    PDFCanvas.Region.Combine(ARegion, roSet);
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfSelectObject(
  const ARecord: PEMRSelectObject; ATable: PHandleTable);

  procedure SelectStockObject(AIndex: Integer);
  begin
    case AIndex of
      BLACK_BRUSH:
        Brush.Color := clBlack;
      BLACK_PEN:
        Pen.Color := clBlack;
      DKGRAY_BRUSH:
        Brush.Color := $666666;
      GRAY_BRUSH:
        Brush.Color := clGray;
      LTGRAY_BRUSH:
        Brush.Color := $AAAAAA;
      NULL_BRUSH:
        Brush.Style := bsClear;
      NULL_PEN:
        Pen.Color := clNone;
      WHITE_BRUSH:
        Brush.Color := clWhite;
      WHITE_PEN:
        Pen.Color := clWhite;
      OEM_FIXED_FONT, ANSI_FIXED_FONT, ANSI_VAR_FONT, SYSTEM_FONT:
        PDFCanvas.Font.Name := 'Arial';
    end;
  end;

var
  AObject: TdxPSPDFMetaFileGdiObjectItem;
begin
  if ARecord^.ihObject and $80000000 <> 0 then
    SelectStockObject(ARecord^.ihObject and $7FFFFFFF)
  else
    if GdiObjectList.FindObject(ATable^.ObjectHandle[ARecord^.ihObject], AObject) then
    begin
      if AObject.SourceObject is TPen then
        Pen.Assign(TPen(AObject.SourceObject));
      if AObject.SourceObject is TBrush then
      begin
        Brush.Assign(TBrush(AObject.SourceObject));
        Brush.Color := AObject.Color;
      end;
      if AObject.SourceObject is TFont then
      begin
        PDFCanvas.Font := TFont(AObject.SourceObject);
        PDFCanvas.Font.Size := ConvertValueX(PDFCanvas.Font.Size);
      end;
    end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfSetPixel(const ARecord: TEMRSetPixelV);
var
  R: TRect;
begin
  R := Rect(ARecord.ptlPixel.X, ARecord.ptlPixel.Y,
    ARecord.ptlPixel.X + 1, ARecord.ptlPixel.Y + 1);
  PDFCanvas.FillRect(ConvertRect(R), ARecord.crColor);
end;

procedure TdxPSPDFMetaFileExportProvider.EmfSetWindowOrg(const ARecord: PEMRSetWindowOrgEx);
var
  P: TPoint;
begin
  P := ConvertPoint(ARecord^.ptlOrigin, False);
  Inc(P.X, BaseWindowOrg.X);
  Inc(P.Y, BaseWindowOrg.Y);
  State.WindowOrg := P;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfStretctBlt(const ARecord: PEMRStretchBlt);
begin
  if ARecord^.cbBitsSrc <> 0 then
  begin
    DrawBitmap(
      Bounds(ARecord^.xDest, ARecord^.yDest, ARecord^.cxDest, ARecord^.cyDest),
      Bounds(ARecord^.xSrc, ARecord^.ySrc, ARecord^.cxSrc, ARecord^.cySrc),
      ARecord, ARecord^.offBmiSrc, ARecord^.offBitsSrc, ARecord^.iUsageSrc);
  end;
end;

procedure TdxPSPDFMetaFileExportProvider.EmfStretctDIBits(const ARecord: PEMRStretchDIBits);
begin
  if ARecord^.cbBitsSrc <> 0 then
  begin
    DrawBitmap(
      Bounds(ARecord^.xDest, ARecord^.yDest, ARecord^.cxDest, ARecord^.cyDest),
      Bounds(ARecord^.xSrc, ARecord^.ySrc, ARecord^.cxSrc, ARecord^.cySrc),
      ARecord, ARecord^.offBmiSrc, ARecord^.offBitsSrc, ARecord^.iUsageSrc);
  end;
end;

function TdxPSPDFMetaFileExportProvider.ExctractBitmap(ARecordAddress: Pointer;
  const ARect: TRect; ABitmapInfoOffset, ABitmapBitsOffset, AColorUsage: Cardinal): TcxBitmap;

  function GetBitmapBitsSize(const AInfo: TBitmapInfo): Integer;
  begin
    with AInfo.bmiHeader do
      Result := biWidth * Abs(biHeight) * biBitCount div 8;
  end;

  function GetPixelFormat(const AInfo: PBitmapInfo): TPixelFormat;
  begin
    case AInfo^.bmiHeader.biBitCount of
      1: Result := pf1bit;
      8: Result := pf8bit;
      16: Result := pf16bit;
      32: Result := pf32bit;
      else
        Result := pf24bit;
    end;
  end;

var
  ABits: Pointer;
  AHandle: HBITMAP;
  AInfo: PBitmapInfo;
begin
  AInfo := PBitmapInfo(DWORD(ARecordAddress) + ABitmapInfoOffset);
  AHandle := CreateDIBSection(cxScreenCanvas.Handle, AInfo^, DIB_RGB_COLORS, ABits, 0, 0);
  cxCopyData(Pointer(DWORD(ARecordAddress) + ABitmapBitsOffset), ABits, GetBitmapBitsSize(AInfo^));
  Result := TcxBitmap.CreateSize(ARect, GetPixelFormat(AInfo));
  StretchDIBits(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height,
    ARect.Left, ARect.Top, cxRectWidth(ARect), cxRectHeight(ARect),
    ABits, AInfo^, AColorUsage, SRCCOPY);
  DeleteObject(AHandle);
end;

procedure TdxPSPDFMetaFileExportProvider.DrawBitmap(const ADest, ASource: TRect;
  ARecordAddress: Pointer; ABitmapInfoOffset, ABitmapBitsOffset, AColorUsage: Cardinal);
var
  ABitmap: TcxBitmap;
begin
  ABitmap := ExctractBitmap(ARecordAddress, ASource, ABitmapInfoOffset, ABitmapBitsOffset, AColorUsage);
  try
    PDFCanvas.DrawPicture(ABitmap, ConvertRect(ADest), ppmStretch, PixelsNumerator, PixelsDenominator);
  finally
    ABitmap.Free;
  end;
end;

function TdxPSPDFMetaFileExportProvider.ValidateRect(const R: TRect): TRect;

  procedure Swap(var A, B: Integer);
  var
    C: Integer;
  begin
    C := A;
    A := B;
    B := C;
  end;

begin
  Result := R;
  if Result.Left > Result.Right then
    Swap(Result.Right, Result.Left);
  if Result.Top > Result.Bottom then
    Swap(Result.Bottom, Result.Top);
end;

function TdxPSPDFMetaFileExportProvider.GetBackgroundColor: TColor;
begin
  if Brush.Style <> bsClear then
    Result := Brush.Color
  else
    Result := clNone;
end;

function TdxPSPDFMetaFileExportProvider.GetBrush: TBrush;
begin
  Result := State.Brush;
end;

function TdxPSPDFMetaFileExportProvider.GetHasBackground: Boolean;
begin
  Result := (BackgroundColor <> clNone) or (Brush.Style > bsClear);
end;

function TdxPSPDFMetaFileExportProvider.GetPageContent: TdxPSPDFPageContent;
begin
  Result := PDFCanvas.PageContent;
end;

function TdxPSPDFMetaFileExportProvider.GetPatternColor: TColor;
begin
  Result := BackgroundColor;
  if Result = clNone then
    Result := State.TextColor;
end;

function TdxPSPDFMetaFileExportProvider.GetPen: TPen;
begin
  Result := State.Pen;
end;

function TdxPSPDFMetaFileExportProvider.GetPenWidth: Integer;
var
  AWidth: Single;
begin
  AWidth := State.Transform.eM11;
  if State.MapMode <> MM_TEXT then
    AWidth := AWidth * State.ViewPortExt.cx / State.WindowExt.cx;
  if Pen.Width <> 0 then
    AWidth := AWidth * Pen.Width;
  Result := Round(AWidth * ScaleFactor);
end;

procedure TdxPSPDFMetaFileExportProvider.Render(
  AMetaFile: TMetafile; const R: TRect; AScaleFactor: Single);
begin
  PDFCanvas.SaveState;
  try
    FBaseWindowOrg := R.TopLeft;
    FScaleFactor := AScaleFactor;
    State.PolyFillMode := ALTERNATE;
    State.ViewPortExt := cxSize(AMetaFile.Width, AMetaFile.Height);
    State.WindowExt := State.ViewPortExt;
    State.WindowOrg := R.TopLeft;
    EnumEnhMetaFile(0, AMetaFile.Handle, @EnhMetaFileProc, Self, cxNullRect);
  finally
    PDFCanvas.RestoreState;
  end;
end;

function TdxPSPDFMetaFileExportProvider.ConvertValue(AValue: Integer;
  AMapScale: Single; AViewPortOffset: Single; AWorldOffset: Single;
  AWorldScale: Single; AConvertPosition: Boolean = False): Integer;
var
  ATempValue: Single;
begin
  case State.MapMode of
    MM_ANISOTROPIC, MM_ISOTROPIC:
      ATempValue := AValue * AMapScale;
    else
      ATempValue := AValue;
  end;
  if AConvertPosition then
    Result := Round(ScaleFactor * ((ATempValue + AViewPortOffset) * AWorldScale + AWorldOffset))
  else
    Result := Round(ScaleFactor * ATempValue * AWorldScale)
end;

function TdxPSPDFMetaFileExportProvider.ConvertValueX(
  AValue: Integer; AConvertPosition: Boolean = False): Integer;
begin
  Result := ConvertValue(AValue, State.ViewPortExt.cx / State.WindowExt.cx,
    State.ViewPortOrg.X, State.Transform.eDx, State.Transform.eM11, AConvertPosition);
  if AConvertPosition then
    Inc(Result, State.WindowOrg.X);
end;

function TdxPSPDFMetaFileExportProvider.ConvertValueY(
  AValue: Integer; AConvertPosition: Boolean = False): Integer;
begin
  Result := ConvertValue(AValue, State.ViewPortExt.cy / State.WindowExt.cy,
    State.ViewPortOrg.Y, State.Transform.eDy, State.Transform.eM22, AConvertPosition);
  if AConvertPosition then
    Inc(Result, State.WindowOrg.Y);
end;

procedure TdxPSPDFMetaFileExportProvider.WriteMetaFileObject(
  ATable: PHandleTable; AObjectsInTable: Integer; const ARecord: PEnhMetaRecord);
begin
  case ARecord^.iType of
    EMR_SAVEDC:
      EmfSaveState;
    EMR_RESTOREDC:
      EmfRestoreState;
    EMR_MASKBLT:
      EmfMaskBlt(PEMRMaskBlt(ARecord));
    EMR_BITBLT:
      EmfBitBlt(PEMRBitBlt(ARecord));
    EMR_STRETCHBLT:
      EmfStretctBlt(PEMRStretchBlt(ARecord));
    EMR_STRETCHDIBITS:
      EmfStretctDIBits(PEMRStretchDiBits(ARecord));
    EMR_ELLIPSE:
      EmfEllipse(PEMREllipse(ARecord)^.rclBox);
    EMR_RECTANGLE:
      EmfRectangle(PEMRRectangle(ARecord)^.rclBox);
    EMR_CREATEPEN:
      EmfCreatePen(PEMRCreatePen(ARecord), ATable);
    EMR_EXTSELECTCLIPRGN:
      EmfSelectClipRgn(PEMRExtSelectClipRgn(ARecord));
    EMR_SELECTOBJECT:
      EmfSelectObject(PEMRSelectObject(ARecord), ATable);
    EMR_DELETEOBJECT:
      EmfDeleteObject(PEMRDeleteObject(ARecord), ATable);
    EMR_SETWINDOWORGEX:
      EmfSetWindowOrg(PEMRSETWINDOWORGEX(ARecord));
    EMR_EXCLUDECLIPRECT:
      EmfExcludeClipRect(PEMREXCLUDECLIPRECT(ARecord));
    EMR_INTERSECTCLIPRECT:
      EmfIntersectClipRect(PEMRINTERSECTCLIPRECT(ARecord));
    EMR_CREATEBRUSHINDIRECT:
      EmfCreateBrush(PEMRCreateBrushIndirect(ARecord), ATable);
    EMR_EXTCREATEFONTINDIRECTW:
      EmfCreateFont(PEMRExtCreateFontIndirect(ARecord), ATable);
    EMR_EXTCREATEPEN:
      EmfCreatePenEx(PEMRExtCreatePen(ARecord), ATable);
    EMR_EXTTEXTOUTW, EMR_EXTTEXTOUTA:
      EmfExtTextOut(PEMRExtTextOut(ARecord), ARecord^.iType = EMR_EXTTEXTOUTW);
    EMR_ROUNDRECT:
      EmfRoundRect(PEMRRoundRect(ARecord)^.rclBox, PEMRRoundRect(ARecord)^.szlCorner);
    EMR_POLYGON, EMR_POLYGON16:
      EmfPolygon(PEMRPolyline(ARecord), ARecord^.iType = EMR_POLYGON16);
    EMR_POLYPOLYGON, EMR_POLYPOLYGON16:
      EmfPolyPolygon(PEMRPolyPolygon(ARecord), ARecord^.iType = EMR_POLYPOLYGON16);
    EMR_POLYPOLYLINE16, EMR_POLYPOLYLINE:
      EmfPolyPolyline(PEMRPolyPolyline(ARecord), ARecord^.iType = EMR_POLYPOLYLINE16);
    EMR_POLYLINE, EMR_POLYLINE16:
      EmfPolyLine(PEMRPolyline(ARecord), ARecord^.iType = EMR_POLYLINE16);
    EMR_SETWORLDTRANSFORM:
      State.Transform := PEMRSetWorldTransform(ARecord)^.xform;
    EMR_MODIFYWORLDTRANSFORM:
      EmfModifyWorldTransform(PEMRModifyWorldTransform(ARecord));
    EMR_SETPIXELV:
      EmfSetPixel(PEMRSetPixelV(ARecord)^);
    EMR_MOVETOEX:
      FMoveToPoint := PEMRMoveToEx(ARecord)^.ptl;
    EMR_LINETO:
      EmfLineTo(PEMRLineTo(ARecord)^);
    EMR_PAINTRGN:
      EmfPaintRgn(PEMRPaintRgn(ARecord)^);
    EMR_FILLRGN:
      EmfFillRgn(PEMRFillRgn(ARecord)^, ATable);
    EMR_PIE:
      EmfPie(PEMRPie(ARecord)^, ATable);
    EMR_ALPHABLEND:
      EmfAlphaBlend(PEMRAlphaBlend(ARecord));
    EMR_SETMAPMODE:
      State.MapMode := PEMRSetMapMode(ARecord)^.iMode;
    EMR_SETVIEWPORTEXTEX:
      State.ViewPortExt := PEMRSetViewportExtEx(ARecord)^.szlExtent;
    EMR_SETVIEWPORTORGEX:
      State.ViewPortOrg := PEMRSetViewportOrgEx(ARecord)^.ptlOrigin;
    EMR_SETWINDOWEXTEX:
      State.WindowExt := PEMRSetWindowExtEx(ARecord)^.szlExtent;
    EMR_SETBKCOLOR:
      State.BackgroundColor := PEMRSETBKCOLOR(ARecord)^.crColor;
    EMR_SETTEXTCOLOR:
      State.TextColor := PEMRSETTEXTCOLOR(ARecord)^.crColor;
    EMR_SETBKMODE:
      State.BackgroundMode := PEMRSETBKMODE(ARecord)^.iMode;
    EMR_SETPOLYFILLMODE:
      State.PolyFillMode := PEMRSetPolyFillMode(ARecord)^.iMode;
    EMR_OFFSETCLIPRGN:
      PDFCanvas.Region.Offset(ConvertPoint(PEMROffsetClipRgn(ARecord)^.ptlOffset, False));
  end;
end;

{ TdxPSPDFMetaFileGdiObjectList }

function TdxPSPDFMetaFileGdiObjectList.CreateBrush(const ABrushInfo: TLogBrush): HBRUSH;
var
  ABrush: TBrush;
begin
  ABrush := TBrush.Create;
  ABrush.Handle := CreateBrushIndirect(ABrushInfo);
  Add(TdxPSPDFMetaFileGdiObjectItem.Create(ABrush.Handle, ABrush, ABrushInfo.lbColor));
  Result := ABrush.Handle;
end;

function TdxPSPDFMetaFileGdiObjectList.CreateFont(const AFontInfo: EXTLOGFONTW): HFONT;
var
  AFont: TFont;
begin
  AFont := TFont.Create;
  AFont.Handle := CreateFontIndirectW(AFontInfo.elfLogFont);
  Add(TdxPSPDFMetaFileGdiObjectItem.Create(AFont.Handle, AFont, clDefault));
  Result := AFont.Handle;
end;

function TdxPSPDFMetaFileGdiObjectList.CreatePen(const APenInfo: TLogPen): HPEN;
var
  APen: TPen;
begin
  APen := TPen.Create;
  APen.Color := APenInfo.lopnColor;
  APen.Width := APenInfo.lopnWidth.X;
  Add(TdxPSPDFMetaFileGdiObjectItem.Create(APen.Handle, APen, APenInfo.lopnColor));
  Result := APen.Handle;  
end;

function TdxPSPDFMetaFileGdiObjectList.CreatePenEx(const APenInfo: TExtLogPen): HPEN;
var
  APen: TPen;
begin
  APen := TPen.Create;
  APen.Color := APenInfo.elpColor;
  APen.Width := APenInfo.elpWidth;
  Add(TdxPSPDFMetaFileGdiObjectItem.Create(APen.Handle, APen, APenInfo.elpColor));
  Result := APen.Handle;
end;

function TdxPSPDFMetaFileGdiObjectList.FindObject(
  AHandle: THandle; var AObject: TdxPSPDFMetaFileGdiObjectItem): Boolean;
var
  I: Integer;
begin
  AObject := nil;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].Handle = AHandle;
    if Result then
    begin
      AObject := Items[I];
      Break;
    end;
  end;
  Result := Assigned(AObject);
end;

function TdxPSPDFMetaFileGdiObjectList.GetItem(
  Index: Integer): TdxPSPDFMetaFileGdiObjectItem;
begin
  Result := TdxPSPDFMetaFileGdiObjectItem(inherited Items[Index]);
end;

procedure TdxPSPDFMetaFileGdiObjectList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited Notify(Ptr, Action);
  if Assigned(Ptr) and (Action = lnDeleted) then
    TObject(Ptr).Free;
end;

{ TdxPSPDFMetaFileGdiObjectItem }

constructor TdxPSPDFMetaFileGdiObjectItem.Create(
  AHandle: THandle; ASourceObject: TObject; AColor: TColor);
begin
  inherited Create;
  FHandle := AHandle;
  FSourceObject := ASourceObject;
  FColor := AColor;
end;

destructor TdxPSPDFMetaFileGdiObjectItem.Destroy;
begin
  FreeAndNil(FSourceObject);
  inherited Destroy;
end;

{ TdxPSPDFMetaFileCanvasState }

constructor TdxPSPDFMetaFileCanvasState.Create;
begin
  inherited Create;
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FWindowExt := cxSize(1, 1);
  FViewPortExt := cxSize(1, 1);
  FTransform := DefaultTransform;
end;

destructor TdxPSPDFMetaFileCanvasState.Destroy;
begin
  FreeAndNil(FPen);
  FreeAndNil(FBrush);
  inherited Destroy;
end;

procedure TdxPSPDFMetaFileCanvasState.Assign(ASource: TdxPSPDFMetaFileCanvasState);
begin
  Pen.Assign(ASource.Pen);
  Brush.Assign(ASource.Brush);
  PolyFillMode := ASource.PolyFillMode;
  BackgroundMode := ASource.BackgroundMode;
  BackgroundColor := ASource.BackgroundColor;
  ViewPortOrg := ASource.ViewPortOrg;
  ViewPortExt := ASource.ViewPortExt;
  WindowExt := ASource.WindowExt;
  WindowOrg := ASource.WindowOrg;
  TextColor := ASource.TextColor;
  Transform := ASource.Transform;
  MapMode := ASource.MapMode;
end;

function TdxPSPDFMetaFileCanvasState.Clone: TdxPSPDFMetaFileCanvasState;
begin
  Result := TdxPSPDFMetaFileCanvasState.Create;
  Result.Assign(Self);
end;

end.
