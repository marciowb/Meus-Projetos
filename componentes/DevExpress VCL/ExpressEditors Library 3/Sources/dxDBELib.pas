
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express data aware standalone editors                       }
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

unit dxDBELib;

interface

{$I dxEdLVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  dxCntner, dxExEdtr, dxEdLib, DB, DBConsts, dxDBEdtr{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  TdxEditDBDataDefinition = class;

  { TdxEditDataLink }
  TdxEditDataLink = class(TDataLink)
  private
    FDBDataDefinition: TdxEditDBDataDefinition;
    FField: TField;
    FFieldName: string;
    FModified: Boolean;
    procedure SetField(Value: TField);
    procedure SetFieldName(const Value: string);
    procedure UpdateField;
  protected
    // override TDataLink
    procedure ActiveChanged; override;
    procedure EditingChanged; override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    constructor Create(ADBDataDefinition: TdxEditDBDataDefinition);
    procedure Modified;
    procedure Reset;
    property Field: TField read FField;
    property FieldName: string read FFieldName write SetFieldName;
  end;

  { TdxEditDBDataDefinition }
  TdxEditDBNotification = class(TComponent) // because TdxEditDataDefinition is TPersistent
  private
    FDBDataDefinition: TdxEditDBDataDefinition;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property DBDataDefinition: TdxEditDBDataDefinition read FDBDataDefinition;
  end;

  TdxEditDBDataDefinition = class(TdxEditDataDefinition)
  private
    FDataLink: TdxEditDataLink;
    FDBNotification: TdxEditDBNotification;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
  protected
    function CanEditModify: Boolean; override;
    function GetAlignment: TAlignment; override;
    function GetDisplayFormat: string; override;
    function GetDisplayValue: Variant; override;
    function GetEditLimit: Integer; override;
    function GetEditMask: string; override;
    function GetEditValue: Variant; override;
    function GetLinkObject: TObject; override;
    function GetMaxValue: Double; override;
    function GetMinValue: Double; override;
    function GetRequired: Boolean; override;
    function IsCanModify: Boolean; override;
    function IsFloatValue: Boolean; override;
    function IsReadOnly: Boolean; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    procedure Modified; override;
    procedure Reset; override;
    procedure SetEditValue(const Value: Variant); override;
    procedure UpdateRecord; override;
    {$IFDEF DELPHI4}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property DataField: string read GetDataField write SetDataField;
    property DataLink: TdxEditDataLink read FDataLink;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Field: TField read GetField;
  end;

  { TCustomdxDBEdit }
  TCustomdxDBEdit = class(TCustomdxEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBEdit }
  TdxDBEdit = class(TCustomdxDBEdit)
  public
    property DataDefinition;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property DataField;
    property DataSource;
    property HideSelection;
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
  end;

  { TCustomdxDBMaskEdit }
  TCustomdxDBMaskEdit = class(TCustomdxMaskEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBMaskEdit }
  TdxDBMaskEdit = class(TCustomdxDBMaskEdit)
  public
    property DataDefinition;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property DataField;
    property DataSource;
    property EditMask;
    property IgnoreMaskBlank; // original
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
  end;

  { TdxMemoEditDBDataDefinition }
  TdxMemoEditDBDataDefinition = class(TdxEditDBDataDefinition)
  protected
    procedure SetEditValue(const Value: Variant); override;
  end;

  { TCustomdxDBMemo }
  TCustomdxDBMemo = class(TCustomdxMemo)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBMemo }
  TdxDBMemo = class(TCustomdxDBMemo)
  public
    property DataDefinition;
    property Lines;
  published
    property Align;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect default False;
    property CharCase;
    property DataField;
    property DataSource;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // memo
    property HideScrollBars;
    property ScrollBars;
    property SelectionBar;
    property WantReturns;
    property WantTabs;
    property WordWrap;
  end;

  { TCustomdxDBDateEdit }
  TCustomdxDBDateEdit = class(TCustomdxDateEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBDateEdit }
  TdxDBDateEdit = class(TCustomdxDBDateEdit)
  public
    property DataDefinition;
    property Date;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property DataField;
    property DataSource;
    property HideSelection;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property PopupAlignment;
    property PopupBorder;
    // date
    property DateButtons;
    property DateOnError;
    property DateValidation;
    property SaveTime;
    property UseEditMask;
    property OnDateChange;
    property OnDateValidateInput;
  end;

  { TCustomdxDBButtonEdit }
  TCustomdxDBButtonEdit = class(TCustomdxButtonEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBButtonEdit }
  TdxDBButtonEdit = class(TCustomdxDBButtonEdit)
  public
    property DataDefinition;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property DataField;
    property DataSource;
    property EditMask;
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // button
    property Buttons;
    property ClickKey;
    property ViewStyle;
    property OnButtonClick;
  end;

