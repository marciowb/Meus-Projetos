
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumTreeList extended columns                     }
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
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxTLClms;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxTL, Menus, StdCtrls {$IFDEF DELPHI4}, ImgList {$ENDIF}, dxEdStr, dxCalc,
  dxCntner, dxEditor, dxExEdtr, dxGrDate, dxUtils{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxTreeListMemoColumn }
  TdxInplaceTreeListMemoEdit = class(TdxInplaceMemoEdit)
  end;

  TdxTreeListMemoColumn = class(TdxTreeListColumn)
  private
    FHideScrollBars: Boolean;
    FScrollBars: TScrollStyle;
    FSelectionBar: Boolean;
    FWordWrap: Boolean;
    FWantReturns: Boolean;
    FWantTabs: Boolean;
    procedure SetSelectionBar(Value: Boolean);
  protected
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function IsColumnMultiLine: Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property HeaderMaxLineCount default 0;
    property HideScrollBars: Boolean read FHideScrollBars write FHideScrollBars default True;
    property ScrollBars: TScrollStyle read FScrollBars write FScrollBars default ssNone;
    property SelectionBar: Boolean read FSelectionBar write SetSelectionBar default False;
    property WantReturns: Boolean read FWantReturns write FWantReturns default True;
    property WantTabs: Boolean read FWantTabs write FWantTabs default False;
    property WordWrap: Boolean read FWordWrap write FWordWrap default True;
  end;

  { TdxTreeListDropDownColumn }
  TdxInplaceTreeListDropDownEdit = class(TdxInplaceDropDownEdit)
  end;
                           
  TdxTreeListDropDownColumn = class(TdxTreeListColumn)
  private
    FButtonGlyph: TBitmap;
    FDropDownRows: Integer;
    FDropDownWidth: Integer;
    FImmediateDropDown: Boolean;
    FImmediatePopup: Boolean;
    FPopupAlignment: TAlignment;
    FPopupBorder: TdxPopupBorder;
    FShowButtonStyle: TdxShowButtonStyle;
    FOnEditButtonClick: TNotifyEvent;
    function GetButtonGlyph: TBitmap;
    procedure SetButtonGlyph(Value: TBitmap);
    procedure SetShowButtonStyle(Value: TdxShowButtonStyle);
  protected
    procedure DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean); virtual;
    procedure EditButtonClick(Sender: TObject); virtual;
    function GetdxInplaceEditClass : TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean; override;
    function IsShowButton(ANode: TdxTreeListNode): Boolean; virtual;
    function NeedShowButtonEdit(X, Y: Integer; CurNode: Boolean): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
    property ButtonGlyph: TBitmap read GetButtonGlyph write SetButtonGlyph;
    property DropDownRows: Integer read FDropDownRows write FDropDownRows default 7;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property ImmediateDropDown: Boolean read FImmediateDropDown write FImmediateDropDown default False;
    property ImmediatePopup: Boolean read FImmediatePopup write FImmediatePopup default False;
    property PopupAlignment: TAlignment read FPopupAlignment write FPopupAlignment default taLeftJustify;
    property PopupBorder: TdxPopupBorder read FPopupBorder write FPopupBorder default pbDefault;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property ShowButtonStyle: TdxShowButtonStyle read FShowButtonStyle write SetShowButtonStyle default sbDefault;
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick write FOnEditButtonClick;
  end;

  { TdxTreeListDateColumn }
  TdxInplaceTreeListDateEdit = class(TdxInplaceDateEdit)
  public
    property Date;
  end;

  TdxTreeListDateColumn = class(TdxTreeListDropDownColumn)
  private
    FDateButtons: TDateButtons;
    FDateOnError: TDateOnError;
    FDateValidation: Boolean;
    FSaveTime: Boolean;
    FUseEditMask: Boolean;
    FOnDateValidateInput: TdxDateValidateInput;
    procedure DoValidateInput(Sender: TObject; const AText: string;
      var ADate: TDateTime; var AMessage: string; var AError: Boolean);
  protected
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property DateButtons: TDateButtons read FDateButtons write FDateButtons default [btnToday, btnClear];
    property DateOnError: TDateOnError read FDateOnError write FDateOnError default deToday;
    property DateValidation: Boolean read FDateValidation write FDateValidation default False;
    property SaveTime: Boolean read FSaveTime write FSaveTime default True;
    property UseEditMask: Boolean read FUseEditMask write FUseEditMask default False;
    property OnDateValidateInput: TdxDateValidateInput read FOnDateValidateInput write FOnDateValidateInput;
    property ButtonGlyph;
    property PopupAlignment;
    property PopupBorder;
  end;

  { TdxTreeListButtonColumn }
  TdxInplaceTreeListButtonEdit = class(TdxInplaceButtonEdit)
  end;

  TdxTreeListButtonColumn = class(TdxTreeListDropDownColumn)
  private
    FButtonOnly: Boolean;
    FButtons: TdxEditButtons;
    FEditButtonStyle: TdxEditButtonStyle;
    FClickKey: TShortCut;
    FGlyph: TBitmap;
    FHideEditCursor: Boolean;
    FOnButtonClick: TdxEditButtonClickEvent;
    procedure SetButtonOnly(Value: Boolean);
    procedure SetButtons(Value: TdxEditButtons);
    procedure SetEditButtonStyle(Value: TdxEditButtonStyle);
    procedure SetGlyph(Value: TBitmap);
    procedure SetHideEditCursor(Value: Boolean);
  protected
    procedure DoButtonClick(Sender: TObject; AbsoluteIndex: Integer); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property ButtonOnly: Boolean read FButtonOnly write SetButtonOnly default False;
    property Buttons: TdxEditButtons read FButtons write SetButtons;
    property EditButtonStyle: TdxEditButtonStyle read FEditButtonStyle write SetEditButtonStyle default ebsEllipsis;
    property ClickKey: TShortCut read FClickKey write FClickKey default VK_RETURN + scCtrl;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property HideEditCursor: Boolean read FHideEditCursor write SetHideEditCursor default False;
    property OnButtonClick: TdxEditButtonClickEvent read FOnButtonClick write FOnButtonClick;
  end;

  { TdxTreeListCheckColumn }
  TdxInplaceTreeListCheckEdit = class(TdxInplaceCheckEdit)
  public
    property Checked;
    property State;
  end;

  TdxTreeListCheckColumn = class(TdxTreeListColumn)
  private
    FAllowGrayed: Boolean;
    FBorder3D: Boolean;
    FGlyph: TBitmap;
    FGlyphCount: Integer;
    FShowNullFieldStyle: TdxShowNullFieldStyle;
    FValueChecked: string;
    FValueGrayed: string;
    FValueUnchecked: string;
    FOnToggleClick: TdxToggleEvent;
    function GetGlyph: TBitmap;
    procedure SetBorder3D(Value : Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphCount(Value: Integer);
    procedure SetShowNullFieldStyle(Value: TdxShowNullFieldStyle);
    procedure SetValueChecked(const Value: string);
    procedure SetValueGrayed(const Value: string);
    procedure SetValueUnchecked(const Value: string);
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoChange(Sender: TObject); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetMaxRowHeight(ACanvas: TCanvas): Integer; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    function GetCheckBoxState(const AText: string): TdxCheckBoxState;
    function GetCheckBoxValue(AState: TdxCheckBoxState): string;
    function GetDisplayValue(Node: TdxTreeListNode; const Value: string): string; override; // TODO ?
  published
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property Border3D: Boolean read FBorder3D write SetBorder3D default False;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property GlyphCount: Integer read FGlyphCount write SetGlyphCount default 6;
    property MinWidth default 16;
    property ShowNullFieldStyle: TdxShowNullFieldStyle read FShowNullFieldStyle write SetShowNullFieldStyle default nsUnchecked;
    property ValueChecked: string read FValueChecked write SetValueChecked;
    property ValueGrayed: string read FValueGrayed write SetValueGrayed;
    property ValueUnchecked: string read FValueUnchecked write SetValueUnchecked;
    property OnToggleClick: TdxToggleEvent read FOnToggleClick write FOnToggleClick;
  end;

  { TdxTreeListImageColumn }
  TdxInplaceTreeListImageEdit = class(TdxInplaceImageEdit)
  end;

  TdxTLImageColumnCloseUp = procedure(Sender: TObject; var Value: string; var Accept: Boolean) of object;

  TdxTreeListImageColumn = class(TdxTreeListDropDownColumn)
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
    FShowDescription: Boolean;
    FValues: TStrings;
    FOnCloseUp: TdxTLImageColumnCloseUp;
    function GetListWidth: Integer; 
    procedure ImageListChange(Sender: TObject);
    procedure SetDefaultImages(Value: Boolean);
    procedure SetDescriptions(Value: TStrings);
    procedure SetImageIndexes(Value: TStrings);
    procedure SetImages(Value: TImageList);
    procedure SetLargeImages(Value: TImageList);
    procedure SetListWidth(Value: Integer);
    procedure SetMultiLineText(Value: Boolean);
    procedure SetShowDescription(Value : Boolean);
    procedure SetValues(Value : TStrings);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean); override;
    function GetMaxRowHeight(ACanvas: TCanvas): Integer; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetBestFit(ACanvas: TCanvas; ANode: TdxTreeListNode): Integer; override;
    function GetDisplayValue(Node: TdxTreeListNode; const Value: string): string; override; // TODO ?
    function GetImageIndex(const AText: string): Integer;
    procedure GetIndexes(const AText: string; var AImageIndex, ADescIndex: Integer);
    procedure RestoreDefaults; override;
  published
    property Alignment stored True;
    property ButtonGlyph;
    property DefaultImages: Boolean read FDefaultImages write SetDefaultImages default True;
    property Descriptions: TStrings read FDescriptions write SetDescriptions;
    property DropDownRows;
    property DropDownWidth;
    property Images: TImageList read FImages write SetImages;
    property ImageIndexes: TStrings read FImageIndexes write SetImageIndexes;
    property Incremental: Boolean read FIncremental write FIncremental default False;
    property LargeImages: TImageList read FLargeImages write SetLargeImages;
    property ListWidth: Integer read GetListWidth write SetListWidth stored False; // obsolete (use DropDownWidth)
    property MultiLineText: Boolean read FMultiLineText write SetMultiLineText default False;
    property PopupAlignment;
    property PopupBorder;
    property ShowDescription: Boolean read FShowDescription write SetShowDescription default False;
    property Values: TStrings read FValues write SetValues;
    property OnCloseUp: TdxTLImageColumnCloseUp read FOnCloseUp write FOnCloseUp;
  end;

  { TdxTreeListSpinColumn }
  TdxInplaceTreeListSpinEdit = class(TdxInplaceSpinEdit)
  public
    property IntValue;
    property Value;
  end;

  TdxTreeListSpinColumn = class(TdxTreeListColumn)
  private
    FEditorEnabled: Boolean;
    FIncrement: Double;
    FMinValue: Double;
    FMaxValue: Double;
    FShowButtonStyle: TdxShowButtonStyle;
    FUseCtrlIncrement: Boolean;
    FValueType: TdxValueType;
    function IsIncrementStored: Boolean;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    procedure SetShowButtonStyle(Value: TdxShowButtonStyle);
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean; override;
    function IsShowButton(ANode: TdxTreeListNode): Boolean; virtual;
    function NeedShowButtonEdit(X, Y: Integer; CurNode: Boolean): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Increment: Double read FIncrement write FIncrement stored IsIncrementStored;
    property MinValue: Double read FMinValue write FMinValue stored IsMinStored;
    property MaxValue: Double read FMaxValue write FMaxValue stored IsMaxStored;
    property ShowButtonStyle: TdxShowButtonStyle read FShowButtonStyle write SetShowButtonStyle default sbDefault;
    property UseCtrlIncrement: Boolean read FUseCtrlIncrement write FUseCtrlIncrement default False;
    property ValueType: TdxValueType read FValueType write FValueType default vtInt;
  end;

  { TdxTreeListPickColumn }
  TdxInplaceTreeListPickEdit = class(TdxInplacePickEdit)
  public
    property ItemIndex;
  end;
  
  TdxTLPickColumnCloseUp = procedure(Sender: TObject; var Value: Variant; var Accept: Boolean) of object;

  TdxTreeListPickColumn = class(TdxTreeListDropDownColumn)
  private
    FDropDownListStyle: Boolean;
    FItems: TStrings;
    FItemsSorted: Boolean;
    FCanDeleteText: Boolean;
    FRevertable: Boolean;
    FOnCloseUp: TdxTLPickColumnCloseUp;
    procedure SetItems(Value: TStrings);
  protected
    procedure DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property ButtonGlyph;
    property DropDownListStyle: Boolean read FDropDownListStyle write FDropDownListStyle default False;
    property Items: TStrings read FItems write SetItems;
    property ItemsSorted: Boolean read FItemsSorted write FItemsSorted default False;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown default True;
    property CanDeleteText: Boolean read FCanDeleteText write FCanDeleteText default False;
    property PopupAlignment;
    property PopupBorder;
    property Revertable: Boolean read FRevertable write FRevertable default False;
    property OnCloseUp: TdxTLPickColumnCloseUp read FOnCloseUp write FOnCloseUp;
  end;

  { TdxTreeListCalcColumn }
  TdxInplaceTreeListCalcEdit = class(TdxInplaceCalcEdit)
  end;

  TdxTreeListCalcColumn = class(TdxTreeListDropDownColumn)
  private
    FBeepOnError: Boolean;
    FButtonStyle: TdxButtonStyle;
    FPrecision: Byte;
    FQuickClose: Boolean;
    FShowButtonFrame: Boolean;
  protected
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property BeepOnError: Boolean read FBeepOnError write FBeepOnError default True;
    property ButtonGlyph;
    property ButtonStyle: TdxButtonStyle read FButtonStyle write FButtonStyle default bsStandard;
    property PopupAlignment;
    property PopupBorder;
    property Precision: Byte read FPrecision write FPrecision default dxDefCalcPrecision;
    property QuickClose: Boolean read FQuickClose write FQuickClose default False;
    property ShowButtonFrame: Boolean read FShowButtonFrame write FShowButtonFrame default False;
  end;

  { TdxTreeListHyperLinkColumn }
  TdxInplaceTreeListHyperLinkEdit = class(TdxInplaceHyperLinkEdit)
  end;

  TdxTreeListHyperLinkColumn = class(TdxTreeListColumn)
  private
    FEditBackgroundColor: TColor;
    FEditFontColor: TColor;
    FLinkFont: TFont;
    FSingleClick: Boolean;
    FStartKey: TShortCut;
    FOnStartClick: TNotifyEvent;
    procedure PrepareLinkFont;
    procedure SetEditBackgroundColor(Value: TColor);
    procedure SetEditFontColor(Value: TColor);
    procedure SetSingleClick(Value: Boolean);
  protected
    procedure DoStartClick(Sender: TObject); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor); override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
    property LinkFont: TFont read FLinkFont;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property EditBackgroundColor: TColor read FEditBackgroundColor write SetEditBackgroundColor default clWhite;
    property EditFontColor: TColor read FEditFontColor write SetEditFontColor default clBlue;
    property SingleClick: Boolean read FSingleClick write SetSingleClick default False;
    property StartKey: TShortCut read FStartKey write FStartKey default VK_RETURN + scCtrl;
    property OnStartClick: TNotifyEvent read FOnStartClick write FOnStartClick;
  end;

  { TdxTreeListTimeColumn }
  TdxInplaceTreeListTimeEdit = class(TdxInplaceTimeEdit)
  public
    property Time;
  end;

  TdxTreeListTimeColumn = class(TdxTreeListColumn)
  private
    FTimeEditFormat: TdxTimeEditFormat;
    FUseCtrlIncrement: Boolean;
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property TimeEditFormat: TdxTimeEditFormat read FTimeEditFormat write FTimeEditFormat default tfHourMinSec;
    property UseCtrlIncrement: Boolean read FUseCtrlIncrement write FUseCtrlIncrement default False;
  end;

  { TdxTreeListCurrencyColumn }
  TdxInplaceTreeListCurrencyEdit = class(TdxInplaceCurrencyEdit)
  public
    property Value;
  end;

  TdxTreeListCurrencyColumn = class(TdxTreeListColumn)
  private
    FDecimalPlaces: Cardinal;
    FDisplayFormat: string;
    FDisplayFormatStored: Boolean;
    FMinValue: Double;
    FMaxValue: Double;
    FUseThousandSeparator: Boolean;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    procedure SetDisplayFormat(const Value: string);
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property DecimalPlaces: Cardinal read FDecimalPlaces write FDecimalPlaces default 2;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat stored FDisplayFormatStored;
    property MinValue: Double read FMinValue write FMinValue stored IsMinStored;
    property MaxValue: Double read FMaxValue write FMaxValue stored IsMaxStored;
    property UseThousandSeparator: Boolean read FUseThousandSeparator write FUseThousandSeparator default False;
  end;

  { TdxTreeListGraphicColumn }
  TdxInplaceTreeListGraphicEdit = class(TdxInplaceGraphicEdit)
  public
    property ClipboardFormat;
    property Picture;
    property ToolbarPos;
  end;

  TdxGraphicEditGetGraphicClassEvent = procedure(Sender: TObject; Node: TdxTreeListNode; var GraphicClass: TGraphicClass) of object;

  TdxTreeListGraphicColumn = class(TdxTreeListColumn)
  private
    FCenter: Boolean;
    FClipboardFormat: Word;
    FCustomFilter: string;
    FCustomGraphic: Boolean;
    FDblClickActivate: Boolean;
    FGraphicTransparency: TdxGraphicEditTransparency;
    FPicture: TPicture;
    FPopupToolBar: TdxPopupToolBarWindow;
    FPopupToolbarPos: TPoint;
    FPopupToolbarPosStored: Boolean;
    FQuickDraw: Boolean;
    FShadowSelection: Boolean;
    FStretch: Boolean;
    FOnAssignPicture: TdxGraphicEditAssignPictureEvent;
    FOnCustomClick: TNotifyEvent;
    FOnGetGraphicClass: TdxGraphicEditGetGraphicClassEvent;
    procedure LoadPictureFromNode(ANode: TdxTreeListNode);
    procedure SetCenter(Value: Boolean);
    procedure SetCustomGraphic(Value: Boolean);
    procedure SetGraphicTransparency(Value: TdxGraphicEditTransparency);
    procedure SetPopupToolBar(Value: TdxPopupToolBarWindow);
    procedure SetPopupToolbarPosStored(Value: Boolean);
    procedure SetQuickDraw(Value: Boolean);
    procedure SetShadowSelection(Value: Boolean);
    procedure SetStretch(Value: Boolean);
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoAssignPicture(Sender: TObject; var Picture: TPicture);
    procedure DoCustomClick(Sender: TObject);
    procedure DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass);
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetGraphicClass(ANode: TdxTreeListNode): TGraphicClass; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetBestFit(ACanvas: TCanvas; ANode: TdxTreeListNode): Integer; override;
    procedure RestoreDefaults; override;
    property ClipboardFormat: Word read FClipboardFormat write FClipboardFormat;
    property PopupToolbarPos: TPoint read FPopupToolbarPos write FPopupToolbarPos;
  published
    property Center: Boolean read FCenter write SetCenter default True;
    property CustomFilter: string read FCustomFilter write FCustomFilter;
    property CustomGraphic: Boolean read FCustomGraphic write SetCustomGraphic default False;
    property DblClickActivate: Boolean read FDblClickActivate write FDblClickActivate default True;
    property GraphicTransparency: TdxGraphicEditTransparency read FGraphicTransparency write SetGraphicTransparency default gtDefault;
    property HeaderMaxLineCount default 0;
    property PopupToolBar: TdxPopupToolBarWindow read FPopupToolBar write SetPopupToolBar;
    property PopupToolbarPosStored: Boolean read FPopupToolbarPosStored write SetPopupToolbarPosStored default True;
    property QuickDraw: Boolean read FQuickDraw write SetQuickDraw default False;
    property ShadowSelection: Boolean read FShadowSelection write SetShadowSelection default True;
    property Stretch: Boolean read FStretch write SetStretch default True;
    property OnAssignPicture: TdxGraphicEditAssignPictureEvent read FOnAssignPicture write FOnAssignPicture;
    property OnCustomClick: TNotifyEvent read FOnCustomClick write FOnCustomClick;
    property OnGetGraphicClass: TdxGraphicEditGetGraphicClassEvent read FOnGetGraphicClass write FOnGetGraphicClass;
  end;

  { TdxTreeListMRUColumn }
  TdxInplaceTreeListMRUEdit = class(TdxInplaceMRUEdit)
  end;

  TdxTreeListMRUColumn = class(TdxTreeListPickColumn)
  private
    FMaxItemCount: Integer;
    FShowEllipsis: Boolean;
    FOnButtonClick: TNotifyEvent;
    procedure SetShowEllipsis(Value: Boolean);
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoButtonClick(Sender: TObject); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property ImmediateDropDown default False;
    property MaxItemCount: Integer read FMaxItemCount write FMaxItemCount default 7;
    property ShowEllipsis: Boolean read FShowEllipsis write SetShowEllipsis default True;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  end;

  { TdxTreeListBlobColumn }
  TdxInplaceTreeListBlobEdit = class(TdxInplaceBlobEdit)
  public
    property Text;
  end;

  TdxTreeListBlobColumn = class(TdxTreeListDropDownColumn)
  private
    FAlwaysSaveText: Boolean;
    FBlobEditKind: TdxBlobEditKind;
    FBlobPaintStyle: TdxBlobPaintStyle;
    FMaxDisplayLength: Integer;
    FMemoCharCase: TEditCharCase;
    FMemoHideScrollBars: Boolean;
    FMemoMaxLength: Integer;
    FMemoOEMConvert: Boolean;
    FMemoScrollBars: TScrollStyle;
    FMemoSelectionBar: Boolean;
    FMemoWantReturns: Boolean;
    FMemoWantTabs: Boolean;
    FMemoWordWrap: Boolean;
    FPictureAutoSize: Boolean;
    FPictureClipboardFormat: Word;
    FPictureGraphicClass: TGraphicClass;
    FPictureFilter: string;
    FPictureTransparency: TdxGraphicEditTransparency;
    FPopupHeight: Integer;
    FPopupWidth: Integer;
    FShowExPopupItems: Boolean;
    FShowPicturePopup: Boolean;
    FSizeablePopup: Boolean;
    FOnAssignPicture: TdxGraphicEditAssignPictureEvent;
    FOnGetGraphicClass: TdxGraphicEditGetGraphicClassEvent;
    procedure SetBlobEditKind(Value: TdxBlobEditKind);
    procedure SetBlobPaintStyle(Value: TdxBlobPaintStyle);
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoAssignPicture(Sender: TObject; var Picture: TPicture); virtual;
    procedure DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass); virtual;
    procedure DoSavePopupSize(Sender: TObject); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetGraphicClass(ANode: TdxTreeListNode): TGraphicClass; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    property PictureClipboardFormat: Word read FPictureClipboardFormat write FPictureClipboardFormat;
    property PictureGraphicClass: TGraphicClass read FPictureGraphicClass write FPictureGraphicClass;
  published
    property AlwaysSaveText: Boolean read FAlwaysSaveText write FAlwaysSaveText default False;
    property BlobEditKind: TdxBlobEditKind read FBlobEditKind write SetBlobEditKind default bekMemo;
    property BlobPaintStyle: TdxBlobPaintStyle read FBlobPaintStyle write SetBlobPaintStyle default bpsIcon;
    property ImmediatePopup;
    property MaxDisplayLength: Integer read FMaxDisplayLength write FMaxDisplayLength default 255;
    property MemoCharCase: TEditCharCase read FMemoCharCase write FMemoCharCase default ecNormal;
    property MemoHideScrollBars: Boolean read FMemoHideScrollBars write FMemoHideScrollBars default True;
    property MemoMaxLength: Integer read FMemoMaxLength write FMemoMaxLength default 0;
    property MemoOEMConvert: Boolean read FMemoOEMConvert write FMemoOEMConvert default False;
    property MemoScrollBars: TScrollStyle read FMemoScrollBars write FMemoScrollBars default ssBoth;
    property MemoSelectionBar: Boolean read FMemoSelectionBar write FMemoSelectionBar default False;
    property MemoWantReturns: Boolean read FMemoWantReturns write FMemoWantReturns default True;
    property MemoWantTabs: Boolean read FMemoWantTabs write FMemoWantTabs default True;
    property MemoWordWrap: Boolean read FMemoWordWrap write FMemoWordWrap default True;
    property MinWidth default 20;
    property PictureAutoSize: Boolean read FPictureAutoSize write FPictureAutoSize default True;
    property PictureFilter: string read FPictureFilter write FPictureFilter;
    property PictureTransparency: TdxGraphicEditTransparency read FPictureTransparency write FPictureTransparency default gtDefault;
    property PopupAlignment;
    property PopupBorder;
    property PopupHeight: Integer read FPopupHeight write FPopupHeight default 140;
    property PopupWidth: Integer read FPopupWidth write FPopupWidth default 200;
    property ShowExPopupItems: Boolean read FShowExPopupItems write FShowExPopupItems default False;
    property ShowPicturePopup: Boolean read FShowPicturePopup write FShowPicturePopup default False;
    property SizeablePopup: Boolean read FSizeablePopup write FSizeablePopup default True;
    property OnAssignPicture: TdxGraphicEditAssignPictureEvent read FOnAssignPicture write FOnAssignPicture;
    property OnGetGraphicClass: TdxGraphicEditGetGraphicClassEvent read FOnGetGraphicClass write FOnGetGraphicClass;
  end;

  { TdxTreeListWrapperColumn }
  TdxTLGetReferenceColumnEvent = procedure(Sender: TObject; Node: TdxTreeListNode;
    var Column: TdxTreeListColumn) of object;

  TdxTreeListWrapperColumn = class(TdxTreeListColumn)
  private
    FOnGetReferenceColumn: TdxTLGetReferenceColumnEvent;
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor); override;
    function GetViewData: TdxEditViewData; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function NeedShowButtonEdit(X, Y: Integer; IsCurrentNode: Boolean): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
    function ReferenceColumn(ANode: TdxTreeListNode): TdxTreeListWrapperColumn; virtual;
  published
    property OnGetReferenceColumn: TdxTLGetReferenceColumnEvent read FOnGetReferenceColumn write FOnGetReferenceColumn;
  end;

