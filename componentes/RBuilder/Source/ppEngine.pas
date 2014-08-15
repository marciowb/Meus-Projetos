{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB                                                
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppEngine;

interface

{$I ppIfDef.pas}

{x$Define CodeSite}

uses
  {$IFDEF CodeSite} rsCodeSite, {$ENDIF}
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppTypes, ppUtils, ppClass, ppBands, ppDB, ppComm, ppReport,
  ppDevice, ppRTTI, ppDrwCmd, ppForms;

const
  cPageStyleBands = 0;
  cPageHeaderBands = 1;
  cReportHeaderBands = 2;
  cColumnHeaderBands = 3;
  cGroupHeaderBands = 4;
  cDetailBands = 5;
  cGroupFooterBands = 6;
  cReportFooterBands = 7;
  cColumnFooterBands = 8;
  cPageFooterBands = 9;

  cPageBandStart = 4;
  cPageBandEnd = 6;

type
                             
  TppTraversalDirectionType = (pptdForward, pptdBackward);
                                                  
  {@TppEngine }
  
  TppEngine = class(TppCustomEngine)
    private
      FAllColumnsStarted: Boolean;
      FBandIndex: Integer;
      FBandListIndex: Integer;
      FColumnComplete: Boolean;
      FColumnarReport: Boolean;
      FColumnStartPosition: Longint;
      FCurrentBand: TppCustomBand;
      FCurrentBookmark: Integer;
      FDetailDataPipeline: TppDataPipeline;
      FFirstPassCompleted2: Boolean;
      FFirstPassStarted: Boolean;
      FLastBand: TppCustomBand;
      FLastPageGenerated: Longint;
      FLookupDataPipelines: TList;
      FMainReportStarted: Boolean;
      FMasterDataPipeline: TppDataPipeline;
      FMasterDetailReport: Boolean;
      FMinGroupNo: Integer;
      FNewCurrentBookmark: Integer;
      FNoDataDialog: TppCustomNoDataDialog;
      FNoDataDrawText: TppDrawText;
      FPageComplete: Boolean;
      FPageListIndex: Integer;
      FPageRequest: TppPageRequest;
      FSecondPassStarted: Boolean;
      FSecondPassCompleted: Boolean;
      FTraversedDetail: Boolean;
      FTraversedMaster: Boolean;

      FMasterDataPipelineState: TppDataPipelineSaveRec;
      FDetailDataPipelineState: TppDataPipelineSaveRec;
      FRestoreMasterDataPipelineState: TppDataPipelineSaveRec;
      FRestoreDetailDataPipelineState: TppDataPipelineSaveRec;
      FDataPipelineStatesRead: Boolean;
      FDataPipelineStatesSaved: Boolean;

      FBandLists: TList;
      FMasterBandList: TStringList;

      FReportHeaderBands: TList;
      FPageHeaderBands: TList;
      FPageStyleBands: TList;
      FColumnHeaderBands: TList;
      FGroupHeaderBands: TList;
      FDetailBands: TList;
      FGroupFooterBands: TList;
      FColumnFooterBands: TList;
      FPageFooterBands: TList;
      FReportFooterBands: TList;

      FColumnStarted: TList;
      FColumnFinished: TList;

      {print routines}
      procedure AfterPass;
      procedure BeforePass;
      procedure CheckGroups(aDataPipeline: TppDataPipeline);
      procedure CategorizeBands;
      procedure ClearBandLists;
      procedure ClearDataPipelines;
      procedure ComputeCalcs;
      function CreateNoDataDrawText: TppDrawText;
      function CreateNoDataDialog: TppCustomNoDataDialog;
      procedure CreateNoDataMessage;
      function DataFound: Boolean;
      procedure DataPipelineRecToState(var aRec: TppDataPipelineSaveRec; aDataPipeline: TppDataPipeline; aFreeBookmark: Boolean);
      procedure DataPipelineStateToRec(aDataPipeline: TppDataPipeline; var aRec: TppDataPipelineSaveRec);
      procedure DoOnNoData;
      procedure FinishColumn;
      procedure FinishPage;
      procedure ForceGroupBreaks;
      procedure FreeBookmarks(aStartPageNo: Integer);
      procedure FreeRestoreBookmarks;
      procedure FreeUnusedBookmarks;
      procedure Generate;
      procedure GenerateBands(aBandList: TList; aBandIndex: Integer; aUpdateBandIndex: Boolean);
      procedure GenerateOrphanedGroupFooter;
      procedure GeneratePage(aBandListIndex, aBandIndex: Integer);
      procedure GetFirstPage;
      procedure GetNextPage;                                                                                     
      function  GetPageFromPageList: Boolean;
      procedure InitBands;
      procedure InitDrawPage;
      procedure InitGroups;
      procedure InitPage;
      procedure KeepGroupsTogether;
      procedure NextMDRecord;
      procedure NextRecord;
      procedure OpenDataPipeline(aDataPipeline: TppDataPipeline); {4.06}
      procedure OpenDataPipelines;
      procedure OpenLookupDataPipelines;
      function  CheckPageStarted: Boolean; {6.04}
      function  PageRequestedInvalid: Boolean;
      procedure PageStart;
      function  PrintingSection: Boolean;
      function  PrintingSubReport: Boolean;
      procedure PriorMDRecord;
      procedure PriorRecord;
      procedure RemoveDrawCommandsFromLastPage;
      procedure RestorePage;
      procedure SaveEngineState;
      procedure SendPage;
      function  SetColumnPosition: Boolean;
      procedure StartColumn;
      procedure StartPage;
      procedure TraverseMaster(aDirection: TppTraversalDirectionType);
      procedure UpdateControlGroup;
      procedure UpdateGenerateCompleted;

    protected
      function GeneratingNewPage: Boolean; override;

      function  GetCurrentBand: TppBand; override;
      function  GetCurrentBandListIndex: Integer; override;
      function  GetPageCount: Longint; override;
      function  GetPageNo: Longint; override;
      function  GetPageBottom: Longint; override;
      function  GetPageStarted: Boolean; override; {4.06}

      function GetColumnStarted(aColumnNo: Integer): Boolean; override;
      procedure SetColumnStarted(aColumnNo: Integer; aValue: Boolean); override;

      function GetColumnFinished(aColumnNo: Integer): Boolean; override;
      procedure SetColumnFinished(aColumnNo: Integer; aValue: Boolean); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      {overriden from Cacheable}
      procedure FreeCache(aCachePageNo: Longint); override;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;

      {overriden from empty implementations in TppCustomEngine}
      function CachePage: Boolean; override;
      procedure CloseDataPipelines; override;
      procedure DataTraversalCompleted; override;
      procedure Init; override;
      procedure RequestPage(aPageRequest: TppPageRequest); override;
      procedure ResetFromPageNo(aAbsolutePageNo: Longint); override;
      procedure PageLimitReached; override;
      procedure Reset; override;
      procedure RestorePipelineState; override;
      procedure SetPageStarted(aValue: Boolean); override;
      procedure SyncData; override;
      procedure TraverseData; override;

    published

  end; {class, TppEngine}

implementation

uses
  ppCtrls, ppStrtch, ppSubRpt, ppNoDataDlg; {4.06 added ppSubRpt}

{******************************************************************************
 *
 ** E N G I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppEngine.Create                                                             }

constructor TppEngine.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);
                                                                                                
  EventNotifies := EventNotifies + [ciPipelineBeforeClose];

  CacheRecordSize := SizeOf(TppEngineSaveRec);

  ESInclude([esInitialized]);

  FDataPipelineStatesRead := False;
  FDataPipelineStatesSaved := False;
  FMainReportStarted := False;
  FCurrentBookmark := 0;
  FNewCurrentBookmark := 0;

  FColumnStarted := nil;
  FColumnFinished := nil;

  FMasterDataPipelineState.FBookmarked := False;
  FDetailDataPipelineState.FBookmarked := False;

  FRestoreMasterDataPipelineState.FBookmarked := False;
  FRestoreDetailDataPipelineState.FBookmarked := False;

  Reset;

  FLookupDataPipelines := TList.Create;
  FPageRequest := TppPageRequest.Create;
  FMasterBandList := TStringList.Create;

  FPageHeaderBands := TList.Create;
  FPageStyleBands := TList.Create;
  FReportHeaderBands := TList.Create;
  FColumnHeaderBands := TList.Create;
  FGroupHeaderBands := TList.Create;
  FDetailBands := TList.Create;
  FGroupFooterBands := TList.Create;
  FColumnFooterBands := TList.Create;
  FReportFooterBands := TList.Create;
  FPageFooterBands := TList.Create;

  FBandLists := TList.Create;

  FBandLists.Add(FPageStyleBands);
  FBandLists.Add(FPageHeaderBands);
  FBandLists.Add(FReportHeaderBands);
  FBandLists.Add(FColumnHeaderBands);
  FBandLists.Add(FGroupHeaderBands);
  FBandLists.Add(FDetailBands);
  FBandLists.Add(FGroupFooterBands);
  FBandLists.Add(FReportFooterBands);
  FBandLists.Add(FColumnFooterBands);
  FBandLists.Add(FPageFooterBands);                             

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppEngine.Destroy }

destructor TppEngine.Destroy;
var
  liBandList: Integer;
  liBandLists: Integer;
begin

  FColumnStarted.Free;
  FColumnFinished.Free;

  FNoDataDrawText.Free;
  
  ClearDataPipelines;

  FLookupDataPipelines.Free;

  {free band lists}
  liBandLists := FBandLists.Count;

  for liBandList := 0 to liBandLists - 1 do
    TList(FBandLists[liBandList]).Free;

  FBandLists.Free;

  {free misc lists}
  FMasterBandList.Free;
  FPageRequest.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppEngine.GetColumnStarted }

function TppEngine.GetColumnStarted(aColumnNo: Integer): Boolean;
begin
  Result := Integer(FColumnStarted[aColumnNo]) = 1;
end;

{------------------------------------------------------------------------------}
{ TppEngine.SetColumnStarted }

procedure TppEngine.SetColumnStarted(aColumnNo: Integer; aValue: Boolean);
begin

  if (aValue) then
    FColumnStarted[aColumnNo] := TObject(1)
  else
    FColumnStarted[aColumnNo] := TObject(0);

end;

{------------------------------------------------------------------------------}
{ TppEngine.GetColumnFinished }

function TppEngine.GetColumnFinished(aColumnNo: Integer): Boolean;
begin
  Result := Integer(FColumnFinished[aColumnNo]) = 1;
end;

{------------------------------------------------------------------------------}
{ TppEngine.SetColumnFinished }

procedure TppEngine.SetColumnFinished(aColumnNo: Integer; aValue: Boolean);
begin

  if (aValue) then
    FColumnFinished[aColumnNo] := TObject(1)
  else
    FColumnFinished[aColumnNo] := TObject(0);

end;

{------------------------------------------------------------------------------}
{ TppEngine.Reset }

procedure TppEngine.Reset;
begin

  if (Printing) then Exit;

  Page.FreeDrawCommands;

  AbsolutePageNo := 0;
  AbsolutePageCount := 0;

  State := [];

  PrintCondition := [];

  FMainReportStarted := False;

  FirstPassCompleted := False;
  FFirstPassCompleted2 := False;
  FSecondPassStarted := False;

  {trigger code module after print (Engine.Ini triggers CodeModuleBeforePrint}
  if not(PrintingSubReport) then
    Report.TriggerCodeModuleAfterPrint;

end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppEngine.Notify }

procedure TppEngine.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  liIndex: Integer;
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and (aCommunicator is TppDataPipeline) then
    begin
      if (aCommunicator = FMasterDataPipeline) or (aCommunicator = FDetailDataPipeline) then
        begin
          FreeUnusedBookmarks;
          FreeRestoreBookmarks;
        end;

      if (aCommunicator = FMasterDataPipeline) then
        FMasterDataPipeline := nil

      else if (aCommunicator = FDetailDataPipeline) then
        FDetailDataPipeline := nil

      else
        begin

          liIndex := FLookupDataPipelines.IndexOf(aCommunicator);

          if (liIndex <> -1) then
            FLookupDataPipelines.Delete(liIndex);
        end;
        
    end;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppEngine.EventNotify }

procedure TppEngine.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aEventID = ciPipelineBeforeClose) then
    begin
      if (aCommunicator = FMasterDataPipeline) or (aCommunicator = FDetailDataPipeline) then
        begin
          FreeUnusedBookmarks;
          FreeRestoreBookmarks;
        end;

    end;


end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppEngine.DataTraversalCompleted }

procedure TppEngine.DataTraversalCompleted;
begin

  AllDataTraversed := True;

  PCInclude([pppcEndOfGroup, pppcEndOfReport]);

end; {procedure, DataTraversalCompleted}

{------------------------------------------------------------------------------}
{ TppEngine.PageLimitReached }

procedure TppEngine.PageLimitReached;
begin

  AllDataTraversed := True;
  LastBandGenerated := True;

  PCInclude([pppcEndOfGroup, pppcEndOfReport]);

end; {procedure, PageLimitReached}

{------------------------------------------------------------------------------}
{ TppEngine.PrintingSubReport }

function TppEngine.PrintingSubReport: Boolean;
begin
  Result := ((Report is TppChildReport) or (Report.PrintingAsSubReport));
end; {procedure, function}

