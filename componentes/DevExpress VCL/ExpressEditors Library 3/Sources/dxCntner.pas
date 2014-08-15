
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express base inplace edit and container                     }
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

unit dxCntner;

interface

{$I dxEdVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  StdCtrls, dxUtils, Imm{$IFDEF DELPHI6}, Variants{$ENDIF};

const
  dxedMinWidth = 20;
  {$IFNDEF DELPHI3}
  WM_MOUSEWHEEL       = $020A;
  {$ENDIF}
  CM_HIDEPOPUP = WM_APP + 101;

  dxEditBorderSize = 2;
  dxEditShadowSize = 2; // TODO 3
  dxEditShadowColor = clBtnShadow;

type
  TdxInplaceEdit = class;
  TCustomdxContainer = class;
  TdxDrawAlignment = (daSingleLine, daVCenter, daBottom, daMultiLine);
  
  TdxEditBorderStyle = (xbsNone, xbsSingle, xbsThick, xbsFlat, xbs3D);
  TdxEditButtonViewStyle = (btsDefault, bts3D, btsFlat, btsSimple, btsHotFlat);
  TdxEditButtonTransparence = (ebtNone, ebtInactive, ebtAlways, ebtHideInactive);
  TdxEditEdge = (edgLeft, edgTop, edgRight, edgBottom);
  TdxEditEdges = set of TdxEditEdge;
  TdxPopupBorder = (pbDefault, pbSingle, pbFrame3D, pbFlat);
  TdxPopupBorderStyle = pbSingle .. pbFlat;

  { TdxEditViewData }
  TdxEditViewData = class
    // State
    Enabled: Boolean;
    Focused: Boolean;
    Selected: Boolean;
    // Style
    BorderColor: TColor;
    BorderStyle: TdxEditBorderStyle;
    ButtonStyle: TdxEditButtonViewStyle;
    ButtonTransparence: Boolean;
    FocusRect: Boolean;
    Edges: TdxEditEdges;
    Shadow: Boolean;
    NoTransparentText: Boolean;
    Transparent: Boolean;
    // ViewBounds
    OffsetSize: TRect;
    ViewBounds: TRect;
    // General Data
    Alignment: TAlignment;
    DrawAlignment: TdxDrawAlignment;
    Brush: HBRUSH;
    BkColor: TColorRef;
    Font: HFONT;
    TextColor: TColorRef;
    IsEditClass: Boolean;
    Data: Variant;
    DataLength: Integer; // 0 - full length
    // TempBitmap
    TempDrawBitmap: TBitmap;
    // RowAutoHeight (Container)
    CalcHeight: Boolean;         // True -  if calculation is needed
    LineCount: Integer;
    LineHeight: Integer; 
    LineTextHeight: Integer;
    Cursor: TCursor; 
  end;

  TdxEditViewDataClass = class of TdxEditViewData;

  { TdxEditViewInfo }
  TdxEditViewInfo = record
    BorderSize: Integer;
    ShadowSize: Integer;
    Bounds: TRect;
    ClientBounds: TRect;
    FlagLeft, FlagTop, FlagRight, FlagBottom: Boolean;
    BorderRect: TRect;
    ShadowRect: TRect;
  end;

  { TdxEditStyle }
  TdxEditStyleValue = (svBorderColor, svBorderStyle, svButtonStyle,
    svButtonTransparence, svEdges, svHotTrack, svShadow);
  TdxEditStyleValues = set of TdxEditStyleValue;

  { TdxStyleController }
  TdxStyleChangedEvent = procedure (Sender: TObject; Link: TObject) of object;

  TdxStyleController = class(TComponent)
  private
    FLinks: TList;
    FLockUpdate: Integer;
    FOnStyleChanged: TdxStyleChangedEvent;
  protected
    procedure Loaded; override;
    procedure AddLink(ALink: TObject); virtual;
    procedure Changed;
    procedure RemoveLink(ALink: TObject); virtual;
    procedure StyleChanged(ALink: TObject); virtual;
    property Links: TList read FLinks;
    property OnStyleChanged: TdxStyleChangedEvent read FOnStyleChanged write FOnStyleChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Update;
  end;

  { TdxEditStyleController }
  TdxEditStyleController = class(TdxStyleController)
  private
    FBorderColor: TColor;
    FBorderStyle: TdxEditBorderStyle;
    FButtonStyle: TdxEditButtonViewStyle;
    FButtonTransparence: TdxEditButtonTransparence;
    FEdges: TdxEditEdges;
    FHotTrack: Boolean;
    FShadow: Boolean;
    procedure SetBorderColor(Value: TColor);
    procedure SetBorderStyle(Value: TdxEditBorderStyle);
    procedure SetButtonStyle(Value: TdxEditButtonViewStyle);
    procedure SetButtonTransparence(Value: TdxEditButtonTransparence);
    procedure SetEdges(Value: TdxEditEdges);
    procedure SetHotTrack(Value: Boolean);
    procedure SetShadow(Value: Boolean);
  protected
    procedure StyleChanged(ALink: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
  published
    property BorderColor: TColor read FBorderColor write SetBorderColor default clWindowFrame;
    property BorderStyle: TdxEditBorderStyle read FBorderStyle write SetBorderStyle default xbs3D;
    property ButtonStyle: TdxEditButtonViewStyle read FButtonStyle write SetButtonStyle default btsDefault;
    property ButtonTransparence: TdxEditButtonTransparence read FButtonTransparence write SetButtonTransparence default ebtNone;
    property Edges: TdxEditEdges read FEdges write SetEdges default [edgLeft, edgTop, edgRight, edgBottom];
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property Shadow: Boolean read FShadow write SetShadow default False;
    property OnStyleChanged;
  end;

  TdxEditStyle = class(TPersistent)
  private
    FAssignedValues: TdxEditStyleValues;
    FBorderColor: TColor;
    FBorderStyle: TdxEditBorderStyle;
    FButtonStyle: TdxEditButtonViewStyle;
    FButtonTransparence: TdxEditButtonTransparence;
    FEdges: TdxEditEdges;
    FEdit: TdxInplaceEdit;
    FHotTrack: Boolean;
    FShadow: Boolean;
    function GetBorderColor: TColor;
    function GetBorderStyle: TdxEditBorderStyle;
    function GetButtonStyle: TdxEditButtonViewStyle;
    function GetButtonTransparence: TdxEditButtonTransparence;
    function GetEdges: TdxEditEdges;
    function GetHotTrack: Boolean;
    function GetShadow: Boolean;
    function IsBorderColorStored: Boolean;
    function IsBorderStyleStored: Boolean;
    function IsButtonStyleStored: Boolean;
    function IsButtonTransparenceStored: Boolean;
    function IsEdgesStored: Boolean;
    function IsHotTrackStored: Boolean;
    function IsShadowStored: Boolean;
    procedure SetAssignedValues(Value: TdxEditStyleValues);
    procedure SetBorderColor(Value: TColor);
    procedure SetBorderStyle(Value: TdxEditBorderStyle);
    procedure SetButtonStyle(Value: TdxEditButtonViewStyle);
    procedure SetButtonTransparence(Value: TdxEditButtonTransparence);
    procedure SetEdges(Value: TdxEditEdges);
    procedure SetHotTrack(Value: Boolean);
    procedure SetShadow(Value: Boolean);
  protected
    procedure Changed; virtual;
    function EditStyleController: TdxEditStyleController;
  public
    constructor Create(AEdit: TdxInplaceEdit);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultBorderColor: TColor; virtual;
    function DefaultBorderStyle: TdxEditBorderStyle; virtual;
    function DefaultButtonStyle: TdxEditButtonViewStyle; virtual;
    function DefaultButtonTransparence: TdxEditButtonTransparence; virtual;
    function DefaultEdges: TdxEditEdges; virtual;
    function DefaultHotTrack: Boolean; virtual;
    function DefaultShadow: Boolean; virtual;
    class function GetDefaultEditStyleController: TdxEditStyleController; virtual;
    procedure RestoreDefaults; virtual;
    property Edit: TdxInplaceEdit read FEdit;
  published
    property AssignedValues: TdxEditStyleValues read FAssignedValues write SetAssignedValues stored False;
    property BorderColor: TColor read GetBorderColor write SetBorderColor stored IsBorderColorStored;
    property BorderStyle: TdxEditBorderStyle read GetBorderStyle write SetBorderStyle stored IsBorderStyleStored;
    property ButtonStyle: TdxEditButtonViewStyle read GetButtonStyle write SetButtonStyle stored IsButtonStyleStored;
    property ButtonTransparence: TdxEditButtonTransparence read GetButtonTransparence write SetButtonTransparence stored IsButtonTransparenceStored;
    property Edges: TdxEditEdges read GetEdges write SetEdges stored IsEdgesStored;
    property HotTrack: Boolean read GetHotTrack write SetHotTrack stored IsHotTrackStored;
    property Shadow: Boolean read GetShadow write SetShadow stored IsShadowStored;
  end;

  TdxEditStyleClass = class of TdxEditStyle;

  { TdxEditDataDefinition }
  TdxEditStoredValue = (svAlignment, svEditLimit, svEditMask, svIsFloat,
    svMaxValue, svMinValue, svReadOnly, svRequired, svDisplayFormat);
  TdxEditStoredValues = set of TdxEditStoredValue;

  TdxEditNotifyEvent = procedure of object;
  TdxEditFocusControlEvent = procedure (var Done: Boolean) of object;

  TdxEditDataDefinition = class(TPersistent)
  private
    FOnActiveChange: TdxEditNotifyEvent;
    FOnDataChange: TdxEditNotifyEvent;
    FOnEditingChange: TdxEditNotifyEvent;
    FOnFocusControl: TdxEditFocusControlEvent;
    FOnLayoutChanged: TdxEditNotifyEvent;
    FOnUpdateData: TdxEditNotifyEvent;
  protected
    function CanEditModify: Boolean; virtual;
    function GetAlignment: TAlignment; virtual;
    function GetDisplayFormat: string; virtual;
    function GetDisplayValue: Variant; virtual;
    function GetEditLimit: Integer; virtual;
    function GetEditMask: string; virtual;
    function GetEditValue: Variant; virtual;
    function GetLinkObject: TObject; virtual;
    function GetMaxValue: Double; virtual;
    function GetMinValue: Double; virtual;
    function GetRequired: Boolean; virtual;
    function IsCanModify: Boolean; virtual;
    function IsFloatValue: Boolean; virtual;
    function IsReadOnly: Boolean; virtual;
    function IsValidChar(InputChar: Char): Boolean; virtual;
    procedure Modified; virtual;
    procedure Reset; virtual;
    procedure SetEditValue(const Value: Variant); virtual;
    procedure UpdateRecord; virtual;
    {$IFDEF DELPHI4}
    function ExecuteAction(Action: TBasicAction): Boolean; virtual;
    function UpdateAction(Action: TBasicAction): Boolean; virtual;
    {$ENDIF}
    // Events
    property OnActiveChange: TdxEditNotifyEvent read FOnActiveChange write FOnActiveChange;
    property OnDataChange: TdxEditNotifyEvent read FOnDataChange write FOnDataChange;
    property OnEditingChange: TdxEditNotifyEvent read FOnEditingChange write FOnEditingChange;
    property OnFocusControl: TdxEditFocusControlEvent read FOnFocusControl write FOnFocusControl;
    property OnLayoutChanged: TdxEditNotifyEvent read FOnLayoutChanged write FOnLayoutChanged;
    property OnUpdateData: TdxEditNotifyEvent read FOnUpdateData write FOnUpdateData;
  public
    // Style
    property Alignment: TAlignment read GetAlignment;
    property CanModify: Boolean read IsCanModify;  
    property DisplayFormat: string read GetDisplayFormat;
    property EditLimit: Integer read GetEditLimit;
    property EditMask: string read GetEditMask;
    property IsFloat: Boolean read IsFloatValue;
    property MaxValue: Double read GetMaxValue;
    property MinValue: Double read GetMinValue;
    property ReadOnly: Boolean read IsReadOnly;
    property Required: Boolean read GetRequired;
    // Data
    property DisplayValue: Variant read GetDisplayValue;
    property EditValue: Variant read GetEditValue;
    property LinkObject: TObject read GetLinkObject;
  end;

  { TdxInplaceEdit }
  EdxEditInvalidInput = class(Exception);

//TODO  TdxEditValidateState = (evsNormal, evsExpected, evsExecuted);

  TdxEditValidateEvent = procedure (Sender: TObject; var ErrorText: string; var Accept: Boolean) of object;

  TdxInplaceEdit = class(TWinControl)
  private
    FActive: Boolean;
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FDataAlignment: TAlignment;
    FDataDefinition: TdxEditDataDefinition;
    FLockActivate: Integer;
    FModified: Boolean;
    FOffsetSize: TRect;
    FPrevModified: Boolean;
    FPrevTextValue: string;
    FReadOnly: Boolean;
    FSelected: Boolean;
    FStyle: TdxEditStyle;
    FStyleController: TdxEditStyleController;
    FTransparent: Boolean;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FOnValidate: TdxEditValidateEvent;

    // NEW TODO
    FLockValidate: Integer; 

    procedure AdjustHeight;
    procedure CheckHotTrack;
    function GetAutoSize: Boolean;
    function GetContainer: TCustomdxContainer;
    function GetEditorColor: TColor;
    function GetReadOnly: Boolean;
    procedure InternalMove(const Loc: TRect; Redraw: Boolean);
    function IsAlignmentStored: Boolean;
    function IsReadOnlyStored: Boolean;
    procedure ReadHeight(Reader: TReader);
    procedure ReadStoredValues(Reader: TReader);
    procedure SetAlignment(Value: TAlignment);
    procedure SetDataDefinition(Value: TdxEditDataDefinition);
    procedure SetEditAutoSize(Value: Boolean);
    procedure SetOffsetSize(Value: TRect);
    procedure SetReadOnly(Value: Boolean);
    procedure SetStyle(Value: TdxEditStyle);
    procedure SetStyleController(Value: TdxEditStyleController);
    procedure SetTransparent(Value: Boolean);
    procedure WriteHeight(Writer: TWriter);
    procedure WriteStoredValues(Writer: TWriter);
    // messages
    procedure WMClear(var Message); message WM_CLEAR;
    procedure WMCut(var Message); message WM_CUT;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMImeComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message wm_Paint;
    procedure WMPaste(var Message); message WM_PASTE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    FCloseFlag: Boolean;           // for MaskEdit - if True then ignore ValidateEdit method
    FDisableCloseEditor: Boolean;  // for MaskEdit - if Modified no CloseEdit in Mousedown proc
    FDisableKillFocus: Boolean;    // for MaskEdit - no SetFocus Grid
    FDisablePopup: Boolean;        // no show popup menu in edit
    FDisableRefresh: Boolean;      // for Lookup and PickList edit (Field.Value := ?)
    FImmediatePopupStyle: Boolean;
    FInternalChanging: Boolean;
    FStoredValues: TdxEditStoredValues;
    procedure DblClick; override;
    {$IFNDEF DELPHI4}
    procedure DefaultHandler(var Message); override;
    {$ENDIF}
    procedure DefineProperties(Filer: TFiler); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;                                
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PaintWindow(DC: HDC); override;
    procedure ParentKeyDown(var Key: Word; Shift: TShiftState);
    procedure WndProc(var Message: TMessage); override;
    // DataDefinition
    procedure AssignEditValue(const Value: Variant); virtual;
    procedure AssignEditProperties; virtual; // DataDefinition
    procedure LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean); virtual;
    procedure PostValue;
    function ReturnEditValue: Variant; virtual;
    procedure DataChange; virtual;
    procedure FocusControl(var Done: Boolean); virtual;
    procedure LayoutChanged; virtual;
    procedure UpdateData; virtual;
    // virtual
    procedure BoundsChanged; virtual;                                // Inplace Mode
    function CanEditAcceptKey(Key: Char): Boolean; virtual;
    procedure Change; virtual;
    function CreateDataDefinition: TdxEditDataDefinition; virtual;
    function CreateStyle: TdxEditStyle;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; virtual;
    procedure DoSetFocus; virtual;
    function EditCanModify: Boolean; virtual;
    function GetDisableCloseEditor: Boolean; virtual;
    class function GetEditStyleClass: TdxEditStyleClass; virtual;
    function GetModified: Boolean; virtual;
    function KeyEditModify(Key: Word; Shift: TShiftState): Boolean; virtual;
    class procedure InflateBorderRect(var ABorderRect: TRect; const AViewInfo: TdxEditViewInfo; IsIncrement: Boolean);
    procedure InvalidateClientRect;
    function IsControlPressed: Boolean; virtual;
    function IsDrawFocused: Boolean; virtual;
    function IsWantMouseWheel: Boolean; virtual;
    function IsWantTab: Boolean; virtual;
    procedure MoveCol(ALeft: Boolean); virtual;
    procedure ResetEditValue; virtual;
    procedure SetActive(Value: Boolean); virtual;
    procedure SetEditAlignment(Value: TAlignment); virtual;
    procedure SetEditReadOnly(Value: Boolean); virtual;
    procedure SetModified(Value: Boolean); virtual;
    procedure SetSelected(Value: Boolean); virtual;
    procedure StyleChanged; virtual;

// TODO NEW
    procedure DisableValidate;   
    procedure EnableValidate;   