var
  sdxGrCheckTextTrue: string;   //'True'
  sdxGrCheckTextFalse: string;  //'False'

implementation

uses
  Clipbrd;

{ TdxTreeListMemoColumn }
constructor TdxTreeListMemoColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited HeaderMaxLineCount := 0;
  FHideScrollBars := True;
  FWantReturns := True;
  FWordWrap := True;
end;

procedure TdxTreeListMemoColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListMemoColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      ScrollBars := TdxTreeListMemoColumn(Source).ScrollBars;
      WordWrap := TdxTreeListMemoColumn(Source).WordWrap;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListMemoColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FScrollBars := ssNone;
  FWordWrap := True;
  HeaderMaxLineCount := 0;
end;

function TdxTreeListMemoColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListMemoEdit;
end;

procedure TdxTreeListMemoColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMemoEdit then
    with TdxInplaceTreeListMemoEdit(AInplaceEdit) do
    begin
      HideScrollBars := Self.HideScrollBars;
      ScrollBars := Self.ScrollBars;
      SelectionBar := Self.SelectionBar;
      WantReturns := Self.WantReturns;
      WantTabs := Self.WantTabs;
      WordWrap := Self.WordWrap;
    end;
end;

function TdxTreeListMemoColumn.IsColumnMultiLine: Boolean;
begin
  Result := True;
