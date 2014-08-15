{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchEngine;

interface

uses
  Classes, Graphics,
  ppTextSearchCustomEngine,
  ppDevice, ppViewr, ppTypes, ppDrwCmd, ppComm,
  ppTextSearchOccurrence, ppTextSearchPage, ppTextSearchPageList, ppTextSearchToolbox;

type

  {@TppTextSearchEngine

    The engine which searches all TppDrawText objects and all of its
    descendents. It uses a TppPageSarchList object to help it manage the search
    occurrences for each page. It also uses this list to navigate the
    occurrences to provide information when the user interface classes ask
    for it.}

  TppTextSearchEngine = class(TppTextSearchCustomEngine)
    private
      FCursorDrawCommand: TppDrawCommand;
      FLineHeight: Integer;
      FCurrentSearchOccurrenceIndex: Integer;
      FSearchOccurrenceForSingleHighlight: TppTextSearchOccurrence;
      FSearchOccurrence: TppTextSearchOccurrence;
      FPageSearchList: TppTextSearchPageList;
      FPreviousHighlightPageNo: Integer;

      procedure CreateEntirePageHighlights(aPage: TppPage);
      function CreatePageSearch(aPage: TppPage; const aSearchText: String): TppTextSearchPage;
      procedure CreateSingleHighlight(aPage: TppPage);
      function NextSearchOccurrence: TppTextSearchOccurrence;
      procedure ResetToTopOfPage(aPageNo: Integer);
      function GetCurrentSearchOccurrence: TppTextSearchOccurrence;
      function GetCurrentDrawCommandIndex: Integer;
      function GetCurrentPageSearch: TppTextSearchPage;
      procedure TransferDrawCommandSearchListToPageSearch(aSearchOccurrenceList: TList; aPageSearch: TppTextSearchPage);

    protected
      function GetCurrentPageNo: Integer; override;
      function GetCurrentSearchIndex: Integer; override;
      function GetFirstPageFound: Integer; override;
      function GetTotalFound: Integer; override;

      procedure BeforeCreateSingleHighlight(aDrawCommand: TppDrawCommand; aSearchOccurrence: TppTextSearchOccurrence); virtual;
      procedure BeforeTraverseBackward; virtual;
      procedure BeforeTraverseForward; virtual;
      procedure BuildSearchOccurrenceList(aDrawCommand: TppDrawCommand; aDrawCommandIndex: Integer; const aSearchText: String; aSearchOccurrenceList: TList); virtual;
      procedure CreateSearchOccurrence(aDrawCommand: TppDrawCommand; aDrawCommandIndex: Integer; var aOriginalText: String; const aSearchText: String; aLineNumber, aPreviousCountSearched: Integer; var aFoundPos: Integer; aSearchOccurrenceList: TList); virtual;

      procedure FreeCursorDrawCommand;

      property CurrentSearchOccurrence: TppTextSearchOccurrence read GetCurrentSearchOccurrence;
      property CurrentDrawCommandIndex: Integer read GetCurrentDrawCommandIndex;
      property CurrentPageSearch: TppTextSearchPage read GetCurrentPageSearch;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function Description: String; override;
      
      procedure Reset; override;
      procedure ResetSearchIndex(aIndex: Integer); override;
      function FirstDrawCommand: Boolean; override;
      function LastDrawCommand: Boolean; override;
      function NextDrawCommand: Boolean; override;
      function PriorDrawCommand: Boolean; override;
      procedure HighlightPage(aPage: TppPage); override;
      procedure GoToPage(aPageNo: Integer); override;
      function Search(const aSearchText: String): Boolean; override;
      function SearchPage(aPage: TppPage; const aSearchText: String): Boolean; override;

    end;

implementation

uses
  SysUtils, Dialogs, Forms, ppUtils,
  ppTextSearchError, ppClass, ppTextSearchDrawCommandHighlightRegistry;

{@TppTextSearchEngine.Create }

constructor TppTextSearchEngine.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FCursorDrawCommand := nil;
  FCurrentSearchOccurrenceIndex := 0;
  FSearchOccurrenceForSingleHighlight := nil;
  FSearchOccurrence := nil;
  FPageSearchList := TppTextSearchPageList.Create(nil);
  FPreviousHighlightPageNo := 0;
  FLineHeight := 0;

end;

{@TppTextSearchEngine.Destroy }

destructor TppTextSearchEngine.Destroy;
begin

  FPageSearchList.Free;

  inherited Destroy;

end;

{@TppTextSearchEngine.Description }

class function TppTextSearchEngine.Description: String;
begin
  Result := 'Standard Search';
end;

{@TppTextSearchEngine.Search

  Finds all occurrences of the search text in the page.}

function TppTextSearchEngine.Search(const aSearchText: String): Boolean;
begin

  ScreenDeviceActive := False;

  Result := inherited Search(aSearchText);

  if Result then
    begin
      SearchText := aSearchText;

      FPageSearchList.Reset;

      Result := SearchPages;
    end;

  ScreenDeviceActive := True;

  if Result and (GotoPageNo <> Viewer.CurrentPage.AbsolutePageNo) then
    Viewer.GotoPage(GotoPageNo);

end;

{@TppTextSearchEngine.SearchPage

  Searches the page object. If this page already has been searched and a page info
  object exists in the page info list, then the page is skipped.}

function TppTextSearchEngine.SearchPage(aPage: TppPage; const aSearchText: String): Boolean;
var
  lPageSearch: TppTextSearchPage;
begin

  SearchText := aSearchText;

  Result := inherited SearchPage(aPage, aSearchText);

  if Result then
    begin

      if (aPage = nil) then
        raise ESearchEngineError.Create('TppSearchEngine.Search: Must pass a non-nil page object from page cache.');

      if (FPageSearchList.IndexOfPageNumber(aPage.AbsolutePageNo) = -1) then
        begin
          InternalAllPagesSearched := aPage.LastPage;

          lPageSearch := CreatePageSearch(aPage, aSearchText);

          if (lPageSearch <> nil) then
            begin
              if (GotoPageNo = -1) then
                GotoPageNo := aPage.AbsolutePageNo + 1;

              FPageSearchList.AddPage(lPageSearch);

              {notify preview form to update search statistics}
              SendEventNotify(Self, ciNewSearchOccurrence, nil);

              Result := True;
            end
          else
            Result := False;

        end;

    end;

end;
 
{@TppTextSearchEngine.Reset }

procedure TppTextSearchEngine.Reset;
begin

  inherited Reset;

  FPageSearchList.Reset;

  InternalAllPagesSearched := False;
  SearchText := '';
  FCurrentSearchOccurrenceIndex := 0;
  FSearchOccurrenceForSingleHighlight := nil;
  FSearchOccurrence := nil;
  GotoPageNo := -1;
  FPreviousHighlightPageNo := 0;
  FLineHeight := 0;

end;

{@TppTextSearchEngine.ResetSearchIndex }

procedure TppTextSearchEngine.ResetSearchIndex(aIndex: Integer);
begin
  FPageSearchList.ResetSearchIndex(aIndex);

  FCurrentSearchOccurrenceIndex := FPageSearchList.CurrentOccurrenceIndex;
end;

{@TppTextSearchEngine.CreatePageSearch }

function TppTextSearchEngine.CreatePageSearch(aPage: TppPage; const aSearchText: String): TppTextSearchPage;
var
  liIndex: Integer;
  lDrawCommand: TppDrawCommand;
  lSearchOccurrenceList: TList;
  lPageSearch: TppTextSearchPage;
begin

  lSearchOccurrenceList := nil;
  lPageSearch := nil;

  try
    lSearchOccurrenceList := TList.Create;

    liIndex := 0;

    while (liIndex < aPage.DrawCommandCount) and not(Cancelled) do
      begin
        lDrawCommand := TppDrawCommand(aPage.DrawCommands[liIndex]);

        if (TppTextSearchDrawCommandHighlightRegistry.IsRegistered(TppDrawCommandClass(lDrawCommand.ClassType))) and not(Cancelled) then
          begin

            BuildSearchOccurrenceList(lDrawCommand, liIndex, aSearchText, lSearchOccurrenceList);

            {page search gets created if draw command search info list is not empty, otherwise result is nil and it isn't added to the page search list}
            if (lSearchOccurrenceList.Count > 0) and not(Cancelled) then
              begin
                if (lPageSearch = nil) then
                  begin
                    lPageSearch := TppTextSearchPage.Create(nil);

                    {notify preview form to update search statistics}
                    SendEventNotify(Self, ciNewSearchOccurrence, nil);
                  end;

                TransferDrawCommandSearchListToPageSearch(lSearchOccurrenceList, lPageSearch);

              end;

            lSearchOccurrenceList.Clear;
          end;

        Inc(liIndex);

        Application.ProcessMessages;

      end;

    lSearchOccurrenceList.Free;
    lSearchOccurrenceList := nil;

    if (lPageSearch <> nil) then
      begin
        if not(Cancelled) then
          begin
            lPageSearch.PageNo := aPage.AbsolutePageNo;
            lPageSearch.Sort;
          end
        else
          begin
            lPageSearch.Free;
            lPageSearch := nil;
          end
      end;

  except
    on E: ESearchEngineError  do
      begin

        if lSearchOccurrenceList <> nil then
          lSearchOccurrenceList.Free;

        if lPageSearch <> nil then
          begin
            lPageSearch.Free;
            lPageSearch := nil;
          end;

      end;

  end;

  Result := lPageSearch;

end;

{@TppTextSearchEngine.TransferDrawCommandSearchListToPageSearch }

procedure TppTextSearchEngine.TransferDrawCommandSearchListToPageSearch(aSearchOccurrenceList: TList; aPageSearch: TppTextSearchPage);
var
  liSearchOccurrenceIndex: Integer;
  lSearchOccurrence: TppTextSearchOccurrence;
  liCount: Integer;
begin

  liSearchOccurrenceIndex := 0;

  liCount := aSearchOccurrenceList.Count;

  {transfer list of draw command search objects to the page search object}
  while (liSearchOccurrenceIndex < liCount) and not(Cancelled) do
    begin
      lSearchOccurrence := TppTextSearchOccurrence(aSearchOccurrenceList[0]);

      aPageSearch.AddOccurrence(lSearchOccurrence);

      {notify preview form to update search statistics}
      SendEventNotify(Self, ciNewSearchOccurrence, nil);

      aSearchOccurrenceList.Delete(0);

      Inc(liSearchOccurrenceIndex);

      Application.ProcessMessages;
    end;

end;

{@TppTextSearchEngine.BuildSearchOccurrenceList

  Searches the draw command and builds the draw command info list for the
  draw command which is passed.

  Override to search additional draw command classes by checking the class type
  of the draw command. This routine only called if the draw command has a draw
  command highlighter registered.}

procedure TppTextSearchEngine.BuildSearchOccurrenceList(aDrawCommand: TppDrawCommand; aDrawCommandIndex: Integer; const aSearchText: String; aSearchOccurrenceList: TList);
var
  liLength: Integer;
  lDrawText: TppDrawText;
  lsText: String;
  liFoundPos: Integer;
  liIndex: Integer;
begin

  if not(aDrawCommand is TppDrawText) then
    raise ESearchEngineError.Create('TppDrawTextSearchEngine.BuildSearchOccurrenceList: The draw command is a ' + aDrawCommand.ClassName + ' not a TppDrawText.');

  lDrawText := TppDrawText(aDrawCommand);

  FLineHeight := TppTextSearchToolboxRegistry.GetToolboxPlugin.CalculateLineHeight(lDrawText, Canvas, ScaleY);

  liFoundPos := 0;
  liLength := 0;

  if (lDrawText.IsMultiLine) then
    begin
      for liIndex := 0 to lDrawText.WrappedText.Count - 1 do
        begin
          lsText := lDrawText.WrappedText[liIndex];

          CreateSearchOccurrence(lDrawText, aDrawCommandIndex, lsText, aSearchText, liIndex + 1, liLength, liFoundPos, aSearchOccurrenceList);

          liLength := liLength + Length(lsText);
        end;

    end

  else
    begin
      lsText := lDrawText.Text;

      CreateSearchOccurrence(lDrawText, aDrawCommandIndex, lsText, aSearchText, 1, liLength, liFoundPos, aSearchOccurrenceList);
    end;

end;

{@TppTextSearchEngine.CreateSearchOccurrence

  Override to search additional draw commands classes.}

procedure TppTextSearchEngine.CreateSearchOccurrence(aDrawCommand: TppDrawCommand; aDrawCommandIndex: Integer; var aOriginalText: String; const aSearchText: String; aLineNumber, aPreviousCountSearched: Integer; var aFoundPos: Integer; aSearchOccurrenceList: TList);
var
  liFoundPos: Integer;
  lSearchOccurrence: TppTextSearchOccurrence;
  lTextSearchToolbox: TppTextSearchToolboxClass;
  liOccurrences: Integer;
begin

  lTextSearchToolbox := TppTextSearchToolboxRegistry.GetToolboxPlugin;

  lTextSearchToolbox.SearchLine(aOriginalText, aSearchText, CaseSensitive, WholeWord, aFoundPos);

  if (aFoundPos <> 0) then
    lSearchOccurrence := TppTextSearchOccurrence.Create(nil)
  else
    lSearchOccurrence := nil;

  liOccurrences := 0;
  liFoundPos := 0;

  while (lSearchOccurrence <> nil) and not(Cancelled) do
    begin
      Inc(liOccurrences);

      liFoundPos := liFoundPos + aFoundPos;

      lSearchOccurrence.DrawCommandIndex := aDrawCommandIndex;
      lSearchOccurrence.OccurrenceIndex := liOccurrences;
      lSearchOccurrence.LineNumber := aLineNumber;
      lSearchOccurrence.StartCharPosition := aPreviousCountSearched + liFoundPos;
      lSearchOccurrence.Top := aDrawCommand.Top + (FLineHeight * (aLineNumber - 1));
      lSearchOccurrence.Left := aDrawCommand.Left + liOccurrences;

      {trim the front of the text to make search incremental in string from [0]}
      aOriginalText := Copy(aOriginalText, aFoundPos + Length(aSearchText), Length(aOriginalText));

      aSearchOccurrenceList.Add(lSearchOccurrence);

      {search the line again for more Occurrences}
      lTextSearchToolbox.SearchLine(aOriginalText, aSearchText, CaseSensitive, WholeWord, aFoundPos);

      if (aFoundPos <> 0) then
        lSearchOccurrence := TppTextSearchOccurrence.Create(nil)
      else
        lSearchOccurrence := nil;

      {check for cancel}
      Application.ProcessMessages;
    end;

end;

{@TppTextSearchEngine.HighlightPage }

procedure TppTextSearchEngine.HighlightPage(aPage: TppPage);
var
  liCurrentPageNo: Integer;
begin

  inherited HighlightPage(aPage);

  if (aPage = nil) then
    raise ESearchHighlightError.Create('TppSearchPreview.HighlightCurrentDrawCommand: Must have a non nil page object to search within');

  if (FPageSearchList.IndexOfPageNumber(aPage.AbsolutePageNo) <> -1) then
    begin

      if ShowAll then
        begin
          if (FPageSearchList.CurrentPageNo <> aPage.AbsolutePageNo) then
            FPageSearchList.GotoPage(aPage.AbsolutePageNo);

          {get the current draw command info index on that page}
          FCurrentSearchOccurrenceIndex := FPageSearchList.CurrentOccurrenceIndex;

          liCurrentPageNo := aPage.AbsolutePageNo;

          if not(Cancelled) then
            ResetToTopOfPage(liCurrentPageNo);

          if not(Cancelled) then
            CreateEntirePageHighlights(aPage);

          if not(Cancelled) then
            ResetToTopOfPage(liCurrentPageNo);
        end
      else
        CreateSingleHighlight(aPage);

      if not(Cancelled) then
        begin
          AddHighlightDrawCommandsToPage(aPage);
          //Try to scroll to the correct position on the page.
          if not(ShowAll) and (FCursorDrawCommand <> nil)then
            Viewer.ScrollBox.VertScrollBar.Position := Trunc(ppFromMMThousandths(FCursorDrawCommand.Top, utScreenPixels, Screen.PixelsPerInch));
        end;
    end;



  if Cancelled then
    EraseHighlights;

end;

{@TppTextSearchEngine.ResetToTopOfPage }

procedure TppTextSearchEngine.ResetToTopOfPage(aPageNo: Integer);
begin
  FPageSearchList.GoToPage(aPageNo);
  FSearchOccurrence := FPageSearchList.CurrentOccurrence;
end;

{@TppTextSearchEngine.CreateEntirePageHighlights }

procedure TppTextSearchEngine.CreateEntirePageHighlights(aPage: TppPage);
var
  liIndex: Integer;
  lCurrentPageSearch: TppTextSearchPage;
  lDrawCommandToFind: TppDrawCommand;
begin

  lCurrentPageSearch := FPageSearchList[FPageSearchList.CurrentTextSearchPageIndex];

  liIndex := 0;

  while not(Cancelled) and (liIndex < lCurrentPageSearch.OccurrenceCount) do
    begin
      if (FSearchOccurrence.DrawCommandIndex >= aPage.DrawCommandCount) then
        raise ESearchEngineError.Create('TppTextSearchEngine.CreateEntirePageHighlights: The draw command info list is out of sync with the current viewer''s page.');

      lDrawCommandToFind := aPage[FSearchOccurrence.DrawCommandIndex];

      CreateHighlightDrawCommand(lDrawCommandToFind, FSearchOccurrence);

      if not(Cancelled) then
        begin
          FSearchOccurrence := NextSearchOccurrence;

          Inc(liIndex);

          Application.ProcessMessages;
        end;
    end;

end;

{@TppTextSearchEngine.NextSearchOccurrence }

function TppTextSearchEngine.NextSearchOccurrence: TppTextSearchOccurrence;
begin

  Result := FPageSearchList.NextOccurrence;

  {when highlighting the last page, stop on the last info}
  if (Result = nil) then
    Result := FPageSearchList.LastOccurrence;

end;

{@TppTextSearchEngine.CreateSingleHighlight }

procedure TppTextSearchEngine.CreateSingleHighlight(aPage: TppPage);
var
  lsMessage: String;
  lDrawCommandFromPage: TppDrawCommand;
begin

  if (aPage = nil) then
    raise ESearchEngineError.Create('TppTextSearchEngine.CreateSingleHighlight: aPage parameter is nil.');

  if (FSearchOccurrence = nil) then
    begin
      lsMessage := 'TppTextSearchEngine.CreateSingleHighlight: ';
      lsMessage := lsMessage + 'Current draw command info is nil.  The search engine is trying to highlight a draw command which should not in the highlight draw command list.';
      lsMessage := lsMessage + 'The list needs to be reset for this page and the page needs to be researched and highlighted';

      raise ESearchEngineError.Create(lsMessage);
    end;

  FCursorDrawCommand := nil;

  if (FSearchOccurrence.DrawCommandindex = -1) then
    raise ESearchEngineError.Create('TppTextSearchEngine.CreateSingleHighlight: SearchOccurrence.DrawCommandIndex is not assigned.');

  lDrawCommandFromPage := aPage[FSearchOccurrence.DrawCommandIndex];

  {allow descendents a chance to do something right before a new single highlight is created}
  BeforeCreateSingleHighlight(lDrawCommandFromPage, FSearchOccurrence);

  FCursorDrawCommand := CreateHighlightDrawCommand(lDrawCommandFromPage, FSearchOccurrence);

end;
 
{@TppTextSearchEngine.BeforeCreateSingleHighlight }

procedure TppTextSearchEngine.BeforeCreateSingleHighlight(aDrawCommand: TppDrawCommand; aSearchOccurrence: TppTextSearchOccurrence);
begin

end;

{@TppTextSearchEngine.BeforeTraverseForward }

procedure TppTextSearchEngine.BeforeTraverseForward;
begin

end;

{@TppTextSearchEngine.BeforeTraverseBackward }

procedure TppTextSearchEngine.BeforeTraverseBackward;
begin

end;

{@TppTextSearchEngine.NextDrawCommand }

function TppTextSearchEngine.NextDrawCommand: Boolean;
begin
  BeforeTraverseForward;

  FSearchOccurrence := FPageSearchList.NextOccurrence;

  FSearchOccurrenceForSingleHighlight := FSearchOccurrence;

  Result := (FSearchOccurrence <> nil);
end;

{@TppTextSearchEngine.GoToPage }

procedure TppTextSearchEngine.GoToPage(aPageNo: Integer);
begin
  if (aPageNo > FPageSearchList.CurrentPageNo) then
    BeforeTraverseForward
  else
    BeforeTraverseBackward;

  FPageSearchList.GotoPage(aPageNo);

  FSearchOccurrence := FPageSearchList.CurrentOccurrence;

  FSearchOccurrenceForSingleHighlight := FSearchOccurrence;
end;

{@TppTextSearchEngine.PriorDrawCommand }

function TppTextSearchEngine.PriorDrawCommand: Boolean;
begin
  BeforeTraverseBackward;

  FSearchOccurrence := FPageSearchList.PriorOccurrence;

  FSearchOccurrenceForSingleHighlight := FSearchOccurrence;

  Result := (FSearchOccurrence <> nil);
end;

{@TppTextSearchEngine.FirstDrawCommand }

function TppTextSearchEngine.FirstDrawCommand: Boolean;
begin
  BeforeTraverseBackward;

  FSearchOccurrence := FPageSearchList.FirstOccurrence;

  FSearchOccurrenceForSingleHighlight := FSearchOccurrence;

  Result := (FSearchOccurrence <> nil);
end;

{@TppTextSearchEngine.LastDrawCommand }

function TppTextSearchEngine.LastDrawCommand: Boolean;
begin
  BeforeTraverseForward;

  FSearchOccurrence := FPageSearchList.LastOccurrence;

  FSearchOccurrenceForSingleHighlight := FSearchOccurrence;

  Result := (FSearchOccurrence <> nil);
end;

{@TppTextSearchEngine.GetCurrentPageNo }

function TppTextSearchEngine.GetCurrentPageNo: Integer;
begin
  Result := FPageSearchList.CurrentPageNo;
end;
   
{@TppTextSearchEngine.GetCurrentSearchIndex }

function TppTextSearchEngine.GetCurrentSearchIndex: Integer;
begin
  Result := FPageSearchList.CurrentSearchIndex;
end;

{@TppTextSearchEngine.GetTotalFound }

function TppTextSearchEngine.GetTotalFound: Integer;
begin
  Result := FPageSearchList.TotalFoundCount;
end;

{@TppTextSearchEngine.GetFirstPageFound }

function TppTextSearchEngine.GetFirstPageFound: Integer;
begin
  Result := GotoPageNo;
end;

{@TppTextSearchEngine.FreeCursorDrawCommand

  When searching, it may be desireable as an engine to not show the highlight
  draw command when a search is performed, in order to support ShowAll with or
  without a cursor. The default engine does not add the cursor highlight draw
  command to the page when ShowAll is true.}

procedure TppTextSearchEngine.FreeCursorDrawCommand;
begin
  if (FCursorDrawCommand <> nil) then
    begin
      FCursorDrawCommand.Free;
      FCursorDrawCommand := nil;
    end;
end;

{@TppTextSearchEngine.GetCurrentOccurrence }

function TppTextSearchEngine.GetCurrentSearchOccurrence: TppTextSearchOccurrence;
begin
  Result := FPageSearchList.CurrentOccurrence;
end;

{@TppTextSearchEngine.GetCurrentDrawCommandIndex }

function TppTextSearchEngine.GetCurrentDrawCommandIndex: Integer;
begin
  Result := FPageSearchList.CurrentDrawCommandIndex;
end;
  
{@TppTextSearchEngine.GetCurrentPageSearch }

function TppTextSearchEngine.GetCurrentPageSearch: TppTextSearchPage;
begin
  if (FPageSearchList.CurrentTextSearchPageIndex <> -1) then
    Result := FPageSearchList[FPageSearchList.CurrentTextSearchPageIndex]
  else
    Result := nil;
end;

end.
