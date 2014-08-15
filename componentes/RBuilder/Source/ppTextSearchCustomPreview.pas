{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchCustomPreview;

interface

uses
  Buttons, Controls, Classes, ComCtrls, ExtCtrls,
  ppComm, ppViewr, ppTypes, ppRTTI,
  ppTextSearchCustomEngine, ppTextSearchSettings, ppTextSearchError,
  ppTBXStatusBars;

type

  TppTextSearchStates = set of TppTextSearchStateType;

  {@TppCustomSearchPreview

    Abstract ancestor to provide the capability to create a plugin descendent
    which creates the visual controls and calls methods in this class to perform
    the search operations.}

  {@TppCustomSearchPreview.ActiveSearch

    True when a search has started and is false only after the search is
    cancelled or done.}

  {@TppCustomSearchPreview.SearchingPage

   True when the search is searching pages. The value is false once all pages
   are searched.}

  TppCustomSearchPreview = class(TppCommunicator)
    private
      FElapsedStartTime: Double;
      FBusy: Boolean;
      FGotoFirst: Boolean;
      FSaveCursor: TCursor;
      FTextSearchSettingsChanged: Boolean;
      FBroadcastChangesCount: Integer;
      FListenToControlChangesCount: Integer;
      FControlsEnabled: Boolean;
      FIgnorePageChanges: Boolean;
      FInternalSearchWhenPreview: Boolean;
      FLastPageNoHighlighted: Integer;
      FPageNavigationClicked: Boolean;
      FPerformingCancel: Boolean;
      FSearchIndex: Integer;
      FSearchText: String;
      FStartingPageNo: Integer;
      FSearchEngine: TppTextSearchCustomEngine;
      FSearchEngineClass: TppTextSearchCustomEngineClass;
      FSearchPanel: TPanel;
      FSearchOperationInMilliseconds: Integer;
      FStatusBar: TStatusBar;
      FTextSearchSettings: TppTextSearchSettings;
      FTextSearchStates: TppTextSearchStates;
      FViewer: TppViewer;
      FTranslatedMinWidth: Integer;
      FOnKeyDown: TKeyEvent;
      FStatusBarTbx: TppTBXStatusBar;

      procedure AfterDrawPage;
      procedure BeforeDrawPage;
      procedure BeforeLastPageJump;
      procedure BeginElapsedTime;
      procedure EndElapsedTime;
      procedure InternalCancel;
      procedure CloseSearchPreview;
      procedure CreateSearchEngine;
      procedure FinishOperation(aSearchType: TppTextSearchType);
      function GetBroadcastChanges: Boolean;
      function GetListenToControlChanges: Boolean;
      function GetActiveSearch: Boolean;
      function GetCancelled: Boolean;
      function GetSearchingPage: Boolean;
      procedure GotoFirst;
      procedure GotoLast;
      procedure GotoNext;
      procedure GotoPrior;
      procedure HighlightPage;
      function NavigateToThePage(aPageNo: Integer): Boolean;
      procedure PerfomSearchWhenPreview;
      procedure Refresh;
      procedure RefreshPage;
      procedure SetSearchingPage(aSearchingPage: Boolean);
      procedure SearchSkippedPages(aStartPageNo, aEndPageNo: Integer);
      procedure SetBroadcastChanges(aBroadcastChanges: Boolean);
      procedure SetListenToControlChanges(aListenToControlChanges: Boolean);
      procedure SetTextSearchSettings(aTextSearchSettings: TppTextSearchSettings);
      procedure SettingsToEngine;
      procedure SetViewer(aViewer: TppViewer);
      function ShouldHighlightPageForShowAll: Boolean;
      procedure Reset;
    protected
      procedure PerformSearchOperation(aSearchType: TppTextSearchType);

      procedure ActivateSearch; virtual;
      procedure ControlsToSettings; virtual; abstract;
      procedure DeactivateSearch; virtual;
      procedure DoneSearching; virtual;
      function IsFirstDrawCommand: Boolean;
      function IsLastDrawCommand: Boolean;
      procedure HandleError(E: ESearchError); virtual;
      procedure InternalInitialize; virtual;
      function GetEngineClass: String; virtual;
      procedure InitializeStatusBar; virtual;
      function ShouldPerformSearch: Boolean; virtual;
      function Search: Boolean; virtual;
      procedure SetBusy(aBusy: Boolean); virtual;
      procedure SetOnKeyDown(aOnKeyDown: TKeyEvent); virtual;
      procedure SetTranslatedMinWidth(aTranslatedMinWidth: Integer);
      procedure ToggleSearchPanel; virtual;
      procedure UpdateControls; virtual;
      procedure UpdateStatusText(aStatus: String);

      property BroadcastChanges: Boolean read GetBroadcastChanges write SetBroadcastChanges;
      property Busy: Boolean read FBusy write SetBusy;
      property ListenToControlChanges: Boolean read GetListenToControlChanges write SetListenToControlChanges;
      property Cancelled: Boolean read GetCancelled;
      property ControlsEnabled: Boolean read FControlsEnabled;
      property Engine: TppTextSearchCustomEngine read FSearchEngine;
      property SearchIndex: Integer read FSearchIndex;
      property SearchPanel: TPanel read FSearchPanel;
      property SearchOperationInMilliseconds: Integer read FSearchOperationInMilliseconds;
      property SearchText: String read FSearchText write FSearchText;
      property StartingPageNo: Integer read FStartingPageNo;
      property TextSearchSettingsChanged: Boolean read FTextSearchSettingsChanged write FTextSearchSettingsChanged;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      procedure AfterPreview; virtual;
      procedure ArrangeControlsVertically; virtual; abstract;
      procedure ArrangeControlsHorizontally; virtual; abstract;
      procedure AfterPreviewActionPerformed(aPreviewAction: TppPreviewActionType); virtual;
      procedure BeforePreviewActionPerformed(aPreviewAction: TppPreviewActionType); virtual;
      procedure BeforePreview; virtual;
      procedure BeforePageJump(aGoToPageNo: Integer); virtual;

      procedure CreateControls(aSearchPanel: TPanel); virtual;
      procedure Initialize;
      procedure Cancel;
      procedure LanguageChanged; virtual;
      procedure StatusChange; virtual;
      procedure ToggleSearch;

      property ActiveSearch: Boolean read GetActiveSearch;
      property SearchingPage: Boolean read GetSearchingPage write SetSearchingPage;
      property StatusBar: TStatusBar read FStatusBar write FStatusBar;
      property StatusBarTbx: TppTBXStatusBar read FStatusBarTbx write FStatusBarTbx;
      property TextSearchSettings: TppTextSearchSettings read FTextSearchSettings write SetTextSearchSettings;
      property TranslatedMinWidth: Integer read FTranslatedMinWidth;
      property Viewer: TppViewer read FViewer write SetViewer;

      property OnKeyDown: TKeyEvent read FOnKeyDown write SetOnKeyDown;

    end;

  {TppCustomSearchPreviewClass}

  TppCustomSearchPreviewClass = class of TppCustomSearchPreview;

implementation

uses

  {$IFDEF Delphi6}Variants,{$ENDIF}
  SysUtils, Windows, Graphics, Forms,
  ppTextSearchPreviewIcons, ppUtils, ppDevice,
  ppTextSearchEngineRegistry;

{@TppCustomSearchPreview.Create }

constructor TppCustomSearchPreview.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FBroadcastChangesCount := 1;
  FBusy := False;
  FElapsedStartTime := 0;
  FViewer := nil;
  FStatusBar := nil;
  FSearchEngine := nil;
  FSearchEngineClass := nil;
  FTextSearchSettings := TppTextSearchSettings.Create;
  FTextSearchSettings.WalkieTalkie.AddNotify(Self);
  FControlsEnabled := False;
  FInternalSearchWhenPreview := FTextSearchSettings.SearchWhenPreview;
  FIgnorePageChanges := False;
  FListenToControlChangesCount := 0;
  FPerformingCancel := False;
  FSearchIndex := -1;
  FSearchText := '';
  FStartingPageNo := 1;
  FSearchPanel := nil;
  FSearchOperationInMilliseconds := 0;
  FPageNavigationClicked := False;
  FTextSearchSettingsChanged := False;
  FTextSearchStates := [];
  FLastPageNoHighlighted := 0;
  FGotoFirst := True;
  FSaveCursor := Screen.Cursor;
  
  EventNotifies := EventNotifies + [ciViewerReset, ciDevicePageReceive, ciScreenDeviceBeforeDrawPage, ciScreenDeviceAfterDrawPage, ciNewSearchOccurrence];
  
end;

{@TppCustomSearchPreview.Destroy }

destructor TppCustomSearchPreview.Destroy;
begin

  FTextSearchSettings.Free;
  FSearchEngine.Free;

  inherited Destroy;

end;

{@TppCustomSearchPreview.Notify }

procedure TppCustomSearchPreview.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) then
    begin

      if (aCommunicator = FViewer.WalkieTalkie) then
        raise ESearchError.Create('TppCustomSearchPreview.Notify: Cannot free the viewer.')

      else if (aCommunicator = FTextSearchSettings.WalkieTalkie) and not(csDestroying in ComponentState) then
        raise ESearchError.Create('TppCustomSearchPreview.Notify: Cannot free the TextSearchSettings.')

    end;

