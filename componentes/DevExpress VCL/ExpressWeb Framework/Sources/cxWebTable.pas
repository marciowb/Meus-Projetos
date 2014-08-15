{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Controls Library                                 }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebTable;

interface
{$I cxVer.inc}

uses
  Classes, SysUtils,
  {$IFDEF VCL}
  Graphics,
  {$ENDIF}
  cxWebIntf, cxWebClasses, cxWebControls, cxWebTypes, cxWebRender;

type

  TcxCustomWebTable = class;
  TcxCustomWebTableColumns = class;

  TcxWebTableColumnViewType = (tvtText, tvtHyperText, tvtImage);

  TcxCustomWebTableColumn = class(TCollectionItem)
  private
    FAlignment: TcxWebHorzAlignment;
    FStyles: TcxWebStyles;
    FTitleAlignment: TcxWebHorzAlignment;
    FViewType: TcxWebTableColumnViewType;
    FTitle: string;
    FWidth: Integer;
    FWordWrap: Boolean;

    procedure SetAlignment(const Value: TcxWebHorzAlignment);
    procedure SetStyles(const Value: TcxWebStyles);
    procedure SetTitleAlignment(const Value: TcxWebHorzAlignment);
    procedure SetTitle(const Value: string);
    procedure SetWidth(const Value: Integer);
    procedure SetViewType(const Value: TcxWebTableColumnViewType);
    procedure SetWordWrap(const Value: Boolean);
  protected
    function Columns: TcxCustomWebTableColumns;
    procedure UpdateTable;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property Alignment: TcxWebHorzAlignment read FAlignment write SetAlignment;
    property Styles: TcxWebStyles read FStyles write SetStyles;
    property TitleAlignment: TcxWebHorzAlignment read FTitleAlignment write SetTitleAlignment;
    property ViewType: TcxWebTableColumnViewType read FViewType write SetViewType;
    property Title: string read FTitle write SetTitle;
    property Width: Integer read FWidth write SetWidth;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
  end;

  TcxCustomWebTableColumns = class(TCollection)
  private
    FTable: TcxCustomWebTable;

    function GetItem(AIndex: Integer): TcxCustomWebTableColumn;
    procedure SetItem(AIndex: Integer; const Value: TcxCustomWebTableColumn);
  protected
    procedure Update(Item: TCollectionItem); override;
    property Table: TcxCustomWebTable read FTable;
  public
    property Items[Index: Integer]: TcxCustomWebTableColumn read GetItem write SetItem; default;
  end;

  TcxWebTablePagingType = (tptNone, tptBottom, tptTop, tptBoth);

  TcxWebTablePaging = class(TPersistent)
  private
    FTable: TcxCustomWebTable;
    FAlignment: TcxWebHorzAlignment;
    FPagingSize: Integer;
    FPagingType: TcxWebTablePagingType;
    FPagingSizeChagned: TNotifyEvent;
    FMaxPageNumbers: Integer;

    procedure SetAlignment(const Value: TcxWebHorzAlignment);
    procedure SetMaxPageNumbers(const Value: Integer);
    procedure SetPagingSize(const Value: Integer);
    procedure SetPagingType(const Value: TcxWebTablePagingType);
  protected
    property Table: TcxCustomWebTable read FTable;

    property PagingSizeChagned: TNotifyEvent read FPagingSizeChagned write FPagingSizeChagned;
  public
    constructor Create(ATable: TcxCustomWebTable);
    procedure Assign(Source: TPersistent); override;
    function StartPageIndex: Integer;
    function EndPageIndex: Integer;
    function MaxPageIndex: Integer;
  published
    property Alignment: TcxWebHorzAlignment read FAlignment write SetAlignment;
    property MaxPageNumbers: Integer read FMaxPageNumbers write SetMaxPageNumbers;
    property PagingSize: Integer read FPagingSize write SetPagingSize;
    property PagingType: TcxWebTablePagingType read FPagingType write SetPagingType;
  end;

  TcxWebTableGetTitleHTML = procedure(Sender: TObject;
        AColumn: TcxCustomWebTableColumn; const AHRef: String; var AHTML: String) of object;
  TcxWebTableGetPagingHTML = procedure(Sender: TObject;
      APagingType: TcxWebTablePagingType; var AHTML: string) of object;
  TcxWebTableGetPagingStatus = procedure(Sender: TObject;
      APageIndex: Integer; var AHTML: string) of object;
  TcxWebTableLoadImage = procedure(Sender: TObject;
        AColumn: TcxCustomWebTableColumn{$IFDEF VCL}; var GraphicClass: TGraphicClass{$ENDIF}) of object;
  TcxWebTableWriteRow = procedure(Sender: TObject;
    AHTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer) of object;

  TcxCustomWebTable = class(TcxWebControl)
  private
    FColumns: TcxCustomWebTableColumns;
    FCellPadding: Integer;
    FCellSpacing: Integer;
    FPaging: TcxWebTablePaging;
    FAlternatingItemsStyles: TcxWebStyles;
    FHeaderStyles: TcxWebStyles;
    FItemsStyles: TcxWebStyles;
    FPagingStyles: TcxWebStyles;
    FPagingNumbersStyles: TcxWebStyles;
    FSelectingPagingNumberStyles: TcxWebStyles;
    FMaximumWidth: Boolean;
    FBorderColor: TcxWebColor;
    FBorderWidth: Integer;
    FShowHeaders: Boolean;
    FOnGetTitleHTML: TcxWebTableGetTitleHTML;
    FOnGetAfterPagingHTML: TcxWebTableGetPagingHTML;
    FOnGetBeforePagingHTML: TcxWebTableGetPagingHTML;
    FOnGetPagingStatus: TcxWebTableGetPagingStatus;
    FOnLoadImage: TcxWebTableLoadImage;
    FOnBeforeWriteRow: TcxWebTableWriteRow;
    FOnEndWriteRow: TcxWebTableWriteRow;

    procedure SetBorderColor(const Value: TcxWebColor);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetCellPadding(const Value: Integer);
    procedure SetCellSpacing(const Value: Integer);
    procedure SetPaging(const Value: TcxWebTablePaging);
    procedure SetAlternatingItemsStyles(const Value: TcxWebStyles);
    procedure SetShowHeaders(const Value: Boolean);
    procedure SetHeaderStyles(const Value: TcxWebStyles);
    procedure SetItemsStyles(const Value: TcxWebStyles);
    procedure SetPagingStyles(const Value: TcxWebStyles);
    procedure SetPagingNumbersStyles(const Value: TcxWebStyles);
    procedure SetSelectingPagingNumberStyles(const Value: TcxWebStyles);

    procedure ColumnClick(const AParameters: TcxActionParameters);
    procedure PagingClick(const AParameters: TcxActionParameters);
    procedure RowClick(const AParameters: TcxActionParameters);
  protected
    function CreateColumns: TcxCustomWebTableColumns; virtual; abstract;
    function GetRecordCount: Integer; virtual; abstract;
    function GetDisplayText(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer): string; virtual; abstract;
    function GetValue(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer): Variant; virtual; abstract;
    procedure GetURL(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer; AURL: TcxURL); virtual;

    function GetPageIndex: Integer; virtual; abstract;
    function GetAllowSorting: Boolean; virtual; abstract;

    procedure DoColumnClick(AColumnIndex: Integer); virtual;
    procedure DoPagingClick(APageIndex: Integer); virtual;
    procedure DoRowClick(AColIndex: Integer; ARowValue: string); virtual;

    procedure GetTitleHTML(AColumn: TcxCustomWebTableColumn; const AHRef: String; var AHTML: String); dynamic;
    procedure GetBeforePagingHTML(APagingType: TcxWebTablePagingType; var AHTML: string); dynamic;
    procedure GetAfterPagingHTML(APagingType: TcxWebTablePagingType; var AHTML: string); dynamic;
    function GetPagingNumberStatus(APageIndex: Integer): string; dynamic;
    procedure DoBeforeWriteRow(AHTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer); dynamic;
    procedure DoEndWriteRow(AHTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer); dynamic;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { actions }
    procedure RegisterActions; override;
    { renderers }
    procedure RegisterRenderers; override;
    { Scripts }
    procedure ScriptsSubscription; override;

    procedure ImplGetProviders(AList: TList); override;

    function GetStartRowIndex: Integer;
    function GetEndRowIndex: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property BorderColor: TcxWebColor read FBorderColor write SetBorderColor;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property CellPadding: Integer read FCellPadding write SetCellPadding;
    property CellSpacing: Integer read FCellSpacing write SetCellSpacing;
    property Columns: TcxCustomWebTableColumns read FColumns;
    property Paging: TcxWebTablePaging read FPaging write SetPaging;
    property ShowHeaders: Boolean read FShowHeaders write SetShowHeaders;

    property AlternatingItemsStyles: TcxWebStyles read FAlternatingItemsStyles write SetAlternatingItemsStyles;
    property HeaderStyles: TcxWebStyles read FHeaderStyles write SetHeaderStyles;
    property ItemsStyles: TcxWebStyles read FItemsStyles write SetItemsStyles;
    property MaximumWidth: Boolean read FMaximumWidth write FMaximumWidth;
    property PagingStyles: TcxWebStyles read FPagingStyles write SetPagingStyles;
    property PagingNumbersStyles: TcxWebStyles read FPagingNumbersStyles write SetPagingNumbersStyles;
    property SelectingPagingNumberStyles: TcxWebStyles read FSelectingPagingNumberStyles
                write SetSelectingPagingNumberStyles;
    property OnGetTitleHTML: TcxWebTableGetTitleHTML read FOnGetTitleHTML write FOnGetTitleHTML;
    property OnGetBeforePagingHTML: TcxWebTableGetPagingHTML read FOnGetBeforePagingHTML write FOnGetBeforePagingHTML;
    property OnGetAfterPagingHTML: TcxWebTableGetPagingHTML read FOnGetAfterPagingHTML write FOnGetAfterPagingHTML;
    property OnGetPagingStatus: TcxWebTableGetPagingStatus read FOnGetPagingStatus write FOnGetPagingStatus;
    property OnLoadImage: TcxWebTableLoadImage read FOnLoadImage write FOnLoadImage;
    property OnBeforeWriteRow: TcxWebTableWriteRow read FOnBeforeWriteRow write FOnBeforeWriteRow;
    property OnEndWriteRow: TcxWebTableWriteRow read FOnEndWriteRow write FOnEndWriteRow;
  end;

  TcxWebTableColumnSortMode = (tsmNone, tsmAscending, tsmDescending);

  TcxWebTableColumn = class(TcxCustomWebTableColumn)
  private
    FSortMode: TcxWebTableColumnSortMode;

    procedure SetSortMode(const Value: TcxWebTableColumnSortMode);
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Alignment;
    property Styles;
    property ViewType;
    property SortMode: TcxWebTableColumnSortMode read FSortMode write SetSortMode;
    property Title;
    property TitleAlignment;
    property Width;
    property WordWrap;
  end;

  TcxWebTableColumns = class(TcxCustomWebTableColumns)
  private
    function GetItem(Index: Integer): TcxWebTableColumn;
    procedure SetItem(Index: Integer; const Value: TcxWebTableColumn);
  public
    function Add: TcxWebTableColumn;
    property Items[Index: Integer]: TcxWebTableColumn read GetItem write SetItem; default;
  end;

  TcxWebTableGetDisplayText = procedure(Sender: TObject;
        AColumn: TcxWebTableColumn; ARecIndex: Integer; var AText: String) of object;
  TcxWebTableGetURLValue = procedure(Sender: TObject;
        AColumn: TcxWebTableColumn; ARecIndex: Integer; AURL: TcxURL) of object;
  TcxWebTableGetValue = procedure(Sender: TObject;
        AColumn: TcxWebTableColumn; ARecIndex: Integer; var Value: Variant) of object;
  TcxWebTableColumnClick = procedure(Sender: TObject; AColumn: TcxWebTableColumn) of object;
  TcxWebTableCellClick = procedure(Sender: TObject;
        AColumn: TcxWebTableColumn; ARecIndex: Integer) of object;

  TcxWebTable = class(TcxCustomWebTable)
  private
    FRecordCount: Integer;
    FPageIndex: Integer;
    FOnGetDisplayText: TcxWebTableGetDisplayText;
    FOnGetValue: TcxWebTableGetValue;
    FOnGetHrefValue: TcxWebTableGetURLValue;
    FOnColumnClick: TcxWebTableColumnClick;
    FOnCellClick: TcxWebTableCellClick;
    FAllowSorting: Boolean;

    procedure DoPagingSizeChanged(Sender: TObject);

    procedure SetRecordCount(Value: Integer);
    function GetColumns: TcxWebTableColumns;
    procedure SetColumns(const Value: TcxWebTableColumns);
    procedure SetPageIndex(Index: Integer);
    procedure SetAllowSorting(const Value: Boolean);
  protected
    function CreateColumns: TcxCustomWebTableColumns; override;
    function GetRecordCount: Integer; override;
    function GetDisplayText(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer): string; override;
    function GetValue(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer): Variant; override;
    procedure GetURL(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer; AURL: TcxURL); override;

    function GetPageIndex: Integer; override;
    function GetAllowSorting: Boolean; override;
    procedure DoColumnClick(AColumnIndex: Integer); override;
    procedure DoPagingClick(APageIndex: Integer); override;
    procedure DoRowClick(AColIndex: Integer; ARowValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AllowSorting: Boolean read FAllowSorting write SetAllowSorting;
    property RecordCount: Integer read FRecordCount write SetRecordCount;
    property Columns: TcxWebTableColumns read GetColumns write SetColumns;
    property MaximumWidth;
    property Paging;
    property PageIndex: Integer read FPageIndex write SetPageIndex;

    property AlternatingItemsStyles;
    property HeaderStyles;
    property ItemsStyles;
    property PagingStyles;
    property PagingNumbersStyles;
    property SelectingPagingNumberStyles;
    property Styles;

    property PopupMenu;
    property PopupShowingType;
    
    property BorderColor;    
    property BorderWidth;
    property CellPadding;
    property CellSpacing;
    property ShowHeaders;

    property OnGetDisplayText: TcxWebTableGetDisplayText read FOnGetDisplayText write FOnGetDisplayText;
    property OnGetHrefValue: TcxWebTableGetURLValue read FOnGetHrefValue write FOnGetHrefValue;
    property OnGetValue: TcxWebTableGetValue read FOnGetValue write FOnGetValue;
    property OnCellClick: TcxWebTableCellClick read FOnCellClick write FOnCellClick;
    property OnColumnClick: TcxWebTableColumnClick read FOnColumnClick write FOnColumnClick;
    property OnGetTitleHTML;
    property OnGetBeforePagingHTML;
    property OnGetAfterPagingHTML;
    property OnGetPagingStatus;
    property OnLoadImage;
    property OnBeforeWriteRow;
    property OnEndWriteRow;
  end;

  TcxWebTableRenderWriteCellProc = procedure(AColumn: TcxCustomWebTableColumn; AIndex: Integer) of object;

  TcxCustomWebTableRenderer = class(TcxWebControlRenderer)
  protected
    function Table: TcxCustomWebTable;
    function MaxPageIndex: Integer;
    function GetColumn(AIndex: Integer): TcxCustomWebTableColumn;
    function GetCellText(AColumn: TcxCustomWebTableColumn; AIndex: Integer): string;
    function GetColumnTitle(AColumn: TcxCustomWebTableColumn): string;

    procedure WriteHeaders; virtual;
    procedure WriteItems; virtual;
    procedure WriteHeader(AColumn: TcxCustomWebTableColumn);
    procedure WriteRow(AIndex: Integer);
    procedure WriteRowStyle(AIndex: Integer);
    procedure WriteCell(AColumn: TcxCustomWebTableColumn; AIndex: Integer);
    procedure WritePaging(APagingType: TcxWebTablePagingType); virtual;
    procedure WritePageIndex(AText, ADisableText: string; APageIndex: Integer; IsNumber: Boolean);

    function GetRenderWriteCellProc(AColumn: TcxCustomWebTableColumn): TcxWebTableRenderWriteCellProc;
    procedure WriteTextCell(AColumn: TcxCustomWebTableColumn; AIndex: Integer); virtual;
    procedure WriteHrefCell(AColumn: TcxCustomWebTableColumn; AIndex: Integer); virtual;
    procedure WriteImageCell(AColumn: TcxCustomWebTableColumn; AIndex: Integer); virtual;
    procedure WriteComponentEvents(const Style: TcxWebStyleItem;
      AHTMLTextBuilder: TcxHTMLTextBuilder = nil);
  public
    procedure WriteHTML; override;
  end;


implementation

uses
  cxWebScriptFactory, cxWebUtils, cxWebDataUtils, cxWebColors, cxWebGraphics;


{ TcxCustomWebTableColumn }
constructor TcxCustomWebTableColumn.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FStyles := TcxWebStyles.Create(Columns.Table);
  FAlignment := whalLeft;
  FTitleAlignment := whalCenter;
  FViewType := tvtText;
  FWidth := 0;
  FWordWrap := True;
end;

destructor TcxCustomWebTableColumn.Destroy;
begin
  FStyles.Free;
  inherited Destroy;
end;

procedure TcxCustomWebTableColumn.Assign(Source: TPersistent);
begin
  if Source is TcxCustomWebTableColumn then
  begin
    FAlignment := TcxCustomWebTableColumn(Source).Alignment;
    FTitleAlignment := TcxCustomWebTableColumn(Source).TitleAlignment;
    FViewType := TcxCustomWebTableColumn(Source).ViewType;
    FTitle := TcxCustomWebTableColumn(Source).Title;
    UpdateTable;
  end else inherited Assign(Source);
end;

function TcxCustomWebTableColumn.Columns: TcxCustomWebTableColumns;
begin
  Result := TcxCustomWebTableColumns(Collection);
end;

procedure TcxCustomWebTableColumn.UpdateTable;
begin
  if (Columns <> nil) and (Columns.Table <> nil) then
    Columns.Table.UpdateDesignerContext;
end;

procedure TcxCustomWebTableColumn.SetAlignment(const Value: TcxWebHorzAlignment);
begin
  if Alignment <> Value then
  begin
    FAlignment := Value;
    UpdateTable;
  end;
end;

procedure TcxCustomWebTableColumn.SetStyles(const Value: TcxWebStyles);
begin
  FStyles.Assign(Value);
  UpdateTable;
end;

procedure TcxCustomWebTableColumn.SetTitleAlignment(const Value: TcxWebHorzAlignment);
begin
  if TitleAlignment <> Value then
  begin
    FTitleAlignment := Value;
    UpdateTable;
  end;
end;

procedure TcxCustomWebTableColumn.SetTitle(const Value: string);
begin
  if Title <> Value then
  begin
    FTitle := Value;
    UpdateTable;
  end;
end;

procedure TcxCustomWebTableColumn.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    UpdateTable;
  end;
end;

procedure TcxCustomWebTableColumn.SetViewType(const Value: TcxWebTableColumnViewType);
begin
  if ViewType <> Value then
  begin
    FViewType := Value;
    UpdateTable;
  end;
end;

procedure TcxCustomWebTableColumn.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    UpdateTable;
  end;
end;

{  TcxCustomWebTableColumns }
function TcxCustomWebTableColumns.GetItem(AIndex: Integer): TcxCustomWebTableColumn;
begin
  Result := TcxCustomWebTableColumn(inherited Items[AIndex]);
end;

procedure TcxCustomWebTableColumns.SetItem(AIndex: Integer; const Value: TcxCustomWebTableColumn);
begin
  Items[AIndex].Assign(Value);
end;

procedure TcxCustomWebTableColumns.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Table <> nil then
    Table.UpdateDesignerContext;
end;

{ TcxWebTablePaging }

constructor TcxWebTablePaging.Create(ATable: TcxCustomWebTable);
begin
  FTable := ATable;
  FMaxPageNumbers := 10;
  FPagingSize := 10;
  FPagingType := tptTop;
  FAlignment := whalCenter;
end;

procedure TcxWebTablePaging.Assign(Source: TPersistent);
begin
  if Source is TcxWebTablePaging then
  begin
    FPagingSize := TcxWebTablePaging(Source).PagingSize;
    FPagingType := TcxWebTablePaging(Source).PagingType;
    FMaxPageNumbers := TcxWebTablePaging(Source).MaxPageNumbers;
    Table.UpdateDesignerContext;
  end else inherited Assign(Source);
end;

function TcxWebTablePaging.StartPageIndex: Integer;
begin
  if MaxPageNumbers > 0 then
  begin
    Result := Table.GetPageIndex - (MaxPageNumbers div 2);
    if Result < 0 then
      Result := 0
    else
    begin
      if Result + MaxPageNumbers > MaxPageIndex + 1 then
        Result := MaxPageIndex + 1 - MaxPageNumbers;
      if Result < 0 then
        Result := 0
    end;
  end else Result := 0;
end;

function TcxWebTablePaging.EndPageIndex: Integer;
begin
  if MaxPageNumbers > 0 then
  begin
    Result := StartPageIndex + MaxPageNumbers;
    if Result > MaxPageIndex + 1 then
      Result := MaxPageIndex + 1;
  end else Result := 0;    
end;

function TcxWebTablePaging.MaxPageIndex: Integer;
begin
  Result := Table.GetRecordCount div PagingSize;
  if (Result > 0) and
    (Table.GetRecordCount mod Table.Paging.PagingSize = 0) then
    Dec(Result);
end;


procedure TcxWebTablePaging.SetAlignment(const Value: TcxWebHorzAlignment);
begin
  if Alignment <> Value then
  begin
    FAlignment := Value;
    Table.UpdateDesignerContext;
  end;
end;

procedure TcxWebTablePaging.SetMaxPageNumbers(const Value: Integer);
begin
  if Value < 1 then exit;
  if MaxPageNumbers <> Value then
  begin
    FMaxPageNumbers := Value;
    Table.UpdateDesignerContext;
  end;
end;

procedure TcxWebTablePaging.SetPagingSize(const Value: Integer);
begin
  if Value < 1 then exit;
  if PagingSize <> Value then
  begin
    FPagingSize := Value;
    if Assigned(FPagingSizeChagned) then
      FPagingSizeChagned(self);
    Table.UpdateDesignerContext;
  end;
end;

procedure TcxWebTablePaging.SetPagingType(const Value: TcxWebTablePagingType);
begin
  if PagingType <> Value then
  begin
    FPagingType := Value;
    Table.UpdateDesignerContext;
  end;
end;


{ TcxCustomWebTable }
constructor TcxCustomWebTable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColumns := CreateColumns;
  FColumns.FTable := self;
  FAlternatingItemsStyles := TcxWebStyles.Create(self);
  FHeaderStyles := TcxWebStyles.Create(self);
  FItemsStyles := TcxWebStyles.Create(self);
  FPagingStyles := TcxWebStyles.Create(self);
  FPagingNumbersStyles := TcxWebStyles.Create(self);
  FSelectingPagingNumberStyles := TcxWebStyles.Create(self);

  FPaging := TcxWebTablePaging.Create(self);
  FCellPadding := -1;
  FBorderColor := clWebWindow;
  FBorderWidth := 1;
  FShowHeaders := True;
  Width := 300;
  Height := 200;
end;

destructor TcxCustomWebTable.Destroy;
begin
  FPaging.Free;
  FAlternatingItemsStyles.Free;

  FHeaderStyles.Free;
  FItemsStyles.Free;
  FPagingStyles.Free;
  FPagingNumbersStyles.Free;
  FSelectingPagingNumberStyles.Free;

  FColumns.Free;

  inherited Destroy;
end;

procedure TcxCustomWebTable.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and not (csDestroying in ComponentState) then
  begin
    if AComponent is TcxWebStyleItem then
    begin
      AlternatingItemsStyles.Notification(AComponent, opRemove);
      HeaderStyles.Notification(AComponent, opRemove);
      ItemsStyles.Notification(AComponent, opRemove);
      PagingStyles.Notification(AComponent, opRemove);
      PagingNumbersStyles.Notification(AComponent, opRemove);
      SelectingPagingNumberStyles.Notification(AComponent, opRemove);
    end;
  end;
end;

procedure TcxCustomWebTable.ColumnClick(const AParameters: TcxActionParameters);
var
  AColumnIndex: Integer;
begin
  if AParameters.ParamString <> '' then
    AColumnIndex := StrToInt(AParameters.ParamString)
  else AColumnIndex := 0;
  DoColumnClick(AColumnIndex);
end;

procedure TcxCustomWebTable.PagingClick(const AParameters: TcxActionParameters);
var
  APageIndex: Integer;
begin
  if AParameters.ParamString <> '' then
    APageIndex := StrToInt(AParameters.ParamString)
  else APageIndex := 0;
  DoPagingClick(APageIndex);
end;

procedure TcxCustomWebTable.RowClick(const AParameters: TcxActionParameters);
var
  AColIndex: Integer;
  S: string;
begin
  S := GetActionParameter(AParameters.ParamString, 0);
  if S <> '' then
    AColIndex := StrToInt(S)
  else AColIndex := 0;
  S := GetActionParameter(AParameters.ParamString, 1);
  DoRowClick(AColIndex, S);
end;

procedure TcxCustomWebTable.GetURL(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer; AURL: TcxURL);
begin
  AURL.Href := Format('javascript:__doPostBack(''%s'', ''ROWCLICK:%d:%d'')',
                [Name, AColumn.Index, ARecIndex]);
end;

procedure TcxCustomWebTable.GetTitleHTML(AColumn: TcxCustomWebTableColumn;
  const AHRef: String; var AHTML: String);
begin
  if Assigned(OnGetTitleHTML) then
    OnGetTitleHTML(self, AColumn, AHRef, AHTML);
end;

procedure TcxCustomWebTable.GetBeforePagingHTML(APagingType: TcxWebTablePagingType; var AHTML: string);
begin
  if Assigned(OnGetBeforePagingHTML) then
    OnGetBeforePagingHTML(self, APagingType, AHTML)
  else AHTML := '';
end;

procedure TcxCustomWebTable.GetAfterPagingHTML(APagingType: TcxWebTablePagingType; var AHTML: string);
begin
  if Assigned(OnGetAfterPagingHTML) then
    OnGetAfterPagingHTML(self, APagingType, AHTML)
  else AHTML := '';  
end;

function TcxCustomWebTable.GetPagingNumberStatus(APageIndex: Integer): string;
begin
  Result := 'Page ' + IntToStr(APageIndex);
  if Assigned(OnGetPagingStatus) then
    OnGetPagingStatus(self, APageIndex, Result);
end;

procedure TcxCustomWebTable.DoColumnClick(AColumnIndex: Integer);
begin
end;

procedure TcxCustomWebTable.DoPagingClick(APageIndex: Integer);
begin
end;

procedure TcxCustomWebTable.DoRowClick(AColIndex: Integer; ARowValue: string);
begin
end;

procedure TcxCustomWebTable.DoBeforeWriteRow(AHTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer);
begin
  if Assigned(OnBeforeWriteRow) then
    OnBeforeWriteRow(self, AHTMLTextBuilder, ARowIndex);
end;

procedure TcxCustomWebTable.DoEndWriteRow(AHTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer);
begin
  if Assigned(OnEndWriteRow) then
    OnEndWriteRow(self, AHTMLTextBuilder, ARowIndex);
end;


procedure TcxCustomWebTable.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', ColumnClick);
  WebActionsHelper.RegisterAction('COLUMNCLICK', ColumnClick);
  WebActionsHelper.RegisterAction('PAGINGCLICK', PagingClick);
  WebActionsHelper.RegisterAction('ROWCLICK', RowClick);
end;


procedure TcxCustomWebTable.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebTableRenderer);
end;

