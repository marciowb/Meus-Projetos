{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTreeNode;

interface

uses
  Windows, Messages, SysUtils, Classes,
  ppRelatv, ppRTTI, ppUtils, ppTypes;

type

  {@TppTreeNode

    TppTreeNode is analogous to TTreeNode in a TTreeNodes object. This
    object represents a node in a tree structure. Descendant classes can add
    additional properties.  The tree nodes behave similarly to a TTreeNode
    with methods such as GetFirstChild, GetNextSibling, etc. and properties
    such as Level, ChildNodeCount, and ChildNodes. }

  {@TppTreeNode.AbsoluteIndex

    Indicates the index of the tree node relative to the first node in the tree.
    Use AbsoluteIndex to determine absolute position of a node in a tree nodes
    object.}

  {@TppTreeNode.AbsoluteChildNodeCount

    Indicates the total number of child nodes in the tree structure.}

  {@TppTreeNode.ChildNodeCount

    Indicates the number of immediate children of a tree node. Use in
    conjunction with the ChildNodes array property to iterate through the
    child nodes.}

  {@TppTreeNode.ChildNodes
  
      Use the ChildNodes array to access the immediate children of a tree node.
      The index of the first node is 0 and the index of the last node is
      ChildNodeCount-1.}

  {@TppTreeNode.Level

      Indicates the number of ancestor nodes for a tree node. The value of Level
      is 0 for nodes on the top level. The value of Level is 1 for their
      children, and so on.}

  {@TppTreeNode.ParentNode

      A reference to a tree nodes immediate parent. For the root node in a tree,
      the value of ParentNode is nil.}

  TppTreeNodeClass = class of TppTreeNode;
    
  TppTreeNode = class(TppRelative)
    private

      { read access }
      function GetAbsoluteChildNodeCount: Integer;
      function GetChildNodeCount: Integer;
      function GetChildNodes(aIndex: Integer): TppTreeNode;
      function GetLevel: Integer;
      function GetParentNode: TppTreeNode;

      { write access }
      procedure SetParentNode(aValue: TppTreeNode);
      function GetAbsoluteIndex: Integer;

    protected
      function GetAncestorsNextSibling: TppTreeNode;
      function GetLastChildDescendent: TppTreeNode;
      function CompareNode(aNode: TppTreeNode): Boolean; virtual;

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      function Add: TppTreeNode; virtual;

      { node navigation }
      function GetFirstChild: TppTreeNode;
      function GetLastChild: TppTreeNode;
      function GetNext: TppTreeNode;
      function GetNextSibling: TppTreeNode;
      function GetPrevious: TppTreeNode;
      function GetPreviousSibling: TppTreeNode;

      function CloneNode(aNewParent: TppTreeNode; aRecurse: Boolean): TppTreeNode;
      function IsEqualTo(aNode: TppTreeNode; aRecurse: Boolean): Boolean;

      property AbsoluteIndex: Integer read GetAbsoluteIndex;
      property AbsoluteChildNodeCount: Integer read GetAbsoluteChildNodeCount;
      property ChildNodeCount: Integer read GetChildNodeCount;
      property ChildNodes[aIndex: Integer]: TppTreeNode read GetChildNodes;
      property Level: Integer read GetLevel;
      property ParentNode: TppTreeNode read GetParentNode write SetParentNode;


    published

  end; {class, TppTreeNode}

  {@TraTppTreeNodeRTTI }
  TraTppTreeNodeRTTI = class(TraTppRelativeRTTI)
    public
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppTreeNodeRTTI}


implementation

{******************************************************************************
 *
 ** TppTreeNode
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTreeNode.Create }

constructor TppTreeNode.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

end;{ constructor, Create }

{------------------------------------------------------------------------------}
{ TppTreeNode.Destroy }

destructor TppTreeNode.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy }

{------------------------------------------------------------------------------}
{@TppTreeNode.CloneNode

  Makes a copy itself and assigns aNewParent as the ParentNode property of the
  newly created node. If the aRecurse parameter is true, this method will
  recursively call itself for all nested children. Use this method to copy
  a single node or an entire node tree.}

function TppTreeNode.CloneNode(aNewParent: TppTreeNode; aRecurse: Boolean): TppTreeNode;
var
  lChildNode: TppTreeNode;
