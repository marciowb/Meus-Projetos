
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector virtual control and base rows              }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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

unit dxInspct;

interface

{$I dxInsVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxEditor, dxExEdtr, CommCtrl{$IFDEF DELPHI4}, ImgList{$ENDIF},
  dxUtils, StdCtrls, ComCtrls, ExtCtrls{$IFDEF DELPHI6}, Variants{$ENDIF};

const
  dxclInspectorGridColor       = clBtnShadow;
  dxclInspectorBackgroundColor = clBtnFace;
  dxclInspectorValueFontColor  = clNavy;
  dxInspectorMaxResizeWidth    = 2;
  dxInspectorButtonSize        = 9;
  dxInspectorButtonExSize      = 10;
  dxInspectorLimitBandWidth    = 20 * 2 + 3;
  dxInspectorLimitColumnWidth  = 20;
  dxInspectorUndefinedValue    = -10000;
  // Cursors
  crdxInspectorInsert          = -1128;
  crdxInspectorAddChild        = -1129;
  crdxInspectorAdd             = -1130;
  crdxInspectorHide            = -1141;
  crdxInspectorNoDrag          = -1142;
  CM_PREPARECUSTOMIZEFORM      = WM_APP + 201;
  CM_UPDATECUSTOMIZEFORM       = WM_APP + 202;

type
  {$IFNDEF DELPHI5}
  TImageIndex = type Integer;
  {$ENDIF}
  
  { TCustomdxInspector }

  TCustomdxInspector = class;

  TdxInspectorOption = (ioAutoBandCount, ioAutoWidth, ioBandSizing, ioColumnSizing,
    ioDrawEndEllipsis, ioDynamicColumnSizing, ioEditing, ioEnterThrough,   
    ioRowAutoHeight, ioRowSizing, ioStoreToRegistry, ioTabThrough, ioTabs);
  TdxInspectorOptions = set of TdxInspectorOption;

  TdxInspectorState = (isNormal, isColumnSizing, isNodeDown, isNodeDragging,
    isBandSizing, isRowSizing);

  TdxInspectorHitTest = (ihtNowhere, ihtColumnEdge, ihtIndent, ihtButton,
    ihtImage, ihtDisplayLabel, ihtLabel, ihtOutside,
    ihtBandSeparator, ihtComplexRowSeparator, ihtRowEdge);

  TdxInspectorNodeAttachMode = (inaAdd, inaAddChild, inaInsert);

  TdxInspectorPaintStyle = (ipsStandard, ipsSimple, ipsExtended,
    ipsNET, ipsCategorized);

  { TdxInspectorNode }
  
  TdxInspectorNode = class
  private
    FDeleting: Boolean;
    FExpanded: Boolean;
    FList: TList;
    FOwner: TCustomdxInspector;
    FParent: TdxInspectorNode;
    function GetAbsoluteIndex: Integer;
    function GetCount: Integer;
    function GetFocused: Boolean;
    function GetIndex: Integer;
    function GetIsLast: Boolean;
    function GetIsNodeVisible: Boolean;
    function GetItem(Index: Integer): TdxInspectorNode;
    function GetLevel: Integer;
    function GetNodeHasChildren: Boolean;
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
  public
    constructor Create(AOwner: TCustomdxInspector);
    destructor Destroy; override;
    function AddChild: TdxInspectorNode;
    procedure Collapse(Recurse: Boolean);
    procedure DeleteChildren;
    procedure Expand(Recurse: Boolean);
    function GetLastNode: TdxInspectorNode;
    function GetNextNode: TdxInspectorNode;
    function GetPriorNode: TdxInspectorNode;
    function GetPriorParentNode: TdxInspectorNode;
    function HasAsParent(Value: TdxInspectorNode): Boolean;
    function IndexOf(Value: TdxInspectorNode): Integer;
    function InsertChild(BeforeNode: TdxInspectorNode): TdxInspectorNode;
    procedure MakeVisible;
    procedure MoveTo(Destination: TdxInspectorNode; Mode: TdxInspectorNodeAttachMode);
    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property Count: Integer read GetCount;
    property Deleting: Boolean read FDeleting;
    property Expanded: Boolean read FExpanded write SetExpanded;
    property Focused: Boolean read GetFocused write SetFocused;
    property HasChildren: Boolean read GetNodeHasChildren;
    property Index: Integer read GetIndex;
    property IsLast: Boolean read GetIsLast;
    property IsVisible: Boolean read GetIsNodeVisible;
    property Items[Index: Integer]: TdxInspectorNode read GetItem; default;
    property Level: Integer read GetLevel;
    property Owner: TCustomdxInspector read FOwner;
    property Parent: TdxInspectorNode read FParent;
  end;

  TdxInspectorHitInfo = record
    Node: TdxInspectorNode;
    Row: Integer;
    hitType: TdxInspectorHitTest;
    // Band
    BandIndex: Integer;
    // ComplexRow
    ComplexRowIndex: Integer; // for complex row <> -1
    ComplexRowRect: TRect;
  end;

  TdxInspectorButtonKind = (ibkNone, ibkPlus, ibkMinus);

  { Content Draw Info}

  TdxInspectorRowInfo = record
    Node: TdxInspectorNode;
    RowHeight: Integer;
  end;

  PdxInspectorRowsInfo = ^TdxInspectorRowsInfo;
  TdxInspectorRowsInfo = array [0..MaxInt div SizeOf(TdxInspectorRowInfo) - 1] of TdxInspectorRowInfo;

  TdxInspectorBandInfo = record
    BandIndex: Integer;
    BandRect: TRect;
    BandContentRect: TRect;
    BandSeparatorRect: TRect;
    EmptyRect: TRect;
    PartRowVisible: Boolean; 
    RowCount: Integer;
    RowsInfo: PdxInspectorRowsInfo;
  end;

  PdxInspectorBandsInfo = ^TdxInspectorBandsInfo;
  TdxInspectorBandsInfo = array [0..MaxInt div SizeOf(TdxInspectorBandInfo) - 1] of TdxInspectorBandInfo;

  TdxInspectorContentDrawInfo = record
    CRect: TRect;
    BandCount: Integer;
    BandsInfo: PdxInspectorBandsInfo;
    EmptyRect: TRect;
  end;

  { Draw Info}
  
  TdxInspectorDrawInfo = record
    IndentRect: TRect;
    ButtonRect: TRect;
    ImageRect: TRect;
    DisplayRect: TRect;
    ValueRect: TRect;
    ButtonKind: TdxInspectorButtonKind;
  end;

  TdxInspectorCellViewData = class
    Cell_Brush: HBRUSH;
    Cell_Font: HFONT;
    Cell_BkColor: TColor;
    Cell_TextColor: TColor;
    Cell_Alignment: TAlignment;
    Cell_Text: string;
    Cell_TextLength: Integer;
    Cell_Selected: Boolean;
    Cell_DrawEndEllipsis: Boolean;
    Cell_Node: TdxInspectorNode;
    Cell_HotTrackNode: Boolean;
    Cell_Rect: TRect;
  end;

  TdxInplaceInspectorEdit = class(TdxInplaceEdit)
  public
    property Text;
  end;

  TdxInspectorChangeNodeEvent = procedure(Sender: TObject; OldNode, Node: TdxInspectorNode) of object;

  TCustomdxInspector = class(TCustomdxContainer)
  private
    FLockUpdate: Integer;
    FLockExpanded: Integer;
    FNodeList: TList;
    FFocused: TdxInspectorNode;
    FTopVisibleNode: TdxInspectorNode;
    FBandCount: Integer;
    FBandSeparatorWidth: Integer;
    FBandWidth: Integer;
    FBorderStyle: TBorderStyle;
    FComplexRowSeparator: string;
    FComplexRowSeparatorWidth, FCaptionComplexRowSeparatorWidth: Integer;
    FDividerPos, FSizingPos, FSaveSizingPos, FSizingBandIndex: Integer;
    FHotTrackNode: TdxInspectorNode;
    FSizingNode: TdxInspectorNode;
    FDividerPosSave: TPoint; // X - DividerPos, Y - Width
    FGridColor: TColor;
    FGroupColor: TColor;
    FGroupGridColor: TColor;
    FLeftBandIndex: Integer;
    FValueFontColor: TColor;
    FRowHeight: Integer;
    FGridSize: Integer;
    FRowFrameSize: Integer;
    FImageHeight: Integer;
    FImageWidth: Integer;
    FImages: TImageList;
    FImageChangeLink: TChangeLink;
    FIndent: Integer;
    FToolboxButtonWidth: Integer;
    FHitTest: TPoint;
    FHitInfo: TdxInspectorHitInfo;
    FRowCount, FVisibleRowCount: Integer;
    FLoading: Boolean;
    FMaxRowTextLineCount: Integer;
    FMinBandWidth: Integer;
    FMinColumnWidth: Integer;
    FMinRowHeight: Integer;
    FTextHeight: Integer;
    FRegistryPath: string;
    FRowHeightAssigned: Boolean;
    FState: TdxInspectorState;
    FOptions: TdxInspectorOptions;
    FSizing: Boolean;
    FPointDragging: TPoint;
    FDragImageNode: TImageList;
    FPaintStyle: TdxInspectorPaintStyle;
    FFlat: Boolean;
    FPartVisibleBandCount: Integer;
    FVisibleBandCount: Integer;
    FOnChangeNode: TdxInspectorChangeNodeEvent;
    FPrevDragCursor: TCursor;
    FShowRowHint: Boolean;
    FPrevHintComplexRowIndex: Integer;
    FPrevHintNode: TdxInspectorNode;
    FPrevHintTest: TdxInspectorHitTest;
    FShowHintTimerId: Integer;
    FHideHintTimerId: Integer;
    FHintWindow: TdxContainerHintWindow;

    FCellViewData: TdxInspectorCellViewData;
    FModified: Boolean;

    FGridBrush, FGroupGridBrush: HBRUSH;
    FBkBrush, FGroupBkBrush: HBRUSH;
    FOnHideCustomizeForm: TNotifyEvent;
    FOnShowCustomizeForm: TNotifyEvent;
    // tree
    function GetCount: Integer;
    function GetFocused: TdxInspectorNode;
    function GetFocusedNumber: Integer;
    function GetLastNode: TdxInspectorNode;
    function GetNode(Index: Integer): TdxInspectorNode;
    function GetTopIndex: Integer;
    function GetTopNode: TdxInspectorNode;
    procedure SetTopIndex(AIndex: Integer);

    // Style
    function GetOptions: TdxInspectorOptions;
    procedure ImageListChange(Sender: TObject);
    procedure InternalLayout;
    function IsActiveControl: Boolean;
    function IsGridColorStored: Boolean;
    function IsRowHeightStored: Boolean;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetComplexRowSeparator(const Value: string);
    procedure SetFlat(Value: Boolean);
    procedure SetGridColor(Value: TColor);
    procedure SetImages(Value: TImageList);
    procedure SetLeftBandIndex(Value: Integer);
    procedure SetOptions(Value: TdxInspectorOptions);
    procedure SetPaintStyle(Value: TdxInspectorPaintStyle);
    procedure SetRowHeight(Value: Integer);
    procedure SetShowRowHint(Value: Boolean);
    procedure SetState(Value: TdxInspectorState);

    // Size & AutoWidth
    function CalcAutoWidth: Integer;
    procedure CheckBandWidth(var ABandWidth: Integer);
    procedure CheckDividerPos(var Pos: Integer);
    function GetBandCount: Integer;
    function GetFocusedBandIndex: Integer;
    function GetLeftBandIndex: Integer;
    function GetPartVisibleBandCount: Integer;
    function GetVisibleBandCount: Integer;
    procedure SetBandWidth(Value: Integer);
    procedure SetDividerPos(Value: Integer);
    procedure SetMaxRowTextLineCount(Value: Integer);
    procedure SetMinBandWidth(Value: Integer);
    procedure SetMinColumnWidth(Value: Integer);
    procedure UpdateDesigner;
    procedure UpdateTopCoord;

    //Customize
    function GetCustomization: Boolean;
    procedure SetCustomization(Value: Boolean);

    // Draw
    procedure DrawButton(ACanvas: TCanvas; ARect, AButtonRect: TRect; AButtonKind: TdxInspectorButtonKind; ANode: TdxInspectorNode);
    procedure DrawDragNode;
    procedure DrawSizingLine;
    procedure InvalidateRect(ARect: TRect);
    function RecalcPaintRect(ARect: TRect): TRect;
    procedure WriteImage(ACanvas: TCanvas; ARect: TRect; Index: Integer);

    // Editor
    procedure CheckEditor(ASetFocus, AFlagRefresh: Boolean);
    function GetInplaceComplexRowIndex: Integer;
    procedure UpdateText;

    // Hint
    procedure ClearPrevHintNode;
    procedure HideRowHint;
    procedure SetInplaceComplexRowIndex(Value: Integer);
    procedure StartShowRowHint(Wait: Boolean);

    // messages
    procedure WMCancelMode(var Msg: TMessage); message WM_CANCELMODE;
    procedure WMCaptureChanged(var Msg: TMessage); message  WM_CAPTURECHANGED;
    procedure WMDestroy(var Msg: TWMDestroy); message WM_DESTROY;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCalcSize;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPaint;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure CMCancelMode(var Msg: TMessage); message CM_CANCELMODE;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMShowHintChanged(var Message: TMessage); message CM_SHOWHINTCHANGED;
  protected
    FDragNode: TdxInspectorNode;
    FDragObject: TDragObject;
    // Editor
    FComplexRowIndex: Integer;
    FInplaceComplexRowIndex: Integer;
    FInplaceEdit: TdxInplaceEdit;
    FInplaceNode: TdxInspectorNode;

    FInplaceComplexRowIndexPushed: Integer;
    FInplaceEditPushed: TdxInplaceEdit;
    FInplaceNodePushed: TdxInspectorNode;
    // customize
    FCustomizeForm: TForm;
    FCustomizeFormPos: TPoint;
    FCustomizeFormSize: TPoint;
    // overrride TWinControl
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoExit; override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    function GetDragImages: {$IFDEF DELPHI4}TDragImageList{$ELSE}TCustomImageList{$ENDIF}; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;

