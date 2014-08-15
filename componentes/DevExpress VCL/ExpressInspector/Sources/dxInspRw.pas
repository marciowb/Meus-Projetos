
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector extended text rows                         }
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

unit dxInspRw;

interface

{$I dxInsVer.inc}

{$DEFINE FLATCHECKBOX}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, Menus,
  dxCntner, dxEditor, dxExEdtr, dxInspct, dxGrDate, dxEdStr, dxCalc
  {$IFDEF DELPHI4}, ImgList{$ENDIF}{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxInspectorMaskRow }

  TdxInspectorMaskEdit = class(TdxInplaceMaskEdit)
  end;

  TdxInspectorMaskRow = class(TdxInspectorRow)
  private
    FAssignedEditMask: Boolean;
    FEditMask: string;
    FIgnoreMaskBlank: Boolean;
    function GetEditMask: string;
    function IsEditMaskStored: Boolean;
    procedure SetEditMask(const Value: string);
  protected
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultEditMask: string; virtual;
    procedure RestoreDefaults; override;
  published
    property EditMask: string read GetEditMask write SetEditMask stored IsEditMaskStored;
    property IgnoreMaskBlank: Boolean read FIgnoreMaskBlank write FIgnoreMaskBlank default False;
  end;

  { TdxInspectorTextMaskRow }
  
  TdxInspectorTextMaskRow = class(TdxInspectorMaskRow)
  private
    FText: string;
    procedure SetText(const Value: String);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorDropDownRow }
  
  TdxInspectorDropDownEdit = class(TdxInplaceDropDownEdit)
  end;

  TdxInspectorDropDownRow = class(TdxInspectorRow)
  private
    FButtonGlyph: TBitmap;
    FDropDownRows: Integer;
    FDropDownWidth: Integer;
    FImmediateDropDown: Boolean;
    FImmediatePopup: Boolean;
    FPopupAlignment: TAlignment;
    FPopupBorder: TdxPopupBorder;
    FOnEditButtonClick: TNotifyEvent;
    function GetButtonGlyph: TBitmap;
    procedure SetButtonGlyph(Value: TBitmap);
  protected
    procedure DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean); virtual;
    procedure EditButtonClick(Sender: TObject); virtual;
    function GetdxInplaceEditClass : TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
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
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick write FOnEditButtonClick;
  end;

  { TdxInspectorDateRow }
  
  TdxInspectorDateEdit = class(TdxInplaceDateEdit)
  public
    property Date;
  end;

  TdxInspectorDateRow = class(TdxInspectorDropDownRow)
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
    function IsRequired: Boolean; virtual;
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

  { TdxInspectorTextDateRow }
   
  TdxInspectorTextDateRow = class(TdxInspectorDateRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorCheckRow }
  
  TdxInspectorCheckEdit = class(TdxInplaceCheckEdit)
  public
    property Checked;
    property State;
  end;

  TdxInspectorCheckRow = class(TdxInspectorRow)
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
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoChange(Sender: TObject); override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetMinRowHeight(ACanvas: TCanvas): Integer; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsShowHint(IsValue: Boolean; const R: TRect; var AText: string): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    function GetCheckBoxState(const AText: string): TdxCheckBoxState;
    function GetCheckBoxValue(AState: TdxCheckBoxState): string;
  published
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property Border3D: Boolean read FBorder3D write SetBorder3D default False;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property GlyphCount: Integer read FGlyphCount write SetGlyphCount default 6;
    property ShowNullFieldStyle: TdxShowNullFieldStyle read FShowNullFieldStyle write SetShowNullFieldStyle default nsUnchecked;
    property ValueChecked: string read FValueChecked write SetValueChecked;
    property ValueGrayed: string read FValueGrayed write SetValueGrayed;
    property ValueUnchecked: string read FValueUnchecked write SetValueUnchecked;
    property OnToggleClick: TdxToggleEvent read FOnToggleClick write FOnToggleClick;
  end;

  { TdxInspectorTextCheckRow }

  TdxInspectorTextCheckRow = class(TdxInspectorCheckRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorCalcRow }

  TdxInspectorCalcEdit = class(TdxInplaceCalcEdit)
  end;

  TdxInspectorCalcRow = class(TdxInspectorDropDownRow)
  private
    FBeepOnError: Boolean;
    FButtonStyle : TdxButtonStyle;
    FPrecision: Byte;
    FShowButtonFrame: Boolean;
    FQuickClose: Boolean;
  protected
    function GetdxInplaceEditClass : TdxInplaceEditClass; override;
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

  { TdxInspectorTextCalcRow }

  TdxInspectorTextCalcRow = class(TdxInspectorCalcRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorButtonRow }
  
  TdxInspectorButtonEdit = class(TdxInplaceButtonEdit)
  end;

  TdxInspectorButtonRow = class(TdxInspectorDropDownRow)
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
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
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

  { TdxInspectorTextButtonRow }
  
  TdxInspectorTextButtonRow = class(TdxInspectorButtonRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorSpinRow }

  TdxInspectorSpinEdit = class(TdxInplaceSpinEdit)
  public
    property IntValue;
    property Value;
  end;

  TdxSpinRowValue = (srMinValue, srMaxValue);
  TdxSpinRowValues = set of TdxSpinRowValue;

  TdxInspectorSpinRow = class(TdxInspectorRow)
  private
    FAssignedValues: TdxSpinRowValues;
    FEditorEnabled: Boolean;
    FIncrement: Double;
    FMinValue: Double;
    FMaxValue: Double;
    FUseCtrlIncrement: Boolean;
    function IsIncrementStored: Boolean;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    function GetMinValue: Double;
    function GetMaxValue: Double;
    procedure SetMinValue(Value: Double);
    procedure SetMaxValue(Value: Double);
  protected
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function DefaultMinValue: Double; virtual;
    function DefaultMaxValue: Double; virtual;
    function GetValueType: TdxValueType; virtual;
    procedure RestoreDefaults; override;
    property AssignedSpinValues: TdxSpinRowValues read FAssignedValues;
    property ValueType: TdxValueType read GetValueType;
  published
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Increment: Double read FIncrement write FIncrement stored IsIncrementStored;
    property MinValue: Double read GetMinValue write SetMinValue stored IsMinStored;
    property MaxValue: Double read GetMaxValue write SetMaxValue stored IsMaxStored;
    property UseCtrlIncrement: Boolean read FUseCtrlIncrement write FUseCtrlIncrement default True;
  end;

  { TdxInspectorTextSpinRow }

  TdxInspectorTextSpinRow = class(TdxInspectorSpinRow)
  private
    FText: string;
    FValueType: TdxValueType;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    function GetValueType: TdxValueType; override;
  published
    property Text: string read FText write SetText;
    property ValueType: TdxValueType read GetValueType write FValueType default vtInt;
  end;

  { TdxInspectorPickRow }
  
  TdxInspectorPickEdit = class(TdxInplacePickEdit)
  public
    property ItemIndex;
  end;

  TdxInspectorPickColumnCloseUp = procedure(Sender: TObject; var Value: Variant; var Accept: Boolean) of object;

  TdxInspectorPickRow = class(TdxInspectorDropDownRow)
  private
    FDropDownListStyle: Boolean;
    FItems: TStrings;
    FCanDeleteText: Boolean;
    FRevertable: Boolean;
    FSorted: Boolean;
    FOnCloseUp: TdxInspectorPickColumnCloseUp;
    procedure SetItems(Value : TStrings);
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
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown default True;
    property CanDeleteText: Boolean read FCanDeleteText write FCanDeleteText default False;
    property PopupAlignment;
    property PopupBorder;
    property Revertable: Boolean read FRevertable write FRevertable default True;
    property Sorted: Boolean read FSorted write FSorted default False;
    property OnCloseUp: TdxInspectorPickColumnCloseUp read FOnCloseUp write FOnCloseUp;
  end;

  { TdxInspectorTextPickRow }
  
  TdxInspectorTextPickRow = class(TdxInspectorPickRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorImageRow }
  
  TdxInspectorImageEdit = class(TdxInplaceImageEdit)
  end;

  TdxInspectorImageColumnCloseUp = procedure(Sender: TObject; var Value: string; var Accept: Boolean) of object;

  TdxInspectorImageRow = class(TdxInspectorDropDownRow)
  private
    FDefaultImages: Boolean;
    FDescriptions: TStrings;
    FImageChangeLink: TChangeLink;
    FImageIndexes: TStrings;
    FImages: TImageList;
    FLargeImageChangeLink: TChangeLink;
    FLargeImages: TImageList;
    FMultiLineText: Boolean;
    FShowDescription: Boolean;
    FValues: TStrings;
    FOnCloseUp: TdxInspectorImageColumnCloseUp;
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
    function GetMinRowHeight(ACanvas: TCanvas): Integer; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function IsShowHint(IsValue: Boolean; const R: TRect; var AText: string): Boolean; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
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
    property LargeImages: TImageList read FLargeImages write SetLargeImages;
    property ListWidth: Integer read GetListWidth write SetListWidth stored False; // obsolete (use DropDownWidth)
    property MultiLineText: Boolean read FMultiLineText write SetMultiLineText default False;
    property PopupAlignment;
    property PopupBorder;
    property ShowDescription: Boolean read FShowDescription write SetShowDescription default False;
    property Values: TStrings read FValues write SetValues;
    property OnCloseUp: TdxInspectorImageColumnCloseUp read FOnCloseUp write FOnCloseUp;
  end;

  { TdxInspectorTextImageRow }
  
  TdxInspectorTextImageRow = class(TdxInspectorImageRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorTimeRow }
  
  TdxInspectorTimeEdit = class(TdxInplaceTimeEdit)
  public
    property Time;
  end;
  
  TdxInspectorTimeRow = class(TdxInspectorRow)
  private
    FTimeEditFormat: TdxTimeEditFormat;
    FUseCtrlIncrement: Boolean;
  protected
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property TimeEditFormat: TdxTimeEditFormat read FTimeEditFormat write FTimeEditFormat default tfHourMinSec;
    property UseCtrlIncrement: Boolean read FUseCtrlIncrement write FUseCtrlIncrement default True;
  end;

  { TdxInspectorTextTimeRow }
  
  TdxInspectorTextTimeRow = class(TdxInspectorTimeRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorCurrencyRow }

  TdxInspectorCurrencyEdit = class(TdxInplaceCurrencyEdit)
  public
    property Value;
  end;

  TdxInspectorCurrencyRow = class(TdxInspectorRow)
  private
    FAssignedValues: TdxSpinRowValues;
    FDecimalPlaces: Cardinal;
    FDisplayFormat: string;
    FDisplayFormatStored: Boolean;
    FMaxValue: Double;
    FMinValue: Double;
    FNullable: Boolean;
    FNullString: string;
    FUseThousandSeparator: Boolean;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    function GetMinValue: Double;
    function GetMaxValue: Double;
    procedure SetDisplayFormat(const Value: string);
    procedure SetMinValue(Value : Double);
    procedure SetMaxValue(Value : Double);
    procedure SetNullable(Value: Boolean);
    procedure SetNullString(const Value: string);
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetDataValue: Variant; virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
    property Nullable: Boolean read FNullable write SetNullable default False;
    property NullString: string read FNullString write SetNullString;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function DefaultMinValue: Double; virtual;
    function DefaultMaxValue: Double; virtual;
    procedure RestoreDefaults; override;
    property AssignedValues: TdxSpinRowValues read FAssignedValues;
  published
    property DecimalPlaces: Cardinal read FDecimalPlaces write FDecimalPlaces default 2;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat stored FDisplayFormatStored;
    property MinValue: Double read GetMinValue write SetMinValue stored IsMinStored;
    property MaxValue: Double read GetMaxValue write SetMaxValue stored IsMaxStored;
    property UseThousandSeparator: Boolean read FUseThousandSeparator write FUseThousandSeparator default False;
  end;

  { TdxInspectorTextCurrencyRow }
  
  TdxInspectorTextCurrencyRow = class(TdxInspectorCurrencyRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorHyperLinkRow }
  
  TdxInspectorHyperLinkEdit = class(TdxInplaceHyperLinkEdit)
  end;

  TdxInspectorHyperLinkRow = class(TdxInspectorRow)
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
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
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

  { TdxInspectorTextHyperLinkRow }
  
  TdxInspectorTextHyperLinkRow = class(TdxInspectorHyperLinkRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorCustomBlobRow }
  
  TdxInspectorBlobEdit = class(TdxInplaceBlobEdit)
  public
    property Text;
  end;

  TdxInspectorBlobRowGetGraphicClassEvent = procedure(Sender: TObject; var GraphicClass: TGraphicClass) of object;
  TdxInspectorBlobRowAssignPictureEvent = procedure(Sender: TObject; var Picture: TPicture) of object;

  TdxInspectorCustomBlobRow = class(TdxInspectorDropDownRow)
  private
    FAlwaysSaveText: Boolean;
    FBlobEditKind: TdxBlobEditKind;
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
    FOnAssignPicture: TdxInspectorBlobRowAssignPictureEvent;
    FOnGetGraphicClass: TdxInspectorBlobRowGetGraphicClassEvent;
    procedure SetBlobEditKind(Value: TdxBlobEditKind);
    procedure SetBlobKind(Value: TdxBlobKind);
    procedure SetBlobPaintStyle(Value: TdxBlobPaintStyle);
  protected
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoAssignPicture(Sender: TObject; var Picture: TPicture); virtual;
    procedure DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass); virtual;
    procedure DoSavePopupSize(Sender: TObject); virtual;
    function GetBlobData: Variant; virtual;
    function GetBlobEditKind: TdxBlobEditKind; virtual;
    function GetBlobText: string; virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetGraphicClass: TGraphicClass; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
    property BlobEditKind: TdxBlobEditKind read FBlobEditKind write SetBlobEditKind default bekMemo;
    property BlobKind: TdxBlobKind read FBlobKind write SetBlobKind default bkAuto;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    property PictureClipboardFormat: Word read FPictureClipboardFormat write FPictureClipboardFormat;
    property PictureGraphicClass: TGraphicClass read FPictureGraphicClass write FPictureGraphicClass;
  published
    property AlwaysSaveText: Boolean read FAlwaysSaveText write FAlwaysSaveText default False;
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
    property OnAssignPicture: TdxInspectorBlobRowAssignPictureEvent read FOnAssignPicture write FOnAssignPicture;
    property OnGetGraphicClass: TdxInspectorBlobRowGetGraphicClassEvent read FOnGetGraphicClass write FOnGetGraphicClass;
  end;

  { TdxInspectorTextBlobRow }

  TdxInspectorTextBlobRow = class(TdxInspectorCustomBlobRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property BlobEditKind;
    property Text: string read FText write SetText;
  end;

  { TdxInspectorMRURow }

  TdxInspectorMRUEdit = class(TdxInplaceMRUEdit)
  public
    property Text;
  end;

  TdxInspectorMRURow = class(TdxInspectorPickRow)
  private
    FMaxItemCount: Integer;
    FShowEllipsis: Boolean;
    FOnButtonClick: TNotifyEvent;
    procedure SetShowEllipsis(Value: Boolean);
  protected
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoButtonClick(Sender: TObject); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
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

  { TdxInspectorTextMRURow }
  
  TdxInspectorTextMRURow = class(TdxInspectorMRURow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorPopupRow }

  TdxInspectorPopupEdit = class(TdxInplacePopupEdit)
  public
    property Text;
    // original
    property HideEditCursor;
    property PopupAutoSize;
    property PopupControl;
    property PopupFormBorderStyle;
    property PopupFormCaption;
    property PopupClientEdge;
    property PopupFlatBorder;
    property PopupHeight;
    property PopupMinHeight;
    property PopupMinWidth;
    property PopupSizeable;
    property PopupWidth;
  end;

  TdxInspectorPopupRow = class(TdxInspectorDropDownRow)
  private
    FHideEditCursor: Boolean;
    FPopupAutoSize: Boolean;
    FPopupControl: TControl;
    FPopupFormBorderStyle: TdxPopupEditFormBorderStyle;
    FPopupFormCaption: string;
    FPopupFormClientEdge: Boolean;
    FPopupFormFlatBorder: Boolean;
    FPopupFormSizeable: Boolean;
    FPopupHeight: Integer;
    FPopupMinHeight: Integer;
    FPopupMinWidth: Integer;
    FPopupWidth: Integer;
    FOnCloseQuery: TdxPopupEditCloseQueryEvent;
    FOnCloseUp: TdxPopupEditCloseUpEvent;
    FOnInitPopup: TNotifyEvent;
    FOnPopup: TdxPopupEditPopupEvent;
    procedure SetPopupControl(Value: TControl);
    procedure SetPopupHeight(Value: Integer);
    procedure SetPopupMinHeight(Value: Integer);
    procedure SetPopupMinWidth(Value: Integer);
    procedure SetPopupWidth(Value: Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoCloseQuery(Sender: TObject; var CanClose: Boolean); virtual;
    procedure DoCloseUp(Sender: TObject; var Text: string; var Accept: Boolean);
      {$IFDEF DELPHI4} reintroduce; {$ENDIF} virtual;
    procedure DoInitPopup(Sender: TObject); virtual;
    procedure DoPopup(Sender: TObject; const EditText: string); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property HideEditCursor: Boolean read FHideEditCursor write FHideEditCursor default False;
    property PopupAutoSize: Boolean read FPopupAutoSize write FPopupAutoSize default True;
    property PopupControl: TControl read FPopupControl write SetPopupControl;
    property PopupFormBorderStyle: TdxPopupEditFormBorderStyle read FPopupFormBorderStyle write FPopupFormBorderStyle default pbsDialog;
    property PopupFormCaption: string read FPopupFormCaption write FPopupFormCaption;
    property PopupFormClientEdge: Boolean read FPopupFormClientEdge write FPopupFormClientEdge default False;
    property PopupFormFlatBorder: Boolean read FPopupFormFlatBorder write FPopupFormFlatBorder default True;
    property PopupFormSizeable: Boolean read FPopupFormSizeable write FPopupFormSizeable default True;
    property PopupHeight: Integer read FPopupHeight write SetPopupHeight default 200;
    property PopupMinHeight: Integer read FPopupMinHeight write SetPopupMinHeight default 100;
    property PopupMinWidth: Integer read FPopupMinWidth write SetPopupMinWidth default 100;
    property PopupWidth: Integer read FPopupWidth write SetPopupWidth default 250;
    property OnCloseQuery: TdxPopupEditCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    property OnCloseUp: TdxPopupEditCloseUpEvent read FOnCloseUp write FOnCloseUp;
    property OnInitPopup: TNotifyEvent read FOnInitPopup write FOnInitPopup;
    property OnPopup: TdxPopupEditPopupEvent read FOnPopup write FOnPopup;
  end;

  { TdxInspectorTextPopupRow }

  TdxInspectorTextPopupRow = class(TdxInspectorPopupRow)
  private
    FText: string;
    procedure SetText(const Value: string);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorMemoRow }

  TdxInspectorMemoEdit = class(TdxInplaceMemoEdit)
  end;

  TdxInspectorMemoRow = class(TdxInspectorRow)
  private
    FHideScrollBars: Boolean;
    FScrollBars: TScrollStyle;
    FSelectionBar: Boolean;
    FWantReturns: Boolean;
    FWantTabs: Boolean;
    FWordWrap: Boolean;
    procedure SetSelectionBar(Value: Boolean);
  protected
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetMemoText: string; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property HideScrollBars: Boolean read FHideScrollBars write FHideScrollBars default True;
    property ScrollBars: TScrollStyle read FScrollBars write FScrollBars default ssNone;
    property SelectionBar: Boolean read FSelectionBar write SetSelectionBar default False;
    property WantReturns: Boolean read FWantReturns write FWantReturns default True;
    property WantTabs: Boolean read FWantTabs write FWantTabs default False;
    property WordWrap: Boolean read FWordWrap write FWordWrap default True;
  end;

  { TdxInspectorTextMemoRow }

  TdxInspectorTextMemoRow = class(TdxInspectorMemoRow)
  private
    FText: string;
    procedure SetText(const Value: String);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

  { TdxInspectorGraphicRow }

  TdxInspectorGraphicEdit = class(TdxInplaceGraphicEdit)
  public
    property ClipboardFormat;
    property Picture;
    property ToolbarPos;
  end;

  TdxGraphicEditGetGraphicClassEvent = procedure(Sender: TObject; var GraphicClass: TGraphicClass) of object;

  TdxInspectorGraphicRow = class(TdxInspectorRow)
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
    FStretch: Boolean;
    FOnAssignPicture: TdxGraphicEditAssignPictureEvent;
    FOnCustomClick: TNotifyEvent;
    FOnGetGraphicClass: TdxGraphicEditGetGraphicClassEvent;
    procedure LoadPictureFromText(APicture: TPicture);
    procedure SetCenter(Value: Boolean);
    procedure SetCustomGraphic(Value: Boolean);
    procedure SetGraphicTransparency(Value: TdxGraphicEditTransparency);
    procedure SetPopupToolBar(Value: TdxPopupToolBarWindow);
    procedure SetPopupToolbarPosStored(Value: Boolean);
    procedure SetQuickDraw(Value: Boolean);
    procedure SetStretch(Value: Boolean);
  protected
    function AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure DoAssignPicture(Sender: TObject; var Picture: TPicture); virtual;
    procedure DoCustomClick(Sender: TObject); virtual;
    procedure DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetGraphicClass: TGraphicClass; virtual;
    function GetGraphicValue: Variant; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData); override;
    property Picture: TPicture read FPicture;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    property ClipboardFormat: Word read FClipboardFormat write FClipboardFormat;
    property PopupToolbarPos: TPoint read FPopupToolbarPos write FPopupToolbarPos;
  published
    property Center: Boolean read FCenter write SetCenter default True;
    property CustomFilter: string read FCustomFilter write FCustomFilter;
    property CustomGraphic: Boolean read FCustomGraphic write SetCustomGraphic default False;
    property DblClickActivate: Boolean read FDblClickActivate write FDblClickActivate default True;
    property GraphicTransparency: TdxGraphicEditTransparency read FGraphicTransparency write SetGraphicTransparency default gtDefault;
    property PopupToolBar: TdxPopupToolBarWindow read FPopupToolBar write SetPopupToolBar;
    property PopupToolbarPosStored: Boolean read FPopupToolbarPosStored write SetPopupToolbarPosStored default True;
    property QuickDraw: Boolean read FQuickDraw write SetQuickDraw default False;
    property Stretch: Boolean read FStretch write SetStretch default True;
    property OnAssignPicture: TdxGraphicEditAssignPictureEvent read FOnAssignPicture write FOnAssignPicture;
    property OnCustomClick: TNotifyEvent read FOnCustomClick write FOnCustomClick;
    property OnGetGraphicClass: TdxGraphicEditGetGraphicClassEvent read FOnGetGraphicClass write FOnGetGraphicClass;
  end;

  { TdxInspectorTextGraphicRow }

  TdxInspectorTextGraphicRow = class(TdxInspectorGraphicRow)
  private
    FText: string;
    procedure SetText(const Value: String);
  protected
    function GetDisplayText: string; override;
    function GetEditText: string; override;
    procedure SetEditText(const Value: string); override;
  published
    property Text: string read FText write SetText;
  end;

