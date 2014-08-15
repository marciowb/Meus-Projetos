{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Objects Dispatch Implementor                                }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit cxWebDispImp;

interface

{$I cxVer.inc}

uses cxScriptDispImpl, SysUtils, Classes,
  cxWebClasses, cxWebControls, cxWebMenus, cxWebMainMenu, cxWebData,
  cxWebGrids, cxWebTV;

type
  TcxScriptDispWebComponentImpl_Empty = procedure of object;

  TcxWebComponentImpl = class(TcxScriptDispImpl)
  private
  protected
    function WebComponent: TcxWebComponent;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
  end;

  TcxScriptDispWebControlImpl_SetBounds = procedure (ALeft, ATop, AWidth, AHeight: Integer) of object;

  TcxWebControlImpl = class(TcxWebComponentImpl)
  private
    FDispatch_Hide: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_SetBounds: TcxScriptDispWebControlImpl_SetBounds;
    FDispatch_Show: TcxScriptDispWebComponentImpl_Empty;
    procedure Dispatch_Hide;
    procedure Dispatch_SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
    procedure Dispatch_Show;
  protected
    function WebControl: TcxWebControl;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property Hide: TcxScriptDispWebComponentImpl_Empty read FDispatch_Hide;
    property SetBounds: TcxScriptDispWebControlImpl_SetBounds read FDispatch_SetBounds;
    property Show: TcxScriptDispWebComponentImpl_Empty read FDispatch_Show;
  end;


  TcxScriptDispWebControlImpl_Count = function: Integer of object;
  TcxScriptDispWebControlImpl_WebControls = function(Index: Integer): TcxWebControl of object;
  TcxScriptDispWebControlImpl_WebContainerControls = function(Index: Integer): TcxWebContainerControl of object;

  TcxWebContainerControlImpl = class(TcxWebControlImpl)
  private
    FDispatch_WebControlContainerCount: TcxScriptDispWebControlImpl_Count;
    FDispatch_WebControlContainers: TcxScriptDispWebControlImpl_WebContainerControls;
    FDispatch_WebControlCount: TcxScriptDispWebControlImpl_Count;
    FDispatch_WebControls: TcxScriptDispWebControlImpl_WebControls;
    function Dispatch_WebControlContainerCount: Integer;
    function Dispatch_WebControlContainers(Index: Integer): TcxWebContainerControl;
    function Dispatch_WebControlCount: Integer;
    function Dispatch_WebControls(Index: Integer): TcxWebControl;
  protected
    function WebContainerControl: TcxWebContainerControl;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property WebControlContainerCount: TcxScriptDispWebControlImpl_Count read FDispatch_WebControlContainerCount;
    property WebControlContainers: TcxScriptDispWebControlImpl_WebContainerControls read FDispatch_WebControlContainers;
    property WebControlCount: TcxScriptDispWebControlImpl_Count read FDispatch_WebControlCount;
    property WebControls: TcxScriptDispWebControlImpl_WebControls read FDispatch_WebControls;
  end;

  TcxScriptDispWebMenuImpl_ItemByName = function(AName: string): TcxWebMenuItem of object;

  TcxWebPopupMenuImpl = class(TcxWebComponentImpl)
  private
    FDispatch_ItemByName: TcxScriptDispWebMenuImpl_ItemByName;
    function Dispatch_ItemByName(AName: string): TcxWebMenuItem;
  protected
    function WebPopupMenu: TcxWebPopupMenu;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property ItemByName: TcxScriptDispWebMenuImpl_ItemByName read FDispatch_ItemByName;
  end;

  TcxWebMainMenuImpl = class(TcxWebControlImpl)
  private
    FDispatch_ItemByName: TcxScriptDispWebMenuImpl_ItemByName;
    function Dispatch_ItemByName(AName: string): TcxWebMenuItem;
  protected
    function WebMainMenu: TcxWebMainMenu;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property ItemByName: TcxScriptDispWebMenuImpl_ItemByName read FDispatch_ItemByName;
  end;

  TcxScriptDispWebMenuItem_Add = function : TcxWebMenuItem of object;
  TcxScriptDispWebMenuItem_Delete = procedure(Index: Integer) of object;
  TcxScriptDispWebMenuItem_IndexOf = function(Item: TcxWebMenuItem): Integer of object;
  TcxScriptDispWebMenuItem_Insert = procedure(Index: Integer; Item: TcxWebMenuItem) of object;
  TcxScriptDispWebMenuItem_Remove = procedure(Item: TcxWebMenuItem) of object;
  TcxScriptDispWebMenuItem_Items = function(Index: Integer): TcxWebMenuItem of object;

  TcxWebMenuItemImpl = class(TcxScriptDispImpl)
  private
    FDispatch_Add: TcxScriptDispWebMenuItem_Add;
    FDispatch_Clear: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_Delete: TcxScriptDispWebMenuItem_Delete;
    FDispatch_IndexOf: TcxScriptDispWebMenuItem_IndexOf;
    FDispatch_Insert: TcxScriptDispWebMenuItem_Insert;
    FDispatch_ItemByName: TcxScriptDispWebMenuImpl_ItemByName;
    FDispatch_Remove: TcxScriptDispWebMenuItem_Remove;
    FDispatch_Items: TcxScriptDispWebMenuItem_Items;

    function Dispatch_Add: TcxWebMenuItem;
    procedure Dispatch_Clear;
    procedure Dispatch_Delete(Index: Integer);
    function Dispatch_IndexOf(Item: TcxWebMenuItem): Integer;
    procedure Dispatch_Insert(Index: Integer; Item: TcxWebMenuItem);
    function Dispatch_ItemByName(AName: string): TcxWebMenuItem;
    procedure Dispatch_Remove(Item: TcxWebMenuItem);
    function Dispatch_Items(Index: Integer): TcxWebMenuItem;

    function GetCount: Integer;
    function GetIndex: Integer;
    function GetParent: TcxWebMenuItem;
    function GetParentMenu: TcxWebComponent;
    procedure SetIndex(Value: Integer);
  protected
    function WebMenuItem: TcxWebMenuItem;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property Add: TcxScriptDispWebMenuItem_Add read FDispatch_Add;
    property Clear: TcxScriptDispWebComponentImpl_Empty read FDispatch_Clear;
    property Delete: TcxScriptDispWebMenuItem_Delete read FDispatch_Delete;
    property IndexOf: TcxScriptDispWebMenuItem_IndexOf read FDispatch_IndexOf;
    property Insert: TcxScriptDispWebMenuItem_Insert read FDispatch_Insert;
    property ItemByName: TcxScriptDispWebMenuImpl_ItemByName read FDispatch_ItemByName;
    property Remove: TcxScriptDispWebMenuItem_Remove read FDispatch_Remove;

    property Count: Integer read GetCount;
    property Items: TcxScriptDispWebMenuItem_Items read FDispatch_Items;
    property Index: Integer read GetIndex write SetIndex;
    property Parent: TcxWebMenuItem read GetParent;
    property ParentMenu: TcxWebComponent read GetParentMenu;
  end;

  TcxScriptDispWebDataSourceImpl_RowIndex = procedure(ARowIndex: Integer) of object;
  TcxScriptDispWebDataSourceImpl_FieldByName = function(Name: string): TcxCustomWebDataField of object;
  TcxScriptDispWebDataSourceImpl_DisplayText = function(RowIndex, ItemIndex: Integer): string of object;
  TcxScriptDispWebDataSourceImpl_Value = function(RowIndex, ItemIndex: Integer): Variant of object;
  TcxScriptDispWebDataSourceImpl_RowExpanded = function(RowIndex: Integer): Boolean of object;
  TcxScriptDispWebDataSourceImpl_RowLevel = function(RowIndex: Integer): Integer of object;
  TcxScriptDispWebDataSourceImpl_RowRecord = function(RowIndex: Integer): Integer of object;
  TcxScriptDispWebDataSourceImpl_ItemIndex = function(Item: Integer): Integer of object;
  TcxScriptDispWebDataSourceImpl_ItemGropuIndex = function(ItemIndex: Integer): Integer of object;
  TcxScriptDispWebDataSourceImpl_ItemSortOrder = function(ItemIndex: Integer): TcxWebDataSortOrder of object;
  TcxScriptDispWebDataSourceImpl_Expand = procedure (ARowIndex: Integer; AExpanded, ARecursive: Boolean) of object;
  TcxScriptDispWebDataSourceImpl_Group = procedure (GroupField, GroupIndex: Integer) of object;
  TcxScriptDispWebDataSourceImpl_PostEdit = procedure (APriorControlName: string) of object;
  TcxScriptDispWebDataSourceImpl_SetEditValue = procedure (AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes) of object;
  TcxScriptDispWebDataSourceImpl_Sort = procedure (SortIndex: Integer; SortOrder: TcxWebDataSortOrder) of object;
  TcxScriptDispWebDataSourceImpl_UnGroup = procedure (UnGroupIndex: Integer) of object;

  TcxWebDataSourceImpl = class(TcxWebComponentImpl)
  private
    FDispatch_FieldByName: TcxScriptDispWebDataSourceImpl_FieldByName;
    FDispatch_GetRowDisplayText: TcxScriptDispWebDataSourceImpl_DisplayText;
    FDispatch_GetRowValue: TcxScriptDispWebDataSourceImpl_Value;
    FDispatch_GetRowExpanded: TcxScriptDispWebDataSourceImpl_RowExpanded;
    FDispatch_GetRowLevel: TcxScriptDispWebDataSourceImpl_RowLevel;
    FDispatch_GetRowRecord: TcxScriptDispWebDataSourceImpl_RowRecord;
    FDispatch_GetItemGroupIndex: TcxScriptDispWebDataSourceImpl_ItemGropuIndex;
    FDispatch_GetItemSortOrder: TcxScriptDispWebDataSourceImpl_ItemSortOrder;
    FDispatch_GetGroupingItemIndex: TcxScriptDispWebDataSourceImpl_ItemIndex;
    FDispatch_GetSortingItemIndex: TcxScriptDispWebDataSourceImpl_ItemIndex;
    FDispatch_ClearGrouping: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_ClearSorting: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_FullCollapse: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_FullExpand: TcxScriptDispWebComponentImpl_Empty;

    FDispatch_DisplayTexts: TcxScriptDispWebDataSourceImpl_DisplayText;
    FDispatch_Values: TcxScriptDispWebDataSourceImpl_Value;

    FDispatch_CancelEdit: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_DeleteRecord: TcxScriptDispWebDataSourceImpl_RowIndex;
    FDispatch_InsertRecord: TcxScriptDispWebDataSourceImpl_RowIndex;
    FDispatch_EditRecord: TcxScriptDispWebDataSourceImpl_RowIndex;
    FDispatch_Expand: TcxScriptDispWebDataSourceImpl_Expand;
    FDispatch_Group: TcxScriptDispWebDataSourceImpl_Group;
    FDispatch_PostEdit: TcxScriptDispWebDataSourceImpl_PostEdit;
    FDispatch_SetEditValue: TcxScriptDispWebDataSourceImpl_SetEditValue;
    FDispatch_Sort: TcxScriptDispWebDataSourceImpl_Sort;
    FDispatch_UnGroup: TcxScriptDispWebDataSourceImpl_UnGroup;
    FDispatch_Refresh: TcxScriptDispWebComponentImpl_Empty;

    function Dispatch_FieldByName(Name: string): TcxCustomWebDataField;
    function Dispatch_GetRowDisplayText(RowIndex: Integer; ItemIndex: Integer): string;
    function Dispatch_GetRowValue(RowIndex: Integer; ItemIndex: Integer): Variant;
    function Dispatch_GetRowExpanded(RowIndex: Integer): Boolean;
    function Dispatch_GetRowLevel(RowIndex: Integer): Integer;
    function Dispatch_GetRowRecord(RowIndex: Integer): Integer;
    function GetGroupingItemCount_: Integer;
    function GetSortingItemCount_: Integer;
    function Dispatch_GetItemGroupIndex(ItemIndex: Integer): Integer;
    function Dispatch_GetItemSortOrder(ItemIndex: Integer): TcxWebDataSortOrder;
    function Dispatch_GetGroupingItemIndex(Item: Integer): Integer;
    function Dispatch_GetSortingItemIndex(Item: Integer): Integer;
    procedure Dispatch_ClearGrouping;
    procedure Dispatch_ClearSorting;
    procedure Dispatch_FullCollapse;
    procedure Dispatch_FullExpand;

    function Dispatch_DisplayTexts(RecordIndex, ItemIndex: Integer): string;
    function Dispatch_Values(RecordIndex, ItemIndex: Integer): Variant;

    procedure Dispatch_CancelEdit;
    procedure Dispatch_DeleteRecord(ARowIndex: Integer);
    procedure Dispatch_InsertRecord(ARowIndex: Integer);
    procedure Dispatch_EditRecord(ARowIndex: Integer);
    procedure Dispatch_Expand(ARowIndex: Integer; AExpanded, ARecursive: Boolean);
    procedure Dispatch_Group(GroupField, GroupIndex: Integer);
    procedure Dispatch_PostEdit(APriorControlName: string);
    procedure Dispatch_SetEditValue(AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes);
    procedure Dispatch_Sort(SortIndex: Integer; SortOrder: TcxWebDataSortOrder);
    procedure Dispatch_UnGroup(UnGroupIndex: Integer);
    procedure Dispatch_Refresh;

    function GetFocusedRowIndex: Integer;
    function GetRecordCount: Integer;
    function GetRowCount: Integer;
    procedure SetFocusedRowIndex(Value: Integer);
  protected
    function WebDataSource: TcxCustomWebDataSource;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property FieldByName: TcxScriptDispWebDataSourceImpl_FieldByName read FDispatch_FieldByName;
    property GetRowDisplayText: TcxScriptDispWebDataSourceImpl_DisplayText read FDispatch_GetRowDisplayText;
    property GetRowValue: TcxScriptDispWebDataSourceImpl_Value read FDispatch_GetRowValue;
    property GetRowExpanded: TcxScriptDispWebDataSourceImpl_RowExpanded read FDispatch_GetRowExpanded;
    property GetRowLevel: TcxScriptDispWebDataSourceImpl_RowLevel read FDispatch_GetRowLevel;
    property GetRowRecord: TcxScriptDispWebDataSourceImpl_RowRecord read FDispatch_GetRowRecord;
    property GetGroupingItemCount: Integer read GetGroupingItemCount_;
    property GetSortingItemCount: Integer read GetSortingItemCount_;
    property GetItemGroupIndex: TcxScriptDispWebDataSourceImpl_ItemGropuIndex read FDispatch_GetItemGroupIndex;
    property GetItemSortOrder: TcxScriptDispWebDataSourceImpl_ItemSortOrder read FDispatch_GetItemSortOrder;
    property GetGroupingItemIndex: TcxScriptDispWebDataSourceImpl_ItemIndex read FDispatch_GetGroupingItemIndex;
    property GetSortingItemIndex: TcxScriptDispWebDataSourceImpl_ItemIndex read FDispatch_GetSortingItemIndex;
    property ClearGrouping: TcxScriptDispWebComponentImpl_Empty read FDispatch_ClearGrouping;
    property ClearSorting: TcxScriptDispWebComponentImpl_Empty read FDispatch_ClearSorting;
    property FullCollapse: TcxScriptDispWebComponentImpl_Empty read FDispatch_FullCollapse;
    property FullExpand: TcxScriptDispWebComponentImpl_Empty read FDispatch_FullExpand;

    property DisplayTexts: TcxScriptDispWebDataSourceImpl_DisplayText read FDispatch_DisplayTexts;
    property FocusedRowIndex: Integer read GetFocusedRowIndex write SetFocusedRowIndex;
    property RecordCount: Integer read GetRecordCount;
    property RowCount: Integer read GetRowCount;
    property Values: TcxScriptDispWebDataSourceImpl_Value read FDispatch_Values;

    property CancelEdit: TcxScriptDispWebComponentImpl_Empty read FDispatch_CancelEdit;
    property DeleteRecord: TcxScriptDispWebDataSourceImpl_RowIndex read FDispatch_DeleteRecord;
    property InsertRecord: TcxScriptDispWebDataSourceImpl_RowIndex read FDispatch_InsertRecord;
    property EditRecord: TcxScriptDispWebDataSourceImpl_RowIndex read FDispatch_EditRecord;
    property Expand: TcxScriptDispWebDataSourceImpl_Expand read FDispatch_Expand;
    property Group: TcxScriptDispWebDataSourceImpl_Group read FDispatch_Group;
    property PostEdit: TcxScriptDispWebDataSourceImpl_PostEdit read FDispatch_PostEdit;
    property SetEditValue: TcxScriptDispWebDataSourceImpl_SetEditValue read FDispatch_SetEditValue;
    property Sort: TcxScriptDispWebDataSourceImpl_Sort read FDispatch_Sort;
    property UnGroup: TcxScriptDispWebDataSourceImpl_UnGroup read FDispatch_UnGroup;
    property Refresh: TcxScriptDispWebComponentImpl_Empty read FDispatch_Refresh;
  end;

  TcxScriptDispWebGridImpl_Add = function: TcxWebColumn of object;
  TcxScriptDispWebGridImpl_Delete = procedure (AIndex: Integer) of object;
  TcxScriptDispWebGridImpl_IndexOf = function(AItem: TcxWebColumn): Integer of object;
  TcxScriptDispWebGridImpl_ColumnByName = function(const AName: string): TcxWebColumn of object;
  TcxScriptDispWebGridImpl_SortOrder = function(ItemIndex: Integer): TcxWebGridSortMode of object;
  TcxScriptDispWebGridImpl_CanCreateDefaultColumns = function: Boolean of object;
  TcxScriptDispWebGridImpl_CreateDefaultColumns = procedure(ADeleteExistColumns: Boolean) of object;
  TcxScriptDispWebGridImpl_Columns = function(Index: Integer): TcxWebColumn of object;

  TcxWebGridImpl = class(TcxWebControlImpl)
  private
    FDispatch_Add: TcxScriptDispWebGridImpl_Add;
    FDispatch_Clear: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_Delete: TcxScriptDispWebGridImpl_Delete;
    FDispatch_IndexOf: TcxScriptDispWebGridImpl_IndexOf;
    FDispatch_ColumnByName: TcxScriptDispWebGridImpl_ColumnByName;
    FDispatch_CanCreateDefaultColumns: TcxScriptDispWebGridImpl_CanCreateDefaultColumns;
    FDispatch_CreateDefaultColumns: TcxScriptDispWebGridImpl_CreateDefaultColumns;
    FDispatch_GetRowDisplayText: TcxScriptDispWebDataSourceImpl_DisplayText;
    FDispatch_GetRowValue: TcxScriptDispWebDataSourceImpl_Value;
    FDispatch_GetRowExpanded: TcxScriptDispWebDataSourceImpl_RowExpanded;
    FDispatch_GetRowLevel: TcxScriptDispWebDataSourceImpl_RowLevel;
    FDispatch_GetRowRecord: TcxScriptDispWebDataSourceImpl_RowRecord;
    FDispatch_GetItemGroupIndex: TcxScriptDispWebDataSourceImpl_ItemGropuIndex;
    FDispatch_GetItemSortOrder: TcxScriptDispWebGridImpl_SortOrder;
    FDispatch_GetSortingItemIndex: TcxScriptDispWebDataSourceImpl_ItemIndex;
    FDispatch_GetGroupingItemIndex: TcxScriptDispWebDataSourceImpl_ItemIndex;
    FDispatch_Columns: TcxScriptDispWebGridImpl_Columns;

    function Dispatch_Add: TcxWebColumn;
    procedure Dispatch_Clear;
    procedure Dispatch_Delete(AIndex: Integer);
    function Dispatch_IndexOf(AItem: TcxWebColumn): Integer;
    function Dispatch_ColumnByName(const AName: string): TcxWebColumn;
    function Dispatch_CanCreateDefaultColumns: Boolean;
    procedure Dispatch_CreateDefaultColumns(ADeleteExistColumns: Boolean);
    function Dispatch_GetRowDisplayText(ARowIndex, AColIndex: Integer): string;
    function Dispatch_GetRowValue(ARowIndex, AColIndex: Integer): Variant;
    function Dispatch_GetRowExpanded(RowIndex: Integer): Boolean;
    function Dispatch_GetRowLevel(RowIndex: Integer): Integer;
    function Dispatch_GetRowRecord(RowIndex: Integer): Integer;
    function Dispatch_GetItemGroupIndex(AColIndex: Integer): Integer;
    function Dispatch_GetItemSortOrder(AColIndex: Integer): TcxWebGridSortMode;
    function Dispatch_GetSortingItemIndex(Item: Integer): Integer;
    function Dispatch_GetGroupingItemIndex(Item: Integer): Integer;
    function Dispatch_Columns(Index: Integer): TcxWebColumn;

    function GetColumnCount: Integer;
    function GetFirstVisibleRow: Integer;
    function GetFocusedRow: Integer;
    function GetGroupingItemCount_: Integer;
    function GetRecordCount: Integer;
    function GetRowCount: Integer;
    function GetSortingItemCount_: Integer;
  protected
    function WebGrid: TcxCustomWebGrid;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property Add: TcxScriptDispWebGridImpl_Add read FDispatch_Add;
    property Clear: TcxScriptDispWebComponentImpl_Empty read FDispatch_Clear;
    property Delete: TcxScriptDispWebGridImpl_Delete read FDispatch_Delete;
    property IndexOf: TcxScriptDispWebGridImpl_IndexOf read FDispatch_IndexOf;
    property ColumnByName: TcxScriptDispWebGridImpl_ColumnByName read FDispatch_ColumnByName;
    property CanCreateDefaultColumns: TcxScriptDispWebGridImpl_CanCreateDefaultColumns read FDispatch_CanCreateDefaultColumns;
    property CreateDefaultColumns: TcxScriptDispWebGridImpl_CreateDefaultColumns read FDispatch_CreateDefaultColumns;

    property GetRowDisplayText: TcxScriptDispWebDataSourceImpl_DisplayText read FDispatch_GetRowDisplayText;
    property GetRowValue: TcxScriptDispWebDataSourceImpl_Value read FDispatch_GetRowValue;
    property GetRowExpanded: TcxScriptDispWebDataSourceImpl_RowExpanded read FDispatch_GetRowExpanded;
    property GetRowLevel: TcxScriptDispWebDataSourceImpl_RowLevel read FDispatch_GetRowLevel;
    property GetRowRecord: TcxScriptDispWebDataSourceImpl_RowRecord read FDispatch_GetRowRecord;
    property GetGroupingItemCount: Integer read GetGroupingItemCount_;
    property GetSortingItemCount: Integer read GetSortingItemCount_;
    property GetItemGroupIndex: TcxScriptDispWebDataSourceImpl_ItemGropuIndex read FDispatch_GetItemGroupIndex;
    property GetItemSortOrder: TcxScriptDispWebGridImpl_SortOrder read FDispatch_GetItemSortOrder;
    property GetSortingItemIndex: TcxScriptDispWebDataSourceImpl_ItemIndex read FDispatch_GetSortingItemIndex;
    property GetGroupingItemIndex: TcxScriptDispWebDataSourceImpl_ItemIndex read FDispatch_GetGroupingItemIndex;

    property Columns: TcxScriptDispWebGridImpl_Columns read FDispatch_Columns;
    property ColumnCount: Integer read GetColumnCount;

    property FirstVisibleRow: Integer read GetFirstVisibleRow;
    property FocusedRow: Integer read GetFocusedRow;
    property RecordCount: Integer read GetRecordCount;
    property RowCount: Integer read GetRowCount;
  end;

  TcxScriptDispWebTreeViewImpl_AddItem = function: TcxWebTreeItem of object;
  TcxScriptDispWebTreeViewImpl_ItemByName = function(const AName: string): TcxWebTreeItem of object;
  TcxScriptDispWebTreeViewImpl_Items = function: TcxWebTreeItem of object;

  TcxWebTreeViewImpl = class(TcxWebControlImpl)
  private
    FDispatch_AddItem: TcxScriptDispWebTreeViewImpl_AddItem;
    FDispatch_Clear: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_FullCollapse: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_FullExpand: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_ItemByName: TcxScriptDispWebTreeViewImpl_ItemByName;
    FDispatch_Items: TcxScriptDispWebTreeViewImpl_Items;

    function Dispatch_AddItem: TcxWebTreeItem;
    procedure Dispatch_Clear;
    procedure Dispatch_FullCollapse;
    procedure Dispatch_FullExpand;
    function Dispatch_ItemByName(const AName: string): TcxWebTreeItem;
    function Dispatch_Items: TcxWebTreeItem;
  protected
    function WebTreeView: TcxWebTreeView;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property AddItem: TcxScriptDispWebTreeViewImpl_AddItem read FDispatch_AddItem;
    property Clear: TcxScriptDispWebComponentImpl_Empty read FDispatch_Clear;
    property FullCollapse: TcxScriptDispWebComponentImpl_Empty read FDispatch_FullCollapse;
    property FullExpand: TcxScriptDispWebComponentImpl_Empty read FDispatch_FullExpand;
    property ItemByName: TcxScriptDispWebTreeViewImpl_ItemByName read FDispatch_ItemByName;
    property Items: TcxScriptDispWebTreeViewImpl_Items read FDispatch_Items;
  end;

  TcxScriptDispWebTreeItemImpl_Collapse = procedure(ARecurse: Boolean) of object;
  TcxScriptDispWebTreeItemImpl_IndexOf = function(Value: TcxWebTreeItem): Integer of object;
  TcxScriptDispWebTreeItemImpl_InsertChild = function(BeforeItem: TcxWebTreeItem): TcxWebTreeItem of object;
  TcxScriptDispWebTreeItemImpl_Items = function(Index: Integer): TcxWebTreeItem of object;

  TcxWebTreeItemImpl = class(TcxScriptDispImpl)
  private
    FDispatch_AddChild: TcxScriptDispWebTreeViewImpl_AddItem;
    FDispatch_Collapse: TcxScriptDispWebTreeItemImpl_Collapse;
    FDispatch_DeleteChildren: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_Expand: TcxScriptDispWebTreeItemImpl_Collapse;
    FDispatch_IndexOf: TcxScriptDispWebTreeItemImpl_IndexOf;
    FDispatch_InsertChild: TcxScriptDispWebTreeItemImpl_InsertChild;
    FDispatch_Items: TcxScriptDispWebTreeItemImpl_Items;

    function Dispatch_AddChild: TcxWebTreeItem;
    procedure Dispatch_Collapse(ARecurse: Boolean);
    procedure Dispatch_DeleteChildren;
    procedure Dispatch_Expand(ARecurse: Boolean);
    function Dispatch_IndexOf(Value: TcxWebTreeItem): Integer;
    function Dispatch_InsertChild(BeforeItem: TcxWebTreeItem): TcxWebTreeItem;
    function Dispatch_Items(Index: Integer): TcxWebTreeItem;

    function GetCount: Integer;
    function GetHasChildren: Boolean;
    function GetIndex: Integer;
    function GetLevel: Integer;
    function GetParent: TcxWebTreeItem;
    function GetExpanded: Boolean;
    function GetHint: string;
    function GetImageIndex: Integer;
    function GetName: string;
    function GetText: string;
    function GetURL: TcxURL;
    procedure SetExpanded(Value: Boolean);
    procedure SetHint(Value: string);
    procedure SetImageIndex(Value: Integer);
    procedure SetName(Value: string);
    procedure SetText(Value: string);
    procedure SetURL(Value: TcxURL);
  protected
    function WebTreeItem: TcxWebTreeItem;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property AddChild: TcxScriptDispWebTreeViewImpl_AddItem read FDispatch_AddChild;
    property Collapse: TcxScriptDispWebTreeItemImpl_Collapse read FDispatch_Collapse;
    property DeleteChildren: TcxScriptDispWebComponentImpl_Empty read FDispatch_DeleteChildren;
    property Expand: TcxScriptDispWebTreeItemImpl_Collapse read FDispatch_Expand;
    property IndexOf: TcxScriptDispWebTreeItemImpl_IndexOf read FDispatch_IndexOf;
    property InsertChild: TcxScriptDispWebTreeItemImpl_InsertChild read FDispatch_InsertChild;
    property Items: TcxScriptDispWebTreeItemImpl_Items read FDispatch_Items;

    property Count: Integer read GetCount;
    property HasChildren: Boolean read GetHasChildren;
    property Index: Integer read GetIndex;
    property Level: Integer read GetLevel;
    property Parent: TcxWebTreeItem read GetParent;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Hint: string read GetHint write SetHint;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex;
    property Name: string read GetName write SetName;
    property Text: string read GetText write SetText;
    property URL: TcxURL read GetURL write SetURL;
  end;

  TcxScriptDispWebStyleControllerImpl_Add = function: TcxWebStyleItem of object;
  TcxScriptDispWebStyleControllerImpl_Delete = procedure(AIndex: Integer) of object;
  TcxScriptDispWebStyleControllerImpl_IndexOf = function(AItem: TcxWebStyleItem): Integer of object;
  TcxScriptDispWebStyleControllerImpl_ItemByName = function(const AName: string): TcxWebStyleItem of object;
  TcxScriptDispWebStyleControllerImpl_Items = function(Index: Integer): TcxWebStyleItem of object;

  TcxWebStyleControllerImpl = class(TcxScriptDispImpl)
  private
    FDispatch_Add: TcxScriptDispWebStyleControllerImpl_Add;
    FDispatch_Clear: TcxScriptDispWebComponentImpl_Empty;
    FDispatch_Delete: TcxScriptDispWebStyleControllerImpl_Delete;
    FDispatch_IndexOf: TcxScriptDispWebStyleControllerImpl_IndexOf;
    FDispatch_ItemByName: TcxScriptDispWebStyleControllerImpl_ItemByName;
    FDispatch_Items: TcxScriptDispWebStyleControllerImpl_Items;

    function Dispatch_Add: TcxWebStyleItem;
    procedure Dispatch_Clear;
    procedure Dispatch_Delete(AIndex: Integer);
    function Dispatch_IndexOf(AItem: TcxWebStyleItem): Integer;
    function Dispatch_ItemByName(const AName: string): TcxWebStyleItem;
    function Dispatch_Items(Index: Integer): TcxWebStyleItem;
    function GetCount: Integer;
  protected
    function WebStyleController: TcxWebStyleController;
  public
    constructor Create(AOwner: TObject); override;
    class function GetObjectClass: TClass; override;
  published
    property Count: Integer read GetCount;
    property Add: TcxScriptDispWebStyleControllerImpl_Add read FDispatch_Add;
    property Clear: TcxScriptDispWebComponentImpl_Empty read FDispatch_Clear;
    property Delete: TcxScriptDispWebStyleControllerImpl_Delete read FDispatch_Delete;
    property IndexOf: TcxScriptDispWebStyleControllerImpl_IndexOf read FDispatch_IndexOf;
    property ItemByName: TcxScriptDispWebStyleControllerImpl_ItemByName read FDispatch_ItemByName;
    property Items: TcxScriptDispWebStyleControllerImpl_Items read FDispatch_Items;

  end;

