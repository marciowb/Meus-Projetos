{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daLinkManager;

interface

uses
  Classes, Controls, Graphics, ExtCtrls, Windows, Forms,
  ppComm, ppClass, ppTypes, ppDsgnDB,
  daForms, daDataModule, daDataViewToolWin, daVisualLink, daVisualLinkHint;

type

  { TdaLinkManager

    Handles the drawing and editing of the visual links which can be created
    between dataviews

     - created by TdaDataManager
     - references the workspace, paintbox, datamodule
     - handles link related mouse events (workspace and dataview toolwindows)}

  TdaLinkManager = class(TppCommunicator)
    private
      FDataManager: TComponent;
      FDataModule: TdaDataModule;
      FEndLinkDataView: TdaDataView;
      FEndLinkFieldAlias: String;
      FLanguageIndex: Integer;
      FLinkColors: TList;
      FLinking: Boolean;
      FPaintBox: TPaintBox;
      FSaveAppMessageHandler: TMessageEvent;
      FSelectedVisualLink: TdaVisualLink;
      FStartLinkDataViewWindow: TdaDataViewToolWin;
      FStartLinkDataView: TdaDataView;
      FStartLinkFieldAlias: String;
      FVisualLinkHint: TdaVisualLinkHint;
      FVisualLinks: TList;
      FWorkSpace: TdaScrollBox;

      procedure ApplicationMessageEvent(var Msg: TMsg; var Handled: Boolean);
      function CreateVisualLink(aLinkColor: TColor; aMasterToolWin, aDetailToolWin: TdaDataViewToolWin; aMasterFieldName, aDetailFieldName: String; aDetailIndex: Integer): TdaVisualLink;
      procedure CreateVisualLinksForDataView(aDataView: TdaDataView; aToolWindow: TdaDataViewToolWin);
      procedure EndLinking;
      procedure FreeVisualLinksInList(aStrings: TStrings);
      function GetLinkColor: TColor;
      procedure GetVisualLinksForDataView(aDataView: TdaDataView; aStrings: TStrings);
      function GetVisualLink(aIndex: Integer): TdaVisualLink;
      procedure PaintBoxClickEvent(Sender: TObject);
      procedure PaintBoxDblClickEvent(Sender: TObject);
      procedure PaintBoxPaintEvent(Sender: TObject);
      procedure RestoreLinkColor(aColor: TColor);
      procedure RefillLinkColors;
      procedure SetDataModule(aDataModule: TdaDataModule);
      procedure SetLanguageIndex(aLanguageIndex: Integer);
      procedure SetSelectedVisualLink(aVisualLink: TdaVisualLink);
      procedure UpdateLinkDescription;
      procedure UseLinkColor(aColor: TColor);
      procedure VisualLinkPaintSelfEvent(Sender: TObject);
      procedure WorkspaceMouseMoveEvent(Sender: TObject; Shift: TShiftState; X, Y: Integer);
      procedure WorkspaceMouseUpEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure DataViewDeleted(aDataView: TdaDataView);
      procedure EditLinks(aDataView: TdaDataView);
      procedure InitializeVisualLinks;
      procedure NewDataView(aDataView: TdaDataView; aDataDictionary: TppDataDictionary);
      procedure RemoveVisualLinksForDataView(aDataView: TdaDataView);
      procedure SetVisualControls(aWorkspace: TdaScrollBox; aPaintBox: TPaintBox);
      procedure UpdateVisualLinksForDataView(aDataView: TdaDataView);

      procedure DataViewDeleteKeyDownEvent(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure DataViewDeleteLinkEvent(Sender: TObject);
      procedure DataViewEndLinkEvent(Sender: TObject; aDataView: TdaDataView; aFieldAlias: String);
      procedure DataViewLinkingEvent(Sender: TObject; aDataView: TdaDataView; aFieldAlias: String);
      procedure DataViewSelectFieldEvent(Sender: TObject);
      procedure DataViewStartLinkEvent(Sender: TObject; aDataView: TdaDataView; aFieldAlias: String);

      property DataModule: TdaDataModule read FDataModule write SetDataModule;
      property LanguageIndex: Integer read FLanguageIndex write SetLanguageIndex;

  end; {class, TdaLinkManager}


implementation

uses
  Messages, Dialogs,
  daDataManager;
  
{******************************************************************************
 *
 ** L I N K   M A N A G E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaLinkManager.Create }

constructor TdaLinkManager.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDataManager := aOwner;
  FDataModule := nil;
  FEndLinkDataView := nil;
  FEndLinkFieldAlias := '';
  FLinkColors := nil;
  FLinking := False;
  FPaintBox := nil;
  FSaveAppMessageHandler := nil;
  FSelectedVisualLink := nil;
  FStartLinkDataView := nil;
  FStartLinkFieldAlias := '';
  FVisualLinkHint := nil;
  FVisualLinks := nil;
  FWorkSpace := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaLinkManager.Destroy }

destructor TdaLinkManager.Destroy;
begin

  FLinkColors.Free;
  FVisualLinks.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaLinkManager.Notify }

