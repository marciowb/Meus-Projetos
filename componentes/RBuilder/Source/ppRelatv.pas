{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppRelatv;

interface

{$I ppIfDef.pas}

uses
  SysUtils, Classes, ppComm, ppUtils, ppTypes, ppRTTI;

type

  TppRelativeClass = class of TppRelative;

  {@TppRelative

    TppRelative is an abstract ancestor for components that particepate in
    parent/child relationships. A relative can be a parent, a child, or both.
    TppRelatives introduces properties and methods that can be used to manage
    parent/child relationships. }

  TppRelative = class(TppCommunicator)
    private
      FChildren: TList;
      FChildType: Integer;
      FFreeingChildren: Boolean;
      FKeyPropName: String;
      FOrderedChildren: Boolean;
      FParent: TppRelative;
      FPosition: Integer;

      {parent procedures}
      procedure FixChildList;

      {child procedures}
      function  GetIndex: Integer;
      function  GetThePosition: Integer;
      procedure SetChildType(aChildType: Integer);
      procedure UpdatePosition(Value: Integer);

      {support ChildType property}
      procedure ReadChildType(Reader: TReader);

    protected

      class function AppearsOnDelphiPalette: Boolean; virtual;

      {supports 'fake/hidden' properties}
      procedure DefineProperties(Filer: TFiler); override;

      procedure ChildListChanged; virtual;
      function  GetPosition: Integer;
      procedure FreeChildren;
      function  GetChildCount: Integer;
      function  GetChildForIndex(aIndex: Integer): TppRelative;
      function  GetChildForKeyPropValue(const aKeyPropValue: String): TppRelative;
      function  GetChildKeyPropValues(aList: TStrings): Boolean;
      function  IndexOfKeyPropValue(const aKeyPropValue: String): Integer;
      procedure PropertyChange; override;
      procedure SetTheChildType(aChildType: Integer);
      procedure SetParent(aParent: TppRelative); virtual;
      procedure SetPosition(Value: Integer);

      property KeyPropName: String read FKeyPropName write FKeyPropName;

      function  GetAllChildCount: Integer; virtual;
      function  GetAllChildForIndex(aIndex: Integer): TppRelative; virtual;

      {parent streaming stuff}
      procedure ReadState(Reader: TReader); override;

      procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;

      procedure SaveComponents(Proc: TGetChildProc); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      {child streaming stuff}
      procedure ChangeOwner(aNewOwner: TComponent); override;
      function  GetParentComponent: TComponent; override;
      function  HasParent: Boolean; override;
      procedure SetParentComponent(Value: TComponent); override;

      procedure AddChild(aChild: TppRelative); virtual;
      procedure InsertChild(aPosition: Integer; aChild: TppRelative); virtual;
      function  IndexOfChild(aChild: TppRelative): Integer; virtual;
      function  RemoveChild(aChild: TppRelative): Integer; virtual;
      procedure Transfer(aSource: TppCommunicator); virtual;

      property Children[Index: Integer]: TppRelative read GetChildForIndex;
      property ChildCount: Integer read GetChildCount;
      property ChildType: Integer read FChildType write SetChildType default 0;
      property Index: Integer read GetIndex; 
      property OrderedChildren: Boolean read FOrderedChildren write FOrderedChildren;
      property Parent: TppRelative read FParent write SetParent;

      property AllChildren[Index: Integer]: TppRelative read GetAllChildForIndex;
      property AllChildCount: Integer read GetAllChildCount;
      property FreeingChildren: Boolean read FFreeingChildren;
      property Position: Integer read GetPosition write SetPosition default -1;


  end; {class, TppRelative}


  {@TraTppRelativeRTTI }
  TraTppRelativeRTTI = class(TraTppCommunicatorRTTI)
    public
      {class procedure GetPropList(aPropList: TraPropList); override;}
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      {class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList): Boolean; override;}
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppRelativeRTTI}


implementation

{******************************************************************************
 *
 ** R E L A T I V E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRelative.Create }

