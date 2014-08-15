{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express RTTI Inspector			                    }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxOI;

interface

{$I dxInsVer.inc}

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, TypInfo,
  dxCntner, dxInspct, dxExEdtr, dxInspRw {$IFDEF DELPHI6}, RTLConsts{$ENDIF};

type
  TdxComponentList = class(TObject)
  private
    FList: TList;
    function GetItem(Index: Integer): TPersistent;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(Item: TPersistent): Integer;
    function Equals(List: TdxComponentList): Boolean;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPersistent read GetItem; default;
  end;

  TdxPropertyAttribute =
    (ipaValueList, ipaSubProperties, ipaDialog, ipaMultiSelect, ipaAutoUpdate,
     ipaSortList, ipaReadOnly, ipaRevertable);
  TdxPropertyAttributes = set of TdxPropertyAttribute;

  TdxPropertyEditor = class;

  TdxInstProp = record
    Instance: TPersistent;
    PropInfo: PPropInfo;
  end;

  PdxInstPropList = ^TdxInstPropList;
  TdxInstPropList = array[0..1023] of TdxInstProp;

  TdxGetPropEditProc = procedure(PropertEditor: TdxPropertyEditor) of object;

  TdxPropertyEditor = class
  private
    FPropCount: Integer;
    FPropList: PdxInstPropList;
    FOwner: TComponent;

    constructor Create(AOwner: TComponent; APropCount: Integer);
    procedure SetPropEntry(Index: Integer; AInstance: TPersistent;
      APropInfo: PPropInfo);
  protected
    function GetPropInfo: PPropInfo;
    function GetFloatValue: Extended;
    function GetFloatValueAt(Index: Integer): Extended;
{$IFDEF DELPHI4}
    function GetInt64Value: Int64;
    function GetInt64ValueAt(Index: Integer): Int64;
{$ENDIF}
    function GetOrdValue: Longint;
    function GetOrdValueAt(Index: Integer): Longint;
    function GetStrValue: string;
    function GetStrValueAt(Index: Integer): string;
    function GetVarValue: Variant;
    function GetVarValueAt(Index: Integer): Variant;
    procedure SetFloatValue(Value: Extended);
{$IFDEF DELPHI4}
    procedure SetInt64Value(Value: Int64);
{$ENDIF}
    procedure SetOrdValue(Value: Longint);
    procedure SetStrValue(const Value: string);
    procedure SetVarValue(const Value: Variant);
  public
    destructor Destroy; override;

    function AllEqual: Boolean; virtual;
    procedure Edit; virtual;
    function GetAttributes: TdxPropertyAttributes; virtual;
    function GetComponent(Index: Integer): TPersistent;
    function GetEditLimit: Integer; virtual;
    function GetName: string; virtual;
    procedure GetProperties(AOwner: TComponent; Proc: TdxGetPropEditProc); virtual;
    function GetPropType: PTypeInfo;
    function GetValue: string; virtual;
    procedure GetValues(Proc: TGetStrProc); virtual;
    procedure SetValue(const Value: string); virtual;
    function ValueAvailable: Boolean;

    property PropCount: Integer read FPropCount;
    property Value: string read GetValue write SetValue;
  end;

  TdxPropertyEditorClass = class of TdxPropertyEditor;

{ TdxOrdinalProperty }

  TdxOrdinalProperty = class(TdxPropertyEditor)
    function AllEqual: Boolean; override;
    function GetEditLimit: Integer; override;
  end;

{ TdxIntegerProperty }

  TdxIntegerProperty = class(TdxOrdinalProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxCharProperty }

  TdxCharProperty = class(TdxOrdinalProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxEnumProperty }

  TdxEnumProperty = class(TdxOrdinalProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxBoolProperty }

  TdxBoolProperty = class(TdxEnumProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxFloatProperty }

  TdxFloatProperty = class(TdxPropertyEditor)
  public
    function AllEqual: Boolean; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{$IFDEF DELPHI4}

{ TInt64Property }

  TdxInt64Property = class(TdxPropertyEditor)
  public
    function AllEqual: Boolean; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;
{$ENDIF}

