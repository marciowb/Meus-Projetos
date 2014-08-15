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
unit ap_ImgList;

interface

uses
  Windows,
  Classes,
  Graphics,
  CommCtrl,
  ImgList,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatImgListLibrary = class(TatScripterLibrary)
    procedure __TChangeLinkDestroy(AMachine: TatVirtualMachine);
    procedure __TChangeLinkChange(AMachine: TatVirtualMachine);
    procedure __GetTChangeLinkSender(AMachine: TatVirtualMachine);
    procedure __SetTChangeLinkSender(AMachine: TatVirtualMachine);
    procedure __TCustomImageListCreate(AMachine: TatVirtualMachine);
    procedure __TCustomImageListCreateSize(AMachine: TatVirtualMachine);
    procedure __TCustomImageListDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomImageListAssign(AMachine: TatVirtualMachine);
    procedure __TCustomImageListAdd(AMachine: TatVirtualMachine);
    procedure __TCustomImageListAddIcon(AMachine: TatVirtualMachine);
    procedure __TCustomImageListAddImages(AMachine: TatVirtualMachine);
    procedure __TCustomImageListAddMasked(AMachine: TatVirtualMachine);
    procedure __TCustomImageListClear(AMachine: TatVirtualMachine);
    procedure __TCustomImageListDelete(AMachine: TatVirtualMachine);
    procedure __TCustomImageListDraw(AMachine: TatVirtualMachine);
    procedure __TCustomImageListDrawOverlay(AMachine: TatVirtualMachine);
    procedure __TCustomImageListFileLoad(AMachine: TatVirtualMachine);
    procedure __TCustomImageListGetBitmap(AMachine: TatVirtualMachine);
    procedure __TCustomImageListGetHotSpot(AMachine: TatVirtualMachine);
    procedure __TCustomImageListGetIcon(AMachine: TatVirtualMachine);
    procedure __TCustomImageListGetImageBitmap(AMachine: TatVirtualMachine);
    procedure __TCustomImageListGetMaskBitmap(AMachine: TatVirtualMachine);
    procedure __TCustomImageListGetResource(AMachine: TatVirtualMachine);
    procedure __TCustomImageListGetInstRes(AMachine: TatVirtualMachine);
    procedure __TCustomImageListHandleAllocated(AMachine: TatVirtualMachine);
    procedure __TCustomImageListInsert(AMachine: TatVirtualMachine);
    procedure __TCustomImageListInsertIcon(AMachine: TatVirtualMachine);
    procedure __TCustomImageListInsertMasked(AMachine: TatVirtualMachine);
    procedure __TCustomImageListMove(AMachine: TatVirtualMachine);
    procedure __TCustomImageListOverlay(AMachine: TatVirtualMachine);
    procedure __TCustomImageListRegisterChanges(AMachine: TatVirtualMachine);
    procedure __TCustomImageListResourceLoad(AMachine: TatVirtualMachine);
    procedure __TCustomImageListResInstLoad(AMachine: TatVirtualMachine);
    procedure __TCustomImageListReplace(AMachine: TatVirtualMachine);
    procedure __TCustomImageListReplaceIcon(AMachine: TatVirtualMachine);
    procedure __TCustomImageListReplaceMasked(AMachine: TatVirtualMachine);
    procedure __TCustomImageListUnRegisterChanges(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListHandle(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListHandle(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListAllocBy(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListAllocBy(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListBlendColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListBlendColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListBkColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListBkColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListDrawingStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListDrawingStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListHeight(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListHeight(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListImageType(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListImageType(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListMasked(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListMasked(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListShareImages(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListShareImages(AMachine: TatVirtualMachine);
    procedure __GetTCustomImageListWidth(AMachine: TatVirtualMachine);
    procedure __SetTCustomImageListWidth(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TChangeLinkClass = class of TChangeLink;
  TCustomImageListClass = class of TCustomImageList;



implementation



procedure TatImgListLibrary.__TChangeLinkDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChangeLink(CurrentObject).Destroy;
  end;
end;

procedure TatImgListLibrary.__TChangeLinkChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChangeLink(CurrentObject).Change;
  end;
end;

procedure TatImgListLibrary.__GetTChangeLinkSender(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChangeLink(CurrentObject).Sender));
  end;
end;

procedure TatImgListLibrary.__SetTChangeLinkSender(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChangeLink(CurrentObject).Sender:=TCustomImageList(Integer(GetInputArg(0)));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomImageListClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListCreateSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomImageListClass(CurrentClass.ClassRef).CreateSize(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Destroy;
  end;
end;

procedure TatImgListLibrary.__TCustomImageListAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomImageList(CurrentObject).Add(TBitmap(Integer(GetInputArg(0))),TBitmap(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListAddIcon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomImageList(CurrentObject).AddIcon(TIcon(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListAddImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).AddImages(TCustomImageList(Integer(GetInputArg(0))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListAddMasked(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomImageList(CurrentObject).AddMasked(TBitmap(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Clear;
  end;
end;

procedure TatImgListLibrary.__TCustomImageListDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      4: TCustomImageList(CurrentObject).Draw(TCanvas(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
      5: TCustomImageList(CurrentObject).Draw(TCanvas(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),GetInputArg(4));
    end;
  end;
end;

procedure TatImgListLibrary.__TCustomImageListDrawOverlay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      5: TCustomImageList(CurrentObject).DrawOverlay(TCanvas(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),GetInputArg(4));
      6: TCustomImageList(CurrentObject).DrawOverlay(TCanvas(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),GetInputArg(4),GetInputArg(5));
    end;
  end;
end;

procedure TatImgListLibrary.__TCustomImageListFileLoad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomImageList(CurrentObject).FileLoad(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListGetBitmap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).GetBitmap(VarToInteger(GetInputArg(0)),TBitmap(Integer(GetInputArg(1))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListGetHotSpot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TPointWrapper.Create(TCustomImageList(CurrentObject).GetHotSpot));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListGetIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).GetIcon(VarToInteger(GetInputArg(0)),TIcon(Integer(GetInputArg(1))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListGetImageBitmap(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomImageList(CurrentObject).GetImageBitmap);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListGetMaskBitmap(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomImageList(CurrentObject).GetMaskBitmap);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListGetResource(AMachine: TatVirtualMachine);
  var
  Param3: TLoadResources;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
AResult := TCustomImageList(CurrentObject).GetResource(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),Param3,GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListGetInstRes(AMachine: TatVirtualMachine);
  var
  Param4: TLoadResources;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param4, VarToInteger(GetInputArg(4)), SizeOf(Param4));
AResult := TCustomImageList(CurrentObject).GetInstRes(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),Param4,GetInputArg(5));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListHandleAllocated(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomImageList(CurrentObject).HandleAllocated;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Insert(VarToInteger(GetInputArg(0)),TBitmap(Integer(GetInputArg(1))),TBitmap(Integer(GetInputArg(2))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListInsertIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).InsertIcon(VarToInteger(GetInputArg(0)),TIcon(Integer(GetInputArg(1))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListInsertMasked(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).InsertMasked(VarToInteger(GetInputArg(0)),TBitmap(Integer(GetInputArg(1))),GetInputArg(2));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListMove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Move(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListOverlay(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomImageList(CurrentObject).Overlay(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListRegisterChanges(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).RegisterChanges(TChangeLink(Integer(GetInputArg(0))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListResourceLoad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomImageList(CurrentObject).ResourceLoad(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListResInstLoad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomImageList(CurrentObject).ResInstLoad(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImgListLibrary.__TCustomImageListReplace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Replace(VarToInteger(GetInputArg(0)),TBitmap(Integer(GetInputArg(1))),TBitmap(Integer(GetInputArg(2))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListReplaceIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).ReplaceIcon(VarToInteger(GetInputArg(0)),TIcon(Integer(GetInputArg(1))));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListReplaceMasked(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).ReplaceMasked(VarToInteger(GetInputArg(0)),TBitmap(Integer(GetInputArg(1))),GetInputArg(2));
  end;
end;

procedure TatImgListLibrary.__TCustomImageListUnRegisterChanges(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).UnRegisterChanges(TChangeLink(Integer(GetInputArg(0))));
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomImageList(CurrentObject).Count));
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomImageList(CurrentObject).Handle));
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Handle:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListAllocBy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomImageList(CurrentObject).AllocBy));
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListAllocBy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).AllocBy:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListBlendColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomImageList(CurrentObject).BlendColor);
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListBlendColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).BlendColor:=GetInputArg(0);
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListBkColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomImageList(CurrentObject).BkColor);
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListBkColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).BkColor:=GetInputArg(0);
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListDrawingStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomImageList(CurrentObject).DrawingStyle);
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListDrawingStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).DrawingStyle:=GetInputArg(0);
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomImageList(CurrentObject).Height));
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Height:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListImageType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomImageList(CurrentObject).ImageType);
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListImageType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).ImageType:=GetInputArg(0);
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListMasked(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomImageList(CurrentObject).Masked);
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListMasked(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Masked:=GetInputArg(0);
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListShareImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomImageList(CurrentObject).ShareImages);
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListShareImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).ShareImages:=GetInputArg(0);
  end;
end;

procedure TatImgListLibrary.__GetTCustomImageListWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomImageList(CurrentObject).Width));
  end;
end;

procedure TatImgListLibrary.__SetTCustomImageListWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomImageList(CurrentObject).Width:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatImgListLibrary.Init;
begin
  With Scripter.DefineClass(TChangeLink) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TChangeLinkDestroy,false,0);
    DefineMethod('Change',0,tkNone,nil,__TChangeLinkChange,false,0);
    DefineProp('Sender',tkClass,__GetTChangeLinkSender,__SetTChangeLinkSender,TCustomImageList,false,0);
  end;
  With Scripter.DefineClass(TCustomImageList) do
  begin
    DefineMethod('Create',1,tkClass,TCustomImageList,__TCustomImageListCreate,true,0);
    DefineMethod('CreateSize',2,tkClass,TCustomImageList,__TCustomImageListCreateSize,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomImageListDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TCustomImageListAssign,false,0);
    DefineMethod('Add',2,tkInteger,nil,__TCustomImageListAdd,false,0);
    DefineMethod('AddIcon',1,tkInteger,nil,__TCustomImageListAddIcon,false,0);
    DefineMethod('AddImages',1,tkNone,nil,__TCustomImageListAddImages,false,0);
    DefineMethod('AddMasked',2,tkInteger,nil,__TCustomImageListAddMasked,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomImageListClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TCustomImageListDelete,false,0);
    DefineMethod('Draw',5,tkNone,nil,__TCustomImageListDraw,false,1);
    DefineMethod('DrawOverlay',6,tkNone,nil,__TCustomImageListDrawOverlay,false,1);
    DefineMethod('FileLoad',3,tkVariant,nil,__TCustomImageListFileLoad,false,0);
    DefineMethod('GetBitmap',2,tkNone,nil,__TCustomImageListGetBitmap,false,0);
    DefineMethod('GetHotSpot',0,tkVariant,nil,__TCustomImageListGetHotSpot,false,0);
    DefineMethod('GetIcon',2,tkNone,nil,__TCustomImageListGetIcon,false,0);
    DefineMethod('GetImageBitmap',0,tkInteger,nil,__TCustomImageListGetImageBitmap,false,0);
    DefineMethod('GetMaskBitmap',0,tkInteger,nil,__TCustomImageListGetMaskBitmap,false,0);
    DefineMethod('GetResource',5,tkVariant,nil,__TCustomImageListGetResource,false,0);
    DefineMethod('GetInstRes',6,tkVariant,nil,__TCustomImageListGetInstRes,false,0);
    DefineMethod('HandleAllocated',0,tkVariant,nil,__TCustomImageListHandleAllocated,false,0);
    DefineMethod('Insert',3,tkNone,nil,__TCustomImageListInsert,false,0);
    DefineMethod('InsertIcon',2,tkNone,nil,__TCustomImageListInsertIcon,false,0);
    DefineMethod('InsertMasked',3,tkNone,nil,__TCustomImageListInsertMasked,false,0);
    DefineMethod('Move',2,tkNone,nil,__TCustomImageListMove,false,0);
    DefineMethod('Overlay',2,tkVariant,nil,__TCustomImageListOverlay,false,0);
    DefineMethod('RegisterChanges',1,tkNone,nil,__TCustomImageListRegisterChanges,false,0);
    DefineMethod('ResourceLoad',3,tkVariant,nil,__TCustomImageListResourceLoad,false,0);
    DefineMethod('ResInstLoad',4,tkVariant,nil,__TCustomImageListResInstLoad,false,0);
    DefineMethod('Replace',3,tkNone,nil,__TCustomImageListReplace,false,0);
    DefineMethod('ReplaceIcon',2,tkNone,nil,__TCustomImageListReplaceIcon,false,0);
    DefineMethod('ReplaceMasked',3,tkNone,nil,__TCustomImageListReplaceMasked,false,0);
    DefineMethod('UnRegisterChanges',1,tkNone,nil,__TCustomImageListUnRegisterChanges,false,0);
    DefineProp('Count',tkInteger,__GetTCustomImageListCount,nil,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTCustomImageListHandle,__SetTCustomImageListHandle,nil,false,0);
    DefineProp('AllocBy',tkInteger,__GetTCustomImageListAllocBy,__SetTCustomImageListAllocBy,nil,false,0);
    DefineProp('BlendColor',tkEnumeration,__GetTCustomImageListBlendColor,__SetTCustomImageListBlendColor,nil,false,0);
    DefineProp('BkColor',tkEnumeration,__GetTCustomImageListBkColor,__SetTCustomImageListBkColor,nil,false,0);
    DefineProp('DrawingStyle',tkEnumeration,__GetTCustomImageListDrawingStyle,__SetTCustomImageListDrawingStyle,nil,false,0);
    DefineProp('Height',tkInteger,__GetTCustomImageListHeight,__SetTCustomImageListHeight,nil,false,0);
    DefineProp('ImageType',tkEnumeration,__GetTCustomImageListImageType,__SetTCustomImageListImageType,nil,false,0);
    DefineProp('Masked',tkVariant,__GetTCustomImageListMasked,__SetTCustomImageListMasked,nil,false,0);
    DefineProp('ShareImages',tkVariant,__GetTCustomImageListShareImages,__SetTCustomImageListShareImages,nil,false,0);
    DefineProp('Width',tkInteger,__GetTCustomImageListWidth,__SetTCustomImageListWidth,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('dsFocus',dsFocus);
    AddConstant('dsSelected',dsSelected);
    AddConstant('dsNormal',dsNormal);
    AddConstant('dsTransparent',dsTransparent);
    AddConstant('itImage',itImage);
    AddConstant('itMask',itMask);
    AddConstant('rtBitmap',rtBitmap);
    AddConstant('rtCursor',rtCursor);
    AddConstant('rtIcon',rtIcon);
    AddConstant('lrDefaultColor',lrDefaultColor);
    AddConstant('lrDefaultSize',lrDefaultSize);
    AddConstant('lrFromFile',lrFromFile);
    AddConstant('lrMap3DColors',lrMap3DColors);
    AddConstant('lrTransparent',lrTransparent);
    AddConstant('lrMonoChrome',lrMonoChrome);
  end;
end;

class function TatImgListLibrary.LibraryName: string;
begin
  result := 'ImgList';
end;

initialization
  RegisterScripterLibrary(TatImgListLibrary, True);

{$WARNINGS ON}

end.

