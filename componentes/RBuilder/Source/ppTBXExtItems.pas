{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{******************************************************************************
  TBX add-on package for Toolbar 2000
  Copyright © 2001–2005 Alex A. Denisov. All rights reserved.

  The contents of this file are subject to the "TBX License"; you may
  not use or distribute this file except in compliance with the
  "TBX Licensee". A copy of the "TBX License" may be found in
  TBX.chm or at

  http://www.g32.org/tbx/index.html

  The TBX source files may be downloaded from

  http://www.g32.org/files/tbx/tbx-2_1-beta1.zip
******************************************************************************}

unit ppTBXExtItems;

// TBX Package
// Copyright 2001-2004 Alex A. Denisov. All Rights Reserved
// See TBX.chm for license and installation instructions
//
// $Id: TBXExtItems.pas 16 2004-05-26 02:02:55Z Alex@ZEISS $

interface

{$I ppTB2Ver.inc}
{$I ppTBX.inc}

{$I ppIfDef.pas}

{$DEFINE COMPATIBLE}

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, StdCtrls, ExtCtrls,

  ppTB2Item,
  ppTB2Toolbar,
  ppTB2ExtItems,
  ppTB2MRU,

  ppTBX,
  ppTBXThemes,
  ppTBXLists,

  ppCharacter;

const
  tcrNumericProperty = 3;
  tcrSpinButton = 4;
  tcrList = 5;

type

  TppTBXEditItemViewer = class;
  TppTBXEditChange = procedure(Sender: TObject; const Text: string) of object;

  { TppTBXEditItem }
  { Extends standard TppTBEditItem, providing additional features and some
    combo box functionality, which is used in descendants }

  TppTBXEditItem = class(TppTBEditItem)
  private
    FAlignment: TAlignment;
    FAutoCompleteCounter: Integer;
    FEditorFontSettings: TFontSettings;
    FFontSettings: TFontSettings;
    FIsChanging: Boolean;
    FLastEditChange: string;
    FPasswordChar: Char;
    FReadOnly: Boolean;
    FShowImage: Boolean;
    FOnChange: TppTBXEditChange;
    procedure FontSettingsChanged(Sender: TObject);
    procedure SetAlignment(Value: TAlignment);
    procedure SetPasswordChar(Value: Char);
    procedure SetShowImage(const Value: Boolean);
    procedure SetFontSettings(Value: TFontSettings);
  protected
    function  DoAcceptText(var NewText: string): Boolean; override;
    function  DoAutoComplete(var AText: string): Boolean; virtual;
    procedure DoBeginEdit(Viewer: TppTBEditItemViewer); override;
    procedure DoChange(const AText: string); virtual;
    procedure DoTextChanged(Reason: Integer); override;
    function  GetImageIndex: Integer; virtual;
    function  GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;
    procedure GetPopupPosition(ParentView: TppTBView; PopupWindow: TppTBPopupWindow; var PopupPositionRec: TppTBPopupPositionRec); override;
    function  GetPopupWindowClass: TppTBPopupWindowClass; override;
    procedure HandleEditChange(Edit: TEdit); virtual;
  public
    function StartEditing(AView: TppTBView): Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property EditorFontSettings: TFontSettings read FEditorFontSettings write FEditorFontSettings;
    property ExtendedAccept;
    property FontSettings: TFontSettings read FFontSettings write SetFontSettings;
    property ImageIndex;
    property Images;
    property PasswordChar: Char read FPasswordChar write SetPasswordChar default #0;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property ShowImage: Boolean read FShowImage write SetShowImage default False;
    property OnChange: TppTBXEditChange read FOnChange write FOnChange;
    property OnSelect;
  end;

  TppTBXEditItemViewer = class(TppTBEditItemViewer)
  private
    procedure EditChangeHandler(Sender: TObject);
    function  MeasureEditCaption: TSize;
    function  MeasureTextHeight: Integer;
    procedure HandleEditChange(Edit: TEdit);
  protected
    OldWndProc: TWndMethod;
    procedure CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer); override;
    function  DoExecute: Boolean; override;
    function  HandleEditMessage(var Message: TMessage): Boolean; virtual;
    function  GetAccRole: Integer; override;
    procedure GetItemInfo(out ItemInfo: TppTBXItemInfo; IsHoverItem, IsPushed, UseMenuColor: Boolean); virtual;
    function  GetEditControlClass: TEditClass; override;
    procedure GetEditInfo(out EditInfo: TppTBXEditInfo; const ItemInfo: TppTBXItemInfo); virtual;
    function  GetIndentBefore: Integer; virtual;
    function  GetIndentAfter: Integer; virtual;
    procedure GetEditRect(var R: TRect); override;
    function  IsToolbarSize: Boolean; override;
    procedure NewEditWndProc(var Message: TMessage);
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect; IsHoverItem, IsPushed, UseDisabledShadow: Boolean); override;
    function  ShowImage: Boolean; virtual;
  public
    function  IsToolbarStyle: Boolean; override;
  end;

  { TppTBXSpinEditItem }
  TppTBXCustomSpinEditItem = class;

  TSEValueType = (evtInteger, evtFloat, evtHex);
  TDecimal = 0..10;
  TSEChangeEvent = procedure(Sender: TppTBXCustomSpinEditItem; const AValue: Extended) of object;
  TSEConvertEvent = procedure(Sender: TppTBXCustomSpinEditItem; const APrefix, APostfix: string; var AValue: Extended; var CanConvert: Boolean) of object;
  TSEStepEvent = procedure(Sender: TppTBXCustomSpinEditItem; Step: Integer; const OldValue: Extended; var NewValue: Extended) of object;
  TSETextToValueEvent = procedure(Sender: TppTBXCustomSpinEditItem; const AText: string; out AValue: Extended; var CanConvert: Boolean) of object;
  TSEValueToTextEvent = procedure(Sender: TppTBXCustomSpinEditItem; const AValue: Extended; var Text: string) of object;

  TppTBXCustomSpinEditItem = class(TppTBXEditItem)
  private
    FDecimal: TDecimal;
    FLastGoodValue: Extended;
    FMaxValue: Extended;
    FMinValue: Extended;
    FIncrement: Extended;
    FSpaceBeforePostfix: Boolean;
    FSpaceAfterPrefix: Boolean;
    FPostfix: string;
    FPrefix: string;
    FSnap: Boolean;
    FValueType: TSEValueType;
    FOnConvert: TSEConvertEvent;
    FOnTextToValue: TSETextToValueEvent;
    FOnValueChange: TSEChangeEvent;
    FOnValueToText: TSEValueToTextEvent;
    FOnStep: TSEStepEvent;
    function  IsIncrementStored: Boolean;
    function  IsMinValueStored: Boolean;
    function  IsMaxValueStored: Boolean;
    function  IsValueStored: Boolean;
    function  GetValue: Extended;
    procedure SetValue(NewValue: Extended);
    procedure SetValueType(NewType: TSEValueType);
    procedure SetDecimal(NewDecimal: TDecimal);
    procedure SetIncrement(const NewIncrement: Extended);
    procedure SetPostfix(const NewPostfix: string);
    procedure SetPrefix(const NewPrefix: string);
    procedure SetSpaceAfterPrefix(UseSpace: Boolean);
    procedure SetSpaceBeforePostfix(UseSpace: Boolean);
    function  ValidateUnits(const S: string): Boolean;
    function  GetAsInteger: Integer;
    procedure SetAsInteger(AValue: Integer);
  protected
    function  CheckValue(const V: Extended): Extended;
    procedure ClickUp;
    procedure ClickDown;
    function  DoAcceptText(var NewText: string): Boolean; override;
    function  DoConvert(const APrefix, APostfix: string; var AValue: Extended): Boolean; virtual;
    procedure DoStep(Step: Integer; const OldValue: Extended; var NewValue: Extended); virtual;
    procedure DoTextChanged(Reason: Integer); override;
    function  DoTextToValue(const AText: string; out AValue: Extended): Boolean; virtual;
    procedure DoValueChange(const V: Extended); virtual;
    procedure DoValueToText(const NewValue: Extended; var NewText: string); virtual;
    function  GetAsText(AValue: Extended): string;
    function  GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;
    function  ParseValue(const S: string; out V: Extended): Boolean;
    procedure SetValueEx(NewValue: Extended; Reason: Integer);
    property Alignment default taRightJustify;
    property OnConvert: TSEConvertEvent read FOnConvert write FOnConvert;
    property OnStep: TSEStepEvent read FOnStep write FOnStep;
    property OnTextToValue: TSETextToValueEvent read FOnTextToValue write FOnTextToValue;
    property OnValueChange: TSEChangeEvent read FOnValueChange write FOnValueChange;
    property OnValueToText: TSEValueToTextEvent read FOnValueToText write FOnValueToText;
  public
    constructor Create(AOwner: TComponent); override;
    property ValueType: TSEValueType read FValueType write SetValueType default evtInteger;
    property AsInteger: Integer read GetAsInteger write SetAsInteger stored False;
    property Decimal: TDecimal read FDecimal write SetDecimal default 2;
    property Increment: Extended read FIncrement write SetIncrement stored IsIncrementStored;
    property MaxValue: Extended read FMaxValue write FMaxValue stored IsMaxValueStored;
    property MinValue: Extended read FMinValue write FMinValue stored IsMinValueStored;
    property Postfix: string read FPostfix write SetPostfix;
    property Prefix: string read FPrefix write SetPrefix;
    property Snap: Boolean read FSnap write FSnap default True;
    property SpaceAfterPrefix: Boolean read FSpaceAfterPrefix write SetSpaceAfterPrefix;
    property SpaceBeforePostfix: Boolean read FSpaceBeforePostfix write SetSpaceBeforePostfix;
    property Value: Extended read GetValue write SetValue stored IsValueStored;
  published
    property Text stored False;
  end;

  TppTBXSpinEditItem = class(TppTBXCustomSpinEditItem)
  published
    property ValueType;
    property Alignment;
    property Decimal;
    property Increment;
    property MaxValue;
    property MinValue;
    property Postfix;
    property Prefix;
    property Snap;
    property SpaceAfterPrefix;
    property SpaceBeforePostfix;
    property Value;
    property OnConvert;
    property OnStep;
    property OnTextToValue;
    property OnValueChange;
    property OnValueToText;
  end;

  TSEBtnState = (ebsNone, ebsUp, ebsDown);

  TppTBXSpinEditViewer = class(TppTBXEditItemViewer)
  private
    FBtnState: TSEBtnState;
    FBtnTimer: TTimer;
    procedure TimerHandler(Sender: TObject);
  protected
    function  GetIndentAfter: Integer; override;
    procedure GetEditInfo(out EditInfo: TppTBXEditInfo; const ItemInfo: TppTBXItemInfo); override;
    function  HandleEditMessage(var Message: TMessage): Boolean; override;
    procedure InvalidateButtons;
    function  IsPtInButtonPart(X, Y: Integer): Boolean; override;
    procedure LosingCapture; override;
    procedure MouseDown(Shift: TShiftState; X, Y: Integer; var MouseDownOnMenu: Boolean); override;
    procedure MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean); override;
  public
    destructor Destroy; override;
  end;

  { TppTBXCustomDropDownItem }
  { An extended edit item tb2k with a button. The dropdown list support is
    implemented in descendants, such as TppTBXComboBoxItem }

  TppTBXCustomDropDownItem = class(TppTBXEditItem)
  private
    FAlwaysSelectFirst: Boolean;
    FDropDownList: Boolean;
  protected
    function CreatePopup(const ParentView: TppTBView; const ParentViewer: TppTBItemViewer;
      const PositionAsSubmenu, SelectFirstItem, Customizing: Boolean;
      const APopupPoint: TPoint; const Alignment: TppTBPopupAlignment): TppTBPopupWindow; override;
    function GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    property AlwaysSelectFirst: Boolean read FAlwaysSelectFirst write FAlwaysSelectFirst default True;
    property DropDownList: Boolean read FDropDownList write FDropDownList default False;
  end;

  TppTBXDropDownItem = class(TppTBXCustomDropDownItem)
  published
    property AlwaysSelectFirst;
    property DropDownList;
    property LinkSubitems;
    property SubMenuImages;
  end;

  TppTBXDropDownItemViewer = class(TppTBXEditItemViewer)
  protected
    procedure GetCursor(const Pt: TPoint; var ACursor: HCURSOR); override;
    procedure GetEditInfo(out EditInfo: TppTBXEditInfo; const ItemInfo: TppTBXItemInfo); override;
    function  GetIndentAfter: Integer; override;
    function  HandleEditMessage(var Message: TMessage): Boolean; override;
    function  IsPtInButtonPart(X, Y: Integer): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

