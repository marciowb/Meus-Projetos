{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daLinkBroker;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  ppRelatv, ppDB, daSQL;

type

  { TdaLinkBroker

      - helper class created by TdaSQL to manage TdaSQLLinks}
  
  TdaLinkBroker = class (TdaChild)
    private
      FLinks: TList;
      FUpdateColors: Boolean;
      FLinkType: TdaLinkType;

      function GetLink(aIndex: Integer): TdaSQLLink;
      function GetLinkCount: Integer;
      function GetMasterSQLObject: TdaSQL;
      function GetSQLObject: TdaSQL;
      procedure ClearLinkColor(aSQLLink: TdaSQLLink);
      function GetLinkType: TdaLinkType;
      procedure SetLinkColor(aSQLLink: TdaSQLLink);
      procedure SetLinkType(const Value: TdaLinkType);

    protected
      procedure SaveComponents(Proc: TGetChildProc); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      procedure Convert(aVersionNo: Integer);

      procedure AddChild(aChild: TppRelative); override;
      procedure ClearLinkColors;
      function CreateLink(aMasterField, aDetailField: TdaField): TdaSQLLink;
      procedure FixUpLinkColors;
      procedure FreeLinks;
      procedure FreeLink(aLink: TdaSQLLink);
      procedure GetDetailFieldList(aList: TList);
      procedure GetLinkList(aLinkList: TStrings);
      function IndexOfChild(aChild: TppRelative): Integer; override;
      function IsLinkingField(aField: TdaField): Boolean;
      function RemoveChild(aChild: TppRelative): Integer; override;
      function ValidateLinks: Boolean;

      property UpdateColors: Boolean read FUpdateColors write FUpdateColors;
      property LinkCount: Integer read GetLinkCount;
      property Links[aIndex: Integer]: TdaSQLLink read GetLink;
      property LinkType: TdaLinkType read GetLinkType write SetLinkType;

  end; {class, TdaLinkBroker}



implementation

uses
  ppTypes;

{*******************************************************************************
 *
 ** L I N K   B R O K E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.Create }

constructor TdaLinkBroker.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FLinks := TList.Create;
  FUpdateColors := True;
  FLinkType := ltMagicSQL;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.Destroy }

destructor TdaLinkBroker.Destroy;
begin

  FreeLinks;
  FLinks.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.Assign }

procedure TdaLinkBroker.Assign(Source: TPersistent);
var
  liIndex: Integer;
  lLink: TdaSQLLink;
  lNewLink: TdaSQLLink;
  lSource: TdaLinkBroker;
begin

  if (Source is TdaLinkBroker) then
    begin
      lSource := TdaLinkBroker(Source);

      FLinkType := lSource.LinkType;

      for liIndex := 0 to lSource.LinkCount - 1 do
        begin
          lLink := lSource.Links[liIndex];

          lNewLink := TdaSQLLink.Create(Self);
          lNewLink.ChildType := Ord(dactSQLLink);
          lNewLink.Parent := Self;
          lNewLink.Assign(lLink);
        end;
    end;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.Convert }

procedure TdaLinkBroker.Convert(aVersionNo: Integer);
var
  liIndex: Integer;
  lLink: TdaSQLLink;
begin

  if aVersionNo < 5200 then
    for liIndex := 0 to FLinks.Count-1 do
      begin
        lLink := Links[liIndex];

        lLink.MasterField.SQLFieldName := lLink.MasterField.FieldName;
        lLink.DetailField.SQLFieldName := lLink.DetailField.FieldName;
      end;

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.FreeLink }

procedure TdaLinkBroker.FreeLink(aLink: TdaSQLLink);
begin

  ClearLinkColor(aLink);

  aLink.Free;

end; {procedure, FreeLink}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.FreeLinks }

procedure TdaLinkBroker.FreeLinks;
var
  liIndex: Integer;
begin

  for liIndex := FLinks.Count - 1 downto 0 do
    FreeLink(Links[liIndex]);

end; {procedure, FreeLinks}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.SaveComponents }

procedure TdaLinkBroker.SaveComponents(Proc: TGetChildProc);
var
  liIndex: Integer;
begin

  inherited SaveComponents(Proc);

  for liIndex := 0 to (FLinks.Count - 1) do
    Proc(FLinks[liIndex]);

end; {procedure, SaveComponents}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.AddChild }

procedure TdaLinkBroker.AddChild(aChild: TppRelative);
begin

  if (TdaChildType(aChild.ChildType) = dactSQLLink) then
    FLinks.Add(aChild)
  else
    inherited AddChild(aChild);

end; {procedure, AddChild}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.IndexOfChild }

function TdaLinkBroker.IndexOfChild(aChild: TppRelative): Integer;
begin

  if TdaChildType(aChild.ChildType) = dactSQLLink then
    Result := FLinks.IndexOf(aChild)
  else
    Result := inherited IndexOfChild(aChild);

end; {function, IndexOfChild}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.RemoveChild }

