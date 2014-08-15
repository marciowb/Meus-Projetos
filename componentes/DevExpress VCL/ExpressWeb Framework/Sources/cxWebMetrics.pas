{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Text Metrics Utils                                          }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebMetrics;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,
  {$IFDEF VCL}
  Windows, Graphics, Jpeg,
  {$ELSE}
  Types, Qt, QGraphics,
  {$ENDIF}
  cxWebUtils, cxWebTypes, cxWebGraphics;

type
  TcxWebMetricsUtils = class(TcxAbstractWebMetricsUtils)
  private
    FPixelsPerInch: Integer;
    FCheckWidth, FCheckHeight: Integer;
    procedure GetCheckSize;
    procedure GetPixelsPerInch;
    function GetFontSizeInPoints(AFontSize: TcxWebFontSize): Integer;
    function GetTextSize(const AText: string; AWebFont: TcxWebFont): TSize;
  protected
    function GetCheckWidth: Integer; override;
    function GetCheckHeight: Integer; override;
    function WebFontToFont(AWebFont: TcxWebFont): {$IFDEF VCL}HFONT{$ELSE}QFontH{$ENDIF};
  public
    constructor Create;
    function CalcEditHeight(AFont: TcxWebFont): Integer; override;
    function GetAweCharWidth(AWebFont: TcxWebFont): Integer; override;
    function GetTextHeight(const AText: string; AWebFont: TcxWebFont): Integer; override;
    function GetTextWidth(const AText: string; AWebFont: TcxWebFont): Integer; override;
  end;

  TcxWebImageUtils = class(TcxAbstractWebImageUtils)
  private
    FPicture: TPicture;
    FErrMessage: string;
  protected
    function GetGraphic: TGraphic;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetErrMessage: string; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    function IsEmpty: Boolean; override;
    procedure SetPath(const APath: string); override;
    procedure SetImage(Value: Variant); override;
  end;

implementation

uses Variants, cxWebDataUtils, Consts;

{ TcxWebMetricsUtils }

constructor TcxWebMetricsUtils.Create;
begin
  inherited;
  GetCheckSize;
  GetPixelsPerInch;
end;

procedure TcxWebMetricsUtils.GetPixelsPerInch;
{$IFDEF VCL}
var
  DC: HDC;
begin
  DC := GetDC(0);
  FPixelsPerInch := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(0, DC);
{$ELSE}
var
  Metrics: QPaintDeviceMetricsH;
begin
  Metrics := QPaintDeviceMetrics_create(QWidget_to_QPaintDevice(QApplication_desktop));
  FPixelsPerInch := QPaintDeviceMetrics_logicalDpiY(Metrics);
  QPaintDeviceMetrics_destroy(Metrics);
{$ENDIF}
end;

function TcxWebMetricsUtils.GetFontSizeInPoints(AFontSize: TcxWebFontSize): Integer;
begin
  case AFontSize.Units of
    wuPixels:
      Result := MulDiv(AFontSize.Value, 72, FPixelsPerInch);  // 1 pt = 1/72 in
    wuPicas:
      Result := MulDiv(AFontSize.Value, 6, FPixelsPerInch);   // 1 pc = 12 pt = 1/6 in
    wuMillimeters:
      Result := MulDiv(AFontSize.Value * 10, 72, 254);   // 1 in = 25.4 mm
    wuCentimeters:
      Result := MulDiv(AFontSize.Value * 100, 72, 254);   // 1 in = 2.54 cm
    wuInches:
      Result := 72 * AFontSize.Value;
    // wuEm: TODO: it is equal to the font size of the parent element
    // wuEx: TODO: it is equal to the height of the lowercase "x".
    // wuPercentage: TODO: it is rate of the font size of the parent element
   else {in points}
     Result := AFontSize.Value;
  end;
end;

function TcxWebMetricsUtils.WebFontToFont(AWebFont: TcxWebFont): {$IFDEF VCL}HFONT{$ELSE}QFontH{$ENDIF};
{$IFDEF VCL}
var
  LogFont: TLogFont;