begin

  Result := TppTreeNodeClass(ClassType).Create(nil);
  Result.ParentNode := aNewParent;

  Result.Assign(Self);

  if (aRecurse) then
    begin
      lChildNode := GetFirstChild;

      while (lChildNode <> nil) do
        begin
          lChildNode.CloneNode(Result, True);

          lChildNode := lChildNode.GetNextSibling;
        end;
    end;

end;{ function, CloneNode }

{------------------------------------------------------------------------------}
{ TppTreeNode.CompareNode }

function TppTreeNode.CompareNode(aNode: TppTreeNode): Boolean;
begin
  Result := True;

end; {function, CompareNode }

{------------------------------------------------------------------------------}
{@TppTreeNode.GetFirstChild

  Returns a tree node's first child node. If the tree node has no children, this
  function returns nil.}

function TppTreeNode.GetFirstChild: TppTreeNode;
begin

  Result := nil;

  if (ChildNodeCount > 0) then
    Result := ChildNodes[0];

end;{ function, GetFirstChild }

{------------------------------------------------------------------------------}
{@TppTreeNode.GetLastChild

  Returns a tree node's last child node. If the node is the last one in the
  tree, this function returns nil.}

function TppTreeNode.GetLastChild: TppTreeNode;
begin

  Result := nil;

  if (ChildNodeCount > 0) then
    Result := ChildNodes[ChildNodeCount -1];
  
end;{ function, GetLastChild }

{------------------------------------------------------------------------------}
{ TppTreeNode.GetLastChildDescendent }
 
function TppTreeNode.GetLastChildDescendent: TppTreeNode;
var
  lItem: TppTreeNode;
begin
  
  Result := nil;
  
  lItem := Self;
  
  while (lItem.ChildNodeCount > 0) do
    lItem := lItem.GetLastChild;
  
  if (lItem <> self) then
    Result := lItem;
  
end;{ function, GetLastChildDescendent }

{------------------------------------------------------------------------------}
{@TppTreeNode.GetNext

  Returns the next node in the tree. If the node is the last one in the
  tree, this function returns nil. To get the next node at the same level, call
  GetNextSibling.}

function TppTreeNode.GetNext: TppTreeNode;
var
  lNode: TppTreeNode;
