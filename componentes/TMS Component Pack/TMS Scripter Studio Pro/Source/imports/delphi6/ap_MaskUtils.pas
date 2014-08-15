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
unit ap_MaskUtils;

interface

uses
  MaskUtils,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMaskUtilsLibrary = class(TatScripterLibrary)
    procedure __FormatMaskText(AMachine: TatVirtualMachine);
    procedure __MaskGetMaskSave(AMachine: TatVirtualMachine);
    procedure __MaskGetMaskBlank(AMachine: TatVirtualMachine);
    procedure __MaskGetFldSeparator(AMachine: TatVirtualMachine);
    procedure __PadInputLiterals(AMachine: TatVirtualMachine);
    procedure __MaskOffsetToOffset(AMachine: TatVirtualMachine);
    procedure __MaskOffsetToWideOffset(AMachine: TatVirtualMachine);
    procedure __IsLiteralChar(AMachine: TatVirtualMachine);
    procedure __MaskGetCharType(AMachine: TatVirtualMachine);
    procedure __MaskGetCurrentDirectives(AMachine: TatVirtualMachine);
    procedure __MaskIntlLiteralToChar(AMachine: TatVirtualMachine);
    procedure __OffsetToMaskOffset(AMachine: TatVirtualMachine);
    procedure __MaskDoFormatText(AMachine: TatVirtualMachine);
    procedure __GetDefaultBlank(AMachine: TatVirtualMachine);
    procedure __GetMaskFieldSeparator(AMachine: TatVirtualMachine);
    procedure __GetMaskNoSave(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatMaskUtilsLibrary.__FormatMaskText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MaskUtils.FormatMaskText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskGetMaskSave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MaskUtils.MaskGetMaskSave(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskGetMaskBlank(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MaskUtils.MaskGetMaskBlank(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskGetFldSeparator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MaskUtils.MaskGetFldSeparator(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__PadInputLiterals(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MaskUtils.PadInputLiterals(GetInputArg(0),GetInputArg(1),VarToStr(GetInputArg(2))[1]);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskOffsetToOffset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MaskUtils.MaskOffsetToOffset(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskOffsetToWideOffset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MaskUtils.MaskOffsetToWideOffset(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__IsLiteralChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MaskUtils.IsLiteralChar(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskGetCharType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MaskUtils.MaskGetCharType(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskGetCurrentDirectives(AMachine: TatVirtualMachine);
  var
  AResultSet: TMaskDirectives;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := MaskUtils.MaskGetCurrentDirectives(GetInputArg(0),VarToInteger(GetInputArg(1)));
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskIntlLiteralToChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MaskUtils.MaskIntlLiteralToChar(VarToStr(GetInputArg(0))[1]);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__OffsetToMaskOffset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(MaskUtils.OffsetToMaskOffset(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__MaskDoFormatText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := MaskUtils.MaskDoFormatText(GetInputArg(0),GetInputArg(1),VarToStr(GetInputArg(2))[1]);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskUtilsLibrary.__GetDefaultBlank(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(MaskUtils.DefaultBlank);
  end;
end;

procedure TatMaskUtilsLibrary.__GetMaskFieldSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(MaskUtils.MaskFieldSeparator);
  end;
end;

procedure TatMaskUtilsLibrary.__GetMaskNoSave(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(MaskUtils.MaskNoSave);
  end;
end;

procedure TatMaskUtilsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('FormatMaskText',2,tkVariant,nil,__FormatMaskText,false,0);
    DefineMethod('MaskGetMaskSave',1,tkVariant,nil,__MaskGetMaskSave,false,0);
    DefineMethod('MaskGetMaskBlank',1,tkVariant,nil,__MaskGetMaskBlank,false,0);
    DefineMethod('MaskGetFldSeparator',1,tkInteger,nil,__MaskGetFldSeparator,false,0);
    DefineMethod('PadInputLiterals',3,tkVariant,nil,__PadInputLiterals,false,0);
    DefineMethod('MaskOffsetToOffset',2,tkInteger,nil,__MaskOffsetToOffset,false,0);
    DefineMethod('MaskOffsetToWideOffset',2,tkInteger,nil,__MaskOffsetToWideOffset,false,0);
    DefineMethod('IsLiteralChar',2,tkVariant,nil,__IsLiteralChar,false,0);
    DefineMethod('MaskGetCharType',2,tkEnumeration,nil,__MaskGetCharType,false,0);
    DefineMethod('MaskGetCurrentDirectives',2,tkInteger,nil,__MaskGetCurrentDirectives,false,0);
    DefineMethod('MaskIntlLiteralToChar',1,tkVariant,nil,__MaskIntlLiteralToChar,false,0);
    DefineMethod('OffsetToMaskOffset',2,tkInteger,nil,__OffsetToMaskOffset,false,0);
    DefineMethod('MaskDoFormatText',3,tkVariant,nil,__MaskDoFormatText,false,0);
    DefineProp('DefaultBlank',tkVariant,__GetDefaultBlank,nil,nil,false,0);
    DefineProp('MaskFieldSeparator',tkVariant,__GetMaskFieldSeparator,nil,nil,false,0);
    DefineProp('MaskNoSave',tkVariant,__GetMaskNoSave,nil,nil,false,0);
    AddConstant('mcNone',mcNone);
    AddConstant('mcLiteral',mcLiteral);
    AddConstant('mcIntlLiteral',mcIntlLiteral);
    AddConstant('mcDirective',mcDirective);
    AddConstant('mcMask',mcMask);
    AddConstant('mcMaskOpt',mcMaskOpt);
    AddConstant('mcFieldSeparator',mcFieldSeparator);
    AddConstant('mcField',mcField);
    AddConstant('mDirReverse',mDirReverse);
    AddConstant('mDirUpperCase',mDirUpperCase);
    AddConstant('mDirLowerCase',mDirLowerCase);
    AddConstant('mDirLiteral',mDirLiteral);
    AddConstant('mMskAlpha',mMskAlpha);
    AddConstant('mMskAlphaOpt',mMskAlphaOpt);
    AddConstant('mMskAlphaNum',mMskAlphaNum);
    AddConstant('mMskAlphaNumOpt',mMskAlphaNumOpt);
    AddConstant('mMskAscii',mMskAscii);
    AddConstant('mMskAsciiOpt',mMskAsciiOpt);
    AddConstant('mMskNumeric',mMskNumeric);
    AddConstant('mMskNumericOpt',mMskNumericOpt);
    AddConstant('mMskNumSymOpt',mMskNumSymOpt);
    AddConstant('mMskTimeSeparator',mMskTimeSeparator);
    AddConstant('mMskDateSeparator',mMskDateSeparator);
  end;
end;

class function TatMaskUtilsLibrary.LibraryName: string;
begin
  result := 'MaskUtils';
end;

initialization
  RegisterScripterLibrary(TatMaskUtilsLibrary, True);

{$WARNINGS ON}

end.