    // based
    function AcquireFocus: Boolean; virtual;
    procedure AddNode(Node: TdxInspectorNode); virtual;
    function CalcBandWidth(ABandWidth: Integer): Integer;
    function CalcDividerPos(AX: Integer): Integer;
    procedure CalcDrawInfo(ANode: TdxInspectorNode; ARect: TRect; var ADrawInfo: TdxInspectorDrawInfo);
    function CalcMinRowHeight(ACanvas: TCanvas): Integer; virtual;
    function CalcTextHeight(ACanvas: TCanvas): Integer; virtual;
    procedure CancelDragSizing;
    procedure CheckComplexRowIndex(var AComplexRowIndex: Integer); virtual;
    procedure CheckDownNode(AClick: Boolean);
    procedure CheckHotTrackNode(ANode: TdxInspectorNode); virtual;
    procedure CheckInplaceComplexRowIndex; virtual;
    function CreateNode: TdxInspectorNode; virtual; abstract;
    procedure DeleteNode(Node, Prior, Next : TdxInspectorNode; IsLast, Redraw : Boolean); virtual;
    procedure DoChangeNode(OldNode, Node : TdxInspectorNode); virtual;
    procedure DoDragScroll(P: TPoint);
    procedure DragDropTo(var ANode: TdxInspectorNode; ADestinationNode: TdxInspectorNode; AAttachMode: TdxInspectorNodeAttachMode); virtual;
    procedure DrawCaption(ACanvas: TCanvas; ANode: TdxInspectorNode; const ADisplayRect: TRect; const AText: string); virtual;
    procedure DrawComplexRowSeparator(ACanvas: TCanvas; const ARect: TRect; AIsCaption: Boolean);
    procedure DrawDisplayText(ACanvas: TCanvas; const ARect: TRect; const AText: string; AAlignment: TAlignment);
    procedure DoDrawCaption(ACanvas:TCanvas; ANode: TdxInspectorNode;
      AIndentRect, AButtonRect, AImageRect: TRect; AButtonKind: TdxInspectorButtonKind;
      ADisplayRect: TRect; var AText: String); virtual;
    procedure DoDrawValue(ACanvas: TCanvas; ARect : TRect; ANode: TdxInspectorNode;
      var AText : String; var AAlignment: TAlignment); virtual;
    procedure DoHideCustomizeForm; virtual;
    procedure DoShowCustomizeForm; virtual;
    procedure DefaultDrawCell(ACanvas: TCanvas; const ARect: TRect; ACellViewData: TdxInspectorCellViewData); virtual;
    procedure CalcCellViewBoundsRect(const ACellRect: TRect; var AViewRect: TRect); virtual;
    procedure DoInternalLayout; virtual;
    function GetAbsoluteCount: Integer;
    function GetAbsoluteIndex(Node: TdxInspectorNode): Integer;
    function GetAbsoluteNode(AIndex: Integer): TdxInspectorNode;
    function GetBandIndexByNode(ANode: TdxInspectorNode): Integer;
    function GetBandRowCount(ABandIndex: Integer): Integer;
    procedure GetBandRowInfo(AByNode: Boolean; var Node: TdxInspectorNode; var BandIndex, BandRowCount: Integer);
    function GetBandTopNode(ABandIndex: Integer): TdxInspectorNode;
    procedure GetComplexRowInfoAt(ANode: TdxInspectorNode; const ARect: TRect; const APos: TPoint;
      var ComplexRowIndex: Integer; var ComplexRowRect: TRect); virtual;
    function GetDefaultNodeHeight(ANode: TdxInspectorNode): Integer;
    function GetDragNodeText(ADragNode: TdxInspectorNode): string; virtual;
    function GetImageIndex(Node: TdxInspectorNode): Integer; virtual;
    function GetMinRowHeight(ANode: TdxInspectorNode): Integer;
    function GetNodeHeight(ANode: TdxInspectorNode): Integer; virtual;
    procedure GetNodeText(Node: TdxInspectorNode; var CaptionText, DisplayText: String); virtual; abstract;
    function GetRectByNode(ANode: TdxInspectorNode; ADrawInfo: TdxInspectorContentDrawInfo): TRect;
    function GetRectNode(ANode: TdxInspectorNode): TRect;
    function GetRectNodeBelow(Node: TdxInspectorNode): TRect;
    function GetSectionWidth: Integer;
    function GetValueFontColor: TColor; virtual;
    function GoTabComplexRow(AForward: Boolean): Boolean; virtual;
    procedure InvalidateNode(ANode: TdxInspectorNode; ABelow: Boolean);
    function IsAutoDrag: Boolean;
    function IsCategoryNode(Node: TdxInspectorNode): Boolean; virtual;
    function IsComplexNode(ANode: TdxInspectorNode): Boolean; virtual;
    function IsCustomizing: Boolean; virtual;
    function IsGoTabComplexRowAvailable(AForward: Boolean): Boolean; virtual;
    function IsHotTrackNode(ANode: TdxInspectorNode): Boolean; virtual;
    function IsImageNode(Node: TdxInspectorNode): Boolean; virtual;
    function IsInternalDragging: Boolean;
    function IsShowHintNode(ANode: TdxInspectorNode; AComplexRowIndex: Integer;
      const AComplexRowRect: TRect; IsValue: Boolean; const R: TRect;
      var AText: string; var X: Integer; var IsRowHint: Boolean): Boolean; virtual;
    procedure LayoutChanged; virtual;
    procedure RedrawSelection; override;
    procedure UpdateCustomizeForm;
    procedure UpdateDesignEditor; virtual;
    procedure UpdateNode(Node: TdxInspectorNode; Below: Boolean); virtual;
    procedure UpdateBandCount;
    procedure UpdateBandRowCount;
    procedure UpdateRowCount; virtual;
    procedure UpdateScrollBar; virtual;
    procedure SetFocusedNode(Node: TdxInspectorNode); virtual;
    procedure SetFocusedNumber(AIndex: Integer); virtual;
    procedure SetNodeHeight(ANode: TdxInspectorNode; Value: Integer); virtual;
    // Load/Save
    procedure LoadFromRegIni(ARegIniObject: TObject; APath: string);
    procedure ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); virtual;
    procedure SaveToRegIni(ARegIniObject: TObject; APath: string);
    procedure WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); virtual;
    //Editor
    function CanEditAcceptKey(Key: Char): Boolean; override;
    function CanEditModify: Boolean; override;
    function CanEditShow: Boolean; virtual;
    function CellRect(ANode: TdxInspectorNode): TRect;
    function CheckEditorWidth: Boolean; override;
    function CreateEditor(ANode: TdxInspectorNode): TdxInplaceEdit; virtual;
    function CreateEditStyle(AEdit: TdxInplaceEdit): TdxEditStyle; override;
    procedure DoCheckKeyDown(var Key: Word; Shift: TShiftState);
    procedure DoEditChange(Sender: TObject); virtual;
    procedure DoEditValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean); virtual;
    function FindInplaceEdit(ANode: TdxInspectorNode): TdxInplaceEdit; virtual;
    function GetEditColor: TColor; override;
    function GetEditingText: String; virtual;
    function GetEditRect(ANode: TdxInspectorNode): TRect; virtual;
    procedure HideEdit(ABackFocus: Boolean);
    procedure InplaceEditKeyDown(var Key: Word; Shift: TShiftState); override;
    function IsAutoBandCount: Boolean;
    function IsDynamicColumnSizing: Boolean; virtual;
    function IsImmediateEditor: Boolean; override;
    function IsRowAutoHeight: Boolean;
    function CanRowSizing: Boolean;
    function IsTabs: Boolean; override;
    procedure SetEditingText(Value: string); virtual;

    function AssignEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant; virtual;
    function EditStyleBorderStyle: TdxEditBorderStyle;
    function EditStyleButtonStyle: TdxEditButtonViewStyle;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); virtual;
    function InitEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant; virtual; // return Value for Editor

    property BandWidth: Integer read FBandWidth write SetBandWidth default 200;
    property BandSeparatorWidth: Integer read FBandSeparatorWidth;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Color default dxclInspectorBackgroundColor;
    property ComplexRowSeparator: string read FComplexRowSeparator write SetComplexRowSeparator;
    property DividerPos: Integer read FDividerPos write SetDividerPos;
    property DragNode: TdxInspectorNode read FDragNode;
    property Flat: Boolean read FFlat write SetFlat default False;
    property GridColor: TColor read FGridColor write SetGridColor stored IsGridColorStored;
    property GridSize: Integer read FGridSize;
    property Images: TImageList read FImages write SetImages;
    property Indent: Integer read FIndent;
    property InplaceComplexRowIndex: Integer read GetInplaceComplexRowIndex write SetInplaceComplexRowIndex;
    property MaxRowTextLineCount: Integer read FMaxRowTextLineCount write SetMaxRowTextLineCount default 3;
    property MinBandWidth: Integer read FMinBandWidth write SetMinBandWidth default dxInspectorLimitBandWidth;
    property MinColumnWidth: Integer read FMinColumnWidth write SetMinColumnWidth default 30;
    property Options: TdxInspectorOptions read GetOptions write SetOptions
        default [ioEditing, ioBandSizing, ioColumnSizing, ioAutoWidth, ioDynamicColumnSizing];
    property PaintStyle: TdxInspectorPaintStyle read FPaintStyle write SetPaintStyle default ipsStandard;
    property ParentColor default False;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property RowCount: Integer read FRowCount;
    property RowHeight: Integer read FRowHeight write SetRowHeight stored IsRowHeightStored;
    property VisibleRowCount: Integer read FVisibleRowCount;
    property ShowRowHint: Boolean read FShowRowHint write SetShowRowHint default False;
    property OnChangeNode: TdxInspectorChangeNodeEvent read FOnChangeNode write FOnChangeNode;
    property OnHideCustomizeForm: TNotifyEvent read FOnHideCustomizeForm write FOnHideCustomizeForm;
    property OnShowCustomizeForm: TNotifyEvent read FOnShowCustomizeForm write FOnShowCustomizeForm;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    // tree methods
    function Add: TdxInspectorNode;
    procedure BeginUpdate;
    procedure ClearNodes; virtual;
    procedure EndUpdate;
    procedure FullCollapse;
    procedure FullExpand;
    function GetHitInfo(Pos: TPoint): TdxInspectorHitInfo;
    function GetHitTestInfoAt(X, Y: Integer): TdxInspectorHitTest;
    function GetNextVisible(Node: TdxInspectorNode): TdxInspectorNode;
    function GetNodeAt(X, Y: Integer): TdxInspectorNode;
    function GetTopParentNode(ANode: TdxInspectorNode): TdxInspectorNode;
    function IndexOf(Value: TdxInspectorNode): Integer;
    function Insert(BeforeNode: TdxInspectorNode): TdxInspectorNode;
    function IsActive: Boolean;
    function IsNodeVisible(Node: TdxInspectorNode): Boolean;
    procedure MakeNodeVisible(Node: TdxInspectorNode);
    function PtInCustomizeForm(const P: TPoint): Boolean;
    // Customize
    procedure HideCustomizeForm;
    procedure ShowCustomizeForm;
    // Editor
    procedure HideEditor;
    procedure InvalidateEditor; virtual;
    procedure PostEditor; // MouseDown, KeyDown...
    procedure ShowEditor;
    procedure ShowEditorChar(Ch: Char);
    procedure ShowEditorMouse(X, Y: Integer);
    // View
    procedure CalcContentDrawInfo(var ADrawInfo: TdxInspectorContentDrawInfo);
    procedure FreeContentDrawInfo(var ADrawInfo: TdxInspectorContentDrawInfo);
    // Load/Save
    procedure LoadFromRegistry(const ARegPath: string);
    procedure SaveToRegistry(const ARegPath: string);

    property Canvas;
    property BandCount: Integer read GetBandCount;
    property Count: Integer read GetCount;
    property CustomizeForm: TForm read FCustomizeForm;
    property Customization: Boolean read GetCustomization write SetCustomization; 
    property EditColor: TColor read GetEditColor;
    property FocusedBandIndex: Integer read GetFocusedBandIndex;
    property FocusedNode: TdxInspectorNode read GetFocused;
    property FocusedNumber: Integer read GetFocusedNumber write SetFocusedNumber;
    property InplaceEditor: TdxInplaceEdit read FInplaceEdit;
    property Items[Index: Integer]: TdxInspectorNode read GetNode;
    property LastNode: TdxInspectorNode read GetLastNode;
    property LeftBandIndex: Integer read GetLeftBandIndex write SetLeftBandIndex;
    property LockUpdate: Integer read FLockUpdate;
    property PartVisibleBandCount: Integer read GetPartVisibleBandCount;
    property State: TdxInspectorState read FState;
    property TopIndex: Integer read GetTopIndex write SetTopIndex;
    property TopNode: TdxInspectorNode read GetTopNode;
    property TopVisibleNode: TdxInspectorNode read FTopVisibleNode;
    property VisibleBandCount: Integer read GetVisibleBandCount;
  published
    property TabStop default True;
  end;

  { TdxInspectorEditStyle }

  TdxInspectorEditStyle = class(TdxEditStyle)
  private
    FInspector: TCustomdxInspector;
  protected
    property Inspector: TCustomdxInspector read FInspector;
  public
    constructor Create(AEdit: TdxInplaceEdit; AInspector: TCustomdxInspector);
    function DefaultBorderColor: TColor; override;
    function DefaultBorderStyle: TdxEditBorderStyle; override;
    function DefaultButtonStyle: TdxEditButtonViewStyle; override;
    function DefaultButtonTransparence: TdxEditButtonTransparence; override;
    function DefaultEdges: TdxEditEdges; override;
    function DefaultHotTrack: Boolean; override;
    function DefaultShadow: Boolean; override;
  end;

  TCustomdxInspectorControl = class;
  TdxInspectorRowNode = class;
  TdxInspectorDesigner = class;

  { TdxInspectorRow }

  TdxRowValue = (rvCaption, rvReadOnly, rvMaxLength, rvRowHeight);
  TdxRowValues = set of TdxRowValue;

  TdxInspectorRow = class;
  TdxInspectorRowDrawValue = procedure (Sender: TdxInspectorRow; ACanvas: TCanvas;
    ARect: TRect; var AText: String; AFont: TFont;
    var AColor: TColor; var ADone: Boolean) of object;
  TdxInspectorGetEditColor = procedure(Sender: TdxInspectorRow; var AColor: TColor) of object;
  TdxInspectorGetEditFont = procedure(Sender: TdxInspectorRow; var AFont: TFont) of object;

  TdxInplaceInspectorTextEdit = class(TdxInplaceTextEdit);

  TdxInspectorRow = class(TComponent)
  private
    FInspector: TCustomdxInspectorControl;
    FNode: TdxInspectorRowNode;
    FAlignment: TAlignment;
    FCaption: string;
    FCharCase: TEditCharCase;
    FHint: string;
    FImageIndex: TImageIndex;
    FIsCategory: Boolean;
    FMaxLength: Integer;
    FReadonly: Boolean;
    FRowHeight: Integer;
    FShowHint: Boolean;
    FAssignedValues: TdxRowValues;
    FPasswordChar: Char;
    FViewData: TdxEditViewData;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    FOnChangeName: TNotifyEvent;
    FOnDrawCaption: TdxInspectorRowDrawValue;
    FOnDrawValue: TdxInspectorRowDrawValue;
    FOnValidate: TdxEditValidateEvent;
    function GetCaption: string;
    function GetMaxLength: Integer;
    function GetReadOnly: Boolean;
    function GetRowHeight: Integer;
    function IsCaptionStored: Boolean;
    function IsMaxLengthStored: Boolean;
    function IsReadOnlyStored: Boolean;
    function IsRowHeightStored: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetCaption(const Value: string);
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetIsCategory(Value: Boolean);
    procedure SetMaxLength(Value: Integer);
    procedure SetPasswordChar(Value: Char);
    procedure SetReadOnly(Value: Boolean);
    procedure SetRowHeight(Value: Integer);
    procedure SetVisible(Value: Boolean);
    procedure SetInspector(AInspector: TCustomdxInspectorControl);
  protected
    // override TComponent
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;
    //virtual
    procedure DoChange(Sender: TObject); virtual;
    procedure DoDrawCaption(ACanvas: TCanvas; AIndentRect, AButtonRect, AImageRect: TRect; AButtonKind: TdxInspectorButtonKind;
      ADisplayRect: TRect; var AText: string; var ADone: Boolean); virtual;
    procedure DoDrawValue(ACanvas:TCanvas; ARect : TRect; var AText: String; var ADone: Boolean); virtual;
    procedure DoEdited; virtual;
    procedure DoValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean); virtual;
    function GetDisplayText: string; virtual; abstract;
    function GetEditLimit: Integer; virtual;
    function GetEditMaskRow: string; virtual;
    function GetEditText: string; virtual; abstract;
    function GetMinRowHeight(ACanvas: TCanvas): Integer; virtual;
    procedure SetEditText(const Value: string); virtual; abstract;
    procedure Changed;
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); virtual;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; virtual;
    function IsEqualValues(const Value: Variant): Boolean; virtual;
    function IsShowHint(IsValue: Boolean; const R: TRect; var AText: string): Boolean; virtual;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); virtual;
    // Visible
    procedure Hide;
    procedure Show;
    // link to objects
    function GetLinkObject: TObject; virtual;
    procedure SetLinkObject(Value: TObject); virtual;
    function GetLinkObjectName: string; virtual;
    procedure SetLinkObjectName(const Value: string); virtual;
    property ViewData: TdxEditViewData read FViewData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; virtual;
    function DefaultMaxLength: Integer; virtual;
    function DefaultReadOnly: Boolean; virtual;
    function DefaultRowHeight: Integer; virtual;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    function IsCanModify: Boolean; virtual;
    function IsValidChar(InputChar: Char): Boolean; virtual;
    procedure RestoreDefaultRowHeight;
    procedure RestoreDefaults; virtual;

    property AssignedValues: TdxRowValues read FAssignedValues;
    property DisplayText: string read GetDisplayText;
    property EditText: string read GetEditText write SetEditText;
    property Inspector: TCustomdxInspectorControl read FInspector write SetInspector;
    property Node: TdxInspectorRowNode read FNode;
    property OnChangeName : TNotifyEvent read FOnChangeName write FOnChangeName;
    property LinkObject: TObject read GetLinkObject write SetLinkObject;
    property LinkObjectName: String read GetLinkObjectName write SetLinkObjectName;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
    property Hint: string read FHint write FHint;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property IsCategory: Boolean read FIsCategory write SetIsCategory default False;
    property MaxLength: Integer read GetMaxLength write SetMaxLength stored IsMaxLengthStored;
    property PasswordChar: Char read FPasswordChar write SetPasswordChar default #0;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly stored IsReadOnlyStored;
    property RowHeight: Integer read GetRowHeight write SetRowHeight stored IsRowHeightStored;
    property ShowHint: Boolean read FShowHint write FShowHint default False;
    property Visible: Boolean read FVisible write SetVisible default True;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDrawCaption: TdxInspectorRowDrawValue read FOnDrawCaption write FOnDrawCaption;
    property OnDrawValue: TdxInspectorRowDrawValue read FOnDrawValue write FOnDrawValue;
    property OnValidate: TdxEditValidateEvent read FOnValidate write FOnValidate;
  end;

  TdxInspectorRowClass = class of TdxInspectorRow;

  { TdxInspectorRowNode }

  TdxInspectorRowNode = class(TdxInspectorNode)
  private
    FRow: TdxInspectorRow;
    procedure WriteData(AStream: TStream);
  public
    destructor Destroy; override;
    // extended
    function AddChildEx(RowClass: TdxInspectorRowClass): TdxInspectorRowNode;
    function InsertChildEx(BeforeNode: TdxInspectorNode; RowClass: TdxInspectorRowClass): TdxInspectorRowNode;
    property Row: TdxInspectorRow read FRow;
  end;

  PdxInspectorRowNodeInfo = ^TdxInspectorRowNodeInfo;
  TdxInspectorRowNodeInfo = packed record
    Count: Integer;
    StrLen: Integer;
    Str: record end;
  end;

  TdxInspectorEditingEvent = procedure(Sender: TObject; Node: TdxInspectorNode;
    Row: TdxInspectorRow; var Allow: Boolean) of object;
  TdxInspectorEditedEvent = procedure(Sender: TObject; Node: TdxInspectorNode; Row: TdxInspectorRow) of object;

  { TCustomdxInspectorControl }

  TdxInspectorComplexRow = class;

  TCustomdxInspectorControl = class(TCustomdxInspector)
  private
    FDefaultRowClass: TdxInspectorRowClass;
    FDesigner: TdxInspectorDesigner;
    FEditFont: TFont;
    FEditors: TList;
    FEditValue: Variant;
    FRows: TList;
    FStreamData: TMemoryStream;
    FOnDrawCaption: TdxInspectorRowDrawValue;
    FOnDrawValue: TdxInspectorRowDrawValue;
    FOnEditChange: TNotifyEvent;
    FOnEditing: TdxInspectorEditingEvent;
    FOnEdited: TdxInspectorEditedEvent;
    FOnEditValidate: TdxEditValidateEvent;
    FOnGetEditColor: TdxInspectorGetEditColor;
    FOnGetEditFont: TdxInspectorGetEditFont;
    procedure AddRow(Row: TdxInspectorRow);
    procedure CheckHiddenRows;
    procedure FreeStreamData;
    function GetRow(Index: Integer): TdxInspectorRow;
    function GetTotalRowCount: Integer;
    function GetVisibleTotalRowCount: Integer;
    procedure InternalCreateNodeForRow(Row: TdxInspectorRow);
    procedure LoadOrderRows;
    procedure NotifyComplexRows(Row: TdxInspectorRow);
    procedure ReadData(Stream: TStream);
    procedure RemoveRow(Row: TdxInspectorRow);
    procedure SetEditValue(const Value: Variant);
    procedure SetRow(Index: Integer; Value: TdxInspectorRow);
    procedure WriteData(AStream: TStream);
  protected
    FAddFlag: Boolean;
    FDragRow: TdxInspectorRow;
    // TComponent
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure GetChildren(Proc: TGetChildProc{$IFDEF DELPHI3}; Root: TComponent{$ENDIF}); override;
    procedure Loaded; override;
    procedure SetChildOrder(Component: TComponent; Order: Integer); override;
    procedure SetName(const Value: TComponentName); override;
    // based
    procedure AddNode(Node: TdxInspectorNode); override;
    function CalcMinRowHeight(ACanvas: TCanvas): Integer; override;
    function CalcRowAutoHeight(ARow: TdxInspectorRow): Integer;
    function CalcRowHeight(ACanvas: TCanvas; const ARect: TRect; ACellViewData: TdxInspectorCellViewData; ARow: TdxInspectorRow): Integer;
    function CalcComplexRowHeight(ACanvas: TCanvas; const ARect: TRect; ACellViewData: TdxInspectorCellViewData; ARow: TdxInspectorComplexRow): Integer;

    procedure CheckComplexRowIndex(var AComplexRowIndex: Integer); override;
    procedure ClearComplexRows(ARow: TdxInspectorRow);
    function CreateNode: TdxInspectorNode; override;
    procedure DestroyRows;
    procedure DefaultDrawCell(ACanvas: TCanvas; const ARect: TRect; ACellViewData: TdxInspectorCellViewData); override;
    procedure DragDropTo(var ANode: TdxInspectorNode; ADestinationNode: TdxInspectorNode; AAttachMode: TdxInspectorNodeAttachMode); override;
    procedure DrawCaption(ACanvas: TCanvas; ANode: TdxInspectorNode; const ADisplayRect: TRect; const AText: string); override;
    procedure DrawComplexRowCaption(ACanvas: TCanvas; const ADisplayRect: TRect; ARow: TdxInspectorComplexRow);
    procedure DrawComplexRowValue(ACanvas: TCanvas; const ARect: TRect; ACellViewData: TdxInspectorCellViewData; ARow: TdxInspectorComplexRow);
    procedure DrawValue(ACanvas: TCanvas; const ARect: TRect; ACellViewData: TdxInspectorCellViewData; ARow: TdxInspectorRow);
    procedure DoDrawCaption(ACanvas: TCanvas; ANode: TdxInspectorNode;
      AIndentRect, AButtonRect, AImageRect: TRect; AButtonKind: TdxInspectorButtonKind;
      ADisplayRect: TRect; var AText: String); override;
    procedure DoDrawValue(ACanvas:TCanvas; ARect: TRect; ANode: TdxInspectorNode;
      var AText : string; var AAlignment: TAlignment); override;
    procedure DoEditChange(Sender: TObject); override;
    procedure DoEditValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean); override;
    procedure DoInternalLayout; override;
    procedure DoRestoreLayout; virtual;
    procedure DoSaveLayout; virtual;
    procedure GetComplexRowInfoAt(ANode: TdxInspectorNode; const ARect: TRect; const APos: TPoint;
      var ComplexRowIndex: Integer; var ComplexRowRect: TRect); override;
    function GetDefaultRowClass: TdxInspectorRowClass; virtual;
    function GetDragNodeText(ADragNode: TdxInspectorNode): string; override;
    function GetEditRect(ANode: TdxInspectorNode): TRect; override;
    function GetImageIndex(Node: TdxInspectorNode): Integer; override;
    function GetNodeHeight(ANode: TdxInspectorNode): Integer; override;
    procedure GetNodeText(Node: TdxInspectorNode; var CaptionText, DisplayText: string); override;
    function GetRowDragCaption(ARow: TdxInspectorRow): string;
    function GetRowHeight(ARow: TdxInspectorRow): Integer;
    function GoTabComplexRow(AForward: Boolean): Boolean; override;
    function IsCategoryNode(Node: TdxInspectorNode): Boolean; override;
    function IsComplexNode(ANode: TdxInspectorNode): Boolean; override;
    function IsGoTabComplexRowAvailable(AForward: Boolean): Boolean; override;
    function IsShowHintNode(ANode: TdxInspectorNode; AComplexRowIndex: Integer;
      const AComplexRowRect: TRect; IsValue: Boolean; const R: TRect;
      var AText: string; var X: Integer; var IsRowHint: Boolean): Boolean; override;
    function RowByComplexRowIndex(ANode: TdxInspectorNode; AComplexRowIndex: Integer): TdxInspectorRow;
    procedure SetNodeHeight(ANode: TdxInspectorNode; Value: Integer); override;
    procedure SetOrderRows(InspectorControl: TCustomdxInspectorControl);
    function SaveNodes: Boolean; virtual;
    procedure UpdateDesignEditor; override;
    procedure UpdateRow(Row: TdxInspectorRow); virtual;
    // Save/Load
    procedure ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); override;
    procedure WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); override;
    // Editor
    function CanEditShow: Boolean; override;
    function CreateEditor(ANode: TdxInspectorNode): TdxInplaceEdit; override;
    function FindInplaceEdit(ANode: TdxInspectorNode): TdxInplaceEdit; override;
    function GetEditColor: TColor; override;
    function GetEditFont: TFont; override;
    function GetInplaceEditRow(ANode: TdxInspectorNode): TdxInspectorRow;
    function AssignEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsDefaultEqualValues(const AValue: Variant; ARow: TdxInspectorRow): Boolean; virtual;
    property EditValue: Variant read FEditValue write SetEditValue;
    property OnDrawCaption: TdxInspectorRowDrawValue read FOnDrawCaption write FOnDrawCaption;
    property OnDrawValue: TdxInspectorRowDrawValue read FOnDrawValue write FOnDrawValue;
    property OnEditChange: TNotifyEvent read FOnEditChange write FOnEditChange;
    property OnEditing: TdxInspectorEditingEvent read FOnEditing write FOnEditing;
    property OnEdited: TdxInspectorEditedEvent read FOnEdited write FOnEdited;
    property OnEditValidate: TdxEditValidateEvent read FOnEditValidate write FOnEditValidate;
    property OnGetEditColor: TdxInspectorGetEditColor read FOnGetEditColor write FOnGetEditColor;
    property OnGetEditFont: TdxInspectorGetEditFont read FOnGetEditFont write FOnGetEditFont;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AssignRows(InspectorControl: TCustomdxInspectorControl); virtual;
    procedure ClearRows; virtual;
    function ComplexRowByRow(ARow: TdxInspectorRow): TdxInspectorComplexRow;
    function CreateDefaultRow(RowClass: TdxInspectorRowClass): TdxInspectorRow;
    function CreateRow(RowClass: TdxInspectorRowClass): TdxInspectorRow;
    function IndexOfRow(ARow: TdxInspectorRow): Integer;
    procedure InvalidateEditor; override;
    procedure RestoreRowsDefaults;
    function RowByName(const AName: string): TdxInspectorRow;
    function RowInComplexRow(ARow: TdxInspectorRow): Boolean;
    // extended
    function AddEx(RowClass: TdxInspectorRowClass): TdxInspectorRowNode;
    function InsertEx(BeforeNode: TdxInspectorNode; RowClass: TdxInspectorRowClass): TdxInspectorRowNode;
    // Save/Load
    procedure LoadNodesFromStream(AStream: TStream);
    procedure SaveNodesToStream(AStream: TStream);

    property DefaultRowClass: TdxInspectorRowClass read FDefaultRowClass write FDefaultRowClass;
    property Designer: TdxInspectorDesigner read FDesigner;
    property Rows[Index : Integer]: TdxInspectorRow read GetRow write SetRow;
    property TotalRowCount: Integer read GetTotalRowCount;
    property VisibleTotalRowCount: Integer read GetVisibleTotalRowCount;
  end;

  { TdxDBTreeListDesigner }

  TdxInspectorDesigner = class
  private
    FInspector: TCustomdxInspectorControl;
  public
    constructor Create(dxInspector: TCustomdxInspectorControl);
    destructor Destroy; override;
    procedure LayoutChanged; virtual;
    property Inspector: TCustomdxInspectorControl read FInspector;
  end;

  { TdxInspector }

  TdxInspector = class(TCustomdxInspectorControl)
  private
    procedure CMExit(var Message: TMessage); message CM_EXIT;
  protected
    function CanEditModify: Boolean; override;
  public
    function GetDefaultRowClass: TdxInspectorRowClass; override;
    property DragNode;
    property ReadOnly;
  published
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    property BandWidth;
    property ComplexRowSeparator;
    property DividerPos;
    property GridColor;
    property Flat;
    property Images;
    property MaxRowTextLineCount;
    property MinBandWidth;
    property MinColumnWidth;
    property Options;
    property PaintStyle;
    property RegistryPath;
    property RowHeight;
    property OnChangeNode;
    property OnDrawCaption;
    property OnDrawValue;
    property OnEditing;
    property OnEditChange;
    property OnEdited;
    property OnEditValidate;
    property OnGetEditColor;
    property OnGetEditFont;
    property OnHideCustomizeForm;
    property OnShowCustomizeForm;
    property ShowRowHint;
    {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    {$ENDIF}
    {$IFDEF DELPHI5}
    property OnContextPopup;
    {$ENDIF}
  end;

  { TdxInspectorTextRow }

  TdxInspectorTextRow = class(TdxInspectorRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorComplexRow }

  TdxInspectorComplexRowItem = class(TCollectionItem)
  private
    FFixed: Boolean;
    FMinWidth: Integer;
    FRow: TdxInspectorRow;
    FWidth: Integer;
    procedure SetFixed(Value: Boolean);
    procedure SetMinWidth(Value: Integer);
    procedure SetRow(Value: TdxInspectorRow);
    procedure SetWidth(Value: Integer);
  protected
    function GetDisplayName: string; override;
    function Inspector: TCustomdxInspectorControl;
    function IsValidRow(ARow: TdxInspectorRow): Boolean;
    procedure PrepareRow(ARow: TdxInspectorRow);
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults;
  published
    property Fixed: Boolean read FFixed write SetFixed default False;
    property MinWidth: Integer read FMinWidth write SetMinWidth default 20;
    property Row: TdxInspectorRow read FRow write SetRow;
    property Width: Integer read FWidth write SetWidth default 50;
  end;

  TdxInspectorComplexRowItems = class(TCollection)
  private
    FRow: TdxInspectorComplexRow;
    function GetItem(Index: Integer): TdxInspectorComplexRowItem;
    procedure SetItem(Index: Integer; Value: TdxInspectorComplexRowItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ARow: TdxInspectorComplexRow);
    function Add: TdxInspectorComplexRowItem;
    function IndexOfRow(ARow: TdxInspectorRow): Integer;
    procedure RestoreDefaults;
    property Row: TdxInspectorComplexRow read FRow;
    property Items[Index: Integer]: TdxInspectorComplexRowItem read GetItem write SetItem; default;
  end;

  TdxInspectorComplexRow = class(TdxInspectorTextRow)
  private
    FItems: TdxInspectorComplexRowItems;
    procedure SetItems(Value: TdxInspectorComplexRowItems);
  protected
    procedure RemoveNotification(ARow: TdxInspectorRow);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Items: TdxInspectorComplexRowItems read FItems write SetItems;
  end;
  // TODO: RegisterProperty Editor = nil MaxLength and ...

  { TdxInspectorComplexRowViewInfo }

  TdxInspectorComplexRowViewInfoItem = class
  private
    FBounds: TRect;
    FFixed: Boolean;
    FMinWidth: Integer;
    FRow: TdxInspectorRow;
    FSeparator: Boolean;
    FWidth: Integer;
  protected
    property Fixed: Boolean read FFixed write FFixed;
    property MinWidth: Integer read FMinWidth write FMinWidth;
    property Width: Integer read FWidth write FWidth;
  public
    constructor Create(ARow: TdxInspectorRow);
    property Bounds: TRect read FBounds write FBounds;
    property Separator: Boolean read FSeparator write FSeparator;
    property Row: TdxInspectorRow read FRow;
  end;

  TdxInspectorComplexRowViewInfo = class
  private
    FItems: TList;
    FRow: TdxInspectorComplexRow;
    FSeparatorWidth: Integer;
    function GetCount: Integer;
    function GetEmpty: Boolean;
    function GetItem(Index: Integer): TdxInspectorComplexRowViewInfoItem;
  protected
    function Add(ARow: TdxInspectorRow): TdxInspectorComplexRowViewInfoItem;
    property Row: TdxInspectorComplexRow read FRow;
    property SeparatorWidth: Integer read FSeparatorWidth;
  public
    constructor Create(ARow: TdxInspectorComplexRow; ASeparatorWidth: Integer);
    destructor Destroy; override;
    procedure Calculate(const ARect: TRect);
    procedure Clear;
    property Count: Integer read GetCount;
    property Empty: Boolean read GetEmpty;
    property Items[Index: Integer]: TdxInspectorComplexRowViewInfoItem read GetItem; default;
  end;

implementation

{$R dxInsCur.RES}

uses
  dxInsCus, Registry;

const
  DrawBitmap: TBitmap = nil;
  ScrollTimerId       = 1;
  ShowHintTimerId     = 2;
  HideHintTimerId     = 3;
  WaitForShowHintTime = 1000;
  WaitForHideHintTime = 5000;
  // Cursors
  dxInspectorInsertCursor   = 'DXINSP_INSERT';
  dxInspectorAddChildCursor = 'DXINSP_ADDCHILD';
  dxInspectorAddCursor      = 'DXINSP_ADD';
  dxInspectorHideCursor     = 'DXINSP_HIDE';
  dxInspectorNoDragCursor   = 'DXINSP_NODRAG';

type
  EFailureLoadOrderRows = class(Exception);
  TWinControlAccess = class(TWinControl);

  TdxInspectorDragControlObject = class(TDragControlObject)
  private
    function GetInspector: TCustomdxInspector;
  protected
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
    property Inspector: TCustomdxInspector read GetInspector;
  end;

function TdxInspectorDragControlObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
begin
  if Inspector.PtInCustomizeForm(Point(X, Y)) then
    Result := crdxInspectorHide
  else
  begin
    if Accepted then
      Result := inherited GetDragCursor(Accepted, X, Y)
    else
      Result := crdxInspectorNoDrag;
  end;
end;

function TdxInspectorDragControlObject.GetInspector: TCustomdxInspector;
begin
  Result := Control as TCustomdxInspector;
end;

procedure CreateBitmaps;
begin
  DrawBitmap := TBitmap.Create;
end;

procedure DestroyBitmaps;
begin
  if DrawBitmap <> nil then DrawBitmap.Free;
  DrawBitmap := nil;
end;

procedure DrawFocused(ADC: HDC; const ARect: TRect);
var
  APrevBkColor, APrevTextColor: TColorRef;
begin
  APrevBkColor := SetBkColor(ADC, clBlack);
  APrevTextColor := SetTextColor(ADC, clWhite);
  Windows.DrawFocusRect(ADC, ARect);
  SetBkColor(ADC, APrevBkColor);
  SetTextColor(ADC, APrevTextColor);
end;

procedure DrawToolboxArrow(ACanvas: TCanvas; ARect: TRect; AExpanded: Boolean);

  procedure DrawCollapsedArrow(ACanvas: TCanvas; ARect: TRect);
  begin
    with ACanvas, ARect do
    begin
      MoveTo(Left, Top);
      LineTo(Left + 2, Top + 2);
      LineTo(Left, Top + 4);
      LineTo(Left, Top + 3);
      LineTo(Left + 2, Top + 2);
      LineTo(Left, Top + 1);
      LineTo(Left, Top);
    end;
  end;

  procedure DrawExpandedArrow(ACanvas: TCanvas; ARect: TRect);
  begin
    with ACanvas, ARect do
    begin
      MoveTo(Left, Top);
      LineTo(Left + 2, Top + 2);
      LineTo(Left + 4, Top);
      LineTo(Left + 3, Top);
      LineTo(Left + 2, Top + 2);
      LineTo(Left + 1, Top);
      LineTo(Left, Top);
    end;
  end;

begin
  if AExpanded then
  begin
    DrawExpandedArrow(ACanvas, ARect);
    OffsetRect(ARect, 0, 3);
    DrawExpandedArrow(ACanvas, ARect);
  end
  else
  begin
    DrawCollapsedArrow(ACanvas, ARect);
    OffsetRect(ARect, 3, 0);
    DrawCollapsedArrow(ACanvas, ARect);
  end;
end;

{ TdxInspectorNode }

constructor TdxInspectorNode.Create(AOwner: TCustomdxInspector);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TdxInspectorNode.Destroy;
var
  Prior, Next: TdxInspectorNode;
  fgLast, fgRedraw: Boolean;
begin
  FDeleting := True;
  DeleteChildren;
  Prior := GetPriorParentNode;
  Next := GetNextNode;
  fgLast := IsLast;
  fgRedraw := IsVisible;

  if Parent <> nil then
  begin
    if Parent.FList <> nil then
    begin
      Parent.FList.Remove(Self);
      if Parent.Count = 0 then
      begin
        Parent.FList.Free;
        Parent.FList := nil;
        Parent.FExpanded := False;
      end;
    end;
  end
  else
    if FOwner <> nil then
    begin
      FOwner.FNodeList.Remove(self);
    end;
  if FList <> nil then
    FList.Free;

  FOwner.DeleteNode(Self, Prior, Next, fgLast, fgRedraw);
  inherited Destroy;
end;

function TdxInspectorNode.AddChild: TdxInspectorNode;
begin
  Result := InsertChild(nil);
end;

procedure TdxInspectorNode.Collapse(Recurse: Boolean);
var
  I: Integer;
begin
  if not HasChildren then Exit;
  FOwner.BeginUpdate;
  try
    Expanded := False;
    if Recurse then
      for I := 0 to Count - 1 do
        Items[I].Collapse(Recurse);
  finally
    FOwner.EndUpdate;
  end;
end;

procedure TdxInspectorNode.DeleteChildren;
begin
  while Count > 0 do
    Items[0].Free;
end;

procedure TdxInspectorNode.Expand(Recurse: Boolean);
var
  I: Integer;
begin
  if not HasChildren then Exit;
  FOwner.BeginUpdate;
  try
    Expanded := True;
    if Recurse then
      for I := 0 to Count - 1 do
        Items[i].Expand(Recurse);
  finally
    FOwner.EndUpdate;
  end;
end;

function TdxInspectorNode.GetLastNode: TdxInspectorNode;
begin
  Result := Self;
  if (Count > 0) and Expanded then
  begin
    Result := Items[Count - 1];
    while (Result.Count > 0) and Result.Expanded do
      Result := Result[Result.Count - 1];
  end;
end;

function TdxInspectorNode.GetNextNode: TdxInspectorNode;
begin
  Result := FOwner.GetNextVisible(Self);
end;

function TdxInspectorNode.GetPriorNode: TdxInspectorNode;

  function GetPrior(ANode: TdxInspectorNode): TdxInspectorNode;
  begin
    if not ANode.Expanded then Result := ANode
    else Result := GetPrior(ANode[ANode.Count-1]);
  end;

begin
  if Index > 0 then
  begin
   if Parent <> nil then
     Result := GetPrior(Parent.Items[Index - 1])
   else Result := GetPrior(FOwner.Items[Index - 1]);
  end
  else Result := Parent;
end;

function TdxInspectorNode.GetPriorParentNode: TdxInspectorNode;
begin
  if Index > 0 then
  begin
    if Parent <> Nil then
      Result := Parent.Items[Index - 1]
    else Result := FOwner.Items[Index - 1];
  end
  else Result := Parent;
end;

function TdxInspectorNode.HasAsParent(Value: TdxInspectorNode): Boolean;
var
  ANode: TdxInspectorNode;
begin
  Result := False;
  ANode := Parent;
  while ANode <> nil do
  begin
    if ANode = Value then
    begin
      Result := True;
      Break;
    end;
    ANode := ANode.Parent;
  end;
end;

function TdxInspectorNode.IndexOf(Value: TdxInspectorNode): Integer;
begin
  Result := -1;
  if Count > 0 then
    Result := FList.IndexOf(Value);
end;

function TdxInspectorNode.InsertChild(BeforeNode: TdxInspectorNode): TdxInspectorNode;
begin
  Result := FOwner.CreateNode;
  Result.FParent := self;
  if FList = nil then
  begin
    FList := TList.Create;
    FList.Add(Result);
  end
  else
  begin
    if BeforeNode = nil then
      FList.Add(Result)
    else FList.Insert(BeforeNode.Index, Result);
  end;
  FOwner.AddNode(Result);
end;

procedure TdxInspectorNode.MakeVisible;
begin
  FOwner.MakeNodeVisible(Self);
end;

procedure TdxInspectorNode.MoveTo(Destination: TdxInspectorNode; Mode: TdxInspectorNodeAttachMode);

  procedure CheckList(Node: TdxInspectorNode);
  begin
    if Node.FList = nil then
      Node.FList := TList.Create;
  end;

begin
  if (Destination = nil) or (Destination.HasAsParent(Self))
    or ((Destination=Self) and
    (Mode in [inaAddChild, inaInsert])) then Exit;
  FOwner.BeginUpdate;
  try
    {InternalRemove}
    if Parent = nil then
      FOwner.FNodeList.Remove(Self)
    else
    begin
      Parent.FList.Remove(Self);
      if Parent.FList.Count = 0 then
      begin
         Parent.FList.Free;
         Parent.FList := nil;
         Parent.FExpanded := False;
      end;
    end;
    {InternalAdd}
    if (Destination.Parent = nil) or
       (Mode in [inaAddChild]) then
    begin
      case Mode of
      inaAdd : FOwner.FNodeList.Add(Self);
      inaInsert : FOwner.FNodeList.Insert(Destination.Index, Self);
      else {Mode in [natlAddChild]}
        begin
          CheckList(Destination);
          Destination.FList.Add(Self);
        end;
      end; {case}
      if (Mode in [inaAddChild]) then
      begin
        FParent := Destination;
      end
      else FParent := nil;
    end
    else
    begin {Parent <> Nil}
      CheckList(Destination.Parent);
      case Mode of
      inaAdd: Destination.Parent.FList.Add(Self);
      inaInsert: Destination.Parent.FList.Insert(Destination.Index, Self);
      end;
      FParent := Destination.Parent;
    end;
    FOwner.FFocused := Self;
    MakeVisible;
  finally
    FOwner.EndUpdate;
  end;
end;

// private
function TdxInspectorNode.GetAbsoluteIndex: Integer;
begin
  Result := FOwner.GetAbsoluteIndex(Self);
end;

function TdxInspectorNode.GetCount: Integer;
begin
  if FList = nil then
    Result := 0
  else Result := FList.Count;
end;

function TdxInspectorNode.GetFocused: Boolean;
begin
  Result := FOwner.FocusedNode = Self;
end;

function TdxInspectorNode.GetIndex: Integer;
begin
  if Parent <> nil then
    Result := Parent.IndexOf(Self)
  else Result := FOwner.IndexOf(Self);
end;

function TdxInspectorNode.GetIsLast: Boolean;
begin
  if Parent <> nil then Result := Index = (Parent.Count - 1)
  else Result := Index = (FOwner.Count - 1);
end;

function TdxInspectorNode.GetIsNodeVisible : Boolean;
begin
  Result := FOwner.IsNodeVisible(Self);
end;

function TdxInspectorNode.GetItem(Index: Integer): TdxInspectorNode;
begin
  Result := nil;
  if (Index > -1) and (Index < Count) then
    Result := FList.Items[Index];
end;

function TdxInspectorNode.GetLevel: Integer;
var
 ANode : TdxInspectorNode;
begin
  Result := 0;
  ANode := Parent;
  while ANode <> nil do
  begin
    Inc(Result);
    ANode := ANode.Parent;
  end;
end;

function TdxInspectorNode.GetNodeHasChildren: Boolean;
begin
  Result := Count > 0;
end;

procedure TdxInspectorNode.SetExpanded(Value: Boolean);
begin
  if not HasChildren then Exit;
  if Value <> Expanded then
  begin
    FExpanded := Value;
    FOwner.UpdateNode(Self, True {Below});
    if not Value and (FOwner.FocusedNode <> nil) and
      FOwner.FocusedNode.HasAsParent(Self) then
      Focused := True;
    // design-time
    if FOwner.FLockExpanded = 0 then
      FOwner.UpdateDesigner;
  end;
end;

procedure TdxInspectorNode.SetFocused(Value : Boolean);
begin
  if Focused = Value then Exit;
  if Value then
    FOwner.SetFocusedNode(Self)
  else FOwner.SetFocusedNode(nil);
end;

{ TCustomdxInspector }

constructor TCustomdxInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FNodeList := TList.Create;

  ControlStyle := [csCaptureMouse, csOpaque, csDoubleClicks, csDisplayDragImage];
  if NewStyleControls then
    ControlStyle := ControlStyle else
    ControlStyle := ControlStyle + [csFramed];
  TabStop := True;

  Color := dxclInspectorBackgroundColor;
  ParentColor := False;
  FBandSeparatorWidth := 3;
  FBandWidth := 200;
  FBorderStyle := bsSingle;
  FGridColor := dxclInspectorGridColor;
  FGroupColor := clBtnFace;
  FGroupGridColor := clBtnShadow;
  FValueFontColor := dxclInspectorValueFontColor;
  Width := 150;
  Height := 250;
  FMinRowHeight := 18;
  FRowHeight := 18;
  FGridSize := 1;  
  FIndent := 6;
  FToolboxButtonWidth := 6 + 4;
  FDividerPos := Width div 2;
  FDividerPosSave.X := FDividerPos;
  FDividerPosSave.Y := -1 ;
  FMaxRowTextLineCount := 3;
  FMinBandWidth  := dxInspectorLimitBandWidth;
  FMinColumnWidth := 30;
  FOptions := [ioEditing, ioBandSizing, ioColumnSizing, ioAutoWidth, ioDynamicColumnSizing];
  FCustomizeFormPos := Point(dxInspectorUndefinedValue, dxInspectorUndefinedValue);
  FCustomizeFormSize := Point(dxInspectorUndefinedValue, dxInspectorUndefinedValue);

  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;

  FCellViewData := TdxInspectorCellViewData.Create;
end;

destructor TCustomdxInspector.Destroy;
begin
  Destroying;
  ClearNodes;
  FNodeList.Free;
  if FDragImageNode <> nil then
  begin
    FDragImageNode.Free;
    FDragImageNode := Nil;
  end;
  FImageChangeLink.Free;
  FCellViewData.Free;
  if FHintWindow <> nil then
  begin
    FHintWindow.Free;
    FHintWindow := nil;
  end;
  if FCustomizeForm <> nil then
  begin
    FCustomizeForm.Free;
    FCustomizeForm := nil;
  end;
  inherited Destroy;
end;

function TCustomdxInspector.Add: TdxInspectorNode;
begin
  Result := CreateNode;
  FNodeList.Add(Result);
  AddNode(Result);
end;

procedure TCustomdxInspector.BeginUpdate;
begin
  Inc(FLockUpdate);
end;

procedure TCustomdxInspector.ClearNodes;
begin
  if not (csDestroying in ComponentState) then BeginUpdate;
  try
    while Count > 0 do Items[0].Free;
  finally
    if not (csDestroying in ComponentState) then EndUpdate;
  end;
end;

procedure TCustomdxInspector.HideCustomizeForm;
begin
  if FCustomizeForm <> nil then
    FCustomizeForm.Close;
end;

procedure TCustomdxInspector.ShowCustomizeForm;
begin
  HideCustomizeForm;
  FCustomizeForm := CreateInspectorCustomizeForm(Self);
  FCustomizeForm.Show;
end;

procedure TCustomdxInspector.EndUpdate;
begin
  Dec(FLockUpdate);
  LayoutChanged;
end;

procedure TCustomdxInspector.FullCollapse;
var
  I: Integer;
begin
  if Count = 0 then Exit;
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].Collapse(True{Recurse});
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxInspector.FullExpand;
var
  I: Integer;
begin
  if Count = 0 then Exit;
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[i].Expand(True{Recurse});
  finally
    EndUpdate;
  end;  
end;

function TCustomdxInspector.GetHitTestInfoAt(X, Y: Integer): TdxInspectorHitTest;
begin
  Result := GetHitInfo(Point(X, Y)).hitType;
end;

function TCustomdxInspector.GetNextVisible(Node: TdxInspectorNode):TdxInspectorNode;

  function GetLastVisible(Node: TdxInspectorNode): TdxInspectorNode;
  begin
    if Node.Parent = nil then
       Result := Items[Node.Index + 1]
    else
      if (Node.Parent.Count - 1) > Node.Index then
        Result := Node.Parent.Items[Node.Index + 1]
      else Result := GetLastVisible(Node.Parent);
  end;

begin
  if Node.Expanded then
     Result := Node.Items[0]
  else
    if Node.Parent = nil then
    begin
      Result := Items[Node.Index + 1]
    end
    else
    begin {Parent <> NIl}
      if Node.Index < (Node.Parent.Count - 1) then
        Result := Node.Parent.Items[Node.Index + 1]
      else {last node}
        Result := GetLastVisible(Node.Parent);
    end;
end;

function TCustomdxInspector.GetNodeAt(X, Y: Integer): TdxInspectorNode;
begin
  Result := GetHitInfo(Point(X, Y)).Node;
end;

function TCustomdxInspector.GetTopParentNode(ANode: TdxInspectorNode): TdxInspectorNode;
begin
  Result := ANode;
  while ANode <> nil do
  begin
    Result := ANode;
    ANode := ANode.Parent;
  end;
end;

function TCustomdxInspector.IndexOf(Value: TdxInspectorNode) : Integer;
begin
  Result := FNodeList.IndexOf(Value);
end;

function TCustomdxInspector.Insert(BeforeNode: TdxInspectorNode) : TdxInspectorNode;
begin
  Result := CreateNode;
  if (BeforeNode = nil) then FNodeList.Add(Result)
  else FNodeList.Insert(BeforeNode.Index, Result);
  AddNode(Result);
end;

function TCustomdxInspector.IsActive: Boolean;
begin
  Result := IsActiveControl or
    ((InplaceEditor <> nil) and InplaceEditor.IsFocused);
end;

function TCustomdxInspector.IsNodeVisible(Node: TdxInspectorNode): Boolean;
begin
  Result := False;
  repeat
    Node := Node.Parent;
    if Node = Nil then
    begin
      Result := True;
      Exit;
    end
    else
      if not Node.Expanded then Exit;
  until False;
end;

procedure TCustomdxInspector.MakeNodeVisible(Node: TdxInspectorNode);
var
  ABandIndex, ATopIndex, AIndex: Integer;
  FlagRepaint: Boolean;
  CurNode: TdxInspectorNode;
begin
  FlagRepaint := False;
  try
    if not Node.IsVisible then
    begin
      BeginUpdate;
      FlagRepaint := True;
      CurNode := Node.Parent;
      while CurNode <> nil do
      begin
        if not CurNode.Expanded then
          CurNode.Expanded := True;
        CurNode := CurNode.Parent;
      end;
    end;
    ATopIndex := GetAbsoluteIndex(TopVisibleNode);
    AIndex := GetAbsoluteIndex(Node);
    if (ATopIndex <= AIndex) and (AIndex <= (ATopIndex + RowCount - 1)) and
      not FlagRepaint then Exit;
    if IsAutoBandCount then
    begin
      ABandIndex := GetBandIndexByNode(Node);
      if ABandIndex < LeftBandIndex then
        LeftBandIndex := ABandIndex
      else
        if ABandIndex > (LeftBandIndex + VisibleBandCount - 1) then
          LeftBandIndex := ABandIndex - VisibleBandCount + 1;
    end
    else
    begin
      if AIndex < ATopIndex then
        TopIndex := AIndex
      else
        if AIndex > (ATopIndex + RowCount - 1) then
          TopIndex := AIndex - RowCount + 1;
    end;
  finally
    if FlagRepaint then EndUpdate;
  end;
end;

function TCustomdxInspector.PtInCustomizeForm(const P: TPoint): Boolean;
var
  ARect: TRect;
begin
  if (FCustomizeForm <> nil) and FCustomizeForm.HandleAllocated then
    GetWindowRect(FCustomizeForm.Handle, ARect)
  else
    SetRectEmpty(ARect);
  Result := PtInRect(ARect, P);
end;

// Editor : public methods
procedure TCustomdxInspector.HideEditor;
begin
  // hide editor if excluding ioEditing or deleting node
  FInplaceNode := nil;
  HideEdit(False);
  FInplaceEdit := nil;
end;

procedure TCustomdxInspector.InvalidateEditor;
begin
  FInplaceNode := nil;
  CheckEditor(False{no SetFocus if not focused}, True);
end;

procedure TCustomdxInspector.PostEditor; // MouseDown, KeyDown...
begin
  if (FInplaceEdit <> nil) and FInplaceEdit.IsVisible and
    (FInplaceNode <> nil) then InplaceEditor.ValidateEdit;
  HideEdit(True);