  { TdxCheckEditDBDataDefinition }
  TdxCheckEditDBDataDefinition = class(TdxEditDBDataDefinition)
  private
    FValueChecked: string;
    FValueGrayed: string;
    FValueUnchecked: string;
    procedure SetValueChecked(const Value: string);
    procedure SetValueGrayed(const Value: string);
    procedure SetValueUnchecked(const Value: string);
    function ValueMatch(const ValueList, Value: string): Boolean;
  protected
    function GetEditValue: Variant; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    procedure SetEditValue(const Value: Variant); override;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property ValueChecked: string read FValueChecked write SetValueChecked;
    property ValueGrayed: string read FValueGrayed write SetValueGrayed;
    property ValueUnchecked: string read FValueUnchecked write SetValueUnchecked;
  end;

  { TCustomdxDBCheckEdit }
  TCustomdxDBCheckEdit = class(TCustomdxCheckEdit)
  private
    function GetDataDefinition: TdxCheckEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetValueChecked: string;
    function GetValueGrayed: string;
    function GetValueUnchecked: string;
    procedure SetDataDefinition(Value: TdxCheckEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetValueChecked(const Value: string);
    procedure SetValueGrayed(const Value: string);
    procedure SetValueUnchecked(const Value: string);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    procedure LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean); override;
    property DataDefinition: TdxCheckEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ValueChecked: string read GetValueChecked write SetValueChecked;
    property ValueGrayed: string read GetValueGrayed write SetValueGrayed;
    property ValueUnchecked: string read GetValueUnchecked write SetValueUnchecked;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBCheckEdit }
  TdxDBCheckEdit = class(TCustomdxDBCheckEdit)
  public
    property Checked;
    property DataDefinition;
    property State;
  published
//    property Action; TODO
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSize;
    property Caption;
    property DataField;
    property DataSource;
    property ReadOnly;
    property StyleController;
    property ValueChecked;
    property ValueGrayed;
    property ValueUnchecked;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // check
    property AllowGrayed;
    property FullFocusRect;
    property Glyph;
    property GlyphCount;
    property MultiLine;
    property NullStyle;
  end;

  { TCustomdxDBImageEdit }

  TdxImageEditDBDataDefinition = class(TdxEditDBDataDefinition)
  protected
    function IsValidChar(InputChar: Char): Boolean; override;
  end;

  TCustomdxDBImageEdit = class(TCustomdxImageEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBImageEdit }
  TdxDBImageEdit = class(TCustomdxDBImageEdit)
  public
    property DataDefinition;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSize;
    property DataField;
    property DataSource;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property DropDownRows;
    property DropDownWidth;
    property PopupAlignment;
    property PopupBorder;
    // image
    property DefaultImages;
    property Descriptions;
    property ImageIndexes;
    property Images;
    property LargeImages;
    property MultiLineText;
    property ShowDescription;
    property Values;
  end;

  { TCustomdxDBSpinEdit }
  TCustomdxDBSpinEdit = class(TCustomdxSpinEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBSpinEdit }
  TdxDBSpinEdit = class(TCustomdxDBSpinEdit)
  public
    property DataDefinition;
    property IntValue;
    property Value;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property DataField;
    property DataSource;
    property HideSelection;
//    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // spin
    property EditorEnabled;
    property Increment;
    property MaxValue;
    property MinValue;
    property ValueType;
  end;

  { TCustomdxDBPickEdit }
  TCustomdxDBPickEdit = class(TCustomdxPickEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBPickEdit }
  TdxDBPickEdit = class(TCustomdxDBPickEdit)
  public
    property DataDefinition;
    property ItemIndex;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property DataField;
    property DataSource;
    property EditMask;
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown;
    property PopupAlignment;
    property PopupBorder;
    // pick
    property DropDownListStyle;
    property Items;
    property CanDeleteText;
    property Revertable;
    property Sorted;
  end;

  { TCustomdxDBCalcEdit }
  TCustomdxDBCalcEdit = class(TCustomdxCalcEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBCalcEdit }
  TdxDBCalcEdit = class(TCustomdxDBCalcEdit)
  public
    property DataDefinition;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property DataField;
    property DataSource;
//    property EditMask;
    property HideSelection;
//    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property PopupAlignment;
    property PopupBorder;
    // calc
    property BeepOnError;
    property ButtonStyle;
    property Precision;
    property QuickClose;
    property ShowButtonFrame;
  end;

  { TCustomdxDBHyperLinkEdit }
  TCustomdxDBHyperLinkEdit = class(TCustomdxHyperLinkEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBHyperLinkEdit }
  TdxDBHyperLinkEdit = class(TCustomdxDBHyperLinkEdit)
  public
    property DataDefinition;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property DataField;
    property DataSource;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // hyper
    property LinkColor;
    property SingleClick;
    property StartKey;
    property OnStartClick; 
  end;

  { TCustomdxDBTimeEdit }
  TCustomdxDBTimeEdit = class(TCustomdxTimeEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBTimeEdit }
  TdxDBTimeEdit = class(TCustomdxDBTimeEdit)
  public
    property DataDefinition;
    property Time;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property DataField;
    property DataSource;
    property HideSelection;
