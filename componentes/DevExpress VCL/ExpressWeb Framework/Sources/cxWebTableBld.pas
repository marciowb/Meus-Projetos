{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       HTML Rendering Module                                       }
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
unit cxWebTableBld;

{$I cxVer.inc}

interface

uses
  Classes, Types,
  cxWebIntf, cxWebRender, cxWebClasses, cxWebUpdateControlPosition;

type

  TcxWebTableBuilderClass = class of TcxWebTableBuilder;
  TcxWebTableBuilder = class
  public
    class procedure WriteControlHTML(HTMLTextBuilder: TcxHTMLTextBuilder;
        AControl: IcxWebControl; ANeedTable: Boolean; AExcludeList: TList); virtual;
    class procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder;
        AContainer: IcxWebContainerControl; ANeedTable: Boolean; AExcludeList: TList); virtual;
  end;

  TcxWebHTMLTableBuilder = class;

  TcxWebHTMLTableBuilderCol = class
  private
    FControl: TcxCustomWebUpdateControlPositionItem;
    FOffSetCellList: TList;
    FColumnIndex: Integer;
    FColSpanCount: Integer;

    FRowSpanCount: Integer;
    FOffsetColSpanCount: Integer;

    function GetOffSetCellsColSpanCount(Index: Integer): Integer;
  public
    constructor Create(AControl: TcxCustomWebUpdateControlPositionItem; AColumnIndex, AColSpanCount: Integer);
    destructor Destroy; override;

    procedure AddOffSetCell(ASpanCount: Integer);
    function OffSetCellCount: Integer;
    property OffSetCellsColSpanCount[Index: Integer]: Integer read GetOffSetCellsColSpanCount;

    property Control: TcxCustomWebUpdateControlPositionItem read FControl;
    property ColumnIndex: Integer read FColumnIndex;
    property ColSpanCount: Integer read FColSpanCount;
    property RowSpanCount: Integer read FRowSpanCount write FRowSpanCount;
    property OffsetColSpanCount: Integer read FOffsetColSpanCount write FOffsetColSpanCount;
  end;


  TcxWebHTMLTableBuilderRow = class
  private
    FBuilder: TcxWebHTMLTableBuilder;
    FColSpanCount: Integer;
    FHeightOffSet: Integer;
    FTop: Integer;
    FCols: TList;
    FLeftColumn: TcxWebHTMLTableBuilderCol;

    function GetColCount: Integer;
    function GetCol(Index: Integer): TcxWebHTMLTableBuilderCol;
  public
    constructor Create(ABuilder: TcxWebHTMLTableBuilder; AControl: TcxCustomWebUpdateControlPositionItem);
    destructor Destroy; override;
    procedure AddControl(AControl: TcxCustomWebUpdateControlPositionItem);
    procedure Update(AIndex: Integer);

    property ColSpanCount: Integer read FColSpanCount;
    property HeightOffSet: Integer read FHeightOffSet;
    property ColCount: Integer read GetColCount;
    property Cols[Index: Integer]: TcxWebHTMLTableBuilderCol read GetCol;
    property LeftColumn: TcxWebHTMLTableBuilderCol read FLeftColumn;
    property Top: Integer read FTop;
  end;

  TcxWebHTMLTableBuilder = class
  private
    FColumns: TList;
    FControls: TList;
    FRows: TList;
    FHeight: Integer;
    FWidth: Integer;

    function GetColumnCount: Integer;
    function GetColumnWidth(Index: Integer): Integer;
    function GetControlCount: Integer;
    function GetControl(Index: Integer): TcxCustomWebUpdateControlPositionItem;
    function GetRowCount: Integer;
    function GetRow(Index: Integer): TcxWebHTMLTableBuilderRow;
  protected
    procedure PrepareColumns;
    procedure PrepareRows;

    property ControlCount: Integer read GetControlCount;
    property Controls[Index: Integer]: TcxCustomWebUpdateControlPositionItem read GetControl;
  public
    constructor Create(AControls: TList);
    destructor Destroy; override;

    function WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder; AName: string): string;

    property ColumnCount: Integer read GetColumnCount;
    property ColumnWidth[Index: Integer]: Integer read GetColumnWidth;
    property RowCount: Integer read GetRowCount;
    property Rows[Index: Integer]: TcxWebHTMLTableBuilderRow read GetRow;
    property Height: Integer read FHeight;
    property Width: Integer read FWidth;
  end;

