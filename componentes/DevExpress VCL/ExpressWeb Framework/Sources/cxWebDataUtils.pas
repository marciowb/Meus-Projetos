{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Data common functions                                       }
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
unit cxWebDataUtils;

{$I cxVer.inc}

interface

uses Classes, Variants,
  {$IFDEF VCL}
  Graphics, Jpeg,
  {$ENDIF}
  SysUtils;

procedure LoadPicture(AStream: TStream; {$IFDEF VCL}GraphicClass: TGraphicClass;{$ENDIF}
  const Value: Variant; var AHeight, AWidth: Integer);
procedure LoadImage(Value: Variant; {$IFDEF VCL}GraphicClass: TGraphicClass;{$ENDIF}
  var URL: string; var AHeight, AWidth: Integer);
function HTMLString(S: string): string;
function HTMLValue(Value: Variant): string;
function ScriptString(S: string): string;
function ScriptValue(Value: Variant): string;

implementation

uses
  cxWebFileCacheManager;

  
type
  TMemoryStreamReadOnly = class(TCustomMemoryStream)
  public
    procedure SetBuffer(const Buffer; Count: Longint);
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

procedure TMemoryStreamReadOnly.SetBuffer(const Buffer; Count: Longint);
begin
  SetPointer(@Buffer, Count);
end;

function TMemoryStreamReadOnly.Write(const Buffer; Count: Longint): Longint;
begin
  Result := 0;
end;


{$IFDEF VCL}
type
  TDummyGraphic = class(TGraphic);
  TDummyGraphicClass = class of TDummyGraphic;

function IsPictureEmpty(APicture: TPicture): Boolean;
begin
  Result := not Assigned(APicture.Graphic) or APicture.Graphic.Empty;
end;
{$ENDIF}

procedure LoadPicture(AStream: TStream; {$IFDEF VCL}GraphicClass: TGraphicClass;{$ENDIF} const Value: Variant;
    var AHeight, AWidth: Integer);
{ Paradox graphic BLOB header - see DB.pas}
type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;
var
  Stream: TMemoryStreamReadOnly;
  Size: Longint;
  Header: TGraphicHeader;
  {$IFDEF VCL}
  Graphic: TGraphic;
  Jpeg: TJPEGImage;
  {$ENDIF}
begin
  if VarType(Value) = varString then // Field.Value -> stored as string
  begin
    Stream := TMemoryStreamReadOnly.Create;
    try
      Size := Length(Value);
      if Size >= SizeOf(TGraphicHeader) then
      begin
        Stream.SetBuffer(string(Value)[1], Size);
        Stream.Position := 0;
        Stream.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> Size - SizeOf(Header)) then
          Stream.Position := 0;
      end;
      if Stream.Size > 0 then
      begin
        {$IFDEF VCL}
        if GraphicClass = nil then
          Graphic := TBitmap.Create
        else Graphic := TDummyGraphicClass(GraphicClass).Create;
        try
          Graphic.LoadFromStream(Stream);
          Jpeg := TJPEGImage.Create;
          try
            with Jpeg do
            begin
              Assign(Graphic);
              SaveToStream(AStream);
              AHeight := Height;
              AWidth := Width;
            end;
          finally
            Jpeg.Free;
          end;
        finally
          Graphic.Free;
        end;
        {$ELSE}
          Stream.SaveToStream(AStream);
        {$ENDIF}
      end;
    finally
      Stream.Free;
    end;
  end;
end;

{
procedure SavePicture(APicture: TPicture; var AValue: string);
var
  AStream: TMemoryStream;
begin
  if not Assigned(APicture) or IsPictureEmpty(APicture) then
    AValue := ''
  else
  begin
    AStream := TMemoryStream.Create;
    try
      APicture.Graphic.SaveToStream(AStream);
      AStream.Position := 0;
      SetLength(AValue, AStream.Size);
      AStream.ReadBuffer(AValue[1], AStream.Size);
    finally
      AStream.Free;
    end;
  end;
end;
}
procedure LoadImage(Value: Variant; {$IFDEF VCL}GraphicClass: TGraphicClass;{$ENDIF}
    var URL: string; var AHeight, AWidth: Integer);
var
  AStream: TStream;
begin
  AStream := TMemoryStream.Create;
  try
    if not VarIsType(Value, [varEmpty, VarNull]) then
    begin
      try
        LoadPicture(AStream, {$IFDEF VCL}GraphicClass,{$ENDIF} Value, AHeight, AWidth);
        URL := TcxWebFileCacheManager.Instance.Add('', AStream);
      except
        URL := '';
        raise;
      end;
    end;
  finally
    AStream.Free;
  end;
end;

function HTMLString(S: string): string;
begin
  Result := S;
end;

function HTMLValue(Value: Variant): string;
begin
  if not VarIsType(Value, [varNull, varEmpty, varUnknown, varDispatch, varAny]) then
  begin
    try
      Result := VarToStr(Value);
      Result := HTMLString(Result);
    except
      Result := '';
    end;
  end
  else Result := '';
end;

function ScriptString(S: string): string;
var
  I: Integer;
begin
  Result := S;
  Result := StringReplace(Result, '\', '\\', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '"', '\"', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '''', '\''', [rfReplaceAll, rfIgnoreCase]);
  for I := 0 to 31 do
    Result := StringReplace(Result, Char(I), '\x' + IntToHex(I, 2), [rfReplaceAll, rfIgnoreCase]);
end;

function ScriptValue(Value: Variant): string;
begin
  if not VarIsType(Value, [varNull, varEmpty, varUnknown, varDispatch, varAny]) then
  begin
    try
      Result := VarToStr(Value);
      Result := ScriptString(Result);
    except
      Result := '';
    end;
  end
  else Result := '';
end;

end.


