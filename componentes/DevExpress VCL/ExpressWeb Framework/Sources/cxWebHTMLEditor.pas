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
unit cxWebHTMLEditor;

interface

uses Classes, SysUtils, Windows, ActiveX, OleCtrls, MSHTML_TLB, SHDocVw,
  cxWebHTMLBehaviors, cxWebHTMLevents, cxWebHTMLEdIntf, cxWebHTMLHostIntf;

type
  TcxHTMLDocReadyEvent = procedure(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant) of object;
  TcxHTMLBeforeNavigateEvent = procedure(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant;
    var Flags: OleVariant; var TargetFrameName: OleVariant; var PostData: OleVariant;
    var Headers: OleVariant; var Cancel: WordBool) of object;
  TcxHTMLNewWindowEvent = procedure(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool) of object;

  TcxHTMLEditor = class;

  TcxHTMLUndoManager = class(TObject)
  private
    FEditor: TcxHTMLEditor;
    FOpenBlockCount: Integer;
    function GetUndoDesctiption: string;
    function GetRedoDesctiption: string;
  protected
    function GetOleUndoManager: IcxOleUndoManager;
  public
    constructor Create(AEditor: TcxHTMLEditor);
    procedure Clear;
    procedure BeginUndoBlock(const ACaption: string);
    procedure EndUndoBlock;
    function CanRedo: Boolean;
    function CanUndo: Boolean;
    procedure Redo;
    procedure Undo;
    property RedoDesctiption: string read GetRedoDesctiption;
    property UndoDesctiption: string read GetUndoDesctiption;
  end;

  TcxHTMLDocHostUIHandler = class(TObject)
  private
    FEditor: TcxHTMLEditor;
  protected
    function ShowContextMenu(dwID: LongWord; ppt: PPoint; const pcmdtReserved: IUnknown;
                             const pdispReserved: IDispatch): HResult; stdcall;
    function GetHostInfo(var pInfo: DOCHOSTUIINFO): HResult; stdcall;
    function ShowUI(dwID: LongWord; const pActiveObject: IUnknown; const pCommandTarget: IUnknown;
                    const pFrame: IUnknown; const pDoc: IUnknown): HResult; stdcall;
    function HideUI: HResult; stdcall;
    function UpdateUI: HResult; stdcall;
    function EnableModeless(fEnable: Integer): HResult; stdcall;
    function OnDocWindowActivate(fActivate: Integer): HResult; stdcall;
    function OnFrameWindowActivate(fActivate: Integer): HResult; stdcall;
    function ResizeBorder(var prcBorder: Integer; const pUIWindow: IUnknown; fRameWindow: Integer): HResult; stdcall;
    function TranslateAccelerator(lpmsg: PMsg; pguidCmdGroup: PGUID; nCmdID: LongWord): HResult; stdcall;
    function GetOptionKeyPath(out pchKey: PWideChar; dw: LongWord): HResult; stdcall;
    function GetDropTarget(const pDropTarget: IUnknown; var ppDropTarget: IUnknown): HResult; stdcall;
    function GetExternal(var ppDispatch: IDispatch): HResult; stdcall;
    function TranslateUrl(dwTranslate: LongWord; const pchURLIn: PWideChar; out ppchURLOut: PWideChar): HResult; stdcall;
    function FilterDataObject(const pDO: IUnknown; var ppDORet: IUnknown): HResult; stdcall;

    function ShowMessage(hwnd: THandle; lpstrText, lpstrCaption: PWideChar; dwType: LongWord; lpstrHelpFile: PWideChar;
                         dwHelpContext: LongWord; var plResult: LongInt): HResult; stdcall;
    function ShowHelp(hwnd: THandle; pszHelpFile: PWideChar; uCommand: LongWord; dwData: LongWord;
                      ptMouse: TPoint; var pDispatchObjectHit: IDispatch): HResult; stdcall;
  public
    constructor Create(AEditor: TcxHTMLEditor);
  end;

  TcxHTMLFrameSide = (fsLeft, fsRight, fsTop, fsBottom);

  TcxHTMLOleCommandTarget = class(TInterfacedObject, IcxOleCommandTarget)
  private
    FEditor: TcxHTMLEditor;
    function GetWBCommandTarget: IcxOleCommandTarget;
    // Table editing helper
    function FindCellOf(AElement: IHTMLElement): IHTMLTableCell;
    function FindRowOf(AElement: IHTMLElement): IHTMLTableRow;
    function FindTableOf(AElement: IHTMLElement): IHTMLTable;
    function GetCellByAbsIndex(ARow: IHTMLTableRow; AIndex: Integer): IHTMLTableCell;
    function GetCellAbsIndex(ARow: IHTMLTableRow; AIndex: Integer): Integer;
    function IsCellsSelected: Boolean;
    function IsRowsSelected: Boolean;
    function IsViewLinkSelected: Boolean;
    procedure UpdateCellColSpan(ACell: IHTMLTableCell; N: Integer);
    // Frame editing helper
    function IsFrameSelected: Boolean;
    function GetFrameIndex(AFrameSet, AFrame: IHTMLElement): Integer;
    function FindParentFrameset(const AElement: IHTMLElement): IHTMLFrameSetElement;
  protected
    function QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
      prgCmds: POleCmd; CmdText: POleCmdText): HResult; stdcall;
    function Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
      vaIn, vaOut: PVariantArg): HResult; stdcall;
  public
    constructor Create(AEditor: TcxHTMLEditor);
    // Table editing commands
    function CanTableInsert: Boolean;
    function CanRowInsert: Boolean;
    function CanColInsert: Boolean;
    function CanCellInsert: Boolean;
    function CanTableSelect: Boolean;
    function CanRowSelect: Boolean;
    function CanColSelect: Boolean;
    function CanCellSelect: Boolean;
    function CanCellMerge: Boolean;
    function CanCellSplit: Boolean;
    function CanTableDelete: Boolean;
    function CanRowDelete: Boolean;
    function CanColDelete: Boolean;
    function CanCellDelete: Boolean;
    procedure TableInsert;
    procedure TableSelect;
    procedure TableDelete;
    procedure ColInsert(ToRight: Boolean = False);
    procedure ColSelect;
    procedure ColDelete;
    procedure RowInsert(Below: Boolean = False);
    procedure RowSelect;
    procedure RowDelete;
    procedure CellInsert;
    procedure CellSelect;
    procedure CellMerge;
    procedure CellSplit;
    procedure CellDelete;
    // Frames editing commands
    function CanFrame: Boolean;
    function CanWholeFrame: Boolean;
    procedure FrameInsert(ASide: TcxHTMLFrameSide);
    procedure FrameDelete;
    procedure WholeFrameInsert;
    // Undo/Redo commands
    procedure AfterUndoRedo(const ACommand: string);
    function BeforeUndoRedo(ACmdID: Cardinal): string;
  end;

  TcxHTMLSelectionType = (stNone, stText, stControl);

  TcxHTMLSelection = class(TObject)
  private
    FEditor: TcxHTMLEditor;
    function GetAbsolutePosition: Boolean;
    procedure SetAbsolutePosition(const Value: Boolean);
    function GetCaret: IHTMLCaret;
    function GetControl(Index: Integer): IHTMLElement;
    function GetCount: Integer;
    function GetElementFromCaret: IHTMLElement;
    function GetElementsFromTextRange(AElements: TInterfaceList): Integer;
    function GetSelType: TcxHTMLSelectionType;
    function GetSelectionObject: IHTMLSelectionObject;
    function GetControlRange: IHTMLControlRange;
    function GetTextRange: IHTMLTxtRange;
    function CreateControlRange: IHTMLControlRange;
    function GetActiveFrame: IHTMLFrameBase;
  protected
    function CanCommand(const ACmdID: OLECMDID): Boolean;
    procedure ExeCommand(const ACmdID: OLECMDID);
    property ControlRange: IHTMLControlRange read GetControlRange;
    property TextRange: IHTMLTxtRange read GetTextRange;
  public
    constructor Create(AEditor: TcxHTMLEditor);
    procedure Add(AControl: IHTMLElement);
    function CanClear: Boolean;
    function CanCopy: Boolean;
    function CanCut: Boolean;
    function CanDelete: Boolean;
    function CanPaste: Boolean;
    function CanSelectAll: Boolean;
    procedure Clear;
    procedure Copy;
    procedure Cut;
    procedure Delete;
    procedure Empty;
    function IndexOf(AControl: IHTMLElement): Integer;
    function Last: IHTMLElement;
    procedure Paste;
    procedure Remove(AControl: IHTMLElement);
    procedure SelectAll;
    property AbsolutePosition: Boolean read GetAbsolutePosition write SetAbsolutePosition;
    property Count: Integer read GetCount;
    property Controls[Index: Integer]: IHTMLElement read GetControl; default;
    property SelType: TcxHTMLSelectionType read GetSelType;
  end;


  TcxHTMLEditorContextMenuEvent = procedure(ASender: TObject; APos: TPoint;
    AElement: IHTMLElement) of object;
  TcxControlInsertEvent = procedure(Sender: TObject; R: TRect; var HTML, InnerHTML: string;
      var ParentElement: IHTMLElement) of object;
  TcxControlInsertedEvent = procedure(Sender: TObject; Element: IHTMLElement) of object;
  TcxParentChangedEvent = procedure(ASender: TObject; ANewParent: IHTMLElement) of object;
  TcxHTMLEditorState = (esNormal, esDragging, esMoving, esResizing);

  TcxHTMLEditor = class(TOleControl, IDispatch, IServiceProvider, IHTMLEditHost,
    IDocHostUIHandler, IDocHostShowUI, IcxHTMLEditorInfo, IcxHTMLElementInfo,
    IHTMLChangeSink)
  private
    FBar: IcxHTMLEditorBar;
    FCommandTarget: IcxOleCommandTarget;
    FDocEventSink: TcxHTMLDocEventSink;
    FDocEventSinkIntf: IcxEventSink;
    FNamespaces: IInterfaceList;
    FHostUIHandler: TcxHTMLDocHostUIHandler;
    FIntf: IWebBrowser2;
    FModified: Boolean;
    FPrimaryMCId: Cardinal;
    FBaseURL: string;
    FInternalBrowseMode: Boolean;
    FSelection: TcxHTMLSelection;
    FState: TcxHTMLEditorState;
    FOnControlInsert: TcxControlInsertEvent;
    FOnControlInserted: TcxControlInsertedEvent;
    FOnDocumentComplete: TNotifyEvent;
    FOnDocumentChange: TNotifyEvent;
    FOnSelectionChanged: TNotifyEvent;
    FOnShowContextMenu: TcxHTMLEditorContextMenuEvent;
    FOnDocReady: TcxHTMLDocReadyEvent;
    FOnBeforeNavigate: TcxHTMLBeforeNavigateEvent;
    FOnNewWindow: TcxHTMLNewWindowEvent;
    FOnParentChanged: TcxParentChangedEvent;
    FOnMoved: TNotifyEvent;
    FOnResized: TNotifyEvent;
    FDraggingElement: IHTMLElement;
    FDropTarget: IHTMLElement;
    FUndoManager: TcxHTMLUndoManager;
    function GetControlInterface: IWebBrowser2;
    function GetDocument: IHTMLDocument2;
    function GetDocument3: IHTMLDocument3;
    function GetDocument4: IHTMLDocument4;
    function GetBrowseMode: Boolean;
    function GetBusy: Boolean;
    function GetDocumentReady: Boolean;
    function GetModified: Boolean;
    function GetDocumentHTML: string;
    function GetDisplayServices: IDisplayServices;
    function GetMarkupServices: IMarkupServices;
    procedure ProcessMessages;
    procedure SetBaseURL(const Value: string);
    procedure SetBrowseMode(const Value: Boolean);
    procedure SetDocumentHTML(const Value: string);
    procedure SetModified(const Value: Boolean);
    function GetBody: IHTMLBodyElement;
    function GetBodyElement: IHTMLElement;
    function AddNamespace(const ANamespace: string): IcxHTMLNamespace;
    function FindNamespace(const ANamespace: string): IcxHTMLNamespace;
    function FindElementBehavior(AElement: IHTMLElement): IcxHTMLBehaviorViewLink;
    function CheckInSelectRect(Element: IHTMLElement; R: TRect): Boolean;
    function FireEvent(ASrcElement: IHTMLElement; const AName: string): Boolean;
    procedure AddGlobalBehaviors;
    procedure LinkChangeSink;
    procedure UnlinkChangeSink;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    procedure AssignEvents;
    procedure SetupControl;
    procedure DoOnDocumentReady(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant); virtual;
    procedure DoOnBeforeNavigate(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant;
      var Flags: OleVariant; var TargetFrameName: OleVariant; var PostData: OleVariant;
      var Headers: OleVariant; var Cancel: WordBool); virtual;
    procedure DoOnNewWindow(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool); virtual;
    procedure DoDocumentChange; virtual;
    procedure DoInsert(AParent: IHTMLElement; R: TRect); virtual;
    procedure DoSelectionChanged; virtual;
    procedure SelectByRect(const AEventObj: IHTMLEventObj; const ARect: TRect);
    procedure GetHTMLElementsList(const AList: IInterfaceList); virtual;
    procedure StartMoveSelectionByKey(const AKey: Integer; ASnap: Boolean);
    procedure StartResizeSelectionByKey(const AKey: Integer);
    procedure EndMoveSelectionByKey;
    procedure EndResizeSelectionByKey;
    { Document event handlers }
    procedure DoOnActivate(const AEventObj: IHTMLEventObj); virtual;
    procedure DoOnSelectionChange(const AEventObj: IHTMLEventObj); virtual;
    function DoOnClick(const AEventObj: IHTMLEventObj): WordBool; virtual;
    function DoOnDblClick(const AEventObj: IHTMLEventObj): WordBool; virtual;
    procedure DoOnKeyDown(const AEventObj: IHTMLEventObj); virtual;
    function DoOnMoveStart(const AEventObj: IHTMLEventObj): WordBool; virtual;
    procedure DoOnMoveEnd(const AEventObj: IHTMLEventObj); virtual;
    function DoOnResizeStart(const AEventObj: IHTMLEventObj): WordBool; virtual;
    procedure DoOnResizeEnd(const AEventObj: IHTMLEventObj); virtual;
    procedure DoOnMouseDown(const AEventObj: IHTMLEventObj); virtual;
    procedure DoOnMouseUp(const AEventObj: IHTMLEventObj); virtual;
    procedure DoOnFocusOut(const AEventObj: IHTMLEventObj); virtual;
    function DoOnDragStart(const AEventObj: IHTMLEventObj): WordBool; virtual;
    procedure DoOnDragEnd(const AEventObj: IHTMLEventObj); virtual;
    function DoOnDrop(const AEventObj: IHTMLEventObj): WordBool; virtual;

    property CommandTarget: IcxOleCommandTarget read FCommandTarget;
    property DisplayServices: IDisplayServices read GetDisplayServices;
    property MarkupServices: IMarkupServices read GetMarkupServices;
    property DraggingElement: IHTMLElement read FDraggingElement;
    { IDispatch }
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    { IServiceProvider }
    function QueryService(const rsid, iid: TGuid; out Obj): HResult; stdcall;
    { IHTMLEditHost }
    function SnapRect(const pIElement: IHTMLElement; var prcNew: tagRECT; eHandle: _ELEMENT_CORNER): HResult; stdcall;
    { IDocHostUIHandler }
    property HostUIHandler: TcxHTMLDocHostUIHandler read FHostUIHandler
      implements IDocHostUIHandler, IDocHostShowUI;
    { IcxHTMLEditorInfo }
    function ShowBorders: Boolean; virtual;
    function ShowDetails: Boolean; virtual;
    function ShowGrid: Boolean; virtual;
    function SnapToGrid: Boolean; virtual;
    function GridXSize: Integer; virtual;
    function GridYSize: Integer; virtual;
    function IsToolSelected: Boolean; virtual;
    procedure CompleteUndoBlock;
    { IcxHTMLElementInfo }
    procedure GetViewLinkContent(const AElement: IHTMLElement; var AContent, ACSSContent, AInlineStyle: string); virtual;
    function IsElementContainer(const AElement: IHTMLElement): Boolean; virtual;
    function CanHaveBehavior(const AElement: IHTMLElement): Boolean; virtual;
    function ContainerLayout(const AElement: IHTMLElement): TcxHTMLContainerLayout; virtual;
    function CanElementSelect(const AElement: IHTMLElement): Boolean; virtual;
    { IHTMLChangeSink }
    function Notify: HResult; stdcall;
  public
    constructor Create(AOwner: TComponent; ABrowseMode: Boolean = False); reintroduce;
    destructor Destroy; override;
    function ExecCommand(const ACmdID: OLECMDID; ACmdExecOpt: OLECMDEXECOPT): OleVariant; overload;
    function ExecCommand(const ACmdID: OLECMDID; ACmdExecOpt: OLECMDEXECOPT; AInVar: OleVariant): OleVariant; overload;
    function QueryStatus(const ACmdID: OLECMDID): OLECMDF;
    procedure LoadDocumentFromStream(const AStream: TStream);
    procedure NewDocument;
    procedure SaveDocumentToStream(const AStream: TStream);
    procedure RegisterTags(const ANamespace: string; ATags: array of string);
    function HasElementViewLink(AElement: IHTMLElement): Boolean;
    procedure UpdateViewLinkContent(AElement: IHTMLElement);
    procedure Wait;

    property Bar: IcxHTMLEditorBar read FBar write FBar;
    property BaseURL: string read FBaseURL write SetBaseURL;
    property BrowseMode: Boolean read GetBrowseMode write SetBrowseMode;
    property Busy: Boolean read GetBusy;
    property Body: IHTMLBodyElement read GetBody;
    property BodyElement: IHTMLElement read GetBodyElement;
    property ControlInterface: IWebBrowser2 read GetControlInterface;
    property DocumentReady: Boolean read GetDocumentReady;
    property DocumentHTML: string read GetDocumentHTML write SetDocumentHTML;
    property Document: IHTMLDocument2 read GetDocument;
    property Document3: IHTMLDocument3 read GetDocument3;
    property Document4: IHTMLDocument4 read GetDocument4;
    property Selection: TcxHTMLSelection read FSelection;
    property State: TcxHTMLEditorState read FState;
    property Modified: Boolean read GetModified write SetModified;
    property UndoManager: TcxHTMLUndoManager read FUndoManager;
    property OnControlInsert: TcxControlInsertEvent read FOnControlInsert write FOnControlInsert;
    property OnControlInserted: TcxControlInsertedEvent read FOnControlInserted write FOnControlInserted;
    property OnDocumentComplete: TNotifyEvent read FOnDocumentComplete write FOnDocumentComplete;
    property OnDocumentChange: TNotifyEvent read FOnDocumentChange write FOnDocumentChange;
    property OnMoved: TNotifyEvent read FOnMoved write FOnMoved;
    property OnParentChanged: TcxParentChangedEvent read FOnParentChanged write FOnParentChanged;
    property OnResized: TNotifyEvent read FOnResized write FOnResized;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnShowContextMenu: TcxHTMLEditorContextMenuEvent read FOnShowContextMenu write FOnShowContextMenu;
  end;