{ TdxStringProperty}

  TdxStringProperty = class(TdxPropertyEditor)
  public
    function AllEqual: Boolean; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxSetElementProperty }

  TdxSetElementProperty = class(TdxPropertyEditor)
  private
    FElement: Integer;
    constructor Create(APropList: PdxInstPropList;
      APropCount: Integer; AElement: Integer);
  public
    destructor Destroy; override;
    function AllEqual: Boolean; override;
    function GetAttributes: TdxPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxSetProperty }

  TdxSetProperty = class(TdxOrdinalProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    procedure GetProperties(AOwner: TComponent; Proc: TdxGetPropEditProc); override;
    function GetValue: string; override;
  end;

{ TdxClassProperty }

  TdxClassProperty = class(TdxPropertyEditor)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    procedure GetProperties(AOwner: TComponent; Proc: TdxGetPropEditProc); override;
    function GetValue: string; override;
  end;

{ TdxComponentProperty }

  TdxComponentProperty = class(TdxPropertyEditor)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxComponentNameProperty }

  TdxComponentNameProperty = class(TdxStringProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetEditLimit: Integer; override;
  end;

{ TdxFontNameProperty }

  TdxFontNameProperty = class(TdxStringProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{ TdxFontCharsetProperty }

  TdxFontCharsetProperty = class(TdxIntegerProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxImeNameProperty }

  TdxImeNameProperty = class(TdxStringProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{ TColorProperty }

  TdxColorProperty = class(TdxIntegerProperty)
  public
    procedure Edit; override;
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxCursorProperty }

  TdxCursorProperty = class(TdxIntegerProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxFontProperty }

  TdxFontProperty = class(TdxClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TdxPropertyAttributes; override;
  end;

{ TdxStringsProperty }

  TdxStringsProperty = class(TdxClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TdxPropertyAttributes; override;
  end;

{ TdxGraphicProperty }  

  TdxGraphicProperty = class(TdxClassProperty)
  private
    function HasGraphic: Boolean;
  protected  
    function GetGraphic: TGraphic; virtual;
    procedure SetGraphic(Value: TGraphic); virtual;
    
    function GetClipboardFormat: Word; virtual;
    function GetGraphicFilter: string; virtual;
    function GraphicClass: TGraphicClass;
  public
    procedure Edit; override;
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;    
  end;
  
{ TdxPictureProperty }

  TdxPictureProperty = class(TdxGraphicProperty)
  protected
    function GetGraphic: TGraphic; override;
    procedure SetGraphic(Value: TGraphic); override;
  end;

  
{ TdxModalResultProperty }

  TdxModalResultProperty = class(TdxIntegerProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxShortCutProperty }

  TdxShortCutProperty = class(TdxOrdinalProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxMPFilenameProperty }

  TdxMPFilenameProperty = class(TdxStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TdxPropertyAttributes; override;
  end;

{ TdxTabOrderProperty }

  TdxTabOrderProperty = class(TdxIntegerProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
  end;

{ TCaptionProperty }

  TdxCaptionProperty = class(TdxStringProperty)
  public
    function GetAttributes: TdxPropertyAttributes; override;
  end;

{ TdxDateProperty }

  TdxDateProperty = class(TdxPropertyEditor)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxTimeProperty }

  TdxTimeProperty = class(TdxPropertyEditor)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TdxDateTimeProperty }

  TdxDateTimeProperty = class(TdxPropertyEditor)
  public
    function GetAttributes: TdxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  EdxPropertyError = class(Exception);


  TdxFilterPropertyEvent = procedure(Sender: TObject; const PropertyName: string; 
    var Accept: Boolean) of object;
    
  TCustomdxRTTIInspector = class(TCustomdxInspectorControl)
  private
    FCurrentRow: TdxInspectorRow;
    FInspectedObject: TPersistent;
    FParentNode: TdxInspectorNode;
    FOnFilterProperty: TdxFilterPropertyEvent;
    FOnPropertyChanged: TNotifyEvent;
    
    function GetFocusedRow: TdxInspectorRow;    
    function GetPropertyEditor: TdxPropertyEditor;    
    procedure SetFocusedRow(Value: TdxInspectorRow);
    procedure SetInspectedObject(Value: TPersistent);

    procedure CreatePropertyRows(OldInspectedObject: TPersistent);
    function CanInvokePropertyEditorDlg: Boolean;
    procedure CreateRows(PropertyEditor: TdxPropertyEditor);
    procedure GetComponentsProperties(const AInstances: array of TPersistent);
    procedure GetStrProc(const S: string);    
    procedure PickRowCloseUp(Sender: TObject; var Value: Variant; var Accept: Boolean);
    procedure ReleaseComponentProperties;
    procedure RowButtonClick(Sender: TObject; AbsoluteIndex: Integer);
    procedure TryInvokePropertyEditorDlg;
  protected 
    procedure DblClick; override; 
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure Loaded; override;
    
    procedure DoDrawCaption(ACanvas:TCanvas; ANode: TdxInspectorNode;
      AIndentRect, AButtonRect, AImageRect : TRect; AButtonKind: TdxInspectorButtonKind;
      ADisplayRect: TRect; var AText: string); override;
    procedure DoEditChange(Sender: TObject); override;
    procedure DoPropertyChanged;
    procedure DoEditValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean); override;

    function FilterProperty(const PropertyName: string): Boolean; dynamic;
    function FindRowByPropertyName(const APropertyName: string): TdxInspectorRow;
    procedure FocusRowByPropertyName(const APropertyName: string);
    function GetRowClass(APropertyEditor: TdxPropertyEditor): TdxInspectorRowClass; virtual;

    property FocusedRow: TdxInspectorRow read GetFocusedRow write SetFocusedRow;
    property PropertyEditor: TdxPropertyEditor read GetPropertyEditor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshInspectedProperties;

    property OnPropertyChanged: TNotifyEvent read FOnPropertyChanged write FOnPropertyChanged;
  published
    property InspectedObject: TPersistent read FInspectedObject write SetInspectedObject;
    property OnFilterProperty: TdxFilterPropertyEvent read FOnFilterProperty write FOnFilterProperty;
  end;

  TdxRTTIInspector = class(TCustomdxRTTIInspector)
  public
    property DragNode;
    property ReadOnly;
  published
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    property BandWidth;
    property ComplexRowSeparator;
    property DividerPos;
    property GridColor;
    property Flat;
    property Images;
    property MaxRowTextLineCount;
    property MinBandWidth;
    property MinColumnWidth;
    property Options;
    property PaintStyle;
    property RegistryPath;
    property RowHeight;
    property OnChangeNode;
    property OnDrawCaption;
    property OnDrawValue;
    property OnEditing;
    property OnEditChange;
    property OnEdited;
    property OnEditValidate;
    property OnGetEditColor;
    property OnGetEditFont;
    property OnHideCustomizeForm;
    property OnShowCustomizeForm;
    property ShowRowHint;
    {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    {$ENDIF}
    {$IFDEF DELPHI5}
    property OnContextPopup;
    {$ENDIF}
  end;
procedure dxRegisterPropertyEditor(APropertyType: PTypeInfo; AComponentClass: TClass;
  const APropertyName: string; AEditorClass: TdxPropertyEditorClass);

type
  TdxPropertyMapperFunc = function(Obj: TPersistent; PropInfo: PPropInfo): TdxPropertyEditorClass;

procedure dxRegisterPropertyMapper(AMapper: TdxPropertyMapperFunc);
procedure dxGetComponentProperties(AOwner: TComponent; AComponents: TdxComponentList;
  AFilter: TTypeKinds; AProc: TdxGetPropEditProc);
  
function dxGetRowClassByEditor(APropertyEditor: TdxPropertyEditor): TdxInspectorRowClass; 
procedure dxRegisterRowClass(AEditorClass: TdxPropertyEditorClass; ARowClass: TdxInspectorRowClass);

function HasProperty(AClass: TClass; const APropertyName: string): Boolean;
function IsUniquePropertyRelativeTo(AClass, ARelativeClass: TClass; const APropertyName: string): Boolean;
function IsUniquePropertyRelativeParent(AClass: TClass; const APropertyName: string): Boolean;

implementation
uses
  Menus, Clipbrd, Dialogs, Consts, Registry, MPlayer, 
  dxEditor, dxOIStringsEd, dxOIPictureEd {$IFDEF DELPHI4}{$IFNDEF DELPHI5}, DsgnIntf{$ENDIF}{$ENDIF};

type
  TdxIntegerSet = set of 0..SizeOf(Integer) * 8 - 1;

  TdxPropertyClassRec = class
    Group: Integer;
    PropertyType: PTypeInfo;
    PropertyName: string;
    ComponentClass: TClass;
    EditorClass: TdxPropertyEditorClass;
  end;

  TdxPropertyMapperRec = class
    Group: Integer;
    Mapper: TdxPropertyMapperFunc;
  end;

  TdxInspectorRowMapperRec = class
    EditorClass: TdxPropertyEditorClass;
    RowClass: TdxInspectorRowClass;
  end;
  
const
  dxPropClassMap: array[TTypeKind] of TdxPropertyEditorClass = (
    nil, TdxIntegerProperty, TdxCharProperty, TdxEnumProperty,
    TdxFloatProperty, TdxStringProperty, TdxSetProperty, TdxClassProperty,
    nil, TdxPropertyEditor, TdxStringProperty, TdxStringProperty,
    TdxPropertyEditor, nil, nil, nil{$IFDEF DELPHI4}, TdxInt64Property, nil{$ENDIF});

var
  FPropertyClasses: TList = nil;
  FPropertyMappers: TList = nil;
  FRowClasses: TList = nil;

function HasProperty(AClass: TClass; const APropertyName: string): Boolean;
var
  TypeKinds: TTypeKinds;
  PropCount: Integer;
  PropList: PPropList;
  I: Integer;
begin
  TypeKinds := tkProperties;
  PropCount := GetPropList(AClass.ClassInfo, TypeKinds, nil);
  if PropCount > 0 then
  begin
    PropList := AllocMem(PropCount * SizeOf(PPropInfo));
    try
      PropCount := GetPropList(AClass.ClassInfo, TypeKinds, PropList);
      I := 0;
      while (I < PropCount) and (CompareText(PropList^[I].Name, APropertyName) <> 0) do
        Inc(I);
      Result := I < PropCount;
    finally
      FreeMem(PropList, PropCount * SizeOf(PPropInfo));
    end;
  end
  else
    Result := False;
end;

function IsUniquePropertyRelativeTo(AClass, ARelativeClass: TClass; const APropertyName: string): Boolean;  
begin
  Result := HasProperty(AClass, APropertyName) and 
    ((ARelativeClass = nil) or not HasProperty(ARelativeClass, APropertyName));
end;

function IsUniquePropertyRelativeParent(AClass: TClass; const APropertyName: string): Boolean;
begin
  Result := IsUniquePropertyRelativeTo(AClass, AClass.ClassParent, APropertyName);
end;
  
{ TComponentList }

constructor TdxComponentList.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TdxComponentList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TdxComponentList.GetItem(Index: Integer): TPersistent;
begin
  Result := FList[Index];
end;

function TdxComponentList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TdxComponentList.Add(Item: TPersistent): Integer;
begin
  Result := FList.Add(Item);
end;

function TdxComponentList.Equals(List: TdxComponentList): Boolean;
var
  I: Integer;
begin
  Result := False;
  if List.Count <> FList.Count then Exit;
  for I := 0 to List.Count - 1 do
    if List[I] <> FList[I] then Exit;
  Result := True;
end;

function dxGetRowClassByEditor(APropertyEditor: TdxPropertyEditor): TdxInspectorRowClass; 
var
  I: Integer;
  Item: TdxInspectorRowMapperRec;
begin
  Result := nil;
  if FRowClasses <> nil then 
    for I := 0 to FRowClasses.Count - 1 do 
    begin
      Item := TdxInspectorRowMapperRec(FRowClasses[I]);
      if Item.EditorClass.InheritsFrom(APropertyEditor.ClassType) then 
        Result := Item.RowClass;
      if Item.EditorClass = APropertyEditor.ClassType then 
        Exit;
    end;    
end;

procedure dxRegisterRowClass(AEditorClass: TdxPropertyEditorClass; ARowClass: TdxInspectorRowClass);
var
  Item: TdxInspectorRowMapperRec;
begin
  if FRowClasses = nil then FRowClasses := TList.Create;
  Item := TdxInspectorRowMapperRec.Create;
  Item.EditorClass := AEditorClass;
  Item.RowClass := ARowClass;
  FRowClasses.Insert(0, Item);
end;

procedure ListFreeAndNil(var List: TList);
var
  I: Integer;
begin
  if List <> nil then 
  begin
    for I := 0 to List.Count - 1 do
      TObject(List[I]).Free;
    List.Free;
    List := nil;
  end;
end;

{ TdxPropertyEditor }

constructor TdxPropertyEditor.Create(AOwner: TComponent; APropCount: Integer);
begin
  GetMem(FPropList, APropCount * SizeOf(TdxInstProp));
  FPropCount := APropCount;
  FOwner := AOwner;
end;

destructor TdxPropertyEditor.Destroy;
begin
  if FPropList <> nil then
    FreeMem(FPropList, FPropCount * SizeOf(TdxInstProp));
  inherited Destroy;  
end;

function TdxPropertyEditor.AllEqual: Boolean;
begin
  Result := FPropCount = 1;
end;

procedure TdxPropertyEditor.Edit;
type
  TdxGetStrFunc = function(const Value: string): Integer of object;
var
  I: Integer;
  Values: TStringList;
  AddValue: TdxGetStrFunc;
begin
  Values := TStringList.Create;
  Values.Sorted := ipaSortList in GetAttributes;
  try
    AddValue := Values.Add;
    GetValues(TGetStrProc(AddValue));
    if Values.Count > 0 then
    begin
      I := Values.IndexOf(Value) + 1;
      if I = Values.Count then I := 0;
      Value := Values[I];
    end;
  finally
    Values.Free;
  end;
end;

function TdxPropertyEditor.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaRevertable];
end;

function TdxPropertyEditor.GetComponent(Index: Integer): TPersistent;
begin
  Result := FPropList^[Index].Instance;
end;

function TdxPropertyEditor.GetFloatValue: Extended;
begin
  Result := GetFloatValueAt(0);
end;

function TdxPropertyEditor.GetFloatValueAt(Index: Integer): Extended;
begin
  with FPropList^[Index] do
    Result := GetFloatProp(Instance, PropInfo);
end;

{$IFDEF DELPHI4}

function TdxPropertyEditor.GetInt64Value: Int64;
begin
  Result := GetInt64ValueAt(0);
end;

function TdxPropertyEditor.GetInt64ValueAt(Index: Integer): Int64;
begin
  with FPropList^[Index] do
    Result := GetInt64Prop(Instance, PropInfo);
end;
{$ENDIF}

function TdxPropertyEditor.GetEditLimit: Integer;
begin
  Result := 255;
end;

function TdxPropertyEditor.GetName: string;
begin
  Result := FPropList^[0].PropInfo^.Name;
end;

function TdxPropertyEditor.GetOrdValue: Longint;
begin
  Result := GetOrdValueAt(0);
end;

function TdxPropertyEditor.GetOrdValueAt(Index: Integer): Longint;
begin
  with FPropList^[Index] do
    Result := GetOrdProp(Instance, PropInfo);
end;

procedure TdxPropertyEditor.GetProperties(AOwner: TComponent; Proc: TdxGetPropEditProc);
begin
end;

function TdxPropertyEditor.GetPropInfo: PPropInfo;
begin
  Result := FPropList^[0].PropInfo;
end;

function TdxPropertyEditor.GetPropType: PTypeInfo;
begin
  Result := FPropList^[0].PropInfo^.PropType^;
end;

function TdxPropertyEditor.GetStrValue: string;
begin
  Result := GetStrValueAt(0);
end;

function TdxPropertyEditor.GetStrValueAt(Index: Integer): string;
begin
  with FPropList^[Index] do
    Result := GetStrProp(Instance, PropInfo);
end;

function TdxPropertyEditor.GetVarValue: Variant;
begin
  Result := GetVarValueAt(0);
end;

function TdxPropertyEditor.GetVarValueAt(Index: Integer): Variant;
begin
  with FPropList^[Index] do
    Result := GetVariantProp(Instance, PropInfo);
end;

function TdxPropertyEditor.GetValue: string;
begin
  Result := srUnknown;
end;

procedure TdxPropertyEditor.GetValues(Proc: TGetStrProc);
begin
end;

procedure TdxPropertyEditor.SetFloatValue(Value: Extended);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetFloatProp(Instance, PropInfo, Value);
end;

{$IFDEF DELPHI4}

procedure TdxPropertyEditor.SetInt64Value(Value: Int64);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetInt64Prop(Instance, PropInfo, Value);
end;
{$ENDIF}

procedure TdxPropertyEditor.SetOrdValue(Value: Longint);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetOrdProp(Instance, PropInfo, Value);
end;

procedure TdxPropertyEditor.SetPropEntry(Index: Integer;
  AInstance: TPersistent; APropInfo: PPropInfo);
begin
  with FPropList^[Index] do
  begin
    Instance := AInstance;
    PropInfo := APropInfo;
  end;
end;

procedure TdxPropertyEditor.SetStrValue(const Value: string);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetStrProp(Instance, PropInfo, Value);
end;

procedure TdxPropertyEditor.SetVarValue(const Value: Variant);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetVariantProp(Instance, PropInfo, Value);
end;

procedure TdxPropertyEditor.SetValue(const Value: string);
begin
end;

function TdxPropertyEditor.ValueAvailable: Boolean;
var
  I: Integer;
  S: string;
begin
  Result := True;
  for I := 0 to FPropCount - 1 do
    if (FPropList^[I].Instance is TComponent) and
      (csCheckPropAvail in TComponent(FPropList^[I].Instance).ComponentStyle) then
    begin
      try
        S := GetValue;
        AllEqual;
      except
        Result := False;
      end;
      Exit;
    end;
end;

{ TdxOrdinalProperty }

function TdxOrdinalProperty.AllEqual: Boolean;
var
  I: Integer;
  V: Longint;
begin
  Result := False;
  if PropCount > 1 then
  begin
    V := GetOrdValue;
    for I := 1 to PropCount - 1 do
      if GetOrdValueAt(I) <> V then Exit;
  end;
  Result := True;
end;

function TdxOrdinalProperty.GetEditLimit: Integer;
begin
  Result := 63;
end;

{ TdxIntegerProperty }

function TdxIntegerProperty.GetValue: string;
begin
  Result := IntToStr(GetOrdValue);
end;

procedure TdxIntegerProperty.SetValue(const Value: string);

  procedure Error(const Args: array of const);
  begin
    raise EPropertyError.CreateFmt(SOutOfRange, Args);
  end;

var
  L: {$IFDEF DELPHI4}Int64{$ELSE}Longint{$ENDIF};
begin
{$IFDEF DELPHI4}
  L := StrToInt64(Value);
{$ELSE}
  L := StrToInt(Value);
{$ENDIF}
  with GetTypeData(GetPropType)^ do
{$IFDEF DELPHI5}
    if OrdType = otULong then
    begin
      if (L < Cardinal(MinValue)) or (L > Cardinal(MaxValue)) then
        Error([Int64(Cardinal(MinValue)), Int64(Cardinal(MaxValue))]);
    end
    else
{$ENDIF}if (L < MinValue) or (L > MaxValue) then
        Error([MinValue, MaxValue]);
  SetOrdValue(L);
end;

{ TCharProperty }

function TdxCharProperty.GetValue: string;
var
  Ch: Char;
begin
  Ch := Chr(GetOrdValue);
  if Ch in [#33..#127] then
    Result := Ch
  else
    FmtStr(Result, '#%d', [Ord(Ch)]);
end;

procedure TdxCharProperty.SetValue(const Value: string);
var
  L: Longint;
begin
  if Length(Value) = 0 then
    L := 0
  else 
    if Length(Value) = 1 then
      L := Ord(Value[1])
    else 
      if Value[1] = '#' then
        L := StrToInt(Copy(Value, 2, Maxint))
      else
        raise EdxPropertyError.Create(SInvalidPropertyValue);
        
  with GetTypeData(GetPropType)^ do
    if (L < MinValue) or (L > MaxValue) then
      raise EdxPropertyError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
  SetOrdValue(L);
end;

{ TdxEnumProperty }

function TdxEnumProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

function TdxEnumProperty.GetValue: string;
var
  L: Longint;
begin
  L := GetOrdValue;
  with GetTypeData(GetPropType)^ do
    if (L < MinValue) or (L > MaxValue) then L := MaxValue;
  Result := GetEnumName(GetPropType, L);
end;

procedure TdxEnumProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  EnumType: PTypeInfo;
begin
  EnumType := GetPropType;
  with GetTypeData(EnumType)^ do
    for I := MinValue to MaxValue do
      Proc(GetEnumName(EnumType, I));
end;

procedure TdxEnumProperty.SetValue(const Value: string);
var
  I: Integer;
begin
  I := GetEnumValue(GetPropType, Value);
  if I < 0 then raise EdxPropertyError.Create(SInvalidPropertyValue);
  SetOrdValue(I);
end;

{ TdxBoolProperty  }

function TdxBoolProperty.GetValue: string;
begin
  if GetOrdValue = 0 then
    Result := 'False'
  else
    Result := 'True';
end;

procedure TdxBoolProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('False');
  Proc('True');
end;

procedure TdxBoolProperty.SetValue(const Value: string);
var
  I: Integer;
begin
  if CompareText(Value, 'False') = 0 then
    I := 0
  else 
    if CompareText(Value, 'True') = 0 then
      I := 1
    else
      I := StrToInt(Value);
  SetOrdValue(I);
end;

{$IFDEF DELPHI4}
{ TInt64Property }

function TdxInt64Property.AllEqual: Boolean;
var
  I: Integer;
  V: Int64;
begin
  Result := False;
  if PropCount > 1 then
  begin
    V := GetInt64Value;
    for I := 1 to PropCount - 1 do
      if GetInt64ValueAt(I) <> V then Exit;
  end;
  Result := True;
end;

function TdxInt64Property.GetEditLimit: Integer;
begin
  Result := 63;
end;

function TdxInt64Property.GetValue: string;
begin
  Result := IntToStr(GetInt64Value);
end;

procedure TdxInt64Property.SetValue(const Value: string);
begin
  SetInt64Value(StrToInt64(Value));
end;
{$ENDIF}

{ TdxFloatProperty }

function TdxFloatProperty.AllEqual: Boolean;
var
  I: Integer;
  V: Extended;
begin
  Result := False;
  if PropCount > 1 then
  begin
    V := GetFloatValue;
    for I := 1 to PropCount - 1 do
      if GetFloatValueAt(I) <> V then Exit;
  end;
  Result := True;
end;

function TdxFloatProperty.GetValue: string;
const
  Precisions: array[TFloatType] of Integer = (7, 15, 18, 18, 18);
begin
  Result := FloatToStrF(GetFloatValue, ffGeneral,
    Precisions[GetTypeData(GetPropType)^.FloatType], 0);
end;

procedure TdxFloatProperty.SetValue(const Value: string);
begin
  SetFloatValue(StrToFloat(Value));
end;

{ TdxStringProperty }

function TdxStringProperty.AllEqual: Boolean;
var
  I: Integer;
  V: string;
begin
  Result := False;
  if PropCount > 1 then
  begin
    V := GetStrValue;
    for I := 1 to PropCount - 1 do
      if GetStrValueAt(I) <> V then Exit;
  end;
  Result := True;
end;

function TdxStringProperty.GetEditLimit: Integer;
begin
  if GetPropType^.Kind = tkString then
    Result := GetTypeData(GetPropType)^.MaxLength
  else
    Result := 255;
end;

function TdxStringProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TdxStringProperty.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

{ TdxComponentNameProperty }

function TdxComponentNameProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [];
end;

function TdxComponentNameProperty.GetEditLimit: Integer;
begin
  Result := 63;
end;

{ TdxSetElementProperty }

constructor TdxSetElementProperty.Create(APropList: PdxInstPropList; APropCount: Integer; AElement: Integer);
begin
  FPropList := APropList;
  FPropCount := APropCount;
  FElement := AElement;
end;

destructor TdxSetElementProperty.Destroy;
begin
end;

function TdxSetElementProperty.AllEqual: Boolean;
var
  I: Integer;
  S: TdxIntegerSet;
  V: Boolean;
begin
  Result := False;
  if PropCount > 1 then
  begin
    Integer(S) := GetOrdValue;
    V := FElement in S;
    for I := 1 to PropCount - 1 do
    begin
      Integer(S) := GetOrdValueAt(I);
      if (FElement in S) <> V then Exit;
    end;
  end;
  Result := True;
end;

function TdxSetElementProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList];
end;

function TdxSetElementProperty.GetName: string;
begin
  Result := GetEnumName(GetTypeData(GetPropType)^.CompType^, FElement);
end;

function TdxSetElementProperty.GetValue: string;
var
  S: TdxIntegerSet;
begin
  Integer(S) := GetOrdValue;
  if FElement in S then
    Result := 'True'
  else
    Result := 'False';
end;

procedure TdxSetElementProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('False');
  Proc('True');
end;

procedure TdxSetElementProperty.SetValue(const Value: string);
var
  S: TdxIntegerSet;
begin
  Integer(S) := GetOrdValue;
  if CompareText(Value, 'True') = 0 then
    Include(S, FElement)
  else
    Exclude(S, FElement);
  SetOrdValue(Integer(S));
end;

{ TdxSetProperty }

function TdxSetProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSubProperties, ipaReadOnly, ipaRevertable];
end;

procedure TdxSetProperty.GetProperties(AOwner: TComponent; Proc: TdxGetPropEditProc);
var
  I: Integer;
begin
  with GetTypeData(GetTypeData(GetPropType)^.CompType^)^ do
    for I := MinValue to MaxValue do
      Proc(TdxSetElementProperty.Create(FPropList, FPropCount, I));
end;

function TdxSetProperty.GetValue: string;
var
  S: TdxIntegerSet;
  TypeInfo: PTypeInfo;
  I: Integer;
begin
  Integer(S) := GetOrdValue;
  TypeInfo := GetTypeData(GetPropType)^.CompType^;
  Result := '[';
  for I := 0 to SizeOf(Integer) * 8 - 1 do
    if I in S then
    begin
      if Length(Result) <> 1 then Result := Result + ',';
      Result := Result + GetEnumName(TypeInfo, I);
    end;
  Result := Result + ']';
end;

{ TdxClassProperty }

function TdxClassProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSubProperties, ipaReadOnly];
end;

procedure TdxClassProperty.GetProperties(AOwner: TComponent; Proc: TdxGetPropEditProc);
var
  Components: TdxComponentList;
  I: Integer;
begin
  Components := TdxComponentList.Create;
  try
    for I := 0 to PropCount - 1 do
      if TComponent(GetOrdValueAt(I)) <> nil then
        Components.Add(TComponent(GetOrdValueAt(I)));
    dxGetComponentProperties(AOwner, Components, tkProperties, Proc);
  finally
    Components.Free;
  end;
end;

function TdxClassProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

{ TdxComponentProperty }

function TdxComponentProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

function TdxComponentProperty.GetEditLimit: Integer;
begin
  Result := 127;
end;

function TdxComponentProperty.GetValue: string;
begin
  if TComponent(GetOrdValue) <> nil then
    Result := TComponent(GetOrdValue).Name
  else
    Result := '';
end;

procedure TdxComponentProperty.GetValues(Proc: TGetStrProc);

  procedure AddProc(AComponent: TComponent);
  var
    i: Integer;
  begin
    for i := 0 to AComponent.ComponentCount - 1 do
    begin
      if (AComponent.Components[i].Name <> '')
      and (AComponent.Components[i] is GetTypeData(GetPropType)^.ClassType) then
        Proc(AComponent.Components[i].Name);
      AddProc(AComponent.Components[i]);
    end;
  end;

begin
  if FOwner <> nil then
  begin
    if FOwner.Owner <> nil then
      AddProc(FOwner.Owner)
    else AddProc(FOwner);
  end else AddProc(Application);
end;

procedure TdxComponentProperty.SetValue(const Value: string);
var
  Component: TComponent;

  function GetComponentByName(Name: string): TComponent;
  begin
    Result := nil;
    if (FOwner <> nil) then
    begin
      Result := FOwner.FindComponent(Name);
      if (Result = nil) and (FOwner.Owner <> nil) then
        Result := FOwner.Owner.FindComponent(Name);
    end;
    if Result = nil then
      Result := Application.FindComponent(Name);   
  end;

begin
  if Value = '' then
    Component := nil
  else
  begin
    Component := GetComponentByName(Value);
    if not (Component is GetTypeData(GetPropType)^.ClassType) then
      raise EdxPropertyError.Create(SInvalidPropertyValue);
  end;
  SetOrdValue(Longint(Component));
end;

{ TdxFontNameProperty }

function TdxFontNameProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

procedure TdxFontNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to Screen.Fonts.Count - 1 do
    Proc(Screen.Fonts[I]);
end;

{ TdxFontCharsetProperty }

function TdxFontCharsetProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSortList, ipaValueList];
end;

