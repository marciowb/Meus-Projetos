{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_AnsiStrings;

interface

uses
  SysUtils,
  StrUtils,
  Windows,
  SysConst,
  AnsiStrings,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatAnsiStringsLibrary = class(TatScripterLibrary)
    procedure __UpperCase(AMachine: TatVirtualMachine);
    procedure __LowerCase(AMachine: TatVirtualMachine);
    procedure __CompareStr(AMachine: TatVirtualMachine);
    procedure __SameStr(AMachine: TatVirtualMachine);
    procedure __CompareText(AMachine: TatVirtualMachine);
    procedure __SameText(AMachine: TatVirtualMachine);
    procedure __AnsiUpperCase(AMachine: TatVirtualMachine);
    procedure __AnsiLowerCase(AMachine: TatVirtualMachine);
    procedure __AnsiCompareStr(AMachine: TatVirtualMachine);
    procedure __AnsiSameStr(AMachine: TatVirtualMachine);
    procedure __AnsiCompareText(AMachine: TatVirtualMachine);
    procedure __AnsiSameText(AMachine: TatVirtualMachine);
    procedure __AnsiLastChar(AMachine: TatVirtualMachine);
    procedure __Trim(AMachine: TatVirtualMachine);
    procedure __TrimLeft(AMachine: TatVirtualMachine);
    procedure __TrimRight(AMachine: TatVirtualMachine);
    procedure __QuotedStr(AMachine: TatVirtualMachine);
    procedure __CharLength(AMachine: TatVirtualMachine);
    procedure __NextCharIndex(AMachine: TatVirtualMachine);
    procedure __AnsiCompareFileName(AMachine: TatVirtualMachine);
    procedure __SameFileName(AMachine: TatVirtualMachine);
    procedure __AnsiLowerCaseFileName(AMachine: TatVirtualMachine);
    procedure __AnsiUpperCaseFileName(AMachine: TatVirtualMachine);
    procedure __AnsiPos(AMachine: TatVirtualMachine);
    procedure __ContainsText(AMachine: TatVirtualMachine);
    procedure __AnsiContainsText(AMachine: TatVirtualMachine);
    procedure __StartsText(AMachine: TatVirtualMachine);
    procedure __AnsiStartsText(AMachine: TatVirtualMachine);
    procedure __EndsText(AMachine: TatVirtualMachine);
    procedure __AnsiEndsText(AMachine: TatVirtualMachine);
    procedure __ReplaceText(AMachine: TatVirtualMachine);
    procedure __AnsiReplaceText(AMachine: TatVirtualMachine);
    procedure __ContainsStr(AMachine: TatVirtualMachine);
    procedure __AnsiContainsStr(AMachine: TatVirtualMachine);
    procedure __StartsStr(AMachine: TatVirtualMachine);
    procedure __AnsiStartsStr(AMachine: TatVirtualMachine);
    procedure __EndsStr(AMachine: TatVirtualMachine);
    procedure __AnsiEndsStr(AMachine: TatVirtualMachine);
    procedure __ReplaceStr(AMachine: TatVirtualMachine);
    procedure __AnsiReplaceStr(AMachine: TatVirtualMachine);
    procedure __DupeString(AMachine: TatVirtualMachine);
    procedure __ReverseString(AMachine: TatVirtualMachine);
    procedure __AnsiReverseString(AMachine: TatVirtualMachine);
    procedure __StuffString(AMachine: TatVirtualMachine);
    procedure __StringReplace(AMachine: TatVirtualMachine);
    procedure __ChangeFileExt(AMachine: TatVirtualMachine);
    procedure __ChangeFilePath(AMachine: TatVirtualMachine);
    procedure __ExtractFilePath(AMachine: TatVirtualMachine);
    procedure __ExtractFileDir(AMachine: TatVirtualMachine);
    procedure __ExtractFileDrive(AMachine: TatVirtualMachine);
    procedure __ExtractFileName(AMachine: TatVirtualMachine);
    procedure __ExtractFileExt(AMachine: TatVirtualMachine);
    procedure __ExpandFileName(AMachine: TatVirtualMachine);
    procedure __ExpandFileNameCase(AMachine: TatVirtualMachine);
    procedure __ExpandUNCFileName(AMachine: TatVirtualMachine);
    procedure __ExtractRelativePath(AMachine: TatVirtualMachine);
    procedure __ExtractShortPathName(AMachine: TatVirtualMachine);
    procedure __LastDelimiter(AMachine: TatVirtualMachine);
    procedure __IsPathDelimiter(AMachine: TatVirtualMachine);
    procedure __IsDelimiter(AMachine: TatVirtualMachine);
    procedure __IncludeTrailingPathDelimiter(AMachine: TatVirtualMachine);
    procedure __IncludeTrailingBackslash(AMachine: TatVirtualMachine);
    procedure __ExcludeTrailingPathDelimiter(AMachine: TatVirtualMachine);
    procedure __ExcludeTrailingBackslash(AMachine: TatVirtualMachine);
    procedure __PosEx(AMachine: TatVirtualMachine);
    procedure __AnsiLeftStr(AMachine: TatVirtualMachine);
    procedure __AnsiRightStr(AMachine: TatVirtualMachine);
    procedure __AnsiMidStr(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatAnsiStringsLibrary.__UpperCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.UpperCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__LowerCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.LowerCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__CompareStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.CompareStr(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__SameStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.SameStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__CompareText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.CompareText(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__SameText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.SameText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiUpperCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiUpperCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiLowerCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiLowerCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiCompareStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.AnsiCompareStr(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiSameStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiSameStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiCompareText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.AnsiCompareText(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiSameText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiSameText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiLastChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(AnsiStrings.AnsiLastChar(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__Trim(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.Trim(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__TrimLeft(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.TrimLeft(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__TrimRight(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.TrimRight(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__QuotedStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.QuotedStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__CharLength(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.CharLength(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__NextCharIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.NextCharIndex(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiCompareFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.AnsiCompareFileName(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__SameFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.SameFileName(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiLowerCaseFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiLowerCaseFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiUpperCaseFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiUpperCaseFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.AnsiPos(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ContainsText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ContainsText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiContainsText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiContainsText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__StartsText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.StartsText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiStartsText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiStartsText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__EndsText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.EndsText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiEndsText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiEndsText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ReplaceText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ReplaceText(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiReplaceText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiReplaceText(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ContainsStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ContainsStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiContainsStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiContainsStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__StartsStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.StartsStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiStartsStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiStartsStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__EndsStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.EndsStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiEndsStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiEndsStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ReplaceStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ReplaceStr(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiReplaceStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiReplaceStr(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__DupeString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.DupeString(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ReverseString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ReverseString(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiReverseString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiReverseString(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__StuffString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.StuffString(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__StringReplace(AMachine: TatVirtualMachine);
  var
  Param3: TReplaceFlags;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
AResult := AnsiStrings.StringReplace(GetInputArg(0),GetInputArg(1),GetInputArg(2),Param3);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ChangeFileExt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ChangeFileExt(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ChangeFilePath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ChangeFilePath(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExtractFilePath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExtractFilePath(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExtractFileDir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExtractFileDir(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExtractFileDrive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExtractFileDrive(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExtractFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExtractFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExtractFileExt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExtractFileExt(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExpandFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExpandFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExpandFileNameCase(AMachine: TatVirtualMachine);
  var
  Param1: TFilenameCaseMatch;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := AnsiStrings.ExpandFileNameCase(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatAnsiStringsLibrary.__ExpandUNCFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExpandUNCFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExtractRelativePath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExtractRelativePath(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExtractShortPathName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExtractShortPathName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__LastDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(AnsiStrings.LastDelimiter(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__IsPathDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.IsPathDelimiter(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__IsDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.IsDelimiter(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__IncludeTrailingPathDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.IncludeTrailingPathDelimiter(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__IncludeTrailingBackslash(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.IncludeTrailingBackslash(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExcludeTrailingPathDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExcludeTrailingPathDelimiter(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__ExcludeTrailingBackslash(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.ExcludeTrailingBackslash(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__PosEx(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := Integer(AnsiStrings.PosEx(GetInputArg(0),GetInputArg(1)));
3: AResult := Integer(AnsiStrings.PosEx(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiLeftStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiLeftStr(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiRightStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiRightStr(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.__AnsiMidStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := AnsiStrings.AnsiMidStr(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatAnsiStringsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('UpperCase',1,tkVariant,nil,__UpperCase,false,0);
    DefineMethod('LowerCase',1,tkVariant,nil,__LowerCase,false,0);
    DefineMethod('CompareStr',2,tkInteger,nil,__CompareStr,false,0);
    DefineMethod('SameStr',2,tkVariant,nil,__SameStr,false,0);
    DefineMethod('CompareText',2,tkInteger,nil,__CompareText,false,0);
    DefineMethod('SameText',2,tkVariant,nil,__SameText,false,0);
    DefineMethod('AnsiUpperCase',1,tkVariant,nil,__AnsiUpperCase,false,0);
    DefineMethod('AnsiLowerCase',1,tkVariant,nil,__AnsiLowerCase,false,0);
    DefineMethod('AnsiCompareStr',2,tkInteger,nil,__AnsiCompareStr,false,0);
    DefineMethod('AnsiSameStr',2,tkVariant,nil,__AnsiSameStr,false,0);
    DefineMethod('AnsiCompareText',2,tkInteger,nil,__AnsiCompareText,false,0);
    DefineMethod('AnsiSameText',2,tkVariant,nil,__AnsiSameText,false,0);
    DefineMethod('AnsiLastChar',1,tkVariant,nil,__AnsiLastChar,false,0);
    DefineMethod('Trim',1,tkVariant,nil,__Trim,false,0);
    DefineMethod('TrimLeft',1,tkVariant,nil,__TrimLeft,false,0);
    DefineMethod('TrimRight',1,tkVariant,nil,__TrimRight,false,0);
    DefineMethod('QuotedStr',1,tkVariant,nil,__QuotedStr,false,0);
    DefineMethod('CharLength',2,tkInteger,nil,__CharLength,false,0);
    DefineMethod('NextCharIndex',2,tkInteger,nil,__NextCharIndex,false,0);
    DefineMethod('AnsiCompareFileName',2,tkInteger,nil,__AnsiCompareFileName,false,0);
    DefineMethod('SameFileName',2,tkVariant,nil,__SameFileName,false,0);
    DefineMethod('AnsiLowerCaseFileName',1,tkVariant,nil,__AnsiLowerCaseFileName,false,0);
    DefineMethod('AnsiUpperCaseFileName',1,tkVariant,nil,__AnsiUpperCaseFileName,false,0);
    DefineMethod('AnsiPos',2,tkInteger,nil,__AnsiPos,false,0);
    DefineMethod('ContainsText',2,tkVariant,nil,__ContainsText,false,0);
    DefineMethod('AnsiContainsText',2,tkVariant,nil,__AnsiContainsText,false,0);
    DefineMethod('StartsText',2,tkVariant,nil,__StartsText,false,0);
    DefineMethod('AnsiStartsText',2,tkVariant,nil,__AnsiStartsText,false,0);
    DefineMethod('EndsText',2,tkVariant,nil,__EndsText,false,0);
    DefineMethod('AnsiEndsText',2,tkVariant,nil,__AnsiEndsText,false,0);
    DefineMethod('ReplaceText',3,tkVariant,nil,__ReplaceText,false,0);
    DefineMethod('AnsiReplaceText',3,tkVariant,nil,__AnsiReplaceText,false,0);
    DefineMethod('ContainsStr',2,tkVariant,nil,__ContainsStr,false,0);
    DefineMethod('AnsiContainsStr',2,tkVariant,nil,__AnsiContainsStr,false,0);
    DefineMethod('StartsStr',2,tkVariant,nil,__StartsStr,false,0);
    DefineMethod('AnsiStartsStr',2,tkVariant,nil,__AnsiStartsStr,false,0);
    DefineMethod('EndsStr',2,tkVariant,nil,__EndsStr,false,0);
    DefineMethod('AnsiEndsStr',2,tkVariant,nil,__AnsiEndsStr,false,0);
    DefineMethod('ReplaceStr',3,tkVariant,nil,__ReplaceStr,false,0);
    DefineMethod('AnsiReplaceStr',3,tkVariant,nil,__AnsiReplaceStr,false,0);
    DefineMethod('DupeString',2,tkVariant,nil,__DupeString,false,0);
    DefineMethod('ReverseString',1,tkVariant,nil,__ReverseString,false,0);
    DefineMethod('AnsiReverseString',1,tkVariant,nil,__AnsiReverseString,false,0);
    DefineMethod('StuffString',4,tkVariant,nil,__StuffString,false,0);
    DefineMethod('StringReplace',4,tkVariant,nil,__StringReplace,false,0);
    DefineMethod('ChangeFileExt',2,tkVariant,nil,__ChangeFileExt,false,0);
    DefineMethod('ChangeFilePath',2,tkVariant,nil,__ChangeFilePath,false,0);
    DefineMethod('ExtractFilePath',1,tkVariant,nil,__ExtractFilePath,false,0);
    DefineMethod('ExtractFileDir',1,tkVariant,nil,__ExtractFileDir,false,0);
    DefineMethod('ExtractFileDrive',1,tkVariant,nil,__ExtractFileDrive,false,0);
    DefineMethod('ExtractFileName',1,tkVariant,nil,__ExtractFileName,false,0);
    DefineMethod('ExtractFileExt',1,tkVariant,nil,__ExtractFileExt,false,0);
    DefineMethod('ExpandFileName',1,tkVariant,nil,__ExpandFileName,false,0);
    DefineMethod('ExpandFileNameCase',2,tkVariant,nil,__ExpandFileNameCase,false,0).SetVarArgs([1]);
    DefineMethod('ExpandUNCFileName',1,tkVariant,nil,__ExpandUNCFileName,false,0);
    DefineMethod('ExtractRelativePath',2,tkVariant,nil,__ExtractRelativePath,false,0);
    DefineMethod('ExtractShortPathName',1,tkVariant,nil,__ExtractShortPathName,false,0);
    DefineMethod('LastDelimiter',2,tkInteger,nil,__LastDelimiter,false,0);
    DefineMethod('IsPathDelimiter',2,tkVariant,nil,__IsPathDelimiter,false,0);
    DefineMethod('IsDelimiter',3,tkVariant,nil,__IsDelimiter,false,0);
    DefineMethod('IncludeTrailingPathDelimiter',1,tkVariant,nil,__IncludeTrailingPathDelimiter,false,0);
    DefineMethod('IncludeTrailingBackslash',1,tkVariant,nil,__IncludeTrailingBackslash,false,0);
    DefineMethod('ExcludeTrailingPathDelimiter',1,tkVariant,nil,__ExcludeTrailingPathDelimiter,false,0);
    DefineMethod('ExcludeTrailingBackslash',1,tkVariant,nil,__ExcludeTrailingBackslash,false,0);
    DefineMethod('PosEx',3,tkInteger,nil,__PosEx,false,1);
    DefineMethod('AnsiLeftStr',2,tkVariant,nil,__AnsiLeftStr,false,0);
    DefineMethod('AnsiRightStr',2,tkVariant,nil,__AnsiRightStr,false,0);
    DefineMethod('AnsiMidStr',3,tkVariant,nil,__AnsiMidStr,false,0);
    AddConstant('mkNone',mkNone);
    AddConstant('mkExactMatch',mkExactMatch);
    AddConstant('mkSingleMatch',mkSingleMatch);
    AddConstant('mkAmbiguous',mkAmbiguous);
  end;
end;

class function TatAnsiStringsLibrary.LibraryName: string;
begin
  result := 'AnsiStrings';
end;

initialization
  RegisterScripterLibrary(TatAnsiStringsLibrary, True);

{$WARNINGS ON}

end.