implementation

uses
  cxScriptDispFactory, cxWebUtils;

{ TcxWebComponentImpl }

constructor TcxWebComponentImpl.Create(AOwner: TObject);
begin
  inherited;
end;

class function TcxWebComponentImpl.GetObjectClass: TClass;
begin
  Result := TcxWebComponent;
end;

function TcxWebComponentImpl.WebComponent: TcxWebComponent;
begin
  if Owner is TcxWebComponent then
    Result := Owner as TcxWebComponent
  else Result := nil;
end;

{ TcxWebControlImpl }

constructor TcxWebControlImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_Hide := Dispatch_Hide;
  FDispatch_SetBounds := Dispatch_SetBounds;
  FDispatch_Show := Dispatch_Show;  
end;

class function TcxWebControlImpl.GetObjectClass: TClass;
begin
  Result := TcxWebControl;
end;

function TcxWebControlImpl.WebControl: TcxWebControl;
begin
  if Owner is TcxWebControl then
    Result := Owner as TcxWebControl
  else Result := nil;
end;

procedure TcxWebControlImpl.Dispatch_Hide;
begin
  WebControl.Hide;
end;

procedure TcxWebControlImpl.Dispatch_SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  WebControl.SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TcxWebControlImpl.Dispatch_Show;
begin
  WebControl.Show;
