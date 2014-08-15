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
unit ap_OleCtnrs;

interface

uses
  Windows,
  Messages,
  CommCtrl,
  ActiveX,
  OleDlg,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Menus,
  Graphics,
  ComObj,
  OleCtnrs,
  atScript;

{$WARNINGS OFF}

type
  TatOleCtnrsLibrary = class(TatScripterLibrary)
    procedure __TOleContainerCreate(AMachine: TatVirtualMachine);
    procedure __TOleContainerDestroy(AMachine: TatVirtualMachine);
    procedure __TOleContainerChangeIconDialog(AMachine: TatVirtualMachine);
    procedure __TOleContainerClose(AMachine: TatVirtualMachine);
    procedure __TOleContainerCopy(AMachine: TatVirtualMachine);
    procedure __TOleContainerCreateLinkToFile(AMachine: TatVirtualMachine);
    procedure __TOleContainerCreateObject(AMachine: TatVirtualMachine);
    procedure __TOleContainerCreateObjectFromFile(AMachine: TatVirtualMachine);
    procedure __TOleContainerCreateObjectFromInfo(AMachine: TatVirtualMachine);
    procedure __TOleContainerDestroyObject(AMachine: TatVirtualMachine);
    procedure __TOleContainerDoVerb(AMachine: TatVirtualMachine);
    procedure __TOleContainerGetIconMetaPict(AMachine: TatVirtualMachine);
    procedure __TOleContainerInsertObjectDialog(AMachine: TatVirtualMachine);
    procedure __TOleContainerLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TOleContainerLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TOleContainerObjectPropertiesDialog(AMachine: TatVirtualMachine);
    procedure __TOleContainerPaste(AMachine: TatVirtualMachine);
    procedure __TOleContainerPasteSpecialDialog(AMachine: TatVirtualMachine);
    procedure __TOleContainerRun(AMachine: TatVirtualMachine);
    procedure __TOleContainerSaveAsDocument(AMachine: TatVirtualMachine);
    procedure __TOleContainerSaveToFile(AMachine: TatVirtualMachine);
    procedure __TOleContainerSaveToStream(AMachine: TatVirtualMachine);
    procedure __TOleContainerUpdateObject(AMachine: TatVirtualMachine);
    procedure __TOleContainerUpdateVerbs(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerCanPaste(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerLinked(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerModified(AMachine: TatVirtualMachine);
    procedure __SetTOleContainerModified(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerNewInserted(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerObjectVerbs(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerOleClassName(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerOleObject(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerPrimaryVerb(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerSourceDoc(AMachine: TatVirtualMachine);
    procedure __GetTOleContainerState(AMachine: TatVirtualMachine);
    procedure __TOleFormCreate(AMachine: TatVirtualMachine);
    procedure __TOleFormDestroy(AMachine: TatVirtualMachine);
    procedure __DestroyMetaPict(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TOleContainerClass = class of TOleContainer;
  TOleFormClass = class of TOleForm;


  TCreateInfoWrapper = class(TatRecordWrapper)
  private
    FCreateType: TCreateType;
    FShowAsIcon: Boolean;
    FIconMetaPict: HGlobal;
    FFileName: WideString;
  public
    constructor Create(ARecord: TCreateInfo);
    function ObjToRec: TCreateInfo;
  published
    property CreateType: TCreateType read FCreateType write FCreateType;
    property ShowAsIcon: Boolean read FShowAsIcon write FShowAsIcon;
    property IconMetaPict: HGlobal read FIconMetaPict write FIconMetaPict;
    property FileName: WideString read FFileName write FFileName;
  end;
  
  TVerbInfoWrapper = class(TatRecordWrapper)
  private
    FVerb: Smallint;
    FFlags: Word;
  public
    constructor Create(ARecord: TVerbInfo);
    function ObjToRec: TVerbInfo;
  published
    property Verb: Smallint read FVerb write FVerb;
    property Flags: Word read FFlags write FFlags;
  end;
  

implementation

constructor TCreateInfoWrapper.Create(ARecord: TCreateInfo);
begin
  inherited Create;
  FCreateType := ARecord.CreateType;
  FShowAsIcon := ARecord.ShowAsIcon;
  FIconMetaPict := ARecord.IconMetaPict;
  FFileName := ARecord.FileName;
end;

function TCreateInfoWrapper.ObjToRec: TCreateInfo;
begin
  result.CreateType := FCreateType;
  result.ShowAsIcon := FShowAsIcon;
  result.IconMetaPict := FIconMetaPict;
  result.FileName := FFileName;
end;

constructor TVerbInfoWrapper.Create(ARecord: TVerbInfo);
begin
  inherited Create;
  FVerb := ARecord.Verb;
  FFlags := ARecord.Flags;
end;

function TVerbInfoWrapper.ObjToRec: TVerbInfo;
begin
  result.Verb := FVerb;
  result.Flags := FFlags;
end;



procedure TatOleCtnrsLibrary.__TOleContainerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOleContainerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).Destroy;
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerChangeIconDialog(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOleContainer(CurrentObject).ChangeIconDialog;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).Close;
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerCopy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).Copy;
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerCreateLinkToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).CreateLinkToFile(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerCreateObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).CreateObject(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerCreateObjectFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).CreateObjectFromFile(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerCreateObjectFromInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).CreateObjectFromInfo(TCreateInfoWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerDestroyObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).DestroyObject;
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerDoVerb(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).DoVerb(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerGetIconMetaPict(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOleContainer(CurrentObject).GetIconMetaPict);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerInsertObjectDialog(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOleContainer(CurrentObject).InsertObjectDialog;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerObjectPropertiesDialog(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOleContainer(CurrentObject).ObjectPropertiesDialog;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerPaste(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).Paste;
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerPasteSpecialDialog(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOleContainer(CurrentObject).PasteSpecialDialog;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerRun(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).Run;
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerSaveAsDocument(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).SaveAsDocument(GetInputArg(0));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerUpdateObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).UpdateObject;
  end;
end;

procedure TatOleCtnrsLibrary.__TOleContainerUpdateVerbs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).UpdateVerbs;
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerCanPaste(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleContainer(CurrentObject).CanPaste);
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerLinked(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleContainer(CurrentObject).Linked);
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleContainer(CurrentObject).Modified);
  end;
end;

procedure TatOleCtnrsLibrary.__SetTOleContainerModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleContainer(CurrentObject).Modified:=GetInputArg(0);
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerNewInserted(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleContainer(CurrentObject).NewInserted);
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerObjectVerbs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOleContainer(CurrentObject).ObjectVerbs));
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerOleClassName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleContainer(CurrentObject).OleClassName);
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerOleObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleContainer(CurrentObject).OleObject);
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerPrimaryVerb(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOleContainer(CurrentObject).PrimaryVerb));
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerSourceDoc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleContainer(CurrentObject).SourceDoc);
  end;
end;

procedure TatOleCtnrsLibrary.__GetTOleContainerState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOleContainer(CurrentObject).State);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleFormCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOleFormClass(CurrentClass.ClassRef).Create(TCustomForm(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtnrsLibrary.__TOleFormDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleForm(CurrentObject).Destroy;
  end;
end;

procedure TatOleCtnrsLibrary.__DestroyMetaPict(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    OleCtnrs.DestroyMetaPict(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatOleCtnrsLibrary.Init;
begin
  With Scripter.DefineClass(TOleContainer) do
  begin
    DefineMethod('Create',1,tkClass,TOleContainer,__TOleContainerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOleContainerDestroy,false,0);
    DefineMethod('ChangeIconDialog',0,tkVariant,nil,__TOleContainerChangeIconDialog,false,0);
    DefineMethod('Close',0,tkNone,nil,__TOleContainerClose,false,0);
    DefineMethod('Copy',0,tkNone,nil,__TOleContainerCopy,false,0);
    DefineMethod('CreateLinkToFile',2,tkNone,nil,__TOleContainerCreateLinkToFile,false,0);
    DefineMethod('CreateObject',2,tkNone,nil,__TOleContainerCreateObject,false,0);
    DefineMethod('CreateObjectFromFile',2,tkNone,nil,__TOleContainerCreateObjectFromFile,false,0);
    DefineMethod('CreateObjectFromInfo',1,tkNone,nil,__TOleContainerCreateObjectFromInfo,false,0);
    DefineMethod('DestroyObject',0,tkNone,nil,__TOleContainerDestroyObject,false,0);
    DefineMethod('DoVerb',1,tkNone,nil,__TOleContainerDoVerb,false,0);
    DefineMethod('GetIconMetaPict',0,tkInteger,nil,__TOleContainerGetIconMetaPict,false,0);
    DefineMethod('InsertObjectDialog',0,tkVariant,nil,__TOleContainerInsertObjectDialog,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TOleContainerLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TOleContainerLoadFromStream,false,0);
    DefineMethod('ObjectPropertiesDialog',0,tkVariant,nil,__TOleContainerObjectPropertiesDialog,false,0);
    DefineMethod('Paste',0,tkNone,nil,__TOleContainerPaste,false,0);
    DefineMethod('PasteSpecialDialog',0,tkVariant,nil,__TOleContainerPasteSpecialDialog,false,0);
    DefineMethod('Run',0,tkNone,nil,__TOleContainerRun,false,0);
    DefineMethod('SaveAsDocument',1,tkNone,nil,__TOleContainerSaveAsDocument,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TOleContainerSaveToFile,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TOleContainerSaveToStream,false,0);
    DefineMethod('UpdateObject',0,tkNone,nil,__TOleContainerUpdateObject,false,0);
    DefineMethod('UpdateVerbs',0,tkNone,nil,__TOleContainerUpdateVerbs,false,0);
    DefineProp('CanPaste',tkVariant,__GetTOleContainerCanPaste,nil,nil,false,0);
    DefineProp('Linked',tkVariant,__GetTOleContainerLinked,nil,nil,false,0);
    DefineProp('Modified',tkVariant,__GetTOleContainerModified,__SetTOleContainerModified,nil,false,0);
    DefineProp('NewInserted',tkVariant,__GetTOleContainerNewInserted,nil,nil,false,0);
    DefineProp('ObjectVerbs',tkClass,__GetTOleContainerObjectVerbs,nil,TStrings,false,0);
    DefineProp('OleClassName',tkVariant,__GetTOleContainerOleClassName,nil,nil,false,0);
    DefineProp('OleObject',tkVariant,__GetTOleContainerOleObject,nil,nil,false,0);
    DefineProp('PrimaryVerb',tkInteger,__GetTOleContainerPrimaryVerb,nil,nil,false,0);
    DefineProp('SourceDoc',tkVariant,__GetTOleContainerSourceDoc,nil,nil,false,0);
    DefineProp('State',tkEnumeration,__GetTOleContainerState,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TOleForm) do
  begin
    DefineMethod('Create',1,tkClass,TOleForm,__TOleFormCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOleFormDestroy,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DestroyMetaPict',1,tkNone,nil,__DestroyMetaPict,false,0);
    AddConstant('aaManual',aaManual);
    AddConstant('aaGetFocus',aaGetFocus);
    AddConstant('aaDoubleClick',aaDoubleClick);
    AddConstant('smClip',smClip);
    AddConstant('smCenter',smCenter);
    AddConstant('smScale',smScale);
    AddConstant('smStretch',smStretch);
    AddConstant('smAutoSize',smAutoSize);
    AddConstant('osEmpty',osEmpty);
    AddConstant('osLoaded',osLoaded);
    AddConstant('osRunning',osRunning);
    AddConstant('osOpen',osOpen);
    AddConstant('osInPlaceActive',osInPlaceActive);
    AddConstant('osUIActive',osUIActive);
    AddConstant('ctNewObject',ctNewObject);
    AddConstant('ctFromFile',ctFromFile);
    AddConstant('ctLinkToFile',ctLinkToFile);
    AddConstant('ctFromData',ctFromData);
    AddConstant('ctLinkFromData',ctLinkFromData);
    AddConstant('ovShow',ovShow);
    AddConstant('ovOpen',ovOpen);
    AddConstant('ovHide',ovHide);
    AddConstant('ovUIActivate',ovUIActivate);
    AddConstant('ovInPlaceActivate',ovInPlaceActivate);
    AddConstant('ovDiscardUndoState',ovDiscardUndoState);
    AddConstant('ovPrimary',ovPrimary);
  end;
end;

class function TatOleCtnrsLibrary.LibraryName: string;
begin
  result := 'OleCtnrs';
end;

initialization
  RegisterScripterLibrary(TatOleCtnrsLibrary, True);

{$WARNINGS ON}

end.