const
  sdxInspCheckTextTrue: string =  'True';
  sdxInspCheckTextFalse: string = 'False';

implementation

uses
  Forms, Clipbrd;

{ TdxInspectorMaskRow }

procedure TdxInspectorMaskRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorMaskRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      EditMask := TdxInspectorMaskRow(Source).EditMask;
      IgnoreMaskBlank := TdxInspectorMaskRow(Source).IgnoreMaskBlank;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorMaskRow.DefaultEditMask: string;
begin
  Result := '';
end;

procedure TdxInspectorMaskRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  EditMask := DefaultEditMask;
  FIgnoreMaskBlank := False;
  FAssignedEditMask := False;
end;

function TdxInspectorMaskRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceMaskEdit then
  begin
    EditText := TdxInspectorMaskEdit(AInplaceEdit).Text;
    Result := EditText;
  end
  else
    Result := inherited AssignEditValue(AInplaceEdit);
end;

function TdxInspectorMaskRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorMaskEdit;
end;

procedure TdxInspectorMaskRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMaskEdit then
    with TdxInspectorMaskEdit(AInplaceEdit) do
    begin
      EditMask := Self.EditMask;
      IgnoreMaskBlank := Self.IgnoreMaskBlank;
    end;
end;

function TdxInspectorMaskRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  TdxInspectorMaskEdit(AInplaceEdit).Text := EditText;
  Result := TdxInspectorMaskEdit(AInplaceEdit).Text;
