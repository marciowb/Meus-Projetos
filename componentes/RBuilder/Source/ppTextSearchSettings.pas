{ RRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppTextSearchSettings;

interface

{$I ppIfDef.pas}

uses
  Classes,
  ppComm, ppTypes;

type

  {@TppTextSearchSettings

    A TextSearchSettings object is embedded in the TppProducer. Descendents
    such as Report, ArchiveReader and ClientReport publish this embedded
    object so that the default search behavior can be changed.

    Set Enabled to true to display the binoculars icon and also to make text
    searching available in the print preview form. Set Visible to true if you
    want to display the search toolbar without requiring the user to click the
    binoculars icon. Set ShowAll to true if you want to show all occurrences
    of the search text. Set CaseSensitive to true, if you want text searching
    to be case sensitive by default.

    You can access the TextSearchSettings property via the Object Inspector or
    by selecting the File | Find Text Settings from the report designer main menu.
    The user can control some settings via a popup menu on the search toolbar for
    ease of use.}

  {@TppTextSearchSettings.CaseSensitive

    Defaults to false.

    This property determines if the text search includes case sensitivity
    when comparing text.}

  {@TppTextSearchSettings.DefaultString

    Defaults to '\<FindText\>'.

    This property is used to set the default search
    text that is displayed in the search toolbar's edit box when the screen
    preview is first displayed.}

  {@TppTextSearchSettings.Enabled

    Defaults to true for new reports.
    
    Defaults to false for pre-ReportBuilder 7.01 reports.

    Controls the visibility of the search toolbar button (binoculars icon).
    This button is available by default in the standard toolbar between the
    autosearch button and the zoom controls.}

  {@TppTextSearchSettings.SearchWhenPreview

    Defaults to false.

    When set to true, causes all pages to be requested from the producer and
    searched for the DefaultString. The first page on which the text is found
    is displayed.}

  {@TppTextSearchSettings.SearchFromCurrentPage

    Defaults to false.

    When true, the text search performs the search from the currently viewed
    page up to the last page in the report. Setting this to false causes the
    text search to begin searching from the first page of the report.}

  {@TppTextSearchSettings.ShowAll

    Defaults to false.

    When ShowAll is set to true, all text matches are highlighted.
    Individual text matches cannot be navigated when ShowAll is true. Use the page
    navigation buttons in the preview to navigate the pages to see all
    occurrences for each page.

    When ShowAll is false the first occurrence is highlighted. Subsequent
    occurrences can be accessed via the search navigation buttons in the search
    toolbar.}

  {@TppTextSearchSettings.Visible

    Defaults to false.

    This property is only effective when Enabled is set to
    true. When the text search in enabled, setting this property to true causes
    the text search toolbar to be displayed when the preview is shown.
    Setting this to false forces the user to press the text search enable
    button (binoculars icon) to show the text search toolbar.}

  {@TppTextSearchSettings.WholeWord

    Defaults to false.

    This property controls whether the text search match
    should be an entire word and not a substring in another word. If true, then
    the text is only found when it is both proceeded and followed by a space or
    grammatical mark. Puncutation and grammatical marks are considered
    whole words. Examples of grammatical marks are commas, quotes and
    symbols (such as the dollar sign).}

  TppTextSearchSettings = class(TPersistent)
    private
      FCaseSensitive: Boolean;
      FDefaultString: String;
      FEnabled: Boolean;
      FSearchFromCurrentPage: Boolean;
      FSearchWhenPreview: Boolean;
      FShowAll: Boolean;
      FVisible: Boolean;
      FWholeWord: Boolean;
      FWalkieTalkie: TppCommunicator;

      procedure SetSearchWhenPreview(aSearchWhenPreview: Boolean);
      procedure SetVisible(aVisible: Boolean);

    protected
      procedure WalkieTalkieNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType); virtual;

    public
      constructor Create;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      procedure LanguageChanged;

      property SearchWhenPreview: Boolean read FSearchWhenPreview write SetSearchWhenPreview;
      property WalkieTalkie: TppCommunicator read FWalkieTalkie;

   published
      property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive default False;
      property DefaultString: String read FDefaultString write FDefaultString;
      property Enabled: Boolean read FEnabled write FEnabled;
      property ShowAll: Boolean read FShowAll write FShowAll default False;
      property SearchFromCurrentPage: Boolean read FSearchFromCurrentPage write FSearchFromCurrentPage default False;
      property Visible: Boolean read FVisible write SetVisible default False;
      property WholeWord: Boolean read FWholeWord write FWholeWord default False;

    end;

    
implementation

uses
  ppUtils, ppTextSearchError;

{@TppTextSearchSettings.Create }

constructor TppTextSearchSettings.Create;
begin

  inherited Create;

  FEnabled := True;
  FDefaultString := ppLoadStr(1069); {'<FindText>'}
  FShowAll := False;
  FSearchWhenPreview := False;
  FCaseSensitive := False;
  FSearchFromCurrentPage := False;
  FVisible := False;
  FWholeWord := False;
  FWalkieTalkie := TppCommunicator.Create(nil);
  FWalkieTalkie.AddNotify(FWalkieTalkie);
  FWalkieTalkie.OnNotify := WalkieTalkieNotifyEvent;

end;

{@TppTextSearchSettings.Destroy }

destructor TppTextSearchSettings.Destroy;
begin

  FWalkieTalkie.OnNotify := nil;
  FWalkieTalkie.Free;

  inherited Destroy;

end;

{@TppTextSearchSettings.Assign }

procedure TppTextSearchSettings.Assign(Source: TPersistent);
var
  lSettings: TppTextSearchSettings;
begin

  lSettings := TppTextSearchSettings(Source);

  FCaseSensitive := lSettings.FCaseSensitive;
  FEnabled := lSettings.FEnabled;
  FDefaultString := lSettings.FDefaultString;
  FShowAll := lSettings.FShowAll;
  FSearchWhenPreview := lSettings.FSearchWhenPreview;
  FSearchFromCurrentPage := lSettings.FSearchFromCurrentPage;
  FVisible := lSettings.FVisible;
  FWholeWord := lSettings.FWholeWord;

end;

{@TppTextSearchSettings.SetSearchWhenPreview }

procedure TppTextSearchSettings.SetSearchWhenPreview(aSearchWhenPreview: Boolean);
begin
  FSearchWhenPreview := aSearchWhenPreview;

  if FSearchWhenPreview then
    FVisible := True;
end;

{@TppTextSearchSettings.WalkieTalkieNotifyEvent }

procedure TppTextSearchSettings.WalkieTalkieNotifyEvent(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if (aCommunicator = FWalkieTalkie) and (aOperation = ppopRemove) then
    raise ESearchError.Create('TppTextSearchSettings.WalkieTalkieNotifyEvent: Don''t free the embedded walkie talkie!');

end;

{@TppTextSearchSettings.SetVisible }

procedure TppTextSearchSettings.SetVisible(aVisible: Boolean);
begin

  if Enabled then
    FVisible := aVisible
  else
    FVisible := False;

end;
 
{@TppTextSearchSettings.LanguageChanged }

procedure TppTextSearchSettings.LanguageChanged;
begin
  FDefaultString := ppLoadStr(1069); {'<FindText>'}
end;

initialization
  RegisterClass(TppTextSearchSettings);

finalization
  UnregisterClass(TppTextSearchSettings);

end.