end;

{@TppCustomSearchPreview.EventNotify }

procedure TppCustomSearchPreview.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lPage: TppPage;
  lsMessage: String;
begin

  if (FViewer <> nil) then
    begin

      if (aCommunicator = FSearchEngine) then
        begin

          if (aEventID = ciNewSearchOccurrence) then
            StatusChange;

        end

      else if (FSearchEngine <> nil) and (aCommunicator = FSearchEngine.OffScreenDevice) then
        begin

          if (aEventID = ciDevicePageReceive) then
            begin
              lPage := aParams[0].Value;

              lsMessage := ppLoadStr(4); {'Calculating page 1 for <documentname>'}
              lsMessage := ppSetMessageParameters(lsMessage);
              lsMessage := Format(lsMessage, [IntToStr(lPage.AbsolutePageNo), lPage.DocumentName]);

              UpdateStatusText(lsMessage);
            end

        end

      else if (FViewer <> nil) and (aCommunicator = FViewer.WalkieTalkie) then
        begin

          if (aEventID = ciViewerReset) then
            Reset;
        end

      else if (FViewer <> nil) and (aCommunicator = FViewer.ScreenDevice) then
        begin

          {before the screen device renders the draw commands on the page}
          if (aEventID = ciScreenDeviceBeforeDrawPage) then
            BeforeDrawPage;

          {after the screen device renders the draw commands on the page}
           if (aEventID = ciScreenDeviceAfterDrawPage) then
            AfterDrawPage;

        end;
        
    end;