function TdxFontCharsetProperty.GetValue: string;
begin
  if not CharsetToIdent(TFontCharset(GetOrdValue), Result) then
    FmtStr(Result, '%d', [GetOrdValue]);
end;

procedure TdxFontCharsetProperty.GetValues(Proc: TGetStrProc);
begin
  GetCharsetValues(Proc);
end;

procedure TdxFontCharsetProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToCharset(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;

{ TdxImeNameProperty }

function TdxImeNameProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaValueList, ipaSortList, ipaMultiSelect];
end;

procedure TdxImeNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to Screen.Imes.Count - 1 do
    Proc(Screen.Imes[I]);
end;

{ TdxMPFilenameProperty }

procedure TdxMPFilenameProperty.Edit;
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Application);
  with OpenDialog do
  try
    Filename := GetValue;
    Filter := SMPOpenFilter;
    Options := Options + [ofPathMustExist, ofFileMustExist];
    if Execute then SetValue(FileName);
  finally
    Free;
  end;
end;

function TdxMPFilenameProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaDialog, ipaRevertable];
end;

{ TdxColorProperty }

procedure TdxColorProperty.Edit;
var
  ColorDialog: TColorDialog;
  IniFile: TRegIniFile;

  procedure GetCustomColors;
  begin
    IniFile := TRegIniFile.Create('\Software\Borland\Delphi\3.0');
    try
      IniFile.ReadSectionValues(SCustomColors,
        ColorDialog.CustomColors);
    except
      { Ignore errors reading values }
    end;
  end;

  procedure SaveCustomColors;
  var
    I, P: Integer;
    S: string;
  begin
    if IniFile <> nil then
      with ColorDialog do
        for I := 0 to CustomColors.Count - 1 do
        begin
          S := CustomColors.Strings[I];
          P := Pos('=', S);
          if P <> 0 then
          begin
            S := Copy(S, 1, P - 1);
            IniFile.WriteString(SCustomColors, S,
              CustomColors.Values[S]);
          end;
        end;
  end;