var
  cxWebHTMLDesignerMajorVersion: Integer = 5;

  function IsEqualElement(const Element1, Element2: IHTMLElement): Boolean;

implementation

uses Messages, ComObj, cxWebHTMLConsts, Types, Variants, cxWebUtils, cxWebDsgnStrs;

const
  URLBlank = 'about:Blank'; // Do not localize

function IsEqualElement(const Element1, Element2: IHTMLElement): Boolean;
begin
  Result := False;
  if (Element1 = nil) or (Element2 = nil) then Exit;
  Result := Element1.sourceIndex = Element2.sourceIndex;
end;

{ TcxHTMLDocHostUIHandler }

constructor TcxHTMLDocHostUIHandler.Create(AEditor: TcxHTMLEditor);
begin
  inherited Create;
  FEditor := AEditor;
end;

function TcxHTMLDocHostUIHandler.EnableModeless(fEnable: Integer): HResult;
begin
  { OnEnable/Disable modeless UI }
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.FilterDataObject(const pDO: IInterface;
  var ppDORet: IInterface): HResult;
begin
  { implement to support additional clipboard formats }
  ppDORet := nil;
  Result := S_FALSE;
end;

function TcxHTMLDocHostUIHandler.GetDropTarget(
  const pDropTarget: IInterface; var ppDropTarget: IInterface): HResult;
begin
  { implement to supply an alternative drop target }
  Result := E_NOTIMPL;
end;

function TcxHTMLDocHostUIHandler.GetExternal(
  var ppDispatch: IDispatch): HResult;
begin
  { implement to expose an automation interface}
  ppDispatch := nil;
  Result := S_FALSE;
end;

function TcxHTMLDocHostUIHandler.GetHostInfo(
  var pInfo: DOCHOSTUIINFO): HResult;
begin
  pInfo.dwFlags := DOCHOSTUIFLAG_DISABLE_HELP_MENU or
    DOCHOSTUIFLAG_OPENNEWWIN or
    DOCHOSTUIFLAG_ACTIVATE_CLIENTHIT_ONLY or
    DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE or
    DOCHOSTUIFLAG_FLAT_SCROLLBAR or
    DOCHOSTUIFLAG_NO3DBORDER or
    DOCHOSTUIFLAG_DIV_BLOCKDEFAULT;
  pInfo.dwDoubleClick := DOCHOSTUIDBLCLK_DEFAULT;
//  pInfo.pchHostNS; investigate
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.GetOptionKeyPath(out pchKey: PWideChar;
  dw: LongWord): HResult;
begin
  { implement to store individual registry settings }
  Result := E_NOTIMPL;
end;

function TcxHTMLDocHostUIHandler.HideUI: HResult;
begin
  if FEditor.Bar <> nil then
  begin
    FEditor.Bar.DisableUI(True);
    FEditor.Bar.UpdateActionControls;
  end;
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.OnDocWindowActivate(
  fActivate: Integer): HResult;
begin
  { OnDocumentActivate/Deactivate }
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.OnFrameWindowActivate(
  fActivate: Integer): HResult;
begin
  { OnFrameActivate/Deactivate (top-level) }
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.ResizeBorder(var prcBorder: Integer;
  const pUIWindow: IInterface; fRameWindow: Integer): HResult;
begin
  { OnResizeFrame/Document }
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.ShowContextMenu(dwID: LongWord;
  ppt: PPoint; const pcmdtReserved: IInterface;
  const pdispReserved: IDispatch): HResult;
var
  Element: IHTMLElement;
begin
  if Assigned(FEditor.FOnShowContextMenu) then
  begin
    Supports(pdispReserved, IHTMLElement, Element);
    FEditor.FOnShowContextMenu(FEditor, ppt^, Element);
  end;
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.ShowHelp(hwnd: THandle;
  pszHelpFile: PWideChar; uCommand: LongWord; dwData: LongWord;
  ptMouse: TPoint; var pDispatchObjectHit: IDispatch): HResult;
begin
  {OnHelp}
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.ShowMessage(hwnd: THandle; lpstrText,
  lpstrCaption: PWideChar; dwType: LongWord; lpstrHelpFile: PWideChar;
  dwHelpContext: LongWord; var plResult: LongInt): HResult;
begin
  { OnShowMessage }
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.ShowUI(dwID: LongWord;
  const pActiveObject, pCommandTarget, pFrame, pDoc: IInterface): HResult;
begin
  if FEditor.Bar <> nil then
  begin
    FEditor.Bar.DisableUI(dwID = DOCHOSTUITYPE_BROWSE);
    FEditor.Bar.SetCommandTarget(FEditor.CommandTarget);
    FEditor.Bar.UpdateActionControls;
  end;
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.TranslateAccelerator(lpmsg: PMsg;
  pguidCmdGroup: PGUID; nCmdID: LongWord): HResult;

  function IsCtrlDown: Boolean;
  begin
    Result := GetAsyncKeyState(VK_CONTROL) < 0;
  end;

  function IsShiftDown: Boolean;
  begin
    Result := GetAsyncKeyState(VK_SHIFT) < 0;
  end;

begin
  { implement to handle key pressing }
  Result := E_NOTIMPL;
  { Suppress some WebBrowser accelerators }
  if ((lpmsg^.message = WM_KEYDOWN) or (lpmsg^.message = WM_KEYUP)) and
    IsCtrlDown and (lpmsg^.wParam in [Ord('P'), Ord('N'), Ord('Y')]) then
    Result := S_OK;
  { Override Undo/Redo accelerators }
  if (lpmsg^.message = WM_KEYDOWN) and IsCtrlDown and
     (lpmsg^.wParam = Ord('Z')) then
  begin
    Result := S_OK;
    if IsShiftDown then
      FEditor.UndoManager.Redo
    else
    begin
      FEditor.UndoManager.Undo;
      Result := S_FALSE;
      //TODO
    end;
  end;
  { Move/Resize selected controls }
  if (lpmsg^.message = WM_KEYDOWN) and
     (FEditor.Selection.SelType = stControl) and
     (lpmsg^.wParam in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
    if IsCtrlDown then
    begin
      FEditor.StartMoveSelectionByKey(lpmsg^.wParam, IsShiftDown);
      Result := S_OK;
    end
    else
      if IsShiftDown then
      begin
        FEditor.StartResizeSelectionByKey(lpmsg^.wParam);
        Result := S_OK;
      end;
  if (lpmsg^.message = WM_KEYUP) and
     (FEditor.Selection.SelType = stControl) and
     (lpmsg^.wParam in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT]) then
  begin
    FEditor.EndMoveSelectionByKey;
    FEditor.EndResizeSelectionByKey;
    Result := S_OK;
  end;
end;

function TcxHTMLDocHostUIHandler.TranslateUrl(dwTranslate: LongWord;
  const pchURLIn: PWideChar; out ppchURLOut: PWideChar): HResult;
var
  NewURL: WideString;
begin
  { implement to modify the URL to be loaded }
  ppchURLOut := nil;
  if not SameText(pchURLIn, URLBlank) and not FEditor.BrowseMode then
  begin
    NewURL := URLBlank;
    ppchURLOut := PWideChar(NewURL);
  end;
  Result := S_OK;
end;

function TcxHTMLDocHostUIHandler.UpdateUI: HResult;
begin
  if FEditor.Bar <> nil then
    FEditor.Bar.UpdateActionControls;
  Result := S_OK;
end;

{ TcxHTMLOleCommandTarget }

constructor TcxHTMLOleCommandTarget.Create(AEditor: TcxHTMLEditor);
begin
  inherited Create;
  FEditor := AEditor;
end;

function TcxHTMLOleCommandTarget.Exec(CmdGroup: PGUID; nCmdID,
  nCmdexecopt: DWORD; vaIn, vaOut: PVariantArg): HResult;
var
  Command: string;