//    property MaxLength;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // time
    property TimeEditFormat;
  end;

  { TCustomdxDBCurrencyEdit }

  TdxCurrencyEditDBDataDefinition = class(TdxEditDBDataDefinition)
  protected
    function IsValidChar(InputChar: Char): Boolean; override;
  end;

  TCustomdxDBCurrencyEdit = class(TCustomdxCurrencyEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBCurrencyEdit }
  
  TdxDBCurrencyEdit = class(TCustomdxDBCurrencyEdit)
  public
    property DataDefinition;
    property Value;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property DataField;
    property DataSource;
    property HideSelection;
    property MaxLength;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // currency
    property DecimalPlaces;
    property DisplayFormat;
    property MaxValue;
    property MinValue;
    property Nullable;
    property NullString;
    property UseThousandSeparator;
  end;

  { TdxGraphicEditDBDataDefinition }
  TdxGraphicEditDBDataDefinition = class(TdxEditDBDataDefinition)
  protected
    procedure SetEditValue(const Value: Variant); override;
  end;

  { TCustomdxDBGraphicEdit }
  TCustomdxDBGraphicEdit = class(TCustomdxGraphicEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBGraphicEdit }
  TdxDBGraphicEdit = class(TCustomdxDBGraphicEdit)
  public
    property ClipboardFormat;
    property DataDefinition;
    property Picture;
    property ToolbarPos;
  published
    property Align;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    // original (standard)
    property Caption;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // graphic
    property Center;
    property CustomFilter;
    property CustomGraphic;
    property DataField;
    property DataSource;
    property DblClickActivate;
    property GraphicTransparency;
    property QuickDraw;
    property Stretch;
    property ToolbarLayout;
    property ToolbarPosStored;
    property OnAssignPicture;
    property OnCustomClick;
    property OnGetGraphicClass;
  end;

  { TCustomdxDBLookupEdit }
  
  TdxDBLookupEditDBDataDefinition = class(TdxEditDBDataDefinition)
  private
    FLookupEdit: TdxInplaceLookupEdit;  
  protected
    function GetAlignment: TAlignment; override;
    function GetEditValue: Variant; override;
    procedure SetEditValue(const Value: Variant); override;
  public
    constructor Create(ALookupEdit: TdxInplaceLookupEdit);
  end;

  TCustomdxDBLookupEdit = class(TdxInplaceLookupEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    function DataLink: TDataLink; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
    class function IsInplace: Boolean; override;
  end;

  { TdxDBLookupEdit }
  
  TdxDBLookupEdit = class(TCustomdxDBLookupEdit)
  public
    property DataDefinition;
    property LookupMode;
    {$IFNDEF DELPHI4}
    property LookupKeyValue;
    {$ENDIF}
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property DataField;
    property DataSource;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    property OnCloseUp;
    // drop down
    property ButtonGlyph;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown;
    property PopupAlignment;
    property PopupBorder;
    // lookup
    property ClearKey;
    property ListFieldName;
    property CanDeleteText;
    property Revertable;

    property KeyFieldName;
    property ListSource;
    {$IFDEF DELPHI4}
    property LookupKeyValue;
    {$ENDIF}
  end;

  { TCustomdxLookupEdit }
  
  TCustomdxLookupEdit = class(TCustomdxDBLookupEdit)
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    function DataLink: TDataLink; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxLookupEdit }

  TdxLookupEdit = class(TCustomdxLookupEdit)
  public
    property LookupMode;
    {$IFNDEF DELPHI4}
    property LookupKeyValue;
    {$ENDIF}
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    property OnCloseUp;
    // drop down
    property ButtonGlyph;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown;
    property PopupAlignment;
    property PopupBorder;
    // lookup
    property ClearKey;
    property ListFieldName;
    property CanDeleteText;
    property Revertable;

    property KeyFieldName;
    property ListSource;
    {$IFDEF DELPHI4}
    property LookupKeyValue;
    {$ENDIF}
  end;

  { TdxBlobEditDBDataDefinition }
  TdxBlobEditDBDataDefinition = class(TdxEditDBDataDefinition)
  protected
    procedure SetEditValue(const Value: Variant); override;
  end;

  { TCustomdxDBBlobEddit }
  TCustomdxDBBlobEdit = class(TCustomdxBlobEdit)
  private
    FBlobKind: TdxBlobKind;
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetBlobKind(Value: TdxBlobKind);
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure AssignEditProperties; override;
    function CreateDataDefinition: TdxEditDataDefinition; override;
    function GetIsNull(const Data: Variant): Boolean; override;
    property BlobKind: TdxBlobKind read FBlobKind write SetBlobKind default bkAuto;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
    class function IsInplace: Boolean; override;
  end;

  { TdxDBBlobEdit }
  TdxDBBlobEdit = class(TCustomdxDBBlobEdit)
  public
    property DataDefinition;
    property PictureClipboardFormat;
    property PictureGraphicClass;
    property Text;
  published
    property AutoSize;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original
    property Alignment;
    property DataField;
    property DataSource;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnValidate;
    // drop down
    property PopupAlignment;
    property PopupBorder;
    // Common
    property BlobKind;
