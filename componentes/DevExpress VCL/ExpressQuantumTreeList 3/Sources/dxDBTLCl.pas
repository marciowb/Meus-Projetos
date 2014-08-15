
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumDBTreeList extended columns                   }
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

unit dxDBTLCl;

interface

{$I dxTLVer.inc}

{$DEFINE FLATCHECKBOX}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, dxTL, Menus, DBCtrls, StdCtrls {$IFDEF DELPHI4}, ImgList {$ENDIF},
  dxEdStr, dxCalc, dxCntner, dxEditor, dxExEdtr, dxDBEdtr, dxDBCtrl, dxUtils,
  dxGrDate, Clipbrd, dxGrFCmn{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  TdxMinMaxColumnValue = (mmcMinValue, mmcMaxValue);
  TdxMinMaxColumnValues = set of TdxMinMaxColumnValue;

  { TdxDBTreeListMemoColumn }
  TdxInplaceDBTreeListMemoEdit = class(TdxInplaceMemoEdit)
  end;

  TdxDBTreeListMemoColumn = class(TdxDBTreeListColumn)
  private
    FMaxDisplayLength: Integer;
    FHideScrollBars: Boolean;
    FScrollBars: TScrollStyle;
    FSelectionBar: Boolean;
    FWordWrap: Boolean;
    FWantReturns: Boolean;
    FWantTabs: Boolean;
    procedure SetSelectionBar(Value: Boolean);
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetDisplayText(ANode: TdxTreeListNode): string; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsBlobColumn: Boolean; override;
    function IsColumnMultiLine: Boolean; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property HeaderMaxLineCount default 0;
    property HideScrollBars: Boolean read FHideScrollBars write FHideScrollBars default True;
    property MaxDisplayLength: Integer read FMaxDisplayLength write {TODO Set and Refresh}FMaxDisplayLength default 255;
    property ScrollBars: TScrollStyle read FScrollBars write FScrollBars default ssNone;
    property SelectionBar: Boolean read FSelectionBar write SetSelectionBar default False;
    property WantReturns: Boolean read FWantReturns write FWantReturns default True;
    property WantTabs: Boolean read FWantTabs write FWantTabs default False;
    property WordWrap: Boolean read FWordWrap write FWordWrap default True;
  end;

  { TdxDBTreeListDropDownColumn }
  TdxInplaceDBTreeListDropDownEdit = class(TdxInplaceDropDownEdit)
  end;

  TdxDBTreeListDropDownColumn = class(TdxDBTreeListColumn)
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
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
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

  { TdxDBTreeListDateColumn }
  TdxInplaceDBTreeListDateEdit = class(TdxInplaceDateEdit)
  public
    property Date;
  end;

  TCustomdxFilterDateEdit = class(TdxInplaceDateEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TdxDBTreeListDateColumn = class(TdxDBTreeListDropDownColumn)
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
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); override;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
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

  { TdxDBTreeListButtonColumn }
  TdxInplaceDBTreeListButtonEdit = class(TdxInplaceButtonEdit)
  end;

  TdxDBTreeListButtonColumn = class(TdxDBTreeListDropDownColumn)
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
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner : TComponent); override;
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

  { TdxDBTreeListCheckColumn }
  TdxInplaceDBTreeListCheckEdit = class(TdxInplaceCheckEdit)
  public
    property Checked;
    property State;
  end;

  TdxDBTreeListCheckColumn = class(TdxDBTreeListColumn)
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
    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); override;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); override;
    function GetMaxRowHeight(ACanvas: TCanvas): Integer; override;
    function GetFilterOperators: TdxDBGridOperatorTypes; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
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
    property OnToggleClick: TdxToggleEvent read FOnToggleClick write FOnToggleClick; // obsolete
  end;

  { TdxDBTreeListImageColumn }
  TdxInplaceDBTreeListImageEdit = class(TdxInplaceImageEdit)
  end;

  TCustomdxFilterImageEdit = class(TdxInplaceImageEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TdxImageColumnCloseUp = procedure(Sender: TObject; var Value: string; var Accept: Boolean) of object; // O

  TdxDBTreeListImageColumn = class(TdxDBTreeListDropDownColumn)
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
    FOnCloseUp: TdxImageColumnCloseUp;
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
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); override;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); override;
    function GetFilterOperators: TdxDBGridOperatorTypes; override;
    function GetMaxRowHeight(ACanvas: TCanvas): Integer; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ConvertExportValue(var Value: Variant; IsHTML: Boolean): Boolean; override;
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
    property OnCloseUp: TdxImageColumnCloseUp read FOnCloseUp write FOnCloseUp;
  end;

  { TdxDBTreeListSpinColumn }
  TdxInplaceDBTreeListSpinEdit = class(TdxInplaceSpinEdit)
  public
    property IntValue;
    property Value;
  end;

  TCustomdxFilterSpinEdit = class(TdxInplaceSpinEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TdxDBTreeListSpinColumn = class(TdxDBTreeListColumn)
  private
    FAssignedValues: TdxMinMaxColumnValues;
    FEditorEnabled: Boolean;
    FIncrement: Double;
    FMinValue: Double;
    FMaxValue: Double;
    FShowButtonStyle: TdxShowButtonStyle;
    FUseCtrlIncrement: Boolean;
    FValueType: TdxValueType;
    function GetMinValue: Double;
    function GetMaxValue: Double;
    function GetValueType: TdxValueType;
    function IsIncrementStored: Boolean;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    procedure SetMinValue(Value: Double);
    procedure SetMaxValue(Value: Double);
    procedure SetShowButtonStyle(Value: TdxShowButtonStyle);
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); override;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
    function IsShowButton(ANode: TdxTreeListNode): Boolean; virtual;
    function NeedShowButtonEdit(X, Y: Integer; CurNode: Boolean): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function DefaultMinValue: Double;
    function DefaultMaxValue: Double;
    procedure RestoreDefaults; override;
    property AssignedValues: TdxMinMaxColumnValues read FAssignedValues;
    property ValueType: TdxValueType read GetValueType;
  published
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Increment: Double read FIncrement write FIncrement stored IsIncrementStored;
    property MinValue: Double read GetMinValue write SetMinValue stored IsMinStored;
    property MaxValue: Double read GetMaxValue write SetMaxValue stored IsMaxStored;
    property ShowButtonStyle: TdxShowButtonStyle read FShowButtonStyle write SetShowButtonStyle default sbDefault;
    property UseCtrlIncrement: Boolean read FUseCtrlIncrement write FUseCtrlIncrement default False;
  end;

  { TdxDBTreeListPickColumn }
  TdxInplaceDBTreeListPickEdit = class(TdxInplacePickEdit)
  public
    property ItemIndex;
  end;

  TCustomdxFilterPickEdit = class(TdxInplacePickEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TdxDBTreeListPickColumn = class(TdxDBTreeListDropDownColumn)
  private
    FDropDownListStyle: Boolean;
    FItems: TStrings;
    FItemsSorted: Boolean;
    FCanDeleteText: Boolean;
    FRevertable: Boolean;
    FOnCloseUp: TdxPickColumnCloseUp;
    procedure SetItems(Value: TStrings);
  protected
    procedure DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
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
    property OnCloseUp: TdxPickColumnCloseUp read FOnCloseUp write FOnCloseUp;
  end;

  { TdxDBTreeListCalcColumn }
  TdxInplaceDBTreeListCalcEdit = class(TdxInplaceCalcEdit)
  end;

  TCustomdxFilterCalcEdit = class(TdxInplaceCalcEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TdxDBTreeListCalcColumn = class(TdxDBTreeListDropDownColumn)
  private
    FBeepOnError: Boolean;
    FButtonStyle: TdxButtonStyle;
    FPrecision: Byte;
    FQuickClose: Boolean;
    FShowButtonFrame: Boolean;
  protected
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetFilterEditClass: TdxInplaceEditClass; override;
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

  { TdxDBTreeListHyperLinkColumn }
  TdxInplaceDBTreeListHyperLinkEdit = class(TdxInplaceHyperLinkEdit)
  end;

  TdxDBTreeListHyperLinkColumn = class(TdxDBTreeListColumn)
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
    procedure FontChanged(Sender: TObject); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor); override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
    property LinkFont: TFont read FLinkFont;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ConvertExportValue(var Value: Variant; IsHTML: Boolean): Boolean; override;
    procedure RestoreDefaults; override;
  published
    property EditBackgroundColor: TColor read FEditBackgroundColor write SetEditBackgroundColor default clWhite;
    property EditFontColor: TColor read FEditFontColor write SetEditFontColor default clBlue;
    property SingleClick: Boolean read FSingleClick write SetSingleClick default False;
    property StartKey: TShortCut read FStartKey write FStartKey default VK_RETURN + scCtrl;
    property OnStartClick: TNotifyEvent read FOnStartClick write FOnStartClick;
  end;

  { TdxDBTreeListTimeColumn }
  TdxInplaceDBTreeListTimeEdit = class(TdxInplaceTimeEdit)
  public
    property Time;
  end;

  TCustomdxFilterTimeEdit = class(TdxInplaceTimeEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TdxDBTreeListTimeColumn = class(TdxDBTreeListColumn)
  private
    FTimeEditFormat: TdxTimeEditFormat;
    FUseCtrlIncrement: Boolean;
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); override;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property TimeEditFormat: TdxTimeEditFormat read FTimeEditFormat write FTimeEditFormat default tfHourMinSec;
    property UseCtrlIncrement: Boolean read FUseCtrlIncrement write FUseCtrlIncrement default False;
  end;

  { TdxDBTreeListCurrencyColumn }
  TdxInplaceDBTreeListCurrencyEdit = class(TdxInplaceCurrencyEdit)
  public
    property Value;
  end;

  TCustomdxFilterCurrencyEdit = class(TdxInplaceCurrencyEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TdxDBTreeListCurrencyColumn = class(TdxDBTreeListColumn)
  private
    FAssignedValues: TdxMinMaxColumnValues;
    FDecimalPlaces: Cardinal;
    FDisplayFormat: string;
    FDisplayFormatStored: Boolean;
    FMinValue: Double;
    FMaxValue: Double;
    FNullable: Boolean;
    FNullString: string;
    FUseThousandSeparator: Boolean;
    function GetMinValue: Double;
    function GetMaxValue: Double;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    procedure SetDisplayFormat(const Value: string);
    procedure SetMinValue(Value: Double);
    procedure SetMaxValue(Value: Double);
    procedure SetNullable(Value: Boolean);
    procedure SetNullString(const Value: string);
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); override;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function DefaultMinValue: Double;
    function DefaultMaxValue: Double;
    function IsValidChar(InputChar: Char): Boolean; override;
    procedure RestoreDefaults; override;
    property AssignedValues: TdxMinMaxColumnValues read FAssignedValues;
  published
    property DecimalPlaces: Cardinal read FDecimalPlaces write FDecimalPlaces default 2;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat stored FDisplayFormatStored;
    property MinValue: Double read GetMinValue write SetMinValue stored IsMinStored;
    property MaxValue: Double read GetMaxValue write SetMaxValue stored IsMaxStored;
    property Nullable: Boolean read FNullable write SetNullable;
    property NullString: string read FNullString write SetNullString;
    property UseThousandSeparator: Boolean read FUseThousandSeparator write FUseThousandSeparator default False;
  end;

  { TdxDBTreeListGraphicColumn }
  TdxInplaceDBTreeListGraphicEdit = class(TdxInplaceGraphicEdit)
  public
    property ClipboardFormat;
    property Picture;
    property ToolbarPos;
  end;

  TdxGraphicEditGetGraphicClassEvent = procedure(Sender: TObject; Node: TdxTreeListNode; var GraphicClass: TGraphicClass) of object;

  TdxDBTreeListGraphicColumn = class(TdxDBTreeListColumn)
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
    function AlwaysStoredValue: Boolean; override;
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoAssignPicture(Sender: TObject; var Picture: TPicture); virtual;
    procedure DoCustomClick(Sender: TObject); virtual;
    procedure DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetGraphicClass(ANode: TdxTreeListNode): TGraphicClass; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsBlobColumn: Boolean; override;
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

  { TdxDBTreeListLookupColumn }
  TdxInplaceDBTreeListLookupEdit = class(TdxInplaceLookupEdit)
  end;

  TCustomdxFilterLookupEdit = class(TdxInplaceLookupEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  TdxDBTreeListLookupColumn = class(TdxDBTreeListDropDownColumn)
  private
    FClearKey: TShortCut;
    FListFieldIndex: Integer;
    FListFieldName: string;
    FCanDeleteText: Boolean;
    FOnCloseUp: TdxPickColumnCloseUp;
    function GetListWidth: Integer; 
    procedure SetListWidth(Value: Integer);
  protected
    procedure DoCloseUp(Sender: TObject; var Value: Variant; var Accept: Boolean); {$IFDEF DELPHI4} reintroduce {$ELSE} virtual {$ENDIF};
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetFilterEditClass: TdxInplaceEditClass; override;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); override;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); override;
    function GetFilterOperators: TdxDBGridOperatorTypes; override;
    function GetFilterValue(ANode: TdxTreeListNode): Variant; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property ButtonGlyph;
    property ClearKey: TShortCut read FClearKey write FClearKey default 0;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown;
    property ListFieldName: string read FListFieldName write FListFieldName; 
    property ListFieldIndex: Integer read FListFieldIndex write FListFieldIndex default 0; // obsolete
    property ListWidth: Integer read GetListWidth write SetListWidth stored False; // obsolete (use DropDownWidth)
    property CanDeleteText: Boolean read FCanDeleteText write FCanDeleteText default False;
    property PopupAlignment;
    property PopupBorder;
    property OnCloseUp: TdxPickColumnCloseUp read FOnCloseUp write FOnCloseUp;
  end;

  { TdxDBTreeListBlobColumn }
  TdxInplaceDBTreeListBlobEdit = class(TdxInplaceBlobEdit)
  end;

  TdxDBTreeListBlobColumn = class(TdxDBTreeListDropDownColumn)
  private
    FAlwaysSaveText: Boolean;
    FBlobKind: TdxBlobKind;
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
    procedure SetBlobKind(Value: TdxBlobKind);
    procedure SetBlobPaintStyle(Value: TdxBlobPaintStyle);
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoAssignPicture(Sender: TObject; var Picture: TPicture); virtual;
    procedure DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass); virtual;
    procedure DoSavePopupSize(Sender: TObject); virtual;
    function GetDisplayText(ANode: TdxTreeListNode): string; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetGraphicClass(ANode: TdxTreeListNode): TGraphicClass; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsBlobColumn: Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    property PictureClipboardFormat: Word read FPictureClipboardFormat write FPictureClipboardFormat;
    property PictureGraphicClass: TGraphicClass read FPictureGraphicClass write FPictureGraphicClass;
  published
    property AlwaysSaveText: Boolean read FAlwaysSaveText write FAlwaysSaveText default False;
    property BlobKind: TdxBlobKind read FBlobKind write SetBlobKind default bkAuto;
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

  { TdxDBTreeListMRUColumn }
  TdxInplaceDBTreeListMRUEdit = class(TdxInplaceMRUEdit)
  end;

  TdxDBTreeListMRUColumn = class(TdxDBTreeListPickColumn)
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

  { TdxDBTreeListWrapperColumn }
  TdxDBTLGetReferenceColumnEvent = procedure(Sender: TObject; Node: TdxTreeListNode;
    var Column: TdxDBTreeListColumn) of object;

  TdxDBTreeListWrapperColumn = class(TdxDBTreeListColumn)
  private
    FOnGetReferenceColumn: TdxDBTLGetReferenceColumnEvent;
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor); override;
    function GetViewData: TdxEditViewData; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function NeedShowButtonEdit(X, Y: Integer; IsCurrentNode: Boolean): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); override;
    // DB
    function AlwaysStoredValue: Boolean; override;
    procedure AssignNodeValues(ANode: TdxDBTreeListControlNode); override;
    function GetDisplayText(ANode: TdxTreeListNode): string; override;
    function GetText(const Value: Variant): string; override;
    function IsBlobColumn: Boolean; override;
    function IsEqualValues(const Value: Variant): Boolean; override;
    function ReferenceColumn(ANode: TdxTreeListNode): TdxDBTreeListWrapperColumn; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure RestoreDefaults; override;
  published
    property OnGetReferenceColumn: TdxDBTLGetReferenceColumnEvent read FOnGetReferenceColumn write FOnGetReferenceColumn;
  end;

