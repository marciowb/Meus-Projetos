{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressVerticalGrid                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSVERTICALGRID AND ALL           }
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
unit cxOI;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, TypInfo, RTLConsts,
  dxCore, dxMessages, cxGraphics, cxClasses, cxControls, cxEdit, cxInplaceContainer, cxVGrid;

type
  TcxPropertyEditor = class;
  TcxRTTIInspectorController = class;
  TcxCustomRTTIInspector = class;

  { TcxComponentList }

  TcxComponentList = class(TObject)
  private
    FList: TList;
    function GetItem(Index: Integer): TPersistent;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(Item: TPersistent): Integer;
    function Equals(List: TcxComponentList): Boolean;{$IFDEF DELPHI12}reintroduce;{$ENDIF}

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPersistent read GetItem; default;
  end;

  TcxPropertyAttribute =
    (ipaValueList, ipaSubProperties, ipaDialog, ipaMultiSelect, ipaAutoUpdate,
     ipaSortList, ipaReadOnly, ipaRevertable);
  TcxPropertyAttributes = set of TcxPropertyAttribute;

  TcxInstProp = record
    Instance: TPersistent;
    PropInfo: PPropInfo;
  end;

  PcxInstPropList = ^TcxInstPropList;
  TcxInstPropList = array[0..1023] of TcxInstProp;

  TcxGetPropEditProc = procedure(APropertyEditor: TcxPropertyEditor) of object;

  { TcxPropertyEditor }

  TcxPropertyEditor = class
  private
    FInspector: TcxCustomRTTIInspector;
    FAncestorList: TList;
    FPropCount: Integer;
    FPropList: PcxInstPropList;
    FOwner: TComponent;
    FRoot: TComponent;
    FAncestor: TPersistent;
    FRootAncestor: TComponent;
    FLookingFor: TComponent;
    FDoneLooking: Boolean;
    procedure AddAncestor(Component: TComponent);
    procedure GetLookupInfo(var Ancestor: TPersistent;
      var Root, LookupRoot, RootAncestor: TComponent);
    procedure SetPropEntry(Index: Integer; AInstance: TPersistent;
      APropInfo: PPropInfo);
    procedure WriteComponentSimulation(Component: TComponent);
  protected
    procedure AdjustInnerEditProperties(AProperties: TcxCustomEditProperties); virtual;
    function GetFloatValue: Extended;
    function GetFloatValueAt(Index: Integer): Extended;
    function GetInt64Value: Int64;
    function GetInt64ValueAt(Index: Integer): Int64;
    function GetOrdValue: Longint;
    function GetOrdValueAt(Index: Integer): Longint;
    function GetPropInfo: PPropInfo;
    function GetStrValue: string;
    function GetStrValueAt(Index: Integer): string;
    function GetVarValue: Variant;
    function GetVarValueAt(Index: Integer): Variant;
    function FindRoot: TComponent;
    procedure PostChangedNotification;
    procedure SetFloatValue(Value: Extended);
    procedure SetInt64Value(Value: Int64);
    procedure SetOrdValue(Value: Longint);
    procedure SetStrValue(const Value: string);
    procedure SetVarValue(const Value: Variant);

    property Inspector: TcxCustomRTTIInspector read FInspector;
    property PropList: PcxInstPropList read FPropList;
  public
    constructor Create(AOwner: TComponent; AInspector: TcxCustomRTTIInspector;
      APropCount: Integer);
    destructor Destroy; override;

    function AllEqual: Boolean; virtual;
    procedure Edit; virtual;
    function GetAttributes: TcxPropertyAttributes; virtual;
    function GetComponent(Index: Integer): TPersistent;
    function GetEditLimit: Integer; virtual;
    function GetName: string; virtual;
    procedure GetProperties(AOwner: TComponent; Proc: TcxGetPropEditProc); virtual;
    function GetPropType: PTypeInfo;
    function GetValue: string; virtual;
    procedure GetValues(Proc: TGetStrProc); virtual;
    procedure SetValue(const Value: string); virtual;
    function IsDefaultValue: Boolean; virtual;
    function ValueAvailable: Boolean;

    property PropCount: Integer read FPropCount;
    property Value: string read GetValue write SetValue;
  end;

  TcxPropertyEditorClass = class of TcxPropertyEditor;

  { TcxOrdinalProperty }

  TcxOrdinalProperty = class(TcxPropertyEditor)
    function AllEqual: Boolean; override;
    function GetEditLimit: Integer; override;
  end;

  { TcxIntegerProperty }

  TcxIntegerProperty = class(TcxOrdinalProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxCharProperty }

  TcxCharProperty = class(TcxOrdinalProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxEnumProperty }

  TcxEnumProperty = class(TcxOrdinalProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxBoolProperty }

  TcxBoolProperty = class(TcxEnumProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxFloatProperty }

  TcxFloatProperty = class(TcxPropertyEditor)
  public
    function AllEqual: Boolean; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TInt64Property }

  TcxInt64Property = class(TcxPropertyEditor)
  public
    function AllEqual: Boolean; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxStringProperty}

  TcxStringProperty = class(TcxPropertyEditor)
  public
    function AllEqual: Boolean; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxSetElementProperty }

  TcxSetElementProperty = class(TcxPropertyEditor)
  private
    FElement: Integer;
    constructor Create(APropList: PcxInstPropList; APropCount: Integer; AElement: Integer);
  public
    destructor Destroy; override;
    function AllEqual: Boolean; override;
    function GetAttributes: TcxPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    function IsDefaultValue: Boolean; override;
  end;

  { TcxSetProperty }

  TcxSetProperty = class(TcxOrdinalProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    procedure GetProperties(AOwner: TComponent; Proc: TcxGetPropEditProc); override;
    function GetValue: string; override;
  end;

  { TcxClassProperty }

  TcxClassProperty = class(TcxPropertyEditor)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    procedure GetProperties(AOwner: TComponent; Proc: TcxGetPropEditProc); override;
    function GetValue: string; override;
  end;

  { TcxComponentProperty }

  TcxComponentProperty = class(TcxPropertyEditor)
  private
    function GetFullName(AComponent: TComponent): string;
  protected
    function IsValidComponent(AComponent: TComponent): Boolean; virtual;
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxComponentNameProperty }

  TcxComponentNameProperty = class(TcxStringProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetEditLimit: Integer; override;
  end;

  { TcxFontNameProperty }

  TcxFontNameProperty = class(TcxStringProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TcxFontCharsetProperty }

  TcxFontCharsetProperty = class(TcxIntegerProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxImeNameProperty }

  TcxImeNameProperty = class(TcxStringProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TColorProperty }

  TcxColorProperty = class(TcxIntegerProperty)
  public
    procedure Edit; override;
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TcxCursorProperty }

  TcxCursorProperty = class(TcxIntegerProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxFontProperty }

  TcxFontProperty = class(TcxClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TcxPropertyAttributes; override;
  end;

  { TcxStringsProperty }

  TcxStringsProperty = class(TcxClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TcxPropertyAttributes; override;
  end;

  { TcxGraphicProperty }

  TcxGraphicProperty = class(TcxClassProperty)
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
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxPictureProperty }

  TcxPictureProperty = class(TcxGraphicProperty)
  protected
    function GetGraphic: TGraphic; override;
    procedure SetGraphic(Value: TGraphic); override;
  end;

  { TcxModalResultProperty }

  TcxModalResultProperty = class(TcxIntegerProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxShortCutProperty }

  TcxShortCutProperty = class(TcxOrdinalProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxMPFilenameProperty }

  TcxMPFilenameProperty = class(TcxStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TcxPropertyAttributes; override;
  end;

  { TcxTabOrderProperty }

  TcxTabOrderProperty = class(TcxIntegerProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
  end;

  { TCaptionProperty }

  TcxCaptionProperty = class(TcxStringProperty)
  public
    function GetAttributes: TcxPropertyAttributes; override;
  end;

  { TcxDateProperty }

  TcxDateProperty = class(TcxPropertyEditor)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxTimeProperty }

  TcxTimeProperty = class(TcxPropertyEditor)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxDateTimeProperty }

  TcxDateTimeProperty = class(TcxPropertyEditor)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxVariantProperty }

  TcxVariantProperty = class(TcxPropertyEditor)
    function GetAttributes: TcxPropertyAttributes; override;
    procedure GetProperties(AOwner: TComponent; Proc: TcxGetPropEditProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  // the support DevExpress editor's properties

  { TcxEditPropertiesProperty }

  TcxEditPropertiesProperty = class(TcxClassProperty)
  protected
    function HasSubProperties: Boolean; virtual;
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  EcxPropertyError = class(EdxException);

  { TcxPropertyRow }

  TcxPropertyRow = class(TcxEditorRow)
  private
    FIsDefaultValue: Boolean;
    FPropertyEditor: TcxPropertyEditor;
  public
    property IsDefaultValue: Boolean read FIsDefaultValue;
    property PropertyEditor: TcxPropertyEditor read FPropertyEditor;
  end;

  { TcxRTTIInspectorEditingController }

  TcxRTTIInspectorEditingController = class(TcxEditingController)
  private
    FDeactivating: Boolean;
    function GetController: TcxRTTIInspectorController;
    function GetInspector: TcxCustomRTTIInspector;
  protected
    property Controller: TcxRTTIInspectorController read GetController;
    property Deactivating: Boolean read FDeactivating;
    property Inspector: TcxCustomRTTIInspector read GetInspector;
  public
    procedure HideEdit(Accept: Boolean); override;
  end;

  { TcxRTTIInspectorController }

  TcxRTTIInspectorController = class(TcxvgController)
  private
    FFocusChanging: Boolean;
    FNeedCorrect: Boolean;
    function GetEditingController: TcxRTTIInspectorEditingController;
    function GetFocusedRowIndex: Integer;
    function GetInspector: TcxCustomRTTIInspector;
    function GetRowIndexFromCellEdit(Value: TcxCustomInplaceEditContainer): Integer;
    procedure SetFocusedRowIndex(AIndex: Integer);
  protected
    procedure BeforeEditKeyDown(var Key: Word; var Shift: TShiftState); override;
    procedure DoEditDblClick(Sender: TObject); override;
    procedure DoUpdateRowAndCell(ANewRow: TcxCustomRow; ANewCellIndex: Integer); override;
    procedure FocusChanged; override;
    function IsKeyForController(AKey: Word; AShift: TShiftState): Boolean; override;
    procedure SetFocusedItem(Value: TcxCustomInplaceEditContainer); override;
    procedure SetFocusedRowAndCell(Value: TcxCustomRow; ACellIndex: Integer); override;
  public
    procedure SetFocusedRecordItem(ARecordIndex: Integer;
      AItem: TcxCustomInplaceEditContainer); override;
    property EditingController: TcxRTTIInspectorEditingController read GetEditingController;
    property Inspector: TcxCustomRTTIInspector read GetInspector;
  end;

  { TcxRTTIInspectorOptionsView }

  TcxRTTIInspectorOptionsView = class(TcxvgOptionsView)
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property PaintStyle default psDelphi;
    property ShowEditButtons default ecsbFocused;
  end;

  { TcxRTTIInspectorOptionsBehavior }

  TcxRTTIInspectorOptionsBehavior = class(TcxvgOptionsBehavior)
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property AlwaysShowEditor default True;
  end;

  { TcxCustomRTTIInspector }
  IcxRTTIInspectorHelper = interface
  ['{EA7182FA-139D-4525-9C5F-4D8BBAB5FEEE}']
    procedure CloseNonModal(AInspector: TcxCustomRTTIInspector);
    procedure PropertyChanged(AInspector: TcxCustomRTTIInspector);
  end;

  TcxFilterPropertyEvent = procedure(Sender: TObject; const PropertyName: string;
    var Accept: Boolean) of object;

  TcxCustomRTTIInspector = class(TcxUnboundVerticalGrid)
  private
    FBoldFont: TFont;
    FCurrentRow: TcxPropertyRow;
    FListeners: TList;
    FLockRefresh: Boolean;
    FInspectedObject: TPersistent;
    FParentRow: TcxCustomRow;
    FReloaded: Boolean;
    FSaveTopRowIndex: Integer;
    FSettingValue: Boolean;
    FOnFilterProperty: TcxFilterPropertyEvent;
    FOnFilterPropertyEx: TcxFilterPropertyEvent;
    FOnPropertyChanged: TNotifyEvent;
    function CanInvokePropertyEditorDlg: Boolean;
    procedure CNPropertyChanged(var AMessage: TMsg); message DXM_VG_PROPERTYCHANGED;
    procedure CreatePropertyRows(AOldInspectedObject: TPersistent);
    procedure CreateRows(APropertyEditor: TcxPropertyEditor);
    procedure GetComponentsProperties(const AInstances: array of TPersistent);
    function GetController: TcxRTTIInspectorController;
    function GetPropertyEditor: TcxPropertyEditor;
    procedure GetStrProc(const S: string);
    procedure ReleaseComponentProperties;
    procedure RowButtonClick(Sender: TObject; AbsoluteIndex: Integer);
    procedure SetInspectedObject(Value: TPersistent);
    procedure TryInvokePropertyEditorDlg;
    function TrySetValue(AEdit: TcxCustomEdit; AUseText: Boolean): Boolean;
  protected
    //override VCL
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
       MousePos: TPoint): Boolean; override;
    procedure FontChanged; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure DataChanged; override;
    procedure DoPropertyChanged;
    procedure EditChange(Sender: TObject);
    procedure EditValueChanged(Sender: TObject);
    function GetControllerClass: TcxCustomControlControllerClass; override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetEditingControllerClass: TcxEditingControllerClass; override;
    function GetOptionsBehaviorClass: TcxControlOptionsBehaviorClass; override;
    function GetOptionsViewClass: TcxControlOptionsViewClass; override;

    function FilterProperty(const APropertyName: string): Boolean; virtual;
    function FilterPropertyEx(const AFullPropertyName: string): Boolean; virtual;
    function FindRowByPropertyName(const APropertyName: string): TcxPropertyRow;
    procedure FocusRowByPropertyName(const APropertyName: string);
    function GetEditPropertiesClass(APropertyEditor: TcxPropertyEditor): TcxCustomEditPropertiesClass; virtual;
    procedure PostChangedNotification;
    procedure PrepareEditProperties(AProperties: TcxCustomEditProperties; APropertyEditor: TcxPropertyEditor); virtual;

    property Controller: TcxRTTIInspectorController read GetController;
    property PropertyEditor: TcxPropertyEditor read GetPropertyEditor;
    property Reloaded: Boolean read FReloaded;
    property LockRefresh: Boolean read FLockRefresh;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddListener(AListener: TPersistent);
    procedure CloseNonModalEditors;
    procedure RefreshInspectedProperties;
    procedure RemoveListener(AListener: TPersistent);
    property InspectedObject: TPersistent read FInspectedObject write SetInspectedObject;
    property OnFilterProperty: TcxFilterPropertyEvent read FOnFilterProperty write FOnFilterProperty;
    property OnFilterPropertyEx: TcxFilterPropertyEvent read FOnFilterPropertyEx write FOnFilterPropertyEx;
    property OnPropertyChanged: TNotifyEvent read FOnPropertyChanged write FOnPropertyChanged;
  end;

  { TcxRTTIInspector }

  TcxRTTIInspector = class(TcxCustomRTTIInspector)
  published
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property InspectedObject;
    property LayoutStyle;
    property LookAndFeel;
    property OptionsView; //before OptionsBehavior
    property OptionsBehavior;
    property OptionsData;
    property ParentFont;
    property PopupMenu;
    property Styles;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawBackground;
    property OnDrawRowHeader;
    property OnDrawValue;
    property OnEdited;
    property OnEditing;
    property OnEditValueChanged;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnFilterProperty;
    property OnFilterPropertyEx;
    property OnItemChanged;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLayoutChanged;
    property OnLeftVisibleBandIndexChanged;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnPropertyChanged;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnTopRowIndexChanged;
  end;

