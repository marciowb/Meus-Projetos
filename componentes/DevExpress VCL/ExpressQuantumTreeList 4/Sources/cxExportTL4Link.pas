
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
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

unit cxExportTL4Link;

{$I cxVer.inc}

interface
uses
  Windows, Graphics, cxGeometry, {$IFDEF DELPHI6} Variants, {$ENDIF}
  cxEdit, cxCalendar, cxCurrencyEdit, cxSpinEdit, cxCalc, cxTimeEdit, cxDataUtils,
  SysUtils, Classes, cxClasses, cxGraphics, cxStyles, cxInplaceContainer, 
  cxTL, cxExport, cxXLSExport, cxHtmlXmlTxtExport, cxTLStrs, dxCore;

procedure cxExportTL4ToHTML(const AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'html');
procedure cxExportTL4ToXML(const AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'xml');
procedure cxExportTL4ToExcel(const AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExpand: Boolean = True; ASaveAll: Boolean = True; AUseNativeFormat: Boolean = True;
  const AFileExt: string = 'xls');
procedure cxExportTL4ToText(const AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const ASeparator: string = '';
  const ABeginString: string = ''; const AEndString: string = '';
  const AFileExt: string = 'txt');
procedure cxExportTL4ToFile(AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExportType: Integer; AExpand, ASaveAll, AUseNativeFormat: Boolean; const ASeparators: array of string;
  const AFileExt: string);

implementation

