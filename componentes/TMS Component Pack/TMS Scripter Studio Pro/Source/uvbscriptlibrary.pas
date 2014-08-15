{***************************************************************************}
{ Scripter Studio Components for Delphi & C++Builder                        }
{ version 4.7 (Std), 1.7 (Pro)                                              }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit uVBScriptLibrary;

{$I ASCRIPT.INC}

interface
uses
  SysUtils, Classes, TypInfo, atScript
  {$IFDEF DELPHI6_LVL}
  , Variants
  {$ENDIF}
  ;

type
  TatVBScriptLibrary = class(TatScripterLibrary)
  private
    procedure __Asc(AMachine: TatVirtualMachine);
    procedure __Atn(AMachine: TatVirtualMachine);
    procedure __CBool(AMachine: TatVirtualMachine);
    procedure __CByte(AMachine: TatVirtualMachine);
    procedure __CCur(AMachine: TatVirtualMachine);
    procedure __CDate(AMachine: TatVirtualMachine);
    procedure __CDbl(AMachine: TatVirtualMachine);
    procedure __CInt(AMachine: TatVirtualMachine);
    procedure __CreateObject(AMachine: TatVirtualMachine);
    procedure __CSng(AMachine: TatVirtualMachine);
    procedure __CStr(AMachine: TatVirtualMachine);
    procedure __DateValue(AMachine: TatVirtualMachine);
    procedure __Day(AMachine: TatVirtualMachine);
    procedure __Hex(AMachine: TatVirtualMachine);
    procedure __Hour(AMachine: TatVirtualMachine);
    procedure __InStr(AMachine: TatVirtualMachine);
    procedure __Fix(AMachine: TatVirtualMachine);
    procedure __Int(AMachine: TatVirtualMachine);
    procedure __IsArray(AMachine: TatVirtualMachine);
    procedure __IsDate(AMachine: TatVirtualMachine);
    procedure __IsEmpty(AMachine: TatVirtualMachine);
    procedure __IsNull(AMachine: TatVirtualMachine);
    procedure __IsNumeric(AMachine: TatVirtualMachine);
    procedure __LBound(AMachine: TatVirtualMachine);
    procedure __LCase(AMachine: TatVirtualMachine);
    procedure __UBound(AMachine: TatVirtualMachine);
    procedure __UCase(AMachine: TatVirtualMachine);
    procedure __Left(AMachine: TatVirtualMachine);
    procedure __Len(AMachine: TatVirtualMachine);
    procedure __Log(AMachine: TatVirtualMachine);
    procedure __LTrim(AMachine: TatVirtualMachine);
    procedure __RTrim(AMachine: TatVirtualMachine);
    procedure __Mid(AMachine: TatVirtualMachine);
    procedure __Minute(AMachine: TatVirtualMachine);
    procedure __Month(AMachine: TatVirtualMachine);
    procedure __MonthName(AMachine: TatVirtualMachine);
    procedure __Replace(AMachine: TatVirtualMachine);
    procedure __Right(AMachine: TatVirtualMachine);
    procedure __Rnd(AMachine: TatVirtualMachine);
    procedure __Second(AMachine: TatVirtualMachine);
    procedure __Sgn(AMachine: TatVirtualMachine);
    procedure __Space(AMachine: TatVirtualMachine);
    procedure __StrComp(AMachine: TatVirtualMachine);
    procedure __String(AMachine: TatVirtualMachine);
    procedure __Timer(AMachine: TatVirtualMachine);
    procedure __TimeSerial(AMachine: TatVirtualMachine);
    procedure __TimeValue(AMachine: TatVirtualMachine);
    procedure __Weekday(AMachine: TatVirtualMachine);
    procedure __WeekdayName(AMachine: TatVirtualMachine);
    procedure __Year(AMachine: TatVirtualMachine);
    procedure __DateSerial(AMachine: TatVirtualMachine);
    procedure __FormatNumber(AMachine: TatVirtualMachine);
    procedure __FormatCurrency(AMachine: TatVirtualMachine);
    procedure __FormatDateTime(AMachine: TatVirtualMachine);
    procedure __MsgBox(AMachine: TatVirtualMachine);
    procedure __InputBox(AMachine: TatVirtualMachine);
    procedure __DatePart(AMachine: TatVirtualMachine);
    procedure __Redim(AMachine: TatVirtualMachine);
    procedure __RedimPreserve(AMachine: TatVirtualMachine);
    procedure __Split(AMachine: TatVirtualMachine);
    procedure __Join(AMachine: TatVirtualMachine);
    procedure __StrReverse(AMachine: TatVirtualMachine);
    procedure __Randomize(AMachine: TatVirtualMachine);
  protected
    procedure Init; override;
  public
    class function LibraryName: string; override;
  end;

