{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppCTRend;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Classes, SysUtils, Graphics, ExtCtrls, Forms,
  ppCTCell, ppCTMain, ppDevice, ppDrwCmd, ppTypes, ppUtils, ppPrintr;

type

  {@TppCustomCrossTabRenderer }
  TppCustomCrossTabRenderer = class(TObject)
    private
      FCrossTab: TppCrossTab;
      FEndColumn: Integer;
      FEndRow: Integer;
      FFormat: Boolean;
      FMatrix: TppMatrix;
      FPrinter: TppPrinter;
      FStartColumn: Integer;
      FStartRow: Integer;
      FStatus: String;

    protected
      function  GetElement(aIndex: Integer): TppElement;
      procedure SetStatus(const aStatus: String);

    public
      constructor Create(aCrossTab: TppCrossTab); virtual;

      class function Description: String; virtual;
      class function LocalizedDescription: String; virtual;

      function  CalcSpaceUsed(aMatrix: TppMatrix; aHeight, aWidth: Longint; aPrinter: TppPrinter): Longint; virtual;
      procedure CreateDrawCommands(aPage: TppPage; aMatrix: TppMatrix; aLeft, aTop: Longint); virtual;

      property CrossTab: TppCrossTab read FCrossTab;
      property Matrix: TppMatrix read FMatrix;
      property Printer: TppPrinter read FPrinter;
      property StartColumn: Integer read FStartColumn write FStartColumn;
      property StartRow: Integer read FStartRow write FStartRow;
      property EndColumn: Integer read FEndColumn write FEndColumn;
      property EndRow: Integer read FEndRow write FEndRow;
      property Format: Boolean read FFormat write FFormat;
      property Status: String read FStatus;

  end; {class, TppCustomCrossTabRenderer}

  {@TppCrossTabRenderer }
  TppCrossTabRenderer = class(TppCustomCrossTabRenderer)
    private
      FColumnWidths: TList;
      FCompletedHorizontalLines: TStringList;
      FCompletedVerticalLines: TStringList;
      FCompletedLines: TStringList;
      FCompletedShapes: TStringList;
      FCompletedText: TList;
      FHorizontalLines: TStringList;
      FRowHeights: TList;
      FVerticalLines: TStringList;

    protected
      {draw routines}
      procedure AddLinesToPage(aPage: TppPage);
      procedure AddShapesToPage(aPage: TppPage);
      procedure AddTextToPage(aPage: TppPage);
      procedure CalcTextDimensions(const aText: String; aFont: TFont; var aWidth, aHeight: Integer);
      procedure CreateLines(aElement: TppElement; aColumn, aRow: Integer; aLeft, aTop, aWidth, aHeight: Integer);
      procedure CreateShape(aElement: TppElement; aLeft, aTop, aWidth, aHeight: Longint);
      procedure CreateText(aElement: TppElement; aColumn, aRow: Integer; aLeft, aTop, aWidth, aHeight: Longint);
      procedure DrawCells(aPage: TppPage; var aLeft, aTop: Longint);
      procedure ExpandTextDimensions(aDrawText: TppDrawText; aColumn, aRow: Integer);
      function  PositionToHorizontalLine(const aPosition: String; aLeft, aWidth: Integer): Boolean;
      function  PositionToVerticalLine(const aPosition: String; aTop, aHeight: Integer): Boolean;

      {calc routines}
      procedure AllocateHeight(aColumn, aRow: Integer; aHeight: Longint; aCount: Integer);
      procedure AllocateWidth(aColumn, aRow: Integer; aWidth: Longint; aCount: Integer);
      procedure CalcValueHeightAndWidth;
      procedure CalcCaptionTextSize(aElement: TppElement; aColumn, aRow: Integer);
      procedure CalcColumnCaptionHeightAndWidth;
      procedure CalcRowCaptionHeightAndWidth;
      function  GetColumnWidth(aColumn: Integer): Integer;
      function  GetRowHeight(aRow: Integer): Integer;
      function  GetValueAsText(aColumn, aRow: Integer): String;
      function  GetValueText(aColumn, aRow: Integer): String;
      function  GetTotalLabelText(aColumn, aRow: Integer): String;
      function  GetFont(aColumn, aRow: Integer): TFont;
      function  IsCaption(aColumn, aRow: Integer): Boolean;

      {calc routines: column captions}
      procedure AdjustTotalColumnWidths;
      procedure AllocateColumnCaptionHeights;
      procedure AllocateColumnCaptionWidths;
      procedure CalcColumnCaptionTextSizes;
      procedure CoalesceColumnCaptionHeights;
      procedure CoalesceColumnCaptionWidths;
      procedure PositionColumnFieldLabels;
      procedure PositionValueFieldLabels;

      {calc routines: row captions}
      procedure AdjustTotalRowHeights;
      procedure AllocateRowCaptionHeights;
      procedure AllocateRowCaptionWidths;
      procedure CalcRowCaptionTextSizes;
      procedure CoalesceRowCaptionHeights;
      procedure CoalesceRowCaptionWidths;
      procedure PositionRowFieldLabels;

      procedure DrawCellsToPage(aPage: TppPage; aMatrix: TppMatrix; aLeft, aTop: Longint); virtual;

    public
      constructor Create(aCrossTab: TppCrossTab); override;
      destructor Destroy; override;

      class function Description: String; override;
      class function LocalizedDescription: String; override;

      function  CalcSpaceUsed(aMatrix: TppMatrix; aHeight, aWidth: Longint; aPrinter: TppPrinter): Longint; override;
      procedure CreateDrawCommands(aPage: TppPage; aMatrix: TppMatrix; aLeft, aTop: Longint); override;

  end; {class, TppCrossTabRenderer}

  TppCrossTabRendererClass = class of TppCustomCrossTabRenderer;

  {@TppCTRendererRepeatCaptions }
  TppCTRendererRepeatCaptions = class(TppCrossTabRenderer)
    public
      constructor Create(aCrossTab: TppCrossTab); override;
      destructor Destroy; override;

      class function Description: String; override;
      class function LocalizedDescription: String; override;

      function  CalcSpaceUsed(aMatrix: TppMatrix; aHeight, aWidth: Longint; aPrinter: TppPrinter): Longint; override;
      procedure DrawCellsToPage(aPage: TppPage; aMatrix: TppMatrix; aLeft, aTop: Longint); override;

  end; {class, TppCTRendererRepeatCaptions}

  {register procedures}
  function  ppRendererClassIndex(const aClassName: String): Integer;
  function  ppRendererClassForName(const aClassName: String): TppCrossTabRendererClass;
  function  ppRendererClassForDescription(const aDescription: String): TppCrossTabRendererClass;
  procedure ppGetRendererClasses(aList: TStrings);
  function  ppRegisteredRendererCount: Integer;
  procedure ppRegisterRenderer(aRendererClass: TppCrossTabRendererClass);
  procedure ppUnRegisterRenderer(aRendererClass: TppCrossTabRendererClass);

implementation

var
  FRendererClassList: TList = nil;

{******************************************************************************
 *
 ** C R O S S T A B   V A L U E   C H E C K E R
 *
{******************************************************************************}

type

  {@TppCrosstabGetValueTextEvent}
  TppCrosstabGetValueTextEvent = function(aColumn, aRow: Integer): String of object;

  {@TppCrossTabValueChecker}
  TppCrosstabValueTracker = class
    private
      FColumn: Integer;
      FMatrix: TppMatrix;
      FOnGetValueText: TppCrosstabGetValueTextEvent;
      FValueList: TStringList;

      procedure SetColumn(aColumn: Integer);

    protected
      function DoOnGetValueText(aColumn, aRow: Integer): String;

    public
      constructor Create;
      destructor Destroy; override;

      function ValueChanged(aRow: Integer): Boolean;
      procedure UpdateValues(aRow: Integer);

      property Matrix: TppMatrix read FMatrix write FMatrix;
      property Column: Integer read FColumn write SetColumn;

      property OnGetValueText: TppCrosstabGetValueTextEvent read FOnGetValueText write FOnGetValueText;

  end;

{------------------------------------------------------------------------------}
{ TppCrosstabValueTracker.Create }

constructor TppCrosstabValueTracker.Create;
begin

  inherited Create;

  FColumn := 0;
  FMatrix := nil;
  FOnGetValueText := nil;
  FValueList := TStringList.Create;

end;

{------------------------------------------------------------------------------}
{ TppCrosstabValueTracker.Destroy }

destructor TppCrosstabValueTracker.Destroy;
begin

  FValueList.Free;

  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppCrosstabValueTracker.SetColumn }

procedure TppCrosstabValueTracker.SetColumn(aColumn: Integer);
begin

  FColumn := aColumn;

  UpdateValues(Matrix.ColumnHeaderCount);

end;

{------------------------------------------------------------------------------}
{ TppCrosstabValueTracker.ValueChanged }

function TppCrosstabValueTracker.ValueChanged(aRow: Integer): Boolean;
var
  liColumn: Integer;
  lsValue: String;
  lsMatrixValue: String;
begin

  Result := False;

  liColumn := 0;

  while not(Result) and (liColumn <= FColumn) do
    begin
      lsValue := FValueList[liColumn];

      lsMatrixValue := DoOnGetValueText(liColumn, aRow);

      if (lsValue <> lsMatrixValue) then
        begin
          Result := True;

          FValueList[liColumn] := lsValue;
        end
      else
        Inc(liColumn);
    end;

end;

{------------------------------------------------------------------------------}
{ TppCrosstabValueTracker.UpdateValues }

procedure TppCrosstabValueTracker.UpdateValues(aRow: Integer);
var
  liColumn: Integer;
begin

  FValueList.Clear;

  for liColumn := 0 to FColumn do
    FValueList.Add(DoOnGetValueText(liColumn, aRow));

end;

{------------------------------------------------------------------------------}
{ TppCrosstabValueTracker.DoOnGetValueText }

function TppCrosstabValueTracker.DoOnGetValueText(aColumn, aRow: Integer): String;
begin
  if Assigned(FOnGetValueText) then
    Result := FOnGetValueText(aColumn, aRow)
  else
    Result := '';
end;

{******************************************************************************
 *
 ** R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppGetRendererClassList }

function ppGetRendererClassList: TList;
begin

  if FRendererClassList = nil then
    FRendererClassList := TList.Create;

  Result := FRendererClassList;

end; {function, ppGetRendererClassList}

{------------------------------------------------------------------------------}
{ ppRendererClassIndex }

function ppRendererClassIndex(const aClassName: String): Integer;
var
  lList: TList;
  liIndex: Integer;
begin

  lList := ppGetRendererClassList;

  liIndex := 0;
  Result := -1;

  while (Result = -1) and (liIndex < lList.Count) do
    begin
      if (CompareText(aClassName, TppCrossTabRendererClass(lList[liIndex]).ClassName) = 0) then
        Result := liIndex;

      Inc(liIndex);
    end;

end; {function, ppRendererClassIndex}

{------------------------------------------------------------------------------}
{ ppRendererClassForName }

function ppRendererClassForName(const aClassName: String): TppCrossTabRendererClass;
var
  liPosition: Integer;
begin

  liPosition := ppRendererClassIndex(aClassName);

  if (liPosition <> -1) then
    Result := TppCrossTabRendererClass(ppGetRendererClassList[liPosition])
  else
    Result := nil;

end; {function, ppRendererClassForName}

{------------------------------------------------------------------------------}
{ ppRendererClassForDescription }

function ppRendererClassForDescription(const aDescription: String): TppCrossTabRendererClass;
var
  lList: TStringList;
  liPosition: Integer;
begin

  lList := TStringList.Create;

  ppGetRendererClasses(lList);

  liPosition := lList.IndexOf(aDescription);

  if (liPosition <> -1) then
    Result := TppCrossTabRendererClass(lList.Objects[liPosition])
  else
    Result := nil;

  lList.Free;

end; {function, ppRendererClassForDescription}

{------------------------------------------------------------------------------}
{ ppGetRendererClasses }

procedure ppGetRendererClasses(aList: TStrings);
var
  lClassList: TList;
  liIndex: Integer;
  lClass: TppCrossTabRendererClass;
begin

  lClassList := ppGetRendererClassList;

  for liIndex := 0 to lClassList.Count - 1 do
    begin
      lClass := TppCrossTabRendererClass(lClassList[liIndex]);

      aList.AddObject(lClass.Description, TObject(lClass));
    end;

end; {procedure, GetRendererClasses}

{------------------------------------------------------------------------------}
{ ppRegisteredRendererCount }

function ppRegisteredRendererCount: Integer;
begin
  Result := ppGetRendererClassList.Count;
end; {procedure, ppRegisteredRendererCount}

{------------------------------------------------------------------------------}
{ ppRegisterRenderer }

procedure ppRegisterRenderer(aRendererClass: TppCrossTabRendererClass);
var
  lClassList: TList;
  liIndex: Integer;
begin

  if (aRendererClass = nil) then Exit;

  lClassList := ppGetRendererClassList;

  liIndex :=  lClassList.IndexOf(aRendererClass);

  if (liIndex = -1) then
    lClassList.Add(aRendererClass);

end; {procedure, ppRegisterRenderer}

{------------------------------------------------------------------------------}
{ ppUnRegisterRenderer }

procedure ppUnRegisterRenderer(aRendererClass: TppCrossTabRendererClass);
var
  lClassList: TList;
  liIndex: Integer;
begin

  if (aRendererClass = nil) then Exit;

  if (FRendererClassList = nil) then Exit;

  lClassList := ppGetRendererClassList;

  liIndex := lClassList.IndexOf(aRendererClass);

  if (liIndex > 0) then
    lClassList.Delete(liIndex);

end; {procedure, ppUnRegisterRenderer}

{******************************************************************************
 *
 ** C U S T O M   C R O S S T A B   R E N D E R E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomCrossTabRenderer.Create }

constructor TppCustomCrossTabRenderer.Create(aCrossTab: TppCrossTab);
begin

  inherited Create;

  FCrossTab := aCrossTab;
  FEndColumn := -1;
  FEndRow := -1;
  FFormat := False;
  FMatrix := nil;
  FPrinter := nil;
  FStartColumn := -1;
  FStartRow := -1;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomCrossTabRenderer.Description }

