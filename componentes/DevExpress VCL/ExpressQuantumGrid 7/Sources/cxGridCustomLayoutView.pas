{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxGridCustomLayoutView;

{$I cxVer.inc}

interface

uses
  Types, Classes, Controls, Graphics, Windows, Forms, StdCtrls, cxClasses, cxCustomData,
  cxLookAndFeelPainters, cxControls, cxGridCustomView, cxGridCustomTableView;

const
  cxGridCustomLayoutViewRecordDefaultIndent = 7;
  cxGridCustomLayoutViewSeparatorDefaultColor = clDefault;
  cxGridCustomLayoutViewSeparatorDefaultWidth = 2;
  cxGridCustomLayoutViewDefaultRecordCaptionSeparator = ':';

type
  TcxGridCustomLayoutView = class;
  TcxGridCustomLayoutRecord = class;

  TcxGridCustomLayoutViewBands = class;

  TcxGridCustomLayoutViewController = class;
  TcxGridCustomLayoutViewControllerClass = class of TcxGridCustomLayoutViewController;

  TcxGridCustomLayoutViewViewInfo = class;
  TcxGridCustomLayoutRecordsViewInfo = class;
  TcxGridCustomLayoutRecordViewInfo = class;
  TcxGridCustomLayoutRecordViewInfoClass = class of TcxGridCustomLayoutRecordViewInfo;
  TcxGridCustomLayoutViewSeparatorsViewInfo = class;
  TcxGridCustomLayoutViewSeparatorsViewInfoClass = class of TcxGridCustomLayoutViewSeparatorsViewInfo;

  { TcxGridCustomLayoutViewBand }

  TcxGridCustomLayoutViewBand = class
  private
    FIndex: Integer;
    FItems: TList;
    function GetLast: TcxGridCustomLayoutRecordViewInfo;
    function GetItem(Index: Integer): TcxGridCustomLayoutRecordViewInfo;
    function GetCount: Integer;
    function GetVisibleCount: Integer;
    procedure SetItem(Index: Integer; Value: TcxGridCustomLayoutRecordViewInfo);
  public
    constructor Create(AIndex: Integer);
    destructor Destroy; override;

    function GetNearest(APos: Integer): TcxGridCustomLayoutRecordViewInfo;

    property Index: Integer read FIndex;
    property Last: TcxGridCustomLayoutRecordViewInfo read GetLast;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxGridCustomLayoutRecordViewInfo read GetItem write SetItem; default;
    property VisibleCount: Integer read GetVisibleCount;
  end;

  TcxGridCustomLayoutViewBandClass = class of TcxGridCustomLayoutViewBand;

  { TcxGridCustomLayoutViewBands }

  TcxGridCustomLayoutViewBands = class
  private
    FRecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo;
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxGridCustomLayoutViewBand;
    function GetLast: TcxGridCustomLayoutViewBand;
    function GetVisibleCount: Integer;
  protected
    function GetBandClass: TcxGridCustomLayoutViewBandClass; virtual;
    property RecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo read FRecordsViewInfo;

    procedure CreateItems;
    procedure DestroyItems;
  public
    constructor Create(ARecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo);
    destructor Destroy; override;

    procedure Clear;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxGridCustomLayoutViewBand read GetItem; default;
    property Last: TcxGridCustomLayoutViewBand read GetLast;
    property VisibleCount: Integer read GetVisibleCount;
  end;
  TcxGridCustomLayoutViewBandsClass = class of TcxGridCustomLayoutViewBands;

  { View Data }

  TcxGridCustomLayoutViewViewData = class(TcxCustomGridTableViewData)
  private
    function GetRecord(Index: Integer): TcxGridCustomLayoutRecord;
  protected
    function GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass; override;
  public
    property Records[Index: Integer]: TcxGridCustomLayoutRecord read GetRecord;
  end;

  { Controllers }

  TcxGridCustomLayoutViewControllerHelper = class
  private
    FController: TcxGridCustomLayoutViewController;
    function GetControl: TcxControl;
    function GetDataController: TcxCustomDataController;
    function GetScrollBarOffsetBegin: Integer;
    function GetScrollBarOffsetEnd: Integer;
    function GetViewData: TcxGridCustomLayoutViewViewData;
    function GetViewInfo: TcxGridCustomLayoutViewViewInfo;
  protected
    function CanScrollBarVisible(AKind: TScrollBarKind): Boolean; virtual;
    procedure InitScrollBarParameters(AKind: TScrollBarKind; ACanHide: Boolean); virtual;

    property Control: TcxControl read GetControl;
    property Controller: TcxGridCustomLayoutViewController read FController;
    property DataController: TcxCustomDataController read GetDataController;
    property ScrollBarOffsetBegin: Integer read GetScrollBarOffsetBegin;
    property ScrollBarOffsetEnd: Integer read GetScrollBarOffsetEnd;
    property ViewData: TcxGridCustomLayoutViewViewData read GetViewData;
    property ViewInfo: TcxGridCustomLayoutViewViewInfo read GetViewInfo;
  public
    constructor Create(AController: TcxGridCustomLayoutViewController); virtual;
    function GetIsRecordsScrollHorizontal: Boolean; virtual; abstract;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; virtual; abstract;
    function GetScrollDelta: Integer; virtual; abstract;
    procedure InitScrollBarsParameters;
    procedure KeyDown(var Key: Word; Shift: TShiftState); dynamic;
  end;

  TcxGridCustomLayoutViewControllerHelperClass = class of TcxGridCustomLayoutViewControllerHelper;

  TcxGridCustomLayoutViewControllerHorizontalHelper = class(TcxGridCustomLayoutViewControllerHelper)
  private
    procedure FocusRecordInNextColumn(ADirection: TcxDirection; AIsSelecting: Boolean);
  protected
    function CanScrollBarVisible(AKind: TScrollBarKind): Boolean; override;
  public
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function GetScrollDelta: Integer; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  TcxGridCustomLayoutViewControllerVerticalHelper = class(TcxGridCustomLayoutViewControllerHelper)
  private
    procedure FocusRecordInNextRow(ADirection: TcxDirection; AIsSelecting: Boolean);
  protected
    function CanScrollBarVisible(AKind: TScrollBarKind): Boolean; override;
  public
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function GetScrollDelta: Integer; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  TcxGridCustomLayoutViewController = class(TcxCustomGridTableController)
  private
    FHelper: TcxGridCustomLayoutViewControllerHelper;
    FScrollRecordViewInfo: TcxGridCustomLayoutRecordViewInfo;
    function GetFocusedRecordViewInfo: TcxGridCustomLayoutRecordViewInfo;
    function GetScrollDelta: Integer;
    function GetViewData: TcxGridCustomLayoutViewViewData;
    function GetViewInfo: TcxGridCustomLayoutViewViewInfo;
    procedure SetScrollRecordViewInfo(Value: TcxGridCustomLayoutRecordViewInfo);
  protected
    function GetDragScrollInterval: Integer; override;
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    procedure ScrollData(ADirection: TcxDirection); override;

    procedure CreateHelper; virtual;
    procedure DestroyHelper; virtual;
    function GetHelperClass: TcxGridCustomLayoutViewControllerHelperClass; virtual;
    procedure InternalKeyDown(var Key: Word; Shift: TShiftState); virtual;
    function ProcessFocusedItemKeys(var AKey: Word; AShift: TShiftState; ARowGoOnCycle: Boolean): Boolean; virtual;

    property FocusedRecordViewInfo: TcxGridCustomLayoutRecordViewInfo read GetFocusedRecordViewInfo;
    property Helper: TcxGridCustomLayoutViewControllerHelper read FHelper;
    property ScrollRecordViewInfo: TcxGridCustomLayoutRecordViewInfo read FScrollRecordViewInfo write SetScrollRecordViewInfo;
    property ScrollDelta: Integer read GetScrollDelta;
    property ViewData: TcxGridCustomLayoutViewViewData read GetViewData;
    property ViewInfo: TcxGridCustomLayoutViewViewInfo read GetViewInfo;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;

    function IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MakeItemVisible(AItem: TcxCustomGridTableItem); override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer); override;
    procedure InitScrollBarsParameters; override;

    function FocusNextItemHorizontally(AGoForward, AGoOnCycle: Boolean): Boolean; virtual;
    function FocusNextItemVertically(AGoForward, AGoOnCycle: Boolean): Boolean; virtual;

    function CanScrollFocusedRecord(ADown: Boolean): Boolean; virtual;
    function ScrollFocusedRecord(ADown: Boolean): Boolean; virtual;

    procedure LayoutDirectionChanged;
  end;

  { Painters }

  { TcxGridCustomLayoutViewPainter }

  TcxGridCustomLayoutViewPainter = class(TcxCustomGridTablePainter)
  private
    function GetViewInfo: TcxGridCustomLayoutViewViewInfo;
  protected
    procedure DrawBackground; override;
    procedure DrawSeparators; virtual;
    procedure PaintContent; override;
  public
    property ViewInfo: TcxGridCustomLayoutViewViewInfo read GetViewInfo;
  end;

  { Cache }

  TcxGridCustomLayoutViewInfoCacheItem = class(TcxCustomGridTableViewInfoCacheItem);

  { TcxGridCustomLayoutRecordViewInfo }

  TcxGridCustomLayoutRecordViewInfo = class(TcxCustomGridRecordViewInfo)
  private
    FCol: Integer;
    FRow: Integer;
    FCalculationPosition: TPoint;
    function GetRecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo;
  protected
    function GetVisible: Boolean; override;
    property CalculationPosition: TPoint read FCalculationPosition write FCalculationPosition;
  public
    class function GetExpandButtonSize(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; virtual;
    function IsFullyVisible: Boolean;

    property RecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo read GetRecordsViewInfo;
    property Col: Integer read FCol;
    property Row: Integer read FRow;
  end;

  { TcxGridCustomLayoutViewSeparatorsViewInfo }

  TcxGridCustomLayoutViewSeparatorsViewInfo = class
  private
    FGridViewInfo: TcxGridCustomLayoutViewViewInfo;
    FItems: TList;
    function GetCount: Integer;
    function GetGridView: TcxGridCustomLayoutView;
    function GetItem(Index: Integer): TRect;
    function GetRecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo;
    procedure SetItem(Index: Integer; const Value: TRect);
    procedure CreateItems;
    procedure DestroyItems;
  protected
    procedure Add(const R: TRect);
    procedure DoCalculate; virtual;
    function GetBounds: TRect; virtual;
    function GetColor: TColor; virtual;
    function GetWidth: Integer; virtual;

    property Bounds: TRect read GetBounds;
    property GridView: TcxGridCustomLayoutView read GetGridView;
    property GridViewInfo: TcxGridCustomLayoutViewViewInfo read FGridViewInfo;
    property RecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo read GetRecordsViewInfo;
  public
    constructor Create(AGridViewInfo: TcxGridCustomLayoutViewViewInfo); virtual;
    destructor Destroy; override;

    procedure Calculate;
    procedure Clear;

    property Color: TColor read GetColor;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TRect read GetItem write SetItem; default;
    property Width: Integer read GetWidth;
  end;

  { calculators }

  TcxGridCustomLayoutRecordsViewInfoBasedCalculator = class
  private
    FRecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo;
    function GetRecord(Index: Integer): TcxGridCustomLayoutRecordViewInfo;
  protected
    procedure AfterCalculate; virtual;
    procedure BeforeCalculate; virtual;
    procedure Calculate(const AContentBounds: TRect);
    procedure DoCalculate(const AContentBounds: TRect); virtual;

    function GetRecordIndent: Integer;
    function GetRecordSpaceHorz: Integer; virtual;
    function GetRecordSpaceVert: Integer; virtual;
    function GetSeparatorWidth: Integer;

    function GetMaxCount: Integer;

    function GetMaxCoulumnCount: Integer; virtual;
    function GetMaxRowCount: Integer; virtual;

    property Records[Index: Integer]: TcxGridCustomLayoutRecordViewInfo read GetRecord;
  public
    constructor Create(ARecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo); virtual;

    property RecordSpaceHorz: Integer read GetRecordSpaceHorz;
    property RecordSpaceVert: Integer read GetRecordSpaceVert;
    property RecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo read FRecordsViewInfo;
  end;

  TcxGridCustomLayoutRecordsViewInfoBasedCalculatorClass = class of TcxGridCustomLayoutRecordsViewInfoBasedCalculator;

  TcxGridCustomLayoutViewInfoHorizontalCalculator = class(TcxGridCustomLayoutRecordsViewInfoBasedCalculator)
  protected
    procedure DoCalculate(const AContentBounds: TRect); override;
    function GetRecordSpaceHorz: Integer; override;
    function GetRecordSpaceVert: Integer; override;
  end;

  TcxGridCustomLayoutViewInfoVerticalCalculator = class(TcxGridCustomLayoutRecordsViewInfoBasedCalculator)
  protected
    procedure DoCalculate(const AContentBounds: TRect); override;
    function GetRecordSpaceHorz: Integer; override;
    function GetRecordSpaceVert: Integer; override;
  end;

  { TcxGridCustomLayoutRecordsViewInfo }

  TcxGridCustomLayoutRecordsViewInfo = class(TcxCustomGridRecordsViewInfo)
  private
    FBands: TcxGridCustomLayoutViewBands;
    FCalculator: TcxGridCustomLayoutRecordsViewInfoBasedCalculator;
    FMaxRecordHeight: Integer;
    FPartVisibleCount: Integer;
    FRecordHeight: Integer;
    FRecordSpaceHorz: Integer;
    FRecordSpaceVert: Integer;
    FRecordWidth: Integer;
    function GetItem(Index: Integer): TcxGridCustomLayoutRecordViewInfo;
    function GetGridView: TcxGridCustomLayoutView;
    function GetGridViewInfo: TcxGridCustomLayoutViewViewInfo;
  protected
    procedure Calculate; override;
    function CalculateContentBounds: TRect; override;

    function GetItemLeftBound(AIndex: Integer): Integer; override;
    function GetItemsOffset(AItemCountDelta: Integer): Integer; override;
    function GetItemTopBound(AIndex: Integer): Integer; override;
    procedure OffsetItem(AIndex, AOffset: Integer); override;

    function CalculateRecordHeight: Integer; virtual;
    function CalculateRecordWidth: Integer; virtual;
    function CalculateMaxRecordHeight: Integer; virtual;

    function GetCalculatorClass: TcxGridCustomLayoutRecordsViewInfoBasedCalculatorClass; virtual;
    function GetBandsClass: TcxGridCustomLayoutViewBandsClass; virtual;
    function GetItemViewInfoClass: TcxGridCustomLayoutRecordViewInfoClass; virtual;

    function GetMaxRecordWidth(AColumn: Integer): Integer; virtual;
    function GetMaxRecordHeight(ARow: Integer): Integer; virtual;

    function GetRecordIndent: Integer; virtual;
    function GetSeparatorWidth: Integer; virtual;

    property Calculator: TcxGridCustomLayoutRecordsViewInfoBasedCalculator read FCalculator;
    property RecordIndent: Integer read GetRecordIndent;
    property RecordSpaceHorz: Integer read FRecordSpaceHorz;
    property RecordSpaceVert: Integer read FRecordSpaceVert;
  public
    constructor Create(AGridViewInfo: TcxCustomGridTableViewInfo); override;
    destructor Destroy; override;

    function GetRealItem(ARecord: TcxCustomGridRecord): TcxGridCustomLayoutRecordViewInfo; reintroduce; virtual;

    property Bands: TcxGridCustomLayoutViewBands read FBands;
    property GridView: TcxGridCustomLayoutView read GetGridView;
    property GridViewInfo: TcxGridCustomLayoutViewViewInfo read GetGridViewInfo;
    property Items[Index: Integer]: TcxGridCustomLayoutRecordViewInfo read GetItem; default;
    property MaxRecordHeight: Integer read FMaxRecordHeight;
    property PartVisibleCount: Integer read FPartVisibleCount;
    property RecordHeight: Integer read FRecordHeight;
    property RecordWidth: Integer read FRecordWidth;
  end;

  { TcxGridCustomLayoutViewViewInfo }

  TcxGridCustomLayoutViewViewInfo = class(TcxCustomGridTableViewInfo)
  private
    FSeparatorsViewInfo: TcxGridCustomLayoutViewSeparatorsViewInfo;
    function GetGridView: TcxGridCustomLayoutView;
    function GetRecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo;
  protected
    procedure AfterCalculating; override;
    procedure BeforeCalculating; override;
    procedure CreateViewInfos; override;
    procedure DestroyViewInfos(AIsRecreating: Boolean); override;

    function GetSeparatorsViewInfoClass: TcxGridCustomLayoutViewSeparatorsViewInfoClass; virtual;
  public
    function CanOffsetView(ARecordCountDelta: Integer): Boolean; override;
    property GridView: TcxGridCustomLayoutView read GetGridView;
    property RecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo read GetRecordsViewInfo;
    property SeparatorsViewInfo: TcxGridCustomLayoutViewSeparatorsViewInfo read FSeparatorsViewInfo;
  end;

  { TcxGridCustomLayoutRecord }

  TcxGridCustomLayoutRecord = class(TcxCustomGridRecord)
  private
    FExpanded: Boolean;
    function GetGridView: TcxGridCustomLayoutView;
    procedure SetExpanded(Value: Boolean);
  protected
    procedure DoCollapse(ARecurse: Boolean); override;
    procedure DoExpand(ARecurse: Boolean); override;
    function GetExpandable: Boolean; override;
    function GetExpanded: Boolean; override;
    function GetHasCells: Boolean; override;
    function GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass; override;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;

    property Expanded: Boolean read GetExpanded write SetExpanded;
  public
    constructor Create(AViewData: TcxCustomGridTableViewData; AIndex: Integer; const ARecordInfo: TcxRowInfo); override;
    property GridView: TcxGridCustomLayoutView read GetGridView;
  end;

  { TcxGridCustomLayoutViewOptionsCustomize }

  TcxGridCustomLayoutViewOptionsCustomize = class(TcxCustomGridTableOptionsCustomize)
  private
    FExpandable: Boolean;
    function GetGridView: TcxGridCustomLayoutView;
    procedure SetExpandable(Value: Boolean);
  protected
    property Expandable: Boolean read FExpandable write SetExpandable default False;
  public
    procedure Assign(Source: TPersistent); override;

    property GridView: TcxGridCustomLayoutView read GetGridView;
  end;

  { TcxGridCustomLayoutViewOptionsView }

  TcxGridCustomLayoutViewOptionsView = class(TcxCustomGridTableOptionsView)
  private
    FCaptionSeparator: Char;
    FIndent: Integer;
    FSeparatorColor: TColor;
    FSeparatorWidth: Integer;
    procedure SetCaptionSeparator(Value: Char);
    procedure SetIndent(Value: Integer);
    procedure SetSeparatorColor(Value: TColor);
    procedure SetSeparatorWidth(Value: Integer);
  protected
    property CaptionSeparator: Char read FCaptionSeparator
      write SetCaptionSeparator default cxGridCustomLayoutViewDefaultRecordCaptionSeparator;
    property Indent: Integer read FIndent write SetIndent
      default cxGridCustomLayoutViewRecordDefaultIndent;
    property SeparatorColor: TColor read FSeparatorColor write SetSeparatorColor
      default cxGridCustomLayoutViewSeparatorDefaultColor;
    property SeparatorWidth: Integer read FSeparatorWidth write SetSeparatorWidth
      default cxGridCustomLayoutViewSeparatorDefaultWidth;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;

    function GetSeparatorColor: TColor;
  end;

  { TcxGridCustomLayoutView }

  TcxGridCustomLayoutView = class(TcxCustomGridTableView)
  private
    function GetOptionsCustomize: TcxGridCustomLayoutViewOptionsCustomize;
    function GetOptionsView: TcxGridCustomLayoutViewOptionsView;
    function GetViewInfo: TcxGridCustomLayoutViewViewInfo;
    procedure SetOptionsCustomize(Value: TcxGridCustomLayoutViewOptionsCustomize);
    procedure SetOptionsView(Value: TcxGridCustomLayoutViewOptionsView);
  protected
    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass; override;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    procedure Reposition;
  public
    property OptionsCustomize: TcxGridCustomLayoutViewOptionsCustomize read GetOptionsCustomize write SetOptionsCustomize;
    property OptionsView: TcxGridCustomLayoutViewOptionsView read GetOptionsView write SetOptionsView;
    property ViewInfo: TcxGridCustomLayoutViewViewInfo read GetViewInfo;
  end;

implementation

uses
  Math, SysUtils;

{ TcxGridCustomLayoutViewColumn }

constructor TcxGridCustomLayoutViewBand.Create(AIndex: Integer);
begin
  inherited Create;
  FIndex := AIndex;
  FItems := TList.Create;
end;

destructor TcxGridCustomLayoutViewBand.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TcxGridCustomLayoutViewBand.GetNearest(APos: Integer): TcxGridCustomLayoutRecordViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if APos < Result.Bounds.Bottom then Break;
  end;
end;

function TcxGridCustomLayoutViewBand.GetLast: TcxGridCustomLayoutRecordViewInfo;
begin
  Result := Items[VisibleCount - 1];
end;

function TcxGridCustomLayoutViewBand.GetItem(Index: Integer): TcxGridCustomLayoutRecordViewInfo;
begin
  Result := TcxGridCustomLayoutRecordViewInfo(FItems[Index]);
end;

function TcxGridCustomLayoutViewBand.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridCustomLayoutViewBand.GetVisibleCount: Integer;
begin
  if Count = 0 then
    Result := 0
  else
  begin
    for Result := Count - 1 downto 0 do
      if Items[Result].Visible then Break;
    Inc(Result);
  end;
end;

procedure TcxGridCustomLayoutViewBand.SetItem(Index: Integer; Value: TcxGridCustomLayoutRecordViewInfo);
begin
  if Index < Count then
    FItems[Index] := Value
  else
    FItems.Add(Value);
  Value.FCol := Self.Index;
  Value.FRow := Index;
end;

{ TcxGridCustomCardViewColumns }

constructor TcxGridCustomLayoutViewBands.Create(ARecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo);
begin
  inherited Create;
  FRecordsViewInfo := ARecordsViewInfo;
  CreateItems;
end;

destructor TcxGridCustomLayoutViewBands.Destroy;
begin
  DestroyItems;
  inherited;
end;

procedure TcxGridCustomLayoutViewBands.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Clear;
end;

function TcxGridCustomLayoutViewBands.GetBandClass: TcxGridCustomLayoutViewBandClass;
begin
  Result := TcxGridCustomLayoutViewBand;
end;

function TcxGridCustomLayoutViewBands.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridCustomLayoutViewBands.GetItem(Index: Integer): TcxGridCustomLayoutViewBand;
begin
  if Index < Count then
    Result := TcxGridCustomLayoutViewBand(FItems[Index])
  else
  begin
    Result := GetBandClass.Create(Index);
    FItems.Add(Result);
  end;
end;

function TcxGridCustomLayoutViewBands.GetLast: TcxGridCustomLayoutViewBand;
begin
  if Count = 0 then
    Result := nil
  else
    Result := Items[Count - 1];
end;

function TcxGridCustomLayoutViewBands.GetVisibleCount: Integer;
begin
  if Count = 0 then
    Result := 0
  else
  begin
    for Result := Count - 1 downto 0 do
      if Items[Result][0].Visible then Break;
    Inc(Result);    
  end;      
end;

procedure TcxGridCustomLayoutViewBands.CreateItems;
begin
  FItems := TList.Create;
end;

procedure TcxGridCustomLayoutViewBands.DestroyItems;
begin
  Clear;
  FItems.Free;
end;

{ TcxGridCustomLayoutViewViewData }

function TcxGridCustomLayoutViewViewData.GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass;
begin
  Result := TcxGridCustomLayoutRecord;
end;

function TcxGridCustomLayoutViewViewData.GetRecord(Index: Integer): TcxGridCustomLayoutRecord;
begin
  Result := TcxGridCustomLayoutRecord(inherited Records[Index]);
end;

{ TcxGridCustomCardViewControllerImpl }

constructor TcxGridCustomLayoutViewControllerHelper.Create(AController: TcxGridCustomLayoutViewController);
begin
  inherited Create;
  FController := AController;
end;

procedure TcxGridCustomLayoutViewControllerHelper.InitScrollBarsParameters;
begin
  InitScrollBarParameters(sbHorizontal, Controller.CanHScrollBarHide);
  InitScrollBarParameters(sbVertical, True);
end;

procedure TcxGridCustomLayoutViewControllerHelper.KeyDown(var Key: Word; Shift: TShiftState);
begin
end;

function TcxGridCustomLayoutViewControllerHelper.CanScrollBarVisible(AKind: TScrollBarKind): Boolean;
begin
  Result := True;
end;

procedure TcxGridCustomLayoutViewControllerHelper.InitScrollBarParameters(AKind: TScrollBarKind; ACanHide: Boolean);
begin
  if CanScrollBarVisible(AKind) then
    Controller.SetScrollBarInfo(AKind, 0, Controller.ScrollBarRecordCount - 1,
      Controller.ScrollDelta, Controller.ViewInfo.VisibleRecordCount, Controller.ScrollBarPos, True, ACanHide)
  else
    Controller.SetScrollBarInfo(AKind, 0, -1, 0, 0, 0, True, True);
end;

function TcxGridCustomLayoutViewControllerHelper.GetControl: TcxControl;
begin
  Result := Controller.Control;
end;

function TcxGridCustomLayoutViewControllerHelper.GetDataController: TcxCustomDataController;
begin
  Result := Controller.DataController;
end;

function TcxGridCustomLayoutViewControllerHelper.GetScrollBarOffsetBegin: Integer;
begin
  Result := Controller.ScrollBarOffsetBegin;
end;

function TcxGridCustomLayoutViewControllerHelper.GetScrollBarOffsetEnd: Integer;
begin
  Result := Controller.ScrollBarOffsetEnd;
end;

function TcxGridCustomLayoutViewControllerHelper.GetViewData: TcxGridCustomLayoutViewViewData;
begin
  Result := Controller.ViewData;
end;

function TcxGridCustomLayoutViewControllerHelper.GetViewInfo: TcxGridCustomLayoutViewViewInfo;
begin
  Result := Controller.ViewInfo;
end;

{ TcxGridCustomCardViewControllerHorizontalImpl }

function TcxGridCustomLayoutViewControllerHorizontalHelper.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := True;
end;

function TcxGridCustomLayoutViewControllerHorizontalHelper.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskHorizontal;
end;

function TcxGridCustomLayoutViewControllerHorizontalHelper.GetScrollDelta: Integer;
begin
  if ViewInfo.RecordsViewInfo.Bands.Count = 0 then
    Result := 0
  else
    Result := ViewInfo.RecordsViewInfo.Bands[0].Count;
end;

procedure TcxGridCustomLayoutViewControllerHorizontalHelper.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_LEFT:
      FocusRecordInNextColumn(dirLeft, ssShift in Shift);
    VK_RIGHT:
      FocusRecordInNextColumn(dirRight, ssShift in Shift);
    VK_UP:
      Controller.GoToPrev(not (ssShift in Shift), False);
    VK_DOWN:
      Controller.GoToNext(not (ssShift in Shift), False);
  end;
end;

function TcxGridCustomLayoutViewControllerHorizontalHelper.CanScrollBarVisible(AKind: TScrollBarKind): Boolean;
begin
  Result := AKind = sbHorizontal;
end;

procedure TcxGridCustomLayoutViewControllerHorizontalHelper.FocusRecordInNextColumn(ADirection: TcxDirection; AIsSelecting: Boolean);
var
  ARecordViewInfo: TcxGridCustomLayoutRecordViewInfo;
  ACheckPos: Integer;

  function MarginCol(AIsLeftDirection: Boolean): Integer;
  begin
    if AIsLeftDirection then
      Result := 0
    else
      Result := ViewInfo.RecordsViewInfo.Bands.VisibleCount - 1;
  end;

  function NextCol: Integer;
  begin
    if ARecordViewInfo = nil then
      Result := MarginCol(ADirection = dirRight)
    else
      if ADirection = dirLeft then
        Result := ARecordViewInfo.Col - 1
      else
        Result := ARecordViewInfo.Col + 1;
  end;

  function MarginRecordIndex: Integer;
  begin
    if ADirection = dirLeft then
      Result := 0
    else
      Result := ViewData.RecordCount - 1;
  end;

begin
  with Controller do
    try
      if FocusedRecordIndex = -1 then
      begin
        if ADirection = dirLeft then
          GoToFirst
        else
          GoToLast(False);
        Exit;
      end;
      MakeFocusedRecordVisible;
      ARecordViewInfo := ViewInfo.RecordsViewInfo.GetRealItem(FocusedRecord);
      ACheckPos := ARecordViewInfo.Bounds.Top;
      if ARecordViewInfo.Col = MarginCol(ADirection = dirLeft) then
      begin
        ScrollData(ADirection);
        ARecordViewInfo := ViewInfo.RecordsViewInfo.GetRealItem(FocusedRecord);
        if (ARecordViewInfo <> nil) and
          (ARecordViewInfo.Col = MarginCol(ADirection = dirLeft)) then
        begin
          if ARecordViewInfo.Bounds.Top <> ACheckPos then
            GoToPrev(False)
          else
            if GridView.IsDetail then
              FocusNextRecord(MarginRecordIndex, ADirection = dirRight, False,
                not AIsSelecting, not AIsSelecting);
          Exit;
        end;
      end;
      ARecordViewInfo := ViewInfo.RecordsViewInfo.Bands[NextCol].GetNearest(ACheckPos);
      FocusedRecord := ARecordViewInfo.GridRecord;
    finally
      MakeFocusedItemVisible;
    end;
end;

{ TcxGridCustomCardViewControllerVerticalImpl }

function TcxGridCustomLayoutViewControllerVerticalHelper.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := False;
end;

function TcxGridCustomLayoutViewControllerVerticalHelper.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskVertical;
end;

function TcxGridCustomLayoutViewControllerVerticalHelper.GetScrollDelta: Integer;
begin
  Result := ViewInfo.RecordsViewInfo.Bands.Count;
end;

procedure TcxGridCustomLayoutViewControllerVerticalHelper.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_LEFT:
      begin
        Controller.GoToPrev(not (ssShift in Shift), False);
        Controller.MakeFocusedItemVisible;
      end;
    VK_RIGHT:
      begin
        Controller.GoToNext(not (ssShift in Shift), False);
        Controller.MakeFocusedItemVisible;
      end;
    VK_UP:
      FocusRecordInNextRow(dirUp, ssShift in Shift);
    VK_DOWN:
      FocusRecordInNextRow(dirDown, ssShift in Shift);
  end;
end;

function TcxGridCustomLayoutViewControllerVerticalHelper.CanScrollBarVisible(AKind: TScrollBarKind): Boolean;
begin
  Result := AKind = sbVertical;
end;

procedure TcxGridCustomLayoutViewControllerVerticalHelper.FocusRecordInNextRow(ADirection: TcxDirection; AIsSelecting: Boolean);
var
  ANewFocusedRecordIndex: Integer;
  AIsNewFocusedRecordOutOfRange: Boolean;

  function NextRecordIndex: Integer;
  begin
    with Controller do
      if ADirection = dirUp then
        Result := FocusedRecordIndex - ScrollDelta
      else
        Result := FocusedRecordIndex + ScrollDelta;
  end;

  function IsOnBound: Boolean;
  begin
    Result :=
      DataController.IsGridMode and
        (DataController.IsBOF and (ADirection = dirUp) or
         DataController.IsEOF and (ADirection = dirDown)) or
      not DataController.IsGridMode and AIsNewFocusedRecordOutOfRange;
  end;

  function MarginRecordIndex: Integer;
  begin
    if ADirection = dirUp then
      Result := 0
    else
      Result := ViewData.RecordCount - 1;
  end;

begin
  with Controller do
  begin
    if FocusedRecordIndex = -1 then
    begin
      if ADirection = dirUp then
        GoToFirst
      else
        GoToLast(False);
      Exit;
    end;
    MakeFocusedRecordVisible;
    ANewFocusedRecordIndex := NextRecordIndex;
    AIsNewFocusedRecordOutOfRange := (ANewFocusedRecordIndex < 0) or
      (ANewFocusedRecordIndex > ViewData.RecordCount - 1);
    if IsOnBound then
    begin
      if GridView.IsDetail then
        FocusNextRecord(MarginRecordIndex, ADirection = dirDown, False,
          not AIsSelecting, not AIsSelecting);
      Exit;
    end;
    if DataController.IsGridMode and AIsNewFocusedRecordOutOfRange or
      not ViewData.Records[ANewFocusedRecordIndex].Visible then
    begin
      ScrollData(ADirection);
      if AIsNewFocusedRecordOutOfRange then
      begin
        if ANewFocusedRecordIndex < 0 then ANewFocusedRecordIndex := 0;
        if ANewFocusedRecordIndex > ViewData.RecordCount - 1 then
          ANewFocusedRecordIndex := ViewData.RecordCount - 1;
      end;
    end;
    FocusedRecordIndex := ANewFocusedRecordIndex;
  end;
end;

{ TcxGridCustomCardViewController }

constructor TcxGridCustomLayoutViewController.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  CreateHelper;
end;

destructor TcxGridCustomLayoutViewController.Destroy;
begin
  DestroyHelper;
  inherited;
end;

function TcxGridCustomLayoutViewController.IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to ViewInfo.RecordsViewInfo.PartVisibleCount - 1 do
  begin
    Result := ViewInfo.RecordsViewInfo[I].IsFullyVisible;
    if not Result then Break;
  end;
  if Result then
    Result := inherited IsDataFullyVisible(AIsCallFromMaster);
end;

procedure TcxGridCustomLayoutViewController.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  InternalKeyDown(Key, Shift);
end;

procedure TcxGridCustomLayoutViewController.MakeItemVisible(AItem: TcxCustomGridTableItem);
begin
  MakeFocusedRecordVisible;
end;

procedure TcxGridCustomLayoutViewController.Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  case AScrollCode of
    scLineUp:
      ScrollData(dirLeft);
    scLineDown:
      ScrollData(dirRight);
    scPageUp:
      ScrollPage(False);
    scPageDown:
      ScrollPage(True);
    scTrack:
      if not DataController.IsGridMode then
        ScrollBarPos := AScrollPos;
    scPosition:
      if DataController.IsGridMode then
        ScrollBarPos := AScrollPos;
  end;
  AScrollPos := ScrollBarPos;
end;

procedure TcxGridCustomLayoutViewController.InitScrollBarsParameters;
begin
  Helper.InitScrollBarsParameters;
end;

function TcxGridCustomLayoutViewController.FocusNextItemHorizontally(AGoForward, AGoOnCycle: Boolean): Boolean;
begin
  Result := False;
end;

function TcxGridCustomLayoutViewController.FocusNextItemVertically(AGoForward, AGoOnCycle: Boolean): Boolean;
begin
  Result := False;
end;

function TcxGridCustomLayoutViewController.CanScrollFocusedRecord(ADown: Boolean): Boolean;
begin
  Result := False;
end;

function TcxGridCustomLayoutViewController.ScrollFocusedRecord(ADown: Boolean): Boolean;
begin
  Result := False;  
end;

procedure TcxGridCustomLayoutViewController.LayoutDirectionChanged;
begin
  DestroyHelper;
  CreateHelper;
end;

procedure TcxGridCustomLayoutViewController.CreateHelper;
begin
  FHelper := GetHelperClass.Create(Self);
end;

function TcxGridCustomLayoutViewController.GetDragScrollInterval: Integer;
begin
  Result := 300;
end;

function TcxGridCustomLayoutViewController.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := Helper.GetIsRecordsScrollHorizontal;
end;

function TcxGridCustomLayoutViewController.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := Helper.GetMouseWheelScrollingKind;
end;

procedure TcxGridCustomLayoutViewController.ScrollData(ADirection: TcxDirection);
begin
  if Site.DragAndDropState = ddsNone then
    ScrollRecords(ADirection in [dirRight, dirDown], ScrollDelta);
end;

procedure TcxGridCustomLayoutViewController.DestroyHelper;
begin
  FreeAndNil(FHelper);
end;

function TcxGridCustomLayoutViewController.GetHelperClass: TcxGridCustomLayoutViewControllerHelperClass;
begin
  Result := TcxGridCustomLayoutViewControllerHelper;
end;

procedure TcxGridCustomLayoutViewController.InternalKeyDown(var Key: Word; Shift: TShiftState);
var
  APrevFocusedRecordIndex: Integer;
begin
  if FocusedRecordIndex <> -1 then
  begin
    if GridView.OptionsSelection.CellSelect and ProcessFocusedItemKeys(Key, Shift, False) then
      Exit;
    if ((Key = VK_UP) or (Key = VK_DOWN)) and ScrollFocusedRecord(Key = VK_DOWN) then
      Exit;
  end;
  APrevFocusedRecordIndex := FocusedRecordIndex;
  case Key of
    VK_HOME:
      GoToFirst(False);
    VK_END:
      GoToLast(False, False);
  end;
  Helper.KeyDown(Key, Shift);
  if (FocusedRecordIndex <> APrevFocusedRecordIndex) and
    (FocusedRecordIndex <> -1) and GridView.OptionsSelection.CellSelect then
    ProcessFocusedItemKeys(Key, Shift, True);
end;

function TcxGridCustomLayoutViewController.ProcessFocusedItemKeys(var AKey: Word; AShift: TShiftState; ARowGoOnCycle: Boolean): Boolean;
begin
  Result := False;
  if FocusedItem <> nil then
    case AKey of
      VK_LEFT, VK_RIGHT:
        Result := FocusNextItemHorizontally(AKey = VK_RIGHT, ARowGoOnCycle);
      VK_UP, VK_DOWN:
        Result := FocusNextItemVertically(AKey = VK_DOWN, ARowGoOnCycle);
      VK_HOME:
        if AShift = [] then
        begin
          FocusNextItem(-1, True, False, False, True);
          Result := True;
        end;
      VK_END:
        if AShift = [] then
        begin
          FocusNextItem(-1, False, True, False, True);
          Result := True;
        end;
      VK_ESCAPE:
        if GridView.OptionsSelection.InvertSelect and (FocusedItem <> nil) then
        begin
          FocusedItem := nil;
          Result := True;
        end;
    end
  else
    if AKey = VK_F2 then
      Result := FocusNextItem(-1, True, False, False, True);
end;

function TcxGridCustomLayoutViewController.GetFocusedRecordViewInfo: TcxGridCustomLayoutRecordViewInfo;
begin
  if FocusedRecord = nil then
    Result := nil
  else
    Result := TcxGridCustomLayoutRecordViewInfo(FocusedRecord.ViewInfo);
end;

function TcxGridCustomLayoutViewController.GetScrollDelta: Integer;
begin
  Result := Helper.GetScrollDelta;
end;

function TcxGridCustomLayoutViewController.GetViewData: TcxGridCustomLayoutViewViewData;
begin
  Result := TcxGridCustomLayoutViewViewData(inherited ViewData);
end;

function TcxGridCustomLayoutViewController.GetViewInfo: TcxGridCustomLayoutViewViewInfo;
begin
  Result := TcxGridCustomLayoutViewViewInfo(inherited ViewInfo);
end;

procedure TcxGridCustomLayoutViewController.SetScrollRecordViewInfo(Value: TcxGridCustomLayoutRecordViewInfo);
var
  AScrollDirection: TcxDirection;
begin
  if FScrollRecordViewInfo <> Value then
  begin
    AScrollDirection := ScrollDirection;
    ScrollDirection := dirNone;
    FScrollRecordViewInfo := Value;
    if FScrollRecordViewInfo <> nil then
      ScrollDirection := AScrollDirection;
  end;
end;

{ TcxGridCustomCardViewPainter }

procedure TcxGridCustomLayoutViewPainter.DrawBackground;
begin
  DrawSeparators;
  inherited;
end;

procedure TcxGridCustomLayoutViewPainter.DrawSeparators;
var
  I: Integer;
  R: TRect;
begin
  Canvas.Brush.Color := ViewInfo.SeparatorsViewInfo.Color;
  for I := 0 to ViewInfo.SeparatorsViewInfo.Count - 1 do
  begin
    R := ViewInfo.SeparatorsViewInfo[I];
    Canvas.FillRect(R);
    Canvas.ExcludeClipRect(R);
  end;
end;

procedure TcxGridCustomLayoutViewPainter.PaintContent;
begin
  DrawFilterBar;
  inherited;
end;

function TcxGridCustomLayoutViewPainter.GetViewInfo: TcxGridCustomLayoutViewViewInfo;
begin
  Result := TcxGridCustomLayoutViewViewInfo(inherited ViewInfo);
end;

{ TcxGridCustomLayoutRecordViewInfo }

class function TcxGridCustomLayoutRecordViewInfo.GetExpandButtonSize(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := ALookAndFeelPainter.GroupExpandButtonSize
end;

function TcxGridCustomLayoutRecordViewInfo.IsFullyVisible: Boolean;
begin
  Result := (inherited GetHeight <= RecordsViewInfo.MaxRecordHeight)
end;

function TcxGridCustomLayoutRecordViewInfo.GetRecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo;
begin
  Result := TcxGridCustomLayoutRecordsViewInfo(inherited RecordsViewInfo);
end;

function TcxGridCustomLayoutRecordViewInfo.GetVisible: Boolean;
begin
  Result := Index < RecordsViewInfo.PartVisibleCount;
end;

{ TcxGridCustomLayoutViewSeparatorsViewInfo }

constructor TcxGridCustomLayoutViewSeparatorsViewInfo.Create(AGridViewInfo: TcxGridCustomLayoutViewViewInfo);
begin
  inherited Create;
  FGridViewInfo := AGridViewInfo;
  CreateItems;
end;

destructor TcxGridCustomLayoutViewSeparatorsViewInfo.Destroy;
begin
  DestroyItems;
  inherited Destroy;
end;

procedure TcxGridCustomLayoutViewSeparatorsViewInfo.Calculate;
begin
  if RecordsViewInfo.Bands.VisibleCount > 0 then
    DoCalculate;
end;

procedure TcxGridCustomLayoutViewSeparatorsViewInfo.Clear;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    Dispose(PRect(FItems[I]));
  FItems.Clear;
end;

procedure TcxGridCustomLayoutViewSeparatorsViewInfo.DoCalculate;
begin
  Clear;
end;

function TcxGridCustomLayoutViewSeparatorsViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridCustomLayoutViewSeparatorsViewInfo.GetGridView: TcxGridCustomLayoutView;
begin
  Result := GridViewInfo.GridView;
end;

function TcxGridCustomLayoutViewSeparatorsViewInfo.GetItem(Index: Integer): TRect;
begin
  Result := PRect(FItems[Index])^;
end;

function TcxGridCustomLayoutViewSeparatorsViewInfo.GetRecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo;
begin
  Result := FGridViewInfo.RecordsViewInfo;
end;

function TcxGridCustomLayoutViewSeparatorsViewInfo.GetWidth: Integer;
begin
  Result := GridView.OptionsView.SeparatorWidth;
end;

procedure TcxGridCustomLayoutViewSeparatorsViewInfo.SetItem(Index: Integer; const Value: TRect);
var
  ARect: PRect;
begin
  if Index >= Count then
  begin
    New(ARect);
    FItems.Add(ARect);
  end;
  PRect(FItems[Index])^ := Value;
end;

procedure TcxGridCustomLayoutViewSeparatorsViewInfo.CreateItems;
begin
  FItems := TList.Create;
end;

procedure TcxGridCustomLayoutViewSeparatorsViewInfo.DestroyItems;
begin
  Clear;
  FreeAndNil(FItems);
end;

procedure TcxGridCustomLayoutViewSeparatorsViewInfo.Add(const R: TRect);
begin
  Items[Count] := R;
end;

function TcxGridCustomLayoutViewSeparatorsViewInfo.GetBounds: TRect;
begin
  Result := GridViewInfo.ClientBounds;
  InflateRect(Result, -RecordsViewInfo.RecordIndent, -RecordsViewInfo.RecordIndent);
end;

function TcxGridCustomLayoutViewSeparatorsViewInfo.GetColor: TColor;
begin
  Result := GridView.OptionsView.GetSeparatorColor;
end;

{ TcxGridCustomCardsViewInfoBasedCalculator }

constructor TcxGridCustomLayoutRecordsViewInfoBasedCalculator.Create(ARecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo);
begin
  inherited Create;
  FRecordsViewInfo := ARecordsViewInfo;
end;

procedure TcxGridCustomLayoutRecordsViewInfoBasedCalculator.AfterCalculate;
var
  I: Integer;
begin
  for I := 0 to RecordsViewInfo.Count - 1 do
    with Records[I] do
      if Visible and RecordsViewInfo.GridViewInfo.CalculateDown then
        MainCalculate(CalculationPosition.X, CalculationPosition.Y);
end;

procedure TcxGridCustomLayoutRecordsViewInfoBasedCalculator.BeforeCalculate;
begin
  RecordsViewInfo.Bands.Clear;
  RecordsViewInfo.FVisibleCount := 0;
  RecordsViewInfo.FPartVisibleCount := 0;
end;

procedure TcxGridCustomLayoutRecordsViewInfoBasedCalculator.Calculate(const AContentBounds: TRect);
begin
  BeforeCalculate;
  DoCalculate(AContentBounds);
  AfterCalculate;
end;

procedure TcxGridCustomLayoutRecordsViewInfoBasedCalculator.DoCalculate(const AContentBounds: TRect);
begin
end;

function TcxGridCustomLayoutRecordsViewInfoBasedCalculator.GetRecordIndent: Integer;
begin
  Result := RecordsViewInfo.RecordIndent;
end;

function TcxGridCustomLayoutRecordsViewInfoBasedCalculator.GetRecordSpaceHorz: Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfoBasedCalculator.GetRecordSpaceVert: Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfoBasedCalculator.GetSeparatorWidth: Integer;
begin
  Result := RecordsViewInfo.GetSeparatorWidth;
end;

function TcxGridCustomLayoutRecordsViewInfoBasedCalculator.GetMaxCount: Integer;
begin
  Result := RecordsViewInfo.MaxCount;
end;

function TcxGridCustomLayoutRecordsViewInfoBasedCalculator.GetMaxCoulumnCount: Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfoBasedCalculator.GetMaxRowCount: Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfoBasedCalculator.GetRecord(Index: Integer): TcxGridCustomLayoutRecordViewInfo;
begin
  Result := RecordsViewInfo.Items[Index];
end;

{ TcxGridCustomCardsViewInfoHorizontalCalculator }

procedure TcxGridCustomLayoutViewInfoHorizontalCalculator.DoCalculate(const AContentBounds: TRect);
var
  ALeftBound, ATopBound, ACol, ARow, I: Integer;
  ARecordViewInfo: TcxGridCustomLayoutRecordViewInfo;
  AMaxColumnCount, AMaxRowCount: Integer;
begin
  inherited;
  ACol := 0;
  ARow := 0;
  ALeftBound := AContentBounds.Left;
  ATopBound := AContentBounds.Top;

  AMaxColumnCount := GetMaxCoulumnCount;
  AMaxRowCount := GetMaxRowCount;

  for I := 0 to GetMaxCount - 1 do
  begin
    ARecordViewInfo := Records[I];
    if I <> 0 then
      if (ATopBound + ARecordViewInfo.Height > AContentBounds.Bottom) or ((AMaxRowCount > 0) and (ARow = AMaxRowCount))  then
      begin
        Inc(ACol);
        ARow := 0;
        Inc(ALeftBound, RecordsViewInfo.GetMaxRecordWidth(ACol - 1) + GetRecordSpaceHorz);
        if (ALeftBound >= RecordsViewInfo.Bounds.Right) or ((AMaxColumnCount > 0) and (ACol = AMaxColumnCount)) then Break;
        ATopBound := AContentBounds.Top;
      end;

    RecordsViewInfo.Bands[ACol][ARow] := ARecordViewInfo;
    if RecordsViewInfo.GridViewInfo.CalculateDown then
      ARecordViewInfo.CalculationPosition := Point(ALeftBound, ATopBound);

    if ((ALeftBound + ARecordViewInfo.Width <= RecordsViewInfo.Bounds.Right) or (ACol = 0)) then
      Inc(RecordsViewInfo.FVisibleCount);
    Inc(RecordsViewInfo.FPartVisibleCount);
    Inc(ARow);
    Inc(ATopBound, ARecordViewInfo.Height + GetRecordSpaceVert);
  end;
end;

function TcxGridCustomLayoutViewInfoHorizontalCalculator.GetRecordSpaceHorz: Integer;
begin
  Result := RecordsViewInfo.RecordIndent + GetSeparatorWidth + RecordsViewInfo.RecordIndent;
end;

function TcxGridCustomLayoutViewInfoHorizontalCalculator.GetRecordSpaceVert: Integer;
begin
  Result := RecordsViewInfo.RecordIndent + GetSeparatorWidth + RecordsViewInfo.RecordIndent;
end;

{ TcxGridCustomCardsViewInfoVerticalCalculator }

procedure TcxGridCustomLayoutViewInfoVerticalCalculator.DoCalculate(const AContentBounds: TRect);
var
  ALeftBound, ATopBound, ARowHeight, ACol, ARow, I: Integer;
  AIsVisibleCountCalculated: Boolean;
  ARecordViewInfo: TcxGridCustomLayoutRecordViewInfo;
  AMaxColumnCount, AMaxRowCount: Integer;

  procedure CalcVisibleCount;
  begin
    Inc(RecordsViewInfo.FPartVisibleCount);
    if not AIsVisibleCountCalculated then
      if (ARow = 0) or (ATopBound + Records[I].Height <= RecordsViewInfo.Bounds.Bottom) then
        Inc(RecordsViewInfo.FVisibleCount)
      else
      begin
        Dec(RecordsViewInfo.FVisibleCount, ACol);
        AIsVisibleCountCalculated := True;
      end;
  end;

begin
  inherited;
  ACol := 0;
  ARow := 0;
  ALeftBound := AContentBounds.Left;
  ATopBound := AContentBounds.Top;
  ARowHeight := 0;
  AIsVisibleCountCalculated := False;

  AMaxColumnCount := GetMaxCoulumnCount;
  AMaxRowCount := GetMaxRowCount;

  for I := 0 to GetMaxCount - 1 do
  begin
    ARecordViewInfo := Records[I];
    if I <> 0 then
      if (ALeftBound + ARecordViewInfo.Width > AContentBounds.Right) or ((AMaxColumnCount > 0) and (AMaxColumnCount = ACol)) then
      begin
        ACol := 0;
        Inc(ARow);
        ALeftBound := AContentBounds.Left;
        Inc(ATopBound, ARowHeight + GetRecordSpaceVert);
        if (ATopBound >= RecordsViewInfo.Bounds.Bottom) or ((AMaxRowCount > 0) and (AMaxRowCount = ARow)) then Break;
        ARowHeight := 0;
      end;

    RecordsViewInfo.Bands[ACol][ARow] := ARecordViewInfo;
    if RecordsViewInfo.GridViewInfo.CalculateDown then
      ARecordViewInfo.CalculationPosition := Point(ALeftBound, ATopBound);

    CalcVisibleCount;

    Inc(ACol);
    ARowHeight := Max(ARowHeight, ARecordViewInfo.Height);
    Inc(ALeftBound, ARecordViewInfo.Width + GetRecordSpaceHorz);
  end;
end;

function TcxGridCustomLayoutViewInfoVerticalCalculator.GetRecordSpaceHorz: Integer;
begin
  Result := RecordsViewInfo.RecordIndent + GetSeparatorWidth + RecordsViewInfo.RecordIndent;
end;

function TcxGridCustomLayoutViewInfoVerticalCalculator.GetRecordSpaceVert: Integer;
begin
  Result := RecordsViewInfo.RecordIndent + GetSeparatorWidth + RecordsViewInfo.RecordIndent;
end;

{ TcxGridCustomLayoutRecordsViewInfo }

constructor TcxGridCustomLayoutRecordsViewInfo.Create(AGridViewInfo: TcxCustomGridTableViewInfo);
begin
  inherited;
  FRecordHeight := -1;
  FBands := GetBandsClass.Create(Self);
end;

destructor TcxGridCustomLayoutRecordsViewInfo.Destroy;
begin
  FreeAndNil(FBands);
  inherited;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetRealItem(ARecord: TcxCustomGridRecord): TcxGridCustomLayoutRecordViewInfo;
begin
  Result := TcxGridCustomLayoutRecordViewInfo(inherited GetRealItem(ARecord));
end;

procedure TcxGridCustomLayoutRecordsViewInfo.Calculate;
begin
  FCalculator := GetCalculatorClass.Create(Self);
  try
    FRecordSpaceHorz := FCalculator.GetRecordSpaceHorz;
    FRecordSpaceVert := FCalculator.GetRecordSpaceVert;
    inherited Calculate;
    FRecordWidth := CalculateRecordWidth;
    FRecordHeight := CalculateRecordHeight;
    FMaxRecordHeight := CalculateMaxRecordHeight;
    FCalculator.Calculate(CalculateContentBounds);
  finally
    FCalculator.Free;
  end;
end;

function TcxGridCustomLayoutRecordsViewInfo.CalculateContentBounds: TRect;
begin
  Result := inherited CalculateContentBounds;
  InflateRect(Result, -RecordIndent, -RecordIndent);
end;

function TcxGridCustomLayoutRecordsViewInfo.GetItemLeftBound(AIndex: Integer): Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetItemsOffset(AItemCountDelta: Integer): Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetItemTopBound(AIndex: Integer): Integer;
begin
  Result := 0;
end;

procedure TcxGridCustomLayoutRecordsViewInfo.OffsetItem(AIndex, AOffset: Integer);
begin
end;

function TcxGridCustomLayoutRecordsViewInfo.CalculateRecordHeight: Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfo.CalculateRecordWidth: Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfo.CalculateMaxRecordHeight: Integer;
begin
  Result := 0;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetCalculatorClass: TcxGridCustomLayoutRecordsViewInfoBasedCalculatorClass;
begin
  Result := TcxGridCustomLayoutRecordsViewInfoBasedCalculator;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetBandsClass: TcxGridCustomLayoutViewBandsClass;
begin
  Result := TcxGridCustomLayoutViewBands;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetItemViewInfoClass: TcxGridCustomLayoutRecordViewInfoClass;
begin
  Result := TcxGridCustomLayoutRecordViewInfo;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetMaxRecordWidth(AColumn: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].Visible and (Items[I].Col = AColumn) then
      Result := Max(Result, Items[I].Width);
end;

function TcxGridCustomLayoutRecordsViewInfo.GetMaxRecordHeight(ARow: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].Visible and (Items[I].Row = ARow) then
      Result := Max(Result, Items[I].Height);
end;

function TcxGridCustomLayoutRecordsViewInfo.GetRecordIndent: Integer;
begin
  Result := GridView.OptionsView.Indent;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetSeparatorWidth: Integer;
begin
  Result := GridViewInfo.SeparatorsViewInfo.Width;
end;

function TcxGridCustomLayoutRecordsViewInfo.GetItem(Index: Integer): TcxGridCustomLayoutRecordViewInfo;
begin
  Result := TcxGridCustomLayoutRecordViewInfo(inherited Items[Index]);
end;

function TcxGridCustomLayoutRecordsViewInfo.GetGridView: TcxGridCustomLayoutView;
begin
  Result := TcxGridCustomLayoutView(inherited GridView);
end;

function TcxGridCustomLayoutRecordsViewInfo.GetGridViewInfo: TcxGridCustomLayoutViewViewInfo;
begin
  Result := TcxGridCustomLayoutViewViewInfo(inherited GridViewInfo);
end;

{ TcxGridCustomLayoutViewInfo }

function TcxGridCustomLayoutViewViewInfo.CanOffsetView(ARecordCountDelta: Integer): Boolean;
begin
  Result := False;
end;

procedure TcxGridCustomLayoutViewViewInfo.AfterCalculating;
begin
  inherited;
  SeparatorsViewInfo.Calculate;
end;

procedure TcxGridCustomLayoutViewViewInfo.BeforeCalculating;
begin
  RecreateViewInfos;
  FilterViewInfo.MainCalculate;
  inherited;
end;

procedure TcxGridCustomLayoutViewViewInfo.CreateViewInfos;
begin
  inherited;
  FSeparatorsViewInfo := GetSeparatorsViewInfoClass.Create(Self);
end;

procedure TcxGridCustomLayoutViewViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
  FreeAndNil(FSeparatorsViewInfo);
  inherited;
end;

function TcxGridCustomLayoutViewViewInfo.GetSeparatorsViewInfoClass: TcxGridCustomLayoutViewSeparatorsViewInfoClass;
begin
  Result := TcxGridCustomLayoutViewSeparatorsViewInfo;
end;

function TcxGridCustomLayoutViewViewInfo.GetGridView: TcxGridCustomLayoutView;
begin
  Result := TcxGridCustomLayoutView(inherited GridView);
end;

function TcxGridCustomLayoutViewViewInfo.GetRecordsViewInfo: TcxGridCustomLayoutRecordsViewInfo;
begin
  Result := TcxGridCustomLayoutRecordsViewInfo(inherited RecordsViewInfo);
end;

{ TcxGridCustomLayoutRecord }

constructor TcxGridCustomLayoutRecord.Create(AViewData: TcxCustomGridTableViewData; AIndex: Integer;
  const ARecordInfo: TcxRowInfo);
begin
  inherited;
  FExpanded := True;
end;

procedure TcxGridCustomLayoutRecord.DoCollapse(ARecurse: Boolean);
begin
  Expanded := False;
end;

procedure TcxGridCustomLayoutRecord.DoExpand(ARecurse: Boolean);
begin
  Expanded := True;
end;

function TcxGridCustomLayoutRecord.GetExpandable: Boolean;
begin
  Result := GridView.OptionsCustomize.Expandable;
end;

function TcxGridCustomLayoutRecord.GetExpanded: Boolean;
begin
  Result := not Expandable or FExpanded;
end;

function TcxGridCustomLayoutRecord.GetHasCells: Boolean;
begin
  Result := True;
end;

function TcxGridCustomLayoutRecord.GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  Result := TcxGridCustomLayoutViewInfoCacheItem;
end;

function TcxGridCustomLayoutRecord.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := GridView.ViewInfo.RecordsViewInfo.GetItemViewInfoClass;
end;

function TcxGridCustomLayoutRecord.GetGridView: TcxGridCustomLayoutView;
begin
  Result := TcxGridCustomLayoutView(inherited GridView);
end;

procedure TcxGridCustomLayoutRecord.SetExpanded(Value: Boolean);
begin
  if FExpanded <> Value then
  begin
    if FExpanded and Focused then
      GridView.Controller.FocusedItem := nil;
    FExpanded := Value;
    GridView.SizeChanged;
  end;
end;

{ TcxGridCustomLayoutViewOptionsCustomize }

procedure TcxGridCustomLayoutViewOptionsCustomize.Assign(Source: TPersistent);
begin
  if Source is TcxGridCustomLayoutViewOptionsCustomize then
    with Source as TcxGridCustomLayoutViewOptionsCustomize do
    begin
      Self.Expandable := Expandable;
    end;
  inherited;
end;

function TcxGridCustomLayoutViewOptionsCustomize.GetGridView: TcxGridCustomLayoutView;
begin
  Result := TcxGridCustomLayoutView(inherited GridView);
end;

procedure TcxGridCustomLayoutViewOptionsCustomize.SetExpandable(Value: Boolean);
begin
  if FExpandable <> Value then
  begin
    if Value then
      GridView.Controller.FocusedItem := nil;
    FExpandable := Value;
    Changed(vcSize);
  end;
end;

{ TcxGridCustomLayoutViewOptionsView }

constructor TcxGridCustomLayoutViewOptionsView.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FCaptionSeparator := cxGridCustomLayoutViewDefaultRecordCaptionSeparator;
  FIndent := cxGridCustomLayoutViewRecordDefaultIndent;
  FSeparatorColor := cxGridCustomLayoutViewSeparatorDefaultColor;
  FSeparatorWidth := cxGridCustomLayoutViewSeparatorDefaultWidth;
end;

procedure TcxGridCustomLayoutViewOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxGridCustomLayoutViewOptionsView then
    with Source as TcxGridCustomLayoutViewOptionsView do
    begin
      Self.CaptionSeparator := CaptionSeparator;
      Self.Indent := Indent;
      Self.SeparatorColor := SeparatorColor;
      Self.SeparatorWidth := SeparatorWidth;
    end;
  inherited;
end;

function TcxGridCustomLayoutViewOptionsView.GetSeparatorColor: TColor;
begin
  Result := SeparatorColor;
  if Result = cxGridCustomLayoutViewSeparatorDefaultColor then
    Result := LookAndFeelPainter.DefaultSeparatorColor;
end;

procedure TcxGridCustomLayoutViewOptionsView.SetCaptionSeparator(Value: Char);
begin
  if FCaptionSeparator <> Value then
  begin
    FCaptionSeparator := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridCustomLayoutViewOptionsView.SetIndent(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FIndent <> Value then
  begin
    FIndent := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridCustomLayoutViewOptionsView.SetSeparatorColor(Value: TColor);
begin
  if FSeparatorColor <> Value then
  begin
    FSeparatorColor := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridCustomLayoutViewOptionsView.SetSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FSeparatorWidth <> Value then
  begin
    FSeparatorWidth := Value;
    Changed(vcLayout);
  end;
end;

{ TcxGridCustomLayoutView }

function TcxGridCustomLayoutView.GetControllerClass: TcxCustomGridControllerClass;
begin
  Result := TcxGridCustomLayoutViewController;
end;

function TcxGridCustomLayoutView.GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass;
begin
  Result := TcxGridCustomLayoutViewOptionsCustomize;
end;

function TcxGridCustomLayoutView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxGridCustomLayoutViewOptionsView;
end;

function TcxGridCustomLayoutView.GetPainterClass: TcxCustomGridPainterClass;
begin
  Result := TcxGridCustomLayoutViewPainter;
end;

function TcxGridCustomLayoutView.GetViewDataClass: TcxCustomGridViewDataClass;
begin
  Result := TcxGridCustomLayoutViewViewData;
end;

function TcxGridCustomLayoutView.GetViewInfoClass: TcxCustomGridViewInfoClass;
begin
  Result := TcxGridCustomLayoutViewViewInfo;
end;

procedure TcxGridCustomLayoutView.Reposition;
begin
  ViewInfo.RecordsViewInfo.Calculate;
  Invalidate(False);
end;

function TcxGridCustomLayoutView.GetOptionsCustomize: TcxGridCustomLayoutViewOptionsCustomize;
begin
  Result := TcxGridCustomLayoutViewOptionsCustomize(inherited OptionsCustomize);
end;

function TcxGridCustomLayoutView.GetOptionsView: TcxGridCustomLayoutViewOptionsView;
begin
  Result := TcxGridCustomLayoutViewOptionsView(inherited OptionsView);
end;

function TcxGridCustomLayoutView.GetViewInfo: TcxGridCustomLayoutViewViewInfo;
begin
  Result := TcxGridCustomLayoutViewViewInfo(inherited ViewInfo);
end;

procedure TcxGridCustomLayoutView.SetOptionsCustomize(Value: TcxGridCustomLayoutViewOptionsCustomize);
begin
  inherited OptionsCustomize := Value;
end;

procedure TcxGridCustomLayoutView.SetOptionsView(Value: TcxGridCustomLayoutViewOptionsView);
begin
  inherited OptionsView := Value;
end;

end.