type
  TcxBandAccess = class(TcxTreeListBand);
  TcxBandViewInfoAccess = class(TcxTreeListBandViewInfo);
  TcxColumnAccess = class(TcxTreeListColumn);
  TcxNodeAccess = class(TcxTreeListNode);
  TcxTreeListAccess = class(TcxCustomTreeListControl);
  TcxViewInfoAccess = class(TcxTreeListViewInfo);
  TcxStylesAccess = class(TcxTreeListStyles);
  TcxPropertiesAccess = class(TcxCustomEditProperties);

  { TcxTreeListNodeItarationHandler }

  TcxTreeListNodeItarationHandler = procedure(ANode: TcxTreeListNode) of object;

  TcxTreeListExportHelper = class;

  TcxTreeListMapsInfo = class;
  TcxTreeListMapsInfoClass = class of TcxTreeListMapsInfo;
  
  TcxMapInfoHelperList = class;

  TcxInfoItemClass = class of TcxInfoItem;

  { TcxInfoItem }

  TcxTreeListCellsMap = array of array of Integer;

  TcxInfoItem = class
  private
    function GetProvider: IcxExportProvider;
  protected
    function GridLines: Boolean;
    procedure RegisterStyles; virtual;
    property Provider: IcxExportProvider read GetProvider;
  public
    AbsolutePosition: TRect;
    Data: TObject;
    Owner: TcxMapInfoHelperList;
    Position: TRect;
    constructor Create(AOwner: TcxMapInfoHelperList); virtual;
  end;

  { TcxMapInfoHelperList }

  TcxMapInfoHelperList = class
  private
    FOwner: TObject;
    function GetItem(Index: Integer): TcxInfoItem;
    function GetDimension: TSize;
  protected
    CellsMap: TcxTreeListCellsMap;
    HorzList: TList;
    ItemCapacity: Integer;
    ItemCount: Integer;
    ItemsList: PPointerList;
    VertList: TList;
    procedure CalculateCellsMap;
    procedure Clear; virtual;
    function CreateList(const AItems: array of Pointer; ACapacity: Integer = -1): TList; 
    function GetOwner: TObject; virtual;
    function GetProvider: IcxExportProvider; virtual;
    function GridLines: Boolean; virtual;
    function UseItemForFillMap(AItem: TcxInfoItem): Boolean; virtual;
    property Count: Integer read ItemCount;
    property Items[Index: Integer]: TcxInfoItem read GetItem;
  public
    constructor Create(AOwner: TObject; AItemsCount: Integer); virtual;
    destructor Destroy; override;
    function AddItem(const AbsolutePosition: TRect;
      Data: TObject; AItemClass: TcxInfoItemClass): TcxInfoItem;
    procedure Calculate; virtual;
    property Dimension: TSize read GetDimension;
  end;

  { TcxTreeListMapInfoList }

  TcxIndentInfoItem = class(TcxInfoItem)
  private
    function GetLevel: Integer;
  public
    property Level: Integer read GetLevel;
  end;

  { TcxBandInfoItem }

  TcxBandInfoItem = class(TcxInfoItem)
  private
    function GetBand: TcxBandAccess;
    function GetBands: Boolean;
    function GetHeaderText: string;
    function GetTreeList: TcxTreeListAccess;
  protected
    procedure RegisterStyles; override;
  public
    CaptionStyleIndex: Integer;
    HeaderStyleIndex: Integer;
    property Band: TcxBandAccess read GetBand;
    property Bands: Boolean read GetBands;
    property HeaderText: string read GetHeaderText;
    property TreeList: TcxTreeListAccess read GetTreeList;
  end;

  { TcxColumnInfoItem }

  TcxColumnInfoItem = class(TcxInfoItem)
  private
    function GetColumn: TcxColumnAccess;
    function GetFooter: Boolean;
    function GetFooterText: string;
    function GetHeader: Boolean;
    function GetHeaderText: string;
    function GetTreeList: TcxTreeListAccess;
  protected
    procedure RegisterStyles; override;
  public
    HeaderStyleIndex: Integer;
    FooterStyleIndex: Integer;
    property Column: TcxColumnAccess read GetColumn;
    property Footer: Boolean read GetFooter;
    property FooterText: string read GetFooterText;
    property Header: Boolean read GetHeader;
    property HeaderText: string read GetHeaderText;
    property TreeList: TcxTreeListAccess read GetTreeList;
  end;

  { TcxTreeListMapInfoList }

  TcxTreeListMapInfoList = class(TcxMapInfoHelperList)
  private
    FBandsList: TList;
    FColumnsList: TList;
    FIndentsList: TList;
    function GetBandCount: Integer;
    function GetBandInfo(Index: Integer): TcxBandInfoItem;
    function GetColumnCount: Integer;
    function GetColumnInfo(Index: Integer): TcxColumnInfoItem;
    function GetIndentCount: Integer;
    function GetIndentInfo(Index: Integer): TcxIndentInfoItem;
    function GetInfoOwner: TcxTreeListMapsInfo;
  protected
    function UseItemForFillMap(AItem: TcxInfoItem): Boolean; override;
    function GetProvider: IcxExportProvider; override;
    function GridLines: Boolean; override;
    property Owner: TcxTreeListMapsInfo read GetInfoOwner;
  public
    constructor Create(AOwner: TObject; AItemsCount: Integer); override;
    destructor Destroy; override;
    procedure Calculate; override;
    function CloneMap: TcxTreeListCellsMap; virtual;
    property BandCount: Integer read GetBandCount;
    property Bands[Index: Integer]: TcxBandInfoItem read GetBandInfo;
    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TcxColumnInfoItem read GetColumnInfo;
    property IndentCount: Integer read GetIndentCount;
    property Indents[Index: Integer]: TcxIndentInfoItem read GetIndentInfo;
  end;

  { TcxPreviewInfo }

  TcxPreviewInfoItem = class
  protected
    Next: TcxPreviewInfoItem;
  public
    Alignment: TcxAlignText;
    Node: TcxTreeListNode;
    Level: Integer;
    Value: Variant;
    Height: Integer;
    ViewParams: TcxViewParams;
    constructor Create(var AFirst, ALast: TcxPreviewInfoItem); virtual;
    procedure SetData(ANode: TcxTreeListNode; ALevel: Integer; AHeight: Integer;
      const AValue: Variant; const AViewParams: TcxViewParams; AAlign: TcxAlignText);
  end;

  { TcxTreeListMapInfo }

  TcxTreeListMapsInfo = class
  private
    FSize: TSize;
    FMaxLevel: Integer;
    FOwner: TcxTreeListExportHelper;
    function GetBandLineHeight: Integer;
    function GetBands: Boolean;
    function GetFooter: Boolean;
    function GetFooters(AColumn: TcxTreeListColumn): Boolean;
    function GetGridLines: Boolean;
    function GetHeaderLineHeight: Integer;
    function GetHeaders: Boolean;
    function GetNodeCellsCount: Integer;
    function GetPreview: Boolean;
    function GetPreviewAutoHeight: Boolean;
    function GetProvider: IcxExportProvider;
    function GetTreeList: TcxTreeListAccess;
    function GetVertInc: Integer;
    procedure AddColumnsFromBand(var AOfs: Integer; ABand: TcxTreeListBand);
  protected
    ConentCellsRowCount: Integer;
    MultiEditRowCount: Integer;
    TotalWidth: Integer;
    PreviewList,
    CurPreviewInfo,
    PreviewListLast,
    GroupList,
    CurGroupInfo,
    GroupListLast: TcxPreviewInfoItem;
    Position: Integer;
    HeaderInfoList: TcxTreeListMapInfoList;
    HeaderMap: TcxTreeListCellsMap;
    FooterMap: TcxTreeListCellsMap;
    function AddGroupInfo: TcxPreviewInfoItem;
    function AddPreviewInfo: TcxPreviewInfoItem;
    procedure CalculateSize;
    procedure CheckNodeBeforeCalculate(ANode: TcxTreeListNode); virtual;
    procedure ClearList(AList: TcxPreviewInfoItem);
    procedure CloneMaps; virtual;
    function CountItems(AList: TcxPreviewInfoItem): Integer;
    procedure CreateHeaderInfo; virtual;
    procedure DoCalculate; virtual;
    procedure DoWrite; virtual;
    procedure DoWriteColumnWidths; virtual;
    procedure DoWriteContent; virtual;
    procedure DoWriteFooter; virtual;
    procedure DoWriteHeader; virtual;
    procedure DoWriteItem(const APosition: TRect; AStyleIndex: Integer; const AText: string);
    procedure DoWriteNode(ANode: TcxTreeListNode); virtual;
    procedure DoWriteNodeGroup(ANode: TcxTreeListNode; AInfo: TcxPreviewInfoItem);
    procedure DoWriteNodeIndents(ANode: TcxTreeListNode; AStartPos: Integer); virtual;
    procedure DoWriteNodeMultiEdit(ANode: TcxTreeListNode); virtual;
    procedure DoWriteNodePreview(ANode: TcxTreeListNode; AInfo: TcxPreviewInfoItem);
    procedure DoWritePreviewInfo(AInfo: TcxPreviewInfoItem); virtual;
    procedure DoWriteRect(ARect: TRect;
      const AParams: TcxViewParams; ABorders: TcxBorders = cxBordersAll);
    procedure DoWriteUnionRect(const ARect: TRect; const AParams: TcxViewParams;
      Align: TcxAlignText; ABorders: TcxBorders = cxBordersAll);
    function GetDisplayText(AIndex: Integer; ANode: TcxTreeListNode; AProperties: TcxCustomEditProperties): string;
    function GetDisplayValue(AIndex: Integer; ANode: TcxTreeListNode; AProperties: TcxCustomEditProperties): Variant;
    function GetIndentStyle(AColor: TColor; ABorders: TcxBorders): TcxCacheCellStyle;
    function GetNodeItemDisplayValue(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; var Align: TcxAlignText): Variant;
    function IsGroupNode(ANode: TcxTreeListNode; var AInfo: TcxPreviewInfoItem): Boolean;
    function IsHasPreview(ANode: TcxTreeListNode; var AInfo: TcxPreviewInfoItem): Boolean;
    function IsNativeFormatProperties(AProperties: TcxCustomEditProperties): Boolean;
    procedure ValidateMaps; virtual;
    property BandLineHeight: Integer read GetBandLineHeight;
    property Bands: Boolean read GetBands;
    property HeaderLineHeight: Integer read GetHeaderLineHeight;
    property Headers: Boolean read GetHeaders;
    property GridLines: Boolean read GetGridLines;
    property Footer: Boolean read GetFooter;
    property Footers[AColumn: TcxTreeListColumn]: Boolean read GetFooters;
    property NodeCellsCount: Integer read GetNodeCellsCount;
    property Owner: TcxTreeListExportHelper read FOwner;
    property Preview: Boolean read GetPreview;
    property PreviewAutoHeight: Boolean read GetPreviewAutoHeight;
    property Provider: IcxExportProvider read GetProvider;
    property Size: TSize read FSize;
    property VertInc: Integer read GetVertInc;
  public
    constructor Create(AOwner: TcxTreeListExportHelper); virtual;
    destructor Destroy; override;
    property MaxLevel: Integer read FMaxLevel;
    property TreeList: TcxTreeListAccess read GetTreeList;
  end;

  { TcxTreeListExportHelper }

  TcxTreeListExportHelper = class
  private
    FProvider: IcxExportProvider;
    FExpand: Boolean;
    FExportSelection: Boolean;
    FIsNativeFormat: Boolean;
    FSelectionList: TList;
    FTreeList: TcxTreeListAccess;
    function AddToSelection(ANode: TcxTreeListNode): Boolean;
    procedure CreateSelectionList;
    procedure SetExportSelection(Value: Boolean);
  protected
    MapsInfo: TcxTreeListMapsInfo;
    procedure CallIterationProc(ANode: TcxTreeListNode;
      AIndex: Integer; AProc: TcxTreeListNodeItarationHandler); virtual;
    procedure DoCalculateTableMap; virtual;
    procedure DoWriteCells; virtual;
    procedure DoIterate(AProc: TcxTreeListNodeItarationHandler);
    procedure DoIterateAllNodes(AProc: TcxTreeListNodeItarationHandler); virtual;
    procedure DoIterateSelectionNodes(AProc: TcxTreeListNodeItarationHandler); virtual;
    function GetMapsInfoClass: TcxTreeListMapsInfoClass; virtual;
  public
    constructor Create(ATreeList: TcxCustomTreeListControl;
      AExportType: Integer; const AFileName: string); virtual;
    destructor Destroy; override;
    property Expand: Boolean read FExpand write FExpand;
    property ExportSelection: Boolean read FExportSelection write SetExportSelection;
    property IsNativeFormat: Boolean read FIsNativeFormat;
    property Provider: IcxExportProvider read FProvider;
    property TreeList: TcxTreeListAccess read FTreeList;
  end;

const
  cxInvalidIndex       = -1;
  cxIndentFontName     = 'Tahoma';
  cxCellBorders: array[Boolean] of TcxBorders = ([], cxBordersAll);
  cxIndentStyle: TcxCacheCellStyle =
  ( AlignText: catCenter;
    FontStyle: [];
    FontColor: 0;
    FontSize: 12;
    FontCharset: 0;
    BrushStyle: cbsSolid);

// todo: need move to cxExport for Delphi 4
  AlignToCxAlign: array[TAlignment] of TcxAlignText =
    (catLeft, catRight, catCenter);
  cxUsedBorder: TcxCellBorders = (IsDefault: False; Width: 1);
  cxEmptyBorder: TcxCellBorders = (IsDefault: True; Width: 0);

// todo: need move to cxInplaceContainer for Delphi 4
function Supports(const Instance: IUnknown; const IID: TGUID; out Intf): Boolean; overload;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(IID, Intf) = 0);
end;

function cxNodesCompare(AItem1, AItem2: TcxTreeListNode): Integer;
var
  ALevel1, ALevel2: Integer;