class function TppCustomCrossTabRenderer.Description: String;
begin
  Result := ClassName;
end; {class function, Description}

{------------------------------------------------------------------------------}
{ TppCustomCrossTabRenderer.LocalizedDescription }

class function TppCustomCrossTabRenderer.LocalizedDescription: String;
begin
  Result := Description;
end; {class function, LocalizedDescription}


{------------------------------------------------------------------------------}
{ TppCustomCrossTabRenderer.GetElement }

function TppCustomCrossTabRenderer.GetElement(aIndex: Integer): TppElement;
begin
  Result := nil;

  if (FCrossTab = nil) then Exit;

  if (aIndex = -1) then
    Result := FCrossTab.GetElement(0)
  else
    Result := FCrossTab.GetElement(aIndex);

end; {procedure, GetElement}

{------------------------------------------------------------------------------}
{ TppCustomCrossTabRenderer.CalcSpaceUsed }

function TppCustomCrossTabRenderer.CalcSpaceUsed(aMatrix: TppMatrix; aHeight, aWidth: Longint; aPrinter: TppPrinter): Longint;
begin

  FMatrix := aMatrix;
  FPrinter := aPrinter;

  Result := 0;

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppCustomCrossTabRenderer.CreateDrawCommands }

procedure TppCustomCrossTabRenderer.CreateDrawCommands(aPage: TppPage; aMatrix: TppMatrix; aLeft, aTop: Longint);
begin
  FMatrix := aMatrix;
end; {procedure, CreateDrawCommands}

{------------------------------------------------------------------------------}
{ TppCustomCrossTabRenderer.SetStatus }

procedure TppCustomCrossTabRenderer.SetStatus(const aStatus: String);
begin
  FStatus := aStatus;

  FCrossTab.ProcessMessages;
  
end; {procedure, SetStatus}

{******************************************************************************
 *
 ** C R O S S T A B   R E N D E R E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.Create }

constructor TppCrossTabRenderer.Create(aCrossTab: TppCrossTab);
begin

  inherited Create(aCrossTab);

  FColumnWidths := TList.Create;
  FRowHeights := TList.Create;

  SetStatus(ppLoadStr(76)); {'Formatting CrossTab: Compute cell heights and widths.'}

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.Destroy }

destructor TppCrossTabRenderer.Destroy;
begin

  FColumnWidths.Free;
  FRowHeights.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.Description }

class function TppCrossTabRenderer.Description: String;
begin
  {do not localize}
  Result := 'Standard';
end; {class function, Description}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.LocalizedDescription }

class function TppCrossTabRenderer.LocalizedDescription: String;
begin
  Result := ppLoadStr(490); {Standard}
end; {class function, LocalizedDescription}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CalcSpaceUsed }

function TppCrossTabRenderer.CalcSpaceUsed(aMatrix: TppMatrix; aHeight, aWidth: Longint; aPrinter: TppPrinter): Longint;
var
  llHeightAvailable: Longint;
  llWidthAvailable: Longint;
  llHeightUsed: Longint;
  llWidthUsed: Longint;
  liColumns: Integer;
  liRows: Integer;
begin

  inherited CalcSpaceUsed(aMatrix, aHeight, aWidth, aPrinter);

  if (Format) then
    begin
      CalcValueHeightAndWidth;
      CalcColumnCaptionHeightAndWidth;
      CalcRowCaptionHeightAndWidth;

      Format := False;
    end;

  llHeightAvailable := aHeight;
  llWidthAvailable := aWidth;

  llHeightUsed := 0;
  liRows := Matrix.RowCount;
  EndRow := StartRow;

  while (llHeightUsed <= llHeightAvailable) and (EndRow < liRows) do
    begin
      llHeightUsed := llHeightUsed + GetRowHeight(EndRow);

      if (llHeightUsed <= llHeightAvailable) then
        EndRow := EndRow + 1;
    end;

  EndRow := EndRow - 1;


  llWidthUsed := 0;
  liColumns := Matrix.ColumnCount;
  EndColumn := StartColumn;
  
  while (llWidthUsed <= llWidthAvailable) and (EndColumn < liColumns) do
    begin
      llWidthUsed := llWidthUsed + GetColumnWidth(EndColumn);

      if (llWidthUsed <= llWidthAvailable) then
        EndColumn := EndColumn + 1;
    end;

  EndColumn := EndColumn - 1;

  {set space used and overflow}
  Result := llHeightUsed;

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CreateDrawCommands }

procedure TppCrossTabRenderer.CreateDrawCommands(aPage: TppPage; aMatrix: TppMatrix; aLeft, aTop: Longint);
begin

  inherited CreateDrawCommands(aPage, aMatrix, aLeft, aTop);

  FHorizontalLines := TStringList.Create;
  FVerticalLines := TStringList.Create;
  FCompletedHorizontalLines := TStringList.Create;
  FCompletedHorizontalLines.Sorted := True;
  FCompletedHorizontalLines.Duplicates := dupAccept;
  FCompletedVerticalLines := TStringList.Create;
  FCompletedVerticalLines.Sorted := True;
  FCompletedVerticalLines.Duplicates := dupAccept;

  FCompletedLines := TStringList.Create;
  FCompletedShapes := TStringList.Create;
  FCompletedText := TList.Create;

  try

    DrawCellsToPage(aPage, aMatrix, aLeft, aTop);

    AddShapesToPage(aPage);
    AddTextToPage(aPage);
    AddLinesToPage(aPage);

  finally
    FHorizontalLines.Free;
    FVerticalLines.Free;
    
    FCompletedHorizontalLines.Free;
    FCompletedVerticalLines.Free;

    FCompletedLines.Free;
    FCompletedShapes.Free;
    FCompletedText.Free;
  end;

end; {procedure, CreateDrawCommands}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.DrawCellsToPage }

procedure TppCrossTabRenderer.DrawCellsToPage(aPage: TppPage; aMatrix: TppMatrix; aLeft, aTop: Longint);
begin
  DrawCells(aPage, aLeft, aTop);
end; {procedure, DrawCellsToPage}

{******************************************************************************
 *
 ** C A L C   R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CalcColumnCaptionHeightAndWidth }

procedure TppCrossTabRenderer.CalcColumnCaptionHeightAndWidth;
var
  liColumn: Integer;
  liRow: Integer;
  lsCaption: String;
  liCaptionWidth: Integer;
  liCaptionHeight: Integer;
  lFont: TFont;
begin

  if (CrossTab.ColumnDefCount > 0) then
    begin
      CalcColumnCaptionTextSizes;

      CoalesceColumnCaptionWidths;

      CoalesceColumnCaptionHeights;

      AllocateColumnCaptionWidths;

      AllocateColumnCaptionHeights;

      PositionColumnFieldLabels;

      PositionValueFieldLabels;
    end

  else
    begin
      liColumn := FCrosstab.RowDefCount;
      liRow := 1;

      lsCaption := FMatrix.Value[liColumn, liRow];
      lFont := GetFont(liColumn, liRow);

      CalcTextDimensions(lsCaption, lFont, liCaptionWidth, liCaptionHeight);

      liCaptionWidth := liCaptionWidth + (ciTextMargin * 2);

      if (Integer(FColumnWidths[0]) < liCaptionWidth) then
        FColumnWidths[0] := TObject(liCaptionWidth);
    end;

end; {procedure, CalcColumnCaptionHeightAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CalcRowCaptionHeightAndWidth }

procedure TppCrossTabRenderer.CalcRowCaptionHeightAndWidth;
begin

  if (CrossTab.RowDefCount = 0) then Exit;

  CalcRowCaptionTextSizes;

  CoalesceRowCaptionHeights;

  CoalesceRowCaptionWidths;

  AllocateRowCaptionHeights;

  AllocateRowCaptionWidths;

  PositionRowFieldLabels;

end; {procedure, CalcRowCaptionHeightAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CalcTextDimensions }

procedure TppCrossTabRenderer.CalcTextDimensions(const aText: String; aFont: TFont; var aWidth, aHeight: Integer);
var
  lCanvas: TCanvas;
  lBitmap: TBitmap;
  lsText: String;
begin

  if (Printer <> nil) then
    begin
      lCanvas := Printer.Canvas;

      lBitmap := nil;
    end
  else
    begin
      lBitmap := TBitmap.Create;

      lCanvas := lBitmap.Canvas;
    end;

  lCanvas.Font := aFont;

  if (aText = '') then
    lsText := 'W'
  else
    lsText := aText;

  aWidth := lCanvas.TextWidth(lsText);
  aHeight := lCanvas.TextHeight(lsText);

  if (Printer <> nil) then
    begin
      aWidth := ppToMMThousandths(aWidth, utPrinterPixels, pprtHorizontal, Printer);
      aHeight := ppToMMThousandths(aHeight, utPrinterPixels, pprtVertical, Printer);
    end
  else
    begin
      aWidth := ppToMMThousandths(aWidth, utScreenPixels, pprtHorizontal, nil);
      aHeight := ppToMMThousandths(aHeight, utScreenPixels, pprtVertical, nil);
    end;

  if (Printer = nil) then
    lBitmap.Free;

end; {function, CalcTextDimensions}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CalcValueHeightAndWidth }

procedure TppCrossTabRenderer.CalcValueHeightAndWidth;
var
  liStartRow: Integer;
  liEndRow: Integer;
  liStartColumn: Integer;
  liEndColumn: Integer;
  liColumn: Integer;
  liColumnNo: Integer;
  liRow: Integer;
  liRowNo: Integer;
  liWidth: Integer;
  liMaxWidth: Integer;
  liHeight: Integer;
  liMaxHeight: Integer;
  lsText: String;
  lsMessage: String;
  lFont: TFont;
