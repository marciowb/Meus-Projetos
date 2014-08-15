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
unit cxfmWebDsgn;

{$I cxVer.inc}

interface

uses Classes, DesignIntf, DesignMenus,
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, Menus, StdCtrls, ImgList,
  ComCtrls, Buttons, ExtCtrls, ToolWin, DesignWindows, Dialogs,
  cxWebHTMLEditor,
  {$ELSE}
  Qt, Types, QGraphics, QControls, QForms, QMenus, QStdCtrls, QImgList,
  QComCtrls, QButtons, QExtCtrls, CLXDesignWindows, QDialogs,
  {$ENDIF}
  cxWebDsgnStrs, cxWebRender, cxWebClasses, cxWebControls, cxWebStdCtrls,
  cxWebDsgnEnvOpt, cxWebDsgnIntf, cxWebIntf;

type
  {$IFDEF LINUX}
  TcxMozillaBrowser = class;
  {$ENDIF}

  TComponentContainer = class(TScrollBox);

  TcxWebModuleState = (msForm, msHTMLResult, msPreview);

  TcxWebModuleDesignWindow = class({$IFDEF VCL}TDesignWindow,{$ELSE}TCLXDesignWindow,{$ENDIF}
                        IcxDesignerWindow, IcxWebModuleDesignerNotify)
  private
    FContainerWindow: TComponentContainer;
    FHSplitter: TSplitter;
    FWebDesigner: TcxAbstractWebDesigner;

    FModuleState: TcxWebModuleState;
    FPanels: Array[TcxWebModuleState] of TPanel;
    FButtons: Array[TcxWebModuleState] of TToolButton;
    FHTMLResultMemo: TMemo;
    FMemoMenu: TPopupMenu;
    FFindDialog: TFindDialog;
    {$IFDEF VCL}
    FWebBrowser: TcxHTMLEditor;
    {$ENDIF}
    {$IFDEF LINUX}
    FWebBrowser: TcxMozillaBrowser;
    {$ENDIF}
    ToolBar: TToolBar;
    btnForm: TToolButton;
    btnSource: TToolButton;
    btnPreview: TToolButton;

    procedure HSplitterCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure HSplitterMoved(Sender: TObject);
    procedure btnFormClick(Sender: TObject);
    procedure btnSourceClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);

    procedure DoOnPopup(Sender: TObject);
    procedure DoFindText(Sender: TObject);
    {$IFDEF VCL}
    procedure DoFindClose(Sender: TObject);
    {$ENDIF}
    procedure DoCopyText(Sender: TObject);
    procedure DoSelectText(Sender: TObject);

    procedure CreateFormComponents;
    procedure CreateDesigner;
    procedure CreateDesignerControl;
    procedure RecreateDesigner;
    procedure CreateControls;
    procedure DropDesigningInComponentState;
    procedure ReadFormLayout;
    procedure SaveFormPosition;
    function IsDestroying: Boolean;
    function IsOwnDesigner(const ADesigner: IDesigner; const AnItem: TPersistent): Boolean;
    procedure DoOnActivate(Sender: TObject);
    procedure DoOnDeactivate(Sender: TObject);

    procedure SetModuleState(const Value: TcxWebModuleState);
    procedure ModuleStateChanged;
    procedure PrepareHTMLStrings;
    procedure PrepareHTMLFile;
    procedure EnableButtons(AEnabled: Boolean);

  protected
    {$IFDEF VCL}
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMNCActivate(var Message: TWMNCActivate); message WM_NCACTIVATE;
    {$ELSE}
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    {$ENDIF}

    {IcxWebModuleDesignerNotify}
    procedure DesignerIDChanged;
    procedure DesignerPositioningTypeChanged;
    function IsSupportPositioningTypeChanged(APositioningType: TcxWebPositioningType): Boolean;
    function GetControlPositioningType: TcxWebPositioningType;

    { IcxDesignerWindow }
    function GetShowingType: TcxWebDesignerShowingType;
    procedure ShowDesigner;

    function GetDesignerCount: Integer;
    function GetDesignerName(Index: Integer): String;
    function GetDesignerID: Integer;
    procedure Activated; override;
    procedure KeyPress(var Key: Char); override;
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
    procedure Resize; override;
  public
    constructor CreateEx(AOwner: TComponent; const ADesigner: IDesigner;
       out AComponentContainer: TWinControl);
    destructor Destroy; override;

    procedure ItemInserted(const ADesigner: IDesigner; Item: TPersistent); override;
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); override;
    procedure ValidateRename(AComponent: TComponent; const CurName, NewName: string); override;

    { IEditHandler }
    function GetEditState: TEditState; override;
    function EditAction(Action: TEditAction): Boolean; override;
    { IDesignNotification }
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean); override;
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean); override;
    procedure ItemsModified(const ADesigner: IDesigner); override;
    {IcxWebModuleDesignerNotify}
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); override;

    property ModuleState: TcxWebModuleState read FModuleState write SetModuleState;
    property WebDesigner: TcxAbstractWebDesigner read FWebDesigner;
  end;

  {$IFDEF LINUX}
  TcxMozillaBrowser = class
  private
    FOwner: TcxWebModuleDesignWindow;
    FBrowserPID: Integer;
    procedure StartMozilla;
  protected
    property BrowserPID: Integer read FBrowserPID;
  public
    constructor Create(AOwner: TcxWebModuleDesignWindow);
    destructor Destroy; override;
    procedure Reload;
  end;
  {$ENDIF}