end;

function TdxInspectorMaskRow.GetEditMask: string;
begin
  if FAssignedEditMask then
    Result := FEditMask
  else
    Result := DefaultEditMask;
end;

function TdxInspectorMaskRow.IsEditMaskStored: Boolean;
begin
  Result := FAssignedEditMask and (FEditMask <> DefaultEditMask);
end;

procedure TdxInspectorMaskRow.SetEditMask(const Value: string);
begin
  if FEditMask <> Value then
  begin
    FEditMask := Value;
    FAssignedEditMask := True;
  end;
end;

{ TdxInspectorTextMaskRow }

function TdxInspectorTextMaskRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextMaskRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextMaskRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextMaskRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorDropDownRow }

constructor TdxInspectorDropDownRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropDownRows := 7;
end;

destructor TdxInspectorDropDownRow.Destroy;
begin
  FButtonGlyph.Free;
  inherited Destroy;
end;

procedure TdxInspectorDropDownRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDropDownRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      DropDownRows := TdxInspectorDropDownRow(Source).DropDownRows;
      DropDownWidth := TdxInspectorDropDownRow(Source).DropDownWidth;
      ImmediateDropDown := TdxInspectorDropDownRow(Source).ImmediateDropDown;
      ImmediatePopup := TdxInspectorDropDownRow(Source).ImmediatePopup;
      PopupAlignment := TdxInspectorDropDownRow(Source).PopupAlignment;
      PopupBorder := TdxInspectorDropDownRow(Source).PopupBorder;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorDropDownRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDropDownRows := 7;
  FDropDownWidth := 0;
  FImmediateDropDown := False;
  FImmediatePopup := False;
  FPopupAlignment := taLeftJustify;
  FPopupBorder := pbDefault;
end;

procedure TdxInspectorDropDownRow.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
begin
end;

procedure TdxInspectorDropDownRow.EditButtonClick(Sender: TObject);
begin
  if Assigned(FOnEditButtonClick) then FOnEditButtonClick(Self);
end;

function TdxInspectorDropDownRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorDropDownEdit;
end;

procedure TdxInspectorDropDownRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceDropDownEdit then
    with TdxInspectorDropDownEdit(AInplaceEdit) do
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

procedure TdxInspectorDropDownRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
    if AViewData is TdxDropDownEditViewData then
      with TdxDropDownEditViewData(AViewData) do
      begin
        ButtonGlyph := Self.FButtonGlyph;
        HideButtons := True;
        ActiveButtonIndex := -1;
        PressedButtonIndex := -1;
      end;
end;

function TdxInspectorDropDownRow.GetButtonGlyph: TBitmap;
begin
  if FButtonGlyph = nil then FButtonGlyph := TBitmap.Create;
  Result := FButtonGlyph;
end;

procedure TdxInspectorDropDownRow.SetButtonGlyph(Value: TBitmap);
begin
  if (Value = nil) or Value.Empty then
  begin
    FButtonGlyph.Free;
    FButtonGlyph := nil;
  end
  else
    ButtonGlyph.Assign(Value);
  Changed;
end;

{ TdxInspectorDateRow }

constructor TdxInspectorDateRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDateButtons := [btnToday, btnClear];
  FSaveTime := True;
end;

procedure TdxInspectorDateRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorDateRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      DateButtons := TdxInspectorDateRow(Source).DateButtons;
      SaveTime := TdxInspectorDateRow(Source).SaveTime;
      DateOnError := TdxInspectorDateRow(Source).DateOnError;
      DateValidation := TdxInspectorDateRow(Source).DateValidation;
      UseEditMask := TdxInspectorDateRow(Source).UseEditMask;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorDateRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDateButtons := [btnToday, btnClear];
  FDateOnError := deToday;
  FSaveTime := True;
  FDateValidation := False;
  FUseEditMask := False;
end;

function TdxInspectorDateRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorDateEdit;
end;

procedure TdxInspectorDateRow.DoValidateInput(Sender: TObject; const AText: string;
  var ADate: TDateTime; var AMessage: string; var AError: Boolean);
begin
  if Assigned(FOnDateValidateInput) then
    FOnDateValidateInput(Self, AText, ADate, AMessage, AError);
end;

procedure TdxInspectorDateRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceDateEdit then
    with TdxInspectorDateEdit(AInplaceEdit) do
    begin
      DateButtons := Self.DateButtons;
      if Self.IsRequired then
        DateButtons := DateButtons - [btnClear];
      DateOnError := Self.DateOnError;
      DateValidation := Self.DateValidation;
      SaveTime := Self.SaveTime;
      UseEditMask := Self.UseEditMask;
      OnDateValidateInput := Self.DoValidateInput;
    end;
end;

function TdxInspectorDateRow.IsRequired: Boolean;
begin
  Result := False;
end;

{ TdxInspectorTextDateRow }
function TdxInspectorTextDateRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextDateRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextDateRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextDateRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorCheckRow }

constructor TdxInspectorCheckRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGlyphCount := 6;
  FValueChecked := sdxInspCheckTextTrue;
  FValueUnchecked := sdxInspCheckTextFalse;
end;

destructor TdxInspectorCheckRow.Destroy;
begin
  FGlyph.Free;
  inherited Destroy;
end;

procedure TdxInspectorCheckRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorCheckRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      AllowGrayed := TdxInspectorCheckRow(Source).AllowGrayed;
      Border3D := TdxInspectorCheckRow(Source).Border3D;
      if TdxInspectorCheckRow(Source).FGlyph <> nil then
        Glyph := TdxInspectorCheckRow(Source).Glyph;
      GlyphCount := TdxInspectorCheckRow(Source).GlyphCount;
      ShowNullFieldStyle := TdxInspectorCheckRow(Source).ShowNullFieldStyle;
      ValueChecked := TdxInspectorCheckRow(Source).ValueChecked;
      ValueGrayed := TdxInspectorCheckRow(Source).ValueGrayed;
      ValueUnChecked := TdxInspectorCheckRow(Source).ValueUnChecked;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorCheckRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAllowGrayed := False;
  FBorder3D := False;
  FGlyph.Free;
  FGlyph := nil;
  FGlyphCount := 6;
  FShowNullFieldStyle := nsUnchecked;
  FValueChecked := sdxInspCheckTextTrue;
  FValueGrayed := '';
  FValueUnchecked := sdxInspCheckTextFalse;
end;

function TdxInspectorCheckRow.GetCheckBoxState(const AText: string): TdxCheckBoxState;
begin
  Result := cbsGrayed;
  if AnsiCompareText(AText, FValueChecked) = 0 then
    Result := cbsChecked
  else
    if AnsiCompareText(AText, FValueUnChecked) = 0 then
      Result := cbsUnchecked;
end;

function TdxInspectorCheckRow.GetCheckBoxValue(AState: TdxCheckBoxState): string;
begin
  case AState of
    cbsChecked: Result := FValueChecked;
    cbsUnchecked: Result := FValueUnChecked;
  else
    Result := FValueGrayed;
  end;
