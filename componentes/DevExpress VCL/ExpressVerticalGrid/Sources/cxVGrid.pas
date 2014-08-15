{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressVerticalGrid                                          }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSVERTICALGRID AND ALL           }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}
unit cxVGrid;

{$I cxVer.inc}

interface

uses
  SysUtils, Classes, Windows, Controls, Messages, Forms, StdCtrls, ImgList,
  ExtCtrls, ComCtrls,
  dxCore, cxControls, Graphics, cxGraphics, cxClasses, cxStyles, cxEdit,
  cxLookAndFeelPainters, cxLookAndFeels,
  cxInplaceContainer, cxButtons, cxNavigator, cxFilterControl,
  cxFilter, cxDataStorage, cxCustomData, cxStorage, cxVGridUtils;

const
  cxvgMinValueWidth     = 20;

  // verticalgrid styles predefined indexes
  // for row styles
  vgrs_Header           = 0;
  vgrs_Content          = 1;

  // for control styles
  vgs_Content        = ecs_Content;
  vgs_Category       = ecs_EditingStylesMaxIndex + 1;
  vgs_Header         = ecs_EditingStylesMaxIndex + 2;
  vgs_IncSearch      = ecs_EditingStylesMaxIndex + 3;

  // base constants for descendants
  cxvgMaxControlStyleIndex = vgs_IncSearch;
  cxvgMaxRowStyleIndex     = vgrs_Content;

  // hit codes
  vghc_Base            = 4;
  vghc_HitAtBandSizing = vghc_Base;
  vghc_HitAtButton     = vghc_Base + 1;
  vghc_HitAtCaption    = vghc_Base + 2;
  vghc_HitAtDivider    = vghc_Base + 3;
  vghc_HitAtEmpty      = vghc_Base + 4;
  vghc_HitAtImage      = vghc_Base + 5;
  vghc_HitAtIndent     = vghc_Base + 6;
  vghc_HitAtRowSizing  = vghc_Base + 7;
  vghc_HitAtValue      = vghc_Base + 8;
  vghc_HitAtCustomize  = vghc_Base + 9;
  vghc_HitAtSeparator  = vghc_Base + 10;

type
{$IFNDEF DELPHI5}
  TImageIndex = Integer;
{$ENDIF}

  EcxVerticalGridError = class(EdxException);

  TcxCustomRow = class;
  TcxCustomRowHeaderInfo = class;
  TcxCustomRowViewInfo = class;
  TcxCustomVerticalGrid = class;
  TcxVirtualVerticalGrid = class;
  TcxRowCaptionInfo = class;
  TcxRowValueInfo = class;
  TcxRowValueInfoClass = class of TcxRowValueInfo;
  TcxValueInfoList = class;
  TcxCustomEditorRow = class;
  TcxCustomMultiEditorRow = class;
  TcxMultiEditorRow = class;
  TcxVerticalGridCustomizing = class;
  TcxVerticalGridCustomizingClass = class of TcxVerticalGridCustomizing;
  TcxVerticalGridRows = class;
  TcxvgCustomRowStyles = class;
  TcxvgCustomRowStylesClass = class of TcxvgCustomRowStyles;
  TcxCategoryRowStyles = class;
  TcxEditorRowStyles = class;
  TcxvgScroller = class;
  TcxCellEdit = class;
  TcxvgController = class;
  TcxvgCustomPaintStyleCalcHelper = class;
  TcxvgCustomPaintStyleCalcHelperClass = class of TcxvgCustomPaintStyleCalcHelper;
  TcxvgCustomViewInfo = class;
  TcxvgHitTest = class;
  TcxvgPainter = class;
  TcxVerticalGridStyles = class;

  { TcxvgOptionsBehavior }

  TcxvgOptionsBehavior = class(TcxControlOptionsBehavior)
  private
    FAlwaysShowEditorAssigned: Boolean;
    FBandSizing: Boolean;
    FHeaderSizing: Boolean;
    FRowSizing: Boolean;
    FRowTracking: Boolean;
    function GetAlwaysShowEditor: Boolean;
    procedure SetAlwaysShowEditor(Value: Boolean);
  protected
    procedure InternalSetAlwaysShowEditor(Value: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
  published
    property AlwaysShowEditor: Boolean read GetAlwaysShowEditor write SetAlwaysShowEditor stored FAlwaysShowEditorAssigned;
    property BandSizing: Boolean read FBandSizing write FBandSizing default True;
    property CellHints default True;
    property HeaderSizing: Boolean read FHeaderSizing write FHeaderSizing default True;
    property RowSizing: Boolean read FRowSizing write FRowSizing default False;
    property RowTracking: Boolean read FRowTracking write FRowTracking default True;
  end;

  { TcxvgMultiRecordsOptionsBehavior }

  TcxvgMultiRecordsOptionsBehavior = class(TcxvgOptionsBehavior)
  private
    FAllowChangeRecord: Boolean;
    function GetIncSearchItem: TcxCustomEditorRow;
    procedure SetAllowChangeRecord(Value: Boolean);
    procedure SetIncSearchItem(Value: TcxCustomEditorRow);
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AllowChangeRecord: Boolean read FAllowChangeRecord write SetAllowChangeRecord default True;
    property FocusFirstCellOnNewRecord;
    property IncSearch;
    property IncSearchItem: TcxCustomEditorRow read GetIncSearchItem write SetIncSearchItem;
  end;

  { TcxvgMultiRecordsOptionsData }

  TcxvgMultiRecordsOptionsData = class(TcxControlOptionsData)
  private
    FAppending: Boolean;
    FDeleting: Boolean;
    FInserting: Boolean;
    FDeletingConfirmation: Boolean;
    procedure SetAppending(Value: Boolean);
    procedure SetDeleting(Value: Boolean);
    procedure SetInserting(Value: Boolean);
  protected
    procedure Changed; override;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Appending: Boolean read FAppending write SetAppending default True;
    property Deleting: Boolean read FDeleting write SetDeleting default True;
    property DeletingConfirmation: Boolean read FDeletingConfirmation write FDeletingConfirmation default True;
    property Inserting: Boolean read FInserting write SetInserting default True;
  end;

  { TcxvgOptionsView }

  TcxvgPaintStyle = (psdotNet, psDelphi);
  TcxvgGridLines = (vglNone, vglHorizontal, vglVertical, vglBoth);

  TcxvgOptionsView = class(TcxControlOptionsView)
  private
    FAutoScaleBands: Boolean;
    FBandsInterval: Integer;
    FCategoryExplorerStyle: Boolean;
    FGridLineColor: TColor;
    FGridLineColorAssigned: Boolean;
    FValueWidth: Integer;
    FPaintStyle: TcxvgPaintStyle;
    FRowHeaderMinWidth: Integer;
    FRowHeaderWidth: Integer;
    FRowHeight: Integer;
    FShowButtons: Boolean;
    FShowHeaders: Boolean;
    FShowEmptyRowImage: Boolean;
    FGridLines: TcxvgGridLines;
    FValueMinWidth: Integer;
    function GetGridLineColor: TColor;
    function GetVerticalGrid: TcxCustomVerticalGrid;
    procedure SetAutoScaleBands(Value: Boolean);
    procedure SetBandsInterval(Value: Integer);
    procedure SetCategoryExplorerStyle(Value: Boolean);
    procedure SetGridLineColor(Value: TColor);
    procedure SetPaintStyle(Value: TcxvgPaintStyle);
    procedure SetRowHeaderMinWidth(Value: Integer);
    procedure SetRowHeaderWidth(Value: Integer);
    procedure SetRowHeight(Value: Integer);
    procedure SetShowButtons(Value: Boolean);
    procedure SetShowEmptyRowImage(Value: Boolean);
    procedure SetShowHeaders(Value: Boolean);
    procedure SetGridLines(Value: TcxvgGridLines);
    procedure SetValueMinWidth(Value: Integer);
    procedure SetValueWidth(Value: Integer);
  protected
    procedure Changed; override;

    property VerticalGrid: TcxCustomVerticalGrid read GetVerticalGrid;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
  published
    property AutoScaleBands: Boolean read FAutoScaleBands write SetAutoScaleBands default True;
    property BandsInterval: Integer read FBandsInterval write SetBandsInterval default 2;
    property CategoryExplorerStyle: Boolean read FCategoryExplorerStyle write SetCategoryExplorerStyle default False;
    property PaintStyle: TcxvgPaintStyle read FPaintStyle write SetPaintStyle default psDotNet;
    property GridLineColor: TColor read GetGridLineColor write SetGridLineColor stored FGridLineColorAssigned;
    property RowHeaderMinWidth: Integer read FRowHeaderMinWidth write SetRowHeaderMinWidth default 24;
    property RowHeaderWidth: Integer read FRowHeaderWidth write SetRowHeaderWidth default 100;
    property RowHeight: Integer read FRowHeight write SetRowHeight default -1;
    property ShowButtons: Boolean read FShowButtons write SetShowButtons default True;
    property ShowEditButtons;
    property ShowEmptyRowImage: Boolean read FShowEmptyRowImage write SetShowEmptyRowImage default False;
    property ShowHeaders: Boolean read FShowHeaders write SetShowHeaders default True;
    property GridLines: TcxvgGridLines read FGridLines write SetGridLines default vglBoth;
    property ValueWidth: Integer read FValueWidth write SetValueWidth default 100;
    property ValueMinWidth: Integer read FValueMinWidth write SetValueMinWidth default 40;
  end;

  { TcxvgMultiRecordsOptionsView }

  TcxvgMultiRecordsOptionsView = class(TcxvgOptionsView)
  private
    FRecordsInterval: Integer;
    procedure SetRecordsInterval(Value: Integer);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property RecordsInterval: Integer read FRecordsInterval write SetRecordsInterval default 0;
  end;

  { TcxCustomRowProperties }

  TcxCustomRowProperties = class(TcxInterfacedCollectionItem)
  private
    FCollection: TCollection;
    FLocked: Boolean;
    FRow: TcxCustomRow;
  protected
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;

    property Locked: Boolean read FLocked;
  public
    constructor Create(Collection: TCollection); override;
    constructor CreateEx(ARow: TcxCustomRow); virtual;
    property Row: TcxCustomRow read FRow;
  end;

  TcxRowPropertiesClass = class of TcxCustomRowProperties;

  { TcxCaptionRowProperties }

  TcxCaptionRowProperties = class(TcxCustomRowProperties)
  private
    FHeaderAlignmentHorz: TAlignment;
    FHeaderAlignmentVert: TcxAlignmentVert;
    FIsCaptionAssigned: Boolean;
    FCaption: TCaption;
    FImageIndex: TImageIndex;
    FHint: string;
    function GetCaption: TCaption;
    function IsCaptionStored: Boolean;
    procedure SetCaption(const Value: TCaption);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetHeaderAlignmentHorz(const Value: TAlignment);
    procedure SetHeaderAlignmentVert(const Value: TcxAlignmentVert);
  protected
    function DefaultCaption: string; virtual;
    procedure RestoreDefaults; virtual;
  public
    constructor CreateEx(ARow: TcxCustomRow); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: TCaption read GetCaption write SetCaption
      stored IsCaptionStored;
    property HeaderAlignmentHorz: TAlignment read FHeaderAlignmentHorz
      write SetHeaderAlignmentHorz default taLeftJustify;
    property HeaderAlignmentVert: TcxAlignmentVert read FHeaderAlignmentVert
      write SetHeaderAlignmentVert default vaTop;
    property Hint: string read FHint write FHint;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
  end;

  { TcxRowOptions }

  TcxRowOptions = class(TPersistent)
  private
    FCanAutoHeight: Boolean;
    FCanMovedToCustomizationForm: Boolean;
    FCanResized: Boolean;
    FFocusing: Boolean;
    FMoving: Boolean;
    FRow: TcxCustomRow;
    FShowExpandButton: Boolean;
    FShowInCustomizationForm: Boolean;
    FTabStop: Boolean;
    procedure SetCanAutoHeight(Value: Boolean);
    procedure SetFocusing(Value: Boolean);
    procedure SetShowExpandButton(Value: Boolean);
    procedure SetShowInCustomizationForm(Value: Boolean);
  protected
    procedure Changed; virtual;
    property Row: TcxCustomRow read FRow;
  public
    constructor Create(ARow: TcxCustomRow); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
  published
    property CanAutoHeight: Boolean read FCanAutoHeight write SetCanAutoHeight default True;
    property CanMovedToCustomizationForm: Boolean read FCanMovedToCustomizationForm write FCanMovedToCustomizationForm default True;
    property CanResized: Boolean read FCanResized write FCanResized default True;
    property Focusing: Boolean read FFocusing write SetFocusing default True;
    property Moving: Boolean read FMoving write FMoving default True;
    property ShowExpandButton: Boolean read FShowExpandButton write SetShowExpandButton default True;
    property ShowInCustomizationForm: Boolean read FShowInCustomizationForm write SetShowInCustomizationForm default True;
    property TabStop: Boolean read FTabStop write FTabStop default True;
  end;

  TcxRowOptionsClass = class of TcxRowOptions;

  { TcxCustomRow }

  TcxRowList = class(TList)
  private
    FOwner: TcxCustomRow;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    procedure UpdateIndexes;
    property Owner: TcxCustomRow read FOwner;
  public
    constructor Create(AOwner: TcxCustomRow);
  end;

  TcxCustomRow = class(TComponent, IUnknown, IcxStoredObject)
  private
    FExpanded: Boolean;
    FHeight: Integer;
    FID: Integer;
    FIndex: Integer;
    FLoadedID: Integer;
    FLoadedIndex: Integer;
    FLoadedParentID: Integer;
    FLoadingIndex: Integer;
    FLoadingParent: string;
    FOptions: TcxRowOptions;
    FParent: TcxCustomRow;
    FRows: TcxRowList;
    FStyles: TcxvgCustomRowStyles;
    FVersion: Integer;
    FVerticalGrid: TcxCustomVerticalGrid;
    FViewInfo: TcxCustomRowViewInfo;
    FVisible: Boolean;
    FVisibleIndex: Integer;
    function GetAbsoluteIndex: Integer;
    function GetCount: Integer;
    function GetFocused: Boolean;
    function GetLevel: Integer;
    function GetOwnerRows: TcxVerticalGridRows;
    function GetParent: TcxCustomRow;
    function GetRow(Index: Integer): TcxCustomRow;
    function GetViewInfo: TcxCustomRowViewInfo;
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetIndex(Value: Integer);
    procedure SetOptions(Value: TcxRowOptions);
    procedure SetParent(Value: TcxCustomRow);
    procedure SetVisible(Value: Boolean);
    // storing layout
    procedure ReadID(Reader: TReader);
    procedure ReadLoadedIndex(Reader: TReader);
    procedure ReadLoadedParentID(Reader: TReader);
    procedure ReadVersion(Reader: TReader);
    procedure WriteID(Writer: TWriter);
    procedure WriteLoadedIndex(Writer: TWriter);
    procedure WriteLoadedParentID(Writer: TWriter);
    procedure WriteVersion(Writer: TWriter);
  protected
    FProperties: TcxCustomRowProperties;
    // IcxStoredObject
    function GetObjectName: string; virtual;
    function IcxStoredObject.GetProperties = GetStoredProperties;
    function GetStoredProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // override TComponent
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(Value: TComponent); override;

    procedure Add(ARow: TcxCustomRow);
    function CanFocus: Boolean; virtual;
    procedure Changed(ARebuild: Boolean = False); virtual;
    function CreateHeaderInfo: TcxCustomRowHeaderInfo; virtual; abstract;
    function CreateViewInfo: TcxCustomRowViewInfo; virtual; abstract;
    procedure Delete(AIndex: Integer);
    function GetDefaultHeight: Integer; virtual;
    function GetEditContainer(ACellIndex: Integer): TcxCellEdit; virtual;
    function GetEditContainerCount: Integer; virtual;
    function GetPropertiesClass: TcxRowPropertiesClass; virtual;
    function GetRealHeight: Integer; virtual;
    function GetOptionsClass: TcxRowOptionsClass; virtual;
    function GetStylesClass: TcxvgCustomRowStylesClass; virtual;
    procedure Insert(AIndex: Integer; ARow: TcxCustomRow);
    function IsHeightAssigned: Boolean;
    procedure Remove(ARow: TcxCustomRow);
    procedure RemoveAll;
    procedure RemoveChildren;
    procedure ResetOwnerCount;
    procedure RestoreIndex;
    procedure RestoreParent;
    procedure SetVerticalGrid(Value: TcxCustomVerticalGrid); virtual;

    property ID: Integer read FID;
    property OwnerRows: TcxVerticalGridRows read GetOwnerRows;
    property Styles: TcxvgCustomRowStyles read FStyles write FStyles;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    // override
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    // visualization
    procedure Collapse(ARecurse: Boolean);
    procedure Expand(ARecurse: Boolean);
    function GetFirstVisibleChild: TcxCustomRow;
    function GetLastVisibleChild: TcxCustomRow;
    function HasChildren: Boolean;
    function HasVisibleChildren: Boolean;
    function IndexOf(ARow: TcxCustomRow): Integer;
    function IsChild(ARow: TcxCustomRow): Boolean;
    function IsFirst: Boolean;
    function IsFirstVisible: Boolean;
    function IsLast: Boolean;
    function IsLastVisible: Boolean;
    function IsRootLevel: Boolean;
    function IsParent(ARow: TcxCustomRow): Boolean;
    procedure MakeVisible;
    procedure RestoreDefaults;
    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property Count: Integer read GetCount;
    property Expanded: Boolean read FExpanded write SetExpanded default True;
    property Focused: Boolean read GetFocused write SetFocused;
    property Height: Integer read FHeight write SetHeight default -1;
    property Index: Integer read FIndex write SetIndex;
    property Level: Integer read GetLevel;
    property Options: TcxRowOptions read FOptions write SetOptions;
    property Parent: TcxCustomRow read GetParent write SetParent;
    property Rows[Index: Integer]: TcxCustomRow read GetRow;
    property VerticalGrid: TcxCustomVerticalGrid read FVerticalGrid write SetVerticalGrid;
    property ViewInfo: TcxCustomRowViewInfo read GetViewInfo;
    property Visible: Boolean read FVisible write SetVisible default True;
    property VisibleIndex: Integer read FVisibleIndex;
  end;

  TcxCustomRowClass = class of TcxCustomRow;

  { TcxCategoryRow }

  TcxCategoryRow = class(TcxCustomRow)
  private
    function GetProperties: TcxCaptionRowProperties;
    function GetStyles: TcxCategoryRowStyles;
    procedure SetProperties(Value: TcxCaptionRowProperties);
    procedure SetStyles(Value: TcxCategoryRowStyles);
  protected
    function GetStoredProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;
    function GetDefaultHeight: Integer; override;
    function GetStylesClass: TcxvgCustomRowStylesClass; override;
  public
    function CreateHeaderInfo: TcxCustomRowHeaderInfo; override;
    function CreateViewInfo: TcxCustomRowViewInfo; override;
  published
    property Expanded;
    property Height;
    property Options;
    property Properties: TcxCaptionRowProperties read GetProperties write SetProperties;
    property Styles: TcxCategoryRowStyles read GetStyles write SetStyles;
    property Visible;
  end;

  TcxCustomEditorRowProperties = class;

  { TcxEditorRowPropertiesOptions }

  TcxEditorRowPropertiesOptions = class(TcxCustomEditContainerItemOptions)
  published
    property Editing;
    property Filtering;
    property IncSearch;
    property ShowEditButtons;
  end;

  { TcxCellEdit }

  TcxCellEdit = class(TcxCustomInplaceEditContainer)
  private
    FCalculating: Boolean;
    FEditRowProperties: TcxCustomEditorRowProperties;
    FRow: TcxCustomRow;
    function GetViewInfo: TcxCustomRowViewInfo;
  protected
    FCellIndex: Integer;
    procedure Calculate(ACellViewInfo: TcxRowValueInfo);
    function CanEdit: Boolean; override;
    function CanFocus: Boolean; override;
    function CanInitEditing: Boolean; override;
    function CanTabStop: Boolean; override;
    procedure DoGetDisplayText(ARecordIndex: Integer; var AText: string); override;
    function DoGetPropertiesFromEvent(AEvent: TcxGetEditPropertiesEvent; AData: Pointer;
      AProperties: TcxCustomEditProperties): TcxCustomEditProperties; override;
    function GetCurrentValue: Variant; override;
    function GetDataBindingClass: TcxItemDataBindingClass; override;
    function GetDisplayValue(AProperties: TcxCustomEditProperties; ARecordIndex: Integer): Variant; override;
    function GetEditValue: Variant; override;
    function GetOptionsClass: TcxCustomEditContainerItemOptionsClass; override;
    function GetValue(ARecordIndex: Integer): Variant; override;
    function GetValueCount: Integer; override;
    function HasDataTextHandler: Boolean; override;
    procedure SetCurrentValue(const Value: Variant); override;
    procedure SetValue(ARecordIndex: Integer; const Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    property CellIndex: Integer read FCellIndex;
    property EditRowProperties: TcxCustomEditorRowProperties read FEditRowProperties;
    property Options;
    property Row: TcxCustomRow read FRow;
    property ViewInfo: TcxCustomRowViewInfo read GetViewInfo;
  end;

  TcxCellEditClass = class of TcxCellEdit;

  { TcxCustomEditorRowProperties }

  TcxVerticalGridGetDisplayTextEvent = procedure(Sender: TcxCustomEditorRowProperties;
    ARecord: Integer; var AText: string) of object;
  TcxVerticalGridGetEditPropertiesEvent = procedure(Sender: TcxCustomEditorRowProperties;
    ARecordIndex: Integer; var AProperties: TcxCustomEditProperties) of object;

  TcxCustomEditorRowProperties = class(TcxCaptionRowProperties,
    IcxEditorPropertiesContainer)
  private
    FEditContainer: TcxCellEdit;
    FOnGetDisplayText: TcxVerticalGridGetDisplayTextEvent;
    function GetDataBinding: TcxItemDataBinding;
    function GetDisplayEditProperty(Index: Integer): TcxCustomEditProperties;
    function GetDisplayText(Index: Integer): string;
    function GetEditViewData: TcxCustomEditViewData;
    function GetEditProperties: TcxCustomEditProperties;
    function GetEditPropertiesClass: TcxCustomEditPropertiesClass;
    function GetEditPropertiesClassName: string;
    function GetIEditorPropertiesContainer: IcxEditorPropertiesContainer;
    function GetItemIndex: Integer;
    function GetItemLink: TObject;
    function GetOptions: TcxEditorRowPropertiesOptions;
    function GetRepositoryItem: TcxEditRepositoryItem;
    function GetValue: Variant;
    function GetValueByIndex(Index: Integer): Variant;
    procedure SetDataBinding(Value: TcxItemDataBinding);
    procedure SetEditProperties(Value: TcxCustomEditProperties);
    procedure SetEditPropertiesClass(Value: TcxCustomEditPropertiesClass);
    procedure SetEditPropertiesClassName(const Value: string);
    procedure SetOptions(Value: TcxEditorRowPropertiesOptions);
    procedure SetRepositoryItem(Value: TcxEditRepositoryItem);
    procedure SetValue(const Value: Variant);
    // events delegation
    function GetOnGetEditingProperties: TcxVerticalGridGetEditPropertiesEvent;
    function GetOnGetEditProperties: TcxVerticalGridGetEditPropertiesEvent;
    procedure SetOnGetEditingProperties(Value: TcxVerticalGridGetEditPropertiesEvent);
    procedure SetOnGetEditProperties(Value: TcxVerticalGridGetEditPropertiesEvent);
  protected
    function GetInplaceEditContainerClass: TcxCellEditClass; virtual;
    procedure DoGetDisplayTextEvent(ARecordIndex: Integer; var Text: string); virtual;
    property EditContainer: TcxCellEdit read FEditContainer;
    property EditViewData: TcxCustomEditViewData read GetEditViewData;
    property IEditorPropertiesContainer: IcxEditorPropertiesContainer
      read GetIEditorPropertiesContainer implements IcxEditorPropertiesContainer;
    property DataBinding: TcxItemDataBinding read GetDataBinding write SetDataBinding;
    property Options: TcxEditorRowPropertiesOptions read GetOptions write SetOptions;
    property Value: Variant read GetValue write SetValue;
    property OnGetDisplayText: TcxVerticalGridGetDisplayTextEvent read FOnGetDisplayText write FOnGetDisplayText;
    property OnGetEditProperties: TcxVerticalGridGetEditPropertiesEvent read GetOnGetEditProperties write SetOnGetEditProperties;
    property OnGetEditingProperties: TcxVerticalGridGetEditPropertiesEvent read GetOnGetEditingProperties write SetOnGetEditingProperties;
  public
    constructor CreateEx(ARow: TcxCustomRow); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property DisplayEditProperties[Index: Integer]: TcxCustomEditProperties read GetDisplayEditProperty;
    property DisplayTexts[Index: Integer]: string read GetDisplayText;
    property EditPropertiesClass: TcxCustomEditPropertiesClass read GetEditPropertiesClass write SetEditPropertiesClass;
    property ItemIndex: Integer read GetItemIndex;
    property ItemLink: TObject read GetItemLink;
    property Values[Index: Integer]: Variant read GetValueByIndex;
  published
    property EditPropertiesClassName: string read GetEditPropertiesClassName write SetEditPropertiesClassName;
    property EditProperties: TcxCustomEditProperties read GetEditProperties write SetEditProperties;
    property RepositoryItem: TcxEditRepositoryItem read GetRepositoryItem write SetRepositoryItem;
  end;

  TcxEditorRowPropertiesClass = class of TcxCustomEditorRowProperties;

  { TcxEditorRowProperties }

  TcxEditorRowProperties = class(TcxCustomEditorRowProperties)
  public
    procedure Assign(Source: TPersistent); override;
  published
    property DataBinding;
    property Options;
    property Value;
    property OnGetDisplayText;
    property OnGetEditProperties;
    property OnGetEditingProperties;
  end;

  { TcxCustomEditorRow }

  TcxCustomEditorRow = class(TcxCustomRow)
  private
    FEditPropertiesEvents: TNotifyEvent;
    FPropertiesEvents: TNotifyEvent;
    function GetProperties: TcxCustomEditorRowProperties;
    function GetStyles: TcxEditorRowStyles;
    procedure SetProperties(Value: TcxCustomEditorRowProperties);
    procedure SetStyles(Value: TcxEditorRowStyles);
  protected
    function CanFocus: Boolean; override;
    function EditContainer: TcxCellEdit;
    function GetDefaultHeight: Integer; override;
    function GetEditContainer(ACellIndex: Integer): TcxCellEdit; override;
    function GetEditContainerCount: Integer; override;
    function GetPropertiesClass: TcxRowPropertiesClass; override;
    function GetStylesClass: TcxvgCustomRowStylesClass; override;
    procedure SetParentComponent(Value: TComponent); override;
    procedure SetVerticalGrid(Value: TcxCustomVerticalGrid); override;
    property Styles: TcxEditorRowStyles read GetStyles write SetStyles;
    property Properties: TcxCustomEditorRowProperties read GetProperties write SetProperties;
  public
    function CreateHeaderInfo: TcxCustomRowHeaderInfo; override;
    function CreateViewInfo: TcxCustomRowViewInfo; override;
  published
    property EditPropertiesEvents: TNotifyEvent read FEditPropertiesEvents write FEditPropertiesEvents;
    property Options;
    property PropertiesEvents: TNotifyEvent read FPropertiesEvents write FPropertiesEvents;
  end;

  { TcxEditorRow }

  TcxEditorRow = class(TcxCustomEditorRow)
  private
    function GetProperties: TcxEditorRowProperties;
    procedure SetProperties(Value: TcxEditorRowProperties);
  protected
    function GetPropertiesClass: TcxRowPropertiesClass; override;
  published
    property Expanded;
    property Height;
    property Options;
    property Properties: TcxEditorRowProperties read GetProperties write SetProperties;
    property Styles;
    property Visible;
  end;

  { TcxMultiEditorRow }

  TSeparatorKind = (skVertLine, skString);

  { TSeparatorInfo }

  TSeparatorInfo = record
    Width: Integer;
    Kind: TSeparatorKind;
    Caption: string;
    TextFlags: Integer;
    ViewParams: TcxViewParams;
  end;

  { TcxMultiEditorRowPropertiesOptions }

  TcxMultiEditorRowPropertiesOptions = class(TcxCustomEditContainerItemOptions)
  published
    property Editing;
    property Filtering;
    property Focusing;
    property IncSearch;
    property ShowEditButtons;
    property TabStop;
  end;

  { TcxCollectionItemEditorRowProperties }

  TcxCollectionItemEditorRowProperties = class(TcxCustomEditorRowProperties)
  private
    FEditPropertiesEvents: TNotifyEvent;
    FWidth: Integer;
    function GetOptions: TcxMultiEditorRowPropertiesOptions;
    procedure SetOptions(Value: TcxMultiEditorRowPropertiesOptions);
    procedure SetWidth(Value: Integer);
  protected
    function GetDisplayName: string; override;
    function GetOwner: TPersistent; override;
    property Options: TcxMultiEditorRowPropertiesOptions read GetOptions write SetOptions;
  public
    constructor CreateEx(ARow: TcxCustomRow); override;
    procedure Assign(Source: TPersistent); override;
  published
    property EditPropertiesEvents: TNotifyEvent read FEditPropertiesEvents write FEditPropertiesEvents;
    property Width: Integer read FWidth write SetWidth default 50;
  end;

  { TcxEditorRowItemProperties }

  TcxEditorRowItemProperties = class(TcxCollectionItemEditorRowProperties)
  public
    procedure Assign(Source: TPersistent); override;
  published
    property DataBinding;
    property Options;
    property Value;
    property OnGetDisplayText;
    property OnGetEditProperties;
    property OnGetEditingProperties;
  end;

  { TcxEditorPropertiesCollection }

  TcxEditorPropertiesCollection = class(TCollection)
  private
    FRow: TcxCustomMultiEditorRow;
    function GetItem(Index: Integer): TcxEditorRowItemProperties;
  protected
    function GetCollectionItemClass: TCollectionItemClass; virtual;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ARow: TcxCustomMultiEditorRow); reintroduce; virtual;
    function Add: TcxEditorRowItemProperties;
    function GetNamePath: string; override;
    property Items[Index: Integer]: TcxEditorRowItemProperties read GetItem; default;
    property Row: TcxCustomMultiEditorRow read FRow;
  end;

  TcxEditorPropertiesCollectionClass = class of TcxEditorPropertiesCollection;

  { TcxMultiEditorRowProperties }

  TcxMultiEditorRowProperties = class(TcxCustomRowProperties)
  private
    FFixed: Boolean;
    FEditors: TcxEditorPropertiesCollection;
    FSeparatorAlignmentVert: TcxAlignmentVert;
    FSeparatorKind: TSeparatorKind;
    FSeparatorString: string;
    procedure SetFixed(Value: Boolean);
    procedure SetSeparatorAlignmentVert(Value: TcxAlignmentVert);
    procedure SetSeparatorKind(Value: TSeparatorKind);
    procedure SetSeparatorString(const Value: string);
  protected
    function GetCollectionClass: TcxEditorPropertiesCollectionClass; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor CreateEx(ARow: TcxCustomRow); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Editors: TcxEditorPropertiesCollection read FEditors write FEditors;
    property Fixed: Boolean read FFixed write SetFixed default False;
    property SeparatorAlignmentVert: TcxAlignmentVert read FSeparatorAlignmentVert
      write SetSeparatorAlignmentVert default vaTop;
    property SeparatorKind: TSeparatorKind read FSeparatorKind
      write SetSeparatorKind default skVertLine;
    property SeparatorString: string read FSeparatorString write SetSeparatorString;
  end;

  { TcxCustomMultiEditorRow }

  TcxCustomMultiEditorRow = class(TcxCustomRow)
  private
    function GetProperties: TcxMultiEditorRowProperties;
    function GetStyles: TcxEditorRowStyles;
    procedure SetProperties(const Value: TcxMultiEditorRowProperties);
    procedure SetStyles(Value: TcxEditorRowStyles);
  protected
    function CanFocus: Boolean; override;
    function GetDefaultHeight: Integer; override;
    function GetEditContainer(ACellIndex: Integer): TcxCellEdit; override;
    function GetEditContainerCount: Integer; override;
    function GetPropertiesClass: TcxRowPropertiesClass; override;
    function GetStylesClass: TcxvgCustomRowStylesClass; override;
    property Styles: TcxEditorRowStyles read GetStyles write SetStyles;
    property Properties: TcxMultiEditorRowProperties read GetProperties write SetProperties;
  public
    function CreateHeaderInfo: TcxCustomRowHeaderInfo; override;
    function CreateViewInfo: TcxCustomRowViewInfo; override;
  end;

  { TcxMultiEditorRow }

  TcxMultiEditorRow = class(TcxCustomMultiEditorRow)
  published
    property Expanded;
    property Height;
    property Options;
    property Properties;
    property Styles;
    property Visible;
  end;

  { TcxVerticalGridRows }

  TcxVerticalGridRows = class
  private
    FList: TList;
    FLockCount: Integer;
    FNextID: Integer;
    FOwner: TcxCustomVerticalGrid;
    FCount: Integer;
    FMaxVisibleLevel: Integer;
    FVisibleRows: TList;
    function GetCount: Integer;
    function GetRoot: TcxCustomRow;
    function GetRow(Index: Integer): TcxCustomRow;
    function GetVisibleRowCount: Integer;
    function GetVisibleRow(Index: Integer): TcxCustomRow;
    procedure SetRow(Index: Integer; const Value: TcxCustomRow);
  protected
    procedure Add(ARow: TcxCustomRow);
    procedure AddChild(AParent, ARow: TcxCustomRow);
    procedure BeginUpdate;
    procedure Changed(ARebuild: Boolean = False); virtual;
    procedure CheckList;
    procedure Clear;
    procedure EndUpdate;
    function FindLoadedParent(AID: Integer): TcxCustomRow;
    function FindRowByID(AID: Integer): TcxCustomRow;
    function FindRowByStoredName(const AName: string): TcxCustomRow;
    function GetNextID: Integer;
    function IsRowVisible(ARow: TcxCustomRow): Boolean;
    procedure PrepareList;
    procedure Remove(ARow: TcxCustomRow);
    procedure RestoreDefaults;
    procedure UnprepareList;
    procedure UpdateVisibleRows;

    property MaxVisibleLevel: Integer read FMaxVisibleLevel;
    property Root: TcxCustomRow read GetRoot;
    property Owner: TcxCustomVerticalGrid read FOwner;
    property VisibleRowCount: Integer read GetVisibleRowCount;
    property VisibleRows[Index: Integer]: TcxCustomRow read GetVisibleRow;
  public
    constructor Create(AOwner: TcxCustomVerticalGrid);
    destructor Destroy; override;
    procedure AssignRows(Source: TcxVerticalGridRows);
    function IndexOf(ARow: TcxCustomRow): Integer;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxCustomRow read GetRow write SetRow; default;
  end;

  TcxvgUnboundLayoutStyle = (ulsBandsView, ulsSingleRecordView);
  TcxvgLayoutStyle = (lsBandsView, lsSingleRecordView, lsMultiRecordView);

  { TBandInfoList }

  TBandInfo = record
    BandIndex: Integer;
    RowsCount: Integer;
    BandHeight: Integer;
    FirstRow: TcxCustomRow;
  end;

  TBandInfoList = class(TcxDataList)
  private
    function GetItem(Index: Integer): TBandInfo;
  public
    constructor Create;
    function Add(ABandIndex, ARowsCount, ABandHeight: Integer;
      AFirstRow: TcxCustomRow): Integer;
    property Items[Index: Integer]: TBandInfo read GetItem; default;
  end;

  { TcxvgCustomScrollStrategy }

  TcxvgCustomScrollStrategy = class
  private
    FBandsInfo: TBandInfoList;
    FCheckingCoordinate: Boolean;
    FLeftVisibleRecord: Integer;
    FScroller: TcxvgScroller;
    FTopVisibleRowIndex: Integer;
    function GetController: TcxvgController; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetDataController: TcxCustomDataController; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetScrollBarPos: Integer;
    function GetVerticalGrid: TcxCustomVerticalGrid; {$IFDEF DELPHI9} inline; {$ENDIF}
		function GetViewInfo: TcxvgCustomViewInfo; {$IFDEF DELPHI9} inline; {$ENDIF}
    function GetVisibleRowCount: Integer;
    procedure SetScrollBarPos(Value: Integer);
    procedure SetTopVisibleRowIndex(Value: Integer);
  protected
    function CanContinueForward(Index: Integer): Boolean; virtual;
    function CanContinueBackward(Index: Integer): Boolean; virtual;
    function CanCalcRowsOnTheNextBand(ALeft, ANextBandIndex: Integer): Boolean; virtual;
    procedure CheckLeftVisibleRecord(var AValue: Integer); virtual;
    function GetBandInterval: Integer; virtual; abstract;
    function GetBandWidth: Integer;
    function GetBottomVisibleChild(ARow: TcxCustomRow): TcxCustomRow;
    function GetFullRowHeight(ARow: TcxCustomRow; out ChildCount: Integer): Integer;
    function GetLeftVisibleBand: Integer; virtual; abstract;
    function GetScrollBarOffsetBegin: Integer; virtual;
    function GetScrollBarOffsetEnd: Integer; virtual;
    function GetVisibleBandCount: Integer; virtual; abstract;
    function GetVisibleCount(ABeginIndex, AAreaHeight, AStep: Integer;
      AForward: Boolean): Integer; virtual;
    function GetVisibleValueCount: Integer; virtual; abstract;
    function IsBehindRightClientEdge(X: Integer): Boolean;
    function IsHideHScrollBar: Boolean; virtual;
    function IsHideVScrollBar: Boolean; virtual;
    function IsRecordsScrollMode: Boolean; virtual;
    procedure ScrollH(AScrollCode: TScrollCode; var AScrollPos: Integer); virtual;
    procedure ScrollV(AScrollCode: TScrollCode; var AScrollPos: Integer); virtual;
    procedure SetLeftVisibleBand(Value: Integer); virtual; abstract;
    procedure SetLeftVisibleRecord(Value: Integer); virtual;
    procedure SetTopVisibleRowIndexAndBand(Index: Integer);

    property Scroller: TcxvgScroller read FScroller;
    property ScrollBarPos: Integer read GetScrollBarPos write SetScrollBarPos;
  public
    constructor Create(AScroller: TcxvgScroller); virtual;
    destructor Destroy; override;
    procedure CheckDecreaseLeftIndex; virtual;
    procedure CheckDecreaseTopIndex(AScrollRectHeight: Integer); virtual;
    function CheckTopVisibleIndex(AIndex, AStep: Integer): Integer; virtual;
    function FindNextCustomItem(AFocusedItemIndex, AItemCount: Integer;
       AGoForward: Boolean; var AItemIndex: Integer): Boolean;
    function FindNextRecord(AFocusedRecordIndex: Integer; AGoForward: Boolean): Integer;
    function FocusNextRecord(AFocusedRecordIndex: Integer; AGoForward: Boolean): Boolean;
		function GetBandIndexByRowIndex(ARowIndex: Integer): Integer; virtual; abstract;
    function GetVisibleCountFromBottom(ABottomIndex, AHeight: Integer): Integer;
    function GetVisibleCountFromTop(ATopIndex, AHeight: Integer): Integer;
    function GetFirstRowByBandIndex(ABandIndex: Integer): TcxCustomRow; virtual;
    procedure InitHScrollBarParameters; virtual;
    procedure InitVScrollBarParameters; virtual;
    procedure RecalcBandsInfo; virtual;
    procedure ScrollRecords(AForward: Boolean; ACount: Integer);
    procedure SetRowMaxVisible(ARow: TcxCustomRow); virtual;

    property BandInterval: Integer read GetBandInterval;
    property BandWidth: Integer read GetBandWidth;
    property BandsInfo: TBandInfoList read FBandsInfo;
    property Controller: TcxvgController read GetController;
    property DataController: TcxCustomDataController read GetDataController;
    property LeftVisibleBand: Integer read GetLeftVisibleBand write SetLeftVisibleBand;
    property LeftVisibleRecord: Integer read FLeftVisibleRecord write SetLeftVisibleRecord;
    property ScrollBarOffsetBegin: Integer read GetScrollBarOffsetBegin;
    property ScrollBarOffsetEnd: Integer read GetScrollBarOffsetEnd;
    property TopVisibleRowIndex: Integer read FTopVisibleRowIndex write SetTopVisibleRowIndex;
    property VerticalGrid: TcxCustomVerticalGrid read GetVerticalGrid;
    property ViewInfo: TcxvgCustomViewInfo read GetViewInfo;
    property VisibleBandCount: Integer read GetVisibleBandCount;
    property VisibleRowCount: Integer read GetVisibleRowCount;
    property VisibleValueCount: Integer read GetVisibleValueCount;
  end;

  TcxvgCustomScrollStrategyClass = class of TcxvgCustomScrollStrategy;

  { TcxvgSingleRecordScrollStrategy }

  TcxvgSingleRecordScrollStrategy = class(TcxvgCustomScrollStrategy)
  protected
    function GetBandInterval: Integer; override;
    function GetLeftVisibleBand: Integer; override;
    function GetVisibleBandCount: Integer; override;
    function GetVisibleValueCount: Integer; override;
    procedure SetLeftVisibleBand(Value: Integer); override;
  public
    function GetBandIndexByRowIndex(ARowIndex: Integer): Integer; override;
  end;

  { TcxvgMultiRecordsScrollStrategy }

  TcxvgMultiRecordsScrollStrategy = class(TcxvgCustomScrollStrategy)
  private
    function GetRecordsInterval: Integer;
  protected
    function GetBandInterval: Integer; override;
    function GetLeftVisibleBand: Integer; override;
    function GetVisibleBandCount: Integer; override;
    function GetVisibleValueCount: Integer; override;
    procedure SetLeftVisibleBand(Value: Integer); override;
    property RecordsInterval: Integer read GetRecordsInterval;
  public
    procedure CheckDecreaseLeftIndex; override;
    function GetBandIndexByRowIndex(ARowIndex: Integer): Integer; override;
  end;

  { TcxvgBandsScrollStrategy }

  TcxvgBandsScrollStrategy = class(TcxvgCustomScrollStrategy)
  private
    FLeftVisibleBand: Integer;
  protected
    function CanCalcRowsOnTheNextBand(ALeft, ANextBandIndex: Integer): Boolean; override;
    function GetBandInterval: Integer; override;
    function GetBandViewRowMaxVisibleTopIndex(ARow: TcxCustomRow): Integer;
    function GetLeftVisibleBand: Integer; override;
    function GetVisibleBandCount: Integer; override;
    function GetVisibleValueCount: Integer; override;
    function IsRecordsScrollMode: Boolean; override;
    procedure SetLeftVisibleBand(Value: Integer); override;
  public
    procedure CheckDecreaseTopIndex(AScrollRectHeight: Integer); override;
    function CheckTopVisibleIndex(AIndex, AStep: Integer): Integer; override;
    function GetBandIndexByRowIndex(ARowIndex: Integer): Integer; override;
    procedure InitHScrollBarParameters; override;
    function IsHideVScrollBar: Boolean; override;
    procedure RecalcBandsInfo; override;
    procedure SetRowMaxVisible(ARow: TcxCustomRow); override;
  end;

  { TcxvgScroller }

  TcxvgScroller = class
  private
    FCheckDecreaseLeftIndex: Boolean;
    FCheckDecreaseTopIndex: Boolean;
    FSaveLeftVisibleBand: Integer;
    FSaveLeftVisibleRecord: Integer;
    FSaveTopVisibleRowIndex: Integer;
    FScrollStrategy: TcxvgCustomScrollStrategy;
    FVerticalGrid: TcxCustomVerticalGrid;
    procedure CheckDecreaseLeftIndex;
    procedure CheckDecreaseTopIndex;
    function GetBandsInfo: TBandInfoList;
    function GetCheckDecrease: Boolean;
    function GetFocusedRecordIndex: Integer;
    function GetLeftVisibleBand: Integer;
    function GetLeftVisibleRecord: Integer;
    function GetTopVisibleRowIndex: Integer;
    function GetViewInfo: TcxvgCustomViewInfo;
    function GetVisibleCountFromBottom(ARowIndex: Integer): Integer;
    function GetVisibleRowCount: Integer;
    function GetVisibleValueCount: Integer;
    procedure SetCheckDecrease(Value: Boolean);
    procedure SetLeftVisibleBand(Value: Integer);
    procedure SetLeftVisibleRecord(Value: Integer);
    procedure SetTopVisibleRowIndex(Value: Integer);
  protected
    function CreateScrollStrategy(AScroller: TcxvgScroller): TcxvgCustomScrollStrategy; virtual;
    procedure LayoutStyleChanged;
    procedure RestoreLayout; virtual;
    procedure SaveLayout; virtual;
    // other
    property FocusedRecordIndex: Integer read GetFocusedRecordIndex;
    property SaveLeftVisibleBand: Integer read FSaveLeftVisibleBand;
    property SaveLeftVisibleRecord: Integer read FSaveLeftVisibleRecord;
    property SaveTopRowIndex: Integer read FSaveTopVisibleRowIndex;
    property ScrollStrategy: TcxvgCustomScrollStrategy read FScrollStrategy;
    property VerticalGrid: TcxCustomVerticalGrid read FVerticalGrid;
    property ViewInfo: TcxvgCustomViewInfo read GetViewInfo;
  public
    constructor Create(AVerticalGrid: TcxCustomVerticalGrid); virtual;
    destructor Destroy; override;
    // navigation
    function GoToFirst: Boolean;
    function GoToLast: Boolean;
    function GoToNext: Boolean;
    function GoToPrev: Boolean;

    function GetBandIndexByRowIndex(ARowIndex: Integer): Integer;
    procedure InitScrollBarsParameters; virtual;
    procedure RecalcBandsInfo;
    procedure RecreateScrollStrategy;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer);
    function SetRecordVisible(ARecordIndex: Integer): Boolean; virtual;
    procedure SetRowVisible(ARow: TcxCustomRow); virtual;
    procedure SetRowMaxVisible(ARow: TcxCustomRow);
    property BandsInfo: TBandInfoList read GetBandsInfo;
    property CheckDecrease: Boolean read GetCheckDecrease write SetCheckDecrease;
    property LeftVisibleBand: Integer read GetLeftVisibleBand write SetLeftVisibleBand;
    property LeftVisibleRecord: Integer read GetLeftVisibleRecord write SetLeftVisibleRecord;
    property TopVisibleRowIndex: Integer read GetTopVisibleRowIndex write SetTopVisibleRowIndex;
    property VisibleRowCount: Integer read GetVisibleRowCount;
    property VisibleValueCount: Integer read GetVisibleValueCount;
  end;

  { TcxvgHitTest }

  TcxvgHitTest = class(TcxCustomHitTestController)
  private
    FHitInControl: Boolean;
    FHitBandIndex: Integer;
    FHitRow: TcxCustomRow;
    FHitCellIndex: Integer;
    function GetHitAtRowHeader: Boolean;
    function GetVerticalGrid: TcxCustomVerticalGrid;
  protected
    FNewHitTestItem: TObject;
    function AllowDesignMouseEvents(X, Y: Integer; AShift: TShiftState): Boolean; override;
    procedure CalcBandsHitTest(AViewInfo: TcxvgCustomViewInfo); virtual;
    function CalcCustomizingHitTest: Boolean; virtual;
    function CalcRowHeaderHitTest(AHeaderInfo: TcxCustomRowHeaderInfo): Boolean; virtual;
    function CalcRowHitTest(ARowViewInfo: TcxCustomRowViewInfo): Boolean;
    procedure CalcRowValuesHitTest(ARowViewInfo: TcxCustomRowViewInfo); virtual;
    procedure CalcRowsHitTest(AViewInfo: TcxvgCustomViewInfo);
    function CanMoving: Boolean; virtual;
    function CanSizing: Boolean; overload;
    function CanSizing(var ASizeDirection: TcxDragSizingDirection): Boolean; overload; virtual;
    function Check(const ARect: TRect): Boolean;
    procedure DoCalculate; override;
    function GetCurrentCursor: TCursor; override;
    function GetState(Index: Integer): Boolean;
    procedure SetHitState(Index: Integer; Value: Boolean);
    property VerticalGrid: TcxCustomVerticalGrid read GetVerticalGrid;
  public
    property HitAtBandSizing: Boolean index vghc_HitAtBandSizing read GetState;
    property HitAtButton: Boolean index vghc_HitAtButton read GetState;
    property HitAtCaption: Boolean index vghc_HitAtCaption read GetState;
    property HitAtCustomize: Boolean index vghc_HitAtCustomize read GetState;
    property HitAtDivider: Boolean index vghc_HitAtDivider read GetState;
    property HitAtEmpty: Boolean index vghc_HitAtEmpty read GetState;
    property HitAtImage: Boolean index vghc_HitAtImage read GetState;
    property HitAtIndent: Boolean index vghc_HitAtIndent read GetState;
    property HitAtRowHeader: Boolean read GetHitAtRowHeader;
    property HitAtRowSizing: Boolean index vghc_HitAtRowSizing read GetState;
    property HitAtValue: Boolean index vghc_HitAtValue read GetState;
    property HitBandIndex: Integer read FHitBandIndex;
    property HitInControl: Boolean read FHitInControl;
    property HitRow: TcxCustomRow read FHitRow;
    property HitCellIndex: Integer read FHitCellIndex;
  end;

  { TcxvgCellNavigator }

  TcxvgCellNavigator = class(TcxCustomCellNavigator)
  private
    function GetController: TcxvgController;
    function GetRecordCount: Integer;
    function GetRow(Index: Integer): TcxCustomRow;
    function GetValueCount: Integer;
  protected
    procedure CalcNextRow(AForward: Boolean; var ARowIndex, ACellIndex: Integer); override;
    function FindNextRecord(AForward: Boolean): Boolean;
    function GetCellContainer(ARowIndex, ACellIndex: Integer): TcxCustomInplaceEditContainer; override;
    function GetContainerCount(ARowIndex: Integer): Integer;
    function GetCount(ARowIndex: Integer): Integer; override;
    procedure Init(var ARowIndex, ACellIndex, ARowCount: Integer); override;
    function MayFocusedEmptyRow(ARowIndex: Integer): Boolean; override;
    procedure SetFocusCell(ARowIndex, ACellIndex: Integer; AShift: TShiftState = []); override;
  public
    constructor Create(AController: TcxCustomControlController); override;
    procedure FocusNextCell(AForward, ANextRow: Boolean; AShift: TShiftState = []); override;
    property RecordCount: Integer read GetRecordCount;
    property Rows[Index: Integer]: TcxCustomRow read GetRow;
    property Controller: TcxvgController read GetController;
    property ValueCount: Integer read GetValueCount;
  end;

  { TcxvgDragImageHelper }

  TcxvgDragImageHelper = class(TcxDragImageHelper)
  protected
    procedure DragAndDrop(const P: TPoint); override;
    function GetCursor: TCursor; virtual;
  end;

  { TcxvgController }

  TcxvgResizeKind = (rkNone, rkRowSizing, rkDivider, rkBandSizing);

  TcxvgController = class(TcxCustomControlController, IUnknown, IcxDragSizing)
  private
    FAutoScrollObject: TcxControllerAutoScrollingObject;
    FCellIndex: Integer;
    FDragFromCustomizingForm: Boolean;
    FDragRow: TcxCustomRow;
    FForceShowEditor: Boolean;
    FFocusedRow: TcxCustomRow;
    FLockIncSearch: Boolean;
    FProcessMultiEditorRow: Boolean;
    FResizeKind: TcxvgResizeKind;
    FSaveFocusedRow: TcxCustomRow;
    FSaveSeparatorPos: Integer;
    FScrollDown: Boolean;
    FScroller: TcxvgScroller;
    FScrollTimer: TTimer;
    FSizingRow: TcxCustomRow;
    FSizingValue: Integer;
    FTrackingEnabled: Boolean;
    FWasScroll: Boolean;
    procedure CheckMoveToCustomizationForm;
    function GetFirstVisibleRow: TcxCustomRow;
    function GetHitTest: TcxvgHitTest;
    function GetVerticalGrid: TcxCustomVerticalGrid;
    function GetViewInfo: TcxvgCustomViewInfo;
    procedure SetFocusedRow(Value: TcxCustomRow);
    procedure SetResizeKind(Value: TcxvgResizeKind);
    procedure OnScrollTimer(Sender: TObject);
    procedure StartScrollTimer;
    procedure StopScrollTimer;
  protected
    FLockUpdate: Boolean;
    ResizeDirection: TcxDragSizingDirection;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxDragSizing
    function CanSizing(ADirection: TcxDragSizingDirection): Boolean; virtual;
    function GetSizingBoundsRect(ADirection: TcxDragSizingDirection): TRect; virtual;
    function GetSizingIncrement(ADirection: TcxDragSizingDirection): Integer; virtual;
    function IsDynamicUpdate: Boolean; virtual;
    procedure SetSizeDelta(ADirection: TcxDragSizingDirection; ADelta: Integer); virtual;
    // drag'n'drop
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure EndDrag(Target: TObject; X, Y: Integer); override;
    procedure StartDrag(var DragObject: TDragObject); override;

    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure BehaviorChanged; override;
    function CanAppend(ACheckOptions: Boolean): Boolean; virtual;
    function CanChangeRecord: Boolean; virtual;
    function CanDelete(ACheckOptions: Boolean): Boolean; virtual;
    function CanInsert(ACheckOptions: Boolean): Boolean; virtual;
    function CanTrack(const AShift: TShiftState): Boolean; virtual;
    procedure CheckFocusFirstVisibleRow;
    procedure CheckPostData;
    procedure CheckRowTracking(Shift: TShiftState; X, Y: Integer);
    procedure DoCancelMode; override;
    procedure DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoNextPage(AForward: Boolean; Shift: TShiftState); override;
    procedure DoUpdateRowAndCell(ANewRow: TcxCustomRow; ANewCellIndex: Integer); virtual;
    procedure FocusedItemChanged(APrevFocusedItem: TcxCustomInplaceEditContainer); override;
    function GetCancelEditingOnExit: Boolean; override;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
    function GetFocusedCellViewInfo(AEditContainer: TcxCustomInplaceEditContainer): TcxEditCellViewInfo; override;
    function GetImmediateEditor: Boolean; override;
    function GetNavigatorClass: TcxCustomCellNavigatorClass; override;
    function GetPostDataOnChangeItem: Boolean; virtual;
    function GetResizeDirection: TcxDragSizingDirection; override;
    procedure InternalSetRowAndCell(ARow: TcxCustomRow; ACellIndex: Integer);
    function IsImmediatePost: Boolean; override;
    function IsInternalDragging: Boolean;
    function IsKeyForController(AKey: Word; AShift: TShiftState): Boolean; override;
    procedure RefreshFocusedRow; virtual;
    procedure SetFocusedCellEdit(ACellEdit: TcxCellEdit);
    procedure SetFocusedRowAndCell(Value: TcxCustomRow; ACellIndex: Integer); virtual;
    procedure UpdatePaintStyle; virtual;
    procedure UpdateRecord(ARecordIndex: Integer); override;

    property DragRow: TcxCustomRow read FDragRow;
    property DragFromCustomizingForm: Boolean read FDragFromCustomizingForm;
    property ForceShowEditor: Boolean read FForceShowEditor;
    property ProcessMultiEditorRow: Boolean read FProcessMultiEditorRow;
    property ResizeKind: TcxvgResizeKind read FResizeKind write SetResizeKind;
    property SaveFocusedRow: TcxCustomRow read FSaveFocusedRow;
    property SaveSeparatorPos: Integer read FSaveSeparatorPos;
  public
    // override
    constructor Create(AOwner: TcxEditingControl); override;
    destructor Destroy; override;
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;

    procedure Clear; override;
    procedure ControlFocusChanged; override;
    function GetCursor(X, Y: Integer): TCursor; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MakeFocusedItemVisible; override;
    procedure MakeFocusedRecordVisible; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    // drag and drop
    function CanDrag(X, Y: Integer): Boolean; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;
    // scrolling
    procedure InitScrollBarsParameters; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;
    // recreate viewinfos
    procedure RestoreLayout; virtual;
    procedure SaveLayout; virtual;

    procedure AppendRecord; virtual;
    procedure DeleteSelection; virtual;
    procedure InsertRecord; virtual;
    procedure MakeRowVisible(ARow: TcxCustomRow); virtual;
    function MakeRecordVisible(AIndex: Integer): Boolean; virtual;
    property CellIndex: Integer read FCellIndex;
    property FocusedRow: TcxCustomRow read FFocusedRow write SetFocusedRow;
    property HitTest: TcxvgHitTest read GetHitTest;
    property Scroller: TcxvgScroller read FScroller;
    property VerticalGrid: TcxCustomVerticalGrid read GetVerticalGrid;
    property ViewInfo: TcxvgCustomViewInfo read GetViewInfo;
  end;

  { TcxvgMultiRecordsController }

  TcxvgMultiRecordsController = class(TcxvgController)
  private
    function GetOptionsBehavior: TcxvgMultiRecordsOptionsBehavior;
    function GetOptionsData: TcxvgMultiRecordsOptionsData;
    function GetVerticalGrid: TcxVirtualVerticalGrid;
  protected
    function CanAppend(ACheckOptions: Boolean): Boolean; override;
    function CanChangeRecord: Boolean; override;
    function CanDelete(ACheckOptions: Boolean): Boolean; override;
    function CanHandleDeleteRecordKeys: Boolean; override;
    function CanInsert(ACheckOptions: Boolean): Boolean; override;
    procedure FocusedRecordChanged(APrevFocusedRowIndex, AFocusedRowIndex: Integer); override;
    function GetCancelEditingOnExit: Boolean; override;
    function GetFocusedRecordIndex: Integer; override;
    function GetPostDataOnChangeItem: Boolean; override;
    function IncSearchKeyDown(AKey: Word; AShift: TShiftState): Word; override;
    function IsImmediatePost: Boolean; override;
    procedure RefreshIncSearchItem; virtual;
    procedure SetFocusedRecordIndex(Value: Integer); override;
    property OptionsBehavior: TcxvgMultiRecordsOptionsBehavior read GetOptionsBehavior;
    property OptionsData: TcxvgMultiRecordsOptionsData read GetOptionsData;
    property VerticalGrid: TcxVirtualVerticalGrid read GetVerticalGrid;
  public
    procedure DeleteSelection; override;
  end;

  { TcxCustomVerticalGrid }

  TcxVerticalGridDrawHeaderEvent = procedure(Sender: TObject;
    ACanvas: TcxCanvas; APainter: TcxvgPainter;
    AHeaderViewInfo: TcxCustomRowHeaderInfo;
    var Done: Boolean) of object;

  TcxVerticalGridDrawValueEvent = procedure(Sender: TObject;
    ACanvas: TcxCanvas; APainter: TcxvgPainter;
    AValueInfo: TcxRowValueInfo;
    var Done: Boolean) of object;

  TcxVerticalGridDrawBackgroundEvent = procedure(Sender: TObject;
    ACanvas: TcxCanvas; const R: TRect; const AViewParams: TcxViewParams;
    var Done: Boolean) of object;

  TcxVerticalGridEditingEvent = procedure(Sender: TObject;
    ARowProperties: TcxCustomEditorRowProperties; var Allow: Boolean) of object;

  TcxVerticalGridChangedEvent = procedure(Sender: TObject;
    ARowProperties: TcxCustomEditorRowProperties) of object;

  TcxVerticalGridItemChangedEvent = procedure(Sender: TObject;
    AOldRow: TcxCustomRow; AOldCellIndex: Integer) of object;

  TcxCustomVerticalGrid = class(TcxExtEditingControl, IcxStoredObject,
    IcxStoredParent, IdxSkinSupport)
  private
    FCategoryFont: TFont;
    FClearingRows: Boolean;
    FCustomizing: TcxVerticalGridCustomizing;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FNewLoadMode: Boolean;
    FRootRow: TcxCustomRow;
    FRows: TcxVerticalGridRows;
    FSaveDragCursor: TCursor;
    FStoringName: string;
    FStylesEvents: TNotifyEvent;
    FVersion: Integer;
    FOnCustomizationVisibleChanged: TNotifyEvent;
    FOnDrawBackground: TcxVerticalGridDrawBackgroundEvent;
    FOnDrawRowHeader: TcxVerticalGridDrawHeaderEvent;
    FOnDrawValue: TcxVerticalGridDrawValueEvent;
    FOnEdited: TcxVerticalGridChangedEvent;
    FOnEditing: TcxVerticalGridEditingEvent;
    FOnEditValueChanged: TcxVerticalGridChangedEvent;
    FOnItemChanged: TcxVerticalGridItemChangedEvent;
    FOnLayoutChanged: TNotifyEvent;
    FOnLeftVisibleBandIndexChanged: TNotifyEvent;
    FOnLeftVisibleRecordIndexChanged: TNotifyEvent;
    FOnTopRowIndexChanged: TNotifyEvent;
    procedure CategoryFontChanged(Sender: TObject);
    function GetController: TcxvgController;
    function GetDragHeaderInfo: TcxCustomRowHeaderInfo;
    function GetFocusedRow: TcxCustomRow;
    function GetHitTest: TcxvgHitTest;
    function GetInplaceEditor: TcxCustomEdit;
    function GetIsEditing: Boolean;
    function GetLeftVisibleBand: Integer;
    function GetLeftVisibleRecord: Integer;
    function GetOptionsBehavior: TcxvgOptionsBehavior;
    function GetOptionsView: TcxvgOptionsView;
    function GetPainter: TcxvgPainter;
    function GetRecordCount: Integer;
    function GetStyles: TcxVerticalGridStyles;
    function GetTopVisibleRowIndex: Integer;
    function GetViewInfo: TcxvgCustomViewInfo;
    procedure ImageListChange(Sender: TObject);
    procedure SetFocusedRow(Value: TcxCustomRow);
    procedure SetImages(Value: TCustomImageList);
    procedure SetLeftVisibleBand(Value: Integer);
    procedure SetLeftVisibleRecord(Value: Integer);
    procedure SetOptionsBehavior(Value: TcxvgOptionsBehavior);
    procedure SetOptionsView(Value: TcxvgOptionsView);
    procedure SetStyles(Value: TcxVerticalGridStyles);
    procedure SetTopVisibleRowIndex(Value: Integer);
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    // layout version
    procedure ReadVersion(Reader: TReader);
    procedure WriteVersion(Writer: TWriter);
  protected
    // IcxStoredObject
    function GetObjectName: string; virtual;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // IcxStoredParent
    function CreateChild(const AObjectName, AClassName: string): TObject; virtual;
    procedure DeleteChild(const AObjectName: string; AObject: TObject); virtual;
    procedure IcxStoredParent.GetChildren = GetStoredChildren;
    procedure GetStoredChildren(AChildren: TStringList); virtual;
    // vcl methods
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DefineProperties(Filer: TFiler); override;
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    // cxControls
    procedure BoundsChanged; override;
    procedure FontChanged; override;
    procedure InitControl; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); override;
    // cxControls - drag'n'drop
    function GetDragObjectClass: TDragControlObjectClass; override;
    // cxExtEditingControl
    procedure AfterLayoutChanged; override;
    procedure CreateSubClasses; override;
    procedure DataChanged; override;
    procedure DestroySubClasses; override;
    procedure DoEdited(AItem: TcxCustomInplaceEditContainer); override;
    function DoEditing(AItem: TcxCustomInplaceEditContainer): Boolean; override;
    procedure DoEditValueChanged(AItem: TcxCustomInplaceEditContainer); override;
    procedure DoInplaceEditContainerItemRemoved(AItem: TcxCustomInplaceEditContainer); override;
    procedure DoLayoutChanged; override;
    function DragDropImageDisplayRect: TRect; override;
    procedure DrawDragDropImage(ADragBitmap: TBitmap; ACanvas: TcxCanvas); override;
    function GetControllerClass: TcxCustomControlControllerClass; override;
    function GetControlStylesClass: TcxCustomControlStylesClass; override;
    function GetDragImageHelperClass: TcxDragImageHelperClass; override;
    function GetEditCellDataBindingClass: TcxItemDataBindingClass; virtual;
    function GetHitTestControllerClass: TcxHitTestControllerClass; override;
    function GetOptionsBehaviorClass: TcxControlOptionsBehaviorClass; override;
    function GetOptionsViewClass: TcxControlOptionsViewClass; override;
    function GetPainterClass: TcxCustomControlPainterClass; override;
    function HasDragDropImages: Boolean; override;
    function IsLocked: Boolean; override;
    procedure RecreateViewInfo; override;
    // layout
    procedure RestoreLayout;
    // virtuals
    procedure AfterLoadedRows;
    procedure BeforeLoadedRows;
    function CanBandSizing: Boolean; virtual;
    procedure CheckRowClass(ARowClass: TcxCustomRowClass); virtual;
    procedure CheckGridModeBufferCount;
    procedure CheckLayoutRealign;
    procedure FreeRowsViewInfo;
    procedure DoCustomizationVisibleChanged; virtual;
    function DoDrawBackgroundPart(const R: TRect; const AViewParams: TcxViewParams): Boolean; virtual;
    function DoDrawRowHeader(AHeaderViewInfo: TcxCustomRowHeaderInfo): Boolean; virtual;
    function DoDrawValue(AValueInfo: TcxRowValueInfo): Boolean; virtual;
    procedure DoItemChanged(AOldRow: TcxCustomRow; AOldCellIndex: Integer); virtual;
    procedure DoLeftVisibleBandIndexChanged; virtual;
    procedure DoLeftVisibleRecordIndexChanged; virtual;
    procedure DoTopRowIndexChanged; virtual;
    function GetCalcHelperClass: TcxvgCustomPaintStyleCalcHelperClass; virtual;
    function GetCellAutoHeight: Boolean; virtual;
    function GetCustomizingClass: TcxVerticalGridCustomizingClass; virtual;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); virtual;
    function GetEditorRowClass: TcxCustomRowClass; virtual;
    function GetMultiEditorRowClass: TcxCustomRowClass; virtual;
    function GetScrollStrategyClass: TcxvgCustomScrollStrategyClass; virtual; abstract;
    procedure InitDataController; virtual;
    procedure PaintStyleChanged;
    procedure RemoveRowFromVerticalGrid(ARow: TcxCustomRow);
    procedure RowsChanged; virtual;
    procedure UpdateDesignEditor; virtual;

    property CategoryFont: TFont read FCategoryFont;
    property Controller: TcxvgController read GetController;
    property Customizing: TcxVerticalGridCustomizing read FCustomizing write FCustomizing;
    property DragHeaderInfo: TcxCustomRowHeaderInfo read GetDragHeaderInfo;
    property LeftVisibleRecord: Integer read GetLeftVisibleRecord write SetLeftVisibleRecord;
    property Painter: TcxvgPainter read GetPainter;
    property RecordCount: Integer read GetRecordCount;
    property RootRow: TcxCustomRow read FRootRow;
    property OnCustomizationFormVisibleChanged: TNotifyEvent read FOnCustomizationVisibleChanged write FOnCustomizationVisibleChanged;
    property OnDrawBackground: TcxVerticalGridDrawBackgroundEvent read FOnDrawBackground write FOnDrawBackground;
    property OnDrawRowHeader: TcxVerticalGridDrawHeaderEvent read FOnDrawRowHeader write FOnDrawRowHeader;
    property OnDrawValue: TcxVerticalGridDrawValueEvent read FOnDrawValue write FOnDrawValue;
    property OnEdited: TcxVerticalGridChangedEvent read FOnEdited write FOnEdited;
    property OnEditing: TcxVerticalGridEditingEvent read FOnEditing write FOnEditing;
    property OnEditValueChanged: TcxVerticalGridChangedEvent read FOnEditValueChanged write FOnEditValueChanged;
    property OnItemChanged: TcxVerticalGridItemChangedEvent read FOnItemChanged write FOnItemChanged;
    property OnLayoutChanged: TNotifyEvent read FOnLayoutChanged write FOnLayoutChanged;
    property OnLeftVisibleBandIndexChanged: TNotifyEvent read FOnLeftVisibleBandIndexChanged write FOnLeftVisibleBandIndexChanged;
    property OnLeftVisibleRecordIndexChanged: TNotifyEvent read FOnLeftVisibleRecordIndexChanged write FOnLeftVisibleRecordIndexChanged;
    property OnTopRowIndexChanged: TNotifyEvent read FOnTopRowIndexChanged write FOnTopRowIndexChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // work with rows
    function Add(ARowClass: TcxCustomRowClass): TcxCustomRow;
    function AddChild(AParent: TcxCustomRow; ARowClass: TcxCustomRowClass): TcxCustomRow;
    procedure AssignRows(Source: TcxCustomVerticalGrid); virtual;
    procedure ClearRows;
    function FirstRow: TcxCustomRow;
    function FirstVisibleRow: TcxCustomRow;
    procedure FocusRow(ARow: TcxCustomRow; ACellIndex: Integer = 0);
    procedure FullCollapse;
    procedure FullExpand;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function HasRows: Boolean;
    function HasVisibleRows: Boolean;
    function IsInternalDragging: Boolean;
    function IsRowVisible(ARow: TcxCustomRow): Boolean;
    function LastRow: TcxCustomRow;
    function LastVisibleRow: TcxCustomRow;
    function NextRow(ARow: TcxCustomRow): TcxCustomRow;
    function NextVisibleRow(ARow: TcxCustomRow): TcxCustomRow;
    function PrevRow(ARow: TcxCustomRow): TcxCustomRow;
    function PrevVisibleRow(ARow: TcxCustomRow): TcxCustomRow;
    procedure Remove(ARow: TcxCustomRow);
    function RowByCaption(const ACaption: string): TcxCustomRow;
    function RowByName(const AName: string): TcxCustomRow;
    // store/load
    procedure RestoreFromIniFile(const AStorageName: string);
    procedure RestoreFromRegistry(const AStorageName: string);
    procedure RestoreFromStream(AStream: TStream);
    procedure StoreToIniFile(const AStorageName: string; AReCreate: Boolean = True);
    procedure StoreToRegistry(const AStorageName: string; AReCreate: Boolean = True);
    procedure StoreToStream(AStream: TStream);
    // edit control
    procedure CancelEdit;
    procedure HideEdit;
    procedure ShowEdit;
    procedure ShowEditByKey(AKey: Char);
    procedure ShowEditByMouse(X, Y: Integer; AShift: TShiftState);

    procedure RestoreDefaults; virtual;
    // properties
    property FocusedRow: TcxCustomRow read GetFocusedRow write SetFocusedRow;
    property HitTest: TcxvgHitTest read GetHitTest;
    property Images: TCustomImageList read FImages write SetImages;
    property InplaceEditor: TcxCustomEdit read GetInplaceEditor;
    property IsEditing: Boolean read GetIsEditing;
    property LeftVisibleBand: Integer read GetLeftVisibleBand write SetLeftVisibleBand;
    property LookAndFeel;
    property OptionsBehavior: TcxvgOptionsBehavior read GetOptionsBehavior write SetOptionsBehavior;
    property OptionsData;
    property OptionsView: TcxvgOptionsView read GetOptionsView write SetOptionsView;
    property Rows: TcxVerticalGridRows read FRows write FRows;
    property StoringName: string read FStoringName write FStoringName;
    property Styles: TcxVerticalGridStyles read GetStyles write SetStyles;
    property TopVisibleRowIndex: Integer read GetTopVisibleRowIndex write SetTopVisibleRowIndex;
    property ViewInfo: TcxvgCustomViewInfo read GetViewInfo;
  published
    property StylesEvents: TNotifyEvent read FStylesEvents write FStylesEvents;
  end;

  { TcxUnboundVerticalGrid }

  TcxUnboundVerticalGrid = class(TcxCustomVerticalGrid)
  private
    FLayoutStyle: TcxvgUnboundLayoutStyle;
    procedure SetLayoutStyle(Value: TcxvgUnboundLayoutStyle);
  protected
    function CanBandSizing: Boolean; override;
    function GetScrollStrategyClass: TcxvgCustomScrollStrategyClass; override;
    function GetViewInfoClass: TcxCustomControlViewInfoClass; override;
    property LayoutStyle: TcxvgUnboundLayoutStyle read FLayoutStyle write SetLayoutStyle default ulsSingleRecordView;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  IcxVGridDesignerRows = interface
  ['{D77CC392-984F-4C1E-A41C-A341FEAC93EB}']
    function GetEditorRowClass: TcxCustomRowClass;
    function GetMultiEditorRowClass: TcxCustomRowClass;
  end;

  { TcxVerticalGrid }

  TcxVerticalGrid = class(TcxUnboundVerticalGrid, IcxVGridDesignerRows)
  public
    property Customizing;
  published
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property LayoutStyle;
    property LookAndFeel;
    property OptionsView; //before OptionsBehavior
    property OptionsBehavior;
    property OptionsData;
    property ParentFont;
    property PopupMenu;
    property Styles;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    property OnCustomizationFormVisibleChanged;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawBackground;
    property OnDrawRowHeader;
    property OnDrawValue;
    property OnEdited;
    property OnEditing;
    property OnEditValueChanged;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnInitEdit;
    property OnItemChanged;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLayoutChanged;
    property OnLeftVisibleBandIndexChanged;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnTopRowIndexChanged;
  end;

  { TcxVirtualVerticalGrid }

  TcxVerticalGridFocusedRecordChangedEvent = procedure(Sender: TcxVirtualVerticalGrid;
    APrevFocusedRecord, AFocusedRecord: Integer) of object;

  IcxVerticalGridDBDataContoller = interface
  ['{947072DE-3531-4010-8C44-D243FD289FDF}']
    procedure CheckGridModeBufferCount;
    function DoScroll(AForward: Boolean): Boolean;
    function GetDataSetRecordCount: Integer;
    function GetScrollBarPos: Integer;
    function GetScrollBarRecordCount: Integer;
    function SetScrollBarPos(APos: Integer): Boolean;
  end;

  TcxVirtualVerticalGrid = class(TcxCustomVerticalGrid, IcxVGridDesignerRows,
    IcxNavigator, IcxFilterControl)
  private
    FNavigatorNotifier: TcxNavigatorControlNotifier;
    FLayoutStyle: TcxvgLayoutStyle;
    FOnFilterControlDialogShow: TNotifyEvent;
    FOnFocusedRecordChanged: TcxVerticalGridFocusedRecordChangedEvent;
    procedure ApplyFilter(Sender: TObject);
    function GetFilterElementProperties(AIndex: Integer): TcxCustomEditorRowProperties;
    function GetFilterRecordEvent: TcxDataFilterRecordEvent;
    function GetFocusedRecordIndex: Integer;
    function GetController: TcxvgMultiRecordsController;
    function GetOptionsBehavior: TcxvgMultiRecordsOptionsBehavior;
    function GetOptionsData: TcxvgMultiRecordsOptionsData;
    function GetOptionsView: TcxvgMultiRecordsOptionsView;
    procedure SetFilterRecordEvent(Value: TcxDataFilterRecordEvent);
    procedure SetFocusedRecordIndex(Value: Integer);
    procedure SetLayoutStyle(Value: TcxvgLayoutStyle);
    procedure SetOptionsBehavior(Value: TcxvgMultiRecordsOptionsBehavior);
    procedure SetOptionsData(Value: TcxvgMultiRecordsOptionsData);
    procedure SetOptionsView(Value: TcxvgMultiRecordsOptionsView);
  protected
    // IcxFilterControl
    function IcxFilterControl.GetCaption = GetFilterCaption;
    function IcxFilterControl.GetCount = GetFilterCount;
    function IcxFilterControl.GetCriteria = GetFilterCriteria;
    function IcxFilterControl.GetFieldName = GetFilterFieldName;
    function IcxFilterControl.GetItemLink = GetFilterItemLink;
    function IcxFilterControl.GetItemLinkID = GetFilterItemLinkID;
    function IcxFilterControl.GetProperties = GetFilterProperties;
    function IcxFilterControl.GetValueType = GetFilterValueType;
    function GetFilterCaption(Index: Integer): string;
    function GetFilterCount: Integer;
    function GetFilterCriteria: TcxFilterCriteria;
    function GetFilterFieldName(Index: Integer): string;
    function GetFilterItemLink(Index: Integer): TObject;
    function GetFilterItemLinkID(Index: Integer): Integer;
    function GetItemLinkName(Index: Integer): string;
    function GetFilterProperties(Index: Integer): TcxCustomEditProperties;
    function GetFilterValueType(Index: Integer): TcxValueTypeClass;
    // IcxNavigator
    function IcxNavigator.CanAppend = NavigatorCanAppend;
    function IcxNavigator.CanDelete = NavigatorCanDelete;
    function IcxNavigator.CanEdit = NavigatorCanEdit;
    function IcxNavigator.CanInsert = NavigatorCanInsert;
    function IcxNavigator.IsActive = NavigatorIsActive;
    function IcxNavigator.IsBof = NavigatorIsBof;
    function IcxNavigator.IsBookmarkAvailable = NavigatorIsBookmarkAvailable;
    function IcxNavigator.IsEditing = NavigatorIsEditing;
    function IcxNavigator.IsEof = NavigatorIsEof;
    procedure IcxNavigator.ClearBookmark = NavigatorClearBookmark;
    procedure IcxNavigator.DoAction = NavigatorDoAction;
    function IcxNavigator.GetNotifier = NavigatorGetNotifier;
    function IcxNavigator.IsActionSupported = NavigatorIsActionSupported;
    function NavigatorCanAppend: Boolean;
    function NavigatorCanDelete: Boolean;
    function NavigatorCanEdit: Boolean;
    function NavigatorCanInsert: Boolean;
    function NavigatorIsActive: Boolean;
    function NavigatorIsBof: Boolean;
    function NavigatorIsBookmarkAvailable: Boolean;
    function NavigatorIsEditing: Boolean;
    function NavigatorIsEof: Boolean;
    procedure NavigatorClearBookmark;
    procedure NavigatorDoAction(AButtonIndex: Integer);
    function NavigatorGetNotifier: TcxNavigatorControlNotifier;
    function NavigatorIsActionSupported(AButtonIndex: Integer): Boolean;
    procedure RefreshNavigators;
    procedure CreateSubClasses; override;
    procedure DestroySubClasses; override;
    function CanBandSizing: Boolean; override;
    procedure ControlUpdateData(AInfo: TcxUpdateControlInfo); override;
    procedure DoFilterDialog; virtual;
    procedure DoFocusedRecordChanged(APrevFocusedRecord, AFocusedRecord: Integer); virtual;
    function GetCellAutoHeight: Boolean; override;
    function GetControllerClass: TcxCustomControlControllerClass; override;
    function GetOptionsBehaviorClass: TcxControlOptionsBehaviorClass; override;
    function GetOptionsDataClass: TcxControlOptionsDataClass; override;
    function GetOptionsViewClass: TcxControlOptionsViewClass; override;
    function GetScrollStrategyClass: TcxvgCustomScrollStrategyClass; override;
    function GetViewInfoClass: TcxCustomControlViewInfoClass; override;
    procedure InitDataController; override;
    procedure DataLayoutChanged; override;
    property Controller: TcxvgMultiRecordsController read GetController;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    property Customizing;
    property DataController;
    property LeftVisibleRecord;
    property FocusedRecordIndex: Integer read GetFocusedRecordIndex write SetFocusedRecordIndex;
    property RecordCount;
  published
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property LayoutStyle: TcxvgLayoutStyle read FLayoutStyle write SetLayoutStyle default lsSingleRecordView;
    property LookAndFeel;
    //before OptionsBehavior
    property OptionsView: TcxvgMultiRecordsOptionsView read GetOptionsView write SetOptionsView;
    property OptionsBehavior: TcxvgMultiRecordsOptionsBehavior read GetOptionsBehavior write SetOptionsBehavior;
    property OptionsData: TcxvgMultiRecordsOptionsData read GetOptionsData write SetOptionsData;
    property ParentFont;
    property PopupMenu;
    property Styles;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    property OnCustomizationFormVisibleChanged;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawBackground;
    property OnDrawRowHeader;
    property OnDrawValue;
    property OnEdited;
    property OnEditing;
    property OnEditValueChanged;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnFilterControlDialogShow: TNotifyEvent
      read FOnFilterControlDialogShow write FOnFilterControlDialogShow;
    property OnFilterRecord: TcxDataFilterRecordEvent
      read GetFilterRecordEvent write SetFilterRecordEvent;
    property OnFocusedRecordChanged: TcxVerticalGridFocusedRecordChangedEvent
      read FOnFocusedRecordChanged write FOnFocusedRecordChanged;
    property OnInitEdit;
    property OnItemChanged;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLayoutChanged;
    property OnLeftVisibleBandIndexChanged;
    property OnLeftVisibleRecordIndexChanged;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnTopRowIndexChanged;
  end;

  { TcxRowValueInfo }

  TcxRowValueInfo = class(TcxEditCellViewInfo)
  private
    FFocusRect: TRect;
    FRow: TcxCustomRow;
    FRowCellIndex: Integer;
    FRecordIndex: Integer;
    function GetEditorRowProperties: TcxCustomEditorRowProperties;
  protected
    procedure DoCalculate; override;
    function EditContainer: TcxCellEdit;
    function GetButtonTransparency: TcxEditButtonTransparency; override;
    function GetDisplayValue: Variant; override;
    function GetEditViewParams: TcxViewParams; override;
    function GetFocused: Boolean; override;
    function GetRecordIndex: Integer; override;
    function GetSelectedTextColor: Integer; override;
    function GetSelectedBKColor: Integer; override;
    function IncSearchParams: TcxViewParams;
    function IsAutoHeight: Boolean; override;

    property EditorRowProperties: TcxCustomEditorRowProperties read GetEditorRowProperties;
  public
    function GetHeight(AContentWidth: Integer): Integer;

    property Focused;
    property FocusRect: TRect read FFocusRect write FFocusRect;
    property Row: TcxCustomRow read FRow;
    property RowCellIndex: Integer read FRowCellIndex;
    property ViewParams;
  end;

  { TcxRowCaptionInfo }

  TcxRowCaptionInfo = class(TPersistent, IUnknown, IcxHotTrackElement)
  private
    FCaption: string;
    FCaptionRect: TRect;
    FCaptionTextRect: TRect;
    FFocused: Boolean;
    FImageIndex: Integer;
    FImageRect: TRect;
    FImages: TCustomImageList;
    FRow: TcxCustomRow;
    FRowCellIndex: Integer;
    FViewParams: TcxViewParams;
    FTextFlags: Integer;
    function FindPropertiesHint(const P: TPoint): string;
  protected
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxHotTrackElement
    function GetHintBounds: TRect; virtual;
    function IsNeedHint(ACanvas: TcxCanvas; const P: TPoint;
      out AText: TCaption;
      out AIsMultiLine: Boolean;
      out ATextRect: TRect; var IsNeedOffsetHint: Boolean): Boolean; virtual;
    procedure UpdateHotTrackState(const APoint: TPoint);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;

    property Caption: string read FCaption write FCaption;
    property CaptionRect: TRect read FCaptionRect;
    property CaptionTextRect: TRect read FCaptionTextRect;
    property Focused: Boolean read FFocused;
    property ImageIndex: Integer read FImageIndex;
    property ImageRect: TRect read FImageRect;
    property Images: TCustomImageList read FImages;
    property Row: TcxCustomRow read FRow;
    property RowCellIndex: Integer read FRowCellIndex write FRowCellIndex;
    property ViewParams: TcxViewParams read FViewParams;
    property TextFlags: Integer read FTextFlags;
  end;

  { TcxCaptionInfoList }

  TcxCaptionInfoList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TcxRowCaptionInfo;
  public
    property Items[Index: Integer]: TcxRowCaptionInfo read GetItem; default;
  end;

  { TcxValueInfoList }

  TcxValueInfoList = class(TcxObjectList)
  private
    FViewInfo: TcxvgCustomViewInfo;
    function GetItem(Index: Integer): TcxRowValueInfo;
  public
    constructor Create(AViewInfo: TcxvgCustomViewInfo);
    destructor Destroy; override;

    property Items[Index: Integer]: TcxRowValueInfo read GetItem; default;
    property ViewInfo: TcxvgCustomViewInfo read FViewInfo;
  end;

  { TcxCustomRowHeaderInfo }

  TcxCustomRowHeaderInfo = class
  private
    FCaptionsInfo: TcxCaptionInfoList;
    FCategoryIndents: TIndentInfoList;
    FFocusRect: TRect;
    FLinesInfo: TLineInfoList;
    FRowIndents: TIndentInfoList;
    FTransparent: Boolean;
    FViewInfo: TcxvgCustomViewInfo;
    function GetPaintStyle: TcxvgPaintStyle;
    function GetSelected: Boolean;
    function GetShowButton: Boolean;
    function GetVerticalGrid: TcxCustomVerticalGrid;
  protected
    FButtonRect: TRect;
    FButtonColor: TColor;
    FFocused: Boolean;
    FHeaderCellsRect: TRect;
    FHeaderRect: TRect;
    FIndentBounds: TRect;
    FIndentViewParams: TcxViewParams;
    FRow: TcxCustomRow;
    FViewParams: TcxViewParams;
    procedure AddBottomHorzLine(const R: TRect); virtual;
    procedure AddBoundHeaderLines; virtual;
    procedure AddNextIndentInfo(const ABounds: TRect;
      const AViewParams: TcxViewParams;
      AToCategories, AUnderline, AAddVertLine: Boolean);
    procedure AddRightVertLine(const R: TRect); virtual;
    procedure Calc(const AHeaderRect: TRect; AViewInfo: TcxvgCustomViewInfo;
      ANextRow: TcxCustomRow; ACalcBounds: Boolean);
    function CalcCaptionInfo(ARowProperties: TcxCaptionRowProperties;
      const R: TRect): TcxRowCaptionInfo;
    procedure CalcIndentBounds(ANextRow: TcxCustomRow; ACalculate: Boolean); virtual;
    function CalcIndentsInfo(ALevelCount: Integer;
      ANextRow: TcxCustomRow): TIndentRectInfoList; virtual;
    procedure CalcExpandButton;
    procedure CalcRowCaptionsInfo; virtual;
    procedure CalcViewParams(AAllowFocus: Boolean); virtual;
    procedure Clear; virtual;
    procedure DoCalcExpandButton; virtual;
    function GetButtonPlaceBackgroundWidth: Integer; virtual;
    function GetCaptionViewParams: TcxViewParams; virtual;
    function GetButtonColor: TColor; virtual;
    function GetFocusRect: TRect; virtual;
    function GetTopCentralPoint(AHeight: Integer; const R: TRect): Integer;
    function IncreaseBoundsByLastVertLine: Boolean; virtual;
    function LeftViewPoint: Integer; virtual;
    property IndentViewParams: TcxViewParams read FIndentViewParams;
    property PaintStyle: TcxvgPaintStyle read GetPaintStyle;
    property Selected: Boolean read GetSelected;
    property VerticalGrid: TcxCustomVerticalGrid read GetVerticalGrid;
    property ViewInfo: TcxvgCustomViewInfo read FViewInfo;
  public
    constructor Create(ARow: TcxCustomRow); virtual;
    destructor Destroy; override;
    property CaptionsInfo: TcxCaptionInfoList read FCaptionsInfo;
    property CategoryIndents: TIndentInfoList read FCategoryIndents;
    property ButtonRect: TRect read FButtonRect;
    property ButtonColor: TColor read FButtonColor;
    property Focused: Boolean read FFocused;
    property FocusRect: TRect read FFocusRect write FFocusRect;
    property HeaderCellsRect: TRect read FHeaderCellsRect;
    property HeaderRect: TRect read FHeaderRect write FHeaderRect;
    property IndentBounds: TRect read FIndentBounds;
    property LinesInfo: TLineInfoList read FLinesInfo;
    property Row: TcxCustomRow read FRow;
    property RowIndents: TIndentInfoList read FRowIndents;
    property ShowButton: Boolean read GetShowButton;
    property Transparent: Boolean read FTransparent write FTransparent;
    property ViewParams: TcxViewParams read FViewParams write FViewParams;
  end;

  { TcxCustomRowViewInfo }

  TcxCustomRowViewInfo = class
  private
    FBandIndex: Integer;
    FBandRowIndex: Integer;
    FCalculatedHeight: Integer;
    FHeaderInfo: TcxCustomRowHeaderInfo;
    FInitialized: Boolean;
    FRow: TcxCustomRow;
    FRowRect: TRect;
    FValuesInfo: TcxValueInfoList;
    FValuesRect: TRect;
    function GetCalculatedHeight: Integer;
    function GetRowValueInfo(ARecordIndex, ACellIndex: Integer): TcxRowValueInfo;
    function GetVerticalGrid: TcxCustomVerticalGrid;
    function GetViewInfo: TcxvgCustomViewInfo;
  protected
    procedure AddRectValueLines(R: TRect; ALast, ABottomLineNeeded: Boolean);
    function AddValueInfo(ARecordIndex, ACellIndex: Integer): TcxRowValueInfo;
    procedure CalculateHeight(ABandWidth: Integer); virtual;
    procedure CalcValuesInfo; virtual; abstract;
    procedure CalcRowHeaderInfo(ANextRow: TcxCustomRow); virtual;
    procedure CalcPaintViewParamsLines(ANextRow: TcxCustomRow); virtual;
    procedure ClearValuesInfo;
    function GetEditContainerCount: Integer;
    function GetRowValueInfoClass: TcxRowValueInfoClass; virtual;
    function GetValuesHeight(ABandWidth: Integer; AViewInfo: TcxvgCustomViewInfo): Integer; virtual;
    procedure InitValuesInfo;

    property ValuesInfo: TcxValueInfoList read FValuesInfo;
    property ViewInfo: TcxvgCustomViewInfo read GetViewInfo;
  public
    constructor Create(ARow: TcxCustomRow); virtual;
    destructor Destroy; override;
    procedure Calc(const ARowRect: TRect; AViewInfo: TcxvgCustomViewInfo; ANextRow: TcxCustomRow);
    procedure Update;
    procedure UpdateRecord(ARecordIndex: Integer);

    property BandIndex: Integer read FBandIndex write FBandIndex;
    property BandRowIndex: Integer read FBandRowIndex write FBandRowIndex;
    property CalculatedHeight: Integer read GetCalculatedHeight write FCalculatedHeight;
    property HeaderInfo: TcxCustomRowHeaderInfo read FHeaderInfo;
    property Row: TcxCustomRow read FRow;
    property RowRect: TRect read FRowRect;
    property RowValueInfo[ARecordIndex, ACellIndex: Integer]: TcxRowValueInfo read GetRowValueInfo;
    property ValuesRect: TRect read FValuesRect write FValuesRect;
    property VerticalGrid: TcxCustomVerticalGrid read GetVerticalGrid;
  end;

  { TcxRowViewInfoList }

  TcxRowViewInfoList = class(TList)
  private
    function GetItem(Index: Integer): TcxCustomRowViewInfo;
  public
    constructor Create;
    function Find(ARow: TcxCustomRow): TcxCustomRowViewInfo;
    property Items[Index: Integer]: TcxCustomRowViewInfo read GetItem; default;
  end;

  { TcxvgCustomViewInfo }

  TcxvgCustomViewInfo = class(TcxCustomControlViewInfo)
  private
    FBandBorderColor: TColor;
    FBandMinWidth: Integer;
    FBandsInterval: Integer;
    FButtonSize: Integer;
    FCalcHelper: TcxvgCustomPaintStyleCalcHelper;
    FClipRect: TRect;
    FDividerWidth: Integer;
    FExplorerButtonSize: TSize;
    FUseCategoryExplorerStyle: Boolean;
    FFocusLinesInfo: TLineInfoList;
    FFullHeaderWidth: Integer;
    FHorzLineBrush: TBrush;
    FHorzLineWidth: Integer;
    FImageSize: TSize;
    FLevelWidth: Integer;
    FLinesInfo: TLineInfoList;
    FLockDividerPos: Boolean;
    FRowHeaderMinWidth: Integer;
    FRowIndentWidth: Integer;
    FRowMinHeight: Integer;
    FRowsViewInfo: TcxRowViewInfoList;
    FShowHeaders: Boolean;
    FVerticalGrid: TcxCustomVerticalGrid;
    FVertLineBrush: TBrush;
    FVertLineWidth: Integer;
    FViewBandWidth: Integer;
    FViewHeaderWidth: Integer;
    FViewValueWidth: Integer;
    FViewRects: TViewRects;
    procedure ClearLinesAndRows;
    function GetBandInfo: TBandInfoList;
    function GetFirstVisibleRecordIndex: Integer;
    function GetMinRowHeight: Integer;
    function GetPainter: TcxvgPainter;
    function GetScroller: TcxvgScroller;
    function GetVisibleRow(Index: Integer): TcxCustomRow;
    function GetVisibleRowCount: Integer;
    procedure UpdateScroller;
    function GetMaxVisibleLevel: Integer;
  protected
    // overriding methods
    function CalculateDefaultEditHeight: Integer; override;
    procedure DoCalculate; override;
    procedure UpdateSelection; override;
    //
    procedure AddBandRowsLines(const R: TRect); virtual;
    procedure AddBottomValueSide(const R: TRect);
    procedure AddEmptyRects; virtual; abstract;
    procedure AddRightValueSide(const R: TRect; ALast: Boolean); virtual;
    procedure CalcBandRects; virtual;
    procedure CalcBandRowsViewInfo(var AFirstRowIndex: Integer;
      const ABandRect: TRect; ABandIndex, ABandRowCount: Integer); virtual;
    procedure CalcBandWidth; virtual;
    procedure CalculateBandsInfo; virtual;
    procedure CalcEmpty; virtual;
    procedure CalcCategoryExplorerStyle;
    procedure CalcLayoutGeneral; virtual;
    procedure CalcRowsHeight;
    procedure CalcRowRects(ARowViewInfo: TcxCustomRowViewInfo); virtual;
    procedure CalcRowsViewInfo; virtual;
    procedure CalcViewRects; virtual;
    function CanAddRowToBand(const ARowRect, ABandRect: TRect; ABandRowIndex: Integer): Boolean; virtual;
    procedure CheckMaxRowHeaderWidth(var Value: Integer; AValueMinWidth: Integer); virtual;
    procedure CheckRowHeaderWidth;
    function CheckShowRowHeader(ARowViewInfo: TcxCustomRowViewInfo): Boolean;
    procedure Clear; virtual;
    procedure ClearValuesInfo;
    procedure CreateBand(ABandHeight, ABandWidth: Integer); virtual;
    procedure CreateBrushes; virtual;
    function CreateCalcHelper: TcxvgCustomPaintStyleCalcHelper; virtual;
    procedure DestroyBrushes; virtual;
    function GetBandSizeableRect(const ABandRect: TRect): TRect; virtual;
    function GetRowAutoHeight(ARow: TcxCustomRow): Boolean; virtual;

    function GetViewBandWidth: Integer; virtual;
    function GetViewHeaderWidth: Integer; virtual;
    function GetViewMinHeaderWidth: Integer; virtual;
    function GetViewValueWidth: Integer; virtual;
    function GetVisibleValueCount: Integer; virtual; abstract;
    procedure LayoutStyleChanged;
    procedure PrepareCalculateBandsInfo;
    procedure Reset; virtual;
    function ScaleRowRects(ARowViewInfo: TcxCustomRowViewInfo): TRectScaler; virtual;
    procedure SetDividerPos(APos: Integer); virtual;
    procedure SetValueWidth(AWidth: Integer); virtual;

    property Scroller: TcxvgScroller read GetScroller;
    property LockDividerPos: Boolean read FLockDividerPos;
    property MaxVisibleLevel: Integer read GetMaxVisibleLevel;
    property ViewBandWidth: Integer read FViewBandWidth write FViewBandWidth;
    property ViewHeaderWidth: Integer read FViewHeaderWidth write FViewHeaderWidth;
  public
    constructor Create(AOwner: TcxEditingControl); override;
    destructor Destroy; override;
    procedure CalcEditCell(const ABounds: TRect; ARowValueInfo: TcxRowValueInfo); virtual;
    function CalcRowHeight(ARow: TcxCustomRow): Integer;
    procedure ChangeFocusedRow(ANewFocus, AOldFocus: TcxCustomRow); virtual;
    function GetDefaultGridModeBufferCount: Integer; virtual;
    function GetRowViewInfo(ARow: TcxCustomRow): TcxCustomRowViewInfo;
    function GetValueRect(AValueIndex: Integer;
      ARowViewInfo: TcxCustomRowViewInfo): TRect; virtual;
    function GetValuesRect(ARowViewInfo: TcxCustomRowViewInfo): TRect; virtual;
    procedure UpdateRecord(ARecordIndex: Integer); virtual;
    // properties
    property BandBorderColor: TColor read FBandBorderColor write FBandBorderColor;
    property BandMinWidth: Integer read FBandMinWidth;
    property BandInfo: TBandInfoList read GetBandInfo;
    property BandsInterval: Integer read FBandsInterval;
    property ButtonSize: Integer read FButtonSize write FButtonSize;
    property CalcHelper: TcxvgCustomPaintStyleCalcHelper read FCalcHelper;
    property ClipRect: TRect read FClipRect;
    property DividerWidth: Integer read FDividerWidth write FDividerWidth;
    property ExplorerButtonSize: TSize read FExplorerButtonSize;
    property UseCategoryExplorerStyle: Boolean read FUseCategoryExplorerStyle;
    property FirstVisibleRecordIndex: Integer read GetFirstVisibleRecordIndex;
    property FocusLinesInfo: TLineInfoList read FFocusLinesInfo;
    property FullHeaderWidth: Integer read FFullHeaderWidth;
    property HorzLineBrush: TBrush read FHorzLineBrush write FHorzLineBrush;
    property HorzLineWidth: Integer read FHorzLineWidth;
    property ImageSize: TSize read FImageSize write FImageSize;
    property LevelWidth: Integer read FLevelWidth write FLevelWidth;
    property LinesInfo: TLineInfoList read FLinesInfo write FLinesInfo;
    property Painter: TcxvgPainter read GetPainter;
    property RowHeaderMinWidth: Integer read FRowHeaderMinWidth;
    property RowIndentWidth: Integer read FRowIndentWidth;
    property RowsViewInfo: TcxRowViewInfoList read FRowsViewInfo;
    property ShowHeaders: Boolean read FShowHeaders;
    property VerticalGrid: TcxCustomVerticalGrid read FVerticalGrid;
    property VertLineBrush: TBrush read FVertLineBrush write FVertLineBrush;
    property VertLineWidth: Integer read FVertLineWidth write FVertLineWidth;
    property ViewRects: TViewRects read FViewRects;
    property ViewValueWidth: Integer read FViewValueWidth write FViewValueWidth;
    property VisibleRows[Index: Integer]: TcxCustomRow read GetVisibleRow;
    property VisibleRowCount: Integer read GetVisibleRowCount;
    property VisibleValueCount: Integer read GetVisibleValueCount;
  end;

  { TcxvgCustomPaintStyleCalcHelper }

  TcxvgCustomPaintStyleCalcHelper = class
  private
    FScroller: TcxvgScroller;
    FViewInfo: TcxvgCustomViewInfo;
    FVerticalGrid: TcxCustomVerticalGrid;
  protected
    function CreateHorzLineBrush: TBrush; virtual; abstract;
    function CreateVertLineBrush: TBrush; virtual; abstract;
    function GetBandBorderColor: TColor; virtual;
    function GetDividerWidth: Integer; virtual; abstract;
    function GetIndentWidth: Integer; virtual; abstract;
  public
    constructor Create(AViewInfo: TcxvgCustomViewInfo); virtual;
    procedure AddBoundHeaderLines(ARowHeaderInfo: TcxCustomRowHeaderInfo); virtual; abstract;
    procedure AddDivider(ALinesInfo: TLineInfoList; const R: TRect;
      AColor: TColor; AIsSeparator: Boolean); virtual; abstract;
    procedure AddHeaderIndentLines(ARowHeaderInfo: TcxCustomRowHeaderInfo;
      const R: TRect; const AViewParams: TcxViewParams;
      AToCategories, AUnderline, AAddVertLine: Boolean); virtual; abstract;
    procedure CalcPaintViewParamsLines(ARowViewInfo: TcxCustomRowViewInfo;
      ANextRow: TcxCustomRow); virtual; abstract;
    function ChangeFocusedRow(ANewFocus, AOldFocus: TcxCustomRow): TRect; virtual; abstract;
    function GetBackgroundColor: TColor; virtual;
    function GetCategoryColor: TColor; virtual; abstract;
    function GetCategoryFocusRect(ARowHeaderInfo: TcxCustomRowHeaderInfo): TRect; virtual; abstract;
    function GetCategoryTextColor: TColor; virtual; abstract;
    function GetContentColor(AFocused: Boolean): TColor; virtual; abstract;
    function GetContentTextColor: TColor; virtual; abstract;
    function GetHeaderColor: TColor; virtual; abstract;
    function GetHeaderTextColor: TColor; virtual; abstract;
    function GetIndentViewParams(ARow, AParentIndentRow: TcxCustomRow): TcxViewParams; virtual; abstract;
    function IsBottomLineNeeded(ANextRow: TcxCustomRow): Boolean; virtual;
    function IsDrawValueFocusRect: Boolean; virtual; abstract;

    property Scroller: TcxvgScroller read FScroller;
    property ViewInfo: TcxvgCustomViewInfo read FViewInfo;
    property VerticalGrid: TcxCustomVerticalGrid read FVerticalGrid;
  end;

  { TcxvgDotNetStyleCalcHelper }

  TcxvgDotNetStyleCalcHelper = class(TcxvgCustomPaintStyleCalcHelper)
  protected
    function CreateHorzLineBrush: TBrush; override;
    function CreateVertLineBrush: TBrush; override;
    function GetDividerWidth: Integer; override;
    function GetIndentWidth: Integer; override;
  public
    procedure AddBoundHeaderLines(ARowHeaderInfo: TcxCustomRowHeaderInfo); override;
    procedure AddDivider(ALinesInfo: TLineInfoList; const R: TRect;
      AColor: TColor; AIsSeparator: Boolean); override;
    procedure AddHeaderIndentLines(ARowHeaderInfo: TcxCustomRowHeaderInfo;
      const R: TRect; const AViewParams: TcxViewParams;
      AToCategories, AUnderline, AAddVertLine: Boolean); override;
    procedure CalcPaintViewParamsLines(ARowViewInfo: TcxCustomRowViewInfo;
      ANextRow: TcxCustomRow); override;
    function ChangeFocusedRow(ANewFocus, AOldFocus: TcxCustomRow): TRect; override;
    function GetCategoryColor: TColor; override;
    function GetCategoryFocusRect(ARowHeaderInfo: TcxCustomRowHeaderInfo): TRect; override;
    function GetCategoryTextColor: TColor; override;
    function GetContentColor(AFocused: Boolean): TColor; override;
    function GetContentTextColor: TColor; override;
    function GetHeaderColor: TColor; override;
    function GetHeaderTextColor: TColor; override;
    function GetIndentViewParams(ARow, AParentIndentRow: TcxCustomRow): TcxViewParams; override;
    function IsDrawValueFocusRect: Boolean; override;
  end;

  { TcxvgStyle3DCalcHelper }

	TcxvgStyle3DCalcHelper = class(TcxvgCustomPaintStyleCalcHelper)
  protected
    function CreateHorzLineBrush: TBrush; override;
    function CreateVertLineBrush: TBrush; override;
    function GetDividerWidth: Integer; override;
    function GetIndentWidth: Integer; override;
  public
    procedure AddBoundHeaderLines(ARowHeaderInfo: TcxCustomRowHeaderInfo); override;
    procedure AddHeaderIndentLines(ARowHeaderInfo: TcxCustomRowHeaderInfo;
      const R: TRect; const AViewParams: TcxViewParams;
      AToCategories, AUnderline, AAddVertLine: Boolean); override;
    procedure AddDivider(ALinesInfo: TLineInfoList;
      const R: TRect; AColor: TColor; AIsSeparator: Boolean); override;
    procedure CalcPaintViewParamsLines(ARowViewInfo: TcxCustomRowViewInfo;
      ANextRow: TcxCustomRow); override;
    function ChangeFocusedRow(ANewFocus, AOldFocus: TcxCustomRow): TRect; override;
    function GetCategoryColor: TColor; override;
    function GetCategoryFocusRect(ARowHeaderInfo: TcxCustomRowHeaderInfo): TRect; override;
    function GetCategoryTextColor: TColor; override;
    function GetContentColor(AFocused: Boolean): TColor; override;
    function GetContentTextColor: TColor; override;
    function GetHeaderColor: TColor; override;
    function GetHeaderTextColor: TColor; override;
    function GetIndentViewParams(ARow, AParentIndentRow: TcxCustomRow): TcxViewParams; override;
    function IsDrawValueFocusRect: Boolean; override;
  end;

  { TcxvgStyle3DCalcHelper }

	TcxvgSkinCalcHelper = class(TcxvgDotNetStyleCalcHelper)
  protected
    function CreateHorzLineBrush: TBrush; override;
    function CreateVertLineBrush: TBrush; override;
    function GetBandBorderColor: TColor; override;
  public
    procedure AddBoundHeaderLines(ARowHeaderInfo: TcxCustomRowHeaderInfo); override;
    procedure AddHeaderIndentLines(ARowHeaderInfo: TcxCustomRowHeaderInfo;
      const R: TRect; const AViewParams: TcxViewParams;
      AToCategories, AUnderline, AAddVertLine: Boolean); override;
    function GetBackgroundColor: TColor; override;
    function GetCategoryColor: TColor; override;
    function GetCategoryTextColor: TColor; override;
    function GetHeaderColor: TColor; override;
    function GetHeaderTextColor: TColor; override;
    function IsBottomLineNeeded(ANextRow: TcxCustomRow): Boolean; override;
  end;

  { TcxvgPainter }

  TcxvgPainter = class(TcxCustomControlPainter)
  private
    function GetViewInfo: TcxvgCustomViewInfo;
    function GetVerticalGrid: TcxCustomVerticalGrid;
  protected
    procedure DoPaint; override;
    procedure DrawRows;
    procedure DrawStyleFeatures; virtual;
  public
    constructor Create(AOwner: TcxEditingControl); override;
    procedure DrawBackground; virtual;
    procedure DrawButton(ARowHeader: TcxCustomRowHeaderInfo); virtual;
    procedure DrawCategoryRowHeader(ARowHeader: TcxCustomRowHeaderInfo); virtual;
    procedure DrawCategoryRowIndent(ARowHeader: TcxCustomRowHeaderInfo); virtual;
    procedure DrawHeaderDragImage(ARowHeader: TcxCustomRowHeaderInfo); virtual;
    procedure DrawHeaderSeparators(ARowHeader: TcxCustomRowHeaderInfo); virtual;
    procedure DrawImage(ACaptionInfo: TcxRowCaptionInfo); virtual;
    procedure DrawLines(ALinesInfo: TLineInfoList; R: TRect); virtual;
    procedure DrawRow(ARowViewInfo: TcxCustomRowViewInfo); virtual;
    procedure DrawRowHeader(ARowHeader: TcxCustomRowHeaderInfo); virtual;
    procedure DrawRowHeaderCell(ACaptionInfo: TcxRowCaptionInfo; ATransparent: Boolean); virtual;
    procedure DrawRowIndent(ARowHeader: TcxCustomRowHeaderInfo); virtual;
    procedure DrawRowValueCell(AValueInfo: TcxRowValueInfo); virtual;
    procedure DrawValuesSeparators(ARowViewInfo: TcxCustomRowViewInfo); virtual;
    procedure FillRect(const R: TRect; ABitmap: TBitmap = nil);

    property VerticalGrid: TcxCustomVerticalGrid read GetVerticalGrid;
    property ViewInfo: TcxvgCustomViewInfo read GetViewInfo;
  end;

  { TcxStyle3DPainter }

  TcxStyle3DPainter = class(TcxvgPainter)
  protected
    procedure DrawStyleFeatures; override;
  end;
  
  // STYLES
  PcxvgContentParamsData = ^TcxvgContentParamsData;
  TcxvgContentParamsData = record
    Row: TcxCustomRow;
    Focused: Boolean;
  end;

  TcxvgOnGetItemStyleEvent = procedure(Sender: TObject; ARow: TcxCustomRow;
    var AStyle: TcxStyle) of object;
  TcxvgOnGetContentStyleEvent = procedure(Sender: TObject;
    AEditProp: TcxCustomEditorRowProperties; AFocused: Boolean;
    ARecordIndex: Integer; var AStyle: TcxStyle) of object;

  { TcxvgCustomRowStyles }

  TcxvgCustomRowStyles = class(TcxStyles)
  protected
    procedure Changed(AIndex: Integer); override;
  end;

  { TcxCategoryRowStyles }

  TcxCategoryRowStyles = class(TcxvgCustomRowStyles)
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Header: TcxStyle index vgrs_Header read GetValue write SetValue;
  end;

  { TcxEditorRowStyles }

  TcxEditorRowStyles = class(TcxCategoryRowStyles)
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Content: TcxStyle index vgrs_Content read GetValue write SetValue;
    property Header;
  end;

  { TcxVerticalGridStyleSheet }

  TcxVerticalGridStyleSheet = class(TcxCustomStyleSheet)
  private
    function GetStylesValue: TcxVerticalGridStyles;
    procedure SetStylesValue(Value: TcxVerticalGridStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxVerticalGridStyles read GetStylesValue write SetStylesValue;
  end;

  { TcxVerticalGridStyles }

  TcxVerticalGridStyles = class(TcxCustomControlStyles)
  private
    FOnGetCategoryStyle: TcxvgOnGetItemStyleEvent;
    FOnGetHeaderStyle: TcxvgOnGetItemStyleEvent;
    FOnGetContentStyle: TcxvgOnGetContentStyleEvent;
    procedure CallInheritedDefaultViewParams(Index: Integer; AData: Pointer; out AParams: TcxViewParams);
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetStyleFromEvent(const AEvent: TcxvgOnGetItemStyleEvent; AItem: TcxCustomRow): TcxStyle;
  public
    procedure Assign(Source: TPersistent); override;
    function GetCategoryParams(ARow: TcxCustomRow): TcxViewParams; virtual;
    function GetContentParams(AEditProp: TcxCustomEditorRowProperties; AFocused: Boolean; ARecordIndex: Integer): TcxViewParams; virtual;
    function GetHeaderParams(ARow: TcxCustomRow): TcxViewParams; virtual;
    function GetIncSearchParams: TcxViewParams;
    function GetSelectedHeaderParams(ARow: TcxCustomRow): TcxViewParams;
  published
    property Category: TcxStyle index vgs_Category read GetValue write SetValue;
    property Header: TcxStyle index vgs_Header read GetValue write SetValue;
    property IncSearch: TcxStyle index vgs_IncSearch read GetValue write SetValue;
    property OnGetCategoryStyle: TcxvgOnGetItemStyleEvent read FOnGetCategoryStyle write FOnGetCategoryStyle;
    property OnGetHeaderStyle: TcxvgOnGetItemStyleEvent read FOnGetHeaderStyle write FOnGetHeaderStyle;
    property OnGetContentStyle: TcxvgOnGetContentStyleEvent read FOnGetContentStyle write FOnGetContentStyle;
    property Background;
    property Content;
    property Inactive;
    property Selection;
    property StyleSheet;
  end;

  { TcxVerticalGridItemsCustomizeListBox }

  TcxVerticalGridItemsCustomizeListBox = class(TcxCustomizeListBox)
  private
    FCanvas: TcxCanvas;
    FDragging: Boolean;
    FIsCategoryListBox: Boolean;
    FVerticalGrid: TcxCustomVerticalGrid;
    FDragAndDropItemIndex: Integer;
    FMouseDownPos: TPoint;
    FOffset: TPoint;
    function GetDragRow: TcxCustomRow;
    function GetPainter: TcxvgPainter;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMPaint(var Message: TMessage); message WM_PAINT;
  protected
    IsPaint: Boolean;
    procedure CalcHeaderViewInfo(const R: TRect; AHeaderInfo: TcxCustomRowHeaderInfo); virtual;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure InitDragAndDropObject; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure RefreshList;

    property Canvas: TcxCanvas read FCanvas;
    property DragRow: TcxCustomRow read GetDragRow;
    property VerticalGrid: TcxCustomVerticalGrid read FVerticalGrid;
    property Painter: TcxvgPainter read GetPainter;
  public
    constructor CreateEx(AOwner: TComponent; AVerticalGrid: TcxCustomVerticalGrid;
      IsCategoryListBox: Boolean);
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
  end;

  { TcxVerticalGridCustomizationForm }

  TcxVerticalGridCustomizationForm = class(TForm)
  private
    FOwner: TcxVerticalGridCustomizing;
    FHookTimer: TTimer;
    function GetVerticalGrid: TcxCustomVerticalGrid;
    procedure HookTimerHandler(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure DoShow; override;

    property Customizing: TcxVerticalGridCustomizing read FOwner;
    property VerticalGrid: TcxCustomVerticalGrid read GetVerticalGrid;
  public
    constructor CreateEx(AOwner: TcxVerticalGridCustomizing);
    destructor Destroy; override;
  end;

  { TcxVerticalGridCustomizing }

  TcxVerticalGridCustomizing = class(TcxOwnedInterfacedPersistent)
  private
    FCategoryListBox: TcxVerticalGridItemsCustomizeListBox;
    FForm: TcxVerticalGridCustomizationForm;
    FRowListBox: TcxVerticalGridItemsCustomizeListBox;
    FLastBandIndex: Integer;
    FLastHeaderIndex: Integer;
    FLastPosition: TPoint;
    FLineHeight: Integer;
    FPageControl: TPageControl;
    FPanel: TPanel;
    FButtonNew: TcxButton;
    FButtonDelete: TcxButton;
    FRowCount: Integer;
    FSaveDragMode: TDragMode;
    FShowCategoryButtons: Boolean;
    FShowCategoryTab: Boolean;
    FTabSheetCategories: TTabSheet;
    FTabSheetRows: TTabSheet;
    FVerticalGrid: TcxCustomVerticalGrid;
    FVisible: Boolean;
    procedure CreateCategoryClick(Sender: TObject);
    procedure DeleteCategoryClick(Sender: TObject);
    procedure SetRowCount(Value: Integer);
    procedure SetShowCategoryButtons(const Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure ShowCustomizingForm;
    procedure UpdateButtons(Sender: TObject);
  protected
    procedure AdjustControls; virtual;
    function CanDrop(const P: TPoint): Boolean; virtual;
    procedure CreateCategoryPanel;
    procedure CreateCategoryRow; virtual;
    procedure CreateControls; virtual;
    procedure CreateCustomizingForm;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); virtual;
    procedure FormShow(Sender: TObject); virtual;
    procedure LookAndFeelChanged; virtual;
    procedure ReleaseControls;
    procedure SetControlParent(AControl, AParent: TWinControl);
    function SizeDelta: TSize; virtual;
    procedure ValidateListBox(AListBox: TcxVerticalGridItemsCustomizeListBox; AIndex: Integer);
    procedure Update; virtual;
    // IcxVerticalGridDesigner
    procedure ComponentRemoved(Sender: TObject); virtual;
    procedure Modified; virtual;
    property CategoryListBox: TcxVerticalGridItemsCustomizeListBox read FCategoryListBox;
    property CustomizingPos: TPoint read FLastPosition write FLastPosition;
    property RowListBox: TcxVerticalGridItemsCustomizeListBox read FRowListBox;
    property VerticalGrid: TcxCustomVerticalGrid read FVerticalGrid;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure MakeCategorySheetVisible;
    procedure MakeRowSheetVisible;

    property Form: TcxVerticalGridCustomizationForm read FForm;
    property RowCount: Integer read FRowCount write SetRowCount default 10;
    property ShowCategoryButtons: Boolean read FShowCategoryButtons write SetShowCategoryButtons;
    property ShowCategoryTab: Boolean read FShowCategoryTab write FShowCategoryTab;
    property Visible: Boolean read FVisible write SetVisible;
  end;

function GetTextAligmentFlags(AProperties: TcxCaptionRowProperties): Integer; overload;
function GetTextAligmentFlags(AHorz: TAlignment; AVert: TcxAlignmentVert): Integer; overload;
procedure cxVerticalGridError(const Msg: string);

implementation

uses
  Variants, Types, dxUxTheme, dxThemeManager, dxThemeConsts,
  cxVGridConsts, cxVGridViewInfo, cxGeometry, cxVGridNewCategory,
  cxFilterControlDialog, cxDataUtils, cxEditUtils, cxDrawTextUtils, cxContainer,
  cxTextEdit, cxLibraryConsts;

{$R cxInsCur.res}

const
  cxvgScrollDelta = 32;

  // Cursors
  cxInspectorInsertCursor   = 'CXVG_INSERT';
  cxInspectorAddChildCursor = 'CXVG_ADDCHILD';
  cxInspectorAddCursor      = 'CXVG_ADD';
  cxInspectorHideCursor     = 'CXVG_HIDE';
  cxInspectorNoDragCursor   = 'CXVG_NODRAG';

  cxVerticalGridStoringVersion = 1;

type
  TControlAccess = class(TControl);
  TcxEditingControllerAccess = class(TcxEditingController);
  TcxHotTrackControllerAccess = class(TcxHotTrackController);

const
  HorzAlignment: array[TAlignment] of Integer = (CXTO_LEFT, CXTO_RIGHT, CXTO_CENTER_HORIZONTALLY);
  VertAlignment: array[TcxAlignmentVert] of Integer = (CXTO_TOP, CXTO_BOTTOM, CXTO_CENTER_VERTICALLY);

function GetTextAligmentFlags(AProperties: TcxCaptionRowProperties): Integer; overload;
begin
  Result := HorzAlignment[AProperties.HeaderAlignmentHorz] or
    VertAlignment[AProperties.HeaderAlignmentVert];
end;

function GetTextAligmentFlags(AHorz: TAlignment;
  AVert: TcxAlignmentVert): Integer; overload;
begin
  Result := HorzAlignment[AHorz] or VertAlignment[AVert];
end;

procedure cxVerticalGridError(const Msg: string);
begin
  raise EcxVerticalGridError.Create(Msg);
end;

{ TcxvgOptionsBehavior }

constructor TcxvgOptionsBehavior.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FBandSizing := True;
  FHeaderSizing := True;
  FRowTracking := True;
  CellHints := True;
end;

procedure TcxvgOptionsBehavior.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxvgOptionsBehavior then
    with TcxvgOptionsBehavior(Source) do
    begin
      Self.BandSizing := BandSizing;
      Self.HeaderSizing := HeaderSizing;
      Self.RowSizing := RowSizing;
      Self.RowTracking := RowTracking;
    end;
end;

procedure TcxvgOptionsBehavior.RestoreDefaults;
begin
  FAlwaysShowEditorAssigned := False;
end;

procedure TcxvgOptionsBehavior.InternalSetAlwaysShowEditor(Value: Boolean);
begin
  inherited AlwaysShowEditor := Value;
end;

function TcxvgOptionsBehavior.GetAlwaysShowEditor: Boolean;
begin
  if FAlwaysShowEditorAssigned then
    Result := inherited AlwaysShowEditor
  else
    Result := TcxCustomVerticalGrid(EditingControl).OptionsView.PaintStyle = psDelphi;
end;

procedure TcxvgOptionsBehavior.SetAlwaysShowEditor(Value: Boolean);
begin
  FAlwaysShowEditorAssigned := True;
  InternalSetAlwaysShowEditor(Value);
end;

{ TcxvgMultiRecordsOptionsBehavior }

constructor TcxvgMultiRecordsOptionsBehavior.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FallowChangeRecord := True;
end;

procedure TcxvgMultiRecordsOptionsBehavior.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxvgMultiRecordsOptionsBehavior then
    AllowChangeRecord := TcxvgMultiRecordsOptionsBehavior(Source).AllowChangeRecord;
end;

function TcxvgMultiRecordsOptionsBehavior.GetIncSearchItem: TcxCustomEditorRow;
var
  AItem: TcxCellEdit;
begin
  AItem := TcxCellEdit(inherited IncSearchItem);
  if AItem <> nil then
    Result := TcxCustomEditorRow(AItem.Row)
  else
    Result := nil;
end;

procedure TcxvgMultiRecordsOptionsBehavior.SetAllowChangeRecord(Value: Boolean);
begin
  if FAllowChangeRecord <> Value then
  begin
    FAllowChangeRecord := Value;
    EditingControl.LayoutChanged;
  end;
end;

procedure TcxvgMultiRecordsOptionsBehavior.SetIncSearchItem(
  Value: TcxCustomEditorRow);
begin
  if Value <> nil then
    inherited IncSearchItem := TcxCustomEditorRowProperties(Value.FProperties).EditContainer
  else
    inherited IncSearchItem := nil;
end;

{ TcxvgMultiRecordsOptionsData }

constructor TcxvgMultiRecordsOptionsData.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FAppending := True;
  FDeletingConfirmation := True;
  FDeleting := True;
  FInserting := True;
end;

procedure TcxvgMultiRecordsOptionsData.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxvgMultiRecordsOptionsData then
    with TcxvgMultiRecordsOptionsData(Source) do
    begin
      Self.Appending := Appending;
      Self.Deleting := Deleting;
      Self.DeletingConfirmation := DeletingConfirmation;
      Self.Inserting := Inserting;
    end;
end;

procedure TcxvgMultiRecordsOptionsData.Changed;
begin
  if EditingControl is TcxVirtualVerticalGrid then
    TcxVirtualVerticalGrid(EditingControl).RefreshNavigators;
end;

procedure TcxvgMultiRecordsOptionsData.SetAppending(Value: Boolean);
begin
  if FAppending <> Value then
  begin
    FAppending := Value;
    Changed;
  end;
end;

procedure TcxvgMultiRecordsOptionsData.SetDeleting(Value: Boolean);
begin
  if FDeleting <> Value then
  begin
    FDeleting := Value;
    Changed;
  end;
end;

procedure TcxvgMultiRecordsOptionsData.SetInserting(Value: Boolean);
begin
  if FInserting <> Value then
  begin
    FInserting := Value;
    Changed;
  end;
end;

{ TcxvgOptionsView }

constructor TcxvgOptionsView.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FAutoScaleBands := True;
  FGridLineColor := clBtnShadow;
  FBandsInterval := 2;
  FRowHeaderMinWidth := 24;
  FRowHeaderWidth := 100;
  FRowHeight := -1;
  FShowButtons := True;
  FShowHeaders := True;
  FGridLines := vglBoth;
  FValueMinWidth := 40;
  FValueWidth := 100;
end;

procedure TcxvgOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxvgOptionsView then
  begin
    VerticalGrid.BeginUpdate;
    try
      inherited Assign(Source);
      with TcxvgOptionsView(Source) do
      begin
        Self.PaintStyle := PaintStyle;
        Self.FGridLineColor := FGridLineColor;
        Self.FGridLineColorAssigned := FGridLineColorAssigned;
        Self.FRowHeaderMinWidth := RowHeaderMinWidth;
        Self.FRowHeight := FRowHeight;
        Self.FValueMinWidth := ValueMinWidth;
        Self.FValueWidth := ValueWidth;
        Self.FRowHeaderWidth := RowHeaderWidth;
        Self.BandsInterval := BandsInterval;
        Self.CategoryExplorerStyle := CategoryExplorerStyle;
        Self.ShowButtons := ShowButtons;
        Self.ShowEmptyRowImage := ShowEmptyRowImage;
        Self.ShowHeaders := ShowHeaders;
        Self.GridLines := GridLines;
        Self.AutoScaleBands := AutoScaleBands;
      end;
      VerticalGrid.ViewInfo.IsDirty := True;
    finally
      VerticalGrid.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxvgOptionsView.RestoreDefaults;
begin
  FGridLineColorAssigned := False;
  FRowHeight := -1;
  FBandsInterval := 2;
  Changed;
end;

procedure TcxvgOptionsView.Changed;
begin
  VerticalGrid.CheckGridModeBufferCount;
  inherited Changed;
end;

function TcxvgOptionsView.GetGridLineColor: TColor;
const
  Colors: array[TcxvgPaintStyle] of TColor = (clBtnFace, clBtnShadow);
begin
  if FGridLineColorAssigned then
    Result := FGridLineColor
  else
    Result := Colors[FPaintStyle];
end;

function TcxvgOptionsView.GetVerticalGrid: TcxCustomVerticalGrid;
begin
  Result := TcxCustomVerticalGrid(EditingControl);
end;

procedure TcxvgOptionsView.SetAutoScaleBands(Value: Boolean);
begin
  if FAutoScaleBands <> Value then
  begin
    FAutoScaleBands := Value;
    if Value then
      if VerticalGrid.Controller <> nil then
        VerticalGrid.Controller.Scroller.ScrollStrategy.SetTopVisibleRowIndex(0);
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetShowButtons(Value: Boolean);
begin
  if FShowButtons <> Value then
  begin
    FShowButtons := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetBandsInterval(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FBandsInterval <> Value then
  begin
    FBandsInterval := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetCategoryExplorerStyle(Value: Boolean);
begin
  if FCategoryExplorerStyle <> Value then
  begin
    FCategoryExplorerStyle := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetGridLineColor(Value: TColor);
begin
  FGridLineColorAssigned := True;
  FGridLineColor := Value;
  Changed;
end;

procedure TcxvgOptionsView.SetPaintStyle(Value: TcxvgPaintStyle);
begin
  if FPaintStyle <> Value then
  begin
    FPaintStyle := Value;
    VerticalGrid.PaintStyleChanged;
  end;
end;

procedure TcxvgOptionsView.SetRowHeaderMinWidth(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if FRowHeaderMinWidth <> Value then
  begin
    FRowHeaderMinWidth := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetRowHeaderWidth(Value: Integer);
begin
  if Value < FRowHeaderMinWidth then
    Value := FRowHeaderMinWidth;
  if FRowHeaderWidth <> Value then
  begin
    FRowHeaderWidth := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetRowHeight(Value: Integer);
begin
  if Value < -1 then
    Value := -1;
  if FRowHeight <> Value then
  begin
    FRowHeight := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetShowEmptyRowImage(Value: Boolean);
begin
  if FShowEmptyRowImage <> Value then
  begin
    FShowEmptyRowImage := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetShowHeaders(Value: Boolean);
begin
  if FShowHeaders <> Value then
  begin
    FShowHeaders := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetGridLines(Value: TcxvgGridLines);
begin
  if FGridLines <> Value then
  begin
    FGridLines := Value;
    Changed;
  end;
end;

procedure TcxvgOptionsView.SetValueMinWidth(Value: Integer);
begin
  Value := Max(cxvgMinValueWidth, Value);
  if FValueMinWidth <> Value then
  begin
    FValueMinWidth := Value;
    ValueWidth := ValueWidth;
  end;
end;

procedure TcxvgOptionsView.SetValueWidth(Value: Integer);
begin
  if Value < FValueMinWidth then
    Value := FValueMinWidth;
  if FValueWidth <> Value then
  begin
    FValueWidth := Value;
    Changed;
  end;
end;

{ TcxvgMultiRecordsOptionsView }

procedure TcxvgMultiRecordsOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxvgMultiRecordsOptionsView then
  begin
    EditingControl.BeginUpdate;
    try
      FRecordsInterval := TcxvgMultiRecordsOptionsView(Source).RecordsInterval;
      inherited Assign(Source);
    finally
      EditingControl.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxvgMultiRecordsOptionsView.RestoreDefaults;
begin
  FRecordsInterval := 0;
  inherited RestoreDefaults;
end;

procedure TcxvgMultiRecordsOptionsView.SetRecordsInterval(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FRecordsInterval <> Value then
  begin
    FRecordsInterval := Value;
    Changed;
  end;
end;

{ TcxCustomRowProperties }

constructor TcxCustomRowProperties.Create(Collection: TCollection);
begin
  if Collection <> nil then
    FRow := TcxEditorPropertiesCollection(Collection).Row;
  FCollection := Collection;
  CreateEx(FRow);
end;

constructor TcxCustomRowProperties.CreateEx(ARow: TcxCustomRow);
begin
  FRow := ARow;
  inherited Create(FCollection);
end;

procedure TcxCustomRowProperties.Changed;
begin
  if FCollection <> nil then
    inherited Changed(True)
  else
    if Row.Visible then Row.Changed;
end;

function TcxCustomRowProperties.GetOwner: TPersistent;
begin
  Result := FRow;
end;

{ TcxCaptionRowProperties }

constructor TcxCaptionRowProperties.CreateEx(ARow: TcxCustomRow);
begin
  inherited CreateEx(ARow);
  FHeaderAlignmentHorz := taLeftJustify;
  FHeaderAlignmentVert := vaTop;
  FImageIndex := -1;
end;

function TcxCaptionRowProperties.DefaultCaption: string;
begin
  Result := '';
end;

procedure TcxCaptionRowProperties.RestoreDefaults;
begin
  FIsCaptionAssigned := False;
  Row.Changed;
end;

function TcxCaptionRowProperties.GetCaption: TCaption;
begin
  if FIsCaptionAssigned then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TcxCaptionRowProperties.IsCaptionStored: Boolean;
begin
  Result := FIsCaptionAssigned and (FCaption <> DefaultCaption);
end;

procedure TcxCaptionRowProperties.SetCaption(
  const Value: TCaption);
begin
  if FIsCaptionAssigned and (Value = FCaption) then Exit;
  FCaption := Value;
  FIsCaptionAssigned := True;
  Changed;
end;

procedure TcxCaptionRowProperties.SetHeaderAlignmentHorz(
  const Value: TAlignment);
begin
  if HeaderAlignmentHorz <> Value then
  begin
    FHeaderAlignmentHorz := Value;
    Changed;
  end;
end;

procedure TcxCaptionRowProperties.SetHeaderAlignmentVert(
  const Value: TcxAlignmentVert);
begin
  if HeaderAlignmentVert <> Value then
  begin
    FHeaderAlignmentVert := Value;
    Changed;
  end;
end;

procedure TcxCaptionRowProperties.SetImageIndex(
  const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed;
  end;
end;

procedure TcxCaptionRowProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCaptionRowProperties then
  begin
    Row.OwnerRows.BeginUpdate;
    try
      with TcxCaptionRowProperties(Source) do
      begin
        Self.FCaption := FCaption;
        Self.FIsCaptionAssigned := FIsCaptionAssigned;
        Self.FImageIndex := FImageIndex;
        Self.FHeaderAlignmentHorz := FHeaderAlignmentHorz;
        Self.FHeaderAlignmentVert := FHeaderAlignmentVert;
        Self.FHint := FHint;
      end;
    finally
      Row.OwnerRows.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

{ TcxRowOptions }

constructor TcxRowOptions.Create(ARow: TcxCustomRow);
begin
  FRow := ARow;
  FCanAutoHeight := True;
  FCanMovedToCustomizationForm := True;
  FCanResized := True;
  FFocusing := True;
  FMoving := True;
  FShowExpandButton := True;
  FShowInCustomizationForm := True;
  FTabStop := True;
end;

procedure TcxRowOptions.Assign(Source: TPersistent);
begin
  if Source is TcxRowOptions then
    with TcxRowOptions(Source) do
    begin
      Self.FCanAutoHeight := CanAutoHeight;
      Self.FCanMovedToCustomizationForm := CanMovedToCustomizationForm;
      Self.FCanResized := CanResized;
      Self.FFocusing := Focusing;
      Self.FMoving := Moving;
      Self.FShowExpandButton := ShowExpandButton;
      Self.FShowInCustomizationForm := ShowInCustomizationForm;
      Self.FTabStop := TabStop;
      Self.Changed;
    end
    else
      inherited Assign(Source);
end;

procedure TcxRowOptions.RestoreDefaults;
begin
  FCanAutoHeight := True;
  FCanMovedToCustomizationForm := True;
  FCanResized := True;
  FFocusing := True;
  FMoving := True;
  FShowExpandButton := True;
  FShowInCustomizationForm := True;
  FTabStop := True;
  Changed;
end;

procedure TcxRowOptions.Changed;
begin
  FRow.Changed;
end;

procedure TcxRowOptions.SetCanAutoHeight(Value: Boolean);
begin
  if FCanAutoHeight <> Value then
  begin
    FCanAutoHeight := Value;
    Changed;
  end;
end;

procedure TcxRowOptions.SetFocusing(Value: Boolean);
begin
  if FFocusing <> Value then
  begin
    FFocusing := Value;
    Changed;
  end;
end;

procedure TcxRowOptions.SetShowExpandButton(Value: Boolean);
begin
  if FShowExpandButton <> Value then
  begin
    FShowExpandButton := Value;
    Changed;
  end;
end;

procedure TcxRowOptions.SetShowInCustomizationForm(Value: Boolean);
begin
  if FShowInCustomizationForm <> Value then
  begin
    FShowInCustomizationForm := Value;
    Changed;
  end;
end;

{ TcxRowList }

constructor TcxRowList.Create(AOwner: TcxCustomRow);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TcxRowList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if (Action in [lnAdded, lnDeleted]) and not (csDestroying in Owner.ComponentState) then
    UpdateIndexes;
end;

procedure TcxRowList.UpdateIndexes;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    TcxCustomRow(Items[I]).FIndex := I;
end;

{ TcxCustomRow }

constructor TcxCustomRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIndex := -1;
  FExpanded := True;
  FVisible := True;
  FHeight := -1;
  FStyles := GetStylesClass.Create(Self);
  FProperties := GetPropertiesClass.CreateEx(Self);
  FOptions := GetOptionsClass.Create(Self);
  FVisibleIndex := -1;
  FLoadedID := -1;
  FVersion := cxVerticalGridStoringVersion;
end;

destructor TcxCustomRow.Destroy;
begin
  VerticalGrid.RemoveRowFromVerticalGrid(Self);
  FreeAndNil(FViewInfo);
  FreeAndNil(FStyles);
  FreeAndNil(FProperties);
  FreeAndNil(FOptions);
  inherited Destroy;
end;

procedure TcxCustomRow.Assign(Source: TPersistent);
begin
  if Source is TcxCustomRow then
    with TcxCustomRow(Source) do
    begin
      Self.FHeight := FHeight; //need a direct assign
      Self.FVisible := FVisible;
      Self.FExpanded := FExpanded;
      Self.FProperties.Assign(FProperties);
      Self.Styles.Assign(Styles);
    end
  else
    inherited Assign(Source);
end;

function TcxCustomRow.GetParentComponent: TComponent;
begin
  if (FParent = nil) or ((FVersion > 0) and (csReading in ComponentState)) then
    Result := VerticalGrid
  else
    Result := FParent;
end;

function TcxCustomRow.HasParent: Boolean;
begin
  Result := True;
end;

procedure TcxCustomRow.Collapse(ARecurse: Boolean);
var
  I: Integer;
begin
  if HasChildren then
  begin
    OwnerRows.BeginUpdate;
    try
      FExpanded := False;
      if ARecurse then
        for I := 0 to Count - 1 do
          Rows[I].Collapse(ARecurse);
    finally
      OwnerRows.EndUpdate;
    end
  end
  else FExpanded := False;
end;

procedure TcxCustomRow.Expand(ARecurse: Boolean);
var
  I: Integer;
begin
  if HasChildren then
  begin
    OwnerRows.BeginUpdate;
    try
      FExpanded := True;
      if ARecurse then
        for I := 0 to Count - 1 do
          Rows[I].Expand(ARecurse);
    finally
      OwnerRows.EndUpdate;
    end;
  end
  else FExpanded := True;
end;

function TcxCustomRow.GetFirstVisibleChild: TcxCustomRow;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Rows[I].Visible then
    begin
      Result := Rows[I];
      break;
    end;
end;

function TcxCustomRow.GetLastVisibleChild: TcxCustomRow;
var
  I: Integer;
  ARow: TcxCustomRow;
begin
  Result := nil;
  for I := Count - 1 downto 0 do
  begin
    ARow := Rows[I];
    if ARow.Visible then
    begin
      if ARow.Expanded then ARow := ARow.GetLastVisibleChild;
      if ARow <> nil then Result := ARow else Result := Rows[I];
      break;
    end;
  end;
end;

function TcxCustomRow.HasChildren: Boolean;
begin
  Result := Count > 0;
end;

function TcxCustomRow.HasVisibleChildren: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Rows[I].Visible then
    begin
      Result := True;
      break;
    end;
end;

function TcxCustomRow.IndexOf(ARow: TcxCustomRow): Integer;
begin
  Result := -1;
  if FRows <> nil then Result := FRows.IndexOf(ARow);
end;

function TcxCustomRow.IsChild(ARow: TcxCustomRow): Boolean;
begin
  Result := (ARow <> nil) and ARow.IsParent(Self)
end;

function TcxCustomRow.IsFirst: Boolean;
begin
  Result := Index = 0;
end;

function TcxCustomRow.IsFirstVisible: Boolean;
begin
  Result := Self = FParent.GetFirstVisibleChild;
end;

function TcxCustomRow.IsLast: Boolean;
begin
  Result := Index = FParent.Count - 1;
end;

function TcxCustomRow.IsLastVisible: Boolean;
var
  I: Integer;
  ARow: TcxCustomRow;
begin
  Result := False;
  with FParent do
    for I := Count - 1 downto 0 do
    begin
      ARow := Rows[I];
      if ARow.Visible then
        if ARow = Self then
        begin
          Result := True;
          break;
        end
        else
          break
    end;
end;

function TcxCustomRow.IsRootLevel: Boolean;
begin
  Result := FParent = VerticalGrid.RootRow;
end;

function TcxCustomRow.IsParent(ARow: TcxCustomRow): Boolean;
begin
  Result := False;
  while ARow <> nil do
  begin
    if ARow.FParent = Self then
    begin
      Result := True;
      break;
    end;
    ARow := ARow.FParent;
  end;
end;

procedure TcxCustomRow.MakeVisible;
begin
  VerticalGrid.Controller.MakeRowVisible(Self);
end;

procedure TcxCustomRow.RestoreDefaults;
begin
  FHeight := -1;
  Options.RestoreDefaults; // indirect call the row's changed method
end;

function TcxCustomRow.GetObjectName: string;
begin
  if VerticalGrid.FNewLoadMode then
  begin
    Result := Name;
    if Result = '' then
      Result := IntToStr(FID);
  end
  else
    Result := IntToStr(FID);
end;

procedure TcxCustomRow.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Visible' then
    AValue := Visible
  else
    if AName = 'Height' then
      AValue := Height
    else
      if AName = 'Expanded' then
        AValue := Expanded
      else
        if AName = 'AParentID' then
        begin
          if VerticalGrid.FNewLoadMode then
            AValue := FParent.GetObjectName
          else
            AValue := FParent.ID;
        end
        else
          if AName = 'Index' then
            AValue := Index
          else
            AValue := Null;
end;

function TcxCustomRow.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  with AProperties do
  begin
    Add('AParentID');
    Add('Index');
    Add('Visible');
    Add('Height');
    Add('Expanded');
  end;
  Result := True;
end;

procedure TcxCustomRow.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Visible' then
    Visible := AValue
  else
    if AName = 'Height' then
      Height := AValue
    else
      if AName = 'Expanded' then
        Expanded := AValue
      else
        if AName = 'AParentID' then
        begin
          if VerticalGrid.FNewLoadMode then
            FLoadingParent := AValue
          else
            Parent := OwnerRows.FindRowByID(AValue);
        end
        else
          if AName = 'Index' then
            if VerticalGrid.FNewLoadMode then
              FLoadingIndex := AValue
            else
              Index := AValue;
end;

procedure TcxCustomRow.SetName(const NewName: TComponentName);
begin
  inherited SetName(NewName);
  if not (csLoading in ComponentState) then
    Changed;
end;

procedure TcxCustomRow.SetParentComponent(Value: TComponent);
begin
  if FParent <> nil then FParent.Remove(Self);
  if Value <> nil then
    if Value is TcxCustomVerticalGrid then
      TcxCustomVerticalGrid(Value).FRootRow.Add(Self)
    else
      if Value is TcxCustomRow then
        TcxCustomRow(Value).Add(Self);
end;

procedure TcxCustomRow.Add(ARow: TcxCustomRow);
begin
  Insert(GetCount, ARow);
end;

function TcxCustomRow.CanFocus: Boolean;
begin
  Result := Options.Focusing;
end;

procedure TcxCustomRow.Changed(ARebuild: Boolean = False);
begin
  if OwnerRows <> nil then
    OwnerRows.Changed(ARebuild);
end;

procedure TcxCustomRow.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ID', ReadID, WriteID, True);
  Filer.DefineProperty('ParentID', ReadLoadedParentID, WriteLoadedParentID, True);
  Filer.DefineProperty('Index', ReadLoadedIndex, WriteLoadedIndex, True);
  Filer.DefineProperty('Version', ReadVersion, WriteVersion, True);
end;

procedure TcxCustomRow.Delete(AIndex: Integer);
var
  ARow: TcxCustomRow;
begin
  if (AIndex < 0) or (FRows = nil) or (AIndex >= GetCount) then
    cxVerticalGridError(cxSvgIndexError);
  ARow := FRows[AIndex];
  FRows.Delete(AIndex);
  ARow.FParent := nil;
  ResetOwnerCount;
end;

function TcxCustomRow.GetDefaultHeight: Integer;
begin
  with VerticalGrid do
    Result := Max(OptionsView.RowHeight,
      cxTextHeight(Styles.GetHeaderParams(Self).Font) + cxTextOffset);
end;

function TcxCustomRow.GetEditContainer(ACellIndex: Integer): TcxCellEdit;
begin
  Result := nil;
end;

function TcxCustomRow.GetEditContainerCount: Integer;
begin
  Result := 0;
end;

function TcxCustomRow.GetPropertiesClass: TcxRowPropertiesClass;
begin
  Result := TcxCaptionRowProperties;
end;

function TcxCustomRow.GetRealHeight: Integer;
begin
  Result := Max(FHeight, GetDefaultHeight);
end;

function TcxCustomRow.GetOptionsClass: TcxRowOptionsClass;
begin
  Result := TcxRowOptions;
end;

function TcxCustomRow.GetStylesClass: TcxvgCustomRowStylesClass;
begin
  Result := TcxvgCustomRowStyles;
end;

procedure TcxCustomRow.Insert(AIndex: Integer; ARow: TcxCustomRow);
begin
  if FRows = nil then
    FRows := TcxRowList.Create(Self);
  ARow.FParent := Self;
  ARow.SetVerticalGrid(VerticalGrid);
  FRows.Insert(AIndex, ARow);
  ResetOwnerCount;
end;

function TcxCustomRow.IsHeightAssigned: Boolean;
begin
  Result := FHeight >= 0;
end;

procedure TcxCustomRow.Remove(ARow: TcxCustomRow);
begin
  Delete(IndexOf(ARow));
end;

procedure TcxCustomRow.RemoveAll;
begin
  while Count > 0 do Rows[0].Free;
  FreeAndNil(FRows);
  ResetOwnerCount;
end;

procedure TcxCustomRow.RemoveChildren;
begin
  if (FParent <> nil) then
  begin
    FParent.Remove(Self);
    FParent := nil;
  end;
  RemoveAll;
end;

procedure TcxCustomRow.ResetOwnerCount;
begin
  OwnerRows.FCount := -1;
end;

procedure TcxCustomRow.RestoreIndex;
begin
  Index := FLoadedIndex;
end;

procedure TcxCustomRow.RestoreParent;
begin
  Parent := OwnerRows.FindLoadedParent(FLoadedParentID);
end;

procedure TcxCustomRow.SetVerticalGrid(Value: TcxCustomVerticalGrid);
begin
  if FVerticalGrid <> Value then
  begin
    FVerticalGrid := Value;
    if Value <> nil then
      FID := Value.Rows.GetNextID;
  end;
end;

function TcxCustomRow.GetAbsoluteIndex: Integer;
begin
  Result := OwnerRows.IndexOf(Self);
end;

function TcxCustomRow.GetCount: Integer;
begin
  if FRows = nil then Result := 0 else Result := FRows.Count;
end;

function TcxCustomRow.GetFocused: Boolean;
begin
  Result := VerticalGrid.FocusedRow = Self;
end;

function TcxCustomRow.GetLevel: Integer;
var
  P: TcxCustomRow;
begin
  Result := 0;
  P := FParent;
  while (P <> nil) and (P <> VerticalGrid.RootRow) do
  begin
    P := P.FParent;
    Inc(Result);
  end;
end;

function TcxCustomRow.GetOwnerRows: TcxVerticalGridRows;
begin
  Result := FVerticalGrid.Rows;
end;

function TcxCustomRow.GetParent: TcxCustomRow;
begin
  if FParent = FVerticalGrid.FRootRow then
    Result := nil
  else
    Result := FParent;
end;

function TcxCustomRow.GetRow(Index: Integer): TcxCustomRow;
begin
  if FRows = nil then
    cxVerticalGridError(cxSvgIndexError);
  Result := FRows[Index];
end;

function TcxCustomRow.GetViewInfo: TcxCustomRowViewInfo;
begin
  if FViewInfo = nil then FViewInfo := CreateViewInfo;
  Result := FViewInfo;
end;

procedure TcxCustomRow.SetExpanded(Value: Boolean);
begin
  if FExpanded <> Value then
  begin
    FExpanded := Value;
    Changed(HasChildren);
  end;
end;

procedure TcxCustomRow.SetFocused(Value: Boolean);
begin
  if Value <> Focused then
    if Value then
      VerticalGrid.FocusedRow := Self
    else
      VerticalGrid.FocusedRow := nil;
end;

procedure TcxCustomRow.SetHeight(Value: Integer);
begin
  if Value < -1 then Value := -1;
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TcxCustomRow.SetIndex(Value: Integer);
var
  AIndex: Integer;
begin
  if (FParent <> nil) and (Value >= 0) and (Value < FParent.GetCount) then
  begin
    AIndex := Index;
    if Value <> AIndex then
    begin
      FParent.FRows.Move(AIndex, Value);
      FParent.FRows.UpdateIndexes;
      Changed(True);
    end;
  end;
end;

procedure TcxCustomRow.SetOptions(Value: TcxRowOptions);
begin
  FOptions.Assign(Value);
end;

procedure TcxCustomRow.SetParent(Value: TcxCustomRow);
begin
  if Value = Self then Exit;
  if Value = nil then
    Value := FVerticalGrid.FRootRow;
  if FParent <> Value then
  begin
    if FParent <> nil then
      FParent.Remove(Self);
    FParent := Value;
    FParent.Add(Self);
    Changed(True);
  end;
end;

procedure TcxCustomRow.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;

procedure TcxCustomRow.ReadID(Reader: TReader);
begin
  FLoadedID := Reader.ReadInteger;
end;

procedure TcxCustomRow.ReadLoadedIndex(Reader: TReader);
begin
  FLoadedIndex := Reader.ReadInteger;
end;

procedure TcxCustomRow.ReadLoadedParentID(Reader: TReader);
begin
  FLoadedParentID := Reader.ReadInteger;
end;

procedure TcxCustomRow.ReadVersion(Reader: TReader);
begin
  FVersion := Reader.ReadInteger;
end;

procedure TcxCustomRow.WriteID(Writer: TWriter);
begin
  Writer.WriteInteger(ID);
end;

procedure TcxCustomRow.WriteLoadedIndex(Writer: TWriter);
begin
  Writer.WriteInteger(Index);
end;

procedure TcxCustomRow.WriteLoadedParentID(Writer: TWriter);
var
  AParentID: Integer;
begin
  if Parent = nil then
    AParentID := -1
  else
    AParentID := Parent.ID;
  Writer.WriteInteger(AParentID);
end;

procedure TcxCustomRow.WriteVersion(Writer: TWriter);
begin
  Writer.WriteInteger(cxVerticalGridStoringVersion);
end;

{ TcxCategoryRow }

function TcxCategoryRow.CreateHeaderInfo: TcxCustomRowHeaderInfo;
begin
  Result := TcxCategoryRowHeaderInfo.Create(Self);
end;

function TcxCategoryRow.CreateViewInfo: TcxCustomRowViewInfo;
begin
  Result := TcxCategoryRowViewInfo.Create(Self);
end;

function TcxCategoryRow.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('Caption');
  Result := inherited GetStoredProperties(AProperties);
end;

procedure TcxCategoryRow.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  if AName = 'Caption' then
    AValue := Properties.Caption
  else
    inherited GetPropertyValue(AName, AValue);
end;

procedure TcxCategoryRow.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
  if (AName = 'Caption') and not VarIsEmpty(AValue) then
    Properties.Caption := AValue
  else
    inherited SetPropertyValue(AName, AValue);
end;

function TcxCategoryRow.GetDefaultHeight: Integer;
begin
  with VerticalGrid do
  begin
    Result := Max(OptionsView.RowHeight,
      cxTextHeight(Styles.GetCategoryParams(Self).Font) + cxTextOffset * 2);
  if ViewInfo.UseCategoryExplorerStyle and (LookAndFeel.SkinPainter = nil) then
    Result := Max(Result, ViewInfo.ExplorerButtonSize.cy + 2);
  end;
end;

function TcxCategoryRow.GetStylesClass: TcxvgCustomRowStylesClass;
begin
  Result := TcxCategoryRowStyles;
end;

function TcxCategoryRow.GetProperties: TcxCaptionRowProperties;
begin
  Result := TcxCaptionRowProperties(FProperties);
end;

function TcxCategoryRow.GetStyles: TcxCategoryRowStyles;
begin
  Result := TcxCategoryRowStyles(FStyles);
end;

procedure TcxCategoryRow.SetProperties(Value: TcxCaptionRowProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCategoryRow.SetStyles(Value: TcxCategoryRowStyles);
begin
  FStyles.Assign(Value);
  Changed;
end;

{ TcxCellEdit }

constructor TcxCellEdit.Create(AOwner: TComponent);
begin
  FRow := TcxCustomRow(AOwner);
  inherited Create(AOwner);
end;

procedure TcxCellEdit.Calculate(ACellViewInfo: TcxRowValueInfo);
begin
  FCalculating := True;
  try
    InitEditViewInfo(ACellViewInfo);
    CalculateEditViewInfo(ACellViewInfo.CellValue, ACellViewInfo, cxInvalidPoint);
  finally
    FCalculating := False;
  end;
end;

function TcxCellEdit.CanEdit: Boolean;
begin
  Result := CanFocus and
    TcxCustomVerticalGrid(EditingControl).OptionsData.Editing and
    TcxEditorRowPropertiesOptions(Options).Editing and
    (dceoShowEdit in DataController.EditOperations);
end;

function TcxCellEdit.CanFocus: Boolean;
begin
  Result := Row.Options.Focusing and inherited CanFocus;
end;

function TcxCellEdit.CanInitEditing: Boolean;
begin
  with TcxCustomVerticalGrid(EditingControl) do
  begin
    Result := inherited CanInitEditing and ((DragAndDropState = ddsNone) or
      ((DragMode <> dmAutomatic) or not HitTest.HitAtValue));
  end;
end;

function TcxCellEdit.CanTabStop: Boolean;
begin
  Result := Row.Options.TabStop and inherited CanTabStop;
end;

procedure TcxCellEdit.DoGetDisplayText(ARecordIndex: Integer; var AText: string);
begin
  EditRowProperties.DoGetDisplayTextEvent(ARecordIndex, AText);
end;

function TcxCellEdit.DoGetPropertiesFromEvent(AEvent: TcxGetEditPropertiesEvent;
  AData: Pointer; AProperties: TcxCustomEditProperties): TcxCustomEditProperties;
begin
  Result := AProperties;
  if Assigned(AEvent) then
  begin
    AEvent(FEditRowProperties, AData, Result);
    if Result = nil then
      Result := AProperties;
  end;
  InitProperties(Result);
end;

function TcxCellEdit.GetCurrentValue: Variant;
begin
  with DataController do
    if RowCount = 0 then
      Value := Null
    else
      Result := Values[FilteredRecordIndex[FocusedRowIndex], ItemIndex];
end;

function TcxCellEdit.GetDataBindingClass: TcxItemDataBindingClass;
begin
  Result := TcxItemDataBinding;
end;

function TcxCellEdit.GetDisplayValue(AProperties: TcxCustomEditProperties;
  ARecordIndex: Integer): Variant;
begin
  with DataController do
  begin
    if RowCount = 0 then
      Result := ''
    else
      if AProperties.GetEditValueSource(False) = evsValue then
        Result := GetValue(FilteredRecordIndex[ARecordIndex], ItemIndex)
      else
        Result := GetDisplayText(FilteredRecordIndex[ARecordIndex], ItemIndex);
  end;
end;

function TcxCellEdit.GetEditValue: Variant;
begin
  if Editing then
  begin
    if DataController.RowCount = 0 then
      Result := Null
    else
      Result := DataController.GetEditValue(ItemIndex, EditValueSource);
  end
  else
    Result := Unassigned;
end;

function TcxCellEdit.GetOptionsClass: TcxCustomEditContainerItemOptionsClass;
begin
  if Row is TcxCustomMultiEditorRow then
    Result := TcxMultiEditorRowPropertiesOptions
  else
    Result := TcxEditorRowPropertiesOptions;
end;

function TcxCellEdit.GetValue(ARecordIndex: Integer): Variant;
begin
  with DataController do
    if RowCount = 0 then
      Value := Null
    else
      Result := Values[FilteredRecordIndex[ARecordIndex], ItemIndex];
end;

function TcxCellEdit.GetValueCount: Integer;
begin
  Result := DataController.RowCount;
end;

function TcxCellEdit.HasDataTextHandler: Boolean;
begin
  Result := Assigned(EditRowProperties.FOnGetDisplayText);
end;

procedure TcxCellEdit.SetCurrentValue(const Value: Variant);
begin
  with DataController do
    if RowCount > 0 then
      Values[FilteredRecordIndex[FocusedRowIndex], ItemIndex] := Value;
end;

procedure TcxCellEdit.SetValue(ARecordIndex: Integer; const Value: Variant);
begin
  with DataController do
    if RowCount > 0 then
      Values[FilteredRecordIndex[ARecordIndex], ItemIndex] := Value;
end;

function TcxCellEdit.GetViewInfo: TcxCustomRowViewInfo;
begin
  Result := FRow.ViewInfo;
end;

{ TcxCustomEditorRowProperties }

constructor TcxCustomEditorRowProperties.CreateEx(ARow: TcxCustomRow);
begin
  //for the correct work with a collection
  FEditContainer := GetInplaceEditContainerClass.Create(ARow);
  FEditContainer.FEditRowProperties := Self;
  inherited CreateEx(ARow);
end;

destructor TcxCustomEditorRowProperties.Destroy;
begin
  FreeAndNil(FEditContainer);
  inherited Destroy;
end;

procedure TcxCustomEditorRowProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomEditorRowProperties then
    FEditContainer.Assign(TcxCustomEditorRowProperties(Source).FEditContainer);
  inherited Assign(Source);
end;

function TcxCustomEditorRowProperties.GetInplaceEditContainerClass: TcxCellEditClass;
begin
  Result := TcxCellEdit;
end;

procedure TcxCustomEditorRowProperties.DoGetDisplayTextEvent(
  ARecordIndex: Integer; var Text: string);
begin
  if Assigned(FOnGetDisplayText) then
    FOnGetDisplayText(Self, ARecordIndex, Text);
end;

function TcxCustomEditorRowProperties.GetDataBinding: TcxItemDataBinding;
begin
  Result := TcxItemDataBinding(EditContainer.FDataBinding);
end;

function TcxCustomEditorRowProperties.GetDisplayEditProperty(
  Index: Integer): TcxCustomEditProperties;
begin
  Result := FEditContainer.DoGetEditProperties(Pointer(Index));
end;

function TcxCustomEditorRowProperties.GetDisplayText(Index: Integer): string;
begin
  with EditContainer do
    Result := GetDisplayValue(DisplayEditProperties[Index], Index);
  DoGetDisplayTextEvent(Index, Result);
end;

function TcxCustomEditorRowProperties.GetEditViewData: TcxCustomEditViewData;
begin
  Result := EditContainer.EditViewData;
end;

function TcxCustomEditorRowProperties.GetEditProperties: TcxCustomEditProperties;
begin
  Result := FEditContainer.Properties;
end;

function TcxCustomEditorRowProperties.GetEditPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := FEditContainer.PropertiesClass;
end;

function TcxCustomEditorRowProperties.GetEditPropertiesClassName: string;
begin
  Result := FEditContainer.PropertiesClassName;
end;

function TcxCustomEditorRowProperties.GetIEditorPropertiesContainer: IcxEditorPropertiesContainer;
begin
  Supports(TObject(FEditContainer), IcxEditorPropertiesContainer, Result);
end;

function TcxCustomEditorRowProperties.GetItemIndex: Integer;
begin
  Result := FEditContainer.ItemIndex;
end;

function TcxCustomEditorRowProperties.GetItemLink: TObject;
begin
  Result := FEditContainer;
end;

function TcxCustomEditorRowProperties.GetOptions: TcxEditorRowPropertiesOptions;
begin
  Result := TcxEditorRowPropertiesOptions(FEditContainer.Options);
end;

function TcxCustomEditorRowProperties.GetRepositoryItem: TcxEditRepositoryItem;
begin
  Result := FEditContainer.RepositoryItem;
end;

function TcxCustomEditorRowProperties.GetValue: Variant;
begin
  Result := FEditContainer.Value;
end;

function TcxCustomEditorRowProperties.GetValueByIndex(Index: Integer): Variant;
begin
  Result := FEditContainer.Values[Index];
end;

procedure TcxCustomEditorRowProperties.SetDataBinding(
  Value: TcxItemDataBinding);
begin
  FEditContainer.FDataBinding.Assign(Value);
end;

procedure TcxCustomEditorRowProperties.SetEditProperties(
  Value: TcxCustomEditProperties);
begin
  FEditContainer.Properties := Value;
end;

procedure TcxCustomEditorRowProperties.SetEditPropertiesClass(
  Value: TcxCustomEditPropertiesClass);
begin
  FEditContainer.PropertiesClass := Value;
end;

procedure TcxCustomEditorRowProperties.SetEditPropertiesClassName(
  const Value: string);
begin
  FEditContainer.PropertiesClassName := Value;
end;

procedure TcxCustomEditorRowProperties.SetOptions(
  Value: TcxEditorRowPropertiesOptions);
begin
  FEditContainer.Options.Assign(Value);
end;

procedure TcxCustomEditorRowProperties.SetRepositoryItem(
  Value: TcxEditRepositoryItem);
begin
  FEditContainer.RepositoryItem := Value;
end;

procedure TcxCustomEditorRowProperties.SetValue(const Value: Variant);
begin
  with FEditContainer.DataController do
  begin
    if (RowCount = 0) or (FocusedRowIndex < 0) then Exit;
    if dceEdit in EditState then
      SetEditValue(FEditContainer.ItemIndex, Value, evsValue)
    else
      Values[FilteredRecordIndex[FocusedRowIndex], FEditContainer.ItemIndex] := Value;
  end;
end;

function TcxCustomEditorRowProperties.GetOnGetEditingProperties: TcxVerticalGridGetEditPropertiesEvent;
begin
  Result := TcxVerticalGridGetEditPropertiesEvent(EditContainer.OnGetEditingProperties);
end;

function TcxCustomEditorRowProperties.GetOnGetEditProperties: TcxVerticalGridGetEditPropertiesEvent;
begin
  Result := TcxVerticalGridGetEditPropertiesEvent(EditContainer.OnGetEditProperties);
end;

procedure TcxCustomEditorRowProperties.SetOnGetEditProperties(
  Value: TcxVerticalGridGetEditPropertiesEvent);
begin
  EditContainer.OnGetEditProperties := TcxGetEditPropertiesEvent(Value);
end;

procedure TcxCustomEditorRowProperties.SetOnGetEditingProperties(
  Value: TcxVerticalGridGetEditPropertiesEvent);
begin
  EditContainer.OnGetEditingProperties := TcxGetEditPropertiesEvent(Value);
end;

{ TcxEditorRowProperties }

procedure TcxEditorRowProperties.Assign(Source: TPersistent);
begin
  if Source is TcxEditorRowProperties then
  begin
    inherited Assign(Source);
    if not (Row.VerticalGrid is TcxVirtualVerticalGrid) then
      Value := TcxEditorRowProperties(Source).Value;
  end
  else
    inherited Assign(Source);
end;                                       

{ TcxCustomEditorRow }

function TcxCustomEditorRow.CreateHeaderInfo: TcxCustomRowHeaderInfo;
begin
  Result := TcxEditorRowHeaderInfo.Create(Self);
end;

function TcxCustomEditorRow.CreateViewInfo: TcxCustomRowViewInfo;
begin
  Result := TcxEditorRowViewInfo.Create(Self);
end;

function TcxCustomEditorRow.CanFocus: Boolean;
begin
  Result := Options.Focusing and Properties.Options.Focusing;
end;

function TcxCustomEditorRow.EditContainer: TcxCellEdit;
begin
  if FProperties <> nil then
    Result := TcxCustomEditorRowProperties(FProperties).FEditContainer
  else
    Result := nil;
end;

function TcxCustomEditorRow.GetDefaultHeight: Integer;
var
  AFont: TFont;
begin
  AFont := VerticalGrid.Styles.GetContentParams(Properties, False, -1).Font;
  Result := Max(inherited GetDefaultHeight, EditContainer.GetEditDefaultHeight(AFont) + cxTextOffset);
end;

function TcxCustomEditorRow.GetEditContainer(
  ACellIndex: Integer): TcxCellEdit;
begin
  Result := EditContainer;
end;

function TcxCustomEditorRow.GetEditContainerCount: Integer;
begin
  Result := 1;
end;

function TcxCustomEditorRow.GetPropertiesClass: TcxRowPropertiesClass;
begin
  Result := TcxCustomEditorRowProperties;
end;

function TcxCustomEditorRow.GetStylesClass: TcxvgCustomRowStylesClass;
begin
  Result := TcxEditorRowStyles;
end;

procedure TcxCustomEditorRow.SetParentComponent(Value: TComponent);
begin
  inherited SetParentComponent(Value);
  if Value <> nil then
    if Value is TcxCustomVerticalGrid then
      EditContainer.EditingControl := TcxCustomVerticalGrid(Value)
    else
      EditContainer.EditingControl := (Value as TcxCustomRow).VerticalGrid;
end;

procedure TcxCustomEditorRow.SetVerticalGrid(Value: TcxCustomVerticalGrid);
begin
  inherited SetVerticalGrid(Value);
  EditContainer.EditingControl := Value
end;

function TcxCustomEditorRow.GetProperties: TcxCustomEditorRowProperties;
begin
  Result := TcxCustomEditorRowProperties(FProperties);
end;

function TcxCustomEditorRow.GetStyles: TcxEditorRowStyles;
begin
  Result := TcxEditorRowStyles(FStyles);
end;

procedure TcxCustomEditorRow.SetProperties(Value: TcxCustomEditorRowProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomEditorRow.SetStyles(Value: TcxEditorRowStyles);
begin
  FStyles.Assign(Value);
  Changed;
end;

{ TcxEditorRow }

function TcxEditorRow.GetPropertiesClass: TcxRowPropertiesClass;
begin
  Result := TcxEditorRowProperties;
end;

function TcxEditorRow.GetProperties: TcxEditorRowProperties;
begin
  Result := TcxEditorRowProperties(FProperties);
end;

procedure TcxEditorRow.SetProperties(Value: TcxEditorRowProperties);
begin
  FProperties.Assign(Value);
end;

{ TcxCollectionItemEditorRowProperties }

constructor TcxCollectionItemEditorRowProperties.CreateEx(
  ARow: TcxCustomRow);
begin
  ARow.FProperties.FLocked := True;
  inherited CreateEx(ARow);
  FWidth := 50;
  FEditContainer.EditingControl := ARow.VerticalGrid;
  ARow.FProperties.FLocked := False;
end;

procedure TcxCollectionItemEditorRowProperties.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxCollectionItemEditorRowProperties then
    Width := TcxCollectionItemEditorRowProperties(Source).Width;
end;

function TcxCollectionItemEditorRowProperties.GetDisplayName: string;
begin
  Result := Caption;
end;

function TcxCollectionItemEditorRowProperties.GetOwner: TPersistent;
begin
  Result := Collection;
end;

function TcxCollectionItemEditorRowProperties.GetOptions: TcxMultiEditorRowPropertiesOptions;
begin
  Result := TcxMultiEditorRowPropertiesOptions(FEditContainer.Options);
end;

procedure TcxCollectionItemEditorRowProperties.SetOptions(
  Value: TcxMultiEditorRowPropertiesOptions);
begin
  FEditContainer.Options.Assign(Value);
end;

procedure TcxCollectionItemEditorRowProperties.SetWidth(Value: Integer);
begin
  if Value < cxvgMinValueWidth then Value := cxvgMinValueWidth;
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

{ TcxEditorRowItemProperties }

procedure TcxEditorRowItemProperties.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxEditorRowItemProperties then
  begin
    Value := TcxEditorRowItemProperties(Source).Value;
    Options := TcxEditorRowItemProperties(Source).Options;
    DataBinding := TcxEditorRowItemProperties(Source).DataBinding;
  end;
end;

{ TcxEditorPropertiesCollection }

constructor TcxEditorPropertiesCollection.Create(ARow: TcxCustomMultiEditorRow);
begin
  inherited Create(GetCollectionItemClass);
  FRow := ARow;
end;

function TcxEditorPropertiesCollection.Add: TcxEditorRowItemProperties;
begin
  Result := TcxEditorRowItemProperties(inherited Add);
end;

function TcxEditorPropertiesCollection.GetNamePath: string;
var
  S, P: string;
begin
  S := Row.Name;
  if S = '' then S := Row.GetNamePath;
  P := PropName;
  if P = '' then Exit;
  Result := S + '.' + P;
end;

function TcxEditorPropertiesCollection.GetCollectionItemClass: TCollectionItemClass;
begin
  Result := TcxEditorRowItemProperties;
end;

function TcxEditorPropertiesCollection.GetOwner: TPersistent;
begin
  if FRow = nil then
    Result := nil
  else
    Result := FRow.FProperties;
end;

procedure TcxEditorPropertiesCollection.Update(Item: TCollectionItem);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    GetItem(I).EditContainer.FCellIndex := I;
  if not Row.Properties.Locked and not Row.VerticalGrid.IsLoading then
  begin
    with Row.VerticalGrid do
    begin
      if FocusedRow = FRow then
        FocusedRow := nil;
      HideEdit;
    end;
    with Row.ViewInfo do
    begin
      Update;
      if Count > 0 then
        for I := 0 to ValuesInfo.Count - 1 do
          ValuesInfo[I].UpdateEditRect;
    end;
    Row.Changed;
  end;
end;

function TcxEditorPropertiesCollection.GetItem(
  Index: Integer): TcxEditorRowItemProperties;
begin
  Result := TcxEditorRowItemProperties(inherited Items[Index]);
end;

{ TcxMultiEditorRowProperties }

constructor TcxMultiEditorRowProperties.CreateEx(ARow: TcxCustomRow);
begin
  inherited CreateEx(ARow);
  FEditors := GetCollectionClass.Create(ARow as TcxCustomMultiEditorRow);
  FSeparatorKind := skVertLine;
end;

destructor TcxMultiEditorRowProperties.Destroy;
begin
  FreeAndNil(FEditors);
  inherited Destroy;
end;

procedure TcxMultiEditorRowProperties.Assign(Source: TPersistent);
begin
  if Source is TcxMultiEditorRowProperties then
    with TcxMultiEditorRowProperties(Source) do
    begin
      Self.SeparatorAlignmentVert := SeparatorAlignmentVert;
      Self.SeparatorKind := SeparatorKind;
      Self.SeparatorString := SeparatorString;
      Self.Fixed := Fixed;
      Self.Editors.Assign(Editors);
    end
  else
    inherited Assign(Source);
end;

function TcxMultiEditorRowProperties.GetCollectionClass: TcxEditorPropertiesCollectionClass;
begin
  Result := TcxEditorPropertiesCollection;
end;

function TcxMultiEditorRowProperties.GetOwner: TPersistent;
begin
  Result := Row;
end;

procedure TcxMultiEditorRowProperties.SetFixed(Value: Boolean);
begin
  if FFixed <> Value then
  begin
    FFixed := Value;
    Changed;
  end;
end;

procedure TcxMultiEditorRowProperties.SetSeparatorAlignmentVert(
  Value: TcxAlignmentVert);
begin
  if FSeparatorAlignmentVert <> Value then
  begin
    FSeparatorAlignmentVert := Value;
    Changed;
  end;
end;

procedure TcxMultiEditorRowProperties.SetSeparatorKind(
  Value: TSeparatorKind);
begin
  if FSeparatorKind <> Value then
  begin
    FSeparatorKind := Value;
    Changed;
  end;
end;

procedure TcxMultiEditorRowProperties.SetSeparatorString(
  const Value: string);
begin
  if FSeparatorString <> Value then
  begin
    FSeparatorString := Value;
    Changed;
  end;
end;

{ TcxCustomMultiEditorRow }

function TcxCustomMultiEditorRow.CreateHeaderInfo: TcxCustomRowHeaderInfo;
begin
  Result := TcxMultiEditorRowHeaderInfo.Create(Self);
end;

function TcxCustomMultiEditorRow.CreateViewInfo: TcxCustomRowViewInfo;
var
  I: Integer;
begin
  Result := TcxMultiEditorRowViewInfo.Create(Self);
  with TcxMultiEditorRowProperties(FProperties) do
    for I := 0 to Editors.Count - 1 do
      Editors[I].EditContainer.FCellIndex := I;
end;

function TcxCustomMultiEditorRow.CanFocus: Boolean;
var
  I: Integer;
begin
  Result := inherited CanFocus;
  if Result then
  begin
    Result := False;
    for I := 0 to Properties.Editors.Count - 1 do
    begin
      Result := Result or Properties.Editors.GetItem(I).Options.Focusing;
      if Result then break;
    end;
  end;
end;

function TcxCustomMultiEditorRow.GetDefaultHeight: Integer;
var
  I: Integer;
  AFont: TFont;
begin
  Result := inherited GetDefaultHeight;
  for I := 0 to Properties.Editors.Count - 1 do
  begin
    AFont := VerticalGrid.Styles.GetContentParams(Properties.Editors[I], False, -1).Font;
    Result := Max(Result, Properties.Editors[I].EditContainer.GetEditDefaultHeight(AFont) + cxTextOffset);
  end;
end;

function TcxCustomMultiEditorRow.GetEditContainer(
  ACellIndex: Integer): TcxCellEdit;
begin
  if (ACellIndex >= 0) and (ACellIndex < GetEditContainerCount) then
    Result := Properties.Editors[ACellIndex].EditContainer
  else
    Result := nil;
end;

function TcxCustomMultiEditorRow.GetEditContainerCount: Integer;
begin
  Result := Properties.Editors.Count;
end;

function TcxCustomMultiEditorRow.GetPropertiesClass: TcxRowPropertiesClass;
begin
  Result := TcxMultiEditorRowProperties;
end;

function TcxCustomMultiEditorRow.GetStylesClass: TcxvgCustomRowStylesClass;
begin
  Result := TcxEditorRowStyles;
end;

function TcxCustomMultiEditorRow.GetProperties: TcxMultiEditorRowProperties;
begin
  Result := TcxMultiEditorRowProperties(FProperties);;
end;

function TcxCustomMultiEditorRow.GetStyles: TcxEditorRowStyles;
begin
  Result := TcxEditorRowStyles(FStyles);
end;

procedure TcxCustomMultiEditorRow.SetProperties(
  const Value: TcxMultiEditorRowProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomMultiEditorRow.SetStyles(Value: TcxEditorRowStyles);
begin
  FStyles.Assign(Value);
  Changed;
end;

{ TcxVerticalGridRows }

constructor TcxVerticalGridRows.Create(AOwner: TcxCustomVerticalGrid);
begin
  inherited Create;
  FOwner := AOwner;
  FList := TList.Create;
  FVisibleRows := TList.Create;
  FCount := -1;
end;

destructor TcxVerticalGridRows.Destroy;
begin
  FreeAndNil(FVisibleRows);
  FreeAndNil(FList);
  inherited Destroy;
end;

procedure TcxVerticalGridRows.AssignRows(Source: TcxVerticalGridRows);

  procedure AddRowWithChildren(AParent: TcxCustomRow; ASourceRow: TcxCustomRow);
  var
    I: Integer;
    AddedRow: TcxCustomRow;
  begin
    AddedRow := Owner.AddChild(AParent, TcxCustomRowClass(ASourceRow.ClassType));
    AddedRow.FID := ASourceRow.ID;
    AddedRow.Assign(ASourceRow);
    for I := 0 to ASourceRow.Count - 1 do
      AddRowWithChildren(AddedRow, ASourceRow.Rows[I]);
  end;

var
  I: Integer;
begin
  if not (Source is TcxVerticalGridRows) then
    cxVerticalGridError(cxGetResourceString(@cxSvgAssignRowsError));
  BeginUpdate;
  try
    Clear;
    for I := 0 to Source.Root.Count - 1 do
      AddRowWithChildren(Root, Source.Root.Rows[I]);
  finally
    EndUpdate;
  end;
end;

function TcxVerticalGridRows.IndexOf(ARow: TcxCustomRow): Integer;
begin
  CheckList;
  Result := FList.IndexOf(ARow);
end;

function TcxVerticalGridRows.IsRowVisible(ARow: TcxCustomRow): Boolean;
begin
  Result := False;
  CheckList;
  if ARow.Visible then
    repeat
      ARow := ARow.FParent;
      if (ARow = Owner.RootRow) then
      begin
        Result := True;
        Exit;
      end
      else
        if not (ARow.Expanded and ARow.Visible) then Exit;
    until False;
end;

procedure TcxVerticalGridRows.Add(ARow: TcxCustomRow);
begin
  if Assigned(ARow) then
  begin
    FOwner.RootRow.Add(ARow);
    UnprepareList;
  end;
end;

procedure TcxVerticalGridRows.AddChild(AParent,
  ARow: TcxCustomRow);
begin
  if Assigned(AParent) and Assigned(ARow) then
  begin
    AParent.Add(ARow);
    UnprepareList;
  end;
end;

procedure TcxVerticalGridRows.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxVerticalGridRows.Changed(ARebuild: Boolean = False);
begin
  if ARebuild then
    PrepareList;
  if FLockCount = 0 then
    Owner.RowsChanged;
end;

procedure TcxVerticalGridRows.CheckList;
begin
  if FCount = -1 then
    PrepareList;
end;

procedure TcxVerticalGridRows.Clear;
begin
  BeginUpdate;
  try
    FOwner.FocusedRow := nil;
    FOwner.RootRow.RemoveAll;
    UnprepareList;
  finally
    EndUpdate;
  end;
end;

procedure TcxVerticalGridRows.EndUpdate;
begin
  Dec(FLockCount);
  if FLockCount = 0 then
    Changed(True);
end;

function TcxVerticalGridRows.FindLoadedParent(AID: Integer): TcxCustomRow;
var
  I: Integer;
  ARow: TcxCustomRow;
begin
  if AID = -1 then
    Result := FOwner.FRootRow
  else
  begin
    Result := nil;
    for I := 0 to Count - 1 do
    begin
      ARow := Items[I];
      if ARow.FLoadedID = AID then
      begin
        Result := ARow;
        break;
      end;
    end;
  end;
end;

function TcxVerticalGridRows.FindRowByID(AID: Integer): TcxCustomRow;
var
  I: Integer;
  ARow: TcxCustomRow;
begin
  if AID = -1 then
    Result := FOwner.FRootRow
  else
  begin
    Result := nil;
    for I := 0 to Count - 1 do
    begin
      ARow := Items[I];
      if ARow.ID = AID then
      begin
        Result := ARow;
        break;
      end;
    end;
  end;
end;

function TcxVerticalGridRows.FindRowByStoredName(const AName: string): TcxCustomRow;
var
  I: Integer;
begin
  Result := FOwner.FRootRow;
  for I := 0 to Count - 1 do
    if CompareStr(Items[I].GetObjectName, AName) = 0 then
    begin
      Result := Items[I];
      break;
    end;
end;

function TcxVerticalGridRows.GetNextID: Integer;
begin
  Result := FNextID;
  Inc(FNextID);
end;

procedure TcxVerticalGridRows.PrepareList;
var
  ARow: TcxCustomRow;

  function NextRow: TcxCustomRow;
  var
    AIndex: Integer;
    ATemp: TcxCustomRow;
  begin
    Result := nil;
    AIndex := 0;
    ATemp := ARow;
    repeat
      if ATemp.Count > AIndex then
        Result := ATemp.Rows[AIndex]
      else
      begin
        AIndex := Succ(ATemp.Index);
        ATemp := ATemp.FParent;
      end;
    until (Result <> nil) or (ATemp = nil);
  end;

begin
  FList.Clear;
  ARow := Owner.FirstRow;
  while ARow <> nil do
  begin
    FList.Add(ARow);
    ARow := NextRow;
  end;
  FCount := FList.Count;
  UpdateVisibleRows;
end;

procedure TcxVerticalGridRows.Remove(ARow: TcxCustomRow);
begin
  FList.Remove(ARow);
  UnprepareList;
end;

procedure TcxVerticalGridRows.RestoreDefaults;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].RestoreDefaults;
end;

procedure TcxVerticalGridRows.UnprepareList;
begin
  FCount := -1;
end;

procedure TcxVerticalGridRows.UpdateVisibleRows;
var
  ARow: TcxCustomRow;
  I: Integer;
begin
  FMaxVisibleLevel := 0;
  FVisibleRows.Clear;
  for I := 0 to Count - 1 do
  begin
    ARow := TcxCustomRow(FList[I]);
    if IsRowVisible(ARow) then
    begin
      FMaxVisibleLevel := Max(FMaxVisibleLevel, ARow.Level);
      ARow.FVisibleIndex := FVisibleRows.Count;
      FVisibleRows.Add(ARow);
    end
    else
      ARow.FVisibleIndex := -1;
  end;
end;

function TcxVerticalGridRows.GetCount: Integer;
begin
  CheckList;
  Result := FList.Count;
end;

function TcxVerticalGridRows.GetRoot: TcxCustomRow;
begin
  Result := FOwner.FRootRow;
end;

function TcxVerticalGridRows.GetRow(Index: Integer): TcxCustomRow;
begin
  if (Index < 0) or (Index >= Count) then // call Count -> refresh if need
    cxVerticalGridError(cxSvgIndexError);
  Result := TcxCustomRow(FList.List^[Index]);
end;

function TcxVerticalGridRows.GetVisibleRowCount: Integer;
begin
  Result := FVisibleRows.Count;
end;

function TcxVerticalGridRows.GetVisibleRow(Index: Integer): TcxCustomRow;
begin
  Result := TcxCustomRow(FVisibleRows[Index]);
end;

procedure TcxVerticalGridRows.SetRow(Index: Integer;
  const Value: TcxCustomRow);
begin
  if (Index < 0) or (Index >= Count) then // call Count -> refresh if need
    cxVerticalGridError(cxSvgIndexError);
  FList[Index] := Value;
end;

{ TBandInfoList }

constructor TBandInfoList.Create;
begin
  inherited Create(SizeOf(TBandInfo));
  Delta := 32;
end;

function TBandInfoList.Add(ABandIndex, ARowsCount, ABandHeight: Integer;
  AFirstRow: TcxCustomRow): Integer;
begin
  CheckCapacity;
  Result := FCount;
  Inc(FCount);
  with TBandInfo(Get(Result)^) do
  begin
    BandIndex := ABandIndex;
    RowsCount := ARowsCount;
    BandHeight := ABandHeight;
    FirstRow := AFirstRow;
  end;
end;

function TBandInfoList.GetItem(Index: Integer): TBandInfo;
begin
  Result := TBandInfo(Get(Index)^);
end;

{ TcxvgCustomScrollStrategy }

constructor TcxvgCustomScrollStrategy.Create(
  AScroller: TcxvgScroller);
begin
  FBandsInfo := TBandInfoList.Create;
  FScroller := AScroller;
end;

destructor TcxvgCustomScrollStrategy.Destroy;
begin
  FBandsInfo.Free;
  inherited Destroy;
end;

procedure TcxvgCustomScrollStrategy.CheckDecreaseLeftIndex;
begin
end;

procedure TcxvgCustomScrollStrategy.CheckDecreaseTopIndex(AScrollRectHeight: Integer);
var
  ACount, ATotal: Integer;
begin
  ATotal := ViewInfo.VisibleRowCount;
  ACount := GetVisibleCountFromBottom(ATotal - 1, AScrollRectHeight);
  if ATotal - ACount < FTopVisibleRowIndex then
    FTopVisibleRowIndex := ATotal - ACount;
end;

function TcxvgCustomScrollStrategy.CheckTopVisibleIndex(AIndex, AStep: Integer): Integer;
var
  ACount: Integer;
begin
  Result := AIndex;
  ACount := ViewInfo.VisibleRowCount;
  cxRange(Result, 0, ACount -
    GetVisibleCountFromBottom(ACount - 1, cxRectHeight(ViewInfo.ClientRect)));
end;

function TcxvgCustomScrollStrategy.FindNextCustomItem(AFocusedItemIndex, AItemCount: Integer;
  AGoForward: Boolean; var AItemIndex: Integer): Boolean;

  function GetFromIndex: Integer;
  begin
    if AFocusedItemIndex = -1 then
      if AGoForward then
        Result := 0
      else
        Result := -1
    else
      if AGoForward then
        Result := AFocusedItemIndex + 1
      else
        Result := AFocusedItemIndex - 1;
  end;

  function CheckIndex(var AIndex: Integer): Boolean;
  begin
    Result := True;
    if AGoForward then
      if AIndex > AItemCount - 1 then
        Result := False
      else
    else
      if AIndex < 0 then
        Result := False;
  end;
begin
  Result := False;
  if AItemCount = 0 then Exit;
  AItemIndex := GetFromIndex;
  Result := CheckIndex(AItemIndex);
end;

function TcxvgCustomScrollStrategy.FindNextRecord(AFocusedRecordIndex: Integer;
  AGoForward: Boolean): Integer;
begin
  if DataController.IsGridMode then
    if AGoForward then
      if not DataController.IsEOF and (AFocusedRecordIndex = DataController.RowCount - 1) then
      begin
        DataController.Scroll(1);
        if not DataController.IsEOF then
          Dec(AFocusedRecordIndex);
      end
      else
    else
      if (AFocusedRecordIndex = 0) and not DataController.IsBOF then
      begin
        DataController.Scroll(-1);
        if not DataController.IsBOF then
          Inc(AFocusedRecordIndex);
      end;
  if not FindNextCustomItem(AFocusedRecordIndex, DataController.RowCount, AGoForward, Result) then
    Result := -1;
end;

function TcxvgCustomScrollStrategy.FocusNextRecord(AFocusedRecordIndex: Integer;
  AGoForward: Boolean): Boolean;

  procedure CheckEditing;
  begin
    if DataController.IsEditing then
    begin
      TcxEditingControllerAccess(Controller.EditingController).UpdateValue;
      if not (dceModified in DataController.EditState) then
      begin
        if DataController.EditState = [dceInsert] then
        begin
          Result := AGoForward xor DataController.IsEOF;
          if Result then DataController.Cancel;
        end;
        Exit;
      end;
      DataController.Post;
      AFocusedRecordIndex := DataController.FocusedRowIndex;
    end;
  end;

  procedure CheckGridMode;
  begin
    if DataController.IsGridMode and (AFocusedRecordIndex = -1) and AGoForward then
      DataController.GotoFirst
  end;

var
  ANewRecordIndex: Integer;

begin
  Result := False;
  CheckEditing;
  if Result then Exit;
  CheckGridMode;
  ANewRecordIndex := FindNextRecord(AFocusedRecordIndex, AGoForward);
  Result := ANewRecordIndex <> -1;
  if Result then
    DataController.FocusedRowIndex := ANewRecordIndex;
end;

function TcxvgCustomScrollStrategy.GetFirstRowByBandIndex(
  ABandIndex: Integer): TcxCustomRow;
begin
  if not cxInRange(ABandIndex, 0, BandsInfo.Count - 1) then
    Result := nil
  else
    Result := FBandsInfo[ABandIndex].FirstRow;
end;

procedure TcxvgCustomScrollStrategy.InitHScrollBarParameters;
var
  AScrollRecordCount, AScrollPos: Integer;

  procedure GetScrollRecordParams;
  var
    AIntf: IcxVerticalGridDBDataContoller;
  begin
    if DataController.GetInterface(IcxVerticalGridDBDataContoller, AIntf) then
    begin
      AScrollRecordCount := AIntf.GetScrollBarRecordCount;
      AScrollPos := AIntf.GetScrollBarPos;
    end
    else
    begin
      AScrollRecordCount := -1;
      AScrollPos := -1;
    end;
    if AScrollRecordCount = -1 then
      AScrollRecordCount := DataController.RowCount + ScrollBarOffsetBegin + ScrollBarOffsetEnd;
    if AScrollPos = -1 then
      AScrollPos := LeftVisibleRecord + ScrollBarOffsetBegin;
  end;

begin
  GetScrollRecordParams;
  VerticalGrid.SetScrollBarInfo(sbHorizontal,
    0, AScrollRecordCount - 1, 1, VisibleValueCount,
    ScrollBarPos, not IsHideHScrollBar, True);
end;

procedure TcxvgCustomScrollStrategy.InitVScrollBarParameters;
begin
  VerticalGrid.SetScrollBarInfo(sbVertical,
    0, ViewInfo.VisibleRowCount - 1, //min max
    1, VisibleRowCount, TopVisibleRowIndex, not IsHideVScrollBar, True);
end;

function TcxvgCustomScrollStrategy.GetVisibleCountFromBottom(
  ABottomIndex, AHeight: Integer): Integer;
begin
  Result := GetVisibleCount(ABottomIndex, AHeight, -1, False);
end;

function TcxvgCustomScrollStrategy.GetVisibleCountFromTop(
  ATopIndex, AHeight: Integer): Integer;
begin
  Result := GetVisibleCount(ATopIndex, AHeight, 1, True);
end;

procedure TcxvgCustomScrollStrategy.RecalcBandsInfo;
begin
  FBandsInfo.Clear;
  FBandsInfo.Add(0, ViewInfo.VisibleRowCount, -1, ViewInfo.VisibleRows[0]);
end;

procedure TcxvgCustomScrollStrategy.ScrollRecords(AForward: Boolean;
  ACount: Integer);
var
  AIntf: IcxVerticalGridDBDataContoller;
begin
  if not DataController.GetInterface(IcxVerticalGridDBDataContoller, AIntf) or
    not AIntf.DoScroll(AForward) then
    if AForward then
      Scroller.LeftVisibleRecord := LeftVisibleRecord + ACount
    else
      Scroller.LeftVisibleRecord := LeftVisibleRecord - ACount;
end;

procedure TcxvgCustomScrollStrategy.SetRowMaxVisible(ARow: TcxCustomRow);
var
  N, ATopIndex, AChildCount, AGroupHeight, AClientHeight: Integer;
begin
  if ARow = nil then Exit;
  AGroupHeight := GetFullRowHeight(ARow, AChildCount);
  AClientHeight := BandsInfo.Count * cxRectHeight(ViewInfo.ClientRect);
  if AGroupHeight >= AClientHeight then
    SetTopVisibleRowIndexAndBand(ARow.VisibleIndex)
  else
  begin
    N := GetVisibleCountFromTop(FTopVisibleRowIndex, cxRectHeight(ViewInfo.ClientRect));
    ATopIndex := ARow.VisibleIndex + AChildCount - N + 1;
    if FTopVisibleRowIndex < ATopIndex then
      SetTopVisibleRowIndexAndBand(ATopIndex);
  end
end;

function TcxvgCustomScrollStrategy.CanContinueForward(Index: Integer): Boolean;
begin
  Result := Index < ViewInfo.VisibleRowCount;
end;

function TcxvgCustomScrollStrategy.CanContinueBackward(Index: Integer): Boolean;
begin
  Result := Index > -1;
end;

function TcxvgCustomScrollStrategy.CanCalcRowsOnTheNextBand(ALeft,
  ANextBandIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TcxvgCustomScrollStrategy.CheckLeftVisibleRecord(var AValue: Integer);
var
  AIsGridMode: Boolean;
  AMaxValue: Integer;
begin
  if FCheckingCoordinate then Exit;
  FCheckingCoordinate := True;
  with DataController do
  try
    AIsGridMode := IsGridMode;
    if AValue < 0 then
    begin
      if AIsGridMode and not IsBOF then
        Scroll(AValue);
      AValue := 0;
    end;
    if AValue > RowCount - 1 then
    begin
      if AIsGridMode and not IsEOF then
        Scroll(AValue - (RowCount - 1));
      AValue := RowCount - 1;
    end;
    if AValue <= 0 then Exit;
    AMaxValue := RowCount - VisibleValueCount;
    if AValue > AMaxValue then
    begin
      if AIsGridMode and not IsEOF and not (dceInsert in EditState) then
        Scroll(AValue - AMaxValue);
      AValue := AMaxValue;
    end;
  finally
    FCheckingCoordinate := False;
  end;
end;

function TcxvgCustomScrollStrategy.GetBandWidth: Integer;
begin
  Result := ViewInfo.FViewBandWidth;
end;

function TcxvgCustomScrollStrategy.GetBottomVisibleChild(
  ARow: TcxCustomRow): TcxCustomRow;
begin
  if (ARow = nil) or not (ARow.Expanded and ARow.Visible) then
  begin
    Result := nil;
    Exit
  end;
  Result := ARow.GetLastVisibleChild;
end;

function TcxvgCustomScrollStrategy.GetFullRowHeight(ARow: TcxCustomRow;
  out ChildCount: Integer): Integer;
var
  I, AIndex: Integer;
  AChild: TcxCustomRow;
begin
  ChildCount := 0;
  Result := 0;
  if ARow = nil then Exit;
  with ViewInfo do
  begin
    Result := ARow.ViewInfo.CalculatedHeight + HorzLineWidth;
    AIndex := ARow.VisibleIndex;
    if AIndex >= 0 then
      for I := AIndex + 1 to VisibleRowCount - 1 do
      begin
        AChild := VisibleRows[I];
        if ARow.IsParent(AChild) then
        begin
          Inc(ChildCount);
          Inc(Result, AChild.ViewInfo.CalculatedHeight + HorzLineWidth);
        end;
      end;
  end;
end;

function TcxvgCustomScrollStrategy.GetScrollBarOffsetBegin: Integer;
begin
  with DataController do
  begin
    if IsGridMode and IsRecordsScrollMode then
      Result := Ord(not IsBOF)
    else
      Result := 0;
  end;
end;

function TcxvgCustomScrollStrategy.GetScrollBarOffsetEnd: Integer;
begin
  with DataController do
  begin
    if IsGridMode and IsRecordsScrollMode then
      Result := Ord(not IsEOF)
    else
      Result := 0;
  end;
end;

function TcxvgCustomScrollStrategy.GetVisibleCount(ABeginIndex, AAreaHeight,
  AStep: Integer; AForward: Boolean): Integer;

  function CheckContinue(AIndex: Integer): Boolean;
  begin
    if AForward then
      Result := CanContinueForward(AIndex)
    else
      Result := CanContinueBackward(AIndex)
  end;

var
  ARowCount, ARowHeight, ABandCount, ALeft, ABandWidth, ABandHeight: Integer;
  ARowViewInfo: TcxCustomRowViewInfo;
begin
  Result      := 0;
  ARowCount   := 0;
  ABandCount  := 0;
  ABandWidth := BandWidth;
  if ABandWidth <= 0 then Exit;
  with ViewInfo do
  begin
    ABandHeight := HorzLineWidth;
    ALeft := ClientRect.Left;
    while CheckContinue(ABeginIndex) do
    begin
      ARowViewInfo := VisibleRows[ABeginIndex].ViewInfo;
      ARowHeight := ARowViewInfo.CalculatedHeight;
      if ABandHeight + ARowHeight + HorzLineWidth > AAreaHeight then
      begin
        if ARowCount = 0 then ARowCount := 1;
        Inc(Result, ARowCount);
        ARowCount := 0;
        ABandHeight := HorzLineWidth;
        Inc(ALeft, ABandWidth + BandInterval);
        Inc(ABandCount);
        if not CanCalcRowsOnTheNextBand(ALeft, ABandCount) then break;
      end;
      Inc(ABandHeight, ARowHeight + HorzLineWidth);
      Inc(ARowCount);
      Inc(ABeginIndex, AStep);
    end;
  end;
  Inc(Result, ARowCount);
end;

function TcxvgCustomScrollStrategy.IsBehindRightClientEdge(X: Integer): Boolean;
begin
 Result := X > (ViewInfo.ClientRect.Right - ViewInfo.VertLineWidth);
end;

function TcxvgCustomScrollStrategy.IsHideHScrollBar: Boolean;
begin
  with VerticalGrid do
    Result := (ClientHeight - 2 < HScrollBar.Height) or
      (IsRecordsScrollMode and not Controller.CanChangeRecord);
end;

function TcxvgCustomScrollStrategy.IsHideVScrollBar: Boolean;
begin
  Result := cxRectWidth(ViewInfo.ClientRect) - 2 < VerticalGrid.VScrollBar.Width;
end;

function TcxvgCustomScrollStrategy.IsRecordsScrollMode: Boolean;
begin
  Result := True;
end;

procedure TcxvgCustomScrollStrategy.ScrollH(
  AScrollCode: TScrollCode; var AScrollPos: Integer);

  procedure DoScrollRecords;
  begin
    case AScrollCode of
      scLineUp:
        ScrollRecords(False, 1);
      scLineDown:
        ScrollRecords(True, 1);
      scPageUp:
        Scroller.LeftVisibleRecord := LeftVisibleRecord - VisibleValueCount;
      scPageDown:
        Scroller.LeftVisibleRecord := LeftVisibleRecord + VisibleValueCount;
      scTrack:
        if not DataController.IsGridMode then
          ScrollBarPos := AScrollPos;
      scPosition:
        if DataController.IsGridMode then
          ScrollBarPos := AScrollPos;
    end;
    AScrollPos := ScrollBarPos;
  end;

  procedure DoScrollBands;
  begin
    case AScrollCode of
      scLineUp:
        Scroller.LeftVisibleBand := LeftVisibleBand - 1;
      scLineDown:
        Scroller.LeftVisibleBand := LeftVisibleBand + 1;
      scPageUp:
        Scroller.LeftVisibleBand := LeftVisibleBand - VisibleBandCount;
      scPageDown:
        Scroller.LeftVisibleBand := LeftVisibleBand + VisibleBandCount;
      scTrack:
        Scroller.LeftVisibleBand := AScrollPos;
    end;
    AScrollPos := LeftVisibleBand;
  end;

begin
  if IsRecordsScrollMode then
    DoScrollRecords
  else
    DoScrollBands;
end;

procedure TcxvgCustomScrollStrategy.ScrollV(
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  case AScrollCode of
    scLineUp:
      Scroller.TopVisibleRowIndex := TopVisibleRowIndex - 1;
    scLineDown:
      Scroller.TopVisibleRowIndex := TopVisibleRowIndex + 1;
    scPageUp:
      Scroller.TopVisibleRowIndex := TopVisibleRowIndex - VisibleRowCount;
    scPageDown:
      Scroller.TopVisibleRowIndex := TopVisibleRowIndex + VisibleRowCount;
    scTrack:
      Scroller.TopVisibleRowIndex := AScrollPos;
  end;
  AScrollPos := TopVisibleRowIndex;
end;

procedure TcxvgCustomScrollStrategy.SetLeftVisibleRecord(Value: Integer);
begin
  CheckLeftVisibleRecord(Value);
  if (FLeftVisibleRecord <> Value) and (Value <> -1) then
  begin
    FLeftVisibleRecord := Value;
    VerticalGrid.LayoutChanged;
  end;
end;

procedure TcxvgCustomScrollStrategy.SetTopVisibleRowIndexAndBand(Index: Integer);
begin
  Index := CheckTopVisibleIndex(Index, 0);
  SetTopVisibleRowIndex(Index);
end;

function TcxvgCustomScrollStrategy.GetController: TcxvgController;
begin
  Result := VerticalGrid.Controller;
end;

function TcxvgCustomScrollStrategy.GetDataController: TcxCustomDataController;
begin
  Result := VerticalGrid.DataController;
end;

function TcxvgCustomScrollStrategy.GetScrollBarPos: Integer;
var
  AIntf: IcxVerticalGridDBDataContoller;
begin
  if DataController.GetInterface(IcxVerticalGridDBDataContoller, AIntf) then
    Result := AIntf.GetScrollBarPos
  else
    Result := -1;
  if Result = -1 then
    Result := LeftVisibleRecord + ScrollBarOffsetBegin;
end;

function TcxvgCustomScrollStrategy.GetVerticalGrid: TcxCustomVerticalGrid;
begin
  Result := Scroller.VerticalGrid;
end;

function TcxvgCustomScrollStrategy.GetViewInfo: TcxvgCustomViewInfo;
begin
  Result := Scroller.ViewInfo;
end;

function TcxvgCustomScrollStrategy.GetVisibleRowCount: Integer;
begin
  with ViewInfo.ClientRect do
    Result := GetVisibleCountFromTop(TopVisibleRowIndex, Bottom - Top);
end;

procedure TcxvgCustomScrollStrategy.SetScrollBarPos(Value: Integer);
var
  AIntf: IcxVerticalGridDBDataContoller;
begin
  if not DataController.GetInterface(IcxVerticalGridDBDataContoller, AIntf) or
    not AIntf.SetScrollBarPos(Value) then
      Scroller.LeftVisibleRecord := Value - ScrollBarOffsetBegin
end;

procedure TcxvgCustomScrollStrategy.SetTopVisibleRowIndex(Value: Integer);
begin
  if FTopVisibleRowIndex <> Value then
  begin
    FTopVisibleRowIndex := Value;
    VerticalGrid.LayoutChanged;
  end;
end;

{ TcxvgSingleRecordScrollStrategy }

function TcxvgSingleRecordScrollStrategy.GetBandIndexByRowIndex(
  ARowIndex: Integer): Integer;
begin
  Result := 0;
end;

function TcxvgSingleRecordScrollStrategy.GetBandInterval: Integer;
begin
  Result := 0;
end;

function TcxvgSingleRecordScrollStrategy.GetLeftVisibleBand: Integer;
begin
  Result := 0;
end;

function TcxvgSingleRecordScrollStrategy.GetVisibleBandCount: Integer;
begin
  Result := 1;
end;

function TcxvgSingleRecordScrollStrategy.GetVisibleValueCount: Integer;
begin
  Result := 1;
end;

procedure TcxvgSingleRecordScrollStrategy.SetLeftVisibleBand(Value: Integer);
begin
end;

{ TcxvgMultiRecordsScrollStrategy }

procedure TcxvgMultiRecordsScrollStrategy.CheckDecreaseLeftIndex;
var
  AVisibleCount: Integer;
begin
  AVisibleCount := VisibleValueCount;
  if LeftVisibleRecord + AVisibleCount > VerticalGrid.RecordCount then
    FLeftVisibleRecord := Max(0, VerticalGrid.RecordCount - AVisibleCount);
end;

function TcxvgMultiRecordsScrollStrategy.GetBandIndexByRowIndex(
  ARowIndex: Integer): Integer;
begin
  Result := 0;
end;

function TcxvgMultiRecordsScrollStrategy.GetBandInterval: Integer;
begin
  Result := 0;
end;

function TcxvgMultiRecordsScrollStrategy.GetLeftVisibleBand: Integer;
begin
  Result := 0;
end;

function TcxvgMultiRecordsScrollStrategy.GetVisibleBandCount: Integer;
begin
  Result := 1;
end;

function TcxvgMultiRecordsScrollStrategy.GetVisibleValueCount: Integer;
var
  ACount, ARecordSpace, ARecordsWidth: Integer;
begin
  with ViewInfo do
  begin
    ARecordSpace := cxSetValue(RecordsInterval = 0, VertLineWidth,
      2 * VertLineWidth + RecordsInterval);
    ARecordsWidth := cxRectWidth(ClientRect) - VertLineWidth -
      FFullHeaderWidth + (ARecordSpace - VertLineWidth);
    ACount := Max(1, ARecordsWidth div (ViewValueWidth + ARecordSpace));
  end;
  Result := Min(ACount, VerticalGrid.RecordCount);
end;

procedure TcxvgMultiRecordsScrollStrategy.SetLeftVisibleBand(Value: Integer);
begin
end;

function TcxvgMultiRecordsScrollStrategy.GetRecordsInterval: Integer;
begin
  Result := TcxMultiRecordViewInfo(ViewInfo).RecordsInterval;
end;

{ TcxvgBandsScrollStrategy }

procedure TcxvgBandsScrollStrategy.CheckDecreaseTopIndex(AScrollRectHeight: Integer);
var
  ALeftBand: Integer;
begin
  ALeftBand := Max(0, BandsInfo.Count - VisibleBandCount);
  if ALeftBand < FLeftVisibleBand then
  begin
    FLeftVisibleBand := ALeftBand;
    VerticalGrid.DoLeftVisibleBandIndexChanged;
  end;
  FTopVisibleRowIndex := GetFirstRowByBandIndex(FLeftVisibleBand).VisibleIndex;
end;

function TcxvgBandsScrollStrategy.CheckTopVisibleIndex(
  AIndex, AStep: Integer): Integer;
var
  ARow: TcxCustomRow;
  ABandIndex: Integer;
begin
  ARow := ViewInfo.VisibleRows[AIndex];
  ABandIndex := GetBandIndexByRowIndex(AIndex);
  if ARow <> GetFirstRowByBandIndex(ABandIndex) then
  begin
    Inc(ABandIndex, AStep);
    ARow := GetFirstRowByBandIndex(ABandIndex);
  end;
  if ARow <> nil then
  begin
    AIndex := ARow.VisibleIndex;
    if FLeftVisibleBand <> ABandIndex then
    begin
      FLeftVisibleBand := ABandIndex;
      VerticalGrid.DoLeftVisibleBandIndexChanged;
    end;  
  end;
  Result := AIndex;
end;

function TcxvgBandsScrollStrategy.GetBandIndexByRowIndex(
  ARowIndex: Integer): Integer;
var
  I, AFirstIndex: Integer;
  ABandInfo: TBandInfo;
begin
  Result := -1;
  for I := 0 to FBandsInfo.Count - 1 do
  begin
    ABandInfo := BandsInfo[I];
    AFirstIndex := ABandInfo.FirstRow.VisibleIndex;
    if (ARowIndex >= AFirstIndex) and (ARowIndex < AFirstIndex + ABandInfo.RowsCount) then
    begin
      Result := I;
      break;
    end;
  end;
end;

procedure TcxvgBandsScrollStrategy.InitHScrollBarParameters;
begin
  if IsRecordsScrollMode then
    inherited InitHScrollBarParameters
  else
    VerticalGrid.SetScrollBarInfo(sbHorizontal, 0, BandsInfo.Count - 1, 1,
      VisibleBandCount, LeftVisibleBand, not IsHideHScrollBar, True);
end;

function TcxvgBandsScrollStrategy.IsHideVScrollBar: Boolean;
begin
  Result := True;
end;

procedure TcxvgBandsScrollStrategy.RecalcBandsInfo;
var
  I, ARowCount, AHeight, ABandIndex, AClientHeight: Integer;
  ARow, AFirstRow: TcxCustomRow;
  ARowViewInfo: TcxCustomRowViewInfo;
begin
  FBandsInfo.Clear;
  ARowCount := 0;
  ABandIndex := 0;
  with ViewInfo do
  begin
    AHeight := HorzLineWidth;
    ViewValueWidth := GetViewValueWidth;
    AClientHeight := cxRectHeight(ClientRect); // for LayoutStyleChanged
    I := 0;
    while I < VisibleRowCount do
    begin
      ARow := VisibleRows[I];
      ARowViewInfo := ARow.ViewInfo;
      if AHeight + ARowViewInfo.CalculatedHeight + HorzLineWidth > AClientHeight then
      begin
        AFirstRow := VisibleRows[I - ARowCount];
        if ARowCount = 0 then
        begin
          ARowCount := 1;
          AFirstRow := VisibleRows[I];
          AHeight := ARowViewInfo.CalculatedHeight + HorzLineWidth;
        end
        else Dec(I);
        BandsInfo.Add(ABandIndex, ARowCount, AHeight, AFirstRow);
        AHeight := HorzLineWidth;
        ARowCount := 0;
        Inc(ABandIndex);
        Inc(I);
        continue;
      end;
      Inc(AHeight, ARowViewInfo.CalculatedHeight + HorzLineWidth);
      Inc(ARowCount);
      Inc(I);
    end;
    if ARowCount <> 0 then
      BandsInfo.Add(ABandIndex, ARowCount, AHeight, VisibleRows[I - ARowCount]);
  end;
end;

procedure TcxvgBandsScrollStrategy.SetRowMaxVisible(ARow: TcxCustomRow);
begin
  SetTopVisibleRowIndexAndBand(GetBandViewRowMaxVisibleTopIndex(ARow));
end;

function TcxvgBandsScrollStrategy.CanCalcRowsOnTheNextBand(
  ALeft, ANextBandIndex: Integer): Boolean;
var
  X: Integer;
begin
  Result := True;
  if IsBehindRightClientEdge(ALeft + BandWidth + ViewInfo.BandsInterval + 1) then
  begin
    if VerticalGrid.OptionsView.AutoScaleBands then
    begin
      X := (ALeft + BandWidth) - ViewInfo.ClientRect.Right;
      if X > ANextBandIndex then Result := False;
    end
    else
      Result := False;
  end;
end;

function TcxvgBandsScrollStrategy.GetBandInterval: Integer;
begin
  Result := ViewInfo.BandsInterval;
end;

function TcxvgBandsScrollStrategy.GetBandViewRowMaxVisibleTopIndex(
  ARow: TcxCustomRow): Integer;
var
  AFirstBandIndex, ALastBandIndex, AVisBandsCount: Integer;
  ABottomChild: TcxCustomRow;
begin
  AFirstBandIndex := GetBandIndexByRowIndex(ARow.VisibleIndex);
  ABottomChild := GetBottomVisibleChild(ARow);
  if (ABottomChild <> nil) and (ABottomChild <> ARow) then
  begin
    ALastBandIndex := GetBandIndexByRowIndex(ABottomChild.VisibleIndex);
    AVisBandsCount := VisibleBandCount;
    if ALastBandIndex - AFirstBandIndex > AVisBandsCount then
    begin
      Result := ARow.VisibleIndex;
      Exit;
    end;
    if AFirstBandIndex + AVisBandsCount > ALastBandIndex then
    begin
      AFirstBandIndex := Max(0, ALastBandIndex - AVisBandsCount + 1);
      Result := GetFirstRowByBandIndex(AFirstBandIndex).VisibleIndex;
      Exit;
    end;
  end;
  Result := ARow.VisibleIndex;
end;

function TcxvgBandsScrollStrategy.GetLeftVisibleBand: Integer;
begin
  Result := FLeftVisibleBand;
end;

function TcxvgBandsScrollStrategy.GetVisibleBandCount: Integer;
var
  W, AIndents: Integer;
begin
  W := Max(1, ViewInfo.ViewBandWidth); // W = 0 ???
  AIndents := BandsInfo.Count - 1 * TcxBandsViewInfo(ViewInfo).BandsInterval;
  Result := Min(BandsInfo.Count, Max(1, (cxRectWidth(ViewInfo.ClientRect) - AIndents) div W));
end;

function TcxvgBandsScrollStrategy.GetVisibleValueCount: Integer;
begin
  Result := 1;
end;

function TcxvgBandsScrollStrategy.IsRecordsScrollMode: Boolean;
begin
  Result := Controller.CanChangeRecord;
end;

procedure TcxvgBandsScrollStrategy.SetLeftVisibleBand(Value: Integer);
var
  AFirstRow: TcxCustomRow;
begin
  cxRange(Value, 0, BandsInfo.Count - VisibleBandCount);
  if FLeftVisibleBand <> Value then
  begin
    FLeftVisibleBand := Value;
    AFirstRow := GetFirstRowByBandIndex(Value);
    if AFirstRow = nil then
      FTopVisibleRowIndex := 0
    else
      FTopVisibleRowIndex := AFirstRow.VisibleIndex;
    VerticalGrid.LayoutChanged;
  end;
end;

{ TcxvgScroller }

constructor TcxvgScroller.Create(AVerticalGrid: TcxCustomVerticalGrid);
begin
  FVerticalGrid := AVerticalGrid;
end;

destructor TcxvgScroller.Destroy;
begin
  FreeAndNil(FScrollStrategy);
  inherited Destroy;
end;

function TcxvgScroller.GoToFirst: Boolean;
begin
  Result := ScrollStrategy.FocusNextRecord(-1, True);
end;

function TcxvgScroller.GoToLast: Boolean;
begin
  Result := ScrollStrategy.FocusNextRecord(-1, False);
end;

function TcxvgScroller.GoToNext: Boolean;
begin
  Result := ScrollStrategy.FocusNextRecord(FocusedRecordIndex, True);
end;

function TcxvgScroller.GoToPrev: Boolean;
begin
  Result := ScrollStrategy.FocusNextRecord(FocusedRecordIndex, False);
end;

function TcxvgScroller.GetBandIndexByRowIndex(
  ARowIndex: Integer): Integer;
begin
  Result := FScrollStrategy.GetBandIndexByRowIndex(ARowIndex);
end;

procedure TcxvgScroller.InitScrollBarsParameters;
begin
  with ScrollStrategy do
  begin
    InitHScrollBarParameters;
    InitVScrollBarParameters;
  end;
end;

procedure TcxvgScroller.RecalcBandsInfo;
begin
  ScrollStrategy.RecalcBandsInfo;
  if CheckDecrease then
  begin
    CheckDecreaseLeftIndex;
    CheckDecreaseTopIndex;
    ViewInfo.PrepareCalculateBandsInfo;
    ScrollStrategy.RecalcBandsInfo;
  end;
end;

procedure TcxvgScroller.RecreateScrollStrategy;
begin
  FreeAndNil(FScrollStrategy);
  FScrollStrategy := CreateScrollStrategy(Self);
  CheckDecrease := True;
end;

procedure TcxvgScroller.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  if AScrollBarKind = sbHorizontal then
    FScrollStrategy.ScrollH(AScrollCode, AScrollPos)
  else
    FScrollStrategy.ScrollV(AScrollCode, AScrollPos);
end;

function TcxvgScroller.SetRecordVisible(ARecordIndex: Integer): Boolean;
var
  ACount, AOldLeftVisibleRecord: Integer;
begin
  Result := False;
  if (ARecordIndex < 0) or (ARecordIndex > VerticalGrid.RecordCount - 1) then Exit;
  AOldLeftVisibleRecord := LeftVisibleRecord;
  if (ARecordIndex < AOldLeftVisibleRecord) then
    LeftVisibleRecord := ARecordIndex
  else
  begin
    ACount := VisibleValueCount;
    if AOldLeftVisibleRecord + ACount <= ARecordIndex then
      LeftVisibleRecord := ARecordIndex - ACount + 1;
  end;
  Result := LeftVisibleRecord <> AOldLeftVisibleRecord;
end;

procedure TcxvgScroller.SetRowMaxVisible(ARow: TcxCustomRow);
begin
  if (ARow = nil) or (ARow.VisibleIndex < 0) then Exit;
  if not ARow.Expanded then
    SetRowVisible(ARow)
  else
    ScrollStrategy.SetRowMaxVisible(ARow);
end;

procedure TcxvgScroller.SetRowVisible(ARow: TcxCustomRow);
var
  AIndex, ATopIndex, ACount, AStep: Integer;
begin
  if ARow = nil then Exit;
  AIndex := ARow.VisibleIndex;
  if AIndex < 0 then Exit;
  ATopIndex := TopVisibleRowIndex;
  AStep := 0;
  if AIndex < TopVisibleRowIndex then
    ATopIndex := AIndex
  else
    if TopVisibleRowIndex + VisibleRowCount <= AIndex then
    begin
      ACount := GetVisibleCountFromBottom(AIndex);
      if AIndex + 1 - ACount > TopVisibleRowIndex then
        ATopIndex := Max(0, AIndex - ACount + 1);
      AStep := 1;
    end;
  with ScrollStrategy do
    SetTopVisibleRowIndex(CheckTopVisibleIndex(ATopIndex, AStep));
end;

function TcxvgScroller.CreateScrollStrategy(
  AScroller: TcxvgScroller): TcxvgCustomScrollStrategy;
begin
  Result := VerticalGrid.GetScrollStrategyClass.Create(Self);
end;

procedure TcxvgScroller.LayoutStyleChanged;
begin
  CheckDecrease := True;
  VerticalGrid.LayoutChanged;
end;

procedure TcxvgScroller.RestoreLayout;
begin
  VerticalGrid.BeginUpdate;
  LeftVisibleRecord := FSaveLeftVisibleRecord;
  LeftVisibleBand := FSaveLeftVisibleBand;
  TopVisibleRowIndex := FSaveTopVisibleRowIndex;
  VerticalGrid.EndUpdate;
end;

procedure TcxvgScroller.SaveLayout;
begin
  FSaveTopVisibleRowIndex := TopVisibleRowIndex;
  FSaveLeftVisibleRecord := LeftVisibleRecord;
  FSaveLeftVisibleBand := LeftVisibleBand;
end;

procedure TcxvgScroller.CheckDecreaseLeftIndex;
begin
  if FCheckDecreaseLeftIndex then
  begin
    FScrollStrategy.CheckDecreaseLeftIndex;
    FCheckDecreaseLeftIndex := False;
  end;
end;

procedure TcxvgScroller.CheckDecreaseTopIndex;
begin
  if not FCheckDecreaseTopIndex or (TopVisibleRowIndex = 0) then Exit;
  with ViewInfo.ClientRect do
    FScrollStrategy.CheckDecreaseTopIndex(Bottom - Top);
  FCheckDecreaseTopIndex := False;
end;

function TcxvgScroller.GetBandsInfo: TBandInfoList;
begin
  Result := FScrollStrategy.FBandsInfo;
end;

function TcxvgScroller.GetCheckDecrease: Boolean;
begin
  Result := FCheckDecreaseLeftIndex or FCheckDecreaseTopIndex;
end;

function TcxvgScroller.GetFocusedRecordIndex: Integer;
begin
  Result := FVerticalGrid.DataController.FocusedRowIndex;
end;

function TcxvgScroller.GetLeftVisibleBand: Integer;
begin
  Result := FScrollStrategy.LeftVisibleBand;
end;

function TcxvgScroller.GetLeftVisibleRecord: Integer;
begin
  Result := FScrollStrategy.LeftVisibleRecord;
end;

function TcxvgScroller.GetTopVisibleRowIndex: Integer;
begin
  Result := FScrollStrategy.TopVisibleRowIndex;
end;

function TcxvgScroller.GetViewInfo: TcxvgCustomViewInfo;
begin
  Result := FVerticalGrid.ViewInfo;
end;

function TcxvgScroller.GetVisibleCountFromBottom(
  ARowIndex: Integer): Integer;
begin
  Result := FScrollStrategy.GetVisibleCountFromBottom(ARowIndex, cxRectHeight(ViewInfo.ClientRect));
end;

function TcxvgScroller.GetVisibleRowCount: Integer;
begin
  Result := FScrollStrategy.GetVisibleRowCount;
end;

function TcxvgScroller.GetVisibleValueCount: Integer;
begin
  Result := FScrollStrategy.GetVisibleValueCount;
end;

procedure TcxvgScroller.SetCheckDecrease(Value: Boolean);
begin
  FCheckDecreaseTopIndex  := Value;
  FCheckDecreaseLeftIndex := Value;
end;

procedure TcxvgScroller.SetLeftVisibleBand(Value: Integer);
var
  AOldValue: Integer;
begin
  AOldValue := LeftVisibleBand;
  ScrollStrategy.LeftVisibleBand := Value;
  if AOldValue <> LeftVisibleBand then
    VerticalGrid.DoLeftVisibleBandIndexChanged;
end;

procedure TcxvgScroller.SetLeftVisibleRecord(
  Value: Integer);
var
  AOldValue: Integer;
begin
  AOldValue := LeftVisibleRecord;
  ScrollStrategy.LeftVisibleRecord := Value;
  if AOldValue <> LeftVisibleRecord then
    VerticalGrid.DoLeftVisibleRecordIndexChanged;
end;

procedure TcxvgScroller.SetTopVisibleRowIndex(Value: Integer);
var
  AOldValue: Integer;
begin
  AOldValue := TopVisibleRowIndex;
  ScrollStrategy.SetTopVisibleRowIndexAndBand(Value);
  if AOldValue <> TopVisibleRowIndex then
    VerticalGrid.DoTopRowIndexChanged;
end;

{ TcxCustomVerticalGrid }

constructor TcxCustomVerticalGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FCategoryFont := TFont.Create;
  FCategoryFont.Style := [fsBold];
  FCategoryFont.OnChange := CategoryFontChanged;
  SetBounds(Left, Top, 150, 200);
end;

destructor TcxCustomVerticalGrid.Destroy;
begin
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FCategoryFont);
  inherited Destroy;
end;

function TcxCustomVerticalGrid.Add(ARowClass: TcxCustomRowClass): TcxCustomRow;
begin
  CheckRowClass(ARowClass);
  Result := ARowClass.Create(Owner);
  Result.SetVerticalGrid(Self);
  FRows.Add(Result);
  LayoutChanged;
end;

function TcxCustomVerticalGrid.AddChild(AParent: TcxCustomRow;
  ARowClass: TcxCustomRowClass): TcxCustomRow;
begin
  if AParent = nil then
  begin
    Result := Add(ARowClass);
    Exit;
  end;
  CheckRowClass(ARowClass);
  Result := ARowClass.Create(Owner);
  Result.SetVerticalGrid(Self);
  FRows.AddChild(AParent, Result);
  LayoutChanged;
end;

procedure TcxCustomVerticalGrid.AssignRows(Source: TcxCustomVerticalGrid);
begin
  if Source <> nil then
    Rows.AssignRows(Source.Rows);
end;

procedure TcxCustomVerticalGrid.ClearRows;
begin
  FClearingRows := True;
  BeginUpdate;
  try
    DataController.BeginUpdateFields;
    try
      Controller.Clear;
      Rows.Clear;
    finally
      DataController.EndUpdateFields;
    end;
  finally
    EndUpdate;
    FClearingRows := False;
  end;
end;

function TcxCustomVerticalGrid.FirstRow: TcxCustomRow;
begin
  if HasRows then Result := FRootRow.Rows[0] else Result := nil;
end;

function TcxCustomVerticalGrid.FirstVisibleRow: TcxCustomRow;
var
  I: Integer;
begin
  Result := nil;
  Rows.CheckList;
  for I := 0 to FRootRow.Count - 1 do
    if FRootRow.Rows[I].Visible then
    begin
      Result := FRootRow.Rows[I];
      break;
    end;
end;

procedure TcxCustomVerticalGrid.FocusRow(ARow: TcxCustomRow;
  ACellIndex: Integer = 0);
begin
  with Controller do
  begin
    SetFocusedRowAndCell(ARow, ACellIndex);
    MakeFocusedItemVisible;
  end;  
end;

procedure TcxCustomVerticalGrid.FullCollapse;
var
  I: Integer;
begin
  if HasRows then
  begin
    BeginUpdate;
    try
      for I := 0 to FRootRow.Count - 1 do
        FRootRow.Rows[I].Collapse(True);
    finally
      EndUpdate;
    end;
  end
end;

procedure TcxCustomVerticalGrid.FullExpand;
begin
  if HasRows then
  begin
    BeginUpdate;
    try
      FRootRow.Expand(True);
    finally
      EndUpdate;
    end;
  end
end;

function TcxCustomVerticalGrid.HasRows: Boolean;
begin
  Result := FRootRow.Count > 0
end;

function TcxCustomVerticalGrid.HasVisibleRows: Boolean;
begin
  Result := FirstVisibleRow <> nil;
end;

function TcxCustomVerticalGrid.IsInternalDragging: Boolean;
begin
  Result := Controller.IsInternalDragging;
end;

function TcxCustomVerticalGrid.IsRowVisible(ARow: TcxCustomRow): Boolean;
begin
  Result := False;
  Rows.CheckList;
  if ARow.Visible then
    repeat
      ARow := ARow.FParent;
      if (ARow = FRootRow) then
      begin
        Result := True;
        Exit;
      end
      else
        if not (ARow.Expanded and ARow.Visible) then Exit;
    until False;
end;

function TcxCustomVerticalGrid.LastRow: TcxCustomRow;
begin
  if Rows.Count > 0 then
    Result := Rows.GetRow(Rows.Count - 1)
  else
    Result := nil;
end;

function TcxCustomVerticalGrid.LastVisibleRow: TcxCustomRow;
var
  I: Integer;
  ARow: TcxCustomRow;
begin
  Result := nil;
  for I := Rows.Count - 1 downto 0 do
  begin
    ARow := Rows.GetRow(I);
    if IsRowVisible(ARow) then
    begin
      Result := ARow;
      break;
    end;
  end;
end;

function TcxCustomVerticalGrid.NextRow(ARow: TcxCustomRow): TcxCustomRow;
var
  AIndex: Integer;
begin
  Rows.CheckList;
  if ARow = nil then
    Result := FirstRow
  else
  begin
    AIndex := Rows.FList.IndexOf(ARow) + 1;
    if (AIndex > 0) and (AIndex < Rows.Count) then
      Result := Rows[AIndex]
    else
      Result := nil;
  end;
end;

function TcxCustomVerticalGrid.NextVisibleRow(
  ARow: TcxCustomRow): TcxCustomRow;
var
  I, AIndex: Integer;
begin
  Rows.CheckList;
  if ARow = nil then
    Result := FirstVisibleRow
  else
  begin
    Result := nil;
    AIndex := Rows.FList.IndexOf(ARow) + 1;
    if AIndex > 0 then
      for I := AIndex to Rows.Count - 1 do
      begin
        ARow := Rows[I];
        if IsRowVisible(ARow) then
        begin
          Result := ARow;
          break;
        end;
      end;
  end;
end;

function TcxCustomVerticalGrid.PrevRow(ARow: TcxCustomRow): TcxCustomRow;
var
  AIndex: Integer;
begin
  Rows.CheckList;
  if ARow = nil then
    Result := LastRow
  else
  begin
    AIndex := Rows.FList.IndexOf(ARow);
    if (AIndex > 0) then Result := Rows[AIndex - 1] else Result := nil;
  end;
end;

function TcxCustomVerticalGrid.PrevVisibleRow(ARow: TcxCustomRow): TcxCustomRow;
var
  I, AIndex: Integer;
begin
  Rows.CheckList;
  if ARow = nil then
    Result := LastVisibleRow
  else
  begin
    Result := nil;
    AIndex := Rows.FList.IndexOf(ARow);
    if AIndex > 0 then
      for I := AIndex - 1 downto 0 do
      begin
        ARow := Rows[I];
        if IsRowVisible(ARow) then
        begin
          Result := ARow;
          break;
        end;
      end;
  end;
end;

procedure TcxCustomVerticalGrid.Remove(ARow: TcxCustomRow);
begin
  FreeAndNil(ARow);
end;

function TcxCustomVerticalGrid.RowByCaption(const ACaption: string): TcxCustomRow;

  function CheckCaption(ARow: TcxCustomRow): Boolean;
  var
    I: Integer;
  begin
    if ARow.FProperties is TcxCaptionRowProperties then
      with TcxCaptionRowProperties(ARow.FProperties) do
        Result := CompareText(Caption, ACaption) = 0
    else
    begin
      Result := False;
      if ARow.FProperties is TcxMultiEditorRowProperties then
        with TcxMultiEditorRowProperties(ARow.FProperties) do
          for I := 0 to Editors.Count - 1 do
            if CompareText(Editors[I].Caption, ACaption) = 0 then
            begin
              Result := True;
              break
            end;
    end;
  end;

var
  I: Integer;
  ARow: TcxCustomRow;
begin
  Result := nil;
  for I := 0 to Rows.Count - 1 do
  begin
    ARow := Rows[I];
    if CheckCaption(ARow) then
    begin
      Result := ARow;
      break;
    end;
  end;
end;

function TcxCustomVerticalGrid.RowByName(const AName: string): TcxCustomRow;
var
  I: Integer;
  ARow: TcxCustomRow;
begin
  Result := nil;
  for I := 0 to Rows.Count - 1 do
  begin
    ARow := Rows[I];
    if CompareText(ARow.Name, AName) = 0 then
    begin
      Result := ARow;
      break;
    end;
  end;
end;

procedure TcxCustomVerticalGrid.RestoreFromIniFile(const AStorageName: string);
var
  AStorage: TcxStorage;
begin
  FNewLoadMode := False;
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    BeforeLoadedRows;
    try
      AStorage.Modes := [smChildrenCreating];
      AStorage.RestoreFromIni(Self);
      AfterLoadedRows;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomVerticalGrid.RestoreFromRegistry(const AStorageName: string);
var
  AStorage: TcxStorage;
begin
  FNewLoadMode := False;
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    BeforeLoadedRows;
    try
      AStorage.Modes := [smChildrenCreating];
      AStorage.RestoreFromRegistry(Self);
      AfterLoadedRows;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomVerticalGrid.RestoreFromStream(AStream: TStream);
var
  AStorage: TcxStorage;
begin
  FNewLoadMode := False;
  AStorage := TcxStorage.Create(AStream);
  try
    BeginUpdate;
    BeforeLoadedRows;
    try
      AStorage.Modes := [smChildrenCreating];
      AStorage.RestoreFromStream(Self);
      AfterLoadedRows;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomVerticalGrid.StoreToIniFile(const AStorageName: string;
  AReCreate: Boolean = True);
var
  AStorage: TcxStorage;
begin
  FNewLoadMode := True;
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      AStorage.ReCreate := AReCreate;
      AStorage.StoreToIni(Self);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomVerticalGrid.StoreToRegistry(const AStorageName: string;
  AReCreate: Boolean = True);
var
  AStorage: TcxStorage;
begin
  FNewLoadMode := True;
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      AStorage.ReCreate := AReCreate;
      AStorage.StoreToRegistry(Self);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomVerticalGrid.StoreToStream(AStream: TStream);
var
  AStorage: TcxStorage;
begin
  FNewLoadMode := True;
  AStorage := TcxStorage.Create(AStream);
  try
    BeginUpdate;
    try
      AStorage.StoreToStream(Self);
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomVerticalGrid.CancelEdit;
begin
  Controller.EditingController.HideEdit(False);
end;

procedure TcxCustomVerticalGrid.HideEdit;
begin
  Controller.EditingController.HideEdit(True);
end;

procedure TcxCustomVerticalGrid.ShowEdit;
begin
  if not OptionsData.Editing then Exit;
  DataController.Edit;
  if CanFocusEx then SetFocus;
  Controller.EditingController.ShowEdit;
end;

procedure TcxCustomVerticalGrid.ShowEditByKey(AKey: Char);
begin
  if not OptionsData.Editing then Exit;
  DataController.Edit;
  if CanFocusEx then SetFocus;
  with Controller do
    EditingController.ShowEdit(FocusedItem, AKey);
end;

procedure TcxCustomVerticalGrid.ShowEditByMouse(X, Y: Integer; AShift: TShiftState);
begin
  if not OptionsData.Editing then Exit;
  DataController.Edit;
  if CanFocusEx then SetFocus;
  with Controller do
    EditingController.ShowEdit(FocusedItem, AShift, X, Y);
end;

procedure TcxCustomVerticalGrid.RestoreDefaults;
begin
  BeginUpdate;
  try
    OptionsBehavior.RestoreDefaults;
    OptionsView.RestoreDefaults;
    Rows.RestoreDefaults;
  finally
    EndUpdate;
  end;
  Modified;
end;

function TcxCustomVerticalGrid.GetObjectName: string;
begin
  if FStoringName <> '' then
    Result := FStoringName
  else
    Result := Name;
end;

function TcxCustomVerticalGrid.GetProperties(AProperties: TStrings): Boolean;
begin
  with AProperties do
  begin
    Add('PaintStyle');
    Add('HeaderWidth');
    Add('ValueWidth');
    Add('NewLoad');
  end;
  Result := True;
end;

procedure TcxCustomVerticalGrid.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  if AName = 'PaintStyle' then
    AValue := OptionsView.PaintStyle
  else
    if AName = 'HeaderWidth' then
      AValue := OptionsView.RowHeaderWidth
    else
      if AName = 'ValueWidth' then
        AValue := OptionsView.ValueWidth
      else
        if AName = 'NewLoad' then
          AValue := 1
        else
          AValue := Null;
end;

procedure TcxCustomVerticalGrid.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
  if AName = 'PaintStyle' then
    OptionsView.PaintStyle := AValue
  else
    if AName = 'HeaderWidth' then
      OptionsView.RowHeaderWidth := AValue
    else
      if AName = 'ValueWidth' then
        OptionsView.ValueWidth := AValue
      else
        if AName = 'NewLoad' then
          FNewLoadMode := True;
end;

function TcxCustomVerticalGrid.CreateChild(
  const AObjectName, AClassName: string): TObject;
var
  ARow: TcxCustomRow;
begin
  if CompareText(AClassName, 'TcxCategoryRow') = 0 then
  begin
    ARow := Add(TcxCategoryRow);
    ARow.Name := CreateUniqueName(Owner, Self, ARow, 'Tcx', 'RuntimeCreatedRow');
    Result := ARow;
  end
  else
    Result := nil;
end;

procedure TcxCustomVerticalGrid.DeleteChild(const AObjectName: string;
  AObject: TObject);
begin
end;

procedure TcxCustomVerticalGrid.GetStoredChildren(AChildren: TStringList);

  function GetStoredRowName(ARow: TcxCustomRow): string;
  begin
    if FNewLoadMode then
      Result := ARow.GetObjectName
    else
      Result := '';
  end;

var
  I: Integer;
begin
  with Rows do
    for I := 0 to Count - 1 do
      AChildren.AddObject(GetStoredRowName(Items[I]), Items[I])
end;

procedure TcxCustomVerticalGrid.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  DragCursor := FSaveDragCursor;
end;

procedure TcxCustomVerticalGrid.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Version', ReadVersion, WriteVersion, True);
end;

procedure TcxCustomVerticalGrid.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to Rows.Count - 1 do
    Proc(Rows[I]);
end;

procedure TcxCustomVerticalGrid.Loaded;
var
  ASaveLock: Boolean;
begin
  // need a lock for AutoScaleBands and changing visibility HScrollBar
  ASaveLock := ViewInfo.FLockDividerPos;
  ViewInfo.FLockDividerPos := True;
  try
    inherited Loaded;
    with OptionsBehavior do
      if not FAlwaysShowEditorAssigned then
        InternalSetAlwaysShowEditor(AlwaysShowEditor);
  finally
    ViewInfo.FLockDividerPos := ASaveLock;
    RestoreLayout;
    LayoutChanged;
  end;
end;

procedure TcxCustomVerticalGrid.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

function cxVerticalGridGetItem(ACaller: TComponent;
  Index: Integer): TComponent;
begin
  Result := TcxCustomVerticalGrid(ACaller).Rows[Index];
end;

procedure TcxCustomVerticalGrid.SetName(const Value: TComponentName);
var
  AOldName: TComponentName;
begin
  AOldName := Name;
  inherited SetName(Value);
  if (Name <> AOldName) and (Name <> '') then
  begin
    RenameComponents(Self, Owner, Name, AOldName, Rows.Count, @cxVerticalGridGetItem);
    if not IsLoading and (Rows.Count > 0) then
      LayoutChanged;
  end;
end;

procedure TcxCustomVerticalGrid.BoundsChanged;
begin
  CheckLayoutRealign;
  inherited BoundsChanged;
  CheckGridModeBufferCount;
end;

procedure TcxCustomVerticalGrid.FontChanged;
begin
  Inc(FLockUpdate);
  try
    inherited FontChanged;
    FCategoryFont.Assign(Font);
    FCategoryFont.Style := Font.Style + [fsBold];
  finally
    Dec(FLockUpdate);
    LayoutChanged;
  end;
end;

procedure TcxCustomVerticalGrid.InitControl;
begin
  ViewInfo.FLockDividerPos := False;
  inherited InitControl;
end;

procedure TcxCustomVerticalGrid.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  PaintStyleChanged;
end;

function TcxCustomVerticalGrid.GetDragObjectClass: TDragControlObjectClass;
begin
  Result := nil;
end;

procedure TcxCustomVerticalGrid.AfterLayoutChanged;
begin
  inherited AfterLayoutChanged;
  Controller.CheckEdit;
end;

procedure TcxCustomVerticalGrid.CreateSubClasses;
begin
  FRows := TcxVerticalGridRows.Create(Self);
  FRootRow := TcxCategoryRow.Create(nil);
  FRootRow.FParent := nil;
  FRootRow.FVerticalGrid := Self;
  FRootRow.FID := -1;
  inherited CreateSubClasses;
  InitDataController;
  FCustomizing := GetCustomizingClass.Create(Self);
end;

procedure TcxCustomVerticalGrid.DataChanged;
begin
  if FLockUpdate > 0 then Exit;
  Inc(FLockUpdate);
  try
    inherited DataChanged;
  finally
    Dec(FLockUpdate);
    LayoutChanged;
  end;
  Controller.MakeFocusedRecordVisible;
end;

procedure TcxCustomVerticalGrid.DestroySubClasses;
begin
  FreeAndNil(FCustomizing);
  FreeAndNil(FRootRow);
  FreeAndNil(FRows);
  inherited DestroySubClasses;
end;

procedure TcxCustomVerticalGrid.DoEdited(
  AItem: TcxCustomInplaceEditContainer);
begin
  if Assigned(FOnEdited) then
    FOnEdited(Self, TcxCellEdit(AItem).EditRowProperties);
end;

function TcxCustomVerticalGrid.DoEditing(
  AItem: TcxCustomInplaceEditContainer): Boolean;
begin
  Result := True;
  if Assigned(FOnEditing) then
    FOnEditing(Self, TcxCellEdit(AItem).EditRowProperties, Result);
end;

procedure TcxCustomVerticalGrid.DoEditValueChanged(
  AItem: TcxCustomInplaceEditContainer);
begin
  if Assigned(FOnEditValueChanged) then
    if AItem <> nil then
      FOnEditValueChanged(Self, TcxCellEdit(AItem).EditRowProperties)
    else
      FOnEditValueChanged(Self, nil);
end;

procedure TcxCustomVerticalGrid.DoInplaceEditContainerItemRemoved(
  AItem: TcxCustomInplaceEditContainer);
begin
  try
    ContainerList.Remove(AItem);
    DataController.RemoveItem(AItem);
    UpdateIndexes;
  finally
    if not (AItem.Owner is TcxCustomMultiEditorRow) then
    // for correct work with collection
      LayoutChanged;
  end;
end;

procedure TcxCustomVerticalGrid.DoLayoutChanged;
begin
  if csUpdating in ComponentState then Exit;
  ViewInfo.Calculate;
  if Customizing.Visible then
    Customizing.Update;
  if Assigned(FOnLayoutChanged) then
    FOnLayoutChanged(Self);
end;

function TcxCustomVerticalGrid.DragDropImageDisplayRect: TRect;
begin
  Result := DragHeaderInfo.HeaderCellsRect;
end;

procedure TcxCustomVerticalGrid.DrawDragDropImage(ADragBitmap: TBitmap;
  ACanvas: TcxCanvas);
var
  AHeaderInfo: TcxCustomRowHeaderInfo;
  ASaveCanvas: TcxCanvas;
  ASaveOrg: TPoint;
begin
  ASaveCanvas := Painter.FCanvas;
  AHeaderInfo := DragHeaderInfo;
  Painter.FCanvas := ACanvas;
  try
    ASaveOrg := ACanvas.WindowOrg;
    ACanvas.WindowOrg := AHeaderInfo.HeaderCellsRect.TopLeft;
    Painter.DrawHeaderDragImage(AHeaderInfo);
  finally
     ACanvas.WindowOrg := ASaveOrg;
     Painter.FCanvas := ASaveCanvas;
  end;
end;

function TcxCustomVerticalGrid.GetControllerClass: TcxCustomControlControllerClass;
begin
  Result := TcxvgController;
end;

function TcxCustomVerticalGrid.GetControlStylesClass: TcxCustomControlStylesClass;
begin
  Result := TcxVerticalGridStyles;
end;

function TcxCustomVerticalGrid.GetDragImageHelperClass: TcxDragImageHelperClass;
begin
  Result := TcxvgDragImageHelper;
end;

function TcxCustomVerticalGrid.GetEditCellDataBindingClass: TcxItemDataBindingClass;
begin
  Result := TcxItemDataBinding;
end;

function TcxCustomVerticalGrid.GetHitTestControllerClass: TcxHitTestControllerClass;
begin
  Result := TcxvgHitTest;
end;

function TcxCustomVerticalGrid.GetOptionsBehaviorClass: TcxControlOptionsBehaviorClass;
begin
  Result := TcxvgOptionsBehavior;
end;

function TcxCustomVerticalGrid.GetOptionsViewClass: TcxControlOptionsViewClass;
begin
  Result := TcxvgOptionsView;
end;

function TcxCustomVerticalGrid.GetPainterClass: TcxCustomControlPainterClass;
begin
  if OptionsView.PaintStyle = psdotNet then
    Result := TcxvgPainter
  else
    Result := TcxStyle3DPainter
end;

function TcxCustomVerticalGrid.HasDragDropImages: Boolean;
begin
  Result := DragHeaderInfo <> nil;
end;

function TcxCustomVerticalGrid.IsLocked: Boolean;
begin
  Result := inherited IsLocked or (DataController.LockCount > 0);
end;

procedure TcxCustomVerticalGrid.RecreateViewInfo;
begin
  if ViewInfo <> nil then
  begin
    HideEdit;
    Controller.SaveLayout;
    try
      inherited RecreateViewInfo;
    finally
      Controller.RestoreLayout;
    end;
  end
  else
    inherited RecreateViewInfo;
end;


function RowIndexCompare(Item1, Item2: Pointer): Integer;
begin
  Result := TcxCustomRow(Item1).FLoadedIndex - TcxCustomRow(Item2).FLoadedIndex;
end;

procedure TcxCustomVerticalGrid.RestoreLayout;
var
  I: Integer;
  L: TList;
begin
  if FVersion < cxVerticalGridStoringVersion then
  begin
    Modified;
    Exit;
  end;
  BeginUpdate;
  try
    L := TList.Create;
    try
      for I := 0 to Rows.Count - 1 do
        L.Add(Rows[I]);
      for I := 0 to L.Count - 1 do
        TcxCustomRow(L[I]).RestoreParent;
      if L.Count > 1 then
        L.Sort(RowIndexCompare);
      for I := 0 to L.Count - 1 do
        TcxCustomRow(L[I]).RestoreIndex;
    finally
      L.Free;
    end;
  finally
    CancelUpdate;
  end;
end;

procedure TcxCustomVerticalGrid.InitDataController;
begin
  DataController.AppendRecord;
  Controller.FocusedRecordIndex := 0;
end;

procedure TcxCustomVerticalGrid.PaintStyleChanged;
begin
    if ViewInfo <> nil then
      RecreateViewInfo;
    if Controller <> nil then
      Controller.UpdatePaintStyle;
end;

procedure TcxCustomVerticalGrid.RemoveRowFromVerticalGrid(ARow: TcxCustomRow);
begin
  Inc(FLockUpdate);
  try
    if not IsDestroying then
    begin
      if IsDesigning and (Controller.DesignSelectionHelper <> nil) then
        Controller.DesignSelectionHelper.UnselectObject(ARow);
      if ARow = FocusedRow then Controller.Clear;
    end;
    Rows.Remove(ARow);
    ARow.RemoveChildren;
  finally
    Dec(FLockUpdate);
  end;
  LayoutChanged;
end;

procedure TcxCustomVerticalGrid.AfterLoadedRows;

  procedure SetupIndexes(ARow: TcxCustomRow);
  var
    I, AIndex: Integer;
  begin
    if ARow.Count > 0 then
    begin
      AIndex := 0;
      repeat
        for I := AIndex to ARow.Count - 1 do
          if ARow.Rows[I].FLoadingIndex = AIndex then
          begin
            ARow.Rows[I].Index := AIndex;
            break;
          end;
        Inc(AIndex);
      until AIndex = ARow.Count;
      for I := 0 to ARow.Count - 1 do
        SetupIndexes(ARow.Rows[I]);
    end;
  end;

var
  L: TList;
  I: Integer;
  ARow: TcxCustomRow;
begin
  if not FNewLoadMode then Exit;
  L := TList.Create;
  try
    Rows.PrepareList;
    L.Assign(Rows.FList);
    for I := 0 to L.Count - 1 do
    begin
      ARow := L[I];
      if ARow.FLoadingIndex <> MaxInt then
        ARow.Parent := Rows.FindRowByStoredName(ARow.FLoadingParent);
    end;
    SetupIndexes(FRootRow);
  finally
    L.Free;
  end;
end;

procedure TcxCustomVerticalGrid.BeforeLoadedRows;
var
  I: Integer;
begin
  Rows.PrepareList;
  for I := 0 to Rows.Count - 1 do
    Rows[I].FLoadingIndex := MaxInt;
end;

function TcxCustomVerticalGrid.CanBandSizing: Boolean;
begin
  Result := OptionsBehavior.BandSizing and not OptionsView.AutoScaleBands;
end;

procedure TcxCustomVerticalGrid.CheckRowClass(ARowClass: TcxCustomRowClass);
begin
  if (ARowClass = nil) or not (ARowClass.InheritsFrom(GetEditorRowClass) or
    ARowClass.InheritsFrom(TcxCategoryRow) or ARowClass.InheritsFrom(GetMultiEditorRowClass)) then
    cxVerticalGridError(cxGetResourceString(@cxSvgInvalidRowClass));
end;

procedure TcxCustomVerticalGrid.CheckGridModeBufferCount;
var
  AIntf: IcxVerticalGridDBDataContoller;
begin
  if (DataController <> nil) and DataController.IsGridMode and
    DataController.GetInterface(IcxVerticalGridDBDataContoller, AIntf) then
      AIntf.CheckGridModeBufferCount;
end;

procedure TcxCustomVerticalGrid.CheckLayoutRealign;
begin
  if Assigned(Controller) then
    Controller.Scroller.CheckDecrease := True;
end;

procedure TcxCustomVerticalGrid.FreeRowsViewInfo;
var
  I: Integer;
begin
  if not IsDestroying then
  begin
    for I := 0 to Rows.Count - 1 do
      FreeAndNil(Rows[I].FViewInfo);
  end;
end;

procedure TcxCustomVerticalGrid.DoCustomizationVisibleChanged;
begin
  if Assigned(FOnCustomizationVisibleChanged) then
    FOnCustomizationVisibleChanged(Self);
end;

function TcxCustomVerticalGrid.DoDrawBackgroundPart(const R: TRect;
  const AViewParams: TcxViewParams): Boolean;
begin
  Result := False;
  if Assigned(FOnDrawBackground) then
    FOnDrawBackground(Self, TcxvgPainter(Painter).Canvas, R, AViewParams, Result);
end;

function TcxCustomVerticalGrid.DoDrawRowHeader(
  AHeaderViewInfo: TcxCustomRowHeaderInfo): Boolean;
begin
  Result := False;
  if Assigned(FOnDrawRowHeader) then
    FOnDrawRowHeader(Self, TcxvgPainter(Painter).Canvas, TcxvgPainter(Painter),
      AHeaderViewInfo, Result);
end;

function TcxCustomVerticalGrid.DoDrawValue(
  AValueInfo: TcxRowValueInfo): Boolean;
begin
  Result := False;
  if Assigned(FOnDrawValue) then
    FOnDrawValue(Self, TcxvgPainter(Painter).Canvas, TcxvgPainter(Painter),
      AValueInfo, Result);
end;

procedure TcxCustomVerticalGrid.DoItemChanged(AOldRow: TcxCustomRow;
  AOldCellIndex: Integer);
begin
  if Assigned(FOnItemChanged) then
    FOnItemChanged(Self, AOldRow, AOldCellIndex);
end;

procedure TcxCustomVerticalGrid.DoLeftVisibleBandIndexChanged;
begin
  if Assigned(FOnLeftVisibleBandIndexChanged) then
    FOnLeftVisibleBandIndexChanged(Self);
end;

procedure TcxCustomVerticalGrid.DoLeftVisibleRecordIndexChanged;
begin
  if Assigned(FOnLeftVisibleRecordIndexChanged) then
    FOnLeftVisibleRecordIndexChanged(Self);
end;

procedure TcxCustomVerticalGrid.DoTopRowIndexChanged;
begin
  if Assigned(FOnTopRowIndexChanged) then
    FOnTopRowIndexChanged(Self);
end;

function TcxCustomVerticalGrid.GetCalcHelperClass: TcxvgCustomPaintStyleCalcHelperClass;
begin
  if LookAndFeel.SkinPainter <> nil then
    Result := TcxvgSkinCalcHelper
  else
  if OptionsView.PaintStyle = psDotNet then
    Result := TcxvgDotNetStyleCalcHelper
  else
    Result := TcxvgStyle3DCalcHelper
end;

function TcxCustomVerticalGrid.GetCellAutoHeight: Boolean;
begin
  Result := OptionsView.CellAutoHeight;
end;

function TcxCustomVerticalGrid.GetCustomizingClass: TcxVerticalGridCustomizingClass;
begin
  Result := TcxVerticalGridCustomizing;
end;

procedure TcxCustomVerticalGrid.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);

  function CalcHelper: TcxvgCustomPaintStyleCalcHelper;
  begin
    Result := ViewInfo.CalcHelper;
  end;

begin
  with AParams do
  begin
    Font := Self.Font;
    TextColor := Font.Color;
    Bitmap := nil;
    case Index of
      vgs_Content:
        begin
          Color := CalcHelper.GetContentColor(PcxvgContentParamsData(AData)^.Focused);
          TextColor := CalcHelper.GetContentTextColor;
        end;
      vgs_Header:
        begin
          Color := CalcHelper.GetHeaderColor;
          TextColor := CalcHelper.GetHeaderTextColor;
        end;
      vgs_Category:
        begin
          Font := FCategoryFont;
          Color := CalcHelper.GetCategoryColor;
          TextColor := CalcHelper.GetCategoryTextColor;
        end;
      vgs_IncSearch:
        begin
          Color := clDefault;
          TextColor := clDefault;
        end;
      ecs_Background:
        begin
          Color := CalcHelper.GetBackgroundColor;
          with Styles do
            if (Background <> nil) and (Background.Bitmap <> nil) and not Background.Bitmap.Empty then
              Bitmap := Background.Bitmap;
        end;
    else
      Styles.CallInheritedDefaultViewParams(Index, nil, AParams);
    end;
  end;
end;

function TcxCustomVerticalGrid.GetEditorRowClass: TcxCustomRowClass;
begin
  Result := TcxEditorRow;
end;

function TcxCustomVerticalGrid.GetMultiEditorRowClass: TcxCustomRowClass;
begin
  Result := TcxMultiEditorRow;
end;

procedure TcxCustomVerticalGrid.RowsChanged;
begin
  CheckLayoutRealign;
  LayoutChanged;
end;

procedure TcxCustomVerticalGrid.UpdateDesignEditor;
begin
  LayoutChanged;
  if not IsLocked then
    Modified;
end;

procedure TcxCustomVerticalGrid.CategoryFontChanged(Sender: TObject);
begin
  LayoutChanged;
end;

function TcxCustomVerticalGrid.GetController: TcxvgController;
begin
  Result := TcxvgController(FController)
end;

function TcxCustomVerticalGrid.GetDragHeaderInfo: TcxCustomRowHeaderInfo;
begin
  with Controller do
    if DragRow <> nil then
      Result := DragRow.ViewInfo.HeaderInfo
    else
      Result := nil;
end;

function TcxCustomVerticalGrid.GetFocusedRow: TcxCustomRow;
begin
  Result := Controller.FocusedRow;
end;

function TcxCustomVerticalGrid.GetHitTest: TcxvgHitTest;
begin
  Result := TcxvgHitTest(Controller.HitTestController);
end;

function TcxCustomVerticalGrid.GetInplaceEditor: TcxCustomEdit;
begin
  if IsEditing then
    Result := Controller.EditingController.Edit
  else
    Result := nil;
end;

function TcxCustomVerticalGrid.GetIsEditing: Boolean;
begin
  Result := Controller.IsEditing;
end;

function TcxCustomVerticalGrid.GetLeftVisibleBand: Integer;
begin
  Result := Controller.Scroller.LeftVisibleBand;
end;

function TcxCustomVerticalGrid.GetLeftVisibleRecord: Integer;
begin
  Result := Controller.Scroller.LeftVisibleRecord;
end;

function TcxCustomVerticalGrid.GetOptionsBehavior: TcxvgOptionsBehavior;
begin
  Result := TcxvgOptionsBehavior(inherited OptionsBehavior);
end;

function TcxCustomVerticalGrid.GetOptionsView: TcxvgOptionsView;
begin
  Result := TcxvgOptionsView(inherited OptionsView);
end;

function TcxCustomVerticalGrid.GetPainter: TcxvgPainter;
begin
  Result := TcxvgPainter(inherited Painter);
end;

function TcxCustomVerticalGrid.GetRecordCount: Integer;
begin
  Result := DataController.RowCount;
end;

function TcxCustomVerticalGrid.GetStyles: TcxVerticalGridStyles;
begin
  Result := TcxVerticalGridStyles(inherited Styles);
end;

function TcxCustomVerticalGrid.GetTopVisibleRowIndex: Integer;
begin
  Result := Controller.Scroller.TopVisibleRowIndex;
end;

function TcxCustomVerticalGrid.GetViewInfo: TcxvgCustomViewInfo;
begin
  Result := TcxvgCustomViewInfo(inherited ViewInfo);
end;

procedure TcxCustomVerticalGrid.ImageListChange(Sender: TObject);
begin
  if HandleAllocated and (Sender = Images) then
    LayoutChanged;
end;

procedure TcxCustomVerticalGrid.SetFocusedRow(Value: TcxCustomRow);
begin
  with Controller do
  begin
    FocusedRow := Value;
    MakeRowVisible(FocusedRow);
  end;
end;

procedure TcxCustomVerticalGrid.SetImages(Value: TCustomImageList);
begin
  BeginUpdate;
  try
    cxSetImageList(Value, FImages, FImageChangeLink, Self);
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomVerticalGrid.SetLeftVisibleBand(Value: Integer);
begin
  Controller.Scroller.LeftVisibleBand := Value;
end;

procedure TcxCustomVerticalGrid.SetLeftVisibleRecord(Value: Integer);
begin
  Controller.Scroller.LeftVisibleRecord := Value;
end;

procedure TcxCustomVerticalGrid.SetOptionsBehavior(Value: TcxvgOptionsBehavior);
begin
  OptionsBehavior.Assign(Value);
end;

procedure TcxCustomVerticalGrid.SetOptionsView(Value: TcxvgOptionsView);
begin
  OptionsView.Assign(Value);
end;

procedure TcxCustomVerticalGrid.SetStyles(Value: TcxVerticalGridStyles);
begin
  Styles.Assign(Value);
end;

procedure TcxCustomVerticalGrid.SetTopVisibleRowIndex(Value: Integer);
begin
  Controller.Scroller.TopVisibleRowIndex := Value;
end;

procedure TcxCustomVerticalGrid.CMDrag(var Message: TCMDrag);
const
  AcceptedCursors: array[Boolean] of TCursor = (crDrag, crDragCopy);
begin
  if Controller.DragRow = nil then
    DragCursor := AcceptedCursors[IsCtrlPressed];
  inherited;
end;

procedure TcxCustomVerticalGrid.ReadVersion(Reader: TReader);
begin
  FVersion := Reader.ReadInteger;
end;

procedure TcxCustomVerticalGrid.WriteVersion(Writer: TWriter);
begin
  Writer.WriteInteger(cxVerticalGridStoringVersion);
end;

{ TcxUnboundVerticalGrid }

constructor TcxUnboundVerticalGrid.Create(AOwner: TComponent);
begin
  FLayoutStyle := ulsSingleRecordView;
  inherited Create(AOwner);
end;

function TcxUnboundVerticalGrid.CanBandSizing: Boolean;
begin
  Result := (FLayoutStyle <> ulsSingleRecordView) and inherited CanBandSizing;
end;

function TcxUnboundVerticalGrid.GetScrollStrategyClass: TcxvgCustomScrollStrategyClass;
begin
  if FLayoutStyle = ulsSingleRecordView then
    Result := TcxvgSingleRecordScrollStrategy
  else
    Result := TcxvgBandsScrollStrategy;
end;

function TcxUnboundVerticalGrid.GetViewInfoClass: TcxCustomControlViewInfoClass;
begin
  if FLayoutStyle = ulsSingleRecordView then
    Result := TcxInspectorViewInfo
  else
    Result := TcxBandsViewInfo;
end;

procedure TcxUnboundVerticalGrid.SetLayoutStyle(Value: TcxvgUnboundLayoutStyle);
begin
  if FLayoutStyle <> Value then
  begin
    FLayoutStyle := Value;
    RecreateViewInfo;
    ViewInfo.LayoutStyleChanged;
  end;
end;

{ TcxVirtualVerticalGrid }

constructor TcxVirtualVerticalGrid.Create(AOwner: TComponent);
begin
  FLayoutStyle := lsSingleRecordView;
  inherited Create(AOwner);
end;

procedure TcxVirtualVerticalGrid.Assign(Source: TPersistent);
begin
  if Source is TcxVirtualVerticalGrid then
    with TcxVirtualVerticalGrid(Source) do
    begin
      Self.BeginUpdate;
      inherited Assign(Source);
      try
        Self.LayoutStyle := LayoutStyle;
      finally
        Self.EndUpdate;
      end;
    end
  else
    inherited Assign(Source);
end;

function TcxVirtualVerticalGrid.GetFilterCaption(Index: Integer): string;
var
  AElement: TcxCustomEditorRowProperties;
begin
  AElement := GetFilterElementProperties(Index);
  if AElement = nil then
    Result := ''
  else
    Result := AElement.Caption;
end;

function TcxVirtualVerticalGrid.GetFilterCount: Integer;
var
  I, J: Integer;
  ARow: TcxCustomRow;
  AEditContainer: TcxCellEdit;
begin
  Result := 0;
  for I := 0 to Rows.Count - 1 do
  begin
    ARow := Rows[I];
    for J := 0 to ARow.GetEditContainerCount - 1 do
    begin
      AEditContainer := ARow.GetEditContainer(J);
      if TcxEditorRowPropertiesOptions(AEditContainer.Options).Filtering and
        (esoFiltering in AEditContainer.PropertiesValue.GetSupportedOperations) then
          Inc(Result);
    end;
  end;
end;

function TcxVirtualVerticalGrid.GetFilterCriteria: TcxFilterCriteria;
begin
  Result := DataController.Filter;
end;

function TcxVirtualVerticalGrid.GetFilterFieldName(Index: Integer): string;
begin
  Result := '';
end;

function TcxVirtualVerticalGrid.GetFilterItemLink(Index: Integer): TObject;
var
  AElement: TcxCustomEditorRowProperties;
begin
  AElement := GetFilterElementProperties(Index);
  if AElement = nil then
    Result := nil
  else
    Result := TObject(AElement.FEditContainer);
end;

function TcxVirtualVerticalGrid.GetFilterItemLinkID(Index: Integer): Integer;
var
  AElement: TcxCustomEditorRowProperties;
begin
  AElement := GetFilterElementProperties(Index);
  if AElement = nil then
    Result := -1
  else
    Result := AElement.FEditContainer.ItemIndex;
end;

function TcxVirtualVerticalGrid.GetItemLinkName(Index: Integer): string;
var
  AElement: TcxCustomEditorRowProperties;
begin
  AElement := GetFilterElementProperties(Index);
  if AElement = nil then
    Result := ''
  else
    Result := 'Item' + IntToStr(AElement.ID);
end;

function TcxVirtualVerticalGrid.GetFilterProperties(Index: Integer): TcxCustomEditProperties;
var
  AElement: TcxCustomEditorRowProperties;
begin
  AElement := GetFilterElementProperties(Index);
  if AElement = nil then
    Result := nil
  else
    Result := AElement.FEditContainer.PropertiesValue;
end;

function TcxVirtualVerticalGrid.GetFilterValueType(Index: Integer): TcxValueTypeClass;
var
  AElement: TcxCustomEditorRowProperties;
begin
  AElement := GetFilterElementProperties(Index);
  if AElement = nil then
    Result := nil
  else
    Result := AElement.FEditContainer.GetEditDataValueTypeClass;
end;

function TcxVirtualVerticalGrid.NavigatorCanAppend: Boolean;
begin
  Result := Controller.CanAppend(True);
end;

function TcxVirtualVerticalGrid.NavigatorCanDelete: Boolean;
begin
  Result := Controller.CanDelete(True);
end;

function TcxVirtualVerticalGrid.NavigatorCanEdit: Boolean;
begin
  Result := OptionsData.Editing;
end;

function TcxVirtualVerticalGrid.NavigatorCanInsert: Boolean;
begin
  Result := Controller.CanInsert(True);
end;

function TcxVirtualVerticalGrid.NavigatorIsActive: Boolean;
begin
  Result := DataController.Active;
end;

function TcxVirtualVerticalGrid.NavigatorIsBof: Boolean;
begin
  Result := DataController.IsBOF;
end;

function TcxVirtualVerticalGrid.NavigatorIsBookmarkAvailable: Boolean;
begin
  Result := DataController.IsBookmarkAvailable;
end;

function TcxVirtualVerticalGrid.NavigatorIsEditing: Boolean;
begin
  Result := DataController.IsEditing;
end;

function TcxVirtualVerticalGrid.NavigatorIsEof: Boolean;
begin
  Result := DataController.IsEOF;
end;

procedure TcxVirtualVerticalGrid.NavigatorClearBookmark;
begin
  DataController.ClearBookmark;
end;

procedure TcxVirtualVerticalGrid.NavigatorDoAction(AButtonIndex: Integer);
begin
  with DataController do
    case AButtonIndex of
      NBDI_FIRST:
        GotoFirst;
      NBDI_PRIORPAGE:
        if LayoutStyle = lsMultiRecordView then
          MoveBy(-Controller.Scroller.VisibleValueCount)
        else
          GotoPrev;
      NBDI_PRIOR:
        GotoPrev;
      NBDI_NEXT:
        GotoNext;
      NBDI_NEXTPAGE:
        if LayoutStyle = lsMultiRecordView then
          MoveBy(Controller.Scroller.VisibleValueCount)
        else
          GotoNext;
      NBDI_LAST:
        GotoLast;
      NBDI_APPEND:
        Controller.AppendRecord;
      NBDI_INSERT:
        Controller.InsertRecord;
      NBDI_DELETE:
        Controller.DeleteSelection;
      NBDI_EDIT:
        ShowEdit;
      NBDI_POST:
        begin
          PostEditingData;
          Post;
        end;
      NBDI_CANCEL:
        Cancel;
      NBDI_REFRESH:
        Refresh;
      NBDI_SAVEBOOKMARK:
        SaveBookmark;
      NBDI_GOTOBOOKMARK:
        GotoBookmark;
      NBDI_FILTER:
        DoFilterDialog;
    end;
end;

function TcxVirtualVerticalGrid.NavigatorGetNotifier: TcxNavigatorControlNotifier;
begin
  Result := FNavigatorNotifier;
end;

function TcxVirtualVerticalGrid.NavigatorIsActionSupported(
  AButtonIndex: Integer): Boolean;
begin
  Result := AButtonIndex in [NBDI_FIRST..NBDI_FILTER];
end;

procedure TcxVirtualVerticalGrid.RefreshNavigators;
begin
  if not IsDestroying then FNavigatorNotifier.RefreshNavigatorButtons;
end;

procedure TcxVirtualVerticalGrid.CreateSubClasses;
begin
  inherited CreateSubClasses;
  FNavigatorNotifier := TcxNavigatorControlNotifier.Create;
end;

procedure TcxVirtualVerticalGrid.DestroySubClasses;
begin
  FreeAndNil(FNavigatorNotifier);
  inherited DestroySubClasses;
end;

function TcxVirtualVerticalGrid.CanBandSizing: Boolean;
begin
  Result := OptionsBehavior.BandSizing and
    ((FLayoutStyle = lsMultiRecordView) or
    ((FLayoutStyle = lsBandsView) and not OptionsView.AutoScaleBands));
end;

procedure TcxVirtualVerticalGrid.ControlUpdateData(AInfo: TcxUpdateControlInfo);
begin
  if IsDestroying then Exit;
  inherited ControlUpdateData(AInfo);
  if (AInfo is TcxSearchChangedInfo) then
    Controller.RefreshIncSearchItem;
  RefreshNavigators;
end;

procedure TcxVirtualVerticalGrid.DoFilterDialog;
begin
  ExecuteFilterControlDialog(Self, LookAndFeel, ApplyFilter, OnFilterControlDialogShow);
end;

procedure TcxVirtualVerticalGrid.DoFocusedRecordChanged(
  APrevFocusedRecord, AFocusedRecord: Integer);
begin
  if Assigned(FOnFocusedRecordChanged) then
    FOnFocusedRecordChanged(Self, APrevFocusedRecord, AFocusedRecord);
end;

function TcxVirtualVerticalGrid.GetCellAutoHeight: Boolean;
begin
  Result := (FLayoutStyle <> lsMultiRecordView) and inherited GetCellAutoHeight;
end;

function TcxVirtualVerticalGrid.GetControllerClass: TcxCustomControlControllerClass;
begin
  Result := TcxvgMultiRecordsController;
end;

function TcxVirtualVerticalGrid.GetOptionsBehaviorClass: TcxControlOptionsBehaviorClass;
begin
  Result := TcxvgMultiRecordsOptionsBehavior;
end;

function TcxVirtualVerticalGrid.GetOptionsDataClass: TcxControlOptionsDataClass;
begin
  Result := TcxvgMultiRecordsOptionsData;
end;

function TcxVirtualVerticalGrid.GetOptionsViewClass: TcxControlOptionsViewClass;
begin
  Result := TcxvgMultiRecordsOptionsView;
end;

procedure TcxVirtualVerticalGrid.InitDataController;
begin
end;

procedure TcxVirtualVerticalGrid.DataLayoutChanged;
begin
  if not DataController.IsGridMode then
    inherited DataLayoutChanged
  else
    LayoutChanged;
end;

function TcxVirtualVerticalGrid.GetScrollStrategyClass: TcxvgCustomScrollStrategyClass;
begin
  case FLayoutStyle of
    lsSingleRecordView: Result := TcxvgSingleRecordScrollStrategy;
    lsBandsView: Result := TcxvgBandsScrollStrategy;
  else
    Result := TcxvgMultiRecordsScrollStrategy;
  end;
end;

function TcxVirtualVerticalGrid.GetViewInfoClass: TcxCustomControlViewInfoClass;
begin
  case FLayoutStyle of
    lsSingleRecordView: Result := TcxInspectorViewInfo;
    lsBandsView: Result := TcxBandsViewInfo;
  else
    Result := TcxMultiRecordViewInfo;
  end;
end;

procedure TcxVirtualVerticalGrid.ApplyFilter(Sender: TObject);
begin
  DataController.Filter.Active := True;
end;

function TcxVirtualVerticalGrid.GetFilterElementProperties(
  AIndex: Integer): TcxCustomEditorRowProperties;
var
  I, J, K: Integer;
  ARow: TcxCustomRow;
  AEditContainer: TcxCellEdit;
begin
  K := 0;
  Result := nil;
  for I := 0 to Rows.Count - 1 do
  begin
    ARow := Rows[I];
    for J := 0 to ARow.GetEditContainerCount - 1 do
    begin
      AEditContainer := ARow.GetEditContainer(J);
      if TcxEditorRowPropertiesOptions(AEditContainer.Options).Filtering and
        (esoFiltering in AEditContainer.PropertiesValue.GetSupportedOperations) then
      begin
        if K = AIndex then
        begin
          Result := AEditContainer.FEditRowProperties;
          Exit;
        end;
        Inc(K);
      end;
    end;
  end;
end;

function TcxVirtualVerticalGrid.GetFilterRecordEvent: TcxDataFilterRecordEvent;
begin
  Result := DataController.OnFilterRecord;
end;

function TcxVirtualVerticalGrid.GetFocusedRecordIndex: Integer;
begin
  Result := DataController.FocusedRowIndex;
end;

function TcxVirtualVerticalGrid.GetController: TcxvgMultiRecordsController;
begin
  Result := TcxvgMultiRecordsController(FController);
end;

function TcxVirtualVerticalGrid.GetOptionsBehavior: TcxvgMultiRecordsOptionsBehavior;
begin
  Result := TcxvgMultiRecordsOptionsBehavior(inherited OptionsBehavior);
end;

function TcxVirtualVerticalGrid.GetOptionsData: TcxvgMultiRecordsOptionsData;
begin
  Result := TcxvgMultiRecordsOptionsData(inherited OptionsData);
end;

function TcxVirtualVerticalGrid.GetOptionsView: TcxvgMultiRecordsOptionsView;
begin
  Result := TcxvgMultiRecordsOptionsView(inherited OptionsView);
end;

procedure TcxVirtualVerticalGrid.SetFilterRecordEvent(
  Value: TcxDataFilterRecordEvent);
begin
  DataController.OnFilterRecord := Value;
end;

procedure TcxVirtualVerticalGrid.SetFocusedRecordIndex(Value: Integer);
begin
  DataController.FocusedRowIndex := Value;
end;

procedure TcxVirtualVerticalGrid.SetLayoutStyle(Value: TcxvgLayoutStyle);
begin
  if FLayoutStyle <> Value then
  begin
    FLayoutStyle := Value;
    RecreateViewInfo;
    ViewInfo.LayoutStyleChanged;
    CheckGridModeBufferCount;
  end;
end;

procedure TcxVirtualVerticalGrid.SetOptionsBehavior(
  Value: TcxvgMultiRecordsOptionsBehavior);
begin
  inherited OptionsBehavior.Assign(Value);
end;

procedure TcxVirtualVerticalGrid.SetOptionsData(
  Value: TcxvgMultiRecordsOptionsData);
begin
  inherited OptionsData.Assign(Value);
end;

procedure TcxVirtualVerticalGrid.SetOptionsView(
  Value: TcxvgMultiRecordsOptionsView);
begin
  inherited OptionsView.Assign(Value);
end;

{ TcxvgHitTest }

function TcxvgHitTest.AllowDesignMouseEvents(X, Y: Integer;
  AShift: TShiftState): Boolean;
begin
  // we must use GetAsyncKeyState
  if (GetAsyncKeyState(VK_CONTROL) < 0) or (GetAsyncKeyState(VK_MENU) < 0) then
  begin
    Result := False;
    Exit;
  end;
  RecalculateOnMouseEvent(X, Y, AShift);
  Result := (VerticalGrid.DragAndDropState <> ddsNone) or CanSizing or
    HitAtRowHeader;
end;

procedure TcxvgHitTest.CalcBandsHitTest(AViewInfo: TcxvgCustomViewInfo);
var
  I: Integer;
  R, CR: TRect;
  ABandSizing, AHasDivider: Boolean;
begin
  with AViewInfo do
  begin
    ABandSizing := VerticalGrid.CanBandSizing;
    AHasDivider := (VerticalGrid.OptionsBehavior.HeaderSizing or
      VerticalGrid.IsDesigning) and ShowHeaders;
    CR := ClientRect;
    for I := 0 to ViewRects.BandRects.Count - 1 do
    begin
      R := ViewRects.BandRects[I];
      if AHasDivider and (I = 0) then
      begin
        // calc divider pos
        CR.Left  := R.Left  + ViewHeaderWidth;
        CR.Right := CR.Left + DividerWidth + 2;
        if Check(CR) then SetHitState(vghc_HitAtDivider, True);
      end;
      // calc first band right side
      if (I = 0) and ABandSizing and Check(GetBandSizeableRect(R)) then
        SetHitState(vghc_HitAtBandSizing, True);
      if Check(R) then
      begin
        FHitBandIndex := I;
        break;
      end;
    end;
  end;
  CalcRowsHitTest(AViewInfo);
end;

function TcxvgHitTest.CalcCustomizingHitTest: Boolean;
begin
  Result := False;
  with VerticalGrid.Customizing do
  begin
    if not Visible then Exit;
    Result := CanDrop(VerticalGrid.ClientToScreen(HitPoint));
    if Result then
      SetHitState(vghc_HitAtCustomize, True);
  end;
end;

function TcxvgHitTest.CalcRowHeaderHitTest(
  AHeaderInfo: TcxCustomRowHeaderInfo): Boolean;
var
  I: Integer;
  ACaptionInfo: TcxRowCaptionInfo;
begin
  with AHeaderInfo do
  begin
    Result := Check(HeaderRect);
    if not Result then Exit;
    if Check(FButtonRect) then
      SetHitState(vghc_HitAtButton, True)
    else
      if Check(FHeaderCellsRect) then
        for I := 0 to CaptionsInfo.Count - 1 do
        begin
          ACaptionInfo := CaptionsInfo[I];
          with ACaptionInfo do
          begin
            if Check(FImageRect) then
            begin
              FHitCellIndex := I;
              SetHitState(vghc_HitAtImage, True);
            end
            else
              if Check(FCaptionRect) then
              begin
                FNewHitTestItem := ACaptionInfo;
                FHitCellIndex := I;
                SetHitState(vghc_HitAtCaption, True);
              end;
          end;
        end
      else
        SetHitState(vghc_HitAtIndent, True);
  end;
end;

function TcxvgHitTest.CalcRowHitTest(
  ARowViewInfo: TcxCustomRowViewInfo): Boolean;
begin
  with ARowViewInfo do
  begin
    with RowRect do
      Result := Check(cxRect(Left, Top, Right,
        Bottom + TcxvgCustomViewInfo(ViewInfo).HorzLineWidth));
    if not Result then Exit;
    FHitRow := Row;
    if not CalcRowHeaderHitTest(HeaderInfo) and Check(ValuesRect) then
      CalcRowValuesHitTest(ARowViewInfo)
  end;
end;

procedure TcxvgHitTest.CalcRowValuesHitTest(
  ARowViewInfo: TcxCustomRowViewInfo);
var
  I: Integer;
  AValueInfo: TcxRowValueInfo;
  AUseValue: Boolean;
begin
  AUseValue := TcxvgController(Controller).ResizeKind = rkNone;
  with ARowViewInfo do
    for I := 0 to ValuesInfo.Count - 1 do
    begin
      AValueInfo := ValuesInfo[I];
      if Check(AValueInfo.VisibleRect) then
      begin
        if AUseValue then
        begin
          FNewHitTestItem := AValueInfo;
          FHitCellIndex := AValueInfo.RowCellIndex;
        end;
        SetHitState(vghc_HitAtValue, True);
        break;
      end;
    end;
end;

procedure TcxvgHitTest.CalcRowsHitTest(
  AViewInfo: TcxvgCustomViewInfo);
var
  I: Integer;
  ARowSizing: Boolean;
  ARowViewInfo: TcxCustomRowViewInfo;
begin
  with AViewInfo do
  begin
    ARowSizing := VerticalGrid.OptionsBehavior.RowSizing;
    for I := 0 to RowsViewInfo.Count - 1 do
    begin
      ARowViewInfo := RowsViewInfo[I];
      if ARowSizing and ARowViewInfo.Row.Options.CanResized then
        with ARowViewInfo.RowRect do
          if Check(cxRect(Left, Bottom - 1, Right, Min(Bottom + 1,
            ClientRect.Bottom))) then
          begin
            FHitRow := ARowViewInfo.Row;
            SetHitState(vghc_HitAtRowSizing, True);
            Exit;
          end;
      if CalcRowHitTest(ARowViewInfo) then Exit;
    end;
    SetHitState(vghc_HitAtEmpty, True);
  end;
end;

function TcxvgHitTest.CanMoving: Boolean;
var
  ADirection: TcxDragSizingDirection;
begin
  Result := ((VerticalGrid.DragMode = dmAutomatic)) and (HitRow <> nil) and
    HitRow.Options.Moving and HitAtCaption and not CanSizing(ADirection);
end;

function TcxvgHitTest.CanSizing: Boolean;
var
  ADirection: TcxDragSizingDirection;
begin
  Result := CanSizing(ADirection);
end;

function TcxvgHitTest.CanSizing(var ASizeDirection: TcxDragSizingDirection): Boolean;
begin
  Result := HitAtRowSizing or HitAtBandSizing or HitAtDivider;
  if not Result then Exit;
  if HitAtRowSizing then
    ASizeDirection := dsdVert
  else
    ASizeDirection := dsdHorz;
end;

function TcxvgHitTest.Check(const ARect: TRect): Boolean;
begin
  Result := cxRectPtIn(ARect, HitPoint);
end;

procedure TcxvgHitTest.DoCalculate;
begin
  FHitRow := nil;
  FNewHitTestItem := nil;
  FHitBandIndex := -1;
  FHitCellIndex := -1;
  FHitState := FHitState and 3;
  FHitInControl := Check(VerticalGrid.ClientBounds);
  if not CalcCustomizingHitTest and FHitInControl then
    CalcBandsHitTest(VerticalGrid.ViewInfo);
  HitTestItem := FNewHitTestItem;
end;

function TcxvgHitTest.GetCurrentCursor: TCursor;
var
  ADirection: TcxDragSizingDirection;
const
  ACursors: array[TcxDragSizingDirection] of TCursor = (crHSplit, crVSplit);
begin
  Result := inherited GetCurrentCursor;
  if (VerticalGrid.DragAndDropState <> ddsNone) and
    not (VerticalGrid.DragAndDropObject is TcxSizingDragAndDropObject) then Exit;
  if Result = crDefault then
    if CanSizing(ADirection) then Result := ACursors[ADirection];
end;

function TcxvgHitTest.GetState(Index: Integer): Boolean;
begin
  Result := (FHitState and (1 shl Index)) <> 0;
end;

procedure TcxvgHitTest.SetHitState(Index: Integer; Value: Boolean);
begin
  if Value then
    FHitState := FHitState or (1 shl Index)
  else
    FHitState := FHitState and not (1 shl Index);
end;

function TcxvgHitTest.GetHitAtRowHeader: Boolean;
begin
  Result := HitAtCaption or HitAtIndent or HitAtImage or HitAtButton;
end;

function TcxvgHitTest.GetVerticalGrid: TcxCustomVerticalGrid;
begin
  // reduce calls
  Result := TcxCustomVerticalGrid(TcxvgController(Controller).EditingControl);
end;

{ TcxvgCellNavigator }

constructor TcxvgCellNavigator.Create(AController: TcxCustomControlController);
begin
  inherited Create(AController);
  DownOnTab := True;
  DownOnEnter := True;
end;

procedure TcxvgCellNavigator.FocusNextCell(AForward, ANextRow: Boolean;
  AShift: TShiftState = []);
var
  APrevRowIndex, APrevCellIndex, ARowIndex, ACellIndex: Integer;

  function IsValidCellIndex(ACount: Integer): Boolean;
  begin
    Result := cxInRange(ACellIndex, 0, ACount - 1) or
      (MayFocusedEmptyRow(ARowIndex) and (ACount = 0));
  end;

begin
  Init(APrevRowIndex, APrevCellIndex, RowCount);
  ARowIndex := APrevRowIndex;
  ACellIndex := APrevCellIndex;
  if ANextRow then
    CalcNextRow(AForward, ARowIndex, ACellIndex)
  else
    ACellIndex := APrevCellIndex + cxIntOffs[AForward];
  SelectCell(AForward, ANextRow, ARowIndex, ACellIndex);
  if (ACellIndex < 0) and FindNextRecord(False) then
    ACellIndex := GetContainerCount(ARowIndex) - 1;
  if not IsValidCellIndex(Count[ARowIndex]) then
  begin
    ACellIndex := APrevCellIndex;
    ARowIndex := APrevRowIndex;
  end;
  if (ARowIndex <> APrevRowIndex) or (ACellIndex <> APrevCellIndex) then
    SetFocusCell(ARowIndex, ACellIndex, AShift);
end;

procedure TcxvgCellNavigator.CalcNextRow(AForward: Boolean;
  var ARowIndex, ACellIndex: Integer);

  function CanCellTabStop(ARowIndex, AIndex: Integer): Boolean;
  var
    ACell: TcxCellEdit;
  begin
    ACell := TcxCellEdit(GetCellContainer(ARowIndex, AIndex));
    Result := (ACell <> nil) and ACell.CanFocus;
    if Result then
    begin
      if ACell.Options is TcxMultiEditorRowPropertiesOptions then
        Result := TcxMultiEditorRowPropertiesOptions(ACell.Options).TabStop;
    end;
  end;

  function NavigateMultiEditorRow(var AIndex: Integer): Boolean;
  var
    ACount, ARecordIndex: Integer;
  begin
    Result := False;
    if ACellIndex < 0 then Exit;
    ACount := GetContainerCount(ARowIndex);
    ARecordIndex := Max(Controller.FocusedRecordIndex, 0);
    AIndex := (ACellIndex mod ACount) + cxIntOffs[AForward];
    while (AIndex >=0) and (AIndex < ACount) do
      if CanCellTabStop(ARowIndex, AIndex) then
      begin
        Result := True;
        Inc(AIndex, ARecordIndex * ACount);
        break
      end
      else
        Inc(AIndex, cxIntOffs[AForward]);
  end;

var
  AIndex, AMin, AMax: Integer;
begin
  if Controller.ProcessMultiEditorRow and NavigateMultiEditorRow(AIndex) then
  begin
    ACellIndex := AIndex;
    Exit;
  end;
  //calc valid row's index
  AMin := 0;
  AMax := RowCount - 1;
  AIndex := ARowIndex;
  repeat
    Inc(AIndex, cxIntOffs[AForward]);
    if not cxInRange(AIndex, AMin, AMax) then Exit;
  until Rows[AIndex].CanFocus and Rows[AIndex].Options.TabStop;
  ARowIndex := AIndex;
  //calc valid cell's index
  AMax := GetContainerCount(ARowIndex);
  if (AMax = 0) or (Controller.FocusedRecordIndex < 0) then
    Exit;
  AIndex := AMax * Controller.FocusedRecordIndex;
  if (AMax > 1) and not Controller.ProcessMultiEditorRow then
  begin
    //special case (multieditor row)
    if not AForward then Inc(AIndex, AMax - 1);
    while not CanCellTabStop(ARowIndex, AIndex) do
      Inc(AIndex, cxIntOffs[AForward]);
  end
  else
    while not CanCellTabStop(ARowIndex, AIndex) do
      Inc(AIndex);
  ACellIndex := AIndex;
end;

function TcxvgCellNavigator.FindNextRecord(AForward: Boolean): Boolean;
begin
  Result := Controller.Scroller.ScrollStrategy.FindNextRecord(
    DataController.FocusedRowIndex, AForward) <> -1;
end;

function TcxvgCellNavigator.GetCellContainer(ARowIndex,
  ACellIndex: Integer): TcxCustomInplaceEditContainer;
var
  ACount: Integer;
begin
  Result := nil;
  if cxInRange(ARowIndex, 0, RowCount - 1) then
    with Rows[ARowIndex] do
    begin
      ACount := GetEditContainerCount;
      if (ACount > 0) and (ACellIndex >= 0) then
        Result := GetEditContainer(ACellIndex mod ACount);
    end;
end;

function TcxvgCellNavigator.GetContainerCount(
  ARowIndex: Integer): Integer;
begin
  if cxInRange(ARowIndex, 0, RowCount - 1) then
    Result := Rows[ARowIndex].GetEditContainerCount
  else
    Result := 0;
end;

function TcxvgCellNavigator.GetCount(
  ARowIndex: Integer): Integer;
begin
  Result := GetContainerCount(ARowIndex) * RecordCount;
end;

procedure TcxvgCellNavigator.Init(var ARowIndex, ACellIndex,
  ARowCount: Integer);
var
  ARecordIndex: Integer;
begin
  with Controller do
  begin
    ARowCount := ViewInfo.VisibleRowCount;
    ARecordIndex := Max(0, FocusedRecordIndex);
    if FocusedRow = nil then
      ARowIndex := -1
    else
      ARowIndex := FocusedRow.VisibleIndex;
    if CellIndex < 0 then
      ACellIndex := -1
    else
      ACellIndex := CellIndex + ARecordIndex * Max(1, GetContainerCount(ARowIndex));
  end;
end;

function TcxvgCellNavigator.MayFocusedEmptyRow(ARowIndex: Integer): Boolean;
begin
  Result := True;
end;

procedure TcxvgCellNavigator.SetFocusCell(ARowIndex, ACellIndex: Integer; AShift: TShiftState = []);
var
  ACount, AIndex, ARecord, AFocusedRecord: Integer;
begin
  ACount := GetContainerCount(ARowIndex);
  if Rows[ARowIndex] <> Controller.FocusedRow then
    with Controller do
    begin
      if (FocusedRecordIndex < 0) and (DataController.RowCount > 0) then
        FocusedRecordIndex := 0;
      if (ACount > 0) then
        AIndex := ACellIndex mod ACount
      else
        AIndex := ACellIndex;
      SetFocusedRowAndCell(Rows[ARowIndex], AIndex);
    end
  else
  begin
    AFocusedRecord := Controller.FocusedRecordIndex;
    ARecord := ACellIndex div Max(ACount, 1);
    if ACount > 0 then AIndex := ACellIndex mod ACount else AIndex := 0;
    if (AFocusedRecord <> -1) and (ARecord <> AFocusedRecord) then
    begin
      if ARecord < AFocusedRecord then
      begin
        if not FindNextRecord(False) then Exit;
        while (AIndex >= 0) and (ACount > 0) and
          not TcxCellEdit(GetCellContainer(ARowIndex, AIndex)).CanFocus do
            Dec(AIndex);
        if AIndex < 0 then Exit;
      end
      else
      begin
        if not FindNextRecord(True) then Exit;
        while (AIndex < ACount) and (ACount > 0) and
          not TcxCellEdit(GetCellContainer(ARowIndex, AIndex)).CanFocus do
            Inc(AIndex);
        if (ACount > 0) and (AIndex = ACount) then Exit;
      end;
      Controller.SetFocusedRecordItem(ARecord, GetCellContainer(ARowIndex, AIndex));
    end
    else
      Controller.SetFocusedRowAndCell(Rows[ARowIndex], AIndex);
  end;
end;

function TcxvgCellNavigator.GetController: TcxvgController;
begin
  Result := TcxvgController(inherited Controller);
end;

function TcxvgCellNavigator.GetRecordCount: Integer;
var
  AIntf: IcxVerticalGridDBDataContoller;
begin
  if DataController.GetInterface(IcxVerticalGridDBDataContoller, AIntf) then
    Result := AIntf.GetDataSetRecordCount
  else
    Result := DataController.RowCount;
end;

function TcxvgCellNavigator.GetRow(Index: Integer): TcxCustomRow;
begin
  Result := Controller.ViewInfo.VisibleRows[Index];
end;

function TcxvgCellNavigator.GetValueCount: Integer;
begin
  Result := Max(1, Controller.ViewInfo.VisibleValueCount)
end;

{ TcxvgDragImageHelper }

procedure TcxvgDragImageHelper.DragAndDrop(const P: TPoint);
var
  CP: TPoint;
begin
  inherited DragAndDrop(P);
  with TcxCustomVerticalGrid(DragControl).Controller do
  begin
    CP := DragControl.ScreenToClient(P);
    HitTest.RecalculateOnMouseEvent(CP.X, CP.Y, []);
    if (FAutoScrollObject <> nil) and not HitTest.HitAtCustomize then
      FAutoScrollObject.CheckBounds(CP);
  end;
  DragControl.DragCursor := GetCursor;
end;

function TcxvgDragImageHelper.GetCursor: TCursor;
begin
  Result := crcxInspectorNoDrag;
  with TcxCustomVerticalGrid(DragControl), HitTest do
  begin
    if HitAtCustomize then
      Result := crDrag
    else
      if HitAtCaption then
        Result := crcxInspectorAddChild
      else
        if HitAtEmpty then
          Result := crcxInspectorAdd
        else
          if HitInControl then
            Result := crcxInspectorInsert
   end;
end;

{ TcxvgController }

constructor TcxvgController.Create(
  AOwner: TcxEditingControl);
begin
  inherited Create(AOwner);
  FScroller := TcxvgScroller.Create(VerticalGrid);
  FCellIndex := -1;
end;

destructor TcxvgController.Destroy;
begin
  FScroller.Free;
  inherited Destroy;
end;

function TcxvgController.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := cxE_NOINTERFACE;
end;

function TcxvgController.GetCursor(X, Y: Integer): TCursor;
begin
  if not VerticalGrid.IsDesigning then
  begin
    if Int64(Point(X, Y)) <> Int64(HitTestController.HitPoint) then
      TcxvgHitTest(HitTestController).RecalculateOnMouseEvent(X, Y, []);
    Result := TcxvgHitTest(HitTestController).GetCurrentCursor;
    if Result = crDefault then
      Result := inherited GetCursor(X, Y);
  end
  else
    Result := inherited GetCursor(X, Y);
end;

procedure TcxvgController.KeyDown(var Key: Word;
  Shift: TShiftState);
var
  AIsMultiEditorRow: Boolean;

  function CanProcessProcessMultiEditorRow: Boolean;
  var
    AIndex: Integer;
  begin
    Result := False;
    if not AIsMultiEditorRow then Exit;
    with TcxCustomMultiEditorRow(FocusedRow) do
    begin
      AIndex := CellIndex;
      if Key = VK_LEFT then
      begin
        if AIndex > 0 then
        repeat
          Dec(AIndex);
          with Properties.Editors[AIndex].EditContainer do
          if CanFocus and CanTabStop then
          begin
            Result := True;
            Exit;
          end;
        until AIndex = 0;
      end
      else
        if AIndex < Properties.Editors.Count - 1 then
        repeat
          Inc(AIndex);
          with Properties.Editors[AIndex].EditContainer do
          if CanFocus and CanTabStop then
          begin
            Result := True;
            Exit;
          end;
        until AIndex = Properties.Editors.Count - 1;
    end;
  end;

  function CanChangeExpandedState: Boolean;
  begin
    Result := VerticalGrid.OptionsView.ShowButtons and (FocusedRow <> nil) and 
      FocusedRow.Options.ShowExpandButton and (FocusedRow.Count > 0) and not IsEditing;
  end;

begin
  FForceShowEditor := (Key = VK_RETURN) and GetGoToNextCellOnEnter;
  AIsMultiEditorRow := (FocusedRow is TcxCustomMultiEditorRow) and
    (TcxCustomMultiEditorRow(FocusedRow).Properties.Editors.Count > 0);
  FProcessMultiEditorRow := AIsMultiEditorRow and
    (ForceShowEditor or ((Key = VK_TAB) and GetGoToNextCellOnTab));
  if ((Key = VK_LEFT) or (Key = VK_RIGHT)) and not CanProcessProcessMultiEditorRow then
  begin
    if not CanChangeRecord then
    begin
      if CanChangeExpandedState then
        FocusedRow.Expanded := Key = VK_RIGHT;
      EatKeyPress := True;
      Key := 0;
    end;
  end;
  inherited KeyDown(Key, Shift);
  case Key of
    VK_MULTIPLY:
      if CanChangeExpandedState then
      begin
        FocusedRow.Expand(True);
        EatKeyPress := True;
        Key := 0;
      end;
    VK_ADD, VK_SUBTRACT:
      if CanChangeExpandedState then
      begin
        FocusedRow.Expanded := Key = VK_ADD;
        EatKeyPress := True;
        Key := 0;
      end;
    VK_INSERT:
      if (Shift = []) and CanInsert(True) then
      begin
        InsertRecord;
        Key := 0;
      end;
    VK_DELETE:
      if CanHandleDeleteRecordKeys and ((Shift = []) or (Shift = [ssCtrl])) and CanDelete(True) then
      begin
        DeleteSelection;
        Key := 0;
      end;
  end;
end;

procedure TcxvgController.MakeFocusedItemVisible;
begin
  if FLockUpdate or (FFocusedRow = nil) then Exit;
  MakeRecordVisible(FocusedRecordIndex);
  MakeRowVisible(FFocusedRow)
end;

procedure TcxvgController.MakeFocusedRecordVisible;
begin
  MakeRecordVisible(FocusedRecordIndex);
end;

procedure TcxvgController.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

  function IsChangeExpandState(ARow: TcxCustomRow): Boolean;
  begin
    with HitTest do
      Result := ARow.Options.ShowExpandButton and
        (HitAtButton or (IsDblClick and HitAtCaption and ARow.HasVisibleChildren));
  end;

  procedure CheckDesignSelection(ARow: TcxCustomRow);
  begin
    if VerticalGrid.IsDesigning then
    begin
      with VerticalGrid.Controller do
        if DesignSelectionHelper <> nil then
          if ARow <> nil then
          DesignSelectionHelper.Select(ARow, Shift)
        else
          DesignSelectionHelper.Select(VerticalGrid, Shift);
    end;
  end;

  function CanChangeFocusedItem(ARow: TcxCustomRow): Boolean;
  begin
    with HitTest do
      Result := (ARow <> nil) and ARow.CanFocus and
        (not IsItemEditCell or not TcxRowValueInfo(EditCellViewInfo).EditContainer.CanFocus);
  end;

  procedure CheckFocusedRow;
  var
    ARow: TcxCustomRow;
  begin
    ARow := FocusedRow;
    while (ARow <> nil) and not VerticalGrid.IsRowVisible(ARow) do
      ARow := ARow.Parent;
    if ARow <> FocusedRow then
      if (ARow <> nil) and ARow.CanFocus then
        FocusedRow := ARow
      else
        FocusedRow := nil;
  end;

var
  ARow: TcxCustomRow;
  ACellIndex: Integer;
  AChangeExpand: Boolean;
begin
  ARow := HitTest.HitRow;
  CheckDesignSelection(ARow);
  AChangeExpand := (ARow <> nil) and IsChangeExpandState(ARow);
  if (ResizeKind = rkNone) and CanChangeFocusedItem(ARow) then
  begin
    if HitTest.HitCellIndex >= 0 then
      ACellIndex := HitTest.HitCellIndex
    else
      ACellIndex := cxSetValue(FocusedRow <> ARow, 0, CellIndex);
    SetFocusedRowAndCell(ARow, ACellIndex);
    AChangeExpand := AChangeExpand and (VerticalGrid.Rows.IndexOf(ARow) >= 0);
  end;
  if AChangeExpand then
  begin
    ARow.Expanded := not ARow.Expanded;
    if ARow.Expanded then
      Scroller.SetRowMaxVisible(ARow)
    else
      CheckFocusedRow;
  end;
end;

procedure TcxvgController.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  CheckRowTracking(Shift, X, Y);
end;

function TcxvgController.CanDrag(X, Y: Integer): Boolean;
begin
  with HitTest do
  begin
    HitPoint := Point(X, Y);
    if HitAtValue and (dceModified in DataController.EditState) then
      Result := False
    else
      Result := not FWasScroll and CanMoving;
  end;
end;

procedure TcxvgController.EndDragAndDrop(Accepted: Boolean);
begin
  inherited EndDragAndDrop(Accepted);
  ResizeKind := rkNone;
end;

function TcxvgController.StartDragAndDrop(const P: TPoint): Boolean;
begin
  with HitTest do
  begin
    HitPoint := P;
    Result := CanSizing;
  end;
end;

procedure TcxvgController.InitScrollBarsParameters;
begin
  if VerticalGrid.HandleAllocated then
    Scroller.InitScrollBarsParameters;
end;

procedure TcxvgController.Scroll(
  AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
  var AScrollPos: Integer);
begin
  Scroller.Scroll(AScrollBarKind, AScrollCode, AScrollPos);
end;

procedure TcxvgController.RestoreLayout;
begin
  if not VerticalGrid.SubClassesCreated then
    Exit;
  Scroller.RestoreLayout;
  ViewInfo.FLockDividerPos := False;
  VerticalGrid.OptionsView.RowHeaderWidth := SaveSeparatorPos;
  FocusedRow := FSaveFocusedRow;
  MakeFocusedRecordVisible;
end;

procedure TcxvgController.SaveLayout;
begin
  if not VerticalGrid.SubClassesCreated then
    Exit;
  FSaveSeparatorPos := VerticalGrid.OptionsView.RowHeaderWidth;
  FSaveFocusedRow := FocusedRow;
  Scroller.SaveLayout;
end;

procedure TcxvgController.AppendRecord;
begin
  if not CanAppend(False) then Exit;
  if VerticalGrid.OptionsBehavior.FocusFirstCellOnNewRecord then
    FocusedRow := ViewInfo.VisibleRows[0];
  DataController.Append;
end;

procedure TcxvgController.DeleteSelection;
begin
end;

procedure TcxvgController.InsertRecord;
begin
  if not CanInsert(False) then Exit;
  if VerticalGrid.OptionsBehavior.FocusFirstCellOnNewRecord then
    FocusedRow := ViewInfo.VisibleRows[0];
  DataController.Insert;
end;

procedure TcxvgController.MakeRowVisible(ARow: TcxCustomRow);
var
  AParent: TcxCustomRow;
begin
  if ARow = nil then Exit;
  if VerticalGrid.IsRowVisible(ARow) then
    Scroller.SetRowVisible(ARow)
  else
    with VerticalGrid do
    begin
      AParent := ARow.FParent;
      BeginUpdate;
      try
        while AParent <> FRootRow do
        begin
          AParent.Visible := True;
          AParent.Expanded := True;
          AParent := AParent.FParent;
        end;
        Scroller.SetRowVisible(ARow);
      finally
        EndUpdate;
      end;
    end;
end;

function TcxvgController.MakeRecordVisible(AIndex: Integer): Boolean;
begin
  Result := Scroller.SetRecordVisible(AIndex);
end;

function TcxvgController._AddRef: Integer;
begin
  Result := -1;
end;

function TcxvgController._Release: Integer;
begin
  Result := -1;
end;

function TcxvgController.CanSizing(
  ADirection: TcxDragSizingDirection): Boolean;
begin
  HitTest.Recalculate(Mouse.CursorPos);
  Result := HitTest.CanSizing(ADirection);
end;

function TcxvgController.GetSizingBoundsRect(
  ADirection: TcxDragSizingDirection): TRect;
begin
  Result := ViewInfo.ClipRect;
  Dec(Result.Bottom);
end;

function TcxvgController.GetSizingIncrement(
  ADirection: TcxDragSizingDirection): Integer;
begin
  Result := 1;
end;

function TcxvgController.IsDynamicUpdate: Boolean;
begin
  Result := True;
end;

procedure TcxvgController.SetSizeDelta(
  ADirection: TcxDragSizingDirection; ADelta: Integer);
begin
  Inc(FSizingValue, ADelta);
  case ResizeKind of
    rkRowSizing:
      FSizingRow.Height := Max(FSizingValue, ViewInfo.FRowMinHeight);
    rkDivider:
      ViewInfo.SetDividerPos(FSizingValue);
    rkBandSizing:
      ViewInfo.SetValueWidth(FSizingValue);
  end;
  VerticalGrid.Modified;
end;

procedure TcxvgController.DragDrop(Source: TObject; X, Y: Integer);
begin
  if IsInternalDragging then
  begin
    with HitTest do
      if (HitRow <> nil) or HitAtEmpty then
      begin
        VerticalGrid.BeginUpdate;
        try
          if HitRow = nil then
          begin
            DragRow.Parent := VerticalGrid.FRootRow;
            DragRow.Index := VerticalGrid.FRootRow.Count - 1;
          end
          else
          begin
            if HitAtCaption then
              DragRow.Parent := HitRow
            else
              DragRow.Parent := HitRow.Parent;
            DragRow.Index := HitRow.Index;
          end;
          DragRow.Visible := True;
        finally
          VerticalGrid.EndUpdate;
        end;
      end
      else
        CheckMoveToCustomizationForm;
  end;
end;

procedure TcxvgController.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited DragOver(Source, X, Y, State, Accept);
  if (not Assigned(VerticalGrid.OnDragOver) or Accept) and IsInternalDragging then
    with HitTest do
    begin
      HitPoint := cxPoint(X, Y);
      Accept := HitAtEmpty or
        HitAtRowHeader and (DragRow <> HitRow) and not DragRow.IsParent(HitRow);
    end;
end;

procedure TcxvgController.EndDrag(Target: TObject; X, Y: Integer);
begin
  FAutoScrollObject.Free;
  FAutoScrollObject := nil;
  FTrackingEnabled := False;
  inherited EndDrag(Target, X, Y);
end;

procedure TcxvgController.StartDrag(var DragObject: TDragObject);
begin
  inherited StartDrag(DragObject);
  FAutoScrollObject := TcxControllerAutoScrollingObject.Create(Self);
  FAutoScrollObject.SetBoundsParams(VerticalGrid.ClientBounds, False, True, 1);
  HitTest.HitPoint := VerticalGrid.ScreenToClient(GetMouseCursorPos);
  with VerticalGrid.Customizing do
  begin
    FDragFromCustomizingForm := Visible and HitTest.HitAtCustomize;
    if Visible and (DragRow <> nil) then
    begin
      if DragRow is TcxCategoryRow then
        MakeCategorySheetVisible
      else
        MakeRowSheetVisible;
    end;
  end;
end;

procedure TcxvgController.BeforeMouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited BeforeMouseDown(Button, Shift, X, Y);
  FDragRow := nil;
end;

procedure TcxvgController.BehaviorChanged;
begin
  if not VerticalGrid.IsLocked then
    inherited BehaviorChanged;
end;

function TcxvgController.CanAppend(ACheckOptions: Boolean): Boolean;
begin
  Result := False;
end;

function TcxvgController.CanChangeRecord: Boolean;
begin
  Result := False;
end;

function TcxvgController.CanDelete(ACheckOptions: Boolean): Boolean;
begin
  Result := False;
end;

function TcxvgController.CanInsert(ACheckOptions: Boolean): Boolean;
begin
  Result := False;
end;

function TcxvgController.CanTrack(const AShift: TShiftState): Boolean;
begin
  Result := FTrackingEnabled and (ssLeft in AShift) and
    (VerticalGrid.DragAndDropState = ddsNone) and
    not VerticalGrid.Dragging and not VerticalGrid.IsLocked;
end;

procedure TcxvgController.CheckFocusFirstVisibleRow;
begin
  if VerticalGrid.IsFocused and (FocusedRow = nil) then
    FocusedRow := GetFirstVisibleRow;
end;

procedure TcxvgController.CheckPostData;
begin
  if [dceEdit, dceModified] * DataController.EditState <> [] then
    DataController.Post;
end;

procedure TcxvgController.CheckRowTracking(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  ARow: TcxCustomRow;
begin
  if not CanTrack(Shift) then Exit;
  ARow := HitTest.HitRow;
  if ARow <> nil then
  begin
    if ARow.CanFocus then
    begin
      StopScrollTimer;
      SetFocusedRowAndCell(ARow, HitTest.HitCellIndex);
      Exit;
    end;
  end
  else
    for I := 0 to ViewInfo.RowsViewInfo.Count - 1 do
      with ViewInfo.RowsViewInfo[I] do
        if cxRectPtIn(RowRect, X, Y) or ((Y >= RowRect.Top) and
          (Y < RowRect.Bottom)) and Row.CanFocus then
        begin
          StopScrollTimer;
          SetFocusedRowAndCell(Row, HitTest.HitCellIndex);
          Exit;
        end;
  with VerticalGrid.ClientBounds do
  begin
    if Y <= Top then
    begin
      FScrollDown := False;
      StartScrollTimer;
    end;
    if Y > Bottom then
    begin
      FScrollDown := True;
      StartScrollTimer;
    end;
  end;
end;

procedure TcxvgController.Clear;
begin
  StopScrollTimer;
  FTrackingEnabled := False;
  inherited Clear;
  EditingController.EditingItem := nil;
  FocusedItem := nil;
  FFocusedRow := nil;
end;

procedure TcxvgController.ControlFocusChanged;
begin
  CheckFocusFirstVisibleRow;
  inherited ControlFocusChanged;
end;

procedure TcxvgController.DoCancelMode;
begin
  StopScrollTimer;
  FTrackingEnabled := False;
  inherited DoCancelMode;
end;

procedure TcxvgController.DoMouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ATopRow: Integer;
  P: TPoint;
begin
  if (VerticalGrid.DragAndDropState <> ddsNone) and HitTest.CanSizing then
  begin
    EditingController.HideEdit(True);
    Exit;
  end;
  ATopRow := Scroller.TopVisibleRowIndex;
  inherited DoMouseDown(Button, Shift, X, Y);
  FWasScroll := ATopRow <> Scroller.TopVisibleRowIndex;
  with VerticalGrid, HitTest do
  begin
    P := ScreenToClient(GetMouseCursorPos); //can be changed on the validation exception
    RecalculateOnMouseEvent(P.X, P.Y, Shift);
    FTrackingEnabled := (Button = mbLeft) and (DragMode <> dmAutomatic) and
      not FWasScroll and not HitAtEmpty and
      not HitAtButton and OptionsBehavior.RowTracking and
      (GetCapture = Handle) and //B139729
      not (IsItemEditCell and EditCellViewInfo.EditViewInfo.IsHotTrack(P));
    if CanMoving and not FTrackingEnabled then
      FDragRow := HitRow;
  end;
end;

procedure TcxvgController.DoMouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StopScrollTimer;
  FTrackingEnabled := False;
  inherited DoMouseUp(Button, Shift, X, Y);
end;

procedure TcxvgController.DoNextPage(AForward: Boolean;
  Shift: TShiftState);
const
  Direction: array[Boolean] of TScrollCode = (scPageUp, scPageDown);
var
  AIndex: Integer;
begin
  if ViewInfo.VisibleRowCount = 0 then Exit;
  if ssCtrl in Shift then
    if AForward then
      FocusedRow := VerticalGrid.LastVisibleRow
    else
      FocusedRow := VerticalGrid.FirstVisibleRow
  else
  begin
    if FFocusedRow = nil then
      AIndex := 0
    else
      AIndex := FFocusedRow.VisibleIndex;
    if AForward then
      Inc(AIndex, Scroller.VisibleRowCount)
    else
      Dec(AIndex, Scroller.VisibleRowCount);
    cxRange(AIndex, 0, ViewInfo.VisibleRowCount - 1);
    FocusedRow := ViewInfo.VisibleRows[AIndex];
  end;
  MakeFocusedItemVisible;
end;

procedure TcxvgController.DoUpdateRowAndCell(ANewRow: TcxCustomRow;
  ANewCellIndex: Integer);
var
  APrevFocusedRow: TcxCustomRow;
  APrevCellIndex: Integer;
begin
  APrevFocusedRow := FFocusedRow;
  APrevCellIndex := FCellIndex;
  if FFocusedRow <> ANewRow then
  begin
    FFocusedRow := ANewRow;
    FCellIndex := cxSetValue(ANewRow = nil, -1, ANewCellIndex);
    ViewInfo.ChangeFocusedRow(ANewRow, APrevFocusedRow)
  end
  else
    if FCellIndex <> ANewCellIndex then
    begin
      FCellIndex := cxSetValue(FFocusedRow = nil, -1, ANewCellIndex);
      RefreshFocusedRow;
    end;
  MakeFocusedItemVisible;
  if (APrevFocusedRow <> FFocusedRow) or (APrevCellIndex <> FCellIndex) then
    VerticalGrid.DoItemChanged(APrevFocusedRow, APrevCellIndex);
  if VerticalGrid.IsLocked then Exit;
  AllowCheckEdit := True;
  if ForceShowEditor then
  begin
    FForceShowEditor := False;
    EditingController.ShowEdit;
  end
  else
    CheckEdit;
end;

procedure TcxvgController.FocusedItemChanged(
  APrevFocusedItem: TcxCustomInplaceEditContainer);
var
  ARow: TcxCustomRow;
  ACellIndex: Integer;
begin
  if EditingControl.ComponentState * [csLoading, csDestroying] <> [] then Exit;
  if not FLockIncSearch then
    CancelIncSearching;
  if (APrevFocusedItem <> nil) and GetPostDataOnChangeItem then
    CheckPostData;
  AllowCheckEdit := False;
  if FLockUpdate then Exit;
  if FocusedItem = nil then
  begin
    if (FFocusedRow = nil) or (csDestroying in FFocusedRow.ComponentState) then
      ARow := nil
    else
      ARow := FFocusedRow;
    ACellIndex := FCellIndex;
  end
  else
    with TcxCellEdit(FocusedItem) do
    begin
      ARow := Row;
      ACellIndex := CellIndex;
    end;
  DoUpdateRowAndCell(ARow, ACellIndex);
end;

function TcxvgController.GetCancelEditingOnExit: Boolean;
begin
  Result := [dceEdit, dceModified] * DataController.EditState = [];
end;

function TcxvgController.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  FResizeKind := rkNone;
  if HitTest.CanSizing(ResizeDirection) then
  begin
    if ResizeDirection = dsdHorz then
    begin
      if HitTest.HitAtDivider then
        ResizeKind := rkDivider
      else
        ResizeKind := rkBandSizing;
    end
    else
      ResizeKind := rkRowSizing;
    Result := TcxSizingDragAndDropObject;
    DragItem := Self;
  end
  else
    Result := nil
end;

function TcxvgController.GetFocusedCellViewInfo(
  AEditContainer: TcxCustomInplaceEditContainer): TcxEditCellViewInfo;
var
  ARowViewInfo: TcxCustomRowViewInfo;
begin
  Result := nil;
  if AEditContainer = nil then Exit;
  ARowViewInfo := TcxCellEdit(AEditContainer).ViewInfo;
  if (ARowViewInfo <> nil) and (FCellIndex >= 0) then
    Result := ARowViewInfo.RowValueInfo[FocusedRecordIndex, FCellIndex];
end;

function TcxvgController.GetImmediateEditor: Boolean;
begin
  // ignore VerticalGrid.DragMode
  with VerticalGrid.OptionsBehavior do
    Result := ImmediateEditor or AlwaysShowEditor;
end;

function TcxvgController.GetNavigatorClass: TcxCustomCellNavigatorClass;
begin
  Result := TcxvgCellNavigator;
end;

function TcxvgController.GetPostDataOnChangeItem: Boolean;
begin
  Result := True;
end;

function TcxvgController.GetResizeDirection: TcxDragSizingDirection;
begin
  if ResizeKind = rkRowSizing then Result := dsdVert else Result := dsdHorz;
end;

procedure TcxvgController.InternalSetRowAndCell(ARow: TcxCustomRow;
  ACellIndex: Integer);
begin
  FFocusedRow := ARow;
  FCellIndex := ACellIndex;
end;

function TcxvgController.IsImmediatePost: Boolean;
begin
  Result := True;
end;

function TcxvgController.IsInternalDragging: Boolean;
begin
  Result := (VerticalGrid.DragMode = dmAutomatic) and (FDragRow <> nil);
end;

function TcxvgController.IsKeyForController(AKey: Word;
  AShift: TShiftState): Boolean;
begin
  Result := inherited IsKeyForController(AKey, AShift) or
    (IsEditing and (ssCtrl in AShift) and (AKey in [VK_MULTIPLY, VK_ADD, VK_SUBTRACT]));
end;

procedure TcxvgController.RefreshFocusedRow;
begin
  if not FLockUpdate and (FFocusedRow <> nil) and
     not (csDestroying in FFocusedRow.ComponentState) and FFocusedRow.Visible then
      FFocusedRow.ViewInfo.Update;
end;

procedure TcxvgController.SetFocusedCellEdit(ACellEdit: TcxCellEdit);
var
  I: Integer;
  ARow: TcxCustomRow;
  ACellViewInfo: TcxEditCellViewInfo;
begin
  if ACellEdit = nil then
    FocusedRow := nil
  else
  begin
    ARow := ACellEdit.Row;
    for I := 0 to ARow.GetEditContainerCount - 1 do
      if ARow.GetEditContainer(I) = ACellEdit then
      begin
        SetFocusedRowAndCell(ARow, I);
        ACellViewInfo := GetFocusedCellViewInfo(ACellEdit);
        if Assigned(ACellViewInfo) then
          ACellViewInfo.Invalidate(True);
        break;
      end;
  end;
end;

procedure TcxvgController.SetFocusedRowAndCell(
  Value: TcxCustomRow; ACellIndex: Integer);

  function CanCellFocus(AIndex: Integer): Boolean;
  begin
    Result := Value.GetEditContainer(AIndex).CanFocus;
  end;

  procedure CorrectCellIndex;
  var
    I, ACount: Integer;
  begin
    if Value = nil then
      ACount := 0
    else
      ACount := Value.GetEditContainerCount;
    if (ACellIndex >= ACount) or (ACellIndex < 0) then
      ACellIndex := 0;
    if (ACount > 0) and not CanCellFocus(ACellIndex) then
    begin
      ACellIndex := 0;
      for I := 0 to ACount - 1 do
        if CanCellFocus(I) then
        begin
          ACellIndex := I;
          break;
        end;
    end;
  end;

var
  AEditContainer: TcxCustomInplaceEditContainer;
begin
  if VerticalGrid.IsDesigning or Assigned(Value) and not Value.CanFocus then Exit;
  CorrectCellIndex;
  if (FCellIndex = ACellIndex) and (FFocusedRow = Value) then Exit;
  FLockUpdate := True;
  try
    if Value <> nil then
      AEditContainer := Value.GetEditContainer(ACellIndex)
    else
      AEditContainer := nil;
    if FocusedItem <> AEditContainer then
      FocusedItem := AEditContainer;
  finally
    FLockUpdate := False;
    AllowCheckEdit := True;
  end;
  DoUpdateRowAndCell(Value, ACellIndex);
end;

procedure TcxvgController.UpdatePaintStyle;
begin
  ViewInfo.LayoutStyleChanged;
end;

procedure TcxvgController.UpdateRecord(ARecordIndex: Integer);
begin
  inherited UpdateRecord(ARecordIndex);
  if not VerticalGrid.IsLocked then
    ViewInfo.UpdateRecord(ARecordIndex);
end;

procedure TcxvgController.CheckMoveToCustomizationForm;

  procedure HideWithChildren(ARow: TcxCustomRow);
  begin
    if not ARow.Options.CanMovedToCustomizationForm then
    begin
      if ARow.Parent <> nil then
        ARow.Parent := ARow.Parent.Parent
      else
        ARow.Parent := nil;
    end;
    while ARow.Count > 0 do
      HideWithChildren(ARow.Rows[0]);
    if ARow.Options.CanMovedToCustomizationForm then
    begin
      ARow.Visible := False;
      ARow.Parent := nil;
    end;
  end;

begin
  if not DragFromCustomizingForm and HitTest.HitAtCustomize and
    DragRow.Options.CanMovedToCustomizationForm then
  begin
    with VerticalGrid do
    begin
      BeginUpdate;
      try
        HideWithChildren(FDragRow);
        FocusedRow := nil;
      finally
        EndUpdate;
      end;
      Customizing.Modified;
    end;
  end;
end;

function TcxvgController.GetFirstVisibleRow: TcxCustomRow;
begin
  if ViewInfo.VisibleRowCount > 0 then
    Result := ViewInfo.VisibleRows[0]
  else
    Result := nil;
end;

function TcxvgController.GetHitTest: TcxvgHitTest;
begin
  Result := TcxvgHitTest(inherited HitTestController);
end;

function TcxvgController.GetVerticalGrid: TcxCustomVerticalGrid;
begin
  Result := TcxCustomVerticalGrid(EditingControl);
end;

function TcxvgController.GetViewInfo: TcxvgCustomViewInfo;
begin
  Result := VerticalGrid.ViewInfo;
end;

procedure TcxvgController.SetFocusedRow(Value: TcxCustomRow);
begin
  SetFocusedRowAndCell(Value, 0);
end;

procedure TcxvgController.SetResizeKind(
  Value: TcxvgResizeKind);
begin
  FResizeKind := Value;
  case Value of
    rkDivider:
      FSizingValue := VerticalGrid.OptionsView.RowHeaderWidth;
    rkBandSizing:
      FSizingValue := VerticalGrid.OptionsView.ValueWidth;
    rkRowSizing:
      begin
        FSizingRow := HitTest.HitRow;
        FSizingValue := FSizingRow.ViewInfo.CalculatedHeight;
      end
  end; 
end;

procedure TcxvgController.OnScrollTimer(Sender: TObject);
var
  ARow: TcxCustomRow;
begin
  if FScrollDown then
    ARow := VerticalGrid.NextVisibleRow(FocusedRow)
  else
    ARow := VerticalGrid.PrevVisibleRow(FocusedRow);
  if ARow <> nil then FocusedRow := ARow;
end;

procedure TcxvgController.StartScrollTimer;
begin
  if FScrollTimer <> nil then Exit;
  FScrollTimer := TTimer.Create(nil);
  FScrollTimer.Interval := 5;
  FScrollTimer.OnTimer := OnScrollTimer;
end;

procedure TcxvgController.StopScrollTimer;
begin
  FreeAndNil(FScrollTimer);
end;

{ TcxvgMultiRecordsController }

procedure TcxvgMultiRecordsController.DeleteSelection;
begin
  if not CanDelete(False) then Exit;
  if not OptionsData.DeletingConfirmation or
    cxConfirmMessageBox(
      PChar(cxGetResourceString(@cxSvgDeletingFocusedConfirmationText)),
      PChar(cxGetResourceString(@cxSvgDeletingConfirmationCaption))) then
    DataController.DeleteFocused;
end;

function TcxvgMultiRecordsController.CanAppend(ACheckOptions: Boolean): Boolean;
begin
  Result := (dceoAppend in DataController.EditOperations) and
    (not ACheckOptions or OptionsData.Appending);
end;

function TcxvgMultiRecordsController.CanChangeRecord: Boolean;
begin
  Result := OptionsBehavior.AllowChangeRecord or
    (VerticalGrid.LayoutStyle = lsMultiRecordView);
end;

function TcxvgMultiRecordsController.CanDelete(ACheckOptions: Boolean): Boolean;
begin
  Result := (dceoDelete in DataController.EditOperations) and
    (not ACheckOptions or OptionsData.Deleting) and (DataController.RowCount > 0);
end;

function TcxvgMultiRecordsController.CanHandleDeleteRecordKeys: Boolean;
begin
  Result := OptionsData.Deleting;
end;

function TcxvgMultiRecordsController.CanInsert(ACheckOptions: Boolean): Boolean;
begin
  Result := (dceoInsert in DataController.EditOperations) and
    (not ACheckOptions or OptionsData.Inserting);
end;

procedure TcxvgMultiRecordsController.FocusedRecordChanged(APrevFocusedRowIndex,
  AFocusedRowIndex: Integer);
begin
  if APrevFocusedRowIndex <> -1 then
    EditingController.HideEdit(True);
  if not MakeRecordVisible(AFocusedRowIndex) then
  begin
    if VerticalGrid.OptionsView.CellAutoHeight then
      ViewInfo.Calculate
    else
    begin
      ViewInfo.UpdateRecord(APrevFocusedRowIndex);
      ViewInfo.UpdateRecord(AFocusedRowIndex);
    end;
  end;
  VerticalGrid.UpdateScrollBars;
  CheckEdit;
  TcxEditingControllerAccess(EditingController).UpdateEditValue;
  VerticalGrid.DoFocusedRecordChanged(APrevFocusedRowIndex, AFocusedRowIndex);
  VerticalGrid.Invalidate;
end;

function TcxvgMultiRecordsController.GetCancelEditingOnExit: Boolean;
begin
  with VerticalGrid do
    Result := OptionsData.CancelOnExit and
     (DataController.EditState * [dceInsert, dceChanging, dceModified] = [dceInsert]);
end;

function TcxvgMultiRecordsController.GetFocusedRecordIndex: Integer;
begin
  Result := DataController.GetFocusedRowIndex;
end;

function TcxvgMultiRecordsController.GetPostDataOnChangeItem: Boolean;
begin
  Result := False;
end;

function TcxvgMultiRecordsController.IncSearchKeyDown(AKey: Word;
  AShift: TShiftState): Word;
begin
  if ItemForIncSearching = nil then
  begin
    Result := AKey;
    Exit;
  end
  else
    Result := 0;
  case AKey of
    VK_LEFT, VK_RIGHT:
      if AShift = [ssCtrl] then
        SearchLocateNext(ItemForIncSearching, AKey = VK_RIGHT)
      else
      begin
        CancelIncSearching;
        Result := AKey;
      end;
    VK_UP, VK_DOWN:
      Result := AKey;
  else
    Result := inherited IncSearchKeyDown(AKey, AShift);
  end;
end;

function TcxvgMultiRecordsController.IsImmediatePost: Boolean;
begin
  Result := False;
end;

procedure TcxvgMultiRecordsController.RefreshIncSearchItem;
var
  ACellEdit: TcxCellEdit;
begin
  if IsIncSearching then
  begin
    ACellEdit := VerticalGrid.ContainerList.List^[DataController.Search.ItemIndex];
    FLockIncSearch := True;
    try
      SetFocusedCellEdit(ACellEdit);
    finally
      FLockIncSearch := False;
    end;
  end;
end;

procedure TcxvgMultiRecordsController.SetFocusedRecordIndex(Value: Integer);
var
  AIndexesAreEqual: Boolean;
begin
  with DataController do
  begin
    if cxInRange(Value, 0, RowCount - 1) and
      not (CanFocusedRecordIndex(Value) and ChangeFocusedRowIndex(Value)) then Exit;
  end;
  AIndexesAreEqual := FocusedRecordIndex = Value;
  if AIndexesAreEqual then MakeFocusedRecordVisible;
end;

function TcxvgMultiRecordsController.GetOptionsBehavior: TcxvgMultiRecordsOptionsBehavior;
begin
  Result := VerticalGrid.OptionsBehavior;
end;

function TcxvgMultiRecordsController.GetOptionsData: TcxvgMultiRecordsOptionsData;
begin
  Result := VerticalGrid.OptionsData;
end;

function TcxvgMultiRecordsController.GetVerticalGrid: TcxVirtualVerticalGrid;
begin
  Result := inherited VerticalGrid as TcxVirtualVerticalGrid;
end;

{ TcxRowValueInfo }

function TcxRowValueInfo.GetHeight(AContentWidth: Integer): Integer;
begin
  CellContentRect := cxRect(0, 0, AContentWidth, 0);
  Result := CalculateEditHeight;
end;

procedure TcxRowValueInfo.DoCalculate;
begin
  EditContainer.Calculate(Self);
  if Focused then
    FFocusRect := DisplayRect
  else
    FFocusRect := cxNullRect;
end;

function TcxRowValueInfo.EditContainer: TcxCellEdit;
begin
  Result := TcxCellEdit(inherited EditContainer);
end;

function TcxRowValueInfo.GetButtonTransparency: TcxEditButtonTransparency;

   function NeedButton: Boolean;
   begin
     Result := Focused;
     if not Result and (Control is TcxVirtualVerticalGrid) then
       with TcxVirtualVerticalGrid(Control) do
         Result := (LayoutStyle = lsMultiRecordView) and
           (RecordIndex = DataController.FocusedRowIndex);
   end;

var
  B1: TcxEditingControlEditShowButtons;
  B2: TcxEditItemShowEditButtons;
begin
  B1 := TcxCustomVerticalGrid(Control).OptionsView.ShowEditButtons;
  B2 := EditorRowProperties.Options.ShowEditButtons;
  if (B2 = eisbAlways) or (B2 = eisbDefault) and
   ((B1 = ecsbAlways) or (B1 = ecsbFocused) and NeedButton) then
    Result := ebtNone
  else
    Result := ebtHideInactive;
end;

function TcxRowValueInfo.GetDisplayValue: Variant;
begin
  if (FRecordIndex < 0) or (FRecordIndex >= EditContainer.DataController.RowCount) then
    Result := Null
  else
    Result := EditContainer.GetDisplayValue(Properties, FRecordIndex);
end;

function TcxRowValueInfo.GetEditViewParams: TcxViewParams;
begin
  Result := Row.VerticalGrid.Styles.GetContentParams(EditorRowProperties,
    Focused, FRecordIndex);
end;

function TcxRowValueInfo.GetFocused: Boolean;
begin
  with EditContainer do
    Result := (FocusedCellViewInfo = Self) and
      (DataController.FocusedRowIndex = FRecordIndex) and
      (FRow = FRow.VerticalGrid.FocusedRow);
end;

function TcxRowValueInfo.GetRecordIndex: Integer;
begin
  Result := FRecordIndex;
end;

function TcxRowValueInfo.GetSelectedTextColor: Integer;
begin
  Result := IncSearchParams.TextColor;
end;

function TcxRowValueInfo.GetSelectedBKColor: Integer;
begin
  Result := IncSearchParams.Color
end;

function TcxRowValueInfo.IncSearchParams: TcxViewParams;
begin
  Result := TcxCustomVerticalGrid(Control).Styles.GetIncSearchParams;
  if Result.Color = clDefault then
    Result.Color := inherited GetSelectedBKColor;
  if Result.TextColor = clDefault then
    Result.TextColor := inherited GetSelectedTextColor;
end;

function TcxRowValueInfo.IsAutoHeight: Boolean;
begin
  Result := TcxvgCustomViewInfo(ControlViewInfo).GetRowAutoHeight(Row);
end;

function TcxRowValueInfo.GetEditorRowProperties: TcxCustomEditorRowProperties;
begin
  Result := EditContainer.FEditRowProperties;
end;

{ TcxRowCaptionInfo }

constructor TcxRowCaptionInfo.Create;
begin
  inherited Create;
  FImageIndex := -1;
end;

destructor TcxRowCaptionInfo.Destroy;
begin
  with Row.VerticalGrid do
    if not IsDestroying then
      with TcxHotTrackControllerAccess(Controller.HotTrackController) do
        if PrevElement = Self then
          Clear;
  inherited Destroy;
end;

function TcxRowCaptionInfo.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := cxE_NOINTERFACE;
end;

function TcxRowCaptionInfo._AddRef: Integer;
begin
  Result := -1;
end;

function TcxRowCaptionInfo._Release: Integer;
begin
  Result := -1;
end;

function TcxRowCaptionInfo.GetHintBounds: TRect;
begin
  Result := CaptionRect;
end;

function TcxRowCaptionInfo.IsNeedHint(ACanvas: TcxCanvas; const P: TPoint;
  out AText: TCaption;
  out AIsMultiLine: Boolean;
  out ATextRect: TRect; var IsNeedOffsetHint: Boolean): Boolean;
var
  ASize: TSize;
begin
  AText := FindPropertiesHint(P);
  ACanvas.Font := ViewParams.Font;
  if AText <> '' then
  begin
    ASize := ACanvas.TextExtent(AText);
    ATextRect.TopLeft := CaptionRect.TopLeft;
    with ATextRect do
    begin
      Right := Left + ASize.cx;
      Bottom := Top + ASize.cy;
    end;
    IsNeedOffsetHint := True;
    Result := True;
  end
  else
  begin
    AText := FCaption;
    ASize := ACanvas.TextExtent(AText);
    cxRectIntersect(ATextRect, CaptionTextRect, Row.ViewInfo.HeaderInfo.HeaderRect);
    cxRectIntersect(ATextRect, ATextRect, Row.VerticalGrid.ClientBounds);
    IsNeedOffsetHint := False;
    Result := (cxRectWidth(ATextRect) < ASize.cx - 1)
      or (cxRectHeight(ATextRect) < ASize.cy - 1);
  end;
  AIsMultiLine := False;
end;

procedure TcxRowCaptionInfo.UpdateHotTrackState(const APoint: TPoint);
begin
end;

function TcxRowCaptionInfo.FindPropertiesHint(const P: TPoint): string;
var
  I: Integer;
begin
  Result := '';
  if (Row.FProperties is TcxCaptionRowProperties) then
    Result := TcxCaptionRowProperties(Row.FProperties).Hint
  else
    if (Row.FProperties is TcxMultiEditorRowProperties) then
      with TcxMultiEditorRowProperties(Row.FProperties), Row.ViewInfo.HeaderInfo do
        for I := 0 to CaptionsInfo.Count - 1 do
          if cxRectPtIn(CaptionsInfo[I].CaptionRect, P) then
          begin
            Result := Editors[I].Hint;
            break;
          end;
end;

{ TcxCaptionInfoList }

function TcxCaptionInfoList.GetItem(Index: Integer): TcxRowCaptionInfo;
begin
{$IFDEF LABEL45}
  Result := TcxRowCaptionInfo(inherited Items[Index]);
{$ELSE}
  Result := TcxRowCaptionInfo(List^[Index]);
{$ENDIF}
end;

{ TcxValueInfoList }

constructor TcxValueInfoList.Create(AViewInfo: TcxvgCustomViewInfo);
begin
  inherited Create;
  Capacity := 64;
  FViewInfo := AViewInfo;
end;

destructor TcxValueInfoList.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    ViewInfo.RemoveEditCellViewInfo(GetItem(I));
  inherited Destroy;
end;

function TcxValueInfoList.GetItem(Index: Integer): TcxRowValueInfo;
begin
  Result := TcxRowValueInfo(List^[Index]);
end;

{ TcxCustomRowHeaderInfo }

constructor TcxCustomRowHeaderInfo.Create(ARow: TcxCustomRow);
begin
  FCaptionsInfo := TcxCaptionInfoList.Create;
  FCategoryIndents := TIndentInfoList.Create;
  FLinesInfo := TLineInfoList.Create;
  FRow := ARow;
  FRowIndents := TIndentInfoList.Create;
end;

destructor TcxCustomRowHeaderInfo.Destroy;
begin
  FreeAndNil(FCaptionsInfo);
  FreeAndNil(FLinesInfo);
  FreeAndNil(FRowIndents);
  FreeAndNil(FCategoryIndents);
  inherited Destroy;
end;

function TcxCustomRowHeaderInfo.GetPaintStyle: TcxvgPaintStyle;
begin
  Result := VerticalGrid.OptionsView.PaintStyle;
end;

function TcxCustomRowHeaderInfo.GetSelected: Boolean;
begin
  with VerticalGrid.Controller do
    Result := (DesignSelectionHelper <> nil) and
      DesignSelectionHelper.IsObjectSelected(Row);
end;

function TcxCustomRowHeaderInfo.GetShowButton: Boolean;
begin
  with VerticalGrid.OptionsView do
    Result := ShowButtons and ShowHeaders and Row.Options.ShowExpandButton and
      Row.HasVisibleChildren;
end;

function TcxCustomRowHeaderInfo.GetVerticalGrid: TcxCustomVerticalGrid;
begin
  Result := Row.VerticalGrid;
end;

procedure TcxCustomRowHeaderInfo.AddBottomHorzLine(const R: TRect);
begin
  with ViewInfo, R do
    if HorzLineWidth > 0 then
      Self.LinesInfo.Add(Left, Bottom, Right - Left, HorzLineWidth, HorzLineBrush);
end;

procedure TcxCustomRowHeaderInfo.AddBoundHeaderLines;
begin
  ViewInfo.CalcHelper.AddBoundHeaderLines(Self);
end;

procedure TcxCustomRowHeaderInfo.AddNextIndentInfo(const ABounds: TRect;
  const AViewParams: TcxViewParams;
  AToCategories, AUnderline, AAddVertLine: Boolean);
begin
  if AToCategories then
    CategoryIndents.Add(ABounds, AViewParams)
  else
    RowIndents.Add(ABounds, AViewParams);
  ViewInfo.CalcHelper.AddHeaderIndentLines(Self, ABounds, AViewParams,
    AToCategories, AUnderline, AAddVertLine);
end;

procedure TcxCustomRowHeaderInfo.AddRightVertLine(const R: TRect);
begin
  if ViewInfo.ShowHeaders then
    ViewInfo.CalcHelper.AddDivider(LinesInfo, R, clNone, False);
end;

procedure TcxCustomRowHeaderInfo.Calc(const AHeaderRect: TRect;
  AViewInfo: TcxvgCustomViewInfo; ANextRow: TcxCustomRow;
  ACalcBounds: Boolean);
begin
  FViewInfo := AViewInfo;
  Clear;
  FTransparent := False;
  FHeaderRect := AHeaderRect;
  FFocused := FRow = VerticalGrid.FocusedRow;
  CalcViewParams(ACalcBounds);
  CalcIndentBounds(ANextRow, ACalcBounds);
  CalcExpandButton;
  AddBoundHeaderLines;
  FHeaderCellsRect := AHeaderRect;
  FHeaderCellsRect.Left := IndentBounds.Right;
  if not cxRectIsEmpty(FHeaderCellsRect) then
  begin
    AddRightVertLine(AHeaderRect);
    CalcRowCaptionsInfo;
    FFocusRect := GetFocusRect;
  end
  else
    FHeaderCellsRect := cxNullRect;
end;

function TcxCustomRowHeaderInfo.CalcCaptionInfo(
  ARowProperties: TcxCaptionRowProperties; const R: TRect): TcxRowCaptionInfo;
var
  W: Integer;
  AOffset: TRect;
begin
  Result := TcxRowCaptionInfo.Create;
  with Result do
  begin
    FRow := Self.Row;
    FCaptionRect := R;
    FImages := VerticalGrid.Images;
    if FImages <> nil then
    begin
      W := ViewInfo.ImageSize.cx;
      if (ARowProperties.ImageIndex >= 0) and (ARowProperties.ImageIndex < FImages.Count) then
        FImageIndex := ARowProperties.ImageIndex
      else
      begin
        if not VerticalGrid.OptionsView.FShowEmptyRowImage then W := 0;
        FImageIndex := -1;
      end;
    end
    else W := 0;
    FImageRect := cxRectBounds(R.Left, GetTopCentralPoint(ViewInfo.ImageSize.cy, R), W, ViewInfo.ImageSize.cy);
    with R do
    begin
      FCaptionTextRect := cxRect(FImageRect.Right + 1, Top,
        FImageRect.Right + 1 + Max(0, Right - FImageRect.Right - 2), Bottom);
    end;
    AOffset := GetTextEditDrawTextOffset(ARowProperties.HeaderAlignmentHorz, True);
    with FCaptionTextRect do
    begin
      Inc(Top, AOffset.Top + 1);
      Inc(Left, AOffset.Left + 1);
      Dec(Bottom, AOffset.Bottom + 1);
      Dec(Right, AOffset.Right + 1);
    end;
    FTextFlags := GetTextAligmentFlags(ARowProperties);
    if VerticalGrid.OptionsView.CellEndEllipsis then
      FTextFlags := FTextFlags or CXTO_END_ELLIPSIS;
    FViewParams := GetCaptionViewParams;
    FCaption := ARowProperties.Caption;
    FFocused := FRow = VerticalGrid.FocusedRow;
  end;
end;

procedure TcxCustomRowHeaderInfo.CalcExpandButton;
begin
  if GetShowButton then
  begin
    DoCalcExpandButton;
    FButtonColor := GetButtonColor;
  end;
end;

function TcxCustomRowHeaderInfo.CalcIndentsInfo(ALevelCount: Integer;
  ANextRow: TcxCustomRow): TIndentRectInfoList;
var
  ACurRow: TcxCustomRow;
  AUnderline, AIsCategory: Boolean;
  I, ANextRowLevel: Integer;
begin
  Result := TIndentRectInfoList.Create;
  if ANextRow = nil then ANextRowLevel := -1 else ANextRowLevel := ANextRow.Level;
  ACurRow := Row;
  for I := ALevelCount downto 0 do
  begin
    AIsCategory := ACurRow is TcxCategoryRow;
    if AIsCategory then
      AUnderline := (ANextRow = nil) or (ACurRow.Level >= ANextRowLevel)
    else
      AUnderline := I = ALevelCount;
    Result.Add(cxSize(ViewInfo.RowIndentWidth, cxRectHeight(HeaderRect)),
      AIsCategory, AUnderline, ViewInfo.CalcHelper.GetIndentViewParams(Row, ACurRow));
    ACurRow := ACurRow.FParent;
  end;
end;

procedure TcxCustomRowHeaderInfo.CalcIndentBounds(ANextRow: TcxCustomRow;
  ACalculate: Boolean);
var
  R: TRect;
  I, J, W, ALevelCount, ANextLevel, AHeight, ABoundsWidth: Integer;
  AIndents: TIndentRectInfoList;
begin
  AHeight := cxRectHeight(HeaderRect);
  R := cxRectBounds(HeaderRect.Left, HeaderRect.Top, 0, AHeight);
  if not ACalculate then
  begin
    FIndentBounds := R;
    Exit;
  end;
  ALevelCount := cxSetValue(ViewInfo.ShowHeaders, Row.Level, -1);
  if ANextRow = nil then ANextLevel := -1 else ANextLevel := ANextRow.Level;
  AIndents := CalcIndentsInfo(ALevelCount, ANextRow);
  ABoundsWidth := 0;
  W := ViewInfo.VertLineWidth;
  J := 0;
  try
    for I := 0 to ALevelCount do
      with AIndents[ALevelCount - I]^ do
      begin
        if IsCategory then
        begin
          if R.Right - R.Left > 0 then
          begin
            Inc(R.Right, W);
            cxRectIntersect(R, R, HeaderRect);
            if not cxRectIsEmpty(R) then
              AddNextIndentInfo(R, AIndents[ALevelCount - J].ViewParams, False, ANextLevel - I <= 0, True);
            Inc(ABoundsWidth, W);
          end;
          cxRectIntersect(R, cxRectBounds(HeaderRect.Left + ABoundsWidth,
            HeaderRect.Top, Size.cx + W, Size.cy), HeaderRect);
          if not cxRectIsEmpty(R) then
            AddNextIndentInfo(cxRectBounds(HeaderRect.Left + ABoundsWidth, HeaderRect.Top,
              Size.cx + W, Size.cy), ViewParams, True, Underline, I < ALevelCount);
					Inc(ABoundsWidth, cxSetValue(I < ALevelCount, W, cxSetValue(IncreaseBoundsByLastVertLine, W, 0)));
          R := cxRectBounds(HeaderRect.Left + ABoundsWidth + Size.cx, HeaderRect.Top, 0, AHeight);
        end
        else
        begin
          Inc(R.Right, Size.cx);
          J := I;
        end;
        Inc(ABoundsWidth, Size.cx);
      end;
    cxRectIntersect(R, R, FHeaderRect);
    if not cxRectIsEmpty(R) then
      AddNextIndentInfo(R, AIndents[ALevelCount - J].ViewParams, False, True, False);
    with HeaderRect do
      FIndentBounds := cxRectBounds(Left, Top, ABoundsWidth, AHeight);
  finally
    AIndents.Free;
  end;
end;

procedure TcxCustomRowHeaderInfo.CalcRowCaptionsInfo;
var
  ACaptionInfo: TcxRowCaptionInfo;
begin
  ACaptionInfo := CalcCaptionInfo(TcxCaptionRowProperties(Row.FProperties), HeaderCellsRect);
  CaptionsInfo.Add(ACaptionInfo);
end;

procedure TcxCustomRowHeaderInfo.CalcViewParams(AAllowFocus: Boolean);
begin
  FIndentViewParams := VerticalGrid.Styles.GetHeaderParams(Row);
  if AAllowFocus and Focused and (PaintStyle = psDotNet) then
  begin
    ViewParams := VerticalGrid.Styles.GetSelectedHeaderParams(Row)
  end
  else
    ViewParams := IndentViewParams;
end;

procedure TcxCustomRowHeaderInfo.Clear;
begin
  FCaptionsInfo.Clear;
  FLinesInfo.Clear;
  FRowIndents.Clear;
  FCategoryIndents.Clear;
  FButtonRect := cxNullRect;
  FFocusRect := cxNullRect;
end;

procedure TcxCustomRowHeaderInfo.DoCalcExpandButton;
var
  AWidth: Integer;
  AButtonPlace: TRect;
begin
  AWidth := GetButtonPlaceBackgroundWidth;
  with IndentBounds do
    AButtonPlace := cxRect(Right - AWidth, Top, Right, Bottom);
  FButtonRect := cxRectCenter(AButtonPlace, ViewInfo.ButtonSize, ViewInfo.ButtonSize);
end;

function TcxCustomRowHeaderInfo.GetButtonPlaceBackgroundWidth: Integer;
begin
  Result := ViewInfo.RowIndentWidth;
end;

function TcxCustomRowHeaderInfo.GetCaptionViewParams: TcxViewParams;
begin
  Result := FViewParams;
end;

function TcxCustomRowHeaderInfo.GetButtonColor: TColor;
begin
  Result := clWindow;
end;

function TcxCustomRowHeaderInfo.GetFocusRect: TRect;
begin
  Result := cxNullRect;
end;

function TcxCustomRowHeaderInfo.GetTopCentralPoint(AHeight: Integer;
  const R: TRect): Integer;
begin
  Result := R.Top + (cxRectHeight(R) - AHeight) div 2;
end;

function TcxCustomRowHeaderInfo.IncreaseBoundsByLastVertLine: Boolean;
begin
  Result := False;
end;

function TcxCustomRowHeaderInfo.LeftViewPoint: Integer;
begin
  Result := FHeaderRect.Left;
  if (PaintStyle = psDotNet) and (FRowIndents.Count > 0) then
    Result := FRowIndents[FRowIndents.Count - 1].Bounds.Left;
end;

{ TcxCustomRowViewInfo }

constructor TcxCustomRowViewInfo.Create(ARow: TcxCustomRow);
begin
  FRow := ARow;
  FBandIndex := -1;
  FBandRowIndex := -1;
  FValuesInfo := TcxValueInfoList.Create(VerticalGrid.ViewInfo);
  FHeaderInfo := Row.CreateHeaderInfo;
end;

destructor TcxCustomRowViewInfo.Destroy;
begin
  ClearValuesInfo;
  FRow.FViewInfo := nil;
  FreeAndNil(FValuesInfo);
  FreeAndNil(FHeaderInfo);
  inherited Destroy;
end;

procedure TcxCustomRowViewInfo.Calc(const ARowRect: TRect;
  AViewInfo: TcxvgCustomViewInfo; ANextRow: TcxCustomRow);
begin
  FRowRect := ARowRect;
  AViewInfo.CalcRowRects(Self);
  CalcRowHeaderInfo(ANextRow);
  if not FInitialized then
    InitValuesInfo;
  CalcValuesInfo;
  CalcPaintViewParamsLines(ANextRow);
end;

procedure TcxCustomRowViewInfo.Update;
begin
  with VerticalGrid, ViewInfo do
  begin
    if Row = FocusedRow then
      ChangeFocusedRow(Row, PrevVisibleRow(Row))
    else
    begin
      LinesInfo.Locked := True;
      FocusLinesInfo.Locked := True;
      try
        Self.Calc(RowRect, ViewInfo, NextVisibleRow(Row));
      finally
        LinesInfo.Locked := False;
        FocusLinesInfo.Locked := False;
        InvalidateRect(RowRect, False);
      end;
    end;
  end;
end;

procedure TcxCustomRowViewInfo.UpdateRecord(ARecordIndex: Integer);
var
  I: Integer;
  ACellInfo: TcxRowValueInfo;
begin
  CalcValuesInfo;
  for I := 0 to ValuesInfo.Count - 1 do
  begin
    ACellInfo := ValuesInfo[I];
    if ACellInfo.FRecordIndex = ARecordIndex then
    begin
      ACellInfo.Invalidate(True);
      ACellInfo.UpdateEditRect;
    end;  
  end;
end;

procedure TcxCustomRowViewInfo.AddRectValueLines(R: TRect;
  ALast, ABottomLineNeeded: Boolean);
begin
  with ViewInfo do
  begin
    if ALast then
    begin
      if R.Left > ClipRect.Right then Exit;
      if R.Right > ClipRect.Right then R.Right := ClipRect.Right;
    end;
    if ABottomLineNeeded then
      AddBottomValueSide(R);
    AddRightValueSide(R, ALast);
  end;
end;

function TcxCustomRowViewInfo.AddValueInfo(ARecordIndex, ACellIndex: Integer): TcxRowValueInfo;
begin
  Result := GetRowValueInfoClass.Create(Row.GetEditContainer(ACellIndex));
  Result.FRow := Row;
  Result.FRecordIndex := ARecordIndex;
  Result.FRowCellIndex := ACellIndex;
  ValuesInfo.Add(Result);
end;

procedure TcxCustomRowViewInfo.CalculateHeight(ABandWidth: Integer);
begin
  CalculatedHeight := Max(Row.GetRealHeight, ViewInfo.FRowMinHeight);
  CalculatedHeight := Max(CalculatedHeight, GetValuesHeight(ABandWidth, ViewInfo));
end;

procedure TcxCustomRowViewInfo.CalcRowHeaderInfo(ANextRow: TcxCustomRow);
begin
  HeaderInfo.Calc(HeaderInfo.HeaderRect, ViewInfo, ANextRow, True);
end;

procedure TcxCustomRowViewInfo.CalcPaintViewParamsLines(ANextRow: TcxCustomRow);
begin
	ViewInfo.CalcHelper.CalcPaintViewParamsLines(Self, ANextRow);
end;

procedure TcxCustomRowViewInfo.ClearValuesInfo;
begin
  FInitialized := False;
  ValuesInfo.Clear;
end;

function TcxCustomRowViewInfo.GetValuesHeight(ABandWidth: Integer;
  AViewInfo: TcxvgCustomViewInfo): Integer;
begin
  Result := -1;
end;

procedure TcxCustomRowViewInfo.InitValuesInfo;
var
  I, J, ARecordIndex, ACellCount: Integer;
  AValueInfo: TcxRowValueInfo;
begin
  ClearValuesInfo;
  ACellCount := GetEditContainerCount;
  if ACellCount > 0 then
  begin
    ARecordIndex := ViewInfo.FirstVisibleRecordIndex;
    for I := 0 to ViewInfo.VisibleValueCount - 1 do
    begin
      for J := 0 to ACellCount - 1 do
      begin
        AValueInfo := AddValueInfo(ARecordIndex, J);
        AValueInfo.DoCalculate;
      end;
      Inc(ARecordIndex);
    end;
  end;
  FInitialized := True;
end;

function TcxCustomRowViewInfo.GetEditContainerCount: Integer;
begin
  Result := Row.GetEditContainerCount;
end;

function TcxCustomRowViewInfo.GetRowValueInfoClass: TcxRowValueInfoClass;
begin
  Result := TcxRowValueInfo;
end;

function TcxCustomRowViewInfo.GetCalculatedHeight: Integer;
begin
  if not FInitialized then
  begin
    InitValuesInfo;
    CalculateHeight(ViewInfo.ViewBandWidth);
  end;
  Result := FCalculatedHeight;
end;

function TcxCustomRowViewInfo.GetRowValueInfo(ARecordIndex,
  ACellIndex: Integer): TcxRowValueInfo;
var
  I: Integer;
  ARowValueInfo: TcxRowValueInfo;
begin
  Result := nil;
  if ValuesInfo = nil then Exit;
  for I := 0 to ValuesInfo.Count - 1 do
  begin
    ARowValueInfo := ValuesInfo[I];
    with ARowValueInfo do
      if (RecordIndex = ARecordIndex) and (RowCellIndex = ACellIndex) then
      begin
        Result := ARowValueInfo;
        break
      end;
  end;
end;

function TcxCustomRowViewInfo.GetVerticalGrid: TcxCustomVerticalGrid;
begin
  Result := Row.VerticalGrid;
end;

function TcxCustomRowViewInfo.GetViewInfo: TcxvgCustomViewInfo;
begin
  Result := Row.VerticalGrid.ViewInfo;
end;

{ TcxRowViewInfoList }

constructor TcxRowViewInfoList.Create;
begin
  Capacity := 1024;
end;

function TcxRowViewInfoList.Find(ARow: TcxCustomRow): TcxCustomRowViewInfo;
var
  I: Integer;
  AViewInfo: TcxCustomRowViewInfo;
begin
  Result := nil;
  if ARow = nil then Exit;
  for I := 0 to Count - 1 do
  begin
    AViewInfo := List^[I];
    if AViewInfo.Row = ARow then
    begin
      Result := AViewInfo;
      break;
    end;
  end;
end;

function TcxRowViewInfoList.GetItem(Index: Integer): TcxCustomRowViewInfo;
begin
  Result := List^[Index];
end;

{ TcxvgCustomViewInfo }

constructor TcxvgCustomViewInfo.Create(
  AOwner: TcxEditingControl);
begin
  inherited Create(AOwner);
  FVerticalGrid := TcxCustomVerticalGrid(AOwner);
  FLinesInfo := TLineInfoList.Create;
  FFocusLinesInfo := TLineInfoList.Create;
  FRowsViewInfo := TcxRowViewInfoList.Create;
  FViewRects := TViewRects.Create;
  FHorzLineWidth := 1;
  FVertLineWidth := 1;
  FCalcHelper := CreateCalcHelper;
  FLockDividerPos := True;
  CalcLayoutGeneral;
  UpdateScroller;
end;

destructor TcxvgCustomViewInfo.Destroy;
begin
  FreeAndNil(FCalcHelper);
  FreeAndNil(FLinesInfo);
  FreeAndNil(FFocusLinesInfo);
  FreeAndNil(FRowsViewInfo);
  FreeAndNil(FViewRects);
  // destroy rows viewinfos on RecreateViewInfo
  VerticalGrid.FreeRowsViewInfo;
  DestroyBrushes;
  inherited Destroy;
end;

procedure TcxvgCustomViewInfo.CalcEditCell(
  const ABounds: TRect; ARowValueInfo: TcxRowValueInfo);
begin
  if ARowValueInfo <> nil then
    ARowValueInfo.SetBounds(ABounds, ClipRect);
end;

function TcxvgCustomViewInfo.CalcRowHeight(ARow: TcxCustomRow): Integer;
begin
  Result := ARow.ViewInfo.CalculatedHeight;
end;

procedure TcxvgCustomViewInfo.ChangeFocusedRow(
  ANewFocus, AOldFocus: TcxCustomRow);
var
  R: TRect;
begin
  if VerticalGrid.IsLocked then Exit;
  LinesInfo.Locked := True;
  try
    R := CalcHelper.ChangeFocusedRow(ANewFocus, AOldFocus);
  finally
    LinesInfo.Locked := False;
  end;
  Inc(R.Bottom, HorzLineWidth); //
  VerticalGrid.InvalidateRect(R, False);
end;

function TcxvgCustomViewInfo.GetDefaultGridModeBufferCount: Integer;
begin
  Result := GetVisibleValueCount;
end;

function TcxvgCustomViewInfo.GetRowViewInfo(
  ARow: TcxCustomRow): TcxCustomRowViewInfo;
begin
  Result := RowsViewInfo.Find(ARow);
end;

function TcxvgCustomViewInfo.GetValueRect(AValueIndex: Integer;
  ARowViewInfo: TcxCustomRowViewInfo): TRect;
begin
  with ARowViewInfo, RowRect do
    Result := cxRect(ValuesRect.Left, Top, Right, Bottom);
end;

function TcxvgCustomViewInfo.GetValuesRect(
  ARowViewInfo: TcxCustomRowViewInfo): TRect;
begin
  with ARowViewInfo, RowRect do
    Result := cxRect(Left + ViewHeaderWidth + DividerWidth, Top, Right, Bottom);
end;

procedure TcxvgCustomViewInfo.UpdateRecord(ARecordIndex: Integer);
var
  I: Integer;
begin
  if (ARecordIndex < 0) or VerticalGrid.IsLocked then Exit;
  for I := 0 to RowsViewInfo.Count - 1 do
    RowsViewInfo[I].UpdateRecord(ARecordIndex);
end;

function TcxvgCustomViewInfo.CalculateDefaultEditHeight: Integer;
begin
  Result := FRowMinHeight;
end;

procedure TcxvgCustomViewInfo.DoCalculate;
begin
  ClearLinesAndRows;
  CalcLayoutGeneral;
  CalculateBandsInfo;
  CalcViewRects;
  CalcRowsViewInfo;
  CheckRowHeaderWidth;
end;

procedure TcxvgCustomViewInfo.UpdateSelection;
begin
  inherited UpdateSelection;
  VerticalGrid.Controller.RefreshFocusedRow;
end;

procedure TcxvgCustomViewInfo.AddBandRowsLines(const R: TRect);
begin
  with R do
  begin
    if HorzLineWidth > 0 then
    begin
      LinesInfo.Add(Left, Top, Right - Left, HorzLineWidth, BandBorderColor);
      LinesInfo.Add(Left + VertLineWidth, Bottom - HorzLineWidth,
        (Right - Left) - 2 * VertLineWidth, HorzLineWidth, BandBorderColor);
    end;
    if VertLineWidth > 0 then
      LinesInfo.Add(Left, Top + HorzLineWidth, VertLineWidth,
        (Bottom - Top) - HorzLineWidth, BandBorderColor);
  end;
end;

procedure TcxvgCustomViewInfo.AddBottomValueSide(const R: TRect);
begin
  with R do
    if HorzLineWidth > 0 then
      LinesInfo.Add(Left, Bottom, Right - Left, HorzLineWidth, HorzLineBrush);
end;

procedure TcxvgCustomViewInfo.AddRightValueSide(const R: TRect;
  ALast: Boolean);
begin
  with R do
    if VertLineWidth > 0 then
      if ALast then
        LinesInfo.Add(Right, Top, VertLineWidth, Bottom - Top + HorzLineWidth, BandBorderColor)
      else
        LinesInfo.Add(Right, Top, VertLineWidth, Bottom - Top + HorzLineWidth, VertLineBrush);
end;

procedure TcxvgCustomViewInfo.CalcBandRects;
var
  ASumHeight: Integer;
  I: Integer;
begin
  ASumHeight := HorzLineWidth;
  for I := Scroller.TopVisibleRowIndex to VisibleRowCount - 1 do
    Inc(ASumHeight, VisibleRows[I].ViewInfo.CalculatedHeight + HorzLineWidth);
  CreateBand(ASumHeight, ViewBandWidth);
end;

procedure TcxvgCustomViewInfo.CalcBandRowsViewInfo(
  var AFirstRowIndex: Integer; const ABandRect: TRect;
  ABandIndex, ABandRowCount: Integer);
var
  ATop, AWidth, ABandRowIndex: Integer;
  ARow, ANextRow: TcxCustomRow;
  ARowRect: TRect;
  ARowViewInfo: TcxCustomRowViewInfo;
begin
  ABandRowIndex := 0;
  ATop := ABandRect.Top + HorzLineWidth;
  ARow := VisibleRows[AFirstRowIndex];
  AWidth := cxRectWidth(ABandRect) - 2 * VertLineWidth;
  if AWidth > 0 then
    while AFirstRowIndex < VisibleRowCount do
    begin
      if ARow = nil then break;
      ANextRow := VisibleRows[AFirstRowIndex + 1];
      ARowViewInfo := ARow.ViewInfo;
      ARowRect := cxRectBounds(ABandRect.Left + VertLineWidth, ATop, AWidth, ARowViewInfo.CalculatedHeight);
      if not CanAddRowToBand(ARowRect, ABandRect, ABandRowIndex) then break;
      ARowViewInfo.BandIndex := ABandIndex;
      ARowViewInfo.BandRowIndex := ABandRowIndex;
      ARowViewInfo.Calc(ARowRect, Self, ANextRow);
      RowsViewInfo.Add(ARowViewInfo);
      AddBandRowsLines(ABandRect);
      Inc(ATop, ARowViewInfo.CalculatedHeight + HorzLineWidth);
      ARow := ANextRow;
      Inc(AFirstRowIndex);
      Inc(ABandRowIndex);
    end;
end;

procedure TcxvgCustomViewInfo.CalcBandWidth;
begin
  FViewBandWidth := GetViewBandWidth;
  FViewHeaderWidth := GetViewHeaderWidth;
  FViewValueWidth := GetViewValueWidth;
end;

procedure TcxvgCustomViewInfo.CalculateBandsInfo;
begin
  PrepareCalculateBandsInfo;
  Scroller.RecalcBandsInfo;
end;

procedure TcxvgCustomViewInfo.CalcEmpty;
begin
  if ShowHeaders then
    with ClientRect do
      FCalcHelper.AddDivider(LinesInfo, cxRect(Left, Top, Left + ViewHeaderWidth,
        Bottom), clNone, False);
end;

procedure TcxvgCustomViewInfo.CalcCategoryExplorerStyle;
var
  ATheme: TdxTheme;
begin
  FUseCategoryExplorerStyle := VerticalGrid.OptionsView.CategoryExplorerStyle and
    AreVisualStylesAvailable([totExplorerBar]) and
    (VerticalGrid.LookAndFeel.SkinPainter = nil);
  if FUseCategoryExplorerStyle then
  begin
    ATheme := OpenTheme(totExplorerBar);
    if ATheme <> 0 then
      GetThemePartSize(ATheme, 0, EBP_NORMALGROUPEXPAND,
        EBNGE_NORMAL, nil, TS_TRUE, @FExplorerButtonSize)
    else
    begin
      FExplorerButtonSize := cxSize(FButtonSize, FButtonSize);
      FUseCategoryExplorerStyle := False;
    end;
  end
  else
    FExplorerButtonSize := cxSize(FButtonSize, FButtonSize);
end;

procedure TcxvgCustomViewInfo.CalcLayoutGeneral;
begin
  with VerticalGrid do
  begin
    Rows.CheckList;

    FHorzLineWidth := Byte(OptionsView.GridLines in [vglHorizontal, vglBoth]);
    FVertLineWidth := Byte(OptionsView.GridLines in [vglVertical, vglBoth]);

    FClipRect := cxRectInflate(Self.ClientRect, -FVertLineWidth, -FHorzLineWidth);

    FBandsInterval := OptionsView.BandsInterval;
    FRowHeaderMinWidth := OptionsView.RowHeaderMinWidth;
    FShowHeaders := OptionsView.ShowHeaders;
    FButtonSize := LookAndFeel.Painter.ExpandButtonSize;
    if Images <> nil then
      FImageSize := cxSize(Images.Width, Images.Height)
    else
      FImageSize := cxNullSize;
    if (FVertLineWidth > 0) and FShowHeaders then
      DividerWidth := FCalcHelper.GetDividerWidth
    else
      DividerWidth := 0;
    FBandBorderColor := FCalcHelper.GetBandBorderColor;
    FRowIndentWidth := FCalcHelper.GetIndentWidth;
    FBandMinWidth := FRowHeaderMinWidth + OptionsView.ValueMinWidth + DividerWidth;
    FRowMinHeight := GetMinRowHeight;
    if FShowHeaders then
      FFullHeaderWidth := GetViewHeaderWidth + DividerWidth
    else
      FFullHeaderWidth := 0;
    CreateBrushes;
    CalcCategoryExplorerStyle;
  end;
end;

procedure TcxvgCustomViewInfo.CalcRowsHeight;
var
  I: Integer;
  ARowViewInfo: TcxCustomRowViewInfo;
begin
  for I := Scroller.TopVisibleRowIndex to VisibleRowCount - 1 do
  begin
    ARowViewInfo := VisibleRows[I].ViewInfo;
    ARowViewInfo.InitValuesInfo;
    ARowViewInfo.CalculateHeight(ViewValueWidth);
  end;
end;

procedure TcxvgCustomViewInfo.CalcRowRects(ARowViewInfo: TcxCustomRowViewInfo);
begin
  if not CheckShowRowHeader(ARowViewInfo) then Exit;
  with ARowViewInfo, RowRect do
  begin
    FHeaderInfo.HeaderRect := cxRect(Left, Top, Left + ViewHeaderWidth, Bottom);
    FValuesRect := cxRect(Left + ViewHeaderWidth + DividerWidth, Top, Right, Bottom);
  end;
end;

procedure TcxvgCustomViewInfo.CalcRowsViewInfo;
var
  ARowIndex, ABandIndex, ALeftVisibleBand: Integer;
  R: TRect;
begin
  with Scroller do
  begin
    ARowIndex := TopVisibleRowIndex;
    ALeftVisibleBand := LeftVisibleBand;
    for ABandIndex := ALeftVisibleBand to BandsInfo.Count - 1 do
    begin
      if ABandIndex - ALeftVisibleBand > ViewRects.BandRects.Count - 1 then break;
      R := ViewRects.BandRects[ABandIndex - ALeftVisibleBand];
      if R.Left > ClientRect.Right then
        break
      else
        CalcBandRowsViewInfo(ARowIndex, R, ABandIndex, BandsInfo[ABandIndex].RowsCount);
    end;
  end;
  if VisibleRowCount = 0 then
    CalcEmpty;
end;

procedure TcxvgCustomViewInfo.CalcViewRects;
var
  R: TRect;
begin
  ViewRects.Clear;
  if VisibleRowCount = 0 then
  begin
    // make empty band
    R := ClientRect;
    R.Bottom := R.Top;
    ViewRects.BandRects.Add(R);
    ViewRects.EmptyRects.Add(ClientRect);
  end
  else
  begin
    CalcBandRects;
    AddEmptyRects;
  end;
end;

function TcxvgCustomViewInfo.CanAddRowToBand(const ARowRect,
  ABandRect: TRect; ABandRowIndex: Integer): Boolean;
begin
  Result := ARowRect.Top < ABandRect.Bottom;
end;

procedure TcxvgCustomViewInfo.CheckMaxRowHeaderWidth(var Value: Integer; AValueMinWidth: Integer);
begin
end;

procedure TcxvgCustomViewInfo.CheckRowHeaderWidth;
var
  ARowHeaderWidth: Integer;
begin
  if FLockDividerPos then Exit;
  ARowHeaderWidth := VerticalGrid.OptionsView.RowHeaderWidth;
  if not VerticalGrid.IsLoading then
    CheckMaxRowHeaderWidth(ARowHeaderWidth, Max(VerticalGrid.OptionsView.ValueMinWidth, 4));
  ARowHeaderWidth := Max(GetViewMinHeaderWidth, ARowHeaderWidth);
  VerticalGrid.OptionsView.RowHeaderWidth := ARowHeaderWidth;
end;

function TcxvgCustomViewInfo.CheckShowRowHeader(ARowViewInfo: TcxCustomRowViewInfo): Boolean;
begin
  Result := ShowHeaders;
  if not Result then
  begin
    with ARowViewInfo.FHeaderInfo do
    begin
      FHeaderRect := ARowViewInfo.FRowRect;
      FHeaderRect.Right := FHeaderRect.Left;
    end;
    ARowViewInfo.FValuesRect := ARowViewInfo.FRowRect;
  end;
end;

procedure TcxvgCustomViewInfo.CreateBand(ABandHeight,
  ABandWidth: Integer);
var
  ALeft, AClientHeight: Integer;
  R: TRect;
begin
  if ViewRects.BandRects.Count = 0 then
    ALeft := ClientRect.Left
  else
    ALeft := ViewRects.BandRects.Rects[ViewRects.BandRects.Count - 1].Right;
  AClientHeight := cxRectHeight(ClientRect);
  R := cxRectBounds(ALeft, ClientRect.Top, ABandWidth, Min(ABandHeight, AClientHeight));
  ViewRects.BandRects.Add(R);
  with R do
    if Bottom - Top < AClientHeight then
      ViewRects.EmptyRects.Add(cxRectBounds(Left, Bottom, ABandWidth, AClientHeight - (Bottom - Top)));
end;

procedure TcxvgCustomViewInfo.CreateBrushes;
begin
  DestroyBrushes;
  FHorzLineBrush := FCalcHelper.CreateHorzLineBrush;
  FVertLineBrush := FCalcHelper.CreateVertLineBrush;
end;

function TcxvgCustomViewInfo.CreateCalcHelper: TcxvgCustomPaintStyleCalcHelper;
begin
  Result := VerticalGrid.GetCalcHelperClass.Create(Self);
end;

procedure TcxvgCustomViewInfo.DestroyBrushes;

  procedure DestroyBrush(var ABrush: TBrush);
  begin
    if ABrush <> nil then
    begin
      if ABrush.Bitmap <> nil then
        ABrush.Bitmap.Free;
      ABrush.Free;
      ABrush := nil;
    end;
  end;

begin
  DestroyBrush(FHorzLineBrush);
  DestroyBrush(FVertLineBrush);
end;

function TcxvgCustomViewInfo.GetBandSizeableRect(const ABandRect: TRect): TRect;
begin
  with ABandRect do
    Result := cxRect(Right - 1, Top, Right + 2, ClientRect.Bottom);
end;

function TcxvgCustomViewInfo.GetRowAutoHeight(ARow: TcxCustomRow): Boolean;
begin
  Result := VerticalGrid.OptionsView.CellAutoHeight;
  if ARow <> nil then Result := Result and ARow.Options.CanAutoHeight and
    not ARow.IsHeightAssigned;
end;

function TcxvgCustomViewInfo.GetViewBandWidth: Integer;
begin
  Result := ClientRect.Right - ClientRect.Left;
end;

function TcxvgCustomViewInfo.GetViewHeaderWidth: Integer;
begin
  if ShowHeaders then
    Result := Max(GetViewMinHeaderWidth, VerticalGrid.OptionsView.RowHeaderWidth)
  else
    Result := 0;
end;

function TcxvgCustomViewInfo.GetViewMinHeaderWidth: Integer;
begin
  Result := 1 + (RowIndentWidth + VertLineWidth) * (MaxVisibleLevel + 1);
end;

function TcxvgCustomViewInfo.GetViewValueWidth: Integer;
begin
  Result := VerticalGrid.OptionsView.ValueWidth;
end;

procedure TcxvgCustomViewInfo.LayoutStyleChanged;
begin
  if VerticalGrid.SubClassesCreated then
    Scroller.LayoutStyleChanged;
end;

procedure TcxvgCustomViewInfo.PrepareCalculateBandsInfo;
begin
  Reset;
  ClearValuesInfo;
  CalcRowsHeight;
  CalcBandWidth;
end;

procedure TcxvgCustomViewInfo.Reset;
begin
end;

function TcxvgCustomViewInfo.ScaleRowRects(
  ARowViewInfo: TcxCustomRowViewInfo): TRectScaler;
begin
  Result := TRectScaler.Create;
  with Result do
  begin
    Add(ViewHeaderWidth, RowHeaderMinWidth, DividerWidth);
    Add(ViewBandWidth - ViewHeaderWidth, BandMinWidth);
    ScaleRect(ARowViewInfo.RowRect);
  end;
end;

procedure TcxvgCustomViewInfo.SetDividerPos(APos: Integer);
var
  AValueWidth: Integer;
begin
  with VerticalGrid.OptionsView do
    if APos <> RowHeaderWidth then
    begin
      AValueWidth := ViewBandWidth - (APos + DividerWidth);
      if AValueWidth < ValueMinWidth then
        APos := ViewBandWidth - ValueMinWidth;
      RowHeaderWidth := APos;
    end;
end;

procedure TcxvgCustomViewInfo.SetValueWidth(AWidth: Integer);
begin
  VerticalGrid.OptionsView.ValueWidth := AWidth;
end;

procedure TcxvgCustomViewInfo.Clear;
begin
  ClearLinesAndRows;
  ViewRects.Clear;
end;

procedure TcxvgCustomViewInfo.ClearValuesInfo;
var
  I: Integer;
begin
  for I := 0 to VisibleRowCount - 1 do
    VisibleRows[I].ViewInfo.ClearValuesInfo;
end;

procedure TcxvgCustomViewInfo.ClearLinesAndRows;
begin
  FLinesInfo.Clear;
  FFocusLinesInfo.Clear;
  FRowsViewInfo.Clear;
end;

function TcxvgCustomViewInfo.GetBandInfo: TBandInfoList;
begin
  Result := Scroller.ScrollStrategy.BandsInfo;
end;

function TcxvgCustomViewInfo.GetFirstVisibleRecordIndex: Integer;
begin
  if VerticalGrid.RecordCount = 0 then
    Result := -1
  else
    Result := Scroller.LeftVisibleRecord;
end;

function TcxvgCustomViewInfo.GetMaxVisibleLevel: Integer;
begin
  Result := VerticalGrid.Rows.MaxVisibleLevel;
end;

function TcxvgCustomViewInfo.GetMinRowHeight: Integer;
var
  ARowHeight: Integer;
begin
  Result := cxTextHeight(VerticalGrid.Font) + cxTextOffset;
  ARowHeight := VerticalGrid.OptionsView.RowHeight;
  if (ARowHeight >= 0) and (ARowHeight > Result) then
    Result := ARowHeight;
  if FImageSize.cy + 2 > Result then
    Result := FImageSize.cy + 2;
end;

function TcxvgCustomViewInfo.GetPainter: TcxvgPainter;
begin
  Result := TcxvgPainter(inherited Painter);
end;

function TcxvgCustomViewInfo.GetScroller: TcxvgScroller;
begin
  Result := VerticalGrid.Controller.Scroller;
end;

function TcxvgCustomViewInfo.GetVisibleRow(
  Index: Integer): TcxCustomRow;
begin
  if (Index >= 0) and (Index < VisibleRowCount) then
    Result := VerticalGrid.Rows.VisibleRows[Index]
  else
    Result := nil;
end;

function TcxvgCustomViewInfo.GetVisibleRowCount: Integer;
begin
  Result := VerticalGrid.Rows.VisibleRowCount;
end;

procedure TcxvgCustomViewInfo.UpdateScroller;
begin
  Scroller.RecreateScrollStrategy;
end;

{ TcxvgCustomPaintStyleCalcHelper }

constructor TcxvgCustomPaintStyleCalcHelper.Create(
  AViewInfo: TcxvgCustomViewInfo);
begin
  FViewInfo := AViewInfo;
  FVerticalGrid := AViewInfo.VerticalGrid;
  FScroller := AViewInfo.Scroller;
end;

function TcxvgCustomPaintStyleCalcHelper.GetBandBorderColor: TColor;
begin
  Result := VerticalGrid.OptionsView.GridLineColor;
end;

function TcxvgCustomPaintStyleCalcHelper.GetBackgroundColor: TColor;
begin
  Result := GetHeaderColor;
end;

function TcxvgCustomPaintStyleCalcHelper.IsBottomLineNeeded(ANextRow: TcxCustomRow): Boolean;
begin
  Result := ANextRow <> nil;
end;

{ TcxvgDotNetStyleCalcHelper }

procedure TcxvgDotNetStyleCalcHelper.AddBoundHeaderLines(
  ARowHeaderInfo: TcxCustomRowHeaderInfo);
begin
  with ARowHeaderInfo, IndentBounds do
    AddBottomHorzLine(cxRectBounds(Right, Top, HeaderRect.Right - Right, Bottom - Top));
end;

procedure TcxvgDotNetStyleCalcHelper.AddDivider(
  ALinesInfo: TLineInfoList; const R: TRect; AColor: TColor; AIsSeparator: Boolean);
begin
  with ViewInfo, R do
    if DividerWidth > 0 then
      ALinesInfo.Add(Right, Top, VertLineWidth, Bottom - Top + HorzLineWidth, VertLineBrush);
end;

procedure TcxvgDotNetStyleCalcHelper.AddHeaderIndentLines(
  ARowHeaderInfo: TcxCustomRowHeaderInfo; const R: TRect;
  const AViewParams: TcxViewParams;
  AToCategories, AUnderline, AAddVertLine: Boolean);
var
  W: Integer;
begin
  with ViewInfo, R do
  begin
    if not ShowHeaders then Exit;
    if AAddVertLine and (VertLineWidth > 0) then
      ARowHeaderInfo.LinesInfo.Add(Right - VertLineWidth, Top, VertLineWidth,
        Bottom - Top + HorzLineWidth, VertLineBrush);
    if HorzLineWidth > 0 then
    begin
      W := Right - Left;
      if AAddVertLine then Dec(W, VertLineWidth);
      if AUnderline then
        ARowHeaderInfo.LinesInfo.Add(Left, Bottom, W, HorzLineWidth, HorzLineBrush)
      else
        if (AViewParams.Bitmap <> nil) and not AViewParams.Bitmap.Empty then
          ARowHeaderInfo.RowIndents.Add(cxRectBounds(Left, Bottom, W, HorzLineWidth), AViewParams)
        else
          ARowHeaderInfo.LinesInfo.Add(Left, Bottom, W, HorzLineWidth, AViewParams.Color);
    end;
  end;
end;

procedure TcxvgDotNetStyleCalcHelper.CalcPaintViewParamsLines(
  ARowViewInfo: TcxCustomRowViewInfo; ANextRow: TcxCustomRow);
begin
end;

function TcxvgDotNetStyleCalcHelper.ChangeFocusedRow(
  ANewFocus, AOldFocus: TcxCustomRow): TRect;
var
  ARecalcChild: Boolean;

  procedure ProcessRow(ARow: TcxCustomRow);
  var
    ARowViewInfo: TcxCustomRowViewInfo;
    ASaveColor: TColor;
    I: Integer;
    ANextRow: TcxCustomRow;
  begin
    ARowViewInfo := ViewInfo.GetRowViewInfo(ARow);
    if ARowViewInfo = nil then Exit;
    with ARowViewInfo, ViewInfo do
    begin
      ASaveColor := HeaderInfo.IndentViewParams.Color;
      Result := cxRectUnion(Result, RowRect);
      ANextRow := VisibleRows[ARow.VisibleIndex + 1];
      Calc(RowRect, Self.ViewInfo, VisibleRows[ARow.VisibleIndex + 1]);
      ARecalcChild := ARecalcChild or
        ((ASaveColor <> HeaderInfo.IndentViewParams.Color) and (Row is TcxCategoryRow));
      if ARecalcChild and (ANextRow <> nil) then
        for I := ANextRow.VisibleIndex to VisibleRowCount - 1 do
          if ARow.IsParent(VisibleRows[I]) then
            with VisibleRows[I].ViewInfo, HeaderInfo do
            begin
              ANextRow := VisibleRows[ARow.VisibleIndex + 1];
              HeaderInfo.Calc(HeaderRect, Self.ViewInfo, ANextRow, True);
              Result := cxRectUnion(Result, HeaderRect);
            end
            else
              break
    end;
  end;

begin
  Result := cxNullRect;
  ARecalcChild := False;
  ProcessRow(ANewFocus);
  ProcessRow(AOldFocus);
end;

function TcxvgDotNetStyleCalcHelper.GetCategoryColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultHeaderColor;
end;

function TcxvgDotNetStyleCalcHelper.GetCategoryFocusRect(
  ARowHeaderInfo: TcxCustomRowHeaderInfo): TRect;
var
  ATextRect: TRect;
  ASize: TSize;
  ACaption: string;
  AHeaderInfo: TcxCategoryRowHeaderInfo;
  AProperties: TcxCaptionRowProperties;
begin
  Result := cxNullRect;
  if VerticalGrid.FocusedRow <> ARowHeaderInfo.Row then Exit;
  AHeaderInfo := TcxCategoryRowHeaderInfo(ARowHeaderInfo);
  AProperties := AHeaderInfo.Row.Properties;
  ACaption := AProperties.Caption;
  if ACaption = '' then Exit;
  ATextRect := AHeaderInfo.CaptionsInfo[0].CaptionTextRect;
  ASize := cxTextExtent(AHeaderInfo.ViewParams.Font, ACaption);
  with ATextRect do
  begin
    case AProperties.HeaderAlignmentHorz of
      taLeftJustify: Right := Left + ASize.cx;
      taRightJustify: Left := Right - ASize.cx;
    else
      ATextRect := cxRectCenter(ATextRect, ASize.cx, Bottom - Top);
    end;
    case AProperties.HeaderAlignmentVert of
      vaTop: Bottom := Top + ASize.cy;
      vaBottom: Top := Bottom - ASize.cy;
    else
      ATextRect := cxRectCenter(ATextRect, Right - Left, ASize.cy);
    end;
  end;
  cxRectIntersect(Result, cxRectInflate(ATextRect, 1, 1), AHeaderInfo.HeaderRect);
end;

function TcxvgDotNetStyleCalcHelper.GetCategoryTextColor: TColor;
begin
  Result := clGrayText;
end;

function TcxvgDotNetStyleCalcHelper.GetContentColor(AFocused: Boolean): TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultContentColor;
end;

function TcxvgDotNetStyleCalcHelper.GetContentTextColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultContentTextColor;
end;

function TcxvgDotNetStyleCalcHelper.GetHeaderColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultContentColor;
end;

function TcxvgDotNetStyleCalcHelper.GetHeaderTextColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultContentTextColor;
end;

function TcxvgDotNetStyleCalcHelper.GetIndentViewParams(ARow,
  AParentIndentRow: TcxCustomRow): TcxViewParams;
begin
  if ARow <> AParentIndentRow then
    with AParentIndentRow.ViewInfo.HeaderInfo do
    begin
      if AParentIndentRow.VisibleIndex < Scroller.TopVisibleRowIndex then
        CalcViewParams(False);
      Result := IndentViewParams;
    end
  else
    Result := ARow.ViewInfo.HeaderInfo.ViewParams;
end;

function TcxvgDotNetStyleCalcHelper.IsDrawValueFocusRect: Boolean;
begin
  Result := True;
end;

function TcxvgDotNetStyleCalcHelper.CreateHorzLineBrush: TBrush;
begin
  Result := TBrush.Create;
  Result.Color := VerticalGrid.OptionsView.GridLineColor;
end;

function TcxvgDotNetStyleCalcHelper.CreateVertLineBrush: TBrush;
begin
  Result := TBrush.Create;
  Result.Color := VerticalGrid.OptionsView.GridLineColor;
end;

function TcxvgDotNetStyleCalcHelper.GetDividerWidth: Integer;
begin
  Result := 1;
end;

function TcxvgDotNetStyleCalcHelper.GetIndentWidth: Integer;
begin
  Result := ViewInfo.Painter.Painter.ExpandButtonSize + 4;
end;

{ TcxvgStyle3DCalcHelper }

procedure TcxvgStyle3DCalcHelper.AddBoundHeaderLines(
  ARowHeaderInfo: TcxCustomRowHeaderInfo);
begin
  if ViewInfo.HorzLineWidth > 0 then
    with ARowHeaderInfo, HeaderRect do
      LinesInfo.Add(Left, Bottom, Right - Left,
        ViewInfo.HorzLineWidth, ViewInfo.HorzLineBrush);
end;

procedure TcxvgStyle3DCalcHelper.AddHeaderIndentLines(
  ARowHeaderInfo: TcxCustomRowHeaderInfo; const R: TRect;
  const AViewParams: TcxViewParams;
  AToCategories, AUnderline, AAddVertLine: Boolean);
begin
end;

procedure TcxvgStyle3DCalcHelper.AddDivider(ALinesInfo: TLineInfoList;
  const R: TRect; AColor: TColor; AIsSeparator: Boolean);
begin
  with ViewInfo, R do
    if DividerWidth > 0 then
      if AIsSeparator then
      begin
        ALinesInfo.Add(Right, Top, 2, 2, AColor);
        ALinesInfo.Add(Right, Bottom - 2, 2, 2, AColor);
        ALinesInfo.Add(Right, Top + 2, 1, Bottom - Top + HorzLineWidth - 5, clBtnShadow);
        ALinesInfo.Add(Right + 1, Top + 2, 1, Bottom - Top + HorzLineWidth - 5, clBtnHighlight);
      end
      else
      begin
        ALinesInfo.Add(Right, Top, 1, Bottom - Top + HorzLineWidth, clBtnShadow);
        ALinesInfo.Add(Right + 1, Top, 1, Bottom - Top + HorzLineWidth, clBtnHighlight);
      end;
end;

procedure TcxvgStyle3DCalcHelper.CalcPaintViewParamsLines(
  ARowViewInfo: TcxCustomRowViewInfo; ANextRow: TcxCustomRow);
var
  AFocusedRowBandIndex: Integer;
  R: TRect;
begin
  if VerticalGrid.FocusedRow = nil then Exit;
  R := ARowViewInfo.RowRect;
  with R do
  begin
    if ANextRow = VerticalGrid.FocusedRow then
    begin
      AFocusedRowBandIndex := Scroller.GetBandIndexByRowIndex(ANextRow.VisibleIndex);
      if AFocusedRowBandIndex = ARowViewInfo.BandIndex then
      begin
        ViewInfo.FocusLinesInfo.Add(Left, Bottom - 1, Right - Left, 1, cl3DDkShadow);
        ViewInfo.FocusLinesInfo.Add(Left + 1, Bottom, Right - Left - 1, 1, clBtnShadow);
      end;
    end;
    if ARowViewInfo.Row = VerticalGrid.FocusedRow then
    begin
      ViewInfo.FocusLinesInfo.Add(Left, Bottom - 1, Right - Left, 1, clBtnFace);
      ViewInfo.FocusLinesInfo.Add(Left, Bottom, Right - Left, 1, clBtnHighlight);
      ViewInfo.FocusLinesInfo.Add(Left, Top - 1, 1, Bottom - Top + 1, cl3DDkShadow);
      ViewInfo.FocusLinesInfo.Add(Left + 1, Top, 1, Bottom - Top - 1, clBtnShadow);
    end;
  end;
end;

function TcxvgStyle3DCalcHelper.ChangeFocusedRow(
  ANewFocus, AOldFocus: TcxCustomRow): TRect;

  procedure ProcessRow(ARow: TcxCustomRow);
  var
    ARowViewInfo: TcxCustomRowViewInfo;
  begin
    ARowViewInfo := ViewInfo.GetRowViewInfo(ARow);
    if ARowViewInfo = nil then Exit;
    with ViewInfo do
    begin
      with ARowViewInfo do
      begin
        Result := cxRectUnion(Result, RowRect);
        Calc(RowRect, ViewInfo, VisibleRows[ARow.VisibleIndex + 1]);
      end;
      ARowViewInfo := GetRowViewInfo(VisibleRows[ARow.VisibleIndex - 1]);
      if ARowViewInfo <> nil then
        with ARowViewInfo do
        begin
          Calc(RowRect, ViewInfo, ARow);
          Result := cxRectUnion(Result, RowRect);
        end;
      if HorzLineWidth = 0 then
        Inc(Result.Bottom); 
    end;
  end;

begin
  Result := cxNullRect;
  ViewInfo.FocusLinesInfo.Clear;
  ProcessRow(ANewFocus);
  ProcessRow(AOldFocus);
end;

function TcxvgStyle3DCalcHelper.GetCategoryColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultHeaderColor;
end;

function TcxvgStyle3DCalcHelper.GetCategoryFocusRect(
  ARowHeaderInfo: TcxCustomRowHeaderInfo): TRect;
begin
  Result := cxNullRect;
end;

function TcxvgStyle3DCalcHelper.GetCategoryTextColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultHeaderTextColor;
end;

function TcxvgStyle3DCalcHelper.GetContentColor(AFocused: Boolean): TColor;
begin
  if AFocused then
    Result := ViewInfo.Painter.Painter.DefaultContentColor
  else
    Result := ViewInfo.Painter.Painter.DefaultHeaderColor;
end;

function TcxvgStyle3DCalcHelper.GetContentTextColor: TColor;
begin
  Result := clNavy;
end;

function TcxvgStyle3DCalcHelper.GetHeaderColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultHeaderColor;
end;

function TcxvgStyle3DCalcHelper.GetHeaderTextColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultHeaderTextColor;
end;

function TcxvgStyle3DCalcHelper.GetIndentViewParams(ARow,
  AParentIndentRow: TcxCustomRow): TcxViewParams;
begin
  Result := ARow.ViewInfo.HeaderInfo.ViewParams;
end;

function TcxvgStyle3DCalcHelper.IsDrawValueFocusRect: Boolean;
begin
  Result := False;
end;

function TcxvgStyle3DCalcHelper.CreateHorzLineBrush: TBrush;
begin
  Result := cxCreateHalftoneBrush(VerticalGrid.OptionsView.GridLineColor, clBtnFace);
end;

function TcxvgStyle3DCalcHelper.CreateVertLineBrush: TBrush;
begin
  Result := cxCreateHalftoneBrush(VerticalGrid.OptionsView.GridLineColor, clBtnFace);
end;

function TcxvgStyle3DCalcHelper.GetDividerWidth: Integer;
begin
  Result := 2;
end;

function TcxvgStyle3DCalcHelper.GetIndentWidth: Integer;
begin
  Result := ViewInfo.Painter.Painter.ExpandButtonSize + 4;
end;

{ TcxvgSkinCalcHelper }

procedure TcxvgSkinCalcHelper.AddBoundHeaderLines(
  ARowHeaderInfo: TcxCustomRowHeaderInfo);
begin
  if ARowHeaderInfo is TcxCategoryRowHeaderInfo then
  begin
    if ARowHeaderInfo.ViewInfo.HorzLineWidth > 0 then
    begin
      with ARowHeaderInfo, IndentBounds do
      begin
        ARowHeaderInfo.LinesInfo.Add(Right, Top - ViewInfo.HorzLineWidth,
          HeaderRect.Right - Right, ViewInfo.HorzLineWidth, ViewInfo.BandBorderColor);
        ARowHeaderInfo.LinesInfo.Add(Right, Bottom, HeaderRect.Right - Right,
          ViewInfo.HorzLineWidth, ViewInfo.BandBorderColor);
      end;
    end;
  end
  else
    inherited AddBoundHeaderLines(ARowHeaderInfo);     
end;

procedure TcxvgSkinCalcHelper.AddHeaderIndentLines(ARowHeaderInfo: TcxCustomRowHeaderInfo;
  const R: TRect; const AViewParams: TcxViewParams; AToCategories, AUnderline,
  AAddVertLine: Boolean);
begin
  inherited AddHeaderIndentLines(ARowHeaderInfo, R, AViewParams, AToCategories,
    AUnderline, AAddVertLine);
  if not ViewInfo.ShowHeaders then Exit;
  if AToCategories and (ViewInfo.VertLineWidth > 0) then
  begin
    if ARowHeaderInfo is TcxCategoryRowHeaderInfo then
      if ARowHeaderInfo.IndentBounds.Right = R.Right then
        ARowHeaderInfo.LinesInfo.Add(R.Left, R.Top - ViewInfo.HorzLineWidth,
          R.Right - R.Left, ViewInfo.HorzLineWidth, ViewInfo.BandBorderColor);
    if AAddVertLine then
      ARowHeaderInfo.LinesInfo.Add(R.Right - ViewInfo.VertLineWidth,
        R.Top - ViewInfo.HorzLineWidth, ViewInfo.VertLineWidth,
        R.Bottom - R.Top + ViewInfo.HorzLineWidth, ViewInfo.BandBorderColor);
    if AUnderline then
      ARowHeaderInfo.LinesInfo.Add(R.Left, R.Bottom, R.Right - R.Left,
        ViewInfo.HorzLineWidth, ViewInfo.BandBorderColor);
  end;
end;

function TcxvgSkinCalcHelper.GetBackgroundColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultContentColor;
end;

function TcxvgSkinCalcHelper.GetCategoryColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultVGridCategoryColor;
end;

function TcxvgSkinCalcHelper.GetCategoryTextColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultVGridCategoryTextColor;
  if Result = clDefault then
    Result := inherited GetCategoryTextColor;
end;

function TcxvgSkinCalcHelper.GetHeaderColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultVGridHeaderColor;
  if Result = clDefault then
    Result := inherited GetHeaderColor;
end;

function TcxvgSkinCalcHelper.GetHeaderTextColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultVGridHeaderTextColor;
  if Result = clDefault then
    Result := inherited GetHeaderTextColor;
end;

function TcxvgSkinCalcHelper.CreateHorzLineBrush: TBrush;
begin
  Result := TBrush.Create;
  Result.Color := ViewInfo.Painter.Painter.DefaultVGridLineColor; 
end;

function TcxvgSkinCalcHelper.CreateVertLineBrush: TBrush;
begin
  Result := TBrush.Create;
  Result.Color := ViewInfo.Painter.Painter.DefaultVGridLineColor;
end;

function TcxvgSkinCalcHelper.GetBandBorderColor: TColor;
begin
  Result := ViewInfo.Painter.Painter.DefaultVGridBandLineColor;
end;

function TcxvgSkinCalcHelper.IsBottomLineNeeded(ANextRow: TcxCustomRow): Boolean;
begin
  Result := not (ANextRow is TcxCategoryRow);
end;

{ TcxvgPainter }

constructor TcxvgPainter.Create(AOwner: TcxEditingControl);
begin
  inherited Create(AOwner);
  Buffered := True;
end;

procedure TcxvgPainter.DrawBackground;
var
  I: Integer;
  AParams: TcxViewParams;
  R: TRect;
begin
  AParams := VerticalGrid.Styles.GetBackgroundParams;
  with ViewInfo.ViewRects.EmptyRects, VerticalGrid do
    for I := 0 to Count - 1 do
    begin
      R := Rects[I];
      if not DoDrawBackgroundPart(R, AParams) then
      begin
        Self.Canvas.Brush.Color := AParams.Color;
        FillRect(R, AParams.Bitmap);
      end;
    end;
end;

procedure TcxvgPainter.DoPaint;
begin
  DrawBackground;
  DrawRows;
  with ViewInfo do
    DrawLines(LinesInfo, ClientRect);
  DrawStyleFeatures;
end;

procedure TcxvgPainter.DrawButton(ARowHeader: TcxCustomRowHeaderInfo);
begin
  with ARowHeader do
  begin
    if cxRectIsEmpty(ButtonRect) then Exit;
    Painter.DrawExpandButton(Canvas, ButtonRect, Row.Expanded, ButtonColor);
    if not Buffered then
      Canvas.ExcludeClipRect(ButtonRect);
  end;
end;

procedure TcxvgPainter.DrawCategoryRowHeader(ARowHeader: TcxCustomRowHeaderInfo);
const
  Parts: array[Boolean, 0..1] of Integer = (
  (EBP_NORMALGROUPEXPAND, EBNGE_NORMAL),
  (EBP_NORMALGROUPCOLLAPSE, EBNGC_NORMAL));
var
  R: TRect;
  ATheme: TdxTheme;
begin
  if ViewInfo.UseCategoryExplorerStyle and (VerticalGrid.LookAndFeel.SkinPainter = nil) then
    with ARowHeader do
    begin
      DrawCategoryRowIndent(ARowHeader);
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := ViewParams.Color;
      R := HeaderRect;
      if (Row.Level > 0) and (PaintStyle = psDotNet) then
        R.Left := IndentBounds.Right - (ViewInfo.RowIndentWidth + ViewInfo.VertLineWidth);
      Canvas.FillRect(R);
      ATheme := OpenTheme(totExplorerBar);
      if ATheme <> 0 then
      begin
        DrawThemeBackground(ATheme, Canvas.Handle, EBP_NORMALGROUPHEAD, 0, @R);
        if not cxRectIsEmpty(ButtonRect) and (ButtonRect.Left >= R.Left) then
        begin
          R := ButtonRect;
          DrawThemeBackground(ATheme, Canvas.Handle, Parts[Row.Expanded, 0],
            Parts[Row.Expanded, 1], @R);
        end;
        if CaptionsInfo.Count > 0 then
          with CaptionsInfo[0] do
          begin
            Canvas.Brush.Style := bsClear;
            Canvas.Font := ViewParams.Font;
            Canvas.Font.Color := ViewParams.TextColor;
            R := CaptionTextRect;
            cxTextOut(Canvas.Canvas, Caption, R, TextFlags);
            Canvas.Brush.Style := bsSolid;
            DrawImage(CaptionsInfo[0]);
          end;
        DrawLines(LinesInfo, cxNullRect);
        if not cxRectIsEmpty(FocusRect) and not VerticalGrid.IsDesigning then
          Canvas.DrawFocusRect(FocusRect);
        if Selected then
        begin
          Canvas.DrawFocusRect(HeaderRect);
          Canvas.DrawFocusRect(cxRectInflate(HeaderRect, -1, -1));
        end;
      end
      else
        DrawRowHeader(ARowHeader);
    end
  else
    DrawRowHeader(ARowHeader);
end;

procedure TcxvgPainter.DrawCategoryRowIndent(ARowHeader: TcxCustomRowHeaderInfo);
var
  I: Integer;
begin
  with ARowHeader do
  begin
    if Transparent then Exit;
    for I := 0 to CategoryIndents.Count - 2 do
      with CategoryIndents[I]^ do
      begin
        Canvas.Brush.Color := ViewParams.Color;
        Canvas.FillRect(Bounds);
      end;
    for I := 0 to RowIndents.Count - 1 do
      with RowIndents[I]^ do
      begin
        Canvas.Brush.Color := ViewParams.Color;
        Canvas.FillRect(Bounds);
      end;
  end;
end;

procedure TcxvgPainter.DrawHeaderDragImage(ARowHeader: TcxCustomRowHeaderInfo);
var
  I: Integer;
  R: TRect;
begin
  with ARowHeader do
  begin
    for I := 0 to CaptionsInfo.Count - 1 do
      DrawRowHeaderCell(CaptionsInfo[I], Transparent);
    if ARowHeader is TcxMultiEditorRowHeaderInfo then
    begin
      DrawLines(LinesInfo, cxNullRect);
      DrawHeaderSeparators(ARowHeader);
    end;  
    R := HeaderRect;
    R.Left := IndentBounds.Right;
    Canvas.FrameRect(R, ViewInfo.BandBorderColor);
  end;
end;

procedure TcxvgPainter.DrawHeaderSeparators(ARowHeader: TcxCustomRowHeaderInfo);
var
  I: Integer;
  AOffset, R: TRect;
begin
  if not (ARowHeader is TcxMultiEditorRowHeaderInfo) then Exit;
  with TcxMultiEditorRowHeaderInfo(ARowHeader) do
  begin
    Canvas.Brush.Color := SeparatorInfo.ViewParams.Color;
    Canvas.Font.Color := SeparatorInfo.ViewParams.TextColor;
    AOffset := GetTextEditDrawTextOffset(taLeftJustify, True);
    for I := 0 to SeparatorRects.Count - 1 do
    begin
      R := SeparatorRects[I];
      if cxRectIsEmpty(R) then continue;
      if not Transparent then
        FillRect(R, SeparatorInfo.ViewParams.Bitmap);
      with R do
      begin
        Inc(Top, AOffset.Top + 1);
        Inc(Left, AOffset.Left + 1);
        Dec(Bottom, AOffset.Bottom + 1);
        Dec(Right, AOffset.Right + 1);
      end;
      cxTextOut(Canvas.Canvas, SeparatorInfo.Caption, R, SeparatorInfo.TextFlags);
    end;
  end;
end;

procedure TcxvgPainter.DrawImage(ACaptionInfo: TcxRowCaptionInfo);
var
  ARgn: TcxRegion;
  R: TRect;
begin
  with ACaptionInfo do
  begin
    if ImageIndex = -1 then Exit;
    ARgn := Canvas.GetClipRegion;
    try
      cxRectIntersect(R, ImageRect, CaptionRect);
      Canvas.IntersectClipRect(R);
      Canvas.DrawImage(Images, ImageRect.Left, ImageRect.Top, ImageIndex);
    finally
      Canvas.SetClipRegion(ARgn, roSet);
    end;
  end;
end;

procedure TcxvgPainter.DrawLines(ALinesInfo: TLineInfoList; R: TRect);
var
  I: Integer;
begin
  for I := 0 to ALinesInfo.Count - 1 do
    with ALinesInfo[I]^ do
    begin
      if IsBrush then
        Canvas.Brush.Assign(Brush)
      else
        Canvas.Brush.Color := Color;
      Canvas.FillRect(Rect);
    end;
end;

procedure TcxvgPainter.DrawRow(ARowViewInfo: TcxCustomRowViewInfo);
var
  I: Integer;
  AValueInfo: TcxRowValueInfo;
begin
  with ARowViewInfo do
  begin
    if ARowViewInfo is TcxCategoryRowViewInfo then
    begin
      if not VerticalGrid.DoDrawRowHeader(HeaderInfo) then
        DrawCategoryRowHeader(HeaderInfo)
    end
    else
    begin
      if not VerticalGrid.DoDrawRowHeader(HeaderInfo) then
        DrawRowHeader(HeaderInfo);
      DrawHeaderSeparators(HeaderInfo);
      DrawValuesSeparators(ARowViewInfo);
      for I := 0 to ValuesInfo.Count - 1 do
      begin
        AValueInfo := ValuesInfo[I];
        BeforeCustomDraw(AValueInfo);
        if not VerticalGrid.DoDrawValue(AValueInfo) then
        begin
          AValueInfo.EditViewInfo.TextColor := Canvas.Font.Color;
          AValueInfo.EditViewInfo.BackgroundColor := Canvas.Brush.Color;
          DrawRowValueCell(AValueInfo);
        end;
        AfterCustomDraw(AValueInfo);
      end;
    end;
    DrawLines(HeaderInfo.LinesInfo, cxNullRect);
  end;
end;

procedure TcxvgPainter.DrawRowHeader(ARowHeader: TcxCustomRowHeaderInfo);
var
  I: Integer;
begin
  DrawRowIndent(ARowHeader);
  with ARowHeader do
  begin
    for I := 0 to CaptionsInfo.Count - 1 do
      DrawRowHeaderCell(CaptionsInfo[I], Transparent);
    if not cxRectIsEmpty(FocusRect) then
      Canvas.DrawFocusRect(FocusRect);
    if Selected then
    begin
      Canvas.DrawFocusRect(HeaderRect);
      Canvas.DrawFocusRect(cxRectInflate(HeaderRect, -1, -1));
    end;
  end;
end;

procedure TcxvgPainter.DrawRowHeaderCell(
  ACaptionInfo: TcxRowCaptionInfo; ATransparent: Boolean);
var
  R: TRect;
begin
  with ACaptionInfo do
  begin
    cxApplyViewParams(Canvas, ViewParams);
    if not ATransparent then
      FillRect(CaptionRect, ViewParams.Bitmap);
    Canvas.Brush.Style := bsClear;
    R := CaptionTextRect;
    cxTextOut(Canvas.Canvas, Caption, R, TextFlags);
    Canvas.Brush.Style := bsSolid;
    DrawImage(ACaptionInfo);
  end;
end;

procedure TcxvgPainter.DrawRowIndent(
  ARowHeader: TcxCustomRowHeaderInfo);
var
  I: Integer;
begin
  if ARowHeader.Transparent then Exit;
  if not Buffered then DrawButton(ARowHeader);
  with ARowHeader do
  begin
    for I := 0 to CategoryIndents.Count - 1 do
      with CategoryIndents[I]^ do
      begin
        Canvas.Brush.Color := ViewParams.Color;
        FillRect(Bounds, ViewParams.Bitmap);
      end;
    for I := 0 to RowIndents.Count - 1 do
      with RowIndents[I]^ do
      begin
        Canvas.Brush.Color := ViewParams.Color;
        FillRect(Bounds, ViewParams.Bitmap);
      end;
  end;
  if Buffered then DrawButton(ARowHeader);
end;

procedure TcxvgPainter.DrawRows;
var
  I: Integer;
  ARowInfo: TcxCustomRowViewInfo;
begin
  for I := 0 to ViewInfo.RowsViewInfo.Count - 1 do
  begin
    ARowInfo := ViewInfo.RowsViewInfo[I];
    if Canvas.RectVisible(ARowInfo.RowRect) then
      DrawRow(ARowInfo);
  end;
end;

procedure TcxvgPainter.DrawStyleFeatures;
begin
end;

procedure TcxvgPainter.DrawRowValueCell(AValueInfo: TcxRowValueInfo);
begin       
  with AValueInfo do
  begin
    if cxRectIsEmpty(DisplayRect) then Exit;
    if ViewParams.Bitmap <> nil then
      Canvas.FillRect(DisplayRect, ViewParams.Bitmap);
    ViewInfo.PaintEx(Canvas);
    if Focused and Self.ViewInfo.CalcHelper.IsDrawValueFocusRect and
      not cxRectIsEmpty(FFocusRect) then
      Canvas.DrawFocusRect(BoundsRect);
  end;
end;

procedure TcxvgPainter.DrawValuesSeparators(ARowViewInfo: TcxCustomRowViewInfo);
var
  I, ASepPerRecord: Integer;
  AViewParams: TcxViewParams;
  ASeparatorInfo: TSeparatorInfo;
  R, AOffset: TRect;
  AStyle: TcxStyle;
  AData: TcxvgContentParamsData;
begin
  if not (ARowViewInfo is TcxMultiEditorRowViewInfo) then Exit;
  with TcxMultiEditorRowViewInfo(ARowViewInfo) do
  begin
    if (FValuesInfo.Count = 0) or (SeparatorRects.Count = 0) then Exit;
    ASeparatorInfo := TcxMultiEditorRowHeaderInfo(HeaderInfo).SeparatorInfo;
    AOffset := GetTextEditDrawTextOffset(taLeftJustify, True);
    ASepPerRecord := Row.Properties.Editors.Count - 1;
    for I := 0 to SeparatorRects.Count - 1 do
    begin
      R := SeparatorRects[I];
      if cxRectIsEmpty(R) then continue;
      with VerticalGrid.Styles do
      begin
        AStyle := nil;
        if Assigned(FOnGetContentStyle) then
          FOnGetContentStyle(Control, nil, False,
            ViewInfo.FirstVisibleRecordIndex + (I div ASepPerRecord), AStyle);
        AData.Row := Row;
        AData.Focused := False;
        cxStylesToViewParams(VerticalGrid.Styles, vgs_Content, @AData,
          [AStyle, Content], AViewParams);
      end;
      Canvas.Brush.Color :=  AViewParams.Color;
      Canvas.Font.Color := AViewParams.TextColor;
      FillRect(R, AViewParams.Bitmap);
      with R do
      begin
        Inc(Top, AOffset.Top + 1);
        Inc(Left, AOffset.Left + 1);
        Dec(Bottom, AOffset.Bottom + 1);
        Dec(Right, AOffset.Right + 1);
      end;
      cxTextOut(Canvas.Canvas, ASeparatorInfo.Caption, R,
        ASeparatorInfo.TextFlags);
    end;
  end;
end;

procedure TcxvgPainter.FillRect(const R: TRect; ABitmap: TBitmap = nil);
begin
  if (ABitmap = nil) or ABitmap.Empty then
    Canvas.FillRect(R)
  else
    Canvas.FillRect(R, ABitmap);
end;

function TcxvgPainter.GetVerticalGrid: TcxCustomVerticalGrid;
begin
  Result := TcxCustomVerticalGrid(Control);
end;

function TcxvgPainter.GetViewInfo: TcxvgCustomViewInfo;
begin
  Result := TcxvgCustomViewInfo(inherited ViewInfo);
end;

{ TcxStyle3DPainter }

procedure TcxStyle3DPainter.DrawStyleFeatures;
begin
  with ViewInfo do
    DrawLines(FocusLinesInfo, ClientRect);
end;

{ TcxvgCustomRowStyles }

procedure TcxvgCustomRowStyles.Changed(AIndex: Integer);
begin
  TcxCustomRow(GetOwner).Changed;
end;

{ TcxCategoryRowStyles }

procedure TcxCategoryRowStyles.Assign(Source: TPersistent);
begin
  if Source is TcxCategoryRowStyles then
    SetValue(vgrs_Header, TcxCategoryRowStyles(Source).GetValue(vgrs_Header));
  inherited Assign(Source);
end;

{ TcxEditorRowStyles }

procedure TcxEditorRowStyles.Assign(Source: TPersistent);
begin
  if Source is TcxEditorRowStyles then
    SetValue(vgrs_Content, TcxCategoryRowStyles(Source).GetValue(vgrs_Content));
  inherited Assign(Source);
end;

{ TcxVerticalGridStyleSheet }

function TcxVerticalGridStyleSheet.GetStylesValue: TcxVerticalGridStyles;
begin
  Result := TcxVerticalGridStyles(GetStyles)
end;

procedure TcxVerticalGridStyleSheet.SetStylesValue(Value: TcxVerticalGridStyles);
begin
  SetStyles(Value);
end;

class function TcxVerticalGridStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxVerticalGridStyles;
end;

{ TcxVerticalGridStyles }

procedure TcxVerticalGridStyles.Assign(Source: TPersistent);
var
  I: Integer;
begin
  inherited Assign(Source);
  if Source is TcxVerticalGridStyles then
    for I := vgs_Category to vgs_IncSearch do
      SetValue(I, TcxVerticalGridStyles(Source).GetValue(I));
end;

function TcxVerticalGridStyles.GetCategoryParams(
  ARow: TcxCustomRow): TcxViewParams;
begin
  cxStylesToViewParams(Self, vgs_Category, ARow,
    [GetStyleFromEvent(FOnGetCategoryStyle, ARow),
     TcxCategoryRowStyles(ARow.FStyles).Header, Category], Result)
end;

function TcxVerticalGridStyles.GetContentParams(
  AEditProp: TcxCustomEditorRowProperties;
  AFocused: Boolean; ARecordIndex: Integer): TcxViewParams;
var
  AStyle: TcxStyle;
  AData: TcxvgContentParamsData;
begin
  AStyle := nil;
  if Assigned(FOnGetContentStyle) then
    FOnGetContentStyle(Control, AEditProp, AFocused, ARecordIndex, AStyle);
  AData.Row := AEditProp.Row;
  AData.Focused := AFocused;
  cxStylesToViewParams(Self, vgs_Content, @AData, [AStyle,
    TcxEditorRowStyles(AEditProp.Row.FStyles).Content, Content], Result);
end;

function TcxVerticalGridStyles.GetHeaderParams(
  ARow: TcxCustomRow): TcxViewParams;
begin
  cxStylesToViewParams(Self, vgs_Header, ARow,
    [GetStyleFromEvent(FOnGetHeaderStyle, ARow),
     TcxCategoryRowStyles(ARow.FStyles).Header, Header], Result)
end;

function TcxVerticalGridStyles.GetIncSearchParams: TcxViewParams;
begin
  GetViewParams(vgs_IncSearch, nil, IncSearch, Result);
end;

function TcxVerticalGridStyles.GetSelectedHeaderParams(
  ARow: TcxCustomRow): TcxViewParams;
begin
  Result := GetSelectionParams;
  CombineParamsWithStyle(GetStyleFromEvent(FOnGetHeaderStyle, ARow), [], Result)
end;

procedure TcxVerticalGridStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
begin
  TcxCustomVerticalGrid(Control).GetDefaultViewParams(Index, AData, AParams);
end;

function TcxVerticalGridStyles.GetStyleFromEvent(
  const AEvent: TcxvgOnGetItemStyleEvent; AItem: TcxCustomRow): TcxStyle;
begin
  Result := nil;
  if Assigned(AEvent) then AEvent(Control, AItem, Result);
end;

procedure TcxVerticalGridStyles.CallInheritedDefaultViewParams(Index: Integer;
  AData: Pointer; out AParams: TcxViewParams);
begin
  inherited GetDefaultViewParams(Index, AData, AParams);
end;

{ TcxVerticalGridItemsCustomizeListBox }

constructor TcxVerticalGridItemsCustomizeListBox.CreateEx(AOwner: TComponent;
  AVerticalGrid: TcxCustomVerticalGrid; IsCategoryListBox: Boolean);
begin
  inherited Create(AOwner);
  FVerticalGrid := AVerticalGrid;
  FIsCategoryListBox := IsCategoryListBox;
  Style := lbOwnerDrawFixed;
  FCanvas := TcxCanvas.Create(inherited Canvas);
  DoubleBuffered := True;
  FDragAndDropItemIndex := -1;
end;

procedure TcxVerticalGridItemsCustomizeListBox.DragDrop(Source: TObject;
  X, Y: Integer);
begin
  if (Source = VerticalGrid) and (DragRow <> nil) then
    VerticalGrid.DragDrop(Source, X, Y);
end;

destructor TcxVerticalGridItemsCustomizeListBox.Destroy;
begin
  FreeAndNil(FCanvas);
  inherited Destroy;
end;

procedure TcxVerticalGridItemsCustomizeListBox.CalcHeaderViewInfo(
  const R: TRect; AHeaderInfo: TcxCustomRowHeaderInfo);
begin
  AHeaderInfo.Calc(R, VerticalGrid.ViewInfo, nil, False);
end;

procedure TcxVerticalGridItemsCustomizeListBox.DragOver(Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = VerticalGrid) and (DragRow <> nil) and
   (DragRow.Options.CanMovedToCustomizationForm);
end;

procedure TcxVerticalGridItemsCustomizeListBox.DrawItem(
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  ACanvas: TcxCanvas;
  AHeaderInfo: TcxCustomRowHeaderInfo;
begin
  AHeaderInfo := TcxCustomRowHeaderInfo(Items.Objects[Index]);
  with AHeaderInfo, Painter do
  begin
    ACanvas := FCanvas;
    FCanvas := Self.Canvas;
    try
      CalcHeaderViewInfo(Rect, AHeaderInfo);
      DrawHeaderDragImage(AHeaderInfo);
      if ItemIndex = Index then FCanvas.InvertRect(Rect);
    finally
      FCanvas := ACanvas;
    end;
  end;
end;

procedure TcxVerticalGridItemsCustomizeListBox.InitDragAndDropObject;
var
  AHeaderInfo: TcxCustomRowHeaderInfo;
  R: TRect;
begin
  with VerticalGrid.Controller do
    if IsEditing then EditingController.HideEdit(False);
  AHeaderInfo := TcxCustomRowHeaderInfo(Items.Objects[FDragAndDropItemIndex]);
  R := cxRectOffset(ItemRect(FDragAndDropItemIndex), -FMouseDownPos.X, -FMouseDownPos.Y);
  CalcHeaderViewInfo(R, AHeaderInfo);
  VerticalGrid.Controller.FDragRow := AHeaderInfo.Row;
  VerticalGrid.DragPos := cxPointOffset(R.TopLeft, FOffset);
  VerticalGrid.BeginDrag(True);
end;

procedure TcxVerticalGridItemsCustomizeListBox.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AItem: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) then
  begin
    AItem := ItemAtPos(Point(X, Y), True);
    if AItem <> - 1 then
    begin
      with ItemRect(AItem) do
        FOffset := Point(X - TopLeft.X, Y - TopLeft.Y);
      FDragging := True;
      FDragAndDropItemIndex := ItemIndex;
      FMouseDownPos := Point(X, Y);
      Invalidate;
    end;
  end;
end;

procedure TcxVerticalGridItemsCustomizeListBox.MouseMove(
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if (FDragAndDropItemIndex <> -1) and not IsPointInDragDetectArea(FMouseDownPos, X, Y) then
  begin
    InitDragAndDropObject;
    FDragAndDropItemIndex := -1;
  end;
end;

procedure TcxVerticalGridItemsCustomizeListBox.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FDragging := False;
  FDragAndDropItemIndex := -1;
  Invalidate;
  VerticalGrid.Controller.CheckEdit;
end;

procedure TcxVerticalGridItemsCustomizeListBox.RefreshList;

   procedure CheckRow(ARow: TcxCustomRow; AIsCategory: Boolean);
   begin
     if ((ARow is TcxCategoryRow) = AIsCategory) and not ARow.Visible and
       ARow.Options.ShowInCustomizationForm then
         Items.AddObject('', ARow.ViewInfo.HeaderInfo);
   end;

var
  I: Integer;
  ASaveIndex: Integer;
begin
  ASaveIndex := ItemIndex;
  Items.Clear;
  Items.BeginUpdate;
  with FVerticalGrid do
  try
    for I := 0 to Rows.Count - 1 do CheckRow(Rows[I], FIsCategoryListBox);
  finally
    if FDragging then ItemIndex := ASaveIndex;
    Items.EndUpdate;
  end;
  Invalidate;
end;

procedure TcxVerticalGridItemsCustomizeListBox.CNDrawItem(
  var Message: TWMDrawItem);
begin
  if not IsPaint then Exit;
  with Message.DrawItemStruct^ do
  begin
    Canvas.Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if Integer(itemID) >= 0 then
    {$IFDEF DELPHI5}
      DrawItem(itemID, rcItem, TOwnerDrawState(LongRec(itemState).Lo))
    {$ELSE}
      DrawItem(itemID, rcItem, TOwnerDrawState(Byte(itemState)))
    {$ENDIF}
    else
      Canvas.FillRect(rcItem);
    Canvas.Canvas.Handle := 0;
  end;
end;

procedure TcxVerticalGridItemsCustomizeListBox.WMCancelMode(
  var Message: TWMCancelMode);
begin
  inherited;
  FDragging := False;
  ItemIndex := -1;
  FDragAndDropItemIndex := -1;
  Invalidate;
end;

procedure TcxVerticalGridItemsCustomizeListBox.WMPaint(var Message: TMessage);
begin
  IsPaint := True;
  try
    inherited;
  finally
    IsPaint := False;
  end;
end;

function TcxVerticalGridItemsCustomizeListBox.GetDragRow: TcxCustomRow;
begin
  Result := VerticalGrid.Controller.DragRow;
end;

function TcxVerticalGridItemsCustomizeListBox.GetPainter: TcxvgPainter;
begin
  Result := VerticalGrid.Painter;
end;

{ TcxVerticalGridCustomizationForm }

constructor TcxVerticalGridCustomizationForm.CreateEx(
  AOwner: TcxVerticalGridCustomizing);
begin
  CreateNew(nil);
  FOwner := AOwner;
end;

procedure TcxVerticalGridCustomizationForm.CreateParams(
  var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := Style or WS_POPUP;
    if not VerticalGrid.IsDestroying then
      WndParent := VerticalGrid.Handle
    else
      WndParent := 0;
  end;
end;

destructor TcxVerticalGridCustomizationForm.Destroy;
begin
  FreeAndNil(FHookTimer);
  inherited Destroy;
end;

procedure TcxVerticalGridCustomizationForm.DoClose(var Action: TCloseAction);
begin
  FreeAndNil(FHookTimer);
  inherited DoClose(Action);
end;

procedure TcxVerticalGridCustomizationForm.DoShow;
begin
  if FHookTimer = nil then
  begin
    FHookTimer := TTimer.Create(nil);
    with FHookTimer do
    begin
      Interval := 100;
      OnTimer := HookTimerHandler;
    end;
  end;  
  inherited DoShow;
end;

function TcxVerticalGridCustomizationForm.GetVerticalGrid: TcxCustomVerticalGrid;
begin
  Result := Customizing.VerticalGrid;
end;

procedure TcxVerticalGridCustomizationForm.HookTimerHandler(Sender: TObject);
begin
  if IsIconic(Application.Handle) then
    Visible := False
  else
    if not IsControlVisible(VerticalGrid) then
      VerticalGrid.Customizing.Visible := False
    else
      if not Visible then
      begin
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
        Visible := True;
      end;
end;

{ TcxVerticalGridCustomizing }

constructor TcxVerticalGridCustomizing.Create(AOwner: TPersistent);
begin
  FVerticalGrid := TcxCustomVerticalGrid(AOwner);
  FVisible := False;
  FRowCount := 10;
  FLastPosition := cxPoint(-10000, -10000);
  FShowCategoryButtons := True;
  FShowCategoryTab := True;
end;

destructor TcxVerticalGridCustomizing.Destroy;
begin
  Visible := False;
  inherited Destroy;
end;

procedure TcxVerticalGridCustomizing.Assign(Source: TPersistent);
begin
  if Source is TcxVerticalGridCustomizing then
  begin
    RowCount := TcxVerticalGridCustomizing(Source).RowCount;
    Visible := TcxVerticalGridCustomizing(Visible).Visible;
  end;
end;

procedure TcxVerticalGridCustomizing.MakeCategorySheetVisible;
begin
  if Visible and ((FTabSheetCategories <> nil) and (FCategoryListBox.Parent = FTabSheetCategories)) then
    FPageControl.ActivePage := FTabSheetCategories;
end;

procedure TcxVerticalGridCustomizing.MakeRowSheetVisible;
begin
  if Visible and (FRowListBox.Parent = FTabSheetRows) then
    FPageControl.ActivePage := FTabSheetRows;
end;

procedure TcxVerticalGridCustomizing.AdjustControls;
begin
  with VerticalGrid do
  begin
    SetControlParent(FPageControl, FForm);
    SetControlParent(FTabSheetRows, FPageControl);
    FTabSheetRows.PageControl := FPageControl;
    SetControlParent(FRowListBox, FTabSheetRows);
    if Assigned(FTabSheetCategories) then
    begin
      SetControlParent(FTabSheetCategories, FPageControl);
      FTabSheetCategories.PageControl := FPageControl;
      SetControlParent(FCategoryListBox, FTabSheetCategories);
    end;
  end;
  ShowCustomizingForm;
end;

function TcxVerticalGridCustomizing.CanDrop(const P: TPoint): Boolean;

  function CheckListBox(AListBox: TcxVerticalGridItemsCustomizeListBox): Boolean;
  begin
    if AListBox = nil then
      Result := False
    else
      with AListBox do
        Result := Visible and cxRectPtIn(ClientRect, ScreenToClient(P));
  end;

var
  ADragCategoryRow: Boolean;
begin
  Result := False;
  if not Visible then Exit;
  ADragCategoryRow := VerticalGrid.Controller.DragRow is TcxCategoryRow;
  if ADragCategoryRow then
    Result := CheckListBox(FCategoryListBox)
  else
    Result := CheckListBox(FRowListBox);
end;

procedure TcxVerticalGridCustomizing.CreateCategoryPanel;

  function CreateButton(ALeft, ATabOrder: Integer; const ACaption: string;
    AOnClick: TNotifyEvent): TcxButton;
  begin
    Result := TcxButton.Create(nil);
    with Result do
    begin
      Left := ALeft;
      Top := 7;
      Width := 75;
      Height := 25;
      Caption := ACaption;
      TabOrder := ATabOrder;
      LookAndFeel.MasterLookAndFeel := VerticalGrid.LookAndFeel;
      Enabled := ATabOrder = 0;
      OnClick := AOnClick;
      Parent := FPanel;
    end;
  end;

begin
  FPanel := TPanel.Create(nil);
  FPanel.Align := alBottom;
  FPanel.Height := 35;
  FPanel.BevelOuter := bvNone;
  FPanel.Visible := FShowCategoryButtons;
  FPanel.Parent := FTabSheetCategories;
  FButtonNew := CreateButton(7, 0,
    cxGetResourceString(@cxSvgCustomizeNewCategory), CreateCategoryClick);
  FButtonDelete := CreateButton(90, 1,
    cxGetResourceString(@cxSvgCustomizeDeleteCategory), DeleteCategoryClick);
end;

procedure TcxVerticalGridCustomizing.CreateCategoryRow;
var
  ARow: TcxCategoryRow;
  S: string;
begin
  if cxShowNewCategoryForm(Form, S, VerticalGrid.LookAndFeel) then
  begin
    VerticalGrid.BeginUpdate;
    try
      ARow := TcxCategoryRow(VerticalGrid.Add(TcxCategoryRow));
      ARow.Visible := False;
      ARow.Properties.Caption := S;
      ARow.Name := CreateUniqueName(VerticalGrid.Owner,
        VerticalGrid, ARow, 'Tcx', 'RuntimeCreatedRow');
    finally
      Modified;
      VerticalGrid.EndUpdate;
    end;
  end;
end;

procedure TcxVerticalGridCustomizing.CreateControls;
begin
  if FForm <> nil then Exit;
  FSaveDragMode := VerticalGrid.DragMode;
  VerticalGrid.DragMode := dmAutomatic;
  CreateCustomizingForm;
  FRowListBox := TcxVerticalGridItemsCustomizeListBox.CreateEx(nil, VerticalGrid, False);
  FPageControl := TPageControl.Create(nil);
  FPageControl.HotTrack := True;
  FTabSheetRows := TTabSheet.Create(FPageControl);
  FTabSheetRows.Caption := cxGetResourceString(@cxSvgCustomizeRowsCaption);
  FTabSheetRows.TabVisible := True;
  if FShowCategoryTab then
  begin
    FCategoryListBox := TcxVerticalGridItemsCustomizeListBox.CreateEx(nil, VerticalGrid, True);
    FCategoryListBox.OnClick := UpdateButtons;
    FTabSheetCategories := TTabSheet.Create(FPageControl);
    FTabSheetCategories.Caption := cxGetResourceString(@cxSvgCustomizeCategoriesCaption);
    FTabSheetCategories.TabVisible := True;
    CreateCategoryPanel;
  end;
  AdjustControls;
end;

procedure TcxVerticalGridCustomizing.CreateCustomizingForm;
var
  I: Integer;
const
  UnusedItems: array[0..4, 0..1] of Integer =
    ((7, MF_BYPOSITION), (5, MF_BYPOSITION), (SC_MAXIMIZE, MF_BYCOMMAND),
    (SC_MINIMIZE, MF_BYCOMMAND), (SC_RESTORE, MF_BYCOMMAND));
begin
  FForm := TcxVerticalGridCustomizationForm.CreateEx(Self);
  with FForm do
  begin
    Visible := False;
    Caption := cxGetResourceString(@cxSvgCustomizeCaption);
    BorderStyle := bsSizeToolWin;
    BorderIcons := [biSystemMenu];
    Font.Assign(VerticalGrid.Font);
    ClientWidth := SizeDelta.cx  * cxTextWidth(Font, '0');
    FLineHeight := cxTextHeight(Font) + SizeDelta.cy;
    ClientHeight := (RowCount + 1) * FLineHeight;
    Constraints.MinWidth := Width;
    Color := clBtnFace;
    OnShow := FormShow;
    OnClose := FormClose;
    for I := 0 to High(UnusedItems) do
      DeleteMenu(GetSystemMenu(Handle, False), UnusedItems[I, 0], UnusedItems[I, 1]);
  end;
end;

procedure TcxVerticalGridCustomizing.FormClose(Sender: TObject; var Action: TCloseAction);

  function CheckIndex(AListBox: TListBox): Integer;
  begin
    if (AListBox = nil) or (AListBox.Parent = nil) then
      Result := -1
    else
      Result := AListBox.ItemIndex;
  end;

begin
  FLastPosition := FForm.BoundsRect.TopLeft;
  FLastHeaderIndex := CheckIndex(FRowListBox);
  FLastBandIndex := CheckIndex(FCategoryListBox);
  Visible := False;
  VerticalGrid.DoCustomizationVisibleChanged;
end;

procedure TcxVerticalGridCustomizing.FormShow(Sender: TObject);
begin
  VerticalGrid.DoCustomizationVisibleChanged;
end;

procedure TcxVerticalGridCustomizing.LookAndFeelChanged;
begin
  FCategoryListBox.Invalidate;
  FRowListBox.Invalidate;
  FPageControl.Invalidate;
end;

procedure TcxVerticalGridCustomizing.ReleaseControls;

  procedure ReleaseControl(var AControl: TControl);
  begin
    if AControl = nil then Exit;
    AControl.Parent := nil;
    FreeAndNil(AControl);
  end;

begin
  if FForm <> nil then
  try
    FLastPosition := Point(FForm.Left, FForm.Top);
    ReleaseControl(TControl(FButtonNew));
    ReleaseControl(TControl(FButtonDelete));
    ReleaseControl(TControl(FPanel));
    ReleaseControl(TControl(FRowListBox));
    ReleaseControl(TControl(FCategoryListBox));
    ReleaseControl(TControl(FTabSheetCategories));
    ReleaseControl(TControl(FTabSheetRows));
    ReleaseControl(TControl(FPageControl));
    FLastBandIndex := -1;
    FLastHeaderIndex := -1;
    if not VerticalGrid.IsDestroying then
      VerticalGrid.DragMode := FSaveDragMode;
  finally
    cxReleaseForm(FForm);
  end;
end;

procedure TcxVerticalGridCustomizing.SetControlParent(AControl, AParent: TWinControl);
begin
  AControl.Parent := AParent;
  if AParent <> nil then
  begin
    AControl.Align := alClient;
    TControlAccess(AControl).ParentFont := True;
    TControlAccess(AControl).ParentColor := True;
    Visible := True;
  end;
end;

function TcxVerticalGridCustomizing.SizeDelta: TSize;
begin
  Result := cxSize(31, 4);
end;

procedure TcxVerticalGridCustomizing.ComponentRemoved(Sender: TObject);
begin
end;

procedure TcxVerticalGridCustomizing.Modified;
begin
  Update;
end;

procedure TcxVerticalGridCustomizing.ValidateListBox(
  AListBox: TcxVerticalGridItemsCustomizeListBox; AIndex: Integer);
begin
  if (AListBox = nil) or (AListBox.Parent = nil) then Exit;
  AListBox.RefreshList;
  if (AIndex >= 0) and (AIndex < AListBox.Items.Count) then
    AListBox.ItemIndex := AIndex;
end;

procedure TcxVerticalGridCustomizing.Update;
begin
  if (FRowListBox <> nil) and (FRowListBox.Parent <> nil) then
    FRowListBox.RefreshList;
  if (FCategoryListBox <> nil) and (FCategoryListBox.Parent <> nil) then
  begin
    FCategoryListBox.RefreshList;
    UpdateButtons(nil);
  end;
end;

procedure TcxVerticalGridCustomizing.CreateCategoryClick(Sender: TObject);
begin
  CreateCategoryRow;
end;

procedure TcxVerticalGridCustomizing.DeleteCategoryClick(Sender: TObject);
var
  ARowHeader: TcxCustomRowHeaderInfo;
begin
  with CategoryListBox do
    if ItemIndex >= 0 then
    begin
      ARowHeader := TcxCustomRowHeaderInfo(Items.Objects[ItemIndex]);
      Items.Delete(ItemIndex);
      ARowHeader.Row.Free;
    end;
  Modified;
end;

procedure TcxVerticalGridCustomizing.SetRowCount(Value: Integer);
begin
  if Value < 2 then Value := 2;
  FRowCount := Value;
end;

procedure TcxVerticalGridCustomizing.SetShowCategoryButtons(
  const Value: Boolean);
begin
  FShowCategoryButtons := Value;
  if FPanel <> nil then FPanel.Visible := Value;
end;

procedure TcxVerticalGridCustomizing.SetVisible(Value: Boolean);

  function CanVisible: Boolean;
  begin
    Result := VerticalGrid.Rows.Count > 0;
  end;

begin
  if Value <> FVisible then
  begin
    if Value and not CanVisible then Exit;
    FVisible := Value;
    if not Value then
      ReleaseControls
    else
      CreateControls;
  end;
end;

function GetDesktopRect: TRect;
begin
  Result := Screen.DesktopRect;
end;

procedure TcxVerticalGridCustomizing.ShowCustomizingForm;
var
  P: TPoint;
  R: TRect;
begin
  if (CustomizingPos.X <> -10000) and (CustomizingPos.Y <> -10000) then
  begin
    FForm.Left := CustomizingPos.X;
    FForm.Top := CustomizingPos.Y;
  end
  else
  begin
    R := GetDesktopRect;
    P := VerticalGrid.ClientToScreen(cxPoint(VerticalGrid.Width, 0));
    with FForm do
    begin
      if P.X + Width > R.Right then
        P.X := R.Right - Width;
      if P.Y + Height > R.Bottom then
        P.Y := R.Bottom - Height;
      if P.X < R.Left then
        P.X := R.Left;
      if P.Y < R.Top then
        P.Y := R.Top;
      SetBounds(P.X, P.Y, Width, Height);
    end;
  end;
  ValidateListBox(FRowListBox, FLastHeaderIndex);
  ValidateListBox(FCategoryListBox, FLastBandIndex);
  FForm.Show;
end;

procedure TcxVerticalGridCustomizing.UpdateButtons(Sender: TObject);
begin
  FButtonDelete.Enabled := FCategoryListBox.ItemIndex <> -1;
end;

initialization
  RegisterClasses([TcxCategoryRow, TcxEditorRow, TcxMultiEditorRow]);
  RegisterClasses([TcxCaptionRowProperties, TcxEditorRowProperties, TcxMultiEditorRowProperties]);

  Screen.Cursors[crcxInspectorInsert] := LoadCursor(HInstance, cxInspectorInsertCursor);
  Screen.Cursors[crcxInspectorAddChild] := LoadCursor(HInstance, cxInspectorAddChildCursor);
  Screen.Cursors[crcxInspectorAdd] := LoadCursor(HInstance, cxInspectorAddCursor);
  Screen.Cursors[crcxInspectorHide] := LoadCursor(HInstance, cxInspectorHideCursor);
  Screen.Cursors[crcxInspectorNoDrag] := LoadCursor(HInstance, cxInspectorNoDragCursor);

finalization
{$IFDEF DELPHI4}
  DestroyCursor(Screen.Cursors[crcxInspectorInsert]);
  DestroyCursor(Screen.Cursors[crcxInspectorAddChild]);
  DestroyCursor(Screen.Cursors[crcxInspectorAdd]);
  DestroyCursor(Screen.Cursors[crcxInspectorHide]);
  DestroyCursor(Screen.Cursors[crcxInspectorNoDrag]);
{$ENDIF}
end.

