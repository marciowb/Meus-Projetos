{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxBarSkin;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ExtCtrls, dxCore, cxGraphics, dxGDIPlusAPI,
  dxSkinsCore;

type
  TdxCustomBarSkin = class;

  TcxSkinRectType = (spt1x1, spt3x1, spt1x3, spt3x3);
  TdxSkinRectStretchMode = (srsmStretch, srsmTile);

  { TdxSkinnedRect }

  TdxSkinnedRect = class(TObject)
  private
    FAlphaValue: Byte;
    FCalculatedSize: TSize;
    FFixedPartSize: TRect;
    FGPCacheBitmap: GpBitmap;
    FGPImage: GpBitmap;
    FID: Integer;
    FInterpolationMode: Integer;
    FLastSize: TSize;
    FMinSize: TSize;
    FName: string;
    FOpaque: Boolean;
    FPartsBounds: TdxSkinElementPartBounds;
    FSize: TSize;
    FSourcePartsBounds: TdxSkinElementPartBounds;
    FStretchMode: TdxSkinRectStretchMode;
    FTextOffset: TRect;
    procedure CalculatePartBounds;
    procedure CheckCachedImage;
    procedure CheckCalculate(AWidth, AHeight: Integer);
    procedure SetInterpolationMode(Value: Integer);
    procedure SetStretchMode(AValue: TdxSkinRectStretchMode);
    procedure UpdateCacheImage;
    procedure UpdateSizes;
  protected
    procedure Calculate(AWidth, AHeight: Integer); virtual;
    procedure Clear; virtual;
    procedure DefaultDraw(DC: HDC; const R: TRect); virtual;
    procedure DoDraw(DC: HDC; const R: TRect); virtual;

    property CalculatedSize: TSize read FCalculatedSize;
  public
    constructor Create(AOpaque: Boolean = False);
    destructor Destroy; override;
    procedure Draw(DC: HDC; const R: TRect; AlphaValue: Byte = 255);
    function GetBitmap(const AWidth, AHeight: Integer; AUseAlphaChannel: Boolean = False): TBitmap;
    function GetTextBounds(const R: TRect): TRect; virtual;
    procedure LoadFromBitmap(ABitmap: GpBitmap; const ARect, AFixedPartSize: TRect);
    procedure LoadFromFile(const AFileName: string; const AFixedPartSize: TRect); overload;
    procedure LoadFromFile(const AFileName: string; const ARect, AFixedPartSize: TRect); overload;

    property AlphaValue: Byte read FAlphaValue write FAlphaValue default 255;
    property ID: Integer read FID write FID;
    property InterpolationMode: Integer read FInterpolationMode write SetInterpolationMode default InterpolationModeDefault;
    property MinSize: TSize read FMinSize write FMinSize;
    property Name: string read FName write FName;
    property Opaque: Boolean read FOpaque write FOpaque;
    property Size: TSize read FSize;
    property StretchMode: TdxSkinRectStretchMode read FStretchMode write SetStretchMode;
    property TextOffset: TRect read FTextOffset write FTextOffset;
  end;

  { TdxCustomBarSkin }

  TdxCustomBarSkin = class(TList)
  private
    FName: string;
    function GetPart(Index: Integer): TdxSkinnedRect;
  protected
    function GetDisplayName: string; virtual; abstract;
    function IsPersistent: Boolean; virtual;
  public
    constructor Create(const AName: string);
    procedure Clear; override;
    function Add(ASkinnedRect: TdxSkinnedRect): Integer;
    function AddPart1x1(ABitmap: GpBitmap; const R: TRect; AID: Integer;
      const AName: string = ''; AInterpolationMode: Integer = InterpolationModeDefault): Integer;
    function AddPart1x3(ABitmap: GpBitmap; const R: TRect; ATop, ABottom, AID: Integer;
      const AName: string = ''; AInterpolationMode: Integer = InterpolationModeDefault): Integer;
    function AddPart3x3(ABitmap: GpBitmap; const R, AFixedSize: TRect;
      AID: Integer; const AName: string = ''; AInterpolationMode: Integer = InterpolationModeDefault): Integer;
    function PartByName(const AName: string): TdxSkinnedRect;
    function PartByID(const AID: Integer): TdxSkinnedRect;
    //
    property DisplayName: string read GetDisplayName;
    property Name: string read FName write FName;
    property Parts[Index: Integer]: TdxSkinnedRect read GetPart; default;
  end;

  TdxCustomBarSkinClass = class of TdxCustomBarSkin;

  { TcxSkinManager }

  TdxBarSkinManager = class(TPersistent)
  private
    FList: TList;
    function GetSkin(Index: Integer): TdxCustomBarSkin;
    function GetSkinCount: Integer;
  protected
    function CanDeleteSkin(ASkin: TdxCustomBarSkin): Boolean;
    procedure Changed; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function AddSkin(ASkin: TdxCustomBarSkin): Integer;
    function RemoveSkin(ASkin: TdxCustomBarSkin): Boolean;
    function SkinByName(const AName: string): TdxCustomBarSkin;
    //
    property SkinCount: Integer read GetSkinCount;
    property Skins[Index: Integer]: TdxCustomBarSkin read GetSkin; default;
  end;

function SkinManager: TdxBarSkinManager;
implementation

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}  
  cxGeometry, dxOffice11, cxControls, dxBar, cxDWMApi, ActiveX, dxGDIPlusClasses;

