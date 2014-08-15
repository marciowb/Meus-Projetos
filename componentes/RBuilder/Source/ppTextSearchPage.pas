{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchPage;

interface

uses
  Classes,
  ppTypes, ppComm, ppDrwCmd, ppDevice,
  ppTextSearchOccurrence;

type

{@TppTextSearchPage

  Used by the print preview text search engine to store information about
  a TppPage object which has been searched for text.

  This is not part of the report generation process and is specific for use
  in the text search engine.}

  TppTextSearchPage = class(TppCommunicator)
    private
      FFreeingList: Boolean;
      FPageNo: Integer;
      FOccurrences: TList;

      function GetOccurrenceForIndex(aIndex: Integer): TppTextSearchOccurrence;
      function GetOccurrenceCount: Integer;
      function PositionToText(aTop, aLeft: Integer): String;
      procedure FreeDrawCommandSearchResults;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure AddOccurrence(aOccurrence: TppTextSearchOccurrence);
      procedure RemoveOccurrence(aOccurrence: TppTextSearchOccurrence);
      procedure Clear;
      procedure Sort;

      property Occurrences[aIndex: Integer]: TppTextSearchOccurrence read GetOccurrenceForIndex; default;
      property OccurrenceCount: Integer read GetOccurrenceCount;
      property PageNo: Integer read FPageNo write FPageNo;

    end;

implementation

uses
  SysUtils,
  ppTextSearchError;
         
{@TppTextSearchPage.Create }

constructor TppTextSearchPage.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FOccurrences := TList.Create;
  FPageNo := 0;
  FFreeingList := False;

end;
    
{@TppTextSearchPage.Destroy }

destructor TppTextSearchPage.Destroy;
begin

  FreeDrawCommandSearchResults;
  FOccurrences.Free;

  inherited Destroy;

end;
      
{@TppTextSearchPage.FreeDrawCommandSearchResults }

procedure TppTextSearchPage.FreeDrawCommandSearchResults;
var
  liIndex: Integer;
begin

  FFreeingList := True;

  for liIndex := FOccurrences.Count - 1 downto 0 do
    TppTextSearchOccurrence(FOccurrences[liIndex]).Free;

  FOccurrences.Clear;

  FFreeingList := False;

end;

{@TppTextSearchPage.Notify }

procedure TppTextSearchPage.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  liIndex: Integer;
begin

  inherited Notify(aCommunicator, aOperation);

  liIndex := FOccurrences.IndexOf(aCommunicator);

  if (liIndex <> - 1) and (aOperation = ppopRemove) and not(FFreeingList) then
    raise ESearchError.Create('TppTextSearchPage.Notify: Cannot free draw command info from page.');

end;
    
{@TppTextSearchPage.GetOccurrenceForIndex }

function TppTextSearchPage.GetOccurrenceForIndex(aIndex: Integer): TppTextSearchOccurrence;
begin

  if (aIndex >= GetOccurrenceCount) or (aIndex < 0) then
    raise ESearchError.Create('TppTextSearchPage.GetDrawCommandForIndex: Must reference an index in range of DrawCommmandCount');

  Result := TppTextSearchOccurrence(FOccurrences[aIndex]);

end;
     
{@TppTextSearchPage.GetOccurrenceCount }

function TppTextSearchPage.GetOccurrenceCount: Integer;
begin
  Result := FOccurrences.Count;
end;
   
{@TppTextSearchPage.AddOccurrence }

procedure TppTextSearchPage.AddOccurrence(aOccurrence: TppTextSearchOccurrence);
begin

  if (aOccurrence <> nil) then
    aOccurrence.AddNotify(Self);

  FOccurrences.Add(aOccurrence);

end;
   
{@TppTextSearchPage.RemoveOccurrence }

procedure TppTextSearchPage.RemoveOccurrence(aOccurrence: TppTextSearchOccurrence);
var
  liIndex: Integer;
begin

  if (aOccurrence <> nil) then
    aOccurrence.RemoveNotify(Self);

  liIndex := FOccurrences.IndexOf(aOccurrence);

  if (liIndex <> -1) then
    FOccurrences.Delete(liIndex);

end;
  
{@TppTextSearchPage.Cleart }

procedure TppTextSearchPage.Clear;
begin
  FOccurrences.Clear;
end;

{@TppTextSearchPage.Sort

  Control how the draw commands are ordered when searching for them here.
  This is the method to change the ordering from top left to bottom right
  in the proper manner to easily support the occurrence navigation of the
  occurrences.}

procedure TppTextSearchPage.Sort;
var
  liTop: Integer;
  liLeft: Integer;
  lsText: String;
  lOccurrence: TppTextSearchOccurrence;
  liIndex: Integer;
  lTopToBottomList: TStringList;
begin

  lTopToBottomList := TStringList.Create;
  lTopToBottomList.Duplicates := dupAccept;

  {$IFDEF Delphi6}
  lTopToBottomList.CaseSensitive := False;
  {$ENDIF}

  for liIndex := 0 to FOccurrences.Count - 1 do
    begin
      lOccurrence := TppTextSearchOccurrence(FOccurrences[liIndex]);

      liTop := lOccurrence.Top;
      liLeft := lOccurrence.Left;

      try
        lsText := PositionToText(liTop, liLeft);

      except
        on E: ESearchError do
          lsText := IntToStr(liTop);
      end;

      lTopToBottomList.AddObject(lsText, lOccurrence);
    end;

  FOccurrences.Clear;

  lTopToBottomList.Sort;

  for liIndex := 0 to lTopToBottomList.Count - 1 do
    begin
      lOccurrence := TppTextSearchOccurrence(lTopToBottomList.Objects[liIndex]);

      FOccurrences.Add(lOccurrence);
    end;

  lTopToBottomList.Free;

end;
        
{@TppTextSearchPage.PositionToText

  Builds a string based on a top and left position in that the string can be
  sorted from a top left to a bottom right order. This is the order that
  the text occurences on a page are to navigated by the user. Since each draw
  command has different locations and fonts and possible memo text, then this
  calculation allows for the correct ordering of the occurrences in the list.}

function TppTextSearchPage.PositionToText(aTop, aLeft: Integer): String;
var
  lsText: String;
  liPrecision: Integer;
  liLength: Integer;
begin

  liPrecision := 7;

  {top}
  lsText := Format('0000000000%d', [aTop]);
  liLength := Length(lsText);
  lsText := Copy(lsText, liLength - liPrecision, liLength);

  Result := lsText;

  {left}
  lsText := Format('0000000000%d', [aLeft]);
  liLength := Length(lsText);
  lsText := Copy(lsText, liLength - liPrecision, liLength);

  if (Length(Result) <> Length(lsText)) then
    raise ESearchError.Create('TppTextSearchPage.PositionToText: Formatting failure');

  Result := Result + lsText;

end;


end.
