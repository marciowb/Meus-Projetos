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
unit ap_WebConst;

interface

uses
  WebConst,
  atScript;

{$WARNINGS OFF}

type
  TatWebConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatWebConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('sInvalidActionRegistration',sInvalidActionRegistration);
    AddConstant('sDuplicateActionName',sDuplicateActionName);
    AddConstant('sOnlyOneDispatcher',sOnlyOneDispatcher);
    AddConstant('sHTTPItemName',sHTTPItemName);
    AddConstant('sHTTPItemURI',sHTTPItemURI);
    AddConstant('sHTTPItemEnabled',sHTTPItemEnabled);
    AddConstant('sHTTPItemDefault',sHTTPItemDefault);
    AddConstant('sHTTPItemProducer',sHTTPItemProducer);
    AddConstant('sResNotFound',sResNotFound);
    AddConstant('sTooManyColumns',sTooManyColumns);
    AddConstant('sFieldNameColumn',sFieldNameColumn);
    AddConstant('sFieldTypeColumn',sFieldTypeColumn);
  end;
end;

class function TatWebConstLibrary.LibraryName: string;
begin
  result := 'WebConst';
end;

initialization
  RegisterScripterLibrary(TatWebConstLibrary, True);

{$WARNINGS ON}

end.