end;

procedure TCustomdxInspector.ShowEditor;
begin
  if not (ioEditing in Options) then Exit;
  if FocusedNode = nil then Exit;
//  UpdateEdit;
  CheckEditor(True{SetFocus if not focused}, False);
end;

procedure TCustomdxInspector.ShowEditorChar(Ch: Char);
begin
  ShowEditor;
  if InplaceEditor <> nil then
    PostMessage(InplaceEditor.Handle, WM_CHAR, Word(Ch), 0);
end;

procedure TCustomdxInspector.ShowEditorMouse(X, Y: Integer);
begin
  ShowEditor;
  if (ioEditing in Options) and (InplaceEditor <> nil) then
    InplaceEditor.MouseClick;
end;

procedure TCustomdxInspector.CalcContentDrawInfo(var ADrawInfo: TdxInspectorContentDrawInfo);

  procedure AddRow(var BandInfo: TdxInspectorBandInfo; ANode: TdxInspectorNode; ARowHeight: Integer);
  begin
    Inc(BandInfo.RowCount);
    ReallocMem(BandInfo.RowsInfo, BandInfo.RowCount * SizeOf(TdxInspectorRowInfo));
    BandInfo.RowsInfo^[BandInfo.RowCount - 1].Node := ANode;
    BandInfo.RowsInfo^[BandInfo.RowCount - 1].RowHeight := ARowHeight;
  end;

  procedure CalcBandInfo(var BandInfo: TdxInspectorBandInfo; const ARect: TRect;
    ABandIndex: Integer; var ACurNode: TdxInspectorNode; AWriteInfo: Boolean);
  var
    ABandHeight, ABandRowCount, AHeight, ANodeHeight: Integer;
    I: Integer;
  begin
    BandInfo.BandIndex := ABandIndex;
    BandInfo.BandRect := ARect;
    BandInfo.BandContentRect := BandInfo.BandRect;
    if IsAutoBandCount then
    begin
      BandInfo.BandSeparatorRect := BandInfo.BandContentRect;
      BandInfo.BandSeparatorRect.Left := BandInfo.BandSeparatorRect.Right - BandSeparatorWidth;
      BandInfo.BandContentRect.Right := BandInfo.BandSeparatorRect.Left;
    end;
    ABandHeight := BandInfo.BandContentRect.Bottom - BandInfo.BandContentRect.Top;
    ABandRowCount := 0;
    AHeight := 0;
    while ACurNode <> nil do
    begin
      ANodeHeight := GetNodeHeight(ACurNode);
      Inc(AHeight, ANodeHeight);
      Inc(ABandRowCount);
      if IsAutoBandCount and (AHeight > ABandHeight) and (ABandRowCount > 1) then
        Break;
      if AWriteInfo then
        AddRow(BandInfo, ACurNode, ANodeHeight);
      ACurNode := GetNextVisible(ACurNode);
      if AHeight >= ABandHeight then
        Break;
    end;
    if AWriteInfo then
    begin
      AHeight := 0;
      for I := 0 to BandInfo.RowCount - 1 do
        Inc(AHeight, BandInfo.RowsInfo^[I].RowHeight);
      BandInfo.PartRowVisible := AHeight > ABandHeight;
      if AHeight < ABandHeight then
        with BandInfo.BandContentRect do
          BandInfo.EmptyRect := Rect(Left, Top + AHeight, Right, Bottom);
    end;
  end;

  procedure CalcBandsInfo;
  var
    AStubBandInfo: TdxInspectorBandInfo;
    ACurNode: TdxInspectorNode;
    ARect: TRect;
    I: Integer;
  begin
    with ADrawInfo do
    begin
      BandCount := PartVisibleBandCount;
      BandsInfo := AllocMem(BandCount * SizeOf(TdxInspectorBandInfo));
      if IsAutoBandCount then
      begin
        ACurNode := TopNode;
        ARect := CRect;
        ARect.Right := ARect.Left + BandWidth;
        for I := 0 to LeftBandIndex + PartVisibleBandCount - 1 do
        begin
          if I < LeftBandIndex then
            CalcBandInfo(AStubBandInfo, ARect, I, ACurNode, False{calc only})
          else
          begin
            CalcBandInfo(BandsInfo^[I - LeftBandIndex], ARect, I, ACurNode, True);
            OffsetRect(ARect, BandWidth, 0);
          end;
        end;
      end
      else
      begin
        ACurNode := TopVisibleNode;
        CalcBandInfo(BandsInfo^[0], CRect, 0, ACurNode, True);
      end;
    end;
  end;

begin
  FillChar(ADrawInfo, SizeOf(ADrawInfo), 0);
  with ADrawInfo do
  begin
    CRect := ClientRect;
    CalcBandsInfo;
    if IsAutoBandCount and (BandCount * BandWidth < (CRect.Right - CRect.Left)) then
    begin
      EmptyRect := CRect;
      Inc(EmptyRect.Left, BandCount * BandWidth);
    end;
  end;
end;

procedure TCustomdxInspector.FreeContentDrawInfo(var ADrawInfo: TdxInspectorContentDrawInfo);

  procedure FreeBandsInfo(var ABandInfo: TdxInspectorBandInfo);
  begin
    if ABandInfo.RowsInfo <> nil then
    begin
      FreeMem(ABandInfo.RowsInfo);
      ABandInfo.RowsInfo := nil;
    end;
  end;

var
  I: Integer;
begin
  with ADrawInfo do
  begin
    for I := 0 to BandCount - 1 do
      FreeBandsInfo(BandsInfo^[I]);
    if BandsInfo <> nil then
    begin
      FreeMem(BandsInfo);
      BandsInfo := nil;
    end;
  end;
end;

procedure TCustomdxInspector.LoadFromRegistry(const ARegPath: string);
var
  ARegIniFile: TRegIniFile;
begin
  ARegIniFile := TRegIniFile.Create('');
  try
    if ARegIniFile.OpenKey(ARegPath, False) then
    begin
      ARegIniFile.CloseKey;
      LoadFromRegIni(ARegIniFile, ARegPath);
    end;
  finally
    ARegIniFile.Free;
  end;
end;

procedure TCustomdxInspector.SaveToRegistry(const ARegPath: string);
var
  ARegIniFile: TRegIniFile;
begin
  ARegIniFile := TRegIniFile.Create('');
  try
    SaveToRegIni(ARegIniFile, ARegPath);
  finally
    ARegIniFile.Free;
  end;
end;

// protected TCustomdxInspector
procedure TCustomdxInspector.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP or WS_CLIPCHILDREN;
    WindowClass.style := CS_DBLCLKS or CS_VREDRAW or CS_HREDRAW;
    if (FBorderStyle = bsSingle) and not Flat then
      if NewStyleControls and Ctl3D then
      begin
        Style := Style and not WS_BORDER;
        ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      end
      else
        Style := Style or WS_BORDER;
    Style := Style or WS_VSCROLL;
  end;
end;

procedure TCustomdxInspector.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  if not IsInternalDragging then
    inherited DoEndDrag(Target, X, Y)
  else
    DragCursor := FPrevDragCursor;
  FDragNode := nil;
  SetState(isNormal);
  CheckEditor(True, False);
  if (FDragImageNode <> nil) then
  begin
    FDragImageNode.Free;
    FDragImageNode := nil;
  end;
  if FDragObject <> nil then
  begin
    FDragObject.Free;
    FDragObject := nil;
  end;
end;

procedure TCustomdxInspector.DoExit;
begin
  inherited DoExit;
  HideEditor;
end;

procedure TCustomdxInspector.DoStartDrag(var DragObject: TDragObject);
var
  P: TPoint;
begin
  if not IsInternalDragging then
    inherited DoStartDrag(DragObject)
  else
    FPrevDragCursor := DragCursor;
  DrawDragNode;
  SetState(isNodeDragging);
  HideEditor;
  Windows.SetFocus(Handle);
  GetCursorPos(P);
  DoDragScroll(P);
  if IsInternalDragging then
  begin
    FDragObject := TdxInspectorDragControlObject.Create(Self);
    DragObject := FDragObject;
    if (FDragNode <> nil) and (FCustomizeForm <> nil) then
      SendMessage(FCustomizeForm.Handle, CM_PREPARECUSTOMIZEFORM, Integer(IsCategoryNode(FDragNode)), 0);
  end;
end;

procedure TCustomdxInspector.DragDrop(Source: TObject; X, Y: Integer);
var
  AHitTest: TdxInspectorHitTest;
  ADestinationNode: TdxInspectorNode;
  AAttachMode: TdxInspectorNodeAttachMode;
begin
  if IsInternalDragging then
  begin
    if (FDragNode <> nil) and PtInCustomizeForm(ClientToScreen(Point(X, Y))) then
      TdxInspectorRowNode(FDragNode).Row.Visible := False
    else
    begin
      AHitTest := GetHitTestInfoAt(X, Y);
      if AHitTest in [ihtIndent, ihtButton, ihtImage, ihtDisplayLabel, ihtLabel,
        ihtColumnEdge, ihtComplexRowSeparator, ihtNowhere] then
      begin
        ADestinationNode := GetNodeAt(X, Y);
        AAttachMode := inaAddChild;
        case AHitTest of
          ihtIndent, ihtButton, ihtImage:
            AAttachMode := inaInsert;
          ihtDisplayLabel, ihtLabel, ihtComplexRowSeparator:
            AAttachMode := inaAddChild;
          ihtNowhere:
          begin
            AAttachMode := inaAdd;
            ADestinationNode := Items[0];
          end;
        end;
        DragDropTo(FDragNode, ADestinationNode, AAttachMode);
        if (FDragNode <> nil) and (ADestinationNode <> nil) then
          FDragNode.MoveTo(ADestinationNode, AAttachMode);
      end;
    end;
  end
  else
    inherited DragDrop(Source, X, Y);
end;

procedure TCustomdxInspector.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  AHitTest: TdxInspectorHitTest;
begin
  if not IsInternalDragging then
    inherited DragOver(Source, X, Y, State, Accept)
  else
  begin
    if Accept then
    begin
      AHitTest := GetHitTestInfoAt(X, Y);
      case AHitTest of
        ihtIndent, ihtButton, ihtImage:
          DragCursor := crdxInspectorInsert;
        ihtDisplayLabel, ihtLabel, ihtComplexRowSeparator:
          DragCursor := crdxInspectorAddChild;
        ihtNowhere:
          DragCursor := crdxInspectorAdd;
      else
        Accept := False;
      end;
    end;
  end;
  if not Dragging then Exit;
  DoDragScroll(Point(X, Y));
end;

function TCustomdxInspector.GetDragImages: {$IFDEF DELPHI4}TDragImageList{$ELSE}TCustomImageList{$ENDIF};
begin
  Result := FDragImageNode;
end;

procedure TCustomdxInspector.KeyDown(var Key: Word; Shift: TShiftState);

  function IsTop: Boolean;
  begin
    Result := (FocusedNode = TopNode) and not (ioTabThrough in Options) and
      not ((Key = VK_TAB) and IsGoTabComplexRowAvailable(False));
  end;

  function IsBottom: Boolean;
  begin
    Result := (FocusedNode = LastNode) and not (ioTabThrough in Options) and
      not ((Key = VK_TAB) and IsGoTabComplexRowAvailable(True));
  end;

  procedure GoTab(AForward: Boolean);
  begin
    if GoTabComplexRow(AForward) then Exit;
    if not AForward then
    begin
      if (ioTabThrough in Options) and (FocusedNode = TopNode) then
        TWinControlAccess(GetParentForm(Self)).SelectNext(Self, False, True)
      else
        FocusedNumber := FocusedNumber - 1;
    end
    else
    begin
      if (ioTabThrough in Options) and (FocusedNode = LastNode) then
        TWinControlAccess(GetParentForm(Self)).SelectNext(Self, True, True)
      else
        FocusedNumber := FocusedNumber + 1;
    end;
  end;

begin
  // check visible
  inherited KeyDown(Key, Shift);
  if FState in [isColumnSizing, isBandSizing, isRowSizing] then
  begin
    if Key = VK_ESCAPE then
      CancelDragSizing;
    Exit;
  end;
  if Dragging and IsAutoDrag and (Key = VK_ESCAPE) then EndDrag(False);
  if Count = 0 then Exit;
  if (Key in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_TAB, VK_RETURN]) and
    (ioEditing in Options) then
  begin
    if ({*}((Key in [VK_UP, VK_PRIOR]) or ((Key = VK_TAB) and (ssShift in Shift))){*} and IsTop) or
       ({*}((Key in [VK_DOWN, VK_NEXT]) or ((Key = VK_TAB) and not (ssShift in Shift))){*} and IsBottom) then
    begin
      if Assigned(FInplaceEdit) and FInplaceEdit.Modified then
      begin
        PostEditor;
        InvalidateEditor;
      end;
      Exit;
    end;
    PostEditor;
  end;
  case Key of
    VK_NEXT:
      if ssCtrl in Shift then
        FocusedNumber := GetAbsoluteCount - 1
      else
        FocusedNumber := FocusedNumber + RowCount; // TODO: Band.RowCount?
    VK_PRIOR:
      if ssCtrl in Shift then
        FocusedNumber := 0
      else
        FocusedNumber := FocusedNumber - RowCount; // TODO: Band.RowCount?
    VK_UP:
      FocusedNumber := FocusedNumber - 1;
    VK_DOWN:
      FocusedNumber := FocusedNumber + 1;
    VK_ESCAPE:
      begin
        InvalidateEditor;
        if FInplaceEdit <> nil then
          FInplaceEdit.Deselect;
      end;
    VK_TAB:
      if not (ssAlt in Shift) then
        GoTab(not (ssShift in Shift));
    VK_RETURN:
      if (ioEnterThrough in Options) then
        GoTab(True);
  end;
  DoCheckKeyDown(Key, Shift);
  if (Key In [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_TAB, VK_RETURN]) and
    (ioEditing in Options) then
    InvalidateEditor;
end;

procedure TCustomdxInspector.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  function GetLastBandNode(ABandIndex: Integer): TdxInspectorNode;
  var
    ABandRowCount: Integer;
    ANode: TdxInspectorNode;
  begin
    GetBandRowInfo(False, ANode, ABandIndex, ABandRowCount);
    Result := GetAbsoluteNode(GetAbsoluteIndex(ANode) + ABandRowCount - 1);
  end;

var
  Node: TdxInspectorNode;
begin
  if Focused or ((FInplaceEdit <> nil) and (FInplaceEdit.Focused)) then
    PostEditor;
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
  begin
    SetFocus;
    //Windows.SetFocus(Handle);
    if not IsActiveControl then
    begin
      MouseCapture := False;
      Exit;
    end;
  end;

  FHitInfo := GetHitInfo(Point(X, Y));
  FComplexRowIndex := FHitInfo.ComplexRowIndex;

  // if Right button pressed then Cancel Drag and Sizing
  if (FState <> isNormal) and (Button = mbRight) then
    CancelDragSizing;

  if (FState = isNormal) and (Button = mbLeft) and (GetCapture = Handle) then
  begin
    if (FHitInfo.hitType = ihtColumnEdge) and (ioColumnSizing in Options) then
    begin
      SetState(isColumnSizing);
      FSaveSizingPos := DividerPos; // for dynamic sizing
      FSizingBandIndex := FHitInfo.BandIndex;
      FSizingPos := X;
      UpdateWindow(Handle);
      DrawSizingLine;
      Exit;
    end;
    if (FHitInfo.hitType = ihtBandSeparator) and (ioBandSizing in Options) then
    begin
      SetState(isBandSizing);
      FSaveSizingPos := BandWidth; // for dynamic sizing
      FSizingBandIndex := FHitInfo.BandIndex;
      FSizingPos := X;
      UpdateWindow(Handle);
      DrawSizingLine;
      Exit;
    end;
    if (FHitInfo.hitType = ihtRowEdge) and (FHitInfo.Node <> nil) then
    begin
      SetState(isRowSizing);
      FSaveSizingPos := GetNodeHeight(FHitInfo.Node); // for dynamic sizing
      FSizingNode := FHitInfo.Node;
      FSizingPos := Y;
      UpdateWindow(Handle);
      DrawSizingLine;
      Exit;
    end;
    if (FHitInfo.hitType in [ihtButton, ihtIndent, ihtImage, ihtDisplayLabel,
      ihtLabel, ihtComplexRowSeparator]) then
    begin
      SetState(isNodeDown);
      FDragNode := FHitInfo.Node;
      if PaintStyle = ipsCategorized then
        InvalidateNode(FDragNode, False);
      FPointDragging.X := X;
      FPointDragging.Y := Y;
      SetFocusedNode(FHitInfo.Node);
      if (FHitInfo.hitType = ihtButton) or
        ((FHitInfo.hitType in [ihtImage, ihtDisplayLabel]) and (ssDouble in Shift)) then
      begin
        FHitInfo.Node.Expanded := not FHitInfo.Node.Expanded;
        if (ssDouble in Shift) then DblClick;
        SetState(isNormal);
        inherited MouseDown(Button, Shift, X, Y);
        Exit;
      end;
      if X > FDividerPos then
      try
//        ShowEditorMouse(X, Y);
        ShowEditor;
        FInplaceComplexRowIndexPushed := FHitInfo.ComplexRowIndex;
        FInplaceEditPushed := FInplaceEdit;
        FInplaceNodePushed := FInplaceNode;
      except
        SetState(isNormal);
        raise;
      end
      else
        ShowEditor;
      Click;
      SetTimer(Handle, 1, 60, nil);
    end;
  end;

  if (Button = mbLeft) and (ssDouble in Shift) and
     (FHitInfo.hitType in [ihtNowhere]) then DblClick;

  if (Button in [mbLeft]) and (FHitInfo.hitType in [ihtNowhere]) then
  begin
    if IsAutoBandCount then
    begin
      if FHitInfo.BandIndex <> -1 then
        Node := GetLastBandNode(FHitInfo.BandIndex)
      else
       Node := nil;
    end
    else
      Node := LastNode;
    if Node <> nil then
    begin
      Node.Focused := True;
      Node.MakeVisible;
      ShowEditor;
    end;
  end;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomdxInspector.MouseMove(Shift: TShiftState; X, Y: Integer);

  procedure CorrectDividerPos(var AX: Integer);
  var
    ADividerPos: Integer;
  begin
    ADividerPos := AX - (FSizingBandIndex - LeftBandIndex) * BandWidth;
    CheckDividerPos(ADividerPos);
    AX := ADividerPos + (FSizingBandIndex - LeftBandIndex) * BandWidth;
  end;

  procedure CorrectBandSeparatorPos(var AX: Integer);
  var
    ABandWidth: Integer;
  begin
    ABandWidth := AX - (FSizingBandIndex - LeftBandIndex) * BandWidth;
    CheckBandWidth(ABandWidth);
    AX := ABandWidth + (FSizingBandIndex - LeftBandIndex) * BandWidth;
    if AX > ClientWidth then AX := ClientWidth;
  end;

  procedure CorrectRowPos(var AY: Integer; ANode: TdxInspectorNode);
  var
    ARect: TRect;
    AMinRowHeight: Integer;
  begin
    AMinRowHeight := GetMinRowHeight(ANode);
    if Assigned(FSizingNode) then
    begin
      ARect := GetRectNode(FSizingNode);
      if (AY - ARect.Top + 1) < AMinRowHeight then
        AY := ARect.Top + AMinRowHeight - 1;
    end;
    if AY > (ClientHeight - 1) then
      AY := ClientHeight - 1;
  end;

var
  Node: TdxInspectorNode;
begin
  FHitInfo := GetHitInfo(Point(X, Y));

  if FState = isColumnSizing then
  begin
    CorrectDividerPos(X);
    if FSizingPos <> X then
    begin
      DrawSizingLine;
      FSizingPos := X;
      DrawSizingLine;
      if IsDynamicColumnSizing then
        DividerPos := CalcDividerPos(FSizingPos);
    end;
  end;

  if FState = isBandSizing then
  begin
    CorrectBandSeparatorPos(X);
    if FSizingPos <> X then
    begin
      DrawSizingLine;
      FSizingPos := X;
      DrawSizingLine;
      BandWidth := CalcBandWidth(FSizingPos);
    end;
  end;

  if FState = isRowSizing then
  begin
    CorrectRowPos(Y, FHitInfo.Node);
    if FSizingPos <> Y then
    begin
      DrawSizingLine;
      FSizingPos := Y;
      DrawSizingLine;
    end;
  end;

  if FState = isNodeDown then
  begin
    HideRowHint;
    if not (ssLeft in Shift) then
      CheckDownNode(True)
    else
    if IsAutoDrag then
    begin
      if ((X < FPointDragging.X - 5) or (X > FPointDragging.X + 5) or
        (Y < FPointDragging.Y - 5) or (Y > FPointDragging.Y + 5)) then
      begin
        Node := FDragNode;
        if Node = nil then
          Node := FHitInfo.Node;
        if Node <> nil then
        begin
          if Node <> FocusedNode then
            Node.Focused := True;
          CheckDownNode(False);
          FDragNode := Node;
          BeginDrag(False);
        end;
      end;
    end
    else
    begin
      FHitInfo := GetHitInfo(Point(X, Y));
      if (FHitInfo.Node <> nil) and
        (FHitInfo.Node.AbsoluteIndex < TopIndex + RowCount) then  // completely visible
      begin
        SetFocusedNode(FHitInfo.Node);
        if (FocusedNode <> FInplaceNodePushed) then
          FInplaceNodePushed := nil;
      end;
    end;
  end;

  if ShowRowHint then
    if (FState = isNormal) and (FHitInfo.hitType in [ihtDisplayLabel, ihtLabel]) then
    begin
      if (FHitInfo.Node <> FPrevHintNode) or (FHitInfo.hitType <> FPrevHintTest) or
        (FHitInfo.ComplexRowIndex <> FPrevHintComplexRowIndex) then
        StartShowRowHint(True{wait});
      FPrevHintComplexRowIndex := FHitInfo.ComplexRowIndex;
      FPrevHintNode := FHitInfo.Node;
      FPrevHintTest := FHitInfo.hitType;
    end
    else
      ClearPrevHintNode;

  CheckHotTrackNode(FHitInfo.Node);

  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomdxInspector.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  procedure CalcRowHeight(ANode: TdxInspectorNode; AY: Integer);
  var
    ARect: TRect;
    AMinRowHeight: Integer;
  begin
    if Assigned(FSizingNode) then
    begin
      AMinRowHeight := GetMinRowHeight(ANode);
      ARect := GetRectNode(FSizingNode);
      if AY > (ClientHeight - 1) then
        AY := ClientHeight - 1;
      if (AY - ARect.Top + 1) < AMinRowHeight then
        AY := ARect.Top + AMinRowHeight - 1;
      SetNodeHeight(FSizingNode, AY - ARect.Top + 1);
    end;
  end;

begin
  FHitInfo := GetHitInfo(Point(X, Y));

  if FState = isNodeDown then
    CheckDownNode(FHitInfo.Node = FDragNode);

  if FState = isColumnSizing then
  begin
    DrawSizingLine;
    DividerPos := CalcDividerPos(FSizingPos);
    SetState(isNormal);
    UpdateDesigner;
  end;

  if FState = isBandSizing then
  begin
    DrawSizingLine;
    BandWidth := CalcBandWidth(FSizingPos);
    SetState(isNormal);
    UpdateDesigner;
  end;

  if FState = isRowSizing then
  begin
    DrawSizingLine;
    if FSizingNode <> nil then
      CalcRowHeight(FSizingNode, FSizingPos);
    SetState(isNormal);
    UpdateDesigner;
  end;

  if FState = isNodeDown then
  begin
    KillTimer(Handle, ScrollTimerId);
    SetState(isNormal);
  end;

  // new
  if (FInplaceEdit <> nil) and (FInplaceNode <> nil) and
    (FInplaceEdit = FInplaceEditPushed) and (FInplaceNode = FInplaceNodePushed) and
    (FHitInfo.hitType = ihtLabel) and (FHitInfo.ComplexRowIndex = FInplaceComplexRowIndexPushed) then
  begin
    FInplaceComplexRowIndexPushed := -1;
    FInplaceEditPushed := nil;
    FInplaceNodePushed := nil;
    FInplaceEdit.MouseClick;  // FInplaceEdit can be NULL (Custom Events)
    if FInplaceEdit <> nil then
      FInplaceEdit.InvalidateEdit;
  end;

  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomdxInspector.Loaded;
begin
  inherited Loaded;
  LayoutChanged;
end;

procedure TCustomdxInspector.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then
      Images := nil;
  end;
end;

procedure TCustomdxInspector.Paint;
var
  ADrawInfo: TdxInspectorContentDrawInfo;

  procedure DrawFocusFrame;
  var
    R: TRect;
    TmpRgn1, TmpRgn2: HRGN;
  begin
    R := GetRectByNode(FocusedNode, ADrawInfo);
    if IsRectEmpty(R) then Exit;
    with Canvas do
    begin
      R := Rect(R.Left - 1, R.Top - 2, R.Right + 1, R.Bottom);
      DrawEdge(Handle, R, BDR_SUNKENOUTER or BDR_SUNKENINNER, BF_TOPLEFT);
      DrawEdge(Handle, R, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
      // exclude rect
      TmpRgn1 := CreateRectRgnIndirect(R);
      R := Rect(R.Left + 2, R.Top + 2, R.Right - 1, R.Bottom - 1);
      TmpRgn2 := CreateRectRgnIndirect(R);
      CombineRgn(TmpRgn1, TmpRgn1, TmpRgn2, RGN_XOR);
      if GetClipRgn(Handle, TmpRgn2) = 0 then
      begin
        DeleteObject(TmpRgn2);
        TmpRgn2 := CreateRectRgnIndirect(ADrawInfo.CRect);
      end;
      CombineRgn(TmpRgn2, TmpRgn2, TmpRgn1, RGN_DIFF);
      SelectClipRgn(Handle, TmpRgn2);
      DeleteObject(TmpRgn2);
      DeleteObject(TmpRgn1);
    end;
  end;

  procedure DrawNETGridLine(ARowRect: TRect; ANode: TdxInspectorNode);
  var
    ANextNode, ATopParentNode: TdxInspectorNode;
    ABrush1, ABrush2: HBRUSH;
    ARect1, ARect2: TRect;
  begin
    ARowRect.Top := ARowRect.Bottom - 1;
    ARect1 := ARowRect;
    ARect1.Right := ARect1.Left + FIndent;
    ARect2 := ARowRect;
    Inc(ARect2.Left, FIndent);
    if IsCategoryNode(ANode) and (ANode.Level = 0) then
    begin
      ABrush2 := FGroupGridBrush;
      if ANode.Expanded then
      begin
        ABrush1 := FGroupBkBrush;
        Dec(ARect1.Right);
        Dec(ARect2.Left);
      end
      else
        ABrush1 := ABrush2;
    end
    else
    begin
      if ANode = LastNode then
        ABrush1 := FGridBrush 
      else
        ABrush1 := FBkBrush;
      ABrush2 := FGridBrush;
      ANextNode := ANode.GetNextNode;
      if (IsCategoryNode(ANextNode) and (ANextNode.Level = 0)) then
      begin
        ABrush2 := FGroupGridBrush;
        ABrush1 := ABrush2;
      end
      else
      begin
        ATopParentNode := GetTopParentNode(ANode);
        if IsCategoryNode(ATopParentNode) then
        begin
          if ATopParentNode.GetLastNode = ANode then
          begin
            ABrush1 := FGroupGridBrush;
            ABrush2 := ABrush1;
          end
          else
            ABrush1 := FGroupBkBrush;
        end;
      end;
    end;
    Windows.FillRect(Canvas.Handle, ARect1, ABrush1);
    Windows.FillRect(Canvas.Handle, ARect2, ABrush2);
  end;

  procedure DrawGridLine(ARowRect: TRect; ANode: TdxInspectorNode);
  var
    APrevBkColor, APrevTextColor: TColorRef;
    ABrush: HBRUSH;
  begin
    with Canvas do
    begin
      APrevBkColor := GetBkColor(Handle);
      APrevTextColor := GetTextColor(Handle);
      if PaintStyle in [ipsStandard, ipsExtended] then
      begin
        SetBkColor(Handle, ColorToRGB(FGridColor));
        SetTextColor(Handle, ColorToRGB(Self.Color));
        ABrush := HalftoneBrush;
      end
      else
        ABrush := FGridBrush;
      if PaintStyle = ipsNET then
        DrawNETGridLine(ARowRect, ANode)
      else
      begin
        ARowRect.Top := ARowRect.Bottom - 1;
        Windows.FillRect(Handle, ARowRect, ABrush);
      end;
      if PaintStyle in [ipsStandard, ipsExtended] then
      begin
        SetBkColor(Handle, APrevBkColor);
        SetTextColor(Handle, APrevTextColor);
      end;
    end;
  end;

  procedure DrawButton(AButtonRect: TRect; AButtonKind: TdxInspectorButtonKind);
  begin
    with Canvas, AButtonRect do
    begin
      Left := (Left + Right - dxInspectorButtonSize) div 2 - 1;
      Top := (Top + Bottom - dxInspectorButtonSize) div 2;
      Right := Left + dxInspectorButtonSize;
      Bottom := Top + dxInspectorButtonSize;
      // draw
      Pen.Color := Self.Font.Color;
      Windows.FillRect(Handle, AButtonRect, FBkBrush); // ?
      Polyline([Point(Left, Top), Point(Right-1, Top),
        Point(Right-1, Bottom-1), Point(Left, Bottom-1), Point(Left, Top)]);
      MoveTo(Left + 2, Top + 4);
      LineTo(Left + 7, Top + 4);
      if AButtonKind = ibkPlus then
      begin
        MoveTo(Left + 4, Top + 2);
        LineTo(Left + 4, Top + 7);
      end;
    end;
  end;

  procedure DrawToolboxButton(AButtonRect: TRect; AButtonKind: TdxInspectorButtonKind);
  var
    AButtonWidth, AButtonHeight: Integer;
  begin
    with Canvas, AButtonRect do
    begin
      FillRect(AButtonRect);
      if AButtonKind = ibkPlus then
      begin
        AButtonWidth := 6;
        AButtonHeight := 5;
      end
      else
      begin
        AButtonWidth := 5;
        AButtonHeight := 6;
      end;
      Left := (Left + Right - AButtonWidth) div 2;
      Top := (Top + Bottom - AButtonHeight) div 2;
      Right := Left + AButtonWidth;
      Bottom := Top + AButtonHeight;
      // draw
      Pen.Color := Self.Font.Color;
      DrawToolboxArrow(Canvas, AButtonRect, AButtonKind = ibkMinus);
    end;
  end;

  procedure DrawToolboxFrame(ARect: TRect; ANode: TdxInspectorNode; ANodeDrawInfo: TdxInspectorDrawInfo);
  var
    I: Integer;
  begin
    if IsCategoryNode(ANode) then
    begin
      // Indent
      FillRect(Canvas.Handle, ANodeDrawInfo.IndentRect, FBkBrush);
      // Frame
      ARect.Left := ANodeDrawInfo.IndentRect.Right;
      if ANode.Focused or IsHotTrackNode(ANode) then
      begin
        if (State = isNodeDown) and (FDragNode = ANode) then
        begin
          DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RIGHT or BF_BOTTOM or BF_ADJUST);
          DrawEdge(Canvas.Handle, ARect, BDR_SUNKENINNER, BF_LEFT or BF_TOP);
        end
        else
        begin
          DrawEdge(Canvas.Handle, ARect, BDR_RAISEDOUTER, BF_RIGHT or BF_BOTTOM or BF_ADJUST);
          DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_LEFT or BF_TOP);
        end;
      end
      else
        FrameRect(Canvas.Handle, ARect, FBkBrush);
      // Button
      if ANodeDrawInfo.ButtonKind <> ibkNone then
        DrawToolboxButton(ANodeDrawInfo.ButtonRect, ANodeDrawInfo.ButtonKind);
    end
    else
    begin
      // Frame
      for I := 0 to FRowFrameSize - 1 do
      begin
        FrameRect(Canvas.Handle, ARect, FBkBrush);
        InflateRect(ARect, -1, -1);
      end;
      // Indent
      FillRect(Canvas.Handle, ANodeDrawInfo.IndentRect, FBkBrush);
      // Button
      if ANodeDrawInfo.ButtonKind <> ibkNone then
        DrawButton(ANodeDrawInfo.ButtonRect, ANodeDrawInfo.ButtonKind);
    end;
  end;

  procedure DrawBand(ABandInfo: TdxInspectorBandInfo);
  var
    APrevDivider: Boolean;

    procedure DrawNode(ARect: TRect; ANode: TdxInspectorNode);
    var
      ANodeDrawInfo: TdxInspectorDrawInfo;
      ACaptionText, ADisplayText: string;
      AAlignment: TAlignment;
      TmpRgn1, TmpRgn2: HRGN;
      IsClipRgnExists: Boolean;
    begin
      CalcDrawInfo(ANode, ARect, ANodeDrawInfo);
      ACaptionText := '';
      ADisplayText := '';
      GetNodeText(ANode, ACaptionText, ADisplayText);
      with Canvas, ANodeDrawInfo do
      begin
        // Draw Caption
        Brush.Color := Self.Color;
        Font := Self.Font;
        if not (PaintStyle in [ipsStandard, ipsExtended]) then
        begin
          if PaintStyle = ipsCategorized then
          begin
            if IsCategoryNode(ANode) then
              Brush.Color := clBtnShadow;
            DrawToolboxFrame(ARect, ANode, ANodeDrawInfo);
          end;
          if (PaintStyle = ipsNET) and (IsCategoryNode(ANode) and (ANode.Level = 0)) then
            Brush.Color := FGroupColor;
          if ANode.Focused and (PaintStyle <> ipsCategorized) then
          begin
            Brush.Color := clHighlight;
            Font.Color := clHighlightText;
          end;
          if ANode.HasChildren and
            not ((PaintStyle in [ipsNET, ipsCategorized]) and not IsCategoryNode(ANode)) then
            Font.Style := Font.Style + [fsBold]
          else
            Font.Style := Font.Style - [fsBold];
        end;
        // set clip rgn (if needed)
        if not IsCategoryNode(ANode) and (IndentRect.Right > DisplayRect.Right) then
        begin
          TmpRgn1 := CreateRectRgn(0, 0, 0, 0); // PrevRgn
          IsClipRgnExists := GetClipRgn(Handle, TmpRgn1) = 1;
          TmpRgn2 := CreateRectRgn(ARect.Left, ARect.Top, DisplayRect.Right, ARect.Bottom);
          ExtSelectClipRgn(Handle, TmpRgn2, RGN_AND);
          DeleteObject(TmpRgn2);
        end
        else
        begin
          TmpRgn1 := 0;
          IsClipRgnExists := False;
        end;
        // Indent, Button, Caption
        if IsCategoryNode(ANode) then
          Font.Style := Font.Style + [fsBold];
        DoDrawCaption(Canvas, ANode,
          IndentRect, ButtonRect, ImageRect, ButtonKind, {Button region}
          DisplayRect, ACaptionText);