{$IFDEF COMPATIBLE}
  { For compatibility with previous versions }
  TppTBXComboItem = class(TppTBXDropDownItem);
{$ENDIF}

  { TppTBXComboBoxItem }
  { A combination of dropdown combo with a stringlist subitem }
  TppTBXComboBoxItem = class;
  TppTBXCAdjustImageIndex = procedure(Sender: TppTBXComboBoxItem; const AText: string;
    AIndex: Integer; var ImageIndex: Integer) of object;

  TppTBXComboBoxItem = class(TppTBXCustomDropDownItem)
  private
    FAutoComplete: Boolean;
    FList: TppTBXStringList;
    FOnItemClick: TNotifyEvent;
    FOnAdjustImageIndex: TppTBXCAdjustImageIndex;
    procedure AdjustImageIndexHandler(Sender: TppTBXCustomList; AItemIndex: Integer; var ImageIndex: Integer);
    function GetItemIndex: Integer;
    function GetMaxVisibleItems: Integer;
    function GetMaxWidth: Integer;
    function GetMinWidth: Integer;
    function GetStrings: TStrings;
    function GetShowListImages: Boolean;
    function GetOnClearItem: TppTBXLPaintEvent;
    function GetOnDrawItem: TppTBXLPaintEvent;
    function GetOnMeasureHeight: TppTBXLMeasureHeight;
    function GetOnMeasureWidth: TppTBXLMeasureWidth;
    procedure ListChangeHandler(Sender: TObject);
    procedure ListClickHandler(Sender: TObject);
    procedure SetItemIndex(Value: Integer);
    procedure SetMaxVisibleItems(Value: Integer);
    procedure SetMaxWidth(Value: Integer);
    procedure SetMinWidth(Value: Integer);
    procedure SetOnClearItem(Value: TppTBXLPaintEvent);
    procedure SetOnDrawItem(Value: TppTBXLPaintEvent);
    procedure SetOnMeasureHeight(Value: TppTBXLMeasureHeight);
    procedure SetOnMeasureWidth(Value: TppTBXLMeasureWidth);
    procedure SetStrings(Value: TStrings);
    procedure SetShowListImages(Value: Boolean);
  protected
    CachedImageIndex: Integer;
    CacheValid: Boolean;
    IsChanging: Boolean;
    procedure AdjustImageIndex(const AText: string; AIndex: Integer; var ImageIndex: Integer); virtual;
    function  DoAutoComplete(var AText: string): Boolean; override;
    procedure DoListChange; virtual;
    procedure DoListClick; virtual;
    procedure DoPopup(Sender: TppTBCustomItem; FromLink: Boolean); override;
    function  GetImageIndex: Integer; override;
    function  GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;
    function  GetStringListClass: TppTBXStringListClass; virtual;
    procedure HandleEditChange(Edit: TEdit); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex default -1;
  published
    property AutoComplete: Boolean read FAutoComplete write FAutoComplete default True;
    property DropDownList;
    property MaxListWidth: Integer read GetMaxWidth write SetMaxWidth default 0;
    property MaxVisibleItems: Integer read GetMaxVisibleItems write SetMaxVisibleItems default 8;
    property MinListWidth: Integer read GetMinWidth write SetMinWidth default 64;
    property ShowListImages: Boolean read GetShowListImages write SetShowListImages default False;
    property Strings: TStrings read GetStrings write SetStrings;
    property SubMenuImages;
    property OnChange;
    property OnAdjustImageIndex: TppTBXCAdjustImageIndex read FOnAdjustImageIndex write FOnAdjustImageIndex;
    property OnClearItem: TppTBXLPaintEvent read GetOnClearItem write SetOnClearItem;
    property OnDrawItem: TppTBXLPaintEvent read GetOnDrawItem write SetOnDrawItem;
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;
    property OnMeasureHeight: TppTBXLMeasureHeight read GetOnMeasureHeight write SetOnMeasureHeight;
    property OnMeasureWidth: TppTBXLMeasureWidth read GetOnMeasureWidth write SetOnMeasureWidth;
    property OnPopup;
  end;

{$IFDEF COMPATIBLE}
  { For compatibility with previous versions }
  TppTBXComboList = class(TppTBXComboBoxItem);
{$ENDIF}

  TppTBXComboBoxItemViewer = class(TppTBXDropDownItemViewer)
  protected
    function HandleEditMessage(var Message: TMessage): Boolean; override;
  end;

  { TppTBXLabelItem }

  TppTBXLabelOrientation = (tbxoAuto, tbxoHorizontal, tbxoVertical);
  TNonNegativeInt = 0..MaxInt;

  TppTBXLabelItem = class(TppTBCustomItem)
  private
    FCaption: TCaption;
    FFontSettings: TFontSettings;
    FMargin: Integer;
    FShowAccelChar: Boolean;
    FOrientation: TppTBXLabelOrientation;
    FOnAdjustFont: TAdjustFontEvent;
    procedure FontSettingsChanged(Sender: TObject);
    procedure SetMargin(Value: Integer);
    procedure SetOrientation(Value: TppTBXLabelOrientation);
    procedure SetCaption(const Value: TCaption);
    procedure SetFontSettings(Value: TFontSettings);
    procedure SetShowAccelChar(Value: Boolean);
  protected
    function GetItemViewerClass (AView: TppTBView): TppTBItemViewerClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateCaption(const Value: TCaption);
  published
    property Caption: TCaption read FCaption write SetCaption;
    property Enabled;
    property FontSettings: TFontSettings read FFontSettings write SetFontSettings;
    property Margin: Integer read FMargin write SetMargin default 0;
    property Orientation: TppTBXLabelOrientation read FOrientation write SetOrientation default tbxoAuto;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property Visible;
    property OnAdjustFont: TAdjustFontEvent read FOnAdjustFont write FOnAdjustFont;
  end;

  TppTBXLabelItemViewer = class(TppTBItemViewer)
  protected
    function  GetCaptionText: string; override;
    function  GetIsHoriz: Boolean; virtual;
    procedure DoAdjustFont(AFont: TFont; StateFlags: Integer); virtual;
    procedure CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer); override;
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect;
      IsHoverItem, IsPushed, UseDisabledShadow: Boolean); override;
    function  IsToolbarSize: Boolean; override;
  public
    function  IsToolbarStyle: Boolean; override;
  end;

  { TppTBXColorItem }

  TppTBXColorItem = class(TppTBXCustomItem)
  private
    FColor: TColor;
    procedure SetColor(Value: TColor);
  protected
    function GetItemViewerClass (AView: TppTBView): TppTBItemViewerClass; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property AutoCheck;
    property Caption;
    property Checked;
    property Color: TColor read FColor write SetColor default clWhite;
    property DisplayMode;
    property Enabled;
    property FontSettings;
    property GroupIndex;
    property HelpContext;
    property Hint;
    property InheritOptions;
    property MaskOptions;
    property MinHeight;
    property MinWidth;
    property Options;
    property ShortCut;
    property Visible;
    property OnAdjustFont;
    property OnClick;
  end;

  TppTBXColorItemViewer = class(TppTBXItemViewer)
  protected
    procedure DoPaintCaption(Canvas: TCanvas; const ClientAreaRect: TRect;
      var CaptionRect: TRect; IsTextRotated: Boolean; var PaintDefault: Boolean); override;
    function GetImageShown: Boolean; override;
    function GetImageSize: TSize; override;
    procedure DrawItemImage(Canvas: TCanvas; ARect: TRect; ItemInfo: TppTBXItemInfo); override;
  public
    constructor Create(AView: TppTBView; AItem: TppTBCustomItem; AGroupLevel: Integer); override;
  end;

  { TppTBXMRUList }

  TppTBXMRUList = class(TppTBMRUList)
  private
    FKeyShift: Integer;
    procedure SetKeyShift(Value: Integer);
  protected
    function GetFirstKey: Integer; override;
    function GetItemClass: TppTBCustomItemClass; override;
    procedure SetItemCaptions; override;
  published
    property KeyShift: Integer read FKeyShift write SetKeyShift default 0;
  end;

  { TppTBXMRUListItem }

  TppTBXMRUListItem = class(TppTBXCustomItem)
  private
    FMRUList: TppTBMRUList;
    procedure SetMRUList(Value: TppTBMRUList);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property MRUList: TppTBMRUList read FMRUList write SetMRUList;
  end;