begin
  Result := S_FALSE;
  if IsEqualGUID(CmdGroup^, CGID_MSHTML) then
    case nCmdID of
      IDM_TABLESELECT:
      begin
        TableSelect;
        Result := S_OK;
      end;
      IDM_ROWSELECT:
      begin
        RowSelect;
        Result := S_OK;
      end;
      IDM_COLUMNSELECT:
      begin
        ColSelect;
        Result := S_OK;
      end;
      IDM_CELLSELECT:
      begin
        CellSelect;
        Result := S_OK;
      end;
      IDM_TABLEINSERT:
      begin
        TableInsert;
        Result := S_OK;
      end;
      IDM_ROWINSERT:
      begin
        RowInsert;
        Result := S_OK;
      end;
      IDM_ROWINSERTBELOW:
      begin
        RowInsert(True);
        Result := S_OK;
      end;
      IDM_COLUMNINSERT:
      begin
        ColInsert;
        Result := S_OK;
      end;
      IDM_COLUMNINSERTRIGHT:
      begin
        ColInsert(True);
        Result := S_OK;
      end;
      IDM_CELLINSERT:
      begin
        CellInsert;
        Result := S_OK;
      end;
      IDM_CELLMERGE:
      begin
        CellMerge;
        Result := S_OK;
      end;
      IDM_CELLSPLIT:
      begin
        CellSplit;
        Result := S_OK;
      end;
      IDM_TABLEDELETE:
      begin
        TableDelete;
        Result := S_OK;
      end;
      IDM_ROWDELETE:
      begin
        RowDelete;
        Result := S_OK;
      end;
      IDM_COLUMNDELETE:
      begin
        ColDelete;
        Result := S_OK;
      end;
      IDM_CELLDELETE:
      begin
        CellDelete;
        Result := S_OK;
      end;
      IDM_FRAMEINSLEFT:
      begin
        FrameInsert(fsLeft);
        Result := S_OK;
      end;
      IDM_FRAMEINSRIGHT:
      begin
        FrameInsert(fsRight);
        Result := S_OK;
      end;
      IDM_FRAMEINSTOP:
      begin
        FrameInsert(fsTop);
        Result := S_OK;
      end;
      IDM_FRAMEINSBOTTOM:
      begin
        FrameInsert(fsBottom);
        Result := S_OK;
      end;
      IDM_FRAMEDELETE:
      begin
        FrameDelete;
        Result := S_OK;
      end;
      IDM_FRAMEINSERT:
      begin
        WholeFrameInsert;
        Result := S_OK;
      end;
      IDM_UNDO:
      begin
        Command := BeforeUndoRedo(IDM_UNDO);
        Result := GetWBCommandTarget.Exec(@CGID_MSHTML, IDM_UNDO, nCmdexecopt, vaIn, vaOut);
        AfterUndoRedo(Command);
      end;
      IDM_REDO:
      begin
        Command := BeforeUndoRedo(IDM_REDO);
        Result := GetWBCommandTarget.Exec(@CGID_MSHTML, IDM_REDO, nCmdexecopt, vaIn, vaOut);
        AfterUndoRedo(Command);
      end;
{      IDM_PASTE:
      begin
        FEditor.UndoManager.BeginUndoBlock('Paste');
        Result := GetWBCommandTarget.Exec(CmdGroup, nCmdID, nCmdexecopt, vaIn, vaOut);
        //FEditor.UndoManager.EndUndoBlock;
      end; }
    end;
  if Result <> S_OK then
    Result := GetWBCommandTarget.Exec(CmdGroup, nCmdID, nCmdexecopt, vaIn, vaOut);
end;

function TcxHTMLOleCommandTarget.QueryStatus(CmdGroup: PGUID;
  cCmds: Cardinal; prgCmds: POleCmd; CmdText: POleCmdText): HResult;

  procedure CmdSupported(AValue: Boolean);
  begin
    if AValue then
      prgCmds^.cmdf := prgCmds^.cmdf or OLECMDF_SUPPORTED
    else
      prgCmds^.cmdf := prgCmds^.cmdf and not OLECMDF_SUPPORTED;
  end;

  procedure CmdEnabled(AValue: Boolean);
  begin
    if AValue then
      prgCmds^.cmdf := prgCmds^.cmdf or OLECMDF_ENABLED
    else
      prgCmds^.cmdf := prgCmds^.cmdf and not OLECMDF_ENABLED;
  end;

  procedure CmdLatched(AValue: Boolean);
  begin
    if AValue then
      prgCmds^.cmdf := prgCmds^.cmdf or OLECMDF_LATCHED
    else
      prgCmds^.cmdf := prgCmds^.cmdf and not OLECMDF_LATCHED;
  end;

{var
  Status: string;}
begin
  Result := S_FALSE;
  if (cCmds = 1) and IsEqualGUID(CmdGroup^, CGID_MSHTML) then
    case prgCmds^.cmdID of
      IDM_TABLESELECT:
      begin
        CmdSupported(True);
        CmdEnabled(CanTableSelect);
        Result := S_OK;
      end;
      IDM_ROWSELECT:
      begin
        CmdSupported(True);
        CmdEnabled(CanRowSelect);
        Result := S_OK;
      end;
      IDM_COLUMNSELECT:
      begin
        CmdSupported(True);
        CmdEnabled(CanColSelect);
        Result := S_OK;
      end;
      IDM_CELLSELECT:
      begin
        CmdSupported(True);
        CmdEnabled(CanCellSelect);
        Result := S_OK;
      end;
      IDM_TABLEINSERT:
      begin
        CmdSupported(True);
        CmdEnabled(CanTableInsert);
        Result := S_OK;
      end;
      IDM_ROWINSERT, IDM_ROWINSERTBELOW:
      begin
        CmdSupported(True);
        CmdEnabled(CanRowInsert);
        Result := S_OK;
      end;
      IDM_COLUMNINSERT, IDM_COLUMNINSERTRIGHT:
      begin
        CmdSupported(True);
        CmdEnabled(CanColInsert);
        Result := S_OK;
      end;
      IDM_CELLINSERT:
      begin
        CmdSupported(True);
        CmdEnabled(CanCellInsert);
        Result := S_OK;
      end;
      IDM_CELLMERGE:
      begin
        CmdSupported(True);
        CmdEnabled(CanCellMerge);
        Result := S_OK;
      end;
      IDM_CELLSPLIT:
      begin
        CmdSupported(True);
        CmdEnabled(CanCellSplit);
        Result := S_OK;
      end;
      IDM_TABLEDELETE:
      begin
        CmdSupported(True);
        CmdEnabled(CanTableDelete);
        Result := S_OK;
      end;
      IDM_ROWDELETE:
      begin
        CmdSupported(True);
        CmdEnabled(CanRowDelete);
        Result := S_OK;
      end;
      IDM_COLUMNDELETE:
      begin
        CmdSupported(True);
        CmdEnabled(CanColDelete);
        Result := S_OK;
      end;
      IDM_CELLDELETE:
      begin
        CmdSupported(True);
        CmdEnabled(CanCellDelete);
        Result := S_OK;
      end;
      IDM_FRAMEINSLEFT, IDM_FRAMEINSRIGHT, IDM_FRAMEINSTOP, IDM_FRAMEINSBOTTOM,
      IDM_FRAMEDELETE:
      begin
        CmdSupported(True);
        CmdEnabled(CanFrame);
        Result := S_OK;
      end;
      IDM_FRAMEINSERT:
      begin
        CmdSupported(True);
        CmdEnabled(CanWholeFrame);
        Result := S_OK;
      end;
      IDM_UNDO:
      if CmdText <> nil then
      begin
        //TODO
{        Result := GetWBCommandTarget.QueryStatus(CmdGroup, cCmds, prgCmds, nil);
        if (prgCmds^.cmdf and OLECMDF_ENABLED) = OLECMDF_ENABLED then
          Status := scxCmdUndo + ' ' + FEditor.UndoManager.UndoDesctiption
        else
          Status := scxCmdCantUndo;
        CmdText^.cwActual := Length(Status);
        StringToWideChar(Status, CmdText^.rgwz, CmdText^.cwBuf);
}       Result := S_OK;
      end;
      IDM_REDO:
      if CmdText <> nil then
      begin
        //TODO
{        Result := GetWBCommandTarget.QueryStatus(CmdGroup, cCmds, prgCmds, nil);
        if (prgCmds^.cmdf and OLECMDF_ENABLED) = OLECMDF_ENABLED then
          Status := scxCmdRedo + ' ' + FEditor.UndoManager.RedoDesctiption
        else
          Status := scxCmdCantRedo;
        CmdText^.cwActual := Length(Status);
        StringToWideChar(Status, CmdText^.rgwz, CmdText^.cwBuf);
}
        Result := S_OK;
      end;
      IDM_UNLINK:
      begin
        Result := GetWBCommandTarget.QueryStatus(CmdGroup, cCmds, prgCmds, nil);
        if IsViewLinkSelected then
          CmdEnabled(False);
      end;
    end;
  if Result <> S_OK then
    Result := GetWBCommandTarget.QueryStatus(CmdGroup, cCmds, prgCmds, nil);
end;

function TcxHTMLOleCommandTarget.GetWBCommandTarget: IcxOleCommandTarget;
begin
  FEditor.ControlInterface.QueryInterface(IcxOleCommandTarget, Result);
end;

function TcxHTMLOleCommandTarget.CanTableInsert: Boolean;
begin
  Result := (FEditor.Selection.SelType <> stControl) and
    (FEditor.Selection.Count = 1);
end;

function TcxHTMLOleCommandTarget.CanCellInsert: Boolean;
begin
  Result := IsCellsSelected;
end;

function TcxHTMLOleCommandTarget.CanCellMerge: Boolean;
begin
  Result := (FEditor.Selection.Count > 1) and IsCellsSelected;
end;

function TcxHTMLOleCommandTarget.CanCellSelect: Boolean;
begin
  Result := False;
  // TODO: implement
end;

function TcxHTMLOleCommandTarget.CanCellSplit: Boolean;
begin
  Result := (FEditor.Selection.Count = 1) and IsCellsSelected;
end;

function TcxHTMLOleCommandTarget.CanTableDelete: Boolean;
var
  I: Integer;
  Table: IHTMLElement;
begin
  Result := False;
  if (FEditor.Selection.SelType = stControl) then
    Result := (FEditor.Selection.Count = 1) and
      Supports(FEditor.Selection[0], IHTMLTable)
  else
    if Supports(FindTableOf(FEditor.Selection[0]), IHTMLElement, Table) then
    begin
      Result := True;
      for I := 1 to FEditor.Selection.Count - 1 do
      begin
        Result := IsEqualElement(Table, FindTableOf(FEditor.Selection[I]) as IHTMLElement);
        if not Result then
          break;
      end;
    end;
end;

function TcxHTMLOleCommandTarget.CanRowDelete: Boolean;
begin
  Result := IsRowsSelected;
end;

function TcxHTMLOleCommandTarget.CanColDelete: Boolean;
begin
  Result := IsCellsSelected;
end;

function TcxHTMLOleCommandTarget.CanCellDelete: Boolean;
begin
  Result := IsCellsSelected;
end;

function TcxHTMLOleCommandTarget.CanColInsert: Boolean;
begin
  Result := IsCellsSelected;
end;

function TcxHTMLOleCommandTarget.CanColSelect: Boolean;
begin
  Result := False;
  // TODO: implement
end;

function TcxHTMLOleCommandTarget.CanRowInsert: Boolean;
begin
  Result := IsCellsSelected;
end;

function TcxHTMLOleCommandTarget.CanRowSelect: Boolean;
begin
  Result := False;
  // TODO: implement
end;

function TcxHTMLOleCommandTarget.CanTableSelect: Boolean;
begin
  Result := False;
  // TODO: implement
end;

procedure TcxHTMLOleCommandTarget.CellInsert;
var
  Cell: IHTMLTableCell;
  Row: IHTMLTableRow;
begin
  if not CanCellInsert then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdCellInsert);
  Cell := FindCellOf(FEditor.Selection[0]);
  Row := (Cell as IHTMLElement).parentElement as IHTMLTableRow;
  Row.insertCell(Cell.cellIndex);
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.CellMerge;
var
  I: Integer;
  Elements: IInterfaceList;
  FirstCell, CurCell: IHTMLTableCell;
begin
  if not CanCellMerge then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdCellMerge);
  Elements := TInterfaceList.Create;
  for I := 0 to FEditor.Selection.Count - 1 do
    Elements.Add(FEditor.Selection[I]);
  FirstCell := nil;
  for I := 0 to Elements.Count - 1 do
  begin
    CurCell := FindCellOf(Elements[I] as IHTMLElement);
    if CurCell <> nil then
      if FirstCell <> nil then
      begin
        FirstCell.colSpan := FirstCell.colSpan + CurCell.colSpan;
        (FirstCell as IHTMLElement).innerHTML := (FirstCell as IHTMLElement).innerHTML +
          (CurCell as IHTMLElement).innerHTML;
        (CurCell as IHTMLDOMNode).removeNode(True);
      end
      else
        FirstCell := CurCell;
  end;
  FEditor.DoSelectionChanged;
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.CellSelect;
begin
  if not CanCellSelect then Exit;
  // TODO: implement
end;

procedure TcxHTMLOleCommandTarget.CellSplit;
var
  Cell: IHTMLTableCell;
  Row: IHTMLTableRow;
  Table: IHTMLTable;
  I, RowIndex, CellIndex: Integer;
