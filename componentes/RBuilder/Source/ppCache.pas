{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppCache;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Classes, SysUtils, ppComm, ppTypes, ppUtils, ppRelatv, ppRTTI;

type
  TppCacheable = class;

  TppAddCacheableProc = procedure(aCacheable: TppCacheable) of object;

  {@TppCacheManager }

  {@TppCacheManager.CachePath

    Run-time only.  You should rarely, if ever, need to set this property.  When
    a report is very long (over 1,000 pages), the report engine may switch to
    disk-based caching if it runs out of memory. In the event that this occurs,
    the value of this property indicates the directory to which the temporary
    caching files will be written.

    Defaults to the current windows path for temporary files.}

  {@TppCacheManager.CacheType

    Run-time only.  You should rarely, if ever, need to set this property.  When
    a report is very long (over 1,000 pages), the report engine may switch to
    disk-based caching if it runs out of memory.  In the event that this occurs,
    the value of this property indicates whether the caching has changed.  Also,
    if for some reason you would like to force file caching, you can set this
    property to ppCTFile.  The temporary caching files will be written to the
    directory specified in the CachePath property.


    <Table>
    Value       Meaning
    ----------  -------
    ppCTFile    Report engine caches to disk files.
    ppCTMemory  Report engine caches to memory
    </Table>}

  TppCacheManager = class(TppCommunicator)
  private
    FCacheFileNames: TStringList;
    FCaches: TList;
    FCacheables: TList;
    FCachePageCount: Longint;
    FCachePath: String;
    FCacheSizes: TStringList;
    FCacheType: TppCacheType;
    FDumpNotification: Boolean;
    FReport: TComponent;

    procedure AttachCacheables;
    procedure CategorizeCacheable(aCacheable: TppCacheable);
    procedure CreateStreams;
    procedure DetachCacheables;
    procedure FreeStreams;
    function GetCountForSize(aCacheRecordSize: Integer): Integer;
    function GetPositionForCacheable(aCacheable: TppCacheable): Integer;
    procedure SetCachePath(aPath: String);
    procedure SetCacheType(aCacheType: TppCacheType);
    procedure TakeCacheAction(aAction: TppCacheActionType; aCachePageNo: Longint);

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
    procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

    procedure AddCacheable(aCacheable: TppCacheable);
    procedure DumpCache(aCachePageNo: Longint);
    procedure RaiseException;
    procedure ReadCache(aCachePageNo: Longint);
    procedure RemoveCacheable(aCacheable: TppCacheable);
    procedure ResetCache;
    procedure ResetCacheWithObjectList(aList: TList);
    procedure SetCacheableProperties(aCacheable: TppCacheable);
    procedure SwitchCache;
    procedure WriteCache(aCachePageNo: Longint);

    property CachePath: String read FCachePath write SetCachePath;
    property CacheType: TppCacheType read FCacheType write SetCacheType;
    property CachePageCount: Longint read FCachePageCount;
    property DumpNotification: Boolean read FDumpNotification write FDumpNotification;

  end; {class, TppCacheManager}

  {@TppCacheable

    This class implements the caching behavior of various components.}
    
  TppCacheable = class(TppRelative)
  private
    FCacheCount: Integer;
    FCachePageCount: Integer;
    FCachePosition: Integer;
    FCacheRecordSize: Integer;
    FCacheStream: TStream;

  protected
    procedure ReadRecordFromCache(aCachePageNo: Longint; var aCacheRecord);
    procedure WriteRecordToCache(aCachePageNo: Longint; var aCacheRecord);

  public
    constructor Create(aOwner: TComponent); override;

    procedure FreeCache(aCachePageNo: Longint); virtual;
    procedure RestoreFromCache(aCachePageNo: Longint); virtual;
    procedure SaveToCache(aCachePageNo: Longint); virtual;

    property CacheCount: Integer read FCacheCount write FCacheCount;
    property CachePageCount: Integer read FCachePageCount write FCachePageCount;
    property CachePosition: Integer read FCachePosition write FCachePosition;
    property CacheRecordSize: Integer read FCacheRecordSize write FCacheRecordSize;
    property CacheStream: TStream read FCacheStream write FCacheStream;

  end; {class, TppCacheable}


  {@TraTppCacheableRTTI }
  TraTppCacheableRTTI = class(TraTppRelativeRTTI)
    public
      {class procedure GetPropList(aPropList: TraPropList); override;}
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      {class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList): Boolean; override;}
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      {class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;}
  end; {class, TraTppCacheableRTTI}