begin
  IniFile := nil;
  ColorDialog := TColorDialog.Create(Application);
  with ColorDialog do
  try
    GetCustomColors;
    Color := GetOrdValue;
    if Execute then SetOrdValue(Color);
    SaveCustomColors;
  finally
    if IniFile <> nil then IniFile.Free;
    Free;
  end;
end;

function TdxColorProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaDialog, ipaValueList, ipaRevertable];
end;

function TdxColorProperty.GetValue: string;
begin
  Result := ColorToString(TColor(GetOrdValue));
end;

procedure TdxColorProperty.GetValues(Proc: TGetStrProc);
begin
  GetColorValues(Proc);
end;

procedure TdxColorProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToColor(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;

{ TdxCursorProperty }

function TdxCursorProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

function TdxCursorProperty.GetValue: string;
begin
  Result := CursorToString(TCursor(GetOrdValue));
end;

procedure TdxCursorProperty.GetValues(Proc: TGetStrProc);
begin
  GetCursorValues(Proc);
end;

procedure TdxCursorProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToCursor(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;

{ TdxFontProperty }

procedure TdxFontProperty.Edit;
var
  FontDialog: TFontDialog;
begin
  FontDialog := TFontDialog.Create(Application);
  try
    FontDialog.Font := TFont(GetOrdValue);
    FontDialog.Options := FontDialog.Options + [fdForceFontExist];
    if FontDialog.Execute then SetOrdValue(Longint(FontDialog.Font));
  finally
    FontDialog.Free;
  end;
end;



function TdxFontProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSubProperties, ipaDialog, ipaReadOnly];
end;


{TdxStringsProperty}

procedure TdxStringsProperty.Edit;
var
  Data: TdxStringsEditorDlgData;
begin
  Data.Caption := GetComponent(0).GetNamePath + '.' + GetName;
  Data.Text := TStrings(GetOrdValue).Text;
  if ShowdxStringsEditor(@Data) then 
    TStrings(GetOrdValue).Text := Data.Text;
end;

function TdxStringsProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaDialog, ipaReadOnly];
end;

