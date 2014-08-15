unit ppHorizontalBandEngine;

interface

uses
  ppDetailBandEngine;

type

  TppHorizontalBandEngine = class(TppDetailBandEngine)
    private
      FStartingLeft: Integer;

      procedure StartColumn;
      procedure FinishColumn;
      function GetColumnPosition(aColumnNo: Integer): Integer;

    protected
      procedure BeforeGenerate; override;
      procedure BeforePrint; override;
      procedure AfterObjectGenerate; override;
      procedure AfterGenerate; override;
      procedure CalcPrintPosition; override;
      procedure UpdatePrintPosition; override;

    public
      procedure FinishPage; override;

  end;

implementation

uses
  SysUtils,
  ppTypes, ppBands, ppUtils, ppReport;
  
{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.BeforePrint }

procedure TppHorizontalBandEngine.BeforePrint;
var
  lRect: TppRect;
begin

  inherited BeforePrint;

  if not(Report.Engine.FirstDetailBandPrinted) then
    Report.Engine.CurrentColumn := 0

  else if (Report.Engine.CurrentColumn >= Report.Columns - 1) then
    begin
      Report.Engine.CurrentColumn := 0;

      lRect := PrintPosRect;

      lRect.Top := lRect.Top + Band.mmHeight + Band.mmBottomOffset;
      lRect.Bottom := lRect.Top;

      Report.Engine.SetPrintPosition(lRect.Left, lRect.Top, lRect.Right, lRect.Top);
    end

  else
    Report.Engine.CurrentColumn := Report.Engine.CurrentColumn + 1;

  if not(Report.Engine.ColumnStarted[Report.Engine.CurrentColumn]) then
    StartColumn;

end;

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.CalcPrintPosition }

procedure TppHorizontalBandEngine.CalcPrintPosition;
var
  lRect: TppRect;
begin

  {get page bottom}
  PageBottom := Report.Engine.PageBottom - Band.mmBottomOffset;

  StartingPosition := Report.Engine.PrintPosRect.Top;

  if not(Report.Engine.ColumnStarted[Report.Engine.CurrentColumn]) and (TppBandedReport(Report).ColumnHeader <> nil) then
    StartingPosition := StartingPosition + TppBandedReport(Report).ColumnHeader.SpaceUsed;

  if Band.Visible and ((StartingPosition + Band.mmHeight) > PageBottom) then
    OutOfSpace := True

  else
    begin
      lRect.Left := GetColumnPosition(Report.Engine.CurrentColumn);
      lRect.Top := StartingPosition;
      lRect.Right := Report.Engine.PrintPosRect.Right;
      lRect.Bottom := lRect.Top + Band.mmHeight;

      PrintPosRect := lRect;

      CurrentPosition := PrintPosRect.Top;
      MaxStretchablePosition := 0;
      CurrentPartialAdjustment := PartialAdjustment;
    end;

end; 

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.UpdatePrintPosition }

procedure TppHorizontalBandEngine.UpdatePrintPosition;
begin

  if (Report.Engine.CurrentColumn = 0) then
    begin
      SpaceUsed := Band.mmHeight + Band.mmBottomOffset;

      Report.Engine.SpaceUsed := Report.Engine.SpaceUsed + SpaceUsed;
    end

  else
    SpaceUsed := 0;

end;

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.AfterObjectGenerate }

procedure TppHorizontalBandEngine.AfterObjectGenerate;
var
  liColumnNo: Integer;
begin

  liColumnNo := Report.Engine.CurrentColumn;

  Report.Engine.ColumnStarted[liColumnNo] := True;

  if Band.Visible and ((PrintPosRect.Bottom + Band.mmHeight) > PageBottom) then
    FinishColumn;

  inherited AfterObjectGenerate;

end;

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.BeforeGenerate }

procedure TppHorizontalBandEngine.BeforeGenerate;
begin

  inherited BeforeGenerate;

  FStartingLeft := Report.Engine.PrintPosRect.Left;

end;

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.AfterGenerate }