//        // Focus Rect for Category
        if IsActive and ANode.Focused and (PaintStyle = ipsCategorized) and not IsCategoryNode(ANode) then
          with DisplayRect do
            DrawFocused(Handle, Rect(Left - 1, Top, Right - 1, Bottom)); // TODO: !
        // restore clip rgn
        if TmpRgn1 <> 0 then
        begin
          if IsClipRgnExists then
            SelectClipRgn(Handle, TmpRgn1)
          else
            SelectClipRgn(Handle, 0);
          DeleteObject(TmpRgn1);
        end;
        if not IsCategoryNode(ANode) then
        begin
          if PaintStyle <> ipsCategorized then
          begin
            // Draw Divider
            if APrevDivider then Dec(ARect.Top);
            Inc(ARect.Left, FDividerPos);
            ARect.Right := ARect.Left + 1;
            if PaintStyle in [ipsStandard, ipsExtended] then
              DrawEdge(Canvas.Handle, ARect, EDGE_ETCHED, BF_LEFT)
            else
              Windows.FillRect(Canvas.Handle, ARect, FGridBrush);
            APrevDivider := True;
          end
          else
          begin
            Brush.Color := Self.Color;
            ARect := DisplayRect;
            ARect.Left := DisplayRect.Right;
            ARect.Right := ARect.Left + 2;
            FillRect(ARect);
          end;
          // Draw Value
          Brush.Color := Self.Color;
          Font := Self.Font;
          Font.Color := GetValueFontColor;
          if PaintStyle = ipsCategorized then
          begin
            Brush.Color := clWindow;
            Font.Color := Self.Font.Color;
          end
          else
            if ANode.Focused and (PaintStyle in [ipsStandard, ipsExtended]) then
            begin
              Brush.Color := EditColor{clWindow};
              Font.Color := Self.Font.Color;
            end;
          AAlignment := taLeftJustify;
          DoDrawValue(Canvas, ValueRect, ANode, ADisplayText, AAlignment);
        end
        else
          APrevDivider := False;
      end;
    end;

  var
    ARect: TRect;
    I, AHeight, ARowHeight: Integer;
  begin
    with Canvas do
    begin
      // Draw Band Separator
      if not IsRectEmpty(ABandInfo.BandSeparatorRect) then
      begin
        ARect := ABandInfo.BandSeparatorRect;
        ARect.Right := ARect.Left + 1; 
        Windows.FillRect(Handle, ARect, FGridBrush);
        OffsetRect(ARect, 1, 0);
        Brush.Color := Self.Color;
        FillRect(ARect);
        OffsetRect(ARect, 1, 0);
        Windows.FillRect(Handle, ARect, FGridBrush);
      end;
      // Empty Rect
      if not IsRectEmpty(ABandInfo.EmptyRect) then
      begin
        Brush.Color := Self.Color;
        FillRect(ABandInfo.EmptyRect);
      end;
      // Design Time Divider
      if (csDesigning in ComponentState) and (ABandInfo.RowCount = 0) then
      begin
        ARect := ABandInfo.BandContentRect;
        Inc(ARect.Left, FDividerPos);
        ARect.Right := ARect.Left + 1;
        if PaintStyle in [ipsStandard, ipsExtended] then
          DrawEdge(Handle, ARect, EDGE_ETCHED, BF_LEFT)
        else
          Windows.FillRect(Handle, ARect, FGridBrush);
      end;
      // Rows
      AHeight := 0;
      APrevDivider := False;
      ARect := ABandInfo.BandContentRect;
      Brush.Color := Self.Color;
      Font := Self.Font;
      for I := 0 to ABandInfo.RowCount - 1 do
      begin
        ARowHeight := ABandInfo.RowsInfo^[I].RowHeight;
        ARect.Top := AHeight;
        ARect.Bottom := ARect.Top + ARowHeight;
        if PaintStyle <> ipsCategorized then
        begin
          DrawGridLine(ARect, ABandInfo.RowsInfo^[I].Node);
          Dec(ARect.Bottom, GridSize);
        end;  
        // if RectVisible(Canvas.Handle, ARect) then TODO: PrevDivider
        DrawNode(ARect, ABandInfo.RowsInfo^[I].Node);
        Inc(AHeight, ARowHeight);
      end;
    end;
  end;

var
  I: Integer;
begin
  CheckEditor(False, False);
  if (FState = isNodeDragging) and (FDragImageNode <> nil) then
    FDragImageNode.HideDragImage;
  try
    CalcContentDrawInfo(ADrawInfo);
    FGridBrush := CreateSolidBrush(ColorToRGB(FGridColor));
    FGroupGridBrush := CreateSolidBrush(ColorToRGB(FGroupGridColor));
    FBkBrush := CreateSolidBrush(ColorToRGB(Self.Color));
    FGroupBkBrush := CreateSolidBrush(ColorToRGB(FGroupColor));
    try
      // Draw Focus Rect
      if PaintStyle in [ipsStandard, ipsExtended] then
        DrawFocusFrame;
      // Empty Rect
      if not IsRectEmpty(ADrawInfo.EmptyRect) then
      begin
        Canvas.Brush.Color := Self.Color;
        Canvas.FillRect(ADrawInfo.EmptyRect);
      end;
      // Draw Bands
      for I := 0 to ADrawInfo.BandCount - 1 do
        DrawBand(ADrawInfo.BandsInfo^[I]);
    finally
      if FGridBrush <> 0 then DeleteObject(FGridBrush);
      if FGroupGridBrush <> 0 then DeleteObject(FGroupGridBrush);
      if FBkBrush <> 0 then DeleteObject(FBkBrush);
      if FGroupBkBrush <> 0 then DeleteObject(FGroupBkBrush);
      FreeContentDrawInfo(ADrawInfo);
    end;
  finally
    if (FState = isNodeDragging) and (FDragImageNode <> nil) then
      FDragImageNode.ShowDragImage;
  end;
end;

procedure TCustomdxInspector.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_SETFOCUS then
    if (FInplaceEdit = nil) or (TWMsetFocus(Message).FocusedWnd <> FInplaceEdit.Handle) then
      CheckEditor(True, False);

  if (Message.Msg = WM_KEYDOWN) and (Message.wParam = VK_ESCAPE) and
      Dragging and IsAutoDrag then EndDrag(False);

  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and IsAutoDrag then
  begin
    if not IsControlMouseMsg(TWMMouse(Message)) then
    begin
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);
    end;
  end
  else
    inherited WndProc(Message);
end;

function TCustomdxInspector.AcquireFocus: Boolean;
begin
  Result := True;
end;

procedure TCustomdxInspector.AddNode(Node: TdxInspectorNode);
var
  RedrawNode: TdxInspectorNode;
begin
  {Close Edit}
  HideEditor;
  if TopVisibleNode = nil then FTopVisibleNode := Node;
  if FocusedNode = nil then FFocused := TopVisibleNode;
  RedrawNode := Node.GetPriorParentNode;
  if RedrawNode = nil then RedrawNode := Node;
  UpdateNode(RedrawNode, True {Below});
end;

function TCustomdxInspector.CalcBandWidth(ABandWidth: Integer): Integer;
begin
  Result := ABandWidth div (FSizingBandIndex - LeftBandIndex + 1);
end;

function TCustomdxInspector.CalcDividerPos(AX: Integer): Integer;
begin
  Result := AX - (FSizingBandIndex - LeftBandIndex) * BandWidth;
end;

procedure TCustomdxInspector.CalcDrawInfo(ANode: TdxInspectorNode; ARect: TRect;
  var ADrawInfo: TdxInspectorDrawInfo);
const
  indDisplay = 2;
begin
  FillChar(ADrawInfo, SizeOf(ADrawInfo), 0);
  with ADrawInfo do
  begin
    // Indent
    if PaintStyle = ipsCategorized then
    begin
      if IsCategoryNode(ANode) then
      begin
        IndentRect := Rect(ARect.Left, ARect.Top,
          ARect.Left + ANode.Level * FIndent, ARect.Bottom);
        InflateRect(ARect, -1, -1);
      end
      else
      begin
        InflateRect(ARect, -FRowFrameSize, -FRowFrameSize);
        IndentRect := Rect(ARect.Left, ARect.Top,
          ARect.Left + (ANode.Level + 1) * FIndent, ARect.Bottom);
        if IsCategoryNode(GetTopParentNode(ANode)) then
          Dec(IndentRect.Right, FIndent);
      end;
    end
    else
    begin
      IndentRect := Rect(ARect.Left, ARect.Top,
        ARect.Left + (ANode.Level + 1) * FIndent, ARect.Bottom);
      if PaintStyle in [ipsStandard] then
        Inc(IndentRect.Right, indDisplay);
    end;
    // Button
    if ANode.HasChildren then
    begin
      if ANode.Expanded then
        ButtonKind := ibkMinus
      else
        ButtonKind := ibkPlus;
      if (PaintStyle <> ipsCategorized) or not IsCategoryNode(ANode) then
        ButtonRect:= Rect(IndentRect.Right - FIndent, IndentRect.Top, // TODO: Toolbox
          IndentRect.Right, IndentRect.Bottom);
    end;
    // Image (in Toolbox style ignored for Category)
    if IsImageNode(ANode) then
    begin
      ImageRect := Rect(IndentRect.Right, ARect.Top, IndentRect.Right + FImageWidth, ARect.Bottom);
      Inc(IndentRect.Right, FImageWidth);
    end;
    DisplayRect := Rect(IndentRect.Right, ARect.Top, ARect.Left + FDividerPos, ARect.Bottom);
    if (PaintStyle = ipsCategorized) and IsCategoryNode(ANode) then
      Inc(DisplayRect.Left);
    ValueRect := Rect(ARect.Left + FDividerPos + 1, ARect.Top, ARect.Right, ARect.Bottom);
    if PaintStyle in [ipsStandard, ipsExtended, ipsCategorized] then // two pixels
      Inc(ValueRect.Left);
    if IsCategoryNode(ANode) then
    begin
      DisplayRect.Right := ValueRect.Right;
      if (ButtonKind <> ibkNone) and (PaintStyle = ipsCategorized) then
      begin
        ButtonRect:= Rect(DisplayRect.Right - FToolboxButtonWidth, DisplayRect.Top, // TODO: Toolbox
          DisplayRect.Right, DisplayRect.Bottom);
        Dec(DisplayRect.Right, FToolboxButtonWidth);
      end;    
    end;
  end;
end;

function TCustomdxInspector.CalcMinRowHeight(ACanvas: TCanvas): Integer;
begin
  Result := CalcTextHeight(ACanvas);
end;

function TCustomdxInspector.CalcTextHeight(ACanvas: TCanvas): Integer;
begin
  Result := ACanvas.TextHeight('Wg') + 2 + 1;
end;

procedure TCustomdxInspector.CancelDragSizing;
begin
  if FState in [isBandSizing, isColumnSizing, isRowSizing] then
  begin
    DrawSizingLine;
    SetState(isNormal);
    SetCursor(Screen.Cursors[Cursor]);
    if IsDynamicColumnSizing or (FState in [isBandSizing{, isRowSizing}]) then
    begin
      if FState = isRowSizing then
        // TODO: restore Row Height := FSaveSizingPos
      else
        if FState = isBandSizing then
          BandWidth := FSaveSizingPos
        else
          if FState = isColumnSizing then
            DividerPos := FSaveSizingPos;
      Invalidate;
      UpdateWindow(Handle);
    end;
  end;
  HideRowHint;
end;

procedure TCustomdxInspector.DeleteNode(Node, Prior, Next: TdxInspectorNode; IsLast, Redraw: Boolean);
var
  RedrawNode: TdxInspectorNode;
begin
  if Count = 0 then
  begin
    FTopVisibleNode := nil;
    FFocused := nil;
    FInplaceNode := nil;
    FSizingNode := nil;
    FHotTrackNode := nil;
    ClearPrevHintNode;
    if (FLockUpdate=0) and (Not (csDestroying in ComponentState)) then
    begin
      {Close Edit}
      HideEditor;
      UpdateScrollBar;
      Invalidate;
    end;
    Exit;
  end;
  RedrawNode := nil;
  if TopVisibleNode = Node then
  begin
    FTopVisibleNode := Prior;
    if FTopVisibleNode = nil then FTopVisibleNode := Next;
    RedrawNode := FTopVisibleNode;
  end;
  if FocusedNode = Node then
  begin
    FFocused := Prior;
    if FocusedNode = nil then FFocused := Next;
    if RedrawNode = nil then RedrawNode := FocusedNode;
  end;
  if FSizingNode = Node then
    FSizingNode := nil;
  if FHotTrackNode = Node then
    FHotTrackNode := nil;
  if Node = FPrevHintNode then
    ClearPrevHintNode;
  {Close Edit}
  HideEditor;
  if Redraw then
  begin
    if RedrawNode = nil then RedrawNode := Prior;
    if RedrawNode = nil then RedrawNode := Next;
    if RedrawNode <> nil then UpdateNode(RedrawNode, True{Below});
  end;
end;

procedure TCustomdxInspector.CheckComplexRowIndex(var AComplexRowIndex: Integer);
begin
end;

procedure TCustomdxInspector.CheckDownNode(AClick: Boolean);
var
  APrevNode: TdxInspectorNode;
begin
  SetState(isNormal);
  APrevNode := FDragNode;
  FDragNode := nil;
  InvalidateNode(APrevNode, False);
  if (PaintStyle = ipsCategorized) and AClick and
    (APrevNode <> nil) and IsCategoryNode(APrevNode) then
    APrevNode.Expanded := not APrevNode.Expanded;
end;

procedure TCustomdxInspector.CheckHotTrackNode(ANode: TdxInspectorNode);
var
  APrevNode: TdxInspectorNode;
begin
  if (State <> isNormal) or (csDesigning in ComponentState) or
    (PaintStyle <> ipsCategorized) then Exit;
  if FHotTrackNode <> ANode then
  begin
    APrevNode := FHotTrackNode;
    FHotTrackNode := ANode;
    InvalidateNode(FHotTrackNode, False);
    InvalidateNode(APrevNode, False);
  end;
end;

procedure TCustomdxInspector.CheckInplaceComplexRowIndex;
begin
  InplaceComplexRowIndex := InplaceComplexRowIndex; // Check Ranges
end;

procedure TCustomdxInspector.DoChangeNode(OldNode, Node : TdxInspectorNode);
begin
  if Assigned(FOnChangeNode) then FOnChangeNode(Self, OldNode, Node);
end;

procedure TCustomdxInspector.DoDragScroll(P: TPoint);
begin
  FHitInfo := GetHitInfo(P);
  if (FHitInfo.hitType in [ihtColumnEdge, ihtIndent, ihtButton, ihtImage,
    ihtDisplayLabel, ihtLabel, ihtComplexRowSeparator]) and (FHitInfo.Node <> nil) then
    FHitInfo.Node.Focused := True
  else
    if FHitInfo.hitType = ihtOutSide then
      SetTimer(Handle, 1, 60, nil);
end;

procedure TCustomdxInspector.DragDropTo(var ANode: TdxInspectorNode;
  ADestinationNode: TdxInspectorNode; AAttachMode: TdxInspectorNodeAttachMode);
begin
end;

procedure TCustomdxInspector.DrawCaption(ACanvas: TCanvas; ANode: TdxInspectorNode;
  const ADisplayRect: TRect; const AText: string);
begin
  DrawDisplayText(ACanvas, ADisplayRect, AText, taLeftJustify);
end;

procedure TCustomdxInspector.DrawComplexRowSeparator(ACanvas: TCanvas; const ARect: TRect; AIsCaption: Boolean);
var
  R: TRect;
begin
  R := ARect;
  InflateRect(R, 0, -2);
  R.Left := (R.Left + R.Right) div 2 - 1;
  R.Right := R.Left + 1;
  if (PaintStyle = ipsCategorized) and not AIsCaption then
    FillRect(ACanvas.Handle, ARect, FBkBrush)
  else
  begin
    ACanvas.FillRect(ARect);
    DrawEdge(ACanvas.Handle, R, EDGE_ETCHED, BF_LEFT);
  end;
end;

procedure TCustomdxInspector.DrawDisplayText(ACanvas: TCanvas; const ARect: TRect;
  const AText: string; AAlignment: TAlignment);

  procedure PrepareViewData(AViewData: TdxEditViewData);
  begin
    with AViewData do
    begin
      Enabled := True;
      Focused := False;
      Selected := False;
      // Style
      BorderColor := clNone;
      BorderStyle := xbsNone;
      ButtonStyle := EditStyleButtonStyle;
      ButtonTransparence := False;
      Edges := [edgLeft, edgTop, edgRight, edgBottom];
      Shadow := False;
      Transparent := False;
      // ViewBounds
      OffsetSize := Rect(0, 0, 0, 0);
      ViewBounds := ARect;
      // General
      if (ARect.Bottom - ARect.Top) > FTextHeight then
        DrawAlignment := daMultiLine
      else
        DrawAlignment := daSingleLine; //daVCenter;
      Font := ACanvas.Font.Handle;
      Brush := ACanvas.Brush.Handle;
      BkColor := ColorToRGB(ACanvas.Brush.Color);
      TextColor := ColorToRGB(ACanvas.Font.Color);
      Alignment := AAlignment;
      IsEditClass := False;
      Data := AText;
      DataLength := 0;
      CalcHeight := False;
    end;
    if AViewData is TdxTextEditViewData then
      with TdxTextEditViewData(AViewData) do
      begin
        EndEllipsis := ioDrawEndEllipsis in Options;
      end;
  end;

var
  AViewData: TdxEditViewData;
begin
  AViewData := TdxInplaceTextEdit.GetViewDataClass.Create;
  try
    PrepareViewData(AViewData);
    CalcCellViewBoundsRect(ARect, AViewData.ViewBounds);
    TdxInplaceTextEdit.Draw(ACanvas.Handle, ARect, AViewData, 0);
  finally
    AViewData.Free;
  end;
end;

procedure TCustomdxInspector.DoDrawCaption(ACanvas: TCanvas; ANode: TdxInspectorNode;
  AIndentRect, AButtonRect, AImageRect: TRect; AButtonKind: TdxInspectorButtonKind;
  ADisplayRect: TRect; var AText: String);
begin
  with ACanvas do
  begin
    // Draw Button
    if PaintStyle <> ipsCategorized then
      DrawButton(ACanvas, AIndentRect, AButtonRect, AButtonKind, ANode);
    if not IsRectEmpty(AImageRect) then
      WriteImage(ACanvas, AImageRect, GetImageIndex(ANode));
    // Draw Display
    DrawCaption(ACanvas, ANode, ADisplayRect, AText);
  end;
end;

function TCustomdxInspector.AssignEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := '';
end;

function TCustomdxInspector.EditStyleBorderStyle: TdxEditBorderStyle;
begin
  if PaintStyle = ipsCategorized then
    Result := xbsFlat
  else
    Result := xbsNone;
end;

function TCustomdxInspector.EditStyleButtonStyle: TdxEditButtonViewStyle;
begin
  if PaintStyle = ipsCategorized then
    Result := btsFlat
  else
    if Flat then
      Result := btsFlat
    else
      Result := bts3D;
end;

procedure TCustomdxInspector.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
var
  DC: HDC;
begin
  with TdxInplaceInspectorEdit(AInplaceEdit) do
  begin
    CloseFlag := False; // for Mask Edit
    // Color
    Color := Self.GetEditColor;
    DC := GetDC(0);
    try
      Color := GetNearestColor(DC, ColorToRGB(Color));
    finally
      ReleaseDC(0, DC);
    end;
    // Font
    Font.Assign(Self.GetEditFont);
    // Offset
    OffsetSize := Rect(1, 0, 0, 0);
  end;
end;

function TCustomdxInspector.InitEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := '';
end;

procedure TCustomdxInspector.DoDrawValue(ACanvas: TCanvas; ARect: TRect; ANode: TdxInspectorNode;
  var AText: string; var AAlignment: TAlignment);
begin
  // Default Draw
  with FCellViewData do
  begin
    Cell_Brush := ACanvas.Brush.Handle;
    Cell_Font := ACanvas.Font.Handle;
    Cell_BkColor := ACanvas.Brush.Color;
    Cell_TextColor := ACanvas.Font.Color;
    Cell_Alignment := AAlignment;
    Cell_Text := AText;
    Cell_TextLength := 0;  // full length
    Cell_Selected := False;
    Cell_DrawEndEllipsis := ioDrawEndEllipsis in Options;
    Cell_Node := ANode;
    Cell_HotTrackNode := IsHotTrackNode(ANode);
    with ARect do
      Cell_Rect := Rect(0, 0, Right - Left, Bottom - Top);
    InflateRect(Cell_Rect, 2, 2); // TODO PAINT2
  end;
  DefaultDrawCell(ACanvas, ARect, FCellViewData);
end;

procedure TCustomdxInspector.DoHideCustomizeForm;
begin
  FCustomizeFormPos.X := CustomizeForm.Left;
  FCustomizeFormPos.Y := CustomizeForm.Top;
  FCustomizeFormSize.X := CustomizeForm.Width;
  FCustomizeFormSize.Y := CustomizeForm.Height;
  if Assigned(FOnHideCustomizeForm) then FOnHideCustomizeForm(Self);
end;

procedure TCustomdxInspector.DoShowCustomizeForm;
begin
  // Size
  if (FCustomizeFormSize.X <> dxInspectorUndefinedValue) or
    (FCustomizeFormSize.Y <> dxInspectorUndefinedValue) then
  begin
    FCustomizeForm.Width := FCustomizeFormSize.X;
    FCustomizeForm.Height := FCustomizeFormSize.Y;
  end;
  // Position
  if (FCustomizeFormPos.X <> dxInspectorUndefinedValue) or
    (FCustomizeFormPos.Y <> dxInspectorUndefinedValue) then
  begin
    FCustomizeForm.Left := FCustomizeFormPos.X;
    FCustomizeForm.Top := FCustomizeFormPos.Y;
  end;
  if Assigned(FOnShowCustomizeForm) then FOnShowCustomizeForm(Self);
end;

procedure TCustomdxInspector.DefaultDrawCell(ACanvas: TCanvas; const ARect: TRect;
  ACellViewData: TdxInspectorCellViewData);
begin
end;

procedure TCustomdxInspector.CalcCellViewBoundsRect(const ACellRect: TRect; var AViewRect: TRect);
begin
  AViewRect := ACellRect;
  InflateRect(AViewRect, 2, 2);
end;

procedure TCustomdxInspector.DoEditChange(Sender: TObject);
begin
end;

procedure TCustomdxInspector.DoEditValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean);
begin
end;

procedure TCustomdxInspector.DoInternalLayout;
begin
  UpdateCustomizeForm;
end;

procedure TCustomdxInspector.GetComplexRowInfoAt(ANode: TdxInspectorNode; const ARect: TRect;
  const APos: TPoint; var ComplexRowIndex: Integer; var ComplexRowRect: TRect);
begin
  ComplexRowIndex := -1;
  SetRectEmpty(ComplexRowRect);
end;

function TCustomdxInspector.GetDefaultNodeHeight(ANode: TdxInspectorNode): Integer;
begin
  Result := RowHeight;
  if (PaintStyle = ipsCategorized) and IsCategoryNode(ANode) then
    Dec(Result, 2);
end;

function TCustomdxInspector.GetDragNodeText(ADragNode: TdxInspectorNode): string;
var
  S: string;
begin
  if ADragNode <> nil then
    GetNodeText(ADragNode, Result, S)
  else
    Result := '';
end;

function TCustomdxInspector.GetHitInfo(Pos: TPoint): TdxInspectorHitInfo;

  procedure InitHitInfo(var AHitInfo: TdxInspectorHitInfo);
  begin
    with AHitInfo do
    begin
      hitType := ihtOutside;
      Node := nil;
      Row := -1;
      BandIndex := -1;
      ComplexRowIndex := -1;
      SetRectEmpty(ComplexRowRect);
    end;
  end;

  procedure CalcNodeAndRect(ABandInfo: TdxInspectorBandInfo; var ANodeRect: TRect);
  var
    I, H: Integer;
  begin
    H := 0;
    ANodeRect := ABandInfo.BandContentRect;
    for I := 0 to ABandInfo.RowCount - 1 do
    begin
      ANodeRect.Top := H;
      ANodeRect.Bottom := ANodeRect.Top + ABandInfo.RowsInfo^[I].RowHeight;
      if PtInRect(ANodeRect, Pos) then
      begin
        Result.Node := ABandInfo.RowsInfo^[I].Node;
        Result.Row := Result.Node.AbsoluteIndex;
        Break;
      end;
      Inc(H, ABandInfo.RowsInfo^[I].RowHeight);
    end;
  end;

  procedure CalcNodeInfo(ANode: TdxInspectorNode; const ANodeRect: TRect);
  var
    ADrawInfo: TdxInspectorDrawInfo;
  begin
    if ANode <> nil then
    begin
      CalcDrawInfo(ANode, ANodeRect, ADrawInfo);
      // TODO: paintstyle ToolBox -> hitType Edge?
      if (PaintStyle = ipsCategorized) and IsCategoryNode(ANode) and (ANode.Level = 0) then
        Inc(ADrawInfo.IndentRect.Right, FIndent);
      if PtInRect(ADrawInfo.IndentRect, Pos) then
      begin
        Result.hitType := ihtIndent;
        if (ADrawInfo.ButtonKind <> ibkNone) and PtInRect(ADrawInfo.ButtonRect, Pos) then
          Result.hitType := ihtButton;
        if PtInRect(ADrawInfo.ImageRect, Pos) then
          Result.hitType := ihtImage;
      end
      else
      begin
        if (PaintStyle = ipsCategorized) and (ADrawInfo.ButtonKind <> ibkNone) and
          PtInRect(ADrawInfo.ButtonRect, Pos) then
          Result.hitType := ihtButton
        else
        begin
          if (Pos.X  <= (ANodeRect.Left + FDividerPos)) or IsCategoryNode(ANode) then
          begin
            Result.hitType := ihtDisplayLabel;
            GetComplexRowInfoAt(Result.Node, ADrawInfo.DisplayRect, Pos,
              Result.ComplexRowIndex, Result.ComplexRowRect);
          end
          else
          begin
            Result.hitType := ihtLabel;
            GetComplexRowInfoAt(Result.Node, ADrawInfo.ValueRect, Pos,
              Result.ComplexRowIndex, Result.ComplexRowRect);
          end;
          if not IsRectEmpty(Result.ComplexRowRect) and (Result.ComplexRowIndex = -1) then
            Result.hitType := ihtComplexRowSeparator;
        end;
      end;
    end;
  end;

  function GetClientEdgeRect(ADrawInfo: TdxInspectorContentDrawInfo): TRect;
  begin
    if IsAutoBandCount and (ADrawInfo.BandCount = 1) then
    begin
      Result := ADrawInfo.CRect;
      Result.Left := Result.Right - BandSeparatorWidth;
    end
    else
      SetRectEmpty(Result);
  end;

var
  ADrawInfo: TdxInspectorContentDrawInfo;
  I: Integer;
  ARect, ANodeRect: TRect;
begin
  InitHitInfo(Result);
  CalcContentDrawInfo(ADrawInfo);
  try
    if PtInRect(ADrawInfo.CRect, Pos) then
    begin
      Result.hitType := ihtNowhere;
      // Calc Band
      for I := 0 to ADrawInfo.BandCount - 1 do
      begin
        if PtInRect(ADrawInfo.BandsInfo^[I].BandRect, Pos) then
        begin
          Result.BandIndex := ADrawInfo.BandsInfo^[I].BandIndex;
          if PtInRect(ADrawInfo.BandsInfo^[I].BandSeparatorRect, Pos) or
            PtInRect(GetClientEdgeRect(ADrawInfo), Pos) then
            Result.hitType := ihtBandSeparator
          else
          begin
            // Node, Row
            CalcNodeAndRect(ADrawInfo.BandsInfo^[I], ANodeRect);
            // divider
            with ADrawInfo.BandsInfo^[I].BandContentRect do
              ARect := Rect(Left + FDividerPos - dxInspectorMaxResizeWidth, Top,
                Left + FDividerPos + dxInspectorMaxResizeWidth, Bottom);
            if PtInRect(ARect, Pos) and not IsCategoryNode(Result.Node) then
              Result.hitType := ihtColumnEdge
            else
            begin
              ARect := ANodeRect;
              ARect.Top := ARect.Bottom - dxInspectorMaxResizeWidth;
              if CanRowSizing and PtInRect(ARect, Pos) then
                Result.hitType := ihtRowEdge
              else
                CalcNodeInfo(Result.Node, ANodeRect);
            end;
          end;
        end;
      end;
    end;
  finally
    FreeContentDrawInfo(ADrawInfo);
  end;
end;

function TCustomdxInspector.GetImageIndex(Node: TdxInspectorNode): Integer;
begin
  Result := -1;
end;

function TCustomdxInspector.GetMinRowHeight(ANode: TdxInspectorNode): Integer;
begin
  Result := FMinRowHeight;
  if (PaintStyle = ipsCategorized) and IsCategoryNode(ANode) then
    Dec(Result, 2);
end;

function TCustomdxInspector.GetNodeHeight(ANode: TdxInspectorNode): Integer;
begin
  Result := GetDefaultNodeHeight(ANode);
end;

function TCustomdxInspector.GetRectByNode(ANode: TdxInspectorNode; ADrawInfo: TdxInspectorContentDrawInfo): TRect;
var
  I, J, H: Integer;
begin
  SetRectEmpty(Result);
  for I := 0 to ADrawInfo.BandCount - 1 do
  begin
    H := 0;
    for J := 0 to ADrawInfo.BandsInfo^[I].RowCount - 1 do
    begin
      if ADrawInfo.BandsInfo^[I].RowsInfo^[J].Node = ANode then
      begin
        Result := ADrawInfo.BandsInfo^[I].BandContentRect;
        Result.Top := H;
        Result.Bottom := Result.Top + ADrawInfo.BandsInfo^[I].RowsInfo^[J].RowHeight;
      end;
      Inc(H, ADrawInfo.BandsInfo^[I].RowsInfo^[J].RowHeight);
    end;
  end;
end;

function TCustomdxInspector.GetRectNode(ANode: TdxInspectorNode): TRect;
var
  ADrawInfo: TdxInspectorContentDrawInfo;
begin
  CalcContentDrawInfo(ADrawInfo);
  try
    Result := GetRectByNode(ANode, ADrawInfo);
  finally
    FreeContentDrawInfo(ADrawInfo);
  end;
end;

function TCustomdxInspector.GetRectNodeBelow(Node: TdxInspectorNode): TRect;
begin
  Result := GetRectNode(Node);
  Result.Bottom := ClientRect.Bottom;
end;

function TCustomdxInspector.GetSectionWidth: Integer;
begin
  if IsAutoBandCount then
    Result := BandWidth - BandSeparatorWidth
  else
    Result := {Client}Width;
end;

function TCustomdxInspector.GetValueFontColor: TColor;
begin
  Result := FValueFontColor;
  if GetSysColor(COLOR_BTNFACE) = 0 then
    Result := ColorToRGB(Result) xor $00FFFFFF;
end;

function TCustomdxInspector.GoTabComplexRow(AForward: Boolean): Boolean;
begin
  Result := False;
end;

procedure TCustomdxInspector.InvalidateNode(ANode: TdxInspectorNode; ABelow: Boolean);
begin
  if ANode = nil then Exit;
  if IsAutoBandCount and ABelow then
    Invalidate // TODO: !
  else
    if not ABelow then
      InvalidateRect(RecalcPaintRect(GetRectNode(ANode)))
    else
      InvalidateRect(RecalcPaintRect(GetRectNodeBelow(ANode)));
end;

function TCustomdxInspector.IsAutoDrag: Boolean;
begin
  Result := IsCustomizing or (DragMode = dmAutomatic);
end;

function TCustomdxInspector.IsCategoryNode(Node: TdxInspectorNode): Boolean;
begin
  Result := False;
end;

function TCustomdxInspector.IsComplexNode(ANode: TdxInspectorNode): Boolean;
begin
  Result := False;
end;

function TCustomdxInspector.IsCustomizing: Boolean;
begin
  Result := FCustomizeForm <> nil;
end;

function TCustomdxInspector.IsGoTabComplexRowAvailable(AForward: Boolean): Boolean;
begin
  Result := False;
end;

function TCustomdxInspector.IsHotTrackNode(ANode: TdxInspectorNode): Boolean;
begin
  Result := (FHotTrackNode = ANode) and (State = isNormal);
end;

function TCustomdxInspector.IsImageNode(Node: TdxInspectorNode): Boolean;
begin
  Result := (GetImageIndex(Node) <> -1) and
    not ((PaintStyle = ipsCategorized) and IsCategoryNode(Node));
end;

function TCustomdxInspector.IsInternalDragging: Boolean;
begin
  Result := IsCustomizing;
end;

function TCustomdxInspector.IsShowHintNode(ANode: TdxInspectorNode; AComplexRowIndex: Integer;
  const AComplexRowRect: TRect; IsValue: Boolean; const R: TRect;
  var AText: string; var X: Integer; var IsRowHint: Boolean): Boolean;
begin
  Result := False;
end;

procedure TCustomdxInspector.LayoutChanged;
begin
  if FLockUpdate <> 0 then Exit;
  Inc(FLockUpdate);
  try
    InternalLayout;
  finally
    Dec(FLockUpdate);
  end;
end;

procedure TCustomdxInspector.RedrawSelection;
begin
  InvalidateNode(FocusedNode, False);
end;

procedure TCustomdxInspector.UpdateCustomizeForm;
var
  AMsg: TMsg;