begin
  ALevel1 := AItem1.Level;
  ALevel2 := AItem2.Level;
  if AItem1.Parent = AItem2.Parent then
    Result := AItem1.Index - AItem2.Index
  else
    if AItem1.HasAsParent(AItem2) then
      Result := 1
    else
      if AItem2.HasAsParent(AItem1) then
        Result := -1
      else
      begin
        while ALevel2 > ALevel1 do
        begin
          AItem2 := AItem2.Parent;
          Dec(ALevel2);
        end;
        while ALevel1 > ALevel2 do
        begin
          AItem1 := AItem1.Parent;
          Dec(ALevel1);
        end;
        while AItem1.Parent <> AItem2.Parent do
        begin
          AItem1 := AItem1.Parent;
          AItem2 := AItem2.Parent;
        end;
        Result := AItem1.Index - AItem2.Index;
      end;
end;

function cxCompareCoordinates(AItem1, AItem2: Pointer): Integer;
begin
  Result := Integer(AItem1) - Integer(AItem2);
end;

function cxGetCellBorders(ACol, ARow: Integer; const Bounds: TRect): TcxBorders;
begin
  Result := [];
  if ACol = Bounds.Left then Include(Result, bLeft);
  if ARow = Bounds.Top then Include(Result, bTop);
  if ACol = Bounds.Right then Include(Result, bRight);
  if ARow = Bounds.Bottom then Include(Result, bBottom);
end;

function cxCheckBorder(var ABorder: TcxCellBorders; NeedSet: Boolean; Color: Integer): Boolean;
begin
  Result := NeedSet;
  if NeedSet then
  begin
    ABorder := cxUsedBorder;
    ABorder.Color := Color;
  end
  else
    ABorder := cxEmptyBorder;
end;

function cxSetStyleBorders(const AStyle: TcxCacheCellStyle; ACol, ARow: Integer;
  const ABounds: TRect; const AColor: Integer; HasBorders: TcxBorders = cxBordersAll): TcxCacheCellStyle;
begin
  Result := AStyle;
  with Result, ABounds do
  begin
    cxCheckBorder(Borders[0], (ACol = Left) and (bLeft in HasBorders), AColor);
    cxCheckBorder(Borders[1], (ARow = Top) and (bTop in HasBorders), AColor);
    cxCheckBorder(Borders[2], (ACol = Right) and (bRight in HasBorders), AColor);
    cxCheckBorder(Borders[3], (ARow = Bottom) and (bBottom in HasBorders), AColor);
  end;
end;

procedure cxViewParamsToCacheStyle(
  AViewParams: TcxViewParams; var ACacheStyle: TcxCacheCellStyle);
begin
  ACacheStyle := DefaultCellStyle;
  with ACacheStyle do
  begin
    FillChar(FontName, SizeOf(FontName), 0);
    dxStringToBytes(AViewParams.Font.Name, FontName);
    FontStyle := TcxFontStyles(AViewParams.Font.Style);
    FontColor := ColorToRgb(AViewParams.TextColor);
    FontSize := AViewParams.Font.Size;
    FontCharset := AViewParams.Font.Charset;
    BrushStyle := cbsSolid;
    BrushBkColor := ColorToRgb(AViewParams.Color);
    BrushFgColor := BrushBkColor;
  end;
end;

function cxRegisterViewParams(AViewParams: TcxViewParams;
  Align: TcxAlignText; Provider: IcxExportProvider): Integer; overload;
var
  AStyle: TcxCacheCellStyle;
begin
  cxViewParamsToCacheStyle(AViewParams, AStyle);
  AStyle.AlignText := Align;
  Result := Provider.RegisterStyle(AStyle)
end;

function cxRegisterViewParams(AViewParams: TcxViewParams; Align: TcxAlignText;
  Provider: IcxExportProvider; ABorders: TcxBorders): Integer; overload;
var
  I: Integer;
  AStyle: TcxCacheCellStyle;
begin
  cxViewParamsToCacheStyle(AViewParams, AStyle);
  AStyle.AlignText := Align;
  for I := 0 to 3 do
    cxCheckBorder(AStyle.Borders[I], TcxBorder(I) in ABorders, cxBtnShadowColor);
  Result := Provider.RegisterStyle(AStyle)
end;

function cxCheckBorders(ACol, ARow: Integer;
  const ARect: TRect; ABorders: TcxBorders): TcxBorders;
begin
  Result := [];
  with ARect do
  begin
    if (ACol = Left) and (bLeft in ABorders) then Include(Result, bLeft);
    if (ARow = Top) and (bTop in ABorders) then Include(Result, bTop);
    if (ACol = Right) and (bRight in ABorders) then Include(Result, bRight);
    if (ARow = Bottom) and (bBottom in ABorders) then Include(Result, bBottom);
  end;
end;

function cxRegisterStyleHeader(AViewInfo: TcxtreeListViewInfoItem;
  AlignHorz: TAlignment; Provider: IcxExportProvider; ABorders: TcxBorders): Integer;
var
  AStyle: TcxCacheCellStyle;
begin
  cxViewParamsToCacheStyle(AViewInfo.ViewParams, AStyle);
  if ABorders <> [] then
    AStyle := cxSetStyleBorders(AStyle, 0, 0, cxNullRect, cxBtnShadowColor, ABorders);
  AStyle.AlignText := AlignToCxAlign[AlignHorz];
  Result := Provider.RegisterStyle(AStyle);
end;

procedure cxFillMapItem(AMap: TcxTreeListCellsMap; AInfo: TcxInfoItem;
  ACheckValue: Boolean = False);
var
  I, J: Integer;
begin
  with AInfo.Position do
  begin
    for I := Left to Right - 1 do
      for J := Top to Bottom - 1 do
        if (AMap[I, J] = 0) or not ACheckValue then AMap[I, J] := Integer(AInfo);
  end;
end;

function cxCreateMap(const ASize: TSize): TcxTreeListCellsMap;
begin
  SetLength(Result, ASize.cx, ASize.cy);
end;

{ TcxInfoItem }

constructor TcxInfoItem.Create(AOwner: TcxMapInfoHelperList);
begin
  Owner := AOwner;
end;

function TcxInfoItem.GridLines: Boolean;
begin
  Result := Owner.GridLines;
end;

procedure TcxInfoItem.RegisterStyles;
begin
end;

function TcxInfoItem.GetProvider: IcxExportProvider;
begin
  Result := Owner.GetProvider;
end;

{ TcxMapInfoHelperList }

constructor TcxMapInfoHelperList.Create(AOwner: TObject; AItemsCount: Integer);
begin
  FOwner := AOwner;
  HorzList := CreateList([nil], AItemsCount + 1);
  VertList := CreateList([nil], AItemsCount + 1);
  ItemCapacity := AItemsCount;
  ItemsList := AllocMem(ItemCapacity * SizeOf(Pointer));
end;

destructor TcxMapInfoHelperList.Destroy;
begin
  try
    FreeAndNil(HorzList);
    FreeAndNil(VertList);
    Clear;
  finally
    inherited Destroy;
  end;
end;

function TcxMapInfoHelperList.AddItem(const AbsolutePosition: TRect;
  Data: TObject; AItemClass: TcxInfoItemClass): TcxInfoItem;
begin
  Result := AItemClass.Create(Self);
  Result.AbsolutePosition := AbsolutePosition;
  Result.Data := Data; 
  ItemsList^[ItemCount] := Result;
  Inc(ItemCount);
  with AbsolutePosition do
  begin
    if HorzList.IndexOf(Pointer(Right)) = cxInvalidIndex then
      HorzList.Add(Pointer(Right));
    if VertList.IndexOf(Pointer(Bottom)) = cxInvalidIndex then
      VertList.Add(Pointer(Bottom));
  end;
end;

procedure TcxMapInfoHelperList.Calculate;
var
  I: Integer;

  function RealPosFromAbsPos(X1, Y1, X2, Y2: Integer): TRect;
  begin
    Result.Left := HorzList.IndexOf(Pointer(X1));
    Result.Top := VertList.IndexOf(Pointer(Y1));
    Result.Right := HorzList.IndexOf(Pointer(X2));
    Result.Bottom := VertList.IndexOf(Pointer(Y2));
  end;