begin

  lNode := nil;

  if (ChildNodeCount > 0) then                   (* Does this node have kids? *)
    lNode := ChildNodes[0]

  else                                           (*                 If not... *)
    if (ParentNode <> nil) then
      begin
        lNode := GetNextSibling;                 (* ... then get next sibling *)

        if (lNode = nil) then                    (*  ... or parent's next sib *)
          lNode := GetAncestorsNextSibling; 
      end;

  Result := lNode;

end;{ function, GetNext }

{------------------------------------------------------------------------------}
{@TppTreeNode.GetNextSibling

  Returns the next node that is at the same Level in the tree. If the node is
  the last sibling, this function returns nil. Use GetNext to return the
  next node in the tree. }

function TppTreeNode.GetNextSibling: TppTreeNode;
begin
  
  Result := nil;
  
  if (ParentNode <> nil) and (Index < (ParentNode.ChildNodeCount - 1)) then
    Result := ParentNode.ChildNodes[Index + 1];
  
end;{ function, GetNextSibling }

{------------------------------------------------------------------------------}
{@TppTreeNode.GetPrevious

  Returns the previous node in the tree. If the node is the first one in the
  tree, this function returns nil.  To get the previous node at the same level,
  call GetPreviousSibling.}

function TppTreeNode.GetPrevious: TppTreeNode;
var
  lItem: TppTreeNode;
begin
  
  lItem := GetPreviousSibling;
  
  if (lItem <> nil) then                    (* Do we have a previous sibling? *)
    begin
      Result := lItem.GetLastChildDescendent; (*   ...then get its last child *)
  
      if (Result = nil) then                (*     if previous sibling has no *)
        Result := lItem;                    (* kids then the sib is prev item *)
    end {lItem > nil}
  
  else                                      (*   No previous sibling? Then we *)
    Result := ParentNode;                   (*               move up the tree *)
  
end;{ function, GetPrevious }

{------------------------------------------------------------------------------}
{@TppTreeNode.GetPreviousSibling

  Returns the previous node that is at the same Level in the tree. If the node
  is the first sibling, this function returns nil. Use GetPrevious to return the
  previous node in the tree. }

function TppTreeNode.GetPreviousSibling: TppTreeNode;
begin
  
  Result := nil;
  
  if (ParentNode <> nil) and (Index > 0) then
    Result := ParentNode.ChildNodes[Index - 1];
  
end;{ function, GetPreviousSibling }


{------------------------------------------------------------------------------}
{ TppTreeNode.GetAbsoluteChildNodeCount }
 
function TppTreeNode.GetAbsoluteChildNodeCount: Integer;
var
  lNode: TppTreeNode;
begin
  
  Result := ChildNodeCount;
  
  lNode := GetFirstChild;
  
  while (lNode <> nil) do
    begin
      Result := Result + lNode.AbsoluteChildNodeCount;
      lNode := lNode.GetNextSibling;
    end;
    
end;{ function, GetAbsoluteChildNodeCount }


{------------------------------------------------------------------------------}
{ TppTreeNode.GetChildNodeCount }
 
function TppTreeNode.GetChildNodeCount: Integer;
begin
  Result := ChildCount;
end;{ function, GetChildNodeCount }


{------------------------------------------------------------------------------}
{ TppTreeNode.GetChildNodes }
 
function TppTreeNode.GetChildNodes(aIndex: Integer): TppTreeNode;
begin
  Result := TppTreeNode(Children[aIndex]);
end;{ function, GetChildNodes }


{------------------------------------------------------------------------------}
{ TppTreeNode.GetLevel }
 
function TppTreeNode.GetLevel: Integer;
var
  lItem: TppTreeNode;
begin
  
  Result := 0;
  
  lItem := ParentNode;
  
  while (lItem <> nil) do
    begin
      Inc(Result);
  
      lItem := lItem.ParentNode;
    end;
  
end;{ function, GetLevel }


{------------------------------------------------------------------------------}
{ TppTreeNode.GetParentNode }
 
function TppTreeNode.GetParentNode: TppTreeNode;
begin
  
  if (Parent is TppTreeNode) then
    Result := TppTreeNode(Parent)
  
  else
    Result := nil;
   
end;{ function, GetParentNode }

{------------------------------------------------------------------------------}
{ TppTreeNode.SetParentNode }

procedure TppTreeNode.SetParentNode(aValue: TppTreeNode);
begin
  Parent := aValue;
end;{ procedure, SetParentNode }


{------------------------------------------------------------------------------}
{ TppTreeNode.GetAncestorsNextSibling }

function TppTreeNode.GetAncestorsNextSibling: TppTreeNode;
var
  lNode: TppTreeNode;
begin

  lNode := nil;

  if (ParentNode <> nil) then
    begin
      lNode := ParentNode.GetNextSibling;

      if (lNode = nil) then
        lNode := ParentNode.GetAncestorsNextSibling;
    end;

  Result := lNode;

end;{ function, GetAncestorsNextSibling }

{------------------------------------------------------------------------------}
{@TppTreeNode.Add

  Adds a new child node of the same class type to the tree and assigns
  itself as the parent. Returns an object reference to the newly created
  tree node.}

function TppTreeNode.Add: TppTreeNode;
begin

  Result := TppTreeNode(ClassType).Create(Self);

  Result.Parent := Self;

end;{ function, Add }


{------------------------------------------------------------------------------}
{@TppTreeNode.IsEqualTo

  Compares the properties of aNode to itself and returns true if
  all properties have the same value. If the aRecurse parameter is true, this
  method will recursively call itself for all nested children and return true
  only if all nodes are equivalent. Use this method to dermine whether a single
  node or an entire node tree are equivalent.}

function TppTreeNode.IsEqualTo(aNode: TppTreeNode; aRecurse: Boolean): Boolean;
var
  lbEquivalent: Boolean;
  lNode: TppTreeNode;
  lCompareNode: TppTreeNode;
begin

  if (aNode = Self) then
    Result := True

  else
    begin
      if (aNode <> nil) then
        begin
          lbEquivalent := CompareNode(aNode);

          if not aRecurse then
            Result := lbEquivalent

          else
            begin
              lNode := GetFirstChild;
              lCompareNode := aNode.GetFirstChild;

              while lbEquivalent and (lNode <> nil) do
                begin
                  lbEquivalent := lNode.IsEqualTo(lCompareNode, True);

                  lNode := lNode.GetNext;
                  lCompareNode := lCompareNode.GetNext;
                end;

              Result := lbEquivalent;
            end;
        end

      else
        Result := False;
    end;

end; {procedure, IsEqualTo}


{------------------------------------------------------------------------------}
{ TppTreeNode.GetAbsoluteIndex }

function TppTreeNode.GetAbsoluteIndex: Integer;
var
  lNode: TppTreeNode;
  lTopMostNode: TppTreeNode;
  lSiblingNode: TppTreeNode;
begin

  if (ParentNode <> nil) then
    begin
      lNode := ParentNode;

      while (lNode.ParentNode <> nil) do
        lNode := lNode.ParentNode;

      lTopMostNode := lNode;
    end

  else
    lTopMostNode := Self;

  lSiblingNode := lTopMostNode.GetPreviousSibling;

  if (lSiblingNode <> nil) then
    begin
      while (lSiblingNode.GetPreviousSibling <> nil) do
        lSiblingNode := lSiblingNode.GetPreviousSibling;

      lNode := lSiblingNode;
    end

  else
    lNode := lTopMostNode;

  Result := 0;

  while (lNode <> Self) do
    begin
      lNode := lNode.GetNext;

      Inc(Result);
    end;

end; {procedure, GetAbsoluteIndex}

{******************************************************************************
 *
 ** R T T I   C L A S S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppTreeNodeRTTI.CallMethod }

class function TraTppTreeNodeRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lNode: TppTreeNode;
  liIndex: Integer;
  lBoolean: Boolean;
  lPageNode: TppTreeNode;
  lResultNode: TppTreeNode;
  lPersistent: TPersistent;
begin

  Result := True;

  lNode := TppTreeNode(aObject);

  { access specifiers }

  if (ppEqual(aMethodName, 'ChildNodes')) and (aGet) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultNode := lNode.ChildNodes[liIndex];

      aParams.SetParamValue(1, lResultNode);
    end

  { methods }
  else if (ppEqual(aMethodName, 'Add')) then
    begin
      lResultNode := lNode.Add;

      aParams.SetParamValue(0, lResultNode);
    end

  else if (ppEqual(aMethodName, 'Assign')) then
    begin
      aParams.GetParamValue(0, lPersistent);

      lNode.Assign(lPersistent);
    end

  else if (ppEqual(aMethodName, 'CloneNode')) then
    begin
      aParams.GetParamValue(0, lPageNode);
      aParams.GetParamValue(1, lBoolean);

      lResultNode := lNode.CloneNode(lPageNode, lBoolean);

      aParams.SetParamValue(2, lResultNode);
    end

  else if (ppEqual(aMethodName, 'GetFirstChild')) then
    begin
      lResultNode := lNode.GetFirstChild;

      aParams.SetParamValue(0, lResultNode);
    end

  else if (ppEqual(aMethodName, 'GetLastChild')) then
    begin
      lResultNode := lNode.GetLastChild;

      aParams.SetParamValue(0, lResultNode);
    end

  else if (ppEqual(aMethodName, 'GetLastChildDescendent')) then
    begin
      lResultNode := lNode.GetLastChildDescendent;

      aParams.SetParamValue(0, lResultNode);
    end

  else if (ppEqual(aMethodName, 'GetNext')) then
    begin
      lResultNode := lNode.GetNext;

      aParams.SetParamValue(0, lResultNode);
    end

  else if (ppEqual(aMethodName, 'GetNextSibling')) then
    begin
      lResultNode := lNode.GetNextSibling;

      aParams.SetParamValue(0, lResultNode);
    end

  else if (ppEqual(aMethodName, 'GetPrevious')) then
    begin
      lResultNode := lNode.GetPrevious;

      aParams.SetParamValue(0, lResultNode);
    end

  else if (ppEqual(aMethodName, 'GetPreviousSibling')) then
    begin
      lResultNode := lNode.GetPreviousSibling;

      aParams.SetParamValue(0, lResultNode);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppTreeNodeRTTI.GetParams }