implementation

uses
  ppClass, ppBands, ppReport;

{------------------------------------------------------------------------------}
{ TppCacheManager.Create }

constructor TppCacheManager.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);

  EventNotifies := [ciCacheableSwitchCache, ciCacheableRaiseException];

  FCacheables := TList.Create;
  FCacheFileNames := TStringList.Create;
  FCachePath := ppGetTempPath;
  FCaches := TList.Create;
  FCacheSizes := TStringList.Create;
  FCacheType := ppctMemory;
  FCachePageCount := -1;
  FDumpNotification := True;
  FReport := aOwner;

  {add cache manager to list, sets up notification for cache dumping}
  TppCustomReport(FReport).AddCacheManager(Self);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCacheManager.Destroy }

destructor TppCacheManager.Destroy;
begin

  TppCustomReport(FReport).RemoveCacheManager(Self);

  {4.24, put csDestroying in State, which lets any reference objects know we are destroying}
  Destroying;

  {free streams}
  FreeStreams;

  {free lists}
  FCacheables.Free;
  FCacheFileNames.Free;
  FCaches.Free;
  FCacheSizes.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCacheManager.Notify }

procedure TppCacheManager.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator is TppCacheable) then
    RemoveCacheable(TppCacheable(aCommunicator));

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppCacheManager.EventNotify }

procedure TppCacheManager.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  if not(aCommunicator is TppCacheable) then Exit;

  case aEventID of
    ciCacheableSwitchCache:
      SwitchCache;

    ciCacheableRaiseException:
      RaiseException;

  end;

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppCacheManager.SetCacheableProperties }

procedure TppCacheManager.SetCacheableProperties(aCacheable: TppCacheable);
var
  lsCacheSize: String;
  liCacheIndex: Integer;
begin

  {get the cache size as a string}
  lsCacheSize := IntToStr(aCacheable.CacheRecordSize);

  {has a cache already been created for this size?}
  liCacheIndex := FCacheSizes.IndexOf(lsCacheSize);

  {get the cache stream}
  if (liCacheIndex <> -1) then
    aCacheable.CacheStream := TStream(FCaches[liCacheIndex])
  else
    aCacheable.CacheStream := nil;

  {update cache page count}
  aCacheable.CachePageCount := FCachePageCount;

  {update cache count, this only works after all cacheables have been categorized and is
   needed for group.keeptogether while the engine is running}
  aCacheable.CacheCount := GetCountForSize(aCacheable.CacheRecordSize);

  {update cache position, this only works after all cacheables have been categorized and is
   needed for group.keeptogether while the engine is running}
  aCacheable.CachePosition := GetPositionForCacheable(aCacheable);

end; {procedure, SetCacheableProperties}

{------------------------------------------------------------------------------}
{ TppCacheManager.AddCacheable }

procedure TppCacheManager.AddCacheable(aCacheable: TppCacheable);
begin

  if (aCacheable = nil) then Exit;

  if (FCacheables.IndexOf(aCacheable) <> -1) then Exit;

  FCacheables.Add(aCacheable);

  aCacheable.AddEventNotify(Self);

end; {procedure, AddCacheable}

{------------------------------------------------------------------------------}
{ TppCacheManager.RemoveCacheable }

procedure TppCacheManager.RemoveCacheable(aCacheable: TppCacheable);
begin

  if (aCacheable = nil) then Exit;

  aCacheable.CacheStream := nil;

  FCacheables.Remove(aCacheable);

  aCacheable.RemoveEventNotify(Self);

