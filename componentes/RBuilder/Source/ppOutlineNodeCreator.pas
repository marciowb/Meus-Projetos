{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineNodeCreator;

interface

{$I ppIfDef.pas}

uses

  Classes,
  ppClass, ppComm, ppRelatv, ppTypes,                                  
  ppOutlineNode, ppOutlineSettings;

type

  {@TppOutlineNodeCreator }

  TppOutlineNodeCreator = class(TppRelative)
    private

      FCurrentNode: TppOutlineNode;
      FMainReport: TppCustomReport;
      FNodeCreatorComponent: TppCommunicator;
      FNodesReceivingPageNodes: TList;
      FOutline: TppCommunicator;

      function GetParentNode: TppOutlineNode;
      function GetOutlineSettings: TppOutlineSettings;

      procedure SetCurrentNode(aOutlineNode: TppOutlineNode);
      procedure SetOutline(aOutline: TppCommunicator);

    protected

      procedure AddNodeToPageList(aNode: TppOutlineNode);
      function AcceptNodeCreate(aNode: TppOutlineNode): Boolean;

    public

      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure Initialize; virtual; abstract;
      procedure ProcessPageEnd; virtual; abstract;

      procedure CreatePageNodes;
      procedure NodeDestroyed(aNode: TppOutlineNode); virtual;

      property CurrentNode: TppOutlineNode read FCurrentNode write SetCurrentNode;
      property OutlineSettings: TppOutlineSettings read GetOutlineSettings;
      property MainReport: TppCustomReport read FMainReport write FMainReport;
      property NodeCreatorComponent: TppCommunicator read FNodeCreatorComponent write FNodeCreatorComponent;
      property Outline: TppCommunicator read FOutline write SetOutline;
      property ParentNode: TppOutlineNode read GetParentNode;

    end; { class, TppOutlineNodeCreator }

implementation

uses

  SysUtils,
  ppUtils, ppReport,
  ppOutline, ppOutlineParticipant;

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.Create }

constructor TppOutlineNodeCreator.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FCurrentNode := nil;
  FMainReport := nil;
  FNodeCreatorComponent := nil;
  FNodesReceivingPageNodes := TList.Create;
  FOutline := nil;

end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.Destroy }

destructor TppOutlineNodeCreator.Destroy;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FNodesReceivingPageNodes.Count - 1 do
    TppOutlineNode(FNodesReceivingPageNodes[liIndex]).NodeCreator := nil;

  FNodesReceivingPageNodes.Free;

  inherited Destroy;

end; { destructor, Destroy }

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.Notify }

procedure TppOutlineNodeCreator.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) then
    begin

      if (aCommunicator = FCurrentNode) then
        FCurrentNode := nil

      else if (aCommunicator = FOutline) then
        FOutline := nil;

    end;

end;

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.GetParentNode }

function TppOutlineNodeCreator.GetParentNode: TppOutlineNode;
begin

  if (Parent <> nil) and (TppOutlineNodeCreator(Parent).CurrentNode = nil) then
    Result := TppOutlineNodeCreator(Parent).GetParentNode

  else if (Parent <> nil) and (TppOutlineNodeCreator(Parent).CurrentNode <> nil) then
    Result := TppOutlineNodeCreator(Parent).CurrentNode

  else if (FOutline <> nil) then
    Result := TppOutline(FOutline).RootNode

  else
    Result := nil;

end; { function, GetParentNode }

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.GetOutlineSettings }

function TppOutlineNodeCreator.GetOutlineSettings: TppOutlineSettings;
var
  IIParticipant: IppOutlineParticipant;
begin

  Result := nil;

  if (FNodeCreatorComponent <> nil) then
    begin

      FNodeCreatorComponent.GetInterface(IppOutlineParticipant, IIParticipant);

      Result := IIParticipant.iOutlineSettings;

    end;

end; { function, GetOutlineSettings }

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.AddNodeToPageList }

procedure TppOutlineNodeCreator.AddNodeToPageList(aNode: TppOutlineNode);
begin

  if TppReport(FMainReport).OutlineSettings.CreatePageNodes then
    begin

      FNodesReceivingPageNodes.Add(aNode);
      aNode.NodeCreator := Self;

    end;

end; { procedure, AddNodeToPageList }

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.AcceptNodeCreate }

function TppOutlineNodeCreator.AcceptNodeCreate(aNode: TppOutlineNode): Boolean;
begin

  Result := True;

  TppOutline(FOutline).DoOnOutlineNodeCreate(FNodeCreatorComponent, aNode, Result);

end; { function, NodeCreate }

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.CreatePageNodes }

procedure TppOutlineNodeCreator.CreatePageNodes;
var
  lOutlineNode: TppOutlineNode;
  lPageNode: TppOutlineNode;
begin

  if TppReport(FMainReport).OutlineSettings.CreatePageNodes then
    begin

      while (FNodesReceivingPageNodes.Count > 0) do
        begin

          lOutlineNode := TppOutlineNode(FNodesReceivingPageNodes[0]);

          if not(lOutlineNode.HasSubnodesReceivingPage) then
            begin

              lPageNode := TppOutlineNode.Create(nil);
              lPageNode.Open := False;
              lPageNode.Active := True;
              lPageNode.Caption := ppLoadStr(18); // 'Page'
              lPageNode.Caption := lPageNode.Caption + ' ' + IntToStr(MainReport.Engine.AbsolutePageNo);
              lPageNode.NodeType := ntPage;
              lPageNode.PageReference := FMainReport.Engine.AbsolutePageNo;
              lPageNode.ParentNode := lOutlineNode;

              if not(AcceptNodeCreate(lPageNode)) then
                lPageNode.Free;

            end;

          lOutlineNode.NodeCreator := nil;
          FNodesReceivingPageNodes.Remove(lOutlineNode)

        end;

    end;

end; { procedure, CreatePageNodes }

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.NodeDestroyed }

procedure TppOutlineNodeCreator.NodeDestroyed(aNode: TppOutlineNode);
begin

  FNodesReceivingPageNodes.Remove(aNode);

end; { procedure, NodeDestroyed }

{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.SetCurrentNode }

procedure TppOutlineNodeCreator.SetCurrentNode(aOutlineNode: TppOutlineNode);
begin

  if (FCurrentNode <> nil) then
    FCurrentNode.RemoveNotify(Self);

  FCurrentNode := aOutlineNode;

  if (FCurrentNode <> nil) then
    FCurrentNode.AddNotify(Self);

end;


{------------------------------------------------------------------------------}
{ TppOutlineNodeCreator.SetOutline }

procedure TppOutlineNodeCreator.SetOutline(aOutline: TppCommunicator);
begin

  if (FOutline <> nil) then
    FOutline.RemoveNotify(Self);

  FOutline := aOutline;

  if (FOutline <> nil) then
    FOutline.AddNotify(Self);

end;

end.

