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

unit FormDesigner;                              
                                                  
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, IniFiles, AXCtrls, Clipbrd, ExtCtrls, CommCtrl, ComCtrls, StdCtrls,
  Contnrs, DB;                                    

{$I ASCRIPT.INC}

const
  WM_SECONDARYPAINT = WM_USER + 1000;                                          
  WM_DESIGNERMDOWN = WM_USER + 1001;

type
  /// Summary:
  ///   Indicates the position of the control's grab handle.
  TGrabPosition = (                           
    gpNone,             /// Generic one
    gpLeftTop,          /// Left top position                             
    gpLeftMiddle,       /// Left middle position
    gpLeftBottom,       /// Left bottom position
    gpMiddleTop,        /// Middle top position
    gpMiddleBottom,     /// Middle bottom position
    gpRightTop,         /// Right top position
    gpRightMiddle,      /// Right middle position
    gpRightBottom       /// Right bottom position
    );
  
  /// Summary:
  ///   A set of possible grab positions.   
  TGrabPositions = set of TGrabPosition;

  /// Summary:
  ///   Indicates the position of the grabs relative to the control bounds.
  /// Description:
  ///   TGrabMode contains the possible modes for the grabs to be positioned relative to control bounds.
  TGrabMode = (
    gmMiddle,      /// The middle point of the grab will be positioned in the control boundary.
    gmInside,      /// The whole grab will be positioned inside the control boundaries.
    gmOutside      /// The whole grab will be positioned outside the control boundaries.
  );

  TAdvCustomFormDesigner = class;

  /// Summary:
  ///   Container control for non-visual components in designer
  /// Description:
  ///   TComponentContainer is a visual control used as a visual representation for the non-visual controls
  ///   in the designer. When end-user moves a non-visual control in form, he/she is actually moving a TComponentContainer control.
  ///   A reference to the real non-visual component being "edited" is provided in the Component property.
  TComponentContainer = class(TCustomControl)
  private
    FDesigner: TAdvCustomFormDesigner;
    FComponent: TComponent;
    FBitmap: TBitmap;
    FCaption: TStaticText;
    procedure HideControl;
  protected
    procedure Paint; override;
    procedure WndProc(var Msg: TMessage); override;
  public
    /// Summary:
    ///   Creates the component container component with the initial data.
    /// Description:
    ///   CreateWithComponent instantiates the TComponentContainer control with the data needed by it to work,
    ///   for example, the component which will be wrapped by the control. It is called internally by the form
    ///   designer, you don't need to call it directly.
    /// Parameters:
    ///   AOwner - Specifies the control's owner.
    ///   AComponent - The component to be represented by the TComponentContainer.
    ///   ADesigner - The form designer that will use the container.
    ///   AVisible - Defines if container component is visible
    constructor CreateWithComponent(AOwner,AComponent: TComponent; ADesigner: TAdvCustomFormDesigner; AVisible: boolean=true);
    destructor Destroy; override;
    
    /// Summary:
    ///   Performs visual update of the control, like for example the caption below the control showing the component name.
    procedure UpdateContainer;
    
    /// Summary:
    ///   The component represented by the TComponentContainer.
    /// Description:
    ///   Component property contains a reference to the actual non-visual component wrapped by the TComponentContainer.
    property Component: TComponent read FComponent write FComponent;
  end;

  /// Summary:
  ///   A special TReader descendant used by the designer to load/save the form content in streams.
  TFDReader = class(TReader)
  private
    Designer: TAdvCustomFormDesigner;
  protected
    function Error(const Message: string): Boolean; override;
    procedure SetName(Component: TComponent; var Name: string); override;
  public
    /// Summary:
    ///   Creates an instance of the reader.
    /// Description:
    ///   You don't need to instantiate a TFDReader, it's used internally by the form designer component.
    constructor Create(AStream: TStream; ADesigner: TAdvCustomFormDesigner);
  end;

  /// Summary:
  ///   A visual control that represents a grab handle in the designer.
  /// Description:
  ///   TGrabHandle is a graphic control used to represent a grab handle when desiging the form. Each grab is
  ///   a separated control and is painted individually.
  TGrabHandle = class(TCustomControl)
  private
    FPosition: TGrabPosition;
    FRect: TRect;
    FLocked: Boolean;
    procedure SetPosition(Value: TGrabPosition);
    procedure SetRect(Value: TRect);
    procedure SetLocked(Value: Boolean);
    procedure UpdateCoords;
    procedure SetArrowCursor;
  protected
    procedure Paint; override;
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    
    /// Summary:
    ///   Indicates the position of the grab relative to the control position, indicated by Rect property.
    property Position: TGrabPosition read FPosition write SetPosition;
    
    /// Summary:
    ///   Contains the bounds rect of the control, used by the grab handle to position itself in the screen.   
    property Rect: TRect read FRect write SetRect;
    
    /// Summary:
    ///   Indicates if the grab is locked.
    /// Description:
    ///   When the grab is locked it means it can't be moved by the end-user. A locked grab is painted with a 
    ///   different color (grey).
    property Locked: Boolean read FLocked write SetLocked;
  end;

  /// Summary:
  ///   Internal component that encapsulates and represents the grab handles used in form designing.   
  TGrabHandles = class(TComponent)
  private
    FItems: array[TGrabPosition] of TGrabHandle;
    FControl: TControl;
    FVisible: Boolean;
    FEnabled: Boolean;
    procedure SetControl(Value: TControl);
    procedure SetVisible(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    function GetParentForm: TCustomForm;
    function GetDesigner: TAdvCustomFormDesigner;
  public
    constructor Create(AOwner: TComponent); override;
    
    /// Summary:
    ///   Visually updates the grab handles.
    /// Description:
    ///   Update method visually refreshes the the grabs, and also updates the internal properties of each
    ///   TGrabHandle, like Locked for example. 
    /// Parameters:
    ///   MustHide - If true, all grab handles will become invisible. If false, then the visibility of handles will depend on the designer state.   
    procedure Update(MustHide: Boolean);
    
    /// Summary:
    ///   Brings all grab handle controls to front.
    procedure BringToFront;
    
    /// Summary:
    ///   Finds the position of grab handle control specified by AHandle.
    /// Description:
    ///   If you have the window handle of a grab handle control, you can use FindHandle method to discover the 
    ///   grab position that relates to that grab handle control.
    /// Return Value:
    ///   The position of the grab handle. If the window handle does not relate to a grab handle control, result is gpNone.  
    /// Parameters:
    ///   AHandle - Window handle of the grab handle control.
    /// See Also:
    ///   TGrabHandle; FindHandleControl
    function FindHandle(AHandle: HWND): TGrabPosition;

    /// Summary:
    ///   Retrieves the TGrabHandle control related to the window contorl specified by AHandle.
    /// Description:
    ///   If you have the window handle of a grab handle control, you can use FindHandle method to retrieve the 
    ///   TGrabHandle control that relates to that grab handle.
    /// Return Value:
    ///   The TGrabHandle control. If the window handle does not relate to a grab handle control, result is nil.  
    /// Parameters:
    ///   AHandle - Window handle of the grab handle control .
    /// See Also:
    ///   TGrabHandle; FindHandle
    function FindHandleControl(AHandle: HWND): TGrabHandle;
    
    /// Summary:
    ///   Verifies if an specified control is an existing grab handle control.
    /// Description:
    ///   Use IsGrabHandle method to check if an specified control is one of the existing grab handles used by the designer.
    /// Parameters:
    ///   AControl - The control that will be verified to be a grab handle.
    /// Return Value:
    ///   Result is true if AControl is a grab handle control, false otherwise.
    function IsGrabHandle(AControl: TControl): Boolean;
    
    /// Summary:
    ///   Contains the control being edited that will be surrounded by the grab handles.
    property Control: TControl read FControl write SetControl;
    
    /// Summary:
    ///   Indicates if the grab handles are visible.
    /// Description:
    ///   Set Visible property to false to hide the grab handles. Setting Visible property to true does not ensure
    ///   they will be visible, because Enabled property also needs to be set to true.
    /// See also:
    ///   Enabled
    property Visible: Boolean read FVisible write SetVisible;
    
    /// Summary:
    ///   Enable or disable the grab handles. Disabled grab handles mean they are invisible.
    /// Description:
    ///   Set Enabled property to false to hide the grab handles. Setting Enabled property to true does not ensure
    ///   they will be visible, because Visible property also needs to be set to true.
    /// See also:
    ///   Visible
    property Enabled: Boolean read FEnabled write SetEnabled;
    
    /// Summary:
    ///   Retrieves the form being edited by the form designer.
    property ParentForm: TCustomForm read GetParentForm;
    
    /// Summary:
    ///   Retrieves the form designer that owns and controls the grab handles.
    property Designer: TAdvCustomFormDesigner read GetDesigner;
  end;

    /// Summary:
    ///   Type for controls list editor.
  TListType = (ltLocked,ltProtected,ltTransparent);

  /// Summary:
  ///   Specifies the behavior in some control flagging operation, like locking or protecting a control.
  /// Description:
  ///   In form designer you can flag control by putting them in special lists. For example, you can lock
  ///   a control by adding it to TAdvCustomFormDesigner.LockedControls list. When you do that, the
  ///   children of that control might be flagged as well or not, depending on the value of TChildrenMode type.
  TChildrenMode = (
    cmNone,       /// Children are not flagged.
    cmNormal,     /// Only direct children (controls parented by original control) are flagged.
    cmRecurse     /// All children, in a recursive way (children of children, and so on) are flagged.
  );

  /// Summary:
  ///   Specifies the protection mode that applies to controls flagged as protected.
  TProtectMode = (
    pmUnselect,       /// Protected controls cannot be selected (in turn, cannot be moved, resized, deleted).
    pmLockKeyboard    /// Protected controls cannot respond to keyboard actions like resizing or moving from keyboard.
  );

  /// Summary:
  ///   Specifies how the form designer hooks windows messages (specially mouse and keyboard) to process them.
  TMessageProcessor = (
    mpEvent,     /// Attaches an event handler to Application.OnMessage event.
    mpHook       /// Uses SetWindowHookEx API to retrieve windows message. 
  );
       
  /// Summary:
  ///   Indicates the current operation being performed by the mouse.
  TMouseAction = (
    maNone,        /// Nothing is being done, mouse is only browsing.
    maDragging,    /// A control is being dragged by the mouse.
    maSelecting,   /// Mouse is being dragged to build a selection rectangle to select controls in the form.
    maPlacing      /// A new component is being inserted in the form. 
  );

  /// Summary:
  ///   Internal type for hint window offset.
  THintMode = (
    hmCustom,  /// Custom hint.
    hmMove,    /// Hint for move operations (control position).
    hmSize     /// Hint for resize operations (control size).
  );

  /// Summary:
  ///   Internal type indicating the type of grab handle to be painted.
  TGrabType = (
    gtNormal,  /// Normal grab handle, when a single control is selected.
    gtMulti,   /// Normal grab handle in multi-selected mode (more than one control selected).
    gtLocked   /// Locked grab handle.
  );

  /// Summary:
  ///   Enumerates possible ways for aligning selected controls in form designer, either in vertical or horizontal aligning.
  TAlignMode = (
    amNoChange,       /// No change in control positions.
    amLeftTop,        /// Align by left side (for horizontal alignment) or top side (for vertical alignment).  
    amCenters,        /// Align by control center.
    amRightBottom,    /// Align using right side (for horizontal alignment) or bottom side (for vertical alignment).
    amSpace,          /// Space controls equally.
    amWindowCenter    /// Centralize control in parent window.
  );

  /// Summary:
  ///   Enumerates possible ways for resizing selected controls, either in width or height. 
  TSizeMode = (
    smNoChange,      /// No change in control size.
    smToSmallest,    /// Resize to the smallest dimension (width or height).  
    smToLargest,     /// Resize to the largest dimension (width or height).
    smValue          /// Resize to a specified value.                         
  );

  /// Summary:
  ///   Lists some options used to configure the alignment palette used by form designer.   
  TAlignmentPaletteOption = (
    apAutoShow,     /// The alignment palette is automatically displayed when designer is active.
    apStayOnTop,    /// The alignment palette window will stay on top of other windows.
    apShowHints,    /// Show hints of alignment palette buttons.
    apFlatButtons   /// Use flat buttons in alignment palette.
  );
      
  /// Summary:
  ///   Set of applicable options for the alignment palette used by form designer.   
  TAlignmentPaletteOptions = set of TAlignmentPaletteOption;

  /// Summary:
  ///   Indicates the format used to save/load the forms to/from streams and dfm files. 
  TDFMFormat = (
    dfmBinary,    /// Content is is binary format (less space is used than text format).      
    dfmText       /// Content is in readable text format.
  );

  /// Summary:
  ///   Indicates how a control should be treated by the form designer for editing purposes.
  /// See Also:
  ///   TAdvCustomFormDesigner.ProtectedControls; TAdvCustomFormDesigner.LockedControls; TAdvCustomFormDesigner.TransparentControls
  TEditBehaviour = (
    ebDefault,              /// Control can be treated as locked, protected or transparent, depending if the control is
                            /// included in properties like LockedControls, ProtectedControls, etc.. For example, if control
                            /// is included in ProtectedControls, it will be considered as protected. This is the default value.
    ebTransparent,          /// Control will always be treated as transparent.  
    ebLocked,               /// Control will always be treated as locked.
    ebProtected,            /// Control will always be treated as protected.
    ebDefaultRuntime,       /// Same as ebDefault but with runtime mode behavior. In this case, the control does not have its csDesigning flag set. This
                            /// means that the control will not behave as if it was being designed in Delphi form designer, but
                            /// instead it will behave just exactly as in runtime mode.
    ebTransparentRuntime,   /// Same as ebTransparent but with runtime mode behavior.
    ebLockedRuntime         /// Same as ebLocked but with runtime mode behavior.
  );

  /// Summary:
  ///   Enumerates alignment lines used by the form designer. An alignment line is a line that is displayed when 
  ///   the selected controls are being resized/moved in the designer in order to help end-user to have a reference of the controls position.   
  TLinePosition = (
    lpLeft,   /// A vertical line is displayed at the left of selection rectangle. 
    lpTop,    /// A horizontal line is displayed at the top of selection rectangle.
    lpRight,  /// A vertical line is displayed at the right of selection rectangle.
    lpBottom  /// A horizontal line is displayed at the bottom of selection rectangle.
  );
  
  /// Summary:
  ///   Set of alignment line positions to be visible when selected controls are moved/resized in the designer.   
  TLinePositions = set of TLinePosition;

  /// Summary:
  ///   Specifies the boundaries of the mouse cursor when the end-user is moving/resizing the selected controls.    
  TMoveLimitMode = (
    lmCursor,     /// The boundaries of the mouse cursor is determined by the parent of the controls being moved/resized. This is the default.
    lmControls    /// The boundaries of the mouse cursos is determined by the rectangular area occupied by the selected controls. 
  );

  /// Summary:
  ///   An event type that receives a reference to a TControl object.
  /// Description:
  ///   Events of type TControlNotifyEvent are used to provide a reference to a TControl object. Usually the
  ///   control object is a control in the form designer, be it a real control, or a TContainerControl used to wrap a non-visual component.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheControl - The reference to the TControl object. Please note that the control can be a TComponentContainer, in this case
  ///                if you want a reference to the real component, you must typecast the control to TComponentContainer and retrieve
  ///                the component reference.
  /// See Also:
  ///   TComponentContainer
  TControlNotifyEvent = procedure(Sender: TObject; TheControl: TControl) of object;

  /// Summary:
  ///   An event type that receives a reference to a TComponent object.
  /// Description:
  ///   Events of type TComponentNotifyEvent are used to provide a reference to a TComponent object. Usually the
  ///   component is one of the existing components in the form designer.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheComponent - The reference to the TComponent object.
  TComponentNotifyEvent = procedure(Sender: TObject; TheComponent: TComponent) of object;
  
  /// Deprecated event type.
  TLoadSaveEvent = procedure(Sender: TObject; TheControl: TControl; IniFile: TIniFile) of object;
  
  /// Summary:
  ///   An event type used to handle windows messages.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   Msg - Record containg the message to be handle.
  TDesignerMessageEvent = procedure(Sender: TObject; var Msg: TMsg) of object;
  
  /// Summary:
  ///   TMoveLimitEvent type is used to retrieve a rect with move limit boundaries.
  /// Description:
  ///   When a control is being moved, you can provide the valid rectangle in which the moving operation can be performed.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheControl - The control object being moved. Be sure to check if the control is a TComponentContainer.
  ///   LimitRect - Set this parameter to provide the rectangle in which the control can be moved.
  TMoveLimitEvent = procedure(Sender: TObject; TheControl: TControl; var LimitRect: TRect) of object;

  /// Summary:
  ///   TSizeLimitEvent type is used to provide minimum and maximum width and height for the control being resized.
  /// Description:
  ///   When a control is being resized, you can provide the minimum and maximum sizes for its dimensions, using this event.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheControl - The control object being resized. Be sure to check if the control is a TComponentContainer.
  ///   MinSize - Set this parameter to provide the minimum width (X) and height (Y) for the control.
  ///   MaxSize - Set this parameter to provide the maximum width (X) and height (Y) for the control.
  TSizeLimitEvent = procedure(Sender: TObject; TheControl: TControl; var MinSize,MaxSize: TPoint) of object;
  
  /// Summary:
  ///   Allows specifying which grab handles will be visible/invisible and enabled/disabled.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   VisibleGrabs - Set this parameter to specify which grab handles will be visible in the form designer. 
  ///   EnabledGrabs - Set this parameter to specify which grab handles will be enabled in the form designer.
  /// See Also:
  ///   TGrabPositions; TGrabHandle
  TCustomizeGrabsEvent = procedure(Sender: TObject; var VisibleGrabs,EnabledGrabs: TGrabPositions) of object;
  
  /// Summary:
  ///   Event used to provide a text string associated with a specified component. Usually used to provide caption or hint for a component.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheComponent - The TComponent object for which the text will be associated.
  ///   Text - Must receive the text associated with the component.
  TComponentTextEvent = procedure(Sender: TObject; TheComponent: TComponent; var Text: string) of object;
  
  /// Summary:
  ///   Event used to provide a bitmap associated with a specified component. Can be used, for example, to set an 
  ///   icon for the non-visual components.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheComponent - The component for which the bitmap will be associated.
  ///   Bitmap - The bitmap object associated with the component. You don't need to create/destroy the bitmap, just update its content. 
  TComponentBitmapEvent = procedure(Sender: TObject; TheComponent: TComponent; const Bitmap: TBitmap) of object;
  
  /// Summary:
  ///   Allows programmer to define if a specified non-visual component is editable or not.
  /// Description:
  ///   This event is used to allow the programmer to define which non-visual components are editable or not. If the 
  ///   component is defined as not editable, it will not even appear in the form designer.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheComponent - A reference for the non-visual component belonging to the form.
  ///   Editable - Set this parameter to specify if the non-visual component can be edited (is visible) in the form designer. 
  TComponentEditableEvent = procedure(Sender: TObject; TheComponent: TComponent; var Editable: Boolean) of object;
  
  /// Summary:
  ///   Event fired when a clipboard operation (copy or paste) is performed for the specified component.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheComponent - The TComponent object being copied or pasted.
  TComponentClipboardEvent = procedure(Sender: TObject; TheComponent: TComponent) of object;
  
  /// Summary:
  ///   TComponentPopupEvent is fired when the end-user performs a right-click in the form designer. This is an opportunity
  ///   to popup your own menu, or even perform a different operation.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   Handled - Set Handled to true if you have performed your custom operation and don't want the default popup menu to 
  ///             appear. If Handled false, the designer will show the popup menu.
  TComponentPopupEvent = procedure(Sender: TObject; var Handled: Boolean) of object;
  
  /// Summary:
  ///   This event is fired for every control being edited in form designer, and allows programmer to specify the
  ///   edit behavior for each individual control.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   TheComponent - The component object which edit behavior will be set.
  ///   Behaviour - Must receive the desired edit behaviour for the component.
  /// See Also:
  ///   TEditBehaviour
  TComponentBehaviourEvent = procedure(Sender: TObject; TheComponent: TComponent; var Behaviour: TEditBehaviour) of object;
  
  /// Summary:
  ///   Events of this type allows the programmer to provide a rectangle/boundaries value.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   R - Must contain the TRect value.
  TRectEvent = procedure(Sender: TObject; var R: TRect) of object;
  
  /// Summary:
  ///   Events of this type can receive a reference to a form object.
  /// Parameters:
  ///   Sender - Object firing the event.
  ///   Form - A reference to the form object.
  TFormEvent = procedure(Sender: TObject; Form: TForm) of object;

  TIDEComponentEditor = class;

  /// Summary:
  ///   Component used to allow runtime form design.
  /// Description:
  ///   TAdvCustomFormDesigner is the base class for TAdvFormDesigner component, used to allow designing of forms at runtime.
  ///   The component must always be owned by the form that must be edited. You can turn designing on and off using the 
  ///   Active property. This component provides several properties and events for customizing the way the form is being edited.
  ///   Several methods are provided to persist form changes, like saving and loading the form to streams and files.
  ///   In Scripter Studio Pro IDE, this component is used internally by the inplace form designer.
  TAdvCustomFormDesigner = class(TComponent)
  private
    { Private declarations }
    FDefaultProc: TFarProc;
    FWinProc: Pointer;
    FBkgBitmap: TBitmap;
    FForm: TCustomForm;
    FAPForm: TForm;
    FHintControl: TControl;
    FHintTimer: TTimer;
    FIgnoreMouseMove: Boolean;
    FKeySelect: Boolean;
    FKeyMove: Boolean;
    FClearBeforeLoad: Boolean;
    FMustClear: Boolean;
    FGrabSize: Integer;
    FNormalGrabBorder: TColor;
    FNormalGrabFill: TColor;
    FMultiGrabBorder: TColor;
    FMultiGrabFill: TColor;
    FLockedGrabBorder: TColor;
    FLockedGrabFill: TColor;
    FNormalGrab: TBitmap;
    FNormalGrabGlyph: TBitmap;
    FMultiGrab: TBitmap;
    FMultiGrabGlyph: TBitmap;
    FLockedGrab: TBitmap;
    FLockedGrabGlyph: TBitmap;
    FHintWindow: THintWindow;
    FCanvas: TCanvas;
    FClickPos: TPoint;
    //FDefaultColor: TColor;
    FActive: Boolean;
    FMessageProcessor: TMessageProcessor;
    FLockCounter: Integer;
    FSynchroLockCounter: Integer;
    FWaiting: Boolean;
    FPlacingParent: TWinControl;
    //FPlacedComponent: TComponent;
    FPlacedComponentClass: TComponentClass;
    FControls: TList;
    FDesignControl: TWinControl;
    FSelectControl: TWinControl;
    FMenuControl: TControl;
    FGrabHandles: TGrabHandles;
    {$IFDEF GFDADVANCEDGRID}
    FGridStepX: Integer;
    FGridStepY: Integer;
    {$ELSE}
    FGridStep: Integer;
    {$ENDIF}
    FSnapToGrid: Boolean;
    FSnapToGridKey: Boolean;
    FDisplayGrid: Boolean;
    FDesignerColor: TColor;
    FGridColor: TColor;
    FPopupMenu: TPopupMenu;
    FPopupItems: TObjectList;
    FLockedControls: TStrings;
    FLockedInverse: Boolean;
    FLockChildren: TChildrenMode;
    FProtectedControls: TStrings;
    FProtectedInverse: Boolean;
    FProtectChildren: TChildrenMode;
    FProtectMode: TProtectMode;
    FTransparentControls: TStrings;
    FTransparentInverse: Boolean;
    FTransparentChildren: TChildrenMode;
    FShowMoveSizeHint: Boolean;
    FShowComponentHint: Boolean;
    FAlignmentPalette: TAlignmentPaletteOptions;
    FMouseAction: TMouseAction;
    FDragPoint: TPoint;
    FDragRect: TRect;
    FSelectRect: TRect;
    FPlacingRect: TRect;
    FSelectCounter: Integer;
    FDragHandle: TGrabPosition;
    FShowNonVisual: Boolean;
    FShowComponentCaptions: Boolean;
    FMultiSelect: Boolean;
    FModified: Boolean;
    FEnableAxisDrag: Boolean;
    FGrabMode: TGrabMode;
    FUseGrabGlyphs: Boolean;
    FGrabsTransparentColor: TColor;
    FAlignmentEntireForm: Boolean;
    FAlignmentLines: TLinePositions;
    FAlignmentColorLeft: TColor;
    FAlignmentColorTop: TColor;
    FAlignmentColorRight: TColor;
    FAlignmentColorBottom: TColor;
    FMoveLimitMode: TMoveLimitMode;
    FAncestor: TComponent;
    FOnMoveSizeControl: TControlNotifyEvent;
    FOnChange: TNotifyEvent;
    FOnLoadControl: TLoadSaveEvent;
    FOnSaveControl: TLoadSaveEvent;
    FOnSelectControl: TControlNotifyEvent;
    FOnSelectionChange: TNotifyEvent;         
    FOnControlDblClick: TControlNotifyEvent;
    FOnAddControl: TControlNotifyEvent;
    FOnDeleteControl: TControlNotifyEvent;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnKeyDown: TKeyEvent;
    FOnKeyUp: TKeyEvent;
    FOnMessage: TDesignerMessageEvent;
    FOnMoveLimit: TMoveLimitEvent;
    FOnSizeLimit: TSizeLimitEvent;
    FOnReadError: TReaderError;
    FOnCustomizeGrabs: TCustomizeGrabsEvent;
    FOnComponentHint: TComponentTextEvent;
    FOnComponentCaption: TComponentTextEvent;
    FOnComponentBitmap: TComponentBitmapEvent;
    FOnComponentEditable: TComponentEditableEvent;
    FOnCopyComponent: TComponentClipboardEvent;
    FOnPasteComponent: TComponentClipboardEvent;
    FOnContextPopup: TComponentPopupEvent;
    FOnEditBehaviour: TComponentBehaviourEvent;
    FOnPlaceComponent: TComponentNotifyEvent;
    FOnEndPlacing: TRectEvent;
    FOnEndSelecting: TRectEvent;
    FOnShowAlignmentPalette: TFormEvent;
    FUpdatingSelection: integer;
    FAvoidFormMoving: boolean;
    // properties access methods
    function GetControlCount: Integer;
    function GetLocked: Boolean;
    function GetSynchroLocked: Boolean;
    function GetParentForm: TCustomForm;
    procedure SetParentForm(const Value: TCustomForm);
    function GetFormData: string;
    procedure SetFormData(const Value: string);
    procedure SetActive(Value: Boolean);
    procedure SetMessageProcessor(Value: TMessageProcessor);
    function GetControl: TControl;
    procedure SetControl(Value: TControl);
    function GetControlByIndex(Index: Integer): TControl;
    function GetComponent: TComponent;
    procedure SetComponent(Value: TComponent);
    function GetComponentByIndex(Index: Integer): TComponent;
    {$IFDEF GFDADVANCEDGRID}
    procedure SetGridStepX(Value: Integer);
    procedure SetGridStepY(Value: Integer);
    {$ELSE}
    procedure SetGridStep(Value: Integer);
    {$ENDIF}
    procedure SetDisplayGrid(Value: Boolean);
    procedure SetDesignerColor(Value: TColor);
    procedure SetGridColor(Value: TColor);
    procedure SetLockedControls(Value: TStrings);
    procedure SetLockedInverse(Value: Boolean);
    procedure SetLockChildren(Value: TChildrenMode);
    procedure SetProtectedControls(Value: TStrings);
    procedure SetProtectedInverse(Value: Boolean);
    procedure SetProtectChildren(Value: TChildrenMode);
    procedure SetProtectMode(Value: TProtectMode);
    procedure SetTransparentControls(Value: TStrings);
    procedure SetTransparentInverse(Value: Boolean);
    procedure SetTransparentChildren(Value: TChildrenMode);
    procedure SetMoveSizeHint(Value: Boolean);
    procedure SetComponentHint(Value: Boolean);
    procedure SetGrabSize(Value: Integer);
    procedure SetAlignmentPalette(Value: TAlignmentPaletteOptions);
    procedure SetNormalGrabBorder(Value: TColor);
    procedure SetNormalGrabFill(Value: TColor);
    procedure SetNormalGrabGlyph(Value: TBitmap);
    procedure SetMultiGrabBorder(Value: TColor);
    procedure SetMultiGrabFill(Value: TColor);
    procedure SetMultiGrabGlyph(Value: TBitmap);
    procedure SetLockedGrabBorder(Value: TColor);
    procedure SetLockedGrabFill(Value: TColor);
    procedure SetLockedGrabGlyph(Value: TBitmap);
    procedure SetShowNonVisual(const Value: Boolean);
    procedure SetShowComponentCaptions(const Value: Boolean);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetDesignControl(const Value: TWinControl);
    procedure SetGrabMode(const Value: TGrabMode);
    procedure SetUseGrabGlyphs(const Value: Boolean);
    procedure SetGrabsTransparentColor(const Value: TColor);
    // internal methods
    procedure ApplicationIdle(Sender: TObject; var Done: Boolean);
    procedure ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
    procedure TimerEvent(Sender: TObject);
    procedure StartTimer(AInterval: Integer);
    procedure StopTimer;
    procedure DrawPlacingRect;
    procedure DrawSelectRect;
    procedure DrawDragRects;
    procedure DrawMultiSelect(AControl: TControl);
    function InTheList(List: TStrings; AControl: TControl): Boolean;
    procedure ShowHint(AHint: string; Mode: THintMode);
    procedure HideHint;
    function GetControlsOrigin: TPoint;
    function CheckParent(AControl: TControl; DisableLocked: Boolean): Boolean;
    procedure SetArrowCursor;
    function ValidControl(AControl: TControl): Boolean;
    procedure CreateContainers;
    procedure DestroyContainers;
    procedure ContainersToDesignInfo;
    procedure DesignInfoToContainers;

    procedure UpdateContainers;
    function InParentForm(WND: HWND): Boolean;
    {$IFDEF TFDTRIAL}
    procedure ShowTrialWarning;
    {$ENDIF}
    // event handler for TStringList.OnChange
    procedure ListChange(Sender: TObject);
    // the new window procedure
    procedure WinProc(var Message: TMessage);
    procedure BuildContextItems(AComp: TComponent; APopup: TPopupMenu);
    procedure ContextPopupItemClick(Sender: TObject);
    procedure PerformComponentPlacing(AParentControl: TWinControl;
      APlacingRect: TRect);
  protected
    /// Summary:
    ///   Retrieves the TIDEComponentEditor object (if any) registered for a component being edited.
    /// Description:
    ///   GetIDEComponentEditor retrieves a reference to a TIDEComponentEditor object applicable to the specified component.
    ///   If the object instance is not created, this method automatically creates it. The form designer takes care
    ///   of the object destruction. The correct editor retrieved depends on what has been previously registered with
    ///   RegisteredIDEComponentEditor.
    /// Parameters:
    ///   AComp - The component for which the component editor will be provided.
    /// Return Value:
    ///   A valid instance of TIDEComponentEditor. If the component has no registered editor, result is nil.
    /// See Also:
    ///   RegisterIDEComponentEditor                                    
    function GetIDEComponentEditor(AComp: TComponent): TIDEComponentEditor;
    
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    
    /// Summary:
    ///   The message handler method used by the form designer to handle hooked application messages.
    procedure MessageProc(var Msg: TMSG); virtual;
    
    /// Summary:
    ///   This method is called when a moving or sizing operation is performed in the designer. This method fires
    ///   the OnMoveSizeControl event for each selected control. 
    procedure DoMoveSizeControl; virtual;
    
    /// Summary:
    ///   DoChange method is called when the form content has changed (a control was moved, resized, deleted, etc.). 
    procedure DoChange; virtual;
    
    /// Summary:
    ///   Deprecated. Most appropriated method is DoAddControl.
    procedure DoSelectControl(AControl: TControl); virtual;
    
    /// Summary:
    ///   DoSelectionChange method is called when the current selection in form designer changes.
    procedure DoSelectionChange; virtual;
    
    /// Summary:
    ///   DoAddControl is called when a new control is added to the current selection in the form designer.
    ///   In other words, it is called when a control is selected.
    /// Parameters:
    ///   AControl - The control which has been added to the selection.
    procedure DoAddControl(AControl: TControl); virtual;
    
    /// Summary:
    ///   DoDeleteControl is called when a control is removed from the current selection in the form designer.
    ///   In other words, it is called when a control is unselected.
    /// Parameters:
    ///   AControl - The control which has been removed from the selection.
    procedure DoDeleteControl(AControl: TControl); virtual;
    
    /// Summary:
    ///   This method is called when a control is double clicked in the form designer.
    /// Parameters:
    ///   AControl - The control which has been double clicked.
    procedure DoControlDblClick(AControl: TControl); virtual;
    
    /// Summary:
    ///   This method is called just before a new component is placed and selected in the form designer. When 
    ///   DoBeforePlaceComponent is called, the component being placed is not yet selected.
    /// Parameters:
    ///   AComponent - the component that is about to be placed in the form.
    procedure DoBeforePlaceComponent(AComponent: TComponent); virtual;
    
    /// Summary:
    ///   DoPlaceComponent is called right after a new component is placed and selected in the form designer.
    /// Parameters:
    ///   AComponent - the component that has been placed in the form.
    procedure DoPlaceComponent(AComponent: TComponent); virtual;
    
    /// Summary:
    ///   GetEditBehaviour retrieves the edit behavior for a control being edited in the form.
    /// Parameters:                                   
    ///   AControl - the control for which the edit behavior will be retrieved.
    /// Return Value:                                      
    ///   Returns the edit behavior for the specified control.
    function GetEditBehaviour(AControl: TControl): TEditBehaviour; virtual;
    {$IFDEF TFD1COMPATIBLE}
    property OnDragControl: TControlNotifyEvent read FOnMoveSizeControl write FOnMoveSizeControl;
    {$ELSE}
    
    /// Summary:
    ///   OnMoveSizeControl event is fired right after a control is moved or resized in the form designer.
    property OnMoveSizeControl: TControlNotifyEvent read FOnMoveSizeControl write FOnMoveSizeControl;
    {$ENDIF}
    
    /// Summary:
    ///   OnChange event is fired whenever a change is performed in the form designer.
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    
    /// Summary:
    ///   Deprecated
    property OnLoadControl: TLoadSaveEvent read FOnLoadControl write FOnLoadControl;
    /// Summary:
    ///   Deprecated
    property OnSaveControl: TLoadSaveEvent read FOnSaveControl write FOnSaveControl;
    /// Summary:
    ///   Deprecated
    property OnSelectControl: TControlNotifyEvent read FOnSelectControl write FOnSelectControl;
    
    /// Summary:
    ///   OnSelectionChange is fired whenever the current selection changes in the form designer, i.e., when
    ///   a component is selected or unselected.
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    
    /// Summary:
    ///   OnControlDblClick is fired when a control is double clicked in the form designer. The control which was
    ///   double clicked is provided by the event.
    property OnControlDblClick: TControlNotifyEvent read FOnControlDblClick write FOnControlDblClick;
    
    /// Summary:
    ///   OnAddControl event is fired when a control is added to the current selection. In other words, the event is fired
    ///   when a control is selected in the form designer. 
    property OnAddControl: TControlNotifyEvent read FOnAddControl write FOnAddControl;

    /// Summary:
    ///   OnDeleteControl event is fired when a control is removed from the current selection. In other words, the event is fired
    ///   when a control is unselected in the form designer. 
    property OnDeleteControl: TControlNotifyEvent read FOnDeleteControl write FOnDeleteControl;
    
    /// Summary:
    ///   OnActivate event is fired when the form designer is activated, and the form enters into design/edit mode.
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;

    /// Summary:
    ///   OnDeactivate event is fired when the form designer is deactivated, and the form exits the design/edit mode, entering
    ///   into the normal runtime mode.
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    
    /// Summary:
    ///   OnKeyDown is fired when a key is pressed during form editing.
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;

    /// Summary:
    ///   OnKeyUp is fired when a key is released during form editing.
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;      
    
    /// Summary:
    ///   OnMessage is a custom opportunity to handle window messages hooked by the form designer. You will rarely need to use this event.
    property OnMessage: TDesignerMessageEvent read FOnMessage write FOnMessage;
    
    /// Summary:
    ///   OnMoveLimit event is fired by the form designer when a component is being moved, to allow the programmer to provide
    ///   the limit boundaries for the control. 
    property OnMoveLimit: TMoveLimitEvent read FOnMoveLimit write FOnMoveLimit;

    /// Summary:
    ///   OnSizeLimit event is fired by the form designer when a component is being resized, to allow the programmer to provide
    ///   the size limits for the control. 
    property OnSizeLimit: TSizeLimitEvent read FOnSizeLimit write FOnSizeLimit;
    
    /// Summary:
    ///   OnReadError event is fired when an error occurs while trying to load the form from a stream or file.
    property OnReadError: TReaderError read FOnReadError write FOnReadError;
    
    /// Summary:
    ///   OnCustomizeGrabs event is fired by the form designer to allow programmer to specify which grab handles
    ///   will be visible and/or enabled in the form designer.
    property OnCustomizeGrabs: TCustomizeGrabsEvent read FOnCustomizeGrabs write FOnCustomizeGrabs;
    
    /// Summary:
    ///   Use OnComponentHint event to provide a text hint for the component provided by the event.
    ///   By defaul the component hint shows its name and class name.
    property OnComponentHint: TComponentTextEvent read FOnComponentHint write FOnComponentHint;

    /// Summary:
    ///   Use OnComponentCaption event to provide a custom caption for the component provided by the event.
    ///   By default, the component caption is the name of the component or the class name (in case component doesn't have a name).
    property OnComponentCaption: TComponentTextEvent read FOnComponentCaption write FOnComponentCaption;
    
    /// Summary:
    ///   Use OnComponentBitmap to provide a custom icon for the non-visual component specified in the event.
    ///   If this event is not assigned, then the designer tries to retrieve the component bitmap from a bitmap resource 
    ///   which name is the same as the component's class name.
    property OnComponentBitmap: TComponentBitmapEvent read FOnComponentBitmap write FOnComponentBitmap;
    
    /// Summary:
    ///   OnComponentEditable event is fired for every non-visual component in the form to allow the programmer
    ///   to inform if the specified component is editable (visible) or not. By default all components are editable, 
    ///   except some special classes like TMenuItem and the TAdvCustomFormDesigner itself (which is owned by form).
    property OnComponentEditable: TComponentEditableEvent read FOnComponentEditable write FOnComponentEditable;
    
    /// Summary:                                                           
    ///   This event is fired whenever a component is copied (or cut) to clipboard.   
    property OnCopyComponent: TComponentClipboardEvent read FOnCopyComponent write FOnCopyComponent;
    
    /// Summary:
    ///   This event is fired whenever a component is pasted from clipboard.
    property OnPasteComponent: TComponentClipboardEvent read FOnPasteComponent write FOnPasteComponent;
    
    /// Summary:
    ///   This event is fired when a mouse right click is performed in the designer, and allows the programmer to 
    ///   do a different operation than just showing the default popup menu.
    property OnContextPopup: TComponentPopupEvent read FOnContextPopup write FOnContextPopup;
    
    /// Summary:
    ///   OnEditBehaviour is fired by the designer to retrieve the edit behavior for the specified component.
    /// See Also:
    ///   TEditBehaviour
    property OnEditBehaviour: TComponentBehaviourEvent read FOnEditBehaviour write FOnEditBehaviour;
    
    /// Summary:
    ///   OnPlaceComponent is fired right after a new component is placed (inserted) in the form.
    property OnPlaceComponent: TComponentNotifyEvent read FOnPlaceComponent write FOnPlaceComponent;
    
    /// Summary:
    ///   OnEndPlacing is fired when a place operation is about to be finished, but before the component is effectively
    ///   placed in the form. This is an opportunity to change the position where the component will be placed.
    ///   The event handler receives a rect with the position where the component will be placed, and can change that value.
    property OnEndPlacing: TRectEvent read FOnEndPlacing write FOnEndPlacing;
    
    /// Summary:
    ///   OnEndSelecting is fired when a selection operation using a selection drag rect is about to be performed.
    ///   All the controls in the selection rect will be selected, and this is an opportunity to change the value of the
    ///   selection rect before the selection happens.
    property OnEndSelecting: TRectEvent read FOnEndSelecting write FOnEndSelecting;
    
    /// Summary:
    ///   This event is fired when the alignment palette form is displayed. The palette form is provided to the event handler.    
    property OnShowAlignmentPalette: TFormEvent read FOnShowAlignmentPalette write FOnShowAlignmentPalette;
    
    /// Summary:
    ///   If greater than zero, indicates that the changes in the current selection are being performed by internal 
    ///   operations of the form designer, not by the end-user.
    property UpdatingSelection: integer read FUpdatingSelection;
  public
    /// Summary:
    ///   Deletes all components in the form.
    procedure ClearForm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    /// Summary:
    ///   Update method refreshes the form designer, updating its visual elements like the grab handles and non-visual
    ///   component icon and caption.
    procedure Update; virtual;
    
    /// Summary:
    ///   Updates (refreshes) the snap grid.
    procedure UpdateGrid;
    
    /// Summary:
    ///   Create objects instantiate some internal objects needed by the form designer, like the hint window and grab glyphs.
    ///   You will rarely need to call this method.
    procedure CreateObjects;
    
    /// Summary:
    ///   Destroyes objects created by CreateObjects method.
    procedure DestroyObjects;
    
    /// Summary:
    ///   Call IsLocked to determine if the control specified by AControl is locked or not. A locked control cannot be moved or resized.
    /// Return Value:
    ///   True if control is locked, false otherwise.
    /// See Also:
    ///   LockedControls
    function IsLocked(AControl: TControl): Boolean;

    /// Summary:
    ///   Call IsProtected to determine if the control specified by AControl is protected or not. 
    ///   A protected control cannot be selected.
    /// Return Value:    
    ///   True if control is protected, false otherwise.
    /// See Also:
    ///   ProtectedControls
    function IsProtected(AControl: TControl): Boolean;

    /// Summary:
    ///   Call IsTransparent to determine if the control specified by AControl is transparent or not. 
    ///   A transparent control is totally ignored by the designer, cannot be selected, edited or deleted, its behavior is
    ///   exactly as if it was part of the form's background.
    /// Return Value:    
    ///   True if control is transparent, false otherwise.
    /// See Also:
    ///   TransparentControls
    function IsTransparent(AControl: TControl): Boolean;
    
    /// Summary:
    ///   Use FindNextControl to retrieves the next control to be selected given the current selection. 
    /// Parameters:
    ///   GoForward - If true, the method returns the next control. If false, the method returns the previous control.
    /// Return Value:
    ///   The instance of control to be selected after the current selection.
    function FindNextControl(GoForward: Boolean): TControl;
    
    /// Summary:
    ///   Returns the control found at an specified position in the form.
    /// Description:
    ///   The method searches for a control belonging to a specified parent. This method is not recursive, which means
    ///   that only direct children of the parent are searched.
    /// Parameters:
    ///   AParent - Specifies the parent control containing the controls to be searched. The method will only look "inside"
    ///             the specified parent, and will ignore other controls. If AParent is nil, the form being edited is used.
    ///   P - The position in which the control will be searched. This value must be in parent's coordinates, (0, 0) being the
    ///       the upper left of the specified control.
    /// Return Value:
    ///   The control found at the specified position.
    function ControlAtPos(AParent: TWinControl; P: TPoint): TControl;
    
    /// Summary:
    ///   Finds a control in the form given its window handle.
    /// Parameters:
    ///   Wnd - The window handle of the control.
    /// Return Value:
    ///   The control instance which window handle matches the handle provided in the parameter.
    function FindWinControl(Wnd: DWORD): TWinControl;
    
    /// Summary:
    ///   Finds the component container control for a non-visual component in the form.
    /// Parameter:
    ///   AComponent - The non-visual component for which we want to find the component container.
    /// Return Value:
    ///   The component container for the component. If the component doesn't have a component container, result is nil.
    function FindComponentContainer(AComponent: TComponent): TComponentContainer;
    
    /// Summary:
    ///   Deprecated method. Use SaveToDfm or SaveToStream instead.
    procedure SaveToFile(FileName: string);

    /// Summary:
    ///   Deprecated method. Use LoadFromDfm or LoadFromStream instead.
    procedure LoadFromFile(FileName: string);
    
    /// Summary:
    ///   Saves the form to a file.
    /// Parameters:
    ///   FileName - The name of the file to be saved.
    ///   DFMFormat - Indicates the file format, binary or text.
    procedure SaveToDFM(FileName: string; DFMFormat: TDFMFormat);

    /// Summary:
    ///   Loads the form from a file. 
    /// Description:
    ///   This method loads the form from a file. All existing controls in the form will be deleted, unless 
    ///   ClearBeforeLoad property is set to false. 
    /// Parameters:
    ///   FileName - The name of the file to loaded.
    ///   DFMFormat - Indicates the file format, binary or text.
    procedure LoadFromDFM(FileName: string; DFMFormat: TDFMFormat);
    
    /// Summary:
    ///   Saves a specific component to a stream.
    /// Parameters:
    ///   Stream - The stream used to save the component to.
    ///   Component - The component to be saved to the stream.
    ///   DFMFormat - The format of content to be saved to stream.
    procedure SaveComponentToStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat);
    
    /// Summary:
    ///   Loads a specific component from a stream.
    /// Parameters:
    ///   Stream - The stream used to load the component from.
    ///   Component - The component to be loaded from the stream.
    ///   DFMFormat - The format of content to be loaded from the stream.
    function LoadComponentFromStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat): TComponent;
    
    /// Summary:
    ///   Saves the form to a stream.
    /// Parameters:
    ///   Stream - The stream object where the form will be saved to.
    ///   DFMFormat - Indicates the content format, binary or text.
    procedure SaveToStream(Stream: TStream; DFMFormat: TDFMFormat);
                                                                    
    /// Summary:                                                     
    ///   Loads the form from a stream.
    /// Parameters:                                                   
    ///   Stream - The stream object where the form will be loaded from.
    ///   DFMFormat - Indicates the content format, binary or text.
    procedure LoadFromStream(Stream: TStream; DFMFormat: TDFMFormat);
    
    /// Summary:
    ///   Returns true if a copy (or cut) to clipboard operation can be performed by the designer. 
    function CanCopy: Boolean;

    /// Summary:
    ///   Returns true if a paste from clipboard operation can be performed by the designer. 
    function CanPaste: Boolean;
    
    /// Summary:
    ///   Copies the currently selected components to the clipboard.
    procedure CopyToClipboard;
                                                 
    /// Summary:
    ///   Cuts the currently selected components to the clipboard. 
    procedure CutToClipboard;
    
    /// Summary:
    ///   Pastes components from the clibpoard and automatically selects the pasted components.
    procedure PasteFromClipboard;

    /// Summary:
    ///   Saves the current component into a string value.
    /// Parameters:
    ///   AComponent - The component to be converted to a string.
    /// Return Value:
    ///   A string representing the specified component.
    function GetComponentProperties(AComponent: TComponent): string;

    /// Summary:
    ///   Loads a component from a string value. The component state is retrieved from a string previously
    ///   saved with GetComponentProperties.
    /// Parameters:
    ///   AComponent - The component to be loaded.
    ///   Props - A string containing the component properties previously saved.
    procedure SetComponentProperties(AComponent: TComponent; Props: string);
    
    /// Summary:
    ///   Aligns a control to the form designer grid.
    /// Parameters:
    ///   TheControl - Control to be aligned to the grid.
    procedure AlignToGrid(TheControl: TControl);
    
    function EditControlLists(DefaultList: TListType): Boolean;
    
    /// Summary:
    ///   Shows the align controls dialog, which allows end-user to align controls verticaly/horizontally.
    /// Return Value:
    ///   True if end-user confirmed changes and the operation was performed, false otherwise.
    function AlignDialog: Boolean;

    /// Summary:
    ///   Shows the size controls dialog, which allows end-user to resize width and height of controls.
    /// Return Value:
    ///   True if end-user confirmed changes and the operation was performed, false otherwise.
    function SizeDialog: Boolean;

    /// Summary:
    ///   Shows the tab order dialog, which allows end-user to set tab order of controls.
    /// Return Value:
    ///   True if end-user confirmed changes and the operation was performed, false otherwise.
    function TabOrderDialog: Boolean;

    /// Summary:
    ///   Shows the designer options dialog, which allows end-user to set general options, like snap grip, for example.
    /// Return Value:
    ///   True if end-user confirmed changes and the operation was performed, false otherwise.
    function OptionsDialog: boolean;
    
    /// Summary:
    ///   Shows the alignment palette window, which provides buttons to align controls horizontally/vertically. 
    procedure ShowAlignmentPalette;

    /// Summary:
    ///   Hides the alignment palette window. 
    procedure HideAlignmentPalette;
    
    /// Summary:
    ///   Aligns currently selected controls according to specified alignment rules.
    /// Parameters:
    ///   Hor - Alignment rule for horizontal alignment.
    ///   Ver - Alignment rule for vertical alignment.
    procedure AlignControls(Hor,Ver: TAlignMode);

    /// Summary:
    ///   Resizes currently selected controls according to the specified resize rules.
    /// Parameters:
    ///   WMode - Resize rule for width.
    ///   WValue - Value of the new width, used only if WMode is smValue.
    ///   HMode - Resize rule for height.
    ///   HValue - Value of the new height, used only if HMode is smValue.
    procedure SizeControls(WMode: TSizeMode; WValue: Integer; HMode: TSizeMode; HValue: Integer);
    
    /// Summary:
    ///   Locks the designer preventing controls to be edited. If you call Lock twice, you must call Unlock twice to effectively unlock the designer. 
    procedure Lock;
    
    /// Summary:
    ///   Unlocks the designer previously locked with Lock method. You need to call Unlock as many times as you have previously
    ///   called Lock method in order to effectively unlock the designer.
    procedure Unlock;
    
    /// Summary:
    ///   Prevents further changes to the designer to fire change notification events, like OnChange and OnSelectionChange.
    ///   Using SynchroLock allows you to perform changes in the designer without receiving notifications that the designer
    ///   has changed, or selection has changed. Use SynchroUnlock to retrieve the designer to normal state.
    procedure SynchroLock;
    
    /// Summary:
    ///   Unlocks the designer previously locked with SynchroLock. You need to call SynchroUnlock as many times as you have
    ///   previously called SynchroLock method in order to effectively unlock the designer.
    procedure SynchroUnlock;
    
    /// Summary:
    ///   Cancels the current mouse operation.
    /// Description:
    ///   End-user can start some mouse operations in the designer, such as moving or resizing a control, start a selection
    ///   rect, among others. Call LeaveMouseAction to programatically cancel such mouse action and put the designer 
    ///   in the default browsing mouse state.
    /// See Also:
    ///   TMouseAction; MouseAction
    procedure LeaveMouseAction;
    
    /// Summary:
    ///   Adds a control to the current selection in the form designer.
    /// Description:
    ///   Call AddControl to select the specified control in the designer. To multi-select several controls in the designer, call
    ///   AddControl for each control you want to select. For non-visual components, use AddComponent instead, 
    ///   unless you specify the TComponentContainer control that wraps the non-visual component you want to select.
    /// Parameters:
    ///   AControl - The control to be selected.
    procedure AddControl(AControl: TControl);
    
    /// Summary:
    ///   Removes a control from the current selection in the form designer.
    /// Description:                                                    
    ///   Call DeleteControl to unselect the specified control in the designer. For non-visual components, use DeleteComponent instead,
    ///   unless you specify the TComponentContainer control that wraps the non-visual component you want to unselect.
    /// Parameters:
    ///   AControl - The control to be unselected.
    procedure DeleteControl(AControl: TControl);
    
    /// Summary:
    ///   Adds a non-visual component to the current selection in the form designer.
    /// Description:                                                           
    ///   Call AddComponent to select the specified component in the designer. Only use this method for non-visual 
    ///   components, if the component is a visual control, do not use AddComponent, use AddControl instead.
    /// Parameters:
    ///   AComponent - The component to be selected.
    procedure AddComponent(AComponent: TComponent);
    
    /// Summary:
    ///   Removes a non-visual component from the current selection in the form designer.
    /// Description:                                                           
    ///   Call DeleteComponent to unselect the specified component in the designer. Only use this method for non-visual 
    ///   components, if the component is a visual control, do not use AddComponent, use AddControl instead.
    /// Parameters:
    ///   AComponent - The component to be unselected.
    procedure DeleteComponent(AComponent: TComponent);
    
    /// Summary:
    ///   Selects all controls in the form designer.
    procedure SelectAll;
    
    /// Summary:
    ///   Unselectes all controls in the designer, automatically selecting the parent form itself. 
    procedure UnselectAll;
    
    /// Summary:
    ///   Deprecated, same as UnselectAll.
    procedure ClearControls;
    
    /// Summary:
    ///   Returns the index of the control in the current selection list.
    /// Description:
    ///   As controls are being added to the selection, an internal list of selected controls is kept by the designer.
    ///   ControlIndex method returns the index position, in that internal list, for the specified control.
    /// Parameters:
    ///   AControl - The control for which the index will be returned.
    /// Return Value:
    ///   The index position of the control in the list.   
    function ControlIndex(AControl: TControl): Integer;
    
    /// Summary:
    ///   Draws a grab handle.
    /// Description:
    ///   DrawGrab method is called by the designer to draw the grab handles around the current selection. You can override
    ///   this method to perform your own custom drawing of the grab handles.
    /// Parameters:
    ///   Canvas - The canvas where the grab handles show be drawn.
    ///   R - The rect position/size of the grab handles.
    ///   GrabType - The current type/state of the grab handle.
    procedure DrawGrab(Canvas: TCanvas; R: TRect; GrabType: TGrabType); virtual;
    
    /// Summary:
    ///   Refreshes the grab handles according to latest changes, like grab size, glyph, etc..
    procedure UpdateGrabs;
    
    /// Summary:
    ///   Creates a new component instance of the specified component class, owned by the current form being edited.
    /// Parameters:
    ///   AComponentClass - class of the component to be created.
    /// Return Value:
    ///   The instantiated component.
    function CreateComponentClass(AComponentClass: TComponentClass): TComponent;
    
    /// Summary:
    ///   Creates a new component instance of the specified component class, owned by the current form being edited.
    /// Parameters:
    ///   AClassName - name of the class of the component to be created.
    /// Return Value:              
    ///   The instantiated component.
    function CreateComponentClassName(AClassName: TComponentName): TComponent;
    
    /// Summary:
    ///   Starts a component placing operation in the designer.
    /// Description:
    ///   Call PlaceComponentClass to start a placing operation of a specified component class in the designer. After calling
    ///   this method, the designer will enter in the placing state where end-user can click or drag a rect in the form designer
    ///   to insert a new control (or component). The operation is finished when the component is inserted, or if the end-user
    ///   cancels the operation (pressing Esc, for example), or if CancelPlacing method is called, or if AutoPlaceComponent is called.
    /// Parameters:
    ///   AComponentClass - the class of the component to be placed when the placing operation is finished. The
    ///                     component is only instantiated when the place operation is performed.
    /// See Also:
    ///   CancelPlacing; AutoPlaceComponent
    procedure PlaceComponentClass(AComponentClass: TComponentClass);

    /// Summary:
    ///   Starts a component placing operation in the designer.
    /// Description:
    ///   Call PlaceComponentClassName to start a placing operation of a specified component class in the designer. After calling
    ///   this method, the designer will enter in the placing state where end-user can click or drag a rect in the form designer
    ///   to insert a new control (or component). The operation is finished when the component is inserted, or if the end-user
    ///   cancels the operation (pressing Esc, for example), or if CancelPlacing method is called, or if AutoPlaceComponent is called.
    /// Parameters:
    ///   AComponentClassName - the name of the class of the component to be placed when the placing operation is finished. The
    ///                         component is only instantiated when the place operation is performed.
    /// See Also:
    ///   CancelPlacing; AutoPlaceComponent
    procedure PlaceComponentClassName(AClassName: TComponentName);
    
    /// Summary:
    ///   Finishes a component placing operation and inserts the control centered in currently selected control.
    /// Description:
    ///   Call AutoPlaceComponent to finish a component placing operation started with PlaceComponentClass or PlaceComponentClassName.
    ///   The component is automatically inserted in the form. If the component is a control, it will be inserted as child of the
    ///   currently selected control, or as a child of the form, it no control is selected. The control is placed in the center
    ///   of the parent control.
    procedure AutoPlaceComponent;
    
    /// Summary:
    ///   Cancels a component placing operation.
    /// Description:
    ///   Call CancelPlacing to cancel a component placing operation started with PlaceComponentClass or PlaceComponentClassName.
    ///   No component is created and the mouse action state goes back to a browsing state.
    procedure CancelPlacing;
    
    /// Summary:
    ///   Retrieves the hint for the specified component, used to show a hint when the component is being moved/resized.
    /// Parameters:
    ///   AComponent - The component for which the hint will be displayed.
    /// Return Value:
    ///   The hint text for the component.
    function GetComponentHint(AComponent: TComponent): string; virtual;
    
    /// Summary: 
    ///   Retrieves the caption for the specified component, used to show caption for non-visual components.
    /// Parameters:
    ///   AComponent - The component for which the caption will be displayed.
    /// Return Value:
    ///   The caption text for the component.
    function GetComponentCaption(AComponent: TComponent): string;
    
    /// Summary:
    ///   Brings the selected controls to front of other existing controls in the form.
    procedure BringControlsToFront;

    /// Summary:
    ///   Sends the selected controls to back of other existing controls in the form.
    procedure SendControlsToBack;
    
    /// Summary:
    ///   Aligns the selected controls to the designer grid.
    procedure AlignControlsToGrid;
    
    /// Summary:
    ///   Removes the currently selected components from the form, destroying the component instances. 
    procedure RemoveSelectedControls;
    
    /// Summary:
    ///   Indicates if the form was modified (a control was moved, for example). This property is automatically
    ///   set to true by the designer when something changes in the designer. You can manually set this property
    ///   back to false (or true) if you need to.
    property Modified: Boolean read FModified write FModified;
    
    /// Summary:
    ///   Provides the number of selected components in the designer.
    property ControlCount: Integer read GetControlCount;
    
    /// Summary:
    ///   Indicates if the designer is in a locked state due to one or more calls to Lock method. In a locked state,
    ///   the controls can't be moved or resized.
    property Locked: Boolean read GetLocked;
    
    /// Summary:
    ///   Indicates if the designer is in a synchro locked state due to one or more cals to SynchroLock method. In a synchro
    ///   locked state, change notification events are not fired, like OnChange or OnSelectionChange.
    property SynchroLocked: Boolean read GetSynchroLocked;
    
    /// Summary:
    ///   Indicates the current mouse action (mouse state) of the designer.
    property MouseAction: TMouseAction read FMouseAction;
    
    /// Summary:
    ///   Indicates if the form designer is active (on) or inactive (off).
    /// Description:
    ///   The Active property controls if the form is being designed or not. When you set Active property to true, the designer
    ///   enters in active mode which mean form editing is possible. Setting Active to false will deactivate the form designer
    ///   and the form will behave like a regular Delphi form.
    property Active: Boolean read FActive write SetActive;
    
    /// Summary:
    ///   Indicates how the application messages are handled by the form designer.
    property MessageProcessor: TMessageProcessor read FMessageProcessor write SetMessageProcessor default mpEvent;
    
    /// Summary:
    ///   Contains the currently selected control in the designer.
    /// Description:
    ///   Control property contains a reference to the currently selected control in the designer. When more than one control
    ///   is selected (multi-selection), Control property returns the first selected control. If you set a value for
    ///   Control property, all other currently selected controls are deselected, and the specified control will be the only
    ///   control selected. For non-visual components, the control is the TComponentContainer control that represents the component.
    /// See Also:
    ///   Controls; Component
    property Control: TControl read GetControl write SetControl;
    
    /// Summary:
    ///   Provides indexed access to the currently selected controls in the designer. The total of selected controls is provided
    ///   by ControlCount method. For non-visual components, the control is the TComponentContainer control that represents the component.
    /// See Also:
    ///   Components
    property Controls[Index: Integer]: TControl read GetControlByIndex;
    
    /// Summary:
    ///   Contains the currently selected component in the designer.
    /// Description:
    ///   Component property contains a reference to the currently selected component in the designer. When more than one component
    ///   is selected (multi-selection), Component property returns the first selected component. If you set a value for
    ///   Component property, all other currently selected components are deselected, and the specified component will be the only
    ///   one selected. 
    /// See Also:
    ///   Components; Control
    property Component: TComponent read GetComponent write SetComponent;

    /// Summary:
    ///   Provides indexed access to the currently selected components in the designer. The total of selected components is provided
    ///   by ControlCount method.
    /// See Also:
    ///   Controls
    property Components[Index: Integer]: TComponent read GetComponentByIndex;
    
    /// Summary:
    ///   Indicates the form that is being edited / will be edited by the designer.
    /// Description:
    ///   By default, the form being edited is the form which owns the designer component. But you can change it using
    ///   ParentForm property. 
    property ParentForm: TCustomForm read GetParentForm write SetParentForm;
    
    /// Summary:
    ///   Provides a direct reference to the alignment palette form.
    /// See Also:
    ///   ShowAlignmentPalette
    property AlignmentPaletteForm: TForm read FAPForm;
    
    /// Summary:
    ///   Indicates the control for which a context popup menu should be displayed.
    /// Description:
    ///   When the end-user performs a right click in the form, a context popup menu is displayed, or the OnContextPopup
    ///   event handler will perform some custom operations. In either situation, the right-clicked control is provided 
    ///   in the MenuControl property. 
    property MenuControl: TControl read FMenuControl;
    
    /// Summary:
    ///   Contains a string representation of the current form.
    /// Description:
    ///   Use FormData property to retrieve a string representation of the current form being edited. You can save the
    ///   string content somewhere and later write FormData property with the string value to retrieve the form state.
    ///   Reading and writing FormData property is similar to save the form to stream or dfm, and later loading it.
    /// See Also:
    ///   SaveToStream; SaveToDFM; LoadFromStream; LoadFromDFM
    property FormData: string read GetFormData write SetFormData;
    
    /// Summary:
    ///   Indicates if all existing controls must be deleted before a load operation is performed.
    /// Description:
    ///   When you load a form from a file or stream, the existing controls are first deleted, then the form is loaded.
    ///   This happens by default, because ClearBeforeLoad is true by default. If you don't want the controls to be deleted,
    ///   set this property to false.
    property ClearBeforeLoad: Boolean read FClearBeforeLoad write FClearBeforeLoad default True;
    
    {$IFDEF TFD1COMPATIBLE}
    property FixedControls: TStrings read FLockedControls write SetLockedControls;
    property FixedInverse: Boolean read FLockedInverse write SetLockedInverse;
    property FixChildren: TChildrenMode read FLockChildren write SetLockChildren;
    {$ELSE}
    
    /// Summary:
    ///   Contains the name of components that should be locked in the designer.
    /// Description:
    ///   Add component names to LockedControls property to indicate that the specified component is locked in the designer.
    ///   If LockedInverse property is true, then the components in this list will NOT be locked, and all missing ones
    ///   will be considered locked.
    /// PasExample:
    ///   LockedControls.Add('Edit');
    ///   LockedControls.Add('Table1');
    /// See Also:
    ///   LockedInverse; LockChildren
    property LockedControls: TStrings read FLockedControls write SetLockedControls;
    
    /// Summary:
    ///   If true, the components in LockedControls list will be considered as not locked, and all others will be locked in the designer.
    property LockedInverse: Boolean read FLockedInverse write SetLockedInverse default False;
    
    /// Summary:
    ///   Indicates how children controls will be treated when a control is locked in the designer.
    /// See Also:
    ///   LockedControls 
    property LockChildren: TChildrenMode read FLockChildren write SetLockChildren default cmNone;
    {$ENDIF}            
    
    /// Summary:
    ///   Contains the name of components that should be protected in the designer.
    /// Description:
    ///   Add component names to ProtectedControls property to indicate that the specified component is protected in the designer.
    ///   If ProtectedInverse property is true, then the components in this list will NOT be protected, and all missing ones
    ///   will be considered protected.
    /// PasExample:
    ///   ProtectedControls.Add('Edit');
    ///   ProtectedControls.Add('Table1');
    /// See Also:
    ///   ProtectedInverse; ProtectChildren
    property ProtectedControls: TStrings read FProtectedControls write SetProtectedControls;

    /// Summary:
    ///   If true, the components in ProtectedControls list will be considered as not protected, and all others will be protected in the designer.
    property ProtectedInverse: Boolean read FProtectedInverse write SetProtectedInverse default False;

    /// Summary:
    ///   Indicates how children controls will be treated when a control is protected in the designer.
    /// See Also:
    ///   ProtectedControls
    property ProtectChildren: TChildrenMode read FProtectChildren write SetProtectChildren default cmNone;
    
    /// Summary:
    ///   Indicates the protection mode for components marked as protected in the designer.
    property ProtectMode: TProtectMode read FProtectMode write SetProtectMode default pmUnselect;

    /// Summary:
    ///   Contains the name of components that should be transparent in the designer.
    /// Description:
    ///   Add component names to TransparentControls property to indicate that the specified component is transparent in the designer.
    ///   If TransparentInverse property is true, then the components in this list will NOT be transparent, and all missing ones
    ///   will be considered transparent.
    /// PasExample:
    ///   TransparentControls.Add('Edit');
    ///   TransparentControls.Add('Table1');
    /// See Also:
    ///   TransparentInverse; TransparentChildren
    property TransparentControls: TStrings read FTransparentControls write SetTransparentControls;

    /// Summary:
    ///   If true, the components in TransparentControls list will be considered as not transparent, and all others will be transparent in the designer.
    property TransparentInverse: Boolean read FTransparentInverse write SetTransparentInverse default False;

    /// Summary:
    ///   Indicates how children controls will be treated when a control is transparent in the designer.
    /// See Also:
    ///   TransparentControls
    property TransparentChildren: TChildrenMode read FTransparentChildren write SetTransparentChildren default cmNone;
    
    /// Summary:
    ///   Contains the popup menu to be displayed when end-user performs a right click in the designer.
    /// Description:
    ///   All items in the popup menu are always displayed. If the right-clicked component has a registered component editor which
    ///   displayed additional context menu items, those menu items will be displayed at the top of popup menu, and all other
    ///   existing items in the popup menu will be displayed below them, separated by a separator line.
    /// See Also:
    ///   RegisterIDEComponentEditor
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu default nil;
    
    {$IFDEF GFDADVANCEDGRID}
    property GridStepX: Integer read FGridStepX write SetGridStepX default 8;          
    property GridStepY: Integer read FGridStepY write SetGridStepY default 8;
    {$ELSE}
    
    /// Summary:
    ///   Contains the separation between grid dots. In other words, the grid size. The grid is displayed when DisplayGrid property is true.
    property GridStep: Integer read FGridStep write SetGridStep default 8;
    {$ENDIF}
    
    /// Summary:                                                                 
    ///   When true, all controls are snapped to grid in insert, moving and resizing operations, regardless of the 
    ///   value of DisplayGrid property.
    property SnapToGrid: Boolean read FSnapToGrid write FSnapToGrid default False;
    
    /// Summary:
    ///   Indicates how the designer will treat Ctrl+Arrows key operations. If false, then Ctrl+Arrow will move the controls
    ///   pixel by pixel. If true, Ctrl+Arrow will move the control by the value specified in GridStep property.
    property SnapToGridKey: Boolean read FSnapToGridKey write FSnapToGridKey default False;
    
    /// Summary:
    ///   Use DisplayGrid to show or hide the designer snap grid. 
    property DisplayGrid: Boolean read FDisplayGrid write SetDisplayGrid default False;
    
    /// Summary:
    ///   Indicates the background color of the form being designed. If DesignerColor is clNone, the current 
    ///   color of the form will be used.
    property DesignerColor: TColor read FDesignerColor write SetDesignerColor default clNone;
    
    /// Summary:
    ///   Specifies the color of the dots in the designer grid.
    /// Description:
    ///   If GridColor is clNone, then the color to be used is the Font color of the parent form.
    property GridColor: TColor read FGridColor write SetGridColor default clNone;
    
    /// Summary:
    ///   When true, the designer shows a hint while moving or resizing operations.
    property ShowMoveSizeHint: Boolean read FShowMoveSizeHint write SetMoveSizeHint default True;
    
    /// Summary:
    ///   When true, a hint is displayed when the mouse moves over a component in the designer.
    property ShowComponentHint: Boolean read FShowComponentHint write SetComponentHint default False;
    
    /// Summary:
    ///   Specifies the size of the grab handles in the designer.
    property GrabSize: Integer read FGrabSize write SetGrabSize default 5;
    
    /// Summary:
    ///   Specifies some options for the alignment palette form.   
    property AlignmentPalette: TAlignmentPaletteOptions read FAlignmentPalette write SetAlignmentPalette default [apStayOnTop,apShowHints];
    
    /// Summary:
    ///   Specifies the color of the grab handle border when it is in normal state. 
    property NormalGrabBorder: TColor read FNormalGrabBorder write SetNormalGrabBorder default clBlack;
    
    /// Summary:
    ///   Specifies the fill color of the grab handle when it is in normal state.
    property NormalGrabFill: TColor read FNormalGrabFill write SetNormalGrabFill default clBlack;
    
    /// Summary:
    ///   Use NormalGrabGlyph to provide a custom bitmap to be displayed in place of the grab handle, when it is in normal state.
    ///   The image will only be displayed if UseGrabGlyphs property is true.
    property NormalGrabGlyph: TBitmap read FNormalGrabGlyph write SetNormalGrabGlyph;

    /// Summary:
    ///   Specifies the color of the grab handle border when multiple components are selected in the designer. 
    property MultiGrabBorder: TColor read FMultiGrabBorder write SetMultiGrabBorder default clGray;

    /// Summary:
    ///   Specifies the fill color of the grab handle when multiple components are selected in the designer.
    property MultiGrabFill: TColor read FMultiGrabFill write SetMultiGrabFill default clGray;

    /// Summary:
    ///   Use MultiGrabGlyph to provide a custom bitmap to be displayed in place of the grab handle, 
    ///   when multiple controls are selected in designer.
    ///   The image will only be displayed if UseGrabGlyphs property is true.
    property MultiGrabGlyph: TBitmap read FMultiGrabGlyph write SetMultiGrabGlyph;

    /// Summary:
    ///   Specifies the color of the grab handle border when the selected component is locked. 
    property LockedGrabBorder: TColor read FLockedGrabBorder write SetLockedGrabBorder default clBlack;

    /// Summary:
    ///   Specifies the fill color of the grab handle when the selected component is locked.
    property LockedGrabFill: TColor read FLockedGrabFill write SetLockedGrabFill default clGray;

    /// Summary:
    ///   Use LockedGrabGlyph to provide a custom bitmap to be displayed in place of the grab handle, 
    ///   when the selected component is locked.                                 
    ///   The image will only be displayed if UseGrabGlyphs property is true.
    property LockedGrabGlyph: TBitmap read FLockedGrabGlyph write SetLockedGrabGlyph;

    /// Summary:
    ///   When KeySelect property is true, the controls can be selected in the designer using keyboard keys
    ///   like arrow and tab keys.
    property KeySelect: Boolean read FKeySelect write FKeySelect default True;

    /// Summary:
    ///   When KeyMove property is true, the selected controls can be moved and resized using keyboard.
    ///   Behavior is similar to Delphi IDE: Shift+Arrows resize the block, Ctrl+Shift+Arrows move the block according to grid size,
    ///   and Ctrl+Arrows might move the block pixel by pixel or by grid size, depending on value of SnapToGridKey property.
    property KeyMove: Boolean read FKeyMove write FKeyMove default True;
    
    /// Summary:
    ///   If ShowNonVisual property is true, the non-visual components are displayed in the designer and can be selected and moved.
    ///   Default value is true.   
    property ShowNonVisual: Boolean read FShowNonVisual write SetShowNonVisual default True;
    
    /// Summary:
    ///   If ShowComponentCaptions is true, a caption is displayed below the non-visual components, showing the name and class
    ///   of the component. You can change the caption value using OnComponentCaption event.
    property ShowComponentCaptions: Boolean read FShowComponentCaptions write SetShowComponentCaptions default False;
    
    /// Summary:
    ///   When MultiSelect is true, the designer allows more than one component to be selected at the same time. 
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default True;
    
    /// Summary:
    ///   Indicates a specific control to be designed, instead of a form. This property is here for backward compatibility
    ///   and show not be used by now.
    property DesignControl: TWinControl read FDesignControl write SetDesignControl;
    
    /// Summary:
    ///   When EnableAxisDrag is true, end-user can limit moving a control by its horizontal or vertical axis only,
    ///   by pressing the Ctrl key while moving the control with the mouse. 
    property EnableAxisDrag: Boolean read FEnableAxisDrag write FEnableAxisDrag default False;
    
    /// Summary:
    ///   Specifies where the grab handles are located relative to the control bounds.
    property GrabMode: TGrabMode read FGrabMode write SetGrabMode default gmMiddle;
    
    /// Summary:
    ///   When true, the grab handles will not be drawn directly by the designer, but instead, a bitmap will be displayed
    ///   at the grab handle position. The bitmap to be displayed must be defined in properties NormalGrabGlyph, MultiGrabGlyph
    ///   or LockedGrabGlyph, depending on the grab handle state.   
    property UseGrabGlyphs: Boolean read FUseGrabGlyphs write SetUseGrabGlyphs default False;
    
    /// Summary:
    ///   Defines the transparent color to be used for the custom grab handle glyphs, when UseGrabGlyphs property is true.
    property GrabsTransparentColor: TColor read FGrabsTransparentColor write SetGrabsTransparentColor default clBlack;
    
    /// Summary:
    ///   When AlignmentLines are used, this property specifies if the alignment lines will be shown in the entire form,
    ///   or only in the parent control.
    property AlignmentEntireForm: Boolean read FAlignmentEntireForm write FAlignmentEntireForm default False;
    
    /// Summary:
    ///   Specifies which alignment lines will be visible in a move or resize operation.
    property AlignmentLines: TLinePositions read FAlignmentLines write FAlignmentLines default [];
    
    /// Summary:
    ///   Specifies the color of left alignment line. The line will be displayed in move or resize operations
    ///   if it is enabled in AlignmentLines property.
    property AlignmentColorLeft: TColor read FAlignmentColorLeft write FAlignmentColorLeft default clGray;

    /// Summary:
    ///   Specifies the color of top alignment line. The line will be displayed in move or resize operations
    ///   if it is enabled in AlignmentLines property.
    property AlignmentColorTop: TColor read FAlignmentColorTop write FAlignmentColorTop default clGray;

    /// Summary:
    ///   Specifies the color of right alignment line. The line will be displayed in move or resize operations
    ///   if it is enabled in AlignmentLines property.
    property AlignmentColorRight: TColor read FAlignmentColorRight write FAlignmentColorRight default clGray;

    /// Summary:
    ///   Specifies the color of bottom alignment line. The line will be displayed in move or resize operations
    ///   if it is enabled in AlignmentLines property.
    property AlignmentColorBottom: TColor read FAlignmentColorBottom write FAlignmentColorBottom default clGray;
    
    /// Summary:
    ///   Specifies what are the limit boundaries for the mouse cursor during move operations.
    property MoveLimitMode: TMoveLimitMode read FMoveLimitMode write FMoveLimitMode default lmCursor;
    
    /// Summary:
    ///   When saving a form to stream or file, you can specify an ancestor component so that the designer will only
    ///   save what is different from the ancestor, instead of saving all components and properties of the form.
    property Ancestor: TComponent read FAncestor write FAncestor;
    
    /// Summary:
    ///   When true, prevents the parent form to be moved by the end-user using the keyboard.
    property AvoidFormMoving: boolean read FAvoidFormMoving write FAvoidFormMoving;
    
    /// Summary:
    ///   During a component place operation, contains the class of the component that will be created when the placing
    ///   operation is finished.
    /// See Also:
    ///   PlaceComponentClass; PlaceComponentClassName
    property PlacedComponentClass: TComponentClass read FPlacedComponentClass;
  end;

  /// Summary:
  ///   Component used to allow runtime form designing.
  /// Description:
  ///   TAdvFormDesigner component is a component used to allow designing of forms at runtime.
  ///   The component must always be owned by the form that must be edited. You can turn designing on and off using the 
  ///   Active property. This component provides several properties and events for customizing the way the form is being edited.
  ///   Several methods are provided to persist form changes, like saving and loading the form to streams and files.
  ///   In Scripter Studio Pro IDE, this component is used internally by the inplace form designer.
  TAdvFormDesigner = class(TAdvCustomFormDesigner)
  published
    property ClearBeforeLoad;
    property MessageProcessor;
    {$IFDEF TFD1COMPATIBLE}
    property FixedControls;
    property FixedInverse;
    property FixChildren;
    {$ELSE}
    property LockedControls;
    property LockedInverse;
    property LockChildren;
    {$ENDIF}
    property ProtectedControls;
    property ProtectedInverse;
    property ProtectChildren;
    property ProtectMode;
    property TransparentControls;
    property TransparentInverse;
    property TransparentChildren;
    property PopupMenu;
    {$IFDEF GFDADVANCEDGRID}
    property GridStepX;
    property GridStepY;
    {$ELSE}
    property GridStep;
    {$ENDIF}
    property SnapToGrid;
    property SnapToGridKey;
    property DisplayGrid;
    property DesignerColor;
    property GridColor;
    property ShowMoveSizeHint;
    property ShowComponentHint;
    property GrabSize;
    property AlignmentPalette;
    property NormalGrabBorder;
    property NormalGrabFill;
    property NormalGrabGlyph;
    property MultiGrabBorder;
    property MultiGrabFill;
    property MultiGrabGlyph;
    property LockedGrabBorder;
    property LockedGrabFill;
    property LockedGrabGlyph;
    property KeySelect;
    property KeyMove;
    property ShowNonVisual;
    property ShowComponentCaptions;
    property MultiSelect;
    property DesignControl;
    property EnableAxisDrag;
    property GrabMode;
    property UseGrabGlyphs;
    property GrabsTransparentColor;
    property AlignmentEntireForm;
    property AlignmentLines;
    property AlignmentColorLeft;
    property AlignmentColorTop;
    property AlignmentColorRight;
    property AlignmentColorBottom;
    property MoveLimitMode;
    {$IFDEF TFD1COMPATIBLE}
    property OnDragControl;
    {$ELSE}
    property OnMoveSizeControl;
    {$ENDIF}
    property OnChange;
    property OnLoadControl;
    property OnSaveControl;
    property OnSelectControl;
    property OnSelectionChange;
    property OnAddControl;
    property OnDeleteControl;
    property OnControlDblClick;
    property OnActivate;
    property OnDeactivate;
    property OnKeyDown;
    property OnKeyUp;
    property OnMessage;
    property OnMoveLimit;
    property OnSizeLimit;
    property OnReadError;
    property OnCustomizeGrabs;
    property OnComponentHint;
    property OnComponentCaption;
    property OnComponentBitmap;
    property OnComponentEditable;
    property OnCopyComponent;
    property OnPasteComponent;
    property OnContextPopup;
    property OnEditBehaviour;
    property OnPlaceComponent;
    property OnEndPlacing;
    property OnEndSelecting;
    property OnShowAlignmentPalette;
  end;

  /// Summary:
  ///   General purpose exception class raised by the TAdvCustomFormDesigner component when some internal error occur.
  EFormDesigner = class(Exception);

  /// Summary:
  ///   Base class for creating custom component editor and context menus for the form designer.
  /// Description:
  ///   Create classes descending from TIDEComponentEditor to allow custom component editor and context menus for specific 
  ///   components. For example, if you want to display a custom dialog when the user double clicks a TTable, or if you want
  ///   to display custom popup menu items when user right clicks a TEdit control, then you must create a class descending
  ///   from TIDEComponentEditor, override some methods like Edit or GetVerbCount, and then register the new editor using
  ///   RegisterIDEComponentEditor.
  TIDEComponentEditor = class(TComponent)
  private
    FComponent: TComponent;
    FDesigner: TAdvCustomFormDesigner;
  protected
    /// Summary:
    ///   Override Edit method to specify a custom action to be performed when the end-user double clicks a component
    ///   in the form designer. You can, for example, call a modal dialog to edit some component properties.
    ///   The Edit method won't be called unless the method HasEditor returns true. 
    /// See Also:
    ///   HasEditor; GetComponent
    procedure Edit; virtual;
                                          
    /// Summary:
    ///   Override this method to specify a action for a custom context menu item. When the end-user right clicks a component
    ///   in the designer and chooses a menu item, ExecuteVerb method is called.
    /// Parameters:
    ///   Index - The index of the menu item clicked by the end-user.
    /// See Also:
    ///   GetVerbCount; GetVerb
    procedure ExecuteVerb(Index: Integer); virtual;
    
    /// Summary:
    ///   Override GetVerb method to specify the caption of the context menu item. When the end-user right clicks a component
    ///   in the designer, several menu items are displayed, in addition to the default menu items 
    ///   provided by TAdvCustomFormDesigner.PopupMenu.
    /// Parameters:
    ///   Index - the index of the menu item for which the caption will be provided.
    /// Return Value:
    ///   The caption of the specified menu item.
    /// See Also:
    ///   GetVerbCount; ExecuteVerb
    function GetVerb(Index: Integer): string; virtual;
    
    /// Summary:
    ///   Override GetVerbCount method to specify the number of additional context menu items that will appear when the
    ///   end-user right clicks a component in the form designer.
    /// Return Value:
    ///   The number of context menu items to be displayed.
    /// See Also:
    ///   GetVerb; ExecuteVerb
    function GetVerbCount: Integer; virtual;
    
    /// Summary:
    ///   Returns the instance of the component associated with this component editor, that is being edited in the form designer.
    function GetComponent: TComponent;
    
    /// Summary:
    ///   Provides a reference to the form designer component.
    function GetDesigner: TAdvCustomFormDesigner;
  public
    /// Summary:
    ///   Override this method to tell the designer to call Edit method when end-user double clicks a component.
    ///   Edit method will only be called if HasEditor returns true.
    function HasEditor: boolean; virtual;
  end;
  
  /// Summary:
  ///   TIDEComponentEditorClass is any class reference that descends from TIDEComponentEditor.
  TIDEComponentEditorClass = class of TIDEComponentEditor;