implementation
uses
  Windows, Forms, Math, 
  {$IFNDEF LINUX}
  Dialogs, ComObj;
  {$ELSE}
  QDialogs;
  {$ENDIF}

{TatVBScriptLibrary}

const
  {FormatDateTime constants}
  vbGeneralDate = 0;
  vbLongDate = 1;
  vbShortDate = 2;
  vbLongTime = 3;
  vbShortTime = 4;

  {MsgBox constants}
  {MsgBox buttons}
  vbOKOnly = 0;
  vbOKCancel = 1;
  vbAbortRetryIgnore = 2;
  vbYesNoCancel = 3;
  vbYesNo = 4;
  vbRetryCancel = 5;
  vbCritical = 16;
  vbQuestion = 32;
  vbExclamation = 48;
  vbInformation = 64;
  vbDefaultButton1 = 0;
  vbDefaultButton2 = 256;
  vbDefaultButton3 = 512;
  vbDefaultButton4 = 768;
  vbApplicationModal = 0;
  vbSystemModal = 4096;

  {MsgBox return values}
  vbOK = 1;
  vbCancel = 2;
  vbAbort = 3;
  vbRetry = 4;
  vbIgnore = 5;
  vbYes = 6;
  vbNo = 7;

  {Split compare values}
  vbBinaryCompare = 0;
  vbTextCompare = 1;

class function TatVBScriptLibrary.LibraryName: string;
begin
  result := 'VBScript';
end;

