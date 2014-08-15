{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppLabelDef;

interface

{$I ppIfDef.pas}

uses
  Classes, SysUtils, Printers,
  ppTypes, ppClass, ppReport, ppPrintr, ppUtils;

const
  cMaxColumnPositions = 10;

type
  TppLabelPrinterType = (ptLaserJet, ptDotMatrix);


  {TppLabelDefRec }
  TppLabelDefRec = record
    Product: String;
    PrinterType: TppLabelPrinterType;
    LabelType: String;
    Name: String;
    Width: Single;
    Height: Single;
    PaperWidth: Single;
    PaperHeight: Single;
    MarginTop: Single;
    MarginBottom: Single;
    MarginLeft: Single;
    MarginRight: Single;
    Orientation: TPrinterOrientation;
    RowSpacing: Single;
    Units: TppUnitType;
    Columns: Integer;
    ColumnPositions: array [0..cMaxColumnPositions] of Single;
  end;


  TppLabelSetClass = class of TppLabelSet;

  {@TppLabelSet }
  TppLabelSet = class
    protected
      class function GetLabelDef(aIndex: Integer): String; virtual; {abstract; - removed to support CBuilder}

    public
      class function Product: String; virtual; {abstract; - removed to support CBuilder}
      class function PrinterType: TppLabelPrinterType; virtual; {abstract; - removed to support CBuilder}
      class function Count: Integer; virtual; {abstract; - removed to support CBuilder}
      class function GetLabelDefRec(aIndex: Integer): TppLabelDefRec;
      class function GetLabelDescription(aIndex: Integer): String;

      class procedure AssignLabelDefToReport(aLabelDef: TppLabelDefRec; aReport: TppCustomReport);

    end; {class, TppLabelSet}


  {@TppLaserJetLabels}
  TppLaserJetLabels = class(TppLabelSet)
    public
      class function PrinterType: TppLabelPrinterType; override;

    end; {class, TppLaserJetLabels}


  {@TppDotMatrixLabels}
  TppDotMatrixLabels = class(TppLabelSet)
    public
      class function PrinterType: TppLabelPrinterType; override;

    end; {class, TppDotMatrixLabels}


  procedure ppRegisterLabelSet(aLabelSetClass: TppLabelSetClass);
  procedure ppUnRegisterLabelSet(aLabelSetClass: TppLabelSetClass);

  procedure ppGetLabelProducts(aPrinterType: TppLabelPrinterType; aLabelProducts: TStrings);
  procedure ppGetLabelDefs(aProductName: String; aPrinterType: TppLabelPrinterType; aLabelDefs: TStrings);

implementation

var
  FLabelSetList: TList;

{******************************************************************************
 *
 ** L A B E L   S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLabelSet.GetLabelDef}

class function TppLabelSet.GetLabelDef(aIndex: Integer): String;
begin
  {treat as abstract - descendants must override }
  Result := '';

end;  {class function, GetLabelDef}

{------------------------------------------------------------------------------}
{ TppLabelSet.Product}

class function TppLabelSet.Product: String;
begin
  {treat as abstract - descendants must override }
  Result := '';

end;  {class function, Product}

{------------------------------------------------------------------------------}
{ TppLabelSet.PrinterType}

class function TppLabelSet.PrinterType: TppLabelPrinterType;
begin
  {treat as abstract - descendants must override }
  Result := ptLaserJet;

end;  {class function, PrinterType}

{------------------------------------------------------------------------------}
{ TppLabelSet.Count}

class function TppLabelSet.Count: Integer;
begin
  {treat as abstract - descendants must override }
  Result := 0;

end;  {class function, Count}


{------------------------------------------------------------------------------}
{ TppLabelSet.AssignLabelDefToReport}

class procedure TppLabelSet.AssignLabelDefToReport(aLabelDef: TppLabelDefRec; aReport: TppCustomReport);
var
  liIndex: Integer;
  lReport: TppBandedReport;
  lPrinterSetup: TppPrinterSetup;
  lColumnPositions: TStrings;

begin

  lReport := TppBandedReport(aReport);

  lReport.Units := aLabelDef.Units;


  lPrinterSetup := lReport.PrinterSetup;

  lPrinterSetup.Orientation  := aLabelDef.Orientation;

  lPrinterSetup.PaperWidth  := aLabelDef.PaperWidth;
  lPrinterSetup.PaperHeight := aLabelDef.PaperHeight;


  lPrinterSetup.MarginLeft   :=  aLabelDef.MarginLeft;
  lPrinterSetup.MarginTop    :=  aLabelDef.MarginTop;
  lPrinterSetup.MarginBottom :=  aLabelDef.MarginBottom;
  lPrinterSetup.MarginRight  :=  aLabelDef.MarginRight;


  lReport.Detailband.Height := aLabelDef.Height;
  lReport.Detailband.BottomOffSet := aLabelDef.RowSpacing;


  lReport.Columns := aLabelDef.Columns;

  lColumnPositions := lReport.ColumnPositions;

  lColumnPositions.Clear;

  if lReport.Columns > 1 then
    for liIndex := 0 to lReport.Columns-1 do
      lColumnPositions.Add(FloatToStr(aLabelDef.ColumnPositions[liIndex]));


  lReport.ColumnWidth := aLabelDef.Width;


  if (lReport.HeaderBand <> nil) then
    lReport.HeaderBand.Free;

  if (lReport.FooterBand <> nil) then
    lReport.FooterBand.Free;

  lReport.PrinterSetup := lPrinterSetup;

end; {class function, AssignLabelDefToReport}



{------------------------------------------------------------------------------}
{ TppLabelSet.GetLabelDescription}

class function TppLabelSet.GetLabelDescription(aIndex: Integer): String;
var
  lsLabelDef: String;
  lStrings: TStringList;

begin
  lsLabelDef := GetLabelDef(aIndex);

  lStrings := TStringList.Create;

  ppParseString(lsLabelDef, lStrings);

  Result := lStrings[1] + ' - ' + lStrings[0];

  lStrings.Free;

end; {class function, GetLabelDescription}


{------------------------------------------------------------------------------}
{ TppLabelSet.GetLabelDefRec}

class function TppLabelSet.GetLabelDefRec(aIndex: Integer): TppLabelDefRec;
var
  lsLabelDef: String;
  liIndex: Integer;
  lStrings: TStringList;
  liBase: Integer;
  lSaveDecimalSepartor: Char;

begin
  lsLabelDef := GetLabelDef(aIndex);

  {temporarily override the decimal separator - it must be a '.' for StrToFloat calls below}
  lSaveDecimalSepartor := DecimalSeparator;

  try

    DecimalSeparator := '.';

    lStrings := TStringList.Create;

    {Product, PrinterType, LabelType, Name,
       Width, Height, MarginTop, MarginBottom, MarginLeft, MarginRight,
       Orientation, RowSpacing, Units, Columns, ColumnPositions }

    ppParseString(lsLabelDef, lStrings);

    Result.Product     := Product;
    Result.PrinterType := PrinterType;

    Result.LabelType   := lStrings[0];
    Result.Name        := lStrings[1];

    Result.Width  := StrToFloat(lStrings[2]);
    Result.Height := StrToFloat(lStrings[3]);

    Result.PaperWidth  := StrToFloat(lStrings[4]);
    Result.PaperHeight := StrToFloat(lStrings[5]);


    Result.MarginTop    := StrToFloat(lStrings[6]);
    Result.MarginBottom := StrToFloat(lStrings[7]);
    Result.MarginLeft   := StrToFloat(lStrings[8]);
    Result.MarginRight  := StrToFloat(lStrings[9]);

    Result.Orientation :=  TPrinterOrientation(StrToInt(lStrings[10]));

    if Result.PaperWidth > Result.PaperHeight then
      Result.Orientation := poLandscape;

    Result.RowSpacing := StrToFloat(lStrings[11]);
    Result.Units      := TppUnitType(StrToInt(lStrings[12]));

    Result.Columns := StrToInt(lStrings[13]);

    liBase := 14;

    for liIndex := 0 to Result.Columns-1 do
      Result.ColumnPositions[liIndex] := StrToFloat(lStrings[liBase + liIndex]);

    lStrings.Free;

  finally
    DecimalSeparator := lSaveDecimalSepartor;

  end;

end; {class function, GetLabelDefRec}



{******************************************************************************
 *
 ** L A S E R J E T    L A B E L S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLaserJetLabels.PrinterType}

class function TppLaserJetLabels.PrinterType: TppLabelPrinterType;
begin
  Result := ptLaserJet;
end;  {class function, PrinterType}

{******************************************************************************
 *
 ** D O T M A T R I X   L A B E L S
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppDotMatrixLabels.PrinterType}

class function TppDotMatrixLabels.PrinterType: TppLabelPrinterType;
begin
  Result := ptDotMatrix;
end;  {class function, PrinterType}


{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppGetLabelSetList }

function ppGetLabelSetList: TList;
begin
  if (FLabelSetList = nil) then
    FLabelSetList := TList.Create;

  Result := FLabelSetList;

end; {function, ppGetLabelSetList}

{------------------------------------------------------------------------------}
{ ppRegisterLabelSet }

procedure ppRegisterLabelSet(aLabelSetClass: TppLabelSetClass);
var
  liIndex: Integer;

begin
  liIndex := ppGetLabelSetList.IndexOf(Pointer(aLabelSetClass));

  if (liIndex < 0) then
    FLabelSetList.Add(aLabelSetClass);

end; {procedure, ppRegisterLabelSet}

{------------------------------------------------------------------------------}
{ ppUnRegisterLabelSet }

procedure ppUnRegisterLabelSet(aLabelSetClass: TppLabelSetClass);
var
  liIndex: Integer;

begin
  liIndex := ppGetLabelSetList.IndexOf(Pointer(aLabelSetClass));

  if (liIndex >= 0) then
    FLabelSetList.Delete(liIndex);

end; {procedure, ppUnRegisterLabelSet}

{------------------------------------------------------------------------------}
{ ppGetLabelProducts }

procedure ppGetLabelProducts(aPrinterType: TppLabelPrinterType; aLabelProducts: TStrings);
var
  liIndex: Integer;
  lLabelSetClass: TppLabelSetClass;

begin

  aLabelProducts.Clear;

  for liIndex := 0 to ppGetLabelSetList.Count-1 do
    begin
      lLabelSetClass := TppLabelSetClass(FLabelSetList[liIndex]);

      if lLabelSetClass.PrinterType = aPrinterType then
        aLabelProducts.AddObject(lLabelSetClass.Product, TObject(lLabelSetClass));

    end;

end; {function, ppGetLabelProducts}

{------------------------------------------------------------------------------}
{ ppGetLabelDefs }

procedure ppGetLabelDefs(aProductName: String; aPrinterType: TppLabelPrinterType; aLabelDefs: TStrings);
var
  lProductList: TStrings;
  liIndex: Integer;
  lLabelSetClass: TppLabelSetClass;

begin

  aLabelDefs.Clear;

  lProductList := TStringList.Create;

  ppGetLabelProducts(aPrinterType, lProductList);

  liIndex := lProductList.IndexOf(aProductName);

  if (liIndex < 0) then Exit;

  lLabelSetClass := TppLabelSetClass(lProductList.Objects[liIndex]);

  for liIndex := 0  to lLabelSetClass.Count-1 do
    aLabelDefs.AddObject(lLabelSetClass.GetLabelDescription(liIndex), TObject(lLabelSetClass));

  lProductList.Free;

end; {function, ppGetLabelDefs}


initialization

finalization

  FLabelSetList.Free;
  FLabelSetList := nil;

end.
 