function TdaLinkBroker.RemoveChild(aChild: TppRelative): Integer;
var
  liIndex: Integer;
begin

  liIndex := IndexOfChild(aChild);

  Result := liIndex;

  if not (liIndex = -1) then
    begin
      if TdaChildType(aChild.ChildType) = dactSQLLink then
        FLinks.Delete(liIndex)
      else
        Result := inherited RemoveChild(aChild);
    end;

end; {function, RemoveChild}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.CreateLink }

function TdaLinkBroker.CreateLink(aMasterField, aDetailField: TdaField):
    TdaSQLLink;
var
  lSQL: TdaSQL;
  lMasterSQL: TdaSQL;
  liIndex: Integer;
  lMasterField: TdaField;
  lDetailField: TdaField;
  lLink: TdaSQLLink;
begin

  lSQL := GetSQLObject;
  lMasterSQL := GetMasterSQLObject;

  liIndex := lMasterSQL.IndexOfAvailableMasterLinkField(aMasterField);

  if (liIndex <> -1) then
    lMasterField := lMasterSQL.SelectMasterLinkField(liIndex)
  else
    raise EDataError.Create('TdaSQL.CreateLink: unable to find available master link field');

  liIndex := lSQL.IndexOfAvailableDetailLinkField(aDetailField);

  if (liIndex <> -1) then
    lDetailField := lSQL.SelectDetailLinkField(liIndex)
  else
    raise EDataError.Create('TdaSQL.CreateLink: unable to find available detail link field');

  lLink := TdaSQLLink.Create(lSQL);
  lLink.Name := GetValidName(lLink);

  lMasterField.SQLFieldName := aMasterField.SQLFieldName;
  lMasterField.ChangeOwner(lLink);
  lMasterField.Name := lMasterField.GetValidName(lMasterField);

  lDetailField.ChangeOwner(lLink);
  lDetailField.Name := lDetailField.GetValidName(lDetailField);
  lDetailField.SQLFieldName := aDetailField.SQLFieldName;

  lMasterField.Parent := lLink;
  lDetailField.Parent := lLink;

  lLink.Parent := Self;

  SetLinkColor(lLink);

  Result := lLink;

end; {procedure, CreateLink}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.GetLinkCount }

function TdaLinkBroker.GetLinkCount: Integer;
begin
  Result := FLinks.Count;
end; {function, GetLinkCount}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.GetDetailFieldList }

procedure TdaLinkBroker.GetDetailFieldList(aList: TList);
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
begin

  aList.Clear;

  for liIndex := 0 to FLinks.Count - 1 do
    begin
      lSQLLink := Links[liIndex];

      aList.Add(lSQLLink.DetailField);
    end;

end; {procedure, GetDetailFieldList}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.GetLinkList }

procedure TdaLinkBroker.GetLinkList(aLinkList: TStrings);
var
  liIndex: Integer;
  lSQLLink: TdaSQLLink;
begin

  if (aLinkList <> nil) then
    begin
      aLinkList.Clear;

      for liIndex := 0 to LinkCount - 1 do
        begin
          lSQLLink := Links[liIndex];
          aLinkList.AddObject(lSQLLink.Description, lSQLLink);
        end;
    end;

end; {procedure, GetLinkList}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.GetLink }

function TdaLinkBroker.GetLink(aIndex: Integer): TdaSQLLink;
begin
  Result := TdaSQLLink(FLinks[aIndex]);
end; {function, GetLink}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.IsLinkingField }

function TdaLinkBroker.IsLinkingField(aField: TdaField): Boolean;
var
  liIndex: Integer;
  lLink: TdaSQLLink;
begin

  Result := False;
  liIndex := 0;

  while (Result) and (liIndex < LinkCount) do
    begin
      lLink := Links[liIndex];

      if (CompareText(lLink.DetailField.TableName, aField.TableName) = 0) and
         (CompareText(lLink.DetailField.FieldName, aField.FieldName) = 0) then
        Result := True
      else
        Inc(liIndex);
    end;

end; {function, IsLinkingField}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.ClearLinkColors }

procedure TdaLinkBroker.ClearLinkColors;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FLinks.Count - 1 do
    ClearLinkColor(Links[liIndex]);
    
end; {procedure, ClearLinkColors}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.FixUpLinkColors }

procedure TdaLinkBroker.FixUpLinkColors;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FLinks.Count - 1 do
    SetLinkColor(Links[liIndex]);
    
end; {procedure, FixUpLinkColors}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.SetLinkColor }

procedure TdaLinkBroker.SetLinkColor(aSQLLink: TdaSQLLink);
var
  lSQL: TdaSQL;
  lMasterSQL: TdaSQL;
  lMasterField: TdaField;
  lDetailField: TdaField;
  lColor: TColor;
