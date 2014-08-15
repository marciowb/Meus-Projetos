{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
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

unit cxPivotGridReg;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, TypInfo,
  Types, DesignIntf, DesignEditors,  VCLEditors,
  Forms, DB, cxDesignWindows, cxEditPropEditors, cxPropEditors,  cxControls, cxEdit, 
  cxStyles, ShellApi, cxPivotGridDesigner, cxCustomPivotGrid, cxDBPivotGrid, cxPivotGrid,
  cxPivotGridPredefinedStyles, cxPivotGridStyleSheetsPreview, ImgList, dxCoreReg, cxLibraryReg;

procedure Register;

implementation

const
  scxDesigner = 'Designer...';
  scxMajorVersion = '1';
  scxProductName = 'ExpressPivotGrid';

type
  { TcxPivotGridFieldHeaderImageIndexProperty }

  TcxPivotGridFieldHeaderImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TcxPivotGridFieldNameProperty }
  
  TcxPivotGridFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

  { TcxPivotGridStylesEventsProperty }

  TcxPivotGridStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxPivotGridPopupMenusEventsProperty }

  TcxPivotGridPopupMenusEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxPivotGridComponentEditor }

  TcxPivotGridComponentEditor = class(TdxComponentEditor)
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  end;

  { TcxPivotGridDesignHelper }

  TcxPivotGridDesignHelper = class(TcxPivotGridCustomDesignHelper, IUnknown,
    IcxPivotGridDesignerHelper {$IFDEF DELPHI6}, IDesignNotification{$ENDIF})
  protected
    Listeners: TList;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
  {$IFDEF DELPHI6}
    // IDesignNotification
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
  {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddListener(APivotGrid: TcxCustomPivotGrid);
    procedure RemoveListener(APivotGrid: TcxCustomPivotGrid);
    function IsObjectSelected(AObject: TPersistent): Boolean;
    procedure Select(AObject: TPersistent; AShift: TShiftState);
  end;

{$IFDEF DELPHI6}
  TcxPivotGridSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
{$ENDIF}

  { TcxPivotGridFieldHeaderImageIndexProperty }

function TcxPivotGridFieldHeaderImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := nil;
  if GetComponent(0) is TcxPivotGridField then
    Result := TcxPivotGridField(GetComponent(0)).PivotGrid.FieldHeaderImages;
end;

{ TcxPivotGridFieldNameProperty }

function TcxPivotGridFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := TcxDBPivotGrid(TcxDBPivotGridFieldDataBinding(
    GetComponent(0)).PivotGrid).DataSource;
end;

{ TcxPivotGridStylesEventsProperty }

function TcxPivotGridStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomPivotGrid(GetComponent(0)).Styles;
end;

{ TcxPivotGridPopupMenusEventsProperty }

function TcxPivotGridPopupMenusEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomPivotGrid(GetComponent(0)).PopupMenus;
end;

{ TcxPivotGridComponentEditor }

function TcxPivotGridComponentEditor.GetProductMajorVersion: string;
begin
  Result := scxMajorVersion;
end;

function TcxPivotGridComponentEditor.GetProductName: string;
begin
  Result := scxProductName;
end;

function TcxPivotGridComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  Result := scxDesigner;
end;

function TcxPivotGridComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TcxPivotGridComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  ShowPivotGridDesigner(Designer, Component as TcxCustomPivotGrid);
end;

{ TcxPivotGridDesignHelper }

constructor TcxPivotGridDesignHelper.Create;
begin
  Listeners := TList.Create;
{$IFDEF DELPHI6}
  RegisterDesignNotification(Self);
{$ENDIF}
end;

destructor TcxPivotGridDesignHelper.Destroy;
begin
{$IFDEF DELPHI6}              
  UnregisterDesignNotification(Self);
{$ENDIF}
  Listeners.Free;
  inherited Destroy;
end;

procedure TcxPivotGridDesignHelper.AddListener(
  APivotGrid: TcxCustomPivotGrid);
begin
  Listeners.Add(APivotGrid);
end;

procedure TcxPivotGridDesignHelper.RemoveListener(
  APivotGrid: TcxCustomPivotGrid);
begin
  Listeners.Remove(APivotGrid);
end;

function TcxPivotGridDesignHelper.IsObjectSelected(
  AObject: TPersistent): Boolean;
begin
  Result := False; 
  if AObject = nil then Exit;
  with TcxDesignHelper.Create(AObject as TComponent) do
  try
    Result := IsObjectSelected(AObject);
  finally
    Free; 
  end;
end;

procedure TcxPivotGridDesignHelper.Select(
  AObject: TPersistent; AShift: TShiftState);
var
  ADesignHelper: TcxDesignHelper;
begin
  if AObject = nil then Exit;
  ADesignHelper := TcxDesignHelper.Create(AObject as TComponent);
  try
    if AShift * [ssCtrl, ssAlt] <> [] then Exit;
    if ssShift in AShift then
      ADesignHelper.ChangeSelection(AObject)
    else
      ADesignHelper.SelectObject(AObject);
  finally
    ADesignHelper.Free;
  end;
end;

// IUnknown
function TcxPivotGridDesignHelper._AddRef: Integer;
begin
  Result := -1;
end;

function TcxPivotGridDesignHelper._Release: Integer;
begin
  Result := -1;
end;

function TcxPivotGridDesignHelper.QueryInterface(
  const IID: TGUID; out Obj): HResult;
const
  cxE_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

{$IFDEF DELPHI6}
type
  TcxCustomPivotGridAccess = class(TcxCustomPivotGrid);

// IDesignNotification
procedure TcxPivotGridDesignHelper.ItemDeleted(
  const ADesigner: IDesigner; AItem: TPersistent);
begin
  if AItem is TcxCustomPivotGrid then
    RemoveListener(AItem as TcxCustomPivotGrid);
end;

procedure TcxPivotGridDesignHelper.ItemInserted(
  const ADesigner: IDesigner; AItem: TPersistent);
begin
end;

procedure TcxPivotGridDesignHelper.ItemsModified(const ADesigner: IDesigner);
begin
end;

procedure TcxPivotGridDesignHelper.SelectionChanged(
  const ADesigner: IDesigner; const ASelection: IDesignerSelections);
var
  I: Integer;
begin
  for I := 0 to Listeners.Count - 1 do
    RefreshListener(TcxCustomPivotGrid(Listeners[I]));
end;

procedure TcxPivotGridDesignHelper.DesignerOpened(
  const ADesigner: IDesigner; AResurrecting: Boolean);
begin
end;

procedure TcxPivotGridDesignHelper.DesignerClosed(
  const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
end;

{ TcxPivotGridSelectionEditor }

procedure TcxPivotGridSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('cxClasses');
  Proc('cxGraphics');
  Proc('cxCustomData');
  Proc('cxStyles');
end;

{$ENDIF}

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  RegisterComponents(dxCoreLibraryProductPage, [TcxPivotGrid, TcxDBPivotGrid]);
  RegisterNoIcon([TcxPivotGridField, TcxDBPivotGridField, TcxPivotGridStyleSheet]);
  RegisterClasses([TcxPivotGridField, TcxDBPivotGridField, TcxPivotGridStyleSheet]);
  RegisterClasses([TcxPivotGridFieldDataBinding, TcxDBPivotGridFieldDataBinding]);
  RegisterComponentEditor(TcxCustomPivotGrid, TcxPivotGridComponentEditor);

  RegisterPropertyEditor(TypeInfo(Boolean),
    TcxPivotGridField, 'IsCaptionAssigned', nil);
  RegisterPropertyEditor(TypeInfo(Boolean),
    TcxPivotGridFieldGroup, 'IsCaptionAssigned', nil);
  RegisterPropertyEditor(TypeInfo(Boolean),
    TcxPivotGridOptionsDataField, 'IsCaptionAssigned', nil);

  RegisterPropertyEditor(TypeInfo(TComponent),
    TcxPivotGridFieldHeaderMenu, 'PopupMenu', TcxControlPopupMenuProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),
    TcxPivotGridGroupValueMenu, 'PopupMenu', TcxControlPopupMenuProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),
    TcxPivotGridHeaderAreaMenu, 'PopupMenu', TcxControlPopupMenuProperty);

  RegisterPropertyEditor(TypeInfo(TImageIndex), TcxPivotGridField,
    'ImageIndex', TcxPivotGridFieldHeaderImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomPivotGrid,
    'StylesEvents', TcxPivotGridStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomPivotGrid,
    'PopupMenusEvents', TcxPivotGridPopupMenusEventsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBPivotGridFieldDataBinding,
    'FieldName', TcxPivotGridFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxPivotGridFieldDataBinding,
    'ValueType', TcxValueTypeProperty);
    
{$IFDEF DELPHI6}
  RegisterSelectionEditor(TcxCustomPivotGrid, TcxPivotGridSelectionEditor);
{$ENDIF}
end;

var
  ADesignerHelper: TcxPivotGridDesignHelper;

initialization
  DesignerHelper := nil;
  RegisterStyleSheetClass(TcxPivotGridStyleSheet);
  ADesignerHelper := TcxPivotGridDesignHelper.Create;
  DesignerHelper := ADesignerHelper as IcxPivotGridDesignerHelper;

finalization
  DesignerHelper := nil;
  UnRegisterStyleSheetClass(TcxPivotGridStyleSheet);
  FreeAndNil(ADesignerHelper);

end.