//    property BlobEditKind;
    property BlobPaintStyle;
    property PopupWidth;
    property PopupHeight;
    property SizeablePopup;
    // Memo
    property AlwaysSaveText;
    property MemoCharCase;
    property MemoHideScrollBars;
    property MemoMaxLength;
    property MemoOEMConvert;
    property MemoScrollBars;
    property MemoSelectionBar;
    property MemoWantReturns;
    property MemoWantTabs;
    property MemoWordWrap;
    // Picture
    property PictureAutoSize;
    property PictureFilter;
    property PictureTransparency;
    property ShowExPopupItems;
    property ShowPicturePopup;
    property OnAssignPicture;
    property OnGetGraphicClass;
  end;

  { TCustomdxDBMRUEdit }
  TCustomdxDBMRUEdit = class(TCustomdxMRUEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBMRUEdit }
  TdxDBMRUEdit = class(TCustomdxDBMRUEdit)
  public
    property DataDefinition;
    property ItemIndex;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property DataField;
    property DataSource;
    property EditMask;
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property DropDownRows;
    property DropDownWidth;
    property ImmediateDropDown;
    property PopupAlignment;
    property PopupBorder;
    // pick
    property DropDownListStyle;
    property Items;
    property CanDeleteText;
    property Revertable;
    // MRU
    property MaxItemCount;
    property ShowEllipsis;
    property OnButtonClick;
  end;

  { TCustomdxDBPopupEdit }
  TCustomdxDBPopupEdit = class(TCustomdxPopupEdit)
  private
    function GetDataDefinition: TdxEditDBDataDefinition;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataDefinition(Value: TdxEditDBDataDefinition);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CreateDataDefinition: TdxEditDataDefinition; override;
    property DataDefinition: TdxEditDBDataDefinition read GetDataDefinition write SetDataDefinition;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TdxDBPopupEdit }
  TdxDBPopupEdit = class(TCustomdxDBPopupEdit)
  public
    property DataDefinition;
  published
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop default True;
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
  {$IFDEF DELPHI4}
    property Anchors;
//    property BiDiMode;
    property Constraints;
    property DragKind;
//    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  {$ENDIF}
    // original (standard)
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property CharCase;
    property DataField;
    property DataSource;
    property EditMask;
    property MaxLength;
    property PasswordChar;
    property ReadOnly;
    property StyleController;
    property OnChange;
    property OnDropDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelectionChange;
    property OnValidate;
    // drop down
    property ButtonGlyph;
    property PopupAlignment; // TODO ?
    // popup edit
    property HideEditCursor;
    property PopupAutoSize;
    property PopupControl;
    property PopupFormBorderStyle;
    property PopupFormCaption;
    property PopupClientEdge;
    property PopupFlatBorder;
    property PopupHeight;
    property PopupMinHeight;
    property PopupMinWidth;
    property PopupSizeable;
    property PopupWidth;
    property OnCloseQuery;
    property OnCloseUp;
    property OnInitPopup;
    property OnPopup;
  end;

implementation

{ TdxEditDataLink }
constructor TdxEditDataLink.Create(ADBDataDefinition: TdxEditDBDataDefinition);
begin
  inherited Create;
  FDBDataDefinition := ADBDataDefinition;
end;

procedure TdxEditDataLink.Modified;
begin
  FModified := True;
end;

procedure TdxEditDataLink.Reset;
begin
  RecordChanged(nil);
end;

procedure TdxEditDataLink.ActiveChanged;
begin
  UpdateField;
  if Assigned(FDBDataDefinition) and Assigned(FDBDataDefinition.OnActiveChange) then
    FDBDataDefinition.OnActiveChange;
end;

procedure TdxEditDataLink.EditingChanged;
begin
  if Assigned(FDBDataDefinition) and Assigned(FDBDataDefinition.OnEditingChange) then
    FDBDataDefinition.OnEditingChange;
  if not Editing then FModified := False;
end;

procedure TdxEditDataLink.FocusControl(Field: TFieldRef);
var
  Done: Boolean;
begin
  // TODO event param
  if (Field^ <> nil) and (Field^ = FField) and Assigned(FDBDataDefinition) and
    Assigned(FDBDataDefinition.OnFocusControl) then
  begin
    Done := False;
    FDBDataDefinition.OnFocusControl(Done);
    if Done then
      Field^ := nil;
  end;
end;

procedure TdxEditDataLink.LayoutChanged;
begin
  UpdateField;
  if Assigned(FDBDataDefinition) and Assigned(FDBDataDefinition.OnLayoutChanged) then
    FDBDataDefinition.OnLayoutChanged;
  FModified := False; // TODO new
end;