procedure TcxCustomWebTable.ScriptsSubscription;
begin
  inherited ScriptsSubscription;;
  if (Styles.Hover <> nil) or (AlternatingItemsStyles.Hover <> nil) or
    (HeaderStyles.Hover <> nil) or (ItemsStyles.Hover <> nil) or
    (PagingStyles.Hover <> nil) or (PagingNumbersStyles.Hover <> nil) or
    (SelectingPagingNumberStyles.Hover <> nil)then
    WebScriptsHelper.ScriptSubscription(TcxWebChangeStyleScript);
  if (Paging.PagingType <> tptNone) or GetAllowSorting then
    WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

procedure TcxCustomWebTable.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  AddStylesToProviderList(AList, [AlternatingItemsStyles, HeaderStyles,
                ItemsStyles, PagingStyles, PagingNumbersStyles,
                SelectingPagingNumberStyles]);
end;

function TcxCustomWebTable.GetStartRowIndex: Integer;
begin
  if Paging.PagingType = tptNone then
    Result := 0
  else Result := GetPageIndex * Paging.PagingSize;
end;

function TcxCustomWebTable.GetEndRowIndex: Integer;
begin
  if Paging.PagingType = tptNone then
    Result := GetRecordCount - 1
  else
  begin
    Result := (GetPageIndex + 1) * Paging.PagingSize  - 1;
    if Result >= GetRecordCount then
     Result := GetRecordCount - 1;
  end;
