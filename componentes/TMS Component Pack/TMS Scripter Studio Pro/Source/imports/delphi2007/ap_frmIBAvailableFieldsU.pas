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
unit ap_frmIBAvailableFieldsU;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  IBCustomDataset,
  frmIBAvailableFieldsU,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatfrmIBAvailableFieldsULibrary = class(TatScripterLibrary)
    procedure __GetTfrmIBAvailableFieldsDataSet(AMachine: TatVirtualMachine);
    procedure __SetTfrmIBAvailableFieldsDataSet(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TfrmIBAvailableFieldsClass = class of TfrmIBAvailableFields;



implementation



procedure TatfrmIBAvailableFieldsULibrary.__GetTfrmIBAvailableFieldsDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TfrmIBAvailableFields(CurrentObject).DataSet);
  end;
end;

procedure TatfrmIBAvailableFieldsULibrary.__SetTfrmIBAvailableFieldsDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TfrmIBAvailableFields(CurrentObject).DataSet:=GetInputArg(0);
  end;
end;

procedure TatfrmIBAvailableFieldsULibrary.Init;
begin
  With Scripter.DefineClass(TfrmIBAvailableFields) do
  begin
    DefineProp('DataSet',tkVariant,__GetTfrmIBAvailableFieldsDataSet,__SetTfrmIBAvailableFieldsDataSet,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatfrmIBAvailableFieldsULibrary.LibraryName: string;
begin
  result := 'frmIBAvailableFieldsU';
end;

initialization
  RegisterScripterLibrary(TatfrmIBAvailableFieldsULibrary, True);

{$WARNINGS ON}

end.

