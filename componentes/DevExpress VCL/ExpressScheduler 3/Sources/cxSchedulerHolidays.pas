{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressDataController                                        }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSDATACONTROLLER AND ALL         }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxSchedulerHolidays;

{$I cxVer.inc}

interface

uses
  Messages, Windows, Variants, Classes, cxClasses, Controls, cxControls,
  cxDateUtils, cxSchedulerUtils, cxCustomData, SysUtils;

type

  { TcxSchedulerLocationHoliday }

  TcxSchedulerHolidaysLocations = class;
  TcxSchedulerHolidaysLocation = class;
  TcxSchedulerHolidaysLocationHoliday = class;

  TcxSchedulerHolidays = class;

  TcxSchedulerHolidaysLocationHoliday = class(TCollectionItem)
  private
    FDate: TDateTime;
    FName: string;
    FVisible: Boolean;
    function GetIsVisible: Boolean;
    function GetLocation: TcxSchedulerHolidaysLocation;
    procedure SetDate(const AValue: TDateTime);
    procedure SetName(const AValue: string);
    procedure SetVisible(AValue: Boolean);
  protected
    function GetDisplayText: string; virtual;
    function IsDateHoliday(const ADate: TDate; AOnlyVisible: Boolean): Boolean;
    function IsEqual(AHoliday: TcxSchedulerHolidaysLocationHoliday): Boolean;
    function IsHolidayInRange(const AStart, AFinish: TDate; AOnlyVisible: Boolean): Boolean;
    function ToString: string;{$IFDEF DELPHI12} reintroduce;{$ENDIF} virtual;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    property DisplayText: string read GetDisplayText;
    property IsVisible: Boolean read GetIsVisible;
    property Location: TcxSchedulerHolidaysLocation read GetLocation;
  published
    property Date: TDateTime read FDate write SetDate;
    property Name: string read FName write SetName;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  { TcxSchedulerHolidaysLocation }

  TcxSchedulerHolidaysLocation = class(TCollectionItem)
  private
    FHolidays: TCollection;
    FName: string;
    FVisible: Boolean;
    function GetCount: Integer;
    function GetHoliday(AIndex: Integer): TcxSchedulerHolidaysLocationHoliday;
    function GetLocations: TcxSchedulerHolidaysLocations;
    procedure SetHoliday(AIndex: Integer; AValue: TcxSchedulerHolidaysLocationHoliday);
    procedure SetName(const AValue: string);
    procedure SetVisible(AValue: Boolean);
    procedure ReadData(AReader: TReader); virtual;
    procedure WriteData(AWriter: TWriter); virtual;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function IsEqual(ALocation: TcxSchedulerHolidaysLocation): Boolean;
    function ToString: string;{$IFDEF DELPHI12} reintroduce;{$ENDIF} virtual;

    property HolidaysList: TCollection read FHolidays;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    function AddHoliday(const AName: string; const ADate: TDateTime): TcxSchedulerHolidaysLocationHoliday; overload; virtual;
    procedure Clear;
    procedure Delete(AIndex: Integer);
    function PopulateHolidayDates(const AName: string; var AList: TcxSchedulerDateList): Boolean;
    function Find(const AName: string; const ADate: TDateTime): TcxSchedulerHolidaysLocationHoliday; overload; virtual;
    procedure Sort(ASortOrder: TcxDataSortOrder; ASortByDate: Boolean);

    property Count: Integer read GetCount;
    property Holidays[AIndex: Integer]: TcxSchedulerHolidaysLocationHoliday read GetHoliday write SetHoliday; default;
    property Locations: TcxSchedulerHolidaysLocations read GetLocations;
  published
    property Name: string read FName write SetName;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

  { TcxSchedulerHolidaysLocations }

  TcxSchedulerHolidaysLocations = class(TCollection)
  private
    FOwner: TcxSchedulerHolidays;
    function GetItem(AIndex: Integer): TcxSchedulerHolidaysLocation;
    function GetOwnerHolidays: TcxSchedulerHolidays;
    procedure SetItem(AIndex: Integer; AValue: TcxSchedulerHolidaysLocation);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TcxSchedulerHolidays); reintroduce; overload;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    function Add(const AName: string): TcxSchedulerHolidaysLocation;
    function GetLocationByName(const AName: string): TcxSchedulerHolidaysLocation;
    procedure Sort(ASortOrder: TcxDataSortOrder);

    property Items[AIndex: Integer]: TcxSchedulerHolidaysLocation read GetItem write SetItem; default;
    property OwnerHolidays: TcxSchedulerHolidays read GetOwnerHolidays;
  end;

  { IcxSchedulerHolidaysListener }

  IcxSchedulerHolidaysListener = interface
  ['{0FE58B1C-71C0-4ED0-9A10-12074CE13EA3}']
    procedure HolidaysChanged(Sender: TObject);
    procedure HolidaysRemoved(Sender: TObject);
  end;

  { TcxSchedulerHolidays }

  TcxSchedulerHolidaysImportExportHolidayEvent = procedure (ASender: TcxSchedulerHolidays;
    AHoliday: TcxSchedulerHolidaysLocationHoliday; var Accept: Boolean) of object;
  TcxSchedulerHolidaysImportUnknownDateEvent = procedure (ASender: TcxSchedulerHolidays;
    var AYear, AMonth, ADay: Word; const ATypeCalendar: Word; var Accept: Boolean) of object;

  TcxSchedulerHolidays = class(TComponent)
  private
    FLocations: TcxSchedulerHolidaysLocations;
    FLockCount: Integer;
    FListeners: TInterfaceList;
    FOnExportHoliday: TcxSchedulerHolidaysImportExportHolidayEvent;
    FOnImportHoliday: TcxSchedulerHolidaysImportExportHolidayEvent;
    FOnImportUnknownDate: TcxSchedulerHolidaysImportUnknownDateEvent;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TcxSchedulerHolidaysLocationHoliday;
    function GetIsDestroying: Boolean;
    function GetIsLoading: Boolean;
    function GetIsUpdatingMode: Boolean;
    procedure GetHolidaysIndex(AIndex: Integer; out ALocationIndex, AHolidayIndex: Integer);
    function GetStringPart(const S: string; var APos: Integer; ACheckDateSeparator: Boolean = True): string;
    procedure SetLocations(const AValue: TcxSchedulerHolidaysLocations);
  protected
    procedure Changed; virtual;
    function CheckStreamFormat(AStream: TStream): Boolean; virtual;
    function DoExportHoliday(AHoliday: TcxSchedulerHolidaysLocationHoliday): Boolean; virtual;
    function DoImportHoliday(AHoliday: TcxSchedulerHolidaysLocationHoliday): Boolean; virtual;
    function DoImportUnknownDate(var AYear, AMonth, ADay: Word;
      const ATypeCalendar: Word): Boolean; virtual;
    procedure SendNotification(AIsRemoved: Boolean = False); virtual;
    function TryCreateFromStream(AStream: TStream;
      out ALocations: TcxSchedulerHolidaysLocations): Boolean; virtual;
    function TryStringToHoliday(const S: string; ALocation: TcxSchedulerHolidaysLocation): Boolean;
    function TryStringToLocation(const S: string; ALocations: TcxSchedulerHolidaysLocations): Boolean;
    function TryStrToIntW(const S: string; out AValue: Word): Boolean;

    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property IsUpdatingMode: Boolean read GetIsUpdatingMode;
    property Listeners: TInterfaceList read FListeners;
    property LockCount: Integer read FLockCount write FLockCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AddHoliday(const ALocationName, AHolidayName: string; const ADate: TDateTime): TcxSchedulerHolidaysLocationHoliday;
    procedure AddListener(AListener: IcxSchedulerHolidaysListener);
    function AddLocation(const AName: string): TcxSchedulerHolidaysLocation; overload; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure Clear; virtual;
    procedure EndUpdate;
    function GetHolidayNamesByDate(const ADate: TDate;
      var ANames: string; AOnlyVisible: Boolean = True): Boolean; virtual;
    procedure LoadFromFile(const AFileName: string); virtual;
    procedure LoadFromStream(AStream: TStream); virtual;
    procedure PopulateHolidayDates(AList: TcxSchedulerDateList; const AStart, AFinish: TDate;
      AOnlyVisible: Boolean = True; AClearList: Boolean = True); virtual;
    procedure RemoveListener(AListener: IcxSchedulerHolidaysListener);
    procedure SaveToFile(const AFileName: string); virtual;
    procedure SaveToStream(var AStream: TStream); virtual;

    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TcxSchedulerHolidaysLocationHoliday read GetItem; default;
  published
    property Locations: TcxSchedulerHolidaysLocations read
      FLocations write SetLocations;
    property OnExportHoliday: TcxSchedulerHolidaysImportExportHolidayEvent
      read FOnExportHoliday write FOnExportHoliday;
    property OnImportHoliday: TcxSchedulerHolidaysImportExportHolidayEvent
      read FOnImportHoliday write FOnImportHoliday;
    property OnImportUnknownDate: TcxSchedulerHolidaysImportUnknownDateEvent
      read FOnImportUnknownDate write FOnImportUnknownDate;
  end;