begin

  SetStatus(ppLoadStr(77)); {'Formatting CrossTab Values: Compute cell heights and widths.'}

  FColumnWidths.Clear;
  FRowHeights.Clear;

  if (CrossTab.RowDefCount = 0) and (CrossTab.ColumnDefCount = 0) then
    liStartColumn := 0
  else
    liStartColumn := Matrix.RowHeaderCount;

  liEndColumn := Matrix.ColumnCount - 1;

  if (CrossTab.RowDefCount = 0) and (CrossTab.ColumnDefCount = 0) then
    liStartRow := 0
  else
    liStartRow := Matrix.ColumnHeaderCount;

  liEndRow := Matrix.RowCount - 1;

  for liColumn := liStartColumn to liEndColumn do
    begin
      liColumnNo := liColumn - liStartColumn;

      for liRow := liStartRow to liEndRow do
        begin
          if ((liColumn mod 10) = 0) and ((liRow mod 10) = 0) then
            begin
              {'Formatting CrossTab Values: Compute cell heights and widths. Column: <count> Row: <count>'}

              lsMessage := ppLoadStr(78);
              lsMessage := ppSetMessageParameters(lsMessage);
              lsMessage := SysUtils.Format(lsMessage, [IntToStr(liColumn), IntToStr(liRow)]);

              SetStatus(lsMessage);
            end;

          liRowNo := liRow - liStartRow;

          lsText := GetValueAsText(liColumn, liRow);
          lFont := GetFont(liColumn, liRow);

          CalcTextDimensions(lsText, lFont, liWidth, liHeight);

          liHeight := liHeight + (ciTextMargin * 2);
          liWidth := liWidth + (ciTextMargin * 2);

          if ((FColumnWidths.Count - 1) < liColumnNo) then
            FColumnWidths.Add(TObject(liWidth))
          else
            begin
              liMaxWidth := Integer(FColumnWidths[liColumnNo]);

              if (liWidth > liMaxWidth) then
                FColumnWidths[liColumnNo] := TObject(liWidth);
            end;

          if ((FRowHeights.Count - 1) < liRowNo) then
            FRowHeights.Add(TObject(liHeight))
          else
            begin
              liMaxHeight := Integer(FRowHeights[liRowNo]);

              if (liHeight > liMaxHeight) then
                FRowHeights[liRowNo] := TObject(liHeight);
            end;

        end;

    end;

  if (CrossTab.RowDefCount = 0) and (CrossTab.ColumnDefCount = 0) then
    begin
      liColumn := 0;

      for liRow := 0 to Matrix.RowCount - 1 do
        begin
          Matrix.CaptionHeight[liColumn, liRow] := Integer(FRowHeights[liRow]);
          Matrix.CaptionWidth[liColumn, liRow] := Integer(FColumnWidths[liColumn]);
        end;

      if (CrossTab.ValueDefCount > 1) then
        begin
          liRow := 0;

          for liColumn := 0 to Matrix.ColumnHeaderCount - 1 do
            begin
              Matrix.CaptionHeight[liColumn, liRow] := Integer(FRowHeights[liRow]);
              Matrix.CaptionWidth[liColumn, liRow] := Integer(FColumnWidths[liColumn]);
            end;
        end;
    end;

end; {procedure, CalcValueHeightAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.GetValueAsText }

function TppCrossTabRenderer.GetValueAsText(aColumn, aRow: Integer): String;
begin

  if ((aRow < Matrix.ColumnHeaderCount) and Matrix.IsTotalColumn(aColumn)) or
     ((aColumn < Matrix.RowHeaderCount) and Matrix.IsTotalRow(aRow)) then
    Result := GetTotalLabelText(aColumn, aRow)
  else
    Result := GetValueText(aColumn, aRow);

end; {function, GetValueAsText}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.GetValueText }

function TppCrossTabRenderer.GetValueText(aColumn, aRow: Integer): String;
var
  liElementIndex: Integer;
  lElement: TppElement;
  lValue: Variant;
  lDataType: TppDataType;
  lsDisplayFormat: String;
begin

  Result := '';

  if Matrix.IsNull[aColumn, aRow] then
    begin
      if Matrix.IsCaption[aColumn, aRow] then
        lValue := ppStringToCaption('')
      else
        lValue := '';
    end
  else
    lValue := Matrix.Value[aColumn, aRow];

  liElementIndex := Matrix.ElementIndex[aColumn, aRow];


  lsDisplayFormat := '';
  lDataType := ppVariantTypeToDataType(VarType(lValue));

  if (liElementIndex <> -1) then
    begin
      lElement := GetElement(liElementIndex);

      if ppDataTypesCompatible(lElement.GetDataType, lDataType) then
        lsDisplayFormat := lElement.DisplayFormat;
    end
  else
    lElement := nil;

  Result := ppFormat(lsDisplayFormat, lDataType, lValue);

  if ((aRow < Matrix.ColumnHeaderCount) or (aColumn < Matrix.RowHeaderCount)) then
    FCrossTab.DoOnGetCaptionText(lElement, aColumn, aRow, lsDisplayFormat, lValue, Result)

  else if (Matrix.IsTotalColumn(aColumn) or Matrix.IsTotalRow(aRow)) then
    FCrossTab.DoOnGetTotalValueText(lElement, aColumn, aRow, lsDisplayFormat, lValue, Result)

  else
    FCrossTab.DoOnGetValueText(lElement, aColumn, aRow, lsDisplayFormat, lValue, Result);

end; {function, GetValueText}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.GetTotalLabelText }

function TppCrossTabRenderer.GetTotalLabelText(aColumn, aRow: Integer): String;
var
  lElement: TppElement;
begin

  if (Matrix.ValueDefCaption[aColumn, aRow] <> '') then
    begin
      lElement := GetElement(Matrix.ElementIndex[aColumn, aRow]);

      if (lElement is TppTotalCaptionDef) and (TppTotalCaptionDef(lElement).Parent is TppGrandTotal) then
        Result := ppStringToCaption(Matrix.ValueDefCaption[aColumn, aRow])
      else
        Result := ppStringToCaption(Matrix.DefCaption[aColumn, aRow]) + ' ' + ppStringToCaption(Matrix.ValueDefCaption[aColumn, aRow]);

      FCrossTab.DoOnGetTotalCaptionText(lElement, aColumn, aRow, Result);
    end

  else if (Matrix.IsNull[aColumn, aRow]) or (Matrix.DefCaption[aColumn, aRow] <> '') then
    begin
      lElement := GetElement(Matrix.ElementIndex[aColumn, aRow]);

      if (lElement is TppTotalCaptionDef) and (TppTotalCaptionDef(lElement).Parent is TppGrandTotal) then
        Result := ppStringToCaption(Matrix.DefCaption[aColumn, aRow])
      else
        Result := ppStringToCaption(Matrix.DefCaption[aColumn, aRow]) + ' ' + ppLoadStr(70); {'Total'}

      FCrossTab.DoOnGetTotalCaptionText(lElement, aColumn, aRow, Result);
    end

  else
    Result := GetValueText(aColumn, aRow);

end; {function, GetTotalLabelText}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.GetFont }

function TppCrossTabRenderer.GetFont(aColumn, aRow: Integer): TFont;
var
  liElementIndex: Integer;
begin

  liElementIndex := Matrix.ElementIndex[aColumn, aRow];

  if (liElementIndex <> -1) then
    Result := GetElement(liElementIndex).Font
  else
    Result := GetElement(0).Font;

end; {function, GetFont}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.GetColumnWidth }

function TppCrossTabRenderer.GetColumnWidth(aColumn: Integer): Longint;
var
  liIndex: Integer;
begin

  if (aColumn < Matrix.RowHeaderCount) then
    begin
      // Result := Matrix.CaptionWidth[aColumn, Matrix.RowHeaderCount - 1];
      Result := Matrix.CaptionWidth[aColumn, 0];

      if (Result = 0) then
        Result := ppToMMThousandths(ciCellWidth, utScreenPixels, pprtHorizontal, nil);
    end
  else
    begin
      liIndex := aColumn - Matrix.RowHeaderCount;

      Result := Integer(FColumnWidths[liIndex]);
    end;

end; {function, GetColumnWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.GetRowHeight }

function TppCrossTabRenderer.GetRowHeight(aRow: Integer): Longint;
var
  liIndex: Integer;
  liColumn: Integer;
begin

  if (aRow < Matrix.ColumnHeaderCount) then
    begin
      liColumn := Matrix.ColumnHeaderCount - 1;

      while (liColumn >= Matrix.ColumnCount) do
        Dec(liColumn);

      Result := Matrix.CaptionHeight[liColumn, aRow];

      if (Result = 0) then
        Result := ppToMMThousandths(ciCellHeight, utScreenPixels, pprtVertical, nil);
    end
  else
    begin
      liIndex := aRow - Matrix.ColumnHeaderCount;

      Result := Integer(FRowHeights[liIndex]);
    end;

end; {function, GetRowHeight}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AllocateHeight }

procedure TppCrossTabRenderer.AllocateHeight(aColumn, aRow: Integer; aHeight: Longint; aCount: Integer);
var
  liRow: Integer;
  liRowNo: Integer;
  liLastRow: Integer;
  llIncrement: Longint;
  liRemainder: Integer;
  liHeight: Integer;
begin

  {compute amount to allocate to each child}
  llIncrement := aHeight div aCount;

  {allocate to each child}
  liRow := aRow;
  liLastRow := liRow + aCount;
  liRemainder := aHeight;

  while (liRow < liLastRow) do
    begin

      {if not innermost level, allocate to next level of children}
      if (aColumn < Matrix.RowHeaderCount) or (aRow < Matrix.ColumnHeaderCount) then
        begin
          liHeight := Matrix.CaptionHeight[aColumn, liRow];

          Matrix.CaptionHeight[aColumn, liRow] := liHeight + llIncrement;
        end
      else
        begin
          liRowNo := liRow - Matrix.ColumnHeaderCount;

          liHeight := Integer(FRowHeights[liRowNo]) + llIncrement;

          FRowHeights[liRowNo] := TObject(liHeight);
        end;

      {calc unallocated amount}
      liRemainder := liRemainder - llIncrement;

      Inc(liRow);

      {if next allocation is to the last row, allocate all remaining height}
      if (liRow = (liLastRow - 1)) then
        llIncrement := liRemainder;
    end;

end; {procedure, AllocateHeight}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AllocateWidth }

procedure TppCrossTabRenderer.AllocateWidth(aColumn, aRow: Integer; aWidth: Longint; aCount: Integer);
var
  liColumn: Integer;
  liLastColumn: Integer;
  llIncrement: Longint;
  liRemainder: Integer;
  liWidth: Integer;
  liColumnNo: Integer;
begin

  {compute amount to allocate to each child}
  llIncrement := aWidth div aCount;

  {allocate to each child}
  liColumn := aColumn;
  liLastColumn := aColumn + aCount;
  liRemainder := aWidth;

  while (liColumn < liLastColumn) do
    begin

      {if not innermost level, allocate to next level of children}
      if (aColumn < Matrix.RowHeaderCount) or (aRow < Matrix.ColumnHeaderCount) then
        begin
          liWidth := Matrix.CaptionWidth[liColumn, aRow];

          Matrix.CaptionWidth[liColumn, aRow] := liWidth + llIncrement;
        end
      else
        begin
          liColumnNo := liColumn - Matrix.RowHeaderCount;

          liWidth := Integer(FColumnWidths[liColumnNo]) + llIncrement;

          FColumnWidths[liColumnNo] := TObject(liWidth);
        end;

      {calc unallocated amount}
      liRemainder := liRemainder - llIncrement;

      Inc(liColumn);

      {if next allocation is to the last row, allocate all remaining height}
      if (liColumn = (liLastColumn - 1)) then
        llIncrement := liRemainder;
    end;