end;

procedure TdxTreeListMemoColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxTextEditViewData then
    with TdxTextEditViewData(AViewData) do
    begin
      SelectionBar := Self.SelectionBar;
    end;
end;

procedure TdxTreeListMemoColumn.SetSelectionBar(Value: Boolean);
begin
  if FSelectionBar <> Value then
  begin
    FSelectionBar := Value;
    Changed(True);
  end;
end;

{ TdxTreeListDropDownColumn }
constructor TdxTreeListDropDownColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropDownRows := 7;
end;

destructor TdxTreeListDropDownColumn.Destroy;
begin
  FButtonGlyph.Free;
  inherited Destroy;
end;

procedure TdxTreeListDropDownColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListDropDownColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DropDownRows := TdxTreeListDropDownColumn(Source).DropDownRows;
      DropDownWidth := TdxTreeListDropDownColumn(Source).DropDownWidth;
      ImmediateDropDown := TdxTreeListDropDownColumn(Source).ImmediateDropDown;
      ImmediatePopup := TdxTreeListDropDownColumn(Source).ImmediatePopup;
      PopupAlignment := TdxTreeListDropDownColumn(Source).PopupAlignment;
      PopupBorder := TdxTreeListDropDownColumn(Source).PopupBorder;
      ShowButtonStyle := TdxTreeListDropDownColumn(Source).ShowButtonStyle;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListDropDownColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDropDownRows := 7;
  FDropDownWidth := 0;
  FImmediateDropDown := False;
  FImmediatePopup := False;
  FPopupAlignment := taLeftJustify;
  FPopupBorder := pbDefault;
  FShowButtonStyle := sbDefault;
end;

procedure TdxTreeListDropDownColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceDropDownEdit then
    with TdxInplaceTreeListDropDownEdit(AInplaceEdit) do
    begin
      ButtonGlyph := Self.FButtonGlyph;
      ImmediateDropDown := Self.ImmediateDropDown;
      DropDownRows := Self.DropDownRows;
      DropDownWidth := Self.DropDownWidth;
      ImmediateDropDown := Self.ImmediateDropDown;
      ImmediatePopup := Self.ImmediatePopup;
      PopupAlignment := Self.PopupAlignment;
      PopupBorder := Self.PopupBorder;
      OnCloseUp := Self.DoCloseUp;
      OnEditButtonClick := Self.EditButtonClick;
    end;
end;

function TdxTreeListDropDownColumn.IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean;
begin
  Result := True;
end;

function TdxTreeListDropDownColumn.IsShowButton(ANode: TdxTreeListNode): Boolean;
begin
  Result := (FShowButtonStyle <> sbNone) and TreeList.IsShowButtonAlways and
    ((FShowButtonStyle = sbAlways) or ANode.Focused);
end;

function TdxTreeListDropDownColumn.NeedShowButtonEdit(X, Y: Integer; CurNode: Boolean): Boolean;
begin
  Result := False;
  if DisableEditor or (FShowButtonStyle = sbNone) then Exit;
  if FShowButtonStyle = sbAlways then
    Result := True
  else Result := CurNode;
end;

procedure TdxTreeListDropDownColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
    if AViewData is TdxDropDownEditViewData then
      with TdxDropDownEditViewData(AViewData) do
      begin
        ButtonGlyph := Self.FButtonGlyph;
        if Assigned(ButtonGlyph) and ButtonGlyph.Empty then
          ButtonGlyph := nil;
        HideButtons := not IsShowButton(ACellViewData.Cell_Node);
        ActiveButtonIndex := -1;
        PressedButtonIndex := -1;
      end;
end;

procedure TdxTreeListDropDownColumn.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
begin
end;

procedure TdxTreeListDropDownColumn.EditButtonClick(Sender: TObject);
begin
  if Assigned(FOnEditButtonClick) then FOnEditButtonClick(Self);
end;

function TdxTreeListDropDownColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListDropDownEdit;
end;

function TdxTreeListDropDownColumn.GetButtonGlyph: TBitmap;
begin
  if FButtonGlyph = nil then FButtonGlyph := TBitmap.Create;
  Result := FButtonGlyph;
end;

procedure TdxTreeListDropDownColumn.SetButtonGlyph(Value: TBitmap);
begin
  if (Value = nil) or Value.Empty then
  begin
    FButtonGlyph.Free;
    FButtonGlyph := nil;
  end
  else
    ButtonGlyph.Assign(Value);
  Changed(False);
end;