end;

{ TcxWebContainerControlImpl }

constructor TcxWebContainerControlImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_WebControlContainerCount := Dispatch_WebControlContainerCount;
  FDispatch_WebControlContainers := Dispatch_WebControlContainers;
  FDispatch_WebControlCount := Dispatch_WebControlCount;
  FDispatch_WebControls := Dispatch_WebControls;
end;

class function TcxWebContainerControlImpl.GetObjectClass: TClass;
begin
  Result := TcxWebContainerControl;
end;

function TcxWebContainerControlImpl.WebContainerControl: TcxWebContainerControl;
begin
  if Owner is TcxWebContainerControl then
    Result := Owner as TcxWebContainerControl
  else Result := nil;
end;

function TcxWebContainerControlImpl.Dispatch_WebControlContainerCount: Integer;
begin
  Result := WebContainerControl.WebControlContainerCount;
end;

function TcxWebContainerControlImpl.Dispatch_WebControlContainers(Index: Integer): TcxWebContainerControl;
begin
  Result := GetComponentByInterface(WebContainerControl.WebControlContainers[Index]) as TcxWebContainerControl;
end;

function TcxWebContainerControlImpl.Dispatch_WebControlCount: Integer;
begin
  Result := WebContainerControl.WebControlCount;
end;

