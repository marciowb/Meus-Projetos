{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchCustomEngine;

interface
                                                   
uses
  Classes, Graphics,
  ppComm, ppViewr, ppTypes, ppDevice, ppClass, ppRTTI, ppTextSearchSettings,
  ppTextSearchOccurrence, ppTextSearchDrawCommandHighlighter;

type

  {@TppTextSearchCustomEngine }

  TppTextSearchCustomEngine = class(TppCommunicator)
    private
      FCancelled: Boolean;
      FInternalAllPagesSearched: Boolean;
      FViewer: TppViewer;
      FOffScreenDevice: TppScreenDevice;
      FScreenDeviceActiveCount: Integer;
      FPublisher: TppPublisher;
      FHighlightDrawCommandList: TList;
      FStartingPageNo: Integer;
      FShowAll: Boolean;
      FCaseSensitive: Boolean;
      FSearchToLastPage: Boolean;
      FCurrentPage: TppPage;
      FHighestPageNoSearched: Integer;
      FScaleY: Double;
      FScaleX: Double;
      FSearchText: String;
      FCanvas: TCanvas;
      FTextSearchSettings: TppTextSearchSettings;
      FGotoPageNo: Integer;

      procedure AssignCanvasScale;
      function NavigateForward(const aSearchText: String; aStopOnFirstOccurrence: Boolean): Integer;
      procedure RequestPage(aPageNo: Integer);
      procedure StopInternalReportPrinting(aReport: TObject);

      function GetCaseSensitive: Boolean;
      function GetScreenDeviceActive: Boolean;
      function GetShowAll: Boolean;
      function GetWholeWord: Boolean;
      procedure SetScreenDeviceActive(aScreenDeviceActive: Boolean);
      procedure SetTextSearchSettings(aTextSearchSettings: TppTextSearchSettings);
      procedure SetViewer(aViewer: TppViewer);

    protected
      function GetAllPagesSearched: Boolean; virtual; abstract;
      function GetCurrentPageNo: Integer; virtual; abstract;
      function GetTotalFound: Integer; virtual; abstract;
      function GetCurrentSearchIndex: Integer; virtual; abstract;
      function GetFirstPageFound: Integer; virtual; abstract;

      {Events}
      procedure AfterCreateHighlight(aHighlighter: TppTextSearchDrawCommandHighlighter; aDrawCommmandHighlighted, aHighlightDrawCommand: TppDrawCommand); virtual;
      procedure BeforeCreateHighlight(aHighlighter: TppTextSearchDrawCommandHighlighter; aSearchOccurrence: TppTextSearchOccurrence; aDrawCommmandHiglighted: TppDrawCommand); virtual;
      procedure BeforeAddHighlightDrawCommandsToPage(aDrawCommand: TppDrawCommand); virtual;

      procedure AddHighlightDrawCommandsToPage(aPage: TppPage);
      function CreateHighlightDrawCommand(aDrawCommand: TppDrawCommand; aDrawCommandSearchOccurrence: TppTextSearchOccurrence): TppDrawCommand;
      procedure GenerateAllPages;
      procedure PublisherReceiveCachedPage(aPage: TppPage); virtual;
      procedure RequestCurrentPageFromPublisher;
      function SearchCachedPages(aPublisher: TppPublisher): Integer;
      function SearchPages: Boolean;
      function SearchRequestedPages: Integer;

      property InternalAllPagesSearched: Boolean read FInternalAllPagesSearched write FInternalAllPagesSearched;
      property Cancelled: Boolean read FCancelled;
      property CaseSensitive: Boolean read GetCaseSensitive;
      property CurrentPage: TppPage read FCurrentPage;
      property HighlightDrawCommandList: TList read FHighlightDrawCommandList;
      property ShowAll: Boolean read GetShowAll;
      property WholeWord: Boolean read GetWholeWord;
      property Canvas: TCanvas read FCanvas;
      property GotoPageNo: Integer read FGotoPageNo write FGotoPageNo;
      property Publisher: TppPublisher read FPublisher;
      property ScaleX: Double read FScaleX write FScaleX;
      property ScaleY: Double read FScaleY write FScaleY;
      property SearchText: String read FSearchText write FSearchText;
      property ScreenDeviceActive: Boolean read GetScreenDeviceActive write SetScreenDeviceActive;

    public
      constructor Create(Owner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      class function Description: String; virtual; abstract;

      function FirstDrawCommand: Boolean; virtual; abstract;
      function LastDrawCommand: Boolean; virtual; abstract;
      function NextDrawCommand: Boolean; virtual; abstract;
      function PriorDrawCommand: Boolean; virtual; abstract;
      procedure GoToPage(aPageNo: Integer); virtual; abstract;

      procedure CancelSearch;
      procedure ClearHighlightDrawCommandList;
      procedure EraseHighlights; virtual;
      procedure HighlightPage(aPage: TppPage); virtual;
      function NavigateForwardToNextOccurrence(const aSearchText: String): Integer;
      function NavigateForwardToLastOccurrence(const aSearchText: String): Integer;
      procedure Reset; virtual;
      procedure ResetSearchIndex(aIndex: Integer); virtual; abstract;
      function Search(const aSearchText: String): Boolean; virtual;
      function SearchPage(aPage: TppPage; const aSearchText: String): Boolean; virtual;

      property AllPagesSearched: Boolean read FInternalAllPagesSearched;
      property CurrentPageNo: Integer read GetCurrentPageNo;
      property CurrentSearchIndex: Integer read GetCurrentSearchIndex;
      property FirstPageFound: Integer read GetFirstPageFound;
      property HighestPageNoSearched: Integer read FHighestPageNoSearched;
      property OffScreenDevice: TppScreenDevice read FOffScreenDevice;
      property SearchToLastPage: Boolean read FSearchToLastPage write FSearchToLastPage;
      property StartingPageNo: Integer read FStartingPageNo write FStartingPageNo;
      property TextSearchSettings: TppTextSearchSettings read FTextSearchSettings write SetTextSearchSettings;
      property TotalFound: Integer read GetTotalFound;
      property Viewer: TppViewer read FViewer write SetViewer;

    end;

  TppTextSearchCustomEngineClass = class of TppTextSearchCustomEngine;

implementation

uses
  Windows, SysUtils, Forms,
  ppTextSearchError, ppUtils, ppPlainText,
  ppArchiv, ppTextSearchDrawCommandHighlightRegistry;

{@TppTextSearchCustomEngine.Create }

constructor TppTextSearchCustomEngine.Create(Owner: TComponent);
begin

  inherited Create(Owner);

  EventNotifies := EventNotifies + [ciPublisherReceivePage, ciScreenDeviceBeforeDrawPage, ciScreenDeviceAfterDrawPage, ciDevicePageReceive];

  FCancelled := False;
  FInternalAllPagesSearched := False;
  FCanvas := nil;
  FCurrentPage := nil;
  FHighlightDrawCommandList := TList.Create;
  FHighestPageNoSearched := 0;
  FStartingPageNo := 0;
  FShowAll := False;
  FCaseSensitive := False;
  FGotoPageNo := -1;
  FPublisher := nil;
  FOffScreenDevice := TppScreenDevice.Create(nil);
  FOffScreenDevice.AddNotify(Self);
  FOffScreenDevice.AddEventNotify(Self);
  FScreenDeviceActiveCount := 1;
  FScaleX := 1;
  FScaleY := 1;
  FSearchText := '';
  FSearchToLastPage := False;
  FTextSearchSettings := nil;
  FViewer := nil;

end;

{@TppTextSearchCustomEngine.Destroy }

destructor TppTextSearchCustomEngine.Destroy;
begin

  FOffScreenDevice.Free;
  EraseHighlights;
  FHighlightDrawCommandList.Free;

  inherited Destroy;

end;

{@TppTextSearchCustomEngine.Notify }

procedure TppTextSearchCustomEngine.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  liIndex: Integer;
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and not(csDestroying in ComponentState) then
    begin

      if (aCommunicator = FOffScreenDevice) then
        raise ESearchEngineError.Create('TppTextSearchCustomEngine.Notify: Do not attempt to free the embedded OffScreenDevice.')

      else if (FTextSearchSettings <> nil) and (aCommunicator = FTextSearchSettings.WalkieTalkie) then
        FTextSearchSettings := nil

      else if (FViewer <> nil) and (aCommunicator = FViewer.WalkieTalkie) then
        begin
          FViewer := nil;
          FPublisher := nil;
        end

      else
        begin
          {Is it a draw command highlight?}
          liIndex := FHighlightDrawCommandList.IndexOf(aCommunicator);

         if (liIndex <> -1) then
           FHighlightDrawCommandList.Delete(liIndex);
        end;

    end;

end;

{@TppTextSearchCustomEngine.EventNotify }

procedure TppTextSearchCustomEngine.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lPage: TppPage;
begin

  if (aCommunicator = FOffScreenDevice) then
    begin

      if (aEventID = ciDevicePageReceive) then
        FCurrentPage := aParams[0].Value;

    end

  else if (aCommunicator = FPublisher) and (FPublisher.CachePages) and (aEventID = ciPublisherReceivePage) then
    begin
      lPage := aParams[0].Value;

      PublisherReceiveCachedPage(lPage);
    end;

end;

{@TppTextSearchCustomEngine.CreateHighlightDrawCommand }

function TppTextSearchCustomEngine.CreateHighlightDrawCommand(aDrawCommand: TppDrawCommand; aDrawCommandSearchOccurrence: TppTextSearchOccurrence): TppDrawCommand;
var
  lHighlighter: TppTextSearchDrawCommandHighlighter;
  lHighlightDrawCommand: TppDrawCommand;
  lsMessage: String;
begin

  if not(TppTextSearchDrawCommandHighlightRegistry.IsRegistered(TppDrawCommandClass(aDrawCommand.ClassType))) then
    raise ESearchEngineError.Create('TppTextSearchCustomEngine.CreateHighlightDrawCommand: Highlighter class not registered for draw ommand class ' + aDrawCommand.ClassName + '.');

  {don't free the highlighter, it is handled by the registry}
  lHighlighter := TppTextSearchDrawCommandHighlightRegistry.GetHighlighterForDrawCommand(aDrawCommand);
  lHighlighter.CaseSensitive := CaseSensitive;
  lHighlighter.WholeWord := WholeWord;
  lHighlighter.ScaleX := ScaleX;
  lHighlighter.ScaleY := ScaleY;

  BeforeCreateHighlight(lHighlighter, aDrawCommandSearchOccurrence, aDrawCommand);

  try
    lHighlightDrawCommand := lHighlighter.CreateHighlight(aDrawCommand, aDrawCommandSearchOccurrence, FSearchText, Canvas);

  except
    on E: ESearchHighlightError do
      begin
        lsMessage := 'TppTextSearchCustomEngine.CreateHighlightDrawCommand: Could not create highlight draw command for ' + aDrawCommand.Classname + '.' + #13#10 + E.Message;

        raise ESearchEngineError.Create(lsMessage);
      end;

  end;

  if (lHighlightDrawCommand <> nil) then
    begin
      lHighlightDrawCommand.AddNotify(Self);
      HighlightDrawCommandList.Add(lHighlightDrawCommand);
    end;

  AfterCreateHighlight(lHighlighter, aDrawCommand, lHighlightDrawCommand);

  Result := lHighlightDrawCommand;

end;

{@TppTextSearchCustomEngine.AfterCreateHighlight

  If the result of the hihglighter execution is no highlight draw command, then
  it is assumed that the highlighter works by changing then original
  draw command. Thus, force the original draw command to redraw itself.}

procedure TppTextSearchCustomEngine.AfterCreateHighlight(aHighlighter: TppTextSearchDrawCommandHighlighter; aDrawCommmandHighlighted, aHighlightDrawCommand: TppDrawCommand);
begin

  if (aHighlightDrawCommand = nil) then
    begin
      if (Viewer <> nil) then
        aDrawCommmandHighlighted.Draw(Viewer.ScreenDevice)
      else
        aDrawCommmandHighlighted.Draw(OffScreenDevice);
    end;

end;
     
{@TppTextSearchCustomEngine.BeforeCreateHighlight

  Allow descendents to do something before the highlighter is told to
  create a highlight.}

procedure TppTextSearchCustomEngine.BeforeCreateHighlight( aHighlighter: TppTextSearchDrawCommandHighlighter; aSearchOccurrence: TppTextSearchOccurrence; aDrawCommmandHiglighted: TppDrawCommand);
begin

end;

{@TppTextSearchCustomEngine.SetViewer }

procedure TppTextSearchCustomEngine.SetViewer(aViewer: TppViewer);
begin

  if (FViewer <> nil) then
    begin
      FViewer.WalkieTalkie.RemoveNotify(Self);
      FPublisher.RemoveEventNotify(Self);
    end;

  FViewer := aViewer;

  if (FViewer <> nil) then
    begin
      FViewer.WalkieTalkie.AddNotify(Self);

      FPublisher := FViewer.ScreenDevice.Publisher;

      if (FPublisher = nil) then
        raise ESearchEngineError.Create('TppTextSearchCustomEngine.SetViewer: Publisher cannot be nil');

      FPublisher.AddEventNotify(Self);

      FOffScreenDevice.Publisher := nil;
      FOffScreenDevice.PageImage.Width  := FViewer.Width;
      FOffScreenDevice.PageImage.Height := FViewer.Height;
    end
  else
    FPublisher := nil;

end;

{@TppTextSearchCustomEngine.EraseHighlights }

procedure TppTextSearchCustomEngine.EraseHighlights;
var
  liIndex: Integer;
  lHighlightDrawCommand: TppDrawCommand;
begin

  for liIndex := FHighlightDrawCommandList.Count - 1 downto 0 do
    begin

      lHighlightDrawCommand := TppDrawCommand(FHighlightDrawCommandList[liIndex]);

      if lHighlightDrawCommand <> nil then
        begin
          lHighlightDrawCommand.Page := nil;
          lHighlightDrawCommand.Free;
        end;

    end;

  FHighlightDrawCommandList.Clear;

end;

{@TppTextSearchCustomEngine.AddHighlightDrawCommandsToPage }

procedure TppTextSearchCustomEngine.AddHighlightDrawCommandsToPage(aPage: TppPage);
var
  liIndex: Integer;
  lDrawCommand: TppDrawCommand;
begin

  for liIndex := 0 to FHighlightDrawCommandList.Count - 1 do
    begin
      lDrawCommand := TppDrawCommand(FHighlightDrawCommandList[liIndex]);

      BeforeAddHighlightDrawCommandsToPage(lDrawCommand);

      lDrawCommand.Page := aPage;

      if (FViewer <> nil) then
        lDrawCommand.Draw(FViewer.ScreenDevice)
      else
        lDrawCommand.Draw(FOffScreenDevice);
    end;

end;

{@TppTextSearchCustomEngine.BeforeAddHighlightDrawCommandsToPage }

procedure TppTextSearchCustomEngine.BeforeAddHighlightDrawCommandsToPage(aDrawCommand: TppDrawCommand);
begin
end;

{@TppTextSearchCustomEngine.ClearHighlightDrawCommandList

  If you want to keep the highlight draw commands on all searched pages, then
  don't free them, but tell the engine that it should start with a new
  list of highlights. This is used by the QA search engine.}

procedure TppTextSearchCustomEngine.ClearHighlightDrawCommandList;
begin
  FHighlightDrawCommandList.Clear;
end;

{@TppTextSearchCustomEngine.Search }

function TppTextSearchCustomEngine.Search(const aSearchText: String): Boolean;
begin

  FCancelled := False;

  if (FViewer = nil) then
    raise ESearchEngineError.Create('TppTextSearchCustomEngine.Search: Must assign a non-nil viewer from the device in order to search.');

  {setup the FOffScreenDevice to be the same size as the on screen viewer}
  FOffScreenDevice.PageImage.Width  := FViewer.Width;
  FOffScreenDevice.PageImage.Height := FViewer.Height;

  AssignCanvasScale;

  Result := True;

end;

{@TppTextSearchCustomEngine.SearchPage }

function TppTextSearchCustomEngine.SearchPage(aPage: TppPage; const aSearchText: String): Boolean;
var
  liPageNo: Integer;
begin

  AssignCanvasScale;

  liPageNo := aPage.AbsolutePageNo;

  if (liPageNo > FHighestPageNoSearched) then
    FHighestPageNoSearched := liPageNo;

  Result := True;

end;

{@TppTextSearchCustomEngine.SearchPages

  Builds a list of objects which hold the draw commands which have the text we
  searched.

  It works by searchng through the publisher's page cache if cache pages is true
  on the publisher. Otherwise the engine requests pages and searches them in
  order to find the first page where the text occurs. If cache pages is true,
  and no occurrences are found in the page cache, then there are page requests made
  until there are no more pages available from the producer. If the pages aren't
  cahced, then there is an off screen viewer and screen device that is connected
  to the publisher in order to request pages.}

function TppTextSearchCustomEngine.SearchPages: Boolean;
var
  lPublisher: TppPublisher;
begin

  ScreenDeviceActive := False;

  {read from the cache if possible}
  lPublisher := OffScreenDevice.Publisher;

  if (lPublisher = nil) then
    raise ESearchEngineError.Create('TppTextSearchEngine.Search: The publisher is nil because the off screen device has been deactivated.');

  if (lPublisher.CachePages) and (StartingPageNo <= lPublisher.PageCount) then
    begin

      if (FSearchToLastPage and not(lPublisher.Pages[lPublisher.PageCount - 1].LastPage)) then
        begin
          Reset;

          GenerateAllPages;
        end;

      FGotoPageNo := SearchCachedPages(lPublisher);

      {if FGotoPageNo = -1 then the page wasn't found in the page cache, so we
      can continue looking by requesting more pages until there are no more
      pages to be searched}
      if not(FInternalAllPagesSearched) and (FGotoPageNo = -1) then
        begin
          StartingPageNo := lPublisher.PageCount + 1;
          FGotoPageNo := SearchRequestedPages;
        end;

    end

  else  
    FGotoPageNo := SearchRequestedPages;

  if not(Cancelled) then
    Result := (FGotoPageNo <> -1)
  else
    begin
      FGotoPageNo := Viewer.CurrentPage.AbsolutePageNo;

      Result := False;
    end;

  ScreenDeviceActive := True;

end;

{@TppTextSearchCustomEngine.SearchCachedPages }

function TppTextSearchCustomEngine.SearchCachedPages(aPublisher: TppPublisher): Integer;
var
  lbLastPage: Boolean;
  lbFoundTextOnPage: Boolean;
  liPageNo: Integer;
  lPage: TppPage;
  lbSearchAllPages: Boolean;
begin

  Result := -1;

  lbSearchAllPages := aPublisher.Pages[aPublisher.PageCount - 1].LastPage;
  liPageNo := StartingPageNo;
  lbFoundTextOnPage := False;
  lbLastPage := False;

  while not(lbLastPage) and (liPageNo <= aPublisher.PageCount) and (not(lbFoundTextOnPage) or lbSearchAllPages) and not(Cancelled) do
    begin
      lPage := aPublisher.Pages[liPageNo - 1];

      lbLastPage := lPage.LastPage;

      lbFoundTextOnPage := SearchPage(lPage, SearchText);

      if lbFoundTextOnPage and (Result = -1) then
        Result := liPageNo;

      Inc(liPageNo);

      Application.ProcessMessages;
    end;

  if lbSearchAllPages then
    FInternalAllPagesSearched := True;

end;

{@TppTextSearchCustomEngine.SearchRequestedPages }

function TppTextSearchCustomEngine.SearchRequestedPages: Integer;
var
  lbLastPage: Boolean;
  lbFoundTextOnPage: Boolean;
  liIndex: Integer;
  lPage: TppPage;
begin

  liIndex := StartingPageNo;
  lbFoundTextOnPage := False;
  lbLastPage := False;
  Result := -1;

  {support searching when previewing for QA architecture}
  if FSearchToLastPage then
    StopInternalReportPrinting(Viewer.Report);


  if  Viewer.CurrentPage.AbsolutePageNo > 0 then
    begin
      while not(lbLastPage) and (not(lbFoundTextOnPage) or FSearchToLastPage) and not(Cancelled) do
        begin

          if (liIndex <> Viewer.CurrentPage.AbsolutePageNo) or (Viewer.DesignViewer) then
            begin
              RequestPage(liIndex);

              {current page is assigned in EventNotify of ancestor when page is received and is from the offscreendevice}
              lPage := CurrentPage;
            end
          else
            lPage := Viewer.CurrentPage;

          if (lPage = nil) then
            raise ESearchEngineError.Create('TppTextSearchCustomEngine.SearchRequestedPages: Requested page is nil.');

          lbLastPage := lPage.LastPage;

          lbFoundTextOnPage := SearchPage(lPage, SearchText);

          if (Result = -1) and lbFoundTextOnPage then
            Result := liIndex;

          Inc(liIndex);

          Application.ProcessMessages;

        end;
    end;

end;

{@TppTextSearchCustomEngine.GenerateAllPages }

procedure TppTextSearchCustomEngine.GenerateAllPages;
begin

  ScreenDeviceActive := False;

  {set printing false in order to support searching when previewing for QA architecture}
  if FSearchToLastPage then
    StopInternalReportPrinting(Viewer.Report);

  OffScreenDevice.PageRequest.PageSetting := psAll;
  OffScreenDevice.MakePageRequest;

  ScreenDeviceActive := True;

end;

{@TppTextSearchCustomEngine.StopInternalReportPrinting }

procedure TppTextSearchCustomEngine.StopInternalReportPrinting(aReport: TObject);
begin

  if (aReport = nil) then
    raise ESearchEngineError.Create('TppTextSearchCustomEngine.StopInternalReportPrinting: Report cannot be nil on the viewer.');

  if (aReport is TppCustomReport) and (TppCustomReport(aReport).Engine <> nil) then
    TppCustomReport(aReport).Engine.Printing := False

  else if (aReport is TppCustomArchiveReader) then
    TppCustomArchiveReader(aReport).Printing := False;

end;

{@TppTextSearchCustomEngine.RequestCurrentPageFromPublisher }

procedure TppTextSearchCustomEngine.RequestCurrentPageFromPublisher;
begin
  FViewer.ScreenDevice.PageRequest.PageSetting := psSinglePage;
  FViewer.ScreenDevice.PageRequest.PageRequested := Viewer.CurrentPage.AbsolutePageNo;
  FViewer.ScreenDevice.MakePageRequest;
end;

{@TppTextSearchCustomEngine.Reset }

procedure TppTextSearchCustomEngine.Reset;
begin

  FCanvas := nil;
  FScaleY := 1;
  FScaleX := 1;
  FHighestPageNoSearched := 0;

  EraseHighlights;
end;

{@TppTextSearchCustomEngine.NavigateForwardToNextOccurrence

  The current page has been searched and the text was not found on it, so we
  have to move to the next page to try and find another Occurrence of the text.}

function TppTextSearchCustomEngine.NavigateForwardToNextOccurrence(const aSearchText: String): Integer;
begin
  Result := NavigateForward(aSearchText, True);
end;

{@TppTextSearchCustomEngine.NavigateForwardToLastOccurrence

  Loop until all pages have been searched and return the last page that
  the search text was found on.}

function TppTextSearchCustomEngine.NavigateForwardToLastOccurrence(const aSearchText: String): Integer;
begin
  Result := NavigateForward(aSearchText, False);
end;

{@TppTextSearchCustomEngine.NavigateForward }

function TppTextSearchCustomEngine.NavigateForward(const aSearchText: String; aStopOnFirstOccurrence: Boolean): Integer;
var
  liStartingPage: Integer;
  lbDone: Boolean;
  lCurrentPage: TppPage;
  liPageNo: Integer;
  lbFound: Boolean;
begin

  Result := 0;

  if (Viewer = nil) then
    raise ESearchEngineError.Create('TppTextSearchCustomEngine.NavigateForward: Cannot request pages when the viewer is nil.');

  lCurrentPage := Viewer.CurrentPage;
  lbDone := False;

  liStartingPage := Viewer.CurrentPage.AbsolutePageNo;

  while not(lCurrentPage.LastPage) and not(lbDone) and not(Cancelled) do
    begin

      liPageNo := lCurrentPage.AbsolutePageNo;

      RequestPage(liPageNo + 1);

      {current page is from the offscreen device}
      lbFound := SearchPage(FCurrentPage, aSearchText);

      lCurrentPage := FCurrentPage;

      if lbFound then
        begin
          Result := lCurrentPage.AbsolutePageNo;

          if aStopOnFirstOccurrence then
            lbDone := True;

        end;

      {check for cancel}
      Application.ProcessMessages;
    end;

  if lCurrentPage.LastPage and not(lbDone) and not(Cancelled) then
    RequestPage(Viewer.CurrentPage.AbsolutePageNo)

  else if Cancelled then
    Result := liStartingPage;

end;
 
{@TppTextSearchCustomEngine.RequestPage }

procedure TppTextSearchCustomEngine.RequestPage(aPageNo: Integer);
begin

  ScreenDeviceActive := False;

  FOffScreenDevice.PageRequest.PageSetting := psSinglePage;
  FOffScreenDevice.PageRequest.PageRequested := aPageNo;
  FOffScreenDevice.MakePageRequest;

  ScreenDeviceActive := True;

end;

{@TppTextSearchCustomEngine.GetScreenDeviceActive }

function TppTextSearchCustomEngine.GetScreenDeviceActive: Boolean;
begin
  Result := (FScreenDeviceActiveCount > 0);
end;
      
{@TppTextSearchCustomEngine.SetScreenDeviceActive }

procedure TppTextSearchCustomEngine.SetScreenDeviceActive(aScreenDeviceActive: Boolean);
var
  liDevice: Integer;
  lDevice: TppDevice;
  liDevices: Integer;
begin

  if aScreenDeviceActive then
    Inc(FScreenDeviceActiveCount)
  else
    Dec(FScreenDeviceActiveCount);

  if (FViewer <> nil) and (FViewer.ScreenDevice <> nil) then
    begin

      {disconnect all devices from publisher}
      if (FPublisher <> nil) then
        begin

          liDevices := FPublisher.DeviceCount;

          for liDevice := (liDevices - 1) downto 0 do
            begin
              lDevice := FPublisher.Devices[liDevice];

              if lDevice is TppScreenDevice then
                lDevice.Publisher := nil;
            end;

        end;

      if ScreenDeviceActive then
        begin
          FViewer.ScreenDevice.Publisher := FPublisher;
          FOffScreenDevice.Publisher := nil;
        end

      else
        begin
          FViewer.ScreenDevice.Publisher := nil;
          FOffScreenDevice.Publisher := FPublisher;

          AssignCanvasScale;
        end;

    end;

end;

{@TppTextSearchCustomEngine.HighlightPage }

procedure TppTextSearchCustomEngine.HighlightPage(aPage: TppPage);
begin
  AssignCanvasScale;
end;

{@TppTextSearchCustomEngine.AssignCanvasScale }

procedure TppTextSearchCustomEngine.AssignCanvasScale;
var
  lScreenDevice: TppScreenDevice;
begin

  if (FViewer <> nil) then
    lScreenDevice := FViewer.ScreenDevice
  else
    lScreenDevice := FOffScreenDevice;

  {reset the font}
  FCanvas := lScreenDevice.Canvas;

  if (FCanvas = nil) then
    raise ESearchEngineError.Create('TppTextSearchCustomEngine.AssignCanvasScale: Must have a non nil canvas.');

  FScaleY := lScreenDevice.Scale;
  FScaleX := lScreenDevice.Scale;
  
end;
  
{@TppTextSearchCustomEngine.PublisherReceiveCachedPage

  Allows descendent engines top get at the publisher's cached page object.}

procedure TppTextSearchCustomEngine.PublisherReceiveCachedPage(aPage: TppPage);
begin

end;

{@TppTextSearchCustomEngine.SetTextSearchSettings }

procedure TppTextSearchCustomEngine.SetTextSearchSettings(aTextSearchSettings: TppTextSearchSettings);
begin

  if (FTextSearchSettings <> nil) then
    FTextSearchSettings.WalkieTalkie.RemoveNotify(Self);

  FTextSearchSettings := aTextSearchSettings;

  if (FTextSearchSettings <> nil) then
    FTextSearchSettings.WalkieTalkie.AddNotify(Self);
    
end;
    
{@TppTextSearchCustomEngine.GetCaseSensitive }

function TppTextSearchCustomEngine.GetCaseSensitive: Boolean;
begin
  if (FTextSearchSettings <> nil) then
    Result := FTextSearchSettings.CaseSensitive
  else
    Result := False;
end;

{@TppTextSearchCustomEngine.GetShowAll }

function TppTextSearchCustomEngine.GetShowAll: Boolean;
begin
  if (FTextSearchSettings <> nil) then
    Result := FTextSearchSettings.ShowAll
  else
    Result := False;
end;

{@TppTextSearchCustomEngine.GetWholeWord }

function TppTextSearchCustomEngine.GetWholeWord: Boolean;
begin
  if (FTextSearchSettings <> nil) then
    Result := FTextSearchSettings.WholeWord
  else
    Result := False;
end;

{@TppTextSearchCustomEngine.CancelSearch

 The search may have been requesting pages to search, so cancel that too.}

procedure TppTextSearchCustomEngine.CancelSearch;
begin
  FCancelled := True;

  if FPublisher = nil then
    raise ESearchEngineError.Create('TppTextSearchCustomEngine.CancelSearch: Publisher is nil and cannot cancel the search cleanly.');

  {need to disconnect to be able to not set cancelled to true on the real screen
   device. If cancelled gets set to true on the screen device,
   then the page navigation buttons won't work.}
  ScreenDeviceActive := False;

  FPublisher.CancelJob;

  ScreenDeviceActive := True;

  FOffScreenDevice.Cancel;

  Reset;
end;

end.