procedure TdxTreeListDropDownColumn.SetShowButtonStyle(Value: TdxShowButtonStyle);
begin
  if FShowButtonStyle <> Value then
  begin
    FShowButtonStyle := Value;
    Changed(False);
  end;
end;

{ TdxTreeListDateColumn }
constructor TdxTreeListDateColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDateButtons := [btnToday, btnClear];
  FSaveTime := True;
end;

procedure TdxTreeListDateColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListDateColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DateButtons := TdxTreeListDateColumn(Source).DateButtons;
      DateOnError := TdxTreeListDateColumn(Source).DateOnError;
      DateValidation := TdxTreeListDateColumn(Source).DateValidation;
      SaveTime := TdxTreeListDateColumn(Source).SaveTime;
      UseEditMask := TdxTreeListDateColumn(Source).UseEditMask;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListDateColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDateButtons := [btnToday, btnClear];
  FDateOnError := deToday;
  FDateValidation := False;
  FSaveTime := True;
  FUseEditMask := False;
end;

function TdxTreeListDateColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListDateEdit;
end;

procedure TdxTreeListDateColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceDateEdit then
    with TdxInplaceTreeListDateEdit(AInplaceEdit) do
    begin
      DateButtons := Self.DateButtons;
      DateOnError := Self.DateOnError;
      DateValidation := Self.DateValidation;
      SaveTime := Self.SaveTime;
      UseEditMask := Self.UseEditMask;
      OnDateValidateInput := Self.DoValidateInput;
    end;
end;

procedure TdxTreeListDateColumn.DoValidateInput(Sender: TObject; const AText: string;
  var ADate: TDateTime; var AMessage: string; var AError: Boolean);
begin
  if Assigned(FOnDateValidateInput) then
    FOnDateValidateInput(Self, AText, ADate, AMessage, AError);
end;

{ TdxTreeListButtonColumn }
type
  TdxColumnEditButtons = class(TdxEditButtons)
    procedure Update(Item: TCollectionItem); override;
  end;

procedure TdxColumnEditButtons.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Owner is TdxTreeListButtonColumn then
    (Owner as TdxTreeListButtonColumn).Changed(True);
end;

constructor TdxTreeListButtonColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TdxColumnEditButtons.Create(Self, TdxEditButton);
  FButtons.Add;
  FEditButtonStyle := ebsEllipsis;
  FClickKey := VK_RETURN + scCtrl;
  FGlyph := TBitmap.Create;
end;

destructor TdxTreeListButtonColumn.Destroy;
begin
  FButtons.Free;
  FGlyph.Free;
  inherited Destroy;
end;

procedure TdxTreeListButtonColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListButtonColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      ButtonOnly := TdxTreeListButtonColumn(Source).ButtonOnly;
      Buttons := TdxTreeListButtonColumn(Source).Buttons;
      EditButtonStyle := TdxTreeListButtonColumn(Source).EditButtonStyle;
      ClickKey := TdxTreeListButtonColumn(Source).ClickKey;
      Glyph := TdxTreeListButtonColumn(Source).Glyph;
      HideEditCursor := TdxTreeListButtonColumn(Source).HideEditCursor;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListButtonColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FButtonOnly := False;
  Buttons.RestoreDefaults;
  Buttons.Add;
  FEditButtonStyle := ebsEllipsis;
  FClickKey := VK_RETURN + scCtrl;
  FGlyph.ReleaseHandle;
  FGlyph.Width := 0;
  FGlyph.Height := 0;
  FHideEditCursor := False;
end;

procedure TdxTreeListButtonColumn.DoButtonClick(Sender: TObject; AbsoluteIndex: Integer);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self, AbsoluteIndex);
end;

function TdxTreeListButtonColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListButtonEdit;
end;

procedure TdxTreeListButtonColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceButtonEdit then
    with TdxInplaceTreeListButtonEdit(AInplaceEdit) do
    begin
      Buttons := Self.Buttons;
      ClickKey := Self.ClickKey;
      if ButtonOnly then
        ViewStyle := vsButtonOnly
      else
      if HideEditCursor then
        ViewStyle := vsHideCursor
      else ViewStyle := vsStandard;
      OnButtonClick := Self.DoButtonClick;
    end;
end;

procedure TdxTreeListButtonColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxButtonEditViewData then
    with TdxButtonEditViewData(AViewData) do
    begin
      if not HideButtons then
      begin
        ButtonOnly := Self.ButtonOnly;
        EditButtons := Self.Buttons;
        if EditButtons.Count = 0 then
          ButtonOnly := False;
      end
      else
      begin
        ButtonOnly := False;
        EditButtons := nil;
      end;
      HideEditCursor := Self.HideEditCursor;
    end;
end;

procedure TdxTreeListButtonColumn.SetButtonOnly(Value: Boolean);
begin
  if FButtonOnly <> Value then
  begin
    FButtonOnly := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListButtonColumn.SetButtons(Value: TdxEditButtons);
begin
  Buttons.Assign(Value);
end;

procedure TdxTreeListButtonColumn.SetEditButtonStyle(Value: TdxEditButtonStyle);
const
  BStyle: array [ebsEllipsis..ebsGlyph] of TdxEditButtonKind = (bkEllipsis, bkDown, bkGlyph);
begin
  if FEditButtonStyle <> Value then
  begin
    FEditButtonStyle := Value;
    if FEditButtonStyle = ebsSimple then
      Buttons.Clear
    else
    begin
      if Buttons.Count = 0 then Buttons.Add;
      Buttons[0].Kind := BStyle[FEditButtonStyle];
    end;
    Changed(False);
  end;
end;

procedure TdxTreeListButtonColumn.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
  if Buttons.Count > 0 then
    Buttons[0].Glyph.Assign(FGlyph);
end;

procedure TdxTreeListButtonColumn.SetHideEditCursor(Value: Boolean);
begin
  if FHideEditCursor <> Value then
  begin
    FHideEditCursor := Value;
    Changed(False);
  end;
end;

{ TdxTreeListCheckColumn }
constructor TdxTreeListCheckColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited MinWidth := 16;
  FGlyphCount := 6;
  FValueChecked := sdxGrCheckTextTrue;
  FValueUnchecked := sdxGrCheckTextFalse;
end;

destructor TdxTreeListCheckColumn.Destroy;
begin
  FGlyph.Free;
  inherited Destroy;
end;

procedure TdxTreeListCheckColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListCheckColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      AllowGrayed := TdxTreeListCheckColumn(Source).AllowGrayed;
      Border3D := TdxTreeListCheckColumn(Source).Border3D;
      if TdxTreeListCheckColumn(Source).FGlyph <> nil then
        Glyph := TdxTreeListCheckColumn(Source).Glyph;
      GlyphCount := TdxTreeListCheckColumn(Source).GlyphCount;
      ShowNullFieldStyle := TdxTreeListCheckColumn(Source).ShowNullFieldStyle;
      ValueChecked := TdxTreeListCheckColumn(Source).ValueChecked;
      ValueGrayed := TdxTreeListCheckColumn(Source).ValueGrayed;
      ValueUnChecked := TdxTreeListCheckColumn(Source).ValueUnChecked;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListCheckColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  MinWidth := 16;
  FAllowGrayed := False;
  FBorder3D := False;
  FGlyph.Free;
  FGlyph := nil;
  FGlyphCount := 6;
  FShowNullFieldStyle := nsUnchecked;
  FValueChecked := sdxGrCheckTextTrue;
  FValueGrayed := '';
  FValueUnchecked := sdxGrCheckTextFalse;
end;

function TdxTreeListCheckColumn.GetCheckBoxState(const AText: string): TdxCheckBoxState;
begin
  Result := cbsGrayed;
  if AnsiCompareText(AText, FValueChecked) = 0 then
    Result := cbsChecked
  else
    if AnsiCompareText(AText, FValueUnChecked) = 0 then
      Result := cbsUnchecked;
end;

function TdxTreeListCheckColumn.GetCheckBoxValue(AState: TdxCheckBoxState): string;
begin
  case AState of
    cbsChecked: Result := FValueChecked;
    cbsUnchecked: Result := FValueUnchecked;
  else { cbsGrayed }
    Result := FValueGrayed;
  end;
end;

function TdxTreeListCheckColumn.GetDisplayValue(Node: TdxTreeListNode; const Value: string): string;
begin
  Result := GetCheckBoxValue(GetCheckBoxState(Value));
end;

function TdxTreeListCheckColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceCheckEdit then
    ANode.Strings[Index] := GetCheckBoxValue(TdxInplaceTreeListCheckEdit(AInplaceEdit).State);
  Result := ANode.Values[Index];
end;                             

procedure TdxTreeListCheckColumn.DoChange(Sender: TObject);
var
  AState: TdxCheckBoxState;
begin
  inherited DoChange(Sender);
  if not TreeList.IsInitEdit then
    if (Sender is TdxInplaceCheckEdit) and Assigned(FOnToggleClick) then
    begin
      AState := TdxInplaceTreeListCheckEdit(Sender).State;
      FOnToggleClick(Self, GetCheckBoxValue(AState), AState);
    end;
end;

function TdxTreeListCheckColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListCheckEdit;
end;

function TdxTreeListCheckColumn.GetMaxRowHeight(ACanvas: TCanvas): Integer;
var
  ACheckWidth, ACheckHeight: Integer;
begin
  if (FGlyph <> nil) and TdxInplaceCheckEdit.CalcCheckSize(Glyph, GlyphCount, ACheckWidth, ACheckHeight) then
    Result := ACheckHeight 
  else Result := FCheckHeight + 2;
end;

procedure TdxTreeListCheckColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCheckEdit then
    with TdxInplaceTreeListCheckEdit(AInplaceEdit) do
    begin
      Alignment := taCenter;
      AllowGrayed := Self.AllowGrayed;
      if Border3D then
        Style.ButtonStyle := bts3D
      else Style.ButtonStyle := btsSimple;
      Glyph := Self.Glyph;
      GlyphCount := Self.GlyphCount;
      NullStyle := Self.ShowNullFieldStyle;
    end;
end;

function TdxTreeListCheckColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited InitEditValue(ANode, AInplaceEdit);
  if AInplaceEdit is TdxInplaceCheckEdit then
    with TdxInplaceTreeListCheckEdit(AInplaceEdit) do
      State := GetCheckBoxState(Result);
end;

procedure TdxTreeListCheckColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxCheckEditViewData then
    with TdxCheckEditViewData(AViewData) do
    begin
      Caption := '';
      Data := GetCheckBoxState(Data);
      Alignment := taCenter;
      if Border3D then
        ButtonStyle := bts3D
      else ButtonStyle := btsSimple;
      Glyph := Self.Glyph;
      GlyphCount := Self.GlyphCount;
      NullStyle := Self.ShowNullFieldStyle;
    end;