const
   cxWebTableBuilderAttribute = 'ewf_tablebuilder';

implementation

uses
  SysUtils,
  cxWebUtils;

{ TcxWebHTMLTableBuilderCol }
constructor TcxWebHTMLTableBuilderCol.Create(AControl: TcxCustomWebUpdateControlPositionItem;
        AColumnIndex, AColSpanCount: Integer);
begin
  FControl := AControl;
  FColumnIndex := AColumnIndex;
  FColSpanCount := AColSpanCount;
  FOffSetCellList := TList.Create;
end;

destructor TcxWebHTMLTableBuilderCol.Destroy;
begin
  FOffSetCellList.Free;
  inherited Destroy;
end;

function TcxWebHTMLTableBuilderCol.OffSetCellCount: Integer;
begin
  Result := FOffSetCellList.Count;
end;

function TcxWebHTMLTableBuilderCol.GetOffSetCellsColSpanCount(Index: Integer): Integer;
begin
  Result := Integer(FOffSetCellList[Index]);
end;

procedure TcxWebHTMLTableBuilderCol.AddOffSetCell(ASpanCount: Integer);
begin
  FOffSetCellList.Add(Pointer(ASpanCount));
end;

constructor TcxWebHTMLTableBuilderRow.Create(ABuilder: TcxWebHTMLTableBuilder;
        AControl: TcxCustomWebUpdateControlPositionItem);
begin
  FBuilder := ABuilder;
  FCols := TList.Create;
  FLeftColumn := TcxWebHTMLTableBuilderCol.Create(AControl, 0, 0);
  FTop := AControl.BoundsRect.Top;
  AddControl(AControl);
end;

destructor TcxWebHTMLTableBuilderRow.Destroy;
var
  I: Integer;
begin
  FLeftColumn.Free;
  for I := 0 to ColCount - 1 do
    Cols[I].Free;
  FCols.Free;
  inherited Destroy;
end;

function TcxWebHTMLTableBuilderRow.GetColCount: Integer;
begin
  Result := FCols.Count;
end;

function TcxWebHTMLTableBuilderRow.GetCol(Index: Integer): TcxWebHTMLTableBuilderCol;
begin
  Result := TcxWebHTMLTableBuilderCol(FCols[Index]);
end;

procedure TcxWebHTMLTableBuilderRow.AddControl(AControl: TcxCustomWebUpdateControlPositionItem);

  procedure InsertColumn(ACol: TcxWebHTMLTableBuilderCol);
  var
    I: Integer;
    AIsFound: Boolean;
  begin
    AIsFound := False;
    for I := 0 to ColCount - 1 do
      if ACol.ColumnIndex < Cols[I].ColumnIndex then
      begin
        AIsFound := True;
        FCols.Insert(I, ACol);
        break;
      end;
    if not AIsFound then
      FCols.Add(ACol);  
  end;

var
  ACol: TcxWebHTMLTableBuilderCol;
  AColumnIndex, AColSpanCount: Integer;
begin
  AColumnIndex := FBuilder.FColumns.IndexOf(Pointer(AControl.BoundsRect.Left));
  AColSpanCount := 0;
  while AControl.BoundsRect.Right > FBuilder.ColumnWidth[AColumnIndex + AColSpanCount]  do
  begin
    Inc(AColSpanCount);
    if AColumnIndex + AColSpanCount >= FBuilder.ColumnCount then
      break;
  end;
  ACol := TcxWebHTMLTableBuilderCol.Create(AControl, AColumnIndex, AColSpanCount);
  InsertColumn(ACol);
end;

