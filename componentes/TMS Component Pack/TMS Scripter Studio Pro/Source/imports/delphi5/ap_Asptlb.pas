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
unit ap_Asptlb;

interface

uses
  ActiveX,
  ComObj,
  Mtx,
  Asptlb,
  atScript;

{$WARNINGS OFF}

type
  TatAsptlbLibrary = class(TatScripterLibrary)
    procedure __TASPObjectOnEndPage(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TASPObjectClass = class of TASPObject;
  TASPMTSObjectClass = class of TASPMTSObject;



implementation



procedure TatAsptlbLibrary.__TASPObjectOnEndPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TASPObject(CurrentObject).OnEndPage;
  end;
end;

procedure TatAsptlbLibrary.Init;
begin
  With Scripter.DefineClass(TASPObject) do
  begin
    DefineMethod('OnEndPage',0,tkNone,nil,__TASPObjectOnEndPage,false,0);
  end;
  With Scripter.DefineClass(TASPMTSObject) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatAsptlbLibrary.LibraryName: string;
begin
  result := 'Asptlb';
end;

initialization
  RegisterScripterLibrary(TatAsptlbLibrary, True);

{$WARNINGS ON}

end.