/// Summary:
///   Designing function returns true if there is any form being designed in the application, i.e., if there is at least
///   one active form designer component in the application.
function Designing: Boolean;

/// Summary:
///   Registers an IDE component editor for a specified component class.
/// Description:
///   Call RegisterIDEComponentEditor to specify a custom component editor for a specific component. Custom component editors
///   allow you to provide custom actions when the end-user double clicks a component in the designer, or to show custom
///   context menu items when end-user right clicks a component.
/// Parameters:
///   ComponentClass - The class of the component for which the component editor will be registered.
///   ComponentEditor - The class of the component editor to be registered for the specified component.
/// PasExample:
///   RegisterIDEComponentEditor(TPageControl, TPageControlIDEEditor);
procedure RegisterIDEComponentEditor(ComponentClass: TComponentClass;
  ComponentEditor: TIDEComponentEditorClass);

implementation

{BJF} {$IFNDEF UseGreatisUnits} {$R FormDesigner.RES} {$ENDIF}
{$IFNDEF FDNOSTDICONS}
{BJF} {$IFNDEF UseGreatisUnits} {$R StdIcons.RES} {$ENDIF}
{$ENDIF}

{$BOOLEVAL OFF}
{$RANGECHECKS OFF}

{$IFDEF VER100}
{$DEFINE NOFRAMES}
{$DEFINE NOMOUSEWHEEL}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER110}
{$DEFINE NOFRAMES}
{$DEFINE NOMOUSEWHEEL}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER120}
{$DEFINE NOFRAMES}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER125}
{$DEFINE NOFRAMES}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER130}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}