implementation

uses
  DateUtils, cxSchedulerStrs, dxCore;

type
  TcxSchedulerHolidaysCollection = class(TCollection)
  private
    FOwner: TPersistent;
  protected
    function GetOwner: TPersistent; override; 
  public
    procedure Assign(Source: TPersistent); override;
  end;

const
  CRLF = #13#10;
  cxDateSeparator = '/';

  cxStartLocationName = '[';
  cxStopLocationName = ']';
  cxDateFormat = 'yyyy/MM/dd';

  cxSeparatorHolidayPart = ',';
  cxHolidaysFormat: TFormatSettings = (DateSeparator: cxDateSeparator; ShortDateFormat: 'yyyy/MM/dd');

{ TcxSchedulerHolidaysCollection }

procedure TcxSchedulerHolidaysCollection.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerHolidaysCollection then
    with TcxSchedulerHolidaysCollection(Source) do
    begin
      Self.BeginUpdate;
      try
        Self.Clear;
        for I := 0 to Count - 1 do
          Self.Add.Assign(Items[I]);
      finally
        Self.EndUpdate;
      end;
    end
  else
    inherited Assign(Source);
end;

function TcxSchedulerHolidaysCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function cxCompareHolidays(
  AItem1, AItem2: TcxSchedulerHolidaysLocationHoliday): Integer;
