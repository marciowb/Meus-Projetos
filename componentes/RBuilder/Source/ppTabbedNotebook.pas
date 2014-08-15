{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppTabbedNoteBook;

interface

uses
  Windows,
  Messages,
  Types,
  Classes,
  Controls,
  StdCtrls,
  ExtCtrls,
  Graphics,

  ppComm,

  ppTBX,
  ppTBXPanel,
  ppTBXThemes,
  ppJvTabBar;

type


  TppTabChangingEvent = procedure (Sender: TObject; aTabIndex: Integer; var AllowChange: Boolean) of object;

  {TppTabSet}
  TppTabSet = class(TppJvTabBar)
  private
    FThemed: Boolean;
    procedure SetThemed(const Value: Boolean);
  protected
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Themed: Boolean read FThemed write SetThemed;
  end;

  {TppTabSet}
  TppThemedTabBarPainter = class(TppJvModernTabBarPainter)
  protected
    procedure DrawBackground(Canvas: TCanvas; TabBar: TppJvCustomTabBar; R: TRect); override;
    procedure DrawTab(Canvas: TCanvas; Tab: TppJvTabBarItem; R: TRect); override;
    function GetThemeTabColor: TColor; virtual;
    procedure TBMThemeChange(var Message: TMessage); message TBM_THEMECHANGE;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;


  {TppTabbedNoteBook

    manages a Tabset and Notebook so that act as one}

  TppTabbedNoteBook = class(TppCommunicator)
  private
    FAlignPanel: TppAlignmentPanel;
    FOnTabChanging: TppTabChangingEvent;
    FOnTabChanged: TNotifyEvent;
    FTabSet: TppTabSet;
    FPageList: TNotebook;
    function GetActivePage: TPage;
    function GetActivePageIndex: Integer;
    function GetCaptions(Index: Integer): String;
    function GetImages: TImageList;
    function GetPageCount: Integer;
    function GetPages(Index: Integer): TPage;
    procedure SetActivePage(const Value: TPage);
    procedure SetActivePageIndex(const Value: Integer);
    procedure SetImages(const Value: TImageList);

  protected
    procedure ehTabSet_OnTabChange(Sender: TObject; aTabIndex: Integer; var aAllowChange: Boolean);
    procedure ehTabSet_OnTabChanged(Sender: TObject);

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function AddPage(aCaption: String): TPage;
    function IndexOfPage(aPage: TPage): Integer;
    procedure Initialize(aParent: TWinControl);
    procedure MovePage(aCurIndex, aNewIndex: Integer);
    procedure SelectNextPage(aGoForward: Boolean);
    procedure SetPageIndex(aPage: TPage; aIndex: Integer);
    procedure SetPageCaption(aPageIndex: Integer; aCaption: String);
    procedure SetPageImageIndex(aPageIndex, aIndex: Integer); overload;
    procedure SetPageImageIndex(aPage: TPage; aImageIndex: Integer); overload;
    procedure SetTabsVisible(const Value: Boolean);
    procedure SetTabVisible(aIndex: Integer; aVisible: Boolean);

    property ActivePage: TPage read GetActivePage write SetActivePage;
    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;
    property Images: TImageList read GetImages write SetImages;
    property PageCount: Integer read GetPageCount;

    property Captions[Index: Integer]: String read GetCaptions;
    property Pages[Index: Integer]: TPage read GetPages;
//    property TabSet: TppTabSet read FTabSet;

  published
    property OnTabChanging: TppTabChangingEvent read FOnTabChanging write FOnTabChanging;
    property OnTabChanged: TNotifyEvent read FOnTabChanged write FOnTabChanged;

  end;


implementation

constructor TppTabbedNoteBook.Create(aOwner: TComponent);
begin

  inherited;

end;

destructor TppTabbedNoteBook.Destroy;
begin
  inherited;
end;

function TppTabbedNoteBook.AddPage(aCaption: String): TPage;
begin

  FTabSet.AddTab(aCaption);
  FPageList.Pages.Add(aCaption);

  Result := Pages[PageCount-1];


end;

procedure TppTabbedNoteBook.ehTabSet_OnTabChange(Sender: TObject; aTabIndex: Integer; var aAllowChange: Boolean);
begin

  if Assigned(FOnTabChanging) then FOnTabChanging(Self, aTabIndex, aAllowChange);

  if aAllowChange then
    FPageList.PageIndex := aTabIndex;

end;

procedure TppTabbedNoteBook.ehTabSet_OnTabChanged(Sender: TObject);
begin
  if Assigned(FOnTabChanged) then FOnTabChanged(Self);
end;

function TppTabbedNoteBook.GetActivePage: TPage;
begin
  Result := GetPages(ActivePageIndex);
end;

function TppTabbedNoteBook.GetActivePageIndex: Integer;
begin

  Result := FTabSet.SelectedTab.Index;

end;

function TppTabbedNoteBook.GetCaptions(Index: Integer): String;
begin
  Result := FTabSet.Tabs[Index].Caption;
end;

function TppTabbedNoteBook.GetImages: TImageList;
begin

  if (FTabSet <> nil) then
    Result := FTabSet.Images
  else
    Result := nil;

end;

function TppTabbedNoteBook.GetPageCount: Integer;
begin
  Result := FPageList.Pages.Count;
end;

function TppTabbedNoteBook.GetPages(Index: Integer): TPage;
begin
  Result := TPage(FPageList.Pages.Objects[Index]);
end;

function TppTabbedNoteBook.IndexOfPage(aPage: TPage): Integer;
begin

  Result := FPageList.Pages.IndexOfObject(aPage);

end;

procedure TppTabbedNoteBook.Initialize(aParent: TWinControl);
begin

  FTabSet := TppTabSet.Create(aParent);
  FTabSet.Parent := aParent;
  FTabSet.Top := 100;
  FTabSet.Align := alTop;
  FTabSet.CloseButton := False;
  FTabSet.OnTabChange := ehTabSet_OnTabChange;
  FTabSet.OnTabChanged := ehTabSet_OnTabChanged;
  FTabSet.Height := FTabSet.Height + 1;  // add extra space at top

  FAlignPanel := TppAlignmentPanel.Create(aParent);
  FAlignPanel.Parent := aParent;
  FAlignPanel.Align := alClient;
  FAlignPanel.Margins.Left := 3;
  FAlignPanel.Margins.Top := 3;
  FAlignPanel.Margins.Right := 3;
  FAlignPanel.Margins.Bottom := 3;

  FPageList := TNotebook.Create(FAlignPanel);
  FPageList.Parent := FAlignPanel;
  FPageList.Align := alClient;
  FPageList.Pages.Clear;

end;

procedure TppTabbedNoteBook.MovePage(aCurIndex, aNewIndex: Integer);
var
  lsCaption: String;
  liImageIndex: Integer;
  liIndex: Integer;
begin

  // move page one at a time
  if (aCurIndex > aNewIndex) then
    for liIndex := aCurIndex downto aNewIndex+1 do
      begin
        lsCaption := FTabSet.Tabs[liIndex].Caption;
        liImageIndex :=  FTabSet.Tabs[liIndex].ImageIndex;

        FTabSet.Tabs[liIndex].Caption := FTabSet.Tabs[liIndex-1].Caption;
        FTabSet.Tabs[liIndex].ImageIndex := FTabSet.Tabs[liIndex-1].ImageIndex;

        FTabSet.Tabs[liIndex-1].Caption := lsCaption;
        FTabSet.Tabs[liIndex-1].ImageIndex := liImageIndex;

        FPageList.Pages.Move(liIndex, liIndex-1);

      end
  else
    for liIndex := aCurIndex to aNewIndex-1 do
      begin
        lsCaption := FTabSet.Tabs[liIndex].Caption;
        liImageIndex :=  FTabSet.Tabs[liIndex].ImageIndex;

        FTabSet.Tabs[liIndex].Caption := FTabSet.Tabs[liIndex+1].Caption;
        FTabSet.Tabs[liIndex].ImageIndex := FTabSet.Tabs[liIndex+1].ImageIndex;

        FTabSet.Tabs[liIndex+1].Caption := lsCaption;
        FTabSet.Tabs[liIndex+1].ImageIndex := liImageIndex;

        FPageList.Pages.Move(liIndex, liIndex+1);

      end;

end;

procedure TppTabbedNoteBook.SelectNextPage(aGoForward: Boolean);
begin

  if aGoForward and (ActivePageIndex < PageCount-1) then
    ActivePageIndex := ActivePageIndex + 1

  else if not(aGoForward) and (ActivePageIndex > 0) then
    ActivePageIndex := ActivePageIndex - 1;

end;

procedure TppTabbedNoteBook.SetActivePage(const Value: TPage);
var
  liIndex: Integer;
begin

  liIndex := FPageList.Pages.IndexOfObject(Value);

  ActivePageIndex := liIndex;

end;

procedure TppTabbedNoteBook.SetActivePageIndex(const Value: Integer);
begin
  FTabSet.SelectedTab := FTabset.Tabs[Value];

end;

procedure TppTabbedNoteBook.SetImages(const Value: TImageList);
begin

  if (FTabSet <> nil) then
    FTabSet.Images := Value;

end;

procedure TppTabbedNoteBook.SetPageIndex(aPage: TPage; aIndex: Integer);
var
  liCurIndex: Integer;
begin
  liCurIndex := IndexOfPage(aPage);

  MovePage(liCurIndex, aIndex);


end;

procedure TppTabbedNoteBook.SetPageCaption(aPageIndex: Integer; aCaption: String);
begin
  FTabSet.Tabs[aPageIndex].Caption := aCaption;

end;

procedure TppTabbedNoteBook.SetPageImageIndex(aPageIndex, aIndex: Integer);
begin
  FTabSet.Tabs[aPageIndex].ImageIndex := aIndex;
end;

procedure TppTabbedNoteBook.SetPageImageIndex(aPage: TPage; aImageIndex: Integer);
var
  liIndex: Integer;
begin
  liIndex := IndexOfPage(aPage);

  SetPageImageIndex(liIndex, aImageIndex);
end;

procedure TppTabbedNoteBook.SetTabsVisible(const Value: Boolean);
begin
  FTabSet.Visible := Value;
end;

procedure TppTabbedNoteBook.SetTabVisible(aIndex: Integer; aVisible: Boolean);
begin
  FTabSet.Tabs[aIndex].Visible := aVisible;

end;

{------------------------------------------------------------------------------}
{ TppTabSet.Create }

constructor TppTabSet.Create(aOwner: TComponent);
begin

  inherited;


  SetThemed(True);

end;

{------------------------------------------------------------------------------}
{ TppTabSet.Destroy }

destructor TppTabSet.Destroy;
begin

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppTabSet.SetThemed }

