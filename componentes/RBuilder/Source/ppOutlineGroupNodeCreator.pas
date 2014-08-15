{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineGroupNodeCreator;

interface

{$I ppIfDef.pas}

uses

  Classes,
  ppComm, ppRTTI,
  ppOutlineNode, ppOutlineNodeCreator;

type

  {@TppOutlineGroupNodeCreator }

  TppOutlineGroupNodeCreator = class(TppOutlineNodeCreator)
    private

      FFirstNodeOnPage: TppOutlineNode;
      FIsHeaderVisible: Boolean;
      FPreviousNode: TppOutlineNode;

      procedure CreateGroupNode;
      function IsInnermostKeepTogether: Boolean;
      function HasKeepTogetherSubgroup: Boolean;

    public

      constructor Create(aOwner: TComponent); override;

      procedure Initialize; override;
      procedure ProcessPageEnd; override;
      procedure NodeDestroyed(aNode: TppOutlineNode); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure AttemptKeepTogetherRewind;

    end; { class, TppOutlineGroupNodeCreator }

implementation

uses

  ppTypes, ppClass, ppBands, ppReport,
  ppOutline;

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.Create }

constructor TppOutlineGroupNodeCreator.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FFirstNodeOnPage := nil;
  FIsHeaderVisible := False;
  FPreviousNode := nil;

end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.CreateGroupNode }

procedure TppOutlineGroupNodeCreator.CreateGroupNode;
var
  lGroupNode: TppOutlineNode;
begin

  if ((CurrentNode = nil) or not(CurrentNode.Open)) then
    begin

      lGroupNode := TppOutlineNode.Create(nil);
      lGroupNode.Open := True;
      lGroupNode.Active := OutLineSettings.CreateNode;
      lGroupNode.Caption := TppGroup(NodeCreatorComponent).BreakValue;
      lGroupNode.NodeType := ntGroup;
      lGroupNode.PageReference := MainReport.Engine.AbsolutePageNo;
      lGroupNode.ParentNode := ParentNode;

      FPreviousNode := CurrentNode;
      CurrentNode := lGroupNode;

      if lGroupNode.Active then
        lGroupNode.Active := AcceptNodeCreate(lGroupNode);

      if (FFirstNodeOnPage = nil) then
        FFirstNodeOnPage := lGroupNode;

      AddNodeToPageList(lGroupNode);

    end;

end; { procedure, CreateGroupNode }

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.IsInnermostKeepTogether }

function TppOutlineGroupNodeCreator.IsInnermostKeepTogether;
begin

  Result := (TppGroup(NodeCreatorComponent).KeepTogether and not(HasKeepTogetherSubgroup));

end; { function, IsInnermostKeepTogether }

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.HasKeepTogetherSubgroup }

function TppOutlineGroupNodeCreator.HasKeepTogetherSubgroup;
var
  liIndex: Integer;
  lSubgroupNodeCreator: TppOutlineGroupNodeCreator;
begin

  Result := False;
  liIndex := 0;

  while (not(Result) and (liIndex < ChildCount)) do
    if (Children[liIndex] is TppOutlineGroupNodeCreator) then
      begin

        lSubgroupNodeCreator := TppOutlineGroupNodeCreator(Children[liIndex]);

        if TppGroup(lSubgroupNodeCreator.NodeCreatorComponent).KeptTogether then
          Result := True
        else if lSubgroupNodeCreator.HasKeepTogetherSubgroup then
          Result := True
        else
          Inc(liIndex);

      end
    else
      Inc(liIndex);

end; { function, HasKeepTogetherSubgroup }

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.Initialize }

procedure TppOutlineGroupNodeCreator.Initialize;
var
  lGroup: TppGroup;
begin

  lGroup := TppGroup(NodeCreatorComponent);

  lGroup.HeaderBand.AddEventNotify(Self);
  lGroup.FooterBand.AddEventNotify(Self);
  TppBandedReport(lGroup.Report).DetailBand.AddEventNotify(Self);

  EventNotifies := EventNotifies + [ciBandBeforeGenerate, ciBandAfterGenerate];

end; { procedure, PageComplete }

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.ProcessPageEnd }

procedure TppOutlineGroupNodeCreator.ProcessPageEnd;
begin

  CreatePageNodes;

  FFirstNodeOnPage := nil;
  if ((CurrentNode <> nil) and (CurrentNode.Open)) then
    begin
      AddNodeToPageList(CurrentNode);
      FFirstNodeOnPage := CurrentNode;
    end

end; { procedure, ProcessPageEnd }

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.NodeDestroyed }

procedure TppOutlineGroupNodeCreator.NodeDestroyed(aNode: TppOutlineNode);
begin

  if (aNode = CurrentNode) then
    CurrentNode := nil;

  if (aNode = FFirstNodeOnPage) then
    FFirstNodeOnPage := nil;

  if (aNode = FPreviousNode) then
    FPreviousNode := nil;

  inherited NodeDestroyed(aNode);

end; { procedure, NodeDestroyed }

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.EventNotify }

procedure TppOutlineGroupNodeCreator.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lGroup: TppGroup;
begin

  if not(TppOutline(Outline).Locked) then
    begin

      lGroup := TppGroup(NodeCreatorComponent);

      {group header band before generate}
      if ((aCommunicator = lGroup.HeaderBand) and (aEventID = ciBandBeforeGenerate)) then
        begin
          FIsHeaderVisible := (lGroup.HeaderBand.Height > 0) and (lGroup.HeaderBand.Visible);

          if FIsHeaderVisible then
            CreateGroupNode;
        end;

      {detail band after generate}
      if ((aCommunicator = TppBandedReport(lGroup.Report).DetailBand) and (aEventID = ciBandBeforeGenerate)) then
        if not FIsHeaderVisible then
          CreateGroupNode;

      {group footer band after generate}
      if ((aCommunicator = lGroup.FooterBand) and (aEventID = ciBandAfterGenerate)) then
        if (not(TppCustomBand(lGroup.FooterBand).Overflow) and (CurrentNode <> nil)) then
          CurrentNode.Open := False;

    end;

end; { procedure, EventNotify }

{------------------------------------------------------------------------------}
{ TppOutlineGroupNodeCreator.AttemptKeepTogetherRewind }

procedure TppOutlineGroupNodeCreator.AttemptKeepTogetherRewind;
begin

  if ((CurrentNode <> nil) and (CurrentNode.Open)) then
    if ((CurrentNode <> FFirstNodeOnPage) and IsInnermostKeepTogether) then
      begin

        CurrentNode.Free;
        CurrentNode := FPreviousNode;

      end;

end; { procedure, AttemptKeepTogetherRewind }

{------------------------------------------------------------------------------}

end.