procedure TdxEditDataLink.RecordChanged(Field: TField);
begin
  if (Field = nil) or (Field = FField) then
  begin
    // begin 
    if Field = nil then
      if Assigned(FDBDataDefinition) and Assigned(FDBDataDefinition.OnLayoutChanged) then
        FDBDataDefinition.OnLayoutChanged;
    // end
    if Assigned(FDBDataDefinition) and Assigned(FDBDataDefinition.OnDataChange) then
      FDBDataDefinition.OnDataChange;
    FModified := False;
  end;
end;

procedure TdxEditDataLink.UpdateData;
begin
  if FModified then
  begin
    if (Field <> nil) and Assigned(FDBDataDefinition) and Assigned(FDBDataDefinition.OnUpdateData) then
      FDBDataDefinition.OnUpdateData;
    FModified := False;
  end;
end;

procedure TdxEditDataLink.SetField(Value: TField);
begin
  if FField <> Value then
  begin
    FField := Value;
//    EditingChanged;
//    RecordChanged(nil);
  end;
end;

procedure TdxEditDataLink.SetFieldName(const Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    UpdateField;
    // Refresh Control
    if Active then ActiveChanged;
    EditingChanged;
    RecordChanged(nil);
  end;
end;

procedure TdxEditDataLink.UpdateField;
begin
  SetField(nil);
  if Active and (FFieldName <> '') then
    SetField(DataSource.DataSet.FieldByName(FFieldName));
  // TODO SetField(GetFieldProperty(DataSource.DataSet, FControl, FFieldName)) else
end;

{ TdxEditDBNotification }
procedure TdxEditDBNotification.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (DBDataDefinition <> nil) and
    (AComponent = DBDataDefinition.DataSource) then DBDataDefinition.DataSource := nil;
end;

{ TdxEditDBDataDefinition }
constructor TdxEditDBDataDefinition.Create;
begin
  inherited Create;
  FDataLink := TdxEditDataLink.Create(Self);
  FDBNotification := TdxEditDBNotification.Create(nil);
  FDBNotification.FDBDataDefinition := Self;
end;

destructor TdxEditDBDataDefinition.Destroy;
begin
  FDBNotification.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TdxEditDBDataDefinition.Assign(Source: TPersistent);
begin
  if Source is TdxEditDBDataDefinition then
  begin
    DataSource := TdxEditDBDataDefinition(Source).DataSource;
    DataField := TdxEditDBDataDefinition(Source).DataField;
  end
  else
    inherited Assign(Source);
end;

function TdxEditDBDataDefinition.CanEditModify: Boolean;
begin
  Result := False;
  if Assigned(Field) and
    (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) then
  begin
    FDatalink.Edit;
    Result := FDatalink.Editing;
    if Result then FDatalink.Modified; // TODO ?
  end;
end;

function TdxEditDBDataDefinition.GetAlignment: TAlignment;
begin
  if Assigned(Field) then
    Result := Field.Alignment
  else Result := inherited GetAlignment;
end;

function TdxEditDBDataDefinition.GetDisplayFormat: string;
begin
  if Assigned(Field) then
  begin
    if Field is TNumericField then
      Result := TNumericField(Field).DisplayFormat
    else Result := inherited GetDisplayValue
  end
  else Result := inherited GetDisplayValue;
end;

function TdxEditDBDataDefinition.GetDisplayValue: Variant;
begin
  if Assigned(Field) then
    Result := Field.DisplayText
  else Result := inherited GetDisplayValue;
end;

function TdxEditDBDataDefinition.GetEditLimit: Integer;
begin
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size
  else Result := inherited GetEditLimit;
end;

function TdxEditDBDataDefinition.GetEditMask: string;
begin
  if Assigned(Field) then
    Result := Field.EditMask
  else Result := inherited GetEditMask;
end;

function TdxEditDBDataDefinition.GetEditValue: Variant;
begin
  if Assigned(Field) then
  begin
    if Field.DataType = ftBoolean then
      Result := Field.AsString
    else
      Result := Field.Value;
  end
  else
    Result := inherited GetEditValue;
end;

function TdxEditDBDataDefinition.GetLinkObject: TObject;
begin
  Result := Field;
end;

function TdxEditDBDataDefinition.GetMaxValue: Double;
begin
  Result := inherited GetMaxValue;
  if Assigned(Field) then
  begin
    if Field is TIntegerField then
      Result := TIntegerField(Field).MaxValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MaxValue, ffGeneral{ffFixed},
          TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
    else
      if Field is TBCDField then
        Result := TBCDField(Field).MaxValue;
  end;
end;

function TdxEditDBDataDefinition.GetMinValue: Double;
begin
  Result := inherited GetMinValue;
  if Assigned(Field) then
  begin
    if Field is TIntegerField then
      Result := TIntegerField(Field).MinValue
    else
      if Field is TFloatField then
      begin
        Result := StrToFloat(FloatToStrF(TFloatField(Field).MinValue, ffGeneral{ffFixed},
          TFloatField(Field).Precision, TFloatField(Field).Precision));
      end
    else
      if Field is TBCDField then
        Result := TBCDField(Field).MinValue;
  end;
end;

function TdxEditDBDataDefinition.GetRequired: Boolean;
begin
  if Assigned(Field) then
    Result := Field.Required
  else Result := inherited GetRequired;
end;

function TdxEditDBDataDefinition.IsCanModify: Boolean;
begin
  if Assigned(Field) then
    Result := not IsReadOnly
  else
    Result := False;
end;

function TdxEditDBDataDefinition.IsFloatValue: Boolean;
begin
  if Assigned(Field) then
    Result := Field.DataType in [ftFloat, ftCurrency, ftBCD]
  else Result := inherited IsFloatValue;
end;

function TdxEditDBDataDefinition.IsReadOnly: Boolean;
begin
  if Assigned(Field) then
    Result := not Field.CanModify or FDataLink.ReadOnly // Field.ReadOnly
  else
    Result := inherited IsReadOnly{True};
end;

function TdxEditDBDataDefinition.IsValidChar(InputChar: Char): Boolean;
begin
  if Assigned(Field) then
    Result := Field.IsValidChar(InputChar)
  else
    Result := inherited IsValidChar(InputChar);
end;

procedure TdxEditDBDataDefinition.Modified;
begin
  FDataLink.Modified;
end;

procedure TdxEditDBDataDefinition.Reset;
begin
  FDataLink.Reset;
end;

procedure TdxEditDBDataDefinition.SetEditValue(const Value: Variant);
begin
  if Assigned(Field) then
  begin
    if VarType(Value) = varString then
      Field.Text := Value
    else Field.Value := Value;
  end;
end;

procedure TdxEditDBDataDefinition.UpdateRecord;
begin
  if Assigned(Field) then 
    FDataLink.UpdateRecord;
end;

{$IFDEF DELPHI4}
function TdxEditDBDataDefinition.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := FDataLink.ExecuteAction(Action);
end;

function TdxEditDBDataDefinition.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := FDataLink.UpdateAction(Action);
end;
{$ENDIF}

function TdxEditDBDataDefinition.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TdxEditDBDataDefinition.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TdxEditDBDataDefinition.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TdxEditDBDataDefinition.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TdxEditDBDataDefinition.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(FDBNotification);
end;

{ TCustomdxDBEdit }
constructor TCustomdxDBEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBMaskEdit }
constructor TCustomdxDBMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBMaskEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBMaskEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBMaskEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBMaskEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBMaskEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBMaskEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBMaskEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBMaskEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
     Message.Result := Integer(DataDefinition.DataLink);