end;

function TdxInspectorCheckRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceCheckEdit then
    EditText := GetCheckBoxValue(TdxInspectorCheckEdit(AInplaceEdit).State);
  Result := EditText;
end;

procedure TdxInspectorCheckRow.DoChange(Sender: TObject);
var
  AState: TdxCheckBoxState;
begin
  inherited DoChange(Sender);
  if (Inspector <> nil) and not Inspector.IsInitEdit then
    if (Sender is TdxInplaceCheckEdit) and Assigned(FOnToggleClick) then
    begin
      AState := TdxInspectorCheckEdit(Sender).State;
      FOnToggleClick(Self, GetCheckBoxValue(AState), AState);
    end;
end;

function TdxInspectorCheckRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorCheckEdit;
end;

function TdxInspectorCheckRow.GetMinRowHeight(ACanvas: TCanvas): Integer;
var
  ACheckWidth, ACheckHeight: Integer;
begin
  if (FGlyph <> nil) and TdxInplaceCheckEdit.CalcCheckSize(Glyph, GlyphCount, ACheckWidth, ACheckHeight) then
    Result := ACheckHeight
  else
    Result := FCheckHeight + 2;
end;

procedure TdxInspectorCheckRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCheckEdit then
    with TdxInspectorCheckEdit(AInplaceEdit) do
    begin
      Alignment := taCenter;
      AllowGrayed := Self.AllowGrayed;
      if Border3D then
        Style.ButtonStyle := bts3D
      else
        Style.ButtonStyle := btsSimple;
      Glyph := Self.Glyph;
      GlyphCount := Self.GlyphCount;
      NullStyle := Self.ShowNullFieldStyle;
    end;
end;

function TdxInspectorCheckRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited InitEditValue(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCheckEdit then
    with TdxInspectorCheckEdit(AInplaceEdit) do
      State := GetCheckBoxState(Result);
end;

function TdxInspectorCheckRow.IsShowHint(IsValue: Boolean; const R: TRect; var AText: string): Boolean;
begin
  if not IsValue then
    Result := inherited IsShowHint(IsValue, R, AText)
  else
    Result := False;
end;

procedure TdxInspectorCheckRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
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
      else
        ButtonStyle := btsSimple;
      Glyph := Self.Glyph;
      GlyphCount := Self.GlyphCount;
      NullStyle := Self.ShowNullFieldStyle;
    end;
end;

function TdxInspectorCheckRow.GetGlyph: TBitmap;
begin
  if FGlyph = nil then
    FGlyph := TBitmap.Create;
  Result := FGlyph;
end;

procedure TdxInspectorCheckRow.SetBorder3D(Value: Boolean);
begin
  if Border3D <> Value then
  begin
    FBorder3D := Value;
    Changed;
  end;
end;

procedure TdxInspectorCheckRow.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
  begin
    FGlyph.Free;
    FGlyph := nil;
  end
  else
    Glyph.Assign(Value);
  Changed;
end;

procedure TdxInspectorCheckRow.SetGlyphCount(Value: Integer);
begin
  if FGlyphCount <> Value then
  begin
    FGlyphCount := Value;
    if FGlyph <> nil then
      Changed;
  end;
end;

procedure TdxInspectorCheckRow.SetShowNullFieldStyle(Value: TdxShowNullFieldStyle);
begin
  if ShowNullFieldStyle <> Value then
  begin
    FShowNullFieldStyle := Value;
    Changed;
  end;
end;

procedure TdxInspectorCheckRow.SetValueChecked(const Value: String);
begin
  if FValueChecked <> Value then
  begin
    FValueChecked := Value;
    Changed;
  end;
end;

procedure TdxInspectorCheckRow.SetValueGrayed(const Value: string);
begin
  if FValueGrayed <> Value then
  begin
    FValueGrayed := Value;
    Changed;
  end;
end;

procedure TdxInspectorCheckRow.SetValueUnchecked(const Value: string);
begin
  if FValueUnchecked <> Value then
  begin
    FValueUnchecked := Value;
    Changed;
  end;
end;

{ TdxInspectorTextCheckRow }
function TdxInspectorTextCheckRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextCheckRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextCheckRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextCheckRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorCalcRow }

constructor TdxInspectorCalcRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBeepOnError := True;
  FButtonStyle := bsStandard;
  FPrecision := dxDefCalcPrecision;
end;

procedure TdxInspectorCalcRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorCalcRow then
  begin
    inherited Assign(Source);
    BeepOnError := TdxInspectorCalcRow(Source).BeepOnError;
    ButtonStyle := TdxInspectorCalcRow(Source).ButtonStyle;
    Precision := TdxInspectorCalcRow(Source).Precision;
    QuickClose := TdxInspectorCalcRow(Source).QuickClose;
    ShowButtonFrame := TdxInspectorCalcRow(Source).ShowButtonFrame;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorCalcRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FBeepOnError := True;
  FButtonStyle := bsStandard;
  FPrecision := dxDefCalcPrecision;
  FQuickClose := False;
  FShowButtonFrame := False;
end;

function TdxInspectorCalcRow.GetdxInplaceEditClass: TdxInplaceEditClass; 
begin
  Result := TdxInspectorCalcEdit;
end;

procedure TdxInspectorCalcRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCalcEdit then
    with TdxInspectorCalcEdit(AInplaceEdit) do
    begin
      BeepOnError := Self.BeepOnError;
      ButtonStyle := Self.ButtonStyle;
      Precision := Self.Precision;
      QuickClose := Self.QuickClose;
      ShowButtonFrame := Self.ShowButtonFrame;
    end;
end;

{ TdxInspectorTextCalcRow }
function TdxInspectorTextCalcRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextCalcRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextCalcRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextCalcRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorButtonRow }

type
  TdxRowEditButtons = class(TdxEditButtons)
    procedure Update(Item: TCollectionItem); override;
  end;

procedure TdxRowEditButtons.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Owner is TdxInspectorButtonRow then
    (Owner as TdxInspectorButtonRow).Changed;
end;

constructor TdxInspectorButtonRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TdxRowEditButtons.Create(Self, TdxEditButton);
  FButtons.Add;
  FEditButtonStyle := ebsEllipsis;
  FClickKey := VK_RETURN + scCtrl;
  FGlyph := TBitmap.Create;
end;

destructor TdxInspectorButtonRow.Destroy;
begin
  FButtons.Free;
  FGlyph.Free;
  inherited Destroy;
end;

procedure TdxInspectorButtonRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorButtonRow then
  begin
    inherited Assign(Source);
    ButtonOnly := TdxInspectorButtonRow(Source).ButtonOnly;
    Buttons := TdxInspectorButtonRow(Source).Buttons;
    EditButtonStyle := TdxInspectorButtonRow(Source).EditButtonStyle;
    ClickKey := TdxInspectorButtonRow(Source).ClickKey;
    Glyph := TdxInspectorButtonRow(Source).Glyph;
    HideEditCursor := TdxInspectorButtonRow(Source).HideEditCursor;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorButtonRow.RestoreDefaults;
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

procedure TdxInspectorButtonRow.DoButtonClick(Sender: TObject; AbsoluteIndex: Integer);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self, AbsoluteIndex);
end;

function TdxInspectorButtonRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorButtonEdit;
end;

procedure TdxInspectorButtonRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceButtonEdit then
    with TdxInspectorButtonEdit(AInplaceEdit) do
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

procedure TdxInspectorButtonRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxButtonEditViewData then
    with TdxButtonEditViewData(AViewData) do
    begin
      if not HideButtons then
      begin
        ButtonOnly := Self.ButtonOnly;
        EditButtons := Self.Buttons;
      end
      else
      begin
        ButtonOnly := False;
        EditButtons := nil;
      end;
      HideEditCursor := Self.HideEditCursor;
    end;
end;

procedure TdxInspectorButtonRow.SetButtonOnly(Value: Boolean);
begin
  if FButtonOnly <> Value then
  begin
    FButtonOnly := Value;
    Changed;
  end;
end;

procedure TdxInspectorButtonRow.SetButtons(Value: TdxEditButtons);
begin
  Buttons.Assign(Value);
end;

procedure TdxInspectorButtonRow.SetEditButtonStyle(Value: TdxEditButtonStyle);
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
    Changed;
  end;
end;

procedure TdxInspectorButtonRow.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
  if Buttons.Count > 0 then
    Buttons[0].Glyph.Assign(FGlyph);
end;

procedure TdxInspectorButtonRow.SetHideEditCursor(Value: Boolean);
begin
  if FHideEditCursor <> Value then
  begin
    FHideEditCursor := Value;
    Changed;
  end;
end;

{ TdxInspectorTextButtonRow }
function TdxInspectorTextButtonRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextButtonRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextButtonRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextButtonRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorSpinRow }

constructor TdxInspectorSpinRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEditorEnabled := True;
  FIncrement := 1.0;
  FUseCtrlIncrement := True;
end;

procedure TdxInspectorSpinRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorSpinRow then
  begin
    inherited Assign(Source);
    EditorEnabled := TdxInspectorSpinRow(Source).EditorEnabled;
    Increment := TdxInspectorSpinRow(Source).Increment;
    MinValue := TdxInspectorSpinRow(Source).MinValue;
    MaxValue := TdxInspectorSpinRow(Source).MaxValue;
    UseCtrlIncrement := TdxInspectorSpinRow(Source).UseCtrlIncrement;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorSpinRow.DefaultMinValue: Double;
begin
  Result := 0.0;
end;

function TdxInspectorSpinRow.DefaultMaxValue: Double;
begin
  Result := 0.0;
end;

procedure TdxInspectorSpinRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAssignedValues := [];
  FEditorEnabled := True;
  FIncrement := 1.0;
  FMinValue := 0.0;
  FMaxValue := 0.0;
  FUseCtrlIncrement := True;
end;

// protected TdxInspectorSpinRow
function TdxInspectorSpinRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceSpinEdit then
    with TdxInspectorSpinEdit(AInplaceEdit) do
      if ValueType = vtFloat then
        Self.EditText := FloatToStrF(Value, ffGeneral, 15, 0)
      else
        Self.EditText := IntToStr(Round(Value));
  Result := EditText;
end;

function TdxInspectorSpinRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorSpinEdit;
end;

function TdxInspectorSpinRow.GetValueType: TdxValueType;
begin
  Result := vtInt;
end;

procedure TdxInspectorSpinRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceSpinEdit then
    with TdxInspectorSpinEdit(AInplaceEdit) do
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

function TdxInspectorSpinRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited InitEditValue(AInplaceEdit);
  if AInplaceEdit is TdxInplaceSpinEdit then
    with TdxInspectorSpinEdit(AInplaceEdit) do
    try
      if Result <> '' then
        Value := StrToFloat(Result)
      else
        Value := 0;
      Result := Value;
    except
      on EConvertError do
        Value := 0;
    end;
end;

procedure TdxInspectorSpinRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
    if AViewData is TdxSpinEditViewData then
      with TdxSpinEditViewData(AViewData) do
      begin
        ShowButton := False; // TODO 
      end;
end;

function TdxInspectorSpinRow.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1.0;
end;

function TdxInspectorSpinRow.IsMaxStored: Boolean;
begin
  Result := (srMaxValue in FAssignedValues) and (MaxValue <> DefaultMaxValue);
end;

function TdxInspectorSpinRow.IsMinStored: Boolean;
begin
  Result := (srMinValue in FAssignedValues) and (MinValue <> DefaultMinValue);
end;

function TdxInspectorSpinRow.GetMinValue: Double;
begin
  if srMinValue in FAssignedValues then
    Result := FMinValue
  else
    Result := DefaultMinValue;
end;

function TdxInspectorSpinRow.GetMaxValue: Double;
begin
  if srMaxValue in FAssignedValues then
    Result := FMaxValue
  else
    Result := DefaultMaxValue;
end;

procedure TdxInspectorSpinRow.SetMinValue(Value: Double);
begin
  if (srMinValue in FAssignedValues) and (Value = FMinValue) then Exit;
  FMinValue := Value;
  Include(FAssignedValues, srMinValue);
end;

procedure TdxInspectorSpinRow.SetMaxValue(Value: Double);
begin
  if (srMaxValue in FAssignedValues) and (Value = FMaxValue) then Exit;
  FMaxValue := Value;
  Include(FAssignedValues, srMaxValue);
end;

{ TdxInspectorTextSpinRow }
procedure TdxInspectorTextSpinRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorTextSpinRow then
  begin
    inherited Assign(Source);
    ValueType := TdxInspectorTextSpinRow(Source).ValueType;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorTextSpinRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FValueType := vtInt;
end;

function TdxInspectorTextSpinRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextSpinRow.GetEditText: string;
begin
  Result := FText;
end;

function TdxInspectorTextSpinRow.GetValueType: TdxValueType;
begin
  Result := FValueType;
end;

procedure TdxInspectorTextSpinRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextSpinRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorPickRow }

constructor TdxInspectorPickRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TStringList.Create;
  ImmediateDropDown := True;
  FRevertable := True;
end;

destructor TdxInspectorPickRow.Destroy;
begin
  FItems.Free;
  FItems := nil;
  inherited Destroy;
end;

procedure TdxInspectorPickRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorPickRow then
  begin
    inherited Assign(Source);
    DropDownListStyle := TdxInspectorPickRow(Source).DropDownListStyle;
    Items.Assign(TdxInspectorPickRow(Source).Items);
    CanDeleteText := TdxInspectorPickRow(Source).CanDeleteText;
    Revertable := TdxInspectorPickRow(Source).Revertable;
    Sorted := TdxInspectorPickRow(Source).Sorted;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorPickRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDropDownListStyle := False;
  ImmediateDropDown := True;
  FCanDeleteText := False;
  FRevertable := True;
  FSorted := False;
end;

procedure TdxInspectorPickRow.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
var
  V: Variant;
begin
  V := Value;
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, V, Accept);
  Value := V;
end;

function TdxInspectorPickRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorPickEdit;
end;

procedure TdxInspectorPickRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplacePickEdit then
    with TdxInspectorPickEdit(AInplaceEdit) do
    begin
      DropDownListStyle := Self.DropDownListStyle;
      Items := Self.Items;
      CanDeleteText := Self.CanDeleteText;
      Revertable := Self.Revertable;
      Sorted := Self.Sorted;
    end;
end;

procedure TdxInspectorPickRow.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
  Changed;
end;

{ TdxInspectorTextPickRow }
function TdxInspectorTextPickRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextPickRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextPickRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextPickRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorImageRow }

constructor TdxInspectorImageRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
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

destructor TdxInspectorImageRow.Destroy;
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

procedure TdxInspectorImageRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorImageRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      DefaultImages := TdxInspectorImageRow(Source).DefaultImages;
      Descriptions.Assign(TdxInspectorImageRow(Source).Descriptions);
      Images := TdxInspectorImageRow(Source).Images;
      ImageIndexes.Assign(TdxInspectorImageRow(Source).ImageIndexes);
      LargeImages := TdxInspectorImageRow(Source).LargeImages;
      MultiLineText := TdxInspectorImageRow(Source).MultiLineText;
      ShowDescription := TdxInspectorImageRow(Source).ShowDescription;
      Values.Assign(TdxInspectorImageRow(Source).Values);
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorImageRow.GetImageIndex(const AText: string): Integer;
var
  ATempIndex: Integer;
begin
  TdxInplaceImageEdit.CalcViewIndexes(AText,
    ImageIndexes, Descriptions, Values, DefaultImages,
    Result, ATempIndex);
end;

procedure TdxInspectorImageRow.GetIndexes(const AText: string; var AImageIndex, ADescIndex: Integer);
begin
  TdxInplaceImageEdit.CalcViewIndexes(AText,
    ImageIndexes, Descriptions, Values, DefaultImages,
    AImageIndex, ADescIndex);
end;

procedure TdxInspectorImageRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDefaultImages := True;
  FMultiLineText := False;
  FShowDescription := False;
end;

//protected TdxInspectorImageRow
procedure TdxInspectorImageRow.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = LargeImages then LargeImages := nil;
  end;
end;

procedure TdxInspectorImageRow.DoCloseUp(Sender: TObject; var Value: string; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Value, Accept);
end;

function TdxInspectorImageRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorImageEdit;
end;

function TdxInspectorImageRow.GetMinRowHeight(ACanvas: TCanvas): Integer;
begin
  Result := inherited GetMinRowHeight(ACanvas);
  if (Images <> nil) and (Images.Height > Result) then
    Result := Images.Height;
end;

procedure TdxInspectorImageRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceImageEdit then
    with TdxInspectorImageEdit(AInplaceEdit) do
    begin
      DefaultImages := Self.DefaultImages;
      Descriptions := Self.Descriptions;
      Images := Self.Images;
      ImageIndexes := Self.ImageIndexes;
      LargeImages := Self.LargeImages;
      MultiLineText := Self.MultiLineText;
      ShowDescription := Self.ShowDescription;
      Values := Self.Values;
    end;
end;

type TWinControlCracker = class(TWinControl);

function TdxInspectorImageRow.IsShowHint(IsValue: Boolean; const R: TRect; var AText: string): Boolean;
var
  I1, I2, W: Integer;
begin
  if not IsValue then
    Result := inherited IsShowHint(IsValue, R, AText)
  else
  begin
    Result := False;
    if (Inspector <> nil) and Inspector.HandleAllocated then
    begin
      GetIndexes(EditText, I1, I2);
      if (0 <= I2) and (I2 < FDescriptions.Count) then
      begin
        AText := FDescriptions[I2];
        if AText <> '' then
        begin
          Inspector.Canvas.Font.Assign(TWinControlCracker(Inspector).Font);
          W := Inspector.Canvas.TextWidth(AText);
          if (Images <> nil) then Inc(W, Images.Width);
          Result := W > (R.Right - R.Left);
        end;
      end;
    end;
  end;
end;

procedure TdxInspectorImageRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
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

function TdxInspectorImageRow.GetListWidth: Integer;
begin
  Result := DropDownWidth;
end;

procedure TdxInspectorImageRow.ImageListChange(Sender: TObject);
begin
  if (Sender = Images) then Changed;
end;

procedure TdxInspectorImageRow.SetImages(Value: TImageList);
begin
  if Images <> nil then
     Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Value <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Value.FreeNotification(Self);
  end;
  Changed;
end;

procedure TdxInspectorImageRow.SetLargeImages(Value: TImageList);
begin
  if LargeImages <> nil then
    LargeImages.UnRegisterChanges(FLargeImageChangeLink);
  FLargeImages := Value;
  if Value <> nil then
  begin
    LargeImages.RegisterChanges(FLargeImageChangeLink);
    Value.FreeNotification(Self);
  end;
  Changed;
end;

procedure TdxInspectorImageRow.SetImageIndexes(Value: TStrings);
begin
  FImageIndexes.Assign(Value);
  Changed;
end;

procedure TdxInspectorImageRow.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
  Changed;
end;

procedure TdxInspectorImageRow.SetDescriptions(Value: TStrings);
begin
  FDescriptions.Assign(Value);
  Changed;
end;

procedure TdxInspectorImageRow.SetShowDescription(Value: Boolean);
begin
  if ShowDescription <> Value then
  begin
    FShowDescription := Value;
    Changed;
  end;
end;

procedure TdxInspectorImageRow.SetDefaultImages(Value: Boolean);
begin
  if DefaultImages <> Value then
  begin
    FDefaultImages := Value;
    Changed;
  end;
end;

procedure TdxInspectorImageRow.SetListWidth(Value: Integer);
begin
  DropDownWidth := Value;
end;

procedure TdxInspectorImageRow.SetMultiLineText(Value: Boolean);
begin
  if FMultiLineText <> Value then
  begin
    FMultiLineText := Value;
    Changed;
  end;
end;

{ TdxInspectorTextImageRow }
function TdxInspectorTextImageRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextImageRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextImageRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextImageRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorTimeRow }

constructor TdxInspectorTimeRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FUseCtrlIncrement := True;
end;

procedure TdxInspectorTimeRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorTimeRow then
  begin
    inherited Assign(Source);
    TimeEditFormat := TdxInspectorTimeRow(Source).TimeEditFormat;
    UseCtrlIncrement := TdxInspectorTimeRow(Source).UseCtrlIncrement;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorTimeRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FTimeEditFormat := tfHourMinSec;
  FUseCtrlIncrement := True;
end;

function TdxInspectorTimeRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceTimeEdit then
    with TdxInspectorTimeEdit(AInplaceEdit) do
      if Time = 0 then
        Self.EditText := ''
      else
        Self.EditText := EditText;
  Result := EditText;
end;

function TdxInspectorTimeRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorTimeEdit;
end;

procedure TdxInspectorTimeRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceTimeEdit then
    with TdxInspectorTimeEdit(AInplaceEdit) do
    begin
      TimeEditFormat := Self.TimeEditFormat;
      UseCtrlIncrement := Self.UseCtrlIncrement;
    end;
end;