end; {procedure, RemoveCacheable}

{------------------------------------------------------------------------------}
{ TppCacheManager.SetCacheType }

procedure TppCacheManager.SetCacheType(aCacheType: TppCacheType);
begin

  if aCacheType = FCacheType then Exit;

  if FCacheType = ppctMemory then
    SwitchCache;

end; {procedure, SetCacheType}

{------------------------------------------------------------------------------}
{ TppCacheManager.SetCachePath }

procedure TppCacheManager.SetCachePath(aPath: String);
begin

  FCachePath := aPath;

  if (Copy(FCachePath, Length(FCachePath), 1) <> '\') then
    FCachePath := FCachePath + '\';

end; {procedure, SetCachePath}

{------------------------------------------------------------------------------}
{ TppCacheManager.ResetCache }

procedure TppCacheManager.ResetCache;
begin
  FreeStreams;

  CreateStreams;
end; {procedure, ResetCache}

{------------------------------------------------------------------------------}
{ TppCacheManager.ResetCacheWithObjectList }

procedure TppCacheManager.ResetCacheWithObjectList(aList: TList);
var
  liIndex: Integer;
begin

  FreeStreams;

  for liIndex := 0 to (aList.Count - 1) do
    AddCacheable(TppCacheable(aList[liIndex]));

  {creates or assigns a stream based on cacherecordsize,
   assigns the cachestream and cacheposition of the cacheables}
  TakeCacheAction(ppcaCreate, 0);

  {assigns the cachecount (total cacheables in each size category)
   can only be done after all cacheables are categorized}
  TakeCacheAction(ppcaSetCacheCount, 0);

end; {procedure, ResetCacheWithObjectList}

{------------------------------------------------------------------------------}
{ TppCacheManager.ReadCache }

procedure TppCacheManager.ReadCache(aCachePageNo: Longint);
begin

  TakeCacheAction(ppcaRead, aCachePageNo)

end; {procedure, ReadCache}

{------------------------------------------------------------------------------}
{ TppCacheManager.DumpCache }

procedure TppCacheManager.DumpCache(aCachePageNo: Longint);
var
  liStream: Integer;
  liCacheSize: Integer;
  llSize: Longint;
  liCacheCount: Integer;
begin

  if (FCachePageCount = -1) then Exit;
  
  if (FDumpNotification) then
    TakeCacheAction(ppcaDump, aCachePageNo);

  for liStream := 0 to FCaches.Count - 1 do
    begin
      {get size of individual cache entry}
      liCacheSize := StrToInt(FCacheSizes[liStream]);
      liCacheCount := GetCountForSize(liCacheSize);

      {calculate amount of cache to transfer}
      llSize := aCachePageNo * (liCacheSize * liCacheCount);

      {reset the stream to new size}
      TStream(FCaches[liStream]).Size := llSize;
    end;

  FCachePageCount := aCachePageNo - 1;

end; {procedure, DumpCache}

{------------------------------------------------------------------------------}
{ TppCacheManager.WriteCache }

procedure TppCacheManager.WriteCache(aCachePageNo: Longint);
begin

  TakeCacheAction(ppcaWrite, aCachePageNo);

  if (FCachePageCount < aCachePageNo) then
    FCachePageCount := aCachePageNo;

end; {procedure, WriteCache}

{------------------------------------------------------------------------------}
{ TppCacheManager.TakeCacheAction }

procedure TppCacheManager.TakeCacheAction(aAction: TppCacheActionType; aCachePageNo: Longint);
var
  liIndex : Integer;
  lCacheable: TppCacheable;
begin

  for liIndex := 0 to (FCacheables.Count - 1) do
    begin

      lCacheable := TppCacheable(FCacheables[liIndex]);

      case aAction of

        ppcaCreate:
          CategorizeCacheable(lCacheable);

        ppcaFree, ppcaDump:
          begin
            SetCacheableProperties(lCacheable);

            lCacheable.FreeCache(aCachePageNo);

            lCacheable.CachePageCount := (aCachePageNo - 1);
          end;

        ppcaRead:
          begin
            SetCacheableProperties(lCacheable);

            lCacheable.RestoreFromCache(aCachePageNo);
          end;

        ppcaWrite:
          begin
            SetCacheableProperties(lCacheable);

            lCacheable.SaveToCache(aCachePageNo);
          end;

        ppcaSetCacheableProperties:
          SetCacheableProperties(lCacheable);

        ppcaSetCacheCount:
          lCacheable.CacheCount := GetCountForSize(lCacheable.CacheRecordSize);

      end; {case, action type}

    end; {for, each cacheable}

end; {procedure, TakeCacheAction}

{------------------------------------------------------------------------------}
{ TppCacheManager.SwitchCache }

procedure TppCacheManager.SwitchCache;
var
  lFileStream: TFileStream;
  lsFileName: String;
  lMemoryStream: TMemoryStream;
  liStream: Integer;
begin

  if FCacheType = ppctFile then
    RaiseException
  else
    begin
      FCacheType := ppctFile;

      for liStream := 0 to FCaches.Count - 1 do
        begin
          lMemoryStream := TMemoryStream(FCaches[liStream]);

          {transfer the memory streams to file streams}
          lsFileName := ppGetTempFileName(FCachePath, 'cch');
          FCacheFileNames.Add(lsFileName);

          lFileStream := TFileStream.Create(lsFileName, fmCreate);
          TMemoryStream(lMemoryStream).SaveToStream(lFileStream);
          lMemoryStream.Free;

          FCaches[liStream] := lFileStream;
          lFileStream.Seek(0, 2);
        end;

      {point the cacheables at the new cache stream}
      TakeCacheAction(ppcaSetCacheableProperties, 0);
    end;

end; {procedure, SwitchCache}

{------------------------------------------------------------------------------}
{ TppCacheManager.CreateStreams }

procedure TppCacheManager.CreateStreams;
begin

  {scavenges the report for all cacheables and adds them to the list}
  AttachCacheables;

  {creates or assigns a stream based on cacherecordsize,
   assigns the cachestream and cacheposition of the cacheables}
  TakeCacheAction(ppcaCreate, 0);

  {assigns the cachecount (total cacheables in each size category)
   can only be done after all cacheables are categorized}
  TakeCacheAction(ppcaSetCacheCount, 0);

end; {procedure, CreateStreams}

{------------------------------------------------------------------------------}
{ TppCacheManager.FreeStreams  }

procedure TppCacheManager.FreeStreams;
var
  liFiles: Integer;
  liFile: Integer;
  lsFileName: String;
  liStream: Integer;
begin

  {notify cacheables that cache is clearing}
  TakeCacheAction(ppcaFree, 0);

  FCachePageCount := -1;

  {detach cacheables}
  DetachCacheables;

  {free the streams}
  for liStream := FCaches.Count - 1 downto 0 do
    TStream(FCaches[liStream]).Free;

  FCaches.Clear;
  FCacheSizes.Clear;
  FCacheables.Clear;

  {delete temporary files}
  if (FCacheType = ppctFile) then
    begin
      liFiles := FCacheFileNames.Count;

      for liFile := 0 to liFiles - 1 do
        begin
          lsFileName := FCacheFileNames[liFile];

          if FileExists(lsFileName) then
            SysUtils.DeleteFile(lsFileName);
        end;

      FCacheFileNames.Clear;

    end; {if, file-based caching}

end; {procedure, FreeStreams}

{------------------------------------------------------------------------------}
{ TppCacheManager.CategorizeCacheable  }

procedure TppCacheManager.CategorizeCacheable(aCacheable: TppCacheable);
var
  liCacheIndex: Integer;
  lsCacheSize: String;
  lsFileName: String;
  liCachePosition: Integer;
  lStream: TStream;
begin

  {get the cache size as a string}
  lsCacheSize := IntToStr(aCacheable.CacheRecordSize);

  {has a cache already been created for this size?}
  liCacheIndex := FCacheSizes.IndexOf(lsCacheSize);

  if (liCacheIndex = -1) then
    begin
      {create a new cache}

      if FCacheType = ppctMemory then
        lStream := TMemoryStream.Create

      else if FCacheType = ppctFile then
        begin
          {create new file streams}
          lsFileName := ppGetTempFileName(FCachePath, 'cch');
          FCacheFileNames.Add(lsFileName);
          lStream := TFileStream.Create(lsFileName, fmCreate);
        end
      else
        lStream := nil;

      liCachePosition := 0;

      {save the stream, size & position}
      if (lStream <> nil) then
        begin
          liCacheIndex := FCaches.Add(lStream);

          FCacheSizes.AddObject(lsCacheSize, TObject(liCachePosition));
        end;

    end

  else
    begin
      {determine last cache position}
      liCachePosition := Integer(FCacheSizes.Objects[liCacheIndex]);

      {increment cache position}
      Inc(liCachePosition);

      {save new cache position}
      FCacheSizes.Objects[liCacheIndex] := TObject(liCachePosition);
    end;

  aCacheable.CachePosition := liCachePosition;
  aCacheable.CacheStream := TStream(FCaches[liCacheIndex])

end; {procedure, CategorizeCacheable}

{------------------------------------------------------------------------------}
{ TppCacheManager.GetPositionForCacheable  }

function TppCacheManager.GetPositionForCacheable(aCacheable: TppCacheable): Integer;
var
  lCacheable: TppCacheable;
  liCacheRecordSize: Integer;
  lbFound: Boolean;
  liIndex: Integer;
begin

  Result := 0;

  liCacheRecordSize := aCacheable.CacheRecordSize;

  lbFound := False;
  liIndex := 0;

  while not(lbFound) and (liIndex < FCacheables.Count)do
    begin
      lCacheable := TppCacheable(FCacheables[liIndex]);

      if (lCacheable = aCacheable) then
        lbFound := True

      else if (lCacheable.CacheRecordSize = liCacheRecordSize) then
        Inc(Result);

      Inc(liIndex);
    end;

end; {procedure, GetPositionForCacheable}

{------------------------------------------------------------------------------}
{ TppCacheManager.GetCountForSize  }

function TppCacheManager.GetCountForSize(aCacheRecordSize: Integer): Integer;
var
  liPosition: Integer;
  lsCacheSize: String;
begin
  lsCacheSize := IntToStr(aCacheRecordSize);

  liPosition := FCacheSizes.IndexOf(lsCacheSize);

  Result := Integer(FCacheSizes.Objects[liPosition]) + 1;

end; {procedure, GetCountForSize}

{------------------------------------------------------------------------------}
{ TppCacheManager.AttachCacheables }

procedure TppCacheManager.AttachCacheables;
begin

  if not(FReport is TppCustomReport) then Exit;

  TppCustomReport(FReport).GetCacheables(AddCacheable);

end; {procedure, AttachCacheables}

{------------------------------------------------------------------------------}
{ TppCacheManager.DetachCacheables }

procedure TppCacheManager.DetachCacheables;
var
  liIndex : Integer;
begin

  for liIndex := 0 to FCacheables.Count - 1 do
    RemoveCacheable(TppCacheable(FCacheables[0]));

end; {procedure, DetachCacheables}

{------------------------------------------------------------------------------}
{ TppCacheManager.RaiseException }

procedure TppCacheManager.RaiseException;
var
  lReport: TppCustomReport;
  lEngine: TppCustomEngine;
begin

  lReport := TppCustomReport(FReport);

  lEngine := lReport.Engine;

  if lEngine.Printing then
    lEngine.StopPrinting := True;

  {raise the exeception for real}
  raise EPrintError.Create(ppLoadStr(284));

end; {procedure, RaiseException }

{******************************************************************************
 *
 ** C A C H E A B L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCacheable.Create }

constructor TppCacheable.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FCacheCount := 0;
  FCachePageCount := -1;
  FCachePosition := 0;
  FCacheRecordSize := 0;
  FCacheStream := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCacheable.ReadRecordFromCache }