    property Alignment: TAlignment read FAlignment write SetAlignment stored IsAlignmentStored;
    property AutoSize: Boolean read GetAutoSize write SetEditAutoSize default True;
    property Container: TCustomdxContainer read GetContainer;
    property DataDefinition: TdxEditDataDefinition read FDataDefinition write SetDataDefinition;
    property EditorColor: TColor read GetEditorColor;
    property OffsetSize: TRect read FOffsetSize write SetOffsetSize;
    property PrevModified: Boolean read FPrevModified; // TODO remove ?
    property PrevTextValue: string read FPrevTextValue write FPrevTextValue;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly stored IsReadOnlyStored;
    property StoredValues: TdxEditStoredValues read FStoredValues;
    property StyleController: TdxEditStyleController read FStyleController write SetStyleController;
    property Transparent: Boolean read FTransparent write SetTransparent default False; // TODO
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnValidate: TdxEditValidateEvent read FOnValidate write FOnValidate;
  public
    FClickTime: Longint;                                             // Inplace Mode
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF DELPHI4}
    procedure DefaultHandler(var Message); override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    {$ENDIF}
    procedure ActivateEdit; virtual;
    function CanModify: Boolean; virtual;
    function CheckWidth(AButtonWidth: Integer): Integer;             // Inplace Mode TODO
    function DefaultAlignment: TAlignment; virtual;
    function DefaultReadOnly: Boolean; virtual;
    function InternalReadOnly: Boolean; virtual;
    procedure Deselect; virtual;
    procedure DoKillFocus(var Message: TWMKillFocus); virtual;
    function GetEditingText: string; virtual;
    procedure Hide; virtual;
    procedure InvalidateEdit;                                        // Inplace Mode
    function IsEditClass: Boolean; virtual;
    function IsEnterValidate: Boolean; virtual;
    function IsFocused: Boolean; virtual;
    function IsNeededRedraw: Boolean; virtual;
    function IsSelected: Boolean; virtual;
    function IsQuickButtonClick: Boolean; virtual;                   // Inplace Mode
    function IsResetTextClass: Boolean; virtual;                  
    {$IFDEF DELPHI4}
    function IsSupportedAction: Boolean; virtual;
    {$ENDIF}
    function IsVisible: Boolean;                                     // Inplace Mode
    procedure LockActivate;                                          // Inplace Mode
    procedure MouseButtonClick(X, Y: Integer); virtual;              // Inplace Mode
    procedure MouseClick; virtual;                                   // Inplace Mode
    procedure Move(const Loc: TRect);                                // Inplace Mode
    procedure Reset;
    procedure RestoreDefaults; virtual;
    procedure SelectAll; virtual;
    procedure SetEditingText(Value: string); virtual;                // Inplace Mode * (TODO const)
    procedure Show; virtual;
    procedure UnLockActivate;                                        // Inplace Mode
    procedure ValidateEdit; virtual;                                 
    // new class methods TODO
    class procedure CalcBoundsInfo(AViewData: TdxEditViewData; var ViewInfo: TdxEditViewInfo);
    class procedure CalcViewInfo(AViewData: TdxEditViewData; AutoSize: Boolean; var ViewInfo: TdxEditViewInfo); virtual;
    class procedure Draw(ADC: HDC; const ARect: TRect; AViewData: TdxEditViewData; ARgn: HRGN); virtual;
    class procedure DrawBorder(ADC: HDC; var ViewInfo: TdxEditViewInfo; AViewData: TdxEditViewData); virtual;
    class function DrawClientArea(ADC: HDC; var ARect: TRect; AViewData: TdxEditViewData; IsControl: Boolean): Boolean; virtual;
    class function GetEditCursor(X, Y: Integer; AViewData: TdxEditViewData): TCursor; virtual;
    class function GetEditRgn(const ViewInfo: TdxEditViewInfo): HRGN;
    class function GetMinHeight(AViewData: TdxEditViewData): Integer; virtual;
    class function GetMinRect(AViewData: TdxEditViewData): TRect; virtual;
    class function GetViewDataClass: TdxEditViewDataClass; virtual;
    class function IsInplace: Boolean; virtual;

    property CloseFlag: Boolean read FCloseFlag write FCloseFlag;    // Inplace Mode
    property DisableCloseEditor: Boolean read GetDisableCloseEditor; // Inplace Mode
    property DisableKillFocus: Boolean read FDisableKillFocus;       // Inplace Mode
    property DisablePopup: Boolean read FDisablePopup;
    property DisableRefresh: Boolean read FDisableRefresh;
    property Modified: Boolean read GetModified write SetModified;
    property Style: TdxEditStyle read FStyle write SetStyle;
  published
    property Height stored False;
  end;

  TdxInplaceEditClass = class of TdxInplaceEdit;

  { TCustomdxContainer }
  TCustomdxContainer = class(TCustomControl)
  private 
    FInitEdit: Boolean;
    {$IFDEF DELPHI4}
    FScrollBarStyle: TScrollBarStyle;
    procedure SetScrollBarStyle(const Value: TScrollBarStyle);
    {$ENDIF}
    procedure WMMouseWHeel(var Message: TWMMouse); message WM_MOUSEWHEEL;
  protected
    procedure CreateWnd; override;
    function CanEditModify: Boolean; virtual;
    function CanEditAcceptKey(Key: Char): Boolean; virtual;
    function CheckEditorWidth: Boolean; virtual;
    function CreateEditStyle(AEdit: TdxInplaceEdit): TdxEditStyle; virtual;
    procedure DoMouseWHeelScroll(AScrollUp: Boolean; AScrollLines: Integer); virtual;
    function GetEditColor: TColor; virtual;
    function GetEditFont: TFont; virtual;
    function GetReadOnly: Boolean; virtual;
    function HideDrawFocusRect: Boolean; virtual;
    procedure InplaceEditKeyDown(var Key: Word; Shift: TShiftState); virtual;
    function IsEditorMoved: Boolean; virtual;
    function IsImmediateEditor: Boolean; virtual;
    function IsShowButtonAlways: Boolean; virtual;
    function IsTabs: Boolean; virtual;
    procedure MoveCol(ALeft: Boolean); virtual;
    procedure RedrawSelection; virtual;
    procedure BeginInitEdit; virtual;
    procedure EndInitEdit; virtual;
    // Scroll Bars
    function GetScrollInfo(BarFlag: Integer; var ScrollInfo: TScrollInfo): BOOL;
    function SetScrollInfo(BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer;
    {$IFDEF DELPHI4}
    procedure AdjustSize; override;
    property ScrollBarStyle: TScrollBarStyle read FScrollBarStyle write SetScrollBarStyle default ssRegular;
    {$ENDIF}
    property ReadOnly: Boolean read GetReadOnly;
  public
    // TODO ?
    function GetDefaultPopupBorderStyle(AEditBorderStyle: TdxEditBorderStyle): TdxPopupBorderStyle; virtual;
    property IsInitEdit: Boolean read FInitEdit;
  end;

  { TdxContainerHintWindow }
  TdxContainerHintWindow = class(TCustomControl)
  private
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ActivateHint(P: TPoint; const AHint: string; AFont: TFont);
    procedure ActivateHintEx(P: TPoint; AWidth: Integer; const AHint: string;
      AFont: TFont; AUseFontSize: Boolean);
    procedure HideHint;  
  end;

  { TdxInplacePopupControl }
  TdxInplacePopupControl = class(TCustomControl)
  private
    FPopupBorderStyle: TdxPopupBorderStyle;
    FShadow: Boolean;
    FShadowSize: Integer;
    procedure SetPopupBorderStyle(Value: TdxPopupBorderStyle);
    procedure SetShadow(Value: Boolean);
    procedure SetShadowSize(Value: Integer);
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    FIsPopupControl: Boolean;
    FDrawNC: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    OwnerControl: TdxInplaceEdit;
    constructor Create(AOwner: TComponent); override;
    procedure HidePopup(ByMouse: Boolean); virtual;
    procedure ShowPopup; virtual;
    property PopupBorderStyle: TdxPopupBorderStyle read FPopupBorderStyle write SetPopupBorderStyle default pbSingle;
    property Shadow: Boolean read FShadow write SetShadow default False;
    property ShadowSize: Integer read FShadowSize write SetShadowSize default dxEditShadowSize;
  end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
procedure DrawPopupBorder(DC: HDC; var R: TRect; BorderStyle: TdxPopupBorderStyle; 
  ScrollBars, Shadow: Boolean; ShadowSize: Integer);
procedure DrawWindowPopupBorder(Wnd: HWND; BorderStyle: TdxPopupBorderStyle;
  ScrollBars, Shadow: Boolean; ShadowSize: Integer);
procedure UpdateShadow(Wnd: HWND; Shadow: Boolean; ShadowSize: Integer);

var
  DefaultEditStyleController: TdxEditStyleController;
  
implementation

uses
  {$IFNDEF DELPHI3}Ole2, {$ELSE}ActiveX, {$ENDIF}{TextToDate}
  dxEdStr, CommCtrl{$IFDEF DELPHI4}, FlatSB{$ENDIF};

procedure KillMessage(Wnd: HWnd; Msg: Integer);
// Delete the requested message from the queue, but throw back
// any WM_QUIT msgs that PeekMessage may also return
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, PM_REMOVE) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.Wparam);
end;