begin
  HorzList.Sort(cxCompareCoordinates);
  VertList.Sort(cxCompareCoordinates);
  for I := 0 to ItemCount - 1 do
    with TcxInfoItem(ItemsList^[I]), AbsolutePosition do
      Position := RealPosFromAbsPos(Left, Top, Right, Bottom);
  CalculateCellsMap;
end;

procedure TcxMapInfoHelperList.Clear;
var
  I: Integer;
begin
  try
    for I := 0 to ItemCount - 1 do
      FreeAndNil(TcxInfoItem(ItemsList^[I]));
    FreeMem(ItemsList);
  finally
    ItemCount := 0;
    ItemsList := nil;
  end;
end;

procedure TcxMapInfoHelperList.CalculateCellsMap;
var
  I: Integer;
begin
  CellsMap := cxCreateMap(Dimension);
  for I := 0 to Count - 1 do
    if UseItemForFillMap(Items[I]) then cxFillMapItem(CellsMap, Items[I]);
end;

function TcxMapInfoHelperList.CreateList(
  const AItems: array of Pointer; ACapacity: Integer = -1): TList;
var
  I: Integer;
begin
  Result := TList.Create;
  if ACapacity <> cxInvalidIndex then
    Result.Capacity := ACapacity;
  if Length(AItems) <> 0 then
    for I := Low(AItems) to High(AItems) do Result.Add(AItems[I]); 
end;

function TcxMapInfoHelperList.GetOwner: TObject;
begin
  Result := FOwner;
end;

function TcxMapInfoHelperList.GetProvider: IcxExportProvider;
begin
  Result := nil;
end;

function TcxMapInfoHelperList.GridLines: Boolean;
begin
  Result := False;
end;

function TcxMapInfoHelperList.UseItemForFillMap(AItem: TcxInfoItem): Boolean;
begin
  Result := True;
end;

function TcxMapInfoHelperList.GetItem(Index: Integer): TcxInfoItem;
begin
  Result := TcxInfoItem(ItemsList^[Index])
end;

function TcxMapInfoHelperList.GetDimension: TSize;
begin
  Result.cx := HorzList.Count - 1;
  Result.cy := VertList.Count - 1;
end;

{ TcxTreeListMapInfoList }

function TcxIndentInfoItem.GetLevel: Integer;
begin
  Result := Integer(Data);
end;

{ TcxBandInfoItem }

procedure TcxBandInfoItem.RegisterStyles;
begin
  with Band, TcxBandViewInfoAccess(ViewInfo) do
  begin
    if Self.Bands then
      CaptionStyleIndex := cxRegisterStyleHeader(BandHeader, Caption.AlignHorz,
        Provider, cxCellBorders[Self.GridLines]);
    if Self.TreeList.OptionsView.Headers and not IsOpaque then
      HeaderStyleIndex := cxRegisterViewParams(ContainerViewParams, catLeft, Provider);
  end;
end;

function TcxBandInfoItem.GetBand: TcxBandAccess;
begin
  Result := TcxBandAccess(Data)
end;

function TcxBandInfoItem.GetBands: Boolean;
begin
  Result := TreeList.OptionsView.Bands;
end;

function TcxBandInfoItem.GetHeaderText: string;
begin
  Result := Band.ViewInfo.BandHeader.Text; 
end;

function TcxBandInfoItem.GetTreeList: TcxTreeListAccess;
begin
  Result := TcxTreeListAccess(Band.TreeList);
end;

{ TcxColumnInfoItem }

procedure TcxColumnInfoItem.RegisterStyles;
begin
  with Column, ViewInfo do
  begin
    if Self.Header then
      HeaderStyleIndex := cxRegisterStyleHeader(ColumnHeader, Caption.AlignHorz,
        Provider, cxCellBorders[GridLines]);
    if Self.Footer then
      FooterStyleIndex := cxRegisterStyleHeader(ColumnFooter,
        SummaryFooter.AlignHorz, Provider, cxCellBorders[GridLines]);
  end;
end;

function TcxColumnInfoItem.GetColumn: TcxColumnAccess;
begin
  Result := TcxColumnAccess(Data);
end;

function TcxColumnInfoItem.GetFooter: Boolean;
begin
  Result := TreeList.OptionsView.Footer and Column.Options.Footer;
end;

function TcxColumnInfoItem.GetFooterText: string;
begin
  Result := Column.ViewInfo.ColumnFooter.Text;
end;

function TcxColumnInfoItem.GetHeader: Boolean;
begin
  Result := TreeList.OptionsView.Headers;
end;

function TcxColumnInfoItem.GetHeaderText: string;
begin
  Result := Column.ViewInfo.ColumnHeader.Text;
end;

function TcxColumnInfoItem.GetTreeList: TcxTreeListAccess;
begin
  Result := TcxTreeListAccess(Column.TreeList);
end;

{ TcxTreeListMapInfoList }

constructor TcxTreeListMapInfoList.Create(AOwner: TObject; AItemsCount: Integer);
begin
  inherited Create(AOwner, AItemsCount);
  FBandsList := TList.Create;
  FColumnsList := TList.Create;
  FIndentsList := TList.Create;
end;

destructor TcxTreeListMapInfoList.Destroy;
begin
  FBandsList.Free;
  FColumnsList.Free;
  FIndentsList.Free;
  inherited Destroy;
end;

procedure TcxTreeListMapInfoList.Calculate;
var
  I: Integer;
begin
  inherited Calculate;
  for I := 0 to ItemCount - 1 do
  begin
    if TObject(ItemsList^[I]) is TcxIndentInfoItem then
      FIndentsList.Add(ItemsList^[I])
    else
      if TObject(ItemsList^[I]) is TcxColumnInfoItem then
        FColumnsList.Add(ItemsList^[I])
      else
        if TObject(ItemsList^[I]) is TcxBandInfoItem then
          FBandsList.Add(ItemsList^[I])
  end;
end;

function TcxTreeListMapInfoList.CloneMap: TcxTreeListCellsMap;
var
  I: Integer;
begin
  Result := cxCreateMap(Dimension);
  with Dimension do
  begin
    for I := 0 to cx - 1 do
      Move(CellsMap[I, 0], Result[I, 0], cy * SizeOf(Integer));
  end;
end;

function TcxTreeListMapInfoList.UseItemForFillMap(AItem: TcxInfoItem): Boolean;
begin
  Result := not (AItem is TcxIndentInfoItem);
end;

function TcxTreeListMapInfoList.GetProvider: IcxExportProvider;
begin
  Result := Owner.Owner.FProvider;
end;

function TcxTreeListMapInfoList.GridLines: Boolean;
begin
  Result := Owner.GetGridLines;
end;

function TcxTreeListMapInfoList.GetBandCount: Integer;
begin
  Result := FBandsList.Count;
end;

function TcxTreeListMapInfoList.GetBandInfo(Index: Integer): TcxBandInfoItem;
begin
  Result := TcxBandInfoItem(FBandsList.List^[Index]);
end;

function TcxTreeListMapInfoList.GetColumnCount: Integer;
begin
  Result := FColumnsList.Count;
end;

function TcxTreeListMapInfoList.GetColumnInfo(Index: Integer): TcxColumnInfoItem;
begin
  Result := TcxColumnInfoItem(FColumnsList.List^[Index]);
end;

function TcxTreeListMapInfoList.GetIndentCount: Integer;
begin
  Result := FIndentsList.Count;
end;

function TcxTreeListMapInfoList.GetIndentInfo(Index: Integer): TcxIndentInfoItem;
begin
  Result := TcxIndentInfoItem(FIndentsList.List^[Index]);
end;

function TcxTreeListMapInfoList.GetInfoOwner: TcxTreeListMapsInfo;
begin
  Result := TcxTreeListMapsInfo(GetOwner);