procedure TdaLinkManager.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator = FDataModule) then
    FDataModule := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaLinkManager.EditLinks }

procedure TdaLinkManager.EditLinks(aDataView: TdaDataView);
var
  lList: TList;
begin

  lList := TList.Create;

  try
    FDataModule.GetLinkableDataViewsForDataView(lList, aDataView);

    if (lList.Count > 0) then
      aDataView.Link(lList);

    UpdateVisualLinksForDataView(aDataView);

    TdaDataManager(FDataManager).UpdateEnabledOptions;

    FDataModule.Modified := True;

  finally
    lList.Free;
  end;

end; {procedure, EditLinks}

{------------------------------------------------------------------------------}
{ TdaLinkManager.NewDataView }

procedure TdaLinkManager.NewDataView(aDataView: TdaDataView; aDataDictionary: TppDataDictionary);
var
  lDataViews: TList;
  liIndex: Integer;
begin

  if not(aDataView.IsLinkable) then Exit;

  aDataView.LinkColor := GetLinkColor;

  lDataViews := TList.Create;
  FDataModule.GetLinkableDataViewsForDataView(lDataViews, aDataView);

  try
    if (lDataViews.Count > 0) then
      begin
        aDataView.CreateAutoLink(lDataViews, aDataDictionary);

        for liIndex := 0 to lDataViews.Count - 1 do
          UpdateVisualLinksForDataView(TdaDataView(lDataViews[liIndex]));
      end;

  finally
    lDataViews.Free;
  end;
  
end; {procedure, NewDataView}

{------------------------------------------------------------------------------}
{ TdaLinkManager.DataViewDeleted }

procedure TdaLinkManager.DataViewDeleted(aDataView: TdaDataView);
begin
  RestoreLinkColor(aDataView.LinkColor);
end; {procedure, DataViewDeleted}

{------------------------------------------------------------------------------}
{ TdaLinkManager.SetDataModule }

procedure TdaLinkManager.SetDataModule(aDataModule: TdaDataModule);
begin

  if FDataModule <> nil then
    FDataModule.RemoveNotify(Self);

  FDataModule := aDataModule;

  if FDataModule <> nil then
    FDataModule.AddNotify(Self);

  if (FDataModule <> nil) and (FDataModule.DataViewCount = 0) then
    RefillLinkColors;

end; {procedure, SetDataModule}

{------------------------------------------------------------------------------}
{ TdaLinkManager.SetVisualControls }

procedure TdaLinkManager.SetVisualControls(aWorkspace: TdaScrollBox; aPaintBox: TPaintBox);
begin

  FWorkspace := aWorkspace;
  FPaintBox := aPaintBox;

  FPaintBox.OnPaint := PaintBoxPaintEvent;
  FPaintBox.OnClick := PaintBoxClickEvent;
  FPaintBox.OnDblClick := PaintBoxDblClickEvent;

end; {procedure, SetVisualControls}

{------------------------------------------------------------------------------}
{ TdaLinkManager.SetLanguageIndex}

procedure TdaLinkManager.SetLanguageIndex(aLanguageIndex: Longint);
begin

  if (FVisualLinkHint <> nil) then
    FVisualLinkHint.LanguageIndex := aLanguageIndex;

end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TdaLinkManager.VisualLinkPaintSelfEvent }

procedure TdaLinkManager.VisualLinkPaintSelfEvent(Sender: TObject);
var
  liIndex: Integer;
  lVisualLink: TdaVisualLink;
  lSender: TdaVisualLink;