implementation

uses
  ppTB2Common,
  ppTB2Consts, TypInfo, Math, ImgList {$IFNDEF JR_D5}, DsgnIntf{$ENDIF};

const
  { Repeat intervals for spin edit items }
  SE_FIRSTINTERVAL = 400;
  SE_INTERVAL = 100;

type
  TppTBViewAccess = class(TppTBView);
  TppTBItemAccess = class(TppTBCustomItem);
  TppTBMRUListAccess = class(TppTBMRUList);
  TCustomEditAccess = class(TCustomEdit);
  TFontSettingsAccess = class(TFontSettings);

{ Misc. functions }

function StartsText(const ASubText, AText: string): Boolean;
var
  P: PChar;
  L, L2: Integer;
begin
  P := PChar(AText);
  L := Length(ASubText);
  L2 := Length(AText);
  if L > L2 then Result := False
  else Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
    P, L, PChar(ASubText), L) = 2;
end;

//============================================================================//

{ TppTBXEdit }

type
  TppTBXEdit = class(TEdit)
  private
    FAlignment: TAlignment;
    procedure SetAlignment(Value: TAlignment);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    property Alignment: TAlignment read FAlignment write SetAlignment;
  end;

procedure TppTBXEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Cardinal = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alignments[FAlignment];
end;

procedure TppTBXEdit.SetAlignment(Value: TAlignment);
begin
  if Value <> FAlignment then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;


//============================================================================//

{ TppTBXEditItem }

constructor TppTBXEditItem.Create(AOwner: TComponent);
begin
  inherited;
  FEditorFontSettings := TFontSettings.Create;
  FFontSettings := TFontSettings.Create;
  TFontSettingsAccess(FEditorFontSettings).OnChange := FontSettingsChanged;
  TFontSettingsAccess(FFontSettings).OnChange := FontSettingsChanged;
end;

destructor TppTBXEditItem.Destroy;
begin
  FFontSettings.Free;
  FEditorFontSettings.Free;
  inherited;
end;

function TppTBXEditItem.DoAcceptText(var NewText: string): Boolean;
begin
  Result := inherited DoAcceptText(NewText);
//  if not Result then DoChange(Text);
end;

function TppTBXEditItem.DoAutoComplete(var AText: string): Boolean;
begin
  Result := False;
end;

procedure TppTBXEditItem.DoBeginEdit(Viewer: TppTBEditItemViewer);
begin
  with Viewer do
  begin
    TppTBXEdit(EditControl).Alignment := Alignment;
    EditControl.PasswordChar := PasswordChar;
    EditControl.SelectAll;
    EditControl.ReadOnly := ReadOnly;
    EditorFontSettings.Apply(EditControl.Font);
    FAutoCompleteCounter := 0;
    inherited;
    if Viewer is TppTBXEditItemViewer then
    begin
      EditControl.OnChange := TppTBXEditItemViewer(Viewer).EditChangeHandler;
      TppTBXEditItemViewer(Viewer).OldWndProc := EditControl.WindowProc;
      EditControl.WindowProc := TppTBXEditItemViewer(Viewer).NewEditWndProc;
    end;
  end;
end;

procedure TppTBXEditItem.DoChange(const AText: string);
begin
  if Assigned(FOnChange) then FOnChange(Self, AText);
end;

procedure TppTBXEditItem.DoTextChanged(Reason: Integer);
begin
  if not ((Reason = tcrEditControl) and (Text = FLastEditChange)) then
    DoChange(Text);
end;

procedure TppTBXEditItem.FontSettingsChanged(Sender: TObject);
begin
  Change(True);
end;

function TppTBXEditItem.GetImageIndex: Integer;
begin
  Result := ImageIndex;
end;

function TppTBXEditItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  if not (tboUseEditWhenVertical in EditOptions) and
     (AView.Orientation = tbvoVertical) then
    Result := TppTBXItemViewer
  else
    Result := TppTBXEditItemViewer;
end;

procedure TppTBXEditItem.GetPopupPosition(ParentView: TppTBView;
  PopupWindow: TppTBPopupWindow; var PopupPositionRec: TppTBPopupPositionRec);
var
  VT: Integer;
begin
  inherited;
  VT := GetWinViewType(PopupWindow);
  PopupPositionRec.PlaySound := not (VT and PVT_LISTBOX = PVT_LISTBOX);
end;

function TppTBXEditItem.GetPopupWindowClass: TppTBPopupWindowClass;
begin
  Result := TppTBXPopupWindow;
end;

procedure TppTBXEditItem.HandleEditChange(Edit: TEdit);
var
  S, S2: string;
begin
  if not FIsChanging then
  begin
    FIsChanging := True;
    try
      S := Edit.Text;
      S2 := S;
      if (Length(S) > 0) and (FAutoCompleteCounter > 0) and DoAutoComplete(S2) then
      begin
        Edit.Text := S2;
        Edit.SelStart := Length(S);
        Edit.SelLength := Length(S2) - Length(S);
        S := S2;
      end;
      if S <> FLastEditChange then
      begin
        DoChange(S); // note, Edit.Text may be different from Self.Text
        FLastEditChange := S;
      end;
    finally
      FIsChanging := False;
    end;
  end;
end;

procedure TppTBXEditItem.SetAlignment(Value: TAlignment);
begin
  if Value <> FAlignment then
  begin
    FAlignment := Value;
    Change(True);
  end;
end;

procedure TppTBXEditItem.SetFontSettings(Value: TFontSettings);
begin
  FFontSettings.Assign(Value);
end;

procedure TppTBXEditItem.SetPasswordChar(Value: Char);
begin
  if Value <> FPasswordChar then
  begin
    FPasswordChar := Value;
    Change(True);
  end;
end;

procedure TppTBXEditItem.SetShowImage(const Value: Boolean);
begin
  FShowImage := Value;
  Change(True);
end;

function TppTBXEditItem.StartEditing(AView: TppTBView): Boolean;
var
  V: TppTBItemViewer;
  SaveText: string;
begin
  Result := False;
  V := AView.Find(Self);
  if V is TppTBXEditItemViewer then
  begin
    SaveText := Text;
    TppTBXEditItemViewer(V).DoExecute;
    Result := Text <> SaveText;
  end;
end;


//============================================================================//

{ TppTBXEditItemViewer }

procedure TppTBXEditItemViewer.CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer);
var
  W, B: Integer;
  EditBoxHeight: Integer;
  EditCaptionSize: TSize;
begin
  if Self.Item is TppTBXEditItem then with CurrentTheme do
  begin
    B := EditFrameWidth;

    AWidth := TppTBXEditItem(Item).EditWidth;
    if not IsToolbarStyle then
    begin
      EditCaptionSize := MeasureEditCaption;
      W := EditCaptionSize.CX;
      if W > 0 then Inc(W, MenuLeftCaptionMargin + MenuRightCaptionMargin + MenuImageTextSpace);
      Inc(AWidth, GetPopupMargin(Self) + MenuImageTextSpace + W + EditMenuRightIndent);
    end
    else
    begin
      EditCaptionSize.CX := 0;
      EditCaptionSize.CY := 0;
    end;

    EditBoxHeight := MeasureTextHeight + 1;
    Inc(EditBoxHeight, EditTextMarginVert * 2 + B * 2);
    AHeight := Max(EditBoxHeight, EditCaptionSize.CY);
    if not IsToolbarStyle then AHeight := AHeight;
    if EditHeightEven then AHeight := (AHeight + 1) and not $01
    else AHeight := AHeight or $01;
  end
  else inherited;
end;

procedure TppTBXEditItemViewer.EditChangeHandler(Sender: TObject);
begin
  HandleEditChange((Sender as TEdit));
end;

procedure TppTBXEditItemViewer.HandleEditChange(Edit: TEdit);
begin
  TppTBXEditItem(Item).HandleEditChange(Edit);
end;

procedure TppTBXEditItemViewer.GetEditInfo(out EditInfo: TppTBXEditInfo; const ItemInfo: TppTBXItemInfo);
begin
  FillChar(EditInfo, SizeOf(EditInfo), 0);
  EditInfo.LeftBtnWidth := GetIndentBefore;
  EditInfo.RightBtnWidth := GetIndentAfter;
end;

function TppTBXEditItemViewer.GetAccRole: Integer;
const
  ROLE_SYSTEM_SPINBUTTON = $34;
  ROLE_SYSTEM_COMBOBOX = $2E;
begin
  Result := inherited GetAccRole;
  if Self is TppTBXSpinEditViewer then Result := ROLE_SYSTEM_SPINBUTTON
  else if Self is TppTBXDropDownItemViewer then Result := ROLE_SYSTEM_COMBOBOX;
end;

procedure TppTBXEditItemViewer.GetItemInfo(out ItemInfo: TppTBXItemInfo; IsHoverItem, IsPushed, UseMenuColor: Boolean);
const
  CToolbarStyle: array [Boolean] of Integer = (0, IO_TOOLBARSTYLE);
  CDesigning: array [Boolean] of Integer = (0, IO_DESIGNING);
var
  Item: TppTBXEditItem;
begin
  Item := TppTBXEditItem(Self.Item);

  FillChar(ItemInfo, SizeOf(TppTBXItemInfo), 0);
  ItemInfo.ViewType := GetViewType(View);
  ItemInfo.ItemOptions := CToolbarStyle[IsToolbarStyle]
    or CDesigning[csDesigning in Item.ComponentState];
  ItemInfo.Enabled := Item.Enabled or View.Customizing;
  ItemInfo.Pushed := IsPushed;
  ItemInfo.Selected := Item.Checked;
  if IsHoverItem then
  begin
    if not ItemInfo.Enabled and not View.MouseOverSelected then
      ItemInfo.HoverKind := hkKeyboardHover
    else
      if ItemInfo.Enabled then ItemInfo.HoverKind := hkMouseHover;
  end
  else ItemInfo.HoverKind := hkNone;
  if not IsToolbarStyle then ItemInfo.PopupMargin := GetPopupMargin(Self);