constructor TppRelative.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FChildren := TList.Create;
  FChildType := 0;
  FFreeingChildren := False;
  FKeyPropName := '';
  FOrderedChildren := False;
  FParent := nil;
  FPosition := -1;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppRelative.Destroy }

destructor TppRelative.Destroy;
begin

  Destroying;

  SetParent(nil);

  FreeChildren;

  FChildren.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppRelative.Transfer }

procedure TppRelative.Transfer(aSource: TppCommunicator);
var
  lRelative: TppRelative;
  liChild: Integer;
  liChildCount: Integer;
  lChild: TppRelative;

begin

  if not (aSource is TppRelative) then Exit;

  lRelative := TppRelative(aSource);

  FOrderedChildren := lRelative.OrderedChildren;
  SetParent(lRelative.Parent);


  {free current children}
  FreeChildren;

  liChildCount := lRelative.ChildCount;

  {transfer children}
  for liChild := 0 to liChildCount - 1 do
    begin
      lChild := lRelative.Children[0];

      lChild.Parent := Self;

      {if child owner is same as former parent, change owner to new parent}
      if (lRelative.Owner = lChild.Owner) then
        lChild.ChangeOwner(Owner);

      {lRelative.RemoveChild(lChild);

      InsertChild(0, lChild);}

    end;

end;  {procedure, Transfer}

{------------------------------------------------------------------------------}
{ TppRelative.AppearsOnDelphiPalette}

class function TppRelative.AppearsOnDelphiPalette: Boolean;
begin

  {this class function enables descendants to decide whether to use the TComponent fake Left, Top
   properties required for non-visual components installed onto the Delphi component palette}
  Result := False;

end; {class function, AppearsOnDelphiPalette}

{------------------------------------------------------------------------------}
{ TppRelative.DefineProperties - read/write private 'fake' properties }

procedure TppRelative.DefineProperties(Filer: TFiler);
var
  lAncestor: TppRelative;

begin

  if AppearsOnDelphiPalette then
    inherited DefineProperties(Filer);

  {if ChildType is published, do not read the value as a 'fake' property -
   descendants which have published ChildType require SetChildType to be called}
  if ppCheckPropInfo(Self, 'ChildType') then Exit;

  if (Filer.Ancestor is TppRelative) then
    lAncestor := TppRelative(Filer.Ancestor)
  else
    lAncestor := nil;

  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('ChildType', ReadChildType, nil, False);
    end
  else
    begin
      Filer.DefineProperty('ChildType', ReadChildType, nil, False);
    end;

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppRelative.ReadChildType }

procedure TppRelative.ReadChildType(Reader: TReader);
begin

  FChildType := Reader.ReadInteger;

end; {procedure, ReadChildType}

{------------------------------------------------------------------------------}
{ TppRelative.PropertyChange }

procedure TppRelative.PropertyChange;
begin
  inherited PropertyChange;

  if (FParent <> nil) then
    FParent.PropertyChange;

  ChildListChanged;

end; {procedure, PropertyChange}

{------------------------------------------------------------------------------}
{ TppRelative.ChildListChanged }

procedure TppRelative.ChildListChanged;
begin

end; {procedure, ChildListChanged}

{------------------------------------------------------------------------------}
{ TppRelative.GetThePosition }

function TppRelative.GetThePosition: Integer;
begin
  Result := FPosition;
end; {function, GetThePosition}

{------------------------------------------------------------------------------}
{ TppRelative.GetPosition }

function TppRelative.GetPosition: Integer;
begin
  if FParent <> nil then
    Result := FParent.IndexOfChild(Self)
  else
    Result := -1;
end; {function, GetPosition}

{------------------------------------------------------------------------------}
{ TppRelative.SetTheChildType }

procedure TppRelative.SetTheChildType(aChildType: Integer);
begin
  FChildType := aChildType;
end; {procedure, SetTheChildType}

{------------------------------------------------------------------------------}
{ TppRelative.SetChildType }