begin
  FillChar(LogFont, SizeOf(TLogFont), 0);
  with LogFont do
  begin
    lfHeight := -MulDiv(GetFontSizeInPoints(AWebFont.Size), FPixelsPerInch, 72);
    lfWidth := 0;
    lfEscapement := 0;
    lfOrientation := 0;
    if AWebFont.Bold then
      lfWeight := FW_BOLD
    else
      lfWeight := FW_NORMAL;
    lfItalic := Byte(AWebFont.Italic);
    lfUnderline := Byte(AWebFont.Underline);
    lfStrikeOut := Byte(AWebFont.Strikeout);
    lfCharSet := DEFAULT_CHARSET;//Byte(Font.Charset);
    lfOutPrecision := OUT_DEFAULT_PRECIS;
    lfClipPrecision := CLIP_DEFAULT_PRECIS;
    lfQuality := DEFAULT_QUALITY;
    lfPitchAndFamily := DEFAULT_PITCH;
    StrPCopy(lfFaceName, AWebFont.Name);
  end;
  Result := CreateFontIndirect(LogFont);
{$ELSE}
var
  AFontName: WideString;
begin
  Result := QFont_Create();
  AFontName := AWebFont.Name;
  QFont_setFamily(Result, @AFontName);
  QFont_setPixelSize(Result, GetFontSizeInPoints(AWebFont.Size));
  QFont_setBold(Result, AWebFont.Bold);
  QFont_setItalic(Result, AWebFont.Italic);
  QFont_setStrikeOut(Result, AWebFont.StrikeOut);
  QFont_setUnderline(Result, AWebFont.Underline);
{$ENDIF}
end;

function TcxWebMetricsUtils.GetAweCharWidth(AWebFont: TcxWebFont): Integer;
{$IFDEF VCL}
var
  DC: HDC;
  PrevFont: HFONT;
  TM: TTextMetric;
begin
  DC := GetDC(0);
  PrevFont := SelectObject(DC, WebFontToFont(AWebFont));
  GetTextMetrics(DC, TM);
  Result := TM.tmAveCharWidth;
  DeleteObject(SelectObject(DC, PrevFont));
  ReleaseDC(0, DC);
{$ELSE}
var
  AFont: QFontH;
  AFontMetrics: QFontMetricsH;
begin
  AFont := WebFontToFont(AWebFont);
  AFontMetrics := QFontMetrics_Create(AFont);
  Result:= QFontMetrics_maxWidth(AFontMetrics);
  QFontMetrics_Destroy(AFontMetrics);
  QFont_Destroy(AFont);
{$ENDIF}
end;

procedure TcxWebMetricsUtils.GetCheckSize;
{$IFDEF VCL}
const
  OBM_CHECKBOXES = 32759;
begin
  with TBitmap.Create do
    try
      Handle := LoadBitmap(0, PChar(OBM_CHECKBOXES));
      FCheckWidth := Width div 4;
      FCheckHeight := Height div 3;
    finally
      Free;
    end;
{$ELSE}
var
  ChSize: TSize;
begin
  QStyle_indicatorSize(QApplication_style, @ChSize);
  if (ChSize.cx <> 0) and (ChSize.cy <> 0) then
  begin
    FCheckWidth := ChSize.cx;
    FCheckHeight := ChSize.cy;
  end
  else
  begin
    FCheckWidth := 13;
    FCheckHeight := 13;
  end;
{$ENDIF}
end;

function TcxWebMetricsUtils.GetTextSize(const AText: string; AWebFont: TcxWebFont): TSize;
{$IFDEF VCL}
var
  DC: HDC;
  PrevFont: HFONT;
begin
  DC := GetDC(0);
  PrevFont := SelectObject(DC, WebFontToFont(AWebFont));
  GetTextExtentPoint32(DC, PChar(AText), Length(AText), Result);
  DeleteObject(SelectObject(DC, PrevFont));
  ReleaseDC(0, DC);
{$ELSE}
var
  AFont: QFontH;
  AFontMetrics: QFontMetricsH;
  AWideText: WideString;
begin
  AFont := WebFontToFont(AWebFont);
  AFontMetrics := QFontMetrics_Create(AFont);
  Result.cy := QFontMetrics_height(AFontMetrics);
  AWideText := AText;
  Result.cx := QFontMetrics_width(AFontMetrics, @AWideText, Length(AText));
  QFontMetrics_Destroy(AFontMetrics);
  QFont_Destroy(AFont);
{$ENDIF}
end;

