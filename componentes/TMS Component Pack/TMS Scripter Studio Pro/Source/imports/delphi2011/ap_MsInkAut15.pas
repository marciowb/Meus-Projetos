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
unit ap_MsInkAut15;

interface

uses
  Windows,
  MsInkAut,
  ActiveX,
  MsInkAut15,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatMsInkAut15Library = class(TatScripterLibrary)
    procedure __GetIID_IInkDivider(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkDivisionResult(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkDivisionUnit(AMachine: TatVirtualMachine);
    procedure __GetIID_IInkDivisionUnits(AMachine: TatVirtualMachine);
    procedure __GetCLSID_InkDivider(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatMsInkAut15Library.__GetIID_IInkDivider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut15.IID_IInkDivider)));
  end;
end;

procedure TatMsInkAut15Library.__GetIID_IInkDivisionResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut15.IID_IInkDivisionResult)));
  end;
end;

procedure TatMsInkAut15Library.__GetIID_IInkDivisionUnit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut15.IID_IInkDivisionUnit)));
  end;
end;

procedure TatMsInkAut15Library.__GetIID_IInkDivisionUnits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut15.IID_IInkDivisionUnits)));
  end;
end;

procedure TatMsInkAut15Library.__GetCLSID_InkDivider(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(MsInkAut15.CLSID_InkDivider)));
  end;
end;

procedure TatMsInkAut15Library.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('IID_IInkDivider',tkVariant,__GetIID_IInkDivider,nil,nil,false,0);
    DefineProp('IID_IInkDivisionResult',tkVariant,__GetIID_IInkDivisionResult,nil,nil,false,0);
    DefineProp('IID_IInkDivisionUnit',tkVariant,__GetIID_IInkDivisionUnit,nil,nil,false,0);
    DefineProp('IID_IInkDivisionUnits',tkVariant,__GetIID_IInkDivisionUnits,nil,nil,false,0);
    DefineProp('CLSID_InkDivider',tkVariant,__GetCLSID_InkDivider,nil,nil,false,0);
    AddConstant('SID_IInkDivider',SID_IInkDivider);
    AddConstant('SID_IInkDivisionResult',SID_IInkDivisionResult);
    AddConstant('SID_IInkDivisionUnit',SID_IInkDivisionUnit);
    AddConstant('SID_IInkDivisionUnits',SID_IInkDivisionUnits);
    AddConstant('IDT_Segment',IDT_Segment);
    AddConstant('IDT_Line',IDT_Line);
    AddConstant('IDT_Paragraph',IDT_Paragraph);
    AddConstant('IDT_Drawing',IDT_Drawing);
    AddConstant('DISPID_IInkDivider_Strokes',DISPID_IInkDivider_Strokes);
    AddConstant('DISPID_IInkDivider_RecognizerContext',DISPID_IInkDivider_RecognizerContext);
    AddConstant('DISPID_IInkDivider_LineHeight',DISPID_IInkDivider_LineHeight);
    AddConstant('DISPID_IInkDivider_Divide',DISPID_IInkDivider_Divide);
    AddConstant('DISPID_IInkDivisionResult_Strokes',DISPID_IInkDivisionResult_Strokes);
    AddConstant('DISPID_IInkDivisionResult_ResultByType',DISPID_IInkDivisionResult_ResultByType);
    AddConstant('DISPID_IInkDivisionUnit_Strokes',DISPID_IInkDivisionUnit_Strokes);
    AddConstant('DISPID_IInkDivisionUnit_DivisionType',DISPID_IInkDivisionUnit_DivisionType);
    AddConstant('DISPID_IInkDivisionUnit_RecognizedString',DISPID_IInkDivisionUnit_RecognizedString);
    AddConstant('DISPID_IInkDivisionUnit_RotationTransform',DISPID_IInkDivisionUnit_RotationTransform);
    AddConstant('DISPID_IInkDivisionUnits_NewEnum',DISPID_IInkDivisionUnits_NewEnum);
    AddConstant('DISPID_IInkDivisionUnits_Item',DISPID_IInkDivisionUnits_Item);
    AddConstant('DISPID_IInkDivisionUnits_Count',DISPID_IInkDivisionUnits_Count);
  end;
end;

class function TatMsInkAut15Library.LibraryName: string;
begin
  result := 'MsInkAut15';
end;

initialization
  RegisterScripterLibrary(TatMsInkAut15Library, True);

{$WARNINGS ON}

end.