procedure TppHorizontalBandEngine.AfterGenerate;
begin

  inherited AfterGenerate;

  Report.Engine.SetPrintPosition(FStartingLeft, PrintPosRect.Bottom, PrintPosRect.Right, PrintPosRect.Bottom);

end;

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.FinishPage }

procedure TppHorizontalBandEngine.FinishPage;
var
  liColumnNo: Integer;
begin

  inherited FinishPage;

  if (((esPrintingTitle in Report.Engine.State) or (esPrintingSummary in Report.Engine.State)) and (TppBandedReport(Report).Detail.Count = 0)) then Exit;

  for liColumnNo := 0 to Report.Columns - 1 do
    begin
      if not(Report.Engine.ColumnFinished[liColumnNo]) then
        begin
          Report.Engine.CurrentColumn := liColumnNo;

          FinishColumn;
        end;
    end;

end;

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.StartColumn }

procedure TppHorizontalBandEngine.StartColumn;
var
  lRect: TppRect;
  liSpaceUsed: Integer;
begin

  Report.Engine.PCInclude([pppcStartOfColumn]);

  lRect := Report.Engine.PrintPosRect;
  liSpaceUsed := Report.Engine.SpaceUsed;

  Report.Engine.SetPrintPosition(GetColumnPosition(Report.Engine.CurrentColumn), lRect.Top, lRect.Right, lRect.Bottom);

  Report.DoOnStartColumn;

  if TppBandedReport(Report).ColumnHeader <> nil then
     TppBandedReport(Report).ColumnHeader.Generate;

  Report.Engine.SetPrintPosition(lRect.Left, lRect.Top, lRect.Right, lRect.Bottom);
  Report.Engine.SpaceUsed := liSpaceUsed;

  Report.Engine.PCExclude([pppcStartOfColumn]);

end;

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.FinishColumn }

procedure TppHorizontalBandEngine.FinishColumn;
var
  lRect: TppRect;
  liSpaceUsed: Integer;
begin

  Report.Engine.PCInclude([pppcEndOfColumn]);

  lRect := Report.Engine.PrintPosRect;
  liSpaceUsed := Report.Engine.SpaceUsed;

  Report.Engine.SetPrintPosition(GetColumnPosition(Report.Engine.CurrentColumn), lRect.Top, lRect.Right, lRect.Bottom);

  if (TppBandedReport(Report).ColumnFooter <> nil) then
    TppBandedReport(Report).ColumnFooter.Generate;

  Report.DoOnEndColumn;

  Report.Engine.SetPrintPosition(lRect.Left, lRect.Top, lRect.Right, lRect.Bottom);
  Report.Engine.SpaceUsed := liSpaceUsed;

  Report.Engine.PCExclude([pppcEndOfColumn]);

  Report.Engine.ColumnFinished[Report.Engine.CurrentColumn] := True;

end;

{------------------------------------------------------------------------------}
{ TppHorizontalBandEngine.GetColumnPosition }

function TppHorizontalBandEngine.GetColumnPosition(aColumnNo: Integer): Integer;
var
  ldColumnPos: Double;
  lsMessage: String;
begin

  Result := 0;

  if (Report.ColumnPositions.Count = 0) then
    Result := Report.Engine.Page.PageDef.mmMarginLeft + (Report.mmColumnWidth * (aColumnNo))

  else
    begin

      if (aColumnNo = Report.ColumnPositions.Count) then
        begin
          lsMessage := ppLoadStrWithParms(43, [IntToStr(aColumnNo + 1)]);

          Report.RaiseException(EPrintError.Create(lsMessage + '.'));
        end;

      try
        ldColumnPos := StrToFloat(Report.ColumnPositions[aColumnNo]);

        Result := ppToMMThousandths(ldColumnPos, Report.Units, pprtHorizontal, Report.Printer);

      except on EConvertError do
        begin
          lsMessage := ppLoadStrWithParms(42, [IntToStr(aColumnNo)]);

          Report.RaiseException(EPrintError.Create(lsMessage + '.'));
        end;

      end {try, except}

    end

end;

end.
