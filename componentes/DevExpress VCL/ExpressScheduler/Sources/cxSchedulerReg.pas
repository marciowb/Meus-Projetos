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

unit cxSchedulerReg;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,
  Types, DesignIntf, DesignEditors,  VCLEditors,
  cxDesignWindows, cxEditPropEditors, cxPropEditors, cxControls, DB, cxDataStorage,
  cxDateUtils, cxInplaceContainer, cxSchedulerStorage, cxSchedulerDBStorage, cxSchedulerUtils,
  cxSchedulerStrs, cxSchedulerDialogs, cxScheduler, cxStyles, cxSchedulerDateNavigator,
  cxDateNavigator;

procedure Register;

implementation

uses
  Windows, ShellApi, cxSchedulerCustomControls, cxSchedulerDayView, dxCoreReg, cxLibraryReg;

const
  cxSchedulerMajorVersion = '1';
  scxSchedulerDescription = 'ExpressScheduler';
  scxStorageDescription   = 'ExpressSchedulerStorage';
  scxEventsEditor         = 'Events editor...';

  scxDefault              = 'System';

type

  { TcxSchedulerComponentsEditor }

  TcxSchedulerComponentsEditor = class(TdxComponentEditor)
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
  end;

  { TcxSchedulerDBStorageFieldProperty }

  TcxSchedulerDBStorageFieldProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

  { TcxSchedulerDBStorageFieldNameProperty }

  TcxSchedulerDBStorageFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

  { TcxSchedulerDBStorageResourceFieldNameProperty }

  TcxSchedulerDBStorageResourceFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

  { TcxSchedulerStylesEventsProperty }

  TcxSchedulerStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxSchedulerContentPopupMenuEventsProperty }

  TcxSchedulerContentPopupMenuEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxSchedulerEventPopupMenuEventsProperty }

  TcxSchedulerEventPopupMenuEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxSchedulerStorageResourcesEventsProperty }

  TcxSchedulerStorageResourcesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxSchedulerDateNavigatorEventsProperty }

  TcxSchedulerDateNavigatorEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxSchedulerViewDayEventsProperty }

  TcxSchedulerViewDayEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxSchedulerTimeZoneProperty }

  TcxSchedulerTimeZoneProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxSchedulerTimeScaleProperty }
  
  TcxSchedulerTimeScaleProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TcxSchedulerComponentsEditor }

function TcxSchedulerComponentsEditor.GetProductMajorVersion: string;
begin
  Result := cxSchedulerMajorVersion;
end;

function TcxSchedulerComponentsEditor.GetProductName: string;
begin
  Result := scxSchedulerDescription;
end;

{ TcxSchedulerDBStorageFieldProperty }

function TcxSchedulerDBStorageFieldProperty.GetDataSource: TDataSource;
begin
  Result := TcxSchedulerDBStorageField(GetComponent(0)).DataSource;
end;

{ TcxSchedulerDBStorageFieldNameProperty }

function TcxSchedulerDBStorageFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := TcxSchedulerDBStorageFieldNames(GetComponent(0)).Storage.DataSource;
end;

{ TcxSchedulerDBStorageResourceFieldNameProperty }

function TcxSchedulerDBStorageResourceFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := TcxSchedulerDBStorageResources(GetComponent(0)).DataSource;
end;

{ TcxSchedulerTimeZoneProperty }

function TcxSchedulerTimeZoneProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  Result := Result - [paReadOnly, paSubProperties] + [paValueList, paRevertable];
end;

function TcxSchedulerTimeZoneProperty.GetValue: string;
var
  AIndex: Integer;
begin
  AIndex := GetOrdValue;
  if (AIndex < 0) or (AIndex >= DateTimeHelper.TimeZoneCount) then
    Result := scxDefault
  else
    Result := DateTimeHelper.TimeZoneInfo(AIndex).Display;
end;

procedure TcxSchedulerTimeZoneProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  AList: TStringList;
begin
  Proc(scxDefault);
  AList := TStringList.Create;
  try
    for I := 0 to DateTimeHelper.TimeZoneCount - 1 do
      AList.Add(DateTimeHelper.TimeZoneInfo(I).Display);
    AList.Sort;
    for I := 0 to AList.Count - 1 do
      Proc(AList[I]);
  finally
    AList.Free;
  end;
end;

procedure TcxSchedulerTimeZoneProperty.SetValue(const Value: string);
var
  AIndex: Integer;
begin
  if (Value = '') or (Value = scxDefault) then
    AIndex := -1
  else
  begin
    AIndex := DateTimeHelper.TimeZoneCount - 1;
    while AIndex >= 0 do
    begin
      if AnsiCompareText(DateTimeHelper.TimeZoneInfo(AIndex).Display, Value) = 0 then
        Break
      else
        Dec(AIndex);
    end;
  end;
  SetOrdValue(AIndex);
end;

{ TcxSchedulerTimeScaleProperty }

function TcxSchedulerTimeScaleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  Result := Result - [paReadOnly, paSubProperties] + [paValueList, paRevertable];
end;

function TcxSchedulerTimeScaleProperty.GetValue: string;
begin
  Result := IntToStr(GetOrdValue) + ' ' + scxMinutes;
end;

procedure TcxSchedulerTimeScaleProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
const
  AValues: array[0..5] of Integer = (60, 30, 15, 10, 6, 5);
begin
  for I := 0 to High(AValues) do
    Proc(IntToStr(AValues[I]) + ' ' + scxMinutes);
end;

procedure TcxSchedulerTimeScaleProperty.SetValue(const Value: string);
var
  I: Integer;
  S: string;
  ATime, ACode: Integer;
begin
  S := '';
  for I := 1 to Length(Value) do
    if Value[I] in ['0'..'9'] then
       S := S + Value[I]
    else
      Break;
  if S = '' then S := '60';
  Val(S, ATime, ACode);
  if ACode <> 0 then
    ATime := 60;
  SetOrdValue(ATime);
end;

{ TcxSchedulerStylesEventsProperty }

function TcxSchedulerStylesEventsProperty.GetInstance: TPersistent;
begin
  if (GetComponent(0) is TcxCustomScheduler) then
    Result := TcxCustomScheduler(GetComponent(0)).Styles
  else
    Result := nil;
end;

{ TcxSchedulerContentPopupMenuEventsProperty }

function TcxSchedulerContentPopupMenuEventsProperty.GetInstance: TPersistent;
begin
  if (GetComponent(0) is TcxCustomScheduler) then
    Result := TcxCustomScheduler(GetComponent(0)).ContentPopupMenu
  else
    Result := nil;
end;

{ TcxSchedulerEventPopupMenuEventsProperty }

function TcxSchedulerEventPopupMenuEventsProperty.GetInstance: TPersistent;
begin
  if (GetComponent(0) is TcxCustomScheduler) then
    Result := TcxCustomScheduler(GetComponent(0)).EventPopupMenu
  else
    Result := nil;
end;

{ TcxSchedulerStorageResourcesEventsProperty }

function TcxSchedulerStorageResourcesEventsProperty.GetInstance: TPersistent;
begin
  if (GetComponent(0) is TcxCustomSchedulerStorage) then
    Result := TcxCustomSchedulerStorage(GetComponent(0)).Resources
  else
    Result := nil;
end;

{ TcxSchedulerDateNavigatorEventsProperty }

function TcxSchedulerDateNavigatorEventsProperty.GetInstance: TPersistent;
begin
  if (GetComponent(0) is TcxScheduler) then
    Result := TcxScheduler(GetComponent(0)).DateNavigator
  else
    Result := nil;
end;

{ TcxSchedulerViewDayEventsProperty }