begin
  Result := AnsiCompareText(AItem1.Name, AItem2.Name)
end;

function cxCompareHolidaysByDate(
  AItem1, AItem2: TcxSchedulerHolidaysLocationHoliday): Integer;
begin
  Result := 0;
  if AItem1.Date <> AItem2.Date then
  begin
    if AItem1.Date - AItem2.Date > 0 then
      Result := 1
    else
      Result := -1;
  end;
end;

function cxCompareLocations(
  AItem1, AItem2: TcxSchedulerHolidaysLocation): Integer;
begin
  Result := AnsiCompareText(AItem1.Name, AItem2.Name);
end;

procedure SortCollection(ACollection: TCollection;
  ACompare: TListSortCompare; AIsAscending: Boolean);
var
  I, J, C: Integer;
begin
  for I := 0 to ACollection.Count - 1 do
    for J := I + 1 to ACollection.Count - 1 do
    begin
      C := ACompare(ACollection.Items[I], ACollection.Items[J]);
      if not AIsAscending then
        C := -C;
      if C > 0 then
        ACollection.Items[J].Index := I;
    end;
end;

{ TcxSchedulerHolidaysLocationHoliday }

constructor TcxSchedulerHolidaysLocationHoliday.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FVisible := True;
end;

procedure TcxSchedulerHolidaysLocationHoliday.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerHolidaysLocationHoliday then
    with Source as TcxSchedulerHolidaysLocationHoliday do
    begin
      Self.Date := Date;
      Self.Name := Name;
      Self.Visible := Visible;
      Self.Changed(True);
    end
  else
    inherited Assign(Source);
end;

function TcxSchedulerHolidaysLocationHoliday.GetDisplayText: string;
begin
  Result := Name;
  if Location <> nil then
    Result := Result + ' (' + Location.Name + ')';
end;

function TcxSchedulerHolidaysLocationHoliday.IsDateHoliday(
  const ADate: TDate; AOnlyVisible: Boolean): Boolean;
begin
  Result := (not AOnlyVisible or IsVisible) and (ADate = Date) and (Name <> '');  
end;

function TcxSchedulerHolidaysLocationHoliday.IsEqual(
  AHoliday: TcxSchedulerHolidaysLocationHoliday): Boolean;
begin
  Result := (AHoliday.FDate = FDate) and (AHoliday.FVisible = FVisible) and
    (AHoliday.FName = FName);
end;

function TcxSchedulerHolidaysLocationHoliday.IsHolidayInRange(
  const AStart, AFinish: TDate; AOnlyVisible: Boolean): Boolean;
begin
  Result := (not AOnlyVisible or IsVisible) and
    (Date >= AStart) and (Date <= AFinish);
