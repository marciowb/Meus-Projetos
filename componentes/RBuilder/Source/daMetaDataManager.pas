{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daMetaDataManager;

{$I ppIfDef.pas}

interface

uses
  Classes, SyncObjs,
  ppDsgnDB,
  daMetaData, daDB;

type

  TdaMetaDataList = class;

  { TdaMetaDataManager }
  TdaMetaDataManager = class
    private
      FLock: TCriticalSection;
      FMetaDataList: TdaMetaDataList;

      function GetMetaData(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName: String): TdaMetaData;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure Clear;
      procedure GetFields(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName, aTableName, aSQLTableName: String; aFields: TList);
      function GetMaxFieldAliasLength(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName, aRawTableName: String): Integer;
      function GetTableAlias(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName, aRawTableName: String): String;
      procedure GetTables(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName: String; aTables: TList);

      procedure GetTableListForDialog(aTables: TList);

  end;


  { TdaMetaData }
  TdaMetaDataList = class
    private
      FList: TList;

      function GetMetaDataForIndex(aIndex: Integer): TdaMetaData;
    function GetCount: Integer;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure Clear;

      function GetMetaData(aSessionClassName, aDatabaseName: String): TdaMetaData;

      property MetaData[Index: Integer]: TdaMetaData read GetMetaDataForIndex; default;
      property Count: Integer read GetCount;

    end;


var
  gMetaDataManager: TdaMetaDataManager;

implementation

uses
  ppTypes;

{*******************************************************************************
 *
 ** M E T A D A T A  M A N A G E R
 *
{******************************************************************************}

{ TdaMetaDataManager }

constructor TdaMetaDataManager.Create;
begin
  inherited;

  FLock := TCriticalSection.Create;
  FMetaDataList := TdaMetaDataList.Create;

end;

{@TdaMetaDataManager.Destroy}

destructor TdaMetaDataManager.Destroy;
begin

  FLock.Free;
  FMetaDataList.Free;

  inherited;
end;

{@TdaMetaDataManager.Clear}

procedure TdaMetaDataManager.Clear;
begin

  FLock.Acquire;

  try
    FMetaDataList.Clear;

  finally
    FLock.Release;

  end;

end;

{@TdaMetaDataManager.GetMetaData}

function TdaMetaDataManager.GetMetaData(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName: String): TdaMetaData;
begin

  Result := FMetaDataList.GetMetaData(aSession.ClassName, aDatabaseName);

  if (Result = nil) then
    raise EDataError.CreateFmt('TdaMetaDataManager.GetMetaData: No meta data found for database, %s', [aDatabaseName]);

  Result.Session := aSession;
  Result.DataDictionary := aDataDictionary;

end;


{@TdaMetaDataManager.GetFields}

procedure TdaMetaDataManager.GetFields(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName, aTableName, aSQLTableName: String; aFields: TList);
var
  lMetaData: TdaMetaData;
begin

  FLock.Acquire;

  try
    lMetaData := GetMetaData(aSession, aDataDictionary, aDatabaseName);

    lMetaData.GetFields(aTableName, aSQLTableName, aFields);

    lMetaData.Session := nil;
    lMetaData.DataDictionary := nil;

  finally
    FLock.Release;

  end;

end;

{@TdaMetaDataManager.GetMaxFieldAliasLength}

function TdaMetaDataManager.GetMaxFieldAliasLength(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName, aRawTableName: String): Integer;
var
  lMetaData: TdaMetaData;
begin

  FLock.Acquire;

  try
    lMetaData := GetMetaData(aSession, aDataDictionary, aDatabaseName);

    Result := lMetaData.GetMaxFieldAliasLength(aRawTableName);

    lMetaData.Session := nil;
    lMetaData.DataDictionary := nil;

  finally
    FLock.Release;

  end;

end;

{@TdaMetaDataManager.GetTableAlias}

function TdaMetaDataManager.GetTableAlias(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName, aRawTableName: String): String;
var
  lMetaData: TdaMetaData;
begin

  FLock.Acquire;

  try
    lMetaData := GetMetaData(aSession, aDataDictionary, aDatabaseName);

    Result := lMetaData.GetTableAlias(aRawTableName);

    lMetaData.Session := nil;
    lMetaData.DataDictionary := nil;

  finally
    FLock.Release;

  end;

end;

{@TdaMetaDataManager.GetTables}

procedure TdaMetaDataManager.GetTables(aSession: TdaSession; aDataDictionary: TppDataDictionary; aDatabaseName: String; aTables: TList);
var
  lMetaData: TdaMetaData;
begin

  FLock.Acquire;

  try
    lMetaData := GetMetaData(aSession, aDataDictionary, aDatabaseName);

    lMetaData.GetTables(aTables);

    lMetaData.Session := nil;
    lMetaData.DataDictionary := nil;

  finally

    FLock.Release;

  end;

end;

{@TdaMetaDataManager.GetTableListForDialog}

procedure TdaMetaDataManager.GetTableListForDialog(aTables: TList);
var
  lMetaData: TdaMetaData;
begin

  FLock.Acquire;


  try
    aTables.Clear;

    if (FMetaDataList.Count > 0) then
      begin
        lMetaData := FMetaDataList[0];

        lMetaData.GetTables(aTables);

      end;


  finally

    FLock.Release;

  end;



end;


{*******************************************************************************
 *
 ** M E T A D A T A  L I S T
 *
{******************************************************************************}

{@TdaMetaDataList.Create}

constructor TdaMetaDataList.Create;
begin

  inherited Create;

  FList := TList.Create;

end;

{@TdaMetaDataList.Destroy}

destructor TdaMetaDataList.Destroy;
begin

  Clear;

  FList.Free;

  inherited;

end;

{@TdaMetaDataList.Clear}

procedure TdaMetaDataList.Clear;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FList.Count - 1 do
    TObject(FList[liIndex]).Free;

  FList.Clear;

end;


{@TdaMetaDataList.GetCount}

function TdaMetaDataList.GetCount: Integer;
begin

  Result := FList.Count;

end;

{@TdaMetaDataList.GetMetaDataForIndex}

function TdaMetaDataList.GetMetaDataForIndex(aIndex: Integer): TdaMetaData;
begin

  Result := TdaMetaData(FList[aIndex]);

end;

{@TdaMetaDataList.GetMetaData}

function TdaMetaDataList.GetMetaData(aSessionClassName, aDatabaseName: String): TdaMetaData;
var
  liIndex: Integer;
  lMetaData: TdaMetaData;
begin

  Result := nil;
  liIndex := 0;

  {look for a match}
  while (Result = nil) and (liIndex < FList.Count) do
    begin
      lMetaData := TdaMetaData(FList[liIndex]);

      if (lMetaData.DatabaseName = aDatabaseName) and
         (lMetaData.SessionClassName = aSessionClassName) then
         Result := lMetaData
      else
        Inc(liIndex);

    end;

  {create a new entry}
  if (Result = nil) then
    begin
      lMetaData := TdaMetaData.Create(nil);
      lMetaData.DatabaseName := aDatabaseName;

      FList.Add(lMetaData);

      Result := lMetaData;

    end;
    

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization
  gMetaDataManager := TdaMetaDataManager.Create;

finalization
  gMetaDataManager.Free;
  gMetaDataManager := nil;


end.
