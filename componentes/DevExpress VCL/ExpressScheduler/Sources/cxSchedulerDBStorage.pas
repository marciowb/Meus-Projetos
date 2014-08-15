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

unit cxSchedulerDBStorage;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, Graphics, DB, cxDB, cxDBData, cxSchedulerStorage,
  cxCustomData, cxDataUtils;

type
  TcxSchedulerDBStorage = class;
  TcxFieldName = type string;

  { TcxSchedulerDBStorageDataController }

  TcxSchedulerDBStorageDataController = class(TcxDBDataController)
  private
    function GetStorage: TcxSchedulerDBStorage;
  protected
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;
    property Storage: TcxSchedulerDBStorage read GetStorage;
  public
    function GetItem(Index: Integer): TObject; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    function GetItemID(AItem: TObject): Integer; override;
    procedure UpdateData; override;
    procedure UpdateItemIndexes; override;
  end;

  { TcxSchedulerDBStorageField }

  TcxSchedulerDBStorageField = class(TcxCustomSchedulerStorageField)
  private
    function GetDataController: TcxSchedulerDBStorageDataController;
    function GetDataSource: TDataSource;
    function GetFieldName: string;
    procedure SetFieldName(const AValue: string);
  protected
    function GetDisplayName: string; override;
    
    property DataController: TcxSchedulerDBStorageDataController read GetDataController;
  public
    property DataSource: TDataSource read GetDataSource;
  published
    property FieldName: string read GetFieldName write SetFieldName;
  end;

  { TcxSchedulerDBStorageFields }

  TcxSchedulerDBStorageFields = class(TcxCustomSchedulerStorageFields)
  private
    function GetItem(AIndex: Integer): TcxSchedulerDBStorageField;
    procedure SetItem(AIndex: Integer; const AValue: TcxSchedulerDBStorageField);
  protected
    function FindFieldByName(const AName: string): TcxCustomSchedulerStorageField; override;
  public
    function Add: TcxSchedulerDBStorageField;
    function ItemByFieldName(const AFieldName: string): TcxSchedulerDBStorageField;

    property Items[Index: Integer]: TcxSchedulerDBStorageField read GetItem write SetItem;
  end;

  { TcxSchedulerDBStorageFieldNames }

  TcxSchedulerDBStorageFieldNames = class(TPersistent)
  private
    FOwner: TcxSchedulerDBStorage;
    function GetDataController: TcxSchedulerDBStorageDataController;
    function GetKeyFieldName: TcxFieldName;
    procedure SetKeyFieldName(const AValue: TcxFieldName);
  protected
    function GetFieldName(AIndex: Integer): TcxFieldName;
    function GetOwner: TPersistent; override;
    procedure SetFieldName(AIndex: Integer; const AValue: TcxFieldName);
    property ReminderTime: TcxFieldName index 10 read GetFieldName write SetFieldName;
  public
    constructor Create(AOwner: TcxSchedulerDBStorage); virtual;
    procedure Assign(Source: TPersistent); override;
    property Storage: TcxSchedulerDBStorage read FOwner;
    property DataController: TcxSchedulerDBStorageDataController read GetDataController;
  published
    property Caption: TcxFieldName index 0 read GetFieldName write SetFieldName;
    property EventType: TcxFieldName index 1 read GetFieldName write SetFieldName;
    property Finish: TcxFieldName index 2 read GetFieldName write SetFieldName;
    property ID: TcxFieldName read GetKeyFieldName write SetKeyFieldName;
    property LabelColor: TcxFieldName index 3 read GetFieldName write SetFieldName;
    property Location: TcxFieldName index 4 read GetFieldName write SetFieldName;
    property Message: TcxFieldName index 5 read GetFieldName write SetFieldName;
    property Options: TcxFieldName index 6 read GetFieldName write SetFieldName;
    property ParentID: TcxFieldName index 7 read GetFieldName write SetFieldName;
    property RecurrenceIndex: TcxFieldName index 8 read GetFieldName write SetFieldName;
    property RecurrenceInfo: TcxFieldName index 9 read GetFieldName write SetFieldName;
    property ResourceID: TcxFieldName index 11 read GetFieldName write SetFieldName;
    property Start: TcxFieldName index 12 read GetFieldName write SetFieldName;
    property State: TcxFieldName index 13 read GetFieldName write SetFieldName;
  end;

  { TcxSchedulerDBStorageResourceDataController }

  TcxSchedulerDBStorageResourceDataController = class(TcxDBDataController)
  protected
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;
  public
    function GetItem(AIndex: Integer): TObject; override;
  end;

  { TcxSchedulerDBStorageResources }

  TcxSchedulerDBStorageResources = class(TcxSchedulerStorageResources)
  private
    FDataController: TcxSchedulerDBStorageResourceDataController;
    FDataItems: TcxSchedulerStorageResourceItems;
    FResourceColorField: TcxDBDataField;
    FResourceColorFieldName: TcxFieldName;
    FResourceIDField: TcxDBDataField;
    FResourceIDFieldName: TcxFieldName;
    FResourceNameField: TcxDBDataField;
    FResourceNameFieldName: TcxFieldName;
    function GetDataSource: TDataSource;
    procedure SetDataSource(AValue: TDataSource);
    procedure SetResourceColorFieldName(const AValue: TcxFieldName);
    procedure SetResourceIDFieldName(const AValue: TcxFieldName);
    procedure SetResourceNameFieldName(const AValue: TcxFieldName);
  protected
    function CreateDataController: TcxSchedulerDBStorageResourceDataController; virtual;
    function GetResourceItems: TcxSchedulerStorageResourceItems; override;
    function GetValueDef(ARecordIndex: Integer; AField: TcxDBDataField;
      const DefValue: Variant): Variant;
    procedure InitDataItem(AItem: TcxSchedulerStorageResourceItem; AIndex: Integer); virtual;
    procedure SetInternalFieldName(var AFieldName: TcxFieldName; const AValue: TcxFieldName; var AField: TcxDBDataField);
    procedure UpdateResourceItems; virtual;
    property DataController: TcxSchedulerDBStorageResourceDataController read FDataController;
    property ResourceColorField: TcxDBDataField read FResourceColorField;
    property ResourceIDField: TcxDBDataField read FResourceIDField;
    property ResourceNameField: TcxDBDataField read FResourceNameField;
  public
    constructor Create(AOwner: TcxCustomSchedulerStorage); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property DataItems: TcxSchedulerStorageResourceItems read FDataItems;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ResourceColor: TcxFieldName read FResourceColorFieldName write SetResourceColorFieldName;
    property ResourceID: TcxFieldName read FResourceIDFieldName write SetResourceIDFieldName;
    property ResourceName: TcxFieldName read FResourceNameFieldName write SetResourceNameFieldName;
    property Items;
    property OnGetResourceName;
  end;

  TcxSchedulerGetEventGeneratedIDEvent = procedure(Sender: TcxSchedulerDBStorage;
    AEvent: TcxSchedulerEvent; var EventID: Variant) of object;

  { TcxSchedulerDBStorage }

  TcxSchedulerDBStorage = class(TcxCustomSchedulerStorage)
  private
    FFieldNames: TcxSchedulerDBStorageFieldNames;
    FGenerateGUIDForID: Boolean;
    FOnGetEventGeneratedID: TcxSchedulerGetEventGeneratedIDEvent;
    function GetDataController: TcxSchedulerDBStorageDataController;
    function GetDataSource: TDataSource;
    function GetFields: TcxSchedulerDBStorageFields;
    function GetResources: TcxSchedulerDBStorageResources;
    procedure SetDataSource(AValue: TDataSource);
    procedure SetFields(const AValue: TcxSchedulerDBStorageFields);
    procedure SetFieldNames(AValue: TcxSchedulerDBStorageFieldNames);
    procedure SetResources(AValue: TcxSchedulerDBStorageResources);
  protected
    FIDField: TField;
    procedure AddRecord; override;
    function CreateFieldNames: TcxSchedulerDBStorageFieldNames; virtual;
    function CreateFields: TcxCustomSchedulerStorageFields; override;
    function CreateResources: TcxSchedulerStorageResources; override;
    procedure CreateSubClasses; override;
    procedure DestroySubClasses; override;
    function DoGetEventGeneratedID(AEvent: TcxSchedulerEvent; const AEventID: Variant): Variant; virtual;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetIDField: TField;
    function GetField(AIndex: Integer): TField;
    function GetFieldValueBeforePost(ARecordIndex, AFieldIndex: Integer): Variant; override;
    function GetFocusedRecordID(ARecordIndex: Integer): Variant; override;
    function IsDataSettingsValid: Boolean; override;
    function IsFieldValid(AField: TcxCustomSchedulerStorageField): Boolean;
    function MakeFocused(AEvent: TcxSchedulerEvent): Boolean;
    procedure PostEvent(AEvent: TcxSchedulerEvent); override;
    procedure PostEditingData(AEvent: TcxSchedulerEvent); override;
    procedure SetFieldValueBeforePost(ARecordIndex, AFieldIndex: Integer; const AValue: Variant); override;
    procedure SetValue(ARecordIndex, AItemIndex: Integer; const AValue: Variant); override;

    function IsReminderAvailable: Boolean; override;

    procedure AfterUpdate; override;
    procedure BeforeUpdate; override;

    property DataController: TcxSchedulerDBStorageDataController read GetDataController;
    property IDField: TField read GetIDField;
  public
    procedure Assign(Source: TPersistent); override;
    function CheckRequiredFields: Boolean; override;
    procedure Clear; override;
    function IsActive: Boolean; override;
    function IsCaptionAvailable: Boolean; override;
    function IsLabelColorAvailable: Boolean; override;
    function IsLocationAvailable: Boolean; override;
    function IsMessageAvailable: Boolean; override;
    function IsRecurrenceAvailable: Boolean; override;
    function IsStateAvailable: Boolean; override;
  published
    property GenerateGUIDForID: Boolean read FGenerateGUIDForID write FGenerateGUIDForID default False;
    property Resources: TcxSchedulerDBStorageResources read GetResources write SetResources;
    property CustomFields: TcxSchedulerDBStorageFields read GetFields write SetFields;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property FieldNames: TcxSchedulerDBStorageFieldNames read FFieldNames write SetFieldNames;
    property OnEventDeleted;
    property OnEventInserted;
    property OnEventModified;
    property OnGetEventGeneratedID: TcxSchedulerGetEventGeneratedIDEvent read FOnGetEventGeneratedID write FOnGetEventGeneratedID;
  end;