procedure DrawPopupBorder(DC: HDC; var R: TRect; BorderStyle: TdxPopupBorderStyle;
  ScrollBars, Shadow: Boolean; ShadowSize: Integer);
var
  SR: TRect;
begin
  if Shadow then
  begin
    Dec(R.Right, ShadowSize);
    Dec(R.Bottom, ShadowSize);
    SR := R;
    OffsetRect(SR, ShadowSize, ShadowSize);
  end;
  // Border
  case BorderStyle of
    pbSingle:
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT or BF_MONO or BF_ADJUST);
    pbFlat:
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_ADJUST);
    pbFrame3D:
      begin
        DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_ADJUST);
        DrawEdge(DC, R, BDR_SUNKENINNER, BF_RECT or BF_FLAT or BF_ADJUST);
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST);
      end;
  end;
  // Shadow
  if Shadow then
    DrawShadow(DC, SR, ShadowSize, ShadowBrush);
  // ScollBars
  if ScrollBars then
  begin
    with R do
      SR := Rect(Right - GetSystemMetrics(SM_CXVSCROLL),
        Bottom - GetSystemMetrics(SM_CYHSCROLL), Right, Bottom);
    if Shadow then
      OffsetRect(SR, -ShadowSize, -ShadowSize);
    FillRect(DC, SR, GetSysColorBrush(COLOR_BTNFACE));
  end;
end;

procedure DrawWindowPopupBorder(Wnd: HWND; BorderStyle: TdxPopupBorderStyle;
  ScrollBars, Shadow: Boolean; ShadowSize: Integer);
var
  DC: HDC;
  R: TRect;
begin
  GetWindowRect(Wnd, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Wnd);
  DrawPopupBorder(DC, R, BorderStyle, ScrollBars, Shadow, ShadowSize);
  ReleaseDC(Wnd, DC);
end;

procedure UpdateShadow(Wnd: HWND; Shadow: Boolean; ShadowSize: Integer);
var
  R: TRect;
  Rgn, TempRgn: HRGN;
begin
  if Shadow then
  begin
    GetWindowRect(Wnd, R);
    OffsetRect(R, -R.Left, -R.Top);
    Dec(R.Right, ShadowSize);
    Dec(R.Bottom, ShadowSize);
    Rgn := CreateRectRgnIndirect(R);
    OffsetRect(R, ShadowSize, ShadowSize);
    TempRgn := CreateRectRgnIndirect(R);
    CombineRgn(Rgn, Rgn, TempRgn, RGN_OR);
    DeleteObject(TempRgn);
  end
  else
    Rgn := 0;
  SetWindowRgn(Wnd, Rgn, True);
end;

{ TdxStyleController }
constructor TdxStyleController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLinks := TList.Create;
end;

destructor TdxStyleController.Destroy;
begin
  FLinks.Free;
  inherited Destroy;
end;

procedure TdxStyleController.BeginUpdate;
begin
  Inc(FLockUpdate);
end;

procedure TdxStyleController.EndUpdate;
begin
  Dec(FLockUpdate);
  Changed;
end;

procedure TdxStyleController.Update;
begin
  Changed;
end;

procedure TdxStyleController.Loaded;
begin
  inherited Loaded;
  Update;
end;

procedure TdxStyleController.AddLink(ALink: TObject);
begin
  FLinks.Add(ALink);
end;

procedure TdxStyleController.Changed;
var
  I: Integer;
begin
  if (FLockUpdate <> 0) or (csLoading in ComponentState) then Exit;
  for I := 0 to Links.Count - 1 do
    StyleChanged(Links[I]);
end;

procedure TdxStyleController.RemoveLink(ALink: TObject);
begin
  FLinks.Remove(ALink);
end;

procedure TdxStyleController.StyleChanged(ALink: TObject);
begin
  if Assigned(FOnStyleChanged) then
    FOnStyleChanged(Self, ALink);
end;

{ TdxEditStyleController }
constructor TdxEditStyleController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorderColor := clWindowFrame;
  FBorderStyle := xbs3D;
  FButtonStyle := btsDefault;
  FButtonTransparence := ebtNone;
  FEdges := [edgLeft, edgTop, edgRight, edgBottom];
  FHotTrack := False;
  FShadow := False;
end;

procedure TdxEditStyleController.Assign(Source: TPersistent);
begin
  if Source is TdxEditStyleController then
  begin
    BeginUpdate;
    try
      BorderColor := TdxEditStyleController(Source).BorderColor;
      BorderStyle := TdxEditStyleController(Source).BorderStyle;
      ButtonStyle := TdxEditStyleController(Source).ButtonStyle;
      ButtonTransparence := TdxEditStyleController(Source).ButtonTransparence;
      Edges := TdxEditStyleController(Source).Edges;
      HotTrack := TdxEditStyleController(Source).HotTrack;
      Shadow := TdxEditStyleController(Source).Shadow;
    finally
      EndUpdate;
    end;  
  end
  else
    inherited Assign(Source);
end;

procedure TdxEditStyleController.RestoreDefaults;
begin
  BeginUpdate;
  try
    BorderColor := clWindowFrame;
    BorderStyle := xbs3D;
    ButtonStyle := btsDefault;
    ButtonTransparence := ebtNone;
    Edges := [edgLeft, edgTop, edgRight, edgBottom];
    HotTrack := False;
    Shadow := False;
  finally
    EndUpdate;
  end;
end;

procedure TdxEditStyleController.StyleChanged(ALink: TObject);
begin
  with TdxInplaceEdit(ALink) do
  begin
    if Assigned(StyleController) and (StyleController <> Self) then // Default Controller 
      Exit;
    StyleChanged;
  end;
  inherited StyleChanged(ALink);
end;

