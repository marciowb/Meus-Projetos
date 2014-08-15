
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express extended inplace editors                            }
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

unit dxExEdtr;

interface

{$I dxEdVer.inc}

uses
  SysUtils, Messages, RichEdit, Windows, Classes, Graphics, Menus, Controls,
  Forms, StdCtrls, Mask, CommCtrl, Buttons, Clipbrd, ImgList, Variants,
  dxCore, dxCommon, dxCntner, dxEditor, dxCalc, dxGrDate;

const
  CM_DROPDOWNPOPUP = WM_APP + 102;
  CM_DROPDOWNPOPUPFORM = WM_APP + 103;
  dxEditButtonCount = 8;
  dxSpinEditTimerId = 100;

type
  { TdxInplaceMemoEdit }
  TdxInplaceMemoEdit = class(TdxInplaceTextEdit)
  private
    FHideScrollBars: Boolean;
    FIsClear: Boolean;
    FLines: TStrings;
    FScrollBars: TScrollStyle;
    FWordWrap: Boolean;
    FWantReturns: Boolean;
    FWantTabs: Boolean;
    procedure SetHideScrollBars(Value: Boolean);
    procedure SetLines(Value: TStrings);
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetWordWrap(Value: Boolean);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSetText(var Message: TMessage); message WM_SETTEXT;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    procedure LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean); override;
    function IsWantTab: Boolean; override;
    property AutoSize default False;
    property HideScrollBars: Boolean read FHideScrollBars write SetHideScrollBars default True;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssNone;
    property SelectionBar default True;
    property WantReturns: Boolean read FWantReturns write FWantReturns default True;
    property WantTabs: Boolean read FWantTabs write FWantTabs default False;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsNeededRedraw: Boolean; override;
    procedure SelectAll; override;
    property Lines: TStrings read FLines write SetLines;
  end;

  { TdxInplaceDropDownEdit }
  TdxEditButtonKind = (bkEllipsis, bkDown, bkGlyph);
  TdxEditButtonInfo = record
    Glyph: TBitmap;
    Index: Integer;
    Kind: TdxEditButtonKind;
    LeftAlignment: Boolean;
    Width: Integer;
  end;
  TdxEditButtonsInfo = array [0..dxEditButtonCount - 1] of TdxEditButtonInfo;

  TdxDropDownEditViewData = class(TdxTextEditViewData)
    // Buttons
    ButtonCount: Integer;
    Buttons: TdxEditButtonsInfo;
    ButtonGlyph: TBitmap;
    HideButtons: Boolean;
    ActiveButtonIndex: Integer;
    PressedButtonIndex: Integer;
  end;

  TdxDropDownEditCloseUp = procedure(Sender: TObject; var Value: string; var Accept: Boolean) of object;

  TdxInplaceDropDownEdit = class(TdxInplaceMaskEdit)
  private
    FActiveButton: Integer;
    FButtonGlyph: TBitmap;
    FDropDownRows: Integer;
    FDropDownWidth: Integer;
    FImmediateDropDown: Boolean;
    FImmediatePopup: Boolean;
    FPopupAlignment: TAlignment;
    FPopupBorder: TdxPopupBorder;
    FPressedButton: Integer;
    FOnCloseUp: TdxDropDownEditCloseUp;
    FOnDropDown: TNotifyEvent;
    function GetButtonGlyph: TBitmap;
    function GetDroppedDown: Boolean;
    procedure SetActiveButton(Value: Integer);
    procedure SetButtonGlyph(Value: TBitmap);
    procedure SetDroppedDown(Value: Boolean);
    procedure StopTracking;
    // messages
    procedure WMCancelMode(var Message: TMessage); message WM_CancelMode;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseWHeel(var Message: TWMMouse); message WM_MOUSEWHEEL;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCLButtonDblClk(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDBLCLK;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMDropDownPopup(var Message: TMessage); message CM_DROPDOWNPOPUP;
    procedure CMHidePopup(var Message: TMessage); message CM_HIDEPOPUP;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  protected
    FActiveList: TWinControl;
    FListVisible: Boolean;
    FSendChildrenStyle: Boolean;
    FSearchStyle: Boolean;
    FOnEditButtonClick: TNotifyEvent;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    // override
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    procedure FocusNeeded;
    procedure SetSelected(Value: Boolean); override;
    // virtual methods
    procedure CalcPosition(APopupControl: TWinControl; ACorrectWidth: Boolean); virtual;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DoButtonDown(IsDown: Boolean; Index: Integer); virtual;
    procedure DoButtonUp(Index: Integer); virtual;
    procedure DoCloseUp(var Value: string; var Accept: Boolean); virtual;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState); virtual;
    procedure DoIncremental(Distance: Integer; Circle: Boolean); virtual;
    procedure DropDown; virtual;
    procedure EditButtonClick; virtual;
    procedure FindListValue(const Value: string); virtual;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    function IsWantMouseWheel: Boolean; override;
    property ActiveButton: Integer read FActiveButton write SetActiveButton;
    property ActiveList: TWinControl read FActiveList write FActiveList;
    property ButtonGlyph: TBitmap read GetButtonGlyph write SetButtonGlyph;
    property DropDownRows: Integer read FDropDownRows write FDropDownRows default 7;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property ImmediateDropDown: Boolean read FImmediateDropDown write FImmediateDropDown default True; // key press
    property ImmediatePopup: Boolean read FImmediatePopup write FImmediatePopup default False; // inplace - show edit
    property PopupAlignment: TAlignment read FPopupAlignment write FPopupAlignment default taLeftJustify;
    property PopupBorder: TdxPopupBorder read FPopupBorder write FPopupBorder default pbDefault;
    property OnCloseUp: TdxDropDownEditCloseUp read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick write FOnEditButtonClick; // obsolete
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActivateEdit; override;
    class procedure CalcButtonsInfo(AViewData: TdxEditViewData); virtual;
    class function CalcDefaultButtonWidth(AViewData: TdxEditViewData; AButtonInfo: TdxEditButtonInfo): Integer; virtual;
    class procedure CalcViewInfo(AViewData: TdxEditViewData; AutoSize: Boolean; var ViewInfo: TdxEditViewInfo); override;
    class procedure DrawBorder(ADC: HDC; var ViewInfo: TdxEditViewInfo; AViewData: TdxEditViewData); override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    function IsFocused: Boolean; override;
    procedure Hide; override;
    procedure MouseButtonClick(X, Y: Integer); override;
    procedure MouseClick; override;
    function PopupBorderStyle: TdxPopupBorderStyle;
    procedure Show; override;
    property DroppedDown: Boolean read GetDroppedDown write SetDroppedDown;
  end;

  { TdxInplaceDateEdit }
  TDateButton = (btnToday, btnClear);
  TDateButtons = set of TDateButton;
  TDateOnError = (deToday, deNull);

  TdxDateValidateInput = procedure(Sender: TObject; const AText: string; var ADate: TDateTime;
      var AMessage: string; var AError: Boolean) of object;

  TdxInplaceDateEdit = class(TdxInplaceDropDownEdit)
  private
    FDate: TDateTime;
    FDateButtons: TDateButtons;
    FDateDropDown: TDateTime;
    FDateOnError: TDateOnError;
    FDateNavigator: TdxGridDatePopup;
    FDateValidation: Boolean;
    FSaveTime: Boolean;
    FTextChanged: Boolean;
    FUseEditMask: Boolean;
    FOnDateChange: TNotifyEvent;
    FOnDateValidateInput: TdxDateValidateInput;
    function GetDate: TDateTime;
    procedure SetDate(Value: TDateTime);
    procedure SetDateEditMask;
    procedure SetUseEditMask(Value: Boolean);
    procedure SetValue(Value: TDateTime);
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    procedure AssignEditValue(const Value: Variant); override;
    procedure Change; override;
    procedure DateChange(Sender: TObject);
    procedure DoValidateInput(const AText: string; var ADate: TDateTime;
      var AMessage: string; var AError: Boolean); virtual;
    procedure DropDown; override;
    function GetDisableCloseEditor: Boolean; override;
    function ReturnEditValue: Variant; override;
    property Date: TDateTime read GetDate write SetDate;
    property DateButtons: TDateButtons read FDateButtons write FDateButtons default [btnToday, btnClear];
    property DateOnError: TDateOnError read FDateOnError write FDateOnError default deNull;
    property DateValidation: Boolean read FDateValidation write FDateValidation default False;
    property EditMask stored False;
    property SaveTime: Boolean read FSaveTime write FSaveTime default True;
    property UseEditMask: Boolean read FUseEditMask write SetUseEditMask default False;
    property OnDateChange: TNotifyEvent read FOnDateChange write FOnDateChange;
    property OnDateValidateInput: TdxDateValidateInput read FOnDateValidateInput write FOnDateValidateInput;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetEditingText: string; override;
    function IsEnterValidate: Boolean; override;
    procedure ValidateEdit; override;
  end;

  { TdxInplaceButtonEdit }
  TdxInplaceButtonEdit = class;

  TdxEditButtonClickEvent = procedure (Sender: TObject; AbsoluteIndex: Integer) of object;

  TdxEditButton = class(TCollectionItem)
  private
    FDefault: Boolean;
    FGlyph: TBitmap;
    FKind: TdxEditButtonKind;
    FLeftAlignment: Boolean;
    FVisible: Boolean;
    FWidth: Integer;
    function GetGlyph: TBitmap;
    procedure SetDefault(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetKind(Value: TdxEditButtonKind);
    procedure SetLeftAlignment(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
  published
    property Default: Boolean read FDefault write SetDefault;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Kind: TdxEditButtonKind read FKind write SetKind default bkEllipsis;
    property LeftAlignment: Boolean read FLeftAlignment write SetLeftAlignment default False;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width: Integer read FWidth write SetWidth default 0;
  end;

  TdxEditButtonClass = class of TdxEditButton;

  TdxEditButtons = class(TCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TdxEditButton;
    function GetVisibleCount: Integer;
    function GetVisibleItem(Index: Integer): TdxEditButton;
    procedure SetItem(Index: Integer; Value: TdxEditButton);
    procedure SetVisibleItem(Index: Integer; Value: TdxEditButton);
  protected
    function GetOwner: TPersistent; {$IFDEF DELPHI3} override;{$ENDIF}
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TComponent; EditButtonClass: TdxEditButtonClass);
    function Add: TdxEditButton;
    function GetAbsoluteIndex(VisibleIndex: Integer): Integer;
    function GetVisibleIndex(AbsoluteIndex: Integer): Integer; // -1 if Invisible
    procedure RestoreDefaults;
    property Items[Index: Integer]: TdxEditButton read GetItem write SetItem; default;
    {$WARNINGS OFF}
    property Owner: TComponent read FOwner;
    {$WARNINGS ON}
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleItems[Index: Integer]: TdxEditButton read GetVisibleItem write SetVisibleItem;
  end;

  TdxEditButtonStyle = (ebsSimple, ebsEllipsis, ebsDown, ebsGlyph);

  TdxButtonEditViewStyle = (vsStandard, vsHideCursor, vsButtonOnly);

  TdxButtonEditViewData = class(TdxDropDownEditViewData)
    ButtonOnly: Boolean;
    EditButtons: TdxEditButtons;
    HideEditCursor: Boolean;
  end;

  TdxInplaceButtonEdit = class(TdxInplaceDropDownEdit)
  private
    FButtons: TdxEditButtons;
    FClickKey: TShortCut;
    FExistButtons: Boolean;
    FViewStyle: TdxButtonEditViewStyle;
    FOnButtonClick: TdxEditButtonClickEvent;
    procedure ReadExistButtons(Reader: TReader);
    procedure SetButtons(Value: TdxEditButtons);
    procedure SetViewStyle(Value: TdxButtonEditViewStyle);
    procedure WriteExistButtons(Writer: TWriter);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    procedure DefaultButtonClick; virtual;
    procedure DoButtonUp(Index: Integer); override;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState); override;
    property Buttons: TdxEditButtons read FButtons write SetButtons;
    property ClickKey: TShortCut read FClickKey write FClickKey default VK_RETURN + scCtrl;
    property ViewStyle: TdxButtonEditViewStyle read FViewStyle write SetViewStyle default vsStandard;
    property OnButtonClick: TdxEditButtonClickEvent read FOnButtonClick write FOnButtonClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure CalcButtonsInfo(AViewData: TdxEditViewData); override;
    class procedure CalcViewInfo(AViewData: TdxEditViewData; AutoSize: Boolean; var ViewInfo: TdxEditViewInfo); override;
    class function DrawClientArea(ADC: HDC; var ARect: TRect; AViewData: TdxEditViewData; IsControl: Boolean): Boolean; override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    function IsEditClass: Boolean; override;
    function IsResetTextClass: Boolean; override;
  end;

  { TdxInplaceCheckEdit }
  TdxCheckBoxState = (cbsUnchecked, cbsChecked, cbsGrayed);
  TdxShowNullFieldStyle = (nsUnchecked, nsInactive, nsGrayedChecked);
  TdxToggleEvent = procedure(Sender: TObject; const Text: string; State: TdxCheckBoxState) of object;

  TdxCheckEditViewData = class(TdxEditViewData)
    Caption: string;
    ExactFocusRect: Boolean;
    Glyph: TBitmap;
    GlyphCount: Integer;
    NullStyle: TdxShowNullFieldStyle;
    Pressed: Boolean;
  end;

  { TdxCheckEditStyleController }
  TdxCheckEditStyleController = class(TdxEditStyleController)
  public
    constructor Create(AOwner: TComponent); override;
    procedure RestoreDefaults; override;
  published
    property BorderStyle default xbsNone;
    property ButtonStyle default bts3D;
  end;

  TdxCheckEditStyle = class(TdxEditStyle)
  public
    class function GetDefaultEditStyleController: TdxEditStyleController; override;
  end;

  TdxInplaceCheckEdit = class(TdxInplaceEdit)
  private
    FAllowGrayed: Boolean;
    FFullFocusRect: Boolean;
    FGlyph: TBitmap;
    FGlyphCount: Integer;
    FMultiLine: Boolean;
    FNullStyle: TdxShowNullFieldStyle;
    FPressed: Boolean;
    FState: TdxCheckBoxState;
    FTracking: Boolean;
    function GetChecked: Boolean;
    function GetGlyph: TBitmap;
    procedure SetChecked(Value: Boolean);
    procedure SetFullFocusRect(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphCount(Value: Integer);
    procedure SetMultiLine(Value: Boolean);
    procedure SetNullStyle(Value: TdxShowNullFieldStyle);
    procedure SetState(Value: TdxCheckBoxState);
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure Click; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    // virtual methods
    procedure AssignEditValue(const Value: Variant); override;
    class procedure CalcCheckRect(ACheckWidth, ACheckHeight: Integer; AAlignment: TAlignment; var R, RC: TRect);
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    class function GetEditStyleClass: TdxEditStyleClass; override;
    procedure InvalidateCheckRect;
    procedure LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean); override;
    function ReturnEditValue: Variant; override;
    procedure Toggle; virtual;
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property Checked: Boolean read GetChecked write SetChecked stored False;
    property FullFocusRect: Boolean read FFullFocusRect write SetFullFocusRect default False;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property GlyphCount: Integer read FGlyphCount write SetGlyphCount default 6;
    property MultiLine: Boolean read FMultiLine write SetMultiLine default False;
    property NullStyle: TdxShowNullFieldStyle read FNullStyle write SetNullStyle default nsGrayedChecked;
    property State: TdxCheckBoxState read FState write SetState default cbsUnchecked;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function CalcCheckSize(AGlyph: TBitmap; AGlyphCount: Integer; var ACheckWidth, ACheckHeight: Integer): Boolean;
    class function DrawClientArea(ADC: HDC; var ARect: TRect; AViewData: TdxEditViewData; IsControl: Boolean): Boolean; override;
    class function GetMinHeight(AViewData: TdxEditViewData): Integer; override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    procedure MouseClick; override;
  end;

  { TdxInplaceImageEdit }
  TdxPopupImageListBox = class;

  TdxImageEditViewData = class(TdxDropDownEditViewData)
    DefaultImages: Boolean;
    Descriptions: TStrings;
    ImageIndexes: TStrings;
    Images: TImageList;
    ShowDescription: Boolean;
    Values: TStrings;
  end;

  TdxInplaceImageEdit = class(TdxInplaceDropDownEdit)
  private
    FDefaultImages: Boolean;
    FDescriptions: TStrings;
    FImageChangeLink: TChangeLink;
    FImageIndexes: TStrings;
    FImages: TImageList;
    FIncremental: Boolean;
    FLargeImageChangeLink: TChangeLink;
    FLargeImages: TImageList;
    FMultiLineText: Boolean;
    FPopupListBox: TdxPopupImageListBox;
    FShowDescription: Boolean;
    FValues: TStrings;
    procedure ImageListChange(Sender: TObject);
    procedure PrepareListBox;
    procedure SetDefaultImages(Value: Boolean);
    procedure SetDescriptions(Value: TStrings);
    procedure SetImageIndexes(Value: TStrings);
    procedure SetImages(Value: TImageList);
    procedure SetLargeImages(Value: TImageList);
    procedure SetMultiLineText(Value: Boolean);
    procedure SetShowDescription(Value: Boolean);
    procedure SetValues(Value: TStrings);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CloseUp(Accept: Boolean); override;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    procedure DoIncremental(Distance: Integer; Circle: Boolean); override;
    procedure DropDown; override;
    procedure SetValue(const Value: string); virtual;
    property DefaultImages: Boolean read FDefaultImages write SetDefaultImages default True;
    property Descriptions: TStrings read FDescriptions write SetDescriptions;
    property ImageIndexes: TStrings read FImageIndexes write SetImageIndexes;
    property Images: TImageList read FImages write SetImages;
    property Incremental: Boolean read FIncremental write FIncremental default False; // Inplace
    property LargeImages: TImageList read FLargeImages write SetLargeImages;
    property MultiLineText: Boolean read FMultiLineText write SetMultiLineText default False;
    property ShowDescription: Boolean read FShowDescription write SetShowDescription default True;
    property Values: TStrings read FValues write SetValues;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure CalcViewIndexes(const Value: string;
      AImageIndexes, ADescriptions, AValues: TStrings; ADefaultImages: Boolean;
      var AImageIndex, ADescIndex: Integer);
    class function DrawClientArea(ADC: HDC; var ARect: TRect;
      AViewData: TdxEditViewData; IsControl: Boolean): Boolean; override;
    class function GetMinHeight(AViewData: TdxEditViewData): Integer; override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    function IsEditClass: Boolean; override;
    function IsResetTextClass: Boolean; override;
  end;

  { TCustomdxPopupListBox }
  TCustomdxPopupListBox = class(TCustomListBox)
  private
    FPopupBorderStyle: TdxPopupBorderStyle;
    FHotTrack: Boolean;
    FRealItemHeight: Integer;
    FShadow: Boolean;
    FShadowSize: Integer;
    procedure SetPopupBorderStyle(Value: TdxPopupBorderStyle);
    procedure SetShadow(Value: Boolean);
    procedure SetShadowSize(Value: Integer);
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    property PopupBorderStyle: TdxPopupBorderStyle read FPopupBorderStyle write SetPopupBorderStyle default pbSingle;
    property HotTrack: Boolean read FHotTrack write FHotTrack default True;
  public
    constructor Create(AOwner: TComponent); override;
    property RealItemHeight: Integer read FRealItemHeight;
    property Shadow: Boolean read FShadow write SetShadow default False;  
    property ShadowSize: Integer read FShadowSize write SetShadowSize default dxEditShadowSize;
    property Style default lbOwnerDrawVariable;
  end;

  { TdxPopupImageListBox }
  TdxPopupImageListBox = class(TCustomdxPopupListBox)
  private
    FImages: TImageList;
    FIsMultiLineText: Boolean;
    procedure SetImages(Value: TImageList);
  protected
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    property Images: TImageList read FImages write SetImages;
    property IsMultiLineText: Boolean read FIsMultiLineText write FIsMultiLineText;
  end;

  { TdxInplaceSpinEdit }
  TdxValueType = (vtInt, vtFloat);
  TdxSpinButtonState = (sbNotDown, sbTopDown, sbBottomDown);

  TdxSpinEditViewData = class(TdxTextEditViewData)
    ShowButton: Boolean;
    StateActive: TdxSpinButtonState;
    StatePressed: TdxSpinButtonState;
  end;

  TdxInplaceSpinEdit = class(TdxInplaceMaskEdit)
  private
    FEditorEnabled: Boolean;
    FIncrement: Double;
    FMaxValue: Double;
    FMinValue: Double;
    FStateActive: TdxSpinButtonState;
    FStatePressed: TdxSpinButtonState;
    FTimer: Longint;
    FUseCtrlIncrement: Boolean;
    FValueType: TdxValueType;
    function CheckValue(Value: Double): Double;
    procedure DoIncremental;
    function GetIntValue: Integer;
    procedure InvalidateBtn;
    function IsIncrementStored: Boolean;
    function IsMaxValueStored: Boolean;
    function IsMinValueStored: Boolean;
    function IsValueStored: Boolean;
    function IsValueTypeStored: Boolean;
    procedure SetIntValue(NewValue: Integer);
    procedure SetMaxValue(Value: Double);
    procedure SetMinValue(Value: Double);
    procedure SetStateActive(Value: TdxSpinButtonState);
    procedure SetValueType(Value: TdxValueType);
    procedure StopTracking;
    // messages
    procedure WMCancelMode(var Message: TMessage); message WM_CancelMode;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMClear(var Message); message WM_CLEAR;
    procedure WMCut(var Message); message WM_CUT;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseWHeel(var Message: TWMMouse); message WM_MOUSEWHEEL;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDblClk(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDBLCLK;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMPaste(var Message); message WM_PASTE;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
  protected
    {$IFNDEF DELPHI4} procedure DefaultHandler(var Message); override; {$ENDIF}
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure AssignEditProperties; override;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    function GetDisableCloseEditor: Boolean; override;
    function GetIncrement: Double; virtual;
    function GetValue: Double; virtual;
    function IsValidChar(Key: Char): Boolean; virtual;
    function IsWantMouseWheel: Boolean; override;
    procedure SetEditMaxValue(Value: Double); virtual;
    procedure SetEditMinValue(Value: Double); virtual;
    procedure SetEditMinMaxValues(AMinValue, AMaxValue: Double); virtual;
    procedure SetEditValueType(Value: TdxValueType); virtual;
    procedure SetSelected(Value: Boolean); override;
    procedure SetValue(Value: Double); virtual;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Increment: Double read FIncrement write FIncrement stored IsIncrementStored;
    property IntValue: Integer read GetIntValue write SetIntValue;
    property MaxValue: Double read FMaxValue write SetMaxValue stored IsMaxValueStored;
    property MinValue: Double read FMinValue write SetMinValue stored IsMinValueStored;
    property StateActive: TdxSpinButtonState read FStateActive write SetStateActive;
    property UseCtrlIncrement: Boolean read FUseCtrlIncrement write FUseCtrlIncrement default False;
    property Value: Double read GetValue write SetValue stored IsValueStored;
    property ValueType: TdxValueType read FValueType write SetValueType stored IsValueTypeStored;
  public
    constructor Create(AOwner: TComponent); override;
    class function CalcSpinButtonWidth(AViewData: TdxEditViewData): Integer; virtual;
    class procedure CalcViewInfo(AViewData: TdxEditViewData;
      AutoSize: Boolean; var ViewInfo: TdxEditViewInfo); override;
    {$IFDEF DELPHI4} procedure DefaultHandler(var Message); override; {$ENDIF}
    function DefaultMaxValue: Double; virtual;
    function DefaultMinValue: Double; virtual;
    function DefaultValueType: TdxValueType; virtual;
    class procedure DrawBorder(ADC: HDC; var ViewInfo: TdxEditViewInfo; AViewData: TdxEditViewData); override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    procedure MouseButtonClick(X, Y: Integer); override;
    procedure RestoreDefaults; override;
    procedure SetMinMaxValues(AMinValue, AMaxValue: Double);
    procedure ValidateEdit; override;
  end;

  { TdxInplacePickEdit }
  TdxPopupPickListBox = class;

  TdxInplacePickEdit = class(TdxInplaceDropDownEdit)
  private
    FDropDownListStyle: Boolean;
    FFindSelection: Boolean;
    FFindStr: string;
    FItemIndex: Integer;
    FItems: TStrings;
    FCanDeleteText: Boolean;
    FPickList: TdxPopupPickListBox;
    FRevertable: Boolean;
    FSorted: Boolean;
    function FindIndex(const AText: string): Integer;
    function GetItemIndex: Integer;
    procedure PrepareListBox;
    procedure SetDropDownListStyle(Value: Boolean);
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure SetSorted(Value: Boolean);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure AssignEditValue(const Value: Variant); override;
    procedure ClearValue; virtual;
    procedure CloseUp(Accept: Boolean); override;
    procedure DoIncremental(Distance: Integer; Circle: Boolean); override;
    procedure DropDown; override;
    procedure FindListValue(const Value: string); override;
    procedure ResetFindStr;
    procedure SetActive(Value: Boolean); override;
    procedure SetEditReadOnly(Value: Boolean); override;
    procedure SetKeyValue(const Value: string); virtual;
    property DropDownListStyle: Boolean read FDropDownListStyle write SetDropDownListStyle default False;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property Items: TStrings read FItems write SetItems;
    property CanDeleteText: Boolean read FCanDeleteText write FCanDeleteText default False; // for DropDownListStyle
    property Revertable: Boolean read FRevertable write FRevertable default False;
    property Sorted: Boolean read FSorted write SetSorted default False;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanModify: Boolean; override;
    function IsResetTextClass: Boolean; override;
  end;

  { TCustomdxPopupPickListBox }
  TCustomdxPopupPickListBox = class(TCustomdxPopupListBox)
  private
    FSearchText: string;
    FSearchTickCount: Longint;
  protected
    procedure KeyPress(var Key: Char); override;
  end;

  { TdxPopupPickListBox }
  TdxPopupPickListBox = class(TCustomdxPopupPickListBox)
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;
  
  { TdxInplaceCalcEdit }
  TdxPopupCalculator = class;

  TdxInplaceCalcEdit = class(TdxInplaceDropDownEdit)
  private
    FBeepOnError: Boolean;
    FButtonStyle: TdxButtonStyle;
    FQuickClose: Boolean;
    FPopupCalculator: TdxPopupCalculator;
    FPrecision: Byte;
    FShowButtonFrame: Boolean;
  protected
    procedure DropDown; override;
    property BeepOnError: Boolean read FBeepOnError write FBeepOnError default True;
    property ButtonStyle: TdxButtonStyle read FButtonStyle write FButtonStyle default bsStandard;
    property Precision: Byte read FPrecision write FPrecision default dxDefCalcPrecision;
    property QuickClose: Boolean read FQuickClose write FQuickClose default False;
    property ShowButtonFrame: Boolean read FShowButtonFrame write FShowButtonFrame default False;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TdxPopupCalculator = class(TCustomdxCalculator)
  private
    FEdit: TdxInplaceCalcEdit;
    FFlat: Boolean;
    FQuickClose: Boolean;
    procedure SetFlat(Value: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function GetEditValue: String; override;
    procedure SetEditValue(const Value: String); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure HidePopup(ByMouse: Boolean); override;
    property Edit: TdxInplaceCalcEdit read FEdit write FEdit;
    property IsFlat: Boolean read FFlat write SetFlat default False;
    property IsQuickClose: Boolean read FQuickClose write FQuickClose default False;
  end;

  { TdxInplaceHyperLinkEdit }
  TdxHyperLinkEditViewData = class(TdxTextEditViewData)
    IsLink: Boolean;
  end;

  TdxInplaceHyperLinkEdit = class(TdxInplaceTextEdit)
  private
    FLinkColor: TColor;
    FLinkFont: TFont;
    FSingleClick: Boolean;
    FStartKey: TShortCut;
    FOnStartClick: TNotifyEvent;
    function GetLinkFont: TFont;
    procedure SetLinkColor(Value: TColor);
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMSetFont(var Message: TWMSetFont); message WM_SETFONT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    procedure DoStart; virtual;
    property AutoSelect default False;
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkFont: TFont read GetLinkFont;
    property SingleClick: Boolean read FSingleClick write FSingleClick default False;
    property StartKey: TShortCut read FStartKey write FStartKey default VK_RETURN + scCtrl;
    property OnStartClick: TNotifyEvent read FOnStartClick write FOnStartClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetEditCursor(X, Y: Integer; AViewData: TdxEditViewData): TCursor; override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    procedure MouseClick; override;
    procedure SelectAll; override;
  end;

  { TdxInplaceTimeEdit }
  TdxTimeEditFormat = (tfHourMinSec, tfHourMin, tfHour);

  TdxInplaceTimeEdit = class(TdxInplaceSpinEdit)
  private
    FSavedDate: TDate;
    FTime: TTime;
    FTimeEditFormat: TdxTimeEditFormat;
    function EditingPlace: Char;
    function GetTime: TTime;
    function IsTimeStored: Boolean;
    procedure SetTime(Value: TTime);
    procedure SetTimeEditFormat(Value: TdxTimeEditFormat);
  protected
    procedure AssignEditValue(const Value: Variant); override;
    function GetIncrement: Double; override;
    function GetValue: Double; override;
    function IsValidChar(Key: Char): Boolean; override;
    function ReturnEditValue: Variant; override;
    procedure SetValue(Value: Double); override;
    property EditMask stored False;
    property Time: TTime read GetTime write SetTime stored IsTimeStored;
    property TimeEditFormat: TdxTimeEditFormat read FTimeEditFormat write SetTimeEditFormat default tfHourMinSec;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SelectAll; override;
  end;

  { TdxInplaceCurrencyEdit }
  TdxInplaceCurrencyEdit = class(TdxInplaceMaskEdit)
  private
    FDecimalPlaces: Integer;
    FDisplayFormat: string;
    FMaxValue: Double;
    FMinValue: Double;
    FNullable: Boolean;
    FNullString: string;
    FUseThousandSeparator: Boolean;
    function GetValue: Double;
    function IsDisplayFormatStored: Boolean;
    function IsMaxValueStored: Boolean;
    function IsMinValueStored: Boolean;
    function IsValueStored: Boolean;
    procedure SetDisplayFormat(const Value: string);
    procedure SetMaxValue(Value: Double);
    procedure SetMinValue(Value: Double);
    procedure SetNullable(Value: Boolean);
    procedure SetNullString(const Value: string);
    procedure SetValue(Value: Double);
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    procedure KeyPress(var Key: Char); override;
    procedure AssignEditProperties; override;
    function IsDisableDragDrop: Boolean; override;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean); override;
    function ReturnEditValue: Variant; override;
    procedure SetEditDisplayFormat(const Value: string); virtual;
    procedure SetEditEditMask(const Value: string); override;
    procedure SetEditMaxValue(Value: Double); virtual;
    procedure SetEditMinValue(Value: Double); virtual;
    procedure SetEditMinMaxValues(AMinValue, AMaxValue: Double); virtual;
    class function StrToFloatEx(S: string; var Value: Double): Boolean;
    property DecimalPlaces: Integer read FDecimalPlaces write FDecimalPlaces default 2;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat stored IsDisplayFormatStored;
    property MaxValue: Double read FMaxValue write SetMaxValue stored IsMaxValueStored;
    property MinValue: Double read FMinValue write SetMinValue stored IsMinValueStored;
    property Nullable: Boolean read FNullable write SetNullable;
    property NullString: string read FNullString write SetNullString; 
    property UseThousandSeparator: Boolean read FUseThousandSeparator write FUseThousandSeparator default False;
    property Value: Double read GetValue write SetValue stored IsValueStored;
  public
    constructor Create(AOwner: TComponent); override;
    function DefaultDisplayFormat: string; virtual;
    function DefaultMaxValue: Double; virtual;
    function DefaultMinValue: Double; virtual;
    function IsNeededRedraw: Boolean; override;
    procedure RestoreDefaults; override;
    procedure SetMinMaxValues(AMinValue, AMaxValue: Double);
    procedure ValidateEdit; override;
  end;

  { TdxPopupToolBar }
  TdxInplaceGraphicEdit = class;
  TdxPopupToolBarButton = (ptbCut, ptbCopy, ptbPaste, ptbDelete, ptbLoad, ptbSave, ptbCustom);
  TdxPopupToolBarButtons = set of TdxPopupToolBarButton;
  TdxPopupToolBarAlignment = (ptaLeft, ptaRight, ptaTop, ptaBottom);
  TdxPopupToolBarButtonClick = procedure(Sender: TObject; Button: TdxPopupToolBarButton) of object;

  TdxPopupToolBar = class(TForm)
  private
    FButtons: array [TdxPopupToolBarButton] of TSpeedButton;
    FCanShow: Boolean;
    FChained: Boolean;
    FClipboardFormat: Word;
    FEditPopupMenu: TPopupMenu;
    FFlagHide: Boolean;
    FIsEmpty: Boolean;
    FIsPopupMenu: Boolean;
    FIsReadOnly: Boolean;
    FNextWindow: HWND;
    FOnButtonClick: TdxPopupToolBarButtonClick;
    FShowCaptions: Boolean;
    FToolBarAlignment: TdxPopupToolBarAlignment;
    FToolBarButtons: TdxPopupToolBarButtons;
    procedure ButtonClick(Sender: TObject);
    function CreateButton(const ACaption, AHint: string; AGlyph: TBitmap): TSpeedButton;
    procedure ForwardMessage(var Message: TMessage);
    function GetCustomButtonCaption: string;
    function GetCustomButtonGlyph: TBitmap;
    procedure SetButtonsEnabled;
    procedure SetCustomButtonCaption(const Value: string);
    procedure SetCustomButtonGlyph(Value: TBitmap);
    procedure SetToolBarAlignment(Value: TdxPopupToolBarAlignment);
    procedure SetToolBarButtons(Value: TdxPopupToolBarButtons);
    procedure WMActivate(var Message: TMessage); message WM_ACTIVATE;
    procedure WMChangeCBChain(var Message: TWMChangeCBChain); message WM_CHANGECBCHAIN;
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
    procedure WMDrawClipboard(var Message: TMessage); message WM_DRAWCLIPBOARD;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWindowHandle; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CalcPosition(const P: TPoint);
    procedure Hide;
    procedure RefreshButtons;
    procedure Show;
    function Visible: Boolean;
    property CanShow: Boolean read FCanShow write FCanShow;
    property ClipboardFormat: Word read FClipboardFormat write FClipboardFormat;
    property CustomButtonCaption: string read GetCustomButtonCaption write SetCustomButtonCaption;
    property CustomButtonGlyph: TBitmap read GetCustomButtonGlyph write SetCustomButtonGlyph;
    property IsEmpty: Boolean read FIsEmpty write FIsEmpty;
    property IsPopupMenu: Boolean read FIsPopupMenu;
    property IsReadOnly: Boolean read FIsReadOnly write FIsReadOnly;
    property OnButtonClick: TdxPopupToolBarButtonClick read FOnButtonClick write FOnButtonClick;
    property ShowCaptions: Boolean read FShowCaptions write FShowCaptions;
    property ToolBarAlignment: TdxPopupToolBarAlignment read FToolBarAlignment write SetToolBarAlignment;
    property ToolBarButtons: TdxPopupToolBarButtons read FToolBarButtons write SetToolBarButtons;
  end;

  { TdxPopupToolBarWindow }
  TdxPopupToolBarWindow = class(TPersistent)
  private
    FAlignment: TdxPopupToolBarAlignment;
    FButtons: TdxPopupToolBarButtons;
    FCustomButtonCaption: string;
    FCustomButtonGlyph: TBitmap;
    FGraphicEdit: TdxInplaceGraphicEdit;
    FIsPopupMenu: Boolean;
    FShowCaptions: Boolean;
    FVisible: Boolean;
    function GetCustomButtonGlyph: TBitmap; virtual;
    procedure SetCustomButtonGlyph(Value: TBitmap);
    procedure SetIsPopupMenu(Value: Boolean);
  public
    constructor Create(AGraphicEdit: TdxInplaceGraphicEdit);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Alignment: TdxPopupToolBarAlignment read FAlignment write FAlignment default ptaBottom;
    property Buttons: TdxPopupToolBarButtons read FButtons write FButtons default
      [ptbCut, ptbCopy, ptbPaste, ptbDelete, ptbLoad, ptbSave];
    property CustomButtonCaption: string read FCustomButtonCaption write FCustomButtonCaption;
    property CustomButtonGlyph: TBitmap read GetCustomButtonGlyph write SetCustomButtonGlyph;
    property IsPopupMenu: Boolean read FIsPopupMenu write SetIsPopupMenu default True;
    property ShowCaptions: Boolean read FShowCaptions write FShowCaptions default True;
    property Visible: Boolean read FVisible write FVisible default True;
  end;

  { TdxInplaceGraphicEdit }
  TdxGraphicEditViewData = class(TdxEditViewData)
    Center: Boolean;
    DrawShadow: Boolean;
    Picture: TPicture;
    QuickDraw: Boolean;
    ShadowColor: TColorRef;
    Stretch: Boolean;
    TempTransparentBitmap: TBitmap;
  end;

  TdxGraphicEditAssignPictureEvent = procedure(Sender: TObject; var Picture: TPicture) of object;
  TdxGraphicEditGraphicClassEvent = procedure(Sender: TObject; var GraphicClass: TGraphicClass) of object;
  TdxGraphicEditTransparency = (gtDefault, gtOpaque, gtTransparent);

  TdxInplaceGraphicEdit = class(TdxInplaceEdit)
  private
    FCenter: Boolean;
    FClipboardFormat: Word;
    FCustomFilter: string;
    FCustomGraphic: Boolean;
    FDblClickActivate: Boolean;
    FGraphicTransparency: TdxGraphicEditTransparency;
    FInternalChanging: Boolean;
    FPicture, FTempPicture: TPicture;
    FPopupToolBar: TdxPopupToolBar;
    FQuickDraw: Boolean;
    FSavePos: TPoint;
    FStretch: Boolean;
    FTempTransparentBitmap: TBitmap;
    FToolbarLayout: TdxPopupToolBarWindow;
    FToolbarPos: TPoint;
    FToolbarPosStored: Boolean;
    FOnAssignPicture: TdxGraphicEditAssignPictureEvent;
    FOnCustomClick: TNotifyEvent;
    FOnGetGraphicClass: TdxGraphicEditGraphicClassEvent;
    procedure EditPopupMenuClick(Sender: TObject);
    procedure HidePopupToolbar;
    procedure PictureChanged(Sender: TObject);
    procedure PreparePopup;
    procedure SetCenter(Value: Boolean);
    procedure SetCustomGraphic(Value: Boolean);
    procedure SetGraphicTransparency(Value: TdxGraphicEditTransparency);
    procedure SetPicture(Value: TPicture);
    procedure SetStretch(Value: Boolean);
    procedure SetToolbarLayout(Value: TdxPopupToolBarWindow);
    procedure SetToolbarPosStored(Value: Boolean);
    procedure ShowPopupToolbar;
    procedure ToolButtonClick(Sender: TObject; Button: TdxPopupToolBarButton);
    procedure WMContextMenu(var Message: TMessage); message WM_CONTEXTMENU;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure AssignEditValue(const Value: Variant); override;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    procedure CustomClick; virtual;
    procedure DoSetFocus; override;
    procedure LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean); override;
    function ReturnEditValue: Variant; override;

    // virtual methods
    procedure AssignPicture(Picture: TPicture); virtual;
    function GetGraphicClass: TGraphicClass; virtual;

    property AutoSize default False;
    property Center: Boolean read FCenter write SetCenter default True;
    property ClipboardFormat: Word read FClipboardFormat write FClipboardFormat;
    property CustomFilter: string read FCustomFilter write FCustomFilter;
    property CustomGraphic: Boolean read FCustomGraphic write SetCustomGraphic default False;
    property DblClickActivate: Boolean read FDblClickActivate write FDblClickActivate default True;
    property GraphicTransparency: TdxGraphicEditTransparency read FGraphicTransparency write SetGraphicTransparency default gtDefault;
    property ParentColor default False;
    property Picture: TPicture read FPicture write SetPicture;
    property QuickDraw: Boolean read FQuickDraw write FQuickDraw default False;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property ToolbarLayout: TdxPopupToolBarWindow read FToolbarLayout write SetToolbarLayout;
    property ToolbarPos: TPoint read FToolbarPos write FToolbarPos;
    property ToolbarPosStored: Boolean read FToolbarPosStored write SetToolbarPosStored default True;
    property OnAssignPicture: TdxGraphicEditAssignPictureEvent read FOnAssignPicture write FOnAssignPicture;
    property OnCustomClick: TNotifyEvent read FOnCustomClick write FOnCustomClick;
    property OnGetGraphicClass: TdxGraphicEditGraphicClassEvent read FOnGetGraphicClass write FOnGetGraphicClass;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure CalcViewInfo(AViewData: TdxEditViewData;
      AutoSize: Boolean; var ViewInfo: TdxEditViewInfo); override;
    procedure ClearPicture;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    class function DrawClientArea(ADC: HDC; var ARect: TRect;
      AViewData: TdxEditViewData; IsControl: Boolean): Boolean; override;
    procedure DoKillFocus(var Message: TWMKillFocus); override;
    class function GetMinRect(AViewData: TdxEditViewData): TRect; override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    function IsFocused: Boolean; override;
    function IsNeededRedraw: Boolean; override;
    procedure LoadFromFile;
    procedure PasteFromClipboard;
    procedure SaveToFile;
  end;

  { TdxInplaceBlobEdit }
  TCustomdxBlobPopup = class;

  TdxBlobPaintStyle = (bpsDefault, bpsIcon, bpsText);
  TdxBlobIcon = (biBlobNull, biBlob, biMemoNull, biMemo,
    biPictNull, biPict, biOleNull, biOle);
  TdxBlobEditKind = (bekMemo, bekPict, bekOle, bekBlob);
  TdxBlobKind = (bkAuto, bkBlob, bkMemo, bkPict, bkOle);

  TdxBlobEditViewData = class(TdxDropDownEditViewData)
    BlobEditKind: TdxBlobEditKind;
    BlobPaintStyle: TdxBlobPaintStyle;
//    BlobText: string;
    Images: TImageList;
//    ImageIndex: Integer;
    IsNull: Boolean;
  end;

  TdxInplaceBlobEdit = class(TdxInplaceDropDownEdit)
  private
    FPopup: TCustomdxBlobPopup;
    FPopupMenu: TPopupMenu;
    // Common
    FBlobData: string;
    FBlobEditKind: TdxBlobEditKind;
    FBlobPaintStyle: TdxBlobPaintStyle;
    FPopupWidth: Integer;
    FPopupHeight: Integer;
    FSizeablePopup: Boolean;
    // Memo
    FAlwaysSaveText: Boolean;
    FMemoCharCase: TEditCharCase;
    FMemoHideScrollBars: Boolean;
    FMemoMaxLength: Integer;
    FMemoOEMConvert: Boolean;
    FMemoScrollBars: TScrollStyle;
    FMemoSelectionBar: Boolean;
    FMemoWantReturns: Boolean;
    FMemoWantTabs: Boolean;
    FMemoWordWrap: Boolean;
    // Picture
    FPictureAutoSize: Boolean;
    FPictureClipboardFormat: Word;
    FPictureGraphicClass: TGraphicClass;
    FPictureFilter: string;
    FPictureTransparency: TdxGraphicEditTransparency;
    FShowExPopupItems: Boolean;
    FShowPicturePopup: Boolean;
    FTempPicture: TPicture;
    FOnAssignPicture: TdxGraphicEditAssignPictureEvent;
    FOnGetGraphicClass: TdxGraphicEditGraphicClassEvent;
    FOnSavePopupSize: TNotifyEvent;
    function GetBlobText: string;
    procedure SaveSize(Sender: TObject);
    procedure SetBlobData(const Value: string);
    procedure SetBlobEditKind(Value: TdxBlobEditKind);
    procedure SetBlobPaintStyle(Value: TdxBlobPaintStyle);
    procedure SetBlobText(const Value: string);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure AssignEditValue(const Value: Variant); override;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    function GetIsNull(const Data: Variant): Boolean; virtual;
    procedure LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean); override;
    function ReturnEditValue: Variant; override;

    // override TdxInplaceDropDownEdit
    procedure CloseUp(Accept: Boolean); override;
    procedure DropDown; override;
    // virtual methods
    procedure AssignPicture(Picture: TPicture); virtual;
    function GetGraphicClass: TGraphicClass; virtual;
    function IsSizeablePopup: Boolean; virtual;
    procedure SavePopupSize(W, H: Integer); virtual;
    procedure SetBlobValue(Sender: TObject); virtual;

    // Common
    property BlobEditKind: TdxBlobEditKind read FBlobEditKind write SetBlobEditKind default bekMemo;
    property BlobPaintStyle: TdxBlobPaintStyle read FBlobPaintStyle write SetBlobPaintStyle default bpsIcon;
    property BlobText: string read GetBlobText write SetBlobText;
    property PopupWidth: Integer read FPopupWidth write FPopupWidth default 200;
    property PopupHeight: Integer read FPopupHeight write FPopupHeight default 140;
    property SizeablePopup: Boolean read FSizeablePopup write FSizeablePopup default True;
    property Text: string read FBlobData write SetBlobData;
    // Memo
    property AlwaysSaveText: Boolean read FAlwaysSaveText write FAlwaysSaveText default True;
    property MemoCharCase: TEditCharCase read FMemoCharCase write FMemoCharCase default ecNormal;
    property MemoHideScrollBars: Boolean read FMemoHideScrollBars write FMemoHideScrollBars default True;
    property MemoMaxLength: Integer read FMemoMaxLength write FMemoMaxLength default 0;
    property MemoOEMConvert: Boolean read FMemoOEMConvert write FMemoOEMConvert default False;
    property MemoScrollBars: TScrollStyle read FMemoScrollBars write FMemoScrollBars default ssNone;
    property MemoSelectionBar: Boolean read FMemoSelectionBar write FMemoSelectionBar default True;
    property MemoWantReturns: Boolean read FMemoWantReturns write FMemoWantReturns default True;
    property MemoWantTabs: Boolean read FMemoWantTabs write FMemoWantTabs default True;
    property MemoWordWrap: Boolean read FMemoWordWrap write FMemoWordWrap default True;
    // Picture
    property PictureAutoSize: Boolean read FPictureAutoSize write FPictureAutoSize default True;
    property PictureClipboardFormat: Word read FPictureClipboardFormat write FPictureClipboardFormat;
    property PictureGraphicClass: TGraphicClass read FPictureGraphicClass write FPictureGraphicClass;
    property PictureFilter: string read FPictureFilter write FPictureFilter;
    property PictureTransparency: TdxGraphicEditTransparency read FPictureTransparency write FPictureTransparency default gtDefault;
    property ShowExPopupItems: Boolean read FShowExPopupItems write FShowExPopupItems default True;
    property ShowPicturePopup: Boolean read FShowPicturePopup write FShowPicturePopup default True;
    property OnAssignPicture: TdxGraphicEditAssignPictureEvent read FOnAssignPicture write FOnAssignPicture;
    property OnGetGraphicClass: TdxGraphicEditGraphicClassEvent read FOnGetGraphicClass write FOnGetGraphicClass;
    property OnSavePopupSize: TNotifyEvent read FOnSavePopupSize write FOnSavePopupSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure CalcButtonsInfo(AViewData: TdxEditViewData); override;
    class function DrawClientArea(ADC: HDC; var ARect: TRect;
      AViewData: TdxEditViewData; IsControl: Boolean): Boolean; override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    function IsEditClass: Boolean; override;
  end;

  { TCustomdxBlobPopup }
  TdxBlobEditButton = (bebOK, bebCancel, bebClose);
  TdxBlobEditButtons = set of TdxBlobEditButton;

  TdxBlobEditSizeInfo = record
    SplitterSize: Integer; {if Flat = 2 else 4}
    BorderIndentX: Integer;
    BorderIndentY: Integer;
    ButtonIndent: Integer;
    ButtonHeight: Integer;
    ButtonWidth: Integer;
    ButtonCount: Integer;
  end;

  TCustomdxBlobPopup = class(TdxInplacePopupControl)
  private
    // Common
    FBlobEditKind: TdxBlobEditKind;
    FButtonEnabled: Boolean;
    FButtonPanelHeight: Integer;
    FButtonPressed: Boolean;
    FButtons: TdxBlobEditButtons;
    FCreating: Boolean;
    FDownButton: Integer;
    FModified: Boolean;
    FReadOnly: Boolean;
    FSizeable: Boolean;
    FSizingCorner: TdxCorner;
    FTracking: Boolean;
    // Memo
    FAlwaysSaveText: Boolean;
    FBlobText: string;
    FBlobTextSaved: Boolean;
    FCharCase: TEditCharCase;
    FCharCaseChanging: Boolean;
    FEditPopupMenu: TPopupMenu;
    FHideScrollBars: Boolean;
    FMaxLength: Integer;
    FOEMConvert: Boolean;
    FScrollBars: TScrollStyle;
    FSelectionBar: Boolean;
    FWantReturns: Boolean;
    FWantTabs: Boolean;
    FWordWrap: Boolean;
    // Picture
    FAutoSize: Boolean;
    FClipboardFormat: Word;
    FGraphicClass: TGraphicClass;
    FGraphicTransparency: TdxGraphicEditTransparency;
    FInternalChanging: Boolean;
    FLeftCoord: Integer;
    FPicture: TPicture;
    FPictureFilter: string;
    FTempTransparentBitmap: TBitmap;
    FTopCoord: Integer;
    // Events
    FOnChange: TNotifyEvent;
    FOnSaveChanges: TNotifyEvent;
    FOnHide: TNotifyEvent;
    procedure CalcRectInfo(var R: TRect; var W, H: Integer);
    procedure CalcSize(var SizeInfo: TdxBlobEditSizeInfo);
    procedure CheckLeftTopCoord;
    procedure CheckSize(var W, H: Integer);
    procedure EditPopupMenuClick(Sender: TObject);
    function GetButtonAt(ScreenX, ScreenY: Integer): Integer;
    function GetButtons: TdxBlobEditButtons;
    function GetModified: Boolean;
    function GetPicture: TPicture;
    procedure PictureChanged(Sender: TObject);
    procedure SetBlobAutoSize(Value: Boolean);
    procedure SetBlobEditKind(Value: TdxBlobEditKind);
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetGraphicTransparency(Value: TdxGraphicEditTransparency);
    procedure SetHideScrollBars(Value: Boolean);
    procedure SetLeftCoord(ALeft: Integer);
    procedure SetMaxLength(Value: Integer);
    procedure SetModified(Value: Boolean);
    procedure SetOEMConvert(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetReadOnly(Value: Boolean);
    procedure SetSelectionBar(Value: Boolean);
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetSizeable(Value: Boolean);
    procedure SetTopCoord(ATop: Integer);
    procedure SetWordWrap(Value: Boolean);
    procedure StopTracking;
    procedure TrackButton(X, Y: Integer);
    procedure UpdateScrollBars;
    // messages
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMContextMenu(var Message: TMessage); message WM_CONTEXTMENU;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitMessage); message WM_NCHITTEST;
    procedure WMNCLButtonDblClk(var Message: TMessage); message WM_NCLBUTTONDBLCLK;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message wm_Paint;
    procedure WMSetFont(var Message: TWMSetFont); message WM_SETFONT;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateWnd; override;
    {$IFNDEF DELPHI4}
    procedure DefaultHandler(var Message); override;
    {$ENDIF}
    procedure DestroyWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
    procedure ButtonClick(Index: Integer); virtual;
    procedure Change; virtual;
    procedure CheckCharCase; virtual;
    procedure DoHide; virtual;
    procedure DoSaveChanges; virtual;
    procedure DoSetMaxLength(Value: Integer); virtual;
    function GetSelLength: Integer; virtual;
    function GetSelStart: Integer; virtual;
    function GetSelText: string; virtual;
    procedure SetSelLength(Value: Integer); virtual;
    procedure SetSelStart(Value: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF DELPHI4}
    procedure DefaultHandler(var Message); override;
    {$ENDIF}
    function CanPaste: Boolean;
    function CanRedo: Boolean;
    function CanUndo: Boolean;
    procedure ClearPicture;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    function GetSelection: TCharRange;
    function GetTextLenEx: Integer;
    procedure HidePopup(ByMouse: Boolean); override;
    procedure LoadFromFile;
    procedure PasteFromClipboard;
    procedure SaveToFile;
    procedure SetSelection(StartPos, EndPos: Longint; ScrollCaret: Boolean);
    procedure SetSize(P: TPoint; DefW, DefH: Integer);
    procedure ShowPopup; override;
    // Common
    property BlobEditKind: TdxBlobEditKind read FBlobEditKind write SetBlobEditKind;
    property Buttons: TdxBlobEditButtons read GetButtons;
    property Modified: Boolean read GetModified write SetModified;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Sizeable: Boolean read FSizeable write SetSizeable default False;
    property SizingCorner: TdxCorner read FSizingCorner;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnSaveChanges: TNotifyEvent read FOnSaveChanges write FOnSaveChanges;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    // Memo - Style
    property AlwaysSaveText: Boolean read FAlwaysSaveText write FAlwaysSaveText default True;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
    property HideScrollBars: Boolean read FHideScrollBars write SetHideScrollBars default True;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property OEMConvert: Boolean read FOEMConvert write SetOEMConvert default False; // TODO
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssNone;
    property SelectionBar: Boolean read FSelectionBar write SetSelectionBar default True;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property WantReturns: Boolean read FWantReturns write FWantReturns default True;
    property WantTabs: Boolean read FWantTabs write FWantTabs default True;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
    // Picture
    property AutoSize: Boolean read FAutoSize write SetBlobAutoSize;
    property ClipboardFormat: Word read FClipboardFormat write FClipboardFormat;
    property GraphicClass: TGraphicClass read FGraphicClass write FGraphicClass;
    property GraphicTransparency: TdxGraphicEditTransparency read FGraphicTransparency write SetGraphicTransparency default gtDefault;
    property LeftCoord: Integer read FLeftCoord write SetLeftCoord;
    property Picture: TPicture read GetPicture write SetPicture;
    property PictureFilter: string read FPictureFilter write FPictureFilter;
    property TopCoord: Integer read FTopCoord write SetTopCoord;
    // Standard
    property Color;
    property Font;
    property Text;
  published
    property TabStop default True;
  end;

  { TdxInplaceMRUEdit }
  TdxMRUEditViewData = class(TdxDropDownEditViewData)
    ShowEllipsis: Boolean;
  end;

  TdxInplaceMRUEdit = class(TdxInplacePickEdit)
  private
    FMaxItemCount: Integer;
    FShowEllipsis: Boolean;
    FOnButtonClick: TNotifyEvent;
    procedure CheckItemCount;
    procedure SetMaxItemCount(Value: Integer);
    procedure SetShowEllipsis(Value: Boolean);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ButtonClick; virtual;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    procedure DoButtonDown(IsDown: Boolean; Index: Integer); override;
    procedure DoButtonUp(Index: Integer); override;
    property ImmediateDropDown default False;
    property MaxItemCount: Integer read FMaxItemCount write SetMaxItemCount default 7;
    property ShowEllipsis: Boolean read FShowEllipsis write SetShowEllipsis default True; 
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddItem(const Value: string); virtual; 
    class procedure CalcButtonsInfo(AViewData: TdxEditViewData); override;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    procedure ValidateEdit; override;
  end;

  { TdxInplacePopupEdit }
  TdxPopupEditForm = class;

  TdxPopupEditFormBorderStyle = (pbsDialog, pbsDialogHelp, pbsSimple, pbsSysPanel);

  TdxPopupEditPopupEvent = procedure (Sender: TObject; const EditText: string) of object;
  TdxPopupEditCloseQueryEvent = procedure (Sender: TObject; var CanClose: Boolean) of object;
  TdxPopupEditCloseUpEvent = procedure (Sender: TObject; var Text: string; var Accept: Boolean) of object;

  TdxInplacePopupEdit = class(TdxInplaceDropDownEdit)
  private
    FHideEditCursor: Boolean;
    FInitedPopupControl: TControl;
    FPopupAutoSize: Boolean;
    FPopupClientEdge: Boolean;
    FPopupControl: TControl;
    FPopupControlAlign: TAlign;
    FPopupControlBorderStyle: TBorderStyle;
    FPopupControlBoundsRect: TRect;
    FPopupControlParent: TWinControl;
    FPopupControlVisible: Boolean;
    FPopupFlatBorder: Boolean;
    FPopupForm: TdxPopupEditForm;
    FPopupFormBorderStyle: TdxPopupEditFormBorderStyle;
    FPopupFormCaption: string;
    FPopupFormVisible: Boolean;
    FPopupHeight: Integer;
    FPopupMinHeight: Integer;
    FPopupMinWidth: Integer;
    FPopupSizeable: Boolean;
    FPopupWidth: Integer;
    FOnCloseQuery: TdxPopupEditCloseQueryEvent;
    FOnCloseUp: TdxPopupEditCloseUpEvent;
    FOnInitPopup: TNotifyEvent;
    FOnPopup: TdxPopupEditPopupEvent;
    procedure SetHideEditCursor(Value: Boolean);
    procedure SetPopupControl(Value: TControl);
    procedure SetPopupHeight(Value: Integer);
    procedure SetPopupMinHeight(Value: Integer);
    procedure SetPopupMinWidth(Value: Integer);
    procedure SetPopupWidth(Value: Integer);
    procedure CMDropDownPopupForm(var Message: TMessage); message CM_DROPDOWNPOPUPFORM;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CalcSize(APopupForm: TdxPopupEditForm); virtual;
    function CanCloseQuery(APopupForm: TdxPopupEditForm): Boolean; virtual;
    procedure DoCloseUp(APopupForm: TdxPopupEditForm; var EditText: string;
      var Accept: Boolean);  {$IFDEF DELPHI4} reintroduce; {$ENDIF} virtual;
    procedure DoDropDownPopupForm; virtual;
    procedure DoInitPopup; virtual;
    procedure DoPopup(APopupForm: TdxPopupEditForm); virtual;
    procedure DropDown; override;
    procedure FinalizePopup(APopupForm: TdxPopupEditForm); virtual;
    procedure InitializePopup(APopupForm: TdxPopupEditForm); virtual;
    property HideEditCursor: Boolean read FHideEditCursor write SetHideEditCursor default False;
    property PopupAutoSize: Boolean read FPopupAutoSize write FPopupAutoSize default True;
    property PopupControl: TControl read FPopupControl write SetPopupControl;
    property PopupFormBorderStyle: TdxPopupEditFormBorderStyle read FPopupFormBorderStyle
      write FPopupFormBorderStyle default pbsDialog;
    property PopupFormCaption: string read FPopupFormCaption write FPopupFormCaption;
    property PopupClientEdge: Boolean read FPopupClientEdge write FPopupClientEdge default False;
    property PopupFlatBorder: Boolean read FPopupFlatBorder write FPopupFlatBorder default True;
    property PopupHeight: Integer read FPopupHeight write SetPopupHeight default 200;
    property PopupMinHeight: Integer read FPopupMinHeight write SetPopupMinHeight default 100;
    property PopupMinWidth: Integer read FPopupMinWidth write SetPopupMinWidth default 100;
    property PopupSizeable: Boolean read FPopupSizeable write FPopupSizeable default True;
    property PopupWidth: Integer read FPopupWidth write SetPopupWidth default 250;
    property OnCloseQuery: TdxPopupEditCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    property OnCloseUp: TdxPopupEditCloseUpEvent read FOnCloseUp write FOnCloseUp;
    property OnInitPopup: TNotifyEvent read FOnInitPopup write FOnInitPopup;
    property OnPopup: TdxPopupEditPopupEvent read FOnPopup write FOnPopup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Hide; override;
    function IsEditClass: Boolean; override;
    function IsFocused: Boolean; override;
    function IsResetTextClass: Boolean; override;
    property PopupForm: TdxPopupEditForm read FPopupForm;
  end;

  TdxPopupEditForm = class(TCustomForm)
  private
    FClientEdge: Boolean;
    FCloseButtonRect: TRect;
    FCloseButtonIsTracking: Boolean;
    FClosePopup: Boolean;
    FFlatBorder: Boolean;
    FGripRect: TRect;
    FMouseAboveCloseButton: Boolean;
    FPopupFormBorderStyle: TdxPopupEditFormBorderStyle;
    FPopupMinHeight: Integer;
    FPopupMinWidth: Integer;
    FSizeable: Boolean;
    FSizingCorner: TdxCorner;
    FSysPanelBorder: Integer;
    FSysPanelHeight: Integer;
    procedure SetClientEdge(Value: Boolean);
    procedure SetFlatBorder(Value: Boolean);
    procedure SetPopupFormBorderStyle(Value: TdxPopupEditFormBorderStyle);
    procedure SetSizeable(Value: Boolean);
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
    procedure WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCCreate(var Message: TWMNCCreate); message WM_NCCREATE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMQueryEndSession(var Message: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure WMSizing(var Message: TMessage); message WM_SIZING;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMSysKeyDown(var Message: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Deactivate; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function HasAsParent(APopupForm: TdxPopupEditForm): Boolean;
    property SizingCorner: TdxCorner read FSizingCorner write FSizingCorner;
  public
    OwnerControl: TdxInplacePopupEdit;
    destructor Destroy; override;
    procedure ClosePopup(Accept: Boolean); virtual;
    procedure ShowPopup; virtual;
    property ClientEdge: Boolean read FClientEdge write SetClientEdge default False;
    property FlatBorder: Boolean read FFlatBorder write SetFlatBorder default True;
    property PopupFormBorderStyle: TdxPopupEditFormBorderStyle read FPopupFormBorderStyle
      write SetPopupFormBorderStyle default pbsDialog;
    property PopupMinHeight: Integer read FPopupMinHeight write FPopupMinHeight default 100;
    property PopupMinWidth: Integer read FPopupMinWidth write FPopupMinWidth default 100;
    property Sizeable: Boolean read FSizeable write SetSizeable default True;
  end;

var
  FCheckWidth, FCheckHeight: Integer;
  dxTimeEditOneSec,
  dxTimeEditOneMin,
  dxTimeEditOneHour,
  dxTimeEditMinValue,
  dxTimeEditMaxValue: TDateTime;
  sdxDateError: string;
  ToolButtons: array [TdxPopupToolBarButton, 0..1] of string;
  imgBlobImages: TImageList = nil;
  sdxBlobEditButtons: array [TdxBlobEditButton] of string; //('OK', 'Cancel', 'Close')
  sdxBlobPopupItems: array [0..5] of string; { ('Cu&t', '&Copy', '&Paste', '&Delete',
    '&Save To File', '&Load From File...')}

const
  crdxHandPointCursor = -1140;
  dxHandPointCursor   = 'DX_HANDPOINT';
  dxTimeEditFormat    = 'hh:nn:ss';
  dxTimeEditFormats: array [TdxTimeEditFormat, 0..1] of string = (
    ('hh:nn:ss', '00:00:00;1;0'), ('hh:nn', '00:00;1;0'), ('hh', '00;1;0'));

function IsPictureEmpty(APicture: TPicture): Boolean;
procedure LoadPicture(Picture: TPicture; GraphicClass: TGraphicClass; const Value: Variant);
procedure SavePicture(APicture: TPicture; var AValue: string);
function TextToDateEx(AText: string; var ADate: TDateTime): Boolean;
function DateTimeToText(ADate: TDateTime): string;
function DateTimeToTextEx(const ADate: TDateTime; IsMasked: Boolean): string;
function DefaultCurrencyDisplayFormat: string;

type
  TdxDateEditSmartInput = (deiToday, deiYesterday, deiTomorrow,
    deiSunday, deiMonday, deiTuesday, deiWednesday, deiThursday, deiFriday, deiSaturday,
    deiFirst, deiSecond, deiThird, deiFourth, deiFifth, deiSixth, deiSeventh,
    deiBOM, deiEOM, deiNow);

const
  sdxDateEditSmartInput: array [TdxDateEditSmartInput] of string = (
    'TODAY', 'YESTERDAY', 'TOMORROW',
    'SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY',
    'FIRST', 'SECOND', 'THIRD', 'FOURTH', 'FIFTH', 'SIXTH', 'SEVENTH',
    'BOM', 'EOM', 'NOW');
  dxGraphicPopupMenuImages: TImageList = nil;
  BlobEditKindUnknown = [bekOle, bekBlob];
  UseDelphiDateTimeFormats: Boolean = False;
  SmartTextToDateFunc: function (const AText: string; var ADate: TDateTime): Boolean = nil;

var
  DefaultCheckEditStyleController: TdxCheckEditStyleController;

implementation

{$R dxExEdtr.res}

uses
  ShellApi, ExtDlgs, dxUtils, Consts, dxEdStr;

const
  bmToolCut      = 'DXTOOL_CUT';
  bmToolCopy     = 'DXTOOL_COPY';
  bmToolPaste    = 'DXTOOL_PASTE';
  bmToolDelete   = 'DXTOOL_DELETE';
  bmToolLoad     = 'DXTOOL_LOAD';
  bmToolSave     = 'DXTOOL_SAVE';

  dxbmBlobNull = 'DXINPLACE_BLOB_NULL';
  dxbmBlob     = 'DXINPLACE_BLOB';
  dxbmMemoNull = 'DXINPLACE_MEMO_NULL';
  dxbmMemo     = 'DXINPLACE_MEMO';
  dxbmPictNull = 'DXINPLACE_PICT_NULL';
  dxbmPict     = 'DXINPLACE_PICT';
  dxbmOleNull  = 'DXINPLACE_OLE_NULL';
  dxbmOle      = 'DXINPLACE_OLE';

  ResButtons: array [TdxPopupToolBarButton] of string = (bmToolCut, bmToolCopy,
    bmToolPaste, bmToolDelete, bmToolLoad, bmToolSave, '');

  // DrawTextRect
  FocusFlags: array [Boolean] of Integer = (0, DX_DTR_FOCUS_RECT);
  ExactFocusFlags: array [Boolean] of Integer = (0, DX_DTR_EXACT_FOCUS_RECT);
  TransparentFlags: array [Boolean] of Integer = (0, DX_DTR_TRANSPARENT);
  // Spin Edit Timer
  InitRepeatPause = 400; { pause before repeat timer (ms) }
  RepeatPause     = 100; { pause before hint window displays (ms)}

var
  PopupFormList: TList;
  TempCanvas: TCanvas;

function ScreenToWindow(hWnd: HWND; var lpPoint: TPoint): Boolean;
var
  R: TRect;
begin
  GetWindowRect(hWnd, R);
  MapWindowPoints(0, hWnd, R, 2);
  Result := ScreenToClient(hWnd, lpPoint);
  Inc(lpPoint.X, -R.Left);
  Inc(lpPoint.Y, -R.Top);
end;

function GetDateEditMask: string;
var
  Format, S: string;
  I, J: Integer;
begin
  Result := '!';
  Format := ShortDateFormat;
  I := 1;
  while I <= Length(Format) do
  begin
    if Format[I] in ['d', 'M', 'y'] then
    begin
      for J := I to Length(Format) do
        if Format[J] <> Format[I] then Break;
      if J - I < 3 then S := '99'
      else
        if Format[I] = 'y' then S := '9999'
        else S := 'lll';
      I := J - 1;
    end
    else S := Format[I];
    Result := Result + S;
    Inc(I);
  end;
  Result := Result + ';1; ';
end;

function GetDateEditFormat: string;

  procedure CorrectForMaskEdit(var S: string);
  var
    APos, AStartPos: Integer;
  begin
    APos := Pos('M', S);
    if APos <> 0 then
    begin
      AStartPos := APos;
      while APos <= Length(S) do
        if S[APos] = 'M' then
          Inc(APos)
        else
          Break;
      if APos - AStartPos > 3 then
        Delete(S, AStartPos + 3, APos - AStartPos - 3);
    end;
  end;

var
  Format: string;
  I: Integer;
  ExistFirst: Boolean;
begin
  Format := ShortDateFormat;
  Result := '';
  for I := 1 to Length(Format) do
  begin
    if (Format[I] = 'd') then
    begin
      ExistFirst := True;
      if (1 < I) and (Format[I - 1] = 'd') then ExistFirst := False;
      if (I < Length(Format)) and (Format[I + 1] = 'd') then ExistFirst := False;
      if ExistFirst then Result := Result + 'd';
    end;
    if (Format[I] = 'M') then
    begin
      ExistFirst := True;
      if (1 < I) and (Format[I - 1] = 'M') then ExistFirst := False;
      if (I < Length(Format)) and (Format[I + 1] = 'M') then ExistFirst := False;
      if ExistFirst then Result := Result + 'M';
    end;
    Result := Result + Format[I];
  end;
  CorrectForMaskEdit(Result);
end;
              
function SmartTextToDate(const AText: string; var ADate: TDateTime): Boolean;
var
  I: TdxDateEditSmartInput;
  L, Delta: Integer;
  S: string;
  Y, M, D: Word;
begin
  Result := False;
  for I := Low(TdxDateEditSmartInput) to High(TdxDateEditSmartInput) do
  begin
    L := Length(sdxDateEditSmartInput[I]);
    S := Copy(AText, 1, L);
    if AnsiCompareText(S, sdxDateEditSmartInput[I]) = 0 then
    begin
      case I of
        deiToday:
          ADate := Date;
        deiYesterday:
          ADate := Date - 1;
        deiTomorrow:
          ADate := Date + 1;
        deiSunday, deiMonday, deiTuesday, deiWednesday, deiThursday, deiFriday, deiSaturday:
          begin
            ADate := Date;
            Delta := Integer(I) - Integer(deiSunday) + 1 - DayOfWeek(ADate);
            if Delta >= 0 then
              ADate := ADate + Delta
            else
              ADate := ADate + 7 + Delta;
          end;
        deiFirst..deiSeventh:
          begin
            ADate := Date;
            Delta := DayOfWeek(ADate) - (Integer(I) - Integer(deiFirst) + 1);
            ADate := ADate - Delta;
          end;
        deiBOM:
          begin
            DecodeDate(Date, Y, M, D);
            ADate := EncodeDate(Y, M, 1);
          end;
        deiEOM:
          begin
            DecodeDate(Date, Y, M, D);
            ADate := EncodeDate(Y, M, MonthDays[IsLeapYear(Y), M]);
          end;
        deiNow:
          ADate := Now;
      end;
      S := Trim(Copy(AText, L + 1, Length(AText)));
      if (Length(S) >= 2) and (S[1] in ['+', '-']) then
      begin
        if S[1] = '+' then L := 1
        else L := -1;
        S := Trim(Copy(S, 2, Length(S)));
        try
          ADate := ADate + L * StrToInt(S);
        except
          on EConvertError do;
        end;
      end;
      Result := True;
      Break;
    end;
  end;
  if not Result and Assigned(SmartTextToDateFunc) then
    Result := SmartTextToDateFunc(AText, ADate);
end;

function TextToDateEx(AText: string; var ADate: TDateTime): Boolean;
var
  I, C: Integer;
begin
  Result := True;
  try
    AText := Trim(AText);
    if AText = '' then
      Result := False
    else
    begin
      // Replace "." (bug VariantChangeType for LongMonth "MMM")
      if not UseDelphiDateTimeFormats and (SysUtils.DateSeparator = '.') then
      begin
        C := 0;
        for I := 1 to Length(AText) do
        begin
          if AText[I] = '.' then
          begin
            AText[I] := ' ';
            Inc(C);
          end;
          if C = 2 then Break;
        end;
      end;
      // Smart Date
      if not SmartTextToDate(AText, ADate) then
        if not UseDelphiDateTimeFormats then
          ADate := VarToDateTime(AText)
        else
          ADate := StrToDateTime(AText);
    end;
  except
    on EVariantError do Result := False;
    on EConvertError do Result := False;
  end;
end;

function DateTimeToText(ADate: TDateTime): string;
var
  SystemTime: TSystemTime;
  PS: PChar;
begin
  if ADate = NullDate then
    Result := ''
  else
    if UseDelphiDateTimeFormats then
      Result := DateTimeToStr(ADate)
    else
    begin
      DateTimeToSystemTime(ADate, SystemTime);
      GetMem(PS, 100);
      try
        GetDateFormat(GetThreadLocale, 0, @SystemTime, nil, PS, 100);
        Result := PS;
        if TimeOf(ADate) <> 0 then
        begin
          GetTimeFormat(GetThreadLocale, 0, @SystemTime, nil, PS, 100);
          Result := Result + ' ' + PS;
        end;
      finally
        FreeMem(PS, 100);
      end;
    end;
  {
  try
    Result := VarFromDateTime(ADate);
  except
    on EVariantError do
      Result := '';
  end;
  }
end;

function DateTimeToTextEx(const ADate: TDateTime; IsMasked: Boolean): string;
begin
  if ADate = NullDate then
    Result := ''
  else
  begin
    if IsMasked then
      Result := FormatDateTime(GetDateEditFormat, ADate)
    else Result := DateTimeToText(ADate);
  end;
end;

procedure LoadPopupMenuImages;
var
  Bmp: TBitmap;
  I: TdxPopupToolBarButton;
begin
  Bmp := TBitmap.Create;
  try
    for I := ptbCut to ptbSave do
      if ResButtons[I] <> '' then
      begin
        Bmp.LoadFromResourceName(HInstance, ResButtons[I]);
        if dxGraphicPopupMenuImages = nil then
          dxGraphicPopupMenuImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
        dxGraphicPopupMenuImages.AddMasked(Bmp, clDefault);
      end;
  finally
    Bmp.Free;
  end;
end;

procedure GetCheckSize;
var
  B: Windows.TBitmap;
  HB: HBITMAP;
begin
  HB := LoadBitmap(0, PChar({$IFNDEF DELPHI3}32759{$ELSE}OBM_CHECKBOXES{$ENDIF}));
  GetObject(HB, SizeOf(Windows.TBitmap), @B);
  DeleteObject(HB);
  FCheckWidth := B.bmWidth div 4;
  FCheckHeight := B.bmHeight div 3;
end;

procedure LoadBlobImages;
var
   Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, dxbmBlobNull);
    imgBlobImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    imgBlobImages.AddMasked(Bmp, clOlive);
    Bmp.LoadFromResourceName(HInstance, dxbmBlob);
    imgBlobImages.AddMasked(Bmp, clOlive);
    Bmp.LoadFromResourceName(HInstance, dxbmMemoNull);
    imgBlobImages.AddMasked(Bmp, clOlive);
    Bmp.LoadFromResourceName(HInstance, dxbmMemo);
    imgBlobImages.AddMasked(Bmp, clOlive);
    Bmp.LoadFromResourceName(HInstance, dxbmPictNull);
    imgBlobImages.AddMasked(Bmp, clOlive);
    Bmp.LoadFromResourceName(HInstance, dxbmPict);
    imgBlobImages.AddMasked(Bmp, clOlive);
    Bmp.LoadFromResourceName(HInstance, dxbmOleNull);
    imgBlobImages.AddMasked(Bmp, clOlive);
    Bmp.LoadFromResourceName(HInstance, dxbmOle);
    imgBlobImages.AddMasked(Bmp, clOlive);
  finally
    Bmp.Free;
  end;
end;

function DefaultCurrencyDisplayFormat: string;
var
  CurrStr: string;
  I: Integer;
  C: Char;
begin
  if CurrencyDecimals > 0 then
  begin
    SetLength(Result, CurrencyDecimals);
    FillChar(Result[1], Length(Result), '0');
  end
  else
    Result := '';
  Result := ',0.' + Result;
  CurrStr := '';
  for I := 1 to Length(CurrencyString) do
  begin
    C := CurrencyString[I];
    if C in [',', '.'] then CurrStr := CurrStr + '''' + C + ''''
    else CurrStr := CurrStr + C;
  end;
  if Length(CurrStr) > 0 then
    case CurrencyFormat of
      0: Result := CurrStr + Result; { '$1' }
      1: Result := Result + CurrStr; { '1$' }
      2: Result := CurrStr + ' ' + Result; { '$ 1' }
      3: Result := Result + ' ' + CurrStr; { '1 $' }
    end;
  Result := Format('%s;-%s', [Result, Result]);
end;

type
  { TdxMemoStrings }
  TdxMemoStrings = class(TStrings)
  private
    MemoEdit: TdxInplaceMemoEdit;
    procedure EnableChange(Value: Boolean);
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetTextStr: string; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetTextStr(const Value: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
  end;

{ TdxMemoStrings }
function TdxMemoStrings.GetCount: Integer;
var
  ACharIndex, ALineLength: Integer;
begin
  Result := 0;
  with MemoEdit do
    if HandleAllocated then
    begin
      Result := SendMessage(Handle, EM_GETLINECOUNT, 0, 0);
      ACharIndex := SendMessage(Handle, EM_LINEINDEX, Result - 1, 0);
      ALineLength := SendMessage(Handle, EM_LINELENGTH, ACharIndex, 0);
      if (ALineLength <= 0) or (ACharIndex = GetTextLenEx) then // bug in RE2 (PlainText mode)
        Dec(Result);
    end;
end;

function TdxMemoStrings.Get(Index: Integer): string;
var
  Text: array[0..4095] of Char;
  L: Integer;
begin
  Word((@Text)^) := SizeOf(Text);
  L := SendMessage(MemoEdit.Handle, EM_GETLINE, Index, Longint(@Text));
  if Text[L - 1] = #13 then Dec(L);
  SetString(Result, Text, L);
end;

procedure TdxMemoStrings.Put(Index: Integer; const S: string);
var
  Selection: TCharRange;
begin
  with MemoEdit do
    if Index >= 0 then
    begin
      Selection.cpMin := SendMessage(Handle, EM_LINEINDEX, Index, 0);
      if Selection.cpMin <> -1 then
      begin
        Selection.cpMax := Selection.cpMin +
          SendMessage(Handle, EM_LINELENGTH, Selection.cpMin, 0);
        SendMessage(Handle, EM_EXSETSEL, 0, Longint(@Selection));
        SendMessage(Handle, EM_REPLACESEL, 0, Longint(PChar(S)));
      end;
    end;
end;

procedure TdxMemoStrings.Insert(Index: Integer; const S: string);
var
  L: Integer;
  Selection: TCharRange;
  Fmt: PChar;
  Str: string;
begin
  with MemoEdit do
    if Index >= 0 then
    begin
      Selection.cpMin := SendMessage(Handle, EM_LINEINDEX, Index, 0);
      if Selection.cpMin >= 0 then
        Fmt := '%s'#13
//        if Count = 0 then Fmt := '%s'
//        else Fmt := '%s'#13
      else
      begin
        Selection.cpMin :=
          SendMessage(Handle, EM_LINEINDEX, Index - 1, 0);
        if Selection.cpMin < 0 then Exit;
        L := SendMessage(Handle, EM_LINELENGTH, Selection.cpMin, 0);
        if L = 0 then Exit;
        Inc(Selection.cpMin, L);
        Fmt := #13'%s';
      end;
      Selection.cpMax := Selection.cpMin;
      SendMessage(Handle, EM_EXSETSEL, 0, Longint(@Selection));
      Str := Format(Fmt, [S]);
      SendMessage(Handle, EM_REPLACESEL, 0, Longint(PChar(Str)));
    end;
end;

procedure TdxMemoStrings.Delete(Index: Integer);
const
  Empty: PChar = '';
var
  Selection: TCharRange;
begin
  with MemoEdit do
  begin
    if Index < 0 then Exit;
    Selection.cpMin := SendMessage(Handle, EM_LINEINDEX, Index, 0);
    if Selection.cpMin <> -1 then
    begin
      Selection.cpMax := SendMessage(Handle, EM_LINEINDEX, Index + 1, 0);
      if Selection.cpMax = -1 then
        Selection.cpMax := Selection.cpMin +
          SendMessage(Handle, EM_LINELENGTH, Selection.cpMin, 0);
      SendMessage(Handle, EM_EXSETSEL, 0, Longint(@Selection));
      SendMessage(Handle, EM_REPLACESEL, 0, Longint(Empty));
    end;
  end;
end;

procedure TdxMemoStrings.Clear;
begin
  MemoEdit.Clear;
end;

procedure TdxMemoStrings.SetUpdateState(Updating: Boolean);
begin
  if MemoEdit.Showing then
    SendMessage(MemoEdit.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then
  begin
    MemoEdit.Refresh;
    MemoEdit.Perform(CM_TEXTCHANGED, 0, 0);
  end;
end;

function TdxMemoStrings.GetTextStr: string;
begin
  Result := MemoEdit.Text;
end;

procedure TdxMemoStrings.SetTextStr(const Value: string);
var
  NewText: string;
begin
  NewText := AdjustLineBreaks(Value);
  EnableChange(False);
  try
    with MemoEdit do
      if (Length(NewText) <> GetTextLen) or (NewText <> Text) then
      begin
        if SendMessage(Handle, WM_SETTEXT, 0, Longint(NewText)) = 0 then
          raise EInvalidOperation.Create(SInvalidMemoSize);
        Perform(CM_TEXTCHANGED, 0, 0);
      end;
  finally
    EnableChange(True);
  end;
end;

procedure TdxMemoStrings.EnableChange(Value: Boolean);
var
  EventMask: Longint;
begin
  with MemoEdit do
  begin
    if Value then
      EventMask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0) or ENM_CHANGE
    else
      EventMask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0) and not ENM_CHANGE;
    SendMessage(Handle, EM_SETEVENTMASK, 0, EventMask);
  end;
end;

{ TdxInplaceMemoEdit }
constructor TdxInplaceMemoEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 185;
  Height := 89;
  if not IsInplace then AutoSelect := False;
  AutoSize := False;
  SelectionBar := True;
  FHideScrollBars := True;
  FWordWrap := True;
  FWantReturns := True;
  FLines := TdxMemoStrings.Create;
  TdxMemoStrings(FLines).MemoEdit := Self;
end;

destructor TdxInplaceMemoEdit.Destroy;
begin
  FLines.Free;
  inherited Destroy;
end;

function TdxInplaceMemoEdit.IsNeededRedraw: Boolean;
begin
  Result := False;
end;

procedure TdxInplaceMemoEdit.SelectAll;
begin
  inherited SelectAll;
  if IsInplace then
  begin
    SendMessage(Handle, EM_LINESCROLL, 0, -$FFFFFFF);
    SendMessage(Handle, EM_SCROLL, SB_LINEUP, 0);
  end;
end;

procedure TdxInplaceMemoEdit.CreateParams(var Params: TCreateParams);
const
  HideScrollBars: array[Boolean] of DWORD = (ES_DISABLENOSCROLL, 0);
  ScrollBar: array[TScrollStyle] of DWORD = (0, WS_HSCROLL, WS_VSCROLL,
    WS_HSCROLL or WS_VSCROLL);
  WordWraps: array[Boolean] of DWORD = (0, ES_AUTOHSCROLL);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style and not WordWraps[FWordWrap];
    Style := Style or ScrollBar[FScrollBars] or HideScrollBars[FHideScrollBars] or
      ES_MULTILINE;
  end;
end;

procedure TdxInplaceMemoEdit.CreateWindowHandle(const Params: TCreateParams);
var
  Bounds: TRect;
begin
  Bounds := BoundsRect;
  inherited CreateWindowHandle(Params);
  if HandleAllocated then BoundsRect := Bounds;
end;

procedure TdxInplaceMemoEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and CanModify and not (ssCtrl in Shift) then
  begin
    if EditCanModify then
      SendMessage(Handle, WM_CHAR, Word(#13), 0);
  end
  else
  begin
    if ((Key in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) and ((SelLength <> GetTextLenEx) or (Shift <> []) )) or
      ((Key in [VK_TAB]) and WantTabs) then
      ParentKeyDown(Key, Shift)
    else
      inherited KeyDown(Key, Shift);
  end;
end;

procedure TdxInplaceMemoEdit.Loaded;
begin
  inherited Loaded;
  Modified := False;
end;

function TdxInplaceMemoEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxTextEditViewData(Result) do
    DrawAlignment := daMultiLine;
end;

procedure TdxInplaceMemoEdit.LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean);
var
  Value: Variant;
begin
  if Assigned(DataDefinition) and IsPaintCopy then
  begin
    Value := DataDefinition.EditValue;
    if VarIsNull(Value) then Data := ''
    else Data := Value;
  end
  else
    inherited LoadDisplayValue(Data, IsPaintCopy);
end;

function TdxInplaceMemoEdit.IsWantTab: Boolean;
begin
  Result := WantTabs;
end;

// private TdxInplaceMemoEdit
procedure TdxInplaceMemoEdit.SetHideScrollBars(Value: Boolean);
begin
  if FHideScrollBars <> Value then
  begin
    FHideScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceMemoEdit.SetLines(Value: TStrings);
begin
  FLines.Assign(Value);
end;

procedure TdxInplaceMemoEdit.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceMemoEdit.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceMemoEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if FWantTabs then
    Message.Result := Message.Result or DLGC_WANTTAB{ or DLGC_WANTCHARS};
  if not FWantReturns then
    Message.Result := Message.Result and not DLGC_WANTALLKEYS;
end;

procedure TdxInplaceMemoEdit.WMKeyDown(var Message: TWMKeyDown);
begin
  if not FWantReturns and (Message.CharCode = VK_RETURN) and
    not IsControlPressed then
  begin
    with TMessage(Message) do
      SendMessage(Parent.Handle, WM_KEYDOWN, WParam, LParam);
    Exit;
  end;
  inherited;
end;

procedure TdxInplaceMemoEdit.WMSetText(var Message: TMessage);
begin
  if HandleAllocated and not FIsClear then
  begin
    FIsClear := True;
    try
      Clear; // Bug in RE
    finally
      FIsClear := False;
    end;
  end;
  inherited;
end;

{ TdxInplaceDropDownEdit }
constructor TdxInplaceDropDownEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSendChildrenStyle := True;
  FActiveButton := -1;
  FDropDownRows := 7;
  FPressedButton := -1;
  FImmediateDropDown := True;
end;

destructor TdxInplaceDropDownEdit.Destroy;
begin
  FButtonGlyph.Free;
  inherited Destroy;
end;

procedure TdxInplaceDropDownEdit.ActivateEdit;
begin
  inherited ActivateEdit;
  if ImmediatePopup then
    DroppedDown := True;
end;

class procedure TdxInplaceDropDownEdit.CalcViewInfo(AViewData: TdxEditViewData;
  AutoSize: Boolean; var ViewInfo: TdxEditViewInfo);
var
  I: Integer;
begin
  inherited CalcViewInfo(AViewData, AutoSize, ViewInfo);
  CalcButtonsInfo(AViewData);
  with TdxDropDownEditViewData(AViewData) do
    for I := 0 to ButtonCount - 1 do
      with Buttons[I], ViewInfo.ClientBounds do
      begin
        if LeftAlignment then
          Inc(Left, Buttons[I].Width)
        else Dec(Right, Buttons[I].Width);
      end;
end;

class procedure TdxInplaceDropDownEdit.DrawBorder(ADC: HDC; var ViewInfo: TdxEditViewInfo; AViewData: TdxEditViewData);
var
  I: Integer;
  BR, R: TRect;
  X, Y, Size: Integer;

  procedure DrawArrow(X, Y: Integer; Color: COLORREF);
  var
    Brush: HBRUSH;
    P: array[1..3] of TPoint;
    Pen: HPEN;
  begin
    P[1] := Point(X, Y);
    P[2] := Point(X + Size - 1, Y);
    P[3] := Point(X + Size div 2, Y + Size div 2);
    Pen := SelectObject(ADC, CreatePen(PS_SOLID, 1, GetSysColor(Color)));
    Brush := SelectObject(ADC, GetSysColorBrush(Color));
    Polygon(ADC, P, 3);
    SelectObject(ADC, Brush);
    Windows.DeleteObject(SelectObject(ADC, Pen));
  end;

  procedure DrawEllipsis(X, Y: Integer; Color: COLORREF);
  begin
    FillRect(ADC, Rect(X, Y, X + Size, Y + Size), GetSysColorBrush(Color));
    FillRect(ADC, Rect(X - Size * 2, Y, X - Size * 2 + Size, Y + Size), GetSysColorBrush(Color));
    FillRect(ADC, Rect(X + Size * 2, Y, X + Size * 2 + Size, Y + Size), GetSysColorBrush(Color));
  end;

  procedure DrawButton(ADC: HDC; ARect: TRect; APushed, ASelected, ATransparent: Boolean);
  const
    Flags3D: array [Boolean] of Integer = (BDR_RAISEDINNER or BDR_RAISEDOUTER, BDR_SUNKENOUTER);
    FlagsFlat: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
    TransparentFlags: array [Boolean] of Integer = (BF_MIDDLE, 0);
  var
    FlatBrush: HBRUSH;
    PenColor: TColorRef;
    W: Integer;
    BS: TdxEditButtonViewStyle;
    Br: HBRUSH;
    R, BRect: TRect;
  begin
    with TdxDropDownEditViewData(AViewData), Buttons[I] do
    begin
      PenColor := COLOR_BTNTEXT;
      W := ARect.Right - ARect.Left;
      BS := ButtonStyle;
      if ATransparent then
        Br := Brush
      else Br := GetSysColorBrush(COLOR_BTNFACE);
      if (APushed or ASelected) and (BS = btsSimple) then
        BS := btsFlat;
      if ATransparent and (Kind <> bkGlyph) then
        FillRect(ADC, ARect, Brush);
      R := ARect;
      case BS of
        btsHotFlat:
          begin
            FrameRect(ADC, ARect, GetSysColorBrush(COLOR_BTNSHADOW));
            InflateRect(ARect, -1, -1);
            if ASelected or APushed then
            begin
              if ATransparent then
              begin
                if not APushed then
                  PenColor := COLOR_BTNSHADOW;
              end
              else PenColor := COLOR_WINDOW;
            end;
            R := ARect;
            if not ATransparent then
            begin
              FlatBrush := GetSysColorBrush(COLOR_BTNFACE);
              if Enabled then
                if APushed then
                  FlatBrush := GetSysColorBrush(COLOR_BTNTEXT)
                else
                  if ASelected then
                    FlatBrush := GetSysColorBrush(COLOR_BTNSHADOW);
              Br := FlatBrush;
              if Kind <> bkGlyph then
                FillRect(ADC, ARect, Br); // Bk
            end;
          end;
        btsSimple:
          begin
            if not ATransparent then
            begin
              FrameRect(ADC, ARect, Brush);
              InflateRect(ARect, -1, -1);
              with ARect do
              begin
                FillRect(ADC, Rect(Left, Top, Left + 1, Bottom), Brush);
                Inc(Left);
              end;
              R := ARect;
              if Kind <> bkGlyph then
                FillRect(ADC, ARect, Br); // Bk
            end
            else
            begin
              InflateRect(ARect, -1, -1);
//              Inc(ARect.Left);
            end;
          end;
        btsFlat:
          begin
            if not ATransparent then
              with ARect do
              begin
                FillRect(ADC, Rect(Left, Top, Left + 1, Bottom), GetSysColorBrush(COLOR_BTNFACE));
                Inc(Left);
              end;
            DrawEdge(ADC, ARect, FlagsFlat[APushed], BF_RECT or // TODO Transparentce? + Spin
              TransparentFlags[ATransparent or (Kind = bkGlyph)] or BF_ADJUST); // Bk*
            R := ARect;
          end;
        bts3D:
          begin
            if APushed then
            begin
              DrawEdge(ADC, ARect, BDR_RAISEDINNER,
                 TransparentFlags[ATransparent or (Kind = bkGlyph)] or BF_BOTTOMRIGHT or BF_ADJUST); // Bk*
              DrawEdge(ADC, ARect, BDR_SUNKENOUTER, BF_TOPLEFT or BF_ADJUST);
            end
            else
              DrawEdge(ADC, ARect, BDR_RAISEDINNER or BDR_RAISEDOUTER,
                 TransparentFlags[ATransparent or (Kind = bkGlyph)] or BF_RECT or BF_ADJUST); // Bk*
            R := ARect;
          end;
      end;
      if APushed and not (BS in [btsHotFlat]) then
      begin
        if Kind = bkGlyph then
        begin
          Inc(ARect.Left, 1 + Byte(BS = bts3D));
          Inc(ARect.Top, 1 + Byte(BS = bts3D));
        end
        else
          OffsetRect(ARect, 1, 1);
      end;
      // Content
      case Kind of
        bkDown:
          begin
            with ARect do
            begin
              Size := (Right - Left) div 2;
              if not Odd(Size) then Inc(Size);
              X := (Left + Right - Size) div 2;
              Y := (Top + Bottom - Size div 2) div 2 - Byte(Odd(Bottom - Top)){1};
              if Enabled then
                DrawArrow(X, Y, PenColor)
              else
              begin
                DrawArrow(X + 1, Y + 1, COLOR_BTNHIGHLIGHT);
                DrawArrow(X, Y, COLOR_BTNSHADOW);
              end;
            end;
          end;
        bkEllipsis:
          begin
            with ARect do
            begin
              if W + Byte(ButtonStyle in [btsSimple, btsFlat]) < 16 then
                Size := 1
              else Size := 2;
              X := (Left + Right - Size) div 2;
              Y := (Top + Bottom - Size div 2) div 2 - Byte(Odd(Bottom - Top)){1};
              if Enabled then
                DrawEllipsis(X, Y, PenColor)
              else
              begin
                DrawEllipsis(X + 1, Y + 1, COLOR_BTNHIGHLIGHT);
                DrawEllipsis(X, Y, COLOR_BTNSHADOW);
              end;
            end;
          end;
        bkGlyph:
          begin
            if Glyph <> nil then
            begin
              with Glyph, ARect do
              begin
                BRect := Rect(Left, Top, Left + Width, Top + Height);
                if BRect.Right < Right then
                begin
                  if APushed and (BS in [btsFlat, btsSimple]) and Odd(Right - BRect.Right) then
                    OffsetRect(BRect, 1, 0);
                  OffsetRect(BRect, (Right - BRect.Right) div 2, 0);
                end;
                if BRect.Bottom < Bottom then
                  OffsetRect(BRect, 0, (Bottom - BRect.Bottom) div 2);
              end;
              TransparentDrawEx(ADC, Br, R, BRect, Glyph);
            end;
          end;
      end;
    end;
  end;

begin
  inherited DrawBorder(ADC, ViewInfo, AViewData);
  with ViewInfo do
  begin
    BR := BorderRect;
    InflateBorderRect(BR, ViewInfo, False);
  end;
  with TdxDropDownEditViewData(AViewData) do
    for I := ButtonCount - 1 downto 0 do
      with Buttons[I] do
      begin
        R := BR;
        if LeftAlignment then
        begin
          R.Right := R.Left + Width;
          BR.Left := R.Right;
        end
        else
        begin
          R.Left := R.Right - Width;
          BR.Right := R.Left;
        end;
        // Draw Buttons
        DrawButton(ADC, R, (I = PressedButtonIndex) and (I = ActiveButtonIndex),
          (I = ActiveButtonIndex), ButtonTransparence);
      end;
end;

function TdxInplaceDropDownEdit.IsFocused: Boolean;
begin
  Result := inherited IsFocused or
    ((FActiveList <> nil) and (FActiveList.HandleAllocated) and (FActiveList.Focused));
end;

procedure TdxInplaceDropDownEdit.Hide;
begin
  if FListVisible and (ActiveList <> nil) then
    PostMessage(ActiveList.Handle, WM_CLOSE, 0, 0);
  FListVisible := False;
  inherited Hide;
end;

procedure TdxInplaceDropDownEdit.MouseButtonClick(X, Y: Integer); // TODO
var
  P: TPoint;
begin
  inherited MouseButtonClick(X, Y);
  if not Assigned(Container) then Exit; 
  P := Point(X, Y);
  MapWindowPoints(Container.Handle, 0, P, 1);
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN,
    SendMessage(Handle, WM_NCHITTEST, 0, MAKELPARAM(P.X, P.Y)),
    MAKELPARAM(P.X, P.Y));
end;

procedure TdxInplaceDropDownEdit.MouseClick;
begin
  if FImmediatePopupStyle and ((ActiveList = nil) or not FListVisible) then
    DropDown;
  inherited MouseClick;
end;

function TdxInplaceDropDownEdit.PopupBorderStyle: TdxPopupBorderStyle;
begin
  if PopupBorder <> pbDefault then
    Result := PopupBorder
  else
  begin
    if Assigned(Container) then
      Result := Container.GetDefaultPopupBorderStyle(Style.BorderStyle)
    else
    case Style.BorderStyle of
      xbsSingle, xbs3D: Result := pbSingle;
      xbsFlat: Result := pbFlat;
    else
      Result := pbFrame3D;
    end;
  end;
end;

procedure TdxInplaceDropDownEdit.Show;
begin
  FListVisible := False;
  inherited Show;
end;

// protected TdxInplaceDropDownEdit
procedure TdxInplaceDropDownEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not FSendChildrenStyle then
    if ((Key in [VK_UP, VK_DOWN]) and (ssAlt in Shift)) or
      ((Key = VK_F4) and not (ssAlt in Shift))then
    begin
      DropDown;
      Key := 0;
    end;
  inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceDropDownEdit.MouseMove(Shift: TShiftState; X, Y: Integer); // TODO
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if (FPressedButton <> -1) or (FImmediatePopupStyle and (ssLeft in Shift)) then
  begin
    if FListVisible and (FActiveList <> nil) then
    begin
      ListPos := FActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxInplaceDropDownEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_KEYDOWN, WM_SYSKEYDOWN, WM_CHAR:
      if FSendChildrenStyle then
        with TWMKey(Message) do
        begin
          if Message.Msg <> WM_CHAR then
            DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
          if (CharCode <> 0) and FListVisible then
            if not FSearchStyle then
            begin
              with TMessage(Message) do
                SendMessage(FActiveList.Handle, Msg, WParam, LParam);
              Exit;
            end
            else
            begin
              if (Message.Msg = WM_CHAR) or
                ((Message.Msg = WM_KEYDOWN) and (TWMKey(Message).CharCode in [VK_DELETE, VK_BACK]))then
              begin
                inherited;
                FindListValue(Text);
              end
              else
                if (Message.Msg = WM_KEYDOWN) then
                begin
                  if IsEditClass and (TWMKey(Message).CharCode in [VK_HOME, VK_END, VK_LEFT, VK_RIGHT]) then
                  begin
                    inherited;
                    Exit;
                  end;
                  if (TWMKey(Message).CharCode in [VK_UP, VK_DOWN, VK_HOME, VK_END, VK_PRIOR, VK_NEXT, VK_LEFT, VK_RIGHT]) then
                  begin
                    with TMessage(Message) do
                      SendMessage(FActiveList.Handle, Msg, WParam, LParam);
                  end;
                end;
              if not ((Message.Msg = WM_SYSKEYDOWN) and (TWMKey(Message).CharCode = VK_F4)) then
                Exit;
            end;
        end;
  end;
  inherited;
end;

class function TdxInplaceDropDownEdit.CalcDefaultButtonWidth(AViewData: TdxEditViewData;
  AButtonInfo: TdxEditButtonInfo): Integer;
begin
  with AViewData, AButtonInfo do
    if (Kind = bkGlyph) and (Glyph <> nil) and (Glyph.Width > 0) then
      Result := Glyph.Width + 2 + 1 * Byte(ButtonStyle in [btsFlat, btsSimple]) + 2 * Byte(ButtonStyle = bts3D)
    else
    begin
      Result := GetSystemMetrics(SM_CXVSCROLL);
      if ButtonStyle in [btsSimple, btsFlat] then
        Dec(Result);
    end;
end;

class procedure TdxInplaceDropDownEdit.CalcButtonsInfo(AViewData: TdxEditViewData);
begin
  with TdxDropDownEditViewData(AViewData) do
  begin
    FillChar(Buttons, SizeOf(Buttons), 0);
    if HideButtons then
      ButtonCount := 0
    else
    begin
      ButtonCount := 1;
      with Buttons[0] do
      begin
        Index := 0;
        LeftAlignment := False; // TODO BiDi
        Glyph := ButtonGlyph;
        if Assigned(Glyph) then Kind := bkGlyph
        else Kind := bkDown;
        Width := CalcDefaultButtonWidth(AViewData, Buttons[0]);
      end;
    end;
  end;
end;

function TdxInplaceDropDownEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxDropDownEditViewData(Result) do
  begin
    ButtonGlyph := FButtonGlyph;
    if Assigned(ButtonGlyph) and ButtonGlyph.Empty then 
      ButtonGlyph := nil;
    HideButtons := not IsSelected and (Style.ButtonTransparence = ebtHideInactive);
    ActiveButtonIndex := FActiveButton;
    PressedButtonIndex := FPressedButton;
  end;
end;

class function TdxInplaceDropDownEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxDropDownEditViewData;
end;

procedure TdxInplaceDropDownEdit.FocusNeeded;
begin
  if not Focused and CanFocus and HandleAllocated and IsWindowVisible(Handle) and
    Application.Active then SetFocus; // TODO Check
end;

procedure TdxInplaceDropDownEdit.SetSelected(Value: Boolean);
begin
  if not Value then
    ActiveButton := -1;
  inherited SetSelected(Value);
end;

procedure TdxInplaceDropDownEdit.CalcPosition(APopupControl: TWinControl; ACorrectWidth: Boolean);
var
  FViewData: TdxEditViewData;
  ViewInfo: TdxEditViewInfo;
  W, H: Integer;
  P: TPoint;
  R: TRect;
begin
  GetWindowRect(Handle, R);
  FViewData := CreateViewData(False);
  try
    CalcViewInfo(FViewData, False, ViewInfo);
    with ViewInfo.BorderRect do
    begin
      W := Right - Left;
      if FViewData.Shadow then
        Inc(W, dxEditShadowSize);
      if ACorrectWidth and (APopupControl.Width < W) then
        APopupControl.Width := W;
      with ViewInfo.BorderRect do
      begin
        Inc(R.Left, Left);
        R.Right := R.Left + W;
      end;
    end;
    if FViewData.BorderStyle in [xbsNone, xbsSingle] then
      InflateRect(R, 0, -1);
    if not IsInplace and (FViewData.BorderStyle = xbsNone) then
      InflateRect(R, 0, -1);
  finally
    FViewData.Free;
  end;
  with R do
  begin
    W := APopupControl.Width;
    H := APopupControl.Height;
    case PopupAlignment of
      taLeftJustify:
        P := Point(Left, Bottom);
      taCenter:
        P := Point((Right + Left) div 2  - (W div 2), Bottom);
    else { taRightJustify }
      P := Point(Right - W, Bottom);
    end;
    CheckScreenPosition(P, W, H, Bottom - Top);
  end;
  with APopupControl do
    SetBounds(P.X, P.Y, W, H);
end;

procedure TdxInplaceDropDownEdit.CloseUp(Accept: Boolean);
begin
end;

procedure TdxInplaceDropDownEdit.DoButtonDown(IsDown: Boolean; Index: Integer);
begin
  if (FActiveList <> nil) and FListVisible and FSendChildrenStyle then
    CloseUp(False)
  else
    if not FListVisible then
    begin
      FPressedButton := FActiveButton;
      if not IsDown then SetCapture(Handle);
      SendMessage(Handle, WM_NCPAINT, 0, 0);
      //DropDown;
      if Index <> -1 then 
        DroppedDown := True;
    end;
end;

procedure TdxInplaceDropDownEdit.DoButtonUp(Index: Integer);
begin
end;

procedure TdxInplaceDropDownEdit.DoCloseUp(var Value: string; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Value, Accept);
end;

procedure TdxInplaceDropDownEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  if ((Key in [VK_UP, VK_DOWN]) and (ssAlt in Shift)) or
    ((Key = VK_F4) and not (ssAlt in Shift))then
  begin
    if FListVisible then CloseUp(True) else DropDown;
    Key := 0;
  end
  else
  if Key in [VK_RETURN, VK_ESCAPE] then
    if FListVisible and not (ssAlt in Shift) then
    begin
      CloseUp(Key = VK_RETURN);
//      if Key = VK_ESCAPE then Key := 0;
      if Key = VK_RETURN then KillMessage(Handle, WM_CHAR);
      Key := 0;
    end;
end;

procedure TdxInplaceDropDownEdit.DoIncremental(Distance: Integer; Circle: Boolean);
begin
  // TODO Modified := ?
end;

procedure TdxInplaceDropDownEdit.DropDown;
begin
end;

procedure TdxInplaceDropDownEdit.EditButtonClick;
begin
  if Assigned(FOnEditButtonClick) then FOnEditButtonClick(Self);
  if Assigned(FOnDropDown) then FOnDropDown(Self);
end;

procedure TdxInplaceDropDownEdit.FindListValue(const Value: string);
begin
end;

procedure TdxInplaceDropDownEdit.ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

function TdxInplaceDropDownEdit.IsWantMouseWheel: Boolean;
begin
  Result := True;
end;

// private TdxInplaceDropDownEdit
function TdxInplaceDropDownEdit.GetButtonGlyph: TBitmap;
begin
  if FButtonGlyph = nil then FButtonGlyph := TBitmap.Create;
  Result := FButtonGlyph;
end;

function TdxInplaceDropDownEdit.GetDroppedDown: Boolean;
begin
  Result := (FActiveList <> nil) and FActiveList.HandleAllocated and
    IsWindowVisible(FActiveList.Handle) and (FActiveList.Focused or FSendChildrenStyle);
end;

procedure TdxInplaceDropDownEdit.SetActiveButton(Value: Integer);
begin
  if FActiveButton <> Value then
  begin
    FActiveButton := Value;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TdxInplaceDropDownEdit.SetButtonGlyph(Value: TBitmap);
begin
  if (Value = nil) or Value.Empty then
  begin
    FButtonGlyph.Free;
    FButtonGlyph := nil;
  end
  else
    ButtonGlyph.Assign(Value);
  StyleChanged;
end;

procedure TdxInplaceDropDownEdit.SetDroppedDown(Value: Boolean);
begin
  if DroppedDown <> Value then
    if Value then
      PostMessage(Handle, CM_DROPDOWNPOPUP, 0, 0)
    else CloseUp(False);   
end;

procedure TdxInplaceDropDownEdit.StopTracking;
begin
  if FPressedButton <> -1 then
  begin
    FPressedButton := -1;
    if GetCapture = Handle then
      ReleaseCapture;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TdxInplaceDropDownEdit.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TdxInplaceDropDownEdit.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  StopTracking;
end;

procedure TdxInplaceDropDownEdit.WMKillFocus(var Message: TMessage);
begin
  inherited;
  CloseUp(False);
end;

procedure TdxInplaceDropDownEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if IsInplace or DroppedDown then
    Message.Result := Message.Result or DLGC_WANTALLKEYS;
end;

procedure TdxInplaceDropDownEdit.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FImmediatePopupStyle then
    DoButtonDown(True, 0);
  inherited;
end;

procedure TdxInplaceDropDownEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if FImmediatePopupStyle then
    DoButtonDown(True, 0);
  inherited;
end;

procedure TdxInplaceDropDownEdit.WMLButtonUp(var Message: TWMLButtonUp);
var
  PressedIndex: Integer;
begin
  if FPressedButton <> -1 then
  begin
    if FActiveButton <> -1 then
      PressedIndex := FPressedButton
    else PressedIndex := -1;
    StopTracking;
    if PressedIndex <> -1 then
      DoButtonUp(PressedIndex);
  end;
  inherited;
end;

procedure TdxInplaceDropDownEdit.WMMouseWHeel(var Message: TWMMouse);
begin
//  inherited;
  if SmallInt(HIWORD(Message.Keys)) > 0 then
  begin
    if DroppedDown then
      if Assigned(ActiveList) then
        SendMessage(ActiveList.Handle, WM_VScroll, SB_LINEUP, 0)
      else
    else
      DoIncremental(-1, False);
  end
  else
  begin
    if DroppedDown then
      if Assigned(ActiveList) then
        SendMessage(ActiveList.Handle, WM_VScroll, SB_LINEDOWN, 0)
      else
    else
      DoIncremental(1, False);
  end;
end;

procedure TdxInplaceDropDownEdit.WMNCHitTest(var Message: TWMNCHitTest);
var
  FViewData: TdxEditViewData;
  ViewInfo: TdxEditViewInfo;
  I: Integer;
  BR, R: TRect;
  P: TPoint;
begin
  inherited;
  FViewData := CreateViewData(False);
  try
    if not (csDesigning in ComponentState) then
    begin
      P := SmallPointToPoint(Message.Pos);
      ScreenToWindow(Handle, P);
      CalcViewInfo(FViewData, False, ViewInfo);
      with ViewInfo do
      begin
        BR := BorderRect;
        InflateBorderRect(BR, ViewInfo, False);
      end;
      with TdxDropDownEditViewData(FViewData) do
        for I := ButtonCount - 1 downto 0 do
          with Buttons[I] do
          begin
            R := BR;
            if LeftAlignment then
            begin
              R.Right := R.Left + Width;
              BR.Left := R.Right;
            end
            else
            begin
              R.Left := R.Right - Width;
              BR.Right := R.Left;
            end;
            if PtInRect(R, P) and ((GetCapture = 0) or (FPressedButton <> -1)) then
            begin
              if (FPressedButton <> -1) and (I <> FPressedButton) then
                ActiveButton := -1
              else ActiveButton := I;
              Message.Result := HTBORDER;
              Exit;
            end;
          end;
    end;
    ActiveButton := -1;
  finally
    FViewData.Free;
  end;
end;

procedure TdxInplaceDropDownEdit.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  if FActiveButton <> -1 then
  begin
    DoButtonDown(False, FActiveButton);
    SetFocus;
//    with TMessage(Message) do
//      SendMessage(Handle, WM_LBUTTONDOWN, 0{MK_LBUTTON}, 0{LParam}); //TODO !!! RichEdit
  end;
end;

procedure TdxInplaceDropDownEdit.WMNCLButtonDblClk(var Message: TWMNCLButtonDown);
begin
  inherited;
  with TMessage(Message) do
    SendMessage(Handle, WM_NCLBUTTONDOWN, WParam, LParam);
end;

procedure TdxInplaceDropDownEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FActiveList) then
    CloseUp(False);
end;

procedure TdxInplaceDropDownEdit.CMDropDownPopup(var Message: TMessage);
begin
  DropDown;
end;

procedure TdxInplaceDropDownEdit.CMHidePopup(var Message: TMessage);
begin
  FListVisible := False;
end;

procedure TdxInplaceDropDownEdit.CMHintShow(var Message: TMessage);
begin
  Message.Result := Integer(DroppedDown);
end;

{ TdxInplaceDateEdit }
constructor TdxInplaceDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption]; 
  FSendChildrenStyle := False;
  FDate := NullDate;
  FDateDropDown := NullDate;
  FDateButtons := [btnToday, btnClear];
  FDateOnError := deNull;
  FSaveTime := True;
end;

destructor TdxInplaceDateEdit.Destroy;
begin
  if FDateNavigator <> nil then FDateNavigator.Free;
  inherited Destroy;
end;

function TdxInplaceDateEdit.GetEditingText: string;
begin
  Result := inherited GetEditingText;
  if IsMasked and (Result = GetBlankText) then
    Result := '';
end;

function TdxInplaceDateEdit.IsEnterValidate: Boolean;
begin
  Result := True;
end;

procedure TdxInplaceDateEdit.ValidateEdit;
var
  Str: string;
  ADate: TDateTime;
  AError: Boolean;
  AMessage: string;
  AValidation, AInvalid: Boolean;
begin
  if DateOnError = deToday then
    ADate := SysUtils.Date
  else ADate := NullDate;
  if Modified then
  begin
    Str := EditText;
    AValidation := DateValidation;
    // error in date ?
    AInvalid := False;
    if (IsMasked and (Str = GetBlankText)) or (not IsMasked and (Str = '' )) then
      ADate := NullDate
    else
      AInvalid := not TextToDateEx(Str, ADate);
    // check date (zB: ranges)
    if AValidation or AInvalid then
    begin
      if FCloseFlag then
      begin
        Reset;
        ADate := NullDate;
        EditText := '';
        Exit;
      end;
      AError := AValidation and AInvalid;
      // custom event
      AMessage := sdxDateError; // 'Invalid Date'
      DoValidateInput(Str, ADate, AMessage, AError);
      if AError then
      begin
        if not (csDesigning in ComponentState) then
        begin
          MaskState := MaskState + [msReEnter];
          if IsWindowVisible(Handle) then Windows.SetFocus(Handle);
        end;
        MessageBeep(0);
        raise Exception.Create(AMessage);
      end;
    end;
    Date := ADate;
    Modified := True;
  end;
  inherited ValidateEdit;
end;

procedure TdxInplaceDateEdit.AssignEditValue(const Value: Variant);
begin
  FInternalChanging := True;
  try
    if ((VarType(Value) = varString) and (Value = '')) or VarIsNull(Value) then
      SetValue(NullDate)
    else SetValue(Value);
  finally
    FInternalChanging := False;
  end;
end;

procedure TdxInplaceDateEdit.Change;
begin
  if FInternalChanging then Exit;
  inherited Change;
  FTextChanged := True;
end;

procedure TdxInplaceDateEdit.DateChange(Sender: TObject);
var
  ADate: TDateTime;
begin
  ADate := TdxGridDatePopup(Sender).SelStart;
  if SaveTime and (ADate <> NullDate) then
    if ADate >= 0 then
      ADate := ADate + TimeOf(FDateDropDown)
    else ADate := ADate - TimeOf(FDateDropDown);
  Date := ADate;
  Modified := True; 
end;

procedure TdxInplaceDateEdit.DoValidateInput(const AText: string; var ADate: TDateTime;
  var AMessage: string; var AError: Boolean);
begin
  if Assigned(FOnDateValidateInput) then
    FOnDateValidateInput(Self, AText, ADate, AMessage, AError);
end;

type TWinControlCrack = class(TWinControl);

procedure TdxInplaceDateEdit.DropDown;
var
  ADate: TDateTime;
begin
  if FListVisible or not CanModify then Exit;
  if FDateNavigator = nil then
    FDateNavigator := TdxGridDatePopup.Create(nil)
  else TWinControlCrack(FDateNavigator).DestroyHandle;
  FDateNavigator.OwnerControl := Self;
  FActiveList := FDateNavigator;
  EditButtonClick; // TODO: assign properties to Popup?
  with FDateNavigator do
  begin
    PopupBorderStyle := Self.PopupBorderStyle;
    Shadow := Self.Style.Shadow;
    Font := Self.Font;
    ShowTodayButton := btnToday in DateButtons;
    ShowClearButton := btnClear in DateButtons;
    if Assigned(DataDefinition) and DataDefinition.Required then
      ShowClearButton := False;
    OnDateTimeChanged := nil;
    if not (IsMasked and (Self.Text = GetBlankText)) and TextToDateEx(Self.Text, ADate) then
      FDateDropDown := ADate
    else
      ADate := SysUtils.Date;
    if FDateDropDown <> NullDate then
      ADate := DateOf(FDateDropDown);
    FirstDate := ADate;
    SelStart := ADate;
    OnDateTimeChanged := DateChange;
    SetSize;
    CalcPosition(FDateNavigator, False);
    FListVisible := True;
    ShowPopup;
  end;
end;

function TdxInplaceDateEdit.GetDisableCloseEditor: Boolean;
begin
  Result := False;
end;

function TdxInplaceDateEdit.ReturnEditValue: Variant;
begin
  if Date = NullDate then
    Result := Null
  else Result := Date;
end;

function TdxInplaceDateEdit.GetDate: TDateTime;
begin
  Result := FDate;
end;

procedure TdxInplaceDateEdit.SetDate(Value: TDateTime);
begin
  if (FDate <> Value) or FTextChanged then
  begin
    if Assigned(Container) and Container.IsInitEdit then
      SetValue(Value)
    else
      if EditCanModify then
        SetValue(Value);
  end;
end;

procedure TdxInplaceDateEdit.SetDateEditMask;
begin
  FInternalChanging := True;
  try
    Clear;
    if FUseEditMask then
      EditMask := GetDateEditMask
    else
    begin
      EditMask := '';
      Exclude(FStoredValues, svEditMask);
    end;
    SetValue(Date);
  finally
    FInternalChanging := False;
  end;
end;

procedure TdxInplaceDateEdit.SetUseEditMask(Value: Boolean);
begin
  if FUseEditMask <> Value then
  begin
    FUseEditMask := Value;
    SetDateEditMask;
  end;
end;

procedure TdxInplaceDateEdit.SetValue(Value: TDateTime);
var
  PrevDate: TDateTime;
begin
  PrevDate := FDate;
  FDate := Value;
  Text := DateTimeToTextEx(FDate, IsMasked);
  FTextChanged := False;
  if not FInternalChanging and (FDate <> PrevDate) and Assigned(FOnDateChange) then
    FOnDateChange(Self);
end;

procedure TdxInplaceDateEdit.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  if not Application.UpdateFormatSettings then Exit;
  SysUtils.GetFormatSettings; // TODO? StartOfWeek
  RetrieveStartOfWeek;
  SetDateEditMask;
end;

{ TdxInplaceButtonEdit }
constructor TdxEditButton.Create(Collection: TCollection);
begin
  if Assigned(Collection) and (Collection.Count >= dxEditButtonCount) then
    raise Exception.CreateFmt('Too many buttons ( >= %d)', [dxEditButtonCount]);
  FVisible := True;
  inherited Create(Collection);
end;

destructor TdxEditButton.Destroy;
begin
  if FGlyph <> nil then FGlyph.Free;
  inherited Destroy;
end;

procedure TdxEditButton.Assign(Source: TPersistent);
begin
  if Source is TdxEditButton then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      Default := TdxEditButton(Source).Default;
      Glyph := TdxEditButton(Source).Glyph;
      Kind := TdxEditButton(Source).Kind;
      LeftAlignment := TdxEditButton(Source).LeftAlignment;
      Visible := TdxEditButton(Source).Visible;
      Width := TdxEditButton(Source).Width;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxEditButton.RestoreDefaults;
begin
  FGlyph.Free;
  FGlyph := nil;
  FKind := bkEllipsis;
  FLeftAlignment := False;
  FVisible := True;
  FWidth := 0;
end;

function TdxEditButton.GetGlyph: TBitmap;
begin
  if FGlyph = nil then
    FGlyph := TBitmap.Create;
  Result := FGlyph;
end;

procedure TdxEditButton.SetDefault(Value: Boolean);
var
  I: Integer;
begin
  if FDefault <> Value then
  begin
    if Value and Assigned(Collection) and (Collection is TdxEditButtons) then
      with Collection as TdxEditButtons do
        for I := 0 to Count - 1 do
          Items[I].FDefault := False;
    FDefault := Value;
    Changed(True);
  end;
end;

procedure TdxEditButton.SetGlyph(Value: TBitmap);
begin
  if (Value = nil) then
  begin
    FGlyph.Free;
    FGlyph := nil;
  end
  else
    Glyph.Assign(Value);
  Changed(True);
end;

procedure TdxEditButton.SetKind(Value: TdxEditButtonKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    Changed(True);
  end;
end;

procedure TdxEditButton.SetLeftAlignment(Value: Boolean);
begin
  if FLeftAlignment <> Value then
  begin
    FLeftAlignment := Value;
    Changed(True);
  end;
end;

procedure TdxEditButton.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;

procedure TdxEditButton.SetWidth(Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed(True);
  end;
end;

constructor TdxEditButtons.Create(AOwner: TComponent; EditButtonClass: TdxEditButtonClass);
begin
  inherited Create(EditButtonClass);
  FOwner := AOwner;
end;

function TdxEditButtons.Add: TdxEditButton;
begin
  Result := TdxEditButton(inherited Add);
end;

function TdxEditButtons.GetAbsoluteIndex(VisibleIndex: Integer): Integer;
var
  I, J: Integer;
begin
  Result := -1;
  J := -1;
  for I := 0 to Count - 1 do
  begin
    if TdxEditButton(Items[I]).Visible then Inc(J);
    if J = VisibleIndex then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TdxEditButtons.GetVisibleIndex(AbsoluteIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  if (AbsoluteIndex < Count) and (TdxEditButton(Items[AbsoluteIndex]).Visible) then
    for I := 0 to AbsoluteIndex do
      if TdxEditButton(Items[I]).Visible then
        Inc(Result);
end;

procedure TdxEditButtons.RestoreDefaults;
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

function TdxEditButtons.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TdxEditButtons.Update(Item: TCollectionItem);
begin
  if FOwner = nil then Exit;
  if csLoading in FOwner.ComponentState then Exit;
  // recalculate fixed
  if Count = 1 then
    Items[0].FDefault := True;
end;

function TdxEditButtons.GetItem(Index: Integer): TdxEditButton;
begin
  Result := TdxEditButton(inherited GetItem(Index));
end;

function TdxEditButtons.GetVisibleCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if TdxEditButton(Items[I]).Visible then
      Inc(Result);
end;

function TdxEditButtons.GetVisibleItem(Index: Integer): TdxEditButton;
var
  I: Integer;
begin
  Result := nil;
  I := GetAbsoluteIndex(Index);
  if I <> -1 then
    Result := Items[I];
end;

procedure TdxEditButtons.SetItem(Index: Integer; Value: TdxEditButton);
begin
  inherited SetItem(Index, Value);
end;

procedure TdxEditButtons.SetVisibleItem(Index: Integer; Value: TdxEditButton);
var
  I :Integer;
begin
  I := GetAbsoluteIndex(Index);
  if I <> -1 then
    inherited SetItem(i, Value);
end;

type
  TdxInplaceEditButtons = class(TdxEditButtons)
    procedure Update(Item: TCollectionItem); override;
  end;

procedure TdxInplaceEditButtons.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Owner is TdxInplaceButtonEdit then
    (Owner as TdxInplaceButtonEdit).StyleChanged;
end;

constructor TdxInplaceButtonEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TdxInplaceEditButtons.Create(Self, TdxEditButton);
  FButtons.Add;
  FClickKey := VK_RETURN + scCtrl;
end;

destructor TdxInplaceButtonEdit.Destroy;
begin
  FButtons.Free;
  inherited Destroy;
end;

procedure TdxInplaceButtonEdit.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ExistButtons', ReadExistButtons, WriteExistButtons, Buttons.Count > 0);
end;

procedure TdxInplaceButtonEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not IsEditClass {ButtonOnly} then
  begin
    case Key of
      VK_LEFT: MoveCol(True{Left});
      VK_RIGHT: MoveCol(False);
    end;
  end;
  if (Buttons.Count > 0) and (ClickKey = ShortCut(Key, Shift)) then
  begin
    KillMessage(Handle, WM_CHAR);
    DefaultButtonClick;
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceButtonEdit.Loaded;
begin
  inherited Loaded;
  if not FExistButtons then Buttons.Clear;
end;

class procedure TdxInplaceButtonEdit.CalcButtonsInfo(AViewData: TdxEditViewData);
var
  ViewInfo: TdxEditViewInfo;
  R: TRect;
  I, W: Integer;
begin
  inherited CalcButtonsInfo(AViewData);
  with TdxButtonEditViewData(AViewData) do
    if (EditButtons <> nil) and not HideButtons then
    begin
      ButtonCount := EditButtons.VisibleCount;
      for I := 0 to ButtonCount - 1 do
        with Buttons[I] do
        begin
          Glyph := EditButtons.VisibleItems[I].Glyph;
          Index := I;
          Kind := EditButtons.VisibleItems[I].Kind;
          LeftAlignment := EditButtons.VisibleItems[I].LeftAlignment;
          Width := EditButtons.VisibleItems[I].Width;
          if Width = 0 then
            Width := CalcDefaultButtonWidth(AViewData, Buttons[I]);
        end;
      // Correct Button Width
      if ButtonOnly then
      begin
        CalcBoundsInfo(AViewData, ViewInfo);
        R := ViewInfo.ClientBounds;
        W := 0;
        for I := 0 to ButtonCount - 1 do
          Inc(W, Buttons[I].Width);
        if W < (R.Right - R.Left) then
          Inc(Buttons[ButtonCount - 1].Width, (R.Right - R.Left) - W);
      end;
    end;
end;

class procedure TdxInplaceButtonEdit.CalcViewInfo(AViewData: TdxEditViewData;
  AutoSize: Boolean; var ViewInfo: TdxEditViewInfo);
begin
  inherited CalcViewInfo(AViewData, AutoSize, ViewInfo);
  with TdxButtonEditViewData(AViewData), ViewInfo.ClientBounds do
    if ButtonOnly then
      Right := Left;       
end;

class function TdxInplaceButtonEdit.DrawClientArea(ADC: HDC; var ARect: TRect;
  AViewData: TdxEditViewData; IsControl: Boolean): Boolean;
begin
  with TdxButtonEditViewData(AViewData) do
  begin
    if HideEditCursor then
      IsControl := False;
    Result := inherited DrawClientArea(ADC, ARect, AViewData, IsControl);
  end;
end;

function TdxInplaceButtonEdit.IsEditClass: Boolean;
begin
  Result := FViewStyle = vsStandard;
end;

function TdxInplaceButtonEdit.IsResetTextClass: Boolean;
begin
  Result := True;
end;

function TdxInplaceButtonEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxButtonEditViewData(Result) do
  begin
    EditButtons := Self.Buttons;
//    FocusRect := not IsInplace and not IsEditClass;
    ButtonOnly := (ViewStyle = vsButtonOnly) and (Self.Buttons.Count > 0);
    HideEditCursor := not IsEditClass;
  end;
end;

procedure TdxInplaceButtonEdit.DefaultButtonClick;
var
  AIndex, I: Integer;
begin
  AIndex := -1;
  with Buttons do
    for I := 0 to VisibleCount - 1 do
      if VisibleItems[I].Default then
      begin
        AIndex := I{GetVisibleIndex(Items[I].Index)};
        Break;
      end;
  if AIndex <> -1 then
    DoButtonUp(AIndex);
end;

procedure TdxInplaceButtonEdit.DoButtonUp(Index: Integer);
begin
  if Assigned(FOnButtonClick) then
    with Buttons do
      if (0 <= Index) and (Index < VisibleCount) then
        with VisibleItems[Index] do
          FOnButtonClick(Self, Index);
  // obsolete FOnEditButtonClick
  EditButtonClick;
end;

procedure TdxInplaceButtonEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
end;

class function TdxInplaceButtonEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxButtonEditViewData;
end;

// private TdxInplaceButtonEdit
procedure TdxInplaceButtonEdit.ReadExistButtons(Reader: TReader);
begin
  FExistButtons := Reader.ReadBoolean;
end;

procedure TdxInplaceButtonEdit.SetButtons(Value: TdxEditButtons);
begin
  Buttons.Assign(Value);
end;

procedure TdxInplaceButtonEdit.SetViewStyle(Value: TdxButtonEditViewStyle);
begin
  if FViewStyle <> Value then
  begin
    FViewStyle := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceButtonEdit.WriteExistButtons(Writer: TWriter);
begin
  Writer.WriteBoolean(Buttons.Count > 0);
end;

procedure TdxInplaceButtonEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if IsInplace then
    Message.Result := Message.Result or DLGC_WANTARROWS;
end;

{ TdxCheckEditStyleController }

constructor TdxCheckEditStyleController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderStyle := xbsNone;
  ButtonStyle := bts3D;
end;

procedure TdxCheckEditStyleController.RestoreDefaults;
begin
  BeginUpdate;
  try
    inherited RestoreDefaults;
    BorderStyle := xbsNone;
    ButtonStyle := bts3D;
  finally
    EndUpdate;
  end;
end;

{ TdxInplaceCheckEdit }

class function TdxCheckEditStyle.GetDefaultEditStyleController: TdxEditStyleController;
begin
  Result := DefaultCheckEditStyleController;
end;

constructor TdxInplaceCheckEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [{csClickEvents, }csSetCaption, csDoubleClicks];
  FGlyphCount := 6;
  FNullStyle := nsGrayedChecked;
  FState := cbsUnchecked;
end;

destructor TdxInplaceCheckEdit.Destroy;
begin
  FGlyph.Free;
  FGlyph := nil;
  inherited Destroy;
end;

class function TdxInplaceCheckEdit.CalcCheckSize(AGlyph: TBitmap; AGlyphCount: Integer;
  var ACheckWidth, ACheckHeight: Integer): Boolean;
begin
  ACheckWidth := FCheckWidth;
  ACheckHeight := FCheckHeight;
  Result := (AGlyphCount > 0) and (AGlyph <> nil) and not AGlyph.Empty;
  if Result then
  begin
    ACheckWidth := AGlyph.Width div AGlyphCount;
    ACheckHeight := AGlyph.Height;
  end;
end;

class function TdxInplaceCheckEdit.DrawClientArea(ADC: HDC; var ARect: TRect;
  AViewData: TdxEditViewData; IsControl: Boolean): Boolean;
const
  ShowStyle: array [TdxShowNullFieldStyle] of Integer = (0, DFCS_INACTIVE, DFCS_CHECKED);
  Border3DStyle: array [Boolean] of Integer = (DFCS_FLAT, 0);
  GlyphIndex: array [TdxCheckBoxState] of Integer = (0, 1, 2);
var
  Flags: Integer;
  R, RC: TRect;
  PrevClipRgn: HRgn;
  IsClipRgnExists, IsGlyph: Boolean;
  ACheckWidth, ACheckHeight: Integer;
  AGlyphIndex: Integer;

  procedure DrawBitmap(DrawDC: HDC; Brush: HBRUSH; const R: TRect; ABitmap: TBitmap; Index: Integer);
  const
    ROP_DSPDxax = $00E20746;
  var
    BW, BH: Integer;
    DC, MaskDC: HDC;
    B, MaskHandle: HBITMAP;
    ATextColor, ABackColor: COLORREF;
    ABrush: HBRUSH;
  begin
    with R do
    begin
      BW := ACheckWidth;
      BH := ACheckHeight;
      DC := CreateCompatibleDC(DrawDC);
      B := SelectObject(DC, CreateCompatibleBitmap(DrawDC, BW, BH));
      try
        BitBlt(DC, 0, 0, BW, BH, ABitmap.Canvas.Handle, Index * BW, 0, SRCCOPY);
        MaskDC := CreateCompatibleDC(DrawDC);
        MaskHandle := SelectObject(MaskDC, CreateBitmap(BW, BH, 1, 1, nil));
        try
          ABackColor := SetBkColor(DC, ColorToRGB(ABitmap.TransparentColor));
          BitBlt(MaskDC, 0, 0, BW, BH, DC, 0, 0, SRCCOPY);
          SetBkColor(DC, ABackColor);
          ATextColor := SetTextColor(DC, 0);
          ABackColor := SetBkColor(DC, $FFFFFF);
          ABrush := SelectObject(DC, Brush);
          BitBlt(DC, 0, 0, BW, BH, MaskDC, 0, 0, ROP_DSPDxax);
          SelectObject(DC, ABrush);
          SetTextColor(DC, ATextColor);
          SetBkColor(DC, ABackColor);
        finally
          DeleteObject(SelectObject(MaskDC, MaskHandle));
          DeleteDC(MaskDC);
        end;
        BitBlt(DrawDC, Left, Top, Right - Left, Bottom - Top, DC, 0, 0, SRCCOPY);
      finally
        DeleteObject(SelectObject(DC, B));
        DeleteDC(DC);
      end;
    end;
  end;

begin
  // TODO remove flicker if IsGlyph
  with TdxCheckEditViewData(AViewData) do
  begin
    IsGlyph := CalcCheckSize(Glyph, GlyphCount, ACheckWidth, ACheckHeight);
    if CalcHeight then
    begin
      LineCount := 1;
      if IsGlyph then
        LineHeight := ACheckHeight
      else LineHeight := FCheckHeight;// + 2; // TODO ?
    end
    else
    begin
      R := ARect;
      CalcCheckRect(ACheckWidth, ACheckHeight, Alignment, R, RC);
      // Draw Background and Caption
      if Alignment = taCenter then
      begin
        if not Transparent then FillRect(ADC, R, Brush);
      end
      else
      begin
        if Enabled then
          DrawTextRect(ADC, Caption, Length(Caption), ARect, R,
            DX_DTR_PREFIX or DX_DTR_LEFT or DrawAlignmentFlags[DrawAlignment] or
            FocusFlags[Focused] or ExactFocusFlags[ExactFocusRect] or TransparentFlags[Transparent],
            Brush, Font, BkColor, TextColor, nil)
        else
        begin
          OffsetRect(R, 1, 1);
          DrawTextRect(ADC, Caption, Length(Caption), ARect, R,
            DX_DTR_PREFIX or DX_DTR_LEFT or DrawAlignmentFlags[DrawAlignment] or
            FocusFlags[Focused] or ExactFocusFlags[ExactFocusRect] or TransparentFlags[Transparent],
            Brush, Font, BkColor, GetSysColor(COLOR_BTNHIGHLIGHT), nil);
          OffsetRect(R, -1, -1);
          DrawTextRect(ADC, Caption, Length(Caption), ARect, R,
            DX_DTR_PREFIX or DX_DTR_LEFT or DrawAlignmentFlags[DrawAlignment] or
            FocusFlags[Focused] or ExactFocusFlags[ExactFocusRect] or TransparentFlags[True{!}],
            Brush, Font, BkColor, GetSysColor(COLOR_BTNSHADOW), nil);
        end;
      end;
      // Draw Check
      if not Enabled then
      begin
        Flags := DFCS_BUTTON3STATE or DFCS_PUSHED;
        case TdxCheckBoxState(Data) of
          cbsUnchecked: Flags := Flags or DFCS_INACTIVE;
        else
          Flags := Flags or DFCS_CHECKED;
        end;
      end
      else
      begin
        Flags := 0;
        case TdxCheckBoxState(Data) of
          cbsGrayed: Flags := DFCS_BUTTON3STATE or ShowStyle[NullStyle];
          cbsChecked: Flags := DFCS_CHECKED;
        end;
        if Pressed then
          Flags := Flags or DFCS_PUSHED;
      end;
      if IsGlyph then
      begin
        AGlyphIndex := GlyphIndex[TdxCheckBoxState(Data)];
        if Pressed then
          Inc(AGlyphIndex, 3);
        while (AGlyphIndex >= GlyphCount) and (AGlyphIndex > 2) do
          AGlyphIndex := AGlyphIndex mod 3;
        DrawBitmap(ADC, Brush, RC, Glyph, AGlyphIndex);
      end
      else
      begin
        PrevClipRgn := 0;
        IsClipRgnExists := False;
        if ButtonStyle in [btsFlat, btsSimple] then
        begin
          PrevClipRgn := CreateRectRgn(0, 0, 0, 0); // TODO Global RGN?
          IsClipRgnExists := GetClipRgn(ADC, PrevClipRgn) = 1;
          {calc rect}
          if ButtonStyle = btsFlat then
            InflateRect(RC, -1, -1);
          R := RC;
          IntersectClipRect(ADC, R.Left, R.Top, R.Right, R.Bottom);
          InflateRect(RC, 1, 1);
        end;
        DrawFrameControl(ADC, RC, DFC_BUTTON, DFCS_BUTTONCHECK or Flags or Border3DStyle[ButtonStyle = bts3D]);
        if ButtonStyle in [btsFlat, btsSimple] then
        begin
          if IsClipRgnExists then
            SelectClipRgn(ADC, PrevClipRgn)
          else
            SelectClipRgn(ADC, 0);
          DeleteObject(PrevClipRgn);
          if ButtonStyle = btsFlat then
          begin
            DrawEdge(ADC, RC, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST);
            DrawEdge(ADC, RC, BDR_SUNKENINNER, BF_RECT or BF_FLAT);
          end
          else
          begin
            InflateRect(RC, -1, -1);
            FrameRect(ADC, RC, GetSysColorBrush(COLOR_BTNSHADOW));
          end;
        end;
      end;
    end;
  end;  
  Result := True;
end;

class function TdxInplaceCheckEdit.GetMinHeight(AViewData: TdxEditViewData): Integer;
const
  DrawAlignmentFlags: array [TdxDrawAlignment] of Integer = (
    DX_DTR_SINGLELINE or DX_DTR_TOP,
    DX_DTR_SINGLELINE or DX_DTR_TOP,
    DX_DTR_SINGLELINE or DX_DTR_TOP,
    DX_DTR_MULTILINE);
var
  DC: HDC;
  ViewInfo: TdxEditViewInfo;
  R, RC: TRect;
  W, H: Integer;
begin
  Result := inherited GetMinHeight(AViewData);
  if Result < FCheckHeight then
    Result := FCheckHeight;
  with TdxCheckEditViewData(AViewData) do
  begin
    if (Glyph <> nil) and not Glyph.Empty then
    begin
      if Result < Glyph.Height then
        Result := Glyph.Height;
    end;
    // MultiLine
    if Alignment <> taCenter {Exist Text} then
    begin
      DC := GetDC(0);
      try
        CalcBoundsInfo(AViewData, ViewInfo);
        R := ViewInfo.ClientBounds;
        CalcCheckSize(Glyph, GlyphCount, W, H);
        CalcCheckRect(W, H, Alignment, R, RC);
        H := DrawTextRect(DC, Caption, Length(Caption), R, R,
          DX_DTR_PREFIX or DX_DTR_LEFT or DrawAlignmentFlags[DrawAlignment] or FocusFlags[Focused] or
          ExactFocusFlags[ExactFocusRect] or TransparentFlags[Transparent] or DX_DTR_CALCRECT{!},
          Brush, Font, BkColor, TextColor, nil);
        Inc(H, 4); // !!! TODO
        if Result < H then Result := H;
      finally
        ReleaseDC(0, DC);
      end;
    end;
  end;
end;

procedure TdxInplaceCheckEdit.MouseClick;
begin
  Toggle;
end;

procedure TdxInplaceCheckEdit.Click;
begin
  if FInternalChanging then Exit;
  inherited Click;
  Change;
end;

procedure TdxInplaceCheckEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_LEFT: MoveCol(True{Left});
    VK_RIGHT: MoveCol(False);
    VK_SPACE:
      if not FPressed then
      begin
        FPressed := True;
        InvalidateCheckRect;
      end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceCheckEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if IsInplace and (Key = #32) and not FPressed and CanModify then
    Toggle;
end;

procedure TdxInplaceCheckEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_SPACE:
      if FPressed then
      begin
        FPressed := False;
        InvalidateCheckRect;
        if CanModify then Toggle;
      end;
  end;
  inherited KeyUp(Key, Shift);
end;

procedure TdxInplaceCheckEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then
  begin
    MouseCapture := True;
    FTracking := True;
    TrackButton(X, Y);
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdxInplaceCheckEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FTracking then TrackButton(X, Y);
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxInplaceCheckEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  if (Button = mbLeft) and WasPressed and CanModify then Toggle;
  inherited MouseUp(Button, Shift, X, Y);
end;

// virtual methods
procedure TdxInplaceCheckEdit.AssignEditValue(const Value: Variant);
var
  PrevModified: Boolean;
begin
  PrevModified := Modified;
  FInternalChanging := True;
  try
    State := Value;
  finally
    FInternalChanging := False;
    Modified := PrevModified;
  end;
end;

class procedure TdxInplaceCheckEdit.CalcCheckRect(ACheckWidth, ACheckHeight: Integer;
  AAlignment: TAlignment; var R, RC: TRect);
begin
  // Draw Background and Caption
  if AAlignment = taCenter then
  begin
    with R do
    begin
      RC.Left := (Left + Right - ACheckWidth) div 2;
      RC.Top := (Top + Bottom - ACheckHeight) div 2;
      RC.Right := RC.Left + ACheckWidth;
      RC.Bottom := RC.Top + ACheckHeight;
    end;
  end
  else
  begin
    InflateRect(R, -2, -2);
    with R do
    begin
      RC.Top := (Top + Bottom - ACheckHeight) div 2;
      RC.Bottom := RC.Top + ACheckHeight;
      if AAlignment = taLeftJustify then
      begin
        RC.Left := Left;
        Inc(R.Left, ACheckWidth + 2 + 1);
      end
      else
      begin
        RC.Left := R.Right - ACheckWidth;
        Dec(R.Right, ACheckWidth + 2 + 1);
      end;
      RC.Right := RC.Left + ACheckWidth;
    end;
  end;
end;

function TdxInplaceCheckEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxCheckEditViewData(Result) do
  begin
    if not MultiLine then
      DrawAlignment := daVCenter
    else DrawAlignment := daMultiLine;
    Caption := Self.Caption;
    ExactFocusRect := not FullFocusRect;
    Glyph := FGlyph;
    GlyphCount := FGlyphCount;
    NullStyle := Self.NullStyle;
    Pressed := FPressed;
    Alignment := Self.Alignment; // DataDefinition disabled
//    Data := State;
  end;
end;

class function TdxInplaceCheckEdit.GetEditStyleClass: TdxEditStyleClass;
begin
  Result := TdxCheckEditStyle;
end;

class function TdxInplaceCheckEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxCheckEditViewData;
end;

procedure TdxInplaceCheckEdit.InvalidateCheckRect;
var
  W, H: Integer;
  R, RC: TRect;
begin
  if HandleAllocated then
  begin
    R := ClientRect;
    CalcCheckSize(Glyph, GlyphCount, W, H);
    CalcCheckRect(W, H, Alignment, R, RC);
    InvalidateRect(Handle, @RC, False);
  end;
end;

procedure TdxInplaceCheckEdit.LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean);
begin
  Data := State;
end;

function TdxInplaceCheckEdit.ReturnEditValue: Variant;
begin
  Result := State;
end;

procedure TdxInplaceCheckEdit.Toggle;
begin
  if EditCanModify then
  begin
    case State of
      cbsUnchecked:
        if AllowGrayed then
          State := cbsGrayed
        else State := cbsChecked;
      cbsChecked: State := cbsUnchecked;
      cbsGrayed: State := cbsChecked;
    end;
    Modified := True;
  end;
end;

// private TdxInplaceCheckEdit
function TdxInplaceCheckEdit.GetChecked: Boolean;
begin
  Result := State = cbsChecked;
end;

function TdxInplaceCheckEdit.GetGlyph: TBitmap;
begin
  if FGlyph = nil then
    FGlyph := TBitmap.Create;
  Result := FGlyph;
end;

procedure TdxInplaceCheckEdit.SetChecked(Value: Boolean);
begin
  if Value then
    State := cbsChecked
  else State := cbsUnchecked;
end;

procedure TdxInplaceCheckEdit.SetFullFocusRect(Value: Boolean);
begin
  if FFullFocusRect <> Value then
  begin
    FFullFocusRect := Value;
    InvalidateClientRect;
  end;
end;

procedure TdxInplaceCheckEdit.SetGlyph(Value: TBitmap);
begin
  if (Value = nil) then
  begin
    FGlyph.Free;
    FGlyph := nil;
  end
  else
    Glyph.Assign(Value);
  StyleChanged;
end;

procedure TdxInplaceCheckEdit.SetGlyphCount(Value: Integer);
begin
  if FGlyphCount <> Value then
  begin
    FGlyphCount := Value;
    if FGlyph <> nil then
      StyleChanged;
  end;
end;

procedure TdxInplaceCheckEdit.SetMultiLine(Value: Boolean);
begin
  if FMultiLine <> Value then
  begin
    FMultiLine := Value;
    if not AutoSize then
      InvalidateClientRect
    else StyleChanged;
  end;
end;

procedure TdxInplaceCheckEdit.SetNullStyle(Value: TdxShowNullFieldStyle);
begin
  if FNullStyle <> Value then
  begin
    FNullStyle := Value;
    InvalidateCheckRect;
  end;
end;

procedure TdxInplaceCheckEdit.SetState(Value: TdxCheckBoxState);
begin
  if FState <> Value then
  begin
    FState := Value;
    InvalidateCheckRect;
    if not (csLoading in ComponentState) then
      Click;
  end;
end;

procedure TdxInplaceCheckEdit.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TdxInplaceCheckEdit.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ClientRect;
  NewState := PtInRect(R, Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateCheckRect;
  end;
end;

procedure TdxInplaceCheckEdit.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TdxInplaceCheckEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if IsInplace then
    Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTALLKEYS 
  else Message.Result := Message.Result and not DLGC_WANTCHARS;
end;

procedure TdxInplaceCheckEdit.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) {D3 - bug "&&"} and CanFocus then
    begin
      SetFocus;
      if Focused then Toggle;
      Result := 1;
    end else
      inherited;
end;

procedure TdxInplaceCheckEdit.CMTextChanged(var Message: TMessage);
begin
  inherited;
  StyleChanged;
end;

{ TdxInplaceImageEdit }
constructor TdxInplaceImageEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csCaptureMouse]; // TODO SetImmediatePopupStyle
  FPopupListBox := TdxPopupImageListBox.Create(Self);
  with FPopupListBox do
  begin
    Visible := False;
    ControlStyle := ControlStyle + [csReplicatable];
    OnMouseUp := ListMouseUp;
  end;
  FImmediatePopupStyle := True;
  FDefaultImages := True;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FLargeImageChangeLink := TChangeLink.Create;
  FLargeImageChangeLink.OnChange := ImageListChange;
  FShowDescription := True;
  FImageIndexes := TStringList.Create;
  FValues := TStringList.Create;
  FDescriptions := TStringList.Create;
end;

destructor TdxInplaceImageEdit.Destroy;
begin
  FDescriptions.Free;
  FValues.Free;
  FImageIndexes.Free;
  FImageChangeLink.Free;
  FLargeImageChangeLink.Free;
  inherited Destroy;
end;

class procedure TdxInplaceImageEdit.CalcViewIndexes(const Value: string;
  AImageIndexes, ADescriptions, AValues: TStrings; ADefaultImages: Boolean;
  var AImageIndex, ADescIndex: Integer);
begin
  AImageIndex := AValues.IndexOf(Value);
  if AImageIndex < ADescriptions.Count then
    ADescIndex := AImageIndex
  else ADescIndex := -1;
  if not ADefaultImages and (0 <= AImageIndex) and (AImageIndex < AImageIndexes.Count) then
  try
    AImageIndex := StrToInt(AImageIndexes[AImageIndex]);
  except
    AImageIndex := -1;
  end;
end;

class function TdxInplaceImageEdit.DrawClientArea(ADC: HDC; var ARect: TRect;
  AViewData: TdxEditViewData; IsControl: Boolean): Boolean;
var
  R: TRect;
  W, H: Integer;
  ImageIndex, DescIndex: Integer;
begin
//  IsControl := False;
  with TdxImageEditViewData(AViewData) do
  begin
    CalcViewIndexes(Data, ImageIndexes, Descriptions, Values,
      DefaultImages, ImageIndex, DescIndex);
    if Images <> nil then
    begin
      W := Images.Width;
      H := Images.Height;
    end
    else
    begin
      W := 0;
      H := 0;
    end;
    if not ShowDescription then
    begin
      if W <> 0 then
      begin
        with ARect do
        begin
          R.Left := (Left + Right - W) div 2;
          R.Top := (Top + Bottom - H) div 2;
          R.Right := R.Left + W;
          R.Bottom := R.Top + H;
        end;
        if not CalcHeight then // Draw
        begin
          if not Transparent then
            FillRect(ADC, ARect, Brush);
          if (Images <> nil) and (0 <= ImageIndex) and (ImageIndex < Images.Count) then
            DrawImage(ADC, R.Left, R.Top, ImageIndex, Images);
        end;
        Transparent := True;
      end;
      Data := '';
    end
    else
    begin
      if DescIndex <> -1 then
        Data := Descriptions[DescIndex];
      if W <> 0 then
      begin
        R := ARect;
        R.Left := ARect.Left;
        R.Right := R.Left + W;
        ARect.Left := R.Right;
        if not CalcHeight then // Draw
        begin
          if not Transparent then
            FillRect(ADC, R, Brush);
          with ARect do
          begin
            R.Top := (Top + Bottom - H) div 2;
            R.Bottom := R.Top + H;
          end;
          if (Images <> nil) and (0 <= ImageIndex) and (ImageIndex < Images.Count) then
            DrawImage(ADC, R.Left, R.Top, ImageIndex, Images);
        end;    
      end;
    end;
  end;
  Result := inherited DrawClientArea(ADC, ARect, AViewData, IsControl);
end;

class function TdxInplaceImageEdit.GetMinHeight(AViewData: TdxEditViewData): Integer;
begin
  Result := inherited GetMinHeight(AViewData);
  with TdxImageEditViewData(AViewData) do
    if (Images <> nil) and (Result < Images.Height) then
      Result := Images.Height;
end;

function TdxInplaceImageEdit.IsEditClass: Boolean;
begin
  Result := False;
end;

function TdxInplaceImageEdit.IsResetTextClass: Boolean;
begin
  Result := True;
end;

procedure TdxInplaceImageEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SeekTo(Index: Integer);
  begin
    if (0 <= Index) and (Index < Values.Count) then
      SetValue(Values[Index]);
  end;

  procedure MoveTo(Distance: Integer);
  begin
    DoIncremental(Distance, False);
  end;

begin
  if (not IsInplace or Incremental) and (Key in [VK_HOME, VK_END, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN, VK_PRIOR, VK_NEXT]) then
  begin
    case Key of
      VK_HOME: SeekTo(0);
      VK_END: SeekTo(Values.Count - 1);
      VK_LEFT, VK_UP: MoveTo(-1);
      VK_RIGHT, VK_DOWN: MoveTo(1);
      VK_PRIOR: MoveTo(- (DropDownRows - 1));
      VK_NEXT: MoveTo((DropDownRows - 1));
    end;
    Key := 0;
  end;
  if IsInplace then
    case Key of
      VK_LEFT: MoveCol(True);
      VK_RIGHT: MoveCol(False);
    end;
  inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceImageEdit.KeyPress(var Key: Char);

  function FindItem(StartIndex: Integer; const S: string): Integer;
  var
    I, L: Integer;
  begin
    Result := -1;
    if Descriptions.Count > 0 then
    begin
      L := Length(S);
      for I := StartIndex to Descriptions.Count - 1 do
      begin
        if AnsiCompareText(Copy(Descriptions[I], 1, L), S) = 0 then
        begin
          Result := I;
          Exit;
        end;
      end;
      for I := 0  to StartIndex - 1 do
      begin
        if AnsiCompareText(Copy(Descriptions[I], 1, L), S) = 0 then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;

  procedure Find(const S: string); // TODO
  var
    I, J: Integer;
  begin
    if Values.Count > 0 then
    begin
      I := Values.IndexOf(Text);
      if I <> -1 then
        J := FindItem(I + 1, S)
      else J := FindItem(0, S);   
      if (J <> -1) and (J <> I) then
        SetValue(Values[J]);
    end;
  end;

begin
  inherited KeyPress(Key);
  // Find Items as in ComboBox TODO Option
  Find(Key);
end;

procedure TdxInplaceImageEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = LargeImages then LargeImages := nil;
  end;
end;

procedure TdxInplaceImageEdit.CloseUp(Accept: Boolean);
var
  I: Integer;
  Value: string;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    FocusNeeded;
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0,
      SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    Invalidate;
    I := FPopupListBox.ItemIndex;
    if (0 <= I) and (I < Self.Values.Count) then
    begin
      Value := Self.Values[I];
      DoCloseUp(Value, Accept);
      if Accept then
        SetValue(Value);
    end;
  end;
end;

function TdxInplaceImageEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxImageEditViewData(Result) do
  begin
    Focused := Focused and not IsInplace and not DroppedDown;
//    FocusRect := True and not IsInplace;
    if Self.MultiLineText then
      DrawAlignment := daMultiLine;
    DefaultImages := Self.DefaultImages;
    Descriptions := Self.Descriptions;
    ImageIndexes := Self.ImageIndexes;
    Images := Self.Images;
    ShowDescription := Self.ShowDescription;
    Values := Self.Values;
  end;
end;

procedure TdxInplaceImageEdit.DoIncremental(Distance: Integer; Circle: Boolean);
var
  I: Integer;
begin
  if not ReadOnly and (Values.Count > 0) then
  begin
    I := Values.IndexOf(Text);
    if (0 <= I) and (I < Values.Count) then
    begin
      I := I + Distance;
      if I < 0 then I := 0;
      if I >= Values.Count then I := Values.Count - 1;
    end
    else
      I := 0;
    SetValue(Values[I]);
  end;
end;

procedure TdxInplaceImageEdit.DropDown;
begin
  if not CanModify {or (Self.Values.Count = 0) }then Exit;
  Windows.SetFocus(Handle);
  if GetFocus <> Handle then Exit;
  EditButtonClick;
  if Values.Count = 0 then Exit;
  FActiveList := FPopupListBox;
  // Init Popup
  with FPopupListBox do
  begin
    Parent := Self;
    Color := Self.Color;
    Font := Self.Font;
    if Self.LargeImages <> nil then
      Images := Self.LargeImages
    else Images := Self.Images;
    IsMultiLineText := Self.MultiLineText;
    PopupBorderStyle := Self.PopupBorderStyle;
    Shadow := Self.Style.Shadow;
  end;
  PrepareListBox;
  with FActiveList do
    SetWindowPos(Handle, HWND_TOP, Left, Top, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  FListVisible := True;
  Invalidate;
end;

class function TdxInplaceImageEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxImageEditViewData;
end;

procedure TdxInplaceImageEdit.SetValue(const Value: string);
begin
  if Text <> Value then
    if CanModify and EditCanModify then
    begin
      Text := Value;
      Modified := True;
    end;
end;

// private TdxInplaceImageEdit
procedure TdxInplaceImageEdit.ImageListChange(Sender: TObject);
begin
  if (Sender = Images) or (Sender = LargeImages) then StyleChanged;
end;

procedure TdxInplaceImageEdit.PrepareListBox;
var
  I, J, Y, K: Integer;
begin
  with FPopupListBox do
  begin
    with Items do
    begin
      BeginUpdate;
      try
        Clear;
        for I := 0 to Self.Values.Count - 1 do
        begin
          K := I;
          if not DefaultImages then
          try
            if I < Self.ImageIndexes.Count then
              K := StrToInt(Self.ImageIndexes[I])
            else K := -1;
          except
            K := -1;
          end;
          if K < 0 then K := -2; // CB_ERR = -1 !!!
          if I < Self.Descriptions.Count then
            AddObject(Self.Descriptions[I], Pointer(K))
          else AddObject('', Pointer(K));
        end;
      finally
        EndUpdate;
      end;
    end;
    // calc non-client width and height
    if Items.Count >= Self.DropDownRows then
      ClientHeight := Self.DropDownRows * RealItemHeight
    else ClientHeight := Items.Count * RealItemHeight;
    if DropDownWidth <> 0 then
      ClientWidth := DropDownWidth
    else
    begin
      J := 10;
      for I := 0 to Items.Count - 1 do
      begin
        Y := Canvas.TextWidth(Items[I]) + 2;
        if Y > J then J := Y;
      end;
      if LargeImages <> nil then
        K := LargeImages.Width
      else
        if Images <> nil then
          K := Images.Width
        else K := ItemHeight;
      ClientWidth := J + K + 4;
    end;
//    J := RealPopupWidth; // Self.Width; // TODO INPLACE
//    if Width < J then Width := J;
    // Seek
    ItemIndex := Self.Values.IndexOf(Self.Text);
    CalcPosition(FActiveList, True);
  end;
end;

procedure TdxInplaceImageEdit.SetDefaultImages(Value: Boolean);
begin
  if FDefaultImages <> Value then
  begin
    FDefaultImages := Value;
    InvalidateClientRect;
  end;
end;

procedure TdxInplaceImageEdit.SetDescriptions(Value: TStrings);
begin
  FDescriptions.Assign(Value);
  StyleChanged;
end;

procedure TdxInplaceImageEdit.SetImageIndexes(Value : TStrings);
begin
  FImageIndexes.Assign(Value);
  StyleChanged;
end;

procedure TdxInplaceImageEdit.SetImages(Value: TImageList);
begin
  if Images <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Value <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Value.FreeNotification(Self);
  end;
  StyleChanged;
end;

procedure TdxInplaceImageEdit.SetLargeImages(Value: TImageList);
begin
  if LargeImages <> nil then
    LargeImages.UnRegisterChanges(FLargeImageChangeLink);
  FLargeImages := Value;
  if Value <> nil then
  begin
    LargeImages.RegisterChanges(FLargeImageChangeLink);
    Value.FreeNotification(Self);
  end;
  StyleChanged;
end;

procedure TdxInplaceImageEdit.SetMultiLineText(Value: Boolean);
begin
  if FMultiLineText <> Value then
  begin
    FMultiLineText := Value;
    StyleChanged;
  end;
end;

procedure TdxInplaceImageEdit.SetShowDescription(Value: Boolean);
begin
  if FShowDescription <> Value then
  begin
    FShowDescription := Value;
    InvalidateClientRect;
  end;
end;

procedure TdxInplaceImageEdit.SetValues(Value : TStrings);
begin
  FValues.Assign(Value);
  StyleChanged;
end;

procedure TdxInplaceImageEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS; // TODO common
end;

{ TCustomdxPopupListBox }
constructor TCustomdxPopupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Style := lbOwnerDrawVariable;
  FHotTrack := True;
  FShadowSize := dxEditShadowSize;
end;

procedure TCustomdxPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    Style := Style and not WS_BORDER;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TCustomdxPopupListBox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
end;

procedure TCustomdxPopupListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if HotTrack then
  begin
    X := ItemAtPos(Point(X, Y), False);
    if (X <> -1) and (ItemIndex <> X) then
      ItemIndex := X;
  end;
end;

procedure TCustomdxPopupListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  Canvas.Font := Self.Font;
  Height := Canvas.TextHeight('Wg');
  FRealItemHeight := Height;
end;

procedure TCustomdxPopupListBox.SetPopupBorderStyle(Value: TdxPopupBorderStyle);
begin
  if FPopupBorderStyle <> Value then
  begin
    FPopupBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxPopupListBox.SetShadow(Value: Boolean);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxPopupListBox.SetShadowSize(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FShadowSize <> Value then
  begin
    FShadowSize := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxPopupListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
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

procedure TCustomdxPopupListBox.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawWindowPopupBorder(Handle, PopupBorderStyle,
    (GetWindowLong(Handle, GWL_STYLE) and (WS_HSCROLL or WS_VSCROLL)) = (WS_HSCROLL or WS_VSCROLL),
    Shadow, ShadowSize);
end;

procedure TCustomdxPopupListBox.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateShadow(Handle, Shadow, ShadowSize);
end;

procedure TCustomdxPopupListBox.CMHintShow(var Message: TMessage);
begin
  Message.Result := 1;
end;

{ TdxPopupImageListBox }
procedure TdxPopupImageListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  S: string;
  I, W, H: Integer;
begin
  if (Index = -1) then
    inherited
  else
    with Canvas, Rect do
    begin
      // fill rect
      FillRect(Rect);
      // draw image
      I := Integer(Items.Objects[Index]);
      if (Images <> nil) then
      begin
        W := Images.Width;
        H := Images.Height;
        if (0 <= I) and (I < Images.Count) then
          Images.Draw(Canvas, Left + 1, (Top + Bottom - H) div 2, I);
      end
      else W := 0;
      S := Items[Index];
      SetBkMode(Handle, TRANSPARENT);
      if IsMultiLineText then
      begin
        InflateRect(Rect, -2, -2);
        Inc(Rect.Left, W + 1);
        DrawText(Handle, PChar(S), Length(S), Rect,
          DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX or DT_WORDBREAK or DT_END_ELLIPSIS);
      end
      else
        TextOut(Left + W + 2 + 1, (Top + Bottom - TextHeight(S)) div 2, S);
    end;
end;

procedure TdxPopupImageListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  Canvas.Font := Self.Font;
  Height := Canvas.TextHeight('Wg') + 3 + 2;
  if (Images <> nil) and (Images.Height + 2 > Height) then
    Height := Images.Height + 2;
  FRealItemHeight := Height;
end;

procedure TdxPopupImageListBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

procedure TdxPopupImageListBox.SetImages(Value: TImageList);
begin
  FImages := Value;
  if Value <> nil then
  begin
    Value.FreeNotification(Self);
    RecreateWnd;
  end;
end;

{ TdxInplaceSpinEdit }

constructor TdxInplaceSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  FEditorEnabled := True;
  FIncrement := 1.0;
  Text := '0';
end;

class function TdxInplaceSpinEdit.CalcSpinButtonWidth(AViewData: TdxEditViewData): Integer;
const
  LimitSize = 13;
begin
  Result := 0;
  if AViewData is TdxSpinEditViewData then
    with TdxSpinEditViewData(AViewData) do
      if ShowButton then
      begin
        Result := GetSystemMetrics(SM_CXVSCROLL);
        if not Odd(Result) then Dec(Result);
        if Result < LimitSize then Result := LimitSize;
        if ButtonStyle in [btsFlat, btsSimple{, btsHotFlat}] then
          Dec(Result);
      end
end;

class procedure TdxInplaceSpinEdit.CalcViewInfo(AViewData: TdxEditViewData;
  AutoSize: Boolean; var ViewInfo: TdxEditViewInfo);
begin
  inherited CalcViewInfo(AViewData, AutoSize, ViewInfo);
  with TdxSpinEditViewData(AViewData), ViewInfo.ClientBounds do
    Dec(Right, CalcSpinButtonWidth(AViewData));
end;

function TdxInplaceSpinEdit.DefaultValueType: TdxValueType;
begin
  if not Assigned(DataDefinition) then
    Result := vtInt
  else
    if DataDefinition.IsFloat then
      Result := vtFloat
    else Result := vtInt;
end;

class procedure TdxInplaceSpinEdit.DrawBorder(ADC: HDC; var ViewInfo: TdxEditViewInfo; AViewData: TdxEditViewData);
var
  X, Y, Size: Integer;

  procedure DrawArrow(X, Y: Integer; Color: COLORREF; IsDown: Boolean);
  var
    Brush: HBRUSH;
    P: array[1..3] of TPoint;
    Pen: HPEN;
  begin
    if IsDown then
    begin
      Inc(Y);    
      P[1] := Point(X, Y);
      P[2] := Point(X + Size - 1, Y);
      P[3] := Point(X + Size div 2, Y + Size div 2);
    end
    else
    begin
      P[1] := Point(X, Y + Size div 2);
      P[2] := Point(X + Size div 2, Y);
      P[3] := Point(X + Size - 1, Y + Size div 2);
    end;
    Pen := SelectObject(ADC, CreatePen(PS_SOLID, 1, GetSysColor(Color)));
    Brush := SelectObject(ADC, GetSysColorBrush(Color));
    Polygon(ADC, P, 3);
    SelectObject(ADC, Brush);
    Windows.DeleteObject(SelectObject(ADC, Pen));
  end;

  procedure DrawButton(ADC: HDC; ARect: TRect; BS: TdxEditButtonViewStyle; ABrush: HBRUSH;
    APushed, ASelected, ATransparent, ATransparence, AEnabled, AIsDown: Boolean);
  const
    FlagsFlat: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
    TransparentFlags: array [Boolean] of Integer = (BF_MIDDLE, 0);
  var
    FlatBrush: HBRUSH;
    PenColor: TColorRef;
    Br: HBRUSH;
    R: TRect;
  begin
    PenColor := COLOR_BTNTEXT;
    if ATransparence then
      Br := ABrush
    else Br := GetSysColorBrush(COLOR_BTNFACE);
    if (APushed or ASelected) and (BS = btsSimple) then
      BS := btsFlat;
    if not ATransparent and ATransparence then
      FillRect(ADC, ARect, ABrush);
    R := ARect;
    case BS of
      btsHotFlat:
        begin
          FrameRect(ADC, ARect, GetSysColorBrush(COLOR_BTNSHADOW));
          InflateRect(ARect, -1, -1);
          if ASelected or APushed then
          begin
            if ATransparence then
            begin
              if not APushed then
                PenColor := COLOR_BTNSHADOW;
            end
            else PenColor := COLOR_WINDOW;
          end;
          R := ARect;
          if not ATransparent and not ATransparence then
          begin
            FlatBrush := GetSysColorBrush(COLOR_BTNFACE);
            if AEnabled then
              if APushed then
                FlatBrush := GetSysColorBrush(COLOR_BTNTEXT)
              else
                if ASelected then
                  FlatBrush := GetSysColorBrush(COLOR_BTNSHADOW);
            Br := FlatBrush;
            FillRect(ADC, ARect, Br); // Bk
          end;
        end;
      btsSimple:
        begin
          if not ATransparent and not ATransparence then
          begin
            FrameRect(ADC, ARect, ABrush);
            InflateRect(ARect, -1, -1);
            with ARect do
            begin
              FillRect(ADC, Rect(Left, Top, Left + 1, Bottom), ABrush);
              Inc(Left);
            end;
            R := ARect;
            FillRect(ADC, ARect, Br); // Bk
          end
          else
            InflateRect(ARect, -1, -1);
        end;
      btsFlat:
        begin
          if not ATransparent and not ATransparence then
            with ARect do
            begin
              FillRect(ADC, Rect(Left, Top, Left + 1, Bottom), GetSysColorBrush(COLOR_BTNFACE));
              Inc(Left);
            end;
          DrawEdge(ADC, ARect, FlagsFlat[APushed], BF_RECT or
            TransparentFlags[{ATransparent and }ATransparence] or BF_ADJUST); // Bk*
          R := ARect;
        end;
      bts3D:
        begin
          if APushed then
          begin
            DrawEdge(ADC, ARect, BDR_RAISEDINNER,
              TransparentFlags[{ATransparent and }ATransparence] or BF_BOTTOMRIGHT or BF_ADJUST); // Bk*
            DrawEdge(ADC, ARect, BDR_SUNKENOUTER, BF_TOPLEFT or BF_ADJUST);
          end
          else
            DrawEdge(ADC, ARect, BDR_RAISEDINNER or BDR_RAISEDOUTER,
              TransparentFlags[{ATransparent and }ATransparence] or BF_RECT or BF_ADJUST); // Bk*
          R := ARect;
        end;
    end;
    if APushed and not (BS in [btsHotFlat]) then
      OffsetRect(ARect, 1, 1);
    // Content
    with ARect do
    begin
      Size := (Right - Left -2{TODO}) div 2; // TODO Height
      if not Odd(Size) then Inc(Size);
      X := (Left + Right - Size) div 2;
      Y := (Top + Bottom - Size div 2) div 2 - 1;
      if AEnabled then
        DrawArrow(X, Y, PenColor, AIsDown)
      else
      begin
        DrawArrow(X + 1, Y + 1, COLOR_BTNHIGHLIGHT, AIsDown);
        DrawArrow(X, Y, COLOR_BTNSHADOW, AIsDown);
      end;
    end;
  end;

var
  BR, R: TRect;
  ButtonWidth: Integer;
begin
  inherited DrawBorder(ADC, ViewInfo, AViewData);
  with TdxSpinEditViewData(AViewData) do
  begin
    if ShowButton then
    begin
      ButtonWidth := CalcSpinButtonWidth(AViewData);
      with ViewInfo do
      begin
        BR := BorderRect;
        InflateBorderRect(BR, ViewInfo, False);
      end;
      with BR do
        R := Rect(Right - ButtonWidth, Top, Right, Bottom);
      // Up
      with R do
        BR := Rect(Left, Top, Right, (Top + Bottom ) shr 1);
      DrawButton(ADC, BR, ButtonStyle, Brush, (StatePressed = sbTopDown) and (StateActive = sbTopDown),
        (StateActive = sbTopDown), Transparent, ButtonTransparence, Enabled, False);
      // Down
      BR.Top := BR.Bottom;
      BR.Bottom := R.Bottom;
      DrawButton(ADC, BR, ButtonStyle, Brush, (StatePressed = sbBottomDown) and (StateActive = sbBottomDown),
        (StateActive = sbBottomDown), Transparent, ButtonTransparence, Enabled, True);
    end;
  end;
end;

procedure TdxInplaceSpinEdit.RestoreDefaults;
begin
  inherited RestoreDefaults;
//  SetEditMaxValue(DefaultMaxValue);
//  SetEditMinValue(DefaultMinValue);
  SetEditMinMaxValues(DefaultMinValue, DefaultMaxValue);
  SetEditValueType(DefaultValueType);
end;

procedure TdxInplaceSpinEdit.SetMinMaxValues(AMinValue, AMaxValue: Double);
begin
  Include(FStoredValues, svMinValue);
  Include(FStoredValues, svMaxValue);
  SetEditMinMaxValues(AMinValue, AMaxValue);
end;

procedure TdxInplaceSpinEdit.ValidateEdit;
begin
  inherited ValidateEdit;
  if Modified then
    SetValue(GetValue);
end;

procedure TdxInplaceSpinEdit.DefaultHandler(var Message);
begin
  case TMessage(Message).Msg of
    WM_KEYDOWN:
      begin
        if (TWMKeyDown(Message).CharCode = VK_UP) or
          (TWMKeyDown(Message).CharCode = VK_DOWN) then
            Exit;
      end;
  end;
  inherited;
end;

procedure TdxInplaceSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not EditorEnabled and KeyEditModify(Key, Shift) then
    Key := 0;
  if (Key in [VK_UP, VK_DOWN]) and not (UseCtrlIncrement and not (ssCtrl in Shift)) then
  begin
    FStatePressed := sbNotDown;
    case Key of
      VK_UP: FStatePressed := sbTopDown;
      VK_DOWN: FStatePressed := sbBottomDown;
    end;
    if FStatePressed <> sbNotDown then
    begin
      FStateActive := FStatePressed;
      if GetCapture = Handle then
        ReleaseCapture;
    end;
    InvalidateBtn;
    DoIncremental;
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceSpinEdit.KeyPress(var Key: Char);
begin
  if Key in ['.', ','] then Key := DecimalSeparator;
  if (Key in [Char(VK_BACK), Char(VK_DELETE), #32 .. #255]) and not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TdxInplaceSpinEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then
    StopTracking;
  inherited KeyUp(Key, Shift);
end;

procedure TdxInplaceSpinEdit.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  StopTracking;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TdxInplaceSpinEdit.AssignEditProperties;
begin
  inherited AssignEditProperties;
  if not (svIsFloat in StoredValues) then
    SetEditValueType(DefaultValueType);
  if not (svMaxValue in StoredValues) and not (svMinValue in StoredValues) then
    SetEditMinMaxValues(DefaultMinValue, DefaultMaxValue)
  else
  begin
    if not (svMaxValue in StoredValues) then
      SetEditMaxValue(DefaultMaxValue);
    if not (svMinValue in StoredValues) then
      SetEditMinValue(DefaultMinValue);
  end;
end;

function TdxInplaceSpinEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxSpinEditViewData(Result) do
  begin
    if not IsSelected and (Style.ButtonTransparence = ebtHideInactive) then
      ShowButton := False
    else ShowButton := True;
    StatePressed := FStatePressed;
    if (FStatePressed <> sbNotDown) and (GetCapture <> Handle) then
      StateActive := FStatePressed
    else StateActive := FStateActive;
  end;
end;

function TdxInplaceSpinEdit.GetDisableCloseEditor: Boolean;
begin
  Result := False;
end;

function TdxInplaceSpinEdit.GetIncrement: Double;
begin
  Result := Increment;
end;

function TdxInplaceSpinEdit.DefaultMaxValue: Double;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.MaxValue
  else Result := 0;
end;

function TdxInplaceSpinEdit.DefaultMinValue: Double;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.MinValue
  else Result := 0;
end;

function TdxInplaceSpinEdit.GetValue: Double;

  function GetMin: Double;
  begin
    if FValueType = vtFloat then
      Result := MinValue
    else
      Result := Trunc(MinValue);
  end;

begin
  try
    if Text = '' then
      Result := GetMin
    else
      if FValueType = vtFloat then
        Result := StrToFloat(Text)
      else
        Result := StrToInt(Text);
  except
    on EConvertError do
      Result := GetMin;
  end;
end;

class function TdxInplaceSpinEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxSpinEditViewData;
end;

procedure TdxInplaceSpinEdit.MouseButtonClick(X, Y: Integer);
var
  P: TPoint;
begin
  inherited MouseButtonClick(X, Y);
  if not Assigned(Container) then Exit; // TODO one code
  P := Point(X, Y);
  MapWindowPoints(Container.Handle, 0, P, 1);
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN,
    SendMessage(Handle, WM_NCHITTEST, 0, MAKELPARAM(P.X, P.Y)),
    MAKELPARAM(P.X, P.Y));
end;

function TdxInplaceSpinEdit.IsValidChar(Key: Char): Boolean;
var
  ValidChars: set of Char;
begin
  ValidChars := ['+', '-', '0'..'9'];
  if FValueType = vtFloat then ValidChars := ValidChars + [DecimalSeparator];
  Result := (Key in ValidChars) or (Key < #32);
  if not EditorEnabled and Result and ((Key >= #32) or
    (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then Result := False;
end;

function TdxInplaceSpinEdit.IsWantMouseWheel: Boolean;
begin
  Result := True;
end;

procedure TdxInplaceSpinEdit.SetEditMaxValue(Value: Double);
begin
  if Value < FMinValue then Value := FMinValue;
  if FMaxValue <> Value then
  begin
    FMaxValue := Value;
    SetValue(GetValue);
  end;
end;

procedure TdxInplaceSpinEdit.SetEditMinValue(Value: Double);
begin
  if Value > FMaxValue then Value := FMaxValue;
  if FMinValue <> Value then
  begin
    FMinValue := Value;
    SetValue(GetValue);
  end;
end;

procedure TdxInplaceSpinEdit.SetEditMinMaxValues(AMinValue, AMaxValue: Double);
begin
  if AMinValue > AMaxValue then AMinValue := AMaxValue;
  FMinValue := AMinValue;
  FMaxValue := AMaxValue;
  SetValue(GetValue);
end;

procedure TdxInplaceSpinEdit.SetEditValueType(Value: TdxValueType);
begin
  if FValueType <> Value then
  begin
    FValueType := Value;
    if Text <> '' then
      SetValue(GetValue);
  end;
end;

procedure TdxInplaceSpinEdit.SetValue(Value: Double);
var
  S: string;
  APrevModified: Boolean;
begin
   if FValueType = vtFloat then
    S := FloatToStrF(CheckValue(Value), ffGeneral{ffFixed}, 15, 0)
  else
    S := IntToStr(Round(CheckValue(Value)));
  if Text <> S then
  begin
    APrevModified := Modified;
    try
      Text := S;   // TODO: Modified ?
    finally
      Modified := APrevModified;
    end;
  end;
end;

procedure TdxInplaceSpinEdit.SetSelected(Value: Boolean);
begin
  if not Value then
    StateActive := sbNotDown;
  inherited SetSelected(Value);
end;

function TdxInplaceSpinEdit.CheckValue(Value: Double): Double;
begin
  Result := Value;
  if MaxValue <> MinValue then
  begin
    if Value < MinValue then Result := MinValue
    else if Value > MaxValue then Result := MaxValue;
  end;
end;

procedure TdxInplaceSpinEdit.DoIncremental;
begin
  if not CanModify then
    MessageBeep(0)
  else
    if EditCanModify then
    begin
      case FStatePressed of
        sbTopDown: SetValue(GetValue + GetIncrement);
        sbBottomDown: SetValue(GetValue - GetIncrement);
      end;
      Modified := True;
    end;
end;

function TdxInplaceSpinEdit.GetIntValue: Integer;
begin
  Result := Trunc(Value);
end;

procedure TdxInplaceSpinEdit.InvalidateBtn;
begin
  if HandleAllocated then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

function TdxInplaceSpinEdit.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1.0;
end;

function TdxInplaceSpinEdit.IsMaxValueStored: Boolean;
begin
  Result := svMaxValue in StoredValues;
end;

function TdxInplaceSpinEdit.IsMinValueStored: Boolean;
begin
  Result := svMinValue in StoredValues;
end;

function TdxInplaceSpinEdit.IsValueStored: Boolean;
begin
  Result := GetValue <> 0.0;
end;

function TdxInplaceSpinEdit.IsValueTypeStored: Boolean;
begin
  Result := svIsFloat in FStoredValues;
end;

procedure TdxInplaceSpinEdit.SetIntValue(NewValue: Integer);
begin
  Value := NewValue;
end;

procedure TdxInplaceSpinEdit.SetMaxValue(Value: Double);
begin
  Include(FStoredValues, svMaxValue);
  SetEditMaxValue(Value);
end;

procedure TdxInplaceSpinEdit.SetMinValue(Value: Double);
begin
  Include(FStoredValues, svMinValue);
  SetEditMinValue(Value);
end;

procedure TdxInplaceSpinEdit.SetStateActive(Value: TdxSpinButtonState);
begin
  if FStateActive <> Value then
  begin
    FStateActive := Value;
    InvalidateBtn;
  end;
end;

procedure TdxInplaceSpinEdit.SetValueType(Value: TdxValueType);
begin
  Include(FStoredValues, svIsFloat);
  SetEditValueType(Value);
end;

procedure TdxInplaceSpinEdit.StopTracking;
begin
  if FStatePressed <> sbNotDown then
  begin
    FStatePressed := sbNotDown;
    FStateActive := sbNotDown;
    if GetCapture = Handle then
      ReleaseCapture;
    InvalidateBtn;
  end;
end;

procedure TdxInplaceSpinEdit.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TdxInplaceSpinEdit.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  StopTracking;
end;

procedure TdxInplaceSpinEdit.WMClear(var Message);
begin
  if not EditorEnabled then Exit;
  inherited;
end;

procedure TdxInplaceSpinEdit.WMCut(var Message);
begin
  if not EditorEnabled then Exit;
  inherited;
end;

procedure TdxInplaceSpinEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if (GetAsyncKeyState(VK_UP) < 0) or (GetAsyncKeyState(VK_DOWN) < 0) then
    StopTracking;
end;

procedure TdxInplaceSpinEdit.WMMouseWHeel(var Message: TWMMouse);
var
  PrevStatePressed: TdxSpinButtonState;
begin
//  inherited;
  PrevStatePressed := FStatePressed;
  try
    if SmallInt(HIWORD(Message.Keys)) > 0 then
      FStatePressed := sbTopDown
    else
      FStatePressed := sbBottomDown;
    DoIncremental;
  finally
    FStatePressed := PrevStatePressed;
  end;
end;

procedure TdxInplaceSpinEdit.WMLButtonUp(var Message: TWMLButtonUp);
begin
  StopTracking;
  inherited;
end;

procedure TdxInplaceSpinEdit.WMNCHitTest(var Message: TWMNCHitTest);
const
  FlagsUpDown: array [Boolean] of TdxSpinButtonState = (sbTopDown, sbBottomDown);
var
  FViewData: TdxEditViewData;
  ViewInfo: TdxEditViewInfo;
  BR: TRect;
  P: TPoint;
  FlagDown: Boolean;
begin
  inherited;
  FViewData := CreateViewData(False);
  try
    if not (csDesigning in ComponentState) then
    begin
      P := SmallPointToPoint(Message.Pos);
      ScreenToWindow(Handle, P);
      CalcViewInfo(FViewData, False, ViewInfo);
      with ViewInfo do
      begin
        BR := BorderRect;
        InflateBorderRect(BR, ViewInfo, False);
      end;
      with TdxSpinEditViewData(FViewData) do
      begin
        BR.Left := BR.Right - CalcSpinButtonWidth(FViewData);
        if PtInRect(BR, P) and ((GetCapture = 0) or (FStatePressed <> sbNotDown)) then
        begin
          FlagDown := P.Y >= (BR.Top + BR.Bottom) div 2;
          if (FStatePressed <> sbNotDown) and (FStatePressed <> FlagsUpDown[FlagDown]) then
            Self.StateActive := sbNotDown
          else Self.StateActive := FlagsUpDown[FlagDown];
          // TODO set
          Message.Result := HTBORDER;
          Exit;
        end;
      end;
    end;
    Self.StateActive := sbNotDown;
  finally
    FViewData.Free;
  end;
end;

procedure TdxInplaceSpinEdit.WMNCLButtonDblClk(var Message: TWMNCLButtonDown);
begin
  inherited;
  StopTracking;
  if FTimer <> 0 then 
  begin
    KillTimer(Handle, dxSpinEditTimerId);
    FTimer := 0;
  end;
  with TMessage(Message) do
  begin
    SendMessage(Handle, WM_NCLBUTTONDOWN, WParam, LParam);
    SendMessage(Handle, WM_NCLBUTTONUP, WParam, LParam);
  end;
end;

procedure TdxInplaceSpinEdit.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  if FStateActive <> sbNotDown then
  begin
    FStatePressed := FStateActive;
    SetCapture(Handle);
    InvalidateBtn;
    DoIncremental;
    if FTimer = 0 then
      FTimer := SetTimer(Handle, dxSpinEditTimerId, InitRepeatPause, nil)
    else
    begin
      KillTimer(Handle, dxSpinEditTimerId);
      FTimer := 0;
    end;
    SetFocus;
  end;
end;

procedure TdxInplaceSpinEdit.WMPaste(var Message);
begin
  if not EditorEnabled then Exit;
  inherited;
end;

procedure TdxInplaceSpinEdit.WMTimer(var Message: TWMTimer);
begin
  inherited;
  if Message.TimerID = dxSpinEditTimerId then
  begin
    if FTimer <> 0 then
    begin
      KillTimer(Handle, dxSpinEditTimerId);
      FTimer := 0;
    end;
    if (FStatePressed <> sbNotDown) and (GetCapture = Handle) then
    begin
      if FStatePressed = FStateActive then
        DoIncremental;
      FTimer := SetTimer(Handle, dxSpinEditTimerId, RepeatPause, nil);
    end;
  end;
end;

{ TdxInplacePickEdit }
constructor TdxInplacePickEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPickList := TdxPopupPickListBox.Create(Self);
  with FPickList do
  begin
    Visible := False;
    ControlStyle := ControlStyle + [csReplicatable];
    IntegralHeight := True;
    ItemHeight := 11;
    OnMouseUp := ListMouseUp;
  end;
  FSearchStyle := True;
  FItemIndex := -1; 
  FItems := TStringList.Create;
end;

destructor TdxInplacePickEdit.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TdxInplacePickEdit.CanModify: Boolean;
begin
  Result := not FDropDownListStyle and inherited CanModify;
end;

function TdxInplacePickEdit.IsResetTextClass: Boolean;
begin
  Result := True;
end;

procedure TdxInplacePickEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure MoveTo(Distance: Integer);
  begin
    if Items.Count > 0 then
    begin
      DoIncremental(Distance, False);
      Key := 0;
    end;
  end;

begin
  case Key of
    VK_ESCAPE:
      ResetFindStr;
    VK_DELETE:
      if DropDownListStyle and (SelLength = GetTextLen) and CanDeleteText then
        ClearValue;
  end;
  if not IsInplace then
    case Key of
      VK_UP: MoveTo(-1);
      VK_DOWN: MoveTo(1);
      VK_PRIOR: MoveTo(- (DropDownRows - 1));
      VK_NEXT: MoveTo((DropDownRows - 1));
    end;
  inherited KeyDown(Key, Shift);
end;

procedure TdxInplacePickEdit.KeyPress(var Key: Char);
var
  Found: Boolean;

  procedure FillFromList;
  var
    AFindIndex: Integer;
  begin
    AFindIndex := FindIndex(FFindStr);
    Found := AFindIndex <> -1;
    if Found then
    begin
      FDisableRefresh := True;
      try
        if EditCanModify then
          SetKeyValue(Items[AFindIndex]);
      finally
        FDisableRefresh := False;
      end;
      SetSelEx(Length(FFindStr), Length(Text), True);
    end;
  end;

begin
  if ReadOnly {not CanModify} then
  begin
    Key := #0;
    inherited KeyPress(Key);
    Exit;
  end;
  Found := False;
  try
    case Key of
    #8: // BkSpace
      begin
        if (SelStart < Length(Text)) and not DropDownListStyle then
          ResetFindStr;
        if DropDownListStyle then
        begin
          if (SelLength = GetTextLen) and CanDeleteText then
            ClearValue
          else
            if not FFindSelection then
            begin
              FFindSelection := True;
              FFindStr := Text;
            end;  
        end;
        if FFindSelection then
        begin
          FFindStr := Copy(FFindStr, 1, Length(FFindStr) - 1);
          if (FFindStr = '') and (not DropDownListStyle or CanDeleteText) then
            ClearValue
          else
          begin
            SetSelEx(Length(FFindStr), Length(Text), True);
            FillFromList;
          end;
        end;
      end;
    #32..#255:
      begin
        if (SelStart < Length(Text)) or (Length(FFindStr) <> Length(Text)) then
          ResetFindStr;
        // TODO SelStart
        if FFindSelection and ((MaxLength = 0) or (Length(Text) < MaxLength)) then
          FFindStr := FFindStr + Key
        else
        begin
          FFindSelection := True;
          FFindStr := Text;
          System.Delete(FFindStr, SelStart + 1, SelLength);
          FFindStr := FFindStr + Key;
        end;
        FillFromList;
        if ImmediateDropDown and not FListVisible then
        begin
          DropDown;
          if (FActiveList <> nil) and FListVisible then {FActiveList.HandleAllocated}
            KillMessage(FActiveList.Handle, WM_MOUSEMOVE);
          FindListValue(Text);
        end;
      end;
    end;
  finally
    if Found then Key := #0;
    inherited KeyPress(Key);
  end;
end;

procedure TdxInplacePickEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (ssDouble in Shift) and Revertable then
  begin
    if (Items <> nil) and (Items.Count > 1) then
    begin
      DoIncremental(1, True);
      FindListValue(Text);
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdxInplacePickEdit.AssignEditValue(const Value: Variant);
begin
  inherited AssignEditValue(Value);
  ResetFindStr;
end;

procedure TdxInplacePickEdit.ClearValue;
begin
  if EditCanModify then
  begin
    FDisableRefresh := True; // TODO ?
    try
      SetKeyValue('');
    finally
      FDisableRefresh := False;
    end;
  end;
end;

procedure TdxInplacePickEdit.CloseUp(Accept: Boolean);
var
  ListValue: string;
begin
  if FListVisible then
  begin
    ResetFindStr;
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    FocusNeeded;
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    Invalidate;
    ListValue := Text;
    if FPickList.ItemIndex <> -1 then
      ListValue := FPickList.Items[FPicklist.ItemIndex];
    DoCloseUp(ListValue, Accept);
    if Accept and EditCanModify then
    begin
      SetKeyValue(ListValue);
      SelectAll;
    end;
  end;
end;

procedure TdxInplacePickEdit.DoIncremental(Distance: Integer; Circle: Boolean);
var
  I: Integer;
begin
  if not ReadOnly and (Items.Count > 0) then
  begin
    ResetFindStr;
    if FItemIndex = -1 then
      I := FindIndex(Text)
    else I := FItemIndex;
    if (0 <= I) and (I < Items.Count) then
    begin
      I := I + Distance;
      if I < 0 then I := 0;
      if I >= Items.Count then
        if Circle then I := 0
        else I := Items.Count - 1;
    end
    else
      I := 0;
    FItemIndex := I;
    if EditCanModify then
      SetKeyValue(Items[FItemIndex]);
    SelectAll;
  end;
end;

procedure TdxInplacePickEdit.DropDown;
begin
  if not InternalReadOnly {CanModify} then
  begin
    Windows.SetFocus(Handle);
    if GetFocus <> Handle then Exit;
    EditButtonClick;
    FActiveList := FPickList;
    if (Items <> nil) and (Items.Count > 0) then
    begin
      PrepareListBox;
      with FActiveList do
        SetWindowPos(Handle, HWND_TOP, Left, Top, 0, 0,
          SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      FListVisible := True;
      Invalidate;
    end;
  end;
end;

procedure TdxInplacePickEdit.FindListValue(const Value: string);
begin
  if FListVisible and Assigned(FPickList) then
  begin
    if not FFindSelection and (FItemIndex < FPickList.Items.Count) then
      FPickList.ItemIndex := FItemIndex
    else
      FPickList.ItemIndex := FindIndex(Value);
  end;
end;

procedure TdxInplacePickEdit.ResetFindStr;
begin
  if FDisableRefresh then Exit;
  FFindSelection := False;
  FFindStr := '';
end;

procedure TdxInplacePickEdit.SetActive(Value: Boolean);
begin
  inherited SetActive(Value);
  {TODO? if not Value then }ResetFindStr;
end;

procedure TdxInplacePickEdit.SetEditReadOnly(Value: Boolean);
begin
  inherited SetEditReadOnly(Value);
  if FDropDownListStyle and HandleAllocated then
    SendMessage(Handle, EM_SETREADONLY, Ord(True), 0);
end;

procedure TdxInplacePickEdit.SetKeyValue(const Value: string);
begin
  if Text <> Value then
  begin
    Text := Value;
    Modified := True;
  end;
end;

function TdxInplacePickEdit.FindIndex(const AText: string): Integer;
var
  I, J, L, MaxFindLen: Integer;
  S: string;
begin
  Result := -1;
  if (AText <> '') and (Items.Count > 0) then
  begin
    L := Length(AText);
    MaxFindLen := 0;
    for I := 0 to Items.Count - 1 do
    begin
      S := Copy(Items[I], 1, L);
      for J := 1 to Length(S) do
        if (CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
          PChar(S), J, PChar(AText), J) - 2) = 0 then // AnsiCompareText
        begin
          if J > MaxFindLen then
          begin
            MaxFindLen := J;
            if MaxFindLen = L then // Found
            begin
              Result := I;
              Exit;
            end;
          end;
        end;
    end;
  end;
end;

function TdxInplacePickEdit.GetItemIndex: Integer;
var
  I: Integer;
  S: string;
begin
  Result := -1;
  S := Text;
  for I := 0 to Items.Count - 1 do
    if AnsiCompareText(Items[I], S) = 0 then
    begin
      Result := I;
      Break;
    end;
end;

procedure TdxInplacePickEdit.PrepareListBox;
var
  I, J, Y: Integer;
begin
  with FPickList do
  begin
    // style
    Parent := Self;
    Color := Self.Color;
    Font := Self.Font;
    PopupBorderStyle := Self.PopupBorderStyle;
    Shadow := Self.Style.Shadow;
    // load items
    Items := Self.Items;
    if Items.Count >= DropDownRows then
      ClientHeight := DropDownRows * RealItemHeight
    else ClientHeight := Items.Count * RealItemHeight;
    // calc width
    if DropDownWidth <> 0 then
      {Client}Width := DropDownWidth // TODO Check!!!
    else
    begin
      J := 10;
      for I := 0 to Items.Count - 1 do
      begin
        Y := Canvas.TextWidth(Items[I]);
        if Y > J then J := Y;
      end;
      ClientWidth := J + 4;
    end;
//    J := RealPopupWidth; // Self.Width; // TODO INPLACE
//    if Width < J then Width := J;
    ItemIndex := Items.IndexOf(Self.Text);
    CalcPosition(FActiveList, True);
  end;
end;

procedure TdxInplacePickEdit.SetDropDownListStyle(Value: Boolean);
begin
  if FDropDownListStyle <> Value then
  begin
    FDropDownListStyle := Value;
    SetEditReadOnly(ReadOnly);
  end;
end;

procedure TdxInplacePickEdit.SetItemIndex(Value: Integer);

  procedure SetValue(const AValue: string);
  begin
    ResetFindStr;
    if EditCanModify then
      SetKeyValue(AValue);
    SelectAll;
  end;   

begin
  if Value = -1 then
  begin
    if ItemIndex <> -1 then
      SetValue('');
  end
  else
    if (0 <= Value) and (Value < Items.Count) then
      SetValue(Items[Value]);
end;

procedure TdxInplacePickEdit.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TdxInplacePickEdit.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    DroppedDown := False;
    FSorted := Value;
    TStringList(Items).Sorted := FSorted;
  end;  
end;

{ TCustomdxPopupPickListBox }
procedure TCustomdxPopupPickListBox.KeyPress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27:
      FSearchText := '';
    #32..#255:
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 2000 then FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        if SendMessage(Handle, LB_SelectString, WORD(-1), Longint(PChar(FSearchText))) = LB_ERR then
          Delete(FSearchText, Length(FSearchText), 1);
        Key := #0;
      end;
  end;
  inherited Keypress(Key);
end;

{ TdxPopupPickListBox }
procedure TdxPopupPickListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button = mbLeft then
    TdxInplacePickEdit(Owner).CloseUp((X >= 0) and (Y >= 0) and
      (X < Width) and (Y < Height));
end;

{ TdxInplaceCalcEdit }
constructor TdxInplaceCalcEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSendChildrenStyle := False;
  FBeepOnError := True;
  FPrecision := dxDefCalcPrecision;
end;

destructor TdxInplaceCalcEdit.Destroy;
begin
  if FPopupCalculator <> nil then
    FPopupCalculator.Free;
  inherited Destroy;
end;

procedure TdxInplaceCalcEdit.DropDown;
begin
  if FListVisible then Exit;
  if not CanModify then Exit;
  if FPopupCalculator = nil then
    FPopupCalculator := TdxPopupCalculator.Create(nil)
  else TWinControlCrack(FPopupCalculator).DestroyHandle;
  FPopupCalculator.OwnerControl := Self;
  FActiveList := FPopupCalculator;
  EditButtonClick; // TODO: assign properties to Popup?
  with FPopupCalculator do
  begin
    PopupBorderStyle := Self.PopupBorderStyle;
    Shadow := Self.Style.Shadow;
    IsPopup := True;
    IsQuickClose := Self.QuickClose;
    Edit := Self;
    Font := Self.Font;
    ShowFocusRect := False;
    BeepOnError := Self.BeepOnError;
    ButtonStyle := Self.ButtonStyle;
    ShowButtonFrame := Self.ShowButtonFrame;
    Precision := Self.Precision;
    CreateLayout;
    CalcPosition(FPopupCalculator, False);
    FListVisible := True;
    ShowPopup;
  end;
end;

{ TdxPopupCalculator }
constructor TdxPopupCalculator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsPopupControl := True;
end;

procedure TdxPopupCalculator.HidePopup(ByMouse: Boolean);
begin
  inherited HidePopup(ByMouse);
  if Assigned(Edit) and (Edit.Text = sdxCalcError) then
  begin
    Edit.Text := '0';
    Edit.Modified := True;
  end;
end;

procedure TdxPopupCalculator.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

function TdxPopupCalculator.GetEditValue: string;
begin
  if Assigned(Edit) then Result := Edit.Text
  else Result := '0';
end;

procedure TdxPopupCalculator.SetEditValue(const Value: String);
begin
  if Assigned(Edit) then
  try
    if Edit.EditCanModify then
    begin
      Edit.Text := Value;
      Edit.Modified := True;
    end;
  except
    HidePopup(False);
    raise;
  end;
end;

procedure TdxPopupCalculator.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if ((Key in [VK_UP, VK_DOWN]) and (ssAlt in Shift)) or
      ((Key = VK_F4){ and not (ssAlt in Shift)}) then
  begin
    HidePopup(False);
    Exit;
  end;
  case Key of
    VK_ESCAPE, VK_RETURN:
      begin
        if Key = VK_RETURN then inherited KeyDown(Key, Shift);
        HidePopup(False);
        Key := 0;
        Exit;
      end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TdxPopupCalculator.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key = '=') and IsQuickClose then
    HidePopup(False);
end;

procedure TdxPopupCalculator.SetFlat(Value : Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

{ TdxInplaceHyperLinkEdit }
constructor TdxInplaceHyperLinkEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoSelect := False;
  FLinkColor := clBlue;
  FStartKey := ShortCut(VK_RETURN, [ssCtrl]);
end;

destructor TdxInplaceHyperLinkEdit.Destroy;
begin
  if Assigned(FLinkFont) then FLinkFont.Free;
  inherited Destroy;
end;

class function TdxInplaceHyperLinkEdit.GetEditCursor(X, Y: Integer; AViewData: TdxEditViewData): TCursor;
begin
  with TdxHyperLinkEditViewData(AViewData) do
  begin
    if IsLink then
      Result := crdxHandPointCursor
    else Result := inherited GetEditCursor(X, Y, AViewData);
  end;
end;

procedure TdxInplaceHyperLinkEdit.MouseClick;
begin
  if SingleClick then
  begin
    UpdateWindow(Handle);
    DoStart;
  end;
end;

procedure TdxInplaceHyperLinkEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (ShortCut(Key, Shift) <> 0) and (StartKey = ShortCut(Key, Shift)) then
  begin
    KillMessage(Handle, WM_CHAR);
    DoStart;
    Key := 0;
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceHyperLinkEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (Button = mbLeft) and PtInRect(ClientRect, Point(X, Y)) and
    (SingleClick or IsInplace or not CanModify) then DoStart;
end;

procedure TdxInplaceHyperLinkEdit.SelectAll;
begin
  if not IsInplace then inherited;
end;

function TdxInplaceHyperLinkEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxHyperLinkEditViewData(Result) do
  begin
    IsLink := not (csDesigning in ComponentState) and
      (SingleClick or IsInplace or not CanModify);
    TextColor := ColorToRGB(LinkFont.Color);
    Font := LinkFont.Handle;
  end;
end;

procedure TdxInplaceHyperLinkEdit.DoStart;
begin
  if Assigned(FOnStartClick) then
    FOnStartClick(Self)
  else
  if Trim(Text) <> '' then
    ShellExecute(GetParentForm(Self).Handle, 'OPEN', PChar(Text), nil, nil, SW_SHOWMAXIMIZED);
end;

class function TdxInplaceHyperLinkEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxHyperLinkEditViewData;
end;

function TdxInplaceHyperLinkEdit.GetLinkFont: TFont;
begin
  if FLinkFont = nil then
  begin
    FLinkFont := TFont.Create;
    Perform(CM_FONTCHANGED, 0, 0);
  end;
  Result := FLinkFont;
end;

procedure TdxInplaceHyperLinkEdit.SetLinkColor(Value: TColor);
begin
  if FLinkColor <> Value then
  begin
    FLinkColor := Value;
    Perform(CM_FONTCHANGED, 0, 0);
    InvalidateClientRect;
  end;
end;

procedure TdxInplaceHyperLinkEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  inherited;
{  if SingleClick or not CanModify then
    inherited
  else}
    DoStart;
end;

procedure TdxInplaceHyperLinkEdit.WMSetFont(var Message: TWMSetFont);
var
  Format: TCharFormat2;
begin
  inherited;
  FillChar(Format, SizeOf(Format), 0);
  with Format do
  begin
    cbSize := SizeOf(Format);
    dwMask := CFM_COLOR or CFM_UNDERLINETYPE;
    if (LinkColor = clWindowText) or (LinkColor = clDefault) then
      dwEffects := CFE_AUTOCOLOR
    else crTextColor := ColorToRGB(LinkColor);
    bUnderlineType := 1;
    dwEffects := 0;
    SendMessage(Handle, EM_SETCHARFORMAT, 0, LPARAM(@Format));
  end;
end;

procedure TdxInplaceHyperLinkEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  LinkFont.Assign(Font);
  LinkFont.Style := LinkFont.Style + [fsUnderline];
  LinkFont.Color := LinkColor;
end;

{ TdxInplaceTimeEdit }
constructor TdxInplaceTimeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  EditMask := dxTimeEditFormats[FTimeEditFormat, 1];
  IgnoreMaskBlank := True;
end;

procedure TdxInplaceTimeEdit.AssignEditValue(const Value: Variant);
var
  PrevModified: Boolean;
begin
  PrevModified := Modified; // TODO Modified
  try
    if ((VarType(Value) = varString) and (Value = '')) or VarIsNull(Value) then
    begin
      FSavedDate := 0;
      SetValue(0);
    end
    else
    begin
      FSavedDate := DateOf(Value);
      SetValue(TimeOf(Value));
    end;
  finally
    Modified := PrevModified;
  end;
end;

function TdxInplaceTimeEdit.IsValidChar(Key: Char): Boolean;
begin
  Result := True;
  case EditingPlace of
    'H':
      begin
        if (SelStart = 0) and not (Key in ['0'..'2']) then Result := False;
        if (SelStart = 1) and (EditText[1] = '2') and not (Key in ['0'..'3']) then
          Result := False;
      end;
    'N': if (SelStart = 3) and not (Key in ['0'..'5']) then Result := False;
    'S': if (SelStart = 6) and not (Key in ['0'..'5']) then Result := False;
  end;
end;

function TdxInplaceTimeEdit.GetValue: Double;
begin
  try
    Result := StrToTime(EditText);
  except
    Result := 0;
  end;
end;

function TdxInplaceTimeEdit.ReturnEditValue: Variant;
begin
  if (Time = 0) and (FSavedDate = 0) then
    Result := 0.0 // TODO: Null -> ClearKey
  else
    Result := FSavedDate + Time;
end;

procedure TdxInplaceTimeEdit.SetValue(Value: Double);
var
  SavePos: Integer;
begin
  // check Value
  if (Value < dxTimeEditMinValue) or (Value > dxTimeEditMaxValue) then Exit;
  if HandleAllocated then
    SavePos := SelStart
  else
    SavePos := 0;
  case SavePos of
  0..2: SavePos := 1;
  3..5: SavePos := 4;
  else
    SavePos := 7;
  end;
//TODO  AssigningText := True;
  try
    FTime := Value;
    try
      EditText := FormatDateTime(dxTimeEditFormats[FTimeEditFormat, 0], Value);
    except
      EditText := TimeToStr(SysUtils.Time);
    end;
  finally
//    AssigningText := False;
    if HandleAllocated then
      SetSel(SavePos, SavePos + 1);
  end;
end;

function TdxInplaceTimeEdit.GetIncrement: Double;
begin
  // get place
  case EditingPlace of
    'H': Result := dxTimeEditOneHour;
    'N': Result := dxTimeEditOneMin;
    'S': Result := dxTimeEditOneSec;
  else
    Result := 0;
  end;
end;

procedure TdxInplaceTimeEdit.SelectAll;
begin
  inherited;
// TODO ?
//  if not IsInplace then inherited;
end;

function TdxInplaceTimeEdit.EditingPlace: Char;
var
  S: string;
  Pos: Integer;
begin
  S := UpperCase(dxTimeEditFormats[FTimeEditFormat, 0]);
  Pos := SelStart + 1;
  if Pos > MaxLength then Pos := MaxLength;
  Result := S[Pos];
  if not (Result in ['H', 'N', 'S']) then
  begin
    Dec(Pos);
    if Pos < 1 then Pos := 1;
    Result := S[Pos];
  end;
end;

function TdxInplaceTimeEdit.GetTime: TTime;
begin
  Result := FTime;
end;

function TdxInplaceTimeEdit.IsTimeStored: Boolean;
begin
  Result := FTime <> 0.0;
end;

procedure TdxInplaceTimeEdit.SetTime(Value: TTime);
begin
  if FTime <> Value then
  begin
    if Assigned(Container) and Container.IsInitEdit then
      SetValue(Value)
    else
      if EditCanModify then
        SetValue(Value);
  end;
end;

procedure TdxInplaceTimeEdit.SetTimeEditFormat(Value: TdxTimeEditFormat);
begin
  if FTimeEditFormat <> Value then
  begin
    FTimeEditFormat := Value;
    EditMask := dxTimeEditFormats[FTimeEditFormat, 1];
  end;
end;

{ TdxInplaceCurrencyEdit }

constructor TdxInplaceCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption]; 
  FDecimalPlaces := 2;
  FDisplayFormat := DefaultDisplayFormat;
end;

function TdxInplaceCurrencyEdit.DefaultDisplayFormat: string;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.DisplayFormat
  else Result := '';
  if Result = '' then
    Result := DefaultCurrencyDisplayFormat;
end;

function TdxInplaceCurrencyEdit.DefaultMaxValue: Double;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.MaxValue
  else Result := 0;
end;

function TdxInplaceCurrencyEdit.DefaultMinValue: Double;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.MinValue
  else Result := 0;
end;

function TdxInplaceCurrencyEdit.IsNeededRedraw: Boolean;
begin
  Result := inherited IsNeededRedraw or (FDisplayFormat <> '');
end;

procedure TdxInplaceCurrencyEdit.RestoreDefaults;
begin
  inherited RestoreDefaults;
  SetEditDisplayFormat(DefaultDisplayFormat);
//  SetEditMaxValue(DefaultMaxValue);
//  SetEditMinValue(DefaultMinValue);
  SetEditMinMaxValues(DefaultMinValue, DefaultMaxValue);
end;

procedure TdxInplaceCurrencyEdit.SetMinMaxValues(AMinValue, AMaxValue: Double);
begin
  Include(FStoredValues, svMinValue);
  Include(FStoredValues, svMaxValue);
  SetEditMinMaxValues(AMinValue, AMaxValue);
end;

procedure TdxInplaceCurrencyEdit.ValidateEdit;
begin
  inherited ValidateEdit;
  if Modified then
    if not ((Text = '') and Nullable) then
      SetValue(GetValue);
end;

procedure TdxInplaceCurrencyEdit.KeyPress(var Key: Char);
begin
  if not (UseThousandSeparator and (Key = ThousandSeparator)) and
    (Key in ['.', ',']) then
    Key := DecimalSeparator;
  if (Key in [#32 .. #255]) and not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0);
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TdxInplaceCurrencyEdit.AssignEditProperties;
begin
  inherited AssignEditProperties;
  if not (svDisplayFormat in StoredValues) then
    SetEditDisplayFormat(DefaultDisplayFormat);

  if not (svMaxValue in StoredValues) and not (svMinValue in StoredValues) then
    SetEditMinMaxValues(DefaultMinValue, DefaultMaxValue)
  else
  begin
    if not (svMaxValue in StoredValues) then
      SetEditMaxValue(DefaultMaxValue);
    if not (svMinValue in StoredValues) then
      SetEditMinValue(DefaultMinValue);
  end;
end;

function TdxInplaceCurrencyEdit.IsDisableDragDrop: Boolean;
begin
  Result := True;
end;

function TdxInplaceCurrencyEdit.IsValidChar(Key: Char): Boolean;
var
  S: string;
  V: Double;
  StartPos, StopPos, DecPos: Integer;
  ValidChars: set of Char;
begin
  Result := False;
  ValidChars := [DecimalSeparator, '-', '+', '0'..'9', 'e', 'E'];
  if UseThousandSeparator then
    ValidChars := ValidChars + [ThousandSeparator];
  if not (Key in ValidChars) then
    Exit;
  S := Text;
  StartPos := SelStart;
  StopPos := SelStart + SelLength;
  System.Delete(S, SelStart + 1, StopPos - StartPos);
  if (Key = '-') and (S = '') then
  begin
    Result := True;
    Exit;
  end;
  System.Insert(Key, S, StartPos + 1);
  DecPos := Pos(DecimalSeparator, S);
  if (DecPos > 0) then
  begin
    StartPos := Pos('E', UpperCase(S));
    if (StartPos > DecPos) then
      DecPos := StartPos - DecPos - 1
    else DecPos := Length(S) - DecPos;
    if DecPos > DecimalPlaces then Exit;
  end;
  if StrToFloatEx(S, V) then
    Result := True;
{  try
    StrToFloat(S);
    Result := True;
  except
  end;}
end;

procedure TdxInplaceCurrencyEdit.LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean);
var
  V: Double;
  Value: Variant;
begin
  if FDisplayFormat <> '' then
  begin
    V := 0;
    if Assigned(DataDefinition) and IsPaintCopy then
    begin
      Value := DataDefinition.EditValue;
      if VarIsNull(Value) or ((VarType(Value) = varString) and (Value = '')) then
      begin
        if Nullable then
        begin
          Data := NullString;
          Exit;
        end
        else
          V := 0;
      end
      else
        V := Value;
    end
    else
    begin
      inherited LoadDisplayValue(Data, IsPaintCopy);
      try
        if Data = '' then
          if Nullable then
          begin
            Data := NullString;
            Exit;
          end
          else
            V := 0
        else
          StrToFloatEx(Data, V);
      except
        on EConvertError do;
      end;
    end;
    Data := FormatFloat(FDisplayFormat, V);
  end
  else
    inherited LoadDisplayValue(Data, IsPaintCopy);
end;

function TdxInplaceCurrencyEdit.ReturnEditValue: Variant;
begin
  if Nullable and (Text = '') then
    Result := Null
  else
    Result := inherited ReturnEditValue;
end;

procedure TdxInplaceCurrencyEdit.SetEditEditMask(const Value: string);
begin
end;

procedure TdxInplaceCurrencyEdit.SetEditDisplayFormat(const Value: string);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    InvalidateClientRect;
  end;
end;

procedure TdxInplaceCurrencyEdit.SetEditMaxValue(Value: Double);
begin
  if Value < FMinValue then Value := FMinValue;
  if FMaxValue <> Value then
  begin
    FMaxValue := Value;
    SetValue(GetValue);
  end;
end;

procedure TdxInplaceCurrencyEdit.SetEditMinValue(Value: Double);
begin
  if Value > FMaxValue then Value := FMaxValue;
  if FMinValue <> Value then
  begin
    FMinValue := Value;
    SetValue(GetValue);
  end;
end;

class function TdxInplaceCurrencyEdit.StrToFloatEx(S: string; var Value: Double): Boolean;
const
  MinDouble = 5.0e-324;
  MaxDouble = 1.7e+308;
var
  I: Integer;
  E: Extended;
begin
  // Ignore Thousand Separators
  for I := Length(S) downto 1 do
    if S[I] = ThousandSeparator then
      Delete(S, I, 1);
  if not TextToFloat(PChar(S), E, fvExtended) or
    ((E <> 0) and ((Abs(E) < MinDouble) or (Abs(E) > MaxDouble))) then
  begin
    Value := 0;
    Result := False;
  end
  else
    begin
      Value := E;
      Result := True;
    end;  
end;

procedure TdxInplaceCurrencyEdit.SetEditMinMaxValues(AMinValue, AMaxValue: Double);
begin
  if AMinValue > AMaxValue then AMinValue := AMaxValue;
  FMinValue := AMinValue;
  FMaxValue := AMaxValue;
  SetValue(GetValue);
end;

function TdxInplaceCurrencyEdit.GetValue: Double;
begin
  if Text = '' then
    Result := 0
  else
    if not StrToFloatEx(Text, Result) then
      Result := MinValue;
end;

function TdxInplaceCurrencyEdit.IsDisplayFormatStored: Boolean;
begin
  Result := svDisplayFormat in StoredValues;
end;

function TdxInplaceCurrencyEdit.IsMaxValueStored: Boolean;
begin
  Result := svMaxValue in StoredValues;
end;

function TdxInplaceCurrencyEdit.IsMinValueStored: Boolean;
begin
  Result := svMinValue in StoredValues;
end;

function TdxInplaceCurrencyEdit.IsValueStored: Boolean;
begin
  Result := GetValue <> 0.0;
end;

procedure TdxInplaceCurrencyEdit.SetDisplayFormat(const Value: string);
begin
  Include(FStoredValues, svDisplayFormat);
  SetEditDisplayFormat(Value);
end;

procedure TdxInplaceCurrencyEdit.SetMaxValue(Value: Double);
begin
  Include(FStoredValues, svMaxValue);
  SetEditMaxValue(Value);
end;

procedure TdxInplaceCurrencyEdit.SetMinValue(Value: Double);
begin
  Include(FStoredValues, svMinValue);
  SetEditMinValue(Value);
end;

procedure TdxInplaceCurrencyEdit.SetNullable(Value: Boolean);
begin
  if FNullable <> Value then
  begin
    FNullable := Value;
    InvalidateClientRect;
  end;
end;

procedure TdxInplaceCurrencyEdit.SetNullString(const Value: string);
begin
  if FNullString <> Value then
  begin
    FNullString := Value;
    InvalidateClientRect;
  end;
end;

procedure TdxInplaceCurrencyEdit.SetValue(Value: Double);
var
  S: string;
  PrevModified: Boolean;
begin
  if MaxValue <> MinValue then
  begin
    if Value < MinValue then Value := MinValue
    else if Value > MaxValue then Value := MaxValue;
  end;
  // TODO !!
  S := FloatToStrF(Value, ffGeneral{ffFixed}, 15, 0);
  PrevModified := Modified;
  try
    if Text <> S then Text := S;
  finally
    Modified := PrevModified;
  end;
end;

procedure TdxInplaceCurrencyEdit.WMPaste(var Message: TWMPaste);
var
  S: string;
begin
  if not CanModify then Exit;
  S := Text;
  inherited;
  try
    StrToFloat(Text);
  except
    Text := S;
    SelectAll;
  end;
end;

procedure TdxInplaceCurrencyEdit.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  if not Application.UpdateFormatSettings then Exit;
  if not (svDisplayFormat in StoredValues) then
  begin
    SysUtils.GetFormatSettings; // TODO?
    SetEditDisplayFormat(DefaultDisplayFormat);
  end;
end;

type // TODO Remove? IntersectRect
  TMemoryStreamReadOnly = class(TCustomMemoryStream)
  public
    procedure SetBuffer(const Buffer; Count: Longint);
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

procedure TMemoryStreamReadOnly.SetBuffer(const Buffer; Count: Longint);
begin
  SetPointer(@Buffer, Count);
end;

function TMemoryStreamReadOnly.Write(const Buffer; Count: Longint): Longint;
begin
  Result := 0;
end;

type
  TDummyGraphic = class(TGraphic);
  TDummyGraphicClass = class of TDummyGraphic;

function IsPictureEmpty(APicture: TPicture): Boolean;
begin
  Result := not Assigned(APicture.Graphic) or APicture.Graphic.Empty;
end;

procedure LoadPicture(Picture: TPicture; GraphicClass: TGraphicClass; const Value: Variant);
{ Paradox graphic BLOB header - see DB.pas}
type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;
var
  Stream: TMemoryStreamReadOnly;
  Size: Longint;
  Header: TGraphicHeader;
  Graphic: TGraphic;
begin
  if VarType(Value) = varString then // Field.Value -> stored as string
  begin
    Stream := TMemoryStreamReadOnly.Create;
    try
      Size := Length(Value);
      if Size >= SizeOf(TGraphicHeader) then
      begin
        Stream.SetBuffer(string(Value)[1], Size);
        Stream.Position := 0;
        Stream.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> Size - SizeOf(Header)) then
          Stream.Position := 0;
      end;
//      Picture.Bitmap.LoadFromStream(Stream);
      if Stream.Size > 0 then
      begin
        if GraphicClass = nil then
          Picture.Bitmap.LoadFromStream(Stream)
        else
        begin
          Graphic := TDummyGraphicClass(GraphicClass).Create;
          try
            Graphic.LoadFromStream(Stream);
            Picture.Graphic := Graphic;
          finally
            Graphic.Free;
          end;
        end;
      end
      else
        Picture.Assign(nil);
    finally
      Stream.Free;
    end;
  end
  else
    Picture.Assign(nil);
end;

procedure SavePicture(APicture: TPicture; var AValue: string);
var
  AStream: TMemoryStream;
begin
  if not Assigned(APicture) or IsPictureEmpty(APicture) then
    AValue := ''
  else
  begin
    AStream := TMemoryStream.Create;
    try
      APicture.Graphic.SaveToStream(AStream);
      AStream.Position := 0;
      SetLength(AValue, AStream.Size);
      AStream.ReadBuffer(AValue[1], AStream.Size);
    finally
      AStream.Free;
    end;
  end;
end;

{ TdxPopupToolBar }
constructor TdxPopupToolBar.Create(AOwner: TComponent);
var
  Bmp: TBitmap;
  I: TdxPopupToolBarButton;
begin
  inherited CreateNew(AOwner);
  // create buttons
  Bmp := TBitmap.Create;
  try
    for I := ptbCut to ptbCustom do
    begin
      if ResButtons[I] <> '' then
        Bmp.LoadFromResourceName(HInstance, ResButtons[I])
      else
      with Bmp do
      begin
        Canvas.Brush.Color := clBtnFace;
        Canvas.FillRect(Rect(0, 0, Width, Height));
      end;
      FButtons[I] := CreateButton(ToolButtons[I, 0], ToolButtons[I, 1], Bmp);
    end;
  finally
    Bmp.Free;
  end;
  FToolBarButtons := [ptbCut, ptbCopy, ptbPaste, ptbDelete, ptbLoad, ptbSave];
  FShowCaptions := True;
  FToolBarAlignment := ptaRight;
  BorderIcons := [biSystemMenu];
  BorderStyle := bsToolWindow;
  Caption := LoadStr(dxSToolBarCaption); // 'Toolbox'
  FormStyle := fsStayOnTop;
  ShowHint := True;
  FClipboardFormat := CF_PICTURE;
end;

destructor TdxPopupToolBar.Destroy;
begin
  if FEditPopupMenu <> nil then FEditPopupMenu.Free;
  FEditPopupMenu := nil;
  inherited Destroy;
end;

procedure TdxPopupToolBar.CalcPosition(const P: TPoint);
var
  R: TRect;
  Pos: TPoint;
  A: TdxPopupToolBarAlignment;
begin
//  SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
  R := GetScreenWorkArea(P);
  Pos := P;
  A := ToolBarAlignment;
  if (A = ptaLeft) then
    if (P.X - Width) < R.Left then
      Pos.X := P.X + TWinControl(Owner).Width
    else Pos.X := P.X - Width
  else
  if (A = ptaRight) then
    if (P.X + TWinControl(Owner).Width + Width) > R.Right then
      Pos.X := P.X - Width
    else Pos.X := P.X + TWinControl(Owner).Width
  else
  if (A = ptaTop) then
    if (P.Y - Self.Height < R.Top) then
      Pos.Y := P.Y + TWinControl(Owner).Height
    else Pos.Y := P.Y - Self.Height
  else
  if (A = ptaBottom) then
    if (P.Y > R.Bottom) then
      Pos.Y := P.Y - Height
    else Pos.Y := P.Y + TWinControl(Owner).Height;
  if Pos.X + Width > R.Right then Pos.X := R.Right - Width;
  if Pos.X < R.Left then Pos.X := R.Left;
  if Pos.Y + Height > R.Bottom then Pos.Y := R.Bottom - Height;
  if Pos.Y < R.Top then Pos.Y := R.Top;
  SetBounds(Pos.X, Pos.Y, Width, Height);
end;

procedure TdxPopupToolBar.Hide;
begin
  ShowWindow(Handle, SW_HIDE);
end;

procedure TdxPopupToolBar.RefreshButtons;
var
  BHeight, BWidth, C, H, W, X, Y: Integer;
  I: TdxPopupToolBarButton;
begin
  // Button Height
  BHeight := 22;
  if ShowCaptions and (ToolBarAlignment in [ptaLeft, ptaRight]) then
  begin
    Canvas.Font := Self.Font;
    H := Canvas.TextHeight('Wg') + 9;
    if H > BHeight then BHeight := H;
  end;
  // Button Width
  BWidth := BHeight + 1;
  W := 0;
  C := 0;
  for I := ptbCut to ptbCustom do
    if I in ToolBarButtons then
    begin
      if ShowCaptions and (ToolBarAlignment in [ptaLeft, ptaRight]) then
      begin
        if I <> ptbCustom then
          FButtons[I].Caption := ToolButtons[I, 0]
        else FButtons[I].Caption := CustomButtonCaption;
      end
      else FButtons[I].Caption := '';
      H := Canvas.TextWidth(FButtons[I].Caption);
      if H > W then W := H;
      Inc(C);
    end;
  if ToolBarAlignment in [ptaLeft, ptaRight] then
  begin
    if W <> 0 then Inc(BWidth, W);
    ClientWidth := BWidth;
    ClientHeight := C * BHeight;
  end
  else
  begin
    ClientHeight := BHeight;
    ClientWidth := BWidth * C;
  end;
  Y := 0;
  X := 0;
  for I := ptbCut to ptbCustom do
    if I in ToolBarButtons then
    begin
      FButtons[I].SetBounds(X, Y, BWidth, BHeight);
      FButtons[I].Visible := True;
      if ToolBarAlignment in [ptaLeft, ptaRight] then
        Inc(Y, BHeight)
      else Inc(X, BWidth);
    end
    else
      FButtons[I].Visible := False;
  // Buttons Enabled
  SetButtonsEnabled;
end;

procedure TdxPopupToolBar.Show;
begin
  if not CanShow or FFlagHide then Exit;
  SendMessage(Handle, WM_NCACTIVATE, Longint(True), 0);
  ShowWindow(Handle, SW_SHOWNOACTIVATE);
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

function TdxPopupToolBar.Visible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TdxPopupToolBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

procedure TdxPopupToolBar.CreateWnd;
var
  SysMenu: HMENU;
begin
  inherited CreateWnd;
  if Handle <> 0 then
  begin
    FNextWindow := SetClipboardViewer(Handle);
    FChained := True;
    SysMenu := GetSystemMenu(Handle, False);
    DeleteMenu(SysMenu, SC_MAXIMIZE, MF_BYCOMMAND);
    DeleteMenu(SysMenu, SC_MINIMIZE, MF_BYCOMMAND);
    DeleteMenu(SysMenu, SC_SIZE, MF_BYCOMMAND);
    DeleteMenu(SysMenu, SC_RESTORE, MF_BYCOMMAND);
  end;
end;

procedure TdxPopupToolBar.DestroyWindowHandle;
begin
  if FChained then
  begin
    ChangeClipboardChain(Handle, FNextWindow);
    FChained := False;
  end;
  FNextWindow := 0;
  inherited DestroyWindowHandle;
end;

procedure TdxPopupToolBar.ButtonClick(Sender: TObject);
var
  I: TdxPopupToolBarButton;
begin
  if Assigned(FOnButtonClick) then
    for I := ptbCut to ptbCustom do
      if FButtons[I] = Sender then
      begin
        FOnButtonClick(Self, I);
//        if Owner <> nil then TWinControl(Owner).SetFocus;
        Break;
      end;
end;

function TdxPopupToolBar.CreateButton(const ACaption, AHint: string; AGlyph: TBitmap): TSpeedButton;
begin
  Result := TSpeedButton.Create(Self);
  with Result do
  begin
    Caption := ACaption;
    Hint := AHint;
    Glyph := AGlyph;
    Flat := True;
    Margin := 4;
    Parent := Self;
    OnClick := ButtonClick;
  end;
end;

procedure TdxPopupToolBar.ForwardMessage(var Message: TMessage);
begin
  if FNextWindow <> 0 then
    with Message do
      SendMessage(FNextWindow, Msg, WParam, LParam);
end;

function TdxPopupToolBar.GetCustomButtonCaption: string;
begin
  Result := FButtons[ptbCustom].Caption;
end;

function TdxPopupToolBar.GetCustomButtonGlyph: TBitmap;
begin
  Result := FButtons[ptbCustom].Glyph;
end;

procedure TdxPopupToolBar.SetButtonsEnabled;
var
  FlagRO, FlagEmpty: Boolean;
begin
  FlagRO := IsReadOnly;
  FlagEmpty := IsEmpty;
  FButtons[ptbCut].Enabled := not FlagEmpty and not FlagRO;
  FButtons[ptbCopy].Enabled := not FlagEmpty;
  FButtons[ptbPaste].Enabled := not FlagRO and Clipboard.HasFormat(ClipboardFormat);
  FButtons[ptbDelete].Enabled := not FlagEmpty and not FlagRO;
  FButtons[ptbLoad].Enabled := not FlagRO;
  FButtons[ptbSave].Enabled := not FlagEmpty;
  if IsPopupMenu and (FEditPopupMenu <> nil) then
    with FEditPopupMenu do
    begin
      Items[0].Enabled := FButtons[ptbCut].Enabled;
      Items[1].Enabled := FButtons[ptbCopy].Enabled;
      Items[2].Enabled := FButtons[ptbPaste].Enabled;
      Items[3].Enabled := FButtons[ptbDelete].Enabled;
      Items[5].Enabled := FButtons[ptbLoad].Enabled;
      Items[6].Enabled := FButtons[ptbSave].Enabled;
    end;
end;

procedure TdxPopupToolBar.SetCustomButtonCaption(const Value: string);
begin
  FButtons[ptbCustom].Caption := Value;
  RefreshButtons;
end;

procedure TdxPopupToolBar.SetCustomButtonGlyph(Value: TBitmap);
begin
  FButtons[ptbCustom].Glyph := Value;
end;

procedure TdxPopupToolBar.SetToolBarAlignment(Value: TdxPopupToolBarAlignment);
begin
  if FToolBarAlignment <> Value then
  begin
    FToolBarAlignment := Value;
    RefreshButtons;
  end;
end;

procedure TdxPopupToolBar.SetToolBarButtons(Value: TdxPopupToolBarButtons);
begin
  if FToolBarButtons <> Value then
  begin
    FToolBarButtons := Value;
    RefreshButtons;
  end;
end;

procedure TdxPopupToolBar.WMActivate(var Message: TMessage);
begin
  SendMessage(GetParentForm(TWinControl(Owner)).Handle, WM_NCACTIVATE, Longint(True), 0);
  inherited;
  SetButtonsEnabled;
end;

procedure TdxPopupToolBar.WMChangeCBChain(var Message: TWMChangeCBChain);
begin
  if Message.Remove = FNextWindow then
    FNextWindow := Message.Next
  else ForwardMessage(TMessage(Message));
  inherited;
end;

procedure TdxPopupToolBar.WMClose(var Message: TWMClose);
begin
  inherited;
  if True then
  begin
    FFlagHide := True;
    Hide;
  end;
end;

procedure TdxPopupToolBar.WMDrawClipboard(var Message: TMessage);
begin
  SetButtonsEnabled;
  ForwardMessage(Message);
  inherited;
end;

procedure TdxPopupToolBar.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if (Owner <> nil) and
    (Msg.FocusedWnd <> TWinControl(Owner).Handle) then Hide;
end;

procedure TdxPopupToolBar.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  Message.Result := MA_NOACTIVATE;
end;

procedure TdxPopupToolBar.WMNCDestroy(var Message: TWMNCDestroy);
begin
  if FChained then
  begin
    ChangeClipboardChain(Handle, FNextWindow);
    FChained := False;
    FNextWindow := 0;
  end;
  inherited;
end;

procedure TdxPopupToolBar.CMShowingChanged(var Message: TMessage);
begin
end;

{ TdxPopupToolBarWindow }
constructor TdxPopupToolBarWindow.Create(AGraphicEdit: TdxInplaceGraphicEdit);
begin
  inherited Create;
  FGraphicEdit := AGraphicEdit;
  FAlignment := ptaBottom;
  FButtons := [ptbCut, ptbCopy, ptbPaste, ptbDelete, ptbLoad, ptbSave];
  FIsPopupMenu := True;
  FShowCaptions := True;
  FVisible := True;
end;

destructor TdxPopupToolBarWindow.Destroy;
begin
  if FCustomButtonGlyph <> nil then
    FCustomButtonGlyph.Free;
  inherited Destroy;
end;

procedure TdxPopupToolBarWindow.Assign(Source: TPersistent);
begin
  if Source is TdxPopupToolBarWindow then
  begin
     Alignment := TdxPopupToolBarWindow(Source).Alignment;
     Buttons := TdxPopupToolBarWindow(Source).Buttons;
     CustomButtonCaption := TdxPopupToolBarWindow(Source).CustomButtonCaption;
     CustomButtonGlyph := TdxPopupToolBarWindow(Source).CustomButtonGlyph;
     IsPopupMenu := TdxPopupToolBarWindow(Source).IsPopupMenu;
     ShowCaptions := TdxPopupToolBarWindow(Source).ShowCaptions;
     Visible := TdxPopupToolBarWindow(Source).Visible;
  end
  else
    inherited Assign(Source);
end;

function TdxPopupToolBarWindow.GetCustomButtonGlyph: TBitmap;
begin
  if FCustomButtonGlyph = nil then
    FCustomButtonGlyph := TBitmap.Create;
  Result := FCustomButtonGlyph;
end;

procedure TdxPopupToolBarWindow.SetCustomButtonGlyph(Value: TBitmap);
begin
  if (Value = nil) then
  begin
    FCustomButtonGlyph.Free;
    FCustomButtonGlyph := nil;
  end
  else
    CustomButtonGlyph.Assign(Value);
end;

procedure TdxPopupToolBarWindow.SetIsPopupMenu(Value: Boolean);
begin
  FIsPopupMenu := Value;
  if FGraphicEdit <> nil then
    FGraphicEdit.FPopupToolBar.FIsPopupMenu := Value;
end;

{ TdxInplaceGraphicEdit }
constructor TdxInplaceGraphicEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csClickEvents, csDoubleClicks];
  AutoSize := False;
  ParentColor := False;
  Width := 140;
  Height := 100;
  FCenter := True;
  FClipboardFormat := CF_PICTURE;
  FDblClickActivate := True;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
//  FTempPicture := TPicture.Create;
  FPopupToolBar := TdxPopupToolBar.Create(Self);
  FPopupToolBar.OnButtonClick := ToolButtonClick;
  FPopupToolBar.FIsPopupMenu := True;
  FSavePos := Point(-10000, -10000);
  FToolbarLayout := TdxPopupToolBarWindow.Create(Self);
  FToolbarPos := Point(-10000, -10000);
  FToolbarPosStored := True;
end;

destructor TdxInplaceGraphicEdit.Destroy;
begin
  FToolbarLayout.Free;
  FPopupToolBar.Free;
  FTempTransparentBitmap.Free;
  FTempPicture.Free;
  FPicture.Free;
  inherited Destroy;
end;

class procedure TdxInplaceGraphicEdit.CalcViewInfo(AViewData: TdxEditViewData;
  AutoSize: Boolean; var ViewInfo: TdxEditViewInfo);
begin
  if AutoSize and IsPictureEmpty(TdxGraphicEditViewData(AViewData).Picture) then
    AutoSize := False;
  inherited CalcViewInfo(AViewData, AutoSize, ViewInfo);
end;

procedure TdxInplaceGraphicEdit.ClearPicture;
begin
  if EditCanModify then
    FPicture.Graphic := nil;
end;

procedure TdxInplaceGraphicEdit.CopyToClipboard;
begin
  if (FPicture <> nil) and (FPicture.Graphic <> nil) then
    Clipboard.Assign(FPicture);
end;

procedure TdxInplaceGraphicEdit.CutToClipboard;
begin
  CopyToClipboard;
  if CanModify then ClearPicture;
end;

class function TdxInplaceGraphicEdit.DrawClientArea(ADC: HDC; var ARect: TRect;
  AViewData: TdxEditViewData; IsControl: Boolean): Boolean;

  procedure CalcStretchRect(R: TRect; W, H: Integer; var CalcRect: TRect);
  var
    W1, H1: Integer;
  begin
    CalcRect.Left := R.Left;
    CalcRect.Top := R.Top;
    W1 := R.Right - R.Left;
    H1 := R.Bottom - R.Top;
    if W / H > W1 / H1 then
    begin
      CalcRect.Right := R.Right;
      CalcRect.Bottom := CalcRect.Top + (W1 * H div W);
    end
    else
    begin
      CalcRect.Bottom := R.Bottom;
      CalcRect.Right := CalcRect.Left + (H1 * W div H);
    end;
  end;

var
  Canvas: TCanvas;
  R, R1, TempRect: TRect;
  PrevClipRgn: HRGN;
  ASaveDC: HDC;
begin
  with TdxGraphicEditViewData(AViewData) do
  begin
    if CalcHeight then
    begin
      LineCount := 1;
      if not Stretch and not IsPictureEmpty(Picture) then
        LineHeight := Picture.Height
      else LineHeight := 0;
    end
    else
    begin
      TempCanvas.Lock;
      ASaveDC := SaveDC(ADC);
      try
        TempCanvas.Handle := ADC;
        // draw picture
//        if not DrawShadow or Transparent or (TempDrawBitmap = nil) then
        if Transparent or (not DrawShadow and (TempDrawBitmap = nil)) then
        begin
          Canvas := TempCanvas;
          R := ARect;
        end
        else
        begin
          Canvas := TempDrawBitmap.Canvas;
          R := ARect;
          OffsetRect(R, -R.Left, -R.Top);
          CheckDrawBitmap(TempDrawBitmap, R.Right - R.Left, R.Bottom - R.Top);
        end;
        with Canvas do
        begin
          // Picture
          if not IsPictureEmpty(Picture) then
          begin
            // QuickDraw
            if QuickDraw and (Picture.Graphic is TBitmap) then
              Picture.Bitmap.IgnorePalette := QuickDraw;
            // Graphic
            PrevClipRgn := CreateRectRgn(0, 0, 0, 0);
            if GetClipRgn(Handle, PrevClipRgn) <> 1 then
            begin
              DeleteObject(PrevClipRgn);
              PrevClipRgn := 0;
            end;
            // Focused Frame
            if not IsInplace and Focused then
            begin
              Windows.FrameRect(Handle, R, GetSysColorBrush(COLOR_WINDOWFRAME));
              with R do
                IntersectClipRect(Handle, Left + 1, Top + 1, Right - 1, Bottom - 1);
            end
            else
              with R do
                IntersectClipRect(Handle, Left, Top, Right, Bottom);
            // Calc Rect
            TempRect := R;
            // Offset (Inplace)
            Inc(TempRect.Left, OffsetSize.Left);
            Inc(TempRect.Top, OffsetSize.Top);
            Dec(TempRect.Right, OffsetSize.Right);
            Dec(TempRect.Bottom, OffsetSize.Bottom);
            if Stretch then
              CalcStretchRect(TempRect{R}, Picture.Width, Picture.Height, R1)
            else
              with TempRect{R} do
              begin
                R1 := Rect(Left, Top, Left + Picture.Width, Top + Picture.Height);
                if Center then
                begin
                  OffsetRect(R1, (Right - Left - Picture.Width) div 2, 0);
                  OffsetRect(R1, 0, (Bottom - Top - Picture.Height) div 2);
                end;
              end;
            if Picture.Graphic.Transparent then
            begin
              // Temp
              if (TempDrawBitmap = nil) and (TempTransparentBitmap <> nil) then
              begin
                CheckDrawBitmap(TempTransparentBitmap, R.Right - R.Left, R.Bottom - R.Top);
                with TempTransparentBitmap.Canvas do
                begin
                  with R do
                  begin
                    Windows.FillRect(Handle, Rect(0, 0, Right - Left, Bottom - Top),
                      TdxGraphicEditViewData(AViewData).Brush);
                    OffsetRect(R1, -Left, -Top);
                  end;
                  StretchDraw(R1, Picture.Graphic);
                end;
                with R do
                  Windows.BitBlt(Handle, Left, Top, Right - Left, Bottom - Top,
                    TempTransparentBitmap.Canvas.Handle, 0, 0, SRCCOPY);
              end
              else
              begin
                Windows.FillRect(Handle, R, TdxGraphicEditViewData(AViewData).Brush);
                StretchDraw(R1, Picture.Graphic);
              end;
            end
            else
            begin
              StretchDraw(R1, Picture.Graphic);
              with R1 do
                ExcludeClipRect(Handle, Left, Top, Right, Bottom);
              Windows.FillRect(Handle, R, TdxGraphicEditViewData(AViewData).Brush)
            end;
            if PrevClipRgn <> 0 then
            begin
              SelectClipRgn(Handle, PrevClipRgn);
              DeleteObject(PrevClipRgn);
            end
            else
              SelectClipRgn(Handle, 0);
          end
          else
          begin
            R1 := R;
            // Focused Frame
            if not IsInplace and Focused then
            begin
              Windows.FrameRect(Handle, R1, GetSysColorBrush(COLOR_WINDOWFRAME));
              InflateRect(R1, -1, -1);
            end;
            if Data <> '' then
              with TdxGraphicEditViewData(AViewData) do
                DrawTextRect(Handle, PChar(string(Data)), Length(Data), R1, R1,
                  DX_DTR_CENTER or DrawAlignmentFlags[daVCenter] or TransparentFlags[Transparent],
                  Brush, Font, BkColor, TextColor, nil)
            else
              Windows.FillRect(Handle, R1, TdxGraphicEditViewData(AViewData).Brush);
          end;
          if DrawShadow then ShadeRect(Handle, R, ShadowColor);
//          if DrawShadow and (TempDrawBitmap <> nil) then
          if not (Transparent or (not DrawShadow and (TempDrawBitmap = nil))) then
            with ARect do
              BitBlt(ADC, Left, Top, Right - Left, Bottom - Top, Handle, 0, 0, SRCCOPY);
        end;
      finally
        TempCanvas.Handle := 0;
        TempCanvas.Unlock;
      end;
      RestoreDC(ADC, ASaveDC);
    end;
  end;
  Result := True;
end;

procedure TdxInplaceGraphicEdit.DoKillFocus(var Message: TWMKillFocus);
begin
  HidePopupToolbar;
  inherited DoKillFocus(Message);
end;

class function TdxInplaceGraphicEdit.GetMinRect(AViewData: TdxEditViewData): TRect;
begin
  with TdxGraphicEditViewData(AViewData) do
  begin
    if not IsPictureEmpty(Picture) then
      Result := Rect(0, 0, Picture.Graphic.Width, Picture.Graphic.Height)
    else Result := inherited GetMinRect(AViewData);
  end;
end;

function TdxInplaceGraphicEdit.IsFocused: Boolean;
begin
  Result := inherited IsFocused or
    ((FPopupToolBar <> nil) and (FPopupToolBar.Focused));
end;

function TdxInplaceGraphicEdit.IsNeededRedraw: Boolean;
begin
  Result := Assigned(DataDefinition);
end;

procedure TdxInplaceGraphicEdit.LoadFromFile;
var
  Dialog: TOpenPictureDialog;
begin
  if EditCanModify then
  begin
    Dialog := TOpenPictureDialog.Create(nil);
    try
      with Dialog do
      begin
        if CustomFilter <> '' then
          Filter := CustomFilter;
        if Execute then
          FPicture.LoadFromFile(FileName);
      end;
    finally
      Dialog.Free;
    end;
  end;
end;

procedure TdxInplaceGraphicEdit.PasteFromClipboard;
begin
  if CanModify and Clipboard.HasFormat(FClipboardFormat{CF_PICTURE}) and EditCanModify then
    if (FClipboardFormat = CF_PICTURE) and Clipboard.HasFormat(CF_BITMAP) then // default format
      FPicture.Bitmap.Assign(Clipboard)
    else
      FPicture.Assign(Clipboard);
end;

procedure TdxInplaceGraphicEdit.SaveToFile;
var
  Dialog: TSavePictureDialog;
begin
  if (FPicture <> nil) and (FPicture.Graphic <> nil) then
  begin
    Dialog := TSavePictureDialog.Create(Application);
    try
      with Dialog do
      begin
        if CustomFilter <> '' then
          Filter := CustomFilter
        else Filter := GraphicFilter(TGraphicClass(FPicture.Graphic.ClassType));
        DefaultExt := GraphicExtension(TGraphicClass(FPicture.Graphic.ClassType));
        if Execute then
          FPicture.SaveToFile(FileName);
      end;
    finally
      Dialog.Free;
    end;
  end;
end;

procedure TdxInplaceGraphicEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if IsInplace then
    case Key of
      VK_LEFT: MoveCol(True{Left});
      VK_RIGHT: MoveCol(False);
    end;
  inherited KeyDown(Key, Shift);
  case Key of
    VK_INSERT:
      if ssShift in Shift then
        PasteFromClipBoard
      else
        if ssCtrl in Shift then CopyToClipBoard;
    VK_DELETE:
      if ssShift in Shift then CutToClipBoard;
  end;
end;

procedure TdxInplaceGraphicEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    ^X: CutToClipBoard;
    ^C: CopyToClipBoard;
    ^V: PasteFromClipBoard;
  end;
end;

procedure TdxInplaceGraphicEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if DblClickActivate and (ssDouble in Shift) then
    ShowPopupToolbar;
end;

procedure TdxInplaceGraphicEdit.AssignEditValue(const Value: Variant);
var
  PrevModified: Boolean;
begin
  PrevModified := Modified; // TODO Modified
  FInternalChanging := True;
  try
    if (CustomGraphic and (csDesigning in ComponentState)) or
      ((VarType(Value) = varString) and (Value = '')) {Empty} then
      FPicture.Assign(nil)
    else
      LoadPicture(FPicture, GetGraphicClass, Value);
  finally
    FInternalChanging := False;
    Modified := PrevModified;
  end;
end;

function TdxInplaceGraphicEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxGraphicEditViewData(Result) do
  begin
    Center := Self.Center;
    if IsPaintCopy then
      Picture := FTempPicture
    else Picture := FPicture;
    QuickDraw := Self.QuickDraw;
    Stretch := Self.Stretch;
    if not IsPictureEmpty(TdxGraphicEditViewData(Result).Picture) and Picture.Graphic.Transparent then
    begin
      if FTempTransparentBitmap = nil then
        FTempTransparentBitmap := TBitmap.Create;
    end;
    TempTransparentBitmap := FTempTransparentBitmap;
  end;
end;

class function TdxInplaceGraphicEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxGraphicEditViewData;
end;

procedure TdxInplaceGraphicEdit.DoSetFocus;
begin
  inherited;
  if not DblClickActivate then
    ShowPopupToolbar;
end;

// virtual methods
function TdxInplaceGraphicEdit.GetGraphicClass: TGraphicClass;
begin
  Result := nil;
  if Assigned(FOnGetGraphicClass) then FOnGetGraphicClass(Self, Result);
end;

procedure TdxInplaceGraphicEdit.LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean);
begin
  Data := Caption;
  if Assigned(DataDefinition) then
  begin
    if IsPaintCopy then
    begin
      if FTempPicture = nil then
        FTempPicture := TPicture.Create;
      if CustomGraphic and (csDesigning in ComponentState) then
        FTempPicture.Assign(nil)
      else
      begin
        LoadPicture(FTempPicture, GetGraphicClass, DataDefinition.EditValue);
        if FTempPicture.Graphic <> nil then
          FTempPicture.Graphic.Transparent := FGraphicTransparency = gtTransparent;
      end;
    end;
  end;
end;

function TdxInplaceGraphicEdit.ReturnEditValue: Variant;
begin
  AssignPicture(FPicture);
  Result := Integer(FPicture.Graphic);
end;

procedure TdxInplaceGraphicEdit.AssignPicture(Picture: TPicture); // TODO *
begin
  if Assigned(FOnAssignPicture) then
    FOnAssignPicture(Self, Picture);
end;

procedure TdxInplaceGraphicEdit.CustomClick;                     
begin
  if Assigned(FOnCustomClick) then
    FOnCustomClick(Self);
end;

procedure TdxInplaceGraphicEdit.EditPopupMenuClick(Sender: TObject);
begin
  ToolButtonClick(Sender, TdxPopupToolBarButton(TMenuItem(Sender).Tag));
end;

procedure TdxInplaceGraphicEdit.HidePopupToolbar;
begin
  if not FPopupToolbar.Focused then FPopupToolBar.Hide;
end;

procedure TdxInplaceGraphicEdit.PictureChanged(Sender: TObject);
var
  PrevEvent: TNotifyEvent;
begin
  StyleChanged;
  if FGraphicTransparency <> gtDefault then
  begin
    PrevEvent := FPicture.OnChange;
    try
      FPicture.OnChange := nil;
      if not IsPictureEmpty(FPicture) then
        FPicture.Graphic.Transparent := FGraphicTransparency = gtTransparent;
    finally
      FPicture.OnChange := PrevEvent;
    end;
  end;
  if not FInternalChanging and not (csLoading in ComponentState) then
  begin
    Change;
    Modified := True;
  end;
end;

procedure TdxInplaceGraphicEdit.PreparePopup;

  function NewItem(const ACaption: string; {$IFDEF DELPHI4}ABitmap: TBitmap;{$ENDIF} ATag: Integer): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    with Result do
    begin
      Caption := ACaption;
      {$IFDEF DELPHI4}
      if Assigned(ABitmap) then
        Bitmap := ABitmap
      else ImageIndex := ATag;  
      {$ENDIF}
      Tag := ATag;
      OnClick := EditPopupMenuClick;
    end;
  end;

  procedure AddItem(AItems: TMenuItem; AButton: TdxPopupToolBarButton);
  begin
    with AItems do
    begin
      if AButton = ptbCustom then
      begin
        ToolbarLayout.CustomButtonGlyph.Transparent := True;
        Add(NewItem(ToolbarLayout.CustomButtonCaption,
          {$IFDEF DELPHI4}ToolbarLayout.CustomButtonGlyph,{$ENDIF}Integer(AButton)));
      end
      else
        Add(NewItem(ToolButtons[AButton, 0],
          {$IFDEF DELPHI4}nil,{$ENDIF} Integer(AButton)));
      if AButton in [ptbDelete, ptbSave] then
        Add(NewItem('-', {$IFDEF DELPHI4}nil,{$ENDIF} MaxInt));
    end;
  end;

var
  I: TdxPopupToolBarButton;
begin
  with FPopupToolbar do
  begin
    if ToolbarLayout.IsPopupMenu then
    begin
      if FEditPopupMenu = nil then
      begin
        FEditPopupMenu := TPopupMenu.Create(nil);
        {$IFDEF DELPHI4}
        FEditPopupMenu.Images := dxGraphicPopupMenuImages;
        {$ENDIF}
        for I := ptbCut to ptbCustom do
          AddItem(FEditPopupMenu.Items, I);
      end;
      // Visible
      with FEditPopupMenu do
      begin
        Items[0].Visible := ptbCut in ToolbarLayout.Buttons;
        Items[1].Visible := ptbCopy in ToolbarLayout.Buttons;
        Items[2].Visible := ptbPaste in ToolbarLayout.Buttons;
        Items[3].Visible := ptbDelete in ToolbarLayout.Buttons;
        Items[5].Visible := ptbLoad in ToolbarLayout.Buttons;
        Items[6].Visible := ptbSave in ToolbarLayout.Buttons;
        Items[8].Visible := ptbCustom in ToolbarLayout.Buttons;
        // Separators
        Items[4].Visible := Items[5].Visible or Items[6].Visible;
        Items[7].Visible := Items[8].Visible;
        // Custom Item
        with Items[8] do
        begin
          Caption := ToolbarLayout.CustomButtonCaption;
          {$IFDEF DELPHI4}
          Bitmap := ToolbarLayout.CustomButtonGlyph;
          {$ENDIF}
        end;
      end;
    end
    else
    begin
      CanShow := ToolbarLayout.Visible;
      CustomButtonCaption := ToolbarLayout.CustomButtonCaption;
      CustomButtonGlyph := ToolbarLayout.CustomButtonGlyph;
      Font := Self.Font;
      ShowCaptions := ToolbarLayout.ShowCaptions;
      ToolBarAlignment := ToolbarLayout.Alignment;
      ToolBarButtons := ToolbarLayout.Buttons;
    end;
    // Common
    ClipboardFormat := Self.ClipboardFormat;
    IsEmpty := IsPictureEmpty(FPicture);
    IsReadOnly := not CanModify;
  end;
end;

procedure TdxInplaceGraphicEdit.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    PictureChanged(Self);
  end;
end;

procedure TdxInplaceGraphicEdit.SetCustomGraphic(Value: Boolean);
begin
  if FCustomGraphic <> Value then
  begin
    FInternalChanging := True;
    try
      FCustomGraphic := Value;
      PictureChanged(nil);
    finally
      FInternalChanging := False;
    end;
  end;
end;

procedure TdxInplaceGraphicEdit.SetGraphicTransparency(Value: TdxGraphicEditTransparency);
begin
  if FGraphicTransparency <> Value then
  begin
    FInternalChanging := True;
    try
      FGraphicTransparency := Value;
      PictureChanged(nil);
    finally
      FInternalChanging := False;
    end;
  end;
end;

procedure TdxInplaceGraphicEdit.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TdxInplaceGraphicEdit.SetStretch(Value: Boolean);
begin
  if Value <> FStretch then
  begin
    FStretch := Value;
    PictureChanged(Self);
  end;
end;

procedure TdxInplaceGraphicEdit.SetToolbarLayout(Value: TdxPopupToolBarWindow);
begin
  FToolbarLayout.Assign(Value);
end;

procedure TdxInplaceGraphicEdit.SetToolbarPosStored(Value: Boolean);
begin
  FToolbarPosStored := Value;
  if not FToolbarPosStored then
    FToolbarPos := Point(-10000, -10000);
end;

procedure TdxInplaceGraphicEdit.ShowPopupToolbar;
var
  P: TPoint;
  R: TRect;
begin
  if ToolbarLayout.IsPopupMenu or not ToolbarLayout.Visible then Exit;
  with FPopupToolbar do
  begin
    // Settings
    PreparePopup;
    // Position
    if not ((FSavePos.X = -10000) and (FSavePos.Y = -10000)) and
      ((FSavePos.X <> Left) or (FSavePos.Y <> Top)) then
      ToolbarPos := Point(Left, Top);
    P := ToolbarPos;
    if not ToolbarPosStored or ((P.X = -10000) and (P.Y = -10000)) then
    begin
      GetWindowRect(Self.Handle, R);
      P := Point(R.Left, R.Top);
      CalcPosition(P);
    end
    else
    begin
      Left := P.X;
      Top := P.Y;
    end;
    FSavePos := Point(Left, Top);
    // Show
    FFlagHide := False;
    RefreshButtons;
    Show;
  end;
end;

procedure TdxInplaceGraphicEdit.ToolButtonClick(Sender: TObject; Button: TdxPopupToolBarButton);
begin
  case Button of
    ptbCut: CutToClipboard;
    ptbCopy: CopyToClipboard;
    ptbPaste: PasteFromClipboard;
    ptbDelete: ClearPicture;
    ptbLoad: LoadFromFile;
    ptbSave: SaveToFile;
    ptbCustom: CustomClick;
  end;
  FPopupToolbar.RefreshButtons;
end;

procedure TdxInplaceGraphicEdit.WMContextMenu(var Message: TMessage);
var
  P: TPoint;
begin
  inherited;
  if (Message.Result = 0) and not HasPopup(Self) and ToolbarLayout.IsPopupMenu then
  begin
    P := SmallPointToPoint(TSmallPoint(Message.LParam));
    if (P.X = -1) and (P.Y = -1) then
    begin
      GetCaretPos(P);
      if P.X > ClientWidth then
        P.X := ClientWidth;
      Windows.ClientToScreen(Handle, P);
    end;
    // Popup
    PreparePopup;
    with FPopupToolbar do
    begin
      RefreshButtons;
      FEditPopupMenu.Popup(P.X, P.Y);
    end;
  end;
end;

procedure TdxInplaceGraphicEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if IsInplace then
    Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTALLKEYS;
end;

{ TdxInplaceBlobEdit }
constructor TdxInplaceBlobEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSendChildrenStyle := False;
  FImmediatePopupStyle := True;
  // Common
  FBlobPaintStyle := bpsIcon;
  FPopupWidth := 200;
  FPopupHeight := 140;
  FSizeablePopup := True;
  // Memo
  FAlwaysSaveText := True;
  FMemoCharCase := ecNormal;
  FMemoHideScrollBars := True;
  FMemoSelectionBar := True;
  FMemoWantReturns := True;
  FMemoWantTabs := True;
  FMemoWordWrap := True;
  // Picture
  FPictureAutoSize := True;
  FPictureClipboardFormat := CF_PICTURE;
  FShowExPopupItems := True;
  FShowPicturePopup := True;
end;

destructor TdxInplaceBlobEdit.Destroy;
begin
  if FPopupMenu <> nil then FPopupMenu.Free;
  if FPopup <> nil then FPopup.Free;
  if FTempPicture <> nil then FTempPicture.Free;
  inherited Destroy;
end;

class procedure TdxInplaceBlobEdit.CalcButtonsInfo(AViewData: TdxEditViewData);
begin
  inherited CalcButtonsInfo(AViewData);
  with TdxBlobEditViewData(AViewData) do
    if not HideButtons and (BlobEditKind in BlobEditKindUnknown) then
      Buttons[0].Kind := bkEllipsis;
end;

class function TdxInplaceBlobEdit.DrawClientArea(ADC: HDC; var ARect: TRect;
  AViewData: TdxEditViewData; IsControl: Boolean): Boolean;
const
  AlignmentFlags: array [TAlignment] of Integer = (
    DX_DTR_LEFT, DX_DTR_RIGHT, DX_DTR_CENTER);
  FocusFlags: array [Boolean] of Integer = (0, DX_DTR_FOCUS_RECT);
  Icons: array [TdxBlobEditKind] of Integer = (Integer(biMemo), Integer(biPict),
    Integer(biOle), Integer(biBlob));
  TransparentFlags: array [Boolean] of Integer = (0, DX_DTR_TRANSPARENT);
var
  W, H, ImageIndex: Integer;
  R: TRect;
begin
  with TdxBlobEditViewData(AViewData) do
  begin
    if BlobPaintStyle = bpsIcon then
    begin
      ImageIndex := Icons[BlobEditKind];
      if IsNull then Dec(ImageIndex);
      if Images <> nil then
      begin
        W := Images.Width;
        H := Images.Height;
        with ARect do
        begin
          R.Left := (Left + Right - W) div 2;
          R.Top := (Top + Bottom - H) div 2;
          R.Right := R.Left + W;
          R.Bottom := R.Top + H;
        end;
        if not CalcHeight then // Draw
        begin
          if not Transparent then
            FillRect(ADC, ARect, Brush);
          if (Images <> nil) and (0 <= ImageIndex) and (ImageIndex < Images.Count) then
            DrawImage(ADC, R.Left, R.Top, ImageIndex, Images);
        end;
        Transparent := True;
      end;
      Data := '';
    end
    else
    begin
      EndEllipsis := True;
      DrawAlignment := daMultiLine;
    end;
    Result := inherited DrawClientArea(ADC, ARect, AViewData, False);
  end;
end;

function TdxInplaceBlobEdit.IsEditClass: Boolean;
begin
  Result := False;
end;

procedure TdxInplaceBlobEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if IsInplace then
    case Key of
      VK_LEFT : MoveCol(True);
      VK_RIGHT : MoveCol(False);
    end;
  if (Key = VK_DELETE) then Key := 0;
  inherited KeyDown(Key, Shift);
end;

procedure TdxInplaceBlobEdit.KeyPress(var Key: Char);
begin
  if FListVisible and (FActiveList <> nil) and FActiveList.Focused and
    (FPopup.Text = '') then
    PostMessage(FActiveList.Handle, WM_CHAR, Ord(Key), 0);
  Key := #0;
  inherited KeyPress(Key);
end;

procedure TdxInplaceBlobEdit.AssignEditValue(const Value: Variant);
begin
  if VarIsNull(Value) then
    FBlobData := ''
  else
    FBlobData := Value;
  InvalidateClientRect;
end;

function TdxInplaceBlobEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxBlobEditViewData(Result) do
  begin
    Focused := Focused and not IsInplace and not DroppedDown;
//    FocusRect := True and not IsInplace;
    BlobEditKind := Self.BlobEditKind;
    BlobPaintStyle := Self.BlobPaintStyle;
    if BlobPaintStyle = bpsIcon then
    begin
      Images := imgBlobImages;
      if not IsPaintCopy then
        IsNull := Text = '' // set actual null state
      else
        IsNull := GetIsNull(Data);
    end;
    BlobText := Self.BlobText;
  end;
end;

function TdxInplaceBlobEdit.GetIsNull(const Data: Variant): Boolean;
begin
  Result := VarIsNull(Data) or ((VarType(Data) = varString) and (Data = ''));
end;

procedure TdxInplaceBlobEdit.LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean);
var
  Value: Variant;
begin
  if Assigned(DataDefinition) then
  begin
    if BlobPaintStyle = bpsText then
      Value := DataDefinition.EditValue
    else
      Value := DataDefinition.DisplayValue;
    if VarIsNull(Value) then
      Data := ''
    else
      Data := Value;
  end
  else
    Data := BlobText;
end;

class function TdxInplaceBlobEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxBlobEditViewData;
end;

function TdxInplaceBlobEdit.ReturnEditValue: Variant;
begin
  if BlobEditKind = bekPict then
  begin
    if FTempPicture = nil then
      FTempPicture := TPicture.Create;
    LoadPicture(FTempPicture, PictureGraphicClass, Text);
    AssignPicture(FTempPicture);
    Result := Integer(FTempPicture.Graphic);
  end
  else
    if Text = '' then
      Result := Null
    else
      Result := Text;
end;

procedure TdxInplaceBlobEdit.CloseUp(Accept: Boolean);
begin
//  FListVisible := False;
end;

procedure TdxInplaceBlobEdit.SavePopupSize(W, H: Integer);
begin
  FPopupWidth := W;
  FPopupHeight := H;
  if Assigned(FOnSavePopupSize) then FOnSavePopupSize(Self);
end;

procedure TdxInplaceBlobEdit.SetBlobValue(Sender: TObject);
var
  S: string;
begin
  FPopup.OnSaveChanges := nil;
  if EditCanModify then
  begin
    case BlobEditKind of
      bekMemo:
        begin
          Text := FPopup.FBlobText;
          if BlobPaintStyle = bpsText then
            BlobText := Text;
        end;
      bekPict:
        begin
          if IsPictureEmpty(FPopup.Picture) then
          begin
            Text := '';
            PictureGraphicClass := nil;
          end
          else
          begin
            PictureGraphicClass := TGraphicClass(FPopup.Picture.Graphic.ClassType);
            SavePicture(FPopup.Picture, S);
            Text := S;
          end;
        end;
    end;
    Modified := True;
  end;
end;

procedure TdxInplaceBlobEdit.DropDown;
var
  P: TPoint;
begin
  if FListVisible or DroppedDown {TODO one code} then Exit;
  EditButtonClick;
  if BlobEditKind in BlobEditKindUnknown then Exit;
  if FPopup = nil then
  begin
    FPopup := TCustomdxBlobPopup.Create(nil);
    FPopup.OwnerControl := Self;
    FActiveList := FPopup;
  end;
  with FPopup do
  begin
    Color := Self.Color;
    Font := Self.Font;
    FBlobText := '';
    FBlobTextSaved := False;
    // Common
    BlobEditKind := Self.BlobEditKind;
    PopupBorderStyle := Self.PopupBorderStyle;
    Shadow := Self.Style.Shadow;
    Sizeable := Self.SizeablePopup;
    // Memo
    AlwaysSaveText := Self.AlwaysSaveText;
    CharCase := MemoCharCase;
    HideScrollBars := MemoHideScrollBars;
    MaxLength := MemoMaxLength;
    OEMConvert := MemoOEMConvert;
    ScrollBars := MemoScrollBars;
    SelectionBar := MemoSelectionBar;
    WantReturns := MemoWantReturns;
    WantTabs := MemoWantTabs;
    WordWrap := MemoWordWrap;
    // Picture
    AutoSize := PictureAutoSize;
    ClipboardFormat := PictureClipboardFormat;
    GraphicClass := GetGraphicClass;
    GraphicTransparency := PictureTransparency;
    PictureFilter := Self.PictureFilter;
    // Load Data
    case BlobEditKind of
      bekPict:
        try
          dxExEdtr.LoadPicture(Picture, GraphicClass, Self.Text);
        except
          Picture.Assign(nil);
          raise;
        end;
    else
      Text := Self.Text;
    end;
    ReadOnly := not Self.CanModify;
    Modified := False;
    OnSaveChanges := SetBlobValue;
    OnHide := SaveSize;
    P := Point(Self.Left, Self.Top + Self.Height);
    Windows.ClientToScreen(Self.Parent.Handle, P);
    FPopup.SetSize(P, PopupWidth, PopupHeight);
    CalcPosition(FPopup, False);
    FListVisible := True;
    ShowPopup;
  end;
end;

// virtual methods
procedure TdxInplaceBlobEdit.AssignPicture(Picture: TPicture);
begin
  if Assigned(FOnAssignPicture) then
    FOnAssignPicture(Self, Picture);
end;

function TdxInplaceBlobEdit.GetGraphicClass: TGraphicClass;
begin
  Result := PictureGraphicClass;
  if Assigned(FOnGetGraphicClass) then FOnGetGraphicClass(Self, Result);
end;

function TdxInplaceBlobEdit.IsSizeablePopup: Boolean;
begin
  Result := True;
end;

// private TdxInplaceBlobEdit
function TdxInplaceBlobEdit.GetBlobText: string;
begin
  Result := inherited Text; 
end;

procedure TdxInplaceBlobEdit.SaveSize(Sender: TObject);
begin
  if FPopup <> nil then
    SavePopupSize(FPopup.Width, FPopup.Height);
end;

procedure TdxInplaceBlobEdit.SetBlobData(const Value: string);
begin
  if FBlobData <> Value then
  begin
    if Assigned(Container) and Container.IsInitEdit then
      FBlobData := Value
    else
      if EditCanModify then
      begin
        FBlobData := Value;
        Change;
      end;
    InvalidateClientRect;
  end;
end;

procedure TdxInplaceBlobEdit.SetBlobEditKind(Value: TdxBlobEditKind);
begin
  if FBlobEditKind <> Value then
  begin
    FBlobEditKind := Value;
    StyleChanged;
  end;
end;

procedure TdxInplaceBlobEdit.SetBlobPaintStyle(Value: TdxBlobPaintStyle);
begin
  if FBlobPaintStyle <> Value then
  begin
    FBlobPaintStyle := Value;
    InvalidateClientRect;
    //TODO StyleChanged;
  end;
end;

procedure TdxInplaceBlobEdit.SetBlobText(const Value: string);
begin
  AssigningText := True;
  try
    inherited Text := Value;
  finally
    AssigningText := False;  
  end;
end;

procedure TdxInplaceBlobEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTALLKEYS;
end;

{ TCustomdxBlobPopup }
constructor TCustomdxBlobPopup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csClickEvents, csCaptureMouse];
  Width := 185;
  Height := 89;
  TabStop := True;
  ParentColor := False;
  Visible := False;
  FIsPopupControl := True;
  FDrawNC := False;
  FDownButton := -1;
  FButtonPanelHeight := 26;
  FButtons := [bebOk, bebCancel];
  // Memo
  FAlwaysSaveText := True;
  FHideScrollBars := True;
  FSelectionBar := True;
  FWantReturns := True;
  FWantTabs := True;
  FWordWrap := True;
  // Picture
  FClipboardFormat := CF_PICTURE;
end;

destructor TCustomdxBlobPopup.Destroy;
begin
  if FEditPopupMenu <> nil then FEditPopupMenu.Free;
  FEditPopupMenu := nil;  
  if FPicture <> nil then FPicture.Free;
  FPicture := nil;
  FTempTransparentBitmap.Free;
  inherited Destroy;
end;

procedure TCustomdxBlobPopup.DefaultHandler(var Message);
begin
  case TMessage(Message).Msg of
    WM_SETFOCUS:
      if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
        not IsWindow(TWMSetFocus(Message).FocusedWnd) then
        TWMSetFocus(Message).FocusedWnd := 0;
  end;
  inherited;
end;

function TCustomdxBlobPopup.CanPaste: Boolean;
begin
  if BlobEditKind = bekMemo then
  begin
    if HandleAllocated then
      Result := SendMessage(Handle, EM_CANPASTE, 0, 0) <> 0
    else Result := False;
  end
  else
    Result := Clipboard.HasFormat(FClipboardFormat);
end;

function TCustomdxBlobPopup.CanRedo: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := SendMessage(Handle, EM_CANREDO, 0, 0) <> 0;
end;

function TCustomdxBlobPopup.CanUndo: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := SendMessage(Handle, EM_CANUNDO, 0, 0) <> 0;
end;

procedure TCustomdxBlobPopup.ClearPicture;
begin
  if (BlobEditKind = bekPict) and  (FPicture <> nil) and
    (FPicture.Graphic <> nil) then
  begin
    if ReadOnly then Exit;
    FPicture.Graphic := nil;
    Invalidate;
    Modified := True;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TCustomdxBlobPopup.CopyToClipboard;
begin
  if not HandleAllocated then Exit;
  if BlobEditKind = bekMemo then
    SendMessage(Handle, WM_COPY, 0, 0)
  else
    if (BlobEditKind = bekPict) and (FPicture <> nil) and
     (FPicture.Graphic <> nil) then Clipboard.Assign(FPicture);
end;

procedure TCustomdxBlobPopup.CutToClipboard;
begin
  if not HandleAllocated then Exit;
  if BlobEditKind = bekMemo then
    SendMessage(Handle, WM_CUT, 0, 0)
  else
    if (BlobEditKind = bekPict) and  (FPicture <> nil) and
      (FPicture.Graphic <> nil) then
    begin
      CopyToClipboard;
      if ReadOnly or not TdxInplaceBlobEdit(OwnerControl).EditCanModify then Exit;
      FPicture.Graphic := nil;
      Invalidate;
      Modified := True;
      SendMessage(Handle, WM_NCPAINT, 0, 0);
    end;
end;

function TCustomdxBlobPopup.GetSelection: TCharRange;
begin
  SendMessage(Handle, EM_EXGETSEL, 0, Longint(@Result));
end;

function TCustomdxBlobPopup.GetTextLenEx: Integer;
var
  Len: TGETTEXTLENGTHEX;
begin
  Len.flags := GTL_DEFAULT;
  Len.codepage := CP_ACP;
  Result := SendMessage(Handle, EM_GETTEXTLENGTHEX, Integer(@Len), 0);
end;

procedure TCustomdxBlobPopup.HidePopup(ByMouse: Boolean);
begin
  if HandleAllocated then FBlobText := Self.Text;
  if IsWindowVisible(Handle) then DoHide;
  inherited HidePopup(ByMouse);
  if AlwaysSaveText then DoSaveChanges;
end;

procedure TCustomdxBlobPopup.LoadFromFile;
var
  Dialog: TOpenPictureDialog;
begin
  if ReadOnly then Exit;
  if (BlobEditKind = bekPict) and  (Picture <> nil) then
  begin
    Dialog := TOpenPictureDialog.Create(nil);
    try
      with Dialog do
      begin
        if PictureFilter <> '' then
          Filter := PictureFilter;
        if Execute then
        begin
          if TdxInplaceBlobEdit(OwnerControl).EditCanModify then
          try
            FPicture.LoadFromFile(FileName);
            Invalidate;
            Modified := True;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          except
            HidePopup(False);
            raise;
          end;
        end;
        ShowPopup;
      end;
    finally
      Dialog.Free;
    end;
  end;
end;

procedure TCustomdxBlobPopup.PasteFromClipboard;
begin
  if ReadOnly or not HandleAllocated then Exit;
  if BlobEditKind = bekMemo then
    SendMessage(Handle, WM_PASTE, 0, 0)
  else
    if (BlobEditKind = bekPict) and  (FPicture <> nil) and
      Clipboard.HasFormat(FClipboardFormat) then
    begin
      try
        if TdxInplaceBlobEdit(OwnerControl).EditCanModify then
          FPicture.Assign(Clipboard);
        Invalidate;
        Modified := True;
        SendMessage(Handle, WM_NCPAINT, 0, 0);
      except
        HidePopup(False);
        raise;
      end;
    end;
end;

procedure TCustomdxBlobPopup.SaveToFile;
var
  Dialog: TSavePictureDialog;
begin
  if (BlobEditKind = bekPict) and (FPicture <> nil) and (FPicture.Graphic <> nil) then
  begin
    Dialog := TSavePictureDialog.Create(nil);
    try
      with Dialog do
      begin
        if PictureFilter <> '' then
          Filter := PictureFilter
        else Filter := GraphicFilter(TGraphicClass(FPicture.Graphic.ClassType));
        DefaultExt := GraphicExtension(TGraphicClass(FPicture.Graphic.ClassType));
        if Execute then
          FPicture.SaveToFile(FileName);
        ShowPopup;
      end;
    finally
      Dialog.Free;
    end;
  end;
end;

procedure TCustomdxBlobPopup.SetSelection(StartPos, EndPos: Longint; ScrollCaret: Boolean);
var
  CharRange: TCharRange;
begin
  with CharRange do
  begin
    cpMin := StartPos;
    cpMax := EndPos;
  end;
  SendMessage(Handle, EM_EXSETSEL, 0, Longint(@CharRange));
  if ScrollCaret then
    SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

const
  BorderSize: array [TdxPopupBorderStyle] of Integer = (1, 4, 2);

procedure TCustomdxBlobPopup.SetSize(P: TPoint; DefW, DefH: Integer);
const
  Corners: array[Boolean, Boolean] of TdxCorner =
    ((coTopLeft, coBottomLeft), (coTopRight, coBottomRight));
var
  DropDownRect, EditRect, R: TRect;
  ALeftFlag, ABottomFlag: Boolean;
  SizeInfo: TdxBlobEditSizeInfo;
  W1, H1: Integer;
  MinW, MinH, MaxW, MaxH: Integer;

  function GetWidth: Integer;
  begin
    with SizeInfo do
      Result := BorderSize[PopupBorderStyle] * 2; // Border
  end;

  function GetHeight: Integer;
  begin
    with SizeInfo do
      Result := SplitterSize + BorderIndentY * 2 + ButtonHeight +
        BorderSize[PopupBorderStyle] * 2; // Border
  end;

begin
  // init coord
  FLeftCoord := 0;
  FTopCoord := 0;
  // check size
  CheckSize(MinW, MinH);
  //screen coord
  FSizingCorner := coBottomRight;
  ALeftFlag := True;
  ABottomFlag := True;
  Windows.GetWindowRect(OwnerControl.Handle, EditRect);
//  SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
  R := GetScreenWorkArea(P);
  CalcSize(SizeInfo);
  MaxW := R.Right - R.Left;
  MaxH := R.Bottom - P.Y;
  if (P.Y - (EditRect.Bottom - EditRect.Top) - R.Top) > MaxH then
    MaxH := P.Y - (EditRect.Bottom - EditRect.Top) - R.Top;
  Dec(DefW, GetWidth);
  Dec(DefH, GetHeight);
  if (BlobEditKind = bekPict) and FAutoSize and (FPicture <> nil) and
    (FPicture.Graphic <> nil) and not FPicture.Graphic.Empty  then
  begin
    DefW := FPicture.Width;
    DefH := FPicture.Height;
    // proportional
    W1 := DefW + GetWidth;
    if W1 > MaxW then
    begin
      DefW := MaxW - GetWidth;
      DefH := DefW * FPicture.Height div FPicture.Width;
    end;
    H1 := DefH + GetHeight;
    if H1 > MaxH then
    begin
      DefH := MaxH - GetHeight;
      DefW := DefH * FPicture.Width div FPicture.Height;
    end;
  end;
  W1 := DefW + GetWidth;
  H1 := DefH + GetHeight;
  if W1 < MinW then W1 := MinW;
  if H1 < MinH then H1 := MinH;
  if W1 > MaxW then W1 := MaxW;
  if H1 > MaxH then H1 := MaxH;
  Width := W1;
  Height := H1;
  DropDownRect := Rect(P.X, P.Y, P.X + Width, P.Y + Height);
  // check x coord
  if Width > (EditRect.Right - EditRect.Left) then
  begin
    if (DropDownRect.Right > R.Right) and
      (Abs(R.Right - EditRect.Left) < Abs(R.Left - EditRect.Right)) then
    begin
      OffsetRect(DropDownRect, - (DropDownRect.Right - DropDownRect.Left) + (EditRect.Right - EditRect.Left), 0);
      ALeftFlag := False;
    end;
  end;
  // check y coord
  if (DropDownRect.Bottom > R.Bottom) then
    if (Abs(R.Bottom - EditRect.Bottom) < Abs(EditRect.Top - R.Top)) then
    begin
      OffsetRect(DropDownRect, 0, -(DropDownRect.Bottom - DropDownRect.Top + (EditRect.Bottom - EditRect.Top)));
      ABottomFlag := False;
    end;
  // set corner
  FSizingCorner := Corners[ALeftFlag, ABottomFlag];
  // set pos
  Left := DropDownRect.Left;
  Top := DropDownRect.Top;
  RecreateWnd; // ReCalc NC
end;

procedure TCustomdxBlobPopup.ShowPopup;
begin
  inherited ShowPopup;
  FBlobTextSaved := False;
//  TdxInplaceBlobEdit(OwnerControl).FListVisible := True; // TODO ?
end;

procedure TCustomdxBlobPopup.CreateParams(var Params: TCreateParams);
const
  CharCases: array[TEditCharCase] of DWORD = (0, ES_UPPERCASE, ES_LOWERCASE);
  HideScrollBars: array[Boolean] of DWORD = (ES_DISABLENOSCROLL, 0);
  OEMConverts: array[Boolean] of DWORD = (0, ES_OEMCONVERT);
  ReadOnlys: array[Boolean] of DWORD = (0, ES_READONLY);
  ScrollBar: array[TScrollStyle] of DWORD = (0, WS_HSCROLL, WS_VSCROLL,
    WS_HSCROLL or WS_VSCROLL);
  SelectionBars: array[Boolean] of DWORD = (0, ES_SELECTIONBAR);
  WordWraps: array[Boolean] of DWORD = (0, ES_AUTOHSCROLL);
var
  S: string;
begin
  inherited CreateParams(Params);
  S := ClassName;
  if FBlobEditKind = bekMemo then
  begin
    CreateSubClass(Params, RICHEDIT_CLASS);
    with Params do
    begin
      Style := (Style or (ES_AUTOHSCROLL or ES_AUTOVSCROLL) or
        ReadOnlys[FReadOnly] or CharCases[FCharCase] or
        OEMConverts[FOEMConvert] or ScrollBar[FScrollBars] or
        SelectionBars[FSelectionBar] or HideScrollBars[FHideScrollBars] or
        ES_MULTILINE) and not WordWraps[FWordWrap];
      S  := S + 'Memo';
    end;
  end
  else
    S  := S + 'Pict';
  with Params do
  begin
    Move(S[1], WinClassName[0], Length(S));
    WinClassName[Length(S)] := #0;
  end;
  with Params do
  begin
    Style := (Style and not WS_CHILD) or WS_POPUP;
    Style := Style and not WS_BORDER;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

procedure TCustomdxBlobPopup.CreateWindowHandle(const Params: TCreateParams);
var
  Bounds: TRect;
begin
  if FBlobEditKind = bekMemo then
  with Params do
  begin
    Bounds := BoundsRect;
    inherited CreateWindowHandle(Params);
    if HandleAllocated then BoundsRect := Bounds;
  end
  else
    inherited;
end;

procedure TCustomdxBlobPopup.CreateWnd;
var
  R: TRect;
  S: string;
begin
  if FBlobEditKind = bekMemo then
  begin
    FCreating := True;
    try
      S := Text;
      inherited CreateWnd;
//      S := Text;
      SendMessage(Handle, WM_SETTEXT, 0, 0);
      SendMessage(Handle, EM_SETTEXTMODE, TM_PLAINTEXT, 0);
      Text := S;
    finally
      FCreating := False;
    end;
    // Max Length
    DoSetMaxLength(FMaxLength);
    // Event Mask
    SendMessage(Handle, EM_SETEVENTMASK, 0, ENM_CHANGE or ENM_SELCHANGE or ENM_DRAGDROPDONE);
    // Bk Color
    SendMessage(Handle, CM_COLORCHANGED, 0, 0);
    R := ClientRect;
    InflateRect(R, -1, -1);
    if (GetWindowLong(Handle, GWL_STYLE) and ES_SELECTIONBAR) <> 0 then
      Inc(R.Left, SelectionBarSize);
    SendMessage(Handle, EM_SETRECT, 0, LongInt(@R));
    CheckCharCase;
  end
  else
    inherited CreateWnd;
  // Common  
  Modified := FModified;
//  Windows.SetParent(Handle, 0);
  UpdateScrollBars;
end;

procedure TCustomdxBlobPopup.DestroyWnd;
begin
  FModified := Modified;
  inherited DestroyWnd;
end;

procedure TCustomdxBlobPopup.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if TdxInplaceBlobEdit(OwnerControl).IsInplace then
    if (Key = VK_TAB) and not WantTabs then
    begin
      HidePopup(False);
      TdxInplaceBlobEdit(OwnerControl).MoveCol(ssShift in Shift);
      Key := 0;
      if Handleallocated then KillMessage(Handle, WM_CHAR);
      Exit;
    end;
  if ((Key in [VK_UP, VK_DOWN]) and (ssAlt in Shift)) or
      ((Key = VK_F4){ and not (ssAlt in Shift)})then
  begin
    HidePopup(False);
    Modified := False;
    Exit;
  end;
  if (Key = VK_ESCAPE) or (IsAccel(Key, sdxBlobEditButtons[bebCancel]) and (ssAlt in Shift)) or
     (IsAccel(Key, sdxBlobEditButtons[bebClose]) and (ssAlt in Shift)) or
     (((Key = VK_RETURN) and ((ssCtrl in Shift) or not FWantReturns or (BlobEditKind = bekPict))) or
      (IsAccel(Key, sdxBlobEditButtons[bebOK]) and (ssAlt in Shift)) and (bebOk in Buttons)) then
  begin
//    HidePopup(False);
    if (Key = VK_ESCAPE) or (IsAccel(Key, sdxBlobEditButtons[bebCancel]) and (ssAlt in Shift)) or
      (IsAccel(Key, sdxBlobEditButtons[bebClose]) and (ssAlt in Shift)) then
    begin
      Modified := False;
      ButtonClick(Ord(bebCancel));
      if (IsAccel(Key, sdxBlobEditButtons[bebCancel]) and (ssAlt in Shift)) or
        (IsAccel(Key, sdxBlobEditButtons[bebClose]) and (ssAlt in Shift)) then
        DestroyWnd; // TODO !!! 30-aug-1999 18:12
    end
    else
    begin
      ButtonClick(Ord(bebOk));
      if IsAccel(Key, sdxBlobEditButtons[bebOK]) and (ssAlt in Shift) then
        DestroyWnd; // TODO !!! 30-aug-1999 18:12
      Key := 0;
    end;
    Exit;
  end;
  inherited KeyDown(Key, Shift);
  if BlobEditKind <> bekMemo then
    case Key of
      VK_INSERT:
        if ssShift in Shift then PasteFromClipBoard else
          if ssCtrl in Shift then CopyToClipBoard;
      VK_DELETE:
        if ssShift in Shift then CutToClipBoard;
    end;
end;

procedure TCustomdxBlobPopup.KeyPress(var Key: Char);
begin
  if (Key = #10) and (bebOk in Buttons) then
  begin
    Key := #0;
    Exit;
  end;
  if not WantTabs and (Key = #9) then
    Key := #0;
  inherited KeyPress(Key);
  if BlobEditKind <> bekMemo then
    case Key of
      ^X: CutToClipBoard;
      ^C: CopyToClipBoard;
      ^V: PasteFromClipBoard;
    end;
end;

procedure TCustomdxBlobPopup.Paint;
var
  CR, R: TRect;
  DrawPict: TPicture;

  procedure CalcStretchRect(R: TRect; W, H: Integer; var CalcRect: TRect);
  var
    W1, H1: Integer;
  begin
    CalcRect.Left := R.Left;
    CalcRect.Top := R.Top;
    W1 := R.Right - R.Left;
    H1 := R.Bottom - R.Top;
    if W/H > W1/H1 then
    begin
      CalcRect.Right := R.Right;
      CalcRect.Bottom := W1*H div W;
    end
    else
    begin
      CalcRect.Bottom := R.Bottom;
      CalcRect.Right := H1*W div H;
    end;
  end;

begin
  if BlobEditKind <> bekMemo then
  begin
    with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := Color;
      CR := ClientRect;
      DrawPict := FPicture;
      if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
        FillRect(CR)
      else
      begin
        if FAutoSize then
        begin
          // CalcRect
          CalcStretchRect(CR, DrawPict.Width, DrawPict.Height, R);
        end
        else
        begin
          R := Rect(0, 0, DrawPict.Width, DrawPict.Height);
          OffsetRect(R, -FLeftCoord, -FTopCoord);
        end;
        if DrawPict.Graphic.Transparent then
        begin
          if FTempTransparentBitmap = nil then
            FTempTransparentBitmap := TBitmap.Create;
          CheckDrawBitmap(FTempTransparentBitmap, CR.Right - CR.Left, CR.Bottom - CR.Top);
          with FTempTransparentBitmap.Canvas do
          begin
            with CR do
            begin
              Windows.FillRect(Handle, Rect(0, 0, Right - Left, Bottom - Top),
                Self.Canvas.Brush.Handle);
              OffsetRect(R, Left, Top);
            end;
            StretchDraw(R, DrawPict.Graphic);
          end;
          with CR do
            Windows.BitBlt(Handle, Left, Top, Right - Left, Bottom - Top,
              FTempTransparentBitmap.Canvas.Handle, 0, 0, SRCCOPY);
//          FillRect(CR);
//          StretchDraw(R, DrawPict.Graphic);
        end
        else
        begin
          StretchDraw(R, DrawPict.Graphic);
          ExcludeClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
          FillRect(CR);
        end;
        SelectClipRgn(Handle, 0);
      end;
    end;
  end;
end;

procedure TCustomdxBlobPopup.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  if ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_MBUTTONDOWN) or
    (Message.Msg = WM_RBUTTONDOWN)) and
    (GetFocus <> Handle) and not (csDesigning in ComponentState) then
  begin
    if Message.Msg = WM_MBUTTONDOWN then
      PostMessage(Handle, WM_MBUTTONUP, 0, 0);
    ReleaseCapture;
  end;
end;

procedure TCustomdxBlobPopup.ButtonClick(Index: Integer);
begin
  if TdxBlobEditButton(Index) in [bebCancel, bebClose] then
    FBlobTextSaved := True;
  HidePopup(False);
  if TdxBlobEditButton(Index) = bebOk then DoSaveChanges;
end;

procedure TCustomdxBlobPopup.Change;
var
  PrevModified: Boolean;
begin
  PrevModified := FButtonEnabled;
//  inherited Changed;
  if Assigned(FOnChange) then FOnChange(Self);
  FButtonEnabled := Modified;
  if PrevModified <> Modified then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TCustomdxBlobPopup.DoHide;
begin
  if Assigned(FOnHide) then FOnHide(Self);
end;

procedure TCustomdxBlobPopup.DoSaveChanges;
begin
  if not FBlobTextSaved and Modified and Assigned(FOnSaveChanges) then
    FOnSaveChanges(Self);
  FBlobTextSaved := True;
end;

procedure TCustomdxBlobPopup.CheckCharCase;
var
  ACharRange: TCharRange;
  AText: string;
begin
  if FCharCase <> ecNormal then
  begin
    if FCharCase = ecUpperCase then
      AText := AnsiUpperCase(Text)
    else AText := AnsiLowerCase(Text);
    if AText <> Text then
    begin
      FCharCaseChanging := True;
      try
        if HandleAllocated then
          ACharRange := GetSelection;
        Text := AText;
        if HandleAllocated then
          with ACharRange do
            SetSelection(cpMin, cpMax, True);
      finally
        FCharCaseChanging := False;
      end;
    end;
  end;
end;

procedure TCustomdxBlobPopup.DoSetMaxLength(Value: Integer);
begin
  SendMessage(Handle, EM_EXLIMITTEXT, 0, Value);
end;

function TCustomdxBlobPopup.GetSelLength: Integer;
begin
  with GetSelection do
    Result := cpMax - cpMin;
end;

function TCustomdxBlobPopup.GetSelStart: Integer;
begin
  Result := GetSelection.cpMin;
end;

function TCustomdxBlobPopup.GetSelText: string;
begin
  SetLength(Result, GetSelLength + 1);
  SetLength(Result, SendMessage(Handle, EM_GETSELTEXT, 0, Longint(PChar(Result))));
end;

procedure TCustomdxBlobPopup.SetSelLength(Value: Integer);
begin
  with GetSelection do
    SetSelection(cpMin, cpMin + Value, True);
end;

procedure TCustomdxBlobPopup.SetSelStart(Value: Integer);
begin
  SetSelection(Value, Value, False);
end;

// private TCustomdxBlobPopup
procedure TCustomdxBlobPopup.CalcSize(var SizeInfo: TdxBlobEditSizeInfo);
var
  i: TdxBlobEditButton;
  W: Integer;
  Canvas: TCanvas;
begin
  FillChar(SizeInfo, SizeOf(TdxBlobEditSizeInfo), 0);
  with SizeInfo do
  begin
    if PopupBorderStyle in [pbFlat, pbSingle] then SplitterSize := 2
    else SplitterSize := 4;
    BorderIndentX := GetSystemMetrics(SM_CXVSCROLL);
    Canvas:= TCanvas.Create;
    Canvas.Handle := GetDC(0);
    try
      Canvas.Font := Font;
      BorderIndentY := Canvas.TextHeight('Wg') div 2;
      BorderIndentY := Canvas.TextHeight('Wg') div 3;
      ButtonIndent := Canvas.TextWidth('0');
      if not FSizeable then
        BorderIndentX := ButtonIndent;
//      ButtonHeight := MulDiv(Font.Size, 5, 2); TODO ?
      ButtonHeight := MulDiv(Canvas.TextHeight('Wg'), 20, 13);
      ButtonWidth := 0;
      ButtonCount := 0;
      for i := Low(TdxBlobEditButton) to High(TdxBlobEditButton) do
      begin
        if i in FButtons then
        begin
          W := Canvas.TextWidth(sdxBlobEditButtons[i]+'00');
          if W > ButtonWidth then ButtonWidth := W;
          Inc(ButtonCount);
        end;
      end;
    finally
      ReleaseDC(0, Canvas.Handle);
      Canvas.Free;
    end;
  end;
end;

procedure TCustomdxBlobPopup.CalcRectInfo(var R: TRect; var W, H: Integer);
var
  AStyle: LongInt;
begin
  AStyle := GetWindowLong(Handle, GWL_STYLE);
  if (AStyle and WS_HSCROLL <>0) then
    H := GetSystemMetrics(SM_CYHSCROLL)
  else H := 0;
  if (AStyle and WS_VSCROLL <> 0) then
    W := GetSystemMetrics(SM_CXVSCROLL)
  else W := 0;
  // Exclude Border
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
end;

procedure TCustomdxBlobPopup.CheckLeftTopCoord;
var
  ATop, ALeft, FLeft, FTop, FWidth, FHeight: Integer;
begin
  if not HandleAllocated or FAutoSize or (BlobEditKind <> bekPict) or
    (FPicture = nil) or (FPicture.Graphic = nil) or FPicture.Graphic.Empty then Exit;
  // check left
  FLeft := LeftCoord;
  FWidth := FPicture.Width;
  ALeft := FLeft;
  if ((ALeft+ClientWidth)> FWidth) then
    ALeft := FWidth-ClientWidth;
  if FLeft <> ALeft then
    LeftCoord := ALeft;
  // check height
  FTop := TopCoord;
  FHeight := FPicture.Height;
  ATop := FTop;
  if ((ATop+ClientHeight)> FHeight) then
    ATop := FHeight-ClientHeight;
  if FTop <> ATop then
    TopCoord := ATop;
end;

procedure TCustomdxBlobPopup.CheckSize(var W, H: Integer);
var
  SizeInfo: TdxBlobEditSizeInfo;
begin
  CalcSize(SizeInfo);
  with SizeInfo do
  begin
    W := BorderIndentX * 2 +
         ButtonCount * (ButtonWidth + ButtonIndent) - ButtonIndent +
         BorderSize[PopupBorderStyle] * 2 + 2; // Border
    FButtonPanelHeight := SplitterSize + BorderIndentY * 2 + ButtonHeight;
    H := FButtonPanelHeight + 3 * GetSystemMetrics(SM_CYHSCROLL);
  end;
end;

function TCustomdxBlobPopup.GetButtonAt(ScreenX, ScreenY: Integer): Integer;
var
  R, CR: TRect;
  W, H: Integer;
  I: TdxBlobEditButton;
  ASizeInfo: TdxBlobEditSizeInfo;
  P: TPoint;
begin
  Result := -1;
  if FButtonPanelHeight = 0 then Exit;
  // screen coord -> window coord
  GetWindowRect(Handle, R);
  P := Point(ScreenX - R.Left, ScreenY - R.Top);
  // get window rect info
  CalcRectInfo(R, W, H);
  if Shadow then
  begin
    Dec(R.Right, ShadowSize);
    Dec(R.Bottom, ShadowSize);
  end;
  case PopupBorderStyle of
    pbSingle:
      InflateRect(R, -1, -1);
    pbFlat:
      InflateRect(R, -2, -2);
    pbFrame3D:
      InflateRect(R, -4, -4);
  end;
  // get button panel info
  CalcSize(ASizeInfo);
  with ASizeInfo do
  begin
    if SizingCorner in [coTopLeft, coTopRight] then
      R.Bottom := R.Top + FButtonPanelHeight;
    CR := Rect(R.Left - BorderIndentX,
               R.Bottom - FButtonPanelHeight + SplitterSize + BorderIndentY,
               R.Right - BorderIndentX,
               R.Bottom - FButtonPanelHeight + SplitterSize + BorderIndentY + ButtonHeight);
    CR.Left := CR.Right - ButtonWidth;
    for i := High(TdxBlobEditButton) downto Low(TdxBlobEditButton) do
    begin
      if i in FButtons then
      begin
        if PtInRect(CR, P) then
        begin
          Result := Ord(i);
          Break;
        end;
        CR.Right := CR.Left - ButtonIndent;
        CR.Left := CR.Right - ButtonWidth;
      end;
    end;
  end;
end;

function TCustomdxBlobPopup.GetButtons: TdxBlobEditButtons;
begin
  Result := FButtons;
end;

function TCustomdxBlobPopup.GetModified: Boolean;
begin
  Result := FModified;
  if HandleAllocated and (BlobEditKind = bekMemo) then
    Result := SendMessage(Handle, EM_GETMODIFY, 0, 0) <> 0;
end;

function TCustomdxBlobPopup.GetPicture: TPicture;
begin
  if FPicture = nil then
    FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;  
  Result := FPicture;
end;

procedure TCustomdxBlobPopup.PictureChanged(Sender: TObject);
var
  PrevEvent: TNotifyEvent;
begin
  if not HandleAllocated then Exit;
  if BlobEditKind = bekPict then
  begin
    if FGraphicTransparency <> gtDefault then
    begin
      PrevEvent := FPicture.OnChange;
      try
        FPicture.OnChange := nil;
        if not IsPictureEmpty(FPicture) then
          FPicture.Graphic.Transparent := FGraphicTransparency = gtTransparent;
      finally
        FPicture.OnChange := PrevEvent;
      end;
    end;
    // Modified
    if not FInternalChanging then
    begin
      Modified := True;
      Change;
    end;  
    Invalidate;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TCustomdxBlobPopup.SetBlobAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.SetBlobEditKind(Value: TdxBlobEditKind);
begin
  if FBlobEditKind <> Value then
  begin
    FBlobEditKind := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.SetCharCase(Value: TEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    CheckCharCase;
  end;
end;

procedure TCustomdxBlobPopup.SetLeftCoord(ALeft: Integer);
var
  FLeft, FTotal: Integer;
  Distance: Integer;
  NewRect: TRect;
begin
  if not HandleAllocated or FAutoSize or (BlobEditKind <> bekPict) or
    (FPicture = nil) or (FPicture.Graphic = nil) or FPicture.Graphic.Empty then Exit;
  FLeft := LeftCoord;
  if FLeft <> ALeft then
  begin
    if (ALeft < 0) then ALeft := 0;
    FTotal := FPicture.Width;
    if ((ALeft+ClientWidth)> FTotal) then ALeft := FTotal-ClientWidth;
    if ALeft < 0 then ALeft := 0;
    if (ALeft <> FLeft) then
    begin
      FLeftCoord := ALeft;
      UpdateScrollBars;
      Distance := (FLeft - ALeft);
      if Abs(Distance) > ClientWidth then
         Invalidate
      else
      begin
        NewRect := ClientRect;
        ScrollWindowEx(Handle, Distance, 0, @NewRect, @NewRect,
          0, nil, SW_Invalidate);
      end;
    end;
  end;
end;

procedure TCustomdxBlobPopup.SetGraphicTransparency(Value: TdxGraphicEditTransparency);
begin
  if FGraphicTransparency <> Value then
  begin
    FInternalChanging := True;
    try
      FGraphicTransparency := Value;
      PictureChanged(nil);
    finally
      FInternalChanging := False;
    end;
  end;
end;

procedure TCustomdxBlobPopup.SetHideScrollBars(Value: Boolean);
begin
  if HideScrollBars <> Value then
  begin
    FHideScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.SetMaxLength(Value: Integer);
begin
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    if (FBlobEditKind = bekMemo) and HandleAllocated then
      SendMessage(Handle, EM_LIMITTEXT, Value, 0)
  end;
end;

procedure TCustomdxBlobPopup.SetModified(Value: Boolean);
begin
  if HandleAllocated and (BlobEditKind = bekMemo) then
    SendMessage(Handle, EM_SETMODIFY, Byte(Value), 0)
  else FModified := Value;
  FButtonEnabled := FModified;
end;

procedure TCustomdxBlobPopup.SetOEMConvert(Value: Boolean);
begin
  if FOEMConvert <> Value then
  begin
    FOEMConvert := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.SetPicture(Value: TPicture);
begin
  if FPicture <> Value then
  begin
    if Value = nil then
    begin
      FPicture.Free;
      FPicture := nil;
    end
    else
      FPicture.Assign(Value);
  end;
end;

procedure TCustomdxBlobPopup.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    // Buttons
    if FReadOnly then
      FButtons := [bebClose]
    else FButtons := [bebOk, bebCancel];
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.SetSelectionBar(Value: Boolean);
begin
  if FSelectionBar <> Value then
  begin
    FSelectionBar := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.SetSizeable(Value: Boolean);
begin
  if Value <> FSizeable then
  begin
    FSizeable := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.SetTopCoord(ATop: Integer);
var
  FTop, FTotal: Integer;
  Distance: Integer;
  NewRect: TRect;
begin
  if not HandleAllocated or FAutoSize or (BlobEditKind <> bekPict) or
    (FPicture = nil) or (FPicture.Graphic = nil) or FPicture.Graphic.Empty then Exit;
  FTop := TopCoord;
  if FTop <> ATop then
  begin
    if (ATop < 0) then ATop := 0;
    FTotal := FPicture.Height;
    if (ATop + ClientHeight) > FTotal then ATop := FTotal - ClientHeight;
    if ATop < 0 then ATop := 0;
    if ATop <> FTop then
    begin
      FTopCoord := ATop;
      UpdateScrollBars;
      Distance := FTop - ATop;
      if Abs(Distance) > ClientHeight then
        Invalidate
      else
      begin
        NewRect := ClientRect;
        ScrollWindowEx(Handle, 0, Distance, @NewRect, @NewRect,
          0, nil, SW_INVALIDATE);
      end;
    end;
  end;
end;

procedure TCustomdxBlobPopup.SetWordWrap(Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxBlobPopup.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
    FButtonPressed := False;
  end;
end;

procedure TCustomdxBlobPopup.TrackButton(X, Y: Integer);
var
  B, FlagRepaint: Boolean;
begin
  if FDownButton <> -1 then
  begin
    B := GetButtonAt(X, Y) = FDownButton;
    FlagRepaint := B <> FButtonPressed;
    FButtonPressed := B;
    if FlagRepaint then
      SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TCustomdxBlobPopup.UpdateScrollBars;
var
  SIOld, SINew: TScrollInfo;
  FWidth, FHeight: Integer;
begin
  if not HandleAllocated or FAutoSize or (BlobEditKind <> bekPict) or
    (FPicture = nil) or (FPicture.Graphic = nil) or FPicture.Graphic.Empty then Exit;
  FWidth := FPicture.Width;
  FHeight := FPicture.Height;
  // horz
  SIOld.cbSize := SizeOf(SIOld);
  SIOld.fMask := SIF_ALL;
  GetScrollInfo(Self.Handle, SB_HORZ, SIOld);
  SINew := SIOld;
  SINew.nMin := 0;
  SINew.nPage := ClientWidth;
  SINew.nMax :=  FWidth-1;
  if FWidth <= ClientWidth then SINew.nMax := 0;
  SINew.nPos := FLeftCoord;
  if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
    (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
    SetScrollInfo(Self.Handle, SB_HORZ, SINew, True);
  // horz
  SIOld.cbSize := SizeOf(SIOld);
  SIOld.fMask := SIF_ALL;
  GetScrollInfo(Self.Handle, SB_VERT, SIOld);
  SINew := SIOld;
  SINew.nMin := 0;
  SINew.nPage := ClientHeight;
  SINew.nMax :=  FHeight-1;
  if FHeight <= ClientHeight then SINew.nMax := 0;
  SINew.nPos := FTopCoord;
  if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
    (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
    SetScrollInfo(Self.Handle, SB_VERT, SINew, True);
end;

procedure TCustomdxBlobPopup.EditPopupMenuClick(Sender: TObject);
begin
  case TMenuItem(Sender).Tag of
    // Memo
    -1: SendMessage(Handle, EM_UNDO, 0, 0);
    -2: SendMessage(Handle, EM_REDO, 0, 0);
    -3: CutToClipBoard;
    -4: CopyToClipBoard;
    -5: PasteFromClipBoard;
    -6: SendMessage(Handle, WM_CLEAR, 0, 0);
    -7: SetSelection(0, -1, False);
    // Picture
    0: CutToClipBoard;
    1: CopyToClipBoard;
    2: PasteFromClipBoard;
    3: ClearPicture;
    4: LoadFromFile;
    5: SaveToFile;
  end;
end;

procedure TCustomdxBlobPopup.WMChar(var Message: TWMChar);
var
  S: string;
begin
  if FCharCase <> ecNormal then
  begin
    S := Char(Message.CharCode);
    if FCharCase = ecUpperCase then
      S := AnsiUpperCase(S)
    else S := AnsiLowerCase(S);
    if Length(S) > 0 then
      Message.CharCode := Word(S[1]);
  end;
  inherited;
end;

procedure TCustomdxBlobPopup.WMContextMenu(var Message: TMessage);

  function NewItem(const ACaption: string; AEnabled: Boolean; AShortCut: TShortCut; ATag: Integer): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    with Result do
    begin
      Caption := ACaption;
      Enabled := AEnabled;
      ShortCut := AShortCut;
      Tag := ATag;
      OnClick := EditPopupMenuClick;
      {$IFDEF DELPHI4}
      if ATag >= 0 then ImageIndex := ATag;
      {$ENDIF}
    end;
  end;

var
  P: TPoint;
  Flag: Boolean;
begin
  inherited;
  if (Message.Result = 0) and not HasPopup(Self) {DELPHI3} and
    not ((BlobEditKind = bekPict) and
    not TdxInplaceBlobEdit(OwnerControl).ShowPicturePopup) then
  begin
    P := SmallPointToPoint(TSmallPoint(Message.LParam));
    if (P.X = -1) and (P.Y = -1) then
    begin
      GetCaretPos(P);
      if P.X > ClientWidth then
        P.X := ClientWidth;
      Windows.ClientToScreen(Handle, P);
    end;
    // Popup
    if FEditPopupMenu = nil then
      FEditPopupMenu := TPopupMenu.Create(Self);
    {$IFDEF DELPHI5}
    FEditPopupMenu.Items.Clear;
    {$ELSE}
    while FEditPopupMenu.Items.Count > 0 do
      FEditPopupMenu.Items.Delete(0);
    {$ENDIF}
    with FEditPopupMenu.Items do
      if BlobEditKind = bekPict then
      begin
        // TODO ShowPopup
        {$IFDEF DELPHI4}
        FEditPopupMenu.Images := dxGraphicPopupMenuImages;
        {$ENDIF}
        Flag := not ((Picture.Graphic = nil) or Picture.Graphic.Empty); 
        Add(NewItem(ToolButtons[ptbCut, 0], Flag and not ReadOnly, Menus.ShortCut(Ord('X'), [ssCtrl]), Integer(ptbCut)));
        Add(NewItem(ToolButtons[ptbCopy, 0], Flag, Menus.ShortCut(Ord('C'), [ssCtrl]), Integer(ptbCopy)));
        Add(NewItem(ToolButtons[ptbPaste, 0], not ReadOnly and CanPaste, Menus.ShortCut(Ord('V'), [ssCtrl]), Integer(ptbPaste)));
        Add(NewItem(ToolButtons[ptbDelete, 0], Flag and not ReadOnly, 0, Integer(ptbDelete)));
        Add(NewItem('-', True, 0, MaxInt));
        // TODO Show Ex
        if TdxInplaceBlobEdit(OwnerControl).ShowExPopupItems then
        begin
          Add(NewItem(ToolButtons[ptbLoad, 0], not ReadOnly, 0, Integer(ptbLoad)));
          Add(NewItem(ToolButtons[ptbSave, 0], Flag, 0, Integer(ptbSave)));
        end;
      end
      else
      begin
        Flag := SelLength > 0;
        Add(NewItem(sdxEditUndoCaption, CanUndo, 0, -1));
        Add(NewItem(sdxEditRedoCaption, CanRedo, 0, -2));
        Add(NewItem('-', True, 0, MaxInt));
        Add(NewItem(sdxEditCutCaption, Flag and not ReadOnly, 0, -3));
        Add(NewItem(sdxEditCopyCaption, Flag, 0, -4));
        Add(NewItem(sdxEditPasteCaption, not ReadOnly and CanPaste, 0, -5));
        Add(NewItem(sdxEditDeleteCaption, Flag and not ReadOnly, 0, -6));
        Add(NewItem('-', True, 0, MaxInt));
        Add(NewItem(sdxEditSelectAllCaption, SelLength <> GetTextLenEx, 0, -7));
      end;
    FEditPopupMenu.Popup(P.X, P.Y);
  end;
end;

procedure TCustomdxBlobPopup.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if (BlobEditKind = bekPict) then
    Message.Result := 1
  else inherited;
end;

procedure TCustomdxBlobPopup.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if FWantTabs then
    Message.Result := Message.Result or DLGC_WANTTAB
  else
    Message.Result := Message.Result and not DLGC_WANTTAB;
  if not FWantReturns then
    Message.Result := Message.Result and not DLGC_WANTALLKEYS;
end;

procedure TCustomdxBlobPopup.WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
var W, H: Integer;
begin
  CheckSize(W, H);
  Message.MinMaxInfo^.ptMinTrackSize := Point(W, H);
  inherited;
end;

procedure TCustomdxBlobPopup.WMHScroll(var Message: TWMHScroll);
var
  SI: TScrollInfo;
  DeltaHScroll: Integer;
  FWidth: Integer;
begin
  if BlobEditKind <> bekPict then
  begin
    inherited;
  end
  else
  if (FPicture <> nil) and (FPicture.Graphic <> nil) and
    not FPicture.Graphic.Empty then
  begin
    DeltaHScroll := GetSystemMetrics(SM_CXHSCROLL);
    FWidth := FPicture.Width;
    with Message do
      case ScrollCode of
        SB_LINEUP: LeftCoord := LeftCoord - DeltaHScroll;
        SB_LINEDOWN: LeftCoord := LeftCoord + DeltaHScroll;
        SB_PAGEUP: LeftCoord := LeftCoord - ClientWidth;
        SB_PAGEDOWN: LeftCoord := LeftCoord + ClientWidth;
        SB_THUMBTRACK,
        SB_THUMBPOSITION:
          begin
              SI.cbSize := sizeof(SI);
              SI.fMask := SIF_ALL;
              GetScrollInfo(Self.Handle, SB_HORZ, SI);
              if SI.nTrackPos <= 0 then
                LeftCoord := 0
              else
              if SI.nTrackPos >= FWidth then
                LeftCoord := FWidth
              else
              begin
                if (SI.nTrackPos+1+ClientWidth) >= FWidth then
                  LeftCoord := (SI.nTrackPos + 1)
                else LeftCoord := ((SI.nTrackPos + 1) div 4) * 4;
              end;
          end;
        SB_BOTTOM: LeftCoord := FWidth;
        SB_TOP: LeftCoord := 0;
      end;
  end;
end;

procedure TCustomdxBlobPopup.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  with Message.CalcSize_Params^.rgrc[0] do
    if SizingCorner in [coBottomLeft, coBottomRight] then
      Dec(Bottom, FButtonPanelHeight)
    else Inc(Top, FButtonPanelHeight);
end;

procedure TCustomdxBlobPopup.WMNCHitTest(var Message: TWMNCHitMessage);
const
  CornerHitTest: array [TdxCorner] of Integer = (Windows.HTTOPLEFT,
    Windows.HTTOPRIGHT, Windows.HTBOTTOMLEFT, Windows.HTBOTTOMRIGHT);
var
  R, TestR: TRect;
  P: TPoint;
begin
  inherited;
  GetWindowrect(Handle, R);
  if Shadow then
  begin
    Dec(R.Right, ShadowSize);
    Dec(R.Bottom, ShadowSize);
  end;
  with Message do
    P := Point(XCursor, YCursor);
  if FSizeable and not FTracking then
  begin
    TestR := R;
    if SizingCorner in [coTopLeft, coTopRight] then
      TestR.Bottom := TestR.Top + GetSystemMetrics(SM_CYHSCROLL)
    else TestR.Top := TestR.Bottom - GetSystemMetrics(SM_CYHSCROLL);
    if SizingCorner in [coTopLeft, coBottomLeft] then
      TestR.Right := TestR.Left + GetSystemMetrics(SM_CXVSCROLL)
    else TestR.Left := TestR.Right - GetSystemMetrics(SM_CXVSCROLL);
    if (PtInRect(TestR, P)) then
      Message.Result := CornerHitTest[SizingCorner]
    else
    begin
      if SizingCorner in [coBottomLeft, coBottomRight] then // bottom
      begin
        TestR := Rect(R.Left, R.Bottom - GetSystemMetrics(SM_CYDLGFRAME), R.Right, R.Bottom);
        if (PtInRect(TestR, P)) then
           Message.Result := Windows.HTBOTTOM;
      end
      else // top
      begin
        TestR := Rect(R.Left, R.Top, R.Right, R.Top + GetSystemMetrics(SM_CYDLGFRAME));
        if (PtInRect(TestR, P)) then
           Message.Result := Windows.HTTOP;
      end;
      if SizingCorner in [coBottomLeft, coTopLeft] then // left
      begin
        TestR := Rect(R.Left, R.Top, R.Left + GetSystemMetrics(SM_CXDLGFRAME), R.Bottom);
        if (PtInRect(TestR, P)) then
           Message.Result := Windows.HTLEFT;
      end
      else // right
      begin
        TestR := Rect(R.Right - GetSystemMetrics(SM_CXDLGFRAME), R.Top, R.Right, R.Bottom);
        if (PtInRect(TestR, P)) then
           Message.Result := Windows.HTRIGHT;
      end;
    end;
  end;
  if Message.Result = Windows.HTNOWHERE then
     Message.Result := Windows.HTBORDER;
end;

procedure TCustomdxBlobPopup.WMNCLButtonDblClk(var Message: TMessage);
begin
  inherited;
  SendMessage(Handle, WM_NCLBUTTONDOWN, Message.wParam, Message.lParam);
end;

procedure TCustomdxBlobPopup.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  if FButtonPanelHeight = 0 then Exit;
  with Message do
  begin
    FDownButton := GetButtonAt(XCursor, YCursor);
    if (FDownButton = Ord(bebOk)) and not FButtonEnabled then
       FDownButton := -1;
    if FDownButton <> -1 then
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(XCursor, YCursor);
    end;
  end;
end;

procedure TCustomdxBlobPopup.WMLButtonUp(var Message: TWMLButtonUp);
var
  WasPressed: Boolean;
begin
  inherited;
  if FButtonPanelHeight = 0 then Exit;
  with Message do
  begin
    WasPressed := (FDownButton <> -1) and FButtonPressed;
    StopTracking;
    if WasPressed then ButtonClick(FDownButton);
    FDownButton := -1;
  end;
end;

procedure TCustomdxBlobPopup.WMMouseMove(var Message: TWMMouseMove);
var p: TPoint;
begin
  inherited;
  with Message do
    p := ClientToScreen(Point(XPos, YPos));
  if FTracking then
    TrackButton(P.X, P.Y);
end;

procedure TCustomdxBlobPopup.WMNCPaint(var Message: TWMNCPaint);
var
  R, CR: TRect;
  DC: HDC;
  H, W: Integer;
  hB: hBrush;
  ASizeInfo: TdxBlobEditSizeInfo;
  i : TdxBlobEditButton;

  procedure DrawButton(DC: hDC; Button : TdxBlobEditButton; R: TRect;
     Down: Boolean; Enabled: Boolean);
  const   
    DownFlatStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  var
    AText: String;
    PrevFont: hFont;
  begin
    AText := sdxBlobEditButtons[Button];
    if PopupBorderStyle in [pbFlat, pbSingle] then
    begin
      DrawEdge(DC, R, DownFlatStyles[Down], BF_RECT);
      InflateRect(R, -1, -1);
    end
    else
    begin
      if Down then
        DrawFrameControl(DC, R, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_PUSHED)
      else
      with R do
      begin
        DrawEdge(DC , R, EDGE_RAISED, BF_BOTTOMRIGHT);
        DrawEdge(DC , R, BDR_SUNKENOUTER, BF_TOPLEFT);
        InflateRect(R, -1, -1);
        DrawEdge(DC , R, BDR_RAISEDINNER, BF_TOPLEFT);
        InflateRect(R, 1, 1);
        SetPixel(DC, Left + 1, Bottom - 2, GetSysColor(COLOR_BTNFACE));
        SetPixel(DC, Right - 2, Top + 1, GetSysColor(COLOR_BTNFACE));
      end;
      InflateRect(R, -2, -2);
    end;
    // Draw Button's Caption
    PrevFont := SelectObject(DC, Font.Handle);
    if Enabled then
      SetTextColor(DC, GetSysColor(COLOR_BTNTEXT))
    else
      SetTextColor(DC, GetSysColor(COLOR_BTNSHADOW));
    SetBkColor(DC, GetSysColor(COLOR_BTNFACE));
    FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
    DrawText(DC, PChar(AText), Length(AText), R,
        DT_CENTER or DT_NOCLIP or DT_SINGLELINE or DT_VCENTER);
    SelectObject(DC, PrevFont);
  end;

begin
  inherited;
  CalcRectInfo(R, W, H); // Exclude Border
  DC := GetWindowDC(Handle);
  DrawPopupBorder(DC, R, PopupBorderStyle, False, Shadow, ShadowSize);
  if (FButtonPanelHeight <> 0) then
  begin
    hB := GetSysColorBrush(COLOR_BTNFACE);
    // ScollBars
    if (H <> 0) and (W <> 0) then
    begin
      with R do
        CR := Rect(Right - W, Bottom - H, Right, Bottom);
      if SizingCorner in [coBottomLeft, coBottomRight] then
        OffsetRect(CR, 0, -FButtonPanelHeight);
      FillRect(DC, CR, hB);
    end;
    // Button Panel
    if SizingCorner in [coBottomLeft, coBottomRight] then
      R.Top := R.Bottom - FButtonPanelHeight
    else R.Bottom := R.Top + FButtonPanelHeight;
    if PopupBorderStyle in [pbFlat, pbSingle] then
    begin
      if SizingCorner in [coBottomLeft, coBottomRight] then H := 0
      else H := FButtonPanelHeight - 2;
      CR := Rect(R.Left, R.Top + H, R.Right, R.Top + 1 + H);
      DrawEdge(DC, CR, BDR_RAISEDINNER , BF_TOP);
      CR := Rect(R.Left, R.Top + 1 + H, R.Right, R.Top + 2 + H);
      DrawEdge(DC, CR, BDR_SUNKENOUTER , BF_TOP);
      if SizingCorner in [coBottomLeft, coBottomRight] then
        Inc(R.Top, 2)
      else Dec(R.Bottom, 2);   
    end
    else
    begin
      if SizingCorner in [coBottomLeft, coBottomRight] then H := 0
      else H := FButtonPanelHeight - 4;
      CR := Rect(R.Left - 2, R.Top + H, R.Right + 1, R.Top + 2 + H);
      DrawEdge(DC, CR, EDGE_RAISED, BF_TOP);
      CR := Rect(R.Left - 2, R.Top + 2 + H, R.Right + 2, R.Top + 4 + 1 + H);
      DrawEdge(DC, CR, BDR_SUNKENINNER, BF_TOPLEFT or BF_RIGHT or BF_FLAT);
      CR := Rect(R.Left - 1, R.Top + 2 + H + 1, R.Right + 2 - 1, R.Top + 4 + 1 + H + 1);
      DrawEdge(DC, CR, BDR_SUNKENOUTER, BF_TOPLEFT or BF_RIGHT);
      if SizingCorner in [coBottomLeft, coBottomRight] then
        Inc(R.Top, 4)
      else Dec(R.Bottom, 4);
    end;
    // Draw Buttons
    CalcSize(ASizeInfo);
    with ASizeInfo do
    begin
      CR := Rect(R.Left - BorderIndentX, R.Bottom - FButtonPanelHeight + BorderIndentY + SplitterSize,
        R.Right - BorderIndentX, R.Bottom - FButtonPanelHeight + BorderIndentY + ButtonHeight + SplitterSize);
      CR.Left := CR.Right - ButtonWidth;
      for I := High(TdxBlobEditButton) downto Low(TdxBlobEditButton) do
      begin
        if I in FButtons then
        begin
          DrawButton(DC, I, CR,
            FButtonPressed and (Ord(I) = FDownButton),
            not (not FButtonEnabled and (I = bebOk)));
          ExcludeClipRect(DC, CR.Left, CR.Top, CR.Right, CR.Bottom);
          CR.Right := CR.Left - ButtonIndent;
          CR.Left := CR.Right - ButtonWidth;
        end;
      end;
    end;
    // Size Border
    if FSizeable then
    begin
      CR := R;
      DrawSizeGrip(DC, CR, SizingCorner);
      with CR do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
    end;
    CR := R;
    FillRect(DC, CR, hB);
  end;
  ReleaseDC(Handle, DC);
end;

procedure TCustomdxBlobPopup.WMPaint(var Message: TWMPaint);
begin
  if BlobEditKind = bekMemo then
    with TMessage(Message) do
      CallWindowProc(DefWndProc, Handle, Msg, WParam, LParam)
  else PaintHandler(Message);
end;

procedure TCustomdxBlobPopup.WMSetFont(var Message: TWMSetFont);
var
  Format: TCharFormat2;
begin
  inherited;
  FillChar(Format, SizeOf(Format), 0);
  with Format do
  begin
    cbSize := SizeOf(Format);
    dwMask := CFM_COLOR;
    if (Font.Color = clWindowText) or (Font.Color = clDefault) then
      dwEffects := CFE_AUTOCOLOR
    else crTextColor := ColorToRGB(Font.Color);
    SendMessage(Handle, EM_SETCHARFORMAT, 0, LPARAM(@Format));
  end;
end;

procedure TCustomdxBlobPopup.WMSize(var Msg: TWMSize);
begin
  inherited;
  UpdateScrollBars;
  CheckLeftTopCoord;
end;

procedure TCustomdxBlobPopup.WMVScroll(var Message: TWMVScroll);
var
  SI: TScrollInfo;
  DeltaVScroll: Integer;
  FHeight: Integer;
begin
  if BlobEditKind <> bekPict then
  begin
    inherited;
  end
  else
  if (FPicture <> nil) and (FPicture.Graphic <> nil) and
    not FPicture.Graphic.Empty then
  begin
    DeltaVScroll := GetSystemMetrics(SM_CYVSCROLL);
    FHeight := FPicture.Height;
    with Message do
      case ScrollCode of
      SB_ENDSCROLL:
      ReleaseCapture;
        SB_LINEUP: TopCoord := TopCoord - DeltaVScroll;
        SB_LINEDOWN: TopCoord := TopCoord + DeltaVScroll;
        SB_PAGEUP: TopCoord := TopCoord - ClientHeight;
        SB_PAGEDOWN: TopCoord := TopCoord + ClientHeight;
        SB_THUMBTRACK,
        SB_THUMBPOSITION:
          begin
              SI.cbSize := sizeof(SI);
              SI.fMask := SIF_ALL;
              GetScrollInfo(Self.Handle, SB_VERT, SI);
              if SI.nTrackPos <= 0 then
                TopCoord := 0
              else
              if SI.nTrackPos >= FHeight then
                TopCoord := FHeight
              else
              begin
                if (SI.nTrackPos+1+ClientHeight) >= FHeight then
                  TopCoord := (SI.nTrackPos + 1)
                else TopCoord := ((SI.nTrackPos + 1) div 4) * 4;
              end;
          end;
        SB_BOTTOM: TopCoord := FHeight;
        SB_TOP: TopCoord := 0;
      end;
  end;
end;

procedure TCustomdxBlobPopup.CMColorChanged(var Message: TMessage);
begin
  inherited;
  SendMessage(Handle, EM_SETBKGNDCOLOR, 0, ColorToRGB(Color))
end;

procedure TCustomdxBlobPopup.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = EN_CHANGE) and not FCharCaseChanging then
  begin
    CheckCharCase;
    if not FCreating then Change;
  end;
end;

{ TdxInplaceMRUEdit }
constructor TdxInplaceMRUEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMaxItemCount := 7;
  FShowEllipsis := True;
  ImmediateDropDown := False;
end;

procedure TdxInplaceMRUEdit.AddItem(const Value: string);
var
  I: Integer;
begin
  if Value = '' then Exit; 
  I := Items.IndexOf(Value);
  if I = -1 then
  begin
    Items.Insert(0, Value);
    CheckItemCount;
  end
  else
    Items.Move(I, 0);
end;

class procedure TdxInplaceMRUEdit.CalcButtonsInfo(AViewData: TdxEditViewData);
begin
  inherited CalcButtonsInfo(AViewData);
  with TdxMRUEditViewData(AViewData) do
  begin
    if (ButtonCount > 0) and ShowEllipsis then
    begin
      Inc(ButtonCount);
      with Buttons[ButtonCount - 1] do
      begin
        Index := ButtonCount - 1;
        LeftAlignment := Buttons[0].LeftAlignment;
        if Assigned(ButtonGlyph) then
        begin
          Buttons[0].Kind := bkDown;
          Buttons[0].Width := CalcDefaultButtonWidth(AViewData, Buttons[0]);
          Glyph := ButtonGlyph;
          Kind := bkGlyph;
        end
        else
          Kind := bkEllipsis;
        Width := CalcDefaultButtonWidth(AViewData, Buttons[ButtonCount - 1]);
      end;
    end;
  end;
end;

class function TdxInplaceMRUEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxMRUEditViewData;
end;

procedure TdxInplaceMRUEdit.ValidateEdit;
begin
  inherited ValidateEdit;
  if Modified then AddItem(Text);
end;

procedure TdxInplaceMRUEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if ShowEllipsis then
    if (ShortCut(VK_RETURN, [ssCtrl]) = ShortCut(Key, Shift)) and CanModify then
    begin
      KillMessage(Handle, WM_CHAR);
      ButtonClick;
    end;
end;

procedure TdxInplaceMRUEdit.ButtonClick;
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;

function TdxInplaceMRUEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxMRUEditViewData(Result) do
    ShowEllipsis := Self.ShowEllipsis;
end;

procedure TdxInplaceMRUEdit.DoButtonDown(IsDown: Boolean; Index: Integer);
begin
  if Index = 1 then Index := -1;
  inherited DoButtonDown(IsDown, Index);
end;

procedure TdxInplaceMRUEdit.DoButtonUp(Index: Integer);
begin
  if Index = 1 then
    ButtonClick;
end;

procedure TdxInplaceMRUEdit.CheckItemCount;
begin
  if FMaxItemCount > 0 then 
    while Items.Count > FMaxItemCount do
      Items.Delete(Items.Count - 1);
end;
      
procedure TdxInplaceMRUEdit.SetMaxItemCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxItemCount <> Value then
  begin
    FMaxItemCount := Value;
    CheckItemCount;
  end;
end;

procedure TdxInplaceMRUEdit.SetShowEllipsis(Value: Boolean);
begin
  if FShowEllipsis <> Value then
  begin
    FShowEllipsis := Value;
    StyleChanged;
  end;
end;

{ TdxPopupEditForm }
destructor TdxPopupEditForm.Destroy;
begin
  if PopupFormList <> nil then
    PopupFormList.Remove(Self);
  inherited Destroy;
end;

procedure TdxPopupEditForm.ClosePopup(Accept: Boolean);
var
  I: Integer;
  AEditText: string;
begin
  if FClosePopup then Exit;
  FClosePopup := True;
  try
    if Accept and not OwnerControl.CanCloseQuery(Self) then
    begin
      ModalResult := 0;
      Exit;
    end;
    // Close Child Popup
    if PopupFormList <> nil then
    begin
      for I := PopupFormList.Count - 1 downto 0 do
      begin
        if TdxPopupEditForm(PopupFormList[I]) = Self then Break;
        if IsWindowEnabled(TdxPopupEditForm(PopupFormList[I]).Handle) then // is modal?
          TdxPopupEditForm(PopupFormList[I]).ClosePopup(False);
      end;
    end;
    with OwnerControl do
    begin
      AEditText := Text;
      DoCloseUp(Self, AEditText, Accept);
      if Accept and CanModify and (AEditText <> Text) and EditCanModify then
      begin
        Text := AEditText;
        Modified := True;
      end;
    end;
    // Close Self
    Visible := False;
    if PopupFormList <> nil then
      PopupFormList.Remove(Self);
  finally
    FClosePopup := False;
  end;
end;

procedure TdxPopupEditForm.ShowPopup;
var
  Msg: TMsg;
  Edit: TdxInplacePopupEdit;
  I: Integer;
begin
  if PopupFormList = nil then
    PopupFormList := TList.Create;
  PopupFormList.Add(Self);
  Self.FreeNotification(OwnerControl);
  Show;
  ModalResult := 0;
  while Visible and Assigned(OwnerControl) and not Application.Terminated do
  begin
    // check Mouse Down
    if PeekMessage(Msg, 0, WM_NCLBUTTONDOWN, WM_NCLBUTTONDOWN, PM_NOREMOVE) or
      PeekMessage(Msg, 0, WM_NCLBUTTONDBLCLK, WM_NCLBUTTONDBLCLK, PM_NOREMOVE) or
      PeekMessage(Msg, 0, WM_LBUTTONDOWN, WM_LBUTTONDOWN, PM_NOREMOVE) or
      PeekMessage(Msg, 0, WM_LBUTTONDBLCLK, WM_LBUTTONDBLCLK, PM_NOREMOVE) then
    begin
      Edit := OwnerControl;
      if PopupFormList <> nil then
        for I := PopupFormList.Count - 1 downto 0 do
            if TdxPopupEditForm(PopupFormList[I]).OwnerControl.Handle = Msg.hwnd then
            begin
              Edit := TdxInplacePopupEdit(TdxPopupEditForm(PopupFormList[I]).OwnerControl);
              Break;
            end;
      with Edit do
        if (Msg.hwnd = Handle) and FPopupFormVisible and
          ({TODO PtInRect(GetButtonRect, SmallPointToPoint(TSmallPoint(Msg.LPARAM))) or }
          (ActiveButton <> -1) or FImmediatePopupStyle) then
          PeekMessage(Msg, 0, Msg.message, Msg.message, PM_REMOVE);
    end;
    // Check ALT+ENTER
    if PeekMessage(Msg, 0, WM_SYSKEYDOWN, WM_SYSKEYDOWN, PM_NOREMOVE) and
      (Msg.wParam in [VK_RETURN]) then
        PeekMessage(Msg, 0, Msg.message, Msg.message, PM_REMOVE);
    // Deactivate    
    if not Application.Active then
      ClosePopup(False);
    // ModalResult
    if ModalResult <> 0 then
      ClosePopup(ModalResult = mrOK);
    Application.HandleMessage;
  end;  
end;

procedure TdxPopupEditForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if not (PopupFormBorderStyle in [pbsDialog, pbsDialogHelp]) then
    begin
      if not (ClientEdge and FlatBorder) then
      begin
        if FlatBorder then
          Style := Style or WS_BORDER
        else
        begin
          ExStyle := ExStyle or WS_EX_WINDOWEDGE or WS_EX_DLGMODALFRAME;
          Style := Style or WS_THICKFRAME;
        end;
      end;
    end
    else
    begin
      if ClientEdge then ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      if Sizeable then Style := Style or WS_THICKFRAME;
    end;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

procedure TdxPopupEditForm.Deactivate;
var
  ActiveWnd: HWND;
  I: Integer;
begin
  inherited Deactivate;
  if PopupFormList <> nil then
  begin
    ActiveWnd := GetActiveWindow;
    for I := PopupFormList.Count - 1 downto 0 do
    begin
      if TdxPopupEditForm(PopupFormList[I]).Handle = ActiveWnd then Exit;
      if IsWindowEnabled(TdxPopupEditForm(PopupFormList[I]).Handle) then // is modal?
        TdxPopupEditForm(PopupFormList[I]).ClosePopup(False);
    end;
  end;
  if PopupFormList.Count > 0 then ClosePopup(False); // Close Self
end;

procedure TdxPopupEditForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = OwnerControl then OwnerControl := nil;
end;

function TdxPopupEditForm.HasAsParent(APopupForm: TdxPopupEditForm): Boolean;
var
  AForm: TCustomForm;
begin
  Result := False;
  AForm := GetParentForm(Self.OwnerControl);
  if AForm = APopupForm then
    Result := True
  else
    if AForm is TdxPopupEditForm then
      Result := TdxPopupEditForm(AForm).HasAsParent(APopupForm);
end;

procedure TdxPopupEditForm.SetClientEdge(Value: Boolean);
begin
  if FClientEdge <> Value then
  begin
    FClientEdge := Value;
    RecreateWnd;
  end;
end;

procedure TdxPopupEditForm.SetFlatBorder(Value: Boolean);
begin
  if FFlatBorder <> Value then
  begin
    FFlatBorder := Value;
    RecreateWnd;
  end;
end;

procedure TdxPopupEditForm.SetPopupFormBorderStyle(Value: TdxPopupEditFormBorderStyle);
begin
  if FPopupFormBorderStyle <> Value then
  begin
    FPopupFormBorderStyle := Value;
    if FPopupFormBorderStyle in [pbsDialog, pbsDialogHelp] then
      BorderStyle := bsDialog
    else BorderStyle := bsNone;
    if FPopupFormBorderStyle = pbsDialogHelp then
      BorderIcons := BorderIcons + [biHelp]
    else BorderIcons := BorderIcons - [biHelp];
    RecreateWnd;
  end;
end;

procedure TdxPopupEditForm.SetSizeable(Value: Boolean);
begin
  if FSizeable <> Value then
  begin
    FSizeable := Value;
    RecreateWnd;
  end;
end;

type TCustomdxContainerCrack = class(TCustomdxContainer);

procedure TdxPopupEditForm.WMActivate(var Message: TWMActivate);
var
  I: Integer;
begin
  inherited;
  if PopupFormList <> nil then
    for I := 0 to PopupFormList.Count - 1 do
    begin
      SendMessage(GetParentForm(TdxPopupEditForm(PopupFormList[I]).OwnerControl).Handle,
        WM_NCACTIVATE, Longint(Message.Active <> WA_INACTIVE), 0);
      if Assigned(TCustomdxContainerCrack(TdxPopupEditForm(PopupFormList[I]).OwnerControl.Container)) then
        TCustomdxContainerCrack(TdxPopupEditForm(PopupFormList[I]).OwnerControl.Container).RedrawSelection;
    end;
end;

procedure TdxPopupEditForm.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  if FCloseButtonIsTracking then
  begin
    FCloseButtonIsTracking := False;
    FMouseAboveCloseButton := False;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TdxPopupEditForm.WMClose(var Message: TWMClose);
begin
  if OwnerControl.CanCloseQuery(Self) then inherited;
end;

procedure TdxPopupEditForm.WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(PopupMinWidth, PopupMinHeight);
  inherited;
end;

procedure TdxPopupEditForm.WMLButtonUp(var Message: TWMLButtonUp);
begin
  if FCloseButtonIsTracking then
  begin
    FCloseButtonIsTracking := False;
    ReleaseCapture;
    if FMouseAboveCloseButton then
      PostMessage(Handle, WM_CLOSE, 0, 0); // Hide
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
  inherited;
end;

procedure TdxPopupEditForm.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  H: Integer;
begin
  inherited;
  if PopupFormBorderStyle in [pbsSimple, pbsSysPanel] then
    with Message.CalcSize_Params^.rgrc[0] do
    begin
      H := FSysPanelHeight;
      // Frame
      if ClientEdge then
        if FlatBorder then
          InflateRect(Message.CalcSize_Params^.rgrc[0], -3, -3)
        else
          InflateRect(Message.CalcSize_Params^.rgrc[0], -2, -2);
      // SysPanel
      if PopupFormBorderStyle = pbsSysPanel then
        if SizingCorner in [coBottomLeft, coBottomRight] then
          Dec(Bottom, H)
        else
          Inc(Top, H);
    end;
end;

procedure TdxPopupEditForm.WMNCCreate(var Message: TWMNCCreate);
var
  SysMenu: HMENU;
  Info: TMenuItemInfo;
  S: array [0..1023] of Char;
  ItemExist: Boolean;
begin
  SysMenu := GetSystemMenu(Handle, False);
  Info.cbSize := 44; // Required
  Info.fMask := MIIM_ID or MIIM_TYPE;
  Info.dwTypeData := @S[0];
  Info.cch := 1024;
  ItemExist := Sizeable and GetMenuItemInfo(SysMenu, SC_SIZE, False{MF_BYCOMMAND}, Info);
  inherited;
  DeleteMenu(SysMenu, SC_MOVE, MF_BYCOMMAND);
  if ItemExist then
    InsertMenuItem(SysMenu, 0, True, Info);
  // Calc SysPanel Height
  FSysPanelHeight := 0;
  FSysPanelBorder := 0;
  if PopupFormBorderStyle = pbsSysPanel then
  begin
    FSysPanelHeight := GetSystemMetrics(SM_CYHSCROLL) + 2;
    if FSysPanelHeight < (dxDropDownNCHeight-1) then
      FSysPanelHeight := (dxDropDownNCHeight-1);
    if FlatBorder then
      if not ClientEdge then
      begin
        Inc(FSysPanelHeight);
        FSysPanelBorder := 1;
      end;
  end;
end;

procedure TdxPopupEditForm.WMNCHitTest(var Message: TWMNCHitTest);
type
  TCornerHitTest = {Windows.HTNOWHERE}0..Windows.HTHELP;
  TCornerHitTests = set of TCornerHitTest;
const
  SizingHitTest = [Windows.HTLEFT, Windows.HTRIGHT, Windows.HTTOP, Windows.HTTOPLEFT,
    Windows.HTTOPRIGHT, Windows.HTBOTTOM, Windows.HTBOTTOMLEFT, Windows.HTBOTTOMRIGHT];
  CornerHitTest: array [TdxCorner] of TCornerHitTests = (
    [Windows.HTLEFT, Windows.HTTOPLEFT, Windows.HTTOP],
    [Windows.HTTOP, Windows.HTTOPRIGHT, Windows.HTRIGHT],
    [Windows.HTLEFT, Windows.HTBOTTOMLEFT, Windows.HTBOTTOM],
    [Windows.HTBOTTOM, Windows.HTBOTTOMRIGHT, Windows.HTRIGHT]);

  function GetCornerHitTestAt(X, Y: Integer): TCornerHitTest;
  var
    P: TPoint;
    R: TRect;
    CX, CY: Integer;
  begin
    Result := Windows.HTNOWHERE;
    P := Point(X, Y);
    GetWindowRect(Handle, R);
    CX := GetSystemMetrics(SM_CXVSCROLL);
    CY := GetSystemMetrics(SM_CYHSCROLL);
    with R do
    begin
      if PtInRect(Rect(Left, Top, Left + CX, Top + CY), P) then
        Result := Windows.HTTOPLEFT
      else
      if PtInRect(Rect(Right - CX, Top, Right, Top + CY), P) then
        Result := Windows.HTTOPRIGHT
      else
      if PtInRect(Rect(Left, Top, Right, Top + CY), P) then
        Result := Windows.HTTOP
      else
      if PtInRect(Rect(Right - CX, Bottom - CY, Right, Bottom), P) then
        Result := Windows.HTBOTTOMRIGHT
      else
      if PtInRect(Rect(Right - CX, Top, Right, Bottom), P) then
        Result := Windows.HTRIGHT
      else
      if PtInRect(Rect(Left, Bottom - CY, Left + CX, Bottom), P) then
        Result := Windows.HTBOTTOMLEFT
      else
      if PtInRect(Rect(Left, Bottom - CY, Right, Bottom), P) then
        Result := Windows.HTBOTTOM
      else
      if PtInRect(Rect(Left, Top, Left + CX, Bottom), P) then
        Result := Windows.HTLEFT;
    end;
  end;

var
  PrevMouseAboveCloseButton: Boolean;
begin
  inherited;
  if Sizeable then
  begin
    if Message.Result in [Windows.HTBORDER, Windows.HTNOWHERE] then
      Message.Result := GetCornerHitTestAt(Message.XPos, Message.YPos);
    if (Message.Result in SizingHitTest) and
      not (Message.Result in CornerHitTest[SizingCorner]) then
      Message.Result := Windows.HTNOWHERE;
  end;

  if PopupFormBorderStyle = pbsSysPanel then
    with Message do
      if Sizeable and PtInRect(FGripRect, SmallPointToPoint(Pos)) then
        Result := GetHitTestByCorner(SizingCorner)
      else
      begin
        PrevMouseAboveCloseButton := FMouseAboveCloseButton;
        FMouseAboveCloseButton := {(GetTopWindow(0) = Handle) and}
          ((GetCapture = 0) or FCloseButtonIsTracking) and
          PtInRect(FCloseButtonRect, SmallPointToPoint(Pos));
        if FMouseAboveCloseButton then Result := HTBORDER;
        if PrevMouseAboveCloseButton <> FMouseAboveCloseButton then
          SendMessage(Handle, WM_NCPAINT, 0, 0);
      end;
  if not Sizeable and (Message.Result in SizingHitTest) then
    Message.Result := Windows.HTNOWHERE;
end;

procedure TdxPopupEditForm.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  if FMouseAboveCloseButton then
  begin
    FCloseButtonIsTracking := True;
    SetCapture(Handle);
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TdxPopupEditForm.WMNCPaint(var Message: TWMNCPaint);
var
  R, CR, FR: TRect;
  B, DX, DY: Integer;
  DC: HDC;
  ABrush: HBRUSH;
  AStyle: Longint;
begin
  inherited;
  if not (PopupFormBorderStyle in [pbsSimple, pbsSysPanel]) then Exit;

  DC := GetWindowDC(Handle);

  GetWindowRect(Handle, R);
  FCloseButtonRect := R;
  FGripRect := R;
  Windows.GetClientRect(Handle, CR);
  MapWindowPoints(0, Handle, R, 2);
  B := -R.Left;
  OffsetRect(CR, -R.Left, -R.Top);
  OffsetRect(R, -R.Left, -R.Top);
  InflateRect(R, -B, -B);
  // Draw Frame
  if ClientEdge then
  begin
    FR := R;
    if FlatBorder then
    begin
      InflateRect(FR, B, B);
      DrawEdge(DC, FR, EDGE_RAISED, BF_RECT);
      InflateRect(FR, -2, -2);
      if SizingCorner in [coBottomLeft, coBottomRight] then
        Dec(FR.Bottom, FSysPanelHeight)
      else Inc(FR.Top, FSysPanelHeight);
      DrawEdge(DC, FR, BDR_SUNKENOUTER, BF_RECT);
    end
    else
    begin
      InflateRect(FR, 2, 2);
      if SizingCorner in [coBottomLeft, coBottomRight] then
        Dec(FR.Bottom, FSysPanelHeight)
      else Inc(FR.Top, FSysPanelHeight);
      DrawEdge(DC, FR, EDGE_SUNKEN, BF_RECT);
    end;
  end;

  if PopupFormBorderStyle = pbsSysPanel then
  begin
    if FlatBorder then
      ABrush := GetSysColorBrush(COLOR_WINDOWFRAME)
    else ABrush := GetSysColorBrush(COLOR_BTNFACE);

    if ClientEdge then
    begin
      if FlatBorder then B := 1
      else B := 2;
      InflateRect(R, B, 0);
      if SizingCorner in [coBottomLeft, coBottomRight] then
        OffsetRect(R, 0, B)
      else OffsetRect(R, 0, -B);
    end;
    if SizingCorner in [coBottomLeft, coBottomRight] then
    begin
      R.Top := R.Bottom - FSysPanelHeight + FSysPanelBorder;
      if not (FlatBorder and ClientEdge) then
        FillRect(DC, Rect(R.Left, R.Top - FSysPanelBorder, R.Right, R.Top), ABrush);
    end
    else
    begin
      R.Bottom := R.Top + FSysPanelHeight - FSysPanelBorder;
      if not (FlatBorder and ClientEdge) then
        FillRect(DC, Rect(R.Left, R.Bottom, R.Right, R.Bottom + FSysPanelBorder), ABrush);
    end;

    DX := 0;
    DY := 0;
    if not FlatBorder then
    begin
      DX := 1;
      DY := 1;
      if SizingCorner in [coTopLeft, coTopRight] then
        DY := -DY;
      if SizingCorner in [coTopRight, coBottomRight] then
        DX := -DX;
    end;

    if Sizeable then
    begin
      CR := R;
      if not FlatBorder then
        OffsetRect(CR, -DX, DY);
      DrawSizeGrip(DC, CR, SizingCorner);
      with CR do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      InflateRect(CR, 2, 2);
      if CR.Top < R.Top then CR.Top := R.Top;
      if CR.Bottom > R.Bottom then CR.Bottom := R.Bottom;
      OffsetRect(CR, FGripRect.Left, FGripRect.Top);
      FGripRect := CR;
    end;

    CR := R;
    if not FlatBorder then
      OffsetRect(CR, DX, DY);
    DrawCloseButton(DC, CR, FMouseAboveCloseButton or FCloseButtonIsTracking,
      FMouseAboveCloseButton and FCloseButtonIsTracking, SizingCorner);
    with CR do
      ExcludeClipRect(DC, Left, Top, Right, Bottom);
    with FCloseButtonRect do OffsetRect(CR, Left, Top);
    FCloseButtonRect := CR;

    FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
    if SizingCorner in [coBottomLeft, coBottomRight] then
    begin
      AStyle := GetWindowLong(Handle, GWL_STYLE);
      if (AStyle and WS_HSCROLL <> 0) and (AStyle and WS_VSCROLL <> 0) then
        with R do
        begin
          Left := Right - GetSystemMetrics(SM_CXVSCROLL);
          Bottom := Top - 1;
          Top := Bottom - GetSystemMetrics(SM_CYHSCROLL);
          FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
        end;
    end;
  end;

  ReleaseDC(Handle, DC);
end;

procedure TdxPopupEditForm.WMQueryEndSession(var Message: TWMQueryEndSession);
begin
  Message.Result := Integer(OwnerControl.CanCloseQuery(Self));
end;

procedure TdxPopupEditForm.WMSizing(var Message: TMessage);
type
  TCornerHitTest = WMSZ_LEFT..WMSZ_BOTTOMRIGHT;
  TCornerHitTests = set of TCornerHitTest;
const
  CornerHitTest: array [TdxCorner] of TCornerHitTests = (
    [WMSZ_LEFT, WMSZ_TOPLEFT, WMSZ_TOP],
    [WMSZ_TOP, WMSZ_TOPRIGHT, WMSZ_RIGHT],
    [WMSZ_LEFT, WMSZ_BOTTOMLEFT, WMSZ_BOTTOM],
    [WMSZ_BOTTOM, WMSZ_BOTTOMRIGHT, WMSZ_RIGHT]);
begin
  inherited;
  if not (Sizeable and (Message.WParam in CornerHitTest[SizingCorner])) then
    PRect(Message.lParam)^ := BoundsRect;
end;

procedure TdxPopupEditForm.WMSysCommand(var Message: TWMSysCommand);
begin
  if Message.CmdType = SC_KEYMENU then
    Message.Result := 0
  else inherited;
end;

procedure TdxPopupEditForm.WMSysKeyDown(var Message: TWMSysKeyDown);
begin
  // TODO 
  if Message.CharCode in [VK_RETURN, VK_MENU] then
    Message.Result := 0
  else inherited;
end;

procedure TdxPopupEditForm.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if FMouseAboveCloseButton then
  begin
    FMouseAboveCloseButton := False;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

{ TdxInplacePopupEdit }
constructor TdxInplacePopupEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSendChildrenStyle := False;
  FPopupAutoSize := True;
  FPopupFlatBorder := True;
  FPopupHeight := 200;
  FPopupMinHeight := 100;
  FPopupMinWidth := 100;
  FPopupSizeable := True;
  FPopupWidth := 250;
end;

destructor TdxInplacePopupEdit.Destroy;
begin
  if FPopupForm <> nil then FPopupForm.Free;
  inherited Destroy;
end;

procedure TdxInplacePopupEdit.Hide;
begin
  if FPopupFormVisible and (PopupForm <> nil) and
    PopupForm.Visible then PopupForm.ClosePopup(False);
  inherited Hide;
end;

function IsPopupActive(APopupForm: TdxPopupEditForm): Boolean;
var
  I: Integer;
begin
  Result := APopupForm.Active;
  if not Result then
  begin
    for I := PopupFormList.Count - 1 downto 0 do
      if TdxPopupEditForm(PopupFormList[I]).Active then
      begin
        if TdxPopupEditForm(PopupFormList[I]).HasAsParent(APopupForm) then
          Result := True;
        Break;
      end;
  end;
end;

function TdxInplacePopupEdit.IsEditClass: Boolean;
begin
  Result := not FHideEditCursor;
end;

function TdxInplacePopupEdit.IsFocused: Boolean;
begin
  Result := inherited IsFocused or ((PopupForm <> nil) and
    FPopupFormVisible and IsPopupActive(PopupForm){PopupForm.Active});
end;

function TdxInplacePopupEdit.IsResetTextClass: Boolean;
begin
  Result := True;
end;

procedure TdxInplacePopupEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FInitedPopupControl then FInitedPopupControl := nil;
    if AComponent = PopupControl then PopupControl := nil;
  end;
end;

procedure TdxInplacePopupEdit.CalcSize(APopupForm: TdxPopupEditForm);
const
  Corners: array[Boolean, Boolean] of TdxCorner =
    ((coTopLeft, coBottomLeft), (coTopRight, coBottomRight));
var
  EditRect, DropDownRect, R: TRect;
  ALeftFlag, ABottomFlag: Boolean;
begin
  // TODO p
  Windows.GetWindowRect(Self.Handle, EditRect);
  Windows.GetWindowRect(APopupForm.Handle, DropDownRect);
  OffsetRect(DropDownRect, EditRect.Left - DropDownRect.Left,
    EditRect.Top + Height - DropDownRect.Top);
  with APopupForm do
  begin
    SizingCorner := coBottomRight;
    ALeftFlag := True;
    ABottomFlag := True;
    //screen coord
//    SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
    R := GetScreenWorkArea(Point(Left, Top));
    // check x coord
    if APopupForm.Width > Self.Width then
    begin
      if (DropDownRect.Right > R.Right) and
        (abs(R.Right - EditRect.Left) < abs(R.Left - EditRect.Right)) then
      begin
        OffsetRect(DropDownRect, - (DropDownRect.Right - DropDownRect.Left) + Self.Width, 0);
        ALeftFlag := False;
      end;
    end;
    // check y coord
    if (DropDownRect.Bottom > R.Bottom) then
      if (abs(R.Bottom - EditRect.Bottom) < abs(EditRect.Top - R.Top)) then
      begin
        OffsetRect(DropDownRect, 0, -(DropDownRect.Bottom - DropDownRect.Top + Self.Height));
        ABottomFlag := False;
      end;
    // set corner
    SizingCorner := Corners[ALeftFlag, ABottomFlag];
    // set pos
    Left := DropDownRect.Left;
    Top := DropDownRect.Top;
  end;
end;

function TdxInplacePopupEdit.CanCloseQuery(APopupForm: TdxPopupEditForm): Boolean;
begin
  Result := True;
  if Assigned(FOnCloseQuery) then FOnCloseQuery(Self, Result);
end;

{$WARNINGS OFF}
procedure TdxInplacePopupEdit.DoCloseUp(APopupForm: TdxPopupEditForm; var EditText: string; var Accept: Boolean);
begin
  PopupHeight := APopupForm.Height;
  PopupWidth := APopupForm.Width;
  if Assigned(FOnCloseUp) then
    FOnCloseUp(Self, EditText, Accept);
end;
{$WARNINGS ON}

procedure TdxInplacePopupEdit.DoDropDownPopupForm;
begin
  // TODO p
  if FPopupFormVisible then Exit;
  Windows.SetFocus(Handle);
  if GetFocus <> Handle then Exit;
//  if ReadOnly then Exit;
  EditButtonClick;

  if FPopupForm = nil then
    FPopupForm := TdxPopupEditForm.CreateNew(nil);
  FPopupForm.OwnerControl := Self;

  FActiveList := FPopupForm;
  with FPopupForm do
  begin
    // Initialize
    InitializePopup(FPopupForm);
    // Before Event
    FListVisible := False;
    FPopupFormVisible := True;
    try
      ShowPopup;
    finally
      FPopupFormVisible := False;
    end;
    // After Event
    FinalizePopup(FPopupForm);
  end;
  FActiveList := nil;
end;

procedure TdxInplacePopupEdit.DoInitPopup;
begin
  if Assigned(FOnInitPopup) then FOnInitPopup(Self);
end;

procedure TdxInplacePopupEdit.DoPopup(APopupForm: TdxPopupEditForm);
begin
  if Assigned(FOnPopup) then FOnPopup(Self, Self.Text);
end;

procedure TdxInplacePopupEdit.DropDown;
begin
  PostMessage(Handle, CM_DROPDOWNPOPUPFORM, 0, 0);
end;

type
  TCustomFormCrack = class(TCustomForm);

procedure TdxInplacePopupEdit.FinalizePopup(APopupForm: TdxPopupEditForm);
begin
  // Restore ChildControl settings
  if FInitedPopupControl <> nil then
  begin
    // Restore Prev settings
    if FInitedPopupControl is TCustomForm then
      TCustomFormCrack(FInitedPopupControl).BorderStyle := FPopupControlBorderStyle;
    FInitedPopupControl.Align := FPopupControlAlign;
    FInitedPopupControl.BoundsRect := FPopupControlBoundsRect;
    FInitedPopupControl.Visible := FPopupControlVisible;
    FInitedPopupControl.Parent := FPopupControlParent;
  end;
end;

procedure TdxInplacePopupEdit.InitializePopup(APopupForm: TdxPopupEditForm);

  function ControlHasAsParent(AControl: TControl): Boolean;
  var
    AParent: TControl;
  begin
    Result := AControl = FPopupForm;
    AParent := FPopupForm.OwnerControl;
    while AParent <> nil do
    begin
      if AParent = AControl then
      begin
        Result := True;
        Break;
      end;
      AParent := AParent.Parent;
    end;
  end;

begin
  DoInitPopup; // change Child Control
  with APopupForm do
  begin
    if ControlHasAsParent(FPopupControl) then
      raise Exception.Create('Circular referencing is not allowed');
    // Default Popup Style
    FFlatBorder := True;
    FSizeable := True;
    BorderStyle := bsDialog;
    ClientEdge := False;
    FlatBorder := True;
    PopupFormBorderStyle := pbsDialog;
    Sizeable := True;
    PopupMinHeight := 100;
    PopupMinWidth := 100;
    // Popup Style
    PopupFormBorderStyle := Self.PopupFormBorderStyle;
    ClientEdge := PopupClientEdge;
    FlatBorder := PopupFlatBorder;
    Sizeable := PopupSizeable;
    Caption := PopupFormCaption;
    PopupMinHeight := PopupMinHeight;
    PopupMinWidth := PopupMinWidth;
    // Popup Size
    if FPopupControl <> nil then
    begin
      // Save Prev settings
      FInitedPopupControl := FPopupControl;
      FPopupControlAlign := FPopupControl.Align;
      FPopupControlBorderStyle := bsNone;
      FPopupControlBoundsRect := FPopupControl.BoundsRect;
      FPopupControlParent := FPopupControl.Parent;
      FPopupControlVisible := FPopupControl.Visible;
      // Set New settings
      FPopupControl.Visible := False;
      if FPopupControl is TCustomForm then
      begin
        FPopupControlBorderStyle := TCustomFormCrack(FPopupControl).BorderStyle;
        TCustomFormCrack(FPopupControl).BorderStyle := bsNone;
      end;
      FPopupControl.Left := 0;
      FPopupControl.Top := 0;
      if PopupAutoSize then
      begin
        ClientWidth := FPopupControl.Width;
        ClientHeight := FPopupControl.Height;
      end
      else
      begin
        Width := PopupWidth;
        Height := PopupHeight;
      end;
      FPopupControl.Align := alClient;
      FPopupControl.Parent := FPopupForm;
      FPopupControl.Visible := True;
    end;
    CalcSize(APopupForm);
    CalcPosition(APopupForm, False); // TODO new
    RecreateWnd; // NCCalc Resize (SysPanel orientation)
  end;
  DoPopup(APopupForm);
end;

procedure TdxInplacePopupEdit.SetHideEditCursor(Value: Boolean);
begin
  if FHideEditCursor <> Value then
  begin
    FHideEditCursor := Value;
    FImmediatePopupStyle := FHideEditCursor; // TODO? Prev save?
    RecreateWnd;
  end;
end;

procedure TdxInplacePopupEdit.SetPopupControl(Value: TControl);
begin
  FPopupControl := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

procedure TdxInplacePopupEdit.SetPopupHeight(Value: Integer);
begin
  if Value < FPopupMinHeight then Value := FPopupMinHeight;
  if FPopupHeight <> Value then
  begin
    FPopupHeight := Value;
  end;  
end;

procedure TdxInplacePopupEdit.SetPopupMinHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FPopupMinHeight := Value;
  SetPopupHeight(FPopupHeight);
end;

procedure TdxInplacePopupEdit.SetPopupMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FPopupMinWidth := Value;
  SetPopupWidth(FPopupWidth);
end;

procedure TdxInplacePopupEdit.SetPopupWidth(Value: Integer);
begin
  if Value < FPopupMinWidth then Value := FPopupMinWidth;
  if FPopupWidth <> Value then
  begin
    FPopupWidth := Value;
  end;  
end;

procedure TdxInplacePopupEdit.CMDropDownPopupForm(var Message: TMessage);
begin
  DoDropDownPopupForm;
end;

var
  I: TdxPopupToolBarButton;
  J: TdxDateEditSmartInput;

initialization
  GetCheckSize;
  Screen.Cursors[crdxHandPointCursor] := LoadCursor(HInstance, dxHandPointCursor);
  // Date Edit
  sdxDateError := LoadStr(dxSDateError);
  // Time Edit
  dxTimeEditOneSec    := EncodeTime(0, 0, 1, 0); // '00:00:01'
  dxTimeEditOneMin    := EncodeTime(0, 1, 0, 0); // '00:01:00'
  dxTimeEditOneHour   := EncodeTime(1, 0, 0, 0); // '01:00:00'
  dxTimeEditMinValue  := EncodeTime(0, 0, 0, 0); // '00:00:00'
  dxTimeEditMaxValue  := EncodeTime(23, 59, 59, 0); // '23:59:59'
  // Graphic Edit
  LoadPopupMenuImages;
  for I := ptbCut to ptbSave do
  begin
    // caption
    ToolButtons[I, 0] := LoadStr(dxSToolBarButtonCaptionCut + Byte(I));
    // hint
    ToolButtons[I, 1] := LoadStr(dxSToolBarButtonHintCut + Byte(I));
  end;
  ToolButtons[ptbCustom, 0] := '';
  ToolButtons[ptbCustom, 1] := '';
  TempCanvas := TCanvas.Create; // for Graphic.Draw
  // load blob images
  LoadBlobImages;
  // load blob buttons
  sdxBlobEditButtons[bebOK] := LoadStr(dxSBlobButtonOK);
  sdxBlobEditButtons[bebCancel] := LoadStr(dxSBlobButtonCancel);
  sdxBlobEditButtons[bebClose] := LoadStr(dxSBlobButtonClose);

  sdxBlobPopupItems[0] := LoadStr(dxSBlobPopupCut);
  sdxBlobPopupItems[1] := LoadStr(dxSBlobPopupCopy);
  sdxBlobPopupItems[2] := LoadStr(dxSBlobPopupPaste);
  sdxBlobPopupItems[3] := LoadStr(dxSBlobPopupDelete);
  sdxBlobPopupItems[4] := LoadStr(dxSBlobPopupSave);
  sdxBlobPopupItems[5] := LoadStr(dxSBlobPopupLoad);

  DefaultCheckEditStyleController := TdxCheckEditStyleController.Create(nil);

  for J := Low(TdxDateEditSmartInput) to High(TdxDateEditSmartInput) do
    sdxDateEditSmartInput[J] := LoadStr(dxSDateToday + Ord(J));

finalization
  DefaultCheckEditStyleController.Free;
  DefaultCheckEditStyleController := nil;
  TempCanvas.Free;
  TempCanvas := nil;
  if dxGraphicPopupMenuImages <> nil then dxGraphicPopupMenuImages.Free;
  dxGraphicPopupMenuImages := nil;
  if imgBlobImages <> nil then imgBlobImages.Free;
  imgBlobImages := nil;

  if PopupFormList <> nil then
  begin
    PopupFormList.Free;
    PopupFormList := nil;
  end;

  {$IFDEF DELPHI4}
  DestroyCursor(Screen.Cursors[crdxHandPointCursor]);
  {$ENDIF}

end.