end; {procedure, AllocateWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CalcCaptionTextSize }

procedure TppCrossTabRenderer.CalcCaptionTextSize(aElement: TppElement; aColumn, aRow: Integer);
var
  lsText: String;
  liWidth: Integer;
  liHeight: Integer;
  lFont: TFont;
begin

  lsText := GetValueAsText(aColumn, aRow);

  lFont := GetFont(aColumn, aRow);

  CalcTextDimensions(lsText, lFont, liWidth, liHeight);

  liWidth := liWidth + (ciTextMargin * 2);
  liHeight := liHeight + (ciTextMargin * 2);

  Matrix.CaptionWidth[aColumn, aRow] := liWidth;
  Matrix.CaptionHeight[aColumn, aRow] := liHeight;

end; {procedure, CalcCaptionTextSize}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.IsCaption }

function TppCrossTabRenderer.IsCaption(aColumn, aRow: Integer): Boolean;
begin
  Result := ((aColumn < Matrix.RowHeaderCount) or (aRow < Matrix.ColumnHeaderCount)) and
            (aColumn < Matrix.ColumnCount) and (aRow < Matrix.RowCount);
end; {function, IsCaption}

{******************************************************************************
 *
 ** C A L C   R O U T I N E S :   R O W   C A P T I O N S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CalcRowCaptionTextSizes }

procedure TppCrossTabRenderer.CalcRowCaptionTextSizes;
var
  liColumn: Integer;
  liRow: Integer;
  lElement: TppElement;
  liStartRow: Integer;
begin

  SetStatus(ppLoadStr(79)); {'Formatting CrossTab Rows: Compute caption text sizes.'}

  if (CrossTab.ColumnDefCount > 0) then
    liStartRow := 1
  else
    liStartRow := 0;

  for liColumn := 0 to Matrix.RowHeaderCount - 1 do
    begin

      for liRow := liStartRow to Matrix.RowCount - 1 do
        begin
          lElement := GetElement(Matrix.ElementIndex[liColumn, liRow]);

          CalcCaptionTextSize(lElement, liColumn, liRow);
        end;

    end;

end; {procedure, CalcRowCaptionTextSizes}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CoalesceRowCaptionHeights }

procedure TppCrossTabRenderer.CoalesceRowCaptionHeights;
var
  liColumn: Integer;
  liRow: Integer;
  liStartRow: Integer;
  liEndRow: Integer;
  liLastSubTotalRow: Integer;
  lsCaption: String;
  lsPreviousCaption: String;
  lbHideLines: Boolean;
  liValueRow: Integer;
  lValueTracker: TppCrosstabValueTracker;
begin

  SetStatus(ppLoadStr(80)); {'Formatting CrossTab Rows: Coalesce caption heights.'}

  lValueTracker := TppCrossTabValueTracker.Create;

  try
    lValueTracker.Matrix := Matrix;
    lValueTracker.OnGetValueText := GetValueAsText;

    for liColumn := 0 to Matrix.RowHeaderCount - 1 do
      begin

        liStartRow := Matrix.ColumnHeaderCount;
        liEndRow := Matrix.RowCount - CrossTab.VisibleRowGrandTotalCount;
        liLastSubTotalRow := -2;
        liRow := liStartRow;
        lsPreviousCaption := '';
        liValueRow := 0;
        lValueTracker.Column := liColumn;

        while (liRow < liEndRow) do
          begin

            if (Matrix.IsTotalRow(liRow)) then
              begin
                if (Matrix.DefIndex[liColumn, liRow] <> -1) and (Matrix.DefIndex[liColumn, liRow] <= liColumn) then
                  lbHideLines := False
                else
                  lbHideLines := True;

                liValueRow := 0;
              end
            else
              begin
                lbHideLines := True;

                Inc(liValueRow);
              end;

            if (lbHideLines) and (CrossTab.ValueDefCount > 1) and (liColumn >= Matrix.RowHeaderCount - 2) then
              begin

                if (liValueRow > 1) and (((liValueRow - 1) mod CrossTab.ValueDefCount) = 0) then
                  begin
                    lbHideLines := False;

                    liValueRow := 0;
                  end;
              end;


            if lbHideLines then
              begin
                lsCaption := GetValueAsText(liColumn, liRow);

                if (lsCaption = lsPreviousCaption) and not(lValueTracker.ValueChanged(liRow)) then
                  Matrix.CaptionVisible[liColumn, liRow] := False;

                lsPreviousCaption := lsCaption;

                Matrix.Borders[liColumn, liRow, btTop] := False;

                if ((liRow - 1) <> liLastSubTotalRow) and (liRow > liStartRow) then
                  Matrix.Borders[liColumn, liRow - 1, btBottom] := False;
              end
            else
              begin

                if Matrix.IsTotalRow(liRow) and (Matrix.DefIndex[liColumn, liRow] <> -1) and (Matrix.DefIndex[liColumn, liRow] <= liColumn) then
                  begin
                    liLastSubTotalRow := liRow;
                    lsPreviousCaption := '';
                  end
                else
                  begin
                    lsCaption := GetValueAsText(liColumn, liRow);

                    lsPreviousCaption := lsCaption;

                    Inc(liValueRow);
                  end;

              end;

            lValueTracker.UpdateValues(liRow);
            
            Inc(liRow);
          end;

      end;

  finally
    lValueTracker.Free;
  end;

end; {procedure, CoalesceRowCaptionHeights}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CoalesceRowCaptionWidths }

procedure TppCrossTabRenderer.CoalesceRowCaptionWidths;
var
  liColumn: Integer;
  liRow: Integer;
begin

  SetStatus(ppLoadStr(81)); {'Formatting CrossTab Rows: Coalesce caption widths.'}

  for liRow := Matrix.ColumnHeaderCount to Matrix.RowCount - 1 do
    begin

      if (Matrix.IsTotalRow(liRow)) then
        begin
          liColumn := Matrix.FirstLabelColumnOfRowTotal(liRow) + 1;

          while (liColumn < Matrix.RowHeaderCount) do
            begin
              Matrix.CaptionVisible[liColumn, liRow] := False;

              Matrix.Borders[liColumn, liRow, btLeft] := False;

              if (liColumn > 0) then
                Matrix.Borders[liColumn - 1, liRow, btRight] := False;

              Inc(liColumn);
            end;
        end;
    end;

end; {procedure, CoalesceRowCaptionWidths}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AllocateRowCaptionHeights }

procedure TppCrossTabRenderer.AllocateRowCaptionHeights;
var
  liRow: Integer;
  liStartRow: Integer;
  liColumn: Integer;
  liRowNo: Integer;
  liCount: Integer;
  liSpanHeight: Integer;
  liHeight: Integer;
  liDifference: Integer;
  lsCaption: String;
  lsPreviousCaption: String;

  procedure AllocateHeightToCells;
  begin
    {allocate width to parent column}
    if (liHeight > liSpanHeight) then
      begin
        liDifference := liHeight - liSpanHeight;

        AllocateHeight(liColumn, liStartRow, liDifference, liCount);
      end

    {allocate width to child column}
    else if (liSpanHeight > liHeight) then
      begin
        liDifference := liSpanHeight - liHeight;

        AllocateHeight(liColumn + 1, liStartRow, liDifference, liCount);
      end;
  end;

begin

  SetStatus(ppLoadStr(81)); {'Formatting CrossTab Rows: Allocate caption heights.'}

  {determine height of total rows by comparing caption height to value height}
  AdjustTotalRowHeights;

  liSpanHeight := 0;
  liHeight := 0;
  liCount := 0;
  liStartRow := Matrix.ColumnHeaderCount;

  for liColumn := 0 to Matrix.RowHeaderCount - 1 do
    begin

      lsPreviousCaption := GetValueAsText(liColumn, Matrix.ColumnHeaderCount);

      for liRow := Matrix.ColumnHeaderCount to Matrix.RowCount - 1 do
        begin

          lsCaption := GetValueAsText(liColumn, liRow);

          if (lsCaption <> lsPreviousCaption) then
            begin
              AllocateHeightToCells;

              liSpanHeight := 0;
              liHeight := 0;
              liCount := 0;
              liStartRow := liRow + 1;

              lsPreviousCaption := lsCaption;
            end

          else if Matrix.CaptionVisible[liColumn, liRow] then
            begin
              AllocateHeightToCells;

              liSpanHeight := Matrix.CaptionHeight[liColumn, liRow];

              if (liColumn + 1 < Matrix.RowHeaderCount) then
                liHeight := Matrix.CaptionHeight[liColumn + 1, liRow]
              else
                begin
                  liRowNo := liRow - Matrix.ColumnHeaderCount;
                  liHeight := Integer(FRowHeights[liRowNo]);
                end;

              liCount := 1;
              liStartRow := liRow;
            end

          else
            begin
              if Matrix.CaptionVisible[liColumn, liRow] then
                liSpanHeight := liSpanHeight + Matrix.CaptionHeight[liColumn, liRow];

              if (liColumn + 1 < Matrix.RowHeaderCount) then
                liHeight := liHeight + Matrix.CaptionHeight[liColumn + 1, liRow]
              else
                begin
                  liRowNo := liRow - Matrix.ColumnHeaderCount;

                  liHeight := liHeight + Integer(FRowHeights[liRowNo]);
                end;

              Inc(liCount);
            end;

        end;

      if (liSpanHeight > 0) then
        AllocateHeightToCells;

    end;

end; {procedure, AllocateRowCaptionHeights}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AdjustTotalRowHeights }

procedure TppCrossTabRenderer.AdjustTotalRowHeights;
var
  liColumn: Integer;
  liRow: Integer;
  liCaptionHeight: Integer;
  liValueHeight: Integer;
  liRowNo: Integer;
begin

  SetStatus(ppLoadStr(82)); {'Formatting CrossTab Rows: Adjust total row heights.'}

  for liRow := Matrix.ColumnHeaderCount to Matrix.RowCount - 1 do
    begin

      if Matrix.IsTotalRow(liRow) then
        begin
          liColumn := Matrix.FirstLabelColumnOfRowTotal(liRow);
          liCaptionHeight := Matrix.CaptionHeight[liColumn, liRow];

          liRowNo := liRow - Matrix.ColumnHeaderCount;
          liValueHeight := Integer(FRowHeights[liRowNo]);

          if (liValueHeight > liCaptionHeight) then
            Matrix.CaptionHeight[liColumn, liRow] := liValueHeight
          else
            FRowHeights[liRowNo] := TObject(liCaptionHeight);
        end;

    end;

end; {procedure, AdjustTotalRowHeights}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AllocateRowCaptionWidths }

procedure TppCrossTabRenderer.AllocateRowCaptionWidths;
var
  liColumn: Integer;
  liRow: Integer;
  liStartColumn: Integer;
  liEndColumn: Integer;
  liStartRow: Integer;
  liEndRow: Integer;
  lRowCaptionWidths: TList;
  lTotalCaptionWidths: TList;
  liWidth: Integer;
  liMaxWidth: Integer;
  liRowWidth: Integer;
  liTotalWidth: Integer;
  liRowDef: Integer;
  liDifference: Integer;
  liCount: Integer;
  liValueLabelWidth: Integer;
  liRemainder: Integer;
  liIncrement: Integer;