var
  sdxGrCheckTextTrue: string;   //'True'
  sdxGrCheckTextFalse: string;  //'False'

implementation

{ TdxDBTreeListMemoColumn }
constructor TdxDBTreeListMemoColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited HeaderMaxLineCount := 0;
  DisableFilter := True;
  FHideScrollBars := True;
  FMaxDisplayLength := 255;
  FWantReturns := True;
  FWordWrap := True;
end;

procedure TdxDBTreeListMemoColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListMemoColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      MaxDisplayLength := TdxDBTreeListMemoColumn(Source).MaxDisplayLength;
      ScrollBars := TdxDBTreeListMemoColumn(Source).ScrollBars;
      WordWrap := TdxDBTreeListMemoColumn(Source).WordWrap;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListMemoColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  DisableFilter := True;
  FMaxDisplayLength := 255;
  FScrollBars := ssNone;
  FWordWrap := True;
  HeaderMaxLineCount := 0;
end;

function TdxDBTreeListMemoColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceMemoEdit) then
    Field.AsString := TdxInplaceDBTreeListMemoEdit(AInplaceEdit).Text
  else Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Result := ANode.Values[Index];
end;

function TdxDBTreeListMemoColumn.GetDisplayText(ANode: TdxTreeListNode): string; // O
begin
  if Assigned(Field) then
  begin
    if MaxDisplayLength < 0 then Result := Field.AsString
    else Result := Copy(Field.AsString, 1, MaxDisplayLength{255})
  end
  else
    Result := inherited GetDisplayText(ANode);
end;

function TdxDBTreeListMemoColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListMemoEdit;
end;

procedure TdxDBTreeListMemoColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMemoEdit then
    with TdxInplaceDBTreeListMemoEdit(AInplaceEdit) do
    begin
      HideScrollBars := Self.HideScrollBars;
      ScrollBars := Self.ScrollBars;
      SelectionBar := Self.SelectionBar;
      WantReturns := Self.WantReturns;
      WantTabs := Self.WantTabs;
      WordWrap := Self.WordWrap;
    end;
end;

function TdxDBTreeListMemoColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceMemoEdit) then
  begin
    TdxInplaceDBTreeListMemoEdit(AInplaceEdit).Text := Field.AsString;
    Result := TdxInplaceDBTreeListMemoEdit(AInplaceEdit).Text;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListMemoColumn.IsBlobColumn: Boolean;
begin
  Result := True;
end;

function TdxDBTreeListMemoColumn.IsColumnMultiLine: Boolean;
begin
  Result := True;
end;

function TdxDBTreeListMemoColumn.IsEqualValues(const Value: Variant): Boolean;
begin
  if Assigned(Field) then
    Result := Field.AsString = Value
  else
    Result := inherited IsEqualValues(Value);
end;

procedure TdxDBTreeListMemoColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxTextEditViewData then
    with TdxTextEditViewData(AViewData) do
    begin
      SelectionBar := Self.SelectionBar;
    end;
end;

procedure TdxDBTreeListMemoColumn.SetSelectionBar(Value: Boolean);
begin
  if FSelectionBar <> Value then
  begin
    FSelectionBar := Value;
    Changed(True);
  end;
end;

{ TdxDBTreeListDropDownColumn }
constructor TdxDBTreeListDropDownColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropDownRows := 7;
end;

destructor TdxDBTreeListDropDownColumn.Destroy;
begin
  FButtonGlyph.Free;
  inherited Destroy;
end;

procedure TdxDBTreeListDropDownColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListDropDownColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DropDownRows := TdxDBTreeListDropDownColumn(Source).DropDownRows;
      DropDownWidth := TdxDBTreeListDropDownColumn(Source).DropDownWidth;
      ImmediateDropDown := TdxDBTreeListDropDownColumn(Source).ImmediateDropDown;
      ImmediatePopup := TdxDBTreeListDropDownColumn(Source).ImmediatePopup;
      PopupAlignment := TdxDBTreeListDropDownColumn(Source).PopupAlignment;
      PopupBorder := TdxDBTreeListDropDownColumn(Source).PopupBorder;
      ShowButtonStyle := TdxDBTreeListDropDownColumn(Source).ShowButtonStyle;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListDropDownColumn.RestoreDefaults;
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

procedure TdxDBTreeListDropDownColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceDropDownEdit then
    with TdxInplaceDBTreeListDropDownEdit(AInplaceEdit) do
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

function TdxDBTreeListDropDownColumn.IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean;
begin
  Result := True;
end;

function TdxDBTreeListDropDownColumn.IsShowButton(ANode: TdxTreeListNode): Boolean;
begin
  Result := (FShowButtonStyle <> sbNone) and TreeList.IsShowButtonAlways and
    ((FShowButtonStyle = sbAlways) or (Assigned(ANode) and ANode.Focused));
end;

function TdxDBTreeListDropDownColumn.NeedShowButtonEdit(X, Y: Integer; CurNode: Boolean): Boolean;
begin
  Result := False;
  if DisableEditor or (FShowButtonStyle = sbNone) then Exit;
  if FShowButtonStyle = sbAlways then
    Result := True
  else Result := CurNode;
end;

procedure TdxDBTreeListDropDownColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if AEdit is TdxInplaceDropDownEdit then
    with TdxInplaceDBTreeListDropDownEdit(AEdit) do
    begin
      OnCloseUp := nil;
      OnEditButtonClick := nil;
    end;
end;

procedure TdxDBTreeListDropDownColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
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

procedure TdxDBTreeListDropDownColumn.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
begin
end;

procedure TdxDBTreeListDropDownColumn.EditButtonClick(Sender: TObject);
begin
  if Assigned(FOnEditButtonClick) then FOnEditButtonClick(Self);
end;

function TdxDBTreeListDropDownColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListDropDownEdit;
end;

function TdxDBTreeListDropDownColumn.GetButtonGlyph: TBitmap;
begin
  if FButtonGlyph = nil then FButtonGlyph := TBitmap.Create;
  Result := FButtonGlyph;
end;

procedure TdxDBTreeListDropDownColumn.SetButtonGlyph(Value: TBitmap);
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

procedure TdxDBTreeListDropDownColumn.SetShowButtonStyle(Value: TdxShowButtonStyle);
begin
  if FShowButtonStyle <> Value then
  begin
    FShowButtonStyle := Value;
    Changed(False);
  end;
