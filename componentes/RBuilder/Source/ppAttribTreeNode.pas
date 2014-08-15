{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppAttribTreeNode;

interface

uses
  Windows, Messages, SysUtils, Classes,
  ppRelatv, ppRTTI, ppUtils, ppTypes, ppTreeNode;

type


  { TppAttributeTreeNode contain a list of attributes (i.e. Name, Value pairs).
    Descendant classes can add additional properties. }

  {@TppAttributeTreeNode}
  TppAttributeTreeNode = class(TppTreeNode)
    private
      FAttributes: TStrings;

      function GetAttributes(aIndex: Integer): String;
      function GetAttributeValues(const aName: String): String;
      function GetAttributesCount: Integer;
      function GetAttributeNames(aIndex: Integer): String;

      procedure SetAttributes(aIndex: Integer; const aValue: String);
      procedure SetAttributeValues(const aName: String; const aValue: String);

      procedure InitAttributes;

    protected
      function CompareNode(aNode: TppTreeNode): Boolean; override;

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      { attribute managment }
      function AddAttribute(const aName, aValue: String): Integer;
      procedure DeleteAttribute(aIndex: Integer);
      procedure RemoveAttribute(const aName: String);

      { attribute managment }
      property Attributes[aIndex: Integer]: String read GetAttributes write SetAttributes;
      property AttributeValues[const aName: String]: String read GetAttributeValues write SetAttributeValues;
      property AttributesCount: Integer read GetAttributesCount;
      property AttributeNames[aIndex: Integer]: String read GetAttributeNames;

  end;  {class, TppAttributeTreeNode}


  {@TraTppAttributeTreeNodeRTTI }
  TraTppAttributeTreeNodeRTTI = class(TraTppRelativeRTTI)
    public
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppAttributeTreeNodeRTTI}



implementation


{******************************************************************************
 *
 ** TppAttributeTreeNode
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.Create }

constructor TppAttributeTreeNode.Create(aOwner: TComponent);
begin

  inherited Create(AOwner);

   FAttributes := nil;

end;{ constructor, Create }

{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.Destroy }

destructor TppAttributeTreeNode.Destroy;
begin

  FAttributes.Free;
  FAttributes := nil;

  inherited Destroy;

end;{ destructor, Destroy }


{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.CompareNode }

function TppAttributeTreeNode.CompareNode(aNode: TppTreeNode): Boolean;
var
  lNode: TppAttributeTreeNode;
begin

  if not (aNode is TppAttributeTreeNode) then
    Result := False
  else
    begin

      lNode :=  TppAttributeTreeNode(aNode);

      if FAttributes = nil then
        Result := (lNode.FAttributes = nil)

      else if (lNode.FAttributes = nil) then
        Result := False

      else
        Result := FAttributes.Equals(lNode.FAttributes);

    end;

end; {function, CompareNode }

{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.InitAttributes}

procedure TppAttributeTreeNode.InitAttributes;
begin

  if (FAttributes = nil) then
    FAttributes := TStringList.Create;

end;{ procedure, InitAttributes }

{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.Assign }

procedure TppAttributeTreeNode.Assign(Source: TPersistent);
var
  lSource: TppAttributeTreeNode;
begin

  if (Source is TppAttributeTreeNode) then
    begin
      lSource := TppAttributeTreeNode(Source);

      if (FAttributes <> nil) then
        FAttributes.Assign(lSource.FAttributes);
    end;

end;{ procedure, Assign }

{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.GetAttributes }

function TppAttributeTreeNode.GetAttributes(aIndex: Integer): String;
begin

  InitAttributes;

  Result := FAttributes[aIndex];

end;{ function, GetAttributes }

{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.SetAttributes }

procedure TppAttributeTreeNode.SetAttributes(aIndex: Integer; const aValue: String);
begin

  InitAttributes;

  FAttributes[aIndex] := aValue;

end;{ procedure, SetAttributes }

{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.GetAttributeValues }

function TppAttributeTreeNode.GetAttributeValues(const aName: String): String;
begin

  InitAttributes;

  Result := FAttributes.Values[aName];

end;{ function, GetAttributeValues }


{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.SetAttributeValues }

procedure TppAttributeTreeNode.SetAttributeValues(const aName: String; const aValue: String);
begin

  InitAttributes;

  FAttributes.Values[aName] := aName;

end;{ procedure, SetAttributeValues }


{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.GetAttributesCount }

function TppAttributeTreeNode.GetAttributesCount: Integer;
begin

  Result := 0;

  if (FAttributes <> nil) then
    Result := FAttributes.Count;

end;{ function, GetAttributesCount }


{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.GetAttributeNames }

function TppAttributeTreeNode.GetAttributeNames(aIndex: Integer): String;
begin

  InitAttributes;

  Result := FAttributes.Names[aIndex];
  
end;{ function, GetAttributeNames }


{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.AddAttribute }

function TppAttributeTreeNode.AddAttribute(const aName, aValue: String): Integer;
begin

  InitAttributes;

  Result := FAttributes.Add(aName + '=' + aValue);

end;{ function, AddAttribute }


{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.DeleteAttribute }

procedure TppAttributeTreeNode.DeleteAttribute(aIndex: Integer);
begin

  InitAttributes;

  FAttributes.Delete(aIndex);

end;{ function, DeleteAttribute }


{------------------------------------------------------------------------------}
{ TppAttributeTreeNode.RemoveAttribute }