begin
  if not CanCellSplit then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdCellSplit);
  Cell := FindCellOf(FEditor.Selection[0]);
  Row := (Cell as IHTMLElement).parentElement as IHTMLTableRow;
  CellIndex := GetCellAbsIndex(Row, Cell.cellIndex);
  RowIndex := Row.rowIndex;
  Table := FindTableOf(Cell as IHTMLElement);
  Row.insertCell(Cell.cellIndex + 1);
  if Cell.colSpan > 1 then
    UpdateCellColSpan(Cell, -1)
  else
    if Table <> nil then
      for I := 0 to Table.rows.length - 1 do
      begin
        Row := Table.rows.item(I, 0) as IHTMLTableRow;
        if Row.rowIndex <> RowIndex then
          UpdateCellColSpan(GetCellByAbsIndex(Row, CellIndex), 1)
      end;
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.CellDelete;
var
  I: Integer;
  Elements: IInterfaceList;
  CellNode: IHTMLDOMNode;
  Caret: IHTMLCaret;
begin
  if not CanCellDelete then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdCellDelete);
  Elements := TInterfaceList.Create;
  for I := 0 to FEditor.Selection.Count - 1 do
    Elements.Add(FEditor.Selection[I]);
  for I := Elements.Count - 1 downto 0 do
  begin
    CellNode := FindCellOf(Elements[I] as IHTMLElement) as IHTMLDOMNode;
    if CellNode <> nil then
      CellNode.removeNode(True);
  end;
  FEditor.Selection.Empty;
  Caret := FEditor.Selection.GetCaret;
  if Caret <> nil then
    Caret.Hide;
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.ColInsert(ToRight: Boolean = False);
var
  NewCell, Cell: IHTMLTableCell;
  Row: IHTMLTableRow;
  Table: IHTMLTable;
  I, CellIndex: Integer;
  Element: IHTMLElement;
  Element2: IHTMLElement2;
begin
  if not CanColInsert then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdColInsert);
  Cell := FindCellOf(FEditor.Selection[0]);
  Row := (Cell as IHTMLElement).parentElement as IHTMLTableRow;
  Table := FindTableOf(Row as IHTMLElement);
  CellIndex := GetCellAbsIndex(Row, Cell.cellIndex);
  if ToRight then
    Inc(CellIndex, Cell.colSpan);
  if (Cell.cellIndex = Row.cells.length - 1) and ToRight then
    for I := 0 to Table.rows.length - 1 do
    begin
      Row := Table.rows.item(I, 0) as IHTMLTableRow;
      Element := Row.cells.item(Row.cells.length - 1, 0) as IHTMLElement;
      Cell := Row.insertCell(-1) as IHTMLTableCell;
      // merge cell attributes
      Element2 := Cell as IHTMLElement2;
      Element2.mergeAttributes(Element);
      // remove colspan
      Element := Element2 as IHTMLElement;
      Element.removeAttribute('colspan', 0);
    end
  else
    for I := 0 to Table.rows.length - 1 do
    begin
      Row := Table.rows.item(I, 0) as IHTMLTableRow;
      Cell := GetCellByAbsIndex(Row, CellIndex);
      if GetCellAbsIndex(Row, Cell.cellIndex) = CellIndex then
      begin
        NewCell := Row.insertCell(Cell.cellIndex) as IHTMLTableCell;
        // merge cell attributes
        if ToRight then
          Element := Row.cells.item(NewCell.cellIndex - 1, 0) as IHTMLElement
        else
          Element := Row.cells.item(NewCell.cellIndex + 1, 0) as IHTMLElement;
        Element2 := NewCell as IHTMLElement2;
        Element2.mergeAttributes(Element);
        // remove colspan
        Element := Element2 as IHTMLElement;
        Element.removeAttribute('colspan', 0);
      end
      else
        UpdateCellColSpan(Cell, 1);
    end;
  FEditor.UndoManager.EndUndoBlock;
  //TODO: maintein rowspan
end;

procedure TcxHTMLOleCommandTarget.ColSelect;
begin
  if not CanColSelect then Exit;
  // TODO: implement
end;

procedure TcxHTMLOleCommandTarget.ColDelete;
var
  Elements: IInterfaceList;
  Caret: IHTMLCaret;
  Cell, NextCell: IHTMLTableCell;
  Row: IHTMLTableRow;
  Table: IHTMLTable;
  I, J, C, CellIndex, CellColSpan: Integer;
begin
  if not CanColDelete then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdColDelete);
  Elements := TInterfaceList.Create;
  for I := 0 to FEditor.Selection.Count - 1 do
    Elements.Add(FEditor.Selection[I]);
  for I := Elements.Count - 1 downto 0 do
  begin
    Cell := FindCellOf(Elements[I] as IHTMLElement);
    Row := (Cell as IHTMLElement).parentElement as IHTMLTableRow;
    Table := FindTableOf(Row as IHTMLElement);
    CellIndex := GetCellAbsIndex(Row, Cell.cellIndex);
    CellColSpan := Cell.colSpan;
    for J := 0 to Table.rows.length - 1 do
    begin
      Row := Table.rows.item(J, 0) as IHTMLTableRow;
      Cell := GetCellByAbsIndex(Row, CellIndex);
      if Cell <> nil then
        if Cell.colSpan > CellColSpan then
          UpdateCellColSpan(Cell, -CellColSpan)
        else
        begin
          C := 0;
          while (C < CellColSpan) and (Cell <> nil) do
          begin
            NextCell := (Cell as IHTMLDOMNode).nextSibling as IHTMLTableCell;
            Inc(C, Cell.colSpan);
            (Cell as IHTMLDOMNode).removeNode(True);
            Cell := NextCell;
          end;
        end;
    end;
  end;
  FEditor.Selection.Empty;
  Caret := FEditor.Selection.GetCaret;
  if Caret <> nil then
    Caret.Hide;
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.RowInsert(Below: Boolean = False);
var
  NewRow, Row: IHTMLTableRow;
  Table: IHTMLTable;
  RowIndex, I: Integer;
  Element: IHTMLElement;
  Element2: IHTMLElement2;
begin
  if not CanRowInsert then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdRowInsert);
  Row := (FindCellOf(FEditor.Selection[0]) as IHTMLElement).parentElement as IHTMLTableRow;
  Table := FindTableOf(Row as IHTMLElement);
  RowIndex := Row.rowIndex;
  if Below then
    Inc(RowIndex);
  NewRow := Table.insertRow(RowIndex) as IHTMLTableRow;
  for I := 0 to Row.cells.length - 1 do
    NewRow.insertCell(-1);
  // merge row attributes
  Element := Row as IHTMLElement;
  Element2 := NewRow as IHTMLElement2;
  Element2.mergeAttributes(Element);
  // merge cell attributes
  for I := 0 to Row.cells.length - 1 do
  begin
    Element := Row.cells.item(I, 0) as IHTMLElement;
    Element2 := NewRow.cells.item(I, 0) as IHTMLElement2;
    Element2.mergeAttributes(Element);
    // remove colspan
    Element := Element2 as IHTMLElement;
    Element.removeAttribute('rowspan', 0);
  end;
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.RowSelect;
begin
  if not CanRowSelect then Exit;
  // TODO: implement
end;

procedure TcxHTMLOleCommandTarget.RowDelete;
var
  I: Integer;
  Caret: IHTMLCaret;
  Elements: IInterfaceList;
  RowNode: IHTMLDOMNode;
begin
  if not CanRowDelete then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdRowDelete);
  Elements := TInterfaceList.Create;
  for I := 0 to FEditor.Selection.Count - 1 do
    Elements.Add(FEditor.Selection[I]);
  for I := Elements.Count - 1 downto 0 do
  begin
    RowNode := FindRowOf(Elements[I] as IHTMLElement) as IHTMLDOMNode;
    if RowNode <> nil then
      RowNode.removeNode(True);
  end;
  FEditor.Selection.Empty;
  Caret := FEditor.Selection.GetCaret;
  if Caret <> nil then
    Caret.Hide;
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.TableInsert;
begin
  // TODO: implement
end;

procedure TcxHTMLOleCommandTarget.TableSelect;
begin
  if not CanTableSelect then Exit;
  // TODO: implement
end;

procedure TcxHTMLOleCommandTarget.TableDelete;
var
  Table: IHTMLTable;
  Caret: IHTMLCaret;
begin
  if not CanTableDelete then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdTableDelete);
  Table := FindTableOf(FEditor.Selection[0]);
  if Table <> nil then
    (Table as IHTMLDOMNode).removeNode(True);
  Caret := FEditor.Selection.GetCaret;
  if Caret <> nil then
    Caret.Hide;
  FEditor.UndoManager.EndUndoBlock;
end;

function TcxHTMLOleCommandTarget.CanFrame: Boolean;
begin
  Result := IsFrameSelected;
end;

function TcxHTMLOleCommandTarget.CanWholeFrame: Boolean;
begin
  Result := Supports(FEditor.Document.activeElement, IHTMLFrameSetElement) and
    (FEditor.Document.frames.length = 0);
end;

procedure TcxHTMLOleCommandTarget.FrameDelete;

  function RemoveAsterix(S: string; AIndex: Integer): string;
  begin
    with TStringList.Create do
    try
      Delimiter := ',';
      DelimitedText := S;
      if AIndex < Count then
        Delete(AIndex);
      Result := DelimitedText;
    finally
      Free;
    end;
  end;

  procedure RemoveFrame(AFrame: IHTMLElement);
  var
    FrameSet: IHTMLFrameSetElement;
    FrameSetElement: IHTMLElement;
    Frames: IHTMLElementCollection;
    Node: IHTMLDOMNode;
    Index: Integer;
  begin
    Node := AFrame as IHTMLDOMNode;
    FrameSet := FindParentFrameset(AFrame);
    FrameSetElement := FrameSet as IHTMLElement;
    if FrameSet <> nil then
    begin
      Index := GetFrameIndex(FrameSetElement, AFrame);
      if Index <> -1 then
      begin
        if FrameSet.cols <> '' then
          FrameSet.cols := RemoveAsterix(FrameSet.cols, Index)
        else
         FrameSet.rows := RemoveAsterix(FrameSet.rows, Index);
        Node.parentNode.removeChild(Node);
        Frames := FrameSetElement.children as IHTMLElementCollection;
        if (Frames.length = 1) and
          (FindParentFrameset(FrameSetElement) <> nil) then
        begin
          Node := Frames.item(0, 0) as IHTMLDOMNode;
          if Supports(Frames.item(0, 0), IHTMLFrameBase) then
            (FrameSetElement as IHTMLDomNode).replaceNode(Node);
        end;
        if Frames.length = 0 then
          RemoveFrame(FrameSetElement);
      end;
    end;
  end;

var
  ActiveFrame: IHTMLFrameBase;
begin
  if not CanFrame then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdFrameDelete);
  ActiveFrame := FEditor.Selection.GetActiveFrame;
  RemoveFrame(ActiveFrame as IHTMLElement);
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.WholeFrameInsert;
var
  FrameSet: IHTMLFrameSetElement;
  Node, NewNode: IHTMLDOMNode;
begin
  if not CanWholeFrame then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdFrameInsert);
  FrameSet := FEditor.Document.ActiveElement as IHTMLFrameSetElement;
  Node := FrameSet as IHTMLDOMNode;
  NewNode := FEditor.Document.createElement('frame') as IHTMLDOMNode;
  Node.appendChild(NewNode);
  FrameSet.cols := '*';
  (NewNode as IHTMLElement3).setActive;
  FEditor.UndoManager.EndUndoBlock;
end;

procedure TcxHTMLOleCommandTarget.FrameInsert(ASide: TcxHTMLFrameSide);

  function InsertAsterix(S: string; AIndex: Integer): string;
  begin
    with TStringList.Create do
    try
      Delimiter := ',';
      DelimitedText := S;
      Insert(AIndex, '*');
      Result := DelimitedText;
    finally
      Free;
    end;
  end;

  function CreateFrameSet(var AReplaceNode: IHTMLDOMNode):
    IHTMLFrameSetElement;
  var
    FrameSetNode: IHTMLDOMNode;
  begin
    Result := FEditor.Document.createElement('frameset') as IHTMLFrameSetElement;
    FrameSetNode := Result as IHTMLDOMNode;
    AReplaceNode.swapNode(FrameSetNode);
    AReplaceNode := FrameSetNode.appendChild(AReplaceNode);
  end;

var
  ActiveFrame: IHTMLFrameBase;
  FrameSet: IHTMLFrameSetElement;
  ActiveNode, NewNode: IHTMLDOMNode;
  Index: Integer;
begin
  if not CanFrame then Exit;
  FEditor.UndoManager.BeginUndoBlock(scxCmdFrameInsert);
  ActiveFrame := FEditor.Selection.GetActiveFrame;
  ActiveNode := ActiveFrame as IHTMLDOMNode;
  FrameSet := FindParentFrameset(ActiveFrame as IHTMLElement);
  Index := GetFrameIndex(FrameSet as IHTMLElement, ActiveFrame as IHTMLElement);
  NewNode := FEditor.Document.createElement('frame') as IHTMLDOMNode;
  if ASide in [fsTop, fsBottom] then
  // horizontal
  begin
    if FrameSet.rows = '' then
    begin
      FrameSet := CreateFrameSet(ActiveNode);
      Index := 0;
      FrameSet.rows := InsertAsterix(FrameSet.rows, Index);
    end;
    if ASide = fsBottom then
      Inc(Index);
    FrameSet.rows := InsertAsterix(FrameSet.rows, Index);
  end
  else
  // vertical
  begin
    if FrameSet.cols = '' then
    begin
      FrameSet := CreateFrameSet(ActiveNode);
      Index := 0;
      FrameSet.cols := InsertAsterix(FrameSet.cols, Index);
    end;
    if ASide = fsRight then
      Inc(Index);
    FrameSet.cols := InsertAsterix(FrameSet.cols, Index);
  end;
  ActiveFrame := ActiveNode.parentNode.insertBefore(NewNode, ActiveNode) as IHTMLFrameBase;
  if ASide in [fsRight, fsBottom] then
    ActiveNode.swapNode(NewNode);
  (ActiveFrame as IHTMLElement3).setActive;
  FEditor.UndoManager.EndUndoBlock;