implementation

{$IFDEF VCL}
{$R *.dfm}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses SysUtils, ToolsAPI,
  {$IFDEF VCL}
  ActiveX,
  {$ENDIF}
  {$IFDEF LINUX}
  Libc, Xlib,
  {$ENDIF}
  cxWebDsgnFactory, cxWebDsgnUtils, cxWebDsgnWebContext, cxWebDsgnConsts,
  StrUtils;

{$IFNDEF VCL}
function GetRValue(Color: Integer): Byte;
begin
  Result := Byte(Color);
end;

function GetGValue(Color: Integer): Byte;
begin
  Result := Byte(Color shr 8);
end;

function GetBValue(Color: Integer): Byte;
begin
  Result := Byte(Color shr 16);
end;

function RGB(R, G, B: Byte): Integer;
begin
  Result := (R or (G shl 8) or (B shl 16));
end;
{$ENDIF}

function ShiftColor(AColor: TColor; ARed, AGreen, ABlue: Byte): TColor;
var
  Red, Green, Blue: Integer;
begin
  Red := GetRValue(AColor) + ARed;
  if Red > High(Byte) then Red := High(Byte);
  if Red < Low(Byte) then Red := Low(Byte);

  Green := GetGValue(AColor) + AGreen;
  if Green > High(Byte) then Green := High(Byte);
  if Green < Low(Byte) then Green := Low(Byte);

  Blue := GetBValue(AColor) + ABlue;
  if Blue > High(Byte) then Blue := High(Byte);
  if Blue < Low(Byte) then Blue := Low(Byte);

  Result := RGB(Red, Green, Blue);
end;

type
  TComponentAccess = class(TComponent);
  TFormAccess = class(TForm);

{ TcxHSplitter }

  TcxHSplitter = class(TSplitter)
  protected
    procedure Paint; override;
  end;

procedure TcxHSplitter.Paint;
begin
  with Canvas do
  begin
    if Top + Height + MinSize + 1 = Parent.Height then
    begin
      Brush.Color := clWindow;
      FillRect(ClientRect);
    end
    else
    begin
      Pen.Color := clWindowText;
      Brush.Color := clBtnFace;
      Rectangle(ClientRect);
    end;
  end;
end;

{$IFDEF LINUX}
type
  PXIDMapEntry = ^TXIDMapEntry;
  TXIDMapEntry = record
    HostWnd: QWidgetH;
    ClientXID: TWindow;
  end;

  TXIDMap = class
  private
    FList: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(AHostWnd: QWidgetH; AClientXID: TWindow): Integer;
    procedure Clear;
    procedure Delete(AIndex: Integer);
    function FindClientXID(AHostWnd: QWidgetH): TWindow;
    function IndexOf(AHostWnd: QWidgetH): Integer;
    procedure Remove(AHostWnd: QWidgetH);
  end;

var
  cxPrevEventFilter: X11EventFilter = nil;
  XIDMap: TXIDMap;

{ TXIDMap }
constructor TXIDMap.Create;
begin
  FList := TList.Create;
end;

destructor TXIDMap.Destroy;
begin
  Clear;
  FreeAndNil(FList);
  inherited;
end;

function TXIDMap.Add(AHostWnd: QWidgetH; AClientXID: TWindow): Integer;
var
  P: PXIDMapEntry;
begin
  New(P);
  P^.HostWnd := AHostWnd;
  P^.ClientXID := AClientXID;
  Result := FList.Add(P);
end;

procedure TXIDMap.Clear;
begin
  while FList.Count > 0 do
    Delete(FList.Count - 1);
end;

procedure TXIDMap.Delete(AIndex: Integer);
begin
  Dispose(PXIDMapEntry(FList[AIndex]));
  FList.Delete(AIndex);
end;

function TXIDMap.FindClientXID(AHostWnd: QWidgetH): TWindow;
var
  Idx: Integer;
begin
  Idx := IndexOf(AHostWnd);
  if Idx <> -1 then
    Result := PXIDMapEntry(FList[Idx])^.ClientXID
  else
    Result := 0;  
end;

function TXIDMap.IndexOf(AHostWnd: QWidgetH): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FList.Count - 1 do
    if PXIDMapEntry(FList[I])^.HostWnd = AHostWnd then
    begin
      Result := I;
      break;
    end;
end;

procedure TXIDMap.Remove(AHostWnd: QWidgetH);
var
  Idx: Integer;
begin
  Idx := IndexOf(AHostWnd);
  if Idx <> -1 then
    Delete(Idx);
end;

function cxMozillaEventFilter(XEvent: PXEvent): Boolean; cdecl;
var
  XCM: PXClientMessageEvent;
begin
  Result := False;
  if XEvent^.xtype = ClientMessage then
  begin
    XCM := PXClientMessageEvent(XEvent);
    if (XCM^.data.l[0] = 0) and (XCM^.data.l[2] = $0111) then
    begin
      XReparentWindow(XCM^.display, TWindow(XCM^.data.l[3]),
        QWidget_winId(QWidgetH(XCM^.data.l[1])), 0, 0);
      XIDMap.Add(QWidgetH(XCM^.data.l[1]), XCM^.data.l[3]);
      Result := True;
    end;
  end;
end;
{$ENDIF}

{ TcxWebModuleDesignWindow }