end;

procedure TppTBXEditItemViewer.GetEditRect(var R: TRect);
const
  TB2K_EDIT_BORDER = 3;
var
  W, B: Integer;
begin
  if Item is TppTBXEditItem then with CurrentTheme do
  begin
    R := BoundsRect;
    if not IsToolbarStyle then
    begin
      W := MeasureEditCaption.CX;
      if W > 0 then Inc(W, MenuLeftCaptionMargin + MenuRightCaptionMargin + MenuImageTextSpace);
      Inc(R.Left, GetPopupMargin(Self) + MenuImageTextSpace + W);
      Dec(R.Right, EditMenuRightIndent);
    end;

    B := EditFrameWidth - TB2K_EDIT_BORDER;
    InflateRect(R, -B - EditTextMarginHorz , -B - EditTextMarginVert);
    Inc(R.Left, GetIndentBefore);
    Dec(R.Right, GetIndentAfter);
  end
  else inherited;
end;

function TppTBXEditItemViewer.GetIndentAfter: Integer;
begin
  Result := 0;
end;

function TppTBXEditItemViewer.GetIndentBefore: Integer;
var
  ImgList: TCustomImageList;
begin
  if ShowImage then
  begin
    ImgList := GetImageList;
    if ImgList <> nil then Result := ImgList.Width + 2
    else Result := 0;
  end
  else Result := 0;
end;

function TppTBXEditItemViewer.HandleEditMessage(var Message: TMessage): Boolean;
const
  CharKeys = [VK_SPACE, $30..$5A, VK_NUMPAD0..VK_DIVIDE, $BA..$F5];
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if Message.WParam in CharKeys then Inc(TppTBXEditItem(Item).FAutoCompleteCounter)
  end
  else if Message.Msg = WM_KEYUP then
  begin
    if Message.WParam in CharKeys then Dec(TppTBXEditItem(Item).FAutoCompleteCounter);
  end;
  Result := False;
end;

procedure TppTBXEditItemViewer.NewEditWndProc(var Message: TMessage);
begin
  if Assigned(OldWndProc) and not HandleEditMessage(Message) then OldWndProc(Message);
end;

procedure TppTBXEditItemViewer.Paint(const Canvas: TCanvas;
  const ClientAreaRect: TRect; IsHoverItem, IsPushed, UseDisabledShadow: Boolean);