class function TraTppTreeNodeRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (ppEqual(aMethodName, 'Assign')) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Source', daClass, TPersistent, '', False, False);
    end

  else if (ppEqual(aMethodName, 'CloneNode')) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aNewParent', daClass, TppTreeNode, '', False, False);
      Result.AddParam('aRecurse', daBoolean, nil, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}


{------------------------------------------------------------------------------}
{ TraTppTreeNodeRTTI.GetPropList }

class procedure TraTppTreeNodeRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('AbsoluteChildNodeCount');
  aPropList.AddProp('ChildNodeCount');
  aPropList.AddProp('ChildNodes');
  aPropList.AddProp('Level');
  aPropList.AddProp('ParentNode');

  aPropList.AddMethod('Add');
  aPropList.AddMethod('Assign');
  aPropList.AddMethod('CloneNode');
  aPropList.AddMethod('GetFirstChild');
  aPropList.AddMethod('GetLastChild');
  aPropList.AddMethod('GetLastChildDescendent');
  aPropList.AddMethod('GetNext');
  aPropList.AddMethod('GetNextSibling');
  aPropList.AddMethod('GetPrevious');
  aPropList.AddMethod('GetPreviousSibling');

end; {class procedure, GetPropList}


{------------------------------------------------------------------------------}
{ TraTppTreeNodeRTTI.GetPropRec }