procedure cxRegisterPropertyEditor(APropertyType: PTypeInfo; AComponentClass: TClass;
  const APropertyName: string; AEditorClass: TcxPropertyEditorClass);

type
  TcxPropertyMapperFunc = function(Obj: TPersistent; PropInfo: PPropInfo): TcxPropertyEditorClass;

procedure cxRegisterPropertyMapper(AMapper: TcxPropertyMapperFunc);
procedure cxGetComponentProperties(AOwner: TComponent;
  AInspector: TcxCustomRTTIInspector; AComponents: TcxComponentList;
  AFilter: TTypeKinds; AProc: TcxGetPropEditProc);

function cxGetPropertiesClassByEditor(APropertyEditor: TcxPropertyEditor): TcxCustomEditPropertiesClass;
procedure cxRegisterEditPropertiesClass(AEditorClass: TcxPropertyEditorClass; AEditPropertiesClass: TcxCustomEditPropertiesClass);
function HasProperty(AClass: TClass; const APropertyName: string): Boolean;
function IsUniquePropertyRelativeTo(AClass, ARelativeClass: TClass; const APropertyName: string): Boolean;
function IsUniquePropertyRelativeParent(AClass: TClass; const APropertyName: string): Boolean;

function IsValidInspectedObject(AObject: TPersistent; AInspector: TcxCustomRTTIInspector): Boolean;

procedure cxDotNetInspectObject(AObject: TPersistent; AInspector: TcxRTTIInspector);

implementation

uses
  Menus, Clipbrd, Dialogs, Consts, Registry, MPlayer, Variants,
  cxOIStringsEd, cxOIPictureEd, cxOICollectionEd, cxColorComboBox,
  cxTextEdit, cxDropDownEdit, cxCalendar, cxSpinEdit, cxTimeEdit, cxButtonEdit,
  cxCustomData, cxGeometry, cxVGridConsts, cxDateUtils;

const
  cxSString = 'String';
  cxSNull = '(Null)';
  cxSUnassigned = '(Unassigned)';

type
  TcxCustomRowAccess = class(TcxCustomRow);
  TcxCustomEditPropertiesAccess = class(TcxCustomEditProperties);
  TcxEditCellViewInfoAccess = class(TcxEditCellViewInfo);
  TcxColorComboBoxPropertiesAccess = class(TcxColorComboBoxProperties);
{$IFNDEF DELPHI6}
  IInterface = IUnknown;
{$ENDIF}

  TcxIntegerSet = set of 0..SizeOf(Integer) * 8 - 1;

  TcxPropertyClassRec = class
    Group: Integer;
    PropertyType: PTypeInfo;
    PropertyName: string;
    ComponentClass: TClass;
    EditorClass: TcxPropertyEditorClass;
  end;

  TcxPropertyMapperRec = class
    Group: Integer;
    Mapper: TcxPropertyMapperFunc;
  end;

  TcxEditPropertiesMapperRec = class
    EditorClass: TcxPropertyEditorClass;
    EditPropertiesClass: TcxCustomEditPropertiesClass;
  end;

  TcxInspectedObjectPropertyEditor = class(TcxComponentProperty)
  protected
    function IsValidComponent(AComponent: TComponent): Boolean; override;
  end;

const
  cxPropClassMap: array[TTypeKind] of TcxPropertyEditorClass = (
    nil, TcxIntegerProperty, TcxCharProperty, TcxEnumProperty,
    TcxFloatProperty, TcxStringProperty, TcxSetProperty, TcxClassProperty,
    nil, TcxPropertyEditor, TcxStringProperty, TcxStringProperty,
    TcxPropertyEditor, nil, nil, nil, TcxInt64Property, nil{$IFDEF DELPHI12}, TcxStringProperty{$ENDIF}
    {$IFDEF DELPHI14}, nil, nil, nil {$ENDIF});

var
  FPropertyClasses: TList = nil;
  FPropertyMappers: TList = nil;
  FEditPropertiesClasses: TList = nil;

{$IFNDEF DELPHI5}
function SameText(const S1, S2: string): Boolean; assembler;
asm
        CMP     EAX,EDX
        JZ      @1
        OR      EAX,EAX
        JZ      @2
        OR      EDX,EDX
        JZ      @3
        MOV     ECX,[EAX-4]
        CMP     ECX,[EDX-4]
        JNE     @3
        CALL    CompareText
        TEST    EAX,EAX
        JNZ     @3
@1:     MOV     AL,1
@2:     RET
@3:     XOR     EAX,EAX
end;
{$ENDIF}

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
      while (I < PropCount) and (CompareText(dxShortStringToString(PropList^[I].Name), APropertyName) <> 0) do
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

function IsValidInspectedObject(AObject: TPersistent; AInspector: TcxCustomRTTIInspector): Boolean;
begin
  Result := AObject <> AInspector;
  if Result and (AObject is TcxCustomRTTIInspector) then
    Result := IsValidInspectedObject(TcxCustomRTTIInspector(AObject).InspectedObject, AInspector);
end;

{ TComponentList }

constructor TcxComponentList.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TcxComponentList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TcxComponentList.GetItem(Index: Integer): TPersistent;
begin
  Result := FList[Index];
end;

function TcxComponentList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TcxComponentList.Add(Item: TPersistent): Integer;
begin
  Result := FList.Add(Item);
end;

function TcxComponentList.Equals(List: TcxComponentList): Boolean;
var
  I: Integer;
begin
  Result := False;
  if List.Count <> FList.Count then Exit;
  for I := 0 to List.Count - 1 do
    if List[I] <> FList[I] then Exit;
  Result := True;
end;

function cxGetPropertiesClassByEditor(APropertyEditor: TcxPropertyEditor): TcxCustomEditPropertiesClass;
var
  I: Integer;
  Item: TcxEditPropertiesMapperRec;
begin
  Result := nil;
  if FEditPropertiesClasses <> nil then
    for I := 0 to FEditPropertiesClasses.Count - 1 do
    begin
      Item := TcxEditPropertiesMapperRec(FEditPropertiesClasses[I]);
      if Item.EditorClass.InheritsFrom(APropertyEditor.ClassType) then
        Result := Item.EditPropertiesClass;
      if Item.EditorClass = APropertyEditor.ClassType then
        Exit;
    end;
end;

procedure cxRegisterEditPropertiesClass(
  AEditorClass: TcxPropertyEditorClass;
  AEditPropertiesClass: TcxCustomEditPropertiesClass);
var
  Item: TcxEditPropertiesMapperRec;
begin
  if FEditPropertiesClasses = nil then FEditPropertiesClasses := TList.Create;
  Item := TcxEditPropertiesMapperRec.Create;
  Item.EditorClass := AEditorClass;
  Item.EditPropertiesClass := AEditPropertiesClass;
  FEditPropertiesClasses.Insert(0, Item);
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

{ TcxPropertyEditor }

constructor TcxPropertyEditor.Create(AOwner: TComponent;
  AInspector: TcxCustomRTTIInspector; APropCount: Integer);
begin
  GetMem(FPropList, APropCount * SizeOf(TcxInstProp));
  FInspector := AInspector;
  FPropCount := APropCount;
  FOwner := AOwner;
end;

destructor TcxPropertyEditor.Destroy;
begin
  if FPropList <> nil then
    FreeMem(FPropList, FPropCount * SizeOf(TcxInstProp));
  inherited Destroy;
end;

function TcxPropertyEditor.AllEqual: Boolean;
begin
  Result := FPropCount = 1;
end;

procedure TcxPropertyEditor.Edit;
type
  TcxGetStrFunc = function(const Value: string): Integer of object;
var
  I: Integer;
  Values: TStringList;
  AddValue: TcxGetStrFunc;
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

function TcxPropertyEditor.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaRevertable];
end;

function TcxPropertyEditor.GetComponent(Index: Integer): TPersistent;
begin
  Result := FPropList^[Index].Instance;
end;

function TcxPropertyEditor.GetFloatValue: Extended;
begin
  Result := GetFloatValueAt(0);
end;

function TcxPropertyEditor.GetFloatValueAt(Index: Integer): Extended;
begin
  with FPropList^[Index] do
    Result := GetFloatProp(Instance, PropInfo);
end;

function TcxPropertyEditor.GetInt64Value: Int64;
begin
  Result := GetInt64ValueAt(0);
end;

function TcxPropertyEditor.GetInt64ValueAt(Index: Integer): Int64;
begin
  with FPropList^[Index] do
    Result := GetInt64Prop(Instance, PropInfo);
end;

function TcxPropertyEditor.GetEditLimit: Integer;
begin
  Result := 255;
end;

function TcxPropertyEditor.GetName: string;
begin
  Result := dxShortStringToString(FPropList^[0].PropInfo^.Name);
end;

function TcxPropertyEditor.GetOrdValue: Longint;
begin
  Result := GetOrdValueAt(0);
end;

function TcxPropertyEditor.GetOrdValueAt(Index: Integer): Longint;
begin
  with FPropList^[Index] do
    Result := GetOrdProp(Instance, PropInfo);
end;

procedure TcxPropertyEditor.GetProperties(AOwner: TComponent; Proc: TcxGetPropEditProc);
begin
end;

procedure TcxPropertyEditor.AdjustInnerEditProperties(
  AProperties: TcxCustomEditProperties);
begin
end;

function TcxPropertyEditor.GetPropInfo: PPropInfo;
begin
  Result := FPropList^[0].PropInfo;
end;

function TcxPropertyEditor.GetPropType: PTypeInfo;
begin
  Result := FPropList^[0].PropInfo^.PropType^;
end;

function TcxPropertyEditor.GetStrValue: string;
begin
  Result := GetStrValueAt(0);
end;

function TcxPropertyEditor.GetStrValueAt(Index: Integer): string;
begin
  with FPropList^[Index] do
    Result := GetStrProp(Instance, PropInfo);
end;

function TcxPropertyEditor.GetVarValue: Variant;
begin
  Result := GetVarValueAt(0);
end;

function TcxPropertyEditor.GetVarValueAt(Index: Integer): Variant;
begin
  with FPropList^[Index] do
    Result := GetVariantProp(Instance, PropInfo);
end;

function TcxPropertyEditor.GetValue: string;
begin
  Result := srUnknown;
end;

procedure TcxPropertyEditor.GetValues(Proc: TGetStrProc);
begin
end;

function TcxPropertyEditor.FindRoot: TComponent;
begin
  Result := FOwner;
end;

procedure TcxPropertyEditor.PostChangedNotification;
begin
  Inspector.PostChangedNotification;
end;

procedure TcxPropertyEditor.SetFloatValue(Value: Extended);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetFloatProp(Instance, PropInfo, Value);
end;

procedure TcxPropertyEditor.SetInt64Value(Value: Int64);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetInt64Prop(Instance, PropInfo, Value);
end;

procedure TcxPropertyEditor.SetOrdValue(Value: Longint);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetOrdProp(Instance, PropInfo, Value);
end;

procedure TcxPropertyEditor.SetStrValue(const Value: string);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetStrProp(Instance, PropInfo, Value);
end;

procedure TcxPropertyEditor.SetVarValue(const Value: Variant);
var
  I: Integer;
begin
  for I := 0 to FPropCount - 1 do
    with FPropList^[I] do
      SetVariantProp(Instance, PropInfo, Value);
end;

procedure TcxPropertyEditor.SetValue(const Value: string);
begin
end;

function AncestorIsValid(Ancestor: TPersistent; Root, RootAncestor: TComponent): Boolean;
begin
  Result := (Ancestor <> nil) and (RootAncestor <> nil) and
            Root.InheritsFrom(RootAncestor.ClassType);
end;

