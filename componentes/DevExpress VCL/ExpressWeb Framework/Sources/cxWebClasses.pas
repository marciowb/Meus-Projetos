{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Components Library                                      }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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

unit cxWebClasses;

interface

{$I cxVer.inc}

uses TypInfo, Classes, Contnrs, HTTPProd,
  {$IFDEF VCL}
  Windows,
  {$ENDIF}
  cxWebRender, cxWebTypes, cxWebColors, cxWebGraphics, cxWebIntf;

const
  cxclDefaultStyleBorderColor = clWebWindowText;
  cxclDefaultStyleBkColor = clWebWindow;

type

  TcxWebStyles = class;
  TcxWebStyleItem = class;

  IcxWebStyleChanged = interface
  ['{F9E6795C-C928-4787-9B43-ED6B23AFA7AE}']
    procedure StyleChanged(Style: TcxWebStyleItem);
  end;

  IcxWebGetStyles = interface
  ['{E4A787C5-60CA-4C60-AD99-C99FAA670DD9}']
    function GetStyles: TcxWebStyles;
  end;

  TcxWebHelper = class(TObject)
  private
    FComponent: TComponent;
  public
    constructor Create(AComponent: TComponent); virtual;
    property Component: TComponent read FComponent;
  end;

  TcxWebActionsHelper = class(TcxWebHelper)
  private
    FActions: TStrings;
  protected
    { IcxWebActions }
    procedure DoPerformAction(const ActionName: string; const ActionParameters: TcxActionParameters);
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;

    procedure ClearActions;
    procedure RegisterAction(const ActionName: string; const Action: TcxWebComponentActionProc);
  end;

  TcxCustomEventItem = class(TCollectionItem)
  private
    FEventProcType: TcxWebComponentEventProcType;
    FEventType: Integer;
    FHandlerText: TStrings;

    procedure SetHandlerText(Value: TStrings);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property EventProcType: TcxWebComponentEventProcType read FEventProcType write FEventProcType;
    property EventType: Integer read FEventType write FEventType;
    property HandlerText: TStrings read FHandlerText write SetHandlerText;
  end;

  TcxWebEventsHelper = class;
  TcxCustomEvents = class(TCollection)
  private
    FEventsHelper: TcxWebEventsHelper;

    function GetItem(Index: Integer): TcxCustomEventItem;
    procedure SetItem(Index: Integer; Value: TcxCustomEventItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AEventsHelper: TcxWebEventsHelper);
    function Add: TcxCustomEventItem;

    property EventsHelper: TcxWebEventsHelper read FEventsHelper;
    property Items[Index: Integer]: TcxCustomEventItem read GetItem write SetItem; default;
  end;

  TcxWebEventsHelper = class(TcxWebHelper)
  private
    FCustomEvents: TcxCustomEvents;
    FEvents: TcxCustomEvents;
    procedure FindEvents(const AEvent: Integer; AList: TList);
  protected
    procedure ClearEvents;

    procedure WriteEvent(AHTMLTextBuilder: TcxHTMLTextBuilder; AList: TList); virtual;
    procedure WriteEventScript(AHTMLTextBuilder: TcxHTMLTextBuilder; AList: TList); virtual;
    procedure WriteEvents(AHTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteEventsScript(AHTMLTextBuilder: TcxHTMLTextBuilder); virtual;

    function EventName(const AEvent: Integer): string; virtual;
    function EventProc(const AEvent: Integer): string; virtual;
    function EventProcName(const AEvent: Integer): string; virtual;
    function EventProcParams(const AEvent: Integer): string; virtual;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;

    function EventTypeInfo: PTypeInfo; virtual;
    function MaxEventValue: Integer;
    function MinEventValue: Integer;

    procedure RegisterEvent(const AEvent: TcxHTMLEvent;
        const AEventProc: TcxWebComponentEventProc;
        const AEventProcType: TcxWebComponentEventProcType);

    property CustomEvents: TcxCustomEvents read FCustomEvents write FCustomEvents;
  end;
  TcxWebEventsHelperClass = class of TcxWebEventsHelper;


  TcxWebScriptEventsHelper = class(TcxWebEventsHelper)
  protected
    function ScriptObject: string; virtual;
    procedure WriteEvent(AHTMLTextBuilder: TcxHTMLTextBuilder; AList: TList); override;
  end;


  TcxWebRenderHelper = class(TcxWebHelper)
  private
    FRenderers: TClassList;

    FOnAfterRender: TNotifyEvent;
    FOnBeforeRender: TNotifyEvent;

    function GetRenderer(AHTMLTextBuilder: TcxHTMLTextBuilder): TcxWebRenderer;
    procedure ClearEvents;
    procedure RegisterEvents;
  protected
    procedure DoAfterRender; dynamic;
    procedure DoBeforeRender; dynamic;
    { IcxCodeProvider }
    function GetRendererClass(Browser: TcxWebBrowserClass): TcxWebRendererClass; virtual;
    procedure GetScriptFiles(HTMLTextBuilder: TcxHTMLTextBuilder; AList: TStrings); virtual;
    procedure WriteClassScripts(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteBeginHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteClassHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteEndHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteClassOutOfFormHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteOutOfFormHTML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteScripts(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteXML(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;

    procedure RegisterRenderer(ARendererClass: TcxWebRendererClass);
    procedure ClearRenderers; virtual;

    property OnAfterRender: TNotifyEvent read FOnAfterRender write FOnAfterRender;
    property OnBeforeRender: TNotifyEvent read FOnBeforeRender write FOnBeforeRender;
  end;

  TcxWebScriptsHelper = class(TcxWebHelper)
  private
    FScripts: TClassList;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
    procedure ScriptSubscription(const AClass: TClass);
  end;

  TcxWebValuesHelper = class(TcxWebHelper)
  private
    FValues: TStrings;
  protected
    { IcxWebValues }
    function GetValues: TStrings;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
    procedure RegisterValue(const AName: string; AValue: string);

    property Values: TStrings read GetValues;
  end;

  { TcxWebComponent }

  TcxWebComponent = class(TComponent, IcxWebProvidersSupport,
    IcxCodeProvider, IcxWebActions, IcxWebEvents,
    IcxWebValues, IcxWebScripts, IcxWebStyleChanged, IcxWebGetStyles,
    IcxWebComponentState, IWebVariableName)
  private
    FStyles: TcxWebStyles;
    FWebActionsHelper: TcxWebActionsHelper;
    FWebEventsHelper: TcxWebEventsHelper;
    FWebRenderHelper: TcxWebRenderHelper;
    FWebScriptsHelper: TcxWebScriptsHelper;
    FWebValuesHelper: TcxWebValuesHelper;
    FWebComponentState: TcxWebComponentStates;

    FOnAfterRender: TNotifyEvent;
    FOnBeforeRender: TNotifyEvent;

    function GetWebRendererClass(ABrowser: TcxWebBrowserClass): TcxWebRendererClass;
    function GetCustomEvents: TcxCustomEvents;
    procedure SetCustomEvents(Value: TcxCustomEvents);

    { IcxWebGetStyles }
    function GetStyles: TcxWebStyles;
    procedure SetStyles(Value: TcxWebStyles);
    function GetStyleItem_Default: TcxWebStyleItem;
    function GetStyleItem_Hover: TcxWebStyleItem;
    procedure SetStyleItem_Default(Value: TcxWebStyleItem);
    procedure SetStyleItem_Hover(Value: TcxWebStyleItem);

    procedure GetDefaultStyleProc(var AScript: string);
    procedure GetHoverStyleProc(var AScript: string);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { actions }
    procedure DoAfterPerformActions; virtual;
    procedure RegisterActions; virtual;
    function GetWebActionsHelper: TcxWebActionsHelper; virtual;
    property WebActionsHelper: TcxWebActionsHelper read GetWebActionsHelper implements IcxWebActions;
    { events }
    procedure RegisterEvents; virtual;
    function GetWebEventsHelper: TcxWebEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; virtual;
    property WebEventsHelper: TcxWebEventsHelper read GetWebEventsHelper implements IcxWebEvents;
    { rendering }
    procedure RegisterRenderers; virtual;
    function GetWebRenderHelper: TcxWebRenderHelper; virtual;
    property WebRenderHelper: TcxWebRenderHelper read GetWebRenderHelper implements IcxCodeProvider;
    { scripts }
    procedure ScriptsSubscription; virtual;
    function GetWebScriptsHelper: TcxWebScriptsHelper; virtual;
    property WebScriptsHelper: TcxWebScriptsHelper read GetWebScriptsHelper;
    { IcxWebProvidersSupport}
    procedure GetProviders(AList: TList);
    procedure ImplGetProviders(AList: TList); virtual;
    procedure AddStylesToProviderList(AList: TList; AStylesArray: Array of TcxWebStyles);

    {IcxWebStyleChanged}
    procedure StyleChanged(Style: TcxWebStyleItem); virtual;
    { values }
    function CanSetValues: Boolean; virtual;
    procedure DoAfterSetValues; virtual;
    procedure DoSetValues; virtual;
    procedure RegisterValues; virtual;
    function GetWebValuesHelper: TcxWebValuesHelper; virtual;
    property WebValuesHelper: TcxWebValuesHelper read GetWebValuesHelper implements IcxWebValues;

    { IWebVariableName }
    function GetVariableName: string;
    function ImplGetVariableName: string; virtual;
    { IcxWebComponentState }
    function GetState: TcxWebComponentStates;
    procedure SetState(Value: TcxWebComponentStates);

    {Render helper events}
    procedure DoBeforeRenderProc(Sender: TObject);
    procedure DoAfterRenderProc(Sender: TObject);
    procedure DoBeforeRender; dynamic;
    procedure DoAfterRender; dynamic;

    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsLoading: Boolean;
    property Styles: TcxWebStyles read GetStyles write SetStyles;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property WebRendererClasses[ABrowser: TcxWebBrowserClass]: TcxWebRendererClass read GetWebRendererClass;
    property WebComponentState: TcxWebComponentStates read GetState write SetState;
  published
    property CustomEvents: TcxCustomEvents read GetCustomEvents write SetCustomEvents;

    //Avoid Delphi bug with linked forms/modules
    property StyleItem_Default: TcxWebStyleItem read GetStyleItem_Default write SetStyleItem_Default;
    property StyleItem_Hover: TcxWebStyleItem read GetStyleItem_Hover write SetStyleItem_Hover;

    property OnAfterRender: TNotifyEvent read FOnAfterRender write FOnAfterRender;
    property OnBeforeRender: TNotifyEvent read FOnBeforeRender write FOnBeforeRender;
  end;

  TcxWebComponentClass = class of TcxWebComponent;

  TcxInternalWebStyle = class
  protected
    class function GetName: string; virtual; abstract;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); virtual; abstract;
  end;

  TcxWebComponentRenderer = class(TcxWebRenderer)
  private
    function GetWebComponent: TcxWebComponent;
  protected
    class function GetDefaultStyleProc(AStyle: TcxWebStyleItem): string; virtual;
    class function GetHoverStyleProc(AStyle: TcxWebStyleItem): string; virtual;

    procedure WriteDefaultStyle; virtual;
    procedure WriteEvents; virtual;
    procedure WriteEventsScript; virtual;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteScripts; override;
    property WebComponent: TcxWebComponent read GetWebComponent;
  end;

  TcxWebStandardTarget = (tBlank, tMedia, tParent, tSearch, tSelf, tTop);
  TcxURL = class(TPersistent)
  private
    FHref: string;
    FOwner: TComponent;
    FTarget: string;
    procedure SetHref(Value: string);
    procedure SetTarget(Value: string);
  protected
    procedure UpdateOwner;
    property Owner: TComponent read FOwner;
  public
    constructor Create(AOwner: TComponent);
    procedure Assign(Source: TPersistent); override;
    procedure Write(AHTMLTextBuilder: TcxHTMLTextBuilder); virtual;
  published
    property Href: string read FHref write SetHref;
    property Target: string read FTarget write SetTarget;
  end;

  TBasecxWebStyle = class;

  TcxWebStyleObject = class(TPersistent)
  private
    FWebStyle: TBasecxWebStyle;
  protected
    function CanAssignValue: Boolean;
    procedure Changed; dynamic;
    procedure DoRestoreDefaults; dynamic;
  public
    constructor Create(AWebStyle: TBasecxWebStyle); virtual;

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure RestoreDefaults;

    property WebStyle: TBasecxWebStyle read FWebStyle;
  end;


  TcxWebBorderStyle =
    (wbsNone, wbsSolid, wbsDotted, wbsDashed, wbsDouble, wbsGroove, wbsRidge, wbsInset, wbsOutset);

  TcxWebBorderAssignedValue = (wbavColor, wbavStyle, wbavWidth);
  TcxWebBorderAssignedValues = set of TcxWebBorderAssignedValue;

  TcxWebBorderWidth = 0..32767;
{$NODEFINE TcxWebBorderWidth}

  (*$HPPEMIT 'namespace cxWebClasses'}*)
  (*$HPPEMIT '{'}*)
  (*$HPPEMIT '#pragma option -b-'*)
  (*$HPPEMIT '  enum TcxWebBorderWidth {bwMin=0, bwMax=32767};'}*)
  (*$HPPEMIT '#pragma option -b.'*)
  (*$HPPEMIT '}'*)

  TcxWebBorders = class;

  TcxWebBorder = class(TPersistent)
  private
    FAssignedValues: TcxWebBorderAssignedValues;
    FBorders: TcxWebBorders;
    FColor: TcxWebColor;
    FStyle: TcxWebBorderStyle;
    FWidth: TcxWebBorderWidth;

    function IsColorStored: Boolean;
    function IsStyleStored: Boolean;
    function IsWidthStored: Boolean;
    procedure SetAssignedValues(Value: TcxWebBorderAssignedValues);
    procedure SetColor(Value: TcxWebColor);
    procedure SetStyle(Value: TcxWebBorderStyle);
    procedure SetWidth(Value: TcxWebBorderWidth);
  protected
    procedure Changed; dynamic;
  public
    constructor Create(ABorders: TcxWebBorders);
    procedure Assign(Source: TPersistent); override;
    procedure Merge(Source: TcxWebBorder); virtual;
    procedure RestoreDefaults;

    property Borders: TcxWebBorders read FBorders;
  published
    property Color: TcxWebColor read FColor write SetColor stored IsColorStored default cxclDefaultStyleBorderColor;
    property Style: TcxWebBorderStyle read FStyle write SetStyle stored IsStyleStored default wbsNone;
    property Width: TcxWebBorderWidth read FWidth write SetWidth stored IsWidthStored default 2;
    // must be last
    property AssignedValues: TcxWebBorderAssignedValues read FAssignedValues write SetAssignedValues default [];
  end;


  TcxWebBorders = class(TcxWebStyleObject)
  private
    FBottom: TcxWebBorder;
    FLeft: TcxWebBorder;
    FRight: TcxWebBorder;
    FTop: TcxWebBorder;

    function GetColor: TcxWebColor;
    function GetStyle: TcxWebBorderStyle;
    function GetWidth: TcxWebBorderWidth;
    function IsColorStored: Boolean;
    function IsStyleStored: Boolean;
    function IsWidthStored: Boolean;
    procedure SetBottom(Value: TcxWebBorder);
    procedure SetColor(Value: TcxWebColor);
    procedure SetLeft(Value: TcxWebBorder);
    procedure SetRight(Value: TcxWebBorder);
    procedure SetStyle(Value: TcxWebBorderStyle);
    procedure SetTop(Value: TcxWebBorder);
    procedure SetWidth(Value: TcxWebBorderWidth);
  protected
    procedure DoRestoreDefaults; override;
  public
    constructor Create(AWebStyle: TBasecxWebStyle); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Merge(Source: TcxWebBorders); virtual;

    function SameColors: Boolean;
    function SameStyles: Boolean;
    function SameWidths: Boolean;

    function HorzBordersSize: Integer;
    function VertBordersSize: Integer;

    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
  published
    property Bottom: TcxWebBorder read FBottom write SetBottom;
    property Color: TcxWebColor read GetColor write SetColor stored IsColorStored;
    property Left: TcxWebBorder read FLeft write SetLeft;
    property Style: TcxWebBorderStyle read GetStyle write SetStyle stored IsStyleStored;
    property Right: TcxWebBorder read FRight write SetRight;
    property Top: TcxWebBorder read FTop write SetTop;
    property Width: TcxWebBorderWidth read GetWidth write SetWidth stored IsWidthStored;
  end;


  TcxWebShadingAssignedValue = (wsavColor);
  TcxWebShadingAssignedValues = set of TcxWebShadingAssignedValue;

  TcxWebShading = class(TcxWebStyleObject)
  private
    FAssignedValues: TcxWebShadingAssignedValues;
    FColor: TcxWebColor;

    procedure SetAssignedValues(Value: TcxWebShadingAssignedValues);
    procedure SetColor(Value: TcxWebColor);
  protected
    procedure DoRestoreDefaults; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Merge(Source: TcxWebShading); virtual;
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
  published
    property Color: TcxWebColor read FColor write SetColor default cxclDefaultStyleBkColor;
    // must be last
    property AssignedValues: TcxWebShadingAssignedValues read FAssignedValues write SetAssignedValues default [];
  end;


  TcxWebNumberingPosition = (wnpInside, wnpOutside);

  TcxWebNumberingStyle = (wnsNone, wnsCircle, wnsDisc, wnsSquare, wnsDecimal,
    wnsUpperRoman, wnsUpperAlpha, wnsLowerAlpha, wnsLowerRoman, wnsPicture);

  TcxWebNumberingAssignedValue = (wnavPosition, wnavStyle);
  TcxWebNumberingAssignedValues = set of TcxWebNumberingAssignedValue;

  TcxWebNumbering = class(TcxWebStyleObject)
  private
    FAssignedValues: TcxWebNumberingAssignedValues;
    FPicture: string;
    FPosition: TcxWebNumberingPosition;
    FStyle: TcxWebNumberingStyle;

    procedure SetAssignedValues(Value: TcxWebNumberingAssignedValues);
    procedure SetPicture(const Value: string);
    procedure SetPosition(Value: TcxWebNumberingPosition);
    procedure SetStyle(Value: TcxWebNumberingStyle);
  protected
    procedure DoRestoreDefaults; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Merge(Source: TcxWebNumbering); virtual;
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
  published
    property Picture: string read FPicture write SetPicture;
    property Position: TcxWebNumberingPosition read FPosition write SetPosition default wnpOutside;
    property Style: TcxWebNumberingStyle read FStyle write SetStyle default wnsNone;
    // must be last
    property AssignedValues: TcxWebNumberingAssignedValues read FAssignedValues write SetAssignedValues default [];
  end;


  TcxWebStyleClass = class of TBasecxWebStyle;
  TBasecxWebStyle = class(TPersistent)
  private
    FBorders: TcxWebBorders;
    FFont: TcxWebFont;
    FNumbering: TcxWebNumbering;
    FShading: TcxWebShading;
    FUpdateCount: Integer;

    procedure SetBorders(Value: TcxWebBorders);
    procedure SetFont(Value: TcxWebFont);
    procedure SetNumbering(Value: TcxWebNumbering);
    procedure SetShading(Value: TcxWebShading);

    procedure FontChanged(Sender: TObject);
  protected
    procedure Changed;
    procedure DoChanged; dynamic;
    procedure DoRestoreDefaults; dynamic;
    property UpdateCount: Integer read FUpdateCount;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Merge(Source: TBasecxWebStyle); virtual;

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure RestoreDefaults;

    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
  published
    property Borders: TcxWebBorders read FBorders write SetBorders;
    property Font: TcxWebFont read FFont write SetFont;
    property Numbering: TcxWebNumbering read FNumbering write SetNumbering;
    property Shading: TcxWebShading read FShading write SetShading;
  end;


  TcxWebStyle = class(TBasecxWebStyle)
  private
    FStyleItem: TcxWebStyleItem;
  protected
    function GetOwner: TPersistent; override;
    procedure DoChanged; override;
  public
    constructor Create(AStyleItem: TcxWebStyleItem);
    property StyleItem: TcxWebStyleItem read FStyleItem;
  end;


  TcxWebStyleController = class;

  TcxWebStyleItem = class(TComponent, IWebVariableName)
  private
    FClients: TList;
    FController: TcxWebStyleController;
    FCSSClassName: string;
    FCustomHTML: TStrings;
    FStyle: TcxWebStyle;

    function GetClient(Index: Integer): IcxWebStyleChanged;
    function GetClientCount: Integer;
    function GetIndex: Integer;
    procedure SetController(Value: TcxWebStyleController);
    procedure SetCustomHTML(Value: TStrings);
    procedure SetIndex(Value: Integer);
    procedure SetStyle(Value: TcxWebStyle);

    function IsClient(AComponent: IcxWebStyleChanged): Boolean;
    procedure UpdateDesigner;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;
    { IWebVariableName }
    function GetVariableName: string;
    function ImplGetVariableName: string; virtual;

    function GetFullName: string; virtual;
    procedure DesignerUpdate(TheAll: Boolean);
    procedure Changed;
    property Clients[Index: Integer]: IcxWebStyleChanged read GetClient;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    procedure RegisterClient(AComponent: IcxWebStyleChanged);
    procedure UnregisterClient(AComponent: IcxWebStyleChanged);
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);

    property ClientCount: Integer read GetClientCount;
    property Controller: TcxWebStyleController read FController write SetController;
    property FullName: string read GetFullName;
  published
    property CSSClassName: string read FCSSClassName write FCSSClassName;
    property CustomHTML: TStrings read FCustomHTML write SetCustomHTML;
    property Index: Integer read GetIndex write SetIndex stored False;
    property Style: TcxWebStyle read FStyle write SetStyle;
  end;


  TAbstractcxWebStyleControllerDesigner = class;

  TcxWebStyleController = class(TComponent, IcxStylesProvider,
      IWebVariableName)
  private
    FDesigner: TAbstractcxWebStyleControllerDesigner;
    FItems: TList;
    FCSSFileName: string;

    function GetCount: Integer;
    function GetItem(Index: Integer): TcxWebStyleItem;
    procedure SetItem(Index: Integer; Value: TcxWebStyleItem);

    procedure InsertItem(Value: TcxWebStyleItem);
    procedure MoveItem(ACurIndex, ANewIndex: Integer);
    procedure RemoveItem(Value: TcxWebStyleItem);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetName(const NewName: TComponentName); override;
    { IcxStylesProvider }
    procedure GetCSSFiles(HTMLTextBuilder: TcxHTMLTextBuilder; AList: TStrings);
    procedure WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    { IWebVariableName }
    function GetVariableName: string;
    function ImplGetVariableName: string; virtual;

    procedure DesignerModified;
    procedure DesignerUpdate(AItem: TcxWebStyleItem);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Add: TcxWebStyleItem;
    procedure AssignItems(ASource: TcxWebStyleController);
    procedure Clear;
    procedure Delete(AIndex: Integer);
    procedure GetStyleList(const AList: TList);
    function IndexOf(AItem: TcxWebStyleItem): Integer;
    function ItemByName(const AName: string): TcxWebStyleItem;

    property Count: Integer read GetCount;
    property Designer: TAbstractcxWebStyleControllerDesigner read FDesigner;
    property Items[Index: Integer]: TcxWebStyleItem read GetItem write SetItem; default;
  published
    property CSSFileName: string read FCSSFileName write FCSSFileName;
  end;


  //TODO: visited style

  TcxWebStyles = class(TPersistent)
  private
    FOwner: TComponent;
    FDefault: TcxWebStyleItem;
    FHover: TcxWebStyleItem;
    //FVisited: TcxWebStyleItem;

    procedure UpdateDesigner;

    procedure SetDefault(Value: TcxWebStyleItem);
    procedure SetHover(Value: TcxWebStyleItem);
    //procedure SetVisited(Value: TcxWebStyleItem);
  protected
    function GetItem(Index: Integer): TcxWebStyleItem; virtual;
    function GetOwner: TPersistent; override;
    function StyleChanged: IcxWebStyleChanged;
  public
    constructor Create(AOwner: TComponent);
    procedure Assign(Source: TPersistent); override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); virtual;

    function ItemCount: Integer; virtual;

    property Component: TComponent read FOwner;
    property Items[Index: Integer]: TcxWebStyleItem read GetItem;
  published
    property Default: TcxWebStyleItem read FDefault write SetDefault;
    property Hover: TcxWebStyleItem read FHover write SetHover;
    //property Visited: TcxWebStyleItem read FVisited write SetVisited;
  end;

  TAbstractcxWebStyleControllerDesigner = class
  private
    FController: TcxWebStyleController;
  protected
    procedure Modified; virtual; abstract;
    procedure Update(AItem: TcxWebStyleItem); virtual; abstract;
  public
    constructor Create(AController: TcxWebStyleController);
    destructor Destroy; override;

    procedure BeginUpdate; virtual; abstract;
    procedure CancelUpdate; virtual; abstract;
    procedure EndUpdate; virtual; abstract;

    property Controller: TcxWebStyleController read FController;
  end;

