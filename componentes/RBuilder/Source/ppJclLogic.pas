{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{**************************************************************************************************}
{ This unit is a adapted from the Project JEDI Code Library (JCL). The original header appears     }
{ in the box below.                                                                                }
{                                                                                                  }
{ original unit: JclLogic.pas                                                                       }
{                                                                                                  }
{ This unit is a subset of the original. It contains only types, classes and methods,              }
{ required to support the JvInspector and related classes. A prefix of pp has been added           }
{ to all classes and methods to differentiate them from the original. This has been done to        }
{ avoid conflicts for users that install ReportBuilder and the JCL.                                }
{                                                                                                  }
{**************************************************************************************************}

{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclLogic.pas.                                                               }
{                                                                                                  }
{ The Initial Developer of the Original Code is documented in the accompanying                     }
{ help file JCL.chm. Portions created by these individuals are Copyright (C) of these individuals. }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Various routines to perform various arithmetic and logical operations on one or more ordinal     }
{ values (integer numbers). This includes various bit manipulation routines, min/max testing and   }
{ conversion to string.                                                                            }
{                                                                                                  }
{ Unit owner: Marcel van Brakel                                                                    }
{ Last modified: September 2, 2001                                                                 }
{                                                                                                  }
{**************************************************************************************************}

unit ppJclLogic;

interface

//--------------------------------------------------------------------------------------------------
// Bit manipulation
//--------------------------------------------------------------------------------------------------

type
  TBitRange = Byte;
  TBooleanArray = array of Boolean;

function ppJclClearBit(const Value: Byte; const Bit: TBitRange): Byte; overload;
function ppJclClearBit(const Value: Shortint; const Bit: TBitRange): Shortint; overload;
function ppJclClearBit(const Value: Smallint; const Bit: TBitRange): Smallint; overload;
function ppJclClearBit(const Value: Word; const Bit: TBitRange): Word; overload;
function ppJclClearBit(const Value: Integer; const Bit: TBitRange): Integer; overload;
function ppJclClearBit(const Value: Cardinal; const Bit: TBitRange): Cardinal; overload;
function ppJclClearBit(const Value: Int64; const Bit: TBitRange): Int64; overload;
procedure ppJclClearBitBuffer(var Value; const Bit: TBitRange); // todo document

function ppJclSetBit(const Value: Byte; const Bit: TBitRange): Byte; overload;
function ppJclSetBit(const Value: Shortint; const Bit: TBitRange): Shortint; overload;
function ppJclSetBit(const Value: Smallint; const Bit: TBitRange): Smallint; overload;
function ppJclSetBit(const Value: Word; const Bit: TBitRange): Word; overload;
function ppJclSetBit(const Value: Cardinal; const Bit: TBitRange): Cardinal; overload;
function ppJclSetBit(const Value: Integer; const Bit: TBitRange): Integer; overload;
function ppJclSetBit(const Value: Int64; const Bit: TBitRange): Int64; overload;
procedure ppJclSetBitBuffer(var Value; const Bit: TBitRange); // todo document

function ppJclTestBit(const Value: Byte; const Bit: TBitRange): Boolean; overload;
function ppJclTestBit(const Value: Shortint; const Bit: TBitRange): Boolean; overload;
function ppJclTestBit(const Value: Smallint; const Bit: TBitRange): Boolean; overload;
function ppJclTestBit(const Value: Word; const Bit: TBitRange): Boolean; overload;
function ppJclTestBit(const Value: Cardinal; const Bit: TBitRange): Boolean; overload;
function ppJclTestBit(const Value: Integer; const Bit: TBitRange): Boolean; overload;
function ppJclTestBit(const Value: Int64; const Bit: TBitRange): Boolean; overload;
function ppJclTestBitBuffer(const Value; const Bit: TBitRange): Boolean; // todo document


implementation

const
  // Constants defining the number of bits in each Integer type

  BitsPerNibble   = 4;
  BitsPerByte     = 8;
  BitsPerShortint = SizeOf(Shortint) * BitsPerByte;
  BitsPerSmallint = SizeOf(Smallint) * BitsPerByte;
  BitsPerWord     = SizeOf(Word) * BitsPerByte;
  BitsPerInteger  = SizeOf(Integer) * BitsPerByte;
  BitsPerCardinal = SizeOf(Cardinal) * BitsPerByte;
  BitsPerInt64    = SizeOf(Int64) * BitsPerByte;


//--------------------------------------------------------------------------------------------------
// Bit manipulation
//--------------------------------------------------------------------------------------------------


//--------------------------------------------------------------------------------------------------

function ppJclClearBit(const Value: Byte; const Bit: TBitRange): Byte;
begin
  Result := Value and not (1 shl (Bit mod BitsPerByte));
end;

//--------------------------------------------------------------------------------------------------

function ppJclClearBit(const Value: Shortint; const Bit: TBitRange): Shortint;
begin
  Result := Value and not (1 shl (Bit mod BitsPerShortint));
end;

//--------------------------------------------------------------------------------------------------