end;

function TcxSchedulerHolidaysLocationHoliday.ToString: string;
begin
  Result := Name + ',' + cxDateToStr(Date, cxHolidaysFormat);
end;

function TcxSchedulerHolidaysLocationHoliday.GetIsVisible: Boolean;
begin
  Result := Visible;
  if Location <> nil then
    Result := Result and Location.Visible;
end;

function TcxSchedulerHolidaysLocationHoliday.GetLocation: TcxSchedulerHolidaysLocation;
begin
  Result := TcxSchedulerHolidaysLocation(Collection.Owner);
end;

procedure TcxSchedulerHolidaysLocationHoliday.SetDate(const AValue: TDateTime);
begin
  if AValue <> FDate then
  begin
    FDate := AValue;
    Changed(True);
  end;
end;

procedure TcxSchedulerHolidaysLocationHoliday.SetName(const AValue: string);
begin
  if AValue <> FName then
  begin
    FName := AValue;
    Changed(True);
  end;
end;

procedure TcxSchedulerHolidaysLocationHoliday.SetVisible(AValue: Boolean);
begin
  if AValue <> FVisible then
  begin
    FVisible := AValue;
    Changed(True);
  end;
end;

{ TcxSchedulerHolidaysLocation }

constructor TcxSchedulerHolidaysLocation.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FHolidays := TcxSchedulerHolidaysCollection.Create(TcxSchedulerHolidaysLocationHoliday);
  TcxSchedulerHolidaysCollection(FHolidays).FOwner := Self;
  FVisible := False; 
end;

destructor TcxSchedulerHolidaysLocation.Destroy;
begin
  FHolidays.Free;
  inherited Destroy;
end;

procedure TcxSchedulerHolidaysLocation.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerHolidaysLocation then
    with Source as TcxSchedulerHolidaysLocation do
    begin
      Self.Name := Name;
      Self.Visible := Visible;
      Self.HolidaysList.Assign(HolidaysList);
      Self.Changed(True);
    end
  else
    inherited Assign(Source);
end;

function TcxSchedulerHolidaysLocation.AddHoliday(const AName: string;
  const ADate: TDateTime): TcxSchedulerHolidaysLocationHoliday;
begin
  Result := HolidaysList.Add as TcxSchedulerHolidaysLocationHoliday;
  Result.Name := AName;
  Result.Date := ADate;
end;

procedure TcxSchedulerHolidaysLocation.Clear;
begin
  FHolidays.Clear;
  Changed(True);
end;

procedure TcxSchedulerHolidaysLocation.Delete(AIndex: Integer);
begin
  FHolidays.Items[AIndex].Free;
end;

function TcxSchedulerHolidaysLocation.PopulateHolidayDates(
  const AName: string; var AList: TcxSchedulerDateList): Boolean;
var
  I: Integer;
begin
  AList.Clear;
  for I := 0 to Count - 1 do
    if AnsiCompareText(AName, Holidays[I].Name) = 0 then
      AList.Add(Holidays[I].Date);
  Result := AList.Count > 0;
end;

function TcxSchedulerHolidaysLocation.Find(
  const AName: string; const ADate: TDateTime): TcxSchedulerHolidaysLocationHoliday;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Holidays[I];
    if (AnsiCompareText(Result.Name, AName) = 0) and (Result.Date = ADate) then
      Exit;
  end;
  Result := nil;
end;

procedure TcxSchedulerHolidaysLocation.Sort(
  ASortOrder: TcxDataSortOrder; ASortByDate: Boolean);
begin
  if ASortOrder <> soNone then
  begin
    if not ASortByDate then
      SortCollection(HolidaysList, @cxCompareHolidays, ASortOrder = soAscending)
    else
      SortCollection(HolidaysList, @cxCompareHolidaysByDate, ASortOrder = soAscending);
  end;
end;

procedure TcxSchedulerHolidaysLocation.DefineProperties(Filer: TFiler);

  function HasData: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not TcxSchedulerHolidaysLocation(Filer.Ancestor).IsEqual(Self)
    else
      Result := Count > 0;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Holidays', ReadData, WriteData, HasData);
  if (FHolidays.Count = 0) and (Filer.Ancestor <> nil) then
    Assign(TcxSchedulerHolidaysLocation(Filer.Ancestor))
end;

function TcxSchedulerHolidaysLocation.IsEqual(
  ALocation: TcxSchedulerHolidaysLocation): Boolean;