const
  bwThin = TcxWebBorderWidth(2);
  bwMedium = TcxWebBorderWidth(4);
  bwThick = TcxWebBorderWidth(6);

function cxWebWidthToString(Width: TcxWebBorderWidth): string;
function cxWebWidthToCursor(const S: string): TcxWebBorderWidth;
procedure cxWebGetWidthValues(Proc: TGetStrProc);
function cxWebWidthToIdent(Width: Longint; var Ident: string): Boolean;
function cxWebIdentToWidth(const Ident: string; var Width: Longint): Boolean;
function IsAnyBorderColorAssigned(ASyleItem: TcxWebStyleItem): Boolean;
function IsAnyBorderWidthAssigned(ASyleItem: TcxWebStyleItem): Boolean;
function IsAnyBorderStyleAssigned(ASyleItem: TcxWebStyleItem): Boolean;

implementation

uses
  SysUtils,
  cxWebScriptFactory, cxWebModule, cxWebConsts, cxWebUtils;

const
  scxLeft = 'left';
  scxTop = 'top';
  scxRight = 'right';
  scxBottom = 'bottom';
  scxBackgroundColor = 'background-color:';
  scxWebBorderStyles: array[TcxWebBorderStyle] of string =
  ('none', 'solid', 'dotted', 'dashed', 'double', 'groove', 'ridge', 'inset', 'outset');
  cxWebBorderWidths: array[0..2] of TIdentMapEntry = (
    (Value: bwThin; Name: 'thin'),
    (Value: bwMedium; Name: 'medium'),
    (Value: bwThick; Name: 'thick'));
  cxWebNumberingStyles: array[TcxWebNumberingStyle] of string =
  ('none', 'circle', 'disc', 'square', 'decimal', 'upper-roman', 'upper-alpha',
    'lower-alpha', 'lower-roman', '');
  cxWebNumberingPositions: array[TcxWebNumberingPosition] of string =
  ('inside', 'outside');