procedure TppRelative.SetChildType(aChildType: Integer);
begin

  if not(HasParent) then Exit;

  if (Parent <> nil) then
    Parent.RemoveChild(Self);

  FChildType := aChildType;

  if (Parent <> nil) then
    Parent.AddChild(Self);

end; {procedure, SetChildType}

{------------------------------------------------------------------------------}
{ TppRelative.SetPosition }

procedure TppRelative.SetPosition(Value: Integer);
begin
  if (csReading in ComponentState) then
    FPosition := Value
  else
    begin
      UpdatePosition(Value);

      PropertyChange;
    end;

end; {procedure, SetPosition}

{------------------------------------------------------------------------------}
{ TppRelative.UpdatePosition }

procedure TppRelative.UpdatePosition(Value: Integer);
var
  liIndex: Integer;
  liCount: Integer;
begin

  if (FParent = nil) then Exit;

  liIndex := GetPosition;
  liCount := FParent.ChildCount;

  {doctor value until it is valid}
  if Value < 0 then Value := 0;

  if (liCount > 0) and (Value >= liCount) then
    Value := liCount - 1;

  if (Value <> liIndex) then
    begin
      {remove from old position}
      if (liIndex >= 0) then
        FParent.RemoveChild(Self);

      {insert into new position}
      FParent.InsertChild(Value, Self);
    end;

end; {procedure, UpdatePosition}

{------------------------------------------------------------------------------}
{ TppRelative.ReadState }

procedure TppRelative.ReadState(Reader: TReader);
begin

  inherited ReadState(Reader);

  {must call this after readstate}
  FixChildList;

end; {procedure, ReadState}

{------------------------------------------------------------------------------}
{ TppRelative.FixChildList }

procedure TppRelative.FixChildList;
var
  liChild: Integer;
  liChildren: Integer;
  liPosition: Integer;
  lList: TList;
  lChild: TppRelative;
begin

  if not(FOrderedChildren) then Exit;

  if (FChildren.Count = 0) then Exit;

  lList := TList.Create;

  try
    lList.Count := FChildren.Count;
    liChildren := FChildren.Count - 1;

    for liChild := 0 to liChildren do
      begin
        lChild := Children[liChild];

        liPosition := lChild.GetThePosition;

        if (liPosition >= 0) and (liPosition <= liChildren) then
          lList[liPosition] := lChild;

      end; {for, each object}

    for liChild := 0 to liChildren do
      begin
        lChild := TppRelative(lList[liChild]);

        if (lChild <> nil) then
          lChild.UpdatePosition(liChild);

      end;

  finally
    lList.Free;
  end; {try, finally}

end; {procedure, FixChildList}

{------------------------------------------------------------------------------}
{ TppRelative.FreeChildren }

procedure TppRelative.FreeChildren;
var
  liChild: Integer;
begin

  FFreeingChildren := True;

  try
    for liChild := (FChildren.Count - 1) downto 0 do
      TObject(FChildren[liChild]).Free;

  finally
    FChildren.Clear;
    FFreeingChildren := False;
  end;

end; {procedure, FreeChildren}

{------------------------------------------------------------------------------}
{ TppRelative.AddChild }

procedure TppRelative.AddChild(aChild: TppRelative);
begin
  FChildren.Add(aChild);
end; {procedure, AddChild}

{------------------------------------------------------------------------------}
{ TppRelative.InsertChild }

procedure TppRelative.InsertChild(aPosition: Integer; aChild: TppRelative);
begin
  FChildren.Insert(aPosition, aChild);
end; {procedure, InsertChild}

{------------------------------------------------------------------------------}
{ TppRelative.RemoveChild }

function TppRelative.RemoveChild(aChild: TppRelative): Integer;
begin
  Result := FChildren.Remove(aChild);
end; {function, RemoveChild}

{------------------------------------------------------------------------------}
{ TppRelative.GetIndex }

function TppRelative.GetIndex: Integer;
begin
  if (FParent <> nil) then
    Result := FParent.IndexOfChild(Self)
  else
    Result := -1;