end;

{ TcxPreviewInfoItem }

constructor TcxPreviewInfoItem.Create(var AFirst, ALast: TcxPreviewInfoItem);
begin
  if AFirst = nil then
    AFirst := Self
  else
    ALast.Next := Self;
  ALast := Self;
end;

procedure TcxPreviewInfoItem.SetData(
  ANode: TcxTreeListNode; ALevel: Integer; AHeight: Integer;
  const AValue: Variant; const AViewParams: TcxViewParams; AAlign: TcxAlignText);
begin
  Alignment := AAlign;
  Node := ANode;
  Level := ALevel;
  Value := AValue;
  Height := AHeight;
  ViewParams := AViewParams;
end;

{ TcxTreeListMapInfo }

constructor TcxTreeListMapsInfo.Create(AOwner: TcxTreeListExportHelper);
begin
  FOwner := AOwner;
  FMaxLevel := 0;
end;

destructor TcxTreeListMapsInfo.Destroy;
begin
  ClearList(GroupList);
  ClearList(PreviewList);
  HeaderInfoList.Free;
  inherited Destroy;
end;

function TcxTreeListMapsInfo.AddGroupInfo: TcxPreviewInfoItem;
begin
  Result := TcxPreviewInfoItem.Create(GroupList, GroupListLast)
end;

function TcxTreeListMapsInfo.AddPreviewInfo: TcxPreviewInfoItem;
begin
  Result := TcxPreviewInfoItem.Create(PreviewList, PreviewListLast);
end;

procedure TcxTreeListMapsInfo.CalculateSize;
begin
  with HeaderInfoList.Dimension do
  begin
    FSize.cx := cx;
    FSize.cy := (cy - 1) * (Byte(Footer) + Byte(Headers) + MultiEditRowCount);
    if Bands then Inc(FSize.cy);
  end;
  Inc(FSize.cy, ConentCellsRowCount);
end;

procedure TcxTreeListMapsInfo.CheckNodeBeforeCalculate(ANode: TcxTreeListNode);
var
  AAlign: TcxAlignText;
  AHeight, H, ALevel: Integer;
  AColumn: TcxColumnAccess;
  AValue: Variant;
  AViewParams: TcxViewParams;

  function CheckNodePreview: Boolean;
  begin
    Result := False;
    if Preview then
    begin
      AColumn := TcxColumnAccess(TreeList.Preview.Column);
      AValue := GetNodeItemDisplayValue(ANode, AColumn, AAlign);
      if PreviewAutoHeight and (AValue = '') then Exit;
      AViewParams := TreeList.Styles.GetPreviewParams(ANode);
      AHeight := TcxViewInfoAccess(TreeList.ViewInfo).PreviewHeight;
      if PreviewAutoHeight then
      begin
        H := TotalWidth - TreeList.GetLevelIndentsWidth(ALevel, False, ANode);
        H := H - (TreeList.Preview.LeftIndent + TreeList.Preview.RightIndent);
        if H < 0 then H := 0;
        H := TcxColumnAccess(AColumn).GetCellHeight(ANode, H,
          TreeList.Preview.MaxLineCount, AViewParams.Font, AValue)
      end
      else
        H := AHeight;
      if Assigned(TreeList.OnGetNodePreviewHeight) then
        TreeList.OnGetNodePreviewHeight(TreeList, ANode, AValue, H);
      with TreeList.Preview do
        if (H > AHeight * MaxLineCount) or (MaxLineCount = 0) then
          AHeight := AHeight * MaxLineCount;
      if AHeight > 0 then
      begin
        Inc(AHeight, VertInc);
        AddPreviewInfo.SetData(ANode, ALevel + Byte(TreeList.OptionsView.ShowRoot),
          AHeight, AValue, AViewParams, AAlign);
        Result := True;
      end;
    end;
   end;

  function CheckGroupNode: Boolean;
  var
    AAlign: TcxAlignText;
  begin
    Result := TreeList.DoIsGroupNode(ANode);
    if not Result then Exit;
    with TreeList do
    begin
      AColumn := TcxColumnAccess(OptionsView.GetCategorizedColumn);
      TcxStylesAccess(Styles).DoGetContentParams(ANode, AColumn, AViewParams);
      AValue := GetNodeItemDisplayValue(ANode, AColumn, AAlign);
      AddGroupInfo.SetData(ANode, ALevel + Byte(TreeList.OptionsView.ShowRoot),
        HeaderLineCount * ViewInfo.DefaultEditHeight + VertInc, AValue, AViewParams, AAlign);
    end;
  end;

begin
  ALevel := ANode.Level;
  if ALevel > FMaxLevel then FMaxLevel := ALevel;
  if CheckNodePreview then
    Inc(ConentCellsRowCount);
  if CheckGroupNode then
    Inc(ConentCellsRowCount)
  else
    Inc(MultiEditRowCount);
end;

procedure TcxTreeListMapsInfo.ClearList(AList: TcxPreviewInfoItem);
var
  AItem: TcxPreviewInfoItem;
begin
  while AList <> nil do
  begin
    AItem := AList;
    AList := AList.Next;
    AItem.Free;
  end;
end;

procedure TcxTreeListMapsInfo.CloneMaps;
begin
  HeaderMap := HeaderInfoList.CloneMap;
  if Footer then FooterMap := cxCreateMap(Size);
  ValidateMaps;
end;

function TcxTreeListMapsInfo.CountItems(AList: TcxPreviewInfoItem): Integer;
begin
  Result := 0;
  while (AList <> nil) and (AList.Node <> nil) do
  begin
    Inc(Result);
    AList := AList.Next; 
  end;
end;

procedure TcxTreeListMapsInfo.CreateHeaderInfo;
var
  I, AOfs, IndentWidth: Integer;

  function GetIndentPosition(Index: Integer): TRect;
  begin
    Result := Rect(Index * IndentWidth, 1,
      (Index + 1) * IndentWidth, 1 + TreeList.HeaderLineCount);
  end;

begin
  AOfs := 0;;
  IndentWidth := TreeList.LevelIndentWidth;
  AOfs := 0;;
  for I := 0 to MaxLevel - 1 do
    HeaderInfoList.AddItem(GetIndentPosition(I), TObject(I), TcxIndentInfoItem);
  for I := 0 to TreeList.VisibleBandCount - 1 do
    AddColumnsFromBand(AOfs, TreeList.VisibleBands[I]);
end;

procedure TcxTreeListMapsInfo.DoCalculate;
var
  I: Integer;
begin
  TotalWidth := 0;
  for I := 0 to TreeList.VisibleBandCount - 1 do
    with TreeList.VisibleBands[I] do
    begin
      Inc(TotalWidth, DisplayWidth);
      if FixedKind <> tlbfNone then Inc(TotalWidth, 3);
    end;
  Owner.DoIterate(CheckNodeBeforeCalculate);
  if HeaderInfoList <> nil then FreeAndNil(HeaderInfoList);
  Inc(FMaxLevel, Byte(TreeList.OptionsView.ShowRoot)); 
  HeaderInfoList := TcxTreeListMapInfoList.Create(Self,
    TreeList.VisibleColumnCount + FMaxLevel + TreeList.VisibleBandCount);
  CreateHeaderInfo;
  HeaderInfoList.Calculate;
  CalculateSize; 
  CloneMaps;
end;

procedure TcxTreeListMapsInfo.DoWrite;
begin
  Provider.SetRange(Size.cx, Size.cy, False);
  Position := 0;
  DoWriteColumnWidths;
  DoWriteHeader;
  DoWriteContent;
  DoWriteFooter;
end;

procedure TcxTreeListMapsInfo.DoWriteColumnWidths;
var
  AList: TList;
  ALeft, ARight, I, J: Integer;