type
  PcxWebBrowserRecord = ^TcxWebBrowserRecord;
  TcxWebBrowserRecord = record
    Browser: TcxWebBrowserClass;
    RenderProc: TcxWebRenderProc;
  end;

function cxWebWidthToString(Width: TcxWebBorderWidth): string;
begin
  if not cxWebWidthToIdent(Width, Result) then
    FmtStr(Result, '%d', [Width]);
end;

function cxWebWidthToCursor(const S: string): TcxWebBorderWidth;
var
  L: Longint;
begin
  if not cxWebIdentToWidth(S, L) then
    L := StrToInt(S);
  Result := L;
end;

procedure cxWebGetWidthValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(cxWebBorderWidths) to High(cxWebBorderWidths) do
    Proc(cxWebBorderWidths[I].Name);
end;

function cxWebWidthToIdent(Width: Longint; var Ident: string): Boolean;
begin

  Result := IntToIdent(Width, Ident, cxWebBorderWidths);
end;

function cxWebIdentToWidth(const Ident: string; var Width: Longint): Boolean;
begin
  Result := IdentToInt(Ident, Width, cxWebBorderWidths);
end;

function IsAnyBorderStyleAssigned(ASyleItem: TcxWebStyleItem): Boolean;
begin
  if (ASyleItem <> nil) and not (csDestroying in ASyleItem.ComponentState) then
    Result := (wbavStyle in ASyleItem.Style.Borders.Left.AssignedValues) or
      ((wbavStyle in ASyleItem.Style.Borders.Top.AssignedValues)) or
      ((wbavStyle in ASyleItem.Style.Borders.Right.AssignedValues)) or
      ((wbavStyle in ASyleItem.Style.Borders.Bottom.AssignedValues))
  else
    Result := False;
end;

function IsAnyBorderWidthAssigned(ASyleItem: TcxWebStyleItem): Boolean;
begin
  if (ASyleItem <> nil) and not (csDestroying in ASyleItem.ComponentState) then
    Result := (wbavWidth in ASyleItem.Style.Borders.Left.AssignedValues) or
      ((wbavWidth in ASyleItem.Style.Borders.Top.AssignedValues)) or
      ((wbavWidth in ASyleItem.Style.Borders.Right.AssignedValues)) or
      ((wbavWidth in ASyleItem.Style.Borders.Bottom.AssignedValues))
  else
    Result := False;
end;

function IsAnyBorderColorAssigned(ASyleItem: TcxWebStyleItem): Boolean;
begin
  if ASyleItem <> nil then
    Result := (wbavColor in ASyleItem.Style.Borders.Left.AssignedValues) or
      ((wbavColor in ASyleItem.Style.Borders.Top.AssignedValues)) or
      ((wbavColor in ASyleItem.Style.Borders.Right.AssignedValues)) or
      ((wbavColor in ASyleItem.Style.Borders.Bottom.AssignedValues))
  else
    Result := False;
end;

type
  TPersistentAccess = class(TPersistent);
  TComponentAccess = class(TComponent);

{ TcxWebHelper }

constructor TcxWebHelper.Create(AComponent: TComponent);
begin
  FComponent := AComponent;
end;

{ TcxWebActionsHelper }

type
  PMethod = ^TMethod;

constructor TcxWebActionsHelper.Create(AComponent: TComponent);
begin
  inherited;
  FActions := TStringList.Create;
end;

destructor TcxWebActionsHelper.Destroy;
begin
  FActions.Free;
  inherited;
end;

procedure TcxWebActionsHelper.ClearActions;
var
  I: Integer;
begin
  for I := 0 to FActions.Count - 1 do
    Dispose(PMethod(FActions.Objects[I]));
  FActions.Clear;
end;

procedure TcxWebActionsHelper.RegisterAction(const ActionName: string; const Action: TcxWebComponentActionProc);
var
  Method: PMethod;
begin
  New(Method);
  Method^ := TMethod(Action);
  FActions.AddObject(ActionName, TObject(Method));
end;

procedure TcxWebActionsHelper.DoPerformAction(const ActionName: string; const ActionParameters: TcxActionParameters);
var
  Index: Integer;
  Method: TcxWebComponentActionProc;
begin
  Index := FActions.IndexOf(ActionName);
  if Index <> -1 then
  begin
    TMethod(Method) := PMethod(FActions.Objects[Index])^;
    if Assigned(Method) then
    begin
      Method(ActionParameters);
    end;
  end;
end;

{ TcxCustomEventItem }

constructor TcxCustomEventItem.Create(Collection: TCollection);
begin
  inherited;
  FHandlerText := TStringList.Create;
  FEventProcType := etProcedure;
end;

destructor TcxCustomEventItem.Destroy;
begin
  FHandlerText.Free;
  inherited;
end;

function TcxCustomEventItem.GetDisplayName: string;
begin
  Result := GetEnumName(TcxCustomEvents(Collection).EventsHelper.EventTypeInfo, EventType);
end;