{------------------------------------------------------------------------------}
{ TppEngine.RequestPage }

procedure TppEngine.RequestPage(aPageRequest: TppPageRequest);
begin

  {if we're already generating pages, we're outta here}
  if Printing then Exit;

  {indicate printing is in progress}
  Printing := True;

  {copy page request settings}
  FPageRequest.Assign(aPageRequest);

  {save current record position}
  DataPipelineStateToRec(Report.DataPipeline, FRestoreMasterDataPipelineState);
  DataPipelineStateToRec(TppBandedReport(Report).DetailBand.DataPipeline, FRestoreDetailDataPipelineState);

  {if previously saved, restore record position}
  if Report.PrintingAsSubReport and FDataPipelineStatesSaved then
    begin
      DataPipelineRecToState(FMasterDataPipelineState,  FMasterDataPipeline, True);
      DataPipelineRecToState(FDetailDataPipelineState, FDetailDataPipeline, True);

      FDataPipelineStatesSaved := False;
    end;

  {generate all pages}
  if (Report.PassSetting = psTwoPass) and not(Report is TppChildReport) and
     (not(esInitialized in State) or not(FirstPassCompleted)) then
    begin
      FPageRequest.PageSetting := psAll;

      Generate;

      FPageRequest.PageSetting := aPageRequest.PageSetting;

      {generate requested pages}
      if not(StopPrinting) then
        Generate;
    end
  else
    Generate;

  {save current record position}
  if Report.PrintingAsSubReport and not(FDataPipelineStatesSaved) then
    begin
      DataPipelineStateToRec(FMasterDataPipeline, FMasterDataPipelineState);
      DataPipelineStateToRec(FDetailDataPipeline, FDetailDataPipelineState);

      FDataPipelineStatesSaved := True;
    end;

  {restore previous record position}
  DataPipelineRecToState(FRestoreMasterDataPipelineState, Report.DataPipeline, True);
  DataPipelineRecToState(FRestoreDetailDataPipelineState, TppBandedReport(Report).DetailBand.DataPipeline, True);

  FreeRestoreBookmarks;


  {indicate to external objects that printing is no longer in progress}
  Printing := False;

end; {procedure, RequestPage}

{------------------------------------------------------------------------------}
{ TppEngine.Generate }

procedure TppEngine.Generate;
begin

  {clear indicators}
  GenerateCompleted := False;
  StopPrinting := False;
  LastBandGenerated := False;

  {get engine ready}
  Init;

  Report.DoOnBeforeGenerate;

  {determine starting AbsolutePageNo value}
  GetFirstPage;

  {loop until all page requests granted or printing cancelled}
  while not(GenerateCompleted) and not(StopPrinting) do
    begin

      SpaceUsed := 0;

      {set pass states, fire event handles}
      BeforePass;

      {generate the page}
      RestorePage;

      {set pass states, fire event handles}
      AfterPass;

      {advance to next page}
      GetNextPage;

      Report.ProcessMessages;

{$IFDEF CodeSite}
  gCodeSite.SendString('TppEngine.Generate', 'Page ' + IntToStr(Page.AbsolutePageNo) + ' has finished.');
{$ENDIF}

    end; {while, pagesrequested}

end;  {procedure, Generate}

{------------------------------------------------------------------------------}
{ TppEngine.AfterPass }

procedure TppEngine.AfterPass;
begin

  if not(FirstPassCompleted) or (AbsolutePageNo <> AbsolutePageCount) then Exit;

  {fire events and exclude states}
  if (esFirstPass in State) and not(FFirstPassCompleted2) then
    begin
      FFirstPassCompleted2 := True;

      Report.DoOnEndFirstPass;

      ESExclude([esFirstPass]);
    end

  else if (esSecondPass in State) and not(FSecondPassCompleted) then
    begin
      FSecondPassCompleted := True;

      Report.DoOnEndSecondPass;

      ESExclude([esSecondPass]);
    end;

end; {procedure, AfterPass}

{------------------------------------------------------------------------------}
{ TppEngine.BeforePass }

procedure TppEngine.BeforePass;
begin

  ESExclude([esFirstPass, esSecondPass]);

  {set state}
  if (Report.PassSetting = psOnePass) then
    ESInclude([esFirstPass])

  else if not(FirstPassCompleted) then
    ESInclude([esFirstPass])

  else
    ESInclude([esSecondPass]);

  {fire startpass events}
  if (esFirstPass in State) and not(FFirstPassStarted) then
    begin
      FFirstPassStarted := True;

      Report.DoOnStartFirstPass
    end

  else if (esSecondPass in State) and not(FSecondPassStarted) then
    begin
      FSecondPassStarted := True;

      Report.DoOnStartSecondPass;
    end;

end; {procedure, BeforePass}

{------------------------------------------------------------------------------}
{ TppEngine.GeneratePage }

procedure TppEngine.GeneratePage(aBandListIndex, aBandIndex: Integer);
var
  lBandList: TList;
  liBandListIndex: Integer;
  liBandIndex: Integer;
  lbSectionStarted: Boolean;
begin

  FBandListIndex := aBandListIndex;
  FBandIndex := aBandIndex;
  lbSectionStarted := False;

  {loop until page is complete}
  while (FBandListIndex <= cPageBandEnd) and not(FPageComplete) and not(StopPrinting) and
        not(lbSectionStarted) do
    begin

      if (FColumnarReport) and ((FColumnComplete) or (CurrentColumn = 0)) then
        begin
          FColumnComplete := False;

          {generate column headers}
          liBandListIndex := FBandListIndex;
          liBandIndex := FBandIndex;

          StartColumn;

          FBandListIndex := liBandListIndex;
          FBandIndex := liBandIndex;

          {generate group headers}
          if (FBandListIndex = cGroupFooterBands) then
            GenerateOrphanedGroupFooter

          else if (FBandListIndex = cDetailBands) or (FBandListIndex = cGroupHeaderBands) then
            begin
              GenerateBands(FGroupHeaderBands, 0, True);

              FBandListIndex := cDetailBands;
              FBandIndex := 0;
            end;

        end;

      if not(FColumnarReport and FColumnComplete) then
        begin
          {generate bands in list}
          lBandList := FBandLists[FBandListIndex];

          GenerateBands(lBandList, FBandIndex, True);

          {advance to next band list}
          if (not(FColumnarReport) and not(FPageComplete)) or
             ((FColumnarReport) and not(FColumnComplete)) then
            begin
              if (FBandListIndex = cPageBandEnd) and not(AllDataTraversed) then
                FBandListIndex := cPageBandStart
              else
                FBandListIndex := FBandListIndex + 1;

              FBandIndex := 0;
            end;
        end;

      Report.ProcessMessages;

      lbSectionStarted := (esStartSection in State);
    end; {while}

  {generate report footer bands}
  if not(FPageComplete) and (AllDataTraversed) then
    begin
      FBandListIndex := cReportFooterBands;

      GenerateBands(FReportFooterBands, 0, True);
    end;

  {print final drawcommands and indicate page is complete}
  if not(FPageComplete) then
    if (FColumnarReport) then
      FinishColumn
    else
      FinishPage;

end; {procedure, GeneratePage}

{------------------------------------------------------------------------------}
{ TppEngine.PrintingSection }

function TppEngine.PrintingSection: Boolean;
begin
  Result := (esGenerateSection in State) or (esStartSection in State);
end; {function, PrintingSection}

{------------------------------------------------------------------------------}
{ TppEngine.RestorePipelineState }

procedure TppEngine.RestorePipelineState;
begin

   if not(FDataPipelineStatesRead) then Exit;

   DataPipelineRecToState(FMasterDataPipelineState, FMasterDataPipeline, False);
   DataPipelineRecToState(FDetailDataPipelineState, FDetailDataPipeline, False);

   FDataPipelineStatesRead := False;

end; {function, RestorePipelineState}

{------------------------------------------------------------------------------}
{ TppEngine.RestorePage }

procedure TppEngine.RestorePage;
var
  liGroup: Integer;
begin

  {restore report state as of the end of the previous page}
  {if not(PrintingSubReport) and (FLastPageGenerated <> AbsolutePageNo - 1) then}
  DoOnReadCache;

  {restore pipeline states - this sets the record positions}
  RestorePipelineState;

  {special section logic}
  if PrintingSection then
    begin
      InitPage;

      PageStarted := False;

      GeneratePage(FBandListIndex, FBandIndex);

      Exit;
    end;

  {start the page}
  StartPage;

  if (FBandListIndex <> cGroupFooterBands) then
    begin
      SyncData;

      {refresh group values, must do this after start page}
      for liGroup := 0 to Report.GroupCount - 1 do
        Report.Groups[liGroup].RefreshBreakValues;
    end;

  {reset the indexes}
  case FBandListIndex of

    cGroupHeaderBands:
      FBandIndex := 0;

    cDetailBands, cPageHeaderBands, cReportHeaderBands, cColumnHeaderBands:
      begin
        FBandListIndex := cGroupHeaderBands;
        FBandIndex := 0;
      end;

    cGroupFooterBands:
      if not(FColumnarReport) then
        GenerateOrphanedGroupFooter;

  end; {case, band list type}

  {continue with the page}
  GeneratePage(FBandListIndex, FBandIndex);

end; {procedure, RestorePage}

{------------------------------------------------------------------------------}
{ TppEngine.GenerateOrphanedGroupFooter }

procedure TppEngine.GenerateOrphanedGroupFooter;
var
  liBandIndex: Integer;
  lGroupBand: TppGroupBand;
  lbGroupFootersComplete: Boolean;
  lGroupHeaderBands: TList;
  liOrphanGroup: Integer;
  liGroup: Integer;