procedure TppCacheable.ReadRecordFromCache(aCachePageNo: Longint; var aCacheRecord);
var
  llPosition: Longint;
  llSeek: Longint;
begin
  llPosition := (aCachePageNo * CacheCount) + CachePosition;

  llSeek := (CacheRecordSize * llPosition);

  if (llSeek > CacheStream.Size) then Exit;

  CacheStream.Seek(llSeek,0);

  CacheStream.Read(aCacheRecord, CacheRecordSize);
  
end; {procedure, ReadRecordFromCache }

{------------------------------------------------------------------------------}
{ TppCacheable.WriteRecordToCache }

procedure TppCacheable.WriteRecordToCache(aCachePageNo: Longint; var aCacheRecord);
var
  llPosition: Longint;
  llSeek: LongInt;
begin
  llPosition := (aCachePageNo * CacheCount) + CachePosition;

  llSeek := (CacheRecordSize * llPosition);

  if (llSeek <= CacheStream.Size) then
    CacheStream.Seek(llSeek,0);

  try
    CacheStream.Write(aCacheRecord, CacheRecordSize);
  except
    SendEventNotify(Self, ciCacheableSwitchCache, nil);
    CacheStream.Seek(llPosition, 0);
    try
      CacheStream.Write(aCacheRecord, CacheRecordSize);
    except
      SendEventNotify(Self, ciCacheableRaiseException, nil);
    end; {try, except}
  end; {try, except}