const
  FillColors: array [Boolean] of Integer = (COLOR_BTNFACE, COLOR_WINDOW);
  TextColors: array [Boolean] of Integer = (COLOR_GRAYTEXT, COLOR_WINDOWTEXT);
  Alignments: array [TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  DC: HDC;
  Item: TppTBXEditItem;
  S: string;
  R, R2: TRect;
  M, W: Integer;
  ItemInfo: TppTBXItemInfo;
  EditInfo: TppTBXEditInfo;
  ImgList: TCustomImageList;
  ImgIndex: Integer;
  Fnt, OldFnt: HFont;
  C, OldColor: TColor;
begin
  DC := Canvas.Handle;
  Item := TppTBXEditItem(Self.Item);
  GetItemInfo(ItemInfo, IsHoverItem, IsPushed, UseDisabledShadow);
  GetEditInfo(EditInfo, ItemInfo);
  R := ClientAreaRect;

  if not IsToolbarStyle then with CurrentTheme do
  begin
    S := Item.EditCaption;

    if Length(S) > 0 then
    begin
      { measure EditCaption }
      Fnt := TppTBXEditItem(Item).FontSettings.CreateTransformedFont(TppTBViewAccess(View).GetFont.Handle, C);
      OldFnt := SelectObject(DC, Fnt);
      W := GetTextWidth(DC, S, True) + MenuImageTextSpace + MenuLeftCaptionMargin + MenuRightCaptionMargin;
      SelectObject(DC, OldFnt);
    end
    else
    begin
      Fnt := 0; // to suppress compiler warning
      W := 0;
    end;

    M := GetPopupMargin(Self);
    if not EditMenuFullSelect then R.Right := M + W
    else Dec(R.Right, EditMenuRightIndent);
    PaintMenuItemFrame(Canvas, R, ItemInfo);
    Inc(R.Left, M + MenuImageTextSpace);
    R.Right := ClientAreaRect.Right - EditMenuRightIndent;

    if Length(S) > 0 then
    begin
      Inc(R.Left, MenuLeftCaptionMargin);
      C := ColorToRGB(GetItemTextColor(ItemInfo));
      OldFnt := SelectObject(DC, Fnt);
      OldColor := SetTextColor(DC, C);
      PaintCaption(Canvas, R, ItemInfo, S, DT_SINGLELINE or DT_LEFT or DT_VCENTER, False);
      SetTextColor(DC, OldColor);
      W := GetTextWidth(DC, S, True);
      SelectObject(DC, OldFnt);
      DeleteObject(Fnt);
      Inc(R.Left, W + MenuRightCaptionMargin + MenuImageTextSpace);
    end;
  end;

  CurrentTheme.PaintEditFrame(Canvas, R, ItemInfo, EditInfo);
  W := CurrentTheme.EditFrameWidth;
  InflateRect(R, -W - CurrentTheme.EditTextMarginHorz, -W - CurrentTheme.EditTextMarginVert);

  if ShowImage then
  begin
    ImgList := GetImageList;
    if ImgList <> nil then
    begin
      R2.Left := R.Left;
      R2.Right := R.Left + ImgList.Width;
      R2.Top := (R.Top + R.Bottom + 1 - ImgList.Height) div 2;
      R2.Bottom := R2.Top + ImgList.Height;
      ImgIndex := TppTBXEditItem(Item).GetImageIndex;
      if Item.Enabled then ImgList.Draw(Canvas, R.Left, R2.Top, ImgIndex)
      else DrawTBXImage(Canvas, R2, ImgList, ImgIndex, ISF_DISABLED);
    end;
  end;
  Inc(R.Left, EditInfo.LeftBtnWidth);
  Dec(R.Right, EditInfo.RightBtnWidth + 1);

  if Item.Text <> '' then
  begin
    S := Item.Text;
    if TppTBXEditItem(Item).PasswordChar <> #0 then S := StringOfChar(TppTBXEditItem(Item).PasswordChar, Length(S));
    Fnt := Item.EditorFontSettings.CreateTransformedFont(TppTBViewAccess(View).GetFont.Handle, C);
    OldFnt := SelectObject(DC, Fnt);
    SetBkMode(DC, TRANSPARENT);
    SetBkColor(DC, GetSysColor(FillColors[Item.Enabled]));
    SetTextColor(DC, GetSysColor(TextColors[Item.Enabled]));
    DrawText(DC, PChar(S), Length(S), R, DT_SINGLELINE or DT_NOPREFIX or Alignments[Item.Alignment]);
    SelectObject(DC, OldFnt);
    DeleteObject(Fnt);
  end;

{  if not IsToolbarStyle then
  begin
    R := ClientAreaRect;
    Self.GetEditRect(R);
    OffsetRect(R, -BoundsRect.Left, -BoundsRect.Top);
    Canvas.FrameRect(R);
  end;  }
end;

function TppTBXEditItemViewer.GetEditControlClass: TEditClass;
begin
  Result := TppTBXEdit;
end;

function TppTBXEditItemViewer.ShowImage: Boolean;
begin
  Result := TppTBXEditItem(Item).ShowImage;
end;

function TppTBXEditItemViewer.IsToolbarSize: Boolean;
begin
  Result := inherited IsToolbarSize;
  Result := Result or ((GetViewType(View) and PVT_TOOLBOX) = PVT_TOOLBOX);
end;

function TppTBXEditItemViewer.IsToolbarStyle: Boolean;
begin
  Result := inherited IsToolbarStyle;
  Result := Result or ((GetViewType(View) and PVT_TOOLBOX) = PVT_TOOLBOX);
end;

function TppTBXEditItemViewer.MeasureEditCaption: TSize;
var
  DC: HDC;
  Fnt, OldFnt: HFont;
  DummyColor: TColor;
  TextMetric: TTextMetric;
  S: string;
begin
  Result.cx := 0;
  Result.cy := 0;
  if Item is TppTBXEditItem then
  begin
    S := StripAccelChars(TppTBXEditItem(Item).EditCaption);
    if Length(S) > 0 then
    begin
      DummyColor := clWhite;
      DC := GetDC(0);
      Fnt := TppTBXEditItem(Item).FontSettings.CreateTransformedFont(TppTBViewAccess(View).GetFont.Handle, DummyColor);
      OldFnt := SelectObject(DC, Fnt);
      GetTextExtentPoint32(DC, PChar(S), Length(S), Result);
      GetTextMetrics(DC, TextMetric);
      Inc(Result.cy, TextMetric.tmExternalLeading);
      SelectObject(DC, OldFnt);
      DeleteObject(Fnt);
      ReleaseDC(0, DC);
    end;
  end;
end;

function TppTBXEditItemViewer.MeasureTextHeight: Integer;
var
  DC: HDC;
  Fnt, OldFnt: HFont;
  DummyColor: TColor;
  TextMetric: TTextMetric;
begin
  Result := 0;
  if Item is TppTBXEditItem then
  begin
    DummyColor := clWhite;
    DC := GetDC(0);
    Fnt := TppTBXEditItem(Item).EditorFontSettings.CreateTransformedFont(TppTBViewAccess(View).GetFont.Handle, DummyColor);
    OldFnt := SelectObject(DC, Fnt);
    Result := GetTextHeight(DC);
    GetTextMetrics(DC, TextMetric);
    Inc(Result, TextMetric.tmExternalLeading);
    SelectObject(DC, OldFnt);
    DeleteObject(Fnt);
    ReleaseDC(0, DC);
  end;
end;

function TppTBXEditItemViewer.DoExecute: Boolean;
begin
  if Item is TppTBXEditItem then
  begin
    TppTBXEditItem(Item).FLastEditChange := '';
    Result := inherited DoExecute;
    with TppTBXEditItem(Item) do
    begin
      if FLastEditChange <> Text then DoChange(Text);
      FLastEditChange := '';
    end;
  end
  else Result := inherited DoExecute;
end;


//============================================================================//

{ TppTBXCustomDropDownItem }

constructor TppTBXCustomDropDownItem.Create(AOwner: TComponent);
begin
  inherited;
  ItemStyle := ItemStyle + [tbisCombo, tbisSubmenu, tbisSubitemsEditable] - [tbisDontSelectFirst];
  FAlwaysSelectFirst := True;
end;

function TppTBXCustomDropDownItem.CreatePopup(const ParentView: TppTBView;
  const ParentViewer: TppTBItemViewer; const PositionAsSubmenu,
  SelectFirstItem, Customizing: Boolean; const APopupPoint: TPoint;
  const Alignment: TppTBPopupAlignment): TppTBPopupWindow;
var
  SelectFirst: Boolean;
begin
  if AlwaysSelectFirst then SelectFirst := True
  else SelectFirst := SelectFirstItem;
  Result := inherited CreatePopup(ParentView, ParentViewer, PositionAsSubmenu,
    SelectFirst, Customizing, APopupPoint, Alignment);
end;

function TppTBXCustomDropDownItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  if not (tboUseEditWhenVertical in EditOptions) and (AView.Orientation = tbvoVertical) then
    Result := TppTBXItemViewer
  else
    Result := TppTBXDropDownItemViewer;
end;


//----------------------------------------------------------------------------//

{ TppTBXDropDownItemViewer }

procedure TppTBXDropDownItemViewer.GetCursor(const Pt: TPoint; var ACursor: HCURSOR);
begin
  if not TppTBXCustomDropDownItem(Item).DropDownList then inherited;
end;

procedure TppTBXDropDownItemViewer.GetEditInfo(out EditInfo: TppTBXEditInfo; const ItemInfo: TppTBXItemInfo);
const
  CDisabled: array [Boolean] of Integer = (EBDS_DISABLED, 0);
  CHot: array [Boolean] of Integer = (0, EBDS_HOT);
  CPressed: array [Boolean] of Integer = (0, EBDS_PRESSED);
begin
  inherited GetEditInfo(EditInfo, ItemInfo);
  EditInfo.RightBtnInfo.ButtonType := EBT_DROPDOWN;
  EditInfo.RightBtnInfo.ButtonState := CDisabled[ItemInfo.Enabled] or
    CHot[ItemInfo.HoverKind = hkMouseHover] or CPressed[ItemInfo.Pushed];
end;

function TppTBXDropDownItemViewer.GetIndentAfter: Integer;
begin
  if IsToolbarStyle then Result := CurrentTheme.EditBtnWidth
  else Result := GetSystemMetrics(SM_CXMENUCHECK) + 2;
end;

function TppTBXDropDownItemViewer.HandleEditMessage(var Message: TMessage): Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if TWMKeyDown(Message).CharCode = VK_F4 then
    begin
      TppTBViewAccess(View).OpenChildPopup(True);
      Result := True;
      Exit;
    end;
  end;

  Result := inherited HandleEditMessage(Message);
end;

function TppTBXDropDownItemViewer.IsPtInButtonPart(X, Y: Integer): Boolean;
begin
  Result := not (tbisSubmenu in TppTBXCustomDropDownItem(Item).ItemStyle);
  if TppTBXCustomDropDownItem(Item).DropDownList then Result := False
  else if (tbisCombo in TppTBXCustomDropDownItem(Item).ItemStyle) then
    Result := X < (BoundsRect.Right - BoundsRect.Left) - GetIndentAfter;
end;

procedure TppTBXDropDownItemViewer.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not TppTBXCustomDropDownItem(Item).DropDownList then inherited;
end;

//============================================================================//

{ TppTBXComboBoxItem }

procedure TppTBXComboBoxItem.AdjustImageIndex(const AText: string;
  AIndex: Integer; var ImageIndex: Integer);
begin
  if Assigned(FOnAdjustImageIndex) then FOnAdjustImageIndex(Self, AText, AIndex, ImageIndex);
end;

procedure TppTBXComboBoxItem.AdjustImageIndexHandler(Sender: TppTBXCustomList;
  AItemIndex: Integer; var ImageIndex: Integer);
begin
  AdjustImageIndex(FList.Strings[AItemIndex], AItemIndex, ImageIndex);
end;

constructor TppTBXComboBoxItem.Create(AOwner: TComponent);
begin
  inherited;
  ItemStyle := ItemStyle - [tbisSubItemsEditable];
  FAutoComplete := True;
  FList := GetStringListClass.Create(Self);
  FList.OnChange := ListChangeHandler;
  FList.OnClick := ListClickHandler;
  FList.OnAdjustImageIndex := AdjustImageIndexHandler;
  MinListWidth := 64;
end;

function TppTBXComboBoxItem.DoAutoComplete(var AText: string): Boolean;
var
  I: Integer;
  S, R: string;
  TemplateL, MinL, L: Integer;
begin
  Result := False;
  if Length(AText) > 0 then
  begin
    { choose the shortest matching string from items }
    TemplateL := Length(AText);
    MinL := MaxInt;
    SetLength(R, 0);
    for I := 0 to FList.Strings.Count - 1 do
    begin
      S := FList.Strings[I];
      L := Length(S);
      if (L >= TemplateL) and (L < MinL) and StartsText(AText, S) then
      begin
        R := S;
        MinL := L;
        if MinL = TemplateL then Break;
      end;
    end;
    Result := Length(R) > 0;
    if Result then AText := R;
  end;
end;

procedure TppTBXComboBoxItem.DoListChange;
begin
  { Update text in edit item. This will call OnChange automatically }
  if (FList.ItemIndex >= 0) and (FList.ItemIndex < FList.Strings.Count) then
  begin
    IsChanging := True;
    try
      if Text <> FList.Strings[Flist.ItemIndex] then
      begin
        SetTextEx(FList.Strings[FList.ItemIndex], tcrList);
      end;
    finally
      IsChanging := False;
    end;
  end;
end;

procedure TppTBXComboBoxItem.DoListClick;
begin
  if Assigned(FOnItemClick) then FOnItemClick(Self);
end;

procedure TppTBXComboBoxItem.DoPopup(Sender: TppTBCustomItem; FromLink: Boolean);
begin
  inherited;
  FList.ItemIndex := FList.Strings.IndexOf(Text);
end;

function TppTBXComboBoxItem.GetImageIndex: Integer;
begin
  if not CacheValid then
  begin
    CachedImageIndex := ImageIndex;
    if ItemIndex >= 0 then CachedImageIndex := ItemIndex;
    AdjustImageIndex(Text, -1, CachedImageIndex);
    CacheValid := True;
  end;
  Result := CachedImageIndex;
end;

function TppTBXComboBoxItem.GetItemIndex: Integer;
begin
  Result := FList.ItemIndex;
end;

function TppTBXComboBoxItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  if not (tboUseEditWhenVertical in EditOptions) and
     (AView.Orientation = tbvoVertical) then
    Result := TppTBXItemViewer
  else
    Result := TppTBXComboBoxItemViewer;
end;

function TppTBXComboBoxItem.GetMaxVisibleItems: Integer;
begin
  Result := FList.MaxVisibleItems;
end;

function TppTBXComboBoxItem.GetMaxWidth: Integer;
begin
  Result := FList.MaxWidth;
end;

function TppTBXComboBoxItem.GetMinWidth: Integer;
begin
  Result := FList.MinWidth;
end;

function TppTBXComboBoxItem.GetOnClearItem: TppTBXLPaintEvent;
begin
  Result := FList.OnClearItem;
end;

function TppTBXComboBoxItem.GetOnDrawItem: TppTBXLPaintEvent;
begin
  Result := FList.OnDrawItem;
end;

function TppTBXComboBoxItem.GetOnMeasureHeight: TppTBXLMeasureHeight;
begin
  Result := FList.OnMeasureHeight;
end;

function TppTBXComboBoxItem.GetOnMeasureWidth: TppTBXLMeasureWidth;
begin
  Result := FList.OnMeasureWidth;
end;

function TppTBXComboBoxItem.GetShowListImages: Boolean;
begin
  Result := FList.ShowImages;
end;

function TppTBXComboBoxItem.GetStringListClass: TppTBXStringListClass;
begin
  Result := TppTBXStringList;
end;

function TppTBXComboBoxItem.GetStrings: TStrings;
begin
  Result := FList.Strings;
end;

procedure TppTBXComboBoxItem.HandleEditChange(Edit: TEdit);
begin
  CacheValid := False;
  inherited;
end;

procedure TppTBXComboBoxItem.ListChangeHandler(Sender: TObject);
begin
  CacheValid := False;
  DoListChange;
end;

procedure TppTBXComboBoxItem.ListClickHandler(Sender: TObject);
begin
  CacheValid := False;
  DoListClick;
end;

procedure TppTBXComboBoxItem.Loaded;
begin
  inherited;
  if FList.Strings.IndexOf(Text) >= 0 then
  begin
    IsChanging := True;
    try
      FList.ItemIndex := FList.Strings.IndexOf(Text);
    finally
      IsChanging := False;
    end;
  end;
  if not (csDesigning in ComponentState) then Add(FList);
end;

procedure TppTBXComboBoxItem.SetItemIndex(Value: Integer);
begin
  FList.ItemIndex := Value;
end;

procedure TppTBXComboBoxItem.SetMaxVisibleItems(Value: Integer);
begin
  FList.MaxVisibleItems := Value;
end;

procedure TppTBXComboBoxItem.SetMaxWidth(Value: Integer);
begin
  FList.MaxWidth := Value;
end;

procedure TppTBXComboBoxItem.SetMinWidth(Value: Integer);
begin
  FList.MinWidth := Value;
end;

procedure TppTBXComboBoxItem.SetOnClearItem(Value: TppTBXLPaintEvent);
begin
  FList.OnClearItem := Value;
end;

procedure TppTBXComboBoxItem.SetOnDrawItem(Value: TppTBXLPaintEvent);
begin
  FList.OnDrawItem := Value;
end;

procedure TppTBXComboBoxItem.SetOnMeasureHeight(Value: TppTBXLMeasureHeight);
begin
  FList.OnMeasureHeight := Value;
end;

procedure TppTBXComboBoxItem.SetOnMeasureWidth(Value: TppTBXLMeasureWidth);
begin
  FList.OnMeasureWidth := Value;
end;

procedure TppTBXComboBoxItem.SetShowListImages(Value: Boolean);
begin
  FList.ShowImages := Value;
end;

procedure TppTBXComboBoxItem.SetStrings(Value: TStrings);
begin
  FList.Strings := Value;
end;


//============================================================================//

{ TppTBXComboBoxItemViewer }

function TppTBXComboBoxItemViewer.HandleEditMessage(var Message: TMessage): Boolean;
begin
  if (Message.Msg = WM_KEYDOWN) then with TppTBXComboBoxItem(Item) do
  begin
    case Message.wParam of
      VK_UP:
        begin
          ItemIndex := ItemIndex - 1;
          EditControl.Text := Text;
          EditControl.SelectAll;
          Result := True;
        end;

      VK_DOWN:
        begin
          ItemIndex := ItemIndex + 1;
          EditControl.Text := Text;
          EditControl.SelectAll;
          Result := True;
        end;
    else
      Result := inherited HandleEditMessage(Message);
    end
  end
  else Result := inherited HandleEditMessage(Message);
end;


//============================================================================//

{ TppTBXLabelItem }

constructor TppTBXLabelItem.Create(AOwner: TComponent);
begin
  inherited;
  FFontSettings := TFontSettings.Create;
  TFontSettingsAccess(FFontSettings).OnChange := FontSettingsChanged;
  FShowAccelChar := True;
  ItemStyle := ItemStyle - [tbisSelectable] + [tbisClicksTransparent, tbisStretch];
end;

destructor TppTBXLabelItem.Destroy;
begin
  FFontSettings.Free;
  inherited;
end;

procedure TppTBXLabelItem.FontSettingsChanged(Sender: TObject);
begin
  Change(True);
end;

function TppTBXLabelItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  Result := TppTBXLabelItemViewer;
end;

procedure TppTBXLabelItem.SetCaption(const Value: TCaption);
begin
  FCaption := Value;
  Change(True);
end;

procedure TppTBXLabelItem.SetFontSettings(Value: TFontSettings);
begin
  FFontSettings := Value;
end;

{procedure TppTBXLabelItem.SetFontSize(Value: TppTBXFontSize);
begin
  FFontSize := Value;
  Change(True);
end;  }

procedure TppTBXLabelItem.SetMargin(Value: Integer);
begin
  FMargin := Value;
  Change(True);
end;

procedure TppTBXLabelItem.SetOrientation(Value: TppTBXLabelOrientation);
begin
  FOrientation := Value;
  Change(True);
end;

procedure TppTBXLabelItem.SetShowAccelChar(Value: Boolean);
begin
  FShowAccelChar := Value;
  Change(True);
end;

procedure TppTBXLabelItem.UpdateCaption(const Value: TCaption);
begin
  FCaption := Value;
  Change(False);
end;


//============================================================================//

{ TppTBXLabelItemViewer }

procedure TppTBXLabelItemViewer.CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer);
var
  DC: HDC;
  S: string;
  TextMetrics: TTextMetric;
  RotatedFont, SaveFont: HFont;
