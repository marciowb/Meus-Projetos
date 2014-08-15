
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressMasterView main components                           }
{                                                                   }
{       Copyright (c) 1999-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSMASTERVIEW AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM      }
{   ONLY.                                                           }
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

unit dxMasterView;

{$I cxVer.inc}

interface

uses
  Windows, Messages, Classes,{$IFDEF DELPHI6} Variants,{$ENDIF} Controls, DB,
  Graphics, Forms;

const
  dxMVCustomizationFormRowCount = 12;
  dxMVPreviewLeftIndent = 20;
  dxMVPreviewMaxLineCount = 3;
  dxMVPreviewRightIndent = 5;

  dxMVColumnDefaultMinWidth = 20;
  dxMVColumnDefaultMaxWidth = 10000;
  dxMVColumnDefaultMaxRowCount = 100;

type
  PBoolArray = ^TBoolArray;
  TBoolArray = array[0..MaxInt div SizeOf(Boolean) - 1] of Boolean;
  PBRUSH = ^HBRUSH;
{$IFNDEF DELPHI5}
  PColor = ^TColor;
{$ENDIF}
  PFont = ^TFont;
  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxInt div SizeOf(Integer) - 1] of Integer;

  TdxMasterViewStyle = class;
  TdxMasterViewStyleClass = class of TdxMasterViewStyle;
  TdxMasterViewColumn = class;
  TdxMasterViewColumnClass = class of TdxMasterViewColumn;
  TdxMasterViewLayout = class;
  TdxMasterViewLevel = class;
  TdxMasterViewNode = class;
  TdxMasterView = class;

  TdxMasterViewNodeType = (ntData, ntCaption, ntGroup);
  TdxMasterViewNodeTypes = set of TdxMasterViewNodeType;

  TdxMVDesignerRefreshCode = (rcName, rcLevels, rcColumns, rcData, rcStyles, rcEnables);
  TdxMVDesignerRefreshCodes = set of TdxMVDesignerRefreshCode;

  TCurDesigner =
    {$IFDEF DELPHI6}IUnknown{$ELSE}{$IFDEF DELPHI4}IDesigner{$ELSE}TDesigner{$ENDIF}{$ENDIF};

  TdxMVDesigner = class
  public
    procedure Changed(Control: TdxMasterView; RefreshCodes: TdxMVDesignerRefreshCodes); virtual; abstract;
    procedure Hide(Control: TdxMasterView); virtual; abstract;
    function UniqueName(Control: TdxMasterView; const BaseName: string): string; virtual; abstract;
    procedure Show(Control: TdxMasterView; ADesigner: TCurDesigner); virtual; abstract;
  end;

  TdxMasterViewDataLink = class(TDataLink)
  private
    FFreezeCount: Integer;
    FLevel: TdxMasterViewLevel;
    function GetFrozen: Boolean;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure EditingChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(ALevel: TdxMasterViewLevel);
    function Freeze: Integer;
    procedure Unfreeze;
    property FreezeCount: Integer read FFreezeCount;
    property Frozen: Boolean read GetFrozen;
  end;

  TdxMasterViewStyleValue = (svAnotherColor, svColor, svFont);
  TdxMasterViewStyleValues = set of TdxMasterViewStyleValue;
  TdxMasterViewStyleConsumeType =
    (sctHeader, sctContent, sctFooter, sctPreview, sctCaption, sctGroup,
     sctGroupByBox, sctHighlight, sctInactive);
  TdxMasterViewStyleConsumeTypes = set of TdxMasterViewStyleConsumeType;

  PdxMasterViewStyleConsumerRec = ^TdxMasterViewStyleConsumerRec;
  TdxMasterViewStyleConsumerRec = record
    Consumer: TComponent;
    ConsumeTypes: TdxMasterViewStyleConsumeTypes;
  end;

  TdxMasterViewStyle = class(TComponent)
  private
    FAnotherBrush: HBRUSH;
    FAnotherColor: TColor;
    FAssignedValues: TdxMasterViewStyleValues;
    FBrush: HBRUSH;
    FColor: TColor;
    FControl: TdxMasterView;
    FConsumers: TList;
    FFont: TFont;
    function GetConsumerRec(Index: Integer): PdxMasterViewStyleConsumerRec;
    function GetConsumerCount: Integer;
    function GetIndex: Integer;
    procedure SetAnotherColor(Value: TColor);
    procedure SetAssignedValues(Value: TdxMasterViewStyleValues);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetIndex(Value: Integer);
    function IsAnotherColorStored: Boolean;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    procedure FontChanged(Sender: TObject);
  protected
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;
    procedure AddConsumeType(AConsumer: TComponent; AConsumeType: TdxMasterViewStyleConsumeType);
    procedure Changed(Values: TdxMasterViewStyleValues);
    function IndexOfConsumer(Consumer: TComponent): Integer;
    procedure RemoveConsumeType(AConsumer: TComponent; AConsumeType: TdxMasterViewStyleConsumeType);
    procedure SysColorChanged; virtual;
    property ConsumerCount: Integer read GetConsumerCount;
    property ConsumerRecs[Index: Integer]: PdxMasterViewStyleConsumerRec read GetConsumerRec;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    property AnotherBrush: HBRUSH read FAnotherBrush;
    property Brush: HBRUSH read FBrush;
    property Control: TdxMasterView read FControl;
    property Index: Integer read GetIndex write SetIndex;
  published
    property AnotherColor: TColor read FAnotherColor write SetAnotherColor
      stored IsAnotherColorStored;
    property Color: TColor read FColor write SetColor stored IsColorStored;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property AssignedValues: TdxMasterViewStyleValues read FAssignedValues
      write SetAssignedValues default [];  // must be loaded after all
  end;

  TdxMasterViewColumnAssignedValue =
    (cvAlignment, cvCaption, cvFooterAlignment, cvHeaderAlignment, cvSummaryFieldName, cvWidth);
  TdxMasterViewColumnAssignedValues = set of TdxMasterViewColumnAssignedValue;
  TdxMasterViewHPart = (hpOne, hpAll);
  TdxMasterViewVPart = (vpGroupByBox, vpHeader, vpContent, vpFooter, vpAll, vpAllAndBelow);
  TdxMasterViewSortOrder = (soNone, soAscending, soDescending);
  TdxMasterViewSummaryType = (stNone, stSum, stMin, stMax, stCount, stAverage);

  TdxMasterViewColumnOption =
    (coGrouping, coHidden, coHorSizing, coMoving, coSorting, coVerSizing,
     coShowCaption);
  TdxMasterViewColumnOptions = set of TdxMasterViewColumnOption;

  TdxMVColumnGetStyleEvent = procedure(Sender: TdxMasterViewColumn;
    Node: TdxMasterViewNode; var NewStyle: TdxMasterViewStyle) of object;
  TdxMVSummaryEvent = procedure(Sender: TdxMasterViewColumn;
    Node: TdxMasterViewNode; DataSet: TDataSet; var Value: Extended) of object;

  TdxMasterViewColumn = class(TComponent)
  private
    FAddInWidth: Integer;
    FAlignment: TAlignment;
    FAssignedValues: TdxMasterViewColumnAssignedValues;
    FCaption: string;
    FColIndex: Integer;
    FContentStyle: TdxMasterViewStyle;
    FField: TField;
    FFieldName: string;
    FFooterAlignment: TAlignment;
    FFooterStyle: TdxMasterViewStyle;
    FHeaderAlignment: TAlignment;
    FHeaderGlyph: TBitmap;
    FHeaderGlyphAlignment: TAlignment;
    FHeaderStyle: TdxMasterViewStyle;
    FLeftColumns: TList;
    FLevel: TdxMasterViewLevel;
    FLoadedGroupIndex: Integer;
    FLoadedSortIndex: Integer;
    FLogicalOffset: Integer;
    FMaxRowCount: Integer;
    FMaxWidth: Integer;
    FMinRowCount: Integer;
    FMinWidth: Integer;
    FMultiLine: Boolean;
    FOptions: TdxMasterViewColumnOptions;
    FPressed: Boolean;
    FRightColumns: TList;
    FRowCount: Integer;
    FRowIndex: Integer;
    FLeaveSortOrder: Boolean;
    FSortOrder: TdxMasterViewSortOrder;
    FSummaryField: TField;
    FSummaryFieldName: string;
    FSummaryFormat: string;
    FSummaryType: TdxMasterViewSummaryType;
    FVisible: Boolean;
    FVisibleWidth: Integer;
    FWidth: Integer;

    FOnAfterCalcSummary: TdxMVSummaryEvent;
    FOnBeforeCalcSummary: TdxMVSummaryEvent;
    FOnCalcSummary: TdxMVSummaryEvent;
    FOnGetContentStyle: TdxMVColumnGetStyleEvent;
    FOnGetFooterStyle: TdxMVColumnGetStyleEvent;
    FOnGetHeaderStyle: TdxMVColumnGetStyleEvent;

    function GetAlignment: TAlignment;
    function GetCaption: string;
    function GetColIndex: Integer;
    function GetContentAnotherBrush: HBRUSH;
    function GetContentAnotherColor: TColor;
    function GetContentBrush: HBRUSH;
    function GetContentColor: TColor;
    function GetContentFont: TFont;
    function GetControl: TdxMasterView;
    function GetFooterAlignment: TAlignment;
    function GetFooterBrush: HBRUSH;
    function GetFooterColor: TColor;
    function GetFooterFont: TFont;
    function GetGroupIndex: Integer;
    function GetHeaderAlignment: TAlignment;
    function GetHeaderBrush: HBRUSH;
    function GetHeaderColor: TColor;
    function GetHeaderFont: TFont;
    function GetHidden: Boolean;
    function GetIndex: Integer;
    function GetIsDestroying: Boolean;
    function GetIsLoading: Boolean;
    function GetLastInRow: Boolean;
    function GetLogicalOffset: Integer;
//    function GetMaxLogicalOffset: Integer;
    function GetMinLogicalOffset: Integer;
    function GetNonScaledLogicalOffset: Integer;
//    function GetNonScaledOffset: Integer;
    function GetNonScaledWidth: Integer;
    function GetOffset: Integer;
    function GetRowIndex: Integer;
    function GetSortIndex: Integer;
    function GetSummaryField: TField;
    function GetSummaryFieldName: string;
    function GetSummaryIndex: Integer;
    function GetVisibleIndex: Integer;
    function GetVisibleMaxWidth: Integer;
    function GetVisibleMinWidth: Integer;
    function GetVisibleWidth: Integer;
    procedure SetAlignment(Value: TAlignment);
    procedure SetAssignedValues(Value: TdxMasterViewColumnAssignedValues);
    procedure SetCaption(Value: string);
    procedure SetColIndex(Value: Integer);
    procedure SetContentStyle(Value: TdxMasterViewStyle);
    procedure SetField(Value: TField);
    procedure SetFieldInternally(Value: TField);
    procedure SetFieldName(Value: string);
    procedure SetFooterAlignment(Value: TAlignment);
    procedure SetFooterStyle(Value: TdxMasterViewStyle);
    procedure SetGroupIndex(Value: Integer);
    procedure SetHeaderAlignment(Value: TAlignment);
    procedure SetHeaderGlyph(Value: TBitmap);
    procedure SetHeaderGlyphAlignment(Value: TAlignment);
    procedure SetHeaderStyle(Value: TdxMasterViewStyle);
    procedure SetIndex(Value: Integer);
    procedure SetInternalVisibleWidth(Value: Integer);
    procedure SetMaxRowCount(Value: Integer);
    procedure SetMaxWidth(Value: Integer);
    procedure SetMinRowCount(Value: Integer);
    procedure SetMinWidth(Value: Integer);
    procedure SetMultiLine(Value: Boolean);
    procedure SetOptions(Value: TdxMasterViewColumnOptions);
    procedure SetPressed(Value: Boolean);
    procedure SetRowCount(Value: Integer);
    procedure SetRowIndex(Value: Integer);
    procedure SetSortIndex(Value: Integer);
    procedure SetSortOrder(Value: TdxMasterViewSortOrder);
    procedure SetSummaryField(Value: TField);
    procedure SetSummaryFieldInternally(Value: TField);
    procedure SetSummaryFieldName(Value: string);
    procedure SetSummaryFormat(Value: string);
    procedure SetSummaryType(Value: TdxMasterViewSummaryType);
    procedure SetVisible(Value: Boolean);
    procedure SetVisibleWidth(Value: Integer);
    procedure SetWidth(Value: Integer);

    procedure CheckRowCount(var Value: Integer);
    procedure CheckVisibleWidthValue(var Value: Integer);
    procedure CheckWidthValue(var Value: Integer);
    function FindField: TField;
    function FindSummaryField: TField;
    procedure HeaderGlyphChanged(Sender: TObject);
    function IsAlignmentStored: Boolean;
    function IsCaptionStored: Boolean;
    function IsFooterAlignmentStored: Boolean;
    function IsHeaderAlignmentStored: Boolean;
    function IsSummaryFieldNameStored: Boolean;
    function IsWidthLinked: Boolean;
    function IsWidthStored: Boolean;
    procedure ReadLeaveSortOrder(Reader: TReader);
    procedure WriteLeaveSortOrder(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;

    function CanGrouping(Index: Integer): Boolean;
    function CanHiding: Boolean;
    function CanMoving: Boolean;
    function CanHorSizing: Boolean;
    function CanSorting: Boolean;
    function CanVerSizing: Boolean;
    procedure ColumnChanged(HardRefresh: Boolean;
      HPart: TdxMasterViewHPart; VPart: TdxMasterViewVPart);
    procedure ContentStyleChanged(Values: TdxMasterViewStyleValues);
    function DefaultAlignment: TAlignment;
    function DefaultCaption: string;
    function DefaultHeaderAlignment: TAlignment;
    function DefaultWidth: Integer;
    procedure DoAfterCalcSummary(Node: TdxMasterViewNode; DataSet: TDataSet;
      var Value: Extended); virtual;
    procedure DoBeforeCalcSummary(Node: TdxMasterViewNode; DataSet: TDataSet;
      var Value: Extended); virtual;
    procedure DoCalcSummary(Node: TdxMasterViewNode; DataSet: TDataSet;
      var Value: Extended); virtual;
    procedure DrawSortMark(DC: HDC; var ARect: TRect);
    procedure DrawHeader(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode); virtual;
    procedure DrawContent(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode); virtual;
    procedure DrawFooter(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode); virtual;
    procedure FooterStyleChanged(Values: TdxMasterViewStyleValues);
    function GetFooterText(Node: TdxMasterViewNode): string;
    function GetGroupByBoxBounds(Node: TdxMasterViewNode): TRect;
    function GetGroupDisplayText(Node: TdxMasterViewNode): string; virtual;
    function GetHeaderBestFitWidth(DC: HDC; CheckSortOrderMark: Boolean): Integer;
    function GetHeaderBounds(Node: TdxMasterViewNode): TRect;
    function GetHeaderHeight: Integer;
    function GetContentBounds(Node: TdxMasterViewNode): TRect;
    function GetFooterBounds(Node: TdxMasterViewNode): TRect;
    procedure HeaderStyleChanged(Values: TdxMasterViewStyleValues);

    property AddInWidth: Integer read FAddInWidth;
    property Hidden: Boolean read GetHidden;
    property InternalVisibleWidth: Integer read FVisibleWidth write SetInternalVisibleWidth;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property LastInRow: Boolean read GetLastInRow;
    property LogicalOffset: Integer read GetLogicalOffset;
//    property MaxLogicalOffset: Integer read GetMaxLogicalOffset;
    property MinLogicalOffset: Integer read GetMinLogicalOffset;
    property NonScaledLogicalOffset: Integer read GetNonScaledLogicalOffset;
//    property NonScaledOffset: Integer read GetNonScaledOffset;
    property NonScaledWidth: Integer read GetNonScaledWidth;
    property Offset: Integer read GetOffset;
    property Pressed: Boolean read FPressed write SetPressed;
    property SummaryIndex: Integer read GetSummaryIndex;
    property VisibleMaxWidth: Integer read GetVisibleMaxWidth;
    property VisibleMinWidth: Integer read GetVisibleMinWidth;

    property HeaderBrush: HBRUSH read GetHeaderBrush;
    property HeaderColor: TColor read GetHeaderColor;
    property HeaderFont: TFont read GetHeaderFont;
    property ContentAnotherBrush: HBRUSH read GetContentAnotherBrush;
    property ContentAnotherColor: TColor read GetContentAnotherColor;
    property ContentBrush: HBRUSH read GetContentBrush;
    property ContentColor: TColor read GetContentColor;
    property ContentFont: TFont read GetContentFont;
    property FooterBrush: HBRUSH read GetFooterBrush;
    property FooterColor: TColor read GetFooterColor;
    property FooterFont: TFont read GetFooterFont;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ChangeWidth(Value: Integer; AdjustLinkedColumns: Boolean);
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    procedure ApplyBestFit;
    function GetBestFitWidth: Integer;
    function GetFooterValue(Node: TdxMasterViewNode): Extended;

    property AssignedValues: TdxMasterViewColumnAssignedValues read FAssignedValues
      write SetAssignedValues;
    property Control: TdxMasterView read GetControl;
    property Field: TField read FField write SetField;
    property Index: Integer read GetIndex write SetIndex;
    property Level: TdxMasterViewLevel read FLevel;
    property SummaryField: TField read GetSummaryField write SetSummaryField;
    property VisibleIndex: Integer read GetVisibleIndex;
    property VisibleWidth: Integer read GetVisibleWidth write SetVisibleWidth;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property ContentStyle: TdxMasterViewStyle read FContentStyle write SetContentStyle;
    property FieldName: string read FFieldName write SetFieldName;
    property FooterAlignment: TAlignment read GetFooterAlignment write SetFooterAlignment
      stored IsFooterAlignmentStored;
    property FooterStyle: TdxMasterViewStyle read FFooterStyle write SetFooterStyle;
    property GroupIndex: Integer read GetGroupIndex write SetGroupIndex default -1;
    property HeaderAlignment: TAlignment read GetHeaderAlignment write SetHeaderAlignment
      stored IsHeaderAlignmentStored;
    property HeaderGlyph: TBitmap read FHeaderGlyph write SetHeaderGlyph;
    property HeaderGlyphAlignment: TAlignment read FHeaderGlyphAlignment
      write SetHeaderGlyphAlignment default taLeftJustify;
    property HeaderStyle: TdxMasterViewStyle read FHeaderStyle write SetHeaderStyle;
    property MaxRowCount: Integer read FMaxRowCount write SetMaxRowCount
      default dxMVColumnDefaultMaxRowCount;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth
      default dxMVColumnDefaultMaxWidth;
    property MinRowCount: Integer read FMinRowCount write SetMinRowCount default 1;
    property MinWidth: Integer read FMinWidth write SetMinWidth
      default dxMVColumnDefaultMinWidth;
    property MultiLine: Boolean read FMultiLine write SetMultiLine default False;
    property Options: TdxMasterViewColumnOptions read FOptions write SetOptions
      default [coGrouping, coHorSizing, coMoving, coSorting, coVerSizing, coShowCaption];

    property RowIndex: Integer read GetRowIndex write SetRowIndex;  // must be before RowCount
    property ColIndex: Integer read GetColIndex write SetColIndex;
    property RowCount: Integer read FRowCount write SetRowCount default 1;

    property SortIndex: Integer read GetSortIndex write SetSortIndex default -1;
    property SortOrder: TdxMasterViewSortOrder read FSortOrder write SetSortOrder default soNone;
    property SummaryFieldName: string read GetSummaryFieldName write SetSummaryFieldName
      stored IsSummaryFieldNameStored;
    property SummaryFormat: string read FSummaryFormat write SetSummaryFormat;
    property SummaryType: TdxMasterViewSummaryType read FSummaryType write SetSummaryType
      default stNone;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width: Integer read FWidth write SetWidth stored IsWidthStored;

    property OnAfterCalcSummary: TdxMVSummaryEvent read FOnAfterCalcSummary
      write FOnAfterCalcSummary;
    property OnBeforeCalcSummary: TdxMVSummaryEvent read FOnBeforeCalcSummary
      write FOnBeforeCalcSummary;
    property OnCalcSummary: TdxMVSummaryEvent read FOnCalcSummary write FOnCalcSummary;
    property OnGetContentStyle: TdxMVColumnGetStyleEvent read FOnGetContentStyle
      write FOnGetContentStyle;
    property OnGetFooterStyle: TdxMVColumnGetStyleEvent read FOnGetFooterStyle
      write FOnGetFooterStyle;
    property OnGetHeaderStyle: TdxMVColumnGetStyleEvent read FOnGetHeaderStyle
      write FOnGetHeaderStyle;
  end;

  TdxMasterViewLayout = class
  private
    FContentNonScaledWidths: PIntArray;
    FContentWidths: PIntArray;
    FHeaderWidthAssigned: PBoolArray;
    FHeaderWidths: PIntArray;
    FHorizontal: Boolean;
    FLevel: TdxMasterViewLevel;
    FLines: TList;
    FRowCount: Integer;
    FUpdateLockCount: Integer;
    FVisibleWidth: Integer;
    function GetColLogicalOffset(ACol: Integer): Integer;
    function GetColOffset(ACol: Integer): Integer;
    function GetColumn(ARow, ACol: Integer): TdxMasterViewColumn;
    function GetColWidth(ACol: Integer): Integer;
    function GetContentDynamicMaxWidth(ACol: Integer): Integer;
    function GetContentDynamicMinWidth(ACol: Integer): Integer;
    function GetContentMaxWidth(ACol: Integer): Integer;
    function GetContentMinWidth(ACol: Integer): Integer;
    function GetContentNonScaledWidth(ACol: Integer): Integer;
    function GetContentWidth(ACol: Integer): Integer;
    function GetCount: Integer;
    function GetHeaderDynamicMaxWidth(ACol: Integer): Integer;
    function GetHeaderDynamicMinWidth(ACol: Integer): Integer;
    function GetHeaderMaxWidth(ACol: Integer): Integer;
    function GetHeaderMinWidth(ACol: Integer): Integer;
    function GetHeaderWidth(ACol: Integer): Integer;
    function GetHeaderWidthAssigned(ACol: Integer): Boolean;
    function GetItem(Index: Integer): TList;
//    function GetMaxWidth: Integer;
    function GetMinWidth: Integer;
    function GetNonScaledWidth: Integer;
    function GetVisibleWidth: Integer;
    procedure SetContentInternalVisibleWidth(ACol, Value: Integer);
    procedure SetContentWidth(ACol, Value: Integer);
    procedure SetCount(Value: Integer);
    procedure SetHeaderWidth(ACol, Value: Integer);
    procedure SetHeaderWidthAssigned(ACol: Integer; Value: Boolean);
  protected
    function AreNeighbours(Column1, Column2: TdxMasterViewColumn;
      ExactResult: Boolean): Boolean;
    procedure CalcAddInWidths;
    procedure CalcColWidths;
    procedure CalcLogicalOffsets(Mode: Byte);
    procedure CalcNeighbours;
    procedure CalcOptimizedValues;
    procedure CalcVisibleWidth;
    procedure CheckColumnsWidths(FixedColumn: TdxMasterViewColumn);
    procedure CheckCount;
    procedure Clear;
    procedure ClearOptimizedValues;
    function ColFromX(X: Integer): Integer;
    procedure CreateColArrays;
    procedure Delete(Index: Integer);
    procedure DestroyColArrays;
    function HasLeftNeighbours(AColumn: TdxMasterViewColumn; AList: TList;
      ExactResult: Boolean): Boolean;
//    function HasLinkedColumns(AColumn: TdxMasterViewColumn; AList: TList): Boolean;
    function HasRightNeighbours(AColumn: TdxMasterViewColumn; AList: TList;
      ExactResult: Boolean): Boolean;
    procedure HeaderWidthChanged;
    procedure Insert(Index, ACount: Integer);
    procedure InsertAtPos(ARow, APos: Integer; AColumn: TdxMasterViewColumn);
    procedure InsertColumn(ARow, ACol: Integer; AColumn: TdxMasterViewColumn);
    procedure InsertColumnAtPos(ARow, APos: Integer; AColumn: TdxMasterViewColumn);
    procedure InternalRemoveFreeSpace;
    procedure RemoveColumn(AColumn: TdxMasterViewColumn);
    procedure RetrieveLastColumns(AList: TList);
    function GetNearestCol(ARow, AOffset: Integer): Integer;
    function GetNearestRow(ACol, ARow: Integer): Integer;
    procedure RequireCount(ACount: Integer);
    procedure ViewModeChanged;

    property ContentInternalVisibleWidths[ACol: Integer]: Integer
      write SetContentInternalVisibleWidth;
  public
    constructor Create(ALevel: TdxMasterViewLevel);
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure ChangeCol(AColumn: TdxMasterViewColumn; ACol: Integer);
    procedure ChangeHeaderWidth(ACol: Integer; Value: Integer; FixCol: Boolean);
    procedure ChangeRow(AColumn: TdxMasterViewColumn; ARow: Integer; FixedPos: Boolean);
    procedure ChangeRowAndRowCount(AColumn: TdxMasterViewColumn; ARow, ARowCount: Integer;
      FixedPos: Boolean);
    procedure ChangeRowCount(AColumn: TdxMasterViewColumn; ARowCount: Integer);
    procedure EndUpdate;
    function GetBestFitWidth(ACol: Integer): Integer;
    function IndexOf(AColumn: TdxMasterViewColumn; ALine: Integer): Integer;
    function IsColumnFirst(AColumn: TdxMasterViewColumn): Boolean;
    function IsColumnLast(AColumn: TdxMasterViewColumn): Boolean;
    function OneOnLine(AColumn: TdxMasterViewColumn): Boolean;
    procedure RemoveFreeSpace;

    property ColLogicalOffsets[ACol: Integer]: Integer read GetColLogicalOffset;
    property ColOffsets[ACol: Integer]: Integer read GetColOffset;
    property Columns[ARow, ACol: Integer]: TdxMasterViewColumn read GetColumn;
    property ColWidths[ACol: Integer]: Integer read GetColWidth;
    property ContentDynamicMaxWidths[ACol: Integer]: Integer read GetContentDynamicMaxWidth;
    property ContentDynamicMinWidths[ACol: Integer]: Integer read GetContentDynamicMinWidth;
    property ContentMaxWidths[ACol: Integer]: Integer read GetContentMaxWidth;
    property ContentMinWidths[ACol: Integer]: Integer read GetContentMinWidth;
    property ContentNonScaledWidths[ACol: Integer]: Integer read GetContentNonScaledWidth;
    property ContentWidths[ACol: Integer]: Integer read GetContentWidth write SetContentWidth;
    property Count: Integer read GetCount write SetCount;
    property HeaderDynamicMaxWidths[ACol: Integer]: Integer read GetHeaderDynamicMaxWidth;
    property HeaderDynamicMinWidths[ACol: Integer]: Integer read GetHeaderDynamicMinWidth;
    property HeaderMaxWidths[ACol: Integer]: Integer read GetHeaderMaxWidth;
    property HeaderMinWidths[ACol: Integer]: Integer read GetHeaderMinWidth;
    property HeaderWidthAssigned[ACol: Integer]: Boolean read GetHeaderWidthAssigned
      write SetHeaderWidthAssigned;
    property HeaderWidths[ACol: Integer]: Integer read GetHeaderWidth write SetHeaderWidth;
    property Horizontal: Boolean read FHorizontal;
    property Items[Index: Integer]: TList read GetItem; default;
//    property MaxWidth: Integer read GetMaxWidth;
    property MinWidth: Integer read GetMinWidth;
    property NonScaledWidth: Integer read GetNonScaledWidth;
    property RowCount: Integer read FRowCount;
    property VisibleWidth: Integer read FVisibleWidth;
  end;

  TdxMasterViewLevelOptionBehavior = (lobDblClkExpanding);
  TdxMasterViewLevelOptionsBehavior = set of TdxMasterViewLevelOptionBehavior;

  TdxMasterViewLevelOptionCustomize =
    (locColumnMoving, locColumnHiding, locColumnHorSizing, locColumnVerSizing,
     locColumnSorting, locColumnGrouping, locHideColumnOnGrouping,
     locShowColumnOnUngrouping);
  TdxMasterViewLevelOptionsCustomize = set of TdxMasterViewLevelOptionCustomize;

  TdxMasterViewLevelOptionCustomizeBox =
    (loxCaption, loxColumns, loxFooter, loxGrid, loxGridWithPreview, loxGroupByBox,
     loxHeader, loxHeaderOptions, loxOccupyRestSpace, loxPreview, loxViewMode);
  TdxMasterViewLevelOptionsCustomizeBox = set of TdxMasterViewLevelOptionCustomizeBox;

  TdxMasterViewLevelOptionDB =
    (lodAllowDelete, lodAllowInsert, lodConfirmDelete, lodDeleteOnlyChildless,
     lodDontFilterRecords, lodSmartLoad, lodSmartRefresh, lodSmartReload);
  TdxMasterViewLevelOptionsDB = set of TdxMasterViewLevelOptionDB;

  TdxMasterViewLevelOptionHeader =
    (lohForFirstNode, lohForFirstVisibleNode, lohAfterExpandedNode);
  TdxMasterViewLevelOptionsHeader = set of TdxMasterViewLevelOptionHeader;

  TdxMasterViewLevelOptionView =
    (lovCaption, lovFooter, lovGrid, lovGridWithPreview, lovGroupByBox,
     lovHeader, lovNoButtonsWhenNoChildren, lovOccupyRestSpace, lovPreview);
  TdxMasterViewLevelOptionsView = set of TdxMasterViewLevelOptionView;

  TdxMVLevels = array of TdxMasterViewLevel;
  TdxMasterViewViewMode = (vmHorizontal, vmVertical);

  TdxMVChangeGroupingEvent = procedure(Sender: TdxMasterViewLevel; Column: TdxMasterViewColumn;
    GroupIndex: Integer; var Allow: Boolean) of object;
  TdxMVColumnEvent = procedure(Sender: TdxMasterViewLevel; Column: TdxMasterViewColumn) of object;
  TdxMVColumnAllowEvent = procedure(Sender: TdxMasterViewLevel; Column: TdxMasterViewColumn;
    var Allow: Boolean) of object;
  TdxMVFilterRecordEvent = procedure(Sender: TdxMasterViewLevel;
    const AID, AKeyValue: Variant; var Accept: Boolean) of object;
  TdxMVGetFooterCellTextEvent = procedure(Sender: TdxMasterViewLevel;
    Node: TdxMasterViewNode; Column: TdxMasterViewColumn; var Text: string) of object;
  TdxMVGetPreviewLineCountEvent = procedure(Sender: TdxMasterViewLevel;
    Node: TdxMasterViewNode; var LineCount: Integer) of object;
  TdxMVGetPreviewTextEvent = procedure(Sender: TdxMasterViewLevel;
    Node: TdxMasterViewNode; var Text: string) of object;
  TdxMVLevelGetStyleEvent = procedure(Sender: TdxMasterViewLevel;
    Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
    var NewStyle: TdxMasterViewStyle) of object;
  TdxMVNodeEvent = procedure(Sender: TdxMasterViewLevel; Node: TdxMasterViewNode) of object;
  TdxMVNodeAllowEvent = procedure(Sender: TdxMasterViewLevel; Node: TdxMasterViewNode;
    var Allow: Boolean) of object;

  TdxMasterViewLevel = class(TComponent)
  private
    FAbsoluteIndex: Integer;
    FAssignWidthsLockCount: Integer;
    FBeforeLoadActiveRecord: Integer;
    FBeforeLoadBOF: Boolean;
    FBeforeLoadBookmark: Pointer;
    FBeforeLoadEOF: Boolean;
    FCanUseSmartReload: Boolean;
    FCaption: string;
    FCaptionStyle: TdxMasterViewStyle;
    FColumns: TList;
    FContentStyle: TdxMasterViewStyle;
    FControl: TdxMasterView;
    FCursorBeforeLoading: TCursor;
    FDataChanging: Boolean;
    FDataChangingLockCount: Integer;
    FDataLink: TdxMasterViewDataLink;
    FDeleteConfirmCaptionText: string;
    FDeleteConfirmText: string;
    FDetailKey: string;
    FDetailKeyFields: TList;
    FEditingNode: TdxMasterViewNode;
    FFirstVisibleNode: TdxMasterViewNode;
    FFirstVisibleNodeWithData: TdxMasterViewNode;
    FFooterStyle: TdxMasterViewStyle;
    FGridLinesBrush: HBRUSH;
    FGridLinesPen: HPEN;
    FGridLinesColor: TColor;
    FGroupByBoxStyle: TdxMasterViewStyle;
    FGroupColumns: TList;
    FGroupStyle: TdxMasterViewStyle;
    FHeaderStyle: TdxMasterViewStyle;
    FHorizontal: Boolean;
    FID: string;
    FIDFields: TList;
    FIndex: Integer;
    FIsInsertMode: Boolean;
    FItems: TList;
    FLayout: TdxMasterViewLayout;
    FLevelSeparatorBrush: HBRUSH;
    FLevelSeparatorColor: TColor;
    FLevelSeparatorWidth: Integer;
    FLoadingLockCount: Integer;
    FLoadLockCount: Integer;
    FMasterKey: string;
    FMasterKeyFields: TList;
    FMultipleDeleteConfirmText: string;
    FOptionsBehavior: TdxMasterViewLevelOptionsBehavior;
    FOptionsCustomize: TdxMasterViewLevelOptionsCustomize;
    FOptionsCustomizeBox: TdxMasterViewLevelOptionsCustomizeBox;
    FOptionsDB: TdxMasterViewLevelOptionsDB;
    FOptionsHeader: TdxMasterViewLevelOptionsHeader;
    FOptionsView: TdxMasterViewLevelOptionsView;
    FParent: TdxMasterViewLevel;
    FParentCount: Integer;
    FParents: TdxMVLevels;
    FPreviewDC: HDC;
    FPreviewField: TField;
    FPreviewFieldName: string;
    FPreviewLeftIndent: Integer;
    FPreviewLineCount: Integer;
    FPreviewMaxLength: Integer;
    FPreviewMaxLineCount: Integer;
    FPreviewPrevFont: HFONT;
    FPreviewRightIndent: Integer;
    FPreviewStyle: TdxMasterViewStyle;
    FRowSeparatorBrush: HBRUSH;
    FRowSeparatorColor: TColor;
    FRowSeparatorWidth: Integer;
    FSortedColumns: TList;
    FSortingLockCount: Integer;
    FSummaryColumns: TList;
    FViewMode: TdxMasterViewViewMode;
    FVisible: Boolean;
    FVisibleColumns: TList;

    FHeaderHeight, FContentHeight, FFooterHeight,
      FHeaderRealHeight, FContentRealHeight,
      FCaptionHeight, FGroupHeight, FGroupByBoxTextHeight: Integer;
    FLineWidth, FExtLineWidth: Integer;

    // for GetParentNode function
    GPNGroupValue, GPNFindingValue, GPNCurValue: Variant;
    GPNDisplayText, GPNS1, GPNS2: string;
    GPNCanUseAnsiCompareStrOnGrouping, GPNCanUseCaseInsensitiveGrouping,
      GPNFindingValueIsNull, GPNCurValueIsNull, GPNReverseOrder: Boolean;
    GPNParentNode: TdxMasterViewNode;

    FOnChangeGrouping: TdxMVChangeGroupingEvent;
    FOnCollapsed: TdxMVNodeEvent;
    FOnCollapsing: TdxMVNodeAllowEvent;
    FOnColumnSorted: TdxMVColumnEvent;
    FOnColumnSorting: TdxMVColumnAllowEvent;
    FOnDeleteNode: TdxMVNodeEvent;
    FOnExpanded: TdxMVNodeEvent;
    FOnExpanding: TdxMVNodeAllowEvent;
    FOnFilterRecord: TdxMVFilterRecordEvent;
    FOnGetCaptionStyle: TdxMVLevelGetStyleEvent;
    FOnGetContentStyle: TdxMVLevelGetStyleEvent;
    FOnGetFooterCellText: TdxMVGetFooterCellTextEvent;
    FOnGetFooterStyle: TdxMVLevelGetStyleEvent;
    FOnGetGroupByBoxStyle: TdxMVLevelGetStyleEvent;
    FOnGetGroupStyle: TdxMVLevelGetStyleEvent;
    FOnGetHeaderStyle: TdxMVLevelGetStyleEvent;
    FOnGetPreviewLineCount: TdxMVGetPreviewLineCountEvent;
    FOnGetPreviewStyle: TdxMVLevelGetStyleEvent;
    FOnGetPreviewText: TdxMVGetPreviewTextEvent;
    FOnHideColumn: TdxMVColumnEvent;
    FOnShowColumn: TdxMVColumnEvent;
    FOnWidthChanged: TNotifyEvent;

    function GetActive: Boolean;
    function GetCaptionBrush: HBRUSH;
    function GetCaptionColor: TColor;
    function GetCaptionFont: TFont;
    function GetColumn(Index: Integer): TdxMasterViewColumn;
    function GetColumnCount: Integer;
    function GetContentAnotherBrush: HBRUSH;
    function GetContentAnotherColor: TColor;
    function GetContentBrush: HBRUSH;
    function GetContentColor: TColor;
    function GetContentFont: TFont;
    function GetCount: Integer;
    function GetDataSet: TDataSet;
    function GetDataSource: TDataSource;
    function GetDetailKeyField(Index: Integer): TField;
    function GetDetailKeyFieldCount: Integer;
    function GetDontFilterRecords: Boolean;
    function GetFooterBrush: HBRUSH;
    function GetFooterColor: TColor;
    function GetFooterFont: TFont;
    function GetGroupBrush: HBRUSH;
    function GetGroupByBoxBrush: HBRUSH;
    function GetGroupByBoxColor: TColor;
    function GetGroupByBoxFont: TFont;
    function GetGroupByBoxFontColor: TColor;
    function GetGroupByBoxHeight: Integer;
    function GetGroupColor: TColor;
    function GetGroupColumn(Index: Integer): TdxMasterViewColumn;
    function GetGroupColumnCount: Integer;
    function GetGroupFont: TFont;
    function GetHasChildren: Boolean;
    function GetHeaderBrush: HBRUSH;
    function GetHeaderColor: TColor;
    function GetHeaderFont: TFont;
    function GetHeaderRestSpaceBrush: HBRUSH;
    function GetHeaderRestSpaceColor: TColor;
    function GetIDField(Index: Integer): TField;
    function GetIDFieldCount: Integer;
    function GetIndent: Integer;
    function GetIsDestroying: Boolean;
    function GetIsFirst: Boolean;
    function GetIsLast: Boolean;
    function GetIsLoading: Boolean;
    function GetIsTop: Boolean;
    function GetItem(Index: Integer): TdxMasterViewLevel;
    function GetMasterKeyField(Index: Integer): TField;
    function GetMasterKeyFieldCount: Integer;
    function GetNonScaledWidth: Integer;
    function GetOccupyRestSpace: Boolean;
    function GetParent(Index: Integer): TdxMasterViewLevel;
    function GetPreviewAnotherBrush: HBRUSH;
    function GetPreviewAnotherColor: TColor;
    function GetPreviewBrush: HBRUSH;
    function GetPreviewColor: TColor;
    function GetPreviewColorAssigned: Boolean;
    function GetPreviewFont: TFont;
    function GetPreviewFontAssigned: Boolean;
    function GetPreviewFontColor: TColor;
    function GetRowCount: Integer;
    function GetShowCaption: Boolean;
    function GetShowFooter: Boolean;
    function GetShowGrid: Boolean;
    function GetShowGridWithPreview: Boolean;
    function GetShowGroupByBox: Boolean;
    function GetShowHeader: Boolean;
    function GetShowPreview: Boolean;
    function GetSmartLoad: Boolean;
    function GetSmartReload: Boolean;
    function GetSortedColumn(Index: Integer): TdxMasterViewColumn;
    function GetSortedColumnCount: Integer;
    function GetVisibleColumn(Index: Integer): TdxMasterViewColumn;
    function GetVisibleColumnCount: Integer;
    function GetVisibleRowCount: Integer;
    function GetVisibleWidth: Integer;
    procedure SetCaption(const Value: string);
    procedure SetCaptionStyle(Value: TdxMasterViewStyle);
    procedure SetColumn(Index: Integer; Value: TdxMasterViewColumn);
    procedure SetContentStyle(Value: TdxMasterViewStyle);
    procedure SetDataSource(Value: TDataSource);
    procedure SetDetailKey(const Value: string);
    procedure SetFooterStyle(Value: TdxMasterViewStyle);
    procedure SetGridLinesColor(Value: TColor);
    procedure SetGroupByBoxStyle(Value: TdxMasterViewStyle);
    procedure SetGroupStyle(Value: TdxMasterViewStyle);
    procedure SetHeaderStyle(Value: TdxMasterViewStyle);
    procedure SetID(Value: string);
    procedure SetMasterKey(const Value: string);
    procedure SetOptionsDB(Value: TdxMasterViewLevelOptionsDB);
    procedure SetOptionsHeader(Value: TdxMasterViewLevelOptionsHeader);
    procedure SetOptionsView(Value: TdxMasterViewLevelOptionsView);
    procedure SetPreviewField(Value: TField);
    procedure SetPreviewFieldInternally(Value: TField);
    procedure SetPreviewFieldName(Value: string);
    procedure SetPreviewLeftIndent(Value: Integer);
    procedure SetPreviewLineCount(Value: Integer);
    procedure SetPreviewMaxLength(Value: Integer);
    procedure SetPreviewMaxLineCount(Value: Integer);
    procedure SetPreviewRightIndent(Value: Integer);
    procedure SetPreviewStyle(Value: TdxMasterViewStyle);
    procedure SetRowSeparatorColor(Value: TColor);
    procedure SetRowSeparatorWidth(Value: Integer);
    procedure SetLevelSeparatorColor(Value: TColor);
    procedure SetLevelSeparatorWidth(Value: Integer);
    procedure SetViewMode(Value: TdxMasterViewViewMode);
    procedure SetVisibleColumn(Index: Integer; Value: TdxMasterViewColumn);

    function IsDeleteConfirmCaptionTextStored: Boolean;
    function IsDeleteConfirmTextStored: Boolean;
    function IsMultipleDeleteConfirmTextStored: Boolean;
    procedure ReadHeaderWidths(Reader: TReader);
    procedure WriteHeaderWidths(Writer: TWriter);

    procedure AddColumn(AColumn: TdxMasterViewColumn);
    procedure RemoveColumn(AColumn: TdxMasterViewColumn);
    procedure AddItem(Value: TdxMasterViewLevel);
    procedure RemoveItem(Value: TdxMasterViewLevel);
    function FindPreviewField: TField;
    procedure FontsChanged;
    procedure DeleteNodes;
    procedure RefreshDetailKeyFieldsList;
    procedure RefreshIDFieldsList;
    procedure RefreshMasterKeyFieldsList;
    procedure RefreshVisibleColumnsList;
    procedure SummaryColumnsChanged(AColumn: TdxMasterViewColumn; Operation: TOperation);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;

    procedure ActiveChanged;
    procedure AfterPaint;
    procedure AssignColumnWidths;
    procedure BeforePaint;
    procedure BeginLoad;
    procedure BeginLoading;
    procedure CalcDefaultWidths(Column: TdxMasterViewColumn);
    procedure CalcLineWidth;
    procedure CalcParents;
    procedure CalcRealHeights;
    procedure DestroySummaries(NodeTypes: TdxMasterViewNodeTypes);
    procedure EndLoad(RecalcInfo: Boolean);
    procedure EndLoading;
    procedure LoadingComplete;

    procedure CalcPreviewLineCount(DC: HDC; const S: string; Width: Integer;
      Node: TdxMasterViewNode; var Height: Integer);
    function CanDelete: Boolean;
    function CanGrouping(Column: TdxMasterViewColumn; Index: Integer): Boolean;
    function CanHorSizing: Boolean;
    function CanInsert: Boolean;
    function CanSmartRefresh: Boolean;
    function CanSorting(Column: TdxMasterViewColumn): Boolean;
    procedure CaptionStyleChanged(Values: TdxMasterViewStyleValues);
    procedure ChangeGrouping(Column: TdxMasterViewColumn; AIndex: Integer);
    procedure ChangeSorting(Column: TdxMasterViewColumn;
      ASortOrder: TdxMasterViewSortOrder; ASortIndex: Integer);
    procedure ContentStyleChanged(Values: TdxMasterViewStyleValues);
    procedure DataChanged;
    procedure DoAfterCollapse(Node: TdxMasterViewNode);
    procedure DoAfterExpand(Node: TdxMasterViewNode);
    function DoBeforeCollapse(Node: TdxMasterViewNode): Boolean;
    function DoBeforeExpand(Node: TdxMasterViewNode): Boolean;
    procedure DoGetContentStyle(Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
      var NewStyle: TdxMasterViewStyle); virtual;
    procedure DoGetFooterCellText(Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
      var Text: string);
    procedure DoHideColumn(Column: TdxMasterViewColumn);
    procedure DoNodeDeleted(Node: TdxMasterViewNode);
    procedure DoShowColumn(Column: TdxMasterViewColumn);
    procedure DoSorting;
    procedure DrawIndent(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
    procedure DrawGroupByBox(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
    procedure DrawHeader(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
    procedure DrawContent(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
    procedure DrawFooter(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
    procedure EditingChanged;
    procedure FooterStyleChanged(Values: TdxMasterViewStyleValues);
    function GetCurDetailKeyValue: Variant;
    function GetCurIDValue: Variant;
    function GetCurKeyValue: Variant;
    function GetCurMasterKeyValue: Variant;
    function GetCurPreviewText(Node: TdxMasterViewNode): string;
    function GetParentNode(Root, Node: TdxMasterViewNode;
      FirstIndex, AvailIndex: PInteger; RestItems: TList;
      CheckRoot: Boolean): TdxMasterViewNode;
    procedure GroupByBoxStyleChanged(Values: TdxMasterViewStyleValues);
    procedure GroupStyleChanged(Values: TdxMasterViewStyleValues);
    function HasExpandButton: Boolean;
    function HasGrid: Boolean;
    //function HasAsChild(Level: TdxMasterViewLevel): Boolean;
    function HasAsParent(Level: TdxMasterViewLevel): Boolean;
    procedure HeaderStyleChanged(Values: TdxMasterViewStyleValues);
    function IndexOfParent(Level: TdxMasterViewLevel): Integer;
    procedure LayoutChanged;
    procedure LevelChanged(HardRefresh: Boolean);
    function LoadDataOnExpand: Boolean;
    procedure MakeVisibleColumnsSortedList(List: TList);
    procedure PreviewChanged;
    procedure PreviewStyleChanged(Values: TdxMasterViewStyleValues);
    procedure RecordChanged(Field: TField);
    procedure RemoveFreeSpace;
    procedure RestoreVisibleColumnsPlaces(var List: TList);
    procedure SaveVisibleColumnsPlaces(var List: TList);
    procedure FreeVisibleColumnsPlaces(var List: TList);
    procedure SyncPos;
    procedure UncheckTriedToExpand;
    procedure WidthChanged;
    procedure WidthChangedEx;

    property Active: Boolean read GetActive;
    property DataLink: TdxMasterViewDataLink read FDataLink;
    property IsLoading: Boolean read GetIsLoading;

    property CaptionHeight: Integer read FCaptionHeight;
    property ContentHeight: Integer read FContentHeight;
    property ContentRealHeight: Integer read FContentRealHeight;
    property ExtLineWidth: Integer read FExtLineWidth;
    property FooterHeight: Integer read FFooterHeight;
    property GroupByBoxHeight: Integer read GetGroupByBoxHeight;
    property GroupByBoxTextHeight: Integer read FGroupByBoxTextHeight;
    property GroupHeight: Integer read FGroupHeight;
    property HeaderHeight: Integer read FHeaderHeight;
    property HeaderRealHeight: Integer read FHeaderRealHeight;
    property Indent: Integer read GetIndent;
    property IsDestroying: Boolean read GetIsDestroying;
    property LineWidth: Integer read FLineWidth;
    property NonScaledWidth: Integer read GetNonScaledWidth;
    property VisibleWidth: Integer read GetVisibleWidth;

    property Horizontal: Boolean read FHorizontal;
    property ParentCount: Integer read FParentCount;
    property Parents[Index: Integer]: TdxMasterViewLevel read GetParent;
    property RowCount: Integer read GetRowCount;
    property VisibleRowCount: Integer read GetVisibleRowCount;

    property GridLinesBrush: HBRUSH read FGridLinesBrush;
    property GridLinesPen: HPEN read FGridLinesPen;
    property LevelSeparatorBrush: HBRUSH read FLevelSeparatorBrush;
    property RowSeparatorBrush: HBRUSH read FRowSeparatorBrush;

    property DontFilterRecords: Boolean read GetDontFilterRecords;
    property OccupyRestSpace: Boolean read GetOccupyRestSpace;
    property ShowCaption: Boolean read GetShowCaption;
    property ShowFooter: Boolean read GetShowFooter;
    property ShowGrid: Boolean read GetShowGrid;
    property ShowGridWithPreview: Boolean read GetShowGridWithPreview;
    property ShowGroupByBox: Boolean read GetShowGroupByBox;
    property ShowHeader: Boolean read GetShowHeader;
    property ShowPreview: Boolean read GetShowPreview;
    property SmartLoad: Boolean read GetSmartLoad;
    property SmartReload: Boolean read GetSmartReload;

    property HeaderBrush: HBRUSH read GetHeaderBrush;
    property HeaderColor: TColor read GetHeaderColor;
    property HeaderFont: TFont read GetHeaderFont;
    property HeaderRestSpaceBrush: HBRUSH read GetHeaderRestSpaceBrush;
    property HeaderRestSpaceColor: TColor read GetHeaderRestSpaceColor;
    property ContentAnotherBrush: HBRUSH read GetContentAnotherBrush;
    property ContentAnotherColor: TColor read GetContentAnotherColor;
    property ContentBrush: HBRUSH read GetContentBrush;
    property ContentColor: TColor read GetContentColor;
    property ContentFont: TFont read GetContentFont;
    property FooterBrush: HBRUSH read GetFooterBrush;
    property FooterColor: TColor read GetFooterColor;
    property FooterFont: TFont read GetFooterFont;
    property PreviewAnotherBrush: HBRUSH read GetPreviewAnotherBrush;
    property PreviewAnotherColor: TColor read GetPreviewAnotherColor;
    property PreviewBrush: HBRUSH read GetPreviewBrush;
    property PreviewColor: TColor read GetPreviewColor;
    property PreviewColorAssigned: Boolean read GetPreviewColorAssigned;
    property PreviewFont: TFont read GetPreviewFont;
    property PreviewFontAssigned: Boolean read GetPreviewFontAssigned;
    property PreviewFontColor: TColor read GetPreviewFontColor;
    property CaptionBrush: HBRUSH read GetCaptionBrush;
    property CaptionColor: TColor read GetCaptionColor;
    property CaptionFont: TFont read GetCaptionFont;
    property GroupBrush: HBRUSH read GetGroupBrush;
    property GroupColor: TColor read GetGroupColor;
    property GroupFont: TFont read GetGroupFont;
    property GroupByBoxBrush: HBRUSH read GetGroupByBoxBrush;
    property GroupByBoxColor: TColor read GetGroupByBoxColor;
    property GroupByBoxFont: TFont read GetGroupByBoxFont;
    property GroupByBoxFontColor: TColor read GetGroupByBoxFontColor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    function Add: TdxMasterViewLevel;
    procedure BeginAssignWidths;
    procedure BeginDataChanging;
    procedure BeginLayout;
    procedure BeginSorting;
    procedure CancelAssignWidths;
    procedure CancelDataChanging;
    procedure CancelLayout;
    procedure CancelSorting;
    procedure Clear;
    procedure ClearSorting(ExceptionalColumn: TdxMasterViewColumn);
    function ColumnByFieldName(const AFieldName: string): TdxMasterViewColumn;
    function ColumnByName(const AName: string): TdxMasterViewColumn;
    procedure CreateAllColumns;
    function CreateColumn(AColumnClass: TdxMasterViewColumnClass): TdxMasterViewColumn;
    procedure DestroyColumns;
    procedure EndAssignWidths;
    procedure EndDataChanging;
    procedure EndLayout;
    procedure EndSorting;

    property AbsoluteIndex: Integer read FAbsoluteIndex;
    property CanUseSmartReload: Boolean read FCanUseSmartReload write FCanUseSmartReload;
    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TdxMasterViewColumn read GetColumn write SetColumn;
    property Control: TdxMasterView read FControl;
    property Count: Integer read GetCount;
    property DataSet: TDataSet read GetDataSet;
    property DetailKeyFieldCount: Integer read GetDetailKeyFieldCount;
    property DetailKeyFields[Index: Integer]: TField read GetDetailKeyField;
    property GroupColumnCount: Integer read GetGroupColumnCount;
    property GroupColumns[Index: Integer]: TdxMasterViewColumn read GetGroupColumn;
    property HasChildren: Boolean read GetHasChildren;
    property IDFieldCount: Integer read GetIDFieldCount;
    property IDFields[Index: Integer]: TField read GetIDField;
    property Index: Integer read FIndex;
    property IsFirst: Boolean read GetIsFirst;
    property IsLast: Boolean read GetIsLast;
    property IsTop: Boolean read GetIsTop;
    property Items[Index: Integer]: TdxMasterViewLevel read GetItem; default;
    property Layout: TdxMasterViewLayout read FLayout;
    property MasterKeyFieldCount: Integer read GetMasterKeyFieldCount;
    property MasterKeyFields[Index: Integer]: TField read GetMasterKeyField;
    property Parent: TdxMasterViewLevel read FParent;
    property PreviewField: TField read FPreviewField write SetPreviewField;
    property SortedColumnCount: Integer read GetSortedColumnCount;
    property SortedColumns[Index: Integer]: TdxMasterViewColumn read GetSortedColumn;
    property Visible: Boolean read FVisible;
    property VisibleColumnCount: Integer read GetVisibleColumnCount;
    property VisibleColumns[Index: Integer]: TdxMasterViewColumn
      read GetVisibleColumn write SetVisibleColumn;

    procedure GetContentParams(Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
      ABrush: PBRUSH; ATextColor, ABkColor: PColor; AFont: PFont; CheckSelected: Boolean);
    procedure GetFooterParams(Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
      ABrush: PBRUSH; ATextColor, ABkColor: PColor; AFont: PFont);
    procedure GetGroupByBoxParams(Node: TdxMasterViewNode;
      ABrush: PBRUSH; ATextColor, ABkColor: PColor; AFont: PFont);
    procedure GetHeaderParams(Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
      ABrush, ARestSpaceBrush: PBRUSH; ATextColor, ABkColor: PColor; AFont: PFont);
    procedure GetPreviewParams(Node: TdxMasterViewNode;
      ABrush: PBRUSH; ATextColor, ABkColor: PColor; AFont: PFont);
  published
    property Caption: string read FCaption write SetCaption;
    property CaptionStyle: TdxMasterViewStyle read FCaptionStyle write SetCaptionStyle;
    property ContentStyle: TdxMasterViewStyle read FContentStyle write SetContentStyle;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DeleteConfirmCaptionText: string read FDeleteConfirmCaptionText
      write FDeleteConfirmCaptionText stored IsDeleteConfirmCaptionTextStored;
    property DeleteConfirmText: string read FDeleteConfirmText write FDeleteConfirmText
      stored IsDeleteConfirmTextStored;
    property DetailKey: string read FDetailKey write SetDetailKey;
    property FooterStyle: TdxMasterViewStyle read FFooterStyle write SetFooterStyle;
    property GridLinesColor: TColor read FGridLinesColor write SetGridLinesColor
      default clBtnShadow;
    property GroupByBoxStyle: TdxMasterViewStyle read FGroupByBoxStyle
      write SetGroupByBoxStyle;
    property GroupStyle: TdxMasterViewStyle read FGroupStyle write SetGroupStyle;
    property HeaderStyle: TdxMasterViewStyle read FHeaderStyle write SetHeaderStyle;
    property ID: string read FID write SetID;
    property LevelSeparatorColor: TColor read FLevelSeparatorColor
      write SetLevelSeparatorColor default clWindowText{!};
    property LevelSeparatorWidth: Integer read FLevelSeparatorWidth
      write SetLevelSeparatorWidth default 0;
    property MasterKey: string read FMasterKey write SetMasterKey;
    property MultipleDeleteConfirmText: string read FMultipleDeleteConfirmText
      write FMultipleDeleteConfirmText stored IsMultipleDeleteConfirmTextStored;
    property OptionsBehavior: TdxMasterViewLevelOptionsBehavior read FOptionsBehavior
      write FOptionsBehavior default [lobDblClkExpanding];
    property OptionsCustomize: TdxMasterViewLevelOptionsCustomize read FOptionsCustomize
      write FOptionsCustomize default [locColumnMoving, locColumnHorSizing,
      locColumnVerSizing, locColumnSorting, locColumnGrouping, locShowColumnOnUngrouping];
    property OptionsCustomizeBox: TdxMasterViewLevelOptionsCustomizeBox read FOptionsCustomizeBox
      write FOptionsCustomizeBox default [loxCaption, loxColumns, loxGrid,
      loxGroupByBox, loxHeader, loxViewMode];
    property OptionsDB: TdxMasterViewLevelOptionsDB read FOptionsDB
      write SetOptionsDB default [lodConfirmDelete, lodSmartLoad, lodSmartReload];
    property OptionsHeader: TdxMasterViewLevelOptionsHeader read FOptionsHeader
      write SetOptionsHeader default [lohForFirstNode, lohForFirstVisibleNode, lohAfterExpandedNode];
    property OptionsView: TdxMasterViewLevelOptionsView read FOptionsView write SetOptionsView
      default [lovGrid, lovGridWithPreview, lovHeader, lovOccupyRestSpace];
    property PreviewFieldName: string read FPreviewFieldName write SetPreviewFieldName;
    property PreviewLeftIndent: Integer read FPreviewLeftIndent write SetPreviewLeftIndent
      default dxMVPreviewLeftIndent;
    property PreviewLineCount: Integer read FPreviewLineCount write SetPreviewLineCount
      default 0;
    property PreviewMaxLength: Integer read FPreviewMaxLength write SetPreviewMaxLength
      default 0;
    property PreviewMaxLineCount: Integer read FPreviewMaxLineCount write SetPreviewMaxLineCount
      default dxMVPreviewMaxLineCount;
    property PreviewRightIndent: Integer read FPreviewRightIndent write SetPreviewRightIndent
      default dxMVPreviewRightIndent;
    property PreviewStyle: TdxMasterViewStyle read FPreviewStyle write SetPreviewStyle;
    property RowSeparatorColor: TColor read FRowSeparatorColor write SetRowSeparatorColor
      default clBtnShadow;
    property RowSeparatorWidth: Integer read FRowSeparatorWidth write SetRowSeparatorWidth
      default 0;
    property ViewMode: TdxMasterViewViewMode read FViewMode write SetViewMode default vmHorizontal;

    property OnChangeGrouping: TdxMVChangeGroupingEvent read FOnChangeGrouping
      write FOnChangeGrouping;
    property OnCollapsed: TdxMVNodeEvent read FOnCollapsed write FOnCollapsed;
    property OnCollapsing: TdxMVNodeAllowEvent read FOnCollapsing write FOnCollapsing;
    property OnColumnSorted: TdxMVColumnEvent read FOnColumnSorted write FOnColumnSorted;
    property OnColumnSorting: TdxMVColumnAllowEvent read FOnColumnSorting
      write FOnColumnSorting;
    property OnDeleteNode: TdxMVNodeEvent read FOnDeleteNode write FOnDeleteNode;
    property OnExpanded: TdxMVNodeEvent read FOnExpanded write FOnExpanded;
    property OnExpanding: TdxMVNodeAllowEvent read FOnExpanding write FOnExpanding;
    property OnFilterRecord: TdxMVFilterRecordEvent read FOnFilterRecord write FOnFilterRecord;
    property OnGetCaptionStyle: TdxMVLevelGetStyleEvent read FOnGetCaptionStyle
      write FOnGetCaptionStyle;
    property OnGetContentStyle: TdxMVLevelGetStyleEvent read FOnGetContentStyle
      write FOnGetContentStyle;
    property OnGetFooterCellText: TdxMVGetFooterCellTextEvent read FOnGetFooterCellText
      write FOnGetFooterCellText;
    property OnGetFooterStyle: TdxMVLevelGetStyleEvent read FOnGetFooterStyle
      write FOnGetFooterStyle;
    property OnGetGroupByBoxStyle: TdxMVLevelGetStyleEvent read FOnGetGroupByBoxStyle
      write FOnGetGroupByBoxStyle;
    property OnGetGroupStyle: TdxMVLevelGetStyleEvent read FOnGetGroupStyle
      write FOnGetGroupStyle;
    property OnGetHeaderStyle: TdxMVLevelGetStyleEvent read FOnGetHeaderStyle
      write FOnGetHeaderStyle;
    property OnGetPreviewLineCount: TdxMVGetPreviewLineCountEvent read FOnGetPreviewLineCount
      write FOnGetPreviewLineCount;  
    property OnGetPreviewStyle: TdxMVLevelGetStyleEvent read FOnGetPreviewStyle
      write FOnGetPreviewStyle;
    property OnGetPreviewText: TdxMVGetPreviewTextEvent read FOnGetPreviewText
      write FOnGetPreviewText;
    property OnHideColumn: TdxMVColumnEvent read FOnHideColumn write FOnHideColumn;
    property OnShowColumn: TdxMVColumnEvent read FOnShowColumn write FOnShowColumn;
    property OnWidthChanged: TNotifyEvent read FOnWidthChanged write FOnWidthChanged;
  end;

  PdxMasterViewNodeList = ^TdxMasterViewNodeList;
  TdxMasterViewNodeList = array[0..MaxListSize - 1] of TdxMasterViewNode;
  TdxMasterViewListSortCompare = function (Item1, Item2: TdxMasterViewNode): Integer;
  TdxMasterViewListMode = (lmItems, lmAbsoluteItems, lmSelectedItems);

  TdxMasterViewList = class
  private
    FCapacity: Integer;
    FCount: Integer;
    FDeletionLockCount: Integer;
    FInsertionLockCount: Integer;
    FList: PdxMasterViewNodeList;
    FMode: TdxMasterViewListMode;
    FNewCount, FPrevCount: Integer;
    FOwner: TdxMasterViewNode;
    function Get(Index: Integer): TdxMasterViewNode;
    procedure Put(Index: Integer; Item: TdxMasterViewNode);
    procedure SetCapacity(NewCapacity: Integer);
    procedure SetCount(NewCount: Integer);
  protected
    procedure Grow;
  public
    constructor Create(AOwner: TdxMasterViewNode; AMode: TdxMasterViewListMode);
    destructor Destroy; override;
    function Add(Item: TdxMasterViewNode): Integer;
    procedure BeginDeletion;   // these two optimization's methods must not intersect
    procedure BeginInsertion;
    procedure Clear;
    procedure CopyTo(List: TList);
    procedure Delete(Index: Integer);
    procedure EndDeletion;
    procedure EndInsertion;
    class procedure Error(const Msg: string; Data: Integer);
    function First: TdxMasterViewNode;
    function IndexOf(Item: TdxMasterViewNode): Integer;
    procedure Insert(Index: Integer; Item: TdxMasterViewNode);
    function Last: TdxMasterViewNode;
    procedure Move(CurIndex, NewIndex: Integer);
    function Remove(Item: TdxMasterViewNode): Integer;
    procedure Sort(Compare: TdxMasterViewListSortCompare;
      TopBound, BottomBound: Integer);

    property Capacity: Integer read FCapacity write SetCapacity;
    property Count: Integer read FCount write SetCount;
    property Items[Index: Integer]: TdxMasterViewNode read Get write Put; default;
    property List: PdxMasterViewNodeList read FList;
    property Owner: TdxMasterViewNode read FOwner;
  end;

  TdxMasterViewNodeViewInfoOption = (vioClipped);
  TdxMasterViewNodeViewInfoOptions = set of TdxMasterViewNodeViewInfoOption;
  TdxMasterViewNodeViewInfo = record
    Bounds: TRect;
    Width: Integer;
    GroupByBoxSize: Integer;
    HeaderSize: Integer;
    PreviewSize: Integer;
    FooterSize: Integer;
    EndLevelCount: Integer;
    EndLevelData: Integer;
    Options: TdxMasterViewNodeViewInfoOptions;
    LevelIndex: Integer;
  end;

  PdxMVSortingValues = ^TdxMVSortingValues;
  TdxMVSortingValues = array[0..MaxInt div SizeOf(PVariant) - 1] of PVariant;
  PdxMVSortingData = ^TdxMVSortingData;
  TdxMVSortingData = array[0..MaxInt div SizeOf(PdxMVSortingValues) - 1] of PdxMVSortingValues;
  PdxMVSummaryValues = ^TdxMVSummaryValues;
  TdxMVSummaryValues = array[0..MaxInt div SizeOf(Extended) - 1] of Extended;
  PdxMVSummaries = ^TdxMVSummaries;
  TdxMVSummaries = array[0..MaxInt div SizeOf(PdxMVSummaryValues) - 1] of PdxMVSummaryValues;

  TdxMasterViewNode = class
  private
    FAbsoluteIndex: Integer;
    FControl: TdxMasterView;  //change to FLevel.Control? (4 times slower)
    FData: Pointer;
    FExpanded: Boolean;
    FGroupIndex: Integer;
    FID: Variant;
    FIndex: Integer;
    FItems: TdxMasterViewList;
    FKeyValue: Variant;
    FLevel: TdxMasterViewLevel;
    FNodeType: TdxMasterViewNodeType;
    FParentNode: TdxMasterViewNode;
    FPreviewText: string;
    FSelectedIndex: Integer;
    FSummaries: PdxMVSummaries;
    FSummariesInitialized: Boolean;
    FTriedToExpand: Boolean;
    FValues: TStrings;
    FViewInfo: TdxMasterViewNodeViewInfo;

    function GetBounds: TRect;
    function GetContentBounds: TRect;
    function GetContentBoundsWithoutPreview: TRect;
    function GetCount: Integer;
    function GetCountInLevel(ALevel: TdxMasterViewLevel): Integer;
    function GetFirst: TdxMasterViewNode;
    function GetFirstInLevel(ALevel: TdxMasterViewLevel): TdxMasterViewNode;
    function GetFocused: Boolean;
    function GetFooterBounds: TRect;
    function GetFullBounds: TRect;
    function GetFullContentBounds: TRect;
    function GetFullFooterBounds: TRect;
    function GetFullGroupByBoxBounds: TRect;
    function GetFullHeaderBounds: TRect;
    function GetGroupByBoxBounds: TRect;
    function GetGroupByBoxColumnBounds(Index: Integer): TRect;
    function GetGroupIndex: Integer;
    function GetHasChildren: Boolean;
    function GetHeaderBounds: TRect;
    function GetHeaderColBounds(Index: Integer): TRect;
    function GetHeaderRowBounds(Index: Integer): TRect;
    function GetHorizontal: Boolean;
    function GetIsEditing: Boolean;
    function GetIsFirst: Boolean;
    function GetIsFirstInLevel: Boolean;
    function GetIsLast: Boolean;
    function GetIsLastInLevel: Boolean;
    function GetItem(Index: Integer): TdxMasterViewNode;
    function GetLast: TdxMasterViewNode;
    function GetLastInLevel(ALevel: TdxMasterViewLevel): TdxMasterViewNode;
    function GetLeftSpaceBounds: TRect;
    function GetNodeWithSummaryData(ALevel: TdxMasterViewLevel): TdxMasterViewNode;
    function GetParentNodes(Index: Integer): TdxMasterViewNode;
    function GetParentNodeWithData: TdxMasterViewNode;
    function GetPreviewBounds: TRect;
    function GetRightSpaceBounds: TRect;
    function GetSelected: Boolean;
    function GetString(Index: Integer): string;
    function GetSubFooterBounds(AParentIndex: Integer): TRect;
    function GetValue(Index: Integer): Variant;
    function GetValueCount: Integer;
    function GetVisible: Boolean;
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetSelected(Value: Boolean);

    procedure AddItem(AIndex: Integer; Value: TdxMasterViewNode);
    procedure RemoveItem(Value: TdxMasterViewNode);
    procedure SetHasLevelSeparator(var EndLevelData: Integer; ALevelParentIndex: Integer);
    procedure SetHasRowSeparator(var EndLevelData: Integer; ALevelParentIndex: Integer);
  protected
    function Add(ALevel: TdxMasterViewLevel; AIndex: Integer;
      ANodeType: TdxMasterViewNodeType; const AID, AKeyValue: Variant): TdxMasterViewNode;
    procedure AddToList(ALevel: TdxMasterViewLevel;
      OtherNodesList, GroupNodesList: TList; ProcessRoot: Boolean);
    procedure AddVisibleToList(List: TdxMasterViewList);
    function CanDelete: Boolean;
    function CanExpand: Boolean;
    procedure ChangeExpanded(Value: Boolean);
    procedure CheckChildNodes(ALevel: TdxMasterViewLevel;
      NeedCheckParentNodes: Boolean);
    procedure CheckExpanded;
    procedure CheckParentNodes;
    procedure Clear;
    procedure ClearValues;
    function ContainsDataInChildren(ALevel: TdxMasterViewLevel): Boolean;
    procedure DoSmartLoadChanged(ALevel: TdxMasterViewLevel);
    procedure DoSorting(ALevel: TdxMasterViewLevel);
    procedure Draw(DC: HDC);
    function GetAvailIndex(AChildLevelIndex: Integer): Integer;
    function GetLastSubChild: TdxMasterViewNode;
    function GetLevelIndex: Integer;
    function HasDataInChildren(ALevel: TdxMasterViewLevel): Boolean;
    function InSelectedPeriod: Boolean;
    procedure Invalidate(Column: TdxMasterViewColumn; VPart: TdxMasterViewVPart);
    procedure MoveData(ALevel: TdxMasterViewLevel; FromIndex, ToIndex: Integer);
    procedure NodeChanged(HardRefresh: Boolean);
    procedure Sync;
    procedure SyncPos;
    procedure UpdateData(UpdateSelf, UpdateChildren, UpdateOther: Boolean);
    procedure UpdateDataForLevel(ALevel: TdxMasterViewLevel);

    procedure CreateSummaries;
    procedure DestroySummaries;
    procedure CheckSummaries;
    procedure InitializeSummaries(ALevel: TdxMasterViewLevel);
    procedure CalcSummaries(UseRealData: Boolean);
    procedure FinalizeSummaries(ALevel: TdxMasterViewLevel);

    function BeginLevel(var Size: Integer): Boolean;
    function EndLevel(var Size, EndLevelCount, EndLevelData: Integer): Boolean;
    function HasExpandButton: Boolean;
    function HasFooter(AParentIndex: Integer): Boolean;
    function HasGroupByBox(var Size: Integer): Boolean;
    function HasHeader(ATopIndex: Integer; var Size: Integer): Boolean;
    function HasLevelSeparator(ALevelParentIndex: Integer): Boolean;
    function HasPreview: Boolean;
    function HasRowSeparator(ALevelParentIndex: Integer): Boolean;
    function HasSummariesData: Boolean;  
    function CalcViewInfo(const ATopIndex: Integer; const R: TRect;
      const AIndent, AWidth: Integer; var AFooterSize: Integer; const StoreInfo: Boolean): Integer;
    procedure ClearViewInfo;
    function ContentColIndexFromX(X: Integer): Integer;
    function ContentRowIndexFromY(Y: Integer): Integer;
    function FooterColIndexFromX(AParentIndex: Integer; X: Integer): Integer;
    function FooterRowIndexFromY(AParentIndex: Integer; Y: Integer): Integer;
    function HeaderColIndexFromX(X: Integer): Integer;
    function HeaderRowIndexFromY(Y: Integer): Integer;
    function InternalHeaderRowIndexFromY(Y: Integer): Integer;
    function ShowExpandButton: Boolean;

    property NodesWithSummaryData[ALevel: TdxMasterViewLevel]: TdxMasterViewNode
      read GetNodeWithSummaryData;

    property Bounds: TRect read GetBounds;
    property ContentBounds: TRect read GetContentBounds;
    property ContentBoundsWithoutPreview: TRect read GetContentBoundsWithoutPreview;
    property FooterBounds: TRect read GetFooterBounds;
    property FullBounds: TRect read GetFullBounds;
    property FullContentBounds: TRect read GetFullContentBounds;
    property FullFooterBounds: TRect read GetFullFooterBounds;
    property FullGroupByBoxBounds: TRect read GetFullGroupByBoxBounds;
    property FullHeaderBounds: TRect read GetFullHeaderBounds;
    property GroupByBoxBounds: TRect read GetGroupByBoxBounds;
    property GroupByBoxColumnBounds[Index: Integer]: TRect read GetGroupByBoxColumnBounds;
    property HeaderBounds: TRect read GetHeaderBounds;
    property HeaderColBounds[Index: Integer]: TRect read GetHeaderColBounds;
    property HeaderRowBounds[Index: Integer]: TRect read GetHeaderRowBounds;
    property LeftSpaceBounds: TRect read GetLeftSpaceBounds;
    property PreviewBounds: TRect read GetPreviewBounds;
    property RightSpaceBounds: TRect read GetRightSpaceBounds;
    property SubFooterBounds[AParentIndex: Integer]: TRect read GetSubFooterBounds;
    property ViewInfo: TdxMasterViewNodeViewInfo read FViewInfo;
  public
    constructor Create(AControl: TdxMasterView; ALevel: TdxMasterViewLevel;
      AParentNode: TdxMasterViewNode; AIndex: Integer;
      ANodeType: TdxMasterViewNodeType; const AID, AKeyValue: Variant);
    destructor Destroy; override;
    procedure Collapse(Recurse: Boolean);
    procedure Delete;
    procedure Expand(Recurse: Boolean);
    function FindChildren: Boolean;
    function GetParentNode(ALevel: TdxMasterViewLevel;
      OnlyDataNodes: Boolean): TdxMasterViewNode;
    procedure MakeVisible;
    procedure LoadChildren(Recurse: Boolean);
    function NodeFromID(ALevel: TdxMasterViewLevel; const AID: Variant): TdxMasterViewNode;
    function NodeFromKeyValue(ALevel: TdxMasterViewLevel; AChildIndex: Integer;
      const AKeyValue: Variant): TdxMasterViewNode;

    property AbsoluteIndex: Integer read FAbsoluteIndex;
    property Control: TdxMasterView read FControl;
    property Count: Integer read GetCount;
    property CountInLevel[ALevel: TdxMasterViewLevel]: Integer read GetCountInLevel;
    property Data: Pointer read FData write FData;
    property Expanded: Boolean read FExpanded write SetExpanded;
    property First: TdxMasterViewNode read GetFirst;
    property FirstInLevel[ALevel: TdxMasterViewLevel]: TdxMasterViewNode read GetFirstInLevel;
    property Focused: Boolean read GetFocused write SetFocused;
    property GroupIndex: Integer read FGroupIndex;
    property GroupValue: Variant read FKeyValue;
    property GroupValueText: Variant read FID;
    property HasChildren: Boolean read GetHasChildren;
    property Horizontal: Boolean read GetHorizontal; 
    property ID: Variant read FID;
    property Index: Integer read FIndex;
    property IsEditing: Boolean read GetIsEditing;
    property IsFirst: Boolean read GetIsFirst;
    property IsFirstInLevel: Boolean read GetIsFirstInLevel;
    property IsLast: Boolean read GetIsLast;
    property IsLastInLevel: Boolean read GetIsLastInLevel;
    property Items[Index: Integer]: TdxMasterViewNode read GetItem; default;
    property ItemsList: TdxMasterViewList read FItems;
    property KeyValue: Variant read FKeyValue;
    property Last: TdxMasterViewNode read GetLast;
    property LastInLevel[ALevel: TdxMasterViewLevel]: TdxMasterViewNode read GetLastInLevel;
    property Level: TdxMasterViewLevel read FLevel;
    property NodeType: TdxMasterViewNodeType read FNodeType;
    property ParentNode: TdxMasterViewNode read FParentNode;
    property ParentNodes[Index: Integer]: TdxMasterViewNode read GetParentNodes;
    property ParentNodeWithData: TdxMasterViewNode read GetParentNodeWithData;
    property PreviewText: string read FPreviewText write FPreviewText;
    property Selected: Boolean read GetSelected write SetSelected;
    property SelectedIndex: Integer read FSelectedIndex;
    property StringCount: Integer read GetValueCount;
    property Strings[Index: Integer]: string read GetString;
    property ValueCount: Integer read GetValueCount;
    property Values[Index: Integer]: Variant read GetValue;
    property Visible: Boolean read GetVisible;
  end;

  TdxMasterViewDragDetect = (ddNone, ddDrag, ddCancel);
  TdxMasterViewDragSource = (dsHeader, dsGroupByBox, dsCustomizingForm);
  TdxMasterViewDirection = (dirNone, dirLeft, dirUp, dirRight, dirDown);
  TdxMasterViewHitTestCode = (htNone, htLeftSpace, htRightSpace, htIndent, htGroupByBox,
    htHeader, htHeaderLeftEdge, htHeaderRightEdge, htHeaderTopEdge, htHeaderBottomEdge,
    htContent, htExpandButton, htContentLeftEdge, htContentRightEdge, htPreview,
    htFooter, htCustomizationForm, htOther);
  TdxMasterViewState =
    (mvsCtrlClick, mvsIndentClick, mvsAnchorSelected, mvsSelectPeriod,
     mvsColumnSizing, mvsColumnMoving, mvsScrolling);
  TdxMasterViewStates = set of TdxMasterViewState;

  TdxMasterViewOptionBehavior =
    (mobAnsiCompareStrOnGrouping, mobAnsiCompareStrOnSorting,
     mobCaseInsensitiveGrouping, mobCaseInsensitiveSorting, mobMultiSelect,
     mobShowHourGlassCursor, mobStoreInIniFile, mobStoreInRegistry,
     mobUseIndent);
  TdxMasterViewOptionsBehavior = set of TdxMasterViewOptionBehavior;

  TdxMasterViewOptionDB = (modSyncMove);
  TdxMasterViewOptionsDB = set of TdxMasterViewOptionDB;

  TdxMasterViewOptionView =
    (movAnimation, movAutoColumnWidth, movDrawEndEllipsis, movHideFocusRect,
     movHideSelection, movKeepColumnWidths,
     movTransparentDragAndDrop, movUseBitmap, movUseBitmapToDrawPreview);
  TdxMasterViewOptionsView = set of TdxMasterViewOptionView;

  TdxMasterViewRegIniFileMode = (riIniFile, riRegistry);
  
  TdxMVScrollBars = (sbAuto, sbHorizontal, sbVertical, sbBoth, sbNone);

  TdxMVColumnMovingEvent = procedure(Sender: TdxMasterView; Column: TdxMasterViewColumn;
    P: TPoint; RowIndex, ColIndex: Integer; InsertIntoNewRow: Boolean;
    var Accept: Boolean) of object;
  TdxMVCustomizingEvent = procedure(Sender: TdxMasterView; Showing: Boolean) of object;
  TdxMVFocusNodeEvent = procedure(Sender: TdxMasterView; PrevNode,
    CurNode: TdxMasterViewNode) of object;
  TdxMVLevelEvent = procedure(Sender: TdxMasterView; Level: TdxMasterViewLevel) of object;
  TdxMVSelectNodeEvent = procedure(Sender: TdxMasterView; Node: TdxMasterViewNode;
    var Allow: Boolean) of object;

  TdxMasterView = class(TCustomControl)
  private
    FAbsoluteItems: TdxMasterViewList;
    FAbsoluteLevels: TList;
    FAnimation: Boolean;
    FArrowsColor: TColor;
    FBitmap: TBitmap;
    FBtnHighlightPen: HPEN;
    FBtnShadowPen: HPEN;
    FCalculatingScrollableWidth: Boolean;
    FCustomizationForm: TWinControl;
    FCustomizationFormPos: TPoint;
    FCustomizationFormRowCount: Integer;
    FCustomizing: Boolean;
    FDontInvalidate: Boolean;
    FFocusedNode: TdxMasterViewNode;
    FFrozen: Boolean;
    FHighlightStyle: TdxMasterViewStyle;
    FInactiveStyle: TdxMasterViewStyle;
    FIniFileName: string;
    FItems: TdxMasterViewNode;
    FLastMousePos: TPoint;
    FLastPartVisibleItemCount: Integer;
    FLastSelectedNode: TdxMasterViewNode;
    FLastVisibleItemCount: Integer;
    FLayoutLockCount: Integer;
    FLeftPos: Integer;
    FLevels: TdxMasterViewLevel;
    FMovingColumn: TdxMasterViewColumn;
    FMovingColumnNode: TdxMasterViewNode;
    FOptionsBehavior: TdxMasterViewOptionsBehavior;
    FOptionsDB: TdxMasterViewOptionsDB;
    FOptionsView: TdxMasterViewOptionsView;
    FPainting: Boolean;
    FPrevTopNode: TdxMasterViewNode;
    FRegistryPath: string;
    FScrollableWidth: Integer;
    FScrollBars: TdxMVScrollBars;
    FScrollTimer: UINT;
    FSelectedItems: TdxMasterViewList;
    FSelectionAnchor: TdxMasterViewNode;
    FSelectionLockCount: Integer;
    FSizingColumn: TdxMasterViewColumn;
    FSortingColumnCount: Integer;
    FSortingData: PdxMVSortingData;
    FSortingDesc: PBoolArray;
    FState: TdxMasterViewStates;
    FStyles: TList;
    FTopNode: TdxMasterViewNode;
    FTopNodeChangeLockCount: Integer;
    FUpdateLockCount: Integer;
    FUpdatingData: Boolean;

    // for sorting
    SortV1, SortV2: PVariant;
    SortS1, SortS2: string;

    FOnAfterColumnMoving: TdxMVColumnMovingEvent;
    FOnAfterUpdateData: TdxMVLevelEvent;
    FOnBeforeColumnMoving: TdxMVColumnMovingEvent;
    FOnBeforeFocusNode: TdxMVSelectNodeEvent;
    FOnBeforeUpdateData: TdxMVLevelEvent;
    FOnColumnMoving: TdxMVColumnMovingEvent;
    FOnCustomizing: TdxMVCustomizingEvent;
    FOnFocusNode: TdxMVFocusNodeEvent;
    FOnLeftPosChanged: TNotifyEvent;
    FOnSelectNode: TdxMVSelectNodeEvent;
    FOnSelectionChanged: TNotifyEvent;
    FOnTopNodeChanged: TNotifyEvent;

    function GetAbsoluteItemCount: Integer;
    function GetAbsoluteItem(Index: Integer): TdxMasterViewNode;
    function GetAbsoluteLevelCount: Integer;
    function GetAbsoluteLevel(Index: Integer): TdxMasterViewLevel;
    function GetAnimation: Boolean;
    function GetAutoColumnWidth: Boolean;
    function GetCustomizationFormLevel: TdxMasterViewLevel;
    function GetFocusedIndex: Integer;
    function GetHasFocus: Boolean;
    function GetHighlightBrush: HBRUSH;
    function GetHighlightColor: TColor;
    function GetHighlightFontColor: TColor;
    function GetInactiveBrush: HBRUSH;
    function GetInactiveColor: TColor;
    function GetInactiveFocusBrush: HBRUSH;
    function GetInactiveFocusColor: TColor;
    function GetInactiveFontColor: TColor;
    function GetIsDesigning: Boolean;
    function GetIsDestroying: Boolean;
    function GetIsLoading: Boolean;
    function GetMultiSelect: Boolean;
    function GetPartVisibleItemCount: Integer;
    function GetSelectedItem(Index: Integer): TdxMasterViewNode;
    function GetSelectedItemCount: Integer;
    function GetShowHourGlassCursor: Boolean;
    function GetStyle(Index: Integer): TdxMasterViewStyle;
    function GetStyleCount: Integer;
    function GetSyncMove: Boolean;
    function GetTopIndex: Integer;
    function GetTransparentDragAndDrop: Boolean;
    function GetUseIndent: Boolean;
    function GetVisibleItemCount: Integer;
    function GetWidthForColumns: Integer;
    procedure SetCanUseSmartReload(Value: Boolean);
    procedure SetCustomizationFormLevel(Value: TdxMasterViewLevel);
    procedure SetCustomizationFormRowCount(Value: Integer);
    procedure SetCustomizing(Value: Boolean);
    procedure SetFocusedIndex(Value: Integer);
    procedure SetFocusedNode(Value: TdxMasterViewNode);
    procedure SetHighlightStyle(Value: TdxMasterViewStyle);
    procedure SetInactiveStyle(Value: TdxMasterViewStyle);
    procedure SetLeftPos(Value: Integer);
    procedure SetOptionsBehavior(Value: TdxMasterViewOptionsBehavior);
    procedure SetOptionsDB(Value: TdxMasterViewOptionsDB);
    procedure SetOptionsView(Value: TdxMasterViewOptionsView);
    procedure SetScrollBars(Value: TdxMVScrollBars);
    procedure SetTopIndex(Value: Integer);
    procedure SetTopNode(Value: TdxMasterViewNode);

    procedure AddStyle(AStyle: TdxMasterViewStyle);
    procedure RemoveStyle(AStyle: TdxMasterViewStyle);

    procedure AddSelectedItem(ANode: TdxMasterViewNode);
    procedure RemoveSelectedItem(ANode: TdxMasterViewNode);
    procedure ClearSelectedItems;

    procedure CreateScrollTimer(Direction: TdxMasterViewDirection);
    procedure DestroyScrollTimer;

    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMMouseWheel(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure SetName(const NewName: TComponentName); override;
    procedure WndProc(var Message: TMessage); override;

    procedure BeginAnimation;
    procedure EndAnimation;
    procedure BeforePaint;
    procedure AfterPaint;
    procedure BeginTopNodeChange;
    procedure EndTopNodeChange;
    property BtnHighlightPen: HPEN read FBtnHighlightPen;
    property BtnShadowPen: HPEN read FBtnShadowPen;

    procedure CalcScrollableWidth(CallingLevel: TdxMasterViewLevel);
    procedure CalcViewInfo(ATopIndex: Integer; AHeight: Integer;
      var AVisibleItemCount, APartVisibleItemCount: Integer; CalcNodesViewInfo: Boolean);
    procedure AssignColumnWidths;
    function GetAnimatableHeight: Integer;
    procedure SetScrollBarsInfo(var AVisibleItemCount, APartVisibleItemCount: Integer);
    procedure WidthChanged;

    function CanScroll(Direction: TdxMasterViewDirection): Boolean;
    function CheckLeftPos(Value: Integer): Integer;
    function CheckTopIndex(Value: Integer): Integer;
    procedure CheckFocusedNode;
    procedure DestroyStyles;
    procedure DoAfterUpdateData(Level: TdxMasterViewLevel); virtual;
    procedure DoBeforeUpdateData(Level: TdxMasterViewLevel); virtual;
    procedure DoColumnMoving(Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
      const InitialP: TPoint; DragSource: TdxMasterViewDragSource);
    procedure DoColumnHorSizing(Column: TdxMasterViewColumn; ContentSizing: Boolean);
    procedure DoColumnVerSizing(Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
      Edge: TdxMasterViewHitTestCode);
    procedure DoNodeDeleted(Node: TdxMasterViewNode); virtual;
    procedure DoScrolling;
    procedure DoSelectionChanged; virtual;
    function DoSelectNode(Node: TdxMasterViewNode): Boolean;
    procedure DoSorting;
    procedure DoTopNodeChanged; virtual;
    procedure HighlightStyleChanged(Values: TdxMasterViewStyleValues);
    procedure InactiveStyleChanged(Values: TdxMasterViewStyleValues);

    function CanFocusNode(Node: TdxMasterViewNode): Boolean;
    procedure ChangeFocusedIndex(Value: Integer);
    function GetFirstNodeFromVisible(Level: TdxMasterViewLevel): TdxMasterViewNode;
    function GetLastNodeFromVisible(Level: TdxMasterViewLevel): TdxMasterViewNode;
    function GetNextNode(Value: TdxMasterViewNode; OnSameLevel: Boolean): TdxMasterViewNode;
    function GetPrevNode(Value: TdxMasterViewNode; OnSameLevel: Boolean): TdxMasterViewNode;
    procedure ShowPrevPage(CurTopIndex: Integer; OnSameLevel: Boolean);
    procedure ShowNextPage(CurBottomIndex: Integer; OnSameLevel: Boolean);
    procedure Scroll(Direction: TdxMasterViewDirection);
    procedure RefreshAbsoluteItems;
    procedure RefreshAbsoluteLevels;
    procedure SelectPeriod(ToNode: TdxMasterViewNode);
    procedure InvalidateSelection;

    procedure Modified;

    procedure Freeze;
    function FreezeDataSet(ALevel: TdxMasterViewLevel): Integer;
    procedure Unfreeze;
    procedure UnfreezeDataSet(ALevel: TdxMasterViewLevel);
    property Frozen: Boolean read FFrozen;

    property Animation: Boolean read GetAnimation;
    property AutoColumnWidth: Boolean read GetAutoColumnWidth;
    property HasFocus: Boolean read GetHasFocus;
    property IsDesigning: Boolean read GetIsDesigning;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property MultiSelect: Boolean read GetMultiSelect;
    property ScrollableWidth: Integer read FScrollableWidth;
    property ShowHourGlassCursor: Boolean read GetShowHourGlassCursor;
    property SyncMove: Boolean read GetSyncMove;
    property TransparentDragAndDrop: Boolean read GetTransparentDragAndDrop;
    property UseIndent: Boolean read GetUseIndent;
    property WidthForColumns: Integer read GetWidthForColumns;
    
    property HighlightBrush: HBRUSH read GetHighlightBrush;
    property HighlightColor: TColor read GetHighlightColor;
    property HighlightFontColor: TColor read GetHighlightFontColor;
    property InactiveBrush: HBRUSH read GetInactiveBrush;
    property InactiveColor: TColor read GetInactiveColor;
    property InactiveFocusColor: TColor read GetInactiveFocusColor;
    property InactiveFocusBrush: HBRUSH read GetInactiveFocusBrush;
    property InactiveFontColor: TColor read GetInactiveFontColor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure DrawText(const DrawDC: HDC; var ARect: TRect;
      const Font: TFont; const Brush: HBRUSH; const TextColor, BkColor: TColor;
      const Alignment: TAlignment; const Text: string;
      const FillBackground, MakeRightSpace, AllowUseBitmap, MultiLine: Boolean);
    function GetSelectionParams(Node: TdxMasterViewNode;
      ABrush: PBRUSH; ATextColor, ABkColor: PColor): Boolean;
    procedure PrepareBitmap(const AWidth, AHeight: Integer);

    property AbsoluteItemsList: TdxMasterViewList read FAbsoluteItems;
    property Bitmap: TBitmap read FBitmap write FBitmap;
    property SelectedItemsList: TdxMasterViewList read FSelectedItems;

    procedure ApplyBestFit(Level: TdxMasterViewLevel; Column: TdxMasterViewColumn);
    procedure BeginLayout;
    procedure BeginSelection;
    procedure BeginUpdate;
    procedure CancelLayout;
    procedure CancelUpdate;
    procedure ClearSelection;
    function CreateStyle(AStyleClass: TdxMasterViewStyleClass): TdxMasterViewStyle;
    procedure DeleteSelection;
    procedure EndLayout;
    procedure EndSelection;
    procedure EndUpdate;
    procedure FocusNode(Node: TdxMasterViewNode; ChangeSelection: Boolean);
    procedure FullCollapse;
    procedure FullExpand;
    function GetHitTestInfo(const P: TPoint; var Node: TdxMasterViewNode;
      var Column: TdxMasterViewColumn; var RowIndex, ColIndex: Integer): TdxMasterViewHitTestCode;
    procedure LoadFromRegIniFile(const AFileName: string; AMode: TdxMasterViewRegIniFileMode);
    function NodeFromID(ALevel: TdxMasterViewLevel; const AID: Variant): TdxMasterViewNode;
    function NodeFromKeyValue(ALevel: TdxMasterViewLevel; AChildIndex: Integer;
      const AKeyValue: Variant): TdxMasterViewNode;
    procedure SaveToRegIniFile(const AFileName: string; AMode: TdxMasterViewRegIniFileMode);
    procedure SelectItems(FromIndex, ToIndex: Integer; Select: Boolean);
    procedure ShowFocusedNode;
    procedure UpdateData;

    property AbsoluteItemCount: Integer read GetAbsoluteItemCount;
    property AbsoluteItems[Index: Integer]: TdxMasterViewNode read GetAbsoluteItem;
    property AbsoluteLevelCount: Integer read GetAbsoluteLevelCount;
    property AbsoluteLevels[Index: Integer]: TdxMasterViewLevel read GetAbsoluteLevel;
    property CanUseSmartReload: Boolean write SetCanUseSmartReload;
    property CustomizationForm: TWinControl read FCustomizationForm;
    property CustomizationFormLevel: TdxMasterViewLevel read GetCustomizationFormLevel
      write SetCustomizationFormLevel;
    property CustomizationFormPos: TPoint read FCustomizationFormPos write FCustomizationFormPos;
    property Customizing: Boolean read FCustomizing write SetCustomizing;
    property FocusedIndex: Integer read GetFocusedIndex write SetFocusedIndex;
    property FocusedNode: TdxMasterViewNode read FFocusedNode write SetFocusedNode;
    property Items: TdxMasterViewNode read FItems;
    property LeftPos: Integer read FLeftPos write SetLeftPos;
    property Levels: TdxMasterViewLevel read FLevels;
    property MovingColumn: TdxMasterViewColumn read FMovingColumn;
    property MovingColumnNode: TdxMasterViewNode read FMovingColumnNode;
    property PartVisibleItemCount: Integer read GetPartVisibleItemCount;
    property SelectedItemCount: Integer read GetSelectedItemCount;
    property SelectedItems[Index: Integer]: TdxMasterViewNode read GetSelectedItem;
    property State: TdxMasterViewStates read FState;
    property StyleCount: Integer read GetStyleCount;
    property Styles[Index: Integer]: TdxMasterViewStyle read GetStyle;
    property TopIndex: Integer read GetTopIndex write SetTopIndex;
    property TopNode: TdxMasterViewNode read FTopNode write SetTopNode;
    property SizingColumn: TdxMasterViewColumn read FSizingColumn;
    property VisibleItemCount: Integer read GetVisibleItemCount;
  published
    property Align;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
  {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    property DragKind;
  {$ENDIF}

    property ArrowsColor: TColor read FArrowsColor write FArrowsColor default clLime;
    property CustomizationFormRowCount: Integer read FCustomizationFormRowCount
      write SetCustomizationFormRowCount default dxMVCustomizationFormRowCount;
    property HighlightStyle: TdxMasterViewStyle read FHighlightStyle write SetHighlightStyle;
    property InactiveStyle: TdxMasterViewStyle read FInactiveStyle write SetInactiveStyle;
    property IniFileName: string read FIniFileName write FIniFileName;
    property OptionsBehavior: TdxMasterViewOptionsBehavior read FOptionsBehavior
      write SetOptionsBehavior default [mobUseIndent];
    property OptionsDB: TdxMasterViewOptionsDB read FOptionsDB write SetOptionsDB
      default [modSyncMove];
    property OptionsView: TdxMasterViewOptionsView read FOptionsView write SetOptionsView
      default [movAnimation, movHideFocusRect, movKeepColumnWidths,
        movTransparentDragAndDrop, movUseBitmapToDrawPreview];
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property ScrollBars: TdxMVScrollBars read FScrollBars write SetScrollBars
      default sbAuto;

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
  {$IFDEF DELPHI4}
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}

    property OnAfterColumnMoving: TdxMVColumnMovingEvent read FOnAfterColumnMoving
      write FOnAfterColumnMoving;
    //property OnAfterUpdateData: TdxMVLevelEvent read FOnAfterUpdateData write FOnAfterUpdateData;
    property OnBeforeColumnMoving: TdxMVColumnMovingEvent read FOnBeforeColumnMoving
      write FOnBeforeColumnMoving;
    property OnBeforeFocusNode: TdxMVSelectNodeEvent read FOnBeforeFocusNode write FOnBeforeFocusNode;
    //property OnBeforeUpdateData: TdxMVLevelEvent read FOnBeforeUpdateData
    //  write FOnBeforeUpdateData;
    property OnColumnMoving: TdxMVColumnMovingEvent read FOnColumnMoving write FOnColumnMoving;
    property OnCustomizing: TdxMVCustomizingEvent read FOnCustomizing write FOnCustomizing;
    property OnFocusNode: TdxMVFocusNodeEvent read FOnFocusNode write FOnFocusNode;
    property OnLeftPosChanged: TNotifyEvent read FOnLeftPosChanged write FOnLeftPosChanged;
    property OnSelectNode: TdxMVSelectNodeEvent read FOnSelectNode write FOnSelectNode;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnTopNodeChanged: TNotifyEvent read FOnTopNodeChanged write FOnTopNodeChanged;
  end;

function DragDetect(Wnd: HWND): TdxMasterViewDragDetect;

var
  dxMVDesigner: TdxMVDesigner;

  dxMVGroupByBoxText: string;

function dxMasterViewColumnClass(Index: Integer): TdxMasterViewColumnClass;
function dxMasterViewColumnCount: Integer;
procedure dxMasterViewRegisterColumn(AColumnClass: TdxMasterViewColumnClass);
procedure dxMasterViewUnregisterColumn(AColumnClass: TdxMasterViewColumnClass);

procedure TransparentDraw(const DrawDC: HDC; var FullRect: TRect;
  const Alignment: TAlignment; const Brush: HBRUSH; const ABitmap: TBitmap);

implementation

{$R dxMasterView.res}

uses
  Consts,{$IFDEF DELPHI6} RTLConsts,{$ENDIF} Buttons, SysUtils, StdCtrls,
  ExtCtrls, CheckLst, IniFiles, Registry, dxMasterViewStrs;

const
  MaxExtended = 1.1E4932;
  MinExtended = -MaxExtended;

  crdxMasterViewMirror = 1501;
  crdxMasterViewFullScroll = 1502;
  crdxMasterViewHorScroll = 1503;
  crdxMasterViewVerScroll = 1504;
  crdxMasterViewUpScroll = 1505;
  crdxMasterViewRightScroll = 1506;
  crdxMasterViewDownScroll = 1507;
  crdxMasterViewLeftScroll = 1508;
  crdxMasterViewHorSize = 1509;
  crdxMasterViewVerSize = 1512;
  crdxMasterViewRemove = 1510;
  crdxMasterViewNoDrop = 1511;

  DefaultLineWidth = 1;
  ExpandButtonIndent = 3;
  ExpandButtonSize = 12;
  LevelIndent = ExpandButtonIndent + ExpandButtonSize + ExpandButtonIndent;
  ColumnSizingZoneWidth = 4;
  InsertZoneWidth = 10;

  HScrollDelta = 10;
  ScrollTimeStep = 70;
  ScrollLeftTimerId = 1;
  ScrollUpTimerId = 2;
  ScrollRightTimerId = 3;
  ScrollDownTimerId = 4;
  ColumnMovingHScrollZone = 15;

  AnimationOriginalStep = 1;
  AnimationIncreaseStepDivisor1 = 100;  // collapse (TopIndex = PrevTopIndex)
  AnimationIncreaseStepDivisor2 =  40;  // collapse (TopIndex <> PrevTopIndex)
  AnimationIncreaseStepDivisor3 = 100;  // expand

  SortOrderMarkZoneWidth = 16;
  SortOrderMarkWidth = 8;
  SortOrderMarkHeight = 7;

  GroupByBoxLeftOffset = 8;
  GroupByBoxTopOffset = 8;
  GroupByBoxHorOffset = 4;
  GroupByBoxVerOffset = 0;
  GroupByBoxColumnWidth = 100;
  GroupByBoxLineColor = clBtnText;

  LeftHitTests = [htLeftSpace, htIndent, htExpandButton];
  HeaderHitTests = [htHeader..htHeaderBottomEdge];
  ContentHitTests = [htContent, htContentLeftEdge, htContentRightEdge];

type
  TDummyDataSet = class(TDataSet);

  PRegColumnRecord = ^TRegColumnRecord;
  TRegColumnRecord = record
    ColumnClass: TdxMasterViewColumnClass;
  end;

var
  RegColumnList: TList;

function dxMasterViewColumnClass(Index: Integer): TdxMasterViewColumnClass;
begin
  Result := PRegColumnRecord(RegColumnList[Index])^.ColumnClass;
end;

function dxMasterViewColumnCount: Integer;
begin
  Result := RegColumnList.Count;
end;

procedure dxMasterViewRegisterColumn(AColumnClass: TdxMasterViewColumnClass);
var
  RegColumnRecord: PRegColumnRecord;
begin
  New(RegColumnRecord);
  with RegColumnRecord^ do
  begin
    ColumnClass := AColumnClass;
  end;
  RegColumnList.Add(RegColumnRecord);
  RegisterClass(AColumnClass);
end;

procedure dxMasterViewUnregisterColumn(AColumnClass: TdxMasterViewColumnClass);
var
  I: Integer;
begin
  for I := 0 to dxMasterViewColumnCount - 1 do
    if dxMasterViewColumnClass(I) = AColumnClass then
    begin
      Dispose(PRegColumnRecord(RegColumnList[I]));
      RegColumnList.Delete(I);
      UnregisterClass(AColumnClass);
      Break;
    end;
end;

function DragDetect(Wnd: HWND): TdxMasterViewDragDetect;
var
  NoDragZone: TRect;
  P: TPoint;
  Msg: TMsg;
begin
  Result := ddCancel;

  GetCursorPos(P);
  with NoDragZone, P do
  begin
    Right := 2 * GetSystemMetrics(SM_CXDRAG);
    Bottom := 2 * GetSystemMetrics(SM_CYDRAG);
    Left := X - Right div 2;
    Top := Y - Bottom div 2;
    Inc(Right, Left);
    Inc(Bottom, Top);
  end;

  SetCapture(Wnd);
  try
    while GetCapture = Wnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if Msg.wParam = VK_ESCAPE then Break;
          WM_MOUSEMOVE:
            begin
              P := SmallPointToPoint(TSmallPoint(Msg.lParam));
              ClientToScreen(Msg.hwnd, P);
              if not PtInRect(NoDragZone, P) then
              begin
                Result := ddDrag;
                Break;
              end;
            end;
          WM_LBUTTONUP:
            begin
              Result := ddNone;
              Break;
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = Wnd then ReleaseCapture;
  end;
end;

procedure CalcFontSize(AFont: TFont; var Size: TSize);
var
  DC: HDC;
  PrevFont: HFONT;
begin
  DC := GetDC(0);
  PrevFont := SelectObject(DC, AFont.Handle);
  GetTextExtentPoint{32}(DC, 'Qq', 2, Size);
  SelectObject(DC, PrevFont);
  ReleaseDC(0, DC);
  Size.cx := Size.cx div 2;
end;

procedure DrawExpandButton(DC: HDC; const ARect: TRect; BkBrush: HBRUSH;
  Expanded, Enabled: Boolean);
var
  X, Y: Integer;
  R: TRect;
  CrossBrush: HBRUSH;

  procedure DrawCross;
  begin
    FillRect(DC, Rect(X - 2, Y, X + 3, Y + 1), CrossBrush);
    if not Expanded then
      FillRect(DC, Rect(X, Y - 2, X + 1, Y + 3), CrossBrush);
  end;

begin
  with ARect do
  begin
    X := (Left + Right - ExpandButtonSize) div 2;
    Y := (Top + Bottom - ExpandButtonSize) div 2;
    FillRect(DC, Rect(Left, Top, Right, Y), BkBrush);
    FillRect(DC, Rect(Left, Y + ExpandButtonSize, Right, Bottom), BkBrush);
    FillRect(DC, Rect(Left, Y, X, Y + ExpandButtonSize), BkBrush);
    FillRect(DC, Rect(X + ExpandButtonSize, Y, Right, Y + ExpandButtonSize), BkBrush);
  end;
  with R do
  begin
    Left := X;
    Top := Y;
    Right := Left + ExpandButtonSize;
    Bottom := Top + ExpandButtonSize;
    DrawEdge(DC, R, BDR_RAISEDINNER, BF_LEFT or BF_TOP);
    DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RIGHT or BF_BOTTOM);
    InflateRect(R, -1, -1);
    DrawEdge(DC, R, BDR_RAISEDINNER, BF_RIGHT or BF_BOTTOM);
    Dec(Right);
    Dec(Bottom);
    FillRect(DC, R, COLOR_BTNFACE + 1);
    X := (Left + Right - 1) div 2;
    Y := (Top + Bottom - 1) div 2;
    if Enabled then
    begin
      CrossBrush := COLOR_BTNTEXT + 1;
      DrawCross;
    end
    else
    begin
      Inc(X);
      Inc(Y);
      CrossBrush := COLOR_BTNHIGHLIGHT + 1;
      DrawCross;
      Dec(X);
      Dec(Y);
      CrossBrush := COLOR_BTNSHADOW + 1;
      DrawCross;
    end;
  end;
end;

procedure TransparentDraw(const DrawDC: HDC; var FullRect: TRect;
  const Alignment: TAlignment; const Brush: HBRUSH; const ABitmap: TBitmap);
const
  ROP_DSPDxax = $00E20746;
var
  BW, BH, X, Y: Integer;
  DC, MaskDC: HDC;
  B, MaskB: HBITMAP;
  ATextColor, ABackColor: COLORREF;
  ABrush: HBRUSH;
begin
  with FullRect do
  begin
    BW := ABitmap.Width;
    BH := ABitmap.Height;
    case Alignment of
      taLeftJustify:
        X := Left;
      taRightJustify:
        X := Right - BW;
    else
      X := (Left + Right - BW) div 2;
    end;
    if X < Left then X := Left;
    if X + BW > Right then BW := Right - X;
    case Alignment of
      taLeftJustify:
        Left := X + BW;
      taRightJustify:
        Right := X;
    end;
    Y := (Top + Bottom - BH) div 2;
    if Y < Top then Y := Top;
    if Y + BH > Bottom then BH := Bottom - Y;

    DC := CreateCompatibleDC(DrawDC);
    B := CreateCompatibleBitmap(DrawDC, BW, BH);
    B := SelectObject(DC, B);
    try
      BitBlt(DC, 0, 0, BW, BH, ABitmap.Canvas.Handle, 0, 0, SRCCOPY);

      MaskDC := CreateCompatibleDC(DrawDC);
      MaskB := CreateBitmap(BW, BH, 1, 1, nil);
      MaskB := SelectObject(MaskDC, MaskB);
      try
        ABackColor := SetBkColor(DC, ColorToRGB(ABitmap.TransparentColor));
        BitBlt(MaskDC, 0, 0, BW, BH, DC, 0, 0, SRCCOPY);

        ATextColor := SetTextColor(DC, 0);
        SetBkColor(DC, $FFFFFF);
        ABrush := SelectObject(DC, Brush);
        BitBlt(DC, 0, 0, BW, BH, MaskDC, 0, 0, ROP_DSPDxax);
        SelectObject(DC, ABrush);
        SetTextColor(DC, ATextColor);
        SetBkColor(DC, ABackColor);
      finally
        DeleteObject(SelectObject(MaskDC, MaskB));
        DeleteDC(MaskDC);
      end;

      BitBlt(DrawDC, X, Y, BW, BH, DC, 0, 0, SRCCOPY);
    finally
      DeleteObject(SelectObject(DC, B));
      DeleteDC(DC);
    end;
  end;
end;

procedure DrawDowned(DC: HDC; const R: TRect);
begin
  with R do
    BitBlt(DC, Left, Top, Right - Left, Bottom - Top, 0, 0, 0, DSTINVERT);
end;

procedure ProcessPaintMessages(Wnd: HWND);
const
  MessageCount = 4;
  Messages: array[0..MessageCount - 1] of UINT =
    (WM_NCCALCSIZE, WM_NCPAINT, WM_ERASEBKGND, WM_PAINT);
var
  Exists: Boolean;
  I: Integer;
  Msg: TMsg;
begin
  repeat
    for I := 0 to MessageCount - 1 do
    begin
      Exists := PeekMessage(Msg, Wnd, Messages[I], Messages[I], PM_REMOVE);
      if Exists then
      begin
        DispatchMessage(Msg);
        Break;
      end;
    end;
  until not Exists;
  UpdateWindow(Wnd);
end;

function IsBetween(N, N1, N2: TdxMasterViewNode): Boolean;
var
  I, M1, M2: Integer;
begin
  if (N1 = nil) or (N2 = nil) then Result := False
  else
  begin
    I := N.AbsoluteIndex;
    M1 := N1.AbsoluteIndex;
    M2 := N2.AbsoluteIndex;
    if M1 < M2 then Result := (M1 <= I) and (I <= M2)
    else Result := (M2 <= I) and (I <= M1);
  end;
end;

function VarAnsiUpperCase(const V: Variant): Variant;
begin
  if VarIsNull(V) or VarIsEmpty(V) then
    Result := V
  else
    Result := AnsiUpperCase(V);
end;

function VarAreEqual(const V1, V2: Variant): Boolean;
var
  I: Integer;
begin
  if not VarIsArray(V1) then
    if VarIsEmpty(V1) or VarIsEmpty(V2) then
      Result := False
    else
      try
        Result := V1 = V2
      except
        Result := False
      end
  else
  begin
    Result := True;
    for I := 0 to VarArrayHighBound(V1, 1) do
      try
        if V1[I] <> V2[I] then
        begin
          Result := False;
          Break;
        end;
      except
        Result := False;
        Break;
      end;
  end;
end;

function VarCompare(const V1, V2: Variant): Integer;
var
  I: Integer;
begin
  if VarIsArray(V1) and VarIsArray(V2) then
  begin
    Result := 0;
    for I := 0 to VarArrayHighBound(V1, 1) do
    begin
      if V1[I] < V2[I] then Result := -1
      else
        if V1[I] = V2[I] then Continue
        else Result := 1;
      Break;
    end;
  end
  else
    if VarIsArray(V1) then Result := 1
    else
      if VarIsArray(V2) then Result := -1
      else
        if VarIsEmpty(V1) then
          if VarIsEmpty(V2) then Result := 0
          else Result := -1
        else
          if VarIsEmpty(V2) then Result := 1
          else
            if V1 < V2 then Result := -1
            else
              if V1 = V2 then Result := 0
              else Result := 1
end;

{ TdxMVRegIniFile }

type
  TCurIniFile = {$IFDEF DELPHI4}TMemIniFile{$ELSE}TIniFile{$ENDIF};

  TdxMVRegIniFile = class
  private
    FIniFile: TCurIniFile;
    FMode: TdxMasterViewRegIniFileMode;
    FRegIniFile: TRegIniFile;
  public
    constructor Create(AFileName: string; AMode: TdxMasterViewRegIniFileMode);
    destructor Destroy; override;
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint;
    function SectionExists(const Section: string): Boolean;
    function ValueExists(const Section, Ident: string): Boolean;
    procedure WriteBool(const Section, Ident: string; Value: Boolean);
    procedure WriteInteger(const Section, Ident: string; Value: Longint);
  end;

constructor TdxMVRegIniFile.Create(AFileName: string; AMode: TdxMasterViewRegIniFileMode);
begin
  inherited Create;
  if FMode = riRegistry then
  begin
    if AFileName[1] <> '\' then AFileName := '\' + AFileName;
    if AFileName[Length(AFileName)] = '\' then
      Delete(AFileName, Length(AFileName), 1);
  end;
  FMode := AMode;
  case FMode of
    riIniFile:
      FIniFile := TCurIniFile.Create(AFileName);
    riRegistry:
      FRegIniFile := TRegIniFile.Create(AFileName);
  end;
end;

destructor TdxMVRegIniFile.Destroy;
begin
  case FMode of
    riIniFile:
      begin
      {$IFDEF DELPHI4}
        FIniFile.UpdateFile;
      {$ENDIF}
        FIniFile.Free;
      end;
    riRegistry:
      FRegIniFile.Free;
  end;
  inherited;
end;

function TdxMVRegIniFile.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
begin
  Result := Default;
  case FMode of
    riIniFile:
      Result := FIniFile.ReadBool(Section, Ident, Default);
    riRegistry:
      Result := FRegIniFile.ReadBool(Section, Ident, Default);
  end;
end;

function TdxMVRegIniFile.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
begin
  Result := Default;
  case FMode of
    riIniFile:
      Result := FIniFile.ReadInteger(Section, Ident, Default);
    riRegistry:
      Result := FRegIniFile.ReadInteger(Section, Ident, Default);
  end;
end;

function TdxMVRegIniFile.SectionExists(const Section: string): Boolean;
var
  S: TStrings;
begin
  S := TStringList.Create;
  try
    case FMode of
      riIniFile:
        FIniFile.ReadSection(Section, S);
      riRegistry:
        FRegIniFile.ReadSection(Section, S);
    end;
  finally
    Result := S.Count <> 0;
    S.Free;
  end;
end;

function TdxMVRegIniFile.ValueExists(const Section, Ident: string): Boolean;
var
  S: TStrings;
begin
  S := TStringList.Create;
  try
    case FMode of
      riIniFile:
        FIniFile.ReadSection(Section, S);
      riRegistry:
        FRegIniFile.ReadSection(Section, S);
    end;
  finally
    Result := S.IndexOf(Ident) <> -1;
    S.Free;
  end;
end;

procedure TdxMVRegIniFile.WriteBool(const Section, Ident: string; Value: Boolean);
begin
  case FMode of
    riIniFile:
      FIniFile.WriteBool(Section, Ident, Value);
    riRegistry:
      FRegIniFile.WriteBool(Section, Ident, Value);
  end;
end;

procedure TdxMVRegIniFile.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  case FMode of
    riIniFile:
      FIniFile.WriteInteger(Section, Ident, Value);
    riRegistry:
      FRegIniFile.WriteInteger(Section, Ident, Value);
  end;
end;

{ TFlatComboBox }

type
  TFlatComboBox = class(TComboBox)
  private
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

constructor TFlatComboBox.Create(AOwner: TComponent);
begin
  inherited;
  Style := csDropDownList;
end;

procedure TFlatComboBox.WMPaint(var Message: TWMPaint);
const
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  Pushes: array[Boolean] of Integer = (0, DFCS_PUSHED);
var
  DC: HDC;
  R: TRect;
begin
  inherited;
  DC := GetDC(Handle);

  R := ClientRect;
  InflateRect(R, -1, -1);
  FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));

  InflateRect(R, -1, -1);
  with R do
  begin
    Left := Right - GetSystemMetrics(SM_CXVSCROLL);
    FillRect(DC, Rect(Left, Top, Left + 1, Bottom), COLOR_BTNFACE + 1);
    Inc(Left);
  end;
  DrawEdge(DC, R, Borders[DroppedDown], BF_RECT);

  InflateRect(R, -1, -1);
  with R do
    IntersectClipRect(DC, Left, Top, Right, Bottom);
  InflateRect(R, 2, 2);
  DrawFrameControl(DC, R, DFC_SCROLL,
    DFCS_SCROLLCOMBOBOX or DFCS_FLAT or Pushes[DroppedDown]);

  ReleaseDC(Handle, DC);
end;

procedure TFlatComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_CHILD or CBS_DROPDOWNLIST;
    ExStyle := 0;
  end;
end;

{ TChangePageButton }

type
  TChangePageButton = class(TSpeedButton)
  private
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
  protected
    procedure Paint; override;
  end;

procedure TChangePageButton.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  if not Down then
  begin
    FState := bsUp;
    Invalidate;
  end;  
end;

procedure TChangePageButton.Paint;
var
  DC: HDC;
  R: TRect;
  PrevFont: HFONT;
begin
  if FState = bsUp then
  begin
    DC := Canvas.Handle;
    R := ClientRect;
    DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    InflateRect(R, -1, -1);
    FillRect(DC, R, COLOR_BTNFACE + 1);
    SetBkMode(DC, Windows.TRANSPARENT);
    PrevFont := SelectObject(DC, Font.Handle);
    DrawText(DC, PChar(Caption), Length(Caption), R,
      DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    SelectObject(DC, PrevFont);
    SetBkMode(DC, OPAQUE);
  end
  else
    inherited;
end;

{ TColumnsListBox }

type
  TColumnsListBox = class(TListBox)
  private
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    Control: TdxMasterView;
    constructor Create(AOwner: TComponent); override;
  end;

constructor TColumnsListBox.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsNone;
  Color := clBtnFace;
  Sorted := True;
  Style := lbOwnerDrawFixed;
end;

procedure TColumnsListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TColumnsListBox.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  inherited;
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
  ReleaseDC(Handle, DC);
end;

procedure TColumnsListBox.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  R: TRect;
  PrevTextColor: COLORREF;
  PrevBkMode: Integer;
  PrevFont: HFONT;
begin
  if Items.Count = 0 then
  begin
    if Message.DC = 0 then DC := BeginPaint(Handle, PS)
    else DC := Message.DC;
    R := ClientRect;
    S := LoadStr(dxsMVCBNoFields);
    PrevTextColor := SetTextColor(DC, GetSysColor(COLOR_BTNSHADOW));
    PrevBkMode := SetBkMode(DC, TRANSPARENT);
    PrevFont := SelectObject(DC, Font.Handle);
    Windows.DrawText(DC, PChar(S), Length(S), R, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    SelectObject(DC, PrevFont);
    SetBkMode(DC, PrevBkMode);
    SetTextColor(DC, PrevTextColor);
    if Message.DC = 0 then EndPaint(Handle, PS);
  end
  else
    inherited;
end;

procedure TColumnsListBox.CNDrawItem(var Message: TWMDrawItem);
var
  R: TRect;
  S: string;
  PrevTextColor: COLORREF;
  PrevBkMode: Integer;
begin
  with Message.DrawItemStruct^ do
    if Integer(itemID) >= 0 then
    begin
      R := rcItem;
      DrawEdge(hDC, R, BDR_RAISEDINNER, BF_RECT);
      InflateRect(R, -1, -1);
      FillRect(hDC, R, COLOR_BTNFACE + 1);
      InflateRect(R, -2, 0);
      S := TdxMasterViewColumn(itemData).Caption;
      PrevTextColor := SetTextColor(hDC, GetSysColor(COLOR_BTNTEXT));
      PrevBkMode := SetBkMode(hDC, TRANSPARENT);
      Windows.DrawText(hDC, PChar(S), Length(S), R,
        DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
      SetBkMode(hDC, PrevBkMode);
      SetTextColor(hDC, PrevTextColor);
      if itemState and ODS_SELECTED <> 0 then
        with rcItem do
          BitBlt(hDC, Left, Top, Right - Left, Bottom - Top, 0, 0, 0, DSTINVERT);
    end;
end;

procedure TColumnsListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button = mbLeft) and (ItemAtPos(Point(X, Y), True) <> -1) and
    (DragDetect(Handle) = ddDrag) then
    Control.DoColumnMoving(nil, TdxMasterViewColumn(Items.Objects[ItemIndex]),
      Point(-1, -1), dsCustomizingForm);
end;

{ TOptionsListBox }

type
  TOptionsListBox = class(TCheckListBox)
  private
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
  protected
    procedure ClickCheck; override;
  public
    Level: TdxMasterViewLevel;
    constructor Create(AOwner: TComponent); override;
  end;

constructor TOptionsListBox.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsNone;
  Color := clBtnFace;
end;

procedure TOptionsListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  InflateRect(Message.CalcSize_Params^.rgrc[0], -2, -2);
end;

procedure TOptionsListBox.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  inherited;
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  DrawEdge(DC, R, EDGE_ETCHED, BF_RECT);
  ReleaseDC(Handle, DC);
end;

procedure TOptionsListBox.ClickCheck;
var
  S: string;
  I: Integer;
                     
  procedure XorOptionsView(Option: TdxMasterViewLevelOptionView);
  begin
    with Level do
      if Option in OptionsView then
        OptionsView := OptionsView - [Option]
      else
        OptionsView := OptionsView + [Option];
  end;

  procedure XorOptionsHeader(Option: TdxMasterViewLevelOptionHeader);
  begin
    with Level do
      if Option in OptionsHeader then
        OptionsHeader := OptionsHeader - [Option]
      else
        OptionsHeader := OptionsHeader + [Option];
  end;

begin
  inherited;
  S := Items[ItemIndex];
  for I := dxsMVCBOptionCaption to dxsMVCBOptionViewMode do
    if S = LoadStr(I) then Break;
  with Level do
    case I - dxsMVBase of
      08: XorOptionsView(lovCaption);
      09: XorOptionsView(lovFooter);
      10: XorOptionsView(lovGrid);
      11: XorOptionsView(lovGridWithPreview);
      12: XorOptionsView(lovGroupByBox);
      13: XorOptionsView(lovHeader);
      14: XorOptionsHeader(lohForFirstNode);
      15: XorOptionsHeader(lohForFirstVisibleNode);
      16: XorOptionsHeader(lohAfterExpandedNode);
      17: XorOptionsView(lovOccupyRestSpace);
      18: XorOptionsView(lovPreview);
      19:
        if ViewMode = vmHorizontal then
          ViewMode := vmVertical
        else
          ViewMode := vmHorizontal;
    end;
end;

{ TdxMVCustomizationForm }

type
  TdxMVCustomizationForm = class(TWinControl)
  private
    FActiveLevel: TdxMasterViewLevel;
    ListBoxTop, ListBoxBottom: Integer;
    procedure SetActiveLevel(Value: TdxMasterViewLevel);

    procedure cmbLevelsClick(Sender: TObject);
    procedure btnChangePageClick(Sender: TObject);

    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMNCCreate(var Message: TWMNCCreate); message WM_NCCREATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    cmbLevels: TComboBox;
    pnlChangePage: TPanel;
    btnColumns, btnOptions: TChangePageButton;
    lbColumns: TColumnsListBox;
    clbOptions: TOptionsListBox;
    Control: TdxMasterView;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function MouseInBounds(P: TPoint): Boolean;
    procedure RefreshColumnsListBox(FocusedColumn: TdxMasterViewColumn);
    procedure RefreshOptions;

    property ActiveLevel: TdxMasterViewLevel read FActiveLevel write SetActiveLevel;
  end;

var
  WndProcHandlers: TList;
  WndProcHookHandle: HHOOK;

function dxMVCustFormWndProcHook(Code: Integer; wParam: WParam; lParam: LParam): LRESULT; stdcall;
const
  Flags: array[Boolean] of Integer = (SWP_HIDEWINDOW, SWP_SHOWWINDOW);
var
  I: Integer;
  Wnd, ParentWnd: HWND;

  function GetParentFormHandle(Wnd: HWND): HWND;
  begin
    Result := Wnd;
    while not (FindControl(Result) is TCustomForm) and (GetParent(Result) <> 0) do
      Result := GetParent(Result);
  end;

begin
  with PCWPStruct(lParam)^ do
    if message = WM_ACTIVATE then
      for I := 0 to WndProcHandlers.Count - 1 do
      begin
        Wnd := TWinControl(WndProcHandlers[I]).Handle;
        ParentWnd := GetParentFormHandle(Wnd);
        if (hwnd = ParentWnd) and (Windows.HWND(lParam) <> Wnd) or
          (hwnd = Wnd) and (Windows.HWND(lParam) <> ParentWnd) then
          SetWindowPos(Wnd, 0, 0, 0, 0, 0,
            SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or
            Flags[LOWORD(wParam) <> WA_INACTIVE]);
      end;
  Result := CallNextHookEx(WndProcHookHandle, Code, wParam, lParam);
end;

procedure RegisterWndProcHandler(CustForm: TWinControl);
begin
  WndProcHandlers.Add(CustForm);
  if WndProcHookHandle = 0 then
    WndProcHookHandle :=
      SetWindowsHookEx(WH_CALLWNDPROC, dxMVCustFormWndProcHook, 0, GetCurrentThreadId);
end;

procedure UnregisterWndProcHandler(CustForm: TWinControl);
begin
  WndProcHandlers.Remove(CustForm);
  if (WndProcHandlers.Count = 0) and (WndProcHookHandle <> 0) then
  begin
    UnhookWindowsHookEx(WndProcHookHandle);
    WndProcHookHandle := 0;
  end;
end;

constructor TdxMVCustomizationForm.Create(AOwner: TComponent);
var
  Size: TPoint;
  D, W, T, I: Integer;
  Level: TdxMasterViewLevel;
  R: TRect;

  function GetSymbolSize: TPoint;
  var
    DC: HDC;
    PrevFont: HFONT;
  begin
    DC := GetDC(0);
    PrevFont := SelectObject(DC, Font.Handle);
    GetTextExtentPoint{32}(DC, '0', 1, TSize(Result));
    SelectObject(DC, PrevFont);
    ReleaseDC(0, DC);
  end;

begin
  Control := TdxMasterView(AOwner);
  inherited;
  Visible := False;
  Caption := LoadStr(dxsMVCBCaption);
  Font := Control.Font;

  Size := GetSymbolSize;
  D := Size.Y div 6;
  W := 32 * Size.X;
  T := D;

  cmbLevels := TFlatComboBox.Create(Self);
  with cmbLevels do
  begin
    Parent := Self;
    for I := 0 to Control.AbsoluteLevelCount - 1 do
    begin
      Level := Control.AbsoluteLevels[I];
      if Level.OptionsCustomizeBox <> [] then
        Items.AddObject(Level.Caption, Level);
    end;
    DropDownCount := Items.Count;
    if Items.Count > 1 then
    begin
      SetBounds(D, T, W, 10);
      OnClick := cmbLevelsClick;
      ShowWindow(Handle, SW_SHOW);
      Inc(T, Height + 2 * D);
    end;  
  end;

  pnlChangePage := TPanel.Create(Self);
  with pnlChangePage do
  begin
    Parent := Self;
    BevelOuter := bvNone;
    SetBounds(D, T, W, 12 * D);
    btnColumns := TChangePageButton.Create(Self);
    with btnColumns do
    begin
      Caption := LoadStr(dxsMVCBColumns);
      Flat := True;
      GroupIndex := 1;
      Down := True;
      Parent := pnlChangePage;
      SetBounds(0, 0, (W - 2 * D) div 2, Parent.Height);
      OnClick := btnChangePageClick;
    end;
    btnOptions := TChangePageButton.Create(Self);
    with btnOptions do
    begin
      Caption := LoadStr(dxsMVCBOptions);
      Flat := True;
      GroupIndex := 1;
      Parent := pnlChangePage;
      SetBounds(btnColumns.Width + 2 * D, 0,
        W - btnColumns.Width - 2 * D, Parent.Height);
      OnClick := btnChangePageClick;
    end;
  end;
  Inc(T, pnlChangePage.Height + 2 * D);

  ListBoxTop := T;
  lbColumns := TColumnsListBox.Create(Self);
  with lbColumns do
  begin
    Control := Self.Control;
    Parent := Self;
    ItemHeight := Size.Y + 2 + 2 * 2;
    SetBounds(D, T, W, 2 + Control.CustomizationFormRowCount * ItemHeight);
    ListBoxBottom := BoundsRect.Bottom;
  end;

  clbOptions := TOptionsListBox.Create(Self);
  with clbOptions do
  begin
    Parent := Self;
    BoundsRect := lbColumns.BoundsRect;
  end;

  Width := 100;
  Height := 100;
  with lbColumns.BoundsRect do
  begin
    ClientWidth := Right + D;
    ClientHeight := Bottom + D;
  end;

  if cmbLevels.Items.Count <> 0 then
    ActiveLevel := TdxMasterViewLevel(cmbLevels.Items.Objects[0]);

  if Control.CustomizationFormPos.X = -1 then
  begin
    GetWindowRect(Control.Handle, R);
    Left := R.Right - Width;
    Top := R.Bottom - Height;
  end
  else
    with Control.CustomizationFormPos do
    begin
      Left := X;
      Top := Y;
    end;

  Visible := True;
  ShowWindow(Handle, SW_SHOW);

  RegisterWndProcHandler(Self);
end;

destructor TdxMVCustomizationForm.Destroy;
begin
  UnregisterWndProcHandler(Self);

  Destroying;
  Control.Customizing := False;
  inherited;
end;

procedure TdxMVCustomizationForm.SetActiveLevel(Value: TdxMasterViewLevel);
const
  Visibilities: array[Boolean] of Integer = (SW_HIDE, SW_SHOW);
var
  ShowColumns, ShowOptions: Boolean;
  T: Integer;
begin
  if FActiveLevel <> Value then
  begin
    FActiveLevel := Value;
    with cmbLevels do
      ItemIndex := Items.IndexOfObject(Value);

    ShowColumns := loxColumns in FActiveLevel.OptionsCustomizeBox;
    ShowOptions := FActiveLevel.OptionsCustomizeBox - [loxColumns] <> [];
    ShowWindow(pnlChangePage.Handle, Visibilities[ShowColumns and ShowOptions]);
    if ShowColumns and ShowOptions then
      T := ListBoxTop
    else
      T := pnlChangePage.BoundsRect.Top;
    if ShowColumns then
    begin
      with lbColumns do
        SetBounds(Left, T, Width, ListBoxBottom - T);
      RefreshColumnsListBox(nil);
    end;
    if ShowOptions then
    begin
      with clbOptions do
        SetBounds(Left, T, Width, ListBoxBottom - T);
      RefreshOptions;
    end;

    ShowColumns := ShowColumns and (btnColumns.Down or not ShowOptions);
    ShowOptions := ShowOptions and (btnOptions.Down or not ShowColumns);
    ShowWindow(lbColumns.Handle, Visibilities[ShowColumns]);
    ShowWindow(clbOptions.Handle, Visibilities[ShowOptions]);
  end;
end;

procedure TdxMVCustomizationForm.cmbLevelsClick(Sender: TObject);
begin
  with cmbLevels do
    ActiveLevel := TdxMasterViewLevel(Items.Objects[ItemIndex]);
end;

procedure TdxMVCustomizationForm.btnChangePageClick(Sender: TObject);
begin
  if btnColumns.Down then
  begin
    ShowWindow(lbColumns.Handle, SW_SHOW);
    ShowWindow(clbOptions.Handle, SW_HIDE);
  end
  else
  begin
    ShowWindow(clbOptions.Handle, SW_SHOW);
    ShowWindow(lbColumns.Handle, SW_HIDE);
  end;
end;

procedure TdxMVCustomizationForm.WMActivate(var Message: TWMActivate);
begin
  inherited;
  if (Message.Active <> WA_INACTIVE) and (GetFocus = Handle) then
    Windows.SetFocus(lbColumns.Handle);
end;

procedure TdxMVCustomizationForm.WMClose(var Message: TWMClose);
begin
  inherited;
  Free;
end;

procedure TdxMVCustomizationForm.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  FillRect(Message.DC, ClientRect, COLOR_BTNFACE + 1);
  Message.Result := 1;
end;

procedure TdxMVCustomizationForm.WMMove(var Message: TWMMove);
var
  R: TRect;
begin
  inherited;
  if IsWindowVisible(Handle) then
  begin
    GetWindowRect(Handle, R);
    Control.CustomizationFormPos := R.TopLeft;
  end;
end;

procedure TdxMVCustomizationForm.WMNCCreate(var Message: TWMNCCreate);
var
  SysMenu: HMENU;
begin
  inherited;
  SysMenu := GetSystemMenu(Handle, False);
  DeleteMenu(SysMenu, SC_MAXIMIZE, MF_BYCOMMAND);
  DeleteMenu(SysMenu, SC_MINIMIZE, MF_BYCOMMAND);
  DeleteMenu(SysMenu, SC_SIZE, MF_BYCOMMAND);
  DeleteMenu(SysMenu, SC_RESTORE, MF_BYCOMMAND);
end;

procedure TdxMVCustomizationForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP or WS_CLIPCHILDREN or WS_CLIPSIBLINGS or WS_CAPTION or WS_SYSMENU;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_DLGMODALFRAME or WS_EX_CONTROLPARENT;
    WindowClass.Style := CS_SAVEBITS;
    WndParent := Control.Handle;
  end;
end;

function TdxMVCustomizationForm.MouseInBounds(P: TPoint): Boolean;
begin
  Windows.ClientToScreen(Control.Handle, P);
  Result := PtInRect(BoundsRect, P);
end;

procedure TdxMVCustomizationForm.RefreshColumnsListBox(FocusedColumn: TdxMasterViewColumn);
var
  PrevFocusedColumn: TObject;
  I: Integer;
  AColumn: TdxMasterViewColumn;
begin
  with lbColumns, Items do
  begin
    if ItemIndex = -1 then
      PrevFocusedColumn := nil
    else
      PrevFocusedColumn := Items.Objects[ItemIndex];
    BeginUpdate;
    try
      Clear;
      for I := 0 to ActiveLevel.ColumnCount - 1 do
      begin
        AColumn := ActiveLevel.Columns[I];
        if not AColumn.Hidden and not AColumn.Visible then
          AddObject(AColumn.Caption, AColumn);
      end;
      if FocusedColumn <> nil then
        ItemIndex := IndexOfObject(FocusedColumn)
      else
        if PrevFocusedColumn <> nil then
          ItemIndex := IndexOfObject(PrevFocusedColumn);
    finally
      EndUpdate;
    end;  
  end;
end;

procedure TdxMVCustomizationForm.RefreshOptions;
begin
  with ActiveLevel, clbOptions, Items do
  begin
    Level := ActiveLevel;
    BeginUpdate;
    try
      Clear;
      if loxViewMode in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionViewMode))] := Horizontal;
      if loxCaption in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionCaption))] := ShowCaption;
      if loxGroupByBox in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionGroupByBox))] := ShowGroupByBox;
      if loxHeader in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionHeader))] := ShowHeader;
      if loxHeaderOptions in OptionsCustomizeBox then
      begin
        Checked[Add(LoadStr(dxsMVCBOptionHeaderForFirstNode))] :=
          lohForFirstNode in OptionsHeader;
        Checked[Add(LoadStr(dxsMVCBOptionHeaderForFirstVisibleNode))] :=
          lohForFirstVisibleNode in OptionsHeader;
        Checked[Add(LoadStr(dxsMVCBOptionHeaderAfterExpandedNode))] :=
          lohAfterExpandedNode in OptionsHeader;
      end;
      if loxGrid in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionGrid))] := ShowGrid;
      if loxGridWithPreview in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionGridWithPreview))] := ShowGridWithPreview;
      if loxPreview in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionPreview))] := ShowPreview;
      if loxFooter in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionFooter))] := ShowFooter;
      if loxOccupyRestSpace in OptionsCustomizeBox then
        Checked[Add(LoadStr(dxsMVCBOptionOccupyRestSpace))] := OccupyRestSpace;
    finally
      EndUpdate;
    end;
  end;
end;

{ TdxMasterViewDataLink }

constructor TdxMasterViewDataLink.Create(ALevel: TdxMasterViewLevel);
begin
  inherited Create;
{$IFDEF DELPHI5}
  VisualControl := True;
{$ENDIF}
  FLevel := ALevel;
end;

function TdxMasterViewDataLink.GetFrozen: Boolean;
begin
  Result := FFreezeCount > 0;
end;

procedure TdxMasterViewDataLink.ActiveChanged;
begin
  FLevel.ActiveChanged;
end;

procedure TdxMasterViewDataLink.DataSetChanged;
begin
  if not Frozen then
    FLevel.DataChanged
  else
    Unfreeze;
end;

procedure TdxMasterViewDataLink.DataSetScrolled(Distance: Integer);
begin
  if not Frozen then
    FLevel.SyncPos
  else
    Unfreeze;
end;

procedure TdxMasterViewDataLink.EditingChanged;
begin
  FLevel.EditingChanged;
end;

procedure TdxMasterViewDataLink.LayoutChanged;
begin
  FLevel.LayoutChanged;
  inherited;
end;

procedure TdxMasterViewDataLink.RecordChanged(Field: TField);
begin
  FLevel.RecordChanged(Field);
end;

function TdxMasterViewDataLink.Freeze: Integer;
begin
  Inc(FFreezeCount);
  Result := FFreezeCount;
end;

procedure TdxMasterViewDataLink.Unfreeze;
begin
  if FFreezeCount > 0 then Dec(FFreezeCount);
end;

{ TdxMasterViewStyle }

constructor TdxMasterViewStyle.Create(AOwner: TComponent);
begin
  inherited;
  FAnotherColor := clNone;
  FColor := clNone;
  FConsumers := TList.Create;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
end;

destructor TdxMasterViewStyle.Destroy;
var
  I: Integer;
begin
  if FControl <> nil then FControl.RemoveStyle(Self);
  if FBrush <> 0 then DeleteObject(FBrush);
  if FAnotherBrush <> 0 then DeleteObject(FAnotherBrush);
  FFont.Free;
  for I := ConsumerCount - 1 downto 0 do
  begin
    Dispose(ConsumerRecs[I]);
    FConsumers.Delete(I);
  end;
  FConsumers.Free;
  FConsumers := nil;
  inherited;
end;

function TdxMasterViewStyle.GetConsumerRec(Index: Integer): PdxMasterViewStyleConsumerRec;
begin
  Result := PdxMasterViewStyleConsumerRec(FConsumers[Index]);
end;

function TdxMasterViewStyle.GetConsumerCount: Integer;
begin
  Result := FConsumers.Count;
end;

function TdxMasterViewStyle.GetIndex: Integer;
begin
  Result := FControl.FStyles.IndexOf(Self);
end;

procedure TdxMasterViewStyle.SetAnotherColor(Value: TColor);
begin
  if FAnotherColor <> Value then
  begin
    FAnotherColor := Value;
    if FAnotherBrush <> 0 then DeleteObject(FAnotherBrush);
    if FAnotherColor = clNone then
    begin
      FAnotherBrush := 0;
      AssignedValues := AssignedValues - [svAnotherColor];
    end
    else
    begin
      FAnotherBrush := CreateSolidBrush(ColorToRGB(FAnotherColor));
      if svAnotherColor in AssignedValues then
        Changed([svAnotherColor])
      else
        AssignedValues := AssignedValues + [svAnotherColor];
    end;
  end;
end;

procedure TdxMasterViewStyle.SetAssignedValues(Value: TdxMasterViewStyleValues);
var
  PrevValue: TdxMasterViewStyleValues;
begin
  if FAnotherColor = clNone then Exclude(Value, svAnotherColor);
  if FColor = clNone then Exclude(Value, svColor);
  if FAssignedValues <> Value then
  begin
    PrevValue := FAssignedValues;
    FAssignedValues := Value;
    Byte(PrevValue) := Byte(PrevValue) xor Byte(Value);
    Changed(PrevValue);
  end;
end;

procedure TdxMasterViewStyle.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if FBrush <> 0 then DeleteObject(FBrush);
    if FColor = clNone then
    begin
      FBrush := 0;
      AssignedValues := AssignedValues - [svColor];
    end
    else
    begin
      FBrush := CreateSolidBrush(ColorToRGB(FColor));
      if svColor in AssignedValues then
        Changed([svColor])
      else
        AssignedValues := AssignedValues + [svColor];
    end;    
  end;
end;

procedure TdxMasterViewStyle.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TdxMasterViewStyle.SetIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value >= FControl.StyleCount then Value := FControl.StyleCount - 1;
  if Index <> Value then
    FControl.FStyles.Move(Index, Value);
end;

function TdxMasterViewStyle.IsAnotherColorStored: Boolean;
begin
  Result := svAnotherColor in FAssignedValues;
end;

function TdxMasterViewStyle.IsColorStored: Boolean;
begin
  Result := svColor in FAssignedValues;
end;

function TdxMasterViewStyle.IsFontStored: Boolean;
begin
  Result := svFont in FAssignedValues;
end;

procedure TdxMasterViewStyle.FontChanged(Sender: TObject);
begin
  if svFont in AssignedValues then
    Changed([svFont])
  else
    AssignedValues := AssignedValues + [svFont];
end;

procedure TdxMasterViewStyle.SetName(const NewName: TComponentName);
begin
  inherited;
  if dxMVDesigner <> nil then dxMVDesigner.Changed(FControl, [rcStyles]);
end;

procedure TdxMasterViewStyle.SetParentComponent(AParent: TComponent);
begin
  if AParent is TdxMasterView then
    TdxMasterView(AParent).AddStyle(Self);
end;

procedure TdxMasterViewStyle.AddConsumeType(AConsumer: TComponent;
  AConsumeType: TdxMasterViewStyleConsumeType);
var
  I: Integer;
  ConsumerRec: PdxMasterViewStyleConsumerRec;
begin
  I := IndexOfConsumer(AConsumer);
  if I = -1 then
  begin
    New(ConsumerRec);
    with ConsumerRec^ do
    begin
      Consumer := AConsumer;
      ConsumeTypes := [AConsumeType];
    end;
    FConsumers.Add(ConsumerRec);
    AConsumer.FreeNotification(Self);
  end
  else
    Include(ConsumerRecs[I]^.ConsumeTypes, AConsumeType);
end;

procedure TdxMasterViewStyle.Changed(Values: TdxMasterViewStyleValues);
var
  I: Integer;
  ConsumerRec: PdxMasterViewStyleConsumerRec;
begin
  for I := 0 to ConsumerCount - 1 do
  begin
    ConsumerRec := ConsumerRecs[I];
    with ConsumerRec^ do
      if Consumer is TdxMasterViewColumn then
        with TdxMasterViewColumn(Consumer) do
        begin
          if sctHeader in ConsumeTypes then HeaderStyleChanged(Values);
          if sctContent in ConsumeTypes then ContentStyleChanged(Values);
          if sctFooter in ConsumeTypes then FooterStyleChanged(Values);
        end
      else
        if Consumer is TdxMasterViewLevel then
          with TdxMasterViewLevel(Consumer) do
          begin
            if sctHeader in ConsumeTypes then HeaderStyleChanged(Values);
            if sctContent in ConsumeTypes then ContentStyleChanged(Values);
            if sctFooter in ConsumeTypes then FooterStyleChanged(Values);
            if sctPreview in ConsumeTypes then PreviewStyleChanged(Values);
            if sctCaption in ConsumeTypes then CaptionStyleChanged(Values);
            if sctGroup in ConsumeTypes then GroupStyleChanged(Values);
            if sctGroupByBox in ConsumeTypes then GroupByBoxStyleChanged(Values);
          end
        else
          if Consumer is TdxMasterView then
            with TdxMasterView(Consumer) do
            begin
              if sctHighlight in ConsumeTypes then HighlightStyleChanged(Values);
              if sctInactive in ConsumeTypes then InactiveStyleChanged(Values);
            end;
  end;
end;

function TdxMasterViewStyle.IndexOfConsumer(Consumer: TComponent): Integer;
begin
  if FConsumers <> nil then
    for Result := 0 to ConsumerCount - 1 do
      if ConsumerRecs[Result]^.Consumer = Consumer then Exit;
  Result := -1;
end;

procedure TdxMasterViewStyle.RemoveConsumeType(AConsumer: TComponent;
  AConsumeType: TdxMasterViewStyleConsumeType);
var
  I: Integer;
begin
  I := IndexOfConsumer(AConsumer);
  if I = -1 then Exit;
  with ConsumerRecs[I]^ do
  begin
    Exclude(ConsumeTypes, AConsumeType);
    if ConsumeTypes = [] then
    begin
      Dispose(ConsumerRecs[I]);
      FConsumers.Delete(I);
    end;
  end;
end;

procedure TdxMasterViewStyle.SysColorChanged;

  procedure RecreateBrush(var ABrush: HBRUSH; AColor: TColor);
  begin
    DeleteObject(ABrush);
    ABrush := CreateSolidBrush(ColorToRGB(AColor));
  end;

begin
  if svColor in AssignedValues then
    RecreateBrush(FBrush, FColor);
  if svAnotherColor in AssignedValues then
    RecreateBrush(FAnotherBrush, FAnotherColor);
end;

procedure TdxMasterViewStyle.Assign(Source: TPersistent);
begin
  if Source is TdxMasterViewStyle then
  begin
    AnotherColor := TdxMasterViewStyle(Source).AnotherColor;
    Color := TdxMasterViewStyle(Source).Color;
    Font := TdxMasterViewStyle(Source).Font;
    AssignedValues := TdxMasterViewStyle(Source).AssignedValues;
  end
  else
    inherited;
end;

function TdxMasterViewStyle.GetParentComponent: TComponent;
begin
  Result := FControl;
end;

function TdxMasterViewStyle.HasParent: Boolean;
begin
  Result := FControl <> nil;
end;

{ TdxMasterViewColumn }

constructor TdxMasterViewColumn.Create(AOwner: TComponent);
begin
  inherited;
  FColIndex := -1;
  FHeaderGlyph := TBitmap.Create;
  FHeaderGlyph.OnChange := HeaderGlyphChanged;
  FLeftColumns := TList.Create;
  FLoadedGroupIndex := -1;
  FLoadedSortIndex := -1;
  FLogicalOffset := -1;
  FMinRowCount := 1;
  FMinWidth := dxMVColumnDefaultMinWidth;
  FMaxRowCount := dxMVColumnDefaultMaxRowCount;
  FMaxWidth := dxMVColumnDefaultMaxWidth;
  FOptions :=
    [coGrouping , coHorSizing, coMoving, coSorting, coVerSizing, coShowCaption];
  FRightColumns := TList.Create;
  FRowIndex := -1;
  FRowCount := 1;
  FVisible := True;
end;

destructor TdxMasterViewColumn.Destroy;
begin
  Destroying;
  HeaderStyle := nil;
  ContentStyle := nil;
  FooterStyle := nil;
  FLevel.RemoveColumn(Self);
  FRightColumns.Free;
  FLeftColumns.Free;
  FHeaderGlyph.Free;
  inherited;
end;

function TdxMasterViewColumn.GetAlignment: TAlignment;
begin
  if cvAlignment in FAssignedValues then
    Result := FAlignment
  else
    Result := DefaultAlignment;
end;

function TdxMasterViewColumn.GetCaption: string;
begin
  if cvCaption in FAssignedValues then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TdxMasterViewColumn.GetColIndex: Integer;
begin
  if FVisible and (FLevel.ViewMode = vmHorizontal) then
    Result := FLevel.Layout.IndexOf(Self, FRowIndex)
  else
    Result := FColIndex;
end;

function TdxMasterViewColumn.GetContentAnotherBrush: HBRUSH;
begin
  if (ContentStyle <> nil) and (svAnotherColor in ContentStyle.AssignedValues) then
    Result := ContentStyle.AnotherBrush
  else
    Result := FLevel.ContentAnotherBrush;
end;

function TdxMasterViewColumn.GetContentAnotherColor: TColor;
begin
  if (ContentStyle <> nil) and (svAnotherColor in ContentStyle.AssignedValues) then
    Result := ContentStyle.AnotherColor
  else
    Result := FLevel.ContentAnotherColor;
end;

function TdxMasterViewColumn.GetContentBrush: HBRUSH;
begin
  if (ContentStyle <> nil) and (svColor in ContentStyle.AssignedValues) then
    Result := ContentStyle.Brush
  else
    Result := FLevel.ContentBrush;
end;

function TdxMasterViewColumn.GetContentColor: TColor;
begin
  if (ContentStyle <> nil) and (svColor in ContentStyle.AssignedValues) then
    Result := ContentStyle.Color
  else
    Result := FLevel.ContentColor;
end;

function TdxMasterViewColumn.GetContentFont: TFont;
begin
  if (ContentStyle <> nil) and (svFont in ContentStyle.AssignedValues) then
    Result := ContentStyle.Font
  else
    Result := FLevel.ContentFont;
end;

function TdxMasterViewColumn.GetControl: TdxMasterView;
begin
  Result := FLevel.Control;
end;

function TdxMasterViewColumn.GetFooterAlignment: TAlignment;
begin
  if cvFooterAlignment in FAssignedValues then
    Result := FFooterAlignment
  else
    Result := DefaultAlignment;
end;

function TdxMasterViewColumn.GetFooterBrush: HBRUSH;
begin
  if (FooterStyle <> nil) and (svColor in FooterStyle.AssignedValues) then
    Result := FooterStyle.Brush
  else
    Result := FLevel.FooterBrush;
end;

function TdxMasterViewColumn.GetFooterColor: TColor;
begin
  if (FooterStyle <> nil) and (svColor in FooterStyle.AssignedValues) then
    Result := FooterStyle.Color
  else
    Result := FLevel.FooterColor;
end;

function TdxMasterViewColumn.GetFooterFont: TFont;
begin
  if (FooterStyle <> nil) and (svFont in FooterStyle.AssignedValues) then
    Result := FooterStyle.Font
  else
    Result := FLevel.FooterFont;
end;

function TdxMasterViewColumn.GetGroupIndex: Integer;
begin
  Result := FLevel.FGroupColumns.IndexOf(Self);
end;

function TdxMasterViewColumn.GetHeaderAlignment: TAlignment;
begin
  if cvHeaderAlignment in FAssignedValues then Result := FHeaderAlignment
  else Result := DefaultHeaderAlignment;
end;

function TdxMasterViewColumn.GetHeaderBrush: HBRUSH;
begin
  if (HeaderStyle <> nil) and (svColor in HeaderStyle.AssignedValues) then
    Result := HeaderStyle.Brush
  else
    Result := FLevel.HeaderBrush;
end;

function TdxMasterViewColumn.GetHeaderColor: TColor;
begin
  if (HeaderStyle <> nil) and (svColor in HeaderStyle.AssignedValues) then
    Result := HeaderStyle.Color
  else
    Result := FLevel.HeaderColor;
end;

function TdxMasterViewColumn.GetHeaderFont: TFont;
begin
  if (HeaderStyle <> nil) and (svFont in HeaderStyle.AssignedValues) then
    Result := HeaderStyle.Font
  else
    Result := FLevel.HeaderFont;
end;

function TdxMasterViewColumn.GetHidden: Boolean;
begin
  Result := coHidden in FOptions;
end;

function TdxMasterViewColumn.GetIndex: Integer;
begin
  Result := FLevel.FColumns.IndexOf(Self);
end;

function TdxMasterViewColumn.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxMasterViewColumn.GetIsLoading: Boolean;
begin
  Result := (csLoading in ComponentState) or FLevel.IsLoading;
end;

function TdxMasterViewColumn.GetLastInRow: Boolean;
begin
  Result := ColIndex = FLevel.Layout[RowIndex].Count - 1;
end;

function TdxMasterViewColumn.GetLogicalOffset: Integer;
var
  List: TList;
  I, AOffset: Integer;
begin
  if FLogicalOffset = -1 then
  begin
    Result := 0;
    if IsLoading {FLevel} then Exit;
    if FLevel.Horizontal then
    begin
      if FRowIndex = -1 then Exit;
      List := TList.Create;
      try
        if FLevel.Layout.HasLeftNeighbours(Self, List, False) then
          for I := 0 to List.Count - 1 do
          begin
            with TdxMasterViewColumn(List[I]) do
              AOffset := LogicalOffset + VisibleWidth;
            if AOffset > Result then Result := AOffset;
          end;
      finally
        List.Free;
      end;
    end
    else
      with FLevel, Layout do
      begin
        if FColIndex = -1 then Exit;
        if HasExpandButton then Result := LevelIndent;
        for I := 0 to ColIndex - 1 do
          Inc(Result, HeaderWidths[I] + ContentWidths[I]);
      end;
  end
  else
    Result := FLogicalOffset;
end;
{
function TdxMasterViewColumn.GetMaxLogicalOffset: Integer;
var
  List: TList;
  I, AOffset: Integer;
begin
  Result := 0;
  if FRowIndex = -1 then Exit;
  List := TList.Create;
  try
    if FLevel.Layout.HasLeftNeighbours(Self, List, True) then
      for I := 0 to List.Count - 1 do
      begin
        with TdxMasterViewColumn(List[I]) do
          AOffset := MaxLogicalOffset + VisibleMaxWidth;
        if AOffset > Result then Result := AOffset;
      end;
  finally
    List.Free;
  end;
end;
}
function TdxMasterViewColumn.GetMinLogicalOffset: Integer;
var
  List: TList;
  I, AOffset: Integer;
begin
  Result := 0;
  if FRowIndex = -1 then Exit;
  List := TList.Create;
  try
    if FLevel.Layout.HasLeftNeighbours(Self, List, False) then
      for I := 0 to List.Count - 1 do
      begin
        with TdxMasterViewColumn(List[I]) do
          AOffset := MinLogicalOffset + VisibleMinWidth;
        if AOffset > Result then Result := AOffset;
      end;
  finally
    List.Free;
  end;
end;

function TdxMasterViewColumn.GetNonScaledLogicalOffset: Integer;
var
  List: TList;
  I, AOffset: Integer;
begin
  Result := 0;
  if FLevel.Horizontal then
  begin
    if FRowIndex = -1 then Exit;
    List := TList.Create;
    try
      if FLevel.Layout.HasLeftNeighbours(Self, List, False) then
        for I := 0 to List.Count - 1 do
        begin
          with TdxMasterViewColumn(List[I]) do
            AOffset := NonScaledLogicalOffset + NonScaledWidth;
          if AOffset > Result then Result := AOffset;
        end;
    finally
      List.Free;
    end;
  end
  else
    with FLevel, Layout do
    begin
      if FColIndex = -1 then Exit;
      if HasExpandButton then Result := LevelIndent;
      for I := 0 to ColIndex - 1 do
        Inc(Result, HeaderWidths[I] + ContentNonScaledWidths[I]);
    end;
end;
{
function TdxMasterViewColumn.GetNonScaledOffset: Integer;
begin
  Result := FLevel.Indent - Control.LeftPos + NonScaledLogicalOffset;
end;
}
function TdxMasterViewColumn.GetNonScaledWidth: Integer;
begin
  Result := Width + AddInWidth;
end;

function TdxMasterViewColumn.GetOffset: Integer;
begin
  Result := FLevel.Indent - Control.LeftPos + LogicalOffset;
end;

function TdxMasterViewColumn.GetRowIndex: Integer;
begin
  if (FLevel.ViewMode = vmVertical) and FVisible then
    Result := FLevel.Layout.IndexOf(Self, FColIndex)  //!!!
  else
    Result := FRowIndex;
end;

function TdxMasterViewColumn.GetSortIndex: Integer;
begin
  Result := FLevel.FSortedColumns.IndexOf(Self);
end;

function TdxMasterViewColumn.GetSummaryField: TField;
begin
  if cvSummaryFieldName in FAssignedValues then
    Result := FSummaryField
  else
    Result := Field;
end;

function TdxMasterViewColumn.GetSummaryFieldName: string;
begin
  if cvSummaryFieldName in FAssignedValues then
    Result := FSummaryFieldName
  else
    Result := FieldName;
end;

function TdxMasterViewColumn.GetSummaryIndex: Integer;
begin
  Result := FLevel.FSummaryColumns.IndexOf(Self);
end;

function TdxMasterViewColumn.GetVisibleIndex: Integer;
begin
  if FLevel = nil then Result := -1
  else Result := FLevel.FVisibleColumns.IndexOf(Self);
end;

function TdxMasterViewColumn.GetVisibleMaxWidth: Integer;
begin
  if coHorSizing in FOptions then
    Result := MaxWidth + AddInWidth
  else
    Result := VisibleWidth;
end;

function TdxMasterViewColumn.GetVisibleMinWidth: Integer;
begin
  if coHorSizing in FOptions then
    Result := MinWidth + AddInWidth
  else
    Result := VisibleWidth;
end;

function TdxMasterViewColumn.GetVisibleWidth: Integer;
begin
  if FVisible and (FVisibleWidth <> 0) then
    Result := FVisibleWidth
  else
    Result := Width;
  Inc(Result, FAddInWidth);
{  if Control.AutoColumnWidth and FVisible then
    Result := FVisibleWidth
  else
    Result := Width;
  Inc(Result, AddInWidth);}
end;

procedure TdxMasterViewColumn.SetAlignment(Value: TAlignment);
begin
  if (Alignment <> Value) or IsLoading then
  begin
    FAlignment := Value;
    AssignedValues := AssignedValues + [cvAlignment];
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewColumn.SetAssignedValues(Value: TdxMasterViewColumnAssignedValues);
var
  PrevValue: TdxMasterViewColumnAssignedValues;
begin
  if FAssignedValues <> Value then
  begin
    PrevValue := FAssignedValues;
    FAssignedValues := Value;
    if not (cvCaption in Value) then FCaption := '';
    if not (cvSummaryFieldName in Value) then
    begin
      FSummaryField := nil;
      FSummaryFieldName := '';
    end;
    if (cvWidth in Value) and not (cvWidth in PrevValue) and FVisible then
      FLevel.WidthChanged
    else
      if not (cvWidth in Value) and
        ((cvWidth in PrevValue) or
         FLevel.ShowHeader and ([cvCaption] * Value <> [cvCaption] * PrevValue)) then
        FLevel.CalcDefaultWidths(Self);
    ColumnChanged(
      (cvSummaryFieldName in PrevValue) and not (cvSummaryFieldName in Value),
      hpAll, vpAll);
//    if dxMVDesigner <> nil then dxMVDesigner.Changed(Control, [rcEnables]);
  end;
end;

procedure TdxMasterViewColumn.SetCaption(Value: string);
const
  HParts: array[Boolean] of TdxMasterViewHPart = (hpAll, hpOne);
begin
  if Caption <> Value then
  begin
    FCaption := Value;
    if not (cvCaption in FAssignedValues) then
      AssignedValues := AssignedValues + [cvCaption]
    else
      if not (cvWidth in FAssignedValues) and FLevel.ShowHeader then
        FLevel.CalcDefaultWidths(Self);
    ColumnChanged(False, HParts[cvWidth in FAssignedValues], vpAll);
  end;
end;

procedure TdxMasterViewColumn.SetColIndex(Value: Integer);
begin
  FLevel.Layout.ChangeCol(Self, Value);
end;

procedure TdxMasterViewColumn.SetContentStyle(Value: TdxMasterViewStyle);
begin
  if FContentStyle <> Value then
  begin
    if FContentStyle <> nil then
      FContentStyle.RemoveConsumeType(Self, sctContent);
    FContentStyle := Value;
    if FContentStyle <> nil then
      FContentStyle.AddConsumeType(Self, sctContent);
    ContentStyleChanged([]);
  end;
end;

procedure TdxMasterViewColumn.SetField(Value: TField);
begin
  if FField <> Value then
  begin
    SetFieldInternally(Value);
    if ([cvWidth, cvCaption] * FAssignedValues = []) {and FLevel.ShowHeader }then
      FLevel.CalcDefaultWidths(Self);
    FLevel.FCanUseSmartReload := False;
    ColumnChanged(True, hpAll, vpAll);
  end;
end;

procedure TdxMasterViewColumn.SetFieldInternally(Value: TField);
begin
  if FField <> Value then
  begin
    FField := Value;
    if FField <> nil then
    begin
      FField.FreeNotification(FLevel);
      FFieldName := FField.FieldName;
    end;
  end;
end;

procedure TdxMasterViewColumn.SetFieldName(Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    SetField(FindField);
  end;
end;

procedure TdxMasterViewColumn.SetFooterAlignment(Value: TAlignment);
begin
  if (FooterAlignment <> Value) or IsLoading then
  begin
    FFooterAlignment := Value;
    AssignedValues := AssignedValues + [cvFooterAlignment];
    ColumnChanged(False, hpOne, vpFooter);
  end;
end;

procedure TdxMasterViewColumn.SetFooterStyle(Value: TdxMasterViewStyle);
begin
  if FFooterStyle <> Value then
  begin
    if FFooterStyle <> nil then
      FFooterStyle.RemoveConsumeType(Self, sctFooter);
    FFooterStyle := Value;
    if FFooterStyle <> nil then
      FFooterStyle.AddConsumeType(Self, sctFooter);
    FooterStyleChanged([]);
  end;
end;

procedure TdxMasterViewColumn.SetGroupIndex(Value: Integer);
begin
  if IsLoading then
    FLoadedGroupIndex := Value
  else
  begin
    if Value < -1 then Value := -1;
    if Value > FLevel.GroupColumnCount then Value := FLevel.GroupColumnCount;
    if (GroupIndex <> Value) and
      (coGrouping in FOptions) {and
      ((coSorting in FOptions) or (Value = -1) or (FSortOrder <> soNone))} then
      FLevel.ChangeGrouping(Self, Value);
  end;
end;

procedure TdxMasterViewColumn.SetHeaderAlignment(Value: TAlignment);
begin
  if HeaderAlignment <> Value then
  begin
    FHeaderAlignment := Value;
    AssignedValues := AssignedValues + [cvHeaderAlignment];
    ColumnChanged(False, hpOne, vpAll);
  end;
end;

procedure TdxMasterViewColumn.SetHeaderGlyph(Value: TBitmap);
begin
  FHeaderGlyph.Assign(Value);
end;

procedure TdxMasterViewColumn.SetHeaderGlyphAlignment(Value: TAlignment);
begin
  if FHeaderGlyphAlignment <> Value then
  begin
    FHeaderGlyphAlignment := Value;
    ColumnChanged(False, hpOne, vpAll);
  end;
end;

procedure TdxMasterViewColumn.SetHeaderStyle(Value: TdxMasterViewStyle);
begin
  if FHeaderStyle <> Value then
  begin
    if FHeaderStyle <> nil then
      FHeaderStyle.RemoveConsumeType(Self, sctHeader);
    FHeaderStyle := Value;
    if FHeaderStyle <> nil then
      FHeaderStyle.AddConsumeType(Self, sctHeader);
    HeaderStyleChanged([]);
  end;
end;

procedure TdxMasterViewColumn.SetIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value >= FLevel.ColumnCount then Value := FLevel.ColumnCount - 1;
  if Index <> Value then
  begin
    Control.Items.MoveData(FLevel, Index, Value);
    FLevel.FColumns.Move(Index, Value);
    FLevel.RefreshVisibleColumnsList;
  end;
end;

procedure TdxMasterViewColumn.SetInternalVisibleWidth(Value: Integer);
begin
  CheckVisibleWidthValue(Value);
  Dec(Value, AddInWidth);
  FVisibleWidth := Value;
{  Dec(Value, AddInWidth);
  CheckWidthValue(Value);
  FVisibleWidth := Value;}
end;

procedure TdxMasterViewColumn.SetMaxRowCount(Value: Integer);
begin
  if Value < FMinRowCount then Value := FMinRowCount;
  if FMaxRowCount <> Value then
  begin
    FMaxRowCount := Value;
    if FRowCount > FMaxRowCount then RowCount := FMaxRowCount;
  end;
end;

procedure TdxMasterViewColumn.SetMaxWidth(Value: Integer);
begin
  if Value < FMinWidth then Value := FMinWidth;
  if FMaxWidth <> Value then
  begin
    FMaxWidth := Value;
    if IsLoading then Exit;
    if Width > FMaxWidth then
      Width := FMaxWidth
    else
      if VisibleWidth > VisibleMaxWidth then
        VisibleWidth := VisibleMaxWidth
      else
        if Control.AutoColumnWidth then FLevel.WidthChangedEx;
  end;
end;

procedure TdxMasterViewColumn.SetMinRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > FMaxRowCount then Value := FMaxRowCount;
  if FMinRowCount <> Value then
  begin
    FMinRowCount := Value;
    if FRowCount < FMinRowCount then RowCount := FMinRowCount;
  end;
end;

procedure TdxMasterViewColumn.SetMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > FMaxWidth then Value := FMaxWidth;
  if FMinWidth <> Value then
  begin
    FMinWidth := Value;
    if IsLoading then Exit;
    if Width < FMinWidth then
      Width := FMinWidth
    else
      if VisibleWidth < VisibleMinWidth then
        VisibleWidth := VisibleMinWidth
      else
        if Control.AutoColumnWidth then FLevel.WidthChangedEx;
  end;
end;

procedure TdxMasterViewColumn.SetMultiLine(Value: Boolean);
begin
  if FMultiLine <> Value then
  begin
    FMultiLine := Value;
    ColumnChanged(False, hpOne, vpContent);
  end;
end;

procedure TdxMasterViewColumn.SetOptions(Value: TdxMasterViewColumnOptions);
const
  HParts: array[Boolean] of TdxMasterViewHPart = (hpAll, hpOne);
var
  ChangedValues: TdxMasterViewColumnOptions;
begin
  if FOptions <> Value then
  begin
    Byte(ChangedValues) := Byte(Value) xor Byte(FOptions);
    FOptions := Value;
    if (coHidden in ChangedValues) and Control.Customizing then
      TdxMVCustomizationForm(Control.CustomizationForm).RefreshColumnsListBox(nil);
    if coShowCaption in ChangedValues then
    begin
      if not (cvWidth in FAssignedValues) and FLevel.ShowHeader then
        FLevel.CalcDefaultWidths(Self);
      ColumnChanged(False, HParts[cvWidth in FAssignedValues], vpAll);
    end;
  end;
end;

procedure TdxMasterViewColumn.SetPressed(Value: Boolean);
begin
  if FPressed <> Value then
  begin
    FPressed := Value;
    ColumnChanged(False, hpOne, vpHeader);
    if FLevel.ShowGroupByBox then
      ColumnChanged(False, hpOne, vpGroupByBox);
    if Control <> nil then Control.Update;
  end;
end;

procedure TdxMasterViewColumn.SetRowCount(Value: Integer);
begin
  FLevel.Layout.ChangeRowCount(Self, Value);
end;

procedure TdxMasterViewColumn.SetRowIndex(Value: Integer);
begin
  FLevel.Layout.ChangeRow(Self, Value, False);
end;

procedure TdxMasterViewColumn.SetSortIndex(Value: Integer);
begin
  if IsLoading then
    FLoadedSortIndex := Value
  else
  begin
    if FSortOrder = soNone then Exit;
    if Value < 0 then Value := 0;
    if Value > FLevel.SortedColumnCount - 1 then
      Value := FLevel.SortedColumnCount - 1;
    if SortIndex <> Value then
      FLevel.ChangeSorting(Self, FSortOrder, Value);
  end;
end;

procedure TdxMasterViewColumn.SetSortOrder(Value: TdxMasterViewSortOrder);
begin
  if IsLoading then
    FSortOrder := Value
  else
    if (FSortOrder <> Value) and (coSorting in FOptions) then
      FLevel.ChangeSorting(Self, Value, SortIndex);
end;

procedure TdxMasterViewColumn.SetSummaryField(Value: TField);
begin
  if SummaryField <> Value then
  begin
    SetSummaryFieldInternally(Value);
    FLevel.FCanUseSmartReload := False;
    ColumnChanged(True, hpAll, vpAll);
  end;
end;

procedure TdxMasterViewColumn.SetSummaryFieldInternally(Value: TField);
begin
  if SummaryField <> Value then
  begin
    FSummaryField := Value;
    if FSummaryField <> nil then
    begin
      FSummaryField.FreeNotification(FLevel);
      SummaryFieldName := FSummaryField.FieldName;
    end;
  end;
end;

procedure TdxMasterViewColumn.SetSummaryFieldName(Value: string);
begin
  if SummaryFieldName <> Value then
  begin
    FSummaryFieldName := Value;
    AssignedValues := AssignedValues + [cvSummaryFieldName];
    SetSummaryField(FindSummaryField);
  end;  
end;

procedure TdxMasterViewColumn.SetSummaryFormat(Value: string);
begin
  if FSummaryFormat <> Value then
  begin
    FSummaryFormat := Value;
    ColumnChanged(False, hpOne, vpFooter);
  end;
end;

procedure TdxMasterViewColumn.SetSummaryType(Value: TdxMasterViewSummaryType);
begin
  if FSummaryType <> Value then
  begin
    FSummaryType := Value;
    FLevel.SummaryColumnsChanged(Self, TOperation(Value = stNone));
    ColumnChanged(True, hpAll, vpAll);
  end;
end;

procedure TdxMasterViewColumn.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    if not Value and not IsLoading then
    begin
      ColumnChanged(False, hpAll, vpAll);
      if FLevel.Horizontal then
        FColIndex := ColIndex
      else
        FRowIndex := RowIndex;
    end;
    FVisible := Value;
    FLevel.RefreshVisibleColumnsList;
    if Value then
      FLevel.Layout.InsertColumn(FRowIndex, FColIndex, Self)
    else
      FLevel.Layout.RemoveColumn(Self);
    if IsLoading then Exit;
    if (HeaderStyle <> nil) and (svFont in HeaderStyle.AssignedValues) then
      HeaderStyleChanged([svFont]);
    if (ContentStyle <> nil) and (svFont in ContentStyle.AssignedValues) then
      ContentStyleChanged([svFont]);
    if (FooterStyle <> nil) and (svFont in FooterStyle.AssignedValues) then
      FooterStyleChanged([svFont]);
    FLevel.WidthChanged;
    if Value then ColumnChanged(False, hpAll, vpAll);
    if Control <> nil then
      if Control.Customizing then
        TdxMVCustomizationForm(Control.CustomizationForm).RefreshColumnsListBox(Self);
    if FVisible then
      FLevel.DoShowColumn(Self)
    else
      FLevel.DoHideColumn(Self);
  end;
end;

procedure TdxMasterViewColumn.SetVisibleWidth(Value: Integer);
begin
  CheckVisibleWidthValue(Value);
  if VisibleWidth <> Value then
    ChangeWidth(Value - AddInWidth, True);
end;

procedure TdxMasterViewColumn.SetWidth(Value: Integer);
begin
  CheckWidthValue(Value);
  if Width <> Value then
    ChangeWidth(Value, False);
end;

procedure TdxMasterViewColumn.CheckRowCount(var Value: Integer);
begin
  if Value < FMinRowCount then Value := FMinRowCount;
  if Value > FMaxRowCount then Value := FMaxRowCount;
end;

procedure TdxMasterViewColumn.CheckVisibleWidthValue(var Value: Integer);
begin
  if Value < VisibleMinWidth then Value := VisibleMinWidth;
  if Value > VisibleMaxWidth then Value := VisibleMaxWidth;
end;

procedure TdxMasterViewColumn.CheckWidthValue(var Value: Integer);
begin
  if Value < FMinWidth then Value := FMinWidth;
  if Value > FMaxWidth then Value := FMaxWidth;
end;

function TdxMasterViewColumn.FindField: TField;
begin
  if (FFieldName <> '') and (FLevel.DataSet <> nil) then
    Result := FLevel.DataSet.FindField(FFieldName)
  else   
    Result := nil;
end;

function TdxMasterViewColumn.FindSummaryField: TField;
begin
  if cvSummaryFieldName in FAssignedValues then
    if (FSummaryFieldName <> '') and (FLevel.DataSet <> nil) then
      Result := FLevel.DataSet.FindField(FSummaryFieldName)
    else
      Result := nil
  else
    Result := Field;
end;

procedure TdxMasterViewColumn.HeaderGlyphChanged(Sender: TObject);
const
  HParts: array[Boolean] of TdxMasterViewHPart = (hpAll, hpOne);
begin
  if not (cvWidth in FAssignedValues) and FLevel.ShowHeader then
    FLevel.CalcDefaultWidths(Self);
  ColumnChanged(False, HParts[cvWidth in FAssignedValues], vpAll);
end;

function TdxMasterViewColumn.IsAlignmentStored: Boolean;
begin
  Result := (cvAlignment in FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TdxMasterViewColumn.IsCaptionStored: Boolean;
begin
  Result := (cvCaption in FAssignedValues) and (FCaption <> DefaultCaption);
end;

function TdxMasterViewColumn.IsFooterAlignmentStored: Boolean;
begin
  Result := (cvFooterAlignment in FAssignedValues) and
    (FFooterAlignment <> DefaultAlignment);
end;

function TdxMasterViewColumn.IsHeaderAlignmentStored: Boolean;
begin
  Result := (cvHeaderAlignment in FAssignedValues) and
    (FHeaderAlignment <> DefaultHeaderAlignment);
end;

function TdxMasterViewColumn.IsSummaryFieldNameStored: Boolean;
begin
  Result := (cvSummaryFieldName in FAssignedValues) and
    (FSummaryFieldName <> FFieldName);
end;

function TdxMasterViewColumn.IsWidthLinked: Boolean;
begin
  Result := VisibleWidth = FLevel.Layout.ContentWidths[ColIndex];
end;

function TdxMasterViewColumn.IsWidthStored: Boolean;
begin
  Result := (cvWidth in FAssignedValues) and (FWidth <> DefaultWidth);
end;

procedure TdxMasterViewColumn.ReadLeaveSortOrder(Reader: TReader);
begin
  FLeaveSortOrder := Reader.ReadBoolean;
end;

procedure TdxMasterViewColumn.WriteLeaveSortOrder(Writer: TWriter);
begin
  Writer.WriteBoolean(FLeaveSortOrder);
end;

procedure TdxMasterViewColumn.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('LeaveSortOrder', ReadLeaveSortOrder, WriteLeaveSortOrder,
    FLeaveSortOrder);
end;

procedure TdxMasterViewColumn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TdxMasterViewStyle) then
  begin
    if HeaderStyle = AComponent then HeaderStyle := nil;
    if ContentStyle = AComponent then ContentStyle := nil;
    if FooterStyle = AComponent then FooterStyle := nil;
  end;
end;

procedure TdxMasterViewColumn.SetName(const NewName: TComponentName);
begin
  inherited;
  if dxMVDesigner <> nil then dxMVDesigner.Changed(Control, [rcColumns]);
end;

procedure TdxMasterViewColumn.SetParentComponent(AParent: TComponent);
begin
  if AParent is TdxMasterViewLevel then
    TdxMasterViewLevel(AParent).AddColumn(Self);
end;

function TdxMasterViewColumn.CanGrouping(Index: Integer): Boolean;
begin
  Result := (coGrouping in FOptions) and FLevel.CanGrouping(Self, Index);
end;

function TdxMasterViewColumn.CanHiding: Boolean;
begin
  Result := FVisible and not Hidden and (FLevel.VisibleColumnCount > 1) and
    ((locColumnHiding in FLevel.OptionsCustomize) or
     Control.Customizing or Control.IsDesigning);
end;

function TdxMasterViewColumn.CanMoving: Boolean;
begin
  Result :=
    (locColumnMoving in FLevel.OptionsCustomize) and (coMoving in FOptions);
end;

function TdxMasterViewColumn.CanHorSizing: Boolean;
begin
  Result := FLevel.CanHorSizing and
    (coHorSizing in FOptions) and (FMinWidth <> FMaxWidth);
end;

function TdxMasterViewColumn.CanSorting: Boolean;
begin
  Result := (coSorting in FOptions) and FLevel.CanSorting(Self);
end;

function TdxMasterViewColumn.CanVerSizing: Boolean;
begin
  Result := (locColumnVerSizing in FLevel.OptionsCustomize) and
    (coVerSizing in FOptions) and (FMinRowCount <> FMaxRowCount);
end;

procedure TdxMasterViewColumn.ColumnChanged(HardRefresh: Boolean;
  HPart: TdxMasterViewHPart; VPart: TdxMasterViewVPart);
var
  I: Integer;
begin
  if not FLevel.Active or IsDestroying or IsLoading then Exit;
  if HardRefresh then
    FLevel.LevelChanged(HardRefresh)
  else
    if (FVisible or (VPart = vpGroupByBox)) and
      (Control <> nil) and (FLevel.FLayout.FUpdateLockCount = 0) then
      with Control do
        if (FUpdateLockCount = 0) and HandleAllocated then
          for I := TopIndex to TopIndex + PartVisibleItemCount - 1 do
            with AbsoluteItems[I] do
              if Level = Self.Level then
                if HPart = hpOne then
                  Invalidate(Self, VPart)
                else
                  Invalidate(nil, VPart)
              else
                if Level.HasAsParent(Self.Level) then
                  Invalidate(nil, vpFooter);
end;

procedure TdxMasterViewColumn.ContentStyleChanged(Values: TdxMasterViewStyleValues);
begin
  if (Values = []) or (svFont in Values) then
    FLevel.ContentStyleChanged([svFont]);
  ColumnChanged(False, hpOne, vpContent);
end;

function TdxMasterViewColumn.DefaultAlignment: TAlignment;
begin
  if Field = nil then
    Result := taLeftJustify
  else
    Result := Field.Alignment;
end;

function TdxMasterViewColumn.DefaultCaption: string;
begin
  if Field = nil then
    Result := FieldName
  else
    Result := Field.DisplayName;
end;

function TdxMasterViewColumn.DefaultHeaderAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TdxMasterViewColumn.DefaultWidth: Integer;
var
  DC: HDC;
  PrevFont: HFONT;
  TM: TTextMetric;
  Size: TSize;
  W: Integer;
begin
  if (FLevel = nil) or (Field = nil) then
    Result := 64
  else
  begin
    DC := GetDC(0);
    PrevFont := SelectObject(DC, ContentFont.Handle);
    GetTextMetrics(DC, TM);
    GetTextExtentPoint{32}(DC, '0', 1, Size);
    Result := Field.DisplayWidth * (Size.cx - TM.tmOverhang) + TM.tmOverhang + 4;
    if FLevel.ShowHeader then
    begin
      W := GetHeaderBestFitWidth(DC, False);
      if W > Result then Result := W;
    end;
    SelectObject(DC, PrevFont);
    ReleaseDC(0, DC);
  end;
  CheckWidthValue(Result);
end;

procedure TdxMasterViewColumn.DoAfterCalcSummary(Node: TdxMasterViewNode;
  DataSet: TDataSet; var Value: Extended);
begin
  if Assigned(FOnAfterCalcSummary) then
    FOnAfterCalcSummary(Self, Node, DataSet, Value);
end;

procedure TdxMasterViewColumn.DoBeforeCalcSummary(Node: TdxMasterViewNode;
  DataSet: TDataSet; var Value: Extended);
begin
  if Assigned(FOnBeforeCalcSummary) then
    FOnBeforeCalcSummary(Self, Node, DataSet, Value);
end;

procedure TdxMasterViewColumn.DoCalcSummary(Node: TdxMasterViewNode;
  DataSet: TDataSet; var Value: Extended);
begin
  if Assigned(FOnCalcSummary) then FOnCalcSummary(Self, Node, DataSet, Value);
end;

procedure TdxMasterViewColumn.DrawSortMark(DC: HDC; var ARect: TRect);
var
  Sign, X, Y: Integer;
  PrevPen: HPEN;
begin
  Dec(ARect.Right, SortOrderMarkZoneWidth);

  Sign := 2 * Byte(FSortOrder = soAscending) - 1;
  X := ARect.Right + SortOrderMarkZoneWidth div 2 - 1;
  Y := (ARect.Top + ARect.Bottom - Sign * SortOrderMarkHeight) div 2 -
    Byte(FSortOrder = soDescending);

  PrevPen := SelectObject(DC, Control.BtnHighlightPen);
  MoveToEx(DC, X + 4, Y + Sign * 5, nil);
  LineTo(DC, X + 1, Y);
  LineTo(DC, X + 4, Y + Sign * 6);
  if FSortOrder = soDescending then SelectObject(DC, Control.BtnShadowPen);
  LineTo(DC, X - 3, Y + Sign * 6);
  if FSortOrder = soAscending then SelectObject(DC, Control.BtnShadowPen);
  LineTo(DC, X, Y);
  LineTo(DC, X - 3, Y + Sign * 7);
  SelectObject(DC, PrevPen);
end;

procedure TdxMasterViewColumn.DrawHeader(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode);
var
  ABrush: HBRUSH;
  ATextColor, ABkColor: TColor;
  AFont: TFont;
  R: TRect;
  ADC: HDC;
  CanUseBitmap, FillBackground, MakeRightSpace: Boolean;
begin
  FLevel.GetHeaderParams(Node, Self, @ABrush, nil, @ATextColor, @ABkColor, @AFont);
  R := ARect;
  CanUseBitmap :=
    (movUseBitmap in Control.OptionsView) or not FHeaderGlyph.Empty;
  with Control do
    if CanUseBitmap then
    begin
      with R do
      begin
        OffsetRect(R, -Left, -Top);
        PrepareBitmap(Right, Bottom);
      end;
      ADC := Bitmap.Canvas.Handle;
    end
    else
      ADC := DC;

  if not FHeaderGlyph.Empty then
  begin
    FillRect(ADC, R, ABrush);
    TransparentDraw(ADC, R, FHeaderGlyphAlignment, ABrush, FHeaderGlyph);
    FillBackground := False;
  end
  else
    FillBackground := True;
  MakeRightSpace := (FSortOrder = soNone) or
    (ARect.Right - ARect.Left < SortOrderMarkZoneWidth);
  if coShowCaption in FOptions then
    Control.DrawText(ADC, R, AFont, ABrush, ATextColor, ABkColor,
      HeaderAlignment, Caption, FillBackground, MakeRightSpace, False, False)
  else
    if FHeaderGlyph.Empty then FillRect(ADC, R, ABrush);
  if not MakeRightSpace then DrawSortMark(ADC, R);

  if CanUseBitmap then
    with ARect do
      BitBlt(DC, Left, Top, Right - Left, Bottom - Top, ADC, 0, 0, SRCCOPY);
end;

procedure TdxMasterViewColumn.DrawContent(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode);
var
  ABrush: HBRUSH;
  ATextColor, ABkColor: TColor;
  AFont: TFont;
  S: string;
begin
  FLevel.GetContentParams(Node, Self, @ABrush, @ATextColor, @ABkColor, @AFont, True);
  if FMultiLine and not VarIsNull(Node.Values[Index]) then
    S := Node.Values[Index]
  else
    S := Node.Strings[Index];
  Control.DrawText(DC, ARect, AFont, ABrush, ATextColor, ABkColor,
    Alignment, S, True, True, True, FMultiLine);
end;

procedure TdxMasterViewColumn.DrawFooter(DC: HDC; var ARect: TRect; Node: TdxMasterViewNode);
var
  ABrush: HBRUSH;
  ATextColor, ABkColor: TColor;
  AFont: TFont;
begin
  FLevel.GetFooterParams(Node, Self, @ABrush, @ATextColor, @ABkColor, @AFont);
  Control.DrawText(DC, ARect, AFont, ABrush, ATextColor, ABkColor,
    FooterAlignment, GetFooterText(Node), True, True, True, False);
end;

procedure TdxMasterViewColumn.FooterStyleChanged(Values: TdxMasterViewStyleValues);
begin
  if (Values = []) or (svFont in Values) then
    FLevel.FooterStyleChanged([svFont]);
  ColumnChanged(False, hpOne, vpFooter);
end;

function TdxMasterViewColumn.GetFooterText(Node: TdxMasterViewNode): string;
const
  SummaryFormats: array[Boolean, stSum..stAverage] of string =
    (('0.00;-0.00', 'MIN=0.00;MIN=-0.00', 'MAX=0.00;MAX=-0.00', '0', 'AVG=0.00;AVG=-0.00'),
     ('', 'MIN=', 'MAX=', '0', 'AVG='));
var
  Value: Extended;
  IsDateTime: Boolean;
begin
  if SummaryType = stNone then
    Result := ''
  else
  begin
    Value := GetFooterValue(Node);
    IsDateTime :=
      (SummaryField <> nil) and
      (SummaryField.DataType in [ftDate, ftTime, ftDateTime]) and
      (FSummaryType <> stCount);
    if FSummaryFormat = '' then
      Result := SummaryFormats[IsDateTime, FSummaryType]
    else
      Result := FSummaryFormat;
    if IsDateTime then
      case SummaryField.DataType of
        ftDate: Result := Result + DateToStr(Value);
        ftTime: Result := Result + TimeToStr(Value);
      else
        Result := Result + DateTimeToStr(Value);
      end
    else
      Result := FormatFloat(Result, Value);
  end;
  FLevel.DoGetFooterCellText(Node, Self, Result);
end;

function TdxMasterViewColumn.GetGroupByBoxBounds(Node: TdxMasterViewNode): TRect;
begin
  Result := Node.GroupByBoxColumnBounds[GroupIndex];
end;

function TdxMasterViewColumn.GetGroupDisplayText(Node: TdxMasterViewNode): string;
begin
  Result := Node.GroupValueText;
end;

function TdxMasterViewColumn.GetHeaderBestFitWidth(DC: HDC; CheckSortOrderMark: Boolean): Integer;
var
  PrevFont: HFONT;
  Size: TSize;
begin
  if coShowCaption in FOptions then
  begin
    PrevFont := SelectObject(DC, HeaderFont.Handle);
    GetTextExtentPoint{32}(DC, PChar(Caption), Length(Caption), Size);
    SelectObject(DC, PrevFont);
  end
  else
    Size.cx := 0;
  Result := 2 + Size.cx + 2;
  if CheckSortOrderMark and (FSortOrder <> soNone) then
    Inc(Result, SortOrderMarkZoneWidth - 2);
  if not FHeaderGlyph.Empty then
    if FHeaderAlignment <> taCenter then
      Inc(Result, FHeaderGlyph.Width)
    else
      if (Caption = '') and (FHeaderGlyph.Width > Result) then
        Result := FHeaderGlyph.Width;
  Inc(Result, 1 + 1);
end;

function TdxMasterViewColumn.GetHeaderBounds(Node: TdxMasterViewNode): TRect;
begin
  if Node.NodeType = ntData then
  begin
    Result := Node.HeaderBounds;
    with Result do
    begin
      Inc(Left, LogicalOffset);
      if FLevel.Horizontal then
        Right := Left + VisibleWidth
      else
        Right := Left + FLevel.Layout.HeaderWidths[ColIndex];
      Inc(Top, RowIndex * FLevel.HeaderRealHeight);
      Bottom := Top + RowCount * FLevel.HeaderRealHeight;
    end;
  end
  else SetRectEmpty(Result);
end;

function TdxMasterViewColumn.GetHeaderHeight: Integer;
var
  Size: TSize;
begin
  CalcFontSize(HeaderFont, Size);
  Result := Size.cy + 2 + 2 * 2;  // 19
end;

function TdxMasterViewColumn.GetContentBounds(Node: TdxMasterViewNode): TRect;
begin
  if Node.NodeType = ntData then
  begin
    Result := Node.ContentBounds;
    with Result do
    begin
      Inc(Left, LogicalOffset);
      if not FLevel.Horizontal then
        Inc(Left, FLevel.Layout.HeaderWidths[ColIndex]);
      Right := Left + VisibleWidth;
      Inc(Top, RowIndex * FLevel.ContentRealHeight);
      Bottom := Top + RowCount * FLevel.ContentRealHeight;
    end;
  end
  else
    SetRectEmpty(Result);
end;

function TdxMasterViewColumn.GetFooterBounds(Node: TdxMasterViewNode): TRect;
begin
  Result := Node.SubFooterBounds[Node.Level.IndexOfParent(FLevel)];
  if not IsRectEmpty(Result) then
    with Result do
    begin
      Inc(Left, LogicalOffset);
      if not FLevel.Horizontal then
        Inc(Left, FLevel.Layout.HeaderWidths[ColIndex]);
      Right := Left + VisibleWidth;
      Inc(Top, RowIndex * FLevel.FooterHeight);
      Bottom := Top + RowCount * FLevel.FooterHeight;
    end;
end;

procedure TdxMasterViewColumn.HeaderStyleChanged(Values: TdxMasterViewStyleValues);
begin
  if (Values = []) or (svFont in Values) then
    FLevel.HeaderStyleChanged([svFont]);
  ColumnChanged(False, hpOne, vpHeader);
  if GroupIndex <> -1 then
    FLevel.GroupByBoxStyleChanged(Values);
end;

procedure TdxMasterViewColumn.Assign(Source: TPersistent);
var
  AColumn: TdxMasterViewColumn;
begin
  if Source is TdxMasterViewColumn then
  begin
    AColumn := TdxMasterViewColumn(Source);
    FLevel.BeginDataChanging;
    try
      AssignedValues := [];
      if cvAlignment in AColumn.AssignedValues then
        Alignment := AColumn.Alignment;
      if cvCaption in AColumn.AssignedValues then
        Caption := AColumn.Caption;
      if cvFooterAlignment in AColumn.AssignedValues then
        FooterAlignment := AColumn.FooterAlignment;
      if cvHeaderAlignment in AColumn.AssignedValues then
        HeaderAlignment := AColumn.HeaderAlignment;
      if cvSummaryFieldName in AColumn.AssignedValues then
        SummaryFieldName := AColumn.SummaryFieldName;
      if cvWidth in AColumn.AssignedValues then
        Width := AColumn.Width;

      ContentStyle := AColumn.ContentStyle;
      FieldName := AColumn.FieldName;
      FooterStyle := AColumn.FooterStyle;
      GroupIndex := AColumn.GroupIndex;
      HeaderGlyph := AColumn.HeaderGlyph;
      HeaderStyle := AColumn.HeaderStyle;
      Index := AColumn.Index;
      MaxRowCount := AColumn.MaxRowCount;
      MaxWidth := AColumn.MaxWidth;
      MinRowCount := AColumn.MinRowCount;
      MinWidth := AColumn.MinWidth;
      MultiLine := AColumn.MultiLine;
      Options := AColumn.Options;

      RowIndex := AColumn.RowIndex;
      ColIndex := AColumn.ColIndex;
      RowCount := AColumn.RowCount;

      SortIndex := AColumn.SortIndex;
      SortOrder := AColumn.SortOrder;
      SummaryFormat := AColumn.SummaryFormat;
      SummaryType := AColumn.SummaryType;
      VisibleWidth := AColumn.VisibleWidth;
      FLeaveSortOrder := AColumn.FLeaveSortOrder; 
      Visible := AColumn.Visible;
    finally
      FLevel.EndDataChanging;
    end;
  end
  else
    inherited;
end;

procedure TdxMasterViewColumn.ChangeWidth(Value: Integer;
  AdjustLinkedColumns: Boolean);
var
  Delta: Integer;
  NeedAssignWidths: Boolean;
  
  function ChangeLinkedWidths: Boolean;
  type
    PBoolArray = ^TBoolArray;
    TBoolArray = array[-1..MaxInt div (2 * SizeOf(Boolean))] of Boolean;
  var
    NewWidths: PIntArray;
    ColumnLocked, ColumnProcessed, ColumnFixed: PBoolArray;
    IsLast: Boolean;
    I, W: Integer;
    Column: TdxMasterViewColumn;

    procedure SetFixedColumns(Column: TdxMasterViewColumn);
    var
      List: TList;
      I: Integer;
    begin
      List := TList.Create;
      try
        FLevel.Layout.HasLeftNeighbours(Column, List, True);
        for I := 0 to List.Count - 1 do
        begin
          ColumnFixed[TdxMasterViewColumn(List[I]).VisibleIndex] := True;
          SetFixedColumns(List[I]);
        end;
      finally
        List.Free;
      end;
    end;

    procedure ChangeWidth(Column: TdxMasterViewColumn; var Delta: Integer;
      Direction: TdxMasterViewDirection);
    var
      VI, W, CheckW, CurDelta, I, ADelta: Integer;
      NeedChangeSize: Boolean;
      ListL, ListR, CollapsingList, ExpandingList: TList;
      OppositeDirection: TdxMasterViewDirection;

      function CanChangeSize(Column: TdxMasterViewColumn): Boolean;
      var
        List: TList;
        I: Integer;
      begin
        Result := not ColumnLocked[Column.VisibleIndex];
        if Result then
        begin
          List := TList.Create;
          try
            if FLevel.Layout.HasLeftNeighbours(Column, List, True) then
              for I := 0 to List.Count - 1 do
              begin
                Result := CanChangeSize(List[I]);
                if not Result then Break;
              end;
          finally
            List.Free;
          end;
        end;
      end;

    begin
      if Column = nil then
        VI := -1
      else
        VI := Column.VisibleIndex;

      if ColumnLocked[VI] or ColumnProcessed[VI] then
      begin
        Delta := 0;
        Exit;
      end;
      if ColumnFixed[VI] then
      begin
        Result := False;
        Exit;
      end;

      NeedChangeSize := (Column <> nil) and
        (Control.AutoColumnWidth or (Direction = dirRight) and CanChangeSize(Column));
      if NeedChangeSize then
      begin
        W := NewWidths[VI];
        if Delta < 0 then
          CheckW := Column.VisibleMinWidth
        else
          CheckW := Column.VisibleMaxWidth;
        if (Delta < 0) and (W + Delta < CheckW) or
          (Delta > 0) and (W + Delta > CheckW) then
          CurDelta := CheckW - W
        else
          CurDelta := Delta;
        Dec(Delta, CurDelta);
      end
      else
      begin
        CurDelta := 0;
        ColumnProcessed[VI] := True;
      end;

      if VI <> -1 then Inc(NewWidths[VI], CurDelta);

      ColumnLocked[VI] := True;
      ListL := TList.Create;
      ListR := TList.Create;
      try
        if Column <> nil then
          with FLevel.Layout do
          begin
            HasLeftNeighbours(Column, ListL, True);
            HasRightNeighbours(Column, ListR, True);
          end;
        if Direction = dirLeft then
        begin
          CollapsingList := ListL;
          if Column = nil then
            FLevel.Layout.RetrieveLastColumns(CollapsingList);
          ExpandingList := ListR;
          OppositeDirection := dirRight;
        end
        else
        begin
          CollapsingList := ListR;
          if (CollapsingList.Count = 0) and
            (Control.AutoColumnWidth or FLevel.OccupyRestSpace) then
            CollapsingList.Add(nil);
          ExpandingList := ListL;
          OppositeDirection := dirLeft;
        end;
        for I := 0 to CollapsingList.Count - 1 do
        begin
          ADelta := -(Delta + CurDelta);
          ChangeWidth(CollapsingList[I], ADelta, OppositeDirection);
          if ADelta <> 0 then
          begin
            Result := False;
            Exit;
          end;
        end;
        if Column = nil then Delta := 0;
        if Delta <> 0 then
          if (ExpandingList.Count = 0) and NeedChangeSize then
            Result := False
          else
          begin
            for I := 0 to ExpandingList.Count - 1 do
            begin
              ADelta := Delta;
              ChangeWidth(ExpandingList[I], ADelta, Direction);
              if ADelta <> 0 then
              begin
                Result := False;
                Exit;
              end;
            end;
            Delta := 0;
          end;
      finally
        ListR.Free;
        ListL.Free;
        ColumnLocked[VI] := False;
      end;
    end;

  begin
    if FLevel.Horizontal then
    begin
      if Control.AutoColumnWidth and FLevel.Layout.OneOnLine(Self) then
      begin
        Result := False;
        Exit;
      end;
      Result := True;
      IsLast := FLevel.Layout.IsColumnLast(Self);

      GetMem(NewWidths, FLevel.VisibleColumnCount * SizeOf(Integer));
      GetMem(ColumnLocked, (1 + FLevel.VisibleColumnCount) * SizeOf(Boolean));
      GetMem(ColumnProcessed, (1 + FLevel.VisibleColumnCount) * SizeOf(Boolean));
      GetMem(ColumnFixed, (1 + FLevel.VisibleColumnCount) * SizeOf(Boolean));
      try
        for I := -1 to FLevel.VisibleColumnCount - 1 do
        begin
          if I <> -1 then
            NewWidths[I] := FLevel.VisibleColumns[I].VisibleWidth;
          ColumnLocked[I] := False;
          ColumnProcessed[I] := False;
          ColumnFixed[I] := False;
        end;
        if not IsLast then SetFixedColumns(Self);

        if IsLast and Control.AutoColumnWidth then
          ChangeWidth(Self, Delta, dirLeft)
        else
          ChangeWidth(Self, Delta, dirRight);
        if not Result then Exit;

        for I := 0 to FLevel.VisibleColumnCount - 1 do
        begin
          Column := FLevel.VisibleColumns[I];
          if Column <> Self then
            with Column do
            begin
              W := NewWidths[I] - AddInWidth;
              if Control.AutoColumnWidth or (VisibleWidth <> NewWidths[I]) then
                Width := W
              else
                InternalVisibleWidth := NewWidths[I];
            end;
        end;
      finally
        FreeMem(ColumnFixed, (1 + FLevel.VisibleColumnCount) * SizeOf(Boolean));
        FreeMem(ColumnProcessed, (1 + FLevel.VisibleColumnCount) * SizeOf(Boolean));
        FreeMem(ColumnLocked, (1 + FLevel.VisibleColumnCount) * SizeOf(Boolean));
        FreeMem(NewWidths, FLevel.VisibleColumnCount * SizeOf(Integer));
      end;
    end
    else
      with FLevel.Layout do
      begin
{        Result := False;
        for I := 0 to Items[ColIndex].Count - 1 do
          with Columns[I, ColIndex] do
            if (Value < MinWidth) or (Value > MaxWidth) then Exit;}
        Result := True;
        if Control.AutoColumnWidth then
        begin
          W := ContentDynamicMinWidths[ColIndex];
          if Value < W then Value := W;
          if ColIndex <> Count - 1 then
          begin
            W := ContentDynamicMaxWidths[ColIndex];
            if Value > W then Value := W;
          end;
          Result := Self.Width <> Value;
          if not Result then Exit;
          FLevel.AssignColumnWidths;
        end;
        for I := 0 to Items[ColIndex].Count - 1 do
          with Columns[I, ColIndex] do
            if (RowIndex = I) and (coHorSizing in Options) then
              Width := Value;
        if Control.AutoColumnWidth then
        begin
          CalcColWidths;
          CheckColumnsWidths(Self);
          FLevel.AssignColumnWidths;
        end;
      end;
  end;

begin
  CheckWidthValue(Value);
  NeedAssignWidths := False;
  try
    if not IsLoading{FLevel} and
      AdjustLinkedColumns and FVisible then
    begin
      Delta := Value - (VisibleWidth - AddInWidth);
      NeedAssignWidths := True;
      FLevel.BeginAssignWidths;
      if not ChangeLinkedWidths then
      begin
        NeedAssignWidths := False;
        FLevel.CancelAssignWidths;
        Exit;
      end;
    end;
    FWidth := Value;
    FVisibleWidth := Value;
    //InternalVisibleWidth := Value + AddInWidth;
    if not (cvWidth in FAssignedValues) then
      AssignedValues := AssignedValues + [cvWidth]
    else
      if FVisible then FLevel.WidthChanged;
  finally
    if NeedAssignWidths then FLevel.EndAssignWidths;
  end;
  ColumnChanged(False, hpAll, vpAll);
end;

function TdxMasterViewColumn.GetParentComponent: TComponent;
begin
  Result := FLevel;
end;

function TdxMasterViewColumn.HasParent: Boolean;
begin
  Result := True;
end;

procedure TdxMasterViewColumn.ApplyBestFit;
var
  Value: Integer;
begin
  if Visible then
  begin
    if FLevel.Horizontal then
      Value := GetBestFitWidth
    else
      Value := FLevel.Layout.GetBestFitWidth(ColIndex);
    VisibleWidth := Value;
  end;
end;

function TdxMasterViewColumn.GetBestFitWidth: Integer;
var
  DC: HDC;
  PrevFont: HFONT;
  AIndex: Integer;
  Size: TSize;

  function GetTextWidth(const S: string): Integer;
  begin
    GetTextExtentPoint{32}(DC, PChar(S), Length(S), Size);
    Result := 2 + Size.cx + 2;
  end;

  procedure CalcBestFit(Root: TdxMasterViewNode);
  var
    I: Integer;
  begin
    if (Root.Level = FLevel) and (Root.NodeType = ntData) then
    begin
      I := FAddInWidth + GetTextWidth(Root.Strings[AIndex]) + FLevel.LineWidth;
      if I > Result then Result := I;
    end
    else
      for I := 0 to Root.Count - 1 do CalcBestFit(Root[I]);
  end;

begin
  DC := GetDC(0);
  try
    if FLevel.Horizontal then
      Result := GetHeaderBestFitWidth(DC, True)
    else
      Result := 0;
    AIndex := Index;
    PrevFont := SelectObject(DC, ContentFont.Handle);
    try
      CalcBestFit(Control.FItems);
    finally
      SelectObject(DC, PrevFont);
    end;
  finally
    ReleaseDC(0, DC);
  end;
end;

function TdxMasterViewColumn.GetFooterValue(Node: TdxMasterViewNode): Extended;
begin
  with Node.NodesWithSummaryData[FLevel] do
    Result := FSummaries[Byte(NodeType = ntData) * Self.FLevel.Index][SummaryIndex];
end;

{ TdxMasterViewLayout }

constructor TdxMasterViewLayout.Create(ALevel: TdxMasterViewLevel);
begin
  inherited Create;
  FLevel := ALevel;
  FHorizontal := True;
  FLines := TList.Create;
end;

destructor TdxMasterViewLayout.Destroy;
var
  I: Integer;
begin
  DestroyColArrays;
  for I := Count - 1 downto 0 do Items[I].Free;
  FLines.Free;
  inherited;
end;

function TdxMasterViewLayout.GetColLogicalOffset(ACol: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if FLevel.HasExpandButton then Inc(Result, LevelIndent);
  for I := 0 to ACol - 1 do Inc(Result, ColWidths[I]);
end;

function TdxMasterViewLayout.GetColOffset(ACol: Integer): Integer;
begin
  with FLevel do
    Result := Indent - Control.LeftPos + ColLogicalOffsets[ACol];
end;

function TdxMasterViewLayout.GetColumn(ARow, ACol: Integer): TdxMasterViewColumn;
begin
  if FHorizontal then
    Result := TdxMasterViewColumn(TList(FLines[ARow])[ACol])
  else
    Result := TdxMasterViewColumn(TList(FLines[ACol])[ARow]);
end;

function TdxMasterViewLayout.GetColWidth(ACol: Integer): Integer;
begin
  Result := HeaderWidths[ACol] + ContentWidths[ACol];
end;

function TdxMasterViewLayout.GetContentDynamicMaxWidth(ACol: Integer): Integer;
var
  W, I: Integer;
begin
  Result := ContentMaxWidths[ACol];
  if FLevel.Control.AutoColumnWidth then
  begin
    W := VisibleWidth - ColLogicalOffsets[ACol] - HeaderWidths[ACol];
    for I := Count - 1 downto ACol + 1 do
      Dec(W, HeaderWidths[I] + ContentDynamicMinWidths[I]);
    if W < Result then Result := W;
    W := ContentDynamicMinWidths[ACol];
    if Result < W then Result := W;
  end;
end;

function TdxMasterViewLayout.GetContentDynamicMinWidth(ACol: Integer): Integer;
begin
  Result := ContentMinWidths[ACol];
end;

function TdxMasterViewLayout.GetContentMaxWidth(ACol: Integer): Integer;
var
  I, W: Integer;
begin
  Result := MaxInt;
  for I := 0 to Items[ACol].Count - 1 do
    with Columns[I, ACol] do
    begin
      W := VisibleMaxWidth;
      if (Result = MaxInt) or (W > Result) then Result := W;
    end;
end;

function TdxMasterViewLayout.GetContentMinWidth(ACol: Integer): Integer;
var
  I, W: Integer;
begin
  Result := 0;
  for I := 0 to Items[ACol].Count - 1 do
  begin
    W := Columns[I, ACol].VisibleMinWidth;
    if W > Result then Result := W;
  end;
end;

function TdxMasterViewLayout.GetContentNonScaledWidth(ACol: Integer): Integer;
begin
  Result := FContentNonScaledWidths[ACol];
end;

function TdxMasterViewLayout.GetContentWidth(ACol: Integer): Integer;
begin
  Result := FContentWidths[ACol];
end;

function TdxMasterViewLayout.GetCount: Integer;
begin
  Result := FLines.Count;
end;

function TdxMasterViewLayout.GetHeaderDynamicMaxWidth(ACol: Integer): Integer;
var
  W, I: Integer;
begin
  Result := HeaderMaxWidths[ACol];
  if FLevel.Control.AutoColumnWidth and (VisibleWidth > MinWidth) then
  begin
    W := VisibleWidth - ColLogicalOffsets[ACol] - ContentMinWidths[ACol];
    for I := Count - 1 downto ACol + 1 do
      Dec(W, HeaderWidths[I] + ContentMinWidths[I]);
    if W < Result then Result := W;
    W := HeaderMinWidths[ACol];
    if Result < W then Result := W;
  end;
end;

function TdxMasterViewLayout.GetHeaderDynamicMinWidth(ACol: Integer): Integer;
begin
  Result := HeaderMinWidths[ACol];
end;

function TdxMasterViewLayout.GetHeaderMaxWidth(ACol: Integer): Integer;
begin
  Result := dxMVColumnDefaultMaxWidth;
end;

function TdxMasterViewLayout.GetHeaderMinWidth(ACol: Integer): Integer;
begin
  Result := dxMVColumnDefaultMinWidth;
end;

function TdxMasterViewLayout.GetHeaderWidth(ACol: Integer): Integer;
begin
  if FLevel.ShowHeader then
    Result := FHeaderWidths[ACol]
  else
    Result := 0;
end;

function TdxMasterViewLayout.GetHeaderWidthAssigned(ACol: Integer): Boolean;
begin
  Result := FHeaderWidthAssigned[ACol];
end;

function TdxMasterViewLayout.GetItem(Index: Integer): TList;
begin
  Result := TList(FLines[Index]);
end;
{
function TdxMasterViewLayout.GetMaxWidth: Integer;
var
  I, AWidth: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].Count <> 0 then
    begin
      with Columns[I, Items[I].Count - 1] do
        AWidth := MaxLogicalOffset + VisibleMaxWidth;
      if AWidth > Result then Result := AWidth;
    end;
end;
}
function TdxMasterViewLayout.GetMinWidth: Integer;
var
  I, AWidth: Integer;
begin
  Result := 0;
  if FHorizontal then
    for I := 0 to Count - 1 do
      if Items[I].Count <> 0 then
      begin
        with Columns[I, Items[I].Count - 1] do
          AWidth := MinLogicalOffset + VisibleMinWidth;
        if AWidth > Result then Result := AWidth;
      end
      else
  else
  begin
    if FLevel.HasExpandButton then Result := LevelIndent;
    for I := 0 to Count - 1 do
      Inc(Result, {HeaderMinWidths[I]}HeaderWidths[I]{!!!} + ContentMinWidths[I]);
  end;
end;

function TdxMasterViewLayout.GetNonScaledWidth: Integer;
var
  I, AWidth: Integer;
begin
  if not FHorizontal and FLevel.HasExpandButton then
    Result := LevelIndent
  else
    Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].Count <> 0 then
      if FHorizontal then
      begin
        with Columns[I, Items[I].Count - 1] do
          AWidth := NonScaledLogicalOffset + NonScaledWidth;
        if AWidth > Result then Result := AWidth;
      end
      else
        Inc(Result, HeaderWidths[I] + ContentNonScaledWidths[I]);
end;

function TdxMasterViewLayout.GetVisibleWidth: Integer;
var
  AIndent: Integer;
begin
  if FLevel.Control.AutoColumnWidth and (FLevel.VisibleColumnCount <> 0) then
  begin
    AIndent := FLevel.Indent;
    Result := MinWidth;
    if AIndent + Result < FLevel.Control.ClientWidth then
      Result := FLevel.Control.ClientWidth - AIndent;
  end
  else
    Result := GetNonScaledWidth;
end;

procedure TdxMasterViewLayout.SetContentInternalVisibleWidth(ACol, Value: Integer);
var
  I: Integer;
begin
  if FContentWidths[ACol] <> Value then
    for I := 0 to Items[ACol].Count - 1 do
      with Columns[I, ACol] do
        if RowIndex = I then
          InternalVisibleWidth := Value;
end;

procedure TdxMasterViewLayout.SetContentWidth(ACol, Value: Integer);
var
  I, PrevWidth: Integer;
  Changed: Boolean;
begin
  if FContentWidths[ACol] <> Value then
  begin
    Changed := False;
    FLevel.BeginAssignWidths;
    try
      for I := 0 to Items[ACol].Count - 1 do
        with Columns[I, ACol] do
          if RowIndex = I then
          begin
            PrevWidth := Width;
            Width := Value;
            Changed := Changed or (Width <> PrevWidth);
          end;
    finally
      if Changed then FLevel.EndAssignWidths
      else FLevel.CancelAssignWidths;
    end;
  end;
end;

procedure TdxMasterViewLayout.SetCount(Value: Integer);
var
  PrevCount, I: Integer;
  PrevHeaderWidths: PIntArray;
  PrevHeaderWidthAssigned: PBoolArray;
begin
  if Value < 1 then Value := 1;
  if Count <> Value then
  begin
    if Value > Count then
    begin
      PrevCount := Count;
      PrevHeaderWidths := FHeaderWidths;
      PrevHeaderWidthAssigned := FHeaderWidthAssigned;
      if not FHorizontal then
      begin
        FHeaderWidths := nil;
        FHeaderWidthAssigned := nil;
        DestroyColArrays;
      end;
      for I := Count + 1 to Value do FLines.Add(TList.Create);
      if FHorizontal then FRowCount := Count
      else
      begin
        CreateColArrays;
        Move(PrevHeaderWidths^, FHeaderWidths^, PrevCount * SizeOf(Integer));
        Move(PrevHeaderWidthAssigned^, FHeaderWidthAssigned^, PrevCount * SizeOf(Boolean));
        FreeMem(PrevHeaderWidths);
        FreeMem(PrevHeaderWidthAssigned);
      end;
    end
    else
      for I := Count - 1 downto Value do Delete(I);

  end;
end;

procedure TdxMasterViewLayout.SetHeaderWidth(ACol, Value: Integer);
begin
  ChangeHeaderWidth(ACol, Value, False);
end;

procedure TdxMasterViewLayout.SetHeaderWidthAssigned(ACol: Integer; Value: Boolean);
begin
  if FHeaderWidthAssigned[ACol] <> Value then
  begin
    FHeaderWidthAssigned[ACol] := Value;
    if not Value then HeaderWidthChanged;
  end;
end;

function TdxMasterViewLayout.AreNeighbours(Column1, Column2: TdxMasterViewColumn;
  ExactResult: Boolean): Boolean;
var
  MinRow, MaxRow, I, I1, I2: Integer;
begin
  if ExactResult then
    Result := Column1.LogicalOffset + Column1.VisibleWidth = Column2.LogicalOffset
  else
  begin
    if Column1.RowIndex > Column2.RowIndex then
      MinRow := Column1.RowIndex
    else
      MinRow := Column2.RowIndex;
    if Column1.RowIndex + Column1.RowCount < Column2.RowIndex + Column2.RowCount then
      MaxRow := Column1.RowIndex + Column1.RowCount - 1
    else
      MaxRow := Column2.RowIndex + Column2.RowCount - 1;
    Result := False;
    for I := MinRow to MaxRow do
      with Items[I] do
      begin
        I1 := IndexOf(Column1);
        if I1 = -1 then Continue;
        I2 := IndexOf(Column2);
        if I2 = -1 then Continue;
        if I1 + 1 <> I2 then Exit;
      end;
    Result := True;
  end;  
end;

procedure TdxMasterViewLayout.CalcAddInWidths;
var
  I: Integer;
  Column: TdxMasterViewColumn;
begin
  for I := 0 to FLevel.ColumnCount - 1 do
    FLevel.Columns[I].FAddInWidth := 0;
  if FLevel.HasExpandButton and FHorizontal then
    for I := 0 to Count - 1 do
      if Items[I].Count <> 0 then
      begin
        Column := Columns[I, 0];
        if (Column.FAddInWidth = 0) and IsColumnFirst(Column) then
          Column.FAddInWidth := LevelIndent;
      end;
end;

procedure TdxMasterViewLayout.CalcColWidths;
var
  DC: HDC;
  I, J, W: Integer;
  AHeaderWidthAssigned, AutoWidth: Boolean;
begin
  FRowCount := 0;
  AutoWidth := FLevel.Control.AutoColumnWidth;
  DC := GetDC(0);
  try
    for I := 0 to Count - 1 do
    begin
      AHeaderWidthAssigned := HeaderWidthAssigned[I];
      if not AHeaderWidthAssigned then
        FHeaderWidths[I] := 0;
      FContentNonScaledWidths[I] := 0;
      FContentWidths[I] := 0;
      J := Items[I].Count;
      if J > FRowCount then FRowCount := J;
      for J := 0 to J - 1 do
      begin
        if not AHeaderWidthAssigned then
        begin
          W := Columns[J, I].GetHeaderBestFitWidth(DC, True);
          if W > FHeaderWidths[I] then FHeaderWidths[I] := W;
        end;
        W := Columns[J, I].NonScaledWidth;
        if W > FContentNonScaledWidths[I] then FContentNonScaledWidths[I] := W;
        if AutoWidth then
          W := Columns[J, I].VisibleWidth;
        if W > FContentWidths[I] then FContentWidths[I] := W;
      end;
    end;
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TdxMasterViewLayout.CalcLogicalOffsets(Mode: Byte);
var
  I, J: Integer;
begin
  if Mode in [0, 1] then
    for I := 0 to Count - 1 do
      for J := 0 to Items[I].Count - 1 do
        with TdxMasterViewColumn(Items[I][J]) do
          FLogicalOffset := -1;
  if Mode in [0, 2] then
    for I := 0 to Count - 1 do
      for J := 0 to Items[I].Count - 1 do
        with TdxMasterViewColumn(Items[I][J]) do
          if FLogicalOffset = -1 then
            FLogicalOffset := LogicalOffset;
end;

procedure TdxMasterViewLayout.CalcNeighbours;
var
  I: Integer;
  Column: TdxMasterViewColumn;
begin
  for I := 0 to FLevel.VisibleColumnCount - 1 do
  begin
    Column := FLevel.VisibleColumns[I];
    Column.FLeftColumns.Clear;
    Column.FRightColumns.Clear;
    if FHorizontal then
    begin
      HasLeftNeighbours(Column, Column.FLeftColumns, False);
      HasRightNeighbours(Column, Column.FRightColumns, False);
    end;
{    Column.FLeftColumns.Clear;
    HasLeftNeighbours(Column, Column.FLeftColumns, False);
    Column.FRightColumns.Clear;
    HasRightNeighbours(Column, Column.FRightColumns, False);}
  end;
end;

procedure TdxMasterViewLayout.CalcOptimizedValues;
begin
  CalcNeighbours;
  CalcLogicalOffsets(0);
end;

procedure TdxMasterViewLayout.CalcVisibleWidth;
begin
  if FLevel.Control.AutoColumnWidth and (FLevel.VisibleColumnCount <> 0) then
    FVisibleWidth := FLevel.Control.ScrollableWidth - FLevel.Indent
  else
    FVisibleWidth := GetVisibleWidth;
end;

procedure TdxMasterViewLayout.CheckColumnsWidths(FixedColumn: TdxMasterViewColumn);

  procedure CheckColumnsAutoWidthsWhenHorizontal;
  var
    AColumns: TList;
    NewWidths, FreeSpaces: PIntArray;
    ColumnLocked: PBoolArray;
    NonScaledSize, AvailableSpace, I, NonScaledOffset, NonScaledW, W, CheckW: Integer;
    Column: TdxMasterViewColumn;

    function GetAdvanceNewWidth: Integer;
    begin
      NonScaledOffset := Column.NonScaledLogicalOffset;
      NonScaledW := Column.NonScaledWidth;
      if OneOnLine(Column) then
        Result := AvailableSpace
      else
        Result :=
          MulDiv(NonScaledOffset + NonScaledW, AvailableSpace, NonScaledSize) -
          MulDiv(NonScaledOffset, AvailableSpace, NonScaledSize);
    end;

    procedure ChangeWidth(Column: TdxMasterViewColumn; Delta: Integer;
      Direction: TdxMasterViewDirection);
    var
      VI, W, CheckW, CurDelta, MaxW_L, MaxW_R, DeltaL, DeltaR, I: Integer;
      ListL, ListR, CollapsingList, ExpandingList: TList;
      OppositeDirection: TdxMasterViewDirection;

      function FindMaxWidth(List: TList): Integer;
      var
        I, W: Integer;
      begin
        Result := 0;
        for I := 0 to List.Count - 1 do
        begin
          W := TdxMasterViewColumn(List[I]).NonScaledWidth;
          if W > Result then Result := W;
        end;
      end;

      procedure CheckAvailableSpace(List: TList; Direction: TdxMasterViewDirection;
        var Delta1, Delta2: Integer);
      var
        AvailSpace: Integer;

        function FindAvailableSpace(List: TList): Integer;
        var
          AList: TList;
          I, Space: Integer;
        begin
          Result := MaxInt;
          AList := TList.Create;
          try
            for I := 0 to List.Count - 1 do
            begin
              if Direction = dirLeft then
                HasLeftNeighbours(List[I], AList, True)
              else
                HasRightNeighbours(List[I], AList, True);
              with TdxMasterViewColumn(List[I]) do
                if CurDelta > 0 then
                  Space := NewWidths[VisibleIndex] - VisibleMinWidth
                else
                  Space := VisibleMaxWidth - NewWidths[VisibleIndex];
              Inc(Space, FindAvailableSpace(AList));
              if Space < Result then Result := Space;
            end;
          finally
            AList.Free;
            if Result = MaxInt then Result := 0;
          end;
        end;

      begin
        AvailSpace := FindAvailableSpace(List);
        if CurDelta < 0 then AvailSpace := -AvailSpace;
        if (CurDelta > 0) and (Delta1 > AvailSpace) or
          (CurDelta < 0) and (Delta1 < AvailSpace) then
        begin
          Inc(Delta2, Delta1 - AvailSpace);
          Delta1 := AvailSpace;
        end;
      end;

    begin
      VI := Column.VisibleIndex;
      if ColumnLocked[VI] then Exit;

      if FreeSpaces[VI] * Delta > 0 then
        CurDelta := Delta
      else
      begin
        W := NewWidths[VI];
        if Delta < 0 then
          CheckW := Column.VisibleMinWidth
        else
          CheckW := Column.VisibleMaxWidth;
        if (Delta < 0) and (W + Delta < CheckW) or
          (Delta > 0) and (W + Delta > CheckW) then
          CurDelta := CheckW - W
        else
          CurDelta := Delta;
      end;    
      Dec(Delta, CurDelta);

      Inc(NewWidths[VI], CurDelta);
      if FreeSpaces[VI] <> 0 then
        if (FreeSpaces[VI] + CurDelta) * FreeSpaces[VI] < 0 then
          FreeSpaces[VI] := 0
        else
          Inc(FreeSpaces[VI], CurDelta);

      ColumnLocked[VI] := True;
      ListL := TList.Create;
      ListR := TList.Create;
      try
        HasLeftNeighbours(Column, ListL, True);
        HasRightNeighbours(Column, ListR, True);
        if Direction = dirNone then
        begin
          MaxW_L := FindMaxWidth(ListL);
          MaxW_R := FindMaxWidth(ListR);
          DeltaL := MulDiv(CurDelta, MaxW_L, MaxW_L + MaxW_R);
          DeltaR := CurDelta - DeltaL;
          CheckAvailableSpace(ListL, dirLeft, DeltaL, DeltaR);
          CheckAvailableSpace(ListR, dirRight, DeltaR, DeltaL);
          for I := 0 to ListL.Count - 1 do
            ChangeWidth(ListL[I], -DeltaL, dirLeft);
          for I := 0 to ListR.Count - 1 do
            ChangeWidth(ListR[I], -DeltaR, dirRight);
        end
        else
        begin
          if Direction = dirLeft then
          begin
            CollapsingList := ListR;
            ExpandingList := ListL;
            OppositeDirection := dirRight;
          end
          else
          begin
            CollapsingList := ListL;
            ExpandingList := ListR;
            OppositeDirection := dirLeft;
          end;
          for I := 0 to CollapsingList.Count - 1 do
            ChangeWidth(CollapsingList[I], -(Delta + CurDelta), OppositeDirection);
          if Delta <> 0 then
            for I := 0 to ExpandingList.Count - 1 do
              ChangeWidth(ExpandingList[I], Delta, Direction);
        end;
      finally
        ListR.Free;
        ListL.Free;
        ColumnLocked[VI] := False;
      end;
    end;

  begin
    if not FLevel.Visible then Exit;

    AColumns := TList.Create;
    AColumns.Count := FLevel.VisibleColumnCount;
    Move(FLevel.FVisibleColumns.List^, AColumns.List^, AColumns.Count * SizeOf(Pointer));

    GetMem(NewWidths, AColumns.Count * SizeOf(Integer));
    GetMem(FreeSpaces, AColumns.Count * SizeOf(Integer));
    GetMem(ColumnLocked, AColumns.Count * SizeOf(Boolean));

    try
      NonScaledSize := NonScaledWidth;
      AvailableSpace := VisibleWidth;

      for I := 0 to AColumns.Count - 1 do
      begin
        Column := AColumns[I];
        W := GetAdvanceNewWidth;
        CheckW := Column.VisibleMinWidth;
        if W < CheckW then
          FreeSpaces[I] := W - CheckW
        else
        begin
          CheckW := Column.VisibleMaxWidth;
          if W > CheckW then
            FreeSpaces[I] := W - CheckW
          else
            FreeSpaces[I] := 0;
        end;
        NewWidths[I] := W;
      end;

      for I := 0 to AColumns.Count - 1 do
      begin
        Column := AColumns[I];
        if FreeSpaces^[Column.VisibleIndex] <> 0 then
        begin
          FillChar(ColumnLocked^, AColumns.Count * SizeOf(Boolean), 0);
          ChangeWidth(Column, -FreeSpaces[Column.VisibleIndex], dirNone);
        end;
      end;

      for I := 0 to AColumns.Count - 1 do
        TdxMasterViewColumn(AColumns[I]).InternalVisibleWidth := NewWidths[I];
    finally
      FreeMem(ColumnLocked, AColumns.Count * SizeOf(Boolean));
      FreeMem(FreeSpaces, AColumns.Count * SizeOf(Integer));
      FreeMem(NewWidths, AColumns.Count * SizeOf(Integer));
      AColumns.Free;
    end;
  end;

  procedure CheckColumnsAutoWidthsWhenVertical;
  var
    NewWidths, ContentMinWidths: PIntArray;
    NonScaledSize, AvailableSpace, FixedCol, FixedI1, FixedI2, 
      I, NonScaledOffset, NonScaledW, W, CheckW: Integer;

    function ContentNonScaledOffset(const ACol: Integer): Integer;
    var
      I: Integer;
    begin
      Result := 0;
      for I := 0 to ACol - 1 do
        if NewWidths[I] = -1 then
          Inc(Result, ContentNonScaledWidths[I]);
    end;

    function GetAdvanceNewWidth: Integer;
    begin
      NonScaledOffset := ContentNonScaledOffset(I);
      NonScaledW := ContentNonScaledWidths[I];
      if Count = 1 then
        Result := AvailableSpace
      else
        Result :=
          MulDiv(NonScaledOffset + NonScaledW, AvailableSpace, NonScaledSize) -
          MulDiv(NonScaledOffset, AvailableSpace, NonScaledSize);
    end;

    procedure CheckWidths(ForMin: Boolean);
    begin
      I := 0;
      NonScaledOffset := 0;
      while I < Count do
      begin
        if NewWidths[I] = -1 then
        begin
          NonScaledW := ContentNonScaledWidths[I];
          W :=
            MulDiv(NonScaledOffset + NonScaledW, AvailableSpace, NonScaledSize) -
            MulDiv(NonScaledOffset, AvailableSpace, NonScaledSize);
          if ForMin then
            CheckW := ContentMinWidths[I]
          else
            CheckW := ContentMaxWidths[I];
          if ForMin and (W < CheckW) or not ForMin and (W > CheckW) then
          begin
            Dec(NonScaledSize, NonScaledW);
            Dec(AvailableSpace, CheckW);
            NewWidths[I] := CheckW;
            I := 0;
            NonScaledOffset := 0;
            Continue;
          end;
          Inc(NonScaledOffset, NonScaledW);
        end;
        Inc(I);
      end;
    end;

  begin
    if not FLevel.Visible then Exit;

    GetMem(NewWidths, Count * SizeOf(Integer));
    GetMem(ContentMinWidths, Count * SizeOf(Integer));
    try
      NonScaledSize := NonScaledWidth;
      AvailableSpace := VisibleWidth;
      if FLevel.HasExpandButton then
      begin
        Dec(NonScaledSize, LevelIndent);
        Dec(AvailableSpace, LevelIndent);
      end;
      for I := 0 to Count - 1 do
      begin
        W := HeaderWidths[I];
        Dec(NonScaledSize, W);
        Dec(AvailableSpace, W);
        ContentMinWidths[I] := Self.ContentMinWidths[I];
      end;
      if FixedColumn = nil then
        FixedCol := -1
      else
        FixedCol := FixedColumn.ColIndex;

      if (FixedCol <> -1) and (FixedCol = Count - 1) then
      begin
        FixedI1 := FixedCol;
        FixedI2 := FixedCol;
      end  
      else
      begin
        FixedI1 := 0;
        FixedI2 := FixedCol;
      end;
      for I := 0 to Count - 1 do
        if (FixedI1 <= I) and (I <= FixedI2) then
        begin
          NonScaledW := ContentNonScaledWidths[I];
          W := ContentWidths[I];
          Dec(NonScaledSize, NonScaledW);
          Dec(AvailableSpace, W);
          NewWidths[I] := W;
        end
        else
        begin
          W := GetAdvanceNewWidth;
          CheckW := ContentMinWidths[I];
          if W < CheckW then
          begin
            Dec(NonScaledSize, NonScaledW);
            Dec(AvailableSpace, CheckW);
            NewWidths[I] := CheckW;
          end
          else
            NewWidths[I] := -1;
        end;

      CheckWidths(True);
      CheckWidths(False);

      NonScaledOffset := 0;
      for I := 0 to Count - 1 do
      begin
        W := NewWidths[I];
        if W = -1 then
        begin
          NonScaledW := ContentNonScaledWidths[I];
          W :=
            MulDiv(NonScaledOffset + NonScaledW, AvailableSpace, NonScaledSize) -
            MulDiv(NonScaledOffset, AvailableSpace, NonScaledSize);
          Inc(NonScaledOffset, NonScaledW);
        end;    
        ContentInternalVisibleWidths[I] := W;
      end;
    finally
      FreeMem(ContentMinWidths, Count * SizeOf(Integer));
      FreeMem(NewWidths, Count * SizeOf(Integer));
    end;
  end;

  procedure CheckColumnsFreeWidths(UseVisibleValues: Boolean);
  var
    List: TList;
    I, J, K, MustBeOffset, FreeSpace, ASpace: Integer;
    Column: TdxMasterViewColumn;
  begin
    if FHorizontal then
    begin
      List := TList.Create;
      try
        for I := 0 to Count - 1 do
          for J := Items[I].Count - 1 downto 0 do
          begin
            Column := Columns[I, J];
            if Column.RowIndex = I then
            begin
              with Column do
                if UseVisibleValues then
                  MustBeOffset := LogicalOffset + VisibleWidth
                else
                  MustBeOffset := NonScaledLogicalOffset + NonScaledWidth;
              if HasRightNeighbours(Column, List, False) then
              begin
                FreeSpace := MaxInt;
                for K := 0 to List.Count - 1 do
                begin
                  with TdxMasterViewColumn(List[K]) do
                    if UseVisibleValues then
                      ASpace := LogicalOffset
                    else
                      ASpace := NonScaledLogicalOffset;
                  Dec(ASpace, MustBeOffset);
                  if ASpace < FreeSpace then FreeSpace := ASpace;
                end;
              end
              else
                if FLevel.OccupyRestSpace or UseVisibleValues then
                  FreeSpace := FVisibleWidth - MustBeOffset
                else
                  FreeSpace := 0;
              if UseVisibleValues then
                ASpace := Column.VisibleWidth
              else
                ASpace := Column.NonScaledWidth;
              Column.InternalVisibleWidth := ASpace + FreeSpace;
            end;
          end;
      finally
        List.Free;
      end;
    end
    else
      for I := 0 to Count - 1 do
        for J := 0 to Items[I].Count - 1 do
          with Columns[J, I] do
            if RowIndex = J then
              InternalVisibleWidth := ContentWidths[I];
  end;

begin
  if (FLevel.FAssignWidthsLockCount <> 0) and (FixedColumn = nil) or
    (FUpdateLockCount <> 0) or FLevel.IsLoading then Exit;
  CalcLogicalOffsets(1);
  if FHorizontal then CalcAddInWidths;
  CalcVisibleWidth;
  if FLevel.Control.AutoColumnWidth then
    if FHorizontal then
    begin
      CheckColumnsAutoWidthsWhenHorizontal;
      CalcLogicalOffsets(2);
      CheckColumnsFreeWidths(True);
    end
    else
    begin
      CheckColumnsAutoWidthsWhenVertical;
      CalcColWidths;
      CalcLogicalOffsets(2);
      CheckColumnsFreeWidths(False);
    end
  else
  begin
    CheckColumnsFreeWidths(False);
    CalcLogicalOffsets(2);
  end;
end;

procedure TdxMasterViewLayout.CheckCount;
var
  I: Integer;
begin
  if FUpdateLockCount <> 0 then Exit;
  for I := Count - 1 downto 0 do
    if Items[I].Count = 0 then Delete(I)
    else Break;
  for I := 0 to Count - 1 do
    if Items[0].Count = 0 then Delete(0)
    else Break;
end;

procedure TdxMasterViewLayout.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do Items[I].Clear;
end;

procedure TdxMasterViewLayout.ClearOptimizedValues;
var
  I: Integer;
begin
  for I := 0 to FLevel.VisibleColumnCount - 1 do
    with FLevel.VisibleColumns[I] do
    begin
      FLogicalOffset := -1;
      FLeftColumns.Clear;
      FRightColumns.Clear;
    end;
end;

function TdxMasterViewLayout.ColFromX(X: Integer): Integer;
begin
  if not FHorizontal then
    for Result := 0 to Count - 1 do
      if (ColOffsets[Result] <= X) and (X < ColOffsets[Result + 1]) then Exit;
  Result := -1;
end;

procedure TdxMasterViewLayout.CreateColArrays;
begin
  GetMem(FContentNonScaledWidths, Count * SizeOf(Integer));
  GetMem(FContentWidths, Count * SizeOf(Integer));
  GetMem(FHeaderWidths, Count * SizeOf(Integer));
  GetMem(FHeaderWidthAssigned, Count * SizeOf(Boolean));
  FillChar(FHeaderWidthAssigned^, Count * SizeOf(Boolean), 0);
end;

procedure TdxMasterViewLayout.Delete(Index: Integer);
var
  I, J: Integer;
begin
  Items[Index].Free;
  FLines.Delete(Index);
  if FHorizontal then FRowCount := Count;
  for I := Index to Count - 1 do
    for J := 0 to Items[I].Count - 1 do
      if FHorizontal then
        with Columns[I, J] do
          if FRowIndex = I + 1 then Dec(FRowIndex)
          else
      else
        with Columns[J, I] do
          if FColIndex = I + 1 then Dec(FColIndex);
end;

procedure TdxMasterViewLayout.DestroyColArrays;
begin
  if FContentNonScaledWidths <> nil then
  begin
    FreeMem(FContentNonScaledWidths);
    FContentNonScaledWidths := nil;
  end;
  if FContentWidths <> nil then
  begin
    FreeMem(FContentWidths);
    FContentWidths := nil;
  end;
  if FHeaderWidths <> nil then
  begin
    FreeMem(FHeaderWidths);
    FHeaderWidths := nil;
  end;
  if FHeaderWidthAssigned <> nil then
  begin
    FreeMem(FHeaderWidthAssigned);
    FHeaderWidthAssigned := nil;
  end;
end;

function TdxMasterViewLayout.HasLeftNeighbours(AColumn: TdxMasterViewColumn;
  AList: TList; ExactResult: Boolean): Boolean;
var
  I, J: Integer;
begin
  if (AColumn.FLeftColumns.Count = 0) or ExactResult then
  begin
    Result := False;
    if AList <> nil then AList.Clear;
    for I := AColumn.RowIndex to AColumn.RowIndex + AColumn.RowCount - 1 do
    begin
      J := Items[I].IndexOf(AColumn);
      if (J > 0) and AreNeighbours(Columns[I, J - 1], AColumn, ExactResult) then
      begin
        Result := True;
        if AList = nil then Exit
        else
          if AList.IndexOf(Columns[I, J - 1]) = -1 then  //!!!
            AList.Add(Columns[I, J - 1]);
      end;
    end;
  end
  else
  begin
    Result := True;
    if AList <> nil then
      with AColumn do
      begin
        AList.Count := FLeftColumns.Count;
        Move(FLeftColumns.List^, AList.List^, FLeftColumns.Count * SizeOf(Pointer));
      end;
  end;
end;
{
function TdxMasterViewLayout.HasLinkedColumns(AColumn: TdxMasterViewColumn;
  AList: TList): Boolean;
var
  List, LinkedColumns: TList;
  I, J: Integer;
begin
  Result := False;
  AList.Clear;
  List := TList.Create;
  LinkedColumns := TList.Create;
  try
    if HasRightNeighbours(AColumn, List, True) then
      for I := 0 to List.Count - 1 do
        if HasLeftNeighbours(List[I], LinkedColumns, True) then
        begin
          with AList do
            Capacity := Capacity + LinkedColumns.Count;
          for J := 0 to LinkedColumns.Count - 1 do
            if LinkedColumns[J] <> AColumn then
              AList.Add(LinkedColumns[J]);
        end
        else
    else
      if FLevel.OccupyRestSpace then
      begin
        RetrieveLastColumns(AList);
        for I := AList.Count - 1 downto 0 do
          if AList[I] = AColumn then AList.Delete(I);
      end
      else Exit;
  finally
    Result := AList.Count <> 0;
    LinkedColumns.Free;
    List.Free;
  end;
end;
}
function TdxMasterViewLayout.HasRightNeighbours(AColumn: TdxMasterViewColumn;
  AList: TList; ExactResult: Boolean): Boolean;
var
  I, J: Integer;
begin
  if (AColumn.FRightColumns.Count = 0) or ExactResult then
  begin
    Result := False;
    if AList <> nil then AList.Clear;
    for I := AColumn.RowIndex to AColumn.RowIndex + AColumn.RowCount - 1 do
    begin
      J := Items[I].IndexOf(AColumn);
      if (J < Items[I].Count - 1) and
        AreNeighbours(AColumn, Columns[I, J + 1], ExactResult) then
      begin
        Result := True;
        if AList = nil then Exit
        else
          if AList.IndexOf(Columns[I, J + 1]) = -1 then  //!!!
            AList.Add(Columns[I, J + 1]);
      end;
    end;
  end
  else
  begin
    Result := True;
    if AList <> nil then
      with AColumn do
      begin
        AList.Count := FRightColumns.Count;
        Move(FRightColumns.List^, AList.List^, FRightColumns.Count * SizeOf(Pointer));
      end;
  end;
end;

procedure TdxMasterViewLayout.HeaderWidthChanged;
begin
  FLevel.WidthChangedEx;
end;

procedure TdxMasterViewLayout.Insert(Index, ACount: Integer);
var
  I, J: Integer;
  PrevHeaderWidths: PIntArray;
  PrevHeaderWidthAssigned: PBoolArray;
begin
  for I := 0 to ACount - 1 do
    FLines.Insert(Index, TList.Create);
  for I := Count - 1 downto Index + ACount do
    for J := 0 to Items[I].Count - 1 do
      if FHorizontal then
        with Columns[I, J] do
          if FRowIndex = I - ACount then Inc(FRowIndex, ACount)
          else
      else
        with Columns[J, I] do
          if FColIndex = I - ACount then Inc(FColIndex, ACount);

  if FHorizontal then FRowCount := Count
  else
  begin
    PrevHeaderWidths := FHeaderWidths;
    PrevHeaderWidthAssigned := FHeaderWidthAssigned;
    FHeaderWidths := nil;
    FHeaderWidthAssigned := nil;
    DestroyColArrays;
    CreateColArrays;
    Move(PrevHeaderWidths^, FHeaderWidths^, Index * SizeOf(Integer));
    Move(PrevHeaderWidthAssigned^, FHeaderWidthAssigned^, Index * SizeOf(Boolean));
    I := Count - (Index + ACount);
    Move(PrevHeaderWidths[Index], FHeaderWidths[Index + ACount],
      I * SizeOf(Integer));
    Move(PrevHeaderWidthAssigned[Index], FHeaderWidthAssigned[Index + ACount],
      I * SizeOf(Boolean));
    FreeMem(PrevHeaderWidths);
    FreeMem(PrevHeaderWidthAssigned);
  end;
end;

procedure TdxMasterViewLayout.InsertAtPos(ARow, APos: Integer; AColumn: TdxMasterViewColumn);
var
  ACol{, AMinOffset, Delta, I, AvailSpace}: Integer;
begin
  ACol := GetNearestCol(ARow, APos);
{  while ACol <> 0 do
  begin
    with Columns[ARow, ACol - 1] do
      AMinOffset := MinLogicalOffset + VisibleMinWidth;
    if AMinOffset <= APos then
    begin
      with Columns[ARow, ACol - 1] do
        Delta := LogicalOffset + VisibleWidth - APos;
      if Delta > 0 then
        for I := ACol - 1 downto 0 do
        begin
          with Columns[ARow, I] do
            AvailSpace := VisibleWidth - VisibleMinWidth;
          if AvailSpace > Delta then AvailSpace := Delta;
          with Columns[ARow, I] do
            InternalVisibleWidth := VisibleWidth - AvailSpace;
          Dec(Delta, AvailSpace);
          if Delta = 0 then Break;
        end;
      Break;
    end
    else Dec(ACol);
  end;}
  Items[ARow].Insert(ACol, AColumn);
end;

procedure TdxMasterViewLayout.InsertColumn(ARow, ACol: Integer; AColumn: TdxMasterViewColumn);
var
  I, Offset: Integer;
begin
//  if not AColumn.Visible then Exit;
  if FHorizontal then
  begin
    RequireCount(ARow + AColumn.RowCount);
    if ACol > Items[ARow].Count then ACol := Items[ARow].Count;
    Offset := -1;
    BeginUpdate;  //!!!
    try
      for I := ARow to ARow + AColumn.RowCount - 1 do
        if I = ARow then Items[I].Insert(ACol, AColumn)
        else
        begin
          if Offset = -1 then
            Offset := AColumn.LogicalOffset;
          InsertAtPos(I, Offset, AColumn);
        end;
    finally
      EndUpdate;
    end;
  end
  else
  begin
    RequireCount(ACol + 1);
    ARow := GetNearestRow(ACol, ARow);
    //if ARow > Items[ACol].Count then ARow := Items[ACol].Count;
    BeginUpdate;  //!!!
    try
      for I := ARow to ARow + AColumn.RowCount - 1 do
        Items[ACol].Insert(I, AColumn);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxMasterViewLayout.InsertColumnAtPos(ARow, APos: Integer; AColumn: TdxMasterViewColumn);
var
  I: Integer;
begin
//  if not AColumn.Visible or not FHorizontal then Exit;
  RequireCount(ARow + AColumn.RowCount);
  for I := ARow to ARow + AColumn.RowCount - 1 do
    InsertAtPos(I, APos, AColumn);
end;

procedure TdxMasterViewLayout.InternalRemoveFreeSpace;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    if Items[I].Count = 0 then Delete(I);
end;

procedure TdxMasterViewLayout.RemoveColumn(AColumn: TdxMasterViewColumn);
var
  I: Integer;
begin
  with AColumn do
    if (RowIndex <> -1) and not IsLoading {FLevel} then
    begin
      Self.BeginUpdate;
      try
        if FHorizontal then
          for I := RowIndex to RowIndex + RowCount - 1 do
            Items[I].Remove(AColumn)
        else
          with Items[ColIndex] do
            for I := RowIndex + RowCount - 1 downto RowIndex do
              Delete(I);
      finally
        Self.EndUpdate;
      end;
    end;
//  CheckCount;
end;

procedure TdxMasterViewLayout.RetrieveLastColumns(AList: TList);
var
  I: Integer;
  Column: TdxMasterViewColumn;
begin
  AList.Clear;
  for I := 0 to Count - 1 do
    if Items[I].Count <> 0 then
    begin
      Column := Items[I].Last;
      if (AList.IndexOf(Column) = -1) and
        not HasRightNeighbours(Column, nil, True) then
        AList.Add(Column);
    end;
end;

function TdxMasterViewLayout.GetNearestCol(ARow, AOffset: Integer): Integer;
var
  CurOffset, I: Integer;
begin
  if ARow >= Count then Result := 0
  else
  begin
    Result := Items[ARow].Count;
    for I := 0 to Result - 1 do
    begin
      with Columns[ARow, I] do
        CurOffset := LogicalOffset;
      if AOffset <= CurOffset then
      begin
        Result := I;
        Break;
      end;
      with Columns[ARow, I] do
        Inc(CurOffset, VisibleWidth);
      if AOffset < CurOffset then
      begin
        Result := I + 1;
        Break;
      end;
    end;
  end;
end;

function TdxMasterViewLayout.GetNearestRow(ACol, ARow: Integer): Integer;
var
  ACount: Integer;
begin
  if ACol >= Count then Result := 0
  else
  begin
    ACount := Items[ACol].Count;
    if ARow >= ACount then Result := ACount
    else
    begin
      Result := ARow;
      while (Result < ACount) and (Columns[Result, ACol].RowIndex <> Result) do
        Inc(Result);
    end;
  end;
end;

procedure TdxMasterViewLayout.RequireCount(ACount: Integer);
begin
  if ACount > Count then Count := ACount;
end;

procedure TdxMasterViewLayout.ViewModeChanged;
var
  I: Integer;
begin
  FHorizontal := FLevel.Horizontal;
  BeginUpdate;
  try
    for I := Count - 1 downto 1 do Delete(I);
    if Count = 1 then Items[0].Clear;
    if FHorizontal then
    begin
      FRowCount := Count;
      for I := 0 to FLevel.VisibleColumnCount - 1 do
      begin
        FLevel.VisibleColumns[I].FRowIndex := 0;
        InsertColumn(0, Items[0].Count, FLevel.VisibleColumns[I]);
      end;
      DestroyColArrays;
    end
    else
    begin
      for I := 0 to FLevel.VisibleColumnCount - 1 do
      begin
        FLevel.VisibleColumns[I].FColIndex := 0;
        InsertColumn(Items[0].Count, 0, FLevel.VisibleColumns[I]);
      end;
      CreateColArrays;
    end;
    CalcAddInWidths;
  finally
    EndUpdate;
  end;
end;

procedure TdxMasterViewLayout.BeginUpdate;
begin
  if FUpdateLockCount = 0 then ClearOptimizedValues;
  Inc(FUpdateLockCount);
end;

procedure TdxMasterViewLayout.CancelUpdate;
begin
  if FUpdateLockCount > 0 then
  begin
    Dec(FUpdateLockCount);
    if FUpdateLockCount = 0 then CalcOptimizedValues;
  end;
end;

procedure TdxMasterViewLayout.ChangeCol(AColumn: TdxMasterViewColumn; ACol: Integer);
var
  ARow: Integer;
begin
  if ACol < 0 then ACol := 0;
  if AColumn.Visible and not FLevel.IsLoading then
  begin
    BeginUpdate;
    try
      ARow := AColumn.RowIndex;
      RemoveColumn(AColumn);
      if FHorizontal then
        if ACol > Items[AColumn.RowIndex].Count then
          ACol := Items[AColumn.RowIndex].Count
        else
      else
        if ACol > Count then ACol := Count;
      AColumn.FColIndex := ACol;
      if FHorizontal then
        ARow := AColumn.RowIndex
      else
        if ACol = Count then
          ARow := 0
        else
          //ARow := Items[ACol].Count;
        begin
          if ARow < 0 then ARow := 0;
          if ARow > Items[ACol].Count then
            ARow := Items[ACol].Count;
        end;
      InsertColumn(ARow, ACol, AColumn);
    finally
      EndUpdate;
    end;
  end
  else
    AColumn.FColIndex := ACol;
end;

procedure TdxMasterViewLayout.ChangeHeaderWidth(ACol: Integer; Value: Integer;
  FixCol: Boolean);
var
  MarginValue: Integer;
begin
  MarginValue := HeaderMinWidths[ACol];
  if Value < MarginValue then Value := MarginValue;
  MarginValue := HeaderMaxWidths[ACol];
  if Value > MarginValue then Value := MarginValue;
  if FixCol then
  begin
    MarginValue := HeaderDynamicMinWidths[ACol];
    if Value < MarginValue then Value := MarginValue;
    MarginValue := HeaderDynamicMaxWidths[ACol];
    if Value > MarginValue then Value := MarginValue;
  end;
  if FHeaderWidths[ACol] <> Value then
  begin
    FHeaderWidths[ACol] := Value;
    HeaderWidthAssigned[ACol] := True;
    if FixCol and (ACol > 0) and FLevel.Control.AutoColumnWidth then
    begin
      CheckColumnsWidths(Columns[0, ACol - 1]);
      with FLevel do
      begin
        BeginAssignWidths;
        try
          AssignColumnWidths;
        finally
          CancelAssignWidths;
        end;
      end;
    end;
    HeaderWidthChanged;
  end;
end;

procedure TdxMasterViewLayout.ChangeRow(AColumn: TdxMasterViewColumn; ARow: Integer;
  FixedPos: Boolean);
var
  APos: Integer;
begin
  if ARow < 0 then ARow := 0;
  if AColumn.Visible and not FLevel.IsLoading then
  begin
    if FHorizontal and (ARow > Count) then
      ARow := Count;
    if AColumn.RowIndex <> ARow then
    begin
      BeginUpdate;
      try
        if FHorizontal then
          if FixedPos then
            APos := AColumn.LogicalOffset
          else
            APos := GetNearestCol(ARow, AColumn.LogicalOffset)
        else
          APos := AColumn.ColIndex;
        RemoveColumn(AColumn);
        if not FHorizontal then
          ARow := GetNearestRow(APos, ARow);
        AColumn.FRowIndex := ARow;
        if FHorizontal and FixedPos then
          InsertColumnAtPos(ARow, APos, AColumn)
        else
          InsertColumn(ARow, APos, AColumn);
      finally
        EndUpdate;
      end;
    end;
  end
  else
    AColumn.FRowIndex := ARow;
end;

procedure TdxMasterViewLayout.ChangeRowAndRowCount(AColumn: TdxMasterViewColumn;
  ARow, ARowCount: Integer; FixedPos: Boolean);
var
  APos: Integer;
begin
  if ARow < 0 then ARow := 0;
  AColumn.CheckRowCount(ARowCount);
  if AColumn.Visible and not FLevel.IsLoading then
  begin
    if FHorizontal and (ARow > Count) then
      ARow := Count;
    if (AColumn.RowIndex <> ARow) or (AColumn.RowCount <> ARowCount) then
    begin
      BeginUpdate;
      try
        if FHorizontal then
          if FixedPos then
            APos := AColumn.LogicalOffset
          else
            APos := GetNearestCol(ARow, AColumn.LogicalOffset)
        else
          APos := AColumn.ColIndex;
        RemoveColumn(AColumn);
        if not FHorizontal then
          ARow := GetNearestRow(APos, ARow);
        with AColumn do
        begin
          FRowIndex := ARow;
          FRowCount := ARowCount;
        end;
        if FHorizontal and FixedPos then
          InsertColumnAtPos(ARow, APos, AColumn)
        else
          InsertColumn(ARow, APos, AColumn);
      finally
        EndUpdate;
      end;
    end;
  end
  else
    with AColumn do
    begin
      FRowIndex := ARow;
      FRowCount := ARowCount;
    end;
end;

procedure TdxMasterViewLayout.ChangeRowCount(AColumn: TdxMasterViewColumn; ARowCount: Integer);
var
  I, AOffset: Integer;
begin
  with AColumn do
  begin
    CheckRowCount(ARowCount);
    if RowCount <> ARowCount then
    begin
      if Visible and not FLevel.IsLoading then
      begin
        Self.BeginUpdate;
        try
          if ARowCount < RowCount then
            for I := RowIndex + RowCount - 1 downto RowIndex + ARowCount do
              if FHorizontal then
                Self.Items[I].Remove(AColumn)
              else  
                Self.Items[ColIndex].Delete(I)
          else
          begin
            if FHorizontal then
            begin
              RequireCount(RowIndex + ARowCount);
              AOffset := LogicalOffset;
            end
            else
              AOffset := 0;
            for I := RowIndex + RowCount to RowIndex + ARowCount - 1 do
              if FHorizontal then
                Self.InsertAtPos(I, AOffset, AColumn)
              else
                Self.Items[ColIndex].Insert(I, AColumn);
          end;
          FRowCount := ARowCount;
        finally
          Self.EndUpdate;
        end;
      end
      else
        FRowCount := ARowCount;
    end;
  end;
end;

procedure TdxMasterViewLayout.EndUpdate;
begin
  if FUpdateLockCount > 0 then
  begin
    Dec(FUpdateLockCount);
    if FUpdateLockCount = 0 then
    begin
      if FHorizontal then
        CheckCount
      else
        InternalRemoveFreeSpace;
      FLevel.WidthChangedEx;
    end;
  end;
end;

function TdxMasterViewLayout.GetBestFitWidth(ACol: Integer): Integer;
var
  I, AValue: Integer;
begin
  Result := 0;
  for I := 0 to Items[ACol].Count - 1 do
    with Columns[I, ACol] do
      if RowIndex = I then
      begin
        AValue := GetBestFitWidth;
        if AValue > Result then Result := AValue;
      end;
end;

function TdxMasterViewLayout.IndexOf(AColumn: TdxMasterViewColumn; ALine: Integer): Integer;
begin
  if (ALine < 0) or (ALine >= Count) then
    Result := -1
  else
    Result := TList(FLines[ALine]).IndexOf(AColumn);
end;

function TdxMasterViewLayout.IsColumnFirst(AColumn: TdxMasterViewColumn): Boolean;
begin
  if FHorizontal then
    Result := not HasLeftNeighbours(AColumn, nil, True)
  else
    Result := AColumn.RowIndex = 0;//IndexOf(AColumn, AColumn.ColIndex) = 0;
end;

function TdxMasterViewLayout.IsColumnLast(AColumn: TdxMasterViewColumn): Boolean;
begin
  if FHorizontal then
    Result := not HasRightNeighbours(AColumn, nil, True)
  else
    with AColumn do
      Result := RowIndex + RowCount = Self.Items[ColIndex].Count;
end;

function TdxMasterViewLayout.OneOnLine(AColumn: TdxMasterViewColumn): Boolean;
var
  I: Integer;
begin
  if FHorizontal then
  begin
    Result := False;
    with AColumn do
      for I := RowIndex to RowIndex + RowCount - 1 do
        if Self.Items[I].Count <> 1 then Exit;
    Result := True;
  end
  else
    with AColumn do
      Result := RowCount = Self.Items[ColIndex].Count;
end;

procedure TdxMasterViewLayout.RemoveFreeSpace;
begin
  BeginUpdate;
  try
    InternalRemoveFreeSpace;
  finally
    EndUpdate;
  end;
end;

{ TdxMasterViewLevel }

constructor TdxMasterViewLevel.Create(AOwner: TComponent);
begin
  inherited;
  FAbsoluteIndex := -1;
  FCanUseSmartReload := True;
  FColumns := TList.Create;
  FDataLink := TdxMasterViewDataLink.Create(Self);
  FDeleteConfirmCaptionText := LoadStr(dxsMVDeleteConfirmCaptionText);
  FDeleteConfirmText := LoadStr(dxsMVDeleteConfirmText);
  FDetailKeyFields := TList.Create;
  FExtLineWidth := DefaultLineWidth;
  FGridLinesColor := clBtnShadow;
  FGroupColumns := TList.Create;
  FHorizontal := True;
  FIDFields := TList.Create;
  FIndex := -1;
  FItems := TList.Create;
  FLayout := TdxMasterViewLayout.Create(Self);
  FLevelSeparatorColor := clWindowText;
  FLineWidth := DefaultLineWidth;
  FMasterKeyFields := TList.Create;
  FMultipleDeleteConfirmText := LoadStr(dxsMVMultipleDeleteConfirmText);
  FOptionsBehavior :=
    [lobDblClkExpanding];
  FOptionsCustomize :=
    [locColumnMoving, locColumnHorSizing, locColumnVerSizing, locColumnSorting,
     locColumnGrouping, locShowColumnOnUngrouping];
  FOptionsCustomizeBox :=
    [loxCaption, loxColumns, loxGrid, loxGroupByBox, loxHeader, loxViewMode];
  FOptionsDB :=
    [lodConfirmDelete, lodSmartLoad, lodSmartReload];
  FOptionsHeader :=
    [lohForFirstNode, lohForFirstVisibleNode, lohAfterExpandedNode];
  FOptionsView :=
    [lovGrid, lovGridWithPreview, lovHeader, lovOccupyRestSpace];
  FPreviewLeftIndent := dxMVPreviewLeftIndent;
  FPreviewMaxLineCount := dxMVPreviewMaxLineCount;
  FPreviewRightIndent := dxMVPreviewRightIndent;
  FRowSeparatorColor := clBtnShadow;
  FSortedColumns := TList.Create;
  FSummaryColumns := TList.Create;
  FVisibleColumns := TList.Create;
  CalcParents;
end;

destructor TdxMasterViewLevel.Destroy;
begin
  Destroying;
  if FParent <> nil then FParent.RemoveItem(Self);
  DestroyColumns;
  Clear;
  HeaderStyle := nil;
  ContentStyle := nil;
  FooterStyle := nil;
  PreviewStyle := nil;
  CaptionStyle := nil;
  GroupStyle := nil;
  GroupByBoxStyle := nil;
  Finalize(FParents);
  FParentCount := 0;
  FMasterKeyFields.Free;
  FLayout.Free;
  FIDFields.Free;
  FGroupColumns.Free;
  FDetailKeyFields.Free;
  FDataLink.Free;
  FVisibleColumns.Free;
  FSummaryColumns.Free;
  FSortedColumns.Free;
  FItems.Free;
  FColumns.Free;
  inherited;
end;

function TdxMasterViewLevel.GetActive: Boolean;
begin
  Result :=
    (FParent = nil) or
    (DataSet <> nil) and DataSet.Active and (IDFieldCount <> 0) and
    (DontFilterRecords or
     (DetailKeyFieldCount <> 0) and (DetailKeyFieldCount = MasterKeyFieldCount));
end;

function TdxMasterViewLevel.GetCaptionBrush: HBRUSH;
begin
  if (CaptionStyle <> nil) and (svColor in CaptionStyle.AssignedValues) then
    Result := CaptionStyle.Brush
  else
    Result := GetSysColorBrush(COLOR_BTNFACE);//FControl.CaptionBrush;
end;

function TdxMasterViewLevel.GetCaptionColor: TColor;
begin
  if (CaptionStyle <> nil) and (svColor in CaptionStyle.AssignedValues) then
    Result := CaptionStyle.Color
  else
    Result := clBtnFace;//FControl.CaptionColor;
end;

function TdxMasterViewLevel.GetCaptionFont: TFont;
begin
  if (CaptionStyle <> nil) and (svFont in CaptionStyle.AssignedValues) then
    Result := CaptionStyle.Font
  else
    Result := FControl.Font;//FControl.CaptionFont;
end;

function TdxMasterViewLevel.GetColumn(Index: Integer): TdxMasterViewColumn;
begin
  Result := TdxMasterViewColumn(FColumns[Index]);
end;

function TdxMasterViewLevel.GetColumnCount: Integer;
begin
  Result := FColumns.Count;
end;

function TdxMasterViewLevel.GetContentAnotherBrush: HBRUSH;
begin
  if (ContentStyle <> nil) and (svAnotherColor in ContentStyle.AssignedValues) then
    Result := ContentStyle.AnotherBrush
  else
    Result := 0;
end;

function TdxMasterViewLevel.GetContentAnotherColor: TColor;
begin
  if (ContentStyle <> nil) and (svAnotherColor in ContentStyle.AssignedValues) then
    Result := ContentStyle.AnotherColor
  else
    Result := clNone;
end;

function TdxMasterViewLevel.GetContentBrush: HBRUSH;
begin
  if (ContentStyle <> nil) and (svColor in ContentStyle.AssignedValues) then
    Result := ContentStyle.Brush
  else
    Result := FControl.Brush.Handle;
end;

function TdxMasterViewLevel.GetContentColor: TColor;
begin
  if (ContentStyle <> nil) and (svColor in ContentStyle.AssignedValues) then
    Result := ContentStyle.Color
  else
    Result := FControl.Color;
end;

function TdxMasterViewLevel.GetContentFont: TFont;
begin
  if (ContentStyle <> nil) and (svFont in ContentStyle.AssignedValues) then
    Result := ContentStyle.Font
  else
    Result := FControl.Font;
end;

function TdxMasterViewLevel.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxMasterViewLevel.GetDataSet: TDataSet;
begin
  Result := FDataLink.DataSet;
end;

function TdxMasterViewLevel.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TdxMasterViewLevel.GetDetailKeyField(Index: Integer): TField;
begin
  Result := TField(FDetailKeyFields[Index]);
end;

function TdxMasterViewLevel.GetDetailKeyFieldCount: Integer;
begin
  Result := FDetailKeyFields.Count;
end;

function TdxMasterViewLevel.GetDontFilterRecords: Boolean;
begin
  Result := IsTop or (lodDontFilterRecords in FOptionsDB);
end;

function TdxMasterViewLevel.GetFooterBrush: HBRUSH;
begin
  if (FooterStyle <> nil) and (svColor in FooterStyle.AssignedValues) then
    Result := FooterStyle.Brush
  else
    Result := GetSysColorBrush(COLOR_BTNFACE);
end;

function TdxMasterViewLevel.GetFooterColor: TColor;
begin
  if (FooterStyle <> nil) and (svColor in FooterStyle.AssignedValues) then
    Result := FooterStyle.Color
  else
    Result := clBtnFace;
end;

function TdxMasterViewLevel.GetFooterFont: TFont;
begin
  if (FooterStyle <> nil) and (svFont in FooterStyle.AssignedValues) then
    Result := FooterStyle.Font
  else
    Result := FControl.Font;
end;

function TdxMasterViewLevel.GetGroupBrush: HBRUSH;
begin
  if (GroupStyle <> nil) and (svColor in GroupStyle.AssignedValues) then
    Result := GroupStyle.Brush
  else
    Result := GetSysColorBrush(COLOR_BTNFACE);
end;

function TdxMasterViewLevel.GetGroupByBoxBrush: HBRUSH;
begin
  if (GroupByBoxStyle <> nil) and (svColor in GroupByBoxStyle.AssignedValues) then
    Result := GroupByBoxStyle.Brush
  else
    Result := GetSysColorBrush(COLOR_BTNSHADOW);
end;

function TdxMasterViewLevel.GetGroupByBoxColor: TColor;
begin
  if (GroupByBoxStyle <> nil) and (svColor in GroupByBoxStyle.AssignedValues) then
    Result := GroupByBoxStyle.Color
  else
    Result := clBtnShadow;
end;

function TdxMasterViewLevel.GetGroupByBoxFont: TFont;
begin
  if (GroupByBoxStyle <> nil) and (svFont in GroupByBoxStyle.AssignedValues) then
    Result := GroupByBoxStyle.Font
  else
    Result := FControl.Font;
end;

function TdxMasterViewLevel.GetGroupByBoxFontColor: TColor;
begin
  if (GroupByBoxStyle <> nil) and (svFont in GroupByBoxStyle.AssignedValues) then
    Result := GroupByBoxStyle.Font.Color
  else
    Result := clBtnFace;
end;

function TdxMasterViewLevel.GetGroupByBoxHeight: Integer;
begin
  Result := GroupColumnCount;
  if Result = 0 then
    Result := 2 * GroupByBoxTopOffset + GroupByBoxTextHeight
  else
    Result := 2 * GroupByBoxTopOffset +
      HeaderRealHeight div 2 * (Result + 1) + Byte(Odd(HeaderRealHeight)) +
      (Result - 1) * GroupByBoxVerOffset;
end;

function TdxMasterViewLevel.GetGroupColor: TColor;
begin
  if (GroupStyle <> nil) and (svColor in GroupStyle.AssignedValues) then
    Result := GroupStyle.Color
  else
    Result := clBtnFace;
end;

function TdxMasterViewLevel.GetGroupColumn(Index: Integer): TdxMasterViewColumn;
begin
  Result := FGroupColumns[Index];
end;

function TdxMasterViewLevel.GetGroupColumnCount: Integer;
begin
  Result := FGroupColumns.Count;
end;

function TdxMasterViewLevel.GetGroupFont: TFont;
begin
  if (GroupStyle <> nil) and (svFont in GroupStyle.AssignedValues) then
    Result := GroupStyle.Font
  else
    Result := FControl.Font;
end;

function TdxMasterViewLevel.GetHasChildren: Boolean;
begin
  Result := FItems.Count <> 0;
end;

function TdxMasterViewLevel.GetHeaderBrush: HBRUSH;
begin
  if (HeaderStyle <> nil) and (svColor in HeaderStyle.AssignedValues) then
    Result := HeaderStyle.Brush
  else
    Result := GetSysColorBrush(COLOR_BTNFACE);
end;

function TdxMasterViewLevel.GetHeaderColor: TColor;
begin
  if (HeaderStyle <> nil) and (svColor in HeaderStyle.AssignedValues) then
    Result := HeaderStyle.Color
  else
    Result := clBtnFace;
end;

function TdxMasterViewLevel.GetHeaderFont: TFont;
begin
  if (HeaderStyle <> nil) and (svFont in HeaderStyle.AssignedValues) then
    Result := HeaderStyle.Font
  else
    Result := FControl.Font;
end;

function TdxMasterViewLevel.GetHeaderRestSpaceBrush: HBRUSH;
begin
  if (HeaderStyle <> nil) and (svAnotherColor in HeaderStyle.AssignedValues) then
    Result := HeaderStyle.AnotherBrush
  else
    Result := GetSysColorBrush(COLOR_BTNSHADOW);
end;

function TdxMasterViewLevel.GetHeaderRestSpaceColor: TColor;
begin
  if (HeaderStyle <> nil) and (svAnotherColor in HeaderStyle.AssignedValues) then
    Result := HeaderStyle.AnotherColor
  else
    Result := clBtnShadow;
end;

function TdxMasterViewLevel.GetIDField(Index: Integer): TField;
begin
  Result := TField(FIDFields[Index]);
end;

function TdxMasterViewLevel.GetIDFieldCount: Integer;
begin
  Result := FIDFields.Count;
end;

function TdxMasterViewLevel.GetIndent: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := ParentCount - 2 downto 0 do
    with Parents[I] do
    begin
      if ShowCaption then
        Inc(Result, LevelIndent + ExtLineWidth);
      Inc(Result, GroupColumnCount * (LevelIndent + ExtLineWidth));
      if I = 0 then Break;
      Inc(Result, LevelIndent + ExtLineWidth + LevelSeparatorWidth);
    end;
end;

function TdxMasterViewLevel.GetIsDestroying: Boolean;
var
  I: Integer;
begin
  Result := csDestroying in ComponentState;
  if not Result then
    for I := 1 to ParentCount - 1 do
    begin
      Result := csDestroying in Parents[I].ComponentState;
      if Result then Break;
    end;
end;

function TdxMasterViewLevel.GetIsFirst: Boolean;
begin
  Result := Index = 0;
end;

function TdxMasterViewLevel.GetIsLast: Boolean;
begin
  Result := Index = FParent.Count - 1;
end;

function TdxMasterViewLevel.GetIsLoading: Boolean;
begin
  Result := (csLoading in ComponentState) or (FLoadingLockCount <> 0);
end;

function TdxMasterViewLevel.GetIsTop: Boolean;
begin
  Result := FParent.Parent = nil;
end;

function TdxMasterViewLevel.GetItem(Index: Integer): TdxMasterViewLevel;
begin
  Result := FItems[Index];
end;

function TdxMasterViewLevel.GetMasterKeyField(Index: Integer): TField;
begin
  Result := TField(FMasterKeyFields[Index]);
end;

function TdxMasterViewLevel.GetMasterKeyFieldCount: Integer;
begin
  Result := FMasterKeyFields.Count;
end;

function TdxMasterViewLevel.GetNonScaledWidth: Integer;
begin
  Result := FLayout.NonScaledWidth;
end;

function TdxMasterViewLevel.GetOccupyRestSpace: Boolean;
begin
  Result := lovOccupyRestSpace in FOptionsView;
end;

function TdxMasterViewLevel.GetParent(Index: Integer): TdxMasterViewLevel;
begin
  Result := FParents[Index];
end;

function TdxMasterViewLevel.GetPreviewAnotherBrush: HBRUSH;
begin
  if (PreviewStyle <> nil) and (svAnotherColor in PreviewStyle.AssignedValues) then
    Result := PreviewStyle.AnotherBrush
  else
    Result := ContentAnotherBrush;
end;

function TdxMasterViewLevel.GetPreviewAnotherColor: TColor;
begin
  if (PreviewStyle <> nil) and (svAnotherColor in PreviewStyle.AssignedValues) then
    Result := PreviewStyle.AnotherColor
  else
    Result := ContentAnotherColor;
end;

function TdxMasterViewLevel.GetPreviewBrush: HBRUSH;
begin
  if (PreviewStyle <> nil) and (svColor in PreviewStyle.AssignedValues) then
    Result := PreviewStyle.Brush
  else
    Result := ContentBrush;
end;

function TdxMasterViewLevel.GetPreviewColor: TColor;
begin
  if PreviewColorAssigned then
    Result := PreviewStyle.Color
  else
    Result := ContentColor;
end;

function TdxMasterViewLevel.GetPreviewColorAssigned: Boolean;
begin
  Result := (PreviewStyle <> nil) and (svColor in PreviewStyle.AssignedValues);
end;

function TdxMasterViewLevel.GetPreviewFont: TFont;
begin
  if PreviewFontAssigned then
    Result := PreviewStyle.Font
  else
    Result := ContentFont;
end;

function TdxMasterViewLevel.GetPreviewFontAssigned: Boolean;
begin
  Result := (PreviewStyle <> nil) and (svFont in PreviewStyle.AssignedValues);
end;

function TdxMasterViewLevel.GetPreviewFontColor: TColor;  //!!!
begin
  if PreviewFontAssigned then
    Result := PreviewStyle.Font.Color
  else
    Result := clBlue;
end;

function TdxMasterViewLevel.GetRowCount: Integer;
begin
  Result := FLayout.RowCount;
end;

function TdxMasterViewLevel.GetShowCaption: Boolean;
begin
  Result := lovCaption in FOptionsView;
end;

function TdxMasterViewLevel.GetShowFooter: Boolean;
begin
  Result := lovFooter in FOptionsView;
end;

function TdxMasterViewLevel.GetShowGrid: Boolean;
begin
  Result := lovGrid in FOptionsView;
end;

function TdxMasterViewLevel.GetShowGridWithPreview: Boolean;
begin
  Result := lovGridWithPreview in FOptionsView;
end;

function TdxMasterViewLevel.GetShowGroupByBox: Boolean;
begin
  Result := lovGroupByBox in FOptionsView;
end;

function TdxMasterViewLevel.GetShowHeader: Boolean;
begin
  Result := lovHeader in FOptionsView;
end;

function TdxMasterViewLevel.GetShowPreview: Boolean;
begin
  Result := lovPreview in FOptionsView;
end;

function TdxMasterViewLevel.GetSmartLoad: Boolean;
begin
  Result := lodSmartLoad in FOptionsDB;
end;

function TdxMasterViewLevel.GetSmartReload: Boolean;
begin
  Result := (lodSmartReload in FOptionsDB) and FCanUseSmartReload;
end;

function TdxMasterViewLevel.GetSortedColumn(Index: Integer): TdxMasterViewColumn;
begin
  Result := TdxMasterViewColumn(FSortedColumns[Index]);
end;

function TdxMasterViewLevel.GetSortedColumnCount: Integer;
begin
  Result := FSortedColumns.Count;
end;

function TdxMasterViewLevel.GetVisibleColumn(Index: Integer): TdxMasterViewColumn;
begin
  Result := TdxMasterViewColumn(FVisibleColumns[Index]);
end;

function TdxMasterViewLevel.GetVisibleColumnCount: Integer;
begin
  Result := FVisibleColumns.Count;
end;

function TdxMasterViewLevel.GetVisibleRowCount: Integer;
begin
  Result := FLayout.RowCount;
  if Result = 0 then Result := 1;
end;

function TdxMasterViewLevel.GetVisibleWidth: Integer;
begin
  Result := FLayout.VisibleWidth;
end;

procedure TdxMasterViewLevel.SetCaptionStyle(Value: TdxMasterViewStyle);
begin
  if FCaptionStyle <> Value then
  begin
    if FCaptionStyle <> nil then
      FCaptionStyle.RemoveConsumeType(Self, sctCaption);
    FCaptionStyle := Value;
    if FCaptionStyle <> nil then
      FCaptionStyle.AddConsumeType(Self, sctCaption);
    CaptionStyleChanged([]);
  end;
end;

procedure TdxMasterViewLevel.SetColumn(Index: Integer; Value: TdxMasterViewColumn);
begin
  Columns[Index].Assign(Value);
end;

procedure TdxMasterViewLevel.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if ShowCaption then LevelChanged(False);
    if dxMVDesigner <> nil then dxMVDesigner.Changed(FControl, [rcLevels]);
  end;
end;

procedure TdxMasterViewLevel.SetContentStyle(Value: TdxMasterViewStyle);
begin
  if FContentStyle <> Value then
  begin
    if FContentStyle <> nil then
      FContentStyle.RemoveConsumeType(Self, sctContent);
    FContentStyle := Value;
    if FContentStyle <> nil then
      FContentStyle.AddConsumeType(Self, sctContent);
    ContentStyleChanged([]);
  end;
end;

procedure TdxMasterViewLevel.SetDataSource(Value: TDataSource);
var
  PrevActive: Boolean;
begin
  if DataSource <> Value then
  begin
    PrevActive := Active;
    FDataLink.DataSource := Value;
    if Value <> nil then Value.FreeNotification(Self);
    if PrevActive or Active then
    begin
      FCanUseSmartReload := False;
      LevelChanged(True);
    end;
  end;
end;

procedure TdxMasterViewLevel.SetDetailKey(const Value: string);
var
  PrevActive: Boolean;
begin
  if FDetailKey <> Value then
  begin
    PrevActive := Active;
    FDetailKey := Value;
    RefreshDetailKeyFieldsList;
    if PrevActive or Active then
    begin
      FCanUseSmartReload := False;
      LevelChanged(True);
    end;
  end;
end;

procedure TdxMasterViewLevel.SetFooterStyle(Value: TdxMasterViewStyle);
begin
  if FFooterStyle <> Value then
  begin
    if FFooterStyle <> nil then
      FFooterStyle.RemoveConsumeType(Self, sctFooter);
    FFooterStyle := Value;
    if FFooterStyle <> nil then
      FFooterStyle.AddConsumeType(Self, sctFooter);
    FooterStyleChanged([]);
  end;
end;

procedure TdxMasterViewLevel.SetGridLinesColor(Value: TColor);
begin
  if FGridLinesColor <> Value then
  begin
    FGridLinesColor := Value;
    LevelChanged(False);
  end;
end;

procedure TdxMasterViewLevel.SetGroupByBoxStyle(Value: TdxMasterViewStyle);
begin
  if FGroupByBoxStyle <> Value then
  begin
    if FGroupByBoxStyle <> nil then
      FGroupByBoxStyle.RemoveConsumeType(Self, sctGroupByBox);
    FGroupByBoxStyle := Value;
    if FGroupByBoxStyle <> nil then
      FGroupByBoxStyle.AddConsumeType(Self, sctGroupByBox);
    GroupByBoxStyleChanged([]);
  end;
end;

procedure TdxMasterViewLevel.SetGroupStyle(Value: TdxMasterViewStyle);
begin
  if FGroupStyle <> Value then
  begin
    if FGroupStyle <> nil then
      FGroupStyle.RemoveConsumeType(Self, sctGroup);
    FGroupStyle := Value;
    if FGroupStyle <> nil then
      FGroupStyle.AddConsumeType(Self, sctGroup);
    GroupStyleChanged([]);
  end;
end;

procedure TdxMasterViewLevel.SetHeaderStyle(Value: TdxMasterViewStyle);
begin
  if FHeaderStyle <> Value then
  begin
    if FHeaderStyle <> nil then
      FHeaderStyle.RemoveConsumeType(Self, sctHeader);
    FHeaderStyle := Value;
    if FHeaderStyle <> nil then
      FHeaderStyle.AddConsumeType(Self, sctHeader);
    HeaderStyleChanged([]);
  end;
end;

procedure TdxMasterViewLevel.SetID(Value: string);
var
  PrevActive: Boolean;
begin
  if FID <> Value then
  begin
    PrevActive := Active;
    FID := Value;
    RefreshIDFieldsList;
    if PrevActive or Active then
    begin
      FCanUseSmartReload := False;
      LevelChanged(True);
    end;
  end;
end;

procedure TdxMasterViewLevel.SetLevelSeparatorColor(Value: TColor);
begin
  if FLevelSeparatorColor <> Value then
  begin
    FLevelSeparatorColor := Value;
    if FLevelSeparatorWidth <> 0 then LevelChanged(False);
  end;
end;

procedure TdxMasterViewLevel.SetLevelSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FLevelSeparatorWidth <> Value then
  begin
    FLevelSeparatorWidth := Value;
    LevelChanged(False);
  end;
end;

procedure TdxMasterViewLevel.SetMasterKey(const Value: string);
var
  PrevActive: Boolean;
begin
  if FMasterKey <> Value then
  begin
    PrevActive := Active;
    FMasterKey := Value;
    RefreshMasterKeyFieldsList;
    if not IsTop then
      with FParent do
      begin
        FCanUseSmartReload := False;
        LevelChanged(True);
      end;
    if PrevActive or Active then
    begin
      FCanUseSmartReload := False;
      LevelChanged(True);
    end;
  end;
end;

procedure TdxMasterViewLevel.SetOptionsDB(Value: TdxMasterViewLevelOptionsDB);
var
  ChangedValues: TdxMasterViewLevelOptionsDB;
begin
  if FOptionsDB <> Value then
  begin
    Byte(ChangedValues) := Byte(Value) xor Byte(FOptionsDB);

    FOptionsDB := Value;

    if lodDontFilterRecords in ChangedValues then
    begin
      FCanUseSmartReload := False;
      LevelChanged(True);
    end;

    if lodSmartLoad in ChangedValues then
      if FControl <> nil then
        with FControl do
        begin
          BeginUpdate;
          try
            Items.DoSmartLoadChanged(Self);
          finally
            EndUpdate;
          end;
        end;
  end;
end;

procedure TdxMasterViewLevel.SetOptionsHeader(Value: TdxMasterViewLevelOptionsHeader);
begin
  if FOptionsHeader <> Value then
  begin
    FOptionsHeader := Value;
    LevelChanged(False);
  end;
end;

procedure TdxMasterViewLevel.SetOptionsView(Value: TdxMasterViewLevelOptionsView);
var
  ChangedValues: TdxMasterViewLevelOptionsView;
begin
  if FOptionsView <> Value then
  begin
    Word(ChangedValues) := Word(Value) xor Word(FOptionsView);

    if lovPreview in ChangedValues then
      if not (lovPreview in Value) then PreviewChanged;

    FOptionsView := Value;

    if lovCaption in ChangedValues then
    begin
      WidthChanged;
      LevelChanged(True);
    end;
    if [lovFooter, lovGroupByBox, lovNoButtonsWhenNoChildren] * ChangedValues <> [] then
      LevelChanged(False);
    if lovGrid in ChangedValues then
    begin
      FExtLineWidth := DefaultLineWidth * Byte(ShowGrid);
      CalcLineWidth;
      if ShowPreview then
        PreviewChanged
      else
        LevelChanged(False);
    end;
    if lovGridWithPreview in ChangedValues then
      if ShowPreview then
      begin
        CalcLineWidth;
        PreviewChanged;
      end;
    if lovHeader in ChangedValues then
    begin
      CalcDefaultWidths(nil);
      if not FHorizontal then WidthChanged;
      LevelChanged(False);
    end;
    if lovPreview in ChangedValues then
    begin
      CalcLineWidth;
      if lovPreview in FOptionsView then LevelChanged(False);
    end;
    if lovOccupyRestSpace in ChangedValues then
      if not FControl.AutoColumnWidth then
      begin
        FLayout.CheckColumnsWidths(nil);
        LevelChanged(False);
      end;
  end;
end;

procedure TdxMasterViewLevel.SetPreviewField(Value: TField);
begin
  if FPreviewField <> Value then
  begin
    SetPreviewFieldInternally(Value);
    PreviewChanged;
    if Active then
    begin
      FCanUseSmartReload := False;
      LevelChanged(True);
    end;
  end;
end;

procedure TdxMasterViewLevel.SetPreviewFieldInternally(Value: TField);
begin
  if FPreviewField <> Value then
  begin
    FPreviewField := Value;
    if FPreviewField <> nil then
    begin
      FPreviewField.FreeNotification(Self);
      FPreviewFieldName := FPreviewField.FieldName;
    end;
  end;
end;

procedure TdxMasterViewLevel.SetPreviewFieldName(Value: string);
begin
  if FPreviewFieldName <> Value then
  begin
    FPreviewFieldName := Value;
    SetPreviewField(FindPreviewField);
  end;  
end;

procedure TdxMasterViewLevel.SetPreviewLeftIndent(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FPreviewLeftIndent <> Value then
  begin
    FPreviewLeftIndent := Value;
    if ShowPreview then PreviewChanged;
  end;
end;

procedure TdxMasterViewLevel.SetPreviewLineCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FPreviewLineCount <> Value then
  begin
    FPreviewLineCount := Value;
    if ShowPreview then PreviewChanged;
  end;
end;

procedure TdxMasterViewLevel.SetPreviewMaxLength(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FPreviewMaxLength <> Value then
  begin
    FPreviewMaxLength := Value;
    PreviewChanged;
    if Active then
    begin
      FCanUseSmartReload := False;
      LevelChanged(True);
    end;
  end;
end;

procedure TdxMasterViewLevel.SetPreviewMaxLineCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FPreviewMaxLineCount <> Value then
  begin
    FPreviewMaxLineCount := Value;
    if ShowPreview and (FPreviewLineCount = 0) then
      PreviewChanged;
  end;
end;

procedure TdxMasterViewLevel.SetPreviewRightIndent(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FPreviewRightIndent <> Value then
  begin
    FPreviewRightIndent := Value;
    if ShowPreview then PreviewChanged;
  end;
end;

procedure TdxMasterViewLevel.SetPreviewStyle(Value: TdxMasterViewStyle);
begin
  if FPreviewStyle <> Value then
  begin
    if FPreviewStyle <> nil then
      FPreviewStyle.RemoveConsumeType(Self, sctPreview);
    FPreviewStyle := Value;
    if FPreviewStyle <> nil then
      FPreviewStyle.AddConsumeType(Self, sctPreview);
    PreviewStyleChanged([]);
  end;
end;

procedure TdxMasterViewLevel.SetRowSeparatorColor(Value: TColor);
begin
  if FRowSeparatorColor <> Value then
  begin
    FRowSeparatorColor := Value;
    if FRowSeparatorWidth <> 0 then LevelChanged(False);
  end;
end;

procedure TdxMasterViewLevel.SetRowSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FRowSeparatorWidth <> Value then
  begin
    FRowSeparatorWidth := Value;
    LevelChanged(False);
  end;
end;

procedure TdxMasterViewLevel.SetViewMode(Value: TdxMasterViewViewMode);
begin
  if FViewMode <> Value then
  begin
    FViewMode := Value;
    FHorizontal := Value = vmHorizontal;
    CalcRealHeights;
    FLayout.ViewModeChanged;
  end;
end;

procedure TdxMasterViewLevel.SetVisibleColumn(Index: Integer; Value: TdxMasterViewColumn);
begin
  VisibleColumns[Index].Assign(Value);
end;

function TdxMasterViewLevel.IsDeleteConfirmCaptionTextStored: Boolean;
begin
  Result := FDeleteConfirmCaptionText <> LoadStr(dxsMVDeleteConfirmCaptionText);
end;

function TdxMasterViewLevel.IsDeleteConfirmTextStored: Boolean;
begin
  Result := FDeleteConfirmText <> LoadStr(dxsMVDeleteConfirmText);
end;

function TdxMasterViewLevel.IsMultipleDeleteConfirmTextStored: Boolean;
begin
  Result := FMultipleDeleteConfirmText <> LoadStr(dxsMVMultipleDeleteConfirmText);
end;

procedure TdxMasterViewLevel.ReadHeaderWidths(Reader: TReader);
var
  I, Value: Integer;
begin
  I := 0;
  Reader.ReadListBegin;
  try
    while not Reader.EndOfList do
    begin
      Value := Reader.ReadInteger;
      FLayout.Count := I + 1;
      if Value <> -1 then
        FLayout.HeaderWidths[I] := Value;
      Inc(I);
    end;
  finally
    Reader.ReadListEnd;
  end;
end;

procedure TdxMasterViewLevel.WriteHeaderWidths(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  try
    for I := 0 to FLayout.Count - 1 do
      if FLayout.HeaderWidthAssigned[I] then
        Writer.WriteInteger(FLayout.HeaderWidths[I])
      else
        Writer.WriteInteger(-1);
  finally
    Writer.WriteListEnd;
  end;
end;

procedure TdxMasterViewLevel.AddColumn(AColumn: TdxMasterViewColumn);
begin
  AColumn.FLevel := Self;
  FColumns.Add(AColumn);
  if AColumn.Visible then
  begin
    FVisibleColumns.Add(AColumn);
    if not IsLoading then
      if FViewMode = vmHorizontal then
      begin
        AColumn.RowIndex := 0;
        AColumn.ColIndex := FLayout[0].Count - 1;
      end
      else
      begin
        AColumn.ColIndex := 0;
        AColumn.RowIndex := FLayout[0].Count - 1;
      end;
  end;
  if FControl <> nil then
    FControl.Items.MoveData(Self, -1, AColumn.Index);
  FontsChanged;  
  LevelChanged(False);
end;

procedure TdxMasterViewLevel.RemoveColumn(AColumn: TdxMasterViewColumn);
begin
  AColumn.GroupIndex := -1;
  if (FControl <> nil) and (FControl.Items <> nil) then
    FControl.Items.MoveData(Self, AColumn.Index, -1);
  if AColumn.Visible then
  begin
    FVisibleColumns.Remove(AColumn);
    FLayout.RemoveColumn(AColumn);
  end;  
  SummaryColumnsChanged(AColumn, opRemove);
  FSortedColumns.Remove(AColumn);
  FColumns.Remove(AColumn);
  FontsChanged;
  LevelChanged(False);
  AColumn.FLevel := nil;
//  if dxMVDesigner <> nil then dxMVDesigner.Changed(FControl, [rcColumns]);
end;

procedure TdxMasterViewLevel.AddItem(Value: TdxMasterViewLevel);
begin
  DestroySummaries([ntData]);
  Value.FIndex := FItems.Add(Value);
  Value.FParent := Self;
  Value.FControl := FControl;
  Value.CalcParents;
  FControl.RefreshAbsoluteLevels;
  Value.FontsChanged;
  if Count = 1 then WidthChanged;
  //FControl.FItems.ChangeExpanded(True);
  if Active then
  begin
    FCanUseSmartReload := False;
    LevelChanged(True);
  end;
end;

procedure TdxMasterViewLevel.RemoveItem(Value: TdxMasterViewLevel);
var
  I: Integer;
begin
  //if (LevelCount = 1) and (FItems <> nil) then FItems.ChangeExpanded(False);
  Value.DeleteNodes;
  DestroySummaries([ntData]);
  FItems.Remove(Value);
  with Value do
  begin
    I := Index;
    FAbsoluteIndex := -1;
    FIndex := -1;
    FParent := nil;
  end;
  for I := I to Count - 1 do Dec(Items[I].FIndex);
  if (FParent <> nil) or (FControl <> nil) and (FControl.Levels = Self) then
  begin
    FControl.RefreshAbsoluteLevels;
    if Count = 0 then WidthChanged;
    if Active then
    begin
      FCanUseSmartReload := False;
      LevelChanged(True);
    end;
  end;  
//  if dxMVDesigner <> nil then dxMVDesigner.Changed(FControl, [rcLevels]);
end;

function TdxMasterViewLevel.FindPreviewField: TField;
begin
  if (FPreviewFieldName <> '') and (DataSet <> nil) then
    Result := DataSet.FindField(FPreviewFieldName)
  else
    Result := nil;
end;

procedure TdxMasterViewLevel.FontsChanged;
begin
  if (FControl <> nil) and not IsDestroying then
  begin
    ContentStyleChanged([svFont]);
    FooterStyleChanged([svFont]);
    HeaderStyleChanged([svFont]);
    PreviewStyleChanged([svFont]);
    CaptionStyleChanged([svFont]);
    GroupStyleChanged([svFont]);
    GroupByBoxStyleChanged([svFont]);
  end;
end;

procedure TdxMasterViewLevel.DeleteNodes;

  procedure DeleteOne(Root: TdxMasterViewNode);
  var
    I: Integer;
  begin
    with Root do
    begin
      if Level = FParent then
      begin
        FItems.BeginDeletion;
        try
          for I := Count - 1 downto 0 do
            if Items[I].Level = Self then Items[I].Free;
        finally
          FItems.EndDeletion;
        end;
      end;
      if Self.HasAsParent(Level) then
        for I := 0 to Count - 1 do DeleteOne(Items[I]);
    end;
  end;

begin
  with FControl do
    if FItems <> nil then
    begin
      FAbsoluteItems.BeginDeletion;
      FSelectedItems.BeginDeletion;
      try
        DeleteOne(FItems);
      finally
        FSelectedItems.EndDeletion;
        FAbsoluteItems.EndDeletion;
      end;
    end;
end;

procedure TdxMasterViewLevel.RefreshDetailKeyFieldsList;
var
  I: Integer;
begin
  FDetailKeyFields.Clear;
  if DataSet <> nil then
  begin
    try
      DataSet.GetFieldList(FDetailKeyFields, FDetailKey);
    except
      FDetailKeyFields.Clear;
    end;
    for I := 0 to DetailKeyFieldCount - 1 do
      DetailKeyFields[I].FreeNotification(Self);
  end;
end;

procedure TdxMasterViewLevel.RefreshIDFieldsList;
var
  I: Integer;
begin
  FIDFields.Clear;
  if DataSet <> nil then
  begin
    try
      DataSet.GetFieldList(FIDFields, FID);
    except
      FIDFields.Clear;
    end;
    for I := 0 to IDFieldCount - 1 do
      IDFields[I].FreeNotification(Self);
  end;
end;

procedure TdxMasterViewLevel.RefreshMasterKeyFieldsList;
var
  I: Integer;
begin
  FMasterKeyFields.Clear;
  if FParent.DataSet <> nil then
  begin
    try
      FParent.DataSet.GetFieldList(FMasterKeyFields, FMasterKey);
    except
      FMasterKeyFields.Clear;
    end;
    for I := 0 to MasterKeyFieldCount - 1 do
      MasterKeyFields[I].FreeNotification(FParent);
  end;
end;

procedure TdxMasterViewLevel.RefreshVisibleColumnsList;
var
  I: Integer;
begin
  FVisibleColumns.Clear;
  for I := 0 to ColumnCount - 1 do
    if Columns[I].Visible then FVisibleColumns.Add(Columns[I]);
end;

procedure TdxMasterViewLevel.SummaryColumnsChanged(AColumn: TdxMasterViewColumn;
  Operation: TOperation);
begin
  if Operation = opInsert then
    if AColumn.SummaryIndex = -1 then
      FSummaryColumns.Add(AColumn)
    else
      Exit
  else
    if AColumn.SummaryIndex = -1 then
      Exit
    else
      FSummaryColumns.Remove(AColumn);
  if ShowCaption or (GroupColumnCount <> 0) then
    DestroySummaries([ntCaption, ntGroup]);
  if FParent <> nil then
    FParent.DestroySummaries([ntData]);
end;

procedure TdxMasterViewLevel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('HeaderWidths', ReadHeaderWidths, WriteHeaderWidths, not FHorizontal);
end;

procedure TdxMasterViewLevel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
    if Columns[I].Owner = Root then Proc(Columns[I]);
  for I := 0 to Count - 1 do
    if Items[I].Owner = Root then Proc(Items[I]);
end;

procedure TdxMasterViewLevel.Loaded;
begin
  inherited;
  LoadingComplete;
end;

procedure TdxMasterViewLevel.Notification(AComponent: TComponent; Operation: TOperation);
var
  NeedLayout: Boolean;
  I: Integer;
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TdxMasterViewStyle) then
  begin
    if HeaderStyle = AComponent then HeaderStyle := nil;
    if ContentStyle = AComponent then ContentStyle := nil;
    if FooterStyle = AComponent then FooterStyle := nil;
    if PreviewStyle = AComponent then PreviewStyle := nil;
    if CaptionStyle = AComponent then CaptionStyle := nil;
    if GroupStyle = AComponent then GroupStyle := nil;
    if GroupByBoxStyle = AComponent then GroupByBoxStyle := nil;
  end;
  if not IsDestroying and (Operation = opRemove) then
    if AComponent = DataSource then
      DataSource := nil
    else
      if AComponent is TField then
      begin
        NeedLayout := False;
        FControl.BeginLayout;
        try
          if FDetailKeyFields.Remove(AComponent) <> -1 then
            NeedLayout := True;
          if FIDFields.Remove(AComponent) <> -1 then
            NeedLayout := True;
          for I := 0 to Count - 1 do
            if Items[I].FMasterKeyFields.Remove(AComponent) <> -1 then
              NeedLayout := True;
          if FPreviewField = AComponent then
          begin
            PreviewField := nil;
            NeedLayout := True;
          end;
          for I := 0 to ColumnCount - 1 do
            with Columns[I] do
            begin
              if Field = AComponent then
              begin
                Field := nil;
                NeedLayout := True;
              end;
              if SummaryField = AComponent then
              begin
                SummaryField := nil;
                NeedLayout := True;
              end;
            end;
        finally
          if NeedLayout and Active then
            FControl.EndLayout
          else
            FControl.CancelLayout;
        end;
      end;
end;

procedure TdxMasterViewLevel.SetName(const NewName: TComponentName);
var
  OldName: TComponentName;
  I: Integer;
  Column: TdxMasterViewColumn;
  ColumnName, NamePrefix: TComponentName;
begin
  OldName := Name;
  inherited;
  { In design mode the name of the columns should track the level name }
  if FControl.IsDesigning and (Name <> OldName) then
    for I := 0 to ColumnCount - 1 do
    begin
      Column := Columns[I];
      if Column.Owner = Owner then
      begin
        ColumnName := Column.Name;
        if Length(ColumnName) > Length(OldName) then
        begin
          NamePrefix := Copy(ColumnName, 1, Length(OldName));
          if CompareText(OldName, NamePrefix) = 0 then
          begin
            System.Delete(ColumnName, 1, Length(OldName));
            System.Insert(NewName, ColumnName, 1);
            try
              Column.Name := ColumnName;
            except
              on EComponentError do {Ignore rename errors };
            end;
          end;
        end;
      end;
    end;
  if dxMVDesigner <> nil then dxMVDesigner.Changed(FControl, [rcLevels]);
end;

procedure TdxMasterViewLevel.SetParentComponent(AParent: TComponent);
begin
  if AParent is TdxMasterView then
    TdxMasterView(AParent).Levels.AddItem(Self)
  else
    if AParent is TdxMasterViewLevel then
      TdxMasterViewLevel(AParent).AddItem(Self);
end;

procedure TdxMasterViewLevel.ActiveChanged;
var
  I: Integer;
begin
  FControl.BeginLayout;
  try
    LayoutChanged;
  finally
    FControl.EndLayout;
  end;
  if FControl.FocusedNode = nil then
  begin
    if FControl.SyncMove then
      if Active then
        SyncPos
      else
        for I := ParentCount - 2 downto 1 do
          with Parents[I] do
            if Active then
              SyncPos
            else
              Break;
    with FControl do
      if (FocusedNode = nil) and (AbsoluteItemCount <> 0) then
        FocusNode(AbsoluteItems[0], True);
  end;
end;

procedure TdxMasterViewLevel.AfterPaint;
begin
  DeleteObject(FRowSeparatorBrush);
  DeleteObject(FLevelSeparatorBrush);
  DeleteObject(FGridLinesPen);
  DeleteObject(FGridLinesBrush);
end;

procedure TdxMasterViewLevel.AssignColumnWidths;
var
  I: Integer;
begin
  BeginAssignWidths;
  try
    for I := 0 to VisibleColumnCount - 1 do
      with VisibleColumns[I] do
        Width := FVisibleWidth;
  finally
    EndAssignWidths;
  end;
end;

procedure TdxMasterViewLevel.BeforePaint;
begin
  FGridLinesBrush := CreateSolidBrush(ColorToRGB(FGridLinesColor));
  FGridLinesPen := CreatePen(PS_SOLID, DefaultLineWidth, ColorToRGB(FGridLinesColor));
  FLevelSeparatorBrush := CreateSolidBrush(ColorToRGB(FLevelSeparatorColor));
  FRowSeparatorBrush := CreateSolidBrush(ColorToRGB(FRowSeparatorColor));
end;

procedure TdxMasterViewLevel.BeginLoad;
var
  NeedUpdateData: Boolean;
begin
  NeedUpdateData := False;
  if (FLoadLockCount = 0) and (DataSet <> nil) then
  begin
    DataSet.DisableControls;
    if DataSet.State in dsEditModes then
    begin
      DataSet.Cancel;
      NeedUpdateData := True;
    end;
    FBeforeLoadBookmark := DataSet.GetBookmark;
    FBeforeLoadActiveRecord := TDummyDataSet(DataSet).ActiveRecord;
    FBeforeLoadBOF := DataSet.BOF;
    FBeforeLoadEOF := DataSet.EOF;
  end;
  Inc(FLoadLockCount);
  if NeedUpdateData then DataChanged;
end;

procedure TdxMasterViewLevel.BeginLoading;
begin
  if FLoadingLockCount = 0 then
  begin
    FCursorBeforeLoading := Screen.Cursor;
    Screen.Cursor := crHourglass;
  end;
  Inc(FLoadingLockCount);
end;

procedure TdxMasterViewLevel.CalcDefaultWidths(Column: TdxMasterViewColumn);
var
  AChanged: Boolean;
  I, PrevWidth: Integer;

  procedure ProcessColumn(Column: TdxMasterViewColumn);
  begin
    with Column do
      if not (cvWidth in AssignedValues) then
      begin
        PrevWidth := FWidth;
        FWidth := DefaultWidth;
        if FWidth <> PrevWidth then
          FVisibleWidth := FWidth;
        AChanged := AChanged or Visible and (FWidth <> PrevWidth);
      end;
  end;

begin
  if IsLoading or (Column <> nil) and Column.IsLoading or
    Control.IsDestroying then Exit;
  AChanged := False;
  BeginAssignWidths;
  try
    if Column <> nil then ProcessColumn(Column)
    else
      for I := 0 to ColumnCount - 1 do
        ProcessColumn(Columns[I]);
  finally
    if AChanged then
      EndAssignWidths
    else
      CancelAssignWidths;
  end;
end;

procedure TdxMasterViewLevel.CalcLineWidth;
begin
  FLineWidth := DefaultLineWidth * Byte(HasGrid);
  CalcRealHeights;
end;

procedure TdxMasterViewLevel.CalcParents;
var
  ALevel: TdxMasterViewLevel; 
begin
  Finalize(FParents);
  FParentCount := 0;
  ALevel := Self;
  while ALevel <> nil do
  begin
    Inc(FParentCount);
    ALevel := ALevel.Parent;
  end;
  SetLength(FParents, FParentCount);
  FParentCount := 0;
  ALevel := Self;
  while ALevel <> nil do
  begin
    FParents[FParentCount] := ALevel;
    Inc(FParentCount);
    ALevel := ALevel.Parent;
  end;
end;

procedure TdxMasterViewLevel.CalcRealHeights;
begin
  FHeaderRealHeight := FHeaderHeight;
  FContentRealHeight := FContentHeight + FLineWidth;
  if not FHorizontal then
    if FHeaderRealHeight > FContentRealHeight then
      FContentRealHeight := FHeaderRealHeight
    else
      FHeaderRealHeight := FContentRealHeight;
end;

procedure TdxMasterViewLevel.DestroySummaries(NodeTypes: TdxMasterViewNodeTypes);

  procedure CheckNode(Node: TdxMasterViewNode);
  var
    I: Integer;
  begin
    if (Node.Level = Self) and (Node.NodeType in NodeTypes) then
      Node.DestroySummaries;
    for I := 0 to Node.Count - 1 do
      CheckNode(Node[I]);
  end;

begin
  with FControl do
    if FItems <> nil then CheckNode(FItems);
end;

procedure TdxMasterViewLevel.EndLoad(RecalcInfo: Boolean);
var
  AFreezeCount: Integer;
begin
  if FLoadLockCount > 0 then
  begin
    Dec(FLoadLockCount);
    if FLoadLockCount = 0 then
    begin
      if DataSet <> nil then
        with TDummyDataSet(DataSet) do
        begin
          if FBeforeLoadBookmark <> nil then
          begin
            if BookmarkValid(FBeforeLoadBookmark) then GotoBookmark(FBeforeLoadBookmark);
            FreeBookmark(FBeforeLoadBookmark);
          end;

          if ActiveRecord > FBeforeLoadActiveRecord then
          begin
            MoveBy(BufferCount - ActiveRecord - 1 +
              ActiveRecord - FBeforeLoadActiveRecord);
            MoveBy(FBeforeLoadActiveRecord - BufferCount + 1);
          end
          else
            if ActiveRecord < FBeforeLoadActiveRecord then
            begin
              MoveBy(-ActiveRecord +
                ActiveRecord - FBeforeLoadActiveRecord);
              MoveBy(FBeforeLoadActiveRecord);
            end;

          if FBeforeLoadBOF and not BOF then Prior;
          if FBeforeLoadEOF and not EOF then Next;

          AFreezeCount := FControl.FreezeDataSet(Self);
          try
            EnableControls;
          finally
            if FDataLink.FreezeCount = AFreezeCount then
              FControl.UnfreezeDataSet(Self);
          end;
        end;
      if RecalcInfo then
      begin
        DoSorting;
      end;
    end;
  end;
end;

procedure TdxMasterViewLevel.EndLoading;
begin
  if FLoadingLockCount > 0 then
  begin
    Dec(FLoadingLockCount);
    if FLoadingLockCount = 0 then
    begin
      LoadingComplete;
      LevelChanged(True);
      Screen.Cursor := FCursorBeforeLoading;
    end;
  end;
end;

procedure TdxMasterViewLevel.LoadingComplete;
var
  List: TList;
  PrevProcessedCount, ProcessedCount, CurIndex, I: Integer;
  PrevLeaveSortOrder: Boolean;
  Column: TdxMasterViewColumn;
begin
  BeginLayout;
  List := TList.Create;
  try
    // grouping
    CurIndex := -1;
    repeat
      ProcessedCount := 0;
      for I := 0 to ColumnCount - 1 do
      begin
        Column := Columns[I];
        with Column do
          if FLoadedGroupIndex = CurIndex then
          begin
            PrevLeaveSortOrder := FLeaveSortOrder;
            if GroupIndex <> FLoadedGroupIndex then
              ChangeGrouping(Column, FLoadedGroupIndex);
            FLeaveSortOrder := PrevLeaveSortOrder;
            ProcessedCount := 1;
            if CurIndex <> -1 then Break;
          end;
      end;    
      Inc(CurIndex);
    until (ProcessedCount = 0) and (CurIndex <> -1);

    // sorting
    CurIndex := -1;
    repeat
      ProcessedCount := 0;
      for I := 0 to ColumnCount - 1 do
      begin
        Column := Columns[I];
        if Column.FLoadedSortIndex = CurIndex then
        begin
          with Column do
            if SortIndex <> FLoadedSortIndex then
              ChangeSorting(Column, SortOrder, FLoadedSortIndex);
          ProcessedCount := 1;
          if CurIndex <> -1 then Break;
        end;
      end;
      Inc(CurIndex);
    until (ProcessedCount = 0) and (CurIndex <> -1);

    // layout
    CalcDefaultWidths(nil);
    MakeVisibleColumnsSortedList(List);
    FLayout.Clear;

    PrevProcessedCount := 0;
    ProcessedCount := 0;
    CurIndex := 0;
    while ProcessedCount < List.Count do
    begin
      while ProcessedCount < List.Count do
      begin
        Column := TdxMasterViewColumn(List[ProcessedCount]);
        if FHorizontal and (Column.RowIndex <> CurIndex) or
          not FHorizontal and (Column.ColIndex <> CurIndex) then Break;
        Inc(ProcessedCount);
      end;
      for I := PrevProcessedCount to ProcessedCount - 1 do
        with TdxMasterViewColumn(List[I]) do
          FLayout.InsertColumn(FRowIndex, FColIndex, List[I]);
      PrevProcessedCount := ProcessedCount;
      Inc(CurIndex);
    end;
  finally
    List.Free;
    EndLayout;
  end;
end;

procedure TdxMasterViewLevel.CalcPreviewLineCount(DC: HDC; const S: string;
  Width: Integer; Node: TdxMasterViewNode; var Height: Integer);
var
  R: TRect;
  Size: TSize;
  LineCount: Integer;
begin
  GetTextExtentPoint{32}(DC, 'Qq', 2, Size);
  if FPreviewLineCount = 0 then
  begin
    R := Rect(0, 0, Width - (FPreviewLeftIndent + FPreviewRightIndent + FExtLineWidth), 0);
    Windows.DrawText(DC, PChar(S), Length(S), R,
      DT_CALCRECT or DT_EXPANDTABS or DT_NOCLIP or DT_NOPREFIX or DT_WORDBREAK);

    LineCount := R.Bottom div Size.cy;
    if (FPreviewMaxLineCount <> 0) and (LineCount > FPreviewMaxLineCount) then
      LineCount := FPreviewMaxLineCount;
  end
  else
    LineCount := FPreviewLineCount;
  if Assigned(FOnGetPreviewLineCount) then
    FOnGetPreviewLineCount(Self, Node, LineCount);
  Height := 1 + Size.cy * LineCount + 1 + FExtLineWidth;
end;

function TdxMasterViewLevel.CanDelete: Boolean;
begin
  Result := (lodAllowDelete in FOptionsDB) and Active and DataSet.CanModify;
end;

function TdxMasterViewLevel.CanGrouping(Column: TdxMasterViewColumn;
  Index: Integer): Boolean;
begin
  Result := locColumnGrouping in FOptionsCustomize;
  if Assigned(FOnChangeGrouping) then
    FOnChangeGrouping(Self, Column, Index, Result);
end;

function TdxMasterViewLevel.CanHorSizing: Boolean;
begin
  Result := locColumnHorSizing in FOptionsCustomize;
end;

function TdxMasterViewLevel.CanInsert: Boolean;
begin
  Result := (lodAllowInsert in FOptionsDB) and Active and DataSet.CanModify;
end;

function TdxMasterViewLevel.CanSmartRefresh: Boolean;
begin
  Result := FControl.SyncMove and (lodSmartRefresh in FOptionsDB) and
    not (FDataLink.DataSet.BOF or FDataLink.DataSet.EOF);
end;

function TdxMasterViewLevel.CanSorting(Column: TdxMasterViewColumn): Boolean;
begin
  Result := locColumnSorting in FOptionsCustomize;
  if Assigned(FOnColumnSorting) then FOnColumnSorting(Self, Column, Result);
end;

procedure TdxMasterViewLevel.CaptionStyleChanged(Values: TdxMasterViewStyleValues);
var
  Size: TSize;
begin
  if (Values = []) or (svFont in Values) then
  begin
    CalcFontSize(CaptionFont, Size);
    FCaptionHeight := Size.cy + 2 + 2;  // 17 - without line
  end;
  if ShowCaption then LevelChanged(False);
end;

procedure TdxMasterViewLevel.ChangeGrouping(Column: TdxMasterViewColumn;
  AIndex: Integer);
begin
  with FGroupColumns, Column do
    if GroupIndex = -1 then
    begin
      FLeaveSortOrder := FSortOrder <> soNone;
      if (locHideColumnOnGrouping in OptionsCustomize) and
        (VisibleColumnCount <> 1) then
        Visible := False;
      if SortOrder = soNone then SortOrder := soAscending;
      Insert(AIndex, Column);
    end
    else
      if AIndex = -1 then
      begin
        Remove(Column);
        if locShowColumnOnUngrouping in OptionsCustomize then
          Visible := True;
      end
      else
        if AIndex = Count then
          Exit
        else
          Move(GroupIndex, AIndex);
  WidthChanged;
  if Active then LevelChanged(True);
  with Column do
    if (AIndex = -1) and not FLeaveSortOrder then SortOrder := soNone;
end;

procedure TdxMasterViewLevel.ChangeSorting(Column: TdxMasterViewColumn;
  ASortOrder: TdxMasterViewSortOrder; ASortIndex: Integer);
var
  Resort: Boolean;
  I: Integer;
begin
  if ASortIndex = -2 then
    if SortedColumnCount <> 0 then
    begin
      BeginSorting;
      try
        for I := SortedColumnCount - 1 downto 0 do
          if SortedColumns[I] <> Column then  // exceptional column
            SortedColumns[I].SortOrder := soNone;
      finally
        EndSorting;
      end;
    end
    else
  else
    if Column <> nil then
    begin
      if (ASortOrder = soNone) and (Column.GroupIndex <> -1) then Exit;
      Column.FSortOrder := ASortOrder;
      Column.ColumnChanged(False, hpOne, vpHeader);
      Resort := True;
      if ASortOrder = soNone then
      begin
        FSortedColumns.Remove(Column);
        if FSortedColumns.Count = 0 then Resort := False;
      end
      else
        if Column.SortIndex = -1 then
          if ASortIndex = -1 then
            FSortedColumns.Add(Column)
          else
            FSortedColumns.Insert(ASortIndex, Column)
        else
          FSortedColumns.Move(Column.SortIndex, ASortIndex);
      if Column.Visible and not FHorizontal and ShowHeader and
        not FLayout.HeaderWidthAssigned[Column.ColIndex] then
        WidthChanged;
      if Resort then DoSorting
      else
        if Column.Visible and ShowHeader then
          if FHorizontal or FLayout.HeaderWidthAssigned[Column.ColIndex] then
            Column.ColumnChanged(False, hpOne, vpHeader)
          else
            LevelChanged(False);
      if not IsDestroying and Assigned(FOnColumnSorted) then
        FOnColumnSorted(Self, Column);
    end;
end;

procedure TdxMasterViewLevel.ContentStyleChanged(Values: TdxMasterViewStyleValues);
var
  Size: TSize;
  H, I: Integer;
begin
  if (Values = []) or (svFont in Values) then
  begin
    if VisibleColumnCount = 0 then
    begin
      CalcFontSize(ContentFont, Size);
      H := Size.cy;
    end
    else
    begin
      H := 0;
      for I := 0 to VisibleColumnCount - 1 do
      begin
        CalcFontSize(VisibleColumns[I].ContentFont, Size);
        if Size.cy > H then H := Size.cy;
      end;
    end;
    FContentHeight := H + 2 + 2;  // 17 - without line
    CalcRealHeights;
    CalcDefaultWidths(nil);
  end;
  LevelChanged(False);
  if (svColor in Values) and not PreviewColorAssigned or
    (svFont in Values) and not PreviewFontAssigned then
    PreviewStyleChanged(Values);
end;

procedure TdxMasterViewLevel.DataChanged;
var
  AKeyValue: Variant;
  ParentNode, Node: TdxMasterViewNode;
begin
  if FDataChanging then Exit;
  FDataChanging := True;
  try
    if FDataLink.DataSet.State = dsSetKey then Exit;

    if FDataLink.DataSet.State = dsBrowse then
      if CanSmartRefresh then
      begin
        if FIsInsertMode or (FEditingNode <> nil) then
        begin
          UncheckTriedToExpand;
          if FIsInsertMode then
          begin
            FIsInsertMode := False;
            AKeyValue := GetCurDetailKeyValue;
            if not VarIsEmpty(AKeyValue) or IsTop then
            begin
              if IsTop then
                ParentNode := FControl.FItems
              else
                ParentNode := FControl.NodeFromKeyValue(FParent, Index, AKeyValue);
              if ParentNode <> nil then
              begin
                ParentNode := GetParentNode(ParentNode, nil, nil, nil, nil, True);
                if ParentNode <> nil then
                begin
                  Node := ParentNode.Add(Self, -1, ntData, GetCurIDValue, GetCurKeyValue);
                  Node.UpdateData(True, False, False);
                  ParentNode.CheckChildNodes(Self, True);
                  Node.MakeVisible;
                end;
              end;
            end;
          end;
          if FEditingNode <> nil then
            with FEditingNode do
            begin
              UpdateData(True, False, True);
              CheckParentNodes;
              MakeVisible;
              FEditingNode := nil;
            end;
        end;
        SyncPos;
      end
      else
      begin
        FIsInsertMode := False;
        FEditingNode := nil;
        UncheckTriedToExpand;
        //FCanUseSmartReload := False;
        LevelChanged(True);
      end;

    if FDataLink.DataSet.State = dsInsert then FIsInsertMode := True;
  finally
    FDataChanging := False;
  end;
end;

procedure TdxMasterViewLevel.DoAfterCollapse(Node: TdxMasterViewNode);
begin
  if Assigned(FOnCollapsed) then FOnCollapsed(Self, Node);
end;

procedure TdxMasterViewLevel.DoAfterExpand(Node: TdxMasterViewNode);
begin
  if Assigned(FOnExpanded) then FOnExpanded(Self, Node);
end;

function TdxMasterViewLevel.DoBeforeCollapse(Node: TdxMasterViewNode): Boolean;
begin
  Result := True;
  if Assigned(FOnCollapsing) then FOnCollapsing(Self, Node, Result);
end;

function TdxMasterViewLevel.DoBeforeExpand(Node: TdxMasterViewNode): Boolean;
begin
  Result := True;
  if Assigned(FOnExpanding) then FOnExpanding(Self, Node, Result);
end;

procedure TdxMasterViewLevel.DoGetContentStyle(Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn; var NewStyle: TdxMasterViewStyle);
begin
  if Assigned(FOnGetContentStyle) then FOnGetContentStyle(Self, Node, Column, NewStyle);
end;

procedure TdxMasterViewLevel.DoGetFooterCellText(Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn; var Text: string);
begin
  if Assigned(FOnGetFooterCellText) then
    FOnGetFooterCellText(Self, Node, Column, Text);
end;

procedure TdxMasterViewLevel.DoHideColumn(Column: TdxMasterViewColumn);
begin
  if Assigned(FOnHideColumn) then FOnHideColumn(Self, Column);
end;

procedure TdxMasterViewLevel.DoNodeDeleted(Node: TdxMasterViewNode);
begin
  if Node = FEditingNode then FEditingNode := nil;
  if Assigned(FOnDeleteNode) then FOnDeleteNode(Self, Node);
end;

procedure TdxMasterViewLevel.DoShowColumn(Column: TdxMasterViewColumn);
begin
  if Assigned(FOnShowColumn) then FOnShowColumn(Self, Column);
end;

procedure TdxMasterViewLevel.DoSorting;
var
  PrevCursor: TCursor;
begin
  if (SortedColumnCount = 0) or
    (FSortingLockCount <> 0) or (FLoadLockCount <> 0) or
    IsDestroying then Exit;
  with FControl do
  begin
    PrevCursor := Screen.Cursor;
    if ShowHourGlassCursor then Screen.Cursor := crHourGlass;
    BeginUpdate;
    try
      Items.DoSorting(Self);
    finally
      EndUpdate;
      ShowFocusedNode;
      if ShowHourGlassCursor then Screen.Cursor := PrevCursor;
    end;
  end;
end;

procedure TdxMasterViewLevel.DrawIndent(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
var
  R: TRect;
  NextLevelIndex, I, RelativeLevelIndex: Integer;
  IsLowerIndent: Boolean;
  ABrush: HBRUSH;

  function GetYoungerParentNodeIndex(AParentIndex: Integer): Integer;
  begin
    for Result := AParentIndex - 1 downto 0 do
      if Node.ParentNodes[Result].NodeType = ntData then Exit;
    Result := 0;
  end;

begin
  R := ARect;
  Dec(R.Left, FControl.LeftPos);

  if Node.AbsoluteIndex = Control.AbsoluteItemCount - 1 then
    NextLevelIndex := -1
  else
    with FControl.AbsoluteItems[Node.AbsoluteIndex + 1], ViewInfo do
      if AbsoluteIndex = FControl.TopIndex + FControl.FLastPartVisibleItemCount then
        NextLevelIndex := GetLevelIndex
      else
        NextLevelIndex := LevelIndex;

  for I := Node.ViewInfo.LevelIndex downto 1 do
    with Node.ViewInfo, Node.ParentNodes[I], R do
    begin
      Right := Left + LevelIndent;
      if (Level = Self) and (Node.ViewInfo.GroupByBoxSize <> 0) and
        (NodeType in [ntData, ntGroup]) and
        (ParentNode.NodeType in [ntData, ntCaption]) then
        Inc(Top, Node.ViewInfo.GroupByBoxSize);
      if AbsoluteIndex < FControl.TopIndex then
        IsLowerIndent := NextLevelIndex <= GetLevelIndex
      else
        IsLowerIndent := NextLevelIndex <= ViewInfo.LevelIndex;

      with Level do
      begin
        GetContentParams(ParentNodes[0], nil, @ABrush, nil, nil, nil, False);
        case NodeType of
          ntData:
            begin
              RelativeLevelIndex := Node.Level.IndexOfParent(Level);
              if Node.HasFooter(RelativeLevelIndex) then
                Dec(Bottom, RowCount * FooterHeight);
              if IsLowerIndent then
              begin
                if (RowSeparatorWidth <> 0) and
                  Node.HasRowSeparator(GetYoungerParentNodeIndex(I)) then
                begin
                  FillRect(DC,
                    Rect(Left, Bottom - RowSeparatorWidth,
                      Right + ExtLineWidth + LevelSeparatorWidth, Bottom),
                    RowSeparatorBrush);
                  Dec(Bottom, RowSeparatorWidth);
                end;
                FillRect(DC, Rect(Left, Bottom - ExtLineWidth, Right, Bottom), GridLinesBrush);
                Dec(Bottom, ExtLineWidth);
                FillRect(DC, R, ABrush);
                Inc(Bottom, ExtLineWidth);
              end
              else
                FillRect(DC, R, ABrush);
              if ExtLineWidth <> 0 then
              begin
                FillRect(DC, Rect(Right, Top, Right + ExtLineWidth, Bottom), GridLinesBrush);
                Inc(Right, ExtLineWidth);
              end;
              if LevelSeparatorWidth <> 0 then
              begin
                FillRect(DC,
                  Rect(Right, Top, Right + LevelSeparatorWidth, Bottom),
                  LevelSeparatorBrush);
                Inc(Right, LevelSeparatorWidth);
                if Node.HasLevelSeparator(GetYoungerParentNodeIndex(I)) then
                  Dec(Bottom, LevelSeparatorWidth);
              end;
              Left := Right;
            end;
          ntCaption, ntGroup:
            begin
              if IsLowerIndent then
              begin
                FillRect(DC, Rect(Left, Bottom - ExtLineWidth, Right, Bottom), GridLinesBrush);
                Dec(Bottom, ExtLineWidth);
                FillRect(DC, R, ABrush);
                Inc(Bottom, ExtLineWidth);
              end
              else
                FillRect(DC, R, ABrush);
              FillRect(DC, Rect(Right, Top, Right + ExtLineWidth, Bottom), GridLinesBrush);
              Left := Right + ExtLineWidth;
              Right := Left + LevelIndent;
            end;
        end;
      end;  
    end;
end;

procedure TdxMasterViewLevel.DrawGroupByBox(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
var
  ATextColor, ABkColor: TColor;
  AFont: TFont;
  R, R1: TRect;
  RestRgn, ClipRgn, Rgn: HRGN;
  ClipRgnExists: Boolean;
  PrevFont: HFONT;
  Size: TSize;
  I, X, Y: Integer;
  ABrush, LineBrush: HBRUSH;

  procedure ExcludeRect(const R: TRect);
  begin
    Rgn := CreateRectRgnIndirect(R);
    CombineRgn(RestRgn, RestRgn, Rgn, RGN_DIFF);
    DeleteObject(Rgn);
  end;

begin
  GetGroupByBoxParams(Node, @ABrush, @ATextColor, @ABkColor, @AFont);
  R := ARect;
  RestRgn := CreateRectRgnIndirect(R);
  try
    ClipRgn := CreateRectRgn(0, 0, 0, 0);
    ClipRgnExists := GetClipRgn(DC, ClipRgn) = 1;
    with R do
      IntersectClipRect(DC, Left, Top, Right, Bottom);
    try
      if GroupColumnCount = 0 then
      begin
        SetTextColor(DC, ColorToRGB(ATextColor));
        SetBkColor(DC, ColorToRGB(ABkColor));
        PrevFont := SelectObject(DC, AFont.Handle);
        GetTextExtentPoint{32}(DC, PChar(dxMVGroupByBoxText),
          Length(dxMVGroupByBoxText), Size);
        with R do
        begin
          Inc(Left, GroupByBoxLeftOffset);
          if Left + Size.cx < Right then
            Right := Left + Size.cx;
          Top := (Top + Bottom - Size.cy) div 2;
          Bottom := Top + Size.cy;
        end;
        DrawText(DC, PChar(dxMVGroupByBoxText), Length(dxMVGroupByBoxText),
          R, DT_SINGLELINE);
        SelectObject(DC, PrevFont);
        ExcludeRect(R);
      end
      else
      begin
        LineBrush := CreateSolidBrush(ColorToRGB(GroupByBoxLineColor));
        try
          for I := 0 to GroupColumnCount - 1 do
            with GroupColumns[I] do
            begin
              R := GetGroupByBoxBounds(Node);
              ExcludeRect(R);
              if I < GroupColumnCount - 1 then
                with R do
                begin
                  Y := (HeaderRealHeight div 2 + GroupByBoxVerOffset) div 2;
                  X := Right - 2 * Y;//(Left + Right) div 2;
                  Y := Bottom + Y;
                  R1 := Rect(X, Bottom, X + 1, Y);
                  FillRect(DC, R1, LineBrush);
                  ExcludeRect(R1);
                  R1 := Rect(X + 1, Y - 1, Right + GroupByBoxHorOffset, Y);
                  FillRect(DC, R1, LineBrush);
                  ExcludeRect(R1);
                end;
              if RectVisible(DC, R) then
              begin
                DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
                R1 := R;
                InflateRect(R, -1, -1);
                DrawHeader(DC, R, Node);
                if Pressed then DrawDowned(DC, R1);
              end;  
            end;
        finally
          DeleteObject(LineBrush);
        end;
      end;
    finally
      SelectClipRgn(DC, Byte(ClipRgnExists) * ClipRgn);
      DeleteObject(ClipRgn);
    end;
  finally
    FillRgn(DC, RestRgn, ABrush);
    DeleteObject(RestRgn);

    R := ARect;
    with R do
    begin
      Left := Right;
      Right := FControl.ClientWidth;
    end;
    FillRect(DC, R, FControl.Brush.Handle);
  end;
end;

procedure TdxMasterViewLevel.DrawHeader(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
var
  ABrush: HBRUSH;
  R, R1, R2: TRect;
  RestRgn, Rgn: HRGN;
  I: Integer;
  Column: TdxMasterViewColumn;

  procedure ExcludeRect(const R: TRect);
  begin
    Rgn := CreateRectRgnIndirect(R);
    CombineRgn(RestRgn, RestRgn, Rgn, RGN_DIFF);
    DeleteObject(Rgn);
  end;

begin
  GetHeaderParams(Node, nil, nil, @ABrush, nil, nil, nil);
  R := ARect;
  RestRgn := 0;
  if FHorizontal then
    if RowCount > 1 then
      RestRgn := CreateRectRgnIndirect(ARect)
    else
  else
    if (Node.ViewInfo.PreviewSize = 0) and (LineWidth <> 0) then
      Dec(R.Bottom, LineWidth);
  try
    for I := 0 to VisibleColumnCount - 1 do
    begin
      Column := VisibleColumns[I];
      with Column, R1 do
      begin
        R1 := GetHeaderBounds(Node);
        if RestRgn <> 0 then ExcludeRect(R1)
        else
          if not FHorizontal and FLayout.IsColumnLast(Column) then
            FillRect(DC, Rect(Left, Bottom, Right, R.Bottom), ABrush);
        if (Left = Right) or not RectVisible(DC, R1) then Continue;
        // draw column's border
        DrawEdge(DC, R1, BDR_RAISEDINNER, BF_RECT);
        // draw column's content
        R2 := R1;
        InflateRect(R2, -1, -1);
        DrawHeader(DC, R2, Node);
        if Pressed then DrawDowned(DC, R1);
      end;
    end;
  finally
    // fill in rest space
    if RestRgn <> 0 then
    begin
      FillRgn(DC, RestRgn, ABrush);
      DeleteObject(RestRgn);
    end;
    // draw rest space
    if FHorizontal then
    begin
      with R do
      begin
        Left := Right;
        Right := FControl.ClientWidth;
      end;
      FillRect(DC, R, FControl.Brush.Handle);
    end;
  end;
end;

procedure TdxMasterViewLevel.DrawContent(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
type
  PPointArray = ^TPointArray;
  TPointArray = array[0..MaxInt div SizeOf(TPoint) - 1] of TPoint;
  PDWORDArray = ^TDWORDArray;
  TDWORDArray = array[0..MaxInt div SizeOf(DWORD) - 1] of DWORD;
var
  R, R1, R2: TRect;
  RestRgn, Rgn: HRGN;
  AShowGrid, AHasExpandButton, IsMultiRows, HasLeftBorder, HasTopBorder: Boolean;
  S: string;
  I, J, K, L: Integer;
  AFont: TFont;
  P, RectsP: PPointArray;
  C, RectsC: PDWORDArray;
  Column: TdxMasterViewColumn;
  ABrush: HBRUSH;
  ATextColor, ABkColor: TColor;
  ADC: HDC;
  PrevFont: HFONT;

  procedure DrawFocus(const R: TRect);
  begin
    R1 := R;
    if AShowGrid or ShowPreview then
    begin
      if Node.Horizontal or AShowGrid or (I = FLayout.Count - 1) then
        Dec(R1.Right, ExtLineWidth);
      if Node.Horizontal or AShowGrid then
        Dec(R1.Bottom, ExtLineWidth);
    end;
    if FControl.HasFocus then
    begin
      with R1 do
        if Odd(Left) = Odd(Top) then
        begin
          SetTextColor(DC, $FFFFFF);
          SetBkColor(DC, 0);
        end
        else
        begin
          SetTextColor(DC, 0);
          SetBkColor(DC, $FFFFFF);
        end;
      DrawFocusRect(DC, R1);
    end
    else
      if not (movHideFocusRect in FControl.OptionsView) then
        if FControl.InactiveFocusColor = clNone then
          with R1 do
          begin
            BitBlt(DC, Left, Top, Right - Left, 1, 0, 0, 0, DSTINVERT);
            BitBlt(DC, Left, Bottom - 1, Right - Left, 1, 0, 0, 0, DSTINVERT);
            BitBlt(DC, Left, Top + 1, 1, Bottom - Top - 2, 0, 0, 0, DSTINVERT);
            BitBlt(DC, Right - 1, Top + 1, 1, Bottom - Top - 2, 0, 0, 0, DSTINVERT);
          end
        else
          FrameRect(DC, R1, FControl.InactiveFocusBrush);
  end;

begin
  R := ARect;
  AShowGrid := HasGrid;
  AHasExpandButton := Node.HasExpandButton;
  Inc(R.Left, Byte(AHasExpandButton) * LevelIndent);
  IsMultiRows := False;
  case Node.NodeType of
    ntData:
      begin
        IsMultiRows := FHorizontal and (RowCount > 1);
        R.Bottom := R.Top +
          VisibleRowCount * ContentRealHeight + Node.ViewInfo.PreviewSize;
        if (Node.ViewInfo.PreviewSize <> 0) or (LineWidth = 0) then
          Inc(R.Bottom, ExtLineWidth);
      end;
    ntCaption:
      R.Bottom := R.Top + CaptionHeight + ExtLineWidth;
    ntGroup:
      R.Bottom := R.Top + GroupHeight + ExtLineWidth;
  end;
  R1 := R;

  // draw expand button
  if AHasExpandButton then
    with R, Node do
    begin
      GetContentParams(Node, nil, @ABrush, nil, nil, nil, False);
      R2 := Rect(Left - LevelIndent, Top, Left, Bottom - ExtLineWidth);
      if Node.ShowExpandButton then
        DrawExpandButton(DC, R2, ABrush, Expanded, CanExpand)
      else
        FillRect(DC, R2, ABrush);
      if ShowGrid then
      begin
        if not Node.Expanded then ABrush := GridLinesBrush;
        FillRect(DC, Rect(Left - LevelIndent, Bottom - ExtLineWidth, Left, Bottom), ABrush);
      end;
    end;

  // draw last(bottom and right) grid lines
  with R1 do
    if Left < Right then
    begin
      FillRect(DC, Rect(Left, Bottom - ExtLineWidth, Right, Bottom), GridLinesBrush);
      Dec(Bottom, ExtLineWidth);
      FillRect(DC, Rect(Right - ExtLineWidth, Top, Right, Bottom), GridLinesBrush);
      Dec(Right, ExtLineWidth);
    end;
  Dec(R1.Bottom, Node.ViewInfo.PreviewSize);

  if Node.NodeType in [ntCaption, ntGroup] then
  begin
    GetContentParams(Node, nil, @ABrush, @ATextColor, @ABkColor, @AFont, True);
    if Node.NodeType = ntCaption then
      S := FCaption
    else
      with GroupColumns[Node.GroupIndex] do
        S := Caption + ' : ' + GetGroupDisplayText(Node);
    FControl.DrawText(DC, R1, AFont, ABrush, ATextColor, ABkColor, taLeftJustify,
      S, True, True, True, False);
  end
  else
  begin
    R2 := R1;
    GetMem(P, 2 * 4 * VisibleColumnCount * SizeOf(TPoint));
    GetMem(C, 4 * VisibleColumnCount * SizeOf(DWORD));
    if IsMultiRows then
    begin
      GetMem(RectsP, 4 * VisibleColumnCount * SizeOf(TPoint));
      GetMem(RectsC, VisibleColumnCount * SizeOf(DWORD));
    end
    else
    begin
      RectsP := nil;
      RectsC := nil;
    end;
    J := 0;
    GetContentParams(Node, nil, @ABrush, nil, nil, nil, True);
    try
      // draw data in cells
      for I := 0 to VisibleColumnCount - 1 do
      begin
        Column := VisibleColumns[I];
        with Column, R1 do
        begin
          R1 := GetContentBounds(Node);
          Inc(Left, AddInWidth);
          if Left = Right then Continue;
          if not FHorizontal then
          begin
            K := FLayout.ContentWidths[ColIndex];
            L := Left + K;
            if (ColIndex = FLayout.Count - 1) and (RowIndex = 0) and (L < R2.Right) then
              FillRect(DC, Rect(L, Top, R2.Right, R2.Bottom), ABrush);
            if L = R.Right then L := R2.Right;
            if Right < L then
              FillRect(DC,
                Rect(Right, Top, L, Bottom - Byte(Bottom = R.Bottom) * LineWidth),
                ABrush);
            if FLayout.IsColumnLast(Column) and (Bottom < R2.Bottom) then
              FillRect(DC, Rect(Left, Bottom, L, R2.Bottom), ABrush);
          end;
          HasLeftBorder := Left <> R.Left;
          HasTopBorder := Top <> R.Top;
          if AShowGrid then
          begin
            if HasLeftBorder then Dec(Left, LineWidth);
            if HasTopBorder then Dec(Top, LineWidth);
          end
          else
            if Right = R.Right then Dec(Right, ExtLineWidth);
          if IsMultiRows then
          begin
            K := 4 * I;
            RectsP[K] := TopLeft;
            with RectsP[K + 1] do
            begin
              X := Right;
              Y := Top;
            end;
            RectsP[K + 2] := BottomRight;
            with RectsP[K + 3] do
            begin
              X := Left;
              Y := Bottom;
            end;
            RectsC[I] := 4;
          end;  
          if not RectVisible(DC, R1) then Continue;
          // calc cell's border
          if AShowGrid then
          begin
            if HasLeftBorder then
            begin
              with P[J] do
              begin
                X := Left;
                Y := Top;
              end;
              with P[J + 1] do
              begin
                X := Left;
                Y := Bottom;
              end;
              Inc(J, 2);
              Inc(Left, LineWidth);
            end;
            if HasTopBorder then
            begin
              with P[J] do
              begin
                X := Left;
                Y := Top;
              end;
              with P[J + 1] do
              begin
                X := Right;
                Y := Top;
              end;
              Inc(J, 2);
              Inc(Top, LineWidth);
            end;
            with P[J] do
            begin
              X := Left;
              Y := Bottom - LineWidth;
            end;
            with P[J + 1] do
            begin
              X := Right;
              Y := P[J].Y;
            end;
            Inc(J, 2);
            Dec(Bottom, LineWidth);
            with P[J] do
            begin
              X := Right - LineWidth;
              Y := Top;
            end;
            with P[J + 1] do
            begin
              X := P[J].X;
              Y := Bottom;
            end;
            Inc(J, 2);
            Dec(Right, LineWidth);
          end;
          // draw cell's content
          DrawContent(DC, R1, Node);
        end;
      end;  
      // draw grid
      J := J div 2;
      if J <> 0 then
      begin
        for I := 0 to J - 1 do C[I] := 2;
        FGridLinesPen := SelectObject(DC, FGridLinesPen);
        PolyPolyLine(DC, P^, C^, J);
        FGridLinesPen := SelectObject(DC, FGridLinesPen);
      end;
      // fill in rest space
      if IsMultiRows then
      begin
        RestRgn := CreateRectRgnIndirect(R2);
        Rgn := CreatePolyPolygonRgn(RectsP^, RectsC^, VisibleColumnCount, WINDING);
        CombineRgn(RestRgn, RestRgn, Rgn, RGN_DIFF);
        DeleteObject(Rgn);
        FillRgn(DC, RestRgn, ABrush);
        DeleteObject(RestRgn);
      end;
    finally
      if IsMultiRows then
      begin
        FreeMem(RectsC, VisibleColumnCount * SizeOf(DWORD));
        FreeMem(RectsP, 4 * VisibleColumnCount * SizeOf(TPoint));
      end;
      FreeMem(C, 4 * VisibleColumnCount * SizeOf(DWORD));
      FreeMem(P, 2 * 4 * VisibleColumnCount * SizeOf(TPoint));
    end;
  end;  

  // draw preview
  if Node.ViewInfo.PreviewSize <> 0 then
  begin
    R1 := R2;
    R1.Top := R1.Bottom;
    R1.Bottom := R1.Top + Node.ViewInfo.PreviewSize;
    if RectVisible(DC, R1) then
      with R1 do
      begin
        R2 := R1;
        GetPreviewParams(Node, @ABrush, @ATextColor, nil, @AFont);
        if movUseBitmapToDrawPreview in FControl.OptionsView then
          with R1 do
          begin
            OffsetRect(R1, -Left, -Top);
            with FControl do
            begin
              PrepareBitmap(Right, Bottom);
              ADC := FBitmap.Canvas.Handle;
            end;
          end
        else
          ADC := DC;
        begin
          with R1 do
          begin
            FillRect(ADC, R1, ABrush);
            Inc(Left, FPreviewLeftIndent);
            Dec(Right, FPreviewRightIndent);
            Inc(Top);
            Dec(Bottom);
          end;
          SetTextColor(ADC, ColorToRGB(ATextColor));
          SetBkMode(ADC, TRANSPARENT);
          PrevFont := SelectObject(ADC, AFont.Handle);
          Windows.DrawText(ADC, PChar(Node.PreviewText), Length(Node.PreviewText), R1,
            DT_EXPANDTABS or DT_NOPREFIX or DT_WORDBREAK);
          SelectObject(ADC, PrevFont);
          SetBkMode(ADC, OPAQUE);
        end;
        if movUseBitmapToDrawPreview in FControl.OptionsView then
          with R2 do
            BitBlt(DC, Left, Top, Right - Left, Bottom - Top, ADC, 0, 0, SRCCOPY);
      end;
  end;

  // draw focus rect
  if Node.Focused then
    if {true}Node.Horizontal or not ShowHeader then
      DrawFocus(R)
    else
    begin
      R2 := R;
      for I := 0 to FLayout.Count - 1 do
        with FLayout, R2 do
        begin
          Inc(Left, HeaderWidths[I]);
          Right := Left + ContentWidths[I];
          Bottom := Top + Items[I].Count * ContentRealHeight;
          DrawFocus(R2);
          Left := Right;
        end;
    end;

  // draw separator of level or row
  if Node.NodeType = ntData then
    if Node.Expanded then
      if LevelSeparatorWidth <> 0 then
        with R do
        begin
          GetContentParams(Node, nil, @ABrush, nil, nil, nil, False);
          FillRect(DC,
            Rect(Left - LevelIndent, Bottom, Left, Bottom + LevelSeparatorWidth),
            ABrush);
          FillRect(DC,
            Rect(Left, Bottom, Left + ExtLineWidth, Bottom + LevelSeparatorWidth),
            GridLinesBrush);
          FillRect(DC,
            Rect(Left + ExtLineWidth, Bottom, FControl.ClientWidth, Bottom + LevelSeparatorWidth),
            LevelSeparatorBrush);
        end
      else
    else
      if RowSeparatorWidth <> 0 then
        with R do
        begin
          FillRect(DC,
            Rect(ARect.Left, Bottom, Right, Bottom + RowSeparatorWidth),
            RowSeparatorBrush);
          FillRect(DC,
            Rect(Right, Bottom, FControl.ClientWidth, Bottom + RowSeparatorWidth),
            FControl.Brush.Handle);
        end;

  // draw rest space
  with R do
  begin
    Left := Right;
    Right := FControl.ClientWidth;
  end;
  FillRect(DC, R, FControl.Brush.Handle);
end;

procedure TdxMasterViewLevel.DrawFooter(DC: HDC; const ARect: TRect; Node: TdxMasterViewNode);
var
  ABrush: HBRUSH;
  R, R1, R2: TRect;
  RestRgn, Rgn: HRGN;
  I, J, K: Integer;

  procedure ExcludeRect(const R: TRect);
  begin
    Rgn := CreateRectRgnIndirect(R);
    CombineRgn(RestRgn, RestRgn, Rgn, RGN_DIFF);
    DeleteObject(Rgn);
  end;

begin
  R := ARect;
  for I := 0 to Node.ViewInfo.EndLevelCount - 1 do
    with Parents[I] do
    begin
      if Node.HasFooter(I) then
      begin
        GetFooterParams(Node, nil, @ABrush, nil, nil, nil);
        R2 := Node.SubFooterBounds[I];
        Inc(R.Top, R2.Bottom - R2.Top);
        DrawEdge(DC, R2, BDR_RAISEDINNER, BF_RECT);
        InflateRect(R2, -1, -1);
        RestRgn := CreateRectRgnIndirect(R2);
        try
          for J := 0 to VisibleColumnCount - 1 do
            with VisibleColumns[J], R1 do
            begin
              R1 := GetFooterBounds(Node);
              InflateRect(R1, -1, -1);
              ExcludeRect(R1);
              if (Left >= Right) or not RectVisible(DC, R1) then Continue;
              if SummaryType = stNone then
                FillRect(DC, R1, ABrush)
              else
              begin
                FrameRect(DC, R1, ABrush);
                InflateRect(R1, -1, -1);
                DrawEdge(DC, R1, BDR_SUNKENOUTER, BF_RECT);
                InflateRect(R1, -1, -1);
                // draw summary's content
                DrawFooter(DC, R1, Node);
              end;
            end;
        finally
          // fill in rest space
          FillRgn(DC, RestRgn, ABrush);
          DeleteObject(RestRgn);
          // draw rest space
          InflateRect(R2, 1, 1);
          with R2 do
          begin
            Left := Right;
            Right := FControl.ClientWidth;
            FillRect(DC, R2, {Content}FControl.Brush.Handle);
          end;
        end;
      end;
      if Parent.Parent <> nil then
      begin
        J := R.Left;
        if (I <> 0) or (Node.NodeType = ntData) then
          Dec(J, (Byte(ShowCaption) + GroupColumnCount) * (LevelIndent + ExtLineWidth))
        else
          if Node.NodeType = ntGroup then
            Dec(J, (Byte(ShowCaption) + Node.GroupIndex) * (LevelIndent + ExtLineWidth));
        with Parent, R do
        begin
          if (LevelSeparatorWidth <> 0) and Node.HasLevelSeparator(I) then
          begin
            FillRect(DC,
              Rect(J, Top, FControl.ClientWidth, Top + LevelSeparatorWidth),
              LevelSeparatorBrush);
            Inc(Top, LevelSeparatorWidth);
          end;
          if (RowSeparatorWidth <> 0) and Node.HasRowSeparator(I) then
          begin
            K := Indent + VisibleWidth - FControl.LeftPos{?!};
            FillRect(DC,
              Rect(J, Top, K, Top + RowSeparatorWidth), RowSeparatorBrush);
            FillRect(DC,
              Rect(K, Top, FControl.ClientWidth, Top + RowSeparatorWidth),
              FControl.Brush.Handle);
            Inc(Top, RowSeparatorWidth);
          end;
          Left := J - (LevelIndent + ExtLineWidth + LevelSeparatorWidth);
        end;  
      end;
    end;
end;

procedure TdxMasterViewLevel.EditingChanged;
begin
  if (FDataLink.DataSet.State = dsEdit) {and CanSmartRefresh }then
    FEditingNode := FControl.NodeFromID(Self, GetCurIDValue);
end;

procedure TdxMasterViewLevel.FooterStyleChanged(Values: TdxMasterViewStyleValues);
var
  Size: TSize;
  H, I: Integer;
begin
  if (Values = []) or (svFont in Values) then
  begin
    if VisibleColumnCount =  0 then
    begin
      CalcFontSize(FooterFont, Size);
      H := Size.cy;
    end
    else
    begin
      H := 0;
      for I := 0 to VisibleColumnCount - 1 do
      begin
        CalcFontSize(VisibleColumns[I].FooterFont, Size);
        if Size.cy > H then H := Size.cy;
      end;
    end;
    FFooterHeight := H + 2 + 2 * 3;  // 21
  end;
  LevelChanged(False);
end;

function TdxMasterViewLevel.GetCurDetailKeyValue: Variant;
var
  I: Integer;
begin
  I := FDetailKeyFields.Count;
  case I of
    0: Result := Unassigned;
    1: Result := TField(FDetailKeyFields[0]).Value;
  else
    Result := VarArrayCreate([0, I - 1], varVariant);
    for I := 0 to I - 1 do
      Result[I] := TField(FDetailKeyFields[I]).Value;
  end;
end;

function TdxMasterViewLevel.GetCurIDValue: Variant;
var
  I: Integer;
begin
  I := FIDFields.Count;
  case I of
    0: Result := Unassigned;
    1: Result := TField(FIDFields[0]).Value;
  else
    Result := VarArrayCreate([0, I - 1], varVariant);
    for I := 0 to I - 1 do
      Result[I] := TField(FIDFields[I]).Value;
  end;
end;

function TdxMasterViewLevel.GetCurKeyValue: Variant;
var
  I: Integer;
begin
  I := FItems.Count;
  if I = 0 then Result := Unassigned
  else
  begin
    Result := VarArrayCreate([0, I - 1], varVariant);
    for I := 0 to I - 1 do
      Result[I] := TdxMasterViewLevel(FItems[I]).GetCurMasterKeyValue;
  end;
end;

function TdxMasterViewLevel.GetCurMasterKeyValue: Variant;
var
  I: Integer;
begin
  I := FMasterKeyFields.Count;
  case I of
    0: Result := Unassigned;
    1: Result := TField(FMasterKeyFields[0]).Value;
  else
    Result := VarArrayCreate([0, I - 1], varVariant);
    for I := 0 to I - 1 do
      Result[I] := TField(FMasterKeyFields[I]).Value;
  end;
end;

function TdxMasterViewLevel.GetCurPreviewText(Node: TdxMasterViewNode): string;
begin
  if PreviewField = nil then Result := ''
  else
  begin
    Result := PreviewField.AsString;
    if (FPreviewMaxLength <> 0) and (Length(Result) > FPreviewMaxLength) then
      Result := Copy(Result, 1, FPreviewMaxLength);
  end;
  if Assigned(FOnGetPreviewText) then FOnGetPreviewText(Self, Node, Result);
end;

function TdxMasterViewLevel.GetParentNode(Root, Node: TdxMasterViewNode;
  FirstIndex, AvailIndex: PInteger; RestItems: TList;
  CheckRoot: Boolean): TdxMasterViewNode;
var
  I, L, R, C, CResult, APos: Integer;

  function CompareGroupValues(const Node: TdxMasterViewNode): Integer;
  begin
    GPNCurValue := Node.GroupValue;
    GPNCurValueIsNull := VarIsNull(GPNCurValue);
    if GPNFindingValueIsNull or GPNCurValueIsNull then
      if GPNFindingValueIsNull and GPNCurValueIsNull then
        Result := 0
      else
        if GPNFindingValueIsNull then
          Result := 1
        else
          Result := -1
    else
      if VarType(GPNFindingValue) <> VarType(GPNCurValue) then
      begin
        Result := -1;
        Exit;
      end
      else
      begin
        if GPNCanUseCaseInsensitiveGrouping then
          GPNCurValue := VarAnsiUpperCase(GPNCurValue);
        if GPNCanUseAnsiCompareStrOnGrouping then
        begin
          GPNS2 := GPNCurValue;
          Result := CompareString(LOCALE_USER_DEFAULT, 0,
            PChar(GPNS1), Length(GPNS1), PChar(GPNS2), Length(GPNS2)) - 2;
        end
        else
          if GPNCurValue < GPNFindingValue then
            Result := -1
          else
            if GPNCurValue = GPNFindingValue then
              Result := 0
            else
              Result := 1;
      end;
    if GPNReverseOrder then Result := -Result;
  end;

  function NodeFromGroupValue(const Root: TdxMasterViewNode;
    var AParentNode: TdxMasterViewNode): Integer;
  begin
    Result := 0;
    if I = 0 then
    begin
      if FirstIndex = nil then
      begin
        AParentNode := Root.FirstInLevel[Self];
        if AParentNode = nil then
        begin
          Result := Root.GetAvailIndex(Index);
          Exit;
        end;
        L := AParentNode.Index;
      end
      else
        L := FirstIndex^;
      AParentNode := nil;
      if AvailIndex = nil then
        R := L + Root.CountInLevel[Self] - 1
      else
        R := AvailIndex^ - 1;
      if L > R then
      begin
        Result := R + 1;
        Exit;
      end;
    end
    else
    begin
      AParentNode := nil;
      R := Root.FItems.Count - 1;
      if R = -1 then Exit;
      L := 0;
    end;

    while L <= R do
    begin
      C := (L + R) div 2;
      CResult := CompareGroupValues(Root.FItems[C]);
      case CResult of
        0: begin
             Result := C;
             AParentNode := Root.FItems[C];
             Exit;
           end;
       -1: L := C + 1;
        1: R := C - 1;
      end;
    end;
    Result := C;
    if CResult = -1 then Inc(Result);
  end;

  procedure RemoveNodeFromRestItems(const Node: TdxMasterViewNode);
  begin
    R := RestItems.Count - 1;
    if R = -1 then Exit;
    L := 0;
    while L <= R do
    begin
      C := (L + R) div 2;
      CResult := Integer(Node) - Integer(RestItems.List^[C]);
      if CResult = 0 then
      begin
        RestItems.Delete(C);
        Break;
      end
      else
        if CResult < 0 then
          R := C - 1
        else
          L := C + 1;
    end;
  end;

begin
  if CheckRoot then
  begin
    if (Root = nil) or not Root.Expanded and SmartLoad then
    begin
      Result := nil;
      Exit;
    end
    else
      Result := Root;
    if (Result.NodeType = ntData) and ShowCaption then
    begin
      Result := Result.FirstInLevel[Self];
      if not Result.Expanded and SmartLoad then
      begin
        Result := nil;
        Exit;
      end
    end;
  end
  else
    Result := Root;

  for I := 0 to FGroupColumns.Count - 1 do
  begin
    GPNCanUseAnsiCompareStrOnGrouping := False;
    GPNCanUseCaseInsensitiveGrouping := False;
    with TdxMasterViewColumn(FGroupColumns[I]) do
      if {(Node = nil)!!! and} (Field = nil) then
      begin
        GPNGroupValue := Null;
        GPNDisplayText := '';
        GPNFindingValue := Null;
      end
      else
      begin
        if Node = nil then
        begin
          GPNGroupValue := Field.Value;
          GPNDisplayText := Field.DisplayText;
        end
        else
        begin
          GPNGroupValue := Node.Values[Index];
          GPNDisplayText := Node.Strings[Index];
        end;
        GPNFindingValue := GPNGroupValue;
        if not VarIsNull(GPNFindingValue) and
          (VarType(GPNFindingValue) = varString) then
        begin
          GPNCanUseAnsiCompareStrOnGrouping :=
            mobAnsiCompareStrOnGrouping in FControl.OptionsBehavior;
          GPNCanUseCaseInsensitiveGrouping :=
            mobCaseInsensitiveGrouping in FControl.OptionsBehavior;
          if GPNCanUseCaseInsensitiveGrouping then
            GPNFindingValue := VarAnsiUpperCase(GPNFindingValue);
          if GPNCanUseAnsiCompareStrOnGrouping then
            GPNS1 := GPNFindingValue;
        end;
      end;
    GPNFindingValueIsNull := VarIsNull(GPNFindingValue);
    GPNReverseOrder :=
      TdxMasterViewColumn(FGroupColumns[Result.GroupIndex + 1]).SortOrder = soDescending;
    APos := NodeFromGroupValue(Result, GPNParentNode);
    if GPNParentNode = nil then
    begin
      if (I = 0) and (AvailIndex <> nil) then
        Inc(AvailIndex^);
      with Result do
        GPNParentNode := Add(Self, APos, ntGroup, GPNDisplayText, GPNGroupValue);
    end
    else
      if RestItems <> nil then RemoveNodeFromRestItems(GPNParentNode);
    Result := GPNParentNode;
  end;
  Result.CheckSummaries;
end;

procedure TdxMasterViewLevel.GroupByBoxStyleChanged(Values: TdxMasterViewStyleValues);
var
  Size: TSize;
begin
  if (Values = []) or (svFont in Values) then
  begin
    CalcFontSize(GroupByBoxFont, Size);
    FGroupByBoxTextHeight := Size.cy + 2 + 2 * 2;  // 19
  end;
  if ShowGroupByBox then LevelChanged(False);
end;

procedure TdxMasterViewLevel.GroupStyleChanged(Values: TdxMasterViewStyleValues);
var
  Size: TSize;
begin
  if (Values = []) or (svFont in Values) then
  begin
    CalcFontSize(GroupFont, Size);
    FGroupHeight := Size.cy + 2 + 2;  // 17 - without line
  end;
  if GroupColumnCount <> 0 then LevelChanged(False);
end;

function TdxMasterViewLevel.HasExpandButton: Boolean;
begin
  Result := HasChildren and (VisibleColumnCount <> 0);
end;

function TdxMasterViewLevel.HasGrid: Boolean;
begin
  Result := ShowGrid and (not ShowPreview or ShowGridWithPreview);
end;
{
function TdxMasterViewLevel.HasAsChild(Level: TdxMasterViewLevel): Boolean;
var
  I: Integer;
  ALevel: TdxMasterViewLevel;
begin
  Result := False;
  for I := AbsoluteIndex to FControl.AbsoluteLevelCount - 1 do
  begin
    ALevel := FControl.AbsoluteLevels[I];
    if ALevel.Parent = Parent then Break;
    if Level = ALevel then
    begin
      Result := True;
      Break;
    end;
  end;
end;
}
function TdxMasterViewLevel.HasAsParent(Level: TdxMasterViewLevel): Boolean;
var
  ALevel: TdxMasterViewLevel;
begin
  ALevel := Self;
  while (ALevel <> nil) and (ALevel <> Level) do
    ALevel := ALevel.Parent;
  Result := ALevel <> nil;
end;

procedure TdxMasterViewLevel.HeaderStyleChanged(Values: TdxMasterViewStyleValues);
var
  Size: TSize;
  H, I: Integer;
begin
  if (Values = []) or (svFont in Values) then
  begin
    if VisibleColumnCount =  0 then
    begin
      CalcFontSize(HeaderFont, Size);
      H := Size.cy;
    end
    else
    begin
      H := 0;
      for I := 0 to VisibleColumnCount - 1 do
      begin
        CalcFontSize(VisibleColumns[I].HeaderFont, Size);
        if Size.cy > H then H := Size.cy;
      end;
    end;
    FHeaderHeight := H + 2 + 2 * 2;  // 19
    CalcRealHeights;
    if ShowHeader then CalcDefaultWidths(nil);
  end;
  if ShowHeader then LevelChanged(False);
  if GroupColumnCount <> 0 then
    GroupByBoxStyleChanged(Values);
end;

function TdxMasterViewLevel.IndexOfParent(Level: TdxMasterViewLevel): Integer;
begin
  for Result := 0 to FParentCount - 1 do
    if FParents[Result] = Level then Exit;
  Result := -1;
end;

procedure TdxMasterViewLevel.LayoutChanged;
var
  I: Integer;
begin
  RefreshDetailKeyFieldsList;
  RefreshIDFieldsList;
  for I := 0 to Count - 1 do
    Items[I].RefreshMasterKeyFieldsList;
  SetPreviewFieldInternally(FindPreviewField);

  for I := 0 to ColumnCount - 1 do
    with Columns[I] do
    begin
      SetFieldInternally(FindField);
      if cvSummaryFieldName in AssignedValues then
        SetSummaryFieldInternally(FindSummaryField);
    end;

  CalcDefaultWidths(nil);
  WidthChangedEx;
end;

procedure TdxMasterViewLevel.LevelChanged(HardRefresh: Boolean);
var
  PrevCursor: TCursor;
begin
  if IsDestroying then Exit;
  if FControl <> nil then
  begin
    if FControl.IsLoading then Exit;
    if HardRefresh then
    begin
      if (FDataChangingLockCount <> 0) or (FControl.FLayoutLockCount <> 0) or
        IsLoading or FControl.IsDestroying then Exit;
      FControl.DoBeforeUpdateData(Self);
      try
        if FParent = nil then
          if FControl.FItems <> nil then
            with FControl do
            begin
              FItems.UpdateData(False, True, False);
              CanUseSmartReload := True;
            end
          else
        else
        begin
          PrevCursor := Screen.Cursor;
          if FControl.ShowHourGlassCursor then Screen.Cursor := crHourGlass;
          FControl.BeginTopNodeChange;
          try
            FControl.BeginUpdate;
            try
              BeginLoad;
              try
                FControl.FItems.UpdateDataForLevel(Self);
              finally
                EndLoad(True);
              end;
            finally
              try
                if not FControl.SyncMove then SyncPos;
              finally
                FControl.EndUpdate;
                if FControl.SyncMove then SyncPos;
                if FControl.ShowHourGlassCursor then Screen.Cursor := PrevCursor;
                FCanUseSmartReload := True;
              end;
            end;
          finally
            FControl.EndTopNodeChange;
          end;
        end;
      finally
        FControl.DoAfterUpdateData(Self);
      end;
    end
    else
      FControl.Invalidate;
  end;    
end;

function TdxMasterViewLevel.LoadDataOnExpand: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Count - 1 do
    if Items[I].SmartLoad then Exit;
  Result := False;
end;

function MakeVisibleColumnsSortedListCompareHor(Column1, Column2: TdxMasterViewColumn): Integer;
begin
  if Column1.FRowIndex < Column2.FRowIndex then
    Result := -1
  else
    if Column1.FRowIndex > Column2.FRowIndex then
      Result := 1
    else
      if Column1.FColIndex < Column2.FColIndex then
        Result := -1
      else
        if Column1.FColIndex > Column2.FColIndex then
          Result := 1
        else
          Result := 0;
end;

function MakeVisibleColumnsSortedListCompareVer(Column1, Column2: TdxMasterViewColumn): Integer;
begin
  if Column1.FColIndex < Column2.FColIndex then
    Result := -1
  else
    if Column1.FColIndex > Column2.FColIndex then
      Result := 1
    else
      if Column1.FRowIndex < Column2.FRowIndex then
        Result := -1
      else
        if Column1.FRowIndex > Column2.FRowIndex then
          Result := 1
        else
          Result := 0;
end;

procedure TdxMasterViewLevel.MakeVisibleColumnsSortedList(List: TList);
begin
  List.Count := VisibleColumnCount;
  Move(FVisibleColumns.List^, List.List^, List.Count * SizeOf(Pointer));
  if FHorizontal then
    List.Sort(@MakeVisibleColumnsSortedListCompareHor)
  else
    List.Sort(@MakeVisibleColumnsSortedListCompareVer);
end;
{
function TdxMasterViewLevel.ParentIndex(Level: TdxMasterViewLevel): Integer;
var
  ALevel: TdxMasterViewLevel;
begin
  Result := 0;
  ALevel := Self;
  while (ALevel <> nil) and (ALevel <> Level) do
  begin
    Inc(Result);
    ALevel := ALevel.Parent;
  end;
  if ALevel = nil then Result := -1;
end;
}
procedure TdxMasterViewLevel.PreviewChanged;
var
  I: Integer;
begin
  if (FControl = nil) or not ShowPreview then Exit;
  with FControl do
    for I := 0 to AbsoluteItemCount - 1 do
      AbsoluteItems[I].FViewInfo.PreviewSize := 0;
  if not FControl.FPainting then LevelChanged(False);
end;

procedure TdxMasterViewLevel.PreviewStyleChanged(Values: TdxMasterViewStyleValues);
begin
  if (Values = []) or (svFont in Values) then
    PreviewChanged
  else
    if ShowPreview then LevelChanged(False);
end;

procedure TdxMasterViewLevel.RecordChanged(Field: TField);
begin
{  if not FControl.SyncMove or (FDataLink.DataSet.State = dsSetKey) then Exit;
  if FInsertedNode <> nil then
    with FInsertedNode do
    begin
      UpdateData(True, False, False);
      Invalidate(nil, vpContent);
    end;
  if FEditingNode <> nil then
    with FEditingNode do
    begin
      UpdateData(True, False, False);
      Invalidate(nil, vpContent);
    end;}
end;

procedure TdxMasterViewLevel.RemoveFreeSpace;
begin
  FLayout.RemoveFreeSpace;
end;

type
  PColumnPlace = ^TColumnPlace;
  TColumnPlace = record
    Column: TdxMasterViewColumn;
    RowIndex, ColIndex, RowCount: Integer;
  end;

procedure TdxMasterViewLevel.RestoreVisibleColumnsPlaces(var List: TList);
var
  I: Integer;
begin
  FLayout.BeginUpdate;
  try
    for I := 0 to List.Count - 1 do
      with PColumnPlace(List[I])^ do
      begin
        Column.RowIndex := RowIndex;
        Column.ColIndex := ColIndex;
        Column.RowCount := RowCount;
      end;
  finally
    FLayout.EndUpdate;
    FreeVisibleColumnsPlaces(List);
  end;
end;

procedure TdxMasterViewLevel.SaveVisibleColumnsPlaces(var List: TList);
var
  I: Integer;
  ColumnPlace: PColumnPlace;
begin
  List := TList.Create;
  MakeVisibleColumnsSortedList(List);
  for I := 0 to List.Count - 1 do
  begin
    New(ColumnPlace);
    ColumnPlace^.Column := List[I];
    List[I] := ColumnPlace;
    with ColumnPlace^ do
    begin
      RowIndex := Column.RowIndex;
      ColIndex := Column.ColIndex;
      RowCount := Column.RowCount;
    end;
  end;
end;

procedure TdxMasterViewLevel.FreeVisibleColumnsPlaces(var List: TList);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do
    Dispose(PColumnPlace(List[I]));
  List.Free;
  List := nil;
end;

procedure TdxMasterViewLevel.SyncPos;
var
  I, AFreezeCount: Integer;
  Value: Variant;
  Node: TdxMasterViewNode;
  Level: TdxMasterViewLevel;
{
  ft,lt:integer;}
begin
  if not FControl.SyncMove then
  begin
    if FControl.FocusedNode <> nil then
      with FControl do
      begin
        FocusedNode.MakeVisible;
        ShowFocusedNode;
      end;
    Exit;
  end;

//  ft:=gettickcount;
                 
  for I := 0 to ParentCount - 3 do
    with Parents[I] do
      if Active then
        if DataSet = Parent.DataSet then
          Continue
        else
          //if Parent.DataSet.Active then
          begin
            Value := GetCurDetailKeyValue;
            if not VarAreEqual(GetCurMasterKeyValue, Value) then
            begin
              AFreezeCount := FControl.FreezeDataSet(Parent);
              try
                Parent.DataSet.Locate(MasterKey, Value, []);
              finally
                if Parent.DataLink.FreezeCount = AFreezeCount then
                  FControl.UnfreezeDataSet(Parent);
              end;
            end;
          end
          {else
            Break}
      else
        Break;

  Node := FControl.FItems;
  for I := ParentCount - 2 downto 0 do
  begin
    Level := Parents[I];
    Node := Node.NodeFromID(Level, Level.GetCurIDValue);
    if Node = nil then
      Break
    else
    begin
      Node.MakeVisible;
      if I = 0 then
        with FControl do
        begin
          Freeze;
          try
            FocusNode(Node, True);
          finally
            Unfreeze;
          end;
        end;
    end;
  end;

//  lt:=gettickcount;
//  application.mainform.caption:=inttostr(lt-ft);
end;

procedure TdxMasterViewLevel.UncheckTriedToExpand;

  procedure ProcessOneNode(Node: TdxMasterViewNode);
  var
    I: Integer;
  begin
    with Node do
      if (NodeType = ntData) and (Level = Self) then
        FTriedToExpand := False
      else
      begin
        if ContainsDataInChildren(Self) then
          FTriedToExpand := False;
        if Self.HasAsParent(Level) then
          for I := 0 to Count - 1 do
            ProcessOneNode(Items[I]);
      end;
  end;

begin
  ProcessOneNode(FControl.Items);
end;

procedure TdxMasterViewLevel.WidthChanged;
var
  AWidth: Integer;
begin
  if (FAssignWidthsLockCount = 0) and not IsLoading and not IsDestroying then
  begin
    AWidth := VisibleWidth;
    FLayout.CalcNeighbours;
    if not FHorizontal then FLayout.CalcColWidths;
    FControl.CalcScrollableWidth(Self);
    FLayout.CheckColumnsWidths(nil);
    if VisibleWidth <> AWidth then
    begin
      PreviewChanged;
      if Assigned(FOnWidthChanged) then FOnWidthChanged(Self);
    end;
  end;
end;

procedure TdxMasterViewLevel.WidthChangedEx;
begin
  WidthChanged;
  LevelChanged(False);
end;

procedure TdxMasterViewLevel.Assign(Source: TPersistent);
var
  ALevel: TdxMasterViewLevel;
  I: Integer;
begin
  if Source is TdxMasterViewLevel then
  begin
    ALevel := TdxMasterViewLevel(Source);

    BeginLoading;
    try
      DestroyColumns;
      
      Caption := ALevel.Caption;
      CaptionStyle := ALevel.CaptionStyle;
      ContentStyle := ALevel.ContentStyle;
      DataSource := ALevel.DataSource;
      DeleteConfirmCaptionText := ALevel.DeleteConfirmCaptionText;
      DeleteConfirmText := ALevel.DeleteConfirmText;
      DetailKey := ALevel.DetailKey;
      FooterStyle := ALevel.FooterStyle;
      GridLinesColor := ALevel.GridLinesColor;
      GroupByBoxStyle := ALevel.GroupByBoxStyle;
      GroupStyle := ALevel.GroupStyle;
      HeaderStyle := ALevel.HeaderStyle;
      ID := ALevel.ID;
      LevelSeparatorColor := ALevel.LevelSeparatorColor;
      LevelSeparatorWidth := ALevel.LevelSeparatorWidth;
      MasterKey := ALevel.MasterKey;
      MultipleDeleteConfirmText := ALevel.MultipleDeleteConfirmText;
      OptionsBehavior := ALevel.OptionsBehavior;
      OptionsCustomize := ALevel.OptionsCustomize;
      OptionsDB := ALevel.OptionsDB;
      OptionsHeader := ALevel.OptionsHeader;
      OptionsView := ALevel.OptionsView;
      PreviewFieldName := ALevel.PreviewFieldName;
      PreviewLeftIndent := ALevel.PreviewLeftIndent;
      PreviewLineCount := ALevel.PreviewLineCount;
      PreviewMaxLength := ALevel.PreviewMaxLength;
      PreviewMaxLineCount := ALevel.PreviewMaxLineCount;
      PreviewRightIndent := ALevel.PreviewRightIndent;
      PreviewStyle := ALevel.PreviewStyle;
      RowSeparatorColor := ALevel.RowSeparatorColor;
      RowSeparatorWidth := ALevel.RowSeparatorWidth;
      ViewMode := ALevel.ViewMode;
      if not FHorizontal then
      begin
        FLayout.Count := ALevel.Layout.Count;
        for I := 0 to ALevel.Layout.Count - 1 do
          if ALevel.Layout.HeaderWidthAssigned[I] then
            FLayout.HeaderWidths[I] := ALevel.Layout.HeaderWidths[I];
      end;      

      for I := 0 to ALevel.ColumnCount - 1 do
        CreateColumn(TdxMasterViewColumnClass(ALevel.Columns[I].ClassType)).Assign(ALevel.Columns[I]);
    finally
      EndLoading;
    end;
  end
  else
    inherited;
end;

function TdxMasterViewLevel.GetParentComponent: TComponent;
begin
  if IsTop then
    Result := FControl
  else
    Result := FParent;
end;

function TdxMasterViewLevel.HasParent: Boolean;
begin
  Result := True;
end;

function TdxMasterViewLevel.Add: TdxMasterViewLevel;
begin
  if ParentCount = 1 + 16 then Result := nil  // due to <Node>.ViewInfo.EndLevelData
  else
  begin
    Result := TdxMasterViewLevel.Create(FControl.Owner);
    AddItem(Result);
  end;  
end;

procedure TdxMasterViewLevel.BeginAssignWidths;
begin
  Inc(FAssignWidthsLockCount);
end;

procedure TdxMasterViewLevel.BeginDataChanging;
begin
  Inc(FDataChangingLockCount);
end;

procedure TdxMasterViewLevel.BeginLayout;
begin
  BeginAssignWidths;
  FLayout.BeginUpdate;
end;

procedure TdxMasterViewLevel.BeginSorting;
begin
  Inc(FSortingLockCount);
end;

procedure TdxMasterViewLevel.CancelAssignWidths;
begin
  if FAssignWidthsLockCount > 0 then
  begin
    Dec(FAssignWidthsLockCount);
    {if FAssignWidthsLockCount = 0 then
      FLayout.CheckColumnsWidths;}
  end;
end;

procedure TdxMasterViewLevel.CancelDataChanging;
begin
  if FDataChangingLockCount > 0 then
  begin
    Dec(FDataChangingLockCount);
  end;
end;

procedure TdxMasterViewLevel.CancelLayout;
begin
  FLayout.CancelUpdate;
  CancelAssignWidths;
end;

procedure TdxMasterViewLevel.CancelSorting;
begin
  if FSortingLockCount > 0 then
  begin
    Dec(FSortingLockCount);
  end;
end;

procedure TdxMasterViewLevel.Clear;
begin
  if Count = 0 then Exit;  
  if (FControl <> nil) and (FParent <> nil) then FControl.BeginLayout;
  try
    while Count <> 0 do Items[0].Free;
  finally
    if (FControl <> nil) and (FParent <> nil) then FControl.EndLayout;
  end;
end;

procedure TdxMasterViewLevel.ClearSorting(ExceptionalColumn: TdxMasterViewColumn);
begin
  ChangeSorting(ExceptionalColumn, soNone, -2);
end;

function TdxMasterViewLevel.ColumnByFieldName(const AFieldName: string): TdxMasterViewColumn;
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
  begin
    Result := Columns[I];
    if AnsiCompareText(Result.FieldName, AFieldName) = 0 then Exit;
  end;
  Result := nil;
end;

function TdxMasterViewLevel.ColumnByName(const AName: string): TdxMasterViewColumn;
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
  begin
    Result := Columns[I];
    if CompareText(Result.Name, AName) = 0 then Exit;
  end;
  Result := nil;
end;

procedure TdxMasterViewLevel.CreateAllColumns;
var
  PrevCursor: TCursor;
  I: Integer;

  function GetValidName(const S: string): string;
  const
    ValidChars = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
  var
    I: Integer;
  begin
    Result := '';
    for I := 1 to Length(S) do
      if S[I] in ValidChars then Result := Result + S[I];
  end;

begin
  if DataSet = nil then Exit;
  PrevCursor := Screen.Cursor;
  if FControl.ShowHourGlassCursor then Screen.Cursor := crHourglass;
  try
    FControl.BeginLayout;
    try
      BeginLayout;
      try
        with DataSet do
          for I := 0 to FieldCount - 1 do
            with CreateColumn(TdxMasterViewColumn) do
            begin
              FieldName := Fields[I].FieldName;
              Visible := Fields[I].Visible;
              try
                Name := Self.Name + GetValidName(FieldName);
              except
                on EComponentError do
                  if FControl.IsDesigning then
                    Name := dxMVDesigner.UniqueName(FControl, Self.Name + 'Column');
              end;
            end;
      finally
        EndLayout;
      end;
    finally
      FControl.EndLayout;
    end;
  finally    
    Screen.Cursor := PrevCursor;
  end;
end;

function TdxMasterViewLevel.CreateColumn(AColumnClass: TdxMasterViewColumnClass): TdxMasterViewColumn;
begin
  Result := AColumnClass.Create(Owner);
  AddColumn(Result);
end;

procedure TdxMasterViewLevel.DestroyColumns;
var
  LockControlLayout, LockSorting: Boolean;
begin
  if ColumnCount = 0 then Exit;
  LockControlLayout := GroupColumnCount <> 0;
  LockSorting := SortedColumnCount <> 0;
  if LockControlLayout then FControl.BeginLayout;
  try
    if LockSorting then BeginSorting;
    try
      BeginLayout;
      try
        while ColumnCount <> 0 do Columns[0].Free;
      finally
        EndLayout;
      end;
    finally
      if LockSorting then EndSorting;
    end;
  finally
    if LockControlLayout then FControl.EndLayout;
  end;
end;

procedure TdxMasterViewLevel.EndAssignWidths;
begin
  if FAssignWidthsLockCount > 0 then
  begin
    Dec(FAssignWidthsLockCount);
    if FAssignWidthsLockCount = 0 then WidthChanged;
  end;
end;

procedure TdxMasterViewLevel.EndDataChanging;
begin
  if FDataChangingLockCount > 0 then
  begin
    Dec(FDataChangingLockCount);
    if FDataChangingLockCount = 0 then LevelChanged(True);
  end;
end;

procedure TdxMasterViewLevel.EndLayout;
begin
  FLayout.EndUpdate;
  EndAssignWidths;
end;

procedure TdxMasterViewLevel.EndSorting;
begin
  if FSortingLockCount > 0 then
  begin
    Dec(FSortingLockCount);
    if FSortingLockCount = 0 then DoSorting;
  end;
end;

procedure TdxMasterViewLevel.GetContentParams(Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn; ABrush: PBRUSH; ATextColor, ABkColor: PColor;
  AFont: PFont; CheckSelected: Boolean);
var
  NewStyle: TdxMasterViewStyle;
  IsOdd: Boolean;
begin
  NewStyle := nil;
  case Node.NodeType of
    ntData:
      begin
        DoGetContentStyle(Node, Column, NewStyle);
        if Column <> nil then
          with Column do
            if Assigned(FOnGetContentStyle) then FOnGetContentStyle(Column, Node, NewStyle);
      end;
    ntCaption:
      if Assigned(FOnGetCaptionStyle) then FOnGetCaptionStyle(Self, Node, nil, NewStyle);
    ntGroup:
      if Assigned(FOnGetGroupStyle) then FOnGetGroupStyle(Self, Node, nil, NewStyle);
  end;

  if not CheckSelected or
    not FControl.GetSelectionParams(Node, ABrush, ATextColor, ABkColor) then
  begin
    IsOdd := Odd(Node.Index) and (Node.NodeType = ntData);

    if ABrush <> nil then
      if (NewStyle <> nil) and IsOdd and (svAnotherColor in NewStyle.AssignedValues) then
        ABrush^ := NewStyle.AnotherBrush
      else
        if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
          ABrush^ := NewStyle.Brush
        else
          case Node.NodeType of
            ntData:
              if Column = nil then
                if IsOdd then
                begin
                  ABrush^ := ContentAnotherBrush;
                  if ABrush^ = 0 then ABrush^ := ContentBrush;
                end
                else
                  ABrush^ := ContentBrush
              else
                if IsOdd then
                begin
                  ABrush^ := Column.ContentAnotherBrush;
                  if ABrush^ = 0 then ABrush^ := Column.ContentBrush;
                end
                else
                  ABrush^ := Column.ContentBrush;
            ntCaption:
              ABrush^ := CaptionBrush;
            ntGroup:
              ABrush^ := GroupBrush;
          end;
    if ATextColor <> nil then
      if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
        ATextColor^ := NewStyle.Font.Color
      else
        case Node.NodeType of
          ntData:
            ATextColor^ := Column.ContentFont.Color;
          ntCaption:
            ATextColor^ := CaptionFont.Color;
          ntGroup:
            ATextColor^ := GroupFont.Color;
        end;
    if ABkColor <> nil then
      if (NewStyle <> nil) and IsOdd and (svAnotherColor in NewStyle.AssignedValues) then
        ABkColor^ := NewStyle.AnotherColor
      else
        if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
          ABkColor^ := NewStyle.Color
        else
          case Node.NodeType of
            ntData:
              if IsOdd then
              begin
                ABkColor^ := Column.ContentAnotherColor;
                if ABkColor^ = clNone then ABkColor^ := Column.ContentColor;
              end
              else
                ABkColor^ := Column.ContentColor;
            ntCaption:
              ABkColor^ := CaptionColor;
            ntGroup:
              ABkColor^ := GroupColor;
          end;
  end;
  if AFont <> nil then
    if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
      AFont^ := NewStyle.Font
    else
      case Node.NodeType of
        ntData:
          AFont^ := Column.ContentFont;
        ntCaption:
          AFont^ := CaptionFont;
        ntGroup:
          AFont^ := GroupFont;
      end;
end;

procedure TdxMasterViewLevel.GetFooterParams(Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn; ABrush: PBRUSH; ATextColor, ABkColor: PColor;
  AFont: PFont);
var
  NewStyle: TdxMasterViewStyle;
begin
  NewStyle := nil;
  if Assigned(FOnGetFooterStyle) then FOnGetFooterStyle(Self, Node, Column, NewStyle);
  if Column <> nil then
    with Column do
      if Assigned(FOnGetFooterStyle) then FOnGetFooterStyle(Column, Node, NewStyle);

  if ABrush <> nil then
    if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
      ABrush^ := NewStyle.Brush
    else
      if Column = nil then
        ABrush^ := FooterBrush
      else
        ABrush^ := Column.FooterBrush;
  if ATextColor <> nil then
    if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
      ATextColor^ := NewStyle.Font.Color
    else
      ATextColor^ := Column.FooterFont.Color;
  if ABkColor <> nil then
    if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
      ABkColor^ := NewStyle.Color
    else
      ABkColor^ := Column.FooterColor;
  if AFont <> nil then
    if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
      AFont^ := NewStyle.Font
    else
      AFont^ := Column.FooterFont;
end;

procedure TdxMasterViewLevel.GetGroupByBoxParams(Node: TdxMasterViewNode;
  ABrush: PBRUSH; ATextColor, ABkColor: PColor; AFont: PFont);
var
  NewStyle: TdxMasterViewStyle;
begin
  NewStyle := nil;
  if Assigned(FOnGetGroupByBoxStyle) then FOnGetGroupByBoxStyle(Self, Node, nil, NewStyle);

  if ABrush <> nil then
    if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
      ABrush^ := NewStyle.Brush
    else
      ABrush^ := GroupByBoxBrush;
  if ATextColor <> nil then
    if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
      ATextColor^ := NewStyle.Font.Color
    else
      ATextColor^ := GroupByBoxFontColor;
  if ABkColor <> nil then
    if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
      ABkColor^ := NewStyle.Color
    else
      ABkColor^ := GroupByBoxColor;
  if AFont <> nil then
    if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
      AFont^ := NewStyle.Font
    else
      AFont^ := GroupByBoxFont;
end;

procedure TdxMasterViewLevel.GetHeaderParams(Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn; ABrush, ARestSpaceBrush: PBRUSH;
  ATextColor, ABkColor: PColor; AFont: PFont);
var
  NewStyle: TdxMasterViewStyle;
begin
  NewStyle := nil;
  if Assigned(FOnGetHeaderStyle) then FOnGetHeaderStyle(Self, Node, Column, NewStyle);
  if Column <> nil then
    with Column do
      if Assigned(FOnGetHeaderStyle) then FOnGetHeaderStyle(Column, Node, NewStyle);

  if ABrush <> nil then
    if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
      ABrush^ := NewStyle.Brush
    else
      ABrush^ := Column.HeaderBrush;
  if ARestSpaceBrush <> nil then
    if (NewStyle <> nil) and (svAnotherColor in NewStyle.AssignedValues) then
      ARestSpaceBrush^ := NewStyle.AnotherBrush
    else
      ARestSpaceBrush^ := HeaderRestSpaceBrush;
  if ATextColor <> nil then
    if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
      ATextColor^ := NewStyle.Font.Color
    else
      ATextColor^ := Column.HeaderFont.Color;
  if ABkColor <> nil then
    if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
      ABkColor^ := NewStyle.Color
    else
      ABkColor^ := Column.HeaderColor;
  if AFont <> nil then
    if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
      AFont^ := NewStyle.Font
    else
      AFont^ := Column.HeaderFont;
end;

procedure TdxMasterViewLevel.GetPreviewParams(Node: TdxMasterViewNode;
  ABrush: PBRUSH; ATextColor, ABkColor: PColor; AFont: PFont);
var
  NewStyle: TdxMasterViewStyle;
  IsOdd: Boolean;
begin
  NewStyle := nil;
  DoGetContentStyle(Node, nil, NewStyle);
  if Assigned(FOnGetPreviewStyle) then FOnGetPreviewStyle(Self, Node, nil, NewStyle);

  if not FControl.GetSelectionParams(Node, ABrush, ATextColor, ABkColor) then
  begin
    IsOdd := Odd(Node.Index) and (Node.NodeType = ntData);
    if ABrush <> nil then
      if (NewStyle <> nil) and IsOdd and (svAnotherColor in NewStyle.AssignedValues) then
        ABrush^ := NewStyle.AnotherBrush
      else
        if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
          ABrush^ := NewStyle.Brush
        else
          if IsOdd then
          begin
            ABrush^ := PreviewAnotherBrush;
            if ABrush^ = 0 then ABrush^ := PreviewBrush;
          end
          else
            ABrush^ := PreviewBrush;
    if ATextColor <> nil then
      if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
        ATextColor^ := NewStyle.Font.Color
      else
        ATextColor^ := PreviewFontColor;
    if ABkColor <> nil then
      if (NewStyle <> nil) and IsOdd and (svAnotherColor in NewStyle.AssignedValues) then
        ABkColor^ := NewStyle.AnotherColor
      else
        if (NewStyle <> nil) and (svColor in NewStyle.AssignedValues) then
          ABkColor^ := NewStyle.Color
        else
          if IsOdd then
          begin
            ABkColor^ := PreviewAnotherColor;
            if ABkColor^ = clNone then ABkColor^ := PreviewColor;
          end
          else
            ABkColor^ := PreviewColor;
  end;
  if AFont <> nil then
    if (NewStyle <> nil) and (svFont in NewStyle.AssignedValues) then
      AFont^ := NewStyle.Font
    else
      AFont^ := PreviewFont;
end;

{ TdxMasterViewList }

constructor TdxMasterViewList.Create(AOwner: TdxMasterViewNode;
  AMode: TdxMasterViewListMode);
begin
  FOwner := AOwner;
  FMode := AMode;
end;

destructor TdxMasterViewList.Destroy;
begin
  Clear;
  inherited;
end;

function TdxMasterViewList.Get(Index: Integer): TdxMasterViewNode;
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  Result := FList^[Index];
end;

procedure TdxMasterViewList.Put(Index: Integer; Item: TdxMasterViewNode);
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  FList^[Index] := Item;
end;

procedure TdxMasterViewList.SetCapacity(NewCapacity: Integer);
begin
  if (NewCapacity < FCount) or (NewCapacity > MaxListSize) then
    Error(SListCapacityError, NewCapacity);
  if NewCapacity <> FCapacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(Pointer));
    FCapacity := NewCapacity;
  end;
end;

procedure TdxMasterViewList.SetCount(NewCount: Integer);
var
  I: Integer;
begin
  if (NewCount < 0) or (NewCount > MaxListSize) then
    Error(SListCountError, NewCount);
  if NewCount > FCapacity then SetCapacity(NewCount);
  if NewCount > FCount then
    FillChar(FList^[FCount], (NewCount - FCount) * SizeOf(Pointer), 0)
  else
    for I := FCount - 1 downto NewCount do Delete(I);
  FCount := NewCount;
end;

procedure TdxMasterViewList.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else
    if FCapacity > 8 then
      Delta := 16
    else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

function TdxMasterViewList.Add(Item: TdxMasterViewNode): Integer;
begin
  Result := FCount;
  if Result = FCapacity then Grow;
  FList^[Result] := Item;
  case FMode of
    lmItems:
      Item.FIndex := Result;
    lmAbsoluteItems:
      Item.FAbsoluteIndex := Result;
    lmSelectedItems:
      Item.FSelectedIndex := Result;
  end;
  Inc(FCount);
end;

procedure TdxMasterViewList.BeginDeletion;
begin
  if FMode = lmSelectedItems then
    FOwner.Control.BeginSelection;
  if FDeletionLockCount = 0 then
    FNewCount := FCount;
  Inc(FDeletionLockCount);
end;

procedure TdxMasterViewList.BeginInsertion;
begin
  if FInsertionLockCount = 0 then
    FPrevCount := FCount;
  Inc(FInsertionLockCount);
end;

procedure TdxMasterViewList.Clear;
begin
  SetCount(0);
  SetCapacity(0);
end;

procedure TdxMasterViewList.CopyTo(List: TList);
begin
  List.Count := FCount;
  System.Move(FList^, List.List^, FCount * SizeOf(Pointer));
end;

procedure TdxMasterViewList.Delete(Index: Integer);
var
  I: Integer;
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  if FList^[Index] = nil then Exit;  
  case FMode of
    lmItems:
      FList^[Index].FIndex := -1;
    lmAbsoluteItems:
      FList^[Index].FAbsoluteIndex := -1;
    lmSelectedItems:
      FList^[Index].FSelectedIndex := -1;
  end;
  FList^[Index] := nil;
  if FDeletionLockCount = 0 then
  begin
    Dec(FCount);
    if Index < FCount then
    begin
      System.Move(FList^[Index + 1], FList^[Index],
        (FCount - Index) * SizeOf(Pointer));
      for I := Index to FCount - 1 do
        case FMode of
          lmItems:
            Dec(FList^[I].FIndex);
          lmAbsoluteItems:
            Dec(FList^[I].FAbsoluteIndex);
          lmSelectedItems:
            Dec(FList^[I].FSelectedIndex);
        end;
    end;
  end  
  else
    Dec(FNewCount);
end;

procedure TdxMasterViewList.EndDeletion;
var
  I, J: Integer;
  NewList: PdxMasterViewNodeList;
begin
  if FDeletionLockCount <> 0 then
  begin
    Dec(FDeletionLockCount);
    if (FDeletionLockCount = 0) and (FCount <> FNewCount) then
    begin
      if FNewCount = 0 then NewList := nil
      else
      begin
        GetMem(NewList, FNewCount * SizeOf(Pointer));
        J := 0;
        for I := 0 to FCount - 1 do
          if FList^[I] <> nil then
          begin
            NewList^[J] := FList^[I];
            case FMode of
              lmItems:
                NewList^[J].FIndex := J;
              lmAbsoluteItems:
                NewList^[J].FAbsoluteIndex := J;
              lmSelectedItems:
                NewList^[J].FSelectedIndex := J;
            end;
            Inc(J);
          end;
      end;
      if FList <> nil then FreeMem(FList);
      FCapacity := FNewCount;
      FCount := FNewCount;
      FList := NewList;
      if (FCount = 0) and (FMode = lmItems) then FOwner.CheckExpanded;
    end;
  end;
  if FMode = lmSelectedItems then
    FOwner.Control.EndSelection;
end;

procedure TdxMasterViewList.EndInsertion;
var
  I: Integer;
begin
  if FInsertionLockCount <> 0 then
  begin
    Dec(FInsertionLockCount);
    if (FInsertionLockCount = 0) and (FCount <> FPrevCount) then
      for I := 0 to FCount - 1 do
        case FMode of
          lmItems:
            FList^[I].FIndex := I;
          lmAbsoluteItems:
            FList^[I].FAbsoluteIndex := I;
          lmSelectedItems:
            FList^[I].FSelectedIndex := I;
        end;
  end;
end;

class procedure TdxMasterViewList.Error(const Msg: string; Data: Integer);

  function ReturnAddr: Pointer;
  asm
          MOV     EAX,[EBP+4]
  end;

begin
  raise EListError.CreateFmt(Msg, [Data]) at ReturnAddr;
end;

function TdxMasterViewList.First: TdxMasterViewNode;
begin
  Result := Get(0);
end;

function TdxMasterViewList.IndexOf(Item: TdxMasterViewNode): Integer;
begin
  case FMode of
    lmItems: Result := Item.FIndex;
    lmAbsoluteItems: Result := Item.FAbsoluteIndex;
    lmSelectedItems: Result := Item.FSelectedIndex;
  else
    Result := -1;
  end;
end;

procedure TdxMasterViewList.Insert(Index: Integer; Item: TdxMasterViewNode);
var
  I: Integer;
begin
  if (Index < 0) or (Index > FCount) then
    Error(SListIndexError, Index);
  if FCount = FCapacity then Grow;
  if Index < FCount then
  begin
    if FInsertionLockCount = 0 then
      for I := Index to FCount - 1 do
        case FMode of
          lmItems:
            Inc(FList^[I].FIndex);
          lmAbsoluteItems:
            Inc(FList^[I].FAbsoluteIndex);
          lmSelectedItems:
            Inc(FList^[I].FSelectedIndex);
        end;
    System.Move(FList^[Index], FList^[Index + 1],
      (FCount - Index) * SizeOf(Pointer));
  end;
  FList^[Index] := Item;
  case FMode of
    lmItems: Item.FIndex := Index;
    lmAbsoluteItems: Item.FAbsoluteIndex := Index;
    lmSelectedItems: Item.FSelectedIndex := Index;
  end;
  Inc(FCount);
end;

function TdxMasterViewList.Last: TdxMasterViewNode;
begin
  Result := Get(FCount - 1);
end;

procedure TdxMasterViewList.Move(CurIndex, NewIndex: Integer);
var
  Item: Pointer;
begin
  if CurIndex <> NewIndex then
  begin
    if (NewIndex < 0) or (NewIndex >= FCount) then
      Error(SListIndexError, NewIndex);
    Item := Get(CurIndex);
    Delete(CurIndex);
    Insert(NewIndex, Item);
  end;
end;

function TdxMasterViewList.Remove(Item: TdxMasterViewNode): Integer;
begin
  Result := IndexOf(Item);
  if Result <> -1 then Delete(Result);
end;

procedure QuickSort(SortList: PdxMasterViewNodeList; L, R: Integer;
  SCompare: TdxMasterViewListSortCompare);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := SortList^[(L + R) shr 1];
    repeat
      while SCompare(SortList^[I], P) < 0 do
        Inc(I);
      while SCompare(SortList^[J], P) > 0 do
        Dec(J);
      if I <= J then
      begin
        T := SortList^[I];
        SortList^[I] := SortList^[J];
        SortList^[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(SortList, L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure TdxMasterViewList.Sort(Compare: TdxMasterViewListSortCompare;
  TopBound, BottomBound: Integer);
var
  I: Integer;
begin
  if (FList <> nil) and (FCount > 0) then
  begin
    QuickSort(FList, TopBound, BottomBound, Compare);
    for I := TopBound to BottomBound do
      with FList^[I] do
        case FMode of
          lmItems: FIndex := I;
          lmAbsoluteItems: FAbsoluteIndex := I;
          lmSelectedItems: FSelectedIndex := I;
        end;
  end;
end;

{ TdxMasterViewNode }

constructor TdxMasterViewNode.Create(AControl: TdxMasterView; ALevel: TdxMasterViewLevel;
  AParentNode: TdxMasterViewNode; AIndex: Integer; ANodeType: TdxMasterViewNodeType;
  const AID, AKeyValue: Variant);
var
  I: Integer;
  PValue: PVariant;
begin
  inherited Create;
  FControl := AControl;
  FLevel := ALevel;
  FNodeType := ANodeType;
  FID := AID;
  FKeyValue := AKeyValue;
  FAbsoluteIndex := -1;
  FGroupIndex := -1;
  FIndex := -1;
  FItems := TdxMasterViewList.Create(Self, lmItems);
  FSelectedIndex := -1;
  if FNodeType = ntData then
  begin
    FValues := TStringList.Create;
    if FLevel <> nil then
    begin
      FValues.Capacity := FLevel.ColumnCount;
      for I := 0 to FValues.Capacity - 1 do
      begin
        New(PValue);
        FValues.AddObject('', TObject(PValue));
      end;
    end;
  end;
  if AParentNode <> nil then AParentNode.AddItem(AIndex, Self);
end;

destructor TdxMasterViewNode.Destroy;
var
  I: Integer;
begin
  FLevel.DoNodeDeleted(Self);
  Clear;
  if FParentNode <> nil then
    with FParentNode do
    begin
      Invalidate(nil, vpAllAndBelow);
      RemoveItem(Self);
    end;
  FControl.DoNodeDeleted(Self);
  DestroySummaries;
  if FNodeType = ntData then
  begin
    for I := 0 to FValues.Count - 1 do
      Dispose(PVariant(FValues.Objects[I]));
    FValues.Free;
  end;  
  FItems.Free;
  inherited;
end;

function TdxMasterViewNode.GetBounds: TRect;
begin
  Result := FViewInfo.Bounds;
end;

function TdxMasterViewNode.GetContentBounds: TRect;
begin
  with FViewInfo, Result do
  begin
    Result := Bounds;
    if Top <> Bottom then
    begin
      Inc(Top, GroupByBoxSize);
      if (HeaderSize <> 0) and FLevel.Horizontal then
        Inc(Top, HeaderSize);
      Dec(Bottom, FooterSize);
      if Top > Bottom then Top := Bottom;
    end;
  end;
end;

function TdxMasterViewNode.GetContentBoundsWithoutPreview: TRect;
begin
  with Result do
  begin
    Result := ContentBounds;
    if IsRectEmpty(Result) then Exit;
    with FLevel do
      Bottom := Top + VisibleRowCount * ContentRealHeight;
  end;
end;

function TdxMasterViewNode.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxMasterViewNode.GetCountInLevel(ALevel: TdxMasterViewLevel): Integer;
var
  Node: TdxMasterViewNode;
  I: Integer;
begin
  if (FNodeType = ntData) and (FLevel.Count = 1) and (ALevel = FLevel[0]) or
    (FNodeType in [ntCaption, ntGroup]) and (ALevel = FLevel) then
    Result := Count
  else
  begin
    Result := 0;
    Node := FirstInLevel[ALevel];
    if Node <> nil then
    begin
      Result := Node.Index;
      for I := Result to Count - 1 do
        if Items[I].Level <> ALevel then
        begin
          Result := I - Result;
          Exit;
        end;
      Result := Count - Result;
    end;
  end;  
end;

function TdxMasterViewNode.GetFirst: TdxMasterViewNode;
begin
  if Count = 0 then Result := nil
  else Result := Items[0];
end;

function TdxMasterViewNode.GetFirstInLevel(ALevel: TdxMasterViewLevel): TdxMasterViewNode;
var
  I: Integer;
begin
  if (FNodeType = ntData) and (FLevel.Count = 1) and (ALevel = FLevel[0]) or
    (FNodeType in [ntCaption, ntGroup]) and (ALevel = FLevel) then
    Result := First
  else
  begin
    for I := 0 to Count - 1 do
    begin
      Result := Items[I];
      if Result.Level = ALevel then Exit;
    end;
    Result := nil;
  end;  
end;

function TdxMasterViewNode.GetFocused: Boolean;
begin
  Result := FControl.FocusedNode = Self;
end;

function TdxMasterViewNode.GetFooterBounds: TRect;
begin
  with FViewInfo do
    if FooterSize = 0 then SetRectEmpty(Result)
    else
    begin
      Result := Bounds;
      Result.Top := Result.Bottom - FooterSize;
    end;
end;

function TdxMasterViewNode.GetFullBounds: TRect;
begin
  Result := FViewInfo.Bounds;
  with Result do
  begin
    Left := 0;
    Right := FControl.ClientWidth;
  end;
end;

function TdxMasterViewNode.GetFullContentBounds: TRect;
begin
  Result := GetContentBounds;
  with Result do
    if Top <> Bottom then
    begin
      Left := 0;
      Right := FControl.ClientWidth;
    end;
end;

function TdxMasterViewNode.GetFullFooterBounds: TRect;
begin
  Result := GetFooterBounds;
  with Result do
    if Top <> Bottom then
    begin
      Left := 0;
      Right := FControl.ClientWidth;
    end;
end;

function TdxMasterViewNode.GetFullGroupByBoxBounds: TRect;
begin
  Result := GetGroupByBoxBounds;
  with Result do
    if Top <> Bottom then
    begin
      //Left := 0;
      Right := FControl.ClientWidth;
    end;
end;

function TdxMasterViewNode.GetFullHeaderBounds: TRect;
begin
  Result := GetHeaderBounds;
  with Result do
    if Top <> Bottom then
    begin
      Left := 0;
      Right := FControl.ClientWidth;
    end;
end;

function TdxMasterViewNode.GetGroupByBoxBounds: TRect;
begin
  with FViewInfo do
    if GroupByBoxSize = 0 then SetRectEmpty(Result)
    else
    begin
      Result := Bounds;
      if FNodeType = ntData then
        Dec(Result.Left,
          FLevel.GroupColumnCount * (LevelIndent + FLevel.ExtLineWidth))
      else
        Dec(Result.Left,
          GroupIndex * (LevelIndent + FLevel.ExtLineWidth));
      Result.Bottom := Result.Top + GroupByBoxSize;
    end;
end;

function TdxMasterViewNode.GetGroupByBoxColumnBounds(Index: Integer): TRect;
var
  I: Integer;
  R: TRect;
begin
  if Index = -1 then Index := 0;
  Result := GroupByBoxBounds;
  R := Result;
  with Result do
  begin
    Inc(Left, GroupByBoxLeftOffset);
    Inc(Top, GroupByBoxTopOffset);
    for I := 0 to Index do
    begin
      Right := Left + GroupByBoxColumnWidth;//FLevel.GroupColumns[I].GetHeaderBestFitWidth(DC, True) + 40;
      Bottom := Top + FLevel.HeaderRealHeight;
      if I = Index then Break;
      Left := Right + GroupByBoxHorOffset;
      Inc(Top, FLevel.HeaderRealHeight div 2 + GroupByBoxVerOffset);
    end;
  end;
end;

function TdxMasterViewNode.GetGroupIndex: Integer;
var
  Node: TdxMasterViewNode;
begin
  Result := -1;
  Node := Self;
  while Node.NodeType = ntGroup do
  begin
    Inc(Result);
    Node := Node.ParentNode;
  end;
end;

function TdxMasterViewNode.GetHasChildren: Boolean;
begin
  Result := Count <> 0;
end;

function TdxMasterViewNode.GetHeaderBounds: TRect;
begin
  with FViewInfo do
    if HeaderSize = 0 then SetRectEmpty(Result)
    else
    begin
      Result := Bounds;
      Inc(Result.Top, GroupByBoxSize);
      Result.Bottom := Result.Top + HeaderSize;
      if Result.Bottom > Bounds.Bottom - FooterSize then
        Result.Bottom := Bounds.Bottom - FooterSize;
    end;
end;

function TdxMasterViewNode.GetHeaderColBounds(Index: Integer): TRect;
var
  I: Integer;
begin
  if FViewInfo.HeaderSize = 0 then SetRectEmpty(Result)
  else
    with Result do
    begin
      Result := HeaderBounds;
      if FLevel.HasExpandButton then Inc(Left, LevelIndent);
      Right := Left;
      for I := 0 to Index do
      begin
        if I <> 0 then
          Inc(Right, FLevel.Layout.ContentWidths[I - 1]);
        Left := Right;
        Inc(Right, FLevel.Layout.HeaderWidths[I]);
      end;
    end;
end;

function TdxMasterViewNode.GetHeaderRowBounds(Index: Integer): TRect;
var
  I: Integer;
begin
  if FViewInfo.HeaderSize = 0 then Exit;
  Result := HeaderBounds;
  Result.Bottom := Result.Top + FLevel.HeaderRealHeight;
  for I := 0 to Index - 1 do
    OffsetRect(Result, 0, FLevel.HeaderRealHeight);
end;

function TdxMasterViewNode.GetHorizontal: Boolean;
begin
  Result := FLevel.Horizontal or (FNodeType <> ntData);
end;

function TdxMasterViewNode.GetIsEditing: Boolean;
begin
  Result := FLevel.FEditingNode = Self;
end;

function TdxMasterViewNode.GetIsFirst: Boolean;
begin
  Result := Index = 0;
end;

function TdxMasterViewNode.GetIsFirstInLevel: Boolean;
begin
  Result := (Index = 0) or (FParentNode.FItems.List^[Index - 1].Level <> FLevel);
end;

function TdxMasterViewNode.GetIsLast: Boolean;
begin
  Result := Index = FParentNode.FItems.Count - 1;
end;

function TdxMasterViewNode.GetIsLastInLevel: Boolean;
begin
  Result := IsLast or (FParentNode.FItems.List^[Index + 1].Level <> FLevel);
end;

function TdxMasterViewNode.GetItem(Index: Integer): TdxMasterViewNode;
begin
  Result := FItems[Index];
end;

function TdxMasterViewNode.GetLast: TdxMasterViewNode;
begin
  if Count = 0 then Result := nil
  else Result := Items[Count - 1];
end;

function TdxMasterViewNode.GetLastInLevel(ALevel: TdxMasterViewLevel): TdxMasterViewNode;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
  begin
    Result := Items[I];
    if Result.Level = ALevel then Exit;
  end;
  Result := nil;
end;

function TdxMasterViewNode.GetLeftSpaceBounds: TRect;
begin
  Result := Bounds;
  with Result do
  begin
    Right := Left;
    Left := 0;
  end;
end;

function TdxMasterViewNode.GetNodeWithSummaryData(ALevel: TdxMasterViewLevel): TdxMasterViewNode;
begin
  Result := GetParentNode(ALevel, False).ParentNode;
end;

function TdxMasterViewNode.GetParentNodes(Index: Integer): TdxMasterViewNode;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Index - 1 do
  begin
    Result := Result.ParentNode;
    if Result = nil then Break;
  end;
end;

function TdxMasterViewNode.GetParentNodeWithData: TdxMasterViewNode;
begin
  Result := FParentNode;
  while Result.NodeType <> ntData do
    Result := Result.ParentNode;
end;

function TdxMasterViewNode.GetPreviewBounds: TRect;
begin
  if FViewInfo.PreviewSize = 0 then SetRectEmpty(Result)
  else
    with Result do
    begin
      Result := ContentBounds;
      if HasExpandButton then Inc(Left, LevelIndent);
      with FLevel do
        Inc(Top, VisibleRowCount * ContentRealHeight);
      Bottom := Top + FViewInfo.PreviewSize;
    end;
end;

function TdxMasterViewNode.GetRightSpaceBounds: TRect;
begin
  Result := Bounds;
  with Result do
    if Top <> Bottom then
    begin
      Left := Right;
      Right := FControl.ClientWidth;
    end;
end;

function TdxMasterViewNode.GetSelected: Boolean;
begin
  Result :=
    not FControl.MultiSelect and Focused or
    FControl.MultiSelect and ((SelectedIndex <> -1) or InSelectedPeriod);
end;

function TdxMasterViewNode.GetString(Index: Integer): string;
begin
  Result := FValues[Index];
end;

function TdxMasterViewNode.GetSubFooterBounds(AParentIndex: Integer): TRect;
var
  I: Integer;
begin
  if (FViewInfo.FooterSize = 0) or not HasFooter(AParentIndex) then
    SetRectEmpty(Result)
  else
  begin
    Result := GetFooterBounds;
    Result.Bottom := Result.Top;
    for I := 0 to FLevel.ParentCount - 2 do
      with Result do
      begin
        with FLevel.Parents[I] do
        begin
          if Self.HasFooter(I) then Inc(Bottom, RowCount * FooterHeight);
          if I = AParentIndex then Break;
          if (I <> 0) or (FNodeType = ntData) then
            Dec(Left, (Byte(ShowCaption) + GroupColumnCount) * (LevelIndent + ExtLineWidth))
          else
            if FNodeType = ntGroup then
              Dec(Left, (Byte(ShowCaption) + GroupIndex) * (LevelIndent + ExtLineWidth));
        end;
        with FLevel.Parents[I + 1] do
        begin
          Dec(Left, LevelIndent + ExtLineWidth + LevelSeparatorWidth);
          Right := Left + VisibleWidth;
          if (LevelSeparatorWidth <> 0) and HasLevelSeparator(I) then
            Inc(Bottom, LevelSeparatorWidth);
          if (RowSeparatorWidth <> 0) and HasRowSeparator(I) then
            Inc(Bottom, RowSeparatorWidth);
          Top := Bottom;
        end;
      end;
  end;
end;

function TdxMasterViewNode.GetValue(Index: Integer): Variant;
begin
  Result := PVariant(FValues.Objects[Index])^;
end;

function TdxMasterViewNode.GetValueCount: Integer;
begin
  if FValues <> nil then
    Result := FValues.Count
  else
    Result := 0;
end;

function TdxMasterViewNode.GetVisible: Boolean;
begin
  Result :=
    (0 <= AbsoluteIndex) and
      (AbsoluteIndex < FControl.TopIndex + FControl.FLastPartVisibleItemCount);
end;

procedure TdxMasterViewNode.SetExpanded(Value: Boolean);
begin
  if FExpanded <> Value then
    if Value then
      Expand(False)
    else
      Collapse(False);
end;

procedure TdxMasterViewNode.SetFocused(Value: Boolean);
begin
  Control.FocusedIndex := AbsoluteIndex;
end;

procedure TdxMasterViewNode.SetSelected(Value: Boolean);
begin
  if FControl.MultiSelect and (Selected <> Value) and
    (not Value or FControl.DoSelectNode(Self)) or
    not FControl.MultiSelect and not Value and (SelectedIndex <> -1) then
  begin
    if Value then
      FControl.AddSelectedItem(Self)
    else
      FControl.RemoveSelectedItem(Self);
    NodeChanged(False);
    FControl.DoSelectionChanged;
  end;
end;

procedure TdxMasterViewNode.AddItem(AIndex: Integer; Value: TdxMasterViewNode);
begin
  if AIndex = -1 then AIndex := GetAvailIndex(Value.Level.Index);
  FItems.Insert(AIndex, Value);
  with Value do
  begin
    FParentNode := Self;
    FGroupIndex := GetGroupIndex;
  end;
end;

procedure TdxMasterViewNode.RemoveItem(Value: TdxMasterViewNode);
begin
  FItems.Remove(Value);
  CheckExpanded;
  //FControl.DoNodeDeleted(Value);
  with Value do
  begin
    FParentNode := nil;
    FGroupIndex := -1;
  end;
end;

procedure TdxMasterViewNode.SetHasLevelSeparator(var EndLevelData: Integer;
  ALevelParentIndex: Integer);
begin
  EndLevelData := EndLevelData or (1 shl ALevelParentIndex);
end;

procedure TdxMasterViewNode.SetHasRowSeparator(var EndLevelData: Integer;
  ALevelParentIndex: Integer);
begin
  EndLevelData := EndLevelData or (1 shl (ALevelParentIndex + 16));
end;

function TdxMasterViewNode.Add(ALevel: TdxMasterViewLevel; AIndex: Integer; 
  ANodeType: TdxMasterViewNodeType; const AID, AKeyValue: Variant): TdxMasterViewNode;
begin
  Result := TdxMasterViewNode.Create(FControl, ALevel, Self, AIndex, ANodeType, AID, AKeyValue);
end;

procedure TdxMasterViewNode.AddToList(ALevel: TdxMasterViewLevel;
  OtherNodesList, GroupNodesList: TList; ProcessRoot: Boolean);
var
  I: Integer;
  Node: TdxMasterViewNode;
begin
  if ProcessRoot then
    if FNodeType <> ntGroup then
    begin
      OtherNodesList.Add(Self);
      Exit;
    end
    else
      GroupNodesList.Add(Self);
  Node := FirstInLevel[ALevel];
  if Node = nil then Exit;
  I := Node.Index;
  for I := I to I + CountInLevel[ALevel] - 1 do
    Items[I].AddToList(ALevel, OtherNodesList, GroupNodesList, True);
end;

procedure TdxMasterViewNode.AddVisibleToList(List: TdxMasterViewList);
var
  I: Integer;
begin
  if FParentNode <> nil then
  begin
    List.Add(Self);
    FLevel.FVisible := True;  // := FNodeType = ntData ?
  end;
  if Expanded then
    for I := 0 to Count - 1 do Items[I].AddVisibleToList(List);
end;

function TdxMasterViewNode.CanDelete: Boolean;
begin
  Result := (FNodeType = ntData) and FLevel.CanDelete;
end;

function TdxMasterViewNode.CanExpand: Boolean;
begin
  Result := HasChildren;
  if not Result then
    case FNodeType of
      ntData:
        Result := FLevel.LoadDataOnExpand;
      ntCaption:
        Result := FLevel.SmartLoad;
    end;
end;

procedure TdxMasterViewNode.ChangeExpanded(Value: Boolean);
begin
  if FExpanded <> Value then
  begin
    FExpanded := Value;
    if Value then FTriedToExpand := True;
  end;
end;

procedure TdxMasterViewNode.CheckChildNodes(ALevel: TdxMasterViewLevel;
  NeedCheckParentNodes: Boolean);
begin
  if (FNodeType = ntGroup) and (Count = 0) then
    CheckParentNodes
  else
    if FirstInLevel[ALevel] <> nil then
      FirstInLevel[ALevel].UpdateData(False, False, True);
  if NeedCheckParentNodes and (FNodeType = ntGroup) then
    ParentNodes[GroupIndex + 1].CheckChildNodes(FLevel, False);
end;

procedure TdxMasterViewNode.CheckExpanded;
begin
  if (FParentNode <> nil) and not HasChildren then ChangeExpanded(False);
end;

procedure TdxMasterViewNode.CheckParentNodes;
var
  DetailKeyValue: Variant;
  BaseNode, AParentNode: TdxMasterViewNode;
  ALevel: TdxMasterViewLevel;
begin
  case FNodeType of
    ntData:
      begin
        if not FControl.SyncMove then Exit;
        // find base data node
        if FLevel.IsTop then
          BaseNode := FControl.FItems
        else
        begin
          DetailKeyValue := FLevel.GetCurDetailKeyValue;
          if VarAreEqual(ParentNodeWithData.KeyValue[FLevel.Index], DetailKeyValue) then
            BaseNode := ParentNodeWithData
          else
            BaseNode := FControl.NodeFromKeyValue(FLevel.Parent, FLevel.Index, DetailKeyValue);
        end;
        // find parentnode
        AParentNode := FLevel.GetParentNode(BaseNode, nil, nil, nil, nil, True);
        if AParentNode = nil then
        begin
          AParentNode := FParentNode;
          ALevel := FLevel;
          Free;
          AParentNode.CheckChildNodes(ALevel, False);
        end
        else
          if FParentNode <> AParentNode then
          begin
            with FParentNode do
            begin
              RemoveItem(Self);
              CheckChildNodes(Self.Level, False);
            end;
            with AParentNode do
            begin
              AddItem(-1, Self);
              CheckChildNodes(Self.Level, True);
            end;
          end;
      end;
    ntGroup:
      if Count = 0 then
      begin
        AParentNode := Self;
        repeat
          BaseNode := AParentNode;
          AParentNode := AParentNode.ParentNode;
          BaseNode.Free;
        until (AParentNode.NodeType <> ntGroup) or (AParentNode.Count <> 0);
        AParentNode.Invalidate(nil, vpAllAndBelow);
      end;
  end;
end;

procedure TdxMasterViewNode.Clear;
var
  I: Integer;
begin
  FControl.BeginSelection;
  try
    for I := Count - 1 downto 0 do Items[I].Free;
  finally
    FControl.EndSelection;
  end;
end;

procedure TdxMasterViewNode.ClearValues;
var
  I: Integer;
begin
  if FNodeType = ntData then
  begin
    FID := Unassigned;
    FKeyValue := Unassigned;
    for I := 0 to Level.ColumnCount - 1 do
    begin
      FValues[I] := '';
      PVariant(FValues.Objects[I])^ := Unassigned;
    end;
  end;  
end;

function TdxMasterViewNode.ContainsDataInChildren(ALevel: TdxMasterViewLevel): Boolean;
begin
  Result :=
    (FNodeType = ntData) and (FLevel = ALevel.Parent) and not ALevel.ShowCaption or
    (FNodeType in [ntCaption, ntGroup]) and (FLevel = ALevel);
end;

procedure TdxMasterViewNode.DoSmartLoadChanged(ALevel: TdxMasterViewLevel);
var
  I: Integer;
begin
  if not ALevel.SmartLoad then
    if HasDataInChildren(ALevel) and
      not FExpanded and (CountInLevel[ALevel] = 0) then
      UpdateData(False, True, False)
    else
      if ALevel.HasAsParent(FLevel) then
        for I := 0 to Count - 1 do
          Items[I].DoSmartLoadChanged(ALevel);
end;

function CompareItems(Item1, Item2: TdxMasterViewNode): Integer;
var
  I: Integer;
  S: string;  // to avoid the bug with optimization
begin
  S := '';
  with Item1.ParentNode, FControl do
    for I := 0 to FSortingColumnCount - 1 do
      if FSortingData^[I] <> nil then
      begin
        SortV1 := FSortingData^[I]^[Item1.Index];
        SortV2 := FSortingData^[I]^[Item2.Index];
        //if VarIsArray(SortV1^) or VarIsArray(SortV2^) then Continue;  //20..30 ms
        try
          if SortV1^ <> SortV2^ then
          begin
            if VarIsNull(SortV1^) then
              Result := -1
            else
              if VarIsNull(SortV2^) then
                Result := 1
              else
                if (mobAnsiCompareStrOnSorting in OptionsBehavior) and
                  (VarType(SortV1^) = varString) then
                begin
                  SortS1 := SortV1^;
                  SortS2 := SortV2^;
                  Result :=
                    CompareString(LOCALE_USER_DEFAULT, 0,
                      PChar(SortS1), Length(SortS1), PChar(SortS2), Length(SortS2)) - 2;
                end
                else
                  if SortV1^ < SortV2^ then
                    Result := -1
                  else
                    Result := 1;
            if FSortingDesc^[I] then Result := -Result;
            Exit;
          end;
        except
          on EVariantError do ;  // 10..20 ms
        end;
      end;
  Result := Item1.Index - Item2.Index;
end;

procedure TdxMasterViewNode.DoSorting(ALevel: TdxMasterViewLevel);
var
  I, J, CI, TopBound, BottomBound, AGroupIndex: Integer;
  UseUpperCase: PBoolArray;
  IsDataNodes: Boolean;
//  ft,lt:integer;
begin
  if ContainsDataInChildren(ALevel) then
  begin
    if FItems.Count = 0 then Exit;

//ft:=gettickcount;

    AGroupIndex := GroupIndex;
    IsDataNodes :=
      (FNodeType in [ntData, ntCaption]) and (ALevel.GroupColumnCount = 0) or
      (FNodeType = ntGroup) and (AGroupIndex = ALevel.GroupColumnCount - 1);
    with FControl, Self do
    begin
      TopBound := -1;
      BottomBound := -2;
      FSortingColumnCount := ALevel.SortedColumnCount;
      GetMem(UseUpperCase, FSortingColumnCount * SizeOf(Boolean));
      GetMem(FSortingDesc, FSortingColumnCount * SizeOf(Boolean));
      GetMem(FSortingData, FSortingColumnCount * SizeOf(PdxMVSortingValues));
      try
        for I := 0 to FSortingColumnCount - 1 do
          if IsDataNodes or
            (ALevel.SortedColumns[I] = ALevel.GroupColumns[AGroupIndex + 1]) then
          begin
            with ALevel.SortedColumns[I] do
            begin
              CI := Index;
              FSortingDesc^[I] := SortOrder = soDescending;
            end;
            GetMem(FSortingData^[I], FItems.Count * SizeOf(PVariant));

            TopBound := -1;
            BottomBound := FItems.Count - 1;
            for J := 0 to BottomBound do
              if FItems[J].Level = ALevel then
              begin
                if TopBound = -1 then
                begin
                  TopBound := J;
                  UseUpperCase[I] :=
                    (mobCaseInsensitiveSorting in OptionsBehavior) and
                      (IsDataNodes and (VarType(PVariant(FItems[J].FValues.Objects[CI])^) = varString) or
                       not IsDataNodes and (VarType(FItems[J].GroupValue) = varString));
                end;
                if UseUpperCase[I] then
                begin
                  New(FSortingData^[I]^[J]);
                  if IsDataNodes then
                    FSortingData^[I]^[J]^ := VarAnsiUpperCase(PVariant(FItems[J].FValues.Objects[CI])^)
                  else
                    FSortingData^[I]^[J]^ := VarAnsiUpperCase(FItems[J].GroupValue);
                end
                else
                  if IsDataNodes then
                    FSortingData^[I]^[J] := PVariant(FItems[J].FValues.Objects[CI])
                  else
                    FSortingData^[I]^[J] := @FItems[J].GroupValue;
              end
              else
                if TopBound <> -1 then
                begin
                  BottomBound := J - 1;
                  Break;
                end;
          end
          else
            FSortingData^[I] := nil;
        if TopBound <> -1 then
          FItems.Sort(CompareItems, TopBound, BottomBound);
      finally
        for I := 0 to FSortingColumnCount - 1 do
          if FSortingData^[I] <> nil then
          begin
            if (TopBound <> -1) and UseUpperCase[I] then
              for J := TopBound to BottomBound do Dispose(FSortingData^[I]^[J]);
            FreeMem(FSortingData^[I], FItems.Count * SizeOf(PVariant));
          end;
        FreeMem(FSortingData, FSortingColumnCount * SizeOf(PdxMVSortingValues));
        FreeMem(FSortingDesc, FSortingColumnCount * SizeOf(Boolean));
        FreeMem(UseUpperCase, FSortingColumnCount * SizeOf(Boolean));
      end;
    end;
//lt:=gettickcount;
//application.messagebox(pchar(inttostr(lt-ft)), '', 0);

    if IsDataNodes then Exit;
  end;

  if ALevel.HasAsParent(FLevel) then
    for I := 0 to Count - 1 do
      Items[I].DoSorting(ALevel);
end;

procedure TdxMasterViewNode.Draw(DC: HDC);
begin
  if RectVisible(DC, LeftSpaceBounds) then
    FLevel.DrawIndent(DC, LeftSpaceBounds, Self);
  if (FViewInfo.FooterSize <> 0) and RectVisible(DC, FullFooterBounds) then
  begin
    FLevel.DrawFooter(DC, FooterBounds, Self);
    if vioClipped in FViewInfo.Options then
      with FullFooterBounds do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
  end;
  if (FViewInfo.GroupByBoxSize <> 0) and RectVisible(DC, FullGroupByBoxBounds) then
    FLevel.DrawGroupByBox(DC, GroupByBoxBounds, Self);
  if (FViewInfo.HeaderSize <> 0) and RectVisible(DC, FullHeaderBounds) then
    FLevel.DrawHeader(DC, HeaderBounds, Self);
  if RectVisible(DC, FullContentBounds) then
    FLevel.DrawContent(DC, ContentBounds, Self);
end;

function TdxMasterViewNode.GetAvailIndex(AChildLevelIndex: Integer): Integer;
begin
  Result := Count;
  if Result <> 0 then
    for Result := 0 to Result - 1 do
      if Items[Result].Level.Index > AChildLevelIndex then Break;
end;

function TdxMasterViewNode.GetLastSubChild: TdxMasterViewNode;
begin
  if Count = 0 then Result := nil
  else
  begin
    Result := Items[Count - 1];
    while Result.Expanded do Result := Result[Result.Count - 1];
  end;
end;

function TdxMasterViewNode.GetLevelIndex: Integer;
var
  Node: TdxMasterViewNode;
begin
  Result := -2;
  Node := Self;
  repeat
    Inc(Result);
    Node := Node.ParentNode;
  until Node = nil;
end;

function TdxMasterViewNode.HasDataInChildren(ALevel: TdxMasterViewLevel): Boolean;
begin
  Result :=
    (FNodeType = ntData) and (FLevel = ALevel.Parent) or
    (FNodeType = ntCaption) and (FLevel = ALevel);
end;

function TdxMasterViewNode.InSelectedPeriod: Boolean;
begin
  Result :=
    (mvsSelectPeriod in FControl.State) and FControl.DoSelectNode(Self) and
    IsBetween(Self, FControl.FSelectionAnchor, FControl.FLastSelectedNode);
end;

procedure TdxMasterViewNode.Invalidate(Column: TdxMasterViewColumn;
  VPart: TdxMasterViewVPart);
var
  R: TRect;
begin
  if FControl.HandleAllocated and (FControl.FUpdateLockCount = 0) then
  begin  //!!!!
    if (FControl.TopIndex <= AbsoluteIndex) and
      (AbsoluteIndex < FControl.TopIndex + FControl.FLastPartVisibleItemCount) then
      case VPart of
        vpGroupByBox:
          if HasGroupByBox(R.Left) then
            if Column = nil then
              R := GroupByBoxBounds
            else
              R := Column.GetGroupByBoxBounds(Self)
          else
            Exit;
        vpHeader:
          if HasHeader(FControl.TopIndex, R.Left) then
            if Column = nil then
              R := FullHeaderBounds
            else
              R := Column.GetHeaderBounds(Self)
          else
            Exit;
        vpContent:
          if (Column = nil) or
            (FNodeType = ntGroup) and (Column = FLevel.GroupColumns[FGroupIndex]) then
            R := FullContentBounds
          else
            R := Column.GetContentBounds(Self);
        vpFooter:
          if Column = nil then
            R := FullFooterBounds
          else
            R := Column.GetFooterBounds(Self);
        vpAll, vpAllAndBelow:
          if Column = nil then
          begin
            R := FullBounds;
            if VPart = vpAllAndBelow then
              R.Bottom := FControl.ClientHeight;
          end
          else
          begin
            Invalidate(Column, vpGroupByBox);
            Invalidate(Column, vpHeader);
            Invalidate(Column, vpContent);
            Invalidate(Column, vpFooter);
            Exit;
          end;
      end
    else
      if VPart = vpAllAndBelow then
        R := FControl.ClientRect
      else
        Exit;
    InvalidateRect(FControl.Handle, @R, False);
  end;
end;

procedure TdxMasterViewNode.MoveData(ALevel: TdxMasterViewLevel; FromIndex, ToIndex: Integer);
var
  PValue: PVariant;
  I: Integer;
begin                             
  if (FNodeType = ntData) and (FLevel = ALevel) then
    if FromIndex = -1 then
    begin
      New(PValue);
      FValues.InsertObject(ToIndex, '', TObject(PValue));
    end
    else
      if ToIndex = -1 then
      begin
        Dispose(PVariant(FValues.Objects[FromIndex]));
        FValues.Delete(FromIndex);
      end
      else FValues.Move(FromIndex, ToIndex)
  else
    if ALevel.HasAsParent(FLevel) then
      for I := 0 to Count - 1 do
        Items[I].MoveData(ALevel, FromIndex, ToIndex);
end;

procedure TdxMasterViewNode.NodeChanged(HardRefresh: Boolean);
begin
  if Control <> nil then
    if HardRefresh then
    else
      Invalidate(nil, vpContent);
end;

procedure TdxMasterViewNode.Sync;
var
  Node: TdxMasterViewNode;
  AFreezeCount: Integer;
begin
  if FNodeType = ntData then
  begin
    Node := Self;
    repeat
      if Node.NodeType = ntData then
        with Node.Level do
          if not VarAreEqual(GetCurIDValue, Node.ID) then
          begin
            if DataSet.State in dsEditModes then DataSet.Post;
            AFreezeCount := FControl.FreezeDataSet(Node.Level);
            try
              DataSet.Locate(ID, Node.ID, []);
            finally
              if DataLink.FreezeCount = AFreezeCount then
                FControl.UnfreezeDataSet(Node.Level);
            end;
          end;
      Node := Node.ParentNode;
    until Node.ParentNode = nil;
  end;  
end;

procedure TdxMasterViewNode.SyncPos;
begin
  if not FControl.Frozen and FControl.SyncMove then Sync;
end;

function CompareItemsByID(Node1, Node2: Pointer): Integer;
begin
  Result := -VarCompare(TdxMasterViewNode(Node1).ID, TdxMasterViewNode(Node2).ID);
end;

function CompareGroupItemsByPtr(Node1, Node2: Pointer): Integer;
begin
  Result := Integer(Node1) - Integer(Node2);
end;

function CompareGroupItemsByGroupIndex(Node1, Node2: Pointer): Integer;
begin
  if TdxMasterViewNode(Node1).GroupIndex < TdxMasterViewNode(Node2).GroupIndex then
    Result := -1
  else
    if TdxMasterViewNode(Node1).GroupIndex = TdxMasterViewNode(Node2).GroupIndex then
      Result := 0
    else
      Result := 1;
end;

procedure TdxMasterViewNode.UpdateData(UpdateSelf, UpdateChildren, UpdateOther: Boolean);
const
  NoneUpdate = 0;
  SoftUpdate = 1;
  HardUpdate = 2;
var
  PrevCursor: TCursor;
  AID, AKeyValue: Variant;
  S: string;
  LockSelection: Boolean;
  I: Integer;
  LevelUpdateState: PIntArray;

  procedure CancelLevel(ALevel: TdxMasterViewLevel; ProcessRoot: Boolean);
  var
    I: Integer;
  begin
    if ProcessRoot or (ALevel <> FLevel) then
      with ALevel do
        if (DataSet <> nil) and (DataSet.State in dsEditModes) then
          DataSet.Cancel;
    for I := 0 to ALevel.Count - 1 do
      CancelLevel(ALevel[I], True);
  end;

  procedure UpdateNode(const Node: TdxMasterViewNode);
  var
    I: Integer;
  begin
    with Node, Level do
    begin
      Node.FID := AID;
      Node.FKeyValue := AKeyValue;
      Node.FPreviewText := GetCurPreviewText(Node);

      for I := 0 to FColumns.Count - 1 do
        with TdxMasterViewColumn(FColumns[I]) do
          if Field <> nil then
            with Field do
            begin
              S := DisplayText;
              FValues[I] := S;
              if (DataType <> ftString) or (S = '') or
                Assigned(OnGetText) or (EditMask <> ''){!} then
                PVariant(FValues.Objects[I])^ := Value
              else
                PVariant(FValues.Objects[I])^ := S;
            end
          else
          begin
            FValues[I] := '';
            PVariant(FValues.Objects[I])^ := Null;//Unassigned;
          end;

      if Node <> Self then CalcSummaries(True);
    end;
  end;

  procedure UpdateLevels(AItems: TdxMasterViewNode);
  var
    RestItems, RestGroupItems: TList;
    I, FirstIndex, AvailIndex, APos, L, R, C, CResult: Integer;
    ALevel: TdxMasterViewLevel;
    LastLevelToLoad, AExpanded, UseLock, ALoadAll, AFound, UnassignedID, Accept: Boolean;
    KeyValue: Variant;
    Node, AParentNode: TdxMasterViewNode;

    procedure BeginDeletion(const UseItems: Boolean);
    begin
      with FControl do
      begin
        FAbsoluteItems.BeginDeletion;
        FSelectedItems.BeginDeletion;
      end;
      if UseItems then AItems.FItems.BeginDeletion;
    end;

    procedure EndDeletion(const UseItems: Boolean);
    begin
      if UseItems then AItems.FItems.EndDeletion;
      with FControl do
      begin
        FSelectedItems.EndDeletion;
        FAbsoluteItems.EndDeletion;
      end;
    end;

    function NodeFromID(const AID: Variant): TdxMasterViewNode;
    begin
      with RestItems do
      begin
        APos := -1;
        Result := nil;
        R := Count - 1;
        if R = -1 then Exit;
        L := 0;
        UnassignedID := VarIsEmpty(AID);
        while L <= R do
        begin
          C := (L + R) div 2;
          with TdxMasterViewNode(List^[C]) do
            if UnassignedID and VarIsEmpty(ID) then
              CResult := 0
            else
              try
                CResult := -VarCompare(AID, ID);
              except
                Exit;
              end;
          case CResult of
            0: begin
                 APos := C;
                 Result := List^[C];
                 Exit;
               end;
           -1: R := C - 1;
            1: L := C + 1;
          end;
        end;
      end;
    end;

    procedure UpdateOneLevel;
    var
      I, J: Integer;

      function GetNewIndex: Integer;
      begin
        if AParentNode.NodeType = ntGroup then
          Result := AParentNode.Count
        else
        begin
          Result := AvailIndex;
          Inc(AvailIndex);
        end;
      end;

    begin
      AExpanded := AItems.Expanded;
      AItems.AddToList(ALevel, RestItems, RestGroupItems, False);

      UseLock := (AItems.NodeType = ntData) and not ALevel.IsLast or
        (RestGroupItems.Count >= RestItems.Count);
      if (not ALevel.ShowCaption or (AItems.NodeType = ntCaption)) and
        (RestItems.Count <> 0) then
      begin
        J := ALevel.GroupColumnCount;
        AParentNode := TdxMasterViewNode(RestItems[0]).ParentNode;
        if (J = 0) and (AParentNode <> AItems) or
          (J <> 0) and (AParentNode = AItems) then
        begin
          if UseLock then AItems.FItems.BeginDeletion;
          try
            for I := RestItems.Count - 1 downto 0 do
            begin
              Node := TdxMasterViewNode(RestItems[I]);
              Node.ParentNode.RemoveItem(Node);
            end;
          finally
            if UseLock then AItems.FItems.EndDeletion;
          end;
        end;
        if not ALevel.SmartReload then
          RestItems.Sort(CompareItemsByID);
        I := RestGroupItems.Count;
        if (J = 0) and (I <> 0) then
        begin
          if not LockSelection then
          begin
            LockSelection := True;
            FControl.BeginSelection;
          end;
          if UseLock then BeginDeletion(True);
          try
            for I := I - 1 downto 0 do
              TdxMasterViewNode(RestGroupItems[I]).Free;
            RestGroupItems.Clear;
          finally
            if UseLock then EndDeletion(True);
          end;
        end;
      end;
      AvailIndex := AItems.GetAvailIndex(ALevel.Index);
      Node := AItems.FirstInLevel[ALevel];
      if Node = nil then
        FirstIndex := AvailIndex
      else
        FirstIndex := Node.Index;
      RestGroupItems.Sort(CompareGroupItemsByPtr);

      if UseLock then AItems.FItems.BeginInsertion;
      try
        if not AExpanded and ALevel.SmartLoad then Exit;

        with ALevel do
        begin
          if ShowCaption and (AItems.NodeType <> ntCaption) then
          begin
            Node := NodeFromID(Unassigned);
            if Node = nil then
            begin
              Node := AItems.Add(ALevel, AvailIndex, ntCaption, Unassigned, Unassigned);
              Inc(AvailIndex);
            end
            else
              RestItems.Delete(APos);
            UpdateLevels(Node);
            Exit;
          end;

          if not Active then Exit;

          if SmartReload and (RestItems.Count <> 0) and
            (TdxMasterViewNode(RestItems[0]).NodeType <> ntCaption) then
          begin
            if LevelUpdateState[AbsoluteIndex] = NoneUpdate then
              LevelUpdateState[AbsoluteIndex] := SoftUpdate;
            for I := 0 to RestItems.Count - 1 do
            begin
              Node := TdxMasterViewNode(RestItems[I]);
              AParentNode :=
                GetParentNode(AItems, Node, @FirstIndex, @AvailIndex, RestGroupItems, False);
              if Node.ParentNode <> AParentNode then
              begin
                if Node.ParentNode <> nil then
                  for J := RestItems.Count - 1 downto 0 do
                  begin
                    Node := TdxMasterViewNode(RestItems[J]);
                    Node.ParentNode.RemoveItem(Node);
                  end;
                AParentNode.AddItem(GetNewIndex, Node);
              end;
              Node.CalcSummaries(False);
              UpdateLevels(Node);
            end;
            RestItems.Clear;
            Exit;
          end;

          if LevelUpdateState[AbsoluteIndex] <> HardUpdate then
          begin
            BeginLoad;
            LevelUpdateState[AbsoluteIndex] := HardUpdate;
          end;
          ALoadAll := DontFilterRecords;
          if not ALoadAll then
            if AItems.NodeType = ntData then
              KeyValue := AItems.KeyValue[Index]
            else
              KeyValue := AItems.ParentNode.KeyValue[Index];
          with DataSet do
          begin
            if ALoadAll then
            begin
              First;
              AFound := not EOF;
            end
            else
              try
                AFound := Locate(DetailKey, KeyValue, []);
              except
                AFound := False;
              end;

            while AFound do
            begin
              AID := GetCurIDValue;
              AKeyValue := GetCurKeyValue;

              Accept := True;
              if Assigned(FOnFilterRecord) then
                FOnFilterRecord(ALevel, AID, KeyValue, Accept);
                
              if Accept then
              begin
                AParentNode :=
                  GetParentNode(AItems, nil{!!!}, @FirstIndex, @AvailIndex, RestGroupItems, False);
                Node := NodeFromID(AID);
                if Node = nil then
                  Node := AParentNode.Add(ALevel, GetNewIndex, ntData, AID, AKeyValue)
                else
                begin
                  RestItems.Delete(APos);
                  if Node.ParentNode <> AParentNode then
                  begin
                    if Node.ParentNode <> nil then
                      Node.ParentNode.RemoveItem(Node);
                    AParentNode.AddItem(GetNewIndex, Node);
                  end;
                end;
                UpdateNode(Node);
                UpdateLevels(Node);
              end;

              Next;
              AFound := not EOF;
              if AFound and not ALoadAll then
                AFound := VarAreEqual(GetCurDetailKeyValue, KeyValue);
            end;
          end;
        end;
      finally
        if UseLock then AItems.FItems.EndInsertion;

        RestGroupItems.Sort(CompareGroupItemsByGroupIndex);
        if (RestItems.Count <> 0) or (RestGroupItems.Count <> 0) then
        begin
          if not LockSelection then
          begin
            LockSelection := True;
            FControl.BeginSelection;
          end;
          AFound :=
            //(AItems.NodeType = ntData) and
            ((RestItems.Count <> 0) and
             (TdxMasterViewNode(RestItems[0]).ParentNode = AItems) or
             (RestGroupItems.Count <> 0) and
             (TdxMasterViewNode(RestGroupItems[0]).ParentNode = AItems));
          BeginDeletion(AFound);
          try
            for I := 0 to RestItems.Count - 1 do
              TdxMasterViewNode(RestItems[I]).Free;
            RestItems.Clear;
            for I := RestGroupItems.Count - 1 downto 0 do
              TdxMasterViewNode(RestGroupItems[I]).Free;
            RestGroupItems.Clear;
          finally
            EndDeletion(AFound);
          end;
        end;

        if LastLevelToLoad then
          with AItems do
          begin
            FExpanded := AExpanded;
            CheckExpanded;
          end;
      end;
    end;

  begin
    if (AItems.NodeType = ntData) and not AItems.Level.HasChildren then Exit;
    RestItems := TList.Create;
    RestItems.Capacity := 10;
    RestGroupItems := TList.Create;
    RestGroupItems.Capacity := 10;
    try
      if AItems.NodeType = ntData then
        for I := 0 to AItems.Level.Count - 1 do
        begin
          ALevel := AItems.Level[I];
          LastLevelToLoad := ALevel.IsLast;
          UpdateOneLevel;
        end
      else
      begin
        ALevel := AItems.Level;
        LastLevelToLoad := True;
        UpdateOneLevel;
      end;
    finally
      RestGroupItems.Free;
      RestItems.Free;
      AItems.FinalizeSummaries(nil);
    end;
  end;

//var
//  ft,lt:integer;

begin
  if (FControl.FLayoutLockCount <> 0) or
    ([csLoading, csDestroying] * FControl.ComponentState <> []) then Exit;

//  ft:=gettickcount;

  if UpdateChildren then
    CancelLevel(FLevel, FNodeType <> ntData);

  with FControl do
  begin
    if FUpdatingData then Exit;
    FUpdatingData := True;
  end;
  try
    PrevCursor := Screen.Cursor;
    if FControl.ShowHourGlassCursor then Screen.Cursor := crHourGlass;
    FControl.BeginUpdate;
    try
      if (FParentNode <> nil) and UpdateSelf then
      begin
        if FLevel.Active then
          with FLevel do
          begin
            AID := GetCurIDValue;
            AKeyValue := GetCurKeyValue;
            UpdateNode(Self);
          end  
        else
          ClearValues;
        if not UpdateChildren then
        begin
          FControl.FDontInvalidate := True;
          Invalidate(nil, vpContent);
        end;
      end;
      if UpdateChildren then
        if (FNodeType = ntData) and FLevel.HasChildren or
          (FNodeType = ntCaption) then
        begin
          FControl.BeginTopNodeChange;
          try
            I := FControl.AbsoluteLevelCount * SizeOf(Integer);
            GetMem(LevelUpdateState, I);
            FillChar(LevelUpdateState^, I, 0);
            try
              UpdateLevels(Self);
            finally
              for I := 0 to FControl.AbsoluteLevelCount - 1 do
                with FControl.AbsoluteLevels[I] do
                  case LevelUpdateState[AbsoluteIndex] of
                    SoftUpdate: DoSorting;
                    HardUpdate: EndLoad(True);
                  end;
              FreeMem(LevelUpdateState);
              if LockSelection then FControl.EndSelection;
            end;
          finally
            FControl.EndTopNodeChange;
          end;
        end
        else
          Clear;
      if (FLevel.Parent <> nil) and UpdateOther then
        with FParentNode do
        begin
          DoSorting(Self.FLevel);
          if HasSummariesData then
          begin
            InitializeSummaries(Self.FLevel);
            try
              I := FirstInLevel[Self.Level].Index;
              for I := I to I + CountInLevel[Self.Level] - 1 do
                Items[I].CalcSummaries(False);
            finally
              FinalizeSummaries(Self.FLevel);
            end;
          end;  
          if FControl.FDontInvalidate then
            Invalidate(nil, vpAllAndBelow);
        end;
    finally
      FControl.EndUpdate;
      if FControl.ShowHourGlassCursor then Screen.Cursor := PrevCursor;
    end;
  finally
    FControl.FUpdatingData := False;
  end;

//  lt:=gettickcount;
//  application.mainform.caption:=inttostr(lt-ft);
//  application.messagebox(pchar(inttostr(lt-ft)),'TdxMasterViewNode.UpdateData',0);

end;

procedure TdxMasterViewNode.UpdateDataForLevel(ALevel: TdxMasterViewLevel);
var
  I: Integer;
begin
  if (FNodeType = ntData) and (FLevel = ALevel.Parent) then
    UpdateData(False, True, False)
  else
    if ALevel.HasAsParent(FLevel) then
    begin
      I := 0;
      while I < Count do
        with Items[I] do
        begin
          UpdateDataForLevel(ALevel);
          I := Index + 1;
        end;
    end;
end;

procedure TdxMasterViewNode.CreateSummaries;
var
  I: Integer;
begin
  if (FNodeType = ntData) and FLevel.HasChildren or (FNodeType <> ntData) then
  begin
    if FNodeType = ntData then
      I := FLevel.Count
    else
      I := 1;
    GetMem(FSummaries, I * SizeOf(PdxMVSummaryValues));
    if FNodeType = ntData then
      for I := 0 to I - 1 do
        with FLevel[I] do
          if FSummaryColumns.Count <> 0 then
            GetMem(FSummaries[I], FSummaryColumns.Count * SizeOf(Extended))
          else
            FSummaries[I] := nil
    else
      if FLevel.FSummaryColumns.Count <> 0 then
        GetMem(FSummaries[0], FLevel.FSummaryColumns.Count * SizeOf(Extended))
      else
        FSummaries[0] := nil
  end;
end;

procedure TdxMasterViewNode.DestroySummaries;
var
  I: Integer;
begin
  if FSummaries <> nil then
  begin
    if FNodeType = ntData then
      for I := 0 to FLevel.Count - 1 do
        if FSummaries[I] <> nil then FreeMem(FSummaries[I])
        else
    else
      if FSummaries[0] <> nil then FreeMem(FSummaries[0]);
    FreeMem(FSummaries);
    FSummaries := nil;
  end;
end;

procedure TdxMasterViewNode.CheckSummaries;
begin
  if FSummaries = nil then CreateSummaries;
  InitializeSummaries(nil); 
end;

procedure TdxMasterViewNode.InitializeSummaries(ALevel: TdxMasterViewLevel);
var
  AIndex: Integer;
  Column: TdxMasterViewColumn;

  procedure InitializeOne(ALevel: TdxMasterViewLevel);
  var
    I: Integer;
  begin
    with ALevel do
      for I := 0 to FSummaryColumns.Count - 1 do
      begin
        Column := TdxMasterViewColumn(FSummaryColumns[I]);
        case Column.SummaryType of
          stMin: FSummaries[AIndex][I] := MaxExtended;
          stMax: FSummaries[AIndex][I] := MinExtended;
        else
          FSummaries[AIndex][I] := 0;
        end;
        Column.DoBeforeCalcSummary(Self, DataSet, FSummaries[AIndex][I]);
      end
  end;

begin
  if FSummariesInitialized then Exit;
  if ALevel = nil then
    if FNodeType = ntData then
      for AIndex := 0 to FLevel.Count - 1 do
        InitializeOne(FLevel[AIndex])
    else
    begin
      AIndex := 0;
      InitializeOne(FLevel);
    end
  else
  begin
    if FNodeType = ntData then
      AIndex := ALevel.Index
    else
      AIndex := 0;
    InitializeOne(ALevel);
  end;
  FSummariesInitialized := True;
end;

procedure TdxMasterViewNode.CalcSummaries(UseRealData: Boolean);
const
  NumberVarTypes =
    [varSmallint, varInteger, varSingle, varDouble, varCurrency, varDate, varByte];
var
  AIndex, I: Integer;
  SummaryValue: Extended;
  SummaryVariant: Variant;
  Column: TdxMasterViewColumn;
begin
  if FNodeType = ntData then
  begin
    if FParentNode.NodeType = ntData then
      AIndex := FLevel.Index
    else
      AIndex := 0;
    with FLevel do
      for I := 0 to FSummaryColumns.Count - 1 do
        with TdxMasterViewColumn(FSummaryColumns[I]) do
        begin
          if (SummaryField = nil) or (SummaryType = stCount) then
            SummaryValue := 0
          else
          begin
            if UseRealData then
              SummaryVariant := SummaryField.Value
            else
            begin
              Column := ColumnByFieldName(SummaryFieldName);
              if Column = nil then
                SummaryVariant := Null
              else
                SummaryVariant := Values[Column.Index];
            end;
            if VarType(SummaryVariant) in NumberVarTypes then
              SummaryValue := SummaryVariant
            else
              SummaryValue := 0;
          end;
          DoCalcSummary(Self, DataSet, SummaryValue);
          with FParentNode do
            case SummaryType of
              stSum, stAverage:
                FSummaries[AIndex][I] := FSummaries[AIndex][I] + SummaryValue;
              stMin:
                if SummaryValue < FSummaries[AIndex][I] then
                  FSummaries[AIndex][I] := SummaryValue;
              stMax:
                if SummaryValue > FSummaries[AIndex][I] then
                  FSummaries[AIndex][I] := SummaryValue;
            end;
        end;
  end;
end;

procedure TdxMasterViewNode.FinalizeSummaries(ALevel: TdxMasterViewLevel);
var
  AIndex, C: Integer;
  Column: TdxMasterViewColumn;

  procedure FinalizeOne(ALevel: TdxMasterViewLevel);
  var
    I: Integer;
  begin
    with ALevel do
      for I := 0 to FSummaryColumns.Count - 1 do
      begin
        Column := TdxMasterViewColumn(FSummaryColumns[I]);
        case Column.SummaryType of
          stCount:
            FSummaries[AIndex][I] := CountInLevel[ALevel];
          stAverage:
            begin
              C := CountInLevel[ALevel];
              if C = 0 then
                FSummaries[AIndex][I] := 0
              else
                FSummaries[AIndex][I] := FSummaries[AIndex][I] / C;
            end;
        end;
        Column.DoAfterCalcSummary(Self, DataSet, FSummaries[AIndex][I]);
      end
  end;

begin
  if ALevel = nil then
    for AIndex := 0 to Count - 1 do
      Items[AIndex].FinalizeSummaries(nil);
  if not FSummariesInitialized then Exit;
  if ALevel = nil then
    if FNodeType = ntData then
      for AIndex := 0 to FLevel.Count - 1 do
        FinalizeOne(FLevel[AIndex])
    else
    begin
      AIndex := 0;
      FinalizeOne(FLevel);
    end
  else
  begin
    if FNodeType = ntData then
      AIndex := ALevel.Index
    else
      AIndex := 0;
    FinalizeOne(ALevel);
  end;
  FSummariesInitialized := False;
end;

function TdxMasterViewNode.BeginLevel(var Size: Integer): Boolean;
begin
  Result := Expanded;
  if Result and (FNodeType = ntData) then
    Size := Level.LevelSeparatorWidth
  else
    Size := 0;
end;

function TdxMasterViewNode.EndLevel(var Size, EndLevelCount, EndLevelData: Integer): Boolean;
var
  ANode: TdxMasterViewNode;
  AlreadyInc: Boolean;
  I: Integer;
begin
  Size := 0;
  EndLevelCount := 0;
  EndLevelData := 0;
  Result := not Expanded and IsLastInLevel;
  if Result then
  begin
    AlreadyInc := False;
    I := 0;
    ANode := Self;
    repeat
      with ANode do
      begin
        if not IsLastInLevel then Break;
        with Level do
        begin
          if (NodeType = ntData) and ShowFooter then
            Inc(Size, RowCount * FooterHeight);
          if ParentNode.Level <> Level then
          begin
            if Parent.Parent <> nil then
            begin
              Inc(Size, Parent.LevelSeparatorWidth);
              SetHasLevelSeparator(EndLevelData, I);
              if ANode.IsLast then
              begin
                Inc(Size, Parent.RowSeparatorWidth);
                SetHasRowSeparator(EndLevelData, I);
              end;
            end;
            if AlreadyInc then AlreadyInc := False
            else Inc(EndLevelCount);
          end
          else
            if NodeType = ntData then
            begin
              Inc(EndLevelCount);
              AlreadyInc := True;
            end;
        end;
        if not IsLast then Break;
        if ParentNode.Level <> Level then Inc(I);
        ANode := ParentNode;
      end;
    until ANode.ParentNode = nil;
  end;
end;

function TdxMasterViewNode.HasExpandButton: Boolean;
begin
  Result := (FNodeType <> ntData) or FLevel.HasExpandButton;
end;

function TdxMasterViewNode.HasFooter(AParentIndex: Integer): Boolean;
begin
  Result := (FViewInfo.FooterSize <> 0) and
    ((AParentIndex <> 0) or (FNodeType = ntData));
  if Result and (AParentIndex <> -1) then
    with FLevel.Parents[AParentIndex] do
      Result := ShowFooter and (AParentIndex < FViewInfo.EndLevelCount);
end;

function TdxMasterViewNode.HasGroupByBox(var Size: Integer): Boolean;
begin
  with FLevel do
  begin
    Result := ShowGroupByBox and (Self = FFirstVisibleNode);
    if Result then
      Size := GroupByBoxHeight
    else
      Size := 0;
  end;
end;

function TdxMasterViewNode.HasHeader(ATopIndex: Integer; var Size: Integer): Boolean;
begin
  Result :=
    (FNodeType = ntData) and FLevel.ShowHeader and
    (not FLevel.Horizontal or
     ((lohForFirstNode in FLevel.OptionsHeader) and IsFirstInLevel or
      (lohAfterExpandedNode in FLevel.OptionsHeader) and
        (Index <> 0) and FParentNode.FItems.List^[Index - 1].Expanded or
      (lohForFirstVisibleNode in FLevel.OptionsHeader) and
        (Self = FLevel.FFirstVisibleNodeWithData)));
  if Result then
    with FLevel do
      Size := VisibleRowCount * HeaderRealHeight
  else
    Size := 0;
end;

function TdxMasterViewNode.HasLevelSeparator(ALevelParentIndex: Integer): Boolean;
begin
  Result := FViewInfo.EndLevelData and (1 shl ALevelParentIndex) <> 0;
end;

function TdxMasterViewNode.HasPreview: Boolean;
begin
  with Level do
    Result := ShowPreview and ((FPreviewText <> '') or (PreviewLineCount <> 0));
end;

function TdxMasterViewNode.HasRowSeparator(ALevelParentIndex: Integer): Boolean;
begin
  Result := FViewInfo.EndLevelData and (1 shl (ALevelParentIndex + 16)) <> 0;
end;

function TdxMasterViewNode.HasSummariesData: Boolean;
begin
  Result := FSummaries <> nil;
end;

function TdxMasterViewNode.CalcViewInfo(const ATopIndex: Integer; const R: TRect;
  const AIndent, AWidth: Integer; var AFooterSize: Integer; const StoreInfo: Boolean): Integer;
var
  I, J: Integer;
begin
  with FViewInfo do
  begin
    with FLevel do
    begin
      case FNodeType of
        ntData:
          begin
            if PreviewSize = 0 then
              if HasPreview then
                CalcPreviewLineCount(FPreviewDC, FPreviewText,
                  AWidth - Byte(HasExpandButton) * LevelIndent, Self, I)
              else
                I := 0
            else
              I := PreviewSize;
            Result := VisibleRowCount * ContentRealHeight + I;
            if (I <> 0) or (LineWidth = 0) then Inc(Result, ExtLineWidth);
          end;
        ntCaption:
          begin
            I := 0;
            Result := CaptionHeight + ExtLineWidth;
          end;
        ntGroup:
          begin
            I := 0;
            Result := GroupHeight + ExtLineWidth;
          end;
      else
        Result := 0;
      end;
      if StoreInfo then PreviewSize := I;
      if not FExpanded and (FNodeType = ntData) then
        Inc(Result, RowSeparatorWidth);
      if HasGroupByBox(I) then Inc(Result, I);
      if StoreInfo then GroupByBoxSize := I;
      if HasHeader(ATopIndex, I) and Horizontal then Inc(Result, I);
      if StoreInfo then HeaderSize := I;
    end;
    if BeginLevel(I) then
    begin
      Inc(Result, I);
      AFooterSize := 0;
      if StoreInfo then
      begin
        FooterSize := 0;
        EndLevelCount := 0;
        EndLevelData := 0;
      end;
    end
    else
    begin
      if EndLevel(AFooterSize, I, J) then Inc(Result, AFooterSize);
      if StoreInfo then
      begin
        FooterSize := AFooterSize;
        EndLevelCount := I;
        EndLevelData := J;
      end;
    end;
    if StoreInfo then
    begin
      with Bounds do
      begin
        Left := AIndent;
        Right := Left + AWidth;
        case FNodeType of
          ntCaption:
            with FLevel do
              Dec(Left, (1 + GroupColumnCount) * (LevelIndent + ExtLineWidth));
          ntGroup:
            with FLevel do
              Dec(Left, (GroupColumnCount - GroupIndex) * (LevelIndent + ExtLineWidth));
        end;
        Top := R.Top;
        Bottom := Top + Result;
      end;
//      Indent := AIndent; //:= Bounds.Left !!!
      Options := [];
      LevelIndex := GetLevelIndex;
    end;
  end;
end;

procedure TdxMasterViewNode.ClearViewInfo;
begin
  SetRectEmpty(FViewInfo.Bounds);
end;

function TdxMasterViewNode.ContentColIndexFromX(X: Integer): Integer;
begin
  Result := FLevel.Layout.ColFromX(X);
end;

function TdxMasterViewNode.ContentRowIndexFromY(Y: Integer): Integer;
var
  R: TRect;
begin
  R := FullContentBounds;
  if (FNodeType = ntData) and (R.Top <= Y) and (Y < R.Bottom) then
  begin
    Result := (Y - R.Top) div FLevel.ContentRealHeight;
    if Result >= FLevel.RowCount then Result := -1;
  end
  else
    Result := -1;
end;

function TdxMasterViewNode.FooterColIndexFromX(AParentIndex: Integer; X: Integer): Integer;
begin
  Result := FLevel.Parents[AParentIndex].Layout.ColFromX(X);
end;

function TdxMasterViewNode.FooterRowIndexFromY(AParentIndex: Integer; Y: Integer): Integer;
var
  R: TRect;
begin
  R := SubFooterBounds[AParentIndex];
  if (R.Top <= Y) and (Y < R.Bottom) then
    with FLevel.Parents[AParentIndex] do
    begin
      Result := (Y - R.Top) div FooterHeight;
      if Result > RowCount - 1 then Result := -1;
    end
  else
    Result := -1;
end;

function TdxMasterViewNode.HeaderColIndexFromX(X: Integer): Integer;
begin
  Result := FLevel.Layout.ColFromX(X);
end;

function TdxMasterViewNode.HeaderRowIndexFromY(Y: Integer): Integer;
begin
  Result := InternalHeaderRowIndexFromY(Y);
  if Result >= FLevel.VisibleRowCount then Result := -1;
end;

function TdxMasterViewNode.InternalHeaderRowIndexFromY(Y: Integer): Integer;
var
  R: TRect;
begin
  R := FullHeaderBounds;
  if R.Top = R.Bottom then Result := -1
  else
  begin
    Result := (Y - R.Top) div FLevel.HeaderRealHeight;
    if Result < -1 then Result := -1;
  end;
end;

function TdxMasterViewNode.ShowExpandButton: Boolean;
begin
  Result :=
    HasChildren or
    not (lovNoButtonsWhenNoChildren in FLevel.OptionsView) or
    (not FTriedToExpand and CanExpand);
end;

procedure TdxMasterViewNode.Collapse(Recurse: Boolean);
var
  CanAnimate: Boolean;
  Delta, AnimationAreaHeight, PrevBaseValue, BaseValue, I, PrevTopIndex,
    PrevTopNodeContentRectTop, AVisibleItemCount, APartVisibleItemCount: Integer;
  BaseNode: TdxMasterViewNode;
  PrevCursor: TCursor;
  R: TRect;
  DC: HDC;

  function GetBaseValue: Integer;
  begin
    if BaseNode = nil then
      if FExpanded then
        with GetLastSubChild do
          if Visible then
            Result := ContentBounds.Bottom
          else
            Result := 0
      else
        Result := ContentBounds.Bottom
    else
      with BaseNode do
        if Visible then
          Result := ContentBounds.Top
        else
          Result := 0;
    if (Result = 0) or (Result > AnimationAreaHeight) then
      Result := AnimationAreaHeight;
  end;

  procedure PrepareAnimation1;
  begin
    CanAnimate :=
      FControl.Animation and (FParentNode <> nil) and FExpanded and
      FControl.HandleAllocated and (FControl.FUpdateLockCount = 0);
    if CanAnimate then
    begin
      ProcessPaintMessages(FControl.Handle);
      if IsLast then
      begin
        with GetLastSubChild do
          if Visible then
            Delta := ContentBounds.Bottom
          else
            Delta := 0;
        BaseNode := FParentNode;
        while (BaseNode.ParentNode <> nil) and BaseNode.IsLast do
          BaseNode := BaseNode.ParentNode;
        if BaseNode.ParentNode = nil then
          BaseNode := nil
        else
          BaseNode := BaseNode.ParentNode[BaseNode.Index + 1];
      end
      else
      begin
        with FParentNode[Index + 1] do
          if Visible then
            Delta := ContentBounds.Top
          else
            Delta := 0;
        BaseNode := FParentNode[Index + 1];
      end;
      AnimationAreaHeight := FControl.GetAnimatableHeight;
      if Delta = 0 then Delta := AnimationAreaHeight;
      PrevBaseValue := GetBaseValue;
    end;
  end;

  procedure PrepareAnimation2;
  begin
    if CanAnimate then
    begin
      PrevTopIndex := FControl.TopIndex;
      PrevTopNodeContentRectTop := FControl.TopNode.ContentBounds.Top;
      R := FullBounds;
    end;
  end;

  procedure DoAnimation;
  var
    AnimationStep, AnimationIncreaseStep: Integer;
    UpdateR: TRect;
  begin
    if CanAnimate then
    begin
      AnimationStep := AnimationOriginalStep;
      FControl.CalcViewInfo(FControl.TopIndex, -1, AVisibleItemCount, APartVisibleItemCount, True);

      if FControl.TopIndex = PrevTopIndex then
      begin
        BaseValue := GetBaseValue;
        Dec(Delta, R.Bottom);
        R.Top := R.Bottom + AnimationStep;
        R.Bottom := AnimationAreaHeight;
        AnimationIncreaseStep :=
          (R.Bottom - R.Top + Delta) div AnimationIncreaseStepDivisor1;

        FControl.BeginAnimation;
        DC := GetDC(FControl.Handle);
        try
          while (Delta > AnimationStep) and (R.Top < R.Bottom) do
          begin
            ScrollWindowEx(FControl.Handle, 0, -AnimationStep, @R, nil, 0, @UpdateR, 0);
            //FillRect(DC, UpdateR, FControl.Brush.Handle);

            Dec(Delta, AnimationStep);
            Inc(R.Top, AnimationIncreaseStep);
            Dec(R.Bottom, AnimationStep);
            Inc(AnimationStep, AnimationIncreaseStep);
          end;
        finally
          ReleaseDC(FControl.Handle, DC);
          FControl.EndAnimation;
        end;

        Invalidate(nil, vpAllAndBelow);
      end
      else
      begin
        Delta := ContentBounds.Bottom - R.Bottom;
        R.Top := PrevTopNodeContentRectTop;
        AnimationIncreaseStep :=
          (R.Bottom - R.Top) div AnimationIncreaseStepDivisor2;

        FControl.BeginAnimation;
        DC := GetDC(FControl.Handle);
        try
          while Delta > AnimationStep do
          begin
            ScrollWindowEx(FControl.Handle, 0, AnimationStep, @R, nil, 0, @UpdateR, 0);
            //FillRect(DC, UpdateR, FControl.Brush.Handle);

            Dec(Delta, AnimationStep);
            Inc(R.Top, AnimationStep);
            Inc(R.Bottom, AnimationStep);
            Inc(AnimationStep, AnimationIncreaseStep);
          end;
        finally
          ReleaseDC(FControl.Handle, DC);
          FControl.EndAnimation;
        end;

        FControl.Invalidate;
      end;
    end;
  end;

begin
  if not FExpanded or not FLevel.DoBeforeCollapse(Self) then Exit;
  PrepareAnimation1;
  PrevCursor := Screen.Cursor;
  if FControl.ShowHourGlassCursor then Screen.Cursor := crHourGlass;
  FControl.BeginUpdate;
  try
    if FParentNode <> nil then ChangeExpanded(False);
    if Recurse then
      for I := 0 to Count - 1 do Items[I].Collapse(True);
  finally
    try
      PrepareAnimation2;
    finally
      FControl.EndUpdate;
      if FControl.ShowHourGlassCursor then Screen.Cursor := PrevCursor;
      DoAnimation;
      FLevel.DoAfterCollapse(Self);
    end;  
  end;
end;

procedure TdxMasterViewNode.Delete;
var
  NewNode: TdxMasterViewNode;
  LevelUsed: PBoolArray;
  I: Integer;
  Control: TdxMasterView;

  function DeleteSelf: TdxMasterViewNode;
  var
    PrevNode: TdxMasterViewNode;
  begin
    Result := FParentNode;
    Free;
    while (Result.NodeType = ntGroup) and (Result.Count = 0) do
    begin
      PrevNode := Result;
      Result := Result.ParentNode;
      PrevNode.Free;
    end;
  end;

  procedure DeleteOne(ALevel: TdxMasterViewLevel; const AID, AKeyValue: Variant);
  var
    Node: TdxMasterViewNode;
    I: Integer;
    AFound: Boolean;
  begin
    if not LevelUsed[ALevel.AbsoluteIndex] then
    begin
      LevelUsed[ALevel.AbsoluteIndex] := True;
      ALevel.BeginLoad;
    end;
    Node := Control.NodeFromID(ALevel, AID);
    try
      if Node <> nil then Node.Sync;         
      if ALevel.HasChildren then
        for I := 0 to ALevel.Count - 1 do
          with ALevel[I] do
            if CanDelete then
              with DataSet do
              begin
                AFound := Locate(DetailKey, AKeyValue[I], []);
                while AFound do
                begin
                  DeleteOne(ALevel[I], GetCurIDValue, GetCurKeyValue);
                  AFound := not EOF and VarAreEqual(GetCurDetailKeyValue, AKeyValue[I]);
                end;
              end;
      ALevel.DataSet.Delete;
    except
      if Node <> nil then Node.UpdateData(False, False, True);
      raise;
    end;
    if Node <> nil then
      if Node = Self then
      begin
        ALevel := FLevel;
        Node := DeleteSelf;
        if Node.CountInLevel[ALevel] <> 0 then
          Node.FirstInLevel[ALevel].UpdateData(False, False, True);
      end
      else
        Node.Free;
  end;

begin
  if not CanDelete or
    (lodDeleteOnlyChildless in FLevel.OptionsDB) and
    FLevel.HasChildren and FindChildren then Exit;

  if AbsoluteIndex = -1 then NewNode := nil
  else
    if IsLast then
      if IsFirst then
        if FParentNode.ParentNode = nil then NewNode := nil
        else
        begin
          NewNode := FParentNode;
          while (NewNode.NodeType = ntGroup) and (NewNode.Count = 1) do
          begin
            if NewNode.ParentNode.Count <> 1 then
            begin
              if NewNode.IsLast then
                NewNode := NewNode.ParentNode[NewNode.Index - 1]
              else
                NewNode := NewNode.ParentNode[NewNode.Index + 1];
              Break;
            end;
            NewNode := NewNode.ParentNode;
          end;
        end
      else
        NewNode := FParentNode[Index - 1]
    else
      NewNode := FParentNode[Index + 1];

  I := FControl.AbsoluteLevelCount * SizeOf(Boolean);
  GetMem(LevelUsed, I);
  FillChar(LevelUsed^, I, 0);
  try
    Control := FControl;
    Control.BeginSelection;
    try
      Control.BeginUpdate;
      try
        DeleteOne(FLevel, FID, FKeyValue);
      finally
        try
          for I := 0 to Control.AbsoluteLevelCount - 1 do
            if LevelUsed[I] then Control.AbsoluteLevels[I].EndLoad(True);
        finally
          Control.EndUpdate;
        end;
      end;
    finally
      Control.EndSelection;
    end;
  finally  
    FreeMem(LevelUsed);
  end;
  if NewNode <> nil then
    with NewNode do
      Control.FocusedIndex := AbsoluteIndex;
end;

procedure TdxMasterViewNode.Expand(Recurse: Boolean);
var
  CanAnimate, PrevExpanded: Boolean;
  PrevCursor: TCursor;
  AnimationAreaHeight, I, AVisibleItemCount, APartVisibleItemCount, Delta: Integer;
  R: TRect;

  procedure PrepareAnimation;
  begin
    CanAnimate :=
      FControl.Animation and (FParentNode <> nil) and not FExpanded and
      FControl.HandleAllocated and (FControl.FUpdateLockCount = 0);
    if CanAnimate then
    begin
      ProcessPaintMessages(FControl.Handle);
      AnimationAreaHeight := FControl.GetAnimatableHeight;
      R := FullContentBounds;
    end;  
  end;

  procedure DoAnimation;
  var
    AnimationStep, AnimationIncreaseStep: Integer;
    DC: HDC;
    UpdateR: TRect;
  begin
    if CanAnimate and FExpanded then
    begin
      AnimationStep := AnimationOriginalStep;
      FControl.CalcViewInfo(FControl.TopIndex, -1, AVisibleItemCount, APartVisibleItemCount, True);
      
      R.Top := R.Bottom - (FLevel.ExtLineWidth + FLevel.RowSeparatorWidth);
      R.Bottom := AnimationAreaHeight - AnimationStep;
      if IsLast then
        with GetLastSubChild do
          if Visible then
            Delta := ContentBounds.Bottom
          else
            Delta := 0
      else
        with FParentNode[Index + 1] do
          if Visible then
            Delta := ContentBounds.Top
          else
            Delta := 0;
      if Delta = 0 then Delta := AnimationAreaHeight;
      Dec(Delta, R.Top);
      AnimationIncreaseStep :=
        (R.Bottom - R.Top + Delta) div AnimationIncreaseStepDivisor3;

      FControl.BeginAnimation;
      DC := GetDC(FControl.Handle);
      try
        while (Delta > AnimationStep) and (R.Top < R.Bottom) do
        begin
          ScrollWindowEx(FControl.Handle, 0, AnimationStep, @R, nil, 0, @UpdateR, 0);
          //FillRect(DC, UpdateR, FControl.Brush.Handle);

          Dec(Delta, AnimationStep);
          Inc(R.Top, AnimationStep);
          Dec(R.Bottom, AnimationIncreaseStep);
          Inc(AnimationStep, AnimationIncreaseStep);
        end;
      finally
        ReleaseDC(FControl.Handle, DC);
        FControl.EndAnimation;
      end;
      
      Invalidate(nil, vpAllAndBelow);
    end;
  end;

  procedure LockLevels(ALock: Boolean);
  var
    I: Integer;
    RootLevel: TdxMasterViewLevel;
    AllowDoAction: Boolean;

    procedure LockOne(ALevel: TdxMasterViewLevel);
    var
      I: Integer;
    begin
      if ALevel <> RootLevel then
        with ALevel do
          if SmartLoad or AllowDoAction then
          begin
            if ALock then BeginLoad
            else EndLoad(True);
            AllowDoAction := True;
          end;
      for I := 0 to ALevel.Count - 1 do LockOne(ALevel[I]);
    end;

  begin
    for I := 0 to FLevel.Count - 1 do
    begin
      RootLevel := FLevel[I];
      AllowDoAction := RootLevel.SmartLoad;
      LockOne(RootLevel);
    end;  
  end;

begin
  if not CanExpand or IsEditing or
    not Expanded and not FLevel.DoBeforeExpand(Self) then Exit;
  PrepareAnimation;
  PrevExpanded := Expanded;
  PrevCursor := Screen.Cursor;
  if FControl.ShowHourGlassCursor then Screen.Cursor := crHourGlass;
  FControl.BeginUpdate;
  try
    ChangeExpanded(True);
    if FNodeType = ntCaption then
      if FLevel.SmartLoad and (Count = 0) then
        UpdateData(False, True, False)
      else
    else
      if FNodeType = ntData then
        for I := 0 to FLevel.Count - 1 do
          if FLevel[I].SmartLoad and (CountInLevel[FLevel[I]] = 0) then
          begin
            UpdateData(False, True, False);
            Break;
          end;
    CheckExpanded;
    if Recurse then
    begin
      LockLevels(True);
      try
        for I := 0 to Count - 1 do Items[I].Expand(True);
      finally
        LockLevels(False);
      end;
    end;
  finally
    FControl.EndUpdate;
    if FControl.ShowHourGlassCursor then Screen.Cursor := PrevCursor;
    DoAnimation;
    if Expanded <> PrevExpanded then FLevel.DoAfterExpand(Self);
  end;
end;

function TdxMasterViewNode.FindChildren: Boolean;
var
  I: Integer;
begin
  Result := HasChildren;
  if Result then Exit;
  case FNodeType of
    ntData:
      for I := 0 to FLevel.Count - 1 do
        with FLevel[I] do
          if SmartLoad and Active then
          begin
            BeginLoad;
            try
              Result := DataSet.Locate(DetailKey, FKeyValue[I], []);
              if Result then Break;
            finally
              EndLoad(False);
            end;
          end;
    ntCaption:
      with FLevel do
        if SmartLoad and Active then
          if ParentCount = 2 then
            with DataSet do
              Result := not (BOF and EOF)
          else
          begin
            BeginLoad;
            try
              Result := DataSet.Locate(DetailKey, FParentNode.KeyValue[Index], []);
            finally
              EndLoad(False);
            end;
          end;
  end;
end;

function TdxMasterViewNode.GetParentNode(ALevel: TdxMasterViewLevel;
  OnlyDataNodes: Boolean): TdxMasterViewNode;
begin
  Result := Self;
  while (Result <> nil) and (Result.Level <> ALevel) do
    Result := Result.ParentNode;
  if Result <> nil then
    if OnlyDataNodes then
    begin
      while (Result.NodeType <> ntData) and
        (Result.ParentNode <> nil) and (Result.ParentNode.Level = ALevel) do
        Result := Result.ParentNode;
      if Result.NodeType <> ntData then Result := nil;
    end;
{  if Result <> nil then
    if OnlyDataNodes then
      if Result.NodeType <> ntData then Result := nil
      else
    else
      while (Result.ParentNode <> nil) and (Result.ParentNode.Level = ALevel) do
        Result := Result.ParentNode;}
end;

procedure TdxMasterViewNode.MakeVisible;
var
  Node: TdxMasterViewNode;
begin
  Node := FParentNode;
  while Node <> nil do
  begin
    Node.Expanded := True;
    Node := Node.ParentNode;
  end;
end;

procedure TdxMasterViewNode.LoadChildren(Recurse: Boolean);
var
  PrevExpanded: Boolean;
  I: Integer;
begin
  FControl.BeginUpdate;
  try
    PrevExpanded := Expanded;
    try
      Expanded := True;
      if Recurse then
        for I := 0 to Count - 1 do
          Items[I].LoadChildren(Recurse);
    finally
      Expanded := PrevExpanded;
    end;
  finally
    FControl.EndUpdate;
  end;
end;

function TdxMasterViewNode.NodeFromID(ALevel: TdxMasterViewLevel;
  const AID: Variant): TdxMasterViewNode;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.Level = ALevel then
      if Result.NodeType = ntData then
        if VarAreEqual(Result.ID, AID) then Exit
        else
      else
        if (Result.NodeType = ntCaption) and VarIsEmpty(AID) then Exit
        else
        begin
          Result := Result.NodeFromID(ALevel, AID);
          if Result <> nil then Exit;
        end;
  end;
  Result := nil;
end;

function TdxMasterViewNode.NodeFromKeyValue(ALevel: TdxMasterViewLevel;
  AChildIndex: Integer; const AKeyValue: Variant): TdxMasterViewNode;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.Level = ALevel then
      if Result.NodeType = ntData then
        if VarAreEqual(Result.KeyValue[AChildIndex], AKeyValue) then Exit
        else
      else
      begin
        Result := Result.NodeFromKeyValue(ALevel, AChildIndex, AKeyValue);
        if Result <> nil then Exit;
      end;
  end;
  Result := nil;
end;

{ TdxMasterView }

constructor TdxMasterView.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csCaptureMouse];
  ParentColor := False;
  TabStop := True;
  Width := 230;
  Height := 170;
  FAbsoluteItems := TdxMasterViewList.Create(nil, lmAbsoluteItems);
  FAbsoluteLevels := TList.Create;
  FArrowsColor := clLime;
  FBitmap := TBitmap.Create;
  FCustomizationFormPos := Point(-1, -1);
  FCustomizationFormRowCount := dxMVCustomizationFormRowCount;
  FLevels := TdxMasterViewLevel.Create(nil);
  FLevels.FControl := Self;
  FItems := TdxMasterViewNode.Create(Self, FLevels, nil, -1, ntData, Unassigned, Unassigned);
  FItems.ChangeExpanded(True);
  FOptionsBehavior :=
    [mobUseIndent];
  FOptionsDB :=
    [modSyncMove];
  FOptionsView :=
    [movAnimation, movHideFocusRect, movKeepColumnWidths,
     movTransparentDragAndDrop, movUseBitmapToDrawPreview];
  FSelectedItems := TdxMasterViewList.Create(FItems, lmSelectedItems);
  FStyles := TList.Create;
end;

destructor TdxMasterView.Destroy;
begin
  try
    if not IsDesigning then
    begin
      if mobStoreInIniFile in FOptionsBehavior then
        SaveToRegIniFile(FIniFileName, riIniFile);
      if mobStoreInRegistry in FOptionsBehavior then
        SaveToRegIniFile(FRegistryPath, riRegistry);
    end;    
  finally
    if dxMVDesigner <> nil then dxMVDesigner.Hide(Self);
    HighlightStyle := nil;
    InactiveStyle := nil;
    DestroyStyles;
    FStyles.Free;
    FItems.Free;
    FItems := nil;
    FLevels.Free;
    FLevels := nil;
    FSelectedItems.Free;
    FBitmap.Free;
    FAbsoluteLevels.Free;
    FAbsoluteItems.Free;
    inherited;
  end;  
end;

function TdxMasterView.GetAbsoluteItemCount: Integer;
begin
  Result := FAbsoluteItems.Count;
end;

function TdxMasterView.GetAbsoluteItem(Index: Integer): TdxMasterViewNode;
begin
  Result := FAbsoluteItems[Index];
end;

function TdxMasterView.GetAbsoluteLevelCount: Integer;
begin
  Result := FAbsoluteLevels.Count;
end;

function TdxMasterView.GetAbsoluteLevel(Index: Integer): TdxMasterViewLevel;
begin
  Result := FAbsoluteLevels[Index];
end;

function TdxMasterView.GetAnimation: Boolean;
begin
  Result := movAnimation in FOptionsView;
end;

function TdxMasterView.GetAutoColumnWidth: Boolean;
begin
  Result := movAutoColumnWidth in FOptionsView;
end;

function TdxMasterView.GetCustomizationFormLevel: TdxMasterViewLevel;
begin
  if FCustomizing then
    Result := TdxMVCustomizationForm(FCustomizationForm).ActiveLevel
  else
    Result := nil;
end;

function TdxMasterView.GetFocusedIndex: Integer;
begin
  if FFocusedNode = nil then Result := -1
  else Result := FFocusedNode.AbsoluteIndex;
end;

function TdxMasterView.GetHasFocus: Boolean;
begin
  Result := Focused;
end;

function TdxMasterView.GetHighlightBrush: HBRUSH;
begin
  if (HighlightStyle <> nil) and (svColor in HighlightStyle.AssignedValues) then
    Result := HighlightStyle.Brush
  else
    Result := GetSysColorBrush(COLOR_HIGHLIGHT);
end;

function TdxMasterView.GetHighlightColor: TColor;
begin
  if (HighlightStyle <> nil) and (svColor in HighlightStyle.AssignedValues) then
    Result := HighlightStyle.Color
  else
    Result := clHighlight;
end;

function TdxMasterView.GetHighlightFontColor: TColor;
begin
  if (HighlightStyle <> nil) and (svFont in HighlightStyle.AssignedValues) then
    Result := HighlightStyle.Font.Color
  else
    Result := clHighlightText;
end;

function TdxMasterView.GetInactiveBrush: HBRUSH;
begin
  if (InactiveStyle <> nil) and (svColor in InactiveStyle.AssignedValues) then
    Result := InactiveStyle.Brush
  else
    Result := GetSysColorBrush(COLOR_BTNFACE);
end;

function TdxMasterView.GetInactiveColor: TColor;
begin
  if (InactiveStyle <> nil) and (svColor in InactiveStyle.AssignedValues) then
    Result := InactiveStyle.Color
  else
    Result := clBtnFace;
end;

function TdxMasterView.GetInactiveFocusBrush: HBRUSH;
begin
  if (InactiveStyle <> nil) and (svAnotherColor in InactiveStyle.AssignedValues) then
    Result := InactiveStyle.AnotherBrush
  else
    Result := 0;
end;

function TdxMasterView.GetInactiveFocusColor: TColor;
begin
  if (InactiveStyle <> nil) and (svAnotherColor in InactiveStyle.AssignedValues) then
    Result := InactiveStyle.AnotherColor
  else
    Result := clNone;
end;

function TdxMasterView.GetInactiveFontColor: TColor;
begin
  if (InactiveStyle <> nil) and (svFont in InactiveStyle.AssignedValues) then
    Result := InactiveStyle.Font.Color
  else
    Result := clBtnText;
end;

function TdxMasterView.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TdxMasterView.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxMasterView.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TdxMasterView.GetMultiSelect: Boolean;
begin
  Result := mobMultiSelect in FOptionsBehavior;
end;

function TdxMasterView.GetPartVisibleItemCount: Integer;
var
  AVisibleItemCount: Integer;
begin
  CalcViewInfo(TopIndex, -1, AVisibleItemCount, Result, True{False});
end;
{
function TdxMasterView.GetScrollableWidth: Integer;
var
  I, Size: Integer;
begin
  Result := 0;
  for I := 0 to LevelCount - 1 do
    with Levels[I] do
      if Visible then
      begin
        Size := Indent + VisibleWidth;
        if Size > Result then Result := Size;
      end;
end;
}
function TdxMasterView.GetSelectedItem(Index: Integer): TdxMasterViewNode;
begin
  if MultiSelect then
    Result := FSelectedItems[Index]
  else
    Result := FFocusedNode;
end;

function TdxMasterView.GetSelectedItemCount: Integer;
begin
  if MultiSelect then
    Result := FSelectedItems.Count
  else
    Result := Byte(FFocusedNode <> nil);
end;

function TdxMasterView.GetShowHourGlassCursor: Boolean;
begin
  Result := mobShowHourGlassCursor in FOptionsBehavior;
end;

function TdxMasterView.GetStyle(Index: Integer): TdxMasterViewStyle;
begin
  Result := TdxMasterViewStyle(FStyles[Index]);
end;

function TdxMasterView.GetStyleCount: Integer;
begin
  Result := FStyles.Count;
end;

function TdxMasterView.GetSyncMove: Boolean;
begin
  Result := modSyncMove in FOptionsDB;
end;

function TdxMasterView.GetTopIndex: Integer;
begin
  if FTopNode = nil then
    Result := -1
  else
    Result := FTopNode.AbsoluteIndex;
end;

function TdxMasterView.GetTransparentDragAndDrop: Boolean;
begin
  Result := movTransparentDragAndDrop in FOptionsView;
end;

function TdxMasterView.GetUseIndent: Boolean;
begin
  Result := mobUseIndent in FOptionsBehavior;
end;

function TdxMasterView.GetVisibleItemCount: Integer;
var
  APartVisibleItemCount: Integer;
begin
  CalcViewInfo(TopIndex, -1, Result, APartVisibleItemCount, True{False});
end;

function TdxMasterView.GetWidthForColumns: Integer;
begin
  Result := ScrollableWidth;
end;

procedure TdxMasterView.SetCanUseSmartReload(Value: Boolean);
var
  I: Integer;
begin
  if not Value or (FLayoutLockCount = 0) then
    for I := 0 to AbsoluteLevelCount - 1 do
      if not Value or (AbsoluteLevels[I].FDataChangingLockCount = 0) then
        AbsoluteLevels[I].CanUseSmartReload := Value;
end;

procedure TdxMasterView.SetCustomizationFormLevel(Value: TdxMasterViewLevel);
begin
  if FCustomizing then
    TdxMVCustomizationForm(FCustomizationForm).ActiveLevel := Value;
end;

procedure TdxMasterView.SetCustomizationFormRowCount(Value: Integer);
begin
  if Value < 2 then Value := 2;
  FCustomizationFormRowCount := Value;
end;

procedure TdxMasterView.SetCustomizing(Value: Boolean);
begin
  if (FCustomizing <> Value) and
    (HandleAllocated and IsWindowVisible(Handle) and (FLevels.Count <> 0) or not Value) then
  begin
    FCustomizing := Value;
    if FCustomizing then
      FCustomizationForm := TdxMVCustomizationForm.Create(Self)
    else
    begin
      with FCustomizationForm do
        if not (csDestroying in ComponentState) then Free;
      FCustomizationForm := nil;
    end;
    if Assigned(FOnCustomizing) then FOnCustomizing(Self, Value);
  end;
end;

procedure TdxMasterView.SetFocusedIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value >= AbsoluteItemCount then Value := AbsoluteItemCount - 1;
  if FocusedIndex <> Value then
    ChangeFocusedIndex(Value);
end;

procedure TdxMasterView.SetFocusedNode(Value: TdxMasterViewNode);
var
  PrevFocusedNode: TdxMasterViewNode;
begin
  if FFocusedNode <> Value then
  begin
    PrevFocusedNode := FFocusedNode;
    FFocusedNode := Value;
    if not IsDestroying and Assigned(FOnFocusNode) then
      FOnFocusNode(Self, PrevFocusedNode, FFocusedNode);
  end;
end;

procedure TdxMasterView.SetHighlightStyle(Value: TdxMasterViewStyle);
begin
  if FHighlightStyle <> Value then
  begin
    if FHighlightStyle <> nil then
      FHighlightStyle.RemoveConsumeType(Self, sctHighlight);
    FHighlightStyle := Value;
    if FHighlightStyle <> nil then
      FHighlightStyle.AddConsumeType(Self, sctHighlight);
    HighlightStyleChanged([]);
  end;
end;

procedure TdxMasterView.SetInactiveStyle(Value: TdxMasterViewStyle);
begin
  if FInactiveStyle <> Value then
  begin
    if FInactiveStyle <> nil then
      FInactiveStyle.RemoveConsumeType(Self, sctInactive);
    FInactiveStyle := Value;
    if FInactiveStyle <> nil then
      FInactiveStyle.AddConsumeType(Self, sctInactive);
    InactiveStyleChanged([]);
  end;
end;

procedure TdxMasterView.SetLeftPos(Value: Integer);
begin
  Value := CheckLeftPos(Value);
  if FLeftPos <> Value then
  begin
    if HandleAllocated then
      ScrollWindowEx(Handle, FLeftPos - Value, 0, nil, nil, 0, nil, SW_INVALIDATE);
    FLeftPos := Value;
    if HandleAllocated then UpdateWindow(Handle);
    if Assigned(FOnLeftPosChanged) then FOnLeftPosChanged(Self);
  end;
end;

procedure TdxMasterView.SetOptionsBehavior(Value: TdxMasterViewOptionsBehavior);
var
  ChangedValues: TdxMasterViewOptionsBehavior;
begin
  if FOptionsBehavior <> Value then
  begin
    Word(ChangedValues) := Word(Value) xor Word(FOptionsBehavior);

    if mobMultiSelect in ChangedValues then
      if not (mobMultiSelect in Value) then ClearSelectedItems;

    FOptionsBehavior := Value;

    if [mobAnsiCompareStrOnGrouping, mobCaseInsensitiveGrouping] * ChangedValues <> [] then
    begin
      CanUseSmartReload := False;
      UpdateData;
    end;
    if [mobAnsiCompareStrOnSorting, mobCaseInsensitiveSorting] * ChangedValues <> [] then
      DoSorting;
    if mobMultiSelect in ChangedValues then
      if FocusedNode <> nil then FocusedNode.NodeChanged(False);
  end;
end;

procedure TdxMasterView.SetOptionsDB(Value: TdxMasterViewOptionsDB);
var
  ChangedValues: TdxMasterViewOptionsDB;
begin
  if FOptionsDB <> Value then
  begin
    Byte(ChangedValues) := Byte(Value) xor Byte(FOptionsDB);

    FOptionsDB := Value;

    if modSyncMove in ChangedValues then
      if SyncMove and (FFocusedNode <> nil) then FFocusedNode.SyncPos;
  end;
end;

procedure TdxMasterView.SetOptionsView(Value: TdxMasterViewOptionsView);
var
  ChangedValues: TdxMasterViewOptionsView;
begin
  if FOptionsView <> Value then
  begin
    Word(ChangedValues) := Word(Value) xor Word(FOptionsView);

    FOptionsView := Value;

    if movAutoColumnWidth in ChangedValues then
      if not AutoColumnWidth and (movKeepColumnWidths in FOptionsView) then
        AssignColumnWidths
      else
      begin
        WidthChanged;
        Invalidate;
      end;
    if movDrawEndEllipsis in ChangedValues then
      Invalidate;
    if [movHideFocusRect, movHideSelection] * ChangedValues <> [] then
      InvalidateSelection;
  end;
end;

procedure TdxMasterView.SetScrollBars(Value: TdxMVScrollBars);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TdxMasterView.SetTopIndex(Value: Integer);
begin
  Value := CheckTopIndex(Value);
  if TopIndex <> Value then
    if Value = -1 then
      TopNode := nil
    else
      TopNode := AbsoluteItems[Value];
end;

procedure TdxMasterView.SetTopNode(Value: TdxMasterViewNode);
begin
  if FTopNode <> Value then
  begin
    FTopNode := Value;
    if not IsDestroying then DoTopNodeChanged;
  end;
end;

procedure TdxMasterView.AddStyle(AStyle: TdxMasterViewStyle);
begin
  FStyles.Add(AStyle);
  AStyle.FControl := Self;
end;

procedure TdxMasterView.RemoveStyle(AStyle: TdxMasterViewStyle);
begin
  FStyles.Remove(AStyle);
  AStyle.FControl := nil;
end;

procedure TdxMasterView.AddSelectedItem(ANode: TdxMasterViewNode);
begin
  FSelectedItems.Add(ANode);
end;

procedure TdxMasterView.RemoveSelectedItem(ANode: TdxMasterViewNode);
begin
  FSelectedItems.Remove(ANode);
end;

procedure TdxMasterView.ClearSelectedItems;
var
  I: Integer;
begin
  if not MultiSelect then Exit;
  BeginSelection;
  try
    for I := SelectedItemCount - 1 downto 0 do
      SelectedItems[I].Selected := False;
  finally
    EndSelection;
  end;
end;

procedure ScrollTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT; Time: DWORD); stdcall;
begin
  with TdxMasterView(FindControl(Wnd)) do
  begin
    case TdxMasterViewDirection(idEvent - ScrollLeftTimerId + 1) of
      dirLeft:
        Scroll(dirLeft);
      dirUp:
        begin
          FocusedIndex := FocusedIndex - 1;
          SelectPeriod(FocusedNode);
        end;
      dirRight:
        Scroll(dirRight);
      dirDown:
        begin
          FocusedIndex := FocusedIndex + 1;
          SelectPeriod(FocusedNode);
        end;
    end;
  end;
end;

procedure TdxMasterView.CreateScrollTimer(Direction: TdxMasterViewDirection);
begin
  if FScrollTimer <> 0 then
    if TdxMasterViewDirection(FScrollTimer - ScrollLeftTimerId + 1) <> Direction then
      DestroyScrollTimer
    else
      Exit;
  FScrollTimer := SetTimer(Handle, ScrollLeftTimerId + Ord(Direction) - 1,
    ScrollTimeStep div (1 + Byte(Direction in [dirLeft, dirRight])), @ScrollTimerProc);
end;

procedure TdxMasterView.DestroyScrollTimer;
begin
  if FScrollTimer <> 0 then
  begin
    KillTimer(Handle, FScrollTimer);
    FScrollTimer := 0;
  end;
end;

procedure TdxMasterView.WMCaptureChanged(var Message: TMessage);
begin
  DestroyScrollTimer;
  if mvsSelectPeriod in FState then SelectPeriod(FSelectionAnchor);
  FSelectionAnchor := nil;
  FState := FState - [mvsCtrlClick, mvsIndentClick, mvsAnchorSelected, mvsSelectPeriod];
  inherited;
end;

procedure TdxMasterView.WMDestroy(var Message: TMessage);
begin
  Customizing := False;
  inherited;
end;

procedure TdxMasterView.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
{
  fillrect(Message.DC, ClientRect, createsolidbrush(clred));
  Message.Result := 0;
}
end;

procedure TdxMasterView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTALLKEYS;
end;

procedure TdxMasterView.WMHScroll(var Message: TWMHScroll);
var
  ScrollInfo: TScrollInfo;
begin
  inherited;
  case Message.ScrollCode of
    SB_LINEUP:
      Scroll(dirLeft);
    SB_LINEDOWN:
      Scroll(dirRight);
    SB_PAGEUP:
      LeftPos := LeftPos - ClientWidth;
    SB_PAGEDOWN:
      LeftPos := LeftPos + ClientWidth;
    SB_THUMBTRACK:
      begin
        with ScrollInfo do
        begin
          cbSize := SizeOf(ScrollInfo);
          fMask := SIF_TRACKPOS;
        end;
        GetScrollInfo(Handle, SB_HORZ, ScrollInfo);
        LeftPos := ScrollInfo.nTrackPos;
      end;
  end;
end;

procedure TdxMasterView.WMKillFocus(var Message: TWMKillFocus); 
begin
  inherited;
  InvalidateSelection;
end;

procedure TdxMasterView.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  if not IsDesigning and Enabled then SetFocus;
end;

procedure TdxMasterView.WMMouseWheel(var Message: TMessage);
begin
  inherited;
  if SmallInt(HiWord(Message.wParam)) > 0 then
    Scroll(dirUp)
  else
    Scroll(dirDown);
end;

procedure TdxMasterView.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TdxMasterView.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
  FLastMousePos := SmallPointToPoint(Message.Pos);
  Windows.ScreenToClient(Handle, FLastMousePos);
end;

procedure TdxMasterView.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  inherited;
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);

  DC := GetWindowDC(Handle);

  DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);

  if GetWindowLong(Handle, GWL_STYLE) and (WS_HSCROLL or WS_VSCROLL) =
    WS_HSCROLL or WS_VSCROLL then
    with R do
    begin
      Dec(Right);
      Dec(Bottom);
      Left := Right - GetSystemMetrics(SM_CXVSCROLL);
      Top := Bottom - GetSystemMetrics(SM_CYHSCROLL);
      FillRect(DC, R, COLOR_BTNFACE + 1);
    end;

  ReleaseDC(Handle, DC);
end;

procedure TdxMasterView.WMSetCursor(var Message: TWMSetCursor);
var
  HitTestCode: TdxMasterViewHitTestCode;
  Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn;
  RowIndex, ColIndex: Integer;
  ACursor: TCursor;
begin
  HitTestCode := GetHitTestInfo(FLastMousePos, Node, Column, RowIndex, ColIndex);
  if (HitTestCode = htIndent) and not IsDesigning then
    ACursor := crdxMasterViewMirror
  else
    case HitTestCode of
      htHeaderRightEdge, htContentRightEdge:
        ACursor := crdxMasterViewHorSize;
      htHeaderTopEdge, htHeaderBottomEdge:
        ACursor := crdxMasterViewVerSize;
    else
      inherited;
      Exit;
    end;
  SetCursor(Screen.Cursors[ACursor]);
end;

procedure TdxMasterView.WMSetFocus(var Message: TWMSetFocus);
begin
  InvalidateSelection;
  inherited;
end;

procedure TdxMasterView.WMSize(var Message: TWMSize);
begin
  inherited;
  if AutoColumnWidth then CalcScrollableWidth(nil);
end;

procedure TdxMasterView.WMVScroll(var Message: TWMVScroll);
var
  ScrollInfo: TScrollInfo;
begin
  case Message.ScrollCode of
    SB_LINEUP:
      Scroll(dirUp);
    SB_LINEDOWN:
      Scroll(dirDown);
    SB_PAGEUP:
      ShowPrevPage(TopIndex, False);
    SB_PAGEDOWN:
      ShowNextPage(TopIndex + VisibleItemCount - 1, False);
    SB_THUMBTRACK:
      begin
        with ScrollInfo do
        begin
          cbSize := SizeOf(ScrollInfo);
          fMask := SIF_TRACKPOS;
        end;
        GetScrollInfo(Handle, SB_VERT, ScrollInfo);
        TopIndex := ScrollInfo.nTrackPos;
      end;
  end;
end;

procedure TdxMasterView.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if Message.WindowPos^.flags and SWP_HIDEWINDOW <> 0 then
    Customizing := False;
end;

procedure TdxMasterView.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  HitTestCode: TdxMasterViewHitTestCode;
  Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn;
  RowIndex, ColIndex: Integer;
begin
  HitTestCode := GetHitTestInfo(SmallPointToPoint(Message.Pos), Node, Column,
    RowIndex, ColIndex);
  Message.Result := Byte(
    (Message.Keys and MK_LBUTTON <> 0) and
      (HitTestCode in
        HeaderHitTests + [htExpandButton, htContentLeftEdge, htContentRightEdge]) or
    (Message.Keys and MK_MBUTTON <> 0));
end;

procedure TdxMasterView.CMFontChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to AbsoluteLevelCount - 1 do
    AbsoluteLevels[I].FontsChanged;
end;

procedure TdxMasterView.CMSysColorChange(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to StyleCount - 1 do
    Styles[I].SysColorChanged;
end;

procedure TdxMasterView.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    if FScrollBars <> sbNone then
      Style := Style or WS_HSCROLL or WS_VSCROLL;
  end;
end;

procedure TdxMasterView.CreateWnd;
begin
  inherited;
  SendMessage(Handle, CM_FONTCHANGED, 0, 0);
end;

procedure TdxMasterView.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to StyleCount - 1 do
    if Styles[I].Owner = Root then Proc(Styles[I]);
  for I := 0 to FLevels.Count - 1 do
    if FLevels[I].Owner = Root then Proc(FLevels[I]);
end;

procedure TdxMasterView.KeyDown(var Key: Word; Shift: TShiftState);
var
  PrevFocusedNode, Node: TdxMasterViewNode;
  Level: TdxMasterViewLevel;
  I: Integer;
begin
  inherited;
  PrevFocusedNode := FocusedNode;
  case Key of
    VK_ESCAPE:
      if GetCapture = Handle then ReleaseCapture;
    VK_UP:
      begin
        Node :=
          GetPrevNode(FFocusedNode, (ssAlt in Shift) and (FFocusedNode <> nil));
        if Node <> nil then Node.Focused := True;
      end;
    VK_DOWN:
      begin
        Node :=
          GetNextNode(FFocusedNode, (ssAlt in Shift) and (FFocusedNode <> nil));
        if Node <> nil then Node.Focused := True;
      end;
    VK_HOME:
      begin
        if (ssAlt in Shift) and (FFocusedNode <> nil) then
          Node := FFocusedNode.ParentNode.FirstInLevel[FFocusedNode.Level]
        else
          Node := nil;
        Node := GetNextNode(Node, Node <> nil);
        if Node <> nil then Node.Focused := True;
      end;
    VK_END:
      begin
        if (ssAlt in Shift) and (FFocusedNode <> nil) then
          Node := FFocusedNode.ParentNode.LastInLevel[FFocusedNode.Level]
        else
          Node := nil;
        Node := GetPrevNode(Node, Node <> nil);
        if Node <> nil then Node.Focused := True;
      end;
    VK_PRIOR:
      begin
        if (ssAlt in Shift) and (FFocusedNode <> nil) then
          Level := FFocusedNode.Level
        else
          Level := nil;
        Node := GetFirstNodeFromVisible(Level);
        I := TopIndex;  
        if (Node <> nil) and (Node.AbsoluteIndex > I) then
          I := Node.AbsoluteIndex;
        if (TopIndex > 0) and
          ((FocusedIndex <= I) or
           (FocusedIndex > TopIndex + VisibleItemCount - 1)) then
          ShowPrevPage(FocusedIndex, Level <> nil);
        Node := GetFirstNodeFromVisible(Level);
        if Node <> nil then Node.Focused := True;
      end;
    VK_NEXT:
      begin
        if (ssAlt in Shift) and (FFocusedNode <> nil) then
          Level := FFocusedNode.Level
        else
          Level := nil;
        Node := GetLastNodeFromVisible(Level);
        I := TopIndex + VisibleItemCount - 1;
        if (Node <> nil) and (Node.AbsoluteIndex < I) then
          I := Node.AbsoluteIndex;
        if (FocusedIndex < TopIndex) or (FocusedIndex >= I) then
          ShowNextPage(FocusedIndex, Level <> nil);
        Node := GetLastNodeFromVisible(Level);
        if Node <> nil then Node.Focused := True;
      end;
    VK_ADD, VK_RIGHT:
      if (FocusedNode <> nil) and not FocusedNode.Expanded and FocusedNode.CanExpand then
        FocusedNode.Expanded := True
      else
        if Key = VK_RIGHT then Scroll(dirRight);
    VK_SUBTRACT, VK_LEFT:
      if (FocusedNode <> nil) and FocusedNode.Expanded then
        FocusedNode.Expanded := False
      else
        if Key = VK_LEFT then Scroll(dirLeft);
    VK_MULTIPLY:
      if FocusedNode <> nil then
{        if FocusedNode.Expanded then
          FocusedNode.Collapse(True)
        else}
          FocusedNode.Expand(True);
    VK_SPACE:
      if MultiSelect and (FocusedNode <> nil) then
        with FocusedNode do
          Selected := not Selected;
    VK_INSERT:
      begin
        if FocusedNode = nil then
          if FLevels.Count = 0 then
            Level := nil
          else 
            Level := FLevels[0]
        else
          Level := FocusedNode.Level; //!!!
        if (Level <> nil) and Level.CanInsert then
        begin
          ClearSelection;
          Level.DataSet.Insert;
        end;
      end;
    VK_DELETE:
      if (Shift = []) or (Shift = [ssCtrl]) then DeleteSelection;
  end;
  if MultiSelect and (AbsoluteItemCount <> 0) and (FocusedNode <> PrevFocusedNode) and
    (Key in [VK_UP, VK_DOWN, VK_HOME, VK_END, VK_PRIOR, VK_NEXT]) then
    if ssShift in Shift then
    begin
      if FSelectionAnchor = nil then
        if PrevFocusedNode = nil then
          FSelectionAnchor := AbsoluteItems[0]
        else
          FSelectionAnchor := PrevFocusedNode;
      BeginSelection;
      try
        ClearSelection;
        SelectItems(FSelectionAnchor.AbsoluteIndex, FocusedIndex, True);
      finally
        EndSelection;
      end;
    end
    else
    begin
      FSelectionAnchor := nil;
      if not (ssCtrl in Shift) then
      begin
        BeginSelection;
        try
          ClearSelection;
          if FocusedNode <> nil then FocusedNode.Selected := True;
        finally
          EndSelection;
        end;
      end;
    end;
end;

procedure TdxMasterView.Loaded;
begin
  inherited;
  try
    if not IsDesigning then
    begin
      if mobStoreInIniFile in FOptionsBehavior then
        LoadFromRegIniFile(FIniFileName, riIniFile);
      if mobStoreInRegistry in FOptionsBehavior then
        LoadFromRegIniFile(FRegistryPath, riRegistry);
    end;
  finally
    UpdateData;
  end;  
end;

procedure TdxMasterView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  NonDragableHitTests = HeaderHitTests +
    [htNone, htLeftSpace, htRightSpace, htGroupByBox, htExpandButton, htContentRightEdge, htFooter];
  DragSources: array[Boolean] of TdxMasterViewDragSource = (dsHeader, dsGroupByBox);
var
  HitTestCode: TdxMasterViewHitTestCode;
  Node, PrevFocusedNode: TdxMasterViewNode;
  Column: TdxMasterViewColumn;
  PrevFocusedIndex, RowIndex, ColIndex: Integer;
  NewSortOrder: TdxMasterViewSortOrder;
  LockSelection, PrevSelected: Boolean;
begin
  inherited;
  HitTestCode := GetHitTestInfo(Point(X, Y), Node, Column, RowIndex, ColIndex);
  if (Button = mbLeft) or
    (Button = mbRight) and (HitTestCode in [htContent, htContentLeftEdge, htPreview]) then
  begin
    if Node <> nil then
    begin
      case HitTestCode of
        htHeader:
          if Column <> nil then
            if not (ssDouble in Shift) then
            begin
              Column.Pressed := True;
              case DragDetect(Handle) of
                ddDrag:
                  try
                    DoColumnMoving(Node, Column, Point(X, Y), DragSources[RowIndex = -1]);
                  finally
                    Column.Pressed := False;
                  end;
                ddNone:
                  with Column do
                  begin
                    Pressed := False;
                    if CanSorting then
                    begin
                      if ssCtrl in Shift then
                        NewSortOrder := soNone
                      else
                        if SortOrder in [soNone, soDescending] then
                          NewSortOrder := soAscending
                        else
                          NewSortOrder := soDescending;
                      if [ssCtrl, ssShift] * Shift = [] then
                        with Level do
                        begin
                          BeginSorting;
                          ClearSorting(Column);
                        end;
                      SortOrder := NewSortOrder;
                      if [ssCtrl, ssShift] * Shift = [] then
                        Level.EndSorting;
                      Modified;  
                    end;
                  end;
              else
                Column.Pressed := False;
              end;
            end
            else
          else
            if ssDouble in Shift then
              Node.Level.RemoveFreeSpace;
        htHeaderRightEdge:
          if Column.Level.Horizontal then
            if ssDouble in Shift then
              Column.ApplyBestFit
            else
              DoColumnHorSizing(Column, True)
          else
            if ssDouble in Shift then
            begin
              Column.Level.Layout.HeaderWidthAssigned[Column.ColIndex] := False;
              Modified;
            end
            else
              DoColumnHorSizing(Column, False);
        htHeaderTopEdge, htHeaderBottomEdge:
          if not (ssDouble in Shift) then
            DoColumnVerSizing(Node, Column, HitTestCode);
        htIndent, htContent, htContentLeftEdge, htPreview, htOther:
          begin
            Shift := Shift - [ssLeft, ssRight]; 
            PrevFocusedIndex := FocusedIndex;
            PrevFocusedNode := FocusedNode;
            if ssDouble in Shift then
            begin
              FocusedIndex := Node.AbsoluteIndex;
              if lobDblClkExpanding in Node.Level.OptionsBehavior then
                with Node do
                  Expanded := not Expanded;
            end
            else
              if MultiSelect then
                if (Shift = []) or (Shift = [ssCtrl]) then
                begin
                  FocusedIndex := Node.AbsoluteIndex;

                  LockSelection :=
                    (Shift = []) and (SelectedItemCount > 0) and
                    (not Node.Selected or (Button <> mbRight) and (DragMode = dmManual));
                  if LockSelection then
                  begin
                    BeginSelection;
                    ClearSelection;
                  end;
                  try
                    FSelectionAnchor := Node;
                    PrevSelected := Node.Selected;
                    Node.Selected := True;
                  finally
                    if LockSelection then EndSelection;
                  end;

                  if Shift = [ssCtrl] then Include(FState, mvsCtrlClick);
                  if HitTestCode = htIndent then Include(FState, mvsIndentClick);
                  if (FState * [mvsCtrlClick, mvsIndentClick] <> []) and
                    not PrevSelected then
                    Include(FState, mvsAnchorSelected);

                  if (Button = mbLeft) and (HitTestCode <> htIndent) and
                    (DragMode = dmAutomatic) then
                  begin
                    if DragDetect(Handle) = ddDrag then
                      BeginDrag(False)
                    else
                      if (Shift = []) and (Button <> mbRight) and
                        PrevSelected and (SelectedItemCount > 1) then
                      begin
                        BeginSelection;
                        try
                          ClearSelection;
                          Node.Selected := True;
                        finally
                          EndSelection;
                        end;
                      end;
                    Exit;
                  end;

                  if FState * [mvsCtrlClick, mvsIndentClick] <> [] then
                    SetCapture(Handle);
                end
                else
                begin
                  FocusedIndex := Node.AbsoluteIndex;
                  if Shift = [ssShift] then
                  begin
                    if FSelectionAnchor = nil then
                      if PrevFocusedNode = nil then
                        FSelectionAnchor := AbsoluteItems[0]
                      else
                        FSelectionAnchor := PrevFocusedNode;
                    BeginSelection;
                    try
                      ClearSelection;
                      SelectItems(FSelectionAnchor.AbsoluteIndex, Node.AbsoluteIndex, True);
                    finally
                      EndSelection;
                    end;
                  end
                  else
                    if Shift = [ssCtrl, ssShift] then
                      SelectItems(PrevFocusedIndex, Node.AbsoluteIndex, True)
                    else
                    begin
                      FSelectionAnchor := nil;
                      BeginSelection;
                      try
                        ClearSelection;
                        Node.Selected := True;
                      finally
                        EndSelection;
                      end;
                    end;
                end
              else
              begin
                if (Shift = []) and (HitTestCode = htIndent) then
                begin
                  Include(FState, mvsIndentClick);
                  SetCapture(Handle);
                end;
                FocusedIndex := Node.AbsoluteIndex;
                if (Button = mbLeft) and (HitTestCode <> htIndent) and
                  (DragMode = dmAutomatic) and (DragDetect(Handle) = ddDrag) then
                  BeginDrag(False);
              end;
          end;
        htExpandButton:
          Node.Expanded := not Node.Expanded;
        htContentRightEdge:
          if not Column.Level.Horizontal then
            if ssDouble in Shift then
              Column.ApplyBestFit
            else
              DoColumnHorSizing(Column, True);
      end;
    end
  end
  else
  begin
    ReleaseCapture;
    if Button = mbMiddle then DoScrolling;
  end;
end;

procedure TdxMasterView.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn;
  RowIndex, ColIndex: Integer;
begin
  inherited;
  GetHitTestInfo(Point(X, Y), Node, Column, RowIndex, ColIndex);

  if not (mvsSelectPeriod in FState) and (mvsIndentClick in FState) then
  begin
    Include(FState, mvsSelectPeriod);
    FLastSelectedNode := FSelectionAnchor;
  end;

  if mvsSelectPeriod in FState then
  begin
    if (Node = nil) and (Y < 0) or
      (Node = TopNode) and (Y < Node.ContentBounds.Top) then
      CreateScrollTimer(dirUp)
    else
      if (Node = nil) and (Y >= ClientHeight) or
        (Y >= AbsoluteItems[TopIndex + VisibleItemCount - 1].ContentBounds.Bottom) then
        CreateScrollTimer(dirDown)
      else
        if X < 0 then
          CreateScrollTimer(dirLeft)
        else
          if X >= ClientWidth then
            CreateScrollTimer(dirRight)
          else
            DestroyScrollTimer;

    if Node <> nil then
    begin
      FocusedIndex := Node.AbsoluteIndex;
      SelectPeriod(Node);
    end;
  end;
end;

procedure TdxMasterView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn;
  RowIndex, ColIndex: Integer;
begin
  inherited;
  if (GetCapture = Handle) and not (mvsScrolling in FState) then
  begin
    if mvsSelectPeriod in FState then
    begin
      Exclude(FState, mvsSelectPeriod);
      if MultiSelect then
        SelectItems(FSelectionAnchor.AbsoluteIndex, FLastSelectedNode.AbsoluteIndex, True);
    end
    else
    begin
      GetHitTestInfo(Point(X, Y), Node, Column, RowIndex, ColIndex);
      if (mvsCtrlClick in FState) and (Node = FSelectionAnchor) and
        FSelectionAnchor.Selected and not (mvsAnchorSelected in FState) then
        FSelectionAnchor.Selected := False;
    end;
    ReleaseCapture;
  end;
end;

procedure TdxMasterView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TdxMasterViewStyle) then
  begin
    if HighlightStyle = AComponent then HighlightStyle := nil;
    if InactiveStyle = AComponent then InactiveStyle := nil;
  end;
end;

procedure TdxMasterView.Paint;
var
  DC: HDC;
  R: TRect;
  FromIndex, AVisibleItemCount, APartVisibleItemCount, I: Integer;
(*
var
  ft,lt{,c}:integer;
*)
begin
  if FUpdateLockCount > 0 then Exit;

  //ft:=gettickcount;
  //for c:=1 to 10 do
  //begin

  FPainting := True;
  try
    FromIndex := TopIndex;
    SetScrollBarsInfo(AVisibleItemCount, APartVisibleItemCount);

    BeforePaint;
    for I := 0 to AbsoluteLevelCount - 1 do AbsoluteLevels[I].BeforePaint;
    try
      DC := Canvas.Handle;
      R := ClientRect;
      if APartVisibleItemCount <> 0 then
      begin
        for I := FromIndex to FromIndex + APartVisibleItemCount - 1 do
          AbsoluteItems[I].Draw(DC);
        R.Top := AbsoluteItems[FromIndex + APartVisibleItemCount - 1].Bounds.Bottom;
        FillRect(DC, R, Brush.Handle);
      end
      else
        FillRect(DC, R, Brush.Handle);
    finally
      for I := 0 to AbsoluteLevelCount - 1 do AbsoluteLevels[I].AfterPaint;
      AfterPaint;

      LeftPos := LeftPos;    // for checking LeftPos
      TopIndex := TopIndex;  // for checking TopIndex
    end;
  finally
    FPainting := False;
  end;

  //end;
  {lt:=gettickcount;
  application.mainform.caption :=inttostr(lt-ft);}
end;

procedure TdxMasterView.SetName(const NewName: TComponentName);
var
  OldName: TComponentName;

  procedure RenameComponents(Mode: Integer);
  var
    I: Integer;
    Component: TComponent;
    ComponentName, NamePrefix: TComponentName;
  begin
    if Mode = 1 then
      I := StyleCount
    else
      I := AbsoluteLevelCount;
    for I := 0 to I - 1 do
    begin
      if Mode = 1 then
        Component := Styles[I]
      else
        Component := AbsoluteLevels[I];
      if Component.Owner = Owner then
      begin
        ComponentName := Component.Name;
        if Length(ComponentName) > Length(OldName) then
        begin
          NamePrefix := Copy(ComponentName, 1, Length(OldName));
          if CompareText(OldName, NamePrefix) = 0 then
          begin
            System.Delete(ComponentName, 1, Length(OldName));
            System.Insert(NewName, ComponentName, 1);
            try
              Component.Name := ComponentName;
            except
              on EComponentError do {Ignore rename errors };
            end;
          end;
        end;
      end;
    end;
  end;

begin
  OldName := Name;
  inherited;
  { In design mode the name of the columns should track the level name }
  if IsDesigning and (Name <> OldName) then
  begin
    RenameComponents(1);
    RenameComponents(2);
  end;
  if dxMVDesigner <> nil then dxMVDesigner.Changed(Self, [rcName]);
end;

procedure TdxMasterView.WndProc(var Message: TMessage);
begin
  with TWMMouse(Message) do
    if (DragMode = dmAutomatic) and not IsDesigning and not Dragging and
      ((Msg = WM_LBUTTONDOWN) or (Msg = WM_LBUTTONDBLCLK)) then
    begin
      if not IsControlMouseMsg(TWMMouse(Message)) then
      begin
        ControlState := ControlState + [csLButtonDown];
        Dispatch(Message);
      end;
      Exit;
    end;
  inherited;
end;

procedure TdxMasterView.BeginAnimation;
begin
  FAnimation := True;
  ValidateRect(Handle, nil);
end;

procedure TdxMasterView.EndAnimation;
begin
  FAnimation := False;
end;

procedure TdxMasterView.BeforePaint;
begin
  FBtnHighlightPen := CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNHIGHLIGHT));
  FBtnShadowPen := CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNSHADOW));
end;

procedure TdxMasterView.AfterPaint;
begin
  DeleteObject(FBtnShadowPen);
  DeleteObject(FBtnHighlightPen);
end;

procedure TdxMasterView.BeginTopNodeChange;
begin
  if FTopNodeChangeLockCount = 0 then
    FPrevTopNode := FTopNode;
  Inc(FTopNodeChangeLockCount);
end;

procedure TdxMasterView.EndTopNodeChange;
begin
  if FTopNodeChangeLockCount > 0 then
  begin
    Dec(FTopNodeChangeLockCount);
    if (FTopNodeChangeLockCount = 0) and (FTopNode <> FPrevTopNode) then
      DoTopNodeChanged;
  end;
end;

procedure TdxMasterView.CalcScrollableWidth(CallingLevel: TdxMasterViewLevel);
var
  PrevScrollableWidth, I, Size: Integer;

  function IsLocked: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 0 to AbsoluteLevelCount - 1 do
      if AbsoluteLevels[I].FAssignWidthsLockCount <> 0 then Exit;
    Result := False;
  end;

begin
  if FCalculatingScrollableWidth or IsLocked then Exit;
  FCalculatingScrollableWidth := True;
  try
    PrevScrollableWidth := FScrollableWidth;
    FScrollableWidth := 0;
    for I := 0 to AbsoluteLevelCount - 1 do
      with AbsoluteLevels[I] do
        if Visible then
        begin
          Size := Indent + Layout.GetVisibleWidth;
          if Size > FScrollableWidth then FScrollableWidth := Size;
        end;
    if AutoColumnWidth and (FScrollableWidth <> PrevScrollableWidth) then
      for I := 0 to AbsoluteLevelCount - 1 do
        with AbsoluteLevels[I] do
          if (AbsoluteLevels[I] <> CallingLevel) and Visible then WidthChanged;
  finally
    FCalculatingScrollableWidth := False;
  end;
end;

procedure TdxMasterView.CalcViewInfo(ATopIndex: Integer; AHeight: Integer;
  var AVisibleItemCount, APartVisibleItemCount: Integer; CalcNodesViewInfo: Boolean);
var
  Indents, Widths: PIntArray;
  I, J, FooterSize: Integer;
  R: TRect;
  Node: TdxMasterViewNode;
  PartialVisibility: Boolean;
begin
  if ATopIndex = -1 then ATopIndex := 0;
  AVisibleItemCount := 0;
  APartVisibleItemCount := 0;

  GetMem(Indents, AbsoluteLevelCount * SizeOf(Integer));
  GetMem(Widths, AbsoluteLevelCount * SizeOf(Integer));
  try
    for I := 0 to AbsoluteLevelCount - 1 do
      with AbsoluteLevels[I] do
      begin
        FFirstVisibleNode := nil;
        FFirstVisibleNodeWithData := nil;
        Widths[I] := VisibleWidth;
        Indents[I] := Indent - LeftPos;
        FPreviewDC := GetDC(Handle);
        FPreviewPrevFont := SelectObject(FPreviewDC, PreviewFont.Handle);
      end;

    Windows.GetClientRect(Handle, R);
    if AHeight = -1 then AHeight := ClientHeight;

    if CalcNodesViewInfo then
    begin
      FItems.FViewInfo.Bounds.Right := R.Right;
{      for I := 0 to ATopIndex - 1 do
        with FAbsoluteItems.List^[I] do
        begin
          ClearViewInfo;
          FViewInfo.Bounds.Right := R.Right;
        end;}
    end;

    for I := ATopIndex to AbsoluteItemCount - 1 do
    begin
      Node := FAbsoluteItems.List^[I];
      with Node, Level do
      begin
        if (FFirstVisibleNode = nil) and (NodeType <> ntCaption) then
          FFirstVisibleNode := Node;
        if (FFirstVisibleNodeWithData = nil) and (NodeType = ntData) then
          FFirstVisibleNodeWithData := Node;
        J := CalcViewInfo(ATopIndex, R, Indents[AbsoluteIndex], Widths[AbsoluteIndex],
          FooterSize, CalcNodesViewInfo);
      end;
      PartialVisibility := R.Top + J > AHeight;
      Inc(R.Top, J);
      if R.Top >= AHeight then
      begin
        APartVisibleItemCount := I - ATopIndex + 1;
        AVisibleItemCount := APartVisibleItemCount - Byte(PartialVisibility);
        if AVisibleItemCount = 0 then AVisibleItemCount := 1;
        Exit;
      end;
    end;

    APartVisibleItemCount := AbsoluteItemCount - ATopIndex;
    AVisibleItemCount := APartVisibleItemCount;
  finally
(*    if CalcNodesViewInfo then
      for I := ATopIndex + APartVisibleItemCount to AbsoluteItemCount - 1 do
        FAbsoluteItems.List^[I].ClearViewInfo;*)

    for I := 0 to AbsoluteLevelCount - 1 do
      with AbsoluteLevels[I] do
      begin
        SelectObject(FPreviewDC, FPreviewPrevFont);
        ReleaseDC(Handle, FPreviewDC);
        FPreviewDC := 0;
      end;
    FreeMem(Widths);
    FreeMem(Indents);
    if CalcNodesViewInfo then
    begin
      FLastVisibleItemCount := AVisibleItemCount;
      FLastPartVisibleItemCount := APartVisibleItemCount;
    end;
  end;
end;

procedure TdxMasterView.AssignColumnWidths;
var
  I: Integer;
begin
  for I := 0 to AbsoluteLevelCount - 1 do AbsoluteLevels[I].AssignColumnWidths;
end;

function TdxMasterView.GetAnimatableHeight: Integer;
begin
  Result := ClientHeight;
end;

procedure TdxMasterView.SetScrollBarsInfo(
  var AVisibleItemCount, APartVisibleItemCount: Integer);
var
  AStyle, HorSize, VerSize: Integer;
  HasHorScrollBar, HasVerScrollBar: Boolean;
  ScrollInfo: TScrollInfo;

  function AlwaysShowHorScrollBar: Boolean;
  begin
    Result := (FScrollBars = sbHorizontal) or (FScrollBars = sbBoth);
  end;

  function AlwaysShowVerScrollBar: Boolean;
  begin
    Result := (FScrollBars = sbVertical) or (FScrollBars = sbBoth);
  end;

  function GetHasHorScrollBar: Boolean;
  begin
    Result := (FScrollBars <> sbNone) and
      (AlwaysShowHorScrollBar or (ScrollableWidth > HorSize));
  end;

  function GetHasVerScrollBar: Boolean;
  begin
    Result := (FScrollBars <> sbNone) and
      (AlwaysShowVerScrollBar or (AbsoluteItemCount > AVisibleItemCount));
  end;

begin  //  sbAuto, sbHorizontal, sbVertical, sbBoth, sbNone
  AStyle := GetWindowLong(Handle, GWL_STYLE);
  HorSize := ClientWidth;
  if AStyle and WS_VSCROLL <> 0 then
    Inc(HorSize, GetSystemMetrics(SM_CXVSCROLL));
  VerSize := ClientHeight;
  if AStyle and WS_HSCROLL <> 0 then
    Inc(VerSize, GetSystemMetrics(SM_CYHSCROLL));

  HasHorScrollBar := GetHasHorScrollBar;
  if HasHorScrollBar then
    Dec(VerSize, GetSystemMetrics(SM_CYHSCROLL));
  CalcViewInfo(TopIndex, VerSize, AVisibleItemCount, APartVisibleItemCount, True);
  HasVerScrollBar := GetHasVerScrollBar;
  if HasVerScrollBar then
  begin
    Dec(HorSize, GetSystemMetrics(SM_CXVSCROLL));
    if not HasHorScrollBar then
    begin
      HasHorScrollBar := GetHasHorScrollBar;
      if HasHorScrollBar then
      begin
        Dec(VerSize, GetSystemMetrics(SM_CYHSCROLL));
        CalcViewInfo(TopIndex, VerSize, AVisibleItemCount, APartVisibleItemCount, True);
      end;
    end;
  end;  

  if FScrollBars <> sbNone then
  begin
    with ScrollInfo do
    begin
      cbSize := SizeOf(ScrollInfo);
      fMask := SIF_ALL;
      if AlwaysShowHorScrollBar then
        fMask := fMask or SIF_DISABLENOSCROLL;
      nMin := 0;
      nMax := ScrollableWidth - 1;
      nPage := HorSize;
      nPos := LeftPos;
    end;
    SetScrollInfo(Handle, SB_HORZ, ScrollInfo, True);
    with ScrollInfo do
    begin
      fMask := SIF_ALL;
      if AlwaysShowVerScrollBar then
        fMask := fMask or SIF_DISABLENOSCROLL;
      nMin := 0;
      nMax := AbsoluteItemCount - 1;
      nPage := AVisibleItemCount;
      nPos := TopIndex;
    end;
    SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
  end;  
end;

procedure TdxMasterView.WidthChanged;
var
  I: Integer;
begin
  for I := 0 to AbsoluteLevelCount - 1 do AbsoluteLevels[I].WidthChanged;
end;

function TdxMasterView.CanScroll(Direction: TdxMasterViewDirection): Boolean;
begin
  case Direction of
    dirLeft:
      Result := LeftPos <> 0;
    dirRight:
      Result := LeftPos + ClientWidth < ScrollableWidth;
    dirUp:
      Result := TopIndex <> 0;
    dirDown:
      Result := TopIndex + VisibleItemCount < AbsoluteItemCount;
  else
    Result := False;
  end;
end;

function TdxMasterView.CheckLeftPos(Value: Integer): Integer;
begin
  Result := Value;
  if HandleAllocated then
  begin
    Value := ScrollableWidth - ClientWidth;
    if Result > Value then Result := Value;
  end;
  if Result < 0 then Result := 0;
end;

function TdxMasterView.CheckTopIndex(Value: Integer): Integer;
var
  FirstCall: Boolean;
  AVisibleItemCount, APartVisibleItemCount: Integer;
begin
  Result := Value;
  if HandleAllocated and (Result > 0) then
  begin
    Value := AbsoluteItemCount - 1;
    FirstCall := True;
    repeat
      if FirstCall and FPainting then
        AVisibleItemCount := FLastVisibleItemCount
      else
        CalcViewInfo(Result, -1, AVisibleItemCount, APartVisibleItemCount, False);
      if Value > Result + AVisibleItemCount - 1 then
      begin
        if not FirstCall then Inc(Result);
        Break;
      end;
      FirstCall := False;
      Dec(Result);
      if Result = -1 then Break;
    until False;
  end;
  if Result < 0 then
    if AbsoluteItemCount > 0 then
      Result := 0
    else
      Result := -1;
  if Result >= AbsoluteItemCount then
    Result := AbsoluteItemCount - 1;
end;

procedure TdxMasterView.CheckFocusedNode;
var
  NonExpandedNode, Node: TdxMasterViewNode;
begin
  if FocusedNode = nil then Exit; //!!!
  NonExpandedNode := nil;
  Node := FocusedNode;
  while Node.ParentNode <> nil do
  begin
    if not Node.Expanded then NonExpandedNode := Node;
    Node := Node.ParentNode;
  end;
  if NonExpandedNode <> nil then
    if CanFocusNode(NonExpandedNode) then
      NonExpandedNode.Focused := True
    else
      FocusedNode := nil;
end;

procedure TdxMasterView.DestroyStyles;
begin
  while StyleCount <> 0 do Styles[0].Free;
end;

procedure TdxMasterView.DoAfterUpdateData(Level: TdxMasterViewLevel);
begin
  if Assigned(FOnAfterUpdateData) then FOnAfterUpdateData(Self, Level);
end;

procedure TdxMasterView.DoBeforeUpdateData(Level: TdxMasterViewLevel);
begin
  if Assigned(FOnBeforeUpdateData) then FOnBeforeUpdateData(Self, Level);
end;

procedure TdxMasterView.DoColumnMoving(Node: TdxMasterViewNode; Column: TdxMasterViewColumn;
  const InitialP: TPoint; DragSource: TdxMasterViewDragSource);
const
  ArrowWidth = 11;
  ArrowHeight = 9;
  Cursors: array[Boolean] of Integer = (crdxMasterViewNoDrop, crdxMasterViewRemove);
type
  PColors = ^TColors;
  TColors = array[0..MaxInt - 1] of Byte;
var
  Level: TdxMasterViewLevel;
  PrevP, P, Offset: TPoint;
  R: TRect;
  W, H, TempBitmapW, TempBitmapH,
    AColIndex, ARowIndex, ActiveRowIndex, ActiveColIndex: Integer;
  DC, AlphaBlendDC, TempDC, SaveDC, BDC, SaveArrowsDC: HDC;
  AlphaBlendBitmap, PrevAlphaBlendBitmap, TempBitmap, SaveB, B, SaveArrowsB: HBITMAP;
  BI: TBitmapInfo;
  DColors, SColors: PColors;
  ArrowsBrush: HBRUSH;
  Accept, Success, AForceMove, ActiveForceMove, AInsert, ActiveInsert: Boolean;
  CaptureWnd: HWND;
  Msg: TMsg;
  HitTestCode: TdxMasterViewHitTestCode;
  ActiveNode, ANode: TdxMasterViewNode;
  AColumn: TdxMasterViewColumn;

  procedure PrepareAlphaBlend;
  begin
    with BI.bmiHeader do
    begin
      biSize := SizeOf(BI.bmiHeader);
      biWidth := W;
      biHeight := -H;
      biPlanes := 1;
      biBitCount := 32;
      biCompression := BI_RGB;
    end;

    AlphaBlendDC := CreateCompatibleDC(DC);
    AlphaBlendBitmap := CreateCompatibleBitmap(DC, W, H);
    PrevAlphaBlendBitmap := SelectObject(AlphaBlendDC, AlphaBlendBitmap);

    TempBitmapW := W;
    TempBitmapH := H;
    TempDC := CreateCompatibleDC(DC);
    TempBitmap := CreateCompatibleBitmap(DC, TempBitmapW, TempBitmapH);
    TempBitmap := SelectObject(TempDC, TempBitmap);

    GetMem(DColors, 4 * W * H);
    GetMem(SColors, 4 * W * H);

    B := SelectObject(BDC, B);
    GetDIBits(DC, B, 0, H, SColors, BI, DIB_RGB_COLORS);
    B := SelectObject(BDC, B);
  end;

  procedure UnprepareAlphaBlend;
  begin
    FreeMem(SColors, 4 * W * H);
    FreeMem(DColors, 4 * W * H);

    DeleteObject(SelectObject(TempDC, TempBitmap));
    DeleteDC(TempDC);

    DeleteObject(SelectObject(AlphaBlendDC, PrevAlphaBlendBitmap));
    DeleteDC(AlphaBlendDC);
  end;

  procedure DrawDraggingColumn(P: TPoint);
  var
    SaveR, R, R1, R2: TRect;
    CurOffset: TPoint;
    Rgn, Rgn1, Rgn2: HRGN;

    procedure MakeAlphaBlend;
    const
      AlphaConst = 127;
    var
      I, J, K: Integer;
    begin
      GetDIBits(DC, AlphaBlendBitmap, 0, H, DColors, BI, DIB_RGB_COLORS);

      for I := 0 to W - 1 do
        for J := 0 to H - 1 do
        begin
          K := (J * W + I) * 4;
          Inc(DColors^[K], MulDiv(AlphaConst, SColors^[K] - DColors^[K], 255));
          Inc(DColors^[K + 1], MulDiv(AlphaConst, SColors^[K + 1] - DColors^[K + 1], 255));
          Inc(DColors^[K + 2], MulDiv(AlphaConst, SColors^[K + 2] - DColors^[K + 2], 255));
        end;

      SetDIBits(DC, AlphaBlendBitmap, 0, H, DColors, BI, DIB_RGB_COLORS);
    end;

    function GetTempBitmapBounds: TRect;
    begin
      with Result do
      begin
        if P.X < PrevP.X then
        begin
          Left := P.X;
          Right := PrevP.X;
        end
        else
        begin
          Left := PrevP.X;
          Right := P.X;
        end;
        if P.Y < PrevP.Y then
        begin
          Top := P.Y;
          Bottom := PrevP.Y;
        end
        else
        begin
          Top := PrevP.Y;
          Bottom := P.Y;
        end;
        Inc(Right, W);
        Inc(Bottom, H);
      end;
    end;

    procedure CheckTempBitmapSize(const R: TRect);
    var
      RequireRecreate: Boolean;
    begin
      RequireRecreate := False;
      if R.Right - R.Left > TempBitmapW then
        RequireRecreate := True
      else
        if R.Bottom - R.Top > TempBitmapH then
          RequireRecreate := True;
      if RequireRecreate then
      begin
        DeleteObject(SelectObject(TempDC, TempBitmap));
        TempBitmapW := R.Right - R.Left;
        TempBitmapH := R.Bottom - R.Top;
        TempBitmap := CreateCompatibleBitmap(DC, TempBitmapW, TempBitmapH);
        TempBitmap := SelectObject(TempDC, TempBitmap);
      end;
    end;

  begin
    if P.X = MaxInt then
      BitBlt(DC, PrevP.X - Offset.X, PrevP.Y - Offset.Y, W, H, SaveDC, 0, 0, SRCCOPY)
    else
    begin
      Dec(P.X, Offset.X);
      Dec(P.Y, Offset.Y);

      if PrevP.X = MaxInt then
      begin
        BitBlt(SaveDC, 0, 0, W, H, DC, P.X, P.Y, SRCCOPY);
        if TransparentDragAndDrop then
        begin
          BitBlt(AlphaBlendDC, 0, 0, W, H, DC, P.X, P.Y, SRCCOPY);
          MakeAlphaBlend;
          BitBlt(DC, P.X, P.Y, W, H, AlphaBlendDC, 0, 0, SRCCOPY);
        end;
      end
      else
      begin
        Dec(PrevP.X, Offset.X);
        Dec(PrevP.Y, Offset.Y);
        if TransparentDragAndDrop then
        begin
          R := GetTempBitmapBounds;
          CheckTempBitmapSize(R);

          with R do
          begin
            BitBlt(TempDC, 0, 0, R.Right - R.Left, R.Bottom - R.Top, DC, Left, Top, SRCCOPY);
            BitBlt(TempDC, PrevP.X - Left, PrevP.Y - Top, W, H, SaveDC, 0, 0, SRCCOPY);
            BitBlt(SaveDC, 0, 0, W, H, TempDC, P.X - Left, P.Y - Top, SRCCOPY);

            BitBlt(AlphaBlendDC, 0, 0, W, H, SaveDC, 0, 0, SRCCOPY);
            MakeAlphaBlend;
            BitBlt(TempDC, P.X - Left, P.Y - Top, W, H, AlphaBlendDC, 0, 0, SRCCOPY);
            
            BitBlt(DC, Left, Top, Right - Left, Bottom - Top, TempDC, 0, 0, SRCCOPY);
          end;
        end
        else
        begin
          SaveR := Bounds(PrevP.X, PrevP.Y, W, H);
          R := Bounds(P.X, P.Y, W, H);

          Rgn := CreateRectRgn(0, 0, 0, 0);
          Rgn1 := CreateRectRgnIndirect(SaveR);
          Rgn2 := CreateRectRgnIndirect(R);

          CombineRgn(Rgn, Rgn1, Rgn2, RGN_DIFF);

          SelectClipRgn(DC, Rgn);
          BitBlt(DC, PrevP.X, PrevP.Y, W, H, SaveDC, 0, 0, SRCCOPY);
          SelectClipRgn(DC, 0);

          R1 := Rect(0, 0, W, H);
          R2 := R1;
          CurOffset := Point(P.X - PrevP.X, P.Y - PrevP.Y);
          OffsetRect(R2, -CurOffset.X, -CurOffset.Y);

          with R2 do
            BitBlt(SaveDC, Left, Top, Right - Left, Bottom - Top, SaveDC, 0, 0, SRCCOPY);

          CombineRgn(Rgn, Rgn2, Rgn1, RGN_DIFF);
          OffsetRgn(Rgn, -P.X, -P.Y);

          SelectClipRgn(SaveDC, Rgn);
          BitBlt(SaveDC, 0, 0, W, H, DC, P.X, P.Y, SRCCOPY);
          SelectClipRgn(SaveDC, 0);

          DeleteObject(Rgn2);
          DeleteObject(Rgn1);
          DeleteObject(Rgn);
        end;
      end;  

      if not TransparentDragAndDrop then
        BitBlt(DC, P.X, P.Y, W, H, BDC, 0, 0, SRCCOPY);

      Inc(P.X, Offset.X);
      Inc(P.Y, Offset.Y);
    end;

    PrevP := P;
  end;

  procedure SetActivePlace(NodeValue: TdxMasterViewNode; ARowIndex, AColIndex: Integer;
    AForceMove, AInsert: Boolean);

    procedure CalcArrowsRects(var TopArrowRect, BottomArrowRect: TRect);
    begin
      if ActiveRowIndex = -1 then  // GroupBy Box
      begin
        TopArrowRect := ActiveNode.GroupByBoxColumnBounds[ActiveColIndex -
          Byte(ActiveColIndex = Level.GroupColumnCount)];
        if ActiveColIndex = 0 then
          Dec(TopArrowRect.Left, GroupByBoxHorOffset div 2)
        else
          if ActiveColIndex = Level.GroupColumnCount then
            TopArrowRect.Left := TopArrowRect.Right + GroupByBoxHorOffset div 2
          else
            OffsetRect(TopArrowRect,
              -GroupByBoxHorOffset div 2,
              -(Level.HeaderRealHeight div 2 + GroupByBoxVerOffset) div 2);
        with TopArrowRect do
        begin
          if Left < 0 then Left := 0;
          if Left >= ClientWidth then Left := ClientWidth - 1;
        end;
        TopArrowRect.Right := TopArrowRect.Left + 1;
        InflateRect(TopArrowRect, ArrowWidth div 2, ArrowHeight);
        MapWindowPoints(Handle, 0, TopArrowRect, 2);
        BottomArrowRect := TopArrowRect;
        with TopArrowRect do
          Bottom := Top + ArrowHeight;
        with BottomArrowRect do
          Top := Bottom - ArrowHeight;
      end
      else
        if Level.Horizontal then
        begin
          TopArrowRect := ActiveNode.HeaderRowBounds[ActiveRowIndex];
          if ActiveInsert then
          begin
            with TopArrowRect do
            begin
              if Left < 0 then Left := 0;
              if Right > ClientWidth then Right := ClientWidth;
              if ActiveRowIndex <> 0 then Dec(Top);
              Bottom := Top + 1;
              InflateRect(TopArrowRect, -(Right - Left) div 4, ArrowWidth div 2);
            end;
            MapWindowPoints(Handle, 0, TopArrowRect, 2);
            BottomArrowRect := TopArrowRect;
            with TopArrowRect do
              Right := Left + ArrowHeight;
            with BottomArrowRect do
              Left := Right - ArrowHeight;
          end
          else
          begin
            with Level, TopArrowRect do
              if ActiveColIndex > 0 then
                Left := Layout.Columns[ActiveRowIndex, ActiveColIndex - 1].
                  GetHeaderBounds(ActiveNode).Right;
            with TopArrowRect do
            begin
              if Left < 0 then Left := 0;
              if Left >= ClientWidth then Left := ClientWidth - 1;
              Right := Left + 1;
            end;
            InflateRect(TopArrowRect, ArrowWidth div 2, ArrowHeight);
            MapWindowPoints(Handle, 0, TopArrowRect, 2);
            BottomArrowRect := TopArrowRect;
            with TopArrowRect do
              Bottom := Top + ArrowHeight;
            with BottomArrowRect do
              Top := Bottom - ArrowHeight;
          end;
        end
        else
        begin
          if (ActiveColIndex = Level.Layout.Count) (*or
            (ActiveRowIndex = Level.Layout[ActiveColIndex].Count) and (ActiveRowIndex = 0){!?}*) then
            with TopArrowRect do
            begin
              with Level.Layout do
              begin
                Left := ColOffsets[ActiveColIndex];
                Right := Left + FMovingColumn.Width;
              end;
              Top := ActiveNode.ContentBounds.Top;
              Bottom := Top + 1;
            end
          else
            if ActiveRowIndex = Level.Layout[ActiveColIndex].Count then
            begin
              TopArrowRect :=
                Level.Layout.Columns[ActiveRowIndex - 1, ActiveColIndex].GetHeaderBounds(ActiveNode);
              with TopArrowRect do
              begin
                Top := Bottom;
                Inc(Bottom);
              end;
            end
            else
            begin
              TopArrowRect :=
                Level.Layout.Columns[ActiveRowIndex, ActiveColIndex].GetHeaderBounds(ActiveNode);
              with TopArrowRect do
                Bottom := Top + 1;
            end;
          with TopArrowRect do
          begin
            if Left < 0 then Left := 0;
            if Left >= ClientWidth then Left := ClientWidth - 1;
            if Right < 0 then Right := 0;
            if Right >= ClientWidth then Right := ClientWidth - 1;
            if ActiveInsert then
            begin
              Right := Left + 1;
              Bottom := ActiveNode.ContentBoundsWithoutPreview.Bottom;
              InflateRect(TopArrowRect, ArrowWidth div 2, ArrowHeight)
            end
            else
              InflateRect(TopArrowRect, ArrowHeight, ArrowWidth div 2);
          end;
          MapWindowPoints(Handle, 0, TopArrowRect, 2);
          BottomArrowRect := TopArrowRect;
          if ActiveInsert then
          begin
            with TopArrowRect do
              Bottom := Top + ArrowHeight;
            with BottomArrowRect do
              Top := Bottom - ArrowHeight;
          end
          else
          begin
            with TopArrowRect do
              Right := Left + ArrowHeight;
            with BottomArrowRect do
              Left := Right - ArrowHeight;
          end;
        end;
    end;

    procedure HideArrows;
    var
      R1, R2: TRect;
    begin
      CalcArrowsRects(R1, R2);
      with R1 do
        BitBlt(DC, Left, Top, Right - Left, Bottom - Top, SaveArrowsDC, 0, 0, SRCCOPY);
      with R2 do
        BitBlt(DC, Left, Top, Right - Left, Bottom - Top, SaveArrowsDC, 0, ArrowWidth, SRCCOPY);
    end;

    procedure ShowArrows;
    var
      R1, R2: TRect;
      P: array[1..7] of TPoint;
      PrevPen: HPEN;
      PrevBrush: HBRUSH;
    begin
      CalcArrowsRects(R1, R2);
      with R1 do
        BitBlt(SaveArrowsDC, 0, 0, Right - Left, Bottom - Top, DC, Left, Top, SRCCOPY);
      with R2 do
        BitBlt(SaveArrowsDC, 0, ArrowWidth, Right - Left, Bottom - Top, DC, Left, Top, SRCCOPY);

      PrevPen := SelectObject(DC, GetStockObject(BLACK_PEN));
      PrevBrush := SelectObject(DC, ArrowsBrush);

      if (ActiveRowIndex <> -1) and  // not GroupBy Box
        (Level.Horizontal and ActiveInsert or
         not Level.Horizontal and not ActiveInsert) then
      begin
        with R1 do
        begin
          P[1] := Point(Left, Top + 3);
          P[2] := Point(Left + 3, Top + 3);
          P[3] := Point(Left + 3, Top);
          P[4] := Point(Right - 1, Top + 5);
          P[5] := Point(Left + 3, Bottom - 1);
          P[6] := Point(Left + 3, Bottom - 4);
          P[7] := Point(Left, Bottom - 4);
        end;
        Polygon(DC, P, 7);
        with R2 do
        begin
          P[1].X := Right - 1;
          P[2].X := Right - 4;
          P[3].X := Right - 4;
          P[4].X := Left;
          P[5].X := Right - 4;
          P[6].X := Right - 4;
          P[7].X := Right - 1;
        end;
        Polygon(DC, P, 7);
      end
      else
      begin
        with R1 do
        begin
          P[1] := Point(Left + 3, Top);
          P[2] := Point(Right - 4, Top);
          P[3] := Point(Right - 4, Top + 3);
          P[4] := Point(Right - 1, Top + 3);
          P[5] := Point(Left + 5, Bottom - 1);
          P[6] := Point(Left, Top + 3);
          P[7] := Point(Left + 3, Top + 3);
        end;
        Polygon(DC, P, 7);
        with R2 do
        begin
          P[1].Y := Bottom - 1;
          P[2].Y := Bottom - 1;
          P[3].Y := Bottom - 4;
          P[4].Y := Bottom - 4;
          P[5].Y := Top;
          P[6].Y := Bottom - 4;
          P[7].Y := Bottom - 4;
        end;
        Polygon(DC, P, 7);
      end;

      SelectObject(DC, PrevBrush);
      SelectObject(DC, PrevPen);
    end;

    function CanInsert: Boolean;
    begin
      if ActiveRowIndex = -1 then  // GroupBy Box
        Result :=
          (FMovingColumn.GroupIndex = -1) or
          (ActiveColIndex < FMovingColumn.GroupIndex) or
          (FMovingColumn.GroupIndex < ActiveColIndex - 1)
      else
        if FMovingColumn.Visible then
          if Level.Horizontal then
            Result :=
              (FMovingColumn.RowIndex <> ActiveRowIndex) or
              ActiveForceMove or ActiveInsert or
              (ActiveColIndex < FMovingColumn.ColIndex) or
              (FMovingColumn.ColIndex + 1 < ActiveColIndex)
          else
            Result :=
              ActiveInsert and
                (not Level.Layout.OneOnLine(FMovingColumn) or
                 (ActiveColIndex < FMovingColumn.ColIndex) or
                 (FMovingColumn.ColIndex + 1 < ActiveColIndex)) or
              not ActiveInsert and
                ((ActiveColIndex <> FMovingColumn.ColIndex) or
                 (ActiveRowIndex < FMovingColumn.RowIndex) or
                 (ActiveRowIndex > FMovingColumn.RowIndex + FMovingColumn.RowCount))
        else
          Result := True;
    end;

  begin
    if (ActiveNode <> NodeValue) or
      (ActiveRowIndex <> ARowIndex) or (ActiveColIndex <> AColIndex) or
      (ActiveForceMove <> AForceMove) or (ActiveInsert <> AInsert) then
    begin
      if PrevP.X <> MaxInt then DrawDraggingColumn(Point(MaxInt, 0));
      if (ActiveNode <> nil) and (ActiveColIndex <> -1) and CanInsert then
        HideArrows;
      ActiveNode := NodeValue;
      ActiveRowIndex := ARowIndex;
      ActiveColIndex := AColIndex;
      ActiveForceMove := AForceMove;
      ActiveInsert := AInsert;
      if (ActiveNode <> nil) and (ActiveColIndex <> -1) and CanInsert then
        ShowArrows;
      if PrevP.X <> MaxInt then DrawDraggingColumn(PrevP);
    end;
  end;

  procedure DestroyScrollTimer;
  begin
    if FScrollTimer <> 0 then
    begin
      KillTimer(Handle, FScrollTimer);
      FScrollTimer := 0;
    end;
  end;

  procedure CreateScrollTimer(Direction: TdxMasterViewDirection);
  begin
    if FScrollTimer <> 0 then
      if TdxMasterViewDirection(FScrollTimer - ScrollLeftTimerId + 1) <> Direction then
        DestroyScrollTimer
      else
        Exit;
    FScrollTimer := SetTimer(Handle, ScrollLeftTimerId + Ord(Direction) - 1,
      ScrollTimeStep div 2, nil);
  end;

  function CheckInsertStatus: Boolean;
  var
    I: Integer;
    CurNode: TdxMasterViewNode;
    R: TRect;
  begin
    Result := False;
    if not Level.Horizontal then Exit;
    for I := TopIndex to TopIndex + PartVisibleItemCount - 1 do
    begin
      CurNode := AbsoluteItems[I];
      if CurNode.Level = Level then
      begin
        R := CurNode.HeaderBounds;
        if IsRectEmpty(R) or PtInRect(R, P) then Continue;
        InflateRect(R, 0, InsertZoneWidth);
        if PtInRect(R, P) then
        begin
          Accept := True;
          ANode := CurNode;
          R.Bottom := R.Top + InsertZoneWidth;
          if PtInRect(R, P) then
            ARowIndex := 0
          else
            ARowIndex := Level.Layout.Count;
          AColIndex := 0;
          AInsert := True;
          Result := True;
          Break;
        end;
      end;
    end;
  end;

  procedure HideDragImages;
  begin
    ANode := ActiveNode;
    ARowIndex := ActiveRowIndex;
    AColIndex := ActiveColIndex;
    AForceMove := ActiveForceMove;
    AInsert := ActiveInsert;
    DrawDraggingColumn(Point(MaxInt, 0));
    SetActivePlace(nil, -1, -1, False, False);
  end;

begin
  if Column = nil then Exit;

  Level := Column.Level;

  if DragSource = dsCustomizingForm then
    GetCursorPos(P)
  else
  begin
    P := InitialP;
    Windows.ClientToScreen(Handle, P);
  end;  

  Accept := Column.CanMoving;
  if Assigned(FOnBeforeColumnMoving) then
  begin
    Windows.ScreenToClient(Handle, P);
    FOnBeforeColumnMoving(Self, Column, P, -1, -1, False, Accept);
    Windows.ClientToScreen(Handle, P);
  end;
  if not Accept then Exit;

  FMovingColumnNode := Node;
  FMovingColumn := Column;
  Include(FState, mvsColumnMoving);

  if Customizing then
    TdxMVCustomizationForm(FCustomizationForm).ActiveLevel := Column.Level;

  if DragSource = dsCustomizingForm then
  begin
    with Column do
    begin
      W := Width;
      H := GetHeaderHeight;//Level.HeaderRealHeight;
    end;
    Offset := Point(W div 2, H div 2);
  end
  else
  begin
    if DragSource = dsHeader then
      R := Column.GetHeaderBounds(Node)
    else
      R := Column.GetGroupByBoxBounds(Node);
    MapWindowPoints(Handle, 0, R, 2);
    with Offset, R do
    begin
      X := P.X - Left;
      Y := P.Y - Top;
      W := Right - Left;
      H := Bottom - Top;
    end;
  end;

  DC := GetDC(0);

  SaveDC := CreateCompatibleDC(DC);
  SaveB := CreateCompatibleBitmap(DC, W, H);
  SaveB := SelectObject(SaveDC, SaveB);

  BDC := CreateCompatibleDC(DC);
  B := CreateCompatibleBitmap(DC, W, H);
  B := SelectObject(BDC, B);

  SaveArrowsDC := CreateCompatibleDC(DC);
  SaveArrowsB := CreateCompatibleBitmap(DC, ArrowWidth, 2 * ArrowWidth);
  SaveArrowsB := SelectObject(SaveArrowsDC, SaveArrowsB);

  ArrowsBrush := CreateSolidBrush(ColorToRGB(FArrowsColor));

  BeforePaint;
  Level.BeforePaint;
  R := Rect(0, 0, W, H);
  DrawEdge(BDC, R, BDR_RAISEDINNER, BF_RECT);
  InflateRect(R, -1, -1);
  Column.DrawHeader(BDC, R, Node);
  Level.AfterPaint;
  AfterPaint;

  PrepareAlphaBlend;

  PrevP.X := MaxInt;
  DrawDraggingColumn(P);

  Success := False;
  ActiveNode := nil;
  ActiveRowIndex := -1;
  ActiveColIndex := -1;
  ActiveForceMove := False;
  ActiveInsert := False;
  CaptureWnd := Handle;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if Msg.wParam = VK_ESCAPE then Break;
          WM_RBUTTONDOWN, WM_MBUTTONDOWN:
            Break;
          WM_MOUSEMOVE:
            begin
              P := SmallPointToPoint(TSmallPoint(Msg.lParam));
              Windows.ClientToScreen(Msg.hwnd, P);
              if (P.X <> PrevP.X) or (P.Y <> PrevP.Y) then
              begin
                Windows.ScreenToClient(Handle, P);
                HitTestCode := GetHitTestInfo(P, ANode, AColumn, ARowIndex, AColIndex);
                AForceMove := False;
                AInsert := False;

                if PtInRect(ClientRect, P) and (HitTestCode <> htCustomizationForm) then
                  if CanScroll(dirLeft) and (P.X < ColumnMovingHScrollZone) then
                    CreateScrollTimer(dirLeft)
                  else
                    if CanScroll(dirRight) and (P.X >= ClientWidth - ColumnMovingHScrollZone) then
                      CreateScrollTimer(dirRight)
                    else
                      DestroyScrollTimer
                else
                  DestroyScrollTimer;

                Accept :=
                  (ANode <> nil) and (ANode.Level = Level) and not CheckInsertStatus and
                  ((HitTestCode = htGroupByBox) and FMovingColumn.CanGrouping(AColIndex) or
                   ANode.HasHeader(TopIndex, R.Left) and
                   ((HitTestCode in HeaderHitTests) or
                    (HitTestCode = htRightSpace) and (ARowIndex <> -1) or
                    not Level.Horizontal and (HitTestCode in LeftHitTests + ContentHitTests) and
                      ((HitTestCode <> htExpandButton) or (ARowIndex <> -1))));
                if Accept then
                  if HitTestCode = htGroupByBox then
                    //
                  else
                    if HitTestCode = htRightSpace then
                      if not Level.Horizontal then
                        AInsert := True
                      else
                    else
                      if not Level.Horizontal and
                        (HitTestCode in [htHeaderLeftEdge] + LeftHitTests + ContentHitTests) then
                      begin
                        if HitTestCode <> htHeaderLeftEdge then
                          Inc(AColIndex);
                        ARowIndex := 0;
                        AInsert := True;
                      end
                      else
                        if AColumn = nil then
                          if Level.Horizontal then
                          begin
                            AColIndex :=
                              Level.Layout.GetNearestCol(ARowIndex, P.X - ANode.HeaderBounds.Left);
                            AForceMove := FMovingColumn.Visible and
                              (ARowIndex = FMovingColumn.RowIndex) {and (AColIndex = 0)};
                          end
                          else
                            ARowIndex := Level.Layout[AColIndex].Count
                        else
                        begin
                          R := AColumn.GetHeaderBounds(ANode);
                          if Level.Horizontal then
                            AColIndex := Level.Layout[ARowIndex].IndexOf(AColumn) +
                              Byte(P.X >= (R.Left + R.Right) div 2)
                          else
                            ARowIndex := AColumn.RowIndex +
                              Byte(P.Y >= (R.Top + R.Bottom) div 2) * AColumn.RowCount;
                        end
                else
                begin
                  ANode := nil;
                  ARowIndex := -1;
                  AColIndex := -1;
                  if HitTestCode <> htCustomizationForm then
                    CheckInsertStatus;
                end;

                if Assigned(FOnColumnMoving) then
                begin
                  FOnColumnMoving(Self, FMovingColumn, P, ARowIndex, AColIndex, AInsert, Accept);
                  if not Accept then
                  begin
                    ARowIndex := -1;
                    AColIndex := -1;
                  end;
                end;

                SetActivePlace(ANode, ARowIndex, AColIndex, AForceMove, AInsert);
                if Accept or
                  (HitTestCode = htCustomizationForm) and (DragSource = dsCustomizingForm) then
                  SetCursor(Screen.Cursors[crDefault])
                else
                  SetCursor(Screen.Cursors[Cursors[
                    (DragSource <> dsGroupByBox) and FMovingColumn.CanHiding or
                    (DragSource = dsGroupByBox) and FMovingColumn.CanGrouping(AColIndex)]]);

                Windows.ClientToScreen(Handle, P);

                DrawDraggingColumn(P);
              end;
            end;
          WM_LBUTTONUP:
            begin
              Success := True;
              Break;
            end;
          WM_TIMER:
            if (Msg.hwnd = Handle) and
              (Msg.wParam in [ScrollLeftTimerId, ScrollRightTimerId]) and
              CanScroll(TdxMasterViewDirection(FScrollTimer - ScrollLeftTimerId + 1)) then
            begin
              HideDragImages;
              if Msg.wParam = ScrollLeftTimerId then
                Scroll(dirLeft)
              else
                Scroll(dirRight);
              GetCursorPos(P);
              Windows.ScreenToClient(Handle, P);
              PostMessage(Handle, WM_MOUSEMOVE, 0, LPARAM(PointToSmallPoint(P)));
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = CaptureWnd then ReleaseCapture;
    DestroyScrollTimer;
    HideDragImages;

    UnprepareAlphaBlend;

    DeleteObject(ArrowsBrush);

    DeleteObject(SelectObject(SaveArrowsDC, SaveArrowsB));
    DeleteDC(SaveArrowsDC);

    DeleteObject(SelectObject(BDC, B));
    DeleteDC(BDC);

    DeleteObject(SelectObject(SaveDC, SaveB));
    DeleteDC(SaveDC);

    ReleaseDC(0, DC);

    if Success then
    begin
      Accept := True;
      if Assigned(FOnAfterColumnMoving) then
      begin
        GetCursorPos(P);
        Windows.ScreenToClient(Handle, P);
        FOnAfterColumnMoving(Self, FMovingColumn, P, ARowIndex, AColIndex, AInsert, Accept);
      end;

      if Accept then
      begin
        with FMovingColumn do
          if ARowIndex = -1 then
            if AColIndex = -1 then
              if DragSource = dsGroupByBox then
                if CanGrouping(-1) then
                begin
                  GroupIndex := -1;
                  if not Visible and Hidden then Visible := True;
                end
                else
              else
                if CanHiding then Visible := False
                else
            else
              if CanGrouping(AColIndex) then
              begin
                if (GroupIndex <> -1) and (AColIndex > GroupIndex) then
                  Dec(AColIndex);
                if GroupIndex <> AColIndex then
                begin
                  GroupIndex := AColIndex;
                  {if (DragSource = dsHeader) and
                    (locHideColumnOnGrouping in Level.OptionsCustomize) then
                    Visible := False;}
                end;
              end
              else
          else
          begin
            Level.BeginLayout;
            try
              if Level.Horizontal then
              begin
                Success := Visible and
                  (RowIndex <= ARowIndex) and (ARowIndex <= RowIndex + RowCount - 1) and
                  (ColIndex < AColIndex);
                if AInsert and (ARowIndex = 0) then
                  Level.Layout.Insert(0, RowCount);
                RowIndex := ARowIndex;
                if (ColIndex <> AColIndex - Byte(Success)) or AForceMove then
                  ColIndex := AColIndex - Byte(Success);
              end
              else
              begin
                Success := Visible and
                  (ColIndex = AColIndex) and (RowIndex < ARowIndex);
                if AInsert then Level.Layout.Insert(AColIndex, 1);
                ColIndex := AColIndex;
                RowIndex := ARowIndex - Byte(Success) * RowCount;
              end;
              if (DragSource = dsGroupByBox) and CanGrouping(-1) then
                GroupIndex := -1;
              Visible := True;
            finally
              Level.EndLayout;
            end;
          end;
        Modified;
      end;
    end;

    Exclude(FState, mvsColumnMoving);
    FMovingColumn := nil;
    FMovingColumnNode := nil;
  end;
end;

procedure TdxMasterView.DoColumnHorSizing(Column: TdxMasterViewColumn; ContentSizing: Boolean);
var
  P, PrevP: TPoint;
  PrevWidths, PrevHeaderWidths: PIntArray;
  I, Offset, Delta, PrevLeftPos, AWidth: Integer;
  Success: Boolean;
  CaptureWnd: HWND;
  Msg: TMsg;
begin
  if Column = nil then Exit;
  FSizingColumn := Column;
  Include(FState, mvsColumnSizing);

  with Column.Level do
  begin
    if ContentSizing or AutoColumnWidth then
    begin
      I := VisibleColumnCount;
      GetMem(PrevWidths, I * SizeOf(Integer));
      for I := 0 to I - 1 do
        with VisibleColumns[I] do
          if cvWidth in AssignedValues then
            PrevWidths[I] := Width
          else
            PrevWidths[I] := -1;
    end
    else
      PrevWidths := nil;
    if not ContentSizing then
    begin
      I := Layout.Count;
      GetMem(PrevHeaderWidths, I * SizeOf(Integer));
      for I := 0 to I - 1 do
        with Layout do
          if HeaderWidthAssigned[I] then
            PrevHeaderWidths[I] := HeaderWidths[I]
          else
            PrevHeaderWidths[I] := -1;
    end
    else
      PrevHeaderWidths := nil;
  end;
  GetCursorPos(PrevP);
  P := Point(Column.Offset, 0);
  Windows.ClientToScreen(Handle, P);
  Offset := P.X;
  if not Column.Level.Horizontal and ContentSizing then
    Inc(Offset, Column.Level.Layout.HeaderWidths[Column.ColIndex]);
  if ContentSizing then
    Delta := Column.VisibleWidth
  else
    Delta := Column.Level.Layout.HeaderWidths[Column.ColIndex];
  Dec(Delta, PrevP.X - Offset);
  PrevLeftPos := LeftPos;

  Success := False;
  CaptureWnd := Handle;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      if LeftPos <> PrevLeftPos then
      begin
        PrevP.X := MaxInt;
        Dec(Offset, LeftPos - PrevLeftPos);
        PrevLeftPos := LeftPos;
      end;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if Msg.wParam = VK_ESCAPE then Break;
          WM_RBUTTONDOWN, WM_MBUTTONDOWN:
            Break;
          WM_MOUSEMOVE:
            begin
              P := SmallPointToPoint(TSmallPoint(Msg.lParam));
              Windows.ClientToScreen(Msg.hwnd, P);
              if P.X <> PrevP.X then
              begin
                AWidth := P.X - Offset + Delta;
                if ContentSizing then
                  Column.VisibleWidth := AWidth
                else
                  Column.Level.Layout.ChangeHeaderWidth(Column.ColIndex, AWidth, True);
                UpdateWindow(Handle);
                PrevP := P;
              end;
            end;
          WM_LBUTTONUP:
            begin
              Success := True;
              Break;
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = CaptureWnd then ReleaseCapture;
    try
      if Success then
        Modified
      else
        with Column.Level do
        begin
          BeginAssignWidths;
          try
            if PrevWidths <> nil then
              for I := 0 to VisibleColumnCount - 1 do
                with VisibleColumns[I] do
                  if PrevWidths[I] = -1 then
                    AssignedValues := AssignedValues - [cvWidth]
                  else
                    Width := PrevWidths[I];
            if PrevHeaderWidths <> nil then
              for I := 0 to Layout.Count - 1 do
                if PrevHeaderWidths[I] = -1 then
                  Layout.HeaderWidthAssigned[I] := False
                else
                  Layout.HeaderWidths[I] := PrevHeaderWidths[I];
          finally
            EndAssignWidths;
          end;
        end;
    finally
      if PrevWidths <> nil then FreeMem(PrevWidths);
      if PrevHeaderWidths <> nil then FreeMem(PrevHeaderWidths);

      Exclude(FState, mvsColumnSizing);
      FSizingColumn := nil;
    end;
  end;
end;

procedure TdxMasterView.DoColumnVerSizing(Node: TdxMasterViewNode;
  Column: TdxMasterViewColumn; Edge: TdxMasterViewHitTestCode);
var
  Level: TdxMasterViewLevel;
  ColumnsPlaces: TList;
  P, PrevP: TPoint;
  Delta, PrevNodeBoundsTop, ARowIndex, ARowCount, AColIndex: Integer;
  Success: Boolean;
  CaptureWnd: HWND;
  Msg: TMsg;
  ANode: TdxMasterViewNode;
  AColumn: TdxMasterViewColumn;
begin
  if Column = nil then Exit;
  Level := Column.Level;
  FSizingColumn := Column;
  Include(FState, mvsColumnSizing);

  Level.SaveVisibleColumnsPlaces(ColumnsPlaces);

  GetCursorPos(PrevP);
  Windows.ScreenToClient(Handle, PrevP);
  Delta := 0;
  PrevNodeBoundsTop := Node.Bounds.Top;

  Success := False;
  CaptureWnd := Handle;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      Inc(Delta, Node.Bounds.Top - PrevNodeBoundsTop);
      PrevNodeBoundsTop := Node.Bounds.Top;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if Msg.wParam = VK_ESCAPE then Break;
          WM_RBUTTONDOWN, WM_MBUTTONDOWN:
            Break;
          WM_MOUSEMOVE:
            begin
              P := SmallPointToPoint(TSmallPoint(Msg.lParam));
              MapWindowPoints(Msg.hwnd, Handle, P, 1);
              if P.Y <> PrevP.Y then
              begin
                if Node.ViewInfo.HeaderSize = 0 then
                begin
                  GetHitTestInfo(P, ANode, AColumn, ARowIndex, AColIndex);
                  if (ANode <> nil) and (ANode.Level = Level) and
                    (ANode.ViewInfo.HeaderSize <> 0) then
                    Node := ANode
                  else
                  begin
                    Success := True;
                    Break;
                  end;
                end;

                ARowIndex := Node.InternalHeaderRowIndexFromY(P.Y + Delta);
                with Column do
                begin
                  if Edge = htHeaderTopEdge then
                    if ARowIndex = -1 then
                    begin
                      ARowIndex := RowIndex + RowCount - MaxRowCount;
                      if ARowIndex < 0 then ARowIndex := 0;
                      ARowCount := RowIndex + RowCount - ARowIndex;
                    end
                    else
                    begin
                      if ARowIndex < RowIndex + RowCount - MaxRowCount then
                        ARowIndex := RowIndex + RowCount - MaxRowCount
                      else
                        if ARowIndex > RowIndex + RowCount - MinRowCount then
                          ARowIndex := RowIndex + RowCount - MinRowCount;
                      ARowCount := RowIndex + RowCount - ARowIndex;
                    end
                  else
                  begin
                    if ARowIndex = -1 then
                      ARowCount := MinRowCount
                    else
                      ARowCount := ARowIndex - RowIndex + 1;
                    ARowIndex := RowIndex;
                  end;
                  CheckRowCount(ARowCount);
                end;

                if Column.RowIndex <> ARowIndex then
                  Level.Layout.ChangeRowAndRowCount(Column, ARowIndex, ARowCount, True)
                else
                  Column.RowCount := ARowCount;

                PrevP := P;
              end;
            end;
          WM_LBUTTONUP:
            begin
              Success := True;
              Break;
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = CaptureWnd then ReleaseCapture;

    if Success then
    begin
      Level.FreeVisibleColumnsPlaces(ColumnsPlaces);
      Modified;
    end
    else
      Level.RestoreVisibleColumnsPlaces(ColumnsPlaces);

    Exclude(FState, mvsColumnSizing);
    FSizingColumn := nil;
  end;
end;

procedure TdxMasterView.DoNodeDeleted(Node: TdxMasterViewNode);
var
  NewNode: TdxMasterViewNode;
begin
  if FSelectionAnchor = Node then FSelectionAnchor := nil;
  if FFocusedNode = Node then FocusedNode := nil;
  if FTopNode = Node then
  begin
    NewNode := GetNextNode(Node, False);
    if NewNode = nil then NewNode := GetPrevNode(Node, False);
  end
  else
    NewNode := nil;
  Node.Selected := False;
  FAbsoluteItems.Remove(Node);
  if FTopNode = Node then TopNode := NewNode;
end;

procedure TdxMasterView.DoScrolling;
const
  ScrollTimeStep = 20;
  ScrollValueStep = 5;
  MaxSpeed = 12;
var
  BreakOnMouseUp: Boolean;
  AllowHorScrolling, AllowVerScrolling: Boolean;
  P, PrevP: TPoint;
  AnchorPos: TPoint;
  AnchorSize: Integer;
  AnchorWnd: HWND;
  Direction: TdxMasterViewDirection;
  Speed: Integer;
  TimerHits: Integer;
  Timer: UINT;
  CaptureWnd: HWND;
  Msg: TMsg;

  function CreateScrollingAnchorWnd: HWND;
  var
    B: TBitmap;
    W, H: Integer;
    Rgn: HRGN;
    DC: HDC;

    function GetResourceBitmapName: string;
    begin
      if AllowHorScrolling and AllowVerScrolling then
        Result := 'DXMASTERVIEWFULLSCROLLBITMAP'
      else
        if AllowHorScrolling then
          Result := 'DXMASTERVIEWHORSCROLLBITMAP'
        else
          Result := 'DXMASTERVIEWVERSCROLLBITMAP';
    end;

  begin
    B := TBitmap.Create;
    B.LoadFromResourceName(HInstance, GetResourceBitmapName);

    W := B.Width;
    H := B.Height;
    AnchorSize := W;
    with AnchorPos do
      Result := CreateWindow('STATIC', nil, WS_POPUP,
        X - W div 2, Y - H div 2, W, H, Handle, 0, HInstance, nil);
    Rgn := CreateEllipticRgn(0, 0, W + 1, H + 1);
    SetWindowRgn(Result, Rgn, True);
    SetWindowPos(Result, 0, 0, 0, 0, 0,
      SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);

    DC := GetWindowDC(Result);
    BitBlt(DC, 0, 0, W, H, B.Canvas.Handle, 0, 0, SRCCOPY);
    Rgn := CreateEllipticRgn(0, 0, W + 1, H + 1);
    FrameRgn(DC, Rgn, GetSysColorBrush(COLOR_WINDOWTEXT), 1, 1);
    DeleteObject(Rgn);
    ReleaseDC(Result, DC);

    B.Free;
  end;

  procedure CalcDirectionAndSpeed(const P: TPoint);
  var
    DeltaX, DeltaY, SpeedValue: Integer;

    function GetNeutralZone: TRect;
    begin
      with AnchorPos do
        Result := Bounds(X - AnchorSize div 2, Y - AnchorSize div 2, AnchorSize, AnchorSize);
      if not AllowHorScrolling then
      begin
        Result.Left := 0;
        Result.Right := Screen.Width;
      end;
      if not AllowVerScrolling then
      begin
        Result.Top := 0;
        Result.Bottom := Screen.Height;
      end;
    end;

  begin
    if PtInRect(GetNeutralZone, P) then
    begin
      Direction := dirNone;
      Speed := 0;
      Exit;
    end
    else
    begin
      BreakOnMouseUp := True;
      DeltaX := P.X - AnchorPos.X;
      DeltaY := P.Y - AnchorPos.Y;
      if AllowHorScrolling and (not AllowVerScrolling or (Abs(DeltaX) > Abs(DeltaY))) then
      begin
        if DeltaX < 0 then Direction := dirLeft
        else Direction := dirRight;
        SpeedValue := Abs(DeltaX);
      end
      else
      begin
        if DeltaY < 0 then Direction := dirUp
        else Direction := dirDown;
        SpeedValue := Abs(DeltaY);
      end;
    end;
    Dec(SpeedValue, AnchorSize div 2);
    Speed := 1 + SpeedValue div ScrollValueStep;
    if Speed > MaxSpeed then Speed := MaxSpeed;
  end;

  procedure SetMouseCursor;
  var
    Cursor: TCursor;
  begin
    case Direction of
      dirLeft:
        Cursor := crdxMasterViewLeftScroll;
      dirUp:
        Cursor := crdxMasterViewUpScroll;
      dirRight:
        Cursor := crdxMasterViewRightScroll;
      dirDown:
        Cursor := crdxMasterViewDownScroll;
    else
      if AllowHorScrolling and AllowVerScrolling then
        Cursor := crdxMasterViewFullScroll
      else
        if AllowHorScrolling then
          Cursor := crdxMasterViewHorScroll
        else
          Cursor := crdxMasterViewVerScroll;
    end;
    SetCursor(Screen.Cursors[Cursor]);
  end;

begin
  Include(FState, mvsScrolling);
  
  BreakOnMouseUp := False;
  AllowHorScrolling := GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0;
  AllowVerScrolling := GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0;
  GetCursorPos(PrevP);
  AnchorPos := PrevP;
  AnchorWnd := CreateScrollingAnchorWnd;
  Direction := dirNone;
  SetMouseCursor;
  Speed := 1;
  TimerHits := 0;
  Timer := SetTimer(0, 0, ScrollTimeStep, nil);

  CaptureWnd := Handle;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      if (Msg.message = WM_PAINT) and (Msg.hwnd = AnchorWnd) then
      begin
        ValidateRect(AnchorWnd, nil);
        Continue;
      end;
      if (Msg.message >= WM_MOUSEFIRST) and (Msg.message <= WM_MOUSELAST) and
        (Msg.message <> WM_MOUSEMOVE) and (Msg.message <> WM_MBUTTONUP) then
        Break;
      try
        case Msg.message of
          WM_KEYDOWN, WM_KEYUP:
            if Msg.wParam = VK_ESCAPE then Break;
          WM_MOUSEMOVE:
            begin
              P := SmallPointToPoint(TSmallPoint(Msg.lParam));
              Windows.ClientToScreen(Msg.hwnd, P);
              if (P.X <> PrevP.X) or (P.Y <> PrevP.Y) then
              begin
                CalcDirectionAndSpeed(P);
                SetMouseCursor;
                PrevP := P;
              end;
            end;
          WM_MBUTTONUP:
            if BreakOnMouseUp then Break;
          WM_TIMER:
            if UINT(Msg.wParam) = Timer then
            begin
              Inc(TimerHits);
              if TimerHits mod (MaxSpeed - Speed + 1) = 0 then Scroll(Direction);
            end;
        end;
      finally
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = CaptureWnd then ReleaseCapture;

    KillTimer(0, Timer);
    DestroyWindow(AnchorWnd);

    Exclude(FState, mvsScrolling);
  end;
end;

procedure TdxMasterView.DoSelectionChanged;
begin
  if (FSelectionLockCount <> 0) or not MultiSelect or IsDestroying then Exit;
  if Assigned(FOnSelectionChanged) then FOnSelectionChanged(Self);
end;

function TdxMasterView.DoSelectNode(Node: TdxMasterViewNode): Boolean;
begin
  Result := True;
  if Assigned(FOnSelectNode) then FOnSelectNode(Self, Node, Result);
end;

procedure TdxMasterView.DoSorting;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to AbsoluteLevelCount - 1 do AbsoluteLevels[I].DoSorting;
  finally
    EndUpdate;
  end;
end;

procedure TdxMasterView.DoTopNodeChanged;
begin
  if FTopNodeChangeLockCount <> 0 then Exit;
  Invalidate;
  if Assigned(FOnTopNodeChanged) then FOnTopNodeChanged(Self);
end;

procedure TdxMasterView.HighlightStyleChanged(Values: TdxMasterViewStyleValues);
begin
  if HasFocus then InvalidateSelection;
end;

procedure TdxMasterView.InactiveStyleChanged(Values: TdxMasterViewStyleValues);
begin
  if not HasFocus then InvalidateSelection;
end;

function TdxMasterView.CanFocusNode(Node: TdxMasterViewNode): Boolean;
begin
  Result := True;
  if Assigned(FOnBeforeFocusNode) then FOnBeforeFocusNode(Self, Node, Result);
end;

procedure TdxMasterView.ChangeFocusedIndex(Value: Integer);
var
  NewFocusedNode: TdxMasterViewNode;
  ATopIndex, AVisibleItemCount, APartVisibleItemCount, Delta, PrevDelta: Integer;
begin
  if Value < 0 then Value := 0;
  if Value >= AbsoluteItemCount then Value := AbsoluteItemCount - 1;

  if Value = -1 then
    NewFocusedNode := nil
  else
    NewFocusedNode := AbsoluteItems[Value];
  if not CanFocusNode(NewFocusedNode) then Exit; 
  //try
    if NewFocusedNode <> nil then NewFocusedNode.SyncPos;
  //finally
    if FFocusedNode <> nil then FFocusedNode.Invalidate(nil, vpContent);
    FocusedNode := NewFocusedNode;
    if Value < TopIndex then TopIndex := Value
    else
      if Value >= TopIndex + VisibleItemCount then
      begin
        ATopIndex := Value - FLastVisibleItemCount + 1;
        Delta := 0;
        repeat
          CalcViewInfo(ATopIndex, -1, AVisibleItemCount, APartVisibleItemCount, False);
          PrevDelta := Delta;
          if Value > ATopIndex + AVisibleItemCount - 1 then
            Delta := 1
          else
            Delta := -1;
          if (PrevDelta <> 0) and (Delta <> PrevDelta) then
          begin
            if Delta = 1 then Inc(ATopIndex);
            Break;
          end;
          Inc(ATopIndex, Delta);
        until False;
        TopIndex := ATopIndex;
      end;
    if FFocusedNode <> nil then
      FFocusedNode.Invalidate(nil, vpContent);
  //end;
end;

function TdxMasterView.GetFirstNodeFromVisible(Level: TdxMasterViewLevel): TdxMasterViewNode;
var
  I: Integer;
begin
  for I := TopIndex to AbsoluteItemCount - 1 do
  begin
    Result := AbsoluteItems[I];
    if ((Level = nil) or (Result.Level = Level)) and
      CanFocusNode(Result) then Exit;
  end;
  for I := TopIndex - 1 downto 0 do
  begin
    Result := AbsoluteItems[I];
    if ((Level = nil) or (Result.Level = Level)) and
      CanFocusNode(Result) then Exit;
  end;
  Result := nil;
end;

function TdxMasterView.GetLastNodeFromVisible(Level: TdxMasterViewLevel): TdxMasterViewNode;
var
  I, Margin: Integer;
begin
  Result := nil;
  Margin := TopIndex + VisibleItemCount - 1;
  for I := TopIndex to AbsoluteItemCount - 1 do
  begin
    if (I > Margin) and (Result <> nil) then Exit;
    if ((Level = nil) or (AbsoluteItems[I].Level = Level)) and
      CanFocusNode(AbsoluteItems[I]) then
      Result := AbsoluteItems[I];
  end;
end;

function TdxMasterView.GetNextNode(Value: TdxMasterViewNode; OnSameLevel: Boolean): TdxMasterViewNode;
var
  I: Integer;
begin
  if (Value <> nil) and (Value.AbsoluteIndex = AbsoluteItemCount - 1) or
    (Value = nil) and OnSameLevel then
    Result := nil
  else
    if OnSameLevel then
    begin
      for I := Value.AbsoluteIndex + 1 to AbsoluteItemCount - 1 do
      begin
        Result := AbsoluteItems[I];
        if (Result.Level = Value.Level) and CanFocusNode(Result) then Exit;
      end;
      Result := nil;
    end
    else
    begin
      if Value = nil then
        I := 0
      else
        I := Value.AbsoluteIndex + 1;
      for I := I to AbsoluteItemCount - 1 do
      begin
        Result := AbsoluteItems[I];
        if (Result <> nil) and CanFocusNode(Result) then Exit;
      end;
      Result := nil;
    end;
end;

function TdxMasterView.GetPrevNode(Value: TdxMasterViewNode; OnSameLevel: Boolean): TdxMasterViewNode;
var
  I: Integer;
begin
  if (Value <> nil) and (Value.AbsoluteIndex = 0) or
    (Value = nil) and OnSameLevel then
    Result := nil
  else
    if OnSameLevel then
    begin
      for I := Value.AbsoluteIndex - 1 downto 0 do
      begin
        Result := AbsoluteItems[I];
        if (Result.Level = Value.Level) and CanFocusNode(Result) then Exit;
      end;
      Result := nil;
    end
    else
    begin
      if Value = nil then
        I := AbsoluteItemCount - 1
      else
        I := Value.AbsoluteIndex - 1;
      for I := I downto 0 do
      begin
        Result := AbsoluteItems[I];
        if (Result <> nil) and CanFocusNode(Result) then Exit;
      end;
      Result := nil;
    end;
end;

procedure TdxMasterView.ShowPrevPage(CurTopIndex: Integer; OnSameLevel: Boolean);
var
  ATopIndex, LastVisibleIndex, AVisibleItemCount, APartVisibleItemCount: Integer;
  NodeVisible, PrevNodeVisible: Boolean;
  FirstVisibleNode, PrevFirstVisibleNode: TdxMasterViewNode;

  function IsNodeVisible: Boolean;
  var
    I: Integer;
  begin
    PrevFirstVisibleNode := FirstVisibleNode;
    Result := True;
    for I := ATopIndex to ATopIndex + AVisibleItemCount - 1 do
    begin
      FirstVisibleNode := AbsoluteItems[I];
      if FirstVisibleNode.Level = FFocusedNode.Level then Exit;
    end;
    FirstVisibleNode := nil;
    Result := False;
  end;

begin
  if CurTopIndex = 0 then Exit;
  if OnSameLevel then
  begin
    ATopIndex := TopIndex;
    AVisibleItemCount := VisibleItemCount;
    PrevNodeVisible := IsNodeVisible;
    if PrevNodeVisible then LastVisibleIndex := TopIndex
    else
    begin
      LastVisibleIndex := FocusedIndex;
      FirstVisibleNode := FFocusedNode;
    end;
    ATopIndex := CurTopIndex - 1;
    repeat
      CalcViewInfo(ATopIndex, -1, AVisibleItemCount, APartVisibleItemCount, False);
      NodeVisible := IsNodeVisible;
      if NodeVisible then
      begin
        if FirstVisibleNode <> PrevFirstVisibleNode then
          LastVisibleIndex := ATopIndex;
        if (ATopIndex + AVisibleItemCount - 1 <= FocusedIndex) and
          (LastVisibleIndex <> TopIndex) then
        begin
          if (ATopIndex + AVisibleItemCount - 1 < FocusedIndex) and PrevNodeVisible then
            Inc(ATopIndex);
          Break;
        end;
      end;
      PrevNodeVisible := NodeVisible;
      Dec(ATopIndex);
      if ATopIndex = -1 then
      begin
        ATopIndex := LastVisibleIndex;
        Break;
      end;
    until False;
  end
  else
  begin
    ATopIndex := CurTopIndex - 1;
    repeat
      if ATopIndex = 0 then Break;
      CalcViewInfo(ATopIndex, -1, AVisibleItemCount, APartVisibleItemCount, False);
      if ATopIndex + AVisibleItemCount - 1 <= CurTopIndex then
      begin
        if ATopIndex + AVisibleItemCount - 1 < CurTopIndex then Inc(ATopIndex);
        Break;
      end;
      Dec(ATopIndex);
    until False;
    if ATopIndex = CurTopIndex then Dec(ATopIndex);
  end;
  TopIndex := ATopIndex;
end;

procedure TdxMasterView.ShowNextPage(CurBottomIndex: Integer; OnSameLevel: Boolean);
var
  ATopIndex, AVisibleItemCount, APartVisibleItemCount: Integer;
  LastVisibleNode, PrevLastVisibleNode: TdxMasterViewNode;

  function IsNodeVisible: Boolean;
  var
    I: Integer;
  begin
    PrevLastVisibleNode := LastVisibleNode;
    Result := True;
    for I := ATopIndex + AVisibleItemCount - 1 downto ATopIndex do
    begin
      LastVisibleNode := AbsoluteItems[I];
      if LastVisibleNode.Level = FFocusedNode.Level then Exit;
    end;
    LastVisibleNode := nil;
    Result := False;
  end;

begin
  if OnSameLevel then
  begin
    ATopIndex := TopIndex;
    AVisibleItemCount := VisibleItemCount;
    if not IsNodeVisible then LastVisibleNode := FFocusedNode;
    ATopIndex := CurBottomIndex;
    repeat
      CalcViewInfo(ATopIndex, -1, AVisibleItemCount, APartVisibleItemCount, False);
      if IsNodeVisible and (LastVisibleNode <> PrevLastVisibleNode) then Break;
      Inc(ATopIndex);
      if ATopIndex = AbsoluteItemCount then Exit;
    until False;
  end
  else
  begin
    ATopIndex := CurBottomIndex;
    if ATopIndex = TopIndex then Inc(ATopIndex);
  end;
  TopIndex := ATopIndex;
end;

procedure TdxMasterView.Scroll(Direction: TdxMasterViewDirection);
begin
  case Direction of
    dirLeft:
      LeftPos := LeftPos - HScrollDelta;
    dirRight:
      LeftPos := LeftPos + HScrollDelta;
    dirUp:
      TopIndex := TopIndex - 1;
    dirDown:
      TopIndex := TopIndex + 1;
  end;
end;

procedure TdxMasterView.RefreshAbsoluteItems;
var
  I: Integer;
  PrevVisibles: PBoolArray;
  NeedCalcScrollableWidth: Boolean;
begin
  if FUpdateLockCount = 0 then
  begin
    GetMem(PrevVisibles, AbsoluteLevelCount * SizeOf(Boolean));
    try
      for I := 0 to AbsoluteLevelCount - 1 do
        with AbsoluteLevels[I] do
        begin
          PrevVisibles[I] := Visible;
          FVisible := False;
        end;
      FAbsoluteItems.Clear;
      if FItems <> nil then FItems.AddVisibleToList(FAbsoluteItems);
      if AutoColumnWidth then
      begin
        NeedCalcScrollableWidth := False;
        for I := 0 to AbsoluteLevelCount - 1 do
          with AbsoluteLevels[I] do
            if Visible and not PrevVisibles[I] then
              WidthChanged
            else
              if not Visible and PrevVisibles[I] then
                NeedCalcScrollableWidth := True;
        if NeedCalcScrollableWidth then
          CalcScrollableWidth(nil);
      end
      else
        CalcScrollableWidth(nil);
    finally
      FreeMem(PrevVisibles, AbsoluteLevelCount * SizeOf(Boolean));
    end;
  end;
end;

procedure TdxMasterView.RefreshAbsoluteLevels;

  procedure AddLevel(Level: TdxMasterViewLevel);
  var
    I: Integer;
  begin
    if Level <> FLevels then
      Level.FAbsoluteIndex := FAbsoluteLevels.Add(Level);
    for I := 0 to Level.Count - 1 do AddLevel(Level[I]);
  end;

begin
  FAbsoluteLevels.Clear;
  AddLevel(FLevels);
end;

procedure TdxMasterView.SelectPeriod(ToNode: TdxMasterViewNode);
var
  M1, M2, I: Integer;
begin
  if MultiSelect and (FLastSelectedNode <> ToNode) then
  begin
    M1 := FLastSelectedNode.AbsoluteIndex;
    M2 := ToNode.AbsoluteIndex;
    if M1 > M2 then
    begin
      I := M1;
      M1 := M2;
      M2 := I;
    end;
    FLastSelectedNode := ToNode;
    for I := M1 to M2 do AbsoluteItems[I].Invalidate(nil, vpContent);
  end;
end;

procedure TdxMasterView.InvalidateSelection;
var
  I: Integer;
begin
  for I := 0 to SelectedItemCount - 1 do
    SelectedItems[I].Invalidate(nil, vpContent);
  if (FFocusedNode <> nil) and not FFocusedNode.Selected then
    FFocusedNode.Invalidate(nil, vpContent);
end;

procedure TdxMasterView.Modified;
begin
  if not (csLoading in ComponentState) and
    (GetParentForm(Self) <> nil) and (GetParentForm(Self).Designer <> nil) then
    GetParentForm(Self).Designer.Modified;
end;

procedure TdxMasterView.Freeze;
begin
  FFrozen := True;
end;

function TdxMasterView.FreezeDataSet(ALevel: TdxMasterViewLevel): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to AbsoluteLevelCount - 1 do
    with AbsoluteLevels[I] do
      if DataSet = ALevel.DataSet then
        Result := DataLink.Freeze;
end;

procedure TdxMasterView.Unfreeze;
begin
  FFrozen := False;
end;

procedure TdxMasterView.UnfreezeDataSet(ALevel: TdxMasterViewLevel);
var
  I: Integer;
begin
  for I := 0 to AbsoluteLevelCount - 1 do
    with AbsoluteLevels[I] do
      if DataSet = ALevel.DataSet then
        DataLink.Unfreeze;
end;

procedure TdxMasterView.Invalidate;
begin
  if HandleAllocated then InvalidateRect(Handle, nil, False);
end;

procedure TdxMasterView.DrawText(const DrawDC: HDC; var ARect: TRect;
  const Font: TFont; const Brush: HBRUSH; const TextColor, BkColor: TColor;
  const Alignment: TAlignment; const Text: string;
  const FillBackground, MakeRightSpace, AllowUseBitmap, MultiLine: Boolean);
const
  Alignments: array[TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
  EndEllipsis: array[Boolean] of Integer = (0, DT_END_ELLIPSIS);
  MultiLines: array[Boolean] of Integer = (DT_SINGLELINE or DT_VCENTER, DT_WORDBREAK);
  Opaques: array[Boolean] of Integer = (0, ETO_OPAQUE);
var
  R: TRect;
  CanUseBitmap: Boolean;
  DC: HDC;
  PrevFont: HFONT;
  Size: TSize;
  X, Y: Integer;
begin
  R := ARect;
  CanUseBitmap := (movUseBitmap in FOptionsView) and AllowUseBitmap;
  if CanUseBitmap then
  begin
    with R do
    begin
      OffsetRect(R, -Left, -Top);
      PrepareBitmap(Right, Bottom);
    end;
    DC := FBitmap.Canvas.Handle;
  end
  else
    DC := DrawDC;

  PrevFont := SelectObject(DC, Font.Handle);
  SetTextColor(DC, ColorToRGB(TextColor));
  GetTextExtentPoint{32}(DC, PChar(Text), Length(Text), Size);

  if (movDrawEndEllipsis in FOptionsView) or MultiLine then
  begin
    if FillBackground then FillRect(DC, R, Brush);
    Inc(R.Left, 2);
    if MakeRightSpace then
      Dec(R.Right, 2)
    else
      Dec(R.Right, SortOrderMarkZoneWidth);
    if MultiLine then InflateRect(R, 0, -2);
    SetBkMode(DC, TRANSPARENT);
    Windows.DrawText(DC, PChar(Text), Length(Text), R,
      MultiLines[MultiLine] or DT_NOPREFIX or Alignments[Alignment] or
      Byte(not MultiLine and not (fsItalic in Font.Style) and
        (Size.cx <= R.Right - R.Left)) * DT_NOCLIP or
      EndEllipsis[not MultiLine and (movDrawEndEllipsis in FOptionsView)]);
    SetBkMode(DC, OPAQUE);
  end
  else
  begin
    with R, Size do
    begin
      if not MakeRightSpace then
      begin
        Dec(Right, SortOrderMarkZoneWidth);
        if FillBackground then
          FillRect(DC, Rect(Right, Top, Right + SortOrderMarkZoneWidth, Bottom), Brush);
      end;
      case Alignment of
        taLeftJustify:
          X := Left + 2;
        taRightJustify:
          X := Right - Byte(MakeRightSpace) * 2 - cx;
      else
        X := (Left + Right + Byte(not MakeRightSpace) * 2 - cx) div 2;
      end;
      if Right - Left - (1 + Byte(MakeRightSpace)) * 2 < cx then
      begin
        X := Left + 2;
        if MakeRightSpace then
        begin
          Dec(Right, 2);
          if FillBackground then
            FillRect(DC, Rect(Right, Top, Right + 2, Bottom), Brush);
        end;
      end;
      Y := (Top + Bottom - cy) div 2;
    end;
    if FillBackground then
      SetBkColor(DC, ColorToRGB(BkColor))
    else
      SetBkMode(DC, TRANSPARENT);
    ExtTextOut(DC, X, Y, ETO_CLIPPED or Opaques[FillBackground],
      @R, PChar(Text), Length(Text), nil);
    if not FillBackground then SetBkMode(DC, OPAQUE);
  end;

  SelectObject(DC, PrevFont);

  if CanUseBitmap then
    with ARect do
      BitBlt(DrawDC, Left, Top, Right - Left, Bottom - Top, DC, 0, 0, SRCCOPY);
end;

function TdxMasterView.GetSelectionParams(Node: TdxMasterViewNode;
  ABrush: PBRUSH; ATextColor, ABkColor: PColor): Boolean;
begin
  Result :=
    Node.Selected and (HasFocus or not (movHideSelection in FOptionsView));
  if Result then
    if HasFocus then
    begin
      if ABrush <> nil then ABrush^ := HighlightBrush;
      if ATextColor <> nil then ATextColor^ := HighlightFontColor;
      if ABkColor <> nil then ABkColor^ := HighlightColor;
    end
    else
    begin
      if ABrush <> nil then ABrush^ := InactiveBrush;
      if ATextColor <> nil then ATextColor^ := InactiveFontColor;
      if ABkColor <> nil then ABkColor^ := InactiveColor;
    end;
end;

procedure TdxMasterView.PrepareBitmap(const AWidth, AHeight: Integer);
begin
  with FBitmap do
  begin
    if AWidth > Width then Width := AWidth;
    if AHeight > Height then Height := AHeight;
  end;
end;

procedure TdxMasterView.ApplyBestFit(Level: TdxMasterViewLevel; Column: TdxMasterViewColumn);
var
  I, J: Integer;
begin
  if Level = nil then
    if Column = nil then
      for I := 0 to AbsoluteLevelCount - 1 do
        for J := 0 to AbsoluteLevels[I].VisibleColumnCount - 1 do
          AbsoluteLevels[I].VisibleColumns[J].ApplyBestFit
    else
      Column.ApplyBestFit
  else
    for I := 0 to Level.VisibleColumnCount - 1 do
      Level.VisibleColumns[I].ApplyBestFit;
end;

procedure TdxMasterView.BeginLayout;
begin
  Inc(FLayoutLockCount);
  BeginUpdate;
end;

procedure TdxMasterView.BeginSelection;
begin
  Inc(FSelectionLockCount);
end;

procedure TdxMasterView.BeginUpdate;
begin
  Inc(FUpdateLockCount);
end;

procedure TdxMasterView.CancelLayout;
begin
  if FLayoutLockCount > 0 then
  begin
    Dec(FLayoutLockCount);
    CancelUpdate;
  end;
end;

procedure TdxMasterView.CancelUpdate;
begin
  if FUpdateLockCount > 0 then Dec(FUpdateLockCount);
  FDontInvalidate := False;
end;

procedure TdxMasterView.ClearSelection;
begin
  ClearSelectedItems;
end;

function TdxMasterView.CreateStyle(AStyleClass: TdxMasterViewStyleClass): TdxMasterViewStyle;
begin
  Result := AStyleClass.Create(Owner);
  AddStyle(Result);
end;

procedure TdxMasterView.DeleteSelection;
var
  PrevCursor: TCursor;
  List: TList;
  I, J: Integer;
  S: string;
begin
  if SelectedItemCount = 0 then Exit;
  if SelectedItemCount = 1 then
  begin
    if not SelectedItems[0].CanDelete then Exit;
    with SelectedItems[0].Level do
      if (lodConfirmDelete in OptionsDB) and
        (Application.MessageBox(
          PChar(Format(DeleteConfirmText, [Caption])),
          PChar(DeleteConfirmCaptionText),
          MB_ICONQUESTION or MB_OKCANCEL) = ID_CANCEL) then Exit;
    SelectedItems[0].Delete;
  end
  else
  begin
    BeginSelection;
    List := TList.Create;
    try
      for I := 0 to AbsoluteLevelCount - 1 do
        if AbsoluteLevels[I].CanDelete then
        begin
          List.Clear;
          for J := 0 to SelectedItemCount - 1 do
            with SelectedItems[J] do
              if (Level.AbsoluteIndex = I) and CanDelete then
                List.Add(SelectedItems[J]);
          if List.Count = 0 then Continue;

          with AbsoluteLevels[I] do
            if lodConfirmDelete in OptionsDB then
            begin
              if List.Count = 1 then
                S := DeleteConfirmText
              else
                S := MultipleDeleteConfirmText;
              case Application.MessageBox(
                PChar(Format(S, [Caption])),
                PChar(DeleteConfirmCaptionText),
                MB_ICONQUESTION or MB_YESNOCANCEL) of
                ID_CANCEL: Break;
                ID_NO: Continue;
              end;
            end;

          PrevCursor := Screen.Cursor;
          if ShowHourGlassCursor then Screen.Cursor := crHourGlass;
          BeginUpdate;
          AbsoluteLevels[I].BeginLoad;
          try
            for J := 0 to List.Count - 1 do
              TdxMasterViewNode(List[J]).Delete;
          finally
            try
              AbsoluteLevels[I].EndLoad(True);
            finally
              EndUpdate;
              if ShowHourGlassCursor then Screen.Cursor := PrevCursor;
            end;  
          end;
        end;
    finally
      List.Free;
      EndSelection;
    end;
  end;
end;

procedure TdxMasterView.EndLayout;
begin
  if FLayoutLockCount > 0 then
  begin
    Dec(FLayoutLockCount);
    try
      if FLayoutLockCount = 0 then UpdateData;
    finally
      EndUpdate;
    end;  
  end;
end;

procedure TdxMasterView.EndSelection;
begin
  if FSelectionLockCount > 0 then
  begin
    Dec(FSelectionLockCount);
    if FSelectionLockCount = 0 then
    begin
      DoSelectionChanged;
    end;
  end;
end;

procedure TdxMasterView.EndUpdate;
begin
  if FUpdateLockCount > 0 then
  begin
    Dec(FUpdateLockCount);
    if FUpdateLockCount = 0 then
    begin
      RefreshAbsoluteItems;
      TopIndex := CheckTopIndex(TopIndex);
      CheckFocusedNode;
      if not FDontInvalidate then Invalidate;
    end;
  end;
  FDontInvalidate := False;
end;

procedure TdxMasterView.FocusNode(Node: TdxMasterViewNode; ChangeSelection: Boolean);
begin
  ChangeSelection := ChangeSelection and MultiSelect and 
    ((FocusedNode = nil) or
     (SelectedItemCount = 1) and FocusedNode.Selected);
  if Node = nil then
    FocusedIndex := -1
  else
    FocusedIndex := Node.AbsoluteIndex;
  if ChangeSelection and (FFocusedNode <> nil) and (FFocusedNode = Node) then
  begin
    BeginSelection;
    try
      ClearSelection;
      FFocusedNode.Selected := True;
    finally
      EndSelection;
    end;
  end;
end;

procedure TdxMasterView.FullCollapse;
begin
  Items.Collapse(True);
end;

procedure TdxMasterView.FullExpand;
{var
  ft,lt:integer;}
begin
//  ft:=gettickcount;
  Items.Expand(True);
//  lt:=gettickcount;
//  application.messagebox(pchar(inttostr(lt-ft)),'',0);
end;

function TdxMasterView.GetHitTestInfo(const P: TPoint; var Node: TdxMasterViewNode;
  var Column: TdxMasterViewColumn; var RowIndex, ColIndex: Integer): TdxMasterViewHitTestCode;
var
  FromIndex, AVisibleItemCount, APartVisibleItemCount, I, J, K: Integer;
  R, R1, R2: TRect;
  List: TList;

  function ProcessHeader(const R: TRect; var HitTestCode: TdxMasterViewHitTestCode): Boolean;
  var
    K, J: Integer;
    R1: TRect;
    AColumn: TdxMasterViewColumn;
  begin
    Result := PtInRect(R, P);
    if Result then
    begin
      RowIndex := Node.HeaderRowIndexFromY(P.Y);
      ColIndex := Node.HeaderColIndexFromX(P.X);
      HitTestCode := htHeader;
      with Node.Level do
        for K := 0 to VisibleColumnCount - 1 do
        begin
          Column := VisibleColumns[K];
          R1 := Column.GetHeaderBounds(Node);
          if PtInRect(R1, P) then
          begin
            if P.X < R1.Left + ColumnSizingZoneWidth then
            begin
              if Horizontal then
              begin
                List := TList.Create;
                try
                  if Layout.HasLeftNeighbours(Column, List, True) then
                    for J := 0 to List.Count - 1 do
                      with TdxMasterViewColumn(List[J]) do
                        if CanHorSizing then
                          with GetHeaderBounds(Node) do
                            if (Top <= P.Y) and (P.Y < Bottom) then
                            begin
                              Column := List[J];
                              HitTestCode := htHeaderRightEdge;
                              Exit;
                            end;
                finally
                  List.Free;
                end;
              end
              else
                if (Column.ColIndex > 0) and
                  (RowIndex < Layout[Column.ColIndex - 1].Count) then
                begin
                  AColumn := Layout.Columns[RowIndex, Column.ColIndex - 1];
                  if AColumn.CanHorSizing and AColumn.IsWidthLinked then
                  begin
                    Column := AColumn;
                    Dec(ColIndex);
                    HitTestCode := htContentRightEdge;
                    Exit;
                  end;
                end;
              HitTestCode := htHeaderLeftEdge;
              Exit;
            end
            else
              if (P.X >= R1.Right - ColumnSizingZoneWidth) and
                (Column.Level.Horizontal and Column.CanHorSizing and
                  (not AutoColumnWidth or not Column.Level.Layout.OneOnLine(Column)) or
                 not Column.Level.Horizontal and Column.Level.CanHorSizing) then
              begin
                HitTestCode := htHeaderRightEdge;
                Exit;
              end;

            if P.Y < R1.Top + ColumnSizingZoneWidth then
              if FHorizontal then
                if Column.CanVerSizing and
                  ((Column.RowIndex <> 0) or (Column.RowCount <> Column.MinRowCount)) then
                  HitTestCode := htHeaderTopEdge
                else
                  Exit
              else
                if Column.RowIndex = 0 then
                  Exit
                else  
                begin
                  AColumn := Layout.Columns[Column.RowIndex - 1, Column.ColIndex];
                  if AColumn.CanVerSizing then
                  begin
                    Column := AColumn;
                    HitTestCode := htHeaderBottomEdge;
                  end;
                end
            else
              if (P.Y >= R1.Bottom - ColumnSizingZoneWidth) and
                Column.CanVerSizing then
                HitTestCode := htHeaderBottomEdge;
            Exit;
          end;
        end;
      Column := nil;
    end;
  end;

begin
  Column := nil;
  RowIndex := -1;
  ColIndex := -1;

  if Customizing and TdxMVCustomizationForm(FCustomizationForm).MouseInBounds(P) then
  begin
    Node := nil;
    Result := htCustomizationForm;
    Exit;
  end;

  if PtInRect(ClientRect, P) then
  begin
    FromIndex := TopIndex;
    if FromIndex <> -1 then
    begin
      CalcViewInfo(TopIndex, -1, AVisibleItemCount, APartVisibleItemCount, True);
      for I := FromIndex to FromIndex + APartVisibleItemCount - 1 do
      begin
        Node := AbsoluteItems[I];
        R := Node.FullBounds;
        if PtInRect(R, P) then
        begin
          // work with footer
          if Node.ViewInfo.FooterSize <> 0 then
            for J := 0 to Node.ViewInfo.EndLevelCount - 1 do
            begin
              R1 := Node.SubFooterBounds[J];
              if PtInRect(R1, P) then
              begin
                RowIndex := Node.FooterRowIndexFromY(J, P.Y);
                ColIndex := Node.FooterColIndexFromX(J, P.X);
                Result := htFooter;
                with Node.Level.Parents[J] do
                  for K := 0 to VisibleColumnCount - 1 do
                  begin
                    Column := VisibleColumns[K];
                    R1 := Column.GetFooterBounds(Node);
                    if PtInRect(R1, P) then Exit;
                  end;
                Column := nil;
                Exit;
              end
              else
              begin
                R2 := R1;
                R2.Right := R1.Left;
                R2.Left := R.Left;
                if PtInRect(R2, P) then
                begin
                  Result := htLeftSpace;
                  Exit;
                end
                else
                begin
                  R1.Left := R1.Right;
                  R1.Right := R.Right;
                  if PtInRect(R1, P) then
                  begin
                    Result := htRightSpace;
                    Exit;
                  end;
                end;
              end;
            end;
          // work with groupby box
          R1 := Node.GroupByBoxBounds;
          if PtInRect(R1, P) then
          begin
            Result := htGroupByBox;
            if mvsColumnMoving in FState then
            begin
              for J := 0 to Node.Level.GroupColumnCount - 1 do
              begin
                Column := Node.Level.GroupColumns[J];
                with Column.GetGroupByBoxBounds(Node) do
                  R1.Right := (Left + Right) div 2;
                if PtInRect(R1, P) then
                begin
                  ColIndex := J;
                  Exit;
                end;
                R1.Left := R1.Right;
              end;
              ColIndex := Node.Level.GroupColumnCount;
            end
            else
              for J := 0 to Node.Level.GroupColumnCount - 1 do
              begin
                Column := Node.Level.GroupColumns[J];
                R1 := Column.GetGroupByBoxBounds(Node);
                if PtInRect(R1, P) then
                begin
                  Result := htHeader;
                  Exit;
                end;
              end;
            Column := nil;
            Exit;
          end;
          // work with left space
          R1 := Node.LeftSpaceBounds;
          if PtInRect(R1, P) then
          begin
            if UseIndent and not PtInRect(Node.FullHeaderBounds, P) then
              Result := htIndent
            else
              Result := htLeftSpace;
            Exit;
          end;
          // work with right space
          R1 := Node.RightSpaceBounds;
          if PtInRect(R1, P) then
          begin
            RowIndex := Node.HeaderRowIndexFromY(P.Y);
            if Node.Level.Horizontal then
              if RowIndex <> -1 then
                if Node.Level.RowCount = 0 then
                  ColIndex := 0
                else
                  ColIndex := Node.Level.Layout[RowIndex].Count
              else
            else
              ColIndex := Node.Level.Layout.Count;
            Result := htRightSpace;
            Exit;
          end;
          // work with header
          if Node.Level.Horizontal then
            if ProcessHeader(Node.HeaderBounds, Result) then Exit
            else
          else
            for J := 0 to Node.Level.Layout.Count - 1 do
              if ProcessHeader(Node.HeaderColBounds[J], Result) then Exit;
          // work with content
          R1 := Node.ContentBounds;
          R2 := R1;
          if UseIndent then
          begin
            R2.Right := R2.Left + ExpandButtonIndent;
            if PtInRect(R2, P) then
            begin
              Result := htIndent;
              Exit;
            end;
          end;
          if Node.HasExpandButton and Node.ShowExpandButton then
          begin
            R2.Right := R2.Left + LevelIndent;
            if PtInRect(R2, P) then
            begin
              RowIndex := Node.ContentRowIndexFromY(P.Y);
              Result := htExpandButton;
              Exit;
            end;
            R1.Left := R2.Right;
          end;
  //        R2 := R1;
          if Node.ViewInfo.PreviewSize <> 0 then
          begin
            R2 := Node.PreviewBounds;
            if PtInRect(R2, P) then
            begin
              Result := htPreview;
              Exit;
            end;
          end;
          RowIndex := Node.ContentRowIndexFromY(P.Y);
          ColIndex := Node.ContentColIndexFromX(P.X);
          if PtInRect(R1, P) and (RowIndex <> -1) then
            Result := htContent
          else
            Result := htOther;
          if RowIndex <> -1 then
            with Node.Level do
              for J := 0 to VisibleColumnCount - 1 do
              begin
                Column := VisibleColumns[J];
                R1 := Column.GetContentBounds(Node);
                if PtInRect(R1, P) then
                begin
                  if not Horizontal then
                    if P.X < R1.Left + ColumnSizingZoneWidth then
                      if ShowHeader then
                        if Column.Level.CanHorSizing then
                          Result := htHeaderRightEdge
                        else
                      else
                        Result := htContentLeftEdge
                    else
                      if (P.X >= R1.Right - ColumnSizingZoneWidth) and
                        Column.CanHorSizing and Column.IsWidthLinked and
                        (not AutoColumnWidth or (Column.Level.Layout.Count <> 1)) then
                        Result := htContentRightEdge;
                  Exit;
                end;
              end;
          Column := nil;
          Exit;
        end;
      end;
    end;
  end;  

  Node := nil;
  Result := htNone;
end;

procedure TdxMasterView.LoadFromRegIniFile(const AFileName: string;
  AMode: TdxMasterViewRegIniFileMode);
var
  ARegIniFile: TdxMVRegIniFile;
  Section: string;
  I: Integer;

  procedure LoadLevel(ALevel: TdxMasterViewLevel);
  var
    LevelSection, ColumnSection: string;
    I, W: Integer;

    procedure ReadOptionView(const AName: string; AValue: TdxMasterViewLevelOptionView);
    begin
      with ALevel do
        if ARegIniFile.ReadBool(LevelSection, AName, AValue in OptionsView) then
          OptionsView := OptionsView + [AValue]
        else
          OptionsView := OptionsView - [AValue];
    end;

    procedure ReadHeaderOption(const AName: string; AValue: TdxMasterViewLevelOptionHeader);
    begin
      with ALevel do
        if ARegIniFile.ReadBool(LevelSection, AName, AValue in OptionsHeader) then
          OptionsHeader := OptionsHeader + [AValue]
        else
          OptionsHeader := OptionsHeader - [AValue];
    end;

    procedure LoadColumn(AColumn: TdxMasterViewColumn);
    begin
      ColumnSection := LevelSection + '\' + AColumn.Name;
      with ARegIniFile, AColumn do
        if SectionExists(ColumnSection) then
        begin
          GroupIndex := ReadInteger(ColumnSection, 'GroupIndex', GroupIndex);
          RowIndex := ReadInteger(ColumnSection, 'RowIndex', RowIndex);
          ColIndex := ReadInteger(ColumnSection, 'ColIndex', ColIndex);
          RowCount := ReadInteger(ColumnSection, 'RowCount', RowCount);
          SortIndex := ReadInteger(ColumnSection, 'SortIndex', SortIndex);
          SortOrder := TdxMasterViewSortOrder(
            ReadInteger(ColumnSection, 'SortOrder', Integer(SortOrder)));
          FLeaveSortOrder := ReadBool(ColumnSection, 'LeaveSortOrder', FLeaveSortOrder);
          Visible := ReadBool(ColumnSection, 'Visible', Visible);
          if ValueExists(ColumnSection, 'Width') then
            Width := ReadInteger(ColumnSection, 'Width', Width);
        end;
    end;

  begin
    if Section = '' then
      LevelSection := ALevel.Name
    else
      LevelSection := Section + '\' + ALevel.Name;
    with ARegIniFile, ALevel do
      if SectionExists(LevelSection) then
      begin
        ReadOptionView('ShowCaption', lovCaption);
        ReadOptionView('ShowFooter', lovFooter);
        ReadOptionView('ShowGrid', lovGrid);
        ReadOptionView('ShowGridWithPreview', lovGridWithPreview);
        ReadOptionView('ShowGroupByBox', lovGroupByBox);
        ReadOptionView('ShowHeader', lovHeader);
        ReadOptionView('ShowPreview', lovPreview);
        ReadOptionView('OccupyRestSpace', lovOccupyRestSpace);

        ReadHeaderOption('shForFirstNode', lohForFirstNode);
        ReadHeaderOption('shForFirstVisibleNode', lohForFirstVisibleNode);
        ReadHeaderOption('shAfterExpandedNode', lohAfterExpandedNode);

        ViewMode := TdxMasterViewViewMode(
          ReadInteger(LevelSection, 'ViewMode', Integer(ViewMode)));
        if not FHorizontal then
        begin
          I := 0;
          repeat
            W := ReadInteger(LevelSection, 'HeaderWidth' + IntToStr(I), -2);
            if W = -2 then Break;
            FLayout.Count := I + 1;
            if W <> -1 then
              FLayout.HeaderWidths[I] := W;
            Inc(I);
          until False;
        end;

        for I := 0 to ColumnCount - 1 do
          LoadColumn(Columns[I]);
      end;
  end;
 
begin
  if AFileName = '' then Exit;
  for I := 0 to AbsoluteLevelCount - 1 do
    AbsoluteLevels[I].BeginLoading;
  try
    ARegIniFile := TdxMVRegIniFile.Create(AFileName, AMode);
    with ARegIniFile do
      try
        case AMode of
          riIniFile:
            Section := Name;
          riRegistry:
            Section := '';
        end;
        if not SectionExists(Section) then Exit;

        if ReadBool(Section, 'Animation', movAnimation in OptionsView) then
          OptionsView := OptionsView + [movAnimation]
        else
          OptionsView := OptionsView - [movAnimation];
        if ReadBool(Section, 'AutoColumnWidth', movAutoColumnWidth in OptionsView) then
          OptionsView := OptionsView + [movAutoColumnWidth]
        else
          OptionsView := OptionsView - [movAutoColumnWidth];

        for I := 0 to AbsoluteLevelCount - 1 do
          LoadLevel(AbsoluteLevels[I]);
      finally
        Free;
      end;
  finally
    for I := AbsoluteLevelCount - 1 downto 0 do
      AbsoluteLevels[I].EndLoading;
    ShowFocusedNode;  
  end;
end;

function TdxMasterView.NodeFromID(ALevel: TdxMasterViewLevel;
  const AID: Variant): TdxMasterViewNode;

  procedure FindNode(Root: TdxMasterViewNode);
  var
    I: Integer;
  begin
    with Root do
      if (NodeType = ntData) and (Level = ALevel.Parent) {or
        (NodeType = ntCaption) and (Level = ALevel)} then
        Result := NodeFromID(ALevel, AID)
      else
        for I := 0 to Count - 1 do
        begin
          FindNode(Items[I]);
          if Result <> nil then Break;
        end;
  end;

begin
  Result := nil;
  if VarIsEmpty(AID) then Exit;
  FindNode(FItems);
end;

function TdxMasterView.NodeFromKeyValue(ALevel: TdxMasterViewLevel;
  AChildIndex: Integer; const AKeyValue: Variant): TdxMasterViewNode;

  procedure FindNode(Root: TdxMasterViewNode);
  var
    I: Integer;
  begin
    with Root do
      if (NodeType = ntData) and (Level = ALevel.Parent) {or
        (NodeType = ntCaption) and (Level = ALevel)} then
        Result := NodeFromKeyValue(ALevel, AChildIndex, AKeyValue)
      else
        for I := 0 to Count - 1 do
        begin
          FindNode(Items[I]);
          if Result <> nil then Break;
        end;
  end;

begin
  Result := nil;
  if VarIsEmpty(AKeyValue) or (ALevel[AChildIndex].MasterKeyFieldCount = 0) then Exit;
  FindNode(FItems);
end;

procedure TdxMasterView.SaveToRegIniFile(const AFileName: string;
  AMode: TdxMasterViewRegIniFileMode);
var
  ARegIniFile: TdxMVRegIniFile;
  Section: string;
  I: Integer;

  procedure SaveLevel(ALevel: TdxMasterViewLevel);
  var
    I, W: Integer;
    LevelSection, ColumnSection: string;

    procedure SaveColumn(AColumn: TdxMasterViewColumn);
    begin
      ColumnSection := LevelSection + '\' + AColumn.Name;
      with ARegIniFile, AColumn do
      begin
        WriteInteger(ColumnSection, 'GroupIndex', GroupIndex);
        WriteInteger(ColumnSection, 'RowIndex', RowIndex);
        WriteInteger(ColumnSection, 'ColIndex', ColIndex);
        WriteInteger(ColumnSection, 'RowCount', RowCount);
        WriteInteger(ColumnSection, 'SortIndex', SortIndex);
        WriteInteger(ColumnSection, 'SortOrder', Integer(SortOrder));
        WriteBool(ColumnSection, 'LeaveSortOrder', FLeaveSortOrder);
        WriteBool(ColumnSection, 'Visible', Visible);
        if cvWidth in AssignedValues then
          WriteInteger(ColumnSection, 'Width', Width);
      end;
    end;

  begin
    if Section = '' then
      LevelSection := ALevel.Name
    else
      LevelSection := Section + '\' + ALevel.Name;
    with ARegIniFile, ALevel do
    begin
      WriteBool(LevelSection, 'ShowCaption', ShowCaption);
      WriteBool(LevelSection, 'ShowFooter', ShowFooter);
      WriteBool(LevelSection, 'ShowGrid', ShowGrid);
      WriteBool(LevelSection, 'ShowGridWithPreview', ShowGridWithPreview);
      WriteBool(LevelSection, 'ShowGroupByBox', ShowGroupByBox);
      WriteBool(LevelSection, 'ShowHeader', ShowHeader);
      WriteBool(LevelSection, 'ShowPreview', ShowPreview);
      WriteBool(LevelSection, 'OccupyRestSpace', OccupyRestSpace);

      WriteBool(LevelSection, 'shForFirstNode', lohForFirstNode in OptionsHeader);
      WriteBool(LevelSection, 'shForFirstVisibleNode', lohForFirstVisibleNode in OptionsHeader);
      WriteBool(LevelSection, 'shAfterExpandedNode', lohAfterExpandedNode in OptionsHeader);

      WriteInteger(LevelSection, 'ViewMode', Ord(ViewMode));
      if not FHorizontal then
        for I := 0 to FLayout.Count - 1 do
        begin
          if FLayout.HeaderWidthAssigned[I] then
            W := FLayout.HeaderWidths[I]
          else
            W := -1;
          WriteInteger(LevelSection, 'HeaderWidth' + IntToStr(I), W);
        end;

      for I := 0 to ColumnCount - 1 do
        SaveColumn(Columns[I]);
    end;
  end;

begin
  if AFileName = '' then Exit;
  ARegIniFile := TdxMVRegIniFile.Create(AFileName, AMode);
  with ARegIniFile do
    try
      case AMode of
        riIniFile:
          Section := Name;
        riRegistry:
          Section := '';
      end;

      WriteBool(Section, 'Animation', movAnimation in FOptionsView);
      WriteBool(Section, 'AutoColumnWidth', movAutoColumnWidth in FOptionsView);

      for I := 0 to AbsoluteLevelCount - 1 do
        SaveLevel(AbsoluteLevels[I]);
    finally
      Free;
    end;
end;

procedure TdxMasterView.SelectItems(FromIndex, ToIndex: Integer; Select: Boolean);
var
  I: Integer;
begin
  if FromIndex < 0 then FromIndex := 0;
  if FromIndex >= AbsoluteItemCount then FromIndex := AbsoluteItemCount - 1;
  if ToIndex < 0 then ToIndex := 0;
  if ToIndex >= AbsoluteItemCount then ToIndex := AbsoluteItemCount - 1;
  if FromIndex > ToIndex then
  begin
    I := FromIndex;
    FromIndex := ToIndex;
    ToIndex := I;
  end;
  BeginSelection;
  try
    for I := FromIndex to ToIndex do
      AbsoluteItems[I].Selected := Select;
  finally
    EndSelection;
  end;
end;

procedure TdxMasterView.ShowFocusedNode;
begin
  if (FocusedNode = nil) or (FUpdateLockCount <> 0) then Exit;
  CheckFocusedNode;
  if (FocusedIndex < TopIndex) or (FocusedIndex > TopIndex + VisibleItemCount - 1) then
  begin
    Freeze;
    try
      ChangeFocusedIndex(FocusedIndex);
    finally
      Unfreeze;
    end;
  end;
end;

procedure TdxMasterView.UpdateData;
begin
  if FLevels <> nil then FLevels.LevelChanged(True);
end;

initialization
  Screen.Cursors[crdxMasterViewMirror] := LoadCursor(HInstance, 'DXMASTERVIEWMIRRORCURSOR');
  Screen.Cursors[crdxMasterViewFullScroll] := LoadCursor(HInstance, 'DXMASTERVIEWFULLSCROLLCURSOR');
  Screen.Cursors[crdxMasterViewHorScroll] := LoadCursor(HInstance, 'DXMASTERVIEWHORSCROLLCURSOR');
  Screen.Cursors[crdxMasterViewVerScroll] := LoadCursor(HInstance, 'DXMASTERVIEWVERSCROLLCURSOR');
  Screen.Cursors[crdxMasterViewUpScroll] := LoadCursor(HInstance, 'DXMASTERVIEWUPSCROLLCURSOR');
  Screen.Cursors[crdxMasterViewRightScroll] := LoadCursor(HInstance, 'DXMASTERVIEWRIGHTSCROLLCURSOR');
  Screen.Cursors[crdxMasterViewDownScroll] := LoadCursor(HInstance, 'DXMASTERVIEWDOWNSCROLLCURSOR');
  Screen.Cursors[crdxMasterViewLeftScroll] := LoadCursor(HInstance, 'DXMASTERVIEWLEFTSCROLLCURSOR');
  Screen.Cursors[crdxMasterViewHorSize] := LoadCursor(HInstance, 'DXMASTERVIEWHORSIZECURSOR');
  Screen.Cursors[crdxMasterViewVerSize] := LoadCursor(HInstance, 'DXMASTERVIEWVERSIZECURSOR');
  Screen.Cursors[crdxMasterViewRemove] := LoadCursor(HInstance, 'DXMASTERVIEWREMOVECURSOR');
  Screen.Cursors[crdxMasterViewNoDrop] := LoadCursor(HInstance, 'DXMASTERVIEWNODROPCURSOR');

  RegisterClasses([TdxMasterViewStyle, TdxMasterViewLevel]);

  RegColumnList := TList.Create;

  dxMasterViewRegisterColumn(TdxMasterViewColumn);

  dxMVGroupByBoxText := LoadStr(dxsMVGroupByBoxText);

  WndProcHandlers := TList.Create;

finalization
  WndProcHandlers.Free;

  dxMasterViewUnregisterColumn(TdxMasterViewColumn);

  with RegColumnList do
  begin
    while Count > 0 do
    begin
      Dispose(PRegColumnRecord(Last));
      Remove(Last);
    end;
    Free;
  end;

end.
