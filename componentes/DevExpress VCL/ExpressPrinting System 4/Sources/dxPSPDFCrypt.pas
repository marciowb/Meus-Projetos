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

unit dxPSPDFCrypt;

interface

{$I cxVer.inc}

uses
  Windows, SysUtils, Classes, Math, dxCore;

type
  TdxRC4Key = array[0..255] of Byte;

  TdxMD5Byte16 = array[0..15] of Byte;
  TdxMD5Byte64 = array[0..63] of Byte;
  PdxMD5Byte64 = ^TdxMD5Byte64;

  TdxMD5Int2 = array[0..1] of Cardinal;
  TdxMD5Int4 = array[0..3] of Cardinal;
  TdxMD5Int16 = array[0..15] of Cardinal;
  PdxMD5Int16 = ^TdxMD5Int16;

  TdxMD5Context = record
    State: TdxMD5Int4;
    Count: TdxMD5Int2;
    Buffer: TdxMD5Byte64;
    BufferLen: Cardinal;
  end;

function dxMD5CalcStr(const S: string): string;
function dxMD5DigestToString(const ADigest: TdxMD5Byte16): string;
procedure dxMD5Calc(AInput: PByteArray; AInputLength: Integer; var ADigest: TdxMD5Byte16);
procedure dxMD5Final(var AContext: TdxMD5Context; var ADigest: TdxMD5Byte16);
procedure dxMD5Init(var AContext: TdxMD5Context);
procedure dxMD5Update(var AContext: TdxMD5Context; AInput: PByteArray; AInputLength: Integer); overload;
procedure dxMD5Update(var AContext: TdxMD5Context; const S: AnsiString); overload;

procedure dxRC4Crypt(var AKey: TdxRC4Key; AInData, AOutData: PByteArray; ADataSize: Integer);
procedure dxRC4Initialize(out AKey: TdxRC4Key; APassword: PByteArray; APasswordLength: Integer);
implementation

const
  FFTable: array[0..15] of LongWord = (
    $d76aa478, $e8c7b756, $242070db, $c1bdceee,
    $f57c0faf, $4787c62a, $a8304613, $fd469501,
    $698098d8, $8b44f7af, $ffff5bb1, $895cd7be,
    $6b901122, $fd987193, $a679438e, $49b40821
  );

  GGTable: array[0..15] of LongWord = (
    $f61e2562, $c040b340, $265e5a51, $e9b6c7aa,
    $d62f105d, $02441453, $d8a1e681, $e7d3fbc8,
    $21e1cde6, $c33707d6, $f4d50d87, $455a14ed,
    $a9e3e905, $fcefa3f8, $676f02d9, $8d2a4c8a
  );

  HHTable: array[0..15] of LongWord = (
    $fffa3942, $8771f681, $6d9d6122, $fde5380c,
    $a4beea44, $4bdecfa9, $f6bb4b60, $bebfbc70,
    $289b7ec6, $eaa127fa, $d4ef3085, $04881d05,
    $d9d4d039, $e6db99e5, $1fa27cf8, $c4ac5665
  );

  IITable: array[0..15] of LongWord = (
    $f4292244, $432aff97, $ab9423a7, $fc93a039,
    $655b59c3, $8f0ccc92, $ffeff47d, $85845dd1,
    $6fa87e4f, $fe2ce6e0, $a3014314, $4e0811a1,
    $f7537e82, $bd3af235, $2ad7d2bb, $eb86d391
  );

function ROL(X, N: LongWord): LongWord;
begin
  Result := (X shl N) or (X shr (32 - N));
end;

function FF(A, B, C, D, X, S, AC: LongWord): LongWord;
begin
  Result := ROL(A + X + AC + (B and C or not B and D), S) + B;
end;

function GG(A, B, C, D, X, S, AC: LongWord): LongWord;
begin
  Result := ROL(A + X + AC + (B and D or C and not D), S) + B;
end;

function HH(A, B, C, D, X, S, AC: LongWord): LongWord;
begin
  Result := ROL(A + X + AC + (B xor C xor D), S) + B;
end;