{ TdxGraphicProperty }

procedure TdxGraphicProperty.Edit;
var
  Data: TdxPictureEditorDlgData;
  P: TPicture;
begin
  P := TPicture.Create;
  try
    P.Assign(GetGraphic);
    with Data do 
    begin
      Caption := GetComponent(0).GetNamePath + '.' + GetName;
      ClipboardFormat := GetClipboardFormat;
      GraphicFilter := GetGraphicFilter;
      Picture := P;
    end;
    if ShowdxPictureEditor(@Data) then SetGraphic(P.Graphic);
  finally
    P.Free;
  end;  
end;

function TdxGraphicProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaDialog];
end;

function TdxGraphicProperty.HasGraphic: Boolean;
begin
  Result := (GetGraphic <> nil) and not GetGraphic.Empty;
end;

function TdxGraphicProperty.GraphicClass: TGraphicClass;
begin
  if GetGraphic = nil then
    Result := nil
  else
    Result := TGraphicClass(GetGraphic.ClassType);
end;

function TdxGraphicProperty.GetGraphicFilter: string;
begin
  if GraphicClass = nil then 
    Result := GraphicFilter(TGraphic)  
  else
    Result := GraphicFilter(GraphicClass);
end;

function TdxGraphicProperty.GetClipboardFormat: Word;
begin
  Result := CF_PICTURE;
  if GraphicClass <> nil then 
    if GraphicClass.InheritsFrom(TBitmap) then 
      Result := CF_BITMAP
    else
      if GraphicClass.InheritsFrom(TMetafile) then     
        Result := CF_METAFILEPICT;
end;

function TdxGraphicProperty.GetGraphic: TGraphic;
begin
  Result := TGraphic(GetOrdValue);
end;

procedure TdxGraphicProperty.SetGraphic(Value: TGraphic);
begin
  GetGraphic.Assign(Value);
end;

function TdxGraphicProperty.GetValue: string;
begin
  if HasGraphic then 
    Result := '(' + GetGraphic.ClassName + ')'
  else
    Result := '(None)';
end;

procedure TdxGraphicProperty.SetValue(const Value: string);
begin
  if Value = '' then SetGraphic(nil);
end;


{TdxPictureProperty}

function TdxPictureProperty.GetGraphic: TGraphic;
begin
  if GetOrdValue = 0 then
    Result := nil
  else  
    Result := TPicture(GetOrdValue).Graphic;
end;

procedure TdxPictureProperty.SetGraphic(Value: TGraphic);
begin
  TPicture(GetOrdValue).Assign(Value);
end;

{ TdxModalResultProperty }

const
  dxModalResults: array[mrNone..mrYesToAll] of string = (
    'mrNone',
    'mrOk',
    'mrCancel',
    'mrAbort',
    'mrRetry',
    'mrIgnore',
    'mrYes',
    'mrNo',
    'mrAll',
    'mrNoToAll',
    'mrYesToAll');

function TdxModalResultProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaRevertable];
end;

function TdxModalResultProperty.GetValue: string;
var
  CurValue: Longint;
begin
  CurValue := GetOrdValue;
  case CurValue of
    Low(dxModalResults)..High(dxModalResults):
      Result := dxModalResults[CurValue];
  else
    Result := IntToStr(CurValue);
  end;
end;

procedure TdxModalResultProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(dxModalResults) to High(dxModalResults) do
    Proc(dxModalResults[I]);
end;

procedure TdxModalResultProperty.SetValue(const Value: string);
var
  I: Integer;
begin
  if Value = '' then
  begin
    SetOrdValue(0);
    Exit;
  end;
  for I := Low(dxModalResults) to High(dxModalResults) do
    if CompareText(dxModalResults[I], Value) = 0 then
    begin
      SetOrdValue(I);
      Exit;
    end;
  inherited SetValue(Value);
end;

{ TdxShortCutProperty }

const
  dxShortCuts: array[0..82] of TShortCut = (
    scNone,
    Byte('A') or scCtrl,
    Byte('B') or scCtrl,
    Byte('C') or scCtrl,
    Byte('D') or scCtrl,
    Byte('E') or scCtrl,
    Byte('F') or scCtrl,
    Byte('G') or scCtrl,
    Byte('H') or scCtrl,
    Byte('I') or scCtrl,
    Byte('J') or scCtrl,
    Byte('K') or scCtrl,
    Byte('L') or scCtrl,
    Byte('M') or scCtrl,
    Byte('N') or scCtrl,
    Byte('O') or scCtrl,
    Byte('P') or scCtrl,
    Byte('Q') or scCtrl,
    Byte('R') or scCtrl,
    Byte('S') or scCtrl,
    Byte('T') or scCtrl,
    Byte('U') or scCtrl,
    Byte('V') or scCtrl,
    Byte('W') or scCtrl,
    Byte('X') or scCtrl,
    Byte('Y') or scCtrl,
    Byte('Z') or scCtrl,
    VK_F1,
    VK_F2,
    VK_F3,
    VK_F4,
    VK_F5,
    VK_F6,
    VK_F7,
    VK_F8,
    VK_F9,
    VK_F10,
    VK_F11,
    VK_F12,
    VK_F1 or scCtrl,
    VK_F2 or scCtrl,
    VK_F3 or scCtrl,
    VK_F4 or scCtrl,
    VK_F5 or scCtrl,
    VK_F6 or scCtrl,
    VK_F7 or scCtrl,
    VK_F8 or scCtrl,
    VK_F9 or scCtrl,
    VK_F10 or scCtrl,
    VK_F11 or scCtrl,
    VK_F12 or scCtrl,
    VK_F1 or scShift,
    VK_F2 or scShift,
    VK_F3 or scShift,
    VK_F4 or scShift,
    VK_F5 or scShift,
    VK_F6 or scShift,
    VK_F7 or scShift,
    VK_F8 or scShift,
    VK_F9 or scShift,
    VK_F10 or scShift,
    VK_F11 or scShift,
    VK_F12 or scShift,
    VK_F1 or scShift or scCtrl,
    VK_F2 or scShift or scCtrl,
    VK_F3 or scShift or scCtrl,
    VK_F4 or scShift or scCtrl,
    VK_F5 or scShift or scCtrl,
    VK_F6 or scShift or scCtrl,
    VK_F7 or scShift or scCtrl,
    VK_F8 or scShift or scCtrl,
    VK_F9 or scShift or scCtrl,
    VK_F10 or scShift or scCtrl,
    VK_F11 or scShift or scCtrl,
    VK_F12 or scShift or scCtrl,
    VK_INSERT,
    VK_INSERT or scShift,
    VK_INSERT or scCtrl,
    VK_DELETE,
    VK_DELETE or scShift,
    VK_DELETE or scCtrl,
    VK_BACK or scAlt,
    VK_BACK or scShift or scAlt);

function TdxShortCutProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaRevertable];
end;

function TdxShortCutProperty.GetValue: string;
var
  CurValue: TShortCut;
begin
  CurValue := GetOrdValue;
  if CurValue = scNone then
    Result := srNone
  else
    Result := ShortCutToText(CurValue);
end;

procedure TdxShortCutProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  Proc(srNone);
  for I := 1 to High(dxShortCuts) do
    Proc(ShortCutToText(dxShortCuts[I]));
end;

procedure TdxShortCutProperty.SetValue(const Value: string);
var
  NewValue: TShortCut;
begin
  NewValue := 0;
  if (Value <> '') and (AnsiCompareText(Value, srNone) <> 0) then
  begin
    NewValue := TextToShortCut(Value);
    if NewValue = 0 then
      raise EdxPropertyError.Create(SInvalidPropertyValue);
  end;
  SetOrdValue(NewValue);
end;

{ TdxTabOrderProperty }

function TdxTabOrderProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [];
end;

{ TdxCaptionProperty }

function TdxCaptionProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaAutoUpdate, ipaRevertable];
end;

{ TdxDateProperty }

function TdxDateProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaRevertable];
end;

function TdxDateProperty.GetValue: string;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := DateToStr(DT);
end;

procedure TdxDateProperty.SetValue(const Value: string);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToDate(Value);
  SetFloatValue(DT);
end;

{ TdxTimeProperty }

function TdxTimeProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaRevertable];
end;

function TdxTimeProperty.GetValue: string;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := TimeToStr(DT);
end;

procedure TdxTimeProperty.SetValue(const Value: string);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToTime(Value);
  SetFloatValue(DT);
end;

function TdxDateTimeProperty.GetAttributes: TdxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaRevertable];
end;

function TdxDateTimeProperty.GetValue: string;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := DateTimeToStr(DT);
end;

procedure TdxDateTimeProperty.SetValue(const Value: string);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToDateTime(Value);
  SetFloatValue(DT);
end;

{ TdxPropInfoList }

type
  TdxPropInfoList = class
  private
    FList: PPropList;
    FCount: Integer;
    FSize: Integer;
    function Get(Index: Integer): PPropInfo;
  public
    constructor Create(Instance: TPersistent; Filter: TTypeKinds);
    destructor Destroy; override;
    
    function Contains(P: PPropInfo): Boolean;
    procedure Delete(Index: Integer);
    procedure Intersect(List: TdxPropInfoList);
    
    property Count: Integer read FCount;
    property Items[Index: Integer]: PPropInfo read Get; default;
  end;

constructor TdxPropInfoList.Create(Instance: TPersistent; Filter: TTypeKinds);
begin
  FCount := GetPropList(Instance.ClassInfo, Filter, nil);
  FSize := FCount * SizeOf(Pointer);
  GetMem(FList, FSize);
  GetPropList(Instance.ClassInfo, Filter, FList);
end;

destructor TdxPropInfoList.Destroy;
begin
  if FList <> nil then FreeMem(FList, FSize);
  inherited Destroy;
end;

function TdxPropInfoList.Contains(P: PPropInfo): Boolean;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    with FList^[I]^ do
      if (PropType^ = P^.PropType^) and (CompareText(Name, P^.Name) = 0) then
      begin
        Result := True;
        Exit;
      end;
  Result := False;
end;

procedure TdxPropInfoList.Delete(Index: Integer);
begin
  Dec(FCount);
  if Index < FCount then
    Move(FList^[Index + 1], FList^[Index], (FCount - Index) * SizeOf(Pointer));
end;

function TdxPropInfoList.Get(Index: Integer): PPropInfo;
begin
  Result := FList^[Index];
end;

procedure TdxPropInfoList.Intersect(List: TdxPropInfoList);
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if not List.Contains(FList^[I]) then Delete(I);
end;

{ GetComponentProperties }

procedure dxRegisterPropertyEditor(APropertyType: PTypeInfo; AComponentClass: TClass;
  const APropertyName: string; AEditorClass: TdxPropertyEditorClass);
var
  Item: TdxPropertyClassRec;
begin
  if FPropertyClasses = nil then FPropertyClasses := TList.Create;
  Item := TdxPropertyClassRec.Create;
  with Item do 
  begin
    Group := CurrentGroup;
    PropertyType := APropertyType;
    ComponentClass := AComponentClass;
    PropertyName := '';
    if ComponentClass <> nil then PropertyName := APropertyName;
    EditorClass := AEditorClass;
  end;  
  FPropertyClasses.Insert(0, Item);
end;

procedure dxRegisterPropertyMapper(AMapper: TdxPropertyMapperFunc);
var
  Item: TdxPropertyMapperRec;
begin
  if FPropertyMappers = nil then
    FPropertyMappers := TList.Create;
  Item := TdxPropertyMapperRec.Create;
  Item.Group := CurrentGroup;
  Item.Mapper := AMapper;
  FPropertyMappers.Insert(0, Item);
end;

function dxGetEditorClass(APropInfo: PPropInfo; Obj: TPersistent): TdxPropertyEditorClass;
var
  PropType: PTypeInfo;
  P, C: TdxPropertyClassRec;
  I: Integer;
begin
  if FPropertyMappers <> nil then
    for I := 0 to FPropertyMappers.Count - 1 do
      with TdxPropertyMapperRec(FPropertyMappers[I]) do
      begin
        Result := Mapper(Obj, APropInfo);
        if Result <> nil then Exit;
      end;

  PropType := APropInfo^.PropType^;
  I := 0;
  C := nil;

  if FPropertyClasses <> nil then
    while I < FPropertyClasses.Count do
    begin
      P := FPropertyClasses[I];
      if ((P.PropertyType = PropType) or ((PropType^.Kind = tkClass) and
        (P.PropertyType^.Kind = tkClass) and
        GetTypeData(PropType)^.ClassType.InheritsFrom(GetTypeData(P.PropertyType)^.ClassType))) and
        ((P.ComponentClass = nil) or (Obj.InheritsFrom(P.ComponentClass))) and
        ((P.PropertyName = '') or (CompareText(APropInfo^.Name, P.PropertyName) = 0)) then
        if (C = nil) or ((C.ComponentClass = nil) and (P.ComponentClass <> nil))
          or ((C.PropertyName = '') and (P.PropertyName <> '')) then
          C := P;
      Inc(I);
    end;

  if C <> nil then
    Result := C.EditorClass
  else
    Result := dxPropClassMap[PropType^.Kind];
end;

procedure dxGetComponentProperties(AOwner: TComponent; AComponents: TdxComponentList;
  AFilter: TTypeKinds; AProc: TdxGetPropEditProc);
var
  I, J, CompCount: Integer;
  CompType: TClass;
  Candidates: TdxPropInfoList;
  PropLists: TList;
  Editor: TdxPropertyEditor;
  EdClass: TdxPropertyEditorClass;
  PropInfo: PPropInfo;
  AddEditor: Boolean;
  Obj: TPersistent;