begin

  SetStatus(ppLoadStr(83)); {'Formatting CrossTab Rows: Allocate caption widths.'}

  liStartRow := 0;
  liEndRow := Matrix.RowCount - 1;

  liStartColumn := 0;
  liEndColumn := Matrix.RowHeaderCount - 1;

  {calc max width of each column, checking only row captions (skipping total captions)}
  lRowCaptionWidths := TList.Create;

  for liColumn := liStartColumn to liEndColumn do
    begin
      for liRow := liStartRow to liEndRow do
        begin

        if not(Matrix.IsTotalRow(liRow)) then
          begin

            liWidth := Matrix.CaptionWidth[liColumn, liRow];

            if (liColumn > lRowCaptionWidths.Count - 1) then
              lRowCaptionWidths.Add(TObject(liWidth))

            else
              begin
                liMaxWidth := Integer(lRowCaptionWidths[liColumn]);

                if (liWidth > liMaxWidth) then
                  lRowCaptionWidths[liColumn] := TObject(liWidth);
              end;

          end;

        end;
    end;

  {compute max width of total caption columns}
  lTotalCaptionWidths := TList.Create;

  for liRowDef := 0 to CrossTab.RowDefCount - 1 do
    for liRow := liStartRow to liEndRow do
      begin
        if not(Matrix.IsTotalRow(liRow)) then Continue;

        liColumn := liRowDef;

        liWidth := Matrix.CaptionWidth[liColumn, liRow];

        if (liColumn > lTotalCaptionWidths.Count - 1) then
          lTotalCaptionWidths.Add(TObject(liWidth))
        else
          begin
            liMaxWidth := Integer(lTotalCaptionWidths[liColumn]);

            if (liWidth > liMaxWidth) then
              lTotalCaptionWidths[liColumn] := TObject(liWidth);
          end;
      end;

  if (CrossTab.ValueDefCount = 1) then
    begin
      liValueLabelWidth := Matrix.CaptionWidth[0,0];

      {get max width of row caption columns}
      liRowWidth := 0;

      for liColumn := 0 to lRowCaptionWidths.Count - 1 do
        liRowWidth := liRowWidth + Integer(lRowCaptionWidths[liColumn]);

      if (liValueLabelWidth > liRowWidth) then
        begin
          liDifference := liValueLabelWidth - liRowWidth;

          liIncrement := liDifference div lRowCaptionWidths.Count;
          liRemainder := liDifference;

          for liColumn := 0 to lRowCaptionWidths.Count - 1 do
            begin
              liRowWidth := Integer(lRowCaptionWidths[liColumn]);

              liRowWidth := liRowWidth + liIncrement;

              lRowCaptionWidths[liColumn] := TObject(liRowWidth);

              {calc unallocated amount}
              liRemainder := liRemainder - liIncrement;

              {if next allocation is to the last row, allocate all remaining height}
              if (liColumn = ((lRowCaptionWidths.Count - 1) - 1)) then
                liIncrement := liRemainder;
            end;
        end;

    end;

  {set all row header columns (both row captions and total captions) to the max column widths}
  for liColumn := 0 to lRowCaptionWidths.Count - 1 do
    for liRow := liStartRow to liEndRow do
      if not(Matrix.IsTotalRow(liRow)) then
        Matrix.CaptionWidth[liColumn, liRow] := Integer(lRowCaptionWidths[liColumn])
      else if (Matrix.CaptionWidth[liColumn, liRow] < Integer(lRowCaptionWidths[liColumn])) then
         Matrix.CaptionWidth[liColumn, liRow] := Integer(lRowCaptionWidths[liColumn]);


  liRowDef := 0;

  {adjust row caption widths or total caption widths for each level of totals}
//  for liRowDef := 0 to CrossTab.RowDefCount - 1 do
//    begin
      {get max width of row caption columns}
      liRowWidth := 0;

      for liColumn := liRowDef to lRowCaptionWidths.Count - 1 do
        liRowWidth := liRowWidth + Integer(lRowCaptionWidths[liColumn]);

      {get max width of total caption columns}
      if (lTotalCaptionWidths.Count = 0) then
        liTotalWidth := liRowWidth
      else
        liTotalWidth := Integer(lTotalCaptionWidths[liRowDef]);

      {allocate excess width to row caption columns}
      if (liTotalWidth > liRowWidth) then
        begin
          liDifference := liTotalWidth - liRowWidth;

          liColumn := liRowDef;
          liCount := Matrix.RowHeaderCount; //- liRowDef;

           for liRow := liStartRow to liEndRow do
            begin
              if not(Matrix.IsTotalRow(liRow)) then
                 AllocateWidth(liColumn, liRow, liDifference, liCount);
            end;
 //       end;

    end;

  lRowCaptionWidths.Free;
  lTotalCaptionWidths.Free;

end; {procedure, AllocateRowCaptionWidths}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.PositionRowFieldLabels }

procedure TppCrossTabRenderer.PositionRowFieldLabels;
var
  liColumn: Integer;
  liRow: Integer;
  liMaxHeight: Integer;
  liEndColumn: Integer;
  liEndRow: Integer;
begin

  SetStatus(ppLoadStr(83)); {'Formatting CrossTab Rows: Position field labels.'}

  if (CrossTab.ColumnDefCount > 0) then Exit;

  {get max height of field labels}
  liEndRow := Matrix.ColumnHeaderCount - 1;
  liEndColumn := Matrix.RowHeaderCount;

  for liRow := 0 to liEndRow do
    begin
      liMaxHeight := 0;

      for liColumn := 0 to liEndColumn do
        begin
          if (Matrix.CaptionHeight[liColumn, liRow] > liMaxHeight) then
            liMaxHeight := Matrix.CaptionHeight[liColumn, liRow];
        end;

      {set height of field labels}
      for liColumn := 0 to liEndColumn do
        Matrix.CaptionHeight[liColumn, liRow] := liMaxHeight;

    end;


end; {procedure, PositionRowFieldLabels}

{******************************************************************************
 *
 ** C A L C   R O U T I N E S :   C O L U M N   C A P T I O N S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CalcColumnCaptionTextSizes }

procedure TppCrossTabRenderer.CalcColumnCaptionTextSizes;
var
  liColumn: Integer;
  liRow: Integer;
  lElement: TppElement;
  liStartColumn: Integer;
begin

  SetStatus(ppLoadStr(84)); {'Formatting CrossTab Columns: Compute caption text sizes.'}

  if (CrossTab.RowDefCount = 0) then
    liStartColumn := 0
  else
    liStartColumn := Matrix.RowHeaderCount;

  for liColumn := liStartColumn to Matrix.ColumnCount - 1 do
    begin

      for liRow := 0 to Matrix.ColumnHeaderCount - 1 do
        begin
          lElement := GetElement(Matrix.ElementIndex[liColumn, liRow]);

          CalcCaptionTextSize(lElement, liColumn, liRow);
        end;

    end;

  if (CrossTab.ValueDefCount = 1) then
    begin
      lElement := GetElement(Matrix.ElementIndex[0, 0]);

      CalcCaptionTextSize(lElement, 0, 0);
    end

  else if (CrossTab.ValueDefCount > 1) and (CrossTab.RowDefCount = 0) then
    begin

      liColumn := liStartColumn;

      for liRow := (Matrix.ColumnHeaderCount) to (Matrix.RowCount - 1) do
        begin
          lElement := GetElement(Matrix.ElementIndex[liColumn, liRow]);

          CalcCaptionTextSize(lElement, liColumn, liRow);
        end;
    end;

end; {procedure, CalcColumnCaptionTextSizes}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CoalesceColumnCaptionWidths }

procedure TppCrossTabRenderer.CoalesceColumnCaptionWidths;
var
  liColumn: Integer;
  liRow: Integer;
  liStartColumn: Integer;
  liEndColumn: Integer;
  liLastSubTotalColumn: Integer;
  lsCaption: String;
  lsPreviousCaption: String;
  lbHideLines: Boolean;
begin

  SetStatus(ppLoadStr(85)); {'Formatting CrossTab Columns: Coalesce caption widths.'}

  for liRow := 0 to Matrix.ColumnHeaderCount - 2 do
    begin

      liStartColumn := Matrix.RowHeaderCount;
      liEndColumn := Matrix.ColumnCount - CrossTab.VisibleColumnGrandTotalCount;

      liLastSubTotalColumn := -2;
      liColumn := liStartColumn;
      lsPreviousCaption := '';

      while (liColumn < liEndColumn) do
        begin

          if (Matrix.IsTotalColumn(liColumn)) then
            begin
              if (Matrix.DefIndex[liColumn, liRow] <> -1) and (Matrix.DefIndex[liColumn, liRow] <= (liRow - 1)) then
                lbHideLines := False
              else
                lbHideLines := True;
            end
          else
            lbHideLines := True;


          if lbHideLines then
            begin
              lsCaption := GetValueAsText(liColumn, liRow);

              if (lsCaption = lsPreviousCaption) then
                Matrix.CaptionVisible[liColumn, liRow] := False;

              lsPreviousCaption := lsCaption;

              Matrix.Borders[liColumn, liRow, btLeft] := False;

              if ((liColumn - 1) <> liLastSubTotalColumn) and (liColumn > liStartColumn) then
                Matrix.Borders[liColumn - 1, liRow, btRight] := False;
            end
          else
            begin

              if Matrix.IsTotalColumn(liColumn) and (Matrix.DefIndex[liColumn, liRow] <> -1) and (Matrix.DefIndex[liColumn, liRow] <= liRow) then
                begin
                  liLastSubTotalColumn := liColumn;
                  lsPreviousCaption := '';
                end
              else
                begin
                  lsCaption := GetValueAsText(liColumn, liRow);

                  lsPreviousCaption := lsCaption;
                end;

            end;

          Inc(liColumn);
        end;

    end;

end; {procedure, CoalesceColumnCaptionWidths}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CoalesceColumnCaptionHeights }

procedure TppCrossTabRenderer.CoalesceColumnCaptionHeights;
var
  liColumn: Integer;
  liRow: Integer;
begin

  SetStatus(ppLoadStr(86)); {'Formatting CrossTab Columns: Coalesce caption heights.'}

  for liColumn := Matrix.RowHeaderCount to Matrix.ColumnCount - 1 do
    begin

      if (Matrix.IsTotalColumn(liColumn)) then
        begin

          liRow := Matrix.FirstLabelRowOfColumnTotal(liColumn) + 1;

          while (liRow < Matrix.ColumnHeaderCount) do
            begin
              Matrix.CaptionVisible[liColumn, liRow] := False;

              Matrix.Borders[liColumn, liRow, btTop] := False;

              if (liRow > 0) then
                Matrix.Borders[liColumn, liRow - 1, btBottom] := False;

              Inc(liRow);
            end;

        end;
    end;

end; {procedure, CoalesceColumnCaptionHeights}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AllocateColumnCaptionWidths }

procedure TppCrossTabRenderer.AllocateColumnCaptionWidths;
var
  liColumn: Integer;
  liStartColumn: Integer;
  liRow: Integer;
  liColumnNo: Integer;
  liCount: Integer;
  liSpanWidth: Integer;
  liWidth: Integer;
  liDifference: Integer;

  procedure AllocateWidthToCells;
  begin
    {allocate width to parent column}
    if (liWidth > liSpanWidth) then
      begin
        liDifference := liWidth - liSpanWidth;

        AllocateWidth(liStartColumn, liRow, liDifference, liCount);
      end

    {allocate width to child column}
    else if (liSpanWidth > liWidth) then
      begin
        liDifference := liSpanWidth - liWidth;

        AllocateWidth(liStartColumn, liRow + 1, liDifference, liCount);
      end;
  end;