function TcxWebContainerControlImpl.Dispatch_WebControls(Index: Integer): TcxWebControl;
begin
  Result := GetComponentByInterface(WebContainerControl.WebControls[Index]) as TcxWebControl;
end;

{ TcxWebPopupMenuImpl }

constructor TcxWebPopupMenuImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_ItemByName := Dispatch_ItemByName;
end;

class function TcxWebPopupMenuImpl.GetObjectClass: TClass;
begin
  Result := TcxWebPopupMenu;
end;

function TcxWebPopupMenuImpl.WebPopupMenu: TcxWebPopupMenu;
begin
  if Owner is TcxWebPopupMenu then
    Result := Owner as TcxWebPopupMenu
  else Result := nil;
end;

function TcxWebPopupMenuImpl.Dispatch_ItemByName(AName: string): TcxWebMenuItem;
begin
  Result := WebPopupMenu.ItemByName(AName);
end;

{ TcxWebMainMenuImpl }

constructor TcxWebMainMenuImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_ItemByName := Dispatch_ItemByName;
end;

function TcxWebMainMenuImpl.Dispatch_ItemByName(
  AName: string): TcxWebMenuItem;
begin
  Result := WebMainMenu.ItemByName(AName);
end;

class function TcxWebMainMenuImpl.GetObjectClass: TClass;
begin
  Result := TcxWebMainMenu;