{$IFNDEF DELPHI6}
type
  IInterfaceComponentReference = interface
    ['{E28B1858-EC86-4559-8FCD-6B4F824151ED}']
    function GetComponent: TComponent;
  end;

function VarSameValue(const A, B: Variant): Boolean;
var
  LA, LB: TVarData;
begin
  LA := FindVarData(A)^;
  LB := FindVarData(B)^;
  if LA.VType = varEmpty then
    Result := LB.VType = varEmpty
  else if LA.VType = varNull then
    Result := LB.VType = varNull
  else if LB.VType in [varEmpty, varNull] then
    Result := False
  else
    Result := A = B;
end;

function VarIsClear(const V: Variant): Boolean;
var
  LVarData: TVarData;
begin
  LVarData := FindVarData(V)^;
  with LVarData do
    Result := (VType = varEmpty) or
      (((VType = varDispatch) or (VType = varUnknown)) and (VDispatch = nil));
end;

function GetInterfaceProp(Instance: TObject; PropInfo: PPropInfo): IInterface;
type
  TInterfaceGetProc = function :IInterface of object;
  TInterfaceIndexedGetProc = function (Index: Integer): IInterface of object;
var
  P: ^IInterface;
  M: TMethod;
  Getter: Longint;
begin
  Getter := Longint(PropInfo^.GetProc);
  if (Getter and $FF000000) = $FF000000 then
  begin  // field - Getter is the field's offset in the instance data
    P := Pointer(Integer(Instance) + (Getter and $00FFFFFF));
    Result := P^;   // auto ref count
  end
  else
  begin
    if (Getter and $FF000000) = $FE000000 then
      // virtual method  - Getter is a signed 2 byte integer VMT offset
      M.Code := Pointer(PInteger(PInteger(Instance)^ + SmallInt(Getter))^)
    else
      // static method - Getter is the actual address
      M.Code := Pointer(Getter);

    M.Data := Instance;
    if PropInfo^.Index = Integer($80000000) then  // no index
      Result := TInterfaceGetProc(M)()
    else
      Result := TInterfaceIndexedGetProc(M)(PropInfo^.Index);
  end;
end;

function GetObjectProp(Instance: TObject; PropInfo: PPropInfo): TObject;
begin
  Result := TObject(GetOrdProp(Instance, PropInfo));
end;

function GetWideStrProp(Instance: TObject; PropInfo: PPropInfo): WideString;
type
  TWideStringGetProc = function :WideString of object;
  TWideStringIndexedGetProc = function (Index: Integer): WideString of object;
var
  P: PWideString;
  M: TMethod;
  Getter: Longint;
begin
  case PropInfo^.PropType^.Kind of
    tkString,
    tkLString: Result := GetStrProp(Instance, PropInfo);
    tkWString:
      begin
        Getter := Longint(PropInfo^.GetProc);
        if (Getter and $FF000000) = $FF000000 then
        begin  // field - Getter is the field's offset in the instance data
          P := Pointer(Integer(Instance) + (Getter and $00FFFFFF));
          Result := P^;  // auto ref count
        end
        else
        begin
          if (Getter and $FF000000) = $FE000000 then
            // virtual method  - Getter is a signed 2 byte integer VMT offset
            M.Code := Pointer(PInteger(PInteger(Instance)^ + SmallInt(Getter))^)
          else
            // static method - Getter is the actual address
            M.Code := Pointer(Getter);

          M.Data := Instance;
          if PropInfo^.Index = Integer($80000000) then  // no index
            Result := TWideStringGetProc(M)()
          else
            Result := TWideStringIndexedGetProc(M)(PropInfo^.Index);
        end;
      end;
  else
    Result := '';
  end;
end;
{$ENDIF}

{$IFNDEF DELPHI7}
type
  TGetLookupInfoEvent = procedure(var Ancestor: TPersistent;
    var Root, LookupRoot, RootAncestor: TComponent) of object;

function IsDefaultPropertyValue(Instance: TObject; PropInfo: PPropInfo;
  OnGetLookupInfo: TGetLookupInfoEvent): Boolean;
var
  PropType: PTypeInfo;
  Ancestor: TPersistent;
  LookupRoot: TComponent;
  RootAncestor: TComponent;
  Root: TComponent;
  AncestorValid: Boolean;

  function IsDefaultOrdProp: Boolean;
  var
    Value: Longint;
    Default: LongInt;
  begin
    Value := GetOrdProp(Instance, PropInfo);
    if AncestorValid then
      Result := Value = GetOrdProp(Ancestor, PropInfo)
    else
    begin
      Default := PPropInfo(PropInfo)^.Default;
      Result :=  (Default <> LongInt($80000000)) and (Value = Default);
    end;
  end;

  function IsDefaultFloatProp: Boolean;
  var
    Value: Extended;
  begin
    Value := GetFloatProp(Instance, PropInfo);
    if AncestorValid then
      Result := Value = GetFloatProp(Ancestor, PropInfo)
    else
      Result := Value = 0;;
  end;

  function IsDefaultInt64Prop: Boolean;
  var
    Value: Int64;
  begin
    Value := GetInt64Prop(Instance, PropInfo);
    if AncestorValid then
      Result := Value = GetInt64Prop(Ancestor, PropInfo)
      else
    Result := Value = 0;
  end;

  function IsDefaultStrProp: Boolean;
  var
    Value: WideString;
  begin
    Value := GetWideStrProp(Instance, PropInfo);
    if AncestorValid then
      Result := Value = GetWideStrProp(Ancestor, PropInfo)
    else
      Result := Value = '';
  end;

  function ObjectAncestorMatch(AncestorValue, Value: TComponent): Boolean;
  begin
    Result := (AncestorValue <> nil) and (AncestorValue.Owner = RootAncestor) and
      (Value <> nil) and (Value.Owner = Root) and
      SameText(AncestorValue.Name, Value.Name);
  end;

  function IsDefaultObjectProp: Boolean;
  var
    Value: TObject;

    function IsDefault: Boolean;
    var
      AncestorValue: TObject;
    begin
      AncestorValue := nil;
      if AncestorValid then
      begin
        AncestorValue := TObject(GetOrdProp(Ancestor, PropInfo));
        if ObjectAncestorMatch(TComponent(AncestorValue), TComponent(Value)) then
          AncestorValue := Value;
      end;
      Result := Value = AncestorValue;
    end;

  begin
    Result := True;
    Value := TObject(GetOrdProp(Instance, PropInfo));
    if (Value = nil) and not IsDefault then
    begin
      Result := False; // nil wasn't the "default" value
    end
    else if Value is TPersistent then
    begin
    {$IFDEF DELPHI6}
      if (Value is TComponent) and
        not (csSubComponent in TComponent(Value).ComponentStyle) then
      begin
        if not IsDefault then
        begin
          // A non sub-component TComponent is only non-default if
          // it actually has a name (that way, it can be streamed out -
          // it can't be streamed without a name).
          if TComponent(Value).Name <> '' then
            Result := False;
        end
      end
      else
    {$ENDIF}
        Result := False; // The TPersistent should be checked for default's by the caller
    end;
  end;

  function IsDefaultInterfaceProp: Boolean;
  var
    Intf: IInterface;
    Value: TComponent;

    function IsDefaultValue: Boolean;
    var
      AncestorIntf: IInterface;
      ASR: IInterfaceComponentReference;
    begin
      Result := Intf = nil;
      if AncestorValid then
      begin
        AncestorIntf := GetInterfaceProp(Ancestor, PropInfo);
        Result := Intf = AncestorIntf;
        if not Result then
        begin
          if Supports(AncestorIntf, IInterfaceComponentReference, ASR) then
            Result := ObjectAncestorMatch(ASR.GetComponent, Value);
        end;
      end;
    end;

  var
    SR: IInterfaceComponentReference;
  begin
    Result := True;
    Intf := GetInterfaceProp(Instance, PropInfo);
    if (Intf = nil) or (not Supports(Intf, IInterfaceComponentReference, SR)) then
    begin
      if AncestorValid and (GetInterfaceProp(Ancestor, PropInfo) <> nil) then
        Result := False;
    end
    else
    begin
      Value := SR.GetComponent;
      if not IsDefaultValue then
      begin
        // We can only stream out components (ie: non-default ones)
        // if they actually have a name
        if Value.Name <> '' then
          Result := False;
      end;
    end;
  end;

  function IsDefaultMethodProp: Boolean;
  var
    Value: TMethod;
    DefaultCode: Pointer;
  begin
    Value := GetMethodProp(Instance, PropInfo);
    DefaultCode := nil;
    if AncestorValid then
      DefaultCode := GetMethodProp(Ancestor, PropInfo).Code;
    Result := (Value.Code = DefaultCode) or
      ((Value.Code <> nil) and (LookupRoot.MethodName(Value.Code) = ''));
  end;

  function IsDefaultVariantProp: Boolean;
  var
    Value: Variant;
  begin
    Value := GetVariantProp(Instance, PropInfo);
    if AncestorValid then
      Result := VarSameValue(Value, GetVariantProp(Ancestor, PropInfo))
    else
      Result := VarIsClear(Value);
  end;

begin
  Ancestor := nil;
  Root := nil;
  LookupRoot := nil;
  RootAncestor := nil;

  if Assigned(OnGetLookupInfo) then
    OnGetLookupInfo(Ancestor, Root, LookupRoot, RootAncestor);

  AncestorValid := AncestorIsValid(Ancestor, Root, RootAncestor);

  Result := True;
  if (PropInfo^.GetProc <> nil) and
     ((PropInfo^.SetProc <> nil) {$IFDEF DELPHI6} or
     ((PropInfo^.PropType^.Kind = tkClass) and
      (TObject(GetOrdProp(Instance, PropInfo)) is TComponent) and
      (csSubComponent in TComponent(GetOrdProp(Instance, PropInfo)).ComponentStyle)) {$ENDIF}) then
  begin
    PropType := PropInfo^.PropType^;
    case PropType^.Kind of
      tkInteger, tkChar, tkEnumeration, tkSet:
        Result := IsDefaultOrdProp;
      tkFloat:
        Result := IsDefaultFloatProp;
      tkString, tkLString, tkWString:
        Result := IsDefaultStrProp;
      tkClass:
        Result := IsDefaultObjectProp;
      tkMethod:
        Result := IsDefaultMethodProp;
      tkVariant:
        Result := IsDefaultVariantProp;
      tkInt64:
        Result := IsDefaultInt64Prop;
      tkInterface:
        Result := IsDefaultInterfaceProp;
    end;
  end;
end;
{$ENDIF}

function TcxPropertyEditor.IsDefaultValue: Boolean;
  function CheckProperties(AnObject: TObject): Boolean;
  var
    PropList: PPropList;
    PropInfo: PPropInfo;
    I, Count: Integer;
  begin
    Result := True;
    // Go through each of the properties on the object
    Count := GetTypeData(AnObject.ClassInfo)^.PropCount;
    if Count > 0 then
    begin
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(AnObject.ClassInfo, PropList);
        for I := 0 to Count - 1 do
        begin
          PropInfo := PropList^[I];
          if PropInfo = nil then
            Break;
          if not IsDefaultPropertyValue(AnObject, PropInfo, GetLookupInfo) then
          begin
            Result := False;
            Break;
          end;
        end;
      finally
        FreeMem(PropList, Count * SizeOf(Pointer));
      end;
    end;
  end;

var
  FirstInstance: TObject;
  FirstPropInfo: PPropInfo;

  SubObject: TObject;
  OldAncestor: TPersistent;

begin
  Result := True;
  if PropCount > 0 then
  begin
    // if they are not all equal, then they aren't all the default (at least one..)
    if not AllEqual then
    begin
      Result := False;
      Exit;
    end;

    FirstInstance := FPropList^[0].Instance;
    FirstPropInfo := FPropList^[0].PropInfo;
    if IsStoredProp(FirstInstance, FirstPropInfo) then
    begin
      // TWriter.WriteDescendent simulation
      FRootAncestor := nil;
      FAncestor := nil;
      FRoot := FindRoot;
      if FirstInstance is TComponent then
      begin
        FLookingFor := TComponent(FirstInstance);
        // Only lookup the component if it was introduced in an ancestor form/frame
        if csAncestor in FLookingFor.ComponentState then
        begin
          FDoneLooking := False;
          WriteComponentSimulation(FRoot);
        end
        else
        begin
          FRootAncestor := nil;
          FAncestor := nil;
        end;
      end
      else
      begin
        // In this case, we will not look up the ancestor (there really
        // isn't one - take columns on tlistview as an example)
        FRootAncestor := nil;
        FAncestor := nil;
      end;

      Result := IsDefaultPropertyValue(FirstInstance, FirstPropInfo, GetLookupInfo);
      if not Result then
      begin
        if FirstPropInfo^.PropType^.Kind = tkClass then
        begin
          // If it was a class/object then we need to recursivly check that
          // object to see if it has all default properties.
          SubObject := GetObjectProp(FirstInstance, FirstPropInfo);

          OldAncestor := FAncestor;
          try
            if AncestorIsValid(FAncestor, FRoot, FRootAncestor) then
              FAncestor := TPersistent(GetOrdProp(FAncestor, FirstPropInfo));
            Result := CheckProperties(SubObject);
          finally
            FAncestor := OldAncestor;
          end;

          if SubObject is TCollection then
          begin
            if not AncestorIsValid(FAncestor, FRoot, FRootAncestor) or
              not CollectionsEqual(TCollection(SubObject),
                TCollection(GetOrdProp(FAncestor, FirstPropInfo))
                {$IFDEF DELPHI6}, FRoot, FRootAncestor{$ENDIF}) then
                  Result := False;
          end;
        end;
      end;
    end;
  end;
end;

function TcxPropertyEditor.ValueAvailable: Boolean;
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

procedure TcxPropertyEditor.AddAncestor(Component: TComponent);
begin
  FAncestorList.Add(Component);
