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
unit ap_DdeMan;

interface

uses
  Windows,
  Classes,
  Forms,
  Controls,
  DDEml,
  DdeMan,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDdeManLibrary = class(TatScripterLibrary)
    procedure __TDdeClientConvCreate(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvDestroy(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvPasteLink(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvOpenLink(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvSetLink(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvCloseLink(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvStartAdvise(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvPokeDataLines(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvPokeData(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvExecuteMacroLines(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvExecuteMacro(AMachine: TatVirtualMachine);
    procedure __TDdeClientConvRequestData(AMachine: TatVirtualMachine);
    procedure __GetTDdeClientConvDdeFmt(AMachine: TatVirtualMachine);
    procedure __GetTDdeClientConvWaitStat(AMachine: TatVirtualMachine);
    procedure __GetTDdeClientConvConv(AMachine: TatVirtualMachine);
    procedure __GetTDdeClientConvDataMode(AMachine: TatVirtualMachine);
    procedure __SetTDdeClientConvDataMode(AMachine: TatVirtualMachine);
    procedure __TDdeClientItemCreate(AMachine: TatVirtualMachine);
    procedure __TDdeClientItemDestroy(AMachine: TatVirtualMachine);
    procedure __TDdeServerConvCreate(AMachine: TatVirtualMachine);
    procedure __TDdeServerConvDestroy(AMachine: TatVirtualMachine);
    procedure __TDdeServerConvExecuteMacro(AMachine: TatVirtualMachine);
    procedure __TDdeServerItemCreate(AMachine: TatVirtualMachine);
    procedure __TDdeServerItemDestroy(AMachine: TatVirtualMachine);
    procedure __TDdeServerItemPokeData(AMachine: TatVirtualMachine);
    procedure __TDdeServerItemCopyToClipboard(AMachine: TatVirtualMachine);
    procedure __TDdeServerItemChange(AMachine: TatVirtualMachine);
    procedure __GetTDdeServerItemFmt(AMachine: TatVirtualMachine);
    procedure __TDdeMgrCreate(AMachine: TatVirtualMachine);
    procedure __TDdeMgrDestroy(AMachine: TatVirtualMachine);
    procedure __TDdeMgrGetExeName(AMachine: TatVirtualMachine);
    procedure __GetTDdeMgrDdeInstId(AMachine: TatVirtualMachine);
    procedure __SetTDdeMgrDdeInstId(AMachine: TatVirtualMachine);
    procedure __GetTDdeMgrAppName(AMachine: TatVirtualMachine);
    procedure __SetTDdeMgrAppName(AMachine: TatVirtualMachine);
    procedure __GetTDdeMgrLinkClipFmt(AMachine: TatVirtualMachine);
    procedure __GetPasteLinkInfo(AMachine: TatVirtualMachine);
    procedure __GetddeMgr(AMachine: TatVirtualMachine);
    procedure __SetddeMgr(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDdeClientConvClass = class of TDdeClientConv;
  TDdeClientItemClass = class of TDdeClientItem;
  TDdeServerConvClass = class of TDdeServerConv;
  TDdeServerItemClass = class of TDdeServerItem;
  TDdeMgrClass = class of TDdeMgr;

  TatDdeManDispatcher = class(TatEventDispatcher)
  private
    procedure __TMacroEvent( Sender: TObject;  Msg: TStrings);
  end;


implementation



procedure TatDdeManLibrary.__TDdeClientConvCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDdeClientConvClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeClientConv(CurrentObject).Destroy;
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvPasteLink(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeClientConv(CurrentObject).PasteLink;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvOpenLink(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeClientConv(CurrentObject).OpenLink;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvSetLink(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeClientConv(CurrentObject).SetLink(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvCloseLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeClientConv(CurrentObject).CloseLink;
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvStartAdvise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeClientConv(CurrentObject).StartAdvise;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvPokeDataLines(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeClientConv(CurrentObject).PokeDataLines(GetInputArg(0),TStrings(Integer(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvPokeData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeClientConv(CurrentObject).PokeData(GetInputArg(0),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvExecuteMacroLines(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeClientConv(CurrentObject).ExecuteMacroLines(TStrings(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvExecuteMacro(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeClientConv(CurrentObject).ExecuteMacro(PChar(VarToStr(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientConvRequestData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(TDdeClientConv(CurrentObject).RequestData(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__GetTDdeClientConvDdeFmt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDdeClientConv(CurrentObject).DdeFmt));
  end;
end;

procedure TatDdeManLibrary.__GetTDdeClientConvWaitStat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDdeClientConv(CurrentObject).WaitStat);
  end;
end;

procedure TatDdeManLibrary.__GetTDdeClientConvConv(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDdeClientConv(CurrentObject).Conv));
  end;
end;

procedure TatDdeManLibrary.__GetTDdeClientConvDataMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDdeClientConv(CurrentObject).DataMode);
  end;
end;

procedure TatDdeManLibrary.__SetTDdeClientConvDataMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeClientConv(CurrentObject).DataMode:=GetInputArg(0);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDdeClientItemClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeClientItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeClientItem(CurrentObject).Destroy;
  end;
end;

procedure TatDdeManLibrary.__TDdeServerConvCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDdeServerConvClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeServerConvDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeServerConv(CurrentObject).Destroy;
  end;
end;

procedure TatDdeManLibrary.__TDdeServerConvExecuteMacro(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDdeServerConv(CurrentObject).ExecuteMacro(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeServerItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDdeServerItemClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeServerItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeServerItem(CurrentObject).Destroy;
  end;
end;

procedure TatDdeManLibrary.__TDdeServerItemPokeData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDdeServerItem(CurrentObject).PokeData(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeServerItemCopyToClipboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeServerItem(CurrentObject).CopyToClipboard;
  end;
end;

procedure TatDdeManLibrary.__TDdeServerItemChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeServerItem(CurrentObject).Change;
  end;
end;

procedure TatDdeManLibrary.__GetTDdeServerItemFmt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDdeServerItem(CurrentObject).Fmt));
  end;
end;

procedure TatDdeManLibrary.__TDdeMgrCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDdeMgrClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__TDdeMgrDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeMgr(CurrentObject).Destroy;
  end;
end;

procedure TatDdeManLibrary.__TDdeMgrGetExeName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDdeMgr(CurrentObject).GetExeName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDdeManLibrary.__GetTDdeMgrDdeInstId(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDdeMgr(CurrentObject).DdeInstId));
  end;
end;

procedure TatDdeManLibrary.__SetTDdeMgrDdeInstId(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeMgr(CurrentObject).DdeInstId:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDdeManLibrary.__GetTDdeMgrAppName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDdeMgr(CurrentObject).AppName);
  end;
end;

procedure TatDdeManLibrary.__SetTDdeMgrAppName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDdeMgr(CurrentObject).AppName:=GetInputArg(0);
  end;
end;

procedure TatDdeManLibrary.__GetTDdeMgrLinkClipFmt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDdeMgr(CurrentObject).LinkClipFmt));
  end;
end;

procedure TatDdeManDispatcher.__TMacroEvent( Sender: TObject;  Msg: TStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMacroEvent(BeforeCall)(Sender,Msg);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Msg]);
    if AssignedMethod(AfterCall) then
      TMacroEvent(AfterCall)(Sender,Msg);
  end;
end;

procedure TatDdeManLibrary.__GetPasteLinkInfo(AMachine: TatVirtualMachine);
  var
  Param0: string;
  Param1: string;
  Param2: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
Param2 := GetInputArg(2);
AResult := DdeMan.GetPasteLinkInfo(Param0,Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(1,Param1);
    SetInputArg(2,Param2);
  end;
end;

procedure TatDdeManLibrary.__GetddeMgr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(DdeMan.ddeMgr));
  end;
end;

procedure TatDdeManLibrary.__SetddeMgr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    DdeMan.ddeMgr:=TDdeMgr(Integer(GetInputArg(0)));
  end;
end;

procedure TatDdeManLibrary.Init;
begin
  With Scripter.DefineClass(TDdeClientConv) do
  begin
    DefineMethod('Create',1,tkClass,TDdeClientConv,__TDdeClientConvCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDdeClientConvDestroy,false,0);
    DefineMethod('PasteLink',0,tkVariant,nil,__TDdeClientConvPasteLink,false,0);
    DefineMethod('OpenLink',0,tkVariant,nil,__TDdeClientConvOpenLink,false,0);
    DefineMethod('SetLink',2,tkVariant,nil,__TDdeClientConvSetLink,false,0);
    DefineMethod('CloseLink',0,tkNone,nil,__TDdeClientConvCloseLink,false,0);
    DefineMethod('StartAdvise',0,tkVariant,nil,__TDdeClientConvStartAdvise,false,0);
    DefineMethod('PokeDataLines',2,tkVariant,nil,__TDdeClientConvPokeDataLines,false,0);
    DefineMethod('PokeData',2,tkVariant,nil,__TDdeClientConvPokeData,false,0);
    DefineMethod('ExecuteMacroLines',2,tkVariant,nil,__TDdeClientConvExecuteMacroLines,false,0);
    DefineMethod('ExecuteMacro',2,tkVariant,nil,__TDdeClientConvExecuteMacro,false,0);
    DefineMethod('RequestData',1,tkVariant,nil,__TDdeClientConvRequestData,false,0);
    DefineProp('DdeFmt',tkInteger,__GetTDdeClientConvDdeFmt,nil,nil,false,0);
    DefineProp('WaitStat',tkVariant,__GetTDdeClientConvWaitStat,nil,nil,false,0);
    DefineProp('Conv',tkInteger,__GetTDdeClientConvConv,nil,nil,false,0);
    DefineProp('DataMode',tkEnumeration,__GetTDdeClientConvDataMode,__SetTDdeClientConvDataMode,nil,false,0);
  end;
  With Scripter.DefineClass(TDdeClientItem) do
  begin
    DefineMethod('Create',1,tkClass,TDdeClientItem,__TDdeClientItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDdeClientItemDestroy,false,0);
  end;
  With Scripter.DefineClass(TDdeServerConv) do
  begin
    DefineMethod('Create',1,tkClass,TDdeServerConv,__TDdeServerConvCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDdeServerConvDestroy,false,0);
    DefineMethod('ExecuteMacro',1,tkInteger,nil,__TDdeServerConvExecuteMacro,false,0);
  end;
  With Scripter.DefineClass(TDdeServerItem) do
  begin
    DefineMethod('Create',1,tkClass,TDdeServerItem,__TDdeServerItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDdeServerItemDestroy,false,0);
    DefineMethod('PokeData',1,tkInteger,nil,__TDdeServerItemPokeData,false,0);
    DefineMethod('CopyToClipboard',0,tkNone,nil,__TDdeServerItemCopyToClipboard,false,0);
    DefineMethod('Change',0,tkNone,nil,__TDdeServerItemChange,false,0);
    DefineProp('Fmt',tkInteger,__GetTDdeServerItemFmt,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDdeMgr) do
  begin
    DefineMethod('Create',1,tkClass,TDdeMgr,__TDdeMgrCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDdeMgrDestroy,false,0);
    DefineMethod('GetExeName',0,tkVariant,nil,__TDdeMgrGetExeName,false,0);
    DefineProp('DdeInstId',tkInteger,__GetTDdeMgrDdeInstId,__SetTDdeMgrDdeInstId,nil,false,0);
    DefineProp('AppName',tkVariant,__GetTDdeMgrAppName,__SetTDdeMgrAppName,nil,false,0);
    DefineProp('LinkClipFmt',tkInteger,__GetTDdeMgrLinkClipFmt,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TMacroEvent), TatDdeManDispatcher, @TatDdeManDispatcher.__TMacroEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetPasteLinkInfo',3,tkVariant,nil,__GetPasteLinkInfo,false,0).SetVarArgs([0,1,2]);
    DefineProp('ddeMgr',tkClass,__GetddeMgr,__SetddeMgr,TDdeMgr,false,0);
    AddConstant('ddeAutomatic',ddeAutomatic);
    AddConstant('ddeManual',ddeManual);
  end;
end;

class function TatDdeManLibrary.LibraryName: string;
begin
  result := 'DdeMan';
end;

initialization
  RegisterScripterLibrary(TatDdeManLibrary, True);

{$WARNINGS ON}

end.