begin
  AList := HeaderInfoList.HorzList;
  ALeft := 0;
  J := 0;
  for I := 0 to AList.Count - 1 do
  begin
    ARight := Integer(AList.List^[I]);
    if ARight = ALeft then
    begin
      Inc(J);
      Continue;
    end;
    Provider.SetColumnWidth(I - J, ARight - ALeft);
    ALeft := ARight;
  end;
end;

procedure TcxTreeListMapsInfo.DoWriteContent;
begin
  Owner.DoIterate(DoWriteNode);
end;

procedure TcxTreeListMapsInfo.DoWriteFooter;
var
  I: Integer;
begin
  if Footer then
  begin
    Dec(Position);
    with HeaderInfoList.Dimension do
      DoWriteRect(Rect(0, 1, cx, cy), TreeList.Styles.GetFooterParams);
    for I := 0 to HeaderInfoList.ColumnCount - 1 do
      with HeaderInfoList.Columns[I] do
        if Footer then DoWriteItem(Position, FooterStyleIndex, FooterText);
  end;
end;

procedure TcxTreeListMapsInfo.DoWriteHeader;
var
  I, J, DH: Integer;
begin
  DH := 0;
  if Bands then
  begin
    for I := 0 to HeaderInfoList.BandCount - 1 do
      with HeaderInfoList.Bands[I] do
        DoWriteItem(Position, CaptionStyleIndex, HeaderText);
  end
  else
  begin
    Dec(Position);
    DH := 1;
  end;
  if Headers then
  begin
    for I := 0 to HeaderInfoList.ColumnCount - 1 do
      with HeaderInfoList.Columns[I] do
        DoWriteItem(Position, HeaderStyleIndex, HeaderText);
    for I := 0 to HeaderInfoList.Dimension.cx - 1 do
      for J := 0 to HeaderInfoList.Dimension.cy - 1 do
        if HeaderInfoList.CellsMap[I, J] = 0 then
          Provider.SetCellStyle(I, J - DH, TcxBandInfoItem(HeaderMap[I, J]).HeaderStyleIndex);
    Inc(Position, HeaderInfoList.Dimension.cy - 1);
  end;
  Inc(Position, 1);
end;

procedure TcxTreeListMapsInfo.DoWriteItem(
  const APosition: TRect; AStyleIndex: Integer; const AText: string);
begin
  with APosition do
  begin
    Provider.SetCellStyleEx(Left, Top + Position,
       Bottom - Top, Right - Left, AStyleIndex);
    if Length(AText) > 0 then
      Provider.SetCellValue(Left, Top + Position, AText);
  end;
end;

procedure TcxTreeListMapsInfo.DoWriteNode(ANode: TcxTreeListNode);
var
  AInfo: TcxPreviewInfoItem;
  AStartPos: Integer;
begin
  AStartPos := Position;
  if Preview and (TreeList.Preview.Place = tlppTop) and IsHasPreview(ANode, AInfo) then
    DoWriteNodePreview(ANode, AInfo);
  if IsGroupNode(ANode, AInfo) then
    DoWriteNodeGroup(ANode, AInfo)
  else
    DoWriteNodeMultiEdit(ANode);
  if Preview and (TreeList.Preview.Place = tlppBottom) and IsHasPreview(ANode, AInfo) then
    DoWriteNodePreview(ANode, AInfo);
  DoWriteNodeIndents(ANode, AStartPos);
end;

procedure TcxTreeListMapsInfo.DoWriteNodeGroup(
  ANode: TcxTreeListNode; AInfo: TcxPreviewInfoItem);
begin
  DoWritePreviewInfo(AInfo);
end;

procedure TcxTreeListMapsInfo.DoWriteNodeIndents(
  ANode: TcxTreeListNode; AStartPos: Integer);
var
  I, ALevel, AStyle: Integer;
const
  ExpandText: array[Boolean] of Char = ('+', '-');
begin
  ALevel := ANode.Level - Byte(not TreeList.OptionsView.ShowRoot);
  for I := 0 to ALevel do
  begin
    with TreeList.Styles.GetIndentParams(ANode, I) do
      AStyle := Provider.RegisterStyle(GetIndentStyle(Color, cxCellBorders[GridLines]));
    if (I = ALevel) and ANode.HasChildren then
      Provider.SetCellDataString(I, AStartPos, ExpandText[ANode.Expanded]);
    Provider.SetCellStyleEx(I, AStartPos, Position - AStartPos, 1, AStyle);
  end;
end;

procedure TcxTreeListMapsInfo.DoWriteNodeMultiEdit(ANode: TcxTreeListNode);
var
  I, J: Integer;
  AParams: TcxViewParams;
  ALeft: Integer;

  procedure WriteCell(AInfo: TcxColumnInfoItem);
  var
    R: TRect;
    AValue: Variant;
    AAlign: TcxAlignText;
  begin
    R := cxRectOffset(AInfo.Position, 0, Position);
    if R.Left = 0 then R.Left := ALeft;
    TcxStylesAccess(TreeList.Styles).DoGetContentParams(ANode, AInfo.Column, AParams);
    AValue := GetNodeItemDisplayValue(ANode, AInfo.Column, AAlign);
    Provider.SetCellValue(R.Left, R.Top, AValue);
    DoWriteUnionRect(R, AParams, AAlign, cxCellBorders[GridLines]);
  end;

  procedure WriteUnusedSpace(I, J: Integer; ABand: TcxBandAccess);
  begin
    TcxStylesAccess(TreeList.Styles).DoGetBandContentParams(ANode, ABand, AParams);
    Provider.SetCellStyle(I, J, cxRegisterViewParams(AParams, catLeft, Provider, []));
  end;

begin
  Dec(Position);
  try
    ALeft := ANode.Level + Byte(TreeList.OptionsView.ShowRoot);
    for J := 1 to HeaderInfoList.Dimension.cy - 1 do
      Provider.SetRowHeight(Position + J, TreeList.DefaultRowHeight);
    for I := 0 to HeaderInfoList.Dimension.cx - 1 do
      for J := 1 to HeaderInfoList.Dimension.cy - 1 do
         if (I > ALeft) and (HeaderInfoList.CellsMap[I, J] = 0) then
           WriteUnusedSpace(I, J + Position, TcxBandInfoItem(HeaderMap[I, J]).Band);
    for I := 0 to HeaderInfoList.ColumnCount - 1 do
      WriteCell(HeaderInfoList.Columns[I]);
  finally
    Inc(Position, NodeCellsCount + 1);
  end;
end;

procedure TcxTreeListMapsInfo.DoWritePreviewInfo(AInfo: TcxPreviewInfoItem);
var
  R: TRect;
begin
  with AInfo do
  begin
    with HeaderInfoList.Dimension do
      R := Rect(Level, Position, cx, Position + 1);
    Provider.SetCellValue(R.Left, R.Top, Value);
    Provider.SetRowHeight(Position, Height);
    DoWriteUnionRect(R, ViewParams, Alignment, cxCellBorders[GridLines]);
    Inc(Position);
  end;
end;

procedure TcxTreeListMapsInfo.DoWriteNodePreview(
  ANode: TcxTreeListNode; AInfo: TcxPreviewInfoItem);
begin
  DoWritePreviewInfo(AInfo)
end;

procedure TcxTreeListMapsInfo.DoWriteRect(ARect: TRect;
  const AParams: TcxViewParams; ABorders: TcxBorders = cxBordersAll);
var
  ACellBorders: TcxBorders;
  AStyleIndex, AIndex, I, J: Integer;
begin
  AStyleIndex := cxRegisterViewParams(AParams, catLeft, Provider, []);
  OffsetRect(ARect, 0, Position);
  for I := ARect.Left to ARect.Right - 1 do
    for J := ARect.Top to ARect.Bottom - 1 do
    begin
      AIndex := AStyleIndex;
      ACellBorders := cxCheckBorders(I, J, ARect, ABorders);
      if ACellBorders <> [] then
        AIndex := cxRegisterViewParams(AParams, catLeft, Provider, ACellBorders);
      Provider.SetCellStyle(I, J, AIndex);
    end;