end;

procedure TcxPropertyEditor.GetLookupInfo(var Ancestor: TPersistent;
  var Root, LookupRoot, RootAncestor: TComponent);
begin
  Ancestor := FAncestor;
  Root := FRoot;
  LookupRoot := FRoot; // Same in this case
  RootAncestor := FRootAncestor;
end;

procedure TcxPropertyEditor.SetPropEntry(Index: Integer;
  AInstance: TPersistent; APropInfo: PPropInfo);
begin
  with FPropList^[Index] do
  begin
    Instance := AInstance;
    PropInfo := APropInfo;
  end;
end;

type
  TComponentHack = class(TComponent);
  
procedure TcxPropertyEditor.WriteComponentSimulation(Component: TComponent);
  function FindAncestor(const Name: string): TComponent;
  var
    I: Integer;
  begin
    for I := 0 to FAncestorList.Count - 1 do
    begin
      Result := FAncestorList[I];
      if SameText(Result.Name, Name) then Exit;
    end;
    Result := nil;
  end;
var
  OldAncestor: TPersistent;
  OldRoot, OldRootAncestor: TComponent;
  OldAncestorList: TList;
  TempAncestor: TPersistent;
begin
  if FDoneLooking then
    Exit;

  OldAncestor := FAncestor;
  OldRootAncestor := FRootAncestor;
  try
    if Assigned(FAncestorList) then
      FAncestor := FindAncestor(Component.Name);

    // If we are at the component we were looking for, then we
    // can stop at this point
    if FLookingFor = Component then
      FDoneLooking := True
    else if SameText(FLookingFor.Name, Component.Name) then
      FDoneLooking := True
    else
    begin
      if (FAncestor = nil) and (Component <> FRoot) then
      begin
        TempAncestor := FRoot;
        if TempAncestor <> nil then
        begin
          FAncestor := TempAncestor;
          FRootAncestor := TComponent(FAncestor);
        end;
      end;
      // Component.WriteState(Self); // This is simulated below, inline
      OldAncestorList := FAncestorList;
      OldRoot := FRoot;
      OldRootAncestor := FRootAncestor;
      try
        FAncestorList := nil;
        try
          if (FAncestor <> nil) and (FAncestor is TComponent) then
          begin
          {$IFDEF DELPHI5}
            if csInline in TComponent(FAncestor).ComponentState then
              FRootAncestor := TComponent(FAncestor);
          {$ENDIF}
            FAncestorList := TList.Create;
            TComponentHack(FAncestor).GetChildren(AddAncestor, FRootAncestor);
          end;
        {$IFDEF DELPHI5}
          if csInline in Component.ComponentState then
            FRoot := Component;
        {$ENDIF}
          TComponentHack(Component).GetChildren(WriteComponentSimulation, FRoot);
        finally
          FAncestorList.Free;
        end;
      finally
        FAncestorList := OldAncestorList;
        if not FDoneLooking then
        begin
          FRoot := OldRoot;
          FRootAncestor := OldRootAncestor;
        end;
      end;
    end;
  finally
    if not FDoneLooking then
    begin
      // Only restore the ancestor if we were not done looking.
      // This way, we can continue up the chaing looking for the
      // component
      FAncestor := OldAncestor;
      FRootAncestor := OldRootAncestor;
    end
  end;
end;

{ TcxOrdinalProperty }

function TcxOrdinalProperty.AllEqual: Boolean;
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

function TcxOrdinalProperty.GetEditLimit: Integer;
begin
  Result := 63;
end;

{ TcxIntegerProperty }

function TcxIntegerProperty.GetValue: string;
begin
  Result := IntToStr(GetOrdValue);
end;

procedure TcxIntegerProperty.SetValue(const Value: string);

  procedure Error(const Args: array of const);
  begin
    raise EcxPropertyError.CreateFmt(SOutOfRange, Args);
  end;

var
  L: Int64;
begin
  L := StrToInt64(Value);
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

function TcxCharProperty.GetValue: string;
var
  Ch: Char;
begin
  Ch := Chr(GetOrdValue);
  if dxCharInSet(Ch, [#33..#127]) then
    Result := Ch
  else
    FmtStr(Result, '#%d', [Ord(Ch)]);
end;

procedure TcxCharProperty.SetValue(const Value: string);
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
        raise EcxPropertyError.Create(SInvalidPropertyValue);
        
  with GetTypeData(GetPropType)^ do
    if (L < MinValue) or (L > MaxValue) then
      raise EcxPropertyError.CreateFmt(SOutOfRange, [MinValue, MaxValue]);
  SetOrdValue(L);
end;

{ TcxEnumProperty }

function TcxEnumProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

function TcxEnumProperty.GetValue: string;
var
  L: Longint;
begin
  L := GetOrdValue;
  with GetTypeData(GetPropType)^ do
    if (L < MinValue) or (L > MaxValue) then L := MaxValue;
  Result := GetEnumName(GetPropType, L);
end;

procedure TcxEnumProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  EnumType: PTypeInfo;
begin
  EnumType := GetPropType;
  with GetTypeData(EnumType)^ do
    for I := MinValue to MaxValue do
      Proc(GetEnumName(EnumType, I));
end;

procedure TcxEnumProperty.SetValue(const Value: string);
var
  I: Integer;
begin
  I := GetEnumValue(GetPropType, Value);
  if I < 0 then raise EcxPropertyError.Create(SInvalidPropertyValue);
  SetOrdValue(I);
end;

{ TcxBoolProperty  }

function TcxBoolProperty.GetValue: string;
begin
  if GetOrdValue = 0 then
    Result := 'False'
  else
    Result := 'True';
end;

procedure TcxBoolProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('False');
  Proc('True');
end;

procedure TcxBoolProperty.SetValue(const Value: string);
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

{ TInt64Property }

function TcxInt64Property.AllEqual: Boolean;
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

function TcxInt64Property.GetEditLimit: Integer;
begin
  Result := 63;
end;

function TcxInt64Property.GetValue: string;
begin
  Result := IntToStr(GetInt64Value);
end;

procedure TcxInt64Property.SetValue(const Value: string);
begin
  SetInt64Value(StrToInt64(Value));
end;

{ TcxFloatProperty }

function TcxFloatProperty.AllEqual: Boolean;
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

function TcxFloatProperty.GetValue: string;
const
  Precisions: array[TFloatType] of Integer = (7, 15, 18, 18, 18);
begin
  Result := FloatToStrF(GetFloatValue, ffGeneral,
    Precisions[GetTypeData(GetPropType)^.FloatType], 0);
end;

procedure TcxFloatProperty.SetValue(const Value: string);
begin
  SetFloatValue(StrToFloat(Value));
end;

{ TcxStringProperty }

function TcxStringProperty.AllEqual: Boolean;
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

function TcxStringProperty.GetEditLimit: Integer;
begin
  if GetPropType^.Kind = tkString then
    Result := GetTypeData(GetPropType)^.MaxLength
  else
    Result := 255;
end;

function TcxStringProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TcxStringProperty.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

{ TcxComponentNameProperty }

function TcxComponentNameProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [];
end;

function TcxComponentNameProperty.GetEditLimit: Integer;
begin
  Result := 63;
end;

{ TcxSetElementProperty }

constructor TcxSetElementProperty.Create(APropList: PcxInstPropList;
  APropCount: Integer; AElement: Integer);
begin
  FPropList := APropList;
  FPropCount := APropCount;
  FElement := AElement;
end;

destructor TcxSetElementProperty.Destroy;
begin
end;

function TcxSetElementProperty.AllEqual: Boolean;
var
  I: Integer;
  S: TcxIntegerSet;
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

function TcxSetElementProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

function TcxSetElementProperty.GetName: string;
begin
  Result := GetEnumName(GetTypeData(GetPropType)^.CompType^, FElement);
end;

function TcxSetElementProperty.GetValue: string;
var
  S: TcxIntegerSet;
begin
  Integer(S) := GetOrdValue;
  if FElement in S then
    Result := 'True'
  else
    Result := 'False';
end;

procedure TcxSetElementProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('False');
  Proc('True');
end;

procedure TcxSetElementProperty.SetValue(const Value: string);
var
  S: TcxIntegerSet;
begin
  Integer(S) := GetOrdValue;
  if CompareText(Value, 'True') = 0 then
    Include(S, FElement)
  else
    Exclude(S, FElement);
  SetOrdValue(Integer(S));
end;

function TcxSetElementProperty.IsDefaultValue: Boolean;
var
  S1, S2: TcxIntegerSet;
  HasStoredProc: Integer;
  ProcAsInt: Integer;
begin
  Result := inherited IsDefaultValue;
  if not Result then
  begin
    ProcAsInt := Integer(PPropInfo(GetPropInfo)^.StoredProc);
    HasStoredProc := ProcAsInt and $FFFFFF00;
    if HasStoredProc = 0 then
    begin
      Integer(S1) := PPropInfo(GetPropInfo)^.Default;
      Integer(S2) := GetOrdValue;
      Result := not ((FElement in S1) xor (FElement in S2));
    end;
  end;
end;

{ TcxSetProperty }

function TcxSetProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSubProperties, ipaReadOnly, ipaRevertable];
end;

procedure TcxSetProperty.GetProperties(AOwner: TComponent; Proc: TcxGetPropEditProc);
var
  I: Integer;
begin
  with GetTypeData(GetTypeData(GetPropType)^.CompType^)^ do
    for I := MinValue to MaxValue do
      Proc(TcxSetElementProperty.Create(FPropList, FPropCount, I));
end;

function TcxSetProperty.GetValue: string;
var
  S: TcxIntegerSet;
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

{ TcxClassProperty }

function TcxClassProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSubProperties, ipaReadOnly];
end;

procedure TcxClassProperty.GetProperties(AOwner: TComponent; Proc: TcxGetPropEditProc);
var
  Components: TcxComponentList;
  I: Integer;
begin
  Components := TcxComponentList.Create;
  try
    for I := 0 to PropCount - 1 do
      if TComponent(GetOrdValueAt(I)) <> nil then
        Components.Add(TComponent(GetOrdValueAt(I)));
    cxGetComponentProperties(AOwner, FInspector, Components, tkProperties, Proc);
  finally
    Components.Free;
  end;
end;

function TcxClassProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

{ TcxComponentProperty }

function TcxComponentProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

function TcxComponentProperty.GetEditLimit: Integer;
begin
  Result := 127;
end;

function TcxComponentProperty.GetValue: string;
begin
  if TComponent(GetOrdValue) <> nil then
    Result := GetFullName(TComponent(GetOrdValue))
  else
    Result := '';
end;

procedure TcxComponentProperty.GetValues(Proc: TGetStrProc);

  procedure AddProc(AComponent: TComponent);
  var
    i: Integer;
  begin
    for i := 0 to AComponent.ComponentCount - 1 do
    begin
      if IsValidComponent(AComponent.Components[i]) then
        Proc(GetFullName(AComponent.Components[i]));
      AddProc(AComponent.Components[i]);
    end;
  end;

var
  AOwner: TComponent;
begin
  if FOwner <> nil then
  begin
    AOwner := FOwner;
    while AOwner.Owner <> nil do
      AOwner := AOwner.Owner;
    AddProc(AOwner);
  end
  else
    AddProc(Application);
end;

procedure TcxComponentProperty.SetValue(const Value: string);
var
  Component: TComponent;

  function GetComponentByName(const AName: string): TComponent;

     procedure CheckOwner(AOwner: TComponent);
     var
       I: Integer;
       AComponent: TComponent;
     begin
       if Result <> nil then Exit;
       for I := 0 to AOwner.ComponentCount - 1 do
       begin
         AComponent := AOwner.Components[I];
         if SameText(GetFullName(AComponent), AName) then
         begin
           Result := AComponent;
           break;
         end
         else
           CheckOwner(AComponent);
       end;
     end;

  var
    AOwner: TComponent;
  begin
    Result := nil;
    AOwner := FOwner;
    while AOwner.Owner <> nil do
      AOwner := AOwner.Owner;
    CheckOwner(AOwner);
  end;

begin
  if Value = '' then
    Component := nil
  else
  begin
    Component := GetComponentByName(Value);
    if not (Component is GetTypeData(GetPropType)^.ClassType) then
      raise EcxPropertyError.Create(SInvalidPropertyValue);
  end;
  SetOrdValue(Longint(Component));
end;

function TcxComponentProperty.IsValidComponent(AComponent: TComponent): Boolean;
begin
  Result := (AComponent.Name <> '') and (AComponent is GetTypeData(GetPropType)^.ClassType);
end;

function TcxComponentProperty.GetFullName(AComponent: TComponent): string;
begin
  Result := cxGetFullComponentName(AComponent);
end;

{ TcxFontNameProperty }

function TcxFontNameProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

procedure TcxFontNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to Screen.Fonts.Count - 1 do
    Proc(Screen.Fonts[I]);
end;

{ TcxFontCharsetProperty }

function TcxFontCharsetProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSortList, ipaValueList];
end;

function TcxFontCharsetProperty.GetValue: string;
begin
  if not CharsetToIdent(TFontCharset(GetOrdValue), Result) then
    FmtStr(Result, '%d', [GetOrdValue]);
end;

procedure TcxFontCharsetProperty.GetValues(Proc: TGetStrProc);
begin
  GetCharsetValues(Proc);
end;

procedure TcxFontCharsetProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToCharset(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;

{ TcxImeNameProperty }

function TcxImeNameProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaValueList, ipaSortList, ipaMultiSelect];
end;

procedure TcxImeNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to Screen.Imes.Count - 1 do
    Proc(Screen.Imes[I]);
end;

{ TcxMPFilenameProperty }