constructor TcxWebModuleDesignWindow.CreateEx(AOwner: TComponent;
  const ADesigner: IDesigner; out AComponentContainer: TWinControl);
begin
  Designer := ADesigner;
  CreateDesigner;
  inherited Create(AOwner);
  CreateFormComponents;
  SetDesigning(True);
  KeyPreview := True;
  CreateControls;
  AComponentContainer := FContainerWindow;
  FModuleState := msForm;
  ModuleStateChanged;
end;

procedure TcxWebModuleDesignWindow.CreateFormComponents;

  function CreateButton(ACaption: string; AImageIndex: Integer; onClick: TNotifyEvent): TToolButton;
  begin
    Result := TToolButton.Create(ToolBar);
    Result.Parent := ToolBar;
    Result.Caption := ACaption;
    Result.ImageIndex := AImageIndex;
    Result.OnClick := onClick;
    Result.AllowAllUp := False;
    Result.Down := False;
    Result.Grouped := True;
    Result.Style := tbsCheck;
  end;

begin
  ToolBar := TToolBar.Create(self);
  ToolBar.Parent := self;
  ToolBar.Align := alBottom;
  ToolBar.AutoSize := True;
  ToolBar.BorderWidth := 1;
  ToolBar.ButtonHeight := 24;
  ToolBar.ButtonWidth := 85;
  ToolBar.Flat := True;
  ToolBar.ShowCaptions := True;

  {$IFDEF VCL}
  btnPreview := CreateButton(scxWebDsgnPreviewButton, 2, btnPreviewClick);
  btnSource := CreateButton(scxWebDsgnResultButton, 1, btnSourceClick);
  btnForm := CreateButton(scxWebDsgnFormButton, 0, btnFormClick);
  {$ELSE}
  btnForm := CreateButton(scxWebDsgnFormButton, 0, btnFormClick);
  btnSource := CreateButton(scxWebDsgnResultButton, 1, btnSourceClick);
  btnPreview := CreateButton(scxWebDsgnPreviewButton, 2, btnPreviewClick);
  {$ENDIF}
  btnForm.Down := True;
end;

destructor TcxWebModuleDesignWindow.Destroy;
begin
  if Designer <> nil then
    Designer.NoSelection;
  if FWebDesigner <> nil then
  begin
    FWebDesigner.DestroyDesignerControl;
    FWebDesigner.Free;
    FWebDesigner := nil;
  end;
  {$IFNDEF LINUX}
  FreeAndNil(FWebBrowser);
  {$ENDIF}
  inherited Destroy;
end;

{$IFDEF VCL}
procedure TcxWebModuleDesignWindow.WMMove(var Message: TWMMove);
begin
  inherited;
  SaveFormPosition;
end;

procedure TcxWebModuleDesignWindow.WMNCActivate(var Message: TWMNCActivate);
begin
  inherited;
  if Message.Active then
    DoOnActivate(Self)
  else
    DoOnDeactivate(Self);
end;
{$ELSE}
function TcxWebModuleDesignWindow.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
begin
  Result := inherited EventFilter(Sender, Event);
  case QEvent_type(Event) of
   QEventType_WindowActivate: DoOnActivate(Self);
   QEventType_WindowDeactivate: DoOnDeactivate(Self);
  end; 
end;
{$ENDIF}

{ IEditHandler }
function TcxWebModuleDesignWindow.GetEditState: TEditState;
begin
  Result := [];
  if WebDesigner <> nil then
    with FWebDesigner do
    begin
      if CanUndo then Include(Result, esCanUndo);
      if CanCut then Include(Result, esCanCut);
      if CanCopy then Include(Result, esCanCopy);
      if CanPaste then Include(Result, esCanPaste);
      if CanDelete then Include(Result, esCanDelete);
{$IFNDEF DELPHI9}
      if CanTabOrder then Include(Result, esCanTabOrder);
{$ENDIF}
      if CanSelectAll then Include(Result, esCanSelectAll);
    end;
end;

function TcxWebModuleDesignWindow.EditAction(Action: TEditAction): Boolean;
begin
  Result := True;
  if WebDesigner <> nil then
    with FWebDesigner do
      case Action of
        eaUndo: Undo;
        eaCut: CutSelection;
        eaCopy: CopySelection;
        eaPaste: PasteSelection;
        eaDelete: DeleteSelection;
        eaSelectAll: SelectAll;
{$IFNDEF DELPHI9}
        eaAlignToGrid: AlignToGrid;
{$ENDIF}
      end;
end;

{ IDesignNotification }

procedure TcxWebModuleDesignWindow.DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
begin
  if IsOwnDesigner(ADesigner, nil) then
  begin
    if WebDesigner <> nil then
    begin
      Caption := FWebDesigner.Root.Name;
      ReadFormLayout;
      DropDesigningInComponentState;
      FWebDesigner.UpdateDesignerControl;
      FWebDesigner.RefreshDesignControls;
    end;  
  end;
end;

procedure TcxWebModuleDesignWindow.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  {$IFDEF VCL} //TODO check in Windows. It looks like it should be removed
  if IsOwnDesigner(ADesigner, nil) then
  begin
    Destroying;
    Release;
  end;
  {$ENDIF}
end;

procedure TcxWebModuleDesignWindow.ItemsModified(const ADesigner: IDesigner);

  function IsEmptySelection: Boolean;
  var
    AList: IDesignerSelections;
  begin
    AList := TDesignerSelections.Create;
    Designer.GetSelections(AList);
    Result := (AList.Count = 0);
  end;