{$IFNDEF VER150}
{$DEFINE NOCSSUBCOMPONENT}
{$ENDIF}

uses
  DesignerAlignDialog, DesignerAlignPalette, DesignerControlsEditor, DesignerSizeDialog, DesignerTabOrderDialog, DesignerOptionsDialog,
  ImageListEditor, DatasetFieldsEditor,
  {$IFDEF SCRIPTER_ADOCONED}
  AdoConEd,
  {$ENDIF}
  ADODB;

type
  TIDECompEditorItem = class(TCollectionItem)
  private
    FCompClass: TComponentClass;
    FEditorClass: TIDEComponentEditorClass;
    FEditor: TIDEComponentEditor;
  public
    destructor Destroy; override;
  end;

  TIDECompEditorList = class(TCollection)
  end;

var
  SavedApplicationMessage: TMessageEvent = nil;
  SavedApplicationIdle: TIdleEvent = nil;
  _Designers: TList;
  _IDEEditorList: TIDECompEditorList;
  HookID: HHook = 0;


function Designers: TList;
begin
  if _Designers = nil then
    _Designers := TList.Create;
  result := _Designers;
end;

function IDEEditorList: TIDECompEditorList;
begin
  if _IDEEditorList = nil then
    _IDEEditorList := TIDECompEditorList.Create(TIDECompEditorItem);
  result := _IDEEditorList;
end;

const
  BufSize = 2048;

function HookProc(Code,WParam,LParam: Integer): LResult; stdcall;
var
  i,ILockCounter: Integer;
begin
  if Designers <> nil then
    for i:=0 to Pred(Designers.Count) do
      with TAdvCustomFormDesigner(Designers[i]) do
      begin
        ILockCounter:=FLockCounter;
        try
          MessageProc(PMsg(LParam)^);
        finally
          if FLockCounter>ILockCounter then FLockCounter:=ILockCounter;
          if Locked then
            case PMsg(LParam)^.Message of
              WM_LBUTTONUP,WM_NCLBUTTONUP,WM_RBUTTONUP,WM_NCRBUTTONUP:
              begin
                Unlock;
                MessageProc(PMsg(LParam)^);
              end;
            end;
        end;
      end;
  Result:=CallNextHookEx(HookID,Code,WParam,LParam);
end;

function GetGrabCursor(GP: TGrabPosition): TCursor;
begin
  case GP of
    gpLeftTop,gpRightBottom: Result:=crSizeNWSE;
    gpLeftMiddle,gpRightMiddle: Result:=crSizeWE;
    gpLeftBottom,gpRightTop: Result:=crSizeNESW;
    gpMiddleTop,gpMiddleBottom: Result:=crSizeNS;
  else Result:=crArrow;
  end;
end;


{ TIDECompEditorItem }

destructor TIDECompEditorItem.Destroy;
begin
  if FEditor <> nil then
  begin
    FEditor.Free;
    FEditor := nil;
  end;
  inherited;
end;

procedure RegisterIDEComponentEditor(ComponentClass: TComponentClass; ComponentEditor: TIDEComponentEditorClass);
var
  AEdit: TIDECompEditorItem;
  c: integer;
begin
  AEdit := nil;
  for c := 0 to IDEEditorList.Count - 1 do
    if ComponentClass = TIDECompEditorItem(IDEEditorList.Items[c]).FCompClass then
    begin
      AEdit := TIDECompEditorItem(IDEEditorList.Items[c]);
      break;
    end;
  if AEdit = nil then
    AEdit := TIDECompEditorItem(IDEEditorList.Add);

  With AEdit do
  begin
    FCompClass := ComponentClass;
    FEditorClass := ComponentEditor;
  end;
end;

{ TPageControlIDEEditor}

type
  TPageControlIDEEditor = class(TIDEComponentEditor)
  protected
    //procedure Edit; virtual;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TPageControlIDEEditor.ExecuteVerb(Index: Integer);
var
  TS: TTabSheet;
  c: integer;
begin
  TS := TTabSheet.Create(GetComponent.Owner);
  TS.PageControl :=TPageControl(GetComponent);
  c := 1;
  while GetComponent.Owner.FindComponent(Format('TabSheet%d', [c])) <> nil do
    inc(c);
  TS.Name := Format('TabSheet%d', [c]);
  TS.Caption := TS.Name;
  TS.PageControl.ActivePage := TS;
  GetDesigner.Component := TS;
end;

function TPageControlIDEEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: result := 'New Page';
  end;
end;

function TPageControlIDEEditor.GetVerbCount: Integer;
begin
  result := 1;
end;

{ TTabSheetIDEEditor}

type
  TTabSheetIDEEditor = class(TIDEComponentEditor)
  protected
    //procedure Edit; virtual;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TTabSheetIDEEditor.ExecuteVerb(Index: Integer);

  procedure _DestroyControls(AControl: TWinControl);
  begin
    while AControl.ControlCount > 0 do
      if AControl.Controls[0] is TWinControl then
        _DestroyControls(TWinControl(AControl.Controls[0]))
      else
        AControl.Controls[0].Free;
    AControl.Free;
  end;

var
  TS: TTabSheet;
  c: integer;
begin
  case Index of
    0:
      begin
        TS := TTabSheet.Create(GetComponent.Owner);
        TS.PageControl :=TTabSheet(GetComponent).PageControl;
        c := 1;
        while GetComponent.Owner.FindComponent(Format('TabSheet%d', [c])) <> nil do
          inc(c);
        TS.Name := Format('TabSheet%d', [c]);
        TS.Caption := TS.Name;
        TS.PageControl.ActivePage := TS;
        GetDesigner.Component := TS;
      end;
    1:
      begin
        TS := TTabSheet(GetComponent);
        GetDesigner.Component := TS.PageControl;
        _DestroyControls(TS);
      end;
  end;
end;

function TTabSheetIDEEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: result := 'New Page';
    1: result := 'Delete Page';
  end;
end;

function TTabSheetIDEEditor.GetVerbCount: Integer;
begin
  result := 2;
end;

{ TImageListIDEEditor }

type
  TImageListIDEEditor = class(TIDEComponentEditor)
  protected
    procedure Edit; override;
    function HasEditor: boolean; override;
  end;

{ TImageListIDEEditor }

procedure TImageListIDEEditor.Edit;
begin
  if GetComponent is TImageList then
    EditImageList(TImageList(GetComponent));
end;

function TImageListIDEEditor.HasEditor: boolean;
begin
  result := true;
end;

{ TDatasetFieldsIDEEditor }

type
  TDatasetFieldsIDEEditor = class(TIDEComponentEditor)
  protected
    procedure Edit; override;
    function HasEditor: boolean; override;
  end;

{ TDatasetFieldsIDEEditor }

procedure TDatasetFieldsIDEEditor.Edit;
begin
  if GetComponent is TDataset then
    EditDatasetFields(TDataset(GetComponent), GetComponent.Owner, GetDesigner);
end;

function TDatasetFieldsIDEEditor.HasEditor: boolean;
begin
  result := true;
end;

{$IFDEF SCRIPTER_ADOCONED}
{ TADOConnectionIDEEditor }

type
  TADOConnectionIDEEditor = class(TIDEComponentEditor)
  protected
    procedure Edit; override;
    function HasEditor: boolean; override;
  end;

procedure TADOConnectionIDEEditor.Edit;
begin
  if GetComponent is TADOConnection then
    EditConnectionString(GetComponent);
end;

function TADOConnectionIDEEditor.HasEditor: boolean;
begin
  result := true;
end;
{$ENDIF}

{ TComponentContainer }

procedure TComponentContainer.Paint;
begin
  with Canvas do
  begin
    Brush.Color:=clBtnFace;
    FillRect(ClientRect);
    Pen.Color:=clBtnHighlight;
    MoveTo(0,Pred(Height));
    LineTo(0,0);
    LineTo(Width,0);
    Pen.Color:=clBtnShadow;
    MoveTo(0,Pred(Height));
    LineTo(Pred(Width),Pred(Height));
    LineTo(Pred(Width),0);
    Draw(2,2,FBitmap);
  end;
end;

procedure TComponentContainer.WndProc(var Msg: TMessage);
begin
  with Msg do
    case Msg of
      WM_SIZE:
      begin
        Width:=28;
        Height:=28;
      end;
      WM_MOVE:
      begin
        inherited;
        if Assigned(FComponent) then
          UpdateContainer;
        {if Assigned(FComponent) and not (csLoading in FComponent.ComponentState) then
        begin
          FComponent.DesignInfo:=Left+Top shl 16;
          UpdateContainer;
        end;}
      end;
    else inherited;
    end;
end;

constructor TComponentContainer.CreateWithComponent(AOwner,AComponent: TComponent;
  ADesigner: TAdvCustomFormDesigner; AVisible: boolean);
begin
  inherited Create(AOwner);
  FDesigner:=ADesigner;
  FComponent:=AComponent;
  FBitmap:=TBitmap.Create;
  with FBitmap do
  begin
    if Assigned(FDesigner) and Assigned(FDesigner.OnComponentBitmap) then
      FDesigner.OnComponentBitmap(FDesigner,FComponent,FBitmap)
    else Handle:=LoadBitmap(HInstance,PChar(AnsiUpperCase(AComponent.ClassName)));
    if Handle=0 then Handle:=LoadBitmap(HInstance,'CONTAINER');
    Transparent:=True;
  end;
  Visible := Assigned(FComponent);
  Width:=28;
  Height:=28;
  ShowHint:=True;
  with FComponent do
    if HandleAllocated then
      SetWindowPos(Handle,0,LoWord(DesignInfo),HiWord(DesignInfo),0,0,SWP_NOSIZE or SWP_NOZORDER)
    else
    begin
      Left:=LoWord(DesignInfo);
      Top:=HiWord(DesignInfo);
    end;
  FCaption:=TStaticText.Create(Self);
  UpdateContainer;
  with FCaption do
  begin
    if Assigned(FDesigner) and FDesigner.ShowComponentCaptions then
      FCaption.Parent:=AOwner as TWinControl;
    Alignment:=taCenter;
  end;
  Parent:=AOwner as TWinControl;
  if not AVisible then
    HideControl;
end;

destructor TComponentContainer.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TComponentContainer.UpdateContainer;
begin
  with FCaption do
  begin
    if Assigned(FDesigner) then Caption:=FDesigner.GetComponentCaption(FComponent)
    else Caption:='';
    Top:=Self.Top+Self.Height+2;
    Left:=(Self.Left)+Self.Width div 2-Width div 2;
  end;
end;

procedure TComponentContainer.HideControl;
begin
  Visible := False;
  Left := -Width-1;
  Top := -Height-1;
end;

{ TFDReader }

function TFDReader.Error(const Message: string): Boolean;
begin
  Result:=True;
  if Assigned(Designer) and Assigned(Designer.FOnReadError) then
    Designer.FOnReadError(Self,Message,Result);
end;

procedure TFDReader.SetName(Component: TComponent; var Name: string);

  procedure RenameComponent(AComponent: TComponent);
  var
    Index: Integer;
    AName: string;
  begin
    Index:=1;
    if Name<>'' then
    begin
      AName:=Name;
      while Assigned(AComponent.Owner.FindComponent(AName)) do
      begin
        Inc(Index);
        AName:=Copy(AComponent.ClassName,2,Length(AComponent.ClassName))+IntToStr(Index);
      end;
      try
        AComponent.Name:=AName;
      except
        AComponent.Name:='';
      end;
      with AComponent do
        for Index:=0 to Pred(ComponentCount) do RenameComponent(Components[Index]);
    end;
  end;