begin

  SetStatus(ppLoadStr(87)); {'Formatting CrossTab Columns: Allocate caption widths.'}

  {determine width of total columns by comparing caption width to value width}
  AdjustTotalColumnWidths;

      liSpanWidth := 0;
      liWidth := 0;
      liCount := 0;
      liStartColumn := Matrix.RowHeaderCount;

  for liRow := 1 to Matrix.ColumnHeaderCount - 1 do
    begin

      for liColumn := Matrix.RowHeaderCount to Matrix.ColumnCount - 1 do
        begin

          if Matrix.IsTotalColumn(liColumn) then
            begin
              AllocateWidthToCells;

              liSpanWidth := 0;
              liWidth := 0;
              liCount := 0;
              liStartColumn := liColumn + 1;
            end

          else if Matrix.CaptionVisible[liColumn, liRow] then
            begin
              AllocateWidthToCells;

              liSpanWidth := Matrix.CaptionWidth[liColumn, liRow];

              if (liRow + 1 < Matrix.ColumnHeaderCount) then
                liWidth := Matrix.CaptionWidth[liColumn, liRow + 1]
              else
                begin
                  liColumnNo := liColumn - Matrix.RowHeaderCount;
                  liWidth := Integer(FColumnWidths[liColumnNo]);
                end;

              liCount := 1;
              liStartColumn := liColumn;
            end

          else
            begin
              if Matrix.CaptionVisible[liColumn, liRow] then
                liSpanWidth := liSpanWidth + Matrix.CaptionWidth[liColumn, liRow];

              if (liRow + 1 < Matrix.ColumnHeaderCount) then
                liWidth := liWidth + Matrix.CaptionWidth[liColumn, liRow + 1]
              else
                begin
                  liColumnNo := liColumn - Matrix.RowHeaderCount;

                  liWidth := liWidth + Integer(FColumnWidths[liColumnNo]);
                end;

              Inc(liCount);
            end;

        end;

      if (liSpanWidth > 0) then
        AllocateWidthToCells;
        
    end;

end; {procedure, AllocateColumnCaptionWidths}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AdjustTotalColumnWidths }

procedure TppCrossTabRenderer.AdjustTotalColumnWidths;
var
  liColumn: Integer;
  liRow: Integer;
  liCaptionWidth: Integer;
  liValueWidth: Integer;
  liColumnNo: Integer;
begin

  if (CrossTab.ColumnDefCount = 0) then Exit;

  SetStatus(ppLoadStr(88)); {'Formatting CrossTab Columns: Adjust total column heights.'}

  for liColumn := Matrix.RowHeaderCount to Matrix.ColumnCount - 1 do
    begin

      if Matrix.IsTotalColumn(liColumn) then
        begin
          liRow := Matrix.FirstLabelRowOfColumnTotal(liColumn);
          liCaptionWidth := Matrix.CaptionWidth[liColumn, liRow];

          liColumnNo := liColumn - Matrix.RowHeaderCount;
          liValueWidth := Integer(FColumnWidths[liColumnNo]);

          if (liValueWidth > liCaptionWidth) then
            Matrix.CaptionWidth[liColumn, liRow] := liValueWidth
          else
            FColumnWidths[liColumnNo] := TObject(liCaptionWidth);
        end;

    end;

end; {procedure, AdjustTotalColumnWidths}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.PositionColumnFieldLabels }

procedure TppCrossTabRenderer.PositionColumnFieldLabels;
var
  liColumn: Integer;
  liRow: Integer;
  lWidths: TList;
  liColumnDef: Integer;
  liCaptionWidth: Integer;
  liColumnWidth: Integer;
  liColumnNo: Integer;
  lsCaption: String;
  liMaxHeight: Integer;
  liEndColumn: Integer;
begin

  SetStatus(ppLoadStr(89)); {'Formatting CrossTab Columns: Position field labels.'}

  {get max height of field labels}
  liRow := 0;
  liMaxHeight := 0;
  liEndColumn := (Matrix.RowHeaderCount + CrossTab.ColumnDefCount) - 1;

  if (liEndColumn >= Matrix.ColumnCount) then
    liEndColumn := Matrix.ColumnCount - 1;
    
  for liColumn := 0 to liEndColumn do
    begin
      if (Matrix.CaptionHeight[liColumn, liRow] > liMaxHeight) then
        liMaxHeight := Matrix.CaptionHeight[liColumn, liRow];
    end;

  {set height of field labels}
  for liColumn := 0 to liEndColumn do
    Matrix.CaptionHeight[liColumn, liRow] := liMaxHeight;

  {get field label widths, clear field label captions}
  liRow := 0;
  lWidths := TList.Create;

  for liColumnDef := 0 to CrossTab.ColumnDefCount - 1 do
    begin
      liColumn := Matrix.RowHeaderCount + liColumnDef;

      if (liColumn < Matrix.ColumnCount) then
        begin
          CalcCaptionTextSize(CrossTab.ColumnDefs[liColumnDef], liColumn, liRow);

          lWidths.Add(TObject(Matrix.CaptionWidth[liColumn, liRow]));

          Matrix.Value[liColumn, liRow] := '';
          Matrix.CaptionVisible[liColumn, liRow] := False;
        end;
    end;

  {position field labels}
  liColumn := Matrix.RowHeaderCount;

  for liColumnDef := 0 to CrossTab.ColumnDefCount - 1 do
    begin

      if (liColumn < Matrix.ColumnCount) then
        begin
          lsCaption := CrossTab.ColumnDefs[liColumnDef].GetName;
          liCaptionWidth := Integer(lWidths[liColumnDef]);

          liColumnNo := liColumn - Matrix.RowHeaderCount;
          liColumnWidth := Integer(FColumnWidths[liColumnNo]);
          
          Matrix.Value[liColumn, liRow] := lsCaption;
          Matrix.CaptionWidth[liColumn, liRow] := liColumnWidth;
          Matrix.CaptionVisible[liColumn, liRow] := True;
          Matrix.ElementIndex[liColumn, liRow] := 0;

          while (liColumn < Matrix.ColumnCount) and (liCaptionWidth > liColumnWidth) do
            begin
              Matrix.Borders[liColumn, liRow, btRight] := False;

              Inc(liColumn);

              if (liColumn < Matrix.ColumnCount) then
                begin
                  Matrix.Value[liColumn, liRow] := lsCaption;
                  Matrix.CaptionVisible[liColumn, liRow] := False;
                  Matrix.CaptionWidth[liColumn, liRow] := liColumnWidth;

                  Matrix.Borders[liColumn, liRow, btLeft] := False;

                  liColumnNo := liColumn - Matrix.RowHeaderCount;
                  liColumnWidth := liColumnWidth + Integer(FColumnWidths[liColumnNo]);
                end;
            end;
        end;

      Inc(liColumn);
    end;

  {hide any remaining cell borders}
  for liColumn := liColumn to Matrix.ColumnCount - 2 do
    begin
      Matrix.Borders[liColumn, liRow, btRight] := False;

      if (liColumn < (Matrix.ColumnCount - 1)) then
        Matrix.Borders[liColumn + 1, liRow, btLeft] := False;
    end;

  lWidths.Free;

end; {procedure, PositionColumnFieldLabels}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.PositionValueFieldLabels }

procedure TppCrossTabRenderer.PositionValueFieldLabels;
var
  liColumn: Integer;
  liRow: Integer;
  liMaxWidth: Integer;
  liWidth: Integer;
begin

  if (CrossTab.RowDefCount > 0) or (CrossTab.ValueDefCount < 2) then Exit;

  SetStatus(ppLoadStr(90)); {'Formatting CrossTab Values: Position field labels.'}

  liColumn := 0;
  liMaxWidth := 0;

  for liRow := 0 to Matrix.RowCount - 1 do
    begin
      liWidth := Matrix.CaptionWidth[liColumn, liRow];

      if (liWidth > liMaxWidth) then
        liMaxWidth := liWidth;
    end;

  for liRow := 0 to Matrix.RowCount - 1 do
    Matrix.CaptionWidth[liColumn, liRow] := liMaxWidth;

end; {procedure, PositionValueFieldLabels}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AllocateColumnCaptionHeights }

procedure TppCrossTabRenderer.AllocateColumnCaptionHeights;
var
  liColumn: Integer;
  liRow: Integer;
  liStartColumn: Integer;
  liEndColumn: Integer;
  liStartRow: Integer;
  liEndRow: Integer;
  liRowNo: Integer;
  lColumnCaptionHeights: TList;
  lTotalCaptionHeights: TList;
  liHeight: Integer;
  liMaxHeight: Integer;
  liColumnHeight: Integer;
  liTotalHeight: Integer;
  liColumnDef: Integer;
  liDifference: Integer;
  liCount: Integer;
begin

  SetStatus(ppLoadStr(91)); {'Formatting CrossTab Values: Allocate caption heights.'}

  {set range of cells to area where column captions exist}
  liStartColumn := Matrix.RowHeaderCount;
  liEndColumn := Matrix.ColumnCount - 1;

  liStartRow := 1;
  liEndRow := Matrix.ColumnHeaderCount - 1;


  {calc max height of each row, checking only column captions (skipping total captions)}
  lColumnCaptionHeights := TList.Create;

  for liRow := liStartRow to liEndRow do
    begin

      for liColumn := liStartColumn to liEndColumn do
        begin

          if Matrix.IsTotalColumn(liColumn) then Continue;

          liHeight := Matrix.CaptionHeight[liColumn, liRow];

          liRowNo := (liRow - liStartRow);

          if (liRowNo > lColumnCaptionHeights.Count - 1) then
            lColumnCaptionHeights.Add(TObject(liHeight))

          else
            begin
              liMaxHeight := Integer(lColumnCaptionHeights[liRowNo]);

              if (liHeight > liMaxHeight) then
                lColumnCaptionHeights[liRowNo] := TObject(liHeight);
            end;

        end;

    end;

  {compute max height of total caption rows}
  lTotalCaptionHeights := TList.Create;

  for liColumnDef := 0 to CrossTab.ColumnDefCount - 2 do
    for liColumn := liStartColumn to liEndColumn do
      begin
        if not(Matrix.IsTotalColumn(liColumn)) then Continue;

        liRow := liColumnDef + 1;

        liHeight := Matrix.CaptionHeight[liColumn, liRow];

        if ((liRow - 1) > lTotalCaptionHeights.Count - 1) then
          lTotalCaptionHeights.Add(TObject(liHeight))
        else
          begin
            liMaxHeight := Integer(lTotalCaptionHeights[liRow - 1]);

            if (liHeight > liMaxHeight) then
              lTotalCaptionHeights[liRow - 1] := TObject(liHeight);
          end;
      end;

  {set all column header rows (both column captions and total captions) to the max column height}
  for liColumn := liStartColumn to liEndColumn do
    for liRow := liStartRow to liEndRow do
      Matrix.CaptionHeight[liColumn, liRow] := Integer(lColumnCaptionHeights[liRow - 1]);


  {adjust column caption heights or total caption heights for each level of totals}
  for liColumnDef := 0 to CrossTab.ColumnDefCount - 2 do
    begin
      {get max height of column caption rows}
      liColumnHeight := Integer(lColumnCaptionHeights[liColumnDef]);

      {get max height of total caption rows}
      if (lTotalCaptionHeights.Count = 0) then
        liTotalHeight := liColumnHeight
      else
        liTotalHeight := Integer(lTotalCaptionHeights[liColumnDef]);

      {allocate excess height to column caption rows}
      if (liTotalHeight > liColumnHeight) then
        begin
          liDifference := liTotalHeight - liColumnHeight;

          liRow := liColumnDef + 1;
          liCount := Matrix.ColumnHeaderCount - liColumnDef;

          for liColumn := liStartColumn to liEndColumn do
            begin
               if not(Matrix.IsTotalColumn(liColumn)) then
                 AllocateHeight(liColumn, liRow, liDifference, liCount);
            end;
        end

      {allocate excess height to total caption rows}
      else if (liColumnHeight > liTotalHeight) then
        begin
          liDifference := liColumnHeight - liTotalHeight;

          liRow := liColumnDef + 1;
          liCount := Matrix.ColumnHeaderCount - liColumnDef;

          for liColumn := liStartColumn to liEndColumn do
            begin
              if Matrix.IsTotalColumn(liColumn) then
                AllocateHeight(liColumn, liRow, liDifference, liCount);
            end;
        end;

    end;

  lColumnCaptionHeights.Free;
  lTotalCaptionHeights.Free;