begin
  if csDestroying in ComponentState then Exit;
  if (FCustomizeForm <> nil) and FCustomizeForm.HandleAllocated and
    not PeekMessage(AMsg, FCustomizeForm.Handle, CM_UPDATECUSTOMIZEFORM,
      CM_UPDATECUSTOMIZEFORM, PM_NOREMOVE) then
    PostMessage(FCustomizeForm.Handle, CM_UPDATECUSTOMIZEFORM, 0, 0);
end;

procedure TCustomdxInspector.UpdateDesignEditor;
begin
end;

procedure TCustomdxInspector.UpdateNode(Node: TdxInspectorNode; Below: Boolean);
begin
  if Node.Deleting then Exit;
  if (FLockUpdate = 0) and not (csDestroying in ComponentState) and Node.IsVisible then
  begin
    if Below then
    begin
      UpdateScrollBar;
      UpdateTopCoord;
    end;
    InvalidateNode(Node, Below);
  end;
end;

procedure TCustomdxInspector.UpdateBandCount;

  procedure CalcVisibleBandCount;
  var
    W: Integer;
  begin
    W := ClientWidth;
    FVisibleBandCount := W div BandWidth;
    FPartVisibleBandCount := FVisibleBandCount;
    if ((W mod BandWidth) <> 0) and (LeftBandIndex <> (BandCount - 1)) then
      Inc(FPartVisibleBandCount);
  end;

  procedure CalcBandCount;
  var
    ANode: TdxInspectorNode;
    ABandRowCount, ABandHeight, AHeight, ANodeHeight: Integer;
  begin
    FBandCount := 1;
    ABandHeight := ClientHeight;
    ANode := TopNode;
    ABandRowCount := 0;
    AHeight := 0;
    while (ANode <> nil) do
    begin
      ANodeHeight := GetNodeHeight(ANode);
      Inc(ABandRowCount);
      Inc(AHeight, ANodeHeight);
      if AHeight >= ABandHeight then
      begin
        Inc(FBandCount);
        if (ABandRowCount > 1) and (AHeight > ABandHeight) then
        begin
          ABandRowCount := 1;
          AHeight := ANodeHeight;
        end
        else
        begin
          ABandRowCount := 0;
          AHeight := 0;
        end;
      end;
      ANode := GetNextVisible(ANode);
    end;
  end;

  procedure CheckBandCount;
  begin
    if FPartVisibleBandCount > FBandCount then
      FPartVisibleBandCount := FBandCount;
    if FVisibleBandCount > FBandCount then
      FBandCount := FVisibleBandCount;
    if FBandCount < 1 then
      FBandCount := 1;
    if FPartVisibleBandCount < 1 then
      FPartVisibleBandCount := 1;
    if FVisibleBandCount < 1 then
      FVisibleBandCount := 1;
  end;

begin
  CalcVisibleBandCount;
  CalcBandCount;
  CheckBandCount;
end;

procedure TCustomdxInspector.UpdateBandRowCount;
begin
  UpdateBandCount;
  UpdateRowCount;
end;

procedure TCustomdxInspector.UpdateRowCount;
var
  ADrawInfo: TdxInspectorContentDrawInfo;
  I: Integer;
begin
  CalcContentDrawInfo(ADrawInfo);
  try
    FRowCount := 0;
    FVisibleRowCount := 0;
    if IsAutoBandCount then
    begin
      for I := 0 to ADrawInfo.BandCount - 1 do
      begin
        if I < VisibleBandCount then
          Inc(FRowCount, ADrawInfo.BandsInfo^[I].RowCount);
        Inc(FVisibleRowCount, ADrawInfo.BandsInfo^[I].RowCount);
      end;
    end
    else
    begin
      FVisibleRowCount := ADrawInfo.BandsInfo^[0].RowCount;
      FRowCount := FVisibleRowCount;
      if ADrawInfo.BandsInfo^[0].PartRowVisible then
        Dec(FRowCount);
    end;
    if FVisibleRowCount < 1 then FVisibleRowCount := 1;
    if FRowCount < 1 then FRowCount := 1;
  finally
    FreeContentDrawInfo(ADrawInfo);
  end;
end;

procedure TCustomdxInspector.UpdateScrollBar;

  procedure HideScrollBar(ABarFlag: Integer);
  var
    SI: TScrollInfo;
  begin
    FillChar(SI, SizeOf(SI), 0);
    SI.cbSize := SizeOf(SI);
    SI.fMask := SIF_ALL;
    SetScrollInfo(ABarFlag, SI, True);
  end;

var
  SIOld, SINew: TScrollInfo;
  ACount: Integer;
begin
  if not HandleAllocated then Exit;
  UpdateBandRowCount;
  SIOld.cbSize := SizeOf(SIOld);
  SIOld.fMask := SIF_ALL;
  if IsAutoBandCount then
  begin
    GetScrollInfo(SB_HORZ, SIOld);
    SINew := SIOld;
    // calc
    SINew.nMin := 0;
    SINew.nPage := VisibleBandCount;
    ACount := BandCount;
    SINew.nMax :=  ACount - 1;
    if ACount <= VisibleBandCount then SINew.nMax := 0;
    SINew.nPos := LeftBandIndex;
    // set
    SetScrollInfo(SB_HORZ, SINew, True);
    HideScrollBar(SB_VERT);
  end
  else
  begin
    GetScrollInfo(SB_VERT, SIOld);
    SINew := SIOld;
    // calc
    SINew.nMin := 0;
    SINew.nPage := FRowCount;
    ACount := GetAbsoluteCount;
    SINew.nMax :=  ACount - 1;
    if ACount <= FRowCount then SINew.nMax := 0;
    SINew.nPos := TopIndex;
    // set
    SetScrollInfo(SB_VERT, SINew, True);
    HideScrollBar(SB_HORZ);
  end;
end;

procedure TCustomdxInspector.SetFocusedNode(Node: TdxInspectorNode);
var
  AOldNode: TdxInspectorNode;
begin
  AOldNode := FocusedNode;
  try
    if FLockUpdate <> 0 then
    begin
      FFocused := Node;
      Exit;
    end;
    if Node <> nil then Node.MakeVisible;
    if FocusedNode = Node then Exit;
    FFocused := Node;
    InvalidateNode(AOldNode, False);
    InvalidateNode(FocusedNode, False);
  finally
    if AOldNode <> FocusedNode then
    begin
      HideEditor;
//      FInplaceEdit := nil;
      CheckInplaceComplexRowIndex;
      DoChangeNode(AOldNode, FocusedNode);
    end;
  end;
end;

procedure TCustomdxInspector.SetFocusedNumber(AIndex: Integer);
var
  FSelIndex, FCount: Integer;
begin
  if Count = 0 then Exit;
  FSelIndex := FocusedNumber;
  if FSelIndex <> AIndex then
  begin
    if (AIndex < 0) then AIndex := 0;
    FCount := GetAbsoluteCount;
    if AIndex > (FCount-1) then AIndex := FCount-1;
    if (AIndex <> FSelIndex) then
      SetFocusedNode(GetAbsoluteNode(AIndex));
    Click;
  end;
end;

procedure TCustomdxInspector.SetNodeHeight(ANode: TdxInspectorNode; Value: Integer);
begin
end;

procedure TCustomdxInspector.LoadFromRegIni(ARegIniObject: TObject; APath: string);
var
  ARegIniWrapper: TdxRegIniWrapper;