begin
  if Assigned(Component) and Assigned(Component.Owner) and Assigned(Designer) and Assigned(Designer.ParentForm) then
    RenameComponent(Component);
end;

constructor TFDReader.Create(AStream: TStream; ADesigner: TAdvCustomFormDesigner);
begin
  inherited Create(AStream,BufSize);
  Designer:=ADesigner;
end;

{ TGrabHandle }

constructor TGrabHandle.Create(AOwner: TComponent);
begin
  inherited;
  with (Owner as TGrabHandles).Designer do
  begin
    Width:=FGrabSize;
    Height:=FGrabSize;
  end;
  ControlStyle:=ControlStyle+[csReplicatable];
end;

procedure TGrabHandle.Paint;

var
  GrabRgn: HRGN;

  procedure CreateRegion;
  var
    X,Y: Integer;
    RGN: HRGN;
    Vsbl: Boolean;
  begin
    GrabRgn:=CreateRectRgn(0,0,0,0);
    with (Owner as TGrabHandles).Designer do
      for Y:=0 to Pred(FGrabSize) do
        for X:=0 to Pred(FGrabSize) do
        begin
          if FLocked then Vsbl:=FLockedGrabGlyph.Canvas.Pixels[X,Y]<>FGrabsTransparentColor
          else Vsbl:=FNormalGrabGlyph.Canvas.Pixels[X,Y]<>FGrabsTransparentColor;
          if Vsbl then
          begin
            RGN:=CreateRectRgn(X,Y,Succ(X),Succ(Y));
            try
              CombineRgn(GrabRgn,GrabRgn,RGN,RGN_OR);
            finally
              DeleteObject(RGN);
            end;
          end;
        end;
    SetWindowRgn(Handle,GrabRgn,False);
  end;

  procedure DestroyRegion;
  begin
    SetWindowRgn(Handle,0,False);
    DeleteObject(GrabRgn);
  end;

begin
  if Assigned(Parent) then
    with Canvas,(Owner as TGrabHandles).Designer do
    begin
      Brush.Color:=clBlack;
      Brush.Style:=bsSolid;
      if FUseGrabGlyphs then
      begin
        CreateRegion;
        try
          if FLocked then
            if not FLockedGrabGlyph.Empty then Draw(0,0,FLockedGrabGlyph)
            else FillRect(ClientRect)
          else
            if not FNormalGrabGlyph.Empty then Draw(0,0,FNormalGrabGlyph)
            else FillRect(ClientRect)
        finally
          DestroyRegion;
        end;
      end
      else
        if FLocked then Draw(0,0,FLockedGrab)
        else Draw(0,0,FNormalGrab);
    end;
end;

procedure TGrabHandle.WndProc(var Msg: TMessage);
begin
  inherited;
  if not FLocked then
    case Msg.Msg of
      CM_MOUSEENTER: Screen.Cursor:=crDefault;
      CM_MOUSELEAVE: SetArrowCursor;
    end;
end;

procedure TGrabHandle.SetPosition(Value: TGrabPosition);
begin
  if Value<>FPosition then
  begin
    FPosition:=Value;
    Cursor:=GetGrabCursor(FPosition);
    UpdateCoords;
  end;
end;

procedure TGrabHandle.SetRect(Value: TRect);
begin
  FRect:=Value;
  UpdateCoords;
end;

procedure TGrabHandle.SetLocked(Value: Boolean);
begin
  if Value<>FLocked then
  begin
    FLocked:=Value;
    if Visible then Invalidate;
  end;
end;

procedure TGrabHandle.UpdateCoords;
var
  ALeft,ATop: Integer;
  R: TRect;
begin
  if Assigned(Parent) then
    with (Owner as TGrabHandles).Designer do
    begin
      case FGrabMode of
        gmInside:
        begin
          case FPosition of
            gpLeftTop,gpLeftMiddle,gpLeftBottom: ALeft:=FRect.Left;
            gpMiddleTop,gpMiddleBottom: ALeft:=(FRect.Left+FRect.Right-FGrabSize) div 2;
            gpRightTop,gpRightMiddle,gpRightBottom: ALeft:=Pred(FRect.Right-FGrabSize);
          else ALeft:=0;
          end;
          case FPosition of
            gpLeftTop,gpMiddleTop,gpRightTop: ATop:=FRect.Top;
            gpLeftMiddle,gpRightMiddle: ATop:=(FRect.Top+FRect.Bottom-FGrabSize) div 2;
            gpLeftBottom,gpMiddleBottom,gpRightBottom: ATop:=Pred(FRect.Bottom-FGrabSize);
          else ATop:=0;
          end;
        end;
        gmOutside:
        begin
          case FPosition of
            gpLeftTop,gpLeftMiddle,gpLeftBottom: ALeft:=FRect.Left-FGrabSize;
            gpMiddleTop,gpMiddleBottom: ALeft:=(FRect.Left+FRect.Right-FGrabSize) div 2;
            gpRightTop,gpRightMiddle,gpRightBottom: ALeft:=Pred(FRect.Right);
          else ALeft:=0;
          end;
          case FPosition of
            gpLeftTop,gpMiddleTop,gpRightTop: ATop:=FRect.Top-FGrabSize;
            gpLeftMiddle,gpRightMiddle: ATop:=(FRect.Top+FRect.Bottom-FGrabSize) div 2;
            gpLeftBottom,gpMiddleBottom,gpRightBottom: ATop:=Pred(FRect.Bottom);
          else ATop:=0;
          end;
        end;
      else
        case FPosition of
          gpLeftTop,gpLeftMiddle,gpLeftBottom: ALeft:=FRect.Left-FGrabSize div 2;
          gpMiddleTop,gpMiddleBottom: ALeft:=(FRect.Left+FRect.Right-FGrabSize) div 2;
          gpRightTop,gpRightMiddle,gpRightBottom: ALeft:=Pred(FRect.Right-FGrabSize div 2);
        else ALeft:=0;
        end;
        case FPosition of
          gpLeftTop,gpMiddleTop,gpRightTop: ATop:=FRect.Top-FGrabSize div 2;
          gpLeftMiddle,gpRightMiddle: ATop:=(FRect.Top+FRect.Bottom-FGrabSize) div 2;
          gpLeftBottom,gpMiddleBottom,gpRightBottom: ATop:=Pred(FRect.Bottom-FGrabSize div 2);
        else ATop:=0;
        end;
      end;
      R:=Classes.Rect(ALeft,ATop,ALeft+FGrabSize,ATop+FGrabSize);
      IntersectRect(R,R,Parent.ClientRect);
      with R do SetWindowPos(Handle,0,Left,Top,Right-Left,Bottom-Top,SWP_NOZORDER);
    end;
end;

procedure TGrabHandle.SetArrowCursor;
begin
  {$IFNDEF STDCURSORS}
  Screen.Cursor:=crArrow;
  {$ELSE}
  Screen.Cursor:=crDefault;
  {$ENDIF}
end;

{ TGrabHandles }

procedure TGrabHandles.SetControl(Value: TControl);
begin
  FControl:=Value;
  if Assigned(FControl) and not (csDestroying in FControl.ComponentState) and FEnabled then Update(False)
  else
  begin
    FEnabled:=False;
    Update(True);
  end;
end;

procedure TGrabHandles.SetVisible(Value: Boolean);
var
  GP: TGrabPosition;
begin
  if Value<>FVisible then
  begin
    FVisible:=Value;
    for GP:=Succ(Low(GP)) to High(GP) do
      FItems[GP].Visible:=FEnabled and FVisible;
  end;
end;

procedure TGrabHandles.SetEnabled(Value: Boolean);
begin
  FEnabled:=Value;
  Visible:=FEnabled and FVisible;
end;

function TGrabHandles.GetParentForm: TCustomForm;
begin
  if Assigned(Designer) then Result:=Designer.ParentForm
  else Result:=nil;
end;

function TGrabHandles.GetDesigner: TAdvCustomFormDesigner;
begin
  if Assigned(Owner) then Result:=Owner as TAdvCustomFormDesigner
  else Result:=nil;
end;

constructor TGrabHandles.Create(AOwner: TComponent);
var
  GP: TGrabPosition;
begin
  inherited;
  for GP:=Succ(Low(GP)) to High(GP) do
  begin
    FItems[GP]:=TGrabHandle.Create(Self);
    with FItems[GP] do
    begin
      Position:=GP;
      Visible:=False;
      Parent:=Designer.ParentForm;
    end;
  end;
  FEnabled:=True;
end;

procedure TGrabHandles.Update(MustHide: Boolean);
var
  GP: TGrabPosition;
  VisibleGrabs,EnabledGrabs: TGrabPositions;
begin
  if (Designer <> nil) and Designer.Active then
  begin
    VisibleGrabs:=[Low(TGrabPosition)..High(TGrabPosition)];
    EnabledGrabs:=VisibleGrabs;
    if Assigned(Designer.FOnCustomizeGrabs) then
      Designer.FOnCustomizeGrabs(Designer,VisibleGrabs,EnabledGrabs);
    Application.ProcessMessages;
    FVisible:=
      FEnabled and
      Assigned(FControl) and
      // test FControl.Visible and
      not Designer.IsProtected(FControl) and
      (Designer.ControlCount<=1);
    for GP:=Succ(Low(GP)) to High(GP) do
      if Assigned(FItems[GP]) then
        with FItems[GP] do
          if Assigned(FControl) then
          begin
            if MustHide then Visible:=False;
            if Assigned(FControl.Parent) and not (csDestroying in FControl.Parent.ComponentState) then
              Parent:=FControl.Parent
            else Parent:=Designer.ParentForm;
            Rect:=FControl.BoundsRect;
            Locked:=Designer.IsLocked(FControl);
            Visible:=FVisible and (GP in VisibleGrabs);
            Enabled:=GP in EnabledGrabs;
            if FVisible then BringToFront;
          end
          else
          try
            Parent:=Designer.ParentForm;
            Visible:=False;
          except
          end;
    Application.ProcessMessages;
  end;
end;

procedure TGrabHandles.BringToFront;
var
  GP: TGrabPosition;
begin
  for GP:=Succ(Low(GP)) to High(GP) do
    if Assigned(FItems[GP]) then FItems[GP].BringToFront;
end;

function TGrabHandles.FindHandle(AHandle: HWND): TGrabPosition;
var
  GP: TGrabPosition;
begin
  Result:=gpNone;
  for GP:=Succ(Low(GP)) to High(GP) do
    if Assigned(FItems[GP]) and (FItems[GP].HandleAllocated) and
      (FItems[GP].Handle=AHandle) then
    begin
      Result:=GP;
      Break;
    end;
end;

function TGrabHandles.FindHandleControl(AHandle: HWND): TGrabHandle;
var
  GP: TGrabPosition;
begin
  GP:=FindHandle(AHandle);
  if GP<>gpNone then Result:=FItems[GP]
  else Result:=nil;
end;

function TGrabHandles.IsGrabHandle(AControl: TControl): Boolean;
var
  GP: TGrabPosition;
begin
  Result:=False;
  for GP:=Succ(Low(GP)) to High(GP) do
    if FItems[GP]=AControl then
    begin
      Result:=True;
      Break;
    end;
end;

{ TAdvCustomFormDesigner }

constructor TAdvCustomFormDesigner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPopupItems := TObjectList.Create(true);
  FLockedControls:=TStringList.Create;
  TStringList(FLockedControls).OnChange:=ListChange;
  FProtectedControls:=TStringList.Create;
  TStringList(FProtectedControls).OnChange:=ListChange;
  FTransparentControls:=TStringList.Create;
  FControls:=TList.Create;
  FAlignmentPalette:=[apStayOnTop,apShowHints];
  FGrabSize:=5;
  FClearBeforeLoad:=True;
  FMultiGrabBorder:=clGray;
  FMultiGrabFill:=clGray;
  FLockedGrabFill:=clGray;
  {$IFDEF GFDADVANCEDGRID}
  FGridStepX:=8;
  FGridStepY:=8;
  {$ELSE}
  FGridStep:=8;
  {$ENDIF}
  FDesignerColor:=clNone;
  FGridColor:=clNone;
  FShowMoveSizeHint:=True;
  FKeySelect:=True;
  FKeyMove:=True;
  {$IFDEF TFDTRIAL}
  if not (csDesigning in ComponentState) then
    MessageBox(
      0,
      'Currently you are using a XXXXXXXXXXXX trial version with some functional limitations.'#13+
      'To obtain a fully-functional component please visit http://www.tmssoftware.com',
      'XXXXXXXXXXXX - Trial Version',
      MB_OK or MB_ICONEXCLAMATION);
  {$ENDIF}
  FShowNonVisual:=True;
  FShowComponentCaptions:=False;
  FMultiSelect:=True;
  FAlignmentColorLeft:=clGray;
  FAlignmentColorTop:=clGray;
  FAlignmentColorRight:=clGray;
  FAlignmentColorBottom:=clGray;
  CreateObjects;
  RegisterIDEComponentEditor(TPageControl, TPageControlIDEEditor);
  RegisterIDEComponentEditor(TTabSheet, TTabSheetIDEEditor);
  RegisterIDEComponentEditor(TImageList, TImageListIDEEditor);
  RegisterIDEComponentEditor(TDataset, TDatasetFieldsIDEEditor);
  {$IFDEF SCRIPTER_ADOCONED}
  RegisterIDEComponentEditor(TADOConnection, TADOConnectionIDEEditor);
  {$ENDIF}
end;

destructor TAdvCustomFormDesigner.Destroy;
begin
  if not (csDesigning in ComponentState) then Active:=False;
  DestroyObjects;
  FLockedControls.Free;
  FTransparentControls.Free;
  FProtectedControls.Free;
  FControls.Free;
  FControls:=nil;
  FPopupItems.Free;
  inherited;
end;

procedure TAdvCustomFormDesigner.CreateObjects;
begin
  FAPForm:=TfrmAlignmentPalette.Create(Self);
  FLockedGrab:=TBitmap.Create;
  FLockedGrabGlyph:=TBitmap.Create;
  FMultiGrab:=TBitmap.Create;
  FMultiGrabGlyph:=TBitmap.Create;
  FNormalGrab:=TBitmap.Create;
  FNormalGrabGlyph:=TBitmap.Create;
  FHintWindow:=THintWindow.Create(Self);
  FHintWindow.Color:=clInfoBk;
  FCanvas:=TCanvas.Create;
  FHintTimer:=TTimer.Create(Self);
  FHintTimer.Enabled:=False;
  FHintTimer.OnTimer:=TimerEvent;
  FBkgBitmap:=TBitmap.Create;
  UpdateGrid;
end;

procedure TAdvCustomFormDesigner.DestroyObjects;

  procedure FreeAndNil(var Obj: TObject);
  begin
    if Assigned(Obj) then Obj.Free;
    Obj:=nil;
  end;

begin
  FreeAndNil(TObject(FHintWindow));
  FreeAndNil(TObject(FCanvas));
  FreeAndNil(TObject(FLockedGrab));
  FreeAndNil(TObject(FLockedGrabGlyph));
  FreeAndNil(TObject(FMultiGrab));
  FreeAndNil(TObject(FMultiGrabGlyph));
  FreeAndNil(TObject(FNormalGrab));
  FreeAndNil(TObject(FNormalGrabGlyph));
  FreeAndNil(TObject(FBkgBitmap));
end;

function TAdvCustomFormDesigner.GetIDEComponentEditor(AComp: TComponent): TIDEComponentEditor;

  function FindIDEEditor(AClass: TClass): TIDEComponentEditor;
  var
    c: integer;
    AItem: TIDECompEditorItem;
  begin
    result := nil;
    for c := 0 to IDEEditorList.Count - 1 do
    begin
      AItem := TIDECompEditorItem(IDEEditorList.Items[c]);
      if AClass = AItem.FCompClass then
      begin
        if AItem.FEditor = nil then
          AItem.FEditor := AItem.FEditorClass.Create(nil);
        AItem.FEditor.FDesigner := Self;
        result := AItem.FEditor;
      end;
    end;
  end;

var
  ACompClass: TClass;
begin
  result := nil;
  ACompClass := AComp.ClassType;
  if ACompClass <> nil then
    repeat
      result := FindIDEEditor(ACompClass);
      ACompClass := ACompClass.ClassParent;
    until (result <> nil) or (ACompClass = nil);

  if result <> nil then
  begin
    result.FComponent := AComp;
  end;
end;

procedure TAdvCustomFormDesigner.Update;
var
  i: Integer;
begin
  UpdateGrabs;
  UpdateContainers;
  if ControlCount>1 then
    for i:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[i]);
end;

function TAdvCustomFormDesigner.IsLocked(AControl: TControl): Boolean;
begin
  if ValidControl(AControl) then
    if AControl=ParentForm then Result:=True
    else
      case GetEditBehaviour(AControl) of
        ebDefault,ebDefaultRuntime:
        begin
          case FLockChildren of
            cmNormal: Result:=InTheList(FLockedControls,AControl) or InTheList(FLockedControls,AControl.Parent);
            cmRecurse:
              repeat
                Result:=InTheList(FLockedControls,AControl);
                if Result then Break
                else
                  if ValidControl(AControl) then AControl:=AControl.Parent
                  else AControl:=nil;
              until (AControl=nil) or (AControl=ParentForm);
          else Result:=InTheList(FLockedControls,AControl);
          end;
          Result:=Result xor FLockedInverse;
        end;
        ebLocked,ebLockedRuntime: Result:=True;
      else Result:=False;
      end
  else Result:=False;
end;

function TAdvCustomFormDesigner.IsProtected(AControl: TControl): Boolean;

  function IsTopLevel(AControl: TControl): Boolean;
  var
    i: Integer;
  begin
    Result:=False;
    if Assigned(AControl) then
    begin
      if Assigned(ParentForm) then
      begin
        with ParentForm do
          for i:=0 to Pred(ComponentCount) do
            if Components[i]=AControl then
            begin
              Result:=True;
              Exit;
            end;
      end;
    end;
  end;

  function FindTopLevel(AControl: TControl): TControl;
  begin
    Result:=nil;
    while Assigned(AControl) do
    begin
      if IsTopLevel(AControl) then
      begin
        Result:=AControl;
        Exit;
      end;
      AControl:=AControl.Parent;
    end;
  end;

begin
  if ValidControl(AControl) then
    case GetEditBehaviour(AControl) of
      ebDefault,ebDefaultRuntime:
      begin
        if Assigned(FDesignControl) then
        begin
          Result:=True;
          while Assigned(AControl.Parent) do
          begin
            AControl:=AControl.Parent;
            if AControl=FDesignControl then
            begin
              Result:=False;
              Exit;
            end;
          end;
        end
        else
        begin
          AControl:=FindTopLevel(AControl);
          if not Assigned(AControl) or (AControl=ParentForm) then Result:=True
          else
          begin
            case FProtectChildren of
              cmNormal: Result:=InTheList(FProtectedControls,AControl) or InTheList(FProtectedControls,AControl.Parent);
              cmRecurse:
                repeat
                  Result:=InTheList(FProtectedControls,AControl);
                  if Result then Break
                  else
                    if ValidControl(AControl) then AControl:=AControl.Parent
                    else AControl:=nil;
                until (AControl=nil) or (AControl=ParentForm);
            else Result:=InTheList(FProtectedControls,AControl);
            end;
            Result:=Result xor FProtectedInverse;
          end;
        end;
      end;
      ebProtected: Result:=True;
    else Result:=False;
    end
  else Result:=False;
end;

function TAdvCustomFormDesigner.IsTransparent(AControl: TControl): Boolean;
begin
  if ValidControl(AControl) then
    case GetEditBehaviour(AControl) of
      ebDefault,ebDefaultRuntime:
        if AControl=ParentForm then Result:=True
        else
        begin
          case FTransparentChildren of
            cmNormal: Result:=InTheList(FTransparentControls,AControl) or InTheList(FTransparentControls,AControl.Parent);
            cmRecurse:
              repeat
                Result:=InTheList(FTransparentControls,AControl);
                if Result then Break
                else
                  if ValidControl(AControl) then AControl:=AControl.Parent
                  else AControl:=nil;
              until (AControl=nil) or (AControl=ParentForm);
          else Result:=InTheList(FTransparentControls,AControl);
          end;
          Result:=Result xor FTransparentInverse;
        end;
      ebTransparent,ebTransparentRuntime: Result:=True;
    else Result:=False;
    end
  else Result:=False;
end;

function TAdvCustomFormDesigner.GetControlCount: Integer;
begin
  if Assigned(FControls) then Result:=FControls.Count
  else Result:=0;
end;

function TAdvCustomFormDesigner.GetLocked: Boolean;
begin
  Result:=FLockCounter>0;
end;

function TAdvCustomFormDesigner.GetSynchroLocked: Boolean;
begin
  Result:=FSynchroLockCounter>0;
end;

function TAdvCustomFormDesigner.GetParentForm: TCustomForm;
begin
  if Assigned(FForm) then Result:=FForm
  else
    if Assigned(Owner) and (Owner is TCustomForm) then Result:=TCustomForm(Owner)
    else Result:=nil;
end;

procedure TAdvCustomFormDesigner.SetParentForm(const Value: TCustomForm);
begin
  if FForm<>Value then
  begin
    if not (csDesigning in ComponentState) then LeaveMouseAction;
    if Assigned(FDefaultProc) then SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FDefaultProc));
    {$IFNDEF NOREMOVENOTIFICATION}
    if Assigned(FForm) then FForm.RemoveFreeNotification(Self);
    {$ENDIF}
    if Assigned(FForm) then FForm.Invalidate;
    FForm:=Value;
    if Assigned(FForm) then FForm.Invalidate;
    if Assigned(FForm) then FForm.FreeNotification(Self);
    if Assigned(FWinProc) then SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FWinProc));
  end;
end;

function TAdvCustomFormDesigner.GetFormData: string;
var
  StringStream: TStringStream;
begin
  StringStream:=TStringStream.Create('');
  try
    SaveToStream(StringStream,dfmText);
    Result:=StringStream.DataString;
  finally
    StringStream.Free;
  end;
end;

procedure TAdvCustomFormDesigner.SetFormData(const Value: string);
var
  StringStream: TStringStream;
begin
  StringStream:=TStringStream.Create(Value);
  try
    LoadFromStream(StringStream,dfmText);
  finally
    StringStream.Free;
  end;
end;

type
  TDesignAccessComponent = class(TComponent)
  public
    procedure SetDesigningPublic(Value: Boolean);
  end;

procedure TDesignAccessComponent.SetDesigningPublic(Value: Boolean);
begin
  {$IFNDEF GFDNOCSDESIGNING}
  SetDesigning(Value);
  {$ENDIF}
end;

procedure TAdvCustomFormDesigner.SetActive(Value: Boolean);

var
  i: Integer;

  function ParentFormOK: Boolean;
  begin
    Result := Assigned(ParentForm);
    if Result then
      ParentForm.HandleNeeded;
  end;

begin
  if Value<>FActive then
  begin
    if Value then
    begin
      (*if Assigned(Owner) then
        if Owner is TCustomForm then
        begin
          FGrabHandles:=TGrabHandles.Create(Self);
          Control:=nil;
          UpdateGrabs;
          if Assigned(ParentForm) then ParentForm.ActiveControl:=nil;
        end
        else raise EFormDesigner.Create('Owner of TAdvFormDesigner must be TCustomForm descendant.')
      else raise EFormDesigner.Create('TAdvFormDesigner has no parent window.');*)

(******)
          FGrabHandles:=TGrabHandles.Create(Self);
          Control:=nil;
          UpdateGrabs;
          if Assigned(ParentForm) then ParentForm.ActiveControl:=nil;
(******)

      if Designers <> nil then
        with Designers do
          if IndexOf(Self)=-1 then Add(Self);
      if MessageProcessor=mpEvent then
      begin
        if Designers.Count=1 then
        begin
          if not Assigned(SavedApplicationMessage) then SavedApplicationMessage:=Application.OnMessage;
          Application.OnMessage:=ApplicationMessage;
        end
      end
      else
        if HookID=0 then HookID:=SetWindowsHookEx(WH_GETMESSAGE,HookProc,HInstance,GetCurrentThreadID);
      if (Designers <> nil) and (Designers.Count=1) then
      begin
        if not Assigned(SavedApplicationIdle) then SavedApplicationIdle:=Application.OnIdle;
        Application.OnIdle:=ApplicationIdle;
      end;
      if ParentFormOK then
        with ParentForm do
        begin
          {$IFNDEF GFDENABLEAUTORANGE}
          DisableAutoRange;
          {$ENDIF}
          //FDefaultColor:=Color;
          Invalidate;
        end;
      Update;
      CreateContainers;
      if apAutoShow in FAlignmentPalette then ShowAlignmentPalette;
    end
    else
    begin
      Designers.Remove(Self);
      Application.OnIdle:=SavedApplicationIdle;
      if MessageProcessor=mpEvent then
      begin
        if Designers.Count=0 then Application.OnMessage:=SavedApplicationMessage;
      end
      else
        if (Designers = nil) or (Designers.Count=0) then
        begin
          UnhookWindowsHookEx(HookID);
          HookID:=0;
        end;
      if not (csDestroying in ComponentState) then
      begin
        FAPForm.Hide;
        LeaveMouseAction;
        //if ParentFormOK then ParentForm.Color:=FDefaultColor;
        Control:=nil;
        if Assigned(FGrabHandles) then
        begin
          FGrabHandles.Free;
          FGrabHandles:=nil;
        end;
        DestroyContainers;
      end;
      if ParentFormOK then
        with ParentForm do
        begin
          {$IFNDEF GFDENABLEAUTORANGE}
          EnableAutoRange;
          {$ENDIF}
          //Color:=FDefaultColor;
          Invalidate;
        end;
    end;
    FActive:=Value;
    if ParentFormOK then
      with ParentForm do
      begin
        for i:=0 to Pred(ComponentCount) do
          if (Components[i] is TControl) and not IsProtected(TControl(Components[i])) then
          begin
            if not (GetEditBehaviour(TControl(Components[i])) in [ebDefaultRuntime,ebTransparentRuntime,ebLockedRuntime]) then
              TDesignAccessComponent(Components[i]).SetDesigningPublic(FActive);
            if (Components[i] is TWinControl) and
              TWinControl(Components[i]).HandleAllocated then
              with TWinControl(Components[i]) do
                if FActive then
                begin
                  {$IFNDEF GFDHIDEINVISIBLE}
                  if csDesigning in ComponentState then
                    ShowWindow(Handle,SW_SHOW);
                  {$ENDIF}
                  EnableWindow(Handle,True);
                end
                else
                begin
                  if not Visible then ShowWindow(Handle,SW_HIDE);
                  EnableWindow(Handle,Enabled);
                end;
          end;
      end;
    if FActive then
    begin
      if ParentFormOK then
        FDefaultProc := TFarProc(GetWindowLong(ParentForm.Handle,GWL_WNDPROC));
      {$WARNINGS OFF}
      FWinProc:=MakeObjectInstance(WinProc);
      {$WARNINGS ON}
      SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FWinProc));
      FModified:=False;
    end
    else
    begin
      if ParentFormOK and Assigned(FDefaultProc) then
        SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FDefaultProc));
      {$WARNINGS OFF}
      if Assigned(FWinProc) then FreeObjectInstance(FWinProc);
      {$WARNINGS ON}
      FDefaultProc := nil;
      FWinProc:=nil;
    end;
    Screen.Cursor:=crDefault;
    if ParentFormOK then ParentForm.Invalidate;
    if FActive then
    begin
      if Assigned(FOnActivate) then FOnActivate(Self);
    end
    else
    begin
      if Assigned(FOnDeactivate) then FOnDeactivate(Self);
    end;
  end;
end;

procedure TAdvCustomFormDesigner.SetMessageProcessor(Value: TMessageProcessor);
begin
  if FActive then EFormDesigner.Create('Cannot change message processor when TAdvFormDesigner is active')
  else
    if Value<>FMessageProcessor then FMessageProcessor:=Value;
end;

{$IFDEF GFDADVANCEDGRID}

procedure TAdvCustomFormDesigner.SetGridStepX(Value: Integer);
begin
  if Value<2 then Value:=2;
  if Value>128 then Value:=128;
  if Value<>FGridStepX then
  begin
    FGridStepX:=Value;
    UpdateGrid;
  end;
end;

procedure TAdvCustomFormDesigner.SetGridStepY(Value: Integer);
begin
  if Value<2 then Value:=2;
  if Value>128 then Value:=128;
  if Value<>FGridStepY then
  begin
    FGridStepY:=Value;
    UpdateGrid;
  end;
end;

{$ELSE}

procedure TAdvCustomFormDesigner.SetGridStep(Value: Integer);
begin
  if Value<2 then Value:=2;
  if Value>128 then Value:=128;
  if Value<>FGridStep then
  begin
    FGridStep:=Value;
    UpdateGrid;
    if DisplayGrid and Assigned(ParentForm) then
      ParentForm.Invalidate;
  end;
end;

{$ENDIF}
procedure TAdvCustomFormDesigner.SetDisplayGrid(Value: Boolean);
begin
  if Value<>FDisplayGrid then
  begin
    FDisplayGrid:=Value;
    if Assigned(ParentForm) then ParentForm.Invalidate;
  end;
end;

procedure TAdvCustomFormDesigner.SetDesignerColor(Value: TColor);
begin
  if Value<>FDesignerColor then
  begin
    FDesignerColor:=Value;
    UpdateGrid;
  end;
end;

procedure TAdvCustomFormDesigner.SetGridColor(Value: TColor);
begin
  if Value<>FGridColor then
  begin
    FGridColor:=Value;
    UpdateGrid;
  end;
end;

procedure TAdvCustomFormDesigner.SetMoveSizeHint(Value: Boolean);
begin
  if Value<>FShowMoveSizeHint then
  begin
    FShowMoveSizeHint:=Value;
    if not FShowMoveSizeHint then HideHint;
  end;
end;

procedure TAdvCustomFormDesigner.SetComponentHint(Value: Boolean);
begin
  if Value<>FShowComponentHint then
  begin
    FShowComponentHint:=Value;
    if not FShowComponentHint then HideHint;
  end;
end;

procedure TAdvCustomFormDesigner.SetGrabSize(Value: Integer);
begin
  if Value<3 then Value:=3;
  if Value>32 then Value:=32;
  if Value<>FGrabSize then
  begin
    FGrabSize:=Value;
    UpdateGrabs;
  end;
end;

procedure TAdvCustomFormDesigner.SetAlignmentPalette(Value: TAlignmentPaletteOptions);
begin
  FAlignmentPalette:=Value;
  if Assigned(FAPForm) then
    with TfrmAlignmentPalette(FAPForm) do
    begin
      if apStayOnTop in FAlignmentPalette then FormStyle:=fsStayOnTop
      else FormStyle:=fsNormal;
      ShowHint:=apShowHints in FAlignmentPalette;
      SetFlatButtons(apFlatButtons in FAlignmentPalette);
    end;
end;

procedure TAdvCustomFormDesigner.SetNormalGrabBorder(Value: TColor);
begin
  if Value<>FNormalGrabBorder then
  begin
    FNormalGrabBorder:=Value;
    UpdateGrabs;
  end;
end;

procedure TAdvCustomFormDesigner.SetNormalGrabFill(Value: TColor);
begin
  if Value<>FNormalGrabFill then
  begin
    FNormalGrabFill:=Value;
    UpdateGrabs;
  end;
end;

procedure TAdvCustomFormDesigner.SetNormalGrabGlyph(Value: TBitmap);
begin
  FNormalGrabGlyph.Assign(Value);
end;

procedure TAdvCustomFormDesigner.SetMultiGrabBorder(Value: TColor);
begin
  if Value<>FMultiGrabBorder then
  begin
    FMultiGrabBorder:=Value;
    UpdateGrabs;
  end;
end;

procedure TAdvCustomFormDesigner.SetMultiGrabFill(Value: TColor);
begin
  if Value<>FMultiGrabFill then
  begin
    FMultiGrabFill:=Value;
    UpdateGrabs;
  end;