var
  I: Integer;
begin
  Result := Count = ALocation.Count;
  if not Result then Exit;
  for I := 0 to Count - 1 do
  begin
    Result := Holidays[I].IsEqual(ALocation.Holidays[I]);
    if not Result then Break;
  end;
end;

function TcxSchedulerHolidaysLocation.ToString: string;
begin
  Result := cxStartLocationName + Name + cxStopLocationName;
end;

function TcxSchedulerHolidaysLocation.GetCount: Integer;
begin
  Result := FHolidays.Count;
end;

function TcxSchedulerHolidaysLocation.GetHoliday(
  AIndex: Integer): TcxSchedulerHolidaysLocationHoliday;
begin
  Result := TcxSchedulerHolidaysLocationHoliday(FHolidays.Items[AIndex]);
end;

function TcxSchedulerHolidaysLocation.GetLocations: TcxSchedulerHolidaysLocations;
begin
  Result := TcxSchedulerHolidaysLocations(Collection);
end;

procedure TcxSchedulerHolidaysLocation.SetHoliday(AIndex: Integer;
  AValue: TcxSchedulerHolidaysLocationHoliday);
begin
  TcxSchedulerHolidaysLocationHoliday(FHolidays.Items[AIndex]).Assign(AValue);
end;

procedure TcxSchedulerHolidaysLocation.SetName(const AValue: string);
begin
  if FName <> AValue then
  begin
    FName := AValue;
    Changed(True);
  end;
end;

procedure TcxSchedulerHolidaysLocation.SetVisible(AValue: Boolean);
begin
  if FVisible <> AValue then
  begin
    FVisible := AValue;
    Changed(True);
  end;
end;

procedure TcxSchedulerHolidaysLocation.ReadData(AReader: TReader);
begin
  if AReader.NextValue = vaCollection then
  begin
    FHolidays.Clear;
    AReader.ReadValue;
    AReader.ReadCollection(FHolidays);
  end;
end;

procedure TcxSchedulerHolidaysLocation.WriteData(AWriter: TWriter);
begin
  AWriter.WriteCollection(FHolidays);
end;

{ TcxSchedulerHolidaysLocations }

constructor TcxSchedulerHolidaysLocations.Create(AOwner: TcxSchedulerHolidays);
begin
  inherited Create(TcxSchedulerHolidaysLocation);
  FOwner := AOwner;
end;

destructor TcxSchedulerHolidaysLocations.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TcxSchedulerHolidaysLocations.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerHolidaysLocations then
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to TcxSchedulerHolidaysLocations(Source).Count - 1 do
        Add(TcxSchedulerHolidaysLocations(Source).Items[I].Name).Assign(
          TcxSchedulerHolidaysLocations(Source).Items[I]);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TcxSchedulerHolidaysLocations.Add(
  const AName: string): TcxSchedulerHolidaysLocation;
begin
  Result := TcxSchedulerHolidaysLocation.Create(Self);
  Result.Name := AName;
end;

function TcxSchedulerHolidaysLocations.GetLocationByName(
  const AName: string): TcxSchedulerHolidaysLocation;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if AnsiCompareText(Result.Name, AName) = 0 then
      Exit;
  end;
  Result := nil;
end;

procedure TcxSchedulerHolidaysLocations.Sort(ASortOrder: TcxDataSortOrder);
begin
  SortCollection(Self, @cxCompareLocations, ASortOrder = soAscending);
end;

function TcxSchedulerHolidaysLocations.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxSchedulerHolidaysLocations.Update(Item: TCollectionItem);
begin
  if (OwnerHolidays <> nil) then
    OwnerHolidays.Changed;
end;

function TcxSchedulerHolidaysLocations.GetItem(
  AIndex: Integer): TcxSchedulerHolidaysLocation;
begin
  Result := TcxSchedulerHolidaysLocation(inherited Items[AIndex]);
end;

function TcxSchedulerHolidaysLocations.GetOwnerHolidays: TcxSchedulerHolidays;
begin
  Result := TcxSchedulerHolidays(GetOwner);
end;

procedure TcxSchedulerHolidaysLocations.SetItem(AIndex: Integer;
  AValue: TcxSchedulerHolidaysLocation);
begin
  Items[AIndex].Assign(AValue);
end;

{ TcxSchedulerHolidays }

constructor TcxSchedulerHolidays.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLocations := TcxSchedulerHolidaysLocations.Create(Self);
  FListeners := TInterfaceList.Create();