end;

function TdxTreeListCheckColumn.GetGlyph: TBitmap;
begin
  if FGlyph = nil then
    FGlyph := TBitmap.Create;
  Result := FGlyph;
end;

procedure TdxTreeListCheckColumn.SetBorder3D(Value: Boolean);
begin
  if Border3D <> Value then
  begin
    FBorder3D := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListCheckColumn.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
  begin
    FGlyph.Free;
    FGlyph := nil;
  end
  else
    Glyph.Assign(Value);
  Changed(True);
end;

procedure TdxTreeListCheckColumn.SetGlyphCount(Value: Integer);
begin
  if FGlyphCount <> Value then
  begin
    FGlyphCount := Value;
    if FGlyph <> nil then
      Changed(True);
  end;
end;

procedure TdxTreeListCheckColumn.SetShowNullFieldStyle(Value: TdxShowNullFieldStyle);
begin
  if ShowNullFieldStyle <> Value then
  begin
    FShowNullFieldStyle := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListCheckColumn.SetValueChecked(const Value: String);
begin
  if FValueChecked <> Value then
  begin
    FValueChecked := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListCheckColumn.SetValueGrayed(const Value: string);
begin
  if FValueGrayed <> Value then
  begin
    FValueGrayed := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListCheckColumn.SetValueUnchecked(const Value: string);
begin
  if FValueUnchecked <> Value then
  begin
    FValueUnchecked := Value;
    Changed(True);
  end;
end;

{ TdxTreeListImageColumn }
constructor TdxTreeListImageColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MinWidth := 16;
  Alignment := taLeftJustify;
  FDefaultImages := True;
  FDescriptions := TStringList.Create;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FImageIndexes := TStringList.Create;
  FLargeImageChangeLink := TChangeLink.Create;
  FLargeImageChangeLink.OnChange := ImageListChange;
  FValues := TStringList.Create;
end;

destructor TdxTreeListImageColumn.Destroy;
begin
  FDescriptions.Free;
  FDescriptions := nil;
  FValues.Free;
  FValues := nil;
  FImageIndexes.Free;
  FImageIndexes := nil;
  FImageChangeLink.Free;
  FLargeImageChangeLink.Free;
  inherited Destroy;
end;

procedure TdxTreeListImageColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListImageColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DefaultImages := TdxTreeListImageColumn(Source).DefaultImages;
      Descriptions.Assign(TdxTreeListImageColumn(Source).Descriptions);
      Images := TdxTreeListImageColumn(Source).Images;
      ImageIndexes.Assign(TdxTreeListImageColumn(Source).ImageIndexes);
      Incremental := TdxTreeListImageColumn(Source).Incremental;
      LargeImages := TdxTreeListImageColumn(Source).LargeImages;
      MultiLineText := TdxTreeListImageColumn(Source).MultiLineText;
      ShowDescription := TdxTreeListImageColumn(Source).ShowDescription;
      Values.Assign(TdxTreeListImageColumn(Source).Values);
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxTreeListImageColumn.GetBestFit(ACanvas: TCanvas; ANode: TdxTreeListNode): Integer;
var
  AImageIndex, ADescIndex: Integer;
begin
  Result := 0;
  GetIndexes(ANode.Strings[Index], AImageIndex, ADescIndex);
  if (0 <= ADescIndex) and (ADescIndex < FDescriptions.Count) then
    Result := ACanvas.TextWidth(FDescriptions[ADescIndex]);
  if Images <> nil then
    Inc(Result, Images.Width);
end;

function TdxTreeListImageColumn.GetDisplayValue(Node: TdxTreeListNode; const Value: string): string;
var
  I1, I2: Integer;
begin
  GetIndexes(Value, I1, I2);
  if (0 <= I2) and (I2 < FDescriptions.Count) then
    Result := FDescriptions[I2]
  else Result := Value;
end;

function TdxTreeListImageColumn.GetImageIndex(const AText: string): Integer;
var
  ATempIndex: Integer;
begin
  TdxInplaceImageEdit.CalcViewIndexes(AText,
    ImageIndexes, Descriptions, Values, DefaultImages,
    Result, ATempIndex);
end;

procedure TdxTreeListImageColumn.GetIndexes(const AText: string; var AImageIndex, ADescIndex: Integer);
begin
  TdxInplaceImageEdit.CalcViewIndexes(AText,
    ImageIndexes, Descriptions, Values, DefaultImages,
    AImageIndex, ADescIndex);
end;

procedure TdxTreeListImageColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  MinWidth := 16;
  FDefaultImages := True;
  FIncremental := False;
  FMultiLineText := False;
  FShowDescription := False;
end;

// protected TdxTreeListImageColumn
procedure TdxTreeListImageColumn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = LargeImages then LargeImages := nil;
  end;
end;

procedure TdxTreeListImageColumn.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Value, Accept);
end;

function TdxTreeListImageColumn.GetMaxRowHeight(ACanvas: TCanvas): Integer;
begin
  if Images <> nil then Result := Images.Height
  else Result := 0;
end;

function TdxTreeListImageColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListImageEdit;
end;

procedure TdxTreeListImageColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceImageEdit then
    with TdxInplaceTreeListImageEdit(AInplaceEdit) do
    begin
      DefaultImages := Self.DefaultImages;
      Descriptions := Self.Descriptions;
      Images := Self.Images;
      ImageIndexes := Self.ImageIndexes;
      Incremental := Self.Incremental;
      LargeImages := Self.LargeImages;
      MultiLineText := Self.MultiLineText;
      ShowDescription := Self.ShowDescription;
      Values := Self.Values;
    end;
end;

procedure TdxTreeListImageColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxImageEditViewData then
    with TdxImageEditViewData(AViewData) do
    begin
      if Self.MultilineText then
        DrawAlignment := daMultiLine;
      DefaultImages := Self.DefaultImages;
      Descriptions := Self.Descriptions;
      ImageIndexes := Self.ImageIndexes;
      Images := Self.Images;
      ShowDescription := Self.ShowDescription;
      Values := Self.Values;
    end;
end;

function TdxTreeListImageColumn.GetListWidth: Integer;
begin
  Result := DropDownWidth;
end;

procedure TdxTreeListImageColumn.ImageListChange(Sender: TObject);
begin
  if (Sender = Images) then Changed(True);
end;

procedure TdxTreeListImageColumn.SetDefaultImages(Value: Boolean);
begin
  if DefaultImages <> Value then
  begin
    FDefaultImages := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListImageColumn.SetDescriptions(Value: TStrings);
begin
  FDescriptions.Assign(Value);
  Changed(False);
end;

procedure TdxTreeListImageColumn.SetImageIndexes(Value: TStrings);
begin
  FImageIndexes.Assign(Value);
  Changed(False);
end;

procedure TdxTreeListImageColumn.SetImages(Value: TImageList);
begin
  if Images <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Value <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Value.FreeNotification(Self);
  end;
  Changed(True);
end;

procedure TdxTreeListImageColumn.SetLargeImages(Value: TImageList);
begin
  if LargeImages <> nil then
    LargeImages.UnRegisterChanges(FLargeImageChangeLink);
  FLargeImages := Value;
  if Value <> nil then
  begin
    LargeImages.RegisterChanges(FLargeImageChangeLink);
    Value.FreeNotification(Self);
  end;
  Changed(True);
end;

procedure TdxTreeListImageColumn.SetListWidth(Value: Integer);
begin
  DropDownWidth := Value;
end;

procedure TdxTreeListImageColumn.SetMultiLineText(Value: Boolean);
begin
  if FMultiLineText <> Value then
  begin
    FMultiLineText := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListImageColumn.SetShowDescription(Value: Boolean);
begin
  if ShowDescription <> Value then
  begin
    FShowDescription := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListImageColumn.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
  Changed(False);
end;

{ TdxTreeListSpinColumn }
constructor TdxTreeListSpinColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEditorEnabled := True;
  FIncrement := 1.0;
end;

procedure TdxTreeListSpinColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListSpinColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      EditorEnabled := TdxTreeListSpinColumn(Source).EditorEnabled;
      Increment := TdxTreeListSpinColumn(Source).Increment;
      MinValue := TdxTreeListSpinColumn(Source).MinValue;
      MaxValue := TdxTreeListSpinColumn(Source).MaxValue;
      ShowButtonStyle := TdxTreeListSpinColumn(Source).ShowButtonStyle;
      UseCtrlIncrement := TdxTreeListSpinColumn(Source).UseCtrlIncrement;
      ValueType := TdxTreeListSpinColumn(Source).ValueType;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListSpinColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FEditorEnabled := True;
  FIncrement := 1.0;
  FMinValue := 0.0;
  FMaxValue := 0.0;
  FShowButtonStyle := sbDefault;
  FUseCtrlIncrement := False;
  FValueType := vtInt;
end;

// protected TdxTreeListSpinColumn
function TdxTreeListSpinColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceSpinEdit then
    with TdxInplaceTreeListSpinEdit(AInplaceEdit) do
      if ValueType = vtFloat then
        ANode.Strings[Index] := FloatToStrF(Value, ffGeneral, 15, 0)
      else ANode.Strings[Index] := IntToStr(Round(Value));
  Result := ANode.Values[Index];
end;

function TdxTreeListSpinColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListSpinEdit;
end;

procedure TdxTreeListSpinColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceSpinEdit then
    with TdxInplaceTreeListSpinEdit(AInplaceEdit) do
    begin
      EditorEnabled := Self.EditorEnabled;
      Increment := Self.Increment;
//      MinValue := Self.MinValue;
//      MaxValue := Self.MaxValue;
      SetMinMaxValues(Self.MinValue, Self.MaxValue);
      UseCtrlIncrement := Self.UseCtrlIncrement;
      ValueType := Self.ValueType;
    end;
end;

function TdxTreeListSpinColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited InitEditValue(ANode, AInplaceEdit);
  if AInplaceEdit is TdxInplaceSpinEdit then
    with TdxInplaceTreeListSpinEdit(AInplaceEdit) do
    try
      if Result <> '' then
        Value := StrToFloat(Result)
      else Value := 0;
      Result := Value;
    except
      Value := 0;
    end;
end;

function TdxTreeListSpinColumn.IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean;
begin
  Result := True;
end;

function TdxTreeListSpinColumn.IsShowButton(ANode: TdxTreeListNode): Boolean;
begin
  Result := (FShowButtonStyle <> sbNone) and TreeList.IsShowButtonAlways and
    ((FShowButtonStyle = sbAlways) or ANode.Focused);
end;

function TdxTreeListSpinColumn.NeedShowButtonEdit(X, Y: Integer; CurNode: Boolean): Boolean;
begin
  Result := False;
  if DisableEditor or (FShowButtonStyle = sbNone) then Exit;
  if FShowButtonStyle = sbAlways then
    Result := True
  else Result := CurNode;