end;

{ TdxMemoEditDBDataDefinition }
procedure TdxMemoEditDBDataDefinition.SetEditValue(const Value: Variant);
begin
  if Assigned(Field) and (VarType(Value) = varString) then
    Field.AsString := Value
  else
    inherited SetEditValue(Value);
end;

{ TCustomdxDBMemo }
constructor TCustomdxDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBMemo.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxMemoEditDBDataDefinition.Create;
end;

function TCustomdxDBMemo.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBMemo.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBMemo.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBMemo.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBMemo.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBMemo.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBMemo.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBDateEdit }
constructor TCustomdxDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBDateEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBDateEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBDateEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBDateEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBDateEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBDateEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBDateEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBDateEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBButtonEdit }
constructor TCustomdxDBButtonEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBButtonEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBButtonEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBButtonEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBButtonEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBButtonEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBButtonEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBButtonEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBButtonEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TdxCheckEditDBDataDefinition }
constructor TdxCheckEditDBDataDefinition.Create;
begin
  inherited Create;
  FValueChecked := STextTrue; // TODO
  FValueUnchecked := STextFalse; // TODO
end;

procedure TdxCheckEditDBDataDefinition.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxCheckEditDBDataDefinition then
  begin
    ValueChecked := TdxCheckEditDBDataDefinition(Source).ValueChecked;
    ValueUnchecked := TdxCheckEditDBDataDefinition(Source).ValueUnchecked;
  end;
end;

function TdxCheckEditDBDataDefinition.GetEditValue: Variant;
var
  S: string;
begin
  Result := cbsGrayed;
  if Assigned(Field) and not Field.IsNull then
  begin
    if Field.DataType = ftBoolean then
      if Field.AsBoolean then
        Result := cbsChecked
      else
        Result := cbsUnchecked
    else
    begin
      S := Field.Text;
      if ValueMatch(FValueChecked, S) then Result := cbsChecked
      else
        if ValueMatch(FValueUnchecked, S) then Result := cbsUnchecked;
    end
  end;
end;

function TdxCheckEditDBDataDefinition.IsValidChar(InputChar: Char): Boolean;
begin
  Result := (InputChar = ' ') or inherited IsValidChar(InputChar);
end;

procedure TdxCheckEditDBDataDefinition.SetEditValue(const Value: Variant);
var
  Pos: Integer;
  S: string;