end;

function TcxHTMLOleCommandTarget.BeforeUndoRedo(ACmdID: Cardinal): string;
const
  BuffLen = 255;
var
  Cmd: TOleCmd;
  Text: POleCmdText;
begin
  Result := '';
  Cmd.cmdID := ACmdID;
  Cmd.cmdf := 0;
  GetMem(Text, SizeOf(TOleCmdText) + BuffLen * SizeOf(WideChar));
  try
    Text^.cmdtextf := OLECMDTEXTF_STATUS;
    Text^.cwBuf := BuffLen;
    Text^.cwActual := 0;
    if (QueryStatus(@CGID_MSHTML, 1, @Cmd, Text) = S_OK) and
      (Text^.cwActual > 0) then
      Result := WideCharToString(Text^.rgwz);
  finally
    FreeMem(Text);
  end;
end;

procedure TcxHTMLOleCommandTarget.AfterUndoRedo(const ACommand: string);
begin
{  if (Pos(scxCmdResize, ACommand) <> 0) and Assigned(FEditor.FOnResized) then
    FEditor.FOnResized(FEditor);
  if Pos(scxCmdMove, ACommand) <> 0 then
    FEditor.DoOnMoveEnd(nil); }
end;

function TcxHTMLOleCommandTarget.IsCellsSelected: Boolean;
var
  I: Integer;
begin
  Result := (FEditor.Selection.SelType <> stControl) and
    (FEditor.Selection.Count > 0);
  if Result then
    for I := 0 to FEditor.Selection.Count - 1 do
      Result := Result and (FindCellOf(FEditor.Selection[I]) <> nil);
end;

function TcxHTMLOleCommandTarget.IsRowsSelected: Boolean;
var
  I: Integer;
begin
  Result := (FEditor.Selection.SelType <> stControl) and
    (FEditor.Selection.Count > 0);
  if Result then
    for I := 0 to FEditor.Selection.Count - 1 do
      Result := Result and (FindRowOf(FEditor.Selection[I]) <> nil);
end;

function TcxHTMLOleCommandTarget.IsViewLinkSelected: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FEditor.Selection.Count - 1 do
  begin
    Result := FEditor.HasElementViewLink(FEditor.Selection[I]);
    if Result then break;
  end;
end;

function TcxHTMLOleCommandTarget.IsFrameSelected: Boolean;
begin
  Result := FEditor.Selection.GetActiveFrame <> nil;
end;

function TcxHTMLOleCommandTarget.FindParentFrameset(const AElement: IHTMLElement): IHTMLFrameSetElement;
var
  FrameSetElement: IHTMLElement;
begin
  FrameSetElement := AElement.parentElement;
  while (FrameSetElement <> nil) and not Supports(FrameSetElement, IHTMLFrameSetElement) do
    FrameSetElement := FrameSetElement.parentElement;
  Supports(FrameSetElement, IHTMLFrameSetElement, Result);
end;

function TcxHTMLOleCommandTarget.GetFrameIndex(AFrameSet, AFrame: IHTMLElement): Integer;
var
  Frames: IHTMLElementCollection;
  I, Cnt: Integer;
begin
  Result := -1;
  Cnt := -1;
  Frames := AFrameSet.children as IHTMLElementCollection;
  for I := 0 to Frames.length - 1 do
    if Supports(Frames.item(I, 0), IHTMLFrameElement) or
      Supports(Frames.item(I, 0), IHTMLFrameSetElement) then
    begin
      Inc(Cnt);
      if (Frames.item(I, 0) as IHTMLElement).sourceIndex = AFrame.sourceIndex then
      begin
        Result := Cnt;
        break;
      end;
    end;
end;

function TcxHTMLOleCommandTarget.FindCellOf(AElement: IHTMLElement): IHTMLTableCell;
var
  CellElement: IHTMLElement;
begin
  CellElement := AElement;
  while (CellElement <> nil) and not Supports(CellElement, IHTMLTableCell) do
    CellElement := CellElement.parentElement;
  Supports(CellElement, IHTMLTableCell, Result);
end;

function TcxHTMLOleCommandTarget.FindRowOf(AElement: IHTMLElement): IHTMLTableRow;
var
  RowElement: IHTMLElement;
begin
  RowElement := AElement;
  while (RowElement <> nil) and not Supports(RowElement, IHTMLTableRow) do
    RowElement := RowElement.parentElement;
  Supports(RowElement, IHTMLTableRow, Result);
end;

function TcxHTMLOleCommandTarget.FindTableOf(AElement: IHTMLElement): IHTMLTable;
var
  TableElement: IHTMLElement;
begin
  TableElement := AElement;
  while (TableElement <> nil) and not Supports(TableElement, IHTMLTable) do
    TableElement := TableElement.parentElement;
  Supports(TableElement, IHTMLTable, Result);
end;

function TcxHTMLOleCommandTarget.GetCellAbsIndex(ARow: IHTMLTableRow; AIndex: Integer): Integer;
var
  I: Integer;
  Cell: IHTMLTableCell;
begin
  Result := -1;
  for I := 0 to ARow.cells.length - 1 do
  begin
    Cell := ARow.cells.item(I, 0) as IHTMLTableCell;
    if Cell.cellIndex = AIndex then
    begin
      Inc(Result);
      break;
    end
    else
      Inc(Result, Cell.colSpan);
  end;
end;

function TcxHTMLOleCommandTarget.GetCellByAbsIndex(ARow: IHTMLTableRow; AIndex: Integer): IHTMLTableCell;
var
  I, AbsIndex: Integer;
begin
  Result := nil;
  AbsIndex := -1;
  for I := 0 to ARow.cells.length - 1 do
  begin
    Result := ARow.cells.item(I, 0) as IHTMLTableCell;
    Inc(AbsIndex, Result.colSpan);
    if AbsIndex >= AIndex then
      break;
  end;
end;

procedure TcxHTMLOleCommandTarget.UpdateCellColSpan(ACell: IHTMLTableCell; N: Integer);
begin
  if ACell <> nil then
    ACell.colSpan := ACell.colSpan + N;
end;

{ TcxHTMLSelection }

constructor TcxHTMLSelection.Create(AEditor: TcxHTMLEditor);
begin
  inherited Create;
  FEditor := AEditor;
end;

function TcxHTMLSelection.CanClear: Boolean;
begin
  Result := CanCommand(IDM_CLEARSELECTION);
end;

function TcxHTMLSelection.CanCopy: Boolean;
begin
  Result := CanCommand(IDM_COPY);
end;

function TcxHTMLSelection.CanCut: Boolean;
begin
  Result := CanCommand(IDM_CUT);
end;

function TcxHTMLSelection.CanDelete: Boolean;
begin
  Result := CanCommand(IDM_DELETE);
end;

function TcxHTMLSelection.CanPaste: Boolean;
begin
  Result := CanCommand(IDM_PASTE);
end;

function TcxHTMLSelection.CanSelectAll: Boolean;
begin
  Result := CanCommand(IDM_SELECTALL);
end;

procedure TcxHTMLSelection.Clear;
begin
  ExeCommand(IDM_CLEARSELECTION);
end;

procedure TcxHTMLSelection.Copy;
begin
  ExeCommand(IDM_COPY);
end;

procedure TcxHTMLSelection.Cut;
begin
  ExeCommand(IDM_CUT);
end;

procedure TcxHTMLSelection.Delete;
begin
  ExeCommand(IDM_DELETE);
end;

procedure TcxHTMLSelection.Empty;
begin
  if SelType <> stNone then
    GetSelectionObject.empty;
end;

function TcxHTMLSelection.IndexOf(AControl: IHTMLElement): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AControl = nil then Exit;
  for I := 0 to Count - 1 do
    if (Controls[I] <> nil) and (Controls[I].sourceIndex = AControl.sourceIndex) then
    begin
      Result := I;
      break;
    end;
end;

function TcxHTMLSelection.Last: IHTMLElement;
var
  CountLoc: Integer;
begin
  CountLoc := GetCount;
  if CountLoc > 0 then
    Result := GetControl(CountLoc - 1)
  else
    Result := nil;
end;

procedure TcxHTMLSelection.Paste;
begin
  ExeCommand(IDM_PASTE);
end;

procedure TcxHTMLSelection.Remove(AControl: IHTMLElement);
var
  Index: Integer;
  Range: IHTMLControlRange;
begin
  Index := IndexOf(AControl);
  if Index <> -1 then
  begin
    Range := ControlRange;
    if Range <> nil then
      try
        Range.remove(Index);
        Range.select;
      except  
      end;
  end;
end;

procedure TcxHTMLSelection.SelectAll;
begin
  ExeCommand(IDM_SELECTALL);
end;

function TcxHTMLSelection.CanCommand(const ACmdID: OLECMDID): Boolean;
begin
  Result := FEditor <> nil;
  if Result then
    Result := (FEditor.QueryStatus(ACmdID) and OLECMDF_ENABLED) = OLECMDF_ENABLED;
end;

procedure TcxHTMLSelection.ExeCommand(const ACmdID: OLECMDID);
begin
  if FEditor = nil then Exit;
  FEditor.ExecCommand(ACmdID, OLECMDEXECOPT_DONTPROMPTUSER);
end;

function TcxHTMLSelection.GetAbsolutePosition: Boolean;
begin
  Result := CanCommand(IDM_2D_ELEMENT);
  if Result then
    Result := FEditor.ExecCommand(IDM_2D_ELEMENT, OLECMDEXECOPT_DONTPROMPTUSER);
end;

procedure TcxHTMLSelection.SetAbsolutePosition(const Value: Boolean);
begin
  if CanCommand(IDM_ABSOLUTE_POSITION) then
    FEditor.ExecCommand(IDM_ABSOLUTE_POSITION, OLECMDEXECOPT_DONTPROMPTUSER, Value);
end;

function TcxHTMLSelection.GetCaret: IHTMLCaret;
begin
  Result := nil;
  if FEditor.DisplayServices <> nil then
    FEditor.DisplayServices.GetCaret(Result);
end;

function TcxHTMLSelection.GetControl(Index: Integer): IHTMLElement;
var
  EList: TInterfaceList;
begin
  Result := nil;
  if Supports(GetActiveFrame, IHTMLElement, Result) then
    Exit;
  if ControlRange <> nil then
    Result := ControlRange.item(Index);
  if (Result = nil) and (TextRange <> nil) then
  begin
    EList := TInterfaceList.Create;
    try
      if GetElementsFromTextRange(EList) > 0 then
        Result := EList.Items[Index] as IHTMLElement;
    finally
      EList.Free;
    end;
  end;
  if Result = nil then
    Result := GetElementFromCaret;
  if not FEditor.CanElementSelect(Result) then
    Result := nil;
	end;

function TcxHTMLSelection.GetCount: Integer;
begin
  Result := 0;
  if GetActiveFrame <> nil then
    Result := 1
  else
  if ControlRange <> nil then
    Result := ControlRange.length
  else
    if TextRange <> nil then
      Result := GetElementsFromTextRange(nil)
    else
      if GetElementFromCaret <> nil then
        Result := 1;
end;

function TcxHTMLSelection.GetElementFromCaret: IHTMLElement;
var
  Caret: IHTMLCaret;
  CaretPos: TPoint;
  Visible: Integer;
begin
  Result := nil;
  Caret := GetCaret;
  if Caret <> nil then
  begin
    Caret.IsVisible(Visible);
    if Visible = Ord(True) then
    begin
      Caret.GetLocation(@CaretPos, 1);
      Result := FEditor.Document.elementFromPoint(CaretPos.X, CaretPos.Y);
    end;
  end;
end;

function TcxHTMLSelection.GetElementsFromTextRange(AElements: TInterfaceList): Integer;
var
  BP, EP: IMarkupPointer;
  StartElement, EndElement, Element: IHTMLElement;
  I: Integer;
  Elements: IHTMLElementCollection;
  InsideRange: Boolean;
begin
  Result := 0;
  if AElements <> nil then
    AElements.Clear;
  if TextRange = nil then Exit;
  with FEditor.MarkupServices do
  begin
    CreateMarkupPointer(BP);
    CreateMarkupPointer(EP);
    MovePointersToRange(TextRange, BP, EP);
  end;
  if BP <> nil then
    BP.CurrentScope(StartElement)
  else
    StartElement := nil;
  if EP <> nil then
    EP.CurrentScope(EndElement)
  else
    EndElement := nil;
  if (StartElement = nil) and (EndElement = nil) then
    Exit;
  if (StartElement <> nil) and (EndElement = nil) then
  begin
    if AElements <> nil then
      AElements.Add(StartElement);
    Result := 1;
    Exit;
  end;
  if (EndElement <> nil) and (StartElement = nil) then
  begin
    if AElements <> nil then
      AElements.Add(EndElement);
    Result := 1;
    Exit;
  end;
  if IsEqualElement(StartElement, EndElement) then
  begin
    if AElements <> nil then
      AElements.Add(StartElement);
    Result := 1;
    Exit;
  end;
  Elements := TextRange.parentElement.children as IHTMLElementCollection;
  InsideRange := False;
  for I := 0 to Elements.length - 1 do
  begin
    Element := Elements.item(I, 0) as IHTMLElement;
    if not InsideRange then
      InsideRange := IsEqualElement(Element, StartElement) or
        Element.contains(StartElement);
    if InsideRange then
    begin
      if AElements <> nil then
        AElements.Add(Element);
      Inc(Result);
      if IsEqualElement(Element, EndElement) or
        Element.contains(EndElement) then
        break;
    end;
  end;
