{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppBandEngine;

interface

uses
  Classes,
  ppComm, ppClass, ppBands, ppTypes, ppStrtch, ppDevice;

type

  {TppBandEngine}

  TppBandEngine = class(TppCommunicator)
    private
      FBand: TppCustomBand;
      FReport: TppCustomReport;

      {engine variables}
      FAllObjectsPrinted: Boolean;
      FCalcList: TList;
      FCount: Integer;
      FCumulativeCurrentPosition: Integer;
      FCurrentPartialAdjustment: Integer;
      FCurrentPosition: Integer;
      FGenerating: Boolean;
      FGenerationComplete: Boolean;
      FMaxStretchable: TppStretchable;
      FMaxStretchablePosition: Integer;
      FObjectListIndex: Integer;
      FObjectLists: TStringList;
      FObjectListSaved: Boolean;
      FObjectIndex: Integer;
      FObjectOverFlow: Boolean;
      FObjectSaved: Boolean;
      FOverFlow: Boolean;
      FOutOfSpace: Boolean;
      FPageBottom: Integer;
      FPartialGeneration: Boolean;
      FPartialAdjustment: Integer;
      FPrintQueue: TStringList;
      FPrintingSection: Boolean;
      FPrintPosRect: TppRect;
      FPrintPositionBreak: Boolean;
      FShifters: TList;
      FSpaceUsed: Integer;
      FStartingPosition: Integer;
      FStatics: TList;
      FStretchables: TList;
      FStretchers: TList;
      FPageNoOfLastStaticFit: Integer;

      {events}
      FAfterGenerate: TNotifyEvent;
      FAfterPrint: TNotifyEvent;
      FBeforeGenerate: TNotifyEvent;
      FBeforePrint: TNotifyEvent;
      FOnCreateDrawCommand: TNotifyEvent;

      {engine routines}
      procedure BuildCalcList;
      function  GetCurrentObject: TppComponent;
      procedure CategorizeObjects;
      function  CheckForEndOfGeneration: Boolean;
      procedure CompleteSection(aObject: TppComponent; aObjectIndex: Integer; aQueue: TList);
      procedure FreeLists;
      procedure GenerateObjects(aListIndex, aObjectIndex: Integer);
      function  GetQueueCount: Integer;
      procedure IncrementCurrentPosition(aObject: TppComponent);
      procedure ProcessQueue(aQueue: TList; aObjectIndex: Integer);
      procedure Print(aPage: TppPage);
      procedure ResetObjects;
      procedure SaveOverFlowObject(aObject: TppComponent; aObjectIndex: Integer);

    protected
      procedure AdjustStartingPosition; virtual;
      procedure AfterGenerate; virtual;
      procedure AfterPrint; virtual;
      procedure AfterObjectGenerate; virtual;
      procedure BeforeGenerate; virtual;
      procedure BeforeObjectGenerate; virtual;
      procedure BeforePrint; virtual;
      procedure CalcPrintPosition; virtual;
      function  CanAdvanceData: Boolean; virtual;
      procedure CreateDrawCommand(aPage: TppPage); virtual;
      procedure UpdatePrintPosition; virtual;

      procedure SetBand(aBand: TppCustomBand); virtual;

      {event triggers}
      procedure DoAfterGenerate;
      procedure DoAfterPrint;
      procedure DoBeforeGenerate;
      procedure DoBeforePrint;

       property Report: TppCustomReport read FReport;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure Generate; virtual;
      procedure Init; virtual;
      procedure FinishPage; virtual;

      property AllObjectsPrinted: Boolean read FAllObjectsPrinted write FAllObjectsPrinted;
      property Band: TppCustomBand read FBand write SetBand;
      property Count: Integer read FCount write FCount;
      property CurrentObject: TppComponent read GetCurrentObject;
      property CurrentPartialAdjustment: Integer read FCurrentPartialAdjustment write FCurrentPartialAdjustment;
      property CurrentPosition: Integer read FCurrentPosition write FCurrentPosition;
      property CumulativeCurrentPosition: Integer read FCumulativeCurrentPosition write FCumulativeCurrentPosition;
      property Generating: Boolean read FGenerating write FGenerating;
      property GenerationComplete: Boolean read FGenerationComplete write FGenerationComplete;
      property MaxStretchable: TppStretchable read FMaxStretchable write FMaxStretchable;
      property MaxStretchablePosition: Integer read FMaxStretchablePosition write FMaxStretchablePosition;
      property ObjectIndex: Integer read FObjectIndex write FObjectIndex;
      property ObjectListIndex: Integer read FObjectListIndex write FObjectListIndex;
      property OutOfSpace: Boolean read FOutOfSpace write FOutOfSpace;
      property OverFlow: Boolean read FOverFlow write FOverFlow;
      property PageBottom: Integer read FPageBottom write FPageBottom;
      property PartialGeneration: Boolean read FPartialGeneration write FPartialGeneration;
      property PartialAdjustment: Integer read FPartialAdjustment write FPartialAdjustment;
      property PrintingSection: Boolean read FPrintingSection write FPrintingSection;
      property PrintPositionBreak: Boolean read FPrintPositionBreak write FPrintPositionBreak;
      property PrintPosRect: TppRect read FPrintPosRect write FPrintPosRect;
      property QueueCount: Integer read GetQueueCount;
      property SpaceUsed: Integer read FSpaceUsed write FSpaceUsed;
      property StartingPosition: Integer read FStartingPosition write FStartingPosition;

      {events}
      property AfterGenerateEvent: TNotifyEvent read FAfterGenerate  write FAfterGenerate;
      property AfterPrintEvent: TNotifyEvent read FAfterPrint  write FAfterPrint;
      property BeforePrintEvent: TNotifyEvent read FBeforePrint  write FBeforePrint;
      property BeforeGenerateEvent: TNotifyEvent read FBeforeGenerate  write FBeforeGenerate;
      property OnCreateDrawCommand: TNotifyEvent read FOnCreateDrawCommand write FOnCreateDrawCommand;
      
  end; {class, TppBandEngine}

implementation

uses
  SysUtils,
  ppUtils, ppSubRpt;

{------------------------------------------------------------------------------}
{ TppBandEngine.Create }

constructor TppBandEngine.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FBand := nil;
  FReport := nil;

  FAllObjectsPrinted := False;
  FCalcList := nil;
  FCumulativeCurrentPosition := 0;
  FCurrentPosition := 0;
  FGenerating := False;
  FGenerationComplete := False;
  FMaxStretchablePosition := 0;
  FObjectListIndex := 0;
  FObjectLists := TStringList.Create;
  FObjectListSaved := False;
  FObjectIndex := 0;
  FObjectSaved := False;
  FOverFlow := False;
  FPageBottom := 0;
  FPrintingSection := False;
  FPrintPositionBreak := False;
  FPrintQueue := TStringList.Create;
  FShifters := nil;
  FSpaceUsed := 0;
  FStartingPosition := 0;
  FStatics := nil;
  FStretchables := nil;
  FStretchers := nil;

  FAfterGenerate := nil;
  FAfterPrint := nil;
  FBeforeGenerate := nil;
  FBeforePrint := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBandEngine.Destroy }