end;

procedure TcxCustomWebTable.SetShowHeaders(const Value: Boolean);
begin
  if ShowHeaders <> Value then
  begin
    FShowHeaders := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebTable.SetAlternatingItemsStyles(const Value: TcxWebStyles);
begin
  AlternatingItemsStyles.Assign(Value);
end;

procedure TcxCustomWebTable.SetCellPadding(const Value: Integer);
begin
  if Value < -1 then exit;
  if CellPadding <> Value then
  begin
    FCellPadding := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebTable.SetBorderColor(const Value: TcxWebColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebTable.SetBorderWidth(const Value: Integer);
begin
  if Value < 0 then exit;
  if BorderWidth <> Value then
  begin
    FBorderWidth := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebTable.SetCellSpacing(const Value: Integer);
begin
  if Value < 0 then exit;
  if CellSpacing <> Value then
  begin
    FCellSpacing := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebTable.SetHeaderStyles(const Value: TcxWebStyles);
begin
  HeaderStyles.Assign(Value);
end;

procedure TcxCustomWebTable.SetItemsStyles(const Value: TcxWebStyles);
begin
  ItemsStyles.Assign(Value);
end;

procedure TcxCustomWebTable.SetPaging(const Value: TcxWebTablePaging);
begin
  Paging.Assign(Value);
end;

procedure TcxCustomWebTable.SetPagingStyles(const Value: TcxWebStyles);
begin
  PagingStyles.Assign(Value);
end;

procedure TcxCustomWebTable.SetPagingNumbersStyles(const Value: TcxWebStyles);
begin
  PagingNumbersStyles.Assign(Value);
end;

procedure TcxCustomWebTable.SetSelectingPagingNumberStyles(const Value: TcxWebStyles);
begin
  SelectingPagingNumberStyles.Assign(Value);
end;

{ TcxWebTableColumn }
constructor TcxWebTableColumn.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSortMode := tsmNone;
end;

procedure TcxWebTableColumn.Assign(Source: TPersistent);
begin
  if Source is TcxWebTableColumn then
  begin
    FSortMode := TcxWebTableColumn(Source).SortMode;
    UpdateTable;
  end else inherited Assign(Source);
end;

procedure TcxWebTableColumn.SetSortMode(const Value: TcxWebTableColumnSortMode);
begin
  if SortMode <> Value then
  begin
    FSortMode := Value;
    UpdateTable;
  end;
end;

{ TcxWebTableColumns }

function TcxWebTableColumns.Add: TcxWebTableColumn;
begin
  Result := TcxWebTableColumn(inherited Add);
end;

function TcxWebTableColumns.GetItem(Index: Integer): TcxWebTableColumn;
begin
  Result := TcxWebTableColumn(inherited Items[Index]);
end;

procedure TcxWebTableColumns.SetItem(Index: Integer; const Value: TcxWebTableColumn);
begin
  Items[Index].Assign(Value);
end;

{TcxWebTable}
constructor TcxWebTable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Paging.FPagingSizeChagned := DoPagingSizeChanged;
end;

function TcxWebTable.CreateColumns: TcxCustomWebTableColumns;
begin
  Result := TcxWebTableColumns.Create(TcxWebTableColumn);
end;

function TcxWebTable.GetRecordCount: Integer;
begin
  Result := FRecordCount;
end;

function TcxWebTable.GetDisplayText(AColumn: TcxCustomWebTableColumn;  ARecIndex: Integer): string;
begin
  if Assigned(OnGetDisplayText) then
    OnGetDisplayText(self, TcxWebTableColumn(AColumn), ARecIndex, Result);
end;

function TcxWebTable.GetValue(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer): Variant;
begin
 if Assigned(OnGetValue) then
    OnGetValue(self, TcxWebTableColumn(AColumn), ARecIndex, Result);
end;

procedure TcxWebTable.GetURL(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer; AURL: TcxURL);
begin
  inherited GetURL(AColumn, ARecIndex, AURL);
  if Assigned(OnGetHrefValue) then
    OnGetHrefValue(self, AColumn as TcxWebTableColumn, ARecIndex, AURL);
end;

function TcxWebTable.GetPageIndex: Integer;
begin
  Result := PageIndex;
end;

function TcxWebTable.GetAllowSorting: Boolean;
begin
  Result := FAllowSorting;
end;

procedure TcxWebTable.DoColumnClick(AColumnIndex: Integer);
begin
  if Assigned(onColumnClick) and (AColumnIndex > -1)
   and (AColumnIndex < Columns.Count) then
    onColumnClick(self, Columns[AColumnIndex]);
end;

procedure TcxWebTable.DoPagingClick(APageIndex: Integer);
begin
  PageIndex := APageIndex;
end;

procedure TcxWebTable.DoRowClick(AColIndex: Integer; ARowValue: string);
var
  ARowIndex: Integer;
begin
  if Assigned(onCellClick) and (AColIndex > -1) and (AColIndex < Columns.Count) then
  begin
    if ARowValue <> '' then
      ARowIndex := StrToInt(ARowValue)
    else ARowIndex := 0;
    onCellClick(self, Columns[AColIndex], ARowIndex);
  end;  
end;

function TcxWebTable.GetColumns: TcxWebTableColumns;
begin
  Result := TcxWebTableColumns(inherited Columns);
end;

procedure TcxWebTable.SetColumns(const Value: TcxWebTableColumns);
begin
  BeginUpdateDesignerContext;
  Columns.Assign(Value);
  EndUpdateDesignerContext;
end;

procedure TcxWebTable.DoPagingSizeChanged(Sender: TObject);
begin
  PageIndex := 0;
end;

procedure TcxWebTable.SetPageIndex(Index: Integer);
begin
  if not (csLoading in ComponentState) and ((Index < 0) or (Index * Paging.PagingSize > GetRecordCount)) then
    exit;
  FPageIndex := Index;
end;

procedure TcxWebTable.SetAllowSorting(const Value: Boolean);
begin
  if AllowSorting <> Value then
  begin
    FAllowSorting := Value;
    UpdateDesignerContext;
  end;
end;

procedure TcxWebTable.SetRecordCount(Value: Integer);
begin
  if Value < 0 then exit;
  if (RecordCount <> Value) then
  begin
    FRecordCount := Value;
    FPageIndex := 0;
    UpdateDesignerContext;
  end;
end;

{TcxCustomWebTableRenderer}
function TcxCustomWebTableRenderer.Table: TcxCustomWebTable;
begin
  Result := Component as TcxCustomWebTable;
end;

function TcxCustomWebTableRenderer.MaxPageIndex: Integer;
begin
  Result := Table.Paging.MaxPageIndex;
end;


function TcxCustomWebTableRenderer.GetColumn(AIndex: Integer): TcxCustomWebTableColumn;
begin
  Result := Table.Columns.Items[AIndex] as TcxCustomWebTableColumn;
end;

function TcxCustomWebTableRenderer.GetCellText(AColumn: TcxCustomWebTableColumn; AIndex: Integer): string;
begin
  Result := Trim(Table.GetDisplayText(AColumn, AIndex));
  Result := HTMLString(Result);
  if Result = '' then  Result := '&nbsp;';
end;

function TcxCustomWebTableRenderer.GetColumnTitle(AColumn: TcxCustomWebTableColumn): string;
begin
  Result := AColumn.Title;
  if Result = '' then
    Result := '&nbsp;';
end;


procedure TcxCustomWebTableRenderer.WriteHTML;
begin
  if (csDesigning in Table.ComponentState) then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSpan);
    HTMLTextBuilder.WriteStyleAttribute(saHeight, WebControl.Height, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, WebControl.Width, 'px');
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aRules, 'all');
  HTMLTextBuilder.WriteAttribute(aBorder, Table.BorderWidth);
  if Table.BorderColor <> clWebWindow then
    HTMLTextBuilder.WriteAttribute(aBordercolor, cxWebColorToWebString(Table.BorderColor));
  HTMLTextBuilder.WriteAttribute(aCellspacing, Table.CellSpacing);
  if Table.CellPadding > -1 then
   HTMLTextBuilder.WriteAttribute(aCellPadding, Table.CellPadding);

  WriteID;
  WriteEvents;
  WritePosition;
  WriteZIndex;
  if Table.MaximumWidth then
    HTMLTextBuilder.WriteStyleAttribute(saWidth, '100%')
  else HTMLTextBuilder.WriteStyleAttribute(saWidth, WebControl.Width, 'px');
  if Table.Styles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, Table.Styles.Default.FullName);
  WriteComponentEvents(Table.Styles.Hover);
  WriteAttributes;
  WriteStyleAttributes;

  if Table.Paging.PagingType in [tptTop, tptBoth] then
    WritePaging(tptTop);

  if Table.ShowHeaders then
    WriteHeaders;
  WriteItems;

  if Table.Paging.PagingType in [tptBottom, tptBoth] then
    WritePaging(tptBottom);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  if (csDesigning in Table.ComponentState) then
  begin
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagSpan);
  end;
