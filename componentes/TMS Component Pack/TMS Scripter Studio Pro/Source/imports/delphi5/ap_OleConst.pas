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
unit ap_OleConst;

interface

uses
  OleConst,
  atScript;

{$WARNINGS OFF}

type
  TatOleConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatOleConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SBadPropValue',SBadPropValue);
    AddConstant('SCannotActivate',SCannotActivate);
    AddConstant('SNoWindowHandle',SNoWindowHandle);
    AddConstant('SOleError',SOleError);
    AddConstant('SVarNotObject',SVarNotObject);
    AddConstant('SVarNotAutoObject',SVarNotAutoObject);
    AddConstant('SNoMethod',SNoMethod);
    AddConstant('SLinkProperties',SLinkProperties);
    AddConstant('SInvalidLinkSource',SInvalidLinkSource);
    AddConstant('SCannotBreakLink',SCannotBreakLink);
    AddConstant('SLinkedObject',SLinkedObject);
    AddConstant('SEmptyContainer',SEmptyContainer);
    AddConstant('SInvalidVerb',SInvalidVerb);
    AddConstant('SPropDlgCaption',SPropDlgCaption);
    AddConstant('SInvalidStreamFormat',SInvalidStreamFormat);
    AddConstant('SInvalidLicense',SInvalidLicense);
    AddConstant('SNotLicensed',SNotLicensed);
    AddConstant('sNoRunningObject',sNoRunningObject);
  end;
end;

class function TatOleConstLibrary.LibraryName: string;
begin
  result := 'OleConst';
end;

initialization
  RegisterScripterLibrary(TatOleConstLibrary, True);

{$WARNINGS ON}

end.

