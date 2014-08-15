{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{                    ExpressSkins Library                            }
{                                                                    }
{           Copyright (c) 2006-2010 Developer Express Inc.           }
{                     ALL RIGHTS RESERVED                            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSKINS AND ALL ACCOMPANYING     }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit dxSkinsDefaultPainters;

{$I cxVer.inc}

interface

uses
  Windows, SysUtils, Classes, dxGDIPlusApi, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsLookAndFeelPainter, dxSkinsStrs;

const
  sdxDefaultUserSkinData = 'DefaultUserSkinData';
  sdxSkinsUserSkinName = 'UserSkin';

type

  { TdxSkinsUserSkinPainter }

  TdxSkinsUserSkinPainter = class(TdxSkinLookAndFeelPainter)
  protected
    class function CacheData: TdxSkinLookAndFeelPainterInfo; override;
  public
    class function InternalUnitName: string; override;
  end;

procedure dxSkinsPopulateSkinResources(AModule: HMODULE; AResNames, ASkinNames: TStringList);
function dxSkinsLoadedUserSkinHasMissingElements: Boolean;
function dxSkinsUserSkinLoadFromFile(const AFileName: string; const ASkinName: string = ''): Boolean;
function dxSkinsUserSkinLoadFromFileByIndex(const AFileName: string; ASkinIndex: Integer = 0): Boolean;
function dxSkinsUserSkinLoadFromStream(AStream: TStream; const ASkinName: string = ''): Boolean;
function dxSkinsUserSkinLoadFromStreamByIndex(AStream: TStream; ASkinIndex: Integer = 0): Boolean;
function dxSkinsUserSkinPopulateSkinNames(AStream: TStream;
  AList: TStrings; ADisplayNames: Boolean = False): Boolean; overload;
function dxSkinsUserSkinPopulateSkinNames(const AFileName: string;
  AList: TStrings; ADisplayNames: Boolean = False): Boolean; overload;
implementation

uses
  dxCore, dxSkinInfo, cxLookAndFeels;

{$R dxSkinsDefaultPainters.res}

type

  { TdxSkinUserLookAndFeelPainterInfo }

  TdxSkinUserLookAndFeelPainterInfo = class(TdxSkinLookAndFeelPainterInfo)
  protected
    function GetIsInternalSkin: Boolean; override;
    procedure SkinChanged(Sender: TdxSkin); override;
  end;

  { TdxListPair }

  TdxListPair = class(TObject)
  public
    ResNames, SkinNames: TStringList;
  end;

var
  CachedPainterData: TdxSkinUserLookAndFeelPainterInfo;

function ReadStringFromStream(AStream: TStream): string;
var
  L: Integer;
  ATemp: AnsiString;
begin
  AStream.Read(L, SizeOf(L));
  SetLength(ATemp, L);
  if L > 0 then
    AStream.ReadBuffer(ATemp[1], L);
  Result := dxAnsiStringToString(ATemp);
end;

function EnumResNameProc(hModule: HMODULE; lpszType: LPCTSTR;
  lpszName: LPTSTR; AData: TdxListPair): Boolean; stdcall;

  function IsSkinResource(var ASkinName: string): Boolean;
  var
    AStream: TStream;
    AVersion: Double;
  begin
    AStream := TResourceStream.Create(hModule, lpszName, lpszType);
    try
      Result := dxSkinCheckSignature(AStream, AVersion);
      if Result then
      begin
        ASkinName := ReadStringFromStream(AStream);
        Result := Result and
          (AData.ResNames.IndexOf(lpszName) = -1) and
          (AData.SkinNames.IndexOf(ASkinName) = -1);
      end;
    finally
      AStream.Free;
    end;
  end;

var
  ASkinName: string;
begin
  Result := True;
  if IsSkinResource(ASkinName) then
  begin
    AData.SkinNames.AddObject(ASkinName,
      TObject(AData.ResNames.AddObject(lpszName, TObject(hModule))));
  end;
end;

procedure dxSkinsPopulateSkinResources(AModule: HMODULE; AResNames, ASkinNames: TStringList);
var
  AData: TdxListPair;
begin
  AResNames.Clear;
  ASkinNames.Clear;
  AData := TdxListPair.Create;
  try
    AData.ResNames := AResNames;
    AData.SkinNames := ASkinNames; 
    Windows.EnumResourceNames(AModule, PChar(sdxResourceType), @EnumResNameProc, Integer(AData));
    ASkinNames.Sort;
  finally
    AData.Free; 
  end;
end;

function dxSkinsLoadedUserSkinHasMissingElements: Boolean;
begin
  Result := CachedPainterData.Skin.HasMissingElements;
end;

function dxSkinsUserSkinLoadFromFile(
  const AFileName: string; const ASkinName: string = ''): Boolean;
var
  AFileStream: TFileStream;
begin
  AFileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    Result := dxSkinsUserSkinLoadFromStream(AFileStream, ASkinName);
  finally
    AFileStream.Free;
  end;
end;

function dxSkinsUserSkinLoadFromFileByIndex(const AFileName: string; ASkinIndex: Integer = 0): Boolean;
var
  AFileStream: TFileStream;
begin
  AFileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    Result := dxSkinsUserSkinLoadFromStreamByIndex(AFileStream, ASkinIndex);
  finally
    AFileStream.Free;
  end;
end;

function dxSkinsUserSkinLoadFromStream(AStream: TStream; const ASkinName: string = ''): Boolean;
var
  AReader: TdxSkinBinaryReader;
begin
  AReader := TdxSkinBinaryReader.Create(AStream);
  try
    Result := AReader.LoadSkin(CachedPainterData.Skin, ASkinName);
  finally
    AReader.Free;
  end;
end;

function dxSkinsUserSkinLoadFromStreamByIndex(AStream: TStream; ASkinIndex: Integer = 0): Boolean;
var
  AReader: TdxSkinBinaryReader;
begin
  AReader := TdxSkinBinaryReader.Create(AStream);
  try
    Result := AReader.LoadSkin(CachedPainterData.Skin, ASkinIndex);
  finally
    AReader.Free;
  end;
end;

function dxSkinsUserSkinPopulateSkinNames(
  AStream: TStream; AList: TStrings; ADisplayNames: Boolean = False): Boolean;
var
  AReader: TdxSkinBinaryReader;
  I: Integer;
begin
  AReader := TdxSkinBinaryReader.Create(AStream);
  try
    Result := AReader.Count > 0;
    if Result then
    begin
      AList.Capacity := AReader.Count;
      for I := 0 to AReader.Count - 1 do
      begin
        if ADisplayNames then
          AList.Add(AReader.SkinDisplayName[I])
        else
          AList.Add(AReader.SkinName[I]);
      end;
    end;
  finally
    AReader.Free;
  end;
end;

function dxSkinsUserSkinPopulateSkinNames(const AFileName: string;
  AList: TStrings; ADisplayNames: Boolean = False): Boolean;
var
  AFileStream: TFileStream;
begin
  AFileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    Result := dxSkinsUserSkinPopulateSkinNames(AFileStream, AList, ADisplayNames);
  finally
    AFileStream.Free;
  end;
end;

{ TdxSkinsUserSkinPainter }

class function TdxSkinsUserSkinPainter.CacheData: TdxSkinLookAndFeelPainterInfo;
begin
  Result := CachedPainterData;
end;

class function TdxSkinsUserSkinPainter.InternalUnitName: string;
begin
  Result := 'dxSkinsDefaultPainters';
end;

//

procedure RegisterPainters;
begin
  if CheckGdiPlus then
  begin
    CachedPainterData := TdxSkinUserLookAndFeelPainterInfo.Create(
      TdxSkin.Create(sdxDefaultUserSkinData, True, HInstance));
    GetExtendedStylePainters.Register(sdxSkinsUserSkinName, TdxSkinsUserSkinPainter,
      CachedPainterData);
  end;
end;

procedure UnregisterPainters;
begin
  if GetExtendedStylePainters <> nil then
    GetExtendedStylePainters.UnRegister(sdxSkinsUserSkinName);
end;

{  TdxSkinUserLookAndFeelPainterInfo }

function TdxSkinUserLookAndFeelPainterInfo.GetIsInternalSkin: Boolean;
begin
  Result := True;
end;

procedure TdxSkinUserLookAndFeelPainterInfo.SkinChanged(Sender: TdxSkin);
begin
  inherited SkinChanged(Sender);
  RootLookAndFeel.Refresh;
end;

initialization
  dxUnitsLoader.AddUnit(@RegisterPainters, @UnregisterPainters);

finalization
  dxUnitsLoader.RemoveUnit(@UnregisterPainters);

end.