end;

procedure TcxCustomWebTableRenderer.WriteHeaders;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  if Table.HeaderStyles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, Table.HeaderStyles.Default.FullName);
  for I := 0 to Table.Columns.Count - 1 do
    WriteHeader(GetColumn(I));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxCustomWebTableRenderer.WriteItems;
var
  I: Integer;
begin
  for I := Table.GetStartRowIndex to Table.GetEndRowIndex do
  begin
    Table.DoBeforeWriteRow(HTMLTextBuilder, I);
    WriteRow(I);
    Table.DoEndWriteRow(HTMLTextBuilder, I);
  end;  
end;

procedure TcxCustomWebTableRenderer.WriteHeader(AColumn: TcxCustomWebTableColumn);
var
  AHref, AHTMLText: string;
  AHTMLTextBuilder: TcxHTMLTextBuilder;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  if AColumn.Width > 0 then HTMLTextBuilder.WriteAttribute(aWidth, AColumn.Width);
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[AColumn.TitleAlignment]);
  AHTMLTextBuilder := TcxHTMLTextBuilder.Create(HTMLTextBuilder.Browser);
  try
    if Table.GetAllowSorting then
    begin
      AHTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
      if Table.HeaderStyles.Default <> nil then
        AHTMLTextBuilder.WriteAttribute(aClass, Table.HeaderStyles.Default.FullName);
      WriteComponentEvents(Table.HeaderStyles.Hover, AHTMLTextBuilder);
      AHref := Format('javascript:__doPostBack(''%s'', ''COLUMNCLICK:%d'')', [Table.Name, AColumn.Index]);
      AHTMLTextBuilder.WriteAttribute(cxWebRender.aHref, AHref);
    end else AHref := '';
    AHTMLTextBuilder.WriteText(GetColumnTitle(AColumn), False, False);
    if Table.GetAllowSorting then
      AHTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
    AHTMLText := AHTMLTextBuilder.Text;
    Table.GetTitleHTML(AColumn, AHRef, AHTMLText);
  finally
    AHTMLTextBuilder.Free;
  end;
  HTMLTextBuilder.WriteText(AHTMLText, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
end;

procedure TcxCustomWebTableRenderer.WriteRow(AIndex: Integer);
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  WriteRowStyle(AIndex);
  for I := 0 to Table.Columns.Count - 1 do
    WriteCell(GetColumn(I), AIndex);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxCustomWebTableRenderer.WriteRowStyle(AIndex: Integer);
begin
  if (Table.AlternatingItemsStyles.Default <> nil) and (AIndex mod 2 = 1) then
  begin
    if Table.AlternatingItemsStyles.Default <> nil then
      HTMLTextBuilder.WriteAttribute(aClass, Table.AlternatingItemsStyles.Default.FullName);
    WriteComponentEvents(Table.AlternatingItemsStyles.Hover);
  end else
  begin
    if Table.ItemsStyles.Default <> nil then
      HTMLTextBuilder.WriteAttribute(aClass, Table.ItemsStyles.Default.FullName);
    WriteComponentEvents(Table.ItemsStyles.Hover);
  end;
end;

procedure TcxCustomWebTableRenderer.WriteCell(AColumn: TcxCustomWebTableColumn; AIndex: Integer);
var
 AProc: TcxWebTableRenderWriteCellProc;
begin
  AProc := GetRenderWriteCellProc(AColumn);
  AProc(AColumn, AIndex);
end;

function TcxCustomWebTableRenderer.GetRenderWriteCellProc(AColumn: TcxCustomWebTableColumn): TcxWebTableRenderWriteCellProc;
begin
  Result := WriteTextCell;
  case AColumn.ViewType of
    tvtText: Result := WriteTextCell;
    tvtHyperText: Result := WriteHRefCell;
    tvtImage: Result := WriteImageCell;    
    else Assert(True, 'RenderCellProc is not register for that type');
  end;
end;

procedure TcxCustomWebTableRenderer.WriteTextCell(AColumn: TcxCustomWebTableColumn; AIndex: Integer);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  if not AColumn.WordWrap then
    HTMLTextBuilder.WriteAttribute(aNowrap);
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[AColumn.Alignment]);
  if AColumn.Styles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, AColumn.Styles.Default.FullName);
  WriteComponentEvents(AColumn.Styles.Hover);
  HTMLTextBuilder.WriteText(GetCellText(AColumn, AIndex), False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
end;

procedure TcxCustomWebTableRenderer.WriteHrefCell(AColumn: TcxCustomWebTableColumn; AIndex: Integer);
var
  AURL: TcxURL;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[AColumn.Alignment]);
  if AColumn.Styles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, AColumn.Styles.Default.FullName);
  WriteComponentEvents(AColumn.Styles.Hover);
  AURL := TcxURL.Create(nil);
  try
    Table.GetURL(AColumn, AIndex, AURL);
    if AURL.Href <> '' then
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
      if AColumn.Styles.Default <> nil then
      begin
        HTMLTextBuilder.WriteAttribute(aClass, AColumn.Styles.Default.FullName);
        WriteComponentEvents(AColumn.Styles.Hover);
      end
      else WriteRowStyle(AIndex);
      AURL.Write(HTMLTextBuilder);
      HTMLTextBuilder.WriteText(GetCellText(AColumn, AIndex), False, False);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
    end else
    begin
      WriteRowStyle(AIndex);
      HTMLTextBuilder.WriteText(GetCellText(AColumn, AIndex), False, False);
    end;
  finally
    AURL.Free;
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
end;

