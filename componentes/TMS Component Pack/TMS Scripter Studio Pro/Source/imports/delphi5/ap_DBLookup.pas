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
unit ap_DBLookup;

interface

uses
  Windows,
  Classes,
  StdCtrls,
  DB,
  Controls,
  Messages,
  SysUtils,
  Forms,
  Graphics,
  Menus,
  Buttons,
  DBGrids,
  DBTables,
  Grids,
  DBCtrls,
  DBLookup,
  atScript;

{$WARNINGS OFF}

type
  TatDBLookupLibrary = class(TatScripterLibrary)
    procedure __TDBLookupComboCreate(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboDestroy(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboDropDown(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboCloseUp(AMachine: TatVirtualMachine);
    procedure __GetTDBLookupComboValue(AMachine: TatVirtualMachine);
    procedure __SetTDBLookupComboValue(AMachine: TatVirtualMachine);
    procedure __GetTDBLookupComboDisplayValue(AMachine: TatVirtualMachine);
    procedure __SetTDBLookupComboDisplayValue(AMachine: TatVirtualMachine);
    procedure __TDBLookupListCreate(AMachine: TatVirtualMachine);
    procedure __TDBLookupListDestroy(AMachine: TatVirtualMachine);
    procedure __GetTDBLookupListValue(AMachine: TatVirtualMachine);
    procedure __SetTDBLookupListValue(AMachine: TatVirtualMachine);
    procedure __GetTDBLookupListDisplayValue(AMachine: TatVirtualMachine);
    procedure __SetTDBLookupListDisplayValue(AMachine: TatVirtualMachine);
    procedure __TPopupGridCreate(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDBLookupComboClass = class of TDBLookupCombo;
  TDBLookupListClass = class of TDBLookupList;
  TPopupGridClass = class of TPopupGrid;
  TComboButtonClass = class of TComboButton;



implementation



procedure TatDBLookupLibrary.__TDBLookupComboCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBLookupComboClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLookupLibrary.__TDBLookupComboDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupCombo(CurrentObject).Destroy;
  end;
end;

procedure TatDBLookupLibrary.__TDBLookupComboDropDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupCombo(CurrentObject).DropDown;
  end;
end;

procedure TatDBLookupLibrary.__TDBLookupComboCloseUp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupCombo(CurrentObject).CloseUp;
  end;
end;

procedure TatDBLookupLibrary.__GetTDBLookupComboValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBLookupCombo(CurrentObject).Value);
  end;
end;

procedure TatDBLookupLibrary.__SetTDBLookupComboValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupCombo(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLookupLibrary.__GetTDBLookupComboDisplayValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBLookupCombo(CurrentObject).DisplayValue);
  end;
end;

procedure TatDBLookupLibrary.__SetTDBLookupComboDisplayValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupCombo(CurrentObject).DisplayValue:=GetInputArg(0);
  end;
end;

procedure TatDBLookupLibrary.__TDBLookupListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBLookupListClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLookupLibrary.__TDBLookupListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupList(CurrentObject).Destroy;
  end;
end;

procedure TatDBLookupLibrary.__GetTDBLookupListValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBLookupList(CurrentObject).Value);
  end;
end;

procedure TatDBLookupLibrary.__SetTDBLookupListValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupList(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLookupLibrary.__GetTDBLookupListDisplayValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBLookupList(CurrentObject).DisplayValue);
  end;
end;

procedure TatDBLookupLibrary.__SetTDBLookupListDisplayValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupList(CurrentObject).DisplayValue:=GetInputArg(0);
  end;
end;

procedure TatDBLookupLibrary.__TPopupGridCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPopupGridClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLookupLibrary.Init;
begin
  With Scripter.DefineClass(TDBLookupCombo) do
  begin
    DefineMethod('Create',1,tkClass,TDBLookupCombo,__TDBLookupComboCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBLookupComboDestroy,false,0);
    DefineMethod('DropDown',0,tkNone,nil,__TDBLookupComboDropDown,false,0);
    DefineMethod('CloseUp',0,tkNone,nil,__TDBLookupComboCloseUp,false,0);
    DefineProp('Value',tkVariant,__GetTDBLookupComboValue,__SetTDBLookupComboValue,nil,false,0);
    DefineProp('DisplayValue',tkVariant,__GetTDBLookupComboDisplayValue,__SetTDBLookupComboDisplayValue,nil,false,0);
  end;
  With Scripter.DefineClass(TDBLookupList) do
  begin
    DefineMethod('Create',1,tkClass,TDBLookupList,__TDBLookupListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBLookupListDestroy,false,0);
    DefineProp('Value',tkVariant,__GetTDBLookupListValue,__SetTDBLookupListValue,nil,false,0);
    DefineProp('DisplayValue',tkVariant,__GetTDBLookupListDisplayValue,__SetTDBLookupListDisplayValue,nil,false,0);
  end;
  With Scripter.DefineClass(TPopupGrid) do
  begin
    DefineMethod('Create',1,tkClass,TPopupGrid,__TPopupGridCreate,true,0);
    DefineProp('RowCount',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TComboButton) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('csDropDown',csDropDown);
    AddConstant('csDropDownList',csDropDownList);
    AddConstant('loColLines',loColLines);
    AddConstant('loRowLines',loRowLines);
    AddConstant('loTitles',loTitles);
  end;
end;

class function TatDBLookupLibrary.LibraryName: string;
begin
  result := 'DBLookup';
end;

initialization
  RegisterScripterLibrary(TatDBLookupLibrary, True);

{$WARNINGS ON}

end.