procedure TatVBScriptLibrary.Init;
begin
  with Scripter.DefineClass(ClassType) do
  begin
     { methods }
     DefineMethod('Asc', 1, tkInteger, nil, __Asc);
     DefineMethod('Atn', 1, tkFloat, nil, __Atn);
     DefineMethod('CBool', 1, tkEnumeration, nil, __CBool);
     DefineMethod('CByte', 1, tkInteger, nil, __CByte);
     DefineMethod('CCur', 1, tkFloat, nil, __CCur);
     DefineMethod('CDate', 1, tkFloat, nil, __CDate);
     DefineMethod('CDbl', 1, tkFloat, nil, __CDbl);
     DefineMethod('CInt', 1, tkInteger, nil, __CInt);
     DefineMethod('CLng', 1, tkInteger, nil, __CInt); //<-- Uses same as CInt
     DefineMethod('CreateObject', 1, tkVariant, nil, __CreateObject);
     DefineMethod('CSng', 1, tkFloat, nil, __CSng);
     DefineMethod('CStr', 1, tkString, nil, __CStr);
     DefineMethod('DatePart', 2, tkInteger, nil, __DatePart);
     DefineMethod('DateSerial', 3, tkFloat, nil, __DateSerial);
     DefineMethod('DateValue', 1, tkFloat, nil, __DateValue);
     DefineMethod('Day', 1, tkInteger, nil, __Day);
     DefineMethod('Hex', 1, tkString, nil, __Hex);
     DefineMethod('Hour', 1, tkInteger, nil, __Hour);
     DefineMethod('InStr', 2, tkInteger, nil, __InStr);
     DefineMethod('Int', 1, tkInteger, nil, __Int);
     DefineMethod('Fix', 1, tkInteger, nil, __Fix);
     DefineMethod('FormatCurrency', 2, tkString, nil, __FormatCurrency);
     DefineMethod('FormatDateTime', 2, tkString, nil, __FormatDateTime);
     DefineMethod('FormatNumber', 2, tkString, nil, __FormatNumber);
     DefineMethod('InputBox', 3, tkInteger, nil, __InputBox);
     DefineMethod('IsArray', 1, tkEnumeration, nil, __IsArray);
     DefineMethod('IsDate', 1, tkEnumeration, nil, __IsDate);
     DefineMethod('IsEmpty', 1, tkEnumeration, nil, __IsEmpty);
     DefineMethod('IsNull', 1, tkEnumeration, nil, __IsNull);
     DefineMethod('IsNumeric', 1, tkEnumeration, nil, __IsNumeric);
     DefineMethod('LBound', 2, tkInteger, nil, __LBound, false, 1);
     DefineMethod('LCase', 1, tkString, nil, __LCase);
     DefineMethod('Left', 2, tkString, nil, __Left);
     DefineMethod('Len', 1, tkInteger, nil, __Len);
     DefineMethod('Log', 1, tkFloat, nil, __Log);
     DefineMethod('LTrim', 1, tkString,  nil, __LTrim);
     DefineMethod('RTrim', 1, tkString,  nil, __RTrim);
     DefineMethod('UBound', 2, tkInteger, nil, __UBound, false, 1);
     DefineMethod('UCase', 1, tkString, nil, __UCase);
     DefineMethod('Mid', 3, tkString,  nil, __Mid);
     DefineMethod('Minute', 1, tkInteger, nil, __Minute);
     DefineMethod('Month', 1, tkInteger, nil, __Month);
     DefineMethod('MonthName', 2, tkString, nil, __MonthName);
     DefineMethod('MsgBox', 3, tkInteger, nil, __MsgBox, false, 2);
     DefineMethod('Replace', 3, tkString, nil, __Replace);
     DefineMethod('Right', 2, tkString, nil, __Right);
     DefineMethod('Rnd', 0, tkFloat, nil, __Rnd);
     DefineMethod('Second', 1, tkInteger, nil, __Second);
     DefineMethod('Sgn', 1, tkInteger, nil, __Sgn);
     DefineMethod('Space', 1, tkString, nil, __Space);
     DefineMethod('StrComp', 2, tkInteger, nil, __StrComp);
     DefineMethod('String', 2, tkString, nil, __String);
     DefineMethod('Timer', 0, tkInteger, nil, __Timer);
     DefineMethod('TimeSerial', 3, tkFloat, nil, __TimeSerial);
     DefineMethod('TimeValue', 1, tkFloat, nil, __TimeValue);
     DefineMethod('Weekday', 1, tkInteger, nil, __Weekday);
     DefineMethod('WeekdayName', 2, tkString, nil, __WeekdayName);
     DefineMethod('Year', 1, tkInteger, nil, __Year);
     DefineMethod('Redim', 10, tkVariant, nil, __Redim, false, 9);
     DefineMethod('RedimPreserve', 2, tkVariant, nil, __RedimPreserve).SetVarArgs([0]);
     DefineMethod('Split', 4, tkVariant, nil, __Split, false, 3);
     DefineMethod('Join', 2, tkString, nil, __Join, false, 1);
     DefineMethod('StrReverse', 1, tkString, nil, __StrReverse);
     DefineMethod('Randomize', 0, tkNone, nil, __Randomize);

     {Constants}
     {FormatDateTime constants}
     AddConstant('vbGeneralDate', vbGeneralDate);
     AddConstant('vbLongDate', vbLongDate);
     AddConstant('vbShortDate', vbShortDate);
     AddConstant('vbLongTime', vbLongTime);
     AddConstant('vbShortTime', vbShortTime);

     {MsgBox Constants}
     {MsgBox buttons}
     AddConstant('vbOKOnly', vbOKOnly);
     AddConstant('vbOKCancel', vbOKCancel);
     AddConstant('vbAbortRetryIgnore', vbAbortRetryIgnore);
     AddConstant('vbYesNoCancel', vbYesNoCancel);
     AddConstant('vbYesNo', vbYesNo);
     AddConstant('vbRetryCancel', vbRetryCancel);
     AddConstant('vbCritical', vbCritical);
     AddConstant('vbQuestion', vbQuestion);
     AddConstant('vbExclamation',vbExclamation);
     AddConstant('vbInformation', vbInformation);
     AddConstant('vbDefaultButton1', vbDefaultButton1);
     AddConstant('vbDefaultButton2', vbDefaultButton2);
     AddConstant('vbDefaultButton3', vbDefaultButton3);
     AddConstant('vbDefaultButton4', vbDefaultButton4);
     AddConstant('vbApplicationModal', vbApplicationModal);
     AddConstant('vbSystemModal', vbSystemModal);

     {MsgBox return values}
     AddConstant('vbOK', vbOK);
     AddConstant('vbCancel', vbCancel);
     AddConstant('vbAbort', vbAbort);
     AddConstant('vbRetry', vbRetry);
     AddConstant('vbIgnore', vbIgnore);
     AddConstant('vbYes', vbYes);
     AddConstant('vbNo', vbNo);

     {Split compare values}
     AddConstant('vbBinaryCompare', vbBinaryCompare);
     AddConstant('vbTextCompare', vbTextCompare);
  end;