{ TdxInspectorTextTimeRow }
function TdxInspectorTextTimeRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextTimeRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextTimeRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextTimeRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorCurrencyRow }

constructor TdxInspectorCurrencyRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDecimalPlaces := 2;
  FDisplayFormat := DefaultCurrencyDisplayFormat;
end;

procedure TdxInspectorCurrencyRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorCurrencyRow then
  begin
    inherited Assign(Source);
    DecimalPlaces := TdxInspectorCurrencyRow(Source).DecimalPlaces;
    DisplayFormat := TdxInspectorCurrencyRow(Source).DisplayFormat;
    MinValue := TdxInspectorCurrencyRow(Source).MinValue;
    MaxValue := TdxInspectorCurrencyRow(Source).MaxValue;
    Nullable := TdxInspectorCurrencyRow(Source).Nullable;
    NullString := TdxInspectorCurrencyRow(Source).NullString;
    UseThousandSeparator := TdxInspectorCurrencyRow(Source).UseThousandSeparator;
  end
  else
    inherited Assign(Source);
end;

function TdxInspectorCurrencyRow.DefaultMinValue: Double;
begin
  Result := 0.0;
end;

function TdxInspectorCurrencyRow.DefaultMaxValue: Double;
begin
  Result := 0.0;
end;

procedure TdxInspectorCurrencyRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAssignedValues := [];
  FDecimalPlaces := 2;
  FDisplayFormat := DefaultCurrencyDisplayFormat;
  FDisplayFormatStored := False;
  FMinValue := 0.0;
  FMaxValue := 0.0;
  FNullable := False;
  FNullString := '';
  FUseThousandSeparator := False;
end;

function TdxInspectorCurrencyRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
var
  V: Variant;
begin
  if AInplaceEdit is TdxInplaceCurrencyEdit then
    with TdxInspectorCurrencyEdit(AInplaceEdit) do
    begin
      V := TdxInspectorCurrencyEdit(AInplaceEdit).ReturnEditValue;
      if VarIsNull(V) then
        Self.EditText := ''
      else
        if Value = 0 then
          Self.EditText := '0'
        else
          Self.EditText := EditText;
    end;
  Result := EditText;
end;

function TdxInspectorCurrencyRow.GetDataValue: Variant;
begin
  if EditText = '' then
    Result := Null
  else
    Result := StrToFloat(EditText);
end;

function TdxInspectorCurrencyRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorCurrencyEdit;
end;

procedure TdxInspectorCurrencyRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCurrencyEdit then
    with TdxInspectorCurrencyEdit(AInplaceEdit) do
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

function TdxInspectorCurrencyRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited InitEditValue(AInplaceEdit);
  if AInplaceEdit is TdxInplaceCurrencyEdit then
    with TdxInspectorCurrencyEdit(AInplaceEdit) do
    try
      Text := '';
      if Result = '' then
      begin
        Value := 0;
        if Nullable then
          Text := '';
      end
      else
        Value := StrToCurr(Result);
      Result := Value;
//      if Result = 0 then
//        Text := '';

(*      if Result <> '' then
        Value := StrToCurr(Result)
      else
        Value := 0;
      Result := Value;
      if Result = 0 then
        Text := '';*)
    except
      on EConvertError do
        Value := 0;
    end;
end;

procedure TdxInspectorCurrencyRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
var
  V: Variant;
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if FDisplayFormat <> '' then
    with TdxEditViewData(AViewData) do
    begin
      V := Self.GetDataValue;
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

function TdxInspectorCurrencyRow.IsMaxStored: Boolean;
begin
  Result := (srMaxValue in FAssignedValues) and (MaxValue <> DefaultMaxValue);
end;

function TdxInspectorCurrencyRow.IsMinStored: Boolean;
begin
  Result := (srMinValue in FAssignedValues) and (MinValue <> DefaultMinValue);
end;

function TdxInspectorCurrencyRow.GetMinValue: Double;
begin
  if srMinValue in FAssignedValues then
    Result := FMinValue
  else
    Result := DefaultMinValue;
end;

function TdxInspectorCurrencyRow.GetMaxValue: Double;
begin
  if srMaxValue in FAssignedValues then
    Result := FMaxValue
  else
   Result := DefaultMaxValue;
end;

procedure TdxInspectorCurrencyRow.SetDisplayFormat(const Value: string);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    FDisplayFormatStored := True;
    Changed;
  end;
end;

procedure TdxInspectorCurrencyRow.SetMinValue(Value: Double);
begin
  if (srMinValue in FAssignedValues) and (Value = FMinValue) then Exit;
  FMinValue := Value;
  Include(FAssignedValues, srMinValue);
end;

procedure TdxInspectorCurrencyRow.SetMaxValue(Value: Double);
begin
  if (srMaxValue in FAssignedValues) and (Value = FMaxValue) then Exit;
  FMaxValue := Value;
  Include(FAssignedValues, srMaxValue);
end;

procedure TdxInspectorCurrencyRow.SetNullable(Value: Boolean);
begin
  if FNullable <> Value then
  begin
    FNullable := Value;
    Changed;
  end;
end;

procedure TdxInspectorCurrencyRow.SetNullString(const Value: string);
begin
  if FNullString <> Value then
  begin
    FNullString := Value;
    Changed;
  end;
end;

procedure TdxInspectorCurrencyRow.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  if not Application.UpdateFormatSettings then Exit;
  if not FDisplayFormatStored then
  begin
    SysUtils.GetFormatSettings; // TODO ?
    FDisplayFormat := DefaultCurrencyDisplayFormat;
  end;
end;

{ TdxInspectorTextCurrencyRow }
function TdxInspectorTextCurrencyRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextCurrencyRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextCurrencyRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextCurrencyRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorHyperLinkRow }

constructor TdxInspectorHyperLinkRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEditBackgroundColor := clWhite;
  FEditFontColor := clBlue;
  FStartKey := VK_RETURN + scCtrl;
  PrepareLinkFont;
end;

destructor TdxInspectorHyperLinkRow.Destroy;
begin
  FLinkFont.Free;
  inherited Destroy;
end;

procedure TdxInspectorHyperLinkRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorHyperLinkRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      EditBackgroundColor := TdxInspectorHyperLinkRow(Source).EditBackgroundColor;
      EditFontColor := TdxInspectorHyperLinkRow(Source).EditFontColor;
      SingleClick := TdxInspectorHyperLinkRow(Source).SingleClick;
      StartKey := TdxInspectorHyperLinkRow(Source).StartKey;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorHyperLinkRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FEditBackgroundColor := clWhite;
  FEditFontColor := clBlue;
  FSingleClick := False;
  FStartKey := VK_RETURN + scCtrl;
end;

procedure TdxInspectorHyperLinkRow.DoStartClick(Sender: TObject);
begin
  if Assigned(FOnStartClick) then FOnStartClick(Self);
end;

function TdxInspectorHyperLinkRow.GetdxInplaceEditClass : TdxInplaceEditClass;
begin
  Result := TdxInspectorHyperLinkEdit;
end;

procedure TdxInspectorHyperLinkRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceHyperLinkEdit then
    with TdxInspectorHyperLinkEdit(AInplaceEdit) do
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

procedure TdxInspectorHyperLinkRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
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

procedure TdxInspectorHyperLinkRow.PrepareLinkFont;
begin
  if FLinkFont = nil then
    FLinkFont := TFont.Create;
  FLinkFont.Style := FLinkFont.Style + [fsUnderline];
  if SingleClick then
    FLinkFont.Color := EditFontColor
  else
    FLinkFont.Color := clDefault;
end;

procedure TdxInspectorHyperLinkRow.SetEditBackgroundColor(Value: TColor);
begin
  if FEditBackgroundColor <> Value then
  begin
    FEditBackgroundColor := Value;
    PrepareLinkFont;
    Changed;
  end;
end;

procedure TdxInspectorHyperLinkRow.SetEditFontColor(Value: TColor);
begin
  if FEditFontColor <> Value then
  begin
    FEditFontColor := Value;
    PrepareLinkFont;
    Changed;
  end;
end;

procedure TdxInspectorHyperLinkRow.SetSingleClick(Value: Boolean);
begin
  if FSingleClick <> Value then
  begin
    FSingleClick := Value;
    PrepareLinkFont;
    Changed;
  end;
end;

{ TdxInspectorTextHyperLinkRow }

function TdxInspectorTextHyperLinkRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextHyperLinkRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextHyperLinkRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextHyperLinkRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorCustomBlobRow }

constructor TdxInspectorCustomBlobRow.Create(AOwner: TComponent);
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
end;

procedure TdxInspectorCustomBlobRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorCustomBlobRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      AlwaysSaveText := TdxInspectorCustomBlobRow(Source).AlwaysSaveText;
      BlobEditKind := TdxInspectorCustomBlobRow(Source).BlobEditKind;
      BlobKind := TdxInspectorCustomBlobRow(Source).BlobKind;
      BlobPaintStyle := TdxInspectorCustomBlobRow(Source).BlobPaintStyle;
      MaxDisplayLength := TdxInspectorCustomBlobRow(Source).MaxDisplayLength;
      MemoMaxLength := TdxInspectorCustomBlobRow(Source).MemoMaxLength;
      MemoCharCase := TdxInspectorCustomBlobRow(Source).MemoCharCase;
      MemoHideScrollBars := TdxInspectorCustomBlobRow(Source).MemoHideScrollBars;
      MemoMaxLength := TdxInspectorCustomBlobRow(Source).MemoMaxLength;
      MemoOEMConvert := TdxInspectorCustomBlobRow(Source).MemoOEMConvert;
      MemoScrollBars := TdxInspectorCustomBlobRow(Source).MemoScrollBars;
      MemoSelectionBar := TdxInspectorCustomBlobRow(Source).MemoSelectionBar;
      MemoWantReturns := TdxInspectorCustomBlobRow(Source).MemoWantReturns;
      MemoWantTabs := TdxInspectorCustomBlobRow(Source).MemoWantTabs;
      MemoWordWrap := TdxInspectorCustomBlobRow(Source).MemoWordWrap;
      PictureAutoSize := TdxInspectorCustomBlobRow(Source).PictureAutoSize;
      PictureFilter := TdxInspectorCustomBlobRow(Source).PictureFilter;
      PictureTransparency := TdxInspectorCustomBlobRow(Source).PictureTransparency;
      PopupHeight := TdxInspectorCustomBlobRow(Source).PopupHeight;
      PopupWidth := TdxInspectorCustomBlobRow(Source).PopupWidth;
      ShowExPopupItems := TdxInspectorCustomBlobRow(Source).ShowExPopupItems;
      ShowPicturePopup := TdxInspectorCustomBlobRow(Source).ShowPicturePopup;
      SizeablePopup := TdxInspectorCustomBlobRow(Source).SizeablePopup;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorCustomBlobRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAlwaysSaveText := False;
  FBlobEditKind := bekMemo;
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
  FPictureAutoSize := True;
  FPictureTransparency := gtDefault;
  FPopupHeight := 140;
  FPopupWidth := 200;
  FShowExPopupItems := False;
  FShowPicturePopup := False;
  FSizeablePopup := True;