end;

procedure TAdvCustomFormDesigner.SetMultiGrabGlyph(Value: TBitmap);
begin
  FMultiGrabGlyph.Assign(Value);
end;

procedure TAdvCustomFormDesigner.SetLockedGrabBorder(Value: TColor);
begin
  if Value<>FLockedGrabBorder then
  begin
    FLockedGrabBorder:=Value;
    UpdateGrabs;
  end;
end;

procedure TAdvCustomFormDesigner.SetLockedGrabFill(Value: TColor);
begin
  if Value<>FLockedGrabFill then
  begin
    FLockedGrabFill:=Value;
    UpdateGrabs;
  end;
end;

procedure TAdvCustomFormDesigner.SetLockedGrabGlyph(Value: TBitmap);
begin
  FLockedGrabGlyph.Assign(Value);
end;

procedure TAdvCustomFormDesigner.SetShowNonVisual(const Value: Boolean);
begin
  if Value<>FShowNonVisual then
  begin
    FShowNonVisual:=Value;
    if FShowNonVisual then CreateContainers
    else DestroyContainers;
  end;
end;

procedure TAdvCustomFormDesigner.SetShowComponentCaptions(const Value: Boolean);
begin
  if Value<>FShowComponentCaptions then
  begin
    FShowComponentCaptions:=Value;
    if not (csDesigning in ComponentState) then
    begin
      DestroyContainers;
      if FShowNonVisual then CreateContainers;
    end;
  end;
end;

procedure TAdvCustomFormDesigner.SetMultiSelect(const Value: Boolean);
begin
  if Value<>FMultiSelect then
  begin
    FMultiSelect:=Value;
    UnselectAll;
  end;
end;

procedure TAdvCustomFormDesigner.SetDesignControl(const Value: TWinControl);
begin
  FDesignControl:=Value;
  if Assigned(FDesignControl) and FActive then LeaveMouseAction;
end;

procedure TAdvCustomFormDesigner.SetGrabMode(const Value: TGrabMode);
begin
  if Value<>FGrabMode then
  begin
    FGrabMode:=Value;
    if Assigned(FGrabHandles) then FGrabHandles.Update(False);
  end;
end;

procedure TAdvCustomFormDesigner.SetUseGrabGlyphs(const Value: Boolean);
begin
  if FUseGrabGlyphs<>Value then
  begin
    FUseGrabGlyphs:=Value;
    if Assigned(FGrabHandles) then UpdateGrabs;
  end;
end;

procedure TAdvCustomFormDesigner.SetGrabsTransparentColor(const Value: TColor);
begin
  if FGrabsTransparentColor<>Value then
  begin
    FGrabsTransparentColor:=Value;
    if Assigned(FGrabHandles) then UpdateGrabs;
  end;
end;

function TAdvCustomFormDesigner.GetControl: TControl;
begin
  if Assigned(FControls) then
    with FControls do
      if Count>0 then Result:=FControls[0]
      else Result:=nil
  else Result:=nil;
end;

procedure TAdvCustomFormDesigner.SetControl(Value: TControl);
begin
  {$IFDEF TFDTRIAL}
  if ValidControl(Value) and (Value.Parent<>ParentForm) then
  begin
    Control:=nil;
    ShowTrialWarning;
    Exit;
  end;
  {$ENDIF}
  if Value=ParentForm then Value:=nil;
  if (Value<>Control) and not IsTransparent(Value) and not IsProtected(Value) then
  begin
    inc(FUpdatingSelection);
    try
      with FControls do
        while Count>0 do DeleteControl(Controls[0]);
    finally
      dec(FUpdatingSelection);
    end;

    FGrabHandles.Enabled:=Assigned(Value);
    if Value<>ParentForm then AddControl(Value);
    if ValidControl(Control) and Assigned(ParentForm) then ParentForm.ActiveControl:=nil;
    Application.ProcessMessages;
    if not ValidControl(Control) then
    begin
      if Assigned(FOnSelectControl) then FOnSelectControl(Self,Control);
      DoSelectionChange;
    end;
  end;
end;

function TAdvCustomFormDesigner.GetControlByIndex(Index: Integer): TControl;
begin
  with FControls do
    if (Index>=0) and (Index<Count) then Result:=FControls[Index]
    else
    begin
      Result:=nil;
      EFormDesigner.Create('Index of Controls array is out or range.');
    end;
end;

function TAdvCustomFormDesigner.GetComponent: TComponent;
begin
  Result:=Control;
  if Result is TComponentContainer then Result:=TComponentContainer(Result).Component;
end;

procedure TAdvCustomFormDesigner.SetComponent(Value: TComponent);
begin
  if Value is TControl then Control:=TControl(Value)
  else Control:=FindComponentContainer(Value);
end;

function TAdvCustomFormDesigner.GetComponentByIndex(Index: Integer): TComponent;
begin
  Result:=Controls[Index];
  if Result is TComponentContainer then Result:=TComponentContainer(Result).Component;
end;

procedure TAdvCustomFormDesigner.SetLockedControls(Value: TStrings);
begin
  FLockedControls.Assign(Value);
  if FActive and IsLocked(Control) then Control:=nil;
end;

procedure TAdvCustomFormDesigner.SetLockedInverse(Value: Boolean);
begin
  if Value<>FLockedInverse then
  begin
    FLockedInverse:=Value;
    if FActive and IsLocked(Control) then Control:=nil;
  end;
end;

procedure TAdvCustomFormDesigner.SetLockChildren(Value: TChildrenMode);
begin
  if Value<>FLockChildren then
  begin
    FLockChildren:=Value;
    if FActive and IsLocked(Control) then Control:=nil;
  end;
end;

procedure TAdvCustomFormDesigner.SetProtectedControls(Value: TStrings);
begin
  FProtectedControls.Assign(Value);
  if FActive and IsProtected(Control) then Control:=nil;
end;

procedure TAdvCustomFormDesigner.SetProtectedInverse(Value: Boolean);
begin
  if Value<>FProtectedInverse then
  begin
    FProtectedInverse:=Value;
    if FActive and IsProtected(Control) then Control:=nil;
  end;
end;

procedure TAdvCustomFormDesigner.SetProtectChildren(Value: TChildrenMode);
begin
  if Value<>FProtectChildren then
  begin
    FProtectChildren:=Value;
    if FActive and IsProtected(Control) then Control:=nil;
  end;
end;

procedure TAdvCustomFormDesigner.SetProtectMode(Value: TProtectMode);
begin
  if Value<>FProtectMode then
  begin
    FProtectMode:=Value;
    if FActive and (ProtectMode=pmUnselect) and
      Assigned(ParentForm) and (ParentForm.ActiveControl<>nil) then Control:=nil;
  end;
end;

procedure TAdvCustomFormDesigner.SetTransparentControls(Value: TStrings);
begin
  FTransparentControls.Assign(Value);
  if FActive and IsTransparent(Control) then Control:=nil;
end;

procedure TAdvCustomFormDesigner.SetTransparentInverse(Value: Boolean);
begin
  if Value<>FTransparentInverse then
  begin
    FTransparentInverse:=Value;
    if FActive and IsTransparent(Control) then Control:=nil;
  end;
end;

procedure TAdvCustomFormDesigner.SetTransparentChildren(Value: TChildrenMode);
begin
  if Value<>FTransparentChildren then
  begin
    FTransparentChildren:=Value;
    if FActive and IsTransparent(Control) then Control:=nil;
  end;
end;

procedure TAdvCustomFormDesigner.DrawPlacingRect;
var
  R: TRect;
begin
  if Assigned(ParentForm) then
    with FCanvas do
    begin
      Handle:=GetDCEx(ParentForm.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS);
      try
        with Pen do
        begin
          Style:=psSolid;
          Mode:=pmXor;
          Width:=2;
          Color:=clGray;
        end;
        Brush.Style:=bsClear;
        if FSnapToGrid then
          with FPlacingRect do
          begin
            Left:=Round(Left/FGridStep)*FGridStep;
            Top:=Round(Top/FGridStep)*FGridStep;
            Right:=Succ(Round(Right/FGridStep)*FGridStep);
            Bottom:=Succ(Round(Bottom/FGridStep)*FGridStep);
          end;
        R:=FPlacingRect;
        MapWindowPoints(FPlacingParent.Handle,ParentForm.Handle,R,2);
        with R do Rectangle(Left+1,Top+1,Right,Bottom);
      finally
        ReleaseDC(0,FCanvas.Handle);
        FCanvas.Handle:=0;
      end;
    end;
end;

procedure TAdvCustomFormDesigner.DrawSelectRect;
var
  SR: TRect;
begin
  if Assigned(ParentForm) then
    with FCanvas do
    begin
      Handle:=GetDCEx(ParentForm.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS);
      try
        with Pen do
        begin
          Style:=psSolid;
          Mode:=pmXor;
          Width:=1;
          Style:=psDot;
          Color:=clWhite;
        end;
        Brush.Style:=bsClear;
        SR:=FSelectRect;
        MapWindowPoints(0,ParentForm.Handle,SR,2);
        with SR do Rectangle(Left+1,Top+1,Right,Bottom);
      finally
        ReleaseDC(0,FCanvas.Handle);
        FCanvas.Handle:=0;
      end;
    end;
end;

procedure TAdvCustomFormDesigner.DrawDragRects;

var
  i: Integer;
  DR: TRect;
  Offset: TPoint;
  FAlignRect: TRect;
  FormColor: TColor;

  function Max(X1,X2: Integer): Integer;
  begin
    if X1>X2 then Result:=X1
    else Result:=X2;
  end;

  function Min(X1,X2: Integer): Integer;
  begin
    if X1<X2 then Result:=X1
    else Result:=X2;
  end;

  function GetAlignment(LP: TLinePosition; var P: TPoint): Boolean;

  var
    i: Integer;
    C: TControl;

    function FormX(Control: TControl; X: Integer): Integer;
    var
      P: TPoint;
    begin
      P.X:=X;
      P.Y:=0;
      if FAlignmentEntireForm then
        P:=ParentForm.ScreenToClient(Control.Parent.ClientToScreen(P));
      Result:=P.X;
    end;

    function FormY(Control: TControl; Y: Integer): Integer;
    var
      P: TPoint;
    begin
      P.X:=0;
      P.Y:=Y;
      if FAlignmentEntireForm then
        P:=ParentForm.ScreenToClient(Control.Parent.ClientToScreen(P));
      Result:=P.Y;
    end;

  begin
    Result:=False;
    P.X:=MaxInt;
    P.Y:=-MaxInt;
    with ParentForm do
      for i:=0 to Pred(ComponentCount) do
        if Components[i] is TControl then
        begin
          C:=TControl(Components[i]);
          if ValidControl(C) and Assigned(C.Parent) and (C.Parent.Showing) and
            (FAlignmentEntireForm or (C.Parent=Control.Parent)) then
            with C do
              case LP of
                lpLeft:
                  if FAlignRect.Left=FormX(C,Left) then
                  begin
                    P.X:=Min(P.X,FormY(C,Top));
                    P.Y:=Max(P.Y,FormY(C,Top+Height));
                    Result:=True;
                  end;
                lpTop:
                  if FAlignRect.Top=FormY(C,Top) then
                  begin
                    P.X:=Min(P.X,FormX(C,Left));
                    P.Y:=Max(P.Y,FormX(C,Left+Width));
                    Result:=True;
                  end;
                lpRight:
                  if FAlignRect.Right=FormX(C,Left+Width) then
                  begin
                    P.X:=Min(P.X,FormY(C,Top));
                    P.Y:=Max(P.Y,FormY(C,Top+Height));
                    Result:=True;
                  end;
                lpBottom:
                  if FAlignRect.Bottom=FormY(C,Top+Height) then
                  begin
                    P.X:=Min(P.X,FormX(C,Left));
                    P.Y:=Max(P.Y,FormX(C,Left+Width));
                    Result:=True;
                  end;
              end;
        end;
    if Result then
      with FAlignRect do
        case LP of
          lpLeft,lpRight:
          begin
            if P.X>Top then P.X:=Top;
            if P.Y<Bottom then P.Y:=Bottom;
          end;
          lpTop,lpBottom:
          begin
            if P.X>Left then P.X:=Left;
            if P.Y<Right then P.Y:=Right;
          end;
        end;
  end;

begin
  with FAlignRect do
  begin
    Left:=MaxInt;
    Top:=MaxInt;
    Right:=-MaxInt;
    Bottom:=-MaxInt;
  end;
  if not ValidControl(Control) then Exit;
  if Assigned(ParentForm) then
    with FCanvas do
    begin
      Handle:=GetDCEx(Control.Parent.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS or DCX_PARENTCLIP);
      try
        Offset.X:=FDragRect.Left-Control.Left;
        Offset.Y:=FDragRect.Top-Control.Top;
        with Control.Parent do
        begin
          DR:=ClientRect;
          if GetParent(ParentForm.Handle)<>0 then
            MapWindowPoints(0,GetParent(ParentForm.Handle),DR,2);
        end;
        with Pen do
        begin
          Style:=psSolid;
          Mode:=pmXor;
          Width:=2;
          Color:=clGray;
        end;
        Brush.Style:=bsClear;
        for i:=0 to Pred(ControlCount) do
        begin
          if i=0 then DR:=FDragRect
          else
          begin
            DR:=Controls[i].BoundsRect;
            OffsetRect(DR,Offset.X,Offset.Y);
          end;
          with FAlignRect do
          begin
            Left:=Min(Left,DR.Left);
            Top:=Min(Top,DR.Top);
            Right:=Max(Right,DR.Right);
            Bottom:=Max(Bottom,DR.Bottom);
          end;
          with DR do Rectangle(Left+1,Top+1,Right,Bottom);
        end;
        if FAlignmentLines<>[] then
        begin
          if FAlignmentEntireForm then
          begin
            ReleaseDC(0,FCanvas.Handle);
            FCanvas.Handle:=GetDCEx(ParentForm.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS);
          end;
          if FDesignerColor<>clNone then FormColor:=FDesignerColor
          else FormColor:=ParentForm.Color;
          FormColor:=ColorToRGB(FormColor);
          if ControlCount=1 then FAlignRect:=FDragRect;
          if FAlignmentEntireForm then
            MapWindowPoints(Control.Parent.Handle,ParentForm.Handle,FAlignRect,2);
          Pen.Width:=1;
          with FAlignRect do
          begin
            if (FDragHandle in [gpNone,gpLeftMiddle,gpLeftTop,gpLeftBottom]) and
              (lpLeft in FAlignmentLines) and GetAlignment(lpLeft,Offset) then
            begin
              Pen.Color:=FAlignmentColorLeft xor FormColor;
              MoveTo(Left-2,Offset.X);
              LineTo(Left-2,Pred(Offset.Y));
            end;
            if (FDragHandle in [gpNone,gpLeftTop,gpMiddleTop,gpRightTop]) and
              (lpTop in FAlignmentLines) and GetAlignment(lpTop,Offset) then
            begin
              Pen.Color:=FAlignmentColorTop xor FormColor;
              MoveTo(Offset.X,Top-2);
              LineTo(Pred(Offset.Y),Top-2);
            end;
            if (FDragHandle in [gpNone,gpRightTop,gpRightMiddle,gpRightBottom]) and
              (lpRight in FAlignmentLines) and GetAlignment(lpRight,Offset) then
            begin
              Pen.Color:=FAlignmentColorRight xor FormColor;
              MoveTo(Right+1,Offset.X);
              LineTo(Right+1,Pred(Offset.Y));
            end;
            if (FDragHandle in [gpNone,gpLeftBottom,gpMiddleBottom,gpRightBottom]) and
              (lpBottom in FAlignmentLines) and GetAlignment(lpBottom,Offset) then
            begin
              Pen.Color:=FAlignmentColorBottom xor FormColor;
              MoveTo(Offset.X,Bottom+1);
              LineTo(Pred(Offset.Y),Bottom+1);
            end;
          end;
        end;
      finally
        ReleaseDC(0,FCanvas.Handle);
        FCanvas.Handle:=0;
      end;
    end;
end;

procedure TAdvCustomFormDesigner.DrawMultiSelect(AControl: TControl);
begin
  if Assigned(FGrabHandles) and FGrabHandles.IsGrabHandle(AControl) then Exit;
  if ValidControl(AControl) and Assigned(AControl.Parent) then
  begin
    AControl.Update;
    if AControl is TWinControl then
      with TCanvas.Create do
      try
        Handle:=GetDCEx(TWinControl(AControl).Handle,0,DCX_CACHE {$IFNDEF GFDHIDDENGRABS}or DCX_CLIPSIBLINGS or DCX_CLIPCHILDREN{$ENDIF});
        with Brush do
        begin
          Style:=bsSolid;
          Color:=clGray;
        end;
        with FMultiGrabGlyph do
        begin
          TransparentMode:=tmFixed;
          TransparentColor:=FGrabsTransparentColor;
          Transparent:=True;
        end;
        with AControl.ClientRect do
          if FUseGrabGlyphs then
          begin
            Draw(Left,Top,FMultiGrabGlyph);
            Draw(Left,Bottom-FGrabSize,FMultiGrabGlyph);
            Draw(Right-FGrabSize,Top,FMultiGrabGlyph);
            Draw(Right-FGrabSize,Bottom-FGrabSize,FMultiGrabGlyph);
          end
          else
          begin
            Draw(Left,Top,FMultiGrab);
            Draw(Left,Bottom-FGrabSize,FMultiGrab);
            Draw(Right-FGrabSize,Top,FMultiGrab);
            Draw(Right-FGrabSize,Bottom-FGrabSize,FMultiGrab);
          end;
      finally
        ReleaseDC(TWinControl(AControl).Handle,Handle);
        Handle:=0;
        Free;
      end
    else
    begin
      with TControlCanvas.Create do
      try
        Control:=AControl;
        with Brush do
        begin
          Style:=bsSolid;
          Color:=clGray;
        end;
        with AControl.ClientRect do
        begin
          Draw(Left,Top,FMultiGrab);
          Draw(Left,Bottom-FGrabSize,FMultiGrab);
          Draw(Right-FGrabSize,Top,FMultiGrab);
          Draw(Right-FGrabSize,Bottom-FGrabSize,FMultiGrab);
        end;
      finally
        Control:=nil;
        Free;
      end;
    end;
  end;
end;

function TAdvCustomFormDesigner.InTheList(List: TStrings; AControl: TControl): Boolean;
var
  AName: string;
  AComponent: TComponent;
begin
  if Assigned(List) and ValidControl(AControl) then
  begin
    if (AControl is TComponentContainer) then
    begin
      if (TComponentContainer(AControl).Component <> nil) then
        AName := TComponentContainer(AControl).Component.Name
      else
        AName := '';
    end
    else AName:=AControl.Name;
    Result:=List.IndexOf(AName)<>-1;
    if not Result then
    begin
      AComponent:=AControl.Owner;
      while not Result and Assigned(AComponent) do
      begin
        AName:=AComponent.Name+'.'+AName;
        Result:=List.IndexOf(AName)<>-1;
        AComponent:=AComponent.Owner;
      end;
    end
  end
  else Result:=False;
end;

procedure TAdvCustomFormDesigner.UpdateGrid;
var
  X,Y: Integer;
  BkColor,DotColor: TColor;
begin
  if Assigned(FBkgBitmap) then
    with FBkgBitmap,Canvas do
    begin
      if FDesignerColor=clNone then
        if Assigned(ParentForm) then BkColor:=ParentForm.Color
        else BkColor:=clBtnFace
      else BkColor:=FDesignerColor;
      if FGridColor=clNone then
        if Assigned(ParentForm) then DotColor:=ParentForm.Font.Color
        else DotColor:=clBlack
      else DotColor:=FGridColor;
      {$IFDEF GFDADVANCEDGRID}
      {$IFDEF GFDNOFASTGRID}
      Width:=FGridStepX;
      Height:=FGridStepY;
      {$ELSE}
      Width:=Screen.Width div FGridStepX*FGridStepX;
      Height:=Screen.Height div FGridStepY*FGridStepY;
      {$ENDIF}
      {$ELSE}
      {$IFDEF GFDNOFASTGRID}
      Width:=FGridStep;
      Height:=FGridStep;
      {$ELSE}
      Width:=Screen.Width div FGridStep*FGridStep;
      Height:=Screen.Height div FGridStep*FGridStep;
      {$ENDIF}
      {$ENDIF}
      Brush.Color:=BkColor;
      FillRect(Rect(0,0,Width,Height));
      {$IFDEF GFDADVANCEDGRID}
      for Y:=0 to Height div FGridStepY do
        for X:=0 to Width div FGridStepX do
          Pixels[X*FGridStepX,Y*FGridStepY]:=DotColor;
      {$ELSE}
      for Y:=0 to Height div FGridStep do
        for X:=0 to Width div FGridStep do
          Pixels[X*FGridStep,Y*FGridStep]:=DotColor;
      {$ENDIF}
    end;
end;

procedure TAdvCustomFormDesigner.ShowHint(AHint: string; Mode: THintMode);
var
  R: TRect;
  P: TPoint;
  Offset: Integer;
begin
  if Assigned(FHintWindow) then
    if ((FShowMoveSizeHint and (Mode<>hmCustom)) or (FShowComponentHint and (Mode=hmCustom))) and (AHint<>'') then
      with FHintWindow do
      begin
        HideHint;
        with Self.FControls do
          if Count>1 then
            for Offset:=0 to Pred(Count) do DrawMultiSelect(Self.Controls[Offset]);
        R:=CalcHintRect(255,AHint,nil);
        GetCursorPos(P);
        case Mode of
          hmCustom: Offset:=24;
          hmMove: Offset:=18
        else Offset:=8;
        end;
        OffsetRect(R,P.X,P.Y+Offset);
        ActivateHint(R,AHint);
      end
    else HideHint;
end;

procedure TAdvCustomFormDesigner.HideHint;
begin
  if Assigned(FHintWindow) then FHintWindow.ReleaseHandle;
end;

function TAdvCustomFormDesigner.GetControlsOrigin: TPoint;
var
  i: Integer;
begin
  case ControlCount of
    0: Result:=Point(0,0);
    1: with Control do Result:=Point(Left,Top);
  else
  begin
    Result:=Point(MaxInt,MaxInt);
    for i:=0 to Pred(ControlCount) do
      with Controls[i],Result do
      begin
        if Left<X then X:=Left;
        if Top<Y then Y:=Top;
      end;
  end;
  end;
end;

function TAdvCustomFormDesigner.CheckParent(AControl: TControl; DisableLocked: Boolean): Boolean;

var
  i: Integer;

  function IsControlLocked(AControl: TControl): Boolean;
  begin
    Result:=IsLocked(AControl) and DisableLocked;
  end;

begin
  Result:=False;
  i:=0;
  while i<ControlCount do
    if (Controls[i].Parent<>AControl.Parent) or
      IsControlLocked(Controls[i]) then
    begin
      Result:=IsControlLocked(Controls[i]);
      Controls[i].Invalidate;
      DeleteControl(Controls[i]);
    end
    else Inc(i);
  if ControlCount=1 then Control.Invalidate;
end;

procedure TAdvCustomFormDesigner.SetArrowCursor;
begin
  {$IFNDEF STDCURSORS}
  Screen.Cursor:=crArrow;
  {$ELSE}
  Screen.Cursor:=crDefault;
  {$ENDIF}
end;

procedure TAdvCustomFormDesigner.ClearForm;
var
  i: Integer;
  OldActive: Boolean;
begin
  OldActive:=Active;
  Active:=False;
  try
    i:=0;
    if Assigned(ParentForm) then
      with ParentForm do
        while i<ComponentCount do
          if Components[i]<>Self then Components[i].Free
          else Inc(i);
  finally
    Active:=OldActive;
  end;
end;

function TAdvCustomFormDesigner.ValidControl(AControl: TControl): Boolean;
begin
  try
    Result:=Assigned(AControl) and (AControl.ClassInfo<>nil) {and Assigned(AControl.Parent)};
    if AControl is TWinControl then
      Result:=Result and TWinControl(AControl).HandleAllocated;
  except
    Result:=False;
  end;
end;

procedure TAdvCustomFormDesigner.CreateContainers;
var
  i: Integer;
  Editable: Boolean;
begin
  if not (csDesigning in ComponentState) then
    if FShowNonVisual then
      with ParentForm do
        for i:=0 to Pred(ComponentCount) do
          if not (Components[i] is TControl) and
            not (Components[i] is TMenuItem) and
            not (Components[i] is TAdvCustomFormDesigner) and
            not Assigned(FindComponentContainer(Components[i])) then
          begin
            Editable:=True;
            if Assigned(FOnComponentEditable) then
              FOnComponentEditable(Self,Components[i],Editable);
            if Editable then
              TComponentContainer.CreateWithComponent(ParentForm, Components[i], Self, not (Components[i] is TField));
          end;
end;

procedure TAdvCustomFormDesigner.DestroyContainers;
var
  i: Integer;
begin
  i:=0;
  with ParentForm do
    while i<ComponentCount do
      if Components[i] is TComponentContainer then Components[i].Free
      else Inc(i);
end;

procedure TAdvCustomFormDesigner.UpdateContainers;
var
  i: Integer;
begin
  with ParentForm do
    for i:=0 to Pred(ComponentCount) do
      if Components[i] is TComponentContainer then
        TComponentContainer(Components[i]).UpdateContainer;
end;


function TAdvCustomFormDesigner.InParentForm(WND: HWND): Boolean;
var
  i: Integer;
begin
  with ParentForm do
  begin
    Result:=WND=Handle;
    if not Result then
      for i:=0 to Pred(ComponentCount) do
        if (Components[i] is TWinControl) and
          TWinControl(Components[i]).HandleAllocated and
          (TWinControl(Components[i]).Handle=WND) then
        begin
          Result:=True;
          Break;
        end;
  end;
end;

{$IFDEF TFDTRIAL}
procedure TAdvCustomFormDesigner.ShowTrialWarning;
begin
  MessageBox(
    0,
    'In the trial version of this component you can select only the controls that are parented by a form, not by another control.',
    'XXXXXXXXXXXXXX - Trial Version',
    MB_OK or MB_ICONEXCLAMATION);
end;
{$ENDIF}

procedure TAdvCustomFormDesigner.ListChange(Sender: TObject);
begin
  if not (csDesigning in ComponentState) and Active then
  try
    Update;
  except
  end;
end;

procedure TAdvCustomFormDesigner.WinProc(var Message: TMessage);

var
  X,Y: Integer;

  function CallDefault: Integer;
  begin
    with Message do
      CallDefault:=CallWindowProc(FDefaultProc,ParentForm.Handle,Msg,wParam,lParam);
  end;

  function OnInactiveForm: Boolean;
  var
    F: TControl;
  begin
    Result:=True;
    F:=ParentForm;
    while Assigned(F) do
    begin
      if F=Screen.ActiveForm then
      begin
        Result:=False;
        Exit;
      end;
      F:=F.Parent;
    end;
  end;

  function ParentedByForm: Boolean;
  var
    C: TWinControl;
  begin
    C:=ParentForm.Parent;
    Result:=False;
    while Assigned(C) do
    begin
      if C is TCustomForm then
      begin
        Result:=True;
        Break;
      end;
      C:=C.Parent;
    end;
  end;

begin
  with Message do
    case Msg of
      WM_ERASEBKGND:
      begin
        if Assigned(ParentForm) and ParentForm.HandleAllocated and Assigned(FBkgBitmap) and FDisplayGrid then
        begin
          CallDefault;
          with ParentForm do
          begin
            for X:=0 to Pred(ControlCount) do
              with Controls[X] do
                if not (Controls[X] is TWinControl) and ((csDesigning in ComponentState) or Visible) then
                  ExcludeClipRect(Canvas.Handle,Left,Top,Left+Width,Top+Height);
            if FActive and FDisplayGrid then
              with FBkgBitmap do
                for Y:=0 to ClientHeight div Height do
                  for X:=0 to ClientWidth div Width do
                    BitBlt(ParentForm.Canvas.Handle,X*Width,Y*Height,Width,Height,Canvas.Handle,0,0,SRCCOPY);
          end;
          Result:=0;
        end
        else Result:=CallDefault;
        if ControlCount>1 then
          for X:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[X]);
      end;
      WM_SIZE,WM_MOVE:
      begin
        Result:=CallDefault;
        FModified:=True;
      end;
      WM_ACTIVATE: Result:=MA_ACTIVATE;
      WM_MOUSEACTIVATE:
        if LoWord(lParam)=HTCAPTION then Result:=MA_NOACTIVATE
        else Result:=MA_ACTIVATE;
    else Result:=CallDefault
    end;
end;

procedure TAdvCustomFormDesigner.Notification(AComponent: TComponent; Operation: TOperation);
var
  CC: TComponentContainer;
begin
  inherited;
  if FActive and
    (ComponentState=[]) and
    (AComponent.Owner=ParentForm) and
    not (AComponent is TComponentContainer) then FModified:=True;
  if Active and not (csLoading in ComponentState) and (Operation=opInsert) and
    (AComponent<>Self) and (AComponent is TComponent) and (AComponent.Owner=ParentForm) and
    not (AComponent is TComponentContainer) then
    CreateContainers;
  if not (csDestroying in ComponentState) and (Operation=opRemove) then
  begin
    Application.ProcessMessages;
    StopTimer;
    if AComponent is TControl then
    begin
      if ControlIndex(TControl(AComponent))<>-1 then DeleteControl(TControl(AComponent));
    end
    else
    begin
      CC:=FindComponentContainer(AComponent);
      if Assigned(CC) then
      begin
        DeleteControl(CC);
        if Assigned(FGrabHandles) then FGrabHandles.Control:=Control;

        {Cannot destroy container here. Let the container stay}
        CC.Hide;
        CC.Component := nil;
      end;
    end;
    Exit;
    if Assigned(FGrabHandles) and not (csDestroying in FGrabHandles.ComponentState) then
      FGrabHandles.Control:=Control;
    if (ControlCount=1) and (AComponent=Control.Parent) then
    begin
      Control:=nil;
      LeaveMouseAction;
    end;
    if AComponent=FPopupMenu then FPopupMenu:=nil;
    if AComponent=FDesignControl then DesignControl:=nil;
    if AComponent=ParentForm then ParentForm:=nil;
  end;
end;

function TAdvCustomFormDesigner.FindNextControl(GoForward: Boolean): TControl;

var
  i,StartIndex: Integer;
  CurControl: TControl;
  Found: Boolean;

  function ParentsVisible(Control: TControl): Boolean;
  var
    P: TWinControl;
  begin
    if ValidControl(Control) then
    begin
      Result:=True;
      P:=Control.Parent;
      while ValidControl(P) and (P<>ParentForm) do
      begin
        if not P.Visible then
        begin
          Result:=False;
          Break;
        end;
        P:=P.Parent;
      end;
    end
    else Result:=False;
  end;

begin
  Result:=nil;
  if Assigned(Control) then
  begin
    CurControl:=Control;
    if Assigned(CurControl.Owner) then
      with CurControl.Owner do
      begin
        if ValidControl(CurControl) then
          if ComponentCount>0 then
          begin
            Found:=False;
            for StartIndex:=0 to Pred(ComponentCount) do
              if Components[StartIndex]=Control then
              begin
                Found:=True;
                Break;
              end;
            if not Found then StartIndex:=-1;
          end
          else StartIndex:=-1
        else StartIndex:=-1;
        if ComponentCount>0 then
        begin
          if StartIndex=-1 then
            if GoForward then StartIndex:=Pred(ComponentCount)
            else StartIndex:=0;
          i:=StartIndex;
          repeat
            if GoForward then
            begin
              Inc(i);
              if i=ComponentCount then i:=0;
            end
            else
            begin
              if i=0 then i:=ComponentCount;
              Dec(i);
            end;
            if Components[i] is TControl then
            begin
              CurControl:=TControl(Components[i]);
              if not (CurControl is TGrabHandle) and
                CurControl.Visible and
                ParentsVisible(CurControl) and
                not IsTransparent(CurControl) and
                not IsProtected(CurControl) and
                (CurControl<>Control) then Result:=CurControl;
            end;
          until (Result<>nil) or (i=StartIndex);
        end;
      end;
  end
  else Result:=ParentForm.Controls[0];