procedure TcxMPFilenameProperty.Edit;
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Application);
  with OpenDialog do
  try
    Filename := GetValue;
    Filter := SMPOpenFilter;
    Options := Options + [ofPathMustExist, ofFileMustExist];
    if Execute then
    begin
      SetValue(FileName);
      PostChangedNotification;
    end;
  finally
    Free;
  end;
end;

function TcxMPFilenameProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaDialog, ipaRevertable];
end;

{ TcxColorProperty }

procedure TcxColorProperty.Edit;
var
  ColorDialog: TColorDialog;
  IniFile: TRegIniFile;

  procedure GetCustomColors;
  begin
    IniFile := TRegIniFile.Create('\Software\Borland\Delphi\7.0');
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
    if Execute then
    begin
      SetOrdValue(Color);
      PostChangedNotification;
    end;
    SaveCustomColors;
  finally
    if IniFile <> nil then IniFile.Free;
    Free;
  end;
end;

function TcxColorProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaDialog];
end;

function TcxColorProperty.GetValue: string;
begin
  Result := IntToStr(GetOrdValue);
end;

procedure TcxColorProperty.GetValues(Proc: TGetStrProc);
begin
end;

{ TcxCursorProperty }

function TcxCursorProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList, ipaRevertable];
end;

function TcxCursorProperty.GetValue: string;
begin
  Result := CursorToString(TCursor(GetOrdValue));
end;

procedure TcxCursorProperty.GetValues(Proc: TGetStrProc);
begin
  GetCursorValues(Proc);
end;

procedure TcxCursorProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToCursor(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;

{ TcxFontProperty }

procedure TcxFontProperty.Edit;
var
  FontDialog: TFontDialog;
begin
  FontDialog := TFontDialog.Create(Application);
  try
    FontDialog.Font := TFont(GetOrdValue);
    FontDialog.Options := FontDialog.Options + [fdForceFontExist];
    if FontDialog.Execute then
    begin
      SetOrdValue(Longint(FontDialog.Font));
      PostChangedNotification;
    end;
  finally
    FontDialog.Free;
  end;
end;

function TcxFontProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSubProperties, ipaDialog, ipaReadOnly];
end;

{TcxStringsProperty}

procedure TcxStringsProperty.Edit;
var
  Data: TcxStringsEditorDlgData;
begin
  if Inspector <> nil then
    Data.LookAndFeel := TcxCustomRTTIInspector(Inspector).LookAndFeel
  else
    Data.LookAndFeel := nil;
  Data.Caption := GetComponent(0).GetNamePath + '.' + GetName;
  Data.Text := TStrings(GetOrdValue).Text;
  if cxShowStringsEditor(@Data) then
  begin
    TStrings(GetOrdValue).Text := Data.Text;
    PostChangedNotification;
  end;
end;

function TcxStringsProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaDialog, ipaReadOnly];
end;

{ TcxGraphicProperty }

procedure TcxGraphicProperty.Edit;
var
  Data: TcxPictureEditorDlgData;
  P: TPicture;
begin
  P := TPicture.Create;
  try
    P.Assign(GetGraphic);
    with Data do
    begin
      if Inspector <> nil then
        LookAndFeel := TcxCustomRTTIInspector(Inspector).LookAndFeel
      else
        LookAndFeel := nil;
      Caption := GetComponent(0).GetNamePath + '.' + GetName;
      ClipboardFormat := GetClipboardFormat;
      GraphicFilter := GetGraphicFilter;
      Picture := P;
    end;
    if cxShowPictureEditor(@Data) then
    begin
      SetGraphic(P.Graphic);
      PostChangedNotification;
    end;
  finally
    P.Free;
  end;
end;

function TcxGraphicProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaDialog];
end;

function TcxGraphicProperty.HasGraphic: Boolean;
begin
  Result := (GetGraphic <> nil) and not GetGraphic.Empty;
end;

function TcxGraphicProperty.GraphicClass: TGraphicClass;
begin
  if GetGraphic = nil then
    Result := nil
  else
    Result := TGraphicClass(GetGraphic.ClassType);
end;

function TcxGraphicProperty.GetGraphicFilter: string;
begin
  Result := GraphicFilter(TGraphic)
end;

function TcxGraphicProperty.GetClipboardFormat: Word;
begin
  Result := CF_PICTURE;
  if GraphicClass <> nil then 
    if GraphicClass.InheritsFrom(TBitmap) then 
      Result := CF_BITMAP
    else
      if GraphicClass.InheritsFrom(TMetafile) then     
        Result := CF_METAFILEPICT;
end;

function TcxGraphicProperty.GetGraphic: TGraphic;
begin
  Result := TGraphic(GetOrdValue);
end;

procedure TcxGraphicProperty.SetGraphic(Value: TGraphic);
begin
  GetGraphic.Assign(Value);
end;

function TcxGraphicProperty.GetValue: string;
begin
  if HasGraphic then 
    Result := '(' + GetGraphic.ClassName + ')'
  else
    Result := '(None)';
end;

procedure TcxGraphicProperty.SetValue(const Value: string);
begin
  if Value = '' then SetGraphic(nil);
end;

{TcxPictureProperty}

function TcxPictureProperty.GetGraphic: TGraphic;
begin
  if GetOrdValue = 0 then
    Result := nil
  else  
    Result := TPicture(GetOrdValue).Graphic;
end;

procedure TcxPictureProperty.SetGraphic(Value: TGraphic);
begin
  TPicture(GetOrdValue).Assign(Value);
end;

{ TcxModalResultProperty }

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

function TcxModalResultProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaRevertable];
end;

function TcxModalResultProperty.GetValue: string;
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

procedure TcxModalResultProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(dxModalResults) to High(dxModalResults) do
    Proc(dxModalResults[I]);
end;

procedure TcxModalResultProperty.SetValue(const Value: string);
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

{ TcxShortCutProperty }

const
  cxShortCuts: array[0..82] of TShortCut = (
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

function TcxShortCutProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaRevertable];
end;

function TcxShortCutProperty.GetValue: string;
var
  CurValue: TShortCut;
begin
  CurValue := GetOrdValue;
  if CurValue = scNone then
    Result := srNone
  else
    Result := ShortCutToText(CurValue);
end;

procedure TcxShortCutProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  Proc(srNone);
  for I := 1 to High(cxShortCuts) do
    Proc(ShortCutToText(cxShortCuts[I]));
end;

procedure TcxShortCutProperty.SetValue(const Value: string);
var
  NewValue: TShortCut;
begin
  NewValue := 0;
  if (Value <> '') and (AnsiCompareText(Value, srNone) <> 0) then
  begin
    NewValue := TextToShortCut(Value);
    if NewValue = 0 then
      raise EcxPropertyError.Create(SInvalidPropertyValue);
  end;
  SetOrdValue(NewValue);
end;

{ TcxTabOrderProperty }

function TcxTabOrderProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [];
end;

{ TcxCaptionProperty }

function TcxCaptionProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaAutoUpdate, ipaRevertable];
end;

{ TcxDateProperty }

function TcxDateProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaRevertable];
end;

function TcxDateProperty.GetValue: string;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := DateToStr(DT);
end;

procedure TcxDateProperty.SetValue(const Value: string);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToDate(Value);
  SetFloatValue(DT);
end;

{ TcxTimeProperty }

function TcxTimeProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaRevertable];
end;

function TcxTimeProperty.GetValue: string;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  Result := TimeToStr(TimeOf(DT));
end;

procedure TcxTimeProperty.SetValue(const Value: string);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToTime(Value);
  SetFloatValue(DT);
end;

{ TcxDateTimeProperty }

function TcxDateTimeProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaRevertable];
end;

function TcxDateTimeProperty.GetValue: string;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := DateTimeToStr(DT);
end;

procedure TcxDateTimeProperty.SetValue(const Value: string);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToDateTime(Value);
  SetFloatValue(DT);
end;

{ TVariantTypeProperty }

{$IFNDEF DELPHI6}
const
  varInt64 = $14;
{$ENDIF}

var
  VarTypeNames: array[varEmpty..varInt64] of string = (
    'Unassigned', // varEmpty
    'Null',       // varNull
    'Smallint',   // varSmallint
    'Integer',    // varInteger
    'Single',     // varSingle
    'Double',     // varDouble
    'Currency',   // varCurrency
    'Date',       // varDate
    'OleStr',     // varOleStr
    '',           // varDispatch
    '',           // varError
    'Boolean',    // varBoolean
    '',           // varVariant
    '',           // varUnknown
    '',           // [varDecimal]
    '',           // [undefined]
    'Shortint',   // varShortInt
    'Byte',       // varByte
    'Word',       // varWord
    'LongWord',   // varLongWord
    'Int64');     // varInt64

type
  TcxVariantTypeProperty = class(TcxPropertyEditor)
  public
    constructor Create(APropList: PcxInstPropList; APropCount: Integer);
    destructor Destroy; override;
    function AllEqual: Boolean; override;
    function GetAttributes: TcxPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
   end;

constructor TcxVariantTypeProperty.Create(APropList: PcxInstPropList;
  APropCount: Integer);
begin
  FPropList := APropList;
  FPropCount := APropCount;
end;

destructor TcxVariantTypeProperty.Destroy;
begin
end;

function TcxVariantTypeProperty.AllEqual: Boolean;
var
  i: Integer;
  V1, V2: Variant;
begin
  Result := False;
  if PropCount > 1 then
  begin
    V1 := GetVarValue;
    for i := 1 to PropCount - 1 do
    begin
      V2 := GetVarValueAt(i);
      if VarType(V1) <> VarType(V2) then Exit;
    end;
  end;
  Result := True;
end;

function TcxVariantTypeProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaValueList, ipaSortList];
end;

function TcxVariantTypeProperty.GetName: string;
begin
  Result := 'Type';
end;

function TcxVariantTypeProperty.GetValue: string;
begin
  if VarIsStr(GetVarValue) then
    Result := cxSString
  else
    case VarType(GetVarValue) and varTypeMask of
      Low(VarTypeNames)..High(VarTypeNames):
        Result := VarTypeNames[VarType(GetVarValue)];
    else
      Result := cxGetResourceString(@cxSvgUnknown);
    end;
end;

procedure TcxVariantTypeProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
begin
  for i := 0 to High(VarTypeNames) do
    if VarTypeNames[i] <> '' then
      Proc(VarTypeNames[i]);
  Proc(cxSString);
end;

procedure TcxVariantTypeProperty.SetValue(const Value: string);

  function GetSelectedType: Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to High(VarTypeNames) do
      if VarTypeNames[i] = Value then
      begin
        Result := i;
        break;
      end;
    if (Result = -1) and (Value = cxSString) then
      Result := varString;
  end;

var
  NewType: Integer;
  V: Variant;
begin
  V := GetVarValue;
  NewType := GetSelectedType;
  case NewType of
    varEmpty: VarClear(V);
    varNull: V := NULL;
    -1: raise EdxException.Create('UnknownType');  //todo resource
  else
    try
      VarCast(V, V, NewType);
    except
      // If it cannot cast, clear it and then cast again.
      VarClear(V);
      VarCast(V, V, NewType);
    end;
  end;
  SetVarValue(V);
end;

{ TcxVariantProperty }

{$IFNDEF DELPHI6}

function VarToStrDef(const V: Variant; const ADefault: string): string;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := ADefault;
end;
{$ENDIF}

function TcxVariantProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect, ipaSubProperties];
end;

procedure TcxVariantProperty.GetProperties(AOwner: TComponent;
  Proc: TcxGetPropEditProc);
begin
  Proc(TcxVariantTypeProperty.Create(FPropList, FPropCount));
end;

function TcxVariantProperty.GetValue: string;

  function GetVariantStr(const Value: Variant): string;
  begin
    case VarType(Value) of
      varBoolean:
        Result := BooleanIdents[Value = True];
      varCurrency:
        Result := CurrToStr(Value);
    else
      Result := VarToStrDef(Value, cxSNull);
    end;
  end;

var
  Value: Variant;
begin
  Value := GetVarValue;
  if VarType(Value) <> varDispatch then
    Result := GetVariantStr(Value)
  else
    Result := 'ERROR';
end;

procedure TcxVariantProperty.SetValue(const Value: string);

  function Cast(var Value: Variant; NewType: Integer): Boolean;
  var
    V2: Variant;
  begin
    Result := True;
    if NewType = varCurrency then
      Result := AnsiPos(dxFormatSettings.CurrencyString, Value) > 0;
    if Result then
    try
      VarCast(V2, Value, NewType);
      Result := (NewType = varDate) or (VarToStr(V2) = VarToStr(Value));
      if Result then Value := V2;
    except
      Result := False;
    end;
  end;

var
  V: Variant;
  OldType: Integer;
begin
  OldType := VarType(GetVarValue);
  V := Value;
  if Value = '' then
    VarClear(V) else
  if (CompareText(Value, cxSNull) = 0) then
    V := NULL else
  if not Cast(V, OldType) then
    V := Value;
  SetVarValue(V);
end;

{ TcxEditPropertiesProperty }

function TcxEditPropertiesProperty.HasSubProperties: Boolean;
var
  I: Integer;
  AIntf: IcxEditorPropertiesContainer;
begin
  for I := 0 to PropCount - 1 do
  begin
    Result := Supports(GetComponent(I), IcxEditorPropertiesContainer, AIntf) and
      (AIntf.GetProperties <> nil);
    if not Result then Exit;
  end;
  Result := True;
end;

function TcxEditPropertiesProperty.GetAttributes: TcxPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if not HasSubProperties then
    Exclude(Result, ipaSubProperties);
  Result := Result - [ipaReadOnly] + [ipaValueList, ipaSortList, ipaRevertable];
end;

function TcxEditPropertiesProperty.GetValue: string;
begin
  if HasSubProperties then
    Result := GetRegisteredEditProperties.GetDescriptionByClass(
      TcxCustomEditProperties(GetOrdValue).ClassType)
  else
    Result := '';
end;