destructor TppBandEngine.Destroy;
begin

  FreeLists;

  FCalcList.Free;
  FObjectLists.Free;
  FPrintQueue.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppBandEngine.SetBand }

procedure TppBandEngine.SetBand(aBand: TppCustomBand);
begin

  if (FBand <> nil) then
    FBand.RemoveNotify(Self);

  FBand := aBand;

  if (FBand <> nil) then
    FBand.AddNotify(Self);

end;

{------------------------------------------------------------------------------}
{ TppBandEngine.Notify }

procedure TppBandEngine.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and (aCommunicator = FBand) then
    FBand := nil;

end;

{------------------------------------------------------------------------------}
{ TppBandEngine.FinishPage }

procedure TppBandEngine.FinishPage;
begin

end;

{------------------------------------------------------------------------------}
{ TppBandEngine.FreeLists }

procedure TppBandEngine.FreeLists;
var
  liList: Integer;
begin

  for liList := 0 to FObjectLists.Count - 1 do
    TList(FObjectLists.Objects[liList]).Free;

  FStretchables := nil;
  FStretchers := nil;
  FShifters := nil;
  FStatics := nil;

  FObjectLists.Clear;

end; {procedure, FreeLists}

{------------------------------------------------------------------------------}
{ TppBandEngine.Init }