procedure TcxWebHTMLTableBuilderRow.Update(AIndex: Integer);

   function GetColumnOffSetByRow(ACol: TcxWebHTMLTableBuilderCol;
     AColumnIndex, ARowIndex: Integer; var APrevColIndex: Integer): Integer;
   var
     I: Integer;
     ARow: TcxWebHTMLTableBuilderRow;
   begin
     Result := 0;
     ARow := FBuilder.Rows[ARowIndex];
     for I := 0 to ARow.ColCount - 1 do
     begin
       if ARow.Cols[I].ColumnIndex > AColumnIndex then
         break;
       if (ARow.Cols[I].ColumnIndex >= APrevColIndex)  and
         (ARowIndex + ARow.Cols[I].RowSpanCount > AIndex) then
       begin
         if (ARow.Cols[I].ColumnIndex > APrevColIndex) then
         begin
           if ACol <> nil then
             ACol.AddOffSetCell(ARow.Cols[I].ColumnIndex - APrevColIndex)
           else Inc(Result);
           Inc(Result, ARow.Cols[I].ColumnIndex - APrevColIndex);
         end;
         Inc(Result, ARow.Cols[I].ColSpanCount);
         APrevColIndex := ARow.Cols[I].ColumnIndex + ARow.Cols[I].ColSpanCount;
       end;
     end;
   end;

   procedure GetColumnOffSet(ACol: TcxWebHTMLTableBuilderCol; AColIndex: Integer);
   var
     I, APrevColIndex, AResult: Integer;
   begin
     AResult := 0;
     if ACol.OffsetColSpanCount = 0 then exit;
     if AColIndex > 0 then
       with FBuilder.Rows[AIndex].Cols[AColIndex - 1] do
         APrevColIndex := ColumnIndex + ColSpanCount
     else APrevColIndex := 0;
     for I := 0 to AIndex - 1 do
       Inc(AResult, GetColumnOffSetByRow(ACol, ACol.ColumnIndex, I, APrevColIndex));
     if (AResult < ACol.OffsetColSpanCount) then
       ACol.AddOffSetCell(ACol.OffsetColSpanCount - AResult);
   end;

   procedure UpdateCol(ACol: TcxWebHTMLTableBuilderCol; AColIndex: Integer);
   begin
     if AColIndex = 0 then
     begin
       ACol.OffsetColSpanCount := ACol.ColumnIndex;
     end else
       with Cols[AColIndex - 1] do
         ACol.OffsetColSpanCount := ACol.ColumnIndex - ColumnIndex - ColSpanCount;
     GetColumnOffSet(ACol, AColIndex);
     ACol.RowSpanCount := 0;
     while ACol.Control.BoundsRect.Bottom > FBuilder.Rows[AIndex + ACol.RowSpanCount].Top do
     begin
       Inc(ACol.FRowSpanCount);
       if AIndex + ACol.RowSpanCount >= FBuilder.RowCount then
         break;
     end;
   end;

   procedure UpdateLeftColumn(ALeftColSpanCount: Integer);
   var
     APrevColIndex: Integer;
     I : Integer;
   begin
     APrevColIndex := ALeftColSpanCount;
     for I := 0 to AIndex - 1 do
     begin
       Inc(ALeftColSpanCount, GetColumnOffSetByRow(FLeftColumn, FBuilder.ColumnCount - 1, I, APrevColIndex));
       if ALeftColSpanCount >= FBuilder.ColumnCount then
         break;
     end;
     if ALeftColSpanCount < FBuilder.ColumnCount then
       FLeftColumn.AddOffSetCell(FBuilder.ColumnCount - ALeftColSpanCount);
   end;

var
  I: Integer;
  ALeftColSpanCount: Integer;
begin
  if (AIndex < FBuilder.RowCount - 1) then
    FHeightOffSet := FBuilder.Rows[AIndex + 1].Top - Top
  else FHeightOffSet := FBuilder.Height - Top;
  ALeftColSpanCount := 0;
  for I := 0 to ColCount - 1 do
  begin
    UpdateCol(Cols[I], I);
    Inc(ALeftColSpanCount, Cols[I].OffsetColSpanCount);
    Inc(ALeftColSpanCount, Cols[I].ColSpanCount);
  end;
  UpdateLeftColumn(ALeftColSpanCount);
end;

{ TcxWebHTMLTableBuilder }
constructor TcxWebHTMLTableBuilder.Create(AControls: TList);
begin
  FControls := AControls;
  FColumns := TList.Create;
  FRows := TList.Create;

  PrepareColumns;
  PrepareRows;
end;

destructor TcxWebHTMLTableBuilder.Destroy;
var
  I: Integer;
begin
  for I := 0 to RowCount - 1 do
    Rows[I].Free;
  FColumns.Free;
  FRows.Free;
  
  inherited Destroy;
end;

function TcxWebHTMLTableBuilder.GetColumnCount: Integer;
begin
  Result := FColumns.Count;
end;

function TcxWebHTMLTableBuilder.GetColumnWidth(Index: Integer): Integer;
begin
  Result := Integer(FColumns[Index]);