end;

procedure TcxTreeListMapsInfo.DoWriteUnionRect(const ARect: TRect;
  const AParams: TcxViewParams; Align: TcxAlignText; ABorders: TcxBorders = cxBordersAll);
var
  AStyle: Integer;
begin
  AStyle := cxRegisterViewParams(AParams, Align, Provider, ABorders);
  with ARect do
    Provider.SetCellStyleEx(Left, Top, Bottom - Top, Right - Left, AStyle);
end;

function TcxTreeListMapsInfo.GetDisplayText(
  AIndex: Integer; ANode: TcxTreeListNode; AProperties: TcxCustomEditProperties): string;
begin
  with AProperties do
  begin
    if GetEditValueSource(False) = evsValue then
      Result := GetDisplayText(ANode.Values[AIndex], True)
    else
      Result := {GetDisplayText(}ANode.Texts[AIndex]{, True)};
  end;
end;

function TcxTreeListMapsInfo.GetDisplayValue(
  AIndex: Integer; ANode: TcxTreeListNode; AProperties: TcxCustomEditProperties): Variant;
begin
  if IsNativeFormatProperties(AProperties) then
    Result := ANode.Values[AIndex]
  else
    Result := AProperties.GetDisplayText(ANode.Values[AIndex], True);// GetDisplayText(AIndex, ANode, AProperties);
end;

function TcxTreeListMapsInfo.GetIndentStyle(
  AColor: TColor; ABorders: TcxBorders): TcxCacheCellStyle;
begin
  Result := cxSetStyleBorders(cxIndentStyle, 0, 0,
    cxNullRect, cxBtnShadowColor, ABorders);
  with Result do
  begin
    BrushBkColor := cxColorToRGB(AColor);
    BrushFGColor := BrushBkColor;
    FontColor := cxColorToRGB(TreeList.OptionsView.TreeLineColor);
  end;
end;

function TcxTreeListMapsInfo.GetNodeItemDisplayValue(
  ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; var Align: TcxAlignText): Variant;
var
  AProp: TcxCustomEditProperties;
begin
  AProp := TcxColumnAccess(AColumn).DoGetEditProperties(ANode);
  if Owner.IsNativeFormat then
    Result := GetDisplayValue(AColumn.ItemIndex, ANode, AProp)
  else
    Result := GetDisplayText(AColumn.ItemIndex, ANode, AProp);
  if VarIsNull(Result) then Result := '';
  ALign := AlignToCxAlign[TcxPropertiesAccess(AProp).Alignment.Horz];
end;

function TcxTreeListMapsInfo.IsGroupNode(
  ANode: TcxTreeListNode; var AInfo: TcxPreviewInfoItem): Boolean;
begin
  if CurGroupInfo = nil then
    CurGroupInfo := GroupList;
  Result := (CurGroupInfo <> nil) and (CurGroupInfo.Node = ANode);
  if Result then
  begin
    AInfo := CurGroupInfo;
    CurGroupInfo := CurGroupInfo.Next;
  end;
end;

function TcxTreeListMapsInfo.IsHasPreview(
  ANode: TcxTreeListNode; var AInfo: TcxPreviewInfoItem): Boolean;
begin
  if CurPreviewInfo = nil then
    CurPreviewInfo := PreviewList;
  Result := (CurPreviewInfo <> nil) and (CurPreviewInfo.Node = ANode);
  if Result then
  begin
    AInfo := CurPreviewInfo;
    CurPreviewInfo := CurPreviewInfo.Next;
  end;
end;