var
  FSkinManager: TdxBarSkinManager;

function SkinManager: TdxBarSkinManager;
begin
  if FSkinManager = nil then
    FSkinManager := TdxBarSkinManager.Create;
  Result := FSkinManager;
end;

function dxAlphaBlend(ADestDC: HDC; const ADestRect: TRect; ASrcDC: HDC; const ASrcRect: TRect;
  AlphaValue: Byte = 255): Boolean;
begin
  if IsWin9X then
  begin
    Result := True;
    cxAlphaBlend(ADestDC, ASrcDC, ADestRect, ASrcRect, False, AlphaValue);
  end
  else
    Result := SystemAlphaBlend(ADestDC, ASrcDC, ADestRect, ASrcRect, AlphaValue);
end;

{ TdxSkinnedRect }

constructor TdxSkinnedRect.Create(AOpaque: Boolean = False);
begin
  FID := -1;
  FAlphaValue := 255;
  FOpaque := AOpaque;
  FTextOffset := cxRect(8, 8, 8, 8);
  FInterpolationMode := InterpolationModeDefault;
end;

destructor TdxSkinnedRect.Destroy;
begin
  if FGPImage <> nil then
    GdipDisposeImage(FGPImage);
  if FGPCacheBitmap <> nil then
    GdipDisposeImage(FGPCacheBitmap);
  inherited Destroy;
end;

procedure TdxSkinnedRect.Calculate(AWidth, AHeight: Integer);
begin
  dxSkinsCalculatePartsBounds(Bounds(0, 0, AWidth, AHeight), FFixedPartSize, FPartsBounds);
end;

procedure TdxSkinnedRect.Clear;
begin
  FCalculatedSize := cxNullSize;
end;

procedure TdxSkinnedRect.DefaultDraw(DC: HDC; const R: TRect);
begin
  FillRectByColor(DC, R, clBtnFace);
end;

procedure TdxSkinnedRect.DoDraw(DC: HDC; const R: TRect);
var
  H, OldBitmap: HBITMAP;
  BDC: HDC;
begin
  CheckCachedImage;
  GdipCreateHBITMAPFromBitmap(FGPCacheBitmap, H, 0);
  BDC := CreateCompatibleDC(DC);
  OldBitmap := SelectObject(BDC, H);
  if not (FOpaque or dxAlphaBlend(DC, R, BDC, cxRect(CalculatedSize), AlphaValue)) then
    cxBitBlt(DC, BDC, R, cxPoint(0, 0), srccopy);
  SelectObject(BDC, OldBitmap);
  DeleteDC(BDC);
  DeleteObject(H);
end;

procedure TdxSkinnedRect.Draw(DC: HDC; const R: TRect; AlphaValue: Byte = 255);
begin
  FAlphaValue := AlphaValue;
  if (R.Right > R.Left) and (R.Bottom > R.Top) then
  begin
    CheckCalculate(R.Right - R.Left, R.Bottom - R.Top);
    if RectVisible(DC, R) then
      DoDraw(DC, R)
  end;
end;

function TdxSkinnedRect.GetBitmap(const AWidth, AHeight: Integer;
  AUseAlphaChannel: Boolean = False): TBitmap;
var
  ABitmap: TcxBitmap32;
begin
  ABitmap := TcxBitmap32.CreateSize(AWidth, AHeight, True);
  Draw(ABitmap.Canvas.Handle, ABitmap.ClientRect);
  if AUseAlphaChannel then
    ABitmap.RecoverTransparency(clFuchsia);
  Result := ABitmap;
end;

function TdxSkinnedRect.GetTextBounds(const R: TRect): TRect;
begin
  Result := cxRectContent(R, FTextOffset);
end;

procedure TdxSkinnedRect.LoadFromBitmap(ABitmap: GpBitmap; const ARect, AFixedPartSize: TRect);
var
  G: GpGraphics;
begin
  Clear;
  FGPImage := dxGpCreateBitmap(ARect);
  GdipCheck(GdipGetImageGraphicsContext(FGPImage, G));
  GdipCheck(GdipSetInterpolationMode(G, InterpolationModeNearestNeighbor));
  GdipCheck(GdipSetCompositingMode(G, CompositingModeSourceCopy));
  GdipCheck(GdipDrawImageRectRectI(G, ABitmap, 0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top,
    ARect.Left, ARect.Top, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, UnitPixel, nil, nil, nil));
  GdipCheck(GdipDeleteGraphics(G));
  FFixedPartSize := AFixedPartSize;
  CalculatePartBounds;
  UpdateSizes;