end; {procedure, AllocateColumnCaptionHeights}

{******************************************************************************
 *
 ** D R A W   R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.DrawCells }

procedure TppCrossTabRenderer.DrawCells(aPage: TppPage; var aLeft, aTop: Longint);
var
  llLeft: Longint;
  llTop: Longint;
  llHeight: Longint;
  llWidth: Longint;
  liColumn: Integer;
  liRow: Integer;
  lElement: TppElement;
begin

  llLeft := aLeft;
  llTop := aTop;

  for liColumn := StartColumn to EndColumn do
    begin
      llTop := aTop;

      llWidth := GetColumnWidth(liColumn);

      if (llWidth = 0) then Continue;

      for liRow := StartRow to EndRow do
        begin
          llHeight := GetRowHeight(liRow);

          if (llHeight = 0) then Continue;

          lElement := GetElement(Matrix.ElementIndex[liColumn, liRow]);

          FCrossTab.DoOnFormatCell(lElement, liColumn, liRow);

          CreateShape(lElement, llLeft, llTop, llWidth, llHeight);

          CreateLines(lElement, liColumn, liRow, llLeft, llTop, llWidth, llHeight);

          CreateText(lElement, liColumn, liRow, llLeft, llTop, llWidth, llHeight);

          llTop := llTop + llHeight;
        end;

      llLeft := llLeft + llWidth;
    end;

  aLeft := llLeft;
  aTop := llTop;

end; {procedure, DrawCells}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CreateShape }

procedure TppCrossTabRenderer.CreateShape(aElement: TppElement; aLeft, aTop, aWidth, aHeight: Longint);
var
  lDrawShape: TppDrawShape;
  lsPosition: String;
  llXIncrement: Integer;
  llYIncrement: Integer;

  function CreateShape: TppDrawShape;
  begin
    Result := TppDrawShape.Create(nil);

    llXIncrement := ppToMMThousandths(1, utPrinterPixels, pprtHorizontal, Printer);
    llYIncrement := ppToMMThousandths(1, utPrinterPixels, pprtVertical, Printer);

    Result.Left         := aLeft - llXIncrement;
    Result.Top          := aTop - llYIncrement;
    Result.Width        := aWidth + llXIncrement;
    Result.Height       := aHeight + llYIncrement;
    Result.ShapeType    := stRectangle;
    Result.Brush.Color  := aElement.Color;
    Result.Pen.Style    := psClear;
  end;

begin

  if (aElement.Color = clWhite) then Exit;

  lDrawShape := CreateShape;

  lsPosition := IntToStr(lDrawShape.Top);

  FCompletedShapes.AddObject(lsPosition, lDrawShape);

end; {procedure, CreateShape}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CreateText }

procedure TppCrossTabRenderer.CreateText(aElement: TppElement; aColumn, aRow: Integer; aLeft, aTop, aWidth, aHeight: Longint);
var
  lsText: String;
  lDrawText: TppDrawText;
  lbAllowExport: Boolean;
begin

  if IsCaption(aColumn, aRow) and not(Matrix.CaptionVisible[aColumn, aRow]) then Exit;

  lsText := GetValueAsText(aColumn, aRow);

  //if (lsText = '') then Exit;

  lDrawText := TppDrawText.Create(nil);

  lDrawText.Alignment    := aElement.Alignment;
  lDrawText.Font         := aElement.Font;
  lDrawText.Left         := aLeft;
  lDrawText.Top          := aTop + ciTextMargin;
  lDrawText.Width        := aWidth;

//  lDrawText.Width := Matrix.CaptionWidth[aColumn, aRow];

  lDrawText.Height       := aHeight;
  lDrawText.AutoSize     := False;
  lDrawText.Transparent  := True;

  //Determine whether the element should be saved to file.
  if CrossTab.SaveHeadings then
    lbAllowExport := True
  else
    lbAllowExport := (aElement is TppDimension) or (aElement is TppTotalDef);

  //Save to file properties
  if lbAllowExport then
  begin
    lDrawText.BandSave := CrossTab.Band.Save;
    lDrawText.BandSaveNo := CrossTab.Band.Report.ReportBandCount;
    lDrawText.Component := CrossTab;
    lDrawText.ComponentSave := CrossTab.Save;
    lDrawText.ComponentSaveNo := CrossTab.SaveOrder;
    lDrawText.SaveLength := CrossTab.SaveLength;
    lDrawText.RowSaveNo := aRow + 1;          //Add 1 to separate the 0 row/column from main report objects.
    lDrawText.ColumnSaveNo := aColumn + 1;
  end;

  ExpandTextDimensions(lDrawText, aColumn, aRow);

  case aElement.Alignment of
    taLeftJustify:  lDrawText.Left := aLeft + ciTextMargin;
    taRightJustify: lDrawText.Width := lDrawText.Width - ciTextMargin;
  end;

  lDrawText.Text  := GetValueAsText(aColumn, aRow);

  FCompletedText.Add(lDrawText);

end; {procedure, CreateText}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.ExpandTextDimensions }

procedure TppCrossTabRenderer.ExpandTextDimensions(aDrawText: TppDrawText; aColumn, aRow: Integer);
var
  lsCaption: String;
  lsCurrentCaption: String;
  liColumn: Integer;
  liRow: Integer;
  lbExpandWidth: Boolean;
  lbExpandHeight: Boolean;
begin

  lsCaption := GetValueAsText(aColumn, aRow);
  liColumn := aColumn;
  lbExpandWidth := True;

  while IsCaption(liColumn, aRow) and lbExpandWidth do
    begin
      liRow := aRow + 1;
      lbExpandHeight := True;

      while IsCaption(liColumn, liRow) and lbExpandHeight do
        begin
          lsCurrentCaption := GetValueAsText(liColumn, liRow);

          if (lsCurrentCaption = lsCaption) and not(Matrix.CaptionVisible[liColumn, liRow]) and (liRow <= FEndRow) then
            aDrawText.Height := aDrawText.Height + Matrix.CaptionHeight[liColumn, liRow]
          else
            lbExpandHeight := False;

          Inc(liRow);
        end;

      Inc(liColumn);

      lbExpandWidth := False;

      if (liColumn <= EndColumn) and (IsCaption(liColumn, aRow)) then
        begin
          lsCurrentCaption := GetValueAsText(liColumn, aRow);

          if (lsCurrentCaption = lsCaption) and not(Matrix.CaptionVisible[liColumn, aRow]) then
            begin
              lbExpandWidth := True;

              aDrawText.Width := aDrawText.Width + Matrix.CaptionWidth[liColumn, aRow];
            end;
        end;
        
    end;

end; {procedure, ExpandTextDimensions}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.CreateLines }

procedure TppCrossTabRenderer.CreateLines(aElement: TppElement; aColumn, aRow: Integer; aLeft, aTop, aWidth, aHeight: Integer);
var
  lDrawLine: TppDrawLine;
  lBorderType: TppBorderType;
  liColumn: Integer;
  liRow: Integer;
  liIndex: Integer;
  lsPosition: String;
  lBorders: array[0..3] of Boolean;
  liBorderColumn: Integer;
  liBorderRow: Integer;

  function CreateLine(aPosition: TppLinePositionType): TppDrawLine;
  begin
    Result := TppDrawLine.Create(nil);

    Result.Left := aLeft;
    Result.Top := aTop;
    Result.Width := aWidth;
    Result.Height := aHeight;

    Result.LinePosition := aPosition;
  end;

begin

  if not(CrossTab.GridLines) then Exit;
  
  liColumn := aColumn;
  liRow := aRow;

  {do not continue lines across subtotals}
  if Matrix.IsTotalRow(liRow) then
    begin
      FCompletedVerticalLines.AddStrings(FVerticalLines);

      FVerticalLines.Clear;
    end

  else if Matrix.IsTotalColumn(liColumn) then
    begin
      FCompletedHorizontalLines.AddStrings(FHorizontalLines);

      FHorizontalLines.Clear;
    end;

  {if value cell, get border attributes from captions}  
  if (liRow >= Matrix.ColumnHeaderCount) and (liColumn >= Matrix.RowHeaderCount) then
    begin
      if (liColumn >= Matrix.RowHeaderCount) then
        begin
          if (Matrix.RowHeaderCount > 0) then
            liBorderColumn := Matrix.RowHeaderCount - 1
          else
            liBorderColumn := 0;

          lBorders[Ord(btTop)] := Matrix.Borders[liBorderColumn, liRow, btTop];
          lBorders[Ord(btBottom)] := Matrix.Borders[liBorderColumn, liRow, btBottom];

          {single value crosstab, turn bottom border on}
          if (Matrix.RowHeaderCount = 0) then
            lBorders[Ord(btBottom)] := True;
        end;

      if (liRow >= Matrix.ColumnHeaderCount) then
        begin
          if (Matrix.ColumnHeaderCount > 0) then
            liBorderRow := Matrix.ColumnHeaderCount - 1
          else
            liBorderRow := 0;

          lBorders[Ord(btLeft)] := Matrix.Borders[liColumn, liBorderRow, btLeft];
          lBorders[Ord(btRight)] := Matrix.Borders[liColumn, liBorderRow, btRight];
        end
    end
  else
    begin
      lBorders[Ord(btLeft)] := Matrix.Borders[liColumn, liRow, btLeft];
      lBorders[Ord(btTop)] := Matrix.Borders[liColumn, liRow, btTop];
      lBorders[Ord(btRight)] := Matrix.Borders[liColumn, liRow, btRight];
      lBorders[Ord(btBottom)] := Matrix.Borders[liColumn, liRow, btBottom];
    end;

  {create lines for borders}
  for liIndex := 0 to 3 do
    begin
      lBorderType := TppBorderType(liIndex);

      if not(lBorders[Ord(lBorderType)]) then Continue;


      case lBorderType of
        btLeft:
          begin
            lsPosition := IntToStr(aLeft);

            if not(PositionToVerticalLine(lsPosition, aTop, aHeight)) then
              begin
                lDrawLine := CreateLine(lpLeft);

                FVerticalLines.AddObject(lsPosition, lDrawLine);
              end;
          end;

        btRight:
          begin
            lsPosition := IntToStr(aLeft + aWidth);

            if not(PositionToVerticalLine(lsPosition, aTop, aHeight)) then
              begin
                lDrawLine := CreateLine(lpRight);

                FVerticalLines.AddObject(lsPosition, lDrawLine);
              end;
          end;

        btTop:
          begin
            lsPosition := IntToStr(aTop);

            if not(PositionToHorizontalLine(lsPosition, aLeft, aWidth)) then
              begin
                lDrawLine := CreateLine(lpTop);

                FHorizontalLines.AddObject(lsPosition, lDrawLine);
              end;
          end;

        btBottom:
          begin
            lsPosition := IntToStr(aTop + aHeight);

            if not(PositionToHorizontalLine(lsPosition, aLeft, aWidth)) then
              begin
                lDrawLine := CreateLine(lpBottom);

                FHorizontalLines.AddObject(lsPosition, lDrawLine);
              end;
          end;

      end; {case border type}

    end; {for, each border}

end; {procedure, CreateLines}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.PositionToVerticalLine }

function TppCrossTabRenderer.PositionToVerticalLine(const aPosition: String; aTop, aHeight: Integer): Boolean;
var
  liLine: Integer;
  lDrawLine: TppDrawLine;
  lbFound: Boolean;
  lsLinePos: String;
  liDifference: Integer;