end;

destructor TcxSchedulerHolidays.Destroy;
begin
  SendNotification(True);
  FreeAndNil(FLocations);
  FListeners.Free;
  inherited Destroy;
end;

procedure TcxSchedulerHolidays.Changed;
begin
  if LockCount = 0 then
    SendNotification();
end;

function TcxSchedulerHolidays.CheckStreamFormat(AStream: TStream): Boolean;
var
  S: Word;
  APos: Integer;
begin
  Result := AStream.Size > SizeOf(dxUnicodePrefix);
  APos := AStream.Position;
  if Result then
  begin
    AStream.Read(S, SizeOf(Word));
    Result := S = dxUnicodePrefix;
  end;
  if not Result then
    AStream.Position := APos;
end;

function TcxSchedulerHolidays.DoExportHoliday(
  AHoliday: TcxSchedulerHolidaysLocationHoliday): Boolean;
begin
  Result := True;
  if Assigned(FOnExportHoliday) then
    FOnExportHoliday(Self, AHoliday, Result);
end;

function TcxSchedulerHolidays.DoImportHoliday(
  AHoliday: TcxSchedulerHolidaysLocationHoliday): Boolean;
begin
  Result := True;
  if Assigned(FOnImportHoliday) then
    FOnImportHoliday(Self, AHoliday, Result);
end;

function TcxSchedulerHolidays.DoImportUnknownDate(var AYear, AMonth, ADay: Word;
  const ATypeCalendar: Word): Boolean;
begin
  Result := False;
  if Assigned(FOnImportUnknownDate) then
    FOnImportUnknownDate(Self, AYear, AMonth, ADay, ATypeCalendar, Result);
end;

function TcxSchedulerHolidays.AddHoliday(const ALocationName,
  AHolidayName: string; const ADate: TDateTime): TcxSchedulerHolidaysLocationHoliday;
var
  ALocation: TcxSchedulerHolidaysLocation;
begin
  Result := nil;
  ALocation := Locations.GetLocationByName(ALocationName);
  if  ALocation <> nil then
    Result := ALocation.AddHoliday(AHolidayName, ADate);
end;

procedure TcxSchedulerHolidays.AddListener(AListener: IcxSchedulerHolidaysListener);
begin
  if FListeners.IndexOf(AListener) = -1 then
    FListeners.Add(AListener);
end;

function TcxSchedulerHolidays.AddLocation(
  const AName: string): TcxSchedulerHolidaysLocation;
begin
  Result := FLocations.Add(AName);
end;

procedure TcxSchedulerHolidays.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerHolidays then
    with Source as TcxSchedulerHolidays do
    begin
      Self.BeginUpdate;
      try
        Self.Clear;
        Self.Locations := Locations;
      finally
        Self.EndUpdate;
      end;
    end
  else
    inherited Assign(Source);
end;

procedure TcxSchedulerHolidays.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxSchedulerHolidays.Clear;
begin
  FLocations.Clear;
end;

procedure TcxSchedulerHolidays.EndUpdate;
begin
  Dec(FLockCount);
  Changed;
end;

function TcxSchedulerHolidays.GetHolidayNamesByDate(const ADate: TDate;
  var ANames: string; AOnlyVisible: Boolean = True): Boolean;
var
  I, J: Integer;
  ALocation: TcxSchedulerHolidaysLocation;
begin
  for I := 0 to Locations.Count - 1 do
  begin
    ALocation := Locations[I];
    if AOnlyVisible and not Locations[I].Visible then Continue;
    for J := 0 to ALocation.Count - 1 do
    begin
      if ALocation[J].IsDateHoliday(ADate, AOnlyVisible) then
      begin
        if Length(ANames) > 0 then
          ANames := ANames + CRLF;
        ANames := ANames + ALocation[J].DisplayText;
      end;
    end;
  end;
  Result := ANames <> '';
end;

procedure TcxSchedulerHolidays.LoadFromFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(AStream);
  finally
    FreeAndNil(AStream);
  end;
end;

procedure TcxSchedulerHolidays.LoadFromStream(AStream: TStream);
var
  ALocations: TcxSchedulerHolidaysLocations;