procedure TcxEditPropertiesProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to GetRegisteredEditProperties.Count - 1 do
    Proc(GetRegisteredEditProperties.Descriptions[I]);
end;

procedure TcxEditPropertiesProperty.SetValue(const Value: string);
var
  APropertiesClass: TcxCustomEditPropertiesClass;
  I: Integer;
  AIntf: IcxEditorPropertiesContainer;
begin
  APropertiesClass := TcxCustomEditPropertiesClass(
    GetRegisteredEditProperties.FindByClassName(Value));
  if APropertiesClass = nil then
    APropertiesClass := TcxCustomEditPropertiesClass(
      GetRegisteredEditProperties.FindByDescription(Value));
  for I := 0 to PropCount - 1 do
    if Supports(GetComponent(I), IcxEditorPropertiesContainer, AIntf) then
      AIntf.SetPropertiesClass(APropertiesClass);
  inherited;
end;

{ TcxPropInfoList }

type
  TcxPropInfoList = class
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
    procedure Intersect(List: TcxPropInfoList);

    property Count: Integer read FCount;
    property Items[Index: Integer]: PPropInfo read Get; default;
  end;

constructor TcxPropInfoList.Create(Instance: TPersistent; Filter: TTypeKinds);
begin
  if Instance.ClassInfo <> nil then
  begin
    FCount := GetPropList(Instance.ClassInfo, Filter, nil);
    FSize := FCount * SizeOf(Pointer);
    GetMem(FList, FSize);
    GetPropList(Instance.ClassInfo, Filter, FList);
  end;
end;

destructor TcxPropInfoList.Destroy;
begin
  if FList <> nil then FreeMem(FList, FSize);
  inherited Destroy;
end;

function TcxPropInfoList.Contains(P: PPropInfo): Boolean;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    with FList^[I]^ do
      if (PropType^ = P^.PropType^) and
        (CompareText(dxShortStringToString(Name), dxShortStringToString(P^.Name)) = 0) then
      begin
        Result := True;
        Exit;
      end;
  Result := False;
end;

procedure TcxPropInfoList.Delete(Index: Integer);
begin
  Dec(FCount);
  if Index < FCount then
    Move(FList^[Index + 1], FList^[Index], (FCount - Index) * SizeOf(Pointer));
end;

function TcxPropInfoList.Get(Index: Integer): PPropInfo;
begin
  Result := FList^[Index];
end;

procedure TcxPropInfoList.Intersect(List: TcxPropInfoList);
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if not List.Contains(FList^[I]) then Delete(I);
end;

{ GetComponentProperties }

procedure cxRegisterPropertyEditor(APropertyType: PTypeInfo; AComponentClass: TClass;
  const APropertyName: string; AEditorClass: TcxPropertyEditorClass);
var
  Item: TcxPropertyClassRec;
begin
  if FPropertyClasses = nil then FPropertyClasses := TList.Create;
  Item := TcxPropertyClassRec.Create;
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

procedure cxRegisterPropertyMapper(AMapper: TcxPropertyMapperFunc);
var
  Item: TcxPropertyMapperRec;
begin
  if FPropertyMappers = nil then
    FPropertyMappers := TList.Create;
  Item := TcxPropertyMapperRec.Create;
  Item.Group := CurrentGroup;
  Item.Mapper := AMapper;
  FPropertyMappers.Insert(0, Item);
end;

function cxGetEditorClass(APropInfo: PPropInfo; Obj: TPersistent): TcxPropertyEditorClass;
var
  PropType: PTypeInfo;
  P, C: TcxPropertyClassRec;
  I: Integer;
begin
  if FPropertyMappers <> nil then
    for I := 0 to FPropertyMappers.Count - 1 do
      with TcxPropertyMapperRec(FPropertyMappers[I]) do
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
        ((P.PropertyName = '') or (CompareText(dxShortStringToString(APropInfo^.Name), P.PropertyName) = 0)) then
        if (C = nil) or ((C.ComponentClass = nil) and (P.ComponentClass <> nil))
          or ((C.PropertyName = '') and (P.PropertyName <> '')) then
          C := P;
      Inc(I);
    end;

  if C <> nil then
    Result := C.EditorClass
  else
    Result := cxPropClassMap[PropType^.Kind];
end;

procedure cxGetComponentProperties(AOwner: TComponent;
  AInspector: TcxCustomRTTIInspector; AComponents: TcxComponentList;
  AFilter: TTypeKinds; AProc: TcxGetPropEditProc);
var
  I, J, CompCount: Integer;
  CompType: TClass;
  Candidates: TcxPropInfoList;
  PropLists: TList;
  Editor: TcxPropertyEditor;
  EdClass: TcxPropertyEditorClass;
  PropInfo: PPropInfo;
  AddEditor: Boolean;
  Obj: TPersistent;
begin
  if (AComponents = nil) or (AComponents.Count = 0) then Exit;
  CompCount := AComponents.Count;
  Obj := AComponents[0];
  CompType := AComponents[0].ClassType;
  Candidates := TcxPropInfoList.Create(AComponents[0], AFilter);
  try
    for I := Candidates.Count - 1 downto 0 do
    begin
      PropInfo := Candidates[I];
      EdClass := cxGetEditorClass(PropInfo, Obj);
      if EdClass = nil then
        Candidates.Delete(I)
      else
      begin
        Editor := EdClass.Create(AOwner, AInspector, 1);
        try
          Editor.SetPropEntry(0, Obj, PropInfo);
          with PropInfo^ do
            if (GetProc = nil) or
              ((PropType^.Kind <> tkClass) and (SetProc = nil)) or
              ((CompCount > 1) and
              not (ipaMultiSelect in Editor.GetAttributes)) or
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
        PropLists.Add(TcxPropInfoList.Create(AComponents[I], AFilter));
      for I := 0 to CompCount - 1 do
        Candidates.Intersect(TcxPropInfoList(PropLists[I]));
      for I := 0 to CompCount - 1 do
        TcxPropInfoList(PropLists[I]).Intersect(Candidates);
      for I := 0 to Candidates.Count - 1 do
      begin
        EdClass := cxGetEditorClass(Candidates[I], Obj);
        if EdClass = nil then Continue;
        Editor := EdClass.Create(AOwner, AInspector, CompCount);
        try
          AddEditor := True;
          for J := 0 to CompCount - 1 do
          begin
            if (AComponents[J].ClassType <> CompType) and
              (cxGetEditorClass(TcxPropInfoList(PropLists[J])[I],
                AComponents[J]) <> EdClass) then
            begin
              AddEditor := False;
              Break;
            end;
            Editor.SetPropEntry(J, AComponents[J], TcxPropInfoList(PropLists[J])[I]);
          end;
        except
          Editor.Free;
          raise;
        end;
        if AddEditor and Editor.ValueAvailable and Assigned(AProc) then
          AProc(Editor)
        else
          Editor.Free;
      end;
    finally
      for I := 0 to PropLists.Count - 1 do TcxPropInfoList(PropLists[I]).Free;
      PropLists.Free;
    end;
  finally
    Candidates.Free;
  end;
end;

{ TcxRTTIInspectorEditingController }

procedure TcxRTTIInspectorEditingController.HideEdit(Accept: Boolean);

  procedure RemoveEditing;
  begin
    EditingItem := nil;
    HideInplaceEditor;
  end;

var
  AEditViewInfo: TcxEditCellViewInfo;
  AItem: TcxCustomInplaceEditContainer;
  ASaveIndex: Integer;
begin
  if FDeactivating then Exit;
  Controller.CancelCheckEditPost;
  CancelEditUpdatePost;
  StopEditShowingTimer;
  if EditHiding or not IsEditing then Exit;
  EditHiding := True;
  try
    if Accept then
    begin
      FDeactivating := True;
      if Inspector.FocusedRow <> nil then
        ASaveIndex := Inspector.FocusedRow.AbsoluteIndex
      else
        ASaveIndex := -1;
      try
        try
          if not Edit.Deactivate then raise EAbort.Create('');
          Controller.DataController.PostEditingData;
        except
          RemoveEditing;
          with Inspector do
            if CanFocusEx then SetFocus;
          raise;
        end;
      finally
        with Inspector do
          if Reloaded then
          begin
            RemoveEditing;
            if (ASaveIndex >= 0) and (ASaveIndex < Rows.Count) then
            begin
              Controller.InternalSetRowAndCell(TcxPropertyRow(Rows[ASaveIndex]), 0);
              Controller.InternalSetFocusedItem(TcxPropertyRow(Rows[ASaveIndex]).EditContainer)
            end
            else
            begin
              Controller.InternalSetRowAndCell(nil, 0);
              Controller.InternalSetFocusedItem(nil);
            end;
            Controller.RefreshFocusedRow;
            Controller.FNeedCorrect := True;
          end;
        FDeactivating := False;
      end;
      IsErrorOnEditExit := False;
      if EditingItem = nil then Exit;
      AEditViewInfo := Controller.GetFocusedCellViewInfo(EditingItem);
      if AEditViewInfo <> nil then
        Edit.ActiveProperties.Update(
          TcxEditCellViewInfoAccess(AEditViewInfo).Properties);
    end;
    AItem := EditingItem;
    TcxCustomRTTIInspector(EditingControl).DoEdited(AItem);
    EditingItem := nil;
    Controller.RefreshFocusedCellViewInfo(AItem);
    HideInplaceEditor;
    IsErrorOnEditExit := False;
  finally
    EditHiding := False;
  end;
end;

function TcxRTTIInspectorEditingController.GetController: TcxRTTIInspectorController;
begin
  Result := TcxRTTIInspectorController(inherited Controller);
end;

function TcxRTTIInspectorEditingController.GetInspector: TcxCustomRTTIInspector;
begin
  Result := TcxCustomRTTIInspector(EditingControl);
end;

{ TcxRTTIInspectorController }

procedure TcxRTTIInspectorController.SetFocusedRecordItem(
  ARecordIndex: Integer; AItem: TcxCustomInplaceEditContainer);
var
  AIndex: Integer;
begin
  AIndex := GetRowIndexFromCellEdit(AItem);
  EditingController.HideEdit(True);
  if FNeedCorrect then
  begin
    if (AIndex >= 0) and (AIndex < Inspector.Rows.Count) and
      (Inspector.Rows[AIndex] is TcxPropertyRow) then
      AItem := TcxPropertyRow(Inspector.Rows[AIndex]).EditContainer
    else
      AItem := nil;
    FNeedCorrect := False;
  end;
  AllowCheckEdit := False;
  try
    DisableCellsRefresh := (FocusedRecordIndex = ARecordIndex);
    FocusedRecordIndex := ARecordIndex;
    DisableCellsRefresh := DisableCellsRefresh and (FocusedItem = AItem);
    FocusedItem := AItem;
  finally
    AllowCheckEdit := True;
    CheckEdit;
    DisableCellsRefresh := False;
  end;
end;

procedure TcxRTTIInspectorController.BeforeEditKeyDown(var Key: Word;
  var Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ssCtrl in Shift) then
  begin
    Key := 0;
    Inspector.TryInvokePropertyEditorDlg;
  end;
end;

procedure TcxRTTIInspectorController.DoEditDblClick(Sender: TObject);
begin
  with Inspector do
    if (PropertyEditor <> nil) and not (ipaRevertable in PropertyEditor.GetAttributes) then
      TryInvokePropertyEditorDlg;
end;

procedure TcxRTTIInspectorController.DoUpdateRowAndCell(ANewRow: TcxCustomRow;
  ANewCellIndex: Integer);
begin
  if Inspector.LockRefresh then Exit;
  inherited DoUpdateRowAndCell(ANewRow, ANewCellIndex);
end;

procedure TcxRTTIInspectorController.FocusChanged;
begin
  if FFocusChanging or Inspector.LockRefresh then Exit;
  FFocusChanging := True;
  try
    inherited FocusChanged;
  finally
    FFocusChanging := False;
  end;
end;

function TcxRTTIInspectorController.IsKeyForController(AKey: Word;
  AShift: TShiftState): Boolean;
begin
  Result := inherited IsKeyForController(AKey, AShift) or
    ((AKey = VK_RETURN) and (ssCtrl in AShift));
end;

procedure TcxRTTIInspectorController.SetFocusedItem(
  Value: TcxCustomInplaceEditContainer);
var
  AIndex: Integer;
begin
  if Inspector.LockRefresh then Exit;
  try
    AIndex := GetRowIndexFromCellEdit(Value);
    if IsEditing then EditingController.HideEdit(True);
    if FNeedCorrect then
    begin
      if (AIndex >= 0) and (AIndex < Inspector.Rows.Count) and
        (Inspector.Rows[AIndex] is TcxPropertyRow) then
        Value := TcxPropertyRow(Inspector.Rows[AIndex]).EditContainer
      else
        Value := nil;
      FNeedCorrect := False;
    end;
    inherited SetFocusedItem(Value);
  finally
    Inspector.FReloaded := False;
  end;
end;

procedure TcxRTTIInspectorController.SetFocusedRowAndCell(Value: TcxCustomRow;
  ACellIndex: Integer);
var
  AEditContainer: TcxCustomInplaceEditContainer;
begin
  if EditingController.Deactivating or Inspector.IsDesigning or
    Assigned(Value) and not TcxCustomRowAccess(Value).CanFocus then Exit;
  FLockUpdate := True;
  try
    if (Value <> nil) and (Value is TcxPropertyRow) then
      AEditContainer := TcxPropertyRow(Value).GetEditContainer(ACellIndex)
    else
      AEditContainer := nil;
    FNeedCorrect := False;
    if FocusedItem <> AEditContainer then
      FocusedItem := AEditContainer;
    if FocusedItem <> nil then
      Value := TcxCellEdit(FocusedItem).Row
    else
      Value := nil;
  finally
    FLockUpdate := False;
    AllowCheckEdit := True;
  end;
  inherited DoUpdateRowAndCell(Value, ACellIndex);