begin
  if (AComponents = nil) or (AComponents.Count = 0) then Exit;
  CompCount := AComponents.Count;
  Obj := AComponents[0];
  CompType := AComponents[0].ClassType;
  Candidates := TdxPropInfoList.Create(AComponents[0], AFilter);
  try
    for I := Candidates.Count - 1 downto 0 do
    begin
      PropInfo := Candidates[I];
      EdClass := dxGetEditorClass(PropInfo, AComponents[0]);
      if EdClass = nil then
        Candidates.Delete(I)
      else
      begin
        Editor := EdClass.Create(AOwner, 1);
        try
          Editor.SetPropEntry(0, Obj, PropInfo);
          with PropInfo^ do
            if (GetProc = nil) or 
              ((PropType^.Kind <> tkClass) and (SetProc = nil)) or 
              ((CompCount > 1) and  not (ipaMultiSelect in Editor.GetAttributes)) or
              not Editor.ValueAvailable then
              Candidates.Delete(I);
        finally
          Editor.Free;
        end;
      end;
    end;
    
    PropLists := TList.Create;
    try
      PropLists.Capacity := CompCount;
      for I := 0 to CompCount - 1 do
        PropLists.Add(TdxPropInfoList.Create(AComponents[I], AFilter));
      for I := 0 to CompCount - 1 do
        Candidates.Intersect(TdxPropInfoList(PropLists[I]));
      for I := 0 to CompCount - 1 do
        TdxPropInfoList(PropLists[I]).Intersect(Candidates);
      for I := 0 to Candidates.Count - 1 do
      begin
        EdClass := dxGetEditorClass(Candidates[I], Obj);
        if EdClass = nil then Continue;
        Editor := EdClass.Create(AOwner, CompCount);
        try
          AddEditor := True;
          for J := 0 to CompCount - 1 do
          begin
            if (AComponents[J].ClassType <> CompType) and
              (dxGetEditorClass(TdxPropInfoList(PropLists[J])[I], AComponents[J]) <> Editor.ClassType) then
            begin
              AddEditor := False;
              Break;
            end;
            Editor.SetPropEntry(J, AComponents[J], TdxPropInfoList(PropLists[J])[I]);
          end;
        except
          Editor.Free;
          raise;
        end;
        if AddEditor and Editor.ValueAvailable and Assigned(AProc) then
          AProc(Editor)
        else   
          Editor.Free
      end;
    finally
      for I := 0 to PropLists.Count - 1 do
        TdxPropInfoList(PropLists[I]).Free;
      PropLists.Free;
    end;
  finally
    Candidates.Free;
  end;
end;


{ = ========================================================================== }
{ TCustomdxRTTIInspector class implementation                                      }
{ = ========================================================================== }
constructor TCustomdxRTTIInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ShowRowHint := True;
  Options := Options + [ioDynamicColumnSizing];
  PaintStyle := ipsExtended;
end;

destructor TCustomdxRTTIInspector.Destroy;
begin
  ReleaseComponentProperties;
  inherited Destroy;
end;

procedure TCustomdxRTTIInspector.DblClick;
var
  Pt: TPoint;
begin
  GetCursorPos(Pt);
  if GetHitInfo(ScreenToClient(Pt)).HitType = ihtLabel then
    TryInvokePropertyEditorDlg;
  inherited DblClick;
end;

procedure TCustomdxRTTIInspector.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ssCtrl in Shift) then 
    TryInvokePropertyEditorDlg;
  inherited KeyDown(Key, Shift);
end;

procedure TCustomdxRTTIInspector.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (AComponent = InspectedObject) then 
    InspectedObject := nil;
end;

procedure TCustomdxRTTIInspector.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then
    CreatePropertyRows(nil);
end;

procedure TCustomdxRTTIInspector.DoDrawCaption(ACanvas: TCanvas; ANode: TdxInspectorNode;
  AIndentRect, AButtonRect, AImageRect : TRect; AButtonKind: TdxInspectorButtonKind;
  ADisplayRect: TRect; var AText: string);
begin
  if ANode.Count > 0 then
    ACanvas.Font.Style := [fsBold];
  inherited DoDrawCaption(ACanvas, ANode, AIndentRect, AButtonRect, AImageRect, AButtonKind, 
    ADisplayRect, AText);
end;

procedure TCustomdxRTTIInspector.DoPropertyChanged;
begin
  if Assigned(FOnPropertyChanged) then FOnPropertyChanged(Self);
end;

procedure TCustomdxRTTIInspector.DoEditChange(Sender: TObject);
begin
  inherited DoEditChange(Sender);
  if (PropertyEditor <> nil) and (ipaAutoUpdate in PropertyEditor.GetAttributes) then
    PropertyEditor.Value := TdxInplaceTextEdit(InplaceEditor).Text;
  DoPropertyChanged;    
end;

procedure TCustomdxRTTIInspector.DoEditValidate(Sender: TObject; var ErrorText: string; 
  var Accept: Boolean);
var
  S: string;  
begin
  inherited DoEditValidate(Sender, ErrorText, Accept);
  if Accept and (PropertyEditor <> nil) then 
  begin
    S := PropertyEditor.Value;
    try
      PropertyEditor.Value := TdxInplaceTextEdit(InplaceEditor).Text;
    except
      PropertyEditor.Value := S;
      Accept := False;
      TdxInplaceTextEdit(InplaceEditor).Text := S;
      raise;
    end;
    DoPropertyChanged;        
    RefreshInspectedProperties;
  end;   
end;

procedure TCustomdxRTTIInspector.PickRowCloseUp(Sender: TObject; var Value: Variant; 
  var Accept: Boolean);
begin
  if Accept then 
  begin
    PropertyEditor.Value := Value;
    DoPropertyChanged;    
    RefreshInspectedProperties;
  end
  else  
  begin
    Value := PropertyEditor.Value;
    Accept:= True;
  end;  
end;

function TCustomdxRTTIInspector.GetFocusedRow: TdxInspectorRow;
begin
  if FocusedNode <> nil then 
    Result := TdxInspectorRowNode(FocusedNode).Row
  else
    Result := nil;
end;

procedure TCustomdxRTTIInspector.SetFocusedRow(Value: TdxInspectorRow);
var
  I: Integer;
  Node: TdxInspectorNode;
begin
  if Value = nil then Exit;
  for I := 0 to TotalRowCount - 1 do 
    if Rows[I].Node = Value.Node then 
    begin
      SetFocusedNode(Value.Node);
      Node := Value.Node.Parent;
      while Node <> nil do 
      begin
        Node.Expanded := True;
        Node := Node.Parent;
      end;
      Rows[I].Node.MakeVisible;
      Break;
    end;
end;


function TCustomdxRTTIInspector.GetPropertyEditor: TdxPropertyEditor;
begin
  if FocusedRow <> nil then 
    Result := TdxPropertyEditor(FocusedRow.Tag)
  else
    Result := nil;
end;

procedure TCustomdxRTTIInspector.CreatePropertyRows(OldInspectedObject: TPersistent);
var
  PropName: string;
begin
  PropName := '';
  BeginUpdate;
  try
    if OldInspectedObject <> nil then
    begin
      if PropertyEditor <> nil then PropName := PropertyEditor.GetName;
      ReleaseComponentProperties;
    end;

    if FInspectedObject <> nil then
    begin
      GetComponentsProperties([FInspectedObject]);
      if PropName <> '' then
        FocusRowByPropertyName(PropName);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxRTTIInspector.SetInspectedObject(Value: TPersistent);
var
  OldInspectedObject: TPersistent;
begin
  if FInspectedObject <> Value then
  begin
    if not (csDestroying in ComponentState) then
      OldInspectedObject := FInspectedObject
    else OldInspectedObject := nil;
    FInspectedObject := Value;
    if (FInspectedObject <> nil) and (FInspectedObject is TComponent) then
      TComponent(Value).FreeNotification(Self);
    if not ((csDesigning in ComponentState) or (csLoading in ComponentState)
    or (csDestroying in ComponentState)) then
      CreatePropertyRows(OldInspectedObject);
  end;
end;

function TCustomdxRTTIInspector.CanInvokePropertyEditorDlg: Boolean;
begin
  Result := (PropertyEditor <> nil) and
    ((ipaDialog in PropertyEditor.GetAttributes) or (ipaValueList in PropertyEditor.GetAttributes));
end;

procedure TCustomdxRTTIInspector.TryInvokePropertyEditorDlg;
begin
  if CanInvokePropertyEditorDlg then
  begin
    PropertyEditor.Edit;
    DoEditChange(self);
    RefreshInspectedProperties;
  end;  
end;

procedure TCustomdxRTTIInspector.GetStrProc(const S: string);
begin
  TdxInspectorTextPickRow(FCurrentRow).Items.Add(S);
end;

procedure TCustomdxRTTIInspector.CreateRows(PropertyEditor: TdxPropertyEditor);
var
  RowClass: TdxInspectorRowClass;
  PropertyAttributes: TdxPropertyAttributes;
begin
  RowClass := GetRowClass(PropertyEditor);
  if RowClass = nil then Exit;
  FCurrentRow := CreateRow(RowClass);
  
  PropertyAttributes := PropertyEditor.GetAttributes;

  FCurrentRow.Caption := PropertyEditor.GetName;
  FCurrentRow.EditText := PropertyEditor.Value;
  FCurrentRow.MaxLength := PropertyEditor.GetEditLimit;
  FCurrentRow.ReadOnly := 
    ([ipaReadOnly, ipaSubProperties] * PropertyAttributes <> []);
  FCurrentRow.Tag := Integer(PropertyEditor);
    
  if FCurrentRow is TdxInspectorTextPickRow then
  begin
    PropertyEditor.GetValues(GetStrProc);
    with TdxInspectorTextPickRow(FCurrentRow) do 
    begin 
      ImmediateDropDown := False;
      Revertable := False;
      PopupBorder := pbSingle;
      OnCloseUp := PickRowCloseUp;
    end;  
  end;  
  if FCurrentRow is TdxInspectorTextButtonRow then
    TdxInspectorTextButtonRow(FCurrentRow).OnButtonClick := RowButtonClick;

  FCurrentRow.Node.MoveTo(FParentNode, inaAddChild);
  if ipaSubProperties in PropertyAttributes then
  begin
    FParentNode := FCurrentRow.Node;
    PropertyEditor.GetProperties(PropertyEditor.FOwner, CreateRows); 
    FParentNode := FParentNode.Parent;
  end;  