end;

function TcxWebHTMLTableBuilder.GetControlCount: Integer;
begin
  Result := FControls.Count;
end;

function TcxWebHTMLTableBuilder.GetControl(Index: Integer): TcxCustomWebUpdateControlPositionItem;
begin
  Result := TcxCustomWebUpdateControlPositionItem(FControls[Index]);
end;

function TcxWebHTMLTableBuilder.GetRowCount: Integer;
begin
  Result := FRows.Count;
end;

function TcxWebHTMLTableBuilder.GetRow(Index: Integer): TcxWebHTMLTableBuilderRow;
begin
  Result := TcxWebHTMLTableBuilderRow(FRows[Index]);
end;

procedure TcxWebHTMLTableBuilder.PrepareColumns;
var
  ASortedControls: TList;

  procedure AddSortedControl(AControl: TcxCustomWebUpdateControlPositionItem);
  var
    I: Integer;
    AIsFound: Boolean;
    ALeft: Integer;
  begin
    AIsFound := False;
    ALeft := AControl.BoundsRect.Left;
    for I := 0 to ASortedControls.Count - 1 do
      if (ALeft < TcxCustomWebUpdateControlPositionItem(ASortedControls[I]).BoundsRect.Left) then
      begin
        AIsFound := True;
        ASortedControls.Insert(I, AControl);
        break;
      end;
    if not AIsFound then
      ASortedControls.Add(AControl);
  end;

  procedure AddColumn(AControl, ANextControl: TcxCustomWebUpdateControlPositionItem);
  begin
    if (ColumnCount = 0) or (AControl.BoundsRect.Left > ColumnWidth[ColumnCount - 1]) then
    begin
      FColumns.Add(Pointer(AControl.BoundsRect.Left));
      if (ANextControl <> nil ) and
        (AControl.BoundsRect.Right < ANextControl.BoundsRect.Left) then
          FColumns.Add(Pointer(AControl.BoundsRect.Right))

    end
  end;

var
  I: Integer;
  AControl: TcxCustomWebUpdateControlPositionItem;
begin
  ASortedControls := TList.Create;
  for I := 0 to ControlCount - 1 do
    AddSortedControl(Controls[I]);

  FWidth := 0;
  for I := 0 to ASortedControls.Count - 1 do
  begin
    AControl := TcxCustomWebUpdateControlPositionItem(ASortedControls[I]);
    if I < ASortedControls.Count - 1 then
      AddColumn(AControl, TcxCustomWebUpdateControlPositionItem(ASortedControls[I + 1]))
    else AddColumn(AControl, nil);
    if AControl.BoundsRect.Right > FWidth then
      FWidth := AControl.BoundsRect.Right;
  end;
  if Width > 0 then
  begin
    FColumns.Insert(0, Pointer(0));
    FColumns.Add(Pointer(Width));
  end;
  ASortedControls.Free;
end;

procedure TcxWebHTMLTableBuilder.PrepareRows;

  function CreateNewRow(AControl: TcxCustomWebUpdateControlPositionItem): TcxWebHTMLTableBuilderRow;
  begin
    Result := TcxWebHTMLTableBuilderRow.Create(self, AControl);
  end;

  procedure AddRow(AControl: TcxCustomWebUpdateControlPositionItem);
  var
    I: Integer;
    AIsFound: Boolean;
    ATop: Integer;
  begin
    AIsFound := False;
    ATop := AControl.BoundsRect.Top;
    for I := 0 to RowCount - 1 do
      if (ATop <= Rows[I].Top) then
      begin
        AIsFound := True;
        if (ATop < Rows[I].Top) then
          FRows.Insert(I, CreateNewRow(AControl))
        else Rows[I].AddControl(AControl);
        break;
      end;
    if not AIsFound then
      FRows.Add(CreateNewRow(AControl));
  end;

var
  I: Integer;
begin
  FHeight := 0;
  for I := 0 to ControlCount - 1 do
  begin
    AddRow(Controls[I]);
    if Controls[I].BoundsRect.Bottom > FHeight then
      FHeight := Controls[I].BoundsRect.Bottom;
  end;
  for I := 0 to RowCount - 1 do
    Rows[I].Update(I);
end;