end;

function TcxRTTIInspectorController.GetEditingController: TcxRTTIInspectorEditingController;
begin
  Result := TcxRTTIInspectorEditingController(inherited EditingController);
end;

function TcxRTTIInspectorController.GetFocusedRowIndex: Integer;
begin
  if FocusedRow = nil then
    Result := -1
  else
    Result := FocusedRow.AbsoluteIndex;
end;

function TcxRTTIInspectorController.GetInspector: TcxCustomRTTIInspector;
begin
  Result := TcxCustomRTTIInspector(EditingControl);
end;

function TcxRTTIInspectorController.GetRowIndexFromCellEdit(
  Value: TcxCustomInplaceEditContainer): Integer;
begin
  if Value <> nil then
    Result := TcxCellEdit(Value).Row.AbsoluteIndex
  else
    Result := -1;
end;

procedure TcxRTTIInspectorController.SetFocusedRowIndex(AIndex: Integer);
var
  ARow: TcxCustomRow;
  AItem: TcxCustomInplaceEditContainer;
begin
  AItem := nil;
  if (AIndex >= 0) and (AIndex < Inspector.Rows.Count) then
  begin
    ARow := Inspector.Rows[AIndex];
    if ARow is TcxPropertyRow then
      AItem := TcxPropertyRow(ARow).EditContainer;
  end
  else
    ARow := nil;
  InternalSetRowAndCell(ARow, 0);
  InternalSetFocusedItem(AItem);
end;

{ TcxRTTIInspectorOptionsView }

constructor TcxRTTIInspectorOptionsView.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  PaintStyle := psDelphi;
  ShowEditButtons := ecsbFocused;
end;

{ TcxRTTIInspectorOptionsBehavior }

constructor TcxRTTIInspectorOptionsBehavior.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  AlwaysShowEditor := True;
end;

{ TcxCustomRTTIInspector }

constructor TcxCustomRTTIInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OptionsBehavior.CellHints := True;
  OptionsBehavior.AlwaysShowEditor := True;
  FBoldFont := TFont.Create;
  FBoldFont.Assign(Font);
  FBoldFont.Style := FBoldFont.Style + [fsBold];
end;

destructor TcxCustomRTTIInspector.Destroy;
begin
  if FListeners <> nil then
  begin
    CloseNonModalEditors;
    FListeners.Free;
  end;
  ReleaseComponentProperties;
  FBoldFont.Free;
  inherited Destroy;
end;

procedure TcxCustomRTTIInspector.AddListener(AListener: TPersistent);
begin
  if FListeners = nil then FListeners := TList.Create;
  if (AListener <> nil) and (FListeners.IndexOf(AListener) < 0) then
    FListeners.Add(AListener)
end;

procedure TcxCustomRTTIInspector.CloseNonModalEditors;
var
  I: Integer;
  AIntf: IcxRTTIInspectorHelper;
begin
  if FListeners <> nil then
    for I := 0 to FListeners.Count - 1 do
      if Supports(TObject(FListeners[I]), IcxRTTIInspectorHelper, AIntf) then
      begin
        AIntf.CloseNonModal(Self);
        AIntf := nil;
      end;
end;

procedure TcxCustomRTTIInspector.RefreshInspectedProperties;

  function GetFullName(ARow: TcxCustomRow): string;
  begin
    Result := '';
    repeat
      if ARow is TcxPropertyRow then
        Result := UpperCase(TcxPropertyRow(ARow).Properties.Caption) + ' ' + Result;
      ARow := ARow.Parent;
    until ARow = nil;
  end;

var
  ALayout: TStringList;
  AIndex, I, J: Integer;
  AObject: TPersistent;
  ARow: TcxCustomRow;
  AFullName: string;
begin
  BeginUpdate;
  FLockRefresh := True;
  try
    FSaveTopRowIndex := TopVisibleRowIndex;
    ALayout := TStringList.Create;
    try
      for I := 0 to Rows.Count - 1 do
      begin
        ARow := Rows[I];
        if ARow.Expanded then
          ALayout.Add(GetFullName(ARow));
      end;
      AObject := InspectedObject;
      AIndex := Controller.GetFocusedRowIndex;
      InspectedObject := nil;
      InspectedObject := AObject;
      if ALayout.Count > 0 then
        for I := 0 to Rows.Count - 1 do
        begin
          ARow := Rows[I];
          AFullName := GetFullName(ARow);
          for J := 0 to ALayout.Count - 1 do
            if ALayout[J] = AFullName then
              ARow.Expanded := True;
        end;
      ViewInfo.Calculate;
      TopVisibleRowIndex := FSaveTopRowIndex;
      FLockRefresh := False;
      if not Controller.EditingController.FDeactivating then
        Controller.SetFocusedRowIndex(AIndex);
    finally
      ALayout.Free;
    end;
  finally
    EndUpdate;
    FReloaded := True;
    FLockRefresh := False;
    if not Controller.EditingController.FDeactivating then
      Controller.CheckEdit
  end;
end;

procedure TcxCustomRTTIInspector.RemoveListener(AListener: TPersistent);
begin
  if (FListeners <> nil) and (FListeners.IndexOf(AListener) >= 0) then
    FListeners.Remove(AListener);
end;

procedure TcxCustomRTTIInspector.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (AComponent = InspectedObject) then
    InspectedObject := nil;
end;

procedure TcxCustomRTTIInspector.DataChanged;
begin
end;

function TcxCustomRTTIInspector.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
   MousePos: TPoint): Boolean;
var
  ARow: TcxCustomRow;
begin
  if ([ssShift] = Shift)  and not IsScrollingContent then
  begin
    if WheelDelta > 0 then
      ARow := PrevVisibleRow(FocusedRow)
    else
      ARow := NextVisibleRow(FocusedRow);
    if ARow <> nil then FocusedRow := ARow;
    Result := ARow <> nil;
  end
  else
    Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
end;

procedure TcxCustomRTTIInspector.FontChanged;
begin
  FBoldFont.Assign(Font);
  FBoldFont.Style := FBoldFont.Style + [fsBold];
  inherited FontChanged;
end;

procedure TcxCustomRTTIInspector.Loaded;
begin
  inherited Loaded;
  if not IsDesigning and Assigned(InspectedObject) then
  begin
    HandleNeeded;
    CreatePropertyRows(nil);
  end;
end;

function TcxCustomRTTIInspector.FilterProperty(const APropertyName: string): Boolean;
begin
  Result := True;
  if Assigned(FOnFilterProperty) then FOnFilterProperty(Self, APropertyName, Result);
end;

function TcxCustomRTTIInspector.FilterPropertyEx(const AFullPropertyName: string): Boolean;
begin
  Result := True;
  if Assigned(FOnFilterPropertyEx) then FOnFilterPropertyEx(Self, AFullPropertyName, Result);
end;

function TcxCustomRTTIInspector.FindRowByPropertyName(const APropertyName: string): TcxPropertyRow;
var
  I: Integer;
begin
  if APropertyName <> '' then
    for I := 0 to Rows.Count - 1 do
      if Rows[I] is TcxPropertyRow then
      begin
        Result := TcxPropertyRow(Rows[I]);
        if CompareText(APropertyName, Result.PropertyEditor.GetName) = 0 then
          Exit;
      end;
  Result := nil;
end;

procedure TcxCustomRTTIInspector.FocusRowByPropertyName(const APropertyName: string);
var
  ARow: TcxCustomRow;
begin
  ARow := FindRowByPropertyName(APropertyName);
  if ARow = nil then ARow := FirstVisibleRow;
  FocusedRow := ARow;
end;

function TcxCustomRTTIInspector.GetEditPropertiesClass(APropertyEditor: TcxPropertyEditor): TcxCustomEditPropertiesClass;
var
  AFullPropertyName: string;
  ARow: TcxPropertyRow;
begin
  AFullPropertyName := APropertyEditor.GetName;
  ARow := TcxPropertyRow(FParentRow);
  while ARow <> nil do
  begin
    if ARow.PropertyEditor <> nil then
    begin
      if AFullPropertyName <> '' then
        AFullPropertyName := '.' + AFullPropertyName;
      AFullPropertyName := ARow.PropertyEditor.GetName + AFullPropertyName;
    end;
    ARow := TcxPropertyRow(ARow.Parent);
  end;
  if FilterProperty(APropertyEditor.GetName) and FilterPropertyEx(AFullPropertyName) then
  begin
    Result := cxGetPropertiesClassByEditor(APropertyEditor);
    if Result = TcxColorComboBoxProperties then Exit;
    if ipaDialog in APropertyEditor.GetAttributes then
      Result := TcxButtonEditProperties;
    if ipaValueList in APropertyEditor.GetAttributes then
      Result := TcxComboBoxProperties;
    if Result = nil then
      Result := TcxTextEditProperties
  end
  else
    Result := nil;
end;

procedure TcxCustomRTTIInspector.PostChangedNotification;
begin
  PostMessage(Handle, DXM_VG_PROPERTYCHANGED, 0, 0);
end;

procedure TcxCustomRTTIInspector.PrepareEditProperties(
  AProperties: TcxCustomEditProperties; APropertyEditor: TcxPropertyEditor);
begin
  with TcxCustomEditPropertiesAccess(AProperties) do
  begin
    //todo: need cxEditors fix
    ClickKey := 0;
    //remove ipaSubProperties for TcxVariantProperty
    ReadOnly := ([ipaReadOnly] * APropertyEditor.GetAttributes <> []);
    UseMouseWheel := False;
    ValidateOnEnter := True;
    OnChange := EditChange;
    OnEditValueChanged := EditValueChanged;
  end;
  if AProperties is TcxCustomTextEditProperties then
    TcxCustomTextEditProperties(AProperties).MaxLength := APropertyEditor.GetEditLimit;
  if AProperties is TcxComboBoxProperties then
  begin
    APropertyEditor.GetValues(GetStrProc);
    with TcxComboBoxProperties(AProperties) do
    begin
      DropDownAutoWidth := True;
      ImmediateDropDown := False;
      Revertable := ipaRevertable in APropertyEditor.GetAttributes;
    end;
  end;
  if AProperties is TcxColorComboBoxProperties then
    with TcxColorComboBoxPropertiesAccess(AProperties) do
    begin
      //todo exteditors bug
      //DropDownListStyle := lsEditFixedList;
      ColorValueFormat := cxcvHexadecimal;
      DropDownListStyle := lsEditList;
      MaxMRUColors := 0;
      ColorBoxWidth := 16;
      PrepareDelphiColorList(False, False);
    end;
  if AProperties is TcxButtonEditProperties then
    with TcxButtonEditProperties(AProperties) do
      OnButtonClick := RowButtonClick;
  if AProperties is TcxSpinEditProperties then
    TcxSpinEditProperties(AProperties).UseCtrlIncrement := True;
  APropertyEditor.AdjustInnerEditProperties(AProperties);
end;

procedure TcxCustomRTTIInspector.DoPropertyChanged;
var
  I: Integer;
  AIntf: IcxRTTIInspectorHelper;
begin
  if FListeners <> nil then
    for I := 0 to FListeners.Count - 1 do
      if Supports(TObject(FListeners[I]), IcxRTTIInspectorHelper, AIntf) then
      begin
        AIntf.PropertyChanged(Self);
        AIntf := nil;
      end;
  if Assigned(FOnPropertyChanged) then FOnPropertyChanged(Self);
end;

procedure TcxCustomRTTIInspector.EditChange(Sender: TObject);
begin
  if (PropertyEditor <> nil) and (ipaAutoUpdate in PropertyEditor.GetAttributes) then
  begin
    if Sender is TcxCustomTextEdit then
    begin
      try
        PropertyEditor.Value := TcxCustomTextEdit(Sender).Text;
        DoPropertyChanged;
      except
        TcxCustomTextEdit(Sender).Text := PropertyEditor.GetValue;
        raise
      end;
    end
    else
      TrySetValue(TcxCustomEdit(Sender), True);
  end;
end;

procedure TcxCustomRTTIInspector.EditValueChanged(Sender: TObject);
begin
  if not ((PropertyEditor <> nil) and (ipaAutoUpdate in PropertyEditor.GetAttributes)) then
    TrySetValue(TcxCustomEdit(Sender), False);
  Controller.CheckPostData;
end;

function TcxCustomRTTIInspector.GetControllerClass: TcxCustomControlControllerClass;
begin
  Result := TcxRTTIInspectorController;
end;

procedure TcxCustomRTTIInspector.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
var
  AIsUnfocusedColor: Boolean;
  ARow: TcxPropertyRow;
  AFocused: Boolean;

  function IsRootParentComponent: Boolean;
  var
    AParent: TcxCustomRow;
  begin
    Result := True;
    AParent := ARow.Parent;
    while (AParent <> nil) and not AParent.IsRootLevel do
    begin
      if (AParent is TcxPropertyRow) and
        (TcxPropertyRow(AParent).PropertyEditor is TcxComponentProperty) and
        (TcxPropertyRow(AParent).PropertyEditor.GetComponent(0) <> InspectedObject) then
      begin
        Result := False;
        Exit;
      end;
      AParent := AParent.Parent;
    end;
  end;

