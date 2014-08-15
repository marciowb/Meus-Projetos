{***************************************************************************}
{ Scripter Studio Pro Components for Delphi & C++Builder                    }
{ version 1.6.0.1                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit IDEMain;

{$I ASCRIPT.INC}

interface                                                
uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, ComCtrls,
  atScript, PropertyList, PropertyInspEditors, TypInfo, AdvMemo, atScripter, ImgList, CommCtrl, Menus,
  {$IFDEF DELPHI6_LVL}
  Variants,
  {$ENDIF}
  {$IFDEF DELPHI9_LVL}
  CategoryButtons,
  {$ENDIF}
  {$IFDEF THEMED_IDE}
  AdvOfficeTabSet,
  AdvStyleIF,
  {$ENDIF}
  Contnrs, Buttons, ExtCtrls, FormDesigner, ComponentInspector, Dialogs;

type
  /// Summary:
  ///   The generic exception class raised by the scripter IDE when an error occurs.
  EIDEException = class(Exception);

  /// Summary:
  ///   Used by TControlDesignerFrame. Indicates the possible zones in which the mouse can be.
  TMouseZone = (mzNone, mzFrame, mzLeftFrame, mzTopFrame, mzRightFrame, mzBottomFrame,
    mzLeftTop, mzCenterTop, mzRightTop, mzLeftCenter, mzRightCenter, mzLeftBottom, mzCenterBottom, mzRightBottom);

  /// Summary:
  ///   Save as TMouseZone, except mzNone
  TRemovedZone = mzFrame..mzRightBottom;

  /// Summary:
  ///   Set of mouse zones that can be removed from valid zones so the control doesn't respond to that zone.
  ///   Used only by TControlDesignerFrame.
  TRemovedZones = set of TRemovedZone;                           

  /// Summary:
  ///   Indicates if the visual style of the form frame will be Delphi or Visual Studio
  TFrameStyle = (fsDelphi, fsVisualStudio);
  
  TIDEFormDesignControl = class;

  /// Description:
  ///   TControlDesignerFrame is a visual control that displays the frame around the form being edited in the embedded
  ///   form designer (TIDEFormDesignControl). It is used internally by TIDEFormDesignControl only.
  TControlDesignerFrame = class(TCustomControl)
  private
    FRegion: HRGN;
    FDragRect: TRect;
    FDragPoint: TPoint;
    FDragZone: TMouseZone;
    FHintWindow: THintWindow;
    FControl: TControl;
    FDirectDrag: Boolean;
    FMinSize: Integer;
    FShowMoveSizeHint: Boolean;
    FGrabColor: TColor;
    FGrabBorderColor: TColor;
    FEnableKeys: Boolean;
    FOnDblClick: TNotifyEvent;
    FGrabSize: integer;
    FFrameWidth: integer;
    FBrush: TBrush;
    FPen: TPen;
    FStyle: TFrameStyle;
    FRemovedZones: TRemovedZones;
    FDesignControl: TIDEFormDesignControl;
    procedure UpdateShape;
    function MouseZone(X, Y: Integer): TMouseZone;
    procedure DrawDragRect;
    procedure ShowDragHint(AHint: string);
    procedure HideDragHint;
    procedure SetControl(const Value: TControl);
    procedure SetGrabColor(const Value: TColor);
    procedure SetEnableKeys(const Value: Boolean);
    function GetThickness: integer;
    procedure SetFrameWidth(const Value: integer);
    procedure SetGrabSize(const Value: integer);
    procedure SetBrush(const Value: TBrush);
    procedure SetPen(const Value: TPen);
    procedure SetGrabBorderColor(const Value: TColor);
    procedure StyleChanged(Sender: TObject);
    procedure SetStyle(const Value: TFrameStyle);
    procedure SetRemovedZones(const Value: TRemovedZones);
  protected
    procedure CreateHandle; override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
    procedure ControlChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// Description:
    ///   Updates the frame position according to the associated control position, so the frame stays around the control.
    procedure UpdatePosition;

    /// Description:
    ///   Control property contains the associated control which will be surrounded and moved by the frame.
    property Control: TControl read FControl write SetControl;

    /// Description:
    ///   If DirectDrag is true, when the frame is moved/resized, the associated control is automatically moved/resized.
    ///   If DirectDrag is false, a cursor is displayed during the drag and control is moved/resized only when dragging
    ///   operation is done.
    property DirectDrag: Boolean read FDirectDrag write FDirectDrag;

    /// Description:
    ///   Contains the minimum size of the frame. Valid for both width and height.
    property MinSize: Integer read FMinSize write FMinSize;

    /// Description:
    ///   If true, a hint with current size is displayed while the control is resized.
    property ShowMoveSizeHint: Boolean read FShowMoveSizeHint write FShowMoveSizeHint;

    /// Description:
    ///   Contains the Pen used to draw the frame.
    property Pen: TPen read FPen write SetPen;

    /// Description:
    ///   Contains the Brush used to draw the frame.
    property Brush: TBrush read FBrush write SetBrush;

    /// Description:
    ///   Contais the fill color of the grab handles of the frame.
    property GrabColor: TColor read FGrabColor write SetGrabColor;

    /// Description:
    ///   Contains the border color of the grab handles of the frame.
    property GrabBorderColor: TColor read FGrabBorderColor write SetGrabBorderColor;

    /// Description:
    ///   Contains the size of the grab handles of the frame.
    property GrabSize: integer read FGrabSize write SetGrabSize;

    /// Description:
    ///   Specifies the width of the frame.
    property FrameWidth: integer read FFrameWidth write SetFrameWidth;

    /// Description:
    ///   Makes the frame control to get focus automatically so keyboard moving/resizing can be performed by the end user.
    property EnableKeys: Boolean read FEnableKeys write SetEnableKeys;

    /// Description:
    ///   Specifies the visual style of the frame, like Delphi style, or Visual Studio style.
    property Style: TFrameStyle read FStyle write SetStyle;

    /// Description:
    ///   Specifies the mouse zones that will be disable when moving/resizing the frame.
    property RemovedZones: TRemovedZones read FRemovedZones write SetRemovedZones;

    /// Description:
    ///   OnDblClick event is fired when the frame is double clicked by the end-user. 
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
  end;

  TIDEInspector = class;
  TIDEEngine = class;

  /// Description:
  ///   TIDEFormDesigner is a non-visual component used to perform form-designing operations. Although it can be put separately
  ///   in a Delphi form to allow run-time designing of that form, it is mostly used together with TIDEFormDesignControl to
  ///   perform form designing operation in the Scripter Studio IDE.
  ///   It contains a key property Engine which connects the designer to a TIDEEngine component so that it integrates itself
  ///   automatically in the IDE engine.
  TIDEFormDesigner = class(TAdvCustomFormDesigner)
  private
    FDesignControl: TIDEFormDesignControl;
    FEngine: TIDEEngine;
    procedure SetEngine(const Value: TIDEEngine);
    function IDEEngine: TIDEEngine;
    procedure LoadFromString(AContent: string; DFMFormat: TDFMFormat);
    function SaveToString(DFMFormat: TDFMFormat): string;
  protected
    procedure DoChange; override;
    procedure DoSelectionChange; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoControlDblClick(AControl: TControl); override;
    procedure DoBeforePlaceComponent(AComponent: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;

    /// Description:
    ///   Points to the TIDEEngine component that will perform all IDE control.
    property Engine: TIDEEngine read FEngine write SetEngine;
  end;

  /// Description:
  ///   TIDEInspector is a visual component inspector used to view and edit properties of a Delphi component or a set
  ///   of Delphi components at the same time. Although it can be put separately in a Delphi form to allow run-time editing
  ///   of properties of any component, it is mostly used as part of a Scripter Studio IDE.
  ///   It contains a key property Engine which connects the designer to a TIDEEngine component so that it integrates itself
  ///   automatically in the IDE engine.
  TIDEInspector = class(TAdvComponentInspector)
  private
    FEngine: TIDEEngine;
    procedure SetEngine(const Value: TIDEEngine);
    function ScriptFormFromProp(P: TProperty): TScriptForm;
    function ValidPropertyIndex(AIndex: integer): boolean;
  protected
    procedure Filter(Prop: TProperty; var Result: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change(TheIndex: Integer); override;
    function GetPropertyValue(P: TProperty): string; override;
    procedure SetPropertyValue(P: TProperty; Value: string); override;
    procedure GetValuesList(TheIndex: Integer; const Strings: TStrings); override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
    function GetReadOnly(TheIndex: Integer): Boolean; override;
    function GetEditorClass(TheIndex: Integer): TPropertyEditorClass; override;
  public
    procedure Update; override;
    destructor Destroy; override;

    /// Description:
    ///   Points to the TIDEEngine component that will perform all IDE control.
    property Engine: TIDEEngine read FEngine write SetEngine;
  end;

  /// Description:
  ///   TIDEFormDesignControl is a visual control used by the Scripter Studio IDE to allow form designing. When the form
  ///   is being designed in the IDE, the parent control of the form is the TIDEFormDesignControl, which implements all
  ///   designing behavior. This control is used only in a Scripter Studio IDE and cannot be used separately to edit
  ///   an existing Delphi form. Only script forms can be edited.
  TIDEFormDesignControl = class(TScrollingWinControl)
  private
    FOldParent: TWinControl;
    FOldLeft: integer;
    FOldTop: integer;
    FOldVisible: boolean;
    FFrame: TControlDesignerFrame;
    FOldWndProc: TWndMethod;
    FDesigner: TIDEFormDesigner;
    FEditForm: TScriptForm;
    FEngine: TIDEEngine;
    procedure FormWindowProc(var Msg: TMessage);
    procedure StartFormEditing;
    procedure StopFormEditing;
    procedure SetEditForm(const Value: TScriptForm);
    procedure SetEngine(const Value: TIDEEngine);
    procedure FocusForm;
    procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMEnter); message CM_EXIT;
    procedure DoFocus;
    procedure DeFocusForm;
    function GetFPopupMenu: TPopupMenu;
    procedure SetPopupMenu(const Value: TPopupMenu);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure FrameControlChanged;
    procedure CreateHandle; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// Description:
    ///   UpdateFrame is called by the designer when the frame control needs to be updated according to the position of the form
    ///   being edited.
    procedure UpdateFrame;

    /// Description:
    ///   Contains the TScriptForm form that will be designed.
    property EditForm: TScriptForm read FEditForm write SetEditForm;

    /// Description:
    ///   Saves the form being designed to the file specified by FileName. The DFMFormat parameter can be used to specify
    ///   a text format, or a binary format.
    procedure SaveToDFM(FileName: string; DFMFormat: TDFMFormat = dfmText);

    /// Description:
    ///   Loads the form being designed from the file specified by FileName. The DFMFormat parameter can be used to specify
    ///   a text format, or a binary format.
    procedure LoadFromDFM(FileName: string; DFMFormat: TDFMFormat = dfmText);

    /// Description:
    ///   Loads the form being designed from the stream specified by AStream. The DFMFormat parameter can be used to specify
    ///   a text format, or a binary format.
    procedure LoadFromStream(AStream: TStream; DFMFormat: TDFMFormat);

    /// Description:
    ///   Saves the form being designed to the stream specified by AStream. The DFMFormat parameter can be used to specify
    ///   a text format, or a binary format.
    procedure SaveToStream(AStream: TStream; DFMFormat: TDFMFormat);

    /// Description:
    ///   Points to the TIDEEngine component that will perform all IDE control.
    property Engine: TIDEEngine read FEngine write SetEngine;
  published
    property Align;
    property Color nodefault;
    property ParentColor nodefault;

    /// Description:
    ///   Contains the reference to a TPopupMenu to be used as the popup menu of the form designer.
    property PopupMenu: TPopupMenu read GetFPopupMenu write SetPopupMenu;
  end;

  /// Description:
  ///   TIDEComponentComboBox is a combobox-style visual component that lists all components in the form being designed and
  ///   allows selecting one of the components. When the component is selected in the combobox, the component is selected
  ///   in the form designer, and the properties of the component appears in the inspector. When a component is manually selected
  ///   in the form designer by the end-user, the combobox also auto-updates itself and displayes the currently selected component.
  ///   It contains a key property Engine which connects the designer to a TIDEEngine component so that it integrates itself
  ///   automatically in the IDE and allows that communication with the designer and the inspector.
  TIDEComponentComboBox = class(TAdvComponentComboBox)
  private
    FEngine: TIDEEngine;
    procedure SetEngine(const Value: TIDEEngine);
  protected
    procedure Change; override;
    function TranslateComponent(AComponent: TComponent): TComponent; override;
    function Filter(AComponent: TComponent): Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    /// Description:
    ///   Points to the TIDEEngine component that will perform all IDE control.
    property Engine: TIDEEngine read FEngine write SetEngine;
  end;

  /// Description:
  ///   TPaletteButton is just a TSpeedButton descendant used internally by the component toolbar control of the Scripter Studio IDE.
  TPaletteButton = class(TSpeedButton)
  private
    FClass: TComponentClass;
  end;

  /// Description:
  ///   TIDEPaletteToolbar is the component toolbar control used in the Scripter Studio IDE. It displays all registered
  ///   components available to be used in the form designer. This toolbar provides the pagecontrol-style tab used in
  ///   Delphi 7 IDE and previous. If you want a more modern component toolbar (Delphi 2005 and above), the proper component
  ///   is the TIDEPaletteButtons.
  ///   It contains a key property Engine which connects the designer to a TIDEEngine component so that it integrates itself
  ///   automatically in the IDE and allows that communication with other IDE components.
  TIDEPaletteToolbar = class(TCustomTabControl)
  private
    FPanel: TPanel;
    FButtonList: TObjectList;
    FFlatButtons: boolean;
    FButtonSize: integer;
    FEngine: TIDEEngine;
    procedure UpdatePanel;
    function CreateButton(AClass: TComponentClass): TPaletteButton;
    procedure SetFlatButtons(const Value: boolean);
    procedure SetButtonSize(const Value: integer);
    procedure UpdateButtonGlyph(ABtn: TSpeedButton; AClass: TClass);
    procedure CancelPlacementClick(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    function GetDesigner: TIDEFormDesigner;
    procedure SetEngine(const Value: TIDEEngine);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change; override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitiateAction; override;
    procedure UpdatePalette;
  published
    property Align;

    /// Description:
    ///   Indicates if the buttons in toolbar will have their Flat property set to true or not.
    property FlatButtons: boolean read FFlatButtons write SetFlatButtons;

    /// Description:
    ///   Indicates the size (width and height) of the button in the toolbar.
    property ButtonSize: integer read FButtonSize write SetButtonSize;

    /// Description:
    ///   Points to the TIDEEngine component that will perform all IDE control.
    property Engine: TIDEEngine read FEngine write SetEngine;
  end;

  {$IFDEF DELPHI9_LVL}
  TIDEPaletteButtonItem = class(TButtonItem)
  private
    FClass: TComponentClass;
  end;

  {$IFDEF THEMED_IDE}
  TIDEPaletteButtons = class(TCategoryButtons, ITMSStyle)
  {$ELSE}
  /// Description:
  ///   TIDEPaletteButtons is the component palette control used in the Scripter Studio IDE. It displays all registered
  ///   components available to be used in the form designer. This toolbar provides the palette-style used in
  ///   Delphi 2005 IDE and above. If you want an older-style component toolbar (Delphi 7 and below), the proper component
  ///   is the TIDEPaletteToolbar.
  ///   It contains a key property Engine which connects the designer to a TIDEEngine component so that it integrates itself
  ///   automatically in the IDE and allows that communication with other IDE components.
  TIDEPaletteButtons = class(TCategoryButtons)
  {$ENDIF}
  private
    FEngine: TIDEEngine;
    FImages: TCustomImageList;
    FCatList: TStrings;
    FFiltered: boolean;
    FFilter: string;
    FCategoryColor: TColor;
    FCategoryColorTo: TColor;
    procedure CheckImages;
    procedure SetEngine(const Value: TIDEEngine);
    procedure CreatePalCategory(ACaption: string);
    procedure CreateButton(aCategory: TButtonCategory; ControlIndex, index: integer);
    procedure PaletteButtonClick(sender: TObject);
    procedure SetFiltered(Value: boolean);
    procedure SetFilter(Value: string);
    procedure ButtonDrawText(Sender: TObject;
      const Button: TButtonItem; Canvas: TCanvas; Rect: TRect;
      State: TButtonDrawState);
    function CheckFilterCategory(ACatName, AFilter: string): boolean;
    function CheckFilter(AFilter: string): boolean;
    procedure SetCategoryColor(Value: TColor);
    procedure SetCategoryColorTo(Value: TColor);
    procedure UpdateCategoriesColors;
    {$IFDEF THEMED_IDE}
    procedure SetComponentStyle(AStyle: TTMSStyle);
    {$ENDIF}
  protected
    procedure Loaded; override;
    {$IFDEF DELPHI2009_LVL}
    procedure DoItemClicked(const Button: TBaseItem); override;
    {$ELSE}
    procedure DoItemClicked(const Button: TButtonItem); override;
    {$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    procedure InitiateAction; override;

    /// Description:
    ///   Rebuilds the list of categories and components. Call Populate to update the control, often used after you
    ///   register (or unregister) some components and want the toolbar to reflect the changes.
    procedure Populate;

    /// Description:
    ///   If Filtered property is true, the toolbar filters the components being displayed. It will only display thos components
    ///   which name matches the filter string provided in the Filter property.
    property Filtered: boolean read FFiltered write SetFiltered;

    /// Description:
    ///   Filter property contains the filter to be applied to the toolbar in order to filter the components being displayed.
    ///   For the filter operation to be performed, the Filtered property must be set to true. Only components which name
    ///   contains the string specified by Filter will be displayed.
    property Filter: string read FFilter write SetFilter;

    /// Description:
    ///   Points to the TIDEEngine component that will perform all IDE control.
    property Engine: TIDEEngine read FEngine write SetEngine;
  published
    property ButtonOptions nodefault;

    /// Description:
    ///   CategoryColor specifies the background color for the category names in the toolbar. The background is displayed
    ///   in a gradient, so this property specifies the start color. Use CategoryColorTo property for the end color.
    property CategoryColor: TColor read FCategoryColor write SetCategoryColor;

    /// Description:
    ///   CategoryColorTo specifies the background color for the category names in the toolbar. The background is displayed
    ///   in a gradient, so this property specifies the end color. Use CategoryColor property for the start color. 
    property CategoryColorTo: TColor read FCategoryColorTo write SetCategoryColorTo;
  end;
  {$ENDIF}

  /// Description:
  ///   TIDEMemo is a TAdvMemo descendant that works as the source code memo editor in the Scripter Studio IDE. You
  ///   can use it separately just as an TAdvMemo. But if you connect the Engine property to an existing TIDEEngine component,
  ///   then the memo will work integrated with the IDE and its other components (inspector, designer, etc.) and perform
  ///   some operations automatically, like setting breakpoints, code completion, etc.
  TIDEMemo = class(TAdvMemo)
  private
    FEngine: TIDEEngine;
    FTempActiveLine: boolean;
    procedure SetEngine(const Value: TIDEEngine);
    procedure CheckTempActiveLine;
    procedure UpdateActiveLineColors;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoGutterClick(LineNo: integer); override;
    procedure DoGetAutoCompletionList(AToken: string; AList: TStringList); override;
    procedure Change; override;
    procedure KeyDown(var Key: word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure DoExit; override;
  public
    constructor Create(AOwner: TComponent); override;

    /// Description:
    ///   Points to the TIDEEngine component that will perform all IDE control.
    property Engine: TIDEEngine read FEngine write SetEngine;
  end;

  /// Description:
  ///   TIDEWatchListView is a TCustomListView descendant automatically displays all the watches defined in the current scripter IDE.
  ///   The key property is Engine property which allows you to connect the watch list view to an existing TIDEEngine component.
  ///   Once you do that, the list view is updated displaying the watches and its values. This component also provides
  ///   methods for adding, deleting and editing the watches.
  TIDEWatchListView = class(TCustomListView)
  private
    FEngine: TIDEEngine;
    FUpdatingItem: integer;
    procedure SetEngine(const Value: TIDEEngine);
    function Watches: TatScripterWatches;
    procedure UpdateItem(AItem: TListItem);
    function WatchFromItem(AItem: TListItem): TatScripterWatch;
    function AddItemFromWatch(AWatch: TatScripterWatch): TListItem;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DblClick; override;
    procedure DeleteWatch(AWatch: TatScripterWatch);
    procedure Edit(const Item: TLVItem); override;
  public
    constructor Create(AOwner: TComponent); override;

    /// Description:
    ///   Adds a new watch to the list view. No dialog is displayed, an empty (no expression) watch is created. The
    ///   TatScripterWatch object associated with the watch is returned by the function.
    function AddWatch: TatScripterWatch;

    /// Description:
    ///   Displays a dialog for the end-user to add a new watch in the IDE. If the end-user confirms the watch creation,
    ///   the function returns a TatScripterWatch object that is associated with the new watch. If the add watch dialog
    ///   is canceled, this function returns nil.
    function DlgAddWatch: TatScripterWatch;

    /// Description:
    ///   Opens a dialog for editing the watch currently selected in the list view. If no watch is selected, nothing happens.
    ///   Function returns true if the end-user confirmed the watch changes in the dialog.
    function DlgEditSelectedWatch: boolean;

    /// Description:
    ///   Opens a dialog for editing the watch specified by the AWatch parameter.
    ///   Returns true if the end-user confirmed the watch changes in the dialog.
    function DlgEditWatch(AWatch: TatScripterWatch): boolean;

    /// Description:
    ///   Finds the TListItem object in the list view associated with the watch specified by TatScripterWatch.
    function FindItemByWatch(AWatch: TatScripterWatch): TListItem;

    /// Description:
    ///   Delete the watches currently selected in the list view. No confirmation message is displayed, the watches
    ///   are just deleted.
    procedure DeleteSelectedWatches;

    /// Description:
    ///   Refreshes the list view, displaying the existing watches and update their values.
    procedure UpdateList;

    /// Description:
    ///   Points to the TIDEEngine component that will perform all IDE control.
    property Engine: TIDEEngine read FEngine write SetEngine;
  published
    property Align;
    property AllocBy;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property ColumnClick;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property FlatScrollBars;
    property FullDrag;
    property GridLines;
    property HideSelection;
    property HotTrack;
    property HotTrackStyles;
    property HoverTime;
    property LargeImages;
    property MultiSelect;
    property ReadOnly default False;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SortType;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
    property OnColumnDragged;
    property OnColumnRightClick;
    property OnCompare;
    property OnContextPopup;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDblClick;
    property OnDeletion;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSubItemImage;
    property OnDragDrop;
    property OnDragOver;
    property OnInfoTip;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnStartDock;
    property OnStartDrag;
  end;

  /// Description:
  ///   TIDEScripter is a TatScripter descendant with extra functionality that allows smooth integration with the Scripter Studio IDE.
  ///   Only TIDEScripter components can be used together with the IDE, TatScripter doesn't offer that functionality.
  ///   TIDEScripter can be safely used as a replacement for TatScripter even for non-IDE purposes. No overhead is added.
  ///   The only different is that TIDEScripter introduces a new Engine property which allows you to associate the scripter component to the
  ///   IDE, so all the integration between IDE members can be done by Engine. If you don't set Engine property, TIDEScripter
  ///   works pretty much like the TatScripter.
  TIDEScripter = class(TatScripter)
  private
    FEngine: TIDEEngine;
    procedure SetEngine(const Value: TIDEEngine);
  protected
    procedure DoCompileError(msg: string; row,col: integer; var AShow: boolean; AScript: TatScript); override;
    procedure SourceCodeChanged(AScript: TatScript); override;
    procedure DoRunningChanged(AMachine: TatVirtualMachine); override;
    procedure SingleDebugHook(AMachine: TatVirtualMachine); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    /// Description:
    ///   Points to the TIDEEngine component that the TIDEScripter will communicate with.
    property Engine: TIDEEngine read FEngine write SetEngine;
  end;

  /// Description:
  ///   TIDERegisteredComp is a collection item class that holds information about a component registered with
  ///   TIDEEngine.RegisterComponent. Information is as basic as the component class, the name of the category in which it
  ///   will appear in the toolbar, among others.
  TIDERegisteredComp = class(TCollectionItem)
  private
    FPage: string;
    FUnits: string;
    FCompClass: TComponentClass;
    procedure SetCompClass(const Value: TComponentClass);
  public
    /// Description:
    ///   Contains the class of the component to be displayed in the toolbar and to be used in the form designer.
    ///   For example, TButton
    property CompClass: TComponentClass read FCompClass write SetCompClass;

    /// Description:
    ///   Contains the list of the units, separated by comma, that will be included in the script when the component is
    ///   used in a form. For example, in case of TListView component, Units property could contain 'Classes,Controls,ComCtrls'.
    ///   When a TListView component is put in a script form and the script is saved, the units Classes, Controls and ComCtrls
    ///   are automatically added to the script uses clause (if they don't exist).
    property Units: string read FUnits write FUnits;

    /// Description:
    ///   Contains the name of page (tab, category) in which the component will appear in component palette toolbar.
    property Page: string read FPage write FPage; 
  end;                                

  /// Description:
  ///   TIDERegisteredComps is a collections that holds information about all components registered in the engine component.
  ///   The list of registered components will be used by TIDEPaletteToolbar and TIDEPaletteButtons component to display
  ///   the list of components available to be used in the designer.
  TIDERegisteredComps = class(TOwnedCollection)               
  private
    function GetItem(Index: integer): TIDERegisteredComp;                                  
  public
    /// Description:
    ///   Fills the AStrings with a distinct list of all pages (categories) referenced by the registered components.
    procedure GetPageNames(AStrings: TStrings);

    /// Description:
    ///   Retrieves in AUnits the names of units required by the component class specified by AClass. See TIDERegisteredComp.Units
    ///   for more info.
    procedure GetClassUnits(AClass: TClass; AUnits: TStrings);

    /// Description:
    ///   Find the TIDERegisteredComp object that holds information about the registered component which class is specified by AClass.
    function FindByClass(AClass: TClass): TIDERegisteredComp;

    /// Description:
    ///   Adds a new TIDERegisteredComp object in the collection. You don't need to call this method, a better alternative
    ///   is to use TIDEEngine.RegisterComponent.
    function Add: TIDERegisteredComp;

    /// Description:
    ///   Provides indexed access to all TIDERegisteredComp objects in the collection.
    property Items[Index: integer]: TIDERegisteredComp read GetItem; default;
  end;

  /// Description:
  ///   This class is used internally by the IDE engine to persist information about the memo editor. In a multi-script
  ///   project, when user navigates through the different script files, the IDE needs to save information about the editor for
  ///   each script, like the cursor line and column, the breakpoints set, etc..
  TIDEProjectFileMemoInfo = class(TPersistent)
  private
    FBookmarks: TIntList;
    FCurY: integer;
    FCurX: integer;
    FTopLine: integer;
  public
    constructor Create;
    destructor Destroy; override;

    /// Description:
    ///   TopLine holds the line of source code that is being displayed in the first line of the memo.
    property TopLine: integer read FTopLine write FTopLine;

    /// Description:
    ///   CurX holds the current column position of the caret cursor.
    property CurX: integer read FCurX write FCurX;

    /// Description:
    ///   CurY holds the current row position of the caret cursor.
    property CurY: integer read FCurY write FCurY;
  end;

  TIDEProjectFiles = class;

  /// Description:
  ///   TIDEFileViewMode is used to indicate how the current file is being displayed in the IDE.
  ///     vmUnit - the script source code is being displayed.
  ///     vmForm - the script form is being displayed.
  TIDEFileViewMode = (vmUnit, vmForm);

  /// Description:
  ///   TIDEProjectFile object holds information about a script file in project. For each file in the project, a TIDEProjectFile
  ///   object is created in the IDE Engine. A file in a project corresponds to a script. The file can be just a single script,
  ///   or a script and a form associated with it.
  ///   This object holds several information about the file, for example, if the file is visible, if the script or form is being
  ///   displayed, the associated script object, etc.
  TIDEProjectFile = class(TCollectionItem)
  private
    FTempScriptLang: TScriptLanguage;
    FScript: TatScript;
    FForm: TScriptForm;
    FUnitName: string;
    FFilePath: string;
    FSaved: boolean;
    FModified: boolean;
    FViewMode: TIDEFileViewMode;
    FVisible: boolean;
    FMustUpdateScript: boolean;
    FOldScriptDestroy: TNotifyEvent;
    FMemoInfo: TIDEProjectFileMemoInfo;
    function Engine: TIDEEngine;
    function Files: TIDEProjectFiles;
    function FormClassName: string;
    procedure SetNewUnitName;
    procedure SetNewFormName;
    procedure SetForm(const Value: TScriptForm);
    function GetFormFileName: string;
    function GetFullFormFileName: string;
    function GetFullFileName(OnlyRelative: boolean = false): string;
    procedure SetViewMode(Value: TIDEFileViewMode);
    procedure SetVisible(const Value: boolean);
    procedure Load;
    function FileExtForm: string;
    function LanguageName: string;
    function DefaultFileExt: string;
    function ScriptLanguage: TScriptLanguage;
    procedure SetScript(const Value: TatScript);
    procedure ScriptDestroy(Sender: TObject);
    procedure SetUnitName(const Value: string);
    function GetFormResource: string;  
  protected
    procedure CheckUsedUnits;
    property FormFileName: string read GetFormFileName;
    property FullFormFileName: string read GetFullFormFileName;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    /// Description:
    ///   UpdateFormHeader changes the script source code in order to update the form header ($FORM directive). It is used
    ///   by the IDE when the file name or form name changes, for example, so the script source code must be updated automatically.
    procedure UpdateFormHeader;

    /// Description:
    ///   Changes the file name of this project file. This method must be used when the name of the file is changed, for example,
    ///   in a "Save As" operation. Changing the file name involves several other things, like updating the script's UnitName property,
    ///   notify other scripts that use the current script, among other tasks.
    ///   If NotifyUnitChange is true, then the main script is notified about the file name change, and will update its "uses" clause
    ///   accordingly. For example, if the main script contains clause "uses Unit1;", and we change Unit1 file name to MyUnit,
    ///   if NotifyUnitChange is true than the main script will be updated to "uses MyUnit;"
    procedure ChangeFileName(AFileName: string; NotifyUnitChange: boolean = false);

    /// Description:
    ///   Saves the file content (script and form, if exists). Do not perform any dialog operation, just saves the current
    ///   file using the current file name. You will not use this method very often, use TIDEEngine.DlgSaveFile method for higher-level
    ///   saving operation.
    procedure Save;

    /// Description:
    ///   Returns true if this project file is a script form. If the project file is only a script unit without a form,
    ///   the method returns false.
    function IsForm: boolean;

    /// Description:
    ///   Loads the form (if exists) from the string AString previously saved. Parameter ADMFormat specified if the string contains
    ///   the form resource saved in binary or text format.
    procedure LoadFormFromString(AString: string; ADFMFormat: TDFMFormat = dfmText);

    /// Description:
    ///   Saves the current form (if exists) in a string. The method returns the string which contains the form data which can
    ///   later be loaded using LoadFormFromString. Use ADFMFormat to specify if the string will contain form data in binary
    ///   or text format (default).
    function SaveFormToString(ADFMFormat: TDFMFormat = dfmText): string;

    /// Description:
    ///   Contains the current form data in string format. The information is saved using the Delphi streaming system and
    ///   is presented in text format.
    property FormResource: string read GetFormResource;

    /// Description:
    ///   Contains a reference to the script form instance associated with this file. If the file does not contain a form,
    ///   this property is nil.
    property Form: TScriptForm read FForm;

    /// Description:
    ///   Contains a reference to the script object associated with this file. The script object is kept by the scripter
    ///   component associated with the TIDEEngine which this file belongs to. The engine keeps the file and script object
    ///   in sync, like for example, the memo content and script source code.
    property Script: TatScript read FScript write SetScript;
    
    {$WARNINGS OFF}
    /// Description:
    ///   Contains the unit name of this file. Usually the unit name is the same as the file name, and you rarely need
    ///   to change this property.
    property UnitName: string read FUnitName write SetUnitName;
    {$WARNINGS ON}

    /// Description:
    ///   Contains the path in which this file is saved. FilePath can have an absolute or relative value. If relative,
    ///   this property contains the file path relative to TIDEEngine.BasePath property.
    property FilePath: string read FFilePath write FFilePath;

    /// Description:
    ///   Saved is true when the project file was saved at least once. When you create a new file in the script project, the
    ///   file is not associated with a physical file yet, and Saved property is false. When the file is saved for the first time
    ///   Saved property becomes true and never goes false again.
    property Saved: boolean read FSaved;

    /// Description:
    ///   Indicates what part of the file is being current displayed in the scripter ide, if the script source code (unit)
    ///   or the form designer. This property is read-write, so you can set its value to specify what you want to be displayed.
    ///   If the file does not contain a form, only a script, the ViewMode value will always vmUnit. Setting it to vmForm
    ///   won't change its value.
    property ViewMode: TIDEFileViewMode read FViewMode write SetViewMode;

    /// Description:
    ///   Indicates if the current file is visible in the IDE or not. The file can be invisible (not being displayed) but still
    ///   belongs to the script project.
    property Visible: boolean read FVisible write SetVisible;

    /// Description:
    ///   Indicates if the current file was modified since created, loaded or saved by last time.
    property Modified: boolean read FModified;
  end;

  /// Description:
  ///   This class holds a collection of TIDEProjectFile objects which represent all the files belonging to a script project.
  ///   A file can be a script or a script form.
  TIDEProjectFiles = class(TOwnedCollection)
  private
    function GetItem(Index: integer): TIDEProjectFile;
    function Engine: TIDEEngine;
  public
    /// Description:
    ///   Adds a new file in the collection.
    function Add: TIDEProjectFile;

    /// Description:
    ///   Finds the TIDEProjectFile object associated with the script specified by AUnitName. If the file is not found,
    ///   this method returns nil.
    function FindByUnitName(AUnitName: string): TIDEProjectFile;

    /// Description:
    ///   Finds the TIDEProjectFile object containing the form which name is specified by AFormName. If the file is not found,
    ///   this method returns nil.
    function FindByFormName(AFormName: string): TIDEProjectFile;

    /// Description:
    ///   Finds the TIDEProjectFile object associated with the TatScript object specified by AScript. If not found, nil is returned.
    function FindByScript(AScript: TatScript): TIDEProjectFile;

    /// Description:
    ///   Finds the TIDEProjectFile object which contains the script form instance specified by AForm. If not found, nil is returned.
    function FindByForm(AForm: TScriptForm): TIDEProjectFile;

    /// Description:
    ///   Provides indexed access to a TIDEProjectFile item in the collection. 
    property Items[Index: integer]: TIDEProjectFile read GetItem; default;
  end;

  /// Description:
  ///   TIDEShowSourceEditorEvent is an event fired when the engine needs to display the source code memo editor at
  ///   the position specified by Col and Row.
  TIDEShowSourceEditorEvent = procedure(Sender: TObject; Col, Row: integer) of object;

  /// Description:
  ///   TIDEEngineOptions contains some general purpose properties for the IDE behavior.
  TIDEEngineOptions = class(TPersistent)
  private
    FEngine: TIDEEngine;
    FAutoHideTabControl: boolean;
  public
    constructor Create(AEngine: TIDEEngine);
    procedure Assign(Source: TPersistent); override;
  published
    /// Description:
    ///   The default IDE contains a TabControl component which displays the list of units opened in the IDE. If
    ///   AutoHideTabControl is true, this TabControl is made invisible if no files are being displayed.
    ///   Used for visual purpose only.
    property AutoHideTabControl: boolean read FAutoHideTabControl write FAutoHideTabControl;
  end;

  /// Description:
  ///   TIDENotificationType indicates the type of notification (event) that happened in the IDE.
  ///     ntComponentSelected - The current selection in form designer has changed (a component has been selected/unselected)
  ///     ntActiveFileChanged - The current active file in the IDE has changed
  ///     ntInspectorChanged - A value in the object inspector has changed
  TIDENotificationType = (ntComponentSelected, ntActiveFileChanged, ntInspectorChanged);

  /// Description:
  ///   TIDEEngineNotifier is the ancestor class for all objects that receive notifications about changes in the IDE.
  ///   If you want to get notified about changes in the IDE (an object has been selected, a property was changed, etc.),
  ///   you need to inherit from TIDEEngineNotifier and override method Notification to perform the desired operations.
  ///   You register a notifier using TIDEEngine.AddNotifier method.
  TIDEEngineNotifier = class
  public
    /// Description:
    ///   Notification method is called when an event in the scripter IDE has been performed. The type of event/notification
    ///   is passed in parameter AOperation.
    procedure Notification(AOperation: TIDENotificationType); virtual;
  end;

  TIDEEngineNotifierClass = class of TIDEEngineNotifier;

  /// Description:
  ///   TIDEDebugAction was used internally by the scripter IDE. Currently this type is not being used
  TIDEDebugAction = (daNone, daRun, daTraceInto, daStepOver, daReturn, daRunTo);

  /// Description:
  ///   TIDERunMode specifies how the project must be executed.
  ///     rmMainUnit - The main script of the project will be executed.
  ///     rmActiveUnit - The script currently active (selected) in the IDE will be executed.
  TIDERunMode = (rmMainUnit, rmActiveUnit);

  /// Description:
  ///   TIDEFileType enumerates the types of files which exist in a script project.
  ///     iftScript - The file is script (.pas, .bas, etc.). Contains the script source code.
  ///     iftForm - The file is a form resource. Contains the form data in string format.
  ///     iftProject - The file is project main file. Contains the list of project files and some other project options.
  TIDEFileType = (iftScript, iftForm, iftProject);

  /// Description:
  ///   TIDECloseFileResult type enumerates possible results of a close file operation.
  ///     cfrCanceled - The close file operation was canceled by end-user.
  ///     cfrClosed - The close file operation was performed and the file was made invisible in the IDE but not removed from project.
  ///     cfrRemoved - The close file operation was performed, the file was made invisible in the IDE and removed from the project.
  TIDECloseFileResult = (cfrCanceled, cfrClosed, cfrRemoved);

  /// Description:
  ///   TRunningChangeEvent fires when the running status of a script project changes. ARunning parameter indicates if the
  ///   project is running (true) or not (false).
  TRunningChangeEvent = procedure(Sender: TObject; ARunning: boolean) of object;

  /// Description:
  ///   TCheckValidFileEvent can be used by programmer to indicate to the IDE if an specified project file is valid (exists).
  ///   The file to check is passed in AFileName parameter, and the type of file is passed in IDEFileType. Note that for
  ///   each project file, the event is fired twice, one for the script source code (unit), one for the form file (resource).
  ///   Even if the file was previously saved without a form, when loading a project again, the event will be fired for the
  ///   form file type. This is the only way engine can tell that if the file has a form or not.
  ///   You must inform if the file exists or not setting the AValid parameter.
  ///   You don't need to handle this event. If this event is not assigned, it will not be fired, and engine will just check
  ///   if the specified file exists in the hard drive. You only need to set this event in case you want to do some custom
  ///   saving of project files (like saving in a database, for example).
  TCheckValidFileEvent = procedure(Sender: TObject; IDEFileType: TIDEFileType;
    AFileName: string; var AValid: boolean) of object;

  /// Description:
  ///   TIDELoadFileEvent can be used by programmer to load a project file in a custom way (from a database, for example).
  ///   The file to load is passed in AFileName parameter, and the type of file is passed in IDEFileType. For
  ///   each project file, the event can be fired twice, one for the script source code (unit), one for the form file (resource).
  ///   You must indicate if the file has a form or not in OnCheckValidFile event. Once you do, OnLoadFile event will be fired
  ///   only for the existing valid files.
  ///   You must load the file content from some place and provide it in the parameter AContent. Then you must set Handled
  ///   parameter to true. If Handled parameter is false, the engine will try to load the file from the hard drive according
  ///   to its file name.
  ///   You don't need to handle this event. If this event is not assigned, it will not be fired, and engine will just load
  ///   the file directly from disk. You only need to set this event in case you want to do some custom
  ///   saving/loading of project files (like saving in a database, for example).
  TIDELoadFileEvent = procedure(Sender: TObject; IDEFileType: TIDEFileType; AFileName: string;
    var AContent: string; AFile: TIDEProjectFile; var Handled: boolean) of object;

  /// Description:
  ///   TIDESaveFileEvent can be used by programmer to save a project file in a custom way (to a database, for example).
  ///   The file to save is passed in AFileName parameter, and the type of file is passed in IDEFileType. The file content
  ///   to be saved is passed in parameter AContent. For each project file, the event can be fired twice, one for the script
  ///   source code (unit), one for the form file (resource), if it exists.
  ///   You must set Handled parameter to true. If Handled parameter is false, the engine will save the file the the hard
  ///   disk according to its file name.
  ///   You don't need to handle this event. If this event is not assigned, it will not be fired, and engine will just save
  ///   the file directly to disk. You only need to set this event in case you want to do some custom
  ///   saving/loading of project files (like saving in a database, for example).
  TIDESaveFileEvent = procedure(Sender: TObject; IDEFileType: TIDEFileType; AFileName: string;
    AContent: string; AFile: TIDEProjectFile; var Handled: boolean) of object;

  /// Description:
  ///   TIDEOpenDialogEvent can be used by programmer to provide a different dialog for opening script project files other
  ///   than the standard one. The event is fired when the end-user choose "Open file" or "Open project" option in the IDE.
  ///   The type of file to be opened is passed in IDEFileType parameter. The file chosen by the end-user must be provided
  ///   in AFileName parameter. If the end-user confirmed the operation, ResultOk must receive true. Otherwise, ResultOk
  ///   must receive false in order to inform the engine to abort the operation (as if the end-user pressed Cancel in the open dialog).
  ///   Finally, Handled parameter must receive true. If Handled receives false, then the standard open dialog will be used.
  TIDEOpenDialogEvent = procedure(Sender: TObject; IDEFileType: TIDEFileType; var AFileName: string;
    var ResultOk, Handled: boolean) of object;

  /// Description:
  ///   TIDESaveDialogEvent can be used by programmer to provide a different dialog for saving script project files other
  ///   than the standard one. The event is fired when the end-user chooses "Save file as..." or "Save project" options in the IDE.
  ///   The type of file to be saved is passed in IDEFileType parameter. The name of the file to be saved is passed in
  ///   AFileName parameter, and you must provide the name back to the parameter (in case end-user changes the name, for example).
  ///   If end-user confirms the operation, ResultOk must receive true. Otherwise, ResultOk must receive false in order to inform the
  ///   engine to abort the operation (as if the end-user pressed Cancel in the save dialog).
  ///   Finally, Handled parameter must receive true. If Handled receives false, then the standard save dialog will be used.
  TIDESaveDialogEvent = procedure(Sender: TObject; IDEFileType: TIDEFileType; var AFileName: string;
    AFile: TIDEProjectFile; var ResultOk, Handled: boolean) of object;

  /// Description:
  ///   TIDEGetComponentImageEvent is an opportunity to provide an icon for a component to be displayed in the palette toolbar.
  ///   The event is fired for every component to be displayed. The RegComp parameter contains the TIDERegisteredComp object which
  ///   contains information about the component. You must provide the icon in the ABitmap object. You don't need to create a bitmap
  ///   object, just use ABitmap to load from stream, or from a file, and assign the bitmap to the object.
  ///   If you have provided a bitmap for the component, set AHandled parameter to true to avoid other images to be assigned
  ///   for that component.
  TIDEGetComponentImageEvent = procedure(Sender: TObject; RegComp: TIDERegisteredComp;
    ABitmap: TBitmap; var AHandled: boolean) of object;

  /// Description:
  ///   TTabControlType specifies the style of the tabcontrol to be used in the script IDE.
  ///     tctNone - Not used.
  ///     tctTabControl - Regular VCL TTabControl is used.
  ///     tctOfficeTabSet - TMS Office TabSet is used (Scripter package must be compiled with directive THEMED_IDE) 
  TTabControlType = (tctNone, tctTabControl, tctOfficeTabSet);

  /// Description:
  ///   TIDEEngine is the main component for scripter IDE management. It is the controller component for the IDE, sending and receiving
  ///   notifications to/from IDE parts (designer, memo, inspector, toolbars) and making them work together. It also encapsulates
  ///   all operations with script projects. You can use TIDEEngine to create new projects, load and execute existing ones,
  ///   programatically add new files, forms, among other operations.
  ///
  ///   You can use TIDEEngine to build your own scripter IDE. In this case you assign the several parts of the IDE (scripter, inspector,
  ///   designer, etc.) to the respective properties of TIDEEngine, and it will make all work together. TIDEEngine provides several
  ///   high-level methods like DlgOpenFile, DlgSaveFile, DlgNewProject, that performs all operation of displaying the open/save dialogs,
  ///   load all files and notify the IDE parts to be updated.
  ///
  ///   Note that if you use TIDEEngine associated with TIDEDialog component (which is a totally pre-built IDE), you don't need to use
  ///   those methods, since TIDEDialog already provides an IDE form with menus and toolbars that are already configured to call
  ///   those TIDEEngine methods.
  TIDEEngine = class(TComponent)
  private
    FFiles: TIDEProjectFiles;
    FInspector: TIDEInspector;
    FComponentCombo: TIDEComponentComboBox;
    FLockDesigner: integer;
    FScripter: TIDEScripter;
    FDesignControl: TIDEFormDesignControl;
    FFormDesigner: TIDEFormDesigner;
    {$IFDEF DELPHI9_LVL}
    FPaletteButtons: TIDEPaletteButtons;
    {$ENDIF}
    FPaletteToolbar: TIDEPaletteToolbar;
    FMemo: TIDEMemo;
    FActiveFile: TIDEProjectFile;
    FMemoTimer: TTimer;
    FUpdatingMemo: boolean;
    FBasePath: string;
    FOnShowSourceEditor: TIDEShowSourceEditorEvent;
    FTabControl: TControl;
    FIDEComps: TIDERegisteredComps;
    FOldTabChange: TNotifyEvent;
    FUpdatingTab: integer;
    FOptions: TIDEEngineOptions;
    FUpdatingView: boolean;
    FUpdateWatches: boolean;
    FPostHaltAction: TIDEDebugAction;
    FProjectName: string;
    FProjectSaved: boolean;
    FProjectModified: boolean;
    FOnProjNameChanged: TNotifyEvent;
    FFileExtBasicUnit: string;
    FFileExtPascalUnit: string;
    FFileExtForm: string;
    FPascalStyler: TAdvCustomMemoStyler;
    FBasicStyler: TAdvCustomMemoStyler;
    FMainUnit: TIDEProjectFile;
    FOnViewModeChanged: TNotifyEvent;
    FOnActiveFileChanged: TNotifyEvent;
    FWatchList: TIDEWatchListView;
    FBeforeAddWatchDlg: TNotifyEvent;
    FOnRunningChanged: TRunningChangeEvent;
    FOnCheckValidFile: TCheckValidFileEvent;
    FOnLoadFile: TIDELoadFileEvent;
    FOnSaveFile: TIDESaveFileEvent;
    FOnOpenDialog: TIDEOpenDialogEvent;
    FOnSaveDialog: TIDESaveDialogEvent;
    FOnGetComponentImage: TIDEGetComponentImageEvent;
    FUpdatingScriptSource: integer;
    FUpdatingComponents: integer;
    FNotifiers: TObjectList;
    FAutoStyler: boolean;
    FOnComponentPlaced: TComponentNotifyEvent;
    FPreventDefaultEventCreation: boolean;
    FOnDesignerSelectionChanged: TNotifyEvent;
    procedure SetInspector(const Value: TIDEInspector);
    procedure DesignerChange;
    procedure MemoChange;
    procedure DesignerSelectionChange;
    procedure InspectorChange;
    procedure InspectorUpdate;
    procedure ComboChanged;
    procedure SetComponentCombo(const Value: TIDEComponentComboBox);
    procedure RegisterScriptFormProps;
    procedure SetScripter(const Value: TIDEScripter);
    procedure SetDesignControl(const Value: TIDEFormDesignControl);
    procedure SetFormDesigner(const Value: TIDEFormDesigner);
    procedure SetPaletteToolbar(const Value: TIDEPaletteToolbar);
    {$IFDEF DELPHI9_LVL}
    procedure SetPaletteButtons(const Value: TIDEPaletteButtons);
    {$ENDIF}
    function GetDesigner: TIDEFormDesigner;
    procedure SetMemo(const Value: TIDEMemo);
    procedure SetActiveFile(AFile: TIDEProjectFile);
    procedure UpdateMemoBreakpoints;
    procedure FormNameChanged(AForm: TScriptForm; AOldName: string);
    procedure UnitNameChanged(AFile: TIDEProjectFile; AOldName, ANewName: string);
    procedure MemoTimerEvent(Sender: TObject);
    procedure UpdateScriptSource(AvoidRecompile: boolean);
    function GetFormResource(AFile: TIDEProjectFile): string;
    procedure SetTabControl(const Value: TControl);
    procedure TabChange(Sender: TObject);
    procedure UpdateTabControl;
    procedure ChangeTabName(ANewName, AOldName: string);
    procedure SetOptions(const Value: TIDEEngineOptions);
    procedure FileRemoved(AIndex: integer);
    procedure ChangeActiveFile(AFile: TIDEProjectFile);
    procedure CheckRunningMode;
    function GetModified: boolean;
    function GetActiveScript: TatScript;
    procedure CheckPostHaltAction;
    procedure ShowExecutionPoint;
    procedure RunningChanged;
    procedure SetBasePath(const Value: string);
    function GetVisibleFile(Index: integer): TIDEProjectFile;
    procedure ForceActiveFile(AIndex: integer);
    procedure SaveFile(AFile: TIDEProjectFile);
    // LoadFile loads the file specified by AFileName, adds it to the project and shows it in the IDE, making it active
    procedure LoadFile(AFile: TIDEProjectFile; AMakeActive: boolean = true);
    procedure PrepareSaveDialog(ADlg: TOpenDialog; AFile: TIDEProjectFile);
    procedure PrepareOpenDialog(ADlg: TOpenDialog);
    procedure PrepareOpenProjectDialog(ADlg: TOpenDialog);
    procedure PrepareSaveProjectDialog(ADlg: TOpenDialog);
    procedure ProjNameChanged;
    procedure GetAutoCompletionList(AToken: string; AList: TStringList);
    procedure AddUsedUnits(AFile: TIDEProjectFile; AUnits: string);
    procedure SetMainUnit(const Value: TIDEProjectFile);
    procedure MainUnitRemoved;
    procedure SetWatchList(const Value: TIDEWatchListView);
    function CreateScriptForm: TScriptForm;
    procedure PrepareMainScript(RunMode: TIDERunMode);
    procedure SaveStringToFile(AFileName, AContent: string);
    function ExecuteSaveDialog(SD: TSaveDialog; AFileType: TIDEFileType; AFile: TIDEProjectFile; var AFileName: string): boolean;
    function ExecuteOpenDialog(OD: TOpenDialog; AFileType: TIDEFileType; var AFileName: string): boolean;
    procedure ScriptSourceChanged(AScript: TatScript);
    procedure BeginUpdateSourceCode;
    procedure EndUpdateSourceCode;
    procedure UpdateMemoSource(AKeepCursorPos: boolean);
    procedure ChangeProjectName(AFileName: string);
    procedure SetProjectName(const Value: string);
    function FindDesignerInForm(AForm: TCustomForm): TIDEFormDesigner;
    function InternalSaveProject(DoSaveAllBefore: boolean): boolean;
    function InternalSaveProjectAs(DoSaveAllBefore: boolean): boolean;
    procedure CompileError(msg: string; row, col: integer; AScript: TatScript);
    function GetSelectedComponent: TComponent;
    procedure SetSelectedComponent(const Value: TComponent);
    procedure DoNotification(AOperation: TIDENotificationType);
    procedure CleanSavedEvents;
    procedure SaveMemoInfo(AFile: TIDEProjectFile);
    procedure LoadMemoInfo(AFile: TIDEProjectFile);
    procedure InternalRun(RunMode: TIDERunMode = rmMainUnit; AExecute: boolean = true);
    function TabControlType(AControl: TControl): TTabControlType;
  protected
    procedure CheckCompiled;
    function DeclareProcedure(AInfo: TatRoutineInfo): integer;
    procedure DoActiveFileChanged; virtual;
    procedure DoBeforeAddWatchDlg; virtual;
    procedure DoGetComponentImage(RegComp: TIDERegisteredComp; ABitmap: TBitmap; var AHandled: boolean);
    procedure ShowSourceEditor(Col: integer = -1; Row: integer = -1); virtual;
    procedure ShowFormEditor;
    procedure ViewModeChanged(AFile: TIDEProjectFile); virtual;
    procedure DoOnViewModeChanged; virtual;
    procedure FileVisibleChanged(AFile: TIDEProjectFile); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetFullProjectFileName: string;
    property Modified: boolean read GetModified;
    procedure DesignerComponentDblClicked(AComponent: TComponent);
    procedure ComponentPlaced(AComponent: TComponent);
    function IsValidFile(AFileType: TIDEFileType; AFileName: string): boolean;

    // It's different than close all, because it also checks for project to be saved
    function DlgCloseProject: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// Description:
    ///   Call UpdateIDE to update all IDE elements, specially the memo and form designer, to reflect any changes to AFile
    ///   made programatically. The file specified by AFile will become the current active file in the IDE.
    procedure UpdateIDE(AFile: TIDEProjectFile);

    /// Description:
    ///   Call BeginRegisterComponents before registered two or more components in sequence using RegisterComponent. This will avoid
    ///   the toolbars to be automatically updated for every component being registered, and will increase performance.
    ///   Once you have done registering components, call EndRegisterComponents to update the toolbars.
    procedure BeginRegisterComponents;

    /// Description:
    ///   Call EndRegisterComponents to terminate an operation started with BeginREgisterComponents method.
    procedure EndRegisterComponents;

    /// Description:
    ///   Call AddNotifier to add a TIDEEngineNotifier object which will receive notifications by the engine about changes in the
    ///   IDE. See TIDEEngineNotifier for more information.
    procedure AddNotifier(ANotifier: TIDEEngineNotifier);

    /// Description:
    ///   Call RemoveNotifier to remove the TIDEEngineNotifier object specified by ANotifier which was previously registered
    ///   with AddNotifier. The object will no longer receive notifications from the engine.
    procedure RemoveNotifier(ANotifier: TIDEEngineNotifier);

    /// Description:
    ///   This method opens a dialog for the user to choose a script language. AItemName is just
    ///   the name of the item which the language will be chosen for, e.g. "Project", "Unit".
    ///   Warning: if the user press Cancel, then an Abort exception is raised. The language selected by end-user in the dialog
    ///   is returned by the function.
    function DlgSelectLanguage(AItemName: string): TScriptLanguage;

    /// Description:
    ///   This method opens a dialog window for the end-user to choose the unit which will be the main unit of project.
    ///   If the operation was canceled by end-user, this method returns false, otherwise it returns true.
    function DlgSelectMainUnit: boolean;

    /// Description:
    ///   Creates all needed units for a blank project to run an empty form.
    ///   In summary it creates a file with a script and a form, creates another file with a script and makes it the main unit of the project,
    ///   and add code to the main unit to automatically create and show the form.
    ///   The language of the scripts must be specified by ALanguage parameter.
    procedure CreateMainUnits(ALanguage: TScriptLanguage);

    /// Description:
    ///   Call NewFormUnit to programatically add a new file to current project. The file will contain a script and an associated form.
    ///   The language of the script is specified by ALanguage parameter. The newly created file will become the selected (active) file
    ///   in the IDE, if IDE is visible.
    ///   The method returns the newly created TIDEProjectFile object associated with the file.
    function NewFormUnit(ALanguage: TScriptLanguage): TIDEProjectFile;

    /// Description:
    ///   Call NewUnit to programatically add a new file to current project. The file will contain a script and will not
    ///   have a form associated with it. The language of the script is specified by ALanguage parameter.
    ///   If AMakeActive parameter is true, the newly created file will become the selected (active) file in the IDE, if IDE is visible.
    ///   The method returns the newly created TIDEProjectFile object associated with the file.  
    function NewUnit(ALanguage: TScriptLanguage; AMakeActive: boolean = true): TIDEProjectFile;

    /// Description:
    ///   NewProject method programatically creates a new blank project. Since TIDEEngine is not multi-project, calling NewProject
    ///   will automatically discard the existing project. This method does not open any dialog or asks for confirmation.
    ///   To create a new project with end-user interaction, use DlgNewProject.
    function NewProject: boolean;

    /// Description:
    ///   SaveProject saves the current project and its files using the current settings and file names. This should be used
    ///   for programatically saving the project, it does not open any dialog for the end-user or asks for confirmation.
    ///   To save a project with end-user interaction, use DlgSaveProject or DlgSaveProjectAs methods.
    procedure SaveProject;

    /// Description:
    ///   LoadProject loads the current project using current settings. You will rarely call LoadProject, it is internally
    ///   used by OpenProject method, which is the one you should use to programatically load a project from file.
    function LoadProject: boolean;

    /// Description:
    ///   OpenFile opens the file specified by AFileName and adds it to the project. If the IDE is open, the file is displayed
    ///   in the IDE and becomes active. If the file already exists in the project, it is just open and made active in the IDE.
    ///   The TIDEProjectFile associated with the file is returned by the method.
    ///   No dialog or confirmation is displayed by OpenFile, it's most used to manipulate files from code.
    ///   To open a file with end-user interaction (open dialog), use DlgOpenFile method.
    function OpenFile(AFileName: string): TIDEProjectFile;

    /// Description:
    ///   OpenProject loads the project specified by AFileName, and all its associated files.
    ///   Since TIDEEngine is not multi-project, loading an existing project will automatically discard the existing project.
    ///   This should be used to programatically open a project, it does not open any dialog for the end-user or asks for confirmation.
    ///   To open a project with end-user interaction, use DlgOpenProject.
    function OpenProject(AFileName: string): boolean;

    /// Description:
    ///   SyncFilesFromScripts method is a way to programatically create a script project in the engine given the current scripts
    ///   in the scripter component specified in the Scripter property. This method removes any file in the project that has no
    ///   script associated in the Scripter. A new file is created for any script in scripter component that doesn't have an associated file
    ///   in the project.
    ///   You will use this method mostly for backward compatibility, if you want to create a project from source code, it is
    ///   better to use NewUnit or NewFormUnit methods instead of creating the scripts in the scripter component and then
    ///   call SyncFilesFromScripts.
    procedure SyncFilesFromScripts;

    /// Description:
    ///   Notifies the IDE that the active file was modified. This is often called by external/custom editors.
    procedure ActiveFileModified;

    /// Description:
    ///   DlgNewProject opens a new dialog to create a new script project. Internally it calls NewProject method, see that
    ///   method documentation for more information.
    ///   It returns true if the end-user confirmed the project creation, false if end-user canceled the operation.
    function DlgNewProject: boolean;

    /// Description:
    ///   DlgOpenProject opens a dialog for choosing a project file and then open the project file, clearing all units and
    ///   loading the units belonging to that project. It returns true if end-user confirmed the operation and the project
    ///   is opened successfully.
    ///   If the dialog was canceled, this method returns false.
    function DlgOpenProject: boolean;

    /// Description:
    ///   Call DlgOpenFile to open an existing file in the IDE interface. It will open a dialog for choosing the file,
    ///   and if confirmed, the new file will be added to the project and opened in the IDE. This method returns the
    ///   newly created TIDEProjectFile which contains the opened file.
    ///   If end-user canceled the open dialog, DlgOpenFile returns nil.
    function DlgOpenFile: TIDEProjectFile;

    /// Description:
    ///   Call DlgSaveFile method to save the file specified by AFile. It automatically opens the "Save as..."
    ///   dialog if the file was not yet saved for the first time. This method returns true if the file was saved succesfully,
    ///   false if end-user canceled the save dialog.
    function DlgSaveFile(AFile: TIDEProjectFile): boolean;

    /// Description:
    ///   Same for DlgSaveFile method, except you don't have to pass the file to be saved, it uses the currently active file in the project.
    function DlgSaveActiveFile: boolean;

    /// Description:
    ///   Opens the "Save as..." dialog for saving an unit. It performs extra operations like checking if the unit name
    ///   already exists, and update the script source code (directive "$FORM") with the correct file name, in case the file name was changed.
    ///   This method returns true if the file was saved succesfully
    function DlgSaveFileAs(AFile: TIDEProjectFile): boolean;

    /// Description:
    ///   Same as DlgSaveFileAs, except you don't have to pass the file to be saved, it uses the currently active file in the project.
    function DlgSaveActiveFileAs: boolean;

    /// Description:
    ///   Save all files in the project at once. For each file, if the file is not saved, it opens a "Save as..." dialog.
    ///   If the dialog is canceled at some point, the remaining files will not be saved. This function returns true if
    ///   all files were saved sucessfully
    function DlgSaveAll: boolean;

    /// Description:
    ///   Closes the file specified by AFile. If the file was already saved, then it is not removed from project, just made invisible in the IDE.
    ///   If the file is a new file that was not saved yet, then it's removed. If the file was modified, the engine opens a dialog
    ///   asking the end-user to confirm if the file should be saved. The result of the closing operation is returned in the
    ///   TIDECloseFileResult result
    function DlgCloseFile(AFile: TIDEProjectFile): TIDECloseFileResult;

    /// Description:
    ///   Same as DlgCloseFile, except that you don't have to pass the file to closed, it uses the currently active file.
    function DlgCloseActiveFile: TIDECloseFileResult;

    /// Description:
    ///   Closes all files in the project and then the project itself. It calls DlgCloseFile for each file in the project,
    ///   and tries to save the project if it is new one or was modified. For some files a dialog asking for confirmation to save
    ///   the file might be displayed, if the end-user press Cancel at some point, the Close All operation will be aborted.
    ///   This method returns true only if all files and the project were closed.
    function DlgCloseAll: boolean;

    /// Description:
    ///   Removes the file specified by AFile from the project. If the file was not saved, it shows a dialog asking for saving it. The method
    ///   returns true if the file was successfully removed.
    function DlgRemoveFile(AFile: TIDEProjectFile): boolean;

    /// Description:
    ///   Same as DlgRemoveFile, except you don't have to pass the file to be removed, it removes the currently active file.
    function DlgRemoveActiveFile: boolean;

    /// Description:
    ///   Opens a save dialog to save the current project. Returns true if the project was saved sucessfully.
    ///   It does not save the files, only the main project file.
    function DlgSaveProjectAs: boolean;

    /// Description:
    ///   Save the current project. If the project was not saved yet, it calls DlgSaveProjectAs to choose the file name for the project.
    function DlgSaveProject: boolean;

    /// Description:
    ///   Calls the Add Watch dialog to add a new watch while debugging. Returns nil if no watch is added, otherwise returns the newly
    ///   created TatScripterWatch object. There is no need to destroy this object later, the engine takes care of it automatically.
    function DlgAddWatch: TatScripterWatch;

    /// Description:
    ///   Toggles the edit mode from unit view to form view and vice-versa. Basically it displays and set focus on the memo
    ///   if the form designer is active, and vice-versa
    procedure ToggleViewMode;

    /// Description:
    ///   Executes a script in the project according to RunMode option. If RunMode is rmMainUnit,
    ///   then the main unit of project is executed. If RunMode is rmActiveUnit, then
    ///   the active unit is executed
    procedure RunScript(RunMode: TIDERunMode = rmMainUnit);

    /// Description:
    ///   Compiles the main unit script of the project, and its dependencies.
    procedure CompileProject;

    /// Description:
    ///   Executes the main unit script. Same as RunScript(rmMainUnit)
    procedure RunProject;

    /// Description:
    ///   Runs the script currently active in the IDE. Save as RunScript(rmActiveUnit)
    procedure RunActiveScript;

    /// Description:
    ///   Pauses the script execution, for IDE debugging purposes
    procedure DebugPause;

    /// Description:
    ///   Performs debug step over action in the current active script.
    ///   RunMode is used only if the project is not running, to specify which script will be used to start execution.
    procedure DebugStepOver(RunMode: TIDERunMode = rmMainUnit);

    /// Description:
    ///   Performs debug step into action in the current active script.
    ///   RunMode is used only if the project is not running, to specify which script will be used to start execution.
    procedure DebugTraceInto(RunMode: TIDERunMode = rmMainUnit);

    /// Description:
    ///   Performs debug action "run to line": run the active script until the line currently selected in memo editor.
    ///   RunMode is used only if the project is not running, to specify which script will be used to start execution.
    procedure DebugRunToLine(RunMode: TIDERunMode = rmMainUnit);

    /// Description:
    ///   Performs debug action "run until return": run the active script until the routine exists.
    ///   RunMode is used only if the project is not running, to specify which script will be used to start execution.
    procedure DebugUntilReturn;

    /// Description:
    ///   Halts script execution.
    procedure DebugReset;

    /// Description:
    ///   Toggles breakpoint on/off in the memo and script, in the line number specified by ALine.
    ///   If ALine is -1 then current line in memo will be toggled for breakpoint
    procedure DebugToggleBreak(ALine: integer = -1);

    /// Description:
    ///   Registers the following components in the tab "Standard": TMainMenu, TPopupMenu, TLabel,
    ///   TEdit, TMemo, TButton, TCheckBox, TRadioButton, TListBox, TComboBox, TGroupBox, TPanel, TRadioGroup}
    procedure RegisterStandardTab;

    /// Description:
    ///   Registers the following components in the tab "Additional": TBitBtn, TSpeedButton, TMaskEdit,
    ///   TImage, TShape, TBevel, TStaticText, TSplitter
    procedure RegisterAdditionalTab;

    /// Description:
    ///   Registers the following components in the tab "Dialogs": TOpenDialog, TSaveDialog, TFontDialog,
    ///   TColorDialog, TPrintDialog, TPrinterSetupDialog
    procedure RegisterDialogsTab;

    /// Description:
    ///   Registers the following components in the tab "Win32":
    ///   TTabControl, TPageControl, TProgressBar, TTreeView, TListView, TDateTimePicker
    procedure RegisterWin32Tab;

    /// Description:
    ///   Use RegisterComponent to make a new component available in the IDE toolbar to be used in form designing.
    ///   Use APage parameter to specify the name of the tab in the palette toolbar in which the component will appear.
    ///   ACompClass is the class of the component to be made available, for example TButton, TGroupBox, etc.
    ///   AUsedUnits is a comma-delimited list with the names of all units that will be added to the script uses clause
    ///   when the component is used in a form. See TIDERegisteredComp.Units property for more information.
    procedure RegisterComponent(APage: string; ACompClass: TComponentClass; AUsedUnits: string = '');

    /// Description:
    ///   Unregisters a component previously registered with RegisterComponent method. You must pass the class
    ///   of the component to be unregistered.
    procedure UnregisterComponent(ACompClass: TComponentClass); overload;

    /// Description:
    ///   Unregisters a component previously registered with RegisterComponent method. You must pass the class name
    ///   of the component to be unregistered.
    procedure UnregisterComponent(AClassName: string); overload;

    /// Description:
    ///   Unregisters all existing registered components belonging to the page specified by APage. In other words, the tab
    ///   specified by APage will be removed and will not appear in the component palette toolbar in the IDE.
    procedure UnregisterTab(APage: string);

    /// Description:
    ///   Return the number of visible files in IDE
    function VisibleFileCount: integer;

    /// Description:
    ///   Provides indexed access to all visible files in the IDE.
    property VisibleFiles[Index: integer]: TIDEProjectFile read GetVisibleFile;

    /// Description:
    ///   Provides access to the TIDEFormDesigner component being used to design the currently active form.
    ///   You can use the TIDEFormDesigner object to perform some low-level operations using methods and properties
    ///   provided by that component that perform operations in the form being designed.
    property Designer: TIDEFormDesigner read GetDesigner;

    /// Description:
    ///   Returns the project file that is currently active (selected) in the IDE.
    property ActiveFile: TIDEProjectFile read FActiveFile write SetActiveFile;

    /// Description:
    ///   RegisteredComps property provides a collection of all components currently registered in the engine that will
    ///   be available in IDE component palette toolbars for the end-user to use in form designing.
    property RegisteredComps: TIDERegisteredComps read FIDEComps;

    /// Description:
    ///   ProjectName holds the name of the current project, without file path or file extension.
    property ProjectName: string read FProjectName write SetProjectName;

    /// Description:
    ///   ActiveScript provides access to the TatScript object associated with the project file currently active (selected) inthe IDE.
    property ActiveScript: TatScript read GetActiveScript;

    /// Description:
    ///   Specifies the main unit of the project. The main unit is the unit which will be executed
    ///   when the project runs.
    property MainUnit: TIDEProjectFile read FMainUnit write SetMainUnit;

    /// Description:
    ///   Contains a collection of all the files belonging to the current project.
    ///   A file might be visible (in the ide) and/or active (selected, when visible), and Engine component
    ///   uses the list of files to do several things
    property Files: TIDEProjectFiles read FFiles;

    /// Description:
    ///   Retrieves the component which is current selected in the environment. If multiple components are selected,
    ///   this property returns nil
    property SelectedComponent: TComponent read GetSelectedComponent write SetSelectedComponent;

    /// Summary:
    ///   Specifies if a default event is edited when a component is double clicked in the designer.
    /// Description:
    ///   When PreventDefaultEventCreation is false (the default behavior), when an user double clicks a component in the
    ///   form designer, the inspector is put in imEvents mode (to show the component events),
    ///   and the existing event handler for the default event is displayed in the script memo.
    ///   If the event doesn't exist in script source code, it is created. For example, when the end-user
    ///   double-clicks a TButton component named Button1, a Button1Click procedure is created in the script
    ///   source code and assigned to the OnClick event of the TButton.
    ///   You will only need to change this property in case you are building your own custom IDE and for
    ///   some reason you don't want this behavior to be automatic.
    property PreventDefaultEventCreation: boolean read FPreventDefaultEventCreation write FPreventDefaultEventCreation;
  published
    /// Description:
    ///   Contains a reference to the TIDEFormDesignControl component that will handle the designing of the project forms.
    ///   You only need to set this property if you are building your own custom IDE. If you are using TIDEDialog component
    ///   to display the predefined IDE, this property will be set automatically.
    ///   Assigning the component to this property is the same as associating the Engine property of component to this TIDEEngine.
    property DesignControl: TIDEFormDesignControl read FDesignControl write SetDesignControl;

    /// Description:
    ///   Contains a reference to the TIDEInspector component that will be used as the IDE object inspector.
    ///   The engine will automatically update the inspector according to the selections in the form designer.
    ///   You only need to set this property if you are building your own custom IDE. If you are using TIDEDialog component]
    ///   to display the predefined IDE, this property will be set automatically.
    ///   Assigning the component to this property is the same as associating the Engine property of component to this TIDEEngine.
    property Inspector: TIDEInspector read FInspector write SetInspector;

    /// Description:
    ///   Contains a reference to the TIDEComponentComboBox component that will be used as the IDE component combo box.
    ///   The engine will automatically update the combo box according to the selections in the form designer,
    ///   and if the selection in the combo box changes, the engine will change the form design selection accordingly.
    ///   You only need to set this property if you are building your own custom IDE. If you are using TIDEDialog component
    ///   to display the predefined IDE, this property will be set automatically.
    ///   Assigning the component to this property is the same as associating the Engine property of component to this TIDEEngine.
    property ComponentCombo: TIDEComponentComboBox read FComponentCombo write SetComponentCombo;

    /// Description:
    ///   Contains a reference to the TIDEScripter component used by TIDEEngine for all scripting operations.
    ///   A TIDEEngine component can't do most of its operations without an associated TIDEScripter, regardless if you are building
    ///   a custom IDE or using the standard one provided by TIDEDialog.
    ///   The engine uses the scripter component to execute the scripts project, to provide code completion, manage debug watches,
    ///   perform source code refactoring, among other tasks.
    ///   The engine manipulates the scripter component when needed, adding or removing scripts, setting source code, etc..
    ///   Assigning a TIDEScripter component to this property is the same as associating the Engine property of TIDEScripter to this TIDEEngine.
    property Scripter: TIDEScripter read FScripter write SetScripter;

    /// Description:
    ///   Not used.
    property FormDesigner: TIDEFormDesigner read FFormDesigner write SetFormDesigner;

    {$IFDEF DELPHI9_LVL}
    /// Description:
    ///   Contains a reference to the TIDEPaletteButtons component that will be used as the palette toolbar in the IDE.
    ///   You only need to set this property if you are building your own custom IDE. If you are using TIDEDialog component
    ///   to display the predefined IDE, this property will be set automatically.
    ///   Assign the component to this property is the same as associating the Engine property of component to this TIDEEngine.
    ///   This property is only available for Delphi 2005 and above.
    property PaletteButtons: TIDEPaletteButtons read FPaletteButtons write SetPaletteButtons;
    {$ENDIF}

    /// Description:
    ///   Contains a reference to the TIDEPaletteToolbar component that will be used as the palette toolbar in the IDE.
    ///   You only need to set this property if you are building your own custom IDE. If you are using TIDEDialog component
    ///   to display the predefined IDE, this property will be set automatically.
    ///   Assign the component to this property is the same as associating the Engine property of component to this TIDEEngine.
    property PaletteToolbar: TIDEPaletteToolbar read FPaletteToolbar write SetPaletteToolbar;

    /// Description:
    ///   Contains a reference to the TIDEWatchListView component that will list the debug watches in the IDE.
    ///   The engine will automatically update the watches during the debug operation.
    ///   You only need to set this property if you are building your own custom IDE. If you are using TIDEDialog component
    ///   to display the predefined IDE, this property will be set automatically.
    ///   Assign the component to this property is the same as associating the Engine property of component to this TIDEEngine.
    property WatchList: TIDEWatchListView read FWatchList write SetWatchList;

    /// Description:
    ///   Contains a reference to the TIDEMemo component that will be used as the source code editor in the IDE.
    ///   The engine will automatically update the memo content accordingly to the current project file being edited,
    ///   and will also use the memo changes to update the project file automatically.
    ///   You only need to set this property if you are building your own custom IDE. If you are using TIDEDialog component
    ///   to display the predefined IDE, this property will be set automatically.
    ///   Assign the component to this property is the same as associating the Engine property of component to this TIDEEngine.
    property Memo: TIDEMemo read FMemo write SetMemo;

    /// Description:
    ///   Contains the base path used to save the project. In general, the project files are saved with relative file paths.
    ///   All paths are relative to this base path. This property is automatically set when you load a project from a file, in this case
    ///   the base path will be the path of the project file.
    property BasePath: string read FBasePath write SetBasePath;

    /// Description:
    ///   OnShowSourceEditor event is fired when the IDE needs to show the memo editor and position the cursor at an specified
    ///   location. The IDE does that automatically when using TIDEDialog, you only need to set this event in case you are building
    ///   your own custom IDE.
    property OnShowSourceEditor: TIDEShowSourceEditorEvent read FOnShowSourceEditor write FOnShowSourceEditor;

    /// Description:
    ///   Contains a reference to the tab control component that will be used to show the visible files the IDE.
    ///   The engine will automatically updates the tabs of the control accordingly to the visible files, and synchronizes
    ///   the current active file in the IDE with the current selected tab.
    ///   The valid controls for this property are TTabControl and TAdvOfficeTabSet.
    ///   You only need to set this property if you are building your own custom IDE. If you are using TIDEDialog component
    ///   to display the predefined IDE, this property will be set automatically.
    ///   Assign the component to this property is the same as associating the Engine property of component to this TIDEEngine.
    property TabControl: TControl read FTabControl write SetTabControl;

    /// Description:
    ///   Provides access to subproperties that control the behavior of the IDE. See TIDEEngineOptions documentation.
    property Options: TIDEEngineOptions read FOptions write SetOptions;

    /// Description:
    ///   Specifies the file extension used for pascal source code files. Default value is '.psc'
    property FileExtPascalUnit: string read FFileExtPascalUnit write FFileExtPascalUnit;

    /// Description:
    ///   Specifies the file extension used for form files. Default value is '.dfm'
    property FileExtForm: string read FFileExtForm write FFileExtForm;

    /// Description:
    ///   Specifies the file extension used for basic source code files. Default value is '.bsc'
    property FileExtBasicUnit: string read FFileExtBasicUnit write FFileExtBasicUnit;

    /// Description:
    ///   If AutoStyler is true, the TIDEMemo editor associated with the engine will have its syntax highlighting automatically
    ///   configured to the language of the current script it is being displayed. For example, if the current script is a basic script,
    ///   the memo will show the script content with basic syntax highlighting.
    ///   You will only need to set this property to false in case you are building your own custom IDE and you want to set a custom
    ///   syntax highlighting to the memo.
    property AutoStyler: boolean read FAutoStyler write FAutoStyler;

    /// Description:
    ///   OnProjNameChanged event is fired when the name of current project is changed, either because of a save as operation,
    ///   or because a new project was created/open
    property OnProjNameChanged: TNotifyEvent read FOnProjNameChanged write FOnProjNameChanged;

    /// Description:
    ///   OnViewModeChanged is fired when the display mode of current active file changes from unit (source code) to form
    ///   or vice-versa.
    property OnViewModeChanged: TNotifyEvent read FOnViewModeChanged write FOnViewModeChanged;

    /// Description:
    ///   OnActiveFileChanged is fired when the currently active (selected) file in the IDE changes.
    property OnActiveFileChanged: TNotifyEvent read FOnActiveFileChanged write FOnActiveFileChanged;

    /// Description:
    ///   BeforeAddWatchDlg event is fired before a add watch dialog is displayed (when DlgAddWatch method is caled).
    property BeforeAddWatchDlg: TNotifyEvent read FBeforeAddWatchDlg write FBeforeAddWatchDlg;

    /// Description:
    ///   OnGetComponentImage is fired, for each registered component, when the component palette toolbar builds itself,
    ///   to allow programmer to provide an icon image for the component to be displayed in the palette toolbar.
    property OnGetComponentImage: TIDEGetComponentImageEvent read FOnGetComponentImage write FOnGetComponentImage;

    /// Description:
    ///   OnComponentPlaced is fired when a new component is placed (added) in the form being designed.
    property OnComponentPlaced: TComponentNotifyEvent read FOnComponentPlaced write FOnComponentPlaced;

    /// Description:
    ///   OnRunningChanged event is fired when a script execution starts or stops.
    property OnRunningChanged: TRunningChangeEvent read FOnRunningChanged write FOnRunningChanged;

    /// Description:
    ///   OnCheckValidFile is used to inform the engine if a project file exists or not. See TCheckValidFileEvent for more information.
    property OnCheckValidFile: TCheckValidFileEvent read FOnCheckValidFile write FOnCheckValidFile;

    /// Description:
    ///   OnLoadFile can be used to load a project file from a different place other than the hard disk.
    ///   See TIDELoadFileEvent for more information.
    property OnLoadFile: TIDELoadFileEvent read FOnLoadFile write FOnLoadFile;

    /// Description:
    ///   OnSaveFile can be used to save a project file to a different place other than the hard disk.
    ///   See TIDESaveFileEvent for more information.
    property OnSaveFile: TIDESaveFileEvent read FOnSaveFile write FOnSaveFile;

    /// Description:
    ///   OnSaveDialog can be used to display a custom save dialog instead of the standard one used by the IDE engine.
    ///   See TIDESaveDialogEvent for more information.
    property OnSaveDialog: TIDESaveDialogEvent read FOnSaveDialog write FOnSaveDialog;

    /// Description:
    ///   OnOpenDialog can be used to display a custom open dialog instead of the standard one used by the IDE engine.
    ///   See TIDEOpenDialogEvent for more information.
    property OnOpenDialog: TIDEOpenDialogEvent read FOnOpenDialog write FOnOpenDialog;

    /// Description:
    ///   OnDesignerSelectionChanged is fired when the current selected componented is changed in form designer.
    property OnDesignerSelectionChanged: TNotifyEvent read FOnDesignerSelectionChanged write FOnDesignerSelectionChanged;
  end;

implementation

uses
  atPascal, atBasic, Advmps, Advmbs, MenuInspIDEEditor, MenuInspEditor,
  {$IFDEF DELPHI2009_LVL}
  Character,
  {$ENDIF}

  {add the following units because they are automatically added by the engine when a form is created.
  Do not include those in C++Builder due to incompatibility problems.}
  {
  ap_Graphics, ap_Controls, ap_Forms, ap_Dialogs,

  ap_StdCtrls, ap_Windows, ap_System,
  ap_ExtCtrls, ap_ComCtrls, ap_Menus, ap_Buttons,}

  IniFiles, fWatchProperties,
  {The units below are not needed unless for the purpose of registering components in the IDEEngine}
  StdCtrls, Mask, fSelectLanguage, fSelectUnit;

function IsPathRelative(APath: string): boolean;
begin
  result := true;
  if Length(APath) > 0 then
  begin
    {if the string begins with "\", then it's not relative}
    if IsPathDelimiter(APath, 1) then
    begin
      result := false;
      exit;
    end;

    {if the string begins with drive letter then it's not relative}

    if ExtractFileDrive(APath) <> '' then
    begin
      result := false;
      exit;
    end;
  end;
end;

function AddPathDelim(APath: string): string;
begin
  {$IFDEF DELPHI6_LVL}
  result := IncludeTrailingPathDelimiter(APath);
  {$ELSE}
  result := IncludeTrailingBackslash(APath);
  {$ENDIF}
end;

function CanFocusControl(AControl: TWinControl): boolean;
var
  AForm: TCustomForm;
begin
  AForm := GetParentForm(AControl);
  result := AControl.CanFocus and (AForm <> nil) and (AForm.Visible) and (AForm.Enabled)
end;

{$R *.RES}

procedure TControlDesignerFrame.ControlChanged;
begin
  if FDesignControl <> nil then
    FDesignControl.FrameControlChanged;
end;

procedure TControlDesignerFrame.UpdateShape;
var
  R: TRect;
  RGN: HRGN;
begin
  if FRegion <> 0 then
    DeleteObject(FRegion);
  R := Rect(0, 0, Width, Height);
  with R do
    FRegion := CreateRectRgn(Left, Top, Right, Bottom);
  InflateRect(R, -GetThickness, -GetThickness);
  with R do
    RGN := CreateRectRgn(Left, Top, Right, Bottom);
  try
    CombineRgn(FRegion, FRegion, RGN, RGN_DIFF);
  finally
    DeleteObject(RGN);
  end;
  SetWindowRgn(Handle, FRegion, True);
end;

function TControlDesignerFrame.MouseZone(X, Y: Integer): TMouseZone;
begin
  Result := mzNone;
  if Y <= GetThickness then
  begin
    if X <= GetThickness then
      Result := mzLeftTop
    else
      if X >= Width - GetThickness then Result := mzRightTop
      else
        if (X >= (Width - GetThickness) div 2) and (X <= (Width + GetThickness) div 2) then
          Result := mzCenterTop
        else
          if Y >= (GetThickness - FrameWidth) then
            Result := mzTopFrame
  end
  else
    if Y >= Height - GetThickness then
    begin
      if X <= GetThickness then
        Result := mzLeftBottom
      else
        if X >= Width - GetThickness then
          Result := mzRightBottom
        else
          if (X >= (Width - GetThickness) div 2) and (X <= (Width + GetThickness) div 2) then
            Result := mzCenterBottom
          else
            if Y <= (Height - GetThickness + FrameWidth) then
              Result := mzBottomFrame
    end
    else
      if X <= GetThickness then
      begin
        if (Y >= (Height - GetThickness) div 2) and (Y <= (Height + GetThickness) div 2) then
          Result := mzLeftCenter
        else
          if X >= (GetThickness - FrameWidth) then
            Result := mzLeftFrame
      end
      else
        if X >= Width - GetThickness then
        begin
          if (Y >= (Height - GetThickness) div 2) and (Y <= (Height + GetThickness) div 2) then
            Result := mzRightCenter
          else
            if X <= (Width - GetThickness + FrameWidth) then
              Result := mzRightFrame;
        end;
  if Result in RemovedZones then
    Result := mzNone;
end;

procedure TControlDesignerFrame.DrawDragRect;
var
  ParentCanvas: TCanvas;
begin
  if Assigned(Parent) then
  begin
    ParentCanvas := TCanvas.Create;
    with ParentCanvas do
    begin
      Handle := GetDCEx(Parent.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS or DCX_PARENTCLIP);
      try
        with Pen do
        begin
          Style := psSolid;
          Mode := pmXor;
          Width := 2;
          Color := clGray;
        end;
        Brush.Style := bsClear;
        with FDragRect do
          Rectangle(Left + 1, Top + 1, Right, Bottom);
      finally
        ReleaseDC(0, ParentCanvas.Handle);
        ParentCanvas.Handle := 0;
        ParentCanvas.Free;
      end;
    end;
  end;
end;

procedure TControlDesignerFrame.ShowDragHint(AHint: string);
var
  R: TRect;
  P: TPoint;
begin
  if FShowMoveSizeHint then
    with FHintWindow do
    begin
      R := CalcHintRect(255, AHint, nil);
      GetCursorPos(P);
      OffsetRect(R, P.X, P.Y + 12);
      ActivateHint(R, AHint);
    end;
end;

procedure TControlDesignerFrame.HideDragHint;
begin
  FHintWindow.ReleaseHandle;
end;

procedure TControlDesignerFrame.SetControl(const Value: TControl);
begin
  FControl := Value;
  Visible := Assigned(FControl);
  UpdatePosition;
  if FEnableKeys and Showing and CanFocusControl(Self) then SetFocus;
end;

procedure TControlDesignerFrame.SetGrabColor(const Value: TColor);
begin
  if Value <> FGrabColor then
  begin
    FGrabColor := Value;
    Invalidate;
  end;
end;

procedure TControlDesignerFrame.SetEnableKeys(const Value: Boolean);
begin
  FEnableKeys := Value;
  if FEnableKeys and Showing and CanFocusControl(Self) then SetFocus;
end;

procedure TControlDesignerFrame.CreateHandle;
begin
  inherited;
  UpdatePosition;
end;

procedure TControlDesignerFrame.Paint;
var
  T: Integer;
  Offset: integer;
begin
  with Canvas do
  begin
    Case FStyle of
      fsDelphi:
        begin
          Offset := GetThickness - FrameWidth;
          Brush.Assign(FBrush);
          Pen.Assign(FPen);
          Rectangle(Offset, Offset, Width - Offset, Height - Offset);
          Rectangle(Pred(GetThickness), Pred(GetThickness), Width - Pred(GetThickness), Height - Pred(GetThickness));

          Brush.Color := FGrabColor;
          Brush.Style := bsSolid;
          Pen.Color := FGrabBorderColor;
          Pen.Style := psSolid;

          T := GrabSize;
          if not (mzLeftTop in RemovedZones) then
            Rectangle(0, 0, T, T);
          if not (mzCenterTop in RemovedZones) then
            Rectangle((Width - T) div 2, 0, (Width + T) div 2, T);
          if not (mzRightTop in RemovedZones) then
            Rectangle(Width - T, 0, Width, T);

          if not (mzLeftCenter in RemovedZones) then
            Rectangle(0, (Height - T) div 2, T, (Height + T) div 2);
          if not (mzRightCenter in RemovedZones) then
            Rectangle(Width - T, (Height - T) div 2, Width, (Height + T) div 2);

          if not (mzLeftBottom in RemovedZones) then
            Rectangle(0, Height - T, T, Height);
          if not (mzCenterBottom in RemovedZones) then
            Rectangle((Width - T) div 2, Height - T, (Width + T) div 2, Height);
          if not (mzRightBottom in RemovedZones) then
            Rectangle(Width - T, Height - T, Width, Height);
        end;
      fsVisualStudio:
        begin
          Pen.Assign(FPen);
          Brush.Assign(FBrush);
          DrawFocusRect(Rect(GetThickness - 2, GetThickness - 2, Width - GetThickness + 2, Height - GetThickness + 2));

          Brush.Color := FGrabColor;
          Brush.Style := bsSolid;
          Pen.Color := FGrabBorderColor;
          Pen.Style := psSolid;
          T := GrabSize;

          if not (mzLeftTop in RemovedZones) then
            RoundRect(1, 1, T + 1, T + 1 , 2, 2);
          if not (mzCenterTop in RemovedZones) then
            RoundRect((Width - T) div 2, 1, (Width + T) div 2, T + 1, 2, 2);
          if not (mzRightTop in RemovedZones) then
            RoundRect(Width - T - 1, 1, Width - 1, T + 1, 2, 2);

          if not (mzLeftCenter in RemovedZones) then
            RoundRect(1, (Height - T) div 2, T + 1, (Height + T) div 2, 2, 2);
          if not (mzRightCenter in RemovedZones) then
            RoundRect(Width - T - 1, (Height - T) div 2, Width - 1, (Height + T) div 2, 2, 2);

          if not (mzLeftBottom in RemovedZones) then
            RoundRect(1, Height - T - 1, T + 1, Height - 1, 2, 2);
          if not (mzCenterBottom in RemovedZones) then
            RoundRect((Width - T) div 2, (Height - T) - 1, (Width + T) div 2, Height - 1, 2, 2);
          if not (mzRightBottom in RemovedZones) then
            RoundRect(Width - T - 1, Height - T - 1, Width - 1, Height - 1, 2, 2);
        end;
    end;
  end;
end;

procedure TControlDesignerFrame.WndProc(var Message: TMessage);
var
  P: TPoint;
  R: TRect;
  X,Y,Step: Integer;
  Shift: Boolean;
begin
  with Message do
    case Msg of
      WM_SETCURSOR:
      begin
        GetCursorPos(P);
        P:=ScreenToClient(P);
        case MouseZone(P.X,P.Y) of
          {$WARNINGS OFF}
          mzFrame: SetCursor(LoadCursor(0, IDC_SIZEALL));
          mzTopFrame, mzBottomFrame: SetCursor(LoadCursor(0,IDC_SIZENS));
          mzLeftFrame, mzRightFrame: SetCursor(LoadCursor(0,IDC_SIZEWE));
          mzLeftTop,mzRightBottom: SetCursor(LoadCursor(0,IDC_SIZENWSE));
          mzLeftBottom,mzRightTop: SetCursor(LoadCursor(0,IDC_SIZENESW));
          mzCenterTop,mzCenterBottom: SetCursor(LoadCursor(0,IDC_SIZENS));
          mzLeftCenter,mzRightCenter: SetCursor(LoadCursor(0,IDC_SIZEWE));
          {$WARNINGS ON}
        end;
      end;
      WM_LBUTTONDOWN:
      begin
        if (FDesignControl <> nil) then FDesignControl.DoFocus;
        FDragZone:=MouseZone(lParamLo,lParamHi);
        if FDragZone <> mzNone then
        begin
          Visible:=False;
          FDragRect:=FControl.Parent.ClientRect;
          MapWindowPoints(FControl.Parent.Handle,HWND_DESKTOP,FDragRect,2);
          //ClipCursor(@FDragRect);
          FDragRect:=FControl.BoundsRect;
          GetCursorPos(FDragPoint);
          if not FDirectDrag then DrawDragRect;
          SetCapture(Handle);
        end;
      end;
      WM_MOUSEMOVE:
        if FDragZone<>mzNone then
        begin
          GetCursorPos(P);
          R:=FDragRect;
          with R do
          begin
            X:=P.X-FDragPoint.X;
            Y:=P.Y-FDragPoint.Y;
            case FDragZone of
              mzFrame:
                OffsetRect(R, X, Y);
              mzLeftTop:
              begin
                Inc(Left,X);
                Inc(Top,Y);
              end;
              mzCenterTop, mzTopFrame:
                Inc(Top,Y);
              mzRightTop:
              begin
                Inc(Right,X);
                Inc(Top,Y);
              end;
              mzLeftCenter, mzLeftFrame:
                Inc(Left,X);
              mzRightCenter, mzRightFrame:
                Inc(Right,X);
              mzLeftBottom:
              begin
                Inc(Left,X);
                Inc(Bottom,Y);
              end;
              mzCenterBottom, mzBottomFrame:
                Inc(Bottom,Y);
              mzRightBottom:
              begin
                Inc(Right,X);
                Inc(Bottom,Y);
              end;
            end;
            if Right-Left<FMinSize then
              case FDragZone of
                mzLeftFrame,mzLeftTop,mzLeftCenter,mzLeftBottom: Left:=Right-FMinSize;
                mzRightFrame,mzRightTop,mzRightCenter,mzRightBottom: Right:=Left+FMinSize;
              end;
            if Bottom-Top<FMinSize then
              case FDragZone of
                mzTopFrame,mzLeftTop,mzCenterTop,mzRightTop: Top:=Bottom-FMinSize;
                mzBottomFrame,mzLeftBottom,mzCenterBottom,mzRightBottom: Bottom:=Top+FMinSize;
              end;
            if not EqualRect(R,FDragRect) then
            begin
              HideDragHint;
              if not FDirectDrag then
                DrawDragRect;
              FDragRect := R;
              GetCursorPos(FDragPoint);
              if not FDirectDrag then
                DrawDragRect
              else
                FControl.BoundsRect := FDragRect;
              if FDragZone = mzFrame then
                ShowDragHint(Format('%d, %d',[Left, Top]))
              else
                ShowDragHint(Format('%d x %d',[Right - Left, Bottom - Top]));
            end;
          end;
        end;
      WM_LBUTTONUP:
      begin
        if FDragZone <> mzNone then
        begin
          //ClipCursor(nil);
          if GetCapture = Handle then
            ReleaseCapture;
          HideDragHint;
          if not FDirectDrag then
          begin
            DrawDragRect;
            Control.BoundsRect := FDragRect;
          end;
          FDragZone := mzNone;
          UpdatePosition;
          Visible := Assigned(FControl);
          ControlChanged;
        end;
      end;
      WM_LBUTTONDBLCLK:
        if not FDirectDrag then
          DrawDragRect;
      WM_NCPAINT:
        if FEnableKeys then SetFocus;
      CM_CHILDKEY:
        if Assigned(FControl) then
        begin
          if GetKeyState(VK_CONTROL) and $80 <> 0 then
            Step:=8
          else
            Step:=1;
          Shift := GetKeyState(VK_SHIFT) and $80 <> 0;
          with FControl do
            case wParam of
              VK_LEFT:
                if Shift then
                begin
                  X:=Width-Step;
                  if X<FMinSize then X:=FMinSize;
                  if X<>Width then Width:=X;
                end;
                //else Left:=Left-Step;
              VK_RIGHT:
                if Shift then Width:=Width+Step;
                //else Left:=Left+Step;
              VK_UP:
                if Shift then
                begin
                  Y:=Height-Step;
                  if Y<FMinSize then Y:=FMinSize;
                  if Y<>Height then Height:=Y;
                end;
                //else Top:=Top-Step;
              VK_DOWN:
                if Shift then Height:=Height+Step;
                //else Top:=Top+Step;
            else
              begin
                inherited;
                Exit;
              end;
            end;
          UpdatePosition;
          Result := 1;
          ControlChanged;
        end;
      else
        inherited;
    end;
end;

constructor TControlDesignerFrame.Create(AOwner: TComponent);
begin
  inherited;
  FPen := TPen.Create;
  FBrush := TBrush.Create;

  FPen.Color := clSilver;
  FPen.Style := psSolid;
  FBrush.Color := clSilver;
  FBrush.Style := bsSolid;
  FGrabColor := clWhite;
  FGrabBorderColor := clBlack;
  FFrameWidth := 8;

  {FStyle := fsDelphi;
  FPen.Color := clSilver;
  FGrabSize := 8;}

  FStyle := fsVisualStudio;
  FPen.Color := clBlack;
  FGrabSize := 7;

  FPen.OnChange := StyleChanged;
  FBrush.OnChange := StyleChanged;
  FHintWindow := THintWindow.Create(Self);
  FHintWindow.Color := clInfoBk;
  FMinSize := 8;
  FShowMoveSizeHint := True;
end;

destructor TControlDesignerFrame.Destroy;
begin
  FPen.Free;
  FBrush.Free;
  DeleteObject(FRegion);
  inherited;
end;

procedure TControlDesignerFrame.StyleChanged(Sender: TObject);
begin
  UpdatePosition;
end;

procedure TControlDesignerFrame.UpdatePosition;
var
  R: TRect;
begin
  if not (csDesigning in ComponentState) and Assigned(FControl) then
  begin
    R := FControl.BoundsRect;
    InflateRect(R, GetThickness, GetThickness);
    BoundsRect := R;
    Parent := FControl.Parent;
    BringToFront;
    UpdateShape;
  end;
end;

function TControlDesignerFrame.GetThickness: integer;
begin
  if FrameWidth > GrabSize then
    result := FrameWidth
  else
    result := GrabSize;
end;

procedure TControlDesignerFrame.SetFrameWidth(const Value: integer);
begin
  if FrameWidth <> Value then
  begin
    FFrameWidth := Value;
    UpdatePosition;
  end;
end;

procedure TControlDesignerFrame.SetGrabSize(const Value: integer);
begin
  if FGrabSize <> Value then
  begin
    FGrabSize := Value;
    UpdatePosition;
  end;
end;

procedure TControlDesignerFrame.SetBrush(const Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TControlDesignerFrame.SetPen(const Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TControlDesignerFrame.SetGrabBorderColor(const Value: TColor);
begin
  if Value <> FGrabBorderColor then
  begin
    FGrabBorderColor := Value;
    Invalidate;
  end;
end;

procedure TControlDesignerFrame.SetStyle(const Value: TFrameStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    UpdatePosition;
  end;
end;

procedure TControlDesignerFrame.SetRemovedZones(const Value: TRemovedZones);
begin
  if FRemovedZones <> Value then
  begin
    FRemovedZones := Value;
    UpdatePosition;
  end
end;

{ TIDEFormDesignControl }

constructor TIDEFormDesignControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoScroll := True;
  ControlStyle := ControlStyle + [csCaptureMouse, csClickEvents];
  ParentColor := false;
  Color := clWindow;

  FFrame := TControlDesignerFrame.Create(Self);           
  FFrame.FDesignControl := Self;;
  FFrame.DirectDrag := false;
  FFrame.RemovedZones := [mzLeftTop, mzCenterTop, mzRightTop, mzTopFrame,
    mzLeftFrame, mzLeftCenter, mzLeftBottom];
  FDesigner := TIDEFormDesigner.Create(nil);
  FDesigner.AvoidFormMoving := true;
  FDesigner.FDesignControl := Self;

  {set some default properties for the designer}
  FDesigner.DisplayGrid := true;
  FDesigner.SnapToGrid := true;
end;

destructor TIDEFormDesignControl.Destroy;
begin
  EditForm := nil;
  FDesigner.Free;
  FFrame.Free;
  inherited;
end;

procedure TIDEFormDesignControl.FocusForm;
begin
  if FEditForm <> nil then
  begin
    SendMessage(FEditForm.Handle, WM_NCACTIVATE, 1, 0);

    {Windows.SetFocus was commented because if the designer frame was scrolled, when the user
     clicked the form, the scrollbars were set to the initial position, causing weird mouse/visual issues.
     Not sure why Windows.SetFocus was needed, but beware if you plan to reactivate it.}
    //Windows.SetFocus(FEditForm.Handle);
  end;
end;

procedure TIDEFormDesignControl.DeFocusForm;
begin
  if FEditForm <> nil then
  begin
    SendMessage(FEditForm.Handle, WM_NCACTIVATE, 0, 0);
    //Windows.SetFocus(FEditForm.Handle);
  end;
end;

procedure TIDEFormDesignControl.StartFormEditing;
begin
  if FEditForm <> nil then
  begin
    FEditForm.ActiveControl := nil;

    FOldLeft := FEditForm.Left;
    FOldTop := FEditForm.Top;
    FOldVisible := FEditForm.Visible;
    FOldParent := FEditForm.Parent;

    FEditForm.Parent := Self;
    FEditForm.Left := 5;
    FEditForm.Top := 5;
    FEditForm.Visible := true;

    FOldWndProc := FEditForm.WindowProc;
    FEditForm.WindowProc := FormWindowProc;

    FFrame.Control := FEditForm;

    if FDesigner.Owner <> nil then
      FDesigner.Owner.RemoveComponent(FDesigner);
    FEditForm.FreeNotification(Self);
    FEditForm.InsertComponent(FDesigner);

    //FDesigner.ParentForm := FEditForm;
    FDesigner.Active := true;
    FDesigner.DoSelectionChange;
    FDesigner.UpdateGrid;
    FEditForm.UpdateControlState; 
    FocusForm;
  end;
end;

procedure TIDEFormDesignControl.StopFormEditing;
begin
  if (FEditForm <> nil) then
  begin
    if not (csDestroying in FEditForm.ComponentState) and not (csDestroying in ComponentState) then
    begin
      FDesigner.Active := false;
      FDesigner.DoSelectionChange;
      FFrame.Control := nil;
      FEditForm.Visible := FOldVisible;
      FEditForm.Left := FOldLeft;

      FEditForm.Top := FOldTop;
      FEditForm.WindowProc := FOldWndProc;
      FEditForm.Parent := FOldParent;
      FEditForm.RemoveComponent(FDesigner);
      FEditForm.RemoveFreeNotification(Self);
    end;
  end;
end;

procedure TIDEFormDesignControl.FormWindowProc(var Msg: TMessage);
begin
  {process message before default handler}
  Case Msg.Msg of
    WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
      begin
        if (
            (Msg.wParam = HTBOTTOMLEFT) or
            (Msg.wParam = HTBOTTOM) or
            (Msg.wParam = HTBOTTOMRIGHT) or
            (Msg.wParam = HTTOPLEFT) or
            (Msg.wParam = HTTOP) or
            (Msg.wParam = HTTOPRIGHT) or
            (Msg.wParam = HTLEFT) or
            (Msg.wParam = HTRIGHT) or
            (Msg.wParam = HTCAPTION) or
            (Msg.wParam = HTMENU) or
            (Msg.wParam = HTREDUCE) or
            (Msg.wParam = HTSYSMENU) or
            (Msg.wParam = HTZOOM) or
            (Msg.wParam = HTCLOSE){ or
            (Msg.wParam = HTVSCROLL) or
            (Msg.wParam = HTHSCROLL)}
           ) then
        begin
          Msg.Msg := 0; {ignore message}
          DoFocus;
          FDesigner.Component := nil;
          {FrameControlChanged;}
        end;
      end;
  end;

  {Default handler}
  if Assigned(FOldWndProc) then
    FOldWndProc(Msg);

  {process message after default handler}
  Case Msg.Msg of
    WM_NCHITTEST:
      begin
        if (
            (Msg.Result = HTBOTTOMLEFT) or
            (Msg.Result = HTBOTTOM) or
            (Msg.Result = HTBOTTOMRIGHT) or
            (Msg.Result = HTTOPLEFT) or
            (Msg.Result = HTTOP) or
            (Msg.Result = HTTOPRIGHT) or
            (Msg.Result = HTLEFT) or
            (Msg.Result = HTRIGHT) {or
            (Msg.Result = HTCAPTION) or
            (Msg.Result = HTMENU) or
            (Msg.Result = HTREDUCE) or
            (Msg.Result = HTSYSMENU) or
            (Msg.Result = HTZOOM) or
            (Msg.Result = HTCLOSE) or
            (Msg.Result = HTVSCROLL) or
            (Msg.Result = HTHSCROLL)}
           ) then
          {set as htcaption so that when user clicks it, the form is selected}
          Msg.Result := HTCAPTION;
      end;
    WM_DESIGNERMDOWN:
      DoFocus;
    CM_COLORCHANGED:
      if FDesigner <> nil then
        FDesigner.UpdateGrid;
    WM_SIZE:
      begin
        if FEditForm <> nil then
        begin
          {Update scroll bars}
          FEditForm.EnableAutoRange;
          FEditForm.DisableAutoRange;
        end;
      end;
  end;
end;

procedure TIDEFormDesignControl.SetEditForm(const Value: TScriptForm);
begin
  if FEditForm <> Value then
  begin
    if FEditForm <> nil then
      StopFormEditing;
    FEditForm := Value;
    if FEditForm <> nil then
      StartFormEditing;
  end;
end;

procedure TIDEFormDesignControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if (AComponent = FEditForm) and (FDesigner.Owner = FEditForm) then
    begin
      FEditForm.RemoveComponent(FDesigner);
      FEditForm := nil;
    end;
  end;
end;

procedure TIDEFormDesignControl.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.DesignControl := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.DesignControl := Self;
      FEngine.FreeNotification(Self);
    end;
  end;
end;

procedure TIDEFormDesignControl.SetPopupMenu(const Value: TPopupMenu);
begin
  FDesigner.PopupMenu := Value;
end;

procedure TIDEFormDesignControl.UpdateFrame;
begin
  FFrame.UpdatePosition;
end;

procedure TIDEFormDesignControl.WMGetDlgCode(var Message: TMessage);
begin
  {Workaround problem when pressing several arrow keys - the form designer doesn't "catch"
   the message, and the arrow keys go to the form, making it unselect the form}
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIDEFormDesignControl.FrameControlChanged;
begin
  if Engine <> nil then
    Engine.DesignerChange;
end;

function TIDEFormDesignControl.GetFPopupMenu: TPopupMenu;
begin
  result := FDesigner.PopupMenu;   
end;

procedure TIDEFormDesignControl.CreateHandle;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    {if EditForm = nil then
      EditForm := FScriptForm;}
    //FScriptForm.BoundsRect := FScriptForm.BoundsRect; //visual update
  end;
end;

procedure TIDEFormDesignControl.CMEnter(var Message: TCMEnter);
begin
  inherited;
  FocusForm;
end;

procedure TIDEFormDesignControl.CMExit(var Message: TCMEnter);
begin
  inherited;
  DeFocusForm;
end;

procedure TIDEFormDesignControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  inherited;
  DoFocus;
end;

procedure TIDEFormDesignControl.DoFocus;
begin
  if not Focused and CanFocusControl(Self) then
    Windows.SetFocus(self.Handle);
end;

procedure TIDEFormDesignControl.LoadFromDFM(FileName: string;
  DFMFormat: TDFMFormat);
begin
  if Assigned(FEditForm) and Assigned(FDesigner) then
  begin
    FDesigner.LoadFromDFM(FileName, DFMFormat);
    UpdateFrame;
    FrameControlChanged;
  end;
end;

procedure TIDEFormDesignControl.SaveToDFM(FileName: string;
  DFMFormat: TDFMFormat);
begin
  if Assigned(FEditForm) and Assigned(FDesigner) then
    FDesigner.SaveToDFM(FileName, DFMFormat);
end;

procedure TIDEFormDesignControl.LoadFromStream(AStream: TStream;
  DFMFormat: TDFMFormat);
begin
  if Assigned(FEditForm) and Assigned(FDesigner) then
  begin
    FDesigner.LoadFromStream(AStream, DFMFormat);
    UpdateFrame;
    FrameControlChanged;
  end;
end;

procedure TIDEFormDesignControl.SaveToStream(AStream: TStream;
  DFMFormat: TDFMFormat);
begin
  if Assigned(FEditForm) and Assigned(FDesigner) then
    FDesigner.SaveToStream(AStream, DFMFormat);
end;

{ TIDEPaletteToolbar }

constructor TIDEPaletteToolbar.Create(AOwner: TComponent);
begin
  inherited;
  FButtonSize := 29;
  FFlatButtons := true;
  ControlStyle := ControlStyle + [csActionClient] - [csSetCaption];
  FPanel := TPanel.Create(nil);
  FButtonList := TObjectList.Create(false);
  ShowHint := true;
  UpdatePalette;
end;

destructor TIDEPaletteToolbar.Destroy;
begin
  FButtonList.Free;
  FPanel.Free;
  FPanel := nil;
  inherited;
end;

procedure TIDEPaletteToolbar.UpdatePalette;
begin
  if (Engine <> nil) and HandleAllocated and not (csDestroying in ComponentState) and not (csDesigning in ComponentState) then
  begin
    Engine.RegisteredComps.GetPageNames(Tabs);
    UpdatePanel;
    Height := Height + (ButtonSize - (DisplayRect.Bottom - DisplayRect.Top));
  end;
end;

procedure TIDEPaletteToolbar.Change;
begin
  inherited;
  UpdatePanel;
end;

function TIDEPaletteToolbar.CreateButton(AClass: TComponentClass): TPaletteButton;
begin
  result := TPaletteButton.Create(Self);
  FButtonList.Add(result);
  With result do
  begin
    Name := '';
    Caption := '';
    Flat := FlatButtons;
    Width := ButtonSize;
    Height := ButtonSize;
    Parent := FPanel;
    AllowAllUp := true;
    FClass := AClass;
    GroupIndex := 1;
    if AClass <> nil then
      Hint := AClass.ClassName;
    UpdateButtonGlyph(result, AClass);
  end;
end;

procedure TIDEPaletteToolbar.UpdatePanel;
var
  c: integer;
  i: integer;
  j: integer;
  AButton: TSpeedButton;
  AOffset: integer;
  CurrentTabName: string;

begin
  FPanel.Parent := Self;
  FPanel.Align := alClient;
  FPanel.BevelOuter := bvNone;

  {Destroy buttons}
  while FButtonList.Count > 0 do
  begin
    TComponent(FButtonList[0]).Free;
    FButtonList.Delete(0);
  end;

  {Create specific buttons}
  //i := (FPanel.ClientHeight - FButtonSize) div 2;
  i := 0;
  AOffset := i;

  {Create CancelPlacement button}
  With CreateButton(nil) do
  begin
    OnClick := CancelPlacementClick;
    Case Self.Align of
      alLeft, alRight:
      begin
        Top := AOffset;
        Left := i;
      end;
    else
      Left := AOffset;
      Top := i;
    end;
    AOffset := AOffset + ButtonSize + 5;
  end;

  CurrentTabName := '';
  if TabIndex > -1 then
    CurrentTabName := Tabs[TabIndex];

  j := 0;
  {Create blocks buttons}
  if Engine <> nil then
  begin
    for c := 0 to Engine.RegisteredComps.Count - 1 do
      if (SameText(CurrentTabName, Engine.RegisteredComps[c].Page)) then
      begin
        AButton := CreateButton(Engine.RegisteredComps[c].CompClass);
        With AButton do
        begin
          OnClick := ButtonClick;
          Tag := c;
          Case Self.Align of
            alLeft, alRight:
            begin
              Top := j * ButtonSize + AOffset;
              Left := i;
            end;
          else
            Left := j * ButtonSize + AOffset;
            Top := i;
          end;
        end;
        inc(j);
      end;
  end;
end;

procedure TIDEPaletteToolbar.SetFlatButtons(const Value: boolean);
begin
  if FFlatButtons <> Value then
  begin
    FFlatButtons := Value;
    UpdatePanel;
  end;
end;

procedure TIDEPaletteToolbar.SetButtonSize(const Value: integer);
begin
  if FButtonSize <> Value then
  begin
    FButtonSize := Value;
    UpdatePanel;
  end;
end;

procedure TIDEPaletteToolbar.UpdateButtonGlyph(ABtn: TSpeedButton;
  AClass: TClass);
var
  //Idx: integer;
  AResName: string;
  AHInstance: integer;
  AAppInstance: integer;
  AScriptInstance: integer;
begin
  (*Idx := -1;
  if Assigned(FOnGetImageIndex) then
    FOnGetImageIndex(ABlockID, Idx);
  if Assigned(Images) and (Idx >= 0) and (Idx < Images.Count) then
  begin
    with ABtn.Glyph do
    begin
      Width := Images.Width;
      Height := Images.Height;
      Canvas.Brush.Color := clFuchsia;//! for lack of a better color
      Canvas.FillRect(Rect(0,0, Width, Height));
      Images.Draw(Canvas, 0, 0, Idx);
    end;
  end else*)
  if AClass <> nil then
  begin
    AHInstance := FindClassHInstance(AClass);
    AScriptInstance := FindClassHInstance(TIDEPaletteToolbar);
    AAppInstance := FindHInstance(Application.MainForm);

    AResName := Uppercase(AClass.ClassName);
    {$WARNINGS OFF}
    if FindResource(AHInstance, PChar(AResName), RT_BITMAP) <> 0 then
    begin
    {$WARNINGS ON}
      ABtn.Glyph.LoadFromResourceName(AHInstance, AResName);
    end
    else
    if FindResource(AScriptInstance, PChar(AResName), RT_BITMAP) <> 0 then
    begin
    {$WARNINGS ON}
      ABtn.Glyph.LoadFromResourceName(AScriptInstance, AResName);
    end
    else
    if FindResource(AAppInstance, PChar(AResName), RT_BITMAP) <> 0 then
    begin
    {$WARNINGS ON}
      ABtn.Glyph.LoadFromResourceName(AAppInstance, AResName);
    end
    else
      {$WARNINGS OFF}
      if FindResource(AHInstance, PChar('TCOMPONENT'), RT_BITMAP) <> 0 then
        ABtn.Glyph.LoadFromResourceName(AHInstance, 'TCOMPONENT');
      {$WARNINGS ON}
  end else
  begin
    AHInstance := FindClassHInstance(TIDEPaletteToolbar);
    {$WARNINGS OFF}
    if FindResource(AHInstance, PChar('EDITMODE'), RT_BITMAP) <> 0 then
      ABtn.Glyph.LoadFromResourceName(AHInstance, 'EDITMODE');
    {$WARNINGS ON}
  end;
  if ABtn.Glyph.Width > ABtn.Glyph.Height then
    ABtn.NumGlyphs := 2
  else
    ABtn.NumGlyphs := 1;
end;

procedure TIDEPaletteToolbar.CancelPlacementClick(Sender: TObject);
begin
  if GetDesigner <> nil then with GetDesigner do
  begin
    if Active then
      CancelPlacing;
  end;
end;

procedure TIDEPaletteToolbar.ButtonClick(Sender: TObject);
begin
  if GetDesigner <> nil then with GetDesigner do
  begin
    if Active then
    begin
      PlaceComponentClass(TPaletteButton(Sender).FClass);
    end;
  end;
end;

(*procedure TIDEPaletteToolbar.SetDesignControl(
  const Value: TIDEFormDesignControl);
begin
  if FDesignControl <> Value then
  begin
    if FDesignControl <> nil then
      FDesignControl.RemoveFreeNotification(Self);
    FDesignControl := Value;
    if FDesignControl <> nil then
      FDesignControl.FreeNotification(Self);
  end;
end;*)

procedure TIDEPaletteToolbar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if (AComponent = FEngine) then
      Engine := nil;
  end;
end;


function TIDEPaletteToolbar.GetDesigner: TIDEFormDesigner;
begin
  result := nil;
  if (FEngine <> nil) then
    result := FEngine.Designer;
end;

procedure TIDEPaletteToolbar.CreateWnd;
begin
  inherited;
  UpdatePalette;
end;

procedure TIDEPaletteToolbar.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.PaletteToolbar := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.PaletteToolbar := Self;
      FEngine.FreeNotification(Self);
    end;
    UpdatePalette;
  end;
end;

procedure TIDEPaletteToolbar.InitiateAction;
var
  c: integer;
  Btn: TPaletteButton;
begin
  if (GetDesigner <> nil) and (FPanel <> nil) then
  begin
    for c := 0 to FPanel.ControlCount - 1 do
      if FPanel.Controls[c] is TPaletteButton then
      begin
        Btn := TPaletteButton(FPanel.Controls[c]);
        if Btn.FClass <> nil then
        begin
          Btn.Down := (GetDesigner.PlacedComponentClass <> nil) and (Btn.FClass = GetDesigner.PlacedComponentClass);
        end
        else
        begin
          {if Fclass is nil, then it's the cancel placing button}
          Btn.Down := (GetDesigner.PlacedComponentClass = nil);
        end;
      end;
  end;
end;

{ TIDEFormDesigner }

constructor TIDEFormDesigner.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TIDEFormDesigner.Destroy;
begin
  Engine := nil;
  inherited;
end;

procedure TIDEFormDesigner.DoChange;
begin
  inherited;
  if IDEEngine <> nil then
    IDEEngine.DesignerChange; 
end;

procedure TIDEFormDesigner.DoControlDblClick(AControl: TControl);
var
  AComp: TComponent;
  AEditor: TIDEComponentEditor;
begin
  inherited;
  if (IDEEngine <> nil) then
  begin
    if AControl is TComponentContainer then
      AComp := TComponentContainer(AControl).Component
    else
      AComp := AControl;

    AEditor := GetIDEComponentEditor(AComp);
    if (AEditor = nil) or not AEditor.HasEditor then
      IDEEngine.DesignerComponentDblClicked(AComp);
  end;
end;

procedure TIDEFormDesigner.DoBeforePlaceComponent(AComponent: TComponent);
begin
  inherited;
  if (IDEEngine <> nil) then
    IDEEngine.ComponentPlaced(AComponent);
end;

procedure TIDEFormDesigner.DoSelectionChange;
begin
  inherited;
  if UpdatingSelection = 0 then
  begin
    if IDEEngine <> nil then
      IDEEngine.DesignerSelectionChange;
  end;
end;

function TIDEFormDesigner.IDEEngine: TIDEEngine;
begin
  result := FEngine;
  if (result = nil) and (FDesignControl <> nil) then
    result := FDesignControl.FEngine;
end;

procedure TIDEFormDesigner.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

procedure TIDEFormDesigner.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.FormDesigner := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.FormDesigner := Self;
      FEngine.FreeNotification(Self);
    end;
  end;
end;

procedure TIDEFormDesigner.Update;
begin
  inherited;
end;

procedure TIDEFormDesigner.LoadFromString(AContent: string;
  DFMFormat: TDFMFormat);
var
  SS: TStringStream;
begin
  SS := TStringStream.Create(AContent);
  try
    SS.Position := 0;
    LoadFromStream(SS, DFMFormat);
  finally
    SS.Free;
  end;
end;

function TIDEFormDesigner.SaveToString(DFMFormat: TDFMFormat): string;
var
  SS: TStringStream;
begin
  result := '';
  SS := TStringStream.Create(result);
  try
    SaveToStream(SS, DFMFormat);
    SS.Position := 0;
    result := SS.DataString;
  finally
    SS.Free;
  end;
end;

{ TIDEInspector }

function TIDEInspector.CallEditor(TheIndex: Integer): Boolean;
var
  Prop: TProperty;
  ProcName: string;
  ALine: integer;
  AInfo: TatRoutineInfo;
  c: integer;
begin
  {Get the TProperty object}
  if ValidPropertyIndex(TheIndex) then
    Prop := Properties[TheIndex]
  else
    Prop := nil;

  {If all objects assigned and the property is an event...}
  if Assigned(Prop) and Assigned(FEngine) and Assigned(FEngine.Scripter) and (Prop.TypeKind=tkMethod) then
  begin
    {Get the current procedure name}
    ProcName := GetValue(TheIndex);

    {if procedure name is blank, then find the new name and set the property value}
    if (ProcName = '') and (Instance is TComponent) then
    begin
      ProcName := FEngine.Scripter.BuildEventHandlerName(TComponent(Instance), Prop.Name);
      SetValue(TheIndex, ProcName);
    end;

    {Ensure that the property is selected and updated. This is the case where CallEditor is called from double click,
     not from the property itself}
    ItemIndex := TheIndex;
    Update;

    {Declare the procedure in the source code, building the information about parameters}
    AInfo := TatRoutineInfo.Create(nil);
    try
      {convert information in Prop object to AInfo object}
      AInfo.Name := ProcName;
      AInfo.IsFunction := Prop.MethodKind <> mkProcedure;
      if AInfo.IsFunction then
        AInfo.ResultTypeDecl := Prop.ResultType;
      for c := 0 to Prop.ParamCount - 1 do
        with AInfo.Variables.Add do
        begin
          VarName := Prop.ParamNames[c];
          if pfVar in Prop.ParamFlags[c]  then
            Modifier := moVar
          else
            Modifier := moNone;
          TypeDecl := Prop.ParamTypes[c];
        end;

      {declare the procedure in source code}
      ALine := FEngine.DeclareProcedure(AInfo);
    finally
      AInfo.Free;
    end;

    {if editor is available, go to the produce}
    if ALine <> 0 then
      FEngine.ShowSourceEditor(2, ALine);
    result := true;
  end else
    result := inherited CallEditor(TheIndex);
end;

procedure TIDEInspector.Change(TheIndex: Integer);
begin                                                    
  inherited;
  if Assigned(FEngine) then
    FEngine.InspectorChange;
end;

destructor TIDEInspector.Destroy;
begin
  Engine := nil;
  inherited;
end;

procedure TIDEInspector.Filter(Prop: TProperty; var Result: Boolean);
var
  ValidEvent: boolean;
begin
  inherited Filter(Prop, Result);

  ValidEvent := false;
  if Assigned(FEngine) and Assigned(FEngine.FScripter) then
  begin
    ValidEvent := (Prop.TypeKind = tkMethod); {and
      (FEngine.FScripter.EventBroker.EventAdapters.FindAdapter(Prop.PropType) <> nil)};
  end;

  result := result and ((Mode = imProperties) or ValidEvent);
end;

function TIDEInspector.GetEditorClass(TheIndex: Integer): TPropertyEditorClass;
begin
  result := inherited GetEditorClass(TheIndex);
  if result = TMenuPropertyEditor then
    result := TMenuIDEPropertyEditor;
end;

function TIDEInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  result := inherited GetEnableExternalEditor(TheIndex);
  if ValidPropertyIndex(TheIndex) then
    with Properties[TheIndex] do
      result := result or ((TypeKind=tkMethod) and Assigned(FEngine) and Assigned(FEngine.FMemo) and Assigned(FEngine.FScripter));
end;

function TIDEInspector.GetPropertyValue(P: TProperty): string;
var
  SForm: TScriptForm;
  CompName: string;
begin
  if P.TypeKind = tkMethod then
  begin
    SForm := ScriptFormFromProp(P);
    if (SForm <> nil) and (P.Instance is TComponent) then
    begin
      if P.Instance = SForm then
        CompName := 'Self'
      else
        CompName := TComponent(P.Instance).Name; 
      result := SForm.SaveEvents.Values[Format('%s.%s', [CompName, P.Name])];
    end;
  end else
    result := inherited GetPropertyValue(P);
end;

procedure TIDEInspector.GetValuesList(TheIndex: Integer;
  const Strings: TStrings);
begin
  inherited GetValuesList(TheIndex,Strings);
  if ValidPropertyIndex(TheIndex) then
    with Properties[TheIndex] do
      if Assigned(Engine) and Assigned(Engine.ActiveScript) and (TypeKind=tkMethod) then
      begin
        {Ensure that the script is compiled}
        Engine.CheckCompiled;

        {Retrieve the names of procedures declared in script}
        Engine.ActiveScript.ScriptInfo.Routines.GetNames(Strings);

        {Exclude main routine name from procedure list}
        if Strings.IndexOf(Engine.ActiveScript.ScriptInfo.MainRoutineName) <> -1 then
          Strings.Delete(Strings.IndexOf(Engine.ActiveScript.ScriptInfo.MainRoutineName));
      end;
end;

procedure TIDEInspector.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

function TIDEInspector.ScriptFormFromProp(P: TProperty): TScriptForm;
begin
  result := nil;
  if Assigned(P.Instance) and (P.Instance is TComponent) then
  begin
    if P.Instance is TScriptForm then
      result := TScriptForm(P.Instance)
    else
    if Assigned(TComponent(P.Instance).Owner) and (TComponent(P.Instance).Owner is TScriptForm) then
      result := TScriptForm(TComponent(P.Instance).Owner)
  end;
end;

procedure TIDEInspector.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.Inspector := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.Inspector := Self;
      FEngine.FreeNotification(Self);
    end;
  end;
end;

procedure TIDEInspector.SetPropertyValue(P: TProperty; Value: string);
var
  SForm: TScriptForm;
  CompName: string;
  OldName: string;
  c: integer;
  S: string;
begin
  {If property is an event, then save the events in the SaveEvents property of TScriptForm
   for posterior loading purposes}
  if P.TypeKind = tkMethod then
  begin
    SForm := ScriptFormFromProp(P);
    if (SForm <> nil) and (P.Instance is TComponent) then
    begin
      if P.Instance = SForm then
        CompName := 'Self'
      else
        CompName := TComponent(P.Instance).Name;
      SForm.SaveEvents.Values[Format('%s.%s', [CompName, P.Name])] := Value;
    end;
  end else
  {If the name of a component is being replaced, then we must rename events, if any}
  if (UpperCase(P.Name) = 'NAME') and (P.Instance is TComponent) then
  begin
    {OldName and CompName is the old name and Value is the new name}
    OldName := TComponent(P.Instance).Name;
    SForm := ScriptFormFromProp(P);

    if SForm <> nil then
    begin
      {Change the event handlers, except in form because the name is always "Self"}
      if CompName <> 'SELF' then
      begin
        CompName := UpperCase(Value) + '.';

        {Iterate through all events and replace the name. Except in forms}
        for c := 0 to SForm.SaveEvents.Count - 1 do
        begin
          S := Uppercase(SForm.SaveEvents[c]);
          if Copy(S, 1, Length(OldName)) = Uppercase(OldName) then
            SForm.SaveEvents[c] := Value + Copy(SForm.SaveEvents[c], Length(OldName) + 1, MaxInt);
        end;
      end;

      {sets the Name property of component accordingly}
      inherited SetPropertyValue(P, Value);

      {if the form name was changed, notify the Engine so that source code can be changed}
      if (P.Instance = SForm) and (Engine <> nil) then
        Engine.FormNameChanged(SForm, OldName);
    end;
  end else
    inherited SetPropertyValue(P, Value);
end;

procedure TIDEInspector.Update;
begin
  inherited;
  if FEngine <> nil then
    FEngine.InspectorUpdate;
end;

function TIDEInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  result := inherited GetReadOnly(TheIndex);

  {Is script is running, force read-only to true. Otherwise, keep it as is}
  result := result or
    ((Engine <> nil) and (Engine.Scripter <> nil) and (Engine.Scripter.Running));
end;

{ TIDEComponenteComboBox }

procedure TIDEComponentComboBox.Change;
begin
  inherited;
  if (FEngine <> nil) then
    FEngine.ComboChanged;
end;

function TIDEComponentComboBox.Filter(AComponent: TComponent): Boolean;
begin
  result := inherited Filter(AComponent);
  result := result and not ((AComponent is TComponentContainer) or (AComponent is TAdvCustomFormDesigner));
end;

procedure TIDEComponentComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

procedure TIDEComponentComboBox.SetEngine(
  const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.ComponentCombo := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.ComponentCombo := Self;
      FEngine.FreeNotification(Self);
    end;
  end;
end;

function TIDEComponentComboBox.TranslateComponent(
  AComponent: TComponent): TComponent;
begin
  if AComponent is TComponentContainer then
    result := TComponentContainer(AComponent).Component
  else
    result := inherited TranslateComponent(AComponent);
end;

function TIDEInspector.ValidPropertyIndex(AIndex: integer): boolean;
begin
  result := (AIndex >= 0) and (AIndex < PropertyCount);
end;

{ TIDERegisteredCompss }

function TIDERegisteredComps.Add: TIDERegisteredComp;
begin
  result := TIDERegisteredComp(inherited Add);
end;

function TIDERegisteredComps.FindByClass(AClass: TClass): TIDERegisteredComp;
var
  c: integer;
begin
  result := nil;
  for c := 0 to Count - 1 do
   if Items[c].CompClass = AClass then
   begin
     result := Items[c];
     break;
   end;
end;

procedure TIDERegisteredComps.GetClassUnits(AClass: TClass;
  AUnits: TStrings);
var
  AComp: TIDERegisteredComp;
begin
  AComp := FindByClass(AClass);
  if AComp <> nil then
    AUnits.CommaText := AComp.Units;
end;

function TIDERegisteredComps.GetItem(Index: integer): TIDERegisteredComp;
begin
  result := TIDERegisteredComp(inherited Items[Index]);
end;

procedure TIDERegisteredComps.GetPageNames(AStrings: TStrings);
var
  c: integer;
begin
  AStrings.Clear;
  for c := 0 to Count - 1 do
    if AStrings.IndexOf(Items[c].Page) = -1 then
      AStrings.Add(Items[c].Page);
end;

{ TIDEEngine }

constructor TIDEEngine.Create(AOwner: TComponent);
begin
  inherited;
  RegisterClass(TScriptForm);

  FPascalStyler := TAdvPascalMemoStyler.Create(nil);
  FBasicStyler := TAdvBasicMemoStyler.Create(nil);
  FAutoStyler := true;
  FFileExtPascalUnit := '.psc';
  FFileExtBasicUnit := '.bsc';
  FFileExtForm := '.sfm';
  FOptions := TIDEEngineOptions.Create(Self);
  FNotifiers := TObjectList.Create(false);
  FIDEComps := TIDERegisteredComps.Create(Self, TIDERegisteredComp);
  FMemoTimer := TTimer.Create(nil);
  FMemoTimer.Interval := 1000;
  FMemoTimer.Enabled := false;
  FMemoTimer.OnTimer := MemoTimerEvent;
  FFiles := TIDEProjectFiles.Create(Self, TIDEProjectFile);
  FPreventDefaultEventCreation := false;
  RegisterScriptFormProps;
  RegisterStandardTab;
  RegisterAdditionalTab;
  RegisterWin32Tab;
  RegisterDialogsTab;
  NewProject;
end;

function GetScriptFormProp(AInstance: TPersistent; Prop: TProperty): string;
begin
  result := '';
  if AInstance is TScriptForm then
  begin
    With TScriptForm(AInstance) do
    begin
      if SaveProps.IndexOfName(Prop.FullName) > -1 then
      begin
        result := SaveProps.Values[Prop.FullName];
      end
      else
      begin
        Prop.SetEmulatedOff;
        result := Prop.GetStringValue;
        Prop.SetEmulatedOn;
      end;
    end;
  end;
end;

procedure SetScriptFormProp(AInstance: TPersistent; Prop: TProperty; Value: string);
begin
  if AInstance is TScriptForm then
  begin
    With TScriptForm(AInstance) do
    begin
      SaveProps.Values[Prop.FullName] := Value;

      {Set borderstyle property, just avoiding bsDialog}
      if (LowerCase(Prop.Name) = 'borderstyle') then
      begin
        Prop.SetEmulatedOff;
        if lowercase(Value) = 'bsdialog' then
          Prop.SetStringValue('bsSingle')
        else
          Prop.SetStringValue(Value);
        SendMessage(TScriptForm(AInstance).Handle, CM_RECREATEWND, 0, 0);
        Prop.SetEmulatedOn;
      end;
    end;
  end;
end;

procedure TIDEEngine.RegisterScriptFormProps;
begin
  RegisterCustomProperty(TScriptForm, 'Left'        , typeinfo(integer)         , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'Top'         , typeinfo(integer)         , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'WindowState' , typeinfo(TWindowState)    , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'Position'    , typeinfo(TPosition)       , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'Align'       , typeinfo(TAlign)          , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'AutoSize'    , typeinfo(boolean)         , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'Enabled'     , typeinfo(boolean)         , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'FormStyle'   , typeinfo(TFormStyle)      , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'KeyPreview'  , typeinfo(boolean)         , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'Visible'     , typeinfo(boolean)         , true, GetScriptFormProp, SetScriptFormProp);
//  RegisterCustomProperty(TScriptForm, 'BorderIcons' , typeinfo(TBorderIcons)    , true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'BorderStyle' , typeinfo(TFormBorderStyle), true, GetScriptFormProp, SetScriptFormProp);
  RegisterCustomProperty(TScriptForm, 'ActiveControl', TWinControl.ClassInfo, true, GetScriptFormProp, SetScriptFormProp);
end;

procedure TIDEEngine.DesignerChange;
begin
  if (Designer <> nil) then
  begin
    if not Designer.SynchroLocked then
    begin
      if FInspector <> nil then
        FInspector.Update;
    end;

    if ActiveFile <> nil then
    begin
      ActiveFile.FModified := true;
      ActiveFile.FMustUpdateScript := true;
    end;
  end;
end;

procedure TIDEEngine.DesignerSelectionChange;
var
  i: Integer;
  c: TControl;
begin
  if Designer <> nil then
  begin
    Inc(FLockDesigner);
    try
      if not Designer.SynchroLocked then
      begin
        if Assigned(FInspector) then
        begin
          FInspector.Root := Designer.ParentForm;
          case Designer.ControlCount of
            0: FInspector.Instance := Designer.ParentForm;
            1: FInspector.Instance := Designer.Component;
          else
            for i := 0 to Designer.ControlCount - 1 do
              if FInspector.IndexOfInstance(Designer.Components[i]) = -1 then
                FInspector.AddInstance(Designer.Components[i]);
            if FInspector.InstanceCount > 1 then
              FInspector.DeleteInstance(Designer.ParentForm);
            i := 0;
            while i < FInspector.InstanceCount do
            begin
              if FInspector.Instances[i] is TControl then
                C := TControl(FInspector.Instances[i])
              else
                C := Designer.FindComponentContainer(FInspector.Instances[i]);
              if Designer.ControlIndex(C) = -1 then
                FInspector.DeleteInstance(FInspector.Instances[i])
              else
                Inc(i);
            end;
          end;
        end;

        {notify the component combo}
        if Assigned(ComponentCombo) then
        begin
          if (Designer <> nil) then
          begin
            ComponentCombo.SynchroLock;
            try
              ComponentCombo.Root := Designer.ParentForm;
              case Designer.ControlCount of
                0: ComponentCombo.Instance := Designer.ParentForm;
                1: ComponentCombo.Instance := Designer.Component;
              else
                ComponentCombo.Instance := nil;
              end;
            finally
              ComponentCombo.SynchroUnlock;
            end;
          end;
        end;
      end;
      CleanSavedEvents;
    finally
      Dec(FLockDesigner);
    end;
  end;

  DoNotification(ntComponentSelected);
  if Assigned(FOnDesignerSelectionChanged) then
    FOnDesignerSelectionChanged(Self);
end;

procedure TIDEEngine.InspectorChange;
begin
  if Assigned(Designer) then
  begin
    Designer.Update;
    if Assigned(Designer.FDesignControl) then
      Designer.FDesignControl.UpdateFrame;
    if ActiveFile <> nil then
    begin
      ActiveFile.FModified := true;
      ActiveFile.FMustUpdateScript := true;
    end;
  end;
  DoNotification(ntInspectorChanged);
end;

procedure TIDEEngine.InspectorUpdate;
begin
  {notify the designer}
  if Assigned(Designer) and Assigned(FInspector) then
    if FLockDesigner = 0 then
    begin
      Designer.SynchroLock;
      Designer.Lock;
      try
        case FInspector.InstanceCount of
          0: Designer.Control := nil;
          1:
            if FInspector.Instance <> Designer.Control then
              if FInspector.Instance is TControl then
                Designer.Control := TControl(FInspector.Instance)
              else
                Designer.Component := FInspector.Instance;
        end;
      finally
        Designer.SynchroUnlock;
        Designer.Unlock;
      end;
    end;
end;

procedure TIDEEngine.SetComponentCombo(
  const Value: TIDEComponentComboBox);
begin
  if FComponentCombo <> Value then
  begin
    FComponentCombo := Value;
    if FComponentCombo <> nil then
      FComponentCombo.Engine := Self;
  end;
end;

procedure TIDEEngine.SetInspector(const Value: TIDEInspector);
begin
  if FInspector <> Value then
  begin
    FInspector := Value;
    if FInspector <> nil then
      FInspector.Engine := Self;
  end;
end;

procedure TIDEEngine.SetPaletteToolbar(const Value: TIDEPaletteToolbar);
begin
  if FPaletteToolbar <> Value then
  begin
    FPaletteToolbar := Value;
    if FPaletteToolbar <> nil then
      FPaletteToolbar.Engine := Self;
  end;
end;

procedure TIDEEngine.SetProjectName(const Value: string);
begin
  if FProjectName <> Value then
  begin
    FProjectName := Value;
    ProjNameChanged;
  end;
end;

{$IFDEF DELPHI9_LVL}
procedure TIDEEngine.SetPaletteButtons(const Value: TIDEPaletteButtons);
begin
  if FPaletteButtons <> Value then
  begin
    FPaletteButtons := Value;
    if FPaletteButtons <> nil then
      FPaletteButtons.Engine := Self;
  end;
end;
{$ENDIF}

procedure TIDEEngine.SetScripter(const Value: TIDEScripter);
begin
  if FScripter <> Value then
  begin
    FScripter := Value;
    if FScripter <> nil then
      FScripter.Engine := Self;
  end;
end;

procedure TIDEEngine.SetDesignControl(
  const Value: TIDEFormDesignControl);
begin
  if FDesignControl <> Value then
  begin
    if FDesignControl <> nil then
      FDesignControl.EditForm := nil;

    FDesignControl := Value;
    if FDesignControl <> nil then
      FDesignControl.Engine := Self;
  end;
end;

procedure TIDEEngine.SetFormDesigner(
  const Value: TIDEFormDesigner);
begin
  if FFormDesigner <> Value then
  begin
    FFormDesigner := Value;
    if FFormDesigner <> nil then
      FFormDesigner.Engine := Self;
  end;
end;

function TIDEEngine.GetDesigner: TIDEFormDesigner;
begin
  if Assigned(FDesignControl) then
    result := FDesignControl.FDesigner
  else
    result := FFormDesigner;
end;

procedure TIDEEngine.SetMemo(const Value: TIDEMemo);
begin
  if FMemo <> Value then
  begin
    FMemo := Value;
    if FMemo <> nil then
    begin
      FMemo.Engine := Self;
      UpdateMemoSource(false);
    end;
  end;
end;

procedure TIDEEngine.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  AFile: TIDEProjectFile;
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if AComponent = FInspector then
      FInspector := nil;
    if AComponent = FComponentCombo then
      FComponentCombo := nil;
    if AComponent = FScripter then
      FScripter := nil;
    if AComponent = FDesignControl then
      FDesignControl := nil;
    if AComponent = FFormDesigner then
      FFormDesigner := nil;
    if AComponent = FMemo then
      FMemo := nil;
    if AComponent is TScriptForm then
    begin
      AFile := FFiles.FindByForm(TScriptForm(AComponent));
      if AFile <> nil then
        AFile.SetForm(nil);
    end;
    if AComponent = FTabControl then
      TabControl := nil;
    if AComponent = FPaletteToolbar then
      FPaletteToolbar := nil;
    {$IFDEF DELPHI9_LVL}
    if AComponent = FPaletteButtons then
      FPaletteButtons := nil;
    {$ENDIF}
  end;
end;

procedure TIDEEngine.MemoChange;
begin
  if (Memo <> nil) and not FUpdatingMemo then
  begin
    if ActiveFile <> nil then
    begin
      ActiveFile.FModified := true;
      ActiveFile.FMustUpdateScript := true;
    end;
    Application.ProcessMessages;
    FMemoTimer.Enabled := false;
    FMemoTimer.Enabled := true;
  end;
end;

destructor TIDEEngine.Destroy;
begin
  FNotifiers.Free;
  FBasicStyler.Free;
  FPascalStyler.Free;

  {Finish compile thread}
  (*if FCompileThread <> nil then
  begin
    TerminateThread(FCompileThread.Handle, 0);
  end;
  FCompileThread := nil;*)

  {Call SetTabControl to restore old events}
  TabControl := nil;

  {free remaining objects}
  FFiles.Free;
  FMemoTimer.Free;
  FIDEComps.Free;
  FIDEComps := nil;

  FOptions.Free;
  inherited;
end;

function TIDEEngine.NewFormUnit(ALanguage: TScriptLanguage{; AMakeActive: boolean = true}): TIDEProjectFile;
begin
  result := NewUnit(ALanguage, false);
  if result <> nil then
  begin
    result.SetForm(CreateScriptForm);
    result.Form.DesignScript := result.Script;

    result.SetNewFormName;

    {Default source code for forms}
    BeginUpdateSourceCode;
    try
      Case result.ScriptLanguage of
        slPascal:
          with result.Script.SourceCode do
          begin
            Clear;
            Add('');
            {Add('uses');
            Add('  Classes, Graphics, Controls, Forms, Dialogs;');
            Add('');}
            Add('begin');
            Add('end;');
          end;
        slBasic:
          with result.Script.SourceCode do
          begin
            Clear;
            Add('');
            {Add('uses');
            Add('  Classes, Graphics, Controls, Forms, Dialogs');
            Add('');}
          end;
      end;
    finally
      EndUpdateSourceCode;
    end;

    result.UpdateFormHeader;

    result.ViewMode := vmForm;


    //if AMakeActive then
      Self.ActiveFile := result;

    result.Script.DesignFormResource := GetFormResource(result);
    result.Script.DesignScriptForm := result.Form;


    {WARNING: CheckUsedUnits only work if file is active, because the active designer is
    used to save the form and update designformresource in script object. Actually, if we
    create a form and does not make it active, this DesignFormResource will never get updated
    and we will not be able to compile it. That's why AMakeActive parameter was disabled for now}
    result.CheckUsedUnits;
  end;
end;

function TIDEEngine.NewUnit(ALanguage: TScriptLanguage; AMakeActive: boolean = true): TIDEProjectFile;
begin
  result := nil;
  if FScripter <> nil then
  begin
    result := FFiles.Add;
    result.Script := FScripter.AddScript(ALanguage);
    result.SetForm(nil);
    result.SetNewUnitName;
    result.FModified := false;
    result.FMustUpdateScript := true;
    result.ViewMode := vmUnit;

    //result.Visible := true;
    if AMakeActive then
      Self.ActiveFile := result;
  end;
end;
procedure TIDEEngine.SetActiveFile(AFile: TIDEProjectFile);
begin
  if FActiveFile <> AFile then
    ChangeActiveFile(AFile);                      
end;

procedure TIDEEngine.BeginRegisterComponents;
begin
  inc(FUpdatingComponents);
end;

procedure TIDEEngine.BeginUpdateSourceCode;
begin
  inc(FUpdatingScriptSource);
end;

procedure TIDEEngine.ChangeActiveFile(AFile: TIDEProjectFile);

  procedure DeactivateFormEditing;
  begin
    if (FDesignControl <> nil) then
      FDesignControl.EditForm := nil;
    DesignerSelectionChange;
    if (FInspector <> nil) then
      FInspector.Instance := nil;
  end;

begin
  {Before changing active file, update the modified file content to script}
  if (ActiveFile <> nil) then
  begin
//    if not (csDestroying in ActiveFile.ComponentState) then
    SaveMemoInfo(ActiveFile);

    {Maybe we should test for destroying for the code below too}
    if ActiveFile.FMustUpdateScript then
      UpdateScriptSource(true);
  end;

  {Now change active file}
  FActiveFile := AFile;

  if FActiveFile <> nil then
  begin
    if (Scripter <> nil) and not Scripter.Running then
      Scripter.CurrentScript := ActiveScript;

    {Update memo content with script source code}
    UpdateMemoSource(false);
    UpdateMemoBreakpoints;
    LoadMemoInfo(ActiveFile);

    {Change the form being edited}
    if (FActiveFile.Form <> nil) then
    begin
      if (FDesignControl <> nil) then
      begin
        FDesignControl.EditForm := FActiveFile.Form;
        DesignerSelectionChange;
      end;
    end else
    begin
      DeactivateFormEditing;
    end;

    FActiveFile.Visible := true;
  end else
    DeactivateFormEditing;

  {Update the selected tab, update the view mode (form or unit)}
  ViewModeChanged(FActiveFile);
  UpdateTabControl;
  if not (csDestroying in ComponentState) then
    DoActiveFileChanged;

  ShowExecutionPoint;
end;

procedure TIDEEngine.DoActiveFileChanged;
begin
  DoNotification(ntActiveFileChanged);
  if Assigned(FOnActiveFileChanged) then
    FOnActiveFileChanged(Self);
end;

procedure TIDEEngine.UpdateMemoSource(AKeepCursorPos: boolean);
var
  ARow, ACol: integer;
  ATopLine: integer;
begin
  if FMemo <> nil then
  begin
    if (ActiveScript <> nil) then
    begin
      FUpdatingMemo := true;
      FMemo.BeginUpdate;
      try
        {Save cursor position}
        ARow := FMemo.CurY;
        ACol := FMemo.CurX;
        ATopLine := FMemo.TopLine;

        FMemo.Lines.Text := ActiveScript.SourceCode.Text;

        if AKeepCursorPos then
        begin
          FMemo.TopLine := ATopLine;
          FMemo.CurY := ARow;
          FMemo.CurX := ACol;
        end;

        if FAutoStyler then
          Case ActiveFile.ScriptLanguage of
            slPascal: FMemo.SyntaxStyles := FPascalStyler;
            slBasic: FMemo.SyntaxStyles := FBasicStyler;
          end;
      finally
        FMemo.EndUpdate;
        FUpdatingMemo := false;
      end;
    end;
  end;
end;

function TIDEEngine.GetFormResource(AFile: TIDEProjectFile): string;
var
  //SS: TStringStream;
  ADesigner: TIDEFormDesigner;
  DestroyDesigner: boolean;
begin
  result := '';
  if (AFile <> nil) and (AFile.Form <> nil) then
  begin
    ADesigner := FindDesignerInForm(AFile.Form);
    DestroyDesigner := false;
    if ADesigner = nil then
    begin
      {Create a temporary designer component just to save the form}
      ADesigner := TIDEFormDesigner.Create(AFile.Form);
      DestroyDesigner := true;
    end;
    try
      result := ADesigner.SaveToString(dfmText);
    finally
      if DestroyDesigner then
        ADesigner.Free;
    end;
  end;


(*
  SS := TStringStream.Create('');
  try
    if (ActiveScript <> nil) then
    begin
      if (Designer <> nil) then
      begin
        Designer.SaveToStream(SS, dfmBinary);
        SS.Position := 0;
        result := SS.DataString;
      end else
      begin
        {Create a designer on the fly just to get form resource. Used in case designer is not available for
         some reason (loading, formdesigncontrol property not set, etc.}
        if ActiveFile.Form <> nil then
        begin
          ADesigner := TIDEFormDesigner.Create(ActiveFile.Form);
          try
            ADesigner.SaveToStream(SS, dfmBinary);
            SS.Position := 0;
            result := SS.DataString;
          finally
            ADesigner.Free;
          end;
        end;
      end;
    end;
  finally
    SS.Free;
  end;*)
end;

(*procedure TIDEEngine.UpdateScriptBreakPoints;
var
  c: integer;
begin
  {Set script breakpoints from memo}
  if (Memo <> nil) and (ActiveScript <> nil) then
  begin
    ActiveScript.VirtualMachine.BreakPoints.Clear;
    for c := 0 to Memo.Lines.Count - 1 do
      if Memo.BreakPoint[c] then
        ActiveScript.VirtualMachine.DebugToggleBreakLine(c + 1);
  end;
end;*)

procedure TIDEEngine.UpdateScriptSource(AvoidRecompile: boolean);
begin
  {Force update of script source code}
  if (ActiveScript <> nil) and not Scripter.Running then
  begin
    ActiveScript.UnitName := ActiveFile.UnitName;
    ActiveScript.DesignFormResource := GetFormResource(ActiveFile);
    ActiveScript.DesignScriptForm := ActiveFile.Form;

    if FMemo <> nil then
    begin
      BeginUpdateSourceCode;
      try
        ActiveScript.SourceCode.Text := FMemo.Lines.Text;
      finally
        EndUpdateSourceCode;
      end;

      //UpdateScriptBreakPoints;
    end else
      ActiveScript.Compiled := false;

    {No need to update script anymore}
    ActiveFile.FMustUpdateScript := false;
  end;

    ///WARNING: MUST WAIT COMPILATION BEFORE CHANGING SOURCE CODE

  if AvoidRecompile then
  begin
    (*

    {Clear all flags to avoid another compilation of memo}
    FMemoTimer.Enabled := false;
    FRecompile := false;
    *)
  end;
end;

procedure TIDEEngine.FormNameChanged(AForm: TScriptForm; AOldName: string);
var
  AFile: TIDEProjectFile;
  S: string;
begin
  AFile := FFiles.FindByForm(AForm);
  if (AFile <> nil) then
  begin
    {Update the form name in source code}
    if (AFile = ActiveFile) and (AFile.FMustUpdateScript) then
      UpdateScriptSource(false);

    AFile.UpdateFormHeader;

    if (AFile = ActiveFile) then
      UpdateMemoSource(true);

    {Now if this form was referenced in mainunit, then change the form class name.
     Uses a "space" before the search string as a simple algorithm to use whole word search}
    if (MainUnit <> nil) then
    begin
      if (ActiveFile = MainUnit) and ActiveFile.FMustUpdateScript then
        UpdateScriptSource(false);

      S := MainUnit.Script.SourceCode.Text;
      S := StringReplace(S, ' T' + AOldName, ' ' + AFile.FormClassName, [rfReplaceAll, rfIgnoreCase]);
      BeginUpdateSourceCode;
      try
        MainUnit.Script.SourceCode.Text := S;
      finally
        EndUpdateSourceCode;
      end;

      if ActiveFile = MainUnit then
        UpdateMemoSource(true);
    end;
  end;
end;

procedure TIDEEngine.MemoTimerEvent(Sender: TObject);
begin
  (* COMPILATION IS NOT THREAD SAFE FOR NOW, WE CAN'T USE THIS... *)

  (*

  {if there is a request for recompilation but the compilethread is not finished yet,
   then wait for the next timer event, until the thread is finished}
  if FRecompile and (FCompileThread <> nil) then
    Exit;

  FMemoTimer.Enabled := false;

  if FScripter <> nil then
  begin
    {if there is not a thread running, then run the thread to compile}
    if (FCompileThread = nil) and (Scripter <> nil) and not Scripter.Running then
    begin
      {Copy source code from memo to script}
      UpdateScriptSource(false);

      {Clear script}
      if (ActiveScript <> nil) then
        ActiveScript.Clear;

      {Only compile if there is a valid activefile}
      if FActiveFile <> nil then
      begin
        FRecompile := false;
        FCompiling := true;

        FCompileThread := TCompileThread.Create(self);
        FCompileThread.OnTerminate := CompilationFinished;
        if FCompileThread.Suspended then
          FCompileThread.Resume;
      end;
    end else
    begin
      {if the thread is running, then wait for the thread to finish and then recompile}
      FRecompile := true;
    end;
  end;

  *)
end;

(*procedure TIDEEngine.CompilationFinished(Sender: TObject);
begin
  Application.ProcessMessages;
  if FRecompile then
    FMemoTimer.Enabled := true;
end;*)

procedure TIDEEngine.CheckCompiled;
begin
  (* REMOVE THIS THREAD-BASED CODE. WE WILL USE NON-THREAD CODE BELOW *)
  (*
  if (Scripter <> nil) and not Scripter.Running then
  begin
    {if Scripter.Running then
      Abort;}

    if (ActiveScript <> nil) then
    begin
      if FCompiling then
        repeat until not FCompiling
      else
      begin
        if not ActiveScript.SilentCompiled then
        begin
          MemoTimerEvent(nil);
          repeat until not FCompiling;
        end;
      end;
    end;
  end;*)

  (* NON-THREAD CODE *)
  if (Scripter <> nil) and not Scripter.Running and (ActiveScript <> nil) then
  begin
    if ActiveFile.FMustUpdateScript then
      UpdateScriptSource(true);
    if not ActiveScript.SilentCompiled then
      ActiveScript.SilentCompile;
  end;
end;

procedure TIDEEngine.SaveFile(AFile: TIDEProjectFile);
var
  AFileContent: string;
  Handled: boolean;
  ADesigner: TIDEFormDesigner;
  DestroyDesigner: boolean;
begin
  if (AFile = ActiveFile) and (AFile.FMustUpdateScript) then
    UpdateScriptSource(false);

  if (AFile <> nil) and (AFile.Script <> nil) then
  begin
    {Ensure all used units are correct}
    AFile.CheckUsedUnits;

    {if scripter is running, then we must save directly from memo, because script source
     was not updated. It is no problem after all, because memo can't be changed while script
     is running, but we do that just to be sure}
    if (Scripter <> nil) and Scripter.Running then
    begin
      if Memo <> nil then
        AFileContent := Memo.Lines.Text;
    end else
      AFileContent := AFile.Script.SourceCode.Text;
    Handled := false;
    if Assigned(FOnSaveFile) then
      FOnSaveFile(Self, iftScript, AFile.GetFullFileName, AFileContent, AFile, Handled);
    if not Handled then
      SaveStringToFile(AFile.GetFullFileName, AFileContent);

    {Save the form to file}
    if (AFile.Form <> nil) then
    begin
      ADesigner := FindDesignerInForm(AFile.Form);
      DestroyDesigner := false;
      if ADesigner = nil then
      begin
        {Create a temporary designer component just to save the form}
        ADesigner := TIDEFormDesigner.Create(AFile.Form);
        DestroyDesigner := true;
      end;
      try
        AFileContent := ADesigner.SaveToString(dfmText);
      finally
        if DestroyDesigner then
          ADesigner.Free;
      end;
      Handled := false;
      if Assigned(FOnSaveFile) then
        FOnSaveFile(Self, iftForm, AFile.FullFormFileName, AFileContent, AFile, Handled);
      if not Handled then
        SaveStringToFile(AFile.FullFormFileName, AFileContent);
    end;

    {if the file was not saved yet, it means it was not added to the project.
     So, before setting FSaved to true, we must check if it is false. If yes, then
     it means that the project is modified and must be saved later.}
    if not AFile.FSaved then
      FProjectModified := true;
    AFile.FSaved := true;
    AFile.FModified := false;
  end;
end;

procedure TIDEEngine.LoadFile(AFile: TIDEProjectFile; AMakeActive: boolean = true);
var
  AFileContent: string;
  Handled: boolean;
  ADesigner: TIDEFormDesigner;
  DestroyDesigner: boolean;
begin
  {Create a script if it does not exist}
  if (AFile.Script = nil) and (FScripter <> nil) then
    AFile.Script := FScripter.AddScript(AFile.FTempScriptLang);

  {Load file content. Provide flexibility for loading file from any place (blobs, etc.)
   using FOnLoadFile event}
  BeginUpdateSourceCode;
  try
    Handled := false;
    if Assigned(FOnLoadFile) then
    begin
      AFileContent := '';
      FOnLoadFile(Self, iftScript, AFile.GetFullFileName, AFileContent, AFile, Handled);
      if Handled then
        AFile.Script.SourceCode.Text := AFileContent;
    end;
    if not Handled then
      AFile.Script.SourceCode.LoadFromFile(AFile.GetFullFileName);

    AFile.Script.UnitName := AFile.UnitName;
  finally
    EndUpdateSourceCode;
  end;

  {Check if the file is a form. If it is, then load a unit, else load a form}
  if IsValidFile(iftForm, AFile.FullFormFileName) then
  begin
    if AFile.Form = nil then
      AFile.SetForm(CreateScriptForm);
    AFile.Form.DesignScript := AFile.Script;

     {We must set ActiveFile before loading the form, in order to have the Designer set to
     the correct form}
    if AMakeActive then
      ChangeActiveFile(AFile);

    {Now load the form. Also here, there is flexibility to load from everyplace}
    ADesigner := FindDesignerInForm(AFile.Form);
    DestroyDesigner := false;
    if ADesigner = nil then
    begin
      ADesigner := TIDEFormDesigner.Create(AFile.Form);
      DestroyDesigner := true;
    end;
    try
      Handled := false;
      if Assigned(FOnLoadFile) then
      begin
        AFileContent := '';
        FOnLoadFile(Self, iftForm, AFile.FullFormFileName, AFileContent, AFile, Handled);
        if Handled then
          ADesigner.LoadFromString(AFileContent, dfmText);
      end;
      if not Handled then
        ADesigner.LoadFromDFM(AFile.FullFormFileName, dfmText);
    finally
      if DestroyDesigner then
        ADesigner.Free;
    end;

    {If it's a form, then make the form visible}
    AFile.ViewMode := vmForm;

    {Notify changes to make sure that everything is updated, if the file is active}
    if AFile = ActiveFile then
    begin
      DesignerChange;
      InspectorChange;
    end;
  end;

  {Make the file active}
  if AMakeActive then
    ActiveFile := AFile;

  AFile.FSaved := true;
  AFile.FModified := false;
  //AFile.FMustUpdateScript := false --> This statement is not needed because UpdateScriptSource already does that
  UpdateScriptSource(false);
end;

function TIDEEngine.DeclareProcedure(AInfo: TatRoutineInfo): integer;
begin
  result := 0;

  {Ensure that there current script is silent compiled so we can retrieve information for it}

  if (ActiveScript <> nil) and (Scripter <> nil) and not Scripter.Running then
  begin
    CheckCompiled;

    {Update the source code from memo to script}
    if ActiveFile.FMustUpdateScript then
      UpdateScriptSource(false);

    {Declare the procedure, if it does not exist}
    result := ActiveScript.Refactor.DeclareRoutine(AInfo);

    {now that script source code has changed, update memo content}
    UpdateMemoSource(true);
  end;
end;

procedure TIDEEngine.ShowFormEditor;
begin
  if FDesignControl <> nil then
  begin
    FDesignControl.BringToFront;
    if CanFocusControl(FDesignControl) then
      FDesignControl.SetFocus;
    if FActiveFile <> nil then
      FActiveFile.FViewMode := vmForm;
  end;
  DoOnViewModeChanged;
end;

procedure TIDEEngine.ShowSourceEditor(Col: integer = -1; Row: integer = -1);
begin
  if Assigned(FOnShowSourceEditor) then
    FOnShowSourceEditor(Self, Col, Row)
  else
  begin
    if FMemo <> nil then
    begin
      if (Col > -1) or (Row > -1) then
        FMemo.SetCursor(Col, Row);
      FMemo.InsertTemplate('');
      FMemo.BringToFront;
      if CanFocusControl(FMemo) then
        FMemo.SetFocus;
    end;
    if FActiveFile <> nil then
      FActiveFile.FViewMode := vmUnit; 
  end;
  DoOnViewModeChanged;
end;

procedure TIDEEngine.SetTabControl(const Value: TControl);
begin
  if FTabControl <> Value then
  begin
    {Check if the control is one of the supported controls}
    if (TabControlType(Value) <> tctNone) or (Value = nil) then
    begin
      if FTabControl <> nil then
      begin
        FTabControl.RemoveFreeNotification(Self);
        case TabControlType(FTabControl) of
          tctTabControl:
        TTabControl(FTabControl).OnChange := FOldTabChange;
          {$IFDEF THEMED_IDE}
          tctOfficeTabSet:
            TAdvOfficeTabSet(FTabControl).OnChange := FOldTabChange;
          {$ENDIF}
        end;
      end;

      FTabControl := Value;

      if FTabControl <> nil then
      begin
        FTabControl.FreeNotification(Self);
        case TabControlType(FTabControl) of
          tctTabControl:
            begin
              FOldTabChange := TTabControl(FTabControl).OnChange;
              TTabControl(FTabControl).OnChange := TabChange;
            end;
          {$IFDEF THEMED_IDE}
          tctOfficeTabSet:
            begin
              FOldTabChange := TAdvOfficeTabSet(FTabControl).OnChange;
              TAdvOfficeTabSet(FTabControl).OnChange := TabChange;
            end;
          {$ENDIF}
        end;
        UpdateTabControl;
      end;
    end;
  end;
end;

procedure TIDEEngine.FileVisibleChanged(AFile: TIDEProjectFile);
begin
  {If the currently active file was set to visible false, then find the next active file}
  if (ActiveFile = AFile) and not AFile.Visible then
    ForceActiveFile(AFile.Index);

  UpdateTabControl;
end;

function TIDEEngine.FindDesignerInForm(AForm: TCustomForm): TIDEFormDesigner;
var
  c: integer;
begin
  result := nil;
  for c := 0 to AForm.ComponentCount - 1 do
    if AForm.Components[c] is TIDEFormDesigner then
    begin
      result := TIDEFormDesigner(AForm.Components[c]);
      break;
    end;
end;

procedure TIDEEngine.ChangeTabName(ANewName, AOldName: string);

  procedure ChangeTCTabName(TC: TTabControl);
  var
    i: integer;
  begin
    i := TC.Tabs.IndexOf(AOldName);
    if i > -1 then
      TC.Tabs[i] := ANewName;
  end;

  {$IFDEF THEMED_IDE}
  procedure ChangeOTSTabName(OTS: TAdvOfficeTabSet);
  var
    i: integer;
  begin
    for i := 0 to OTS.AdvOfficeTabs.Count - 1 do
      if SameText(OTS.AdvOfficeTabs[i].Caption, AOldName) then
      begin
        OTS.AdvOfficeTabs[i].Caption := ANewName;
        break;
      end;
  end;
  {$ENDIF}

begin
  if (ANewName <> '') and (AOldName <> '') then
    case TabControlType(FTabControl) of
      tctTabControl:
      ChangeTCTabName(TTabControl(FTabControl));
      {$IFDEF THEMED_IDE}
      tctOfficeTabSet:
        ChangeOTSTabName(TAdvOfficeTabSet(FTabControl));
      {$ENDIF}
    end;
end;

procedure TIDEEngine.UpdateTabControl;

  procedure UpdateTabControlTabs;
  var
    c: integer;
    TabCtrl: TTabControl;
    //OldTabIndex: integer;
    AFile: TIDEProjectFile;
  begin
    TabCtrl := TTabControl(FTabControl);
    //OldTabIndex := TabCtrl.TabIndex;

    {To avoid flickering, do it in two steps: first remove the invisible tabs}
    c := 0;
    while c < TabCtrl.Tabs.Count do
    begin
      AFile := FFiles.FindByUnitName(TabCtrl.Tabs[c]);
      if (AFile = nil) or not (AFile.Visible) then
        TabCtrl.Tabs.Delete(c)
      else
        inc(c);
    end;

    {Now include the new ones at the end of tab}
    for c := 0 to FFiles.Count - 1 do
    begin
      if Files[c].Visible and (TabCtrl.Tabs.IndexOf(Files[c].UnitName) = -1) then
        TabCtrl.Tabs.Add(Files[c].UnitName);
    end;

    {Select the tab accordingly to the active file}
    if FActiveFile <> nil then
    begin
      Inc(FUpdatingTab);
      try
        TabCtrl.TabIndex := TabCtrl.Tabs.IndexOf(FActiveFile.UnitName);
      finally
        Dec(FUpdatingTab);
      end;
    end;

    {Make tab invisible if AutoHideTabControl is true}
    if FOptions.AutoHideTabControl then
    begin
      TabCtrl.Visible := (TabCtrl.Tabs.Count > 0);
    end;
  end;

  {$IFDEF THEMED_IDE}
  procedure UpdateOfficeTabSetTabs;
  var
    c: integer;
    TabCtrl: TAdvOfficeTabSet;
    //OldTabIndex: integer;
    AFile: TIDEProjectFile;

    function FindOfficeTab(ACaption: string): TOfficeTabCollectionItem;
    var
      i: integer;
    begin
      result := nil;
      for i := 0 to TabCtrl.AdvOfficeTabs.Count - 1 do
        if SameText(ACaption, TabCtrl.AdvOfficeTabs[i].Caption) then
        begin
          result := TabCtrl.AdvOfficeTabs[i];
          break;
        end;
    end;


  begin
    TabCtrl := TAdvOfficeTabSet(FTabControl);

    {To avoid flickering, do it in two steps: first remove the invisible tabs}
    c := 0;
    while c < TabCtrl.AdvOfficeTabs.Count do
    begin
      AFile := FFiles.FindByUnitName(TabCtrl.AdvOfficeTabs[c].Caption);
      if (AFile = nil) or not (AFile.Visible) then
      begin
        Inc(FUpdatingTab);
        try
          TabCtrl.AdvOfficeTabs.Delete(c);
        finally
          Dec(FUpdatingTab);
        end;
      end
      else
        inc(c);
    end;

    {Now include the new ones at the end of tab}
    for c := 0 to FFiles.Count - 1 do
    begin
      if Files[c].Visible and (FindOfficeTab(Files[c].UnitName) = nil) then
        TabCtrl.AdvOfficeTabs.Add.Caption := Files[c].UnitName;
    end;

    {Select the tab accordingly to the active file}
    if FActiveFile <> nil then
    begin
      Inc(FUpdatingTab);
      try
        if FindOfficeTab(FActiveFile.UnitName) <> nil then
          TabCtrl.ActiveTabIndex := FindOfficeTab(FActiveFile.UnitName).Index;
      finally
        Dec(FUpdatingTab);
      end;
    end;

    {Make tab invisible if AutoHideTabControl is true}
    if FOptions.AutoHideTabControl then
    begin
      TabCtrl.Visible := (TabCtrl.AdvOfficeTabs.Count > 0);
      for c := 0 to TabCtrl.Parent.ControlCount - 1 do
        TabCtrl.Parent.Controls[c].Visible := Tabctrl.Visible;
    end;
  end;
  {$ENDIF}

begin
  {Update visible tabs}
  if not (csDestroying in ComponentState) then
  begin
    case TabControlType(FTabControl) of
      tctTabControl:
      UpdateTabControlTabs;
      {$IFDEF THEMED_IDE}
      tctOfficeTabSet:
        UpdateOfficeTabSetTabs;
      {$ENDIF}
    end;
  end;
end;

procedure TIDEEngine.RegisterComponent(APage: string;
  ACompClass: TComponentClass; AUsedUnits: string);
begin
  with FIDEComps.Add do
  begin
    Page := APage;
    CompClass := ACompClass;
    Units := AUsedUnits;
  end;
  if FUpdatingComponents = 0 then
  begin
    {$IFDEF DELPHI9_LVL}
    if PaletteButtons <> nil then
      PaletteButtons.Populate;
    {$ENDIF}
    if PaletteToolbar <> nil then
      PaletteToolbar.UpdatePalette;
  end;
end;

procedure TIDEEngine.TabChange(Sender: TObject);
var
  S: string;
  AFile: TIDEProjectFile;
begin
  if FUpdatingTab = 0 then
  begin
    S := '';
    case TabControlType(FTabControl) of
      tctTabControl:
        begin
          With TTabControl(FTabControl) do
            if TabIndex >= 0 then
              S := Tabs[TabIndex];
        end;
      {$IFDEF THEMED_IDE}
      tctOfficeTabSet:
        begin
          With TAdvOfficeTabSet(FTabControl) do
            if ActiveTabIndex >= 0 then
              S := AdvOfficeTabs[ActiveTabIndex].Caption;
        end;
      {$ENDIF}
    end;

    if S > '' then
    begin
      AFile := FFiles.FindByUnitName(S);
      if AFile <> nil then
        ActiveFile := AFile;
    end;
  end;
end;

function TIDEEngine.TabControlType(AControl: TControl): TTabControlType;
begin
  result := tctNone;
  {$IFDEF THEMED_IDE}
  if AControl is TAdvOfficeTabSet then
    result := tctOfficeTabSet
  else
  {$ENDIF}
  if AControl is TTabControl then
    result := tctTabControl;
end;

procedure TIDEEngine.SetOptions(const Value: TIDEEngineOptions);
begin
  FOptions.Assign(Value);
end;

procedure TIDEEngine.RegisterStandardTab;
begin
  BeginRegisterComponents;
  try
    RegisterComponent('Standard',       TMainMenu,          'Menus');
    RegisterComponent('Standard',       TPopupMenu,         'Menus');
    RegisterComponent('Standard',       TLabel,             'StdCtrls');
    RegisterComponent('Standard',       TEdit,              'StdCtrls');
    RegisterComponent('Standard',       TMemo,              'StdCtrls');
    RegisterComponent('Standard',       TButton,            'StdCtrls');
    RegisterComponent('Standard',       TCheckBox,          'StdCtrls');
    RegisterComponent('Standard',       TRadioButton,       'StdCtrls');
    RegisterComponent('Standard',       TListBox,           'StdCtrls');
    RegisterComponent('Standard',       TComboBox,          'StdCtrls');
    RegisterComponent('Standard',       TGroupBox,          'StdCtrls');
    RegisterComponent('Standard',       TPanel,             'ExtCtrls,StdCtrls');
    RegisterComponent('Standard',       TRadioGroup,        'ExtCtrls,StdCtrls');
  finally
    EndRegisterComponents;
  end;
end;

procedure TIDEEngine.RegisterAdditionalTab;
begin
  BeginRegisterComponents;
  try
    RegisterComponent('Additional',     TBitBtn,            'Buttons,ExtCtrls,StdCtrls');
    RegisterComponent('Additional',     TSpeedButton,       'Buttons,ExtCtrls,StdCtrls');
    RegisterComponent('Additional',     TMaskEdit,          'Mask,StdCtrls');
    //RegisterComponent('Additional',     TStringGrid,        'Grids,StdCtrls');
    RegisterComponent('Additional',     TImage,             'ExtCtrls,StdCtrls');
    RegisterComponent('Additional',     TShape,             'ExtCtrls,StdCtrls');
    RegisterComponent('Additional',     TBevel,             'ExtCtrls,StdCtrls');
    RegisterComponent('Additional',     TStaticText,        'StdCtrls,StdCtrls');
    RegisterComponent('Additional',     TSplitter,          'ExtCtrls,StdCtrls');
  finally
    EndRegisterComponents;
  end;
end;

procedure TIDEEngine.RegisterWin32Tab;
begin
  BeginRegisterComponents;
  try
    RegisterComponent('Win32',          TTabControl,        'ComCtrls,ExtCtrls,StdCtrls');
    RegisterComponent('Win32',          TPageControl,       'ComCtrls,ExtCtrls,StdCtrls');
    RegisterClass(TTabSheet);
    RegisterComponent('Win32',          TImageList,         'ImgList'); 
    RegisterComponent('Win32',          TProgressBar,       'ComCtrls,ExtCtrls,StdCtrls');
    RegisterComponent('Win32',          TTreeView,          'ComCtrls,ExtCtrls,StdCtrls');
    RegisterComponent('Win32',          TListView,          'ComCtrls,ExtCtrls,StdCtrls');
    RegisterComponent('Win32',          TDateTimePicker,    'ComCtrls,ExtCtrls,StdCtrls');
  finally
    EndRegisterComponents;
  end;
end;

(*procedure TIDEngine.RegisterDataAccessTab;
begin
  IDEEngine1.RegisterComponent('Data Access',    TDatasource,        'DB');
  IDEEngine1.RegisterComponent('Data Access',    TTable,             'DBTables,DB');
  IDEEngine1.RegisterComponent('Data Access',    TDatabase,          'DBTables,DB');
  IDEEngine1.RegisterComponent('Data Access',    TQuery,             'DBTables,DB');
  IDEEngine1.RegisterComponent('Data Controls',  TDBGrid,            'DBGrids,StdCtrls,Grids,DBCtrls');
  IDEEngine1.RegisterComponent('Data Controls',  TDBNavigator,       'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
  IDEEngine1.RegisterComponent('Data Controls',  TDBText,            'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
  IDEEngine1.RegisterComponent('Data Controls',  TDBEdit,            'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
  IDEEngine1.RegisterComponent('Data Controls',  TDBMemo,            'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
  IDEEngine1.RegisterComponent('Data Controls',  TDBListBox,         'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
  IDEEngine1.RegisterComponent('Data Controls',  TDBCheckBox,        'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
  IDEEngine1.RegisterComponent('Data Controls',  TDBRadioGroup,      'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
  IDEEngine1.RegisterComponent('Data Controls',  TDBLookupListBox,   'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
  IDEEngine1.RegisterComponent('Data Controls',  TDBLookupComboBox,  'DBCtrls,ComCtrls,StdCtrls,ExtCtrls,Buttons');
end;*)

procedure TIDEEngine.RegisterDialogsTab;
begin
  BeginRegisterComponents;
  try
    RegisterComponent('Dialogs',        TOpenDialog,        'Dialogs,StdCtrls');
    RegisterComponent('Dialogs',        TSaveDialog,        'Dialogs,StdCtrls');
    RegisterComponent('Dialogs',        TFontDialog,        'Dialogs,StdCtrls');
    RegisterComponent('Dialogs',        TColorDialog,       'Dialogs,StdCtrls');
    RegisterComponent('Dialogs',        TPrintDialog,       'Dialogs,StdCtrls');
    RegisterComponent('Dialogs',        TPrinterSetupDialog,'Dialogs,StdCtrls');
  finally
    EndRegisterComponents;
  end;
end;

procedure TIDEEngine.UnregisterComponent(ACompClass: TComponentClass);
var
  Comp: TIDERegisteredComp;
begin
  Comp := FIDEComps.FindByClass(ACompClass);
  while Comp <> nil do
  begin
    Comp.Free;
    Comp := FIDEComps.FindByClass(ACompClass);
  end;
end;

procedure TIDEEngine.UnregisterComponent(AClassName: string);
var
  AClass: TClass;
begin
  AClass := FindClass(AClassName);
  if (AClass <> nil) and AClass.InheritsFrom(TComponent) then
    UnregisterComponent(TComponentClass(AClass));
end;

procedure TIDEEngine.UnregisterTab(APage: string);
var
  c: integer;
begin
  c := 0;
  while c < FIDEComps.Count do
  begin
    if SameText(APage, FIDEComps.Items[c].Page) then
      FIDEComps.Items[c].Free
    else
      inc(c);
  end;
end;

function TIDEEngine.OpenFile(AFileName: string): TIDEProjectFile;
var
  AUnitName: string;
  AFoundFile: TIDEProjectFile;
begin
  if IsValidFile(iftScript, AFileName) and (FScripter <> nil) then
  begin 
    {Check if the file can be loaded. Cannot add the file is the unit name already exists}
    AUnitName := ExtractFileName(ChangeFileExt(AFileName, ''));
    AFoundFile := FFiles.FindByUnitName(AUnitName);
    if AFoundFile <> nil then
    begin
      {If the file already exists and the path and file is exactly the same (in other words,
       the existing file is being loaded, then just activates the file and exit}
      if SameText(AFoundFile.GetFullFileName, AFileName) then
      begin
        result := AFoundFile;
        {if file is visible, then just set as active. If it's not visible, then reload from file}
        if result.Visible then
          ChangeActiveFile(result)
        else
          result.Load; //Load method already sets the file as active
        Exit;
      end else
        {if it's not the same file but has the same name, then raises an exception}
        raise EIDEException.Create(Format('An unit named "%s" already exists in project.', [AUnitName]));
    end;

    {Create the file object}
    result := FFiles.Add;

    {For now, check only for .pas files. In future, we must need to check the
     type of file}
    if SameText(ExtractFileExt(AFileName), FileExtBasicUnit) then
      result.FTempScriptLang := slBasic
    else
      result.FTempScriptLang := slPascal;
    result.ChangeFileName(AFileName);

    result.Load;

    {if the execution reaches this point, it means that a new file was added to the project.
     Then set project modified to true}
    FProjectModified := true;
  end else
    result := nil;
end;

function TIDEEngine.DlgOpenFile: TIDEProjectFile;
var
  OD: TOpenDialog;
  AFileName: string;
begin
  result := nil;
  OD := TOpenDialog.Create(nil);
  try
    PrepareOpenDialog(OD);
    if ExecuteOpenDialog(OD, iftScript, AFileName) then
      result := OpenFile(AFileName);
  finally
    OD.Free;
  end;
end;

function TIDEEngine.dlgSaveAll: boolean;
var
  c: integer;
begin
  result := false;
  for c := 0 to VisibleFileCount - 1 do
    if VisibleFiles[c] <> MainUnit then
    begin
      if not DlgSaveFile(VisibleFiles[c]) then
        Exit;
    end;
  if MainUnit <> nil then
    if not DlgSaveFile(MainUnit) then
      Exit;
  result := InternalSaveProject(false);
end;

procedure TIDEEngine.PrepareSaveDialog(ADlg: TOpenDialog; AFile: TIDEProjectFile);
begin
  ADlg.Title := Format('Save %s as', [AFile.UnitName]);
  ADlg.DefaultExt := AFile.DefaultFileExt;
  ADlg.Filter := Format('Scripter Studio %s unit (*%s)|*%s', [AFile.LanguageName, AFile.DefaultFileExt, AFile.DefaultFileExt]);
  ADlg.Filter := ADlg.Filter + '|Any file (*.*)|*.*';
  ADlg.FileName := ExtractFileName(AFile.GetFullFileName);
  ADlg.Options := ADlg.Options + [ofOverwritePrompt];
end;

procedure TIDEEngine.PrepareSaveProjectDialog(ADlg: TOpenDialog);
begin
  ADlg.Title := Format('Save %s as', [FProjectName]);
  ADlg.DefaultExt := '.ssproj';
  ADlg.Filter := Format('Scripter Studio project (*%s)|*%s', ['.ssproj', '.ssproj']);
  ADlg.Filter := ADlg.Filter + '|Any file (*.*)|*.*';
  ADlg.FileName := ExtractFileName(GetFullProjectFileName);
  ADlg.Options := ADlg.Options + [ofOverwritePrompt];
end;

procedure TIDEEngine.PrepareOpenDialog(ADlg: TOpenDialog);
begin
  ADlg.Title := Format('Open', []);
  ADlg.DefaultExt := FileExtPascalUnit;
  ADlg.Filter :=
    Format('Scripter Studio unit (*%s;*%s)|*%s;*%s', [FileExtPascalUnit, FileExtBasicUnit, FileExtPascalUnit, FileExtBasicUnit]) + '|' +
    Format('Scripter Studio Pascal unit (*%s)|*%s', [FileExtPascalUnit, FileExtPascalUnit]) + '|' +
    Format('Scripter Studio Basic unit (*%s)|*%s', [FileExtBasicUnit, FileExtBasicUnit]);
  ADlg.Filter := ADlg.Filter + '|Any file (*.*)|*.*';
end;

procedure TIDEEngine.PrepareOpenProjectDialog(ADlg: TOpenDialog);
begin
  ADlg.Title := Format('Open project', []);
  ADlg.DefaultExt := '.ssproj';
  ADlg.Filter := Format('Scripter Studio project (*%s)|*%s', ['.ssproj', '.ssproj']);
  ADlg.Filter := ADlg.Filter + '|Any file (*.*)|*.*';
end;

function TIDEEngine.DlgSaveFileAs(AFile: TIDEProjectFile): boolean;
var
  SD: TSaveDialog;
  OldFileName: string;
  AExistingUnit: TIDEProjectFile;
  AFileName: string;
begin
  result := false;
  if (AFile <> nil) then
  begin
    {Ensure all units are being used}
    AFile.CheckUsedUnits;

    SD := TSaveDialog.Create(nil);
    try
      {Prepare save dialog properties}
      PrepareSaveDialog(SD, AFile);

      repeat
        result := ExecuteSaveDialog(SD, iftScript, AFile, AFileName);
        AExistingUnit := Files.FindByUnitName(ExtractFileName(ChangeFileExt(AFileName, '')));
        if (AExistingUnit <> nil) and (AExistingUnit <> AFile) then
          ShowMessage(Format('A unit name "%s" already exists in project.', [AExistingUnit.UnitName]));
      until (AExistingUnit = nil) or (AExistingUnit = AFile);

      if result then
      begin
        OldFileName := AFile.GetFullFileName;
        AFile.ChangeFileName(AFileName, true);
        try
          AFile.UpdateFormHeader;
          AFile.Save;
        except
          {Rollback the old file name because there was an error while saving the file}
          AFile.ChangeFileName(OldFileName, true);
          AFile.UpdateFormHeader;
          raise;
        end;
        if AFile = ActiveFile then
          UpdateMemoSource(true);
        UpdateTabControl;
      end;
    finally
      SD.Free;
    end;
  end;
end;

function TIDEEngine.DlgSaveFile(AFile: TIDEProjectFile): boolean;
begin
  result := false;
  if AFile <> nil then
  begin
    if AFile.FSaved then
    begin
      AFile.Save;
      result := true;
    end
    else
      result := DlgSaveFileAs(AFile);
  end;
end;

function TIDEEngine.DlgSaveActiveFile: boolean;
begin
  result := DlgSaveFile(ActiveFile);
end;

function TIDEEngine.DlgSaveActiveFileAs: boolean;
begin
  result := DlgSaveFileAs(ActiveFile);
end;

function TIDEEngine.DlgCloseActiveFile: TIDECloseFileResult;
begin
  result := DlgCloseFile(ActiveFile);
end;

function TIDEEngine.DlgCloseFile(AFile: TIDEProjectFile): TIDECloseFileResult;
begin
  result := cfrCanceled;
  if AFile <> nil then
  begin
    {if file is not modified, then we can close it}
    if AFile.FModified then
    begin
      {$WARNINGS OFF}
      Case Application.MessageBox(Pchar(Format('Save changes to %s?', [AFile.UnitName])), Pchar('Confirm'),
        MB_YESNOCANCEL) of
        IDYES:
          if DlgSaveFile(AFile) then
            result := cfrClosed;
        IDNO:
          result := cfrClosed;
      else
        //IDCANCEL:
        result := cfrCanceled;
      end;
      {$WARNINGS ON}
    end else
      result := cfrClosed;

    if result = cfrClosed then
    begin
      if AFile.FSaved then
        AFile.Visible := false
      else
      begin
        AFile.Free;
        result := cfrRemoved;
      end;
    end;
  end;
end;

function TIDEEngine.DlgCloseAll: boolean;
begin
  {Close all files}
  result := false;
  while (VisibleFileCount > 0) do
  begin
    if DlgCloseFile(VisibleFiles[0]) = cfrCanceled then
      Exit;
  end;

  {Now close project}
  {if project modified, then we can close it}
  result := not FProjectModified;
  if not result then
  begin
    {$WARNINGS OFF}
    Case Application.MessageBox(Pchar(Format('Save changes to project %s?', [FProjectName])), PChar('Confirm'),
      MB_YESNOCANCEL) of
      IDYES:
        begin
          DlgSaveProject;
          result := true;
        end;
      IDNO:
        result := true;
    else
      //IDCANCEL:
      result := false;
    end;
    {$WARNINGS ON}
  end;

  (*{If the project was closed, then create a new one automatically}
  if result then
    NewProject;*)
end;

function TIDEEngine.DlgNewProject: boolean;
begin
  result := false;
  if DlgCloseProject then
  begin
    result := NewProject;
  end;
end;

function TIDEEngine.DlgSaveProjectAs: boolean;
begin
  if FProjectSaved then
    result := InternalSaveProjectAs(true)
  else
    result := InternalSaveProject(true);
end;

function TIDEEngine.InternalSaveProjectAs(DoSaveAllBefore: boolean): boolean;
var
  SD: TSaveDialog;
  OldProjName: string;
  AFileName: string;
begin
  result := false;
  if not DoSaveAllBefore or DlgSaveAll then
  begin
    SD := TSaveDialog.Create(nil);
    try
      PrepareSaveProjectDialog(SD);

      result := ExecuteSaveDialog(SD, iftProject, nil, AFileName);
      if result then
      begin
        OldProjName := GetFullProjectFileName;
        ChangeProjectName(AFileName);
        try
          SaveProject;
        except
          {Rollback the old file name because there was an error while saving the file}
          ChangeProjectName(OldProjName);
          raise;
        end;
      end;
    finally
      SD.Free;
    end;
  end;
end;

function TIDEEngine.DlgSaveProject: boolean;
begin
  result := InternalSaveProject(true);
end;

function TIDEEngine.InternalSaveProject(DoSaveAllBefore: boolean): boolean;
begin
  result := false;
  if not DoSaveAllBefore or DlgSaveAll then
  begin
    if FProjectSaved then
    begin
      SaveProject;
      result := true;
    end
    else
      result := InternalSaveProjectAs(false);
  end;
end;

procedure TIDEEngine.ViewModeChanged(AFile: TIDEProjectFile);
begin
  if (AFile <> nil) and (AFile = ActiveFile) and not FUpdatingView then
  begin
    FUpdatingView := true;
    try
      Case AFile.ViewMode of
        vmUnit:
          ShowSourceEditor;
        vmForm:
          ShowFormEditor;
      end;
    finally
      FUpdatingView := false;
    end;
  end;
end;

procedure TIDEEngine.FileRemoved(AIndex: integer);
begin
  {Remove the form being edited from the design control to avoid problems when
   the form is destroyed}
  if FDesignControl <> nil then
    FDesignControl.EditForm := nil;

  {Set the new active file}
  if not (csDestroying in ComponentState) then
    ForceActiveFile(AIndex);
end;

procedure TIDEEngine.MainUnitRemoved;
var
  c: integer;
begin
  {Find another "main unit". If no unit is found, try to find a form}
  FMainUnit := nil;
  for c := 0 to Files.Count - 1 do
    if not Files[c].IsForm then
    begin
      FMainUnit := Files[c];
      break;
    end;

  if (FMainUnit = nil) and (Files.Count > 0) then
    FMainUnit := Files[0];
end;

procedure TIDEEngine.ForceActiveFile(AIndex: integer);
var
  c: integer;
  AFile: TIDEProjectFile;
begin
  {Find the next visible file with index less than AIndex. If not found, then use
   any visible file. If not found, then set to nil}
  AFile := nil;
  for c := Files.Count - 1 downto 0 do
    if Files[c].Visible then
    begin
      AFile := Files[c];
      if AFile.Index < AIndex then
        break;
    end;

  ChangeActiveFile(AFile);
end;

procedure TIDEEngine.ToggleViewMode;
begin
  if ActiveFile <> nil then
  begin
    Case ActiveFile.ViewMode of
      vmUnit:
        ActiveFile.ViewMode := vmForm;
      vmForm:
        ActiveFile.ViewMode := vmUnit;
    end;
  end;
end;

procedure TIDEEngine.ComboChanged;
begin
  if (ComponentCombo <> nil) then
  begin
    ComponentCombo.SynchroLock;
    try
      SelectedComponent := ComponentCombo.Instance;
    finally
      ComponentCombo.SynchroUnlock;
    end;
  end;
end;

procedure TIDEEngine.PrepareMainScript(RunMode: TIDERunMode);
begin
  if Scripter <> nil then
    Case RunMode of
      rmMainUnit:
        if (MainUnit <> nil) and not Scripter.Running then
          ActiveFile := MainUnit;
    end;
end;

procedure TIDEEngine.RunScript(RunMode: TIDERunMode = rmMainUnit);
begin
  InternalRun(RunMode, true);
end;

procedure TIDEEngine.RunProject;
begin
  RunScript(rmMainUnit);
end;

procedure TIDEEngine.RunActiveScript;
begin
  RunScript(rmActiveUnit);
end;

procedure TIDEEngine.DebugPause;
begin
  if Scripter <> nil then
  begin
    FUpdateWatches := true;
    Scripter.Paused := true;
  end;
end;

procedure TIDEEngine.DebugStepOver(RunMode: TIDERunMode = rmMainUnit);
begin
  if (Scripter <> nil) then
  begin
    PrepareMainScript(RunMode);
    FUpdateWatches := true;
    FPostHaltAction := daStepOver;
    CheckRunningMode;
    Scripter.Paused := true;
    if not Scripter.Running then
    begin
      Scripter.Running := true;
      CheckPostHaltAction;
    end else
      Scripter.DebugStepOverLine;
  end;
end;

procedure TIDEEngine.DebugTraceInto(RunMode: TIDERunMode = rmMainUnit);
begin
  if Scripter <> nil then
  begin
    PrepareMainScript(RunMode);
    FUpdateWatches := true;
    FPostHaltAction := daStepOver;
    CheckRunningMode;
    Scripter.Paused := true;
    if not Scripter.Running then
    begin
      Scripter.Running := true;
      CheckPostHaltAction;
    end else
      Scripter.DebugTraceIntoLine;
  end;
end;

procedure TIDEEngine.DebugRunToLine(RunMode: TIDERunMode = rmMainUnit);
begin
  if (ActiveScript <> nil) and (Memo <> nil) then
  begin
    PrepareMainScript(RunMode);
    FUpdateWatches := true;
    FPostHaltAction := daRunTo;
    CheckRunningMode;
    ActiveScript.VirtualMachine.DebugRunToLine(Memo.CurY + 1);
    CheckPostHaltAction;
  end;
end;

procedure TIDEEngine.DebugUntilReturn;
begin
  if Scripter <> nil then
  begin
    FUpdateWatches := true;
    FPostHaltAction := daReturn;
    CheckRunningMode;
    Scripter.DebugRunUntilReturn;
    CheckPostHaltAction;
  end;
end;

procedure TIDEEngine.DebugReset;
begin
  if Scripter <> nil then
  begin
    FUpdateWatches := true;
    Scripter.Halt;
    ShowExecutionPoint;
    if Memo <> nil then
    begin
      Memo.ActiveLineSettings.ShowActiveLine := false;
      Memo.ActiveLineSettings.ShowActiveLineIndicator := false;
    end;
  end;
end;

procedure TIDEEngine.ShowExecutionPoint;
var
  curline : integer;
  ANewActiveFile: TIDEProjectFile;
begin                                               
  if (Memo <> nil) and (ActiveScript <> nil) then
  begin
    {All these settings only make sense if the script is paused. Otherwise,
     we don't need to update the IDE (active script, active line, watches, etc.}
    if ActiveScript.Scripter.Paused then
    begin

      {Set the active script accordingly. We must check if active script is the same
       as *CurrentDebugScript* which is the *base* script (if we have multiple forms running,
       currentdebugscript will be the base form}
      if (Scripter <> nil) and (Scripter.CurrentDebugScript <> ActiveScript) then
      begin
        ANewActiveFile := FFiles.FindByScript(Scripter.CurrentDebugScript);
        if ANewActiveFile <> nil then
        begin
          ANewActiveFile.ViewMode := vmUnit;
          ActiveFile := ANewActiveFile;
        end;
      end;

      if not Memo.ActiveLineSettings.ShowActiveLine then
        Memo.ActiveLineSettings.ShowActiveLine := true;
      if not Memo.ActiveLineSettings.ShowActiveLineIndicator then
        Memo.ActiveLineSettings.ShowActiveLineIndicator := true;

      {we must be careful: the curline must come from *CurrentScript*, which is the script effectively running
       in the scripter component}
      curline := LineNumberFromInstruction(Scripter.CurrentScript.VirtualMachine.NextInstruction);
      if curline <> Memo.ActiveLine then // just avoid memo flicking
      begin
        Memo.ActiveLine := curline;
        Memo.CurY := curline;
        FUpdateWatches := true;
      end;
      if FUpdateWatches then
      begin
        if FWatchList <> nil then
        begin
          if FWatchList.Visible then
            FWatchList.UpdateList;
        end;
        FUpdateWatches := false;
      end;
    end else
    begin
      {hide active line}
      if Memo.ActiveLineSettings.ShowActiveLine then
        Memo.ActiveLineSettings.ShowActiveLine := false;
      if Memo.ActiveLineSettings.ShowActiveLineIndicator then
        Memo.ActiveLineSettings.ShowActiveLineIndicator := false;
    end;
  end;
end;

procedure TIDEEngine.CheckPostHaltAction;
begin
  {This code does nothing. See comments in CheckRunningMode method. If needed, we can uncomment
   this code later, but it was only used for executing a debug action after a script was halted
   after the question "source has been modified, start again?". Since we will not have this
   question for now, the code is useless}

  {if FPostHaltAction <> daNone then
  begin
    PostMessage(Handle, WM_DEBUGACTION, Ord(FPostHaltAction), 0);
    FPostHaltAction := daNone;
  end;}
end;

procedure TIDEEngine.CheckRunningMode;
var
  c: integer;
begin
  {if script source was modified then ask user to recompile and rerun}
  {NOTE: this code was "copied" from original IDE demo project. It was copied here
  and keep as-is for future needs, but actually the code is not needed, because in this new IDE Engine,
  no changes can be done to the project (source code memo, form designer, etc.) while script is running.
  So, there is no need to check "modified" and ask things like "source has been modified". But we will keep
  this redundant code here in case we need it for the future.}
  if (ActiveScript <> nil) and (Scripter <> nil) then
  begin
    {Ensure the script is compiled and compile thread is not running}
    CheckCompiled;

    (*if Modified and (FLastModifiedAnswer <> mrNo) then
    begin
      {Check if scripter component (not script object) is running, because ActiveScript is related to the IDE
       (current script being edited) but the current script running might be different}
      if Scripter.Running then
      begin
        FLastModifiedAnswer := MessageDlg('Source has been modified. Start again?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
        case FLastModifiedAnswer of
          mrYes :
            begin
              Scripter.Halt;
              Abort;
            end;
          mrCancel:
            begin
              FPostHaltAction := daNone;
              Abort;
            end;
        end;
      end
      else
      begin
        UpdateScriptSource(false);

        {if source was modified, then set everything to compiled = false, so everything is recompiled.
         This is needed because we might have a unit which uses another one. Example, unit1 uses unit2.
         If unit2 is modified, we must set unit1.compiled to false, because otherwise some pointers and indexes
         of compiled code of unit1 will be outdated and some AV might raise}
        {So, force all units to recompile}
        for c := 0 to Scripter.Scripts.Count - 1 do
          Scripter.Scripts[c].Compiled := false;
      end;
    end;*)

    if ActiveFile.FMustUpdateScript and not Scripter.Running then
    begin
      UpdateScriptSource(false);

      {if source was modified, then set everything to compiled = false, so everything is recompiled.
       This is needed because we might have a unit which uses another one. Example, unit1 uses unit2.
       If unit2 is modified, we must set unit1.compiled to false, because otherwise some pointers and indexes
       of compiled code of unit1 will be outdated and some AV might raise}
      {So, force all units to recompile}
      for c := 0 to Scripter.Scripts.Count - 1 do
        Scripter.Scripts[c].Compiled := false;
    end;

    //UpdateScriptBreakPoints;
    FPostHaltAction := daNone;

    {Update current script to be executed}
    if not Scripter.Running then
      Scripter.CurrentScript := ActiveScript;
  end;
end;

function TIDEEngine.GetModified: boolean;
var
  c: integer;
begin
  result := false;
  for c := 0 to FFiles.Count - 1 do
    if FFiles[c].FModified then
    begin
      result := true;
      exit;
    end;
end;

function TIDEEngine.GetActiveScript: TatScript;
begin
  if (ActiveFile <> nil) then
    result := ActiveFile.Script
  else
    result := nil;
end;

procedure TIDEEngine.DebugToggleBreak(ALine: integer = -1);
begin
  {if ALine is -1 then it depends on memo cursor. If memo is not assigned,
   exit the procedure}
  if ALine = -1 then
  begin
    if Memo <> nil then
      ALine := Memo.CurY + 1
    else
      exit;
  end;

  if Memo <> nil then
    Memo.BreakPoint[ALine - 1] := not Memo.BreakPoint[ALine - 1];
  if ActiveScript <> nil then
    ActiveScript.Breaks.ToggleBreak(ALine);
end;

procedure TIDEEngine.UpdateIDE(AFile: TIDEProjectFile);
begin
  ChangeActiveFile(AFile);
end;

procedure TIDEEngine.UpdateMemoBreakpoints;
var
  c: integer;
begin
  {Update memo breakpoints according to the ones set in the script}
  if (ActiveScript <> nil) and (Memo <> nil) then
  begin
    Memo.ClearBreakpoints;
    with ActiveScript do
      for c := 0 to Breaks.Count - 1 do
        if not Breaks[c].AutoDestroy then
          Memo.BreakPoint[Breaks[c].Line - 1] := true;

    {Hide/set active line. Show active line if scripter is running
     and the activescript (visibel) is the same as the currentscript being executed}
    Memo.ActiveLineSettings.ShowActiveLine :=
      Scripter.Running and (ActiveScript = ActiveScript.Scripter.CurrentDebugScript);
    Memo.ActiveLineSettings.ShowActiveLineIndicator :=
      Memo.ActiveLineSettings.ShowActiveLineIndicator;
  end;
end;

procedure TIDEEngine.RunningChanged;
var
  ARunning: boolean;
begin
  {Set all components disable when script is running}
  ARunning := (Scripter <> nil) and (Scripter.Running);

  {Set memo read only if scripter is running}
  if Memo <> nil then
    Memo.ReadOnly := ARunning;

  {Lock designer is script is running}
  if GetDesigner <> nil then
  begin
    if ARunning and not GetDesigner.Locked then
      GetDesigner.Lock
    else
    if not ARunning and GetDesigner.Locked then
      GetDesigner.Unlock;
  end;

  {Inspector should be locked too, but this is done automatically in TIDEInspector.GetReadOnly method}

  {Update active line in memo}
  ShowExecutionPoint;

  {if scripter has finished running, then set currentscript to original activescript. They might be different because
   a form might have be executed and then the currentscript is pointing to a running form (the form might have be displayed
   with Show, the script stopped executed, but the currentscript is still point to the form}
  if not ARunning and (Scripter <> nil) and (ActiveFile <> nil) then
  begin
    Scripter.CurrentScript := ActiveFile.Script;
  end;

  if Assigned(FOnRunningChanged) then
    FOnRunningChanged(Self, ARunning);
end;

procedure TIDEEngine.SetBasePath(const Value: string);
var
  c: integer;
  AFullFileName: string;
  OldBasePath: string;
begin
  if FBasePath <> Value then
  begin
    OldBasePath := FBasePath;

    {iterate through all files and update file name so it's now relative to base path}
    for c := 0 to Files.Count - 1 do
    begin
      {Get current file name based on old basepath}
      FBasePath := OldBasePath;
      AFullFileName := Files[c].GetFullFileName;

      {Now set the new file based on new basepath. This procedure will set the relative paths
       accordingly}
      FBasePath := Value;
      Files[c].ChangeFileName(AFullFileName);
    end;

    FBasePath := Value;
  end;
end;

function TIDEEngine.GetVisibleFile(Index: integer): TIDEProjectFile;
var
  c: integer;
  i: integer;
begin
  result := nil;
  i := 0;
  for c := 0 to Files.Count - 1 do
    if Files[c].Visible then
    begin
      if Index = i then
      begin
        result := Files[c];
        break;
      end;
      i := i + 1;
    end;
end;

function TIDEEngine.VisibleFileCount: integer;
var
  c: integer;
begin
  result := 0;
  for c := 0 to Files.Count - 1 do
    if Files[c].Visible then
      result := result + 1;
end;

function TIDEEngine.NewProject: boolean;
begin
  result := true;
  Files.Clear;
  BasePath := '';
  FProjectName := 'Project1';
  FProjectSaved := false;
  FProjectModified := false;
  ProjNameChanged;
end;

procedure TIDEEngine.SaveProject;
var
  MI: TMemIniFile;
  c, total: integer;
  AFileContent: string;
  SL: TStringList;
  Handled: boolean;
begin
  {This only saves the list of files in the project}
  MI := TMemIniFile.Create('');
  try
    total := 0;
    for c := 0 to Files.Count - 1 do
    begin
      {Only include saved units in project}
      if Files[c].FSaved then
      begin
        total := total + 1;
        MI.WriteString('Files', 'File' + IntToStr(total), Files[c].GetFullFileName(true));
        MI.WriteInteger('Files', 'Language' + IntToStr(total), Ord(Files[c].ScriptLanguage));
      end;
    end;
    MI.WriteInteger('Files', 'FileCount', Total);
    if MainUnit <> nil then
      MI.WriteString('Files', 'MainUnit', MainUnit.UnitName);

    {Now save content to file}
    SL := TStringList.Create;
    try
      MI.GetStrings(SL);
      AFileContent := SL.Text;
      Handled := false;
      if Assigned(FOnSaveFile) then
        FOnSaveFile(Self, iftProject, GetFullProjectFileName, AFileContent, nil, Handled);
      if not Handled then
        SL.SaveToFile(GetFullProjectFileName);
    finally
      SL.Free;
    end;

  finally
    MI.Free;
  end;

  FProjectSaved := true;
  FProjectModified := false;
end;

procedure TIDEEngine.ProjNameChanged;
begin
  if Assigned(FOnProjNameChanged) then
    FOnProjNameChanged(Self);
end;

procedure TIDEEngine.ChangeProjectName(AFileName: string);
begin
  FProjectName := ExtractFileName(ChangeFileExt(AFileName, ''));
  BasePath := ExtractFilePath(ExpandFileName(AFileName));
  ProjNameChanged;
end;

function TIDEEngine.GetFullProjectFileName: string;
begin
  result := AddPathDelim(BasePath) + ChangeFileExt(FProjectName, '.ssproj');
end;

function TIDEEngine.DlgRemoveActiveFile: boolean;
begin
  result := DlgRemoveFile(ActiveFile);
end;

function TIDEEngine.DlgRemoveFile(AFile: TIDEProjectFile): boolean;
begin
  result := false;
  if AFile <> nil then
  begin
    {$WARNINGS OFF}
    if Application.MessageBox(Pchar(Format('Remove unit "%s" from project?', [AFile.UnitName])), Pchar('Confirm'),
        MB_OKCANCEL) = IDOK then
    {$WARNINGS ON}
    begin
      {Just close file normally}
      Case DlgCloseFile(AFile) of
        cfrRemoved:
          {if file was already removed, then function just returns true}
          result := true;
        cfrClosed:
          begin
            {If file was just closed, then remove the file from collection}
            AFile.Free;
            result := true;
          end;
      end;
    end;
  end;
end;

function TIDEEngine.DlgOpenProject: boolean;
var
  OD: TOpenDialog;
  AFileName: string;
begin
  result := false;
  OD := TOpenDialog.Create(nil);
  try
    PrepareOpenProjectDialog(OD);
    if ExecuteOpenDialog(OD, iftProject, AFileName) then
    begin
      if DlgCloseProject then
        result := OpenProject(AFileName);
    end;
  finally
    OD.Free;
  end;
end;

function TIDEEngine.OpenProject(AFileName: string): boolean;
begin
  result := false;
  if IsValidFile(iftProject, AFileName) then
  begin
    {Clears everything}
    NewProject;

    {Updated project name}                   
    ChangeProjectName(AFileName);

    {Load project}
    result := LoadProject;

    {Set internal variables}
    FProjectModified := false;
    FProjectSaved := true;
  end;
end;

function TIDEEngine.LoadProject: boolean;
var
  MI: TMemIniFile;
  ANewFile: TIDEProjectFile;
  AFileName: string;
  c, total: integer;
  AMainUnitName: string;
  SL: TStrings;
  Handled: boolean;
  AFileContent: string;
  AFileLanguage: integer;
begin
  {Loads the list of files in the project, fill the files collection, and make all visible}
  MI := TMemIniFile.Create(GetFullProjectFileName);
  try
    {Load the text from file. Do it in two steps because we want to call FOnLoadFile event
     in case the file content is loaded from a blob or something like that}
    SL := TStringList.Create;
    try
      AFileContent := '';
      Handled := false;
      if Assigned(FOnLoadFile) then
      begin
        FOnLoadFile(Self, iftProject, GetFullProjectFileName, AFileContent, nil, Handled);
        if Handled then
          SL.Text := AFileContent;
      end;
      if not Handled then
        SL.LoadFromFile(GetFullProjectFileName);

      {After loading file content, now set the content of memory ini file for retrieving information}
      MI.SetStrings(SL);
    finally
      SL.Free;
    end;

    {Load the project from the memory ini file}
    total := MI.ReadInteger('Files', 'FileCount', 0);
    AMainUnitName := MI.ReadString('Files', 'MainUnit', '');
    for c := 1 to total do
    begin
      AFileName := MI.ReadString('Files', 'File' + IntToStr(c), '');
      ANewFile := FFiles.Add;

      AFileLanguage := MI.ReadInteger('Files', 'Language' + IntToStr(c), -1);
      Case AFileLanguage of
        0: ANewFile.FTempScriptLang := slPascal;
        1: ANewFile.FTempScriptLang := slBasic;
      else
        if SameText(ExtractFileExt(AFileName), FileExtBasicUnit) then
          ANewFile.FTempScriptLang := slBasic
        else
          ANewFile.FTempScriptLang := slPascal;
      end;

      if IsPathRelative(ExtractFilePath(AFileName)) then
        ANewFile.ChangeFileName(AddPathDelim(BasePath) + AFileName)
      else
        ANewFile.ChangeFileName(AFileName);
      ANewFile.Load;
    end;
  finally
    MI.Free;
  end;
  MainUnit := Files.FindByUnitName(AMainUnitName);

  FProjectSaved := true;
  FProjectModified := false;
  result := true;
end;

procedure TIDEEngine.GetAutoCompletionList(AToken: string;
  AList: TStringList);
var
  e,l: integer;
  tp: integer;
  sl: tstringlist;
  s,r:string;
  no: TObject;
begin
  {Fill the autocompletion list}
  if (Memo = nil) or (Scripter = nil) or (Scripter.Running) or (ActiveScript = nil) then
    Exit;

  if ActiveFile.FMustUpdateScript then
    UpdateScriptSource(true);

  CheckCompiled;
  AList.Clear;
  Memo.TextFromPos(Memo.CurX, Memo.CurY, tp);

  sl := CreateCodeCompletionList(ActiveScript,
    Memo.Lines.Text,tp + 1,e,l);
  try
    for e := 1 to sl.Count do
    begin
      s := sl.Strings[e - 1];
      l := pos(' ',s);
      if l > 0 then
      begin
        r := copy(s,1,l - 1);
        delete(s,1,l);
      end
      else
        r := '';

      while pos('.',s) > 0 do
      begin
        delete(s,1,pos('.',s));
      end;

      {$WARNINGS OFF}
      case integer(sl.Objects[e - 1]) of
      {$WARNINGS ON}
      0: sl.Strings[e - 1] := 'property ' + s;
      1,17: sl.Strings[e - 1] := 'procedure ' + s;
      2,18: sl.Strings[e - 1] := 'function ' + s;
      3,19: sl.Strings[e - 1] := 'event ' + s;
      16: sl.Strings[e - 1] := 'var ' + s
      else
        sl.Strings[e - 1] := s;
      end;
      // (ttNone, ttVar, ttProp, ttEvent, ttMethod, ttFunc, ttProc);
      {$WARNINGS OFF}
      case integer(sl.Objects[e - 1]) of
      {$WARNINGS ON}
        0: no := TObject(ttProp);
        1: no := TObject(ttMethod);
        2: no := TObject(ttMethod);
        3: no := TObject(ttEvent);
        16: no := TObject(ttVar);
        17: no := TObject(ttProc);
        18: no := TObject(ttFunc);
        19: no := TObject(ttEvent)
        else
          no := TObject(ttNone);
      end;
      sl.Objects[e - 1] := no;
    end;
    AList.AddStrings(sl);
  finally
    sl.Free;
  end;
end;

procedure TIDEEngine.DesignerComponentDblClicked(AComponent: TComponent);
var
  i: integer;
begin
  if (Inspector <> nil) and not FPreventDefaultEventCreation then
  begin
    {Ensure the the component is selected and is the only selected component}
    if (Inspector.Instance <> AComponent) or (Inspector.InstanceCount <> 1) then
    begin
      while Inspector.InstanceCount > 0 do
        Inspector.DeleteInstance(FInspector.Instances[0]);
      Inspector.Instance := AComponent;
    end;

    {Now find the event and edit it, if it exists. First, try to find OnCreate, then OnChange, then OnClick.
     If none is found, then use first event}
    Inspector.Mode := imEvents;
    i := Inspector.IndexOfPropertyName('OnCreate');
    if i = -1 then
      i := Inspector.IndexOfPropertyName('OnChange');
    if i = -1 then
      i := Inspector.IndexOfPropertyName('OnClick');
    if (i = -1) then
      i := 0;

    {if i is a valid index, then edit the event}
    if (i >= 0) and (i < Inspector.PropertyCount) then
      Inspector.CallEditor(i);
  end;
end;

procedure TIDEEngine.ComponentPlaced(AComponent: TComponent);
begin
  {Add used units to the source code}
  if (ActiveFile <> nil) then
    ActiveFile.CheckUsedUnits;

  {Remove filter of palettebuttons}
  {$IFDEF DELPHI9_LVL}
  if FPaletteButtons <> nil then
  begin
    FPaletteButtons.Filtered := false;
    FPaletteButtons.Filter := '';
  end;
  {$ENDIF}

  if Assigned(FOnComponentPlaced) then
    FOnComponentPlaced(Self, AComponent);
end;

procedure TIDEEngine.AddUsedUnits(AFile: TIDEProjectFile; AUnits: string);
begin
  {Ensure that there current script is silent compiled so we can retrieve information for it}
  if (Scripter <> nil) and not Scripter.Running and (AFile <> nil) and (AFile.Script <> nil) then
  begin
    {if we're going to update the active file, then ensure compile thread is not running
     and also that the script is updated with memo content}
    if AFile = ActiveFile then
    begin
      {Update the source code from memo to script}
      if ActiveFile.FMustUpdateScript then
        UpdateScriptSource(false);

      CheckCompiled;
    end;

    {Add used units to specified file}
    AFile.Script.Refactor.AddUsedUnit(AUnits);

    {now that script source code has changed, update memo content, if the file being updated
     is the active file}
     if AFile = ActiveFile then
       UpdateMemoSource(true);
  end;
end;

function TIDEEngine.DlgSelectLanguage(AItemName: string): TScriptLanguage;
var
  LangForm: TfmSelectLanguage;
begin
  LangForm := TfmSelectLanguage.Create(nil);
  try
    LangForm.Label1.Caption := Format(LangForm.Label1.Caption, [AItemName]);
    if LangForm.ShowModal <> mrOk then
      Abort;
    Case LangForm.ComboBox1.ItemIndex of
      1: result := slBasic;
    else
      result := slPascal;
    end;
  finally
    LangForm.Free;
  end;
end;

procedure TIDEEngine.CreateMainUnits(ALanguage: TScriptLanguage);
var
  AFormFile: TIDEProjectFile;
begin
  MainUnit := NewUnit(ALanguage, true);
  AFormFile := NewFormUnit(ALanguage);
  if (MainUnit <> nil) and (MainUnit.Script <> nil) then
  begin
    BeginUpdateSourceCode;
    try
      With MainUnit.Script.SourceCode do
      begin
        Clear;
        Case ALanguage of
          slPascal:
            begin
              Clear;
              Add('uses');
              Add(Format('  Classes, Graphics, Controls, Forms, Dialogs, %s;', [AFormFile.UnitName]));
              Add('');
              Add('var');
              Add(Format('  MainForm: %s;', [AFormFile.FormClassName]));
              Add('begin');
              Add(Format('  MainForm := %s.Create(Application);', [AFormFile.FormClassName]));
              Add('  MainForm.Show;');
              Add('end;');
            end;
          slBasic:
            begin
              Clear;
              Add('USES');
              Add(Format('  Classes, Graphics, Controls, Forms, Dialogs, %s', [AFormFile.UnitName]));
              Add('');
              Add(Format('DIM MainForm AS %s', [AFormFile.FormClassName]));
              Add('');
              Add(Format('MainForm = %s.Create(Application)', [AFormFile.FormClassName]));
              Add('MainForm.Show');
            end;
        end;
      end;
    finally
      EndUpdateSourceCode;
    end;
    MainUnit.FModified := false;
    AFormFile.FModified := false;
  end;
  ActiveFile := MainUnit;
end;

procedure TIDEEngine.SetMainUnit(const Value: TIDEProjectFile);
begin
  if (FMainUnit <> Value) then
  begin
    FMainUnit := Value;
  end;
end;

procedure TIDEEngine.UnitNameChanged(AFile: TIDEProjectFile; AOldName,
  ANewName: string);
begin
  {very rough and fast algorithm to replace unit name. This procedure is called in
   many different situations (mainly when ChangeFileName is called) and it would be
   a little bit dangerous if we compile the main unit now}
  if (MainUnit <> nil) and (MainUnit.Script <> nil) and (AOldName <> '') and (ANewName <> '') then
  begin
    if (MainUnit = ActiveFile) and (ActiveFile.FMustUpdateScript) then
      UpdateScriptSource(false);

    BeginUpdateSourceCode;
    try
      MainUnit.Script.SourceCode.Text := StringReplace(MainUnit.Script.SourceCode.Text,
        ' ' + AOldName, ' ' + ANewName, [rfIgnoreCase]);
    finally
      EndUpdateSourceCode;
    end;

    if MainUnit = ActiveFile then
      UpdateMemoSource(true);
  end;
end;

function TIDEEngine.DlgSelectMainUnit: boolean;
var
  ChooseForm: TfmSelectUnit;
  c: integer;
begin
  result := false;
  if Files.Count > 0 then
  begin
    ChooseForm := TfmSelectUnit.Create(nil);
    try
      ChooseForm.Label1.Caption := 'Select main unit of the project';

      {Fill in unit list and select main unit}
      ChooseForm.ComboBox1.Items.Clear;
      for c := 0 to Files.Count - 1 do
        ChooseForm.ComboBox1.Items.Add(Self.Files[c].UnitName);
      ChooseForm.ComboBox1.Sorted := true;
      if MainUnit <> nil then
        ChooseForm.ComboBox1.ItemIndex := ChooseForm.ComboBox1.Items.IndexOf(MainUnit.UnitName);

      {Show the form}
      result := (ChooseForm.ShowModal = mrOk);
      if result then
        MainUnit := Files.FindByUnitName(Chooseform.ComboBox1.Items[ChooseForm.ComboBox1.ItemIndex]);
    finally
      ChooseForm.Free;
    end;
  end;
end;

procedure TIDEEngine.DoOnViewModeChanged;
begin
  if Assigned(FOnViewModeChanged) then
    FOnViewModeChanged(Self);
end;

procedure TIDEEngine.SetWatchList(const Value: TIDEWatchListView);
begin
  if FWatchList <> Value then
  begin
    FWatchList := Value;
    if FWatchList <> nil then
    begin
      FWatchList.Engine := Self;
      FWatchList.UpdateList;
    end;
  end;
end;

function TIDEEngine.CreateScriptForm: TScriptForm;
begin
  if Scripter <> nil then
    result := Scripter.ScriptFormClass.Create(nil)
  else
    result := TScriptForm.Create(nil)
end;

function TIDEEngine.DlgAddWatch: TatScripterWatch;
begin
  result := nil;
  if WatchList <> nil then
    result := WatchList.DlgAddWatch;
end;

procedure TIDEEngine.DoBeforeAddWatchDlg;
begin
  if Assigned(FBeforeAddWatchDlg) then
    FBeforeAddWatchDlg(Self);
end;

procedure TIDEEngine.DoGetComponentImage(RegComp: TIDERegisteredComp;
  ABitmap: TBitmap; var AHandled: boolean);
begin
  if Assigned(FOnGetComponentImage) then
    FOnGetComponentImage(Self, RegComp, ABitmap, AHandled);
end;

procedure TIDEEngine.SyncFilesFromScripts;
var
  c: integer;
  i: integer;
  found: boolean;
  ANewFile: TIDEProjectFile;
  ANewBaseName: string;
  ANewUnitName: string; 
begin
  if Scripter <> nil then
  begin
    {Destroy files which don't have scripts associated - this will be very rare}
    c := 0;
    while c < Files.Count do
    begin
      found := false;
      for i := 0 to Scripter.Scripts.Count - 1 do
        if Scripter.Scripts[i] = Files[c].Script then
        begin
          found := true;
          break;
        end;

      if not found then
        Files[c].Free
      else
        inc(c);
    end;

    {Now create files based on scripts}
    for c := 0 to Scripter.Scripts.Count - 1 do
    begin
      {if the script doesn't have a file associated, then create a file}
      if Files.FindByScript(Scripter.Scripts[c]) = nil then
      begin
        {create the file}
        ANewFile := Files.Add;
        ANewFile.Script := Scripter.Scripts[c];
        ANewFile.SetForm(nil); //no way to create form from existing script

        {Set the unit name}
        ANewBaseName := Scripter.Scripts[c].UnitName;
        if ANewBaseName = '' then
          ANewBaseName := Scripter.Scripts[c].ScriptInfo.UnitName;
        if ANewBaseName = '' then
          ANewBaseName := Format('Script%d', [c + 1]);

        ANewUnitName := ANewBaseName;
        i := 0;
        while
          ((Scripter.Scripts.FindByUnitName(ANewUnitName) <> nil) and (Scripter.Scripts.FindByUnitName(ANewUnitName) <> Scripter.Scripts[c]))
          or
         (Files.FindByUnitName(ANewUnitName) <> nil) do
        begin
          i := i + 1;
          ANewUnitName := Format('%s_%d', [ANewBaseName, i]);
        end;

        {After new unit name found, set the unit name in both script and file}
        Scripter.Scripts[c].UnitName := ANewUnitName;
        ANewFile.FUnitName := ANewUnitName;
        ANewFile.FModified := false;
        ANewFile.FMustUpdateScript := false;
        ANewFile.ViewMode := vmUnit;
        ANewFile.Visible := true;
      end;
    end;
  end;
end;

function TIDEEngine.IsValidFile(AFileType: TIDEFileType; AFileName: string): boolean;
begin
  result := false;
  if Assigned(FOnCheckValidFile) then
    FOnCheckValidFile(Self, AFileType, AFileName, result)
  else
    result := FileExists(AFileName);
end;

procedure TIDEEngine.SaveStringToFile(AFileName, AContent: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Text := AContent;
    SL.SaveToFile(AFileName);
  finally
    SL.Free;
  end;
end;

procedure TIDEEngine.ScriptSourceChanged(AScript: TatScript);
begin
  if (FUpdatingScriptSource = 0) and (ActiveScript = AScript) then
  begin
    BeginUpdateSourceCode;
    try
      UpdateMemoSource(true);
    finally
      EndUpdateSourceCode;
    end;
  end;
end;

function TIDEEngine.ExecuteSaveDialog(SD: TSaveDialog; AFileType: TIDEFileType;
  AFile: TIDEProjectFile; var AFileName: string): boolean;
var
  Handled: boolean;
begin
  Handled := false;
  result := false;
  if Assigned(FOnSaveDialog) then
  begin
    if AFile <> nil then
      AFileName := AFile.UnitName
    else
      AFileName := FProjectName;
    FOnSaveDialog(Self, AFileType, AFileName, AFile, result, Handled);
  end;
  if not Handled and (SD <> nil) then
  begin
    result := SD.Execute;
    AFileName := SD.FileName;
  end;
end;

procedure TIDEEngine.EndRegisterComponents;
begin
  Dec(FUpdatingComponents);
end;

procedure TIDEEngine.EndUpdateSourceCode;
begin
  Dec(FUpdatingScriptSource);
end;

function TIDEEngine.ExecuteOpenDialog(OD: TOpenDialog; AFileType: TIDEFileType;
  var AFileName: string): boolean;
var
  Handled: boolean;
begin
  Handled := false;
  result := false;
  if Assigned(FOnOpenDialog) then
    FOnOpenDialog(Self, AFileType, AFileName, result, Handled);
  if not Handled and (OD <> nil) then
  begin
    result := OD.Execute;
    AFileName := OD.FileName;
  end;
end;

procedure TIDEEngine.CompileError(msg: string; row, col: integer;
  AScript: TatScript);
var
  AFile: TIDEProjectFile;
begin
  AFile := Files.FindByScript(AScript);
  if AFile <> nil then
  begin
    ActiveFile := AFile;
    ShowSourceEditor(Col - 1, Row - 1);
    if Memo <> nil then
    begin
      Memo.FTempActiveLine := true;
      Memo.ActiveLineSettings.ActiveLineColor := clRed;
      Memo.ActiveLineSettings.ActiveLineTextColor := clWhite;
      Memo.ActiveLineSettings.ShowActiveLine := true;
      Memo.ActiveLine := Row - 1;
    end;
  end;
end;

function TIDEEngine.GetSelectedComponent: TComponent;
begin
  {Trust in inspector, then in component combo. Designer is the less option, because the designer
   does not have the selection of non-visual controls which do not contain containers, like fields and menu items}
  result := nil;
  if FInspector <> nil then
  begin
    if FInspector.InstanceCount = 1 then
      result := FInspector.Instance;
  end else
  if FComponentCombo <> nil then
    result := FComponentCombo.Instance
  else
  if Designer <> nil then
    result := Designer.Component;
end;

procedure TIDEEngine.SetSelectedComponent(const Value: TComponent);
begin
  if Designer <> nil then
  begin
    {Avoid automatic update of inspector and combo, because we will update inspector manually later}
    Designer.SynchroLock;
    try
      if Value = Designer.ParentForm then
        Designer.Component := nil
      else
        Designer.Component := Value;
    finally
      Designer.SynchroUnlock;
    end;
  end;

  if Inspector <> nil then
    Inspector.Instance := Value;

  if ComponentCombo <> nil then
    ComponentCombo.Instance := Value;

  DoNotification(ntComponentSelected);
end;

procedure TIDEEngine.ActiveFileModified;
begin
  if ActiveFile <> nil then
  begin
    ActiveFile.FModified := true;
    ActiveFile.FMustUpdateScript := true;
  end;
end;

procedure TIDEEngine.AddNotifier(ANotifier: TIDEEngineNotifier);
begin
  if ANotifier <> nil then
    FNotifiers.Add(ANotifier);
end;

procedure TIDEEngine.RemoveNotifier(ANotifier: TIDEEngineNotifier);
begin
  FNotifiers.Remove(ANotifier);
end;

procedure TIDEEngine.DoNotification(AOperation: TIDENotificationType);
var
  c: integer;
begin
  for c := 0 to FNotifiers.Count - 1 do
    TIDEEngineNotifier(FNotifiers[c]).Notification(AOperation);
end;

procedure TIDEEngine.CleanSavedEvents;
var
  c: integer;
  p: integer;
begin
  if (ActiveFile <> nil) and (ActiveFile.Form <> nil) then
  begin
    c := 0;
    while c < ActiveFile.Form.SaveEvents.Count do
    begin
      p := Pos('.', ActiveFile.Form.SaveEvents.Names[c]);
      if (p > 1) and
        not SameText(Copy(ActiveFile.Form.SaveEvents.Names[c], 1, p - 1), 'Self')
        and (ActiveFile.Form.FindComponent(Copy(ActiveFile.Form.SaveEvents.Names[c], 1, p - 1)) = nil) then
        ActiveFile.Form.SaveEvents.Delete(c)
      else
        inc(c);
    end;
  end;
end;

procedure TIDEEngine.LoadMemoInfo(AFile: TIDEProjectFile);
var
  c: integer;
begin
  if (Memo <> nil) and (AFile <> nil) then
  begin
    Memo.CurX := AFile.FMemoInfo.CurX;
    Memo.CurY := AFile.FMemoInfo.CurY;
    if Memo.TopLine <> AFile.FMemoInfo.TopLine then
      Memo.TopLine := AFile.FMemoInfo.TopLine;
    for c := 0 to 9 do
      Memo.Bookmarks[c] := AFile.FMemoInfo.FBookmarks[c];
    Memo.Invalidate;
  end;
end;

procedure TIDEEngine.SaveMemoInfo(AFile: TIDEProjectFile);
var
  c: integer;
begin
  if (Memo <> nil) and (AFile <> nil) then
  begin
    AFile.FMemoInfo.TopLine := Memo.TopLine;
    AFile.FMemoInfo.CurX := Memo.CurX;
    AFile.FMemoInfo.CurY := Memo.CurY;
    for c := 0 to 9 do
      AFile.FMemoInfo.FBookmarks[c] := Memo.Bookmarks[c];
  end;
end;

procedure TIDEEngine.InternalRun(RunMode: TIDERunMode; AExecute: boolean);
begin
  if (Scripter <> nil) then
  begin
    PrepareMainScript(RunMode);
    FUpdateWatches := true;
    FPostHaltAction := daRun;
    CheckRunningMode;
    Scripter.Paused := false;
    if AExecute then
    begin
      if not Scripter.Running then
        Scripter.Running := true;
    end else
    begin
      Scripter.Compiled := false;
      Scripter.Compile;
    end;
    CheckPostHaltAction;
  end;
end;

procedure TIDEEngine.CompileProject;
begin
  InternalRun(rmMainUnit, false);
end;

function TIDEEngine.DlgCloseProject: boolean;
var
  IsModified: boolean;
  c: integer;
begin
  IsModified := FProjectModified;
  if not IsModified then
    for c := 0 to Files.Count - 1 do
      if Files[c].FModified then
      begin
        IsModified := true;
        break;
      end;

  {Now close project}
  {if project modified, then we can close it}
  result := not IsModified;
  if not result then
  begin
    {$WARNINGS OFF}
    Case Application.MessageBox(Pchar(Format('Save changes to project %s?', [FProjectName])), PChar('Confirm'),
      MB_YESNOCANCEL) of
      IDYES:
        begin
          for c := 0 to Files.Count - 1 do
            if Files[c].FModified or not Files[c].FSaved then
            begin
              if not DlgSaveFile(Files[c]) then
                Exit;
            end;
          result :=  DlgSaveProject;
        end;
      IDNO:
        result := true;
    else
      //IDCANCEL:
      result := false;
    end;
    {$WARNINGS ON}
  end;

end;

{TIDEMemo}

procedure TIDEMemo.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.Memo := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.Memo := Self;
      FEngine.FreeNotification(Self);
    end;
  end;
end;

procedure TIDEMemo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

procedure TIDEMemo.Change;
begin
  inherited;
  if Assigned(FEngine) then
    FEngine.MemoChange;
end;

procedure TIDEMemo.DoGutterClick(LineNo: integer);
begin
  if (Engine <> nil) then
    Engine.DebugToggleBreak(LineNo + 1);

  inherited;
end;

procedure TIDEMemo.DoGetAutoCompletionList(AToken: string;
  AList: TStringList);
begin
  if FEngine <> nil then
    FEngine.GetAutoCompletionList(AToken, AList);
  inherited DoGetAutoCompletionList(AToken, AList);
end;

constructor TIDEMemo.Create(AOwner: TComponent);
begin
  inherited;
  {Use Delphi 2006/2007 color settings for breakpoint and lines}
  BreakpointColor := RGB(199, 199, 255);
  BreakpointTextColor := Font.Color;
  FTempActiveLine := false;
  UpdateActiveLineColors;
  ActiveLineSettings.ActiveLineColor := RGB(204, 153, 153);
  ActiveLineSettings.ActiveLineTextColor := Font.Color;
end;

procedure TIDEMemo.DoExit;
begin
  inherited;
  CheckTempActiveLine;
end;

procedure TIDEMemo.KeyDown(var Key: word; Shift: TShiftState);
begin
  inherited;
  CheckTempActiveLine;
end;

procedure TIDEMemo.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: integer);
begin
  inherited;
  CheckTempActiveLine;
end;

procedure TIDEMemo.CheckTempActiveLine;
begin
  if FTempActiveLine then
  begin
    FTempActiveLine := false;
    ActiveLineSettings.ShowActiveLine := false;
    UpdateActiveLineColors;
  end;
end;

procedure TIDEMemo.UpdateActiveLineColors;
begin
  ActiveLineSettings.ActiveLineColor := RGB(204, 153, 153);
  ActiveLineSettings.ActiveLineTextColor := Font.Color;
end;

{ TIDEProjectFiles }

function TIDEProjectFiles.Add: TIDEProjectFile;
begin
  result := TIDEProjectFile(inherited Add);
end;

function TIDEProjectFiles.Engine: TIDEEngine;
begin
  if GetOwner is TIDEEngine then
    result := TIDEEngine(GetOwner)
  else
    result := nil;
end;

function TIDEProjectFiles.FindByUnitName(AUnitName: string): TIDEProjectFile;
var
  c: integer;
begin
  result := nil;
  for c := 0 to Count - 1 do
    if CompareText(AUnitName, Items[c].UnitName) = 0 then
    begin
      result := items[c];
      break;
    end;
end;

function TIDEProjectFiles.FindByForm(AForm: TScriptForm): TIDEProjectFile;
var
  c: integer;
begin
  result := nil;
  if AForm <> nil then
    for c := 0 to Count - 1 do
      if AForm = Items[c].Form then
      begin
        result := items[c];
        break;
      end;
end;

function TIDEProjectFiles.FindByFormName(
  AFormName: string): TIDEProjectFile;
var
  c: integer;
begin
  result := nil;
  for c := 0 to Count - 1 do
    if (Items[c].Form <> nil) and (CompareText(AFormName, Items[c].Form.Name) = 0) then
    begin
      result := items[c];
      break;
    end;
end;

function TIDEProjectFiles.GetItem(Index: integer): TIDEProjectFile;
begin
  result := TIDEProjectFile(inherited Items[Index]);
end;

function TIDEProjectFiles.FindByScript(
  AScript: TatScript): TIDEProjectFile;
var
  c: integer;
begin
  result := nil;
  for c := 0 to Count - 1 do
    if (Items[c].Script <> nil) and (Items[c].Script = AScript) then
    begin
      result := items[c];
      break;
    end;
end;

{ TIDEProjectFile }

constructor TIDEProjectFile.Create(Collection: TCollection);
begin
  inherited;
  FMemoInfo := TIDEProjectFileMemoInfo.Create;
  FTempScriptLang := slPascal;
  FViewMode := vmUnit;
  if (Engine <> nil) and (Engine.MainUnit = nil) then
    Engine.MainUnit := Self;
end;

destructor TIDEProjectFile.Destroy;
var
  AEngine: TIDEEngine;
  AIndex: integer;
begin
  {Save the reference to Engine before removing this file from files collection}
  AEngine := Engine;
  AIndex := Index;

  {Set project as modified, since a file was removed. But only makes it modified if the
   file was already saved}
  if (Engine <> nil) and FSaved then
    Engine.FProjectModified := true;

  if (Script <> nil) then
  begin
    Script.OnDestroy := FOldScriptDestroy;
  end;

  {Now remove the file from collection}
  inherited;

  {Do this code *after* the ancestor Destroy code, because after that this item
   is already removed from the colletion}

  {Notify Engine that the file was removed. Use saved AEngine reference}
  if (AEngine <> nil) then
  begin
    AEngine.FileRemoved(AIndex);
    if AEngine.MainUnit = Self then
      AEngine.MainUnitRemoved;
  end;

  {Now destroys the form. Must be destroyed after everything, to avoid invalid pointers}
  if FForm <> nil then
  begin
    FForm.Free;
    FForm := nil;
  end;

  {Destroy the script also}
  if Script <> nil then
  begin
    Script.Free;
    Script := nil;
  end;

  FMemoInfo.Free;
end;

function TIDEProjectFile.Engine: TIDEEngine;
begin
  if Files <> nil then
    result := Files.Engine
  else
    result := nil;
end;

function TIDEProjectFile.Files: TIDEProjectFiles;
begin
  if Collection is TIDEProjectFiles then
    result := TIDEProjectFiles(Collection)
  else
    result := nil;
end;

function TIDEProjectFile.FormClassName: string;
begin
  if Form <> nil then
    result := 'T' + Form.Name
  else
    result := '';
end;

function TIDEProjectFile.GetFormFileName: string;
begin
  result := ExtractFileName(FullFormFileName);
end;

function TIDEProjectFile.GetFormResource: string;
begin
  if (Engine <> nil) and (Form <> nil) then
    result := Engine.GetFormResource(Self);
end;

function TIDEProjectFile.GetFullFileName(OnlyRelative: boolean = false): string;
var
  APath: string;
begin
  if IsPathRelative(FFilePath) and not OnlyRelative and not IsPathRelative(Engine.BasePath) and (Engine <> nil) then
    APath := AddPathDelim(Engine.BasePath) + FFilePath
  else
    APath := FFilePath;

  if APath <> '' then
    APath := AddPathDelim(APath);

  result := APath + ChangeFileExt(UnitName, DefaultFileExt);
end;

function TIDEProjectFile.GetFullFormFileName: string;
begin
  result := ChangeFileExt(GetFullFileName, FileExtForm);
end;

procedure TIDEProjectFile.Save;
begin
  if Engine <> nil then
    Engine.SaveFile(Self);
end;

procedure TIDEProjectFile.Load;
begin
  if Engine <> nil then
    Engine.LoadFile(Self);
end;

function TIDEProjectFile.SaveFormToString(ADFMFormat: TDFMFormat = dfmText): string;
var
  ADesigner: TIDEFormDesigner;
  DestroyDesigner: boolean;
begin
  if (Engine <> nil) and (Form <> nil) then
  begin
    ADesigner := Engine.FindDesignerInForm(Form);
    DestroyDesigner := false;
    if ADesigner = nil then
    begin
      ADesigner := TIDEFormDesigner.Create(Form);
      DestroyDesigner := true;
    end;
    try
      result := ADesigner.SaveToString(ADFMFormat);
    finally
      if DestroyDesigner then
        ADesigner.Free;
    end;
    //FMustUpdateScript := true;
  end;
end;

procedure TIDEProjectFile.LoadFormFromString(AString: string;
  ADFMFormat: TDFMFormat = dfmText);
var
  ADesigner: TIDEFormDesigner;
  DestroyDesigner: boolean;
begin
  if (Engine <> nil) and (Form <> nil) then
  begin
    ADesigner := Engine.FindDesignerInForm(Form);
    DestroyDesigner := false;
    if ADesigner = nil then
    begin
      ADesigner := TIDEFormDesigner.Create(Form);
      DestroyDesigner := true;
    end;
    try
      ADesigner.LoadFromString(AString, ADFMFormat);
    finally
      if DestroyDesigner then
        ADesigner.Free;
    end;
    FMustUpdateScript := true;
  end;
end;

procedure TIDEProjectFile.SetForm(const Value: TScriptForm);
begin
  FForm := Value;
  if (Engine <> nil) and (FForm <> nil) then
    FForm.FreeNotification(Engine);
end;

procedure TIDEProjectFile.SetNewUnitName;
var
  AName: string;
  F: TIDEProjectFile;
  c: integer;
begin
  if Files <> nil then
  begin
    c := 1;
    repeat
      AName := Format('Unit%d', [c]);
      F := Files.FindByUnitName(AName);
      inc(c);
    until (F = Self) or (F = nil);

    Self.FUnitName := AName;
    Self.FFilePath := '';
  end;
end;

procedure TIDEProjectFile.SetNewFormName;
var
  c: integer;
  F: TIDEProjectFile;
  AName: string;
  i: integer;
  isnumber: boolean;
begin
  if (Engine <> nil) and (Form <> nil) then
  begin
    {Find the number for the form, based on unit name}
    c := 1;
    AName := Uppercase(UnitName);
    if Pos('UNIT', AName) = 1 then
    begin
      AName := Copy(AName, Length('UNIT') + 1, MaxInt);
      isnumber := true;
      for i := 1 to Length(AName) do
        {$IFDEF DELPHI2009_LVL}
        if not Character.IsDigit(AName[i]) then
        {$ELSE}                                         
        if not (AName[i] in ['0'..'9']) then
        {$ENDIF}
        begin
          isnumber := false;
          break;
        end;

      if isnumber then
        c := StrToInt(AName);
    end;

    {Now find a name that does not repeat in the list of forms}
    repeat
      AName := Format('Form%d', [c]);
      F := Files.FindByFormName(AName);
      inc(c);
    until (F = Self) or (F = nil);
    Form.Name := AName;
  end;
end;

procedure TIDEProjectFile.UpdateFormHeader;
begin
  if Engine <> nil then Engine.BeginUpdateSourceCode;
  try
    if (Script <> nil) and (Form <> nil) then
      Script.Refactor.UpdateFormHeader(FormClassName, FormFileName);
  finally
    if Engine <> nil then Engine.EndUpdateSourceCode;
  end;
end;

procedure TIDEProjectFile.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if Engine <> nil then
      Engine.FileVisibleChanged(Self);
  end;
end;

procedure TIDEProjectFile.ChangeFileName(AFileName: string; NotifyUnitChange: boolean = false);
var
  AOldUnitName: string;
begin
  AOldUnitName := FUnitName;
  FUnitName := ExtractFileName(ChangeFileExt(AFileName, ''));
  if Script <> nil then
    Script.UnitName := FUnitName;

  if (Engine <> nil) and not IsPathRelative(Engine.BasePath) then
    FilePath := ExtractRelativePath(Engine.BasePath, ExtractFilePath(ExpandFileName(AFileName)))
  else
    FilePath := ExtractFilePath(ExpandFileName(AFileName));

  if NotifyUnitChange and (Engine <> nil) then
    Engine.UnitNameChanged(Self, AOldUnitName, FUnitName);
end;

procedure TIDEProjectFile.SetViewMode(Value: TIDEFileViewMode);
begin
  if Form = nil then
    Value := vmUnit;
  if FViewMode <> Value then
  begin
    FViewMode := Value;
    if Engine <> nil then
      Engine.ViewModeChanged(Self);
  end;
end;

function TIDEProjectFile.DefaultFileExt: string;
begin
  result := '';
  if Engine <> nil then
  begin
    Case ScriptLanguage of
      slPascal: result := Engine.FileExtPascalUnit;
      slBasic: result := Engine.FileExtBasicUnit;
    end;
  end;
end;

function TIDEProjectFile.FileExtForm: string;
begin
  if Engine <> nil then
  begin
    result := Engine.FileExtForm;
  end
  else
    result := '';
end;

function TIDEProjectFile.LanguageName: string;
begin
  result := '';
  Case ScriptLanguage of
    slPascal: result := 'Pascal';
    slBasic: result := 'Basic';
  end;
end;

function TIDEProjectFile.ScriptLanguage: TScriptLanguage;
begin
  if Script is TatBasicScript then
    result := slBasic
  else
  if Script is TatPascalScript then
    result := slPascal
  else
    raise EIDEException.Create('Cannot retrieve script language. Unknown script class.');
end;

procedure TIDEProjectFile.CheckUsedUnits;
var
  c: integer;
  AList: TObjectList;
  ARegComp: TIDERegisteredComp;
  UnitList: string;
begin
  if (Script <> nil) and (Form <> nil) and (Engine <> nil) then
  begin
    {First, add the basic units for form}
    UnitList := 'Classes,Graphics,Controls,Forms,Dialogs';

    AList := TObjectList.Create(false);
    try
      {we must fill in the list first, because AddUsedUnits might change the order
       of the components}
      for c := 0 to Form.ComponentCount - 1 do
        AList.Add(Form.Components[c]);

      for c := 0 to AList.Count - 1 do
      begin
        ARegComp := Engine.RegisteredComps.FindByClass(AList[c].ClassType);
        if ARegComp <> nil then
          if Trim(ARegComp.Units) <> ''  then
            UnitList := UnitList + ',' + ARegComp.Units;
      end;
    finally
      AList.Free;
    end;
    Engine.AddUsedUnits(Self, UnitList);
  end;
end;

function TIDEProjectFile.IsForm: boolean;
begin
  result := (Form <> nil);
end;

(*
COMPILATION IS NOT THREAD SAFE FOR NOW, WE CAN'T USE THIS

{ TCompileThread }

constructor TCompileThread.Create(AEngine: TIDEEngine);
begin
  FEngine := AEngine;
  inherited Create(true);
  FreeOnTerminate := true;
end;

destructor TCompileThread.Destroy;
begin
  FEngine.FCompileThread := nil;
  inherited;
end;

procedure TCompileThread.Execute;
begin
  //FEngine.FCompiling := true;
  try
    try
      if (FEngine <> nil) and (FEngine.FScripter <> nil) and
        (FEngine.ActiveScript <> nil) then
      begin
        Synchronize(DoCompile);
        FEngine.ActiveScript.ExpandDebugInfo(false);
      end;
    except
    end;
  finally
    if FEngine <> nil then
      FEngine.FCompiling := false;
    Terminate;
    if Suspended then Resume;
  end;
end;

procedure TCompileThread.DoCompile;
begin
  FEngine.ActiveScript.SilentCompile;
end;

*)

procedure TIDEProjectFile.SetScript(const Value: TatScript);
begin
  FScript := Value;
  if (FScript <> nil) then
  begin
    FOldScriptDestroy := FScript.OnDestroy;
    FScript.OnDestroy := ScriptDestroy;
  end;
end;

procedure TIDEProjectFile.SetUnitName(const Value: string);
begin
  if Engine <> nil then
    Engine.ChangeTabName(Value, FUnitName);
  FUnitName := Value;
  if Script <> nil then
    Script.UnitName := FUnitName;
end;

procedure TIDEProjectFile.ScriptDestroy(Sender: TObject);
begin
  Script := nil;
  if Assigned(FOldScriptDestroy) then
    FOldScriptDestroy(Sender);
end;

{ TIDEEngineOptions }

procedure TIDEEngineOptions.Assign(Source: TPersistent);
begin
  if Source is TIDEEngineOptions then
  begin
    AutoHideTabControl := TIDEEngineOptions(Source).AutoHideTabControl;
  end else
    inherited Assign(Source); 
end;

constructor TIDEEngineOptions.Create(AEngine: TIDEEngine);
begin
  FEngine := AEngine;
  FAutoHideTabControl := true;
end;

{ TIDEScripter }

procedure TIDEScripter.SingleDebugHook(AMachine: TatVirtualMachine);
begin
  if FEngine <> nil then
    FEngine.ShowExecutionPoint;
end;

procedure TIDEScripter.SourceCodeChanged(AScript: TatScript);
begin
  inherited;
  if FEngine <> nil then
    FEngine.ScriptSourceChanged(AScript);
end;

procedure TIDEScripter.DoCompileError(msg: string; row, col: integer;
  var AShow: boolean; AScript: TatScript);
begin
  inherited DoCompileError(msg, row, col, AShow, AScript);
  if FEngine <> nil then
    FEngine.CompileError(msg, row, col, AScript);
end;

procedure TIDEScripter.DoRunningChanged(AMachine: TatVirtualMachine);
begin
  if FEngine <> nil then
    FEngine.RunningChanged;
  inherited;
end;

procedure TIDEScripter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

procedure TIDEScripter.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.Scripter := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.Scripter := Self;
      FEngine.FreeNotification(Self);
    end;
  end;
end;

{ TIDEPaletteButtons }

{$IFDEF DELPHI9_LVL}
procedure TIDEPaletteButtons.CheckImages;
begin
  if not (csDesigning in ComponentState) then
  begin
    if not Assigned(Images) then
    begin
      FImages := TCustomImageList.Create(self);
      FImages.Width := 24;
      FImages.Height := 24;
      Images := FImages;
    end;
  end;

end;

constructor TIDEPaletteButtons.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csActionClient];
  FCatList := TStringList.Create;
  ButtonOptions := [boBoldCaptions, boFullSize, boGradientFill, boShowCaptions,
    boVerticalCategoryCaptions, boUsePlusMinus];
//  ButtonFlow := cbfVertical;
  BevelKind := bkFlat;
  BorderStyle := bsNone;
  ButtonHeight := 29;
  ButtonWidth := 29;
  OnDrawText := ButtonDrawText;
  FCategoryColor := clNone;
  FCategoryColorTo := clNone;
end;

procedure TIDEPaletteButtons.ButtonDrawText(Sender: TObject;
    const Button: TButtonItem; Canvas: TCanvas; Rect: TRect;
    State: TButtonDrawState);
var
  TextRect: TRect;
  AText: string;
  AFilterText: string;
  AText2: string;
  P: integer;
begin
  TextRect := Rect;
  AText := Button.Caption;
  if Filtered and (Filter <> '') then
  begin
    P := Pos(Uppercase(Filter), Uppercase(AText));
    AFilterText := Copy(AText, P, Length(Filter));
    AText2 := Copy(AText, P + Length(Filter), MaxInt);
    AText := Copy(AText, 1, P - 1);

    {Draw first part of text, then bold, then second part}
    if AText > '' then
    begin
      Canvas.Font.Style := Canvas.Font.Style - [fsBold];
      Canvas.TextRect(TextRect, AText, [tfEndEllipsis, tfCalcRect, tfModifyString]);
      Canvas.TextRect(TextRect, AText, [tfEndEllipsis, tfModifyString]);
      TextRect.Left := TextRect.Right;
      TextRect.Right := Rect.Right;
    end;

    Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.TextRect(TextRect, AFilterText, [tfEndEllipsis, tfCalcRect, tfModifyString]);
    Canvas.TextRect(TextRect, AFilterText, [tfEndEllipsis, tfModifyString]);
    TextRect.Left := TextRect.Right;
    TextRect.Right := Rect.Right;

    Canvas.Font.Style := Canvas.Font.Style - [fsBold];
    Canvas.TextRect(TextRect, AText2, [tfEndEllipsis, tfModifyString]);
  end else
    Canvas.TextRect(TextRect, AText, [tfEndEllipsis]);
end;

procedure TIDEPaletteButtons.CreateButton(aCategory: TButtonCategory;
  ControlIndex, index: integer);
Var
  aButton: TIDEPaletteButtonItem;
  aClass: TComponentClass;
  aBitmap: TBitmap;
  aMask: TBitmap;
  AHInstance: integer;
  AScriptInstance: integer;
  AAppInstance: integer;
  AResName: string;
  AHandled: boolean;
begin
  if FEngine <> nil then
  begin
    aClass := FEngine.RegisteredComps[ControlIndex].CompClass;
    aButton := TIDEPaletteButtonItem.Create(aCategory.Items);
    aCategory.Items.AddItem(aButton,index);

    with aButton do
    begin
      FClass := aClass;
      Caption := FEngine.RegisteredComps[ControlIndex].CompClass.ClassName;
      OnClick := PaletteButtonClick;
      if not (boFullSize in ButtonOptions) then
        Hint := Caption;
    end;

    {Now update button image}
    aBitmap := TBitmap.Create;
    aMask := TBitmap.Create;
    try
      if aClass <> nil then
      begin
        {$WARNINGS OFF}
        AHInstance := FindClassHInstance(aClass);
        AScriptInstance := FindClassHInstance(TIDEPaletteButtons);
        AAppInstance := FindHInstance(Application.MainForm);
        AResName := Uppercase(aClass.ClassName);

        AHandled := false;
        if Engine <> nil then
          Engine.DoGetComponentImage(FEngine.RegisteredComps[ControlIndex],
            aBitmap, AHandled);

        if not AHandled then
        begin
          {$WARNINGS OFF}
          if FindResource(AHInstance, PChar(AResName), RT_BITMAP) <> 0 then
          {$WARNINGS ON}
            aBitmap.LoadFromResourceName(AHInstance, AResName)
          else
          {$WARNINGS OFF}
          if FindResource(AScriptInstance, PChar(AResName), RT_BITMAP) <> 0 then
          {$WARNINGS ON}
            aBitmap.LoadFromResourceName(AScriptInstance, AResName)
          else
          {$WARNINGS OFF}
          if FindResource(AAppInstance, PChar(AResName), RT_BITMAP) <> 0 then
          {$WARNINGS ON}
            aBitmap.LoadFromResourceName(AAppInstance, AResName)
          else
            {$WARNINGS OFF}
            if FindResource(AScriptInstance, PChar('TCOMPONENT'), RT_BITMAP) <> 0 then
              aBitmap.LoadFromResourceName(AScriptInstance, 'TCOMPONENT');
            {$WARNINGS ON}
        end;
      end else
      begin
        AHInstance := FindClassHInstance(TIDEPaletteButtons);
        if FindResource(AHInstance, PChar('EDITMODE'), RT_BITMAP) <> 0 then
          aBitmap.LoadFromResourceName(AHInstance, 'EDITMODE');
      end;

      aMask.Assign(aBitmap);
      aMask.Mask(aMask.Canvas.Pixels[0, aMask.Height - 1]);

      if (Images <> nil) and (aBitmap.Width = Images.Width)
        and (aBitmap.Height = Images.Height) then
        aButton.ImageIndex := Images.Add(aBitmap,aMask);
    finally
      aBitmap.Free;
      aMask.Free;
    end;
  end;
end;

function TIDEPaletteButtons.CheckFilterCategory(ACatName, AFilter: string): boolean;
var
  c: integer;
begin
  result := false;
  if FEngine <> nil then
    for c := 0 to FEngine.RegisteredComps.Count - 1 do
    begin
      if SameText(FEngine.RegisteredComps[c].Page, ACatName) and
        ((AFilter = '') or (Pos(Uppercase(AFilter),
          Uppercase(FEngine.RegisteredComps[c].CompClass.ClassName)) > 0)) then
      begin
        result := true;
        break;
      end;
    end;
end;

function TIDEPaletteButtons.CheckFilter(AFilter: string): boolean;
var
  c : integer;
  ACatList: TStrings;
begin
  result := false;
  if FEngine <> nil then
  begin
    ACatList := TStringList.Create;
    try
      FEngine.RegisteredComps.GetPageNames(ACatList);
      for c := 0 to ACatList.Count - 1 do
        if CheckFilterCategory(ACatList[c], AFilter) then
        begin
          result := true;
          break;
        end;
    finally
      ACatList.Free;
    end;
  end;
end;

procedure TIDEPaletteButtons.CreatePalCategory(ACaption: string);
Var
  aCategory: TButtonCategory;
  c, x: integer;
begin
  if FEngine <> nil then
  begin
    {To avoid flicking, first check if the category has buttons, when filtered.
     If not, don't even create the category}
    if not CheckFilterCategory(ACaption, Filter) then
      Exit;

    aCategory := Categories.Add;
    aCategory.Caption := aCaption;
    aCategory.Collapsed := false;
    if CategoryColor <> clNone then
      aCategory.Color := CategoryColor;
    if CategoryColorTo <> clNone then
      aCategory.GradientColor := CategoryColorTo;

    x := 0;
    for c := 0 to FEngine.RegisteredComps.Count - 1 do
    begin
      if SameText(FEngine.RegisteredComps[c].Page, ACaption) and
        (not Filtered or (Filter = '') or (Pos(Uppercase(Filter),
          Uppercase(FEngine.RegisteredComps[c].CompClass.ClassName)) > 0)) then
      begin
        CreateButton(aCategory, c, x);
        inc(x);
      end;
    end;
  end;
end;

destructor TIDEPaletteButtons.Destroy;
begin
  if Assigned(FImages) then
    FImages.Free;
  FCatList.Free;
  inherited;
end;
                                                                  
{$IFDEF DELPHI2009_LVL}
procedure TIDEPaletteButtons.DoItemClicked(const Button: TBaseItem);
{$ELSE}
procedure TIDEPaletteButtons.DoItemClicked(const Button: TButtonItem);
{$ENDIF}
begin
{  if (Button is TIDEPaletteButtonItem) and (Button.Action <> nil) and
    (TDiagramButtonItem(Button).ActionLink <> nil) then
    TDiagramButtonItem(Button).ActionLink.Execute(Self)
  else}
  inherited;
end;

procedure TIDEPaletteButtons.InitiateAction;
var
  c: integer;
  d: integer;
  ItemToSelect: TButtonItem;
begin
  ItemToSelect := nil;
  if (FEngine <> nil) and (FEngine.Designer <> nil) then
    for c := 0 to Categories.Count - 1 do
      for d := 0 to Categories[c].Items.Count - 1 do
        if TIDEPaletteButtonItem(Categories[c].Items[d]).FClass = FEngine.Designer.PlacedComponentClass then
        begin
          ItemToSelect := Categories[c].Items[d];
          break;
        end;

  SelectedItem := ItemToSelect;
end;

procedure TIDEPaletteButtons.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    CheckImages;
    if not (boFullSize in ButtonOptions) then
      ShowHint := true;
    Populate;
  end;
end;

procedure TIDEPaletteButtons.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

procedure TIDEPaletteButtons.PaletteButtonClick(sender: TObject);
begin
  if (FEngine <> nil) and (FEngine.Designer <> nil) then
    FEngine.Designer.PlaceComponentClass(TIDEPaletteButtonItem(FocusedItem).FClass);
end;

procedure TIDEPaletteButtons.Populate;

  procedure FillCatList;
  begin
    FEngine.RegisteredComps.GetPageNames(FCatList);
    //TStringList(FCatList).Sorted := true;
  end;

var
  c : integer;
begin
  if FEngine <> nil then
  begin
    CheckImages;
    FillCatList;
    Categories.Clear;
    for c := 0 to FCatList.Count - 1 do
      CreatePalCategory(FCatList[c]);

    {Auto-select item}
    if Filtered and (Filter > '') and (Categories.Count > 0) and (Categories[0].Items.Count > 0) then
    begin
      FocusedItem := Categories[0].Items[0];
      PaletteButtonClick(FocusedItem);
    end else
      if (FEngine <> nil) and (FEngine.Designer <> nil) then
        FEngine.Designer.CancelPlacing;
  end;
end;

procedure TIDEPaletteButtons.SetCategoryColor(Value: TColor);
begin
  if FCategoryColor <> Value then
  begin
    FCategoryColor := Value;
    UpdateCategoriesColors;
  end;
end;

procedure TIDEPaletteButtons.SetCategoryColorTo(Value: TColor);
begin
  if FCategoryColorTo <> Value then
  begin
    FCategoryColorTo := Value;
    UpdateCategoriesColors;
  end;
end;

{$IFDEF THEMED_IDE}
procedure TIDEPaletteButtons.SetComponentStyle(AStyle: TTMSStyle);
begin
  case AStyle of
    tsOffice2003Blue:
      begin
        Color := $00FDEADA;
        CategoryColor := $00E4AE88;
        CategoryColorTo := $00FDEADA;
        RegularButtonColor := $00EEDBC8;
      end;
    tsOffice2003Silver:
      begin
        Color := $00ECE2E1;
        CategoryColor := $00E7DCD5;
        CategoryColorTo := $00F4F4EE;
        RegularButtonColor := $00F3F3F1;
      end;
    tsOffice2003Olive:
      begin
        Color := $00CFF0EA;
        CategoryColor := $008CC0B1;
        CategoryColorTo := $00CFF0EA;
       RegularButtonColor := $00CFF0EA;
      end;
    tsOffice2003Classic:
      begin
        Color := clWhite;
        CategoryColor := $00C9D1D5;
        CategoryColorTo := clWhite;
        RegularButtonColor := clWhite;
      end;
    tsOffice2007Luna:
      begin
        Color := $00FAF1E9;
        CategoryColor := $00EDD8C7;
        CategoryColorTo := $00F6E9D9;
        RegularButtonColor := $00EEDBC8;
      end;
    tsOffice2007Obsidian:
      begin
        Color := $00ECECE5;
        CategoryColor := $00C5BBB4;
        CategoryColorTo := $00ECECE5;
        RegularButtonColor := $00DFDED6;
      end;
    tsWindowsXP:
      begin
        Color := clBtnFace;
        CategoryColor := clBtnFace;
        CategoryColorTo := clBtnFace;
        RegularButtonColor := clWhite;
      end;
    tsWhidbey:
      begin
        Color := clWhite;
        CategoryColor := $00A8C0C0;
        CategoryColorTo := $00F5F9FA;
        RegularButtonColor := clWhite;
      end;
    tsOffice2007Silver:
      begin
        Color := $00F9F5F3;
        CategoryColor := $00E7DCD5;
        CategoryColorTo := $00F4F4EE;
        RegularButtonColor := $00F3F3F1;
      end;
  end;
  Invalidate;
end;
{$ENDIF}

procedure TIDEPaletteButtons.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.PaletteButtons := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.PaletteButtons := Self;
      FEngine.FreeNotification(Self);
    end;
    Populate;
  end;
end;

procedure TIDEPaletteButtons.SetFiltered(Value: boolean);
begin
  if FFiltered <> Value then
  begin
    if Value and not CheckFilter(FFilter) then
      FFilter := '';
    FFiltered := Value;                
    Populate;
  end;
end;

procedure TIDEPaletteButtons.SetFilter(Value: string);
begin
  if (FFilter <> Value) and CheckFilter(Value) then
  begin
    FFilter := Value;
    Populate;
  end;
end;

procedure TIDEPaletteButtons.UpdateCategoriesColors;
var
  c: integer;
begin
  for c := 0 to Categories.Count - 1 do
  begin
    if FCategoryColor <> clNone then
      Categories[c].Color := FCategoryColor;
    Categories[c].GradientColor := FCategoryColorTo;
  end;
end;

{$ENDIF}

{ TIDEWatchListView }

procedure TIDEWatchListView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

procedure TIDEWatchListView.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    if FEngine <> nil then
    begin
      FEngine.WatchList := nil;
      FEngine.RemoveFreeNotification(Self);
    end;
    FEngine := Value;
    if FEngine <> nil then
    begin
      FEngine.WatchList := Self;
      FEngine.FreeNotification(Self);
    end;
  end;
end;

function TIDEWatchListView.WatchFromItem(AItem: TListItem): TatScripterWatch;
begin
  {$WARNINGS OFF}
  result := TatScripterWatch(AItem.Data);
  {$WARNINGS ON}
end;

procedure TIDEWatchListView.UpdateItem(AItem: TListItem);
var
  AWatch: TatScripterWatch;
  AName: string;
  AValue: string;
begin
  Inc(FUpdatingItem);
  try
    if AItem <> nil then
    begin
      AWatch := WatchFromItem(AItem);
      AName := '(unknown)';
      AValue := '';
      if AWatch <> nil then
      begin
        AWatch.Evaluate;
        AName := AWatch.Expression;
        case AWatch.WatchStatus of
          wsNotEvaluated:
            AValue := '(not evaluated)';
          wsEvaluated:
            try
              AValue := VarToStr(AWatch.LastResult);
            except
              AValue := VarTypeAsText(VarType(AWatch.LastResult));
            end;
          wsCompileError:
            AValue := '(compile error on expression)';
          wsRuntimeError:
            AValue := '(runtime error on expression)';
          wsProcessNotAvailable:
            AValue := '(process not accessible)';
        end;
        AItem.Caption := AName;
        if AItem.Subitems.Count = 0 then
          AItem.SubItems.Add('');
        AItem.SubItems[0] := AValue;
        AItem.Checked := AWatch.Enabled;
      end;
    end;
  finally
    Dec(FUpdatingItem);
  end;
end;

function TIDEWatchListView.AddItemFromWatch(AWatch: TatScripterWatch): TListItem;
begin
  result := Items.Add;
  {$WARNINGS OFF}
  result.Data := AWatch;
  {$WARNINGS ON}
end;

procedure TIDEWatchListView.UpdateList;
var
  c: integer;
begin
  Items.BeginUpdate;
  Inc(FUpdatingItem);
  try
    Items.Clear;
    if Watches <> nil then
      for c := 0 to Watches.Count - 1 do
      begin
        UpdateItem(AddItemFromWatch(Watches[c]));
      end;
  finally
    Dec(FUpdatingItem);
    Items.EndUpdate;
  end;
end;

function TIDEWatchListView.Watches: TatScripterWatches;
begin
  if (Engine <> nil) and (Engine.Scripter <> nil) then
    result := Engine.Scripter.Watches
  else
    result := nil;
end;

constructor TIDEWatchListView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 400;
  Height := 120;
  ViewStyle := vsReport;
  With Columns.Add do
  begin
    Caption := 'Watch name';
    Width := 150;
  end;
  With Columns.Add do
  begin
    Caption := 'Value';
    Width := 240;
    AutoSize := true;
  end;
  RowSelect := true;
  CheckBoxes := true; 
end;

function TIDEWatchListView.AddWatch: TatScripterWatch;
begin
  result := nil;
  if Watches <> nil then
  begin
    result := Watches.Add;
    AddItemFromWatch(result);
  end;
end;

procedure TIDEWatchListView.DeleteSelectedWatches;
var
  c: integer;
begin
  c := 0;
  Items.BeginUpdate;
  try
    while c < Items.Count do
    begin
      if Items[c].Selected then
      begin
        DeleteWatch(WatchFromItem(Items[c]));
      end else
        inc(c);
    end;
  finally
    Items.EndUpdate;
  end;
end;

function TIDEWatchListView.FindItemByWatch(AWatch: TatScripterWatch): TListItem;
var
  c: integer;
begin
  result := nil;
  for c := 0 to Items.Count - 1 do
    if WatchFromItem(Items[c]) = AWatch then
    begin
      result := Items[c];
      break;
    end;
end;

procedure TIDEWatchListView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Shift=[] then
    case Key of
      VK_DELETE:
        begin
          DeleteSelectedWatches;
          Key := 0;
        end;
      VK_INSERT:
        begin
          DlgAddWatch;
          Key := 0;
        end;
      VK_RETURN:
        begin
          DlgEditSelectedWatch;
          Key := 0;
        end;
    end;
  inherited KeyDown(Key, Shift);
end;

function TIDEWatchListView.DlgAddWatch: TatScripterWatch;
begin
  if Engine <> nil then
    Engine.DoBeforeAddWatchDlg;
    
  result := AddWatch;
  if DlgEditWatch(result) then
    UpdateItem(FindItemByWatch(result))
  else
  begin
    DeleteWatch(result);
    result := nil;
  end;
end;

function TIDEWatchListView.DlgEditSelectedWatch: boolean;
begin
  result := false;
  if (Selected <> nil) and (WatchFromItem(Selected) <> nil) then
    result := DlgEditWatch(WatchFromItem(Selected));
end;

function TIDEWatchListView.DlgEditWatch(AWatch: TatScripterWatch): boolean;
var
  WatchForm: TfmWatchProperties;
begin
  WatchForm := TfmWatchProperties.Create(self);
  try
    WatchForm.ScripterWatches := Watches;
    WatchForm.ScripterWatch := AWatch;
    result := WatchForm.ShowModal = mrOk;
    if result then
      UpdateItem(FindItemByWatch(AWatch));
  finally
    WatchForm.Free;
  end;
end;

procedure TIDEWatchListView.DeleteWatch(AWatch: TatScripterWatch);
var
  AItem: TListItem;
begin
  {Destroy the watch and remove the list item}
  AItem := FindItemByWatch(AWatch);
  if AItem <> nil then
    AItem.Free;
  AWatch.Free;
end;

procedure TIDEWatchListView.DblClick;
begin
  inherited;
  DlgEditSelectedWatch;
end;

procedure TIDEWatchListView.Edit(const Item: TLVItem);
var
  AWatch: TatScripterWatch;
begin
  inherited;
  if Selected <> nil then
  begin
    AWatch := WatchFromItem(Selected);
    if AWatch <> nil then
    begin
      AWatch.Expression := Selected.Caption;
      UpdateItem(Selected);
    end;
  end;
end;

procedure TIDEWatchListView.CNNotify(var Message: TWMNotify);
var
  listItem : TListItem;
begin
  case Message.NMHdr^.code of
    LVN_ITEMCHANGED:
      begin
        with PNMListView(Message.NMHdr)^ do
        begin
          if (uChanged and LVIF_STATE) <> 0 then
          begin
            if ((uNewState and LVIS_STATEIMAGEMASK) shr 12) <> ((uOldState and LVIS_STATEIMAGEMASK) shr 12) then
            begin
              listItem := Items[iItem];

              {list item checked}
              if FUpdatingItem = 0 then
              begin
                if WatchFromItem(listItem) <> nil then
                begin
                  WatchFromItem(listItem).Enabled := listItem.Checked;
                  UpdateItem(listItem);
                end;
              end;
            end;
          end;
        end;
      end;
  end;
  inherited;
end;

{ TIDERegisteredComp }

procedure TIDERegisteredComp.SetCompClass(const Value: TComponentClass);
begin
  FCompClass := Value;
  RegisterClass(FCompClass);
end;              

{ TIDEEngineNotifier }

procedure TIDEEngineNotifier.Notification(
  AOperation: TIDENotificationType);
begin
end;

{ TIDEProjectFileMemoInfo }

constructor TIDEProjectFileMemoInfo.Create;
var
  i: integer;
begin
  FBookmarks := TIntList.Create;
  for i := 1 to 10 do
    FBookmarks.Add(-1);
end;

destructor TIDEProjectFileMemoInfo.Destroy;
begin
  FBookmarks.Free;
  inherited;
end;

end.

