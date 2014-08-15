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
unit ap_VDBConsts;

interface

uses
  VDBConsts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatVDBConstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatVDBConstsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SFirstRecord',SFirstRecord);
    AddConstant('SPriorRecord',SPriorRecord);
    AddConstant('SNextRecord',SNextRecord);
    AddConstant('SLastRecord',SLastRecord);
    AddConstant('SInsertRecord',SInsertRecord);
    AddConstant('SDeleteRecord',SDeleteRecord);
    AddConstant('SEditRecord',SEditRecord);
    AddConstant('SPostEdit',SPostEdit);
    AddConstant('SCancelEdit',SCancelEdit);
    AddConstant('SConfirmCaption',SConfirmCaption);
    AddConstant('SRefreshRecord',SRefreshRecord);
    AddConstant('SDeleteRecordQuestion',SDeleteRecordQuestion);
    AddConstant('SDeleteMultipleRecordsQuestion',SDeleteMultipleRecordsQuestion);
    AddConstant('SDataSourceFixed',SDataSourceFixed);
    AddConstant('SNotReplicatable',SNotReplicatable);
    AddConstant('SPropDefByLookup',SPropDefByLookup);
    AddConstant('STooManyColumns',STooManyColumns);
    AddConstant('SRemoteLogin',SRemoteLogin);
    AddConstant('SDataBindings',SDataBindings);
  end;
end;

class function TatVDBConstsLibrary.LibraryName: string;
begin
  result := 'VDBConsts';
end;

initialization
  RegisterScripterLibrary(TatVDBConstsLibrary, True);

{$WARNINGS ON}

end.