procedure TppAttributeTreeNode.RemoveAttribute(const aName: String);
var
  liIndex: Integer;
begin

  InitAttributes;

  liIndex := FAttributes.IndexOfName(aName);

  if (liIndex > -1) then
    FAttributes.Delete(liIndex);

end;{ function, RemoveAttribute }


{******************************************************************************
 *
 ** Attribute Tree Node R T T I   C L A S S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppAttributeTreeNodeRTTI.CallMethod }

class function TraTppAttributeTreeNodeRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lNode: TppAttributeTreeNode;
  liIndex: Integer;
  liResult: Integer;
  lString: String;
  lString2: String;
  lsIndex: String;
  lsResult: String;
begin

  Result := True;

  lNode := TppAttributeTreeNode(aObject);

  { access specifiers }

  if (ppEqual(aMethodName, 'Attributes')) then
    begin
      if (aGet) then
        begin
          aParams.GetParamValue(0, liIndex);

          lsResult := lNode.Attributes[liIndex];

          aParams.SetParamValue(1, lsResult);
        end

      else
        begin
          aParams.GetParamValue(0, liIndex);
          aParams.GetParamValue(1, lString);

          lNode.Attributes[liIndex] := lString;
        end
    end

  else if (ppEqual(aMethodName, 'AttributeValues')) then
    begin
      if (aGet) then
        begin
          aParams.GetParamValue(0, lsIndex);

          lsResult := lNode.AttributeValues[lsIndex];

          aParams.SetParamValue(1, lsResult);
        end

      else
        begin
          aParams.GetParamValue(0, lsIndex);
          aParams.GetParamValue(1, lString);

          lNode.AttributeValues[lsIndex] := lString;
        end
    end

  else if (ppEqual(aMethodName, 'AttributeNames')) and (aGet) then
    begin
      aParams.GetParamValue(0, liIndex);

      lsResult := lNode.AttributeNames[liIndex];

      aParams.SetParamValue(1, lsResult);
    end

  { methods }
  else if (ppEqual(aMethodName, 'AddAttribute')) then
    begin
      aParams.GetParamValue(0, lString);
      aParams.GetParamValue(1, lString2);

      liResult := lNode.AddAttribute(lString, lString2);

      aParams.SetParamValue(2, liResult);
    end

  else if (ppEqual(aMethodName, 'DeleteAttribute')) then
    begin
      aParams.GetParamValue(0, liIndex);

      lNode.DeleteAttribute(liIndex);
    end

  else if (ppEqual(aMethodName, 'RemoveAttribute')) then
    begin
      aParams.GetParamValue(0, lString);

      lNode.RemoveAttribute(lString);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppAttributeTreeNodeRTTI.GetParams }

class function TraTppAttributeTreeNodeRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (ppEqual(aMethodName, 'AddAttribute')) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aName', daString, nil, '', True, False);
      Result.AddParam('aValue', daString, nil, '', True, False);
    end

  else if (ppEqual(aMethodName, 'DeleteAttribute')) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aIndex', daInteger, nil, '', False, False);
    end

  else if (ppEqual(aMethodName, 'RemoveAttribute')) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aName', daString, nil, '', True, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}


{------------------------------------------------------------------------------}
{ TraTppAttributeTreeNodeRTTI.GetPropList }

class procedure TraTppAttributeTreeNodeRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('Attributes');
  aPropList.AddProp('AttributeValues');
  aPropList.AddProp('AttributesCount');
  aPropList.AddProp('AttributeNames');

  aPropList.AddMethod('AddAttribute');
  aPropList.AddMethod('DeleteAttribute');
  aPropList.AddMethod('RemoveAttribute');

end; {class procedure, GetPropList}


{------------------------------------------------------------------------------}
{ TraTppAttributeTreeNodeRTTI.GetPropRec }

class function TraTppAttributeTreeNodeRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (ppEqual(aPropName, 'Attributes')) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (ppEqual(aPropName, 'AttributeValues')) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (ppEqual(aPropName, 'AttributesCount')) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (ppEqual(aPropName, 'AttributeNames')) then
    AccessSpecifierToRec(aPropName, aPropRec) 


  else if (ppEqual(aPropName, 'AddAttribute')) then
    MethodToRec(aPropName, True, aPropRec)

  else if (ppEqual(aPropName, 'DeleteAttribute')) then
    MethodToRec(aPropName, True, aPropRec)

  else if (ppEqual(aPropName, 'RemoveAttribute')) then
    MethodToRec(aPropName, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}


{------------------------------------------------------------------------------}
{ TraTppAttributeTreeNodeRTTI.GetPropValue }

class function TraTppAttributeTreeNodeRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (ppEqual(aPropName, 'AttributesCount')) then
    Integer(aValue) := TppAttributeTreeNode(aObject).AttributesCount

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{------------------------------------------------------------------------------}
{ TraTppAttributeTreeNodeRTTI.RefClass }

class function TraTppAttributeTreeNodeRTTI.RefClass: TClass;
begin
  Result := TppAttributeTreeNode;
end; {class function, RefClass}


initialization

  RegisterClass(TppAttributeTreeNode);
  raRegisterRTTI(TraTppAttributeTreeNodeRTTI);

finalization

  UnRegisterClass(TppAttributeTreeNode);
  raUnRegisterRTTI(TraTppAttributeTreeNodeRTTI);


end.