end;

{ TdxDBTreeListDateColumn }
class function TCustomdxFilterDateEdit.IsInplace: Boolean;
begin
  Result := False;
end;

constructor TdxDBTreeListDateColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDateButtons := [btnToday, btnClear];
  FSaveTime := True;
end;

procedure TdxDBTreeListDateColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListDateColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DateButtons := TdxDBTreeListDateColumn(Source).DateButtons;
      DateOnError := TdxDBTreeListDateColumn(Source).DateOnError;
      DateValidation := TdxDBTreeListDateColumn(Source).DateValidation;
      SaveTime := TdxDBTreeListDateColumn(Source).SaveTime;
      UseEditMask := TdxDBTreeListDateColumn(Source).UseEditMask;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListDateColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDateButtons := [btnToday, btnClear];
  FDateOnError := deToday;
  FDateValidation := False;
  FSaveTime := True;
  FUseEditMask := False;
end;

function TdxDBTreeListDateColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceDateEdit) then
  begin
    if TdxInplaceDBTreeListDateEdit(AInplaceEdit).Date = NullDate then
      Field.Clear
    else Field.AsFloat{AsDateTime} := TdxInplaceDBTreeListDateEdit(AInplaceEdit).Date; // incorrect DB.DateTimeField
  end  
  else Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Result := ANode.Values[Index];
end;

function TdxDBTreeListDateColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListDateEdit;
end;

function TdxDBTreeListDateColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterDateEdit;
end;

procedure TdxDBTreeListDateColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
begin
  if AEdit is TdxInplaceDateEdit then
    with TdxInplaceDBTreeListDateEdit(AEdit) do
    begin
      if Date = NullDate then
        V := Null
      else
        V := Date;
      S := Text;
    end
  else
    inherited GetFilterEditValues(AEdit, V, S);
end;

procedure TdxDBTreeListDateColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
  if AEdit is TCustomdxFilterDateEdit then
  begin
    if VarIsNull(V) then
      TCustomdxFilterDateEdit(AEdit).Date := NullDate
    else
      TCustomdxFilterDateEdit(AEdit).Date := V;
  end
  else
    inherited SetFilterEditValue(AEdit, V);
end;

procedure TdxDBTreeListDateColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceDateEdit then
    with TdxInplaceDBTreeListDateEdit(AInplaceEdit) do
    begin
      DateButtons := Self.DateButtons;
      DateOnError := Self.DateOnError;
      DateValidation := Self.DateValidation;
      SaveTime := Self.SaveTime;
      UseEditMask := Self.UseEditMask;
      OnDateValidateInput := Self.DoValidateInput;
    end;
end;

function TdxDBTreeListDateColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceDateEdit) then
  begin
    if Field.IsNull then
      TdxInplaceDBTreeListDateEdit(AInplaceEdit).Date := NullDate
    else
      TdxInplaceDBTreeListDateEdit(AInplaceEdit).Date := Field.AsFloat{AsDateTime}; // incorrect DB.DateTimeField
    Result := TdxInplaceDBTreeListDateEdit(AInplaceEdit).Date;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListDateColumn.IsEqualValues(const Value: Variant): Boolean;
var
  D: TDateTime;
begin
  D := TDateTime(Value); 
  if Assigned(Field) then
    if Field.IsNull and (D = NullDate) then
      Result := True
    else  
      Result := Field.AsFloat{AsDateTime} = D //incorrect DB.DateTimeField
  else
    Result := inherited IsEqualValues(Value);
end;

procedure TdxDBTreeListDateColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if AEdit is TdxInplaceDateEdit then
    with TdxInplaceDBTreeListDateEdit(AEdit) do
    begin
      OnDateValidateInput := nil;
    end;
end;

procedure TdxDBTreeListDateColumn.DoValidateInput(Sender: TObject; const AText: string;
  var ADate: TDateTime; var AMessage: string; var AError: Boolean);
begin
  if Assigned(FOnDateValidateInput) then
    FOnDateValidateInput(Self, AText, ADate, AMessage, AError);
end;

{ TdxDBTreeListButtonColumn }
type
  TdxColumnEditButtons = class(TdxEditButtons)
    procedure Update(Item: TCollectionItem); override;
  end;

procedure TdxColumnEditButtons.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Owner is TdxDBTreeListButtonColumn then
    (Owner as TdxDBTreeListButtonColumn).Changed(True);
end;

constructor TdxDBTreeListButtonColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TdxColumnEditButtons.Create(Self, TdxEditButton);
  FButtons.Add;
  FEditButtonStyle := ebsEllipsis;
  FClickKey := VK_RETURN + scCtrl;
  FGlyph := TBitmap.Create;
end;

destructor TdxDBTreeListButtonColumn.Destroy;
begin
  FButtons.Free;
  FGlyph.Free;
  inherited Destroy;
end;

procedure TdxDBTreeListButtonColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListButtonColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      ButtonOnly := TdxDBTreeListButtonColumn(Source).ButtonOnly;
      Buttons := TdxDBTreeListButtonColumn(Source).Buttons;
      EditButtonStyle := TdxDBTreeListButtonColumn(Source).EditButtonStyle;
      ClickKey := TdxDBTreeListButtonColumn(Source).ClickKey;
      Glyph := TdxDBTreeListButtonColumn(Source).Glyph;
      HideEditCursor := TdxDBTreeListButtonColumn(Source).HideEditCursor;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListButtonColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FButtonOnly := False;
  Buttons.RestoreDefaults;
  Buttons.Clear;
  Buttons.Add;
  FEditButtonStyle := ebsEllipsis;
  FClickKey := VK_RETURN + scCtrl;
  FGlyph.ReleaseHandle;
  FGlyph.Width := 0;
  FGlyph.Height := 0;
  FHideEditCursor := False;
end;

procedure TdxDBTreeListButtonColumn.DoButtonClick(Sender: TObject; AbsoluteIndex: Integer);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self, AbsoluteIndex);
end;

function TdxDBTreeListButtonColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListButtonEdit;
end;

procedure TdxDBTreeListButtonColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceButtonEdit then
    with TdxInplaceDBTreeListButtonEdit(AInplaceEdit) do
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

procedure TdxDBTreeListButtonColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if AEdit is TdxInplaceButtonEdit then
    with TdxInplaceDBTreeListButtonEdit(AEdit) do
    begin
      OnButtonClick := nil;
    end;
end;

procedure TdxDBTreeListButtonColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
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

procedure TdxDBTreeListButtonColumn.SetButtonOnly(Value: Boolean);
begin
  if FButtonOnly <> Value then
  begin
    FButtonOnly := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListButtonColumn.SetButtons(Value: TdxEditButtons);
begin
  Buttons.Assign(Value);
end;

procedure TdxDBTreeListButtonColumn.SetEditButtonStyle(Value: TdxEditButtonStyle);
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

procedure TdxDBTreeListButtonColumn.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
  if Buttons.Count > 0 then
    Buttons[0].Glyph.Assign(FGlyph);
end;

procedure TdxDBTreeListButtonColumn.SetHideEditCursor(Value: Boolean);
begin
  if FHideEditCursor <> Value then
  begin
    FHideEditCursor := Value;
    Changed(False);
  end;
end;

{ TdxDBTreeListCheckColumn }
constructor TdxDBTreeListCheckColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited MinWidth := 16;
  FGlyphCount := 6;
  FValueChecked := sdxGrCheckTextTrue;
  FValueUnchecked := sdxGrCheckTextFalse;
end;

destructor TdxDBTreeListCheckColumn.Destroy;
begin
  FGlyph.Free;
  inherited Destroy;
end;

procedure TdxDBTreeListCheckColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListCheckColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      AllowGrayed := TdxDBTreeListCheckColumn(Source).AllowGrayed;
      Border3D := TdxDBTreeListCheckColumn(Source).Border3D;
      if TdxDBTreeListCheckColumn(Source).FGlyph <> nil then
        Glyph := TdxDBTreeListCheckColumn(Source).Glyph;
      GlyphCount := TdxDBTreeListCheckColumn(Source).GlyphCount;
      ShowNullFieldStyle := TdxDBTreeListCheckColumn(Source).ShowNullFieldStyle;
      ValueChecked := TdxDBTreeListCheckColumn(Source).ValueChecked;
      ValueGrayed := TdxDBTreeListCheckColumn(Source).ValueGrayed;
      ValueUnChecked := TdxDBTreeListCheckColumn(Source).ValueUnChecked;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListCheckColumn.RestoreDefaults;
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

function TdxDBTreeListCheckColumn.GetCheckBoxState(const AText: string): TdxCheckBoxState;
begin
  Result := cbsGrayed;
  if AnsiCompareText(AText, FValueChecked) = 0 then
    Result := cbsChecked
  else
    if AnsiCompareText(AText, FValueUnChecked) = 0 then
      Result := cbsUnchecked;
end;

function TdxDBTreeListCheckColumn.GetCheckBoxValue(AState: TdxCheckBoxState): string;
begin
  case AState of
    cbsChecked: Result := FValueChecked;
    cbsUnchecked: Result := FValueUnchecked;
  else { cbsGrayed }
    Result := FValueGrayed;
  end;
end;

function TdxDBTreeListCheckColumn.GetDisplayValue(Node: TdxTreeListNode; const Value: string): string;
begin
  Result := GetCheckBoxValue(GetCheckBoxState(Value));
end;

function TdxDBTreeListCheckColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceCheckEdit) then
    Field.Text := GetCheckBoxValue(TdxInplaceDBTreeListCheckEdit(AInplaceEdit).State)
  else Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Result := ANode.Values[Index];
end;

procedure TdxDBTreeListCheckColumn.DoChange(Sender: TObject);
var
  AState: TdxCheckBoxState;
begin
  inherited DoChange(Sender);
  if not TreeList.IsInitEdit then
    if (Sender is TdxInplaceCheckEdit) and Assigned(FOnToggleClick) then
    begin
      AState := TdxInplaceDBTreeListCheckEdit(Sender).State;
      FOnToggleClick(Self, GetCheckBoxValue(AState), AState);
    end;
end;

function TdxDBTreeListCheckColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListCheckEdit;
end;

function TdxDBTreeListCheckColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterImageEdit;
end;

procedure TdxDBTreeListCheckColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
var
  I, J: Integer;
begin
  inherited GetFilterEditValues(AEdit, V, S);
//  if (VarType(V) = varString) and (V = FValueGrayed) then
//    V := Null;
  if VarType(V) = varString then
  begin
    if Assigned(Field) and (Field.DataType = ftBoolean) then
    begin
      if AnsiCompareText(V, FValueChecked) = 0 then
        V := True
      else
        if AnsiCompareText(V, FValueUnChecked) = 0 then
          V := False
        else
          V := Null
    end
    else
      if AnsiCompareText(V, FValueGrayed) = 0 then
        V := Null;
  end;
  if AEdit is TCustomdxFilterImageEdit then // TODO in new ver Convert with Edit
    with TCustomdxFilterImageEdit(AEdit) do
    begin
      CalcViewIndexes(S, ImageIndexes, Descriptions, Values, DefaultImages, I, J);
      if J <> -1 then
        S := Descriptions[J];
    end;
end;

procedure TdxDBTreeListCheckColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
  if AEdit is TCustomdxFilterImageEdit then
  begin
    if VarIsNull(V) then
      TCustomdxFilterImageEdit(AEdit).Text := FValueGrayed
    else
      if VarType(V) = varBoolean then
      begin
        if V then
          TCustomdxFilterImageEdit(AEdit).Text := FValueChecked {'True'}
        else
          TCustomdxFilterImageEdit(AEdit).Text := FValueUnchecked {'False'};
      end
      else
        TCustomdxFilterImageEdit(AEdit).Text := V;
  end
  else
    inherited SetFilterEditValue(AEdit, V);
end;

function TdxDBTreeListCheckColumn.GetMaxRowHeight(ACanvas: TCanvas): Integer;
var
  ACheckWidth, ACheckHeight: Integer;
begin
  if (FGlyph <> nil) and TdxInplaceCheckEdit.CalcCheckSize(Glyph, GlyphCount, ACheckWidth, ACheckHeight) then
    Result := ACheckHeight
  else Result := FCheckHeight + 2;
end;

function TdxDBTreeListCheckColumn.GetFilterOperators: TdxDBGridOperatorTypes;
begin
  Result := [gotEqual, gotNotEqual, gotBlank, gotNonBlank];
end;

procedure TdxDBTreeListCheckColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCheckEdit then
    with TdxInplaceDBTreeListCheckEdit(AInplaceEdit) do
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

function TdxDBTreeListCheckColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceCheckEdit) then
  begin
    TdxInplaceDBTreeListCheckEdit(AInplaceEdit).State := GetCheckBoxState(Field.Text);
    Result := Integer(TdxInplaceDBTreeListCheckEdit(AInplaceEdit).State);
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListCheckColumn.IsEqualValues(const Value: Variant): Boolean;
begin
  if Assigned(Field) and (VarType(Value) = varInteger) then
    Result := GetCheckBoxState(Field.Text) = Value
  else
    Result := inherited IsEqualValues(Value);
end;

procedure TdxDBTreeListCheckColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if AEdit is TCustomdxFilterImageEdit then
    with TCustomdxFilterImageEdit(AEdit) do
    begin
      Values.Clear;
      Values.Add(ValueGrayed);
      Values.Add(ValueUnchecked);
      Values.Add(ValueChecked);
      Descriptions.Clear;
      Descriptions.Add(ValueGrayed);
      Descriptions.Add(ValueUnchecked);
      Descriptions.Add(ValueChecked);
      ShowDescription := True; 
    end;
end;

procedure TdxDBTreeListCheckColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
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

function TdxDBTreeListCheckColumn.GetGlyph: TBitmap;
begin
  if FGlyph = nil then
    FGlyph := TBitmap.Create;
  Result := FGlyph;
end;

procedure TdxDBTreeListCheckColumn.SetBorder3D(Value: Boolean);
begin
  if Border3D <> Value then
  begin
    FBorder3D := Value;
    Changed(True);
  end;
end;

procedure TdxDBTreeListCheckColumn.SetGlyph(Value: TBitmap);
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

procedure TdxDBTreeListCheckColumn.SetGlyphCount(Value: Integer);
begin
  if FGlyphCount <> Value then
  begin
    FGlyphCount := Value;
    if FGlyph <> nil then
      Changed(True);
  end;
end;

procedure TdxDBTreeListCheckColumn.SetShowNullFieldStyle(Value: TdxShowNullFieldStyle);
begin
  if ShowNullFieldStyle <> Value then
  begin
    FShowNullFieldStyle := Value;
    Changed(True);
  end;
end;

procedure TdxDBTreeListCheckColumn.SetValueChecked(const Value: String);
begin
  if FValueChecked <> Value then
  begin
    FValueChecked := Value;
    Changed(True);
  end;
end;

procedure TdxDBTreeListCheckColumn.SetValueGrayed(const Value: string);
begin
  if FValueGrayed <> Value then
  begin
    FValueGrayed := Value;
    Changed(True);
  end;
end;

procedure TdxDBTreeListCheckColumn.SetValueUnchecked(const Value: string);
begin
  if FValueUnchecked <> Value then
  begin
    FValueUnchecked := Value;
    Changed(True);
  end;
end;

{ TdxDBTreeListImageColumn }
class function TCustomdxFilterImageEdit.IsInplace: Boolean;
begin
  Result := False;
end;

constructor TdxDBTreeListImageColumn.Create(AOwner: TComponent);
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

destructor TdxDBTreeListImageColumn.Destroy;
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

procedure TdxDBTreeListImageColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListImageColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DefaultImages := TdxDBTreeListImageColumn(Source).DefaultImages;
      Descriptions.Assign(TdxDBTreeListImageColumn(Source).Descriptions);
      Images := TdxDBTreeListImageColumn(Source).Images;
      ImageIndexes.Assign(TdxDBTreeListImageColumn(Source).ImageIndexes);
      Incremental := TdxDBTreeListImageColumn(Source).Incremental;
      LargeImages := TdxDBTreeListImageColumn(Source).LargeImages;
      MultiLineText := TdxDBTreeListImageColumn(Source).MultiLineText;
      ShowDescription := TdxDBTreeListImageColumn(Source).ShowDescription;
      Values.Assign(TdxDBTreeListImageColumn(Source).Values);
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxDBTreeListImageColumn.ConvertExportValue(var Value: Variant; IsHTML: Boolean): Boolean;
var
  S: string;
begin
  if VarIsNull(Value) then
    S := ''
  else S := Value;
  Value := GetDisplayValue(nil, S);
  Result := True;
end;

function TdxDBTreeListImageColumn.GetBestFit(ACanvas: TCanvas; ANode: TdxTreeListNode): Integer;
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

function TdxDBTreeListImageColumn.GetDisplayValue(Node: TdxTreeListNode; const Value: string): string;
var
  I1, I2: Integer;
begin
  GetIndexes(Value, I1, I2);
  if (0 <= I2) and (I2 < FDescriptions.Count) then
    Result := FDescriptions[I2]
  else Result := Value;
end;

function TdxDBTreeListImageColumn.GetImageIndex(const AText: string): Integer;
var
  ATempIndex: Integer;
begin
  TdxInplaceImageEdit.CalcViewIndexes(AText,
    ImageIndexes, Descriptions, Values, DefaultImages,
    Result, ATempIndex);
end;

procedure TdxDBTreeListImageColumn.GetIndexes(const AText: string; var AImageIndex, ADescIndex: Integer);
begin
  TdxInplaceImageEdit.CalcViewIndexes(AText,
    ImageIndexes, Descriptions, Values, DefaultImages,
    AImageIndex, ADescIndex);
end;

procedure TdxDBTreeListImageColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  MinWidth := 16;
  FDefaultImages := True;
  FIncremental := False;
  FMultiLineText := False;
  FShowDescription := False;
end;

// protected TdxDBTreeListImageColumn
procedure TdxDBTreeListImageColumn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = LargeImages then LargeImages := nil;
  end;
end;

procedure TdxDBTreeListImageColumn.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Value, Accept);
end;

function TdxDBTreeListImageColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterImageEdit;
end;

procedure TdxDBTreeListImageColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
var
  AImageIndex, ADescIndex: Integer;
begin
  if AEdit is TdxInplaceImageEdit then
    with TdxInplaceDBTreeListImageEdit(AEdit) do
    begin
      V := Text;
      S := GetDisplayValue(nil, Text);
      GetIndexes(V, AImageIndex, ADescIndex);
      if AImageIndex = -1 then
        V := Null; 
    end
  else
    inherited GetFilterEditValues(AEdit, V, S);
end;

procedure TdxDBTreeListImageColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
  if AEdit is TCustomdxFilterImageEdit then
  begin
    if VarIsNull(V) then
      TCustomdxFilterImageEdit(AEdit).Text := ''
    else
      TCustomdxFilterImageEdit(AEdit).Text := V;
  end
  else
    inherited SetFilterEditValue(AEdit, V);
end;

function TdxDBTreeListImageColumn.GetFilterOperators: TdxDBGridOperatorTypes;
begin
  Result := [gotEqual, gotNotEqual, gotBlank, gotNonBlank];
end;

function TdxDBTreeListImageColumn.GetMaxRowHeight(ACanvas: TCanvas): Integer;
begin
  if Images <> nil then Result := Images.Height
  else Result := 0;
end;

function TdxDBTreeListImageColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListImageEdit;
end;

procedure TdxDBTreeListImageColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceImageEdit then
    with TdxInplaceDBTreeListImageEdit(AInplaceEdit) do
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

procedure TdxDBTreeListImageColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
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

function TdxDBTreeListImageColumn.GetListWidth: Integer;
begin
  Result := DropDownWidth;
end;

procedure TdxDBTreeListImageColumn.ImageListChange(Sender: TObject);
begin
  if (Sender = Images) then Changed(True);
end;

procedure TdxDBTreeListImageColumn.SetDefaultImages(Value: Boolean);
begin
  if DefaultImages <> Value then
  begin
    FDefaultImages := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListImageColumn.SetDescriptions(Value: TStrings);
begin
  FDescriptions.Assign(Value);
  Changed(False);
end;

procedure TdxDBTreeListImageColumn.SetImageIndexes(Value: TStrings);
begin
  FImageIndexes.Assign(Value);
  Changed(False);
end;

procedure TdxDBTreeListImageColumn.SetImages(Value: TImageList);
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

procedure TdxDBTreeListImageColumn.SetLargeImages(Value: TImageList);
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

procedure TdxDBTreeListImageColumn.SetListWidth(Value: Integer);
begin
  DropDownWidth := Value;
end;

procedure TdxDBTreeListImageColumn.SetMultiLineText(Value: Boolean);
begin
  if FMultiLineText <> Value then
  begin
    FMultiLineText := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListImageColumn.SetShowDescription(Value: Boolean);
begin
  if ShowDescription <> Value then
  begin
    FShowDescription := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListImageColumn.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
  Changed(False);
end;

{ TdxDBTreeListSpinColumn }
class function TCustomdxFilterSpinEdit.IsInplace: Boolean;
begin
  Result := False;
end;

constructor TdxDBTreeListSpinColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEditorEnabled := True;
  FIncrement := 1.0;
end;

procedure TdxDBTreeListSpinColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListSpinColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      EditorEnabled := TdxDBTreeListSpinColumn(Source).EditorEnabled;
      Increment := TdxDBTreeListSpinColumn(Source).Increment;
      MinValue := TdxDBTreeListSpinColumn(Source).MinValue;
      MaxValue := TdxDBTreeListSpinColumn(Source).MaxValue;
      ShowButtonStyle := TdxDBTreeListSpinColumn(Source).ShowButtonStyle;
      UseCtrlIncrement := TdxDBTreeListSpinColumn(Source).UseCtrlIncrement;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxDBTreeListSpinColumn.DefaultMinValue: Double;
begin
  Result := 0.0;
  if Assigned(Field) then
    if Field is TIntegerField then
      Result := TIntegerField(Field).MinValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MinValue, ffGeneral{ffFixed},
                             TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
      else
        if Field is TBCDField then
          Result := TBCDField(Field).MinValue;
end;

function TdxDBTreeListSpinColumn.DefaultMaxValue: Double;
begin
  Result := 0.0;
  if Assigned(Field) then
    if Field is TIntegerField then
      Result := TIntegerField(Field).MaxValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MaxValue, ffGeneral{ffFixed},
                             TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
      else
        if Field is TBCDField then
          Result := TBCDField(Field).MaxValue;
end;