implementation

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  cxVariants, cxSchedulerStrs, cxSchedulerUtils;

{$IFNDEF DELPHI6}
function CoCreateGuid(out guid: TGUID): HResult; stdcall;
  external 'ole32.dll' name 'CoCreateGuid';

function StringFromCLSID(const clsid: TGUID; out psz: PWideChar): HResult; stdcall;
  external 'ole32.dll' name 'StringFromCLSID';

procedure CoTaskMemFree(pv: Pointer); stdcall;
  external 'ole32.dll' name 'CoTaskMemFree';

function CreateGUID(out Guid: TGUID): HResult;
begin
  Result := CoCreateGuid(Guid);
end;

function GUIDToString(const GUID: TGUID): string;
var
  P: PWideChar;
begin
  if not Succeeded(StringFromCLSID(GUID, P)) then
    raise EAbort.Create('');
  Result := P;
  CoTaskMemFree(P);
end;
{$ENDIF}

function CreateGUIDForID: string;
var
  G: TGUID;
begin
  CreateGUID(G);
  Result := GUIDToString(G);
end;

procedure CheckAndSetFieldValue(AField: TField; const AValue: Variant);
begin
  if (AField <> nil) and not VarEqualsSoft(AField.Value, AValue) then
    SetFieldValue(AField, AValue);