end; {function, GetIndex}

{------------------------------------------------------------------------------}
{ TppRelative.GetChildCount }

function TppRelative.GetChildCount: Integer;
begin
  Result := FChildren.Count;
end; {function, GetChildCount}

{------------------------------------------------------------------------------}
{ TppRelative.GetChildForIndex }

function TppRelative.GetChildForIndex(aIndex: Integer): TppRelative;
begin
  Result := TppRelative(FChildren[aIndex]);
end; {function, GetChildForIndex}

{------------------------------------------------------------------------------}
{ TppRelative.GetAllChildCount }

function TppRelative.GetAllChildCount: Integer;
begin
  Result := GetChildCount;
end; {function, GetAllChildCount}

{------------------------------------------------------------------------------}
{ TppRelative.GetAllChildForIndex }

function TppRelative.GetAllChildForIndex(aIndex: Integer): TppRelative;
begin
  Result := GetChildForIndex(aIndex);
end; {function, GetAllChildForIndex}

{------------------------------------------------------------------------------}
{ TppRelative.GetChildForKeyPropValue }

function TppRelative.GetChildForKeyPropValue(const aKeyPropValue: String): TppRelative;
var
  liIndex: Integer;

begin

  Result  := nil;

  liIndex := IndexOfKeyPropValue(aKeyPropValue);

  if (liIndex <> -1) then
    Result := TppRelative(FChildren[liIndex]);

end; {function, GetChildForKeyPropValue}

{------------------------------------------------------------------------------}
{ TppRelative.IndexOfChild }

function TppRelative.IndexOfChild(aChild: TppRelative): Integer;
begin
  Result := FChildren.IndexOf(aChild);
end; {procedure, IndexOfChild}

{------------------------------------------------------------------------------}
{ TppRelative.IndexOfKeyPropValue }

function TppRelative.IndexOfKeyPropValue(const aKeyPropValue: String): Integer;
var
  lbFound: Boolean;
  lChild: TComponent;
  liChild: Integer;
  lsValue: String;
begin

  Result := -1;

  liChild := 0;
  lbFound := False;

  while not(lbFound) and (liChild < FChildren.Count) do
    begin
      lChild := TComponent(FChildren[liChild]);

      lsValue := ppGetStringPropValue(lChild, FKeyPropName);

      if (lsValue = aKeyPropValue) then
        lbFound := True
      else
        Inc(liChild);

    end;

end; {function, IndexOfKeyPropValue}

{------------------------------------------------------------------------------}
{ TppRelative.GetChildKeyPropValues }

function TppRelative.GetChildKeyPropValues(aList: TStrings): Boolean;
var
  liChild: Integer;
  lChild: TppRelative;
  lsValue: String;
begin

  aList.Clear;

  for liChild := 0 to FChildren.Count-1 do
    begin
      lChild := TppRelative(FChildren[liChild]);

      lsValue := ppGetStringPropValue(lChild, FKeyPropName);

      aList.Add(lsValue);
    end;

  Result := (aList.Count > 0);

end; {function, GetChildKeyPropValues}

{------------------------------------------------------------------------------}
{ TppRelative.SaveComponents }

procedure TppRelative.SaveComponents(Proc: TGetChildProc);
begin

end; {procedure, SaveComponents}

{------------------------------------------------------------------------------}
{ TppRelative.GetChildren }

procedure TppRelative.GetChildren(Proc: TGetChildProc; Root:TComponent);
var
  liChild: Integer;
begin

  {save child components}
  for liChild := 0 to (FChildren.Count - 1) do
    Proc(Children[liChild]);

  {allow descendants to save components}
  SaveComponents(Proc);

end; {procedure, GetChildren}

{------------------------------------------------------------------------------}
{ TppRelative.SetParent }

procedure TppRelative.SetParent(aParent: TppRelative);
begin

  if not(HasParent) then Exit;

  if FParent <> nil then
    FParent.RemoveChild(Self);

  FParent := aParent;

  if FParent <> nil then
    FParent.AddChild(Self);