begin
  // check "\"
  if (Length(APath) > 0) and (APath[1] <> '\') then
    APath := '\' + APath;
  while (Length(APath) > 0) and (APath[Length(APath)] = '\') do
    Delete(APath, Length(APath), 1);
  ARegIniWrapper := TdxRegIniWrapper.Create;
  try
    ARegIniWrapper.RegIniObject := ARegIniObject;
    with ARegIniWrapper do
    begin
      BeginUpdate;
      try
        ReadSettings(ARegIniWrapper, APath);
      finally
        EndUpdate;
      end;
    end;
  finally
    ARegIniWrapper.Free;
  end;
end;

procedure TCustomdxInspector.ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);
begin
  with ARegIniWrapper do
  begin
    BandWidth := ReadInteger(APath, 'BandWidth', BandWidth);
    DividerPos := ReadInteger(APath, 'DividerPos', DividerPos);
  end;
end;

procedure TCustomdxInspector.SaveToRegIni(ARegIniObject: TObject; APath: string);
var
  ARegIniWrapper: TdxRegIniWrapper;
begin
  // check "\"
  if (Length(APath) > 0) and (APath[1] <> '\') then
    APath := '\' + APath;
  while (Length(APath) > 0) and (APath[Length(APath)] = '\') do
    Delete(APath, Length(APath), 1);
  ARegIniWrapper := TdxRegIniWrapper.Create;
  try
    ARegIniWrapper.RegIniObject := ARegIniObject;
    with ARegIniWrapper do
    begin
      Erase(APath);
      WriteSettings(ARegIniWrapper, APath);
    end;
  finally
    ARegIniWrapper.Free;
  end;
end;

procedure TCustomdxInspector.WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);
begin
  with ARegIniWrapper do
  begin
    WriteInteger(APath, 'BandWidth', BandWidth);
    WriteInteger(APath, 'DividerPos', DividerPos);
  end;
end;

function TCustomdxInspector.CanEditAcceptKey(Key: Char): Boolean;
begin
  Result := True;
end;

function TCustomdxInspector.CanEditModify: Boolean;
begin
  Result := True;
end;

function TCustomdxInspector.CanEditShow: Boolean;
begin
  Result := (ioEditing in Options) and (FocusedNode <> nil) and
    not IsCategoryNode(FocusedNode) and
    not (csDesigning in ComponentState) and (FLockUpdate = 0) and HandleAllocated
    and (FState <> isNodeDragging) and not IsCustomizing;
end;

function TCustomdxInspector.CellRect(ANode: TdxInspectorNode): TRect;
var
  ARect: TRect;
  ADrawInfo: TdxInspectorDrawInfo;
begin
  ARect := GetRectNode(ANode);
  CalcDrawInfo(ANode, ARect, ADrawInfo);
  Result := ADrawInfo.ValueRect;
  Result.Bottom := Result.Bottom - GridSize;
end;

function TCustomdxInspector.CheckEditorWidth: Boolean;
begin
  Result := False;
end;

function TCustomdxInspector.CreateEditor(ANode: TdxInspectorNode): TdxInplaceEdit;
begin
  Result := TdxInplaceTextEdit.Create(Self);
end;

function TCustomdxInspector.CreateEditStyle(AEdit: TdxInplaceEdit): TdxEditStyle;
begin
  Result := TdxInspectorEditStyle.Create(AEdit, Self);
end;

procedure TCustomdxInspector.DoCheckKeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key <> 0) and (FocusedNode <> nil) then
  begin
    FocusedNode.MakeVisible;
    if IsCategoryNode(FocusedNode) then
      case Key of
        VK_LEFT:
          begin
            FocusedNode.MakeVisible;
            FocusedNode.Expanded := False;
          end;
        VK_RIGHT:
          begin
            FocusedNode.MakeVisible;
            FocusedNode.Expanded := True;
          end;
      end;
    if (ssCtrl in Shift) or IsCategoryNode(FocusedNode) then
      case Key of
        VK_SUBTRACT:
          begin
            FocusedNode.MakeVisible;
            FocusedNode.Expanded := False;
          end;
        VK_ADD:
          begin
            FocusedNode.MakeVisible;
            FocusedNode.Expanded := True;
          end;
        VK_MULTIPLY:
          begin
            if FocusedNode.HasChildren then
              FocusedNode.Expand(True{Recuse});
          end;
      end;
  end;
end;

function TCustomdxInspector.FindInplaceEdit(ANode:TdxInspectorNode):TdxInplaceEdit;
begin
  if FInplaceEdit <> nil then
    Result := FInplaceEdit
  else Result := nil;
end;

function TCustomdxInspector.GetEditColor: TColor;
begin
  Result := clWindow;
end;

function TCustomdxInspector.GetEditingText: string;
begin
  Result := '';
  if (ioEditing in Options) and (FInplaceEdit <> Nil) then
     Result := FInplaceEdit.GetEditingText;
end;

function TCustomdxInspector.GetEditRect(ANode: TdxInspectorNode): TRect;
begin
  Result := CellRect(ANode);
end;

procedure TCustomdxInspector.HideEdit(ABackFocus: Boolean);
begin
  if (FInplaceEdit <> nil) then
    try
      FInplaceEdit.CloseFlag := True;
      try
        if not (csDestroying in FInplaceEdit.ComponentState) then
          UpdateText;
      except
        if ABackFocus and (FInplaceNode <> Nil) and (ExceptObject <> nil) then
        begin
          FInplaceNode.MakeVisible;
          UpdateWindow(Handle);
        end;
        KillTimer(Handle, ScrollTimerId);
        SetState(isNormal);
        raise;
      end;
    finally
      if not ABackFocus then
      begin
        FInplaceNode := Nil;
        if FInplaceEdit <> nil then
          FInplaceEdit.Hide;
      end;
      ABackFocus := ABackFocus or
        ((FInplaceEdit <> nil) and (FInplaceEdit.HandleAllocated) and (GetFocus = FInplaceEdit.Handle));
      if ABackFocus and IsWindowVisible(Self.Handle) then
         Windows.SetFocus(Self.Handle);
    end;
end;

procedure TCustomdxInspector.InplaceEditKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited InplaceEditKeyDown(Key, Shift);
  DoCheckKeyDown(Key, Shift);
end;

function TCustomdxInspector.IsAutoBandCount: Boolean;
begin
  Result := ioAutoBandCount in Options;
end;

function TCustomdxInspector.IsDynamicColumnSizing: Boolean;
begin
  Result := ioDynamicColumnSizing in Options;
  if FState = isRowSizing then Result := False;
end;

function TCustomdxInspector.IsImmediateEditor: Boolean;
begin
  Result := True;
end;

function TCustomdxInspector.IsRowAutoHeight: Boolean;
begin
  Result := ioRowAutoHeight in Options;
end;

function TCustomdxInspector.CanRowSizing: Boolean;
begin
  Result := ioRowSizing in Options;
end;

function TCustomdxInspector.IsTabs: Boolean;
begin
  Result := (ioTabs in Options) and (GetAsyncKeyState(VK_CONTROL) >= 0);
end;

procedure TCustomdxInspector.SetEditingText(Value: string);
begin
  if (ioEditing in Options) and (FInplaceEdit <> nil) then
    FInplaceEdit.SetEditingText(Value);
end;

// private TCustomdxInspector tree
function TCustomdxInspector.GetAbsoluteCount: Integer;

  function GetExpandedCount(Node: TdxInspectorNode): Integer;
  var
    I: Integer;
  begin
    Result := Node.Count;
    for I := 0 to Node.Count - 1 do
      if Node[I].Expanded then
        Result := Result + GetExpandedCount(Node[I]);
  end;

var
  I: Integer;
begin
  Result := Count;
  for I := 0 to Count - 1 do
    if Items[I].Expanded then
      Result := Result + GetExpandedCount(Items[I]);
end;

function TCustomdxInspector.GetAbsoluteIndex(Node: TdxInspectorNode): Integer;
var
  Ret, I: Integer;
  CurNode: TdxInspectorNode;

  function FoundNode (ParentNode, FindNode: TdxInspectorNode): Boolean;
  var
    I: Integer;
    CurNode: TdxInspectorNode;
  begin
    Result := False;
    for I := 0 to ParentNode.Count - 1 do
    begin
      CurNode := ParentNode[I];
      Inc(Ret);
      if CurNode = FindNode then
      begin
        Result := True;
        Exit;
      end
      else
        if CurNode.Expanded then
          if FoundNode (CurNode, FindNode) then
          begin
            Result := True;
            Exit;
          end;
    end;
  end;

begin
  Ret := -1;
  Result := Ret;
  if (Node = nil) or (Count = 0) then Exit;
  for I :=0 to Count - 1 do
  begin
    CurNode := Items[I];
    Inc(Ret);
    if CurNode = Node then
    begin
      Result := Ret;
      Exit;
    end
    else
      if CurNode.Expanded then
        if FoundNode (CurNode, Node) then
        begin
          Result := Ret;
          Exit;
        end
  end;
end;

function TCustomdxInspector.GetAbsoluteNode(AIndex: Integer): TdxInspectorNode;
var
  I: Integer;
  k: Integer;
  CurNode: TdxInspectorNode;

  function GetNextNodes(Node: TdxInspectorNode): TdxInspectorNode;
  var
    k: Integer;
  begin
    Result := nil;
    for k := 0 to Node.Count - 1 do
    begin
      Inc(I);
      if I = AIndex then
      begin
        Result := Node[k];
        Exit;
      end;
      if Node[k].Expanded then
         Result := GetNextNodes(Node[k]);
      if Result <> nil then Exit;
    end;
  end;

begin
  Result := nil;
  I := -1;
  for k := 0 to Count - 1 do
  begin
    Inc(I);
    CurNode := Items[k];
    if I = AIndex then
    begin
      Result := CurNode;
      Exit;
    end;
    if CurNode.Expanded then
      Result := GetNextNodes(CurNode);
    if Result <> nil then Exit;
  end;
end;

function TCustomdxInspector.GetCount: Integer;
begin
  Result := FNodeList.Count;
end;

function TCustomdxInspector.GetFocused: TdxInspectorNode;
begin
  Result := FFocused;
end;

function TCustomdxInspector.GetFocusedNumber: Integer;
begin
  Result := -1;
  if FocusedNode <> nil then
    Result := GetAbsoluteIndex(FocusedNode);
end;

function TCustomdxInspector.GetLastNode: TdxInspectorNode;
begin
  if Count > 0 then
    Result := Items[Count - 1].GetLastNode
  else
    Result := nil;
end;

function TCustomdxInspector.GetNode(Index: Integer): TdxInspectorNode;
begin
  Result := nil;
  if(Index > -1) and (Index < Count) then
    Result := FNodeList.Items[Index];
end;

function TCustomdxInspector.GetTopIndex: Integer;
begin
  Result := -1;
  if TopVisibleNode <> nil then
    Result := GetAbsoluteIndex(TopVisibleNode);
end;

function TCustomdxInspector.GetTopNode: TdxInspectorNode;
begin
  Result := GetNode(0);
end;

procedure TCustomdxInspector.SetTopIndex(AIndex: Integer);
var
  ABandIndex, ACount, APrevTopIndex: Integer;
begin
  if Count = 0 then Exit;
  ACount := GetAbsoluteCount;
  APrevTopIndex := TopIndex;
  if AIndex > (ACount - 1) then
    AIndex := ACount - 1;
  if AIndex < 0 then AIndex := 0;
  if IsAutoBandCount then
  begin
    ABandIndex := GetBandIndexByNode(GetAbsoluteNode(AIndex));
    AIndex := GetAbsoluteIndex(GetBandTopNode(ABandIndex));
    if APrevTopIndex <> AIndex then
      LeftBandIndex := ABandIndex;
  end
  else
  begin
    if APrevTopIndex <> AIndex then
    begin
      if (AIndex + RowCount) > ACount then
        AIndex := ACount - RowCount;
      if AIndex < 0 then AIndex := 0;
      if AIndex <> APrevTopIndex then
      begin
        FTopVisibleNode := GetAbsoluteNode(AIndex);
        UpdateScrollBar;
        if FLockUpdate <> 0 then Exit;
        Invalidate;
      end;
    end;
  end;
end;

// Style
function TCustomdxInspector.GetOptions: TdxInspectorOptions;
begin
  Result := FOptions;
end;

procedure TCustomdxInspector.ImageListChange(Sender: TObject);
begin
  if HandleAllocated and (Sender = Images) then
    LayoutChanged;
end;

procedure TCustomdxInspector.InternalLayout;
var
  RestoreCanvas: Boolean;
  S: string;
begin
  if (csLoading in ComponentState) then Exit;
  RestoreCanvas := not HandleAllocated;
  if RestoreCanvas then
    Canvas.Handle := GetDC(0);
  try
    Canvas.Font := Self.Font;
    FToolboxButtonWidth := 6 + 2 * 2;
    if PaintStyle = ipsStandard then
      FIndent := Canvas.TextWidth('+')
    else
    if PaintStyle = ipsCategorized then
      FIndent := dxInspectorButtonSize + 5
    else
    if PaintStyle in [ipsSimple, ipsNET, ipsCategorized] then
      FIndent := dxInspectorButtonSize + 6
    else
      FIndent := dxInspectorButtonExSize + 4;
    // ComplexRowSeparatorWidth
    S := ComplexRowSeparator + '_';
    FCaptionComplexRowSeparatorWidth := Canvas.TextWidth(S);
    if PaintStyle = ipsCategorized then
      FComplexRowSeparatorWidth := 4
    else
      FComplexRowSeparatorWidth := FCaptionComplexRowSeparatorWidth;
    // Row Height
    if PaintStyle = ipsCategorized then
    begin
      FGridSize := 0;
      FRowFrameSize := 2;
    end
    else
    begin
      FGridSize := 1;
      FRowFrameSize := 0;
    end;
    FTextHeight := CalcTextHeight(Canvas);
    FMinRowHeight := CalcMinRowHeight(Canvas) + FGridSize + 2 * FRowFrameSize;
    if not FRowHeightAssigned then
      FRowHeight := FMinRowHeight;
    if FRowHeight < FMinRowHeight then
      FRowHeight := FMinRowHeight;
    if FRowHeight = FMinRowHeight then
      FRowHeightAssigned := False;
    // Images
    FImageWidth := 0;
    FImageHeight := 0;
    if Images <> nil then
    begin
      FImageWidth := Images.Width;
      FImageHeight := Images.Height;
    end;
    if FImageHeight > (FRowHeight - FGridSize - 2 * FRowFrameSize) then
      FRowHeight := FImageHeight + FGridSize + 2 * FRowFrameSize;
  finally
    if RestoreCanvas then
    begin
      ReleaseDC(0, Canvas.Handle);
      Canvas.Handle := 0;
    end;
  end;
  DoInternalLayout;
  UpdateScrollBar;
  UpdateTopCoord;
  Invalidate;
end;

function TCustomdxInspector.IsActiveControl: Boolean;
var
  H: hWnd;
begin
  Result := False;
  begin
    H := GetFocus;
    while IsWindow(H) and (Result = False) do
    begin
      if H = WindowHandle then
        Result := True
      else
        H := GetParent(H);
    end;
  end;
end;

function TCustomdxInspector.IsGridColorStored: Boolean;
begin
  Result := not ((FPaintStyle in [ipsStandard, ipsExtended]) and (FGridColor = dxclInspectorGridColor)) or
  (not (FPaintStyle in [ipsNET]) and (FGridColor = clBtnFace));
end;

function TCustomdxInspector.IsRowHeightStored: Boolean;
begin
  Result := FRowHeightAssigned;
end;

procedure TCustomdxInspector.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxInspector.SetComplexRowSeparator(const Value: string);
begin
  if FComplexRowSeparator <> Value then
  begin
    FComplexRowSeparator := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxInspector.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    {$IFDEF DELPHI4}
    if FFlat then
      ScrollBarStyle := ssFlat
    else
      ScrollBarStyle := ssRegular;
    {$ENDIF}
    RecreateWnd;
  end;
end;

procedure TCustomdxInspector.SetGridColor(Value: TColor);
begin
  if FGridColor <> Value then
  begin
    FGridColor := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxInspector.SetImages(Value: TImageList);
begin
  BeginUpdate;
  try
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if Value <> nil then
    begin
      Images.RegisterChanges(FImageChangeLink);
      Value.FreeNotification(Self);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxInspector.SetLeftBandIndex(Value: Integer);
begin
  if BandCount = 0 then Exit;
  if Value < 0 then Value := 0;
  if (Value + VisibleBandCount) > BandCount then Value := BandCount;
  if Value < 0 then Value := 0;
  if (LeftBandIndex <> Value) or
    (GetBandTopNode(FLeftBandIndex) <> TopVisibleNode) then
  begin
    FLeftBandIndex := Value;
    FTopVisibleNode := GetBandTopNode(FLeftBandIndex);
    UpdateScrollBar;
    UpdateTopCoord;
    Invalidate;
  end;
end;

procedure TCustomdxInspector.SetOptions(Value: TdxInspectorOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    SetDividerPos(DividerPos);
    LayoutChanged;
    CheckEditor(False, False);
  end;
end;

procedure TCustomdxInspector.SetPaintStyle(Value: TdxInspectorPaintStyle);
const
  PaintStyleSet = [ipsStandard, ipsExtended, ipsCategorized];
begin
  if PaintStyle <> Value then
  begin
    // restore default setting
    if (FPaintStyle in PaintStyleSet) <> (Value in PaintStyleSet) then
      if FPaintStyle in PaintStyleSet then
      begin
        if FValueFontColor = dxclInspectorValueFontColor then FValueFontColor := Self.Font.Color;
        if FGridColor = dxclInspectorGridColor then FGridColor := clBtnFace;
        if Color = dxclInspectorBackgroundColor then Color := clWindow;
      end
      else
      begin
        if FValueFontColor = Self.Font.Color then FValueFontColor := dxclInspectorValueFontColor;
        if FGridColor = clBtnFace then FGridColor := dxclInspectorGridColor;
        if Color = clWindow then Color := dxclInspectorBackgroundColor;
      end;
    FPaintStyle := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxInspector.SetRowHeight(Value: Integer);
begin
  if Value < FMinRowHeight then
    Value := FMinRowHeight;
  if FRowHeight <> Value then
  begin
    FRowHeight := Value;
    FRowHeightAssigned := True;
    LayoutChanged;
  end;
end;

procedure TCustomdxInspector.SetShowRowHint(Value: Boolean);
begin
  if FShowRowHint <> Value then
  begin
    FShowRowHint := Value;
    if Value then ShowHint := False;
  end;
end;

procedure TCustomdxInspector.SetState(Value: TdxInspectorState);
begin
  FState := Value;
end;

// Size & AutoWidth
function TCustomdxInspector.CalcAutoWidth: Integer;
begin
  if FDividerPosSave.Y = -1 then FDividerPosSave.Y := GetSectionWidth;
  if FDividerPosSave.Y = 0 then
  begin
    FDividerPosSave.Y := -1;
    Result := 0;
  end
  else
    Result := FDividerPosSave.X * GetSectionWidth div FDividerPosSave.Y;
{  Result := FDividerPosSave.X * GetSectionWidth div FDividerPosSave.Y;}
end;

procedure TCustomdxInspector.CheckBandWidth(var ABandWidth: Integer);
begin
  if ABandWidth < FMinBandWidth then
    ABandWidth := FMinBandWidth;
end;

procedure TCustomdxInspector.CheckDividerPos(var Pos: Integer);
begin
  if HandleAllocated and (GetSectionWidth > 0) then
  begin
    if Pos > (GetSectionWidth - FMinColumnWidth) then
      Pos := (GetSectionWidth - FMinColumnWidth);
    if Pos < FMinColumnWidth then
      Pos := FMinColumnWidth;
  end;
end;

function TCustomdxInspector.GetBandCount: Integer;
begin
  if IsAutoBandCount then
    Result := FBandCount
  else
    Result := 1;
end;

function TCustomdxInspector.GetFocusedBandIndex: Integer;
begin
  Result := GetBandIndexByNode(FocusedNode);
end;

function TCustomdxInspector.GetBandIndexByNode(ANode: TdxInspectorNode): Integer;
var
  ABandRowCount: Integer;
begin
  Result := -1;
  GetBandRowInfo(True, ANode, Result, ABandRowCount);
end;

function TCustomdxInspector.GetBandRowCount(ABandIndex: Integer): Integer;
var
  ANode: TdxInspectorNode;
begin
  if IsAutoBandCount then
    GetBandRowInfo(False, ANode, ABandIndex, Result)
  else
    Result := RowCount;
end;

procedure TCustomdxInspector.GetBandRowInfo(AByNode: Boolean; // if False then by BandIndex
  var Node: TdxInspectorNode; var BandIndex, BandRowCount: Integer);
var
  ABandHeight: Integer;

  function CalcBandRows(ABandIndex: Integer; var ACurNode: TdxInspectorNode): Boolean;
  var
    ABandRowCount, ANodeHeight, AHeight: Integer;
    ACurTopNode: TdxInspectorNode;
  begin
    Result := False;
    ABandRowCount := 0;
    AHeight := 0;
    ACurTopNode := ACurNode;
    while ACurNode <> nil do
    begin
      if AByNode and (ACurNode = Node) then
      begin
        BandIndex := ABandIndex;
        Result := True;
      end;
      ANodeHeight := GetNodeHeight(ACurNode);
      Inc(AHeight, ANodeHeight);
      Inc(ABandRowCount);
      if AHeight > ABandHeight then
      begin
        if ABandRowCount = 1 then
          ACurNode := GetNextVisible(ACurNode)
        else
        begin
          Dec(ABandRowCount);
          Result := False;
        end;  
        Break;
      end;
      ACurNode := GetNextVisible(ACurNode);
    end;
    if not AByNode and (ABandIndex = BandIndex) then
    begin
      Node := ACurTopNode;
      Result := True;
    end;
    if Result then
      BandRowCount := ABandRowCount;
  end;

var
  ACurNode: TdxInspectorNode;
  I: Integer;
begin
  if IsAutoBandCount and HandleAllocated then
  begin
    ACurNode := TopNode;
    ABandHeight := ClientHeight;
    for I := 0 to BandCount - 1 do
      if CalcBandRows(I, ACurNode) then
        Break;
  end;
end;

function TCustomdxInspector.GetBandTopNode(ABandIndex: Integer): TdxInspectorNode;
var
  ABandRowCount: Integer;
begin
  if IsAutoBandCount then
    GetBandRowInfo(False, Result, ABandIndex, ABandRowCount)
  else
    Result := TopVisibleNode;
end;

function TCustomdxInspector.GetLeftBandIndex: Integer;
begin
  if IsAutoBandCount then
    Result := FLeftBandIndex 
  else
    Result := 0;
end;

function TCustomdxInspector.GetPartVisibleBandCount: Integer;
begin
  if IsAutoBandCount then
    Result := FPartVisibleBandCount
  else
    Result := 1;
end;

function TCustomdxInspector.GetVisibleBandCount: Integer;
begin
  if IsAutoBandCount then
    Result := FVisibleBandCount
  else
    Result := 1;
end;

procedure TCustomdxInspector.SetBandWidth(Value: Integer);
begin
  CheckBandWidth(Value);
  if FBandWidth <> Value then
  begin
    FBandWidth := Value;
    LayoutChanged;
    if HandleAllocated then
      SendMessage(Handle, WM_SIZE, SIZE_RESTORED, 0); // TODO: method
  end;
end;

procedure TCustomdxInspector.SetDividerPos(Value: Integer);
begin
  CheckDividerPos(Value);
  if FDividerPos <> Value then
  begin
    FDividerPos := Value;
    Invalidate;
  end;
  if not FSizing then
  begin
    FDividerPosSave.X := FDividerPos;
    FDividerPosSave.Y := GetSectionWidth;
  end;
  // TODO: CHECK
  UpdateScrollBar;
  UpdateTopCoord;
end;

procedure TCustomdxInspector.SetMaxRowTextLineCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxRowTextLineCount <> Value then
  begin
    FMaxRowTextLineCount := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxInspector.SetMinBandWidth(Value: Integer);
begin
  if Value < dxInspectorLimitBandWidth then
    Value := dxInspectorLimitBandWidth;
  if FMinBandWidth <> Value then
  begin
    FMinBandWidth := Value;
    SetBandWidth(BandWidth);
  end;
end;

procedure TCustomdxInspector.SetMinColumnWidth(Value: Integer);
begin
  if Value < dxInspectorLimitColumnWidth then
    Value := dxInspectorLimitColumnWidth;
  if FMinColumnWidth <> Value then
  begin
    FMinColumnWidth := Value;
    SetDividerPos(DividerPos);
  end;
end;

procedure TCustomdxInspector.UpdateDesigner;
var
  ParentForm: {$IFNDEF DELPHI3}TForm{$ELSE}TCustomForm{$ENDIF};
begin
  if (csDesigning in ComponentState) and HandleAllocated and
    not (csUpdating in ComponentState) then
  begin
    ParentForm := GetParentForm(Self);
    if Assigned(ParentForm) and Assigned(ParentForm.Designer) then
      ParentForm.Designer.Modified;
  end;
end;

procedure TCustomdxInspector.UpdateTopCoord;

  function CalcPossibleRowCount: Integer;
  var
    ABandHeight, AHeight, ANodeHeight: Integer;
    ACurNode: TdxInspectorNode;
  begin
    Result := 0;
    AHeight := 0;
    ABandHeight := ClientHeight;
    ACurNode := GetAbsoluteNode(TopIndex + RowCount - 1);
    while ACurNode <> nil do
    begin
      ANodeHeight := GetNodeHeight(ACurNode);
      Inc(AHeight, ANodeHeight);
      if AHeight > ABandHeight then
        Break;
      Inc(Result);
      ACurNode := ACurNode.GetPriorNode;
    end;
  end;

var
  ATopIndex, APossibleRowCount, ACount: Integer;
  ALeftBandIndex, ABandCount: Integer;
begin
  if not HandleAllocated then Exit;
  if IsAutoBandCount then
  begin
    ALeftBandIndex := LeftBandIndex;
    ABandCount := BandCount;
    if (ALeftBandIndex + VisibleBandCount) > ABandCount then
      ALeftBandIndex := ABandCount - VisibleBandCount;
    if ALeftBandIndex < 0 then ALeftBandIndex := 0;
    LeftBandIndex := ALeftBandIndex;
  end
  else
  begin
    ATopIndex := TopIndex;
    ACount := GetAbsoluteCount;
    APossibleRowCount := CalcPossibleRowCount;
    if (ATopIndex + APossibleRowCount) > ACount then
      ATopIndex := ACount - APossibleRowCount;
    if ATopIndex < 0 then ATopIndex := 0;
    if ATopIndex <> TopIndex then TopIndex := ATopIndex;
  end;
end;

function TCustomdxInspector.GetCustomization: Boolean;
begin
  Result := CustomizeForm <> nil;
end;

procedure TCustomdxInspector.SetCustomization(Value: Boolean);
begin
  if Customization <> Value then
    if Value then
      ShowCustomizeForm
    else
      HideCustomizeForm;
end;

// Draw TCustomdxInspector
procedure TCustomdxInspector.DrawButton(ACanvas: TCanvas; ARect, AButtonRect: TRect;
  AButtonKind: TdxInspectorButtonKind; ANode: TdxInspectorNode);

  procedure DrawNETIndent(ARect: TRect);
  var
    ARect1, ARect2: TRect;
    ABrush1, ABrush2: HBRUSH;
    ANextNode, ATopParentNode: TdxInspectorNode;
  begin
    ARect1 := ARect;
    ARect1.Right := ARect1.Left + FIndent - 1;
    ARect2 := ARect;
    Inc(ARect2.Left, FIndent);
    ACanvas.FillRect(ARect2);
    Dec(ARect2.Left);
    ARect2.Right := ARect2.Left + 1;
    ANextNode := ANode.GetNextNode;
    if not ((IsCategoryNode(ANode) and (ANode.Level = 0)) or
      (IsCategoryNode(ANextNode) and (ANextNode.Level = 0))) then
      Inc(ARect2.Bottom);
    ABrush1 := FBkBrush;
    ABrush2 := FGridBrush;
    ATopParentNode := GetTopParentNode(ANode);
    if (IsCategoryNode(ANode) and (ANode.Level = 0)) or
      IsCategoryNode(ATopParentNode) then
    begin
      ABrush1 := FGroupBkBrush;
      if not (IsCategoryNode(ANode) and (ANode.Level = 0)) then
        ABrush2 := FGroupGridBrush;
    end;
    FillRect(ACanvas.Handle, ARect1, ABrush1);
    FillRect(ACanvas.Handle, ARect2, ABrush2);
  end;

  procedure DrawToolboxIndent(ARect: TRect);
  begin
    if IsCategoryNode(ANode) then
      FillRect(ACanvas.Handle, ARect, FBkBrush)
    else
      ACanvas.FillRect(ARect);
  end;

var
  Ch: Char;
begin
  with ACanvas do
  begin
    // TODO: !!
    if PaintStyle = ipsNET then
      DrawNETIndent(ARect)
    else
    if PaintStyle = ipsCategorized then
      DrawToolboxIndent(ARect)
    else
      FillRect(ARect);

    if AButtonKind <> ibkNone then
    begin
      if PaintStyle = ipsStandard then
      begin
        SetBkMode(Handle, TRANSPARENT);
        if AButtonKind = ibkMinus then Ch := '-' else Ch := '+';
        DrawText(Handle, PChar(@Ch), 1, AButtonRect,
          DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX or DT_SINGLELINE or DT_VCENTER or DT_CENTER);
      end
      else
      if PaintStyle = ipsExtended then
      begin
        with AButtonRect do
        begin
          // clac rect
          Left := (Left + Right - dxInspectorButtonExSize) div 2;
          Top := (Top + Bottom - dxInspectorButtonExSize) div 2;
          Right := Left + dxInspectorButtonExSize;
          Bottom := Top + dxInspectorButtonExSize;
          // draw
          DrawEdge(Handle, AButtonRect, BDR_RAISEDINNER, BF_LEFT or BF_TOP);
          DrawEdge(Handle, AButtonRect, BDR_RAISEDOUTER, BF_RIGHT or BF_BOTTOM);
          InflateRect(AButtonRect, -1, -1);
          DrawEdge(Handle, AButtonRect, BDR_RAISEDINNER, BF_RIGHT or BF_BOTTOM);
          Dec(Right);
          Dec(Bottom);
          Windows.FillRect(Handle, Rect(Left + 1, Top + 3, Left + 6, Top + 3 + 1), COLOR_BTNTEXT + 1);
          if AButtonKind = ibkPlus then
            Windows.FillRect(Handle, Rect(Left + 3, Top + 1, Left + 3 + 1, Top + 6), COLOR_BTNTEXT + 1);
        end;
      end
      else
      begin
        with AButtonRect do
        begin
          Left := (Left + Right - dxInspectorButtonSize) div 2;
          Top := (Top + Bottom - dxInspectorButtonSize) div 2;
          Right := Left + dxInspectorButtonSize;
          Bottom := Top + dxInspectorButtonSize;
          // draw
          Pen.Color := Font.Color;
          if PaintStyle = ipsNET then
          begin
            Pen.Color := Self.Font.Color;
            if IsCategoryNode(ANode) then
              Windows.FillRect(Handle, AButtonRect, FGroupBkBrush)
            else
              Windows.FillRect(Handle, AButtonRect, FBkBrush);
          end;
          Polyline([Point(Left, Top), Point(Right-1, Top),
            Point(Right-1, Bottom-1), Point(Left, Bottom-1), Point(Left, Top)]);
          MoveTo(Left + 2, Top + 4);
          LineTo(Left + 7, Top + 4);
          if AButtonKind = ibkPlus then
          begin
            MoveTo(Left + 4, Top + 2);
            LineTo(Left + 4, Top + 7);
          end;
        end;
      end;
    end;
  end;
end;

procedure TCustomdxInspector.DrawDragNode;
const
  indDrag = 32;
var
  ARect: TRect;
  S1: string;
  PrevBkColor, PrevTextColor: TColorRef;
begin
  ARect := Rect(0, 0, FDividerPos + indDrag, FTextHeight);
  with DrawBitmap, ARect Do
  begin
    Width := Right - Left;
    Height := Bottom - Top;
  end;
  with DrawBitmap.Canvas Do
  begin
    {Clear Node Rect }
    PrevBkColor := GetBkColor(Handle);
    SetBkColor(Handle, ColorToRGB(clBtnShadow));
    PrevTextColor := GetTextColor(Handle);
    SetTextColor(Handle, ColorToRGB(Self.Color));
    Windows.FillRect(Handle, ARect, HalftoneBrush);
    SetBkColor(Handle, PrevBkColor);
    SetTextColor(Handle, PrevTextColor);
    Font := Self.Font;
    Font.Style := [fsBold];
    InflateRect(ARect, -1, -1);
    ARect.Left := ARect.Left + indDrag - 2;
    // draw text
    S1 := GetDragNodeText(FDragNode);
    SetBkMode(Handle, TRANSPARENT);
    DrawText(Handle, PChar(S1), Length(S1), ARect,
        DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX or DT_SINGLELINE or DT_VCENTER);
  end;
  with DrawBitmap do
    BitBlt(Canvas.Handle, 0, 0, Width, Height, 0, 0, 0, DSTINVERT);
  // create TImageList
  if FDragImageNode = nil then
    FDragImageNode := TImageList.CreateSize(DrawBitmap.Width, DrawBitmap.Height);
  FDragImageNode.DrawingStyle := dsSelected;
  FDragImageNode.AddMasked(DrawBitmap, DrawBitmap.Canvas.Pixels[1, 0]{Self.Color});
end;

procedure TCustomdxInspector.DrawSizingLine;

  function GetBandRect(ABandIndex: Integer): TRect;
  begin
    Result := ClientRect;
    if IsAutoBandCount then
    begin
      Result.Right := Result.Left + BandWidth;
      OffsetRect(Result, (ABandIndex - LeftBandIndex) * BandWidth, 0);
    end;
  end;

var
  DC: HDC;
  PrevPen: HPEN;
  PrevROP2: Integer;
  ARect: TRect;
begin
  if IsDynamicColumnSizing or (FState in [isBandSizing{, isRowSizing}]) then Exit;
  DC := Canvas.Handle;
  PrevPen := SelectObject(DC, GetStockObject(BLACK_PEN));
  PrevROP2 := SetROP2(DC, R2_NOTXORPEN);
  try
    if FState = isRowSizing then
    begin
      if FSizingNode <> nil then
      begin
        ARect := GetRectNode(FSizingNode);
        ARect.Bottom := FSizingPos;
        Windows.MoveToEx(DC, ARect.Left, ARect.Bottom, nil);
        Windows.LineTo(DC, ARect.Right, ARect.Bottom);
      end;
    end
    else
      if FState = isColumnSizing then
      begin
        ARect := GetBandRect(FocusedBandIndex);
        Windows.MoveToEx(DC, FSizingPos, ARect.Top, nil);
        Windows.LineTo(DC, FSizingPos, ARect.Bottom);
      end;
  finally
    SetROP2(DC, PrevROP2);
    SelectObject(DC, PrevPen);
  end;
end;

procedure TCustomdxInspector.InvalidateRect(ARect:TRect);
begin
  if not HandleAllocated then Exit;
  Windows.InvalidateRect(Handle, @ARect, False);
end;

function TCustomdxInspector.RecalcPaintRect(ARect: TRect): TRect;
begin
  Result := ARect;
  if PaintStyle in [ipsStandard, ipsExtended] then
    Result.Top := Result.Top - 2;
  if IsAutoBandCount then
    InflateRect(Result, 2, 0);
end;

procedure TCustomdxInspector.WriteImage(ACanvas: TCanvas; ARect: TRect; Index: Integer);
begin
  if Assigned(Images) and (0 <= Index) and (Index < Images.Count) then
    Images.Draw(ACanvas, (ARect.Left + ARect.Right - Images.Width + 1) div 2,
      (ARect.Top + ARect.Bottom - Images.Height + 1) div 2, Index);
end;

// Editor TCustomdxInspector
procedure TCustomdxInspector.CheckEditor(ASetFocus, AFlagRefresh: Boolean);
var
  R, EditRect : TRect;
  FEdit: TdxInplaceEdit;

  procedure UpdateEditor;
  begin
    FInplaceComplexRowIndex := FComplexRowIndex;
    FInplaceNode := FocusedNode;
    BeginInitEdit;
    try
      InitEditProperties(FInplaceEdit);
      InitEditValue(FInplaceNode, FInplaceEdit);
      with TdxInplaceInspectorEdit(FInplaceEdit) do
      begin
        Modified := False;
        if Self.GetReadOnly then
          ReadOnly := True;
        SetActive(True);
      end;
    finally
      EndInitEdit;
    end;
  end;

begin
  if CanEditShow then
  begin
    if not ASetFocus and
       not (Focused or ((FInplaceEdit <> nil) and (FInplaceEdit.Focused))) then
    begin
      if (FInplaceEdit <> nil) and not FInplaceEdit.Focused and AFlagRefresh then
        UpdateEditor;
      Exit;
    end;
//    EditRect := CellRect(FocusedNode);
    EditRect := GetEditRect(FocusedNode);
    // Check class type
    FEdit := FindInplaceEdit(FocusedNode);
    if (FEdit = nil) then
    begin
      FInplaceNode := nil;
      HideEdit(False);
      FInplaceEdit := CreateEditor(FocusedNode);
      FInplaceEdit.Parent := Self;
      UpdateEditor;
      FInplaceEdit.Move(EditRect);
      Exit;
    end;
    if (FEdit <> FInplaceEdit) or (FocusedNode <> FInplaceNode) or
      (FInplaceComplexRowIndex <> FComplexRowIndex) then
    begin
      FInplaceNode := nil;
      HideEdit(False);
      FInplaceEdit := FEdit;
      UpdateEditor;
      FInplaceEdit.Move(EditRect);
      Exit;
    end;
    // Check Bounds
    GetWindowRect(FInplaceEdit.Handle, R);
    InflateRect(R, -dxEditBorderSize, -dxEditBorderSize);
    MapWindowPoints(0, Handle, R, 2);
    if not EqualRect(R, EditRect) or ASetFocus then
    begin
      FInplaceNode := FocusedNode;
      FInplaceEdit.Hide;
      if FInplaceEdit <> nil then
      begin
        FInplaceEdit.Move(EditRect);
        FInplaceEdit.Deselect;
      end;
    end;
  end
  else
    if (FInplaceEdit <> nil) and IsWindowVisible(FInplaceEdit.Handle) then
      HideEditor;
end;

function TCustomdxInspector.GetInplaceComplexRowIndex: Integer;
begin
  Result := FComplexRowIndex;
  if Result = -1 then
    Result := 0;
end;

procedure TCustomdxInspector.UpdateText;
begin
  if (FInplaceNode <> nil) then
    AssignEditValue(FInplaceNode, FInplaceEdit);
end;

// Hint
procedure TCustomdxInspector.ClearPrevHintNode;
begin
  FPrevHintComplexRowIndex := -1;
  FPrevHintNode := nil;
  FPrevHintTest := ihtOutside;
end;

procedure TCustomdxInspector.HideRowHint;
begin
  if FShowHintTimerId <> 0 then
  begin
    KillTimer(Handle, FShowHintTimerId);
    FShowHintTimerId := 0;
  end;
  if FHideHintTimerId <> 0 then
  begin
    KillTimer(Handle, FHideHintTimerId);
    FHideHintTimerId := 0;
  end;
  if FHintWindow <> nil then
    FHintWindow.HideHint;
end;

procedure TCustomdxInspector.SetInplaceComplexRowIndex(Value: Integer);
var
  APrevInplaceComplexRowIndex: Integer;
begin
  APrevInplaceComplexRowIndex := InplaceComplexRowIndex; // -1 equal 0
  CheckComplexRowIndex(Value);
  if FComplexRowIndex <> Value then
  begin
    FComplexRowIndex := Value;
    if APrevInplaceComplexRowIndex <> InplaceComplexRowIndex then
      InvalidateNode(FocusedNode, False);
  end;
end;

procedure TCustomdxInspector.StartShowRowHint(Wait: Boolean);
var
  P: TPoint;
  R, R1: TRect;
  S: string;
  HitInfo: TdxInspectorHitInfo;
  DrawInfo: TdxInspectorDrawInfo;
  AIsRowHint: Boolean;
begin
  GetCursorPos(P);
  HideRowHint;
  P := ScreenToClient(P);
  HitInfo := GetHitInfo(P);
  if (HitInfo.hitType in [ihtDisplayLabel, ihtLabel]) and (HitInfo.Node <> nil) then
  begin
    S := '';
    R := GetRectNode(HitInfo.Node);
    CalcDrawInfo(HitInfo.Node, R, DrawInfo);
    P.Y := R.Top - 2 + FRowFrameSize;
    if HitInfo.hitType = ihtDisplayLabel then
    begin
      R1 := DrawInfo.DisplayRect;
      P.X := R1.Left - 2;
      if not IsShowHintNode(HitInfo.Node, HitInfo.ComplexRowIndex, HitInfo.ComplexRowRect,
        False, R1, S, P.X, AIsRowHint) then
        S := '';
      if AIsRowHint then
      begin
        if Wait then
        begin
          FShowHintTimerId := SetTimer(Handle, ShowHintTimerId, WaitForShowHintTime, nil);
          Exit;
        end;
      end;
    end
    else
    begin
      R1 := DrawInfo.ValueRect;
      P.X := R1.Left - 1;
      if not IsShowHintNode(HitInfo.Node, HitInfo.ComplexRowIndex, HitInfo.ComplexRowRect,
        True, R1, S, P.X, AIsRowHint) then
        S := '';
    end;
    P := ClientToScreen(P);
    if S <> '' then
    begin
      if FHintWindow = nil then
        FHintWindow := TdxContainerHintWindow.Create(nil);
      FHintWindow.ActivateHintEx(P, 0{TODO MuliLine}, S, Self.Font, True);
      FHideHintTimerId := SetTimer(Handle, HideHintTimerId, WaitForHideHintTime, nil);
    end;
  end;
end;

// messages TCustomdxInspector
procedure TCustomdxInspector.WMCancelMode(var Msg: TMessage);
begin
  CancelDragSizing;
  inherited;
end;

procedure TCustomdxInspector.WMCaptureChanged(var Msg: TMessage);
begin
  inherited;
  if FState = isNodeDown then
  begin
    KillTimer(Handle, ScrollTimerId);
//      SetState(isNormal);
  end;
end;

procedure TCustomdxInspector.WMDestroy(var Msg: TWMDestroy);
begin
  HideRowHint;
  inherited;
end;

procedure TCustomdxInspector.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TCustomdxInspector.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
//  if ioTabs in Options then
//    Msg.Result := Msg.Result or DLGC_WANTTAB;
  if IsTabs {and (GetAsyncKeyState(VK_CONTROL) >= 0) }then
    Msg.Result := Msg.Result or DLGC_WANTTAB;
  if ioEditing in Options then
    Msg.Result := Msg.Result or DLGC_WANTCHARS;
end;

procedure TCustomdxInspector.WMHScroll(var Message: TWMHScroll);
var
  SI: TScrollInfo;
begin
  if not AcquireFocus then Exit;
  with Message do
    case ScrollCode of
      SB_LINEUP:
        LeftBandIndex := LeftBandIndex - 1;
      SB_LINEDOWN:
        LeftBandIndex := LeftBandIndex + 1;
      SB_PAGEUP:
        LeftBandIndex := LeftBandIndex - VisibleBandCount;
      SB_PAGEDOWN:
        LeftBandIndex := LeftBandIndex + VisibleBandCount;
      SB_THUMBTRACK:
        begin
          SI.cbSize := SizeOf(SI);
          SI.fMask := SIF_ALL;
          GetScrollInfo(SB_HORZ, SI);
          if SI.nTrackPos <= 0 then
            LeftBandIndex := 0
          else
            if SI.nTrackPos >= BandCount then
              LeFtBandIndex := BandCount
            else
              LeftBandIndex := SI.nTrackPos;
        end;
    end;
end;

procedure TCustomdxInspector.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if (FInplaceEdit <> nil) and (Msg.FocusedWnd = FInplaceEdit.Handle)
    then Exit;
  InvalidateNode(FocusedNode, False);
  if State = isNodeDown then SetState(isNormal); //after Abort
end;

procedure TCustomdxInspector.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
end;

procedure TCustomdxInspector.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  if (BorderStyle <> bsNone) and Flat then
    InflateRect(Message.CalcSize_Params.rgrc[0], -1, -1);
  inherited;
end;

procedure TCustomdxInspector.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  FHitTest := SmallPointToPoint(Msg.Pos);
end;

procedure TCustomdxInspector.WMNCPaint(var Message: TMessage);
var
  R : TRect;
  DC : HDC;
begin
  inherited;
  if not Flat or (BorderStyle = bsNone) then Exit;
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
  ReleaseDC(Handle, DC);
end;

procedure TCustomdxInspector.WMSetCursor(var Msg: TWMSetCursor);
var
  hInfo : TdxInspectorHitInfo;
  State: TdxInspectorState;
  Cur: HCURSOR;
begin
  Cur := 0;
  with Msg do
  begin
    if HitTest = HTCLIENT then
    begin
      State := isNormal;
      if FState in [isNormal{, isEditing}] then
      begin
        FHitTest := ScreenToClient(FHitTest);
        hInfo := GetHitInfo(FHitTest);
        if (hInfo.hitType = ihtColumnEdge) and
           (ioColumnSizing in Options) then
          State := isColumnSizing;
        if (hInfo.hitType = ihtBandseparator) and
           (ioBandSizing in Options) then
          State := isBandSizing;
        if (hInfo.hitType = ihtRowEdge) and
           (ioRowSizing in Options){?} then
          State := isRowSizing;
      end
      else
        State := FState;
      if (State in [isBandSizing, isColumnSizing]) then
        Cur := Screen.Cursors[crHSplit];
      if (State in [isRowSizing]) then
        Cur := Screen.Cursors[crVSplit];
    end;
  end;

  if Cur <> 0 then SetCursor(Cur)
  else inherited;
end;

procedure TCustomdxInspector.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if (FInplaceEdit = nil) or (Msg.FocusedWnd <> FInplaceEdit.Handle) then
  begin
    InvalidateNode(FocusedNode, False);
    CheckEditor(True{SetFocus if not focused}, False);
  end;
end;

procedure TCustomdxInspector.WMSize(var Msg: TWMSize);
var PrevState : Boolean;
begin
  inherited;
  PrevState := FSizing;
  FSizing := True;
  try
    UpdateScrollBar;
    if (ioAutoWidth in Options) and not (csLoading in ComponentState) and not FLoading then
      DividerPos := CalcAutoWidth
    else
      SetDividerPos(DividerPos);
    UpdateTopCoord;
  finally
    FSizing := PrevState;
  end;
  CheckEditor(False, False);
end;

procedure TCustomdxInspector.WMTimer(var Msg: TWMTimer);

  function GetRowsRect(APos: TPoint): TRect;
  var
    ADrawInfo: TdxInspectorContentDrawInfo;
    I, J: Integer;
  begin
    SetRectEmpty(Result);
    CalcContentDrawInfo(ADrawInfo);
    try
      for I := 0 to ADrawInfo.BandCount - 1 do
        if PtInRect(ADrawInfo.BandsInfo^[I].BandContentRect, APos) then
        begin
          Result := ADrawInfo.BandsInfo^[I].BandContentRect;
          Result.Bottom := Result.Top;
          for J := 0 to ADrawInfo.BandsInfo^[I].RowCount - 1 do
            Inc(Result.Bottom, ADrawInfo.BandsInfo^[I].RowsInfo^[J].RowHeight);
          Break;
        end;
    finally
      FreeContentDrawInfo(ADrawInfo);
    end;
  end;

var
  Pos: TPoint;
  ARect: TRect;
begin
  if Msg.TimerId = ScrollTimerId then // scroll
  begin
    if not (State in [isNodeDown, isNodeDragging]) then Exit;
    GetCursorPos(Pos);
    Pos := ScreenToClient(Pos);

    if Pos.X < 0 then
      Pos.X := 0
    else
      if Pos.X >= ClientWidth then
        Pos.X := ClientWidth - 1;

    ARect := GetRowsRect(Pos);
    if Pos.Y < ARect.Top then {ScrollUp}
    begin
      if not IsAutoBandCount and (TopIndex <> FocusedNumber) then
        FocusedNumber := TopIndex;
      FocusedNumber := FocusedNumber - 1;
    end;
    if Pos.Y > ARect.Bottom then {ScrollDown}
    begin
      if not IsAutoBandCount and ((TopIndex + RowCount - 1) <> FocusedNumber) then
        FocusedNumber := TopIndex + RowCount - 1;
      FocusedNumber := FocusedNumber + 1;
    end;
  end
  else
    if Msg.TimerId = HideHintTimerId then // hint
      HideRowHint
    else
      if Msg.TimerId = ShowHintTimerId then // show hint
        StartShowRowHint(False);
end;

procedure TCustomdxInspector.WMVScroll(var Message: TWMVScroll);
var
  SI: TScrollInfo;
begin
  if not AcquireFocus then Exit;
  with Message do
    case ScrollCode of
      SB_LINEUP:
        TopIndex := TopIndex - 1;
      SB_LINEDOWN:
        TopIndex := TopIndex + 1;
      SB_PAGEUP:
        TopIndex := TopIndex - RowCount;
      SB_PAGEDOWN:
        TopIndex := TopIndex + RowCount;
      SB_THUMBTRACK:
        begin
          SI.cbSize := sizeof(SI);
          SI.fMask := SIF_ALL;
          GetScrollInfo(SB_VERT, SI);
          if SI.nTrackPos <= 0 then
            TopIndex := 0
          else
            if SI.nTrackPos >= GetAbsoluteCount then
              TopIndex := GetAbsoluteCount
            else
              TopIndex := SI.nTrackPos;
        end;
    end;
end;

procedure TCustomdxInspector.CMCancelMode(var Msg: TMessage);
begin
  CancelDragSizing;
  if Assigned(FInplaceEdit) then
    TWinControlAccess(FInplaceEdit).WndProc(Msg);
  inherited;
end;

procedure TCustomdxInspector.CMColorChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomdxInspector.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if (FBorderStyle = bsSingle) and not Flat then RecreateWnd;
end;

procedure TCustomdxInspector.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
  AHitInfo: TdxInspectorHitInfo;
begin
  Msg.Result := 0;
  AHitInfo := GetHitInfo(Point(Msg.Pos.X, Msg.Pos.Y));
  if (AHitInfo.hitType = ihtColumnEdge) or (FState = isColumnSizing) or
    (AHitInfo.hitType = ihtBandSeparator) or (FState = isBandSizing) or
    (AHitInfo.hitType = ihtRowEdge) or (FState = isRowSizing) or
    (AHitInfo.hitType = ihtButton) then Msg.Result := 1;
end;

procedure TCustomdxInspector.CMFontChanged(var Message: TMessage);
begin
  inherited;
  LayoutChanged;
end;

procedure TCustomdxInspector.CMMouseEnter(var Message: TMessage);
var
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  P := ScreenToClient(P);
  CheckHotTrackNode(GetHitInfo(P).Node);
end;

procedure TCustomdxInspector.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  CheckHotTrackNode(nil);
  HideRowHint;
  ClearPrevHintNode;
end;

procedure TCustomdxInspector.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  LayoutChanged;
end;

procedure TCustomdxInspector.CMShowHintChanged(var Message: TMessage);
begin
  inherited;
  if ShowHint then ShowRowHint := False;
end;

{ TdxInspectorEditStyle }

constructor TdxInspectorEditStyle.Create(AEdit: TdxInplaceEdit; AInspector: TCustomdxInspector);
begin
  inherited Create(AEdit);
  FInspector := AInspector;
end;

function TdxInspectorEditStyle.DefaultBorderColor: TColor;
begin
  Result := clWindowFrame;
end;

function TdxInspectorEditStyle.DefaultBorderStyle: TdxEditBorderStyle;
begin
  Result := Inspector.EditStyleBorderStyle;
end;

function TdxInspectorEditStyle.DefaultButtonStyle: TdxEditButtonViewStyle;
begin
  Result := Inspector.EditStyleButtonStyle;
end;

function TdxInspectorEditStyle.DefaultButtonTransparence: TdxEditButtonTransparence;
begin
  Result := ebtNone;
end;

function TdxInspectorEditStyle.DefaultEdges: TdxEditEdges;
begin
  Result := [edgLeft, edgTop, edgRight, edgBottom];
end;

function TdxInspectorEditStyle.DefaultHotTrack: Boolean;
begin
  Result := False;
end;

function TdxInspectorEditStyle.DefaultShadow: Boolean;
begin
  Result := False;
end;

{ TdxInspectorRow }

constructor TdxInspectorRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImageIndex := -1;
  FViewData := GetdxInplaceEditClass.GetViewDataClass.Create;
  FVisible := True;
end;

destructor TdxInspectorRow.Destroy;
begin
  if (Inspector <> nil) {and
     not (csDestroying in Inspector.ComponentState)} then
    Inspector.RemoveRow(Self);
  FViewData.Free;
  inherited Destroy;
end;

procedure TdxInspectorRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      RestoreDefaults;
      Alignment := TdxInspectorRow(Source).Alignment;
      if rvCaption in TdxInspectorRow(Source).AssignedValues then
        Caption := TdxInspectorRow(Source).Caption;
      if rvReadOnly in TdxInspectorRow(Source).AssignedValues then
        ReadOnly := TdxInspectorRow(Source).ReadOnly;
      if rvMaxLength in TdxInspectorRow(Source).AssignedValues then
        MaxLength := TdxInspectorRow(Source).MaxLength;
      if rvRowHeight in TdxInspectorRow(Source).AssignedValues then
        RowHeight := TdxInspectorRow(Source).RowHeight;
      Hint := TdxInspectorRow(Source).Hint;
      ShowHint := TdxInspectorRow(Source).ShowHint;
      IsCategory := TdxInspectorRow(Source).IsCategory;
      CharCase := TdxInspectorRow(Source).CharCase;
      Visible := TdxInspectorRow(Source).Visible;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorRow.DefaultCaption: String;
begin
  Result := '';
end;

function TdxInspectorRow.DefaultMaxLength: Integer;
begin
  Result := 0;
end;

function TdxInspectorRow.DefaultReadOnly: Boolean;
begin
  Result := False;
end;

function TdxInspectorRow.DefaultRowHeight: Integer;
begin
  if Assigned(Inspector) then
    Result := Inspector.GetDefaultNodeHeight(Node)
  else
    Result := 0;
end;

function TdxInspectorRow.GetParentComponent: TComponent;
begin
  Result := Inspector;
end;

function TdxInspectorRow.HasParent: Boolean;
begin
  Result := True;
end;

function TdxInspectorRow.IsCanModify: Boolean;
begin
  Result := True;
end;

function TdxInspectorRow.IsValidChar(InputChar: Char): Boolean;
begin
  Result := True;
end;

procedure TdxInspectorRow.RestoreDefaultRowHeight;
begin
  RowHeight := DefaultRowHeight;
end;

procedure TdxInspectorRow.RestoreDefaults;
begin
  FAssignedValues := [];
  FAlignment := taLeftJustify;
  FShowHint := False;
  FIsCategory := False;
  FCharCase := ecNormal;
  FRowHeight := 0;
end;

// protected TdxInspectorRow
procedure TdxInspectorRow.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TCustomdxInspectorControl then
    Inspector := TCustomdxInspectorControl(Reader.Parent);
end;

procedure TdxInspectorRow.SetName(const Value: TComponentName);
begin
  inherited SetName(Value);
  if (Assigned(FOnChangeName)) then FOnChangeName(self);
  if Inspector <> nil then
    Inspector.UpdateDesignEditor;
end;

procedure TdxInspectorRow.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then
    Inspector := AParent as TCustomdxInspectorControl;
end;

procedure TdxInspectorRow.DoChange(Sender: TObject);
begin
  if (Inspector <> nil) and not Inspector.IsInitEdit then
  begin
    Inspector.DoEditChange(Self);
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TdxInspectorRow.DoDrawCaption(ACanvas:TCanvas;
  AIndentRect, AButtonRect, AImageRect: TRect; AButtonKind: TdxInspectorButtonKind;
  ADisplayRect: TRect; var AText: string; var ADone: Boolean);
var
  AColor: TColor;
begin
  if Assigned(FOnDrawCaption) then
  begin
    AColor := ACanvas.Brush.Color;
    FOnDrawCaption(Self, ACanvas, ADisplayRect, AText, ACanvas.Font, AColor, ADone);
    ACanvas.Brush.Color := AColor;
  end;
end;

procedure TdxInspectorRow.DoDrawValue(ACanvas:TCanvas; ARect : TRect; var AText: string; var ADone: Boolean);
var
  AColor: TColor;
begin
  if Assigned(FOnDrawValue) then
  begin
    AColor := ACanvas.Brush.Color;
    FOnDrawValue(Self, ACanvas, ARect, AText, ACanvas.Font, AColor, ADone);
    ACanvas.Brush.Color := AColor;
  end;
end;

procedure TdxInspectorRow.DoEdited;
begin
  if (Inspector <> nil) and Assigned(Inspector.FOnEdited) then
    Inspector.FOnEdited(Inspector, Node, Self);
end;

procedure TdxInspectorRow.DoValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean);
begin
  if (Inspector <> nil) and not Inspector.IsInitEdit then
  begin
    Inspector.DoEditValidate(Self, ErrorText, Accept);
    if Assigned(FOnValidate) then FOnValidate(Self, ErrorText, Accept);
  end;
end;

function TdxInspectorRow.GetEditLimit: Integer;
begin
  Result := 0;
end;

function TdxInspectorRow.GetEditMaskRow: string;
begin
  Result := '';
end;

function TdxInspectorRow.GetMinRowHeight(ACanvas: TCanvas): Integer;
begin
  Result := ACanvas.TextHeight('Wg')+ 2 + 1;
end;

procedure TdxInspectorRow.Changed;
begin
  if Inspector <> nil then
    Inspector.UpdateRow(nil);
end;

function TdxInspectorRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceTextEdit then
    EditText := TdxInplaceInspectorTextEdit(AInplaceEdit).Text;
  Result := EditText;
end;

function TdxInspectorRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTextEdit;
end;

procedure TdxInspectorRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  if AInplaceEdit is TdxInplaceEdit then
    with TdxInplaceInspectorEdit(AInplaceEdit) do
    begin
      ReadOnly := Self.ReadOnly;
      OnChange := Self.DoChange;
      OnValidate := Self.DoValidate;
    end;
  if AInplaceEdit is TdxInplaceTextEdit then
    with TdxInplaceInspectorTextEdit(AInplaceEdit) do
    begin
      CharCase := Self.CharCase;
      MaxLength := Self.MaxLength;
      PasswordChar := Self.PasswordChar;
      if HandleAllocated then ClearUndo;
    end;
end;

function TdxInspectorRow.IsEqualValues(const Value: Variant): Boolean;
begin
  Result := Inspector.IsDefaultEqualValues(Value, Self);
end;

function TdxInspectorRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  TdxInplaceInspectorEdit(AInplaceEdit).Text := EditText;
  Result := TdxInplaceInspectorEdit(AInplaceEdit).Text;
end;

function TdxInspectorRow.IsShowHint(IsValue: Boolean; const R: TRect; var AText: string): Boolean;
begin
  if (Inspector <> nil) and Inspector.HandleAllocated then
  begin
    if IsValue then
      AText := EditText // TODO
    else
      AText := Caption;
    Inspector.Canvas.Font.Assign(Inspector.Font);
    if IsCategory then Inspector.Canvas.Font.Style := [fsBold];
    Result := Inspector.Canvas.TextWidth(AText) > (R.Right - R.Left);
  end
  else
    Result := False;
end;

procedure TdxInspectorRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
begin
  with AViewData do
  begin
    Enabled := True;
    Focused := False;
    Selected := ACellViewData.Cell_HotTrackNode;
    // Style
    BorderColor := clNone;
    if (Inspector.PaintStyle = ipsCategorized) and (ACellViewData.Cell_HotTrackNode or
      ((Node <> nil) and Node.Focused)) then
      BorderStyle := xbsFlat // Inspector.EditStyleBorderStyle
    else
      BorderStyle := xbsNone;
    ButtonStyle := Inspector.EditStyleButtonStyle;
    ButtonTransparence := False;
    Edges := [edgLeft, edgTop, edgRight, edgBottom];
    Shadow := False;
    Transparent := False;
    // ViewBounds
    OffsetSize := Rect(1, 0, 0, 0);
    ViewBounds := ACellViewData.Cell_Rect;
    // General
    DrawAlignment := daSingleLine;
    Font := ACellViewData.Cell_Font;
    Brush := ACellViewData.Cell_Brush;
    BkColor := ColorToRGB(ACellViewData.Cell_BkColor);
    TextColor := ColorToRGB(ACellViewData.Cell_TextColor);
    Alignment := ACellViewData.Cell_Alignment;
    IsEditClass := False;
    Data := ACellViewData.Cell_Text;
    DataLength := ACellViewData.Cell_TextLength;
    CalcHeight := False;
  end;
  if AViewData is TdxTextEditViewData then
    with TdxTextEditViewData(AViewData) do
    begin
      CharCase := Self.CharCase;
      EndEllipsis := ACellViewData.Cell_DrawEndEllipsis;
      PasswordChar := Self.PasswordChar;
    end;
end;

procedure TdxInspectorRow.Hide;
var
  ANode: TdxInspectorRowNode;
  I: Integer;
begin
  if (Inspector <> nil) and (Node <> nil) then
  begin
    Inspector.BeginUpdate;
    try
      ANode := FNode;
      for I := ANode.Count - 1 downto 0 do
        TdxInspectorRowNode(ANode[I]).Row.Visible := False; //Hide;
      FNode := nil;
      ANode.FRow := nil;
      ANode.Free;
    finally
      Inspector.EndUpdate;
    end;
  end;
end;

procedure TdxInspectorRow.Show;
begin
  if Inspector <> nil then
  begin
    Inspector.NotifyComplexRows(Self);
    Inspector.InternalCreateNodeForRow(Self);
  end;
end;

function TdxInspectorRow.GetLinkObject: TObject;
begin
  Result := nil;
end;

procedure TdxInspectorRow.SetLinkObject(Value : TObject);
begin
end;

function TdxInspectorRow.GetLinkObjectName: String;
begin
end;

procedure TdxInspectorRow.SetLinkObjectName(const Value : String);
begin
end;

// private TdxInspectorRow
function TdxInspectorRow.GetCaption: String;
begin
  if rvCaption in FAssignedValues then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TdxInspectorRow.GetMaxLength: Integer;
begin
  if rvMaxLength in FAssignedValues then
    Result := FMaxLength
  else
    Result := DefaultMaxLength;
end;

function TdxInspectorRow.GetReadOnly: Boolean;
begin
  if rvReadOnly in FAssignedValues then
    Result := FReadOnly
  else
    Result := DefaultReadOnly;
  if not Result and (Inspector <> nil) then
     Result := Inspector.ReadOnly;
end;

function TdxInspectorRow.GetRowHeight: Integer;
begin
  if rvRowHeight in FAssignedValues then
  begin
    Result := FRowHeight;
    if Result < DefaultRowHeight then
      Result := DefaultRowHeight;
  end
  else
    Result := DefaultRowHeight;
end;

function TdxInspectorRow.IsCaptionStored: Boolean;
begin
  Result := (rvCaption in FAssignedValues) and
    (FCaption <> DefaultCaption);
end;

function TdxInspectorRow.IsMaxLengthStored: Boolean;
begin
  Result := (rvMaxLength in FAssignedValues);
end;

function TdxInspectorRow.IsReadOnlyStored: Boolean;
begin
  Result := (rvReadOnly in FAssignedValues) and
    (FReadOnly <> DefaultReadOnly);
end;

function TdxInspectorRow.IsRowHeightStored: Boolean;
begin
  Result := rvRowHeight in FAssignedValues;
end;

procedure TdxInspectorRow.SetAlignment(Value: TAlignment);
begin
  if Value <> FAlignment then
  begin
    FAlignment := Value;
    Changed;
  end;
end;

procedure TdxInspectorRow.SetCaption(const Value: string);
begin
  if (rvCaption in FAssignedValues) and
    (Value = FCaption) then Exit;
  FCaption := Value;
  Include(FAssignedValues, rvCaption);
  Changed;
end;

procedure TdxInspectorRow.SetCharCase(Value: TEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    Changed;
  end;
end;

procedure TdxInspectorRow.SetPasswordChar(Value: Char);
begin
  if FPasswordChar <> Value then
  begin
    FPasswordChar := Value;
    Changed;
  end;
end;

procedure TdxInspectorRow.SetImageIndex(Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed;
  end;
end;

procedure TdxInspectorRow.SetIsCategory(Value: Boolean);
begin
  if FIsCategory <> Value then
  begin
    FIsCategory := Value;
    Changed;
  end;
end;

procedure TdxInspectorRow.SetMaxLength(Value: Integer);
begin
  if (rvMaxLength in FAssignedValues) and
    (Value = FMaxLength) then Exit;
  FMaxLength := Value;
  Include(FAssignedValues, rvMaxLength);
  Changed;
end;

procedure TdxInspectorRow.SetReadOnly(Value: Boolean);
begin
  if (rvReadOnly in FAssignedValues) and
    (Value = FReadOnly) then Exit;
  FReadOnly := Value;
  Include(FAssignedValues, rvReadOnly);
  Changed;
end;

procedure TdxInspectorRow.SetRowHeight(Value: Integer);
begin
  FRowHeight := Value;
  if FRowHeight <= DefaultRowHeight then
  begin
    FRowHeight := DefaultRowHeight;
    Exclude(FAssignedValues, rvRowHeight);
  end
  else
    Include(FAssignedValues, rvRowHeight);
  Changed;
end;

procedure TdxInspectorRow.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if FVisible then
      Show
    else
      Hide;
    if Inspector <> nil then
    begin
      Inspector.UpdateCustomizeForm;
      Inspector.UpdateDesignEditor;
    end;
  end;
end;

procedure TdxInspectorRow.SetInspector(AInspector: TCustomdxInspectorControl);
begin
  if AInspector <> Inspector then
  begin
    if Inspector <> nil then Inspector.RemoveRow(Self);
    if AInspector <> nil then AInspector.AddRow(Self);
  end;
end;

{ TdxInspectorRowNode }

destructor TdxInspectorRowNode.Destroy;
var R : TdxInspectorRow;
begin
  if (Row <> nil) then
  begin
    R := Row;
    Row.FNode := nil;
    R.Free;
  end;
  inherited Destroy;
end;

function TdxInspectorRowNode.AddChildEx(RowClass: TdxInspectorRowClass): TdxInspectorRowNode;
var
  PrevRowClass: TdxInspectorRowClass;
begin
  with TCustomdxInspectorControl(Owner) do
  begin
    PrevRowClass := DefaultRowClass;
    DefaultRowClass := RowClass;
    try
      Result := TdxInspectorRowNode(AddChild);
    finally
      DefaultRowClass := PrevRowClass;
    end;
  end;
end;

function TdxInspectorRowNode.InsertChildEx(BeforeNode: TdxInspectorNode;
  RowClass: TdxInspectorRowClass): TdxInspectorRowNode;
var
  PrevRowClass: TdxInspectorRowClass;
begin
  with TCustomdxInspectorControl(Owner) do
  begin
    PrevRowClass := DefaultRowClass;
    DefaultRowClass := RowClass;
    try
      Result := TdxInspectorRowNode(InsertChild(BeforeNode));
    finally
      DefaultRowClass := PrevRowClass;
    end;
  end;
end;

procedure TdxInspectorRowNode.WriteData(AStream: TStream);
var
  I, AItemCount, ASize: Integer;
  PInfo: PdxInspectorRowNodeInfo;
  S: string;
begin
  ASize := SizeOf(TdxInspectorRowNodeInfo);
  GetMem(PInfo, ASize);
  try
    AItemCount := Count;
    if Row <> nil then
      S := Row.Name
    else
      S := '';
    PInfo^.Count := AItemCount;
    PInfo^.StrLen := Length(S);
    AStream.WriteBuffer(ASize, SizeOf(ASize));
    AStream.WriteBuffer(PInfo^, ASize);
    if PInfo^.StrLen <> 0 then
      AStream.WriteBuffer(S[1], PInfo^.StrLen);
  finally
    FreeMem(PInfo, ASize);
  end;
  for I := 0 to AItemCount - 1 do
    TdxInspectorRowNode(Items[I]).WriteData(AStream);
end;

{ TCustomdxInspectorControl }

constructor TCustomdxInspectorControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRows := TList.Create;
  FEditors := TList.Create;
  FEditValue := Null;
end;

destructor TCustomdxInspectorControl.Destroy;
begin
  try
    DoSaveLayout;
  finally
    Destroying;
    FreeStreamData;
    if FDesigner <> nil then FDesigner.Free;
    if Assigned(FRows) then DestroyRows;
    FRows.Free;
    FRows := nil;
    FEditors.Free;
    FEditors := nil;
    if FEditFont <> nil then FEditFont.Free;
    FEditFont := nil;
    inherited Destroy;
  end;
end;

procedure TCustomdxInspectorControl.AssignRows(InspectorControl: TCustomdxInspectorControl);
var
  I: Integer;
  Row: TdxInspectorRow;
begin
  if InspectorControl <> nil then
  begin
    BeginUpdate;
    try
      DestroyRows;
      for I := 0 to InspectorControl.TotalRowCount - 1 do
      begin
        Row := CreateRow(TdxInspectorRowClass(InspectorControl.Rows[I].ClassType));
        Row.Name := InspectorControl.Rows[I].Name;
        Row.Assign(InspectorControl.Rows[I]);
      end;
      // order
      SetOrderRows(InspectorControl);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxInspectorControl.ClearRows;
begin
  BeginUpdate;
  try
    DestroyRows;
  finally
    EndUpdate;
  end;
end;

function TCustomdxInspectorControl.ComplexRowByRow(ARow: TdxInspectorRow): TdxInspectorComplexRow;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to TotalRowCount - 1 do
    if (Rows[I] is TdxInspectorComplexRow) and
      (TdxInspectorComplexRow(Rows[I]).Items.IndexOfRow(ARow) <> -1) then
    begin
      Result := Rows[I] as TdxInspectorComplexRow;
      Break;
    end;
end;

function TCustomdxInspectorControl.CreateDefaultRow(RowClass: TdxInspectorRowClass): TdxInspectorRow;
begin
  Result := RowClass.Create(Self);
  Result.Inspector := Self;
end;

function TCustomdxInspectorControl.CreateRow(RowClass: TdxInspectorRowClass): TdxInspectorRow;
var
  i : Integer;
begin
  Result := RowClass.Create(Self.Owner);
  i := TotalRowCount + 1;
  while i <> -1 do
    try
      Result.Name := Name + 'Row' + IntToStr(i);
      i := -1;
    except
      Inc(i);
    end;
  Result.Inspector := Self;
end;

function TCustomdxInspectorControl.IndexOfRow(ARow: TdxInspectorRow): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to TotalRowCount - 1 do
    if Rows[I] = ARow then
    begin
      Result := I;
      Break; 
    end;
end;

procedure TCustomdxInspectorControl.RestoreRowsDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to TotalRowCount - 1 do
      Rows[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

function TCustomdxInspectorControl.RowByName(const AName : String) : TdxInspectorRow;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to TotalRowCount - 1 do
    if AnsiCompareText(Rows[I].Name, AName) = 0 then
    begin
      Result := Rows[I];
      Exit;
    end;
end;

function TCustomdxInspectorControl.RowInComplexRow(ARow: TdxInspectorRow): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to TotalRowCount - 1 do
    if (Rows[I] is TdxInspectorComplexRow) and
      (TdxInspectorComplexRow(Rows[I]).Items.IndexOfRow(ARow) <> -1) then
    begin
      Result := True;
      Break;
    end;
end;

function TCustomdxInspectorControl.AddEx(RowClass: TdxInspectorRowClass): TdxInspectorRowNode;
var
  PrevRowClass: TdxInspectorRowClass;
begin
  PrevRowClass := DefaultRowClass;
  DefaultRowClass := RowClass;
  try
    Result := TdxInspectorRowNode(Add);
  finally
    DefaultRowClass := PrevRowClass;
  end;
end;

function TCustomdxInspectorControl.InsertEx(BeforeNode: TdxInspectorNode;
  RowClass: TdxInspectorRowClass): TdxInspectorRowNode;
var
  PrevRowClass: TdxInspectorRowClass;
begin
  PrevRowClass := DefaultRowClass;
  DefaultRowClass := RowClass;
  try
    Result := TdxInspectorRowNode(Insert(BeforeNode));
  finally
    DefaultRowClass := PrevRowClass;
  end;
end;

procedure TCustomdxInspectorControl.LoadNodesFromStream(AStream: TStream);
var
  I: Integer;
begin
  for I := 0 to TotalRowCount - 1 do
    if not RowInComplexRow(Rows[I]) then
      Rows[I].Visible := True;
  ReadData(AStream);
  LoadOrderRows;
  FreeStreamData;
end;

procedure TCustomdxInspectorControl.SaveNodesToStream(AStream: TStream);
begin
  WriteData(AStream);
end;

// protected TCustomdxInspectorControl
procedure TCustomdxInspectorControl.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData,
    (Count > 0) and SaveNodes);
end;

procedure TCustomdxInspectorControl.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  FDragRow := nil;
end;

procedure TCustomdxInspectorControl.GetChildren(Proc: TGetChildProc{$IFDEF DELPHI3}; Root: TComponent{$ENDIF});
var
  I: Integer;
  Row: TdxInspectorRow;
begin
  for I := 0 to FRows.Count - 1 do
  begin
    Row := FRows[I];
    if Row.Owner {$IFNDEF DELPHI3}<> Self{$ELSE}= Root {$ENDIF} then Proc(Row);
  end;
end;

procedure TCustomdxInspectorControl.Loaded;
begin
  BeginUpdate;
  FLoading := True;
  try
    inherited Loaded;
    // TODO : restore proc
    Inc(FLockExpanded);
    try
      LoadOrderRows;
    finally
      Dec(FLockExpanded);
    end;
    DoRestoreLayout;
    FreeStreamData;
    CheckHiddenRows;
    if TopNode <> nil then
    begin
      TopNode.Focused := True;
      TopNode.MakeVisible;
    end;
  finally
    EndUpdate;
    FLoading := False;
  end;
end;

procedure TCustomdxInspectorControl.SetChildOrder(Component: TComponent; Order: Integer);
begin
end;

procedure TCustomdxInspectorControl.SetName(const Value: TComponentName);
var
  I: Integer;
  OldName, FieldName, NamePrefix: TComponentName;
  Row: TdxInspectorRow;
  OldChangeEvent : TNotifyEvent;
begin
  OldName := Name;
  inherited SetName(Value);
  if (csDesigning in ComponentState) and (Name <> OldName) then
  begin
    { In design mode the name of the columns should track the data set name }
    for I := 0 to FRows.Count - 1 do
    begin
      Row := Rows[I];
      if Row.Owner = Owner then
      begin
        FieldName := Row.Name;
        NamePrefix := FieldName;
        if Length(NamePrefix) > Length(OldName) then
        begin
          SetLength(NamePrefix, Length(OldName));
          if CompareText(OldName, NamePrefix) = 0 then
          begin
            System.Delete(FieldName, 1, Length(OldName));
            System.Insert(Value, FieldName, 1);
            OldChangeEvent := Row.OnChangeName;
            Row.OnChangeName := Nil;
            try
              Row.Name := FieldName;
            except
              on EComponentError do {Ignore rename errors };
            end;
            Row.OnChangeName := OldChangeEvent;
          end;
        end;
      end;
    end;
    UpdateDesignEditor;
  end;
end;

procedure TCustomdxInspectorControl.AddNode(Node: TdxInspectorNode);
begin
  if not FAddFlag then
  begin
    // add row
    FAddFlag := True;
    try
      if Assigned(FDefaultRowClass) then
        TdxInspectorRowNode(Node).FRow := CreateRow(FDefaultRowClass)
      else TdxInspectorRowNode(Node).FRow := CreateRow(GetDefaultRowClass);
      TdxInspectorRowNode(Node).FRow.FNode := TdxInspectorRowNode(Node);
    finally
      FAddFlag := False;
    end;
  end;
  inherited AddNode(Node);
end;

function TCustomdxInspectorControl.CalcMinRowHeight(ACanvas: TCanvas): Integer;
var
  I, H: Integer;
begin
  Result := inherited CalcMinRowHeight(ACanvas);
  for I := 0 to VisibleTotalRowCount - 1 do
  begin
    H := Rows[I].GetMinRowHeight(ACanvas);
    if H > Result then
      Result := H;
  end;
end;

function TCustomdxInspectorControl.CalcRowHeight(ACanvas: TCanvas; const ARect: TRect;
  ACellViewData: TdxInspectorCellViewData; ARow: TdxInspectorRow): Integer;
var
  AViewInfo: TdxEditViewInfo;
  ALineCount, ALineHeight: Integer;
begin
  Result := RowHeight;
  with ARow do
  begin
    PrepareViewData(ViewData, ACellViewData);
    CalcCellViewBoundsRect(ARect, ViewData.ViewBounds);
    GetdxInplaceEditClass.CalcViewInfo(ViewData, False, AViewInfo);
    ViewData.CalcHeight := True;
    try
      ViewData.LineCount := 0;
      if GetdxInplaceEditClass.DrawClientArea(ACanvas.Handle, AViewInfo.ClientBounds, ViewData, False) then
      begin
        ALineHeight := ViewData.LineHeight;
        ALineCount := ViewData.LineCount;
        if (MaxRowTextLineCount > 0) and (ALineCount > MaxRowTextLineCount) then
        begin
          ALineCount := MaxRowTextLineCount;
          ALineHeight := ALineCount * ViewData.LineTextHeight;
        end;
        Result := ALineHeight + 3 + GridSize;
        if not IsCategoryNode(ARow.Node) then
          Result := Result + FRowFrameSize * 2; // TODO: !!!
        if Result < RowHeight then
          Result := RowHeight;
      end;
    finally
      ViewData.CalcHeight := False;
    end;
  end;
end;

function TCustomdxInspectorControl.CalcComplexRowHeight(ACanvas: TCanvas; const ARect: TRect;
  ACellViewData: TdxInspectorCellViewData; ARow: TdxInspectorComplexRow): Integer;
var
  AViewInfo: TdxInspectorComplexRowViewInfo;
  I, AMaxHeight, AHeight: Integer;
begin
  AMaxHeight := RowHeight;
  AViewInfo := TdxInspectorComplexRowViewInfo.Create(ARow, FComplexRowSeparatorWidth);
  try
    AViewInfo.Calculate(ARect);
    if not AViewInfo.Empty then
      for I := 0 to AViewInfo.Count - 1 do
      begin
        if not AViewInfo[I].Separator then
        begin
          if AViewInfo[I].Row <> nil then
          begin
            ACellViewData.Cell_Text := AViewInfo[I].Row.DisplayText;
            AHeight := CalcRowHeight(ACanvas, AViewInfo[I].Bounds, ACellViewData, AViewInfo[I].Row);
            if AHeight > AMaxHeight then
              AMaxHeight := AHeight;
          end;
        end;
      end;
  finally
    AViewInfo.Free;
  end;
  Result := AMaxHeight;
end;

function TCustomdxInspectorControl.CalcRowAutoHeight(ARow: TdxInspectorRow): Integer;
var
  ANode: TdxInspectorRowNode;
  AWidth: Integer;
  ACaptionText, ADisplayText: string;
  ARect: TRect;
  ACanvas: TCanvas;
  ADrawInfo: TdxInspectorDrawInfo;
begin
  // View Info
  ANode := ARow.Node;
  if IsAutoBandCount then
    AWidth := BandWidth - BandSeparatorWidth
  else
    AWidth := ClientWidth;
  ARect := Rect(0, 0, AWidth, FTextHeight);
  CalcDrawInfo(ANode, ARect, ADrawInfo);
  ARect := ADrawInfo.ValueRect;
  ACaptionText := '';
  ADisplayText := '';
  GetNodeText(ANode, ACaptionText, ADisplayText);
  ACanvas := Canvas;
  ACanvas.Font := Self.Font;  
  with FCellViewData do
  begin
    Cell_Brush := ACanvas.Brush.Handle;
    Cell_Font := ACanvas.Font.Handle;
    Cell_BkColor := ACanvas.Brush.Color;
    Cell_TextColor := ACanvas.Font.Color;
    Cell_Alignment := taLeftJustify;
    Cell_Text := ADisplayText;
    Cell_TextLength := 0;  // full length
    Cell_Selected := False;
    Cell_DrawEndEllipsis := ioDrawEndEllipsis in Options;
    Cell_Node := ANode;
    Cell_HotTrackNode := IsHotTrackNode(ANode);
    with ARect do
      Cell_Rect := Rect(0, 0, Right - Left, Bottom - Top);
    InflateRect(Cell_Rect, 2, 2); // TODO PAINT2
  end;
  if IsComplexNode(ANode) then
    Result := CalcComplexRowHeight(ACanvas, ARect, FCellViewData, ARow as TdxInspectorComplexRow)
  else
    Result := CalcRowHeight(ACanvas, ARect, FCellViewData, ARow);
end;

procedure TCustomdxInspectorControl.CheckComplexRowIndex(var AComplexRowIndex: Integer);
var
  AComplexRow: TdxInspectorComplexRow;
begin
  if (FocusedNode <> nil) and IsComplexNode(FocusedNode) then
  begin
    AComplexRow := TdxInspectorRowNode(FocusedNode).Row as TdxInspectorComplexRow;
    if AComplexRowIndex < 0 then
      AComplexRowIndex := 0;
    if AComplexRowIndex >= AComplexRow.Items.Count then
      AComplexRowIndex := AComplexRow.Items.Count - 1;
  end;
end;

procedure TCustomdxInspectorControl.ClearComplexRows(ARow: TdxInspectorRow);
var
  I: Integer;
begin
  for I := 0 to TotalRowCount - 1 do
    if Rows[I] is TdxInspectorComplexRow then
      TdxInspectorComplexRow(Rows[I]).RemoveNotification(ARow);
end;

function TCustomdxInspectorControl.CreateNode: TdxInspectorNode;
begin
  Result := TdxInspectorRowNode.Create(Self);
end;

procedure TCustomdxInspectorControl.DestroyRows;
var
  Row: TdxInspectorRow;
begin
  while FRows.Count > 0 do
  begin
    Row := FRows.Last;
    RemoveRow(Row);
    Row.Free;
  end;
end;

procedure TCustomdxInspectorControl.DefaultDrawCell(ACanvas: TCanvas; const ARect: TRect;
  ACellViewData: TdxInspectorCellViewData);
var
  ARow: TdxInspectorRow;
begin
  ARow := TdxInspectorRowNode(ACellViewData.Cell_Node).Row;
  if IsComplexNode(ACellViewData.Cell_Node) then
    DrawComplexRowValue(ACanvas, ARect, ACellViewData, ARow as TdxInspectorComplexRow)
  else
    DrawValue(ACanvas, ARect, ACellViewData, ARow);
end;

procedure TCustomdxInspectorControl.DragDropTo(var ANode: TdxInspectorNode;
  ADestinationNode: TdxInspectorNode; AAttachMode: TdxInspectorNodeAttachMode);
begin
  if FDragRow <> nil then
  begin
    FDragRow.Visible := True;
    ANode := FDragRow.Node;
  end;
end;

procedure TCustomdxInspectorControl.DrawCaption(ACanvas: TCanvas; ANode: TdxInspectorNode;
  const ADisplayRect: TRect; const AText: string);
begin
  if (ANode <> nil) and IsComplexNode(ANode) then
    DrawComplexRowCaption(ACanvas, ADisplayRect, TdxInspectorRowNode(ANode).Row as TdxInspectorComplexRow)
  else
    inherited;
end;

procedure TCustomdxInspectorControl.DrawComplexRowCaption(ACanvas: TCanvas; const ADisplayRect: TRect;
  ARow: TdxInspectorComplexRow);
var
  AViewInfo: TdxInspectorComplexRowViewInfo;
  I: Integer;
  ADisplayText: string;
begin
  AViewInfo := TdxInspectorComplexRowViewInfo.Create(ARow, FCaptionComplexRowSeparatorWidth);
  try
    AViewInfo.Calculate(ADisplayRect);
    if AViewInfo.Empty then
      DrawDisplayText(ACanvas, ADisplayRect, ARow.Caption, taLeftJustify)
    else
      for I := 0 to AViewInfo.Count - 1 do
      begin
        if AViewInfo[I].Separator then
        begin
          if ComplexRowSeparator = '' then
            DrawComplexRowSeparator(ACanvas, AViewInfo[I].Bounds, True)
          else
            DrawDisplayText(ACanvas, AViewInfo[I].Bounds, ComplexRowSeparator, taCenter);
        end
        else
        begin
          if AViewInfo[I].Row <> nil then
            ADisplayText := AViewInfo[I].Row.Caption
          else
            ADisplayText := '';
          DrawDisplayText(ACanvas, AViewInfo[I].Bounds, ADisplayText, taLeftJustify);
        end;
      end;
  finally
    AViewInfo.Free;
  end;
end;

procedure TCustomdxInspectorControl.DrawComplexRowValue(ACanvas: TCanvas; const ARect: TRect;
  ACellViewData: TdxInspectorCellViewData; ARow: TdxInspectorComplexRow);
var
  AViewInfo: TdxInspectorComplexRowViewInfo;
  I: Integer;
begin
  AViewInfo := TdxInspectorComplexRowViewInfo.Create(ARow, FComplexRowSeparatorWidth);
  try
    AViewInfo.Calculate(ARect);
    if AViewInfo.Empty then
      DrawDisplayText(ACanvas, ARect, '', taLeftJustify)
    else
      for I := 0 to AViewInfo.Count - 1 do
      begin
        if AViewInfo[I].Separator then
        begin
          if ComplexRowSeparator = '' then
            DrawComplexRowSeparator(ACanvas, AViewInfo[I].Bounds, False)
          else
            DrawDisplayText(ACanvas, AViewInfo[I].Bounds, ComplexRowSeparator, taCenter);
        end
        else
        begin
          if AViewInfo[I].Row <> nil then
          begin
            ACellViewData.Cell_Text := AViewInfo[I].Row.DisplayText;
            DrawValue(ACanvas, AViewInfo[I].Bounds, ACellViewData, AViewInfo[I].Row);
          end
          else
            DrawDisplayText(ACanvas, AViewInfo[I].Bounds, '', taLeftJustify);
        end;
      end;
  finally
    AViewInfo.Free;
  end;
end;

procedure TCustomdxInspectorControl.DrawValue(ACanvas: TCanvas; const ARect: TRect;
  ACellViewData: TdxInspectorCellViewData; ARow: TdxInspectorRow);
begin
  with ARow do
  begin
    PrepareViewData(ViewData, ACellViewData);
    CalcCellViewBoundsRect(ARect, ViewData.ViewBounds);
    GetdxInplaceEditClass.Draw(ACanvas.Handle, ARect, ViewData, 0);
  end;
end;

procedure TCustomdxInspectorControl.DoDrawCaption(ACanvas:TCanvas; ANode: TdxInspectorNode;
  AIndentRect, AButtonRect, AImageRect: TRect; AButtonKind: TdxInspectorButtonKind;
  ADisplayRect: TRect; var AText: string);
var
  ADone: Boolean;
  AColor: TColor;
begin
  ADone := False;
  if (ANode <> nil) and (TdxInspectorRowNode(ANode).Row <> nil) then
  begin
    if Assigned(FOnDrawCaption) then
    begin
      AColor := ACanvas.Brush.Color;
      FOnDrawCaption(TdxInspectorRowNode(ANode).Row, ACanvas, ADisplayRect, AText, ACanvas.Font, AColor, ADone);
      ACanvas.Brush.Color := AColor;
    end;
    if not ADone then
      TdxInspectorRowNode(ANode).Row.DoDrawCaption(ACanvas, AIndentRect, AButtonRect, AImageRect,
        AButtonKind, ADisplayRect, AText, ADone);
  end;
  if not ADone then
    inherited DoDrawCaption(ACanvas, ANode,
      AIndentRect, AButtonRect, AImageRect, AButtonKind, ADisplayRect, AText);
end;

procedure TCustomdxInspectorControl.DoDrawValue(ACanvas:TCanvas; ARect : TRect; ANode: TdxInspectorNode;
  var AText: string; var AAlignment: TAlignment);
var
  ADone: Boolean;
  AColor: TColor;
  ARow: TdxInspectorRow;
begin
  ADone := False;
  if (ANode <> nil) then
  begin
    ARow := TdxInspectorRowNode(ANode).Row;
    if ARow <> nil then
    begin
      AAlignment := ARow.Alignment;
      if Assigned(FOnDrawValue) then
      begin
        AColor := ACanvas.Brush.Color;
        FOnDrawValue(ARow, ACanvas, ARect, AText, ACanvas.Font, AColor, ADone);
        ACanvas.Brush.Color := AColor;
      end;
      if not ADone then
        ARow.DoDrawValue(ACanvas, ARect, AText, ADone);
    end;
  end;
  if not ADone then
    inherited DoDrawValue(ACanvas, ARect, ANode, AText, AAlignment);
end;

procedure TCustomdxInspectorControl.DoEditChange(Sender: TObject);
begin
  if Assigned(FOnEditChange) then FOnEditChange(Sender);
end;

procedure TCustomdxInspectorControl.DoEditValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean);
begin
  if Assigned(FOnEditValidate) then FOnEditValidate(Sender, ErrorText, Accept);
end;

procedure TCustomdxInspectorControl.DoInternalLayout;
begin
  inherited DoInternalLayout;
  InvalidateEditor;
  if Designer <> nil then Designer.LayoutChanged;
end;

procedure TCustomdxInspectorControl.DoRestoreLayout;
begin
  if (ioStoreToRegistry in Options) and not (csDesigning in ComponentState) and
    (RegistryPath <> '') then LoadFromRegistry(RegistryPath);
end;

procedure TCustomdxInspectorControl.DoSaveLayout;
begin
  if (ioStoreToRegistry in Options) and not (csDesigning in ComponentState) and
    (RegistryPath <> '') then SaveToRegistry(RegistryPath);
end;

procedure TCustomdxInspectorControl.GetComplexRowInfoAt(ANode: TdxInspectorNode; const ARect: TRect;
  const APos: TPoint; var ComplexRowIndex: Integer; var ComplexRowRect: TRect);
var
  ARow: TdxInspectorComplexRow;
  AViewInfo: TdxInspectorComplexRowViewInfo;
  I: Integer;
begin
  inherited GetComplexRowInfoAt(ANode, ARect, APos, ComplexRowIndex, ComplexRowRect);
  if IsComplexNode(ANode) and PtInRect(ARect, APos) then
  begin
    ARow := TdxInspectorRowNode(ANode).Row as TdxInspectorComplexRow;
    AViewInfo := TdxInspectorComplexRowViewInfo.Create(ARow, FComplexRowSeparatorWidth);
    try
      AViewInfo.Calculate(ARect);
      for I := 0 to AViewInfo.Count - 1 do
        if PtInRect(AViewInfo[I].Bounds, APos) then
        begin
          if AViewInfo[I].Separator then
            ComplexRowRect := AViewInfo[I - 1].Bounds
          else
          begin
            ComplexRowIndex := I div 2;
            ComplexRowRect := AViewInfo[I].Bounds;
          end;
          Break;
        end;
    finally
      AViewInfo.Free;
    end;
  end;
end;

function TCustomdxInspectorControl.GetDefaultRowClass: TdxInspectorRowClass;
begin
  Result := TdxInspectorRow;
end;

function TCustomdxInspectorControl.GetDragNodeText(ADragNode: TdxInspectorNode): string;
begin
  if (ADragNode = nil) and (FDragRow <> nil) then
  begin
//    Result := FDragRow.Caption;
    Result := GetRowDragCaption(FDragRow);
  end
  else
  begin
    if (ADragNode <> nil) and IsComplexNode(ADragNode) then
      Result := GetRowDragCaption(TdxInspectorRowNode(ADragNode).Row)
    else
      Result := inherited GetDragNodeText(ADragNode);
  end;
end;

function TCustomdxInspectorControl.GetEditRect(ANode: TdxInspectorNode): TRect;
var
  AComplexRow: TdxInspectorComplexRow;
  AViewInfo: TdxInspectorComplexRowViewInfo;
  I: Integer;
begin
  Result := inherited GetEditRect(ANode); // CellRect
  if IsComplexNode(ANode) then
  begin
    AComplexRow := TdxInspectorRowNode(ANode).Row as TdxInspectorComplexRow;
    AViewInfo := TdxInspectorComplexRowViewInfo.Create(AComplexRow, FComplexRowSeparatorWidth);
    try
      AViewInfo.Calculate(Result);
      for I := 0 to AViewInfo.Count - 1 do
        if GetInplaceEditRow(ANode) = AViewInfo[I].Row then
        begin
          Result := AViewInfo[I].Bounds;
          Break;
        end;
    finally
      AViewInfo.Free;
    end;
  end;
end;

function TCustomdxInspectorControl.GetImageIndex(Node: TdxInspectorNode): Integer;
begin
  Result := TdxInspectorRowNode(Node).Row.ImageIndex;
end;

function TCustomdxInspectorControl.GetNodeHeight(ANode: TdxInspectorNode): Integer;
begin
  if Assigned(ANode) and Assigned(TdxInspectorRowNode(ANode).Row) then
    Result := GetRowHeight(TdxInspectorRowNode(ANode).Row)
  else
    Result := inherited GetNodeHeight(ANode);
end;

procedure TCustomdxInspectorControl.GetNodeText(Node: TdxInspectorNode; var CaptionText, DisplayText: String);
begin
  CaptionText := TdxInspectorRowNode(Node).Row.Caption;
  DisplayText := TdxInspectorRowNode(Node).Row.DisplayText;
end;

function TCustomdxInspectorControl.GetRowDragCaption(ARow: TdxInspectorRow): string;
var
  I: Integer;
  S: string;
begin
  Result := ARow.Caption;
  S := ComplexRowSeparator;
  if S = '' then
    S := '-';
  if (Result = '') and (ARow is TdxInspectorComplexRow) then
    with ARow as TdxInspectorComplexRow do
      for I := 0 to Items.Count - 1 do
      begin
        if Items[I].Row <> nil then
        begin
          if I > 0 then
            Result := Result + S;
          Result := Result + Items[I].Row.Caption;
        end;
      end;
end;

function TCustomdxInspectorControl.GetRowHeight(ARow: TdxInspectorRow): Integer;
begin
  // TODO: row auto height only for memo?
  if IsRowAutoHeight and not (rvRowHeight in ARow.AssignedValues) then
    Result := CalcRowAutoHeight(ARow)
  else
    Result := ARow.RowHeight;
end;

function TCustomdxInspectorControl.IsCategoryNode(Node: TdxInspectorNode): Boolean;
begin
  if (Node <> nil) and (TdxInspectorRowNode(Node).Row <> nil) then
    Result := TdxInspectorRowNode(Node).Row.IsCategory
  else Result := inherited IsCategoryNode(Node);
end;

function TCustomdxInspectorControl.GoTabComplexRow(AForward: Boolean): Boolean;
var
  AComplexRow: TdxInspectorComplexRow;
  APrevInplaceComplexRowIndex: Integer;
begin
  Result := False;
  if (FocusedNode <> nil) and IsComplexNode(FocusedNode) then
  begin
    AComplexRow := TdxInspectorRowNode(FocusedNode).Row as TdxInspectorComplexRow;
    if AComplexRow.Items.Count > 1 then
    begin
      APrevInplaceComplexRowIndex := InplaceComplexRowIndex;
      if AForward then
        InplaceComplexRowIndex := InplaceComplexRowIndex + 1
      else
        InplaceComplexRowIndex := InplaceComplexRowIndex - 1;
      if APrevInplaceComplexRowIndex <> InplaceComplexRowIndex then
        Result := True
      else
        if AForward then
        begin
          if FocusedNode <> LastNode then
            InplaceComplexRowIndex := 0;
        end
        else
        begin
          if FocusedNode <> TopNode then
            InplaceComplexRowIndex := AComplexRow.Items.Count - 1;
        end;  
    end;
  end
  else
  begin
    if AForward then
      InplaceComplexRowIndex := 0
    else
      InplaceComplexRowIndex := $7FFFFFFF;
  end;
end;

function TCustomdxInspectorControl.IsComplexNode(ANode: TdxInspectorNode): Boolean;
begin
  Result := (ANode <> nil) and not IsCategoryNode(ANode) and
    (TdxInspectorRowNode(ANode).Row is TdxInspectorComplexRow);
end;

function TCustomdxInspectorControl.IsGoTabComplexRowAvailable(AForward: Boolean): Boolean;
var
  AComplexRow: TdxInspectorComplexRow;
  AInplaceComplexRowIndex, APrevInplaceComplexRowIndex: Integer;
begin
  Result := False;
  if (FocusedNode <> nil) and IsComplexNode(FocusedNode) then
  begin
    AComplexRow := TdxInspectorRowNode(FocusedNode).Row as TdxInspectorComplexRow;
    if AComplexRow.Items.Count > 1 then
    begin
      APrevInplaceComplexRowIndex := InplaceComplexRowIndex;
      if AForward then
        AInplaceComplexRowIndex := InplaceComplexRowIndex + 1
      else
        AInplaceComplexRowIndex := InplaceComplexRowIndex - 1;
      CheckComplexRowIndex(AInplaceComplexRowIndex);
      if APrevInplaceComplexRowIndex <> AInplaceComplexRowIndex then
        Result := True;
    end;
  end;
end;

function TCustomdxInspectorControl.IsShowHintNode(ANode: TdxInspectorNode; AComplexRowIndex: Integer;
  const AComplexRowRect: TRect; IsValue: Boolean; const R: TRect; var AText: string;
  var X: Integer; var IsRowHint: Boolean): Boolean;
var
  ARow: TdxInspectorRow;
  ARect: TRect;
begin
  Result := False;
  IsRowHint := False;
  if ANode <> nil then
  begin
    if IsComplexNode(ANode) then
    begin
      ARect := AComplexRowRect;
      ARow := RowByComplexRowIndex(ANode, AComplexRowIndex);
    end
    else
    begin
      ARow := TdxInspectorRowNode(ANode).Row;
      ARect := R;
    end;
    if (ARow <> nil) and not IsRectEmpty(ARect) then
    begin
      X := ARect.Left - 1;
      if not IsValue then Dec(X);
      Inc(ARect.Left, 2);
      if not IsValue and ARow.ShowHint and (ARow.Hint <> '') then
      begin
        AText := ARow.Hint;
        IsRowHint := True;
        Result := True;
      end
      else
      begin
        if IsValue then
          Dec(ARect.Right);
        Result := ARow.IsShowHint(IsValue, ARect, AText);
      end;
    end;
  end;
end;

function TCustomdxInspectorControl.RowByComplexRowIndex(ANode: TdxInspectorNode;
  AComplexRowIndex: Integer): TdxInspectorRow;
var
  AComplexRow: TdxInspectorComplexRow;
begin
  AComplexRow := TdxInspectorRowNode(ANode).Row as TdxInspectorComplexRow;
  if (0 <= AComplexRowIndex) and (AComplexRowIndex < AComplexRow.Items.Count) then
    Result := AComplexRow.Items[AComplexRowIndex].Row
  else
    Result := nil;
end;

procedure TCustomdxInspectorControl.SetNodeHeight(ANode: TdxInspectorNode; Value: Integer);
begin
  if Assigned(ANode) then
    TdxInspectorRowNode(ANode).Row.RowHeight := Value;
end;

procedure TCustomdxInspectorControl.SetOrderRows(InspectorControl: TCustomdxInspectorControl);

  procedure MoveChildren(ExtlNode, CurNode: TdxInspectorRowNode);
  var
    I: Integer;
    Node, ANode: TdxInspectorRowNode;
    Row: TdxInspectorRow;
  begin
    for I := 0 to ExtlNode.Count - 1 do
    begin
      Node := TdxInspectorRowNode(ExtlNode[I]);
      if Node.Row <> nil then
      begin
        Row := RowByName(Node.Row.Name);
        if (Row <> nil) then
        begin
          ANode := Row.Node;
          if ANode <> nil then
          begin
            ANode.MoveTo(CurNode, inaAddChild);
            MoveChildren(Node, ANode);
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  Node, ANode: TdxInspectorRowNode;
  Row: TdxInspectorRow;
begin
  // move to root
  for I := 0 to InspectorControl.Count - 1 do
  begin
    // move to root
    Node := TdxInspectorRowNode(InspectorControl.Items[I]);
    if Node.Row <> nil then
    begin
      Row := RowByName(Node.Row.Name);
      if (Row <> nil) then
      begin
        ANode := Row.Node;
        if ANode <> nil then
        begin
          ANode.MoveTo(Items[0], inaAdd);
          // move children
          MoveChildren(Node, ANode);
        end;
      end;
    end;
  end;
end;

function TCustomdxInspectorControl.SaveNodes: Boolean;
begin
  Result := True;
end;

procedure TCustomdxInspectorControl.UpdateDesignEditor;
begin
  if Assigned(FDesigner) then
    FDesigner.LayoutChanged;
end;

procedure TCustomdxInspectorControl.UpdateRow(Row: TdxInspectorRow);
begin
  if csLoading in ComponentState then Exit;
  LayoutChanged;
//  if Designer <> nil then Designer.LayoutChanged;
end;

procedure TCustomdxInspectorControl.ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);

  procedure ReadCategories;
  var
    I: Integer;
    ACategories: TStringList;
    ARow: TdxInspectorRow;
  begin
    ACategories := TStringList.Create;
    try
      ARegIniWrapper.ReadSection(APath + '\Categories', ACategories);
      for I := 0 to ACategories.Count - 1 do
        ACategories.Objects[I] := RowByName(ACategories[I]);
      // delete
      for I := TotalRowCount - 1 downto 0 do
      begin
        ARow := Rows[I];
        if ARow.IsCategory and (ACategories.IndexOfObject(ARow) = -1) then
        begin
          ARow.Visible := False;
          ARow.Free;
        end;
      end;
      // create
      for I := 0 to ACategories.Count - 1 do
        if ACategories.Objects[I] = nil then
        begin
          ARow := CreateRow(GetDefaultRowClass);
          ARow.IsCategory := True;
          ARow.Visible := False;
          ARow.Name := ACategories[I]; 
          ARow.Caption := ARegIniWrapper.ReadString(APath + '\Categories', ARow.Name, ARow.Name);
        end;
    finally
      ACategories.Free;
    end;
  end;

  procedure ReadNodes;
  var
    AStream: TMemoryStream;
  begin
    AStream := TMemoryStream.Create;
    try
      AStream.SetSize(ARegIniWrapper.ReadBinaryData(APath, 'Nodes', AStream.Memory^, 0));
      ARegIniWrapper.ReadBinaryData(APath, 'Nodes', AStream.Memory^, AStream.Size);
      if AStream.Size <> 0 then
        LoadNodesFromStream(AStream);
    finally
      AStream.Free;
    end;
  end;

  procedure ReadRow(const ARowPath: string; ARow: TdxInspectorRow);
  begin
    with ARegIniWrapper do
    begin
      ARow.RowHeight := ReadInteger(ARowPath, 'RowHeight', -1);
      ARow.Visible := ReadBool(ARowPath, 'Visible', ARow.Visible);
    end;
  end;

  procedure ReadRows;
  var
    I: Integer;
    ARow: TdxInspectorRow;
    ARowPath: string;
  begin
    for I := 0 to TotalRowCount - 1 do
    begin
      ARow := Rows[I];
      ARowPath := APath + '\Rows\' + ARow.Name;
      ReadRow(ARowPath, ARow);
    end;
  end;

begin
  ReadCategories;
  ReadNodes;
  ReadRows;
  inherited ReadSettings(ARegIniWrapper, APath);
end;

procedure TCustomdxInspectorControl.WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);

  procedure WriteCategories;
  var
    I: Integer;
    ARow: TdxInspectorRow;
  begin
    ARegIniWrapper.EraseSection(APath + '\Categories');
    for I := 0 to TotalRowCount - 1 do
    begin
      ARow := Rows[I];
      if ARow.IsCategory then
        ARegIniWrapper.WriteString(APath + '\Categories', ARow.Name, ARow.Caption);
    end;
  end;

  procedure WriteNodes;
  var
    AStream: TMemoryStream;
  begin
    AStream := TMemoryStream.Create;
    try
      SaveNodesToStream(AStream);
      ARegIniWrapper.WriteBinaryData(APath, 'Nodes', AStream.Memory^, AStream.Size);
    finally
      AStream.Free;
    end;
  end;

  procedure WriteRow(const ARowPath: string; ARow: TdxInspectorRow);
  begin
    with ARegIniWrapper do
    begin
      if rvRowHeight in ARow.AssignedValues then
        WriteInteger(ARowPath, 'RowHeight', ARow.RowHeight)
      else
        WriteInteger(ARowPath, 'RowHeight', -1);
      WriteBool(ARowPath, 'Visible', ARow.Visible);
    end;
  end;

  procedure WriteRows;
  var
    I: Integer;
    ARow: TdxInspectorRow;
  begin
    for I := 0 to TotalRowCount - 1 do
    begin
      ARow := Rows[I];
      WriteRow(APath + '\Rows\' + ARow.Name, ARow);
    end;
  end;

begin
  inherited WriteSettings(ARegIniWrapper, APath);
  WriteCategories;
  WriteNodes;
  WriteRows;
end;

function TCustomdxInspectorControl.CanEditShow: Boolean;
begin
  Result := inherited CanEditShow;
  if Result and (FocusedNode <> nil) then
  begin
    if IsComplexNode(FocusedNode) and (GetInplaceEditRow(FocusedNode) = nil) then
      Result := False
    else
      if Assigned(FOnEditing) then
        FOnEditing(Self, FocusedNode, GetInplaceEditRow(FocusedNode), Result);
  end;
end;

function TCustomdxInspectorControl.GetInplaceEditRow(ANode: TdxInspectorNode): TdxInspectorRow;
begin
  if IsComplexNode(ANode) then
    Result := RowByComplexRowIndex(ANode, InplaceComplexRowIndex)
  else
    Result := TdxInspectorRowNode(ANode).Row;
end;

function TCustomdxInspectorControl.CreateEditor(ANode: TdxInspectorNode): TdxInplaceEdit;
begin
  Result := GetInplaceEditRow(ANode).GetdxInplaceEditClass.Create(Self);
  FEditors.Add(Result);
end;

function TCustomdxInspectorControl.FindInplaceEdit(ANode: TdxInspectorNode): TdxInplaceEdit;
var
  I: Integer;
  EClass: TdxInplaceEditClass;
begin
  Result := nil;
  EClass := GetInplaceEditRow(ANode).GetdxInplaceEditClass;
  for I := 0 to FEditors.Count - 1 do
    if TdxInplaceEdit(FEditors[I]).ClassType = EClass then
    begin
      Result := FEditors[I];
      Exit;
    end;
end;

function TCustomdxInspectorControl.GetEditColor: TColor;
begin
  Result := inherited GetEditColor;
  if (FocusedNode <> nil) and Assigned(FOnGetEditColor) then
    FOnGetEditColor(TdxInspectorRowNode(FocusedNode).Row, Result);
end;

function TCustomdxInspectorControl.GetEditFont: TFont;
begin
  Result := inherited GetEditFont;
  if (FocusedNode <> nil) and Assigned(FOnGetEditFont) then
  begin
    if FEditFont = nil then FEditFont := TFont.Create;
    FEditFont.Assign(Result);
    FOnGetEditFont(TdxInspectorRowNode(FocusedNode).Row, FEditFont);
    Result := FEditFont;
  end;
end;

procedure TCustomdxInspectorControl.InvalidateEditor;
begin
  inherited InvalidateEditor;
  FModified := False;
end;

function TCustomdxInspectorControl.AssignEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant;
var
  ModifiedFlag: Boolean;
begin
  ModifiedFlag := FModified or AInplaceEdit.Modified;
  if ModifiedFlag then
  begin
    EditValue := GetInplaceEditRow(ANode).AssignEditValue(AInplaceEdit);
    Result := EditValue;
    inherited AssignEditValue(ANode, AInplaceEdit);
    if ModifiedFlag and Assigned(FOnEdited) then
      FOnEdited(Self, FocusedNode, GetInplaceEditRow(FocusedNode));
    FModified := False;
  end;
end;

procedure TCustomdxInspectorControl.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if FocusedNode <> nil then
    GetInplaceEditRow(FocusedNode).InitEditProperties(AInplaceEdit);
end;

function TCustomdxInspectorControl.InitEditValue(ANode: TdxInspectorNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if FocusedNode <> nil then
    Result := GetInplaceEditRow(FocusedNode).InitEditValue(AInplaceEdit)
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
  EditValue := Result;  
end;

function TCustomdxInspectorControl.IsDefaultEqualValues(const AValue: Variant; ARow: TdxInspectorRow): Boolean;
begin
  Result := False;
end;

// private TCustomdxInspectorControl

procedure TCustomdxInspectorControl.AddRow(Row: TdxInspectorRow);
begin
  InternalCreateNodeForRow(Row);
  FRows.Add(Row);
  Row.FInspector := Self;
  UpdateRow(Nil);
  UpdateCustomizeForm;
end;

procedure TCustomdxInspectorControl.CheckHiddenRows;
var
  I: Integer;
begin
  for I := 0 to TotalRowCount - 1 do
    if not Rows[I].Visible then
      Rows[I].Hide;
end;

procedure TCustomdxInspectorControl.FreeStreamData;
begin
  if FStreamData <> nil then
  begin
    FStreamData.Free;
    FStreamData := nil;
  end;
end;

function TCustomdxInspectorControl.GetRow(Index : Integer): TdxInspectorRow;
begin
  Result := FRows[Index];
end;

function TCustomdxInspectorControl.GetTotalRowCount: Integer;
begin
  Result := FRows.Count;
end;

function TCustomdxInspectorControl.GetVisibleTotalRowCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to TotalRowCount - 1 do
    if Rows[I].Visible then
      Inc(Result);
end;

procedure TCustomdxInspectorControl.InternalCreateNodeForRow(Row: TdxInspectorRow);
begin
  if not FAddFlag and (Row.FNode = nil) then
  begin
    // add node
    FAddFlag := True;
    try
      Row.FNode := TdxInspectorRowNode(Add);
      Row.FNode.FRow := Row;
    finally
      FAddFlag := False;
    end;
  end;
end;

procedure TCustomdxInspectorControl.LoadOrderRows;

  procedure ReadInfo(var ACount: Integer; var ARow: TdxInspectorRow);
  var
    PInfo: PdxInspectorRowNodeInfo;
    ASize: Integer;
    S: string; // buffer
  begin
    FStreamData.ReadBuffer(ASize, SizeOf(ASize));
    GetMem(PInfo, ASize);
    try
      FStreamData.ReadBuffer(PInfo^, ASize);
      SetLength(S, PInfo^.StrLen);
      FStreamData.ReadBuffer(S[1], PInfo^.StrLen);
      ACount := PInfo^.Count;
      ARow := RowByName(S);
    finally
      FreeMem(PInfo, ASize);
    end;
  end;

  procedure MoveChildren(ACurNode: TdxInspectorRowNode);
  var
    I, ACount: Integer;
    ANode: TdxInspectorRowNode;
    ARow: TdxInspectorRow;
  begin
    ReadInfo(ACount, ARow);
    if ARow <> nil then
    begin
      ANode := ARow.Node;
      if ANode <> nil then
      begin
        ANode.MoveTo(ACurNode, inaAddChild);
        for I := 0 to ACount - 1 do
          MoveChildren(ANode);
      end;
    end
    else
      raise EFailureLoadOrderRows.Create('');
  end;

  procedure ReadExpandedInfo(var ARow: TdxInspectorRow);
  var
    PInfo: PdxInspectorRowNodeInfo;
    ASize: Integer;
    S: string; // buffer
  begin
    FStreamData.ReadBuffer(ASize, SizeOf(ASize));
    GetMem(PInfo, ASize);
    try
      FStreamData.ReadBuffer(PInfo^, ASize);
      SetLength(S, PInfo^.StrLen);
      FStreamData.ReadBuffer(S[1], PInfo^.StrLen);
      ARow := RowByName(S);
    finally
      FreeMem(PInfo, ASize);
    end;
  end;

var
  I, J, ACount, AItemCount: Integer;
  ARow: TdxInspectorRow;
  ANode: TdxInspectorRowNode;
begin
  if (FStreamData <> nil) and (FStreamData.Size > 0) then
  begin
    try
      FStreamData.Position := 0;
      FStreamData.ReadBuffer(AItemCount, SizeOf(AItemCount));
      for I := 0 to AItemCount - 1 do
      begin
        // read info
        ReadInfo(ACount, ARow);
        // move to root
        if ARow <> nil then
        begin
          ANode := ARow.Node;
          if ANode <> nil then
          begin
            ANode.MoveTo(Items[0], inaAdd);
            // move children
            for J := 0 to ACount - 1 do
              MoveChildren(ANode);
          end;
        end
        else
          raise EFailureLoadOrderRows.Create('');
      end;
      // expanded nodes
      if FStreamData.Position < FStreamData.Size then
      begin
        FullCollapse;
        FStreamData.ReadBuffer(AItemCount, SizeOf(AItemCount)); // expanded node(row) count
        for I := 0 to AItemCount - 1 do
        begin
          ReadExpandedInfo(ARow);
          if ARow <> nil then
            ARow.Node.Expanded := True
          else
            raise EFailureLoadOrderRows.Create('');
        end;
      end;
    except
      on EFailureLoadOrderRows do
        // ignore
      else
        raise;
    end;
  end;
end;

procedure TCustomdxInspectorControl.NotifyComplexRows(Row: TdxInspectorRow);
var
  I: Integer;
begin
  for I := 0 to TotalRowCount - 1 do
    if Rows[I] is TdxInspectorComplexRow then
      TdxInspectorComplexRow(Rows[I]).RemoveNotification(Row);
end;

procedure TCustomdxInspectorControl.ReadData(Stream: TStream);
var
  Size: Integer;
begin
  Stream.ReadBuffer(Size, SizeOf(Size));
  if FStreamData = nil then
    FStreamData := TMemoryStream.Create;
  FStreamData.Clear;
  FStreamData.CopyFrom(Stream, Size);
end;

procedure TCustomdxInspectorControl.RemoveRow(Row: TdxInspectorRow);
var
  N: TdxInspectorRowNode;
  Flag: Boolean;
begin
  Row.FInspector := Nil;
  // remove node
  if Row.Node <> nil then
  begin
    N := Row.Node;
    Row.FNode.FRow := nil;
    Row.FNode := nil;
    if not (csDestroying in ComponentState) then N.Free;
    Flag := True;
  end
  else Flag := False;
  FRows.Remove(Row);
  NotifyComplexRows(Row);
  if not (csDestroying in ComponentState) and Flag then
    UpdateRow(Nil);
  UpdateCustomizeForm;
end;

procedure TCustomdxInspectorControl.SetEditValue(const Value: Variant);
begin
  FEditValue := Value;
end;

procedure TCustomdxInspectorControl.SetRow(Index: Integer; Value: TdxInspectorRow);
begin
  TdxInspectorRow(FRows[Index]).Assign(Value);
end;

procedure TCustomdxInspectorControl.WriteData(AStream: TStream);
var
  AExpandedCount: Integer;
  
  procedure WriteExpandedData(ANode: TdxInspectorRowNode);
  var
    S: string;
    I, ASize: Integer;
    PInfo: PdxInspectorRowNodeInfo;
  begin
    with ANode do
    begin
      if Expanded then
      begin
        ASize := SizeOf(TdxInspectorRowNodeInfo);
        GetMem(PInfo, ASize);
        try
          if Row <> nil then
            S := Row.Name
          else
            S := '';
          PInfo^.StrLen := Length(S);
          // PInfo^.Count ignored
          AStream.WriteBuffer(ASize, SizeOf(ASize));
          AStream.WriteBuffer(PInfo^, ASize);
          if PInfo^.StrLen <> 0 then
            AStream.WriteBuffer(S[1], PInfo^.StrLen);
        finally
          FreeMem(PInfo, ASize);
        end;
        Inc(AExpandedCount);
      end;
      for I := 0 to Count - 1 do
        WriteExpandedData(TdxInspectorRowNode(Items[I]));
    end;
  end;

var
  I, ASize, APosStart, APosEnd, APosStartExpanded: Integer;
begin
  APosStart := AStream.Position;  // save position
  ASize := 0;
  AStream.WriteBuffer(ASize, SizeOf(ASize));
  // tree
  I := Count;
  AStream.WriteBuffer(I, SizeOf(I));
  for I := 0 to Count - 1 do
    TdxInspectorRowNode(Items[I]).WriteData(AStream);
  // expanded nodes
  APosStartExpanded := AStream.Position;
  AExpandedCount := 0;
  AStream.WriteBuffer(AExpandedCount, SizeOf(AExpandedCount));
  for I := 0 to Count - 1 do
    WriteExpandedData(TdxInspectorRowNode(Items[I]));
  if AExpandedCount > 0 then
  begin
    APosEnd := AStream.Position;  // save position
    AStream.Position := APosStartExpanded;
    AStream.WriteBuffer(AExpandedCount, SizeOf(AExpandedCount));
    AStream.Position := APosEnd;  // restore position
  end;
  // write size
  APosEnd := AStream.Position;
  AStream.Position := APosStart;
  ASize := APosEnd - APosStart - SizeOf(ASize);
  AStream.WriteBuffer(ASize, SizeOf(ASize));
  AStream.Position := APosEnd; // restore position
end;

{ TdxDBTreeListDesigner }

constructor TdxInspectorDesigner.Create(dxInspector: TCustomdxInspectorControl);
begin
  FInspector := dxInspector;
  FInspector.FDesigner := Self;
end;

destructor TdxInspectorDesigner.Destroy;
begin
  FInspector.FDesigner := nil;
  inherited Destroy;
end;

procedure TdxInspectorDesigner.LayoutChanged;
begin
end;

{ TdxInspector }

function TdxInspector.GetDefaultRowClass: TdxInspectorRowClass;
begin
  Result := TdxInspectorTextRow;
end;

function TdxInspector.CanEditModify: Boolean;
begin
  Result := False;
  if FocusedNode <> nil then
    with GetInplaceEditRow(FocusedNode) do
      if not ReadOnly and IsCanModify then
      begin
        Result := True;
        FModified := True;
      end;
end;

procedure TdxInspector.CMExit(var Message: TMessage);
begin
  try
    if (FInplaceEdit <> nil) and FInplaceEdit.IsVisible and
     (FInplaceNode <> nil) then InplaceEditor.ValidateEdit;
    HideEdit(False);
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

{ TdxInspectorTextRow }

function TdxInspectorTextRow.GetDisplayText: String;
begin
  Result := FText;
end;

function TdxInspectorTextRow.GetEditText: String;
begin
  Result := FText;
end;

procedure TdxInspectorTextRow.SetEditText(const Value: String);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

function TdxInspectorTextRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTextEdit;
end;

procedure TdxInspectorTextRow.SetText(const Value: String);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorComplexRowItem }

constructor TdxInspectorComplexRowItem.Create(Collection: TCollection);
begin
  FMinWidth := 20;
  FWidth := 50;
  inherited Create(Collection);
end;

procedure TdxInspectorComplexRowItem.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorComplexRowItem then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      Fixed := TdxInspectorComplexRowItem(Source).Fixed;
      MinWidth := TdxInspectorComplexRowItem(Source).MinWidth;
      Row := TdxInspectorComplexRowItem(Source).Row;
      Width := TdxInspectorComplexRowItem(Source).Width;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorComplexRowItem.RestoreDefaults;
begin
  FMinWidth := 20;
  FWidth := 50;
end;

function TdxInspectorComplexRowItem.GetDisplayName: string;
begin
  if Row <> nil then
    Result := Row.Name
  else
    Result := '';
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function TdxInspectorComplexRowItem.Inspector: TCustomdxInspectorControl;
begin
  if Assigned(Collection) and Assigned(TdxInspectorComplexRowItems(Collection).Row) then
    Result := TdxInspectorComplexRowItems(Collection).Row.Inspector
  else
    Result := nil;
end;

function TdxInspectorComplexRowItem.IsValidRow(ARow: TdxInspectorRow): Boolean;

  function ExistInInspector: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if Inspector <> nil then
      with Inspector do
        for I := 0 to Inspector.TotalRowCount - 1 do
          if Rows[I] = ARow then
          begin
            Result := True;
            Break;
          end;
  end;

begin
  Result := not (ARow is TdxInspectorComplexRow) and ExistInInspector;
end;

procedure TdxInspectorComplexRowItem.PrepareRow(ARow: TdxInspectorRow);
begin
  ARow.Visible := False;
  Inspector.ClearComplexRows(ARow);
end;

procedure TdxInspectorComplexRowItem.SetFixed(Value: Boolean);
begin
  if FFixed <> Value then
  begin
    FFixed := Value;
    Changed(True);
  end;
end;

procedure TdxInspectorComplexRowItem.SetMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FMinWidth := Value;
  SetWidth(FWidth);
end;

procedure TdxInspectorComplexRowItem.SetRow(Value: TdxInspectorRow);
begin
  if (Value <> nil) and not IsValidRow(Value) then Exit;
  if FRow <> Value then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      if Value <> nil then
        PrepareRow(Value);
      FRow := Value;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end;
end;

procedure TdxInspectorComplexRowItem.SetWidth(Value: Integer);
begin
  if Value < FMinWidth then Value := FMinWidth;
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed(True); 
  end;
end;

{ TdxInspectorComplexRowItems }

constructor TdxInspectorComplexRowItems.Create(ARow: TdxInspectorComplexRow);
begin
  inherited Create(TdxInspectorComplexRowItem);
  FRow := ARow;
end;

function TdxInspectorComplexRowItems.Add: TdxInspectorComplexRowItem;
begin
  Result := TdxInspectorComplexRowItem(inherited Add);
end;

function TdxInspectorComplexRowItems.IndexOfRow(ARow: TdxInspectorRow): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].Row = ARow then
    begin
      Result := I;
      Break;
    end;