begin

  lSender := TdaVisualLink(Sender);

  for liIndex := 0 to FVisualLinks.Count - 1 do
    begin
      lVisualLink := GetVisualLink(liIndex);

      if (lVisualLink <> lSender) and (lVisualLink.Overlaps(lSender)) then
        lVisualLink.Paint;
    end;

end; {procedure, VisualLinkPaintSelfEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.PaintBoxPaintEvent }

procedure TdaLinkManager.PaintBoxPaintEvent(Sender: TObject);
var
  liIndex: Integer;
begin

  if (FVisualLinks = nil) then Exit;

  for liIndex := 0 to FVisualLinks.Count - 1 do
    GetVisualLink(liIndex).Paint;

end; {procedure, PaintBoxPaintEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.PaintBoxClickEvent }

procedure TdaLinkManager.PaintBoxClickEvent(Sender: TObject);
var
  liIndex: Integer;
  lVisualLink: TdaVisualLink;
  lSelectedLink: TdaVisualLink;
begin

  if (FVisualLinks <> nil) then
    begin

      lSelectedLink := nil;

      {find the clicked click, if any}
      liIndex := 0;

      while (lSelectedLink = nil) and (liIndex < FVisualLinks.Count) do
        begin
          lVisualLink := GetVisualLink(liIndex);

          if lVisualLink.IsHotPoint(Mouse.CursorPos.X, Mouse.CursorPos.Y) then
            lSelectedLink := lVisualLink;

          Inc(liIndex);
        end;

      SetSelectedVisualLink(lSelectedLink);
      
    end;

end; {procedure, PaintBoxClickEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.SetSelectedVisualLink }

procedure TdaLinkManager.SetSelectedVisualLink(aVisualLink: TdaVisualLink);
begin

  {deselect the previously selected link}
  if (FSelectedVisualLink <> nil) and (FSelectedVisualLink <> aVisualLink) then
    begin
      FSelectedVisualLink.Selected := False;

      FWorkSpace.OnKeyDown := nil;

      FSelectedVisualLink := nil;
    end;

  {select the clicked link}
  if (aVisualLink <> nil) then
    begin
      FSelectedVisualLink := aVisualLink;

      FWorkSpace.OnKeyDown := DataViewDeleteKeyDownEvent;

      FSelectedVisualLink.Selected := True;
    end;

end; {procedure, PaintBoxClickEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.DataViewDeleteKeyDownEvent }