begin
  if not IsDestroying and IsOwnDesigner(ADesigner, nil) then
  begin
    if not IsEmptySelection then
      ModuleState := msForm;
    if FWebDesigner <> nil then
      FWebDesigner.Modified;
  end;
end;

{IcxWebModuleDesignerNotify}
procedure TcxWebModuleDesignWindow.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
var
  List: TList;
begin
  if not IsDestroying and IsOwnDesigner(ADesigner, nil) then
  begin
    List := TList.Create;
    try
      DesignerSelectionsToList(ASelection, List);
      if FWebDesigner <> nil then
        FWebDesigner.SelectionChanged(List);
    finally
      List.Free;
    end;
  end;
end;

{IcxWebModuleDesignerNotify}
procedure TcxWebModuleDesignWindow.DesignerIDChanged;
begin
  if (FWebDesigner = nil) or (FWebDesigner.GetID <> GetDesignerID) then
  begin
    if ModuleState <> msForm then
      ModuleState := msForm;
    if FWebDesigner <> nil then
      FWebDesigner.DesignerIdChanging;
    RecreateDesigner;
    if (FWebDesigner <> nil) and not (csLoading in Designer.Root.ComponentState) then
      FWebDesigner.RefreshDesignControls;
  end;
end;

procedure TcxWebModuleDesignWindow.DesignerPositioningTypeChanged;
begin
  if (FWebDesigner <> nil) then
  begin
    if (ModuleState <> msForm) then
      ModuleState := msForm;
    FWebDesigner.DesignerPositioningTypeChanged;
  end;
end;

function TcxWebModuleDesignWindow.IsSupportPositioningTypeChanged(APositioningType: TcxWebPositioningType): Boolean;
begin
  if (FWebDesigner <> nil) then
    Result := FWebDesigner.IsSupportPositioningTypeChanged(APositioningType)
  else Result := False;
end;

function TcxWebModuleDesignWindow.GetControlPositioningType: TcxWebPositioningType;
begin
  if (FWebDesigner <> nil) then
    Result := FWebDesigner.GetControlPositioningType
  else Result := cxptGrid;
end;


{ IcxDesignerWindow }
function TcxWebModuleDesignWindow.GetShowingType: TcxWebDesignerShowingType;
begin
  if ModuleState = msForm then
    Result := stDesigner
  else Result := stPreview;
end;

procedure TcxWebModuleDesignWindow.ShowDesigner;
begin
  ModuleState := msForm;
end;

function TcxWebModuleDesignWindow.GetDesignerCount: Integer;
begin
  Result := WebDesignerFactory.Count;
end;

function TcxWebModuleDesignWindow.GetDesignerName(Index: Integer): String;
begin
  Result := WebDesignerFactory[Index].GetName;
end;

procedure TcxWebModuleDesignWindow.Activated;
begin
  inherited Activated;
  if (FWebDesigner <> nil) and (FWebDesigner.DesignerControl <> nil) then
  begin
    {$IFDEF VCL}
    Windows.SetFocus(FWebDesigner.DesignerControl.Handle);
    {$ELSE}
    QWidget_setFocus(FWebDesigner.DesignerControl.Handle);
    {$ENDIF}
  end;
end;

function TcxWebModuleDesignWindow.GetDesignerID: Integer;
begin
  if (Designer.Root <> nil) and Supports(Designer.Root, IcxWebDesignerModule) then
    Result := (Designer.Root as IcxWebDesignerModule).GetDesignerID
  else Result := -1;  
end;

procedure TcxWebModuleDesignWindow.KeyPress(var Key: char);
begin
  if Key in [#13, #33..#126] then 
  begin
    if Key = #13 then Key := #0;
    ActivateInspector(Key);
    Key := #0;
  end;
  inherited KeyPress(Key);
end;

function TcxWebModuleDesignWindow.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if IsEqualGUID(IID, IEditHandler) then
  begin
    GetInterface(IID, Obj);
    Result := S_OK;
  end
  else
    Result := inherited QueryInterface(IID, Obj);
end;

procedure TcxWebModuleDesignWindow.Resize;
{$IFDEF LINUX}
var
  BrowserXID: TWindow;
{$ENDIF}  
begin
  inherited;
  SaveFormPosition;
  {$IFDEF LINUX}
  BrowserXID := XIDMap.FindClientXID(FPanels[msPreview].Handle);
  if BrowserXID <> 0 then
    XResizeWindow(Application.Display, BrowserXID,
      Width, Height - ToolBar.Height);
  {$ENDIF}
end;

procedure TcxWebModuleDesignWindow.ItemInserted(const ADesigner: IDesigner; Item: TPersistent);
begin
  inherited ItemInserted(ADesigner, Item);
  if IsOwnDesigner(ADesigner, Item) and (Item is TComponent) and (WebDesigner <> nil) then
    WebDesigner.ComponentCreated(TComponent(Item));
end;

procedure TcxWebModuleDesignWindow.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);
begin
  if IsOwnDesigner(ADesigner, Item) and (Item is TComponent) and (WebDesigner <> nil) then
    WebDesigner.ComponentDestroyed(TComponent(Item));
  inherited ItemDeleted(ADesigner, Item);
end;

procedure TcxWebModuleDesignWindow.ValidateRename(AComponent: TComponent;
        const CurName, NewName: string);
