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
unit ap_TabNotBk;

interface

uses
  Windows,
  Classes,
  StdCtrls,
  Forms,
  Messages,
  Graphics,
  Controls,
  ComCtrls,
  TabNotBk,
  Variants,
  ap_Messages,
  atScript;

{$WARNINGS OFF}

type
  TatTabNotBkLibrary = class(TatScripterLibrary)
    procedure __TTabPageCreate(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookCMTabFontChanged(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookCreate(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookDestroy(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookGetIndexForPage(AMachine: TatVirtualMachine);
    procedure __TTabbedNotebookTabFontChanged(AMachine: TatVirtualMachine);
    procedure __GetTTabbedNotebookTopFont(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TTabPageClass = class of TTabPage;
  TTabbedNotebookClass = class of TTabbedNotebook;

  TatTabNotBkDispatcher = class(TatEventDispatcher)
  private
    procedure __TPageChangeEvent( Sender: TObject;  NewTab: Integer; var AllowChange: Boolean);
  end;


implementation



procedure TatTabNotBkLibrary.__TTabPageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabPageClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabNotBkLibrary.__TTabbedNotebookCMTabFontChanged(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMessage;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TMessageWrapper) then 
  Param0Rec := TMessageWrapper.Create(Param0);
Param0 := TMessageWrapper(Param0Rec).ObjToRec;
    TTabbedNotebook(CurrentObject).CMTabFontChanged(Param0);
    SetInputArg(0,integer(TMessageWrapper.Create(Param0)));
  end;
end;

procedure TatTabNotBkLibrary.__TTabbedNotebookCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabbedNotebookClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabNotBkLibrary.__TTabbedNotebookDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabbedNotebook(CurrentObject).Destroy;
  end;
end;

procedure TatTabNotBkLibrary.__TTabbedNotebookGetIndexForPage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabbedNotebook(CurrentObject).GetIndexForPage(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabNotBkLibrary.__TTabbedNotebookTabFontChanged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabbedNotebook(CurrentObject).TabFontChanged(TObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatTabNotBkLibrary.__GetTTabbedNotebookTopFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTabbedNotebook(CurrentObject).TopFont));
  end;
end;

procedure TatTabNotBkDispatcher.__TPageChangeEvent( Sender: TObject;  NewTab: Integer; var AllowChange: Boolean);
var
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TPageChangeEvent(BeforeCall)(Sender,NewTab,AllowChange);
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,NewTab,AllowChangeTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TPageChangeEvent(AfterCall)(Sender,NewTab,AllowChange);
  end;
end;

procedure TatTabNotBkLibrary.Init;
begin
  With Scripter.DefineClass(TTabPage) do
  begin
    DefineMethod('Create',1,tkClass,TTabPage,__TTabPageCreate,true,0);
  end;
  With Scripter.DefineClass(TTabbedNotebook) do
  begin
    DefineMethod('CMTabFontChanged',1,tkNone,nil,__TTabbedNotebookCMTabFontChanged,false,0).SetVarArgs([0]);
    DefineMethod('Create',1,tkClass,TTabbedNotebook,__TTabbedNotebookCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTabbedNotebookDestroy,false,0);
    DefineMethod('GetIndexForPage',1,tkInteger,nil,__TTabbedNotebookGetIndexForPage,false,0);
    DefineMethod('TabFontChanged',1,tkNone,nil,__TTabbedNotebookTabFontChanged,false,0);
    DefineProp('TopFont',tkClass,__GetTTabbedNotebookTopFont,nil,TFont,false,0);
  end;
  DefineEventAdapter(TypeInfo(TPageChangeEvent), TatTabNotBkDispatcher, @TatTabNotBkDispatcher.__TPageChangeEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('CM_TABFONTCHANGED',CM_TABFONTCHANGED);
  end;
end;

class function TatTabNotBkLibrary.LibraryName: string;
begin
  result := 'TabNotBk';
end;

initialization
  RegisterScripterLibrary(TatTabNotBkLibrary, True);

{$WARNINGS ON}

end.

