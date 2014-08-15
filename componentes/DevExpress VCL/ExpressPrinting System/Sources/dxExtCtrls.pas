{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxExtCtrls;

interface

{$I cxVer.inc}

uses
  Windows, Messages, Classes, Graphics, Controls, StdCtrls, ExtCtrls, ComCtrls,
  ImgList, Menus, Forms, Dialogs, dxCore;

type
  { TdxPSSpinEdit }

  TdxButtonType = (btLine, btPage);
  TdxSpinValueType = (svtInteger, svtFloat);
  TdxScrollMouseSensetivity = (msLow, msMedium, msHigh);

  TdxSpinButtonClickEvent = procedure(Sender: TObject; ButtonType: TdxButtonType;
    Button: TUDBtnType) of object;

  TdxPSSpinEdit = class(TCustomEdit)
  private
    FAlignment: TAlignment;
    FArrowKeys: Boolean;
    FCheckBounds: Boolean;
    FDecimal: Byte;
    FDefaultValue: Extended;
    FEditorEnabled: Boolean;
    FFlat: Boolean;
    FIncrButtonWidth: Integer;
    FIncrement: Extended;
    FLastGoodValue: Extended;
    FLegendText: string;
    FLockChange: Boolean;
    FMaxValue: Extended;
    FMinValue: Extended;
    FMouseInControl: Boolean;
    FPageIncrButtonWidth: Integer;
    FPageIncrement: Extended;
    FPageUpDown: TCustomUpDown;
    FSaveValue: Extended;
    FScrollMouseSens: TdxScrollMouseSensetivity;
    FUpDown: TCustomUpDown;
    FUsePageIncr: Boolean;
    FValueType: TdxSpinValueType;
    FOnButtonClick: TdxSpinButtonClickEvent;
    function GetAsInteger: Longint;
    function GetButtonWidth: Integer;
    function GetLegendText: string;
    function GetMinHeight: Integer;
    function IsDefaultValueStored: Boolean;
    function IsIncrButtonWidthStored: Boolean;
    function IsIncrementStored: Boolean;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    function IsPageIncrButtonWidthStored: Boolean;
    function IsPageIncrementStored: Boolean;
    function IsValueStored: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetAsInteger(NewValue: Longint);
    procedure SetCheckBounds(Value: Boolean);
    procedure SetDecimal(NewValue: Byte);
    procedure SetDefaultValue(NewDefaultValue: Extended);
    procedure SetFlat(Value: Boolean);
    procedure SetIncrButtonWidth(Value: Integer);
    procedure SetLegendText(const Value: string);
    procedure SetMaxValue(Value: Extended);
    procedure SetMinValue(Value: Extended);
    procedure SetPageIncrButtonWidth(Value: Integer);
    procedure SetScrollMouseSens(Value: TdxScrollMouseSensetivity);
    procedure SetUsePageIncr(Value: Boolean);
    procedure SetValueType(NewType: TdxSpinValueType);
    procedure GetTextHeight(var SysHeight, Height: Integer);
    procedure PageUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure RecreateButton;
    procedure ResizeButtons;
    procedure SetEditRect;
    procedure UpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMCut(var Message: TWMCut); message WM_CUT;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
   {$IFNDEF DELPHI5}
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
   {$ENDIF}
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
 
    function CheckValue(NewValue: Extended): Extended;
    procedure DoButtonClick(ButtonType: TdxButtonType; Button: TUDBtnType);
    function GetValue: Extended; virtual;
    function GetValueText: string; virtual;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure SetValue(NewValue: Extended); virtual;
    procedure SpecialKeyClick(Key: Word; Shift: TShiftState; Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property AsInteger: Longint read GetAsInteger write SetAsInteger;
    property Text;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property ArrowKeys: Boolean read FArrowKeys write FArrowKeys default True;
    property CheckBounds: Boolean read FCheckBounds write SetCheckBounds default True;
    property UsePageIncr: Boolean read FUsePageIncr write SetUsePageIncr default False;
    property PageIncrement: Extended read FPageIncrement write FPageIncrement stored IsPageIncrementStored;
    property IncrButtonWidth: Integer read FIncrButtonWidth write SetIncrButtonWidth stored IsIncrButtonWidthStored;
    property PageIncrButtonWidth: Integer read FPageIncrButtonWidth write SetPageIncrButtonWidth stored IsPageIncrButtonWidthStored;
    property ScrollMouseSens: TdxScrollMouseSensetivity read FScrollMouseSens write SetScrollMouseSens default msMedium;
    property DefaultValue: Extended read FDefaultValue write SetDefaultValue stored IsDefaultValueStored;
    property Decimal: Byte read FDecimal write SetDecimal default 2;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Flat: Boolean read FFlat write SetFlat default False;
    property Increment: Extended read FIncrement write FIncrement stored IsIncrementStored;
    property LegendText: string read GetLegendText write SetLegendText;
    property MaxValue: Extended read FMaxValue write SetMaxValue stored IsMaxStored;
    property MinValue: Extended read FMinValue write SetMinValue stored IsMinStored;
    property ValueType: TdxSpinValueType read FValueType write SetValueType default svtInteger;
    property Value: Extended read GetValue write SetValue stored IsValueStored;

    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnButtonClick: TdxSpinButtonClickEvent read FOnButtonClick write FOnButtonClick;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
   {$IFDEF DELPHI5}
    property OnContextPopup;
   {$ENDIF}
  end;

  { TdxPSColorCombo }
  
  TdxColorType = (ctPure, ctSystem);
  TdxColorTypes = set of TdxColorType;

  TdxColorKind = (ckNormal, ckAuto, ckCustom);
  
  TdxSelectColorProc = function(var AColor: TColor): Boolean of object;

  TdxGetSelectColorProcEvent = procedure(Sender: TObject;
    var SelectColorProc: TdxSelectColorProc) of object;

  TdxOnGetColorNameEvent = procedure(Sender: TObject; Index: Integer;
    AColor: TColor; AKind: TdxColorKind; var AName: string) of object;

  TdxPSColorCombo = class(TCustomComboBox)
  private
    FAutoColor: TColor;
    FAutoColorText: string;
    FColorTypes: TdxColorTypes;
    FCustomColorText: string;
    FDropDownCountAssigned: Boolean;
    FEndEllipsis: Boolean;
    FIsAutoColorTextAssigned: Boolean;
    FIsCustomColorTextAssigned: Boolean;
    FSelEndOk: Boolean;
    FShowAutoColor: Boolean;
    FShowColorName: Boolean;
    FShowCustomColor: Boolean;
    FOnGetColorName: TdxOnGetColorNameEvent;
    FOnGetSelectColorProc: TdxGetSelectColorProcEvent;
    function GetActualDropDownCount: Integer;
    function GetAutoColorText: string;
    function GetColorTypes: TdxColorTypes;
    function GetColorValue: TColor;
    function GetCustomColorText: string;
    function GetIsAutoColorSelected: Boolean;
    function IsAutoColorTextStored: Boolean;
    function IsCustomColorTextStored: Boolean;
    procedure SetAutoColor(Value: TColor);
    procedure SetAutoColorText(const Value: string);
    procedure SetColorTypes(Value: TdxColorTypes);
    procedure SetColorValue(Value: TColor);
    procedure SetCustomColorText(const Value: string);
    procedure SetEndEllipsis(Value: Boolean);
    procedure SetShowAutoColor(Value: Boolean);
    procedure SetShowColorName(Value: Boolean);
    procedure SetShowCustomColor(Value: Boolean);
    
    function FindRGB(AColor: TColor): Integer;
    procedure ResetItemHeight;
    procedure SelectCustomColor;
    function StandardSelectColorProc(var AColor: TColor): Boolean;

    procedure ReadIsAutoColorTextAssigned(AReader: TReader);
    procedure ReadIsCustomColorTextAssigned(AReader: TReader);
    procedure WriteIsAutoColorTextAssigned(AWriter: TWriter); 
    procedure WriteIsCustomColorTextAssigned(AWriter: TWriter); 
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure Click; override;
    procedure CreateWnd; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure SetDropDownCount(const Value: Integer);{$IFDEF DELPHI6} override; {$ENDIF}

    function GetColorName(Index: Integer): string; virtual;
    procedure RefreshItems;
    function SelectColorProc: TdxSelectColorProc; dynamic;
  public
    constructor Create(AOwner: TComponent); override;

    function DefaultAutoColorText: string; virtual;
    function DefaultCustomColorText: string; virtual;
    
    property ActualDropDownCount: Integer read GetActualDropDownCount;
    property ColorNames[Index: Integer]: string read GetColorName;
    property DropDownCountAssigned: Boolean read FDropDownCountAssigned write FDropDownCountAssigned;
    property IsAutoColorSelected: Boolean read GetIsAutoColorSelected;
  published
    property Anchors;
    property AutoColor: TColor read FAutoColor write SetAutoColor default clWindowText;
    property AutoColorText: string read GetAutoColorText write SetAutoColorText stored IsAutoColorTextStored;
    property BiDiMode;
    property Color;
    property ColorTypes: TdxColorTypes read GetColorTypes write SetColorTypes default [ctPure, ctSystem];
    property ColorValue: TColor read GetColorValue write SetColorValue default clBlack;
    property Constraints;
    property CustomColorText: string read GetCustomColorText write SetCustomColorText stored IsCustomColorTextStored;
    property Ctl3D;
    property DragKind;
    property DragMode;
    property DragCursor;
    property DropDownCount write SetDropDownCount;
    property Enabled;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default False;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAutoColor: Boolean read FShowAutoColor write SetShowAutoColor default False;
    property ShowColorName: Boolean read FShowColorName write SetShowColorName default True;
    property ShowCustomColor: Boolean read FShowCustomColor write SetShowCustomColor default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
   {$IFDEF DELPHI5}
    property OnContextPopup;
   {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetColorName: TdxOnGetColorNameEvent read FOnGetColorName write FOnGetColorName;
    property OnGetSelectColorProc: TdxGetSelectColorProcEvent read FOnGetSelectColorProc write FOnGetSelectColorProc;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  { TdxPSBrushStyleCombo }
  
  TdxGetBrushStyleNameEvent = procedure(Sender: TObject; Index: Integer;
    AStyle: TBrushStyle; var AName: string) of object;

  TdxPSBrushStyleCombo = class(TCustomComboBox)
  private
    FBrushColor: TColor;
    FEndEllipsis: Boolean;
    FShowStyleName: Boolean;
    FOnGetBrushStyleName: TdxGetBrushStyleNameEvent;
    function GetStyle(Index: Integer): TBrushStyle;
    function GetStyleIndex(Style: TBrushStyle): Integer;
    function GetStyleValue: TBrushStyle;
    procedure SetBrushColor(Value: TColor);
    procedure SetEndEllipsis(Value: Boolean);
    procedure SetShowStyleName(Value: Boolean);
    procedure SetStyleValue(Value: TBrushStyle);
    procedure RefreshItems;
    procedure ResetItemHeight;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
  protected
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    function GetStyleName(Index: Integer): string; virtual;
    property Sorted;
  public
    constructor Create(AOwner: TComponent); override;
    property StyleIndexes[Style: TBrushStyle]: Integer read GetStyleIndex;
    property StyleNames[Index: Integer]: string read GetStyleName;
    property Styles[Index: Integer]: TBrushStyle read GetStyle;
  published
    property Anchors;
    property BiDiMode;
    property BrushColor: TColor read FBrushColor write SetBrushColor default clWindowText;
    property BrushStyle: TBrushStyle read GetStyleValue write SetStyleValue default bsSolid;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragKind;
    property DragMode;
    property DragCursor;
    property Enabled;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default False;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property ShowStyleName: Boolean read FShowStyleName write SetShowStyleName default False;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
   {$IFDEF DELPHI5}
    property OnContextPopup;
   {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetBrushStyleName: TdxGetBrushStyleNameEvent read FOnGetBrushStyleName write FOnGetBrushStyleName;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
  end;
  
{ TdxPSPaintPanel }

{$DEFINE CANDEFINE_DOUBLEBUFFERED}

  TdxEdgeBorder = (ebLeft, ebTop, ebRight, ebBottom);
  TdxEdgeBorders = set of TdxEdgeBorder;

  TdxEdgeStyle = (esNone, esRaised, esSunken);

  TdxPSPaintPanel = class(TCustomPanel)
  private
    FEdgeBorders: TdxEdgeBorders;
    FEdgeInner: TdxEdgeStyle;
    FEdgeOuter: TdxEdgeStyle;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FOnPaint: TNotifyEvent;
    function GetEdgeBorders: TdxEdgeBorders;
    procedure SetEdgeBorders(Value: TdxEdgeBorders);
    procedure SetEdgeInner(Value: TdxEdgeStyle);
    procedure SetEdgeOuter(Value: TdxEdgeStyle);
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure Paint; override;
    procedure DoPaint; dynamic;
    procedure DoMouseEnter; dynamic;
    procedure DoMouseLeave; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  published
    property Align;
    property Anchors;
    property Constraints;
    property DragKind;
   {$IFDEF CANDEFINE_DOUBLEBUFFERED}  
    property DoubleBuffered default True;
   {$ENDIF}       
    property EdgeBorders: TdxEdgeBorders read GetEdgeBorders write SetEdgeBorders default [ebLeft, ebTop, ebRight, ebBottom];
    property EdgeInner: TdxEdgeStyle read FEdgeInner write SetEdgeInner default esRaised;
    property EdgeOuter: TdxEdgeStyle read FEdgeOuter write SetEdgeOuter default esSunken;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Ctl3D;
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property OnCanResize;
    property OnConstrainedResize;
    property OnClick;
   {$IFDEF DELPHI5}
    property OnContextPopup;
   {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  { TdxPSBitmapAnimator }
  
  TdxPSBitmapAnimator = class(TGraphicControl)
  private
    FAnimationSpeed: Integer;
    FAnimationStepCount: Integer;    
    FBitmap: TBitmap;
    FState: Boolean;
    procedure SetBitmap(Value: TBitmap);
    procedure SetState(Value: Boolean);
  protected
    procedure Paint; override;
    procedure Resize; override;
    
    procedure Animate; dynamic;
    procedure StateChanged; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AnimationSpeed: Integer read FAnimationSpeed write FAnimationSpeed {ms} default 10;
    property AnimationStepCount: Integer read FAnimationStepCount write FAnimationStepCount default 10;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property State: Boolean read FState write SetState default False;
  end;

  { TdxPSWarningPane }
  
  TdxPSWarningPane = class(TdxPSBitmapAnimator)
  private
    FHint: string;
    procedure SetHint(const Value: string);
  protected  
    procedure InitializeBitmap; virtual;
    procedure InitializeBitmapHint(var R: TRect); virtual;
    procedure StateChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetStateAndHint(NewState: Boolean; const AHint: string);
  published
    property Font;
    property Hint: string read FHint write SetHint;
  end;
  
  { TdxPSImageScrollBox }
  
  TdxPSImageScrollBoxBuiltInMenuItem = (biiPreview, biiCopy, biiSave);
  TdxPSImageScrollBoxBuiltInMenuItems = set of TdxPSImageScrollBoxBuiltInMenuItem;
  
  TdxPSImageScrollBox = class(TScrollBox)
  private
    FBuiltInImages: TCustomImageList;
    FBuiltInMenu: TPopupMenu;
    FBuiltInMenuItemsVisibility: TdxPSImageScrollBoxBuiltInMenuItems;
    FCanvas: TControlCanvas;
    FCenter: Boolean;
    FHintText: string;
    FIsGraphicInvalid: Boolean;
    FPicture: TPicture;
    function GetCanvas: TCanvas;
    function GetHasGraphic: Boolean;
    function GetHasPictureRestRectBottom: Boolean;
    function GetHasPictureRestRectLeft: Boolean;
    function GetHasPictureRestRectRight: Boolean;
    function GetHasPictureRestRectTop: Boolean;
    function GetHasScrollBars: Boolean;
    function GetHasScrollHorzBar: Boolean;
    function GetHasScrollVertBar: Boolean;
    function GetHintTextRect: TRect;
    function GetIsPictureHeightExceedControlBounds: Boolean;
    function GetIsPictureWidthExceedControlBounds: Boolean;
    function GetPictureOriginX: Integer;
    function GetPictureOriginY: Integer;
    function GetPictureHeight: Integer;
    function GetPictureRect: TRect;
    function GetPictureWidth: Integer;
    function GetPictureRestRectBottom: TRect;
    function GetPictureRestRectRight: TRect;
    function GetPictureRestRectLeft: TRect;
    function GetPictureRestRectTop: TRect;
    procedure SetCenter(Value: Boolean);
    procedure SetHintText(const Value: string);
    procedure SetPicture(Value: TPicture);

    procedure BuiltInMenuPopup(Sender: TObject);
    procedure CopyClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure PreviewClick(Sender: TObject);
    procedure PictureChanged(Sender: TObject);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    miCopy: TMenuItem;
    miLine1: TMenuItem;
    miLine2: TMenuItem;
    miPreview: TMenuItem;
    miSave: TMenuItem;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DblClick; override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
    
    procedure CreateBuiltInImages; virtual;
    procedure CreateBuiltInMenu; virtual;
    procedure DrawHint; virtual;
    procedure DrawPicture; virtual;
    procedure DrawPictureRestSpace; virtual;
    procedure Paint; virtual;

    property HasPictureRestRectBottom: Boolean read GetHasPictureRestRectBottom;
    property HasPictureRestRectLeft: Boolean read GetHasPictureRestRectLeft;
    property HasPictureRestRectRight: Boolean read GetHasPictureRestRectRight;
    property HasPictureRestRectTop: Boolean read GetHasPictureRestRectTop;
    property HasScrollBars: Boolean read GetHasScrollBars;
    property HasScrollHorzBar: Boolean read GetHasScrollHorzBar;
    property HasScrollVertBar: Boolean read GetHasScrollVertBar;
    property HintTextRect: TRect read GetHintTextRect;
    property IsPictureHeightExceedControlBounds: Boolean read GetIsPictureHeightExceedControlBounds;
    property IsPictureWidthExceedControlBounds: Boolean read GetIsPictureWidthExceedControlBounds;
    property PictureHeight: Integer read GetPictureHeight;
    property PictureOriginX: Integer read GetPictureOriginX;
    property PictureOriginY: Integer read GetPictureOriginY;
    property PictureRect: TRect read GetPictureRect;
    property PictureRestRectBottom: TRect read GetPictureRestRectBottom;
    property PictureRestRectLeft: TRect read GetPictureRestRectLeft;
    property PictureRestRectRight: TRect read GetPictureRestRectRight;
    property PictureRestRectTop: TRect read GetPictureRestRectTop;
    property PictureWidth: Integer read GetPictureWidth;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    property BuiltInImages: TCustomImageList read FBuiltInImages;
    property BuiltInMenu: TPopupMenu read FBuiltInMenu;
    property BuiltInMenuItemsVisibility: TdxPSImageScrollBoxBuiltInMenuItems read FBuiltInMenuItemsVisibility 
      write FBuiltInMenuItemsVisibility default [biiPreview..biiSave];
    property Canvas: TCanvas read GetCanvas;
    property HasGraphic: Boolean read GetHasGraphic;
  published  
    property Center: Boolean read FCenter write SetCenter default True;
    property HintText: string read FHintText write SetHintText;
    property Picture: TPicture read FPicture write SetPicture;
  end;

function WarningSignBitmap: TBitmap;
 
var
  UseAllColorValuesInDropDownList: Boolean = True;
  
implementation

uses
 {$IFDEF DELPHI7} 
  Themes, UxTheme, 
 {$ENDIF} 
  CommCtrl, SysUtils, Registry, ExtDlgs, ClipBrd, cxClasses, dxPSUtl, dxPSImgs, 
  dxPSGlbl, dxPSRes, dxPCPrVw, dxPSPopupMan, dxExtCtrlsStrs;

const
  MinButtonWidth = 9;
  ScrollMouseSensibility: array[TdxScrollMouseSensetivity] of Integer = (10, 5, 1);

  PureColors: array[0..19] of TColor =
    (clBlack, clOlive, clTeal, clGreen, clMoneyGreen, clLime, clNavy, clBlue,
     clAqua, clSkyBlue, clGray, clMedGray, clSilver, clMaroon, clPurple, clFuchsia, clRed,
     clCream, clYellow, clWhite);
  SysColors: array[0..24] of TColor =
    (clScrollBar, clBackground, clActiveCaption, clInactiveCaption, clMenu,
     clWindow, clWindowFrame, clMenuText, clWindowText, clCaptionText, clActiveBorder,
     clInactiveBorder, clAppWorkSpace, clHighlight, clHighlightText, clBtnFace,
     clBtnShadow, clGrayText, clBtnText, clInactiveCaptionText, clBtnHighlight,
     cl3DDkShadow, cl3DLight, clInfoText, clInfoBk);

var
  FWarningSignBitmap: TBitmap;
  
function WarningSignBitmap: TBitmap;
begin
  if FWarningSignBitmap = nil then
  begin
    FWarningSignBitmap := TBitmap.Create;
    Bitmap_LoadFromResourceName(FWarningSignBitmap, IDB_DXPSWARNINGSIGN);
    FWarningSignBitmap.Transparent := True;
  end;
  Result := FWarningSignBitmap;
end;

type
  TdxUpDown = class(TCustomUpDown)
  private
    FLockChange: Boolean;
    FMouseSensibility: TdxScrollMouseSensetivity;
    FPrevMousePos: TSmallPoint;
    procedure CancelScroll;    
    function MouseInSplitRegion(Pt: TSmallPoint): Boolean;
    procedure ScrollMessage(var Message: TWMScroll);
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
   {$IFNDEF DELPHI5}
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
   {$ENDIF}
    procedure WMVScroll(var Message: TWMVScroll); message CN_VSCROLL;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;

    property MouseSensibility: TdxScrollMouseSensetivity read FMouseSensibility write FMouseSensibility default msMedium;
    property PopupMenu;
    property OnClick;
  end;

constructor TdxUpDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Orientation := udVertical;
  Min := -1;
  Max := 1;
  Position := 0;
  MouseSensibility := msMedium;
end;

procedure TdxUpDown.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (GetCapture = Handle) and (Key = VK_ESCAPE) then 
    CancelScroll;
  inherited KeyDown(Key, Shift);
end;

procedure TdxUpDown.CancelScroll;
begin
  SetCursor(Screen.Cursors[crDefault]);
end;

function TdxUpDown.MouseInSplitRegion(Pt: TSmallPoint): Boolean;
const
  Delta = 2;
begin
  Result := (Pt.Y > (Height div 2) - Delta) and (Pt.Y < (Height div 2) + Delta);
end;

procedure TdxUpDown.ScrollMessage(var Message: TWMScroll);
const
  UDBtnType: array [Boolean] of TUDBtnType = (btNext, btPrev);
begin
  if not FLockChange then
  begin
    FLockChange := True;
    try
      case message.ScrollCode of
        SB_THUMBPOSITION: 
          Click(UDBtnType[Message.Pos < 0]);
        SB_LINEUP: 
          Click(btNext);
        SB_LINEDOWN:
          Click(btPrev);
      end;
      if HandleAllocated then SendMessage(Handle, UDM_SETPOS, 0, 0);
    finally
      FLockChange := False;
    end;
  end;
end;

procedure TdxUpDown.WMCaptureChanged(var Message: TMessage);
begin
  CancelScroll;  
end;

procedure TdxUpDown.WMHScroll(var message: TWMHScroll);
begin
  ScrollMessage(Message);
end;

procedure TdxUpDown.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if MouseInSplitRegion(Message.Pos) then
  begin
    FPrevMousePos := Message.Pos;
    SetCapture(Handle);
  end
  else
    inherited;
end;

procedure TdxUpDown.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  if GetCapture = Handle then ReleaseCapture;
end;

{$IFNDEF DELPHI5}
procedure TdxUpDown.WMRButtonUp(var Message: TWMMouse);
begin
  inherited;
  if not (csNoStdEvents in ControlStyle) then
    with Message do
      MouseUp(mbRight, KeysToShiftState(Keys), XPos, YPos);
end;
{$ENDIF}

procedure TdxUpDown.WMMouseMove(var Message: TWMMouseMove);
const
  Cursors: array[Boolean] of TCursor = (crDefault, crVSplit);
  UDBtnType: array [Boolean] of TUDBtnType = (btNext, btPrev);
var
  Pt: TSmallPoint;
begin
  Pt := Message.Pos;
  if GetCapture = Handle then
  begin
    if not FLockChange and (Abs(FPrevMousePos.Y - Pt.Y) >= ScrollMouseSensibility[MouseSensibility]) then
    begin
      Click(UDBtnType[Pt.Y > FPrevMousePos.Y]);
      SendMessage(Handle, UDM_SETPOS, 0, 0);
      FPrevMousePos := Pt;
    end;
  end
  else
  begin
    Cursor := Cursors[MouseInSplitRegion(Pt)];
    inherited;
  end;
end;

procedure TdxUpDown.WMVScroll(var message: TWMVScroll);
begin
  ScrollMessage(message);
end;

procedure DrawBorder(Control: TWinControl);
var
  DC: HDC;
  R: TRect;
  Pt: TPoint;
  MouseInControl: Boolean;
  DrawSunken: Boolean;
  FocusControl: TWinControl;
begin
  DC := GetWindowDC(Control.Handle);
  try
    GetWindowRect(Control.Handle, R);
    GetCursorPos(Pt);
    MouseInControl := PtInRect(R, Pt);
    OffsetRect(R, -R.Left, -R.Top);
    if Control.Enabled then
    begin
      if csDesigning in Control.ComponentState then
        DrawSunken := True
      else 
        if Control.Focused then
          DrawSunken := True
        else 
          if GetParentForm(Control).Active and MouseInControl then
          begin
            FocusControl := FindControl(GetFocus);
            if FocusControl <> nil then
              DrawSunken := not (FocusControl is Control.ClassType)
            else
              DrawSunken := True;
          end
          else
            DrawSunken := False;
            
      if DrawSunken then
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT)
      else
        FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
        
      InflateRect(R, -1, -1);
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
    end
    else
    begin
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
      InflateRect(R, -1, -1);
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNHIGHLIGHT));
    end;
  finally
    ReleaseDC(Control.Handle, DC);
  end;  
end;

{ TdxPSSpinEdit }

constructor TdxPSSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Text := '0';
  FDefaultValue := 0;
  FFlat := False;
  Height := 22;
  Width := 65;
  FIncrement := 1.0;
  FPageIncrement := 10.0;
  FCheckBounds := True;
  FDecimal := 2;
  FEditorEnabled := True;
  FUsePageIncr := False;
  FIncrButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FPageIncrButtonWidth := FIncrButtonWidth;
  FScrollMouseSens := msMedium;
  FArrowKeys := True;
  FLegendText := '';
  FLastGoodValue := 0.0;
  RecreateButton;
end;

procedure TdxPSSpinEdit.RecreateButton;
begin
  FreeAndNil(FUpDown);
  FreeAndNil(FPageUpDown);
  if FUsePageIncr then
  begin
    FPageUpDown := TdxUpDown.Create(Self);
    with TdxUpDown(FPageUpDown) do
    begin
      Visible := True;
      SetBounds(0, 0, FPageIncrButtonWidth, Self.Height);
      if BiDiMode = bdRightToLeft then
        Align := alLeft
      else
        Align := alRight;
      Parent := Self;
      MouseSensibility := Self.ScrollMouseSens;
      OnClick := PageUpDownClick;
      PopupMenu := Self.PopupMenu;
    end;
  end;
  
  FUpDown := TdxUpDown.Create(Self);
  with TdxUpDown(FUpDown) do
  begin
    Visible := True;
    SetBounds(0, 0, FIncrButtonWidth, Self.Height);
    if BiDiMode = bdRightToLeft then
      Align := alLeft
    else
      Align := alRight;
    Parent := Self;
    MouseSensibility := Self.ScrollMouseSens;
    OnClick := UpDownClick;
    PopupMenu := Self.PopupMenu;
  end;
end;

procedure TdxPSSpinEdit.UpDownClick(Sender: TObject; Button: TUDBtnType);
const
  Keys: array[TUDBtnType] of UINT = (VK_UP, VK_DOWN);
begin
  if TabStop and CanFocus then SetFocus;
  SpecialKeyClick(Keys[Button], [], Sender);
end;

procedure TdxPSSpinEdit.PageUpDownClick(Sender: TObject; Button: TUDBtnType);
const
  Keys: array[TUDBtnType] of UINT = (VK_PRIOR, VK_NEXT);
begin
  if TabStop and CanFocus then SetFocus;
  SpecialKeyClick(Keys[Button], [], Sender);
end;

function TdxPSSpinEdit.GetButtonWidth: Integer;
begin
  Result := 0;
  if FUpDown <> nil then Result := FUpDown.Width;
  if FPageUpDown <> nil then Result := Result + FPageUpDown.Width;
end;

procedure TdxPSSpinEdit.ResizeButtons;
begin
  if FUpDown <> nil then
  begin
    FUpDown.Width := FIncrButtonWidth;
    if BiDiMode = bdRightToLeft then
      FUpDown.Align := alLeft
    else
      FUpDown.Align := alRight;
  end;
  if FPageUpDown <> nil then
  begin
    FPageUpDown.Width := FPageIncrButtonWidth;
    if BiDiMode = bdRightToLeft then
      FPageUpDown.Align := alLeft
    else
      FPageUpDown.Align := alRight;
  end;
end;

procedure TdxPSSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  IsProcessKey: Boolean;
begin
  inherited KeyDown(Key, Shift);
  IsProcessKey := 
    Key in [VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN, VK_END, VK_HOME, VK_ESCAPE, VK_DELETE];
  if IsProcessKey then 
    case Key of
      VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN:
        if ArrowKeys then
        begin
          SpecialKeyClick(Key, Shift, Self);
          Key := 0;        
        end;
      VK_END:
        if ssCtrl in Shift then 
        begin 
          Value := MaxValue;
          Key := 0;
        end;  
      VK_HOME:
        if ssCtrl in Shift then 
        begin 
          Value := MinValue;
          Key := 0;
        end;  
      VK_DELETE:
        if not EditorEnabled then 
        begin
          MessageBeep(0);           
          Key := 0;           
        end;
      VK_ESCAPE:
        begin
        end;
    end;
end;

procedure TdxPSSpinEdit.Change;
begin
  if not FLockChange then inherited Change;
end;

procedure TdxPSSpinEdit.KeyPress(var Key: Char);
begin
  if not EditorEnabled or not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0);
  end;
  
  if Key <> #0 then
  begin
    inherited;
    if Key = Char(VK_RETURN) then
    begin
      if AutoSelect then SelectAll;
      Value := Value;
    end;
    if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then
    begin
      GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
      if Key = Char(VK_RETURN) then Key := #0;
    end;
  end;
end;

function TdxPSSpinEdit.IsValidChar(Key: Char): Boolean;
begin
  Result := dxCharInSet(Key, ['+', '-', '0'..'9']);
  Result := Result or (Key < #32) or (Pos(Key, LegendText) > 0);
  if not Result and (ValueType = svtFloat) then
    Result := Key = DecimalSeparator;

  if Result and not FEditorEnabled and 
   ((Key >= #32) or (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then 
    Result := False;
end;

procedure TdxPSSpinEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TAlignment] of DWORD =
    ((ES_LEFT, ES_RIGHT, ES_CENTER), (ES_RIGHT, ES_LEFT, ES_CENTER));
begin
  inherited;
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN or
    Alignments[UseRightToLeftAlignment, FAlignment];
end;

procedure TdxPSSpinEdit.CreateWnd;
begin
  inherited;
  SetEditRect;
end;

procedure TdxPSSpinEdit.SetEditRect;
var
  R: TRect;
begin
  if BiDiMode = bdRightToLeft then
    R := MakeRect(GetButtonWidth + 1, 0, ClientWidth - 1, ClientHeight + 1)
  else
    R := MakeRect(0, 0, ClientWidth - GetButtonWidth - 2, ClientHeight + 1);
  SendMessage(Handle, EM_SETRECTNP, 0, Longint(@R));
end;

procedure TdxPSSpinEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TdxPSSpinEdit.WMSize(var message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
  if Height < MinHeight then
    Height := MinHeight
  else
  begin
    ResizeButtons;
    SetEditRect;
  end;
end;

procedure TdxPSSpinEdit.GetTextHeight(var SysHeight, Height: Integer);
var
  DC: hDC;
  SaveFont: hFont;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  SysHeight := SysMetrics.tmHeight;
  Height := Metrics.tmHeight;
end;

function TdxPSSpinEdit.GetMinHeight: Integer;
var
  I, H: Integer;
begin
  GetTextHeight(I, H);
  if I > H then I := H;
  Result := H + GetSystemMetrics(SM_CYBORDER) * 4 + 1;
end;

procedure TdxPSSpinEdit.SpecialKeyClick(Key: Word; Shift: TShiftState; Sender: TObject);
var
  OldText: string;
begin
  if not ReadOnly then 
  begin
    FLockChange := True;
    try
      OldText := inherited Text;
      case Key of
        VK_PRIOR:
          begin
            Value := Value + FPageIncrement;
            DoButtonClick(btPage, btPrev);
          end;
        
        VK_NEXT:
          begin
            Value := Value - FPageIncrement;
            DoButtonClick(btPage, btNext);
          end;
        
        VK_UP:
          if ssCtrl in Shift then
          begin
            Value := Value + FPageIncrement;
            DoButtonClick(btPage, btNext);
          end
          else
          begin
            Value := Value + FIncrement;
            DoButtonClick(btLine, btNext);
          end;
        
        VK_DOWN:
          if ssCtrl in Shift then
          begin
            Value := Value - FPageIncrement;
            DoButtonClick(btPage, btPrev);
          end
          else
          begin
            Value := Value - FIncrement;
            DoButtonClick(btLine, btPrev);
          end;
      end;
    finally
      FLockChange := False;
    end;

    if CompareText(OldText, inherited Text) <> 0 then
    begin
      Modified := True;
      Change;
    end;
  end
  else
    MessageBeep(0);
end;

function TdxPSSpinEdit.GetValueText: string;
var
  P: Integer;
begin
  if LegendText <> '' then
  begin
    P := Pos(LegendText, Text);
    if P > 0 then
      Result := Copy(Text, 1, P - 1)
    else
      Result := Text;
  end
  else
    Result := Text;
end;

function TdxPSSpinEdit.GetValue: Extended;
var
  ValueText: string;
  Code: Integer;
begin
  ValueText := GetValueText;
  if ValueType = svtFloat then 
  begin
   {$IFDEF DELPHI6}
    Result := StrToFloatDef(ValueText, DefaultValue);
   {$ELSE}
    if not TextToFloat(PChar(ValueText), Result, fvExtended) then 
      Result := DefaultValue;
   {$ENDIF}
  end
  else
  begin
    Val(ValueText, Result, Code);
    if Code <> 0 then 
      Result := Trunc(DefaultValue);
  end;  
  
(*try
    if ValueType = svtFloat then
      Result := StrToFloat(GetValueText)
    else
      Result := StrToInt(GetValueText);
    { Because -> StrToFloat(',7') = 0,7 }
    Result := CheckValue(Result);
  except
    Result := DefaultValue;
    if ValueType = svtInteger then Result := Trunc(Result);
  end;*)
end;

procedure TdxPSSpinEdit.SetLegendText(const Value: string);
var
  V: Extended;
begin
  if FLegendText <> Value then
  begin
    V := Self.Value;
    FLegendText := Value;
    Self.Value := V;
  end;
end;

function TdxPSSpinEdit.GetLegendText: string;
begin
  if FLegendText = '' then
    Result := ''
  else 
    if FLegendText[1] = ' ' then
      Result := FLegendText
    else
      Result := ' ' + FLegendText;
end;

procedure TdxPSSpinEdit.SetValue(NewValue: Extended);
begin
  if ValueType = svtFloat then
    Text := FloatToStrF(CheckValue(NewValue), ffFixed, 15, FDecimal) + LegendText
  else
    Text := IntToStr(Round(CheckValue(NewValue))) + LegendText;
end;

function TdxPSSpinEdit.CheckValue(NewValue: Extended): Extended;
begin
  Result := NewValue;
  if CheckBounds then
//  if (FMinValue <> 0) or (FMaxValue <> FMinValue) then
    if NewValue < FMinValue then
      Result := FMinValue
    else 
      if NewValue > FMaxValue then
        Result := FMaxValue;
end;

procedure TdxPSSpinEdit.SetDefaultValue(NewDefaultValue: Extended);
begin
  if FDefaultValue <> NewDefaultValue then
    FDefaultValue := CheckValue(NewDefaultValue);
end;

function TdxPSSpinEdit.GetAsInteger: Longint;
begin
  Result := Trunc(GetValue);
end;

procedure TdxPSSpinEdit.SetAsInteger(NewValue: Longint);
begin
  SetValue(NewValue);
end;

procedure TdxPSSpinEdit.SetValueType(NewType: TdxSpinValueType);
begin
  if FValueType <> NewType then
  begin
    FValueType := NewType;
    Value := GetValue;
    if FValueType = svtInteger then
    begin
      FIncrement := Round(FIncrement);
      if FIncrement = 0 then FIncrement := 1;
      FPageIncrement := Round(FPageIncrement);
      if FPageIncrement = 0 then FPageIncrement := 1;
    end;
  end;
end;

procedure TdxPSSpinEdit.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TdxPSSpinEdit.SetUsePageIncr(Value: Boolean);
begin
  if FUsePageIncr <> Value then
  begin
    FUsePageIncr := Value;
    RecreateButton;
    ResizeButtons;
    SetEditRect;
  end;
end;

procedure TdxPSSpinEdit.SetIncrButtonWidth(Value: Integer);
begin
  if Value < MinButtonWidth then 
    Value := MinButtonWidth;
    
  if FIncrButtonWidth <> Value then
  begin
    FIncrButtonWidth := Value;
    ResizeButtons;
    SetEditRect;
  end;
end;

procedure TdxPSSpinEdit.SetPageIncrButtonWidth(Value: Integer);
begin
  if Value < MinButtonWidth then 
    Value := MinButtonWidth;
    
  if FPageIncrButtonWidth <> Value then
  begin
    FPageIncrButtonWidth := Value;
    ResizeButtons;
    SetEditRect;
  end;
end;

function TdxPSSpinEdit.IsIncrButtonWidthStored: Boolean;
begin
  Result := FUpDown.Width <> GetSystemMetrics(SM_CXVSCROLL);
end;

function TdxPSSpinEdit.IsPageIncrButtonWidthStored: Boolean;
begin
  Result := (FPageUpDown <> nil) and (FPageUpDown.Width <> GetSystemMetrics(SM_CXVSCROLL));
end;

function TdxPSSpinEdit.IsIncrementStored: Boolean;
begin
  Result := Increment <> 1.0;
end;

function TdxPSSpinEdit.IsPageIncrementStored: Boolean;
begin
  Result := PageIncrement <> 10.0;
end;

function TdxPSSpinEdit.IsMaxStored: Boolean;
begin
  Result := MaxValue <> 0.0;
end;

function TdxPSSpinEdit.IsMinStored: Boolean;
begin
  Result := MinValue <> 0.0;
end;

function TdxPSSpinEdit.IsValueStored: Boolean;
begin
  Result := GetValue <> 0.0;
end;

function TdxPSSpinEdit.IsDefaultValueStored: Boolean;
begin
  Result := FDefaultValue <> 0.0;
end;

procedure TdxPSSpinEdit.SetMaxValue(Value: Extended);
begin
  if FMaxValue <> Value then
  begin
    FMaxValue := Value;
    CheckValue(Self.Value);
  end;
end;

procedure TdxPSSpinEdit.SetMinValue(Value: Extended);
begin
  if FMinValue <> Value then
  begin
    FMinValue := Value;
    Self.Value := Self.Value;
  end;
end;

procedure TdxPSSpinEdit.SetCheckBounds(Value: Boolean);
begin
  if FCheckBounds <> Value then
  begin
    FCheckBounds := Value;
    Self.Value := Self.Value;
  end;
end;

procedure TdxPSSpinEdit.SetDecimal(NewValue: Byte);
begin
  if FDecimal <> NewValue then
  begin
    FDecimal := NewValue;
    Self.Value := Self.Value;
  end;
end;

procedure TdxPSSpinEdit.SetScrollMouseSens(Value: TdxScrollMouseSensetivity);
begin
  if FScrollMouseSens <> Value then
  begin
    FScrollMouseSens := Value;
    TdxUpDown(FUpDown).MouseSensibility := Value;

    if FPageUpDown <> nil then 
      TdxUpDown(FPageUpDown).MouseSensibility := Value;
  end;
end;

procedure TdxPSSpinEdit.DoButtonClick(ButtonType: TdxButtonType; Button: TUDBtnType);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self, ButtonType, Button);
end;

procedure TdxPSSpinEdit.WMContextMenu(var Message: TWMContextMenu);
begin
  if Message.hWnd = Handle then inherited;
end;

procedure TdxPSSpinEdit.WMCut(var Message: TWMCut);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TdxPSSpinEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if Flat then DrawBorder(Self);
end;

procedure TdxPSSpinEdit.WMMouseWheel(var Message: TWMMouseWheel);

  function GetControl: TCustomUpDown;
  begin
    if GetKeyState(VK_CONTROL) < 0 then
      Result := FPageUpDown
    else
      Result := FUpDown;
  end;
  
const
  ScrollCodes: array[Boolean] of SmallInt = (SB_LINEDOWN, SB_LINEUP);
var
  ScrollMsg: TWMScroll;
begin
  inherited;
  FillChar(ScrollMsg, SizeOf(TMessage), 0);
  ScrollMsg.Msg := WM_VSCROLL;
  ScrollMsg.ScrollCode := ScrollCodes[Message.WheelDelta > 0];
  if GetControl is TdxUpDown then
    TdxUpDown(GetControl).ScrollMessage(ScrollMsg);
end;

procedure TdxPSSpinEdit.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  //if Flat then InflateRect(message.CalcSize_Params.rgrc[0], -1, -1);
end;

procedure TdxPSSpinEdit.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  if Flat then DrawBorder(Self);
end;

procedure TdxPSSpinEdit.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

{$IFNDEF DELPHI5}
procedure TdxPSSpinEdit.WMRButtonUp(var Message: TWMRButtonUp);
var
  R: TRect;
  Pt: TPoint;
begin
  if (PopupMenu <> nil) and PopupMenu.AutoPopup then
  begin
    R := FUpDown.ClientRect;
    if FUsePageIncr then
      UnionRect(R, R, FPageUpDown.ClientRect);
    Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
    if PtInRect(R, Pt) then Exit;
  end;
  inherited;
end;
{$ENDIF}

procedure TdxPSSpinEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Flat then DrawBorder(Self);
end;

procedure TdxPSSpinEdit.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  ResizeButtons;
  SetEditRect;
  Invalidate;
end;

procedure TdxPSSpinEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if FUpDown <> nil then FUpDown.Enabled := Enabled;
  if FPageUpDown <> nil then FPageUpDown.Enabled := Enabled;
  if FFlat then DrawBorder(Self);
end;

procedure TdxPSSpinEdit.CMEnter(var Message: TCMEnter);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then 
    SelectAll;
  FSaveValue := Value;
  inherited;
end;

procedure TdxPSSpinEdit.CMExit(var Message: TCMExit);
begin
//  if ( CheckValue(Value) <> Value ) then SetValue(Value)
//  else
  Value := Value;
  inherited;
end;

procedure TdxPSSpinEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResizeButtons;
  SetEditRect;
end;

procedure TdxPSSpinEdit.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseInControl := True;
  if Flat then DrawBorder(Self);
end;

procedure TdxPSSpinEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseInControl := False;
  if Flat then DrawBorder(Self);
end;

{ TdxPSColorCombo  }

constructor TdxPSColorCombo.Create(AOwner: TComponent);
begin
  inherited;
  Style := csOwnerDrawFixed;
  FColorTypes := [ctPure, ctSystem];
  FShowColorName := True;
  FShowCustomColor := True;
  FAutoColor := clWindowText;
end;

function TdxPSColorCombo.DefaultAutoColorText: string;
begin
  Result := cxGetResourceString(@sdxAutoColorText);
end;

function TdxPSColorCombo.DefaultCustomColorText: string;
begin
  Result := cxGetResourceString(@sdxCustomColorText);
end;

procedure TdxPSColorCombo.Click;
begin
  if ShowCustomColor and (ItemIndex = Items.Count - 1) then SelectCustomColor;
  inherited;
end;

procedure TdxPSColorCombo.CreateWnd;
begin
  inherited;
  RefreshItems;
end;

procedure TdxPSColorCombo.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('IsAutoColorTextAssigned', ReadIsAutoColorTextAssigned, WriteIsAutoColorTextAssigned, 
    FIsAutoColorTextAssigned and (AutoColorText = ''));
  Filer.DefineProperty('IsCustomColorTextAssigned', ReadIsCustomColorTextAssigned, WriteIsCustomColorTextAssigned, 
    FIsCustomColorTextAssigned and (CustomColorText = ''));
end;

procedure TdxPSColorCombo.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  ColorWidth = 22;
  Format = DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
  EndEllipsis: array[Boolean] of UINT = (0, DT_END_ELLIPSIS);
var
  ColorRect, TxtRect: TRect;
  PrevColor: TColor;
  PrevMode: Integer;
  S: string;
begin
  Canvas.FillRect(Rect);
  InflateRect(Rect, -2, -2);
  ColorRect := Rect;
  TxtRect := Rect;
  if FShowColorName or ((ShowAutoColor and (Index = 0)) or
    (ShowCustomColor and (Index = Items.Count - 1))) then
  begin
    if BiDiMode = bdRightToLeft then
      ColorRect.Left := ColorRect.Right - ColorWidth
    else
      ColorRect.Right := ColorRect.Left + ColorWidth;

    SubtractRect(TxtRect, Rect, ColorRect);
    if BiDiMode = bdRightToLeft then
      Dec(TxtRect.Right, 6);
    Inc(TxtRect.Left, 6);
  end; // else if ( Index = Items.Count - 1 ) then
  //  SetRectEmpty(AColorRect);

  with Canvas do
  begin
    Pen.Color := clBtnShadow;
    PrevColor := Brush.Color;
    if ShowAutoColor and (Index = 0) then
    begin
      Brush.Color := AutoColor;
      Brush.Style := bsSolid;
    end
    else 
      if not ShowAutoColor or (TColor(Items.Objects[Index]) <> clNone) then
      begin
        Brush.Color := TColor(Items.Objects[Index]);
        Brush.Style := bsSolid;
      end
      else
        Brush.Style := bsClear;
        
    if not IsRectEmpty(ColorRect) then
      with ColorRect do
        Rectangle(Left, Top, Right, Bottom);
    Brush.Color := PrevColor;

    PrevMode := SetBkMode(Handle, TRANSPARENT);
    if not Enabled then
      PrevColor := SetTextColor(Handle, ColorToRGB(clInactiveCaptionText));
      
    if FShowColorName or ((ShowAutoColor and (Index = 0)) or
      (ShowCustomColor and (Index = Items.Count - 1))) then
    begin
      S := GetColorName(Index);
      DrawText(Canvas.Handle, PChar(S), Length(S), TxtRect, Format or EndEllipsis[Self.EndEllipsis]);
    end;

    {$IFNDEF CBUILDER} 
    if ShowAutoColor and ((Index = 0) or (Index = 1)) and not (odComboBoxEdit in State) then
    begin
      Pen.Color := clWindowText;
      with Rect do 
        if Index = 0 then
          Rectangle(Left, Bottom + 1, Right, Bottom + 2)
        else
          Rectangle(Left, Top - 2, Right, Top - 1);
    end;
    {$ENDIF}

    if not Enabled then
      SetTextColor(Handle, ColorToRGB(PrevColor));
    SetBkMode(Handle, PrevMode);
  end;
end;

procedure TdxPSColorCombo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not DroppedDown and ShowCustomColor and (Key = vk_RETURN) and
    (ItemIndex = Items.Count - 1) then 
    Click;
  inherited;
end;

procedure TdxPSColorCombo.SetDropDownCount(const Value: Integer);
begin
 {$IFDEF DELPHI6}
  inherited;
 {$ELSE}
  inherited DropDownCount := Value;
 {$ENDIF}
  FDropDownCountAssigned := True;
end;

procedure TdxPSColorCombo.RefreshItems;
begin
  with Items do
  begin
    BeginUpdate;
    try
      Clear;
      if ShowAutoColor then 
        AddObject(AutoColorText, TObject(AutoColor));

      if ctPure in FColorTypes then
      begin
        AddObject(cxGetResourceString(@sdxPureColorBlack),      TObject(PureColors[0]));
        AddObject(cxGetResourceString(@sdxPureColorOlive),      TObject(PureColors[1]));        
        AddObject(cxGetResourceString(@sdxPureColorTeal),       TObject(PureColors[2]));
        AddObject(cxGetResourceString(@sdxPureColorGreen),      TObject(PureColors[3]));
        AddObject(cxGetResourceString(@sdxPureColorMoneyGreen), TObject(PureColors[4]));
        AddObject(cxGetResourceString(@sdxPureColorLime),       TObject(PureColors[5]));
        AddObject(cxGetResourceString(@sdxPureColorNavy),       TObject(PureColors[6]));
        AddObject(cxGetResourceString(@sdxPureColorBlue),       TObject(PureColors[7]));
        AddObject(cxGetResourceString(@sdxPureColorAqua),       TObject(PureColors[8]));
        AddObject(cxGetResourceString(@sdxPureColorSkyBlue),    TObject(PureColors[9]));
        AddObject(cxGetResourceString(@sdxPureColorGray),       TObject(PureColors[10]));
        AddObject(cxGetResourceString(@sdxPureColorMedGray),    TObject(PureColors[11]));
        AddObject(cxGetResourceString(@sdxPureColorSilver),     TObject(PureColors[12]));
        AddObject(cxGetResourceString(@sdxPureColorMaroon),     TObject(PureColors[13]));
        AddObject(cxGetResourceString(@sdxPureColorPurple),     TObject(PureColors[14]));
        AddObject(cxGetResourceString(@sdxPureColorFuchsia),    TObject(PureColors[15]));
        AddObject(cxGetResourceString(@sdxPureColorRed),        TObject(PureColors[16]));
        AddObject(cxGetResourceString(@sdxPureColorCream),      TObject(PureColors[17]));
        AddObject(cxGetResourceString(@sdxPureColorYellow),     TObject(PureColors[18]));
        AddObject(cxGetResourceString(@sdxPureColorWhite),      TObject(PureColors[19]));
      end;
      
      if ctSystem in FColorTypes then
      begin
        AddObject(cxGetResourceString(@sdxSysColorScrollBar),           TObject(SysColors[0]));
        AddObject(cxGetResourceString(@sdxSysColorBackground),          TObject(SysColors[1]));
        AddObject(cxGetResourceString(@sdxSysColorActiveCaption),       TObject(SysColors[2]));
        AddObject(cxGetResourceString(@sdxSysColorInactiveCaption),     TObject(SysColors[3]));
        AddObject(cxGetResourceString(@sdxSysColorMenu),                TObject(SysColors[4]));
        AddObject(cxGetResourceString(@sdxSysColorWindow),              TObject(SysColors[5]));
        AddObject(cxGetResourceString(@sdxSysColorWindowFrame),         TObject(SysColors[6]));
        AddObject(cxGetResourceString(@sdxSysColorMenuText),            TObject(SysColors[7]));
        AddObject(cxGetResourceString(@sdxSysColorWindowText),          TObject(SysColors[8]));
        AddObject(cxGetResourceString(@sdxSysColorCaptionText),         TObject(SysColors[9]));
        AddObject(cxGetResourceString(@sdxSysColorActiveBorder),        TObject(SysColors[10]));
        AddObject(cxGetResourceString(@sdxSysColorInactiveBorder),      TObject(SysColors[11]));
        AddObject(cxGetResourceString(@sdxSysColorAppWorkSpace),        TObject(SysColors[12]));
        AddObject(cxGetResourceString(@sdxSysColorHighLight),           TObject(SysColors[13]));
        AddObject(cxGetResourceString(@sdxSysColorHighLighText),        TObject(SysColors[14]));
        AddObject(cxGetResourceString(@sdxSysColorBtnFace),             TObject(SysColors[15]));
        AddObject(cxGetResourceString(@sdxSysColorBtnShadow),           TObject(SysColors[16]));
        AddObject(cxGetResourceString(@sdxSysColorGrayText),            TObject(SysColors[17]));
        AddObject(cxGetResourceString(@sdxSysColorBtnText),             TObject(SysColors[18]));
        AddObject(cxGetResourceString(@sdxSysColorInactiveCaptionText), TObject(SysColors[19]));
        AddObject(cxGetResourceString(@sdxSysColorBtnHighligh),         TObject(SysColors[20]));
        AddObject(cxGetResourceString(@sdxSysColor3DDkShadow),          TObject(SysColors[21]));
        AddObject(cxGetResourceString(@sdxSysColor3DLight),             TObject(SysColors[22]));
        AddObject(cxGetResourceString(@sdxSysColorInfoText),            TObject(SysColors[23]));
        AddObject(cxGetResourceString(@sdxSysColorInfoBk),              TObject(SysColors[24]));
      end;  
        
      if ShowCustomColor then 
        AddObject(CustomColorText, TObject(clNone));

      if Items.Count <> 0 then
        ItemIndex := 0;
    finally
      EndUpdate;
    end;
  end;  
end;

function TdxPSColorCombo.SelectColorProc: TdxSelectColorProc;
begin
  Result := nil;
  if Assigned(FOnGetSelectColorProc) then
  begin
    FOnGetSelectColorProc(Self, Result);
    if @Result = nil then
      Result := StandardSelectColorProc
  end
  else
    Result := StandardSelectColorProc;
end;

function TdxPSColorCombo.GetColorName(Index: Integer): string;
var
  Kind: TdxColorKind;
begin
  Result := Items[Index];
  if Assigned(FOnGetColorName) then
  begin
    if ShowAutoColor and (Index = 0) then
      Kind := ckAuto
    else 
      if ShowCustomColor and (Index = Items.Count - 1) then
        Kind := ckCustom
      else
        Kind := ckNormal;
    FOnGetColorName(Self, Index, TColor(Items.Objects[Index]), Kind, Result);
  end;
end;

function TdxPSColorCombo.GetActualDropDownCount: Integer;
begin
  if UseAllColorValuesInDropDownList and not DropDownCountAssigned then
    Result := Items.Count
  else  
    Result := DropDownCount;
end;

function TdxPSColorCombo.GetAutoColorText: string;
begin
  if FIsAutoColorTextAssigned then
    Result := FAutoColorText
  else
    Result := DefaultAutoColorText;
end;

function TdxPSColorCombo.GetColorTypes: TdxColorTypes;
begin
  Result := FColorTypes;
end;

function TdxPSColorCombo.GetColorValue: TColor;
begin
  Result := TColor(Items.Objects[ItemIndex]);
end;

function TdxPSColorCombo.GetCustomColorText: string;
begin
  if FIsCustomColorTextAssigned then
    Result := FCustomColorText
  else
    Result := DefaultCustomColorText
end;

function TdxPSColorCombo.GetIsAutoColorSelected: Boolean;
begin
  Result := ShowAutoColor and (ItemIndex = 0);
end;

function TdxPSColorCombo.IsAutoColorTextStored: Boolean;
begin
  Result := FIsAutoColorTextAssigned and (AutoColorText <> DefaultAutoColorText);
end;

function TdxPSColorCombo.IsCustomColorTextStored: Boolean;
begin
  Result := FIsCustomColorTextAssigned and (CustomColorText <> DefaultCustomColorText);
end;

procedure TdxPSColorCombo.SetAutoColor(Value: TColor);
begin
  if FAutoColor <> Value then
  begin
    FAutoColor := Value;
    if ShowAutoColor and (ItemIndex = 0) then Invalidate;
  end;
end;

procedure TdxPSColorCombo.SetAutoColorText(const Value: string);
begin
  if AutoColorText <> Value then
  begin
    FAutoColorText := Value;
    FIsAutoColorTextAssigned := True;
    if ShowAutoColor then RecreateWnd;//and (ItemIndex = 0) then Invalidate;
  end;
end;

procedure TdxPSColorCombo.SetColorTypes(Value: TdxColorTypes);
begin
  if Value <> FColorTypes then
  begin
    if Value = [] then Value := [ctPure];
    FColorTypes := Value;
    RecreateWnd;
  end;
end;

procedure TdxPSColorCombo.SetColorValue(Value: TColor);
var
  Index: Integer;
begin
  Index := Items.IndexOfObject(TObject(Value));
  if Index > -1 then 
    ItemIndex := Index
  else 
    if ShowCustomColor then
    begin
      Items.Objects[Items.Count - 1] := TObject(Value);
      ItemIndex := Items.Count - 1;
      Repaint;
    end;
end;

procedure TdxPSColorCombo.SetCustomColorText(const Value: string);
begin
  if CustomColorText <> Value then
  begin
    FCustomColorText := Value;
    FIsCustomColorTextAssigned := True;
    if ShowCustomColor then RecreateWnd;//and (ItemIndex = 0) then Invalidate;
  end;
end;

procedure TdxPSColorCombo.SetEndEllipsis(Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    Invalidate;
  end;
end;

procedure TdxPSColorCombo.SetShowAutoColor(Value: Boolean);
begin
  if FShowAutoColor <> Value then
  begin
    FShowAutoColor := Value;
    RecreateWnd;
  end;
end;

procedure TdxPSColorCombo.SetShowColorName(Value: Boolean);
begin
  if Value <> FShowColorName then
  begin
    FShowColorName := Value;
    Repaint;
  end;
end;

procedure TdxPSColorCombo.SetShowCustomColor(Value: Boolean);
begin
  if FShowCustomColor <> Value then
  begin
    FShowCustomColor := Value;
    RecreateWnd;
  end;
end;

function TdxPSColorCombo.FindRGB(AColor: TColor): Integer;

  function IsSysColor(Color: TColor): Boolean;
  begin
    Result := (Color and $80000000 = $80000000);
  end;
  
var
  C: TColor;
begin
  if IsSysColor(AColor) then
    AColor := ColorToRGB(GetSysColor(AColor))
  else
    AColor := ColorToRGB(AColor);
    
  for Result := 0 to Items.Count - 1 do
  begin
    C := TColor(Items.Objects[Result]);
    if IsSysColor(C) then 
      C := GetSysColor(C);
    C := ColorToRGB(C);
    if AColor = C then Exit;
  end;
  Result := -1;
end;

procedure TdxPSColorCombo.ResetItemHeight;
var
  H: Integer;
begin
  H := -MulDiv(Font.Height, 15, 10);
  if H < 10 then H := 10;
  ItemHeight := H;
end;

procedure TdxPSColorCombo.SelectCustomColor;
var
  CustomColor: TColor;
  Proc: TdxSelectColorProc;
  Index: Integer;
begin
  CustomColor := TColor(Items.Objects[ItemIndex]);
  Proc := SelectColorProc();
  if Assigned(Proc) then
    if Proc(CustomColor) then
    begin
      Index := Items.IndexOfObject(TObject(CustomColor));
      if Index <> ItemIndex then
        if Index = -1 then 
        begin
          Items.Objects[ItemIndex] := TObject(CustomColor);
          Repaint;
        end
        else
          ItemIndex := Index;
    end
    else
      ColorValue := CustomColor;
end;

function TdxPSColorCombo.StandardSelectColorProc(var AColor: TColor): Boolean;
begin
  dxPSGlbl.ColorDialog.Color := AColor;
  Result := dxPSGlbl.ColorDialog.Execute;
  if Result then
    AColor := dxPSGlbl.ColorDialog.Color;
end;

procedure TdxPSColorCombo.ReadIsAutoColorTextAssigned(AReader: TReader);
begin
  FIsAutoColorTextAssigned := AReader.ReadBoolean;
end;

procedure TdxPSColorCombo.ReadIsCustomColorTextAssigned(AReader: TReader);
begin
  FIsCustomColorTextAssigned := AReader.ReadBoolean;
end;

procedure TdxPSColorCombo.WriteIsAutoColorTextAssigned(AWriter: TWriter); 
begin
  AWriter.WriteBoolean(FIsAutoColorTextAssigned);
end;

procedure TdxPSColorCombo.WriteIsCustomColorTextAssigned(AWriter: TWriter); 
begin
  AWriter.WriteBoolean(FIsCustomColorTextAssigned);
end;

procedure TdxPSColorCombo.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TdxPSColorCombo.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if csDesigning in ComponentState then Invalidate;
end;

procedure TdxPSColorCombo.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
end;

procedure TdxPSColorCombo.CMRecreateWnd(var Message: TMessage);
var
  ASaveValue: TColor;
  Ind: Integer;
begin
  ASaveValue := ColorValue;
  inherited;
  Ind := FindRGB(ASaveValue);
  if Ind > -1 then ItemIndex := Ind;
end;

procedure TdxPSColorCombo.CNCommand(var Message: TWMCommand);
begin
  case message.NotifyCode of
    CBN_SELCHANGE:
      begin
        Text := Items[ItemIndex];
        //if not DroppedDown then Click;
        Change;
        Exit;
      end;
    CBN_CLOSEUP:
      if FSelEndOk then Click;
    CBN_DROPDOWN: 
      begin
        DropDownCount := ActualDropDownCount;
        FSelEndOk := True;
      end;  
    CBN_SELENDCANCEL: 
      FSelEndOk := False;
  end;
  inherited;
end;

{ TdxPSBrushStyleCombo }

constructor TdxPSBrushStyleCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ItemHeight := 22;
  Height := 22;
  FEndEllipsis := False;
  FShowStyleName := False;
  FBrushColor := clWindowText;
  Style := csOwnerDrawFixed;
end;

procedure TdxPSBrushStyleCombo.CreateWnd;
begin
  inherited CreateWnd;
  RefreshItems;
  ItemIndex := 0;
end;

procedure TdxPSBrushStyleCombo.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
const
  EndEllipsisMap: array[Boolean] of UINT = (0, DT_END_ELLIPSIS);
  Format = DT_SINGLELINE or DT_LEFT or DT_VCENTER;
var
  BrushRect, TextRect: TRect;
  S: string;
begin
  Canvas.FillRect(Rect);
  InflateRect(Rect, -2, -2);
  BrushRect := Rect;
  TextRect := Rect;
  if FShowStyleName then
  begin
    if BiDiMode = bdRightToLeft then
      BrushRect.Left := BrushRect.Right - (Rect.Right - Rect.Left) div 2
    else
      BrushRect.Right := BrushRect.Left + (Rect.Right - Rect.Left) div 2;

    SubtractRect(TextRect, Rect, BrushRect);
    if BiDiMode = bdRightToLeft then
      Dec(TextRect.Right, 6);
    Inc(TextRect.Left, 6);
  end;

  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clBtnShadow;
  Canvas.FrameRect(BrushRect);
  InflateRect(BrushRect, -1, -1);

  if Index > StyleIndexes[bsClear] then
    Canvas.Brush.Style := Styles[Index]
  else
    Canvas.Brush.Style := bsSolid;
    
  if Index = StyleIndexes[bsClear] then
    Canvas.Brush.Color := clWindow
  else
    if ColorToRGB(BrushColor) = ColorToRGB(clWindow) then
      if Index > StyleIndexes[bsClear] then
        Canvas.Brush.Color := clWindowText
      else
        Canvas.Brush.Color := BrushColor
    else
      Canvas.Brush.Color := BrushColor;

  SetBkColor(Canvas.Handle, ColorToRGB(clWindow));
  Canvas.FillRect(BrushRect);
      
  if FShowStyleName then
  begin
    Canvas.Brush.Style := bsClear;      
    if not Enabled then
      Canvas.Font.Color := clGrayText;
    S := StyleNames[Index];
    DrawText(Canvas.Handle, PChar(S), Length(S), TextRect, Format or EndEllipsisMap[EndEllipsis]);
  end;
  Canvas.Brush.Style := bsSolid;
  Canvas.Font.Color := clWindowText;  
end;

function TdxPSBrushStyleCombo.GetStyleName(Index: Integer): string;
begin
  Result := Items[Index];
  if Assigned(FOnGetBrushStyleName) then
    FOnGetBrushStyleName(Self, Index, Styles[Index], Result);
end;

function TdxPSBrushStyleCombo.GetStyle(Index: Integer): TBrushStyle;
begin
  Result := TBrushStyle(Items.Objects[Index]);
end;

function TdxPSBrushStyleCombo.GetStyleIndex(Style: TBrushStyle): Integer;
begin
  Result := Items.IndexOfObject(TObject(Style));
end;

function TdxPSBrushStyleCombo.GetStyleValue: TBrushStyle;
begin
  if ItemIndex <> -1 then
    Result := Styles[ItemIndex]
  else
    Result := bsSolid;
end;

procedure TdxPSBrushStyleCombo.SetBrushColor(Value: TColor);
begin
  if FBrushColor <> Value then
  begin
    FBrushColor := Value;
    Invalidate;
  end;
end;

procedure TdxPSBrushStyleCombo.SetEndEllipsis(Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    Invalidate;
  end;
end;

procedure TdxPSBrushStyleCombo.SetShowStyleName(Value: Boolean);
begin
  if FShowStyleName <> Value then
  begin
    FShowStyleName := Value;
    Invalidate;
  end;
end;

procedure TdxPSBrushStyleCombo.SetStyleValue(Value: TBrushStyle);
begin
  ItemIndex := StyleIndexes[Value];
end;

procedure TdxPSBrushStyleCombo.RefreshItems;
begin
  with Items do 
  begin
    BeginUpdate;
    try
      Clear;
      AddObject(cxGetResourceString(@sdxBrushStyleSolid), TObject(bsSolid));
      AddObject(cxGetResourceString(@sdxBrushStyleClear), TObject(bsClear));
      AddObject(cxGetResourceString(@sdxBrushStyleHorizontal), TObject(bsHorizontal));
      AddObject(cxGetResourceString(@sdxBrushStyleVertical), TObject(bsVertical));
      AddObject(cxGetResourceString(@sdxBrushStyleFDiagonal), TObject(bsFDiagonal));
      AddObject(cxGetResourceString(@sdxBrushStyleBDiagonal), TObject(bsBDiagonal));
      AddObject(cxGetResourceString(@sdxBrushStyleCross), TObject(bsCross));
      AddObject(cxGetResourceString(@sdxBrushStyleDiagCross), TObject(bsDiagCross));
    finally
      EndUpdate;
    end;
  end;  
end;

procedure TdxPSBrushStyleCombo.ResetItemHeight;
var
  H: Integer;
begin
  H := -MulDiv(Font.Height, 12, 10);
  if H < 22 then H := 22;
  ItemHeight := H;
end;

procedure TdxPSBrushStyleCombo.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TdxPSBrushStyleCombo.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
end;

procedure TdxPSBrushStyleCombo.CMRecreateWnd(var Message: TMessage);
var
  SaveStyle: TBrushStyle;
begin
  SaveStyle := BrushStyle;
  inherited;
  BrushStyle := SaveStyle;
end;

procedure TdxPSBrushStyleCombo.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if csDesigning in ComponentState then Invalidate;
end;

{ TdxPSPaintPanel }

constructor TdxPSPaintPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEdgeBorders := [ebLeft, ebTop, ebRight, ebBottom];
  FEdgeInner := esRaised;
  FEdgeOuter := esSunken;
  FDoubleBuffered := True;
end;

procedure TdxPSPaintPanel.Paint;
begin
  DoPaint;
end;

procedure TdxPSPaintPanel.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self)
end;

procedure TdxPSPaintPanel.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self)
end;

procedure TdxPSPaintPanel.DoPaint;
begin
  if Assigned(FOnPaint) then FOnPaint(Self)
end;

function TdxPSPaintPanel.GetEdgeBorders: TdxEdgeBorders;
begin
  Result := FEdgeBorders;
end;

procedure TdxPSPaintPanel.SetEdgeBorders(Value: TdxEdgeBorders);
begin
  if FEdgeBorders <> Value then
  begin
    FEdgeBorders := Value;
    if (FEdgeOuter <> esNone) and (FEdgeInner <> esNone) then 
      RecreateWnd;
  end;
end;

procedure TdxPSPaintPanel.SetEdgeInner(Value: TdxEdgeStyle);
begin
  if FEdgeInner <> Value then
  begin
    FEdgeInner := Value;
    RecreateWnd;
  end;
end;

procedure TdxPSPaintPanel.SetEdgeOuter(Value: TdxEdgeStyle);
begin
  if FEdgeOuter <> Value then
  begin
    FEdgeOuter := Value;
    RecreateWnd;
  end;
end;

procedure TdxPSPaintPanel.WMNCCalcSize(var Message: TWMNCCalcSize);

  function GetEdgeSize: Integer;
  begin
    if Ctl3D then
      Result := Integer(EdgeInner > esNone) + Integer(EdgeOuter > esNone)
    else
      Result := 1;
  end;
  
  procedure AdjustEdges(var R: TRect; AEdgeSize: Integer);
  begin
    if ebLeft in FEdgeBorders then Inc(R.Left, AEdgeSize);
    if ebTop in FEdgeBorders then Inc(R.Top, AEdgeSize);
    if ebRight in FEdgeBorders then Dec(R.Right, AEdgeSize);
    if ebBottom in FEdgeBorders then Dec(R.Bottom, AEdgeSize);
  end;

begin
  AdjustEdges(Message.CalcSize_Params^.rgrc[0], GetEdgeSize);
  inherited;
end;

procedure TdxPSPaintPanel.WMNCPaint(var Message: TWMNCPaint);
const
  InnerStyles: array[TdxEdgeStyle] of Integer = (0, BDR_RAISEDINNER, BDR_SUNKENINNER);
  OuterStyles: array[TdxEdgeStyle] of Integer = (0, BDR_RAISEDOUTER, BDR_SUNKENOUTER);
  Ctl3DStyles: array[Boolean] of Integer = (BF_MONO, 0);
var
  R: TRect;
  DC: HDC;
  //Details: TThemedElementDetails;
begin
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  try
    //Details := ThemeServices.GetElementDetails(trBandNormal);
    //ThemeServices.DrawEdge(DC, Details, R, BDR_RAISEDINNER or BDR_RAISEDOUTER, BF_RECT or BF_FLAT);
    DrawEdge(DC, R, InnerStyles[FEdgeInner] or OuterStyles[FEdgeOuter],
      Byte(FEdgeBorders) or Ctl3DStyles[Ctl3D]);
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TdxPSPaintPanel.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if FEdgeBorders <> [] then RecreateWnd;
end;

procedure TdxPSPaintPanel.CMTextChanged(var Message: TMessage);
begin
end;

procedure TdxPSPaintPanel.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  DoMouseEnter;
end;

procedure TdxPSPaintPanel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  DoMouseLeave;
end;

{ TdxPSBitmapAnimator }

constructor TdxPSBitmapAnimator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAnimationSpeed := 10;
  FAnimationStepCount := 10;
  
  FBitmap := TBitmap.Create;
  FBitmap.Height := Height;
  FBitmap.Width := Width;
  
  FState := False;
end;

destructor TdxPSBitmapAnimator.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

procedure TdxPSBitmapAnimator.Paint;
begin
  if State and not Bitmap.Empty then 
    Canvas.Draw(0, 0, Bitmap)
end;

procedure TdxPSBitmapAnimator.Resize;
begin
  inherited;
  Bitmap.Height := Height;
  Bitmap.Width := Width;  
end;

procedure TdxPSBitmapAnimator.Animate;
var
  dY, V, I: Integer;
  T: DWORD;
  R: TRect;
begin
  dY := Height div AnimationStepCount + Ord((Height mod AnimationStepCount) <> 0);
  
  T := GetTickCount;  
  for I := 1 to AnimationStepCount do 
  begin
    while GetTickCount - T < DWORD(FAnimationSpeed) do ;
    T := GetTickCount;
    
    if State then 
    begin
      V := Height - I * dY;
      if V < 0 then V := 0;
      Canvas.Draw(0, V, Bitmap);
    end  
    else
    begin
      V := I * dY;
      if V >= Height then V := Height;
      R := MakeBounds(Left, Top + V - dY, Width, dY);
      InvalidateRect(Parent.Handle, @R, True);
      UpdateWindow(Parent.Handle);
      Canvas.Draw(0, V, Bitmap);
    end;  
  end;
  
  if Bitmap.Width < Width then
  begin
    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(MakeRect(Bitmap.Width, 0, Width, Height));
  end;  
end;

procedure TdxPSBitmapAnimator.StateChanged;
begin
  if not Bitmap.Empty then Animate;
end;

procedure TdxPSBitmapAnimator.SetBitmap(Value: TBitmap);
begin
  Bitmap.Assign(Value);
  Bitmap.Height := Height;
  Bitmap.Width := Width;  
end;

procedure TdxPSBitmapAnimator.SetState(Value: Boolean);
begin
  if FState <> Value then 
  begin
    FState := Value;
    StateChanged; 
  end;  
end;

{ TdxPSWarningPane }

constructor TdxPSWarningPane.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name := 'Tahoma';
  Font.Color := clInfoText;
end;

procedure TdxPSWarningPane.SetStateAndHint(NewState: Boolean; const AHint: string);
begin
  if State <> NewState then 
    if not State then 
    begin
      Hint := AHint;
      State := True;
    end
    else
      State := False
  else    
    Hint := AHint;
end;

procedure TdxPSWarningPane.InitializeBitmap;
var
  R: TRect;
  X, Y: Integer;
begin
  with Bitmap do
  begin
    R := MakeRect(0, 0, Width, Height);  
    // frame & Interior
    Canvas.Pen.Color := clBtnShadow;
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clInfoBk;
    Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    InflateRect(R, -1, -1);

    // warning sign
    with R do 
    begin
      X := Left + 2;
      Y := Top + (Bottom - Top - WarningSignBitmap.Height) div 2;
    end;  
    Canvas.Draw(X, Y, WarningSignBitmap);
    InflateRect(R, -1, -1);
    
    // text
    Inc(R.Left, 2 + WarningSignBitmap.Width + 4);
    Canvas.Brush.Style := bsClear;
    Canvas.Font := Font;
    InitializeBitmapHint(R);
  end;  
end;

procedure TdxPSWarningPane.InitializeBitmapHint(var R: TRect);
const 
  TextFormats: array[Boolean] of UINT = (DT_SINGLELINE or DT_VCENTER, DT_WORDBREAK);
var
  IsWordWrap: Boolean;
begin
  IsWordWrap := Bitmap.Canvas.TextWidth(Hint) > (R.Right - R.Left);
  DrawText(Bitmap.Canvas.Handle, PChar(Hint), Length(Hint), R, TextFormats[IsWordWrap]);
end;

procedure TdxPSWarningPane.StateChanged;
begin
  inherited;
  Beep;
end;

procedure TdxPSWarningPane.SetHint(const Value: string);
begin
  if FHint <> Value then 
  begin
    FHint := Value;
    InitializeBitmap;
    if State then Invalidate;
  end;
end;

{ TdxPSImageScrollBox }
                                 
constructor TdxPSImageScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  FBuiltInMenuItemsVisibility := [biiPreview..biiSave];
  Font.Style := Font.Style + [fsBold];
  HorzScrollBar.Tracking := True;
  VertScrollBar.Tracking := True;
  
  FBuiltInImages := TImageList.Create(Self);
  FBuiltInMenu := TPopupMenu.Create(Self);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FCenter := True;
  ParentFont := False;
  
  CreateBuiltInImages;
  CreateBuiltInMenu;
  
  dxPSPopupMan.dxPSPopupMenuController.RegisterControl(Self);
end;

destructor TdxPSImageScrollBox.Destroy;
begin
  dxPSPopupMan.dxPSPopupMenuController.UnregisterControl(Self);
  FreeAndNil(FPicture);
  FreeAndNil(FCanvas);
  inherited;
end;

procedure TdxPSImageScrollBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WindowClass.Style := Params.WindowClass.Style + (CS_HREDRAW or CS_VREDRAW);
end;

procedure TdxPSImageScrollBox.DblClick;
begin
  inherited;
  //if (biiPreview in FBuiltInMenuItemsVisibility) and HasGraphic then 
  //  dxPCPrVw.dxShowPicturePreview(Picture.Graphic);
end;

function TdxPSImageScrollBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; 
  MousePos: TPoint): Boolean;
type
  TScrollDirection = (sdLeft, sdTop, sdRight, sdBottom);

  function GetScrollDirection: TScrollDirection;
  const
    ScrollDirectionHorzMap: array[Boolean] of TScrollDirection = (sdRight, sdLeft);
    ScrollDirectionVertMap: array[Boolean] of TScrollDirection = (sdBottom, sdTop);
  begin
    if HasScrollVertBar then
      Result := ScrollDirectionVertMap[WheelDelta > 0]
    else
      if HasScrollHorzBar then
        Result := ScrollDirectionHorzMap[WheelDelta > 0]
      else
        Result := sdTop;      
  end;
  
const
  MsgMap: array[TScrollDirection] of Cardinal =  (WM_HSCROLL, WM_VSCROLL, WM_HSCROLL, WM_VSCROLL);
  ScrollCodeMap: array[TScrollDirection] of Smallint = (SB_LINELEFT, SB_LINEUP, SB_LINERIGHT, SB_LINEDOWN);
  ScrollBarMap: array[TScrollDirection] of Integer = (SB_HORZ, SB_VERT, SB_HORZ, SB_VERT);
var
  ScrollDirection: TScrollDirection;
  Message: TWMScroll;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if not Result and HasScrollBars then
  begin
    ScrollDirection := GetScrollDirection;
    FillChar(Message, SizeOf(TMessage), 0);
    with Message do 
    begin
      Msg := MsgMap[ScrollDirection];
      ScrollCode := ScrollCodeMap[ScrollDirection];
      Pos := GetScrollPos(Handle, ScrollBarMap[ScrollDirection]) + WheelDelta;
    end;  
    Dispatch(Message);
  end;  
end;

procedure TdxPSImageScrollBox.CreateBuiltInImages;

  procedure LoadImage(B: TBitmap; const AResName: string);
  begin
    Bitmap_LoadFromResourceName(B, AResName);
    BuiltInImages.AddMasked(B, B.Canvas.Pixels[0, B.Height - 1]);
  end;

var
  B: TBitmap;
begin
  BuiltInImages.AllocBy := 3;

  B := TBitmap.Create;
  try
    LoadImage(B, IDB_DXPSPREVIEW);
    LoadImage(B, IDB_DXPSCOPY);
    LoadImage(B, IDB_DXPSSAVE);
  finally
    B.Free;
  end;  
end;

procedure TdxPSImageScrollBox.CreateBuiltInMenu;

  function CreateMenuItem(const ACaption: string; AnImageIndex: Integer; AShortCut: TShortCut; 
    AnOnClick: TNotifyEvent): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    with Result do 
    begin
      Caption := ACaption;
      ImageIndex := AnImageIndex;
      ShortCut := AShortCut;
      
      OnClick := AnOnClick;
    end;     
    BuiltInMenu.Items.Add(Result);
  end;                              
  
begin
  miPreview := CreateMenuItem(dxPSUtl.AddEndEllipsis(cxGetResourceString(@sdxPreview)), 0, 0, PreviewClick);
  miLine1 := CreateMenuItem('-', -1, 0, nil);
  miCopy := CreateMenuItem(cxGetResourceString(@sdxCopy), 1, Menus.TextToShortCut('Ctrl+C'), CopyClick);
  miLine2 := CreateMenuItem('-', -1, 0, nil);
  miSave := CreateMenuItem(cxGetResourceString(@sdxSave), 2, Menus.TextToShortCut('Ctrl+S'), SaveClick);

  BuiltInMenu.Images := BuiltInImages;
  BuiltInMenu.OnPopup := BuiltInMenuPopup;

  PopupMenu := BuiltInMenu;
end;

procedure TdxPSImageScrollBox.DrawHint;  
const
  TextFormat: UINT = DT_CENTER or DT_VCENTER or DT_WORDBREAK;
var
  DC: HDC;
  F: HFONT;
  R: TRect;
begin
  DC := Canvas.Handle;

  FillRect(DC, ClientRect, GetSysColorBrush(COLOR_BTNFACE));

  F := SelectObject(DC, Font.Handle);
  
  R := HintTextRect;
  SetBkMode(DC, Windows.TRANSPARENT);
  DrawText(DC, PChar(HintText), Length(HintText), R, TextFormat);
  SetBkMode(DC, Windows.OPAQUE);

  SelectObject(DC, F);
end;

procedure TdxPSImageScrollBox.DrawPicture;
begin
  Canvas.Draw(PictureOriginX, PictureOriginY, Picture.Graphic);
end;

procedure TdxPSImageScrollBox.DrawPictureRestSpace;

  procedure DrawRestSpaceRect(const R: TRect);
  begin
   {$IFDEF DELPHI7}
     with Themes.ThemeServices do
       if ThemesEnabled then
         DrawParentBackground(Handle, Canvas.Handle, nil, False)
       else  
   {$ENDIF}
         Canvas.FillRect(R); 
  end;
  
begin
  Canvas.Brush.Color := Color;
  if HasPictureRestRectLeft then DrawRestSpaceRect(PictureRestRectLeft);
  if HasPictureRestRectTop then DrawRestSpaceRect(PictureRestRectTop);
  if HasPictureRestRectRight then DrawRestSpaceRect(PictureRestRectRight);
  if HasPictureRestRectBottom then DrawRestSpaceRect(PictureRestRectBottom);
end;

procedure TdxPSImageScrollBox.Paint;
begin
  FIsGraphicInvalid := False;
  try
    if HasGraphic then 
    begin
      DrawPictureRestSpace;
      DrawPicture;
    end  
    else
      DrawHint;  
  except
    FIsGraphicInvalid := True;
    DrawHint;
  end;
end;

function TdxPSImageScrollBox.GetCanvas: TCanvas;
begin
  Result := FCanvas;
end;

function TdxPSImageScrollBox.GetHasGraphic: Boolean;
begin
  Result := (Picture.Graphic <> nil) and not Picture.Graphic.Empty;
end;

function TdxPSImageScrollBox.GetHasPictureRestRectBottom: Boolean;
begin
  Result := RectVisible(Canvas.Handle, PictureRestRectBottom);
end;

function TdxPSImageScrollBox.GetHasPictureRestRectLeft: Boolean;
begin
  Result := RectVisible(Canvas.Handle, PictureRestRectLeft);
end;

function TdxPSImageScrollBox.GetHasPictureRestRectRight: Boolean;
begin
  Result := RectVisible(Canvas.Handle, PictureRestRectRight);
end;

function TdxPSImageScrollBox.GetHasPictureRestRectTop: Boolean;
begin
  Result := RectVisible(Canvas.Handle, PictureRestRectTop);
end;

function TdxPSImageScrollBox.GetHasScrollBars: Boolean;
begin
  Result := HasScrollHorzBar or HasScrollVertBar;
end;

function TdxPSImageScrollBox.GetHasScrollHorzBar: Boolean;
begin
  Result := HandleAllocated and (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0);
end;

function TdxPSImageScrollBox.GetHasScrollVertBar: Boolean;
begin
  Result := HandleAllocated and (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0);
end;

function TdxPSImageScrollBox.GetHintTextRect: TRect;
const
  TextFormat: UINT = DT_CALCRECT or DT_WORDBREAK;
var
  X, Y: Integer;
begin
  Result := ClientRect;
  DrawText(Canvas.Handle, PChar(HintText), Length(HintText), Result, TextFormat);

  X := (ClientWidth - (Result.Right - Result.Left)) div 2;
  Y := (ClientHeight - (Result.Bottom - Result.Top)) div 2;
  OffsetRect(Result, X, Y);
end;

function TdxPSImageScrollBox.GetIsPictureHeightExceedControlBounds: Boolean;
begin
  Result := Picture.Graphic.Height > ClientHeight;
end;

function TdxPSImageScrollBox.GetIsPictureWidthExceedControlBounds: Boolean;
begin
  Result := Picture.Graphic.Width > ClientWidth;
end;

function TdxPSImageScrollBox.GetPictureOriginX: Integer;
begin
  if IsPictureWidthExceedControlBounds then
    Result := -HorzScrollBar.Position
  else  
    if Center then 
      Result := (ClientWidth - Picture.Graphic.Width) div 2
    else
      Result := 0;  
end;

function TdxPSImageScrollBox.GetPictureOriginY: Integer;
begin
  if IsPictureHeightExceedControlBounds then
    Result := -VertScrollBar.Position
  else 
    if Center then 
      Result := (ClientHeight - Picture.Graphic.Height) div 2
    else
      Result := 0;  
end;

function TdxPSImageScrollBox.GetPictureHeight: Integer;
begin
  with PictureRect do 
    Result := Bottom - Top;
end;

function TdxPSImageScrollBox.GetPictureRect: TRect;
begin
  if HasGraphic then 
    Result := MakeBounds(PictureOriginX, PictureOriginY, Picture.Graphic.Width, Picture.Graphic.Height)
  else
    Result := NullRect;
end;

function TdxPSImageScrollBox.GetPictureWidth: Integer;
begin
  with PictureRect do 
    Result := Right - Left;
end;

function TdxPSImageScrollBox.GetPictureRestRectBottom: TRect;
begin
  with Result do
  begin
    Left := PictureRestRectLeft.Right;
    Top := PictureRect.Bottom;
    Right := Left + PictureWidth;
    Bottom := ClientHeight;
  end;
end;

function TdxPSImageScrollBox.GetPictureRestRectLeft: TRect;
begin
  Result := MakeBounds(0, 0, PictureOriginX, ClientHeight);
end;

function TdxPSImageScrollBox.GetPictureRestRectRight: TRect;
begin
  Result := MakeRect(PictureOriginX + Picture.Graphic.Width - 1, 0, ClientWidth, ClientHeight);
end;

function TdxPSImageScrollBox.GetPictureRestRectTop: TRect;
begin
  with Result do
  begin
    Left := PictureRestRectLeft.Right;
    Top := 0;
    Right := Left + PictureWidth;
    Bottom := PictureOriginY;
  end;
end;

procedure TdxPSImageScrollBox.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    if HasGraphic then Invalidate;
  end;
end;

procedure TdxPSImageScrollBox.SetHintText(const Value: string);
begin
  if FHintText <> Value then 
  begin
    FHintText := Value;
    if not HasGraphic then Invalidate;
  end;
end;

procedure TdxPSImageScrollBox.SetPicture(Value: TPicture);
begin
  Picture.Assign(Value);
end;

procedure TdxPSImageScrollBox.BuiltInMenuPopup(Sender: TObject);
begin
  miPreview.Visible := biiPreview in FBuiltInMenuItemsVisibility;
  miPreview.Enabled := HasGraphic;
  miLine1.Visible := miPreview.Visible;
  miCopy.Visible := biiCopy in FBuiltInMenuItemsVisibility;
  miCopy.Enabled := HasGraphic;
  miLine2.Visible := miCopy.Visible;
  miSave.Visible := biiSave in FBuiltInMenuItemsVisibility;
  miSave.Enabled := HasGraphic;
end;

procedure TdxPSImageScrollBox.CopyClick(Sender: TObject);
begin
  if HasGraphic then Clipboard.Assign(Picture.Graphic);
end;

procedure TdxPSImageScrollBox.SaveClick(Sender: TObject);
var
  GraphicClass: TGraphicClass;
begin
  if HasGraphic then 
  begin
    GraphicClass := TGraphicClass(Picture.Graphic.ClassType);
    with TSavePictureDialog.Create(nil) do 
    try
      DefaultExt := GraphicExtension(GraphicClass);
      Filter := GraphicFilter(GraphicClass);
      Options := Options + [ofOverwritePrompt];
      if Execute then 
        Picture.SaveToFile(FileName);
    finally
      Free;
    end;
  end;  
end;

procedure TdxPSImageScrollBox.PictureChanged(Sender: TObject);
begin
  HorzScrollBar.Range := Picture.Width;
  VertScrollBar.Range := Picture.Height;
  Invalidate;
end;

procedure TdxPSImageScrollBox.PreviewClick(Sender: TObject);
begin
  if HasGraphic then dxPCPrVw.dxShowPicturePreview(Picture.Graphic);
end;

procedure TdxPSImageScrollBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  message.Result := 1;
end;

procedure TdxPSImageScrollBox.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  if not (csDesigning in ComponentState) and CanFocus then
    SetFocus;
end;

procedure TdxPSImageScrollBox.WMNCPaint(var Message: TWMNCPaint);
begin
 inherited;
 {$IFDEF DELPHI7}
   with Themes.ThemeServices do 
     if ThemesEnabled then
       PaintBorder(Self, True);
 {$ENDIF} 
end;

procedure TdxPSImageScrollBox.WMPaint(var Message: TWMPaint);
var
  PaintStruct: TPaintStruct;
begin
  Canvas.Lock;
  try
    Canvas.Handle := BeginPaint(Handle, PaintStruct);
    try
      Paint;
    finally
      Canvas.Handle := 0;
      EndPaint(Handle, PaintStruct);
    end;  
  finally
    Canvas.Unlock;
  end;  
end;                      

initialization
  
finalization
  FreeAndNil(FWarningSignBitmap);
  
end.

