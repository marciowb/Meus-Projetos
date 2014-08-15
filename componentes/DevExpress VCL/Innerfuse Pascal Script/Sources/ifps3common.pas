{
  This unit contains constants used by the compiler and executer.
}
{$I ifps3_def.inc}
unit ifps3common;

interface

const
  {The name of the main proc }
  IFPSMainProcName = '!MAIN';
{ The lowest supported build by the executer. }
  IFPSLowBuildSupport = 12;
{ The current build of the compiler and executer. }
  IFPSCurrentBuildNo = 19;
{ The current version of the script engine }
  IFPSCurrentversion = '1.03';
{ The header of a compiled IFPS3 binary must start with this }
  IFPSValidHeader = 1397769801;
{ Start of the positive stack }
  IFPSAddrStackStart = 1610612736;
{ Start of the negative stack }
  IFPSAddrNegativeStackStart = 1073741824;
type
{ TIFPSBaseType is the most basic type -type }
  TIFPSBaseType = Byte;
{ 
@link(OnUseVariable)
  TIFPSVariableType is used in TIFPSComp.OnUseVariable event }
  TIFPSVariableType = (ivtGlobal, ivtParam, ivtVariable);

const
{ Executer internal type for return addresses, can not be used as a type }
  btReturnAddress = 0;
{ A 1 byte unsigned integer (byte) }
  btU8 = 1;
{ A 1 byte signed integer (Shortint) }
  btS8 = 2;
{ A 2 byte unsigned integer (word) }
  btU16 = 3;
{ A 2 byte signed integer (smallint) }
  btS16 = 4;
{ A 4 byte unsigned integer (cardinal/longword) }
  btU32 = 5;
{ A 4 byte signed integer (Integer/Longint) }
  btS32 = 6;
{ A 4 byte float (single) }
  btSingle = 7;
{ A 8 byte float (double) }
  btDouble = 8;
{ A 10 byte float (extended) }
  btExtended = 9;
{ A string }
  btString = 10;
{ A record }
  btRecord = 11;
{ An array}
  btArray = 12;
{ A pointer }
  btPointer = 13;
{ A PChar (internally the same as a string) }
  btPChar = 14;
{ A resource pointer: Variable that can contain things from outside the script engine }
  btResourcePointer = 15;
{ A variant }
  btVariant = 16;
{$IFNDEF NOINT64}
{ An 8 byte signed integer (int64) }
  btS64 = 17;
{$ENDIF}
  btChar = 18;
{$IFNDEF NOWIDESTRING}
  btWideString = 19;
  btWideChar = 20;
{$ENDIF}
{ Compile time procedural pointer (will be btu32 when compiled) }
  btProcPtr = 21;
{ Compile time class type; In IFPS3 external classes are not of one defined type (They could be anything from an integer to a pointer) }
  btClass = 128;
{ Compile time enumeration; This will be a btu32 when compiled }
  btEnum = 129;


{ Make a hash of a string }
function MakeHash(const s: string): Longint;

const
{ Script internal command: Assign command }
  CM_A = 0;
{ Script internal command: Calculate Command }
  CM_CA = 1;
{ Script internal command: Push}
  CM_P = 2;
{ Script internal command: Push Var}
  CM_PV = 3;
{ Script internal command: Pop}
  CM_PO = 4;
{ Script internal command: Call}
  Cm_C = 5;
{ Script internal command: Goto}
  Cm_G = 6;
{ Script internal command: Conditional Goto}
  Cm_CG = 7;
{ Script internal command: Conditional NOT Goto}
  Cm_CNG = 8;
{ Script internal command: Ret}
  Cm_R = 9;
{ Script internal command: Set Stack Type}
  Cm_ST = 10;
{ Script internal command: Push Type}
  Cm_Pt = 11;
{ Script internal command: Compare}
  CM_CO = 12;
{ Script internal command: Call Var}
  Cm_cv = 13;
{ Script internal command: Set Pointer}
  cm_sp = 14;
{ Script internal command: Boolean NOT}
  cm_bn = 15;
{ Script internal command: Var Minus}
  cm_vm = 16;
{ Script internal command: Set Flag}
  cm_sf = 17;
{ Script internal command: Flag Goto}
  cm_fg = 18;
{ Script internal command: Push Exception Handler}
  cm_puexh = 19;
{ Script internal command: Pop Exception Handler}
  cm_poexh = 20;
{ Script internal command: Integer NOT}
  cm_in = 21;


type
{Byte}
  TbtU8 = Byte;
{Shortint}
  TbtS8 = ShortInt;
{word}
  TbtU16 = Word;
{Smallint}
  TbtS16 = SmallInt;
{Cardinal/Longword}
  TbtU32 = Cardinal;
{Integer/Longint}
  TbtS32 = Longint;
{Single}
  TbtSingle = Single;
{Double}
  TbtDouble = double;
{Extended}
  TbtExtended = Extended;
{String/Pchar}
  TbtString = string;
{$IFNDEF NOINT64}
{ An 8 byte signed integer (int64) }
  tbts64 = int64;
{$ENDIF}
  tbtchar = char;
{$IFNDEF NOWIDESTRING}
  tbtwidestring = widestring;
  tbtwidechar = widechar;
{$ENDIF}

implementation

function MakeHash(const s: string): Longint;
{small hash maker}
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(s) do
    Result := ((Result shl 7) or (Result shr 25)) + Ord(s[I]);
end;

end.