end;

procedure TdxInspectorComplexRowItems.RestoreDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

function TdxInspectorComplexRowItems.GetOwner: TPersistent;
begin
  Result := FRow;
end;

procedure TdxInspectorComplexRowItems.Update(Item: TCollectionItem);
begin
  if (FRow = nil) or ([csLoading, csDestroying] * FRow.ComponentState <> []) then Exit;
  if not (csDestroying in Row.Inspector.ComponentState) then
    Row.Inspector.LayoutChanged;
end;

function TdxInspectorComplexRowItems.GetItem(Index: Integer): TdxInspectorComplexRowItem;
begin
  Result := TdxInspectorComplexRowItem(inherited Items[Index]);
end;

procedure TdxInspectorComplexRowItems.SetItem(Index: Integer; Value: TdxInspectorComplexRowItem);
begin
  Items[Index].Assign(Value);
end;

{ TdxInspectorComplexRow }

constructor TdxInspectorComplexRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TdxInspectorComplexRowItems.Create(Self);
end;

destructor TdxInspectorComplexRow.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TdxInspectorComplexRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorComplexRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      Items := TdxInspectorComplexRow(Source).Items;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorComplexRow.RemoveNotification(ARow: TdxInspectorRow);
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    if Items[I].Row = ARow then
      Items[I].Row := nil;