end;

procedure TdxTreeListSpinColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
    if AViewData is TdxSpinEditViewData then
      with TdxSpinEditViewData(AViewData) do
      begin
        ShowButton := IsShowButton(ACellViewData.Cell_Node);
      end;  
end;

// private TdxTreeListSpinColumn
function TdxTreeListSpinColumn.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1.0;
end;

function TdxTreeListSpinColumn.IsMaxStored: Boolean;
begin
  Result := FMaxValue <> 0.0;
end;

function TdxTreeListSpinColumn.IsMinStored: Boolean;
begin
  Result := FMinValue <> 0.0;
end;

procedure TdxTreeListSpinColumn.SetShowButtonStyle(Value: TdxShowButtonStyle);
begin
  if FShowButtonStyle <> Value then
  begin
    FShowButtonStyle := Value;
    Changed(False);
  end;
end;

{ TdxTreeListPickColumn }
constructor TdxTreeListPickColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ImmediateDropDown := True;
  FItems := TStringList.Create;
end;

destructor TdxTreeListPickColumn.Destroy;
begin
  FItems.Free;
  FItems := Nil;
  inherited Destroy;
end;

procedure TdxTreeListPickColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListPickColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DropDownListStyle := TdxTreeListPickColumn(Source).DropDownListStyle;
      Items.Assign(TdxTreeListPickColumn(Source).Items);
      CanDeleteText := TdxTreeListPickColumn(Source).CanDeleteText;
      Revertable := TdxTreeListPickColumn(Source).Revertable;
      Sorted := TdxTreeListPickColumn(Source).Sorted;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListPickColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDropDownListStyle := False;
  ImmediateDropDown := True;
  FCanDeleteText := False;
  FRevertable := False;
  FItemsSorted := False;
end;

procedure TdxTreeListPickColumn.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
var
  V: Variant;
begin
  V := Value;
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, V, Accept);
  Value := V;
end;

function TdxTreeListPickColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListPickEdit;
end;

procedure TdxTreeListPickColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplacePickEdit then
    with TdxInplaceTreeListPickEdit(AInplaceEdit) do
    begin
      DropDownListStyle := Self.DropDownListStyle;
      Items := Self.Items;
      CanDeleteText := Self.CanDeleteText; 
      Revertable := Self.Revertable;
      Sorted := Self.ItemsSorted;
    end;
end;

procedure TdxTreeListPickColumn.SetItems(Value : TStrings);
begin
  FItems.Assign(Value);
  Changed(False);
end;

{ TdxTreeListCalcColumn }
constructor TdxTreeListCalcColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBeepOnError := True;
  FPrecision := dxDefCalcPrecision;
end;

procedure TdxTreeListCalcColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListCalcColumn then
  begin
    inherited Assign(Source);
    BeepOnError := TdxTreeListCalcColumn(Source).BeepOnError;
    ButtonStyle := TdxTreeListCalcColumn(Source).ButtonStyle;
    Precision := TdxTreeListCalcColumn(Source).Precision;
    QuickClose := TdxTreeListCalcColumn(Source).QuickClose;
    ShowButtonFrame := TdxTreeListCalcColumn(Source).ShowButtonFrame;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListCalcColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FBeepOnError := True;
  FButtonStyle := bsStandard;
  FPrecision := dxDefCalcPrecision;
  FQuickClose := False;
  FShowButtonFrame := False;
end;

function TdxTreeListCalcColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListCalcEdit;
end;

procedure TdxTreeListCalcColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCalcEdit then
    with TdxInplaceTreeListCalcEdit(AInplaceEdit) do
    begin
      BeepOnError := Self.BeepOnError;
      ButtonStyle := Self.ButtonStyle;
      Precision := Self.Precision;
      QuickClose := Self.QuickClose;
      ShowButtonFrame := Self.ShowButtonFrame;
    end;
end;

{ TdxTreeListHyperLinkColumn }
constructor TdxTreeListHyperLinkColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEditBackgroundColor := clWhite;
  FEditFontColor := clBlue;
  FStartKey := VK_RETURN + scCtrl;
  PrepareLinkFont;
end;

destructor TdxTreeListHyperLinkColumn.Destroy;
begin
  FLinkFont.Free;
  inherited Destroy;
end;

procedure TdxTreeListHyperLinkColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListHyperLinkColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      EditBackgroundColor := TdxTreeListHyperLinkColumn(Source).EditBackgroundColor;
      EditFontColor := TdxTreeListHyperLinkColumn(Source).EditFontColor;
      SingleClick := TdxTreeListHyperLinkColumn(Source).SingleClick;
      StartKey := TdxTreeListHyperLinkColumn(Source).StartKey;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListHyperLinkColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FEditBackgroundColor := clWhite;
  FEditFontColor := clBlue;
  FSingleClick := False;
  FStartKey := VK_RETURN + scCtrl;
end;

procedure TdxTreeListHyperLinkColumn.DoStartClick(Sender: TObject);
begin
  if Assigned(FOnStartClick) then FOnStartClick(Self);
end;

function TdxTreeListHyperLinkColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListHyperLinkEdit;
end;

procedure TdxTreeListHyperLinkColumn.GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor);
begin
  if SingleClick and (ANode.Strings[Index] <> '') then
    ACursor := crdxHandPointCursor; 
end;

procedure TdxTreeListHyperLinkColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceHyperLinkEdit then
    with TdxInplaceTreeListHyperLinkEdit(AInplaceEdit) do
    begin
      Color := Self.EditBackgroundColor;
      LinkColor := Self.EditFontColor;
      SingleClick := Self.SingleClick;
      StartKey := Self.StartKey;
      if Assigned(Self.FOnStartClick) then
        OnStartClick := Self.DoStartClick
      else
        OnStartClick := nil;
    end;
end;

procedure TdxTreeListHyperLinkColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxHyperLinkEditViewData then
    with TdxHyperLinkEditViewData(AViewData) do
    begin
      if not ACellViewData.Cell_Selected and (LinkFont.Color <> clDefault) then
        TextColor := ColorToRGB(LinkFont.Color);
      Font := LinkFont.Handle;
    end;
end;

procedure TdxTreeListHyperLinkColumn.PrepareLinkFont;
begin
  if FLinkFont = nil then
    FLinkFont := TFont.Create;
  FLinkFont.Style := FLinkFont.Style + [fsUnderline];
  if SingleClick then FLinkFont.Color := EditFontColor
  else FLinkFont.Color := clDefault;
end;

procedure TdxTreeListHyperLinkColumn.SetEditBackgroundColor(Value: TColor);
begin
  if FEditBackgroundColor <> Value then
  begin
    FEditBackgroundColor := Value;
    PrepareLinkFont;
    Changed(False);
  end;
end;

procedure TdxTreeListHyperLinkColumn.SetEditFontColor(Value: TColor);
begin
  if FEditFontColor <> Value then
  begin
    FEditFontColor := Value;
    PrepareLinkFont;
    Changed(False);
  end;
end;

procedure TdxTreeListHyperLinkColumn.SetSingleClick(Value: Boolean);
begin
  if FSingleClick <> Value then
  begin
    FSingleClick := Value;
    PrepareLinkFont;
    Changed(False);
  end;
end;

{ TdxTreeListTimeColumn }
procedure TdxTreeListTimeColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListTimeColumn then
  begin
    inherited Assign(Source);
    TimeEditFormat := TdxTreeListTimeColumn(Source).TimeEditFormat;
    UseCtrlIncrement := TdxTreeListTimeColumn(Source).UseCtrlIncrement;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListTimeColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FTimeEditFormat := tfHourMinSec;
  FUseCtrlIncrement := False;
end;

function TdxTreeListTimeColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceTimeEdit then
    with TdxInplaceTreeListTimeEdit(AInplaceEdit) do
      if Time = 0 then
        ANode.Strings[Index] := ''
      else ANode.Strings[Index] := EditText;
  Result := ANode.Values[Index];
end;

function TdxTreeListTimeColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListTimeEdit;
end;

procedure TdxTreeListTimeColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceTimeEdit then
    with TdxInplaceTreeListTimeEdit(AInplaceEdit) do
    begin
      TimeEditFormat := Self.TimeEditFormat;
      UseCtrlIncrement := Self.UseCtrlIncrement;
    end;
end;

{ TdxTreeListCurrencyColumn }
constructor TdxTreeListCurrencyColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDecimalPlaces := 2;
  FDisplayFormat := DefaultCurrencyDisplayFormat;
end;

procedure TdxTreeListCurrencyColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListCurrencyColumn then
  begin
    inherited Assign(Source);
    DecimalPlaces := TdxTreeListCurrencyColumn(Source).DecimalPlaces;
    DisplayFormat := TdxTreeListCurrencyColumn(Source).DisplayFormat;
    MinValue := TdxTreeListCurrencyColumn(Source).MinValue;
    MaxValue := TdxTreeListCurrencyColumn(Source).MaxValue;
    UseThousandSeparator := TdxTreeListCurrencyColumn(Source).UseThousandSeparator;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListCurrencyColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDecimalPlaces := 2;
  FDisplayFormat := DefaultCurrencyDisplayFormat;
  FDisplayFormatStored := False;
  FMinValue := 0.0;
  FMaxValue := 0.0;
  FUseThousandSeparator := False;
end;

function TdxTreeListCurrencyColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceCurrencyEdit then
    with TdxInplaceTreeListCurrencyEdit(AInplaceEdit) do
      if Value = 0 then
        ANode.Strings[Index] := ''
      else ANode.Strings[Index] := EditText;
  Result := ANode.Values[Index];
end;

function TdxTreeListCurrencyColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListCurrencyEdit;
end;

procedure TdxTreeListCurrencyColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCurrencyEdit then
    with TdxInplaceTreeListCurrencyEdit(AInplaceEdit) do
    begin
      DecimalPlaces := Self.DecimalPlaces;
      DisplayFormat := ''; //Self.DisplayFormat;
//      MinValue := Self.MinValue;
//      MaxValue := Self.MaxValue;
      SetMinMaxValues(Self.MinValue, Self.MaxValue);
      UseThousandSeparator := Self.UseThousandSeparator; 
    end;
end;

function TdxTreeListCurrencyColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited InitEditValue(ANode, AInplaceEdit);
  if AInplaceEdit is TdxInplaceCurrencyEdit then
    with TdxInplaceTreeListCurrencyEdit(AInplaceEdit) do
    try
      Text := '';
      if Result <> '' then
        Value := StrToCurr(Result)
      else Value := 0;
      Result := Value;
      if Result = 0 then
        Text := '';
    except
      Value := 0;
    end;
end;

procedure TdxTreeListCurrencyColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
var
  V: Double;
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if FDisplayFormat <> '' then
    with TdxEditViewData(AViewData) do
    begin
      try
        if Data = '' then
          V := 0
        else V := StrToFloat(Data);
        Data := FormatFloat(FDisplayFormat, V)
      except
      end;
    end;
end;

function TdxTreeListCurrencyColumn.IsMaxStored: Boolean;
begin
  Result := FMaxValue <> 0.0;
end;

function TdxTreeListCurrencyColumn.IsMinStored: Boolean;
begin
  Result := FMinValue <> 0.0;
end;

procedure TdxTreeListCurrencyColumn.SetDisplayFormat(const Value: string);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    FDisplayFormatStored := True;
    Changed(True);
  end;
end;

procedure TdxTreeListCurrencyColumn.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  if not Application.UpdateFormatSettings then Exit;
  if not FDisplayFormatStored then
  begin
    SysUtils.GetFormatSettings; // TODO ?
    FDisplayFormat := DefaultCurrencyDisplayFormat;
  end;
end;

{ TdxTreeListGraphicColumn }
constructor TdxTreeListGraphicColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited HeaderMaxLineCount := 0;
  FPicture := TPicture.Create;
  FPopupToolBar := TdxPopupToolBarWindow.Create(nil);
  FPopupToolbarPos := Point(-10000, -10000);
  FCenter := True;
  FClipboardFormat := CF_PICTURE;
  FDblClickActivate := True;
  FPopupToolbarPosStored := True;
  FShadowSelection := True;
  FStretch := True;
end;

destructor TdxTreeListGraphicColumn.Destroy;
begin
  FPopupToolBar.Free;
  FPopupToolBar := nil;
  FPicture.Free;
  FPicture := nil;
  inherited Destroy;
end;

procedure TdxTreeListGraphicColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListGraphicColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      Center := TdxTreeListGraphicColumn(Source).Center;
      CustomFilter := TdxTreeListGraphicColumn(Source).CustomFilter;
      CustomGraphic := TdxTreeListGraphicColumn(Source).CustomGraphic;
      DblClickActivate := TdxTreeListGraphicColumn(Source).DblClickActivate;
      GraphicTransparency := TdxTreeListGraphicColumn(Source).GraphicTransparency;
      PopupToolBar := TdxTreeListGraphicColumn(Source).PopupToolBar;
      PopupToolbarPosStored := TdxTreeListGraphicColumn(Source).PopupToolbarPosStored;
      QuickDraw := TdxTreeListGraphicColumn(Source).QuickDraw;
      ShadowSelection := TdxTreeListGraphicColumn(Source).ShadowSelection;
      Stretch := TdxTreeListGraphicColumn(Source).Stretch;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxTreeListGraphicColumn.GetBestFit(ACanvas: TCanvas; ANode: TdxTreeListNode): Integer;
begin
  Result := 0;
  if not Stretch then
  begin
    LoadPictureFromNode(ANode);
    if not IsPictureEmpty(FPicture) then
      Result := FPicture.Width;
  end;
end;

procedure TdxTreeListGraphicColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  HeaderMaxLineCount := 0;
  FCenter := True;
  FCustomGraphic := False;
  FDblClickActivate := True;
  FGraphicTransparency := gtDefault;
  FPopupToolbarPosStored := True;
  FQuickDraw := False;
  FShadowSelection := True;
  FStretch := True;
end;

function TdxTreeListGraphicColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
var
  S: string;
  APicture: TPicture; 
begin
  if AInplaceEdit is TdxInplaceGraphicEdit then
    with TdxInplaceTreeListGraphicEdit(AInplaceEdit) do
    begin
      APicture := Picture;
      DoAssignPicture(Self, APicture);
      SavePicture(Picture, S);
      ANode.Values[Index] := S;
    end;
  Result := ANode.Values[Index];
end;

procedure TdxTreeListGraphicColumn.DoAssignPicture(Sender: TObject; var Picture: TPicture);
begin
  if Assigned(FOnAssignPicture) then FOnAssignPicture(Self, Picture);
end;

procedure TdxTreeListGraphicColumn.DoCustomClick(Sender: TObject);
begin
  if Assigned(FOnCustomClick) then FOnCustomClick(Self);
end;

procedure TdxTreeListGraphicColumn.DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass);
begin
  GraphicClass := GetGraphicClass(TreeList.FocusedNode)
end;

function TdxTreeListGraphicColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListGraphicEdit;
end;

function TdxTreeListGraphicColumn.GetGraphicClass(ANode: TdxTreeListNode): TGraphicClass;
begin
  Result := nil;
  if Assigned(FOnGetGraphicClass) then FOnGetGraphicClass(Self, ANode, Result);
end;

procedure TdxTreeListGraphicColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceGraphicEdit then
    with TdxInplaceTreeListGraphicEdit(AInplaceEdit) do
    begin
      Center := Self.Center;
      ClipboardFormat := Self.ClipboardFormat;
      CustomFilter := Self.CustomFilter;
      CustomGraphic := Self.CustomGraphic;
      DblClickActivate := Self.DblClickActivate;
      GraphicTransparency := Self.GraphicTransparency;
      ToolbarLayout.Assign(Self.PopupToolBar);
      ToolbarPos := Self.PopupToolbarPos;
      ToolbarPosStored := Self.PopupToolbarPosStored;
      QuickDraw := Self.QuickDraw;
      ShadowSelection := Self.ShadowSelection;
      Stretch := Self.Stretch;
      OnAssignPicture := Self.DoAssignPicture;
      OnCustomClick := Self.DoCustomClick;
      OnGetGraphicClass := Self.DoGetGraphicClass;
    end;
end;

function TdxTreeListGraphicColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited InitEditValue(ANode, AInplaceEdit);
  if AInplaceEdit is TdxInplaceGraphicEdit then
    with TdxInplaceTreeListGraphicEdit(AInplaceEdit) do
    begin
      OffsetSize := Rect(0, 0, 0, 0);  
      Caption := '';
      Result := ANode.Values[Index];
      LoadPicture(Picture, Self.GetGraphicClass(ANode), Result);
    end;
end;

type
  TdxTreeListCracker = class(TCustomdxTreeList);

procedure TdxTreeListGraphicColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxGraphicEditViewData then
    with TdxGraphicEditViewData(AViewData) do
    begin
      LoadPictureFromNode(ACellViewData.Cell_Node);
      if Self.GraphicTransparency <> gtDefault then
      begin
        if not IsPictureEmpty(Self.FPicture) then
          FPicture.Graphic.Transparent := Self.GraphicTransparency = gtTransparent;
      end;
      Picture := Self.FPicture;
      Data := '';
      // Other
      BkColor := ColorToRGB(ACellViewData.Cell_CellColor);
      Brush := ACellViewData.Cell_CellBrush;
      Center := Self.Center;
      DrawShadow := ACellViewData.Cell_Selected and Self.ShadowSelection;
      QuickDraw := Self.QuickDraw;
      ShadowColor := ColorToRGB(ACellViewData.Cell_SelectionColor);
      Stretch := Self.Stretch;
//      TempTransparentBitmap := TdxTreeListCracker(TreeList).DrawBitmap; // TODO
      TempTransparentBitmap := nil;
      TempDrawBitmap := TdxTreeListCracker(TreeList).DrawBitmap; // TODO
      OffsetSize := Rect(0, 0, 0, 0);
    end;
end;

procedure TdxTreeListGraphicColumn.LoadPictureFromNode(ANode: TdxTreeListNode);
begin
  if not (CustomGraphic and (csDesigning in ComponentState)) then
    LoadPicture(FPicture, GetGraphicClass(ANode), ANode.Values[Index])
  else FPicture.Graphic := nil;
end;

procedure TdxTreeListGraphicColumn.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListGraphicColumn.SetCustomGraphic(Value: Boolean);
begin
  if FCustomGraphic <> Value then
  begin
    FCustomGraphic := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListGraphicColumn.SetGraphicTransparency(Value: TdxGraphicEditTransparency);
begin
  if FGraphicTransparency <> Value then
  begin
    FGraphicTransparency := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListGraphicColumn.SetPopupToolBar(Value: TdxPopupToolBarWindow);
begin
  FPopupToolBar.Assign(Value);
end;

procedure TdxTreeListGraphicColumn.SetPopupToolbarPosStored(Value: Boolean);
begin
  FPopupToolbarPosStored := Value;
  if not FPopupToolbarPosStored then
    FPopupToolbarPos := Point(-10000, -10000);
end;

procedure TdxTreeListGraphicColumn.SetQuickDraw(Value: Boolean);
begin
  if FQuickDraw <> Value then
  begin
    FQuickDraw := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListGraphicColumn.SetShadowSelection(Value: Boolean);
begin
  if FShadowSelection <> Value then
  begin
    FShadowSelection := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListGraphicColumn.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Changed(False);
  end;
end;

{ TdxTreeListMRUColumn }
constructor TdxTreeListMRUColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ImmediateDropDown := False;
  FMaxItemCount := 7;
  FShowEllipsis := True;
end;

procedure TdxTreeListMRUColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListMRUColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      MaxItemCount := TdxTreeListMRUColumn(Source).MaxItemCount;
      ShowEllipsis := TdxTreeListMRUColumn(Source).ShowEllipsis;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListMRUColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FMaxItemCount := 7;
  FShowEllipsis := True;
end;

function TdxTreeListMRUColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Items.Assign(TdxInplaceTreeListMRUEdit(AInplaceEdit).Items);
end;

procedure TdxTreeListMRUColumn.DoButtonClick(Sender: TObject);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;

function TdxTreeListMRUColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListMRUEdit;
end;

procedure TdxTreeListMRUColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMRUEdit then
    with TdxInplaceTreeListMRUEdit(AInplaceEdit) do
    begin
      MaxItemCount := Self.MaxItemCount;
      ShowEllipsis := Self.ShowEllipsis;
      OnButtonClick := Self.DoButtonClick;
    end;
end;

procedure TdxTreeListMRUColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxMRUEditViewData then
    with TdxMRUEditViewData(AViewData) do
    begin
      ShowEllipsis := Self.ShowEllipsis;
    end;
end;

procedure TdxTreeListMRUColumn.SetShowEllipsis(Value: Boolean);
begin
  if FShowEllipsis <> Value then
  begin
    FShowEllipsis := Value;
    Changed(True);
  end;
end;

{ TdxTreeListBlobColumn }
constructor TdxTreeListBlobColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBlobPaintStyle := bpsIcon;
  FMaxDisplayLength := 255;
  FMemoHideScrollBars := True;
  FMemoScrollBars := ssBoth;
  FMemoWantReturns := True;
  FMemoWantTabs := True;
  FMemoWordWrap := True;
  FPictureAutoSize := True;
  FPictureClipboardFormat := CF_PICTURE;
  FPopupHeight := 140;
  FPopupWidth := 200;
  FSizeablePopup := True;
  MinWidth := 20;
