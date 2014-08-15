{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressScheduler                                 }
{                                                                    }
{       Copyright (c) 2003-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxSchedulerAggregateStorage;

{$I cxVer.inc}

interface

uses
  Classes, cxClasses, Controls, cxSchedulerStorage, cxSchedulerHolidays,
  cxSchedulerUtils, cxCustomData;

type

  TcxSchedulerStorageLinks = class;
  TcxSchedulerAggregateStorage = class;

  TcxSchedulerStorageLinkClass = class of TcxSchedulerStorageLink;

  { TcxSchedulerStorageLink }

  TcxSchedulerStorageLink = class(TCollectionItem)
  private
    FIsDestroying: Boolean;
    FStorage: TcxCustomSchedulerStorage;
    function GetAggregateStorage: TcxSchedulerAggregateStorage;
    function GetDefault: Boolean;
    function GetLinks: TcxSchedulerStorageLinks;
    procedure SetDefault(AValue: Boolean);
    procedure SetStorage(AValue: TcxCustomSchedulerStorage);
  protected
    property IsDestroying: Boolean read FIsDestroying;
  public
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property AggregateStorage: TcxSchedulerAggregateStorage read GetAggregateStorage;
    property Links: TcxSchedulerStorageLinks read GetLinks;
  published
    property Default: Boolean read GetDefault write SetDefault default False;
    property Storage: TcxCustomSchedulerStorage read FStorage write SetStorage;
  end;

  { TcxSchedulerStorageLinks }

  TcxSchedulerStorageLinks = class(TCollection)
  private
    FAggregateStorage: TcxSchedulerAggregateStorage;
    FDefaultLink: TcxSchedulerStorageLink;
    function GetDefaultStorage: TcxCustomSchedulerStorage;
    function GetItem(AIndex: Integer): TcxSchedulerStorageLink;
    procedure SetDefaultLink(AValue: TcxSchedulerStorageLink);
    procedure SetItem(AIndex: Integer; AValue: TcxSchedulerStorageLink);
  protected
    function GetItemLinkClass: TcxSchedulerStorageLinkClass; virtual;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor CreateEx(AOwner: TcxSchedulerAggregateStorage); virtual;

    function AddStorageLink(AStorage: TcxCustomSchedulerStorage): TcxSchedulerStorageLink;
    function GetStorageLinkIndex(AStorage: TcxCustomSchedulerStorage): Integer;
    procedure PopulateHolidays(AList: TList);

    property AggregateStorage: TcxSchedulerAggregateStorage read FAggregateStorage;
    property DefaultLink: TcxSchedulerStorageLink read FDefaultLink write SetDefaultLink;
    property DefaultStorage: TcxCustomSchedulerStorage read GetDefaultStorage;
    property Items[AIndex: Integer]: TcxSchedulerStorageLink read GetItem write SetItem; default;
  end;

  { TcxSchedulerAggregateStorageEvent }

  TcxSchedulerAggregateStorageEvent = class(TcxSchedulerEvent)
  private
    FSourceEvent: TcxSchedulerEvent;
    function GetStorage: TcxSchedulerAggregateStorage;
  protected
    MappedID: Integer;
    MappedParentID: Integer;
    procedure CheckParentID;
    function GetParentID: Variant; override;
    function GetValueByIndex(AIndex: Integer): Variant; override;
    procedure SetSourceEvent(AValue: TcxSchedulerEvent);
    procedure SetValue(AField: TcxCustomSchedulerStorageField; const AValue: Variant); override;
  public
    procedure DeleteExceptions; override;
    procedure RemoveRecurrence; override;

    property SourceEvent: TcxSchedulerEvent read FSourceEvent;
    property Storage: TcxSchedulerAggregateStorage read GetStorage;
  end;

  { TcxSchedulerAggregateStorageDataSource }

  TcxSchedulerAggregateStorageDataSource = class(TcxCustomDataSource)
  private
    FStorage: TcxSchedulerAggregateStorage;
  protected
    function GetRecordCount: Integer; override;
    function GetRecordId(ARecordHandle: TcxDataRecordHandle): Variant; override;
    function GetRecordHandle(ARecordIndex: Integer): TcxDataRecordHandle; override;
    function GetValue(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant; override;
    function IsRecordIdSupported: Boolean; override;
    procedure SetValue(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle; const AValue: Variant); override;
  public
    constructor Create(AStorage: TcxSchedulerAggregateStorage); virtual;

    property Storage: TcxSchedulerAggregateStorage read FStorage;
  end;

  { TcxSchedulerAggregateStorage }

  TcxSchedulerEventInsertingEvent = procedure(Sender: TcxSchedulerAggregateStorage;
    AEvent: TcxSchedulerEvent; var AStorage: TcxCustomSchedulerStorage) of object;

  TcxSchedulerAggregateStorage = class(TcxCustomSchedulerStorage, IcxSchedulerStorageListener)
  private
    FCounter: Integer;
    FLinks: TcxSchedulerStorageLinks;
    FProvider: TcxSchedulerAggregateStorageDataSource;
    FSynchronizing: Boolean;
    FOnEventInserting: TcxSchedulerEventInsertingEvent;
    function CanRefresh: Boolean;
    function GetCustomFields: TcxSchedulerStorageFields;
    procedure SetCustomFields(const AValue: TcxSchedulerStorageFields);
  protected
    function CreateDataProvider: TcxSchedulerAggregateStorageDataSource; virtual;
    procedure DestroyDataProvider;
    procedure DoDeleteEvent(const ARecordIndex: Integer); override;
    procedure DoEventInserting(AEvent: TcxSchedulerEvent; out AStorage: TcxCustomSchedulerStorage); virtual;
    function DoFilterEvent(AEvent: TcxSchedulerEvent): Boolean; override;
    procedure DoRefresh; override;
    function GetEventClass: TcxSchedulerEventClass; override;
    function GetMappedID(ASource: TcxSchedulerEvent): Integer;
    function GetRecordID(const ARecordIndex: Integer): Variant; override;
    function InternalAddEvent(AEvent: TcxSchedulerEvent): TcxSchedulerAggregateStorageEvent; virtual;
    function IsDesigning: Boolean;
    function IsDestroining: Boolean;
    procedure PopulateEvents(var AList: TList); virtual;
    procedure PostEditingData(AEvent: TcxSchedulerEvent); override; 
    procedure PostEvent(AEvent: TcxSchedulerEvent); override;
    procedure SendNotification(AIsRemoved: Boolean = False); override;
    procedure SynchronizeEventsWithRecords; override;

    procedure BeginUpdateDataController; override;
    procedure EndUpdateDataController; override;
    // IcxSchedulerStorageListener & IcxSchedulerStorageListener2
    procedure StorageChanged(Sender: TObject);
    procedure StorageRemoved(Sender: TObject);

    property Provider: TcxSchedulerAggregateStorageDataSource read FProvider;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    function createEvent: TcxSchedulerEvent; override;
    procedure GenerateHolidayEvents(const AResourceID: Variant); override;
    function GetHolidayNamesByDate(ADate: TDate; var ANames: string;
      AOnlyVisible: Boolean = True): Boolean; override;
    function IsActive: Boolean; override;
    procedure PopulateHolidayDates(AList: TcxSchedulerDateList; AStart, AFinish: TDate;
      AOnlyVisible: Boolean = True; AClearList: Boolean = True); override;
  published
    property CustomFields: TcxSchedulerStorageFields read GetCustomFields write SetCustomFields;
    property Reminders;
    property Resources;
    property Links: TcxSchedulerStorageLinks read FLinks write FLinks;
    property OnEventInserting: TcxSchedulerEventInsertingEvent read
      FOnEventInserting write FOnEventInserting;
    property OnEventIntersect;
    property OnFilterEvent;
  end;

implementation

uses
  SysUtils, Variants, Types, cxVariants;

type

  TcxCustomSchedulerStorageAccess = class(TcxCustomSchedulerStorage);

  TcxSyncObject = class(TList)
  public
    IsSource: Boolean;
    Link: TObject;
    Source: TObject;
    IsUnique: Boolean;
  end;

  TcxSynchronizer = class(TcxObjectList)
  private
    function GetItem(AIndex: Integer): TcxSyncObject;
  protected
    function Add(ALink, ASource: TObject; AIsSource: Boolean): TcxSyncObject;
  public
    procedure AddItems(AEvents: TList);
    procedure AddSources(AEvents: TList);
    procedure Synchronize;

    property Items[AIndex: Integer]: TcxSyncObject read GetItem;
  end;

function cxCompareSyncObjects(AItem1, AItem2: TcxSyncObject): Integer;
begin
  Result := Integer(AItem1.Source) - Integer(AItem2.Source);
  if Result = 0 then
    Result := Integer(AItem2.IsSource) - Integer(AItem1.IsSource);
end;

function cxCompareEventsByIndex(AEvent1, AEvent2: TcxSchedulerEvent): Integer;
begin
  Result := Integer(AEvent1) - Integer(AEvent2);
  if Result <> 0 then
  begin
    if AEvent1 = nil then
      Result := 1
    else
      if AEvent2 = nil then
        Result := -1
      else
        Result := AEvent1.RecordIndex - AEvent2.RecordIndex; 
  end;
end;

{ TcxSynchronizer }

procedure TcxSynchronizer.AddItems(AEvents: TList);
var
  I: Integer;
  AEvent: TcxSchedulerAggregateStorageEvent;
begin
  for I := 0 to AEvents.Count - 1 do
  begin
    AEvent := TcxSchedulerAggregateStorageEvent(AEvents.List^[I]);
    Add(AEvent, AEvent.SourceEvent, False);
  end;
end;

procedure TcxSynchronizer.AddSources(AEvents: TList);
var
  I: Integer;
begin
  for I := 0 to AEvents.Count - 1 do
    Add(AEvents.List^[I], AEvents.List^[I], True);
end;

function TcxSynchronizer.Add(ALink, ASource: TObject; AIsSource: Boolean): TcxSyncObject;
begin
  Result := TcxSyncObject.Create;
  Result.Link := ALink;
  Result.Source := ASource;
  Result.IsSource := AIsSource;  
  inherited Add(Result);
end;

{$B-}

procedure TcxSynchronizer.Synchronize;
var
  I: Integer;
  AItem: TcxSyncObject;
begin
  Sort(@cxCompareSyncObjects);
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    if AItem.IsSource then
      AItem.IsUnique := (I = (Count - 1)) or (AItem.Source <> Items[I + 1].Source)
    else
      AItem.IsUnique := (I = 0) or (AItem.Source <> Items[I - 1].Source);
  end;
end;

function TcxSynchronizer.GetItem(AIndex: Integer): TcxSyncObject;
begin
  Result := TcxSyncObject(List^[AIndex]);
end;

function cxCompareEvents(AItem1, AItem2: Integer): Integer;
begin
  Result := AItem1 - AItem2;
end;

procedure cxMakeUniqueList(AList: TList);
var
  I: Integer;
begin
  AList.Sort(@cxCompareEvents);
  for I := AList.Count - 1 downto 1 do
    if AList[I] = AList[I - 1] then
      AList.Delete(I);
end;

{ TcxSchedulerStorageLink }

destructor TcxSchedulerStorageLink.Destroy;
begin
  FIsDestroying := True;
  if Default then
    Links.FDefaultLink := nil;
  Storage := nil;
  inherited Destroy;
end;

procedure TcxSchedulerStorageLink.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerStorageLink then
  with Source as TcxSchedulerStorageLink do
    begin
      Self.Storage := Storage;
      Self.Default := Default;
    end
  else
    inherited Assign(Source);
end;

function TcxSchedulerStorageLink.GetAggregateStorage: TcxSchedulerAggregateStorage;
begin
  Result := Links.AggregateStorage;
end;

function TcxSchedulerStorageLink.GetDefault: Boolean;
begin
  Result := Links.DefaultLink = Self;
end;

function TcxSchedulerStorageLink.GetLinks: TcxSchedulerStorageLinks;
begin
  Result := inherited Collection as TcxSchedulerStorageLinks;
end;

procedure TcxSchedulerStorageLink.SetDefault(AValue: Boolean);
begin
  if AValue then
    Links.DefaultLink := Self;
end;

procedure TcxSchedulerStorageLink.SetStorage(AValue: TcxCustomSchedulerStorage);
begin
  if (Links.GetStorageLinkIndex(AValue) = -1) and
    (AValue <> AggregateStorage) then
  begin
    if FStorage <> nil then
      FStorage.RemoveListener(AggregateStorage);
    FStorage := AValue;
    if FStorage <> nil then
      FStorage.AddListener(AggregateStorage);
    if not IsDestroying then
      Changed(True);
  end;
end;

{ TcxSchedulerStorageLinks }

constructor TcxSchedulerStorageLinks.CreateEx(AOwner: TcxSchedulerAggregateStorage);
begin
  Create(GetItemLinkClass);
  FAggregateStorage := AOwner;
end;

function TcxSchedulerStorageLinks.AddStorageLink(
  AStorage: TcxCustomSchedulerStorage): TcxSchedulerStorageLink;
begin
  Result := nil;
  if GetStorageLinkIndex(AStorage) < 0 then
  begin
    BeginUpdate;
    try
      Result := Add as TcxSchedulerStorageLink;
      Result.Storage := AStorage;
    finally
      EndUpdate;
    end;
  end;
end;

function TcxSchedulerStorageLinks.GetStorageLinkIndex(
  AStorage: TcxCustomSchedulerStorage): Integer;
begin
  if AStorage <> nil then
    for Result := 0 to Count - 1 do
      if Items[Result].Storage = AStorage then Exit;
  Result := -1; 
end;

procedure TcxSchedulerStorageLinks.PopulateHolidays(AList: TList);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    with Items[I] do
    begin
      if (Storage <> nil) then
      if Storage is TcxSchedulerAggregateStorage then
        TcxSchedulerAggregateStorage(Storage).Links.PopulateHolidays(AList)
      else
        if Storage.Holidays <> nil then
          AList.Add(Storage.Holidays);
    end;
  cxMakeUniqueList(AList);
end;

function TcxSchedulerStorageLinks.GetItemLinkClass: TcxSchedulerStorageLinkClass;
begin
  Result := TcxSchedulerStorageLink;
end;

procedure TcxSchedulerStorageLinks.Update(Item: TCollectionItem);
var
  I: Integer;
begin
  inherited Update(Item);
  if Count > 0 then
  begin
    if (FDefaultLink = nil) or (FDefaultLink.Storage = nil) then
    begin
      for I := 0 to Count - 1 do
        if not Items[I].IsDestroying and (Items[I].Storage <> nil) then
        begin
          FDefaultLink := Items[I];
          Break;
        end;
    end;
  end;
  AggregateStorage.StorageChanged(nil);
end;

function TcxSchedulerStorageLinks.GetDefaultStorage: TcxCustomSchedulerStorage;
begin
  if FDefaultLink <> nil then
    Result := FDefaultLink.Storage
  else
    Result := nil;
end;

function TcxSchedulerStorageLinks.GetItem(AIndex:
  Integer): TcxSchedulerStorageLink;
begin
  Result := TcxSchedulerStorageLink(inherited Items[AIndex]);
end;

procedure TcxSchedulerStorageLinks.SetDefaultLink(
  AValue: TcxSchedulerStorageLink);
begin
  if ((AValue = nil) or ((AValue.Storage <> nil) and
    not AValue.IsDestroying)) and (FDefaultLink <> AValue) then
  begin
    FDefaultLink := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerStorageLinks.SetItem(AIndex: Integer;
  AValue: TcxSchedulerStorageLink);
begin
  Items[AIndex].Assign(AValue);
end;

{ TcxSchedulerAggregateStorageEvent }

procedure TcxSchedulerAggregateStorageEvent.DeleteExceptions;
begin
  SourceEvent.DeleteExceptions;
end;

procedure TcxSchedulerAggregateStorageEvent.RemoveRecurrence;
begin
  SourceEvent.RemoveRecurrence;
end;

procedure TcxSchedulerAggregateStorageEvent.CheckParentID;
begin
  if (Storage = nil) or Storage.IsDestroying then
    Exit;                                                                
  if (MappedParentID = -1) and (SourceEvent.Pattern <> nil) then
    MappedParentID := Storage.GetMappedID(SourceEvent.Pattern)
  else
    if (MappedParentID = -2) and (SourceEvent <> nil) and VarIsNumericEx(SourceEvent.ParentID) and
        (SourceEvent.ParentID >= 0) then
      MappedParentID := Storage.GetMappedID(SourceEvent.Storage.GetEventByID(SourceEvent.ParentID));
end;

function TcxSchedulerAggregateStorageEvent.GetParentID: Variant;
begin
  Result := MappedParentID;
end;

function TcxSchedulerAggregateStorageEvent.GetValueByIndex(AIndex: Integer): Variant;
begin
  if (SourceEvent = nil) or IsEditing then
  begin
    if (AIndex = TcxSchedulerAggregateStorage(Storage).FParentIDField.Index) and
      (EventType in [etCustom, etException]) and
      ((FPattern <> nil) or (ParentID >= 0)) then
    begin
      if FPattern <> nil then
        Result := TcxSchedulerAggregateStorageEvent(FPattern).SourceEvent.ID
      else
        Result := TcxSchedulerAggregateStorageEvent(Storage.GetEventByID(ParentID)).SourceEvent.ID;
    end
    else
      Result := FEditValues[AIndex]
  end
  else
{    if SourceEvent <> nil then
      Result := SourceEvent.Values[AIndex]
    else            }
      Result := inherited GetValueByIndex(AIndex);
end;

procedure TcxSchedulerAggregateStorageEvent.SetSourceEvent(AValue: TcxSchedulerEvent);
begin
  FSourceEvent := AValue;
end;

procedure TcxSchedulerAggregateStorageEvent.SetValue(AField: TcxCustomSchedulerStorageField;
  const AValue: Variant);
begin
  if IsEditing and
      (AField = TcxSchedulerAggregateStorage(Storage).FParentIDField) then
    MappedParentID := AValue
  else
    inherited SetValue(AField, AValue);
end;

function TcxSchedulerAggregateStorageEvent.GetStorage: TcxSchedulerAggregateStorage;
begin
  Result := TcxSchedulerAggregateStorage(inherited Storage);
end;

{ TcxSchedulerAggregateStorageDataSource }

constructor TcxSchedulerAggregateStorageDataSource.Create(AStorage: TcxSchedulerAggregateStorage);
begin
  FStorage := AStorage;
end;

function TcxSchedulerAggregateStorageDataSource.GetRecordCount: Integer;
begin
  Result := Storage.EventCount;
end;

function TcxSchedulerAggregateStorageDataSource.GetRecordId(
  ARecordHandle: TcxDataRecordHandle): Variant;
begin
  Result := TcxSchedulerAggregateStorageEvent(ARecordHandle).MappedID;
end;

function TcxSchedulerAggregateStorageDataSource.GetRecordHandle(
  ARecordIndex: Integer): TcxDataRecordHandle;
begin
  Result := Storage.FEventsList[ARecordIndex];
end;

function TcxSchedulerAggregateStorageDataSource.GetValue(
  ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant;
begin
  with TcxSchedulerAggregateStorageEvent(ARecordHandle).SourceEvent do
    Result := Values[Integer(AItemHandle)];
end;

function TcxSchedulerAggregateStorageDataSource.IsRecordIdSupported: Boolean;
begin
  Result := True;
end;

procedure TcxSchedulerAggregateStorageDataSource.SetValue(
  ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle; const AValue: Variant);
begin
  with TcxSchedulerAggregateStorageEvent(ARecordHandle).SourceEvent do
    Values[Integer(AItemHandle)] := AValue;
end;

{ TcxSchedulerAggregateStorage }

constructor TcxSchedulerAggregateStorage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLinks := TcxSchedulerStorageLinks.CreateEx(Self);
  FProvider := CreateDataProvider;
  DataController.CustomDataSource := FProvider;
end;

destructor TcxSchedulerAggregateStorage.Destroy;
begin
  FLinks.Free;
  DestroyDataProvider;
  inherited Destroy;
end;

procedure TcxSchedulerAggregateStorage.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerAggregateStorage then
    Links.Assign(TcxSchedulerAggregateStorage(Source).Links);
  inherited Assign(Source);
end;

procedure TcxSchedulerAggregateStorage.Clear;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Links.Count - 1 do
      if Links[I].Storage <> nil then
        Links[I].Storage.Clear;
  finally
    EndUpdate;
  end;
end;

function TcxSchedulerAggregateStorage.createEvent: TcxSchedulerEvent;
begin
  Result := inherited createEvent;
  Inc(FCounter);
  with TcxSchedulerAggregateStorageEvent(Result) do
  begin
    MappedID := FCounter;
    MappedParentID := -2;
  end;
end;

procedure TcxSchedulerAggregateStorage.GenerateHolidayEvents(const AResourceID: Variant);
var
  AHolidaysList: TList;
  I: Integer;
begin
  AHolidaysList := TList.Create;
  try
    Links.PopulateHolidays(AHolidaysList);
    for I := 0 to AHolidaysList.Count - 1 do
      GenerateHolidayEventsBySchedulerHolidays(AResourceID, TcxSchedulerHolidays(AHolidaysList[I]));
  finally
    AHolidaysList.Free;
  end;
end;

function TcxSchedulerAggregateStorage.GetHolidayNamesByDate(ADate: TDate; var ANames: string;
  AOnlyVisible: Boolean = True): Boolean;
var
  I: Integer;
  AHolidaysList: TList;
begin
  AHolidaysList := TList.Create;
  try
    Links.PopulateHolidays(AHolidaysList);
    for I := 0 to AHolidaysList.Count - 1 do
      TcxSchedulerHolidays(AHolidaysList.Items[I]).GetHolidayNamesByDate(ADate, ANames, AOnlyVisible);
  finally
    FreeAndNil(AHolidaysList);
    Result := ANames <> '';
  end;
end;

function TcxSchedulerAggregateStorage.IsActive: Boolean;
begin
  Result := (Links <> nil) and (Links.Count > 0) and (Links.DefaultStorage <> nil) and
    (Links.DefaultStorage.IsActive or Assigned(FOnEventInserting));
  if Result then
    Result := CanRefresh;
end;

procedure TcxSchedulerAggregateStorage.PopulateHolidayDates(AList: TcxSchedulerDateList;
  AStart, AFinish: TDate; AOnlyVisible: Boolean = True; AClearList: Boolean = True);

  procedure AddHolidays(AHolidays: TcxSchedulerHolidays);
  begin
    AHolidays.PopulateHolidayDates(AList, AStart, AFinish, AOnlyVisible, False);
  end;

var
  AHolidaysList: TList;
  I: Integer;
begin
  AHolidaysList := TList.Create;
  try
    Links.PopulateHolidays(AHolidaysList);
    if AClearList then
      AList.Clear;
    for I := 0 to AHolidaysList.Count - 1 do
      AddHolidays(AHolidaysList[I]);
  finally
    FreeAndNil(AHolidaysList);
  end;
end;

procedure TcxSchedulerAggregateStorage.DoDeleteEvent(const ARecordIndex: Integer);
begin
  if (ARecordIndex >= 0) and (ARecordIndex < EventCount) then
  begin
    if Events[ARecordIndex] = LastEditedEvent then
      FLastEditedEvent := nil;
    TcxSchedulerAggregateStorageEvent(Events[ARecordIndex]).SourceEvent.Delete;
  end;
end;

procedure TcxSchedulerAggregateStorage.DoEventInserting(AEvent: TcxSchedulerEvent;
  out AStorage: TcxCustomSchedulerStorage);
begin
  if (AEvent.EventType in [etCustom, etException]) and
    ((AEvent.Pattern <> nil) or (AEvent.ParentID >= 0)) then
  begin
    if AEvent.Pattern <> nil then
      AStorage := TcxSchedulerAggregateStorageEvent(AEvent.Pattern).SourceEvent.Storage
    else
      AStorage := TcxSchedulerAggregateStorageEvent(GetEventByID(AEvent.ParentID)).SourceEvent.Storage;
    Exit;
  end;
  AStorage := Links.DefaultStorage;
  if Assigned(FOnEventInserting) then
    FOnEventInserting(Self, AEvent, AStorage);
end;

function TcxSchedulerAggregateStorage.DoFilterEvent(AEvent: TcxSchedulerEvent): Boolean;
var
  AStorage: TcxCustomSchedulerStorageAccess;
begin
  if AEvent is TcxSchedulerAggregateStorageEvent then
  begin
    AStorage := TcxCustomSchedulerStorageAccess(TcxSchedulerAggregateStorageEvent(AEvent).SourceEvent.Storage);
    Result := AStorage.DoFilterEvent(TcxSchedulerAggregateStorageEvent(AEvent).SourceEvent);
  end
  else
    Result := True;
  if Assigned(OnFilterEvent) then
    OnFilterEvent(Self, AEvent, Result);
end;

procedure TcxSchedulerAggregateStorage.DoRefresh;
begin
  if CanRefresh then
    inherited DoRefresh;
end;

function TcxSchedulerAggregateStorage.CreateDataProvider: TcxSchedulerAggregateStorageDataSource;
begin
  Result := TcxSchedulerAggregateStorageDataSource.Create(Self);
end;

procedure TcxSchedulerAggregateStorage.DestroyDataProvider;
begin
  DataController.CustomDataSource := nil;
  FreeAndNil(FProvider);
end;

function TcxSchedulerAggregateStorage.GetEventClass:
  TcxSchedulerEventClass;
begin
  Result := TcxSchedulerAggregateStorageEvent;
end;

function TcxSchedulerAggregateStorage.GetMappedID(ASource: TcxSchedulerEvent): Integer;
var
  I: Integer;
begin
  Result := -2;
  if ASource = nil then Exit;
  for I := EventCount - 1 downto 0 do
    if FEventsList[I] <> nil then
      with TcxSchedulerAggregateStorageEvent(FEventsList[I]) do
        if SourceEvent = ASource then
        begin
          Result := MappedID;
          Break;
        end;
end;

function TcxSchedulerAggregateStorage.GetRecordID(
  const ARecordIndex: Integer): Variant;
begin
  Result := TcxSchedulerAggregateStorageEvent(Events[ARecordIndex]).MappedID;
end;

function TcxSchedulerAggregateStorage.InternalAddEvent(
  AEvent: TcxSchedulerEvent): TcxSchedulerAggregateStorageEvent;
begin
  Inc(FCounter);
  Result := GetEventClass.Create(Self, -1) as TcxSchedulerAggregateStorageEvent;
  Result.FSourceEvent := AEvent;
  Result.MappedID := FCounter;
  Result.SetRecordIndex(FEventsList.Add(Result));
  Result.MappedParentID := GetMappedID(AEvent.Pattern);
end;

function TcxSchedulerAggregateStorage.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TcxSchedulerAggregateStorage.IsDestroining: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

procedure TcxSchedulerAggregateStorage.PopulateEvents(var AList: TList);

  procedure PopulateStorageEvents(AStorage: TcxCustomSchedulerStorage);
  var
    AIndex: Integer;
  begin
    if AStorage = nil then Exit;
    for AIndex := 0 to AStorage.EventCount - 1 do
      AList.Add(AStorage.Events[AIndex]);
  end;

var
  ALinkIndex: Integer;
begin
  AList.Clear;
  if Links = nil then
    Exit;
  for ALinkIndex := 0 to Links.Count - 1 do
    PopulateStorageEvents(Links[ALinkIndex].Storage);
end;

procedure TcxSchedulerAggregateStorage.PostEditingData(
  AEvent: TcxSchedulerEvent);
var
  ASource: TcxSchedulerEvent;
begin
  ASource := TcxSchedulerAggregateStorageEvent(AEvent).SourceEvent;
  if (ASource <> nil) and (AEvent.RecordIndex >= 0) and
    not (ASource is TcxSchedulerAggregateStorageEvent) then
  begin
    if DoEventModified(AEvent) then Exit;
    ASource.BeginEditing;
    try
      ASource.Assign(AEvent);
    finally
      ASource.EndEditing;
    end;
  end
  else
    inherited;
end;

procedure TcxSchedulerAggregateStorage.PostEvent(AEvent: TcxSchedulerEvent);
var
  ASource: TcxSchedulerEvent;
  AStorage: TcxCustomSchedulerStorage;             
  APattern: TcxSchedulerEvent;
begin
  if TcxSchedulerAggregateStorageEvent(AEvent).IsNewEvent then
  begin
    BeginUpdate;
    try
      FNewEvents.Remove(AEvent);
      if not IsDestroying then
      begin
        APattern := nil;
        if AEvent.Pattern <> nil then
          APattern := AEvent.Pattern
        else
          if AEvent.ParentID >= 0 then
            APattern := GetEventByID(AEvent.ParentID);
        DoEventInserting(AEvent, AStorage);
        if AStorage <> nil then
        begin
          ASource := AStorage.createEvent;
          ASource.Assign(AEvent);
          if APattern <> nil then
          begin
            ASource.ParentID := TcxSchedulerAggregateStorageEvent(APattern).SourceEvent.ID;
            TcxSchedulerAggregateStorageEvent(ASource).FPattern := TcxSchedulerAggregateStorageEvent(APattern).SourceEvent;
            TcxSchedulerAggregateStorageEvent(AEvent).MappedParentID := APattern.ID;
          end;
          TcxSchedulerAggregateStorageEvent(AEvent).SetSourceEvent(ASource);
          AEvent.EndEditing;
          with TcxSchedulerAggregateStorageEvent(AEvent) do
            SetRecordIndex(FEventsList.Add(AEvent));
          ASource.Post;
        end
        else
          AEvent.Free;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxSchedulerAggregateStorage.SendNotification(AIsRemoved: Boolean = False);
begin
  if (AIsRemoved or IsDestroining or CanRefresh) and not FSynchronizing then
    inherited SendNotification(AIsRemoved);
end;

procedure TcxSchedulerAggregateStorage.SynchronizeEventsWithRecords;
var
  AEvents: TList;
  I, ADeletedCount: Integer;
  ASynchronizer: TcxSynchronizer;
begin
  if FSynchronizing then Exit;
  ADeletedCount := 0;
  AEvents := TList.Create;
  try
    PopulateEvents(AEvents);
    ASynchronizer := TcxSynchronizer.Create;
    try
      ASynchronizer.Capacity := AEvents.Count + EventCount;
      ASynchronizer.AddItems(FEventsList.List);
      ASynchronizer.AddSources(AEvents);
      ASynchronizer.Synchronize;
      for I := 0 to ASynchronizer.Count - 1 do
        with ASynchronizer.Items[I] do
        begin
          if IsUnique then
          begin
            if IsSource then
              InternalAddEvent(TcxSchedulerEvent(Source))
            else
            begin
              if FEventsList.List.List^[TcxSchedulerEvent(Link).RecordIndex] = FLastEditedEvent then
                FLastEditedEvent := nil;
              FEventsList.List.List^[TcxSchedulerEvent(Link).RecordIndex] := nil;
              TcxSchedulerAggregateStorageEvent(Link).FIsDeletion := True;
              Link.Free;
              Inc(ADeletedCount);
            end
          end
        end;
    finally
      ASynchronizer.Free;
    end;
  finally
    AEvents.Free;
  end;
  if ADeletedCount > 0 then
  begin
    FEventsList.Sort(@cxCompareEventsByIndex);
    FEventsList.List.Count := FEventsList.List.Count - ADeletedCount;
  end;
  for I := 0 to FEventsList.Count - 1 do
    with TcxSchedulerAggregateStorageEvent(FEventsList[I]) do
    begin
      SetRecordIndex(I);
      FPattern := nil;
      CheckParentID;
    end;
  Provider.LoadRecordHandles;
end;

procedure TcxSchedulerAggregateStorage.BeginUpdateDataController;
var
  ALinkIndex: Integer;
begin
  if Links = nil then Exit;
  for ALinkIndex := 0 to Links.Count - 1 do
    if (Links[ALinkIndex].Storage <> nil) then
      Links[ALinkIndex].Storage.BeginUpdate;
  inherited BeginUpdateDataController;
end;

procedure TcxSchedulerAggregateStorage.EndUpdateDataController;
var
  ALinkIndex: Integer;
begin
  if Links = nil then Exit;
  for ALinkIndex := 0 to Links.Count - 1 do
    if (Links[ALinkIndex].Storage <> nil) then
      Links[ALinkIndex].Storage.EndUpdate;
  inherited EndUpdateDataController;
end;

// IcxSchedulerStorageListener
procedure TcxSchedulerAggregateStorage.StorageChanged(Sender: TObject);
begin
  SynchronizeEventsWithRecords;
  FSynchronizing := True;
  try
    Provider.DataChanged;
  finally
    FSynchronizing := False;
    SendNotification();
  end;
end;

procedure TcxSchedulerAggregateStorage.StorageRemoved(Sender: TObject);
var
  AIndex: Integer;
begin
  TcxCustomSchedulerStorage(Sender).RemoveListener(Self);
  AIndex := Links.GetStorageLinkIndex(TcxCustomSchedulerStorage(Sender));
  if AIndex >= 0 then
  begin
    Links[AIndex].FStorage := nil;
    if Links.DefaultLink = Links[AIndex] then
      Links.DefaultLink := nil;
  end;
  if not IsDestroying then
    FullRefresh;
end;

function TcxSchedulerAggregateStorage.CanRefresh: Boolean;
var
  I: Integer;
begin
  Result := True;
  if Links <> nil then
    for I := 0 to Links.Count - 1 do
      if Links[I].Storage <> nil then
      begin
        Result := Result and (FieldCount = Links[I].Storage.FieldCount);
        if not Result then
          Break;
      end;
end;

function TcxSchedulerAggregateStorage.GetCustomFields: TcxSchedulerStorageFields;
begin
  Result := TcxSchedulerStorageFields(inherited CustomFields);
end;

procedure TcxSchedulerAggregateStorage.SetCustomFields(const AValue: TcxSchedulerStorageFields);
begin
  CustomFields.Assign(AValue);
end;

end.