end;

function TcxHTMLSelection.GetSelType: TcxHTMLSelectionType;
var
  SelObj: IHTMLSelectionObject;
  TypeAsStr: string;
begin
   Result := stNone;
   SelObj := GetSelectionObject;
   if SelObj = nil then Exit;
   TypeAsStr := SelObj.type_;
   if SameText(TypeAsStr, 'control') then
     Result := stControl
   else
     if SameText(TypeAsStr, 'text') then
       Result := stText;
end;

function TcxHTMLSelection.GetSelectionObject: IHTMLSelectionObject;
begin
  if FEditor.Document <> nil then
    Result := FEditor.Document.selection
  else
    Result := nil;
end;

function TcxHTMLSelection.GetControlRange: IHTMLControlRange;
begin
  Result := nil;
  if SelType = stControl then
    Supports(GetSelectionObject.createRange, IHTMLControlRange, Result);
end;

function TcxHTMLSelection.GetTextRange: IHTMLTxtRange;
begin
  Result := nil;
  if SelType = stText then
    Supports(GetSelectionObject.createRange, IHTMLTxtRange, Result);
end;

procedure TcxHTMLSelection.Add(AControl: IHTMLElement);
var
  Range: IHTMLControlRange;
begin
  Range := ControlRange;
  if Range = nil then
  begin
    Empty;
    Range := CreateControlRange;
  end;
  if FEditor.CanElementSelect(AControl) then
  begin
    try  // Temporary solution for "invalid argument"
      (Range as IHTMLControlRange2).addElement(AControl);
      Range.select;
    except
    end;
  end;
end;

function TcxHTMLSelection.CreateControlRange: IHTMLControlRange;
begin
  Result := (FEditor.BodyElement as IHTMLElement2).createControlRange as
    IHTMLControlRange;
end;

function TcxHTMLSelection.GetActiveFrame: IHTMLFrameBase;
var
  FrameElement: IHTMLelement;
begin
  FrameElement := FEditor.Document.activeElement;
  while (FrameElement <> nil) and not Supports(FrameElement, IHTMLFrameBase) do
    FrameElement := FrameElement.parentElement;
  Supports(FrameElement, IHTMLFrameBase, Result);
end;

{ TcxHTMLEditor }

{ TcxHTMLEditor public }

constructor TcxHTMLEditor.Create(AOwner: TComponent; ABrowseMode: Boolean = False);
begin
  inherited Create(AOwner);
  FInternalBrowseMode := ABrowseMode;
  FModified := False;
  FPrimaryMCId := 0;
  FBaseURL := '';
  FNamespaces := TInterfaceList.Create;
  FDocEventSink := TcxHTMLDocEventSink.Create(nil);
  FDocEventSinkIntf := FDocEventSink;
  FHostUIHandler := TcxHTMLDocHostUIHandler.Create(Self);
  FCommandTarget := TcxHTMLOleCommandTarget.Create(Self) as IcxOleCommandTarget;
  FSelection := TcxHTMLSelection.Create(Self);
  FUndoManager := TcxHTMLUndoManager.Create(Self);
  NewDocument;
  Wait;
  BrowseMode := ABrowseMode;
end;

destructor TcxHTMLEditor.Destroy;
begin
  UnlinkChangeSink;
  FDocEventSinkIntf.Disconnect;
  inherited;
  FUndoManager.Free;
  FSelection.Free;
  FHostUIHandler.Free;
end;

function TcxHTMLEditor.ExecCommand(const ACmdID: OLECMDID;
  ACmdExecOpt: OLECMDEXECOPT): OleVariant;
begin
  VarClear(Result);
  CommandTarget.Exec(@CGID_MSHTML, ACmdID, ACmdExecOpt, nil, @Result);
end;

function TcxHTMLEditor.ExecCommand(const ACmdID: OLECMDID;
  ACmdExecOpt: OLECMDEXECOPT; AInVar: OleVariant): OleVariant;
begin
  VarClear(Result);
  CommandTarget.Exec(@CGID_MSHTML, ACmdID, ACmdExecOpt, @AInVar, @Result);
end;

function TcxHTMLEditor.QueryStatus(const ACmdID: OLECMDID): OLECMDF;
var
  Cmd: TOleCmd;
begin
  Cmd.cmdID := ACmdID;
  Cmd.cmdf := 0;
  CommandTarget.QueryStatus(@CGID_MSHTML, 1, @Cmd, nil);
  Result := Cmd.cmdf;
end;

procedure TcxHTMLEditor.LoadDocumentFromStream(const AStream: TStream);
var
  OleStream: IStream;
  PersistStream: IPersistStreamInit;
begin
  if Busy then
    ControlInterface.Stop;
  if Supports(ControlInterface.Document, IPersistStreamInit, PersistStream) then
  begin
    OleCheck(PersistStream.InitNew);
    OleStream := TStreamAdapter.Create(AStream);
    OleCheck(PersistStream.Load(OleStream));
    Modified := False;
    FBaseURL := '';
  end;
end;

procedure TcxHTMLEditor.NewDocument;
var
  NavFlags: OleVariant;
  PersistStream: IPersistStreamInit;
begin
  NavFlags := navNoHistory or navNoReadFromCache or navNoWriteToCache;
  ControlInterface.Stop;
  ControlInterface.Navigate(URLBlank, NavFlags, EmptyParam, EmptyParam, EmptyParam);
  if Supports(ControlInterface.Document, IPersistStreamInit, PersistStream) then
    OleCheck(PersistStream.InitNew);
  Modified := False;
  FBaseURL := '';
end;

procedure TcxHTMLEditor.SaveDocumentToStream(const AStream: TStream);
var
  OleStream: IStream;
  PersistStream: IPersistStreamInit;
begin
  Wait;
  if Supports(ControlInterface.Document, IPersistStreamInit, PersistStream) then
  begin
//  OleCheck(PersistStream.InitNew);
    OleStream := TStreamAdapter.Create(AStream);
    OleCheck(PersistStream.Save(OleStream, True));
    Modified := False;
  end;
end;

procedure TcxHTMLEditor.RegisterTags(const ANamespace: string; ATags: array of string);
var
  Namespace: IcxHTMLNamespace;
  VFactory: OleVariant;
  SP: IServiceProvider;
  NST: IElementNamespaceTable;
begin
  Namespace := FindNamespace(ANamespace);
  if Namespace = nil then
    Namespace := AddNamespace(ANamespace);
  Namespace.AddTags(ATags);
  TVarData(VFactory).VType := VT_UNKNOWN;
  TVarData(VFactory).VUnknown := Pointer(Namespace as IElementNamespaceFactory);
  Namespace._AddRef;
  if Supports(Document, IServiceProvider, SP) and
    (SP.QueryService(IElementNamespaceTable, IElementNamespaceTable, NST) = S_OK) then
    begin
      NST.AddNamespace(ANamespace, '', ELEMENTNAMESPACEFLAGS_QUERYFORUNKNOWNTAGS, VFactory); {Creates a normal namespace}
    end;
end;

function TcxHTMLEditor.HasElementViewLink(AElement: IHTMLElement): Boolean;
begin
  Result := FindElementBehavior(AElement) <> nil;
end;

procedure TcxHTMLEditor.UpdateViewLinkContent(AElement: IHTMLElement);
var
  Behavior: IcxHTMLBehaviorViewLink;
begin
  Behavior := FindElementBehavior(AElement);
  if Behavior <> nil then
    Behavior.UpdateContent; 
end;

procedure TcxHTMLEditor.Wait;
begin
  while Busy do
    ProcessMessages;
end;

{ TcxHTMLEditor protected }

procedure TcxHTMLEditor.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IWebBrowser2;
  end;

begin
  if FIntf = nil then DoCreate;
end;

{$WRITEABLECONST ON}
procedure TcxHTMLEditor.InitControlData;
const
  CEventDispIDs: array [0..2] of DWORD =
    (DISPID_DOCUMENTCOMPLETE, DISPID_BEFORENAVIGATE2, DISPID_NEWWINDOW2);
  CControlData: TControlData2 = (
    ClassID: '{8856F961-340A-11D0-A96B-00C04FD705A2}';
    EventIID: '{34A715A0-6587-11D0-924A-0020AFC7AC4D}';
    EventCount: 3;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80040154*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  FOnDocReady := DoOnDocumentReady;
  FOnBeforeNavigate := DoOnBeforeNavigate;
  FOnNewWindow := DoOnNewWindow;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnDocReady) - Cardinal(Self);
end;

procedure TcxHTMLEditor.AssignEvents;
begin
  with FDocEventSink do
  begin
    OnActivate := DoOnActivate;
    OnSelectionChange := DoOnSelectionChange;
    OnKeyDown := DoOnKeyDown;
    OnClick := DoOnClick;
    OnMouseDown := DoOnMouseDown;
    OnMouseUp := DoOnMouseUp;
    OnDblClick := DoOnDblClick;
    OnMoveEnd := DoOnMoveEnd;
    OnMoveStart := DoOnMoveStart;
    OnResizeStart := DoOnResizeStart;
    OnResizeEnd := DoOnResizeEnd;
    OnFocusOut := DoOnFocusOut;
    OnDrop := DoOnDrop;
    OnDragStart := DoOnDragStart;
    OnDragEnd := DoOnDragEnd;
  end;
end;

procedure TcxHTMLEditor.DoOnActivate(const AEventObj: IHTMLEventObj);
begin
  if Supports(AEventObj.srcElement, IHTMLFrameBase) then
    DoSelectionChanged;
end;

procedure TcxHTMLEditor.DoOnDocumentReady(ASender: TObject; const pDisp: IDispatch;
  var URL: OleVariant);
begin
  FDocEventSinkIntf.Connect(Document);
  LinkChangeSink;
  AssignEvents;
  SetupControl;
  if Assigned(FOnDocumentComplete) then
    FOnDocumentComplete(Self);
  UndoManager.Clear;
  FState := esNormal;
end;

procedure TcxHTMLEditor.DoOnBeforeNavigate(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant;
  var Flags: OleVariant; var TargetFrameName: OleVariant; var PostData: OleVariant;
  var Headers: OleVariant; var Cancel: WordBool);
begin
  if not SameText(URL, URLBlank) and (Pos('res://', URL) = 0) then
    Cancel := True;
end;