end;

procedure TdxSkinnedRect.LoadFromFile(const AFileName: string; const AFixedPartSize: TRect);
begin
  Clear;
  FFixedPartSize := AFixedPartSize;
  GdipCheck(GdipLoadImageFromFile(PWideChar(WideString(AFileName)), FGPImage));
  CalculatePartBounds;
  UpdateSizes;
end;

procedure TdxSkinnedRect.LoadFromFile(const AFileName: string; const ARect, AFixedPartSize: TRect);
var
  B: GpBitmap;
  G: GpGraphics;
begin
  Clear;
  FFixedPartSize := AFixedPartSize;
  GdipCheck(GdipLoadImageFromFile(PWideChar(WideString(AFileName)), B));
  FGPImage := dxGpCreateBitmap(ARect);
  GdipCheck(GdipGetImageGraphicsContext(FGPImage, G));
  GdipCheck(GdipDrawImageRectRectI(G, B, 0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top,
    ARect.Left, ARect.Top, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, UnitPixel, nil, nil, nil));
  GdipCheck(GdipDeleteGraphics(G));
  GdipCheck(GdipDisposeImage(B));
  CalculatePartBounds;
  UpdateSizes;
end;

procedure TdxSkinnedRect.CalculatePartBounds;
begin
  GdipCheck(GdipGetImageWidth(FGPImage, FSize.cx));
  GdipCheck(GdipGetImageHeight(FGPImage, FSize.cy));
  dxSkinsCalculatePartsBounds(cxRect(FSize), FFixedPartSize, FSourcePartsBounds);
end;

procedure TdxSkinnedRect.CheckCachedImage;
begin
  if (FLastSize.cx <> CalculatedSize.cx) or (FLastSize.cy <> CalculatedSize.cy) then
  begin
    FLastSize := CalculatedSize;
    if FGPCacheBitmap <> nil then
      GdipDisposeImage(FGPCacheBitmap);
    FGPCacheBitmap := dxGpCreateBitmap(CalculatedSize);
    UpdateCacheImage;
  end;
end;

procedure TdxSkinnedRect.CheckCalculate(AWidth, AHeight: Integer);
begin
  if (AWidth <> CalculatedSize.cx) or (AHeight <> CalculatedSize.cy) then
  begin
    Calculate(AWidth, AHeight);
    FCalculatedSize.cx := AWidth;
    FCalculatedSize.cy := AHeight;
  end;
end;

procedure TdxSkinnedRect.SetInterpolationMode(Value: Integer);
begin
  if IsWinSeven then
    Value := InterpolationModeDefault;
  FInterpolationMode := Value;
end;

procedure TdxSkinnedRect.SetStretchMode(AValue: TdxSkinRectStretchMode);
begin
  if AValue <> FStretchMode then
  begin
    FStretchMode := AValue;
    FCalculatedSize := cxNullSize;
  end;
end;

procedure TdxSkinnedRect.UpdateCacheImage;
var
  AGraphics: GpGraphics;
  APart: TdxSkinImagePart;
begin
  GdipCheck(GdipGetImageGraphicsContext(FGPCacheBitmap, AGraphics));
  GdipCheck(GdipSetInterpolationMode(AGraphics, FInterpolationMode));
  GdipCheck(GdipSetCompositingMode(AGraphics, CompositingModeSourceCopy));
  for APart := Low(TdxSkinImagePart) to High(TdxSkinImagePart) do
  begin
    if StretchMode = srsmStretch then
      dxGpDrawImage(AGraphics, FPartsBounds[APart], FSourcePartsBounds[APart], FGPImage)
    else
      dxGpTilePartEx(AGraphics, FPartsBounds[APart], FSourcePartsBounds[APart], FGPImage);
  end;
  GdipCheck(GdipDeleteGraphics(AGraphics));
end;

procedure TdxSkinnedRect.UpdateSizes;
begin
  FTextOffset := FFixedPartSize;
  FMinSize.cx := FTextOffset.Left + FTextOffset.Right;
  FMinSize.cy := FTextOffset.Top + FTextOffset.Bottom;
end;

{ TdxCustomBarSkin }

constructor TdxCustomBarSkin.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
end;

function TdxCustomBarSkin.Add(ASkinnedRect: TdxSkinnedRect): Integer;
var
  I: Integer;