begin
  with AParams do
    case Index of
      vgs_Content:
        begin
          Bitmap := nil;
          with PcxvgContentParamsData(AData)^ do
          begin
            ARow := TcxPropertyRow(Row);
            AFocused := Focused;
          end;
          AIsUnfocusedColor := not AFocused or ARow.Properties.EditProperties.ReadOnly;
          Color := ViewInfo.CalcHelper.GetContentColor(not AIsUnfocusedColor);
          if not (AFocused or ARow.IsDefaultValue) then
            Font := FBoldFont
          else
            Font := Self.Font;
          TextColor := ViewInfo.CalcHelper.GetContentTextColor;
        end;
      vgs_Header:
        if TcxCustomRow(AData) is TcxPropertyRow then
        begin
          Bitmap := nil;
          ARow := TcxPropertyRow(AData);
          Color := ViewInfo.CalcHelper.GetHeaderColor;
          Font := Self.Font;
          if ARow.PropertyEditor is TcxComponentProperty then
            TextColor := clMaroon
          else
            if IsRootParentComponent then
              TextColor := ViewInfo.CalcHelper.GetHeaderTextColor
            else
              TextColor := clGreen;
        end
        else
          inherited GetDefaultViewParams(Index, AData, AParams);
    else
      inherited GetDefaultViewParams(Index, AData, AParams);
    end;
end;

function TcxCustomRTTIInspector.GetEditingControllerClass: TcxEditingControllerClass;
begin
  Result := TcxRTTIInspectorEditingController;
end;

function TcxCustomRTTIInspector.GetOptionsBehaviorClass: TcxControlOptionsBehaviorClass;
begin
  Result := TcxRTTIInspectorOptionsBehavior;
end;

function TcxCustomRTTIInspector.GetOptionsViewClass: TcxControlOptionsViewClass;
begin
  Result := TcxRTTIInspectorOptionsView;
end;

function TcxCustomRTTIInspector.CanInvokePropertyEditorDlg: Boolean;
begin
  Result := (PropertyEditor <> nil) and
    ((ipaDialog in PropertyEditor.GetAttributes) or (ipaValueList in PropertyEditor.GetAttributes));
end;

procedure TcxCustomRTTIInspector.CNPropertyChanged(var AMessage: TMsg);
begin
  DoPropertyChanged;
end;

procedure TcxCustomRTTIInspector.CreatePropertyRows(AOldInspectedObject: TPersistent);
var
  APropName: string;
begin
  APropName := '';
  BeginUpdate;
  try
    if AOldInspectedObject <> nil then
    begin
      if PropertyEditor <> nil then APropName := PropertyEditor.GetName;
      ReleaseComponentProperties;
    end;
    if FInspectedObject <> nil then
      GetComponentsProperties([FInspectedObject]);
  finally
    EndUpdate;
  end;
  //todo: move before EndUpdate;
  if not LockRefresh then
    FocusRowByPropertyName(APropName);
end;

procedure TcxCustomRTTIInspector.CreateRows(APropertyEditor: TcxPropertyEditor);
var
  AEditPropertiesClass: TcxCustomEditPropertiesClass;
begin
  AEditPropertiesClass := GetEditPropertiesClass(APropertyEditor);
  if AEditPropertiesClass = nil then
  begin
    APropertyEditor.Free;
    Exit;
  end;
  FCurrentRow := TcxPropertyRow(AddChild(FParentRow, TcxPropertyRow));
  with FCurrentRow.Properties do
  begin
    Caption := APropertyEditor.GetName;
    FCurrentRow.FIsDefaultValue := APropertyEditor.IsDefaultValue;
    EditPropertiesClass := AEditPropertiesClass;
    PrepareEditProperties(EditProperties, APropertyEditor);
  end;
  FCurrentRow.FPropertyEditor := APropertyEditor;
  FCurrentRow.Properties.Value := APropertyEditor.Value;
  if ipaSubProperties in APropertyEditor.GetAttributes then
  begin
    FParentRow := FCurrentRow;
    APropertyEditor.GetProperties(APropertyEditor.FOwner, CreateRows);
    FParentRow := FParentRow.Parent; //check for nil
  end;
end;

procedure TcxCustomRTTIInspector.GetComponentsProperties(
  const AInstances: array of TPersistent);

  function FindRootOwner(APersistent: TPersistent): TComponent;
  begin
    if (APersistent is TComponent) then
      Result := TComponent(APersistent).Owner
    else Result := nil;
    if Result <> nil then
      while (Result.Owner <> nil) and not (Result is TDataModule) and
        not (Result is TCustomForm) {$IFDEF DELPHI5} and not (Result is TCustomFrame) {$ENDIF} do
        Result := Result.Owner;
  end;

var
  ComponentList: TcxComponentList;
  I: Integer;
  AOwner: TComponent;
begin
  ComponentList := TcxComponentList.Create;
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
    cxGetComponentProperties(AOwner, Self, ComponentList, tkProperties, CreateRows);
    FullCollapse;
    FParentRow := nil;
    FCurrentRow := nil;
  finally
    ComponentList.Free;
  end;
end;

function TcxCustomRTTIInspector.GetController: TcxRTTIInspectorController;
begin
  Result := TcxRTTIInspectorController(FController);
end;

function TcxCustomRTTIInspector.GetPropertyEditor: TcxPropertyEditor;
begin
  if FocusedRow <> nil then
    Result := TcxPropertyRow(FocusedRow).PropertyEditor
  else
    Result := nil;
end;

procedure TcxCustomRTTIInspector.GetStrProc(const S: string);
begin
  TcxComboBoxProperties(TcxPropertyRow(FCurrentRow).Properties.EditProperties).Items.Add(S);
end;

procedure TcxCustomRTTIInspector.ReleaseComponentProperties;
var
  I: Integer;
  ARow: TcxCustomRow;
begin
  for I := 0 to Rows.Count - 1 do
  begin
    ARow := Rows[I];
    if ARow is TcxPropertyRow then
      with TcxPropertyRow(ARow) do
      begin
        if PropertyEditor is TcxPropertyEditor then
        begin
          PropertyEditor.Free;
          FPropertyEditor := nil;
        end;
      end;
  end;
  if not (csDestroying in ComponentState) then
    ClearRows;
end;

procedure TcxCustomRTTIInspector.RowButtonClick(Sender: TObject; AbsoluteIndex: Integer);
begin
  TryInvokePropertyEditorDlg;
end;

procedure TcxCustomRTTIInspector.SetInspectedObject(Value: TPersistent);
var
  OldInspectedObject: TPersistent;
begin
  if (FInspectedObject <> Value) and IsValidInspectedObject(Value, Self) then
  begin
    if not (csDestroying in ComponentState) then
      OldInspectedObject := FInspectedObject
    else
      OldInspectedObject := nil;
    if not FLockRefresh and (OldInspectedObject <> nil) and
      not OptionsData.CancelOnExit and Controller.IsEditing then
    begin
      TrySetValue(Controller.EditingController.Edit, True);
    end;
    FInspectedObject := Value;
    if (FInspectedObject <> nil) and (FInspectedObject is TComponent) then
      TComponent(Value).FreeNotification(Self);
    if ([csDesigning, csLoading, csDestroying] * ComponentState) = [] then
      CreatePropertyRows(OldInspectedObject);
  end;
end;

procedure TcxCustomRTTIInspector.TryInvokePropertyEditorDlg;
begin
  if CanInvokePropertyEditorDlg then
  begin
    PropertyEditor.Edit;
    RefreshInspectedProperties;
  end;
end;

function TcxCustomRTTIInspector.TrySetValue(
  AEdit: TcxCustomEdit; AUseText: Boolean): Boolean;
var
  V: Variant;
begin
  Result := False;
  if FSettingValue or (PropertyEditor = nil) then Exit;
  FSettingValue := True;
  try
    V := PropertyEditor.Value;
    try
      if AUseText and (AEdit is TcxCustomTextEdit) then
        PropertyEditor.Value := TcxCustomTextEdit(AEdit).Text
      else
        PropertyEditor.Value := AEdit.EditValue;
      Result := True;
    except
      PropertyEditor.Value := V;
      AEdit.EditValue := V;
      raise;
    end;
    DoPropertyChanged;
    RefreshInspectedProperties;
  finally
    FSettingValue := False;
  end;
end;

procedure cxDotNetInspectObject(AObject: TPersistent; AInspector: TcxRTTIInspector);
var
  I: Integer;
  C: TcxCategoryRow;
begin
  if AObject <> nil then
    with AInspector do
    begin
      InspectedObject := nil;
      BeginUpdate;
      try
        InspectedObject := AObject;
        OptionsBehavior.AlwaysShowEditor := False;
        OptionsView.GridLineColor := clBtnFace;
        OptionsView.PaintStyle := psdotNet;
        C := TcxCategoryRow(Add(TcxCategoryRow));
        with C do
        begin
          if (AObject is TComponent) and (TComponent(AObject).Name <> '') then
            Properties.Caption := TComponent(AObject).Name + ': ' + AObject.ClassName
          else
            Properties.Caption := AObject.ClassName;
          Properties.HeaderAlignmentVert := vaCenter;
          Index := 0;
        end;
        for I := 1 to Rows.Count - 1 do
          if Rows[I].Level = 0 then
            Rows[I].Parent := C;
      finally
        FocusedRow := FirstVisibleRow;
        EndUpdate;
      end;
    end;
end;

{ TcxInspectedObjectPropertyEditor }

function TcxInspectedObjectPropertyEditor.IsValidComponent(AComponent: TComponent): Boolean;
begin
  Result := inherited IsValidComponent(AComponent) and
    IsValidInspectedObject(AComponent, Inspector);
end;

initialization
  cxRegisterPropertyEditor(TypeInfo(TColor), nil, '', TcxColorProperty);
  cxRegisterPropertyEditor(TypeInfo(TFont), nil, '', TcxFontProperty);
  cxRegisterPropertyEditor(TypeInfo(TFontCharset), nil, '', TcxFontCharsetProperty);
  cxRegisterPropertyEditor(TypeInfo(TFontName), nil, '', TcxFontNameProperty);
  cxRegisterPropertyEditor(TypeInfo(TCursor), nil, '', TcxCursorProperty);
  cxRegisterPropertyEditor(TypeInfo(string), TMediaPlayer, 'FileName', TcxMPFilenameProperty);
  cxRegisterPropertyEditor(TypeInfo(TCaption), nil, '', TcxCaptionProperty);
  cxRegisterPropertyEditor(TypeInfo(TComponent), nil, '', TcxComponentProperty);
  cxRegisterPropertyEditor(TypeInfo(TComponentName), nil, '', TcxComponentNameProperty);
  cxRegisterPropertyEditor(TypeInfo(TImeName), nil, '', TcxImeNameProperty);
  cxRegisterPropertyEditor(TypeInfo(TModalResult), nil, '', TcxModalResultProperty);
  cxRegisterPropertyEditor(TypeInfo(TShortCut), nil, '', TcxShortCutProperty);
  cxRegisterPropertyEditor(TypeInfo(TTabOrder), nil, '', TcxTabOrderProperty);
  cxRegisterPropertyEditor(TypeInfo(TDate), nil, '', TcxDateProperty);
  cxRegisterPropertyEditor(TypeInfo(TTime), nil, '', TcxTimeProperty);
  cxRegisterPropertyEditor(TypeInfo(TDateTime), nil, '', TcxDateTimeProperty);
  cxRegisterPropertyEditor(TypeInfo(Boolean), nil, '', TcxBoolProperty);
  cxRegisterPropertyEditor(TypeInfo(TStrings), nil, '', TcxStringsProperty);
  cxRegisterPropertyEditor(TypeInfo(TPicture), nil, '', TcxPictureProperty);
  cxRegisterPropertyEditor(TypeInfo(TBitmap), nil, '', TcxGraphicProperty);
  cxRegisterPropertyEditor(TypeInfo(Variant), nil, '', TcxVariantProperty);

  cxRegisterPropertyEditor(TypeInfo(TPersistent),
    TcxCustomRTTIInspector, 'InspectedObject', TcxInspectedObjectPropertyEditor);

  cxRegisterEditPropertiesClass(TcxCaptionProperty, TcxTextEditProperties);
  cxRegisterEditPropertiesClass(TcxColorProperty, TcxColorComboBoxProperties);
  cxRegisterEditPropertiesClass(TcxComponentNameProperty, TcxTextEditProperties);
  cxRegisterEditPropertiesClass(TcxComponentProperty, TcxComboBoxProperties);
  cxRegisterEditPropertiesClass(TcxCursorProperty, TcxComboBoxProperties);
  cxRegisterEditPropertiesClass(TcxDateProperty, TcxDateEditProperties);
  cxRegisterEditPropertiesClass(TcxDateTimeProperty, TcxTextEditProperties);
  cxRegisterEditPropertiesClass(TcxFontCharsetProperty, TcxComboBoxProperties);
  cxRegisterEditPropertiesClass(TcxFontNameProperty, TcxComboBoxProperties);
  cxRegisterEditPropertiesClass(TcxFontProperty, TcxTextEditProperties);
  cxRegisterEditPropertiesClass(TcxIntegerProperty, TcxSpinEditProperties);
  cxRegisterEditPropertiesClass(TcxImeNameProperty, TcxTextEditProperties);
  cxRegisterEditPropertiesClass(TcxModalResultProperty, TcxComboBoxProperties);
  cxRegisterEditPropertiesClass(TcxMPFilenameProperty, TcxTextEditProperties);
  cxRegisterEditPropertiesClass(TcxPictureProperty, TcxButtonEditProperties);
  cxRegisterEditPropertiesClass(TcxShortCutProperty, TcxComboBoxProperties);
  cxRegisterEditPropertiesClass(TcxStringsProperty, TcxButtonEditProperties);
  cxRegisterEditPropertiesClass(TcxTabOrderProperty, TcxSpinEditProperties);
  cxRegisterEditPropertiesClass(TcxTimeProperty, TcxTimeEditProperties);
  //
  cxRegisterPropertyEditor(TypeInfo(string), TcxCustomEditorRowProperties, 'EditPropertiesClassName', nil);
  cxRegisterPropertyEditor(TypeInfo(TcxCustomEditProperties), TcxCustomEditorRowProperties, 'EditProperties', TcxEditPropertiesProperty);

finalization
  ListFreeAndNil(FEditPropertiesClasses);
  ListFreeAndNil(FPropertyClasses);
  ListFreeAndNil(FPropertyMappers);

end.