end;

function TAdvCustomFormDesigner.ControlAtPos(AParent: TWinControl; P: TPoint): TControl;
var
  i: Integer;
  SR: TRect;
begin
  Result:=nil;
  if AParent=nil then AParent:=ParentForm;
  if Assigned(AParent) then
    with AParent do
      for i:=0 to Pred(ControlCount) do
        with Controls[i] do
        begin
          SR:=BoundsRect;
          SR.TopLeft:=ClientToScreen(SR.TopLeft);
          SR.BottomRight:=ClientToScreen(SR.BottomRight);
          if PtInRect(SR,ClientToScreen(P)) then
          begin
            Result:=Controls[i];
            Break;
          end;
        end;
end;

function TAdvCustomFormDesigner.FindWinControl(Wnd: DWORD): TWinControl;

  procedure FindInComponent(Wnd: HWND; Component: TComponent; var Control: TWinControl);
  var
    i: Integer;
  begin
    if Assigned(Component) and not Assigned(Control) then
      if (Component is TWinControl) then
        with TWinControl(Component) do
          if HandleAllocated and
            ValidControl(Parent) and
            (Component <> ParentForm) and 
            (Handle=Wnd)
            {$IFNDEF NOCSSUBCOMPONENT}
            and not (csSubComponent in Component.ComponentStyle)
            {$ENDIF}
            then Control:=TWinControl(Component)
          else
            with Component do
              for i:=Pred(ComponentCount) downto 0 do
                FindInComponent(Wnd,Components[i],Control);
  end;

begin
  Result:=nil;
  FindInComponent(Wnd,ParentForm,Result);
end;

function TAdvCustomFormDesigner.FindComponentContainer(AComponent: TComponent): TComponentContainer;
var
  i: Integer;
begin
  Result:=nil;
  with ParentForm do
    for i:=0 to Pred(ComponentCount) do
      if (Components[i] is TComponentContainer) and
        (TComponentContainer(Components[i]).Component=AComponent) then
      begin
        Result:=TComponentContainer(Components[i]);
        Break;
      end;
end;

procedure TAdvCustomFormDesigner.SaveToFile(FileName: string);

var
  F: TIniFile;
  SL: TStringList;
  i: Integer;

  procedure SaveControl(AControl: TControl);
  var
    i: Integer;
  begin
    if (AControl<>ParentForm) and
      not (AControl is TGrabHandle) and
      (AControl.Name<>'') and
      ValidControl(AControl.Parent) then
    begin
      if Assigned(FOnSaveControl) then FOnSaveControl(Self,AControl,F);
      with F,AControl do
      begin
        WriteString(Name,'Class',ClassName);
        WriteString(Name,'Parent',Parent.Name);
        WriteInteger(Name,'Left',Left);
        WriteInteger(Name,'Top',Top);
        WriteInteger(Name,'Width',Width);
        WriteInteger(Name,'Height',Height);
      end;
      if AControl is TWinControl then
        with TWinControl(AControl) do
          for i:=0 to Pred(ControlCount) do SaveControl(Controls[i]);
    end;
  end;

begin
  F:=TIniFile.Create(FileName);
  try
    SL:=TStringList.Create;
    try
      F.ReadSections(SL);
      for i:=0 to Pred(SL.Count) do F.EraseSection(SL[i])
    finally
      SL.Free;
    end;
    if Assigned(FOnSaveControl) then FOnSaveControl(Self,ParentForm,F);
    if Assigned(ParentForm) then
      with ParentForm do
        for i:=0 to Pred(ControlCount) do SaveControl(Controls[i]);
  finally
    F.Free;
  end;
end;

procedure TAdvCustomFormDesigner.LoadFromFile(FileName: string);

var
  F: TIniFile;
  i: Integer;
  SL: TStringList;

  procedure LoadControl(AName: string);
  var
    PC: TPersistentClass;
    C: TComponent;
  begin
    with F do
    begin
      PC:=GetClass(ReadString(AName,'Class',''));
      if Assigned(PC) then
      begin
        C:=TComponentClass(PC).Create(ParentForm);
        if Assigned(C) and (C is TControl) then
        begin
          with TControl(C) do
          begin
            Name:=AName;
            Left:=ReadInteger(AName,'Left',Left);
            Top:=ReadInteger(AName,'Top',Top);
            Width:=ReadInteger(AName,'Width',Width);
            Height:=ReadInteger(AName,'Height',Height);
          end;
        end;
      end;
    end;
  end;

  procedure SetParent(AName: string);
  var
    C,P: TComponent;
  begin
    if Assigned(ParentForm) then
    begin
      C:=TControl(ParentForm.FindComponent(AName));
      if Assigned(C) and (C is TControl) then
      begin
        P:=TWinControl(ParentForm.FindComponent(F.ReadString(AName,'Parent','')));
        if Assigned(P) and (P is TWinControl) then TControl(C).Parent:=TWinControl(P)
        else TControl(C).Parent:=ParentForm;
        if Assigned(FOnLoadControl) then FOnLoadControl(Self,TControl(C),F);
      end;
    end;
  end;

begin
  if Assigned(ParentForm) then
  begin
    with ParentForm do
    begin
      i:=0;
      while i<ComponentCount do
        if Components[i] is TControl then Components[i].Free
        else Inc(i);
    end;
    F:=TIniFile.Create(FileName);
    try
      SL:=TStringList.Create;
      try
        if Assigned(FOnLoadControl) then FOnLoadControl(Self,ParentForm,F);
        F.ReadSections(SL);
        for i:=0 to Pred(SL.Count) do LoadControl(SL[i]);
        for i:=0 to Pred(SL.Count) do SetParent(SL[i]);
      finally
        SL.Free;
      end;
    finally
      F.Free;
    end;
  end;
end;

procedure TAdvCustomFormDesigner.SaveToDFM(FileName: string; DFMFormat: TDFMFormat);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(FS, DFMFormat);
  finally
    FS.Free;
  end;
end;

procedure TAdvCustomFormDesigner.SaveToStream(Stream: TStream; DFMFormat: TDFMFormat);
var
  Form: TCustomForm;
  {TxtStream,}BinStream: TMemoryStream;
  OldOwner: TComponent;
  OldComponent: TComponent;
begin
  if Assigned(ParentForm) then
  begin
    OldComponent := Component;
    inc(FUpdatingSelection);
    try
      Control := nil;
      ContainersToDesignInfo;
      DestroyContainers;
      try
        BinStream:=TMemoryStream.Create;
        try
          with TWriter.Create(BinStream,BufSize) do
          try
            Form:=ParentForm;
            if Form=Owner then
            begin
              OldOwner:=Owner;
              Form.RemoveComponent(Self);
            end
            else OldOwner:=nil;
            Form.ActiveControl:=nil;
            try
              WriteDescendent(Form,FAncestor);
            finally
              if Assigned(OldOwner) then OldOwner.InsertComponent(Self);
            end;
          finally
            Free;
          end;
          BinStream.Seek(0,soFromBeginning);
          if DFMFormat=dfmText then ObjectBinaryToText(BinStream,Stream)
          else
          begin
            {TxtStream:=TMemoryStream.Create;
            try
              ObjectBinaryToText(BinStream,TxtStream);
              TxtStream.Seek(0,soFromBeginning);
              ObjectTextToResource(TxtStream,Stream);
            finally
              TxtStream.Free;
            end;}
            Stream.CopyFrom(BinStream, 0);
          end;
          {$IFDEF TFDSAVEITSELF}
          BinStream.Clear;
          with TWriter.Create(BinStream,BufSize) do
          try
            WriteRootComponent(Self);
          finally
            Free;
          end;
          BinStream.Seek(0,soFromBeginning);
          if DFMFormat=dfmText then ObjectBinaryToText(BinStream,Stream)
          else Stream.CopyFrom(BinStream, 0);
          {$ENDIF}
        finally
          BinStream.Free;
        end;
      finally
        if Active then
        begin
          CreateContainers;
          DesignInfoToContainers;
        end;
      end;
    finally
      Component := OldComponent;
      Dec(FUpdatingSelection);
    end;
  end;
end;

procedure TAdvCustomFormDesigner.LoadFromDFM(FileName: string; DFMFormat: TDFMFormat);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(FS, DFMFormat);
  finally
    FS.Free;
  end;
end; 

procedure TAdvCustomFormDesigner.LoadFromStream(Stream: TStream; DFMFormat: TDFMFormat);
var
  {TxtStream,}BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      if FClearBeforeLoad or FMustClear then ClearForm;
      BinStream:=TMemoryStream.Create;
      try
        if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
        else
        begin
          {TxtStream:=TMemoryStream.Create;
          try
            ObjectResourceToText(Stream,TxtStream);
            TxtStream.Seek(0,soFromBeginning);
            ObjectTextToBinary(TxtStream,BinStream);
          finally
            TxtStream.Free;
          end;}
          BinStream.CopyFrom(Stream, 0);
        end;
        BinStream.Seek(0,soFromBeginning);
        ParentForm.Name:='';
        with TFDReader.Create(BinStream,Self) do
        try
          ReadRootComponent(ParentForm);
        finally
          Free;
        end;
        {$IFDEF TFDSAVEITSELF}
        if Stream.Position<Stream.Size then
        begin
          BinStream.Clear;
          if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
          else BinStream.CopyFrom(Stream,Stream.Size-Stream.Position);
          BinStream.Seek(0,soFromBeginning);
          with TFDReader.Create(BinStream,Self) do
          try
            ReadRootComponent(Self);
          finally
            Free;
          end;
        end;
        {$ENDIF}
      finally
        BinStream.Free;
      end;
    finally
      if Active then
      begin
        CreateContainers;
        DesignInfoToContainers;
      end;
    end;
    ParentForm.Invalidate;
  end;
end;

procedure TAdvCustomFormDesigner.SaveComponentToStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat);
var
  BinStream: TMemoryStream;
begin
  if Assigned(Component) then
  begin
    BinStream:=TMemoryStream.Create;
    try
      with TWriter.Create(BinStream,BufSize) do
      try
        Root:=ParentForm;
        WriteSignature;
        WriteComponent(Component);
      finally
        Free;
      end;
      BinStream.Seek(0,soFromBeginning);
      if DFMFormat=dfmText then ObjectBinaryToText(BinStream,Stream)
      else Stream.CopyFrom(BinStream,0);
    finally
      BinStream.Free;
    end;
  end;
end;

function TAdvCustomFormDesigner.LoadComponentFromStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat): TComponent;
var
  BinStream: TMemoryStream;
begin
  BinStream:=TMemoryStream.Create;
  try
    if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
    else BinStream.CopyFrom(Stream,0);
    BinStream.Seek(0,soFromBeginning);
    with TFDReader.Create(BinStream,Self) do
    try
      BeginReferences;
      try
        Root:=ParentForm;
        Owner:=ParentForm;
        if Assigned(DesignControl) and (Component<>DesignControl) then
          Parent:=DesignControl
        else Parent:=ParentForm;
        ReadSignature;
        Result:=ReadComponent(Component);
        FixupReferences;
      finally
        EndReferences;
      end;
    finally
      Free;
    end;
  finally
    BinStream.Free;
  end;
end;

function TAdvCustomFormDesigner.CanCopy: Boolean;
begin
  Result:=ControlCount>0;
end;

function TAdvCustomFormDesigner.CanPaste: Boolean;
begin
  Result:=Pos('object ',Clipboard.AsText)=1;
end;

procedure TAdvCustomFormDesigner.CopyToClipboard;
var
  i: Integer;
  BinStream: TMemoryStream;
  StringStream: TStringStream;
  ComponentList: TList;
begin
  CheckParent(Control,False);
  if (Assigned(ParentForm)) and (ControlCount>0) then
  begin
    ComponentList:=TList.Create;
    for i:=0 to Pred(ControlCount) do
      if Controls[i] is TComponentContainer then
        ComponentList.Add(TComponentContainer(Controls[i]).Component);
    ContainersToDesignInfo;
    DestroyContainers;
    try
      i:=0;
      while i<ControlCount do
        if ValidControl(Controls[i].Parent) and (ControlIndex(Controls[i].Parent)<>-1) then
          DeleteControl(Controls[i])
        else Inc(i);
      BinStream:=TMemoryStream.Create;
      try
        with TWriter.Create(BinStream,BufSize) do
        try
          Root:=ParentForm;
          for i:=0 to Pred(ControlCount) do
          begin
            WriteSignature;
            WriteComponent(Controls[i]);
            if Assigned(FOnCopyComponent) then
              FOnCopyComponent(Self,Controls[i]);
          end;
          with ComponentList do
            for i:=0 to Pred(Count) do
            begin
              WriteSignature;
              WriteComponent(TComponent(Items[i]));
              if Assigned(FOnCopyComponent) then
                FOnCopyComponent(Self,TComponent(Items[i]));
            end;
        finally
          Free;
        end;
        BinStream.Seek(0,soFromBeginning);
        StringStream:=TStringStream.Create('');
        try
          while BinStream.Position<BinStream.Size do
            ObjectBinaryToText(BinStream,StringStream);
          Clipboard.AsText:=StringStream.DataString;
        finally
          StringStream.Free;
        end;
      finally
        BinStream.Free;
      end;
    finally
      if Active then
      begin
        CreateContainers;
        DesignInfoToContainers;
      end;
      with ComponentList do
      begin
        for i:=0 to Pred(Count) do 
          AddControl(FindComponentContainer(TComponent(Items[i])));
        Free;
      end;
    end;
  end;
end;

procedure TAdvCustomFormDesigner.CutToClipboard;
begin
  CopyToClipboard;
  RemoveSelectedControls;
  DoChange;
  //DoSelectionChange;
end;

procedure TAdvCustomFormDesigner.PasteFromClipboard;
var
  BinStream: TMemoryStream;
  StringStream: TStringStream;
  ParentControl: TWinControl;
  NewComponent: TComponent;
  Container: TComponentContainer;
begin
  if (Assigned(ParentForm)) and (Clipboard.AsText<>'') then
  begin
    StringStream:=TStringStream.Create(Clipboard.AsText);
    if StringStream.Size>0 then
      try
        if ValidControl(Control) then
          if Control is TWinControl then ParentControl:=TWinControl(Control)
          else ParentControl:=Control.Parent
        else ParentControl:=ParentForm;
        while ValidControl(ParentControl) and not (csAcceptsControls in ParentControl.ControlStyle) do
          ParentControl:=ParentControl.Parent;
        if not ValidControl(ParentControl) then ParentControl:=ParentForm;
        Control:=nil;
        BinStream:=TMemoryStream.Create;
        try
          while StringStream.Position<StringStream.Size do
          begin
            BinStream.Seek(0,soFromBeginning);
            ObjectTextToBinary(StringStream,BinStream);
            BinStream.Seek(0,soFromBeginning);
            with TFDReader.Create(BinStream,Self) do
            try
              BeginReferences;
              try
                Root:=ParentForm;
                Owner:=ParentForm;
                Parent:=ParentControl;
                ReadSignature;
                NewComponent:=ReadComponent(nil);
                if Assigned(FOnPasteComponent) then FOnPasteComponent(Self,NewComponent);
                if FActive then
                  if NewComponent is TControl then
                    AddControl(TControl(NewComponent))
                  else
                  begin
                    Container:=FindComponentContainer(NewComponent);
                    if Assigned(Container) then
                    begin
                      {with NewComponent do
                        SetWindowPos(Container.Handle,0,LoWord(DesignInfo),HiWord(DesignInfo),0,0,SWP_NOSIZE or SWP_NOZORDER);}
                      Container.Left := LongRec(NewComponent.DesignInfo).Lo;
                      Container.Top := LongRec(NewComponent.DesignInfo).Hi;
                      Container.UpdateContainer;
                      AddControl(Container);
                    end;
                  end;
                FixupReferences;
              finally
                EndReferences;
              end;
            finally
              Free;
            end;
          end;
        finally
          BinStream.Free;
        end;
        DoChange;
      finally
        StringStream.Free;
      end;
  end;
end;

function TAdvCustomFormDesigner.GetComponentProperties(AComponent: TComponent): string;
var
  B: TMemoryStream;
  S: TStringStream;
begin
  if Assigned(AComponent) then
  begin
    B:=TMemoryStream.Create;
    S:=TStringStream.Create('');
    try
      B.WriteComponent(AComponent);
      B.Seek(0,soFromBeginning);
      ObjectBinaryToText(B,S);
      Result:=S.DataString;
    finally
      S.Free;
      B.Free;
    end;
  end
  else Result:='';
end;

procedure TAdvCustomFormDesigner.SetComponentProperties(AComponent: TComponent; Props: string);
var
  B: TMemoryStream;
  S: TStringStream;
begin
  if Assigned(AComponent) then
  begin
    B:=TMemoryStream.Create;
    S:=TStringStream.Create(Props);
    try
      ObjectTextToBinary(S,B);
      B.Seek(0,soFromBeginning);
      B.ReadComponent(AComponent);
    finally
      S.Free;
      B.Free;
    end;
  end;
end;

procedure TAdvCustomFormDesigner.AlignToGrid(TheControl: TControl);
begin
  if FActive and ValidControl(TheControl) and not IsLocked(TheControl) and not IsTransparent(TheControl) and not IsProtected(TheControl) then
  begin
    with TheControl do
    begin
      {$IFDEF GFDADVANCEDGRID}
      if Left mod FGridStepX < FGridStepX div 2 then Left:=Left div FGridStepX * FGridStepX
      else Left:=Succ(Left div FGridStepX) * FGridStepX;
      if Top mod FGridStepY < FGridStepY div 2 then Top:=Top div FGridStepY * FGridStepY
      else Top:=Succ(Top div FGridStepY) * FGridStepY;
      {$ELSE}
      if Left mod FGridStep < FGridStep div 2 then Left:=Left div FGridStep * FGridStep
      else Left:=Succ(Left div FGridStep) * FGridStep;
      if Top mod FGridStep < FGridStep div 2 then Top:=Top div FGridStep * FGridStep
      else Top:=Succ(Top div FGridStep) * FGridStep;
      {$ENDIF}
      FGrabHandles.Update(False);
      if (ControlCount>1) and (ControlIndex(TheControl)<>-1) then DrawMultiSelect(TheControl);
    end;
    DoMoveSizeControl;
    DoChange;
  end;
end;

function TAdvCustomFormDesigner.EditControlLists(DefaultList: TListType): Boolean;
begin
  Result:=EditLists(Self,DefaultList);
end;

function TAdvCustomFormDesigner.AlignDialog: Boolean;
begin
  Result:=False;
  with TfrmAlign.Create(Application) do
  try
    Result:=ShowModal=mrOk;
    if Result then
      AlignControls(TAlignMode(rgrHorizontal.ItemIndex),TAlignMode(rgrVertical.ItemIndex));
  except
    Free;
  end;
end;

function TAdvCustomFormDesigner.SizeDialog: Boolean;
var
  W,H: TSizeMode;

  function GetInt(S: string): Integer;
  begin
    if S='' then Result:=0
    else Result:=StrToInt(S);
  end;

begin
  Result:=False;
  with TfrmSize.Create(Application) do
  try
    Result:=ShowModal=mrOk;
    if Result then
    begin
      if rbtWNoChange.Checked then W:=smNoChange
      else
        if rbtWToSmallest.Checked then W:=smToSmallest
        else
          if rbtWToLargest.Checked then W:=smToLargest
          else W:=smValue;
      if rbtHNoChange.Checked then H:=smNoChange
      else
        if rbtHToSmallest.Checked then H:=smToSmallest
        else
          if rbtHToLargest.Checked then H:=smToLargest
          else H:=smValue;
      SizeControls(W,GetInt(edtWidth.Text),H,GetInt(edtHeight.Text));
    end;
  except
    Free;
  end;
end;

function TAdvCustomFormDesigner.TabOrderDialog: Boolean;
var
  PC: TWinControl;
  i: Integer;
  List: TList;
begin
  with TfrmTabOrder.Create(Application) do
  try
    CheckParent(Control,False);
    if ValidControl(Control) then
    begin
      if Control is TWinControl then PC:=TWinControl(Control)
      else PC:=Control.Parent;
      while ValidControl(PC) and (PC.ControlCount=0) do PC:=PC.Parent;
      if not ValidControl(PC) then PC:=ParentForm;
    end
    else PC:=ParentForm;
    List:=TList.Create;
    try
      PC.GetTabOrderList(List);
      for i:=0 to Pred(List.Count) do
        if not Assigned(FGrabHandles)
          or (Assigned(FGrabHandles)
            and not FGrabHandles.IsGrabHandle(TControl(List[i])))
            and not (TControl(List[i]) is TComponentContainer) then
        with TControl(List[i]) do
          if Parent=PC then
            lsbControls.Items.AddObject(Name+': '+ClassName,List[i]);
    finally
      List.Free;
    end;
    with lsbControls,Items do
    begin
      if Count>0 then ItemIndex:=0
      else btnOK.Enabled:=False;
      Result:=ShowModal=mrOk;
      if Result then
      begin
        for i:=0 to Pred(Count) do
          (Objects[i] as TWinControl).TabOrder:=i;
        DoChange;
      end;
    end;
  finally
    Free;
  end;
end;

function TAdvCustomFormDesigner.OptionsDialog: Boolean;
begin
  with TfrmDesignerOptions.Create(nil) do
  try
    Designer := Self;
    Result := ShowModal = mrOk;
    if Result then
     // designeroptionsdialog
  finally
    Free;
  end;
end;

procedure TAdvCustomFormDesigner.ShowAlignmentPalette;
begin
  with FAPForm do
  begin
    if apStayOnTop in FAlignmentPalette then FormStyle:=fsStayOnTop
    else FormStyle:=fsNormal;
    if Assigned(FOnShowAlignmentPalette) then FOnShowAlignmentPalette(Self,FAPForm);
    Show;
  end;
end;

procedure TAdvCustomFormDesigner.HideAlignmentPalette;
begin
  FAPForm.Hide;
end;

function LeftSort(Item1,Item2: Pointer): Integer;
begin
  if TControl(Item1).Left<TControl(Item2).Left then Result:=-1
  else
    if TControl(Item1).Left>TControl(Item2).Left then Result:=1
    else Result:=0;
end;

function RightSort(Item1,Item2: Pointer): Integer;

  function Right(Item: Pointer): Integer;
  begin
    with TControl(Item) do Result:=Left+Width;
  end;

begin
  if Right(Item1)<Right(Item2) then Result:=-1
  else
    if Right(Item1)>Right(Item2) then Result:=1
    else Result:=0;
end;

function TopSort(Item1,Item2: Pointer): Integer;
begin
  if TControl(Item1).Top<TControl(Item2).Top then Result:=-1
  else
    if TControl(Item1).Top>TControl(Item2).Top then Result:=1
    else Result:=0;
end;

function BottomSort(Item1,Item2: Pointer): Integer;

  function Bottom(Item: Pointer): Integer;
  begin
    with TControl(Item) do Result:=Top+Height;
  end;

begin
  if Bottom(Item1)<Bottom(Item2) then Result:=-1
  else
    if Bottom(Item1)>Bottom(Item2) then Result:=1
    else Result:=0;
end;

procedure TAdvCustomFormDesigner.AlignControls(Hor,Ver: TAlignMode);
var
  i,Val,Min,Max: Integer;
begin
  if FActive then
  begin
    CheckParent(Control,True);
    if ControlCount>0 then
    begin
      with TList.Create do
      try
        for i:=0 to Pred(ControlCount) do
          if not IsLocked(Controls[i]) then Add(Controls[i]);
        case Hor of
          amLeftTop:
            if ControlCount>1 then
            begin
              Sort(LeftSort);
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  Controls[i].Left:=TControl(Items[0]).Left;
            end;
          amCenters:
            if ControlCount>1 then
            begin
              Sort(LeftSort);
              Val:=TControl(Items[0]).Left;
              Sort(RightSort);
              with TControl(Items[Pred(Count)]) do Val:=(Val+Left+Width) div 2;
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Left:=Val-Width div 2;
            end;
          amRightBottom:
            if ControlCount>1 then
            begin
              Sort(RightSort);
              with TControl(Items[Pred(Count)]) do Val:=Left+Width;
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Left:=Val-Width;
            end;
          amSpace:
            if Count>1 then
            begin
              Sort(LeftSort);
              Val:=(TControl(Items[Pred(Count)]).Left-TControl(Items[0]).Left) div Pred(Count);
              for i:=0 to Pred(Count) do
                TControl(Items[i]).Left:=TControl(Items[0]).Left+Val*i;
            end;
          amWindowCenter:
          begin
            Val:=Control.Parent.ClientWidth;
            Min:=MaxInt;
            Max:=-MaxInt;
            for i:=0 to Pred(ControlCount) do
              with Controls[i] do
              begin
                if Left<Min then Min:=Left;
                if Left+Width>Max then Max:=Left+Width;
              end;
            for i:=0 to Pred(ControlCount) do
              if not IsLocked(Controls[i]) then
                with Controls[i] do Left:=Left+(Val-Max+Min) div 2-Min;
          end;
        end;
        case Ver of
          amLeftTop:
            if ControlCount>1 then
            begin
              Sort(TopSort);
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  Controls[i].Top:=TControl(Items[0]).Top;
            end;
          amCenters:
            if ControlCount>1 then
            begin
              Sort(TopSort);
              Val:=TControl(Items[0]).Top;
              Sort(BottomSort);
              with TControl(Items[Pred(Count)]) do Val:=(Val+Top+Height) div 2;
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Top:=Val-Height div 2;
            end;
          amRightBottom:
            if ControlCount>1 then
            begin
              Sort(BottomSort);
              with TControl(Items[Pred(Count)]) do Val:=Top+Height;
              for i:=0 to Pred(ControlCount) do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Top:=Val-Height;
            end;
          amSpace:
            if Count>1 then
            begin
              Sort(TopSort);
              Val:=(TControl(Items[Pred(Count)]).Top-TControl(Items[0]).Top) div Pred(Count);
              for i:=0 to Pred(Count) do
                TControl(Items[i]).Top:=TControl(Items[0]).Top+Val*i;
            end;
          amWindowCenter:
          begin
            Val:=Control.Parent.ClientHeight;
            Min:=MaxInt;
            Max:=-MaxInt;
            for i:=0 to Pred(ControlCount) do
              with Controls[i] do
              begin
                if Top<Min then Min:=Top;
                if Top+Height>Max then Max:=Top+Height;
              end;
            for i:=0 to Pred(ControlCount) do
              if not IsLocked(Controls[i]) then
                with Controls[i] do Top:=Top+(Val-Max+Min) div 2-Min;
          end;
        end;
      finally
        Free;
      end;
      if ControlCount>1 then
        for i:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[i])
      else
      begin
        Control.Invalidate;
        FGrabHandles.Update(False);
      end;
      Application.ProcessMessages;
      DoMoveSizeControl;
      DoChange;
    end;
  end;
end;

procedure TAdvCustomFormDesigner.SizeControls(WMode: TSizeMode; WValue: Integer; HMode: TSizeMode; HValue: Integer);
var
  i,Val: Integer;
begin
  if FActive then
  begin
    CheckParent(Control,True);
    if ControlCount>0 then
    begin
      case WMode of
        smToSmallest:
        begin
          Val:=MaxInt;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Width<Val then Val:=Width;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width:=Val;
        end;
        smToLargest:
        begin
          Val:=-MaxInt;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Width>Val then Val:=Width;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width:=Val;
        end;
        smValue:
        begin
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width:=WValue;
        end;
      end;
      case HMode of
        smToSmallest:
        begin
          Val:=MaxInt;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Height<Val then Val:=Height;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height:=Val;
        end;
        smToLargest:
        begin
          Val:=-MaxInt;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Height>Val then Val:=Height;
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height:=Val;
        end;
        smValue:
        begin
          for i:=0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height:=HValue;
        end;
      end;
      if ControlCount>1 then
        for i:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[i])
      else
      begin
        Control.Invalidate;
        FGrabHandles.Update(False);
      end;
      Application.ProcessMessages;
      DoMoveSizeControl;
      DoChange;
    end;
  end;
end;

procedure TAdvCustomFormDesigner.Lock;
begin
  Inc(FLockCounter);
end;

procedure TAdvCustomFormDesigner.Unlock;
begin
  if FLockCounter>0 then Dec(FLockCounter);
  if (ParentForm <> nil) and (GetCapture = ParentForm.Handle) then
    ReleaseCapture;
end;

procedure TAdvCustomFormDesigner.SynchroLock;
begin
  Inc(FSynchroLockCounter);
end;

procedure TAdvCustomFormDesigner.SynchroUnlock;
begin
  if FSynchroLockCounter>0 then Dec(FSynchroLockCounter);
end;

procedure TAdvCustomFormDesigner.LeaveMouseAction;
begin
  if FActive and (FMouseAction<>maNone) then
  begin
    case FMouseAction of
      maDragging: DrawDragRects;
      maSelecting: DrawSelectRect;
    end;
    ReleaseCapture;
    ClipCursor(nil);
    HideHint;
    FMouseAction:=maNone;
    if Assigned(FGrabHandles) then FGrabHandles.Visible:=ValidControl(Control);
    if ValidControl(Control) then FDragRect:=Control.BoundsRect;
  end;
end;

procedure TAdvCustomFormDesigner.AddControl(AControl: TControl);
var
  Index: Integer;
  OldControl: TControl;
begin
  OldControl:=nil;
  if Assigned(FGrabHandles) and FGrabHandles.IsGrabHandle(AControl) then Exit;
  if ValidControl(AControl) then
  begin
    {$IFDEF TFDTRIAL}
    if ValidControl(AControl) and (AControl.Parent<>ParentForm) then
    begin
      ShowTrialWarning;
      Exit;
    end;
    {$ENDIF}
    with FControls do
    begin
      Index:=IndexOf(AControl);
      if Index=-1 then
      begin
        OldControl:=Control;
        Add(AControl);
        AControl.FreeNotification(Self);
        Application.ProcessMessages;
        DoAddControl(AControl);
        DoSelectControl(AControl);
        DoSelectionChange;
      end;
      if ControlCount>1 then DrawMultiSelect(AControl)
      else AControl.Invalidate;
      if Assigned(FGrabHandles) then
      begin
        FGrabHandles.Enabled := true;
        FGrabHandles.Control := AControl;
      end;
      if Assigned(OldControl) then DrawMultiSelect(OldControl);
    end;
  end;
end;

procedure TAdvCustomFormDesigner.DeleteControl(AControl: TControl);
var
  Index: Integer;
begin
  with FControls do
  begin
    Index:=IndexOf(AControl);
    if Index<>-1 then
    begin
      Delete(Index);
      {$IFNDEF NOREMOVENOTIFICATION}
      AControl.RemoveFreeNotification(Self);
      {$ENDIF}
      try
        if ValidControl(AControl.Parent) then
        begin
          if AControl is TWinControl then
            RedrawWindow(TWinControl(AControl).Handle,nil,0,RDW_INVALIDATE or RDW_ALLCHILDREN);
          AControl.Invalidate;
        end;
      except
      end;
      if Assigned(FGrabHandles) then
        if FGrabHandles.Control=AControl then FGrabHandles.Control:=Control;
      Application.ProcessMessages;
      DoDeleteControl(AControl);
      DoSelectionChange;
    end;
  end;
end;

procedure TAdvCustomFormDesigner.AddComponent(AComponent: TComponent);
begin
  AddControl(FindComponentContainer(AComponent));
end;

procedure TAdvCustomFormDesigner.DeleteComponent(AComponent: TComponent);
begin
  DeleteControl(FindComponentContainer(AComponent));
end;

procedure TAdvCustomFormDesigner.SelectAll;
var
  i: Integer;
