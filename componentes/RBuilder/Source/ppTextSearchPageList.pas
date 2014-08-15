{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchPageList;

interface

uses
  Classes,
  ppComm, ppTypes, ppDevice,
  ppTextSearchPage,
  ppTextSearchOccurrence;


type

  {@TppTextSearchPageList

    Provides a list of TextSearchPage objects.  Also tracks the current draw command
    as the list is traversed via the First, Last, Next, and Prior
    DrawCommandSearchOccurrence navigation functions.}

  {@TppTextSearchPageList.CurrentDrawCommandIndex

    Index on thepage for the draw command for which the draw command info is to
    be highlighting. This is also zero based relative to the page object.}

  {@TppTextSearchPageList.CurrentOccurrenceIndex

    This is the index starting at zero on the current page that the draw command
    info exists for. This is a page specfic index and resets to zero on every
    new page.}

  {@TppTextSearchPageList.CurrentSearchIndex

    Read only. Returns the current index that the search engine has positioned
    the page info list on when searching through the page info list. Read this
    value to see if the engine is out of sync with the search preview.

    Note: Use ResetSearchIndex to set the search index to a value.}

  TppTextSearchPageList = class(TppCommunicator)
    private
      FCurrentTextSearchPage: TppTextSearchPage;
      FCurrentOccurrenceIndex: Integer;
      FCurrentTextSearchPageIndex: Integer;
      FFreeingList: Boolean;
      FList: TList;
      FTotalFoundCount: Integer;

      function GetTextSearchPageCount: Integer;
      function GetTextSearchPageForIndex(aIndex: Integer): TppTextSearchPage;
      function GetTotalFoundCount: Integer;
      function NextTextSearchPage: TppTextSearchPage;
      function PriorTextSearchPage: TppTextSearchPage;
      function GetCurrentDrawCommandIndex: Integer;
      function GetCurrentPageNo: Integer;
      function GetCurrentOccurrenceIndex: Integer;
      function FirstTextSearchPage: TppTextSearchPage;
      function LastTextSearchPage: TppTextSearchPage;
      procedure FreeTextSearchpages;
      function GetCurrentTextSearchPageIndex: Integer;
      function GetCurrentSearchIndex: Integer;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      function GotoPage(aPageNo: Integer): TppTextSearchPage;
      procedure GotoOccurrence(aIndex: Integer);
      function IndexOfPageNumber(aPageNo: Integer): Integer;
      function NextOccurrence: TppTextSearchOccurrence;
      function PriorOccurrence: TppTextSearchOccurrence;
      function FirstOccurrence: TppTextSearchOccurrence;
      function LastOccurrence: TppTextSearchOccurrence;
      function CurrentOccurrence: TppTextSearchOccurrence;
      procedure AddPage(aTextSearchPage: TppTextSearchPage);
      procedure RemovePage(aTextSearchPage: TppTextSearchPage);
      procedure Reset;
      procedure ResetSearchIndex(aIndex: Integer);

      property CurrentPageNo: Integer read GetCurrentPageNo;
      property CurrentDrawCommandIndex: Integer read GetCurrentDrawCommandIndex;
      property CurrentOccurrenceIndex: Integer read GetCurrentOccurrenceIndex;
      property CurrentSearchIndex: Integer read GetCurrentSearchIndex;
      property CurrentTextSearchPageIndex: Integer read GetCurrentTextSearchPageIndex;
      property TextSearchPages[aIndex: Integer]: TppTextSearchPage read GetTextSearchPageForIndex; default;
      property TextSearchPageCount: Integer read GetTextSearchPageCount;
      property TotalFoundCount: Integer read GetTotalFoundCount;

    end;

implementation

uses
  SysUtils,
  ppTextSearchError;

{@TppTextSearchPageList.Create }

constructor TppTextSearchPageList.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FList := TList.Create;
  FTotalFoundCount := 0;
  FFreeingList := False;
  FCurrentTextSearchPageIndex := -1;
  FCurrentTextSearchPage := nil;
  FCurrentOccurrenceIndex := -1;

end;

{@TppTextSearchPageList.Destroy }

destructor TppTextSearchPageList.Destroy;
begin

  FreeTextSearchpages;

  FList.Free;

  inherited Destroy;

end;
      
{@TppTextSearchPageList.Notify }

procedure TppTextSearchPageList.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  liIndex: Integer;
begin

  inherited Notify(aCommunicator, aOperation);

  if not(FFreeingList) and (aOperation = ppopRemove) then
    begin

      liIndex := FList.IndexOf(aCommunicator);

      if (liIndex <> - 1) then
        raise ESearchError.Create('TppTextSearchPageList.Notify: Cannot free a TextSearchPage embedded object');

      if (aCommunicator = FCurrentTextSearchPage) then
        FCurrentTextSearchPage := nil;

    end;

end;

{@TppTextSearchPageList.FreeTextSearchpages }

procedure TppTextSearchPageList.FreeTextSearchpages;
var
  liIndex: Integer;
begin

  FTotalFoundCount := 0;

  FFreeingList := True;

  for liIndex := FList.Count - 1 downto 0 do
    TppTextSearchPage(FList[liIndex]).Free;

  FList.Clear;

  FFreeingList := False;

end;
         
{@TppTextSearchPageList.Reset }

procedure TppTextSearchPageList.Reset;
begin
  FreeTextSearchpages;

  FCurrentTextSearchPageIndex := -1;
  FCurrentTextSearchPage := nil;
  FCurrentOccurrenceIndex := -1;
end;
        
{@TppTextSearchPageList.GetTextSearchPageCount }

function TppTextSearchPageList.GetTextSearchPageCount: Integer;
begin
  Result := FList.Count;
end;

{@TppTextSearchPageList.GetTextSearchPageForIndex }

function TppTextSearchPageList.GetTextSearchPageForIndex(aIndex: Integer): TppTextSearchPage;
begin

  if (aIndex >= GetTextSearchPageCount) or (aIndex < 0) then
    Result := nil
  else
    Result := TppTextSearchPage(FList[aIndex]);

end;
       
{@TppTextSearchPageList.AddPage }

procedure TppTextSearchPageList.AddPage(aTextSearchPage: TppTextSearchPage);
begin

  if (aTextSearchPage <> nil) then
    aTextSearchPage.AddNotify(Self);

  FList.Add(aTextSearchPage);

end;

{@TppTextSearchPageList.RemovePage }

procedure TppTextSearchPageList.RemovePage(aTextSearchPage: TppTextSearchPage);
var
  liIndex: Integer;
begin

  if (aTextSearchPage <> nil) then
    aTextSearchPage.RemoveNotify(Self);

  liIndex := FList.IndexOf(aTextSearchPage);

  if (liIndex <> -1) then
    FList.Delete(liIndex);

end;

{@TppTextSearchPageList.NextOccurrence }

function TppTextSearchPageList.NextOccurrence: TppTextSearchOccurrence;
begin

  Inc(FCurrentOccurrenceIndex);

  if (FCurrentTextSearchPage = nil) then
    FCurrentTextSearchPage := NextTextSearchPage;

  if (FCurrentTextSearchPage <> nil) and (FCurrentOccurrenceIndex > (FCurrentTextSearchPage.OccurrenceCount - 1)) then
    begin
      FCurrentTextSearchPage := NextTextSearchPage;
      FCurrentOccurrenceIndex := 0;
    end;
    
  if (FCurrentTextSearchPage <> nil) then
    Result := FCurrentTextSearchPage.Occurrences[FCurrentOccurrenceIndex]
  else
    Result := nil;

end;

{@TppTextSearchPageList.PriorOccurrence }

function TppTextSearchPageList.PriorOccurrence: TppTextSearchOccurrence;
begin

  Dec(FCurrentOccurrenceIndex);

  if (FCurrentOccurrenceIndex < 0) then
    begin

      FCurrentTextSearchPage := PriorTextSearchPage;

      if (FCurrentTextSearchPage <> nil) then
        FCurrentOccurrenceIndex := FCurrentTextSearchPage.OccurrenceCount - 1
      else
        FCurrentOccurrenceIndex := 0;

    end;

  if (FCurrentTextSearchPage <> nil) then
    Result := FCurrentTextSearchPage.Occurrences[FCurrentOccurrenceIndex]
  else
    Result := nil;

end;
     
{@TppTextSearchPageList.FirstOccurrence }

function TppTextSearchPageList.FirstOccurrence: TppTextSearchOccurrence;
begin

  FCurrentOccurrenceIndex := 0;

  FCurrentTextSearchPage := FirstTextSearchPage;

  if (FCurrentTextSearchPage <> nil) then
    Result := FCurrentTextSearchPage.Occurrences[FCurrentOccurrenceIndex]
  else
    Result := nil;

end;
    
{@TppTextSearchPageList.LastOccurrence }

function TppTextSearchPageList.LastOccurrence: TppTextSearchOccurrence;
begin

  FCurrentOccurrenceIndex := 0;
  FCurrentTextSearchPage := LastTextSearchPage;

  if (FCurrentTextSearchPage <> nil) then
    begin
      FCurrentOccurrenceIndex := FCurrentTextSearchPage.OccurrenceCount - 1;

      Result := FCurrentTextSearchPage.Occurrences[FCurrentOccurrenceIndex]
    end
  else
    Result := nil;

end;
    
{@TppTextSearchPageList.NextTextSearchPage }

function TppTextSearchPageList.NextTextSearchPage: TppTextSearchPage;
begin

  Inc(FCurrentTextSearchPageIndex);

  if (FCurrentTextSearchPageIndex < FList.Count) then
    Result := FList[FCurrentTextSearchPageIndex]
  else
    begin
      FCurrentTextSearchPageIndex := FList.Count - 1;
      Result := nil;
    end;

end;
      
{@TppTextSearchPageList.PriorTextSearchPage }

function TppTextSearchPageList.PriorTextSearchPage: TppTextSearchPage;
begin

  Dec(FCurrentTextSearchPageIndex);

  if (FCurrentTextSearchPageIndex > -1) then
    Result := FList[FCurrentTextSearchPageIndex]
  else
    begin
      FCurrentTextSearchPageIndex := FList.Count - 1;
      Result := nil;
    end;

end;
     
{@TppTextSearchPageList.FirstTextSearchPage }

function TppTextSearchPageList.FirstTextSearchPage: TppTextSearchPage;
begin
  FCurrentTextSearchPageIndex := 0;

  Result := FList[FCurrentTextSearchPageIndex]
end;
       
{@TppTextSearchPageList.LastTextSearchPage }

function TppTextSearchPageList.LastTextSearchPage: TppTextSearchPage;
begin
  FCurrentTextSearchPageIndex := FList.Count - 1;

  if (FCurrentTextSearchPageIndex < 0) then
    raise ESearchError.Create('TppTextSearchPageList.LastTextSearchPage: Current page search object list is empty.');

  Result := FList[FCurrentTextSearchPageIndex]
end;
   
{@TppTextSearchPageList.GetTotalFoundCount }

function TppTextSearchPageList.GetTotalFoundCount: Integer;
var
  lTextSearchPage: TppTextSearchPage;
  liIndex: Integer;
begin

  Result := 0;

  for liIndex := 0 to FList.Count - 1 do
    begin
      lTextSearchPage := FList[liIndex];

      Result := Result + lTextSearchPage.OccurrenceCount;
    end;

end;
      
{@TppTextSearchPageList.GetCurrentDrawCommandIndex }

function TppTextSearchPageList.GetCurrentDrawCommandIndex: Integer;
begin

  if (FCurrentTextSearchPage <> nil) then
    Result := FCurrentTextSearchPage[FCurrentOccurrenceIndex].DrawCommandIndex
  else
    Result := -1;

end;
      
{@TppTextSearchPageList.GetCurrentPageNo }

function TppTextSearchPageList.GetCurrentPageNo: Integer;
begin
  if (FCurrentTextSearchPage <> nil) then
    Result := FCurrentTextSearchPage.PageNo
  else
    Result := -1;
end;

{@TppTextSearchPageList.GetCurrentOccurrenceIndex }

function TppTextSearchPageList.GetCurrentOccurrenceIndex: Integer;
begin
  Result := FCurrentOccurrenceIndex;
end;

{@TppTextSearchPageList.GotoPage

  Moves the current position in the page info list to this page and sets
  the current draw command index for the page at zero, which is the first draw
  command at the top of the page. The page info page number is not necessarily
  the same as the absolute page number of the report.}

function TppTextSearchPageList.GotoPage(aPageNo: Integer): TppTextSearchPage;
var
  lTextSearchPage: TppTextSearchPage;
  liIndex: Integer;
  lbPageReached: Boolean;
begin

  lbPageReached := False;
  liIndex := 0;

  while (liIndex < GetTextSearchPageCount) and not(lbPageReached) do
    begin
      lTextSearchPage := GetTextSearchPageForIndex(liIndex);

      if (lTextSearchPage.PageNo = aPageNo) then
        begin
          FCurrentTextSearchPageIndex := liIndex;

          lbPageReached := True;
        end;

      Inc(liIndex);
    end;

  if (liIndex > GetTextSearchPageCount) and not(lbPageReached) then
    raise ESearchError.Create('TppTextSearchPageList.GotoPage: Cannot find the page number ' + IntToStr(aPageNo) + ' in the list of page info objects of (1-' + IntToStr(GetTextSearchPageCount) + ').');

  FCurrentTextSearchPage := GetTextSearchPageForIndex(FCurrentTextSearchPageIndex);
  FCurrentOccurrenceIndex := 0;

  Result := FCurrentTextSearchPage;

end;

{@TppTextSearchPageList.CurrentOccurrence }

function TppTextSearchPageList.CurrentOccurrence: TppTextSearchOccurrence;
begin
  if (FCurrentTextSearchPage = nil) then
    Result := FirstOccurrence
  else
    Result := FCurrentTextSearchPage.Occurrences[FCurrentOccurrenceIndex];
end;

{@TppTextSearchPageList.GotoOccurrence }

procedure TppTextSearchPageList.GotoOccurrence(aIndex: Integer);
begin
  FCurrentOccurrenceIndex := aIndex;
end;

{@TppTextSearchPageList.GotoDrawCommandSearchOccurrence }

function TppTextSearchPageList.GetCurrentTextSearchPageIndex: Integer;
begin
  Result := FCurrentTextSearchPageIndex;
end;

{@TppTextSearchPageList.ResetSearchIndex }

procedure TppTextSearchPageList.ResetSearchIndex(aIndex: Integer);
var
  lTextSearchPage: TppTextSearchPage;
  liIndex: Integer;
  liTotal: Integer;
begin

  liTotal := 0;
  liIndex := 0;
  lTextSearchPage := nil;

  {loop through the pages finding the totals on each page}
  while ((liTotal - 1) < aIndex) and (liIndex < FList.Count)do
    begin
      lTextSearchPage := TppTextSearchPage(FList[liIndex]);

      liTotal := liTotal + lTextSearchPage.OccurrenceCount;

      Inc(liIndex);
    end;

  if (liIndex > FList.Count) or ((liTotal - 1) < aIndex) then
    raise ESearchError.Create('TppTextSearchPageList.ResetSearchIndex: Cannot find the search index in the page range: ' + IntToStr(aIndex));

  {the current page info has the index we are looking for}
  FCurrentOccurrenceIndex := lTextSearchPage.OccurrenceCount - (liTotal - (aIndex + 1)) - 1;
  FCurrentTextSearchPage := lTextSearchPage;
  FCurrentTextSearchPageIndex := liIndex;

end;

{@TppTextSearchPageList.GetCurrentSearchIndex

  Returns the global index of the current draw command ingo over all the searched
  pages.  Loops through the pages finding the totals on each page and stop on
  the page right before the current page in order to simply add the value of
  the current known page relative index.}

function TppTextSearchPageList.GetCurrentSearchIndex: Integer;
var
  lTextSearchPage: TppTextSearchPage;
  liIndex: Integer;
  liTotal: Integer;
begin

  liTotal := 0;

  if (FCurrentTextSearchPageIndex = 0) then
    begin
      lTextSearchPage := TppTextSearchPage(FList[0]);

      liTotal := lTextSearchPage.OccurrenceCount;
    end

  else
    begin
      liIndex := 0;

      while (liIndex < FCurrentTextSearchPageIndex) do
        begin
          lTextSearchPage := TppTextSearchPage(FList[liIndex]);

          liTotal := liTotal + lTextSearchPage.OccurrenceCount;

          Inc(liIndex);
        end;

    end;

  {liTotal isn't zero based so we need to subtract one to get the correct zero
   based index.}
  Result := (liTotal - 1) + (FCurrentOccurrenceIndex + 1);

end;
    
{@TppTextSearchPageList.IndexOfPageNumber }

function TppTextSearchPageList.IndexOfPageNumber(aPageNo: Integer): Integer;
var
  lTextSearchPage: TppTextSearchPage;
  liIndex: Integer;
  lbPageReached: Boolean;
begin

  lbPageReached := False;
  liIndex := 0;

  while (liIndex < GetTextSearchPageCount) and not(lbPageReached) do
    begin
      lTextSearchPage := GetTextSearchPageForIndex(liIndex);

      if (lTextSearchPage.PageNo = aPageNo) then
        begin
          FCurrentTextSearchPageIndex := liIndex;

          lbPageReached := True;
        end;

      if not(lbPageReached) then
        Inc(liIndex);
    end;

  if lbPageReached then
    Result := liIndex
  else
    Result := -1;

end;

end.
