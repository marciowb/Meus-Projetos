{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
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
unit cxWebHTMLEvents;

interface

uses Classes, Windows, MSHTML_TLB,
  cxWebHTMLEdIntf;

type
  TcxHTMLEventSinkClass = class of TcxCustomHTMLEventSink;

  TcxHTMLProcEvent = procedure(const AEventObject: IHTMLEventObj) of object;
  TcxHTMLFuncEvent = function(const AEventObject: IHTMLEventObj): WordBool of object;

  TcxCustomEventSink = class(TInterfacedObject, IUnknown, IDispatch, IcxEventSink)
  private
    FCookie: Integer;
    FSource: IUnknown;
  protected
    function SinkIID: TGUID; virtual;
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    { IcxEventSink }
    procedure Connect(const ASource: IUnknown);
    procedure Disconnect;
    procedure ImplConnect(const ASource: IUnknown); virtual;
    procedure ImplDisconnect; virtual;
    function GetSource: IUnknown;

    property Source: IUnknown read FSource;
  end;

  TcxCustomHTMLEventSink = class(TcxCustomEventSink, IDispatch)
  private
    FBehavior: IcxHTMLBehavior;

    FOnHelp: TcxHTMLFuncEvent;
    FOnClick: TcxHTMLFuncEvent;
    FOnDblClick: TcxHTMLFuncEvent;
    FOnKeyPress: TcxHTMLFuncEvent;
    FOnKeyDown: TcxHTMLProcEvent;
    FOnKeyUp: TcxHTMLProcEvent;
    FOnMouseOut: TcxHTMLProcEvent;
    FOnMouseOver: TcxHTMLProcEvent;
    FOnMouseMove: TcxHTMLProcEvent;
    FOnMouseDown: TcxHTMLProcEvent;
    FOnMouseUp: TcxHTMLProcEvent;
    FOnSelectStart: TcxHTMLFuncEvent;
    FOnFilterChange: TcxHTMLProcEvent;
    FOnDragStart: TcxHTMLFuncEvent;
    FOnBeforeUpdate: TcxHTMLFuncEvent;
    FOnAfterUpdate: TcxHTMLProcEvent;
    FOnErrorUpdate: TcxHTMLFuncEvent;
    FOnRowExit: TcxHTMLFuncEvent;
    FOnRowEnter: TcxHTMLProcEvent;
    FOnDatasetChanged: TcxHTMLProcEvent;
    FOnDataAvailable: TcxHTMLProcEvent;
    FOnDatasetComplete: TcxHTMLProcEvent;
    FOnLoseCapture: TcxHTMLProcEvent;
    FOnPropertyChange: TcxHTMLProcEvent;
    FOnScroll: TcxHTMLProcEvent;
    FOnFocus: TcxHTMLProcEvent;
    FOnBlur: TcxHTMLProcEvent;
    FOnResize: TcxHTMLProcEvent;
    FOnDrag: TcxHTMLFuncEvent;
    FOnDragEnd: TcxHTMLProcEvent;
    FOnDragEnter: TcxHTMLFuncEvent;
    FOnDragOver: TcxHTMLFuncEvent;
    FOnDragLeave: TcxHTMLProcEvent;
    FOnDrop: TcxHTMLFuncEvent;
    FOnBeforeCut: TcxHTMLFuncEvent;
    FOnCut: TcxHTMLFuncEvent;
    FOnBeforeCopy: TcxHTMLFuncEvent;
    FOnCopy: TcxHTMLFuncEvent;
    FOnBeforePaste: TcxHTMLFuncEvent;
    FOnPaste: TcxHTMLFuncEvent;
    FOnContextMenu: TcxHTMLFuncEvent;
    FOnRowsDelete: TcxHTMLProcEvent;
    FOnRowsInserted: TcxHTMLProcEvent;
    FOnCellChange: TcxHTMLProcEvent;
    FOnReadyStateChange: TcxHTMLProcEvent;
    FOnBeforeEditFocus: TcxHTMLProcEvent;
    FOnLayoutComplete: TcxHTMLProcEvent;
    FOnPage: TcxHTMLProcEvent;
    FOnMouseEnter: TcxHTMLProcEvent;
    FOnMouseLeave: TcxHTMLProcEvent;
    FOnActivate: TcxHTMLProcEvent;
    FOnDeactivate: TcxHTMLProcEvent;
    FOnBeforeDeactivate: TcxHTMLFuncEvent;
    FOnBeforeActivate: TcxHTMLFuncEvent;
    FOnFocusIn: TcxHTMLProcEvent;
    FOnFocusOut: TcxHTMLProcEvent;
    FOnMove: TcxHTMLProcEvent;
    FOnControlSelect: TcxHTMLFuncEvent;
    FOnMoveStart: TcxHTMLFuncEvent;
    FOnMoveEnd: TcxHTMLProcEvent;
    FOnResizeStart: TcxHTMLFuncEvent;
    FOnResizeEnd: TcxHTMLProcEvent;
    FOnMouseWheel: TcxHTMLFuncEvent;
  protected
    { IDispatch }
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;

    function DoHTMLEvent(const AEventObject: IHTMLEventObj; AMemberID: Integer;
       var AResult: Variant): HRESULT; virtual;
    function DoHelp(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoClick(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoDblClick(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoKeyPress(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoKeyDown(const AEventObject: IHTMLEventObj); virtual;
    procedure DoKeyUp(const AEventObject: IHTMLEventObj); virtual;
    procedure DoMouseOut(const AEventObject: IHTMLEventObj); virtual;
    procedure DoMouseOver(const AEventObject: IHTMLEventObj); virtual;
    procedure DoMouseMove(const AEventObject: IHTMLEventObj); virtual;
    procedure DoMouseDown(const AEventObject: IHTMLEventObj); virtual;
    procedure DoMouseUp(const AEventObject: IHTMLEventObj); virtual;
    function DoSelectStart(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoFilterChange(const AEventObject: IHTMLEventObj); virtual;
    function DoBeforeUpdate(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoAfterUpdate(const AEventObject: IHTMLEventObj); virtual;
    function DoErrorUpdate(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoRowExit(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoRowEnter(const AEventObject: IHTMLEventObj); virtual;
    procedure DoDatasetChanged(const AEventObject: IHTMLEventObj); virtual;
    procedure DoDataAvailable(const AEventObject: IHTMLEventObj); virtual;
    procedure DoDatasetComplete(const AEventObject: IHTMLEventObj); virtual;
    procedure DoLoseCapture(const AEventObject: IHTMLEventObj); virtual;
    procedure DoPropertyChange(const AEventObject: IHTMLEventObj); virtual;
    procedure DoScroll(const AEventObject: IHTMLEventObj); virtual;
    procedure DoFocus(const AEventObject: IHTMLEventObj); virtual;
    procedure DoBlur(const AEventObject: IHTMLEventObj); virtual;
    procedure DoResize(const AEventObject: IHTMLEventObj); virtual;
    function DoDragStart(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoDrag(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoDragEnd(const AEventObject: IHTMLEventObj); virtual;
    function DoDragEnter(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoDragOver(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoDragLeave(const AEventObject: IHTMLEventObj); virtual;
    function DoDrop(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoBeforeCut(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoCut(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoBeforeCopy(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoCopy(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoBeforePaste(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoPaste(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoContextMenu(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoRowsDelete(const AEventObject: IHTMLEventObj); virtual;
    procedure DoRowsInserted(const AEventObject: IHTMLEventObj); virtual;
    procedure DoCellChange(const AEventObject: IHTMLEventObj); virtual;
    procedure DoReadyStateChange(const AEventObject: IHTMLEventObj); virtual;
    procedure DoBeforeEditFocus(const AEventObject: IHTMLEventObj); virtual;
    procedure DoLayoutComplete(const AEventObject: IHTMLEventObj); virtual;
    procedure DoPage(const AEventObject: IHTMLEventObj); virtual;
    procedure DoMouseEnter(const AEventObject: IHTMLEventObj); virtual;
    procedure DoMouseLeave(const AEventObject: IHTMLEventObj); virtual;
    procedure DoActivate(const AEventObject: IHTMLEventObj); virtual;
    procedure DoDeactivate(const AEventObject: IHTMLEventObj); virtual;
    function DoBeforeDeactivate(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoBeforeActivate(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoFocusIn(const AEventObject: IHTMLEventObj); virtual;
    procedure DoFocusOut(const AEventObject: IHTMLEventObj); virtual;
    procedure DoMove(const AEventObject: IHTMLEventObj); virtual;
    function DoControlSelect(const AEventObject: IHTMLEventObj): Boolean; virtual;
    function DoMoveStart(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoMoveEnd(const AEventObject: IHTMLEventObj); virtual;
    function DoResizeStart(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoResizeEnd(const AEventObject: IHTMLEventObj); virtual;
    function DoMouseWheel(const AEventObject: IHTMLEventObj): Boolean; virtual;
  public
    constructor Create(ABehavior: IcxHTMLBehavior); virtual;
    property Behavior: IcxHTMLBehavior read FBehavior;

    property OnHelp: TcxHTMLFuncEvent read FOnHelp write FOnHelp;
    property OnClick: TcxHTMLFuncEvent read FOnClick write FOnClick;
    property OnDblClick: TcxHTMLFuncEvent read FOnDblClick write FOnDblClick;
    property OnKeyPress: TcxHTMLFuncEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyDown: TcxHTMLProcEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyUp: TcxHTMLProcEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseOut: TcxHTMLProcEvent read FOnMouseOut write FOnMouseOut;
    property OnMouseOver: TcxHTMLProcEvent read FOnMouseOver write FOnMouseOver;
    property OnMouseMove: TcxHTMLProcEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseDown: TcxHTMLProcEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TcxHTMLProcEvent read FOnMouseUp write FOnMouseUp;
    property OnSelectStart: TcxHTMLFuncEvent read FOnSelectStart write FOnSelectStart;
    property OnFilterChange: TcxHTMLProcEvent read FOnFilterChange write FOnFilterChange;
    property OnDragStart: TcxHTMLFuncEvent read FOnDragStart write FOnDragStart;
    property OnBeforeUpdate: TcxHTMLFuncEvent read FOnBeforeUpdate write FOnBeforeUpdate;
    property OnAfterUpdate: TcxHTMLProcEvent read FOnAfterUpdate write FOnAfterUpdate;
    property OnErrorUpdate: TcxHTMLFuncEvent read FOnErrorUpdate write FOnErrorUpdate;
    property OnRowExit: TcxHTMLFuncEvent read FOnRowExit write FOnRowExit;
    property OnRowEnter: TcxHTMLProcEvent read FOnRowEnter write FOnRowEnter;
    property OnDatasetChanged: TcxHTMLProcEvent read FOnDatasetChanged write FOnDatasetChanged;
    property OnDataAvailable: TcxHTMLProcEvent read FOnDataAvailable write FOnDataAvailable;
    property OnDatasetComplete: TcxHTMLProcEvent read FOnDatasetComplete write FOnDatasetComplete;
    property OnLoseCapture: TcxHTMLProcEvent read FOnLoseCapture write FOnLoseCapture;
    property OnPropertyChange: TcxHTMLProcEvent read FOnPropertyChange write FOnPropertyChange;
    property OnScroll: TcxHTMLProcEvent read FOnScroll write FOnScroll;
    property OnFocus: TcxHTMLProcEvent read FOnFocus write FOnFocus;
    property OnBlur: TcxHTMLProcEvent read FOnBlur write FOnBlur;
    property OnResize: TcxHTMLProcEvent read FOnResize write FOnResize;
    property OnDrag: TcxHTMLFuncEvent read FOnDrag write FOnDrag;
    property OnDragEnd: TcxHTMLProcEvent read FOnDragEnd write FOnDragEnd;
    property OnDragEnter: TcxHTMLFuncEvent read FOnDragEnter write FOnDragEnter;
    property OnDragOver: TcxHTMLFuncEvent read FOnDragOver write FOnDragOver;
    property OnDragLeave: TcxHTMLProcEvent read FOnDragLeave write FOnDragLeave;
    property OnDrop: TcxHTMLFuncEvent read FOnDrop write FOnDrop;
    property OnBeforeCut: TcxHTMLFuncEvent read FOnBeforeCut write FOnBeforeCut;
    property OnCut: TcxHTMLFuncEvent read FOnCut write FOnCut;
    property OnBeforeCopy: TcxHTMLFuncEvent read FOnBeforeCopy write FOnBeforeCopy;
    property OnCopy: TcxHTMLFuncEvent read FOnCopy write FOnCopy;
    property OnBeforePaste: TcxHTMLFuncEvent read FOnBeforePaste write FOnBeforePaste;
    property OnPaste: TcxHTMLFuncEvent read FOnPaste write FOnPaste;
    property OnContextMenu: TcxHTMLFuncEvent read FOnContextMenu write FOnContextMenu;
    property OnRowsDelete: TcxHTMLProcEvent read FOnRowsDelete write FOnRowsDelete;
    property OnRowsInserted: TcxHTMLProcEvent read FOnRowsInserted write FOnRowsInserted;
    property OnCellChange: TcxHTMLProcEvent read FOnCellChange write FOnCellChange;
    property OnReadyStateChange: TcxHTMLProcEvent read FOnReadyStateChange write FOnReadyStateChange;
    property OnBeforeEditFocus: TcxHTMLProcEvent read FOnBeforeEditFocus write FOnBeforeEditFocus;
    property OnLayoutComplete: TcxHTMLProcEvent read FOnLayoutComplete write FOnLayoutComplete;
    property OnPage: TcxHTMLProcEvent read FOnPage write FOnPage;
    property OnMouseEnter: TcxHTMLProcEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TcxHTMLProcEvent read FOnMouseLeave write FOnMouseLeave;
    property OnActivate: TcxHTMLProcEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TcxHTMLProcEvent read FOnDeactivate write FOnDeactivate;
    property OnBeforeDeactivate: TcxHTMLFuncEvent read FOnBeforeDeactivate write FOnBeforeDeactivate;
    property OnBeforeActivate: TcxHTMLFuncEvent read FOnBeforeActivate write FOnBeforeActivate;
    property OnFocusIn: TcxHTMLProcEvent read FOnFocusIn write FOnFocusIn;
    property OnFocusOut: TcxHTMLProcEvent read FOnFocusOut write FOnFocusOut;
    property OnMove: TcxHTMLProcEvent read FOnMove write FOnMove;
    property OnControlSelect: TcxHTMLFuncEvent read FOnControlSelect write FOnControlSelect;
    property OnMoveStart: TcxHTMLFuncEvent read FOnMoveStart write FOnMoveStart;
    property OnMoveEnd: TcxHTMLProcEvent read FOnMoveEnd write FOnMoveEnd;
    property OnResizeStart: TcxHTMLFuncEvent read FOnResizeStart write FOnResizeStart;
    property OnResizeEnd: TcxHTMLProcEvent read FOnResizeEnd write FOnResizeEnd;
    property OnMouseWheel: TcxHTMLFuncEvent read FOnMouseWheel write FOnMouseWheel;
  end;

  TcxHTMLDocEventSink = class(TcxCustomHTMLEventSink)
  private
    FOnSelectionChange: TcxHTMLProcEvent;
    FOnStop: TcxHTMLFuncEvent;
  protected
    function SinkIID: TGUID; override;
    function DoHTMLEvent(const AEventObject: IHTMLEventObj; AMemberID: Integer;
       var AResult: Variant): HRESULT; override;
    procedure DoSelectionChange(const AEventObject: IHTMLEventObj); virtual;
    function DoStop(const AEventObject: IHTMLEventObj): Boolean; virtual;
    procedure DoBeforeEditFocus(const AEventObject: IHTMLEventObj); override;
  public
    property OnSelectionChange: TcxHTMLProcEvent read FOnSelectionChange write FOnSelectionChange;
    property OnStop: TcxHTMLFuncEvent read FOnStop write FOnStop;
  end;

  TcxHTMLEWFCtrlEventSink = class(TcxCustomHTMLEventSink)
  private
    FResizing: Boolean;
  protected
    procedure DoBeforeEditFocus(const AEventObject: IHTMLEventObj); override;
    procedure DoResizeEnd(const AEventObject: IHTMLEventObj); override;
    function DoResizeStart(const AEventObject: IHTMLEventObj): Boolean; override;
  public
    property IsResizing: Boolean read FResizing;
  end;

  TcxHTMLSelectState = (hssNone, hssStart, hssSelecting);

  TcxHTMLSelectRegionSink = class(TcxCustomHTMLEventSink)
  private
    FState: TcxHTMLSelectState;
    FSelectingRect: TRect;
    FOnRectSelect: TcxHTMLRegionSelectEvent;
    FDeltaX: Integer;
    FDeltaY: Integer;
    function GetNormalSelectRect: TRect;
    procedure Snap(const ACurValue, ADelta: Integer; var ANewValue: Integer);
  protected
    function SinkIID: TGUID; override;
    procedure DoMouseDown(const AEventObject: IHTMLEventObj); override;
    procedure DoMouseMove(const AEventObject: IHTMLEventObj); override;
    procedure DoMouseUp(const AEventObject: IHTMLEventObj); override;
    procedure DoBeforeEditFocus(const AEventObject: IHTMLEventObj); override;

    procedure DoRectSelect(const AEventObject: IHTMLEventObj; const ARect: TRect); virtual;
    function IsOwnEvent(const AEventObject: IHTMLEventObj): Boolean;
  public
    property NormalSelectRect: TRect read GetNormalSelectRect;
    property OnRectSelect: TcxHTMLRegionSelectEvent read FOnRectSelect write FOnRectSelect;
    property State: TcxHTMLSelectState read FState;
  end;

  function IsDocumentReady(ADocument: IHTMLDocument2): Boolean;
  function IsPointInClient(const AElement: IHTMLElement; const X, Y: Integer): Boolean;
  function GetClientRect(const AElement: IHTMLElement; var ARect: TRect): Boolean;

const
  DISPID_HTMLELEMENTEVENTS2_ONHELP              = -2147418102;
  DISPID_HTMLELEMENTEVENTS2_ONCLICK             = -600;
  DISPID_HTMLELEMENTEVENTS2_ONDBLCLICK          = -601;
  DISPID_HTMLELEMENTEVENTS2_ONKEYPRESS          = -603;
  DISPID_HTMLELEMENTEVENTS2_ONKEYDOWN           = -602;
  DISPID_HTMLELEMENTEVENTS2_ONKEYUP             = -604;
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEOUT          = -2147418103;
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEOVER         = -2147418104;
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEMOVE         = -606;
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEDOWN         = -605;
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEUP           = -607;
  DISPID_HTMLELEMENTEVENTS2_ONSELECTSTART       = -2147418100;
  DISPID_HTMLELEMENTEVENTS2_ONFILTERCHANGE      = -2147418095;
  DISPID_HTMLELEMENTEVENTS2_ONDRAGSTART         = -2147418101;
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREUPDATE      = -2147418108;
  DISPID_HTMLELEMENTEVENTS2_ONAFTERUPDATE       = -2147418107;
  DISPID_HTMLELEMENTEVENTS2_ONERRORUPDATE       = -2147418099;
  DISPID_HTMLELEMENTEVENTS2_ONROWEXIT           = -2147418106;
  DISPID_HTMLELEMENTEVENTS2_ONROWENTER          = -2147418105;
  DISPID_HTMLELEMENTEVENTS2_ONDATASETCHANGED    = -2147418098;
  DISPID_HTMLELEMENTEVENTS2_ONDATAAVAILABLE     = -2147418097;
  DISPID_HTMLELEMENTEVENTS2_ONDATASETCOMPLETE   = -2147418096;
  DISPID_HTMLELEMENTEVENTS2_ONLOSECAPTURE       = -2147418094;
  DISPID_HTMLELEMENTEVENTS2_ONPROPERTYCHANGE    = -2147418093;
  DISPID_HTMLELEMENTEVENTS2_ONSCROLL            = 1014;
  DISPID_HTMLELEMENTEVENTS2_ONFOCUS             = -2147418111;
  DISPID_HTMLELEMENTEVENTS2_ONBLUR              = -2147418112;
  DISPID_HTMLELEMENTEVENTS2_ONRESIZE            = 1016;
  DISPID_HTMLELEMENTEVENTS2_ONDRAG              = -2147418092;
  DISPID_HTMLELEMENTEVENTS2_ONDRAGEND           = -2147418091;
  DISPID_HTMLELEMENTEVENTS2_ONDRAGENTER         = -2147418090;
  DISPID_HTMLELEMENTEVENTS2_ONDRAGOVER          = -2147418089;
  DISPID_HTMLELEMENTEVENTS2_ONDRAGLEAVE         = -2147418088;
  DISPID_HTMLELEMENTEVENTS2_ONDROP              = -2147418087;
  DISPID_HTMLELEMENTEVENTS2_ONBEFORECUT         = -2147418083;
  DISPID_HTMLELEMENTEVENTS2_ONCUT               = -2147418086;
  DISPID_HTMLELEMENTEVENTS2_ONBEFORECOPY        = -2147418082;
  DISPID_HTMLELEMENTEVENTS2_ONCOPY              = -2147418085;
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREPASTE       = -2147418081;
  DISPID_HTMLELEMENTEVENTS2_ONPASTE             = -2147418084;
  DISPID_HTMLELEMENTEVENTS2_ONCONTEXTMENU       = 1023;
  DISPID_HTMLELEMENTEVENTS2_ONROWSDELETE        = -2147418080;
  DISPID_HTMLELEMENTEVENTS2_ONROWSINSERTED      = -2147418079;
  DISPID_HTMLELEMENTEVENTS2_ONCELLCHANGE        = -2147418078;
  DISPID_HTMLELEMENTEVENTS2_ONREADYSTATECHANGE  = -609;
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREEDITFOCUS   = 1027;
  DISPID_HTMLELEMENTEVENTS2_ONLAYOUTCOMPLETE    = 1030;
  DISPID_HTMLELEMENTEVENTS2_ONPAGE              = 1031;
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEENTER        = 1042;
  DISPID_HTMLELEMENTEVENTS2_ONMOUSELEAVE        = 1043;
  DISPID_HTMLELEMENTEVENTS2_ONACTIVATE          = 1044;
  DISPID_HTMLELEMENTEVENTS2_ONDEACTIVATE        = 1045;
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREDEACTIVATE  = 1034;
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREACTIVATE    = 1047;
  DISPID_HTMLELEMENTEVENTS2_ONFOCUSIN           = 1048;
  DISPID_HTMLELEMENTEVENTS2_ONFOCUSOUT          = 1049;
  DISPID_HTMLELEMENTEVENTS2_ONMOVE              = 1035;
  DISPID_HTMLELEMENTEVENTS2_ONCONTROLSELECT     = 1036;
  DISPID_HTMLELEMENTEVENTS2_ONMOVESTART         = 1038;
  DISPID_HTMLELEMENTEVENTS2_ONMOVEEND           = 1039;
  DISPID_HTMLELEMENTEVENTS2_ONRESIZESTART       = 1040;
  DISPID_HTMLELEMENTEVENTS2_ONRESIZEEND         = 1041;
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEWHEEL        = 1033;

  DISPID_HTMLDOCUMENTEVENTS2_ONSTOP  = 1026;
  DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE  = 1037;

implementation

uses ComObj, ActiveX, SysUtils;

function IsDocumentReady(ADocument: IHTMLDocument2): Boolean;
begin
  Result := SameText(ADocument.readyState, 'complete'); // Do not localize
end;

function IsPointInClient(const AElement: IHTMLElement; const X, Y: Integer): Boolean;
var
  Element2: IHTMLElement2;
begin
  if Supports(AElement, IHTMLElement2, Element2) then
    Result := Element2.componentFromPoint(X, Y) = ''
  else
    Result := False;
end;

function GetClientRect(const AElement: IHTMLElement; var ARect: TRect): Boolean;
var
  Element2: IHTMLElement2;
begin
  if (AElement <> nil) then
  begin
    Element2 := AElement as IHTMLElement2;
    ARect.Left := AElement.offsetLeft + Element2.clientLeft;
    ARect.Top := AElement.offsetTop + Element2.clientTop;
    ARect.Right := ARect.Left + Element2.clientWidth;
    ARect.Bottom := ARect.Top + Element2.clientHeight;
    Result := True;
  end
  else
    Result := False;
end;

{ TcxCustomEventSink }

function TcxCustomEventSink.SinkIID: TGUID;
begin
  Result := DIID_HTMLElementEvents2;
end;

procedure TcxCustomEventSink.Connect(const ASource: IInterface);
begin
  ImplConnect(ASource);
end;

procedure TcxCustomEventSink.Disconnect;
begin
  ImplDisconnect;
end;

procedure TcxCustomEventSink.ImplConnect(const ASource: IInterface);
begin
  Assert(ASource <> nil);
  Disconnect;
  InterfaceConnect(ASource, SinkIID, Self, FCookie);
  FSource := ASource;
end;

procedure TcxCustomEventSink.ImplDisconnect;
begin
  if FSource <> nil then
  begin
    InterfaceDisconnect(FSource, SinkIID, FCookie);
    FSource := nil;
  end;
end;

function TcxCustomEventSink.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  Result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    if IsEqualIID(IID, SinkIID) and GetInterface(IDispatch, Obj) then
      Result := S_OK;
end;

function TcxCustomEventSink.GetIDsOfNames(const IID: TGUID;
  Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TcxCustomEventSink.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TcxCustomEventSink.GetTypeInfoCount(
  out Count: Integer): HResult;
begin
  Count := 0;
  Result := E_NOTIMPL;
end;

function TcxCustomEventSink.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;

begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TcxCustomEventSink.GetSource: IUnknown;
begin
  Result := FSource;
end;

{ TcxCustomHTMLEventSink }

constructor TcxCustomHTMLEventSink.Create(ABehavior: IcxHTMLBehavior);
begin
  FBehavior := ABehavior;
end;

function TcxCustomHTMLEventSink.DoHTMLEvent(
  const AEventObject: IHTMLEventObj; AMemberID: Integer;
  var AResult: Variant): HRESULT;

  procedure ReturnBoolResult(const EventResult: Boolean);
  begin
    TVarData(AResult).VType := varBoolean;
    TVarData(AResult).VBoolean := EventResult;
  end;

begin
  Result := S_OK;
  case AMemberID of
    DISPID_HTMLELEMENTEVENTS2_ONHELP:
      ReturnBoolResult(DoHelp(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONCLICK:
      ReturnBoolResult(DoClick(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONDBLCLICK:
      ReturnBoolResult(DoDblClick(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONKEYPRESS:
      ReturnBoolResult(DoKeyPress(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONKEYDOWN:
      DoKeyDown(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONKEYUP:
      DoKeyUp(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEOUT:
      DoMouseOut(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEOVER:
      DoMouseOver(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEMOVE:
      DoMouseMove(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEDOWN:
      DoMouseDown(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEUP:
      DoMouseUp(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONSELECTSTART:
      ReturnBoolResult(DoSelectStart(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONFILTERCHANGE:
      DoFilterChange(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREUPDATE:
      ReturnBoolResult(DoBeforeUpdate(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONAFTERUPDATE:
      DoAfterUpdate(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONERRORUPDATE:
      ReturnBoolResult(DoErrorUpdate(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONROWEXIT:
      ReturnBoolResult(DoRowExit(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONROWENTER:
      DoRowEnter(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONDATASETCHANGED:
      DoDatasetChanged(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONDATAAVAILABLE:
      DoDataAvailable(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONDATASETCOMPLETE:
      DoDatasetComplete(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONLOSECAPTURE:
      DoLoseCapture(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONPROPERTYCHANGE:
      DoPropertyChange(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONSCROLL:
      DoScroll(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONFOCUS:
      DoFocus(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONBLUR:
      DoBlur(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONRESIZE:
      DoResize(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONDRAGSTART:
      ReturnBoolResult(DoDragStart(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONDRAG:
      ReturnBoolResult(DoDrag(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONDRAGEND:
      DoDragEnd(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONDRAGENTER:
      ReturnBoolResult(DoDragEnter(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONDRAGOVER:
      ReturnBoolResult(DoDragOver(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONDRAGLEAVE:
      DoDragLeave(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONDROP:
      ReturnBoolResult(DoDrop(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONBEFORECUT:
      ReturnBoolResult(DoBeforeCut(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONCUT:
      ReturnBoolResult(DoCut(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONBEFORECOPY:
      ReturnBoolResult(DoBeforeCopy(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONCOPY:
      ReturnBoolResult(DoCopy(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREPASTE:
      ReturnBoolResult(DoBeforePaste(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONPASTE:
      ReturnBoolResult(DoPaste(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONCONTEXTMENU:
      ReturnBoolResult(DoContextMenu(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONROWSDELETE:
      DoRowsDelete(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONROWSINSERTED:
      DoRowsInserted(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONCELLCHANGE:
      DoCellChange(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONREADYSTATECHANGE:
      DoReadyStateChange(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREEDITFOCUS:
      DoBeforeEditFocus(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONLAYOUTCOMPLETE:
      DoLayoutComplete(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONPAGE:
      DoPage(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEENTER:
      DoMouseEnter(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOUSELEAVE:
      DoMouseLeave(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONACTIVATE:
      DoActivate(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONDEACTIVATE:
      DoDeactivate(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREDEACTIVATE:
      ReturnBoolResult(DoBeforeDeactivate(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONBEFOREACTIVATE:
      ReturnBoolResult(DoBeforeActivate(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSIN:
      DoFocusIn(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONFOCUSOUT:
      DoFocusOut(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOVE:
      DoMove(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONCONTROLSELECT:
      ReturnBoolResult(DoControlSelect(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONMOVESTART:
      ReturnBoolResult(DoMoveStart(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONMOVEEND:
      DoMoveEnd(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONRESIZESTART:
      ReturnBoolResult(DoResizeStart(AEventObject));
    DISPID_HTMLELEMENTEVENTS2_ONRESIZEEND:
      DoResizeEnd(AEventObject);
    DISPID_HTMLELEMENTEVENTS2_ONMOUSEWHEEL:
      ReturnBoolResult(DoMouseWheel(AEventObject));
  else
    Result := DISP_E_MEMBERNOTFOUND;
  end;
end;

function TcxCustomHTMLEventSink.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;

  function GetHTMLEventParam(out AParam: IHTMLEventObj): Boolean;
  var
    DispParams: TDispParams absolute Params;
    Param: TVariantArg;
  begin
    AParam := nil;
    Result := (DispParams.cArgs = 1) and
      (Flags and DISPATCH_METHOD = DISPATCH_METHOD);
    if Result then
    begin
      Param := PVariantArgList(DispParams.rgvarg)^[0];
      Result := (Param.vt = VT_DISPATCH) or (Param.vt = VT_UNKNOWN);
      if Result then
        Supports(IInterface(Param.unkVal), IHTMLEventObj, AParam);
    end;
  end;

var
  EventObject: IHTMLEventObj;
begin
  if GetHTMLEventParam(EventObject) then
    Result := DoHTMLEvent(EventObject, DispID, Variant(VarResult^))
  else
    Result := DISP_E_MEMBERNOTFOUND;
end;

function TcxCustomHTMLEventSink.DoControlSelect(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  Result := True;
  if Assigned(FOnControlSelect) then
    Result := FOnControlSelect(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoMouseDown(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMouseDown) then
    FOnMouseDown(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoMouseMove(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMouseMove) then
    FOnMouseMove(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoMouseUp(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMouseUp) then
    FOnMouseUp(AEventObject);
end;

function TcxCustomHTMLEventSink.DoCut(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnCut) then
    Result := FOnCut(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoCopy(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnCopy) then
    Result := FOnCopy(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoPaste(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnPaste) then
    Result := FOnPaste(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoActivate(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnActivate) then
    FOnActivate(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoAfterUpdate(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnAfterUpdate) then
    FOnAfterUpdate(AEventObject);
end;

function TcxCustomHTMLEventSink.DoBeforeActivate(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnBeforeActivate) then
    Result := FOnBeforeActivate(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoBeforeCopy(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnBeforeCopy) then
    Result := FOnBeforeCopy(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoBeforeCut(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnBeforeCut) then
    Result := FOnBeforeCut(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoBeforeDeactivate(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnBeforeDeactivate) then
    Result := FOnBeforeDeactivate(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoBeforePaste(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnBeforePaste) then
    Result := FOnBeforePaste(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoBeforeUpdate(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnBeforeUpdate) then
    Result := FOnBeforeUpdate(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoBlur(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnBlur) then
    FOnBlur(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoCellChange(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnCellChange) then
    FOnCellChange(AEventObject);
end;

function TcxCustomHTMLEventSink.DoClick(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnClick) then
    Result := FOnClick(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoContextMenu(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnContextMenu) then
    Result := FOnContextMenu(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoDataAvailable(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnDataAvailable) then
    FOnDataAvailable(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoDatasetChanged(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnDatasetChanged) then
    FOnDatasetChanged(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoDatasetComplete(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnDatasetComplete) then
    FOnDatasetComplete(AEventObject);
end;

function TcxCustomHTMLEventSink.DoDblClick(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnDblClick) then
    Result := FOnDblClick(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoDeactivate(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnDeactivate) then
    FOnDeactivate(AEventObject);
end;

function TcxCustomHTMLEventSink.DoDrag(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnDrag) then
    Result := FOnDrag(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoDragEnd(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnDragEnd) then
    FOnDragEnd(AEventObject);
end;

function TcxCustomHTMLEventSink.DoDragEnter(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnDragEnter) then
    Result := FOnDragEnter(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoDragLeave(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnDragLeave) then
    FOnDragLeave(AEventObject);
end;

function TcxCustomHTMLEventSink.DoDragOver(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnDragOver) then
    Result := FOnDragOver(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoDragStart(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnDragStart) then
    Result := FOnDragStart(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoDrop(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnDrop) then
    Result := FOnDrop(AEventObject)
  else
    Result := True;
end;

function TcxCustomHTMLEventSink.DoErrorUpdate(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnErrorUpdate) then
    Result := FOnErrorUpdate(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoFilterChange(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnFilterChange) then
    FOnFilterChange(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoFocus(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnFocus) then
    FOnFocus(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoFocusIn(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnFocusIn) then
    FOnFocusIn(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoFocusOut(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnFocusOut) then
    FOnFocusOut(AEventObject);
end;

function TcxCustomHTMLEventSink.DoHelp(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnHelp) then
    Result := FOnHelp(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoKeyDown(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnKeyDown) then
    FOnKeyDown(AEventObject);
end;

function TcxCustomHTMLEventSink.DoKeyPress(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnKeyPress) then
    Result := FOnKeyPress(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoKeyUp(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnKeyUp) then
    FOnKeyUp(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoLayoutComplete(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnLayoutComplete) then
    FOnLayoutComplete(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoLoseCapture(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnLoseCapture) then
    FOnLoseCapture(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoMouseEnter(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoMouseLeave(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoMouseOut(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMouseOut) then
    FOnMouseOut(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoMouseOver(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMouseOver) then
    FOnMouseOver(AEventObject);
end;

function TcxCustomHTMLEventSink.DoMouseWheel(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnMouseWheel) then
    Result := FOnMouseWheel(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoMove(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMove) then
    FOnMove(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoMoveEnd(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnMoveEnd) then
    FOnMoveEnd(AEventObject);
end;

function TcxCustomHTMLEventSink.DoMoveStart(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnMoveStart) then
    Result := FOnMoveStart(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoPage(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnPage) then
    FOnPage(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoPropertyChange(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnPropertyChange) then
    FOnPropertyChange(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoReadyStateChange(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnReadyStateChange) then
    FOnReadyStateChange(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoResize(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnResize) then
    FOnResize(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoResizeEnd(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnResizeEnd) then
    FOnResizeEnd(AEventObject);
end;

function TcxCustomHTMLEventSink.DoResizeStart(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnResizeStart) then
    Result := FOnResizeStart(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoRowEnter(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnRowEnter) then
    FOnRowEnter(AEventObject);
end;

function TcxCustomHTMLEventSink.DoRowExit(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnRowExit) then
    Result := FOnRowExit(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoRowsDelete(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnRowsDelete) then
    FOnRowsDelete(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoRowsInserted(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnRowsInserted) then
    FOnRowsInserted(AEventObject);
end;

procedure TcxCustomHTMLEventSink.DoScroll(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnScroll) then
    FOnScroll(AEventObject);
end;

function TcxCustomHTMLEventSink.DoSelectStart(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnSelectStart) then
    Result := FOnSelectStart(AEventObject)
  else
    Result := True;
end;

procedure TcxCustomHTMLEventSink.DoBeforeEditFocus(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnBeforeEditFocus) then
    FOnBeforeEditFocus(AEventObject);
end;

{ TcxHTMLDocEventSink }

function TcxHTMLDocEventSink.SinkIID: TGUID;
begin
  Result := DIID_HTMLDocumentEvents2;
end;

procedure TcxHTMLDocEventSink.DoBeforeEditFocus(
  const AEventObject: IHTMLEventObj);
var
  Doc2: IHTMLDocument2;
begin
  if Supports(Source, IHTMLDocument2, Doc2) then
    AEventObject.returnValue := IsDocumentReady(Doc2);
  inherited;
end;

function TcxHTMLDocEventSink.DoHTMLEvent(
  const AEventObject: IHTMLEventObj; AMemberID: Integer;
  var AResult: Variant): HRESULT;

  procedure ReturnBoolResult(const EventResult: Boolean);
  begin
    TVarData(AResult).VType := varBoolean;
    TVarData(AResult).VBoolean := EventResult;
  end;

begin
  Result := S_OK;
  case AMemberID of
   DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE:
     DoSelectionChange(AEventObject);
   DISPID_HTMLDOCUMENTEVENTS2_ONSTOP:
     ReturnBoolResult(DoStop(AEventObject));
  else
    Result := inherited DoHTMLEvent(AEventObject, AMemberID, AResult);
  end;
end;

procedure TcxHTMLDocEventSink.DoSelectionChange(
  const AEventObject: IHTMLEventObj);
begin
  if Assigned(FOnSelectionChange) then
    FOnSelectionChange(AEventObject);
end;

function TcxHTMLDocEventSink.DoStop(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  if Assigned(FOnStop) then
    Result := FOnStop(AEventObject)
  else
    Result := True;
end;

{ TcxHTMLEWFCtrlEventSink }

procedure TcxHTMLEWFCtrlEventSink.DoBeforeEditFocus(
  const AEventObject: IHTMLEventObj);
begin
  AEventObject.returnValue := False;
  AEventObject.cancelBubble := True;
  inherited;
end;

procedure TcxHTMLEWFCtrlEventSink.DoResizeEnd(
  const AEventObject: IHTMLEventObj);
begin
  FResizing := False;
  inherited;
end;

function TcxHTMLEWFCtrlEventSink.DoResizeStart(
  const AEventObject: IHTMLEventObj): Boolean;
begin
  FResizing := True;
  Result := inherited DoResizeStart(AEventObject);
end;

{ TcxHTMLSelectRegionSink }

function TcxHTMLSelectRegionSink.GetNormalSelectRect: TRect;
var
  Pos: Integer;
begin
  Result := FSelectingRect;
  if Result.Left > Result.Right then
  begin
    Pos := Result.Left;
    Result.Left := Result.Right;
    Result.Right := Pos;
  end;
  if Result.Top > Result.Bottom then
  begin
    Pos := Result.Top;
    Result.Top := Result.Bottom;
    Result.Bottom := Pos;
  end;
end;

procedure TcxHTMLSelectRegionSink.Snap(const ACurValue, ADelta: Integer; var ANewValue: Integer);
var
  I: Integer;
begin
  I := ANewValue;
  if I > ACurValue then
    Inc(I, ADelta);
  I := (I div ADelta) * ADelta;
  if ((ADelta < 4) and (Abs(I - ANewValue) < 2) ) or
    (Abs(I - ANewValue) < (ADelta div 2)) then
    ANewValue := I
  else
    ANewValue := ACurValue;
end;

function TcxHTMLSelectRegionSink.SinkIID: TGUID;
begin
  Result := DIID_HTMLTextContainerEvents2;
end;

procedure TcxHTMLSelectRegionSink.DoMouseDown(const AEventObject: IHTMLEventObj);

  function GetClipRect(var R: TRect): Boolean;
  var
    Global: tagPOINT;
    Element2: IHTMLElement2;
    Doc2: IHTMLDocument2;
    Win3: IHTMLWindow3;
  begin
    if (Behavior.Element <> nil) and
      Supports(Behavior.Element.document, IHTMLDocument2, Doc2) and
      Supports(Doc2.parentWindow, IHTMLWindow3, Win3) then
    begin
      Element2 := Behavior.Element as IHTMLElement2;
      Global := tagPOINT(Point(Element2.clientLeft, Element2.clientTop));
      Inc(Global.X, Win3.screenLeft);
      Inc(Global.Y, Win3.screenTop);
      R.TopLeft := TPoint(Global);
      R.Right := R.Left + Element2.clientWidth;
      R.Bottom := R.Top + Element2.clientHeight;
      Result := True;
    end
    else
      Result := False;
  end;

var
  Rect: TRect;
  RightLoc, BottomLoc: Integer;
begin
  inherited;
  if (AEventObject.button = 1) {Left mouse button} and
    IsOwnEvent(AEventObject) and
    IsPointInClient(AEventObject.srcElement, AEventObject.clientX, AEventObject.clientY) then
  begin
    if GetClipRect(Rect) then
      ClipCursor(@Rect);
    FState := hssStart;
    FDeltaX := Behavior.Namespace.GetEditorInfo.GridXSize;
    FDeltaY := Behavior.Namespace.GetEditorInfo.GridYSize;
    RightLoc := AEventObject.offsetX;
    BottomLoc := AEventObject.offsetY;
    if Behavior.Namespace.GetEditorInfo.IsToolSelected and
      Behavior.Namespace.GetEditorInfo.SnapToGrid then
    begin
      RightLoc := ((RightLoc + FDeltaX div 2) div FDeltaX) * FDeltaX;
      BottomLoc := ((BottomLoc + FDeltaY div 2) div FDeltaY) * FDeltaY;
    end;
    FSelectingRect := Bounds(RightLoc, BottomLoc, 0, 0);
  end;
end;

procedure TcxHTMLSelectRegionSink.DoMouseMove(const AEventObject: IHTMLEventObj);

  function IsRealMoving: Boolean;
  begin
    Result := (Abs(FSelectingRect.Left - AEventObject.offsetX) > 3) or
      (Abs(FSelectingRect.Top - AEventObject.offsetY) > 3);
  end;
var
  R: TRect;
  RightLoc, BottomLoc: Integer;
begin
  inherited;
  if (AEventObject.button = 1) {Left mouse button} and
    (FState <> hssNone) and IsRealMoving then
  begin
    if FState <> hssSelecting then
      Behavior.PaintSite.InvalidatePainterInfo;
    RightLoc := AEventObject.offsetX;
    BottomLoc := AEventObject.offsetY;
    if Behavior.Namespace.GetEditorInfo.IsToolSelected and
      Behavior.Namespace.GetEditorInfo.SnapToGrid then
    begin
      Snap(FSelectingRect.Right, FDeltaX, RightLoc);
      Snap(FSelectingRect.Bottom, FDeltaY, BottomLoc);
    end;
    FState := hssSelecting;
    R := NormalSelectRect;
    InflateRect(R, 1, 1);
    if Behavior.Namespace.GetEditorInfo.IsToolSelected then
      InflateRect(R, 1, 1);
    Behavior.PaintSite.InvalidateRect(@R);
    FSelectingRect.Right := RightLoc;
    FSelectingRect.Bottom := BottomLoc;
    R  := NormalSelectRect;
    Behavior.PaintSite.InvalidateRect(@R);
    AEventObject.returnValue := False;
  end;
end;

procedure TcxHTMLSelectRegionSink.DoMouseUp(const AEventObject: IHTMLEventObj);
var
  R: TRect;
  LocState: TcxHTMLSelectState;
  RightLoc, BottomLoc: Integer;
begin
  inherited;
  LocState := FState;
  FState := hssNone;
  if (LocState <> hssNone) then
    ClipCursor(nil);
  if (LocState = hssSelecting) then
  begin
    RightLoc := AEventObject.offsetX;
    BottomLoc := AEventObject.offsetY;
    if Behavior.Namespace.GetEditorInfo.IsToolSelected and
      Behavior.Namespace.GetEditorInfo.SnapToGrid then
    begin
      Snap(FSelectingRect.Right, FDeltaX, RightLoc);
      Snap(FSelectingRect.Bottom, FDeltaY, BottomLoc);
    end;
    FSelectingRect.Right := RightLoc;
    FSelectingRect.Bottom := BottomLoc;
    R := NormalSelectRect;
    Behavior.PaintSite.InvalidateRect(@R);
    Behavior.PaintSite.InvalidatePainterInfo;
    (AEventObject.SrcElement.document as IHTMLDocument2).selection.empty;
    DoRectSelect(AEventObject, R);
  end;
end;

procedure TcxHTMLSelectRegionSink.DoRectSelect(const AEventObject: IHTMLEventObj; const ARect: TRect);
begin
  if Assigned(FOnRectSelect) then
    FOnRectSelect(AEventObject, ARect);
end;

function TcxHTMLSelectRegionSink.IsOwnEvent(
  const AEventObject: IHTMLEventObj): Boolean;
var
  Element: IHTMLElement;
begin
  Result := False;
  if (AEventObject = nil) or (AEventObject.srcElement = nil) then Exit;
  if Supports(Source, IHTMLElement, Element) then
   Result := AEventObject.srcElement.sourceIndex = Element.sourceIndex;
end;

procedure TcxHTMLSelectRegionSink.DoBeforeEditFocus(
  const AEventObject: IHTMLEventObj);

  function IsTableEvent: Boolean;
  var
    Doc2: IHTMLDocument2;
    Element: IHTMLElement;
  begin
    Element := nil;
    if (AEventObject <> nil) and (AEventObject.srcElement <> nil) and
      Supports(AEventObject.srcElement.document, IHTMLDocument2, Doc2) then
      Element := Doc2.elementFromPoint(AEventObject.clientX, AEventObject.clientY);
    Result := (Element <> nil) and
     (Supports(Element, IHTMLTableCell) or Supports(Element, IHTMLTableCaption));
  end;

begin
  if IsOwnEvent(AEventObject) then
    if not IsTableEvent then
  begin
    AEventObject.returnValue := False;
    AEventObject.cancelBubble := True;
  end;
  inherited;
end;

end.