begin
  SynchroLock;
  try
    if Assigned(ParentForm) then
      with ParentForm do
        for i:=0 to Pred(ComponentCount) do
          if (Components[i] is TControl) and
            TControl(Components[i]).Visible and
            ValidControl(TControl(Components[i]).Parent) and
            TControl(Components[i]).Parent.Showing and
            not FGrabHandles.IsGrabHandle(TControl(Components[i])) and
            not IsProtected(TControl(Components[i])) and
            not IsTransparent(TControl(Components[i])) then AddControl(TControl(Components[i]));
  finally
    SynchroUnlock;
  end;
  DoSelectionChange;
end;

procedure TAdvCustomFormDesigner.UnselectAll;
begin
  Control:=nil;
end;

procedure TAdvCustomFormDesigner.ClearControls;
begin
  with FControls do
    while Count>0 do DeleteControl(Controls[0]);
end;

function TAdvCustomFormDesigner.ControlIndex(AControl: TControl): Integer;
begin
  if Assigned(FControls) then Result:=FControls.IndexOf(AControl)
  else Result:=-1;
end;

procedure TAdvCustomFormDesigner.DrawGrab(Canvas: TCanvas; R: TRect; GrabType: TGrabType);
begin
  with Canvas do
  begin
    case GrabType of
      gtNormal:
      begin
        Pen.Color:=FNormalGrabBorder;
        Brush.Color:=FNormalGrabFill;
      end;
      gtMulti:
      begin
        Pen.Color:=FMultiGrabBorder;
        Brush.Color:=FMultiGrabFill;
      end;
      gtLocked:
      begin
        Pen.Color:=FLockedGrabBorder;
        Brush.Color:=FLockedGrabFill;
      end;
    end;
    with R do Rectangle(Left,Top,Right,Bottom);
  end;
end;

procedure TAdvCustomFormDesigner.UpdateGrabs;
begin
  if Assigned(FNormalGrab) then
    with FNormalGrab do
    begin
      Width:=FGrabSize;
      Height:=FGrabSize;
      DrawGrab(Canvas,Rect(0,0,FGrabSize,FGrabSize),gtNormal);
    end;
  if Assigned(FMultiGrab) then
    with FMultiGrab do
    begin
      Width:=FGrabSize;
      Height:=FGrabSize;
      DrawGrab(Canvas,Rect(0,0,FGrabSize,FGrabSize),gtMulti);
    end;
  if Assigned(FLockedGrab) then
    with FLockedGrab do
    begin
      Width:=FGrabSize;
      Height:=FGrabSize;
      DrawGrab(Canvas,Rect(0,0,FGrabSize,FGrabSize),gtLocked);
    end;
  if Assigned(FGrabHandles) then FGrabHandles.Update(True);
end;

function TAdvCustomFormDesigner.CreateComponentClass(AComponentClass: TComponentClass): TComponent;
begin
  Result:=AComponentClass.Create(ParentForm);
end;

function TAdvCustomFormDesigner.CreateComponentClassName(AClassName: TComponentName): TComponent;
var
  CC: TComponentClass;
begin
  CC:=TComponentClass(GetClass(AClassName));
  if Assigned(CC) then Result:=CreateComponentClass(CC)
  else Result:=nil;
end;

procedure TAdvCustomFormDesigner.PlaceComponentClass(AComponentClass: TComponentClass);
{var
  CC: TComponentContainer;}
begin
  CancelPlacing;
  if Assigned(AComponentClass) then
  begin
    Lock;
    FWaiting:=True;
    (*FPlacedComponent:=CreateComponentClass(AComponentClass);
    if not (FPlacedComponent is TControl) then
    begin
      CC := FindComponentContainer(FPlacedComponent);
      if Assigned(CC) then CC.Visible := False;
    end;*)
    FPlacedComponentClass:= AComponentClass;
  end;
end;

procedure TAdvCustomFormDesigner.PlaceComponentClassName(AClassName: TComponentName);
var
  CC: TComponentClass;
begin
  CC:=TComponentClass(GetClass(AClassName));
  if Assigned(CC) then PlaceComponentClass(CC);
end;

procedure TAdvCustomFormDesigner.CancelPlacing;
begin
  (*FPlacedComponent.Free;
  FPlacedComponent := nil;*)
  FPlacedComponentClass := nil;
  FWaiting := False;
  Unlock;
end;

function TAdvCustomFormDesigner.GetComponentHint(AComponent: TComponent): string;
begin
  if Assigned(AComponent) and not FGrabHandles.IsGrabHandle(TControl(AComponent)) then
  begin
    if AComponent is TComponentContainer then AComponent:=TComponentContainer(AComponent).Component;
    if Assigned(AComponent) then
    begin
      with AComponent do Result:=Format('%s: %s',[Name,ClassName]);
      if Assigned(FOnComponentHint) then FOnComponentHint(Self,AComponent,Result);
    end
    else Result:='';
  end
  else Result:='';
end;

function TAdvCustomFormDesigner.GetComponentCaption(AComponent: TComponent): string;
begin
  if Assigned(AComponent) then
    if AComponent.Name<>'' then Result:=AComponent.Name
    else Result:=AComponent.ClassName
  else Result:='[none]';
  if Assigned(FOnComponentCaption) then FOnComponentCaption(Self,AComponent,Result);
end;

procedure TAdvCustomFormDesigner.ApplicationIdle(Sender: TObject; var Done: Boolean);
var
  i: Integer;
  OldDesigning: Boolean;
begin
  if Assigned(ParentForm) and not (csDestroying in ParentForm.ComponentState) and (MouseAction=maNone) then
  begin
    if ParentForm.HandleAllocated then
      with ParentForm do
        for i:=0 to Pred(ComponentCount) do
        begin
          if (Components[i] is TControl) and not IsProtected(TControl(Components[i])) then
          begin
            OldDesigning:=csDesigning in Components[i].ComponentState;
            if not (Components[i] is TCustomForm) and
              not (GetEditBehaviour(TControl(Components[i])) in [ebDefaultRuntime,ebTransparentRuntime,ebLockedRuntime]) then
              TDesignAccessComponent(Components[i]).SetDesigningPublic(FActive);
            if (OldDesigning xor (csDesigning in Components[i].ComponentState)) then
            begin
              TControl(Components[i]).Invalidate;
              ParentForm.Invalidate;
            end;
          end;
        end;
    with FControls do
      if Count>1 then
        for i:=0 to Pred(Count) do DrawMultiSelect(Controls[i]);
    //if Assigned(FGrabHandles) then FGrabHandles.Update(False);
  end;
  if Assigned(ParentForm) then
    with ParentForm do
      if not IsProtected(ActiveControl) then ActiveControl:=nil;
  Done:=True;
  if Assigned(SavedApplicationIdle) then SavedApplicationIdle(Sender,Done);
end;

procedure TAdvCustomFormDesigner.ApplicationMessage(var Msg: TMsg; var Handled: Boolean);
var
  i,ILockCounter: Integer;
  iMsg: TMsg;
begin
  if Designers <> nil then
    for i:=0 to Pred(Designers.Count) do
    begin
      iMsg:=Msg;
      with TAdvCustomFormDesigner(Designers[i]) do
      begin
        ILockCounter:=FLockCounter;
        try
          MessageProc(iMsg);
        finally
          if FLockCounter>ILockCounter then FLockCounter:=ILockCounter;
          if Locked and InParentForm(Msg.hwnd) then
            case Msg.Message of
              WM_LBUTTONUP,WM_NCLBUTTONUP,WM_RBUTTONUP,WM_NCRBUTTONUP:
              begin
                Unlock;
                MessageProc(iMsg);
              end;
            end;
        end;
      end;
      Msg:=iMsg;
    end;
  if Assigned(SavedApplicationMessage) then SavedApplicationMessage(Msg,Handled);
end;

procedure TAdvCustomFormDesigner.PerformComponentPlacing(AParentControl: TWinControl;
  APlacingRect: TRect);

  function AutoName(Component: TComponent): Boolean;
  var
    i: Integer;
    CN: string;
  begin
    Result:=False;
    if Assigned(Component) then
      with ParentForm,Component do
      begin
        if (Name='') or Assigned(ParentForm.FindComponent(Name)) then
        begin
          CN:=Copy(ClassName,2,Pred(Length(ClassName)));
          for i:=1 to 32768 do
            if not Assigned(ParentForm.FindComponent(CN+IntToStr(i))) then
            begin
              Name:=CN+IntToStr(i);
              Result:=True;
              Break;
            end;
        end;
      end;
  end;

var
  APlacedComponent: TComponent;
  ADefaultPlacing: boolean;
  CC: TComponentContainer;

  procedure CalculatePlacing(PlaceControl: TControl);
  begin
    {if the placingrect is not defined, then calculates it in the middle of parent}
    if (APlacingRect.Left = -1) and (APlacingRect.Right = -1) then
    begin
      APlacingRect.Left := (AParentControl.Width div 2) - (PlaceControl.Width div 2);
      APlacingRect.Top := (AParentControl.Height div 2) - (PlaceControl.Height div 2);
      ADefaultPlacing := true;
    end else
    begin
      {Check if the placingrect is too small, then set default placing}
      With APlacingRect do
        ADefaultPlacing := (Abs(Right - Left) < 10) and (Abs(Bottom - Top) < 10);
    end;
  end;

begin
  APlacedComponent := CreateComponentClass(FPlacedComponentClass);
  if Assigned(APlacedComponent) then
  begin
    if not AutoName(APlacedComponent) then APlacedComponent.Free
    else
    begin
      if Assigned(FOnEndPlacing) then FOnEndPlacing(Self, APlacingRect);
      if APlacedComponent is TControl then
      begin
        CalculatePlacing(TControl(APlacedComponent));
        with TControl(APlacedComponent) do
        begin
          if ADefaultPlacing then
          begin
            Left:=APlacingRect.Left;
            Top:=APlacingRect.Top;
          end
          else
            with APlacingRect do
              SetBounds(Left, Top, Right - Left, Bottom - Top);
          if FSnapToGrid then AlignToGrid(TControl(APlacedComponent));
          Parent := AParentControl;
        end;
      end
      else
      begin
        CreateContainers;
        CC := FindComponentContainer(APlacedComponent);
        if Assigned(CC) then
        begin
          AParentControl := ParentForm;
          CalculatePlacing(CC);
          with CC do
          begin
            Left := APlacingRect.Left;
            Top := APlacingRect.Top;
            Visible := True;
            ShowWindow(Handle,SW_SHOW);
          end;
          if FSnapToGrid then AlignToGrid(CC);
        end;
      end;
      FGrabHandles.FEnabled := True;
      DoBeforePlaceComponent(APlacedComponent);
      Component := APlacedComponent;
      RedrawWindow(ParentForm.Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
      DoPlaceComponent(Component);
      DoChange;
    end;
  end;
end;

procedure TAdvCustomFormDesigner.AutoPlaceComponent;
var
  APlacingParent: TControl;
begin
  if FPlacedComponentClass <> nil then
  begin
    APlacingParent := Control;
    while Assigned(APlacingParent) and not (csAcceptsControls in APlacingParent.ControlStyle) do
      APlacingParent := APlacingParent.Parent;
    if (APlacingParent = nil) or not (APlacingParent is TWinControl) then
      APlacingParent := ParentForm;

    PerformComponentPlacing(TWinControl(APlacingParent), Rect(-1, -1, -1, -1));

    {Set focus on the form}
    if (ParentForm <> nil) and ParentForm.CanFocus then
    begin
      if (ParentForm.Parent <> nil) and ParentForm.Parent.CanFocus then
        ParentForm.Parent.SetFocus
      else
        ParentForm.SetFocus;
    end;

    {Restore normal state}
    FPlacedComponentClass := nil;
    FWaiting := false;
    Unlock;
  end;
end;

procedure TAdvCustomFormDesigner.TimerEvent(Sender: TObject);
begin
  if FShowComponentHint and (Integer(FHintTimer.Interval)=Application.HintPause) then
  begin
    ShowHint(GetComponentHint(FHintControl),hmCustom);
    FHintTimer.Interval:=Application.HintHidePause;
  end
  else
  begin
    FHintTimer.Enabled:=False;
    HideHint;
  end;
end;

procedure TAdvCustomFormDesigner.StartTimer(AInterval: Integer);
begin
  with FHintTimer do
  begin
    Interval:=AInterval;
    Enabled:=True;
  end;
end;

procedure TAdvCustomFormDesigner.StopTimer;
begin
  if Assigned(FHintTimer) then FHintTimer.Enabled:=False;
end;

procedure TAdvCustomFormDesigner.MessageProc(var Msg: TMSG);

type
  TKeyType = (ktSelect,ktMove,ktFastMove,ktSize);

var
  NewControl: TControl;
  NewDrag,P,Min,Max: TPoint;
  R: TRect;
  KeyType: TKeyType;
  Key: Word;
  i: Integer;
  Handled: Boolean;
  WinControl: TWinControl;

  procedure ProcessKey(Key: Word);
  var
    R: TRect;
    i: Integer;

    procedure GrowRect(var R: TRect; X,Y: Integer);
    begin
      Inc(R.Right,X);
      Inc(R.Bottom,Y);
    end;

    procedure CheckRect(AControl: TControl; var R: TRect);
    var
      Limit: TRect;
    begin
      if ValidControl(AControl) and ValidControl(AControl.Parent) then
        with AControl.Parent,R do
          if KeyType=ktSize then
          begin
            Min:=Point(0,0);
            Max:=Point(MaxInt,MaxInt);
            if Assigned(FOnSizeLimit) then FOnSizeLimit(Self,Control,Min,Max);
            if Right-Left<Min.X then Right:=Left+Min.X;
            if Bottom-Top<Min.Y then Bottom:=Top+Min.Y;
            if Right-Left>Max.X then Right:=Left+Max.X;
            if Bottom-Top>Max.Y then Bottom:=Top+Max.Y;
          end
          else
          begin
            Limit:=ClientRect;
            if Assigned(FOnMoveLimit) then FOnMoveLimit(Self,AControl,Limit);
            if Left<Limit.Left then OffsetRect(R,Limit.Left-Left,0);
            if Top<Limit.Top then OffsetRect(R,0,Limit.Left-Top);
            if Right>Limit.Right-FGrabSize div 2 then OffsetRect(R,Limit.Right-Right-FGrabSize div 2,0);
            if Bottom>Limit.Bottom-FGrabSize div 2 then OffsetRect(R,0,Limit.Bottom-Bottom-FGrabSize div 2);
          end;
    end;

  begin
    if KeyType=ktMove then
    begin
      i:=0;
      while i<ControlCount do
        if (Controls[i].Parent<>Control.Parent) or
          IsLocked(Controls[i]) then DeleteControl(Controls[i])
        else Inc(i);
    end;

    {Do not move form}
    if (KeyType = ktMove) and AvoidFormMoving and (ControlCount = 1) and (Controls[0] = ParentForm) then
      Exit;

    for i:=0 to Pred(ControlCount) do
      if ValidControl(Controls[i]) then
        with Controls[i] do
        begin
          R:=BoundsRect;
          case Key of
            VK_RIGHT:
              case KeyType of
                ktSelect: Control:=FindNextControl(True);
                ktMove: OffsetRect(R,1,0);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,FGridStepX,0);
                {$ELSE}
                ktFastMove: OffsetRect(R,FGridStep,0);
                {$ENDIF}
                ktSize: GrowRect(R,1,0);
              end;
            VK_LEFT:
              case KeyType of
                ktSelect: Control:=FindNextControl(False);
                ktMove: OffsetRect(R,-1,0);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,-FGridStepX,0);
                {$ELSE}
                ktFastMove: OffsetRect(R,-FGridStep,0);
                {$ENDIF}
                ktSize: GrowRect(R,-1,0);
              end;
            VK_UP:
              case KeyType of
                ktSelect: Control:=FindNextControl(False);
                ktMove: OffsetRect(R,0,-1);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,0,-FGridStepY);
                {$ELSE}
                ktFastMove: OffsetRect(R,0,-FGridStep);
                {$ENDIF}
                ktSize: GrowRect(R,0,-1);
              end;
            VK_DOWN:
              case KeyType of
                ktSelect: Control:=FindNextControl(True);
                ktMove: OffsetRect(R,0,1);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,0,FGridStepY);
                {$ELSE}
                ktFastMove: OffsetRect(R,0,FGridStep);
                {$ENDIF}
                ktSize: GrowRect(R,0,1);
              end;
            VK_DELETE:
              Case KeyType of
                ktSelect:
                  RemoveSelectedControls
              end;
          end;
          if (KeyType<>ktSelect) and Assigned(ParentForm) then
          begin
            CheckRect(Controls[i],R);
            if not EqualRect(BoundsRect,R) then
            begin
              BoundsRect:=R;
              if ValidControl(Controls[i]) and Assigned(Parent) then
                MapWindowPoints(Parent.Handle,ParentForm.Handle,R,2);
              if ControlCount>1 then DrawMultiSelect(Controls[i]);
              if Assigned(FGrabHandles) then FGrabHandles.Update(False);
              Application.ProcessMessages;
              DoMoveSizeControl;
            end;
          end
          else Break;
        end;
    DoChange;
  end;

  function GetMouseControl(Wnd: HWND; LParam: Integer): TControl;

  var
    Child: TControl;
    Parent: TWinControl;
    ParentPoint: TPoint;
    OrgWnd: HWND;
    {$IFNDEF NOFRAMES}
    i: Integer;
    {$ENDIF}

    function TopLevel(AOwner: TComponent; C: TControl): Boolean;
    begin
      Result:=False;
      if Assigned(C) then
        with C do
          Result:=(C.Owner=AOwner) or (Owner is TCustomForm)
          {$IFNDEF NOFRAMES}
          or (Owner is TCustomFrame)
          {$ENDIF}
          ;
    end;

    function ControlAtPos: TControl;
    var
      i: Integer;

      function FormRect(Control: TControl): TRect;
      begin
        if ValidControl(Control) and ValidControl(Control.Parent) then
        begin
          Result:=Control.BoundsRect;
          with Result do
          begin
            TopLeft:=ParentForm.ScreenToClient(Control.Parent.ClientToScreen(TopLeft));
            BottomRight:=ParentForm.ScreenToClient(Control.Parent.ClientToScreen(BottomRight));
          end;
        end
        else Result:=Rect(0,0,0,0);
      end;

    begin
      if Assigned(ParentForm) then
        with ParentForm do
        begin
          Result:=ControlAtPos(ParentPoint,True);
          if IsTransparent(Result) or not TopLevel(ParentForm,Result) then Result:=nil;
          if not ValidControl(Result) or IsTransparent(Result) then
            for i:=Pred(ComponentCount) downto 0 do
              if (Components[i] is TControl) and (ValidControl(TControl(Components[i]))) then
                if TControl(Components[i]).Visible and
                  PtInRect(FormRect(TControl(Components[i])),ParentPoint) and
                  not IsTransparent(TControl(Components[i])) and
                  TopLevel(ParentForm,TControl(Components[i])) then
                begin
                  Result:=TControl(Components[i]);
                  Break;
                end;
        end
      else Result:=nil;
    end;

    function ControlAtPoint(C: TWinControl; P: TPoint): TControl;
    var
      i: Integer;
    begin
      Result:=nil;
      with C do
        for i:=Pred(ControlCount) downto 0 do
          if PtInRect(Controls[i].BoundsRect,P) and
            ((csDesigning in Controls[i].ComponentState) or Controls[i].Visible) then
          begin
            Result:=Controls[i];
            Break;
          end;
    end;

  begin
    ParentPoint:=Point(LoWord(LParam),HiWord(LParam));
    Parent:=FindWinControl(Wnd);
    if not Assigned(Parent) then Parent:=ParentForm;
    MapWindowPoints(Wnd,Parent.Handle,ParentPoint,1);
    OrgWnd:=Wnd;
    if Assigned(FGrabHandles) then Result:=FGrabHandles.FindHandleControl(Wnd)
    else Result:=nil;
    if not ValidControl(Result) then
    begin
      Result:=FindWinControl(Wnd);
      if ValidControl(Result) then
      begin
        Child:=ControlAtPoint((Result as TWinControl),(Point(LoWord(LParam),HiWord(LParam))));
        if not TopLevel(ParentForm,Child) then Child:=nil;
      end
      else Child:=nil;
      if ValidControl(Child) then Result:=Child
      else
      begin
        if Result=nil then
          while (Wnd<>0) and not ValidControl(Result) do
          begin
            Wnd:=Windows.GetParent(Wnd);
            Result:=FindWinControl(Wnd);
          end;
        if (Result=nil) and InParentForm(OrgWnd) then Result:=ControlAtPos;
      end;
    end;
    {$IFNDEF NOFRAMES}
    if Result is TCustomFrame then
      with TCustomFrame(Result) do
      begin
        for i:=Pred(ComponentCount) downto 0 do
          if Components[i] is TWinControl then
            if TWinControl(Components[i]).Handle=OrgWnd then
            begin
              Result:=TControl(Components[i]);
              Break;
            end;
        if ValidControl(Result) and (Result is TWinControl) then
        begin
          Child:=(Result as TWinControl).ControlAtPos(Point(LoWord(LParam),HiWord(LParam)),True);
          if not TopLevel(Result,Child) then Child:=nil;
        end
        else Child:=nil;
        if ValidControl(Child) then Result:=Child
      end;
    {$ENDIF}
    if Assigned(FGrabHandles) and not FGrabHandles.IsGrabHandle(Result) then
    begin
      while Assigned(Result) and not TopLevel(ParentForm,Result) do Result:=Result.Parent;
      while Assigned(Result) and IsTransparent(Result) do Result:=Result.Parent;
      if Result=ParentForm then Result:=nil;
    end;
  end;

  function SelectableParent(AControl: TControl): TControl;
  begin
    if ValidControl(AControl) then
    begin
      Result:=AControl.Parent;
      while ValidControl(Result) and
        (Result<>ParentForm) and
        (IsLocked(Result) or IsTransparent(Result) or IsProtected(Result)) do
        Result:=Result.Parent;
      if Result=ParentForm then Result:=nil;
    end
    else Result:=nil;
  end;

  function NormalRect(Rect: TRect): TRect;
  begin
    with Rect do
    begin
      if Left<Right then
      begin
        Result.Left:=Left;
        Result.Right:=Right;
      end
      else
      begin
        Result.Left:=Right;
        Result.Right:=Left;
      end;
      if Top<Bottom then
      begin
        Result.Top:=Top;
        Result.Bottom:=Bottom;
      end
      else
      begin
        Result.Top:=Bottom;
        Result.Bottom:=Top;
      end;
    end;
  end;

  function GetPopupParent(W: HWND): HWND;
  begin
    Result:=W;
    if Assigned(ParentForm) then
      while (W<>0) and (W<>ParentForm.Handle) and (W<>Application.Handle) do
      begin
        W:=GetParent(W);
        if (W<>0) and (W<>Application.Handle) then Result:=W;
      end;
  end;

  function IsActiveOwner: Boolean;
  var
    F: TWinControl;
  begin
    Result:=Application.Active and IsLibrary;
    if not Result then
    begin
      F:=ParentForm;
      while ValidControl(F) do
      begin
        if (Screen.ActiveForm=F) or
          (Screen.ActiveForm<>nil) and (Screen.ActiveForm.ActiveMDIChild=F) then
        begin
          Result:=True;
          Break
        end;
        F:=F.Parent;
      end;
    end;
  end;

  function FindControlHandle(C: TComponent; W: HWND): Boolean;
  var
    i: Integer;
  begin
    Result:=False;
    with C do
      for i:=0 to Pred(ComponentCount) do
        if Components[i] is TWinControl then
          with TWinControl(Components[i]) do
            if HandleAllocated and (Handle=W) then
            begin
              Result:=True;
              Break;
            end;
    if not Result then
    begin
      W:=GetParent(W);
      if (W<>0) and (W<>ParentForm.Handle) then Result:=FindControlHandle(C,W);
    end;
  end;

  function IsProtectedHandle(W: HWND): Boolean;
  var
    C: TWinControl;
  begin
    Result:=False;
    while W<>0 do
    begin
      C:=FindControl(W);
      if ValidControl(C) and IsProtected(C) then
      begin
        Result:=True;
        Break;
      end;
      W:=GetParent(W);
    end;
  end;

  function InParentForm(WND: HWND): Boolean;
  begin
    Result:=False;
    while WND<>0 do
    begin
      if WND=ParentForm.Handle then
      begin
        Result:=True;
        Exit;
      end;
      WND:=GetParent(WND);
    end;
  end;

  function InDesignControl(WND: HWND): Boolean;
  var
    C: TWinControl;
  begin
    if not Assigned(DesignControl) then Result:=InParentForm(WND)
    else
    begin
      Result:=False;
      C:=FindControl(WND);
      if Assigned(C) then
        while Assigned(C) do
        begin
          if C=DesignControl then
          begin
            Result:=True;
            Break;
          end;
          C:=C.Parent;
        end;
    end;
  end;

var
  RL: TRect;