begin

  liLine := FVerticalLines.IndexOf(aPosition);

  if (liLine <> -1) then
    begin
      lDrawLine := TppDrawLine(FVerticalLines.Objects[liLine]);

      if (lDrawLine.Top <= aTop) and ((lDrawLine.Top + lDrawLine.Height) >= (aTop + aHeight)) then
        {do nothing}

      else if (lDrawLine.Top <= aTop) and ((lDrawLine.Top + lDrawLine.Height) < (aTop + aHeight)) then
        begin
          liDifference := (aTop + aHeight) - (lDrawLine.Top + lDrawLine.Height);

          lDrawLine.Height := lDrawLine.Height + liDifference;
        end;

      Result := True;
    end
    
  else
    begin
      liLine := FCompletedVerticalLines.IndexOf(aPosition);

      if (liLine <> -1) then
        lsLinePos := FCompletedVerticalLines[liLine]
      else
        lsLinePos := '';

      lbFound := False;

      while (lsLinePos = aPosition) and not(lbFound) do
        begin
          lDrawLine := TppDrawLine(FCompletedVerticalLines.Objects[liLine]);

          if (lDrawLine.Top <= aTop) and ((lDrawLine.Top + lDrawLine.Height) >= (aTop + aHeight)) then
            lbFound := True

          else if ((lDrawLine.Top + lDrawLine.Height) > aTop) and ((lDrawLine.Top + lDrawLine.Height) < (aTop + aHeight)) then
            begin
              lbFound := True;

              liDifference := (aTop + aHeight) - (lDrawLine.Top + lDrawLine.Height);

              lDrawLine.Height := lDrawLine.Height + liDifference;
            end

          else
            begin
              Inc(liLine);

              if (liLine < FCompletedVerticalLines.Count) then
                lsLinePos := FCompletedVerticalLines[liLine]
              else
                lsLinePos := '';
            end;

        end;

      Result := lbFound;
    end;

end; {procedure, PositionToVerticalLine}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.PositionToHorizontalLine }

function TppCrossTabRenderer.PositionToHorizontalLine(const aPosition: String; aLeft, aWidth: Integer): Boolean;
var
  liLine: Integer;
  lDrawLine: TppDrawLine;
  lbFound: Boolean;
  lsLinePos: String;
  liDifference: Integer;
begin

  liLine := FHorizontalLines.IndexOf(aPosition);

  if (liLine <> -1) then
    begin
      lDrawLine := TppDrawLine(FHorizontalLines.Objects[liLine]);

      if (lDrawLine.Left <= aLeft) and ((lDrawLine.Left + lDrawLine.Width) >= (aLeft + aWidth)) then
       {do nothing}

      else if (lDrawLine.Left <= aLeft) and ((lDrawLine.Left + lDrawLine.Width) < (aLeft + aWidth)) then
        begin
          liDifference := (aLeft + aWidth) - (lDrawLine.Left + lDrawLine.Width);

          lDrawLine.Width := lDrawLine.Width + liDifference;
        end;

      Result := True;
    end
    
  else
    begin
      liLine := FCompletedHorizontalLines.IndexOf(aPosition);

      if (liLine <> -1) then
        lsLinePos := FCompletedHorizontalLines[liLine]
      else
        lsLinePos := '';

      lbFound := False;

      while (lsLinePos = aPosition) and not(lbFound) do
        begin
          lDrawLine := TppDrawLine(FCompletedHorizontalLines.Objects[liLine]);

          if (lDrawLine.Left <= aLeft) and ((lDrawLine.Left + lDrawLine.Width) >= (aLeft + aWidth)) then
            lbFound := True

          else if ((lDrawLine.Left + lDrawLine.Width) > aLeft) and ((lDrawLine.Left + lDrawLine.Width) >= (aLeft + aWidth)) then
            begin
              lbFound := True;

              liDifference := (aLeft + aWidth) - (lDrawLine.Left + lDrawLine.Width);

              lDrawLine.Width := lDrawLine.Width + liDifference;
            end

          else
            begin
              Inc(liLine);

              if (liLine < FCompletedHorizontalLines.Count) then
                lsLinePos := FCompletedHorizontalLines[liLine]
              else
                lsLinePos := '';
            end;

        end;

      Result := lbFound;
    end;

end; {procedure, PositionToHorizontalLine}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AddLinesToPage }

procedure TppCrossTabRenderer.AddLinesToPage(aPage: TppPage);
var
  liIndex: Integer;
  lDrawLine: TppDrawLine;
begin

  if not(CrossTab.GridLines) then Exit;

  FCompletedVerticalLines.AddStrings(FVerticalLines);
  FVerticalLines.Clear;

  FCompletedHorizontalLines.AddStrings(FHorizontalLines);
  FHorizontalLines.Clear;

  FCompletedLines.Clear;
  FCompletedLines.AddStrings(FCompletedVerticalLines);
  FCompletedLines.AddStrings(FCompletedHorizontalLines);

  for liIndex := 0 to FCompletedLines.Count - 1 do
    begin
      lDrawLine := TppDrawLine(FCompletedLines.Objects[liIndex]);

      lDrawLine.Page := aPage;
    end;

end; {procedure, AddLinesToPage}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AddShapesToPage }

procedure TppCrossTabRenderer.AddShapesToPage(aPage: TppPage);
var
  liIndex: Integer;
  lDrawShape: TppDrawShape;
begin

  for liIndex := 0 to FCompletedShapes.Count - 1 do
    begin
      lDrawShape := TppDrawShape(FCompletedShapes.Objects[liIndex]);

      lDrawShape.Page := aPage;
    end;

end; {procedure, AddShapesToPage}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.AddTextToPage }

procedure TppCrossTabRenderer.AddTextToPage(aPage: TppPage);
var
  liIndex: Integer;
  lDrawText: TppDrawText;
begin

  for liIndex := 0 to FCompletedText.Count - 1 do
    begin
      lDrawText := TppDrawText(FCompletedText[liIndex]);

      lDrawText.Page := aPage;
    end;

end; {procedure, AddTextToPage}

{******************************************************************************
 *
 ** C R O S S T A B   R E N D E R E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCTRendererRepeatCaptions.Create }

constructor TppCTRendererRepeatCaptions.Create(aCrossTab: TppCrossTab);
begin

  inherited Create(aCrossTab);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCTRendererRepeatCaptions.Destroy }

destructor TppCTRendererRepeatCaptions.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCTRendererRepeatCaptions.Description }

class function TppCTRendererRepeatCaptions.Description: String;
begin
  {do not localize}
  Result := 'RepeatedCaptions';
end; {class function, Description}

{------------------------------------------------------------------------------}
{ TppCrossTabRenderer.LocalizedDescription }

class function TppCTRendererRepeatCaptions.LocalizedDescription: String;
begin
  Result := ppLoadStr(1139);
end; {class function, LocalizedDescription}


{------------------------------------------------------------------------------}
{ TppCTRendererRepeatCaptions.CalcSpaceUsed }

function TppCTRendererRepeatCaptions.CalcSpaceUsed(aMatrix: TppMatrix; aHeight, aWidth: Longint; aPrinter: TppPrinter): Longint;
var
  llHeightAvailable: Longint;
  llWidthAvailable: Longint;
  llHeightUsed: Longint;
  llWidthUsed: Longint;
  liColumns: Integer;
  liRows: Integer;
  liColumn: Integer;
  liRow: Integer;
  lbRepeatRowCaptions: Boolean;
  lbRepeatColumnCaptions: Boolean;
  lbFirstPage: Boolean;
begin

  lbFirstPage := (StartColumn = 0) and (StartRow = 0);

  if (Format) or lbFirstPage then
    begin
      Result := inherited CalcSpaceUsed(aMatrix, aHeight, aWidth, aPrinter);

      Exit;
    end;

  llHeightAvailable := aHeight;
  llWidthAvailable := aWidth;

  {determine if captions should be repeated}
  lbRepeatRowCaptions := (StartColumn <> 0);
  lbRepeatColumnCaptions := (StartRow <> 0);

  llHeightUsed := 0;

  if lbRepeatColumnCaptions then
    begin
      for liRow := 0 to Matrix.ColumnHeaderCount - 1 do
        llHeightUsed := llHeightUsed + GetRowHeight(liRow);

      {captions take up all of page space, and so cannot be reprinted}
      if (llHeightUsed >= llHeightAvailable) then
        llHeightUsed := 0;
    end;

  liRows := Matrix.RowCount;
  EndRow := StartRow;

  while (llHeightUsed <= llHeightAvailable) and (EndRow < liRows) do
    begin
      llHeightUsed := llHeightUsed + GetRowHeight(EndRow);

      if (llHeightUsed <= llHeightAvailable) then
        EndRow := EndRow + 1;
    end;

  EndRow := EndRow - 1;


  llWidthUsed := 0;

  if lbRepeatRowCaptions then
    begin
      for liColumn := 0 to Matrix.RowHeaderCount - 1 do
        llWidthUsed := llWidthUsed + GetColumnWidth(liColumn);

      {captions take up all of page space, and so cannot be reprinted}
      if (llWidthUsed >= llWidthAvailable) then
        llWidthUsed := 0;
    end;

  liColumns := Matrix.ColumnCount;
  EndColumn := StartColumn;
  
  while (llWidthUsed <= llWidthAvailable) and (EndColumn < liColumns) do
    begin
      llWidthUsed := llWidthUsed + GetColumnWidth(EndColumn);

      if (llWidthUsed <= llWidthAvailable) then
        EndColumn := EndColumn + 1;
    end;

  EndColumn := EndColumn - 1;

  {set space used and overflow}
  Result := llHeightUsed;

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppCTRendererRepeatCaptions.DrawCellsToPage }

procedure TppCTRendererRepeatCaptions.DrawCellsToPage(aPage: TppPage; aMatrix: TppMatrix; aLeft, aTop: Longint);
var
  liSaveStartRow: Integer;
  liSaveEndRow: Integer;
  liSaveStartColumn: Integer;
  liSaveEndColumn: Integer;
  lbRepeatRowCaptions: Boolean;
  lbRepeatColumnCaptions: Boolean;
  liLeft: Integer;
  liTop: Integer;
begin

  liLeft := aLeft;
  liTop := aTop;

  {determine if captions should be repeated}
  lbRepeatRowCaptions := (StartColumn <> 0);
  lbRepeatColumnCaptions := (StartRow <> 0);

  {draw row captions}
  if (lbRepeatRowCaptions) then
    begin
      liSaveStartColumn := StartColumn;
      liSaveEndColumn := EndColumn;

      StartColumn := 0;
      EndColumn := Matrix.RowHeaderCount - 1;

      {redraw the anchor corner}
      if (lbRepeatColumnCaptions) then
        begin
          liSaveStartRow := StartRow;
          liSaveEndRow := EndRow;

          StartRow := 0;
          EndRow := Matrix.ColumnHeaderCount - 1;

          DrawCells(aPage, liLeft, liTop);

          {reset left}
          liLeft := aLeft;

          StartRow := liSaveStartRow;
          EndRow := liSaveEndRow;
        end;

      DrawCells(aPage, liLeft, liTop);

      {save new left}
      aLeft := liLeft;

      {reset top}
      liTop := aTop;

      StartColumn := liSaveStartColumn;
      EndColumn := liSaveEndColumn;
    end;

  {draw column captions}
  if (lbRepeatColumnCaptions) then
    begin
      liSaveStartRow := StartRow;
      liSaveEndRow := EndRow;

      StartRow := 0;
      EndRow := Matrix.ColumnHeaderCount - 1;

      DrawCells(aPage, liLeft, liTop);

      {save new top}
      aTop := liTop;

      {reset left}
      liLeft := aLeft;

      StartRow := liSaveStartRow;
      EndRow := liSaveEndRow;
    end;

  {draw data}
  inherited DrawCellsToPage(aPage, aMatrix, aLeft, aTop);

end; {procedure, DrawCellsToPage}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterRenderer(TppCrossTabRenderer);
  ppRegisterRenderer(TppCTRendererRepeatCaptions);

finalization

  ppUnRegisterRenderer(TppCrossTabRenderer);
  ppUnRegisterRenderer(TppCTRendererRepeatCaptions);

  FRendererClassList.Free;
  FRendererClassList := nil;

end.
