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
unit ap_Mask;

interface

uses
  Windows,
  SysUtils,
  Classes,
  StdCtrls,
  Controls,
  Messages,
  Forms,
  Graphics,
  Menus,
  Mask,
  atScript;

{$WARNINGS OFF}

type
  TatMaskLibrary = class(TatScripterLibrary)
    procedure __TCustomMaskEditCreate(AMachine: TatVirtualMachine);
    procedure __TCustomMaskEditValidateEdit(AMachine: TatVirtualMachine);
    procedure __TCustomMaskEditClear(AMachine: TatVirtualMachine);
    procedure __TCustomMaskEditGetTextLen(AMachine: TatVirtualMachine);
    procedure __GetTCustomMaskEditIsMasked(AMachine: TatVirtualMachine);
    procedure __GetTCustomMaskEditEditText(AMachine: TatVirtualMachine);
    procedure __SetTCustomMaskEditEditText(AMachine: TatVirtualMachine);
    procedure __GetTCustomMaskEditText(AMachine: TatVirtualMachine);
    procedure __SetTCustomMaskEditText(AMachine: TatVirtualMachine);
    procedure __FormatMaskText(AMachine: TatVirtualMachine);
    procedure __MaskGetMaskSave(AMachine: TatVirtualMachine);
    procedure __MaskGetMaskBlank(AMachine: TatVirtualMachine);
    procedure __MaskGetFldSeparator(AMachine: TatVirtualMachine);
    procedure __GetDefaultBlank(AMachine: TatVirtualMachine);
    procedure __GetMaskFieldSeparator(AMachine: TatVirtualMachine);
    procedure __GetMaskNoSave(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EDBEditErrorClass = class of EDBEditError;
  TCustomMaskEditClass = class of TCustomMaskEdit;
  TMaskEditClass = class of TMaskEdit;



implementation



procedure TatMaskLibrary.__TCustomMaskEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomMaskEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskLibrary.__TCustomMaskEditValidateEdit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMaskEdit(CurrentObject).ValidateEdit;
  end;
end;

procedure TatMaskLibrary.__TCustomMaskEditClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMaskEdit(CurrentObject).Clear;
  end;
end;

procedure TatMaskLibrary.__TCustomMaskEditGetTextLen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomMaskEdit(CurrentObject).GetTextLen);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskLibrary.__GetTCustomMaskEditIsMasked(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomMaskEdit(CurrentObject).IsMasked);
  end;
end;

procedure TatMaskLibrary.__GetTCustomMaskEditEditText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomMaskEdit(CurrentObject).EditText);
  end;
end;

procedure TatMaskLibrary.__SetTCustomMaskEditEditText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMaskEdit(CurrentObject).EditText:=GetInputArg(0);
  end;
end;

procedure TatMaskLibrary.__GetTCustomMaskEditText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomMaskEdit(CurrentObject).Text);
  end;
end;

procedure TatMaskLibrary.__SetTCustomMaskEditText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMaskEdit(CurrentObject).Text:=GetInputArg(0);
  end;
end;

procedure TatMaskLibrary.__FormatMaskText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Mask.FormatMaskText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskLibrary.__MaskGetMaskSave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Mask.MaskGetMaskSave(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskLibrary.__MaskGetMaskBlank(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Mask.MaskGetMaskBlank(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskLibrary.__MaskGetFldSeparator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Mask.MaskGetFldSeparator(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMaskLibrary.__GetDefaultBlank(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Mask.DefaultBlank);
  end;
end;

procedure TatMaskLibrary.__GetMaskFieldSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Mask.MaskFieldSeparator);
  end;
end;

procedure TatMaskLibrary.__GetMaskNoSave(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Mask.MaskNoSave);
  end;
end;

procedure TatMaskLibrary.Init;
begin
  With Scripter.DefineClass(EDBEditError) do
  begin
  end;
  With Scripter.DefineClass(TCustomMaskEdit) do
  begin
    DefineMethod('Create',1,tkClass,TCustomMaskEdit,__TCustomMaskEditCreate,true,0);
    DefineMethod('ValidateEdit',0,tkNone,nil,__TCustomMaskEditValidateEdit,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomMaskEditClear,false,0);
    DefineMethod('GetTextLen',0,tkInteger,nil,__TCustomMaskEditGetTextLen,false,0);
    DefineProp('IsMasked',tkVariant,__GetTCustomMaskEditIsMasked,nil,nil,false,0);
    DefineProp('EditText',tkVariant,__GetTCustomMaskEditEditText,__SetTCustomMaskEditEditText,nil,false,0);
    DefineProp('Text',tkVariant,__GetTCustomMaskEditText,__SetTCustomMaskEditText,nil,false,0);
  end;
  With Scripter.DefineClass(TMaskEdit) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('FormatMaskText',2,tkVariant,nil,__FormatMaskText,false,0);
    DefineMethod('MaskGetMaskSave',1,tkVariant,nil,__MaskGetMaskSave,false,0);
    DefineMethod('MaskGetMaskBlank',1,tkVariant,nil,__MaskGetMaskBlank,false,0);
    DefineMethod('MaskGetFldSeparator',1,tkInteger,nil,__MaskGetFldSeparator,false,0);
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

class function TatMaskLibrary.LibraryName: string;
begin
  result := 'Mask';
end;

initialization
  RegisterScripterLibrary(TatMaskLibrary, True);

{$WARNINGS ON}

end.