end;

procedure TdxTreeListBlobColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListBlobColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      AlwaysSaveText := TdxTreeListBlobColumn(Source).AlwaysSaveText;
      BlobEditKind := TdxTreeListBlobColumn(Source).BlobEditKind;
      BlobPaintStyle := TdxTreeListBlobColumn(Source).BlobPaintStyle;
      MaxDisplayLength := TdxTreeListBlobColumn(Source).MaxDisplayLength;
      MemoMaxLength := TdxTreeListBlobColumn(Source).MemoMaxLength;
      MemoCharCase := TdxTreeListBlobColumn(Source).MemoCharCase;
      MemoHideScrollBars := TdxTreeListBlobColumn(Source).MemoHideScrollBars;
      MemoMaxLength := TdxTreeListBlobColumn(Source).MemoMaxLength;
      MemoOEMConvert := TdxTreeListBlobColumn(Source).MemoOEMConvert;
      MemoScrollBars := TdxTreeListBlobColumn(Source).MemoScrollBars;
      MemoSelectionBar := TdxTreeListBlobColumn(Source).MemoSelectionBar;
      MemoWantReturns := TdxTreeListBlobColumn(Source).MemoWantReturns;
      MemoWantTabs := TdxTreeListBlobColumn(Source).MemoWantTabs;
      MemoWordWrap := TdxTreeListBlobColumn(Source).MemoWordWrap;
      PictureAutoSize := TdxTreeListBlobColumn(Source).PictureAutoSize;
      PictureFilter := TdxTreeListBlobColumn(Source).PictureFilter;
      PictureTransparency := TdxTreeListBlobColumn(Source).PictureTransparency;
      PopupHeight := TdxTreeListBlobColumn(Source).PopupHeight;
      PopupWidth := TdxTreeListBlobColumn(Source).PopupWidth;
      ShowExPopupItems := TdxTreeListBlobColumn(Source).ShowExPopupItems;
      ShowPicturePopup := TdxTreeListBlobColumn(Source).ShowPicturePopup;
      SizeablePopup := TdxTreeListBlobColumn(Source).SizeablePopup;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListBlobColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAlwaysSaveText := False;
  FBlobEditKind := bekMemo;
  FBlobPaintStyle := bpsIcon;
  FMaxDisplayLength := 255;
  FMemoCharCase := ecNormal;
  FMemoHideScrollBars := True;
  FMemoMaxLength := 0;
  FMemoOEMConvert := False;
  FMemoScrollBars := ssBoth;
  FMemoSelectionBar := False;
  FMemoWantReturns := True;
  FMemoWantTabs := True;
  FMemoWordWrap := True;
  MinWidth := 20;
  FPictureAutoSize := True;
  FPictureTransparency := gtDefault;
  FPopupHeight := 140;
  FPopupWidth := 200;
  FShowExPopupItems := False;
  FShowPicturePopup := False;
  FSizeablePopup := True;
end;

function TdxTreeListBlobColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceBlobEdit then
    ANode.Strings[Index] := TdxInplaceTreeListBlobEdit(AInplaceEdit).Text;
  Result := ANode.Values[Index];
end;

procedure TdxTreeListBlobColumn.DoAssignPicture(Sender: TObject; var Picture: TPicture);
begin
  if Assigned(FOnAssignPicture) then FOnAssignPicture(Self, Picture);
end;

procedure TdxTreeListBlobColumn.DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass);
begin
  GraphicClass := GetGraphicClass(TreeList.FocusedNode);
end;

procedure TdxTreeListBlobColumn.DoSavePopupSize(Sender: TObject);
begin
  if Sender is TdxInplaceTreeListBlobEdit then
  begin
    PopupWidth := TdxInplaceTreeListBlobEdit(Sender).PopupWidth;
    PopupHeight := TdxInplaceTreeListBlobEdit(Sender).PopupHeight;
  end;
end;

function TdxTreeListBlobColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListBlobEdit;
end;

function TdxTreeListBlobColumn.GetGraphicClass(ANode: TdxTreeListNode): TGraphicClass;
begin
  Result := PictureGraphicClass;
  if Assigned(FOnGetGraphicClass) then FOnGetGraphicClass(Self, ANode, Result);
end;

procedure TdxTreeListBlobColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceBlobEdit then
    with TdxInplaceTreeListBlobEdit(AInplaceEdit) do
    begin
      AlwaysSaveText := Self.AlwaysSaveText;
      BlobEditKind := Self.BlobEditKind;
      BlobPaintStyle := Self.BlobPaintStyle;
      BlobText := TreeList.FocusedNode.Strings[Index]; // TODO
      MemoCharCase := Self.MemoCharCase;
      MemoHideScrollBars := Self.MemoHideScrollBars;
      MemoMaxLength := Self.MemoMaxLength;
      MemoOEMConvert := Self.MemoOEMConvert;
      MemoScrollBars := Self.MemoScrollBars;
      MemoSelectionBar := Self.MemoSelectionBar;
      MemoWantReturns := Self.MemoWantReturns;
      MemoWantTabs := Self.MemoWantTabs;
      MemoWordWrap := Self.MemoWordWrap;
      PictureAutoSize := Self.PictureAutoSize;
      PictureClipboardFormat := Self.PictureClipboardFormat;
      PictureFilter := Self.PictureFilter;
      PictureGraphicClass := Self.PictureGraphicClass;
      PictureTransparency := Self.PictureTransparency;
      PopupHeight := Self.PopupHeight;
      PopupWidth := Self.PopupWidth;
      ShowExPopupItems := Self.ShowExPopupItems;
      ShowPicturePopup := Self.ShowPicturePopup;
      SizeablePopup := Self.SizeablePopup;
      OnAssignPicture := Self.DoAssignPicture;
      OnGetGraphicClass := Self.DoGetGraphicClass;
      OnSavePopupSize := Self.DoSavePopupSize;
    end;
end;

function TdxTreeListBlobColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  inherited InitEditValue(ANode, AInplaceEdit);
  Result := ANode.Strings[Index];
  if AInplaceEdit is TdxInplaceBlobEdit then
    with TdxInplaceTreeListBlobEdit(AInplaceEdit) do
      Text := Result;
end;

procedure TdxTreeListBlobColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxBlobEditViewData then
    with TdxBlobEditViewData(AViewData) do
    begin
      BlobEditKind := Self.BlobEditKind;
      BlobPaintStyle := Self.BlobPaintStyle;
//      BlobText := ACellViewData.Cell_Node.Strings[Index]; // TODO
      Images := imgBlobImages;
      Data := ACellViewData.Cell_Node.Values[Index];
      IsNull := VarIsNull(Data) or ((VarType(Data) = varString) and (Data = ''));
    end;
end;

procedure TdxTreeListBlobColumn.SetBlobEditKind(Value: TdxBlobEditKind);
begin
  if FBlobEditKind <> Value then
  begin
    FBlobEditKind := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListBlobColumn.SetBlobPaintStyle(Value: TdxBlobPaintStyle);
begin
  if BlobPaintStyle <> Value then
  begin
    FBlobPaintStyle := Value;
    Changed(False);
  end;
end;

{ TdxTreeListWrapperColumn }
function TdxTreeListWrapperColumn.ReferenceColumn(ANode: TdxTreeListNode): TdxTreeListWrapperColumn;
begin
  if not Assigned(ANode) and Assigned(TreeList) then
    ANode := TreeList.FocusedNode;
  Result := nil;  
  if Assigned(ANode) and Assigned(FOnGetReferenceColumn) then
    FOnGetReferenceColumn(Self, ANode, TdxTreeListColumn(Result));
end;

function TdxTreeListWrapperColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
var
  C: TdxTreeListWrapperColumn;
begin
  C := ReferenceColumn(ANode);
  if C <> nil then
  begin
    C.FActualIndex := Self.Index;
    try
      Result := C.AssignEditValue(ANode, AInplaceEdit);
    finally
      C.FActualIndex := -1;
    end;
  end
  else
    Result := inherited AssignEditValue(ANode, AInplaceEdit);
end;

function TdxTreeListWrapperColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
var
  C: TdxTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.GetdxInplaceEditClass
  else
    Result := inherited GetdxInplaceEditClass;
end;

procedure TdxTreeListWrapperColumn.GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor);
var
  C: TdxTreeListWrapperColumn;
begin
  C := ReferenceColumn(ANode);
  if C <> nil then
    C.GetHotTrackCursor(ANode, ACursor)
  else
    inherited GetHotTrackCursor(ANode, ACursor);
end;

function TdxTreeListWrapperColumn.GetViewData: TdxEditViewData;
var
  C: TdxTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.GetViewData
  else
    Result := inherited GetViewData;
end;

procedure TdxTreeListWrapperColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
var
  C: TdxTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    C.InitEditProperties(AInplaceEdit)
  else
    inherited InitEditProperties(AInplaceEdit);
end;

function TdxTreeListWrapperColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
var
  C: TdxTreeListWrapperColumn;
begin
  C := ReferenceColumn(ANode);
  if C <> nil then
  begin
    C.FActualIndex := Self.Index;
    try
      Result := C.InitEditValue(ANode, AInplaceEdit);
    finally
      C.FActualIndex := -1;
    end;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxTreeListWrapperColumn.NeedShowButtonEdit(X, Y: Integer; IsCurrentNode: Boolean): Boolean;
var
  C: TdxTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.NeedShowButtonEdit(X, Y, IsCurrentNode)
  else
    Result := inherited NeedShowButtonEdit(X, Y, IsCurrentNode);
end;

procedure TdxTreeListWrapperColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
var
  C: TdxTreeListWrapperColumn;
begin
  C := ReferenceColumn(ACellViewData.Cell_Node);
  if C <> nil then
    C.PrepareViewData(AViewData, ACellViewData)
  else
    inherited PrepareViewData(AViewData, ACellViewData);
end;

initialization
  // load strings
  sdxGrCheckTextTrue := LoadStr(dxSTextTrue);
  sdxGrCheckTextFalse := LoadStr(dxSTextFalse);

  Classes.RegisterClasses([TdxTreeListMemoColumn, TdxTreeListDateColumn,
    TdxTreeListButtonColumn, TdxTreeListCheckColumn, TdxTreeListImageColumn,
    TdxTreeListSpinColumn, TdxTreeListPickColumn, TdxTreeListCalcColumn,
    TdxTreeListHyperLinkColumn, TdxTreeListTimeColumn, TdxTreeListCurrencyColumn,
    TdxTreeListGraphicColumn, TdxTreeListBlobColumn, TdxTreeListMRUColumn,
    TdxTreeListWrapperColumn{TODO}]);

end.