end;

procedure TdxInspectorComplexRow.SetItems(Value: TdxInspectorComplexRowItems);
begin
  Items.Assign(Value);
end;

{ TdxInspectorComplexRowViewInfoItem }

constructor TdxInspectorComplexRowViewInfoItem.Create(ARow: TdxInspectorRow);
begin
  inherited Create;
  FRow := ARow;
end;

{ TdxInspectorComplexRowViewInfo }

constructor TdxInspectorComplexRowViewInfo.Create(ARow: TdxInspectorComplexRow;
  ASeparatorWidth: Integer);
begin
  inherited Create;
  FItems := TList.Create;
  FRow := ARow;
  FSeparatorWidth := ASeparatorWidth;
end;

destructor TdxInspectorComplexRowViewInfo.Destroy;
begin
  Clear;
  FItems.Free;
  inherited Destroy;
end;

procedure TdxInspectorComplexRowViewInfo.Calculate(const ARect: TRect);
var
  AVisibleWidth: Integer;

  procedure AddViewItem(ARow: TdxInspectorRow; AFixed, ASeparator: Boolean; AWidth, AMinWidth: Integer);
  var
    AItem: TdxInspectorComplexRowViewInfoItem;
  begin
    AItem := Add(ARow);
    AItem.Fixed := AFixed;
    AItem.MinWidth := AMinWidth;
    AItem.Separator := ASeparator;
    AItem.Width := AWidth;
    if AItem.Fixed then
      Dec(AVisibleWidth, AWidth);
  end;

  procedure AddViewItems;
  var
    I: Integer;
    AItem: TdxInspectorComplexRowItem;
  begin
    for I := 0 to Row.Items.Count - 1 do
    begin
      AItem := Row.Items[I];
      AddViewItem(AItem.Row, AItem.Fixed, False, AItem.Width, AItem.MinWidth);
      if I <> (Row.Items.Count - 1) then // Separator
        AddViewItem(nil, True, True, SeparatorWidth, 0);
    end;
  end;

  procedure ScaledWidths;
  var
    ARecalcNeeded, ACalculation: Boolean;
    I, AWidth, AScalableWidth: Integer;
  begin
    if AVisibleWidth < 0 then
      AVisibleWidth := 0;
    ACalculation := True;
    repeat
      ARecalcNeeded := False;
      AScalableWidth := 0;
      for I := 0 to Count - 1 do
        if not Items[I].Fixed then
          Inc(AScalableWidth, Items[I].Width);
      for I := 0 to Count - 1 do
        if not Items[I].Fixed then
        begin
          if AScalableWidth > 0 then
            AWidth := Items[I].Width * AVisibleWidth div AScalableWidth
          else
            AWidth := 0;
          if ACalculation then
          begin
            if AWidth < Items[I].MinWidth then
            begin
              Items[I].Width := Items[I].MinWidth;
              Items[I].Fixed := True;
              Dec(AVisibleWidth, Items[I].Width);
              ARecalcNeeded := True;
              Break;
            end;
          end
          else
            Items[I].Width := AWidth;
        end;
      if not ACalculation then
        Break;
      if not ARecalcNeeded then
        ACalculation := False;
    until False;
  end;

  procedure CalcOffset;
  var
    I, ALeft: Integer;
    R: TRect;
  begin
    ALeft := ARect.Left;
    for I := 0 to Count - 1 do
    begin
      Items[I].Bounds := Rect(ALeft, ARect.Top, ALeft + Items[I].Width, ARect.Bottom);
      Inc(ALeft, Items[I].Width);
    end;
    if (ALeft < ARect.Right) and (Count > 0) then
    begin
      R := Items[Count - 1].Bounds;
      R.Right := ARect.Right;
      Items[Count - 1].Bounds := R;
    end;
  end;

begin
  Clear;
  AVisibleWidth := ARect.Right - ARect.Left;
  if Assigned(Row) and (AVisibleWidth > 0) then
  begin
    AddViewItems;
    ScaledWidths;
    CalcOffset;
  end;
end;

procedure TdxInspectorComplexRowViewInfo.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    TdxInspectorComplexRowViewInfoItem(FItems[I]).Free;
  FItems.Clear;
end;

function TdxInspectorComplexRowViewInfo.Add(ARow: TdxInspectorRow): TdxInspectorComplexRowViewInfoItem;
begin
  Result := TdxInspectorComplexRowViewInfoItem.Create(ARow);
  FItems.Add(Result);
end;

function TdxInspectorComplexRowViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxInspectorComplexRowViewInfo.GetEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TdxInspectorComplexRowViewInfo.GetItem(Index: Integer): TdxInspectorComplexRowViewInfoItem;
begin
  Result := FItems[Index];
end;

var
  FAntiBugImageList: HImageList;

initialization
  CreateBitmaps;
  Classes.RegisterClasses([TdxInspectorComplexRow, TdxInspectorTextRow]);
  FAntiBugImageList := ImageList_Create(1, 1, ILC_COLOR, 1, 1);

  Screen.Cursors[crdxInspectorInsert] := LoadCursor(HInstance, dxInspectorInsertCursor);
  Screen.Cursors[crdxInspectorAddChild] := LoadCursor(HInstance, dxInspectorAddChildCursor);
  Screen.Cursors[crdxInspectorAdd] := LoadCursor(HInstance, dxInspectorAddCursor);
  Screen.Cursors[crdxInspectorHide] := LoadCursor(HInstance, dxInspectorHideCursor);
  Screen.Cursors[crdxInspectorNoDrag] := LoadCursor(HInstance, dxInspectorNoDragCursor);

finalization
  if FAntiBugImageList <> 0 then
  begin
    ImageList_Destroy(FAntiBugImageList);
    FAntiBugImageList := 0;
  end;
  DestroyBitmaps;

  {$IFDEF DELPHI4}
  DestroyCursor(Screen.Cursors[crdxInspectorInsert]);
  DestroyCursor(Screen.Cursors[crdxInspectorAddChild]);
  DestroyCursor(Screen.Cursors[crdxInspectorAdd]);
  DestroyCursor(Screen.Cursors[crdxInspectorHide]);
  DestroyCursor(Screen.Cursors[crdxInspectorNoDrag]);
  {$ENDIF}

end.
// TODO: visible norify in Editor