begin
  Canvas.Font := TppTBViewAccess(View).GetFont;
  DoAdjustFont(Canvas.Font, 0);
  S := GetCaptionText;
  if Length(S) = 0 then S := '0';
  DC := Canvas.Handle;
  if IsToolbarStyle then
  begin
    AWidth := TppTBXLabelItem(Item).Margin;
    AHeight := AWidth;
    if Length(S) > 0 then
    begin
      if GetIsHoriz then
      begin
        GetTextMetrics(DC, TextMetrics);
        Inc(AHeight, TextMetrics.tmHeight);
        Inc(AWidth, GetTextWidth(DC, S, TppTBXLabelItem(Item).ShowAccelChar));
      end
      else
      begin
        RotatedFont := CreateRotatedFont(DC);
        SaveFont := SelectObject(DC, RotatedFont);
        GetTextMetrics(DC, TextMetrics);
        Inc(AWidth, TextMetrics.tmHeight);
        Inc(AHeight, GetTextWidth(DC, S, TppTBXLabelItem(Item).ShowAccelChar));
        SelectObject(DC, SaveFont);
        DeleteObject(RotatedFont);
      end;
    end;
  end
  else
  begin
    if Length(S) > 0 then
    begin
      GetTextMetrics(DC, TextMetrics);
      AHeight := TextMetrics.tmHeight;
      AWidth := GetTextWidth(DC, S, TppTBXLabelItem(Item).ShowAccelChar);
    end;
  end;

  if AWidth < 6 then AWidth := 6;
  if AHeight < 6 then AHeight := 6;
  with TppTBXLabelItem(Item) do
  begin
    Inc(AWidth, Margin shl 1 + 1);
    Inc(AHeight, Margin shl 1 + 1);
  end;
end;

procedure TppTBXLabelItemViewer.DoAdjustFont(AFont: TFont; StateFlags: Integer);
begin
  if Item is TppTBXLabelItem then
    with TppTBXLabelItem(Item) do
    begin
      FontSettings.Apply(AFont);
      if Assigned(FOnAdjustFont) then FOnAdjustFont(Item, Self, AFont, StateFlags);
    end;
end;

function TppTBXLabelItemViewer.GetCaptionText: string;
var
  P: Integer;
