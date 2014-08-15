{ RRRRRR                   ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineViewer;

interface

{$I ppIfDef.pas}

uses
  Classes,
  Controls,
  ComCtrls,
  Messages,
  Menus,

  ppTB2Item,
  ppTBX,
  
  ppComm,
  ppDevice,
  ppViewr,
  ppOutlineNode,
  ppOutlineDrawCommand,
  ppToolResources,

  ppPopupMenuBase;

type

  {TppOutlineViewer

    TTreeView descendant that implements the user interface for the report
    outline. The report outline is a feature included with ReportBuilder
    Enterprise.}

  TppOutlineViewer = class(TTreeView)
    private
      FWalkieTalkie: TppCommunicator;
      FComplete: Boolean;
      FNodeCount: Integer;
      FOutlinePopupMenu: TppPopupMenuBase;
      FPreview: TObject;
      FViewer: TppViewer;
      FUpdatingStateCount: Integer;

      function CreateOutlinePopupMenu: TppPopupMenuBase;
      procedure DisableOutline;
      procedure GenerateOutline(aDrawOutline: TppOutlineDrawCommand);
      procedure OutlineTreeMouseDownEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      procedure OutlineNodeChangeEvent(Sender: TObject; Node: TTreeNode);
      procedure OutlineFullExpandEvent(Sender: TObject);
      procedure OutlineFullCollapseEvent(Sender: TObject);
      procedure ProcessOutlineNode(aOutlineNode: TppOutlineNode; aParentTreeNode: TTreeNode);
      procedure ToggleOutlineVisibilityEvent(Sender: TObject);

      function GetOutlineVisible: Boolean;
      function GetUpdatingState: Boolean;
      procedure SetViewer(aViewer: TppViewer);
      procedure SetOutlineVisible(aVisible: Boolean);
      procedure SetUpdatingState(aValue: Boolean);

    protected
      procedure WndProc(var Message: TMessage); override;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;

      property UpdatingState: Boolean read GetUpdatingState write SetUpdatingState;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure EnablePopupMenu;
      procedure LanguageChanged(aOutlineDrawCommand: TppOutlineDrawCommand);
      procedure Reset;
      procedure ScrollToPage(aPageNumber: Integer);
      procedure UpdateOutline(aPage: TppPage);

      property OutlineVisible: Boolean read GetOutlineVisible write SetOutlineVisible;
      property Preview: TObject read FPreview write FPreview;
      property Viewer: TppViewer read FViewer write SetViewer;
      property WalkieTalkie: TppCommunicator read FWalkieTalkie;

    end; {class, TppOutlineViewer }



implementation

uses
  Windows,
  Forms,
  Graphics, ExtCtrls,
  ppTypes, ppUtils, ppPreview,
  ppRTTI;

{@TppOutlineViewer.Create }

constructor TppOutlineViewer.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FComplete := False;
  FNodeCount := 0;
  FOutlinePopupMenu := nil;
  FPreview := nil;
  FViewer := nil;
  FUpdatingStateCount := 0;
  Ctl3D := False;
  BorderStyle := bsNone;

  PopupMenu := nil;
  DoubleBuffered := True;
  HotTrack := True;
  ReadOnly := True;
  ShowRoot := False;
  TabStop := False;
  OnMouseDown := OutlineTreeMouseDownEvent;
  OnChange := OutlineNodeChangeEvent;

  FWalkieTalkie := TppCommunicator.Create(nil);
  FWalkieTalkie.FreeNotification(Self);

end;
   
{@TppOutlineViewer.Destroy }

destructor TppOutlineViewer.Destroy;
begin

  FWalkieTalkie.Free;

  inherited Destroy;

end;

{@TppOutlineViewer.OutlineTreeMouseDownEvent }

procedure TppOutlineViewer.OutlineTreeMouseDownEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  liPageReference: Integer;
  lOutlineTreeNode: TTreeNode;
begin

  lOutlineTreeNode := GetNodeAt(X, Y);

  if ((lOutlineTreeNode <> nil) and (htOnItem in GetHitTestInfoAt(X, Y))) then
    begin

      liPageReference := Integer(lOutlineTreeNode.Data);

      if ((liPageReference > 0) and (FViewer <> nil)) then
        FViewer.GotoPage(liPageReference);

    end;

end;

{@TppOutlineViewer.OutlineNodeChangeEvent }

procedure TppOutlineViewer.OutlineNodeChangeEvent(Sender: TObject; Node: TTreeNode);
var
  liPageReference: Integer;
begin

  if (Node <> nil) then
    begin
      liPageReference := Integer(Node.Data);

      if ((liPageReference > 0) and (FViewer <> nil)) then
        FViewer.GotoPage(liPageReference);

    end;

end;

      
{@TppOutlineViewer.Notification }

procedure TppOutlineViewer.Notification(AComponent: TComponent; Operation: TOperation);
begin

  inherited Notification(aComponent, Operation);

  if (Operation = opRemove) and not(csDestroying in ComponentState) then
    begin

      if (aComponent = FViewer) then
        FViewer := nil

      else if (aComponent = FWalkieTalkie) then
        raise EReportBuilderError.Create('TppOutlineViewer.Notification: Do not try to free the embedded walkie talkie.');

    end;

end;

{@TppOutlineViewer.ProcessOutlineNode }

procedure TppOutlineViewer.ProcessOutlineNode(aOutlineNode: TppOutlineNode; aParentTreeNode: TTreeNode);
var
  liIndex: Integer;
  lTreeNode: TTreeNode;
begin

  if (aOutlineNode <> nil) then
    begin

      lTreeNode := nil;

      Items.BeginUpdate;

      try

        if (aOutlineNode.NodeType <> ntRoot) then
          begin
            lTreeNode := Items.AddChild(aParentTreeNode, aOutlineNode.Caption);
            lTreeNode.Data := Pointer(aOutlineNode.PageReference)
          end;

        for liIndex := 0 to aOutlineNode.ChildNodeCount - 1 do
          ProcessOutlineNode(TppOutlineNode(aOutlineNode.ChildNodes[liIndex]), lTreeNode);

        if aOutlineNode.NodeType <> ntRoot then
          lTreeNode.Expanded := aOutlineNode.Expanded;

      finally
        Items.EndUpdate;
      end;

    end;

end; { procedure, ProcessOutlineNode }

{@TppOutlineViewer.ToggleOutlineVisibilityEvent }

procedure TppOutlineViewer.ToggleOutlineVisibilityEvent(Sender: TObject);
begin

  SetOutlineVisible(not(GetOutlineVisible));

end;

{@TppOutlineViewer.OutlineFullExpandEvent }

procedure TppOutlineViewer.OutlineFullExpandEvent(Sender: TObject);
begin

  Items.BeginUpdate;

  try

    FullExpand;

  finally
    Items.EndUpdate;

  end;

end;

{@TppOutlineViewer.OutlineFullCollapseEvent }

procedure TppOutlineViewer.OutlineFullCollapseEvent(Sender: TObject);
var
  lTopLevelNode: TTreeNode;
begin

  Items.BeginUpdate;

  try

    if (Items.GetFirstNode = nil) then
      lTopLevelNode := nil
    else if ((Items.GetFirstNode.GetNextSibling = nil) or (Items.GetFirstNode.GetNextSibling.Text = '')) then
      lTopLevelNode := Items.GetFirstNode.GetFirstChild
    else
      lTopLevelNode := Items.GetFirstNode;

    while (lTopLevelNode <> nil) do
      begin
        lTopLevelNode.Collapse(True);
        lTopLevelNode := lTopLevelNode.getNextSibling;
      end;

  finally
    Items.EndUpdate;
    
  end;

end;

{@TppOutlineViewer.GetOutlineVisible }

function TppOutlineViewer.GetOutlineVisible: Boolean;
begin
  Result := Visible;
end;

{@TppOutlineViewer.SetOutlineVisible }

procedure TppOutlineViewer.SetOutlineVisible(aVisible: Boolean);
var
  lbSuccess: Boolean;
  lbVisible: Boolean;
  lParams: TraParamList;
begin

  if UpdatingState then Exit;

  UpdatingState := True;

  lbSuccess := False;

  try
    lbSuccess := LockWindowUpdate(Viewer.Parent.Handle);

    FViewer.IncrementalPainting := True;

    Visible := aVisible;

    UpdatingState := False;

    if Visible then
      EnablePopupMenu;

    if (FOutlinePopupMenu <> nil) then
      begin

        if Visible then
          FOutlinePopupMenu.Items[0].Caption := ppLoadStr(1041) {'Hide Outline'}
        else
          FOutlinePopupMenu.Items[0].Caption := ppLoadStr(1042);  {'Show Outline'}

        FOutlinePopupMenu.Items[1].Enabled := Visible;
        FOutlinePopupMenu.Items[2].Enabled := Visible;
      end;

    lParams := TraParamList.Create;

    lbVisible := Visible;

    lParams.AddParam('Visible', daBoolean, nil, '', True, False);
    lParams.SetValuePointer(0, @lbVisible);

    FWalkieTalkie.SendEventNotify(FWalkieTalkie, ciOutlineViewerVisibilityChanged, lParams);

    lParams.Free;

    FViewer.IncrementalPainting := False;

  finally
    if lbSuccess then
      LockWindowUpdate(0);
      
  end;

end;

{@TppOutlineViewer.EnablePopupMenu }

procedure TppOutlineViewer.EnablePopupMenu;
begin

  if (FOutlinePopupMenu = nil) then
    FOutlinePopupMenu := CreateOutlinePopupMenu;

  FViewer.PopupMenu := FOutlinePopupMenu;

  PopupMenu := FOutlinePopupMenu;

end;

{@TppOutlineViewer.WndProc }

procedure TppOutlineViewer.WndProc(var Message: TMessage);
begin

  if (Message.Msg <> WM_LBUTTONDBLCLK) and (Message.Msg <> WM_RBUTTONDOWN) then
    inherited WndProc(Message);

end;

{@TppOutlineViewer.CreateOutlinePopupMenu }

function TppOutlineViewer.CreateOutlinePopupMenu: TppPopupMenuBase;
var
  lMenuItem: TppTBXItem;
begin

  Result := TppPopupMenuBase.Create(Self);
  Result.Images := ToolImageList;

  lMenuItem := Result.AddChildItem();
  lMenuItem.Caption := ppLoadStr(1041); {'Hide Outline'}
  lMenuItem.OnClick := ToggleOutlineVisibilityEvent;

  lMenuItem := Result.AddChildItem();
  lMenuItem.Caption := ppLoadStr(1043); {'Expand Outline'}
  lMenuItem.ImageIndex := ToolImageList.AddTool('PPEXPANDOUTLINE');
  lMenuItem.OnClick := OutlineFullExpandEvent;

  lMenuItem := Result.AddChildItem();
  lMenuItem.Caption := ppLoadStr(1044); {'Collapse Outline'}
  lMenuItem.ImageIndex := ToolImageList.AddTool('PPCOLLAPSEOUTLINE');
  lMenuItem.OnClick := OutlineFullCollapseEvent;

end;

{@TppOutlineViewer.UpdateOutline }

procedure TppOutlineViewer.UpdateOutline(aPage: TppPage);
var
  lDrawOutline: TppOutlineDrawCommand;
  lLastNode: TTreeNode;
begin

  {clear selection}
  if ((Selected <> nil) and (Integer(Selected.Data) <> aPage.AbsolutePageNo)) then
    begin
      {$IFDEF Delphi6}
      ClearSelection;
      {$ELSE}
      Selected := nil;
      {$ENDIF}
    end;

  lDrawOutline := TppOutlineDrawCommand(aPage.GetOutlineDrawCommand);

  if (lDrawOutline <> nil) then
    begin
    
      FComplete := lDrawOutline.Completed;

      {regenerate the outline tree, if needed}
      if (FNodeCount < lDrawOutline.RootNode.AbsoluteChildNodeCount) then
        GenerateOutline(lDrawOutline)

      {Show main node only and no other nodes, hide the '...more...' node text.
       This happens when no nodes are created and the entire report has been
       generated.}
      else if FComplete then
        begin

          if (lDrawOutline.RootNode.ChildNodeCount = 0) or (TppOutlineNode(lDrawOutline.RootNode.ChildNodes[0]).NodeType = ntNoOutline) then
            DisableOutline;

          if (Items.Count > 0) then
            begin
              lLastNode := Items[Items.Count - 1];

              {remove the node representing '...more...' }
              if (lLastNode.Text = ppLoadStr(1045)) then
                Items.Delete(lLastNode);
            end;

        end;

    end;

end;

{@TppOutlineViewer.DisableOutline }

procedure TppOutlineViewer.DisableOutline;
begin
  HotTrack := False;
  ShowHint := False;
end;

{@TppOutlineViewer.ScrollToPage }

procedure TppOutlineViewer.ScrollToPage(aPageNumber: Integer);
var
  liIndex: Integer;
  liPageNumber: Integer;
  lPageNode: TTreeNode;
begin

  if (Selected = nil) then
    begin

      liIndex := 0;
      lPageNode := nil;

      while ((lPageNode = nil) and (liIndex < Items.Count)) do
        begin
          liPageNumber := Integer(Items[liIndex].Data);

          if (liPageNumber = aPageNumber) then
            lPageNode := Items[liIndex]
          else
            Inc(liIndex);

        end;

      Items.BeginUpdate;

      try
        if (lPageNode <> nil) then
          TopItem := lPageNode;

      finally
        Items.EndUpdate;
      end;

    end;

end;

{@TppOutlineViewer.Reset }

procedure TppOutlineViewer.Reset;
begin

  Items.BeginUpdate;

  try
    Items.Clear;
    Selected := nil;
  finally
    Items.EndUpdate;
  end;

  FNodeCount := 0;

  FComplete := False;

  FOutlinePopupMenu.Free;
  FOutlinePopupMenu := nil;

  if (FViewer <> nil) then
    FViewer.PopupMenu := nil;
    
  PopupMenu := nil;

end;

{@TppOutlineViewer.SetViewer }

procedure TppOutlineViewer.SetViewer(aViewer: TppViewer);
begin

  if (FViewer <> nil) then
    FViewer.RemoveFreeNotification(Self);

  FViewer := aViewer;

  if (FViewer <> nil) then
    begin
      FViewer.FreeNotification(Self);

      FViewer.PopupMenu := nil;
    end;

end;
 
{@TppOutlineViewer.GetUpdatingState }

function TppOutlineViewer.GetUpdatingState: Boolean;
begin

  if (FUpdatingStateCount > 0) then
    Result := True
  else
    Result := False;

end;

{@TppOutlineViewer.SetUpdatingState }

procedure TppOutlineViewer.SetUpdatingState(aValue: Boolean);
begin

  if aValue then
    Inc(FUpdatingStateCount)
  else
    Dec(FUpdatingStateCount);

  if (FUpdatingStateCount < 0) then
    FUpdatingStateCount := 0;

end;
     
{@TppOutlineViewer.LanguageChanged }

procedure TppOutlineViewer.LanguageChanged(aOutlineDrawCommand: TppOutlineDrawCommand);
begin

  if (FOutlinePopupMenu <> nil) then
    begin

      if Visible then
        FOutlinePopupMenu.Items[0].Caption := ppLoadStr(1041) {'Hide Outline'}
      else
        FOutlinePopupMenu.Items[0].Caption := ppLoadStr(1042);  {'Show Outline'}

      FOutlinePopupMenu.Items[1].Caption := ppLoadStr(1043); {'Expand Outline'}

      FOutlinePopupMenu.Items[2].Caption := ppLoadStr(1044); {'Collapse Outline'}

    end;

  if (aOutlineDrawCommand <> nil) then
    aOutlineDrawCommand.LanguageChanged;

end;


{@TppOutlineViewer.GenerateOutline }

procedure TppOutlineViewer.GenerateOutline(aDrawOutline: TppOutlineDrawCommand);
var
  lsMoreNotification: String;
begin

  if (aDrawOutline <> nil) then
    begin
      Items.BeginUpdate;

      Items.Clear;

      ProcessOutlineNode(aDrawOutline.RootNode, nil);

      FNodeCount := aDrawOutline.RootNode.AbsoluteChildNodeCount;

      if (FNodeCount > 0) and not(FComplete) then
        begin
          lsMoreNotification := ppLoadStr(1045); // '...more...'
          Items.AddChild(nil, '');
          Items.AddChild(nil, lsMoreNotification);
        end
      else if (FNodeCount = 1) and aDrawOutline.Completed then
        DisableOutline;

      Items.EndUpdate;

    end;

end;

end.