procedure TppBandEngine.Init;
var
  liIndex: Integer;
begin

  FReport := FBand.Report;

  for liIndex := 0 to FBand.ObjectCount - 1 do
    FBand.Objects[liIndex].Init;

  FObjectIndex := 0;
  FObjectListIndex := 0;
  FOverFlow := False;
  FPartialGeneration := False;
  FPartialAdjustment := FBand.mmHeight;
  FPageNoOfLastStaticFit := 0;

  FreeLists;

  CategorizeObjects;

  BuildCalcList;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppBandEngine.BuildCalcList }

procedure TppBandEngine.BuildCalcList;
var
  liIndex: Integer;
  lComponent: TppComponent;
begin

  FCalcList.Free;
  FCalcList := nil;

  for liIndex := 0 to FBand.ObjectCount - 1 do
    begin
      lComponent := FBand.Objects[liIndex];

      if lComponent.IsCalc then
        begin
          if (FCalcList = nil) then
            FCalcList := TList.Create;

          FCalcList.Add(lComponent);
        end;
        
    end;

end; {procedure, BuildCalcList}

{------------------------------------------------------------------------------}
{ TppBandEngine.GetCurrentObject }

function TppBandEngine.GetCurrentObject: TppComponent;
var
  lList: TList;
begin

  Result := nil;

  if (FObjectLists.Count = 0) then Exit;

  if (FObjectListIndex < 0) or (FObjectListIndex >= FObjectLists.Count) then Exit;

  lList := TList(FObjectLists.Objects[FObjectListIndex]);

  if (FObjectIndex < 0) or (FObjectIndex >= lList.Count) then Exit;

  Result := TppComponent(lList[FObjectIndex]);

end; {procedure, function}

{------------------------------------------------------------------------------}
{ TppBandEngine.CategorizeObjects }

procedure TppBandEngine.CategorizeObjects;
var
  liIndex: Integer;
  lComponent: TppComponent;

  procedure AddObjectToList(var aList: TList; aObject: TObject; aListRank: Integer);
  begin

    if (aList = nil) then
      begin
        aList := TList.Create;

        FObjectLists.AddObject(IntToStr(aListRank), aList);
      end;

    aList.Add(lComponent);

  end; {procedure, AddObjectToList}

  