begin
  if CheckStreamFormat(AStream) and TryCreateFromStream(AStream, ALocations) then
  try
    ShowHourglassCursor;
    try
      BeginUpdate;
      try
        Clear;
        Locations := ALocations;
      finally
        EndUpdate;
      end
    finally
      HideHourglassCursor;
    end;
  finally
    ALocations.Free;
  end
  else
    cxSchedulerError(cxGetResourceString(@scxOutlookFormatMismatch));
end;

procedure TcxSchedulerHolidays.PopulateHolidayDates(AList: TcxSchedulerDateList;
  const AStart, AFinish: TDate; AOnlyVisible: Boolean = True; AClearList: Boolean = True);
var
  I, J: Integer;
  ALocation: TcxSchedulerHolidaysLocation;
begin
  if AClearList then
    AList.Clear;
  for I := 0 to Locations.Count - 1 do
  begin
    ALocation := Locations[I];
    if not ALocation.Visible and AOnlyVisible then Continue;
    for J := 0 to ALocation.Count - 1 do
      if ALocation.Holidays[J].IsHolidayInRange(AStart, AFinish, AOnlyVisible) then
        AList.Add(ALocation.Holidays[J].Date);
  end;
end;

procedure TcxSchedulerHolidays.RemoveListener(AListener: IcxSchedulerHolidaysListener);
begin
  FListeners.Remove(AListener);
end;

procedure TcxSchedulerHolidays.SaveToFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate or fmOpenWrite);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TcxSchedulerHolidays.SaveToStream(var AStream: TStream);
var
  I, J: Integer;
  ALocation: TcxSchedulerHolidaysLocation;
  AExportList: TStringList;
  ADataAsString: Widestring;
begin
  for I := 0 to Locations.Count - 1 do
  begin
    ALocation := Locations[I];
    AExportList := TStringList.Create;
    try
      for J := 0 to ALocation.Count - 1 do
        if DoExportHoliday(ALocation.Holidays[J]) then
          AExportList.Add(ALocation.Holidays[J].ToString);
      if AExportList.Count > 0 then
        ADataAsString := ADataAsString + ALocation.ToString + ' ' +
          IntToStr(AExportList.Count) + CRLF + AExportList.Text;
    finally
      AExportList.Free
    end;
  end;
  if Length(ADataAsString) > 0 then
  begin
    AStream.WriteBuffer(dxUnicodePrefix, SizeOf(dxUnicodePrefix));
    AStream.Write(ADataAsString[1], Length(ADataAsString) * 2);
  end;
end;

procedure TcxSchedulerHolidays.SendNotification(AIsRemoved: Boolean = False);
var
  I: Integer;
  AIntf: IcxSchedulerHolidaysListener;
begin
  for I := Listeners.Count - 1 downto 0 do
    if Supports(Listeners[I], IcxSchedulerHolidaysListener, AIntf) then
    begin
      if AIsRemoved then
        AIntf.HolidaysRemoved(Self)
      else
        if not IsUpdatingMode then
          AIntf.HolidaysChanged(Self);
    end;
end;

function TcxSchedulerHolidays.TryCreateFromStream(AStream: TStream;
  out ALocations: TcxSchedulerHolidaysLocations): Boolean;
var
  I: Integer;
  ADataAsText: WideString;
  AHolidaysList: TStringList;
begin
  Result := True;
  ALocations := TcxSchedulerHolidaysLocations.Create(nil);
  try
    SetLength(ADataAsText, (AStream.Size - AStream.Position) div 2);
    AStream.Read(ADataAsText[1], AStream.Size - AStream.Position);
    AHolidaysList := TStringList.Create;
    try
      AHolidaysList.Text := ADataAsText;
      for I := 0 to AHolidaysList.Count - 1 do
        if TryStringToLocation(AHolidaysList[I], ALocations) or ((ALocations.Count > 0) and
          TryStringToHoliday(AHolidaysList[I], ALocations[ALocations.Count - 1])) then
        else
          Result := False;
    finally
      AHolidaysList.Free;
    end;
  except
    ALocations.Free;
    raise;
  end;
end;

function TcxSchedulerHolidays.TryStringToHoliday(
  const S: string; ALocation: TcxSchedulerHolidaysLocation): Boolean;
var
  ADate: TDate;
  APart, AName: string;
  AYear, AMonth, ADay: Word;
  ACalendar, ACurPos: Integer;
  AHoliday: TcxSchedulerHolidaysLocationHoliday;
