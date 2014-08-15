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
unit ap_AspTlb;

interface

uses
  ActiveX,
  ComObj,
  Mtx,
  AspTlb,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatAspTlbLibrary = class(TatScripterLibrary)
    procedure __TASPObjectOnStartPage(AMachine: TatVirtualMachine);
    procedure __TASPObjectOnEndPage(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TASPObjectClass = class of TASPObject;
  TASPMTSObjectClass = class of TASPMTSObject;



implementation



procedure TatAspTlbLibrary.__TASPObjectOnStartPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TASPObject(CurrentObject).OnStartPage(GetInputArg(0));
  end;
end;

procedure TatAspTlbLibrary.__TASPObjectOnEndPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TASPObject(CurrentObject).OnEndPage;
  end;
end;

procedure TatAspTlbLibrary.Init;
begin
  With Scripter.DefineClass(TASPObject) do
  begin
    DefineMethod('OnStartPage',1,tkNone,nil,__TASPObjectOnStartPage,false,0);
    DefineMethod('OnEndPage',0,tkNone,nil,__TASPObjectOnEndPage,false,0);
  end;
  With Scripter.DefineClass(TASPMTSObject) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatAspTlbLibrary.LibraryName: string;
begin
  result := 'AspTlb';
end;

initialization
  RegisterScripterLibrary(TatAspTlbLibrary, True);

{$WARNINGS ON}

end.