end;

function TdxInspectorCustomBlobRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceBlobEdit then
    Self.EditText := TdxInspectorBlobEdit(AInplaceEdit).Text;
  Result := EditText;
end;

procedure TdxInspectorCustomBlobRow.DoAssignPicture(Sender: TObject; var Picture: TPicture);
begin
  if Assigned(FOnAssignPicture) then FOnAssignPicture(Self, Picture);
end;

procedure TdxInspectorCustomBlobRow.DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass);
begin
  GraphicClass := GetGraphicClass;
end;

procedure TdxInspectorCustomBlobRow.DoSavePopupSize(Sender: TObject);
begin
  if Sender is TdxInspectorBlobEdit then
  begin
    PopupWidth := TdxInspectorBlobEdit(Sender).PopupWidth;
    PopupHeight := TdxInspectorBlobEdit(Sender).PopupHeight;
  end;
end;

function TdxInspectorCustomBlobRow.GetBlobData: Variant;
begin
  Result := EditText;
end;

function TdxInspectorCustomBlobRow.GetBlobEditKind: TdxBlobEditKind;
begin
  Result := FBlobEditKind;
end;

function TdxInspectorCustomBlobRow.GetBlobText: string;
begin
  Result := DisplayText;
end;

function TdxInspectorCustomBlobRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorBlobEdit;
end;

function TdxInspectorCustomBlobRow.GetGraphicClass: TGraphicClass;
begin
  Result := PictureGraphicClass;
  if Assigned(FOnGetGraphicClass) then FOnGetGraphicClass(Self, Result);
end;

procedure TdxInspectorCustomBlobRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceBlobEdit then
    with TdxInspectorBlobEdit(AInplaceEdit) do
    begin
      AlwaysSaveText := Self.AlwaysSaveText;
      BlobEditKind := Self.GetBlobEditKind;
      BlobPaintStyle := Self.BlobPaintStyle;
      if BlobPaintStyle = bpsText then
        BlobText := Self.GetBlobData
      else
        BlobText := Self.GetBlobText; // Self.EditText; // TODO
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

function TdxInspectorCustomBlobRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  inherited InitEditValue(AInplaceEdit);
  Result := EditText;
  if AInplaceEdit is TdxInplaceBlobEdit then
    with TdxInspectorBlobEdit(AInplaceEdit) do
      Text := Result;
end;

procedure TdxInspectorCustomBlobRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxBlobEditViewData then
    with TdxBlobEditViewData(AViewData) do
    begin
      BlobEditKind := Self.GetBlobEditKind;
      BlobPaintStyle := Self.BlobPaintStyle;
      Images := imgBlobImages;
      Data := Self.GetBlobData;
      IsNull := VarIsNull(Data) or ((VarType(Data) = varString) and (Data = ''));
      if BlobPaintStyle = bpsText then
        Data := VarToStr(Self.GetBlobData)
      else
        Data := Self.GetBlobText; // Self.EditText; // TODO
    end;
end;

procedure TdxInspectorCustomBlobRow.SetBlobEditKind(Value: TdxBlobEditKind);
begin
  if FBlobEditKind <> Value then
  begin
    FBlobEditKind := Value;
    Changed;
  end;
end;

procedure TdxInspectorCustomBlobRow.SetBlobKind(Value: TdxBlobKind);
begin
  if FBlobKind <> Value then
  begin
    FBlobKind := Value;
    Changed;
  end;
end;

procedure TdxInspectorCustomBlobRow.SetBlobPaintStyle(Value: TdxBlobPaintStyle);
begin
  if BlobPaintStyle <> Value then
  begin
    FBlobPaintStyle := Value;
    Changed;
  end;
end;

{ TdxInspectorTextBlobRow }

function TdxInspectorTextBlobRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextBlobRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextBlobRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextBlobRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorMRURow }

constructor TdxInspectorMRURow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ImmediateDropDown := False;
  FMaxItemCount := 7;
  FShowEllipsis := True;
end;

procedure TdxInspectorMRURow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorMRURow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      MaxItemCount := TdxInspectorMRURow(Source).MaxItemCount;
      ShowEllipsis := TdxInspectorMRURow(Source).ShowEllipsis;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorMRURow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FMaxItemCount := 7;
  FShowEllipsis := True;
end;

function TdxInspectorMRURow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Items.Assign(TdxInspectorMRUEdit(AInplaceEdit).Items);
  Result := inherited AssignEditValue(AInplaceEdit);
end;

procedure TdxInspectorMRURow.DoButtonClick(Sender: TObject);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;

function TdxInspectorMRURow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorMRUEdit;
end;

procedure TdxInspectorMRURow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMRUEdit then
    with TdxInspectorMRUEdit(AInplaceEdit) do
    begin
      MaxItemCount := Self.MaxItemCount;
      ShowEllipsis := Self.ShowEllipsis;
      OnButtonClick := Self.DoButtonClick;
    end;
end;

procedure TdxInspectorMRURow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxMRUEditViewData then
    with TdxMRUEditViewData(AViewData) do
    begin
      ShowEllipsis := Self.ShowEllipsis;
    end;
end;

procedure TdxInspectorMRURow.SetShowEllipsis(Value: Boolean);
begin
  if FShowEllipsis <> Value then
  begin
    FShowEllipsis := Value;
    Changed;
  end;
end;

{ TdxInspectorTextMRURow }

function TdxInspectorTextMRURow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextMRURow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextMRURow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextMRURow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorPopupRow }

constructor TdxInspectorPopupRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPopupFormBorderStyle := pbsDialog;
  FPopupFormFlatBorder := True;
  FPopupFormSizeable := True;
  FPopupAutoSize := True;
  FPopupHeight := 200;
  FPopupWidth := 250;
  FPopupMinHeight := 100;
  FPopupMinWidth := 100;
end;

procedure TdxInspectorPopupRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorPopupRow then
  begin
    inherited Assign(Source);
    HideEditCursor := TdxInspectorPopupRow(Source).HideEditCursor;
    PopupAutoSize := TdxInspectorPopupRow(Source).PopupAutoSize;
    PopupHeight := TdxInspectorPopupRow(Source).PopupHeight;
    PopupWidth := TdxInspectorPopupRow(Source).PopupWidth;
    PopupFormBorderStyle := TdxInspectorPopupRow(Source).PopupFormBorderStyle;
    PopupFormCaption := TdxInspectorPopupRow(Source).PopupFormCaption;
    PopupFormClientEdge := TdxInspectorPopupRow(Source).PopupFormClientEdge;
    PopupFormFlatBorder := TdxInspectorPopupRow(Source).PopupFormFlatBorder;
    PopupFormSizeable := TdxInspectorPopupRow(Source).PopupFormSizeable;
    PopupMinHeight := TdxInspectorPopupRow(Source).PopupMinHeight;
    PopupMinWidth := TdxInspectorPopupRow(Source).PopupMinWidth;
    PopupControl := TdxInspectorPopupRow(Source).PopupControl;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorPopupRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FHideEditCursor := False;
  FPopupAutoSize := True;
  FPopupHeight := 200;
  FPopupWidth := 250;
  FPopupMinHeight := 100;
  FPopupMinWidth := 100;
  FPopupFormBorderStyle := pbsDialog;
  FPopupFormClientEdge := False;
  FPopupFormFlatBorder := True;
  FPopupFormSizeable := True;
end;

procedure TdxInspectorPopupRow.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = PopupControl then PopupControl := nil;
end;

procedure TdxInspectorPopupRow.DoCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FOnCloseQuery) then FOnCloseQuery(Self, CanClose);
end;

procedure TdxInspectorPopupRow.DoCloseUp(Sender: TObject; var Text: string; var Accept: Boolean);
begin
  if Assigned(FOnCloseUp) then FOnCloseUp(Self, Text, Accept);
end;

procedure TdxInspectorPopupRow.DoInitPopup(Sender: TObject);
begin
  if Assigned(FOnInitPopup) then FOnInitPopup(Self);
end;

procedure TdxInspectorPopupRow.DoPopup(Sender: TObject; const EditText: string);
begin
  if Assigned(FOnPopup) then FOnPopup(Self, EditText);
end;

function TdxInspectorPopupRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorPopupEdit;
end;

procedure TdxInspectorPopupRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplacePopupEdit then
    with TdxInspectorPopupEdit(AInplaceEdit) do
    begin
      HideEditCursor := Self.HideEditCursor; 
      PopupAutoSize := Self.PopupAutoSize; 
      PopupControl := Self.PopupControl; 
      PopupFormBorderStyle := Self.PopupFormBorderStyle;
      PopupFormCaption := Self.PopupFormCaption;
      PopupClientEdge := Self.PopupFormClientEdge;
      PopupFlatBorder := Self.PopupFormFlatBorder;
      PopupHeight := Self.PopupHeight;
      PopupMinHeight := Self.PopupMinHeight;
      PopupMinWidth := Self.PopupMinWidth;
      PopupSizeable := Self.PopupFormSizeable;
      PopupWidth := Self.PopupWidth;
      OnCloseQuery := Self.DoCloseQuery;
      OnCloseUp := Self.DoCloseUp;
      OnInitPopup := Self.DoInitPopup;
      OnPopup := Self.DoPopup;
    end;
end;

procedure TdxInspectorPopupRow.SetPopupControl(Value: TControl);
begin
  FPopupControl := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    if csDestroying in ComponentState then Exit;
end;

procedure TdxInspectorPopupRow.SetPopupHeight(Value: Integer);
begin
  if Value < FPopupMinHeight then Value := FPopupMinHeight;
  if FPopupHeight <> Value then
    FPopupHeight := Value;
end;

procedure TdxInspectorPopupRow.SetPopupMinHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FPopupMinHeight := Value;
  SetPopupHeight(FPopupHeight);
end;

procedure TdxInspectorPopupRow.SetPopupMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FPopupMinWidth := Value;
  SetPopupWidth(FPopupWidth);
end;

procedure TdxInspectorPopupRow.SetPopupWidth(Value: Integer);
begin
  if Value < FPopupMinWidth then Value := FPopupMinWidth;
  if FPopupWidth <> Value then
    FPopupWidth := Value;
