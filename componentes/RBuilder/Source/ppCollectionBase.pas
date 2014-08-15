{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppCollectionBase;

interface

uses
  SysUtils,
  Classes,
  Contnrs,
  IniFiles;

type

    {TppHashTable3}
    TppHashTable = class(TStringHash);


  {TppCollectionBase}
  TppCollectionBase = class
    private
      FInnerList: TObjectList;

      function GetCount: Integer;

    protected
      property InnerList: TObjectList read FInnerList;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure Clear; virtual;

      property Count: Integer read GetCount;

    end;

    {TppIndexedCollectionBase}
    TppIndexedCollectionBase = class(TppCollectionBase)
    private
      FCaseSensitive: Boolean;
      FIndex: TppHashTable;
      FIndexValid: Boolean;
      FUpdateState: Integer;

      function GetIndex: TppHashTable;
      
    protected
      function GetItemForKey(aKey: String): TObject; virtual;
      function GetKey(aObject: TObject): String; virtual; abstract;
      function InternalAdd(aObject: TObject): Integer; overload; virtual;
      procedure InternalInsert(aPosition: Integer; aObject: TObject);
      function InternalRemove(aObject: TObject): Integer; overload; virtual;
      function IndexOfKey(aKey: String): Integer;
      procedure SetCaseSensitive(const Value: Boolean); virtual;
      procedure RebuildIndex; virtual;

//      procedure Remove(aKey: String); overload; virtual;

      property Index: TppHashTable read GetIndex;
      property IndexValid: Boolean read FIndexValid write FIndexValid;
      property UpdateState: Integer read FUpdateState;

    public
      constructor Create; override;
      destructor Destroy; override;

      procedure BeginUpdate;
      procedure Clear; override;
      procedure EndUpdate;
      property CaseSensitive: Boolean read FCaseSensitive write SetCaseSensitive;

    end;


  {TppInterfaceCollectionBase}
  TppInterfaceCollectionBase = class
    private
      FInnerList: TInterfaceList;

      function GetCount: Integer;

    protected
      property InnerList: TInterfaceList read FInnerList;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure Clear; virtual;
      property Count: Integer read GetCount;

    end;

  {TppComponentCollectionBase}
  TppComponentCollectionBase = class
    private
      FInnerList: TComponentList;

      function GetCount: Integer;

    protected
      property InnerList: TComponentList read FInnerList;

    public
      constructor Create; virtual;
      destructor Destroy; override;
      procedure Clear; virtual;
      property Count: Integer read GetCount;

    end;

  TppIntegerCollection = class(TppCollectionBase)
  private
    function GetItems(Index: Integer): Integer;
    procedure SetItems(Index: Integer; const Value: Integer);
  public
    function Add(aValue: Integer): Integer;
    procedure Delete(aIndex: Integer);
    procedure Insert(aIndex, aValue: Integer);
    property Items[Index: Integer]: Integer read GetItems write SetItems; default;
  end;



{
  TppCollectionPattern = class(TppCollectionBase)

  private
    function GetItemForIndex(aIndex: Integer): TmyClassType;
    function GetItemForName(aName: String): TmyClassType;

  public
    function IndexOf(aObject: TmyClassType): Integer;
    procedure Add(aObject: TmyClassType);
    procedure Remove(aObject: TmyClassType);

    property ItemsByNames[Name: Strign]: TmyClassType read GetItemForName; default;
    property Items[Index: Integer]: TmyClassType read GetItemForIndex; default;

  end;

}

implementation

{*******************************************************************************
 *
 ** C O L L E C T I O N   B A S E
 *
 *******************************************************************************}


{------------------------------------------------------------------------------}
{ TppCollectionBase.Create }

constructor TppCollectionBase.Create;
begin
  inherited;
  
  FInnerList := TObjectList.Create;
  FInnerList.OwnsObjects := False;
end;

{------------------------------------------------------------------------------}
{ TppCollectionBase.Destroy }

destructor TppCollectionBase.Destroy;
begin

  FInnerList.Free;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppCollectionBase.Clear }

procedure TppCollectionBase.Clear;
begin
  FInnerList.Clear;
end;

{------------------------------------------------------------------------------}
{ TppCollectionBase.GetCount }

function TppCollectionBase.GetCount: Integer;
begin
  Result := FInnerList.Count;

end;

{*******************************************************************************
 *
 ** I N T E R F A C E   C O L L E C T I O N   B A S E
 *
 *******************************************************************************}

procedure TppInterfaceCollectionBase.Clear;
begin
  FInnerList.Clear;

end;

constructor TppInterfaceCollectionBase.Create;
begin

  inherited Create;

  FInnerList := TInterfaceList.Create;


end;

destructor TppInterfaceCollectionBase.Destroy;
begin

  FInnerList.Free;

  inherited;
end;

function TppInterfaceCollectionBase.GetCount: Integer;
begin
  Result := FInnerList.Count;