end;

{ TcxSchedulerDBStorageDataController }

function TcxSchedulerDBStorageDataController.GetItem(
  Index: Integer): TObject;
begin
  Result := Storage.FFields[Index];
end;

function TcxSchedulerDBStorageDataController.GetItemValueSource(
  AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := evsValue;
end;

function TcxSchedulerDBStorageDataController.GetItemID(
  AItem: TObject): Integer;
begin
  if AItem is TcxCustomSchedulerStorageField then
    Result := TcxCustomSchedulerStorageField(AItem).Index
  else
    Result := -1;
end;

procedure TcxSchedulerDBStorageDataController.UpdateData;
begin
  Storage.UpdateData;
end;

procedure TcxSchedulerDBStorageDataController.UpdateItemIndexes;
begin
  Storage.UpdateItemIndexes;
  inherited UpdateItemIndexes;
end;

procedure TcxSchedulerDBStorageDataController.UpdateControl(
  AInfo: TcxUpdateControlInfo);
begin
  Storage.UpdateControl(AInfo);
end;

function TcxSchedulerDBStorageDataController.GetStorage: TcxSchedulerDBStorage;
begin
  Result := TcxSchedulerDBStorage(GetOwner)
end;

{ TcxSchedulerDBStorageField }

function TcxSchedulerDBStorageField.GetDisplayName: string;
begin
  Result := FieldName;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function TcxSchedulerDBStorageField.GetDataController: TcxSchedulerDBStorageDataController;
begin
  Result := TcxSchedulerDBStorageDataController(inherited DataController);
end;

function TcxSchedulerDBStorageField.GetDataSource: TDataSource;
begin
  Result := DataController.DataSource;
end;

function TcxSchedulerDBStorageField.GetFieldName: string;
begin
  Result := DataController.GetItemFieldName(Index);
end;

procedure TcxSchedulerDBStorageField.SetFieldName(
  const AValue: string);
begin
  TcxSchedulerDBStorageDataController(DataController).ChangeFieldName(Index, AValue);
end;

{ TcxSchedulerDBStorageFields }

function TcxSchedulerDBStorageFields.Add: TcxSchedulerDBStorageField;
begin
  Result := TcxSchedulerDBStorageField(inherited Add)
end;

function TcxSchedulerDBStorageFields.ItemByFieldName(
  const AFieldName: string): TcxSchedulerDBStorageField;
begin
  Result := TcxSchedulerDBStorageField(FindFieldByName(AFieldName));
end;

function TcxSchedulerDBStorageFields.FindFieldByName(
  const AName: string): TcxCustomSchedulerStorageField;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TcxSchedulerStorageField(inherited Items[I]);
    if AnsiSameText(AName, TcxSchedulerDBStorageField(Result).FieldName) then Exit;
  end;
  Result := nil;
end;

function TcxSchedulerDBStorageFields.GetItem(
  AIndex: Integer): TcxSchedulerDBStorageField;
begin
  Result := TcxSchedulerDBStorageField(inherited Items[AIndex])
end;

procedure TcxSchedulerDBStorageFields.SetItem(
  AIndex: Integer; const AValue: TcxSchedulerDBStorageField);
begin
  Items[AIndex].Assign(AValue);
end;

{ TcxSchedulerDBStorageFieldNames }

constructor TcxSchedulerDBStorageFieldNames.Create(
  AOwner: TcxSchedulerDBStorage);
begin
  FOwner := AOwner;
end;

procedure TcxSchedulerDBStorageFieldNames.Assign(
  Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerDBStorageFieldNames then
  begin
    for I := 0 to Storage.InternalFields.Count - 1 do
      SetFieldName(I, TcxSchedulerDBStorageFieldNames(Source).GetFieldName(I));
  end;
end;

function TcxSchedulerDBStorageFieldNames.GetDataController: TcxSchedulerDBStorageDataController;
begin
  Result := FOwner.DataController;
end;

function TcxSchedulerDBStorageFieldNames.GetFieldName(
  AIndex: Integer): TcxFieldName;
begin
  Result := TcxSchedulerDBStorageField(
    Storage.InternalFields.Items[AIndex]).FieldName;
end;

function TcxSchedulerDBStorageFieldNames.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxSchedulerDBStorageFieldNames.SetFieldName(
  AIndex: Integer; const AValue: TcxFieldName);
begin
  TcxSchedulerDBStorageField(
    Storage.InternalFields.Items[AIndex]).FieldName := AValue;
end;

function TcxSchedulerDBStorageFieldNames.GetKeyFieldName: TcxFieldName;
begin
  Result := DataController.KeyFieldNames;
end;

procedure TcxSchedulerDBStorageFieldNames.SetKeyFieldName(
  const AValue: TcxFieldName);
begin
  DataController.KeyFieldNames := AValue;
  Storage.FIDField := nil;
end;

{ TcxSchedulerDBStorageResourceDataController }

function TcxSchedulerDBStorageResourceDataController.GetItem(
  AIndex: Integer): TObject;
begin
  Result := nil;
end;

procedure TcxSchedulerDBStorageResourceDataController.UpdateControl(
  AInfo: TcxUpdateControlInfo);
begin
  if (AInfo is TcxDataChangedInfo) or (AInfo is TcxUpdateRecordInfo) then
    TcxSchedulerDBStorage(GetOwner).Resources.UpdateResourceItems;
end;

{ TcxSchedulerDBStorageResources }

constructor TcxSchedulerDBStorageResources.Create(
  AOwner: TcxCustomSchedulerStorage);
begin
  inherited Create(AOwner);
  FDataController := CreateDataController;
  FDataItems := CreateItems;
end;

destructor TcxSchedulerDBStorageResources.Destroy;
begin
  FDataItems.Free;
  FreeAndNil(FResourceColorField);
  FreeAndNil(FResourceIDField);
  FreeAndNil(FResourceNameField);
  FreeAndNil(FDataController);
  inherited Destroy;
end;

procedure TcxSchedulerDBStorageResources.Assign(
  Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerDBStorageResources then
  begin
    DataSource := TcxSchedulerDBStorageResources(Source).DataSource;
    ResourceColor := TcxSchedulerDBStorageResources(Source).ResourceColor;
    ResourceID := TcxSchedulerDBStorageResources(Source).ResourceID;
    ResourceName := TcxSchedulerDBStorageResources(Source).ResourceName;
  end;
end;

function TcxSchedulerDBStorageResources.CreateDataController: TcxSchedulerDBStorageResourceDataController;
begin
  Result := TcxSchedulerDBStorageResourceDataController.Create(Storage);
end;

function TcxSchedulerDBStorageResources.GetResourceItems: TcxSchedulerStorageResourceItems;
begin
  if DataItems.Count > 0 then
    Result := DataItems
  else
    Result := Items;
end;

procedure TcxSchedulerDBStorageResources.InitDataItem(
  AItem: TcxSchedulerStorageResourceItem; AIndex: Integer);
begin
  AItem.ResourceID := GetValueDef(AIndex, ResourceIDField, Null);
  AItem.Name := GetValueDef(AIndex, ResourceNameField, '');
  AItem.Color := GetValueDef(AIndex, ResourceColorField, clDefault);
end;

function TcxSchedulerDBStorageResources.GetValueDef(ARecordIndex: Integer;
  AField: TcxDBDataField; const DefValue: Variant): Variant;
begin
  if AField <> nil then
  begin
    Result := DataController.GetInternalValue(ARecordIndex, AField);
    if VarIsNull(Result) then
      Result := DefValue
  end
  else
    Result := DefValue
end;

procedure TcxSchedulerDBStorageResources.SetInternalFieldName(
  var AFieldName: TcxFieldName; const AValue: TcxFieldName;
  var AField: TcxDBDataField);
begin
  if AFieldName <> AValue then
  begin
    AFieldName := AValue;
    DataController.UpdateInternalKeyFields(AValue, AField);
  end;
end;

procedure TcxSchedulerDBStorageResources.UpdateResourceItems;
var
  I, J: Integer;
  APrevItems: TcxSchedulerStorageResourceItems; 
begin
  APrevItems := FDataItems;
  FDataItems := CreateItems;
  try
    for I := 0 to DataController.RecordCount - 1 do
      InitDataItem(FDataItems.Add, I);
    for I := 0 to FDataItems.Count - 1 do
      for J := 0 to APrevItems.Count - 1 do
        if VarEquals(FDataItems[I].ResourceID, APrevItems[J].ResourceID) then
          with FDataItems[I] do
          begin
            Assign(APrevItems[J]);
            ResourceID := GetValueDef(I, ResourceIDField, ResourceID);
            Name := GetValueDef(I, ResourceNameField, Name);
            Color := GetValueDef(I, ResourceColorField, Color);
          end;
  finally
    APrevItems.Free;
    Changed;
  end;
end;

function TcxSchedulerDBStorageResources.GetDataSource: TDataSource;
begin
  Result := DataController.DataSource;
end;

procedure TcxSchedulerDBStorageResources.SetDataSource(
  AValue: TDataSource);
begin
  DataController.DataSource := AValue;
end;

procedure TcxSchedulerDBStorageResources.SetResourceColorFieldName(
  const AValue: TcxFieldName);
begin
  SetInternalFieldName(FResourceColorFieldName, AValue, FResourceColorField);
end;

procedure TcxSchedulerDBStorageResources.SetResourceIDFieldName(
  const AValue: TcxFieldName);
begin
  SetInternalFieldName(FResourceIDFieldName, AValue, FResourceIDField);
end;

procedure TcxSchedulerDBStorageResources.SetResourceNameFieldName(
  const AValue: TcxFieldName);
begin
  SetInternalFieldName(FResourceNameFieldName, AValue, FResourceNameField);
end;

{ TcxSchedulerDBStorage }

procedure TcxSchedulerDBStorage.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerDBStorage then
  begin
    FieldNames := TcxSchedulerDBStorage(Source).FieldNames;
    DataSource := TcxSchedulerDBStorage(Source).DataSource;
  end;
  inherited Assign(Source);
end;

function TcxSchedulerDBStorage.CheckRequiredFields: Boolean;
var
  S: string;
begin
  Result := IsDataSettingsValid;
  if not Result then
  begin
    S := '';
    if (FieldNames.ID = '') then
      S := S + ' � ID'#13#10;
    if not IsFieldValid(FEventTypeField) then
      S := S + ' � EventType'#13#10;
    if not IsFieldValid(FStartField) then
      S := S + ' � Start'#13#10;
    if not IsFieldValid(FFinishField) then
      S := S + ' � Finish'#13#10;
    if not IsFieldValid(FOptionsField) then
      S := S + ' � Options'#13#10;

    cxSchedulerError(scxRequiredFieldsNeeded, [S]);
  end;
end;

procedure TcxSchedulerDBStorage.Clear;
begin
  DataController.BeginUpdate;
  try
    DataController.Cancel;
    if IsActive then
    begin
      DataSource.DataSet.DisableControls;
      try
        while DataSource.DataSet.RecordCount > 0 do
          DataSource.DataSet.Delete;
      finally
        DataSource.DataSet.EnableControls;
      end;
      DataController.RecordCount := 0;
    end;
  finally
    DataController.EndUpdate;
  end;
end;

function TcxSchedulerDBStorage.IsActive: Boolean;
begin
  Result := (DataSource <> nil) and (DataSource.DataSet <> nil) and
    DataSource.DataSet.Active
end;

function TcxSchedulerDBStorage.IsCaptionAvailable: Boolean;
begin
  Result := IsFieldValid(FCaptionField);
end;

function TcxSchedulerDBStorage.IsLabelColorAvailable: Boolean;
begin
  Result := IsFieldValid(FLabelColorField);
end;

function TcxSchedulerDBStorage.IsLocationAvailable: Boolean;
begin
  Result := IsFieldValid(FLocationField);
end;

function TcxSchedulerDBStorage.IsMessageAvailable: Boolean;
begin
  Result := IsFieldValid(FMessageField);
end;

function TcxSchedulerDBStorage.IsRecurrenceAvailable: Boolean;
begin
  Result := IsFieldValid(FRecurrenceInfoField) and
    IsFieldValid(FRecurrenceIndexField);
end;

function TcxSchedulerDBStorage.IsStateAvailable: Boolean;
begin
  Result := IsFieldValid(FStateField);
end;

function TcxSchedulerDBStorage.IsReminderAvailable: Boolean;
begin
  Result := IsFieldValid(FReminderTimeField);
end;

procedure TcxSchedulerDBStorage.AfterUpdate;
begin
  if not DataController.DataModeController.SmartRefresh then
    DataController.DataSet.EnableControls;
end;

procedure TcxSchedulerDBStorage.BeforeUpdate;
begin
  if not DataController.DataModeController.SmartRefresh then
    DataController.DataSet.DisableControls;
end;

procedure TcxSchedulerDBStorage.AddRecord;
begin
  DataController.Append;
end;

function TcxSchedulerDBStorage.CreateFieldNames: TcxSchedulerDBStorageFieldNames;
begin
  Result := TcxSchedulerDBStorageFieldNames.Create(Self);
end;

function TcxSchedulerDBStorage.CreateFields: TcxCustomSchedulerStorageFields;
begin
  Result := TcxSchedulerDBStorageFields.Create(TcxSchedulerDBStorageField);
end;

function TcxSchedulerDBStorage.CreateResources: TcxSchedulerStorageResources;
begin
  Result := TcxSchedulerDBStorageResources.Create(Self);
end;

procedure TcxSchedulerDBStorage.CreateSubClasses;
begin
  inherited CreateSubClasses;
  FFieldNames := CreateFieldNames;
end;

procedure TcxSchedulerDBStorage.DestroySubClasses;
begin
  inherited DestroySubClasses;
  FFieldNames.Free;
end;

function TcxSchedulerDBStorage.DoGetEventGeneratedID(AEvent: TcxSchedulerEvent;
  const AEventID: Variant): Variant; 
begin
  Result := AEventID;
  if Assigned(FOnGetEventGeneratedID) then
    FOnGetEventGeneratedID(Self, AEvent, Result);
end;

function TcxSchedulerDBStorage.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxSchedulerDBStorageDataController;
end;

function TcxSchedulerDBStorage.GetField(
  AIndex: Integer): TField;
begin
  Result := DataController.GetItemField(AIndex);
end;

function TcxSchedulerDBStorage.GetIDField: TField;
begin
  if FIDField = nil then
    FIDField := DataController.DataSet.FieldByName(FieldNames.ID);
  Result := FIDField;
end;

function TcxSchedulerDBStorage.GetFieldValueBeforePost(
  ARecordIndex, AFieldIndex: Integer): Variant;
var
  AField: TField;
begin
  AField := GetField(AFieldIndex);
  if (AField <> nil) then
    Result := GetFieldValue(AField)
  else
    Result := Null;
end;

function TcxSchedulerDBStorage.GetFocusedRecordID(ARecordIndex: Integer): Variant;
begin
  Result := DataSource.DataSet.FieldByName(FieldNames.ID).Value;
end;

function TcxSchedulerDBStorage.IsDataSettingsValid: Boolean;
begin
  Result := IsActive and (FieldNames.ID <> '') {and IsFieldValid(FParentIDField)} and
    IsFieldValid(FEventTypeField) and IsFieldValid(FOptionsField) and
    IsFieldValid(FStartField) and IsFieldValid(FFinishField);
end;

function TcxSchedulerDBStorage.IsFieldValid(
  AField: TcxCustomSchedulerStorageField): Boolean;
begin
  Result := GetField(AField.Index) <> nil;
end;

procedure TcxSchedulerDBStorage.SetFieldValueBeforePost(
  ARecordIndex, AFieldIndex: Integer; const AValue: Variant);
begin
  CheckAndSetFieldValue(GetField(AFieldIndex), AValue);
end;

procedure TcxSchedulerDBStorage.SetValue(
  ARecordIndex, AItemIndex: Integer; const AValue: Variant);
begin
  SetFieldValue(DataController.GetItemField(AItemIndex), AValue);
end;

function TcxSchedulerDBStorage.MakeFocused(
  AEvent: TcxSchedulerEvent): Boolean;
begin
  DataController.FocusedRecordIndex := AEvent.RecordIndex;
  Result := DataController.FocusedRecordIndex = AEvent.RecordIndex;
end;

procedure TcxSchedulerDBStorage.PostEvent(AEvent: TcxSchedulerEvent);
var
  AIndex: Integer;
begin
  if not CheckRequiredFields then
  begin
    AEvent.Free;
    Exit;
  end;
  BeginUpdate;
  try
    AIndex := FNewEvents.Remove(AEvent);
    if AIndex <> -1 then
    begin
      FEventsList.Add(AEvent);
      SetEventRecordInfo(AEvent, -1, Null);
      if DoEventInserted(AEvent) then Exit;
      AddRecord;
      AEvent.EndEditing;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxSchedulerDBStorage.PostEditingData(
  AEvent: TcxSchedulerEvent);
var
  AEventID: Variant;
  AFieldIndex: Integer;
begin
  if DoEventModified(AEvent) or not IsDataSettingsValid then Exit;
  if (AEvent.RecordIndex <> -1) and (not DataController.IsEditing or
    (AEvent.RecordIndex <> DataController.EditingRecordIndex)) then
  begin
    if not MakeFocused(AEvent) then Exit;
    DataController.Edit;
  end;
  for AFieldIndex := 0 to AEvent.ValueCount - 1 do
    SetPostFieldValue(AEvent, AFieldIndex);
  if AEvent.RecordIndex = - 1 then
  begin
    if GenerateGUIDForID then
    begin
      AEventID := CreateGUIDForID;
      IDField.Value := AEventID;
    end;
    DataController.Post;
    if not GenerateGUIDForID then
      AEventID := DoGetEventGeneratedID(AEvent, IDField.Value);
    SetEventRecordInfo(AEvent, -1, AEventID);
  end
  else
    DataController.Post;
end;

function TcxSchedulerDBStorage.GetDataController: TcxSchedulerDBStorageDataController;
begin
  Result := TcxSchedulerDBStorageDataController(inherited DataController);
end;

function TcxSchedulerDBStorage.GetDataSource: TDataSource;
begin
  Result := TcxSchedulerDBStorageDataController(DataController).DataSource;
end;

function TcxSchedulerDBStorage.GetFields: TcxSchedulerDBStorageFields;
begin
  Result := TcxSchedulerDBStorageFields(inherited Fields);
end;

function TcxSchedulerDBStorage.GetResources: TcxSchedulerDBStorageResources;
begin
  Result := TcxSchedulerDBStorageResources(inherited Resources);
end;

procedure TcxSchedulerDBStorage.SetDataSource(
  AValue: TDataSource);
begin
  DataController.DataSource := AValue;
end;

procedure TcxSchedulerDBStorage.SetFields(
  const AValue: TcxSchedulerDBStorageFields);
begin
  Fields.Assign(AValue);
end;

procedure TcxSchedulerDBStorage.SetFieldNames(
  AValue: TcxSchedulerDBStorageFieldNames);
begin
  FFieldNames.Assign(AValue);
end;

procedure TcxSchedulerDBStorage.SetResources(
  AValue: TcxSchedulerDBStorageResources);
begin
  Resources.Assign(AValue);
end;

end.

