{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxViewEditor;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  cxClasses, cxStorage, cxDesignWindows, cxCustomData, cxGridStructureNavigator,
  cxGridCommon, cxGridCustomView, cxGridCustomTableView, cxGridBandedTableView;

type
  { TcxViewEditor }

  TcxViewEditor = class(TForm)
    PViewEditor: TPanel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FView: TcxCustomGridView;
    function GetDataController: TcxCustomDataController;
    function GetOwnerForm: TComponent;
  protected
    procedure BeginUpdate;
    function CanAddComponent: Boolean;
    function CanDeleteComponent(AComponent: TComponent): Boolean;
    procedure EndUpdate;
    procedure GetSelectionList(AList: TList);
    procedure SelectComponent(AComponent: TPersistent);
    function UniqueName(AComponent: TComponent;
      const ATruncateClassName: string = ScxGridPrefixName): string; virtual;
    procedure UpdateDesigner; virtual;
    procedure UpdateEditor; virtual;
    procedure UpdateSelection; virtual;
    property DataController: TcxCustomDataController read GetDataController;
  public
    FormEditor: TcxDesignFormEditor;
    class function GetViewByObject(APersistent: TPersistent): TcxCustomGridView; virtual;
    procedure HideFrame; virtual;
    procedure SetView(Value: TcxCustomGridView; ARefreshNeeded: Boolean);
    procedure ShowFrame; virtual;
    property OwnerForm: TComponent read GetOwnerForm;
    property View: TcxCustomGridView read FView;
  end;

  TcxViewEditorClass = class of TcxViewEditor;

  { TcxCustomGridViewStorage }

  TcxCustomGridViewStorage = class(TcxInterfacedPersistent, IcxStoredObject)
  private
    FView: TcxCustomGridView;
  protected
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean;
    procedure GetPropertyValue(const AName: string; var AValue: Variant);
    procedure SetPropertyValue(const AName: string; const AValue: Variant);
    property View: TcxCustomGridView read FView;
  public
    constructor Create(AView: TcxCustomGridView); reintroduce; virtual;
    class function GetViewClass: TcxCustomGridViewClass; virtual;
  end;

  TcxCustomGridViewStorageClass = class of TcxCustomGridViewStorage;

function GetViewEditorClass(AViewClass: TcxCustomGridViewClass): TcxViewEditorClass;
procedure RegisterViewEditorClass(AViewClass: TcxCustomGridViewClass; AViewEditorClass: TcxViewEditorClass);
procedure UnregisterViewEditorClass(AViewClass: TcxCustomGridViewClass; AViewEditorClass: TcxViewEditorClass);
function GetLinkedView(APersistent: TPersistent): TcxCustomGridView;
function IsViewLinkedToComponent(AView: TcxCustomGridView; AComponent: TComponent): Boolean;

function GetViewTemplateRegKey: string;
procedure RegisterDefaultViewStorage(AStorageClass: TcxCustomGridViewStorageClass);
procedure UnregisterDefaultViewStorage(AStorageClass: TcxCustomGridViewStorageClass);
function GetDefaultViewStorageByViewClass(AGridView: TcxCustomGridView): TcxCustomGridViewStorage;
procedure RestoreViewFromTemplate(const ARegPath: string; AView: TcxCustomGridView);
procedure SaveViewToTemplate(const ARegPath: string; AView: TcxCustomGridView);

implementation

{$R *.dfm}

uses
  cxGrid, cxGridLevel;

type
  TcxDesignWindowAccess = class(TcxDesignWindow);

var
  ViewEditorClassList: TcxRegisteredClassList;
  DefaultViewStorages: TList;

function GetViewEditorClass(AViewClass: TcxCustomGridViewClass): TcxViewEditorClass;
begin
  Result := TcxViewEditorClass(ViewEditorClassList.FindClass(AViewClass));
end;

procedure RegisterViewEditorClass(AViewClass: TcxCustomGridViewClass; AViewEditorClass: TcxViewEditorClass);
begin
  ViewEditorClassList.Register(AViewClass, AViewEditorClass);
end;

procedure UnregisterViewEditorClass(AViewClass: TcxCustomGridViewClass; AViewEditorClass: TcxViewEditorClass);
begin
  ViewEditorClassList.Unregister(AViewClass, AViewEditorClass);
end;

function GetLinkedView(APersistent: TPersistent): TcxCustomGridView;
var
  I: Integer;
  AViewEditorClass: TcxViewEditorClass;
begin
  Result := nil;
  for I := 0 to ViewEditorClassList.Count - 1 do
  begin
    AViewEditorClass := TcxViewEditorClass(ViewEditorClassList[I].RegisteredClass);
    Result := AViewEditorClass.GetViewByObject(APersistent);
    if Result <> nil then
      Break;
  end;
end;

function IsViewLinkedToComponent(AView: TcxCustomGridView; AComponent: TComponent): Boolean;

  function CheckLevels(ALevel: TcxGridLevel): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ALevel.Count - 1 do
      if (ALevel[I].GridView = AView) or CheckLevels(ALevel[I]) then
      begin
        Result := True;
        Break;
      end; 
  end;

begin
  Result := AView.GetParentComponent = AComponent;
  if not Result and (AComponent is TcxCustomGrid) then // check Levels (from Repository)
    Result := CheckLevels(TcxCustomGrid(AComponent).Levels);
end;

function GetViewTemplateRegKey: string;
begin
  Result := TcxDesignWindow.GetBaseRegKey + '\TcxGridViewTemplate';
end;

procedure RegisterDefaultViewStorage(AStorageClass: TcxCustomGridViewStorageClass);
begin
  if DefaultViewStorages = nil then
    DefaultViewStorages := TList.Create;
  if DefaultViewStorages.IndexOf((AStorageClass)) < 0 then
    DefaultViewStorages.Add((AStorageClass));
end;

procedure UnregisterDefaultViewStorage(AStorageClass: TcxCustomGridViewStorageClass);
begin
  if DefaultViewStorages <> nil then
    DefaultViewStorages.Remove((AStorageClass));
end;

function GetDefaultViewStorageByViewClass(AGridView: TcxCustomGridView): TcxCustomGridViewStorage;
var
  I: Integer;
  ACurrent, AStorageClass: TcxCustomGridViewStorageClass;
begin
  Result := nil;
  AStorageClass := nil;
  if (DefaultViewStorages <> nil) and (AGridView <> nil) then
  begin
    for I := 0 to DefaultViewStorages.Count - 1 do
    begin
      ACurrent := TcxCustomGridViewStorageClass(DefaultViewStorages[I]);

      if AGridView.InheritsFrom(ACurrent.GetViewClass) then
        if (AStorageClass = nil) or
          not AStorageClass.GetViewClass.InheritsFrom(ACurrent.GetViewClass) then
          AStorageClass := ACurrent;

      if (AStorageClass <> nil) and
        (AStorageClass.GetViewClass = AGridView.ClassType) then
        Break;
    end;
  end;
  if AStorageClass <> nil then
    Result := AStorageClass.Create(AGridView);
end;

procedure RestoreViewFromTemplate(const ARegPath: string; AView: TcxCustomGridView);
var
  AStorage: TcxStorage;
  AViewStorage: TcxCustomGridViewStorage;
begin
  AViewStorage := GetDefaultViewStorageByViewClass(AView);
  if AViewStorage = nil then Exit;
  try
    AStorage := TcxStorage.Create(ARegPath{ + '\' + AViewStorage.GetObjectName});
    try
      AStorage.Modes := AStorage.Modes + [smSavePublishedClassProperties];
      AStorage.RestoreFromRegistry(AViewStorage);
    finally
      AStorage.Free;
    end;
  finally
    AViewStorage.Free;
  end;
end;

procedure SaveViewToTemplate(const ARegPath: string; AView: TcxCustomGridView);
var
  AStorage: TcxStorage;
  AViewStorage: TcxCustomGridViewStorage;
begin
  AViewStorage := GetDefaultViewStorageByViewClass(AView);
  if AViewStorage = nil then Exit;
  try
    AStorage := TcxStorage.Create(ARegPath{ + '\' + AViewStorage.GetObjectName});
    try
      AStorage.Modes := AStorage.Modes + [smSavePublishedClassProperties];
      AStorage.Recreate := False;
      AStorage.StoreToRegistry(AViewStorage);
    finally
      AStorage.Free;
    end;
  finally
    AViewStorage.Free;
  end;
end;

{ TcxCustomGridViewStorage }

constructor TcxCustomGridViewStorage.Create(AView: TcxCustomGridView);
begin
  inherited Create(AView);
  FView := AView;
end;

class function TcxCustomGridViewStorage.GetViewClass: TcxCustomGridViewClass;
begin
  Result := nil;
end;

function TcxCustomGridViewStorage.GetObjectName: string;
begin
  Result := GetViewClass.ClassName;
end;

function TcxCustomGridViewStorage.GetProperties(AProperties: TStrings): Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridViewStorage.GetPropertyValue(const AName: string; var AValue: Variant);
begin
end;

procedure TcxCustomGridViewStorage.SetPropertyValue(const AName: string; const AValue: Variant);
begin
end;

{ TcxViewEditor }

class function TcxViewEditor.GetViewByObject(APersistent: TPersistent): TcxCustomGridView;
begin
  Result := nil;
end;

procedure TcxViewEditor.HideFrame;
begin
end;

procedure TcxViewEditor.SetView(Value: TcxCustomGridView; ARefreshNeeded: Boolean);
begin
  FView := Value;
  if ARefreshNeeded then
    UpdateEditor;
  UpdateSelection;
end;

procedure TcxViewEditor.ShowFrame;
begin
end;

procedure TcxViewEditor.BeginUpdate;
begin
  FormEditor.BeginUpdate;
end;

function TcxViewEditor.CanAddComponent: Boolean;
begin
  Result := FormEditor.CanAddComponent;
end;

function TcxViewEditor.CanDeleteComponent(AComponent: TComponent): Boolean;
begin
  Result := FormEditor.CanDeleteComponent(AComponent);
end;

procedure TcxViewEditor.EndUpdate;
begin
  FormEditor.EndUpdate;
end;

procedure TcxViewEditor.GetSelectionList(AList: TList);
begin
  FormEditor.GetSelectionList(AList);
end;

procedure TcxViewEditor.SelectComponent(AComponent: TPersistent);
begin
  FormEditor.SelectComponent(AComponent);
end;

function TcxViewEditor.UniqueName(AComponent: TComponent;
  const ATruncateClassName: string = ScxGridPrefixName): string;
begin
  Result := CreateUniqueName(OwnerForm, View, AComponent, ATruncateClassName, '');
end;

procedure TcxViewEditor.UpdateDesigner;
begin
  FormEditor.Designer.Modified;
end;

procedure TcxViewEditor.UpdateEditor;
begin
end;

procedure TcxViewEditor.UpdateSelection;
begin
end;

function TcxViewEditor.GetDataController: TcxCustomDataController;
begin
  Result := FView.DataController;
end;

function TcxViewEditor.GetOwnerForm: TComponent;
begin
  Result := FormEditor.Component.Owner;
end;

procedure TcxViewEditor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #13, #33..#126:
      begin
        if Key = #13 then Key := #0;
        TcxDesignWindowAccess(FormEditor).ActivateInspector(Key);
        Key := #0;
      end;
  end;
end;

initialization
  ViewEditorClassList := TcxRegisteredClassList.Create;

finalization
  FreeAndNil(ViewEditorClassList);
  FreeAndNil(DefaultViewStorages);

end.