begin
  Result := TppTBXLabelItem(Item).Caption;
  P := Pos(#9, Result);
  if P <> 0 then SetLength(Result, P - 1);
end;

function TppTBXLabelItemViewer.GetIsHoriz: Boolean;
begin
  with TppTBXLabelItem(Item) do
   case Orientation of
     tbxoHorizontal: Result := True;
     tbxoVertical: Result := False;
   else // tbxoAuto
     Result := View.Orientation <> tbvoVertical;
   end;
end;

function TppTBXLabelItemViewer.IsToolbarSize: Boolean;
begin
  Result := inherited IsToolbarSize;
  Result := Result or ((GetViewType(View) and PVT_TOOLBOX) = PVT_TOOLBOX);
end;

function TppTBXLabelItemViewer.IsToolbarStyle: Boolean;
begin
  Result := inherited IsToolbarStyle;
  Result := Result or ((GetViewType(View) and PVT_TOOLBOX) = PVT_TOOLBOX);
end;

procedure TppTBXLabelItemViewer.Paint(const Canvas: TCanvas;
  const ClientAreaRect: TRect; IsHoverItem, IsPushed, UseDisabledShadow: Boolean);
const
  CEnabledStates: array [Boolean] of Integer = (ISF_DISABLED, 0);
  CDesigning: array [Boolean] of Integer = (0, IO_DESIGNING);
  CPrefixes: array [Boolean] of Integer = (DT_NOPREFIX, 0);
var
  Fmt: Cardinal;
  ItemInfo: TppTBXItemInfo;
  R: TRect;
begin
  FillChar(ItemInfo, SizeOf(ItemInfo), 0);
  ItemInfo.ViewType := GetViewType(View);
  ItemInfo.ItemOptions := IO_TOOLBARSTYLE or CDesigning[csDesigning in Item.ComponentState];
  ItemInfo.Enabled := Item.Enabled or View.Customizing;
  ItemInfo.Pushed := False;
  ItemInfo.Selected := False;
  ItemInfo.ImageShown := False;
  ItemInfo.ImageWidth := 0;
  ItemInfo.ImageHeight := 0;
  ItemInfo.HoverKind := hkNone;
  ItemInfo.IsPopupParent := False;
  ItemInfo.IsVertical := not GetIsHoriz;

  Canvas.Font := TppTBViewAccess(View).GetFont;
  Canvas.Font.Color := CurrentTheme.GetItemTextColor(ItemInfo);
  DoAdjustFont(Canvas.Font, CEnabledStates[ItemInfo.Enabled]);
  Canvas.Brush.Style := bsClear;
  Fmt := DT_SINGLELINE or DT_CENTER or DT_VCENTER or CPrefixes[TppTBXLabelItem(Item).ShowAccelChar];
  R := ClientAreaRect;
  CurrentTheme.PaintCaption(Canvas, R, ItemInfo, GetCaptionText, Fmt, ItemInfo.IsVertical);
  Canvas.Brush.Style := bsSolid;
end;


//============================================================================//

{ TppTBXColorItem }

constructor TppTBXColorItem.Create(AOwner: TComponent);
begin
  inherited;
  FColor := clWhite;
end;

function TppTBXColorItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  Result := TppTBXColorItemViewer;
end;

procedure TppTBXColorItem.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Change(False);
  end;
end;


//============================================================================//

{ TppTBXColorItemViewer }

procedure TppTBXColorItemViewer.DrawItemImage(Canvas: TCanvas; ARect: TRect; ItemInfo: TppTBXItemInfo);
begin
  with ItemInfo, Canvas do if Enabled then
  begin
    if ((ItemOptions and IO_TOOLBARSTYLE) = 0) then InflateRect(ARect, -2, -2);
    if TppTBXColorItem(Item).Color <> clNone then
    begin
      Brush.Color := clBtnShadow;
      FrameRect(ARect);
      InflateRect(ARect, -1, -1);
      Brush.Color := TppTBXColorItem(Item).Color;
      FillRect(ARect);
    end;
  end
  else
  begin
    Inc(ARect.Right);
    Inc(ARect.Bottom);
    DrawEdge(Handle, ARect, BDR_SUNKENOUTER or BDR_RAISEDINNER, BF_RECT);
  end;
end;

procedure TppTBXColorItemViewer.DoPaintCaption(Canvas: TCanvas;
  const ClientAreaRect: TRect; var CaptionRect: TRect;
  IsTextRotated: Boolean; var PaintDefault: Boolean);
begin
  if (GetViewType(View) and PVT_TOOLBOX) = PVT_TOOLBOX then
  begin
    { Center Caption }
    OffsetRect(CaptionRect, -CaptionRect.Left, 0);
    OffsetRect(CaptionRect, (ClientAreaRect.Right - CaptionRect.Right) div 2, 0);
  end;
end;

function TppTBXColorItemViewer.GetImageSize: TSize;
begin
  if IsToolbarStyle then
  begin
    Result.CX := 12;
    Result.CY := 12;
  end
  else
  begin
    Result.CX := 16;
    Result.CY := 16;
  end;
end;

function TppTBXColorItemViewer.GetImageShown: Boolean;
begin
  Result := ((Item.DisplayMode in [nbdmDefault, nbdmImageAndText]) or
    (IsToolbarStyle and (Item.DisplayMode = nbdmTextOnlyInMenus)));
end;

constructor TppTBXColorItemViewer.Create(AView: TppTBView; AItem: TppTBCustomItem; AGroupLevel: Integer);
begin
  inherited;
  Wide := False;
end;

//============================================================================//

{ TppTBXMRUList }

function TppTBXMRUList.GetFirstKey:Integer;
begin
  Result := FKeyShift;
end;

function TppTBXMRUList.GetItemClass: TppTBCustomItemClass;
begin
  Result := TppTBXCustomItem;
end;

procedure TppTBXMRUList.SetItemCaptions;
var
  I: Integer;
begin
  inherited;
  if Container is TppTBXCustomItem then
    for I := 0 to Items.Count - 1 do
      TppTBXCustomItem(Items[I]).FontSettings := TppTBXCustomItem(Container).FontSettings;
end;

procedure TppTBXMRUList.SetKeyShift(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FKeyShift := Value;
  SetItemCaptions;
end;


//============================================================================//

{ TppTBXMRUListItem }

constructor TppTBXMRUListItem.Create(AOwner: TComponent);
begin
  inherited;
  ItemStyle := ItemStyle + [tbisEmbeddedGroup];
  Caption := ppSTBMRUListItemDefCaption[1] + 'TBX ' +
    Copy(ppSTBMRUListItemDefCaption, 2, Length(ppSTBMRUListItemDefCaption) - 1);
end;

procedure TppTBXMRUListItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FMRUList) and (Operation = opRemove) then MRUList := nil;
end;

procedure TppTBXMRUListItem.SetMRUList(Value: TppTBMRUList);
begin
  if FMRUList <> Value then
  begin
    FMRUList := Value;
    if Assigned(Value) then
    begin
      Value.FreeNotification(Self);
      LinkSubitems := TppTBMRUListAccess(Value).Container;
    end
    else LinkSubitems := nil;
  end;
end;

{ TppTBXCustomSpinEditItem }

function TppTBXCustomSpinEditItem.CheckValue(const V: Extended): Extended;
begin
  Result := V;
  if FMaxValue <> FMinValue then
  begin
    if V < FMinValue then Result := FMinValue
    else if V > FMaxValue then Result := FMaxValue;
  end;
end;

procedure TppTBXCustomSpinEditItem.ClickDown;
var
  OldValue, NewValue: Extended;
begin
  OldValue := GetValue;
  if Snap then
    NewValue := Ceil(OldValue / Increment - 1 - Increment * 0.0001) * Increment
  else
    NewValue := OldValue - FIncrement;
  DoStep(-1, OldValue, NewValue);
  SetValueEx(NewValue, tcrSpinButton);
end;

procedure TppTBXCustomSpinEditItem.ClickUp;
var
  OldValue, NewValue: Extended;
begin
  OldValue := GetValue;
  if Snap then
    NewValue := Floor(OldValue / Increment + 1 + Increment * 0.0001) * Increment
  else
    NewValue := OldValue + FIncrement;
  DoStep(+1, OldValue, NewValue);
  SetValueEx(NewValue, tcrSpinButton);
end;

constructor TppTBXCustomSpinEditItem.Create(AOwner: TComponent);
begin
  inherited;
  FAlignment := taRightJustify;
  FDecimal := 2;
  FIncrement := 1;
  FSnap := True;
  Text := '0';
end;

function TppTBXCustomSpinEditItem.DoAcceptText(var NewText: string): Boolean;
var
  V: Extended;
begin
  if ParseValue(NewText, V) then
  begin
    NewText := GetAsText(V);
    Result := True;
  end
  else Result := False;
end;

function TppTBXCustomSpinEditItem.DoConvert(const APrefix, APostfix: string; var AValue: Extended): Boolean;
begin
  Result := True;
  if Assigned(FOnConvert) then FOnConvert(Self, APrefix, APostfix, AValue, Result);
end;

procedure TppTBXCustomSpinEditItem.DoStep(Step: Integer; const OldValue: Extended; var NewValue: Extended);
begin
  if Assigned(FOnStep) then FOnStep(Self, Step, OldValue, NewValue);
end;

procedure TppTBXCustomSpinEditItem.DoTextChanged(Reason: Integer);
begin
  if Reason = tcrEditControl then
    SetValueEx(GetValue, tcrNumericProperty);
end;

function TppTBXCustomSpinEditItem.DoTextToValue(const AText: string; out AValue: Extended): Boolean;
begin
  Result := False;
  if Assigned(FOnTextToValue) then FOnTextToValue(Self, AText, AValue, Result);
end;

procedure TppTBXCustomSpinEditItem.DoValueChange(const V: Extended);
begin
  if Assigned(FOnValueChange) then FOnValueChange(Self, V);
end;

procedure TppTBXCustomSpinEditItem.DoValueToText(const NewValue: Extended; var NewText: string);
begin
  if Assigned(FOnValueToText) then FOnValueToText(Self, NewValue, NewText);
end;

function TppTBXCustomSpinEditItem.GetAsInteger: Integer;
begin
  Result := Round(Value);
end;

function TppTBXCustomSpinEditItem.GetAsText(AValue: Extended): string;
begin
  AValue := CheckValue(AValue);
  if ValueType = evtFloat then Result := FloatToStrF(AValue, ffFixed, 15, FDecimal)
  else if ValueType = evtHex then Result := IntToHex(Round(AValue), 1)
  else Result := IntToStr(Round(AValue));

  if Length(Prefix) > 0 then
  begin
    if SpaceAfterPrefix then Result := ' ' + Result;
    Result := Prefix + Result;
  end;
  if Length(Postfix) > 0 then
  begin
    if SpaceBeforePostfix then Result := Result + ' ';
    Result := Result + Postfix;
  end;
  DoValueToText(AValue, Result);
end;

function TppTBXCustomSpinEditItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  if not (tboUseEditWhenVertical in EditOptions) and
     (AView.Orientation = tbvoVertical) then
    Result := TppTBXItemViewer
  else
    Result := TppTBXSpinEditViewer;
end;

function TppTBXCustomSpinEditItem.GetValue: Extended;
begin
  if not ParseValue(Text, Result) then
    Result := FLastGoodValue;
end;

function TppTBXCustomSpinEditItem.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1;
end;

function TppTBXCustomSpinEditItem.IsMaxValueStored: Boolean;
begin
  Result := FMaxValue <> 0;
end;

function TppTBXCustomSpinEditItem.IsMinValueStored: Boolean;
begin
  Result := FMinValue <> 0;
end;

function TppTBXCustomSpinEditItem.IsValueStored: Boolean;
begin
  Result := GetValue <> 0;
end;

function TppTBXCustomSpinEditItem.ParseValue(const S: string; out V: Extended): Boolean;
const
  CWhiteSpace = [' ', #9];
  CDigits = ['0'..'9'];
  CHexDigits = CDigits + ['A'..'F'];
  CInvalidUnitChars = [#0..#31, ' ', '*', '+', ',', '-', '.', '/', '0'..'9', '^'];
  CInvalidHexUnitChars = CInvalidUnitChars + ['A'..'F'];
var
  P: PChar;
  Sign1: Integer;
  Value1: Extended;
  Value2: Extended;
  Operator: Char;
  PrefixString, PostfixString: string;

  procedure SkipWhiteSpace;
  begin
    while TppCharacter.IsWhiteSpace(P^) do Inc(P);
  end;

  function GetInt: Integer;
  begin
    Result := 0;
    while TppCharacter.IsDigit(P^) do
    begin
      Result := Result * 10 + (Integer(P^) - Integer('0'));
      Inc(P);
    end;
  end;

  function GetInt2: Extended;
  begin
    Result := 0;
    while TppCharacter.IsDigit(P^) do
    begin
      Result := Result * 10 + (Integer(P^) - Integer('0'));
      Inc(P);
    end;
  end;

  function GetNumber(out PrefixString, PostfixString: string; out R: Extended): Boolean;
  var
    PStart: PChar;
    Tmp: Integer;
    ExponentSign, IR: Integer;
    Count1, Count2: Integer;
    E: Extended;
  begin
    R := 0;
    Result := False;

    { Read prefix }
    PStart := P;
    if ValueType <> evtHex then while not ppCharInSet(P^, CInvalidUnitChars) do Inc(P)
    else while not ppCharInSet(P^, CInvalidHexUnitChars) do Inc(P);
    SetString(PrefixString, PStart, P - PStart);
    SkipWhiteSpace;

    { Read value }
    if ValueType in [evtFloat, evtInteger] then
    begin
      if (ValueType = evtInteger) and not TppCharacter.IsDigit(P^) then Exit;

      { get the integer part }
      PStart := P;
      R := GetInt2;
      Count1 := P - PStart;

      if (ValueType = evtFloat) and (P^ = DecimalSeparator) then
      begin
        Inc(P);
        PStart := P;
        E := GetInt2;
        R := R + E / IntPower(10, P - PStart);
        Count2 := P - PStart;
      end
      else Count2 := 0;

      if (Count1 = 0) and (Count2 = 0) then Exit; // '.' (or ',') is not a number

      if (ValueType = evtFloat) and ppCharInSet(P^, ['e', 'E']) and (ppCharInSet(PChar(P + 1)^, ['+', '-', '0'..'9'])) then
      begin
        Inc(P);
        ExponentSign := 1;
        if P^ = '-' then
        begin
          ExponentSign := -1;
          Inc(P);
        end
        else if P^ = '+' then Inc(P);
        if not TppCharacter.IsDigit(P^) then Exit;
        Tmp := GetInt;
        if Tmp >= 5000 then Exit;
        R := R * IntPower(10, Tmp * ExponentSign);
      end;
    end
    else { evtHex }
    begin
      IR := 0;
      if not ppCharInSet(P^, CHexDigits) then Exit;
      while ppCharInSet(P^, CHexDigits) do
      begin
        IR := IR shl 4;
        if TppCharacter.IsDigit(P^) then Inc(IR, Integer(P^) - Integer('0'))
        else if ppCharInSet(P^, ['a'..'f']) then Inc(IR, Integer(P^) - Integer('a') + 10)
        else Inc(IR, Integer(P^) - Integer('A') + 10);
        Inc(P);
      end;
      R := IR;
    end;
    SkipWhiteSpace;

    { Read postfix }
    PStart := P;
    if ValueType <> evtHex then while not ppCharInSet(P^, CInvalidUnitChars) do Inc(P)
    else while not ppCharInset(P^, CInvalidHexUnitChars) do Inc(P);
    SetString(PostfixString, PStart, P - PStart);
    SkipWhiteSpace;

    Result := True;
  end;

begin
  V := 0;

  { Try text-to-value conversion for predefined "constants" }
  Result := DoTextToValue(S, V);
  if Result then Exit;

  { Parse the string for values and expressions }
  if Length(S) = 0 then Exit;
  P := PChar(S);
  SkipWhiteSpace;

  { Read the sign }
  Sign1 := 1;
  if P^ = '-' then
  begin
    Sign1 := -1;
    Inc(P);
    SkipWhiteSpace;
  end
  else if P^ = '+' then
  begin
    Inc(P);
    SkipWhiteSpace;
  end;

  { Read value }
  if not GetNumber(PrefixString, PostfixString, Value1) then Exit;
  if not DoConvert(PrefixString, PostfixString, Value1) then Exit;
  Value1 := Value1 * Sign1;
  V := Value1;

  { Read operator }
  if ppCharInSet(P^, ['*', '+', '-', '/']) then
  begin
    Operator := P^;
    Inc(P);
    SkipWhiteSpace;
    if not GetNumber(PrefixString, PostfixString, Value2) then Exit;
    if not DoConvert(PrefixString, PostfixString, Value2) then Exit;
    case Operator of
    '*': V := V * Value2;
    '+': V := V + Value2;
    '-': V := V - Value2;
    '/': if Value2 <> 0 then V := V / Value2 else Exit;
    end;
  end;

  if P^ = #0 then Result := True;
end;

procedure TppTBXCustomSpinEditItem.SetAsInteger(AValue: Integer);
begin
  Value := AValue;
end;

procedure TppTBXCustomSpinEditItem.SetDecimal(NewDecimal: TDecimal);
begin
  if NewDecimal <> FDecimal then
  begin
    FDecimal := NewDecimal;
    SetValueEx(GetValue, tcrNumericProperty);
  end;
end;

procedure TppTBXCustomSpinEditItem.SetIncrement(const NewIncrement: Extended);
begin
  if NewIncrement <= 0 then
    raise EPropertyError.Create('Increment should be a positive value');
  FIncrement := NewIncrement;
end;

procedure TppTBXCustomSpinEditItem.SetPostfix(const NewPostfix: string);
begin
  if not ValidateUnits(NewPostfix) then
    raise EPropertyError.Create('Invalid postfix');
  FPostfix := NewPostfix;
  SetValueEx(GetValue, tcrNumericProperty);
end;

procedure TppTBXCustomSpinEditItem.SetPrefix(const NewPrefix: string);
begin
  if not ValidateUnits(NewPrefix) then
    raise EPropertyError.Create('Invalid prefix');
  FPrefix := NewPrefix;
  SetValueEx(GetValue, tcrNumericProperty);
end;

procedure TppTBXCustomSpinEditItem.SetSpaceAfterPrefix(UseSpace: Boolean);
begin
  FSpaceAfterPrefix := UseSpace;
  SetValueEx(GetValue, tcrNumericProperty);
end;

procedure TppTBXCustomSpinEditItem.SetSpaceBeforePostfix(UseSpace: Boolean);
begin
  FSpaceBeforePostfix := UseSpace;
  SetValueEx(GetValue, tcrNumericProperty);
end;

procedure TppTBXCustomSpinEditItem.SetValue(NewValue: Extended);
begin
  SetTextEx(GetAsText(NewValue), tcrNumericProperty);
  if FLastGoodValue <> NewValue then
  begin
    FLastGoodValue := NewValue;
    DoValueChange(NewValue);
  end;
end;

procedure TppTBXCustomSpinEditItem.SetValueEx(NewValue: Extended; Reason: Integer);
begin
  SetTextEx(GetAsText(NewValue), Reason);
  if FLastGoodValue <> NewValue then
  begin
    FLastGoodValue := NewValue;
    DoValueChange(NewValue);
  end;
end;

procedure TppTBXCustomSpinEditItem.SetValueType(NewType: TSEValueType);
var
  V: Extended;
begin
  if NewType <> FValueType then
  begin
    V := GetValue;
    FValueType := NewType;
    SetValueEx(V, tcrNumericProperty);
    if NewType in [evtInteger, evtHex] then FIncrement := Max(Round(FIncrement), 1);
  end;
end;

function TppTBXCustomSpinEditItem.ValidateUnits(const S: string): Boolean;
const
  InvalidChars = [#0..#31, ' ', '*', '+', ',', '-', '.', '/', '0'..'9', '^'];
var
  I: Integer;
begin
  Result := False;
  if Length(S) > 0 then
    for I := 1 to Length(S) do
     if ppCharInset(S[I], InvalidChars) then Exit;
  Result := True;
end;

{ TppTBXSpinEditViewer }

destructor TppTBXSpinEditViewer.Destroy;
begin
  FBtnTimer.Free;
  inherited;
end;

procedure TppTBXSpinEditViewer.GetEditInfo(out EditInfo: TppTBXEditInfo; const ItemInfo: TppTBXItemInfo);
const
  CDisabled: array [Boolean] of Integer = (EBSS_DISABLED, 0);
  CHot: array [Boolean] of Integer = (0, EBSS_HOT);
  CUpDnState: array [TSEBtnState] of Integer = (0, EBSS_UP, EBSS_DOWN);
begin
  inherited GetEditInfo(EditInfo, ItemInfo);
  EditInfo.RightBtnInfo.ButtonType := EBT_SPIN;
  EditInfo.RightBtnInfo.ButtonState := CDisabled[ItemInfo.Enabled] or
    CHot[ItemInfo.HoverKind = hkMouseHover] or CUpDnState[FBtnState];
end;

function TppTBXSpinEditViewer.GetIndentAfter: Integer;
begin
  if IsToolbarStyle then Result := CurrentTheme.EditBtnWidth  + 2
  else Result := GetSystemMetrics(SM_CXMENUCHECK) + 2;
end;

function TppTBXSpinEditViewer.HandleEditMessage(var Message: TMessage): Boolean;
var
  Item: TppTBXCustomSpinEditItem;

  function Val: Extended;
  begin
    if not Item.ParseValue(EditControl.Text, Result) then Result := Item.FLastGoodValue;
  end;

begin
  Item := TppTBXCustomSpinEditItem(Self.Item);
  if Message.Msg = WM_CHAR then
    case TWMChar(Message).CharCode of
      VK_TAB:
        begin
          Item.Value := Val;
          EditControl.Text := Item.Text;
        end;
      VK_RETURN:
        begin
          Item.Value := Val;
          EditControl.Text := Item.Text;
        end;
      VK_ESCAPE:
        begin
//          Item.Value := Item.GetValue;
        end;
    end
  else if Message.Msg = WM_KEYDOWN then
    case TWMKeyDown(Message).CharCode of
      VK_UP:
        begin
          Item.ClickUp;
          EditControl.Text := Item.Text;
          EditControl.SelectAll;
          Result := True;
          Exit;
        end;
      VK_DOWN:
        begin
          Item.ClickDown;
          EditControl.Text := Item.Text;
          EditControl.SelectAll;
          Result := True;
          Exit;
        end;
    end;

  Result := inherited HandleEditMessage(Message);
end;

procedure TppTBXSpinEditViewer.InvalidateButtons;
var
  R: TRect;
begin
  with TppTBXSpinEditItem(Item) do
    if Show and not IsRectEmpty(BoundsRect) then
      begin
        R := BoundsRect;
        R.Left := R.Right - GetIndentAfter;
        InvalidateRect(View.Window.Handle, @R, False);
        Include(State, tbisInvalidated);
      end;
end;

function TppTBXSpinEditViewer.IsPtInButtonPart(X, Y: Integer): Boolean;
begin
  Result := X <= (BoundsRect.Right - BoundsRect.Left) - GetIndentAfter;
end;

procedure TppTBXSpinEditViewer.LosingCapture;
begin
  FBtnTimer.Free;
  FBtnTimer := nil;
  inherited;
end;

procedure TppTBXSpinEditViewer.MouseDown(Shift: TShiftState; X, Y: Integer; var MouseDownOnMenu: Boolean);
begin
  if not Item.Enabled then Exit;
  FBtnState := ebsNone;
  if X >= BoundsRect.Right - BoundsRect.Left - GetIndentAfter then
  begin
    if Y < (BoundsRect.Bottom - BoundsRect.Top) div 2 then
    begin
      FBtnState := ebsUp;
      TppTBXSpinEditItem(Item).ClickUp;
    end
    else
    begin
      FBtnState := ebsDown;
      TppTBXSpinEditItem(Item).ClickDown;
    end;

    if FBtnTimer = nil then
    begin
      FBtnTimer := TTimer.Create(nil);
      FBtnTimer.OnTimer := TimerHandler;
    end;
    FBtnTimer.Interval := SE_FIRSTINTERVAL;
    FBtnTimer.Enabled := True;
  end;

  if FBtnState <> ebsNone then
  begin
    InvalidateButtons;
    inherited;
    View.SetCapture;
  end
  else inherited;
end;

procedure TppTBXSpinEditViewer.MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean);
begin
  if FBtnState <> ebsNone then
  begin
    FBtnState := ebsNone;
    FBtnTimer.Free;
    FBtnTimer := nil;
    InvalidateButtons;
  end;
  inherited;
end;

procedure TppTBXSpinEditViewer.TimerHandler(Sender: TObject);
begin
  FBtnTimer.Interval := SE_INTERVAL;
  if FBtnState = ebsUp then TppTBXSpinEditItem(Item).ClickUp
  else if FBtnState = ebsDown then TppTBXSpinEditItem(Item).ClickDown
  else
  begin
    FBtnTimer.Free;
    FBtnTimer := nil;
  end;
end;

end.