begin
  if not Assigned(DesignControl) and Assigned(ParentForm) and ParentForm.HandleAllocated then
    if GetWindowLong(ParentForm.Handle,GWL_WNDPROC)<>Integer(FWinProc) then
    begin
      SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FDefaultProc));
      FDefaultProc := TFarProc(GetWindowLong(ParentForm.Handle,GWL_WNDPROC));
      SetWindowLong(ParentForm.Handle,GWL_WNDPROC,Integer(FWinProc));
    end;
  if not Locked then
  begin
    if Assigned(ParentForm) and IsActiveOwner then
    begin
      Lock;
      with Msg do
        case Message of
          CM_COLORCHANGED:
            UpdateGrid;
          WM_MOVE,WM_SIZE:
            if hwnd=ParentForm.Handle then UpdateGrabs;
          CM_DEACTIVATE: LeaveMouseAction;
          WM_PAINT:
            if (hwnd<>ParentForm.Handle) and Assigned(FHintWindow) and (hwnd<>FHintWindow.Handle) and (MouseAction=maDragging) then
              Message:=0;
          WM_LBUTTONDBLCLK,WM_RBUTTONDBLCLK,WM_MBUTTONDBLCLK,
          WM_NCLBUTTONDBLCLK,WM_NCRBUTTONDBLCLK,WM_NCMBUTTONDBLCLK:
          begin
            GetCursorPos(P);
            NewControl:=GetMouseControl(hwnd,LParam);
            if (FClickPos.X=P.X) and (FClickPos.Y=P.Y) then
            begin
              if ValidControl(NewControl) and not IsProtected(NewControl) then
              begin
                if (Message=WM_LBUTTONDBLCLK) or (Message=WM_NCLBUTTONDBLCLK) then
                  DoControlDblClick(NewControl);
                Message:=0;
              end else
              if (ParentForm <> nil) and (hwnd = ParentForm.Handle) then //ParentForm doubleclicked
              begin
                if (Message=WM_LBUTTONDBLCLK) or (Message=WM_NCLBUTTONDBLCLK) then
                  DoControlDblClick(ParentForm);
              end;

              if (hwnd<>ParentForm.Handle) and not IsProtectedHandle(hwnd) and
                InParentForm(hwnd) then Message:=0;
              if not ValidControl(NewControl) and (hwnd<>ParentForm.Handle) and
                InParentForm(hwnd) then Message:=0;
              if ValidControl(Control) and (Control=NewControl) then Message:=0;
            end
            else
              if Assigned(NewControl) then Message:=0;
          end;
          WM_RBUTTONDOWN,WM_NCRBUTTONDOWN:
          begin
            NewControl:=GetMouseControl(hwnd,LParam);
            if ValidControl(NewControl) then
              if not IsProtected(NewControl) then
              begin
                {$IFDEF TFDTRIAL}
                if NewControl.Parent<>ParentForm then
                begin
                  Message:=0;
                  ShowTrialWarning;
                  Exit;
                end;
                {$ENDIF}
                FMenuControl:=NewControl;
                if ControlIndex(NewControl)=-1 then Control:=NewControl;
              end
              else FMenuControl:=nil
            else FMenuControl:=nil;
            if (hwnd=ParentForm.Handle) and not Assigned(FMenuControl) then
              FMenuControl:=ParentForm;
          end;
          WM_RBUTTONUP,WM_NCRBUTTONUP:
          begin
            Handled:=False;
            if Assigned(FOnContextPopup) then
              FOnContextPopup(Self,Handled);
            if not Handled and ValidControl(FMenuControl) and
              ((GetMouseControl(hwnd,LParam)=FMenuControl) or (FMenuControl=ParentForm)) then
            begin
              if Assigned(FPopupMenu) then
              begin
                GetCursorPos(NewDrag);
                with NewDrag do
                begin
                  Lock;
                  try
                    {Destroy the context items}
                    FPopupItems.Clear;

                    {Create context items if only one control is selected}
                    if FMenuControl is TComponentContainer then
                      BuildContextItems(TComponentContainer(FMenuControl).Component, FPopupMenu)
                    else
                      BuildContextItems(FMenuControl, FPopupMenu);

                    FPopupMenu.Popup(X,Y);
                  finally
                    Unlock;
                  end;
                end;
              end;
              Message:=0;
            end
            else
              if (GetMouseControl(hwnd, LParam) <> nil) and not IsProtected(GetMouseControl(hwnd,LParam)) then
                Message := 0;
          end;
          WM_LBUTTONDOWN{,WM_NCLBUTTONDOWN}:
          begin
            FIgnoreMouseMove:=True;
            if GetCapture=ParentForm.Handle then ReleaseCapture;
            GetCursorPos(FClickPos);
            HideHint;
            if not InDesignControl(hwnd) then Exit;
            if (Message=WM_NCLBUTTONDOWN) and
              ((hwnd=ParentForm.Handle) and (wParam<>HTCLIENT)) then Exit;
            if GetPopupParent(hwnd)<>ParentForm.Handle then Exit;
            if (hwnd<>ParentForm.Handle) and
              not FindControlHandle(ParentForm,hwnd) and
              (not Assigned(FGrabHandles) or not Assigned(FGrabHandles.FindHandleControl(hwnd))) then Exit;
            if TForm(ParentForm).FormStyle=fsMDIChild then SendMessage(ParentForm.Handle,WM_MDIACTIVATE,0,ParentForm.Handle);
            NewControl:=GetMouseControl(hwnd,lParam);
            if Assigned(NewControl) and (NewControl.Perform(CM_DESIGNHITTEST,wParam,lParam)<>0) then Exit;
            if FMultiSelect and (Assigned(FDesignControl) and (NewControl=FDesignControl) or
              (GetKeyState(VK_CONTROL) and $80 <> 0) or
              (hwnd=ParentForm.Handle) and not ValidControl(NewControl)) then
            begin
              FGrabHandles.Enabled:=False;
              with FSelectRect do
              begin
                GetCursorPos(TopLeft);
                BottomRight:=TopLeft;
              end;
              FSelectCounter:=0;
              if ControlCount>1 then
                while ControlCount>0 do
                begin
                  DoDeleteControl(FControls[0]);
                  if ValidControl(TControl(FControls[0]).Parent) then
                    if TControl(FControls[0]) is TWinControl then
                      RedrawWindow(TWinControl(FControls[0]).Handle,nil,0,RDW_INVALIDATE or RDW_ALLCHILDREN);
                    TControl(FControls[0]).Invalidate;
                  FControls.Delete(0);
                end
              else
              begin
                if Assigned(Control) then DoDeleteControl(Control);
                FControls.Clear;
                DoSelectControl(Control);
                DoSelectionChange;
              end;
              FGrabHandles.Control:=nil;
              FSelectControl:=FindWinControl(hwnd);
              if not ValidControl(FSelectControl) then FSelectControl:=ParentForm
              else
                while ValidControl(FSelectControl.Parent) and
                  not (csAcceptsControls in FSelectControl.ControlStyle) do
                  FSelectControl:=FSelectControl.Parent;
              with FSelectControl,R do
              begin
                R:=ClientRect;
                TopLeft:=ClientToScreen(TopLeft);
                BottomRight:=ClientToScreen(BottomRight);
              end;
              SetCapture(ParentForm.Handle);
              ClipCursor(@R);
              FMouseAction:=maSelecting;
              ParentForm.ActiveControl:=nil;
              PostMessage(ParentForm.Handle, WM_DESIGNERMDOWN, 0, 0);
              Message:=0;
            end
            else
            begin
              GetCursorPos(FDragPoint);
              if Assigned(FGrabHandles) then
              begin
                FDragHandle:=FGrabHandles.FindHandle(hwnd);
                if not IsProtected(NewControl) or (NewControl=FDesignControl) then FGrabHandles.Enabled:=False;
              end
              else FDragHandle:=gpNone;
              FGrabHandles.Enabled:=False;
              {$IFNDEF GFDXPTHEMES}
              //Application.ProcessMessages;
              {$ENDIF}
              if FDragHandle=gpNone then
              begin
                if ValidControl(NewControl) then
                  if not IsProtected(NewControl) then
                  begin
                    {$IFDEF TFDTRIAL}
                    if NewControl.Parent<>ParentForm then
                    begin
                      Message:=0;
                      ShowTrialWarning;
                      Exit;
                    end;
                    {$ENDIF}
                    ParentForm.ActiveControl:=nil;
                    if FMultiSelect and (GetKeyState(VK_SHIFT) and $80 <> 0) then
                    begin
                      if ControlIndex(NewControl)=-1 then
                      begin
                        if ControlCount=1 then DrawMultiSelect(Control);
                        AddControl(NewControl);
                      end
                      else
                        if ControlCount>1 then
                        begin
                          DeleteControl(NewControl);
                          NewControl.Invalidate;
                          if ControlCount=1 then Control.Invalidate;
                        end;
                      if Assigned(FGrabHandles) and (FGrabHandles.Control<>Control) then
                        FGrabHandles.Control:=Control;
                      Application.ProcessMessages;
                      PostMessage(ParentForm.Handle, WM_DESIGNERMDOWN, 0, 0);
                      Message:=0;
                      Exit;
                    end
                    else
                    begin
                      if (ControlIndex(NewControl)<>-1) and (ControlCount>1) then
                      begin
                        AddControl(NewControl);
                        if CheckParent(NewControl,True) then Message:=0;
                      end
                      else
                      begin
                        if ControlCount>1 then
                          while ControlCount>0 do
                          begin
                            DoDeleteControl(FControls[0]);
                            TControl(FControls[0]).Invalidate;
                            FControls.Delete(0);
                          end;
                        if NewControl<>Control then
                        begin
                          if Assigned(Control) then DoDeleteControl(Control);
                          FControls.Clear;
                          AddControl(NewControl);
                        end;
                        if IsLocked(NewControl) then
                        begin
                          FGrabHandles.Control:=Control;
                          PostMessage(ParentForm.Handle, WM_DESIGNERMDOWN, 0, 0);
                          Message:=0;
                          Exit;
                        end;
                      end;
                    end;
                  end
                  else
                  begin
                    if (FProtectMode=pmUnselect) and (NewControl<>Control) then
                    begin
                      Control:=nil;
                      if NewControl is TWinControl then
                        with TWinControl(NewControl) do
                          if Showing and CanFocus then SetFocus;
                    end;
                    if NewControl=FDesignControl then Control:=nil;
                    Exit;
                  end
                else
                begin
                  if GetPopupParent(hwnd)=ParentForm.Handle then
                  begin
                    Control:=nil;
                    ParentForm.ActiveControl:=nil;
                  end;
                end;
              end
              else NewControl:=nil;
              Application.ProcessMessages;
              //ParentForm.Repaint;
              if ValidControl(NewControl) and not IsLocked(NewControl) or
                ValidControl(Control) and not IsLocked(Control) and (FDragHandle<>gpNone) then
              begin
                Screen.Cursor:=GetGrabCursor(FDragHandle);
                if ValidControl(Control) then
                begin
                  FDragRect:=Control.BoundsRect;
                  FGrabHandles.Control:=Control;
                  if ValidControl(Control) and ValidControl(Control.Parent) then
                  begin
                    DrawDragRects;
                    with Control.Parent,R do
                    begin
                      R:=ClientRect;
                      if Assigned(FOnMoveLimit) then FOnMoveLimit(Self,Control,R);
                      if FMoveLimitMode=lmControls then
                      begin
                        Min.X:=MaxInt;
                        Min.Y:=MaxInt;
                        Max.X:=-MaxInt;
                        Max.Y:=-MaxInt;
                        for i:=0 to Pred(ControlCount) do
                        begin
                          with Controls[i] do
                          begin
                            if Left<Min.X then Min.X:=Left;
                            if Top<Min.Y then Min.Y:=Top;
                            if Left+Width>Max.X then Max.X:=Left+Width;
                            if Top+Height>Max.Y then Max.Y:=Top+Height;
                          end;
                        end;
                        with ScreenToClient(FDragPoint) do
                        begin
                          Inc(Left,X-Min.X);
                          Inc(Top,Y-Min.Y);
                          Dec(Right,Max.X-X);
                          Dec(Bottom,Max.Y-Y);
                        end;
                      end;
                      TopLeft:=ClientToScreen(TopLeft);
                      BottomRight:=ClientToScreen(BottomRight);
                    end;
                    SetCapture(ParentForm.Handle);
                    ClipCursor(@R);
                  end;
                end;
                PostMessage(ParentForm.Handle, WM_DESIGNERMDOWN, 0, 0);
                Message:=0;
                FMouseAction:=maDragging;
                if ValidControl(Control) then
                  with Control do
                    if FDragHandle<>gpNone then Self.ShowHint(Format('%d x %d',[Width,Height]),hmSize)
                    else Self.ShowHint(Format('%d, %d',[Left,Top]),hmMove);
              end
              else
              begin
                PostMessage(ParentForm.Handle, WM_DESIGNERMDOWN, 0, 0);
                Message:=0;
              end;
            end;
          end;
          WM_LBUTTONUP{,WM_NCLBUTTONUP}:
          begin
            HideHint;
            if (Message=WM_NCLBUTTONUP) and
              ((hwnd=ParentForm.Handle) or (wParam<>HTCLIENT)) then Exit;
            case MouseAction of
              maDragging:
              begin
                DrawDragRects;
                FMouseAction:=maNone;
                FDragHandle:=gpNone;
                if ControlCount>1 then
                begin
                  NewDrag.X:=FDragRect.Left-Control.Left;
                  NewDrag.Y:=FDragRect.Top-Control.Top;
                  for i:=0 to Pred(ControlCount) do
                  begin
                    R:=Controls[i].BoundsRect;
                    OffsetRect(R,NewDrag.X,NewDrag.Y);
                    if not EqualRect(R,Controls[i].BoundsRect) then
                    begin
                      Controls[i].BoundsRect:=R;
                      DrawMultiSelect(Controls[i]);
                    end;
                    Application.ProcessMessages;
                    DoMoveSizeControl;
                  end;
                  DoChange;
                end
                else
                begin
                  R:=NormalRect(FDragRect);
                  if ValidControl(Control) then
                  begin
                    if Assigned(FOnSizeLimit) then
                      with R do
                      begin
                        Min:=Point(0,0);
                        Max:=Point(MaxInt,MaxInt);
                        FOnSizeLimit(Self,Control,Min,Max);
                        if Right-Left<Min.X then Right:=Left+Min.X;
                        if Bottom-Top<Min.Y then Bottom:=Top+Min.Y;
                        if Right-Left>Max.X then Right:=Left+Max.X;
                        if Bottom-Top>Max.Y then Bottom:=Top+Max.Y;
                      end;
                    if not EqualRect(R,Control.BoundsRect) then
                    begin
                      Control.BoundsRect:=R;
                      Application.ProcessMessages;
                      DoMoveSizeControl;
                      DoChange;
                    end;
                    FDragRect:=Control.BoundsRect;
                  end;
                end;
                Application.ProcessMessages;
                Message:=0;
                if Assigned(FGrabHandles) then
                  with FGrabHandles do
                  begin
                    if FindHandle(hwnd)=gpNone then SetArrowCursor;
                    Enabled:=True;
                    Update(True);
                  end
                else SetArrowCursor;
                Application.ProcessMessages;
                if GetCapture=ParentForm.Handle then ReleaseCapture;
                ClipCursor(nil);
                if FAlignmentLines<>[] then ParentForm.Invalidate
                else SendMessage(ParentForm.Handle,WM_ERASEBKGND,0,0);
              end;
              maSelecting:
              begin
                FMouseAction:=maNone;
                DrawSelectRect;
                Lock;
                try
                  if Assigned(FSelectControl) then
                  begin
                    with FSelectControl do
                    begin
                      FSelectRect:=NormalRect(FSelectRect);
                      with FSelectRect do
                      begin
                        TopLeft:=ScreenToClient(TopLeft);
                        BottomRight:=ScreenToClient(BottomRight);
                      end;
                      if Assigned(FOnEndSelecting) then FOnEndSelecting(Self,FSelectRect);
                      for i:=0 to Pred(ControlCount) do
                        if not IsTransparent(Controls[i]) and
                          not IsProtected(Controls[i]) and
                          ((csDesigning in Controls[i].ComponentState) or Controls[i].Visible) and
                          {$IFNDEF NOCSSUBCOMPONENT}
                          not (csSubComponent in Controls[i].ComponentStyle) and
                          {$ENDIF}
                          (Controls[i].Parent.Showing) then
                        begin
                          IntersectRect(R,FSelectRect,Controls[i].BoundsRect);
                          if not IsRectEmpty(R) then
                          begin
                            with FControls do
                            begin
                              if IndexOf(Controls[i])=-1 then
                              begin
                                Insert(0,Controls[i]);
                                Application.ProcessMessages;
                                DoAddControl(Controls[i]);
                              end;
                            end;
                            DoSelectControl(Controls[i]);
                          end;
                        end;
                    end;
                    DoSelectionChange;
                    if (ControlCount=1) and Assigned(FGrabHandles) then
                      with FGrabHandles do
                      begin
                        Control:=Self.Control;
                        Enabled:=True;
                        Update(False);
                      end;
                    if Assigned(FGrabHandles) then
                      with FGrabHandles do
                      begin
                        Enabled:=True;
                        Update(False);
                      end;
                  end;
                finally
                  Unlock;
                end;
                Application.ProcessMessages;
                if ControlCount>1 then
                  for i:=0 to Pred(ControlCount) do DrawMultiSelect(Controls[i]);
                Message:=0;
                if GetCapture=ParentForm.Handle then ReleaseCapture;
                ClipCursor(nil);
              end;
            else
            begin
              if not IsProtected(Control) and Assigned(FGrabHandles) then
                with FGrabHandles do
                begin
                  if FindHandle(hwnd)=gpNone then SetArrowCursor;
                  if not Enabled then
                  begin
                    Enabled:=True;
                    Update(True);
                  end;
                end;
              end;
            end;
            {$IFDEF LIKE236}
            Application.ProcessMessages;
            {$ENDIF}
          end;
          WM_MOUSEMOVE,WM_NCMOUSEMOVE:
            if GetPopupParent(hwnd)=ParentForm.Handle then
            begin
              if not ValidControl(Control) and (GetCapture=ParentForm.Handle) and
                not ((Message<>WM_NCMOUSEMOVE) and (hwnd=ParentForm.Handle)) then
                  ReleaseCapture;
              if GetKeyState(VK_LBUTTON) and $80 = 0 then
              begin
                if IsProtected(GetMouseControl(hwnd,lParam)) then Screen.Cursor:=crDefault;
                LeaveMouseAction;
                NewControl:=GetMouseControl(hwnd,LParam);
                if FShowComponentHint and Assigned(NewControl) and not IsProtected(NewControl) and (GetCapture=0) then
                begin
                  if FHintControl<>NewControl then
                  begin
                    FHintControl:=NewControl;
                    if FHintTimer.Enabled then
                    begin
                      ShowHint(GetComponentHint(NewControl),hmCustom);
                      StartTimer(Application.HintHidePause);
                    end
                    else StartTimer(Application.HintPause)
                  end
                  else
                    if not FHintTimer.Enabled then StartTimer(Application.HintHidePause);
                end
                else
                begin
                  FHintControl:=nil;
                  StopTimer;
                  HideHint;
                end;
              end;
              case FMouseAction of
                maDragging:
                  if FIgnoreMouseMove then FIgnoreMouseMove:=False
                  else
                  begin
                    StopTimer;
                    if GetKeyState(VK_LBUTTON) and $80 = 0 then LeaveMouseAction
                    else
                      if ValidControl(Control) then
                      begin
                        GetCursorPos(NewDrag);
                        with NewDrag do
                        begin
                          X:=X-FDragPoint.X;
                          Y:=Y-FDragPoint.Y;
                          if FEnableAxisDrag and (GetKeyState(VK_CONTROL) and $80 <> 0) then
                            if (X<>0) and (Y<>0) then
                            begin
                              if Abs(Y)>Abs(X) then X:=0
                              else Y:=0;
                            end;
                          if (FDragHandle=gpNone) and
                            FSnapToGrid and (GetKeyState(VK_MENU) and $80 = 0) then
                          begin
                            {$IFDEF GFDADVANCEDGRID}
                            X:=Round(X/FGridStepX)*FGridStepX;
                            Y:=Round(Y/FGridStepY)*FGridStepY;
                            {$ELSE}
                            X:=Round(X/FGridStep)*FGridStep;
                            Y:=Round(Y/FGridStep)*FGridStep;
                            {$ENDIF}
                          end;
                        end;
                        if ValidControl(Control) then R:=Control.BoundsRect;
                        with NewDrag do
                          case FDragHandle of
                            {$IFDEF GFD2542921}
                            gpNone: if Control.Tag<>2542921 then OffsetRect(R,X,Y);
                            {$ELSE}
                            gpNone: OffsetRect(R,X,Y);
                            {$ENDIF}
                          else
                            with R do
                            begin
                              case FDragHandle of
                                gpLeftTop:
                                begin
                                  Left:=Left+X;
                                  Top:=Top+Y;
                                end;
                                gpLeftMiddle: Left:=Left+X;
                                gpLeftBottom:
                                begin
                                  Left:=Left+X;
                                  Bottom:=Bottom+Y;
                                end;
                                gpMiddleTop: Top:=Top+Y;
                                gpMiddleBottom: Bottom:=Bottom+Y;
                                gpRightTop:
                                begin
                                  Right:=Right+X;
                                  Top:=Top+Y;
                                end;
                                gpRightMiddle: Right:=Right+X;
                                gpRightBottom:
                                begin
                                  Right:=Right+X;
                                  Bottom:=Bottom+Y;
                                end;
                              end;
                              if FSnapToGrid and (GetKeyState(VK_MENU) and $80 = 0) then
                              begin
                                {$IFDEF GFDADVANCEDGRID}
                                if FDragHandle in [gpLeftTop,gpLeftMiddle,gpLeftBottom] then
                                  Left:=Round(Left/FGridStepX)*FGridStepX;
                                if FDragHandle in [gpLeftTop,gpMiddleTop,gpRightTop] then
                                  Top:=Round(Top/FGridStepY)*FGridStepY;
                                if FDragHandle in [gpRightTop,gpRightMiddle,gpRightBottom] then
                                  Right:=Succ(Round(Right/FGridStepX)*FGridStepX);
                                if FDragHandle in [gpLeftBottom,gpMiddleBottom,gpRightBottom] then
                                  Bottom:=Succ(Round(Bottom/FGridStepY)*FGridStepY);
                                {$ELSE}
                                if FDragHandle in [gpLeftTop,gpLeftMiddle,gpLeftBottom] then
                                  Left:=Round(Left/FGridStep)*FGridStep;
                                if FDragHandle in [gpLeftTop,gpMiddleTop,gpRightTop] then
                                  Top:=Round(Top/FGridStep)*FGridStep;
                                if FDragHandle in [gpRightTop,gpRightMiddle,gpRightBottom] then
                                  Right:=Succ(Round(Right/FGridStep)*FGridStep);
                                if FDragHandle in [gpLeftBottom,gpMiddleBottom,gpRightBottom] then
                                  Bottom:=Succ(Round(Bottom/FGridStep)*FGridStep);
                                {$ENDIF}
                              end;
                              if GetKeyState(VK_SHIFT) and $80 <> 0 then
                                if Abs(Right-Left)/(Control.Width) < Abs(Bottom-Top)/Control.Height then
                                  Bottom:=Top+(Right-Left)*Control.Height div Control.Width
                                else
                                  Right:=Left+(Bottom-Top)*Control.Width div Control.Height;
                            end;
                          end;
                        if not EqualRect(R,FDragRect) then
                        begin
                          HideHint;
                          DrawDragRects;
                          FDragRect:=R;
                          DrawDragRects;
                          with FDragRect do
                            if FDragHandle<>gpNone then Self.ShowHint(Format('%d x %d',[Abs(Right-Left),Abs(Bottom-Top)]),hmSize)
                            else
                            begin
                              P:=GetControlsOrigin;
                              Inc(P.X,FDragRect.Left-Control.Left);
                              Inc(P.Y,FDragRect.Top-Control.Top);
                              Self.ShowHint(Format('%d, %d',[P.X,P.Y]),hmMove);
                            end;
                        end;
                      end;
                  end;
                maSelecting:
                  if GetKeyState(VK_LBUTTON) and $80 = 0 then LeaveMouseAction
                  else
                  begin
                    if FSelectCounter>0 then DrawSelectRect;
                    GetCursorPos(FSelectRect.BottomRight);
                    if FSelectCounter=0 then FSelectRect.TopLeft:=FSelectRect.BottomRight;
                    if FSelectCounter>0 then DrawSelectRect;
                    Inc(FSelectCounter);
                  end;
              else
                if GetCapture=0 then
                begin
                  NewControl:=GetMouseControl(HWND,lParam);
                  if ValidControl(NewControl) then
                  begin
                    if Assigned(FGrabHandles) and (FGrabHandles.FindHandle(HWND)=gpNone) then
                      if IsProtected(NewControl) or IsTransparent(NewControl) then
                        Screen.Cursor:=crDefault
                      else SetArrowCursor
                    else
                      if Assigned(FGrabHandles) and (FGrabHandles.FindHandle(HWND)<>gpNone) then
                        Screen.Cursor:=crDefault
                      else
                        if IsLocked(NewControl) then SetArrowCursor;
                  end
                  else Screen.Cursor:=crDefault;
                end;
              end;
            end;
          WM_KEYDOWN:
            // Screen <-> ParentForm
            if (
                 (Screen.ActiveControl=ParentForm) or (Screen.ActiveControl.Owner=ParentForm) or
                 (
                    (ParentForm <> nil) and (Screen.ActiveControl = ParentForm.Parent) //Check specifically for TFormDesignControl
                 )
               ) and
              (ProtectMode<>pmLockKeyboard) or not ValidControl(Screen.ActiveControl) or
              not IsProtected(Screen.ActiveControl) or (Screen.ActiveControl=ParentForm) then
            begin
              if FSnapToGridKey then
                if GetKeyState(VK_SHIFT) and $80 <> 0 then
                  if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType:=ktFastMove
                  else KeyType:=ktSize
                else
                  if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType:=ktFastMove
                  else KeyType:=ktSelect
              else
                if GetKeyState(VK_SHIFT) and $80 <> 0 then
                  if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType:=ktFastMove
                  else KeyType:=ktSize
                else
                  if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType:=ktMove
                  else KeyType:=ktSelect;
              if (KeyType=ktSelect) and not FKeySelect then Exit;
              if (KeyType<>ktSelect) and not FKeyMove then Exit;
              case wParam of
                VK_ESCAPE:
                  if MouseAction<>maNone then LeaveMouseAction
                  else Control:=SelectableParent(Control);
                VK_TAB:
                begin
                  Control:=FindNextControl(GetKeyState(VK_SHIFT) and $80 = 0);
                  if ValidControl(Control) then Message:=0;
                end;
                VK_RIGHT,VK_LEFT,VK_UP,VK_DOWN,VK_DELETE:
                begin
                  ProcessKey(wParam);
                  if ValidControl(Control) then Message:=0;
                end;
              else
              begin
                if Assigned(FOnKeyDown) then
                begin
                  Key:=wParam;
                  FOnKeyDown(Self,Key,KeyDataToShiftState(lParam));
                  wParam:=Key;
                end;
                Exit;
              end;
              end;
            end;
          WM_KEYUP:
            case wParam of
              VK_TAB,VK_RIGHT,VK_LEFT,VK_UP,VK_DOWN,VK_DELETE: Message:=0;
            else
              if Assigned(FOnKeyUp) then
              begin
                Key:=wParam;
                FOnKeyUp(Self,Key,KeyDataToShiftState(lParam));
                wParam:=Key;
              end;
            end;
          CN_HSCROLL,CN_VSCROLL,WM_VSCROLL,WM_HSCROLL:
            FGrabHandles.Update(False);
          WM_SYSKEYDOWN,WM_SYSKEYUP:;
          {$IFNDEF NOMOUSEWHEEL}
          WM_MOUSEWHEEL: ParentForm.DefaultHandler(Msg);
          {$ENDIF}
        end // case Message of...
    end
    else
      if IsActiveOwner then
        if GetPopupParent(Msg.hwnd)<>ParentForm.Handle then Screen.Cursor:=crDefault
        else SetArrowCursor
  end
  else
  begin
    Screen.Cursor:=crDefault;
    if FWaiting then
      with Msg,ParentForm do
        case Message of
          WM_LBUTTONDOWN:
          begin
            if (GetPopupParent(hwnd)=Handle) and InDesignControl(hwnd) then
            begin
              {Focus the form. If the form has a parent (so it is in a TFormDesignControl)
               then focus the parent}

              if (ParentForm <> nil) and ParentForm.CanFocus then
              begin
                if (ParentForm.Parent <> nil) and ParentForm.Parent.CanFocus then
                  ParentForm.Parent.SetFocus
                else
                  ParentForm.SetFocus;
              end;

              FMouseAction := maPlacing;
              Message:=0;
              if hwnd=Handle then FPlacingParent:=ParentForm
              else
              begin
                FPlacingParent:=FindWinControl(hwnd);
                while Assigned(FPlacingParent) and
                  not (csAcceptsControls in FPlacingParent.ControlStyle) do
                  FPlacingParent := FPlacingParent.Parent;
              end;
              if Assigned(FPlacingParent) and (FPlacedComponentClass <> nil) then
              begin
                with FPlacingRect do
                begin
                  TopLeft:=Point(LoWord(lParam),HiWord(lParam));
                  MapWindowPoints(hwnd,ParentForm.Handle,FDragRect.TopLeft,1);
                  BottomRight:=TopLeft;
                end;
                DrawPlacingRect;

                RL := FPlacingParent.ClientRect;
                RL.TopLeft := FPlacingParent.ClientToScreen(RL.TopLeft);
                RL.BottomRight := FPlacingParent.ClientToScreen(RL.BottomRight);
                ClipCursor(@RL);
              end;
            end;
          end;
          WM_MOUSEMOVE:
            if FMouseAction=maPlacing then
              with FPlacingRect do
              begin
                DrawPlacingRect;
                BottomRight:=Point(LoWord(lParam),HiWord(lParam));
                if FPlacingParent <> nil then
                  MapWindowPoints(hwnd, FPlacingParent.Handle, BottomRight, 1);
                DrawPlacingRect;
              end;
          WM_LBUTTONUP:
          begin
            if FMouseAction=maPlacing then
            begin
              FMouseAction:=maNone;
              ReleaseCapture;
              DrawPlacingRect;
              Message:=0;
              WinControl := FPlacingParent;
              if WinControl = nil then
              begin
                if hwnd=Handle then WinControl:=ParentForm
                else
                begin
                  WinControl:=FindWinControl(hwnd);
                  while Assigned(WinControl) and
                    not (csAcceptsControls in WinControl.ControlStyle) do
                    WinControl:=WinControl.Parent;
                end;
              end;

              if Assigned(WinControl) and (FPlacedComponentClass <> nil) then
              begin
                FPlacingRect:=NormalRect(FPlacingRect);
                //MapWindowPoints(hwnd,WinControl.Handle,FPlacingRect,2);

                PerformComponentPlacing(WinControl, FPlacingRect);
              end;
              FPlacedComponentClass := nil;
              FWaiting := false;
              Unlock;
              ClipCursor(nil);
            end;
          end;
        end
    else
      if Assigned(FOnMessage) and (GetPopupParent(Msg.hwnd)=ParentForm.Handle) then FOnMessage(Self,Msg);
  end;
end;

procedure TAdvCustomFormDesigner.DoMoveSizeControl;
var
  i: Integer;
begin
  if Assigned(FOnMoveSizeControl) then
    for i:=0 to Pred(ControlCount) do FOnMoveSizeControl(Self,Controls[i]);
end;

procedure TAdvCustomFormDesigner.DoChange;
begin
  FModified := True;
  if not SynchroLocked and Assigned(FOnChange) then FOnChange(Self);
end;

procedure TAdvCustomFormDesigner.DoSelectControl(AControl: TControl);
var
  OldControl: TControl;
begin
  if AControl is TComponentContainer then
  begin
    OldControl:=AControl;
    if Assigned(TComponentContainer(AControl).Component) then
    try
      AControl:=TControl(TComponentContainer(AControl).Component);
    except
      AControl:=OldControl;
    end;
  end;
  if Assigned(FOnSelectControl) then FOnSelectControl(Self,AControl);
end;

procedure TAdvCustomFormDesigner.DoSelectionChange;
begin
  if (FUpdatingSelection = 0) and not SynchroLocked and Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end;

procedure TAdvCustomFormDesigner.DoAddControl(AControl: TControl);
begin
  if Assigned(FOnAddControl) then FOnAddControl(Self,AControl);
end;

procedure TAdvCustomFormDesigner.DoDeleteControl(AControl: TControl);
begin
  if Assigned(FOnDeleteControl) then FOnDeleteControl(Self,AControl);
end;

function TAdvCustomFormDesigner.GetEditBehaviour(AControl: TControl): TEditBehaviour;
var
  AComponent: TComponent;
begin
  Result:=ebDefault;
  if Assigned(AControl) then
  begin
    if AControl is TComponentContainer then
      AComponent:=TComponentContainer(AControl).Component
    else AComponent:=AControl;
    if Assigned(AComponent) and Assigned(FOnEditBehaviour) then
      FOnEditBehaviour(Self,AComponent,Result);
  end;
end;

function Designing: Boolean;
begin
  Result := (Designers <> nil) and (Designers.Count > 0);
end;

procedure TAdvCustomFormDesigner.DoControlDblClick(AControl: TControl);
var
  AEditor: TIDEComponentEditor;
  AComp: TComponent;
begin
  if AControl is TComponentContainer then
    AComp := TComponentContainer(AControl).Component
  else
    AComp := AControl;

  AEditor := GetIDEComponentEditor(AComp);
  if (AEditor <> nil) and AEditor.HasEditor then
  begin
    AEditor.Edit;
  end;

  if Assigned(FOnControlDblClick) then
    FOnControlDblClick(Self, AControl);
end;

procedure TAdvCustomFormDesigner.BringControlsToFront;
var
  i: integer;
begin
  for i := Pred(ControlCount) downto 0 do
    if not (Controls[i] is TComponentContainer) then
      Controls[i].BringToFront;

  {keep component containers in front}
  if Assigned(ParentForm) then
    for i := 0 to ParentForm.ComponentCount - 1 do
      if (ParentForm.Components[i] is TComponentContainer) then
        TComponentContainer(ParentForm.Components[i]).BringToFront;
  Update;
end;

procedure TAdvCustomFormDesigner.BuildContextItems(AComp: TComponent; APopup: TPopupMenu);
var
  AEditor: TIDEComponentEditor;
  AItem: TMenuItem;
  c: integer;
begin
  AEditor := GetIDEComponentEditor(AComp);
  if AEditor <> nil then
  begin
    for c := 0 to AEditor.GetVerbCount - 1 do
    begin
      AItem := TMenuItem.Create(AEditor);
      AItem.OnClick := ContextPopupItemClick;
      AItem.Caption := AEditor.GetVerb(c);
      FPopupItems.Add(AItem);
      APopup.Items.Insert(c, AItem);
    end;
  end;
end;

procedure TAdvCustomFormDesigner.ContextPopupItemClick(Sender: TObject);
var
  AItem: TMenuItem;
begin
  if Sender is TMenuItem then
  begin
    AItem := TMenuItem(Sender);
    if AItem.Owner is TIDEComponentEditor then
      TIDEComponentEditor(AItem.Owner).ExecuteVerb(AItem.MenuIndex);
  end;
end;

procedure TAdvCustomFormDesigner.SendControlsToBack;
var
  i: integer;
begin
  for i := Pred(ControlCount) downto 0 do
    if not (Controls[i] is TComponentContainer) then
      Controls[i].SendToBack;
  Update;
end;

procedure TAdvCustomFormDesigner.AlignControlsToGrid;
var
  i: integer;
begin
  for i := 0 to ControlCount - 1 do
    if not IsLocked(Controls[i]) then
      AlignToGrid(Controls[i]);
end;

procedure TAdvCustomFormDesigner.DoBeforePlaceComponent(AComponent: TComponent);
begin
end;

procedure TAdvCustomFormDesigner.DoPlaceComponent(AComponent: TComponent);
begin
  if Assigned(FOnPlaceComponent) then
    FOnPlaceComponent(Self, AComponent);
end;

procedure TAdvCustomFormDesigner.RemoveSelectedControls;
var
  ACompList: TObjectList;
begin
  ACompList := TObjectList.Create(true);
  try
    while ControlCount > 0 do
    begin
      if Controls[0] is TComponentContainer then
        ACompList.Add(TComponentContainer(Controls[0]).Component);
      Controls[0].Free;
    end;

    {Destroy the components}
    ACompList.Clear;
  finally
    ACompList.Free;
  end;
  DoSelectionChange;
end;

procedure TAdvCustomFormDesigner.ContainersToDesignInfo;
var
  CC: TComponentContainer;
  c: integer;
  DInfo: Longint;
begin
  if ParentForm <> nil then
    for c := 0 to ParentForm.ComponentCount - 1 do
      if ParentForm.Components[c] is TComponentContainer then
      begin
        CC := TComponentContainer(ParentForm.Components[c]);
        LongRec(DInfo).Lo := CC.Left;
        LongRec(DInfo).Hi := CC.Top;
        if Assigned(CC.Component) then
          CC.Component.DesignInfo := DInfo;
      end;
end;

procedure TAdvCustomFormDesigner.DesignInfoToContainers;
var
  CC: TComponentContainer;
  c: integer;
begin
  if ParentForm <> nil then
    for c := 0 to ParentForm.ComponentCount - 1 do
      if ParentForm.Components[c] is TComponentContainer then
      begin
        CC := TComponentContainer(ParentForm.Components[c]);
        if Assigned(CC.Component) then
        begin
          CC.Left := LongRec(CC.Component.DesignInfo).Lo;
          CC.Top := LongRec(CC.Component.DesignInfo).Hi;
        end;
      end;
end;

{ TIDEComponentEditor }

procedure TIDEComponentEditor.Edit;
begin
end;

procedure TIDEComponentEditor.ExecuteVerb(Index: Integer);
begin
end;

function TIDEComponentEditor.GetComponent: TComponent;
begin
  result := FComponent;
end;

function TIDEComponentEditor.GetDesigner: TAdvCustomFormDesigner;
begin
  result := FDesigner;
end;

function TIDEComponentEditor.GetVerb(Index: Integer): string;
begin
  result := '';
end;

function TIDEComponentEditor.GetVerbCount: Integer;
begin
  result := 0;
end;

function TIDEComponentEditor.HasEditor: boolean;
begin
  result := false;
end;

initialization
  _Designers := TList.Create;
  _IDEEditorList := TIDECompEditorList.Create(TIDECompEditorItem);
finalization
  _IDEEditorList.Free;
  _IDEEditorList := nil;
  _Designers.Free;
  _Designers := nil;
end.