begin
  inherited ValidateRename(AComponent, CurName, NewName);
  if (AComponent <> nil) and not (csDestroying in AComponent.ComponentState)
    and not (csLoading in AComponent.ComponentState)
    and (AComponent.Owner = Designer.Root)
    and (WebDesigner <> nil) then
      WebDesigner.ComponentChangedName(AComponent, CurName, NewName);
end;

procedure TcxWebModuleDesignWindow.HSplitterCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  if TcxWebDesignerEnvironmentOptions.GetSnapControlsToGrid(Designer) then
  begin
    if NewSize < 0 then NewSize := 0;
  end;
  Accept := NewSize <= Height - 200;
end;

procedure TcxWebModuleDesignWindow.HSplitterMoved(Sender: TObject);
begin
   TcxWebDesignerEnvironmentOptions.SetDividerPos(Designer,
        FContainerWindow.Height + FHSplitter.Height + FHSplitter.MinSize);
end;

procedure TcxWebModuleDesignWindow.CreateDesigner;
begin
  FWebDesigner := WebDesignerFactory.GetDesignerByID(GetDesignerID).Create(self, Designer);
  InsertComponent(FWebDesigner.Root);
  if (Designer.Root <> nil) and Supports(Designer.Root, IcxWebDesignerModule) then
    (Designer.Root as IcxWebDesignerModule).SetDesignerID(FWebDesigner.GetID);
end;

procedure TcxWebModuleDesignWindow.CreateDesignerControl;
begin
  if FWebDesigner <> nil then
  begin
    FWebDesigner.CreateDesignerControl(FPanels[msForm]);
    TComponentAccess(FWebDesigner.DesignerControl).SetDesigning(False);
  end;
end;

procedure TcxWebModuleDesignWindow.RecreateDesigner;
begin
  if (FWebDesigner <> nil)
  and (WebDesignerFactory.GetDesignerByID(GetDesignerID) = FWebDesigner.ClassType) then
    exit;
  if FWebDesigner <> nil then
  begin
    RemoveComponent(FWebDesigner.Root);
    FWebDesigner.DestroyDesignerControl;
    FWebDesigner.Free;
    FWebDesigner := nil;
  end;
  CreateDesigner;
  CreateDesignerControl;
  FWebDesigner.UpdateDesignerControl;
end;

type
{$IFDEF VCL}
 TWebBrowserHack = class(TcxHTMLEditor);
{$ENDIF}

 TMemoHack = class(TMemo)
 private
 {$IFDEF VCL}
   procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
   procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
   procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
 {$ENDIF}
 end;

{$IFDEF VCL}
procedure TMemoHack.WMContextMenu(var Message: TWMContextMenu);
begin
  PopupMenu.PopupComponent := Self;
  PopupMenu.Popup(Message.XPos, Message.YPos);
  Message.Result := 1;
end;

procedure TMemoHack.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TMemoHack.WMKeyDown(var Message: TWMKeyDown);
begin
  if Message.CharCode = VK_TAB then
    Message.Result := 1
  else inherited;
end;
{$ENDIF}