procedure TdxDBTreeListSpinColumn.RestoreDefaults;
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

// protected TdxDBTreeListSpinColumn
function TdxDBTreeListSpinColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceSpinEdit) then
    Field.Value := TdxInplaceDBTreeListSpinEdit(AInplaceEdit).Value
  else Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Result := ANode.Values[Index];
end;

function TdxDBTreeListSpinColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListSpinEdit;
end;

function TdxDBTreeListSpinColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterSpinEdit;
end;

procedure TdxDBTreeListSpinColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
begin
  if AEdit is TdxInplaceSpinEdit then
    with TdxInplaceDBTreeListSpinEdit(AEdit) do
    begin
      V := Value;
      S := Text;
    end
  else
    inherited GetFilterEditValues(AEdit, V, S);
end;

procedure TdxDBTreeListSpinColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
  if AEdit is TCustomdxFilterSpinEdit then
  begin
    if VarIsNull(V) then
      TCustomdxFilterSpinEdit(AEdit).Value := 0
    else
      TCustomdxFilterSpinEdit(AEdit).Value := V;
  end
  else
    inherited SetFilterEditValue(AEdit, V);
end;

procedure TdxDBTreeListSpinColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceSpinEdit then
    with TdxInplaceDBTreeListSpinEdit(AInplaceEdit) do
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

function TdxDBTreeListSpinColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceSpinEdit) then
  begin
    TdxInplaceDBTreeListSpinEdit(AInplaceEdit).Value := Field.AsFloat;
    Result := TdxInplaceDBTreeListSpinEdit(AInplaceEdit).Value;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListSpinColumn.IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean;
begin
  Result := True;
end;

function TdxDBTreeListSpinColumn.IsEqualValues(const Value: Variant): Boolean;
begin
  if Assigned(Field) then
    Result := Field.AsFloat = Value
  else
    Result := inherited IsEqualValues(Value);
end;

function TdxDBTreeListSpinColumn.IsShowButton(ANode: TdxTreeListNode): Boolean;
begin
  Result := (FShowButtonStyle <> sbNone) and TreeList.IsShowButtonAlways and
    ((FShowButtonStyle = sbAlways) or ANode.Focused);
end;

function TdxDBTreeListSpinColumn.NeedShowButtonEdit(X, Y: Integer; CurNode: Boolean): Boolean;
begin
  Result := False;
  if DisableEditor or (FShowButtonStyle = sbNone) then Exit;
  if FShowButtonStyle = sbAlways then
    Result := True
  else Result := CurNode;
end;

procedure TdxDBTreeListSpinColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
    if AViewData is TdxSpinEditViewData then
      with TdxSpinEditViewData(AViewData) do
      begin
        ShowButton := IsShowButton(ACellViewData.Cell_Node);
      end;  
end;

// private TdxDBTreeListSpinColumn
function TdxDBTreeListSpinColumn.GetMinValue : Double;
begin
  if mmcMinValue in FAssignedValues then
    Result := FMinValue
  else Result := DefaultMinValue;
end;

function TdxDBTreeListSpinColumn.GetMaxValue : Double;
begin
  if mmcMaxValue in FAssignedValues then
    Result := FMaxValue
  else Result := DefaultMaxValue;
end;

function TdxDBTreeListSpinColumn.GetValueType: TdxValueType;
begin
  Result := vtInt;
  if Assigned(Field) then
    if (Field is TFloatField) or (Field is TBCDField) then
      Result := vtFloat;
end;

function TdxDBTreeListSpinColumn.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1.0;
end;

function TdxDBTreeListSpinColumn.IsMaxStored: Boolean;
begin
  Result := (mmcMaxValue in FAssignedValues) and (MaxValue <> DefaultMaxValue);
end;

function TdxDBTreeListSpinColumn.IsMinStored: Boolean;
begin
  Result := (mmcMinValue in FAssignedValues) and (MinValue <> DefaultMinValue);
end;

procedure TdxDBTreeListSpinColumn.SetMinValue(Value : Double);
begin
  if (mmcMinValue in FAssignedValues) and (Value = FMinValue) then Exit;
  FMinValue := Value;
  Include(FAssignedValues, mmcMinValue);
end;

procedure TdxDBTreeListSpinColumn.SetMaxValue(Value : Double);
begin
  if (mmcMaxValue in FAssignedValues) and (Value = FMaxValue) then Exit;
  FMaxValue := Value;
  Include(FAssignedValues, mmcMaxValue);
end;

procedure TdxDBTreeListSpinColumn.SetShowButtonStyle(Value: TdxShowButtonStyle);
begin
  if FShowButtonStyle <> Value then
  begin
    FShowButtonStyle := Value;
    Changed(False);
  end;
end;

{ TdxDBTreeListPickColumn }
class function TCustomdxFilterPickEdit.IsInplace: Boolean; 
begin
  Result := False;
end;

constructor TdxDBTreeListPickColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ImmediateDropDown := True;
  FItems := TStringList.Create;
end;

destructor TdxDBTreeListPickColumn.Destroy;
begin
  FItems.Free;
  FItems := Nil;
  inherited Destroy;
end;

procedure TdxDBTreeListPickColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListPickColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      DropDownListStyle := TdxDBTreeListPickColumn(Source).DropDownListStyle;
      Items.Assign(TdxDBTreeListPickColumn(Source).Items);
      CanDeleteText := TdxDBTreeListPickColumn(Source).CanDeleteText;
      Revertable := TdxDBTreeListPickColumn(Source).Revertable;
      Sorted := TdxDBTreeListPickColumn(Source).Sorted;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListPickColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDropDownListStyle := False;
  ImmediateDropDown := True;
  FCanDeleteText := False;
  FRevertable := False;
  FItemsSorted := False;
end;

procedure TdxDBTreeListPickColumn.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
var
  V: Variant;
begin
  V := Value;
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, V, Accept);
  Value := V;
end;

function TdxDBTreeListPickColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListPickEdit;
end;

function TdxDBTreeListPickColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterPickEdit;
end;

procedure TdxDBTreeListPickColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplacePickEdit then
    with TdxInplaceDBTreeListPickEdit(AInplaceEdit) do
    begin
      DropDownListStyle := Self.DropDownListStyle;
      Items := Self.Items;
      CanDeleteText := Self.CanDeleteText;
      Revertable := Self.Revertable;
      Sorted := Self.ItemsSorted;
    end;
end;

procedure TdxDBTreeListPickColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if AEdit is TdxInplacePickEdit then
    with TdxInplaceDBTreeListPickEdit(AEdit) do
    begin
      ImmediateDropDown := False;
    end;
end;

procedure TdxDBTreeListPickColumn.SetItems(Value : TStrings);
begin
  FItems.Assign(Value);
  Changed(False);
end;

{ TdxDBTreeListCalcColumn }
class function TCustomdxFilterCalcEdit.IsInplace: Boolean;
begin
  Result := False;
end;

constructor TdxDBTreeListCalcColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBeepOnError := True;
  FPrecision := dxDefCalcPrecision;
end;

procedure TdxDBTreeListCalcColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListCalcColumn then
  begin
    inherited Assign(Source);
    BeepOnError := TdxDBTreeListCalcColumn(Source).BeepOnError;
    ButtonStyle := TdxDBTreeListCalcColumn(Source).ButtonStyle;
    Precision := TdxDBTreeListCalcColumn(Source).Precision;
    QuickClose := TdxDBTreeListCalcColumn(Source).QuickClose;
    ShowButtonFrame := TdxDBTreeListCalcColumn(Source).ShowButtonFrame;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListCalcColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FBeepOnError := True;
  FButtonStyle := bsStandard;
  FPrecision := dxDefCalcPrecision;
  FQuickClose := False;
  FShowButtonFrame := False;
end;

function TdxDBTreeListCalcColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListCalcEdit;
end;

function TdxDBTreeListCalcColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterCalcEdit; 
end;

procedure TdxDBTreeListCalcColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCalcEdit then
    with TdxInplaceDBTreeListCalcEdit(AInplaceEdit) do
    begin
      BeepOnError := Self.BeepOnError;
      ButtonStyle := Self.ButtonStyle;
      Precision := Self.Precision;
      QuickClose := Self.QuickClose;
      ShowButtonFrame := Self.ShowButtonFrame;
    end;
end;

{ TdxDBTreeListHyperLinkColumn }
constructor TdxDBTreeListHyperLinkColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEditBackgroundColor := clWhite;
  FEditFontColor := clBlue;
  FStartKey := VK_RETURN + scCtrl;
  PrepareLinkFont;
end;

destructor TdxDBTreeListHyperLinkColumn.Destroy;
begin
  FLinkFont.Free;
  inherited Destroy;
end;

procedure TdxDBTreeListHyperLinkColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListHyperLinkColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      EditBackgroundColor := TdxDBTreeListHyperLinkColumn(Source).EditBackgroundColor;
      EditFontColor := TdxDBTreeListHyperLinkColumn(Source).EditFontColor;
      SingleClick := TdxDBTreeListHyperLinkColumn(Source).SingleClick;
      StartKey := TdxDBTreeListHyperLinkColumn(Source).StartKey;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxDBTreeListHyperLinkColumn.ConvertExportValue(var Value: Variant; IsHTML: Boolean): Boolean;
var
  S: string;
begin
  if IsHTML then
  begin
    if VarIsNull(Value) then
      S := ''
    else S := Value;
    Value := '<a href="'+ S +'">' + S + '</a>';
    Result := True;
  end
  else
    Result := inherited ConvertExportValue(Value, IsHTML);
end;

procedure TdxDBTreeListHyperLinkColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FEditBackgroundColor := clWhite;
  FEditFontColor := clBlue;
  FSingleClick := False;
  FStartKey := VK_RETURN + scCtrl;
end;

procedure TdxDBTreeListHyperLinkColumn.DoStartClick(Sender: TObject);
begin
  if Assigned(FOnStartClick) then FOnStartClick(Self);
end;

procedure TdxDBTreeListHyperLinkColumn.FontChanged(Sender: TObject);
begin
  inherited FontChanged(Sender);
  PrepareLinkFont;
end;

function TdxDBTreeListHyperLinkColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListHyperLinkEdit;
end;

procedure TdxDBTreeListHyperLinkColumn.GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor);
begin
  if SingleClick and (ANode.Strings[Index] <> '') then
    ACursor := crdxHandPointCursor; 
end;

procedure TdxDBTreeListHyperLinkColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceHyperLinkEdit then
    with TdxInplaceDBTreeListHyperLinkEdit(AInplaceEdit) do
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

procedure TdxDBTreeListHyperLinkColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
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

procedure TdxDBTreeListHyperLinkColumn.PrepareLinkFont;
begin
  if FLinkFont = nil then
    FLinkFont := TFont.Create;
  FLinkFont.Assign(Font);
  FLinkFont.Style := FLinkFont.Style + [fsUnderline];
  if SingleClick then FLinkFont.Color := EditFontColor
  else FLinkFont.Color := clDefault;
end;

procedure TdxDBTreeListHyperLinkColumn.SetEditBackgroundColor(Value: TColor);
begin
  if FEditBackgroundColor <> Value then
  begin
    FEditBackgroundColor := Value;
    PrepareLinkFont;
    Changed(False);
  end;
end;

procedure TdxDBTreeListHyperLinkColumn.SetEditFontColor(Value: TColor);
begin
  if FEditFontColor <> Value then
  begin
    FEditFontColor := Value;
    PrepareLinkFont;
    Changed(False);
  end;