procedure TdxEditStyleController.SetBorderColor(Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Changed;
  end;  
end;

procedure TdxEditStyleController.SetBorderStyle(Value: TdxEditBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    Changed;
  end;
end;

procedure TdxEditStyleController.SetButtonStyle(Value: TdxEditButtonViewStyle);
begin
  if FButtonStyle <> Value then
  begin
    FButtonStyle := Value;
    Changed;
  end;  
end;

procedure TdxEditStyleController.SetButtonTransparence(Value: TdxEditButtonTransparence);
begin
  if FButtonTransparence <> Value then
  begin
    FButtonTransparence := Value;
    Changed;
  end;
end;

procedure TdxEditStyleController.SetEdges(Value: TdxEditEdges);
begin
  if FEdges <> Value then
  begin
    FEdges := Value;
    Changed;
  end;  
end;

procedure TdxEditStyleController.SetHotTrack(Value: Boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    Changed;
  end;  
end;

procedure TdxEditStyleController.SetShadow(Value: Boolean);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    Changed;
  end;
end;

{ TdxEditStyle }
constructor TdxEditStyle.Create(AEdit: TdxInplaceEdit);
begin
  inherited Create;
  FEdit := AEdit;
  // RegisterEdit
  if GetDefaultEditStyleController <> nil then
    GetDefaultEditStyleController.AddLink(FEdit);
end;

destructor TdxEditStyle.Destroy;
begin
  // UnregisterEdit
  if GetDefaultEditStyleController <> nil then
    GetDefaultEditStyleController.RemoveLink(FEdit);
  inherited Destroy;
end;  

procedure TdxEditStyle.Assign(Source: TPersistent);
begin
  if Source is TdxEditStyle then
  begin
    BorderColor := TdxEditStyle(Source).BorderColor;
    BorderStyle := TdxEditStyle(Source).BorderStyle;
    ButtonStyle := TdxEditStyle(Source).ButtonStyle;
    ButtonTransparence := TdxEditStyle(Source).ButtonTransparence;
    Edges := TdxEditStyle(Source).Edges;
    HotTrack := TdxEditStyle(Source).HotTrack;
    Shadow := TdxEditStyle(Source).Shadow;
  end
  else
    inherited Assign(Source);
end;


function TdxEditStyle.DefaultBorderColor: TColor;
begin
  if EditStyleController <> nil then
    Result := EditStyleController.BorderColor
  else
    if GetDefaultEditStyleController <> nil then
      Result := GetDefaultEditStyleController.BorderColor
    else
      Result := clWindowFrame;
end;

function TdxEditStyle.DefaultBorderStyle: TdxEditBorderStyle;
begin
  if EditStyleController <> nil then
    Result := EditStyleController.BorderStyle
  else
    if GetDefaultEditStyleController <> nil then
      Result := GetDefaultEditStyleController.BorderStyle
    else
      Result := xbs3D;
end;

function TdxEditStyle.DefaultButtonStyle: TdxEditButtonViewStyle;
begin
  if EditStyleController <> nil then
    Result := EditStyleController.ButtonStyle
  else
    if GetDefaultEditStyleController <> nil then
      Result := GetDefaultEditStyleController.ButtonStyle
    else
      Result := btsDefault;
end;

function TdxEditStyle.DefaultButtonTransparence: TdxEditButtonTransparence;
begin
  if EditStyleController <> nil then
    Result := EditStyleController.ButtonTransparence
  else
    if GetDefaultEditStyleController <> nil then
      Result := GetDefaultEditStyleController.ButtonTransparence
    else
      Result := ebtNone;
end;

function TdxEditStyle.DefaultEdges: TdxEditEdges;
begin
  if EditStyleController <> nil then
    Result := EditStyleController.Edges
  else
    if GetDefaultEditStyleController <> nil then
      Result := GetDefaultEditStyleController.Edges
    else
      Result := [edgLeft, edgTop, edgRight, edgBottom];
end;

function TdxEditStyle.DefaultHotTrack: Boolean;
begin
  if EditStyleController <> nil then
    Result := EditStyleController.HotTrack
  else
    if GetDefaultEditStyleController <> nil then
      Result := GetDefaultEditStyleController.HotTrack
    else
      Result := False;
end;

function TdxEditStyle.DefaultShadow: Boolean;
begin
  if EditStyleController <> nil then
    Result := EditStyleController.Shadow
  else
    if GetDefaultEditStyleController <> nil then
      Result := GetDefaultEditStyleController.Shadow
    else
      Result := False;
end;

class function TdxEditStyle.GetDefaultEditStyleController: TdxEditStyleController;
begin
  Result := DefaultEditStyleController; 
end;

procedure TdxEditStyle.RestoreDefaults;
begin
  FAssignedValues := [];
  Changed;
end;

procedure TdxEditStyle.Changed;
begin
  Edit.StyleChanged;
end;

function TdxEditStyle.EditStyleController: TdxEditStyleController;
begin
  if Assigned(Edit) and Assigned(Edit.StyleController) then            
    Result := Edit.StyleController
  else Result := nil;
end;

function TdxEditStyle.GetBorderColor: TColor;
begin
  if svBorderColor in FAssignedValues then
    Result := FBorderColor
  else Result := DefaultBorderColor;
end;

function TdxEditStyle.GetBorderStyle: TdxEditBorderStyle;
begin
  if svBorderStyle in FAssignedValues then
    Result := FBorderStyle
  else Result := DefaultBorderStyle;
end;

function TdxEditStyle.GetButtonStyle: TdxEditButtonViewStyle;
begin
  if svButtonStyle in FAssignedValues then
    Result := FButtonStyle
  else Result := DefaultButtonStyle;
end;

function TdxEditStyle.GetButtonTransparence: TdxEditButtonTransparence;
begin
  if svButtonTransparence in FAssignedValues then
    Result := FButtonTransparence
  else Result := DefaultButtonTransparence;
end;

function TdxEditStyle.GetEdges: TdxEditEdges;
begin
  if svEdges in FAssignedValues then
    Result := FEdges
  else Result := DefaultEdges;
end;

function TdxEditStyle.GetHotTrack: Boolean;
begin
  if svHotTrack in FAssignedValues then
    Result := FHotTrack
  else Result := DefaultHotTrack;
end;

function TdxEditStyle.GetShadow: Boolean;
begin
  if svShadow in FAssignedValues then
    Result := FShadow
  else Result := DefaultShadow;
end;

function TdxEditStyle.IsBorderColorStored: Boolean;
begin
  Result := (svBorderColor in FAssignedValues);
end;

function TdxEditStyle.IsBorderStyleStored: Boolean;
begin
  Result := (svBorderStyle in FAssignedValues);
end;

function TdxEditStyle.IsButtonTransparenceStored: Boolean;
begin
  Result := (svButtonTransparence in FAssignedValues);
end;

function TdxEditStyle.IsButtonStyleStored: Boolean;
begin
  Result := (svButtonStyle in FAssignedValues);
end;

function TdxEditStyle.IsEdgesStored: Boolean;
begin
  Result := (svEdges in FAssignedValues);
end;

function TdxEditStyle.IsHotTrackStored: Boolean;
begin
  Result := (svHotTrack in FAssignedValues);
end;

function TdxEditStyle.IsShadowStored: Boolean;
begin
  Result := (svShadow in FAssignedValues);
end;

procedure TdxEditStyle.SetAssignedValues(Value: TdxEditStyleValues);
begin
  if FAssignedValues <> Value then
  begin
    FAssignedValues := Value;
    Changed;
  end;
end;

procedure TdxEditStyle.SetBorderColor(Value: TColor);
begin
  if (svBorderColor in FAssignedValues) and (Value = FBorderColor) then Exit;
  FBorderColor := Value;
  Include(FAssignedValues, svBorderColor);
  Changed;
end;

procedure TdxEditStyle.SetBorderStyle(Value: TdxEditBorderStyle);
begin
  if (svBorderStyle in FAssignedValues) and (Value = FBorderStyle) then Exit;
  FBorderStyle := Value;
  Include(FAssignedValues, svBorderStyle);
  Changed;
end;

procedure TdxEditStyle.SetButtonStyle(Value: TdxEditButtonViewStyle);
begin
  if (svButtonStyle in FAssignedValues) and (Value = FButtonStyle) then Exit;
  FButtonStyle := Value;
  Include(FAssignedValues, svButtonStyle);
  Changed;
end;

procedure TdxEditStyle.SetButtonTransparence(Value: TdxEditButtonTransparence);
begin
  if (svButtonTransparence in FAssignedValues) and (Value = FButtonTransparence) then Exit;
  FButtonTransparence := Value;
  Include(FAssignedValues, svButtonTransparence);
  Changed;
end;

procedure TdxEditStyle.SetEdges(Value: TdxEditEdges);
begin
  if (svEdges in FAssignedValues) and (Value = FEdges) then Exit;
  FEdges := Value;
  Include(FAssignedValues, svEdges);
  Changed;
end;

procedure TdxEditStyle.SetHotTrack(Value: Boolean);
begin
  if (svHotTrack in FAssignedValues) and (Value = FHotTrack) then Exit;
  FHotTrack := Value;
  Include(FAssignedValues, svHotTrack);
  Changed;
end;

procedure TdxEditStyle.SetShadow(Value: Boolean);
begin
  if (svShadow in FAssignedValues) and (Value = FShadow) then Exit;
  FShadow := Value;
  Include(FAssignedValues, svShadow);
  Changed;
end;

{ TdxEditDataDefinition }
function TdxEditDataDefinition.CanEditModify: Boolean;
begin
  Result := True;
end;

function TdxEditDataDefinition.GetAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TdxEditDataDefinition.GetDisplayFormat: string;
begin
  Result := '';
end;

function TdxEditDataDefinition.GetDisplayValue: Variant;
begin
  Result := GetEditValue;
end;

function TdxEditDataDefinition.GetEditLimit: Integer;
begin
  Result := 0;
end;

function TdxEditDataDefinition.GetEditMask: string;
begin
  Result := '';
end;

function TdxEditDataDefinition.GetEditValue: Variant;
begin
  Result := '';
end;

function TdxEditDataDefinition.GetLinkObject: TObject;
begin
  Result := nil;
end;

function TdxEditDataDefinition.GetMaxValue: Double;
begin
  Result := 0.0;
end;

function TdxEditDataDefinition.GetMinValue: Double;
begin
  Result := 0.0;
end;

function TdxEditDataDefinition.GetRequired: Boolean;
begin
  Result := False;
end;

function TdxEditDataDefinition.IsCanModify: Boolean;
begin
  Result := True;
end;

function TdxEditDataDefinition.IsFloatValue: Boolean;
begin
  Result := False; 
end;

function TdxEditDataDefinition.IsReadOnly: Boolean;
begin
  Result := False;
end;

function TdxEditDataDefinition.IsValidChar(InputChar: Char): Boolean;
begin
  Result := True;
end;

procedure TdxEditDataDefinition.Modified;
begin
end;

procedure TdxEditDataDefinition.Reset;
begin
  if Assigned(FOnDataChange) then
    FOnDataChange;
end;

procedure TdxEditDataDefinition.SetEditValue(const Value: Variant);
begin
end;

procedure TdxEditDataDefinition.UpdateRecord;
begin
  if Assigned(FOnUpdateData) then FOnUpdateData;
end;

{$IFDEF DELPHI4}
function TdxEditDataDefinition.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := False;
end;

function TdxEditDataDefinition.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := False;
end;
{$ENDIF}

{ TdxInplaceEdit }
constructor TdxInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoSize := True;
  FDataAlignment := DefaultAlignment;
  FStyle := CreateStyle;
  FDataDefinition := CreateDataDefinition;
  if FDataDefinition <> nil then
    with FDataDefinition do
    begin
      OnActiveChange := LayoutChanged;
      OnDataChange := DataChange;
      OnFocusControl := FocusControl;
      OnLayoutChanged := LayoutChanged;
      OnUpdateData := UpdateData;
    end;
  if IsInplace then
  begin
    ParentColor := False;
    ParentCtl3D := False;
    Ctl3D := False;
    TabStop := False;
  end
  else
  begin
    Width := 121;
    Height := 21;
    TabStop := True;
  end;
end;

destructor TdxInplaceEdit.Destroy;
begin
  if (FStyleController <> nil) and not (csDestroying in FStyleController.ComponentState) then
    FStyleController.RemoveLink(Self);
  if FDataDefinition <> nil then
  begin
    FDataDefinition.Free;
    FDataDefinition := nil;
  end;
  if FStyle <> nil then FStyle.Free;
  inherited Destroy;
end;

procedure TdxInplaceEdit.DefaultHandler(var Message);
begin
  if not IsEditClass then
    case TMessage(Message).Msg of
      // TODO: test + non Edit
      WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN:
        if not (csDesigning in ComponentState) and (GetFocus <> Handle){not Focused} then
          Windows.SetFocus(Handle);
    end;
//  if IsEditClass and (csDestroying in ComponentState) then Exit;   
  inherited;
end;

{$IFDEF DELPHI4}
function TdxInplaceEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or Assigned(DataDefinition) and
    DataDefinition.ExecuteAction(Action);
end;

function TdxInplaceEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or Assigned(DataDefinition) and
    DataDefinition.UpdateAction(Action);
end;
{$ENDIF}

procedure TdxInplaceEdit.ActivateEdit;
begin
end;

function TdxInplaceEdit.CanModify: Boolean;
begin
  Result := not ReadOnly;
  if Assigned(DataDefinition) then
    Result := Result and DataDefinition.CanModify;
end;

function TdxInplaceEdit.CheckWidth(AButtonWidth: Integer): Integer; // Inplace Mode
begin
  Result := Width;
  if Assigned(Container) and Container.CheckEditorWidth then
    if Result < (AButtonWidth + dxedMinWidth) then Result := AButtonWidth + dxedMinWidth;
end;

function TdxInplaceEdit.DefaultAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TdxInplaceEdit.DefaultReadOnly: Boolean;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.ReadOnly
  else
    Result := False;
end;

function TdxInplaceEdit.InternalReadOnly: Boolean;
begin
  if Assigned(DataDefinition) then
    Result := not DataDefinition.CanModify
  else
    Result := False;
end;

procedure TdxInplaceEdit.Deselect;
begin
end;

procedure TdxInplaceEdit.DoKillFocus(var Message: TWMKillFocus);
begin
  CheckHotTrack;
  if IsDrawFocused then InvalidateClientRect;
  if Assigned(Container) and (Message.FocusedWnd <> Container.Handle) then
    Container.RedrawSelection;
end;

function TdxInplaceEdit.GetEditingText: string;
begin
  Result := Text;
end;

procedure TdxInplaceEdit.Hide;
begin
  if IsInplace then
  begin
    FVisible := False;
    if HandleAllocated then
    begin
      if IsWindowVisible(Handle) then InvalidateEdit;
      SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or
        SWP_NOREDRAW);
    end;
  end
  else
    inherited Hide;
end;

procedure TdxInplaceEdit.InvalidateEdit; // Inplace Mode
var
  Cur: TRect;
begin
  if not Assigned(Container) then Exit;
  ValidateRect(Handle, nil);
  InvalidateRect(Handle, nil, True);
  Windows.GetWindowRect(Handle, Cur);
  MapWindowPoints(0, Container.Handle, Cur, 2);
  ValidateRect(Container.Handle, @Cur);
  InvalidateRect(Container.Handle, @Cur, False);
end;

function TdxInplaceEdit.IsEditClass: Boolean;
begin
  Result := False;
end;

function TdxInplaceEdit.IsEnterValidate: Boolean;
begin
  Result := False;
end;

function TdxInplaceEdit.IsFocused: Boolean;
begin
  Result := Self.Focused;
end;

function TdxInplaceEdit.IsNeededRedraw: Boolean;
begin
//  Result := not (svAlignment in StoredValues) and
//    Assigned(DataDefinition) and (DataDefinition.Alignment <> Alignment);

  // TODO: CHECK
  Result := Assigned(DataDefinition) or not Enabled;
end;

function TdxInplaceEdit.IsSelected: Boolean;
begin
  Result := FSelected or IsFocused and Enabled;
end;

function TdxInplaceEdit.IsQuickButtonClick: Boolean; // Inplace Mode
begin
  Result := Assigned(Container) and Container.IsShowButtonAlways;
end;

function TdxInplaceEdit.IsResetTextClass: Boolean;
begin
  Result := IsEditClass; // (Check, Blob, Graphic) 
end;

{$IFDEF DELPHI4}
function TdxInplaceEdit.IsSupportedAction: Boolean;
begin
  Result := IsEditClass;
end;
{$ENDIF}

function TdxInplaceEdit.IsVisible: Boolean; // Inplace Mode
begin
  if IsInplace then
    Result := FVisible
  else Result := Visible;
end;

procedure TdxInplaceEdit.LockActivate; // Inplace Mode
begin
  Inc(FLockActivate);
end;

procedure TdxInplaceEdit.MouseButtonClick(X, Y: Integer); // Inplace Mode
begin
end;

procedure TdxInplaceEdit.MouseClick; // Inplace Mode
begin
end;

procedure TdxInplaceEdit.Move(const Loc: TRect); // Inplace Mode
begin
  InternalMove(Loc, True);
end;

procedure TdxInplaceEdit.SelectAll;
begin
end;

procedure TdxInplaceEdit.SetEditingText(Value: string);
begin
  if EditCanModify then Text := Value;
  Modified := True;
end;

procedure TdxInplaceEdit.Show;
begin
  if IsInplace then
  begin
//    Windows.ShowWindow(Handle, SW_SHOWNORMAL);
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or SWP_NOMOVE or
      SWP_NOSIZE or SWP_SHOWWINDOW);
    FVisible := True;
  end
  else
    inherited Show;
end;

procedure TdxInplaceEdit.UnLockActivate; // Inplace Mode
begin
  Dec(FLockActivate);
end;

procedure TdxInplaceEdit.ValidateEdit;
var
  Accept: Boolean;
  ErrorText: string;
begin
  if Modified and (FLockValidate = 0) then
  begin
    Accept := True;
    ErrorText := LoadStr(dxSValidateEditErrorText); // TODO res
    if Assigned(FOnValidate) then
      FOnValidate(Self, ErrorText, Accept);
    if not Accept then
    begin
      MessageBeep(0);
      if IsWindowVisible(Handle) then Windows.SetFocus(Handle);
      raise EdxEditInvalidInput.Create(ErrorText);
    end;
  end;
end;

class procedure TdxInplaceEdit.CalcBoundsInfo(AViewData: TdxEditViewData;
  var ViewInfo: TdxEditViewInfo);
var
  B: Integer;
begin
  FillChar(ViewInfo, SizeOf(ViewInfo), 0);
  with ViewInfo, AViewData do
  begin
    B := dxEditBorderSize; // TODO Param
    if Shadow then ShadowSize := dxEditShadowSize;
    // Bounds
    Bounds := ViewBounds;
    with Bounds do
    begin
      // Client Rect
      ClientBounds := Rect(Left + B, Top + B, Right - B - ShadowSize,
        Bottom  - B - ShadowSize);
    end;
    // Border
    case BorderStyle of
      xbsSingle: BorderSize := 1;
      xbsFlat, xbs3D: BorderSize := B;
      xbsThick: BorderSize := B;
    end;
  end;
end;

// new class methods
class procedure TdxInplaceEdit.CalcViewInfo(AViewData: TdxEditViewData;
  AutoSize: Boolean; var ViewInfo: TdxEditViewInfo);
var
  B, H: Integer;
  R: TRect;
begin
  CalcBoundsInfo(AViewData, ViewInfo);
  with ViewInfo, AViewData do
  begin
    if AutoSize then
      with Bounds do
      begin
        B := dxEditBorderSize; // TODO Param
        R := GetMinRect(AViewData);
        if not IsRectEmpty(R) then
        begin
          H := R.Right - R.Left;
          Right := Left + H + B * 2 + ShadowSize;
          // Client Rect
          ClientBounds.Right := Left + B + H;
          H := R.Bottom - R.Top;
        end
        else
          H := GetMinHeight(AViewData);
        Bottom := Top + H + B * 2 + ShadowSize;
        // Client Rect
        ClientBounds.Bottom := Top + B + H;
      end;
    // Flag Edges
    FlagLeft := edgLeft in Edges;
    FlagTop := edgTop in Edges;
    FlagRight := edgRight in Edges;
    FlagBottom := edgBottom in Edges;
    // BorderRect
    BorderRect := ClientBounds;
    // Edges - correct Border Rect
    InflateBorderRect(BorderRect, ViewInfo, True);
    // ShadowRect
    if ShadowSize > 0 then
    begin
      ShadowRect := BorderRect;
      OffsetRect(ShadowRect, ShadowSize, ShadowSize);
    end;
  end;
end;

class procedure TdxInplaceEdit.Draw(ADC: HDC; const ARect: TRect; AViewData: TdxEditViewData; ARgn: HRGN);
var
  ViewInfo: TdxEditViewInfo;
  Rgn: HRGN;
begin
  CalcViewInfo(AViewData, False, ViewInfo);
  DrawBorder(ADC, ViewInfo, AViewData);
  DrawClientArea(ADC, ViewInfo.ClientBounds, AViewData, False);
  if ARgn <> 0 then
  begin
    Rgn := GetEditRgn(ViewInfo);
    if Rgn = 0 then
      Rgn := CreateRectRgnIndirect(ViewInfo.BorderRect);
    CombineRgn(ARgn, ARgn, Rgn, RGN_DIFF);
    DeleteObject(Rgn);
  end;
end;

class procedure TdxInplaceEdit.DrawBorder(ADC: HDC; var ViewInfo: TdxEditViewInfo; AViewData: TdxEditViewData);
var
  FrameBrush: HBRUSH;
  R: TRect;
  I, FlagEdges: Integer;
begin
  with ViewInfo, AViewData do
  begin
    // Frame
    if BorderStyle <> xbsNone then
    begin
      FlagEdges := 0;
      if FlagLeft then FlagEdges := FlagEdges or BF_LEFT;
      if FlagTop then FlagEdges := FlagEdges or BF_TOP;
      if FlagRight then FlagEdges := FlagEdges or BF_RIGHT;
      if FlagBottom then FlagEdges := FlagEdges or BF_BOTTOM;
      R := BorderRect;
      case BorderStyle of
        xbsSingle, xbsThick:
          begin
            FrameBrush := CreateSolidBrush(ColorToRGB(BorderColor));
            if FlagLeft and FlagTop and FlagRight and FlagBottom then
              for I := 0 to BorderSize - 1 do
              begin
                FrameRect(ADC, R, FrameBrush);
                InflateRect(R, -1, -1);
              end
            else
              with R do
              begin
                if FlagLeft then
                  FillRect(ADC, Rect(Left, Top - BorderSize * Byte(not FlagTop),
                    Left + BorderSize, Bottom), FrameBrush);
                if FlagTop then
                  FillRect(ADC, Rect(Left, Top, Right, Top + BorderSize), FrameBrush);
                if FlagRight then
                  FillRect(ADC, Rect(Right - BorderSize, Top - BorderSize * Byte(not FlagTop),
                    Right, Bottom), FrameBrush);
                if FlagBottom then
                  FillRect(ADC, Rect(Left, Bottom - BorderSize, Right, Bottom), FrameBrush);
              end;
            DeleteObject(FrameBrush);
          end;
        xbsFlat:
          begin
            R := BorderRect;
            DrawEdge(ADC, R, BDR_SUNKENOUTER, FlagEdges or BF_ADJUST);
            DrawEdge(ADC, R, BDR_SUNKENINNER, FlagEdges or BF_FLAT);
          end;
        xbs3D: DrawEdge(ADC, R, BDR_SUNKENINNER or BDR_SUNKENOUTER, FlagEdges);
      end;
    end;
    // Shadow
    if Shadow then
      DrawShadow(ADC, ShadowRect, ShadowSize, ShadowBrush);
  end;
end;

class function TdxInplaceEdit.DrawClientArea(ADC: HDC; var ARect: TRect;
  AViewData: TdxEditViewData; IsControl: Boolean): Boolean;
begin
  if not AViewData.CalcHeight then
    FillRect(ADC, ARect, AViewData.Brush);
  Result := True;
end;

class function TdxInplaceEdit.GetEditCursor(X, Y: Integer; AViewData: TdxEditViewData): TCursor;
begin
  if AViewData.Cursor <> crDefault then
    Result := AViewData.Cursor
  else
    if not AViewData.IsEditClass then
      Result := crArrow
    else Result := crDefault;
end;

class function TdxInplaceEdit.GetEditRgn(const ViewInfo: TdxEditViewInfo): HRGN;
var
  TempRgn: HRGN;
begin
  with ViewInfo do
    if (ShadowSize > 0) or (BorderSize < dxEditBorderSize) or
      not (FlagLeft and FlagTop and FlagRight and FlagBottom) then
    begin
      Result := CreateRectRgnIndirect(BorderRect);
      TempRgn := CreateRectRgnIndirect(ShadowRect);
      CombineRgn(Result, Result, TempRgn, RGN_OR);
      DeleteObject(TempRgn);
    end
    else
      Result := 0;
end;

class function TdxInplaceEdit.GetMinHeight(AViewData: TdxEditViewData): Integer;
var
  DC: HDC;
  SaveFont: HFONT;
  Metrics: TTextMetric;
begin
  if IsInplace then Result := 3
  else Result := (GetSystemMetrics(SM_CYBORDER) + 1) * 2; {4}
  DC := GetDC(0);
  SaveFont := SelectObject(DC, AViewData.Font);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Inc(Result, Metrics.tmHeight);
end;

class function TdxInplaceEdit.GetMinRect(AViewData: TdxEditViewData): TRect;
begin
  SetRectEmpty(Result);
end;

class function TdxInplaceEdit.IsInplace: Boolean;
begin
  Result := True;
end;

// protected TdxInplaceEdit
procedure TdxInplaceEdit.DblClick;
begin
  if IsInplace then
    Container.DblClick
  else inherited DblClick;
end;

procedure TdxInplaceEdit.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Height', ReadHeight, WriteHeight, not AutoSize);
  Filer.DefineProperty('StoredValues', ReadStoredValues, WriteStoredValues, StoredValues <> []);
end;

procedure TdxInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SendToParent;
  begin
    Container.KeyDown(Key, Shift);
    Key := 0;
  end;

begin
  if Key = VK_ESCAPE then Reset; // TODO Option
  if IsInplace then
  begin
    // Validate Editor
    if (Key in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_TAB, VK_RETURN, VK_ESCAPE,
      VK_INSERT]) {CloseEditor} then ValidateEdit;
    DisableValidate;
    try
      // Send to Container
      case Key of
        VK_ESCAPE, VK_RETURN: SendToParent;
        VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT : SendToParent;
        VK_INSERT:
          if Shift = [] then SendToParent
          else if (Shift = [ssShift]) and not Container.CanEditModify then Key := 0;
        VK_F2:
          begin
            ParentKeyDown(Key, Shift);
            if Key = VK_F2 then
            begin
              Deselect;
              Exit;
            end;
          end;
        VK_TAB: if not (ssAlt in Shift) then
          SendToParent;
      end;
      if (Key = VK_DELETE) and not Container.CanEditModify then Key := 0;
      if Key <> 0 then
      begin
        ParentKeyDown(Key, Shift);
        if KeyEditModify(Key, Shift) then
        begin
          if not CanModify or not EditCanModify then
            Key := 0;
        end;
        inherited KeyDown(Key, Shift);
      end;
    finally
      EnableValidate;
    end;
  end
  else
  begin
    if KeyEditModify(Key, Shift) then
    begin
      if not CanModify or not EditCanModify then
        Key := 0;
    end;
    if (Key = VK_RETURN) and IsEnterValidate then
      ValidateEdit;
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TdxInplaceEdit.KeyPress(var Key: Char);
begin
  if Assigned(Container) then Container.KeyPress(Key);
  if (Key in [#32..#255]) and not CanEditAcceptKey(Key) then
  begin
    Key := #0;
    MessageBeep(0);
  end;
  if IsInplace and (Key = #9) and not IsWantTab then
    Key := #0;
  case Key of
    {#9,} #27: Key := #0;
    {^H, ^V, ^X, }#9, #32..#255:
      if IsEditClass and not EditCanModify then
        Key := #0;
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TdxInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if IsInplace then
    Container.KeyUp(Key, Shift)
  else inherited KeyUp(Key, Shift);
end;

procedure TdxInplaceEdit.Loaded;
begin
  inherited Loaded;
  if Assigned(DataDefinition) then
    LayoutChanged;
end;

procedure TdxInplaceEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if StyleController = AComponent then
      StyleController := nil;
end;

procedure TdxInplaceEdit.PaintWindow(DC: HDC);
var
  FViewData: TdxEditViewData;
  ARect: TRect;
begin
  FViewData := CreateViewData(False);
  try
    ARect := ClientRect;
    if ARect.Right - ARect.Left > 0 then
      DrawClientArea(DC, ARect, FViewData, True);
  finally
    FViewData.Free;
  end;
  inherited PaintWindow(DC);
end;

procedure TdxInplaceEdit.ParentKeyDown(var Key: Word; Shift: TShiftState);
begin
  if IsInplace then
    Container.InplaceEditKeyDown(Key, Shift);
end;

procedure TdxInplaceEdit.WndProc(var Message: TMessage);
begin
  if IsInplace then
    case Message.Msg of
      WM_SETFOCUS:
        begin
          if (GetParentForm(Self) = nil) or (GetParentForm(Self).SetFocusedControl(Container) or
            (csFocusing in Container.ControlState)) then
            Dispatch(Message);
          Container.RedrawSelection;
          DoSetFocus;
          Exit;
        end;
      WM_KILLFOCUS:
        begin
          DoKillFocus(TWMKillFocus(Message));
        end;
      WM_LBUTTONDOWN:
        if Container.IsImmediateEditor then
        begin
          if UINT(GetMessageTime - FClickTime) < GetDoubleClickTime then
            Message.Msg := WM_LBUTTONDBLCLK;
          FClickTime := 0;
        end;
      WM_MOUSEWHEEL:
        if not IsWantMouseWheel then
        begin
          SendMessage(Container.Handle, CM_CANCELMODE, 0, 0);
          SendMessage(Container.Handle, WM_MOUSEWHEEL, Message.WParam, Message.LParam);
        end;
      WM_KEYDOWN, WM_SYSKEYDOWN, WM_CHAR:
        if Container.IsEditorMoved then Exit;
    end
  else
    begin
      case Message.Msg of
        WM_SETFOCUS: DoSetFocus;
        WM_KILLFOCUS: DoKillFocus(TWMKillFocus(Message));
      end;
    end;
  inherited WndProc(Message);
end;

procedure TdxInplaceEdit.AssignEditValue(const Value: Variant);
begin
  if VarIsNull(Value) then Text := ''
  else Text := Value;
end;

procedure TdxInplaceEdit.AssignEditProperties;
var
  PrevDataAlignment: TAlignment;
begin
  if not (svAlignment in StoredValues) then
  begin
    PrevDataAlignment := FDataAlignment;
    FDataAlignment := DataDefinition.Alignment;
    if FDataAlignment <> PrevDataAlignment then
      InvalidateClientRect;
  end;
  if not (svReadOnly in StoredValues) then
    SetEditReadOnly(InternalReadOnly);
end;

procedure TdxInplaceEdit.MoveCol(ALeft: Boolean);
begin
  if Assigned(Container) then Container.MoveCol(ALeft); 
end;

procedure TdxInplaceEdit.ResetEditValue;
begin
  if Modified and IsResetTextClass then
  begin
    Text := FPrevTextValue;
    Modified := FPrevModified;
  end;
end;

procedure TdxInplaceEdit.LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean);
var
  Value: Variant;
begin
  if Assigned(DataDefinition) and IsPaintCopy then
  begin
    Value := DataDefinition.GetDisplayValue;
    if VarIsNull(Value) then Data := ''
    else Data := Value;
  end
  else
    Data := Self.Text;
end;

procedure TdxInplaceEdit.PostValue;
begin
  if Assigned(DataDefinition) then
    DataDefinition.UpdateRecord;
end;

function TdxInplaceEdit.ReturnEditValue: Variant;
begin
  Result := Text;
end;

procedure TdxInplaceEdit.DataChange;
begin
  AssignEditValue(FDataDefinition.GetEditValue);
  Modified := False;
//  InvalidateClientRect;
end;

procedure TdxInplaceEdit.FocusControl(var Done: Boolean);
begin
  if CanFocus then 
  begin 
    SetFocus; 
    Done := True;
  end;
end;

procedure TdxInplaceEdit.LayoutChanged;
begin
  AssignEditProperties;
  DataChange;  
end;

procedure TdxInplaceEdit.UpdateData;
begin
  ValidateEdit;
  FDataDefinition.SetEditValue(ReturnEditValue);
end;

procedure TdxInplaceEdit.BoundsChanged;
begin
end;

function TdxInplaceEdit.CanEditAcceptKey(Key: Char): Boolean;
begin
  if Assigned(Container) then
    Result := Container.CanEditAcceptKey(Key)
  else
  if Assigned(DataDefinition) then
    Result := DataDefinition.IsValidChar(Key)
  else Result := True;
end;

procedure TdxInplaceEdit.Change;
begin
  inherited Changed;
//  if Assigned(DataDefinition) then DataDefinition.Modified;
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TdxInplaceEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := nil;
end;

function TdxInplaceEdit.CreateStyle: TdxEditStyle;
begin
  if IsInplace and Assigned(Container) then
    Result := Container.CreateEditStyle(Self)
  else Result := GetEditStyleClass.Create(Self);
end;

function TdxInplaceEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := GetViewDataClass.Create;
  with Result do
  begin
    Enabled := Self.Enabled;
    Focused := IsFocused;
    Selected := IsSelected;
    // Style
    BorderColor := Style.BorderColor;
    BorderStyle := Style.BorderStyle;
    if Selected and Style.HotTrack then
    begin
      case BorderStyle of
        xbsNone: BorderStyle := xbsFlat;
        xbsSingle: BorderStyle := xbsThick;
        xbsFlat: BorderStyle := xbs3D;
      end;
    end;
    ButtonStyle := Style.ButtonStyle;
    if ButtonStyle = btsDefault then
      case BorderStyle of
        xbsNone: ButtonStyle := btsSimple;
        xbsSingle: ButtonStyle := btsHotFlat;
        xbsThick, xbs3D: ButtonStyle := bts3D;
        xbsFlat: ButtonStyle := btsFlat; 
      end;
    ButtonTransparence := (Style.ButtonTransparence = ebtAlways) or
      ((Style.ButtonTransparence = ebtInactive) and not Selected);
    Edges := Style.Edges;
    Shadow := Style.Shadow;
    Transparent := not Focused and Self.Transparent;
    // ViewBounds
    ViewBounds := Rect(0, 0, Width, Height);
    OffsetSize := Self.OffsetSize;
    // General
    DrawAlignment := daSingleLine;
    Font := Self.Font.Handle;
    if Enabled then
    begin
      Brush := Self.Brush.Handle;
      BkColor := ColorToRGB(Self.Color);
      TextColor := ColorToRGB(Self.Font.Color);
    end
    else
    begin
      Brush := GetSysColorBrush(COLOR_BTNFACE);
      BkColor := GetSysColor(COLOR_BTNFACE);
      TextColor := GetSysColor(COLOR_BTNSHADOW);
    end;
    if not (svAlignment in FStoredValues) and Assigned(DataDefinition) then
      Alignment := DataDefinition.Alignment
    else Alignment := Self.Alignment;
    IsEditClass := Self.IsEditClass;
    DataLength := 0;
    LoadDisplayValue(Data, IsPaintCopy);
    Cursor := Self.Cursor;
  end;
end;

procedure TdxInplaceEdit.DoSetFocus;
begin
  CheckHotTrack;
  if IsDrawFocused then InvalidateClientRect;
end;

function TdxInplaceEdit.EditCanModify: Boolean;
begin
  if ReadOnly then
    Result := False
  else
    if Assigned(Container) then
      Result := Container.CanEditModify
    else
    if Assigned(DataDefinition) then
      Result := DataDefinition.CanEditModify
    else Result := True;
end;

function TdxInplaceEdit.GetDisableCloseEditor: Boolean;
begin
  Result := FDisableCloseEditor;
end;

class function TdxInplaceEdit.GetEditStyleClass: TdxEditStyleClass;
begin
  Result := TdxEditStyle;
end;

function TdxInplaceEdit.GetModified: Boolean;
begin
  Result := FModified;
end;

class function TdxInplaceEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxEditViewData;
end;

procedure TdxInplaceEdit.InvalidateClientRect;
begin
  if HandleAllocated then
    InvalidateRect(Handle, nil, False);
end;

function TdxInplaceEdit.KeyEditModify(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := ((ssCtrl in Shift) and (Char(Key) in ['V', 'X'])) or (Key = VK_BACK) or
    (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift));
end;

class procedure TdxInplaceEdit.InflateBorderRect(var ABorderRect: TRect;
  const AViewInfo: TdxEditViewInfo; IsIncrement: Boolean);
var
  BS: Integer;
begin
  with AViewInfo do
    if BorderSize > 0 then
      with ABorderRect do
      begin
        if IsIncrement then BS := BorderSize
        else BS := - BorderSize;
        if FlagLeft then Dec(Left, BS);
        if FlagTop then Dec(Top, BS);
        if FlagRight then Inc(Right, BS);
        if FlagBottom then Inc(Bottom, BS);
      end;
end;

function TdxInplaceEdit.IsControlPressed: Boolean;
begin
  Result := (GetAsyncKeyState(VK_CONTROL) < 0) and
    (GetAsyncKeyState(VK_MENU) >= 0);
end;

function TdxInplaceEdit.IsDrawFocused: Boolean;
begin
  Result := not IsEditClass;
end;

function TdxInplaceEdit.IsWantMouseWheel: Boolean;
begin
  Result := False;
end;

function TdxInplaceEdit.IsWantTab: Boolean;
begin
  Result := False;
end;

procedure TdxInplaceEdit.Reset;
begin
  if Assigned(DataDefinition) then
  begin
    DataDefinition.Reset;
    SelectAll;
  end
  else
    ResetEditValue;
end;

procedure TdxInplaceEdit.RestoreDefaults;
var
  PrevAlignment: TAlignment;
begin
  FStoredValues := [];
  // Alignment
  PrevAlignment := Alignment;
  SetEditAlignment(DefaultAlignment);
  if (PrevAlignment = Alignment) and Assigned(DataDefinition) then
  begin
    FDataAlignment := DataDefinition.Alignment;
    if FDataAlignment <> PrevAlignment then
      InvalidateClientRect;
  end;
  // ReadOnly
  SetEditReadOnly(InternalReadOnly);
end;

procedure TdxInplaceEdit.SetModified(Value: Boolean);
begin
  FModified := Value;
end;

procedure TdxInplaceEdit.SetSelected(Value: Boolean);
begin
  FSelected := Value;
end;

procedure TdxInplaceEdit.StyleChanged;
begin
  AdjustHeight;
  InvalidateClientRect;
end;

// TODO NEW 
procedure TdxInplaceEdit.DisableValidate;
begin
  if IsInplace then Inc(FLockValidate);
end;

procedure TdxInplaceEdit.EnableValidate;
begin
  if IsInplace then Dec(FLockValidate);
end;

// private TdxInplaceEdit
procedure TdxInplaceEdit.AdjustHeight;
var
  FViewData: TdxEditViewData;
  ViewInfo: TdxEditViewInfo;
  Rgn: HRGN;
begin
  if not HandleAllocated then Exit;
  FViewData := CreateViewData(False);
  try
    CalcViewInfo(FViewData, AutoSize, ViewInfo);
    with ViewInfo do
    begin
      SetBounds(Left, Top, Bounds.Right - Bounds.Left, Bounds.Bottom - Bounds.Top);
      Rgn := GetEditRgn(ViewInfo);
      SetWindowRgn(Handle, Rgn, True);
    end;
  finally
    FViewData.Free;
  end;
end;

procedure TdxInplaceEdit.CheckHotTrack;
begin
  if not (csDestroying in ComponentState) then
    with Style do
      if HotTrack or (ButtonTransparence in [ebtInactive, ebtAlways, ebtHideInactive]) then AdjustHeight;
end;

function TdxInplaceEdit.GetAutoSize: Boolean;
begin
  Result := FAutoSize and not IsInplace; 
end;

function TdxInplaceEdit.GetContainer: TCustomdxContainer;
begin
  if IsInplace then
    Result := TCustomdxContainer(Owner)
  else Result := nil;
end;

function TdxInplaceEdit.GetEditorColor: TColor;
begin
  if Assigned(Container) then
    Result := Container.GetEditColor
  else Result := Self.Color;
end;

function TdxInplaceEdit.GetReadOnly: Boolean;
begin
  if svReadOnly in StoredValues then
    Result := FReadOnly
  else
    Result := DefaultReadOnly;
end;

procedure TdxInplaceEdit.InternalMove(const Loc: TRect; Redraw: Boolean);
var
  R: TRect;
  PrevState: Boolean;
begin
  if not IsInplace then Exit;
  if IsRectEmpty(Loc) then
  else
  begin
    R := Loc;
    InflateRect(R, dxEditBorderSize, dxEditBorderSize);
    with R do
      SetBounds(Left, Top, Right - Left, Bottom - Top);
    PrevState := FVisible;
    Show;
    if GetFocus <> Handle then
      Windows.SetFocus(Handle);
    SelectAll;
    if not PrevState and (FLockActivate = 0) then
      ActivateEdit;
  end;
end;

function TdxInplaceEdit.IsAlignmentStored: Boolean;
begin
  Result := svAlignment in StoredValues;
end;

function TdxInplaceEdit.IsReadOnlyStored: Boolean;
begin
  Result := svReadOnly in StoredValues;
end;

procedure TdxInplaceEdit.ReadHeight(Reader: TReader);
begin
  Height := Reader.ReadInteger;
end;

procedure TdxInplaceEdit.ReadStoredValues(Reader: TReader);
var
  B: Byte;
begin
  B := Reader.ReadInteger;
  PByte(@FStoredValues)^ := B;
end;

procedure TdxInplaceEdit.SetAlignment(Value: TAlignment);
begin
  Include(FStoredValues, svAlignment);
  SetEditAlignment(Value);
end;

procedure TdxInplaceEdit.SetDataDefinition(Value: TdxEditDataDefinition);
begin
  if Assigned(FDataDefinition) then
    FDataDefinition.Assign(Value);
end;

procedure TdxInplaceEdit.SetEditAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    StyleChanged;
  end;
end;

procedure TdxInplaceEdit.SetOffsetSize(Value: TRect);
begin
  if not EqualRect(FOffsetSize, Value) then
  begin
    FOffsetSize := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceEdit.SetReadOnly(Value: Boolean);
begin
  Include(FStoredValues, svReadOnly);
  SetEditReadOnly(Value);
end;

procedure TdxInplaceEdit.SetActive(Value: Boolean);

  procedure ResetData;
  var
    APrevModified: Boolean;
  begin
    APrevModified := Modified;
    try
      DataDefinition.Reset;
    finally
      Modified := APrevModified;
    end;
  end;

begin
  if IsInplace or (FActive <> Value) then
  begin
    FPrevModified := Modified;
    FPrevTextValue := Text;
  end;
  if not IsInplace and (FActive <> Value) then
  begin
    FActive := Value;
    if IsNeededRedraw then InvalidateClientRect;
    if not FActive and Assigned(DataDefinition) then
      ResetData;
  end;
end;

procedure TdxInplaceEdit.SetEditAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceEdit.SetEditReadOnly(Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TdxInplaceEdit.SetStyle(Value: TdxEditStyle);
begin
  if Assigned(FStyle) then FStyle.Assign(Value);
end;

procedure TdxInplaceEdit.SetStyleController(Value: TdxEditStyleController);
begin
  if FStyleController <> Value then
  begin
    if (FStyleController <> nil) and not (csDestroying in FStyleController.ComponentState) then
      FStyleController.RemoveLink(Self);
    FStyleController := Value;
    if Value <> nil then
    begin
      Value.AddLink(Self);
      Value.FreeNotification(Self);
      Value.StyleChanged(Self);
    end
    else
      StyleChanged;
  end;
end;

procedure TdxInplaceEdit.SetTransparent(Value: Boolean);
begin
end;

procedure TdxInplaceEdit.WriteHeight(Writer: TWriter);
begin
  Writer.WriteInteger(Height);
end;

procedure TdxInplaceEdit.WriteStoredValues(Writer: TWriter);
begin
  Writer.WriteInteger(PByte(@StoredValues)^);
end;

procedure TdxInplaceEdit.WMClear(var Message);
begin
  if not EditCanModify then Exit;
  inherited;
end;

procedure TdxInplaceEdit.WMCut(var Message);
begin
  if not EditCanModify then Exit;
  inherited;
end;

procedure TdxInplaceEdit.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if IsEditClass then
  begin
    if Enabled then
      inherited
    else
      Message.Result := 1; // Self Drawing
  end
  else
    Message.Result := 1;
end;

procedure TdxInplaceEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTCHARS;
  if IsInplace then
    Message.Result := Message.Result or DLGC_WANTALLKEYS; // NEW!
  if Assigned(Container) and Container.IsTabs then
    Message.Result := Message.Result or DLGC_WANTTAB
  else
    Message.Result := Message.Result and not DLGC_WANTTAB;
end;

procedure TdxInplaceEdit.WMKeyDown(var Message: TWMKeyDown);
begin
  if IsInplace then
  begin
    if Message.CharCode in [VK_RETURN] then KillMessage(Handle, WM_CHAR);
    if (Message.CharCode = VK_TAB) and not IsWantTab then
      KillMessage(Handle, WM_CHAR);
  end;
  inherited;
end;

procedure TdxInplaceEdit.WMImeComposition(var Message: TMessage);
begin
  if (Message.lParam and GCS_RESULTSTR) <> 0 then
    if IsEditClass and not EditCanModify then
      Exit;
  inherited;
end;

procedure TdxInplaceEdit.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
// TODO  
//  if not (csDesigning in ComponentState) and (GetFocus <> Handle){not Focused} then
//    Windows.SetFocus(Handle);
end;

procedure TdxInplaceEdit.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  FViewData: TdxEditViewData;
  ViewInfo: TdxEditViewInfo;
begin
  inherited;
  FViewData := CreateViewData(False);
  try
    CalcViewInfo(FViewData, False, ViewInfo);
    with ViewInfo, Message.CalcSize_Params^.rgrc[0] do
    begin
      Inc(Left, ClientBounds.Left - Bounds.Left);
      Inc(Top, ClientBounds.Top - Bounds.Top);
      Dec(Right, Bounds.Right - ClientBounds.Right);
      Dec(Bottom, Bounds.Bottom - ClientBounds.Bottom);
      if Right <= Left then Right := Left;
    end;
  finally
    FViewData.Free;
  end;
end;

procedure TdxInplaceEdit.WMNCPaint(var Message: TWMNCPaint);
var
  FViewData: TdxEditViewData;
  ViewInfo: TdxEditViewInfo;
  DC: HDC;
begin
  inherited;
  FViewData := CreateViewData(False);
  try
    CalcViewInfo(FViewData, False, ViewInfo);
    DC := GetWindowDC(Handle);
    DrawBorder(DC, ViewInfo, FViewData);
    // ScollBars
    with ViewInfo do
      if (GetWindowLong(Handle, GWL_STYLE) and (WS_HSCROLL or WS_VSCROLL)) =
        (WS_HSCROLL or WS_VSCROLL) then
      begin
        InflateRect(BorderRect, -BorderSize, -BorderSize);
        with BorderRect do
          BorderRect := Rect(Right - GetSystemMetrics(SM_CXVSCROLL), Bottom - GetSystemMetrics(SM_CYHSCROLL), Right, Bottom);
        FillRect(DC, BorderRect, GetSysColorBrush(COLOR_BTNFACE));
      end;
    ReleaseDC(Handle, DC);
  finally
    FViewData.Free;
  end;
end;

procedure TdxInplaceEdit.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
  PS: TPaintStruct;
  R: TRect;
  ViewData: TdxEditViewData;
begin
  if (csPaintCopy in ControlState) or (not FActive and IsNeededRedraw) or
    (IsEditClass and (csDesigning in ComponentState)) then
  begin
    ViewData := CreateViewData({csPaintCopy in ControlState}True); // TODO: CHECK
    try
      DC := Message.DC;
      if DC = 0 then DC := BeginPaint(Handle, PS);
      try
        if csPaintCopy in ControlState then
          Draw(DC, ViewData.ViewBounds, ViewData, 0)
        else
        begin
          R := ClientRect;
          DrawClientArea(DC, R, ViewData, False);
        end;
      finally
        if Message.DC = 0 then EndPaint(Handle, PS);
      end;
    finally
      ViewData.Free;
    end;
  end
  else
  begin
    // only for RE
    if IsEditClass and (Message.DC = 0) then
    begin
      DC := GetDC(Handle);
      Message.DC := DC;
    end
    else
      DC := 0;
    PaintHandler(Message);
    if DC <> 0 then
      ReleaseDC(Handle, DC);
  end;
end;

procedure TdxInplaceEdit.WMPaste(var Message);
begin
  if not EditCanModify then Exit;
  inherited
end;

procedure TdxInplaceEdit.WMSetCursor(var Message: TWMSetCursor);
var
  Cursor: TCursor;
  P: TPoint;
  AViewData: TdxEditViewData;
begin
  with Message do
    if CursorWnd = Handle then
      case Smallint(HitTest) of
        HTCLIENT:
          begin
            GetCursorPos(P);
            AViewData := CreateViewData(False);
            try
              Cursor := GetEditCursor(P.X, P.Y, AViewData);
            finally
              AViewData.Free;
            end;
            if Cursor <> crDefault then
            begin
              Windows.SetCursor(Screen.Cursors[Cursor]);
              Result := 1;
              Exit;
            end;
          end;
      end;
  inherited;
end;

procedure TdxInplaceEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  AdjustHeight;
end;

procedure TdxInplaceEdit.CMColorChanged(var Message: TMessage);
begin
  inherited;
  StyleChanged;
end;

procedure TdxInplaceEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  //AdjustHeight;
  StyleChanged;
end;

procedure TdxInplaceEdit.CMEnter(var Message: TCMEnter);
begin
  SetActive(True);
  inherited;
end;

procedure TdxInplaceEdit.CMExit(var Message: TCMExit);
begin
  if not Assigned(DataDefinition) then
  begin
    ValidateEdit;
  end
  else
  begin
    try
      DataDefinition.UpdateRecord;
    except
      SelectAll;
      SetFocus;
      raise;
    end;
  end;
  SetActive(False);
  inherited;
end;

procedure TdxInplaceEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustHeight;
end;

procedure TdxInplaceEdit.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  SetSelected(True);
  CheckHotTrack;
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TdxInplaceEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  SetSelected(False);
  CheckHotTrack;
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TdxInplaceEdit.CMShowingChanged(var Message: TMessage);
begin
  if not IsInplace then inherited;
end;

procedure TdxInplaceEdit.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if not IsEditClass then
    InvalidateClientRect; 
end;

{ TCustomdxContainer }
procedure TCustomdxContainer.CreateWnd;
{$IFDEF DELPHI4}
const
  Styles: array[TScrollBarStyle] of Integer = (FSB_REGULAR_MODE,
    FSB_ENCARTA_MODE, FSB_FLAT_MODE);
{$ENDIF}
begin
  inherited CreateWnd;
  {$IFDEF DELPHI4}
  if not SysLocale.MiddleEast then
    InitializeFlatSB(Handle);
  FlatSB_SetScrollProp(Handle, WSB_PROP_HSTYLE, Styles[ScrollBarStyle], True);
  FlatSB_SetScrollProp(Handle, WSB_PROP_VSTYLE, Styles[ScrollBarStyle], True);
  {$ENDIF}
end;

function TCustomdxContainer.CanEditModify: Boolean;
begin
  Result := False;
end;

function TCustomdxContainer.CanEditAcceptKey(Key: Char): Boolean;
begin
  Result := False;
end;

function TCustomdxContainer.CheckEditorWidth: Boolean;
begin
  Result := True;
end;

function TCustomdxContainer.CreateEditStyle(AEdit: TdxInplaceEdit): TdxEditStyle;
begin
  Result := TdxEditStyle.Create(AEdit);
end;

function TCustomdxContainer.GetDefaultPopupBorderStyle(AEditBorderStyle: TdxEditBorderStyle): TdxPopupBorderStyle;
begin
  Result := pbFrame3D;
end;

function TCustomdxContainer.GetEditColor: TColor;
begin
  Result := Self.Color;
end;

function TCustomdxContainer.GetEditFont: TFont;
begin
  Result := Self.Font;
end;

function TCustomdxContainer.GetReadOnly: Boolean;
begin
  Result := False;
end;

function TCustomdxContainer.HideDrawFocusRect: Boolean;
begin
  Result := False;
end;

procedure TCustomdxContainer.InplaceEditKeyDown(var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);
end;

function TCustomdxContainer.IsEditorMoved: Boolean;
begin
  Result := False;
end;

function TCustomdxContainer.IsImmediateEditor: Boolean;
begin
  Result := False;
end;

function TCustomdxContainer.IsShowButtonAlways: Boolean;
begin
  Result := False;
end;

function TCustomdxContainer.IsTabs: Boolean;
begin
  Result := False;
end;

procedure TCustomdxContainer.MoveCol(ALeft: Boolean);
begin
end;

procedure TCustomdxContainer.RedrawSelection;
begin
end;

procedure TCustomdxContainer.BeginInitEdit;
begin
  FInitEdit := True;
end;

procedure TCustomdxContainer.EndInitEdit;
begin
  FInitEdit := False;
end;

function TCustomdxContainer.GetScrollInfo(BarFlag: Integer; var ScrollInfo: TScrollInfo): BOOL;
begin
  {$IFDEF DELPHI4}
  Result := FlatSB_GetScrollInfo(Handle, BarFlag, ScrollInfo);
  {$ELSE}
  Result := Windows.GetScrollInfo(Handle, BarFlag, ScrollInfo);
  {$ENDIF}
end;

function TCustomdxContainer.SetScrollInfo(BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer;
begin
  {$IFDEF DELPHI4}
  Result := FlatSB_SetScrollInfo(Handle, BarFlag, ScrollInfo, Redraw);
  {$ELSE}
  Result := Windows.SetScrollInfo(Handle, BarFlag, ScrollInfo, Redraw);
  {$ENDIF}
end;

{$IFDEF DELPHI4}
procedure TCustomdxContainer.AdjustSize;
begin
end;

procedure TCustomdxContainer.SetScrollBarStyle(const Value: TScrollBarStyle);
begin
  if Value <> FScrollBarStyle then
  begin
    FScrollBarStyle := Value;
    RecreateWnd;
  end;
end;
{$ENDIF}

procedure TCustomdxContainer.WMMouseWHeel(var Message: TWMMouse);
begin
  inherited;
  DoMouseWHeelScroll(SmallInt(HIWORD(Message.Keys)) > 0,
    {$IFDEF DELPHI4}Mouse.WheelScrollLines{$ELSE}3{$ENDIF});
end;

procedure TCustomdxContainer.DoMouseWHeelScroll(AScrollUp: Boolean; AScrollLines: Integer);
var
  I, AScrollCode: Integer;
begin
  if AScrollUp then
    AScrollCode := SB_LINEUP
  else
    AScrollCode := SB_LINEDOWN;
  for I := 0 to AScrollLines - 1 do
    SendMessage(Handle, WM_VSCROLL, AScrollCode, 0);
end;

{ TdxContainerHintWindow }
constructor TdxContainerHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clInfoBk;
  Canvas.Brush.Style := bsClear;
end;

procedure TdxContainerHintWindow.ActivateHint(P: TPoint; const AHint: string; AFont: TFont);
begin
  ActivateHintEx(P, Screen.Width, AHint, AFont, False);
end;

procedure TdxContainerHintWindow.ActivateHintEx(P: TPoint; AWidth: Integer;
  const AHint: string; AFont: TFont; AUseFontSize: Boolean);
var
  NonClientMetrics: TNonClientMetrics;
  R: TRect;
begin
  Caption := AHint;

  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Canvas.Font.Handle := CreateFontIndirect(NonClientMetrics.lfStatusFont)
  else
    Canvas.Font.Size := 8;
  Canvas.Font.Color := clInfoText;
  // NEW
  Canvas.Font.Name := AFont.Name;
  Canvas.Font.Charset := AFont.Charset;
  if AUseFontSize then
    Canvas.Font.Size := AFont.Size;

  if AWidth <= 0 then
    AWidth := Screen.Width;
  R := Rect(0, 0, AWidth, 0);
  DrawText(Canvas.Handle, PChar(AHint), -1, R, DT_CALCRECT or DT_LEFT or
    DT_NOPREFIX or DT_WORDBREAK);
  Inc(R.Right, 2 * (1 + 2));
  Inc(R.Bottom, 2 * (1 + 2));
  Width := R.Right;
  Height := R.Bottom;
  OffsetRect(R, P.X, P.Y);

  if R.Top + Height > Screen.Height then
    R.Top := Screen.Height - Height;
  if R.Left + Width > Screen.Width then
    R.Left := Screen.Width - Width;
  if R.Left < 0 then R.Left := 0;
  if R.Bottom < 0 then R.Bottom := 0;

  SetWindowPos(Handle, HWND_TOPMOST, R.Left, R.Top, 0,
    0, SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

procedure TdxContainerHintWindow.HideHint;
begin
  if HandleAllocated then
    SetWindowPos(Handle, 0, 0, 0, 0,
      0, SWP_NOSIZE or SWP_HIDEWINDOW or SWP_NOACTIVATE);
end;

procedure TdxContainerHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP{ or WS_DISABLED};
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    ExStyle := WS_EX_TOOLWINDOW;
  end;
end;

procedure TdxContainerHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  DrawEdge(Canvas.Handle, R, BDR_RAISEDOUTER, BF_RECT);
  InflateRect(R, -1, -1);
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  DrawText(Canvas.Handle, PChar(Caption), -1, R,
    DT_LEFT or DT_NOCLIP or DT_NOPREFIX or DT_WORDBREAK);
end;

procedure TdxContainerHintWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

{ TdxInplacePopupControl }
constructor TdxInplacePopupControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDrawNC := True;
  FShadowSize := dxEditShadowSize;
end;

procedure TdxInplacePopupControl.HidePopup(ByMouse: Boolean);
begin
  if IsWindowVisible(Handle) then
  begin
    SetWindowPos(Handle, 0, 0, 0, 0, 0,
      SWP_HIDEWINDOW or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE);
    if Application.Active then
      Windows.SetFocus(OwnerControl.Handle);
  end;
  if OwnerControl <> nil then
    PostMessage(OwnerControl.Handle, CM_HIDEPOPUP, 0, 0);
end;

procedure TdxInplacePopupControl.ShowPopup;
begin
  ShowWindow(Handle, SW_SHOW);
  SendMessage(GetParentForm(OwnerControl).Handle, WM_NCACTIVATE, Longint(True), 0);
end;

procedure TdxInplacePopupControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FIsPopupControl then
    with Params do
      WndParent := GetParentForm(OwnerControl).Handle;
end;

procedure TdxInplacePopupControl.SetPopupBorderStyle(Value: TdxPopupBorderStyle);
begin
  if FPopupBorderStyle <> Value then
  begin
    FPopupBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplacePopupControl.SetShadow(Value: Boolean);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplacePopupControl.SetShadowSize(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FShadowSize <> Value then
  begin
    FShadowSize := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplacePopupControl.WMActivate(var Message: TWMActivate);
begin
  inherited;
  if FIsPopupControl and (Message.Active = WA_INACTIVE) and
    (Message.ActiveWindow <> GetParentForm(OwnerControl).Handle) then
    SendMessage(GetParentForm(OwnerControl).Handle, WM_NCACTIVATE, Longint(False), 0);
end;

procedure TdxInplacePopupControl.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if FIsPopupControl then
  begin
    HidePopup(False);
    OwnerControl.DoKillFocus(Message);
  end;
end;

procedure TdxInplacePopupControl.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  if FIsPopupControl then
    Message.Result := MA_NOACTIVATE;
end;

procedure TdxInplacePopupControl.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if FIsPopupControl then
  begin
    case PopupBorderStyle of
      pbSingle:
        InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
      pbFlat:
        InflateRect(Message.CalcSize_Params^.rgrc[0], -2, -2);
      pbFrame3D:
        InflateRect(Message.CalcSize_Params^.rgrc[0], -4, -4);
    end;
    if Shadow then
      with Message.CalcSize_Params^.rgrc[0] do
      begin
        Dec(Right, ShadowSize);
        Dec(Bottom, ShadowSize);
      end;
  end;
end;

procedure TdxInplacePopupControl.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  if FIsPopupControl and FDrawNC then 
    DrawWindowPopupBorder(Handle, PopupBorderStyle,
      (GetWindowLong(Handle, GWL_STYLE) and (WS_HSCROLL or WS_VSCROLL)) = (WS_HSCROLL or WS_VSCROLL),
      Shadow, ShadowSize);
end;

procedure TdxInplacePopupControl.WMSize(var Message: TWMSize);
begin
  inherited;
  if FIsPopupControl then
    UpdateShadow(Handle, Shadow, ShadowSize);
end;

initialization
  ShadowBrush := CreateSolidBrush(ColorToRGB(dxEditShadowColor));
  DefaultEditStyleController := TdxEditStyleController.Create(nil);

finalization
  DefaultEditStyleController.Free;
  DefaultEditStyleController := nil;
  if ShadowBrush <> 0 then DeleteObject(ShadowBrush);

end.