procedure TcxCustomEventItem.SetHandlerText(Value: TStrings);
begin
  FHandlerText.Assign(Value);
end;

{ TcxCustomEvents }

constructor TcxCustomEvents.Create(AEventsHelper: TcxWebEventsHelper);
begin
  FEventsHelper := AEventsHelper;
  inherited Create(TcxCustomEventItem);
end;

function TcxCustomEvents.GetItem(Index: Integer): TcxCustomEventItem;
begin
  Result := TcxCustomEventItem(inherited Items[Index]);
end;

procedure TcxCustomEvents.SetItem(Index: Integer; Value: TcxCustomEventItem);
begin
  Items[Index].Assign(Value);
end;

function TcxCustomEvents.GetOwner: TPersistent;
begin
  if FEventsHelper <> nil then
    Result := FEventsHelper.Component
  else Result := nil;
end;

function TcxCustomEvents.Add: TcxCustomEventItem;
begin
  Result := TcxCustomEventItem(inherited Add);
end;

{ TcxWebEventsHelper }

constructor TcxWebEventsHelper.Create(AComponent: TComponent);
begin
  inherited;
  FEvents := TcxCustomEvents.Create(Self);
  FCustomEvents := TcxCustomEvents.Create(Self);
end;

destructor TcxWebEventsHelper.Destroy;
begin
  FCustomEvents.Free;
  FEvents.Free;
  inherited;
end;

procedure TcxWebEventsHelper.ClearEvents;
begin
  FEvents.Clear;
end;

procedure TcxWebEventsHelper.FindEvents(const AEvent: Integer; AList: TList);
var
  I: Integer;
begin
  for I := 0 to FCustomEvents.Count - 1 do
    if CustomEvents[I].EventType = AEvent then
      AList.Add(CustomEvents[I]);
  for I := 0 to FEvents.Count - 1 do
    if FEvents[I].EventType = AEvent then
      AList.Add(FEvents[I]);
end;

procedure TcxWebEventsHelper.WriteEvent(AHTMLTextBuilder: TcxHTMLTextBuilder; AList: TList);
var
  EventItem: TcxCustomEventItem;
  Text: string;
begin
  if AList.Count <> 0 then
  begin
    EventItem := TcxCustomEventItem(AList[0]);
    if (AList.Count = 1) and (EventItem.EventProcType = etSingleLine) then
    begin
      Text := StringReplace(EventItem.HandlerText.Text, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
      if Text <> '' then
        AHTMLTextBuilder.WriteUnknownAttribute(EventName(EventItem.EventType), Text);
    end
    else AHTMLTextBuilder.WriteUnknownAttribute(EventName(EventItem.EventType),
      EventProc(EventItem.EventType));
  end;
end;

procedure TcxWebEventsHelper.WriteEventScript(AHTMLTextBuilder: TcxHTMLTextBuilder; AList: TList);
var
  I: Integer;
  Text: string;
begin
  if AList.Count <> 0 then
  begin
    if (AList.Count > 1) or (TcxCustomEventItem(AList[0]).EventProcType = etProcedure) then
    begin
      AHTMLTextBuilder.WriteText(Format('function %s',
          [EventProc(TcxCustomEventItem(AList[0]).EventType)]));
      AHTMLTextBuilder.WriteText('{');
      for I := 0 to AList.Count - 1 do
      begin
        Text := TcxCustomEventItem(AList[I]).HandlerText.Text;
        AHTMLTextBuilder.WriteText(Text);
      end;
      AHTMLTextBuilder.WriteText('}');
    end;
  end;
end;

procedure TcxWebEventsHelper.WriteEvents(AHTMLTextBuilder: TcxHTMLTextBuilder);
var
  Event: Integer;
  List: TList;
begin
  List := TList.Create;
  try
    for Event := MinEventValue to MaxEventValue do
    begin
      FindEvents(Event, List);
      if List.Count > 0 then WriteEvent(AHTMLTextBuilder, List);
      List.Clear;
    end;
  finally
    List.Free;
  end;
end;

procedure TcxWebEventsHelper.WriteEventsScript(AHTMLTextBuilder: TcxHTMLTextBuilder);
var
  Event: Integer;
  List: TList;
begin
  List := TList.Create;
  try
    for Event := MinEventValue to MaxEventValue do
    begin
      FindEvents(Event, List);
      if List.Count > 0 then WriteEventScript(AHTMLTextBuilder, List);
      List.Clear;
    end;
  finally
    List.Free;
  end;
end;


function TcxWebEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxHTMLEvent] of string =
      ('onblur', 'onchange', 'onclick', 'ondblclick', 'ondragstart', 'ondragend',
      'onfocus', 'onkeypress', 'onload', 'onmousedown', 'onmousemove', 'onmouseover',
      'onmouseout', 'onmouseup', 'onselect', 'onselectstart', 'onunload', 'onpropertychange');
begin
  Result := cxHTMLEvent[TcxHTMLEvent(AEvent)];
end;

function TcxWebEventsHelper.EventProc(const AEvent: Integer): string;
begin
  Result := EventProcName(AEvent) + EventProcParams(AEvent);
end;

function TcxWebEventsHelper.EventProcName(const AEvent: Integer): string;
begin
  Result := '__' + Component.Name + EventName(AEvent);
end;

function TcxWebEventsHelper.EventProcParams(const AEvent: Integer): string;
begin
  Result := '(event)';
end;

function TcxWebEventsHelper.MaxEventValue: Integer;
begin
  Result := GetTypeData(EventTypeInfo)^.MaxValue;
end;

function TcxWebEventsHelper.MinEventValue: Integer;
begin
  Result := GetTypeData(EventTypeInfo)^.MinValue;
end;

function TcxWebEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxHTMLEvent);
end;

procedure TcxWebEventsHelper.RegisterEvent(const AEvent: TcxHTMLEvent;
  const AEventProc: TcxWebComponentEventProc;
  const AEventProcType: TcxWebComponentEventProcType);
var
  AHandlerText: string;
begin
  if TypeInfo(TcxHTMLEvent) <> EventTypeInfo then exit;
  with FEvents.Add do
  begin
    EventType := Integer(AEvent);
    AEventProc(AHandlerText);
    HandlerText.Text := AHandlerText;
    EventProcType := AEventProcType
  end;
end;

{ TcxWebScriptEventsHelper }

function TcxWebScriptEventsHelper.ScriptObject: string;
begin
  Result := '';
end;

procedure TcxWebScriptEventsHelper.WriteEvent(AHTMLTextBuilder: TcxHTMLTextBuilder; AList: TList);
var
  EventItem: TcxCustomEventItem;
  Text, HandlerText: string;