procedure TcxWebModuleDesignWindow.CreateControls;


  procedure CreateHSplitter;
  begin
    FHSplitter := TcxHSplitter.Create(Self);
    TComponentAccess(FHSplitter).SetDesigning(False);
    FHSplitter.Parent := FPanels[msForm];
    FHSplitter.Align := alBottom;
    FHSplitter.AutoSnap := False;
    FHSplitter.MinSize := 1;
    FHSplitter.OnCanResize := HSplitterCanResize;
    FHSplitter.OnMoved := HSplitterMoved;
  end;

  procedure CreateContainerWindow;
  begin
    FContainerWindow := TComponentContainer.Create(Self);
    TComponentAccess(FContainerWindow).SetDesigning(True);
    FContainerWindow.Parent := FPanels[msForm];
    FContainerWindow.Align := alBottom;
    FContainerWindow.Color := ShiftColor(ColorToRGB(clBtnFace), 10, 10, 10);
    FContainerWindow.Height := TcxWebDesignerEnvironmentOptions.GetDividerPos(Designer)
         - FHSplitter.Height - FHSplitter.MinSize;
    FContainerWindow.Top := FContainerWindow.Parent.Height - FContainerWindow.Height;
    FHSplitter.Align := alTop;
    FHSplitter.Align := alBottom;
    FContainerWindow.BorderStyle := bsNone;
  end;

  function CreatePanel: TPanel;
  begin
    Result := TPanel.Create(self);
    Result.Parent := self;
    Result.Align := alClient;
    Result.BorderStyle := bsNone;
    Result.BevelInner := bvNone;
    Result.BevelOuter := bvNone;
  end;

  procedure CreatePopupMenu;
  var
    Item: TMenuItem;
  begin
    FMemoMenu := TPopupMenu.Create(self);
    TComponentAccess(FMemoMenu).SetDesigning(False);
    FMemoMenu.OnPopup := DoOnPopup;
    FFindDialog := TFindDialog.Create(self);
    TComponentAccess(FFindDialog).SetDesigning(False);
    FFindDialog.Options := [frHideUpDown];
    {$IFNDEF VCL}
    FFindDialog.Modal := True;
    FFindDialog.Title := 'Find Text';
    {$ELSE}
    FFindDialog.OnFind := DoFindText;
    FFindDialog.OnClose := DoFindClose;
    {$ENDIF}
    Item := TMenuItem.Create(FMemoMenu);
    Item.Caption := 'Find...';
    Item.ShortCut := ShortCut({$IFDEF VCL}Ord('F'){$ELSE}Key_F{$ENDIF}, [ssCtrl]);
    Item.OnClick := DoFindText;
    FMemoMenu.Items.Add(Item);

    Item := TMenuItem.Create(FMemoMenu);
    Item.Caption := 'Find Next';
    Item.ShortCut := ShortCut({$IFDEF VCL}VK_F3{$ELSE}Key_F3{$ENDIF}, []);
    Item.OnClick := DoFindText;
    Item.Enabled := False;
    FMemoMenu.Items.Add(Item);

    Item := TMenuItem.Create(FMemoMenu);
    Item.Caption := '-';
    FMemoMenu.Items.Add(Item);

    Item := TMenuItem.Create(FMemoMenu);
    Item.Caption := 'Copy';
    Item.ShortCut := ShortCut({$IFDEF VCL}Ord('C'){$ELSE}Key_C{$ENDIF}, [ssCtrl]);
    Item.OnClick := DoCopyText;
    Item.Enabled := False;
    FMemoMenu.Items.Add(Item);

    Item := TMenuItem.Create(FMemoMenu);
    Item.Caption := 'Select All';
    Item.ShortCut := ShortCut({$IFDEF VCL}Ord('A'){$ELSE}Key_A{$ENDIF}, [ssCtrl]);
    Item.OnClick := DoSelectText;
    FMemoMenu.Items.Add(Item);
  end;

  procedure CreateHTMLResultMemo;
  begin
    FHTMLResultMemo := TMemoHack.Create(self);
    TComponentAccess(FHTMLResultMemo).SetDesigning(False);
    FHTMLResultMemo.Parent := FPanels[msHTMLResult];
    FHTMLResultMemo.ScrollBars := ssBoth;
    FHTMLResultMemo.WordWrap := False;
    FHTMLResultMemo.Align := alClient;
    FHTMLResultMemo.ReadOnly := True;
    {$IFDEF VCL}
    FHTMLResultMemo.HideSelection := False;
    {$ENDIF}
    CreatePopupMenu;
    FHTMLResultMemo.PopupMenu := FMemoMenu;
  end;

  procedure CreateWebBrowser;
  begin
    {$IFDEF VCL}
    FWebBrowser := TWebBrowserHack.Create(self, True);
    TWebBrowserHack(FWebBrowser).SetParent(FPanels[msPreview]);
    FWebBrowser.Align := alClient;
    {$ENDIF}
    {$IFDEF LINUX}
    FWebBrowser := TcxMozillaBrowser.Create(self);
    {$ENDIF}
  end;
var
  AState: TcxWebModuleState;
begin
  for AState := Low(TcxWebModuleState) to High(TcxWebModuleState) do
    FPanels[AState] := CreatePanel;
  FButtons[msForm] := btnForm;
  FButtons[msHTMLResult] := btnSource;
  FButtons[msPreview] := btnPreview;

  CreateHTMLResultMemo;
  CreateWebBrowser;

  CreateHSplitter;
  CreateContainerWindow;
  CreateDesignerControl;
end;

procedure TcxWebModuleDesignWindow.DropDesigningInComponentState;
var
  I: Integer;
  Component: TComponent;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    Component := Components[I];
    if (Component <> Designer.GetRoot) and (Component <> FContainerWindow) then
      TComponentAccess(Component).SetDesigning(False);
  end;
end;

procedure TcxWebModuleDesignWindow.ReadFormLayout;
const
  VisibleModuleSize = 10;
var
  DesignOffset: TPoint;
  DesignSize: TPoint;
begin
  if (Designer.Root is TDataModule) then
  begin
    DesignOffset := TDataModule(Designer.Root).DesignOffset;
    DesignSize := TDataModule(Designer.Root).DesignSize;
    if (DesignOffset.X + DesignSize.X < VisibleModuleSize) then
       DesignOffset.X := VisibleModuleSize - DesignSize.X;
    if (DesignOffset.Y + DesignSize.Y < VisibleModuleSize) then
       DesignOffset.Y := VisibleModuleSize - DesignSize.Y;
    if ({$IFNDEF VCL}QForms.{$ENDIF}Screen.Width - DesignOffset.X < VisibleModuleSize) then
       DesignOffset.X := {$IFNDEF VCL}QForms.{$ENDIF}Screen.Width - VisibleModuleSize;
    if ({$IFNDEF VCL}QForms.{$ENDIF}Screen.Height - DesignOffset.Y < VisibleModuleSize) then
       DesignOffset.Y := {$IFNDEF VCL}QForms.{$ENDIF}Screen.Height - VisibleModuleSize;
    Left := DesignOffset.X;
    Top := DesignOffset.Y;
    Width := DesignSize.X;
    Height := DesignSize.Y;
  end;
end;

procedure TcxWebModuleDesignWindow.SaveFormPosition;
begin
  if (Designer.Root is TDataModule) then
    with TDataModule(Designer.Root) do
    begin
      DesignOffset := Point(Left, Top);
      DesignSize := Point(Width, Height);
    end;
end;

function TcxWebModuleDesignWindow.IsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxWebModuleDesignWindow.IsOwnDesigner(const ADesigner: IDesigner;
  const AnItem: TPersistent): Boolean;
