{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppOutlineNode;

interface

{$I ppIfDef.pas}

uses

  Classes,
  ppTypes, ppRelatv, ppTreeNode;

type

  {@TppOutlineNode

    Represents an outline node in a tree structure. Descends from TppTreeNode
    and introduces properties specific to outline nodes.

    Use the Report.OnOutlineNodeCreate event to modify the default Caption
    property assigned to outline nodes during report generation.}

  {@TppOutlineNode.Caption

    The text that is displayed when the outline node is rendered.}

  {@TppOutlineNode.NodeType

    Specifies the type of information represented by the node.

    <Table>
    Value		        Meaning
    -----------     -----------
    ntRoot	        The node represents the root.
    ntReport	      The node represents the report.
    ntSubReport	    The node represents a subreport.
    ntGroup         The node represents a group.
    ntPage          The node represents a page.
    ntNoOutline     The node designates the absence of outline creation.
    ntOther         The default node type assigned by the constructor.
    </Table> }

  {@TppOutlineNode.PageReference

    The page number to which the information in this node corresponds.}

  TppOutlineNode = class(TppTreeNode)
    private

      FActive: Boolean;
      FExpanded: Boolean;
      FCaption: String;
      FNodeCreator: TppRelative;
      FNodeType: TppOutlineNodeType;
      FOpen: Boolean;
      FPageReference: Integer;

      class procedure AttachActiveChildren(aSource, aDestination: TppOutlineNode);

      function HasExistingPageNode(aPageNumber: Integer): Boolean;

    public

      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function CloneActiveRootNode(aSource: TppOutlineNode): TppOutlineNode;

      procedure SetParentComponent(Value: TComponent); override;
      function HasSubnodesReceivingPage: Boolean;
      function EqualTo(aNode: TppOutlineNode): Boolean;

      property Active: Boolean read FActive write FActive;
      property NodeCreator: TppRelative read FNodeCreator write FNodeCreator;
      property Open: Boolean read FOpen write FOpen;

    published

      property Caption: String read FCaption write FCaption;
      property Expanded: Boolean read FExpanded write FExpanded;
      property NodeType: TppOutlineNodeType read FNodeType write FNodeType;
      property PageReference: Integer read FPageReference write FPageReference;

    end; { class, TppOutlineNode }
  
implementation

uses

  ppOutlineNodeCreator, ppOutlineDrawCommand;

{------------------------------------------------------------------------------}
{ TppOutlineNode.Create }

constructor TppOutlineNode.Create(aOwner: TComponent);
begin

  inherited Create(AOwner);

  FActive := True;
  FCaption := '';
  FNodeCreator := nil;
  FNodeType := ntOther;
  FOpen := False;
  FPageReference := 0;
  FExpanded := True;

end; { constructor, Create }

{------------------------------------------------------------------------------}
{ TppOutlineNode.Destroy }

destructor TppOutlineNode.Destroy;
begin

  if (FNodeCreator <> nil) then
    TppOutlineNodeCreator(FNodeCreator).NodeDestroyed(Self);

  inherited Destroy;

end; { destructor, Destroy }

{------------------------------------------------------------------------------}
{ TppOutlineNode.AttachActiveChildren }

class procedure TppOutlineNode.AttachActiveChildren(aSource, aDestination: TppOutlineNode);
var
  liIndex: Integer;
  lbDuplicatePageNode: Boolean;
  lSourceNode: TppOutlineNode;
  lDestinationNode: TppOutlineNode;
begin

  for liIndex := 0 to aSource.ChildNodeCount - 1 do
    begin

      lSourceNode := TppOutlineNode(aSource.ChildNodes[liIndex]);

      if lSourceNode.Active then
        begin

          lbDuplicatePageNode := False;
          if (lSourceNode.NodeType = ntPage) then
            lbDuplicatePageNode := aDestination.HasExistingPageNode(lSourceNode.PageReference);

          if not(lbDuplicatePageNode) then
            begin

              lDestinationNode := TppOutlineNode.Create(nil);
              lDestinationNode.Caption := lSourceNode.Caption;
              lDestinationNode.PageReference := lSourceNode.PageReference;
              lDestinationNode.NodeType := lSourceNode.NodeType;
              lDestinationNode.ParentNode := aDestination;
              lDestinationNode.Expanded := lSourceNode.Expanded;

              AttachActiveChildren(lSourceNode, lDestinationNode);

            end;

        end
      else
        AttachActiveChildren(lSourceNode, aDestination);

    end;

end; { procedure, AttachActiveChildren }

{------------------------------------------------------------------------------}
{ TppOutlineNode.HasExistingPageNode }

function TppOutlineNode.HasExistingPageNode(aPageNumber: Integer): Boolean;
var
  liIndex: Integer;
  lChildNode: TppOutlineNode;
begin

  Result := False;
  liIndex := 0;

  while (not(Result) and (liIndex < ChildNodeCount)) do
    begin

      lChildNode := TppOutlineNode(ChildNodes[liIndex]);

      if ((lChildNode.NodeType = ntPage) and (lChildNode.PageReference = aPageNumber)) then
        Result := True;

      Inc(liIndex);

    end;

end; { function, HasExistingPageNode }

{------------------------------------------------------------------------------}
{ TppOutlineNode.CloneActiveRootNode }

class function TppOutlineNode.CloneActiveRootNode(aSource: TppOutlineNode): TppOutlineNode;
begin

  Result := nil;

  if (aSource.NodeType = ntRoot) then
    begin

      Result := TppOutlineNode.Create(nil);
      Result.Caption := aSource.Caption;
      Result.PageReference := aSource.PageReference;
      Result.NodeType := ntRoot;

      AttachActiveChildren(aSource, Result);

    end;

end; { procedure, CloneActiveRootNode }

{------------------------------------------------------------------------------}
{ TppOutlineNode.SetParentComponent }

procedure TppOutlineNode.SetParentComponent(Value: TComponent);
begin

  if (Value is TppOutlineDrawCommand) then
    TppOutlineDrawCommand(Value).RootNode := Self

  else
    inherited SetParentComponent(Value);

end; { procedure, SetParentComponent }

{------------------------------------------------------------------------------}
{ TppOutlineNode.HasSubnodesReceivingPage }

function TppOutlineNode.HasSubnodesReceivingPage: Boolean;
var
  liIndex: Integer;
begin

  Result := False;
  liIndex := 0;

  while (not(Result) and (liIndex < ChildNodeCount)) do
    if (TppOutlineNode(ChildNodes[liIndex]).NodeCreator <> nil) then
      Result := True
    else
      Inc(liIndex);

end; { function, HasSubnodesReceivingPage }

{------------------------------------------------------------------------------}
{ TppOutlineNode.EqualTo }

function TppOutlineNode.EqualTo(aNode: TppOutlineNode): Boolean;
var
  liIndex: Integer;
  lChildNode: TppOutlineNode;
begin

  Result := (FCaption = aNode.Caption);
  Result := (Result and (FPageReference = aNode.PageReference));
  Result := (Result and (FNodeType = aNode.NodeType));
  Result := (Result and (ChildNodeCount = aNode.ChildNodeCount));

  liIndex := 0;

  while (Result and (liIndex < ChildNodeCount)) do
    begin

      lChildNode := TppOutlineNode(ChildNodes[liIndex]);

      if not(lChildNode.EqualTo(TppOutlineNode(aNode.ChildNodes[liIndex]))) then
        Result := False
      else
        Inc(liIndex);

    end;

end; { function, EqualTo }

{------------------------------------------------------------------------------}

initialization

  RegisterClass(TppOutlineNode);

finalization

  UnRegisterClass(TppOutlineNode);

end.