end;

function TcxWebMainMenuImpl.WebMainMenu: TcxWebMainMenu;
begin
  if Owner is TcxWebMainMenu then
    Result := Owner as TcxWebMainMenu
  else Result := nil;
end;

{ TcxWebMenuItemImpl }

constructor TcxWebMenuItemImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_Add := Dispatch_Add;
  FDispatch_Clear := Dispatch_Clear;
  FDispatch_Delete := Dispatch_Delete;
  FDispatch_IndexOf := Dispatch_IndexOf;
  FDispatch_Insert := Dispatch_Insert;
  FDispatch_ItemByName := Dispatch_ItemByName;
  FDispatch_Remove := Dispatch_Remove;
  FDispatch_Items := Dispatch_Items;
end;

class function TcxWebMenuItemImpl.GetObjectClass: TClass;
begin
  Result := TcxWebMenuItem;
end;

function TcxWebMenuItemImpl.WebMenuItem: TcxWebMenuItem;
begin
  if Owner is TcxWebMenuItem then
    Result := Owner as TcxWebMenuItem
  else Result := nil;
end;

function TcxWebMenuItemImpl.Dispatch_Add: TcxWebMenuItem;
begin
  Result := WebMenuItem.Add;
end;

procedure TcxWebMenuItemImpl.Dispatch_Clear;
begin
  WebMenuItem.Clear;
end;

procedure TcxWebMenuItemImpl.Dispatch_Delete(Index: Integer);
begin
  WebMenuItem.Delete(Index);
end;

function TcxWebMenuItemImpl.Dispatch_IndexOf(Item: TcxWebMenuItem): Integer;
begin
  Result := WebMenuItem.IndexOf(Item);
end;

procedure TcxWebMenuItemImpl.Dispatch_Insert(Index: Integer; Item: TcxWebMenuItem);
begin
  WebMenuItem.Insert(Index, Item);
end;

function TcxWebMenuItemImpl.Dispatch_ItemByName(AName: string): TcxWebMenuItem;
begin
  Result := WebMenuItem.ItemByName(AName);
end;

procedure TcxWebMenuItemImpl.Dispatch_Remove(Item: TcxWebMenuItem);
begin
  WebMenuItem.Remove(Item);
end;

