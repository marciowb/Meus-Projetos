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
unit ap_ScktCnst;

interface

uses
  ScktCnst,
  atScript;

type
  TatScktCnstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation

{$WARNINGS OFF}



procedure TatScktCnstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('KEY_SOCKETSERVER',KEY_SOCKETSERVER);
    AddConstant('KEY_IE',KEY_IE);
    AddConstant('csSettings',csSettings);
    AddConstant('ckPort',ckPort);
    AddConstant('ckThreadCacheSize',ckThreadCacheSize);
    AddConstant('ckInterceptGUID',ckInterceptGUID);
    AddConstant('ckShowHost',ckShowHost);
    AddConstant('ckTimeout',ckTimeout);
    AddConstant('ckRegistered',ckRegistered);
    AddConstant('SServiceName',SServiceName);
    AddConstant('SApplicationName',SApplicationName);
    AddConstant('SServiceOnly',SServiceOnly);
    AddConstant('SErrClose',SErrClose);
    AddConstant('SErrChangeSettings',SErrChangeSettings);
    AddConstant('SQueryDisconnect',SQueryDisconnect);
    AddConstant('SOpenError',SOpenError);
    AddConstant('SHostUnknown',SHostUnknown);
    AddConstant('SNotShown',SNotShown);
    AddConstant('SNoWinSock2',SNoWinSock2);
    AddConstant('SStatusline',SStatusline);
    AddConstant('SAlreadyRunning',SAlreadyRunning);
    AddConstant('SNotUntilRestart',SNotUntilRestart);
  end;
end;

class function TatScktCnstLibrary.LibraryName: string;
begin
  result := 'ScktCnst';
end;

initialization
  RegisterScripterLibrary(TatScktCnstLibrary, True);

{$WARNINGS ON}

end.