end;

{*******************************************************************************
 *
 ** C O M P O N E N T  C O L L E C T I O N   B A S E
 *
 *******************************************************************************}

{------------------------------------------------------------------------------}
{ TppComponentCollectionBase.Create }

constructor TppComponentCollectionBase.Create;
begin
  FInnerList := TComponentList.Create;
  FInnerList.OwnsObjects := False;
end;

{------------------------------------------------------------------------------}
{ TppComponentCollectionBase.Destroy }

destructor TppComponentCollectionBase.Destroy;
begin

  FInnerList.Free;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppCollecTppComponentCollectionBasetionBase.Clear }

procedure TppComponentCollectionBase.Clear;
begin
  FInnerList.Clear;
end;

{------------------------------------------------------------------------------}
{ TppComponentCollectionBase.GetCount }

function TppComponentCollectionBase.GetCount: Integer;
begin
  Result := FInnerList.Count;

end;

{*******************************************************************************
 *
 ** I N D E X E D   C O L L E C T I O N   B A S E
 *
 *******************************************************************************}

{------------------------------------------------------------------------------}
{ TppIndexedCollectionBase.Create }

constructor TppIndexedCollectionBase.Create;
begin

  inherited;

  FIndex := TppHashTable.Create();

end;

{------------------------------------------------------------------------------}
{ TppIndexedCollectionBase.Destroy }

destructor TppIndexedCollectionBase.Destroy;
begin

  FIndex.Free;
  FIndex := nil;

  inherited;

end;

procedure TppIndexedCollectionBase.BeginUpdate;
begin
  Inc(FUpdateState);
end;

{------------------------------------------------------------------------------}
{ TppCollectionBase.Clear }

procedure TppIndexedCollectionBase.Clear;
begin
  FIndex.Clear;
  inherited;
end;

procedure TppIndexedCollectionBase.EndUpdate;
begin

  if FUpdateState = 0 then Exit;

  Dec(FUpdateState);

  if (FUpdateState = 0) then
    RebuildIndex;

end;

function TppIndexedCollectionBase.GetIndex: TppHashTable;
begin

  if not(FIndexValid) then
    RebuildIndex;

  Result := FIndex;

end;

function TppIndexedCollectionBase.InternalAdd(aObject: TObject): Integer;
begin

  IndexValid := False;

  Result := InnerList.Add(aObject);

end;

procedure TppIndexedCollectionBase.RebuildIndex;
var
  liIndex: Integer;
  lObject: TObject;
begin

  FIndex.Free;

 if InnerList.Count = 0 then
   FIndex := TppHashTable.Create
 else
  FIndex := TppHashTable.Create(InnerList.Count);

  for liIndex := 0 to InnerList.Count - 1 do
    begin
      lObject := InnerList[liIndex];
      FIndex.Add(GetKey(lObject), liIndex);
    end;

  FIndexValid := True;

end;

function TppIndexedCollectionBase.GetItemForKey(aKey: String): TObject;
var
  liIndex: Integer;
begin

  liIndex := GetIndex.ValueOf(aKey);

  if (liIndex >= 0) then
    Result := InnerList[liIndex]
  else
    Result := nil;

end;

function TppIndexedCollectionBase.IndexOfKey(aKey: String): Integer;
begin
  Result := GetIndex.ValueOf(aKey);
end;

procedure TppIndexedCollectionBase.InternalInsert(aPosition: Integer; aObject: TObject);
begin

  IndexValid := False;

  InnerList.Insert(aPosition, aObject);

end;

function TppIndexedCollectionBase.InternalRemove(aObject: TObject): Integer;
begin

  IndexValid := False;

  Result := InnerList.Remove(aObject);

end;

procedure TppIndexedCollectionBase.SetCaseSensitive(const Value: Boolean);
begin
  FCaseSensitive := Value;

end;

function TppIntegerCollection.Add(aValue: Integer): Integer;
begin
  Result := InnerList.Add(TObject(aValue));
end;

procedure TppIntegerCollection.Delete(aIndex: Integer);
begin
  InnerList.Delete(aIndex);
end;

function TppIntegerCollection.GetItems(Index: Integer): Integer;
begin
  Result := Integer(InnerList[Index]);
end;

procedure TppIntegerCollection.Insert(aIndex, aValue: Integer);
begin
  InnerList.Insert(aIndex, TObject(aValue));
end;

procedure TppIntegerCollection.SetItems(Index: Integer; const Value: Integer);
begin
  if Index >= Count then
    InnerList.Add(TObject(Value))
  else
    InnerList[Index] := TObject(Value);
end;

{
procedure TppIndexedCollectionBase.Remove(aKey: String);
var
  liIndex: Integer;
begin

  liIndex := FIndex.ValueOf(aKey);
  FIndex.Remove(aKey);

  InnerList.Delete(liIndex);

end;
}

end.