function TcxWebMenuItemImpl.Dispatch_Items(Index: Integer): TcxWebMenuItem;
begin
  Result := WebMenuItem.Items[Index];
end;

function TcxWebMenuItemImpl.GetCount: Integer;
begin
  Result := WebMenuItem.Count;
end;

function TcxWebMenuItemImpl.GetIndex: Integer;
begin
  Result := WebMenuItem.Index;
end;

function TcxWebMenuItemImpl.GetParent: TcxWebMenuItem;
begin
  Result := WebMenuItem.Parent;
end;

function TcxWebMenuItemImpl.GetParentMenu: TcxWebComponent;
begin
  Result := WebMenuItem.ParentMenu;
end;

procedure TcxWebMenuItemImpl.SetIndex(Value: Integer);
begin
  WebMenuItem.Index := Value;
end;

{ TcxWebDataSourceImpl }

constructor TcxWebDataSourceImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_FieldByName := Dispatch_FieldByName;
  FDispatch_GetRowDisplayText := Dispatch_GetRowDisplayText;
  FDispatch_GetRowValue := Dispatch_GetRowValue;
  FDispatch_GetRowExpanded := Dispatch_GetRowExpanded;
  FDispatch_GetRowLevel := Dispatch_GetRowLevel;
  FDispatch_GetRowRecord := Dispatch_GetRowRecord;
  FDispatch_GetItemGroupIndex := Dispatch_GetItemGroupIndex;
  FDispatch_GetItemSortOrder := Dispatch_GetItemSortOrder;
  FDispatch_GetGroupingItemIndex := Dispatch_GetGroupingItemIndex;
  FDispatch_GetSortingItemIndex := Dispatch_GetSortingItemIndex;
  FDispatch_ClearGrouping := Dispatch_ClearGrouping;
  FDispatch_ClearSorting := Dispatch_ClearSorting;
  FDispatch_FullCollapse := Dispatch_FullCollapse;
  FDispatch_FullExpand := Dispatch_FullExpand;

  FDispatch_DisplayTexts := Dispatch_DisplayTexts;
  FDispatch_Values := Dispatch_Values;

  FDispatch_CancelEdit := Dispatch_CancelEdit;
  FDispatch_DeleteRecord := Dispatch_DeleteRecord;
  FDispatch_InsertRecord := Dispatch_InsertRecord;
  FDispatch_EditRecord := Dispatch_EditRecord;
  FDispatch_Expand := Dispatch_Expand;
  FDispatch_Group := Dispatch_Group;
  FDispatch_PostEdit := Dispatch_PostEdit;
  FDispatch_SetEditValue := Dispatch_SetEditValue;
  FDispatch_Sort := Dispatch_Sort;
  FDispatch_UnGroup := Dispatch_UnGroup;
  FDispatch_Refresh := Dispatch_Refresh;
end;

procedure TcxWebDataSourceImpl.Dispatch_CancelEdit;
begin
  WebDataSource.CancelEdit;
end;

procedure TcxWebDataSourceImpl.Dispatch_ClearGrouping;
begin
  WebDataSource.ClearGrouping;
end;

procedure TcxWebDataSourceImpl.Dispatch_ClearSorting;
begin
  WebDataSource.ClearSorting;
end;

procedure TcxWebDataSourceImpl.Dispatch_DeleteRecord(ARowIndex: Integer);
begin
  WebDataSource.DeleteRecord(ARowIndex);
end;

function TcxWebDataSourceImpl.Dispatch_DisplayTexts(RecordIndex,
  ItemIndex: Integer): string;
begin
  Result := WebDataSource.DisplayTexts[RecordIndex, ItemIndex];
end;

procedure TcxWebDataSourceImpl.Dispatch_EditRecord(ARowIndex: Integer);
begin
  WebDataSource.EditRecord(ARowIndex);
end;

procedure TcxWebDataSourceImpl.Dispatch_Expand(ARowIndex: Integer;
  AExpanded, ARecursive: Boolean);
begin
  WebDataSource.Expand(ARowIndex, AExpanded, ARecursive);
end;

function TcxWebDataSourceImpl.Dispatch_FieldByName(
  Name: string): TcxCustomWebDataField;
begin
  Result := WebDataSource.FieldByName(Name);
end;

procedure TcxWebDataSourceImpl.Dispatch_FullCollapse;
begin
  WebDataSource.FullCollapse;
end;

procedure TcxWebDataSourceImpl.Dispatch_FullExpand;
begin
  WebDataSource.FullExpand;
end;

function TcxWebDataSourceImpl.GetGroupingItemCount_: Integer;
begin
  Result := WebDataSource.GetGroupingItemCount;
end;

function TcxWebDataSourceImpl.Dispatch_GetGroupingItemIndex(
  Item: Integer): Integer;
begin
  Result := WebDataSource.GetGroupingItemIndex(Item);
end;

function TcxWebDataSourceImpl.Dispatch_GetItemGroupIndex(
  ItemIndex: Integer): Integer;
begin
  Result := WebDataSource.GetItemGroupIndex(ItemIndex);
end;

function TcxWebDataSourceImpl.Dispatch_GetItemSortOrder(
  ItemIndex: Integer): TcxWebDataSortOrder;
begin
  Result := WebDataSource.GetItemSortOrder(ItemIndex);
end;

function TcxWebDataSourceImpl.Dispatch_GetRowDisplayText(RowIndex,
  ItemIndex: Integer): string;
begin
  Result := WebDataSource.GetRowDisplayText(RowIndex, ItemIndex);
end;

function TcxWebDataSourceImpl.Dispatch_GetRowExpanded(
  RowIndex: Integer): Boolean;
begin
  Result := WebDataSource.GetRowExpanded(RowIndex)
end;

function TcxWebDataSourceImpl.Dispatch_GetRowLevel(
  RowIndex: Integer): Integer;
begin
  Result := WebDataSource.GetRowLevel(RowIndex);
end;

function TcxWebDataSourceImpl.Dispatch_GetRowRecord(
  RowIndex: Integer): Integer;
begin
  Result := WebDataSource.GetRowRecord(RowIndex);
end;

function TcxWebDataSourceImpl.Dispatch_GetRowValue(RowIndex,
  ItemIndex: Integer): Variant;
begin
  Result := WebDataSource.GetRowValue(RowIndex, ItemIndex);
end;

function TcxWebDataSourceImpl.GetSortingItemCount_: Integer;
begin
  Result := WebDataSource.GetSortingItemCount;
end;

function TcxWebDataSourceImpl.Dispatch_GetSortingItemIndex(
  Item: Integer): Integer;
begin
  Result := WebDataSource.GetSortingItemIndex(Item);
end;

procedure TcxWebDataSourceImpl.Dispatch_Group(GroupField,
  GroupIndex: Integer);
begin
  WebDataSource.Group(GroupField, GroupIndex);
end;

procedure TcxWebDataSourceImpl.Dispatch_InsertRecord(ARowIndex: Integer);
begin
  WebDataSource.InsertRecord(ARowIndex);
end;

procedure TcxWebDataSourceImpl.Dispatch_PostEdit(
  APriorControlName: string);
begin
  WebDataSource.PostEdit(APriorControlName);
end;

procedure TcxWebDataSourceImpl.Dispatch_Refresh;
begin
  WebDataSource.Refresh;
end;

procedure TcxWebDataSourceImpl.Dispatch_SetEditValue(AItemIndex: Integer;
  AValue: Variant; AType: TcxWebDataTypes);
begin
  WebDataSource.SetEditValue(AItemIndex, AValue, AType);
end;