function TcxWebMetricsUtils.GetCheckWidth: Integer;
begin
  Result := FCheckWidth;
end;

function TcxWebMetricsUtils.GetCheckHeight: Integer;
begin
  Result := FCheckHeight;
end;

function TcxWebMetricsUtils.GetTextHeight(const AText: string; AWebFont: TcxWebFont): Integer;
begin
  Result := GetTextSize(AText, AWebFont).cy;
end;

function TcxWebMetricsUtils.GetTextWidth(const AText: string; AWebFont: TcxWebFont): Integer;
begin
  Result := GetTextSize(AText, AWebFont).cx;
end;

function TcxWebMetricsUtils.CalcEditHeight(AFont: TcxWebFont): Integer;
{$IFDEF VCL}
var
  DC: HDC;
  PrevFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  PrevFont := SelectObject(DC, WebFontToFont(AFont));
  GetTextMetrics(DC, Metrics);
  DeleteObject(SelectObject(DC, PrevFont));
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight + 2 * GetSystemMetrics(SM_CYBORDER);
{$ELSE}
begin
  Result := 2 + GetTextHeight('Wq', AFont) + 2;
{$ENDIF}
end;

{ TcxWebImageUtils }

constructor TcxWebImageUtils.Create;
begin
  FPicture := TPicture.Create;
  FErrMessage := '';
end;

destructor TcxWebImageUtils.Destroy;
begin
  FPicture.Free;
  inherited;
end;

function TcxWebImageUtils.GetErrMessage: string;
begin
  Result := FErrMessage;
end;

function TcxWebImageUtils.GetHeight: Integer;
begin
  Result := FPicture.Height;
end;

function TcxWebImageUtils.GetWidth: Integer;
begin
  Result := FPicture.Width;
end;

function TcxWebImageUtils.IsEmpty: Boolean;
begin
  Result := (FPicture.Graphic = nil) or FPicture.Graphic.Empty;
end;

procedure TcxWebImageUtils.SetPath(const APath: string);
var
  Ext: string;
begin
  if APath = '' then
  begin
    FPicture.Graphic := nil;
    FErrMessage := '';
  end
  else
    try
      Ext := ExtractFileExt(APath);
      Delete(Ext, 1, 1);
      if Ext = '' then
        raise EInvalidGraphic.CreateFmt(SUnknownExtension, [Ext]);
      FPicture.LoadFromFile(APath);
      FErrMessage := '';
    except
      on E: Exception do
      begin
        FPicture.Graphic := nil;
        FErrMessage := 'DESIGNER WARNING:' + #13#10 + E.Message + #13#10 + 'Image may be missing or displayed incorrectly.';
      end;
    end;
end;

procedure TcxWebImageUtils.SetImage(Value: Variant);
var
  AStream: TStream;
  AHeight, AWidth: Integer;
  NewGraphic: TGraphic;
begin
  if VarIsType(Value, [varEmpty, VarNull]) then Exit;
  {$IFDEF VCL}
  NewGraphic := TJPEGImage.Create;
  {$ELSE}
  NewGraphic := TBitmap.Create;
  {$ENDIF}
  try
    AStream := TMemoryStream.Create;
    LoadPicture(AStream, {$IFDEF VCL}nil,{$ENDIF} Value, AHeight, AWidth);
    try
      AStream.Position := 0;
      NewGraphic.LoadFromStream(AStream);
      FPicture.Graphic := NewGraphic;
    finally
      AStream.Free;
    end;
  finally
    NewGraphic.Free;
  end;
end;

function TcxWebImageUtils.GetGraphic: TGraphic;
begin
  Result := FPicture.Graphic;
end;

initialization
  if Assigned(cxWebMetricsUtils) then
    cxWebMetricsUtils.Free;
  cxWebMetricsUtils := TcxWebMetricsUtils.Create;
  cxWebImageUtilsClass := TcxWebImageUtils;

finalization
  FreeAndNil(cxWebMetricsUtils);
  cxWebImageUtilsClass := nil;
  
end.