procedure TppTabSet.SetThemed(const Value: Boolean);
begin

  FThemed := Value;

  Painter.Free;

  if FThemed then
    Painter := TppThemedTabBarPainter.Create(Self)
  else
    Painter := TppJvModernTabBarPainter.Create(Self);


end;

{------------------------------------------------------------------------------}
{ TppThemedTabBarPainter.Create }

constructor TppThemedTabBarPainter.Create(aOwner: TComponent);
begin

  inherited;
  
  AddThemeNotification(Self);

  TabColor := GetThemeTabColor;

end;

{------------------------------------------------------------------------------}
{ TppThemedTabBarPainter.Destroy }

destructor TppThemedTabBarPainter.Destroy;
begin

  RemoveThemeNotification(Self);

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppThemedTabBarPainter.DrawBackground }

procedure TppThemedTabBarPainter.DrawBackground(Canvas: TCanvas; TabBar: TppJvCustomTabBar; R: TRect);
begin
//  inherited;
//  Exit;


  with Canvas do
  begin

//   CurrentTheme.PaintBackgnd(Canvas, R, c, R, CurrentTheme.GetViewColor(TVT_NORMALTOOLBAR), false, TVT_NORMALTOOLBAR);

//   CurrentTheme.PaintBackgnd(Canvas, R, R, R, CurrentTheme.GetViewColor(TVT_NORMALTOOLBAR), false, TVT_NORMALTOOLBAR);

    Brush.Style := bsSolid;
    Brush.Color := Color;
