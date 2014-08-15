
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxEditPaintUtils;

{$I cxVer.inc}

interface

uses
  Windows, Classes, Controls, Graphics, SysUtils, cxClasses,
  cxControls, cxGraphics, cxLookAndFeels;

const
  cxSolidBrushCacheDefaultMaxDepth = 128;

type
  { TcxSolidBrushCache }

  TcxSolidBrushCache = class
  private
    FBrushColors: array of TColor;
    FBrushes: array of TBrushHandle;
    FCounts: array of Cardinal;
    FDepth: Integer;
    FMaxDepth: Integer;
    FSystemPaletteChangedNotifier: TcxSystemPaletteChangedNotifier;
  protected
    procedure SystemPaletteChanged; virtual;
  public
    constructor Create; overload;
    constructor Create(AMaxDepth: Integer); overload;
    destructor Destroy; override;
    procedure Clear;
    function GetBrush(ABrushColor: TColor): TBrushHandle;
  end;

function GetSolidBrush(ABrushColor: TColor): TBrushHandle; overload;
function GetSolidBrush(ACanvas: TCanvas; ABrushColor: TColor): TBrushHandle; overload;
function GetSolidBrush(ACanvas: TcxCanvas; ABrushColor: TColor): TBrushHandle; overload;
procedure ResetSolidBrushCache;

implementation

uses
  Forms;

const
  cxSysColorPrefix: Cardinal = {$IFDEF DELPHI7}clSystemColor{$ELSE}$80000000{$ENDIF};

var
  FSolidBrushCache: TcxSolidBrushCache = nil;
  FSystemBrushes: array of TBrushHandle;

function GetSolidBrush(ABrushColor: TColor): TBrushHandle;
begin
  Result := FSolidBrushCache.GetBrush(ABrushColor);
end;

function GetSolidBrush(ACanvas: TCanvas; ABrushColor: TColor): TBrushHandle;
begin
  Result := FSolidBrushCache.GetBrush(ABrushColor);
end;

function GetSolidBrush(ACanvas: TcxCanvas; ABrushColor: TColor): TBrushHandle;
begin
  Result := FSolidBrushCache.GetBrush(ABrushColor);
end;

procedure ResetSolidBrushCache;
begin
  FSolidBrushCache.Clear;
end;

procedure CreateSystemBrushes;
var
  I: Word;
begin
  SetLength(FSystemBrushes, COLOR_ENDCOLORS - COLOR_SCROLLBAR + 1);
  for I := COLOR_SCROLLBAR to COLOR_ENDCOLORS do
    FSystemBrushes[I] := GetSysColorBrush(I);
end;

procedure DestroySystemBrushes;
begin
  FSystemBrushes := nil;
end;

{ TcxSolidBrushCache }

constructor TcxSolidBrushCache.Create;
begin
  Create(cxSolidBrushCacheDefaultMaxDepth);
end;

constructor TcxSolidBrushCache.Create(AMaxDepth: Integer);
begin
  inherited Create;
  FMaxDepth := AMaxDepth;
  SetLength(FBrushColors, FMaxDepth);
  SetLength(FBrushes, FMaxDepth);
  SetLength(FCounts, FMaxDepth);
  FSystemPaletteChangedNotifier := TcxSystemPaletteChangedNotifier.Create(True);
  FSystemPaletteChangedNotifier.OnSystemPaletteChanged := SystemPaletteChanged;
end;

destructor TcxSolidBrushCache.Destroy;
begin
  FreeAndNil(FSystemPaletteChangedNotifier);
  Clear;
  FBrushColors := nil;
  FBrushes := nil;
  FCounts := nil;
  inherited Destroy;
end;

procedure TcxSolidBrushCache.Clear;
var
  I: Integer;
begin
  for I := 0 to FDepth - 1 do
    DeleteObject(FBrushes[I]);
  FDepth := 0;
end;

function TcxSolidBrushCache.GetBrush(ABrushColor: TColor): TBrushHandle;

  function GetColorIndex(AColor: TColor; out AIndex: Integer): Boolean;
  var
    L, H, I, C: Integer;
  begin
    Result := False;
    L := 0;
    H := FDepth - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      C := FBrushColors[I] - AColor;
      if C < 0 then
        L := I + 1
      else
      begin
        H := I - 1;
        if C = 0 then
        begin
          Result := True;
          L := I;
        end;
      end;
    end;
    AIndex := L;
  end;

  function GetRarestColorIndex: Integer;
  var
    I, ACount, AMinCount: Integer;
  begin
    Result := 0;
    AMinCount := FCounts[0];
    if AMinCount = 0 then
      Exit;
    for I := 1 to FDepth - 1 do
    begin
      ACount := FCounts[I];
      if ACount < AMinCount then
      begin
        Result := I;
        if ACount = 0 then
          Break
        else
          AMinCount := ACount;
      end;
    end;
  end;

  function PrepareNewItem(AIndex: Integer): TBrushHandle;
  var
    ACount, ARarestColorIndex: Integer;
  begin
    if FDepth = FMaxDepth then
    begin
      ARarestColorIndex := GetRarestColorIndex;
      DeleteObject(FBrushes[ARarestColorIndex]);
      Dec(FDepth);
      if ARarestColorIndex < FDepth then
      begin
        ACount := (FDepth - ARarestColorIndex) shl 2;
        Move(FBrushColors[ARarestColorIndex + 1], FBrushColors[ARarestColorIndex], ACount);
        Move(FBrushes[ARarestColorIndex + 1], FBrushes[ARarestColorIndex], ACount);
        Move(FCounts[ARarestColorIndex + 1], FCounts[ARarestColorIndex], ACount);
      end;
      if AIndex > ARarestColorIndex then
        Dec(AIndex);
    end;
    if AIndex < FDepth then
    begin
      ACount := (FDepth - AIndex) shl 2;
      Move(FBrushColors[AIndex], FBrushColors[AIndex + 1], ACount);
      Move(FBrushes[AIndex], FBrushes[AIndex + 1], ACount);
      Move(FCounts[AIndex], FCounts[AIndex + 1], ACount);
    end;
    Inc(FDepth);
    Result := CreateSolidBrush(ColorToRGB(ABrushColor));
    FBrushColors[AIndex] := ABrushColor;
    FBrushes[AIndex] := Result;
    FCounts[AIndex] := 0;
  end;

var
  AColorIndex: Integer;
begin
  if FSystemBrushes <> nil then
    if (Cardinal(ABrushColor) >= cxSysColorPrefix) and (Cardinal(ABrushColor) <= cxSysColorPrefix or COLOR_ENDCOLORS) then
    begin
      Result := FSystemBrushes[ABrushColor and not cxSysColorPrefix];
      Exit;
    end;
  if GetColorIndex(ABrushColor, AColorIndex) then
  begin
    Inc(FCounts[AColorIndex]);
    Result := FBrushes[AColorIndex];
  end
  else
    Result := PrepareNewItem(AColorIndex);
end;

procedure TcxSolidBrushCache.SystemPaletteChanged;
begin
  Clear;
end;

initialization
  CreateSystemBrushes;
  FSolidBrushCache := TcxSolidBrushCache.Create;

finalization
  FreeAndNil(FSolidBrushCache);
  DestroySystemBrushes;

end.