procedure TcxCustomWebTableRenderer.WriteImageCell(AColumn: TcxCustomWebTableColumn; AIndex: Integer);
var
{$IFDEF VCL}
  AGraphicClass: TGraphicClass;
{$ENDIF}  
  ImgHeight, ImgWidth: Integer;
  APictureURL: string;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[AColumn.Alignment]);
  if AColumn.Styles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, AColumn.Styles.Default.FullName);
  WriteComponentEvents(AColumn.Styles.Hover);

{$IFDEF VCL}
  AGraphicClass := nil;
{$ENDIF}
  if Assigned(Table.OnLoadImage) then
    Table.OnLoadImage(Table, AColumn{$IFDEF VCL}, AGraphicClass{$ENDIF});
  try
    LoadImage(Table.GetValue(AColumn, AIndex){$IFDEF VCL}, AGraphicClass{$ENDIF}, APictureURL, ImgHeight, ImgWidth);
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
    HTMLTextBuilder.WriteAttribute(aSrc, APictureURL);
    HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
    HTMLTextBuilder.WriteAttribute(aHspace, 0);
    HTMLTextBuilder.WriteAttribute(aVspace, 0);
  except
    HTMLTextBuilder.WriteText('Unable to load image', False, False);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
end;

procedure TcxCustomWebTableRenderer.WritePaging(APagingType: TcxWebTablePagingType);
var
  I, AStartPage, AEndPage: Integer;
  ACustomHTML: string;