function TcxTreeListMapsInfo.IsNativeFormatProperties(
  AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := (AProperties is TcxDateEditProperties) or (AProperties is TcxCurrencyEditProperties) or
    (AProperties is TcxSpinEditProperties) or (AProperties is TcxCalcEditProperties) or
    (AProperties is TcxTimeEditProperties);
end;

procedure TcxTreeListMapsInfo.ValidateMaps;
var
  I: Integer;
  ABand: TcxBandInfoItem;
begin
  with HeaderInfoList do
  begin
    for I := 0 to BandCount - 1 do
    begin
      ABand := Bands[I];
      ABand.Position.Bottom := Dimension.cy;
      cxFillMapItem(HeaderMap, ABand, True);
      ABand.Position.Bottom := 1;
      if Footer then cxFillMapItem(FooterMap, ABand, False);
      ABand.RegisterStyles;
    end;
    for I := 0 to ColumnCount - 1 do
    begin
      if Footer then cxFillMapItem(FooterMap, Columns[I], False);
      Columns[I].RegisterStyles;
    end;
  end;
end;

function TcxTreeListMapsInfo.GetBandLineHeight: Integer;
begin
  with TreeList do 
    Result := TcxViewInfoAccess(ViewInfo).BandLineHeight * OptionsView.BandLineCount;
end;

function TcxTreeListMapsInfo.GetBands: Boolean;
begin
  Result := TreeList.OptionsView.Bands;
end;

function TcxTreeListMapsInfo.GetNodeCellsCount: Integer;
begin
  Result := HeaderInfoList.Dimension.cy - 1;
end;

function TcxTreeListMapsInfo.GetPreview: Boolean;
begin
  Result := TreeList.Preview.Active;
end;

function TcxTreeListMapsInfo.GetPreviewAutoHeight: Boolean;
begin
  Result := TreeList.Preview.AutoHeight;
end;

function TcxTreeListMapsInfo.GetProvider: IcxExportProvider;
begin
  Result := Owner.Provider;
end;

function TcxTreeListMapsInfo.GetHeaders: Boolean;
begin
  Result := TreeList.OptionsView.Headers;
end;

function TcxTreeListMapsInfo.GetFooter: Boolean;
begin
  Result := TreeList.OptionsView.Footer;
end;

function TcxTreeListMapsInfo.GetFooters(AColumn: TcxTreeListColumn): Boolean;
begin
  Result := Footer and AColumn.Options.Footer;
end;

function TcxTreeListMapsInfo.GetGridLines: Boolean;
begin
  Result := TreeList.OptionsView.GridLines <> tlglNone;
end;

function TcxTreeListMapsInfo.GetHeaderLineHeight: Integer;
begin
  Result := TcxViewInfoAccess(TreeList.ViewInfo).HeaderLineHeight;
end;

function TcxTreeListMapsInfo.GetTreeList: TcxTreeListAccess;
begin
  Result := Owner.TreeList;
end;

function TcxTreeListMapsInfo.GetVertInc: Integer;
begin
  Result := 2 * Byte(TreeList.OptionsView.GridLines in [tlglVert, tlglBoth]);
end;

procedure TcxTreeListMapsInfo.AddColumnsFromBand(
  var AOfs: Integer; ABand: TcxTreeListBand);
var
  I, J, ALeft, ABandWidth: Integer;

  procedure AddColumn(ALineOfs: Integer; AColumn: TcxColumnAccess);
  var
    R: TRect;
  begin
    with AColumn do
    begin
      R := Rect(ALeft, ALineOfs + 1, // + 1  band header offset but may be invisible
        ALeft + DisplayWidth, ALineOfs + Position.LineCount + 1);
      Inc(ALeft, DisplayWidth);
    end;
    HeaderInfoList.AddItem(R, AColumn, TcxColumnInfoItem);
  end;

begin
  ABandWidth := TcxBandAccess(ABand).DisplayWidth;
  for I := 0 to ABand.BandRows.Count - 1 do
  begin
    ALeft := AOfs;
    with ABand.BandRows[I] do
    begin
      for J := 0 to Count - 1 do
        AddColumn(LineOffset, TcxColumnAccess(Items[J]));
    end;
  end;
  HeaderInfoList.AddItem(Rect(AOfs, 0, AOfs + ABandWidth, 1), ABand, TcxBandInfoItem);
  Inc(AOfs, ABandWidth);
end;

{ TcxTreeListExportHelper }

constructor TcxTreeListExportHelper.Create(ATreeList: TcxCustomTreeListControl;
  AExportType: Integer; const AFileName: string);

  function DefaultStyle: TcxCacheCellStyle;
  begin
    cxViewParamsToCacheStyle(TreeList.Styles.GetBackgroundParams, Result);
  end;

begin
  FTreeList := TcxTreeListAccess(ATreeList);
  TcxExport.Provider(AExportType, AFileName).GetInterface(IcxExportProvider, FProvider);
  FProvider.SetDefaultStyle(DefaultStyle);
  FSelectionList := TList.Create;
  FSelectionList.Capacity := FTreeList.DataController.RecordCount;
  MapsInfo := GetMapsInfoClass.Create(Self);
end;

destructor TcxTreeListExportHelper.Destroy;
begin
  try
    MapsInfo.Free; 
    FSelectionList.Free;
    FProvider := nil;
  finally
    inherited Destroy;
  end;
end;

procedure TcxTreeListExportHelper.CallIterationProc(ANode: TcxTreeListNode;
  AIndex: Integer; AProc: TcxTreeListNodeItarationHandler);
var
  APrevIndex: Integer;
begin
  APrevIndex := TcxNodeAccess(ANode).FVisibleIndex;
  TcxNodeAccess(ANode).FVisibleIndex := AIndex;
  try
    AProc(ANode);
  finally
    TcxNodeAccess(ANode).FVisibleIndex := APrevIndex;
  end;
end;

procedure TcxTreeListExportHelper.DoCalculateTableMap;
begin
  MapsInfo.DoCalculate;
end;

procedure TcxTreeListExportHelper.DoWriteCells;
begin
  MapsInfo.DoWrite; 
  Provider.Commit;
end;

procedure TcxTreeListExportHelper.DoIterate(
  AProc: TcxTreeListNodeItarationHandler);
begin
  if not Assigned(AProc) then Exit;
  if ExportSelection then
    DoIterateSelectionNodes(AProc)
  else
    DoIterateAllNodes(AProc);
end;

procedure TcxTreeListExportHelper.DoIterateAllNodes(AProc: TcxTreeListNodeItarationHandler);
var
  AIndex: Integer;
  AStartNode: TcxTreeListNode;
begin
  AStartNode := TreeList.Nodes.Root.GetFirstChild;
  AIndex := 0;
  while AStartNode <> nil do
  begin
    CallIterationProc(AStartNode, AIndex, AProc);
    if Expand then
      AStartNode := AStartNode.GetNext
    else
      AStartNode := AStartNode.GetNextVisible;
    Inc(AIndex);
  end;
end;

procedure TcxTreeListExportHelper.DoIterateSelectionNodes(
  AProc: TcxTreeListNodeItarationHandler);
var
  I: Integer;
begin
  for I := 0 to FSelectionList.Count - 1 do
    CallIterationProc(TcxTreeListNode(FSelectionList[I]), I, AProc);
end;

function TcxTreeListExportHelper.GetMapsInfoClass: TcxTreeListMapsInfoClass;
begin
  Result := TcxTreeListMapsInfo;
end;

function TcxTreeListExportHelper.AddToSelection(ANode: TcxTreeListNode): Boolean;
begin
  Result := FSelectionList.IndexOf(ANode) <> cxInvalidIndex;
  if not Result then
  begin
    if not ANode.IsVisible then
    begin
      if not Expand then
        Exit
      else
        ANode.Expanded := True;
    end;
    FSelectionList.Add(ANode);
    Result := True;
  end;
end;

procedure TcxTreeListExportHelper.CreateSelectionList;
var
  I: Integer;
  AFlatList: TList;

  procedure ProcessSelectedNodes(ANode: TcxTreeListNode);
  begin
    if (ANode = nil) or not ANode.Expanded then Exit;
    ANode := ANode.GetFirstChild;
    while ANode <> nil do
    begin
      if ANode.Selected then 
        AddToSelection(ANode);
      if Expand then
        ProcessSelectedNodes(ANode);
      ANode := ANode.getNextSibling;
    end;
  end;

  procedure AddParentsToSelection(ANode: TcxTreeListNode);
  var
    I: Integer;
  begin
    AFlatList.Clear;
    AFlatList.Add(ANode);
    for I := 0 to ANode.Level - 1 do
    begin
      ANode := ANode.Parent;
      if not ANode.Expanded and Expand then
        ANode.Expanded := True;
      if ANode.Expanded then
        AFlatList.Add(ANode)
      else
        Exit;
    end;
    for I := AFlatList.Count - 1 downto 0 do 
      if FSelectionList.IndexOf(AFlatList[I]) = cxInvalidIndex then
        FSelectionList.Add(TcxTreeListNode(AFlatList[I]));
  end;

begin
  AFlatList := TList.Create;
  try
    for I := 0 to TreeList.SelectionCount - 1 do
      AddParentsToSelection(TreeList.Selections[I]);
    for I := 0 to FSelectionList.Count - 1 do
      ProcessSelectedNodes(TcxTreeListNode(FSelectionList.List^[I]));
    FSelectionList.Sort(@cxNodesCompare);
  finally
    AFlatList.Free;
  end;
end;

procedure TcxTreeListExportHelper.SetExportSelection(Value: Boolean);
begin
  FExportSelection := Value;
  if Value then CreateSelectionList;
end;

// external procedures definition

procedure cxExportTL4ToFile(AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExportType: Integer; AExpand, ASaveAll, AUseNativeFormat: Boolean;
  const ASeparators: array of string; const AFileExt: string);
var
  I: Integer;
  AIntf: IcxExportWithSeparators;
begin
  if AFileExt <> '' then
    AFileName := ChangeFileExt(AFileName, '.' + AFileExt);
  if not ATreeList.Visible then
    cxTreeListError(scxExportNotVisibleControl);
  with TcxTreeListExportHelper.Create(ATreeList, AExportType, AFileName) do
  try
    FExpand := AExpand;
    FIsNativeFormat :=  AUseNativeFormat;
    ExportSelection := not ASaveAll;
    if cxExportTL4Link.Supports(Provider, IcxExportWithSeparators, AIntf) and (Length(ASeparators) > 0) then
    begin
      for I := Low(ASeparators) to High(ASeparators) do
        AIntf.AddSeparator(ASeparators[I]);
    end;
    DoCalculateTableMap;
    DoWriteCells;
  finally
    Free;
  end;
end;

procedure cxExportTL4ToHTML(const AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'html');
begin
  cxExportTL4ToFile(AFileName, ATreeList, cxExportToHtml, AExpand, ASaveAll, False, [], AFileExt);
end;

procedure cxExportTL4ToXML(const AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'xml');
begin
  cxExportTL4ToFile(AFileName, ATreeList, cxExportToXML, AExpand, ASaveAll, False, [], AFileExt);
end;

procedure cxExportTL4ToExcel(const AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExpand: Boolean = True; ASaveAll: Boolean = True; AUseNativeFormat: Boolean = True;
  const AFileExt: string = 'xls');
begin
  cxExportTL4ToFile(AFileName, ATreeList, cxExportToExcel, AExpand, ASaveAll,
    AUseNativeFormat, [], AFileExt);
end;

procedure cxExportTL4ToText(const AFileName: string; ATreeList: TcxCustomTreeListControl;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const ASeparator: string = '';
  const ABeginString: string = ''; const AEndString: string = ''; const AFileExt: string = 'txt');
begin
  cxExportTL4ToFile(AFileName, ATreeList, cxExportToText, AExpand, ASaveAll, False,
    [ASeparator, ABeginString, AEndString], AFileExt);
end;

initialization
  dxStringToBytes(cxIndentFontName, cxIndentStyle.FontName);
  cxExportInit(TcxGetResourceStringProc(@cxGetResourceString), @ColorToRGB,  True );
end.