function TcxWebHTMLTableBuilder.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder; AName: string): string;

   procedure WriteTableHeader;
   begin
     HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
     HTMLTextBuilder.WriteAttribute(aId, AName + 'Table');
     HTMLTextBuilder.WriteAttribute(aHeight, Height);
     HTMLTextBuilder.WriteAttribute(aWidth, Width);
     HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
     HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
     HTMLTextBuilder.WriteAttribute(aBorder, 0);
     HTMLTextBuilder.WriteUnknownAttribute(cxWebTableBuilderAttribute + '="true"');
   end;

   procedure WriteTableFooter;
   begin
     HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
   end;

   procedure WriteRowHeader(Height: Integer = 0);
   begin
     HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
     HTMLTextBuilder.WriteAttribute(aValign, 'top');
     if Height > 0 then
       HTMLTextBuilder.WriteAttribute(aHeight, Height);
   end;

   procedure WriteRowFooter;
   begin
     HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
   end;

   procedure WriteFirstRow;
   var
     I: Integer;
   begin
     WriteRowHeader;
     for I := 1 to ColumnCount - 1 do
     begin
       HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);

       if I = 1 then
       begin
         HTMLTextBuilder.WriteAttribute(aWidth, ColumnWidth[I]);
         HTMLTextBuilder.WriteAttribute(aHeight, Rows[0].Top);
       end
       else HTMLTextBuilder.WriteAttribute(aWidth, ColumnWidth[I] - ColumnWidth[I - 1]);
       HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
     end;
     WriteRowFooter;
   end;

   procedure WriteOffsetColSpan(ACol: TcxWebHTMLTableBuilderCol; AIndex, ARowHeightOffSet: Integer);

     procedure WriteHeight;
     begin
       if AIndex = 0 then
         HTMLTextBuilder.WriteAttribute(aHeight, ARowHeightOffSet);
     end;

     procedure WriteCollSpanCount(ACount: Integer);
     begin
       if ACount > 1 then
         HTMLTextBuilder.WriteAttribute(aColspan, ACount);
     end;

   var
     I: Integer;
   begin
     if ACol.OffSetCellCount > 0 then
     begin
       for I := 0 to ACol.OffSetCellCount - 1 do
       begin
         HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
         WriteCollSpanCount(ACol.OffSetCellsColSpanCount[I]);
         if I = 0 then WriteHeight;
         HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
       end;
     end;
   end;

   procedure WriteCol(ARow: TcxWebHTMLTableBuilderRow; ACol: TcxWebHTMLTableBuilderCol; AIndex: Integer);

     procedure WriteColSpan;
     begin
       if ACol.ColSpanCount > 1 then
         HTMLTextBuilder.WriteAttribute(aColspan, ACol.ColSpanCount);
     end;

     procedure WriteRowSpan;
     begin
       if ACol.RowSpanCount > 1 then
         HTMLTextBuilder.WriteAttribute(aRowspan, ACol.RowSpanCount);
     end;

   begin
     WriteOffsetColSpan(ACol, AIndex, ARow.HeightOffSet);
     HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
     WriteColSpan;
     WriteRowSpan;
     ACol.Control.WriteHTML(HTMLTextBuilder);
     HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
   end;

   procedure WriteRow(ARow: TcxWebHTMLTableBuilderRow);
   var
     I: Integer;
   begin
     WriteRowHeader(ARow.HeightOffSet);
     for I := 0 to ARow.ColCount - 1 do
       WriteCol(ARow, ARow.Cols[I], I);
     WriteOffsetColSpan(ARow.LeftColumn, -1, 0);
     WriteRowFooter;
   end;

var
  I: Integer;
begin
  if (Height > 0) and (Width > 0) then
  begin
    WriteTableHeader;
    WriteFirstRow;
    for I := 0 to RowCount - 1 do
      WriteRow(Rows[I]);
    WriteTableFooter;
  end;
end;

{ TcxWebTableBuilder }
type
  TcxWebUpdateControlPositionItem = class(TcxCustomWebUpdateControlPositionItem)
  private
    FWebControl: IcxWebControl;
  protected
    function GetBoundsRect: TRect; override;
    procedure SetBoundsRect(const Value: TRect); override;
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  public
    constructor Create(AWebControl: IcxWebControl);
  end;

constructor TcxWebUpdateControlPositionItem.Create(AWebControl: IcxWebControl);
begin
  FWebControl := AWebControl;
end;