function II(A, B, C, D, X, S, AC: LongWord): LongWord;
begin
  Result := ROL(A + X + AC + (C xor (B or not D)), S) + B;
end;

procedure dxMD5Init(var AContext: TdxMD5Context);
begin
  ZeroMemory(@AContext, SizeOf(AContext));
  AContext.State[0] := $67452301;
  AContext.State[1] := $EFCDAB89;
  AContext.State[2] := $98BADCFE;
  AContext.State[3] := $10325476;
end;

procedure dxMD5Transform(var AAccumulator: TdxMD5Int4; const ABuf: PdxMD5Int16);

  function CalcPos(ARow, AOffset: Integer): Integer;
  begin
    Result := ARow * 4 + AOffset;
    if Result < 0 then
      Inc(Result, 16);
    if Result >= 16 then
      Dec(Result, 16);
  end;

var
  A, B, C, D: LongWord;
  I: Integer;
begin
  A := AAccumulator[0];
  B := AAccumulator[1];
  C := AAccumulator[2];
  D := AAccumulator[3];

  for I := 0 to 3 do
  begin
    A := FF(A, B, C, D, ABuf^[CalcPos(I, 0)],  7, FFTable[4 * I + 0]);
    D := FF(D, A, B, C, ABuf^[CalcPos(I, 1)], 12, FFTable[4 * I + 1]);
    C := FF(C, D, A, B, ABuf^[CalcPos(I, 2)], 17, FFTable[4 * I + 2]);
    B := FF(B, C, D, A, ABuf^[CalcPos(I, 3)], 22, FFTable[4 * I + 3]);
  end;

  for I := 0 to 3 do
  begin
    A := GG(A, B, C, D, ABuf^[CalcPos(I, 1)],   5, GGTable[4 * I + 0]);
    D := GG(D, A, B, C, ABuf^[CalcPos(I, 6)],   9, GGTable[4 * I + 1]);
    C := GG(C, D, A, B, ABuf^[CalcPos(I, 11)], 14, GGTable[4 * I + 2]);
    B := GG(B, C, D, A, ABuf^[CalcPos(I, 0)],  20, GGTable[4 * I + 3]);
  end;

  for I := 0 to 3 do
  begin
    A := HH(A, B, C, D, ABuf^[CalcPos(-I, 5)],   4, HHTable[4 * I + 0]);
    D := HH(D, A, B, C, ABuf^[CalcPos(-I, 8)],  11, HHTable[4 * I + 1]);
    C := HH(C, D, A, B, ABuf^[CalcPos(-I, 11)], 16, HHTable[4 * I + 2]);
    B := HH(B, C, D, A, ABuf^[CalcPos(-I, 14)], 23, HHTable[4 * I + 3]);
  end;

  for I := 0 to 3 do
  begin
    A := II(A, B, C, D, ABuf^[CalcPos(-I, 0)],   6, IITable[4 * I + 0]);
    D := II(D, A, B, C, ABuf^[CalcPos(-I, 7)],  10, IITable[4 * I + 1]);
    C := II(C, D, A, B, ABuf^[CalcPos(-I, 14)], 15, IITable[4 * I + 2]);
    B := II(B, C, D, A, ABuf^[CalcPos(-I, 5)],  21, IITable[4 * I + 3]);
  end;

  Inc(AAccumulator[0], A);
  Inc(AAccumulator[1], B);
  Inc(AAccumulator[2], C);
  Inc(AAccumulator[3], D);
end;

procedure dxMD5Update(var AContext: TdxMD5Context; const S: AnsiString);
begin
  dxMD5Update(AContext, @S[1], Length(S));
end;

procedure dxMD5Update(var AContext: TdxMD5Context; AInput: PByteArray; AInputLength: Integer);
const
  SplitPartSize = 64;
var
  AIndex: Integer;
  ALeft: Integer;