begin
  if AList.Count <> 0 then
  begin
    EventItem := TcxCustomEventItem(AList[0]);
    if (AList.Count = 1) and (EventItem.EventProcType = etSingleLine) then
    begin
      HandlerText := 'function ' + EventProc(EventItem.EventType) + ' { ' + EventItem.HandlerText.Text + ' } ';
      HandlerText := StringReplace(HandlerText, #13#10, '', [rfReplaceAll]);
    end
    else HandlerText := EventProcName(EventItem.EventType) + ';';

    Text := '  ' + ScriptObject + '.' + EventName(EventItem.EventType) + ' = ' + HandlerText;
    AHTMLTextBuilder.WriteText(Text);
    AHTMLTextBuilder.WriteText('');
  end;
end;

{ TcxWebRenderHelper }

constructor TcxWebRenderHelper.Create(AComponent: TComponent);
begin
  inherited;
  FRenderers := TClassList.Create;
end;

destructor TcxWebRenderHelper.Destroy;
begin
  FRenderers.Free;
  inherited;
end;

procedure TcxWebRenderHelper.ClearEvents;
var
  EventsIntf: IcxWebEvents;
begin
  if Component.GetInterface(IcxWebEvents, EventsIntf) then
    EventsIntf.ClearEvents;
end;

procedure TcxWebRenderHelper.RegisterEvents;
var
  EventsIntf: IcxWebEvents;
begin
  if Component.GetInterface(IcxWebEvents, EventsIntf) then
    EventsIntf.RegisterEvents;
end;

procedure TcxWebRenderHelper.DoAfterRender;
begin
  if Assigned(FOnAfterRender) then FOnAfterRender(Component);
  ClearEvents;
end;

procedure TcxWebRenderHelper.DoBeforeRender;
begin
  RegisterEvents;
  if Assigned(FOnBeforeRender) then FOnBeforeRender(Component);
end;

function TcxWebRenderHelper.GetRenderer(AHTMLTextBuilder: TcxHTMLTextBuilder): TcxWebRenderer;
var
  RenderClass: TcxWebRendererClass;
begin
  RenderClass := GetRendererClass(AHTMLTextBuilder.Browser);
  if RenderClass <> nil then
    Result := RenderClass.Create(Component, AHTMLTextBuilder)
  else Result := TcxWebRenderer.Create(Component, AHTMLTextBuilder);
end;

function TcxWebRenderHelper.GetRendererClass(Browser: TcxWebBrowserClass): TcxWebRendererClass;
var
  I: Integer;
begin
  Result := WebRendererFactory.FindRenderer(TComponentClass(Component.ClassType), Browser);
  if Result = nil then
    for I := FRenderers.Count - 1 downto 0 do
      if TcxWebRendererClass(FRenderers.Items[I]).IsBrowserSupported(Browser) then
      begin
        Result := TcxWebRendererClass(FRenderers.Items[I]);
        break;
      end;
end;

procedure TcxWebRenderHelper.RegisterRenderer(ARendererClass: TcxWebRendererClass);
begin
  FRenderers.Add(ARendererClass);
end;

procedure TcxWebRenderHelper.ClearRenderers;
begin
  FRenderers.Clear;
end;

{ IcxCodeProvider }

procedure TcxWebRenderHelper.GetScriptFiles(HTMLTextBuilder: TcxHTMLTextBuilder; AList: TStrings);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.GetScriptFiles(AList);
  Renderer.Free;
end;

procedure TcxWebRenderHelper.WriteClassScripts(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteClassScripts(HTMLTextBuilder);
  Renderer.Free;
end;

procedure TcxWebRenderHelper.WriteBeginHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  DoBeforeRender;
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteBeginHTML;
  Renderer.Free;
end;

procedure TcxWebRenderHelper.WriteClassHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteClassHTML(HTMLTextBuilder);
  Renderer.Free;
end;

procedure TcxWebRenderHelper.WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteHiddenFormElements;
  Renderer.Free;
end;

procedure TcxWebRenderHelper.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  DoBeforeRender;
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteHTML;
  Renderer.Free;
  DoAfterRender;
end;

procedure TcxWebRenderHelper.WriteEndHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteEndHTML;
  Renderer.Free;
  DoAfterRender;
end;

procedure TcxWebRenderHelper.WriteClassOutOfFormHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteClassOutOfFormHTML(HTMLTextBuilder);
  Renderer.Free;
end;

procedure TcxWebRenderHelper.WriteOutOfFormHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteOutOfFormHTML;
  Renderer.Free;
end;

procedure TcxWebRenderHelper.WriteScripts(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  RegisterEvents;
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteScripts;
  Renderer.Free;
  ClearEvents;
end;

procedure TcxWebRenderHelper.WriteXML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteXML;
  Renderer.Free;
end;

{ IcxStylesProvider }
procedure TcxWebRenderHelper.WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebRenderer;
begin
  Renderer := GetRenderer(HTMLTextBuilder);
  Renderer.WriteStyles(HTMLTextBuilder);
  Renderer.Free;
end;

{ TcxWebScriptsHelper }

constructor TcxWebScriptsHelper.Create(AComponent: TComponent);
begin
  inherited;
  FScripts := TClassList.Create;
end;

destructor TcxWebScriptsHelper.Destroy;
begin
  FScripts.Free;
  inherited;
end;

procedure TcxWebScriptsHelper.ScriptSubscription(const AClass: TClass);
begin
  WebScriptFactory.Subscribe(TcxWebScriptClass(AClass));
  if FScripts.IndexOf(AClass) = -1 then
    FScripts.Add(AClass);
end;

{ TcxWebValuesHelper }

constructor TcxWebValuesHelper.Create(AComponent: TComponent);
begin
  inherited;
  FValues := TStringList.Create;
end;

destructor TcxWebValuesHelper.Destroy;
begin
  FValues.Free;
  inherited;
end;

function TcxWebValuesHelper.GetValues: TStrings;
begin
  Result := FValues;
end;

procedure TcxWebValuesHelper.RegisterValue(const AName: string; AValue: string);
begin
  FValues.Add(AName + '=' + AValue);
end;

{ TcxWebComponent }

constructor TcxWebComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStyles := TcxWebStyles.Create(Self);
  FWebComponentState := [wcsLoading];
  RegisterRenderers;
end;

destructor TcxWebComponent.Destroy;
begin
  FStyles.Free;
  WebRenderHelper.ClearRenderers;
  FreeAndNil(FWebActionsHelper);
  FreeAndNil(FWebEventsHelper);
  FreeAndNil(FWebRenderHelper);
  FreeAndNil(FWebScriptsHelper);
  FreeAndNil(FWebValuesHelper);
  inherited Destroy;
end;

procedure TcxWebComponent.Loaded;
begin
  inherited;
end;

procedure TcxWebComponent.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if not IsDestroying and (AComponent is TcxWebStyleItem) then
    Styles.Notification(AComponent, Operation);
end;

{ actions }

procedure TcxWebComponent.DoAfterPerformActions;
begin
end;

procedure TcxWebComponent.RegisterActions;
begin
end;

function TcxWebComponent.GetWebActionsHelper: TcxWebActionsHelper;
begin
  if FWebActionsHelper = nil then
    FWebActionsHelper := TcxWebActionsHelper.Create(Self);
  Result := FWebActionsHelper;
end;

{ renderers }
procedure TcxWebComponent.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebRenderer);
end;

{ events }
procedure TcxWebComponent.RegisterEvents;
begin
  if Styles.Hover <> nil then
  begin
    WebEventsHelper.RegisterEvent(eOnMouseOut, GetDefaultStyleProc, etSingleLine);
    WebEventsHelper.RegisterEvent(eOnMouseOver, GetHoverStyleProc, etSingleLine);
  end;
end;

class function TcxWebComponent.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebEventsHelper;
end;

function TcxWebComponent.GetWebEventsHelper: TcxWebEventsHelper;
begin
  if FWebEventsHelper = nil then
    FWebEventsHelper := GetWebEventsHelperClass.Create(Self);
  Result := FWebEventsHelper;
end;

{ IcxCodeProvider }
function TcxWebComponent.GetWebRenderHelper: TcxWebRenderHelper;
begin
  if FWebRenderHelper = nil then
  begin
    FWebRenderHelper := TcxWebRenderHelper.Create(Self);
    FWebRenderHelper.OnAfterRender := DoAfterRenderProc;
    FWebRenderHelper.OnBeforeRender := DoBeforeRenderProc;
  end;
  Result := FWebRenderHelper;
end;

{ scripts }
procedure TcxWebComponent.ScriptsSubscription;
begin
  if TcxWebStyles(Styles).Hover <> nil then
    WebScriptsHelper.ScriptSubscription(TcxWebChangeStyleScript);
end;

function TcxWebComponent.GetWebScriptsHelper: TcxWebScriptsHelper;
begin
  if FWebScriptsHelper = nil then
    FWebScriptsHelper := TcxWebScriptsHelper.Create(Self);
  Result := FWebScriptsHelper;
end;

{ IcxWebProvidersSupport}
procedure TcxWebComponent.GetProviders(AList: TList);
begin
  ImplGetProviders(AList);
end;

procedure TcxWebComponent.ImplGetProviders(AList: TList);
begin
  AddStylesToProviderList(AList, [Styles]);
end;

procedure TcxWebComponent.AddStylesToProviderList(AList: TList; AStylesArray: Array of TcxWebStyles);

  procedure AddStyleToProviderList(AStyles: TcxWebStyles);
  var
    I: Integer;
    AStyleController: TComponent;
  begin
    for I := 0 to AStyles.ItemCount - 1 do
    begin
      if AStyles.Items[I] <> nil then
      begin
        AStyleController := AStyles.Items[I].Controller;
        if AList.IndexOf(AStyleController) < 0 then
          AList.Add(AStyleController);
      end;
    end;
  end;

var
  I: Integer;
begin
  for I := Low(AStylesArray) to High(AStylesArray) do
     AddStyleToProviderList(AStylesArray[I]);
end;

{ styles }

procedure TcxWebComponent.StyleChanged(Style: TcxWebStyleItem);
begin
end;

{ values }

function TcxWebComponent.CanSetValues: Boolean;
begin
  Result := True;
end;

procedure TcxWebComponent.DoSetValues;
begin
end;

procedure TcxWebComponent.DoAfterSetValues;
begin
end;

procedure TcxWebComponent.RegisterValues;
begin
end;


function TcxWebComponent.GetWebValuesHelper: TcxWebValuesHelper;
begin
  if FWebValuesHelper = nil then
    FWebValuesHelper := TcxWebValuesHelper.Create(Self);
  Result := FWebValuesHelper;
end;

{ IWebVariableName }

function TcxWebComponent.GetVariableName: string;
begin
  Result := ImplGetVariableName;
end;

function TcxWebComponent.ImplGetVariableName: string;
begin
  Result := Self.Name;
end;

function TcxWebComponent.GetState: TcxWebComponentStates;
begin
  Result := FWebComponentState;
end;

procedure TcxWebComponent.SetState(Value: TcxWebComponentStates);
begin
  FWebComponentState := Value;
end;

{ design - time support }

function TcxWebComponent.IsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState) or ((Owner <> nil) and (csDesigning in Owner.ComponentState));
end;

function TcxWebComponent.IsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxWebComponent.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TcxWebComponent.GetWebRendererClass(ABrowser: TcxWebBrowserClass): TcxWebRendererClass;
begin
  Result := WebRenderHelper.GetRendererClass(ABrowser);
end;

function TcxWebComponent.GetCustomEvents: TcxCustomEvents;
begin
  Result := WebEventsHelper.CustomEvents;
end;

procedure TcxWebComponent.DoBeforeRenderProc(Sender: TObject);
begin
  DoBeforeRender;
end;

procedure TcxWebComponent.DoAfterRenderProc(Sender: TObject);
begin
  DoAfterRender;
end;

procedure TcxWebComponent.DoBeforeRender;
begin
  if Assigned(onBeforeRender) then
    onBeforeRender(self);
end;

procedure TcxWebComponent.DoAfterRender;
begin
  if Assigned(onAfterRender) then
    onAfterRender(self);
end;

procedure TcxWebComponent.SetCustomEvents(Value: TcxCustomEvents);
begin
  WebEventsHelper.CustomEvents := Value;
end;

function TcxWebComponent.GetStyles: TcxWebStyles;
begin
  if FStyles = nil then
    FStyles := TcxWebStyles.Create(Self);
  Result := FStyles;
end;

procedure TcxWebComponent.SetStyles(Value: TcxWebStyles);
begin
  Styles.Assign(Value);
end;

function TcxWebComponent.GetStyleItem_Default: TcxWebStyleItem;
begin
  Result := Styles.Default;
end;

function TcxWebComponent.GetStyleItem_Hover: TcxWebStyleItem;
begin
  Result := Styles.Hover;
end;

procedure TcxWebComponent.SetStyleItem_Default(Value: TcxWebStyleItem);
begin
  Styles.Default := Value;;
end;

procedure TcxWebComponent.SetStyleItem_Hover(Value: TcxWebStyleItem);
begin
  Styles.Hover := Value;
end;

procedure TcxWebComponent.GetDefaultStyleProc(var AScript: string);
begin
  AScript := TcxWebComponentRenderer.GetDefaultStyleProc(Styles.Default);
end;

procedure TcxWebComponent.GetHoverStyleProc(var AScript: string);
begin
  AScript := TcxWebComponentRenderer.GetHoverStyleProc(Styles.Hover);
end;

{ TcxWebComponentRenderer }

function TcxWebComponentRenderer.GetWebComponent: TcxWebComponent;
begin
  Result := Component as TcxWebComponent;
end;

class function TcxWebComponentRenderer.GetDefaultStyleProc(AStyle: TcxWebStyleItem): string;
begin
  Result := '__ChangeStyle(event, this);';
end;

class function TcxWebComponentRenderer.GetHoverStyleProc(AStyle: TcxWebStyleItem): string;
begin
  if AStyle <> nil then
    Result := Format('__ChangeStyle(event, this, ''%s'');', [AStyle.FullName])
  else Result := '';
end;

procedure TcxWebComponentRenderer.WriteDefaultStyle;
begin
  if WebComponent.Styles.Default <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, WebComponent.Styles.Default.FullName);
end;

procedure TcxWebComponentRenderer.WriteEvents;
begin
  WebComponent.WebEventsHelper.WriteEvents(HTMLTextBuilder);
end;

procedure TcxWebComponentRenderer.WriteEventsScript;
begin
  WebComponent.WebEventsHelper.WriteEventsScript(HTMLTextBuilder);
end;

class procedure TcxWebComponentRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
end;

procedure TcxWebComponentRenderer.WriteScripts;
begin
  WriteEventsScript;
end;

{ TcxURL }

constructor TcxURL.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
end;