function TcxWebUpdateControlPositionItem.GetBoundsRect: TRect;
begin
  Result := FWebControl.BoundsRect;
  if FWebControl.Parent <> nil then
    with FWebControl.Parent do
      OffsetRect(Result, - GetClientLeft, - GetClientTop);
end;

procedure TcxWebUpdateControlPositionItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  TcxWebTableBuilder.WriteControlHTML(HTMLTextBuilder, FWebControl, True, nil);
end;

procedure TcxWebUpdateControlPositionItem.SetBoundsRect(const Value: TRect);
var
  R: TRect;
begin
  R := Value;
  if FWebControl.Parent <> nil then
    with FWebControl.Parent do
      OffsetRect(R, GetClientLeft, GetClientTop);
  FWebControl.SetBoundsRect(R);
end;

procedure UpdateControlsPosition(AContainer: IcxWebContainerControl; AExcludeList: TList);
var
  AList: TList;
  I: Integer;
begin
  AList := TList.Create;
  for I := 0 to AContainer.ControlCount - 1 do
    if (AExcludeList = nil) or
      (AExcludeList.IndexOf(GetComponentByInterface(AContainer.Controls[I])) < 0) then
      AList.Add(TcxWebUpdateControlPositionItem.Create(AContainer.Controls[I]));
  UpdateWebControlsPosition(AList);
  for I := 0 to AList.Count - 1 do
    TcxWebUpdateControlPositionItem(AList[I]).Free;
  AList.Free;
end;

function CreateControlList(AContainer: IcxWebContainerControl; AExcludeList: TList): TList;
var
  I: Integer;
  AControl: IcxWebControl;
begin
  Result := TList.Create;
  for I := 0 to AContainer.ControlCount - 1 do
  begin
    AControl := AContainer.Controls[I];
    if (AControl.Visible) and
    ((AExcludeList = nil) or
    (AExcludeList.IndexOf(GetComponentByInterface(AControl)) < 0)) then
      Result.Add(TcxWebUpdateControlPositionItem.Create(AControl));
  end;
end;

class procedure TcxWebTableBuilder.WriteControlHTML(HTMLTextBuilder: TcxHTMLTextBuilder;
    AControl: IcxWebControl; ANeedTable: Boolean; AExcludeList: TList);
var
  Container: IcxWebContainerControl;
  CodeIntf: IcxCodeProvider;
  ContainerCodeIntf: IcxContainerCodeProvider;
begin
  if AControl.Visible and ((AExcludeList = nil) or
      (AExcludeList.IndexOf(GetComponentByInterface(AControl)) < 0)) then
  begin
    if Supports(AControl, IcxWebContainerControl, Container) then
    begin
      if Supports(AControl, IcxContainerCodeProvider, ContainerCodeIntf) then
      begin
        ContainerCodeIntf.WriteBeginHTML(HTMLTextBuilder);
        WriteHTML(HTMLTextBuilder, Container, ANeedTable, AExcludeList);
        ContainerCodeIntf.WriteEndHTML(HTMLTextBuilder);
      end;
    end
    else if Supports(AControl, IcxCodeProvider, CodeIntf) then
      CodeIntf.WriteHTML(HTMLTextBuilder)
  end;
end;

class procedure TcxWebTableBuilder.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder;
    AContainer: IcxWebContainerControl; ANeedTable: Boolean; AExcludeList: TList);
var
  I: Integer;
  ABuilder: TcxWebHTMLTableBuilder;
  AControlList: TList;
  AComponent: TComponent;
begin
  if ANeedTable then
  begin
    UpdateControlsPosition(AContainer, AExcludeList);
    AControlList := CreateControlList(AContainer, AExcludeList);
    ABuilder := TcxWebHTMLTableBuilder.Create(AControlList);
    try
      AComponent := GetComponentByInterface(AContainer);
      ABuilder.WriteHTML(HTMLTextBuilder, AComponent.Name);
    finally
      ABuilder.Free;
      for I := 0 to AControlList.Count - 1 do
        TcxWebUpdateControlPositionItem(AControlList[I]).Free;
      AControlList.Free;
    end;
  end
  else
  begin
    for I := 0 to AContainer.ControlCount - 1 do
      WriteControlHTML(HTMLTextBuilder, AContainer.Controls[I], ANeedTable, AExcludeList);
  end;
end;

end.