begin
  if Assigned(Field) then
  begin
    if TdxCheckBoxState(Value) = cbsGrayed then
    begin
      if (FValueGrayed <> '') and (Field.DataType <> ftBoolean) then
      begin
        Pos := 1;
        Field.Text := ExtractFieldName(FValueGrayed, Pos);
      end
      else
        Field.Clear;
    end    
    else
    begin
      if Field.DataType = ftBoolean then
        Field.AsBoolean := TdxCheckBoxState(Value) = cbsChecked
      else
      begin
        if TdxCheckBoxState(Value) = cbsChecked then
          S := FValueChecked
        else S := FValueUnchecked;
        Pos := 1;
        Field.Text := ExtractFieldName(S, Pos);
      end;
    end;
  end;
end;

procedure TdxCheckEditDBDataDefinition.SetValueChecked(const Value: string);
begin
  FValueChecked := Value;
  if Assigned(Field) then DataLink.ActiveChanged;
end;

procedure TdxCheckEditDBDataDefinition.SetValueGrayed(const Value: string);
begin
  FValueGrayed := Value;
  if Assigned(Field) then DataLink.ActiveChanged;
end;

procedure TdxCheckEditDBDataDefinition.SetValueUnchecked(const Value: string);
begin
  FValueUnchecked := Value;
  if Assigned(Field) then DataLink.ActiveChanged;
end;

function TdxCheckEditDBDataDefinition.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      Result := True;
      Break;
    end;
end;

{ TCustomdxDBCheckEdit }
constructor TCustomdxDBCheckEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
end;

function TCustomdxDBCheckEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxCheckEditDBDataDefinition.Create;
end;

procedure TCustomdxDBCheckEdit.LoadDisplayValue(var Data: Variant; IsPaintCopy: Boolean);
begin
  if Assigned(DataDefinition) and IsPaintCopy then
    Data := DataDefinition.GetEditValue
  else inherited LoadDisplayValue(Data, IsPaintCopy);
end;

function TCustomdxDBCheckEdit.GetDataDefinition: TdxCheckEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxCheckEditDBDataDefinition;
end;

function TCustomdxDBCheckEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBCheckEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

function TCustomdxDBCheckEdit.GetValueChecked: string;
begin
  Result := DataDefinition.ValueChecked;
end;

function TCustomdxDBCheckEdit.GetValueGrayed: string;
begin
  Result := DataDefinition.ValueGrayed;
end;

function TCustomdxDBCheckEdit.GetValueUnchecked: string;
begin
  Result := DataDefinition.ValueUnchecked;
end;

procedure TCustomdxDBCheckEdit.SetDataDefinition(Value: TdxCheckEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBCheckEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBCheckEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBCheckEdit.SetValueChecked(const Value: string);
begin
  DataDefinition.ValueChecked := Value;
end;

procedure TCustomdxDBCheckEdit.SetValueGrayed(const Value: string);
begin
  DataDefinition.ValueGrayed := Value;
end;

procedure TCustomdxDBCheckEdit.SetValueUnchecked(const Value: string);
begin
  DataDefinition.ValueUnchecked := Value;
end;

procedure TCustomdxDBCheckEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBImageEdit }

function TdxImageEditDBDataDefinition.IsValidChar(InputChar: Char): Boolean;
begin
  Result := True;
end;

constructor TCustomdxDBImageEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBImageEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxImageEditDBDataDefinition.Create;
end;

function TCustomdxDBImageEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBImageEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBImageEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBImageEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBImageEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBImageEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBImageEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBSpinEdit }
constructor TCustomdxDBSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBSpinEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBSpinEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBSpinEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBSpinEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBSpinEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBSpinEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBSpinEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBSpinEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBPickEdit }
constructor TCustomdxDBPickEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBPickEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBPickEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBPickEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBPickEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBPickEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBPickEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBPickEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBPickEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBCalcEdit }
constructor TCustomdxDBCalcEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBCalcEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBCalcEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBCalcEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBCalcEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBCalcEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBCalcEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBCalcEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBCalcEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBHyperLinkEdit }
constructor TCustomdxDBHyperLinkEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBHyperLinkEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBHyperLinkEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBHyperLinkEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBHyperLinkEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBHyperLinkEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBHyperLinkEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBHyperLinkEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBHyperLinkEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBTimeEdit }
constructor TCustomdxDBTimeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBTimeEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBTimeEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBTimeEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBTimeEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBTimeEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBTimeEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBTimeEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBTimeEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TdxCurrencyEditDBDataDefinition }

function TdxCurrencyEditDBDataDefinition.IsValidChar(InputChar: Char): Boolean;
begin
  if InputChar = ThousandSeparator then
    Result := True
  else
    Result := inherited IsValidChar(InputChar);
end;

{ TCustomdxDBCurrencyEdit }

constructor TCustomdxDBCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBCurrencyEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxCurrencyEditDBDataDefinition.Create;
end;

function TCustomdxDBCurrencyEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBCurrencyEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBCurrencyEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBCurrencyEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBCurrencyEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBCurrencyEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBCurrencyEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TdxGraphicEditDBDataDefinition }
procedure TdxGraphicEditDBDataDefinition.SetEditValue(const Value: Variant);
begin
  if Assigned(Field) then
    SaveBlobValueToField(Value, Field);