begin

  {categorize objects}
  for liIndex := 0 to FBand.ObjectCount - 1 do
    begin
      lComponent := FBand.Objects[liIndex];

      {save object's z-order}
      lComponent.ZOrder := liIndex;

      if (lComponent is TppStretchable) then
        begin
          if (TppStretchable(lComponent).ShiftRelativeTo = nil) and
             (TppStretchable(lComponent).Region = nil) then
             begin
               if TppStretchable(lComponent).Stretch then
                 AddObjectToList(FStretchables, lComponent, 2)

               else if lComponent.StretchWithParent then
                 AddObjectToList(FStretchers, lComponent, 3)

               else if lComponent.ShiftWithParent then
                 AddObjectToList(FShifters, lComponent, 4)

               else
                 AddObjectToList(FStatics, lComponent, 1);

             end;
        end

      else if (lComponent.Region = nil) then
        begin

          if lComponent.StretchWithParent then
            AddObjectToList(FStretchers, lComponent, 3)

          else if lComponent.ShiftWithParent then
            AddObjectToList(FShifters, lComponent, 4)

          else
            AddObjectToList(FStatics, lComponent, 1);

      end; {if, object is stretchable}
      
    end; {for, each object}

  FObjectLists.Sort;

end; {procedure, CategorizeObjects}

{------------------------------------------------------------------------------}
{ TppBandEngine.Generate }

procedure TppBandEngine.Generate;
begin

  FGenerating := True;
  FGenerationComplete := False;
  FOutOfSpace := False;
  FCount := 0;

  {initialize this value, the first time this band gets a chance to generate}
  if FPageNoOfLastStaticFit = 0 then
   FPageNoOfLastStaticFit := FBand.Report.AbsolutePageNo;

  {allow descendant's to do something}
  BeforeGenerate;

  {added 6.04 - must initialize space used here in case band does not generate
   at all.}
  FSpaceUsed := 0;

  while not(CheckForEndOfGeneration) do
    begin
      {init printing properties}
      FAllObjectsPrinted := True;
      FMaxStretchable := nil;
      FObjectSaved := False;
      FObjectListSaved := False;
      FObjectOverFlow := False;
      FPrintQueue.Clear;
      FSpaceUsed := 0;

      ResetObjects;

      {fire BeforePrint event}
      BeforePrint;

      {calculate the height used by the band}
      CalcPrintPosition;

      if (FBand.Visible) then
        begin

          {allow objects to generate}
          if not(FOutOfSpace) then
            begin
              {increment band counters}
              if not(OverFlow) and not(PartialGeneration) then
                Report.Engine.ReportBandCount := Report.Engine.ReportBandCount + 1;
                
              Report.Engine.PageBandCount := Report.Engine.PageBandCount + 1;
              FCount := FCount + 1;

              {allow descendant's to do something}
              BeforeObjectGenerate;

              GenerateObjects(FObjectListIndex, FObjectIndex);

              {allow descendant's to do something}
              AfterObjectGenerate;

              {update print position}
              UpdatePrintPosition;
            end;

          {allow objects to create print commands}
          Print(Report.Engine.Page);

      end; {if, band is visible}

      {end generation if band not visible}
      GenerationComplete := not(FBand.Visible);

      {fire AfterPrint event}
      AfterPrint;

      {let the app catch up}
      Report.ProcessMessages;

    end; {while, not end of generation}

  {when band is static height, track whether any bands where generated for the page
    and raise an exception if this ocurrs for more than 3 pages.
    this prevents the endless page generation issue}
  if (FBand.PrintHeight = phStatic) then
    begin
      if (Count > 0) or not(FBand.Visible) then
        FPageNoOfLastStaticFit := FBand.Report.AbsolutePageNo
      else if (FBand.Report.AbsolutePageNo - FPageNoOfLastStaticFit) > 3 then
        Report.MainReport.RaiseException(EPrintError.Create('Static height detail band cannot fit on page'));

    end;

  {allow descendants to do something here}
  AfterGenerate;

  FGenerating := False;

end; {procedure, Generate}

{------------------------------------------------------------------------------}
{ TppBandEngine.ResetObjects }

procedure TppBandEngine.ResetObjects;
var
  liIndex: Integer;
begin

  if FOverFlow or FPartialGeneration then Exit;

  for liIndex := 0 to FBand.ObjectCount - 1 do
    FBand.Objects[liIndex].DrawComponent := True;

end; {procedure, ResetObjects}

{------------------------------------------------------------------------------}
{ TppBandEngine.CheckForEndofGeneration }

function TppBandEngine.CheckForEndofGeneration: Boolean;
begin

  Result := False;

  if GenerationComplete then
    Result := True

  else if Report.Engine.StopPrinting then
    Result := True

  else if FOutOfSpace then
    Result := True

  else if (FBand.PrintTimes = ptOne) and (FCount = 1) then
    Result := True

  else if (FBand.PrintTimes = ptCount) and (FCount = FBand.PrintCount) then
    Result := True

  else if ((FBand.PrintCondition * Report.Engine.PrintCondition) = []) then
    Result := True;

end; {function, CheckForEndofGeneration}

{------------------------------------------------------------------------------}
{ TppBandEngine.CalcPrintPosition }

procedure TppBandEngine.CalcPrintPosition;
var
  lRect: TppRect;
  liHeight: Integer;
begin

  {set page bottom}
  FPageBottom := Report.Engine.PageBottom - FBand.mmBottomOffset;

  {set starting position}
  FStartingPosition := Report.Engine.PrintPosRect.Top;

  {adjust starting position to support PrintPosition property}
  AdjustStartingPosition;

  {determine if band can fit on page}
  if (FBand.PrintHeight = phStatic) then
    liHeight := FBand.mmHeight
  else
    liHeight := 0;

  if FBand.Visible and ((FStartingPosition + liHeight) > FPageBottom) then
    FOutOfSpace := True
  else
    begin
      {set print position}
      lRect.Left   := Report.Engine.PrintPosRect.Left;
      lRect.Top    := FStartingPosition;
      lRect.Right  := Report.Engine.PrintPosRect.Right;

      if (FBand.PrintHeight = phStatic) then
        lRect.Bottom := lRect.Top + FBand.mmHeight
      else
        lRect.Bottom := FPageBottom;

      FPrintPosRect := lRect;

      FCurrentPosition := PrintPosRect.Top;

      FMaxStretchablePosition := 0;

      FCurrentPartialAdjustment := FPartialAdjustment;
    end;

end; {procedure, CalcPrintPosition}

{------------------------------------------------------------------------------}
{ TppBandEngine.AdjustStartingPosition }

procedure TppBandEngine.AdjustStartingPosition;
var
  lsMessage: String;
begin

  if (FBand.mmPrintPosition <> 0) then
    begin

      if (FBand.mmPrintPosition >= FPageBottom) then
        begin
          lsMessage := ppLoadStr(415);
          Report.RaiseException(EPrintError.Create(lsMessage + '.'));
        end

      else if (FBand.mmPrintPosition < FStartingPosition) or
              ((FBand.PrintHeight = phStatic) and ((FBand.mmPrintPosition + FBand.mmHeight) > FPageBottom) ) then
        begin
          if (FPrintPositionBreak) then
            FPrintPositionBreak := False
          else
            begin
              FOutOfSpace := True;

              FPrintPositionBreak := True;
            end;
        end
      else
        begin
          if (FPrintPositionBreak) then
            FPrintPositionBreak := False;

          FStartingPosition := FBand.mmPrintPosition;
        end;

    end;

end; {procedure, AdjustStartingPosition}

{------------------------------------------------------------------------------}
{ TppBandEngine.UpdatePrintPosition }

procedure TppBandEngine.UpdatePrintPosition;
var
  lRect: TppRect;
begin
  lRect := FPrintPosRect;

  if (FBand.PrintHeight = phStatic) then
    FSpaceUsed := FBand.mmHeight
  else
    FSpaceUsed := FSpaceUsed;

  FSpaceUsed := FSpaceUsed + FBand.mmBottomOffset;

  lRect.Top := lRect.Top + FSpaceUsed;
  lRect.Bottom := lRect.Top;

  Report.Engine.SetPrintPosition(lRect.Left, lRect.Top, lRect.Right, lRect.Top);

  Report.Engine.SpaceUsed := Report.Engine.SpaceUsed + FSpaceUsed;

end;{procedure, UpdatePrintPosition}

{------------------------------------------------------------------------------}
{ TppBandEngine.Print }

procedure TppBandEngine.Print(aPage: TppPage);
var
  liIndex: Integer;
  lComponent: TppComponent;
begin

  if not(FBand.DrawPage) then Exit;

  CreateDrawCommand(aPage);

  {sort objects by z-order}
  FPrintQueue.Sort;

  for liIndex := 0 to FPrintQueue.Count - 1 do
    begin
      lComponent := TppComponent(FPrintQueue.Objects[liIndex]);

      lComponent.Print(aPage);

      {let the app catch up}
      Report.ProcessMessages;
    end;

end; {procedure, Print}

{------------------------------------------------------------------------------}
{ TppBandEngine.GenerateObjects }

procedure TppBandEngine.GenerateObjects(aListIndex, aObjectIndex: Integer);
var
  liListIndex: Integer;
  liLists: Integer;
  lList: TList;
  liObjectIndex: Integer;
begin

  {generate any reprintonoverflow statics first}
  if OverFlow and (FStatics <> nil) and not(PrintingSection) and (aListIndex <> 0) and not(PartialGeneration) then
    ProcessQueue(FStatics, 0);

  {loop thru object lists, processing each one}
  liListIndex := aListIndex;
  liObjectIndex := aObjectIndex;

  liLists := FObjectLists.Count;

  while (liListIndex < liLists) do
    begin
      lList := TList(FObjectLists.Objects[liListIndex]);

      ProcessQueue(lList, liObjectIndex);

      if not(AllObjectsPrinted) and not(FObjectListSaved) then
        begin
          FObjectListSaved := True;
          FObjectListIndex := liListIndex;
        end;

      {go to next list}
      if not(FPrintingSection) then
        begin
          Inc(liListIndex);

          liObjectIndex := 0;

          {if stretchables don't fit, we're done}
          if (FStretchables <> nil) and (lList = FStretchables) and (SpaceUsed = 0) then
            liListIndex := liLists;
        end
      else
        liListIndex := liLists;

      {let the app catch up}
      Report.ProcessMessages;

    end; {while, each object list}

  {set overflow status}
  FOverFlow := FObjectOverFlow;

  if (FOverFlow) and (FPrintQueue.Count = 0) then
    FOverFlow := False;

  {set partial generation status}
  FPartialGeneration := not(FAllObjectsPrinted) and not(FOverFlow);

  FPartialAdjustment := FCurrentPartialAdjustment;

  if (FPartialGeneration) and (FPrintQueue.Count = 0) then
    FPartialAdjustment := 0

  else if not(FPartialGeneration) then
    FPartialAdjustment := FBand.mmHeight;

  {reset object indexes}
  if (FAllObjectsPrinted) then
    begin
      FObjectListIndex := 0;
      FObjectIndex := 0;
    end;

  {set out of space status}
  if (FPartialGeneration) or (FOverFlow) then
    FOutOfSpace := True;

end; {procedure, GenerateObjects}

{------------------------------------------------------------------------------}
{ TppBandEngine.ProcessQueue }

procedure TppBandEngine.ProcessQueue(aQueue: TList; aObjectIndex: Integer);
var
  liComponent: Integer;
  lComponent: TppComponent;
  lbContinuingPartialGen: Boolean;
  lbAllObjectsPrinted: Boolean;
begin

  liComponent := aObjectIndex;

  lbContinuingPartialGen := FPartialGeneration;
  lbAllObjectsPrinted := FAllObjectsPrinted;

  FCumulativeCurrentPosition := FCurrentPosition;

  while (liComponent < aQueue.Count) and not(GenerationComplete) do
    begin
      lComponent := TppComponent(aQueue[liComponent]);

      lComponent.Generate;

      {add the object to the print queue}
      if (lComponent.SpaceUsed > 0) then
        FPrintQueue.AddObject(Format('%8d', [lComponent.ZOrder]), lComponent);

      {indicate that object did not print completely}
      SaveOverFlowObject(lComponent, liComponent);

      {add to current position}
      IncrementCurrentPosition(lComponent);

      {finish the section}
      if (FPrintingSection) then
        CompleteSection(lComponent, liComponent, aQueue);

      {goto next component}
      Inc(liComponent);

      {let the app catch up}
      Report.ProcessMessages;

    end; {while, each object}

  if (FCumulativeCurrentPosition <> FCurrentPosition) then
    begin
      FCurrentPosition := FCumulativeCurrentPosition;
      FSpaceUsed := FCurrentPosition - PrintPosRect.Top;
    end;

  if lbContinuingPartialGen and not(FAllObjectsPrinted) and (lbAllObjectsPrinted) and (FObjectIndex < aQueue.Count) then
    FCurrentPartialAdjustment :=  TppComponent(aQueue[FObjectIndex]).mmTop;

end; {procedure, ProcessQueue}

{------------------------------------------------------------------------------}
{ TppBandEngine.SaveOverFlowObject }

procedure TppBandEngine.SaveOverFlowObject(aObject: TppComponent; aObjectIndex: Integer);
begin

  if (aObject.GenerationComplete) then Exit;

  {if this component was the first not to print, save it's position in the list}
  if not(FObjectSaved) then
    begin
      FObjectSaved := True;
      FObjectIndex := aObjectIndex;

      if (aObject is TppStretchable) and TppStretchable(aObject).Stretch then
        FObjectOverFlow := True
      else
        FObjectOverFlow := False;

      FAllObjectsPrinted := False;
    end;

  {4.22, enables Stretchable.KeepTogether to work when ShiftWithParent is orphaned}
  {if (FPartialAdjustment = -1) then
    FPartialAdjustment := mmHeight;}

  if (FCurrentPartialAdjustment = 0) then
    FCurrentPartialAdjustment := FBand.mmHeight;

  if (aObject.mmTop < FCurrentPartialAdjustment) then
    FCurrentPartialAdjustment := aObject.mmTop;

end; {procedure, SaveOverFlowObject}

{------------------------------------------------------------------------------}
{ TppBandEngine.IncrementCurrentPosition }

procedure TppBandEngine.IncrementCurrentPosition(aObject: TppComponent);
var
  llCheckPosition: Integer;
begin

  if (FBand.PrintHeight = phStatic) or (FPrintingSection) then Exit;

  {default max stretchable, if possible}
  if (aObject is TppStretchable) and (FMaxStretchable = nil) then
    FMaxStretchable := TppStretchable(aObject);

  if (aObject.SpaceUsed = 0) then Exit;

  llCheckPosition := aObject.PrintPosRect.Top + aObject.SpaceUsed;

  if (llCheckPosition > FCumulativeCurrentPosition) then
    FCumulativeCurrentPosition := llCheckPosition;

  if (aObject is TppStretchable) and (llCheckPosition > FMaxStretchablePosition) then
    begin
      FMaxStretchablePosition := llCheckPosition;
      FMaxStretchable := TppStretchable(aObject);
    end;

end; {procedure, IncrementCurrentPosition}

{------------------------------------------------------------------------------}
{ TppBandEngine.CompleteSection }

procedure TppBandEngine.CompleteSection(aObject: TppComponent; aObjectIndex: Integer; aQueue: TList);
var
  lRect: TppRect;
  lNextObject: TppComponent;
begin

  if not(FPrintingSection) then Exit;

  if not(aObject.GenerationComplete) then
    begin
      GenerationComplete := True;

      Exit;
    end;

  if (aObjectIndex + 1 < aQueue.Count) then
    lNextObject := TppComponent(aQueue[aObjectIndex + 1])
  else
    lNextObject := nil;

  if (lNextObject <> nil) and (lNextObject is TppSubReport) and
     (TppSubReport(lNextObject).PrintBehavior = pbSection) then
    begin
      {indicate to next section that space has been used}
      if aObject.Visible then
        FSpaceUsed := aObject.SpaceUsed;
    end
  else
    begin
      {use up remaining space}
      FCurrentPosition := PageBottom;
      FCumulativeCurrentPosition := FCurrentPosition;
      FSpaceUsed := FCurrentPosition - PrintPosRect.Top;

      lRect := PrintPosRect;
      lRect.Top := PageBottom;
      lRect.Bottom := PageBottom;
      PrintPosRect := lRect;

      FPrintingSection := False;
      FPartialGeneration := False;
      
      if (FBand.PrintHeight = phDynamic) then
        FPartialAdjustment := -1;
        
    end;

end; {procedure, CompleteSection}

{------------------------------------------------------------------------------}
{ TppBandEngine.AfterGenerate }

procedure TppBandEngine.AfterGenerate;
begin

end; {procedure, AfterGenerate}

{------------------------------------------------------------------------------}
{ TppBandEngine.BeforeObjectGenerate }

procedure TppBandEngine.BeforeObjectGenerate;
begin
  DoBeforeGenerate;
end; {procedure, BeforeObjectGenerate}

{------------------------------------------------------------------------------}
{ TppBandEngine.AfterObjectGenerate }

procedure TppBandEngine.AfterObjectGenerate;
begin
  DoAfterGenerate;
end; {procedure, AfterObjectGenerate}

{------------------------------------------------------------------------------}
{ TppBandEngine.BeforePrint }

procedure TppBandEngine.BeforePrint;
var
  liIndex: Integer;
begin

  if (CanAdvanceData) then
    Report.Engine.SyncData;

  {notify objects}
  for liIndex := 0 to FBand.ObjectCount - 1 do
    FBand.Objects[liIndex].BeforePrint;

  {fire event}
  DoBeforePrint;

end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppBandEngine.AfterPrint }

procedure TppBandEngine.AfterPrint;
var
  liObject: Integer;
begin

  {notify objects}
  for liObject := 0 to FBand.ObjectCount - 1 do
    FBand.Objects[liObject].AfterPrint;

  // notify listeners that no space was used by the detail band. This enables
  // a DBCalc or Variable that resides in a footer to restore its prior value
  // so that reflects the correct result
  if (FBand.PrintHeight = phDynamic) and (OutOfSpace) and (SpaceUsed = 0) then
    Report.Engine.SendEventNotify(Report.Engine, ciDetailOutOfSpace, nil);

  {fire event}
  if not(OutOfSpace) or (OverFlow) then
    DoAfterPrint;

end; {procedure, AfterPrint}

{------------------------------------------------------------------------------}
{ TppBandEngine.BeforeGenerate }

procedure TppBandEngine.BeforeGenerate;
begin

end; {procedure, BeforeGenerate}

{------------------------------------------------------------------------------}
{ TppBandEngine.CanAdvanceData }

function TppBandEngine.CanAdvanceData: Boolean;
begin
  Result := False;
end; {function, CanAdvanceData}

{------------------------------------------------------------------------------}
{ TppBandEngine.CreateDrawCommand }

procedure TppBandEngine.CreateDrawCommand(aPage: TppPage);
begin
  if Assigned(FOnCreateDrawCommand) then FOnCreateDrawCommand(Self);
end; {procedure, CreateDrawCommand}

{------------------------------------------------------------------------------}
{ TppBandEngine.DoAfterGenerate }

procedure TppBandEngine.DoAfterGenerate;
begin
  if Assigned(FAfterGenerate) then FAfterGenerate(Self);
end; {procedure, DoAfterGenerate}

{------------------------------------------------------------------------------}
{ TppBandEngine.DoBeforeGenerate }

procedure TppBandEngine.DoBeforeGenerate;
begin
  if Assigned(FBeforeGenerate) then FBeforeGenerate(Self);
end; {procedure, DoBeforeGenerate}

{------------------------------------------------------------------------------}
{ TppBandEngine.DoAfterPrint }

procedure TppBandEngine.DoAfterPrint;
begin
  if Assigned(FAfterPrint) then FAfterPrint(Self);
end; {procedure, DoAfterPrint}

{------------------------------------------------------------------------------}
{ TppBandEngine.DoBeforePrint }

procedure TppBandEngine.DoBeforePrint;
begin
  if Assigned(FBeforePrint) then FBeforePrint(Self);
end; {procedure, DoBeforePrint}

{------------------------------------------------------------------------------}
{ TppBandEngine.GetQueueCount }

function TppBandEngine.GetQueueCount: Integer;
begin
  Result := FPrintQueue.Count;
end; {procedure, GetQueueCount}

end.