begin
  Result := (ALocation <> nil) and (S <> '');
  if not Result then
  begin
    Result := True;
    Exit;
  end;
  ADate := NullDate;
  ACalendar := CAL_GREGORIAN;
  ACurPos := Length(S);
  APart := GetStringPart(S, ACurPos, False);
  if Pos(cxDateSeparator, APart) <= 0 then
  begin
    Result := Result and TryStrToInt(APart, ACalendar);
    APart := GetStringPart(S, ACurPos, False);
  end;
  AName := GetStringPart(S, ACurPos, False);
  if ACalendar in [CAL_GREGORIAN, CAL_HIJRI, CAL_HEBREW] then
    ADate := cxStrToDate(APart, cxHolidaysFormat, ACalendar)
  else
  begin
    ACurPos := Length(APart);
    if not TryStrToIntW(GetStringPart(APart, ACurPos), ADay) or
      not TryStrToIntW(GetStringPart(APart, ACurPos), AMonth) or
      not TryStrToIntW(GetStringPart(APart, ACurPos), AYear) then
        cxSchedulerError(cxGetResourceString(@scxOutlookFormatMismatch))
    else
    begin
      if DoImportUnknownDate(AYear, AMonth, ADay, ACalendar) then
        ADate := EncodeDate(AYear, AMonth, ADay)
    end;
  end;
  if Result then
  begin
    AHoliday := ALocation.AddHoliday(AName, ADate);
    if not DoImportHoliday(AHoliday) then
       AHoliday.Free;
  end;
end;

function TcxSchedulerHolidays.TryStringToLocation(
  const S: string; ALocations: TcxSchedulerHolidaysLocations): Boolean;
var
  AStartPos, AEndPos: Integer;
begin
  AStartPos := Pos(cxStartLocationName, S);
  AEndPos := Pos(cxStopLocationName, S);
  Result := (ALocations <> nil) and (AStartPos > 0) and (AEndPos > AStartPos);
  if Result then
    Result := ALocations.Add(Copy(S, AStartPos + 1, AEndPos - AStartPos - 1)) <> nil;
end;

function TcxSchedulerHolidays.TryStrToIntW(const S: string; out AValue: Word): Boolean;
var
  I: Integer;
begin
  Result := TryStrToInt(S, I);
  AValue := I;
end;

function TcxSchedulerHolidays.GetCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Locations.Count - 1 do
    Inc(Result, Locations[I].Count);
end;

function TcxSchedulerHolidays.GetItem(AIndex: Integer): TcxSchedulerHolidaysLocationHoliday;
var
  I, J: Integer;
begin
  GetHolidaysIndex(AIndex, I, J);
  Result := Locations[I].Holidays[J];
end;

function TcxSchedulerHolidays.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxSchedulerHolidays.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TcxSchedulerHolidays.GetIsUpdatingMode: Boolean;
begin
  Result := IsDestroying or IsLoading or (LockCount > 0);
end;

procedure TcxSchedulerHolidays.GetHolidaysIndex(AIndex: Integer;
  out ALocationIndex, AHolidayIndex: Integer);
var
  I: Integer;
  ACount: Integer;
begin
  ACount := 0;
  for I := 0 to Locations.Count - 1 do
  begin
    if AIndex < (ACount + Locations[I].Count) then
    begin
      ALocationIndex := I;
      AHolidayIndex := AIndex - ACount;
      Break;
    end
    else
      Inc(ACount, Locations[I].Count);
  end;
end;

function TcxSchedulerHolidays.GetStringPart(const S: string;
  var APos: Integer; ACheckDateSeparator: Boolean = True): string;
var
  L: Integer;
  ASeparators: TdxAnsiCharSet;
begin
  Result := '';
  if ACheckDateSeparator then
    ASeparators := [cxDateSeparator, cxSeparatorHolidayPart]
  else
    ASeparators := [cxSeparatorHolidayPart];
  if (APos > Length(S)) or (APos <= 0) then Exit;  
  while (APos > 0) and dxCharInSet(S[APos], ASeparators) or (S[APos] = ' ') do Dec(APos);
  L := APos;
  while (APos > 0) and not dxCharInSet(S[APos], ASeparators) do Dec(APos);
  if APos < L then
  begin
    Result := Copy(S, APos + 1, L - APos);
    Dec(APos);
  end; 
end;

procedure TcxSchedulerHolidays.SetLocations(
  const AValue: TcxSchedulerHolidaysLocations);
begin
  BeginUpdate;
  try
    FLocations.Assign(AValue);
  finally
    EndUpdate;
  end;
end;

end.