begin
  Result := -1;
  if ASkinnedRect = nil then Exit;
  for I := 0 to Count - 1 do
    with Parts[I] do
      if (ASkinnedRect.ID <> -1) and (ASkinnedRect.ID = ID) then
        raise EdxException.CreateFmt('ERROR: Duplicate part''s ID = %d', [ASkinnedRect.ID])
      else if (ASkinnedRect.Name <> '') and (AnsiSameText(ASkinnedRect.Name, Name)) then
        raise EdxException.CreateFmt('ERROR: Duplicate part''s name = "%s"', [ASkinnedRect.Name]);
  Result := inherited Add(ASkinnedRect);
end;

function TdxCustomBarSkin.AddPart1x1(ABitmap: GpBitmap;
  const R: TRect; AID: Integer; const AName: string = '';
  AInterpolationMode: Integer = InterpolationModeDefault): Integer;
var
  P: TdxSkinnedRect;
begin
  P := TdxSkinnedRect.Create;
  P.LoadFromBitmap(ABitmap, R, cxNullRect);
  P.ID := AID;
  P.Name := AName;
  P.InterpolationMode := AInterpolationMode;
  Result := Add(P);
end;

function TdxCustomBarSkin.AddPart1x3(ABitmap: GpBitmap;
  const R: TRect; ATop, ABottom, AID: Integer; const AName: string = '';
  AInterpolationMode: Integer = InterpolationModeDefault): Integer;
var
  P: TdxSkinnedRect;
begin
  P := TdxSkinnedRect.Create;
  P.LoadFromBitmap(ABitmap, R, cxRect(0, ATop, 0, ABottom));
  P.ID := AID;
  P.Name := AName;
  P.InterpolationMode := AInterpolationMode;
  Result := Add(P);
end;

function TdxCustomBarSkin.AddPart3x3(ABitmap: GpBitmap; const R,
  AFixedSize: TRect; AID: Integer; const AName: string = '';
  AInterpolationMode: Integer = InterpolationModeDefault): Integer;
var
  P: TdxSkinnedRect;
begin
  P := TdxSkinnedRect.Create;
  P.LoadFromBitmap(ABitmap, R, AFixedSize);
  P.ID := AID;
  P.Name := AName;
  P.InterpolationMode := AInterpolationMode;
  Result := Add(P);
end;

procedure TdxCustomBarSkin.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Parts[I].Free;
  inherited Clear;
end;

function TdxCustomBarSkin.PartByID(const AID: Integer): TdxSkinnedRect;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if AID = Parts[I].ID then
    begin
      Result := Parts[I];
      Break;
    end;
end;

function TdxCustomBarSkin.PartByName(const AName: string): TdxSkinnedRect;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if AnsiSameText(AName, Parts[I].Name) then
    begin
      Result := Parts[I];
      Break;
    end;
end;

function TdxCustomBarSkin.IsPersistent: Boolean;
begin
  Result := False;
end;

function TdxCustomBarSkin.GetPart(Index: Integer): TdxSkinnedRect;
begin
  Result := TdxSkinnedRect(List^[Index]);
end;

{ TdxBarSkinManager }

constructor TdxBarSkinManager.Create;
begin
  FList := TList.Create;
end;

destructor TdxBarSkinManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    Skins[I].Free;
  FList.Free;
  inherited Destroy;
end;

function TdxBarSkinManager.AddSkin(ASkin: TdxCustomBarSkin): Integer;
begin
  Result := -1;
  if CheckGdiPlus then
  begin
    if (ASkin <> nil) and (ASkin.Name <> '') then
    begin
      if SkinByName(ASkin.Name) <> nil then
        Exit;
    end;
    Result := FList.Add(ASkin);
    Changed;
  end
end;

function TdxBarSkinManager.CanDeleteSkin(ASkin: TdxCustomBarSkin): Boolean;
begin
  Result := not ASkin.IsPersistent;
end;

procedure TdxBarSkinManager.Changed;
begin
end;

function TdxBarSkinManager.GetSkin(Index: Integer): TdxCustomBarSkin;
begin
  Result := TdxCustomBarSkin(FList[Index]);
end;

function TdxBarSkinManager.RemoveSkin(ASkin: TdxCustomBarSkin): Boolean;
var
  I: Integer;
begin
  Result := CanDeleteSkin(ASkin);
  if Result then
  begin
    I := FList.IndexOf(ASkin);
    if I >= 0 then
    begin
      ASkin.Free;
      FList.Delete(I);
      Changed;
    end;
  end;
end;

function TdxBarSkinManager.SkinByName(const AName: string): TdxCustomBarSkin;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to SkinCount - 1 do
    if AnsiSameText(AName, Skins[I].Name) then
    begin
      Result := Skins[I];
      Break;
    end;
end;

function TdxBarSkinManager.GetSkinCount: Integer;
begin
  Result := FList.Count;
end;

procedure DestroySkinManager;
begin
  FreeAndNil(FSkinManager);
end;

initialization

finalization
  DestroySkinManager;

end.