begin
  Result := (ADesigner = nil) or (ADesigner = Designer);
  if Result and (AnItem <> nil) then
     Result := FindRootDesigner(AnItem) = FindRootDesigner(Designer.Root);
  (*
    {$IFDEF VCL}
    Result := (TFormAccess(Self).Designer as IDesignerNotify) = FindRootDesigner(AnItem);
    {$ELSE}
    if Supports(Designer, IDesignerNotify) then  //TODO LINUX check it out
      Result := (Designer as IDesignerNotify) = FindRootDesigner(AnItem);
    {$ENDIF}
   *)
end;

procedure TcxWebModuleDesignWindow.DoOnActivate(Sender: TObject);
begin
  if (FWebDesigner <> nil) then
    FWebDesigner.DesignerActivated;
end;

procedure TcxWebModuleDesignWindow.DoOnDeactivate(Sender: TObject);
begin
  if (FWebDesigner <> nil) then
    FWebDesigner.DesignerDeactivated;
end;

procedure TcxWebModuleDesignWindow.SetModuleState(const Value: TcxWebModuleState);
begin
  if (FModuleState <> Value) then
  begin
    FModuleState := Value;
    if (FWebDesigner <> nil) and (ModuleState <> msForm) then
      FWebDesigner.PreviewShowing;
    ModuleStateChanged;
  end;
end;

procedure TcxWebModuleDesignWindow.ModuleStateChanged;

  function IsSelected(AInstance: TPersistent): Boolean;
  var
    AList: IDesignerSelections;
  begin
    AList := TDesignerSelections.Create;
    Designer.GetSelections(AList);
    Result := (AList.Count = 1) and (AList.Items[0] = AInstance);
  end;

  function IsEmptySelection: Boolean;
  var
    AList: IDesignerSelections;
  begin
    AList := TDesignerSelections.Create;
    Designer.GetSelections(AList);
    Result := (AList.Count = 0);
  end;

var
  I: TcxWebModuleState;
begin
  for I := Low(TcxWebModuleState) to High(TcxWebModuleState) do
    FPanels[I].Visible := ModuleState = I;
  if ModuleState = msHTMLResult then
  {$IFDEF VCL}
    Windows.SetFocus(FHTMLResultMemo.Handle);
  {$ELSE}
    QWidget_setFocus(FHTMLResultMemo.Handle);
  {$ENDIF}
  FButtons[ModuleState].Down := True;
  if Designer <> nil then
    if ModuleState = msForm then
    begin
      if IsEmptySelection or not IsSelected(Designer.Root) then
        Designer.SelectComponent(Designer.Root);
    end
    else
      Designer.NoSelection;
end;

procedure TcxWebModuleDesignWindow.EnableButtons(AEnabled: Boolean);
var
  I: TcxWebModuleState;
begin
  for I := Low(TcxWebModuleState) to High(TcxWebModuleState) do
    FButtons[I].Enabled := AEnabled;
end;

procedure TcxWebModuleDesignWindow.btnFormClick(Sender: TObject);
begin
  ModuleState := msForm;
end;

procedure TcxWebModuleDesignWindow.btnSourceClick(Sender: TObject);

  procedure PrepareHTMLResultFont;
  var
    AFontName: string;
    AFontSize: Integer;
  begin
    AFontName := FHTMLResultMemo.Font.Name;
    AFontSize := FHTMLResultMemo.Font.Size;
    if GetDelphiEditorFontInfo(AFontName, AFontSize) then
    begin
      FHTMLResultMemo.Font.Name := AFontName;
      FHTMLResultMemo.Font.Size := AFontSize;
    end;
  end;

begin
  EnableButtons(False);
  try
    {$IFDEF VCL}
    if FWebBrowser.Busy then
      FWebBrowser.NewDocument;
    {$ENDIF}
    ModuleState := msHTMLResult;
    PrepareHTMLResultFont;
    PrepareHTMLStrings;
  finally
    EnableButtons(True);
  end;
end;

procedure TcxWebModuleDesignWindow.btnPreviewClick(Sender: TObject);
begin
  EnableButtons(False);
  ModuleState := msPreview;
  PrepareHTMLFile;
  EnableButtons(True);
end;

procedure TcxWebModuleDesignWindow.PrepareHTMLStrings;
begin
  FHTMLResultMemo.Lines.Text := cxGetDesignWebContent(Designer);
end;

procedure TcxWebModuleDesignWindow.PrepareHTMLFile;
{$IFNDEF VCL}
var
  PreviewFile: string;
{$ENDIF}
begin
  if ModuleState <> msHTMLResult then
    PrepareHTMLStrings;
  {$IFDEF VCL}
  FWebBrowser.DocumentHTML := FHTMLResultMemo.Lines.Text;
  FWebBrowser.BaseURL := ExtractFilePath((BorlandIDEServices as IOTAModuleServices).CurrentModule.FileName);
  {$ENDIF}
  {$IFDEF LINUX}
  PreviewFile := getenv('HOME') + '/.borland/preview';
  FHTMLResultMemo.Lines.SaveToFile(PreviewFile);
  FWebBrowser.Reload;
  {$ENDIF}
end;

procedure TcxWebModuleDesignWindow.DoFindText(Sender: TObject);
var
  SearchRes: Boolean;
  {$IFDEF VCL}
  Text: string;
  SO: TStringSearchOptions;
  MatchStr: PChar;
  {$ELSE}
  StartFrom: TCaretPos;
  {$ENDIF}
