unit ppDetailBandEngine;

interface

uses
  Classes,
  ppBands, ppComm, ppTypes, ppBandEngine;

type

  { TppDetailBandEngine }

  TppDetailBandEngine = class(TppBandEngine)
    private
      FBandsPerRecordCount: Integer;
      FDetailBand: TppDetailBand;

      procedure SetDetailBand(aDetailBand: TppDetailBand);

    protected
      procedure SetBand(aBand: TppCustomBand); override;

      procedure AdjustStartingPosition; override;
      procedure AfterPrint; override;
      procedure AfterObjectGenerate; override;
      procedure BeforeObjectGenerate; override;
      procedure BeforePrint; override;
      function  CanAdvanceData: Boolean; override;

    public
      constructor Create(aOwner: TComponent); override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure Init; override;

      property DetailBand: TppDetailBand read FDetailBand write SetDetailBand;
      property BandsPerRecordCount: Integer read FBandsPerRecordCount write FBandsPerRecordCount;

  end;

implementation

uses
  SysUtils;

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.Create }

constructor TppDetailBandEngine.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDetailBand := nil;
  FBandsPerRecordCount := 0;

end;

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.Notify }

procedure TppDetailBandEngine.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and (aCommunicator = FDetailBand) then
    FDetailBand := nil;

end;

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.SetBand }

procedure TppDetailBandEngine.SetBand(aBand: TppCustomBand);
begin

  inherited SetBand(aBand);

  if not(aBand is TppDetailBand) then
    raise EReportBuilderError.Create('TppDetailBandEngine.SetBand: Band must be a TppDetailBand.');

  FDetailBand := TppDetailBand(aBand);

end;

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.SetDetailBand }

procedure TppDetailBandEngine.SetDetailBand(aDetailBand: TppDetailBand);
begin
  SetBand(aDetailBand);
end;

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.Init }

procedure TppDetailBandEngine.Init;
begin

  inherited Init;

  FBandsPerRecordCount := 1;

end; {function, Init}

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.AdjustStartingPosition }

procedure TppDetailBandEngine.AdjustStartingPosition;
begin

  {set starting position to print position for first detail band only}
  if not(Report.Engine.FirstDetailBandPrinted) then
    inherited AdjustStartingPosition;

end; {procedure, AdjustStartingPosition}

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.BeforePrint }

procedure TppDetailBandEngine.BeforePrint;
var
  liIndex: Integer;
begin

  {fire event}
  DoBeforePrint;

  if not(Band.Visible) then
    Report.Engine.SyncData;

  {notify objects}
  for liIndex := 0 to Band.ObjectCount - 1 do
    Band.Objects[liIndex].BeforePrint;

end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.BeforeObjectGenerate }

procedure TppDetailBandEngine.BeforeObjectGenerate;
begin

  Report.Engine.SyncData;

  inherited BeforeObjectGenerate;

end; {procedure, BeforeObjectGenerate}

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.AfterPrint }

procedure TppDetailBandEngine.AfterPrint;
begin

  inherited AfterPrint;

  if not(OverFlow) and not(OutOfSpace) then
    begin
      if (BandsPerRecordCount >= DetailBand.BandsPerRecord) then
        begin
          Report.Engine.TraverseData;

          BandsPerRecordCount := 1;
        end
      else
        BandsPerRecordCount := BandsPerRecordCount + 1;

      if Report.Engine.AllDataTraversed or (pppcEndOfGroup in Report.Engine.PrintCondition) then
        GenerationComplete := True;
    end;

  {if we've reached the count limit, we're done with this page}
  if not(GenerationComplete) then
    begin
      if not(OverFlow) and (Report.AutoStop) and (Count = 1) then
        begin
          GenerationComplete := True;

          Report.Stop;
        end
      else if ((Band.PrintTimes = ptCount) and (Count = Band.PrintCount)) then
        OutOfSpace := True;
    end;

end;{procedure, AfterPrint}

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.CanAdvanceData }

function TppDetailBandEngine.CanAdvanceData: Boolean;
begin
  Result := True;
end; {function, CanAdvanceData}

{------------------------------------------------------------------------------}
{ TppDetailBandEngine.AfterObjectGenerate }

procedure TppDetailBandEngine.AfterObjectGenerate;
begin

  {computes calcs for detail band only}
  if not(OverFlow) and Report.Engine.AllDataTraversed then
    GenerationComplete := True;

  if (PrintingSection) and not(esEndSection in Report.Engine.State) then
    OutOfSpace := True;

  if not(Report.Engine.FirstDetailBandPrinted) then
    Report.Engine.FirstDetailBandPrinted := True;

  if not(Report.Engine.PageStarted) then
    Report.Engine.PageStarted := True;

  inherited AfterObjectGenerate;

end; {procedure, AfterObjectGenerate}

end.