end;

procedure TdxDBTreeListHyperLinkColumn.SetSingleClick(Value: Boolean);
begin
  if FSingleClick <> Value then
  begin
    FSingleClick := Value;
    PrepareLinkFont;
    Changed(False);
  end;
end;

{ TdxDBTreeListTimeColumn }
class function TCustomdxFilterTimeEdit.IsInplace: Boolean;
begin
  Result := False;
end;

procedure TdxDBTreeListTimeColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListTimeColumn then
  begin
    inherited Assign(Source);
    TimeEditFormat := TdxDBTreeListTimeColumn(Source).TimeEditFormat;
    UseCtrlIncrement := TdxDBTreeListTimeColumn(Source).UseCtrlIncrement;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListTimeColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FTimeEditFormat := tfHourMinSec;
  FUseCtrlIncrement := False;
end;

function TdxDBTreeListTimeColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceTimeEdit) then
    Field.AsFloat{AsDateTime} := DateOf(Field.AsFloat{AsDateTime}) + TdxInplaceDBTreeListTimeEdit(AInplaceEdit).Time
  else Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Result := ANode.Values[Index];
end;

function TdxDBTreeListTimeColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListTimeEdit;
end;

function TdxDBTreeListTimeColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterTimeEdit;
end;

procedure TdxDBTreeListTimeColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
begin
  if AEdit is TdxInplaceTimeEdit then
    with TdxInplaceDBTreeListTimeEdit(AEdit) do
    begin
      V := Time;
      VarCast(V , V, varDate);
      S := EditText;
    end
  else
    inherited GetFilterEditValues(AEdit, V, S);
end;

procedure TdxDBTreeListTimeColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
  if AEdit is TCustomdxFilterTimeEdit then
  begin
    if VarIsNull(V) then
      TCustomdxFilterTimeEdit(AEdit).Time := 0
    else
      TCustomdxFilterTimeEdit(AEdit).Time := V;
  end
  else
    inherited SetFilterEditValue(AEdit, V);
end;

procedure TdxDBTreeListTimeColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceTimeEdit then
    with TdxInplaceDBTreeListTimeEdit(AInplaceEdit) do
    begin
      TimeEditFormat := Self.TimeEditFormat;
      UseCtrlIncrement := Self.UseCtrlIncrement;
    end;
end;

function TdxDBTreeListTimeColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceTimeEdit) then
  begin
    TdxInplaceDBTreeListTimeEdit(AInplaceEdit).Time := TimeOf(Field.AsFloat{AsDateTime});
    Result := TdxInplaceDBTreeListTimeEdit(AInplaceEdit).Time;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListTimeColumn.IsEqualValues(const Value: Variant): Boolean;
begin
  if Assigned(Field) then
    Result := TimeOf(Field.AsFloat{AsDateTime}) = Value
  else
    Result := inherited IsEqualValues(Value);
end;

{ TdxDBTreeListCurrencyColumn }
class function TCustomdxFilterCurrencyEdit.IsInplace: Boolean;
begin
  Result := False;
end;

constructor TdxDBTreeListCurrencyColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDecimalPlaces := 2;
  FDisplayFormat := DefaultCurrencyDisplayFormat;
end;

procedure TdxDBTreeListCurrencyColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListCurrencyColumn then
  begin
    inherited Assign(Source);
    DecimalPlaces := TdxDBTreeListCurrencyColumn(Source).DecimalPlaces;
    DisplayFormat := TdxDBTreeListCurrencyColumn(Source).DisplayFormat;
    MinValue := TdxDBTreeListCurrencyColumn(Source).MinValue;
    MaxValue := TdxDBTreeListCurrencyColumn(Source).MaxValue;
    Nullable := TdxDBTreeListCurrencyColumn(Source).Nullable;
    NullString := TdxDBTreeListCurrencyColumn(Source).NullString;
    UseThousandSeparator := TdxDBTreeListCurrencyColumn(Source).UseThousandSeparator;
  end
  else
    inherited Assign(Source);
end;

function TdxDBTreeListCurrencyColumn.DefaultMinValue : Double;
begin
  Result := 0.0;
  if Assigned(Field) then
    if Field is TIntegerField then
      Result := TIntegerField(Field).MinValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MinValue, ffGeneral{ffFixed},
                             TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
      else
        if Field is TBCDField then
          Result := TBCDField(Field).MinValue;
end;

function TdxDBTreeListCurrencyColumn.DefaultMaxValue : Double;
begin
  Result := 0.0;
  if Assigned(Field) then
    if Field is TIntegerField then
      Result := TIntegerField(Field).MaxValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MaxValue, ffGeneral{ffFixed},
                             TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
      else
        if Field is TBCDField then
          Result := TBCDField(Field).MaxValue;
end;

function TdxDBTreeListCurrencyColumn.IsValidChar(InputChar: Char): Boolean;
begin
  Result := ATreeList.DataLink.Active and Assigned(Field) and
    ((InputChar = ThousandSeparator) or Field.IsValidChar(InputChar));
end;

procedure TdxDBTreeListCurrencyColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDecimalPlaces := 2;
  FDisplayFormat := DefaultCurrencyDisplayFormat;
  FDisplayFormatStored := False;
  FMinValue := 0.0;
  FMaxValue := 0.0;
end;

function TdxDBTreeListCurrencyColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceCurrencyEdit) then
    Field.Value := TdxInplaceDBTreeListCurrencyEdit(AInplaceEdit).ReturnEditValue
  else
    Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Result := ANode.Values[Index];
end;

function TdxDBTreeListCurrencyColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListCurrencyEdit;
end;

function TdxDBTreeListCurrencyColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterCurrencyEdit;
end;

procedure TdxDBTreeListCurrencyColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
begin
  if AEdit is TdxInplaceCurrencyEdit then
    with TdxInplaceDBTreeListCurrencyEdit(AEdit) do
    begin
      V := Value;
      S := Text;
    end
  else
    inherited GetFilterEditValues(AEdit, V, S);
end;

procedure TdxDBTreeListCurrencyColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
  if AEdit is TCustomdxFilterCurrencyEdit then
  begin
    if VarIsNull(V) then
      TCustomdxFilterCurrencyEdit(AEdit).Value := 0
    else
      TCustomdxFilterCurrencyEdit(AEdit).Value := V;
  end
  else
    inherited SetFilterEditValue(AEdit, V);
end;

procedure TdxDBTreeListCurrencyColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCurrencyEdit then
    with TdxInplaceDBTreeListCurrencyEdit(AInplaceEdit) do
    begin
      DecimalPlaces := Self.DecimalPlaces;
      DisplayFormat := ''; //Self.DisplayFormat;
//      MinValue := Self.MinValue;
//      MaxValue := Self.MaxValue;
      SetMinMaxValues(Self.MinValue, Self.MaxValue);
      Nullable := Self.Nullable;
      NullString := Self.NullString;
      UseThousandSeparator := Self.UseThousandSeparator;
    end;
end;

function TdxDBTreeListCurrencyColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceCurrencyEdit) then
  begin
    TdxInplaceDBTreeListCurrencyEdit(AInplaceEdit).Value := Field.AsFloat;
    Result := TdxInplaceDBTreeListCurrencyEdit(AInplaceEdit).Value;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListCurrencyColumn.IsEqualValues(const Value: Variant): Boolean;

  function GetFieldValue: Variant;
  begin
    Result := Field.AsFloat;
    if MinValue <> MaxValue then
    begin
      if Result < MinValue then Result := MinValue;
      if Result > MaxValue then Result := MaxValue;
    end;
  end;

begin
  if Assigned(Field) then
    Result := {Field.AsFloat}GetFieldValue = Value
  else
    Result := inherited IsEqualValues(Value);
end;

procedure TdxDBTreeListCurrencyColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); // O

  function DisableFormat: Boolean;
  begin
    Result := Assigned(Field) and (Assigned(Field.OnGetText) or
      ((Field is TCurrencyField) and TCurrencyField(Field).Currency));
  end;

var
  V: Variant;
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if (FDisplayFormat <> '') and not DisableFormat then
    with TdxEditViewData(AViewData) do
    begin
      if Assigned(ACellViewData.Cell_Node) and not ACellViewData.Cell_IsNullNode then
      begin
        V := ACellViewData.Cell_Node.Values[Self.Index];
        try
          if VarIsNull(V) or (VarType(V) = varString) then
          begin
            Data := VarToStr(V);
            if (Data = '') and Nullable then
              Data := NullString;
          end
          else
            Data := FormatFloat(FDisplayFormat, V);
        except
          on EConvertError do;
        end;
      end;
    end;
end;

function TdxDBTreeListCurrencyColumn.GetMinValue: Double;
begin
  if mmcMinValue in FAssignedValues then
    Result := FMinValue
  else Result := DefaultMinValue;
end;

function TdxDBTreeListCurrencyColumn.GetMaxValue: Double;
begin
  if mmcMaxValue in FAssignedValues then
    Result := FMaxValue
  else Result := DefaultMaxValue;
end;

function TdxDBTreeListCurrencyColumn.IsMaxStored: Boolean;
begin
  Result := FMaxValue <> 0.0;
end;

function TdxDBTreeListCurrencyColumn.IsMinStored: Boolean;
begin
  Result := FMinValue <> 0.0;
end;

procedure TdxDBTreeListCurrencyColumn.SetDisplayFormat(const Value: string);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    FDisplayFormatStored := True;
    Changed(True);
  end;
end;

procedure TdxDBTreeListCurrencyColumn.SetMinValue(Value : Double);
begin
  if (mmcMinValue in FAssignedValues) and (Value = FMinValue) then Exit;
  FMinValue := Value;
  Include(FAssignedValues, mmcMinValue);
end;

procedure TdxDBTreeListCurrencyColumn.SetMaxValue(Value : Double);
begin
  if (mmcMaxValue in FAssignedValues) and (Value = FMaxValue) then Exit;
  FMaxValue := Value;
  Include(FAssignedValues, mmcMaxValue);
end;

procedure TdxDBTreeListCurrencyColumn.SetNullable(Value: Boolean);
begin
  if FNullable <> Value then
  begin
    FNullable := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListCurrencyColumn.SetNullString(const Value: string);
begin
  if FNullString <> Value then
  begin
    FNullString := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListCurrencyColumn.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  if not Application.UpdateFormatSettings then Exit;
  if not FDisplayFormatStored then
  begin
    SysUtils.GetFormatSettings; // TODO ?
    FDisplayFormat := DefaultCurrencyDisplayFormat;
  end;
end;

{ TdxDBTreeListGraphicColumn }
constructor TdxDBTreeListGraphicColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited HeaderMaxLineCount := 0;
  DisableFilter := True;
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

destructor TdxDBTreeListGraphicColumn.Destroy;
begin
  FPopupToolBar.Free;
  FPopupToolBar := nil;
  FPicture.Free;
  FPicture := nil;
  inherited Destroy;
end;

procedure TdxDBTreeListGraphicColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListGraphicColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      Center := TdxDBTreeListGraphicColumn(Source).Center;
      CustomFilter := TdxDBTreeListGraphicColumn(Source).CustomFilter;
      CustomGraphic := TdxDBTreeListGraphicColumn(Source).CustomGraphic;
      DblClickActivate := TdxDBTreeListGraphicColumn(Source).DblClickActivate;
      GraphicTransparency := TdxDBTreeListGraphicColumn(Source).GraphicTransparency;
      PopupToolBar := TdxDBTreeListGraphicColumn(Source).PopupToolBar;
      PopupToolbarPosStored := TdxDBTreeListGraphicColumn(Source).PopupToolbarPosStored;
      QuickDraw := TdxDBTreeListGraphicColumn(Source).QuickDraw;
      ShadowSelection := TdxDBTreeListGraphicColumn(Source).ShadowSelection;
      Stretch := TdxDBTreeListGraphicColumn(Source).Stretch;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxDBTreeListGraphicColumn.GetBestFit(ACanvas: TCanvas; ANode: TdxTreeListNode): Integer;
begin
  Result := 0;
  if not Stretch then
  begin
    LoadPictureFromNode(ANode);
    if not IsPictureEmpty(FPicture) then
      Result := FPicture.Width;
  end;
end;

procedure TdxDBTreeListGraphicColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  HeaderMaxLineCount := 0;
  DisableFilter := True;
  FCenter := True;
  FCustomGraphic := False;
  FDblClickActivate := True;
  FGraphicTransparency := gtDefault;
  FPopupToolbarPosStored := True;
  FQuickDraw := False;
  FShadowSelection := True;
  FStretch := True;
end;

function TdxDBTreeListGraphicColumn.AlwaysStoredValue: Boolean;
begin
  Result := True;
end;

function TdxDBTreeListGraphicColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceGraphicEdit) then
    SaveBlobValueToField(TdxInplaceDBTreeListGraphicEdit(AInplaceEdit).ReturnEditValue, Field)
  else Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Result := ANode.Values[Index];
end;

procedure TdxDBTreeListGraphicColumn.DoAssignPicture(Sender: TObject; var Picture: TPicture);
begin
  if Assigned(FOnAssignPicture) then FOnAssignPicture(Self, Picture);
end;

procedure TdxDBTreeListGraphicColumn.DoCustomClick(Sender: TObject);
begin
  if Assigned(FOnCustomClick) then FOnCustomClick(Self);
end;

procedure TdxDBTreeListGraphicColumn.DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass);
begin
  GraphicClass := GetGraphicClass(TreeList.FocusedNode)
end;

function TdxDBTreeListGraphicColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListGraphicEdit;
end;

function TdxDBTreeListGraphicColumn.GetGraphicClass(ANode: TdxTreeListNode): TGraphicClass;
begin
  Result := nil;
  if Assigned(FOnGetGraphicClass) then FOnGetGraphicClass(Self, ANode, Result);
end;

procedure TdxDBTreeListGraphicColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceGraphicEdit then
    with TdxInplaceDBTreeListGraphicEdit(AInplaceEdit) do
    begin
      Center := Self.Center;
      ClipboardFormat := Self.ClipboardFormat;
      CustomFilter := Self.CustomFilter;
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

function TdxDBTreeListGraphicColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; // O
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceGraphicEdit) then
  begin
    with TdxInplaceDBTreeListGraphicEdit(AInplaceEdit) do
    begin
      OffsetSize := Rect(0, 0, 0, 0);
      Caption := '';
      Result := Field.Value;
      LoadPicture(Picture, Self.GetGraphicClass(ANode), Result);
    end;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListGraphicColumn.IsBlobColumn: Boolean;
begin
  Result := True;
end;

type
  TdxTreeListCracker = class(TCustomdxTreeList);

procedure TdxDBTreeListGraphicColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxGraphicEditViewData then
    with TdxGraphicEditViewData(AViewData) do
    begin
      if not ACellViewData.Cell_IsNullNode then
        LoadPictureFromNode(ACellViewData.Cell_Node)
      else
        FPicture.Graphic := nil;
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

procedure TdxDBTreeListGraphicColumn.LoadPictureFromNode(ANode: TdxTreeListNode);
begin
  if not (CustomGraphic and (csDesigning in ComponentState)) then
    LoadPicture(FPicture, GetGraphicClass(ANode), ANode.Values[Index])
  else FPicture.Graphic := nil;
end;

procedure TdxDBTreeListGraphicColumn.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListGraphicColumn.SetCustomGraphic(Value: Boolean);
begin
  if FCustomGraphic <> Value then
  begin
    FCustomGraphic := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListGraphicColumn.SetGraphicTransparency(Value: TdxGraphicEditTransparency);
begin
  if FGraphicTransparency <> Value then
  begin
    FGraphicTransparency := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListGraphicColumn.SetPopupToolBar(Value: TdxPopupToolBarWindow);
begin
  FPopupToolBar.Assign(Value);
end;

procedure TdxDBTreeListGraphicColumn.SetPopupToolbarPosStored(Value: Boolean);
begin
  FPopupToolbarPosStored := Value;
  if not FPopupToolbarPosStored then
    FPopupToolbarPos := Point(-10000, -10000);
end;

procedure TdxDBTreeListGraphicColumn.SetQuickDraw(Value: Boolean);
begin
  if FQuickDraw <> Value then
  begin
    FQuickDraw := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListGraphicColumn.SetShadowSelection(Value: Boolean);
begin
  if FShadowSelection <> Value then
  begin
    FShadowSelection := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListGraphicColumn.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Changed(False);
  end;
end;

{ TdxDBTreeListLookupColumn }
class function TCustomdxFilterLookupEdit.IsInplace: Boolean;
begin
  Result := False;
end;

procedure TdxDBTreeListLookupColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListLookupColumn then
  begin
    if Assigned(ATreeList) then ATreeList.BeginUpdate;
    try
      inherited Assign(Source);
      ClearKey := TdxDBTreeListLookupColumn(Source).ClearKey;
      ListFieldName := TdxDBTreeListLookupColumn(Source).ListFieldName;
      ListFieldIndex := TdxDBTreeListLookupColumn(Source).ListFieldIndex;
      CanDeleteText := TdxDBTreeListLookupColumn(Source).CanDeleteText;
    finally
      if Assigned(ATreeList) then ATreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListLookupColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FClearKey := 0;
  FListFieldName := '';
  FListFieldIndex := 0;
  FCanDeleteText := False;
end;

procedure TdxDBTreeListLookupColumn.DoCloseUp(Sender: TObject; var Value: Variant; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Value, Accept);
end;

function TdxDBTreeListLookupColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListLookupEdit;
end;

function TdxDBTreeListLookupColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterLookupEdit;
end;

procedure TdxDBTreeListLookupColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
begin
  if AEdit is TdxInplaceLookupEdit then
    with TdxInplaceDBTreeListLookupEdit(AEdit) do
    begin
      V := LookupKeyValue;
      S := Text;
    end
  else
    inherited GetFilterEditValues(AEdit, V, S);
end;

procedure TdxDBTreeListLookupColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
  if AEdit is TCustomdxFilterLookupEdit then
  begin
    TCustomdxFilterLookupEdit(AEdit).LookupKeyValue := V;
  end
  else
    inherited SetFilterEditValue(AEdit, V);
end;

function TdxDBTreeListLookupColumn.GetFilterOperators: TdxDBGridOperatorTypes;
begin
  Result := [gotEqual, gotNotEqual, gotBlank, gotNonBlank];
end;

function TdxDBTreeListLookupColumn.GetFilterValue(ANode: TdxTreeListNode): Variant;
begin
  Result := TdxDBTreeListControlNode(ANode).VariantData[Index].LookupValue;
end;

procedure TdxDBTreeListLookupColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceLookupEdit then
    with TdxInplaceDBTreeListLookupEdit(AInplaceEdit) do
    begin
      ClearKey := Self.ClearKey;
      Field := Self.Field;
      ListFieldName := Self.ListFieldName;
      CanDeleteText := Self.CanDeleteText;
      OnCloseUp := Self.DoCloseUp;
    end;
end;

procedure TdxDBTreeListLookupColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  inherited PrepareFilterEdit(AEdit);
  if AEdit is TdxInplaceLookupEdit then
    with TdxInplaceDBTreeListLookupEdit(AEdit) do
    begin
      CanDeleteText := True;
      UnboundMode := True;
      OnCloseUp := nil;
    end;
end;

function TdxDBTreeListLookupColumn.GetListWidth: Integer;
begin
  Result := DropDownWidth;
end;

procedure TdxDBTreeListLookupColumn.SetListWidth(Value: Integer);
begin
  DropDownWidth := Value;
end;

{ TdxDBTreeListBlobColumn }
constructor TdxDBTreeListBlobColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DisableFilter := True;
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

procedure TdxDBTreeListBlobColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListBlobColumn then
  begin
    if Assigned(ATreeList) then ATreeList.BeginUpdate;
    try
      inherited Assign(Source);
      AlwaysSaveText := TdxDBTreeListBlobColumn(Source).AlwaysSaveText;
      BlobKind := TdxDBTreeListBlobColumn(Source).BlobKind;
      BlobPaintStyle := TdxDBTreeListBlobColumn(Source).BlobPaintStyle;
      MaxDisplayLength := TdxDBTreeListBlobColumn(Source).MaxDisplayLength;
      MemoMaxLength := TdxDBTreeListBlobColumn(Source).MemoMaxLength;
      MemoCharCase := TdxDBTreeListBlobColumn(Source).MemoCharCase;
      MemoHideScrollBars := TdxDBTreeListBlobColumn(Source).MemoHideScrollBars;
      MemoMaxLength := TdxDBTreeListBlobColumn(Source).MemoMaxLength;
      MemoOEMConvert := TdxDBTreeListBlobColumn(Source).MemoOEMConvert;
      MemoScrollBars := TdxDBTreeListBlobColumn(Source).MemoScrollBars;
      MemoSelectionBar := TdxDBTreeListBlobColumn(Source).MemoSelectionBar;
      MemoWantReturns := TdxDBTreeListBlobColumn(Source).MemoWantReturns;
      MemoWantTabs := TdxDBTreeListBlobColumn(Source).MemoWantTabs;
      MemoWordWrap := TdxDBTreeListBlobColumn(Source).MemoWordWrap;
      PictureAutoSize := TdxDBTreeListBlobColumn(Source).PictureAutoSize;
      PictureFilter := TdxDBTreeListBlobColumn(Source).PictureFilter;
      PictureTransparency := TdxDBTreeListBlobColumn(Source).PictureTransparency;
      PopupHeight := TdxDBTreeListBlobColumn(Source).PopupHeight;
      PopupWidth := TdxDBTreeListBlobColumn(Source).PopupWidth;
      ShowExPopupItems := TdxDBTreeListBlobColumn(Source).ShowExPopupItems;
      ShowPicturePopup := TdxDBTreeListBlobColumn(Source).ShowPicturePopup;
      SizeablePopup := TdxDBTreeListBlobColumn(Source).SizeablePopup;
    finally
      if Assigned(ATreeList) then ATreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListBlobColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  DisableFilter := True;
  FAlwaysSaveText := False;
  FBlobKind := bkAuto;
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

function TdxDBTreeListBlobColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceBlobEdit) then
    SaveBlobValueToField(TdxInplaceDBTreeListBlobEdit(AInplaceEdit).ReturnEditValue, Field)
  else Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Result := ANode.Values[Index];
end;

procedure TdxDBTreeListBlobColumn.DoAssignPicture(Sender: TObject; var Picture: TPicture);
begin
  if Assigned(FOnAssignPicture) then FOnAssignPicture(Self, Picture);