begin
  AIndex := 0;
  if Integer(AInputLength shl 3) < 0 then
    Inc(AContext.Count[1]);

  Inc(AContext.Count[0], AInputLength shl 3);
  Inc(AContext.Count[1], AInputLength shr 29);

  if AContext.BufferLen > 0 then
  begin
    ALeft := Min(AInputLength, SplitPartSize - AContext.BufferLen);
    Move(AInput^[AIndex], AContext.Buffer[AContext.BufferLen], ALeft);
    Inc(AContext.BufferLen, ALeft);
    Inc(AIndex, ALeft);
    if AContext.BufferLen < SplitPartSize then
      Exit;
    dxMD5Transform(AContext.State, @AContext.Buffer[0]);
    AContext.BufferLen := 0;
  end;

  while AIndex + SplitPartSize <= AInputLength do
  begin
    dxMD5Transform(AContext.State, @AInput^[AIndex]);
    Inc(AIndex, SplitPartSize);
  end;

  if AInputLength > AIndex then
  begin
    AContext.BufferLen := AInputLength - AIndex;
    Move(AInput^[AIndex], AContext.Buffer[0], AContext.BufferLen);
  end;
end;

procedure dxMD5Final(var AContext: TdxMD5Context; var ADigest: TdxMD5Byte16);
var
  AWorkBuf: TdxMD5Byte64;
  AWorkLen: Cardinal;
begin
  ADigest := TdxMD5Byte16(AContext.State);
  Move(AContext.Buffer, AWorkBuf, AContext.BufferLen);
  AWorkBuf[AContext.BufferLen] := $80;
  AWorkLen := AContext.BufferLen + 1;
  if AWorkLen > 56 then
  begin
    FillChar(AWorkBuf[AWorkLen], 64 - AWorkLen, 0);
    dxMD5Transform(TdxMD5Int4(ADigest), @AWorkBuf[0]);
    AWorkLen := 0
  end;
  FillChar(AWorkBuf[AWorkLen], 56 - AWorkLen, 0);
  TdxMD5Int16(AWorkBuf)[14] := AContext.Count[0];
  TdxMD5Int16(AWorkBuf)[15] := AContext.Count[1];
  dxMD5Transform(TdxMD5Int4(ADigest), @AWorkBuf[0]);
  FillChar(AContext, SizeOf(AContext), 0);
end;

procedure dxMD5Calc(AInput: PByteArray; AInputLength: Integer; var ADigest: TdxMD5Byte16);
var
  AContext: TdxMD5Context;
begin
  dxMD5Init(AContext);
  dxMD5Update(AContext, AInput, AInputLength);
  dxMD5Final(AContext, ADigest);
end;

function dxMD5CalcStr(const S: string): string;
var
  AAnsiString: AnsiString;
  ADigest: TdxMD5Byte16;
begin
  AAnsiString := dxStringToAnsiString(S);
  dxMD5Calc(@AAnsiString[1], Length(AAnsiString), ADigest);
  Result := dxMD5DigestToString(ADigest);
end;

function dxMD5DigestToString(const ADigest: TdxMD5Byte16): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(ADigest) do
    Result := Result + IntToHex(ADigest[I], 2);
end;

procedure dxRC4Initialize(out AKey: TdxRC4Key; APassword: PByteArray; APasswordLength: Integer);
var
  ATempKey: TdxRC4Key;
  I, J, K: Integer;
begin
  for I := 0 to 255 do
  begin
    ATempKey[I] := APassword^[I mod APasswordLength];
    AKey[I] := I;
  end;

  J := 0;
  for I := 0 to 255 do
  begin
    J := (J + AKey[I] + ATempKey[I]) and $FF;
    K := AKey[I];
    AKey[I] := AKey[J];
    AKey[j] := K;
  end;
end;

procedure dxRC4Crypt(var AKey: TdxRC4Key; AInData, AOutData: PByteArray; ADataSize: Integer);
var
  T, K, I, J: Integer;
begin
  I := 0;
  J := 0;
  for K := 0 to ADataSize - 1 do
  begin
    I := Byte(I + 1);
    J := Byte(J + AKey[I]);

    T := AKey[I];
    AKey[I] := AKey[J];
    AKey[J] := T;

    T := Byte(AKey[I] + AKey[J]);
    AOutData^[K] := AInData^[K] xor AKey[T];
  end;
end;

end.