begin

  {save generation state of all group headers}
  for liBandIndex := 0 to FGroupHeaderBands.Count - 1 do
    begin
      lGroupBand := TppGroupBand(FGroupHeaderBands[liBandIndex]);
      lGroupBand.SaveGeneration := lGroupBand.Generation;
      lGroupBand.Generation := False;
    end;

  {generate group headers for groups outside orphaned group}
  lGroupBand := FGroupFooterBands[FBandIndex];

  liOrphanGroup := Report.FindGroup(lGroupBand.Group);

  {generate header for orphaned group based on HeaderForOrphanedFooter prop}
  if not(lGroupBand.Group.HeaderForOrphanedFooter) then
    liOrphanGroup := liOrphanGroup - 1;

  {generate group headers}
  if (liOrphanGroup > -1) then
    begin
      lGroupHeaderBands := TList.Create;

      for liBandIndex := 0 to liOrphanGroup do
        lGroupHeaderBands.Add(FGroupHeaderBands[liBandIndex]);

      GenerateBands(lGroupHeaderBands, 0, False);

      lGroupHeaderBands.Free;
    end;

  PCExclude([pppcStartOfPage, pppcStartOfColumn, pppcStartOfReport]);

  {restore group header generation state}
  for liBandIndex := 0 to FGroupHeaderBands.Count - 1 do
    begin
      lGroupBand := TppGroupBand(FGroupHeaderBands[liBandIndex]);
      lGroupBand.Generation := lGroupBand.SaveGeneration;
    end;

  {generate group footers}
  liBandIndex := FBandIndex;

  GenerateBands(FGroupFooterBands, FBandIndex, True);

  lGroupBand := TppGroupBand(FGroupFooterBands[liBandIndex]);

  {determine if all group footer printed}
  lbGroupFootersComplete := True;
  liBandIndex := FBandIndex;

  while (liBandIndex < FGroupFooterBands.Count) and (lbGroupFootersComplete) do
    begin
      lGroupBand := FGroupFooterBands[liBandIndex];

      lbGroupFootersComplete := not(lGroupBand.OutOfSpace);

      Inc(liBandIndex);
    end;

  if AllDataTraversed and (lbGroupFootersComplete) then
    begin
      FBandListIndex := cReportFooterBands;
      FBandIndex := 0;
    end
  else if (lbGroupFootersComplete) then
    begin
      FBandListIndex := cGroupHeaderBands;
      FBandIndex := 0;
    end;

  {refresh group values}
  for liGroup := 0 to Report.GroupCount - 1 do
    Report.Groups[liGroup].RefreshBreakValues;

  {if group footer orphaned for StartNewPage, don't advance record}
  if lGroupBand.Group.NewPage then Exit;

  SyncData;

end; {procedure, GenerateOrphanedGroupFooter}

{------------------------------------------------------------------------------}
{ TppEngine.KeepGroupsTogether }

procedure TppEngine.KeepGroupsTogether;
var
  lbKeepTogether: Boolean;
begin

  if (ControlKeepTogether = nil) then Exit;

  {modified for 4.06}
  if (FCurrentBand is TppDetailBand) then
    lbKeepTogether := True

  else if (FCurrentBand is TppGroupFooterBand) then
    lbKeepTogether := (TppGroupFooterBand(FCurrentBand).Group.GroupNo >= ControlKeepTogether.GroupNo)

  else if (FCurrentBand is TppGroupHeaderBand) then
    lbKeepTogether := (TppGroupHeaderBand(FCurrentBand).Group.GroupNo >= ControlKeepTogether.GroupNo)

  else
    lbKeepTogether := False;

  if lbKeepTogether then
    ControlKeepTogether.DetailOutOfSpace

end; {procedure, KeepGroupsTogether}

{------------------------------------------------------------------------------}
{ TppEngine.GenerateBands }

procedure TppEngine.GenerateBands(aBandList: TList; aBandIndex: Integer; aUpdateBandIndex: Boolean);
var
  liBands: Integer;
  liBand: Integer;
  lbOutOfSpace: Boolean;
  liSpaceUsed: Integer;
  liBottom: Integer;
begin

  {generate start page bands}
  liBands := aBandList.Count;

  liBand := aBandIndex;

  lbOutOfSpace := False;
  liBottom := 0;
  liSpaceUsed := 0;

  while (liBand < liBands) and not(lbOutOfSpace) and not(StopPrinting) do
    begin
      FCurrentBand := TppCustomBand(aBandList[liBand]);

      if (FColumnarReport) and (FCurrentBand is TppDetailBand) and (CurrentColumn > 1) then
        begin
          liBottom := PrintPosRect.Bottom;
          liSpaceUsed := SpaceUsed;

          SpaceUsed := 0;
        end;

      FCurrentBand.Generate;

      if StopPrinting then
        exit;

      if CheckPageStarted then
        PageStarted := True;

      if (FColumnarReport) and (FCurrentBand is TppDetailBand) and (CurrentColumn > 1) then
        begin
          if (liBottom > PrintPosRect.Bottom) then
            SpaceUsed := liSpaceUsed + (liBottom - PrintPosRect.Bottom)
          else
            SpaceUsed := liSpaceUsed;
        end

      else if (PrintPosRect.Bottom > SpaceUsed) then
        SpaceUsed := PrintPosRect.Bottom;

      lbOutOfSpace := FCurrentBand.OutOfSpace;

      if (lbOutOfSpace) then
        KeepGroupsTogether;

      if (AllDataTraversed) and (FCurrentBand = FLastBand) and not(lbOutOfSpace) then
        LastBandGenerated := True;

      if not(lbOutOfSpace) then
        Inc(liBand);

      Report.ProcessMessages;
    end;

  if (aBandList = FGroupHeaderBands) and not(lbOutOfSpace) then
    PCExclude([pppcStartOfPage, pppcStartOfColumn, pppcStartOfReport]);

  if (aUpdateBandIndex) then
    if (liBand < aBandList.Count) then
      FBandIndex := liBand
    else
      FBandIndex := aBandList.Count - 1;


  {finish the page or column}
  if lbOutOfSpace and not(pppcEndOfPage in PrintCondition) and not(StopPrinting) then

    if (FColumnarReport) then
      FinishColumn
    else
      FinishPage;

  {clear current band}
  FCurrentBand := nil;

end; {procedure, GenerateBands}

{------------------------------------------------------------------------------}
{ TppEngine.CheckPageStarted }

function TppEngine.CheckPageStarted: Boolean;
var
  lGroupBand: TppGroupBand;
begin

  Result := False;

  if PageStarted then
    Result := True

  else if (FCurrentBand is TppGroupHeaderBand) then
    begin
     lGroupBand := TppGroupBand(FCurrentBand);

     {if group header band is not reprint on subsequent and it is taking up space, return true}
     if not(lGroupBand.Group.ReprintOnSubsequentPage) and (FCurrentBand.SpaceUsed > 0) then
       Result := True;
    end

  else if (FBandListIndex <> cReportHeaderBands) and
          (FBandListIndex <> cPageHeaderBands) and
          (FBandListIndex <> cColumnHeaderBands) and
          (FCurrentBand.SpaceUsed > 0) then
    begin
      Result := True;
    end

end; {function, CheckPageStarted}


{------------------------------------------------------------------------------}
{ TppEngine.UpdateGenerateCompleted }

procedure TppEngine.UpdateGenerateCompleted;
begin

  case FPageRequest.PageSetting of
    psAll, psLastPage:
      if (LastBandGenerated) and (DrawPage) and (AbsolutePageNo = AbsolutePageCount) then
        GenerateCompleted := True;

    psSinglePage:
      if (AbsolutePageNo >= FPageRequest.PageRequested) and (DrawPage) then
        GenerateCompleted := True;

    psFirstPage:
      if (AbsolutePageNo >= 1) and (DrawPage)  then
        GenerateCompleted := True;

    psPageList:
      if (PageRequestedInvalid) then
        GenerateCompleted := True;

   end; {case, page settting type}

end; {procedure, UpdateGenerateCompleted}

{------------------------------------------------------------------------------}
{ TppEngine.GetFirstPage }

procedure TppEngine.GetFirstPage;
begin

  DoOnGetLastPageCached;

  if FPageRequest.PageRequested < AbsolutePageNo then
    SendEventNotify(Self, ciPageBackward, nil);

  {determine starting page no}
  case FPageRequest.PageSetting of
    psAll:
      AbsolutePageNo := 1;

    psSinglePage:
      begin
        if FirstPassCompleted and (FPageRequest.PageRequested > AbsolutePageCount) then
          FPageRequest.PageRequested := AbsolutePageCount

        else if (FPageRequest.PageRequested < 1) then
          FPageRequest.PageRequested := 1;

        AbsolutePageNo := FPageRequest.PageRequested;
      end;

    psFirstPage:
      AbsolutePageNo := 1;

    psLastPage:
      if FirstPassCompleted then
        AbsolutePageNo := AbsolutePageCount
      else
        AbsolutePageNo := LastPageCached + 1;

    psPageList:
      begin
        FPageListIndex := 0;

        if GetPageFromPageList then
          AbsolutePageNo := FPageRequest.PageRequested
        else
          GenerateCompleted := True;

      end;

   end; {case, page setting type}


  {if page is beyond page cache, start from last page cached}
  if (AbsolutePageNo > (LastPageCached + 1) ) then
    AbsolutePageNo := LastPageCached + 1;

end; {procedure, GetFirstPage}

{------------------------------------------------------------------------------}
{ TppEngine.GetNextPage }

procedure TppEngine.GetNextPage;
begin

  if GenerateCompleted then Exit;

  if (FPageRequest.PageRequested < AbsolutePageNo) and (FPageRequest.PageSetting = psSinglePage) then
    SendEventNotify(Self, ciPageBackward, nil);

  case FPageRequest.PageSetting of
    psAll:
      if (LastBandGenerated) then
        GenerateCompleted := True
      else
        AbsolutePageNo := AbsolutePageNo + 1;

    psSinglePage:
      begin
        if (AbsolutePageNo >= FPageRequest.PageRequested) then
          GenerateCompleted := DrawPage;

        if not(GenerateCompleted) then
          begin
            if FirstPassCompleted and (FPageRequest.PageRequested > AbsolutePageCount) then
              FPageRequest.PageRequested := AbsolutePageCount

            else if (FPageRequest.PageRequested < 1) then
              FPageRequest.PageRequested := 1;

            AbsolutePageNo := FPageRequest.PageRequested;
          end;

      end;

    psFirstPage:
      if (AbsolutePageNo >= 1) then
        GenerateCompleted := True;

    psLastPage:
      if (LastBandGenerated) then
        GenerateCompleted := DrawPage
      else
        AbsolutePageNo := AbsolutePageNo + 1;

    psPageList:
      begin
        if GetPageFromPageList then
          AbsolutePageNo := FPageRequest.PageRequested
        else
          GenerateCompleted := True;
      end;

   end; {case, page setting type}

  DoOnGetLastPageCached;

  if (AbsolutePageNo > (LastPageCached + 1)) then
    begin
      if FirstPassCompleted then
        AbsolutePageNo := LastPageCached
      else
        AbsolutePageNo := LastPageCached + 1;
    end;

end; {procedure, GetNextPage}

{------------------------------------------------------------------------------}
{ TppEngine.GetPageFromPageList }

function TppEngine.GetPageFromPageList: Boolean;
var
  lbInvalidPage: Boolean;
begin
  Result := True;

  if (FPageRequest.PageList = nil) then
    Result := False

  else if (FPageListIndex >= FPageRequest.PageList.Count) then
    Result := False

  else
    begin
      lbInvalidPage := True;

      while (FPageListIndex < FPageRequest.PageList.Count) and lbInvalidPage do
        begin
          lbInvalidPage := PageRequestedInvalid;

          if (FPageRequest.PageRequested <= (AbsolutePageCount + 1)) or lbInvalidPage then
            Inc(FPageListIndex);
        end; {while, pages invalid}

      if (lbInvalidPage) then
        Result := False;
    end;

end; {function, GetPageFromPageList}

{------------------------------------------------------------------------------}
{ TppEngine.PageRequestedInvalid }

function TppEngine.PageRequestedInvalid: Boolean;
begin

  Result := True;

  if (FPageRequest.PageList = nil) then Exit;

  if (FPageListIndex >= FPageRequest.PageList.Count) then Exit;

  FPageRequest.PageRequested := StrToInt(FPageRequest.PageList[FPageListIndex]);

  if FirstPassCompleted then
    begin
      if (FPageRequest.PageRequested > 0) and (FPageRequest.PageRequested <= AbsolutePageCount) then
        Result := False;
    end

  else if (FPageRequest.PageRequested > 0) then
    Result := False;
    
end; {procedure, PageRequestedInvalid}

{------------------------------------------------------------------------------}
{ TppEngine.StartPage }

procedure TppEngine.StartPage;
var
  liBandIndex: Integer;
  liBandListIndex: Integer;
  liIndex: Integer;
begin

  PageStarted := False;

  {save current band settings}
  liBandIndex := FBandIndex;
  liBandListIndex := FBandListIndex;

  InitPage;


  {print page style bands}
  if not(FPageComplete) then
    begin
      PCInclude([pppcStartOfPage]);

      GenerateBands(FPageStyleBands, 0, False);

      PCExclude([pppcStartOfPage]);
    end;

    
  {print report header bands}
  if (pppcStartOfReport in PrintCondition) then
    begin
      FBandListIndex := cReportHeaderBands;

      GenerateBands(FReportHeaderBands, 0, True);

      if not(FPageComplete) then
        PCExclude([pppcStartOfReport]);
    end;


  {print page header bands}
  if not(FPageComplete) then
    begin
      PCInclude([pppcStartOfPage]);

      FBandListIndex := cPageHeaderBands;

      GenerateBands(FPageHeaderBands, 0, True);

      {restore band list and band position}
      FBandIndex := liBandIndex;
      FBandListIndex := liBandListIndex;
    end;

  if (TppBandedReport(Report).Detail.ColumnTraversal = ctLeftToRight) then
    begin
      for liIndex := 0 to FColumnStarted.Count - 1 do
        FColumnStarted[liIndex] := TObject(0);

      for liIndex := 0 to FColumnFinished.Count - 1 do
        FColumnFinished[liIndex] := TObject(0);
    end;

end; {procedure, StartPage}

{------------------------------------------------------------------------------}
{ TppEngine.InitPage }

procedure TppEngine.InitPage;
var
  liBand: Integer;
begin

  TppBandedReport(Report).Detail.Count := 0;

  if (AbsolutePageNo = 1) then
    SendEventNotify(Self, ciEngineStart, nil);
    
  {fire appropriate report events}
  Report.DoOnStartPage;

  {force detail band to print, before first traversal}
  if (AbsolutePageNo = 1) then
    PCInclude([pppcOnTraversal]);

  {set print position to top of page}
  SetPrintPosition(Page.PageDef.mmMarginLeft, Page.PageDef.mmMarginTop,
                   Page.PageDef.mmPrintableWidth, Page.PageDef.mmMarginTop);

  {init indicator used to support detailband printposition property}
  FirstDetailBandPrinted := False;

  FAllColumnsStarted := False;
  CurrentColumn := 0;
  FColumnStartPosition := 0;

  FPageComplete := False;

  PageBandCount := 1;

  {during first pass, update page count}
  if not(FirstPassCompleted) and (AbsolutePageNo > AbsolutePageCount) then
    begin
      AbsolutePageCount := AbsolutePageNo;

      UpdateControlGroup;
    end;

  {clear any draw commands}
  Page.FreeDrawCommands;

  {send message page}
  DrawPage := False;

  SendPage;

  {set draw page}
  InitDrawPage;

  {notify bands of draw page value}
  for liBand := 0 to (Report.BandCount - 1) do
    Report.Bands[liBand].DrawPage := DrawPage;

  {notify bands & objects that page has started}
  PageStart;

end; {procedure, InitPage}

{------------------------------------------------------------------------------}
{ TppEngine.UpdateControlGroup }

procedure TppEngine.UpdateControlGroup;
var
  lGroup: TppGroup;
  lGroupHeader: TppGroupHeaderBand;
  lBandList: TList;
  lBand: TppCustomBand;
  lComponent: TppComponent;
  lbUpdate: Boolean;
  liIndex: Integer;
begin

  if (ControlGroup = nil) then Exit;

  {modified for 4.06}
  if not(FBandListIndex = cGroupFooterBands) and not(FBandListIndex = cReportFooterBands) then
    begin

      {set first page of all ResetPageNo groups}
      for liIndex := 0 to Report.GroupCount - 1 do
        begin
          lGroup := Report.Groups[liIndex];

          if (lGroup.ResetPageNo) then
            begin
              lGroupHeader := TppGroupHeaderBand(lGroup.HeaderBand);

              if ((pppcStartOfReport in PrintCondition) or ((lGroupHeader.Generation) and not(lGroupHeader.OverFlow)) )then
                lGroup.FirstPageNo := AbsolutePageNo;
            end;
        end;
        
    end;

  if PrintingSection then
    begin
      lBandList := TList(FBandLists[FBandListIndex]);
      lBand := TppCustomBand(lBandList[FBandIndex]);
      lComponent := lBand.CurrentObject;

      if (lComponent is TppSubReport) and not(TppSubReport(lComponent).ResetPageNo) then
        lbUpdate := True
      else
        lbUpdate := False;
    end
  else
    lbUpdate := True;


  {update page count of all ResetPageNo groups}
  if lbUpdate then
    begin

      for liIndex := 0 to Report.GroupCount - 1 do
        begin
          lGroup := Report.Groups[liIndex];

          if (lGroup.ResetPageNo) and (FBandListIndex <> cReportFooterBands) then
            lGroup.UpdatePageCount;
        end;
        
    end;

end; {procedure, UpdateControlGroup}

{------------------------------------------------------------------------------}
{ TppEngine.FinishPage }

procedure TppEngine.FinishPage;
begin

  {indicate to engine that page has been completed}
  FPageComplete := True;

  {save engine state to cache}
  if not(FColumnarReport) then
    SaveEngineState;
    
  {save last generated page}
  FLastPageGenerated := AbsolutePageNo;

  {put record on correct position for printing column footers}
  if CalcsOutOfSync and not(FColumnarReport) then
    PriorRecord;

  Report.FinishPage;

  {generate page footer bands}
  if not(pppcEndofPage in PrintCondition) and ([esGenerateSection, esEndSection] * State = []) then
    begin
      PCInclude([pppcEndOfPage]);

      GenerateBands(FPageFooterBands, 0, False);
    end;

  {notify report that page is complete, do this before writing to cache}
  DoOnPageEnd;

  if not(Report.PrintingAsSubreport) then
    TppReport(Report).GenerateOutlineDrawCommand;

  {if we've traversed all data and last band has been generated, we're done}
  if ((esFirstPass in State) and (AllDataTraversed) and (LastBandGenerated)) then
    begin
      if not(FirstPassCompleted) then
        FirstPassCompleted := True;

      SendEventNotify(Self, ciEngineEnd, nil);

      {notify all objects in report that report has started}
      if not(PrintingSubReport) and FMainReportStarted then
        Report.EndOfMainReport;
    end;

  {this is the last page remove unneeded draw commands}
  if (FirstPassCompleted) and (AbsolutePageNo = AbsolutePageCount) and (DrawPage) then
    RemoveDrawCommandsFromLastPage;

  {add no data draw text so it appears in front}
  if not(DataFound) and (SpaceUsed <> 0) then
    begin
      CreateNoDataMessage;

      if (FNoDataDrawText <> nil) then
        begin
          FNoDataDrawText.Page := Page;
          FNoDataDrawText := nil;
        end;
    end;

  {notify all bands and objects}
  DoBeforeSendPage;

  {send the page}
  SendPage;

  {4.06 - new print job fix}
  UpdateGenerateCompleted;

  {notify all bands and objects}
  DoAfterSendPage;

  {clear end of page condition}
  PCExclude([pppcEndOfPage]);

end; {procedure, FinishPage}

{------------------------------------------------------------------------------}
{ TppEngine.RemoveDrawCommandsFromLastPage }

procedure TppEngine.RemoveDrawCommandsFromLastPage;
var
  lDrawCommands: TList;
  liIndex: Integer;
  liIndex2: Integer;
  lHeaderBand: TppHeaderBand;
  liHeaderSpaceUsed: Integer;
  lFooterBand: TppFooterBand;
  liFooterSpaceUsed: Integer;
  lDrawCommand: TppDrawCommand;
begin

  if not(DrawPage) then Exit;
  
  lDrawCommands := TList.Create;

  {remove header band draw commands}
  liHeaderSpaceUsed := 0;

  for liIndex := 0 to FPageHeaderBands.Count - 1 do
    begin
      lHeaderBand := TppHeaderBand(FPageHeaderBands[liIndex]);

      if (lHeaderBand.SpaceUsed > liHeaderSpaceUsed) then
        liHeaderSpaceUsed := lHeaderBand.SpaceUsed;

      if not(lHeaderBand.PrintOnLastPage) then
        begin

          for liIndex2 := 0 to Page.DrawCommandCount - 1 do
            begin
              lDrawCommand := Page.DrawCommands[liIndex2];

              {save header band draw commands so that they can be removed}
              if (lDrawCommand.Band = lHeaderBand) then
                lDrawCommands.Add(lDrawCommand)

              {shift draw commands up for space used by header}
              else if not(lDrawCommand.Band is TppTitleBand) and not(lDrawCommand.Band is TppFooterBand) and not(lDrawCommand.Band is TppColumnFooterBand) then
                lDrawCommand.Top := lDrawCommand.Top - liHeaderSpaceUsed;

            end;

        end;

    end;

  {remove footer band draw commands}
  liFooterSpaceUsed := 0;

  for liIndex := 0 to FPageFooterBands.Count - 1 do
    begin
      lFooterBand := TppFooterBand(FPageFooterBands[liIndex]);

      if (lFooterBand.SpaceUsed > liFooterSpaceUsed) then
        liFooterSpaceUsed := lFooterBand.SpaceUsed
      else
        liFooterSpaceUsed := lFooterBand.mmHeight; {6.04}


      if not(lFooterBand.PrintOnLastPage) then
        begin

          for liIndex2 := 0 to Page.DrawCommandCount - 1 do
            begin
              lDrawCommand := Page.DrawCommands[liIndex2];

              {save footer band draw commands so that they can be removed}
              if (lDrawCommand.Band = lFooterBand) then
                lDrawCommands.Add(lDrawCommand)

              {shift column footer draw commands down for space used by header}
              else if (lDrawCommand.Band is TppColumnFooterBand) then
                lDrawCommand.Top := lDrawCommand.Top + liFooterSpaceUsed;
            end;

        end;

    end;

  {free header and footer draw commands}
  for liIndex := 0 to lDrawCommands.Count - 1 do
    begin
      lDrawCommand := TppDrawCommand(lDrawCommands[liIndex]);

      lDrawCommand.Page := nil;
      
      lDrawCommand.Free;
    end;

  lDrawCommands.Free;

end; {procedure, RemoveDrawCommandsFromLastPage}

{------------------------------------------------------------------------------}
{ TppEngine.CachePage }

function TppEngine.CachePage;
begin

  {get the last page cached}
  DoOnGetLastPageCached;

  Result := (AbsolutePageNo = 0) or (AbsolutePageNo > LastPageCached);

end; {function, CachePage}

{------------------------------------------------------------------------------}
{ TppEngine.SaveEngineState }

procedure TppEngine.SaveEngineState;
begin

  {this is the last page, no need to cache}
  if not(PrintingSubReport) and (Report.Engine.FirstPassCompleted or Report.MainReport.Engine.FirstPassCompleted) then Exit;

  {free bookmarks from any previously saved record positions}
  FreeUnusedBookmarks;

  {save record positions}
  FDataPipelineStatesSaved := True;
  DataPipelineStateToRec(Report.DataPipeline, FMasterDataPipelineState);
  DataPipelineStateToRec(TppBandedReport(Report).DetailBand.DataPipeline, FDetailDataPipelineState);

  {save engine state}
  if Report.MainReport.Engine.CachePage then
    DoOnWriteCache;

end; {procedure, SaveEngineState}

{------------------------------------------------------------------------------}
{ TppEngine.FreeUnusedBookmarks }

procedure TppEngine.FreeUnusedBookmarks;
begin

  if not(FDataPipelineStatesSaved) then Exit;

  FDataPipelineStatesSaved := False;

  if (FMasterDatapipeline <> nil) and FMasterDataPipelineState.FBookmarked then
    begin
      FMasterDataPipeline.FreeBookmark(FMasterDataPipelineState.FBookmark);
      FMasterDataPipelineState.FBookmarked := False;
    end;

  if (FDetailDataPipeline <> nil) and FDetailDataPipelineState.FBookmarked then
    begin
      FDetailDataPipeline.FreeBookmark(FDetailDataPipelineState.FBookmark);
      FDetailDataPipelineState.FBookmarked := False;
    end;

end; {procedure, FreeUnusedBookmarks}

{------------------------------------------------------------------------------}
{ TppEngine.FreeRestoreBookmarks }

procedure TppEngine.FreeRestoreBookmarks;
begin

  if (FMasterDatapipeline <> nil) and FRestoreMasterDataPipelineState.FBookmarked then
    begin
      FMasterDataPipeline.FreeBookmark(FRestoreMasterDataPipelineState.FBookmark);
      FRestoreMasterDataPipelineState.FBookmarked := False;
    end;

  if (FDetailDataPipeline <> nil) and FRestoreDetailDataPipelineState.FBookmarked then
    begin
      FDetailDataPipeline.FreeBookmark(FRestoreDetailDataPipelineState.FBookmark);
      FRestoreDetailDataPipelineState.FBookmarked := False;
    end;


end; {procedure, FreeRestoreBookmarks}

{------------------------------------------------------------------------------}
{ TppEngine.SendPage }

procedure TppEngine.SendPage;
begin

  {notify devices that we're starting a page}
  Page.AbsolutePageNo := AbsolutePageNo;
  Page.AbsolutePageCount := AbsolutePageCount;

  if (ControlGroup <> nil) then
    Page.ControlGroupBreakNo := ControlGroup.BreakNo;

  Page.DocumentName := Report.PrinterSetup.DocumentName;
  Page.FirstPage := (AbsolutePageNo = 1);
  Page.LanguageIndex := Report.LanguageIndex;
  Page.LastPage := (LastBandGenerated and (AbsolutePageNo = AbsolutePageCount));
  Page.PassSetting := Report.PassSetting;
  {Page.PageNo := PageNo;
  Page.PageCount := PageCount;} {4.06}

  if ([esStartSection, esGenerateSection, esEndSection] * State = []) then
    begin
      Page.PageNo := PageNo;
      Page.PageCount := PageCount;
    end;

  Page.PrintDateTime := PrintDateTime;

  if ((Report.PassSetting = psOnePass) and (esFirstPass in State)) or
     ((Report.PassSetting = psTwoPass) and (esSecondPass in State)) and DrawPage then
    Page.Final := True
  else
    Page.Final := False;

  Page.Calculation := not(DrawPage);

  DoOnPageSent;

end; {procedure, SendPage}

{------------------------------------------------------------------------------}
{ TppEngine.StartColumn }

procedure TppEngine.StartColumn;
var
  liBandListIndex: Integer;
  liBandIndex: Integer;
begin

  if (esPrintingTitle in State) or (esPrintingSummary in State) then Exit;

  liBandListIndex := FBandListIndex;
  liBandIndex := FBandIndex;

  {initialize column start position}
  if (CurrentColumn = 0) then
    FColumnStartPosition := PrintPosRect.Top;

  if (CurrentColumn < Report.Columns) then
    begin
      CurrentColumn := CurrentColumn + 1;

      if SetColumnPosition and not(FAllColumnsStarted) then
        begin
          Report.DoOnStartColumn;

          PCInclude([pppcStartOfColumn]);

          FBandListIndex := cColumnHeaderBands;

          PageStarted := False;

          GenerateBands(FColumnHeaderBands, 0, True);

          if (CurrentColumn = Report.Columns) then
            FAllColumnsStarted := True;
        end; {if, column position successfully set}

    end; {if, column should be advanced}

  FBandListIndex := liBandListIndex;
  FBandIndex := liBandIndex;

end; {procedure, StartColumn}

{------------------------------------------------------------------------------}
{ TppEngine.FinishColumn }

procedure TppEngine.FinishColumn;
var
  lbStartNewPage: Boolean;
  lbNextColumnValid: Boolean;
  lSaveRect: TppRect;
  lGroup: TppGroup;
begin

  {indicate column is complete}
  FColumnComplete := True;

  {check to see if group forces new page, do this first}
  lbStartNewPage := False;

  if (((esPrintingTitle in State) or (esPrintingSummary in State)) and (TppBandedReport(Report).Detail.Count = 0)) then
    lbStartNewPage := True

  else if (FCurrentBand is TppGroupHeaderBand) then
    begin
      lGroup := TppGroupHeaderBand(FCurrentBand).Group;

      if lGroup.NewPage and not(lGroup.NewColumn) then
        lbStartNewPage := True

      else if FCurrentBand.OutOfSpace and (lGroup.NewPageThreshold <> 0) and (lGroup.NewColumnThreshold = 0) then
        lbStartNewPage := True;
     end;

  if (CurrentColumn > 0) and (CurrentColumn = Report.ColumnPositions.Count) then
    lbNextColumnValid := False
  else
    begin
      lSaveRect := PrintPosRect;
      CurrentColumn := CurrentColumn + 1;
      lbNextColumnValid := SetColumnPosition;
      CurrentColumn := CurrentColumn - 1;
      SetPrintPosition(lSaveRect.Left, lSaveRect.Top, lSaveRect.Right, lSaveRect.Bottom);
    end;

  {save engine state to cache}
  if (CurrentColumn = Report.Columns) or
     ((AllDataTraversed) and (FBandListIndex > cGroupFooterBands)) or
     not(lbNextColumnValid) or lbStartNewPage or (esStartSection in State) then
    SaveEngineState;

  {put record on correct position for printing column footers}
  if CalcsOutOfSync then
    begin
      PriorRecord;

      if (lbNextColumnValid) then
        AdvanceRecord := True
      else
        AdvanceRecord := False;
    end;

  {generate column footer bands}
  if not(((esPrintingTitle in State) or (esPrintingSummary in State)) and (TppBandedReport(Report).Detail.Count = 0)) then
    begin
      PCInclude([pppcEndOfColumn]);

      GenerateBands(FColumnFooterBands, 0, False);

      {trigger event, after column footers generate}
      Report.DoOnEndColumn;

      {generate column footer bands}
      PCExclude([pppcEndOfColumn]);
    end;

  {if this is the last column, finish the page}
  if (CurrentColumn = Report.Columns) or
     ((AllDataTraversed) and (FBandListIndex > cGroupFooterBands)) or
     not(lbNextColumnValid) or lbStartNewPage or (esStartSection in State) then
    begin
      {set print position back to far left}
      SetPrintPosition(Page.PageDef.mmMarginLeft, PrintPosRect.Top, Page.PageDef.mmPrintableWidth, PrintPosRect.Bottom);

      FinishPage;
    end;

end; {procedure, FinishColumn}

{------------------------------------------------------------------------------}
{ TppEngine.SetColumnPosition }

function TppEngine.SetColumnPosition: Boolean;
var
  lrColumnPos: Single;
  liColumnPositions: Integer;
  llColumnWidth: Longint;
  llNewLeft: Longint;
  lsMessage: String;
  lbValidPosition: Boolean;
  llRightBoundary: Longint;
begin

  {calculate starting left position for column}
  llNewLeft := 0;

  llColumnWidth := Report.mmColumnWidth;

  liColumnPositions := Report.ColumnPositions.Count;

  if (liColumnPositions > 0) then
    begin

      if (CurrentColumn <= liColumnPositions) then

        try
          lrColumnPos := StrToFloat(Report.ColumnPositions[CurrentColumn - 1]);
          llNewLeft := ppToMMThousandths(lrColumnPos, Report.Units, pprtHorizontal, Report.Printer);
        except on EConvertError do
          begin
            lsMessage := ppLoadStrWithParms(42, [IntToStr(CurrentColumn)]);

            Report.RaiseException(EPrintError.Create(lsMessage + '.'));
          end;
        end {try, except}

      else
        begin
          lsMessage := ppLoadStrWithParms(43, [IntToStr(CurrentColumn)]);

          Report.RaiseException(EPrintError.Create(lsMessage + '.'));
        end;

    end {if, user has specified column positions}

  else
    llNewLeft := Page.PageDef.mmMarginLeft + (llColumnWidth * (CurrentColumn - 1));


  {set new column position}
  llRightBoundary := Page.PageDef.mmWidth - Page.PageDef.mmMarginRight;

  if (Report.ColumnPositions.Count > 0) and (llNewLeft > llRightBoundary) then
    lbValidPosition := False

  else if (Report.ColumnPositions.Count = 0) and
          ((llNewLeft + llColumnWidth) > (llRightBoundary)) then
    lbValidPosition := False

  else
    lbValidPosition := True;


  if lbValidPosition then
    SetPrintPosition(llNewLeft, FColumnStartPosition, llRightBoundary, FColumnStartPosition);


  Result := lbValidPosition;

end; {function, SetColumnPosition}

{------------------------------------------------------------------------------}
{ TppEngine.CheckGroups }

procedure TppEngine.CheckGroups(aDataPipeline: TppDataPipeline);
var
  liGroup: Integer;
  liGroups: Integer;
  lGroup: TppGroup;
  lbGroupBreak: Boolean;
begin

  if not(CheckForGroupBreaks) then  Exit;

  {check for group breaks from highest to lowest}
  liGroups := Report.GroupCount;

  for liGroup := (liGroups - 1) downto 0 do
    begin
      lGroup := Report.Groups[liGroup];

      if (aDataPipeline <> nil) and (lGroup.DataPipeline = aDataPipeline) and aDataPipeline.EOF then
        lbGroupBreak := True
      else
        begin
          lGroup.CheckForBreak;

          lbGroupBreak := lGroup.Breaking;
        end;

      if (lbGroupBreak) and (liGroup < FMinGroupNo) then
        FMinGroupNo := liGroup;

    end; {for, each group}

end; {procedure, CheckGroups}

{------------------------------------------------------------------------------}
{ TppEngine.ForceGroupBreaks }

procedure TppEngine.ForceGroupBreaks;
var
  liGroup: Integer;
  liGroups: Integer;
  lbNewPageFound: Boolean;
begin

  if not(CheckForGroupBreaks) then Exit;

  lbNewPageFound := False;

  liGroups := Report.GroupCount;

  for liGroup := FMinGroupNo to liGroups - 1 do
    begin
      Report.Groups[liGroup].ForceBreak;

      if Report.Groups[liGroup].NewPage and not(lbNewPageFound) then
        lbNewPageFound := True

      else if lbNewPageFound and (liGroup <> FMinGroupNo) then
        TppGroupHeaderBand(Report.Groups[liGroup].HeaderBand).AlreadyPageBreak := True;

    end;

end; {procedure, ForceGroupBreaks}

{------------------------------------------------------------------------------}
{ TppEngine.InitDrawPage }

procedure TppEngine.InitDrawPage;
var
  lMainReport: TppReport;
begin

  lMainReport := TppReport(Report.MainReport);

  {determine whether pages should be generated}
  if (esFirstPass in State) and (lMainReport.PassSetting = psOnePass) then
    DrawPage := True

  else if (esSecondPass in State) and (lMainReport.PassSetting = psTwoPass) then
    DrawPage := True

  else if (esFirstPass in State) and (lMainReport.PassSetting = psTwoPass) then
    DrawPage := (AbsolutePageNo = FPageRequest.PageRequested)

  else
    DrawPage := False;


  if DrawPage and lMainReport.Publisher.CachePages then Exit;
  
  case FPageRequest.PageSetting of
    psSinglePage:
      DrawPage := (AbsolutePageNo = FPageRequest.PageRequested);

    psFirstPage:
      DrawPage := (AbsolutePageNo = 1);

    psLastPage:
      DrawPage := FirstPassCompleted and (AbsolutePageNo = AbsolutePageCount);

    psPageList:
      DrawPage := (AbsolutePageNo = FPageRequest.PageRequested);

  end; {case, page settting type}


end; {procedure, InitDrawPage}

{------------------------------------------------------------------------------}
{ TppEngine.ResetFromPageNo }

procedure TppEngine.ResetFromPageNo(aAbsolutePageNo: Longint);
begin

  if (aAbsolutePageNo = 0) then
    begin
      AbsolutePageNo := 0;
      AbsolutePageCount := 0;

      State := [];

      PrintCondition := [];
    end
  else
    AbsolutePageCount := aAbsolutePageNo;

  Page.FreeDrawCommands;

  FirstPassCompleted := False;
  FFirstPassCompleted2 := False;
  FSecondPassStarted := False;

end; {procedure, ResetFromPageNo}

{------------------------------------------------------------------------------}
{ TppEngine.Init }

procedure TppEngine.Init;
begin

  if (esInitialized in State) then
    begin
      // need to make sure the datapipeline is still empty
      if not(DataFound) and (FMasterDatapipeline <> nil) then
        FMasterDatapipeline.UpdateState;
      
      if not(DataFound) then
        DoOnNoData;

      Exit;
    end;

  {must fire before opening pipes - 5.01}
  if not(PrintingSubReport) and not(FMainReportStarted) then
    begin
      SendEventNotify(Self, ciReportBeforeOpenDataPipelines, nil);
      Report.TriggerCodeModuleBeforePrint;
    end;

  {open the data pipelines, must do this before calling subreports - 4.23}
  OpenDataPipelines;

  if StopPrinting and (FMasterDatapipeline <> nil) then
    FMasterDatapipeline.State := [ppdaNoRecords];

  {notify all objects in report that report has started}
  if not(PrintingSubReport) and not(FMainReportStarted) then
    begin
      // StartOfMainReport notifies all subreports to call init and open their datapipelines
      Report.StartOfMainReport;
      FMainReportStarted := True;
      // all datapipelines are now open
      SendEventNotify(Self, ciReportAfterOpenDataPipelines, nil);
    end;

  {notify any subreports, one level down}
  Report.StartOfParentReport;

  {indicate that engine has been run}
  PrintCondition := [];
  State := [];

  {clear cache}
  DoOnResetCache;

  {note: call to ResetCache above will cause bookmarks to be free'd.
         the code below is required to due to this timing issue }
  FCurrentBookmark := FNewCurrentBookmark;
  FNewCurrentBookmark := 0;

  {reset first pass complete indicator}
  FFirstPassStarted := False;
  FirstPassCompleted := False;
  FFirstPassCompleted2 := False;
  FSecondPassStarted := False;

  {must do this here, in case engine exits due to no data}
  SpaceUsed := 0;

  {init data traversal vars}
  AllDataTraversed := False;
  FTraversedDetail := False;
  FTraversedMaster := False;
  AdvanceRecord := False;
  CalcsOutOfSync := False;

  FAllColumnsStarted := False;

  {indicate whether this is a master/detail report}
  FMasterDetailReport := (FMasterDataPipeline <> nil) and (FDetailDataPipeline <> nil);

  FNoDataDialog := nil;
  FNoDataDrawText := nil;

  if not(DataFound) then
    DoOnNoData;

  {default so first call to ComputeCalcs actually works}
  CalcsOutOfSync := True;
  FTraversedMaster := (FMasterDataPipeline <> nil);
  FTraversedDetail := (FDetailDataPipeline <> nil);

  {must do this after opening the data pipelines and before CategorizeBands}
  PageStarted := False;

  InitGroups;

  {categorize bands by print condition}
  CategorizeBands;

  {all bands to build object lists}
  InitBands;

  {force group headers to print at beginning of report}
  PCInclude([pppcStartOfGroup]);

  {save time report printing was started, used by TppCalc's ctPrintDateTime}
  if not(PrintingSubReport) then
    PrintDateTime := Now
  else
    PrintDateTime := Report.MainReport.PrintDateTime;

  {indicate that engine has been initialized}
  ESInclude([esInitialized, esFirstPass]);

  {init band counters}
  ReportBandCount := 0;
  PageBandCount := 0;

  {init page counters}
  AbsolutePageNo := 0;
  AbsolutePageCount := 0;

  {indicate whether this is a columnar report}
  FColumnarReport := (Report.Columns > 1) and (TppBandedReport(Report).Detail.ColumnTraversal = ctTopToBottom);

  {force title band to print at beginning of report}
  PCInclude([pppcStartOfReport]);

  {write nil info into first cache position, do this after all other initiallization}
  FBandListIndex := cReportHeaderBands;
  FBandIndex := 0;

  SaveEngineState;

  FLastPageGenerated := 0;

  BeforePass;

  if (TppBandedReport(Report).Detail.ColumnTraversal = ctLeftToRight) then
    begin
      if (FColumnStarted = nil) then
        FColumnStarted := TList.Create
      else
        FColumnStarted.Clear;

      FColumnStarted.Count := Report.Columns;

      if (FColumnFinished = nil) then
        FColumnFinished := TList.Create
      else
        FColumnFinished.Clear;

      FColumnFinished.Count := Report.Columns;
    end;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppEngine.CreateNoDataMessage }

procedure TppEngine.CreateNoDataMessage;
var
  lbShowDialog: Boolean;
  lbAddTextToPage: Boolean;
begin

  if (FNoDataDrawText <> nil) then
    begin
      FNoDataDrawText.Free;
      FNoDataDrawText := nil;
    end;

  if not(DataFound) then
    begin

      if (ndBlankReport in Report.NoDataBehaviors) then
        begin

          if (ndMessageOnPage in Report.NoDataBehaviors) then
            begin
              lbAddTextToPage := True;
              FNoDataDrawText := CreateNoDataDrawText;
            end
          else
            lbAddTextToPage := False;                             

          if (ndMessageDialog in Report.NoDataBehaviors) then
            begin
              if not(FSecondPassStarted) then
                lbShowDialog := True
              else
                lbShowDialog := False;

              FNoDataDialog := CreateNoDataDialog;
            end
          else
            lbShowDialog := False;

          Report.DoOnNoData(FNoDataDialog, lbShowDialog, FNoDataDrawText, lbAddTextToPage);

          if (FNoDataDialog <> nil) then
            begin
              if (lbShowDialog) then
                FNoDataDialog.ShowModal;

              FNoDataDialog.Free;
              FNoDataDialog := nil;
            end;

          if (FNoDataDrawText <> nil) then
            begin
              if not(lbAddTextToPage) then
                begin
                  FNoDataDrawText.Free;
                  FNoDataDrawText := nil;
                end;
            end;

        end;

    end;

end; {procedure, CreateNoDataMessage}

{------------------------------------------------------------------------------}
{ TppEngine.DataFound }

function TppEngine.DataFound: Boolean;
begin

  if StopPrinting then
    Result := False
  else
    begin
      Result := True;

      {if master contains no data,
         due to timing, need to check BOF, EOF rather than ppdaNoRecords}
      if (FMasterDataPipeline <> nil) and ((ppdaNoRecords in FMasterDataPipeline.State) or (FMasterDataPipeline.BOF and FMasterDataPipeline.EOF)) then
        Result := False;
    end;

end; {function, DataFound}
 
{------------------------------------------------------------------------------}
{ TppEngine.DoOnNoData }

procedure TppEngine.DoOnNoData;
var
  lbShowDialog: Boolean;
  lbAddTextToPage: Boolean;
begin

  if (ndBlankPage in Report.NoDataBehaviors) then
    begin
      GenerateCompleted := True;
      LastBandGenerated := True;
      FMainReportStarted := False;


      if (ndMessageDialog in Report.NoDataBehaviors) then
        FNoDataDialog := CreateNoDataDialog;

      lbAddTextToPage := False;

      if not(FSecondPassStarted) then
        lbShowDialog := True
      else
        lbShowDialog := False;

      Report.DoOnNoData(FNoDataDialog, lbShowDialog, nil, lbAddTextToPage);

      if (FNoDataDialog <> nil) then
        begin
          if (lbShowDialog) then
            FNoDataDialog.ShowModal;

          FNoDataDialog.Free;
          FNoDataDialog := nil;
        end;

      if (Report.PassSetting = psTwoPass) then
        FSecondPassStarted := True;

    end;

end; {function, DoOnNoData}

{------------------------------------------------------------------------------}
{ TppEngine.CreateNoDataDialog }

function TppEngine.CreateNoDataDialog: TppCustomNoDataDialog;
var
  lFormClass: TFormClass;
  lDialog: TppCustomNoDataDialog;
begin

  lFormClass := ppGetFormClass(TppCustomNoDataDialog);

  lDialog := TppCustomNoDataDialog(lFormClass.Create(Application));
  lDialog.Report := Report;
  lDialog.LanguageIndex := Report.LanguageIndex;

  if not(Report.Icon.Empty) then
    lDialog.Icon := Report.Icon;

  Result := lDialog;

end; {function, CreateNoDataDialog}

{------------------------------------------------------------------------------}
{ TppEngine.CreateNoDataDrawText }

function TppEngine.CreateNoDataDrawText: TppDrawText;
var
  liTextHeight: Integer;
  liTextWidth: Integer;
  liPageWidth: Integer;
  lDrawText: TppDrawText;
begin

  lDrawText := TppDrawText.Create(Page);

  lDrawText.Autosize := True;
  lDrawText.Font.Name := 'Arial';
  lDrawText.Font.Size := 12;
  lDrawText.Font.Color := clBlack;
  lDrawText.IsMemo := False;
  lDrawText.Text := ppLoadStr(1034); {'No Data Found.'}
  lDrawText.Transparent := True;
  lDrawText.WordWrap := False;

  liTextWidth := 110;
  liTextHeight := 18;

  lDrawText.Height := ppToMMThousandths(liTextHeight, utScreenPixels, pprtVertical, nil);
  lDrawText.Width := ppToMMThousandths(liTextWidth, utScreenPixels, pprtHorizontal, nil);

  liPageWidth := Page.PageDef.mmPrintableWidth;

  lDrawText.Left := (liPageWidth -  lDrawText.Width ) div 2;
  lDrawText.Top  := (SpaceUsed - lDrawText.Height) div 2;


  Result := lDrawText;

end; {function, CreateNoDataDrawText}

{------------------------------------------------------------------------------}
{ TppEngine.InitGroups }

procedure TppEngine.InitGroups;

var
  liGroup: Integer;
  liGroups: Integer;
  lGroup: TppGroup;
  liInnerMostNewPage: Integer;
begin

  ControlGroup := nil;
  ControlKeepTogether := nil;

  liGroups := Report.GroupCount - 1;

  if (liGroups = -1) then Exit;

  {init groups & group bands}
  for liGroup := 0 to liGroups do
    begin
      lGroup := Report.Groups[liGroup];

      lGroup.Init;

      if (ControlGroup = nil) and lGroup.NewPage and lGroup.ResetPageNo then
        ControlGroup := lGroup;
    end;

  liInnerMostNewPage := -1;  {4.06}
  
  for liGroup := liGroups downto 0 do
    begin
      lGroup := Report.Groups[liGroup];

      if (lGroup.NewPage) and (lGroup.Index > liInnerMostNewPage) then
        liInnerMostNewPage := lGroup.Index;

      {set the controlling keep together group}
      if (ControlKeepTogether = nil) and lGroup.KeepTogether and not(lGroup.NewPage) then
        ControlKeepTogether := lGroup;
    end;

  {new page group inside a keep together invalidates the keep together}
  if (ControlKeepTogether <> nil) and (ControlKeepTogether.Index < liInnerMostNewPage) then
    ControlKeepTogether := nil;

end; {procedure, InitGroups}

{------------------------------------------------------------------------------}
{ TppEngine.InitBands }

procedure TppEngine.InitBands;
var
  liBand: Integer;
begin

  {init bands}
  for liBand := 0 to (Report.BandCount - 1) do
    Report.Bands[liBand].Init;

end; {procedure, InitBands}

{------------------------------------------------------------------------------}
{ TppEngine.ComputeCalcs }

procedure TppEngine.ComputeCalcs;
begin

  {trigger traversal events}
  if FTraversedMaster then
    FMasterDataPipeline.DoOnTraversal;

  if FTraversedDetail then
    FDetailDataPipeline.DoOnTraversal;

  {notify all components of traversal}
  SendEventNotify(Self, ciTraversal, nil);

end; {procedure, ComputeCalcs}

{------------------------------------------------------------------------------}
{ TppEngine.PageStart }

procedure TppEngine.PageStart;

var
  liBand: Integer;
begin

  for liBand := 0 to (Report.BandCount - 1) do
    Report.Bands[liBand].PageStart;

end; {procedure, PageStart}

{------------------------------------------------------------------------------}
{ TppEngine.CategorizeBands }

procedure TppEngine.CategorizeBands;
var
  liBand: Integer;
  liBands: Integer;
  lBand: TppCustomBand;
  lPrintCondition: TppPrintConditions;
begin

 if (Report.BandCount = 0) then
    Report.CreateDefaultBands;

  {clear previous band lists}
  ClearBandLists;

  FMasterBandList.Clear;

  {load bands into string list}
  for liBand := 0 to (Report.BandCount - 1) do
    begin
      lBand := TppCustomBand(Report.Bands[liBand]);

      FMasterBandList.AddObject(lBand.Rank, lBand);
    end;

  {put bands in print order}
  FMasterBandList.Sort;

  liBands := FMasterBandList.Count;

  {load bands into page lists, based on sorted order}
  for liBand := 0 to  liBands - 1 do
    begin
      lBand := TppCustomBand(FMasterBandList.Objects[liBand]);

      lPrintCondition := lBand.PrintCondition;

      if (pppcStartOfReport in lPrintCondition) then
        FReportHeaderBands.Add(lBand)

      else if (pppcStartOfGroup in lPrintCondition) then
        FGroupHeaderBands.Add(lBand)

      else if (pppcStartOfPage in lPrintCondition) and (lBand is TppPageStyle) then
        FPageStyleBands.Add(lBand)

      else if (pppcStartOfPage in lPrintCondition) and (lBand is TppPageBand) then
        FPageHeaderBands.Add(lBand)

      else if (pppcStartOfColumn in lPrintCondition) then
        FColumnHeaderBands.Add(lBand)

      else if (pppcOnTraversal in lPrintCondition) then
        FDetailBands.Add(lBand)

      else if (pppcEndOfGroup in lPrintCondition) then
        FGroupFooterBands.Add(lBand)

      else if (pppcEndOfColumn in lPrintCondition) then
        FColumnFooterBands.Add(lBand)

      else if (pppcEndOfPage in lPrintCondition) then
        FPageFooterBands.Add(lBand)

      else if (pppcEndOfReport in lPrintCondition) then
        FReportFooterBands.Add(lBand);

    end; {for, each band in sorted list}

  {determine last band of report}
  if (FReportFooterBands.Count > 0) then
    FLastBand := TppCustomBand(FReportFooterBands[FReportFooterBands.Count - 1])

  else if (FGroupFooterBands.Count > 0) then
    FLastBand := TppCustomBand(FGroupFooterBands[FGroupFooterBands.Count - 1])

  else if (FDetailBands.Count > 0) then
    FLastBand := TppCustomBand(FDetailBands[FDetailBands.Count - 1])

  else
    FLastBand := nil;

end; {procedure, CategorizeBands}

{------------------------------------------------------------------------------}
{ TppEngine.ClearBandLists }

procedure TppEngine.ClearBandLists;
begin

  FReportHeaderBands.Clear;
  FPageStyleBands.Clear;
  FPageHeaderBands.Clear;
  FColumnHeaderBands.Clear;
  FGroupHeaderBands.Clear;
  FDetailBands.Clear;
  FGroupFooterBands.Clear;
  FColumnFooterBands.Clear;
  FPageFooterBands.Clear;
  FReportFooterBands.Clear;

end; {procedure, ClearBandLists}

{------------------------------------------------------------------------------}
{ TppEngine.GetCurrentBand }

function  TppEngine.GetCurrentBand: TppBand;
begin
  Result := FCurrentBand;
end; {function, GetCurrentBand}

{------------------------------------------------------------------------------}
{ TppEngine.GetCurrentBandListIndex }

function  TppEngine.GetCurrentBandListIndex: Integer;
begin
  Result := FBandListIndex;
end; {function, GetCurrentBandListIndex}

{------------------------------------------------------------------------------}
{ TppEngine.GetPageStarted }

function TppEngine.GetPageStarted: Boolean;
begin

  Result := inherited GetPageStarted;

  {if not page started, check to see if parent has page started}
  if not(Result) and (Report.ParentReport <> nil) then
    Result := Report.ParentReport.Engine.PageStarted;

end; {function, GetPageStarted}

{------------------------------------------------------------------------------}
{ TppEngine.SetPageStarted }

procedure TppEngine.SetPageStarted(aValue: Boolean);
var
  liBandListIndex: Integer;
  lCurrentBand: TppBand;
begin

  inherited SetPageStarted(aValue);

  {if page started, make sure parent report knows about it}
  if (aValue) and (Report.ParentReport <> nil) then
    begin
      liBandListIndex := Report.ParentReport.Engine.CurrentBandListIndex;
      lCurrentBand := Report.ParentReport.Engine.CurrentBand;

      if not(liBandListIndex = cReportHeaderBands) and
         not(liBandListIndex = cPageHeaderBands) and
         not(liBandListIndex = cColumnHeaderBands) and
         not((liBandListIndex = cGroupHeaderBands) and
             (lCurrentBand is TppGroupBand) and (TppGroupBand(lCurrentBand).Group.ReprintOnSubsequentPage)) then
        Report.ParentReport.Engine.SetPageStarted(aValue);
    end;

end; {procedure, SetPageStarted}

{------------------------------------------------------------------------------}
{ TppEngine.GetPageNo }

function TppEngine.GetPageNo: Longint;
var
  lTitleBand: TppBand;
begin

  {if title band is cover page, then page numbering cannot be controlled by group}
  lTitleBand := Report.GetBand(btTitle, 0);

  if (Report.AbsolutePageNo = 1) and (lTitleBand <> nil) and (TppTitleBand(lTitleBand).NewPage) then
    Result := inherited GetPageNo

  {if group is controlling page numbers, get page number from group}
  else if Printing and (ControlGroup <> nil) then
    Result := ControlGroup.PageNo

  else
    Result := inherited GetPageNo;

end; {function, GetPageNo}

{------------------------------------------------------------------------------}
{ TppEngine.GetPageCount }

function TppEngine.GetPageCount: Longint;
var
  lTitleBand: TppBand;
begin

  {if title band is cover page, then page numbering cannot be controlled by group}
  lTitleBand := Report.GetBand(btTitle, 0);

  if (Report.AbsolutePageNo = 1) and (lTitleBand <> nil) and (TppTitleBand(lTitleBand).NewPage) then
    begin
      if (ControlGroup <> nil) then
        Result := inherited GetPageNo
      else
        Result := inherited GetPageCount;
    end

  {if group is controlling page numbers, get page count from group}
  else if Printing and (ControlGroup <> nil) then
    Result := ControlGroup.PageCount

  else
    Result := inherited GetPageCount;

end; {function, GetPageCount}

{------------------------------------------------------------------------------}
{ TppEngine.GetPageBottom }

function TppEngine.GetPageBottom: Longint;
var
  liBand: Integer;
  lColumnFooterBand: TppColumnFooterBand;
  lFooterBand: TppFooterBand;
begin

  if (Report = nil) then
    raise EPrintError.Create('TppEngine.GetPageBottom: No Report assigned to this engine.');

  Result := Page.PageDef.mmHeight;

  {reduce for bottom margin}
  Result := Result - Page.PageDef.mmMarginBottom;

  {reduce for column footer height}
  for liBand := 0 to FColumnFooterBands.Count - 1 do
    begin
      lColumnFooterBand := TppColumnFooterBand(FColumnFooterBands[liBand]);

      if (lColumnFooterBand.Visible) then
        Result := Result - lColumnFooterBand.mmHeight;
    end;

  {reduce for page footer height}
  for liBand := 0 to FPageFooterBands.Count - 1 do
    begin
      lFooterBand := TppFooterBand(FPageFooterBands[liBand]);

      if not(lFooterBand.PrintOnLastPage) and (esPrintingSummary in Report.Engine.State) then
        // do not adjust for footer band height
      else if (lFooterBand.Visible) then
        Result := Result - lFooterBand.mmHeight;
    end;

end; {function, GetPageBottom}

{------------------------------------------------------------------------------}
{ TppEngine.TraverseData }

procedure TppEngine.TraverseData;
begin

  CheckForGroupBreaks := True;

  {update states}
  if (pppcStartOfReport in PrintCondition) then
    GenerateStarted := True;

  PCExclude([pppcStartOfPage, pppcStartOfColumn, pppcStartOfGroup]);

  {set print condition to traversal only, do this before checking AllDataTraversed}
  PCInclude([pppcOnTraversal]);

  {check this separately from MasterPipeline, in case DonePrinting has set the value}
  if (AllDataTraversed) then Exit;

  {move to next record}
  NextRecord;

  {4.06, modified to call PriorRecord only when not EOF}

  {set indicator here}
  if ((FMasterDataPipeline <> nil) and (FMasterDataPipeline.EOF)) then
    begin
      AllDataTraversed := True;

      PCInclude([pppcEndOfReport, pppcEndOfGroup]);

      {if (FMasterDetailReport) then} {4.21, always goto last record after EOF}

      TraverseMaster(pptdBackward);
    end

  {we've got a group break, so step one record back}
  else if (pppcEndOfGroup in PrintCondition) then
    PriorRecord
    
  else
    CalcsOutOfSync := True;

end; {procedure, TraverseData}

{------------------------------------------------------------------------------}
{ TppEngine.SyncData }

procedure TppEngine.SyncData;
var
  liGroup: Integer;
begin

  if not(AdvanceRecord) and not(CalcsOutOfSync) then Exit;

  CheckForGroupBreaks := False;

  {we're about to print group headers, so step forward}
  if AdvanceRecord then
    begin
      AdvanceRecord := False;
      CalcsOutOfSync := False;

      {move to next record}
      NextRecord;

      {compute value of calc components}
      ComputeCalcs;

      {indicate group footers have completed}
      if not(pppcEndOfReport in PrintCondition) then
        PCExclude([pppcEndofGroup]);

      {set print condition for group header and detail band printing}
      PCInclude([pppcStartOfGroup, pppcOnTraversal]);
    end

  else if CalcsOutOfSync then
    begin
      CalcsOutOfSync := False;

      {compute value of calc components}
      ComputeCalcs;
    end;

  {refresh group values, must do this after start page}
  for liGroup := 0 to Report.GroupCount - 1 do
    Report.Groups[liGroup].RefreshBreakValues;

end; {procedure, SyncData}

{------------------------------------------------------------------------------}
{ TppEngine.NextRecord }

procedure TppEngine.NextRecord;
begin

  {track minimum breaking group no}
  FMinGroupNo := Report.GroupCount;

  if not(FMasterDetailReport) then
    begin
      TraverseMaster(pptdForward);

      CheckGroups(FMasterDataPipeline);
    end

  else
    NextMDRecord;

  {force group breaks}
  if (FMinGroupNo <> Report.GroupCount) then
    begin
      ForceGroupBreaks;

      PCInclude([pppcStartOfGroup, pppcEndOfGroup]);
    end;

end; {procedure, NextRecord}

{------------------------------------------------------------------------------}
{ TppEngine.NextMDRecord }

procedure TppEngine.NextMDRecord;
var
  lbTraverseMaster: Boolean;
  lbTraverseDetail: Boolean;
begin

  {determine which DataPipelines should be traversed}
  lbTraverseMaster := (FMasterDataPipeline <> nil) and
                       not(ppdaNoRecords in FMasterDataPipeline.State) and
                       not(ppdaLastRecord in FMasterDataPipeline.State);

  lbTraverseDetail := (FDetailDataPipeline <> nil) and
                       not(ppdaNoRecords in FDetailDataPipeline.State) and
                       not(ppdaLastRecord in FDetailDataPipeline.State);

  {traverse record}
  if (lbTraverseDetail) then
    begin
      FDetailDataPipeline.Next;

      FTraversedDetail := True;
      FTraversedMaster := False;

      {allow detail pipeline groups to break}
      CheckGroups(FDetailDataPipeline);

      {allow master pipeline groups to break}
      if FDetailDataPipeline.EOF then
        begin
          FTraversedDetail := False;

          TraverseMaster(pptdForward);

          FDetailDataPipeline.First;

          CheckGroups(FMasterDataPipeline);
        end;

    end

  else if (lbTraverseMaster) then
    begin
      TraverseMaster(pptdForward);

      FDetailDataPipeline.First;

      CheckGroups(FMasterDataPipeline);
    end;

end; {procedure, NextMDRecord}

{------------------------------------------------------------------------------}
{ TppEngine.PriorRecord }

procedure TppEngine.PriorRecord;
begin

  if not(FMasterDetailReport) then
    TraverseMaster(pptdBackward)

  else
    PriorMDRecord;

end; {procedure, PriorRecord}

{------------------------------------------------------------------------------}
{ TppEngine.PriorMDRecord }

procedure TppEngine.PriorMDRecord;
var
  lbTraverseMaster: Boolean;
  lbTraverseDetail: Boolean;
begin
  {determine which DataPipelines should be traversed}
  lbTraverseMaster := (FMasterDataPipeline <> nil) and
                      not(ppdaFirstRecord in FMasterDataPipeline.State) and
                      not(ppdaNoRecords in FMasterDataPipeline.State);

  lbTraverseDetail := (FDetailDataPipeline <> nil) and
                      not(ppdaFirstRecord in FDetailDataPipeline.State) and
                      not(ppdaNoRecords in FDetailDataPipeline.State);

  {traverse record}
  if (lbTraverseDetail) then
    begin
      if FDetailDataPipeline.EOF then
        FDetailDataPipeline.Last
      else
        FDetailDataPipeline.Prior;
    end

  else if lbTraverseMaster then
    begin
      TraverseMaster(pptdBackward);

      FDetailDataPipeline.Last;
    end;

end; {procedure, PriorMDRecord

{------------------------------------------------------------------------------}
{ TppEngine.TraverseMaster }

procedure TppEngine.TraverseMaster(aDirection: TppTraversalDirectionType);
begin

  if (FMasterDataPipeline = nil) then Exit;

  case aDirection of

    pptdForward:
      begin
        FMasterDataPipeline.Next;

        FTraversedMaster := True;
        FTraversedDetail := (FDetailDataPipeline <> nil);
      end;

    pptdBackward:
      begin
        if FMasterDataPipeline.EOF then
          FMasterDataPipeline.Last
        else
          FMasterDataPipeline.Prior;
      end;

    end; {case, traversal direction}

end; {procedure, TraverseMaster}

{------------------------------------------------------------------------------}
{ TppEngine.OpenDataPipelines  }

procedure TppEngine.OpenDataPipelines;
var
  lDetailBand: TppDetailBand;
begin

  // clear exsiting datapipeline references/relationships
  ClearDataPipelines;

  {must reset this, otherwise RestorePage could destroy the initialization}
  FDataPipelineStatesRead := False;

  FMasterDataPipeline := Report.DataPipeline;

  if (FMasterDataPipeline <> nil) then
    begin
      FMasterDataPipeline.AddEventNotify(Self);

      OpenDataPipeline(FMasterDataPipeline);

      {save currently allocated bookmark to FNewCurrentBookmark,
       it will subsequently be transferred to FCurrentBookmark in the
       Init method}
      if not PrintingSubReport then
        begin
          FNewCurrentBookmark := FMasterDataPipeline.GetBookmark;

          FMasterDataPipeline.CurrentBookmark := FNewCurrentBookmark;
        end
      else
        FNewCurrentBookmark := 0;

      FMasterDataPipeline.First;

      FTraversedMaster := True;

      {get detailband}
      lDetailBand := TppDetailBand(Report.GetBand(btDetail, 0));

      if (lDetailBand <> nil) and (lDetailBand.DataPipeline <> FMasterDataPipeline) then
        FDetailDataPipeline := lDetailBand.DataPipeline
      else
        FDetailDataPipeline := nil;

      if (FDetailDataPipeline <> nil) then
        begin
          FDetailDataPipeline.AddEventNotify(Self);

          OpenDataPipeline(FDetailDataPipeline);

          FDetailDataPipeline.First;

          FTraversedDetail := True;
        end; {if, detail data pipeline}

    end; {if, master data pipeline}

  if not(DataFound) then
    ESInclude([esNoData])

  else if (esNoData in State) then
    ESExclude([esNoData]);

  OpenLookupDataPipelines;


end; {procedure, OpenDataPipelines}

{------------------------------------------------------------------------------}
{ TppEngine.OpenLookupDataPipelines }

procedure TppEngine.OpenLookupDataPipelines;
var
  liBand: Integer;
  lBand: TppCustomBand;
  lComponent: TppComponent;
  liComponent: Integer;
  lDataPipeline: TppDataPipeline;
begin

  for liBand := 0 to Report.BandCount - 1 do
    begin
      lBand := TppCustomBand(Report.Bands[liBand]);

      for liComponent := 0 to lBand.ObjectCount - 1 do
        begin
          lComponent := TppComponent(lBand.Objects[liComponent]);
          lDataPipeline := lComponent.DataPipeline;

          if lComponent.IsDataAware and (lDataPipeline <> nil) and
            (lDataPipeline <> FMasterDataPipeline) and (lDataPipeline <> FDetailDataPipeline) then
            lComponent.LookupPipeline := True
          else
            lComponent.LookupPipeline := False;

          if lComponent.LookupPipeline and (FLookupDataPipelines.IndexOf(lDataPipeline) = -1) then
            begin
              OpenDataPipeline(lDataPipeline);

              lDataPipeline.AddNotify(Self);

              FLookupDataPipelines.Add(lDataPipeline);
            end; {if, DataPipeline not in list}

        end; {for, each component}

    end; {for, each band}

end; {procedure, OpenLookupDataPipelines}

{------------------------------------------------------------------------------}
{ TppEngine.OpenDataPipeline }

procedure TppEngine.OpenDataPipeline(aDataPipeline: TppDataPipeline);
begin

  try
    aDataPipeline.Open;
  except on E: EDataError do
    Report.RaiseException(EPrintError.Create(aDataPipeline.UserName + ': '+ ppLoadStr(40) + #13#10 + #13#10 + E.Message));
  end;

  if not(aDataPipeline.Active) then
    Report.RaiseException(EPrintError.Create(aDataPipeline.UserName + ': '+ ppLoadStr(40)));

end; {procedure, OpenDataPipeline}

{------------------------------------------------------------------------------}
{ TppEngine.CloseDataPipelines }

procedure TppEngine.CloseDataPipelines;
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
begin

  if (FMasterDataPipeline <> nil) then
    begin
      FMasterDataPipeline.RemoveEventNotify(Self);
      FMasterDataPipeline.Close;
      FMasterDataPipeline := nil;
    end;

  if (FDetailDataPipeline <> nil) then
    begin
      FDetailDataPipeline.RemoveEventNotify(Self);
      FDetailDataPipeline.Close;
      FDetailDataPipeline := nil;
    end;

  for liIndex := (FLookupDataPipelines.Count - 1) downto 0 do
    begin
      lDataPipeline := TppDataPipeline(FLookupDataPipelines[liIndex]);

      lDataPipeline.RemoveNotify(Self);
      lDataPipeline.Close;

      FLookupDataPipelines.Delete(liIndex);
    end; 

end; {procedure, CloseDataPipelines}

{------------------------------------------------------------------------------}
{ TppEngine.ClearDataPipelines }

procedure TppEngine.ClearDataPipelines;
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
begin

  if (FMasterDataPipeline <> nil) then
    begin
      FMasterDataPipeline.RemoveEventNotify(Self);
      FMasterDataPipeline := nil;
    end;

  if (FDetailDataPipeline <> nil) then
    begin
      FDetailDataPipeline.RemoveEventNotify(Self);
      FDetailDataPipeline := nil;
    end;

  for liIndex := (FLookupDataPipelines.Count - 1) downto 0 do
    begin
      lDataPipeline := TppDataPipeline(FLookupDataPipelines[liIndex]);

      lDataPipeline.RemoveNotify(Self);

      FLookupDataPipelines.Delete(liIndex);
    end;

end; {procedure, ClearDataPipelines}

{------------------------------------------------------------------------------}
{ TppEngine.SaveToCache }

procedure TppEngine.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppEngineSaveRec;
  lDataPipelineSaveRec: TppDataPipelineSaveRec;
begin

  lRec.FAdvanceRecord      := AdvanceRecord;
  lRec.FAllColumnsStarted  := FAllColumnsStarted;
  lRec.FAllDataTraversed   := AllDataTraversed;
  lRec.FBandListIndex      := FBandListIndex;
  lRec.FBandIndex          := FBandIndex;
  lRec.FCalcsOutOfSync     := CalcsOutOfSync;
  lRec.FReportBandCount    := ReportBandCount;
  lRec.FTraversedMaster    := FTraversedMaster;
  lRec.FTraversedDetail    := FTraversedDetail;

  {save engine states}
  lRec.FNoData  := (esNoData in State);
  lRec.FInitialized  := (esInitialized in State);
  {lRec.FFirstPass  := (esFirstPass in State);}

  lRec.FPrintingSummary  := (esPrintingSummary in State);
  lRec.FPrintingTitle    := (esPrintingTitle in State);

  lRec.FStartSection     := (esStartSection in State);
  lRec.FGenerateSection  := (esGenerateSection in State);

  {save print conditions}
  lRec.FStartOfReport := (pppcStartOfReport in PrintCondition);
  lRec.FStartOfPage   := (pppcStartOfPage in PrintCondition);
  lRec.FStartOfColumn := (pppcStartOfColumn in PrintCondition);
  lRec.FStartOfGroup  := (pppcStartOfGroup in PrintCondition);
  lRec.FOnTraversal   := (pppcOnTraversal in PrintCondition);
  lRec.FEndOfGroup    := (pppcEndOfGroup in PrintCondition);
  lRec.FEndOfColumn   := (pppcEndOfColumn in PrintCondition);
  lRec.FEndOfPage     := (pppcEndOfPage in PrintCondition);
  lRec.FEndOfReport   := (pppcEndOfReport in PrintCondition);


  if FDataPipelineStatesSaved then
    begin
      lRec.FMasterNoRecords := FMasterDataPipelineState.FNoRecords;
      lRec.FMasterLastRecord := FMasterDataPipelineState.FLastRecord;
      lRec.FMasterFirstRecord := FMasterDataPipelineState.FFirstRecord;
      lRec.FMasterBookmarked := FMasterDataPipelineState.FBookmarked;
      lRec.FMasterBookmark := FMasterDataPipelineState.FBookmark;
      lRec.FMasterTraversalCount := FMasterDataPipelineState.FTraversalCount;
      lRec.FMasterRecordNo := FMasterDataPipelineState.FRecordNo;

      lRec.FDetailNoRecords := FDetailDataPipelineState.FNoRecords;
      lRec.FDetailLastRecord := FDetailDataPipelineState.FLastRecord;
      lRec.FDetailFirstRecord := FDetailDataPipelineState.FFirstRecord;
      lRec.FDetailBookmarked := FDetailDataPipelineState.FBookmarked;
      lRec.FDetailBookmark := FDetailDataPipelineState.FBookmark;
      lRec.FDetailTraversalCount := FDetailDataPipelineState.FTraversalCount;
      lRec.FDetailRecordNo := FDetailDataPipelineState.FRecordNo;

      FDataPipelineStatesSaved := False;
    end
  else
    begin
      DataPipelineStateToRec(FMasterDataPipeline, lDataPipelineSaveRec);

      lRec.FMasterNoRecords := lDataPipelineSaveRec.FNoRecords;
      lRec.FMasterLastRecord := lDataPipelineSaveRec.FLastRecord;
      lRec.FMasterFirstRecord := lDataPipelineSaveRec.FFirstRecord;
      lRec.FMasterBookmarked := lDataPipelineSaveRec.FBookmarked;
      lRec.FMasterBookmark := lDataPipelineSaveRec.FBookmark;
      lRec.FMasterTraversalCount := lDataPipelineSaveRec.FTraversalCount;
      lRec.FMasterRecordNo := lDataPipelineSaveRec.FRecordNo;

      DataPipelineStateToRec(FDetailDataPipeline, lDataPipelineSaveRec);

      lRec.FDetailNoRecords := lDataPipelineSaveRec.FNoRecords;
      lRec.FDetailLastRecord := lDataPipelineSaveRec.FLastRecord;
      lRec.FDetailFirstRecord := lDataPipelineSaveRec.FFirstRecord;
      lRec.FDetailBookmarked := lDataPipelineSaveRec.FBookmarked;
      lRec.FDetailBookmark := lDataPipelineSaveRec.FBookmark;
      lRec.FDetailTraversalCount := lDataPipelineSaveRec.FTraversalCount;
      lRec.FDetailRecordNo       := lDataPipelineSaveRec.FRecordNo;
    end;


  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppEngine.RestoreFromCache }

procedure TppEngine.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppEngineSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  {set current band}
  AdvanceRecord          := lRec.FAdvanceRecord;
  FAllColumnsStarted     := lRec.FAllColumnsStarted;
  AllDataTraversed       := lRec.FAllDataTraversed;
  FBandListIndex         := lRec.FBandListIndex;
  FBandIndex             := lRec.FBandIndex;
  CalcsOutOfSync         := lRec.FCalcsOutOfSync;
  ReportBandCount        := lRec.FReportBandCount;
  FTraversedMaster       := lRec.FTraversedMaster;
  FTraversedDetail       := lRec.FTraversedDetail;

  if lRec.FInitialized then ESInclude([esInitialized]) else ESExclude([esInitialized]);
  {if lRec.FFirstPass then ESInclude([esFirstPass]) else ESExclude([esFirstPass]);}
  if lRec.FNoData then ESInclude([esNoData]) else ESExclude([esNoData]);
  if lRec.FPrintingTitle then ESInclude([esPrintingTitle]) else ESExclude([esPrintingTitle]);
  if lRec.FPrintingSummary then ESInclude([esPrintingSummary]) else ESExclude([esPrintingSummary]);
  if lRec.FStartSection then ESInclude([esStartSection]) else ESExclude([esStartSection]);
  if lRec.FGenerateSection then ESInclude([esGenerateSection]) else ESExclude([esGenerateSection]);

  {restore print conditions}
  PrintCondition := [];

  if lRec.FStartOfReport then PCInclude([pppcStartOfReport]);
  if lRec.FStartOfPage   then PCInclude([pppcStartOfPage]);
  if lRec.FStartOfColumn then PCInclude([pppcStartOfColumn]);
  if lRec.FStartOfGroup  then PCInclude([pppcStartOfGroup]);
  if lRec.FOnTraversal   then PCInclude([pppcOnTraversal]);
  if lRec.FEndOfGroup    then PCInclude([pppcEndOfGroup]);
  if lRec.FEndOfColumn   then PCInclude([pppcEndOfColumn]);
  if lRec.FEndOfPage     then PCInclude([pppcEndOfPage]);
  if lRec.FEndOfReport   then PCInclude([pppcEndOfReport]);

  FreeUnusedBookmarks;

  FDataPipelineStatesRead := True;

  FMasterDataPipelineState.FNoRecords := lRec.FMasterNoRecords;
  FMasterDataPipelineState.FLastRecord := lRec.FMasterLastRecord;
  FMasterDataPipelineState.FFirstRecord := lRec.FMasterFirstRecord;
  FMasterDataPipelineState.FBookmarked := lRec.FMasterBookmarked;
  FMasterDataPipelineState.FBookmark := lRec.FMasterBookmark;
  FMasterDataPipelineState.FTraversalCount := lRec.FMasterTraversalCount;
  FMasterDataPipelineState.FRecordNo := lRec.FMasterRecordNo;

  FDetailDataPipelineState.FNoRecords := lRec.FDetailNoRecords;
  FDetailDataPipelineState.FLastRecord := lRec.FDetailLastRecord;
  FDetailDataPipelineState.FFirstRecord := lRec.FDetailFirstRecord;
  FDetailDataPipelineState.FBookmarked := lRec.FDetailBookmarked;
  FDetailDataPipelineState.FBookmark := lRec.FDetailBookmark;
  FDetailDataPipelineState.FTraversalCount := lRec.FDetailTraversalCount;
  FDetailDataPipelineState.FRecordNo := lRec.FDetailRecordNo;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppEngine.FreeCache }

procedure TppEngine.FreeCache(aCachePageNo: Integer);
begin
  FreeBookmarks(aCachePageNo);
end; {procedure, FreeCache}

{------------------------------------------------------------------------------}
{ TppEngine.DataPipelineStateToRec }

procedure TppEngine.DataPipelineStateToRec(aDataPipeline: TppDataPipeline; var aRec: TppDataPipelineSaveRec);
begin

  if (aDataPipeline = nil) then
    begin
      aRec.FNoRecords := False;
      aRec.FLastRecord := False;
      aRec.FFirstRecord := False;
      aRec.FTraversalCount := 0;
      aRec.FRecordNo := 0;
      aRec.FBookmarked := False;
      aRec.FBookmark := 0;
    end

  else
    begin
      {save record states}
      aRec.FNoRecords := (ppdaNoRecords in aDataPipeline.State);
      aRec.FLastRecord := (ppdaLastRecord in aDataPipeline.State);
      aRec.FFirstRecord := (ppdaFirstRecord in aDataPipeline.State);
      aRec.FTraversalCount := aDataPipeline.TraversalCount;

      if (ppdaLastRecord in aDataPipeline.State) then
        aRec.FRecordNo := aDataPipeline.RecordNo;

      {bookmark record position}
      if aDataPipeline.Active then
        begin
          aRec.FBookmarked := True;
          aRec.FBookmark := Longint(aDataPipeline.GetBookmark);
          aRec.FRecordNo := aDataPipeline.RecordNo;
        end
      else
        begin
          aRec.FBookmarked := False;
          aRec.FBookmark := 0;
        end;

    end;

end; {procedure, DataPipelineStateToRec}

{------------------------------------------------------------------------------}
{ TppEngine.DataPipelineRecToState }

procedure TppEngine.DataPipelineRecToState(var aRec: TppDataPipelineSaveRec; aDataPipeline: TppDataPipeline; aFreeBookmark: Boolean);
begin

  if (aDataPipeline = nil) then Exit;

  aDataPipeline.ExcludeState([ppdaNoRecords, ppdaLastRecord, ppdaFirstRecord]);

  if aRec.FNoRecords then aDataPipeline.IncludeState([ppdaNoRecords]);
  if aRec.FLastRecord then aDataPipeline.IncludeState([ppdaLastRecord]);
  if aRec.FFirstRecord then aDataPipeline.IncludeState([ppdaFirstRecord]);

  aDataPipeline.TraversalCount := aRec.FTraversalCount;

  {restore record position}
  if (ppdaFirstRecord in aDataPipeline.State) then
    aDataPipeline.First

  else if (ppdaLastRecord in aDataPipeline.State) then
    begin
      aDataPipeline.RecordNo := aRec.FRecordNo;
      aDataPipeline.Last;
    end

  else if aRec.FBookmarked and (aDataPipeline.Active) then
    begin
      aDataPipeline.RecordNo := aRec.FRecordNo;
      aDataPipeline.GotoBookmark(aRec.FBookmark);
    end;


  if aRec.FBookmarked and (aFreeBookmark) then
    begin
      aDataPipeline.FreeBookmark(aRec.FBookmark);
      aRec.FBookmarked := False;
    end;

end; {procedure, DataPipelineRecToState}

{------------------------------------------------------------------------------}
{ TppEngine.FreeBookmarks }

procedure TppEngine.FreeBookmarks(aStartPageNo: Integer);
var
  lRec: TppEngineSaveRec;
  llPage: Longint;
  lDetailBand: TppDetailBand;
  lMasterDataPipeline: TppDataPipeline;
  lDetailDataPipeline: TppDataPipeline;
begin

  FreeUnusedBookmarks;

  if (CacheStream = nil) then Exit;

  {get master data pipeline}
  lMasterDataPipeline := Report.DataPipeline;

  if (lMasterDataPipeline <> nil) and (FCurrentBookmark <> 0) then
    begin
      lMasterDataPipeline.FreeBookmark(FCurrentBookmark);
      FCurrentBookmark := 0;
      lMasterDataPipeline.CurrentBookmark := 0;
    end;


  {get detail data pipeline}
  lDetailBand := TppDetailBand(Report.GetBand(btDetail, 0));

  if (lDetailBand <> nil) and (lDetailBand.DataPipeline <> lMasterDataPipeline) then
    lDetailDataPipeline := lDetailBand.DataPipeline
  else
    lDetailDataPipeline := nil;

  {free any bookmarks}
  llPage := aStartPageNo;

  while (llPage <= CachePageCount) do
    begin
      ReadRecordFromCache(llPage, lRec);

      try
        if lRec.FMasterBookmarked and (lMasterDataPipeline <> nil) then
          begin
            lMasterDataPipeline.FreeBookmark(lRec.FMasterBookmark);
            lRec.FMasterBookmarked := False;
          end;
      except
        on EInvalidPointer do
          begin
           {do nothing, it is just a bad bookmark}
          end;
        on EAccessViolation do
          begin
           {do nothing, it is just a bad bookmark}
          end;
      end;

      try
        if lRec.FDetailBookmarked and (lDetailDataPipeline <> nil) then
          begin
            lDetailDataPipeline.FreeBookmark(lRec.FDetailBookmark);
            lRec.FDetailBookmarked := False;
          end;
      except
        on EInvalidPointer do
          begin
           {do nothing, it is just a bad bookmark}
          end;
        on EAccessViolation do
          begin
           {do nothing, it is just a bad bookmark}
          end;
      end;

      Inc(llPage);
    end;

end; {procedure, FreeBookmarks}

{------------------------------------------------------------------------------}
{ TppEngine.GeneratingNewPage }

function TppEngine.GeneratingNewPage: Boolean;
begin

  if (Report = nil) or not(Printing) then
    Result := False
  else if not(TppReport(Report.MainReport).CachePages) then
    Result := True
  else
    Result := (AbsolutePageNo = LastPageCached + 1);

end; {function, GeneratingNewPage}



end.