procedure TcxURL.Assign(Source: TPersistent);
begin
  if Source is TcxURL then
  begin
    Href := TcxURL(Source).Href;
    Target := TcxURL(Source).Target;
  end
  else inherited;
end;

procedure TcxURL.Write(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if Href <> '' then
  begin
    AHTMLTextBuilder.WriteAttribute(aHref, Href);
    if Target <> '' then AHTMLTextBuilder.WriteAttribute(aTarget, Target);
  end;
end;

procedure TcxURL.UpdateOwner;
var
  AControl: IcxWebControl;
begin
  if (Owner <> nil) and not (csDestroying in Owner.ComponentState) then
    if Supports(Owner, IcxWebControl, AControl) and (AControl.DesignerControl <> nil) then
      AControl.DesignerControl.UpdateContext;
end;

procedure TcxURL.SetHref(Value: string);
begin
  if FHref <> Value then
  begin
    FHref := Value;
    UpdateOwner;
  end;
end;

procedure TcxURL.SetTarget(Value: string);
begin
  if FTarget <> Value then
  begin
    FTarget := Value;
    UpdateOwner;
  end;
end;

{  TcxWebStyleObject }

constructor TcxWebStyleObject.Create(AWebStyle: TBasecxWebStyle);
begin
  inherited Create;
  DoRestoreDefaults;
  FWebStyle := AWebStyle;
end;

procedure TcxWebStyleObject.BeginUpdate;
begin
  if WebStyle <> nil then
    WebStyle.BeginUpdate;
end;

procedure TcxWebStyleObject.EndUpdate;
begin
  if WebStyle <> nil then
    WebStyle.EndUpdate;
end;

procedure TcxWebStyleObject.RestoreDefaults;
begin
  BeginUpdate;
  try
    DoRestoreDefaults;
  finally
    EndUpdate;
  end;
end;

function TcxWebStyleObject.CanAssignValue: Boolean;
begin
  Result := WebStyle <> nil;
  if Result and (WebStyle.GetOwner <> nil) then
    Result := not (csLoading in (WebStyle.GetOwner as TComponent).ComponentState);
end;

procedure TcxWebStyleObject.Changed;
begin
  if WebStyle <> nil then
    WebStyle.Changed;
end;

procedure TcxWebStyleObject.DoRestoreDefaults;
begin
end;

{ TcxWebBorder }

constructor TcxWebBorder.Create(ABorders: TcxWebBorders);
begin
  inherited Create;
  RestoreDefaults;
  FBorders := ABorders;
end;

procedure TcxWebBorder.Assign(Source: TPersistent);
begin
  if Source is TcxWebBorder then
  begin
    if Borders <> nil then Borders.BeginUpdate;
    try
      Color := TcxWebBorder(Source).Color;
      Style := TcxWebBorder(Source).Style;
      Width := TcxWebBorder(Source).Width;
      AssignedValues := TcxWebBorder(Source).AssignedValues;
    finally
      if Borders <> nil then Borders.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxWebBorder.Merge(Source: TcxWebBorder);
begin
  if Borders <> nil then Borders.BeginUpdate;
  try
    if not (wbavColor in AssignedValues) and
      (wbavColor in Source.AssignedValues) then
    begin
      Color := Source.Color;
      AssignedValues := AssignedValues + [wbavColor];
    end;
    if not (wbavStyle in AssignedValues) and
      (wbavStyle in Source.AssignedValues) then
    begin
      Style := Source.Style;
      AssignedValues := AssignedValues + [wbavStyle];
    end;
    if not (wbavWidth in AssignedValues) and
      (wbavWidth in Source.AssignedValues) then
    begin
      Width := Source.Width;
      AssignedValues := AssignedValues + [wbavWidth];
    end;
  finally
    if Borders <> nil then Borders.EndUpdate;
  end;
end;


procedure TcxWebBorder.RestoreDefaults;
begin
  Color := cxclDefaultStyleBorderColor;
  Style := wbsNone;
  Width := 2;
  AssignedValues := [];
end;

procedure TcxWebBorder.Changed;
begin
  if Borders <> nil then
    Borders.Changed;
end;

function TcxWebBorder.IsColorStored: Boolean;
begin
  Result := (Borders = nil) or not Borders.SameColors;
end;

function TcxWebBorder.IsStyleStored: Boolean;
begin
  Result := (Borders = nil) or not Borders.SameStyles;
end;

function TcxWebBorder.IsWidthStored: Boolean;
begin
  Result := (Borders = nil) or not Borders.SameWidths;
end;

procedure TcxWebBorder.SetAssignedValues(Value: TcxWebBorderAssignedValues);
begin
  if FAssignedValues <> Value then
  begin
    FAssignedValues := Value;
    Changed;    
  end;
end;

procedure TcxWebBorder.SetColor(Value: TcxWebColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if (Borders <> nil) and Borders.CanAssignValue then
      AssignedValues := AssignedValues + [wbavColor];
    Changed;
  end;
end;

procedure TcxWebBorder.SetStyle(Value: TcxWebBorderStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    if (Borders <> nil) and Borders.CanAssignValue then
      AssignedValues := AssignedValues + [wbavStyle];
    Changed;
  end;
end;

procedure TcxWebBorder.SetWidth(Value: TcxWebBorderWidth);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    if (Borders <> nil) and Borders.CanAssignValue then
      AssignedValues := AssignedValues + [wbavWidth];
    Changed;
  end;
end;

{ TcxWebBorders }

constructor TcxWebBorders.Create(AWebStyle: TBasecxWebStyle);
begin
  FBottom := TcxWebBorder.Create(Self);
  FLeft := TcxWebBorder.Create(Self);
  FRight := TcxWebBorder.Create(Self);
  FTop := TcxWebBorder.Create(Self);
  inherited Create(AWebStyle);
end;

destructor TcxWebBorders.Destroy;
begin
  FBottom.Free;
  FLeft.Free;
  FRight.Free;
  FTop.Free;
  inherited;
end;

procedure TcxWebBorders.Assign(Source: TPersistent);
begin
  if Source is TcxWebBorders then
  begin
    BeginUpdate;
    try
      Bottom := TcxWebBorders(Source).Bottom;
      Left := TcxWebBorders(Source).Left;
      Right := TcxWebBorders(Source).Right;
      Top := TcxWebBorders(Source).Top;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxWebBorders.Merge(Source: TcxWebBorders);
begin
  BeginUpdate;
  try
    Bottom.Merge(Source.Bottom);
    Left.Merge(Source.Left);
    Right.Merge(Source.Right);
    Top.Merge(Source.Top);
  finally
    EndUpdate;
  end;
end;

function TcxWebBorders.SameColors: Boolean;
begin
  Result := (Left.Color = Top.Color) and (Top.Color = Right.Color) and
    (Right.Color = Bottom.Color);
end;

function TcxWebBorders.SameStyles: Boolean;
begin
  Result := (Left.Style = Top.Style) and (Top.Style = Right.Style) and
    (Right.Style = Bottom.Style);
end;

function TcxWebBorders.SameWidths: Boolean;
begin
  Result := (Left.Width = Top.Width) and (Top.Width = Right.Width) and
    (Right.Width = Bottom.Width);
end;

function TcxWebBorders.HorzBordersSize: Integer;
begin
  Result := 0;
  if wbavWidth in Left.AssignedValues then
    Inc(Result, Left.Width);
  if wbavWidth in Right.AssignedValues then
    Inc(Result, Right.Width);
end;

function TcxWebBorders.VertBordersSize: Integer;
begin
  Result := 0;
  if wbavWidth in Top.AssignedValues then
    Inc(Result, Top.Width);
  if wbavWidth in Bottom.AssignedValues then
    Inc(Result, Bottom.Width);
end;

procedure TcxWebBorders.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if SameColors and (wbavColor in Bottom.AssignedValues) then
    HTMLTextBuilder.WriteStyleAttribute(saBorderColor, cxWebColorToWebString(Bottom.Color))
  else
  begin
    if wbavColor in Bottom.AssignedValues then
      HTMLTextBuilder.WriteStyleAttribute(saBorderBottomColor, cxWebColorToWebString(Bottom.Color));
    if wbavColor in Left.AssignedValues then
      HTMLTextBuilder.WriteStyleAttribute(saBorderLeftColor, cxWebColorToWebString(Left.Color));
    if wbavColor in Right.AssignedValues then
      HTMLTextBuilder.WriteStyleAttribute(saBorderRightColor, cxWebColorToWebString(Right.Color));
    if wbavColor in Top.AssignedValues then
      HTMLTextBuilder.WriteStyleAttribute(saBorderTopColor, cxWebColorToWebString(Top.Color));
  end;
  if SameStyles and (wbavStyle in Bottom.AssignedValues) then
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, scxWebBorderStyles[Bottom.Style])
  else
  begin
    if wbavStyle in Bottom.AssignedValues then
      HTMLTextBuilder.WriteStyleAttribute(saBorderBottomStyle, scxWebBorderStyles[Bottom.Style]);
    if wbavStyle in Left.AssignedValues then
      HTMLTextBuilder.WriteStyleAttribute(saBorderLeftStyle, scxWebBorderStyles[Left.Style]);
    if wbavStyle in Right.AssignedValues then
      HTMLTextBuilder.WriteStyleAttribute(saBorderRightStyle, scxWebBorderStyles[Right.Style]);
    if wbavStyle in Top.AssignedValues then
      HTMLTextBuilder.WriteStyleAttribute(saBorderTopStyle, scxWebBorderStyles[Top.Style]);
  end;
  if SameWidths and (wbavWidth in Bottom.AssignedValues) then
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, Bottom.Width, 'px')
  else
  begin
    if (wbavWidth in Bottom.AssignedValues) then
      HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, Bottom.Width, 'px');
    if (wbavWidth in Left.AssignedValues) then
      HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, Left.Width, 'px');
    if (wbavWidth in Right.AssignedValues) then
      HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, Right.Width, 'px');
    if (wbavWidth in Top.AssignedValues) then
      HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, Top.Width, 'px');
  end;
end;

procedure TcxWebBorders.DoRestoreDefaults;
begin
  Bottom.RestoreDefaults;
  Left.RestoreDefaults;
  Right.RestoreDefaults;
  Top.RestoreDefaults;
end;

function TcxWebBorders.GetColor: TcxWebColor;
begin
  Result := FLeft.Color;
end;

function TcxWebBorders.GetStyle: TcxWebBorderStyle;
begin
  Result := FLeft.Style;
end;

function TcxWebBorders.GetWidth: TcxWebBorderWidth;
begin
  Result := FLeft.Width;
end;

function TcxWebBorders.IsColorStored: Boolean;
begin
  Result := SameColors;
end;

function TcxWebBorders.IsStyleStored: Boolean;
begin
  Result := SameStyles;