end;

procedure TatVBScriptLibrary.__Asc(AMachine: TatVirtualMachine);
var
  S: string;
begin
  with AMachine do
  begin
    S := GetInputArgAsString(0);
    if Length(S) > 0 then
      ReturnOutputArg(Ord(S[1]))
    else
      RaiseRuntimeError('Empty string when calling Asc function');
  end;
end;

procedure TatVBScriptLibrary.__Atn(AMachine: TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(ArcTan(GetInputArgAsFloat(0)));
end;

procedure TatVBScriptLibrary.__CBool(AMachine: TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(VarToBoolean(GetInputArg(0)));
end;

procedure TatVBScriptLibrary.__CByte(AMachine: TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(Byte(GetInputArgAsInteger(0)));
end;

procedure TatVBScriptLibrary.__CCur(AMachine: TatVirtualMachine);
var
  R: Currency;
begin
  with AMachine do
  begin
    R := GetInputArgAsFloat(0);
    ReturnOutputArg(R);
  end;
end;

procedure TatVBScriptLibrary.__CDate(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(VarToDateTime(GetInputArg(0)));
end;

procedure TatVBScriptLibrary.__CDbl(AMachine:TatVirtualMachine);
var
  D: double;
begin
  with AMachine do
  begin
    D := VarToFloat(GetInputArg(0));
    ReturnOutputArg(D);
  end;
end;

procedure TatVBScriptLibrary.__CInt(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(GetInputArgAsInteger(0));
end;

procedure TatVBScriptLibrary.__CreateObject(AMachine:TatVirtualMachine);
begin
  {$IFNDEF LINUX}
  with AMachine do
    ReturnOutputArg(CreateOleObject(GetInputArgAsString(0)));
  {$ENDIF}
end;

procedure TatVBScriptLibrary.__CSng(AMachine:TatVirtualMachine);
var
  D: single;
begin
  with AMachine do
  begin
    D := VarToFloat(GetInputArg(0));
    ReturnOutputArg(D);
  end;
end;

procedure TatVBScriptLibrary.__CStr(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(GetInputArgAsString(0));
end;

procedure TatVBScriptLibrary.__DatePart(AMachine:TatVirtualMachine);
var
  DD: TDateTime;
  I: string;
  D, M, Y, H, Min, S, MS: word;
  Res: integer;
begin
  with AMachine do
  begin
    DD := GetInputArgAsDateTime(1);
    I := LowerCase(GetInputArgAsString(0));
    DecodeDate(DD, Y, M, D);
    DecodeTime(DD, H, Min, S, MS);
    if I = 'yyyy' then
      Res := Y
    else
    if I = 'm' then
      Res := M
    else
    if I = 'd' then
      Res := D
    else
    if I = 'h' then
      Res := H
    else
    if I = 'n' then
      Res := Min
    else
    if I = 's' then
      Res := S
    else
    if I = 'w' then
      Res := DayOfWeek(DD)
    else
    if I = 'q' then
      Res := ((M - 1) div 3) + 1
    else
      Res := 0;
    ReturnOutputArg(Res);
  end;
end;

procedure TatVBScriptLibrary.__DateSerial(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(EncodeDate(GetInputArgAsInteger(0),
      GetInputArgAsInteger(1), GetInputArgAsInteger(2)));
end;

procedure TatVBScriptLibrary.__DateValue(AMachine:TatVirtualMachine);
var
  D, M, Y: word;
begin
  with AMachine do
  begin
    DecodeDate(VarToDateTime(GetInputArg(0)), Y, M, D);
    ReturnOutputArg(EncodeDate(Y, M, D));
  end;
end;

procedure TatVBScriptLibrary.__Day(AMachine:TatVirtualMachine);
var
  D, M, Y: word;
begin
  with AMachine do
  begin
    DecodeDate(VarToDateTime(GetInputArg(0)), Y, M, D);
    ReturnOutputArg(D);
  end;
end;

procedure TatVBScriptLibrary.__Hex(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(IntToHex(GetInputArgAsInteger(0), 0));
end;

procedure TatVBScriptLibrary.__Hour(AMachine:TatVirtualMachine);
var
  H, M, S, MS: word;
begin
  with AMachine do
  begin
    DecodeTime(VarToDateTime(GetInputArg(0)), H, M, S, MS);
    ReturnOutputArg(H);
  end;
end;

procedure TatVBScriptLibrary.__InStr(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(pos(GetInputArgAsString(1), GetInputArgAsString(0)));
end;

procedure TatVBScriptLibrary.__Int(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(Floor(GetInputArgAsFloat(0)));
end;

procedure TatVBScriptLibrary.__Fix(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(Int(GetInputArgAsFloat(0)));
end;

procedure TatVBScriptLibrary.__FormatCurrency(AMachine:TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(CurrToStrF(GetInputArgAsFloat(0), ffCurrency, GetInputArgAsInteger(1)));
  end;
end;

procedure TatVBScriptLibrary.__FormatDateTime(AMachine:TatVirtualMachine);
var
  AFormat: string;
begin
  with AMachine do
  begin
    Case GetInputArgAsInteger(1) of
      vbLongDate: AFormat := 'dddddd';
      vbShortDate: AFormat := 'ddddd';
      vbLongTime: AFormat := 'tt';
      vbShortTime: AFormat := 't';
    else
      {vbGeneralDate}
      AFormat := 'c';
    end;
    ReturnOutputArg(FormatDateTime(AFormat, GetInputArgAsDateTime(0)));
  end;
end;

procedure TatVBScriptLibrary.__FormatNumber(AMachine:TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(FloatToStrF(GetInputArgAsFloat(0), ffFixed, 15, GetInputArgAsInteger(1)));
  end;
end;

procedure TatVBScriptLibrary.__InputBox(AMachine:TatVirtualMachine);
var
  V: string;
begin
  with AMachine do
  begin
    V := GetInputArgAsString(2);
    if InputQuery(GetInputArgAsString(1), GetInputArgAsString(0), V) then
      ReturnOutputArg(V)
    else
      ReturnOutputArg('');
  end;
end;

procedure TatVBScriptLibrary.__IsArray(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(VarIsArray(GetInputArg(0)));
end;

procedure TatVBScriptLibrary.__IsDate(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(VarType(GetInputArg(0)) = varDate);
end;

procedure TatVBScriptLibrary.__IsEmpty(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(VarIsEmpty(GetInputArg(0)));
end;

procedure TatVBScriptLibrary.__IsNull(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(VarIsNull(GetInputArg(0)));
end;

{$HINTS OFF}
procedure TatVBScriptLibrary.__IsNumeric(AMachine:TatVirtualMachine);
var
  e: integer;
  V: double;
begin
  with AMachine do
  begin
    Val(GetInputArgAsString(0), V, e);
    ReturnOutputArg(e = 0);
  end;
end;
{$HINTS ON}

procedure TatVBScriptLibrary.__LBound(AMachine:TatVirtualMachine);
begin
  with AMachine do
    if InputArgCount = 1 then
      ReturnOutPutArg(VarArrayLowBound(GetInputArg(0), 1))
    else
      ReturnOutPutArg(VarArrayLowBound(GetInputArg(0), GetInputArgAsInteger(1)))
end;

procedure TatVBScriptLibrary.__LCase(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutPutArg(LowerCase(GetInputArgAsString(0)));
end;

procedure TatVBScriptLibrary.__Left(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutPutArg(Copy(GetInputArgAsString(0), 1, GetInputArgAsInteger(1)));
end;

procedure TatVBScriptLibrary.__Len(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutPutArg(Length(GetInputArgAsString(0)));
end;

procedure TatVBScriptLibrary.__Log(AMachine: TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(Ln(GetInputArgAsFloat(0)));
end;

procedure TatVBScriptLibrary.__LTrim(AMachine:TatVirtualMachine);
begin
   with AMachine do
      ReturnOutputArg( TrimLeft( GetInputArgAsString( 0 ) ) );
end;

procedure TatVBScriptLibrary.__RTrim(AMachine:TatVirtualMachine);
begin
   with AMachine do
      ReturnOutputArg( TrimRight( GetInputArgAsString( 0 ) ) );
end;

procedure TatVBScriptLibrary.__UBound(AMachine:TatVirtualMachine);
begin
  with AMachine do
    if InputArgCount = 1 then
      ReturnOutPutArg(VarArrayHighBound(GetInputArg(0), 1))
    else
      ReturnOutPutArg(VarArrayHighBound(GetInputArg(0), GetInputArgAsInteger(1)));
end;

procedure TatVBScriptLibrary.__UCase(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutPutArg(UpperCase(GetInputArgAsString(0)));
end;

procedure TatVBScriptLibrary.__Mid(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutPutArg(Copy(GetInputArgAsString(0), GetInputArgAsInteger(1), GetInputArgAsInteger(2)));
end;

procedure TatVBScriptLibrary.__Minute(AMachine:TatVirtualMachine);
var
  H, M, S, MS: word;
begin
  with AMachine do
  begin
    DecodeTime(VarToDateTime(GetInputArg(0)), H, M, S, MS);
    ReturnOutputArg(M);
  end;
end;

procedure TatVBScriptLibrary.__Month(AMachine:TatVirtualMachine);
var
  D, M, Y: word;
begin
  with AMachine do
  begin
    DecodeDate(VarToDateTime(GetInputArg(0)), Y, M, D);
    ReturnOutputArg(M);
  end;
end;

procedure TatVBScriptLibrary.__MonthName(AMachine:TatVirtualMachine);
var
  D: TDateTime;
begin
  with AMachine do
  begin
    D := EncodeDate(1900, GetInputArgAsInteger(0), 1);
    if GetInputArgAsBoolean(1) then
      ReturnOutputArg(FormatDateTime('mmm', D))
    else
      ReturnOutputArg(FormatDateTime('mmmm', D));
  end;
end;

procedure TatVBScriptLibrary.__MsgBox(AMachine:TatVirtualMachine);
begin
  with AMachine do
  begin
    case InputArgCount of
      1:  ReturnOutputArg(Windows.MessageBox(Application.Handle, PChar(GetInputArgAsString(0)),
            PChar(Application.Title), vbOKOnly));
      2:  ReturnOutputArg(Windows.MessageBox(Application.Handle, PChar(GetInputArgAsString(0)),
            PChar(Application.Title), GetInputArgAsInteger(1)));
      3:  ReturnOutputArg(Windows.MessageBox(Application.Handle, PChar(GetInputArgAsString(0)),
            PChar(GetInputArgAsString(2)), GetInputArgAsInteger(1)));
    end;
  end;
end;

procedure TatVBScriptLibrary.__Replace(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(StringReplace(GetInputArgAsString(0),
      GetInputArgAsString(1),GetInputArgAsString(2), [rfReplaceAll]));
end;

procedure TatVBScriptLibrary.__Right(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutPutArg(Copy(GetInputArgAsString(0),
      Length(GetInputArgAsString(0)) - GetInputArgAsInteger(1) + 1, MaxInt));
end;

procedure TatVBScriptLibrary.__Rnd(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutPutArg(Random);
end;

procedure TatVBScriptLibrary.__Second(AMachine:TatVirtualMachine);
var
  H, M, S, MS: word;
begin
  with AMachine do
  begin
    DecodeTime(VarToDateTime(GetInputArg(0)), H, M, S, MS);
    ReturnOutputArg(S);
  end;
end;

procedure TatVBScriptLibrary.__Sgn(AMachine:TatVirtualMachine);
var
  D: double;
begin
  with AMachine do
  begin
    D := GetInputArgAsFloat(0);
    if D > 0 then
      ReturnOutputArg(1)
    else
    if D < 0 then
      ReturnOutputArg(-1)
    else
      ReturnOutputArg(0);
  end;
end;

procedure TatVBScriptLibrary.__Space(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutPutArg(StringOfChar(' ', GetInputArgAsInteger(0)));
end;

procedure TatVBScriptLibrary.__StrComp(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(CompareStr(GetInputArgAsString(0), GetInputArgAsString(1)));
end;

procedure TatVBScriptLibrary.__String(AMachine:TatVirtualMachine);
var
  Ch: char;
  S: string;
begin
  with AMachine do
  begin
    S := GetInputArgAsString(1);
    if Length(S) > 0 then
      Ch := S[1]
    else
      Ch := ' ';
    ReturnOutPutArg(StringOfChar(Ch, GetInputArgAsInteger(0)));
  end;
end;

procedure TatVBScriptLibrary.__Timer(AMachine:TatVirtualMachine);
var
  H, M, S, MS: word;
begin
  with AMachine do
  begin
    DecodeTime(Now, H, M, S, MS);
    ReturnOutputArg(H * 3600 + M * 60 + S + (MS / 1000));
  end;
end;

procedure TatVBScriptLibrary.__TimeSerial(AMachine:TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArg(EncodeTime(GetInputArgAsInteger(0),
      GetInputArgAsInteger(1), GetInputArgAsInteger(2), 0));
end;

procedure TatVBScriptLibrary.__TimeValue(AMachine:TatVirtualMachine);
var
  H, M, S, MS: word;
begin
  with AMachine do
  begin
    DecodeTime(VarToDateTime(GetInputArg(0)), H, M, S, MS);
    ReturnOutputArg(EncodeTime(H, M, S, MS));
  end;
end;

procedure TatVBScriptLibrary.__Weekday(AMachine:TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(DayOfWeek(GetInputArgAsDateTime(0)));
  end;
end;

procedure TatVBScriptLibrary.__WeekdayName(AMachine:TatVirtualMachine);
var
  D: TDateTime;
begin
  with AMachine do
  begin
    //The date 1/1/1899 is a sunday, so...
    D := EncodeDate(1899, 1, GetInputArgAsInteger(0));
    if GetInputArgAsBoolean(1) then
      ReturnOutputArg(FormatDateTime('ddd', D))
    else
      ReturnOutputArg(FormatDateTime('dddd', D));
  end;
end;

procedure TatVBScriptLibrary.__Year(AMachine:TatVirtualMachine);
var
  D, M, Y: word;
begin
  with AMachine do
  begin
    DecodeDate(VarToDateTime(GetInputArg(0)), Y, M, D);
    ReturnOutputArg(Y);
  end;
end;

procedure TatVBScriptLibrary.__Redim(AMachine: TatVirtualMachine);
var
  ParamCount: integer;
  Dimensions: array of integer;
begin
  with AMachine do
  begin
    SetLength(Dimensions, (InputArgCount) * 2);

    for ParamCount := 0 to InputArgCount - 1 do
    begin
      Dimensions[(ParamCount * 2)    ] :=  0;
      Dimensions[(ParamCount * 2) + 1] := GetInputArgAsInteger(ParamCount);
    end;

    ReturnOutputArg(VarArrayCreate(Dimensions, varVariant));
  end;
end;

procedure TatVBScriptLibrary.__RedimPreserve(AMachine: TatVirtualMachine);
var
  VariantArray: Variant;
begin
  with AMachine do
  begin
    VariantArray := GetInputArg(0);
    VarArrayRedim(VariantArray, GetInputArgAsInteger(1));
    SetInputArg(0, VariantArray);
  end;
end;

procedure TatVBScriptLibrary.__Split(AMachine: TatVirtualMachine);

  function CharPos(ADelimiter: Char; AExpression: string): integer;
  var
    I: integer;
  begin
    for I := 1 to Length(AExpression) do
      if AExpression[I] = ADelimiter then
      begin
        Result := I;
        Exit;
      end;

    Result := -1;
  end;

var
  I: Integer;
  Token: string;
  DelimiterCount: integer;
  TokensCount: integer;
  Expression: string;
  Delimiter: char;
  Count: integer;
  OutPut: Variant;
begin
  with AMachine do
  begin
    Expression := GetInputArgAsString(0);

    if Expression = '' then
    begin
      Output := VarArrayCreate([0, 0], varVariant);
      Output[0] := Expression;
    end
    else begin
      if InputArgCount < 2 then
        Delimiter := ' '
      else
        Delimiter := GetInputArgAsChar(1);

      if InputArgCount < 3 then
        Count := -1
      else
        Count := GetInputArgAsInteger(2);

      DelimiterCount := 0;
      for I := 1 to Length(Expression) do
        if Expression[I] = Delimiter then
          Inc(DelimiterCount);

      if DelimiterCount = 0 then
      begin
        Output := VarArrayCreate([0, 0], varVariant);
        Output[0] := Expression;
      end
      else
      begin
        if Count = -1 then
          Count := DelimiterCount + 1;

        Output := VarArrayCreate([0, Count - 1], varVariant);

        TokensCount := 0;
        I := CharPos(Delimiter, Expression);

        while (I > 0) and (TokensCount < Count) do
        begin
          Token := Copy(Expression, 1, I - 1);
          Output[TokensCount] := Token;
          Inc(TokensCount);
          Delete(Expression, 1, I);
          I := CharPos(Delimiter, Expression);
        end;

        if (Expression <> '') and (TokensCount < Count) then
          Output[TokensCount] := Expression;
      end;
    end;

    ReturnOutputArg(OutPut);
  end;
end;

procedure TatVBScriptLibrary.__Join(AMachine: TatVirtualMachine);
var
  I: Integer;
  HighBound: integer;
  ResultString: string;
  Delimiter: Char;
  VarArray: array of Variant;
begin
  with AMachine do
  begin
    VarArray := GetInputArg(0);

    if InputArgCount < 2 then
      Delimiter := ' '
    else
      Delimiter := GetInputArgAsChar(1);

    HighBound := VarArrayHighBound(VarArray, 1);
    ResultString := '';    

    for I := VarArrayLowBound(VarArray, 1) to HighBound do begin
      ResultString := ResultString + String(VarArray[I]);

      if I <> HighBound then
        ResultString := ResultString + Delimiter;
    end;

    ReturnOutputArg(ResultString);
  end;
end;

procedure TatVBScriptLibrary.__StrReverse(AMachine: TatVirtualMachine);
var
  I: Integer;
  Len: integer;
  InputString: string;
  ResultString: string;
begin
  with AMachine do
  begin
    InputString := GetInputArg(0);

    Len := Length(InputString);

    SetLength(ResultString, Len);

    for I := 1 to Len do
      ResultString[Len - I + 1] := InputString[I];

    ReturnOutputArg(ResultString);
  end;
end;

procedure TatVBScriptLibrary.__Randomize(AMachine: TatVirtualMachine);
begin
  Randomize;
end;

initialization
  RegisterScripterLibrary(TatVBScriptLibrary, True);

end.
