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
unit ap_ADOConst;

interface

uses
  ADOConst,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatADOConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatADOConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SInvalidEnumValue',SInvalidEnumValue);
    AddConstant('SMissingConnection',SMissingConnection);
    AddConstant('SNoDetailFilter',SNoDetailFilter);
    AddConstant('SBookmarksRequired',SBookmarksRequired);
    AddConstant('SMissingCommandText',SMissingCommandText);
    AddConstant('SNoResultSet',SNoResultSet);
    AddConstant('SADOCreateError',SADOCreateError);
    AddConstant('SEventsNotSupported',SEventsNotSupported);
    AddConstant('SUsupportedFieldType',SUsupportedFieldType);
    AddConstant('SNoMatchingADOType',SNoMatchingADOType);
    AddConstant('SConnectionRequired',SConnectionRequired);
    AddConstant('SCantRequery',SCantRequery);
    AddConstant('SNoFilterOptions',SNoFilterOptions);
    AddConstant('SRecordsetNotOpen',SRecordsetNotOpen);
  end;
end;

class function TatADOConstLibrary.LibraryName: string;
begin
  result := 'ADOConst';
end;

initialization
  RegisterScripterLibrary(TatADOConstLibrary, True);

{$WARNINGS ON}

end.