procedure TdaLinkManager.DataViewDeleteKeyDownEvent(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  lDataView: TdaDataView;
begin

  if (Key = VK_DELETE) and (FSelectedVisualLink <> nil) then
    begin
      lDataView := FSelectedVisualLink.Detail.DataView;

      lDataView.DeleteLink(FSelectedVisualLink.DetailIndex);
      
      FDataModule.Modified := True;
    end;

end; {procedure, DataViewDeleteKeyDownEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.PaintBoxDblClickEvent }

procedure TdaLinkManager.PaintBoxDblClickEvent(Sender: TObject);
var
  lbHandled: Boolean;
  liIndex: Integer;
  lVisualLink: TdaVisualLink;
  lDataView: TdaDataView;
  lList: TList;
begin

  if (FVisualLinks = nil) then Exit;

  lbHandled := False;
  liIndex := 0;

  while not(lbHandled) and (liIndex < FVisualLinks.Count) do
    begin
      lVisualLink := GetVisualLink(liIndex);

      lbHandled := lVisualLink.IsHotPoint(Mouse.CursorPos.X, Mouse.CursorPos.Y);

      if lbHandled then
        begin
          lDataView := lVisualLink.Detail.DataView;

          lList := TList.Create;

          try
            FDataModule.GetLinkableDataViewsForDataView(lList, lDataView);

            lDataView.Link(lList);

            UpdateVisualLinksForDataView(lDataView);

            TdaDataManager(FDataManager).UpdateEnabledOptions;

          finally
            lList.Free;
          end;

        end

      else
        Inc(liIndex);
    end;
    
end; {procedure, PaintBoxDblClickEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.InitializeVisualLinks }

procedure TdaLinkManager.InitializeVisualLinks;
var
  liIndex: Integer;
  lDataView: TdaDataView;
  lToolWindow: TdaDataViewToolWin;
begin

  if (FDataModule = nil) then Exit;

  RefillLinkColors;

  for liIndex := 0 to FDataModule.DataViewCount - 1 do
    begin
      lDataView := FDataModule.DataViews[liIndex];

      if lDataView.IsLinkable then
        begin
          UseLinkColor(lDataView.LinkColor);

          lToolWindow := TdaDataViewToolWin(TdaDataManager(FDataManager).DataViewWindows[liIndex]);

          CreateVisualLinksForDataView(lDataView, lToolWindow);
        end;

    end;

end; {procedure, InitializeVisualLinks}

{------------------------------------------------------------------------------}
{ TdaLinkManager.CreateVisualLinksForDataView }

procedure TdaLinkManager.CreateVisualLinksForDataView(aDataView: TdaDataView; aToolWindow: TdaDataViewToolWin);
var
  liIndex: Integer;
  lMasterDataView: TdaDataView;
  lMasterToolWindow: TdaDataViewToolWin;
  lsMasterFieldName: String;
  lsDetailFieldName: String;
  lVisualLink: TdaVisualLink;
  lLinkColor: TColor;
begin

  lMasterDataview := aDataView.MasterDataView;

  if (lMasterDataView = nil) then Exit;

  lMasterToolWindow := TdaDataManager(FDataManager).GetToolWindowForDataView(lMasterDataview);

  for liIndex := 0 to aDataView.GetLinkCount - 1 do
    begin
      aDataView.GetLinkFieldNames(liIndex, lsMasterFieldName, lsDetailFieldName);

      lLinkColor := aDataView.GetLinkColorForField(lsDetailFieldName);

      lVisualLink := CreateVisualLink(lLinkColor, lMasterToolWindow, aToolWindow, lsMasterFieldName, lsDetailFieldName, liIndex);

      if (FVisualLinks = nil) then
        FVisualLinks := TList.Create;

      FVisualLinks.Add(lVisualLink);
    end;

end; {procedure, CreateVisualLinksForDataView}

{------------------------------------------------------------------------------}
{ TdaLinkManager.CreateVisualLink }

function TdaLinkManager.CreateVisualLink(aLinkColor: TColor; aMasterToolWin, aDetailToolWin: TdaDataViewToolWin; aMasterFieldName, aDetailFieldName: String; aDetailIndex: Integer): TdaVisualLink;
begin

  Result := TdaVisualLink.CreateLink(FPaintBox, FWorkSpace);
  Result.Master := aMasterToolWin;
  Result.MasterFieldName := aMasterFieldName;
  Result.Detail := aDetailToolWin;
  Result.DetailFieldName := aDetailFieldName;
  Result.DetailIndex := aDetailIndex;
  Result.Color := aLinkColor;
  Result.OnPaintSelf := VisualLinkPaintSelfEvent;

end; {function, CreateVisualLink}

{------------------------------------------------------------------------------}
{ TdaLinkManager.RemoveVisualLinksForDataView }

procedure TdaLinkManager.RemoveVisualLinksForDataView(aDataView: TdaDataView);
var
  lDataViews: TList;
  lVisualLinks: TStrings;
  liIndex: Integer;
  lDataView: TdaDataView;
begin

  lDataViews := TList.Create;


  FDataModule.GetDetailDataViews(aDataView, lDataViews);

  {add the passed dataview, since we need to delete all of its links}
  lDataViews.Add(aDataView);


  lVisualLinks := TStringList.Create;

  try
    for liIndex := 0 to lDataViews.Count - 1 do
      begin
        lDataView := TdaDataView(lDataViews[liIndex]);

        GetVisualLinksForDataView(lDataView, lVisualLinks);

        FreeVisualLinksInList(lVisualLinks);
      end;
  finally
    lDataViews.Free;
    lVisualLinks.Free;
  end;

end; {procedure, RemoveVisualLinksForDataView}

{------------------------------------------------------------------------------}
{ TdaLinkManager.GetVisualLink }

function TdaLinkManager.GetVisualLink(aIndex: Integer): TdaVisualLink;
begin
  Result := TdaVisualLink(FVisualLinks[aIndex]);

end; {procedure, GetVisualLink}

{------------------------------------------------------------------------------}
{ TdaLinkManager.GetVisualLinksForDataView }

procedure TdaLinkManager.GetVisualLinksForDataView(aDataView: TdaDataView; aStrings: TStrings);
var
  liIndex: Integer;
  lVisualLink: TdaVisualLink;
  lsKey: String;
begin

  aStrings.Clear;

  if (FVisualLinks = nil) then Exit;

  for liIndex := 0 to FVisualLinks.Count - 1 do
    begin
      lVisualLink := GetVisualLink(liIndex);

      if (lVisualLink.Detail.DataView = aDataView) then
        begin
          lsKey := lVisualLink.MasterFieldName + lVisualLink.DetailFieldName;

          aStrings.AddObject(lsKey, lVisualLink);
        end;

    end;

end; {procedure, GetVisualLinksForDataView}

{------------------------------------------------------------------------------}
{ TdaLinkManager.FreeVisualLinksInList }

procedure TdaLinkManager.FreeVisualLinksInList(aStrings: TStrings);
var
  liIndex: Integer;
  liPosition: Integer;
  lVisualLink: TdaVisualLink;
begin

  for liIndex := 0 to aStrings.Count - 1 do
    begin
      lVisualLink := TdaVisualLink(aStrings.Objects[liIndex]);

      liPosition := FVisualLinks.IndexOf(lVisualLink);
      FVisualLinks.Delete(liPosition);

      lVisualLink.Visible := False;

      if (FSelectedVisualLink = lVisualLink) then
        SetSelectedVisualLink(nil);

      lVisualLink.Free;
    end;

  FPaintBox.Refresh;

end; {procedure, FreeVisualLinksInList}

{------------------------------------------------------------------------------}
{ TdaLinkManager.UpdateVisualLinksForDataView }

procedure TdaLinkManager.UpdateVisualLinksForDataView(aDataView: TdaDataView);
var
  liIndex: Integer;
  liPosition: Integer;
  lMasterDataView: TdaDataView;
  lMasterToolWindow: TdaDataViewToolWin;
  lDetailToolWindow: TdaDataViewToolWin;
  lsMasterFieldName: String;
  lsDetailFieldName: String;
  lVisualLink: TdaVisualLink;
  lVisualLinks: TStringList;
  lsKey: String;
  lbCreateLink: Boolean;
  lLinkColor: TColor;
begin

  {collect all visual links for this dataview}
  lVisualLinks := TStringList.Create;

  GetVisualLinksForDataView(aDataView, lVisualLinks);

  lMasterDataview := aDataView.MasterDataView;

  if (lMasterDataView <> nil) then
    begin

      lMasterToolWindow := TdaDataManager(FDataManager).GetToolWindowForDataView(lMasterDataview);
      lDetailToolWindow := TdaDataManager(FDataManager).GetToolWindowForDataView(aDataview);

      for liIndex := 0 to aDataView.GetLinkCount - 1 do
        begin
          aDataView.GetLinkFieldNames(liIndex, lsMasterFieldName, lsDetailFieldName);

          lbCreateLink := False;

          lsKey := lsMasterFieldName + lsDetailFieldName;

          liPosition := lVisualLinks.IndexOf(lsKey);

          if (liPosition <> -1) then
            begin
              lVisualLink := TdaVisualLink(lVisualLinks.Objects[liPosition]);

              lVisualLink.DetailIndex := liIndex;

              if (lVisualLink.Master = lMasterToolWindow) then
                lVisualLinks.Delete(liPosition)
              else
                lbCreateLink := True;
            end
          else
            lbCreateLink := True;

          if (lbCreateLink) then
            begin
              lLinkColor := aDataView.GetLinkColorForField(lsDetailFieldName);
              
              lVisualLink := CreateVisualLink(lLinkColor, lMasterToolWindow, lDetailToolWindow, lsMasterFieldName, lsDetailFieldName, liIndex);

              if (FVisualLinks = nil) then
                FVisualLinks := TList.Create;

              FVisualLinks.Add(lVisualLink);
            end;
        end;

    end;

  {free any visual links that were not found in the MasterFieldLinkItems property}
  FreeVisualLinksInList(lVisualLinks);

  {free the list}
  lVisualLinks.Free;

end; {procedure, UpdateVisualLinksForDataView}

{------------------------------------------------------------------------------}
{ TdaLinkManager.DataViewDeleteLinkEvent }

procedure TdaLinkManager.DataViewDeleteLinkEvent(Sender: TObject);
var
  lDataView: TdaDataView;
begin

  lDataView := TdaDataViewToolWin(Sender).DataView;

  UpdateVisualLinksForDataView(lDataView);

  TdaDataManager(FDataManager).UpdateEnabledOptions;

end; {procedure, DataViewDeleteLinkEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.DataViewSelectFieldEvent }

procedure TdaLinkManager.DataViewSelectFieldEvent(Sender: TObject);
begin
  SetSelectedVisualLink(nil);
end; {procedure, DataViewSelectFieldEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.DataViewStartLinkEvent }

procedure TdaLinkManager.DataViewStartLinkEvent(Sender: TObject; aDataView: TdaDataView; aFieldAlias: String);
begin

  if (FVisualLinkHint = nil) then
    begin
      FVisualLinkHint := TdaVisualLinkHint.Create(Self);
      FVisualLinkHint.Parent := FWorkspace;
      FVisualLinkHint.LanguageIndex := LanguageIndex;
    end;

  FStartLinkDataViewWindow := TdaDataViewToolWin(Sender);
  FStartLinkDataView := aDataView;
  FStartLinkFieldAlias := aFieldAlias;
  FEndLinkDataView := nil;
  FEndLinkFieldAlias := '';
  FLinking := True;

  UpdateLinkDescription;

  FVisualLinkHint.Visible := True;
  FVisualLinkHint.BringToFront;

  FWorkspace.OnMouseMove := WorkspaceMouseMoveEvent;
  FWorkspace.OnMouseUp := WorkspaceMouseUpEvent;

  FSaveAppMessageHandler := Application.OnMessage;

  Application.OnMessage := ApplicationMessageEvent;

end; {procedure, DataViewStartLinkEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.DataViewLinkingEvent }

procedure TdaLinkManager.DataViewLinkingEvent(Sender: TObject; aDataView: TdaDataView; aFieldAlias: String);
begin

  if (FStartLinkDataView = nil) or (FStartLinkDataView = aDataView) or
    (aDataView.InMasterChain(FStartLinkDataView)) or not(aDataView.IsLinkableAsMaster) then Exit;

  FEndLinkDataView := aDataView;
  FEndLinkFieldAlias := aFieldAlias;

  UpdateLinkDescription;

end; {procedure, DataViewLinkingEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.DataViewEndLinkEvent }

procedure TdaLinkManager.DataViewEndLinkEvent(Sender: TObject; aDataView: TdaDataView; aFieldAlias: String);
begin
  EndLinking;

end; {procedure, DataViewEndLinkEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.WorkspaceMouseMoveEvent }

procedure TdaLinkManager.WorkspaceMouseMoveEvent(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin

  FEndLinkDataView := nil;
  FEndLinkFieldAlias := '';

  UpdateLinkDescription;

end; {procedure, WorkspaceMouseMoveEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.WorkspaceMouseUpEvent }

procedure TdaLinkManager.WorkspaceMouseUpEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  EndLinking;

  FLinking := False;

  FStartLinkDataView := nil;
  FStartLinkFieldAlias := '';

end; {procedure, WorkspaceMouseUpEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.ApplicationMessageEvent }

procedure TdaLinkManager.ApplicationMessageEvent(var Msg: TMsg; var Handled: Boolean);
var
  lPoint: TPoint;
begin

  if (Msg.Message = WM_MOUSEMOVE) then
    begin
      lPoint := FWorkSpace.ScreenToClient(Mouse.CursorPos);

      FVisualLinkHint.Left := lPoint.X + 5;
      FVisualLinkHint.Top := lPoint.Y + 20;
    end

  else if (Msg.Message = WM_LBUTTONUP) then
    EndLinking

  else if (Msg.Message = WM_RBUTTONDOWN) or ((Msg.Message = WM_KEYUP) and (Msg.WPARAM = VK_ESCAPE)) then
    begin

      EndLinking;

      FLinking := False;

      FStartLinkDataView := nil;
      FStartLinkFieldAlias := '';

      Handled := True;
    end;

end; {procedure, ApplicationMessageEvent}

{------------------------------------------------------------------------------}
{ TdaLinkManager.UpdateLinkDescription }

procedure TdaLinkManager.UpdateLinkDescription;
var
  lsEndLinkDataView: String;
begin

  if (FEndLinkDataView = nil) or (FEndLinkFieldAlias = '') then
    lsEndLinkDataView := ''
  else
    lsEndLinkDataView := FEndLinkDataView.Description;

  if (FVisualLinkHint <> nil) then
    FVisualLinkHint.UpdateDescription(FStartLinkDataView.Description, FStartLinkFieldAlias, lsEndLinkDataView, FEndLinkFieldAlias, FStartLinkDataView.LinkColor);

end; {procedure, UpdateLinkDescription}

{------------------------------------------------------------------------------}
{ TdaLinkManager.EndLinking }

procedure TdaLinkManager.EndLinking;
begin
  if FLinking and (FEndLinkDataView <> nil) then

    begin
      FStartLinkDataView.CreateLink(FEndLinkDataView, FEndLinkFieldAlias, FStartLinkFieldAlias);

      UpdateVisualLinksForDataView(FStartLinkDataView);

      TdaDataManager(FDataManager).UpdateEnabledOptions;

      FDataModule.Modified := True;
    end;

  if FLinking then
    Application.OnMessage := FSaveAppMessageHandler;

  FLinking := False;

  FStartLinkDataView := nil;
  FStartLinkFieldAlias := '';

  FWorkSpace.OnMouseMove := nil;

  if (FVisualLinkHint <> nil) then
    FVisualLinkHint.Visible := False;

  if (FStartLinkDataViewWindow <> nil) then
    FStartLinkDataViewWindow.Linking := False;

  FEndLinkDataView := nil;
  FEndLinkFieldAlias := '';

end; {procedure, EndLinking}

{------------------------------------------------------------------------------}
{ TdaLinkManager.RefillLinkColors }

procedure TdaLinkManager.RefillLinkColors;
begin

  if (FLinkColors = nil) then
    begin
      FLinkColors := TList.Create;

      FLinkColors.Count := 4;
    end;

  FLinkColors[0] := TObject(clMaroon);
  FLinkColors[1] := TObject(clNavy);
  FLinkColors[2] := TObject(clGreen);
  FLinkColors[3] := TObject(clPurple);

end; {procedure, RefillLinkColors}

{------------------------------------------------------------------------------}
{ TdaLinkManager.GetLinkColor }

function TdaLinkManager.GetLinkColor: TColor;
var
  liIndex: Integer;
  lbColorFound: Boolean;
begin

  Result := 0;

  if (FLinkColors = nil) then
    RefillLinkColors;

  lbColorFound := False;
  liIndex := 0;

  while not(lbColorFound) and (liIndex < FLinkColors.Count) do
    begin
      if (TColor(FLinkColors[liIndex]) <> -1) then
        begin
          lbColorFound := True;

          Result := TColor(FLinkColors[liIndex]);
          
          FLinkColors[liIndex] := TObject(-1);
        end
      else
        Inc(liIndex);
    end;

  if not(lbColorFound) then
    begin
      RefillLinkColors;

      Result := TColor(FLinkColors[0]);

      UseLinkColor(TColor(FLinkColors[0]));
    end;

end; {function, GetLinkColor}

{------------------------------------------------------------------------------}
{ TdaLinkManager.UseLinkColor }

procedure TdaLinkManager.UseLinkColor(aColor: TColor);
var
  liIndex: Integer;
  lbColorUsed: Boolean;
begin

  if (FLinkColors = nil) then
    RefillLinkColors;

  lbColorUsed := False;
  liIndex := 0;

  while not(lbColorUsed) and (liIndex < FLinkColors.Count) do
    begin
      if (TColor(FLinkColors[liIndex]) = aColor) then
        begin
          lbColorUsed := True;

          FLinkColors[liIndex] := TObject(-1);
        end
      else
        Inc(liIndex);
    end;

end; {procedure, UseLinkColor}

{------------------------------------------------------------------------------}
{ TdaLinkManager.RestoreLinkColor }

procedure TdaLinkManager.RestoreLinkColor(aColor: TColor);
begin

  if (FLinkColors <> nil) then
    begin

      case aColor of
        clMaroon: FLinkColors[0] := TObject(clMaroon);
        clNavy: FLinkColors[1] := TObject(clNavy);
        clGreen: FLinkColors[2] := TObject(clGreen);
        clPurple: FLinkColors[3] := TObject(clPurple);
      end;
    end;

end; {procedure, RestoreLinkColor}

end.