function TcxSchedulerViewDayEventsProperty.GetInstance: TPersistent;
begin
  if (GetComponent(0) is TcxScheduler) then
    Result := TcxScheduler(GetComponent(0)).ViewDay
  else
    Result := nil;
end;

type
  TcxSchedulerSelectionEditor = class(TSelectionEditor)
  protected
    ComponentsList: TStringList;
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxDateNavigatorSelectionEditor = class(TSelectionEditor)
  protected
    ComponentsList: TStringList;
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure TcxSchedulerSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('Menus');
  Proc('cxStyles');
  Proc('cxGraphics');
  Proc('cxEdit');
  Proc('cxScheduler');
  Proc('cxSchedulerStorage');
  Proc('cxSchedulerCustomControls');
  Proc('cxSchedulerCustomResourceView');
  Proc('cxSchedulerDayView');
  Proc('cxSchedulerDateNavigator');
  Proc('cxSchedulerWeekView');
end;

procedure TcxDateNavigatorSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('cxStyles');
  Proc('cxGraphics');
  Proc('cxSchedulerStorage');
  Proc('cxSchedulerCustomControls');
  Proc('cxSchedulerDateNavigator');
end;

procedure Register;
begin
  RegisterComponents(dxCoreLibraryProductPage, [TcxSchedulerStorage, TcxSchedulerDBStorage,
    TcxScheduler, TcxDateNavigator]);
  RegisterClasses([TcxSchedulerStorageField, TcxSchedulerDBStorageField]);
  RegisterComponentEditor(TcxCustomScheduler, TcxSchedulerComponentsEditor);
  RegisterComponentEditor(TcxCustomSchedulerStorage, TcxSchedulerComponentsEditor);
  RegisterComponentEditor(TcxCustomDateNavigator, TcxSchedulerComponentsEditor);

  RegisterPropertyEditor(TypeInfo(string), TcxSchedulerStorageField,
    'ValueType', TcxValueTypeProperty);

  // data base field names property editors
  RegisterPropertyEditor(TypeInfo(string), TcxSchedulerDBStorageField,
    'FieldName', TcxSchedulerDBStorageFieldProperty);
  RegisterPropertyEditor(TypeInfo(TcxFieldName), TcxSchedulerDBStorageFieldNames,
    '', TcxSchedulerDBStorageFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(TcxFieldName), TcxSchedulerDBStorageResources,
    '', TcxSchedulerDBStorageResourceFieldNameProperty);

  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomScheduler,
    'StylesEvents', TcxSchedulerStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxScheduler,
    'DateNavigatorEvents', TcxSchedulerDateNavigatorEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxScheduler,
    'ViewDayEvents', TcxSchedulerViewDayEventsProperty);

  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomSchedulerStorage,
    'ResourcesEvents', TcxSchedulerStorageResourcesEventsProperty);

  // day view property editors
  RegisterPropertyEditor(TypeInfo(Integer), TcxSchedulerOptionsView,
    'CurrentTimeZone', TcxSchedulerTimeZoneProperty);
  RegisterPropertyEditor(TypeInfo(Integer),  TcxSchedulerOptionsView,
    'AdditionalTimeZone', TcxSchedulerTimeZoneProperty);
  RegisterPropertyEditor(TypeInfo(Integer),  TcxSchedulerDayView,
    'TimeScale', TcxSchedulerTimeScaleProperty);

  //popups
  RegisterPropertyEditor(TypeInfo(TComponent), TcxSchedulerPopupMenu,
    'PopupMenu', TcxControlPopupMenuProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomScheduler,
    'ContentPopupMenuEvents', TcxSchedulerContentPopupMenuEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomScheduler,
    'EventPopupMenuEvents', TcxSchedulerEventPopupMenuEventsProperty);

  RegisterSelectionEditor(TcxCustomScheduler, TcxSchedulerSelectionEditor);
  RegisterSelectionEditor(TcxDateNavigator, TcxDateNavigatorSelectionEditor);
end;

end.