end;

{ TdxInspectorTextPopupRow }

function TdxInspectorTextPopupRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextPopupRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextPopupRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextPopupRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorMemoRow }

constructor TdxInspectorMemoRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHideScrollBars := True;
  FWantReturns := True;
  FWordWrap := True;
end;

procedure TdxInspectorMemoRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorMemoRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      HideScrollBars := TdxInspectorMemoRow(Source).HideScrollBars;
      ScrollBars := TdxInspectorMemoRow(Source).ScrollBars;
      SelectionBar := TdxInspectorMemoRow(Source).SelectionBar;
      WantReturns := TdxInspectorMemoRow(Source).WantReturns;
      WantTabs := TdxInspectorMemoRow(Source).WantTabs;
      WordWrap := TdxInspectorMemoRow(Source).WordWrap;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorMemoRow.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FHideScrollBars := True;
  FScrollBars := ssNone;
  SelectionBar := False;
  FWantReturns := True;
  FWantTabs := False;
  FWordWrap := True;
end;

function TdxInspectorMemoRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorMemoEdit;
end;

function TdxInspectorMemoRow.GetMemoText: string; 
begin
  Result := EditText;
end;

procedure TdxInspectorMemoRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMemoEdit then
    with TdxInspectorMemoEdit(AInplaceEdit) do
    begin
      HideScrollBars := Self.HideScrollBars;
      ScrollBars := Self.ScrollBars;
      SelectionBar := Self.SelectionBar;
      WantReturns := Self.WantReturns;
      WantTabs := Self.WantTabs;
      WordWrap := Self.WordWrap;
    end;
end;

procedure TdxInspectorMemoRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxTextEditViewData then
    with TdxTextEditViewData(AViewData) do
    begin
      DrawAlignment := daMultiLine; // TODO: !
      Data := Self.GetMemoText;
      SelectionBar := Self.SelectionBar;
    end;
end;

procedure TdxInspectorMemoRow.SetSelectionBar(Value: Boolean);
begin
  if FSelectionBar <> Value then
  begin
    FSelectionBar := Value;
    Changed;
  end;
end;

{ TdxInspectorTextMemoRow }

function TdxInspectorTextMemoRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextMemoRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextMemoRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextMemoRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

{ TdxInspectorGraphicRow }

constructor TdxInspectorGraphicRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPicture := TPicture.Create;
  FPopupToolBar := TdxPopupToolBarWindow.Create(nil);
  FPopupToolbarPos := Point(-10000, -10000);
  FCenter := True;
  FClipboardFormat := CF_PICTURE;
  FDblClickActivate := True;
  FPopupToolbarPosStored := True;
  FStretch := True;
end;

destructor TdxInspectorGraphicRow.Destroy;
begin
  FPopupToolBar.Free;
  FPopupToolBar := nil;
  FPicture.Free;
  FPicture := nil;
  inherited Destroy;
end;

procedure TdxInspectorGraphicRow.Assign(Source: TPersistent);
begin
  if Source is TdxInspectorGraphicRow then
  begin
    if Assigned(Inspector) then Inspector.BeginUpdate;
    try
      inherited Assign(Source);
      Center := TdxInspectorGraphicRow(Source).Center;
      CustomFilter := TdxInspectorGraphicRow(Source).CustomFilter;
      CustomGraphic := TdxInspectorGraphicRow(Source).CustomGraphic;
      DblClickActivate := TdxInspectorGraphicRow(Source).DblClickActivate;
      GraphicTransparency := TdxInspectorGraphicRow(Source).GraphicTransparency;
      PopupToolBar := TdxInspectorGraphicRow(Source).PopupToolBar;
      PopupToolbarPosStored := TdxInspectorGraphicRow(Source).PopupToolbarPosStored;
      QuickDraw := TdxInspectorGraphicRow(Source).QuickDraw;
      Stretch := TdxInspectorGraphicRow(Source).Stretch;
    finally
      if Assigned(Inspector) then Inspector.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxInspectorGraphicRow.RestoreDefaults; // TODO: BeginUpdate/Endupdate
begin
  inherited RestoreDefaults;
  FCenter := True;
  FCustomGraphic := False;
  FDblClickActivate := True;
  FGraphicTransparency := gtDefault;
  FPopupToolbarPosStored := True;
  FQuickDraw := False;
  FStretch := True;
end;

function TdxInspectorGraphicRow.AssignEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
var
  S: string;
  APicture: TPicture; 
begin
  if AInplaceEdit is TdxInplaceGraphicEdit then
    with TdxInspectorGraphicEdit(AInplaceEdit) do
    begin
      APicture := Picture;
      DoAssignPicture(Self, APicture);
      SavePicture(Picture, S);
      Self.EditText := S;
    end;
  Result := EditText;
end;

procedure TdxInspectorGraphicRow.DoAssignPicture(Sender: TObject; var Picture: TPicture);
begin
  if Assigned(FOnAssignPicture) then FOnAssignPicture(Self, Picture);
end;

procedure TdxInspectorGraphicRow.DoCustomClick(Sender: TObject);
begin
  if Assigned(FOnCustomClick) then FOnCustomClick(Self);
end;

procedure TdxInspectorGraphicRow.DoGetGraphicClass(Sender: TObject; var GraphicClass: TGraphicClass);
begin
  GraphicClass := GetGraphicClass;
end;

function TdxInspectorGraphicRow.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInspectorGraphicEdit;
end;

function TdxInspectorGraphicRow.GetGraphicClass: TGraphicClass;
begin
  Result := nil;
  if Assigned(FOnGetGraphicClass) then
    FOnGetGraphicClass(Self, Result);
end;

function TdxInspectorGraphicRow.GetGraphicValue: Variant;
begin
  Result := EditText;
end;

procedure TdxInspectorGraphicRow.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceGraphicEdit then
    with TdxInspectorGraphicEdit(AInplaceEdit) do
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
      Stretch := Self.Stretch;
      OnAssignPicture := Self.DoAssignPicture;
      OnCustomClick := Self.DoCustomClick;
      OnGetGraphicClass := Self.DoGetGraphicClass;
    end;
end;

function TdxInspectorGraphicRow.InitEditValue(AInplaceEdit: TdxInplaceEdit): Variant;
begin
  inherited InitEditValue(AInplaceEdit);
  Result := GetGraphicValue;
  if AInplaceEdit is TdxInplaceGraphicEdit then
    with TdxInspectorGraphicEdit(AInplaceEdit) do
    begin
      OffsetSize := Rect(0, 0, 0, 0);
      Caption := '';
      LoadPicture(Picture, Self.GetGraphicClass, Result);
    end;
end;

procedure TdxInspectorGraphicRow.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxInspectorCellViewData);
begin
  inherited PrepareViewData(AViewData, ACellViewData);
  if AViewData is TdxGraphicEditViewData then
    with TdxGraphicEditViewData(AViewData) do
    begin
      LoadPictureFromText(FPicture);
      if Self.GraphicTransparency <> gtDefault then
      begin
        if not IsPictureEmpty(Self.FPicture) then
          FPicture.Graphic.Transparent := Self.GraphicTransparency = gtTransparent;
      end;
      Picture := Self.FPicture;
      Data := '';
//      // Other
//      BkColor := ColorToRGB(ACellViewData.Cell_CellColor);
//      Brush := ACellViewData.Cell_CellBrush;
      Center := Self.Center;
      QuickDraw := Self.QuickDraw;
//      ShadowColor := ColorToRGB(ACellViewData.Cell_SelectionColor);
      Stretch := Self.Stretch;
//      TempTransparentBitmap := TdxTreeListCracker(TreeList).DrawBitmap; // TODO
      TempTransparentBitmap := nil;
//      TempDrawBitmap := TdxTreeListCracker(TreeList).DrawBitmap; // TODO
      OffsetSize := Rect(0, 0, 0, 0);
    end;
end;

procedure TdxInspectorGraphicRow.LoadPictureFromText(APicture: TPicture);
begin
  if not (CustomGraphic and (csDesigning in ComponentState)) then
    LoadPicture(APicture, GetGraphicClass, GetGraphicValue)
  else
    APicture.Graphic := nil;
end;

procedure TdxInspectorGraphicRow.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    Changed;
  end;
end;

procedure TdxInspectorGraphicRow.SetCustomGraphic(Value: Boolean);
begin
  if FCustomGraphic <> Value then
  begin
    FCustomGraphic := Value;
    Changed;
  end;
end;

procedure TdxInspectorGraphicRow.SetGraphicTransparency(Value: TdxGraphicEditTransparency);
begin
  if FGraphicTransparency <> Value then
  begin
    FGraphicTransparency := Value;
    Changed;
  end;
end;

procedure TdxInspectorGraphicRow.SetPopupToolBar(Value: TdxPopupToolBarWindow);
begin
  FPopupToolBar.Assign(Value);
end;

procedure TdxInspectorGraphicRow.SetPopupToolbarPosStored(Value: Boolean);
begin
  FPopupToolbarPosStored := Value;
  if not FPopupToolbarPosStored then
    FPopupToolbarPos := Point(-10000, -10000);
end;

procedure TdxInspectorGraphicRow.SetQuickDraw(Value: Boolean);
begin
  if FQuickDraw <> Value then
  begin
    FQuickDraw := Value;
    Changed;
  end;
end;

procedure TdxInspectorGraphicRow.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Changed;
  end;
end;

{ TdxInspectorTextGraphicRow }

function TdxInspectorTextGraphicRow.GetDisplayText: string;
begin
  Result := FText;
end;

function TdxInspectorTextGraphicRow.GetEditText: string;
begin
  Result := FText;
end;

procedure TdxInspectorTextGraphicRow.SetEditText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;  
end;

procedure TdxInspectorTextGraphicRow.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

initialization
  sdxInspCheckTextTrue := LoadStr(dxSTextTrue);
  sdxInspCheckTextFalse := LoadStr(dxSTextFalse);

  Classes.RegisterClasses([TdxInspectorTextMaskRow, TdxInspectorTextDateRow,
    TdxInspectorTextCheckRow, TdxInspectorTextCalcRow, TdxInspectorTextButtonRow,
    TdxInspectorTextSpinRow, TdxInspectorTextPickRow, TdxInspectorTextImageRow,
    TdxInspectorTextTimeRow, TdxInspectorTextCurrencyRow, TdxInspectorTextHyperLinkRow,
    TdxInspectorTextBlobRow, TdxInspectorTextMRURow, TdxInspectorTextPopupRow,
    TdxInspectorTextMemoRow, TdxInspectorTextGraphicRow]);

end.