end;

{@TppCustomSearchPreview.AfterPreview }

procedure TppCustomSearchPreview.AfterPreview;
begin

  SearchingPage := False;

  FTextSearchSettingsChanged := False;
  FIgnorePageChanges := False;
  FSearchIndex := -1;
  FSearchText := '';
  FStartingPageNo := 1;
  FPageNavigationClicked := False;

  if (FSearchEngine <> nil) then
    FSearchEngine.Reset;

end;

{@TppCustomSearchPreview.BeforePreview }

procedure TppCustomSearchPreview.BeforePreview;
var
  lbSuccess: Boolean;
begin

  if (FViewer = nil) then
    raise ESearchError.Create('TppCustomSearchPreview.BeforePreview: Must assign viewer first.');

  if (FViewer.ScreenDevice = nil) then
    raise ESearchError.Create('TppCustomSearchPreview.BeforePreview: Screen device is nil.');

  lbSuccess := False;

  try
    lbSuccess := LockWindowUpdate(Viewer.Parent.Handle);

    FViewer.ScreenDevice.AddEventNotify(Self);

    CreateSearchEngine;

    InitializeStatusBar;

    {haven't cancelled yet}
    FTextSearchStates := FTextSearchStates - [seCancelled];

    FTextSearchSettingsChanged := False;
    FInternalSearchWhenPreview := TextSearchSettings.SearchWhenPreview;

    if TextSearchSettings.Enabled and TextSearchSettings.Visible then
      FControlsEnabled := True
    else
      FControlsEnabled := False;

    ToggleSearchPanel;

    if not(FControlsEnabled) then
      begin
        if ActiveSearch then
          InternalCancel
        else
          begin
            Reset;

            UpdateControls;
          end;

      end;

  finally
    if lbSuccess then
      LockWindowUpdate(0);

  end;

end;
               
{@TppCustomSearchPreview.CreateSearchEngine

  Creates a search engine. It is not always created, but created on demand only
  when the search engine has not been created, or a different search engine is
  registered to be used as a replacement at runtime.}

procedure TppCustomSearchPreview.CreateSearchEngine;
var
  lSearchEngineClass: TppTextSearchCustomEngineClass;
begin

  lSearchEngineClass := TppTextSearchEngineRegistry.GetEngineForDescription(GetEngineClass);

  {try to use the ancestor TppTextSearchEngine}
  if (lSearchEngineClass = nil) then
    begin
      lSearchEngineClass := TppTextSearchEngineRegistry.GetEngineForDescription('Full Search');

      {ancestor TppTextSearchEngine not registered, check ppTextSearch.pas for registration call}
      if (lSearchEngineClass = nil) then
        raise ESearchError.Create('TppCustomSearchPreview.CreateSearchEngine: Text search engine not found in registry: ' + GetEngineClass);
    end;

  if (FSearchEngineClass <> lSearchEngineClass) then
    begin
      FSearchEngineClass := lSearchEngineClass;

      if (FSearchEngine <> nil) then
        begin
          FSearchEngine.RemoveEventNotify(Self);
          FSearchEngine.Free;
          FSearchEngine := nil;
        end;

      FSearchEngine := FSearchEngineClass.Create(nil);
      FSearchEngine.AddEventNotify(Self);
      FSearchEngine.OffScreenDevice.AddEventNotify(Self);
    end;

end;

{@TppCustomSearchPreview.StatusChange

  This method is triggered when it is appropriate to set the status text. Override
  this in descendents in order to set the text in the status bar of the preview
  form.}

procedure TppCustomSearchPreview.StatusChange;
begin


end;

{@TppCustomSearchPreview.BeforeLastPageJump

  Before the last page is requested, the search doesn't know how many pages to
  reqeuest in order to search through them in order to search the skipped pages.
  Requests pages incrementally until the last page is found.}

procedure TppCustomSearchPreview.BeforeLastPageJump;
begin

  if (Viewer.AbsolutePageNo >= FSearchEngine.HighestPageNoSearched)  then
    begin
      FSearchEngine.EraseHighlights;

      {need to search all skipped pages}
      FSearchEngine.NavigateForwardToLastOccurrence(FSearchText);

      if not(Cancelled) then
        FSearchEngine.ResetSearchIndex(FSearchIndex)
      else
        begin
          if (Viewer <> nil) then
            Viewer.ScreenDevice.Cancel;
            
          UpdateControls;
        end;

    end;

end;

{@TppCustomSearchPreview.BeforePageJump

  Used to search through the pages that are skipped when the user skips pages.}

procedure TppCustomSearchPreview.BeforePageJump(aGoToPageNo: Integer);
begin

  if ActiveSearch then
    begin
      FPageNavigationClicked := True;

      if (Viewer.AbsolutePageNo >= FSearchEngine.HighestPageNoSearched) and (aGotoPageNo > FSearchEngine.HighestPageNoSearched) then
        begin
          FSearchEngine.EraseHighlights;

          SearchSkippedPages(FSearchEngine.HighestPageNoSearched + 1, aGoToPageNo - 1);

          FSearchEngine.ResetSearchIndex(FSearchIndex);
        end;

    end;

end;

{@TppCustomSearchPreview.BeforePreviewActionPerformed

  Used to track that an action has been performed by the TppPreview controls.}

procedure TppCustomSearchPreview.BeforePreviewActionPerformed(aPreviewAction: TppPreviewActionType);
begin

  ListenToControlChanges := False;

  if ActiveSearch then
    begin

      if (aPreviewAction in [paFirst, paPrior, paNext]) then
        FPageNavigationClicked := True

      else if (aPreviewAction in [paAutoSearch, paCancel, paClose]) then
        begin
          PerformSearchOperation(stCancel);

          if (aPreviewAction = paCancel) then
            CloseSearchPreview;
        end

      else if (aPreviewAction = paLast) then
        begin
          FPageNavigationClicked := True;

          SearchingPage := True;

          BeforeLastPageJump;

          SearchingPage := False;
        end;

    end
  else if Cancelled then
    FTextSearchStates := [];

end;

{@TppCustomSearchPreview.AfterPreviewActionPerformed }

procedure TppCustomSearchPreview.AfterPreviewActionPerformed(aPreviewAction: TppPreviewActionType);
begin
  ListenToControlChanges := True;
end;

{@TppCustomSearchPreview.ToggleSearch

  Call this routine in descendents in order to turn the controls on or off.

  Also call this routine if you are replacing the preview form and creating the
  search preview object manually.}

procedure TppCustomSearchPreview.ToggleSearch;
var
  lbSuccess: Boolean;
begin

  lbSuccess := False;

  try
    {makes resizing of the preview form controls less flashy}
    lbSuccess := LockWindowUpdate(FViewer.Parent.Handle);

    FViewer.IncrementalPainting := True;

    FControlsEnabled := not(FControlsEnabled);

    TextSearchSettings.Visible := FControlsEnabled;

    ToggleSearchPanel;

    FViewer.IncrementalPainting := False;

  finally
    if lbSuccess then
      LockWindowUpdate(0);
  end;

  {if disabling of the search is the result of this button click then}
  if not(FControlsEnabled) then
    begin

      if ActiveSearch then
        InternalCancel
      else
        Reset;

      RefreshPage;

    end
  else
    Reset;

  UpdateControls;

  {notify the preview plugin that the search has grabbed focus and that it can
  return focus to its key catcher}
  SendEventNotify(Self, ciSearchPreviewActionPerformed, nil);

end;

{@TppCustomSearchPreview.ToggleSearchPanel

  Based on the setting of FControlsEnabled, the search toolbar is turned on or
  off.  When the search toolbar is hidden, then the active search is terminated.}

procedure TppCustomSearchPreview.ToggleSearchPanel;
begin
  FSearchPanel.Visible := FControlsEnabled;

  {this is sent in order to notify the TppPreview to configure the accessory
   panel visibility when the search panel is aligned left}
  SendEventNotify(Self, ciSearchToolBarChanged, nil);
end;

{@TppCustomSearchPreview.SetViewer }

procedure TppCustomSearchPreview.SetViewer(aViewer: TppViewer);
begin

  FViewer := aViewer;

  if (FViewer <> nil) then
    begin
      FViewer.WalkieTalkie.AddEventNotify(Self);
      FViewer.Screendevice.AddEventNotify(Self);
    end;

end;

{@TppCustomSearchPreview.GetBroadcastChanges }

function TppCustomSearchPreview.GetBroadcastChanges: Boolean;
begin
  Result := (FBroadcastChangesCount > 0);
end;

{@TppCustomSearchPreview.SetBroadcastChanges }

procedure TppCustomSearchPreview.SetBroadcastChanges(aBroadcastChanges: Boolean);
begin

  if (aBroadcastChanges) then
    Inc(FBroadcastChangesCount)
  else
    Dec(FBroadcastChangesCount);

end;
  
{@TppCustomSearchPreview.GetListenToControlChanges }

function TppCustomSearchPreview.GetListenToControlChanges: Boolean;
begin
  Result := (FListenToControlChangesCount = 0);
end;
   
{@TppCustomSearchPreview.SetListenToControlChanges }

procedure TppCustomSearchPreview.SetListenToControlChanges(aListenToControlChanges: Boolean);
begin

  if (aListenToControlChanges) then
    Inc(FListenToControlChangesCount)
  else
    Dec(FListenToControlChangesCount);

end;

{@TppCustomSearchPreview.SetTextSearchSettings }

procedure TppCustomSearchPreview.SetTextSearchSettings(aTextSearchSettings: TppTextSearchSettings);
begin
  FTextSearchSettings.Assign(aTextSearchSettings);
end;

{@TppCustomSearchPreview.NavigateToThePage

  Tell the viewer to request a page by passing the absolute page number.}

function TppCustomSearchPreview.NavigateToThePage(aPageNo: Integer): Boolean;
begin

  Result := False;

  BroadcastChanges := False;

  if (aPageNo <> -1) and not(Cancelled) then
    begin
      if (aPageNo <> FViewer.CurrentPage.AbsolutePageNo) then
        begin
          FSearchEngine.EraseHighlights;

          FViewer.GotoPage(aPageNo);

          Result := True;
        end;

    end;

  BroadcastChanges := True;

end;

{@TppCustomSearchPreview.RefreshPage

  Tells the viewer to redraw the current page.}

procedure TppCustomSearchPreview.RefreshPage;
begin
  FViewer.ScreenDevice.RenderPage;
  FViewer.RefreshPage;
end;
 
{@TppCustomSearchPreview.HighlightPage

  Uses the search engine to highlight the page.}

procedure TppCustomSearchPreview.HighlightPage;
begin

  if (FSearchEngine.TotalFound > 0) then
    begin
      BroadcastChanges := False;

      FSearchEngine.EraseHighlights;

      try
        FSearchEngine.HighlightPage(Viewer.CurrentPage);

        FLastPageNoHighlighted := FViewer.CurrentPage.AbsolutePageNo;

      except
        on E: ESearchEngineError do
          raise ESearchPreviewError.Create('TppCustomSearchPreview.HighlightPage: Cannot highlight page.' + #13#10 + E.Message);

      end;

      if not(Cancelled) then
        RefreshPage;

      BroadcastChanges := True;
    end;

end;
    
{@TppCustomSearchPreview.CreateControls }

procedure TppCustomSearchPreview.CreateControls(aSearchPanel: TPanel);
begin
  FSearchPanel := aSearchPanel;
  FSearchPanel.Visible := FControlsEnabled;
end;

{@TppCustomSearchPreview.AfterDrawPage

  This method is called after the engine has copied the page to the screen
  device, but before it is rendered on the screen so that we can highlight the
  page with highlight draw commands.}

procedure TppCustomSearchPreview.AfterDrawPage;
var
  lbShouldHighlight: Boolean;
begin

  if (Viewer.CurrentPage.AbsolutePageNo <> 0) then
    begin

      if FInternalSearchWhenPreview then
        begin
          FInternalSearchWhenPreview := False;

          FGotoFirst := False;

          PerfomSearchWhenPreview;

          FGotoFirst := True;
        end

      else if BroadcastChanges then
        begin
          BroadcastChanges := False;

          if (FSearchEngine <> nil) and (FSearchEngine.TotalFound > 0) then
            begin

              if TextSearchSettings.ShowAll then
                lbShouldHighlight := ShouldHighlightPageForShowAll
              else
                begin
                  lbShouldHighlight := (FLastPageNoHighlighted = Viewer.CurrentPage.AbsolutePageNo);

                  if (Viewer.CurrentPage.AbsolutePageNo > FSearchEngine.HighestPageNoSearched) then
                    FSearchEngine.SearchPage(Viewer.CurrentPage, FSearchText);
                end;

              if lbShouldHighlight then
                lbShouldHighlight := Viewer.CurrentPage.DrawCommandCount > 0;

              if lbShouldHighlight then
                begin
                  FSearchEngine.HighlightPage(Viewer.CurrentPage);

                  StatusChange;

                  RefreshPage;

                  FLastPageNoHighlighted := Viewer.CurrentPage.AbsolutePageNo
                end;

              UpdateControls;
            end;

          BroadcastChanges := True;
        end;

    end;

end;

{@TppCustomSearchPreview.BeforeDrawPage

 Notification which happens before the screen device renders the draw commands
 on the page.}

procedure TppCustomSearchPreview.BeforeDrawPage;
begin

  if BroadcastChanges and (FSearchEngine <> nil) then
    FSearchEngine.EraseHighlights;

end;

{@TppCustomSearchPreview.ShouldHighlightPageForShowAll }

function TppCustomSearchPreview.ShouldHighlightPageForShowAll: Boolean;
begin
  Result := True;

  if (FLastPageNoHighlighted <> Viewer.CurrentPage.AbsolutePageNo) then
    begin
      if TextSearchSettings.SearchFromCurrentPage and (Viewer.CurrentPage.AbsolutePageNo < FStartingPageNo) then
        Result := False

      else if (Viewer.CurrentPage.AbsolutePageNo > FSearchEngine.HighestPageNoSearched) then
        Result := FSearchEngine.SearchPage(Viewer.CurrentPage, FSearchText);

      if Result then
        begin
          Result := (FSearchEngine.TotalFound > 0);

          if Result then
            FSearchEngine.GotoPage(Viewer.CurrentPage.AbsolutePageNo);
        end;
        
    end;

end;

{@TppCustomSearchPreview.SearchSkippedPages }

procedure TppCustomSearchPreview.SearchSkippedPages(aStartPageNo, aEndPageNo: Integer);
var
  liPageNo: Integer;
begin

  if ((aEndPageNo - aStartPageNo) >= 0) then
    begin
      FSearchEngine.GoToPage(aStartPageNo);

      liPageNo := aStartPageNo;

      while (liPageNo < aEndPageNo) do
        liPageNo := FSearchEngine.NavigateForwardToNextOccurrence(FSearchText);

      FSearchEngine.ResetSearchIndex(FSearchIndex);
    end;

end;

{@TppCustomSearchPreview.ActivateSearch }

procedure TppCustomSearchPreview.ActivateSearch;
begin
  if not(ActiveSearch) then
    begin
      FTextSearchStates := FTextSearchStates + [seActiveSearch] - [seCancelled];

      FSearchPanel.Color := clBtnFace;
    end;
end;

{@TppCustomSearchPreview.DeactivateSearch }

procedure TppCustomSearchPreview.DeactivateSearch;
begin
  FTextSearchStates := FTextSearchStates - [seActiveSearch];
end;

{@TppCustomSearchPreview.PerformSearchOperation }

procedure TppCustomSearchPreview.PerformSearchOperation(aSearchType: TppTextSearchType);
begin

  if ListenToControlChanges  or (aSearchType = stCancel) then
    begin
      if (aSearchType <> stCancel) then
        ListenToControlChanges := False;

      BeginElapsedTime;

      try
        begin

          if (FSearchEngine <> nil) then
            begin

              try
                ActivateSearch;

                Busy := True;

                case aSearchType of

                  stSearch: Search;

                  stFirst: GotoFirst;

                  stNext: GotoNext;

                  stPrior: GotoPrior;

                  stLast: GotoLast;

                  stCancel: InternalCancel;

                  stDone: DoneSearching;

                  stRefresh: Refresh;

                end;

              finally
                FinishOperation(aSearchType);

                EndElapsedTime;

                if (aSearchType <> stCancel) then
                  ListenToControlChanges := True;

                UpdateControls;

                Busy := False;

              end;

            end;
        end

      except
        on E: ESearchError do HandleError(E);

      end;

      {notify the Preview Plugin that the search is being used and the
      preview would like to know that so it can set the focus to its KeyCatcher
      to support standard keystroke control of the Preview.}
      if not(FPerformingCancel) then
        SendEventNotify(Self, ciSearchPreviewActionPerformed, nil);
    end;

end;

{@TppCustomSearchPreview.BeginElapsedTime }

procedure TppCustomSearchPreview.BeginElapsedTime;
begin
  FElapsedStartTime := Time;
  FSearchOperationInMilliseconds := 0;
end;

{@TppCustomSearchPreview.EndElapsedTime }

procedure TppCustomSearchPreview.EndElapsedTime;
var
  lHours: Word;
  lMinutes: Word;
  lSeconds: Word;
  lMilliseconds: Word;
  ldDeltaTime: TDateTime;
  ldEndTime: TDateTime;
begin
  ldEndTime := Time;

  ldDeltaTime := ldEndTime - FElapsedStartTime;

  DecodeTime(ldDeltaTime, lHours, lMinutes, lSeconds, lMilliseconds);

  FSearchOperationInMilliseconds := (((((lHours * 60) + lMinutes) * 60) + lSeconds) * 1000) + lMilliseconds;
end;

{@TppCustomSearchPreview.FinishOperation }

procedure TppCustomSearchPreview.FinishOperation(aSearchType: TppTextSearchType);
begin
  if not(aSearchType = stCancel) and Cancelled then
    begin
      DoneSearching;

      UpdateControls;
    end;
end;

{@TppCustomSearchPreview.Search

  This routine is called after the search button is pressed. A search action is
  triggered which will cause the search Engine to search through all of the
  cached page until it finds ths first Occurrence.  If there are pages left to be
  generated, the engine doesn't generate them until all of the occurrences
  in the current cache have been traversed in the preview.}

function TppCustomSearchPreview.Search: Boolean;
begin

  Result := False;

  if ShouldPerformSearch then
    begin
      SearchingPage := True;

      ControlsToSettings;

      FSearchEngine.Reset;

      FPageNavigationClicked := False;

      SettingsToEngine;
      
      FSearchIndex := -1;

      if TextSearchSettings.SearchFromCurrentPage then
        FStartingPageNo := Viewer.CurrentPage.AbsolutePageNo
      else
        FStartingPageNo := 1;

      FSearchEngine.StartingPageNo := FStartingPageNo;

      BroadcastChanges := False;

      UpdateControls;

      Result := FSearchEngine.Search(FSearchText);

      FTextSearchSettingsChanged := False;

      BroadcastChanges := True;

      SearchingPage := False;
    end
  else if (FSearchEngine.TotalFound > 0) then
    GotoFirst;

  if not(Cancelled) then
    begin

      if not(Result) then
        begin
          BroadcastChanges := False;

          RefreshPage;

          BroadcastChanges := True;
        end
      else if FGotoFirst then
        GoToFirst;

    end;

end;

{@TppCustomSearchPreview.Refresh}

procedure TppCustomSearchPreview.Refresh;
begin

  if (FSearchText <> '') then
    begin
      SettingsToEngine;

      HighlightPage;

      FSearchIndex := FSearchEngine.CurrentSearchIndex;
    end;

end;

{@TppCustomSearchPreview.ShouldPerformSearch }

function TppCustomSearchPreview.ShouldPerformSearch: Boolean;
begin

  if FTextSearchSettingsChanged or
     FPageNavigationClicked or
     TextSearchSettings.SearchWhenPreview or
     (FSearchEngine.TotalFound = 0) or
     (not(FSearchEngine.AllPagesSearched) and FSearchEngine.SearchToLastPage) then
    Result := True
  else
    Result := False;

end;

{@TppCustomSearchPreview.SettingsToEngine }

procedure TppCustomSearchPreview.SettingsToEngine;
begin
  FSearchEngine.TextSearchSettings := TextSearchSettings;
  FSearchEngine.Viewer := Viewer;
end;

{@TppCustomSearchPreview.GotoFirst }

procedure TppCustomSearchPreview.GotoFirst;
begin

  if not(Cancelled) then
    begin
      FSearchEngine.FirstDrawCommand;

      Application.ProcessMessages;

      if not(Cancelled) then
        NavigateToThePage(FSearchEngine.CurrentPageNo);

      Application.ProcessMessages;

      if not(Cancelled) then
        HighlightPage;

      FSearchIndex := 0;
    end;

end;

{@TppCustomSearchPreview.GotoPrior }

procedure TppCustomSearchPreview.GotoPrior;
begin

  if not(Cancelled) then
    begin

      if not(IsFirstDrawCommand) then
        begin
          FSearchEngine.PriorDrawCommand;

          NavigateToThePage(FSearchEngine.CurrentPageNo);

          HighlightPage;

          Dec(FSearchIndex);
        end;
        
    end;

end;

{@TppCustomSearchPreview.GotoNext }

procedure TppCustomSearchPreview.GotoNext;
begin

  if IsLastDrawCommand and not(FSearchEngine.AllPagesSearched) then
    FSearchEngine.NavigateForwardToNextOccurrence(FSearchText);

  Application.ProcessMessages;

  if not(Cancelled) then
    begin

      if not(IsLastDrawCommand) then
        begin
          FSearchEngine.NextDrawCommand;

          NavigateToThePage(FSearchEngine.CurrentPageNo);

          HighlightPage;

          Inc(FSearchIndex);
        end;

    end;

end;

{@TppCustomSearchPreview.GotoLast }

procedure TppCustomSearchPreview.GotoLast;
begin

  if not(FSearchEngine.AllPagesSearched) then
    FSearchEngine.NavigateForwardToLastOccurrence(FSearchText);

  Application.ProcessMessages;

  if not(Cancelled) then
    begin
      FSearchEngine.LastDrawCommand;

      NavigateToThePage(FSearchEngine.CurrentPageNo);

      HighlightPage;

      FSearchIndex := FSearchEngine.TotalFound - 1;
    end;

end;

{@TppCustomSearchPreview.PerfomSearchWhenPreview

  When the SearchWhenPreview property is true, this method gets called
  to cause the first page to be searched when it is rendered using the default
  search text string. At this point the first page has been generated and the
  screen device is about to display it, so let's highlight it.}

procedure TppCustomSearchPreview.PerfomSearchWhenPreview;
begin

  FSearchEngine.SearchToLastPage := True;

  PerformSearchOperation(stSearch);

  if (FSearchEngine.TotalFound > 0) then
    begin
      BroadcastChanges := False;

      FSearchEngine.EraseHighlights;

      FSearchEngine.FirstDrawCommand;

      if (FViewer.ScreenDevice.Publisher <> nil) then
        FViewer.ScreenDevice.EndJob;

      NavigateToThePage(FSearchEngine.CurrentPageNo);

      FSearchEngine.HighlightPage(Viewer.CurrentPage);

      FLastPageNoHighlighted := Viewer.CurrentPage.AbsolutePageNo;

      FSearchIndex := 0;

      BroadcastChanges := True;
    end;

  UpdateControls;

end;

{@TppCustomSearchPreview.Reset }

procedure TppCustomSearchPreview.Reset;
begin
  FTextSearchStates := FTextSearchStates - [seCancelled, seSearchingPage];

  DeactivateSearch;

  FIgnorePageChanges := False;
  FSearchIndex := -1;
  FSearchText := '';
  FStartingPageNo := 1;
  FPageNavigationClicked := False;

  FSearchEngine.Reset;
end;

{@TppCustomSearchPreview.DoneSearching }

procedure TppCustomSearchPreview.DoneSearching;
begin
  {do this first so that the cancel isn't shown when pressing done}
  UpdateControls;

  Reset;

  RefreshPage;
end;

{@TppCustomSearchPreview.InternalCancel }

procedure TppCustomSearchPreview.InternalCancel;
begin

  FTextSearchStates := FTextSearchStates + [seCancelled];

  DeactivateSearch;

  FSearchEngine.CancelSearch;

  UpdateControls;

  RefreshPage;

end;

{@TppCustomSearchPreview.IsFirstDrawCommand

  Returns true if the current highlight draw command is the first draw command
  occurrence.}

function TppCustomSearchPreview.IsFirstDrawCommand: Boolean;
begin
  if (FSearchIndex <= 0) then
    Result := True
  else
    Result := False;
end;

{@TppCustomSearchPreview.IsLastDrawCommand

  Returns true if the current draw command in the engine is the last one
  in the search FSearchEngine's list (last occurrence).

  It may be possible that there are more
  pages to be searched, so this can be true, even if more text is found on
  subsequent pages. When LastDrawCommand is true and Engine.AllPagesSearched is
  true, then that is the last draw command which is ever going to be highlighted
  for the current report.}

function TppCustomSearchPreview.IsLastDrawCommand: Boolean;
begin
  if (FSearchEngine.TotalFound  > 0) and ((FSearchIndex + 1) = FSearchEngine.TotalFound) then
    Result := True
  else
    Result := False;
end;

{@TppCustomSearchPreview.HandleError }

procedure TppCustomSearchPreview.HandleError(E: ESearchError);
begin

  Application.HandleException(Self);

  PerformSearchOperation(stCancel);

  Busy := False;

end;

{@TppCustomSearchPreview.LanguageChanged }

procedure TppCustomSearchPreview.LanguageChanged;
begin

end;

{@TppCustomSearchPreview.GetEngineClass }

function TppCustomSearchPreview.GetEngineClass: String;
begin
  Result := 'Full Search';
end;

{@TppCustomSearchPreview.GetActiveSearch }

function TppCustomSearchPreview.GetActiveSearch: Boolean;
begin
  Result := seActiveSearch in FTextSearchStates;
end;
    
{@TppCustomSearchPreview.GetCancelled }

function TppCustomSearchPreview.GetCancelled: Boolean;
begin
  Result := seCancelled in FTextSearchStates;
end;
   
{@TppCustomSearchPreview.GetSearchingPage }

function TppCustomSearchPreview.GetSearchingPage: Boolean;
begin
  Result := seSearchingPage in FTextSearchStates;
end;

{@TppCustomSearchPreview.SetSearchingPage }

procedure TppCustomSearchPreview.SetSearchingPage(aSearchingPage: Boolean);
begin
  if aSearchingPage then
    FTextSearchStates := FTextSearchStates + [seSearchingPage]
  else
    FTextSearchStates := FTextSearchStates - [seSearchingPage];
end;
      
{@TppCustomSearchPreview.SetBusy }

procedure TppCustomSearchPreview.SetBusy(aBusy: Boolean);
begin

  if aBusy and not(FBusy) then
    begin
      FBusy := True;

      FSaveCursor := Screen.Cursor;

      Screen.Cursor := crHourGlass;
    end
  else if not(aBusy) and (FBusy) then
    begin
      FBusy := False;

      Screen.Cursor := FSaveCursor;
    end;

end;

{@TppCustomSearchPreview.UpdateControls }

procedure TppCustomSearchPreview.UpdateControls;
begin

  if (FViewer.ScreenDevice.Publisher <> nil) and FViewer.ScreenDevice.Publisher.ReportCompleted then
    UpdateStatusText(Viewer.CurrentPage.PageSetDescription)
  else
    UpdateStatusText(Viewer.CurrentPage.PageNoDescription);

end;

{@TppCustomSearchPreview.CloseSearchPreview

  When the user selects the cancel button in the main toolbar, the report is
  finished and no more pages can be requested from thereport. The search preview
  will also be closed and disabled at this point because the repor engine can't
  send the requested pages.}

procedure TppCustomSearchPreview.CloseSearchPreview;
var
  liIndex: Integer;
begin

  FSearchPanel.Enabled := False;

  for liIndex := 0 to FSearchPanel.ControlCount - 1 do
    FSearchPanel.Controls[liIndex].Enabled := False;

  UpdateControls;

end;
     
{@TppCustomSearchPreview.Cancel

  Call this routine to stop the search preview dead in its tracks such as
  when the designer changes tabs when the search is still active.}

procedure TppCustomSearchPreview.Cancel;
begin
  FPerformingCancel := True;

  PerformSearchOperation(stCancel);

  FPerformingCancel := False;
end;

{@TppCustomSearchPreview.Initialize

  Call this routine to prepare the search preview when the designer changes
  to the preview tab.}

procedure TppCustomSearchPreview.Initialize;
begin
  InternalInitialize;
end;

procedure TppCustomSearchPreview.InitializeStatusBar;
var
  liIndex: Integer;
begin

  if (FStatusBarTbx <> nil) then
    begin
      if FStatusBarTbx.SimplePanel then
        FStatusBarTbx.SimplePanel := False;

      for liIndex := 1 to 2 do
        if FStatusBarTbx.Panels.Count < liIndex  then
          begin
            FStatusBarTbx.Panels.Add;
            FStatusBarTbx.Panels[0].Width := 275;
          end;

      if FViewer.DesignViewer then
        FStatusBarTbx.Panels[1].Text := '';

    end;

  // legacy status bar
  if (FStatusBar <> nil) then
    begin
      if FStatusBar.SimplePanel then
        FStatusBar.SimplePanel := False;

      for liIndex := 0 to 1 do
        if FStatusBar.Panels.Count <= liIndex  then
          begin
            FStatusBar.Panels.Add;
            FStatusBar.Panels[liIndex].Width := 275;
          end;

    end;


end;

{@TppCustomSearchPreview.InternalInitialize

  Allow descendents to override in order to prepare for a new report to search.}

procedure TppCustomSearchPreview.InternalInitialize;
begin
  Reset;

  FControlsEnabled := True;

  FSearchPanel.Enabled := True;
end;

{@TppCustomSearchPreview.SetTranslatedMinWidth

  Call this in descendents in order to help control the position of the splitter
  in the previewer for the outline viewer's min width.}

procedure TppCustomSearchPreview.SetTranslatedMinWidth(aTranslatedMinWidth: Integer);
begin
  FTranslatedMinWidth := aTranslatedMinWidth;
end;

procedure TppCustomSearchPreview.SetOnKeyDown(aOnKeyDown: TKeyEvent);
begin
  FOnKeyDown := aOnKeyDown;
end;

procedure TppCustomSearchPreview.UpdateStatusText(aStatus: String);
begin
  if FStatusBar <> nil then
    FStatusBar.Panels[0].Text := aStatus;

  if FStatusBarTbx <> nil then
    FStatusBarTbx.Panels[0].Text := aStatus;

end;

end.