procedure TcxWebDataSourceImpl.Dispatch_Sort(SortIndex: Integer;
  SortOrder: TcxWebDataSortOrder);
begin
  WebDataSource.Sort(SortIndex, SortOrder);
end;

procedure TcxWebDataSourceImpl.Dispatch_UnGroup(UnGroupIndex: Integer);
begin
  WebDataSource.UnGroup(UnGroupIndex);
end;

function TcxWebDataSourceImpl.Dispatch_Values(RecordIndex,
  ItemIndex: Integer): Variant;
begin
  Result := WebDataSource.Values[RecordIndex, ItemIndex];
end;

function TcxWebDataSourceImpl.GetFocusedRowIndex: Integer;
begin
  Result := WebDataSource.FocusedRowIndex;
end;

function TcxWebDataSourceImpl.GetRecordCount: Integer;
begin
  Result := WebDataSource.RecordCount;
end;

function TcxWebDataSourceImpl.GetRowCount: Integer;
begin
  Result := WebDataSource.RowCount;
end;

procedure TcxWebDataSourceImpl.SetFocusedRowIndex(Value: Integer);
begin
  WebDataSource.FocusedRowIndex := Value;
end;

class function TcxWebDataSourceImpl.GetObjectClass: TClass;
begin
  Result := TcxCustomWebDataSource;
end;

function TcxWebDataSourceImpl.WebDataSource: TcxCustomWebDataSource;
begin
  if Owner is TcxCustomWebDataSource then
    Result := Owner as TcxCustomWebDataSource
  else Result := nil;
end;

{ TcxWebGridImpl }

constructor TcxWebGridImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_Add := Dispatch_Add;
  FDispatch_Clear := Dispatch_Clear;
  FDispatch_Delete := Dispatch_Delete;
  FDispatch_IndexOf := Dispatch_IndexOf;
  FDispatch_ColumnByName := Dispatch_ColumnByName;
  FDispatch_CanCreateDefaultColumns := Dispatch_CanCreateDefaultColumns;
  FDispatch_CreateDefaultColumns := Dispatch_CreateDefaultColumns;
  FDispatch_GetRowDisplayText := Dispatch_GetRowDisplayText;
  FDispatch_GetRowValue :=  Dispatch_GetRowValue;
  FDispatch_GetRowExpanded := Dispatch_GetRowExpanded;
  FDispatch_GetRowLevel := Dispatch_GetRowLevel;
  FDispatch_GetRowRecord := Dispatch_GetRowRecord;
  FDispatch_GetItemGroupIndex := Dispatch_GetItemGroupIndex;
  FDispatch_GetItemSortOrder := Dispatch_GetItemSortOrder;
  FDispatch_GetSortingItemIndex := Dispatch_GetSortingItemIndex;
  FDispatch_GetGroupingItemIndex := Dispatch_GetGroupingItemIndex;
  FDispatch_Columns := Dispatch_Columns;
end;

function TcxWebGridImpl.Dispatch_Add: TcxWebColumn;
begin
  Result := WebGrid.Add;
end;

function TcxWebGridImpl.Dispatch_CanCreateDefaultColumns: Boolean;
begin
  Result := WebGrid.CanCreateDefaultColumns;
end;

procedure TcxWebGridImpl.Dispatch_Clear;
begin
  WebGrid.Clear;
end;

function TcxWebGridImpl.Dispatch_ColumnByName(const AName: string): TcxWebColumn;
begin
  Result := WebGrid.ColumnByName(AName);
end;

function TcxWebGridImpl.Dispatch_Columns(Index: Integer): TcxWebColumn;
begin
  Result := WebGrid.Columns[Index];
end;

procedure TcxWebGridImpl.Dispatch_CreateDefaultColumns(ADeleteExistColumns: Boolean);
begin
  WebGrid.CreateDefaultColumns(ADeleteExistColumns);
end;

procedure TcxWebGridImpl.Dispatch_Delete(AIndex: Integer);
begin
  WebGrid.Delete(AIndex);
end;

function TcxWebGridImpl.Dispatch_GetGroupingItemIndex(Item: Integer): Integer;
begin
  Result := WebGrid.GetGroupingItemIndex(Item);
end;

function TcxWebGridImpl.Dispatch_GetItemGroupIndex(AColIndex: Integer): Integer;
begin
  Result := WebGrid.GetItemGroupIndex(AColIndex);
end;

function TcxWebGridImpl.Dispatch_GetItemSortOrder(AColIndex: Integer): TcxWebGridSortMode;
begin
  Result := WebGrid.GetItemSortOrder(AColIndex);
end;

function TcxWebGridImpl.Dispatch_GetRowDisplayText(ARowIndex, AColIndex: Integer): string;
begin
  Result := WebGrid.GetRowDisplayText(ARowIndex, AColIndex);
end;

function TcxWebGridImpl.Dispatch_GetRowExpanded(RowIndex: Integer): Boolean;
begin
  Result := WebGrid.GetRowExpanded(RowIndex);
end;

function TcxWebGridImpl.Dispatch_GetRowLevel(RowIndex: Integer): Integer;
begin
  Result := WebGrid.GetRowLevel(RowIndex);
end;

function TcxWebGridImpl.Dispatch_GetRowRecord(RowIndex: Integer): Integer;
begin
  Result := WebGrid.GetRowRecord(RowIndex);
end;

function TcxWebGridImpl.Dispatch_GetRowValue(ARowIndex, AColIndex: Integer): Variant;
begin
  Result := WebGrid.GetRowValue(ARowIndex, AColIndex);
end;

function TcxWebGridImpl.Dispatch_GetSortingItemIndex(Item: Integer): Integer;
begin
  Result := WebGrid.GetSortingItemIndex(Item);
end;

function TcxWebGridImpl.Dispatch_IndexOf(AItem: TcxWebColumn): Integer;
begin
  Result := WebGrid.IndexOf(AItem);
end;

function TcxWebGridImpl.GetColumnCount: Integer;
begin
  Result := WebGrid.ColumnCount;
end;

function TcxWebGridImpl.GetFirstVisibleRow: Integer;
begin
  Result := WebGrid.FirstVisibleRow;
end;

function TcxWebGridImpl.GetFocusedRow: Integer;
begin
  Result := WebGrid.FocusedRow;
end;

function TcxWebGridImpl.GetGroupingItemCount_: Integer;
begin
  Result := WebGrid.GetGroupingItemCount;
end;

class function TcxWebGridImpl.GetObjectClass: TClass;
begin
  Result := TcxCustomWebGrid;
end;

function TcxWebGridImpl.GetRecordCount: Integer;
begin
  Result := WebGrid.RecordCount;
end;

function TcxWebGridImpl.GetRowCount: Integer;
begin
  Result := WebGrid.RowCount;
end;

function TcxWebGridImpl.GetSortingItemCount_: Integer;
begin
  Result := WebGrid.GetSortingItemCount;
end;

function TcxWebGridImpl.WebGrid: TcxCustomWebGrid;
begin
  if Owner is TcxCustomWebGrid then
    Result := Owner as TcxCustomWebGrid
  else Result := nil;
end;

{ TcxWebTreeViewImpl }

constructor TcxWebTreeViewImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_AddItem := Dispatch_AddItem;
  FDispatch_Clear := Dispatch_Clear;
  FDispatch_FullCollapse := Dispatch_FullCollapse;
  FDispatch_FullExpand := Dispatch_FullExpand;
  FDispatch_ItemByName := Dispatch_ItemByName;
  FDispatch_Items := Dispatch_Items;
end;

function TcxWebTreeViewImpl.Dispatch_AddItem: TcxWebTreeItem;
begin
  Result := WebTreeView.AddItem;