end;

function TcxWebBorders.IsWidthStored: Boolean;
begin
  Result := SameWidths;
end;

procedure TcxWebBorders.SetBottom(Value: TcxWebBorder);
begin
  Bottom.Assign(Value);
end;

procedure TcxWebBorders.SetColor(Value: TcxWebColor);
begin
  BeginUpdate;
  try
    Bottom.Color := Value;
    Left.Color := Value;
    Right.Color := Value;
    Top.Color := Value;
  finally
    EndUpdate;
  end;
end;

procedure TcxWebBorders.SetLeft(Value: TcxWebBorder);
begin
  Left.Assign(Value);
end;

procedure TcxWebBorders.SetRight(Value: TcxWebBorder);
begin
  Right.Assign(Value);
end;

procedure TcxWebBorders.SetStyle(Value: TcxWebBorderStyle);
begin
  BeginUpdate;
  try
    Bottom.Style := Value;
    Left.Style := Value;
    Right.Style := Value;
    Top.Style := Value;
  finally
    EndUpdate;
  end;
end;

procedure TcxWebBorders.SetTop(Value: TcxWebBorder);
begin
  Top.Assign(Value);
end;

procedure TcxWebBorders.SetWidth(Value: TcxWebBorderWidth);
begin
  BeginUpdate;
  try
    Bottom.Width := Value;
    Left.Width := Value;
    Right.Width := Value;
    Top.Width := Value;
  finally
    EndUpdate;
  end;
end;

{ TcxWebNumbering }

procedure TcxWebNumbering.Assign(Source: TPersistent);
begin
  if Source is TcxWebNumbering then
  begin
    BeginUpdate;
    try
      Style := TcxWebNumbering(Source).Style;
      Position := TcxWebNumbering(Source).Position;
      AssignedValues := TcxWebNumbering(Source).AssignedValues;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxWebNumbering.Merge(Source: TcxWebNumbering);
begin
  BeginUpdate;
  try
    if not (wnavStyle in AssignedValues) and
      (wnavStyle in Source.AssignedValues) then
    begin
      Style := Source.Style;
      AssignedValues := AssignedValues + [wnavStyle];
    end;
    if not (wnavPosition in AssignedValues) and
      (wnavPosition in Source.AssignedValues) then
    begin
      Position := Source.Position;
      AssignedValues := AssignedValues + [wnavPosition];
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxWebNumbering.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if wnavStyle in AssignedValues then
    if Style < wnsPicture then
      HTMLTextBuilder.WriteStyleAttribute(saListStyleType, cxWebNumberingStyles[Style])
    else
      HTMLTextBuilder.WriteStyleAttribute(saListStyleImage, 'url(' + Picture + ')');
  if wnavPosition in AssignedValues then
    HTMLTextBuilder.WriteStyleAttribute(saListStylePosition, cxWebNumberingPositions[Position]);
end;

procedure TcxWebNumbering.DoRestoreDefaults;
begin
  Position := wnpOutside;
  Style := wnsNone;
  AssignedValues := [];
end;

procedure TcxWebNumbering.SetAssignedValues(Value: TcxWebNumberingAssignedValues);
begin
  if FAssignedValues <> Value then
    FAssignedValues := Value;
end;

procedure TcxWebNumbering.SetPicture(const Value: string);
begin
  FPicture := Value;
end;