procedure TcxHTMLEditor.DoOnNewWindow(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
begin
  Cancel := True;
end;

procedure TcxHTMLEditor.DoDocumentChange;
begin
  FModified := True;
  if Assigned(OnDocumentChange) then
    OnDocumentChange(Self);
end;

procedure TcxHTMLEditor.SetupControl;
begin
  ExecCommand(IDM_MULTIPLESELECTION, OLECMDEXECOPT_DODEFAULT, True);
  ExecCommand(IDM_2D_POSITION, OLECMDEXECOPT_DODEFAULT, True);
  ExecCommand(IDM_LIVERESIZE, OLECMDEXECOPT_DODEFAULT, True);
  ExecCommand(IDM_DISABLE_EDITFOCUS_UI, OLECMDEXECOPT_DODEFAULT, False);
  ExecCommand(IDM_SHOWZEROBORDERATDESIGNTIME, OLECMDEXECOPT_DODEFAULT, ShowBorders);
  ExecCommand(IDM_PRESERVEUNDOALWAYS, OLECMDEXECOPT_DODEFAULT, True);
  ExecCommand(IDM_PROTECTMETATAGS, OLECMDEXECOPT_DODEFAULT, True);
  //TODO: Show Details option
  AddGlobalBehaviors;
end;

procedure TcxHTMLEditor.SelectByRect(const AEventObj: IHTMLEventObj; const ARect: TRect);
var
  I: Integer;
  AElements: IInterfaceList;
  Element: IHTMLElement;
begin
  if IsToolSelected then
    DoInsert(BodyElement, ARect)
  else
  begin
    AElements := TInterfaceList.Create;
    GetHTMLElementsList(AElements);
    for I := 0 to AElements.Count - 1 do
    begin
      Element := AElements.Items[I] as IHTMLElement;
      if CheckInSelectRect(Element, ARect) then
        Selection.Add(Element);
    end;
  end;
end;

function TcxHTMLEditor.DoOnClick(const AEventObj: IHTMLEventObj): WordBool;
var
  Rect: TREct;
  Receiver: IHTMLElement;
begin
  Result := not IsToolSelected;
  if not Result then
  begin
    if IsElementContainer(AEventObj.srcElement) then
    begin
      Receiver := AEventObj.srcElement;
      Rect.Left := AEventObj.offsetX;
      Rect.Top := AEventObj.offsetY;
    end
    else
    begin
      Rect.Left := AEventObj.x;
      Rect.Top := AEventObj.y;
      Receiver := BodyElement;
    end;
    Rect.Right := Rect.Left;
    Rect.Bottom := Rect.Top;
    DoInsert(Receiver, Rect);
  end;
end;

function TcxHTMLEditor.DoOnDblClick(
  const AEventObj: IHTMLEventObj): WordBool;
begin
  Result := True;
end;

procedure TcxHTMLEditor.DoOnDragEnd(const AEventObj: IHTMLEventObj);
begin
  if (FDropTarget <> nil) and Assigned(FOnParentChanged) then
    FOnParentChanged(Self, FDropTarget);
  FDraggingElement := nil;
  FDropTarget := nil;
end;

function TcxHTMLEditor.DoOnDragStart(
  const AEventObj: IHTMLEventObj): WordBool;
begin
  FDraggingElement := AEventObj.srcElement;
  FDropTarget := nil;
  Result := True;
end;

function TcxHTMLEditor.DoOnDrop(const AEventObj: IHTMLEventObj): WordBool;
begin
  FDropTarget := AEventObj.srcElement;
  Result := True;
end;

procedure TcxHTMLEditor.DoOnFocusOut(const AEventObj: IHTMLEventObj);
begin
end;

procedure TcxHTMLEditor.DoOnKeyDown(const AEventObj: IHTMLEventObj);
begin
end;

procedure TcxHTMLEditor.DoOnMouseDown(const AEventObj: IHTMLEventObj);
begin
end;

procedure TcxHTMLEditor.DoOnMouseUp(const AEventObj: IHTMLEventObj);
var
  Range: IHTMLControlRange;
  Rect: TRect;
begin
  // Complete control resizing by mouse
  if FState = esResizing then
  begin
    FState := esNormal;
    if Assigned(FOnResized) then
      FOnresized(Self);
  end;
  // Complete control moving by mouse
  if FState = esMoving then
  begin
    FState := esNormal;
    if Assigned(FOnMoved) then
      FOnMoved(Self);
    UndoManager.EndUndoBlock;
  end;
  // Workaround for the IE 5.5 bug with the OnSelectionChange event
  if cxWebHTMLDesignerMajorVersion = 5 then
     if (AEventObj.ctrlKey or AEventObj.shiftKey) and
       Supports(Document.selection.createRange, IHTMLControlRange, Range) and
       (Range.length > 0) then
      DoSelectionChanged;
  if IsToolSelected and IsElementContainer(AEventObj.srcElement) then
  begin
    Rect.Left := AEventObj.offsetX;
    Rect.Top := AEventObj.offsetY;
    Rect.Right := Rect.Left;
    Rect.Bottom := Rect.Top;
    DoInsert(AEventObj.srcElement, Rect);
  end;
end;

procedure TcxHTMLEditor.DoOnMoveEnd(const AEventObj: IHTMLEventObj);
begin
//  DoDocumentChange;
end;

function TcxHTMLEditor.DoOnMoveStart(
  const AEventObj: IHTMLEventObj): WordBool;
begin
  if FState <> esMoving then
    UndoManager.BeginUndoBlock(scxCmdMove);
  FState := esMoving;
  Result := True;
end;

function TcxHTMLEditor.DoOnResizeStart(const AEventObj: IHTMLEventObj): Wordbool;
begin
  if HasElementViewLink(AEventObj.srcElement) then
    UndoManager.BeginUndoBlock(scxCmdResize);
  FState := esResizing;
  Result := True;
end;

procedure TcxHTMLEditor.DoOnResizeEnd(const AEventObj: IHTMLEventObj);
begin
//  DoDocumentChange;
end;

procedure TcxHTMLEditor.DoOnSelectionChange(
  const AEventObj: IHTMLEventObj);
var
  Element: IHTMLElement;
  Changed: Boolean;
begin
  if not Busy then
  begin
    Changed := False;
    if GetAsyncKeyState(VK_LBUTTON) < 0 then
    begin
      Element := Document.elementFromPoint(AEventObj.clientX, AEventObj.clientY);
      if (ContainerLayout(Element) = hclGrid) and
         (Selection.Count > 0) and not CanElementSelect(Element) then
      begin
        Selection.Empty;
        Changed := True;
      end;
    end;
    if not Changed then
      DoSelectionChanged;
  end;
end;

procedure TcxHTMLEditor.DoInsert(AParent: IHTMLElement; R: TRect);
var
  AHTML, AInnerHTML: string;
  Element: IHTMLElement;
begin
  if Assigned(FOnControlInsert) then
  begin
    UndoManager.BeginUndoBlock(scxCmdInsert);
    FOnControlInsert(Self, R, AHTML, AInnerHTML, AParent);
    if (AHTML <> '') and (AParent <> nil) then
    begin
      Element := Document.createElement(AHTML);
      if AInnerHTML <> '' then
        Element.innerHTML := AInnerHTML;
      while True do
      begin
        if (AParent as IHTMLElement2).canHaveChildren then
          break;
        AParent := AParent.parentElement;
        if AParent = nil then break;
      end;
      (AParent as IHTMLDOMNode).appendChild(Element as IHTMLDOMNode);
      if Assigned(FOnControlInserted) then
        FOnControlInserted(Self, Element);
      if not HasElementViewLink(Element) then
        UndoManager.EndUndoBlock;
    end;
  end;
end;

procedure TcxHTMLEditor.DoSelectionChanged;
begin
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;

procedure TcxHTMLEditor.GetHTMLElementsList(const AList: IInterfaceList);
begin
end;

procedure TcxHTMLEditor.StartMoveSelectionByKey(const AKey: Integer; ASnap: Boolean);
var
  I: Integer;
  Element: IHTMLElement;
  DeltaX, DeltaY: Integer;
  IsFirst: Boolean;
begin
  if ASnap and SnapToGrid then
  begin
    DeltaX := GridXSize;
    DeltaY := GridYSize;
  end
  else
  begin
    DeltaX := 1;
    DeltaY := 1;
  end;
  IsFirst := FState <> esMoving;
  if IsFirst then
    EndResizeSelectionByKey;
  for I := 0 to Selection.Count - 1 do
  begin
    Element := Selection.Controls[I];
    if not SameText((Element as IHTMLElement2).currentStyle.position, 'static') then // Do not localize
    begin
      if IsFirst then
        FireEvent(Element, 'onmovestart');
      case AKey of
        VK_UP:
          Element.style.setAttribute('top', Element.offsetTop - DeltaY, 0);
        VK_DOWN:
          Element.style.setAttribute('top', Element.offsetTop + DeltaY, 0);
        VK_LEFT:
          Element.style.setAttribute('left', Element.offsetLeft - DeltaX, 0);
        VK_RIGHT:
          Element.style.setAttribute('left', Element.offsetLeft + DeltaX, 0);
      end;
    end;
  end;
end;

procedure TcxHTMLEditor.StartResizeSelectionByKey(const AKey: Integer);
var
  I: Integer;
  Element: IHTMLElement;
  IsFirst: Boolean;
begin
  IsFirst := FState <> esResizing;
  if IsFirst then
  begin
    EndMoveSelectionByKey;
    UndoManager.BeginUndoBlock(scxCmdResize);
  end;
  for I := 0 to Selection.Count - 1 do
  begin
    Element := Selection.Controls[I];
    if IsFirst then
      FireEvent(Element, 'onresizestart');
    Element.style.setAttribute('height', Element.offsetHeight, 0);
    Element.style.setAttribute('width', Element.offsetWidth, 0);
    case AKey of
      VK_UP:
        Element.style.setAttribute('height', Element.offsetHeight - 1, 0);
      VK_DOWN:
        Element.style.setAttribute('height', Element.offsetHeight + 1, 0);
      VK_LEFT:
        Element.style.setAttribute('width', Element.offsetWidth - 1, 0);
      VK_RIGHT:
        Element.style.setAttribute('width', Element.offsetWidth + 1, 0);
    end;
  end;
end;

procedure TcxHTMLEditor.EndMoveSelectionByKey;
var
  I: Integer;
  Element: IHTMLElement;
  SelElements: IInterfaceList;
begin
  if FState <> esMoving then Exit;
  SelElements := TInterfaceList.Create;
  for I := 0 to Selection.Count - 1 do
    SelElements.Add(Selection[I]);
  for I := 0 to SelElements.Count - 1 do
  begin
    Element := SelElements[I] as IHTMLElement;
    if not SameText((Element as IHTMLElement2).currentStyle.position, 'static') then // Do not localize
      FireEvent(Element, 'onmoveend');
  end;
  FState := esNormal;
  if Assigned(FOnMoved) then
    FOnMoved(Self);
  UndoManager.EndUndoBlock;
end;

procedure TcxHTMLEditor.EndResizeSelectionByKey;
var
  I: Integer;
begin
  if FState <> esResizing then Exit;
  for I := 0 to Selection.Count - 1 do
    FireEvent(Selection.Controls[I], 'onresizeend');
  FState := esNormal;
  if Assigned(FOnResized) then
    FOnResized(Self);
  UndoManager.EndUndoBlock;
end;

function TcxHTMLEditor.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
  if DispID = DISPID_AMBIENT_DLCONTROL then
    if VarResult <> nil then
    begin
      POleVariant(VarResult)^ :=
                   DLCTL_DLIMAGES or DLCTL_VIDEOS or DLCTL_BGSOUNDS or
                   DLCTL_NO_SCRIPTS or DLCTL_NO_JAVA or
                   DLCTL_NO_RUNACTIVEXCTLS or DLCTL_NO_DLACTIVEXCTLS or
                   DLCTL_PRAGMA_NO_CACHE or
                   DLCTL_NO_BEHAVIORS or
                   DLCTL_FORCEOFFLINE or DLCTL_NO_CLIENTPULL or DLCTL_SILENT or
                   DLCTL_NO_METACHARSET;
      Result := S_OK;
      if FInternalBrowseMode then
        POleVariant(VarResult)^ := POleVariant(VarResult)^ or DLCTL_NO_FRAMEDOWNLOAD;
    end
    else
      Result := E_INVALIDARG;
end;

function TcxHTMLEditor.QueryService(const rsid, iid: TGuid;
  out Obj): HResult;
begin
  Result := E_NOINTERFACE;
  if IsEqualGUID(rsid, IID_IHTMLEditHost) and IsEqualGUID(iid, IID_IHTMLEditHost) then
    Result := QueryInterface(IHTMLEditHost, Obj);
end;

function TcxHTMLEditor.SnapRect(const pIElement: IHTMLElement;
  var prcNew: tagRECT; eHandle: _ELEMENT_CORNER): HResult;

  function GetGlobalPoint(AElement: IHTMLElement): TPoint;
  begin
    Result.X := (BodyElement as IHTMLElement2).scrollLeft;
    Result.Y := (BodyElement as IHTMLElement2).scrollTop;
    while AElement <> nil do
    begin
      Result.X := Result.X + AElement.offsetLeft;
      Result.Y := Result.Y + AElement.offsetTop;
      AElement := AElement.offsetParent;
    end;
  end;

  procedure EvalResize(const ACurValue, ADelta: Integer; var ANewValue: Integer);
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

  procedure EvalMove(const ACurValue, ADelta: Integer; var ANewValue: Integer);
  var
    I: Integer;
  begin
    I := ACurValue + ((ANewValue - ACurValue) div ADelta) * ADelta;
    if Abs(I - ANewValue) < (ADelta div 2) then
      ANewValue := I
    else
      ANewValue := ACurValue;
  end;
var
  DeltaX, DeltaY: Integer;
begin
  Result := S_OK;
  DeltaX := GridXSize;
  DeltaY := GridYSize;
  if SnapToGrid and (pIElement <> nil) and (GetAsyncKeyState(VK_MENU) >= 0) then
    case eHandle of
      ELEMENT_CORNER_NONE:
      begin
        EvalMove(GetGlobalPoint(pIElement).Y, DeltaY, prcNew.top);
        EvalMove(GetGlobalPoint(pIElement).X, DeltaX, prcNew.left);
      end;
      ELEMENT_CORNER_TOP:
        EvalResize(GetGlobalPoint(pIElement).Y, DeltaY, prcNew.top);
      ELEMENT_CORNER_LEFT:
        EvalResize(GetGlobalPoint(pIElement).X, DeltaX, prcNew.left);
      ELEMENT_CORNER_BOTTOM:
        EvalResize(GetGlobalPoint(pIElement).Y + pIElement.offsetHeight,
          DeltaY, prcNew.bottom);
      ELEMENT_CORNER_RIGHT:
        EvalResize(GetGlobalPoint(pIElement).X + pIElement.offsetWidth,
          DeltaX, prcNew.right);
      ELEMENT_CORNER_TOPLEFT:
      begin
        EvalResize(GetGlobalPoint(pIElement).Y, DeltaY, prcNew.top);
        EvalResize(GetGlobalPoint(pIElement).X, DeltaX, prcNew.left);
      end;
      ELEMENT_CORNER_TOPRIGHT:
      begin
        EvalResize(GetGlobalPoint(pIElement).Y, DeltaY, prcNew.top);
        EvalResize(GetGlobalPoint(pIElement).X + pIElement.offsetWidth,
          DeltaX, prcNew.right);
      end;
      ELEMENT_CORNER_BOTTOMLEFT:
      begin
        EvalResize(GetGlobalPoint(pIElement).Y + pIElement.offsetHeight,
          DeltaY, prcNew.bottom);
        EvalResize(GetGlobalPoint(pIElement).X, DeltaX, prcNew.left);
      end;
      ELEMENT_CORNER_BOTTOMRIGHT:
      begin
        EvalResize(GetGlobalPoint(pIElement).Y + pIElement.offsetHeight,
          DeltaY, prcNew.bottom);
        EvalResize(GetGlobalPoint(pIElement).X + pIElement.offsetWidth,
          DeltaX, prcNew.right);
      end;
    end;
end;

function TcxHTMLEditor.ShowBorders: Boolean;
begin
  Result := True;
end;

function TcxHTMLEditor.ShowDetails: Boolean;
begin
  Result := False;
end;

function TcxHTMLEditor.ShowGrid: Boolean;
begin
  Result := True;
end;

function TcxHTMLEditor.SnapToGrid: Boolean;
begin
  Result := True;
end;

function TcxHTMLEditor.GridXSize: Integer;
begin
  Result := 0;
end;

function TcxHTMLEditor.GridYSize: Integer;
begin
  Result := 0;
end;

function TcxHTMLEditor.IsToolSelected: Boolean;
begin
  Result := False;
end;

procedure TcxHTMLEditor.CompleteUndoBlock;
begin
  if UndoManager.FOpenBlockCount > 0 then
    UndoManager.EndUndoBlock
  else
    UndoManager.Clear;
end;

procedure TcxHTMLEditor.GetViewLinkContent(const AElement: IHTMLElement;
  var AContent, ACSSContent, AInlineStyle: string);
begin
  AContent := '';
  ACSSContent := '';
  AInlineStyle := '';
end;

function TcxHTMLEditor.IsElementContainer(const AElement: IHTMLElement): Boolean;
begin
  Result := False;
end;

function TcxHTMLEditor.CanHaveBehavior(const AElement: IHTMLElement): Boolean;
begin
  Result := True;
end;

function TcxHTMLEditor.ContainerLayout(const AElement: IHTMLElement): TcxHTMLContainerLayout;
begin
  Result := hclFlow;
end;

function TcxHTMLEditor.CanElementSelect(const AElement: IHTMLElement): Boolean;
begin
  Result := True;
end;

function TcxHTMLEditor.Notify: HResult;
begin
  DoDocumentChange;
  Result := S_OK;
end;

{ TcxHTMLEditor private }

function TcxHTMLEditor.GetControlInterface: IWebBrowser2;
begin
  CreateControl;
  Result := FIntf;
end;

function TcxHTMLEditor.GetDocument: IHTMLDocument2;
begin
  Supports(ControlInterface.Document, IHTMLDocument2, Result);
end;

function TcxHTMLEditor.GetDocument3: IHTMLDocument3;
begin
  Supports(ControlInterface.Document, IHTMLDocument3, Result);
end;

function TcxHTMLEditor.GetDocument4: IHTMLDocument4;
begin
  Supports(ControlInterface.Document, IHTMLDocument4, Result);
end;

function TcxHTMLEditor.GetBrowseMode: Boolean;
begin
//  Wait;
  if Document <> nil then
    Result := not SameText(Document.designMode, 'On')
  else
    Result := True;
end;

function TcxHTMLEditor.GetBusy: Boolean;
begin
  Result := ControlInterface.Busy;
end;

function TcxHTMLEditor.GetDocumentReady: Boolean;
begin
  Result := ControlInterface.ReadyState = READYSTATE_COMPLETE;
end;

function TcxHTMLEditor.GetModified: Boolean;
begin
  Result := FModified or UndoManager.CanUndo;
end;

function TcxHTMLEditor.GetDocumentHTML: string;
var
  StrStream: TStream;
begin
  Result := '';
  StrStream := TStringStream.Create('');
  try
    SaveDocumentToStream(StrStream);
    Result := TStringStream(StrStream).DataString;
  finally
    StrStream.Free;
  end;
end;

function TcxHTMLEditor.GetDisplayServices: IDisplayServices;
begin
  Supports(Document, IDisplayServices, Result);
end;

function TcxHTMLEditor.GetMarkupServices: IMarkupServices;
begin
  Supports(Document, IMarkupServices, Result);
end;

procedure TcxHTMLEditor.ProcessMessages;
var
  Msg: TMsg;
begin
  if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    if Msg.Message <> WM_QUIT then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
end;

procedure TcxHTMLEditor.SetBaseURL(const Value: string);
var
  Elements: IHTMLElementCollection;
  BaseElement: IHTMLElement;
  Node: IHTMLDOMNode;
  TagName: WideString;
  Stream: TStream;
begin
  if Value = FBaseURL then Exit;
  LockWindowUpdate(Handle);
  try
    // Wait for document complete
    Wait;
    while not DocumentReady do
      ProcessMessages;
    while not IsDocumentReady(Document) do
      ProcessMessages;
    // Get Base element
    MarkupServices.GetNameForTagID(TAGID_BASE, TagName);
    Elements := Document3.getElementsByTagName(TagName);
    if Elements.length = 0 then
    begin
      MarkupServices.createElement(TAGID_BASE, 'ewf_designer', BaseElement);
      MarkupServices.GetNameForTagID(TAGID_HEAD, TagName);
      Elements := Document3.getElementsByTagName(TagName);
      if Elements.length > 0 then
      begin
        Node := Elements.item(0, 0) as IHTMLDomNode;
        Node.appendChild(BaseElement as IHTMLDOMNode);
      end; 
    end
    else
      BaseElement := Elements.item(0, 0) as IHTMLElement;
    if not VarIsNull(BaseElement.getAttribute('ewf_designer', 0)) then
    begin
      // Modify Base URL
      (BaseElement as IHTMLBaseElement).href := Value;
      // Reload HTML
      Stream := TMemoryStream.Create;
      try
        SaveDocumentToStream(Stream);
        Stream.Position := 0;
        LoadDocumentFromStream(Stream);
      finally
        Stream.Free
      end;
      FBaseURL := Value;
    end;
  finally
    LockWindowUpdate(0);
  end;  
end;

procedure TcxHTMLEditor.SetBrowseMode(const Value: Boolean);
begin
  Wait;
  if Document <> nil then
    if Value then
      Document.designMode := 'Off'
    else
      Document.designMode := 'On';
end;

procedure TcxHTMLEditor.SetDocumentHTML(const Value: string);
var
  StrStream: TStream;
begin
  StrStream := TStringStream.Create(Value);
  try
    LoadDocumentFromStream(StrStream);
  finally
    StrStream.Free;
  end;
end;

procedure TcxHTMLEditor.SetModified(const Value: Boolean);
begin
  if not Value then
    UndoManager.Clear;
  FModified := Value;
end;

function TcxHTMLEditor.GetBody: IHTMLBodyElement;
begin
  Supports(BodyElement, IHTMLBodyElement, Result);
end;

function TcxHTMLEditor.GetBodyElement: IHTMLElement;
begin
  if Document <> nil then
    Result := Document.body
  else
    Result := nil;
end;

function TcxHTMLEditor.AddNamespace(const ANamespace: string): IcxHTMLNamespace;
begin
  Result := TcxHTMLNamespace.CreateObj(ANamespace, self) as IcxHTMLNamespace;
  if Result <> nil then
    FNamespaces.Add(Result);
end;

function TcxHTMLEditor.FindNamespace(const ANamespace: string): IcxHTMLNamespace;
var
  I: Integer;
  Namespace: IcxHTMLNamespace;
begin
  Result := nil;
  for I := 0 to FNamespaces.Count - 1 do
  begin
    Namespace := FNamespaces.Items[I] as IcxHTMLNamespace;
    if SameText(Namespace.Name, ANamespace) then
    begin
      Result := Namespace;
      break;
    end;
  end;
end;

function TcxHTMLEditor.FindElementBehavior(AElement: IHTMLElement): IcxHTMLBehaviorViewLink;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FNamespaces.Count - 1 do
    if Supports((FNamespaces[I] as IcxHTMLNamespace).GetElementBehavior(AElement),
      IcxHTMLBehaviorViewLink, Result) then break;
end;

function TcxHTMLEditor.CheckInSelectRect(Element: IHTMLElement; R: TRect): Boolean;
var
  ElementRect, ResultRect: TRect;
begin
  ElementRect.Left := Element.offsetLeft;
  ElementRect.Top := Element.offsetTop;
  ElementRect.Right := ElementRect.Left + Element.offsetWidth;
  ElementRect.Bottom := ElementRect.Top + Element.offsetHeight;
  Result := IntersectRect(ResultRect, ElementRect, R);
end;

function TcxHTMLEditor.FireEvent(ASrcElement: IHTMLElement; const AName: string): Boolean;
var
  NewEvent: IHTMLEventObj;
  VEvent: OleVariant;
begin
  NewEvent := Document4.CreateEventObject(nil);
  VEvent := NewEvent;
  Result := (ASrcElement as IHTMLElement3).FireEvent(AName, VEvent);
end;

procedure TcxHTMLEditor.AddGlobalBehaviors;

  procedure RemoveBehavior(ABehavior: IcxHTMLBehavior);
  var
    Cookie: Integer;
    Element2: IHTMLElement2;
  begin
    ABehavior.PaintSite.GetHitTestCookie(Cookie);
    if Supports(ABehavior.Element, IHTMLElement2, Element2) then
      Element2.removeBehavior(Cookie);
  end;

var
  I: Integer;
  Namespace: IcxHTMLNamespace;
  Body2: IHTMLElement2;
  vFactory: OleVariant;
  Factory: IElementBehaviorFactory;
  SelectionBehavior: IcxHTMLSelectionBehavior;
begin
  Namespace := FindNamespace('');
  if Namespace = nil then
    Namespace := AddNamespace('');
  while Namespace.Behaviors.Count > 0 do
    RemoveBehavior(Namespace.Behaviors.Items[0] as IcxHTMLBehavior);
  Supports(Namespace, IElementBehaviorFactory, Factory);
  Factory._AddRef;
  TVarData(vFactory).VType := varUnknown;
  TVarData(vFactory).VUnknown := Pointer(Factory);
  if (Body <> nil) and (ContainerLayout(BodyElement) = hclGrid) then
  begin
    Body2 := BodyElement as IHTMLElement2;
    Body2.addBehavior('grid', vFactory);
    Body2.addBehavior('select', vFactory);
    //TODO: improve events handling mechanism
    for I := 0 to Namespace.Behaviors.Count - 1 do
      if Supports(Namespace.Behaviors.Items[I], IcxHTMLSelectionBehavior, SelectionBehavior) then
        SelectionBehavior.OnRegionSelected := SelectByRect;
  end;
end;

procedure TcxHTMLEditor.LinkChangeSink;
var
  PrimaryMC: IMarkupContainer2;
begin
  if Supports(Document, IMarkupContainer2, PrimaryMC) then
  begin
    UnlinkChangeSink;
    PrimaryMC.RegisterForDirtyRange(Self, FPrimaryMCId);
  end;
end;

procedure TcxHTMLEditor.UnlinkChangeSink;
var
  PrimaryMC: IMarkupContainer2;
begin
  if Supports(Document, IMarkupContainer2, PrimaryMC) then
    if FPrimaryMCId <> 0 then
    begin
      PrimaryMC.UnRegisterForDirtyRange(FPrimaryMCId);
      FPrimaryMCId := 0;
    end;
end;

{ TcxHTMLUndoManager }

constructor TcxHTMLUndoManager.Create(AEditor: TcxHTMLEditor);
begin
  FEditor := AEditor;
  FOpenBlockCount := 0;
end;

procedure TcxHTMLUndoManager.BeginUndoBlock(const ACaption: string);
begin
  FEditor.MarkupServices.BeginUndoUnit(ACaption);
  Inc(FOpenBlockCount);
end;

procedure TcxHTMLUndoManager.Clear;
var
  OleUndoManager: IcxOleUndoManager;
begin
  OleUndoManager := GetOleUndoManager;
  if OleUndoManager <> nil then
  begin
    OleUndoManager.DiscardFrom(nil);
    OleUndoManager.Enable(False);
    OleUndoManager.Enable(True);
  end;
end;

procedure TcxHTMLUndoManager.EndUndoBlock;
begin
  if FOpenBlockCount = 0 then Exit;
  FEditor.MarkupServices.EndUndoUnit;
  Dec(FOpenBlockCount);
end;

function TcxHTMLUndoManager.GetUndoDesctiption: string;
var
  WDesc: WideString;
begin
  Result := '';
  if GetOleUndoManager.GetLastUndoDescription(WDesc) = S_OK then
    Result := WDesc;
end;

function TcxHTMLUndoManager.GetRedoDesctiption: string;
var
  WDesc: WideString;
begin
  Result := '';
  if GetOleUndoManager.GetLastRedoDescription(WDesc) = S_OK then
    Result := WDesc;
end;

function TcxHTMLUndoManager.CanRedo: Boolean;
begin
//TODO  Result := (FEditor.QueryStatus(IDM_REDO) and OLECMDF_ENABLED) = OLECMDF_ENABLED;
  Result := False;
end;

function TcxHTMLUndoManager.CanUndo: Boolean;
begin
//TODO  Result := (FEditor.QueryStatus(IDM_UNDO) and OLECMDF_ENABLED) = OLECMDF_ENABLED;
  Result := False;
end;

procedure TcxHTMLUndoManager.Redo;
begin
  if not CanRedo then Exit;
  FEditor.ExecCommand(IDM_REDO, OLECMDEXECOPT_DONTPROMPTUSER);
end;

procedure TcxHTMLUndoManager.Undo;
begin
  if not CanUndo then Exit;
  FEditor.ExecCommand(IDM_UNDO, OLECMDEXECOPT_DONTPROMPTUSER);
end;

function TcxHTMLUndoManager.GetOleUndoManager: IcxOleUndoManager;
var
  SP: IServiceProvider;
begin
  if Supports(FEditor.Document, IServiceProvider, SP) then
    SP.QueryService(IcxOleUndoManager, IcxOleUndoManager, Result);
end;

initialization
  OleInitialize(nil);

finalization
  OleUninitialize;
end.