end; {procedure, SetParent}

{------------------------------------------------------------------------------}
{ TppRelative.HasParent }

function TppRelative.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppRelative.GetParentComponent - required method for Components with HasParent = True }

function TppRelative.GetParentComponent: TComponent;
begin
  Result := FParent;
end;

{------------------------------------------------------------------------------}
{ TppRelative.SetParentComponent - required method for Components with HasParent = True }

procedure TppRelative.SetParentComponent(Value: TComponent);
begin
  if (Value is TppRelative) then
    SetParent(TppRelative(Value));
end;

{------------------------------------------------------------------------------}
{ TppRelative.ChangeOwner }

procedure TppRelative.ChangeOwner(aNewOwner: TComponent);
var
  liChild: Integer;
  lChild: TppRelative;
  lOldOwner: TComponent;

begin

  if (aNewOwner = Owner) then Exit;

  lOldOwner := Owner;

  inherited ChangeOwner(aNewOwner);


  {change owner of children, if children have same owner as parent}
  for liChild := 0 to (FChildren.Count - 1) do
    begin
      lChild := FChildren[liChild];

      if lChild.Owner = lOldOwner then
        lChild.ChangeOwner(aNewOwner);

    end;


end; {procedure, TppRelative}


{******************************************************************************
 *
 ** R E L A T I V E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppRelativeRTTI.RefClass }

class function TraTppRelativeRTTI.RefClass: TClass;
begin
  Result := TppRelative;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppRelativeRTTI.GetPropRec }

class function TraTppRelativeRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if CompareText(aPropName, 'AllChildCount') = 0 then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if CompareText(aPropName, 'ChildCount') = 0 then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if CompareText(aPropName, 'ChildType') = 0 then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if CompareText(aPropName, 'FreeingChildren') = 0 then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if CompareText(aPropName, 'Index') = 0 then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if CompareText(aPropName, 'OrderedChildren') = 0 then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if CompareText(aPropName, 'Parent') = 0 then
    ClassPropToRec(aPropName, TppRelative, False, aPropRec)

  else if CompareText(aPropName, 'Position') = 0 then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppRelativeRTTI.GetPropValue }

class function TraTppRelativeRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if CompareText(aPropName, 'AllChildCount') = 0 then
    Integer(aValue) := TppRelative(aObject).AllChildCount

  else if CompareText(aPropName, 'ChildCount') = 0 then
    Integer(aValue) := TppRelative(aObject).ChildCount

  else if CompareText(aPropName, 'ChildType') = 0 then
    Integer(aValue) := TppRelative(aObject).ChildType

  else if CompareText(aPropName, 'FreeingChildren') = 0 then
    Integer(aValue) := Ord(TppRelative(aObject).FreeingChildren)

  else if CompareText(aPropName, 'Index') = 0 then
    Integer(aValue) := TppRelative(aObject).Index 

  else if CompareText(aPropName, 'OrderedChildren') = 0 then
    Integer(aValue) := Ord(TppRelative(aObject).OrderedChildren)

  else if CompareText(aPropName, 'Parent') = 0 then
    Integer(aValue) := Integer(TppRelative(aObject).Parent)

  else if CompareText(aPropName, 'Position') = 0 then
    Integer(aValue) := TppRelative(aObject).Position

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppRelativeRTTI.SetPropValue }

class function TraTppRelativeRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;


  if CompareText(aPropName, 'ChildType') = 0 then
    TppRelative(aObject).ChildType := Integer(aValue)

  else if CompareText(aPropName, 'Parent') = 0 then
    TppRelative(aObject).Parent := TppRelative(aValue)

  else if CompareText(aPropName, 'Position') = 0 then
    TppRelative(aObject).Position := Integer(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


initialization

  raRegisterRTTI(TraTppRelativeRTTI);

finalization

  raUnRegisterRTTI(TraTppRelativeRTTI);

end.