end;

procedure TCustomdxRTTIInspector.GetComponentsProperties(const AInstances: array of TPersistent);

  function FindRootOwner(APersistent: TPersistent): TComponent;
  begin
    if (APersistent is TComponent) then
      Result := TComponent(APersistent).Owner
    else Result := nil;
    if Result <> nil then
      while (Result.Owner <> nil) and not (Result is TDataModule) and
        not (Result is TCustomForm) and not (Result is TCustomFrame) do
        Result := Result.Owner;
  end;

var
  ComponentList: TdxComponentList;
  I: Integer;
  AOwner: TComponent;
begin
  ComponentList := TdxComponentList.Create;
  try
    AOwner := FindRootOwner(AInstances[Low(AInstances)]);
    for I := Low(AInstances) to High(AInstances) do
    begin
      ComponentList.Add(TPersistent(AInstances[I]));
      if (AOwner <> nil) then
      begin
        if FindRootOwner(AInstances[I]) <> AOwner then
          AOwner := nil;
      end else AOwner := nil;
    end;
    if AOwner = nil then
      AOwner := self;
    dxGetComponentProperties(AOwner, ComponentList, tkProperties, CreateRows);
    FullCollapse;
    FParentNode := nil;
    FCurrentRow := nil;
  finally
    ComponentList.Free;
  end;
end;

procedure TCustomdxRTTIInspector.ReleaseComponentProperties;
var
  I: Integer;
begin
  for I := 0 to TotalRowCount - 1 do
    with Rows[I] do
    begin
      if (Tag <> 0) and (TObject(Tag) is TdxPropertyEditor) then
      begin
        TdxPropertyEditor(Tag).Free;
        Tag := 0;
      end;
    end;
  if not (csDestroying in ComponentState) then
    ClearRows;
end;
    
procedure TCustomdxRTTIInspector.RowButtonClick(Sender: TObject; AbsoluteIndex: Integer);
begin
  TryInvokePropertyEditorDlg;
end;

function TCustomdxRTTIInspector.FilterProperty(const PropertyName: string): Boolean;
begin
  Result := True;
  if Assigned(FOnFilterProperty) then FOnFilterProperty(Self, PropertyName, Result);
end;

procedure TCustomdxRTTIInspector.FocusRowByPropertyName(const APropertyName: string);
var
  Row: TdxInspectorRow;
begin
  Row := FindRowByPropertyName(APropertyName);
  if (Row = nil) and (TotalRowCount > 0) then Row := Rows[0];
  FocusedRow := Row;
end;

function TCustomdxRTTIInspector.FindRowByPropertyName(const APropertyName: string): TdxInspectorRow;
var
  I: Integer;
begin
  if APropertyName <> '' then 
    for I := 0 to TotalRowCount - 1 do 
    begin
      Result := Rows[I];
      if CompareText(APropertyName, TdxPropertyEditor(Result.Tag).GetName) = 0 then 
        Exit;
    end;
  Result := nil;
end;

function TCustomdxRTTIInspector.GetRowClass(APropertyEditor: TdxPropertyEditor): TdxInspectorRowClass;
begin
  if FilterProperty(APropertyEditor.GetName) then 
  begin
    Result := dxGetRowClassByEditor(APropertyEditor);
    if ipaDialog in APropertyEditor.GetAttributes then
      Result := TdxInspectorTextButtonRow;
    if ipaValueList in APropertyEditor.GetAttributes then 
      Result := TdxInspectorTextPickRow;  
    if Result = nil then 
      Result := TdxInspectorTextRow
  end    
  else
    Result := nil;    
end;

procedure TCustomdxRTTIInspector.RefreshInspectedProperties;
var 
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to TotalRowCount - 1 do
      Rows[I].EditText := TdxPropertyEditor(Rows[I].Tag).GetValue;
  finally    
    EndUpdate;
  end;  
end;

initialization
  dxRegisterPropertyEditor(TypeInfo(TColor), nil, '', TdxColorProperty);
  dxRegisterPropertyEditor(TypeInfo(TFont), nil, '', TdxFontProperty);
  dxRegisterPropertyEditor(TypeInfo(TFontCharset), nil, '', TdxFontCharsetProperty);
  dxRegisterPropertyEditor(TypeInfo(TFontName), nil, '', TdxFontNameProperty);
  dxRegisterPropertyEditor(TypeInfo(TCursor), nil, '', TdxCursorProperty);
  dxRegisterPropertyEditor(TypeInfo(string), TMediaPlayer, 'FileName', TdxMPFilenameProperty);
  dxRegisterPropertyEditor(TypeInfo(TCaption), nil, '', TdxCaptionProperty);
  dxRegisterPropertyEditor(TypeInfo(TComponent), nil, '', TdxComponentProperty);
  dxRegisterPropertyEditor(TypeInfo(TComponentName), nil, '', TdxComponentNameProperty);
  dxRegisterPropertyEditor(TypeInfo(TImeName), nil, '', TdxImeNameProperty);
  dxRegisterPropertyEditor(TypeInfo(TModalResult), nil, '', TdxModalResultProperty);
  dxRegisterPropertyEditor(TypeInfo(TShortCut), nil, '', TdxShortCutProperty);
  dxRegisterPropertyEditor(TypeInfo(TTabOrder), nil, '', TdxTabOrderProperty);
  dxRegisterPropertyEditor(TypeInfo(TDate), nil, '', TdxDateProperty);
  dxRegisterPropertyEditor(TypeInfo(TTime), nil, '', TdxTimeProperty);
  dxRegisterPropertyEditor(TypeInfo(TDateTime), nil, '', TdxDateTimeProperty);
  dxRegisterPropertyEditor(TypeInfo(Boolean), nil, '', TdxBoolProperty);
  dxRegisterPropertyEditor(TypeInfo(TStrings), nil, '', TdxStringsProperty);
  dxRegisterPropertyEditor(TypeInfo(TPicture), nil, '', TdxPictureProperty);
  dxRegisterPropertyEditor(TypeInfo(TBitmap), nil, '', TdxGraphicProperty);

//  dxRegisterRowClass(TdxBoolProperty, TdxInspectorTextCheckRow);
  dxRegisterRowClass(TdxCaptionProperty, TdxInspectorTextRow);
  dxRegisterRowClass(TdxColorProperty, TdxInspectorTextPickRow);
  dxRegisterRowClass(TdxComponentNameProperty, TdxInspectorTextRow);
  dxRegisterRowClass(TdxComponentProperty, TdxInspectorTextPickRow);
  dxRegisterRowClass(TdxCursorProperty, TdxInspectorTextPickRow);
  dxRegisterRowClass(TdxDateProperty, TdxInspectorTextDateRow);
  dxRegisterRowClass(TdxDateTimeProperty, TdxInspectorTextRow);
  dxRegisterRowClass(TdxFontCharsetProperty, TdxInspectorTextPickRow);
  dxRegisterRowClass(TdxFontNameProperty, TdxInspectorTextPickRow);
  dxRegisterRowClass(TdxFontProperty, TdxInspectorTextRow);
  dxRegisterRowClass(TdxIntegerProperty, TdxInspectorTextSpinRow);
  dxRegisterRowClass(TdxImeNameProperty, TdxInspectorTextRow);
  dxRegisterRowClass(TdxModalResultProperty, TdxInspectorTextPickRow);
  dxRegisterRowClass(TdxMPFilenameProperty, TdxInspectorTextRow);
  dxRegisterRowClass(TdxPictureProperty, TdxInspectorTextButtonRow);
//  dxRegisterRowClass(TdxSetElementProperty, TdxInspectorTextCheckRow);
  dxRegisterRowClass(TdxShortCutProperty, TdxInspectorTextPickRow);
  dxRegisterRowClass(TdxStringsProperty, TdxInspectorTextButtonRow);
  dxRegisterRowClass(TdxTabOrderProperty, TdxInspectorTextSpinRow);
  dxRegisterRowClass(TdxTimeProperty, TdxInspectorTextTimeRow);

finalization
  ListFreeAndNil(FRowClasses);
  ListFreeAndNil(FPropertyClasses);
  ListFreeAndNil(FPropertyMappers);  

end.

