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
unit ap_DBGrids;

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Controls,
  Forms,
  StdCtrls,
  Graphics,
  Grids,
  DBCtrls,
  Db,
  Menus,
  ImgList,
  DBGrids,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatDBGridsLibrary = class(TatScripterLibrary)
    procedure __TColumnTitleCreate(AMachine: TatVirtualMachine);
    procedure __TColumnTitleDestroy(AMachine: TatVirtualMachine);
    procedure __TColumnTitleAssign(AMachine: TatVirtualMachine);
    procedure __TColumnTitleDefaultAlignment(AMachine: TatVirtualMachine);
    procedure __TColumnTitleDefaultColor(AMachine: TatVirtualMachine);
    procedure __TColumnTitleDefaultFont(AMachine: TatVirtualMachine);
    procedure __TColumnTitleDefaultCaption(AMachine: TatVirtualMachine);
    procedure __TColumnTitleRestoreDefaults(AMachine: TatVirtualMachine);
    procedure __GetTColumnTitleColumn(AMachine: TatVirtualMachine);
    procedure __TColumnCreate(AMachine: TatVirtualMachine);
    procedure __TColumnDestroy(AMachine: TatVirtualMachine);
    procedure __TColumnAssign(AMachine: TatVirtualMachine);
    procedure __TColumnDefaultAlignment(AMachine: TatVirtualMachine);
    procedure __TColumnDefaultColor(AMachine: TatVirtualMachine);
    procedure __TColumnDefaultFont(AMachine: TatVirtualMachine);
    procedure __TColumnDefaultImeMode(AMachine: TatVirtualMachine);
    procedure __TColumnDefaultImeName(AMachine: TatVirtualMachine);
    procedure __TColumnDefaultReadOnly(AMachine: TatVirtualMachine);
    procedure __TColumnDefaultWidth(AMachine: TatVirtualMachine);
    procedure __TColumnDepth(AMachine: TatVirtualMachine);
    procedure __TColumnRestoreDefaults(AMachine: TatVirtualMachine);
    procedure __GetTColumnGrid(AMachine: TatVirtualMachine);
    procedure __GetTColumnAssignedValues(AMachine: TatVirtualMachine);
    procedure __GetTColumnExpandable(AMachine: TatVirtualMachine);
    procedure __GetTColumnField(AMachine: TatVirtualMachine);
    procedure __SetTColumnField(AMachine: TatVirtualMachine);
    procedure __GetTColumnParentColumn(AMachine: TatVirtualMachine);
    procedure __GetTColumnShowing(AMachine: TatVirtualMachine);
    procedure __TDBGridColumnsAdd(AMachine: TatVirtualMachine);
    procedure __TDBGridColumnsLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TDBGridColumnsLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TDBGridColumnsRestoreDefaults(AMachine: TatVirtualMachine);
    procedure __TDBGridColumnsRebuildColumns(AMachine: TatVirtualMachine);
    procedure __TDBGridColumnsSaveToFile(AMachine: TatVirtualMachine);
    procedure __TDBGridColumnsSaveToStream(AMachine: TatVirtualMachine);
    procedure __GetTDBGridColumnsState(AMachine: TatVirtualMachine);
    procedure __SetTDBGridColumnsState(AMachine: TatVirtualMachine);
    procedure __GetTDBGridColumnsGrid(AMachine: TatVirtualMachine);
    procedure __GetTDBGridColumnsItems(AMachine: TatVirtualMachine);
    procedure __SetTDBGridColumnsItems(AMachine: TatVirtualMachine);
    procedure __TGridDataLinkCreate(AMachine: TatVirtualMachine);
    procedure __TGridDataLinkDestroy(AMachine: TatVirtualMachine);
    procedure __TGridDataLinkAddMapping(AMachine: TatVirtualMachine);
    procedure __TGridDataLinkClearMapping(AMachine: TatVirtualMachine);
    procedure __TGridDataLinkModified(AMachine: TatVirtualMachine);
    procedure __TGridDataLinkReset(AMachine: TatVirtualMachine);
    procedure __GetTGridDataLinkDefaultFields(AMachine: TatVirtualMachine);
    procedure __GetTGridDataLinkFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTGridDataLinkFields(AMachine: TatVirtualMachine);
    procedure __GetTGridDataLinkSparseMap(AMachine: TatVirtualMachine);
    procedure __SetTGridDataLinkSparseMap(AMachine: TatVirtualMachine);
    procedure __TBookmarkListCreate(AMachine: TatVirtualMachine);
    procedure __TBookmarkListDestroy(AMachine: TatVirtualMachine);
    procedure __TBookmarkListClear(AMachine: TatVirtualMachine);
    procedure __TBookmarkListDelete(AMachine: TatVirtualMachine);
    procedure __TBookmarkListFind(AMachine: TatVirtualMachine);
    procedure __TBookmarkListIndexOf(AMachine: TatVirtualMachine);
    procedure __TBookmarkListRefresh(AMachine: TatVirtualMachine);
    procedure __GetTBookmarkListCount(AMachine: TatVirtualMachine);
    procedure __GetTBookmarkListCurrentRowSelected(AMachine: TatVirtualMachine);
    procedure __SetTBookmarkListCurrentRowSelected(AMachine: TatVirtualMachine);
    procedure __GetTBookmarkListItems(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridCreate(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridDefaultDrawDataCell(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridDefaultDrawColumnCell(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridDefaultHandler(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridExecuteAction(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridShowPopupEditor(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridUpdateAction(AMachine: TatVirtualMachine);
    procedure __TCustomDBGridValidFieldIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomDBGridFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomDBGridFields(AMachine: TatVirtualMachine);
    procedure __GetTCustomDBGridSelectedField(AMachine: TatVirtualMachine);
    procedure __SetTCustomDBGridSelectedField(AMachine: TatVirtualMachine);
    procedure __GetTCustomDBGridSelectedIndex(AMachine: TatVirtualMachine);
    procedure __SetTCustomDBGridSelectedIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomDBGridDataSource(AMachine: TatVirtualMachine);
    procedure __SetTCustomDBGridDataSource(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TColumnTitleClass = class of TColumnTitle;
  TColumnClass = class of TColumn;
  TDBGridColumnsClass = class of TDBGridColumns;
  TGridDataLinkClass = class of TGridDataLink;
  TBookmarkListClass = class of TBookmarkList;
  TCustomDBGridClass = class of TCustomDBGrid;
  TDBGridClass = class of TDBGrid;

  TatDBGridsDispatcher = class(TatEventDispatcher)
  private
    procedure __TDBGridClickEvent( Column: TColumn);
  end;


implementation



procedure TatDBGridsLibrary.__TColumnTitleCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColumnTitleClass(CurrentClass.ClassRef).Create(TColumn(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnTitleDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColumnTitle(CurrentObject).Destroy;
  end;
end;

procedure TatDBGridsLibrary.__TColumnTitleAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColumnTitle(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBGridsLibrary.__TColumnTitleDefaultAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColumnTitle(CurrentObject).DefaultAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnTitleDefaultColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColumnTitle(CurrentObject).DefaultColor;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnTitleDefaultFont(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColumnTitle(CurrentObject).DefaultFont);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnTitleDefaultCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColumnTitle(CurrentObject).DefaultCaption;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnTitleRestoreDefaults(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColumnTitle(CurrentObject).RestoreDefaults;
  end;
end;

procedure TatDBGridsLibrary.__GetTColumnTitleColumn(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TColumnTitle(CurrentObject).Column));
  end;
end;

procedure TatDBGridsLibrary.__TColumnCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColumnClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColumn(CurrentObject).Destroy;
  end;
end;

procedure TatDBGridsLibrary.__TColumnAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColumn(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBGridsLibrary.__TColumnDefaultAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColumn(CurrentObject).DefaultAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnDefaultColor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColumn(CurrentObject).DefaultColor;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnDefaultFont(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColumn(CurrentObject).DefaultFont);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnDefaultImeMode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColumn(CurrentObject).DefaultImeMode;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnDefaultImeName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColumn(CurrentObject).DefaultImeName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnDefaultReadOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColumn(CurrentObject).DefaultReadOnly;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnDefaultWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColumn(CurrentObject).DefaultWidth);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnDepth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColumn(CurrentObject).Depth);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TColumnRestoreDefaults(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColumn(CurrentObject).RestoreDefaults;
  end;
end;

procedure TatDBGridsLibrary.__GetTColumnGrid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TColumn(CurrentObject).Grid));
  end;
end;

procedure TatDBGridsLibrary.__GetTColumnAssignedValues(AMachine: TatVirtualMachine);
var
PropValueSet: TColumnValues;
begin
  with AMachine do
  begin
    PropValueSet := TColumn(CurrentObject).AssignedValues;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBGridsLibrary.__GetTColumnExpandable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TColumn(CurrentObject).Expandable);
  end;
end;

procedure TatDBGridsLibrary.__GetTColumnField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TColumn(CurrentObject).Field));
  end;
end;

procedure TatDBGridsLibrary.__SetTColumnField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColumn(CurrentObject).Field:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBGridsLibrary.__GetTColumnParentColumn(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TColumn(CurrentObject).ParentColumn));
  end;
end;

procedure TatDBGridsLibrary.__GetTColumnShowing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TColumn(CurrentObject).Showing);
  end;
end;

procedure TatDBGridsLibrary.__TDBGridColumnsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBGridColumns(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TDBGridColumnsLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBGridColumns(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatDBGridsLibrary.__TDBGridColumnsLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBGridColumns(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBGridsLibrary.__TDBGridColumnsRestoreDefaults(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBGridColumns(CurrentObject).RestoreDefaults;
  end;
end;

procedure TatDBGridsLibrary.__TDBGridColumnsRebuildColumns(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBGridColumns(CurrentObject).RebuildColumns;
  end;
end;

procedure TatDBGridsLibrary.__TDBGridColumnsSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBGridColumns(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatDBGridsLibrary.__TDBGridColumnsSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBGridColumns(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBGridsLibrary.__GetTDBGridColumnsState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBGridColumns(CurrentObject).State);
  end;
end;

procedure TatDBGridsLibrary.__SetTDBGridColumnsState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBGridColumns(CurrentObject).State:=GetInputArg(0);
  end;
end;

procedure TatDBGridsLibrary.__GetTDBGridColumnsGrid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBGridColumns(CurrentObject).Grid));
  end;
end;

procedure TatDBGridsLibrary.__GetTDBGridColumnsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBGridColumns(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBGridsLibrary.__SetTDBGridColumnsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBGridColumns(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TColumn(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBGridsLibrary.__TGridDataLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGridDataLinkClass(CurrentClass.ClassRef).Create(TCustomDBGrid(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TGridDataLinkDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGridDataLink(CurrentObject).Destroy;
  end;
end;

procedure TatDBGridsLibrary.__TGridDataLinkAddMapping(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TGridDataLink(CurrentObject).AddMapping(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TGridDataLinkClearMapping(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGridDataLink(CurrentObject).ClearMapping;
  end;
end;

procedure TatDBGridsLibrary.__TGridDataLinkModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGridDataLink(CurrentObject).Modified;
  end;
end;

procedure TatDBGridsLibrary.__TGridDataLinkReset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGridDataLink(CurrentObject).Reset;
  end;
end;

procedure TatDBGridsLibrary.__GetTGridDataLinkDefaultFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGridDataLink(CurrentObject).DefaultFields);
  end;
end;

procedure TatDBGridsLibrary.__GetTGridDataLinkFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGridDataLink(CurrentObject).FieldCount));
  end;
end;

procedure TatDBGridsLibrary.__GetTGridDataLinkFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGridDataLink(CurrentObject).Fields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBGridsLibrary.__GetTGridDataLinkSparseMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TGridDataLink(CurrentObject).SparseMap);
  end;
end;

procedure TatDBGridsLibrary.__SetTGridDataLinkSparseMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGridDataLink(CurrentObject).SparseMap:=GetInputArg(0);
  end;
end;

procedure TatDBGridsLibrary.__TBookmarkListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBookmarkListClass(CurrentClass.ClassRef).Create(TCustomDBGrid(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TBookmarkListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBookmarkList(CurrentObject).Destroy;
  end;
end;

procedure TatDBGridsLibrary.__TBookmarkListClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBookmarkList(CurrentObject).Clear;
  end;
end;

procedure TatDBGridsLibrary.__TBookmarkListDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBookmarkList(CurrentObject).Delete;
  end;
end;

procedure TatDBGridsLibrary.__TBookmarkListFind(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := TBookmarkList(CurrentObject).Find(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatDBGridsLibrary.__TBookmarkListIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBookmarkList(CurrentObject).IndexOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TBookmarkListRefresh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBookmarkList(CurrentObject).Refresh;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__GetTBookmarkListCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBookmarkList(CurrentObject).Count));
  end;
end;

procedure TatDBGridsLibrary.__GetTBookmarkListCurrentRowSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBookmarkList(CurrentObject).CurrentRowSelected);
  end;
end;

procedure TatDBGridsLibrary.__SetTBookmarkListCurrentRowSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBookmarkList(CurrentObject).CurrentRowSelected:=GetInputArg(0);
  end;
end;

procedure TatDBGridsLibrary.__GetTBookmarkListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBookmarkList(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomDBGridClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomDBGrid(CurrentObject).Destroy;
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridDefaultDrawDataCell(AMachine: TatVirtualMachine);
  var
  Param2: TGridDrawState;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
    TCustomDBGrid(CurrentObject).DefaultDrawDataCell(TRectWrapper(integer(GetInputArg(0))).ObjToRec,TField(Integer(GetInputArg(1))),Param2);
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridDefaultDrawColumnCell(AMachine: TatVirtualMachine);
  var
  Param3: TGridDrawState;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
    TCustomDBGrid(CurrentObject).DefaultDrawColumnCell(TRectWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),TColumn(Integer(GetInputArg(2))),Param3);
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TCustomDBGrid(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomDBGrid(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridShowPopupEditor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TCustomDBGrid(CurrentObject).ShowPopupEditor(TColumn(Integer(GetInputArg(0))));
      2: TCustomDBGrid(CurrentObject).ShowPopupEditor(TColumn(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)));
      3: TCustomDBGrid(CurrentObject).ShowPopupEditor(TColumn(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    end;
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomDBGrid(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__TCustomDBGridValidFieldIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomDBGrid(CurrentObject).ValidFieldIndex(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBGridsLibrary.__GetTCustomDBGridFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomDBGrid(CurrentObject).FieldCount));
  end;
end;

procedure TatDBGridsLibrary.__GetTCustomDBGridFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomDBGrid(CurrentObject).Fields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBGridsLibrary.__GetTCustomDBGridSelectedField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomDBGrid(CurrentObject).SelectedField));
  end;
end;

procedure TatDBGridsLibrary.__SetTCustomDBGridSelectedField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomDBGrid(CurrentObject).SelectedField:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBGridsLibrary.__GetTCustomDBGridSelectedIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomDBGrid(CurrentObject).SelectedIndex));
  end;
end;

procedure TatDBGridsLibrary.__SetTCustomDBGridSelectedIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomDBGrid(CurrentObject).SelectedIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBGridsLibrary.__GetTCustomDBGridDataSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomDBGrid(CurrentObject).DataSource));
  end;
end;

procedure TatDBGridsLibrary.__SetTCustomDBGridDataSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomDBGrid(CurrentObject).DataSource:=TDataSource(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBGridsDispatcher.__TDBGridClickEvent( Column: TColumn);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDBGridClickEvent(BeforeCall)(Column);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Column]);
    if AssignedMethod(AfterCall) then
      TDBGridClickEvent(AfterCall)(Column);
  end;
end;

procedure TatDBGridsLibrary.Init;
begin
  With Scripter.DefineClass(TColumnTitle) do
  begin
    DefineMethod('Create',1,tkClass,TColumnTitle,__TColumnTitleCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TColumnTitleDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TColumnTitleAssign,false,0);
    DefineMethod('DefaultAlignment',0,tkEnumeration,nil,__TColumnTitleDefaultAlignment,false,0);
    DefineMethod('DefaultColor',0,tkEnumeration,nil,__TColumnTitleDefaultColor,false,0);
    DefineMethod('DefaultFont',0,tkClass,TFont,__TColumnTitleDefaultFont,false,0);
    DefineMethod('DefaultCaption',0,tkVariant,nil,__TColumnTitleDefaultCaption,false,0);
    DefineMethod('RestoreDefaults',0,tkNone,nil,__TColumnTitleRestoreDefaults,false,0);
    DefineProp('Column',tkClass,__GetTColumnTitleColumn,nil,TColumn,false,0);
  end;
  With Scripter.DefineClass(TColumn) do
  begin
    DefineMethod('Create',1,tkClass,TColumn,__TColumnCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TColumnDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TColumnAssign,false,0);
    DefineMethod('DefaultAlignment',0,tkEnumeration,nil,__TColumnDefaultAlignment,false,0);
    DefineMethod('DefaultColor',0,tkEnumeration,nil,__TColumnDefaultColor,false,0);
    DefineMethod('DefaultFont',0,tkClass,TFont,__TColumnDefaultFont,false,0);
    DefineMethod('DefaultImeMode',0,tkEnumeration,nil,__TColumnDefaultImeMode,false,0);
    DefineMethod('DefaultImeName',0,tkVariant,nil,__TColumnDefaultImeName,false,0);
    DefineMethod('DefaultReadOnly',0,tkVariant,nil,__TColumnDefaultReadOnly,false,0);
    DefineMethod('DefaultWidth',0,tkInteger,nil,__TColumnDefaultWidth,false,0);
    DefineMethod('Depth',0,tkInteger,nil,__TColumnDepth,false,0);
    DefineMethod('RestoreDefaults',0,tkNone,nil,__TColumnRestoreDefaults,false,0);
    DefineProp('Grid',tkClass,__GetTColumnGrid,nil,TCustomDBGrid,false,0);
    DefineProp('AssignedValues',tkInteger,__GetTColumnAssignedValues,nil,nil,false,0);
    DefineProp('Expandable',tkVariant,__GetTColumnExpandable,nil,nil,false,0);
    DefineProp('Field',tkClass,__GetTColumnField,__SetTColumnField,TField,false,0);
    DefineProp('ParentColumn',tkClass,__GetTColumnParentColumn,nil,TColumn,false,0);
    DefineProp('Showing',tkVariant,__GetTColumnShowing,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDBGridColumns) do
  begin
    DefineMethod('Add',0,tkClass,TColumn,__TDBGridColumnsAdd,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TDBGridColumnsLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TDBGridColumnsLoadFromStream,false,0);
    DefineMethod('RestoreDefaults',0,tkNone,nil,__TDBGridColumnsRestoreDefaults,false,0);
    DefineMethod('RebuildColumns',0,tkNone,nil,__TDBGridColumnsRebuildColumns,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TDBGridColumnsSaveToFile,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TDBGridColumnsSaveToStream,false,0);
    DefineProp('State',tkEnumeration,__GetTDBGridColumnsState,__SetTDBGridColumnsState,nil,false,0);
    DefineProp('Grid',tkClass,__GetTDBGridColumnsGrid,nil,TCustomDBGrid,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTDBGridColumnsItems,__SetTDBGridColumnsItems,TColumn,false,1);
  end;
  With Scripter.DefineClass(TGridDataLink) do
  begin
    DefineMethod('Create',1,tkClass,TGridDataLink,__TGridDataLinkCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGridDataLinkDestroy,false,0);
    DefineMethod('AddMapping',1,tkVariant,nil,__TGridDataLinkAddMapping,false,0);
    DefineMethod('ClearMapping',0,tkNone,nil,__TGridDataLinkClearMapping,false,0);
    DefineMethod('Modified',0,tkNone,nil,__TGridDataLinkModified,false,0);
    DefineMethod('Reset',0,tkNone,nil,__TGridDataLinkReset,false,0);
    DefineProp('DefaultFields',tkVariant,__GetTGridDataLinkDefaultFields,nil,nil,false,0);
    DefineProp('FieldCount',tkInteger,__GetTGridDataLinkFieldCount,nil,nil,false,0);
    DefineProp('Fields',tkClass,__GetTGridDataLinkFields,nil,TField,false,1);
    DefineProp('SparseMap',tkVariant,__GetTGridDataLinkSparseMap,__SetTGridDataLinkSparseMap,nil,false,0);
  end;
  With Scripter.DefineClass(TBookmarkList) do
  begin
    DefineMethod('Create',1,tkClass,TBookmarkList,__TBookmarkListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TBookmarkListDestroy,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TBookmarkListClear,false,0);
    DefineMethod('Delete',0,tkNone,nil,__TBookmarkListDelete,false,0);
    DefineMethod('Find',2,tkVariant,nil,__TBookmarkListFind,false,0).SetVarArgs([1]);
    DefineMethod('IndexOf',1,tkInteger,nil,__TBookmarkListIndexOf,false,0);
    DefineMethod('Refresh',0,tkVariant,nil,__TBookmarkListRefresh,false,0);
    DefineProp('Count',tkInteger,__GetTBookmarkListCount,nil,nil,false,0);
    DefineProp('CurrentRowSelected',tkVariant,__GetTBookmarkListCurrentRowSelected,__SetTBookmarkListCurrentRowSelected,nil,false,0);
    DefaultProperty := DefineProp('Items',tkVariant,__GetTBookmarkListItems,nil,nil,false,1);
  end;
  With Scripter.DefineClass(TCustomDBGrid) do
  begin
    DefineMethod('Create',1,tkClass,TCustomDBGrid,__TCustomDBGridCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomDBGridDestroy,false,0);
    DefineMethod('DefaultDrawDataCell',3,tkNone,nil,__TCustomDBGridDefaultDrawDataCell,false,0);
    DefineMethod('DefaultDrawColumnCell',4,tkNone,nil,__TCustomDBGridDefaultDrawColumnCell,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TCustomDBGridDefaultHandler,false,0).SetVarArgs([0]);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TCustomDBGridExecuteAction,false,0);
    DefineMethod('ShowPopupEditor',3,tkNone,nil,__TCustomDBGridShowPopupEditor,false,2);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TCustomDBGridUpdateAction,false,0);
    DefineMethod('ValidFieldIndex',1,tkVariant,nil,__TCustomDBGridValidFieldIndex,false,0);
    DefineProp('EditorMode',tkVariant,nil,nil,nil,false,0);
    DefineProp('FieldCount',tkInteger,__GetTCustomDBGridFieldCount,nil,nil,false,0);
    DefineProp('Fields',tkClass,__GetTCustomDBGridFields,nil,TField,false,1);
    DefineProp('SelectedField',tkClass,__GetTCustomDBGridSelectedField,__SetTCustomDBGridSelectedField,TField,false,0);
    DefineProp('SelectedIndex',tkInteger,__GetTCustomDBGridSelectedIndex,__SetTCustomDBGridSelectedIndex,nil,false,0);
    DefineProp('DataSource',tkClass,__GetTCustomDBGridDataSource,__SetTCustomDBGridDataSource,TDataSource,false,0);
  end;
  With Scripter.DefineClass(TDBGrid) do
  begin
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
    DefineProp('SelectedRows',tkVariant,nil,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TDBGridClickEvent), TatDBGridsDispatcher, @TatDBGridsDispatcher.__TDBGridClickEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('cvColor',cvColor);
    AddConstant('cvWidth',cvWidth);
    AddConstant('cvFont',cvFont);
    AddConstant('cvAlignment',cvAlignment);
    AddConstant('cvReadOnly',cvReadOnly);
    AddConstant('cvTitleColor',cvTitleColor);
    AddConstant('cvTitleCaption',cvTitleCaption);
    AddConstant('cvTitleAlignment',cvTitleAlignment);
    AddConstant('cvTitleFont',cvTitleFont);
    AddConstant('cvImeMode',cvImeMode);
    AddConstant('cvImeName',cvImeName);
    AddConstant('cbsAuto',cbsAuto);
    AddConstant('cbsEllipsis',cbsEllipsis);
    AddConstant('cbsNone',cbsNone);
    AddConstant('csDefault',csDefault);
    AddConstant('csCustomized',csCustomized);
    AddConstant('dgEditing',dgEditing);
    AddConstant('dgAlwaysShowEditor',dgAlwaysShowEditor);
    AddConstant('dgTitles',dgTitles);
    AddConstant('dgIndicator',dgIndicator);
    AddConstant('dgColumnResize',dgColumnResize);
    AddConstant('dgColLines',dgColLines);
    AddConstant('dgRowLines',dgRowLines);
    AddConstant('dgTabs',dgTabs);
    AddConstant('dgRowSelect',dgRowSelect);
    AddConstant('dgAlwaysShowSelection',dgAlwaysShowSelection);
    AddConstant('dgConfirmDelete',dgConfirmDelete);
    AddConstant('dgCancelOnExit',dgCancelOnExit);
    AddConstant('dgMultiSelect',dgMultiSelect);
    AddConstant('ColumnTitleValues',IntFromConstSet(ColumnTitleValues));
    AddConstant('cm_DeferLayout',cm_DeferLayout);
    AddConstant('IndicatorWidth',IndicatorWidth);
  end;
end;

class function TatDBGridsLibrary.LibraryName: string;
begin
  result := 'DBGrids';
end;

initialization
  RegisterScripterLibrary(TatDBGridsLibrary, True);

{$WARNINGS ON}

end.