class function TraTppTreeNodeRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (ppEqual(aPropName, 'AbsoluteChildNodeCount')) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (ppEqual(aPropName, 'ChildNodeCount')) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (ppEqual(aPropName, 'ChildNodes')) then
    AccessSpecifierToRec(aPropName, aPropRec) 

  else if (ppEqual(aPropName, 'Level')) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (ppEqual(aPropName, 'ParentNode')) then
    ClassPropToRec(aPropName, TppTreeNode, False, aPropRec)

  else if (ppEqual(aPropName, 'Add')) then
    MethodToRec(aPropName, False, aPropRec)

  else if (ppEqual(aPropName, 'Assign')) then
    MethodToRec(aPropName, True, aPropRec)

  else if (ppEqual(aPropName, 'CloneNode')) then
    MethodToRec(aPropName, True, aPropRec)

  else if (ppEqual(aPropName, 'GetFirstChild')) then
    MethodToRec(aPropName, False, aPropRec)

  else if (ppEqual(aPropName, 'GetLastChild')) then
    MethodToRec(aPropName, False, aPropRec)

  else if (ppEqual(aPropName, 'GetLastChildDescendent')) then
    MethodToRec(aPropName, False, aPropRec)

  else if (ppEqual(aPropName, 'GetNext')) then
    MethodToRec(aPropName, False, aPropRec)

  else if (ppEqual(aPropName, 'GetNextSibling')) then
    MethodToRec(aPropName, False, aPropRec)

  else if (ppEqual(aPropName, 'GetPrevious')) then
    MethodToRec(aPropName, False, aPropRec)

  else if (ppEqual(aPropName, 'GetPreviousSibling')) then
    MethodToRec(aPropName, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}


{------------------------------------------------------------------------------}
{ TraTppTreeNodeRTTI.GetPropValue }

class function TraTppTreeNodeRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (ppEqual(aPropName, 'AbsoluteChildNodeCount')) then
    Integer(aValue) := TppTreeNode(aObject).AbsoluteChildNodeCount

  else if (ppEqual(aPropName, 'ChildNodeCount')) then
    Integer(aValue) := TppTreeNode(aObject).ChildNodeCount

  else if (ppEqual(aPropName, 'Level')) then
    Integer(aValue) := TppTreeNode(aObject).Level

  else if (ppEqual(aPropName, 'ParentNode')) then
    TppTreeNode(aValue) := TppTreeNode(aObject).ParentNode

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{------------------------------------------------------------------------------}
{ TraTppTreeNodeRTTI.RefClass }

class function TraTppTreeNodeRTTI.RefClass: TClass;
begin
  Result := TppTreeNode;
end; {class function, RefClass}


{------------------------------------------------------------------------------}
{ TraTppTreeNodeRTTI.SetPropValue }

class function TraTppTreeNodeRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (ppEqual(aPropName, 'ParentNode')) then
    TppTreeNode(aObject).ParentNode := TppTreeNode(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


initialization

  RegisterClass(TppTreeNode);
  raRegisterRTTI(TraTppTreeNodeRTTI);

finalization

  UnRegisterClass(TppTreeNode);
  raUnRegisterRTTI(TraTppTreeNodeRTTI);


end.