begin

  if not(FUpdateColors) or (csReading in aSQLLink.ComponentState) or (csLoading in aSQLLink.ComponentState) then Exit;

  lSQL := GetSQLObject;
  lMasterSQL := GetMasterSQLObject;

  {get the select fields}
  lMasterField := lMasterSQL.GetFieldForSQLFieldName(aSQLLink.MasterField.SQLFieldName);
  lDetailField := lSQL.GetFieldForSQLFieldName(aSQLLink.DetailField.SQLFieldName);

  {if master field that is already linked, use that field's color}
  if (lMasterField.LinkColor <> 0) then
    lColor := lMasterField.LinkColor

  {if detail field already linked, use that field's color}
  else if (lDetailField.LinkColor <> 0) then
    lColor := lDetailField.LinkColor

  {otherwise use the dataview's linking color}
  else
    lColor := lSQL.LinkColor;

  lMasterField.LinkColor := lColor;
  lDetailField.LinkColor := lColor;

end; {procedure, SetLinkColor}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.ClearLinkColor }

procedure TdaLinkBroker.ClearLinkColor(aSQLLink: TdaSQLLink);
var
  lSQL: TdaSQL;
  lMasterSQL: TdaSQL;
  lMasterField: TdaField;
  lDetailField: TdaField;
begin

  if not(FUpdateColors) or (csReading in aSQLLink.ComponentState) or (csLoading in aSQLLink.ComponentState) then Exit;
  
  lSQL := GetSQLObject;

  lDetailField := lSQL.GetFieldForSQLFieldName(aSQLLink.DetailField.SQLFieldName);

  if (lDetailField <> nil) then
    lDetailField.LinkColor := 0;


  lMasterSQL := lSQL.MasterSQL;

  if (lMasterSQL <> nil) then
    begin
      lMasterField := lMasterSQL.GetFieldForSQLFieldName(aSQLLink.MasterField.SQLFieldName);

      if (lMasterField <> nil) then
        lMasterField.LinkColor := 0;
    end;

end; {procedure, ClearLinkColor}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.GetLinkType }

function TdaLinkBroker.GetLinkType: TdaLinkType;
var
  lAvailabeLinkTypes: TdaLinkTypes;
begin

  lAvailabeLinkTypes := GetSQLObject.AvailableLinkTypes;

  // this check is for the case in which the master SQL has been edited as text
  // and therefore we need to switch to ParameterizedSQL or ManualSQL
  if (FLinkType = ltMagicSQL) and not (ltMagicSQL in lAvailabeLinkTypes) then
    FLinkType := ltParameterizedSQL
  else if (FLinkType = ltParameterizedSQL) and not (ltParameterizedSQL in lAvailabeLinkTypes) then
    FLinkType := ltManualSQL;

  Result := FLinkType;

end;

{------------------------------------------------------------------------------}
{ TdaLinkBroker.GetSQLObject }

function TdaLinkBroker.GetSQLObject: TdaSQL;
begin

  Result := GetSQL;

  if (Result = nil) then
    raise EDataError.Create('TdaLinkBroker.GetSQLObjects: No SQL object available.');

end; {function, GetSQLObject}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.GetMasterSQLObject }

function TdaLinkBroker.GetMasterSQLObject: TdaSQL;
var
  lSQL: TdaSQL;
begin

  lSQL := GetSQLObject;

  Result := lSQL.MasterSQL;

  if (Result = nil) then
    raise EDataError.Create('TdaLinkBroker.GetSQLObjects: No master SQL object available.');

end; {function, GetMasterSQLObject}

{------------------------------------------------------------------------------}
{ TdaLinkBroker.SetLinkType }

procedure TdaLinkBroker.SetLinkType(const Value: TdaLinkType);
begin

  if (csReading in GetSQLObject.ComponentState) or (csLoading in GetSQLObject.ComponentState) then
    FLinkType := Value
  else if (Value in GetSQLObject.AvailableLinkTypes) then
    FLinkType := Value;

end;

{------------------------------------------------------------------------------}
{ TdaLinkBroker.ValidateLinks }

function TdaLinkBroker.ValidateLinks: Boolean;
var
  lSQL: TdaSQL;
  lMasterSQL: TdaSQL;
  liIndex: Integer;
  lLink: TdaSQLLink;
begin

  Result := True;

  lSQL := GetSQLObject;
  lMasterSQL := lSQL.MasterSQL;

  if (lMasterSQL = nil) then Exit;

  if (lMasterSQL.LinkType = ltMagicSQL) and (lMasterSQL.IsOrderedByAggregateCalcField) then
    begin
      Result := False;
      
      FreeLinks;
    end;

  for liIndex := FLinks.Count - 1 downto 0 do
    begin
      lLink := Links[liIndex];

      if (lMasterSQL.GetFieldForFieldName(lLink.MasterField.FieldName) = nil) or
         (lSQL.GetFieldForFieldName(lLink.DetailField.FieldName) = nil) then
        begin
          Result := False;

          ClearLinkColor(lLink);

          lLink.Free;
        end;
    end;

  if (FLinks.Count = 0) then
    lSQL.MasterSQL := nil;

end; {procedure, ValidateLinks}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClass(TdaLinkBroker);

finalization

  UnRegisterClass(TdaLinkBroker);

end.
