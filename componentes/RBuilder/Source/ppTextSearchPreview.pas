{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchPreview;

interface

uses
  Buttons, Controls, Classes, Menus, ComCtrls, ExtCtrls, StdCtrls,
  ppTextSearchCustomPreview, ppTypes, ppDevice,
  ppRTTI, ppTextSearchError,

  ppToolResources,

  ppTB2Item,
  ppTBXDkPanels,

  ppPopupMenuBase;

type


  {@TppTextSearchPreview

    Creates the controls neccessary to provide an interface to the search engine.
    This class creates search controls in the Accessory Toolbar
    of the standard TppPreview form above the report outline on the
    left side of the viewer.}

  {@TppTextSearchPreview.DoneButton

    Used to stop the search or cancel the search if the search is actively
    processing a search action.}

  {@TppTextSearchPreview.FirstButton

    Pressing this button moves the search highlight cursor to the first
    occurrence in the search.}

  {@TppTextSearchPreview.LastButton

    Pressing this button moves the search highlight cursor to the last
    occurrence in the search.}

  {@TppTextSearchPreview.NextButton

    Pressing this button moves the search highlight cursor to the next
    occurrence in the search.}

  {@TppTextSearchPreview.PriorButton

    Pressing this button moves the search highlight cursor to the prior
    occurrence in the search.}

  {@TppTextSearchPreview.PopupMenu

    The menu which is available by right mouse clicking in the search toolbar
    workspace.  The options in the menu are used to control the text search
    settings for the next search to be performed.  Selecting one of the options
    does not cause a new search to be spawned. The search button needs to be
    pressed in order to start a new search using the latest settings.}

  {@TppTextSearchPreview.SearchButton

    Launches a new search using the latest text search settings which have been
    defined on the report.}

  {@TppTextSearchPreview.SearchEdit

    The edit box in which the text to be searched for is entered. Pressing enter
    in this edit box causes the search to be performed, the same as if the
    Search button is pressed.}

  TppTextSearchPreview = class(TppCustomSearchPreview)
    private
      {visual controls}
      FCaseSensitiveMenuItem: TppTBCustomItem;
      FCurrentPageMenuItem: TppTBCustomItem;
      FFirstButton: TppTBXButton;
      FFirstPageMenuItem: TppTBCustomItem;
      FLastButton: TppTBXButton;
      FNextButton: TppTBXButton;
      FPopupMenu: TppPopupMenuBase;
      FPriorButton: TppTBXButton;
      FSearchButton: TButton;
      FSearchDoneButton: TButton;
      FSearchEdit: TEdit;
      FShowAllMenuItem: TppTBCustomItem;
      FWholeWordMenuItem: TppTBCustomItem;

      {event handlers}
      procedure SearchDoneButtonClickHandler(Sender: TObject);
      procedure KeyPressHandler(Sender: TObject; var Key: Char);
      procedure NextButtonClickHandler(Sender: TObject);
      procedure PriorButtonClickHandler(Sender: TObject);
      procedure LastButtonClickHandler(Sender: TObject);
      procedure FirstButtonClickHandler(Sender: TObject);
      procedure SearchButtonClickHandler(Sender: TObject);
      procedure ShowAllClickHandler(Sender: TObject);
      procedure CaseSensitiveClickHandler(Sender: TObject);
      procedure SearchAllPagesClickHandler(Sender: TObject);
      procedure SearchCurrentPageForwardClickHandler(Sender: TObject);
      procedure WholeWordClickHandler(Sender: TObject);

    protected
      procedure ControlsToSettings; override;
      procedure DoneSearching; override;
      procedure HandleError(E: ESearchError); override;
      procedure InternalInitialize; override;
      function Search: Boolean; override;
      function ShouldPerformSearch: Boolean; override;
      procedure SetBusy(aBusy: Boolean); override;
      procedure SetOnKeyDown(aOnKeyDown: TKeyEvent); override;
      procedure UpdateControls; override;

      procedure BeforeShowStatistics(var aStatistics: String); virtual;
      procedure ConfigureSearchPopupMenu(aPopupMenu: TPopupMenu); virtual;
      function CreateSearchPopupMenu(aParent: TWinControl): TppPopupMenuBase;
          virtual;

      {utility routines}
      procedure DisableSearchNavigationControls;
      procedure ToggleSearchButtons;
      procedure OptionsToStatusbar(aClearStatistics: Boolean);
      procedure OptionsToStatusbarStd(aClearStatistics: Boolean);
      procedure OptionsToStatusbarTbx(aClearStatistics: Boolean);
      procedure StatisticsToStatusbar;
      procedure StatisticsToStatusbarStd;
      procedure StatisticsToStatusbarTbx;

      property DoneButton: TButton read FSearchDoneButton;
      property FirstButton: TppTBXButton read FFirstButton;
      property LastButton: TppTBXButton read FLastButton;
      property NextButton: TppTBXButton read FNextButton;
      property PopupMenu: TppPopupMenuBase read FPopupMenu;
      property PriorButton: TppTBXButton read FPriorButton;
      property SearchButton: TButton read FSearchButton;
      property SearchEdit: TEdit read FSearchEdit;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure LanguageChanged; override;

      procedure AfterPreview; override;
      procedure ArrangeControlsVertically; override;
      procedure ArrangeControlsHorizontally; override;
      procedure BeforePreview; override;
      procedure CreateControls(aSearchPanel: TPanel); override;
      procedure StatusChange; override;

    end;

  {TppTextSearchPreviewClass}

  TppTextSearchPreviewClass = class of TppTextSearchPreview;

implementation

uses
  SysUtils, Forms, Graphics,
  ppUtils, ppPreview,
  ppTextSearchPreviewIcons;

{@TppTextSearchPreview.Create }

constructor TppTextSearchPreview.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FCaseSensitiveMenuItem := nil;
  FCurrentPageMenuItem := nil;
  FFirstPageMenuItem := nil;
  FPopupMenu := nil;
  FShowAllMenuItem := nil;
  FWholeWordMenuItem := nil;

  FSearchEdit := nil;
  FFirstButton := nil;
  FPriorButton := nil;
  FNextButton := nil;
  FLastButton := nil;
  FSearchButton := nil;
  FSearchDoneButton := nil;

end;

{@TppTextSearchPreview.Destroy }

destructor TppTextSearchPreview.Destroy;
begin

  inherited Destroy;

end;


{@TppTextSearchPreview.CreateControls }

procedure TppTextSearchPreview.CreateControls(aSearchPanel: TPanel);
begin

  inherited CreateControls(aSearchPanel);

  FSearchEdit := TEdit.Create(aSearchPanel);
  FSearchEdit.Parent := aSearchPanel;
  FSearchEdit.Width := 115;
  FSearchEdit.Text := TextSearchSettings.DefaultString;
  FSearchEdit.OnKeyPress := KeyPressHandler;
  FSearchEdit.Tag := 101;
  FSearchEdit.AutoSelect := True;
  FSearchEdit.Hint := ppLoadStr(1052); {'Enter the text to search for'}
  FSearchEdit.TabStop := False;
  FSearchEdit.OnKeyDown := OnKeyDown;

  FFirstButton := TppTBXButton.Create(aSearchPanel);
  FFirstButton.Parent := aSearchPanel;
  FFirstButton.ButtonStyle := bsFlat;
  FFirstButton.Height := 22;
  FFirstButton.Width := 23;
  FFirstButton.Images := ToolImageList;
  FFirstButton.ImageIndex :=  ToolImageList.AddTool('PPFIRSTPAGE');
  FFirstButton.Enabled := False;
  FFirstButton.OnClick := FirstButtonClickHandler;
  FFirstButton.Tag := 102;
  FFirstButton.Hint := ppLoadStr(1058); {'Go to the first occurrence of the text'}

  FPriorButton := TppTBXButton.Create(aSearchPanel);
  FPriorButton.Parent := aSearchPanel;
  FPriorButton.ButtonStyle := bsFlat;
  FPriorButton.Height := FFirstButton.Height;
  FPriorButton.Width := FFirstButton.Width;
  FPriorButton.Images := ToolImageList;
  FPriorButton.ImageIndex := ToolImageList.AddTool('PPPRIORPAGE');
  FPriorButton.Enabled := False;
  FPriorButton.OnClick := PriorButtonClickHandler;
  FPriorButton.Tag := 103;
  FPriorButton.Hint := ppLoadStr(1061); {'Go to the previous occurrence of the text'}

  FNextButton := TppTBXButton.Create(aSearchPanel);
  FNextButton.Parent := aSearchPanel;
  FNextButton.ButtonStyle := bsFlat;
  FNextButton.Height := FFirstButton.Height;
  FNextButton.Width := FFirstButton.Width;
  FNextButton.Images := ToolImageList;
  FNextButton.ImageIndex :=  ToolImageList.AddTool('PPNEXTPAGE');
  FNextButton.Enabled := False;
  FNextButton.OnClick := NextButtonClickHandler;
  FNextButton.Tag := 104;
  FNextButton.Hint := ppLoadStr(1060); {'Go to the next occurrence of the text'}

  FLastButton := TppTBXButton.Create(aSearchPanel);
  FLastButton.Parent := aSearchPanel;
  FLastButton.ButtonStyle := bsFlat;
  FLastButton.Height := FFirstButton.Height;
  FLastButton.Width := FFirstButton.Width;
  FLastButton.Images := ToolImageList;
  FLastButton.ImageIndex := ToolImageList.AddTool('PPLASTPAGE');
  FLastButton.Enabled := False;
  FLastButton.OnClick := LastButtonClickHandler;
  FLastButton.Tag := 105;
  FLastButton.Hint := ppLoadStr(1059); {'Go to the last occurrence of the text'}

  FSearchButton := TButton.Create(aSearchPanel);
  FSearchButton.Parent := aSearchPanel;
  FSearchButton.Width  := 55;
  FSearchButton.Height  := 23;
  FSearchButton.Caption := ppLoadStr(1072); {'Find Text'}
  FSearchButton.Enabled := True;
  FSearchButton.OnClick := SearchButtonClickHandler;
  FSearchButton.Tag := 106;
  FSearchButton.Hint := ppLoadStr(1053); {'Find text in the report'}
  FSearchButton.TabStop := False;
//TODO  FSearchButton.OnClick := OnKeyDown;

  FSearchDoneButton := TButton.Create(aSearchPanel);
  FSearchDoneButton.Parent := aSearchPanel;
  FSearchDoneButton.Width := FSearchButton.Width;
  FSearchDoneButton.Height := FSearchButton.Height;
  FSearchDoneButton.Caption := ppLoadStr(1046); {'Done';}
  FSearchDoneButton.Enabled := False;
  FSearchDoneButton.OnClick := SearchDoneButtonClickHandler;
  FSearchDoneButton.Tag := 107;
  FSearchDoneButton.Hint := ppLoadStr(1049); {'Clear the search'}
  FSearchDoneButton.TabStop := False;

  FPopupMenu := CreateSearchPopupMenu(aSearchPanel);
  SearchPanel.Popupmenu := FPopupMenu;

end;

{@TppTextSearchPreview.CreateSearchPopupMenu }

function TppTextSearchPreview.CreateSearchPopupMenu(aParent: TWinControl): TppPopupMenuBase;
begin

  Result := TppPopupMenuBase.Create(aParent);
  Result.AutoPopup := True;
  Result.MenuAnimation := [maTopToBottom];

  FShowAllMenuItem := Result.AddChildItem();
  FShowAllMenuItem.Caption := ppLoadStr(1062); {'Show All'}
  FShowAllMenuItem.OnClick := ShowAllClickHandler;

  FCaseSensitiveMenuItem := Result.AddChildItem();
  FCaseSensitiveMenuItem.Caption := ppLoadStr(1063); {'Case Sensitive'}
  FCaseSensitiveMenuItem.OnClick := CaseSensitiveClickHandler;

  FWholeWordMenuItem := Result.AddChildItem();
  FWholeWordMenuItem.Caption := ppLoadStr(1064); {'Whole Word'}
  FWholeWordMenuItem.OnClick := WholeWordClickHandler;

  Result.AddSeparator();

  FFirstPageMenuItem := Result.AddChildItem();
  FFirstPageMenuItem.Caption := ppLoadStr(1057); {'Search From First Page'}
  FFirstPageMenuItem.OnClick := SearchAllPagesClickHandler;

  FCurrentPageMenuItem := Result.AddChildItem();
  FCurrentPageMenuItem.Caption := ppLoadStr(1056); {'Search From Current Page'}
  FCurrentPageMenuItem.OnClick := SearchCurrentPageForwardClickHandler;

end;

{@TppTextSearchPreview.BeforePreview

  This method is called by the parent preview after the preview form has been
  created and before the preview form is shown. Allows the search preview to
  initialize itself.}

procedure TppTextSearchPreview.BeforePreview;
begin

  inherited BeforePreview;

  FSearchEdit.Text := TextSearchSettings.DefaultString;

  ConfigureSearchPopupMenu(FPopupMenu);

end;

{@TppTextSearchPreview.AfterPreview

  This routine is called by the preview parent when the preview form is exiting.
  It is not being freed necessarily, such as when in the runtime designer. The
  preview form is still instantiated, but this function resets the search
  preview so that it can prepare itself for the next time the search preview
  is shown.}

procedure TppTextSearchPreview.AfterPreview;
begin

  inherited AfterPreview;

  FSearchDoneButton.Enabled := False;

  ControlsToSettings;

  UpdateControls;

end;

{@TppTextSearchPreview.StatusChange }

procedure TppTextSearchPreview.StatusChange;
begin

  inherited StatusChange;

  if ControlsEnabled then
    begin
      StatisticsToStatusbar;

      OptionsToStatusbar(False);
    end;

end;

{@TppTextSearchPreview.Search }

function TppTextSearchPreview.Search: Boolean;
begin
  FSearchDoneButton.Enabled := True;

  Result := inherited Search;
end;

{@TppTextSearchPreview.DoneSearching }

procedure TppTextSearchPreview.DoneSearching;
begin
  inherited DoneSearching;

  FSearchDoneButton.Enabled := False;
end;

{@TppTextSearchPreview.ConfigureSearchPopupMenu

  This method is called before the search preview is shown.  Use this routine to
  control the popup menu before the search preview is shown in order to
  initialize it after it is created.}

procedure TppTextSearchPreview.ConfigureSearchPopupMenu(aPopupMenu: TPopupMenu);
begin
  FShowAllMenuItem.Checked := TextSearchSettings.ShowAll;
  FCaseSensitiveMenuItem.Checked := TextSearchSettings.CaseSensitive;
  FWholeWordMenuItem.Checked := TextSearchSettings.WholeWord;
  FFirstPageMenuItem.Checked := not(TextSearchSettings.SearchFromCurrentPage);
  FCurrentPageMenuItem.Checked := TextSearchSettings.SearchFromCurrentPage;
end;

{@TppTextSearchPreview.ShowAllClickHandler }

procedure TppTextSearchPreview.ShowAllClickHandler(Sender: TObject);
begin
  TextSearchSettingsChanged := True;

  FShowAllMenuItem.Checked := not(FShowAllMenuItem.Checked);

  FSearchButton.Enabled := True;
end;

{@TppTextSearchPreview.CaseSensitiveClickHandler }

procedure TppTextSearchPreview.CaseSensitiveClickHandler(Sender: TObject);
begin
  TextSearchSettingsChanged := True;

  FCaseSensitiveMenuItem.Checked := not(FCaseSensitiveMenuItem.Checked);

  FSearchButton.Enabled := True;
end;
  
{@TppTextSearchPreview.WholeWordClickHandler }

procedure TppTextSearchPreview.WholeWordClickHandler(Sender: TObject);
begin
  TextSearchSettingsChanged := True;

  FWholeWordMenuItem.Checked := not(FWholeWordMenuItem.Checked);

  FSearchButton.Enabled := True;
end;

{@TppTextSearchPreview.SearchAllPagesClickHandler }

procedure TppTextSearchPreview.SearchAllPagesClickHandler(Sender: TObject);
begin

  FFirstPageMenuItem.Checked := not(FFirstPageMenuItem.Checked);

  {toggle SearchCurrentPage}
  FCurrentPageMenuItem.Checked := not(FFirstPageMenuItem.Checked);

  TextSearchSettingsChanged := True;

  FSearchButton.Enabled := True;
end;

{@TppTextSearchPreview.SearchCurrentPageForwardClickHandler }

procedure TppTextSearchPreview.SearchCurrentPageForwardClickHandler(Sender: TObject);
begin

  FCurrentPageMenuItem.Checked := not(FCurrentPageMenuItem.Checked);

  {toggle SearchAllPages}
  FFirstPageMenuItem.Checked := not(FCurrentPageMenuItem.Checked);

  TextSearchSettingsChanged := True;

  FSearchButton.Enabled := True;
end;

{@TppTextSearchPreview.KeyPressHandler }

procedure TppTextSearchPreview.KeyPressHandler(Sender: TObject; var Key: Char);
begin

  if (Sender = FSearchEdit) then
    begin

      if (Key = chEnterKey) then
        begin
          SearchText := FSearchEdit.Text;

          TextSearchSettingsChanged := True;
          
          PerformSearchOperation(stSearch);

          {stop the default windows beep}
          Key := #0;
        end;
        
    end;

end;

{@TppTextSearchPreview.ControlsToSettings }

procedure TppTextSearchPreview.ControlsToSettings;
begin
  TextSearchSettings.ShowAll := FShowAllMenuItem.Checked;
  TextSearchSettings.CaseSensitive := FCaseSensitiveMenuItem.Checked;
  TextSearchSettings.WholeWord := FWholeWordMenuItem.Checked;
  TextSearchSettings.SearchFromCurrentPage := FCurrentPageMenuItem.Checked;
  TextSearchSettings.DefaultString := FSearchEdit.Text;
  SearchText := FSearchEdit.Text;
end;

{@TppTextSearchPreview.SearchButtonClickHandler }

procedure TppTextSearchPreview.SearchButtonClickHandler(Sender: TObject);
begin
  try
    PerformSearchOperation(stSearch);

  except
    on E: Exception  do
      Application.HandleException(Sender);
  end;
end;

{@TppTextSearchPreview.SearchDoneButtonClickHandler }

procedure TppTextSearchPreview.SearchDoneButtonClickHandler(Sender: TObject);
begin

  if (FSearchDoneButton.Caption = ppLoadStr(ppMsgCancel)) then
    begin
      ListenToControlChanges := True;

      PerformSearchOperation(stCancel);

      ListenToControlChanges := False;
    end

  else if (FSearchDoneButton.Caption = ppLoadStr(1046)) then {'Done'}
    PerformSearchOperation(stDone);

end;

{@TppTextSearchPreview.FirstButtonClickHandler }

procedure TppTextSearchPreview.FirstButtonClickHandler(Sender: TObject);
begin
  PerformSearchOperation(stFirst);
end;

{@TppTextSearchPreview.LastButtonClickHandler }

procedure TppTextSearchPreview.LastButtonClickHandler(Sender: TObject);
begin
  PerformSearchOperation(stLast);
end;

{@TppTextSearchPreview.NextButtonClickHandler

  Retrieves the next draw command in which the search item was found.}

procedure TppTextSearchPreview.NextButtonClickHandler(Sender: TObject);
begin
  PerformSearchOperation(stNext);
end;

{@TppTextSearchPreview.PriorButtonClickHandler }

procedure TppTextSearchPreview.PriorButtonClickHandler(Sender: TObject);
begin
  PerformSearchOperation(stPrior);
end;

{@TppTextSearchPreview.UpdateControls }

procedure TppTextSearchPreview.UpdateControls;
begin

  inherited UpdateControls;

  ToggleSearchButtons;

  StatisticsToStatusbar;

  OptionsToStatusbar(False);

end;

{@TppTextSearchPreview.StatisticsToStatusbar

  Called to add statistic about the current search to the status bar. This is
  called before the options are added to the status bar.}

procedure TppTextSearchPreview.StatisticsToStatusbar;
begin

  if (StatusBar <> nil) then
    StatisticsToStatusbarStd;

  if (StatusBarTbx <> nil) then
    StatisticsToStatusbarTbx;


end;
  
{@TppTextSearchPreview.BeforeShowStatistics

  Allows descendents to set the status before the search preview updates it
  with the statistics. Override in the descendent and add custom text to the
  aStatistics var string.}

procedure TppTextSearchPreview.BeforeShowStatistics(var aStatistics: String);
{var
  lsOperationTime: String;}
begin

{  uncomment if you want to see elapsed time for a search

  if (SearchOperationInMilliseconds > 0) then
    lsOperationTime := '          Search Operation Time (ms): ' + IntToStr(SearchOperationInMilliseconds)
  else
    lsOperationTime := '';

  aStatistics := aStatistics + lsOperationTime;}

end;

{@TppTextSearchPreview.OptionsToStatusbar

  Called after the statistics have been added to the status bar.}

procedure TppTextSearchPreview.OptionsToStatusbar(aClearStatistics: Boolean);
begin

  if (StatusBar <> nil) then
    OptionsToStatusbarStd(aClearStatistics);

  if (StatusBarTbx <> nil) then
    OptionsToStatusbarTbx(aClearStatistics);

end;


{@TppTextSearchPreview.ToggleSearchButtons }

procedure TppTextSearchPreview.ToggleSearchButtons;
begin

  if TextSearchSettings.ShowAll or not(ActiveSearch) then
    begin
      DisableSearchNavigationControls;

      FSearchDoneButton.Enabled := ActiveSearch;
    end
  else
    begin
      if (Engine.TotalFound = 0) and not(SearchingPage) then
        begin
          FNextButton.Enabled := False;
          FPriorButton.Enabled := False;
          FSearchDoneButton.Enabled := False;
        end
      else
        begin
          FPriorButton.Enabled := not(IsFirstDrawCommand);

          if Engine.AllPagesSearched then
            FNextButton.Enabled := not(IsLastDrawCommand)
          else
            FNextButton.Enabled := True;

          FSearchDoneButton.Enabled := True;
        end;

      FFirstButton.Enabled := FPriorButton.Enabled;
      FLastButton.Enabled := FNextButton.Enabled;
    end;

end;

{@TppTextSearchPreview.DisableSearchNavigationControls

  Turn off the search navigation buttons.}

procedure TppTextSearchPreview.DisableSearchNavigationControls;
begin
  FNextButton.Enabled := False;
  FPriorButton.Enabled := False;
  FFirstButton.Enabled := False;
  FLastButton.Enabled := False;
end;

{@TppTextSearchPreview.ShouldPerformSearch }

function TppTextSearchPreview.ShouldPerformSearch: Boolean;
begin
  Result := inherited ShouldPerformSearch;

  if not(Result) then
    Result := (SearchText <> FSearchEdit.Text);
end;
   
{@TppTextSearchPreview.ArrangeControlsHorizontally

  Call this routine from the TppPreview plugin descendent in the
  TppPreview.ConfigureTextSearchPanel routine in order to control the
  placement of the text search panel.  This routine places the text search
  panel to the right of the standard toolbar at the top of the previewer.}

procedure TppTextSearchPreview.ArrangeControlsHorizontally;
begin

  FSearchEdit.Left := 2;
  FSearchEdit.Top := 2;

  FFirstButton.Top := 2;
  FFirstButton.Left := FSearchEdit.Left + (FSearchEdit.Width + 5);

  FPriorButton.Top := 2;
  FPriorButton.Left := FFirstButton.Left + (FFirstButton.Width +5);

  FNextButton.Top := 2;
  FNextButton.Left := FPriorButton.Left + (FPriorButton.Width + 5);

  FLastButton.Top := 2;
  FLastButton.Left := FNextButton.Left + (FNextButton.Width + 5);

  FSearchButton.Top := 2;
  FSearchButton.Left := FLastButton.Left + (FLastButton.Width + 5);

  FSearchDoneButton.Top := 2;
  FSearchDoneButton.Left := FSearchButton.Left + (FSearchButton.Width + 5);

  SearchPanel.Width := FSearchDoneButton.Left + FSearchDoneButton.Width;

  {TranslatedMinWidth not used in this case, but set here for consistency with ArrangeControlsVertically method}
  SetTranslatedMinWidth(SearchPanel.Width);

end;

{@TppTextSearchPreview.ArrangeControlsVertically

  Call this routine from the TppPreview plugin descendent in the
  TppPreview.ConfigureTextSearchPanel routine in order to control the
  placement of the text search panel.  This routine is called by default and
  places the text search panel in the top left panel above the OutlineViewer.}

procedure TppTextSearchPreview.ArrangeControlsVertically;
var
  lBitmap: TBitmap;
  lCanvas: TCanvas;
  liTop: Integer;
  liLeft: Integer;
  liThirdRowTop: Integer;
  liSecondRowTop: Integer;
begin

  liLeft := 5;
  liTop := 5;

  FSearchEdit.Left := liLeft;
  FSearchEdit.Top  := liTop;

  liSecondRowTop := FSearchEdit.Top + FSearchEdit.Height + 2;

  FFirstButton.Top := liSecondRowTop;
  FPriorButton.Top  := liSecondRowTop;
  FNextButton.Top  := liSecondRowTop;
  FLastButton.Top  := liSecondRowTop;

  liThirdRowTop := FLastButton.Top + FLastButton.Height + 2;

  FSearchButton.Top  := liThirdRowTop;
  FSearchDoneButton.Top  := liThirdRowTop;

  FFirstButton.Left := liLeft + 6;
  FPriorButton.Left := FFirstButton.Left + (FFirstButton.Width + 2);
  FNextButton.Left := FPriorButton.Left + (FPriorButton.Width + 2);
  FLastButton.Left := FNextButton.Left + (FNextButton.Width + 2);


  FSearchButton.Left := liLeft;

  lBitmap := TBitmap.Create;

  try
    lCanvas := lBitmap.Canvas;
    lCanvas.Font := FSearchButton.Font;

    FSearchButton.Width := lCanvas.TextWidth(FSearchButton.Caption) + 10;
    FSearchDoneButton.Width := lCanvas.TextWidth(FSearchDoneButton.Caption) + 10;

    {the default button width is 55}
    if (FSearchButton.Width < 55) then
      FSearchButton.Width := 55;

    if (FSearchDoneButton.Width < FSearchButton.Width) then
      FSearchDoneButton.Width := FSearchButton.Width;

    FSearchDoneButton.Left := FSearchButton.Left + (FSearchButton.Width + 6);

    {min width is used here to control the outline splitter left position and the min width of splitter in the preview}
    SetTranslatedMinWidth(FSearchDoneButton.Left + FSearchDoneButton.Width + 5);

  finally
    lBitmap.Free;
  end;

end;

{@TppTextSearchPreview.HandleError }

procedure TppTextSearchPreview.HandleError(E: ESearchError);
begin

  inherited HandleError(E);

  FSearchEdit.Text := SearchText;

end;

{@TppTextSearchPreview.LanguageChanged }

procedure TppTextSearchPreview.LanguageChanged;
begin

  inherited LanguageChanged;

  FSearchEdit.Hint := ppLoadStr(1052); {'Enter the text to search for'}
  FFirstButton.Hint := ppLoadStr(1058); {'Find First'}
  FPriorButton.Hint := ppLoadStr(1061); {'Find Prior'}
  FNextButton.Hint := ppLoadStr(1060); {'Find Next'}
  FLastButton.Hint := ppLoadStr(1059); {'Find Last'}
  FSearchButton.Caption := ppLoadStr(1072); {'Find Text'}
  FSearchButton.Hint := ppLoadStr(1053); {'Find text in the report'}
  FSearchDoneButton.Caption := ppLoadStr(1046); {'Done'}
  FSearchDoneButton.Hint := ppLoadStr(1049); {'Clear the search'}
  FShowAllMenuItem.Caption := ppLoadStr(1062); {'Show All'}
  FCaseSensitiveMenuItem.Caption := ppLoadStr(1063); {'Case Sensitive'}
  FWholeWordMenuItem.Caption := ppLoadStr(1064); {'Whole Word'}
  FFirstPageMenuItem.Caption := ppLoadStr(1057); {'Find Text From First Page'}
  FCurrentPageMenuItem.Caption := ppLoadStr(1056); {'Find Text From Current Page'}

  UpdateControls;

end;

{@TppTextSearchPreview.SetBusy }

procedure TppTextSearchPreview.SetBusy(aBusy: Boolean);
begin

  inherited SetBusy(aBusy);

  if Busy then
    begin
      FSearchDoneButton.Caption := ppLoadStr(ppMsgCancel); {'Cancel'}
      FSearchDoneButton.Hint := ppLoadStr(ppMsgCancel); {'Cancel'}
    end
  else
    begin
      FSearchDoneButton.Caption := ppLoadStr(1046); {'Done'}
      FSearchDoneButton.Hint := ppLoadStr(1049); {'Clear the search'}
    end;

end;
     
{@TppTextSearchPreview.InternalInitialize }

procedure TppTextSearchPreview.InternalInitialize;
begin

  inherited InternalInitialize;

  FSearchEdit.Enabled := True;
  FSearchButton.Enabled := True;

end;

{@TppTextSearchPreview.OptionsToStatusbar

  Called after the statistics have been added to the status bar.}

procedure TppTextSearchPreview.OptionsToStatusbarStd(aClearStatistics: Boolean);
var
  lsSpace: String;
  lsOptions: String;
begin

  {add lang support}
  lsOptions := '';
  lsSpace :=  '          ';

  if aClearStatistics then
    StatusBar.Panels[1].Text := lsOptions

  else if not(Cancelled) and ActiveSearch then
    begin
      if TextSearchSettings.ShowAll then
        lsOptions := lsSpace + ppLoadStr(1062) {'Show All'}
      else
        lsOptions := '';

      if TextSearchSettings.CaseSensitive then
        lsOptions := lsOptions + lsSpace + ppLoadStr(1063); {'Case Sensitive'}

      if TextSearchSettings.WholeWord then
        lsOptions := lsOptions + lsSpace + ppLoadStr(1064); {'Match Whole Word'}

    end;

  StatusBar.Panels[1].Text := StatusBar.Panels[1].Text + lsOptions;

end;

{@TppTextSearchPreview.OptionsToStatusbar

  Called after the statistics have been added to the status bar.}

procedure TppTextSearchPreview.OptionsToStatusbarTbx(aClearStatistics: Boolean);
var
  lsSpace: String;
  lsOptions: String;
begin

  {add lang support}
  lsOptions := '';
  lsSpace :=  '          ';

  if aClearStatistics then
    StatusBarTbx.Panels[1].Text := lsOptions

  else if not(Cancelled) and ActiveSearch then
    begin
      if TextSearchSettings.ShowAll then
        lsOptions := lsSpace + ppLoadStr(1062) {'Show All'}
      else
        lsOptions := '';

      if TextSearchSettings.CaseSensitive then
        lsOptions := lsOptions + lsSpace + ppLoadStr(1063); {'Case Sensitive'}

      if TextSearchSettings.WholeWord then
        lsOptions := lsOptions + lsSpace + ppLoadStr(1064); {'Match Whole Word'}

    end;

  StatusBarTbx.Panels[1].Text := StatusBarTbx.Panels[1].Text + lsOptions;

end;

procedure TppTextSearchPreview.SetOnKeyDown(aOnKeyDown: TKeyEvent);
begin
  inherited;

  if (FSearchEdit <> nil) then
    begin
      FSearchEdit.OnKeyDown := aOnKeyDown;
//TODO      FSearchButton.OnKeyDown := aOnKeyDown;
    end;
end;

{@TppTextSearchPreview.StatisticsToStatusbar

  Called to add statistic about the current search to the status bar. This is
  called before the options are added to the status bar.}

procedure TppTextSearchPreview.StatisticsToStatusbarStd;
var
  lsSpace: String;
  lsIndex: String;
  lsTotal: String;
  lsStatistics: String;
begin

  lsIndex := IntToStr(SearchIndex + 1);

  lsSpace :=  '          ';

  lsTotal := IntToStr(Engine.TotalFound);

  if Cancelled then
    lsStatistics := ppLoadStr(1051) {'Search Cancelled'}

  else if not(ActiveSearch) then
    lsStatistics := ''

  else
    begin
      if TextSearchSettings.ShowAll then
        lsStatistics := ppLoadStr(1048) + ' ' + lsTotal  {Found lsTotal}
      else
        lsStatistics := ppLoadStr(1048) + ' ' + lsIndex + ' ' + ppLoadStr(16) + ' ' + lsTotal; {Found liIndex of lsTotal}

      if not(Engine.AllPagesSearched) then
        lsStatistics := lsStatistics + ppLoadStr(1045); {'...more...'}

    end;

  BeforeShowStatistics(lsStatistics);

  StatusBar.Panels[1].Text := lsStatistics;

end;

{@TppTextSearchPreview.StatisticsToStatusbar

  Called to add statistic about the current search to the status bar. This is
  called before the options are added to the status bar.}

procedure TppTextSearchPreview.StatisticsToStatusbarTbx;
var
  lsSpace: String;
  lsIndex: String;
  lsTotal: String;
  lsStatistics: String;
begin

  lsIndex := IntToStr(SearchIndex + 1);

  lsSpace :=  '          ';

  lsTotal := IntToStr(Engine.TotalFound);

  if Cancelled then
    lsStatistics := ppLoadStr(1051) {'Search Cancelled'}

  else if not(ActiveSearch) then
    lsStatistics := ''

  else
    begin
      if TextSearchSettings.ShowAll then
        lsStatistics := ppLoadStr(1048) + ' ' + lsTotal  {Found lsTotal}
      else
        lsStatistics := ppLoadStr(1048) + ' ' + lsIndex + ' ' + ppLoadStr(16) + ' ' + lsTotal; {Found liIndex of lsTotal}

      if not(Engine.AllPagesSearched) then
        lsStatistics := lsStatistics + ppLoadStr(1045); {'...more...'}

    end;

  BeforeShowStatistics(lsStatistics);

  StatusBarTbx.Panels[1].Text := lsStatistics;

end;

end.