function ppJclClearBit(const Value: Smallint; const Bit: TBitRange): Smallint;
begin
  Result := Value and not (1 shl (Bit mod BitsPerSmallint));
end;

//--------------------------------------------------------------------------------------------------

function ppJclClearBit(const Value: Word; const Bit: TBitRange): Word;
begin
  Result := Value and not (1 shl (Bit mod BitsPerWord));
end;

//--------------------------------------------------------------------------------------------------

function ppJclClearBit(const Value: Cardinal; const Bit: TBitRange): Cardinal;
begin
  Result := Value and not (1 shl (Bit mod BitsPerCardinal));
end;

//--------------------------------------------------------------------------------------------------

function ppJclClearBit(const Value: Integer; const Bit: TBitRange): Integer;
begin
  Result := Value and not (1 shl (Bit mod BitsPerInteger));
end;

//--------------------------------------------------------------------------------------------------

function ppJclClearBit(const Value: Int64; const Bit: TBitRange): Int64;
begin
  Result := Value and not (Int64(1) shl (Bit mod BitsPerInt64));
end;

//--------------------------------------------------------------------------------------------------

procedure ppJclClearBitBuffer(var Value; const Bit: TBitRange);
var
  P: PByte;
  BitOfs: TBitRange;
begin
  P := Addr(Value);
  Inc(P, Bit div 8);
  BitOfs := Bit mod 8;
  P^ := ppJclClearBit(P^, BitOfs);
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetBit(const Value: Byte; const Bit: TBitRange): Byte;
begin
  Result := Value or (1 shl (Bit mod BitsPerByte));
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetBit(const Value: Shortint; const Bit: TBitRange): Shortint;
begin
  Result := Value or (1 shl (Bit mod BitsPerShortint));
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetBit(const Value: Smallint; const Bit: TBitRange): Smallint;
begin
  Result := Value or (1 shl (Bit mod BitsPerSmallint));
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetBit(const Value: Word; const Bit: TBitRange): Word;
begin
  Result := Value or (1 shl (Bit mod BitsPerWord));
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetBit(const Value: Cardinal; const Bit: TBitRange): Cardinal;
begin
  Result := Value or (1 shl (Bit mod BitsPerCardinal));
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetBit(const Value: Integer; const Bit: TBitRange): Integer;
begin
  Result := Value or (1 shl (Bit mod BitsPerInteger));
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetBit(const Value: Int64; const Bit: TBitRange): Int64;
begin
  Result := Value or (Int64(1) shl (Bit mod BitsPerInt64));
end;

//--------------------------------------------------------------------------------------------------

procedure ppJclSetBitBuffer(var Value; const Bit: TBitRange);
var
  P: PByte;
  BitOfs: TBitRange;
begin
  P := Addr(Value);
  Inc(P, Bit div 8);
  BitOfs := Bit mod 8;
  P^ := ppJclSetBit(P^, BitOfs);
end;

//--------------------------------------------------------------------------------------------------

function ppJclTestBit(const Value: Byte; const Bit: TBitRange): Boolean;
begin
  Result := (Value and (1 shl (Bit mod BitsPerByte))) <> 0;
end;

//--------------------------------------------------------------------------------------------------

function ppJclTestBit(const Value: Shortint; const Bit: TBitRange): Boolean;
begin
  Result := (Value and (1 shl (Bit mod BitsPerShortint))) <> 0;
end;

//--------------------------------------------------------------------------------------------------

function ppJclTestBit(const Value: Smallint; const Bit: TBitRange): Boolean;
begin
  Result := (Value and (1 shl (Bit mod BitsPerSmallint))) <> 0;
end;

//--------------------------------------------------------------------------------------------------

function ppJclTestBit(const Value: Word; const Bit: TBitRange): Boolean;
begin
  Result := (Value and (1 shl (Bit mod BitsPerWord))) <> 0;
end;

//--------------------------------------------------------------------------------------------------

function ppJclTestBit(const Value: Cardinal; const Bit: TBitRange): Boolean;
begin
  Result := (Value and (1 shl (Bit mod BitsPerCardinal))) <> 0;
end;

//--------------------------------------------------------------------------------------------------

function ppJclTestBit(const Value: Integer; const Bit: TBitRange): Boolean;
begin
  Result := (Value and (1 shl (Bit mod BitsPerInteger))) <> 0;
end;

//--------------------------------------------------------------------------------------------------

function ppJclTestBit(const Value: Int64; const Bit: TBitRange): Boolean;
begin
  Result := (Value and (Int64(1) shl (Bit mod BitsPerInt64))) <> 0;
end;

//--------------------------------------------------------------------------------------------------

function ppJclTestBitBuffer(const Value; const Bit: TBitRange): Boolean;
var
  P: PByte;
  BitOfs: TBitRange;
begin
  P := Addr(Value);
  Inc(P, Bit div 8);
  BitOfs := Bit mod 8;
  Result := ppJclTestBit(P^, BitOfs);
end;


end.
