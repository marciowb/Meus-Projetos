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

unit InspectorControls;

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}
                                                              
interface

uses SysUtils, Classes, TypInfo, Windows, Messages, Controls, StdCtrls,
  Dialogs, Graphics, Forms, Mask;
                                     
type
  TAdvCustomInspector = class;

  /// Summary:
  ///   TButtonType enumerates possible types of button to be displayed at the right of the property editor edit box, in the
  ///   inspector control.
  TButtonType = (
    btNone,       /// No button is displayed in the property editor.
    btDropDown,   /// A drop down button is displayed, the property editor behaves as a combo box. 
    btUpDown,     /// A up/down button is displayed, the property editor behaves as an spin edit. 
    btDialog      /// A ellipsis button is displayed, mostly used to display a custom property editor 
                  /// dialog when end-user clicks the button.
  );

  /// Summary:
  ///   TInplaceEditorType contains the type of control used to edit the selected property in the inspector control.  
  TInplaceEditorType = (
    ieNone,       /// No editor will be used.
    ieEdit,       /// A regular edit control will be used to edit the property.
    ieCheckBox    /// A check box will be used to edit the property.
  );

  /// Summary:
  ///   Indicates the state of the current property with regarding to its subproperties visibility. 
  /// Description:
  ///   If the property has subproperties, then they can be displayed (expanded) or hidden (collapsed). 
  //    The state is represented by a small glyph at the left of property name.
  TExpandState = (
    esNone,        /// The property doesn't have subproperties, no glyph is displayed.
    esExpand,      /// The subproperties are expanded, a minus (-) sign is displayed as a glyph, if the end-user clicks it,
                   /// the subproperties will be collapsed.
    esCollapse     /// The subproperties are collapsed, a plus (+) sign is displayed as a glyph, if the end-user clicks it
                   /// the subproperties will be expanded.
  );

  /// Summary:
  ///   A special TListBox descendant that is used as the drop down list for the property editor.
  /// Description:
  ///   TInspectorPopup is a special control that is internally used by the inspector control to display drop down lists
  ///   for the property editor. When the end-user clicks a drop down button of a property editor, a drop down list is displayed,
  ///   that drop down list is a TInspectorPopup control.    
  TInspectorPopup = class(TListBox)
  private
    function Inspector: TAdvCustomInspector;
  protected
    /// Summary:
    ///   This method overrides the default DrawItem method of the TListBox in order to draw the items in the drop down combo.
    procedure DrawItem(TheIndex: Integer; Rect: TRect; State: TOwnerDrawState); override;
    
    /// Summary:
    ///   WndProc method is used to handle some windows messages like keyboard operations (Esc, Enter) and mouse messages,
    ///   in order to make the drop down popup list to work accordingly.
    procedure WndProc(var Message: TMessage); override;
    
    /// Summary:
    ///   CreateParams is overriden to specify some special flags to the window control.
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;
  
  /// Summary:
  ///   TMaskEdit descendant edit control used as the inplace edit for the inspector control, when the property
  ///   is supposed to be edited with an edit control.  
  TInspectorEdit = class(TMaskEdit)
  private
    FEditing: Boolean;
    function Inspector: TAdvCustomInspector;
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;
  end;

  /// Summary:
  ///   TCheckBox descendant check box control used as the inplace edit for the inspector control, when the property
  ///   is supposed to be edited with a check box control.
  TInspectorCheckBox = class(TCheckBox)
  private
    function Inspector: TAdvCustomInspector;
  protected
    procedure Click; override;
  end;

  /// Summary:
  ///   A special button control used in the inplace property editor.
  /// Description:
  ///   TInspectorButton is a graphic control used in conjunction with the inplace property editor. Depending on the value
  ///   of ButtonType property, it will be displayed in a different way. The inspector button is displayed at the right
  ///   of the inplace editor.
  TInspectorButton = class(TCustomControl)
  private
    FDown: Boolean;
    FButtonType: TButtonType;
    FDropDown: TBitmap;
    FUpDown: TBitmap;
    FDialog: TBitmap;
    procedure SetDown(const Value: Boolean);
    procedure SetButtonType(const Value: TButtonType);
    function Inspector: TAdvCustomInspector;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    /// Summary:
    ///   Indicates if the button is pressed or not.
    property Down: Boolean read FDown write SetDown;
    
    /// Summary:
    ///   Specifies the type of the inspector button. The appearance of the button control is defined by this property. 
    property ButtonType: TButtonType read FButtonType write SetButtonType;
  end;

  /// Summary:
  ///   Used internally by the inspector control to know what kind of drag operation is being performed.
  TDragKind = (
    dkNone,      /// No drag operation is being performed.
    dkItem,      /// The property item (name) is being dragged.
    dkSplitter   /// The splitter is being dragged.
  );
              
  /// Summary:
  ///   Used internally by the inspector control to know what kind of action should be performed/simulated in the property editor.
  TItemAction = (
    iaDoubleClick,   /// A double click action should be performed.
    iaButtonClick    /// A button click action should be performed.
  );

  /// Summary:
  ///   Enumerates types of appearance for the inspector control.
  TPaintStyle = (
    psClassic,   /// Classic appearance. 
    psTree,      /// Tree-like appearance. 
    psTMS        /// Modern TMS appearance.
  );

  /// Summary:
  ///   Event used to validate a key press while editing a property in the inspector.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of property being edited.
  ///   Key - The pressed key. You can change this value.
  /// Return Value:
  ///   Return true if the pressed key is a valid char and can be accepted by the inplace property editor.  
  ///   Return false if you want the key to be rejected by the inplace editor. 
  TValidateCharEvent = function(Sender: TObject; TheIndex: Integer; var Key: Char): Boolean of object;
  
  /// Summary:
  ///   Event type used to provide an opportunity to the programmer to change a string value for a specified property.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of property being edited.
  ///   Value - The current string value, you can change it if you need to.
  TGetStringEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: string) of object;
  
  /// Summary:
  ///   Event type used to pass a string value that has been set for a specified property.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Value - The string value that has been set for the property.
  TSetStringEvent = procedure(Sender: TObject; TheIndex: Integer; const Value: string) of object;
  
  /// Summary:
  ///   Event type used to provide an opportunity for the programmer to specify the button type of the 
  ///   specified property's inplace editor.
  /// Parameters:                                                         
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Value - Set this parameter to specify the button type of the editor.
  TButtonTypeEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TButtonType) of object;
  
  /// Summary:
  ///   Event type used to provide an opportunity for the programmer to specify the type of inplace editor
  ///   to be used for the specified property
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Value - Set this parameter to specify the type of inplace editor.
  TInplaceEditorTypeEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TInplaceEditorType) of object;
  
  /// Summary:
  ///   Event type used to provide an opportunity for the programmer to change a boolean value associated with the specified property.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Value - The current boolean value, you can change it if you need to.
  TBooleanEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: Boolean) of object;
  
  /// Summary:
  ///   Event type used to provide an opportunity for the programmer to specify the expand state for the specified property 
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Value - the current expand state, you can change it if you need to.
  TExpandStateEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TExpandState) of object;
  
  /// Summary:
  ///   Event type used to provide an opportunity for the programmer to change an integer value associated with the specified property.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Value - The current integer value, you can change it if you need to.
  TIntegerEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: Integer) of object;
                                                    
  /// Summary:
  ///   Event type used to provide an opportunity for the programmer to change a pointer value associated with the specified property.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Value - The current pointer value, you can change it if you need to.
  TPointerEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: Pointer) of object;
  
  /// Summary:
  ///   Event type used to provide an opportunity for the programmer to change a color value associated with the specified property.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Value - The current color value, you can change it if you need to.
  TColorEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TColor) of object;
  
  /// Summary:
  ///   Event type used to provide an opportunity for the programmer to change properties 
  ///   of a font associated with the specified property.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   TheFont - The font object associated with the property, you can change its properties.
  TFontEvent = procedure(Sender: TObject; TheIndex: Integer; const TheFont: TFont) of object;
  
  /// Summary:
  ///   Event type used by the programmer to provide a list of string values to the inspector, as requested.   
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   Strings - The TStrings object to be filled by the event handler.
  TStringsEvent = procedure(Sender: TObject; TheIndex: Integer; const Strings: TStrings) of object;
  
  /// Summary:
  ///   This event is fired when the inspector needs to execute the custom property editor of the specified property.
  ///   This usually happens when the end-user double clicks the inplace editor, or clicks the dialog button of the editor.
  ///   For the custom editor to be called for that specific property, you must inform the the inspector that the property
  ///   has a custom external editor, using TAdvCustomInspector.OnGetEnableExternalEditor event.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property for which the editor must be called.
  /// Return Value:
  ///   Return true if any changes were performed by the editor, so that the inspector updates itself.
  ///   Return false if the editor was canceled by the end-user.
  TCallEditorEvent = function(Sender: TObject; TheIndex: Integer): Boolean of object;
  
  /// Summary:
  ///   This event is fired when the inspector needs to execute the custom property editor of the specified property.
  ///   This usually happens when the end-user double clicks the inplace editor, or clicks the dialog button of the editor.
  ///   For the custom editor to be called for that specific property, you must inform the the inspector that the property
  ///   has a custom external editor, using TAdvCustomInspector.OnGetEnableExternalEditor event.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property for which the editor must be called.
  ///   EnabledDefault - If this parameter is set to true, the default component editor for the property will be called.
  ///                    Set EnableDefault parameter to false if you have already displayed your custom editor and don't want
  ///                    any other existing editor to appear.
  /// Return Value:
  ///   Return true if any changes were performed by the editor, so that the inspector updates itself.
  ///   Return false if the editor was canceled by the end-user.
  TCallEditorEnableEvent = function(Sender: TObject; TheIndex: Integer; var EnableDefault: Boolean): Boolean of object;
  
  /// Summary:
  ///   This event type is used for general purpose notifications about a specific property.     
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property for which the event was fired.
  TIndexNotifyEvent = procedure(Sender: TObject; TheIndex: Integer) of object;
                                                                                                                  
  /// Summary:
  ///   Event for custom drawing operations in the inspector control.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property associated with the painting operation.
  ///   TheCanvas - Canvas object used to perform drawing.
  ///   TheRect - Rect position where the drawing operation should be performed.
  TIndexDrawEvent = procedure(Sender: TObject; TheIndex: Integer; TheCanvas: TCanvas; TheRect: TRect) of object;
  
  /// Summary:
  ///   This event is used to enable or disable the property default action to be performed. The propert default action
  ///   is performed when the end-user doubles click the property editor or when Ctrl+Enter is pressed. 
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property.
  ///   EnableDefault - This this parameter to tru eto allow default (double click) operation to be performed, false otherwise.
  TIndexEnableEvent = procedure(Sender: TObject; TheIndex: Integer; var EnableDefault: Boolean) of object;
  
  /// Summary:
  ///   This event is fired when the value of a property changes.
  /// Parameters:
  ///   Sender - Object that fired the event. Usually the inspector control.
  ///   TheIndex - Index of specified property for which the value changed.
  ///   Editing - True is the property was being edited (inplace editor was active). False otherwise.
  ///   Value - The new value of the property in string format.
  TChangeValueEvent = procedure(Sender: TObject; TheIndex: Integer; Editing: Boolean; const Value: string) of object;
  

  /// Summary:
  ///   Abstract ancestor class for inspector controls.
  /// Description:
  ///   TAdvCustomInspector is the ancestor class for visual inspector controls. This component is an abstract one, in the sense
  ///   that it doesn't implement effective property listing, reading or writing. Its implementation is only at visual/control 
  ///   level.
  /// See Also:
  ///   TCommonInspector
  TAdvCustomInspector = class(TCustomListBox)
  private
    FCheckBox: TInspectorCheckBox;
    FEdit: TInspectorEdit;
    FButton: TInspectorButton;
    FIndex: Integer;
    FFullUpdate: Boolean;
    FOldScrollPos: Integer;
    FClicked: Boolean;
    FOldWidth: Integer;
    FOldHeight: Integer;
    FOldSplitter: Integer;
    FLockCounter: Integer;
    FSplitter: Integer;
    FCheckBoxes: Boolean;
    FPaintStyle: TPaintStyle;
    FDragSplitter: Integer;
    FDragKind: TDragKind;
    FPopup: TInspectorPopup;
    FExpand: TBitmap;
    FCollapse: TBitmap;
    FItemCount: Integer;
    FOnSelect: TIndexNotifyEvent;
    FOnUpdate: TNotifyEvent;
    FOnValidateChar: TValidateCharEvent;
    FOnChangeValue: TChangeValueEvent;
    FOnDrawName: TIndexDrawEvent;
    FOnDrawValue: TIndexDrawEvent;
    FOnGetName: TGetStringEvent;
    FOnGetValue: TGetStringEvent;
    FOnGetNextValue: TGetStringEvent;
    FOnSetValue: TSetStringEvent;
    FOnGetButtonType: TButtonTypeEvent;
    FOnGetInplaceEditorType: TInplaceEditorTypeEvent;
    FOnGetMaxLength: TIntegerEvent;
    FOnGetEditMask: TGetStringEvent;
    FOnGetEnableExternalEditor: TBooleanEvent;
    FOnGetReadOnly: TBooleanEvent;
    FOnGetExpandState: TExpandStateEvent;
    FOnGetLevel: TIntegerEvent;
    FOnGetData: TPointerEvent;
    FOnGetValuesList: TStringsEvent;
    FOnGetSortValuesList: TBooleanEvent;
    FOnGetSelectedValue: TGetStringEvent;
    FOnGetAutoApply: TBooleanEvent;
    FOnGetNameFont: TFontEvent;
    FOnGetNameColor: TColorEvent;
    FOnGetValueFont: TFontEvent;
    FOnGetValueColor: TColorEvent;
    FOnCallEditor: TCallEditorEvent;
    FOnExpand: TIndexNotifyEvent;
    FOnCollapse: TIndexNotifyEvent;
    FOnSelectItem: TIndexNotifyEvent;
    FOnDeselectItem: TIndexNotifyEvent;
    FOnValueDoubleClick: TIndexEnableEvent;
    FOnDragValue: TIntegerEvent;
    function GetLocked: Boolean;
    function GetItemCount: Integer;
    procedure SetItemCount(const Value: Integer);
    procedure SetSplitter(const Value: Integer);
    procedure SetCheckBoxes(const Value: Boolean);
    procedure SetPaintStyle(const Value: TPaintStyle);
    procedure DrawDragSplitter;
    procedure SetMouseItem(Pos: LParam);
    function Action(A: TItemAction): Boolean;
    procedure HidePopup;
    function IsFocused: Boolean;
    function SpecialClick(L: LParam): Boolean;
    procedure UpdateControls;
    procedure SetIndex(const Value: Integer);
    procedure FocusControl;
    {$IFDEF GOITRIAL}
    procedure TrialMessage;
    {$ENDIF}
  protected
    procedure WndProc(var Message: TMessage); override;
    
    /// Summary:
    ///   Returns the index of the property that should be selected by default by the inspector.
    /// Description:
    ///   When the inspector must updates itself with a new set of properties, an initial property must be selected.
    ///   The inspector calls GetDefaultIndex method to retrieve the index of the property that should be selected by default.
    /// Return Value:
    ///   The index of property that shoud be selected by default.    
    function GetDefaultIndex: Integer; virtual;
    
    /// Summary:
    ///   Sets an internal flag requiring full control repainting when the inspector is updated.
    /// Description:
    ///   When the inspector is required to update itself, part of the control will be invalidated and repainted.
    ///   The part to be repainted might be only the currently selected property, or the whole control.
    ///   Calling FullUpdateNeeded method will required the inspector to repaint the whole control when an update is required.
    procedure FullUpdateNeeded;
    
    /// Summary:
    ///   Returns the width of the popup list box to be displayed as a drop down list when a property is being edited.
    /// Parameters:
    ///   ListBox - The list box control which will be displayed as the popup combo list.
    ///   TheIndex - The index of the property being edited.
    /// Return Value:
    ///   The width of the listbox control, in pixels.
    function GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer; virtual;
    
    /// Summary:
    ///   Performs drawing of an item of the list box to be displayed as a drop down list when a property is being edited.
    /// Parameters:
    ///   ListBox - The list box control which will be displayed as the popup combo list.
    ///   ListItemIndex - The index of the list box item to be drawn.
    ///   R - The rectangle that specifies the list itemboundaries
    ///   TheIndex - The index of the property being edited.
    procedure DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer); virtual;
    
    /// Summary:
    ///   Sets the text of the inplace property editor control. This puts the property in editing mode and 
    ///   the text set is selected in the control.
    /// Parameters:
    ///   AText - The text to be set in the editor.
    procedure SetEditedText(const AText: string); virtual;
    
    /// Summary:
    ///   Indicates if the specified key pressed is valid for current editing of selected property. 
    /// Parameters:
    ///   TheIndex - The index of the property being edited.
    ///   Key - The key pressed in the editor that should be validated. The method might change this value if needed.
    /// Return Value:
    ///   Returns true if the key can be accepted in the editor, false otherwise.    
    function ValidateChar(TheIndex: Integer; var Key: Char): Boolean; virtual;
    
    /// Summary:
    ///   This method is called by the inspector when a property value changes.
    /// Parameters:
    ///   TheIndex - Index of the property being edited.
    ///   Editing - Indicates if the current property is being edited (inplace editor control is visible and active).
    ///   AText - The new string value of the property typed in the editor.
    procedure ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string); virtual;
    
    /// Summary:
    ///   Selects a specified property in the inspector.
    /// Parameters:
    ///   TheIndex - Index of the property to be selected.
    ///   NeedUpdate - Indicates if current changes must be applied and inspector must be refreshed, even if the 
    ///                selected property didn't change.
    procedure SetSelectionPos(TheIndex: Integer; NeedUpdate: Boolean);
    
    /// Summary:
    ///   Draws the property name in inspector control, which correspondes to the left part of the inspector.
    /// Parameters:
    ///   TheCanvas - Canvas object used to perform the drawing operation.
    ///   TheIndex - Index of the property to be drawn.
    ///   R - The rectangle in which the property value will be drawn. This value corresponds to the whole property
    ///       area, including name, value, border. The Splitter property should be used to know at which position
    ///       the name and value areas are separated.
    procedure DrawPropertyName(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;

    /// Summary:
    ///   Draws the property value in inspector control, which correspondes to the right part of the inspector.
    /// Parameters:
    ///   TheCanvas - Canvas object used to perform the drawing operation.
    ///   TheIndex - Index of the property to be drawn.
    ///   R - The rectangle in which the property value will be drawn. This value corresponds to the whole property
    ///       area, including name, value, border. The Splitter property should be used to know at which position
    ///       the name and value areas are separated.
    procedure DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;
    
    /// Summary:
    ///   Draws the vertical separator line which divides the name (left) and value (right) sections of a property.
    /// Parameters:
    ///   TheCanvas - Canvas object used to perform the drawing operation.
    ///   TheIndex - Index of the property to be drawn.
    ///   R - The rectangle in which the property will be drawn. This value corresponds to the whole property
    ///       area, including name, value, border. The Splitter property should be used to know at which position
    ///       the name and value areas are separated.
    procedure DrawVerticalSeparator(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;

    /// Summary:
    ///   Draws the horizontal separator line which separates one property from another.
    /// Parameters:             
    ///   TheCanvas - Canvas object used to perform the drawing operation.
    ///   TheIndex - Index of the property to be drawn.
    ///   R - The rectangle in which the property will be drawn. This value corresponds to the whole property
    ///       area, including name, value, border. The Splitter property should be used to know at which position
    ///       the name and value areas are separated.
    procedure DrawHorizontalSeparator(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;
    
    /// Summary:
    ///   Draws the borders of the property area.
    /// Parameters:             
    ///   TheCanvas - Canvas object used to perform the drawing operation.
    ///   TheIndex - Index of the property to be drawn.
    ///   R - The rectangle in which the property will be drawn. This value corresponds to the whole property
    ///       area, including name, value, border. The Splitter property should be used to know at which position
    ///       the name and value areas are separated.
    procedure DrawBorders(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;
    
    /// Summary:
    ///   Retrieves the name of the specified property. Descendants can override this method to effectively retrieve
    ///   the name of a property.
    /// Parameters:
    ///   TheIndex - The index of the property for which the name will be retrieved.
    /// Return Value:
    ///   The property name. 
    function GetName(TheIndex: Integer): string; virtual;

    /// Summary:
    ///   Retrieves the value of the specified property. Descendants can override this method to effectively retrieve
    ///   the value of a property.
    /// Parameters:
    ///   TheIndex - The index of the property for which the value will be retrieved.
    /// Return Value:
    ///   The property value.
    function GetValue(TheIndex: Integer): string; virtual;

    /// Summary:
    ///   Retrieves the next valid value for the specified property.
    /// Description:
    ///   When a property is being edited, the end-user might double click the editor control. If no default editor is 
    ///   defined, then the inspector will change the property value for the next valid value. For example, suppose you have
    ///   an enumerated property in which valid values are pvNone, pv 
    function GetNextValue(TheIndex: Integer): string; virtual;

    /// Summary:
    ///   Sets the value of the specified property. 
    /// Description:
    ///   This method is called by the inspector when and editing operation is performed. Descendants can override
    ///   this method to effectively sets the value of a real property.
    /// Parameters:
    ///   TheIndex - The index of the property for which the value will be set.
    ///   Value - The new value of the property.
    procedure SetValue(TheIndex: Integer; const Value: string); virtual;
    
    /// Summary:
    ///   This method is called by the inspector when the end-user is draging a property value in the editor. This happens
    ///   when the button in the editor is a up/down button, and user clicks the button and drags the mouse up/down.
    /// Parameters:
    ///   TheIndex - Index of property being edited.
    ///   Offset - The offset value corresponding to the mouse position (can be negative or positive).
    procedure DragValue(TheIndex,Offset: Integer); virtual;
    
    /// Summary:
    ///   Retrieves the type of the button to be used in a property editor.
    /// Parameters:
    ///   TheIndex - Index of the property for which the button type will be retrieved.
    /// Return Value:
    ///   The button type for the property editor.
    function GetButtonType(TheIndex: Integer): TButtonType; virtual;
    
    /// Summary:
    ///   Retrieves the type of the inplace editor to be used for editing a property.
    /// Parameters:
    ///   TheIndex - Index of the property for which the inplace editor will be used.
    /// Return Value:
    ///   The type of inplace editor for the property.
    function GetInplaceEditorType(TheIndex: Integer): TInplaceEditorType; virtual;
    
    /// Summary:
    ///   Retrieves the maximum value length for the text being typed in a property editor.
    /// Parameters:
    ///   TheIndex - Index of the property being edited.
    /// Return Value:
    ///   The maximum allowed length of the propery value. 
    function GetMaxLength(TheIndex: Integer): Integer; virtual;
    
    /// Summary:
    ///   Retrieves the edit mask to be used for a inplace property editor.
    /// Parameters:
    ///   TheIndex - Index of the property being edited.
    /// Return Value:
    ///   The edit mask to be used in the property editor of the specified property.
    function GetEditMask(TheIndex: Integer): string; virtual;
    
    /// Summary:
    ///   Indicates if the specified property has a custom external property editor. If true, then when the property editor
    ///   is double clicked, the CallEditor method is called, as well the OnCallEditor event, as an opportunity to launch
    ///   the custom editor.
    /// Parameters:
    ///   TheIndex - Index of the property that will be checked to have an external editor or not.
    /// Return Value:
    ///   True if the property has an external editor, false otherwise.
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; virtual;
    
    /// Summary:
    ///   Indicates the if specified property is read-only.
    /// Parameters:
    ///   TheIndex - Index of the specified property.
    /// Return Value:
    ///   True if the property is read-only, false otherwise.
    function GetReadOnly(TheIndex: Integer): Boolean; virtual;

    /// Summary:
    ///   Returns the current expand state (subproperties are collapsed or expanded) of the specified property.
    /// Parameters:
    ///   TheIndex - Index of the specified property.
    /// Return Value:
    ///   The expand state of the specified property. 
    function GetExpandState(TheIndex: Integer): TExpandState; virtual;
    
    /// Summary:
    ///   Returns the level of the specified property. Properties can have subproperties, and each subproperty might have
    ///   its subproperties as well. So, the level indicates the position of the subproperty in this chain. 
    /// Parameters:
    ///   TheIndex - index of the specified property.
    /// Return Value:
    ///   The level of the property. First (top) level is 0, second level is 1, and so on. 
    function GetLevel(TheIndex: Integer): Integer; virtual;
    
    /// Summary:
    ///   Returns custom general purpose data for the specified property. The inspector doesn't use this information, it's only
    ///   a way to store custom information related to a property.
    /// Parameters:
    ///   TheIndex - Index of the property for which custom data will be retrieved.
    /// Return Value:
    ///   The custom data in pointer format.
    function GetData(TheIndex: Integer): Pointer; virtual;
    
    /// Summary:
    ///   Retrieves a list of valid property values to be displayed in the drop down combo box in the property editor.
    ///   For example, a boolean property will receive "false" and "true" values, a color property might receive names
    ///   of valid colors, and so on.
    /// Parameters:
    ///   TheIndex - Index of the property being edited.
    ///   Strings - TStrings object that will should filled by GetValuesList with all the valid property values.
    /// See Also:
    ///   GetSortValuesList
    procedure GetValuesList(TheIndex: Integer; const Strings: TStrings); virtual;
    
    /// Summary:
    ///   Indicates if the items in the popup list displayed by the property editor are sorted or not. For example, for
    ///   a color property editor, you might not way to have the color names to be sorted. For a field name property editor,
    ///   it's nice to have the field names sorted.
    /// Parameters:
    ///   TheIndex - Index of the specified property.
    /// Return Value:
    ///   True if the items in the popup list should be sorted. False otherwise.
    /// See Also:
    ///   GetValuesList
    function GetSortValuesList(TheIndex: Integer): Boolean; virtual;
    
    /// Summary:
    ///   Calls GetValue method.
    function GetSelectedValue(TheIndex: Integer): string; virtual;
    
    /// Summary:
    ///   Indicates if the value of the selected property will be automatically applied. 
    /// Description:
    ///   When a property is being edited
    ///   and the selected property changes, the property the was being edited is updated with the content of property editor,
    ///   if the property should be auto applied. Otherwise, the editing value is discarded and the property value is not changed.
    /// Parameters:
    ///   TheIndex - Index of the specified property.
    /// Return Value:
    ///   True if the property must be have its value auto applied, false otherwise.
    function GetAutoApply(TheIndex: Integer): Boolean; virtual;
    
    /// Summary:
    ///   Returns the font to be used when drawing the property name in the inspector.
    /// Parameters:
    ///   TheIndex - Index of the property being displayed.
    ///   TheFont - Font object that will be updated by the method.
    procedure GetNameFont(TheIndex: Integer; TheFont: TFont); virtual;
    
    /// Summary:
    ///   Returns the background color to be used when drawing the property name in the inspector.
    /// Parameters:
    ///   TheIndex - Index of the property being displayed.
    /// Return Value:
    ///   Background color to be used.
    function GetNameColor(TheIndex: Integer): TColor; virtual;

    /// Summary:
    ///   Returns the font to be used when drawing the property value in the inspector.
    /// Parameters:
    ///   TheIndex - Index of the property being displayed.
    ///   TheFont - Font object that will be updated by the method.
    procedure GetValueFont(TheIndex: Integer; TheFont: TFont); virtual;

    /// Summary:
    ///   Returns the background color to be used when drawing the property value in the inspector.
    /// Parameters:
    ///   TheIndex - Index of the property being displayed.
    /// Return Value:
    ///   Background color to be used.
    function GetValueColor(TheIndex: Integer): TColor; virtual;
    
    /// Summary:
    ///   Returns the indentation width to be used in the inspector when displayed subproperties at different levels.
    /// Return Value:
    ///   The indentation width, in pixels.
    /// See Also:
    ///   GetLevel
    function GetIndent: Integer; virtual;
    
    /// Summary:
    ///   Executes the custom external editor for the specified property. The editor is called when the end-user double clicks
    ///   the property editor, or clicks the ellipsis button, and the property has an external editor enabled.
    /// Parameters:
    ///   TheIndex - Index of the property for which the editor must be executed.
    /// Return Value:
    ///   True if the editor changed the property value and the inspector must be updated. False if the editor was canceled
    ///   and nothing changed.
    /// See Also:
    ///   GetEnableExternalEditor   
    function CallEditor(TheIndex: Integer): Boolean; virtual;
    
    /// Summary:
    ///   Expands the subproperties of the specified property.
    /// Parameters:
    ///   TheIndex - Index of the property to be expanded.
    procedure Expand(TheIndex: Integer); virtual;

    /// Summary:
    ///   Collapses the subproperties of the specified property.
    /// Parameters:
    ///   TheIndex - Index of the property to be expanded.
    procedure Collapse(TheIndex: Integer); virtual;
    
    /// Summary:
    ///   Called by the inspector to indicate that a property has been selected. It fires the event OnSelectItem.
    /// Parameters:                                                                                          
    ///   TheIndex - Index of the selected property. 
    procedure SelectItem(TheIndex: Integer); virtual;

    /// Summary:
    ///   Called by the inspector to indicate that a property has been deselected. It fires the event OnDeselectItem.
    /// Parameters:
    ///   TheIndex - Index of the deselected property. 
    procedure DeselectItem(TheIndex: Integer); virtual;
    
    /// Summary:
    ///   Contains the number of items being displayed in the inspector.
    property ItemCount: Integer read GetItemCount write SetItemCount default 0;

    /// Summary:
    ///   Contains the position, in pixels of the internal vertical splitter used to separate property name and value. 
    property Splitter: Integer read FSplitter write SetSplitter default 100;
    
    /// Summary:
    ///   If true, checkboxes are used as property editors for boolean properties. If false, then edit controls are used.
    property CheckBoxes: Boolean read FCheckBoxes write SetCheckBoxes default False;
    
    /// Summary:
    ///   OnSelect event is fired when a new property is selected in the inspector.
    property OnSelect: TIndexNotifyEvent read FOnSelect write FOnSelect;
    
    /// Summary:
    ///   OnUpdate event is fired after the inspector updates itself due to a call to Update method.
    property OnUpdate: TNotifyEvent read FOnUpdate write FOnUpdate;
    
    /// Summary:
    ///   Use OnValidateChar event to allow or forbid specific keys to be pressed in a property editor.
    property OnValidateChar: TValidateCharEvent read FOnValidateChar write FOnValidateChar;
    
    /// Summary:
    ///   OnChangeValue event is fired whenever a property value is changed by the inspector.
    property OnChangeValue: TChangeValueEvent read FOnChangeValue write FOnChangeValue;
    
    /// Summary:
    ///   Use OnDrawName event to perform custom drawing of a property name in the inspector.
    property OnDrawName: TIndexDrawEvent read FOnDrawName write FOnDrawName;
                                                              
    /// Summary:
    ///   Use OnDrawValue event to perform custom drawing of a property value in the inspector.
    property OnDrawValue: TIndexDrawEvent read FOnDrawValue write FOnDrawValue;
    
    /// Summary:
    ///   Use OnGetName event to provide the name of the specified property.
    /// See Also:
    ///   GetName
    property OnGetName: TGetStringEvent read FOnGetName write FOnGetName;

    /// Summary:
    ///   Use OnGetValue event to provide the value of a specified property. 
    /// See Also:
    ///   GetValue
    property OnGetValue: TGetStringEvent read FOnGetValue write FOnGetValue;
    
    /// Summary:
    ///   Use OnGetNextValue event to provide the next value of a specified property. 
    /// See Also:
    ///   GetNextValue
    property OnGetNextValue: TGetStringEvent read FOnGetNextValue write FOnGetNextValue;
    
    /// Summary:
    ///   OnSetValue is fired as an opportunity for the programmer to set a property value in a custom way.
    /// See Also:
    ///   SetValue
    property OnSetValue: TSetStringEvent read FOnSetValue write FOnSetValue;
    
    /// Summary:
    ///   Use OnGetButtonType event to provide the type of the button to be used in a property editor.
    /// See Also:
    ///   GetButtonType
    property OnGetButtonType: TButtonTypeEvent read FOnGetButtonType write FOnGetButtonType;
    
    /// Summary:
    ///   Use this event to provide the type of inplace editor to be used as the property editor.
    /// See Also:
    ///   GetInplaceEditorType
    property OnGetInplaceEditorType: TInplaceEditorTypeEvent read FOnGetInplaceEditorType write FOnGetInplaceEditorType;
    
    /// Summary:
    ///   Use this event to provide the maximum text length for a property value when editing the property in the inspector.
    /// See Also:
    ///   GetMaxLength
    property OnGetMaxLength: TIntegerEvent read FOnGetMaxLength write FOnGetMaxLength;
    
    /// Summary:
    ///   Use this event to provide the edit mask for a property editor.
    /// See Also:
    ///   GetEditMask
    property OnGetEditMask: TGetStringEvent read FOnGetEditMask write FOnGetEditMask;
    
    /// Summary:
    ///   Use this event to inform the inspector if a specified property has a custom external editor.
    /// See Also:
    ///   GetEnableExternalEditor
    property OnGetEnableExternalEditor: TBooleanEvent read FOnGetEnableExternalEditor write FOnGetEnableExternalEditor;
    
    /// Summary:
    ///   Use this event to inform the inspector if a specified property is read-only or not.
    /// See Also:
    ///   GetReadOnly
    property OnGetReadOnly: TBooleanEvent read FOnGetReadOnly write FOnGetReadOnly;
    
    /// Summary:
    ///   Use this event to provide the inspector with the current expand state (expanded or collapsed) for a specified property.
    /// See Also:
    ///   GetExpandState
    property OnGetExpandState: TExpandStateEvent read FOnGetExpandState write FOnGetExpandState;
    
    /// Summary:
    ///   Use this event to inform the level of a specified property.
    /// See Also:
    ///   GetLevel
    property OnGetLevel: TIntegerEvent read FOnGetLevel write FOnGetLevel;
    
    /// Summary:
    ///   Use this event to inform custom data for a specified property.
    /// See Also:
    ///   GetData
    property OnGetData: TPointerEvent read FOnGetData write FOnGetData;
    
    /// Summary:
    ///   Use this event to provide a list of values to be used as the popup list in the property editor.
    /// See Also:
    ///   GetValuesList; OnGetSortValuesList
    property OnGetValuesList: TStringsEvent read FOnGetValuesList write FOnGetValuesList;
    
    /// Summary:
    ///   Use this event to specify if the items in the editor's popup list will be sorted or not.
    /// See Also:
    ///   GetSortValuesList
    property OnGetSortValuesList: TBooleanEvent read FOnGetSortValuesList write FOnGetSortValuesList;
    
    /// Summary:
    ///   Not used. Use OnGetValue instead.
    property OnGetSelectedValue: TGetStringEvent read FOnGetSelectedValue write FOnGetSelectedValue;
    
    /// Summary:
    ///   Use this event to inform if a specified property must have its value auto applied or not when the focus leaves.
    /// See Also:
    ///   GetAutoApply
    property OnGetAutoApply: TBooleanEvent read FOnGetAutoApply write FOnGetAutoApply;
    
    /// Summary:
    ///   Use this event to provide the font used to display the property name in the inspector.
    /// See Also:
    ///   GetNameFont
    property OnGetNameFont: TFontEvent read FOnGetNameFont write FOnGetNameFont;
    
    /// Summary:
    ///   Use this event to provide the background color of the property name in the inspector.
    /// See Also:
    ///   GetNameColor
    property OnGetNameColor: TColorEvent read FOnGetNameColor write FOnGetNameColor;

    /// Summary:
    ///   Use this event to provide the font used to display the property value in the inspector.
    /// See Also:
    ///   GetValueFont
    property OnGetValueFont: TFontEvent read FOnGetValueFont write FOnGetValueFont;

    /// Summary:
    ///   Use this event to provide the background color of the property value in the inspector.
    /// See Also:
    ///   GetValueColor
    property OnGetValueColor: TColorEvent read FOnGetValueColor write FOnGetValueColor;
    
    /// Summary:
    ///   This event is fired by the inspector when a custom external editor must be executed for a specified property.
    /// See Also:
    ///   CallEditor; OnGetEnableExternalEditor
    property OnCallEditor: TCallEditorEvent read FOnCallEditor write FOnCallEditor;
    
    /// Summary:
    ///   This event is fired when a property has been expanded (subproperties are displayed).
    /// See Also:
    ///   Expand
    property OnExpand: TIndexNotifyEvent read FOnExpand write FOnExpand;

    /// Summary:
    ///   This event is fired when a property has been collapsed (subproperties are hidden).
    /// See Also:
    ///   Collapse
    property OnCollapse: TIndexNotifyEvent read FOnCollapse write FOnCollapse;
    
    /// Summary:
    ///   This event is fired when a property is selected in the inspector.
    property OnSelectItem: TIndexNotifyEvent read FOnSelectItem write FOnSelectItem;

    /// Summary:
    ///   This event is fired when a property is deselected in the inspector.
    property OnDeselectItem: TIndexNotifyEvent read FOnDeselectItem write FOnDeselectItem;
    
    /// Summary:
    ///   This event is fired when the property editor is double clicked in the inspector. You can use this event
    ///   to disable any action to be performed by the inspector when a double click occurs (like calling a default editor for example).
    /// See Also:
    ///   OnGetNextValue; OnCallEditor
    property OnValueDoubleClick: TIndexEnableEvent read FOnValueDoubleClick write FOnValueDoubleClick;
    
    /// Summary:
    ///   This event is fired when the end-user is dragging a property value (clicking an up/down button and dragging the mouse)
    /// See Also:
    ///   DragValue
    property OnDragValue: TIntegerEvent read FOnDragValue write FOnDragValue;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    /// Summary:
    ///   Updates the inspector to reflect the latest changes.
    /// Description:
    ///   Call Update to make the inspector to reflect the latest changes. This method invalidates the inspector control, forcing
    ///   it to repaint itself, and also updates the inplace editors. If the inspector is locked, then no update is performed. 
    /// See Also:
    ///   Lock; Locked
    procedure Update; override;
    
    /// Summary:
    ///   Inspector overrides this method for internal purposes.
    procedure CreateWnd; override;
    
    /// Summary:
    ///   Puts the inspector in locked state.
    /// Description:
    ///   Call Lock to prevent the inspector to visually update itself. For each Lock call, you must call Unlock method.
    /// See Also:
    ///   Update; Unlock; Locked
    procedure Lock; virtual;
    
    /// Summary:
    ///   Removes the inspector from locked state.
    /// Description:
    ///   Call Unlock for each previous call to Lock method you made. This unlocks the inspector.  
    /// See Also:
    ///   Update; Lock; Locked
    procedure Unlock; virtual;
    
    /// Summary:
    ///   Performs the default drawing of the property name in the inspector.
    /// Parameters:
    ///   TheCanvas - Canvas object used to perform the drawing operation.
    ///   TheIndex - Index of the property to be drawn.
    ///   R - The rectangle in which the property name will be drawn. This value corresponds to the whole property
    ///       area, including name, value, border. The Splitter property should be used to know at which position
    ///       the name and value areas are separated.
    /// See Also:
    ///   OnDrawName
    procedure DrawPropertyNameDefault(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);

    /// Summary:
    ///   Performs the default drawing of the property value in the inspector.
    /// Parameters:
    ///   TheCanvas - Canvas object used to perform the drawing operation.
    ///   TheIndex - Index of the property to be drawn.
    ///   R - The rectangle in which the property value will be drawn. This value corresponds to the whole property
    ///       area, including name, value, border. The Splitter property should be used to know at which position
    ///       the name and value areas are separated.
    /// See Also:
    ///   OnDrawValue
    procedure DrawPropertyValueDefault(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);

    /// Summary:
    ///   Updates the property value based on the content of the inplace editor.
    /// See Also:
    ///   IgnoreChanges
    procedure ApplyChanges;
    
    /// Summary:
    ///   Discard the changes made to the inplace editor, reseting the editor content to the current property value.
    /// See Also:
    ///   ApplyChanges
    procedure IgnoreChanges;
    
    /// Summary:
    ///   Provides a reference to the inplace edit control used to edit property values. 
    property InplaceEdit: TInspectorEdit read FEdit;
                                                     
    /// Summary:
    ///   Provides a reference to the inplace checkbox control used to edit boolean property values.
    /// See Also:
    ///   CheckBoxes
    property InplaceCheckBox: TInspectorCheckBox read FCheckBox;
    
    /// Summary:
    ///   Informs if the inspector is in the locked state. When the inspector is locked, no visual updates are performed.
    /// See Also:
    ///   Lock; Unlock; Update
    property Locked: Boolean read GetLocked;
    
    /// Summary:
    ///   Retrieves the name of the property which index is specified by Index. 
    property Names[Index: Integer]: string read GetName;

    /// Summary:
    ///   Retrieves the value of the property which index is specified by Index.
    property Values[Index: Integer]: string read GetValue;
    
    /// Summary:
    ///   Retrieves the button type of the inplace editor used to edit the value of the property specified by Index. 
    property ButtonType[Index: Integer]: TButtonType read GetButtonType;

    /// Summary:
    ///   Retrieves the type of the inplace editor used to edit the value of the property specified by Index. 
    property InplaceEditorType[Index: Integer]: TInplaceEditorType read GetInplaceEditorType;
    
    /// Summary:
    ///   Informs if the property specified by Index has a custom external editor.
    /// See Also:
    ///   OnCallEditor
    property EnableExternalEditor[Index: Integer]: Boolean read GetEnableExternalEditor;
    
    /// Summary:
    ///   Informs the the property specified by Index is read-only or not.
    property ReadOnly[Index: Integer]: Boolean read GetReadOnly;
    
    /// Summary:
    ///   Retrieves the expand state for the property specified by Index.
    property ExpandState[Index: Integer]: TExpandState read GetExpandState;
    
    /// Summary:
    ///   Use Index property to know the index of the currently selected property. To select a different property in the inspector,
    ///   set Index property to the index of the desired property to be selected.
    property Index: Integer read FIndex write SetIndex;
    
    /// Summary:
    ///   Informs if the inspector was clicked at the position of inplace editor. 
    property Clicked: Boolean read FClicked write FClicked;
    
    /// Summary:
    ///   Use PaintStyle property to set the visual appearance of the inspector control.
    property PaintStyle: TPaintStyle read FPaintStyle write SetPaintStyle default psClassic;
  end;

  /// Summary:
  ///   General-purpose inspector control.
  /// Description:
  ///   TCommonInspector a general purpose inspector control. You can use it to implement any kind of inspecting, be it
  ///   object inspector, database inspector, or anything else. It doesn't implement any business logic for retrieving properties,
  ///   set property name, get property value, etc. All must be done by the programmer through several events provided
  ///   by the component.
  TCommonInspector = class(TAdvCustomInspector)
  published
    {$IFNDEF VERSION3}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property ItemCount;
    property CheckBoxes;
    property PaintStyle;
    property Splitter;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property OnGetName;
    property OnGetValue;
    property OnGetNextValue;
    property OnSetValue;
    property OnGetButtonType;
    property OnGetMaxLength;
    property OnGetEditMask;
    property OnGetInplaceEditorType;
    property OnGetEnableExternalEditor;
    property OnGetReadOnly;
    property OnGetExpandState;
    property OnGetLevel;
    property OnGetData;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetAutoApply;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnExpand;
    property OnCollapse;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
    property OnDragValue;
  end;

implementation

{$R *.RES}
{$R-}

{$IFDEF GOITRIAL}
const
  WM_TRIALMESSAGE = WM_USER + 1234;
{$ENDIF}

const
  crUpDown = 1;

function StringToBoolean(const S: string): Boolean;
begin
  Result:=GetEnumValue(TypeInfo(Boolean),S)>0;
end;

function TInspectorPopup.Inspector: TAdvCustomInspector;
begin
  if Assigned(Owner) then Result:=TAdvCustomInspector(Owner)
  else Result:=nil;
end;

procedure TInspectorPopup.DrawItem(TheIndex: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  Canvas.FillRect(Rect);
  with Inspector do DrawPopupItem(Self,TheIndex,Rect,ItemIndex);
end;

procedure TInspectorPopup.WndProc(var Message: TMessage);

  procedure Close(OK: Boolean);
  begin
    if Visible then
    begin
      Hide;
      with Inspector do
      begin
        if OK and (Self.ItemIndex>-1) then
          {$IFDEF GOITRIAL}
          TrialMessage;
          {$ELSE}
          FEdit.FEditing:=True;
          if (Self.ItemIndex<>-1) and (Self.ItemIndex<Self.Items.Count) then
          begin
            SetValue(ItemIndex,Self.Items[Self.ItemIndex]);
            Invalidate;
          end;
          {$ENDIF}
        if Showing and CanFocus then
        begin
          SetFocus;
          FocusControl;
        end;
        UpdateControls;
      end;
    end;
  end;

begin
  with Message do
    case Msg of
      CM_CANCELMODE:
        if TCMCancelMode(Message).Sender<>Self then Close(False);
      CM_DIALOGCHAR,WM_ACTIVATEAPP: Close(False);
      WM_KEYDOWN:
        case wParam of
          VK_ESCAPE,VK_TAB: Close(False);
          VK_RETURN: Close(True);
        end;
      WM_MOUSEMOVE,WM_LBUTTONDOWN:
        if GetKeyState(VK_LBUTTON) and $80 <> 0 then
          ItemIndex:=ItemAtPos(Point(LoWord(lParam),HiWord(lParam)),True);
      WM_LBUTTONUP: Close(PtInRect(ClientRect,Point(LoWord(lParam),HiWord(lParam))));
    end;
  inherited;
end;

procedure TInspectorPopup.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do ExStyle:=ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  with Params do Style:=Style or WS_TABSTOP;
end;

constructor TInspectorPopup.Create(AOwner: TComponent);
begin
  inherited;
  ParentCtl3D:=False;
  Ctl3D:=False;
  Style:=lbOwnerDrawFixed;
  IntegralHeight:=True;
end;

function TInspectorEdit.Inspector: TAdvCustomInspector;
begin
  if Assigned(Owner) then Result:=TAdvCustomInspector(Owner)
  else Result:=nil;
end;

procedure TInspectorEdit.WndProc(var Message: TMessage);
begin
  with Message do
    case Msg of
      WM_LBUTTONDOWN:
      begin
        if Inspector.Clicked then Inspector.Clicked:=False
        else
        begin
          inherited;
          Inspector.HidePopup;
          if not Inspector.IsFocused then
          begin
            if Parent.CanFocus then Parent.SetFocus;
            if CanFocus then SetFocus;
          end;
        end;
      end;
      WM_LBUTTONDBLCLK:
      begin
        inherited;
        Inspector.Action(iaDoubleClick);
      end;
      CM_EXIT:
      begin
        inherited;
        with Inspector do
        begin
          ApplyChanges;
          Update;
        end;
        Modified:=False;
      end;
    else inherited;
    end;
end;

procedure TInspectorEdit.KeyPress(var Key: Char);
begin
  with Inspector do
  begin
    if not ValidateChar(ItemIndex,Key) then
    begin
      Key:=#0;
      MessageBeep(0);
    end;
    FEditing:=True;
  end;
end;

procedure TInspectorEdit.Change;
begin
  with Inspector do ChangeValue(ItemIndex,FEditing,Self.Text);
  FEditing:=False;
end;

function TInspectorCheckBox.Inspector: TAdvCustomInspector;
begin
  if Assigned(Owner) then Result:=TAdvCustomInspector(Owner)
  else Result:=nil;
end;

procedure TInspectorCheckBox.Click;
begin
  inherited;
  with Inspector do
    if Boolean(GetEnumValue(TypeInfo(Boolean),GetValue(ItemIndex)))<>Checked then
    begin
      {$IFDEF GOITRIAL}
      TrialMessage;
      {$ELSE}
      FEdit.FEditing:=True;
      SetValue(FIndex,GetEnumName(TypeInfo(Boolean),Integer(Checked)));
      {$ENDIF}
      Update;
    end;
end;

procedure TInspectorButton.SetDown(const Value: Boolean);
begin
  if Value<>FDown then
  begin
    FDown:=Value;
    Invalidate;
  end;
end;

procedure TInspectorButton.SetButtonType(const Value: TButtonType);
begin
  FButtonType:=Value;
  Visible:=(FButtonType<>btNone) and not (csDesigning in ComponentState);
  Invalidate;
end;

function TInspectorButton.Inspector: TAdvCustomInspector;
begin
  if Assigned(Owner) then Result:=TAdvCustomInspector(Owner)
  else Result:=nil;
end;

procedure TInspectorButton.WndProc(var Message: TMessage);
var
  R: TRect;
  Glyph: TBitmap;
begin
  with Message do
    case Msg of
      WM_LBUTTONDOWN:
        if not (csDesigning in ComponentState) then
          with Inspector do
          begin
            if not FPopup.Showing then
            begin
              Down:=True;
              SetCapture(Self.Handle);
            end
            else
            begin
              HidePopup;
              if IsFocused and CanFocus then
              begin
                SetFocus;
                FocusControl;
              end;
            end;
            if not IsFocused and CanFocus then
            begin
              SetFocus;
              FocusControl;
            end;
            if FButtonType=btUpDown then
            begin
              Self.Cursor:=crUpDown;
              Screen.Cursor:=crUpDown;
            end;
          end
        else inherited;
      WM_MOUSEMOVE:
        if GetCapture=Handle then
        begin
          Down:=(FButtonType=btUpDown) or PtInRect(ClientRect,Point(LoWord(lParam),HiWord(lParam)));
          if FButtonType=btUpDown then
          begin
            GetCursorPos(R.TopLeft);
            R.BottomRight:=ClientToScreen(Point(0,ClientHeight div 2));
            with Inspector do DragValue(ItemIndex,R.Bottom-R.Top);
          end;
        end;
      WM_LBUTTONUP:
        if GetCapture=Handle then
        begin
          ReleaseCapture;
          Cursor:=crDefault;
          Screen.Cursor:=crDefault;
          if Down then
          begin
            Down:=False;
            with Inspector do
              case FButtonType of
                btDropDown: if Action(iaButtonClick) then Update;
                btDialog: if Action(iaDoubleClick) then Update;
              else
                ApplyChanges;
                Update;
              end;
          end;
        end;
      WM_LBUTTONDBLCLK:
      begin
        Down:=False;
        ReleaseCapture;
        if FButtonType=btDropDown then Inspector.HidePopup;
        if FButtonType<>btUpDown then
          with Inspector do
            if IsFocused and CanFocus then
            begin
              SetFocus;
              FocusControl;
            end;
      end;
      WM_PAINT:
      begin
        inherited;
        R:=ClientRect;
        with R,Canvas do
        begin
          Dec(Right);
          Dec(Bottom);
          if FDown then
          begin
            Pen.Color:=clBtnShadow;
            MoveTo(Left,Bottom);
            LineTo(Left,Top);
            LineTo(Right,Top);
            LineTo(Right,Bottom);
            LineTo(Left,Bottom);
          end
          else
          begin
            Pen.Color:=cl3DLight;
            MoveTo(Left,Bottom);
            LineTo(Left,Top);
            LineTo(Right,Top);
            Pen.Color:=clBlack;
            LineTo(Right,Bottom);
            LineTo(Pred(Left),Bottom);
            InflateRect(R,-1,-1);
            Pen.Color:=clBtnHighlight;
            MoveTo(Left,Bottom);
            LineTo(Left,Top);
            LineTo(Right,Top);
            Pen.Color:=clBtnShadow;
            LineTo(Right,Bottom);
            LineTo(Pred(Left),Bottom);
          end;
          case FButtonType of
            btDropDown: Glyph:=FDropDown;
            btUpDown: Glyph:=FUpDown;
            btDialog: Glyph:=FDialog;
          else Glyph:=nil;
          end;
          if Assigned(Glyph) then
          begin
            Left:=(Right+Left) div 2-(Glyph.Width) div 2;
            Top:=(Bottom+Top) div 2-(Glyph.Height) div 2;
            CopyMode:=cmSrcAnd;
            R:=Rect(Left,Top,Left+Glyph.Width,Top+Glyph.Height);
            if FDown then OffsetRect(R,1,1);
            CopyRect(R,Glyph.Canvas,Rect(0,0,Glyph.Width,Glyph.Height));
          end;
        end;
      end;
    else inherited;
    end;
end;

constructor TInspectorButton.Create(AOwner: TComponent);
begin
  inherited;
  Color:=clBtnFace;
  FDropDown:=TBitmap.Create;
  FDropDown.Handle:=LoadBitmap(HInstance,'DROPDOWN');
  FUpDown:=TBitmap.Create;
  FUpDown.Handle:=LoadBitmap(HInstance,'UPDOWN');
  FDialog:=TBitmap.Create;
  FDialog.Handle:=LoadBitmap(HInstance,'DIALOG');
  ControlStyle:=ControlStyle-[csDoubleClicks,csOpaque];
end;

destructor TInspectorButton.Destroy;
begin
  FDropDown.Free;
  FUpDown.Free;
  FDialog.Free;
  inherited Destroy;
end;

procedure TAdvCustomInspector.UpdateControls;
var
  R: TRect;
  WasFocused: Boolean;
begin
  if not (csDesigning in ComponentState) and (ItemCount>0) then
  begin
    WasFocused:=IsFocused;
    R:=ItemRect(FIndex);
    Dec(R.Left);
    Dec(R.Bottom);
    with R do Left:=Right-(Bottom-Top);
    with FButton do
    begin
      BoundsRect:=R;
      ButtonType:=Inspector.GetButtonType(FIndex);
      Visible:=Visible and not (csDesigning in ComponentState) and (ItemCount>0);
    end;
    R:=ItemRect(FIndex);
    InflateRect(R,-2,-2);
    R.Left:=FSplitter+3;
    Dec(R.Top);
    Dec(R.Bottom);
    if FButton.Visible then Dec(R.Right,FButton.Width);
    OffsetRect(R,0,1);
    Dec(R.Bottom);
    with FEdit do
    begin
      ParentFont:=True;
      if not (csLoading in Self.ComponentState) then GetValueFont(FIndex,Font);
      InflateRect(R,1,1);
      BoundsRect:=R;
      Text:=GetValue(FIndex);
      ReadOnly:=GetReadOnly(FIndex);
      MaxLength:=GetMaxLength(FIndex);
      EditMask:=GetEditMask(FIndex);
      Visible:=(GetInplaceEditorType(FIndex)=ieEdit) and not (csDesigning in ComponentState) and (ItemCount>0);
      SelectAll;
      if WasFocused and CanFocus then SetFocus;
      Invalidate;
    end;
    with FCheckBox do
    begin
      BoundsRect:=R;
      if GetInplaceEditorType(FIndex)=ieCheckBox then
        Checked:=StringToBoolean(GetValue(FIndex));
      Enabled:=not GetReadOnly(FIndex);
      Visible:=(GetInplaceEditorType(FIndex)=ieCheckBox) and CheckBoxes and
        not (csDesigning in ComponentState) and (ItemCount>0);
      if WasFocused and CanFocus then SetFocus;
      Invalidate;
    end;
    if WasFocused and not IsFocused and CanFocus then SetFocus;
  end
  else
  begin
    FEdit.Hide;
    FButton.Hide;
    FCheckBox.Hide;
  end;
end;

procedure TAdvCustomInspector.SetIndex(const Value: Integer);
var
  R: TRect;
begin
  if Value<>FIndex then
  begin
    if GetAutoApply(FIndex) then ApplyChanges;
    R:=ItemRect(FIndex);
    Dec(R.Top,ItemHeight+2);
    Inc(R.Bottom,ItemHeight);
    FIndex:=Value;
    ItemIndex:=FIndex;
    UpdateControls;
    Dec(R.Top,ItemHeight+2);
    Inc(R.Bottom,ItemHeight);
    InvalidateRect(Handle,@R,True);
  end;
end;

procedure TAdvCustomInspector.FocusControl;
begin
  if Showing and CanFocus and not FPopup.Visible then
  begin
    case GetInplaceEditorType(FIndex) of
      ieEdit:
        with FEdit do
          if CanFocus and Enabled then
          begin
            SelectAll;
            SetFocus;
            Invalidate;
          end;
      ieCheckBox:
        with FCheckBox do
          if CanFocus and Enabled then
          begin
            SetFocus;
            Invalidate;
          end;
    end;
    with FButton do if Visible then Invalidate;
  end;
end;

{$IFDEF GOITRIAL}
procedure TAdvCustomInspector.TrialMessage;
begin
  PostMessage(Self.Handle,WM_TRIALMESSAGE,0,0);
end;
{$ENDIF}

function TAdvCustomInspector.GetLocked: Boolean;
begin
  Result:=FLockCounter>0;
end;

function TAdvCustomInspector.GetItemCount: Integer;
begin
  Result:=Items.Count;
end;

procedure TAdvCustomInspector.SetItemCount(const Value: Integer);
var
  i: Integer;
  Focused: HWND;
begin
  if HandleAllocated and (ItemCount<>Value) then
  begin
    with Items do
    begin
      BeginUpdate;
      try
        Clear;
        for i:=0 to Pred(Value) do AddObject(GetName(i),GetData(i));
      finally
        EndUpdate;
      end;
    end;
    Focused:=GetFocus;
    if Items.Count>0 then ItemIndex:=GetDefaultIndex;
    Windows.SetFocus(Focused);
  end;
  FItemCount:=Value;
end;

procedure TAdvCustomInspector.SetSplitter(const Value: Integer);
var
  FS: Integer;
begin
  FS:=Value;
  if FS<32 then FS:=32;
  if FS>ClientWidth-48 then FS:=ClientWidth-48;
  if FSplitter<>FS then
  begin
    FSplitter:=FS;
    if Value<>FSplitter then FSplitter:=Value;
    UpdateControls;
    Invalidate;
  end;
end;

procedure TAdvCustomInspector.SetCheckBoxes(const Value: Boolean);
begin
  if FCheckBoxes<>Value then
  begin
    FCheckBoxes:=Value;
    Update;
    Invalidate;
  end;
end;

procedure TAdvCustomInspector.SetPaintStyle(const Value: TPaintStyle);
begin
  if FPaintStyle<>Value then
  begin
    FPaintStyle:=Value;
    Invalidate;
  end;
end;

procedure TAdvCustomInspector.DrawDragSplitter;
var
  OldPen: TPen;
  R: TRect;
begin
  with TCanvas.Create do
  try
    Handle:=GetWindowDC(0);
    OldPen:=TPen.Create;
    try
      OldPen.Assign(Pen);
      R:=ClientRect;
      MapWindowPoints(Self.Handle,HWND_DESKTOP,R,2);
      with Pen,R do
      begin
        Color:=clSilver;
        Mode:=pmXor;
        MoveTo(FDragSplitter+ClientOrigin.X,Top);
        LineTo(FDragSplitter+ClientOrigin.X,Bottom);
        Assign(OldPen);
      end;
    finally
      OldPen.Free;
    end;
  finally
    ReleaseDC(0,Handle);
    Free;
  end;
end;

procedure TAdvCustomInspector.SetMouseItem(Pos: LParam);
var
  I: Integer;
begin
  with Items do
    if Count>0 then
    begin
      I:=ItemAtPos(Point(0,HiWord(Pos)),False);
      if I<0 then
        if SmallInt(HiWord(Pos))>ItemHeight*(ClientHeight div ItemHeight) then I:=Succ(ItemIndex)
        else I:=Pred(ItemIndex);
      if I<0 then I:=0;
      if I>Pred(Count) then I:=Pred(Count);
      ItemIndex:=I;
    end;
end;

function TAdvCustomInspector.Action(A: TItemAction): Boolean;
var
  W: Integer;
  P: TPoint;
  EnableDefault: Boolean;
begin
  Result:=False;
  if (ItemIndex>-1) and (ItemIndex<Items.Count) and Assigned(GetParentForm(Self)) then
  begin
    case A of
      iaDoubleClick:
      begin
        EnableDefault:=True;
        if Assigned(FOnValueDoubleClick) then FOnValueDoubleClick(Self,ItemIndex,EnableDefault);
        if EnableDefault then
        begin
          if GetEnableExternalEditor(ItemIndex) then Result:=CallEditor(ItemIndex)
          else
            if not GetReadOnly(ItemIndex) then
            begin
              Result:=True;
              {$IFDEF GOITRIAL}
              TrialMessage;
              {$ELSE}
              SetValue(ItemIndex,GetNextValue(ItemIndex));
              {$ENDIF}
            end;

          {Comment FocusControl for now. Other properties like Font, Enabled, etc., all work ok with double click and
           the focus is kept in the property even without calling FocusControl. With FocusControl commented, we can
           implement focusing in other control in CallEditor, like for example when the user is double clicking events
           and the editor memo is focused. }
          //FocusControl;
        end;
        if Result then Update;
      end;
      iaButtonClick:
      begin
        with FPopup do
        begin
          Visible:=False;
          Parent:=Self;
          Canvas.Font.Assign(Font);
          Items.Clear;
          Sorted:=GetSortValuesList(Self.ItemIndex);
          GetValuesList(Self.ItemIndex,Items);
          W:=Items.Count;
          if W>8 then W:=8;
          if W<1 then W:=1;
          Height:=ItemHeight*W+2;
          Width:=0;
          W:=GetPopupItemWidth(FPopup,Self.ItemIndex)+6;
          if Height div ItemHeight < Items.Count then
            Inc(W,GetSystemMetrics(SM_CXVSCROLL));
          if W<Self.ClientWidth-FSplitter then W:=Self.ClientWidth-FSplitter;
          ClientWidth:=W;
          P.X:=FSplitter;
          if Width+FSplitter>Self.ClientWidth then P.X:=Self.ClientWidth-Width;
          with Self do
          begin
            P.Y:=ItemRect(ItemIndex).Bottom-2;
            P:=ClientToScreen(P);
            if P.Y+FPopup.Height>Screen.Height then
              Dec(P.Y,ItemHeight+FPopup.Height-2);
          end;
          Left:=P.X;
          Top:=P.Y;
          ItemIndex:=Items.IndexOf(GetSelectedValue(Self.ItemIndex));
          ShowWindow(Handle,SW_SHOW);
          Windows.SetParent(Handle,GetDesktopWindow);
          SetWindowLong(Handle,GWL_HWNDPARENT,GetDesktopWindow);
          SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NOMOVE or SWP_NOSIZE);
          SendMessage(GetFocus,WM_KILLFOCUS,0,0);
          Application.ProcessMessages;
          SendMessage(Handle,WM_SETFOCUS,GetFocus,0);
          Visible:=True;
          SetFocus;
        end;
      end;
    end;
  end;
end;

procedure TAdvCustomInspector.HidePopup;
begin
  if Assigned(FPopup) and FPopup.Visible then
  begin
    FPopup.Hide;
    FocusControl;
  end;
end;

function TAdvCustomInspector.IsFocused: Boolean;
begin
  IsFocused:=
    Focused or
    FCheckBox.Focused or
    FEdit.Focused or
    FButton.Focused;
end;

function TAdvCustomInspector.SpecialClick(L: LParam): Boolean;
begin
  Result:=(GetExpandState(ItemIndex)<>esNone) and
    (Abs(LoWord(L))>=GetLevel(ItemIndex)*GetIndent) and
    (Abs(LoWord(L))<=Succ(GetLevel(ItemIndex))*GetIndent+2);
end;

procedure TAdvCustomInspector.WndProc(var Message: TMessage);
var
  R: TRect;
  P: TPoint;
  i,j: Integer;
  IFont: TFont;
  IPen: TPen;
  IBrush: TBrush;

  procedure SaveCanvas(C: TCanvas);
  begin
    with C do
    begin
      IFont.Assign(Font);
      IPen.Assign(Pen);
      IBrush.Assign(Brush);
    end;
  end;

  procedure RestoreCanvas(C: TCanvas);
  begin
    with C do
    begin
      Font.Assign(IFont);
      Pen.Assign(IPen);
      Brush.Assign(IBrush);
    end;
  end;

  procedure ExpandCollapse;
  begin
    case GetExpandState(ItemIndex) of
      esExpand:
      begin
        j:=ItemCount;
        Expand(ItemIndex);
        i:=ItemIndex+ItemCount-j-(ClientHeight div ItemHeight)+1;
        if i>TopIndex then TopIndex:=i;
      end;
      esCollapse:
      begin
        Collapse(ItemIndex);
        SetSelectionPos(ItemIndex,True);
      end;
    end;
  end;

begin
  with Message do
    case Msg of
      CM_ENTER:
      begin
        inherited;
        if FEdit.CanFocus then FEdit.SetFocus;
        if FCheckBox.CanFocus then FCheckBox.SetFocus;
        FocusControl;
      end;
      CM_EXIT:
      begin
        if FPopup.Showing then FPopup.Hide;
        inherited;
      end;
      CM_FONTCHANGED:
      begin
        inherited;
        ItemHeight:=3*Abs(Font.Height) div 2;
        if ItemIndex<>-1 then SetSelectionPos(ItemIndex,True);
      end;
      CM_SHOWINGCHANGED:
      begin
        inherited;
        if FPopup.Showing then FPopup.Hide;
        FFullUpdate:=True;
      end;
      CM_FOCUSCHANGED:
      begin
        with TCmFocusChanged(Message) do
          if (Sender<>FPopup) and FPopup.Showing then FPopup.Hide;
        inherited;
      end;
      WM_CHAR,WM_CHARTOITEM,WM_VKEYTOITEM:;
      WM_KEYDOWN:
        if FPopup.CanFocus then
        begin
          FPopup.SetFocus;
          SendMessage(FPopup.Handle,WM_KEYDOWN,wParam,lParam);
          wParam:=0;
        end
        else
          case Char(wParam) of
            'A'..'Z','0'..'9':
              wParam:=0;
          else inherited;
          end;
      CM_CHILDKEY:
        if not (csDesigning in ComponentState) then
          if FPopup.CanFocus then
          begin
            Result:=1;
            FPopup.SetFocus;
            SendMessage(FPopup.Handle,WM_KEYDOWN,wParam,lParam);
          end
          else
            case wParam of
              VK_RETURN:
              begin
                Result:=1;
                if GetKeyState(VK_MENU) and $80 <> 0 then
                begin
                   if GetButtonType(ItemIndex)=btDropDown then Action(iaButtonClick);
                end
                else
                  if GetKeyState(VK_CONTROL) and $80 <> 0 then
                  begin
                    if GetButtonType(ItemIndex)=btDialog then Action(iaDoubleClick);
                  end
                  else
                  begin
                    FEdit.Modified:=True;
                    ApplyChanges;
                    Update;
                    FEdit.Modified:=False;
                  end;
              end;
              VK_ESCAPE:
              begin
                Result:=1;
                IgnoreChanges;
                Update;
              end;
              VK_UP:
              begin
                Result:=1;
                if ItemIndex>0 then ItemIndex:=Pred(ItemIndex);
              end;
              VK_DOWN{$IFDEF GOITABNEXT},VK_TAB{$ENDIF}:
              begin
                Result:=1;
                if GetKeyState(VK_MENU) and $80 <> 0 then
                begin
                  if GetButtonType(ItemIndex)=btDropDown then Action(iaButtonClick);
                  Exit;
                end;
                if ItemIndex<Pred(Items.Count) then ItemIndex:=Succ(ItemIndex);
              end;
            else inherited;
            end
        else inherited;
      WM_PAINT:
      begin
        inherited;
        if ItemCount>0 then
        begin
          DrawBorders(Canvas,FIndex,ItemRect(FIndex));
          if FButton.Visible then FButton.Invalidate;
        end;
      end;
      WM_SIZE:
      begin
        inherited;
        Splitter:=FSplitter;
        FEdit.Width:=ClientWidth;
        FFullUpdate:=True;
        Update;
      end;
      WM_LBUTTONDOWN:
        if not (csDesigning in ComponentState) then
        begin
          with FPopup do
            if Showing then Hide;
          with FEdit do
            if CanFocus then SetFocus;
          with FCheckBox do
            if CanFocus then SetFocus;
          FocusControl;
          SetCapture(Handle);
          if Abs(LoWord(lParam)-FSplitter)<=2 then
          begin
            FDragKind:=dkSplitter;
            FDragSplitter:=LoWord(lParam);
            DrawDragSplitter;
            SetCapture(Handle);
          end
          else
          begin
            SetMouseItem(lParam);
            if SpecialClick(lParam) then ExpandCollapse
            else
            begin
              FDragKind:=dkItem;
              SetCapture(Handle);
            end;
          end;
        end
        else inherited;
      WM_MOUSEMOVE:
      begin
        if GetCapture=Handle then
          case FDragKind of
            dkSplitter:
            begin
              DrawDragSplitter;
              FDragSplitter:=SmallInt(LoWord(lParam));
              if FDragSplitter<32 then FDragSplitter:=32;
              if FDragSplitter>ClientWidth-48 then FDragSplitter:=ClientWidth-48;
              DrawDragSplitter;
            end;
            dkItem: SetMouseItem(lParam);
          else inherited;
          end
        else inherited;
      end;
      WM_LBUTTONUP:
      begin
        inherited;
        case FDragKind of
          dkSplitter:
          begin
            DrawDragSplitter;
            Splitter:=FDragSplitter;
          end;
        end;
        ReleaseCapture;
        FDragKind:=dkNone;
        if FEdit.Visible and PtInRect(FEdit.BoundsRect,Point(LoWord(lParam),HiWord(lParam)))
          or FCheckBox.Visible and PtInRect(FCheckBox.BoundsRect,Point(LoWord(lParam),HiWord(lParam))) then
        begin
          Clicked:=True;
          if GetSystemMetrics(SM_SWAPBUTTON) = 0 then
          begin
            mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
          end else
          begin
            mouse_event(MOUSEEVENTF_RIGHTDOWN,0,0,0,0);
            mouse_event(MOUSEEVENTF_RIGHTUP,0,0,0,0);
          end;
        end;
      end;
      WM_LBUTTONDBLCLK:
        if LParamLo<FSplitter then ExpandCollapse;
      WM_RBUTTONDOWN:
      begin
        SetMouseItem(lParam);
        inherited;
      end;
      WM_NCLBUTTONDOWN..WM_NCMBUTTONDBLCLK:
      begin
        FPopup.Hide;
        inherited;
      end;
      WM_VSCROLL:
      begin
        inherited;
        HidePopup;
        if (Win32Platform=VER_PLATFORM_WIN32_NT) and (FOldScrollPos<>GetScrollPos(Handle,SB_VERT)) then
        begin
          FFullUpdate:=True;
          UpdateControls;
          case WParamLo of
            SB_ENDSCROLL:;
            SB_LINEDOWN,SB_LINEUP,SB_THUMBTRACK:
            begin
              R:=ItemRect(Pred(FIndex));
              Dec(R.Top,2);
              R.Bottom:=Succ(ItemRect(Succ(FIndex)).Bottom);
              InvalidateRect(Handle,@R,True);
            end;
          else Invalidate;
          end;
          FOldScrollPos:=GetScrollPos(Handle,SB_VERT);
        end;
      end;
      {$IFNDEF VERSION3}
      WM_MOUSEWHEEL:
      begin
        inherited;
        HidePopup;
        UpdateControls;
        Invalidate;
      end;
      {$ENDIF}
      LB_SETCURSEL:
      begin
        i:=FIndex;
        DeselectItem(ItemIndex);
        SetSelectionPos(wParam,False);
        inherited;
        R:=ItemRect(i);
        Dec(R.Top,2);
        Inc(R.Bottom);
        InvalidateRect(Handle,@R,True);
        UpdateControls;
        SelectItem(ItemIndex);
      end;
      WM_SETCURSOR:
        if not (csDesigning in ComponentState) and (HiWord(lParam)<>0) then
        begin
          GetCursorPos(P);
          P:=ScreenToClient(P);
          if Abs(P.X-FSplitter)<=2 then SetCursor(Screen.Cursors[crHSplit])
          else inherited;
        end
        else inherited;
      CN_DRAWITEM:
      begin
        IFont:=TFont.Create;
        IPen:=TPen.Create;
        IBrush:=TBrush.Create;
        try
          with PDrawItemStruct(lParam)^ do
            if (ODS_FOCUS and WordRec(LongRec(itemState).Lo).Lo=0) and (Integer(itemID)<>-1) then
              with Canvas do
              begin
                Canvas.Handle := hDC;
                Font.Assign(Self.Font);
                Brush.Style:=bsSolid;
                SetBkMode(hDC,TRANSPARENT);
                R:=rcItem;
                R.Right:=R.Left+FSplitter;
                Brush.Color:=Color;
                Font.Color:=clWindowText;
                SaveCanvas(Canvas);
                try
                  DrawPropertyName(Canvas,itemID,R);
                finally
                  RestoreCanvas(Canvas);
                end;
                Font.Color:=clNavy;
                R:=rcItem;
                R.Left:=R.Left+FSplitter+1;
                if csDesigning in ComponentState then DrawPropertyValue(Canvas,itemID,R)
                else
                  if (itemID=DWORD(ItemIndex)) and (GetInplaceEditorType(itemID)<>ieNone) then
                  begin
                    case GetInplaceEditorType(itemID) of
                      ieEdit: Brush.Color:=clWindow;
                      ieCheckBox: Brush.Color:=clWindow;
                    end;
                    Dec(R.Bottom);
                    FillRect(R);
                  end
                  else
                  begin
                    SaveCanvas(Canvas);
                    try
                      DrawPropertyValue(Canvas,itemID,R);
                    finally
                      RestoreCanvas(Canvas);
                    end;
                  end;
                if ItemCount>0 then
                begin
                  DrawHorizontalSeparator(Canvas,itemID,rcItem);
                  if ItemID=DWORD(ItemIndex) then DrawBorders(Canvas,ItemID,rcItem);
                  DrawVerticalSeparator(Canvas,itemID,rcItem);
                end;
                Canvas.Handle := 0;
              end;
        finally
          IFont.Free;
          IPen.Free;
          IBrush.Free;
        end;
      end;
      {$IFDEF GOITRIAL}
      WM_TRIALMESSAGE:
        Application.MessageBox(
          'Data cannot be changed in trial version of the component.',
          'Trial Limitation - XXXXXXXXXXXXXXXXXXXX',
          MB_OK or MB_ICONEXCLAMATION);
      {$ENDIF}
    else inherited;
    end;
end;

function TAdvCustomInspector.GetDefaultIndex: Integer;
begin
  Result:=0;
end;

procedure TAdvCustomInspector.FullUpdateNeeded;
begin
  FFullUpdate:=True;
end;

function TAdvCustomInspector.GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer;
var
  i: Integer;
begin
  Result:=0;
  with ListBox do
    for i:=0 to Pred(Items.Count) do
      with Canvas do
        if TextWidth(Items[i])>Result then Result:=TextWidth(Items[i]);
end;

procedure TAdvCustomInspector.DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer);
begin
  with ListBox,Canvas,R do
  begin
    Inc(Left,2);
    DrawText(Handle,PChar(Items[ListItemIndex]),-1,R,DT_SINGLELINE or DT_VCENTER);
  end;
end;

procedure TAdvCustomInspector.SetEditedText(const AText: string);
begin
  with FEdit do
  begin
    FEditing:=True;
    Text:=AText;
    Modified:=True;
    SelectAll;
  end;
end;

function TAdvCustomInspector.ValidateChar(TheIndex: Integer; var Key: Char): Boolean;
begin
  if Assigned(FOnValidateChar) then Result:=FOnValidateChar(Self,TheIndex,Key)
  else Result:=True;
end;

procedure TAdvCustomInspector.ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string);
begin
  if Assigned(FOnChangeValue) then FOnChangeValue(Self,TheIndex,Editing,AText);
end;

procedure TAdvCustomInspector.SetSelectionPos(TheIndex: Integer; NeedUpdate: Boolean);
begin
  if not (csDesigning in ComponentState) and
    ((TheIndex<>Index) and (TheIndex<>-1) or NeedUpdate) then
  begin
    Font.Assign(Self.Font);
    FSplitter:=Self.FSplitter;
    try
      if (TheIndex<>-1) and not GetReadOnly(FIndex) and GetAutoApply(FIndex) then ApplyChanges;
      FIndex:=TheIndex;
    except
      ItemIndex:=FIndex;
      raise;
    end;
    FFullUpdate:=True;
    UpdateControls;
    if Assigned(FOnSelect) then FOnSelect(Self,TheIndex);
  end;
end;

procedure TAdvCustomInspector.ApplyChanges;
var
  WasFocused: Boolean;
begin
  WasFocused:=IsFocused;
  if FIndex<>-1 then
    if (GetInplaceEditorType(FIndex)=ieEdit) and FEdit.Modified then
    begin                                         
      {$IFDEF GOITRIAL}
      TrialMessage;
      {$ELSE}
      if GetButtonType(FIndex) <> btDialog then // special property editor: cannot set directly
        SetValue(FIndex, FEdit.Text);
      {$ENDIF}
      FEdit.Modified:=False;
    end;
  if WasFocused then
  begin
    if FEdit.CanFocus then FEdit.SetFocus;
    if FCheckBox.CanFocus then FCheckBox.SetFocus;
  end;
end;

procedure TAdvCustomInspector.IgnoreChanges;
begin
  if FIndex<>-1 then
    case GetInplaceEditorType(FIndex) of
      ieEdit: FEdit.Text:=GetValue(FIndex);
      ieCheckBox: FCheckBox.Checked:=StringToBoolean(GetValue(FIndex));
    end;
end;

procedure TAdvCustomInspector.DrawPropertyName(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
begin
  TheCanvas.Brush.Color:=GetNameColor(TheIndex);
  GetNameFont(TheIndex,TheCanvas.Font);
  if Assigned(FOnDrawName) then FOnDrawName(Self,TheIndex,TheCanvas,R)
  else DrawPropertyNameDefault(TheCanvas,TheIndex,R);
end;

procedure TAdvCustomInspector.DrawPropertyNameDefault(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);

var
  X,S,E: Integer;
  EB: TBitmap;
  FR: TRect;

  function FindItem(Start,Level: Integer): Boolean;
  var
    i: Integer;
  begin
    Result:=False;
    for i:=Succ(Start) to Pred(Items.Count) do
    begin
      Result:=GetLevel(i)=Level;
      if Result then Break;
    end;
  end;

begin
  case GetExpandState(TheIndex) of
    esExpand: EB:=FExpand;
    esCollapse: EB:=FCollapse;
  else EB:=nil;
  end;
  with TheCanvas,R do
    case FPaintStyle of
      psClassic:
      begin
        FillRect(R);
        if Assigned(EB) then
          Draw(Left+GetLevel(TheIndex)*GetIndent+2,Top+(Bottom-Top-FExpand.Height) div 2,EB);
        Inc(Left,Succ(GetLevel(TheIndex))*GetIndent+4);
        DrawText(Handle,PChar(GetName(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
      end;
      psTree:
      begin
        Pen.Color:=clWhite;
        Pen.Color:=clBtnShadow;
        for X:=0 to GetLevel(TheIndex) do
        begin
          S:=Top-2;
          E:=Bottom;
          if TheIndex=0 then Inc(S,ItemHeight div 2+2);
          if not FindItem(TheIndex,X) then
            if GetLevel(TheIndex)=X then Dec(E,ItemHeight div 2)
            else Continue;
          MoveTo(Left+X*(GetIndent+2)+GetIndent div 2,S);
          LineTo(PenPos.X,E);
        end;
        MoveTo(Left+GetLevel(TheIndex)*(GetIndent+2)+GetIndent div 2,(Top+Bottom) div 2);
        LineTo(Left+Pred(Succ(GetLevel(TheIndex))*(GetIndent+2)),PenPos.Y);
        if Assigned(EB) then
          Draw(Left+GetLevel(TheIndex)*(GetIndent+2)+2,Top+(Bottom-Top) div 2-(FExpand.Height) div 2,EB);
        Inc(Left,Succ(GetLevel(TheIndex))*(GetIndent+2)+2);
        Dec(Bottom);
        Inc(Top);
        Dec(Right);
        DrawText(Handle,PChar(GetName(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS or DT_CALCRECT);
        FR:=R;
        InflateRect(FR,2,0);
        FillRect(FR);
        DrawText(Handle,PChar(GetName(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
      end;
      psTMS:
      begin
        FillRect(
          Rect(
            Left+Pred(GetLevel(TheIndex)*(GetIndent+2)),
            Top,Right,Bottom));
        if Assigned(EB) then
          Draw(Left+GetLevel(TheIndex)*(GetIndent+2)+2,Top+(Bottom-Top-FExpand.Height) div 2,EB);
        Pen.Color:=clWhite;
        Pen.Color:=clBtnShadow;
        if GetExpandState(TheIndex)<>esNone then
        begin
          MoveTo(Left+Pred(Succ(GetLevel(TheIndex))*(GetIndent+2)),Top);
          LineTo(PenPos.X,Bottom);
        end;
        MoveTo(Left+Pred(Getlevel(TheIndex)*(GetIndent+2)),Top);
        LineTo(PenPos.X,Bottom);
        Inc(Left,Succ(GetLevel(TheIndex))*(GetIndent+2)+2);
        DrawText(Handle,PChar(GetName(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
      end;
    end;
end;

procedure TAdvCustomInspector.DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
begin
  TheCanvas.Brush.Color:=GetValueColor(TheIndex);
  GetValueFont(TheIndex,TheCanvas.Font);
  if Assigned(FOnDrawValue) then FOnDrawValue(Self,TheIndex,TheCanvas,R)
  else DrawPropertyValueDefault(TheCanvas,TheIndex,R);
end;

procedure TAdvCustomInspector.DrawPropertyValueDefault(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  S: Integer;
  IR: TRect;
begin
  with TheCanvas do
  begin
    FillRect(R);
    Dec(R.Bottom);
    case GetInplaceEditorType(TheIndex) of
      ieNone,ieEdit:
      begin
        Inc(R.Left);
        DrawText(Handle,PChar(GetValue(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS or DT_NOPREFIX);
      end;
      ieCheckBox:
      begin
        IR:=R;
        with IR do
        begin
          Right:=Left+GetSystemMetrics(SM_CXMENUCHECK);
          Bottom:=Top+Right-Left;
          OffsetRect(IR,1,((R.Bottom-R.Top+1)-(Bottom-Top)) div 2);
        end;
        S:=DFCS_BUTTONCHECK;
        if StringToBoolean(GetValue(TheIndex)) then S:=S or DFCS_CHECKED;
        DrawFrameControl(Handle,IR,DFC_BUTTON,S);
      end;
    end;
  end;
end;

procedure TAdvCustomInspector.DrawBorders(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
begin
  with TheCanvas,R do
    case FPaintStyle of
      psClassic:
      begin
        Pen.Color:=clBlack;
        MoveTo(Left,Bottom-1);
        LineTo(Left,Top-2);
        LineTo(Right,Top-2);
        Pen.Color:=clBtnHighlight;
        LineTo(Right,Bottom-1);
        LineTo(Pred(Left),Bottom-1);
        InflateRect(R,-1,-1);
        Pen.Color:=clBtnShadow;
        MoveTo(Left,Bottom-2);
        LineTo(Left,Top-2);
        LineTo(Succ(Right),Top-2);
        Pen.Color:=cl3DLight;
        MoveTo(Left+1,Bottom-1);
        LineTo(Right+1,Bottom-1);
      end;
    end;
end;

procedure TAdvCustomInspector.DrawVerticalSeparator(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  B: Integer;
begin
  with TheCanvas,R do
    case FPaintStyle of
      psClassic:
      begin
        if TheIndex=ItemIndex then B:=Bottom-2
        else B:=Bottom;
        Pen.Color:=clBtnShadow;
        MoveTo(Pred(FSplitter),Top);
        LineTo(Pred(FSplitter),B);
        Pen.Color:=clBtnHighlight;
        MoveTo(FSplitter,Top);
        LineTo(FSplitter,B);
      end;
      psTMS,psTree:
      begin
        Pen.Color:=clWhite;
        Pen.Color:=clBtnShadow;
        MoveTo(FSplitter,Top);
        LineTo(FSplitter,Bottom);
      end;
    end;
end;

procedure TAdvCustomInspector.DrawHorizontalSeparator(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  i: Integer;
begin
  with TheCanvas,R do
    case FPaintStyle of
      psClassic:
        for i:=Left to Pred(Right) do
          if not Odd(i) then
            SetPixel(Handle,i,Pred(Bottom),ColorToRGB(clBtnShadow));
      psTree:
      begin
        if TheIndex<Pred(Items.Count) then Pen.Color:=GetValueColor(TheIndex)
        else Pen.Color:=Self.Color;
        MoveTo(Left+FSplitter,Pred(Bottom));
        LineTo(Right,Pred(Bottom));
      end;
      psTMS:
      begin
        Pen.Color:=clWhite;
        Pen.Color:=clBtnShadow;
        i:=GetLevel(TheIndex);
        if (TheIndex<Pred(ItemCount)) and (GetLevel(Succ(TheIndex))<i) then
          i:=GetLevel(Succ(TheIndex));
        MoveTo(Left+Pred(i*(GetIndent+2)),Pred(Bottom));
        LineTo(Right,Pred(Bottom));
      end;
    end;
end;

function TAdvCustomInspector.GetName(TheIndex: Integer): string;
begin
  Result:='';
  if Assigned(FOnGetName) then FOnGetName(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetValue(TheIndex: Integer): string;
begin
  Result:='';
  if Assigned(FOnGetValue) then FOnGetValue(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetNextValue(TheIndex: Integer): string;
begin
  Result:='';
  if Assigned(FOnGetNextValue) then FOnGetNextValue(Self,TheIndex,Result);
end;

procedure TAdvCustomInspector.SetValue(TheIndex: Integer; const Value: string);
begin
  if Assigned(FOnSetValue) then FOnSetValue(Self,TheIndex,Value);
end;

procedure TAdvCustomInspector.DragValue(TheIndex,Offset: Integer);
begin
  if Assigned(FOnDragValue) then FOnDragValue(Self,TheIndex,Offset);
end;

function TAdvCustomInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  Result:=btNone;
  if Assigned(FOnGetButtonType) then FOnGetButtonType(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetInplaceEditorType(TheIndex: Integer): TInplaceEditorType;
begin
  Result:=ieEdit;
  if Assigned(FOnGetInplaceEditorType) then FOnGetInplaceEditorType(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetMaxLength(TheIndex: Integer): Integer;
begin
  Result:=0;
  if Assigned(FOnGetMaxLength) then FOnGetMaxLength(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetEditMask(TheIndex: Integer): string;
begin
  Result:='';
  if Assigned(FOnGetEditMask) then FOnGetEditMask(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  Result:=False;
  if Assigned(FOnGetEnableExternalEditor) then FOnGetEnableExternalEditor(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  Result:=False;
  if Assigned(FOnGetReadOnly) then FOnGetReadOnly(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetExpandState(TheIndex: Integer): TExpandState;
begin
  Result:=esNone;
  if Assigned(FOnGetExpandState) then FOnGetExpandState(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetLevel(TheIndex: Integer): Integer;
begin
  Result:=0;
  if Assigned(FOnGetLevel) then FOnGetLevel(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetData(TheIndex: Integer): Pointer;
begin
  Result:=nil;
  if Assigned(FOnGetData) then FOnGetData(Self,TheIndex,Result);
end;

procedure TAdvCustomInspector.GetValuesList(TheIndex: Integer; const Strings: TStrings);
begin
  if Assigned(Strings) and Assigned(FOnGetValuesList) then
  begin
    Strings.Clear;
    FOnGetValuesList(Self,TheIndex,Strings);
  end;
end;

function TAdvCustomInspector.GetSortValuesList(TheIndex: Integer): Boolean;
begin
  Result:=False;
  if Assigned(FOnGetSortValuesList) then FOnGetSortValuesList(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetSelectedValue(TheIndex: Integer): string;
begin
  Result:=Values[TheIndex];
  if Assigned(FOnGetSelectedValue) then FOnGetSelectedValue(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  Result:=False;
  if Assigned(FOnGetAutoApply) then FOnGetAutoApply(Self,TheIndex,Result);
end;

procedure TAdvCustomInspector.GetNameFont(TheIndex: Integer; TheFont: TFont);
begin
  case FPaintStyle of
    psTMS,psTree:
      if TheIndex=ItemIndex then TheFont.Color:=clHighlightText
  end;
  if Assigned(FOnGetNameFont) then FOnGetNameFont(Self,TheIndex,TheFont);
end;

function TAdvCustomInspector.GetNameColor(TheIndex: Integer): TColor;
begin
  case FPaintStyle of
    psTMS,psTree:
      if TheIndex=ItemIndex then Result:=clHighlight
      else Result:=Color;
  else Result:=Color;
  end;
  if Assigned(FOnGetNameColor) then FonGetNameColor(Self,TheIndex,Result);
end;

procedure TAdvCustomInspector.GetValueFont(TheIndex: Integer; TheFont: TFont);
begin
  if Assigned(FOnGetValueFont) then FOnGetValueFont(Self,TheIndex,TheFont);
end;

function TAdvCustomInspector.GetValueColor(TheIndex: Integer): TColor;
begin
  Result:=Color;
  if Assigned(FOnGetValueColor) then FonGetValueColor(Self,TheIndex,Result);
end;

function TAdvCustomInspector.GetIndent: Integer;
begin
  Result:=FExpand.Width;
  case FPaintStyle of
    psTMS: Inc(Result,3);
    psTree: Inc(Result,4);
  end;
end;

function TAdvCustomInspector.CallEditor(TheIndex: Integer): Boolean;
begin
  if Assigned(FOnCallEditor) then Result:=FOnCallEditor(Self,TheIndex)
  else Result:=False;
end;

procedure TAdvCustomInspector.Expand(TheIndex: Integer);
begin
  if Assigned(FOnExpand) then FOnExpand(Self,TheIndex);
end;

procedure TAdvCustomInspector.Collapse(TheIndex: Integer);
begin
  if Assigned(FOnCollapse) then FOnCollapse(Self,TheIndex);
end;

procedure TAdvCustomInspector.SelectItem(TheIndex: Integer);
begin
  if Assigned(FOnSelectItem) then FOnSelectItem(Self,TheIndex);
end;

procedure TAdvCustomInspector.DeselectItem(TheIndex: Integer);
begin
  if Assigned(FOnDeselectItem) then FOnDeselectItem(Self,TheIndex);
end;

constructor TAdvCustomInspector.Create(AOwner: TComponent);
begin
  inherited;
  Style:=lbOwnerDrawFixed;
  Color:=clBtnFace;
  FSplitter:=100;
  FEdit:=TInspectorEdit.Create(Self);
  with FEdit do
  begin
    BorderStyle:=bsNone;
    Visible:=False;
    if not (csDesigning in ComponentState) then Parent:=Self;
  end;
  FCheckBox:=TInspectorCheckBox.Create(Self);
  with FCheckBox do
  begin
    ParentColor:=False;
    Color:=clWindow;
    Visible:=False;
    if not (csDesigning in ComponentState) then Parent:=Self;
  end;
  FButton:=TInspectorButton.Create(Self);
  if not (csDesigning in ComponentState) then FButton.Parent:=Self;
  FPopup:=TInspectorPopup.Create(Self);
  FPopup.ItemHeight:=ItemHeight;
  FExpand:=TBitmap.Create;
  FExpand.Handle:=LoadBitmap(HInstance,'EXPAND');
  with FExpand,Canvas do
  begin
    PixelFormat:=pf4bit;
    Brush.Color:=clWindow;
    FloodFill(2,2,clBlack,fsBorder);
  end;
  FCollapse:=TBitmap.Create;
  FCollapse.Handle:=LoadBitmap(HInstance,'COLLAPSE');
  with FCollapse,Canvas do
  begin
    PixelFormat:=pf4bit;
    Brush.Color:=clWindow;
    FloodFill(2,2,clBlack,fsBorder);
  end;
  {$IFDEF GOITRIAL}
  if not (csDesigning in ComponentState) then
    Application.MessageBox(
      'You are using trial version of XXXXXXXXXXXXXXXXXX components'#13'with some functional limitations.',
      'XXXXXXXXXXXXXXXXXXX - Trial Version',
      MB_OK or MB_ICONEXCLAMATION);
  {$ENDIF}
end;

destructor TAdvCustomInspector.Destroy;
begin
  FExpand.Free;
  FCollapse.Free;
  inherited;
end;

procedure TAdvCustomInspector.Update;
var
  R: TRect;
begin
  if not Locked then
  begin
    if Assigned(FPopup) then FPopup.Hide;
    RedrawWindow(Handle,nil,0,RDW_NOERASE or RDW_INVALIDATE);
    if not FFullUpdate then
    begin
      R:=ItemRect(ItemIndex);                   
      R.Right:=FSplitter;
      ValidateRect(Handle,@R);
    end;
    FFullUpdate:=False;
    UpdateControls;
    if Assigned(FOnUpdate) then FOnUpdate(Self);
  end;
end;

procedure TAdvCustomInspector.Lock;
begin
  Inc(FLockCounter);
end;

procedure TAdvCustomInspector.Unlock;
begin
  if Locked then Dec(FLockCounter);
end;

procedure TAdvCustomInspector.CreateWnd;
begin
  inherited;
  ItemCount:=FItemCount;
  FOldWidth:=0;
  FOldHeight:=0;
  FOldSplitter:=0;
  UpdateControls;
end;

initialization
  Screen.Cursors[crUpDown]:=LoadCursor(HInstance,'UPDOWN');
end.
