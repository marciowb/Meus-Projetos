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
unit ap_ComStrs;

interface

uses
  ComStrs,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatComStrsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatComStrsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('sTabFailClear',sTabFailClear);
    AddConstant('sTabFailDelete',sTabFailDelete);
    AddConstant('sTabFailRetrieve',sTabFailRetrieve);
    AddConstant('sTabFailGetObject',sTabFailGetObject);
    AddConstant('sTabFailSet',sTabFailSet);
    AddConstant('sTabFailSetObject',sTabFailSetObject);
    AddConstant('sTabMustBeMultiLine',sTabMustBeMultiLine);
    AddConstant('sInvalidLevel',sInvalidLevel);
    AddConstant('sInvalidLevelEx',sInvalidLevelEx);
    AddConstant('sInvalidIndex',sInvalidIndex);
    AddConstant('sInsertError',sInsertError);
    AddConstant('sInvalidOwner',sInvalidOwner);
    AddConstant('sUnableToCreateColumn',sUnableToCreateColumn);
    AddConstant('sUnableToCreateItem',sUnableToCreateItem);
    AddConstant('sRichEditInsertError',sRichEditInsertError);
    AddConstant('sRichEditLoadFail',sRichEditLoadFail);
    AddConstant('sRichEditSaveFail',sRichEditSaveFail);
    AddConstant('sTooManyPanels',sTooManyPanels);
    AddConstant('sHKError',sHKError);
    AddConstant('sHKInvalid',sHKInvalid);
    AddConstant('sHKInvalidWindow',sHKInvalidWindow);
    AddConstant('sHKAssigned',sHKAssigned);
    AddConstant('sUDAssociated',sUDAssociated);
    AddConstant('sPageIndexError',sPageIndexError);
    AddConstant('sInvalidComCtl32',sInvalidComCtl32);
    AddConstant('sDateTimeMax',sDateTimeMax);
    AddConstant('sDateTimeMin',sDateTimeMin);
    AddConstant('sNeedAllowNone',sNeedAllowNone);
    AddConstant('sFailSetCalDateTime',sFailSetCalDateTime);
    AddConstant('sFailSetCalMaxSelRange',sFailSetCalMaxSelRange);
    AddConstant('sFailSetCalMinMaxRange',sFailSetCalMinMaxRange);
    AddConstant('sCalRangeNeedsMultiSelect',sCalRangeNeedsMultiSelect);
    AddConstant('sFailsetCalSelRange',sFailsetCalSelRange);
  end;
end;

class function TatComStrsLibrary.LibraryName: string;
begin
  result := 'ComStrs';
end;

initialization
  RegisterScripterLibrary(TatComStrsLibrary, True);

{$WARNINGS ON}

end.