begin
  if MaxPageIndex = 0 then exit;

  AStartPage := Table.Paging.StartPageIndex;
  AEndPage := Table.Paging.EndPageIndex;

  Table.GetBeforePagingHTML(APagingType, ACustomHTML);
  if ACustomHTML <> '' then
    HTMLTextBuilder.WriteText(ACustomHTML);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[Table.Paging.Alignment]);
  if Table.PagingStyles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, Table.PagingStyles.Default.FullName);
  WriteComponentEvents(Table.PagingStyles.Hover);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aColspan, Table.Columns.Count);

  WritePageIndex('<&lt;', '&lt;', Table.GetPageIndex - 1, False);
  HTMLTextBuilder.WriteText('&nbsp;');
  if Table.Paging.MaxPageNumbers > 0 then
    for I := AStartPage to AEndPage - 1 do
    begin
      WritePageIndex('', '', I, True);
      HTMLTextBuilder.WriteText('&nbsp;');
    end;
  WritePageIndex('>&gt;', '&gt;', Table.GetPageIndex + 1, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  Table.GetAfterPagingHTML(APagingType, ACustomHTML);
  if ACustomHTML <> '' then
    HTMLTextBuilder.WriteText(ACustomHTML);
end;

procedure TcxCustomWebTableRenderer.WritePageIndex(AText, ADisableText: string;
        APageIndex: Integer; IsNumber: Boolean);
var
  AMouseOverStr, AMouseOutStr: string;
begin
  if AText = '' then
    AText := IntToStr(APageIndex + 1);
  if ADisableText = '' then
    ADisableText := IntToStr(APageIndex + 1);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSpan);
  if (APageIndex = Table.GetPageIndex) or (APageIndex < 0) or
    (APageIndex > MaxPageIndex) then
  begin
    if IsNumber and (Table.SelectingPagingNumberStyles.Default <> nil) then
      HTMLTextBuilder.WriteAttribute(aClass, Table.SelectingPagingNumberStyles.Default.FullName)
    else
      if Table.PagingNumbersStyles.Default <> nil then
        HTMLTextBuilder.WriteAttribute(aClass, Table.PagingNumbersStyles.Default.FullName);
    WriteComponentEvents(Table.SelectingPagingNumberStyles.Hover);
    HTMLTextBuilder.WriteText('&nbsp;' + ADisableText + '&nbsp;');
  end else
  begin
    if Table.PagingNumbersStyles.Default <> nil then
      HTMLTextBuilder.WriteAttribute(aClass, Table.PagingNumbersStyles.Default.FullName);
    WriteComponentEvents(Table.PagingNumbersStyles.Hover);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA);
    HTMLTextBuilder.WriteAttribute(aHref,
        Format('javascript:__doPostBack(''%s'', ''PAGINGCLICK:%d'')',
        [Table.Name, APageIndex]));
    if Table.PagingNumbersStyles.Default <> nil then
      HTMLTextBuilder.WriteAttribute(aClass, Table.PagingNumbersStyles.Default.FullName);

    if not Table.IsDesigning then
    begin
      AMouseOverStr := Format('status =''%s'';', [Table.GetPagingNumberStatus(APageIndex + 1)]);
      AMouseOutStr := 'status =''''; ';
      if (Table.PagingNumbersStyles.Hover <> nil) then
      begin
        AMouseOverStr := AMouseOverStr + GetHoverStyleProc(Table.PagingNumbersStyles.Hover);
        AMouseOutStr := AMouseOutStr + GetDefaultStyleProc(Table.PagingNumbersStyles.Hover);
      end;
      AMouseOverStr := AMouseOverStr + ' return true;';
      HTMLTextBuilder.WriteEventAttribute(eOnMouseOver, AMouseOverStr);
      HTMLTextBuilder.WriteEventAttribute(eOnMouseOut, AMouseOutStr);
    end;

    HTMLTextBuilder.WriteText('&nbsp;' + AText + '&nbsp;');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagSpan);
end;

procedure TcxCustomWebTableRenderer.WriteComponentEvents(const Style: TcxWebStyleItem;
  AHTMLTextBuilder: TcxHTMLTextBuilder = nil);
begin
  if AHTMLTextBuilder = nil then
    AHTMLTextBuilder := HTMLTextBuilder;
  if not Table.IsDesigning and (Style <> nil) then
  begin
    AHTMLTextBuilder.WriteEventAttribute(eOnMouseOver, GetHoverStyleProc(Style));
    AHTMLTextBuilder.WriteEventAttribute(eOnMouseOut, GetDefaultStyleProc(Style));
  end;
end;

initialization
  RegisterClasses([TcxCustomWebTableColumn, TcxWebTableColumn, TcxWebTable]);
  
end.