end;

{ TCustomdxDBGraphicEdit }
constructor TCustomdxDBGraphicEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]{ - [csSetCaption]};
end;

function TCustomdxDBGraphicEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxGraphicEditDBDataDefinition.Create;
end;

function TCustomdxDBGraphicEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBGraphicEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBGraphicEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBGraphicEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBGraphicEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBGraphicEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBGraphicEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBLookupEdit }

constructor TdxDBLookupEditDBDataDefinition.Create(ALookupEdit: TdxInplaceLookupEdit);
begin
  inherited Create;
  FLookupEdit := ALookupEdit;
end;

function TdxDBLookupEditDBDataDefinition.GetAlignment: TAlignment;
begin
  Result := TCustomdxDBLookupEdit(FLookupEdit).LookupAlignment;
end;

function TdxDBLookupEditDBDataDefinition.GetEditValue: Variant;
begin
  if Assigned(Field) then
    Result := inherited GetEditValue
  else
    Result := Null;
end;

procedure TdxDBLookupEditDBDataDefinition.SetEditValue(const Value: Variant);
begin
end;

constructor TCustomdxDBLookupEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

class function TCustomdxDBLookupEdit.IsInplace: Boolean;
begin
  Result := False;
end;

function TCustomdxDBLookupEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxDBLookupEditDBDataDefinition.Create(Self);
end;

function TCustomdxDBLookupEdit.DataLink: TDataLink;
begin
  Result := DataDefinition.DataLink;
end;

function TCustomdxDBLookupEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBLookupEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBLookupEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBLookupEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBLookupEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBLookupEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBLookupEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxLookupEdit }

constructor TCustomdxLookupEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  UnboundMode := True;
end;

function TCustomdxLookupEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := nil;
end;

function TCustomdxLookupEdit.DataLink: TDataLink;
begin
  Result := nil;
end;

{ TdxBlobEditDBDataDefinition }
procedure TdxBlobEditDBDataDefinition.SetEditValue(const Value: Variant);
begin
  if Assigned(Field) then
    SaveBlobValueToField(Value, Field);
end;

{ TCustomdxDBBlobEdit }
constructor TCustomdxDBBlobEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

class function TCustomdxDBBlobEdit.IsInplace: Boolean;
begin
  Result := False;
end;

procedure TCustomdxDBBlobEdit.AssignEditProperties;
begin
  inherited AssignEditProperties;
  BlobEditKind := CalcBlobEditKind(BlobKind, TdxEditDBDataDefinition(DataDefinition).Field);
end;

function TCustomdxDBBlobEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxBlobEditDBDataDefinition.Create;
end;

function TCustomdxDBBlobEdit.GetIsNull(const Data: Variant): Boolean;
begin
  if Assigned(DataDefinition) then
    Result := inherited GetIsNull(DataDefinition.GetEditValue)
  else
    Result := inherited GetIsNull(Data);
end;

function TCustomdxDBBlobEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBBlobEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBBlobEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBBlobEdit.SetBlobKind(Value: TdxBlobKind);
begin
  if FBlobKind <> Value then
  begin
    FBlobKind := Value;
    AssignEditProperties;
  end;
end;

procedure TCustomdxDBBlobEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBBlobEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBBlobEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBBlobEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBMRUEdit }
constructor TCustomdxDBMRUEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBMRUEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBMRUEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBMRUEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBMRUEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBMRUEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBMRUEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBMRUEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBMRUEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

{ TCustomdxDBPopupEdit }
constructor TCustomdxDBPopupEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable] - [csSetCaption];
end;

function TCustomdxDBPopupEdit.CreateDataDefinition: TdxEditDataDefinition;
begin
  Result := TdxEditDBDataDefinition.Create;
end;

function TCustomdxDBPopupEdit.GetDataDefinition: TdxEditDBDataDefinition;
begin
  Result := inherited DataDefinition as TdxEditDBDataDefinition;
end;

function TCustomdxDBPopupEdit.GetDataField: string;
begin
  Result := DataDefinition.DataField;
end;

function TCustomdxDBPopupEdit.GetDataSource: TDataSource;
begin
  Result := DataDefinition.DataSource;
end;

procedure TCustomdxDBPopupEdit.SetDataDefinition(Value: TdxEditDBDataDefinition);
begin
  inherited DataDefinition := Value;
end;

procedure TCustomdxDBPopupEdit.SetDataField(const Value: string);
begin
  DataDefinition.DataField := Value;
end;

procedure TCustomdxDBPopupEdit.SetDataSource(Value: TDataSource);
begin
  DataDefinition.DataSource := Value;
end;

procedure TCustomdxDBPopupEdit.CMGetDataLink(var Message: TMessage);
begin
  if Assigned(DataDefinition) then
    Message.Result := Integer(DataDefinition.DataLink);
end;

end.