//     Brush.Color := CurrentTheme.GetViewColor(TVT_NORMALTOOLBAR);
    FillRect(R);
//    CurrentTheme.PaintDock(Canvas, R, R, DP_TOP);

    Brush.Style := bsClear;
    Pen.Color := BorderColor;
    Pen.Width := 1;
    case TabBar.Orientation of
      toBottom:
        begin
          MoveTo(0, R.Bottom - 1);
          LineTo(0, 0);
          Pen.Color := ControlDivideColor;
          LineTo(R.Right - 1, 0);
          Pen.Color := BorderColor;
          LineTo(R.Right - 1, R.Bottom - 1);
          LineTo(0, R.Bottom - 1);
        end;
    else
      // toTop
      MoveTo(0, R.Bottom - 1);
      LineTo(0, 0);
      LineTo(R.Right - 1, 0);
      LineTo(R.Right - 1, R.Bottom - 1);
      Pen.Color := ControlDivideColor;
      LineTo(0, R.Bottom - 1);
    end;
  end;
end;

procedure TppThemedTabBarPainter.DrawTab(Canvas: TCanvas; Tab: TppJvTabBarItem; R: TRect);
var
  CloseR: TRect;
begin
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    Pen.Mode := pmCopy;
    Pen.Style := psSolid;
    Pen.Width := 1;

    // selected
    if Tab.Selected then
    begin
      Brush.Style := bsSolid;
      Brush.Color := TabColor;
     FillRect(R);
//      CurrentTheme.PaintDock(Canvas, R, R, DP_TOP);