end;

procedure TcxWebTreeViewImpl.Dispatch_Clear;
begin
  WebTreeView.Clear;
end;

procedure TcxWebTreeViewImpl.Dispatch_FullCollapse;
begin
  WebTreeView.FullCollapse;
end;

procedure TcxWebTreeViewImpl.Dispatch_FullExpand;
begin
  WebTreeView.FullExpand;
end;

function TcxWebTreeViewImpl.Dispatch_ItemByName(const AName: string): TcxWebTreeItem;
begin
  Result := WebTreeView.ItemByName(AName);
end;

function TcxWebTreeViewImpl.Dispatch_Items: TcxWebTreeItem;
begin
  Result := WebTreeView.Items;
end;

class function TcxWebTreeViewImpl.GetObjectClass: TClass;
begin
  Result := TcxWebTreeView;
end;

function TcxWebTreeViewImpl.WebTreeView: TcxWebTreeView;
begin
  if Owner is TcxWebTreeView then
    Result := Owner as TcxWebTreeView
  else Result := nil;
end;

{ TcxWebTreeItemImpl }

constructor TcxWebTreeItemImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_AddChild := Dispatch_AddChild;
  FDispatch_Collapse := Dispatch_Collapse;
  FDispatch_DeleteChildren := Dispatch_DeleteChildren;
  FDispatch_Expand := Dispatch_Expand;
  FDispatch_IndexOf := Dispatch_IndexOf;
  FDispatch_InsertChild := Dispatch_InsertChild;
  FDispatch_Items := Dispatch_Items;
end;

function TcxWebTreeItemImpl.Dispatch_AddChild: TcxWebTreeItem;
begin
  Result := WebTreeItem.AddChild;
end;

procedure TcxWebTreeItemImpl.Dispatch_Collapse(ARecurse: Boolean);
begin
  WebTreeItem.Collapse(ARecurse);
end;

procedure TcxWebTreeItemImpl.Dispatch_DeleteChildren;
begin
  WebTreeItem.DeleteChildren;
end;

procedure TcxWebTreeItemImpl.Dispatch_Expand(ARecurse: Boolean);
begin
  WebTreeItem.Expand(ARecurse);
end;

function TcxWebTreeItemImpl.Dispatch_IndexOf(Value: TcxWebTreeItem): Integer;
begin
  Result := WebTreeItem.IndexOf(Value);
end;

function TcxWebTreeItemImpl.Dispatch_InsertChild(BeforeItem: TcxWebTreeItem): TcxWebTreeItem;
begin
  Result := WebTreeItem.InsertChild(BeforeItem);
end;

function TcxWebTreeItemImpl.Dispatch_Items(Index: Integer): TcxWebTreeItem;
begin
  Result := WebTreeItem.Items[Index];
end;

function TcxWebTreeItemImpl.GetCount: Integer;
begin
  Result := WebTreeItem.Count;
end;

function TcxWebTreeItemImpl.GetExpanded: Boolean;
begin
  Result := WebTreeItem.Expanded;
end;

function TcxWebTreeItemImpl.GetHasChildren: Boolean;
begin
  Result := WebTreeItem.HasChildren;
end;

function TcxWebTreeItemImpl.GetHint: string;
begin
  Result := WebTreeItem.Hint;
end;

function TcxWebTreeItemImpl.GetImageIndex: Integer;
begin
  Result := WebTreeItem.ImageIndex;
end;

function TcxWebTreeItemImpl.GetIndex: Integer;
begin
  Result := WebTreeItem.Index;
end;

function TcxWebTreeItemImpl.GetLevel: Integer;
begin
  Result := WebTreeItem.Level
end;

function TcxWebTreeItemImpl.GetName: string;
begin
  Result := WebTreeItem.Name;
end;

class function TcxWebTreeItemImpl.GetObjectClass: TClass;
begin
  Result := TcxWebTreeItem;
end;

function TcxWebTreeItemImpl.GetParent: TcxWebTreeItem;
begin
  Result := WebTreeItem.Parent;
end;

function TcxWebTreeItemImpl.GetText: string;
begin
  Result := WebTreeItem.Text;
end;

function TcxWebTreeItemImpl.GetURL: TcxURL;
begin
  Result := WebTreeItem.URL;
end;

procedure TcxWebTreeItemImpl.SetExpanded(Value: Boolean);
begin
  WebTreeItem.Expanded := Value;
end;

procedure TcxWebTreeItemImpl.SetHint(Value: string);
begin
  WebTreeItem.Hint := Value;
end;

procedure TcxWebTreeItemImpl.SetImageIndex(Value: Integer);
begin
  WebTreeItem.ImageIndex := Value;
end;

procedure TcxWebTreeItemImpl.SetName(Value: string);
begin
  WebTreeItem.Name := Value;
end;

procedure TcxWebTreeItemImpl.SetText(Value: string);
begin
  WebTreeItem.Text := Value;
end;

procedure TcxWebTreeItemImpl.SetURL(Value: TcxURL);
begin
  WebTreeItem.URL := Value;
end;

function TcxWebTreeItemImpl.WebTreeItem: TcxWebTreeItem;
begin
  if Owner is TcxWebTreeItem then
    Result := Owner as TcxWebTreeItem
  else Result := nil;
end;

{ TcxWebStyleControllerImpl }

constructor TcxWebStyleControllerImpl.Create(AOwner: TObject);
begin
  inherited;
  FDispatch_Add := Dispatch_Add;
  FDispatch_Clear := Dispatch_Clear;
  FDispatch_Delete := Dispatch_Delete;
  FDispatch_IndexOf := Dispatch_IndexOf;
  FDispatch_ItemByName := Dispatch_ItemByName;
  FDispatch_Items := Dispatch_Items;
end;

function TcxWebStyleControllerImpl.Dispatch_Add: TcxWebStyleItem;
begin
  Result := WebStyleController.Add;
end;

procedure TcxWebStyleControllerImpl.Dispatch_Clear;
begin
  WebStyleController.Clear;
end;

procedure TcxWebStyleControllerImpl.Dispatch_Delete(AIndex: Integer);
begin
  WebStyleController.Delete(AIndex);
end;

function TcxWebStyleControllerImpl.Dispatch_IndexOf(AItem: TcxWebStyleItem): Integer;
begin
  Result := WebStyleController.IndexOf(AItem);
end;

function TcxWebStyleControllerImpl.Dispatch_ItemByName(const AName: string): TcxWebStyleItem;
begin
  Result := WebStyleController.ItemByName(AName);
end;

function TcxWebStyleControllerImpl.Dispatch_Items(Index: Integer): TcxWebStyleItem;
begin
  Result := WebStyleController.Items[Index];
end;

function TcxWebStyleControllerImpl.GetCount: Integer;
begin
  Result := WebStyleController.Count;
end;

class function TcxWebStyleControllerImpl.GetObjectClass: TClass;
begin
  Result := TcxWebStyleController;
end;

function TcxWebStyleControllerImpl.WebStyleController: TcxWebStyleController;
begin
  if Owner is TcxWebStyleController then
    Result := Owner as TcxWebStyleController
  else Result := nil;
end;

initialization
  ScriptDispClassFactory.RegisterDispatch(TcxWebComponentImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebControlImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebContainerControlImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebPopupMenuImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebMainMenuImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebMenuItemImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebDataSourceImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebGridImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebTreeViewImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebTreeItemImpl);
  ScriptDispClassFactory.RegisterDispatch(TcxWebStyleControllerImpl);

end.