end; {procedure, WriteRecordToCache }

{------------------------------------------------------------------------------}
{ TppCacheable.RestoreFromCache }

procedure TppCacheable.RestoreFromCache(aCachePageNo: Longint);
begin

end; {procedure, RestoreFromCache }

{------------------------------------------------------------------------------}
{ TppCacheable.SaveToCache }

procedure TppCacheable.SaveToCache(aCachePageNo: Longint);
begin

end; {procedure, SaveToCache }

{------------------------------------------------------------------------------}
{ TppCacheable.FreeCache }

procedure TppCacheable.FreeCache(aCachePageNo: Longint);
begin

end; {procedure, FreeCache }


{******************************************************************************
 *
 ** C A C H E A B L E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCacheableRTTI.RefClass }

class function TraTppCacheableRTTI.RefClass: TClass;
begin
  Result := TppCacheable;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCacheableRTTI.GetPropRec }

class function TraTppCacheableRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if CompareText(aPropName, 'CacheCount') = 0 then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if CompareText(aPropName, 'CachePageCount') = 0 then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if CompareText(aPropName, 'CachePosition') = 0 then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if CompareText(aPropName, 'CacheRecordSize') = 0 then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if CompareText(aPropName, 'CacheStream') = 0 then
    ClassPropToRec(aPropName, TStream, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCacheableRTTI.GetPropValue }

class function TraTppCacheableRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if CompareText(aPropName, 'CacheCount') = 0 then
    Integer(aValue) := TppCacheable(aObject).CacheCount

  else if CompareText(aPropName, 'CachePageCount') = 0 then
    Integer(aValue) := TppCacheable(aObject).CachePageCount

  else if CompareText(aPropName, 'CachePosition') = 0 then
    Integer(aValue) := TppCacheable(aObject).CachePosition

  else if CompareText(aPropName, 'CacheRecordSize') = 0 then
    Integer(aValue) := TppCacheable(aObject).CacheRecordSize

  else if CompareText(aPropName, 'CacheStream') = 0 then
    Integer(aValue) := Integer(TppCacheable(aObject).CacheStream)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


initialization

  raRegisterRTTI(TraTppCacheableRTTI);

finalization

  raUnRegisterRTTI(TraTppCacheableRTTI);

end.