//dm      CurrentTheme.PaintBackgnd(Canvas, R, R, R, CurrentTheme.GetViewColor(TVT_NORMALTOOLBAR), false, TVT_NORMALTOOLBAR);
//dm      CurrentTheme.PaintBackgnd(Canvas, R, R, R, clWindow, false, clWindow);

      Pen.Color := ControlDivideColor;
      case Tab.TabBar.Orientation of
        toBottom:
          begin
            MoveTo(R.Left, R.Top);
            LineTo(R.Left, R.Bottom - 1);
            LineTo(R.Right - 1, R.Bottom - 1);
            LineTo(R.Right - 1, R.Top - 1{end});
          end;
      else
        // toTop
        MoveTo(R.Left, R.Bottom - 1);
        LineTo(R.Left, R.Top);
        LineTo(R.Right - 1, R.Top);
        LineTo(R.Right - 1, R.Bottom - 1 + 1{end});
      end;
    end;

    // hot color
    if Tab.Enabled and not Tab.Selected and Tab.Hot then
    begin
      // hot
      Pen.Color := DividerColor;
      MoveTo(R.Left, R.Top);
      LineTo(R.Right - 1 - 1, R.Top);
    end;

    // close button
    if Tab.TabBar.CloseButton then
    begin
      // close button color
      if Tab.Selected then
        Brush.Color := CloseColorSelected
      else
        Brush.Color := CloseColor;

      CloseR := GetCloseRect(Canvas, Tab, Tab.DisplayRect);
      Pen.Color := CloseRectColor;
      if not Tab.Enabled then
        Pen.Color := CloseRectColorDisabled;

      if Tab.Closing then
        // shrink
        Rectangle(CloseR.Left + 1, CloseR.Top + 1, CloseR.Right - 1, CloseR.Bottom - 1)
      else
        Rectangle(CloseR);

      if Tab.Modified then
        Pen.Color := ModifiedCrossColor
      else
      if Tab.Selected and not Tab.Closing then
        Pen.Color := CloseCrossColorSelected
      else
      if Tab.Enabled then
        Pen.Color := CloseCrossColor
      else
        Pen.Color := CloseCrossColorDisabled;

      // close cross
      MoveTo(CloseR.Left + 3, CloseR.Top + 3);
      LineTo(CloseR.Right - 3, CloseR.Bottom - 3);
      MoveTo(CloseR.Left + 4, CloseR.Top + 3);
      LineTo(CloseR.Right - 4, CloseR.Bottom - 3);

      MoveTo(CloseR.Right - 4, CloseR.Top + 3);
      LineTo(CloseR.Left + 2, CloseR.Bottom - 3);
      MoveTo(CloseR.Right - 5, CloseR.Top + 3);
      LineTo(CloseR.Left + 3, CloseR.Bottom - 3);

      // remove intersection
      if Tab.Modified then
        FillRect(Rect(CloseR.Left + 5, CloseR.Top + 4, CloseR.Right - 5, CloseR.Bottom - 4));

      R.Left := CloseR.Right;
    end;

    InflateRect(R, -1, -1);

    if not Tab.TabBar.CloseButton then
      Inc(R.Left, 2);

    if (Tab.ImageIndex <> -1) and (Tab.GetImages <> nil) then
    begin
      Tab.GetImages.Draw(Canvas, R.Left, R.Top + (R.Bottom - R.Top - Tab.GetImages.Height) div 2,
        Tab.ImageIndex, {$IFDEF VisualCLX} itImage, {$ENDIF} Tab.Enabled);
      Inc(R.Left, Tab.GetImages.Width + 2);
    end;

    if Tab.Enabled then
    begin
      if Tab.Selected then
        Font.Assign(Self.SelectedFont)
      else
        Font.Assign(Self.Font);
    end
    else
      Font.Assign(Self.DisabledFont);

    Brush.Style := bsClear;

    // draw text
    TextRect(R, R.Left + 3, R.Top + 3, Tab.Caption);
  end;
end;


{------------------------------------------------------------------------------}
{ TppThemedTabBarPainter.GetThemeTabColor }

function TppThemedTabBarPainter.GetThemeTabColor: TColor;
begin
  Result := CurrentTheme.GetViewColor(VT_TOOLBAR);
//  Result := CurrentTheme.GetViewColor(TVT_MENUBAR);
 // Result := clWindow;
end;

{------------------------------------------------------------------------------}
{ TppTabSet.TBMThemeChange }

procedure TppThemedTabBarPainter.TBMThemeChange(var Message: TMessage);
begin

  if (Message.WParam = TSC_VIEWCHANGE) then
    TabColor := GetThemeTabColor;

end;

end.