procedure TcxWebNumbering.SetPosition(Value: TcxWebNumberingPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    if CanAssignValue then
      AssignedValues := AssignedValues + [wnavPosition];
    Changed;
  end;
end;

procedure TcxWebNumbering.SetStyle(Value: TcxWebNumberingStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    if CanAssignValue then
      AssignedValues := AssignedValues + [wnavStyle];
    Changed;
  end;
end;

{ TcxWebShading }

procedure TcxWebShading.Assign(Source: TPersistent);
begin
  if Source is TcxWebShading then
  begin
    BeginUpdate;
    try
      Color := TcxWebShading(Source).Color;
      AssignedValues := TcxWebShading(Source).AssignedValues;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxWebShading.Merge(Source: TcxWebShading);
begin
  BeginUpdate;
  try
    if not (wsavColor in AssignedValues) and
      (wsavColor in Source.AssignedValues) then
    begin
      Color := Source.Color;
      AssignedValues := AssignedValues + [wsavColor];
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxWebShading.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if wsavColor in AssignedValues then
    HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, cxWebColorToWebString(Color));
end;

procedure TcxWebShading.DoRestoreDefaults;
begin
  Color := cxclDefaultStyleBkColor;
  AssignedValues := [];
end;

procedure TcxWebShading.SetAssignedValues(Value: TcxWebShadingAssignedValues);
begin
  if FAssignedValues <> Value then
  begin
    FAssignedValues := Value;
    Changed;    
  end;
end;

procedure TcxWebShading.SetColor(Value: TcxWebColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if CanAssignValue then
      AssignedValues := AssignedValues + [wsavColor];
    Changed;
  end;
end;


{ TBasecxWebStyle }

constructor TBasecxWebStyle.Create;
begin
  inherited Create;
  FBorders := TcxWebBorders.Create(Self);
  FFont := TcxWebFont.Create;
  FNumbering := TcxWebNumbering.Create(Self);
  FShading := TcxWebShading.Create(Self);
  DoRestoreDefaults;
  FFont.OnChange := FontChanged;
end;

destructor TBasecxWebStyle.Destroy;
begin
  FShading.Free;
  FNumbering.Free;
  FFont.Free;
  FBorders.Free;
  inherited;
end;

procedure TBasecxWebStyle.Assign(Source: TPersistent);
begin
  if Source is TBasecxWebStyle then
  begin
    BeginUpdate;
    try
      Borders := TBasecxWebStyle(Source).Borders;
      Font := TBasecxWebStyle(Source).Font;
      Numbering := TBasecxWebStyle(Source).Numbering;
      Shading := TBasecxWebStyle(Source).Shading;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TBasecxWebStyle.Merge(Source: TBasecxWebStyle);
begin
  BeginUpdate;
  try
    Borders.Merge(Source.Borders);
//    Font.Assign(Source.Font);
    Numbering.Merge(Source.Numbering);
    Shading.Merge(Source.Shading);
  finally
    EndUpdate;
  end;
end;

procedure TBasecxWebStyle.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TBasecxWebStyle.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      Changed;
  end;
end;

procedure TBasecxWebStyle.RestoreDefaults;
begin
  BeginUpdate;
  try
    DoRestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TBasecxWebStyle.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  Shading.WriteHTML(HTMLTextBuilder);
  Borders.WriteHTML(HTMLTextBuilder);
  Font.WriteHTML(HTMLTextBuilder);
  Numbering.WriteHTML(HTMLTextBuilder);
end;

procedure TBasecxWebStyle.Changed;
begin
  if FUpdateCount = 0 then
    DoChanged;
end;

procedure TBasecxWebStyle.DoChanged;
begin
end;

procedure TBasecxWebStyle.DoRestoreDefaults;
begin
  BeginUpdate;
  try
    Borders.RestoreDefaults;
    Font.Assign(cxWebDefaultFont);
    Numbering.RestoreDefaults;
    Shading.RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TBasecxWebStyle.SetBorders(Value: TcxWebBorders);
begin
  Borders.Assign(Value);
end;

procedure TBasecxWebStyle.SetFont(Value: TcxWebFont);
begin
  Font.Assign(Value);
end;

procedure TBasecxWebStyle.SetNumbering(Value: TcxWebNumbering);
begin
  Numbering.Assign(Value);
end;

procedure TBasecxWebStyle.SetShading(Value: TcxWebShading);
begin
  Shading.Assign(Value);
end;

procedure TBasecxWebStyle.FontChanged(Sender: TObject);
begin
  Changed;
end;

{ TcxWebStyle }

constructor TcxWebStyle.Create(AStyleItem: TcxWebStyleItem);
begin
  inherited Create;
  FStyleItem := AStyleItem;
end;

function TcxWebStyle.GetOwner: TPersistent;
begin
  Result := StyleItem;
end;

procedure TcxWebStyle.DoChanged;
begin
  if StyleItem <> nil then
    StyleItem.Changed;
end;

{ TcxWebStyleItem }

constructor TcxWebStyleItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStyle := TcxWebStyle.Create(Self);
  FCustomHTML := TStringList.Create;
end;

destructor TcxWebStyleItem.Destroy;
begin
  Controller := nil;
  while FClients <> nil do
    UnregisterClient(Clients[ClientCount - 1]);
  FCustomHTML.Free;
  FStyle.Free;
  inherited Destroy;
end;

procedure TcxWebStyleItem.Assign(Source: TPersistent);
begin
  if Source is TcxWebStyleItem then
    Style := TcxWebStyleItem(Source).Style
  else
    inherited;
end;

function TcxWebStyleItem.GetParentComponent: TComponent;
begin
  Result := Controller;
end;

function TcxWebStyleItem.HasParent: Boolean;
begin
  HasParent := Controller <> nil;
end;

procedure TcxWebStyleItem.RegisterClient(AComponent: IcxWebStyleChanged);
begin
  if (AComponent = nil) or IsClient(AComponent) then
    Exit;
  if FClients = nil then
    FClients := TList.Create;  
  FClients.Add(Pointer(AComponent));
end;

procedure TcxWebStyleItem.UnregisterClient(AComponent: IcxWebStyleChanged);
begin
  if FClients <> nil then
  begin
    FClients.Remove(Pointer(AComponent));
    if (FClients.Count = 0) then
    begin
      FClients.Free;
      FClients := nil;
    end;
  end;
end;

procedure TcxWebStyleItem.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if (CustomHTML.Count > 0) and (Length(CustomHTML.Text) < 1024) then
    HTMLTextBuilder.WriteUnknownStyleAttribute(CustomHTML.Text)
  else Style.WriteHTML(HTMLTextBuilder);
end;

procedure TcxWebStyleItem.Notification(AComponent: TComponent; Operation: TOperation);
var
  AStyleChanged: IcxWebStyleChanged;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Controller then
      Controller := nil;
   if Supports(AComponent, IcxWebStyleChanged, AStyleChanged) then
     UnregisterClient(AStyleChanged);
  end;
end;

procedure TcxWebStyleItem.ReadState(Reader: TReader);
begin
  inherited;
  if Reader.Parent is TcxWebStyleController then
    Controller := TcxWebStyleController(Reader.Parent);
end;

procedure TcxWebStyleItem.SetName(const NewName: TComponentName);
begin
  inherited;
  DesignerUpdate(False);
end;

procedure TcxWebStyleItem.SetParentComponent(AParent: TComponent);
begin
  inherited;
  if not (csLoading in ComponentState) then
    Controller := AParent as TcxWebStyleController;
end;

{ IWebVariableName }
function TcxWebStyleItem.GetVariableName: string;
begin
  Result := ImplGetVariableName;
end;

function TcxWebStyleItem.ImplGetVariableName: string;
begin
  Result := Name;
end;

procedure TcxWebStyleItem.DesignerUpdate(TheAll: Boolean);
begin
  if Controller <> nil then
    if TheAll then
      Controller.DesignerUpdate(nil)
    else
      Controller.DesignerUpdate(Self);
end;

procedure TcxWebStyleItem.Changed;
var
  I: Integer;
begin
  if ClientCount = 0 then
    Exit;
  for I := 0 to ClientCount - 1 do
    Clients[I].StyleChanged(Self);
  UpdateDesigner;
end;

function TcxWebStyleItem.GetClient(Index: Integer): IcxWebStyleChanged;
begin
  Result := IcxWebStyleChanged(FClients[Index]);
end;

function TcxWebStyleItem.GetClientCount: Integer;
begin
  if FClients <> nil then
    Result := FClients.Count
  else
    Result := 0;
end;

function TcxWebStyleItem.GetFullName: string;
begin
  if FCSSClassName = '' then
    Result := Format('%s%s', [Owner.Name, Name])
  else Result := FCSSClassName;
end;

function TcxWebStyleItem.GetIndex: Integer;
begin
  if Controller <> nil then
    Result := Controller.IndexOf(Self)
  else
    Result := -1;
end;

procedure TcxWebStyleItem.SetController(Value: TcxWebStyleController);
begin
  if FController <> Value then
  begin
    if FController <> nil then
      FController.RemoveItem(Self);
    if Value <> nil then
      Value.InsertItem(Self);
  end;
end;

procedure TcxWebStyleItem.SetCustomHTML(Value: TStrings);
begin
  FCustomHTML.Assign(Value);
end;

procedure TcxWebStyleItem.SetIndex(Value: Integer);
var
  CurIndex: Integer;
begin
  if Controller = nil then
    Exit;
  if Value < 0 then
    Value := 0;
  if Value > Controller.Count - 1 then
    Value := Controller.Count - 1;
  CurIndex := Index;
  if CurIndex <> Value then
    Controller.MoveItem(CurIndex, Value);
end;

procedure TcxWebStyleItem.SetStyle(Value: TcxWebStyle);
begin
  FStyle.Assign(Value);
end;

function TcxWebStyleItem.IsClient(AComponent: IcxWebStyleChanged): Boolean;
begin
  Result := (FClients <> nil) and (FClients.IndexOf(Pointer(AComponent)) <> -1);
end;

procedure TcxWebStyleItem.UpdateDesigner;
var
  AWebControl: IcxWebControl;
  I: Integer;
begin
  for I := 0 to ClientCount - 1 do
    if Supports(Clients[I], IcxWebControl, AWebControl) and
      (AWebControl.DesignerControl <> nil) then
       AWebControl.DesignerControl.UpdateContext;
end;

{ TcxWebStyleController }

constructor TcxWebStyleController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList.Create;
end;

destructor TcxWebStyleController.Destroy;
begin
{$IFNDEF DELPHI5}
  Destroying;
{$ENDIF}
  FDesigner.Free;
  Clear;
  FItems.Free;
  inherited Destroy;
end;

function TcxWebStyleController.Add: TcxWebStyleItem;
begin
  Result := TcxWebStyleItem.Create(Owner);
  Result.Controller := Self;
end;

procedure TcxWebStyleController.AssignItems(ASource: TcxWebStyleController);
var
  I: Integer;
begin
  Clear;
  if ASource <> nil then
    for I := 0 to ASource.Count - 1 do
      Add.Assign(ASource[I]);
end;

procedure TcxWebStyleController.Clear;
begin
  while Count > 0 do
    Delete(Count - 1);
end;

procedure TcxWebStyleController.Delete(AIndex: Integer);
var
  Item: TcxWebStyleItem;
begin
  if (AIndex > -1) and (AIndex < Count) then
  begin
    Item := Items[AIndex];
    Item.Free;
  end;
end;

procedure TcxWebStyleController.GetStyleList(const AList: TList);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    AList.Add(Items[I]);
end;

function TcxWebStyleController.IndexOf(AItem: TcxWebStyleItem): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

function TcxWebStyleController.ItemByName(const AName: string): TcxWebStyleItem;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if CompareText(AName, Result.Name) = 0 then
      Exit;
  end;
  Result := nil;
end;

procedure TcxWebStyleController.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Item: TcxWebStyleItem;
begin
  for I := 0 to Count - 1 do
  begin
    Item := Items[I];
    if Item.Owner = Root then Proc(Item);
  end;
end;

procedure TcxWebStyleController.SetName(const NewName: TComponentName);
var
  OldName, NewItemName: string;
  I, L: Integer;
  Item: TcxWebStyleItem;
begin
  OldName := Name;
  L := Length(OldName);
  inherited;
  if (csDesigning in ComponentState) and (Count > 0) then
  begin
    if Designer <> nil then Designer.BeginUpdate;
    try
      for I := 0 to Count - 1 do
      begin
        Item := Items[I];
        NewItemName := Item.Name;
        if Pos(OldName, NewItemName) = 1 then
        begin
          System.Delete(NewItemName, 1, L);
          System.Insert(Name, NewItemName, 1);
          try
            Item.Name := NewItemName;
          except
            on EComponentError do ; {Ignore rename errors }
          end;
        end;
      end;
    finally
      if Designer <> nil then Designer.EndUpdate;
    end;
  end;
end;

{ IcxStylesProvider }
procedure TcxWebStyleController.GetCSSFiles(HTMLTextBuilder: TcxHTMLTextBuilder; AList: TStrings);
begin
  if FCSSFileName <> '' then
    AList.Add(FCSSFileName);
end;

procedure TcxWebStyleController.WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
  Style: TcxWebStyleItem;
begin
  for I := 0 to Count - 1 do
  begin
    Style := Items[I];
    if Style.CSSClassName = '' then
    begin
      HTMLTextBuilder.WriteStyle(Style.FullName);
      Style.WriteHTML(HTMLTextBuilder)
    end;
  end;
end;

{ IWebVariableName }
function TcxWebStyleController.GetVariableName: string;
begin
  Result := ImplGetVariableName;
end;

function TcxWebStyleController.ImplGetVariableName: string;
begin
  Result := Name;
end;

procedure TcxWebStyleController.DesignerModified;
begin
  if Designer <> nil then Designer.Modified;
end;

procedure TcxWebStyleController.DesignerUpdate(AItem: TcxWebStyleItem);
begin
  if Designer <> nil then Designer.Update(AItem);
end;

function TcxWebStyleController.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxWebStyleController.GetItem(Index: Integer): TcxWebStyleItem;
begin
  Result := TcxWebStyleItem(FItems[Index]);
end;

procedure TcxWebStyleController.SetItem(Index: Integer; Value: TcxWebStyleItem);
begin
  Items[Index].Assign(Value);
end;

procedure TcxWebStyleController.InsertItem(Value: TcxWebStyleItem);
begin
  FItems.Add(Value);
  Value.FController := Self;
end;

procedure TcxWebStyleController.MoveItem(ACurIndex, ANewIndex: Integer);
begin
  FItems.Move(ACurIndex, ANewIndex);
  DesignerUpdate(nil);
end;

procedure TcxWebStyleController.RemoveItem(Value: TcxWebStyleItem);
begin
  Value.FController := nil;
  FItems.Remove(Value);
end;


{ TcxWebStyles }

constructor TcxWebStyles.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TcxWebStyles.Assign(Source: TPersistent);
begin
  if Source is TcxWebStyles then
  begin
    Default := TcxWebStyles(Source).Default;
    Hover := TcxWebStyles(Source).Hover;
  end
  else
    inherited;
end;

procedure TcxWebStyles.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  if AOperation = opRemove then
  begin
    if AComponent = Default then Default := nil;
    if AComponent = Hover then Hover := nil;
  end;
end;

procedure TcxWebStyles.UpdateDesigner;
var
  AWebControl: IcxWebControl;
begin
  if Supports(Component, IcxWebControl, AWebControl) and
    (AWebControl.DesignerControl <> nil) then
    AWebControl.DesignerControl.UpdateContext;
end;


procedure TcxWebStyles.SetDefault(Value: TcxWebStyleItem);
begin
  if FDefault <> Value then
  begin
    if FDefault <> nil then
    begin
      if StyleChanged <> nil then
        FDefault.UnregisterClient(StyleChanged);
      FDefault.RemoveFreeNotification(Component);
    end;
    FDefault := Value;
    if FDefault <> nil then
    begin
      FDefault.FreeNotification(Component);
      if StyleChanged <> nil then
        FDefault.RegisterClient(StyleChanged);
    end;
    if StyleChanged <> nil then
      StyleChanged.StyleChanged(Default); // TODO: redesign
    UpdateDesigner;
  end;
end;

procedure TcxWebStyles.SetHover(Value: TcxWebStyleItem);
begin
  if FHover <> Value then
  begin
    if FHover <> nil then
    begin
      if StyleChanged <> nil then
        FHover.UnregisterClient(StyleChanged);
      FHover.RemoveFreeNotification(Component);
    end;
    FHover := Value;
    if FHover <> nil then
    begin
      FHover.FreeNotification(Component);
      if StyleChanged <> nil then
        FHover.RegisterClient(StyleChanged);
    end;
    if StyleChanged <> nil then
      StyleChanged.StyleChanged(Hover); // TODO: redesign
    UpdateDesigner;
  end;
end;

function TcxWebStyles.GetItem(Index: Integer): TcxWebStyleItem;
begin
  Result := nil;
  case Index of
    0: Result := Default;
    1: Result := Hover;
  end;
end;

function TcxWebStyles.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TcxWebStyles.StyleChanged: IcxWebStyleChanged;
begin
  if FOwner <> nil then
    Supports(FOwner, IcxWebStyleChanged, Result)
  else Result := nil;  
end;


function TcxWebStyles.ItemCount: Integer;
begin
  Result := 2;
end;


{ TAbstractcxWebStyleControllerDesigner }

constructor TAbstractcxWebStyleControllerDesigner.Create(AController: TcxWebStyleController);
begin
  FController := AController;
  if FController <> nil then
    FController.FDesigner := Self;
end;

destructor TAbstractcxWebStyleControllerDesigner.Destroy;
begin
  if Controller <> nil then
    Controller.FDesigner := nil;
  inherited;
end;

initialization
  RegisterIntegerConsts(TypeInfo(TcxWebBorderWidth), cxWebIdentToWidth, cxWebWidthToIdent);
  RegisterClasses([TcxWebStyleItem, TcxWebStyleController]);

end.