begin
  {$IFNDEF VCL}
  StartFrom.Line := 0;
  StartFrom.Col := 0;
  {$ENDIF}
  if (Sender is TMenuItem) and (TMenuItem(Sender).MenuIndex = 0) then
  begin
    if FFindDialog.Execute then
      FMemoMenu.Items[1].Enabled := False;
    {$IFDEF VCL}
    Exit;
    {$ENDIF}
  end;
  if FHTMLResultMemo.SelLength > 0 then
  begin
    {$IFNDEF VCL}
    StartFrom.Line := FHTMLResultMemo.Selection.Line2;
    StartFrom.Col := FHTMLResultMemo.Selection.Col2 + 1;
    {$ENDIF}
  end;
  {$IFDEF VCL}
  SO := [soDown];
  if frMatchCase in FFindDialog.Options then
    SO := SO + [soMatchCase];
  if frWholeWord in FFindDialog.Options then
    SO := SO + [soWholeWord];
  Text := FHTMLResultMemo.Text;
  MatchStr := SearchBuf(PChar(Text), Length(Text),
    FHTMLResultMemo.SelStart, FHTMLResultMemo.SelLength, FFindDialog.FindText, SO);
  SearchRes := MatchStr <> nil;
  if SearchRes then
  begin
    FHTMLResultMemo.SelStart := MatchStr - PChar(Text);
    FHTMLResultMemo.SelLength := Length(FFindDialog.FindText);
  end;
  {$ELSE}
  SearchRes := FHTMLResultMemo.Search(FFindDialog.FindText,
    frMatchCase in FFindDialog.Options, True,
    frWholeWord in FFindDialog.Options, False,
    StartFrom.Line, StartFrom.Col);
  {$ENDIF}
  if SearchRes then
    FMemoMenu.Items[1].Enabled := True
  else
    MessageDlg({$IFNDEF VCL}'',{$ENDIF} 'Search string "' + FFindDialog.FindText + '" not found!',
      mtInformation, [mbOk], 0);
end;

procedure TcxWebModuleDesignWindow.DoCopyText(Sender: TObject);
begin
  FHTMLResultMemo.CopyToClipboard;
end;

procedure TcxWebModuleDesignWindow.DoSelectText(Sender: TObject);
begin
  FHTMLResultMemo.SelectAll;
end;

procedure TcxWebModuleDesignWindow.DoOnPopup(Sender: TObject);
begin
  FMemoMenu.Items[3].Enabled := (FHTMLResultMemo.SelLength > 0);
end;

{$IFDEF VCL}
procedure TcxWebModuleDesignWindow.DoFindClose(Sender: TObject);
begin
  Windows.SetFocus(FHTMLResultMemo.Handle);
end;
{$ENDIF}

{$IFDEF LINUX}

{TcxMozillaBrowser}
constructor TcxMozillaBrowser.Create(AOwner: TcxWebModuleDesignWindow);
begin
  inherited Create;
  FOwner := AOwner;
  FBrowserPID := 0;
end;

destructor TcxMozillaBrowser.Destroy;
begin
  if FBrowserPID <> 0 then
    kill(FBrowserPID, SIGTERM);
  XIDMap.Remove(FOwner.FPanels[msPreview].Handle);
  inherited;
end;

procedure TcxMozillaBrowser.StartMozilla;
const
  BorMozPath = '/bin/mozilla/BorMozBrowser';
var
  FArgv: array of PChar;
  XID, Wnd: Integer;
  Parent: TWidgetControl;
  BrowserCmd: string;
begin
  FBrowserPID := 0;
  SetLength(FArgv, 8);
  BrowserCmd := getenv('DELPHI') + BorMozPath;
  if not FileExists(BrowserCmd) then Exit;

  FArgv[0] := PChar(BrowserCmd);
  Parent := FOwner.FPanels[msPreview];
  Wnd := Integer(Parent.Handle);
  XID := QWidget_winId(QWidgetH(Wnd));

  FArgv[1] := PChar(IntToStr(XID)); // Host XID
  FArgv[2] := PChar(IntToStr(Wnd)); // Host HWND
  FArgv[3] := PChar(IntToStr(Parent.Left)); // Window x-coordinate
  FArgv[4] := PChar(IntToStr(Parent.Top)); // Window y-coordinate
  FArgv[5] := PChar(IntToStr(Parent.Height)); // Window height
  FArgv[6] := PChar(IntToStr(Parent.Width)); // Window width
  FArgv[7] := nil;
  FBrowserPID := fork;
  if FBrowserPID = 0 then
  begin
    execv(PChar(FArgv[0]), @FArgv[0]);
    Exit;
  end;
end;

procedure TcxMozillaBrowser.Reload;
begin
  if (FBrowserPID = 0) or (kill(FBrowserPID, SIGUSR1) < 0) then
    StartMozilla;
end;
{$ENDIF}

{$IFDEF LINUX}
initialization
  XIDMap := TXIDMap.Create;
  cxPrevEventFilter := Application.SetX11EventFilter(@cxMozillaEventFilter);

finalization
  cxPrevEventFilter := Application.SetX11EventFilter(cxPrevEventFilter);
  cxPrevEventFilter := nil;
  FreeAndNil(XIDMap);
{$ENDIF}

end.