end;

procedure TdxDBTreeListBlobColumn.DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass);
begin
  GraphicClass := GetGraphicClass(TreeList.FocusedNode);
end;

procedure TdxDBTreeListBlobColumn.DoSavePopupSize(Sender: TObject);
begin
  if Sender is TdxInplaceDBTreeListBlobEdit then
  begin
    PopupWidth := TdxInplaceDBTreeListBlobEdit(Sender).PopupWidth;
    PopupHeight := TdxInplaceDBTreeListBlobEdit(Sender).PopupHeight;
  end;
end;

function TdxDBTreeListBlobColumn.GetDisplayText(ANode: TdxTreeListNode): string;
begin
  if Assigned(Field) then
  begin
    if BlobPaintStyle = bpsText then 
      if MaxDisplayLength < 0 then
        Result := Field.AsString
      else Result := Copy(Field.AsString, 1, MaxDisplayLength{255})
    else
    if (BlobPaintStyle = bpsIcon) and Field.IsNull then
      Result := ''
    else
      Result := inherited GetDisplayText(ANode);
  end
  else
    Result := inherited GetDisplayText(ANode);
end;

function TdxDBTreeListBlobColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListBlobEdit;
end;

function TdxDBTreeListBlobColumn.GetGraphicClass(ANode: TdxTreeListNode): TGraphicClass;
begin
  Result := PictureGraphicClass;
  if Assigned(FOnGetGraphicClass) then FOnGetGraphicClass(Self, ANode, Result);
end;

procedure TdxDBTreeListBlobColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceBlobEdit then
    with TdxInplaceDBTreeListBlobEdit(AInplaceEdit) do
    begin
      AlwaysSaveText := Self.AlwaysSaveText;
      BlobEditKind := CalcBlobEditKind(BlobKind, Field);
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

function TdxDBTreeListBlobColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) and (AInplaceEdit is TdxInplaceBlobEdit) then
  begin
//    TdxInplaceDBTreeListBlobEdit(AInplaceEdit).Text := Field.Value;
    TdxInplaceDBTreeListBlobEdit(AInplaceEdit).Text := Field.AsString;
    Result := TdxInplaceDBTreeListBlobEdit(AInplaceEdit).Text;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListBlobColumn.IsBlobColumn: Boolean;
begin
  Result := True;
end;

procedure TdxDBTreeListBlobColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxBlobEditViewData then
    with TdxBlobEditViewData(AViewData) do
    begin
      BlobEditKind := CalcBlobEditKind(BlobKind, Field);
      BlobPaintStyle := Self.BlobPaintStyle;
      Images := imgBlobImages;
      if not ACellViewData.Cell_IsNullNode then
      begin
        if BlobPaintStyle = bpsText then
          Data := VarToStr(ACellViewData.Cell_Node.Values[Index]) // TODO
        else
          Data := ACellViewData.Cell_Node.Strings[Index]; // TODO
      end
      else
        Data := '';
      IsNull := VarIsNull(Data) or ((VarType(Data) = varString) and (Data = ''));
    end;
end;

procedure TdxDBTreeListBlobColumn.SetBlobKind(Value: TdxBlobKind);
begin
  if FBlobKind <> Value then
  begin
    FBlobKind := Value;
    Changed(False);
  end;
end;

procedure TdxDBTreeListBlobColumn.SetBlobPaintStyle(Value: TdxBlobPaintStyle);
begin
  if BlobPaintStyle <> Value then
  begin
    FBlobPaintStyle := Value;
    Changed(False);
    ChangedReload(True);
  end;
end;

{ TdxDBTreeListMRUColumn }
constructor TdxDBTreeListMRUColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ImmediateDropDown := False;
  FMaxItemCount := 7;
  FShowEllipsis := True;
end;

procedure TdxDBTreeListMRUColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListMRUColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      MaxItemCount := TdxDBTreeListMRUColumn(Source).MaxItemCount;
      ShowEllipsis := TdxDBTreeListMRUColumn(Source).ShowEllipsis;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxDBTreeListMRUColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FMaxItemCount := 7;
  FShowEllipsis := True;
end;

function TdxDBTreeListMRUColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited AssignEditValue(ANode, AInplaceEdit);
  Items.Assign(TdxInplaceDBTreeListMRUEdit(AInplaceEdit).Items);
end;

procedure TdxDBTreeListMRUColumn.DoButtonClick(Sender: TObject);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;

function TdxDBTreeListMRUColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListMRUEdit;
end;

procedure TdxDBTreeListMRUColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMRUEdit then
    with TdxInplaceDBTreeListMRUEdit(AInplaceEdit) do
    begin
      MaxItemCount := Self.MaxItemCount;
      ShowEllipsis := Self.ShowEllipsis;
      OnButtonClick := Self.DoButtonClick;
    end;
end;

procedure TdxDBTreeListMRUColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxMRUEditViewData then
    with TdxMRUEditViewData(AViewData) do
    begin
      ShowEllipsis := Self.ShowEllipsis;
    end;
end;

procedure TdxDBTreeListMRUColumn.SetShowEllipsis(Value: Boolean);
begin
  if FShowEllipsis <> Value then
  begin
    FShowEllipsis := Value;
    Changed(True);
  end;
end;

{ TdxDBTreeListWrapperColumn }
constructor TdxDBTreeListWrapperColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DisableFilter := True;
end;

function TdxDBTreeListWrapperColumn.ReferenceColumn(ANode: TdxTreeListNode): TdxDBTreeListWrapperColumn;
begin
  if not Assigned(ANode) and Assigned(TreeList) then
    ANode := TreeList.FocusedNode;
  Result := nil;
  if Assigned(ANode) and Assigned(FOnGetReferenceColumn) then
    FOnGetReferenceColumn(Self, ANode, TdxDBTreeListColumn(Result));
end;

procedure TdxDBTreeListWrapperColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  DisableFilter := True;
end; 

function TdxDBTreeListWrapperColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(ANode);
  if C <> nil then
  begin
    C.FActualIndex := Self.Index;
    try
      // TODO Field
      Result := C.AssignEditValue(ANode, AInplaceEdit);
    finally
      C.FActualIndex := -1;
    end;
  end
  else
    Result := inherited AssignEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListWrapperColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.GetdxInplaceEditClass
  else
    Result := inherited GetdxInplaceEditClass;
end;

procedure TdxDBTreeListWrapperColumn.GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor);
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(ANode);
  if C <> nil then
    C.GetHotTrackCursor(ANode, ACursor)
  else
    inherited GetHotTrackCursor(ANode, ACursor);
end;

function TdxDBTreeListWrapperColumn.GetViewData: TdxEditViewData;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.GetViewData
  else
    Result := inherited GetViewData;
end;

procedure TdxDBTreeListWrapperColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    C.InitEditProperties(AInplaceEdit)
  else
    inherited InitEditProperties(AInplaceEdit);
end;

function TdxDBTreeListWrapperColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
var
  C: TdxDBTreeListWrapperColumn;
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

function TdxDBTreeListWrapperColumn.NeedShowButtonEdit(X, Y: Integer; IsCurrentNode: Boolean): Boolean;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.NeedShowButtonEdit(X, Y, IsCurrentNode)
  else
    Result := inherited NeedShowButtonEdit(X, Y, IsCurrentNode);
end;

procedure TdxDBTreeListWrapperColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(ACellViewData.Cell_Node);
  if C <> nil then
    C.PrepareViewData(AViewData, ACellViewData)
  else
    inherited PrepareViewData(AViewData, ACellViewData);
end;

function TdxDBTreeListWrapperColumn.AlwaysStoredValue: Boolean;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.AlwaysStoredValue
  else
    Result := inherited AlwaysStoredValue;
end;

procedure TdxDBTreeListWrapperColumn.AssignNodeValues(ANode: TdxDBTreeListControlNode);
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(ANode);
  if C <> nil then
  begin
    C.FActualIndex := Self.Index;
    try
      C.AssignNodeValues(ANode);
    finally
      C.FActualIndex := -1;
    end;
  end
  else
    inherited AssignNodeValues(ANode);
end;

function TdxDBTreeListWrapperColumn.GetDisplayText(ANode: TdxTreeListNode): string;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(ANode);
  if C <> nil then
    Result := C.GetDisplayText(ANode)
  else
    Result := inherited GetDisplayText(ANode);
end;

function TdxDBTreeListWrapperColumn.GetText(const Value: Variant): string;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.GetText(Value)
  else
    Result := inherited GetText(Value);
end;

function TdxDBTreeListWrapperColumn.IsBlobColumn: Boolean;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.IsBlobColumn
  else
    Result := inherited IsBlobColumn;
end;

function TdxDBTreeListWrapperColumn.IsEqualValues(const Value: Variant): Boolean;
var
  C: TdxDBTreeListWrapperColumn;
begin
  C := ReferenceColumn(FActualNode);
  if C <> nil then
    Result := C.IsEqualValues(Value)
  else
    Result := inherited IsEqualValues(Value);
end;

// InitDBTreeListColumnList
procedure InitDBTreeListColumnList(AFieldType: TFieldType; AFieldKind: TFieldKind;
  var Info: TdxDBTreeListColumnClassInfo);
const
  AVer = 1;
begin
  if AFieldKind <> fkLookup then
  begin
    case AFieldType of
      ftBoolean: Info.ColumnClass := TdxDBTreeListCheckColumn;
      ftDate, ftDateTime: Info.ColumnClass := TdxDBTreeListDateColumn;
      ftTime: Info.ColumnClass := TdxDBTreeListTimeColumn;
      ftCurrency, ftBCD: Info.ColumnClass := TdxDBTreeListCurrencyColumn;
      ftMemo: Info.ColumnClass := TdxDBTreeListMemoColumn;
      ftGraphic: Info.ColumnClass := TdxDBTreeListGraphicColumn;
      ftBytes, ftVarBytes, ftBlob, ftFmtMemo, ftParadoxOle,
        ftDBaseOle, ftTypedBinary: Info.ColumnClass := TdxDBTreeListBlobColumn;
      else
        Info.ColumnClass := TdxDBTreeListMaskColumn;
    end;
    Info.Version := AVer;
  end
  else {lookup}
  begin
    Info.ColumnClass := TdxDBTreeListLookupColumn;
    Info.Version := AVer;
  end;
end;

initialization
  // load strings
  sdxGrCheckTextTrue := LoadStr(dxSTextTrue);
  sdxGrCheckTextFalse := LoadStr(dxSTextFalse);

  Classes.RegisterClasses([TdxDBTreeListMemoColumn, TdxDBTreeListDropDownColumn,
    TdxDBTreeListDateColumn, TdxDBTreeListButtonColumn, TdxDBTreeListCheckColumn,
    TdxDBTreeListImageColumn, TdxDBTreeListSpinColumn, TdxDBTreeListPickColumn,
    TdxDBTreeListCalcColumn, TdxDBTreeListHyperLinkColumn, TdxDBTreeListTimeColumn,
    TdxDBTreeListCurrencyColumn, TdxDBTreeListGraphicColumn, TdxDBTreeListLookupColumn,
    TdxDBTreeListBlobColumn, TdxDBTreeListMRUColumn,
    TdxDBTreeListWrapperColumn]);

  InitDefaultDBTreeListColumnClasses(InitDBTreeListColumnList);

finalization
  ResetDefaultDBTreeListColumnClasses;

end.
