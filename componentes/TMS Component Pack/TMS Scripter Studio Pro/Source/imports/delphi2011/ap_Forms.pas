{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_Forms;

interface

uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Menus,
  Controls,
  Imm,
  ActnList,
  MultiMon,
  HelpIntfs,
  DwmApi,
  Forms,
  Variants,
  ap_Types,
  ap_Messages,
  atScript;

{$WARNINGS OFF}

type
  TatFormsLibrary = class(TatScripterLibrary)
    procedure __TControlScrollBarAssign(AMachine: TatVirtualMachine);
    procedure __TControlScrollBarChangeBiDiPosition(AMachine: TatVirtualMachine);
    procedure __TControlScrollBarIsScrollBarVisible(AMachine: TatVirtualMachine);
    procedure __GetTControlScrollBarKind(AMachine: TatVirtualMachine);
    procedure __GetTControlScrollBarScrollPos(AMachine: TatVirtualMachine);
    procedure __TScrollingWinControlCreate(AMachine: TatVirtualMachine);
    procedure __TScrollingWinControlDestroy(AMachine: TatVirtualMachine);
    procedure __TScrollingWinControlDisableAutoRange(AMachine: TatVirtualMachine);
    procedure __TScrollingWinControlEnableAutoRange(AMachine: TatVirtualMachine);
    procedure __TScrollingWinControlScrollInView(AMachine: TatVirtualMachine);
    procedure __TScrollBoxCreate(AMachine: TatVirtualMachine);
    procedure __TCustomFrameCreate(AMachine: TatVirtualMachine);
    procedure __TGlassFrameCreate(AMachine: TatVirtualMachine);
    procedure __TGlassFrameAssign(AMachine: TatVirtualMachine);
    procedure __TGlassFrameFrameExtended(AMachine: TatVirtualMachine);
    procedure __TGlassFrameIntersectsControl(AMachine: TatVirtualMachine);
    procedure __TCustomFormCreate(AMachine: TatVirtualMachine);
    procedure __TCustomFormCreateNew(AMachine: TatVirtualMachine);
    procedure __TCustomFormDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomFormClose(AMachine: TatVirtualMachine);
    procedure __TCustomFormCloseQuery(AMachine: TatVirtualMachine);
    procedure __TCustomFormDefaultHandler(AMachine: TatVirtualMachine);
    procedure __TCustomFormDefocusControl(AMachine: TatVirtualMachine);
    procedure __TCustomFormDock(AMachine: TatVirtualMachine);
    procedure __TCustomFormFocusControl(AMachine: TatVirtualMachine);
    procedure __TCustomFormGetFormImage(AMachine: TatVirtualMachine);
    procedure __TCustomFormHide(AMachine: TatVirtualMachine);
    procedure __TCustomFormIsShortCut(AMachine: TatVirtualMachine);
    procedure __TCustomFormMakeFullyVisible(AMachine: TatVirtualMachine);
    procedure __TCustomFormMouseWheelHandler(AMachine: TatVirtualMachine);
    procedure __TCustomFormPrint(AMachine: TatVirtualMachine);
    procedure __TCustomFormRecreateAsPopup(AMachine: TatVirtualMachine);
    procedure __TCustomFormRelease(AMachine: TatVirtualMachine);
    procedure __TCustomFormSendCancelMode(AMachine: TatVirtualMachine);
    procedure __TCustomFormSetFocus(AMachine: TatVirtualMachine);
    procedure __TCustomFormSetFocusedControl(AMachine: TatVirtualMachine);
    procedure __TCustomFormShow(AMachine: TatVirtualMachine);
    procedure __TCustomFormShowModal(AMachine: TatVirtualMachine);
    procedure __TCustomFormWantChildKey(AMachine: TatVirtualMachine);
    procedure __TCustomFormset_PopupParent(AMachine: TatVirtualMachine);
    procedure __TCustomFormAfterConstruction(AMachine: TatVirtualMachine);
    procedure __TCustomFormBeforeDestruction(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormActive(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormActiveControl(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormActiveControl(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormActiveOleControl(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormActiveOleControl(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormBorderStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormBorderStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormCanvas(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormDropTarget(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormDropTarget(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormFormState(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormGlassFrame(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormGlassFrame(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormHelpFile(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormHelpFile(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormKeyPreview(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormKeyPreview(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormMenu(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormMenu(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormModalResult(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormModalResult(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormMonitor(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormPopupMode(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormPopupMode(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormScreenSnap(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormScreenSnap(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormSnapBuffer(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormSnapBuffer(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormWindowState(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormWindowState(AMachine: TatVirtualMachine);
    procedure __GetTCustomFormPopupParent(AMachine: TatVirtualMachine);
    procedure __SetTCustomFormPopupParent(AMachine: TatVirtualMachine);
    procedure __TCustomActiveFormCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActiveFormWantChildKey(AMachine: TatVirtualMachine);
    procedure __TFormArrangeIcons(AMachine: TatVirtualMachine);
    procedure __TFormCascade(AMachine: TatVirtualMachine);
    procedure __TFormNext(AMachine: TatVirtualMachine);
    procedure __TFormPrevious(AMachine: TatVirtualMachine);
    procedure __TFormTile(AMachine: TatVirtualMachine);
    procedure __TCustomDockFormCreate(AMachine: TatVirtualMachine);
    procedure __GetTMonitorHandle(AMachine: TatVirtualMachine);
    procedure __GetTMonitorMonitorNum(AMachine: TatVirtualMachine);
    procedure __GetTMonitorLeft(AMachine: TatVirtualMachine);
    procedure __GetTMonitorHeight(AMachine: TatVirtualMachine);
    procedure __GetTMonitorTop(AMachine: TatVirtualMachine);
    procedure __GetTMonitorWidth(AMachine: TatVirtualMachine);
    procedure __GetTMonitorBoundsRect(AMachine: TatVirtualMachine);
    procedure __GetTMonitorWorkareaRect(AMachine: TatVirtualMachine);
    procedure __GetTMonitorPrimary(AMachine: TatVirtualMachine);
    procedure __TScreenCreate(AMachine: TatVirtualMachine);
    procedure __TScreenDestroy(AMachine: TatVirtualMachine);
    procedure __TScreenDisableAlign(AMachine: TatVirtualMachine);
    procedure __TScreenEnableAlign(AMachine: TatVirtualMachine);
    procedure __TScreenMonitorFromPoint(AMachine: TatVirtualMachine);
    procedure __TScreenMonitorFromRect(AMachine: TatVirtualMachine);
    procedure __TScreenMonitorFromWindow(AMachine: TatVirtualMachine);
    procedure __TScreenRealign(AMachine: TatVirtualMachine);
    procedure __TScreenResetFonts(AMachine: TatVirtualMachine);
    procedure __GetTScreenActiveControl(AMachine: TatVirtualMachine);
    procedure __GetTScreenActiveCustomForm(AMachine: TatVirtualMachine);
    procedure __GetTScreenActiveForm(AMachine: TatVirtualMachine);
    procedure __GetTScreenCustomFormCount(AMachine: TatVirtualMachine);
    procedure __GetTScreenCustomForms(AMachine: TatVirtualMachine);
    procedure __GetTScreenCursorCount(AMachine: TatVirtualMachine);
    procedure __GetTScreenCursor(AMachine: TatVirtualMachine);
    procedure __SetTScreenCursor(AMachine: TatVirtualMachine);
    procedure __GetTScreenCursors(AMachine: TatVirtualMachine);
    procedure __SetTScreenCursors(AMachine: TatVirtualMachine);
    procedure __GetTScreenDataModules(AMachine: TatVirtualMachine);
    procedure __GetTScreenDataModuleCount(AMachine: TatVirtualMachine);
    procedure __GetTScreenFocusedForm(AMachine: TatVirtualMachine);
    procedure __SetTScreenFocusedForm(AMachine: TatVirtualMachine);
    procedure __GetTScreenSaveFocusedList(AMachine: TatVirtualMachine);
    procedure __GetTScreenMonitorCount(AMachine: TatVirtualMachine);
    procedure __GetTScreenMonitors(AMachine: TatVirtualMachine);
    procedure __GetTScreenDesktopRect(AMachine: TatVirtualMachine);
    procedure __GetTScreenDesktopHeight(AMachine: TatVirtualMachine);
    procedure __GetTScreenDesktopLeft(AMachine: TatVirtualMachine);
    procedure __GetTScreenDesktopTop(AMachine: TatVirtualMachine);
    procedure __GetTScreenDesktopWidth(AMachine: TatVirtualMachine);
    procedure __GetTScreenWorkAreaRect(AMachine: TatVirtualMachine);
    procedure __GetTScreenWorkAreaHeight(AMachine: TatVirtualMachine);
    procedure __GetTScreenWorkAreaLeft(AMachine: TatVirtualMachine);
    procedure __GetTScreenWorkAreaTop(AMachine: TatVirtualMachine);
    procedure __GetTScreenWorkAreaWidth(AMachine: TatVirtualMachine);
    procedure __GetTScreenHintFont(AMachine: TatVirtualMachine);
    procedure __SetTScreenHintFont(AMachine: TatVirtualMachine);
    procedure __GetTScreenIconFont(AMachine: TatVirtualMachine);
    procedure __SetTScreenIconFont(AMachine: TatVirtualMachine);
    procedure __GetTScreenMenuFont(AMachine: TatVirtualMachine);
    procedure __SetTScreenMenuFont(AMachine: TatVirtualMachine);
    procedure __GetTScreenMessageFont(AMachine: TatVirtualMachine);
    procedure __SetTScreenMessageFont(AMachine: TatVirtualMachine);
    procedure __GetTScreenCaptionFont(AMachine: TatVirtualMachine);
    procedure __SetTScreenCaptionFont(AMachine: TatVirtualMachine);
    procedure __GetTScreenFonts(AMachine: TatVirtualMachine);
    procedure __GetTScreenFormCount(AMachine: TatVirtualMachine);
    procedure __GetTScreenForms(AMachine: TatVirtualMachine);
    procedure __GetTScreenImes(AMachine: TatVirtualMachine);
    procedure __GetTScreenDefaultIme(AMachine: TatVirtualMachine);
    procedure __GetTScreenDefaultKbLayout(AMachine: TatVirtualMachine);
    procedure __GetTScreenHeight(AMachine: TatVirtualMachine);
    procedure __GetTScreenPixelsPerInch(AMachine: TatVirtualMachine);
    procedure __GetTScreenPrimaryMonitor(AMachine: TatVirtualMachine);
    procedure __GetTScreenWidth(AMachine: TatVirtualMachine);
    procedure __TApplicationCreate(AMachine: TatVirtualMachine);
    procedure __TApplicationDestroy(AMachine: TatVirtualMachine);
    procedure __TApplicationActivateHint(AMachine: TatVirtualMachine);
    procedure __TApplicationAddPopupForm(AMachine: TatVirtualMachine);
    procedure __TApplicationBringToFront(AMachine: TatVirtualMachine);
    procedure __TApplicationControlDestroyed(AMachine: TatVirtualMachine);
    procedure __TApplicationCancelHint(AMachine: TatVirtualMachine);
    procedure __TApplicationCreateHandle(AMachine: TatVirtualMachine);
    procedure __TApplicationDoApplicationIdle(AMachine: TatVirtualMachine);
    procedure __TApplicationExecuteAction(AMachine: TatVirtualMachine);
    procedure __TApplicationHandleException(AMachine: TatVirtualMachine);
    procedure __TApplicationHandleMessage(AMachine: TatVirtualMachine);
    procedure __TApplicationHelpCommand(AMachine: TatVirtualMachine);
    procedure __TApplicationHelpContext(AMachine: TatVirtualMachine);
    procedure __TApplicationHelpJump(AMachine: TatVirtualMachine);
    procedure __TApplicationHelpKeyword(AMachine: TatVirtualMachine);
    procedure __TApplicationHelpShowTableOfContents(AMachine: TatVirtualMachine);
    procedure __TApplicationHideHint(AMachine: TatVirtualMachine);
    procedure __TApplicationHintMouseMessage(AMachine: TatVirtualMachine);
    procedure __TApplicationHookSynchronizeWakeup(AMachine: TatVirtualMachine);
    procedure __TApplicationInitialize(AMachine: TatVirtualMachine);
    procedure __TApplicationIsRightToLeft(AMachine: TatVirtualMachine);
    procedure __TApplicationMinimize(AMachine: TatVirtualMachine);
    procedure __TApplicationModalStarted(AMachine: TatVirtualMachine);
    procedure __TApplicationModalFinished(AMachine: TatVirtualMachine);
    procedure __TApplicationNormalizeAllTopMosts(AMachine: TatVirtualMachine);
    procedure __TApplicationNormalizeTopMosts(AMachine: TatVirtualMachine);
    procedure __TApplicationProcessMessages(AMachine: TatVirtualMachine);
    procedure __TApplicationRemovePopupForm(AMachine: TatVirtualMachine);
    procedure __TApplicationRestore(AMachine: TatVirtualMachine);
    procedure __TApplicationRestoreTopMosts(AMachine: TatVirtualMachine);
    procedure __TApplicationRun(AMachine: TatVirtualMachine);
    procedure __TApplicationShowException(AMachine: TatVirtualMachine);
    procedure __TApplicationTerminate(AMachine: TatVirtualMachine);
    procedure __TApplicationUnhookSynchronizeWakeup(AMachine: TatVirtualMachine);
    procedure __TApplicationUpdateAction(AMachine: TatVirtualMachine);
    procedure __TApplicationUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __TApplicationUseRightToLeftReading(AMachine: TatVirtualMachine);
    procedure __TApplicationUseRightToLeftScrollBar(AMachine: TatVirtualMachine);
    procedure __TApplicationMessageBox(AMachine: TatVirtualMachine);
    procedure __GetTApplicationActive(AMachine: TatVirtualMachine);
    procedure __GetTApplicationActionUpdateDelay(AMachine: TatVirtualMachine);
    procedure __SetTApplicationActionUpdateDelay(AMachine: TatVirtualMachine);
    procedure __GetTApplicationActiveFormHandle(AMachine: TatVirtualMachine);
    procedure __GetTApplicationAllowTesting(AMachine: TatVirtualMachine);
    procedure __SetTApplicationAllowTesting(AMachine: TatVirtualMachine);
    procedure __GetTApplicationAutoDragDocking(AMachine: TatVirtualMachine);
    procedure __SetTApplicationAutoDragDocking(AMachine: TatVirtualMachine);
    procedure __GetTApplicationCurrentHelpFile(AMachine: TatVirtualMachine);
    procedure __GetTApplicationDefaultFont(AMachine: TatVirtualMachine);
    procedure __SetTApplicationDefaultFont(AMachine: TatVirtualMachine);
    procedure __GetTApplicationDialogHandle(AMachine: TatVirtualMachine);
    procedure __SetTApplicationDialogHandle(AMachine: TatVirtualMachine);
    procedure __GetTApplicationEnumAllWindowsOnActivateHint(AMachine: TatVirtualMachine);
    procedure __SetTApplicationEnumAllWindowsOnActivateHint(AMachine: TatVirtualMachine);
    procedure __GetTApplicationExeName(AMachine: TatVirtualMachine);
    procedure __GetTApplicationHelpFile(AMachine: TatVirtualMachine);
    procedure __SetTApplicationHelpFile(AMachine: TatVirtualMachine);
    procedure __GetTApplicationHint(AMachine: TatVirtualMachine);
    procedure __SetTApplicationHint(AMachine: TatVirtualMachine);
    procedure __GetTApplicationHintColor(AMachine: TatVirtualMachine);
    procedure __SetTApplicationHintColor(AMachine: TatVirtualMachine);
    procedure __GetTApplicationHintHidePause(AMachine: TatVirtualMachine);
    procedure __SetTApplicationHintHidePause(AMachine: TatVirtualMachine);
    procedure __GetTApplicationHintPause(AMachine: TatVirtualMachine);
    procedure __SetTApplicationHintPause(AMachine: TatVirtualMachine);
    procedure __GetTApplicationHintShortCuts(AMachine: TatVirtualMachine);
    procedure __SetTApplicationHintShortCuts(AMachine: TatVirtualMachine);
    procedure __GetTApplicationHintShortPause(AMachine: TatVirtualMachine);
    procedure __SetTApplicationHintShortPause(AMachine: TatVirtualMachine);
    procedure __GetTApplicationIcon(AMachine: TatVirtualMachine);
    procedure __SetTApplicationIcon(AMachine: TatVirtualMachine);
    procedure __GetTApplicationMainForm(AMachine: TatVirtualMachine);
    procedure __GetTApplicationMainFormHandle(AMachine: TatVirtualMachine);
    procedure __GetTApplicationMainFormOnTaskBar(AMachine: TatVirtualMachine);
    procedure __SetTApplicationMainFormOnTaskBar(AMachine: TatVirtualMachine);
    procedure __GetTApplicationModalLevel(AMachine: TatVirtualMachine);
    procedure __GetTApplicationModalPopupMode(AMachine: TatVirtualMachine);
    procedure __SetTApplicationModalPopupMode(AMachine: TatVirtualMachine);
    procedure __GetTApplicationBiDiMode(AMachine: TatVirtualMachine);
    procedure __SetTApplicationBiDiMode(AMachine: TatVirtualMachine);
    procedure __GetTApplicationBiDiKeyboard(AMachine: TatVirtualMachine);
    procedure __SetTApplicationBiDiKeyboard(AMachine: TatVirtualMachine);
    procedure __GetTApplicationNonBiDiKeyboard(AMachine: TatVirtualMachine);
    procedure __SetTApplicationNonBiDiKeyboard(AMachine: TatVirtualMachine);
    procedure __GetTApplicationShowHint(AMachine: TatVirtualMachine);
    procedure __SetTApplicationShowHint(AMachine: TatVirtualMachine);
    procedure __GetTApplicationShowMainForm(AMachine: TatVirtualMachine);
    procedure __SetTApplicationShowMainForm(AMachine: TatVirtualMachine);
    procedure __GetTApplicationTerminated(AMachine: TatVirtualMachine);
    procedure __GetTApplicationTitle(AMachine: TatVirtualMachine);
    procedure __SetTApplicationTitle(AMachine: TatVirtualMachine);
    procedure __GetTApplicationUpdateFormatSettings(AMachine: TatVirtualMachine);
    procedure __SetTApplicationUpdateFormatSettings(AMachine: TatVirtualMachine);
    procedure __GetTApplicationUpdateMetricSettings(AMachine: TatVirtualMachine);
    procedure __SetTApplicationUpdateMetricSettings(AMachine: TatVirtualMachine);
    procedure __GetTApplicationHandle(AMachine: TatVirtualMachine);
    procedure __SetTApplicationHandle(AMachine: TatVirtualMachine);
    procedure __GetTApplicationPopupControlWnd(AMachine: TatVirtualMachine);
    procedure __GetParentForm(AMachine: TatVirtualMachine);
    procedure __ValidParentForm(AMachine: TatVirtualMachine);
    procedure __IsAccel(AMachine: TatVirtualMachine);
    procedure __KeysToShiftState(AMachine: TatVirtualMachine);
    procedure __KeyDataToShiftState(AMachine: TatVirtualMachine);
    procedure __KeyboardStateToShiftState(AMachine: TatVirtualMachine);
    procedure __ForegroundTask(AMachine: TatVirtualMachine);
    procedure __GetApplication(AMachine: TatVirtualMachine);
    procedure __SetApplication(AMachine: TatVirtualMachine);
    procedure __GetScreen(AMachine: TatVirtualMachine);
    procedure __SetScreen(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TControlScrollBarClass = class of TControlScrollBar;
  TScrollingWinControlClass = class of TScrollingWinControl;
  TScrollBoxClass = class of TScrollBox;
  TCustomFrameClass = class of TCustomFrame;
  TFrameClass = class of TFrame;
  TGlassFrameClass = class of TGlassFrame;
  TCustomFormClass = class of TCustomForm;
  TCustomActiveFormClass = class of TCustomActiveForm;
  TFormClass = class of TForm;
  TCustomDockFormClass = class of TCustomDockForm;
  TMonitorClass = class of TMonitor;
  TScreenClass = class of TScreen;
  TApplicationClass = class of TApplication;

  TatFormsDispatcher = class(TatEventDispatcher)
  private
    procedure __TCloseEvent( Sender: TObject; var Action: TCloseAction);
    procedure __TCloseQueryEvent( Sender: TObject; var CanClose: Boolean);
    function __THelpEvent( Command: Word;  Data: Longint; var CallHelp: Boolean): Boolean;
    procedure __TExceptionEvent( Sender: TObject;  E: Exception);
    procedure __TGetHandleEvent(var Handle: HWND);
    procedure __TIdleEvent( Sender: TObject; var Done: Boolean);
    procedure __TSettingChangeEvent( Sender: TObject;  Flag: Integer; const Section: string; var Result: Longint);
  end;

  TPopupWndWrapper = class(TatRecordWrapper)
  private
    FID: Integer;
    FControlWnd: HWND;
  public
    constructor Create(ARecord: TPopupWnd);
    function ObjToRec: TPopupWnd;
  published
    property ID: Integer read FID write FID;
    property ControlWnd: HWND read FControlWnd write FControlWnd;
  end;
  
  TCursorRecWrapper = class(TatRecordWrapper)
  private
    FIndex: Integer;
    FHandle: HCURSOR;
  public
    constructor Create(ARecord: TCursorRec);
    function ObjToRec: TCursorRec;
  published
    property Index: Integer read FIndex write FIndex;
    property Handle: HCURSOR read FHandle write FHandle;
  end;
  
  TCMHintShowPauseWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FWasActive: Integer;
    FResult: Integer;
  public
    constructor Create(ARecord: TCMHintShowPause);
    function ObjToRec: TCMHintShowPause;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property WasActive: Integer read FWasActive write FWasActive;
    property Result: Integer read FResult write FResult;
  end;
  
  TPopupFormWrapper = class(TatRecordWrapper)
  private
    FFormID: Integer;
    FForm: TCustomForm;
    FWasPopup: Boolean;
  public
    constructor Create(ARecord: TPopupForm);
    function ObjToRec: TPopupForm;
  published
    property FormID: Integer read FFormID write FFormID;
    property Form: TCustomForm read FForm write FForm;
    property WasPopup: Boolean read FWasPopup write FWasPopup;
  end;
  

implementation

constructor TPopupWndWrapper.Create(ARecord: TPopupWnd);
begin
  inherited Create;
  FID := ARecord.ID;
  FControlWnd := ARecord.ControlWnd;
end;

function TPopupWndWrapper.ObjToRec: TPopupWnd;
begin
  result.ID := FID;
  result.ControlWnd := FControlWnd;
end;

constructor TCursorRecWrapper.Create(ARecord: TCursorRec);
begin
  inherited Create;
  FIndex := ARecord.Index;
  FHandle := ARecord.Handle;
end;

function TCursorRecWrapper.ObjToRec: TCursorRec;
begin
  result.Index := FIndex;
  result.Handle := FHandle;
end;

constructor TCMHintShowPauseWrapper.Create(ARecord: TCMHintShowPause);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FWasActive := ARecord.WasActive;
  FResult := ARecord.Result;
end;

function TCMHintShowPauseWrapper.ObjToRec: TCMHintShowPause;
begin
  result.Msg := FMsg;
  result.WasActive := FWasActive;
  result.Result := FResult;
end;

constructor TPopupFormWrapper.Create(ARecord: TPopupForm);
begin
  inherited Create;
  FFormID := ARecord.FormID;
  FForm := ARecord.Form;
  FWasPopup := ARecord.WasPopup;
end;

function TPopupFormWrapper.ObjToRec: TPopupForm;
begin
  result.FormID := FFormID;
  result.Form := FForm;
  result.WasPopup := FWasPopup;
end;



procedure TatFormsLibrary.__TControlScrollBarAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlScrollBar(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TControlScrollBarChangeBiDiPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlScrollBar(CurrentObject).ChangeBiDiPosition;
  end;
end;

procedure TatFormsLibrary.__TControlScrollBarIsScrollBarVisible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControlScrollBar(CurrentObject).IsScrollBarVisible;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__GetTControlScrollBarKind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TControlScrollBar(CurrentObject).Kind);
  end;
end;

procedure TatFormsLibrary.__GetTControlScrollBarScrollPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControlScrollBar(CurrentObject).ScrollPos));
  end;
end;

procedure TatFormsLibrary.__TScrollingWinControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScrollingWinControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TScrollingWinControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScrollingWinControl(CurrentObject).Destroy;
  end;
end;

procedure TatFormsLibrary.__TScrollingWinControlDisableAutoRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScrollingWinControl(CurrentObject).DisableAutoRange;
  end;
end;

procedure TatFormsLibrary.__TScrollingWinControlEnableAutoRange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScrollingWinControl(CurrentObject).EnableAutoRange;
  end;
end;

procedure TatFormsLibrary.__TScrollingWinControlScrollInView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScrollingWinControl(CurrentObject).ScrollInView(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TScrollBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScrollBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomFrameCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomFrameClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TGlassFrameCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGlassFrameClass(CurrentClass.ClassRef).Create(TCustomForm(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TGlassFrameAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGlassFrame(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TGlassFrameFrameExtended(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TGlassFrame(CurrentObject).FrameExtended;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TGlassFrameIntersectsControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TGlassFrame(CurrentObject).IntersectsControl(TControl(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomFormCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomFormClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomFormCreateNew(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TCustomFormClass(CurrentClass.ClassRef).CreateNew(TComponent(Integer(GetInputArg(0)))));
2: AResult := Integer(TCustomFormClass(CurrentClass.ClassRef).CreateNew(TComponent(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomFormDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).Destroy;
  end;
end;

procedure TatFormsLibrary.__TCustomFormClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).Close;
  end;
end;

procedure TatFormsLibrary.__TCustomFormCloseQuery(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomForm(CurrentObject).CloseQuery;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomFormDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TCustomForm(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatFormsLibrary.__TCustomFormDefocusControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).DefocusControl(TWinControl(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatFormsLibrary.__TCustomFormDock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).Dock(TWinControl(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatFormsLibrary.__TCustomFormFocusControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).FocusControl(TWinControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TCustomFormGetFormImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomForm(CurrentObject).GetFormImage);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomFormHide(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).Hide;
  end;
end;

procedure TatFormsLibrary.__TCustomFormIsShortCut(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TWMKey;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TWMKeyWrapper) then 
  Param0Rec := TWMKeyWrapper.Create(Param0);
Param0 := TWMKeyWrapper(Param0Rec).ObjToRec;
AResult := TCustomForm(CurrentObject).IsShortCut(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TWMKeyWrapper.Create(Param0)));
  end;
end;

procedure TatFormsLibrary.__TCustomFormMakeFullyVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      0: TCustomForm(CurrentObject).MakeFullyVisible;
      1: TCustomForm(CurrentObject).MakeFullyVisible(TMonitor(Integer(GetInputArg(0))));
    end;
  end;
end;

procedure TatFormsLibrary.__TCustomFormMouseWheelHandler(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMessage;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TMessageWrapper) then 
  Param0Rec := TMessageWrapper.Create(Param0);
Param0 := TMessageWrapper(Param0Rec).ObjToRec;
    TCustomForm(CurrentObject).MouseWheelHandler(Param0);
    SetInputArg(0,integer(TMessageWrapper.Create(Param0)));
  end;
end;

procedure TatFormsLibrary.__TCustomFormPrint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).Print;
  end;
end;

procedure TatFormsLibrary.__TCustomFormRecreateAsPopup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).RecreateAsPopup(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__TCustomFormRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).Release;
  end;
end;

procedure TatFormsLibrary.__TCustomFormSendCancelMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).SendCancelMode(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TCustomFormSetFocus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).SetFocus;
  end;
end;

procedure TatFormsLibrary.__TCustomFormSetFocusedControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomForm(CurrentObject).SetFocusedControl(TWinControl(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomFormShow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).Show;
  end;
end;

procedure TatFormsLibrary.__TCustomFormShowModal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomForm(CurrentObject).ShowModal);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomFormWantChildKey(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TMessageWrapper) then 
  Param1Rec := TMessageWrapper.Create(Param1);
Param1 := TMessageWrapper(Param1Rec).ObjToRec;
AResult := TCustomForm(CurrentObject).WantChildKey(TControl(Integer(GetInputArg(0))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TMessageWrapper.Create(Param1)));
  end;
end;

procedure TatFormsLibrary.__TCustomFormset_PopupParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).set_PopupParent(TCustomForm(Integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TCustomFormAfterConstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).AfterConstruction;
  end;
end;

procedure TatFormsLibrary.__TCustomFormBeforeDestruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).BeforeDestruction;
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).Active);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormActiveControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomForm(CurrentObject).ActiveControl));
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormActiveControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).ActiveControl:=TWinControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormActiveOleControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomForm(CurrentObject).ActiveOleControl));
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormActiveOleControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).ActiveOleControl:=TWinControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormBorderStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).BorderStyle);
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormBorderStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).BorderStyle:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomForm(CurrentObject).Canvas));
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).DropTarget);
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormDropTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).DropTarget:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormFormState(AMachine: TatVirtualMachine);
var
PropValueSet: TFormState;
begin
  with AMachine do
  begin
    PropValueSet := TCustomForm(CurrentObject).FormState;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormGlassFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomForm(CurrentObject).GlassFrame));
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormGlassFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).GlassFrame:=TGlassFrame(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormHelpFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).HelpFile);
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormHelpFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).HelpFile:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormKeyPreview(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).KeyPreview);
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormKeyPreview(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).KeyPreview:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomForm(CurrentObject).Menu));
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).Menu:=TMainMenu(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormModalResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).ModalResult);
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormModalResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).ModalResult:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormMonitor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomForm(CurrentObject).Monitor));
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormPopupMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).PopupMode);
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormPopupMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).PopupMode:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormScreenSnap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).ScreenSnap);
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormScreenSnap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).ScreenSnap:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormSnapBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomForm(CurrentObject).SnapBuffer));
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormSnapBuffer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).SnapBuffer:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormWindowState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomForm(CurrentObject).WindowState);
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormWindowState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).WindowState:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTCustomFormPopupParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomForm(CurrentObject).PopupParent));
  end;
end;

procedure TatFormsLibrary.__SetTCustomFormPopupParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomForm(CurrentObject).PopupParent:=TCustomForm(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__TCustomActiveFormCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActiveFormClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TCustomActiveFormWantChildKey(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TMessageWrapper) then 
  Param1Rec := TMessageWrapper.Create(Param1);
Param1 := TMessageWrapper(Param1Rec).ObjToRec;
AResult := TCustomActiveForm(CurrentObject).WantChildKey(TControl(Integer(GetInputArg(0))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TMessageWrapper.Create(Param1)));
  end;
end;

procedure TatFormsLibrary.__TFormArrangeIcons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TForm(CurrentObject).ArrangeIcons;
  end;
end;

procedure TatFormsLibrary.__TFormCascade(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TForm(CurrentObject).Cascade;
  end;
end;

procedure TatFormsLibrary.__TFormNext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TForm(CurrentObject).Next;
  end;
end;

procedure TatFormsLibrary.__TFormPrevious(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TForm(CurrentObject).Previous;
  end;
end;

procedure TatFormsLibrary.__TFormTile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TForm(CurrentObject).Tile;
  end;
end;

procedure TatFormsLibrary.__TCustomDockFormCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomDockFormClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__GetTMonitorHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMonitor(CurrentObject).Handle));
  end;
end;

procedure TatFormsLibrary.__GetTMonitorMonitorNum(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMonitor(CurrentObject).MonitorNum));
  end;
end;

procedure TatFormsLibrary.__GetTMonitorLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMonitor(CurrentObject).Left));
  end;
end;

procedure TatFormsLibrary.__GetTMonitorHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMonitor(CurrentObject).Height));
  end;
end;

procedure TatFormsLibrary.__GetTMonitorTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMonitor(CurrentObject).Top));
  end;
end;

procedure TatFormsLibrary.__GetTMonitorWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMonitor(CurrentObject).Width));
  end;
end;

procedure TatFormsLibrary.__GetTMonitorBoundsRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TMonitor(CurrentObject).BoundsRect)));
  end;
end;

procedure TatFormsLibrary.__GetTMonitorWorkareaRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TMonitor(CurrentObject).WorkareaRect)));
  end;
end;

procedure TatFormsLibrary.__GetTMonitorPrimary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMonitor(CurrentObject).Primary);
  end;
end;

procedure TatFormsLibrary.__TScreenCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScreenClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TScreenDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).Destroy;
  end;
end;

procedure TatFormsLibrary.__TScreenDisableAlign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).DisableAlign;
  end;
end;

procedure TatFormsLibrary.__TScreenEnableAlign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).EnableAlign;
  end;
end;

procedure TatFormsLibrary.__TScreenMonitorFromPoint(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TScreen(CurrentObject).MonitorFromPoint(TPointWrapper(integer(GetInputArg(0))).ObjToRec));
2: AResult := Integer(TScreen(CurrentObject).MonitorFromPoint(TPointWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TScreenMonitorFromRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TScreen(CurrentObject).MonitorFromRect(TRectWrapper(integer(GetInputArg(0))).ObjToRec));
2: AResult := Integer(TScreen(CurrentObject).MonitorFromRect(TRectWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TScreenMonitorFromWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TScreen(CurrentObject).MonitorFromWindow(GetInputArg(0)));
2: AResult := Integer(TScreen(CurrentObject).MonitorFromWindow(GetInputArg(0),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TScreenRealign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).Realign;
  end;
end;

procedure TatFormsLibrary.__TScreenResetFonts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).ResetFonts;
  end;
end;

procedure TatFormsLibrary.__GetTScreenActiveControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).ActiveControl));
  end;
end;

procedure TatFormsLibrary.__GetTScreenActiveCustomForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).ActiveCustomForm));
  end;
end;

procedure TatFormsLibrary.__GetTScreenActiveForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).ActiveForm));
  end;
end;

procedure TatFormsLibrary.__GetTScreenCustomFormCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).CustomFormCount));
  end;
end;

procedure TatFormsLibrary.__GetTScreenCustomForms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).CustomForms[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatFormsLibrary.__GetTScreenCursorCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).CursorCount));
  end;
end;

procedure TatFormsLibrary.__GetTScreenCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TScreen(CurrentObject).Cursor);
  end;
end;

procedure TatFormsLibrary.__SetTScreenCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).Cursor:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTScreenCursors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).Cursors[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatFormsLibrary.__SetTScreenCursors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).Cursors[VarToInteger(GetArrayIndex(0))]:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatFormsLibrary.__GetTScreenDataModules(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).DataModules[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatFormsLibrary.__GetTScreenDataModuleCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).DataModuleCount));
  end;
end;

procedure TatFormsLibrary.__GetTScreenFocusedForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).FocusedForm));
  end;
end;

procedure TatFormsLibrary.__SetTScreenFocusedForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).FocusedForm:=TCustomForm(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTScreenSaveFocusedList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).SaveFocusedList));
  end;
end;

procedure TatFormsLibrary.__GetTScreenMonitorCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).MonitorCount));
  end;
end;

procedure TatFormsLibrary.__GetTScreenMonitors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).Monitors[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatFormsLibrary.__GetTScreenDesktopRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TScreen(CurrentObject).DesktopRect)));
  end;
end;

procedure TatFormsLibrary.__GetTScreenDesktopHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).DesktopHeight));
  end;
end;

procedure TatFormsLibrary.__GetTScreenDesktopLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).DesktopLeft));
  end;
end;

procedure TatFormsLibrary.__GetTScreenDesktopTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).DesktopTop));
  end;
end;

procedure TatFormsLibrary.__GetTScreenDesktopWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).DesktopWidth));
  end;
end;

procedure TatFormsLibrary.__GetTScreenWorkAreaRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TScreen(CurrentObject).WorkAreaRect)));
  end;
end;

procedure TatFormsLibrary.__GetTScreenWorkAreaHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).WorkAreaHeight));
  end;
end;

procedure TatFormsLibrary.__GetTScreenWorkAreaLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).WorkAreaLeft));
  end;
end;

procedure TatFormsLibrary.__GetTScreenWorkAreaTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).WorkAreaTop));
  end;
end;

procedure TatFormsLibrary.__GetTScreenWorkAreaWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).WorkAreaWidth));
  end;
end;

procedure TatFormsLibrary.__GetTScreenHintFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).HintFont));
  end;
end;

procedure TatFormsLibrary.__SetTScreenHintFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).HintFont:=TFont(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTScreenIconFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).IconFont));
  end;
end;

procedure TatFormsLibrary.__SetTScreenIconFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).IconFont:=TFont(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTScreenMenuFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).MenuFont));
  end;
end;

procedure TatFormsLibrary.__SetTScreenMenuFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).MenuFont:=TFont(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTScreenMessageFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).MessageFont));
  end;
end;

procedure TatFormsLibrary.__SetTScreenMessageFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).MessageFont:=TFont(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTScreenCaptionFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).CaptionFont));
  end;
end;

procedure TatFormsLibrary.__SetTScreenCaptionFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreen(CurrentObject).CaptionFont:=TFont(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTScreenFonts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).Fonts));
  end;
end;

procedure TatFormsLibrary.__GetTScreenFormCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).FormCount));
  end;
end;

procedure TatFormsLibrary.__GetTScreenForms(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).Forms[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatFormsLibrary.__GetTScreenImes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).Imes));
  end;
end;

procedure TatFormsLibrary.__GetTScreenDefaultIme(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TScreen(CurrentObject).DefaultIme);
  end;
end;

procedure TatFormsLibrary.__GetTScreenDefaultKbLayout(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).DefaultKbLayout));
  end;
end;

procedure TatFormsLibrary.__GetTScreenHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).Height));
  end;
end;

procedure TatFormsLibrary.__GetTScreenPixelsPerInch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).PixelsPerInch));
  end;
end;

procedure TatFormsLibrary.__GetTScreenPrimaryMonitor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).PrimaryMonitor));
  end;
end;

procedure TatFormsLibrary.__GetTScreenWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreen(CurrentObject).Width));
  end;
end;

procedure TatFormsLibrary.__TApplicationCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TApplicationClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Destroy;
  end;
end;

procedure TatFormsLibrary.__TApplicationActivateHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ActivateHint(TPointWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatFormsLibrary.__TApplicationAddPopupForm(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TApplication(CurrentObject).AddPopupForm(TCustomForm(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationBringToFront(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).BringToFront;
  end;
end;

procedure TatFormsLibrary.__TApplicationControlDestroyed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ControlDestroyed(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TApplicationCancelHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).CancelHint;
  end;
end;

procedure TatFormsLibrary.__TApplicationCreateHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).CreateHandle;
  end;
end;

procedure TatFormsLibrary.__TApplicationDoApplicationIdle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).DoApplicationIdle;
  end;
end;

procedure TatFormsLibrary.__TApplicationExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationHandleException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HandleException(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TApplicationHandleMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HandleMessage;
  end;
end;

procedure TatFormsLibrary.__TApplicationHelpCommand(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).HelpCommand(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationHelpContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).HelpContext(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationHelpJump(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).HelpJump(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationHelpKeyword(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).HelpKeyword(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationHelpShowTableOfContents(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).HelpShowTableOfContents;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationHideHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HideHint;
  end;
end;

procedure TatFormsLibrary.__TApplicationHintMouseMessage(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TMessage;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TMessageWrapper) then 
  Param1Rec := TMessageWrapper.Create(Param1);
Param1 := TMessageWrapper(Param1Rec).ObjToRec;
    TApplication(CurrentObject).HintMouseMessage(TControl(Integer(GetInputArg(0))),Param1);
    SetInputArg(1,integer(TMessageWrapper.Create(Param1)));
  end;
end;

procedure TatFormsLibrary.__TApplicationHookSynchronizeWakeup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HookSynchronizeWakeup;
  end;
end;

procedure TatFormsLibrary.__TApplicationInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Initialize;
  end;
end;

procedure TatFormsLibrary.__TApplicationIsRightToLeft(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).IsRightToLeft;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationMinimize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Minimize;
  end;
end;

procedure TatFormsLibrary.__TApplicationModalStarted(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ModalStarted;
  end;
end;

procedure TatFormsLibrary.__TApplicationModalFinished(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ModalFinished;
  end;
end;

procedure TatFormsLibrary.__TApplicationNormalizeAllTopMosts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).NormalizeAllTopMosts;
  end;
end;

procedure TatFormsLibrary.__TApplicationNormalizeTopMosts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).NormalizeTopMosts;
  end;
end;

procedure TatFormsLibrary.__TApplicationProcessMessages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ProcessMessages;
  end;
end;

procedure TatFormsLibrary.__TApplicationRemovePopupForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).RemovePopupForm(TCustomForm(Integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TApplicationRestore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Restore;
  end;
end;

procedure TatFormsLibrary.__TApplicationRestoreTopMosts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).RestoreTopMosts;
  end;
end;

procedure TatFormsLibrary.__TApplicationRun(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Run;
  end;
end;

procedure TatFormsLibrary.__TApplicationShowException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ShowException(Exception(integer(GetInputArg(0))));
  end;
end;

procedure TatFormsLibrary.__TApplicationTerminate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Terminate;
  end;
end;

procedure TatFormsLibrary.__TApplicationUnhookSynchronizeWakeup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).UnhookSynchronizeWakeup;
  end;
end;

procedure TatFormsLibrary.__TApplicationUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationUseRightToLeftReading(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).UseRightToLeftReading;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationUseRightToLeftScrollBar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TApplication(CurrentObject).UseRightToLeftScrollBar;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__TApplicationMessageBox(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := Integer(TApplication(CurrentObject).MessageBox(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
3: AResult := Integer(TApplication(CurrentObject).MessageBox(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).Active);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationActionUpdateDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).ActionUpdateDelay));
  end;
end;

procedure TatFormsLibrary.__SetTApplicationActionUpdateDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ActionUpdateDelay:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationActiveFormHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).ActiveFormHandle));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationAllowTesting(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).AllowTesting);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationAllowTesting(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).AllowTesting:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationAutoDragDocking(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).AutoDragDocking);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationAutoDragDocking(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).AutoDragDocking:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationCurrentHelpFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).CurrentHelpFile);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationDefaultFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).DefaultFont));
  end;
end;

procedure TatFormsLibrary.__SetTApplicationDefaultFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).DefaultFont:=TFont(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationDialogHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).DialogHandle));
  end;
end;

procedure TatFormsLibrary.__SetTApplicationDialogHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).DialogHandle:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationEnumAllWindowsOnActivateHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).EnumAllWindowsOnActivateHint);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationEnumAllWindowsOnActivateHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).EnumAllWindowsOnActivateHint:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationExeName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).ExeName);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationHelpFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).HelpFile);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationHelpFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HelpFile:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).Hint);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Hint:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationHintColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).HintColor);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationHintColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HintColor:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationHintHidePause(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).HintHidePause));
  end;
end;

procedure TatFormsLibrary.__SetTApplicationHintHidePause(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HintHidePause:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationHintPause(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).HintPause));
  end;
end;

procedure TatFormsLibrary.__SetTApplicationHintPause(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HintPause:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationHintShortCuts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).HintShortCuts);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationHintShortCuts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HintShortCuts:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationHintShortPause(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).HintShortPause));
  end;
end;

procedure TatFormsLibrary.__SetTApplicationHintShortPause(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).HintShortPause:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).Icon));
  end;
end;

procedure TatFormsLibrary.__SetTApplicationIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Icon:=TIcon(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationMainForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).MainForm));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationMainFormHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).MainFormHandle));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationMainFormOnTaskBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).MainFormOnTaskBar);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationMainFormOnTaskBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).MainFormOnTaskBar:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationModalLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).ModalLevel));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationModalPopupMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).ModalPopupMode);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationModalPopupMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ModalPopupMode:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationBiDiMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).BiDiMode);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationBiDiMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).BiDiMode:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationBiDiKeyboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).BiDiKeyboard);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationBiDiKeyboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).BiDiKeyboard:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationNonBiDiKeyboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).NonBiDiKeyboard);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationNonBiDiKeyboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).NonBiDiKeyboard:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationShowHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).ShowHint);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationShowHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ShowHint:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationShowMainForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).ShowMainForm);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationShowMainForm(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).ShowMainForm:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationTerminated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).Terminated);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).Title);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Title:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationUpdateFormatSettings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).UpdateFormatSettings);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationUpdateFormatSettings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).UpdateFormatSettings:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationUpdateMetricSettings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TApplication(CurrentObject).UpdateMetricSettings);
  end;
end;

procedure TatFormsLibrary.__SetTApplicationUpdateMetricSettings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).UpdateMetricSettings:=GetInputArg(0);
  end;
end;

procedure TatFormsLibrary.__GetTApplicationHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).Handle));
  end;
end;

procedure TatFormsLibrary.__SetTApplicationHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TApplication(CurrentObject).Handle:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatFormsLibrary.__GetTApplicationPopupControlWnd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TApplication(CurrentObject).PopupControlWnd));
  end;
end;

procedure TatFormsDispatcher.__TCloseEvent( Sender: TObject; var Action: TCloseAction);
var
  ActionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCloseEvent(BeforeCall)(Sender,Action);
    ActionTemp := Action;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ActionTemp]);
    Action := ActionTemp;
    if AssignedMethod(AfterCall) then
      TCloseEvent(AfterCall)(Sender,Action);
  end;
end;

procedure TatFormsDispatcher.__TCloseQueryEvent( Sender: TObject; var CanClose: Boolean);
var
  CanCloseTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCloseQueryEvent(BeforeCall)(Sender,CanClose);
    CanCloseTemp := CanClose;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,CanCloseTemp]);
    CanClose := CanCloseTemp;
    if AssignedMethod(AfterCall) then
      TCloseQueryEvent(AfterCall)(Sender,CanClose);
  end;
end;

function TatFormsDispatcher.__THelpEvent( Command: Word;  Data: Longint; var CallHelp: Boolean): Boolean;
var
  CallHelpTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      THelpEvent(BeforeCall)(Command,Data,CallHelp);
    CallHelpTemp := CallHelp;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Command,Data,CallHelpTemp]);
    CallHelp := CallHelpTemp;
    if AssignedMethod(AfterCall) then
      THelpEvent(AfterCall)(Command,Data,CallHelp);
  end;
end;

procedure TatFormsDispatcher.__TExceptionEvent( Sender: TObject;  E: Exception);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TExceptionEvent(BeforeCall)(Sender,E);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,E]);
    if AssignedMethod(AfterCall) then
      TExceptionEvent(AfterCall)(Sender,E);
  end;
end;

procedure TatFormsDispatcher.__TGetHandleEvent(var Handle: HWND);
var
  HandleTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetHandleEvent(BeforeCall)(Handle);
    HandleTemp := Integer(Handle);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [HandleTemp]);
    Handle := VarToInteger(HandleTemp);
    if AssignedMethod(AfterCall) then
      TGetHandleEvent(AfterCall)(Handle);
  end;
end;

procedure TatFormsDispatcher.__TIdleEvent( Sender: TObject; var Done: Boolean);
var
  DoneTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIdleEvent(BeforeCall)(Sender,Done);
    DoneTemp := Done;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,DoneTemp]);
    Done := DoneTemp;
    if AssignedMethod(AfterCall) then
      TIdleEvent(AfterCall)(Sender,Done);
  end;
end;

procedure TatFormsDispatcher.__TSettingChangeEvent( Sender: TObject;  Flag: Integer; const Section: string; var Result: Longint);
var
  ResultTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSettingChangeEvent(BeforeCall)(Sender,Flag,Section,Result);
    ResultTemp := Integer(Result);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Flag,Section,ResultTemp]);
    Result := VarToInteger(ResultTemp);
    if AssignedMethod(AfterCall) then
      TSettingChangeEvent(AfterCall)(Sender,Flag,Section,Result);
  end;
end;

procedure TatFormsLibrary.__GetParentForm(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(Forms.GetParentForm(TControl(Integer(GetInputArg(0)))));
2: AResult := Integer(Forms.GetParentForm(TControl(Integer(GetInputArg(0))),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__ValidParentForm(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(Forms.ValidParentForm(TControl(Integer(GetInputArg(0)))));
2: AResult := Integer(Forms.ValidParentForm(TControl(Integer(GetInputArg(0))),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__IsAccel(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Forms.IsAccel(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__KeysToShiftState(AMachine: TatVirtualMachine);
  var
  AResultSet: TShiftState;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := Forms.KeysToShiftState(VarToInteger(GetInputArg(0)));
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__KeyDataToShiftState(AMachine: TatVirtualMachine);
  var
  AResultSet: TShiftState;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := Forms.KeyDataToShiftState(VarToInteger(GetInputArg(0)));
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__KeyboardStateToShiftState(AMachine: TatVirtualMachine);
  var
  AResultSet: TShiftState;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := Forms.KeyboardStateToShiftState;
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__ForegroundTask(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Forms.ForegroundTask;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFormsLibrary.__GetApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Forms.Application));
  end;
end;

procedure TatFormsLibrary.__SetApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Forms.Application:=TApplication(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.__GetScreen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Forms.Screen));
  end;
end;

procedure TatFormsLibrary.__SetScreen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Forms.Screen:=TScreen(Integer(GetInputArg(0)));
  end;
end;

procedure TatFormsLibrary.Init;
begin
  With Scripter.DefineClass(TControlScrollBar) do
  begin
    DefineMethod('Assign',1,tkNone,nil,__TControlScrollBarAssign,false,0);
    DefineMethod('ChangeBiDiPosition',0,tkNone,nil,__TControlScrollBarChangeBiDiPosition,false,0);
    DefineMethod('IsScrollBarVisible',0,tkVariant,nil,__TControlScrollBarIsScrollBarVisible,false,0);
    DefineProp('Kind',tkEnumeration,__GetTControlScrollBarKind,nil,nil,false,0);
    DefineProp('ScrollPos',tkInteger,__GetTControlScrollBarScrollPos,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TScrollingWinControl) do
  begin
    DefineMethod('Create',1,tkClass,TScrollingWinControl,__TScrollingWinControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TScrollingWinControlDestroy,false,0);
    DefineMethod('DisableAutoRange',0,tkNone,nil,__TScrollingWinControlDisableAutoRange,false,0);
    DefineMethod('EnableAutoRange',0,tkNone,nil,__TScrollingWinControlEnableAutoRange,false,0);
    DefineMethod('ScrollInView',1,tkNone,nil,__TScrollingWinControlScrollInView,false,0);
  end;
  With Scripter.DefineClass(TScrollBox) do
  begin
    DefineMethod('Create',1,tkClass,TScrollBox,__TScrollBoxCreate,true,0);
  end;
  With Scripter.DefineClass(TCustomFrame) do
  begin
    DefineMethod('Create',1,tkClass,TCustomFrame,__TCustomFrameCreate,true,0);
  end;
  With Scripter.DefineClass(TFrame) do
  begin
  end;
  With Scripter.DefineClass(TGlassFrame) do
  begin
    DefineMethod('Create',1,tkClass,TGlassFrame,__TGlassFrameCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TGlassFrameAssign,false,0);
    DefineMethod('FrameExtended',0,tkVariant,nil,__TGlassFrameFrameExtended,false,0);
    DefineMethod('IntersectsControl',1,tkVariant,nil,__TGlassFrameIntersectsControl,false,0);
  end;
  With Scripter.DefineClass(TCustomForm) do
  begin
    DefineMethod('Create',1,tkClass,TCustomForm,__TCustomFormCreate,true,0);
    DefineMethod('CreateNew',2,tkClass,TCustomForm,__TCustomFormCreateNew,true,1);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomFormDestroy,false,0);
    DefineMethod('Close',0,tkNone,nil,__TCustomFormClose,false,0);
    DefineMethod('CloseQuery',0,tkVariant,nil,__TCustomFormCloseQuery,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TCustomFormDefaultHandler,false,0).SetVarArgs([0]);
    DefineMethod('DefocusControl',2,tkNone,nil,__TCustomFormDefocusControl,false,0);
    DefineMethod('Dock',2,tkNone,nil,__TCustomFormDock,false,0);
    DefineMethod('FocusControl',1,tkNone,nil,__TCustomFormFocusControl,false,0);
    DefineMethod('GetFormImage',0,tkClass,TBitmap,__TCustomFormGetFormImage,false,0);
    DefineMethod('Hide',0,tkNone,nil,__TCustomFormHide,false,0);
    DefineMethod('IsShortCut',1,tkVariant,nil,__TCustomFormIsShortCut,false,0).SetVarArgs([0]);
    DefineMethod('MakeFullyVisible',1,tkNone,nil,__TCustomFormMakeFullyVisible,false,1);
    DefineMethod('MouseWheelHandler',1,tkNone,nil,__TCustomFormMouseWheelHandler,false,0).SetVarArgs([0]);
    DefineMethod('Print',0,tkNone,nil,__TCustomFormPrint,false,0);
    DefineMethod('RecreateAsPopup',1,tkNone,nil,__TCustomFormRecreateAsPopup,false,0);
    DefineMethod('Release',0,tkNone,nil,__TCustomFormRelease,false,0);
    DefineMethod('SendCancelMode',1,tkNone,nil,__TCustomFormSendCancelMode,false,0);
    DefineMethod('SetFocus',0,tkNone,nil,__TCustomFormSetFocus,false,0);
    DefineMethod('SetFocusedControl',1,tkVariant,nil,__TCustomFormSetFocusedControl,false,0);
    DefineMethod('Show',0,tkNone,nil,__TCustomFormShow,false,0);
    DefineMethod('ShowModal',0,tkInteger,nil,__TCustomFormShowModal,false,0);
    DefineMethod('WantChildKey',2,tkVariant,nil,__TCustomFormWantChildKey,false,0).SetVarArgs([1]);
    DefineMethod('set_PopupParent',1,tkNone,nil,__TCustomFormset_PopupParent,false,0);
    DefineMethod('AfterConstruction',0,tkNone,nil,__TCustomFormAfterConstruction,false,0);
    DefineMethod('BeforeDestruction',0,tkNone,nil,__TCustomFormBeforeDestruction,false,0);
    DefineProp('Active',tkVariant,__GetTCustomFormActive,nil,nil,false,0);
    DefineProp('ActiveControl',tkClass,__GetTCustomFormActiveControl,__SetTCustomFormActiveControl,TWinControl,false,0);
    DefineProp('Action',tkVariant,nil,nil,nil,false,0);
    DefineProp('ActiveOleControl',tkClass,__GetTCustomFormActiveOleControl,__SetTCustomFormActiveOleControl,TWinControl,false,0);
    DefineProp('BorderStyle',tkEnumeration,__GetTCustomFormBorderStyle,__SetTCustomFormBorderStyle,nil,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomFormCanvas,nil,TCanvas,false,0);
    DefineProp('Caption',tkVariant,nil,nil,nil,false,0);
    DefineProp('Color',tkVariant,nil,nil,nil,false,0);
    DefineProp('DropTarget',tkVariant,__GetTCustomFormDropTarget,__SetTCustomFormDropTarget,nil,false,0);
    DefineProp('Font',tkVariant,nil,nil,nil,false,0);
    DefineProp('FormState',tkInteger,__GetTCustomFormFormState,nil,nil,false,0);
    DefineProp('GlassFrame',tkClass,__GetTCustomFormGlassFrame,__SetTCustomFormGlassFrame,TGlassFrame,false,0);
    DefineProp('HelpFile',tkVariant,__GetTCustomFormHelpFile,__SetTCustomFormHelpFile,nil,false,0);
    DefineProp('KeyPreview',tkVariant,__GetTCustomFormKeyPreview,__SetTCustomFormKeyPreview,nil,false,0);
    DefineProp('Menu',tkClass,__GetTCustomFormMenu,__SetTCustomFormMenu,TMainMenu,false,0);
    DefineProp('ModalResult',tkEnumeration,__GetTCustomFormModalResult,__SetTCustomFormModalResult,nil,false,0);
    DefineProp('Monitor',tkClass,__GetTCustomFormMonitor,nil,TMonitor,false,0);
    DefineProp('PopupMode',tkEnumeration,__GetTCustomFormPopupMode,__SetTCustomFormPopupMode,nil,false,0);
    DefineProp('ScreenSnap',tkVariant,__GetTCustomFormScreenSnap,__SetTCustomFormScreenSnap,nil,false,0);
    DefineProp('SnapBuffer',tkInteger,__GetTCustomFormSnapBuffer,__SetTCustomFormSnapBuffer,nil,false,0);
    DefineProp('WindowState',tkEnumeration,__GetTCustomFormWindowState,__SetTCustomFormWindowState,nil,false,0);
    DefineProp('PopupParent',tkClass,__GetTCustomFormPopupParent,__SetTCustomFormPopupParent,TCustomForm,false,0);
  end;
  With Scripter.DefineClass(TCustomActiveForm) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActiveForm,__TCustomActiveFormCreate,true,0);
    DefineMethod('WantChildKey',2,tkVariant,nil,__TCustomActiveFormWantChildKey,false,0).SetVarArgs([1]);
    DefineProp('Visible',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TForm) do
  begin
    DefineMethod('ArrangeIcons',0,tkNone,nil,__TFormArrangeIcons,false,0);
    DefineMethod('Cascade',0,tkNone,nil,__TFormCascade,false,0);
    DefineMethod('Next',0,tkNone,nil,__TFormNext,false,0);
    DefineMethod('Previous',0,tkNone,nil,__TFormPrevious,false,0);
    DefineMethod('Tile',0,tkNone,nil,__TFormTile,false,0);
    DefineProp('ActiveMDIChild',tkVariant,nil,nil,nil,false,0);
    DefineProp('ClientHandle',tkVariant,nil,nil,nil,false,0);
    DefineProp('DockManager',tkVariant,nil,nil,nil,false,0);
    DefineProp('MDIChildCount',tkVariant,nil,nil,nil,false,0);
    DefineProp('MDIChildren',tkVariant,nil,nil,nil,false,0);
    DefineProp('TileMode',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomDockForm) do
  begin
    DefineMethod('Create',1,tkClass,TCustomDockForm,__TCustomDockFormCreate,true,0);
    DefineProp('AutoScroll',tkVariant,nil,nil,nil,false,0);
    DefineProp('BorderStyle',tkVariant,nil,nil,nil,false,0);
    DefineProp('FormStyle',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TMonitor) do
  begin
    DefineProp('Handle',tkInteger,__GetTMonitorHandle,nil,nil,false,0);
    DefineProp('MonitorNum',tkInteger,__GetTMonitorMonitorNum,nil,nil,false,0);
    DefineProp('Left',tkInteger,__GetTMonitorLeft,nil,nil,false,0);
    DefineProp('Height',tkInteger,__GetTMonitorHeight,nil,nil,false,0);
    DefineProp('Top',tkInteger,__GetTMonitorTop,nil,nil,false,0);
    DefineProp('Width',tkInteger,__GetTMonitorWidth,nil,nil,false,0);
    DefineProp('BoundsRect',tkVariant,__GetTMonitorBoundsRect,nil,nil,false,0);
    DefineProp('WorkareaRect',tkVariant,__GetTMonitorWorkareaRect,nil,nil,false,0);
    DefineProp('Primary',tkVariant,__GetTMonitorPrimary,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TScreen) do
  begin
    DefineMethod('Create',1,tkClass,TScreen,__TScreenCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TScreenDestroy,false,0);
    DefineMethod('DisableAlign',0,tkNone,nil,__TScreenDisableAlign,false,0);
    DefineMethod('EnableAlign',0,tkNone,nil,__TScreenEnableAlign,false,0);
    DefineMethod('MonitorFromPoint',2,tkClass,TMonitor,__TScreenMonitorFromPoint,false,1);
    DefineMethod('MonitorFromRect',2,tkClass,TMonitor,__TScreenMonitorFromRect,false,1);
    DefineMethod('MonitorFromWindow',2,tkClass,TMonitor,__TScreenMonitorFromWindow,false,1);
    DefineMethod('Realign',0,tkNone,nil,__TScreenRealign,false,0);
    DefineMethod('ResetFonts',0,tkNone,nil,__TScreenResetFonts,false,0);
    DefineProp('ActiveControl',tkClass,__GetTScreenActiveControl,nil,TWinControl,false,0);
    DefineProp('ActiveCustomForm',tkClass,__GetTScreenActiveCustomForm,nil,TCustomForm,false,0);
    DefineProp('ActiveForm',tkClass,__GetTScreenActiveForm,nil,TForm,false,0);
    DefineProp('CustomFormCount',tkInteger,__GetTScreenCustomFormCount,nil,nil,false,0);
    DefineProp('CustomForms',tkClass,__GetTScreenCustomForms,nil,TCustomForm,false,1);
    DefineProp('CursorCount',tkInteger,__GetTScreenCursorCount,nil,nil,false,0);
    DefineProp('Cursor',tkEnumeration,__GetTScreenCursor,__SetTScreenCursor,nil,false,0);
    DefineProp('Cursors',tkInteger,__GetTScreenCursors,__SetTScreenCursors,nil,false,1);
    DefineProp('DataModules',tkClass,__GetTScreenDataModules,nil,TDataModule,false,1);
    DefineProp('DataModuleCount',tkInteger,__GetTScreenDataModuleCount,nil,nil,false,0);
    DefineProp('FocusedForm',tkClass,__GetTScreenFocusedForm,__SetTScreenFocusedForm,TCustomForm,false,0);
    DefineProp('SaveFocusedList',tkClass,__GetTScreenSaveFocusedList,nil,TList,false,0);
    DefineProp('MonitorCount',tkInteger,__GetTScreenMonitorCount,nil,nil,false,0);
    DefineProp('Monitors',tkClass,__GetTScreenMonitors,nil,TMonitor,false,1);
    DefineProp('DesktopRect',tkVariant,__GetTScreenDesktopRect,nil,nil,false,0);
    DefineProp('DesktopHeight',tkInteger,__GetTScreenDesktopHeight,nil,nil,false,0);
    DefineProp('DesktopLeft',tkInteger,__GetTScreenDesktopLeft,nil,nil,false,0);
    DefineProp('DesktopTop',tkInteger,__GetTScreenDesktopTop,nil,nil,false,0);
    DefineProp('DesktopWidth',tkInteger,__GetTScreenDesktopWidth,nil,nil,false,0);
    DefineProp('WorkAreaRect',tkVariant,__GetTScreenWorkAreaRect,nil,nil,false,0);
    DefineProp('WorkAreaHeight',tkInteger,__GetTScreenWorkAreaHeight,nil,nil,false,0);
    DefineProp('WorkAreaLeft',tkInteger,__GetTScreenWorkAreaLeft,nil,nil,false,0);
    DefineProp('WorkAreaTop',tkInteger,__GetTScreenWorkAreaTop,nil,nil,false,0);
    DefineProp('WorkAreaWidth',tkInteger,__GetTScreenWorkAreaWidth,nil,nil,false,0);
    DefineProp('HintFont',tkClass,__GetTScreenHintFont,__SetTScreenHintFont,TFont,false,0);
    DefineProp('IconFont',tkClass,__GetTScreenIconFont,__SetTScreenIconFont,TFont,false,0);
    DefineProp('MenuFont',tkClass,__GetTScreenMenuFont,__SetTScreenMenuFont,TFont,false,0);
    DefineProp('MessageFont',tkClass,__GetTScreenMessageFont,__SetTScreenMessageFont,TFont,false,0);
    DefineProp('CaptionFont',tkClass,__GetTScreenCaptionFont,__SetTScreenCaptionFont,TFont,false,0);
    DefineProp('Fonts',tkClass,__GetTScreenFonts,nil,TStrings,false,0);
    DefineProp('FormCount',tkInteger,__GetTScreenFormCount,nil,nil,false,0);
    DefineProp('Forms',tkClass,__GetTScreenForms,nil,TForm,false,1);
    DefineProp('Imes',tkClass,__GetTScreenImes,nil,TStrings,false,0);
    DefineProp('DefaultIme',tkVariant,__GetTScreenDefaultIme,nil,nil,false,0);
    DefineProp('DefaultKbLayout',tkInteger,__GetTScreenDefaultKbLayout,nil,nil,false,0);
    DefineProp('Height',tkInteger,__GetTScreenHeight,nil,nil,false,0);
    DefineProp('PixelsPerInch',tkInteger,__GetTScreenPixelsPerInch,nil,nil,false,0);
    DefineProp('PrimaryMonitor',tkClass,__GetTScreenPrimaryMonitor,nil,TMonitor,false,0);
    DefineProp('Width',tkInteger,__GetTScreenWidth,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TApplication) do
  begin
    DefineMethod('Create',1,tkClass,TApplication,__TApplicationCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TApplicationDestroy,false,0);
    DefineMethod('ActivateHint',1,tkNone,nil,__TApplicationActivateHint,false,0);
    DefineMethod('AddPopupForm',1,tkInteger,nil,__TApplicationAddPopupForm,false,0);
    DefineMethod('BringToFront',0,tkNone,nil,__TApplicationBringToFront,false,0);
    DefineMethod('ControlDestroyed',1,tkNone,nil,__TApplicationControlDestroyed,false,0);
    DefineMethod('CancelHint',0,tkNone,nil,__TApplicationCancelHint,false,0);
    DefineMethod('CreateHandle',0,tkNone,nil,__TApplicationCreateHandle,false,0);
    DefineMethod('DoApplicationIdle',0,tkNone,nil,__TApplicationDoApplicationIdle,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TApplicationExecuteAction,false,0);
    DefineMethod('HandleException',1,tkNone,nil,__TApplicationHandleException,false,0);
    DefineMethod('HandleMessage',0,tkNone,nil,__TApplicationHandleMessage,false,0);
    DefineMethod('HelpCommand',2,tkVariant,nil,__TApplicationHelpCommand,false,0);
    DefineMethod('HelpContext',1,tkVariant,nil,__TApplicationHelpContext,false,0);
    DefineMethod('HelpJump',1,tkVariant,nil,__TApplicationHelpJump,false,0);
    DefineMethod('HelpKeyword',1,tkVariant,nil,__TApplicationHelpKeyword,false,0);
    DefineMethod('HelpShowTableOfContents',0,tkVariant,nil,__TApplicationHelpShowTableOfContents,false,0);
    DefineMethod('HideHint',0,tkNone,nil,__TApplicationHideHint,false,0);
    DefineMethod('HintMouseMessage',2,tkNone,nil,__TApplicationHintMouseMessage,false,0).SetVarArgs([1]);
    DefineMethod('HookSynchronizeWakeup',0,tkNone,nil,__TApplicationHookSynchronizeWakeup,false,0);
    DefineMethod('Initialize',0,tkNone,nil,__TApplicationInitialize,false,0);
    DefineMethod('IsRightToLeft',0,tkVariant,nil,__TApplicationIsRightToLeft,false,0);
    DefineMethod('Minimize',0,tkNone,nil,__TApplicationMinimize,false,0);
    DefineMethod('ModalStarted',0,tkNone,nil,__TApplicationModalStarted,false,0);
    DefineMethod('ModalFinished',0,tkNone,nil,__TApplicationModalFinished,false,0);
    DefineMethod('NormalizeAllTopMosts',0,tkNone,nil,__TApplicationNormalizeAllTopMosts,false,0);
    DefineMethod('NormalizeTopMosts',0,tkNone,nil,__TApplicationNormalizeTopMosts,false,0);
    DefineMethod('ProcessMessages',0,tkNone,nil,__TApplicationProcessMessages,false,0);
    DefineMethod('RemovePopupForm',1,tkNone,nil,__TApplicationRemovePopupForm,false,0);
    DefineMethod('Restore',0,tkNone,nil,__TApplicationRestore,false,0);
    DefineMethod('RestoreTopMosts',0,tkNone,nil,__TApplicationRestoreTopMosts,false,0);
    DefineMethod('Run',0,tkNone,nil,__TApplicationRun,false,0);
    DefineMethod('ShowException',1,tkNone,nil,__TApplicationShowException,false,0);
    DefineMethod('Terminate',0,tkNone,nil,__TApplicationTerminate,false,0);
    DefineMethod('UnhookSynchronizeWakeup',0,tkNone,nil,__TApplicationUnhookSynchronizeWakeup,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TApplicationUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TApplicationUseRightToLeftAlignment,false,0);
    DefineMethod('UseRightToLeftReading',0,tkVariant,nil,__TApplicationUseRightToLeftReading,false,0);
    DefineMethod('UseRightToLeftScrollBar',0,tkVariant,nil,__TApplicationUseRightToLeftScrollBar,false,0);
    DefineMethod('MessageBox',3,tkInteger,nil,__TApplicationMessageBox,false,1);
    DefineProp('Active',tkVariant,__GetTApplicationActive,nil,nil,false,0);
    DefineProp('ActionUpdateDelay',tkInteger,__GetTApplicationActionUpdateDelay,__SetTApplicationActionUpdateDelay,nil,false,0);
    DefineProp('ActiveFormHandle',tkInteger,__GetTApplicationActiveFormHandle,nil,nil,false,0);
    DefineProp('AllowTesting',tkVariant,__GetTApplicationAllowTesting,__SetTApplicationAllowTesting,nil,false,0);
    DefineProp('AutoDragDocking',tkVariant,__GetTApplicationAutoDragDocking,__SetTApplicationAutoDragDocking,nil,false,0);
    DefineProp('CurrentHelpFile',tkVariant,__GetTApplicationCurrentHelpFile,nil,nil,false,0);
    DefineProp('DefaultFont',tkClass,__GetTApplicationDefaultFont,__SetTApplicationDefaultFont,TFont,false,0);
    DefineProp('DialogHandle',tkInteger,__GetTApplicationDialogHandle,__SetTApplicationDialogHandle,nil,false,0);
    DefineProp('EnumAllWindowsOnActivateHint',tkVariant,__GetTApplicationEnumAllWindowsOnActivateHint,__SetTApplicationEnumAllWindowsOnActivateHint,nil,false,0);
    DefineProp('ExeName',tkVariant,__GetTApplicationExeName,nil,nil,false,0);
    DefineProp('HelpFile',tkVariant,__GetTApplicationHelpFile,__SetTApplicationHelpFile,nil,false,0);
    DefineProp('Hint',tkVariant,__GetTApplicationHint,__SetTApplicationHint,nil,false,0);
    DefineProp('HintColor',tkEnumeration,__GetTApplicationHintColor,__SetTApplicationHintColor,nil,false,0);
    DefineProp('HintHidePause',tkInteger,__GetTApplicationHintHidePause,__SetTApplicationHintHidePause,nil,false,0);
    DefineProp('HintPause',tkInteger,__GetTApplicationHintPause,__SetTApplicationHintPause,nil,false,0);
    DefineProp('HintShortCuts',tkVariant,__GetTApplicationHintShortCuts,__SetTApplicationHintShortCuts,nil,false,0);
    DefineProp('HintShortPause',tkInteger,__GetTApplicationHintShortPause,__SetTApplicationHintShortPause,nil,false,0);
    DefineProp('Icon',tkClass,__GetTApplicationIcon,__SetTApplicationIcon,TIcon,false,0);
    DefineProp('MainForm',tkClass,__GetTApplicationMainForm,nil,TForm,false,0);
    DefineProp('MainFormHandle',tkInteger,__GetTApplicationMainFormHandle,nil,nil,false,0);
    DefineProp('MainFormOnTaskBar',tkVariant,__GetTApplicationMainFormOnTaskBar,__SetTApplicationMainFormOnTaskBar,nil,false,0);
    DefineProp('ModalLevel',tkInteger,__GetTApplicationModalLevel,nil,nil,false,0);
    DefineProp('ModalPopupMode',tkEnumeration,__GetTApplicationModalPopupMode,__SetTApplicationModalPopupMode,nil,false,0);
    DefineProp('BiDiMode',tkEnumeration,__GetTApplicationBiDiMode,__SetTApplicationBiDiMode,nil,false,0);
    DefineProp('BiDiKeyboard',tkVariant,__GetTApplicationBiDiKeyboard,__SetTApplicationBiDiKeyboard,nil,false,0);
    DefineProp('NonBiDiKeyboard',tkVariant,__GetTApplicationNonBiDiKeyboard,__SetTApplicationNonBiDiKeyboard,nil,false,0);
    DefineProp('ShowHint',tkVariant,__GetTApplicationShowHint,__SetTApplicationShowHint,nil,false,0);
    DefineProp('ShowMainForm',tkVariant,__GetTApplicationShowMainForm,__SetTApplicationShowMainForm,nil,false,0);
    DefineProp('Terminated',tkVariant,__GetTApplicationTerminated,nil,nil,false,0);
    DefineProp('Title',tkVariant,__GetTApplicationTitle,__SetTApplicationTitle,nil,false,0);
    DefineProp('UpdateFormatSettings',tkVariant,__GetTApplicationUpdateFormatSettings,__SetTApplicationUpdateFormatSettings,nil,false,0);
    DefineProp('UpdateMetricSettings',tkVariant,__GetTApplicationUpdateMetricSettings,__SetTApplicationUpdateMetricSettings,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTApplicationHandle,__SetTApplicationHandle,nil,false,0);
    DefineProp('PopupControlWnd',tkInteger,__GetTApplicationPopupControlWnd,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TCloseEvent), TatFormsDispatcher, @TatFormsDispatcher.__TCloseEvent);
  DefineEventAdapter(TypeInfo(TCloseQueryEvent), TatFormsDispatcher, @TatFormsDispatcher.__TCloseQueryEvent);
  DefineEventAdapter(TypeInfo(THelpEvent), TatFormsDispatcher, @TatFormsDispatcher.__THelpEvent);
  DefineEventAdapter(TypeInfo(TExceptionEvent), TatFormsDispatcher, @TatFormsDispatcher.__TExceptionEvent);
  DefineEventAdapter(TypeInfo(TGetHandleEvent), TatFormsDispatcher, @TatFormsDispatcher.__TGetHandleEvent);
  DefineEventAdapter(TypeInfo(TIdleEvent), TatFormsDispatcher, @TatFormsDispatcher.__TIdleEvent);
  DefineEventAdapter(TypeInfo(TSettingChangeEvent), TatFormsDispatcher, @TatFormsDispatcher.__TSettingChangeEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetParentForm',2,tkClass,TCustomForm,__GetParentForm,false,1);
    DefineMethod('ValidParentForm',2,tkClass,TCustomForm,__ValidParentForm,false,1);
    DefineMethod('IsAccel',2,tkVariant,nil,__IsAccel,false,0);
    DefineMethod('KeysToShiftState',1,tkInteger,nil,__KeysToShiftState,false,0);
    DefineMethod('KeyDataToShiftState',1,tkInteger,nil,__KeyDataToShiftState,false,0);
    DefineMethod('KeyboardStateToShiftState',0,tkInteger,nil,__KeyboardStateToShiftState,false,0);
    DefineMethod('ForegroundTask',0,tkVariant,nil,__ForegroundTask,false,0);
    DefineProp('Application',tkClass,__GetApplication,__SetApplication,TApplication,false,0);
    DefineProp('Screen',tkClass,__GetScreen,__SetScreen,TScreen,false,0);
    AddConstant('sbHorizontal',sbHorizontal);
    AddConstant('sbVertical',sbVertical);
    AddConstant('ssRegular',ssRegular);
    AddConstant('ssFlat',ssFlat);
    AddConstant('ssHotTrack',ssHotTrack);
    AddConstant('wsNormal',wsNormal);
    AddConstant('wsMinimized',wsMinimized);
    AddConstant('wsMaximized',wsMaximized);
    AddConstant('bsNone',bsNone);
    AddConstant('bsSingle',bsSingle);
    AddConstant('bsSizeable',bsSizeable);
    AddConstant('bsDialog',bsDialog);
    AddConstant('bsToolWindow',bsToolWindow);
    AddConstant('bsSizeToolWin',bsSizeToolWin);
    AddConstant('fsNormal',fsNormal);
    AddConstant('fsMDIChild',fsMDIChild);
    AddConstant('fsMDIForm',fsMDIForm);
    AddConstant('fsStayOnTop',fsStayOnTop);
    AddConstant('biSystemMenu',biSystemMenu);
    AddConstant('biMinimize',biMinimize);
    AddConstant('biMaximize',biMaximize);
    AddConstant('biHelp',biHelp);
    AddConstant('poDesigned',poDesigned);
    AddConstant('poDefault',poDefault);
    AddConstant('poDefaultPosOnly',poDefaultPosOnly);
    AddConstant('poDefaultSizeOnly',poDefaultSizeOnly);
    AddConstant('poScreenCenter',poScreenCenter);
    AddConstant('poDesktopCenter',poDesktopCenter);
    AddConstant('poMainFormCenter',poMainFormCenter);
    AddConstant('poOwnerFormCenter',poOwnerFormCenter);
    AddConstant('dmDesktop',dmDesktop);
    AddConstant('dmPrimary',dmPrimary);
    AddConstant('dmMainForm',dmMainForm);
    AddConstant('dmActiveForm',dmActiveForm);
    AddConstant('poNone',poNone);
    AddConstant('poProportional',poProportional);
    AddConstant('poPrintToFit',poPrintToFit);
    AddConstant('saIgnore',saIgnore);
    AddConstant('saRestore',saRestore);
    AddConstant('saMinimize',saMinimize);
    AddConstant('saMaximize',saMaximize);
    AddConstant('tbHorizontal',tbHorizontal);
    AddConstant('tbVertical',tbVertical);
    AddConstant('caNone',caNone);
    AddConstant('caHide',caHide);
    AddConstant('caFree',caFree);
    AddConstant('caMinimize',caMinimize);
    AddConstant('pmNone',pmNone);
    AddConstant('pmAuto',pmAuto);
    AddConstant('pmExplicit',pmExplicit);
    AddConstant('afbNone',afbNone);
    AddConstant('afbSingle',afbSingle);
    AddConstant('afbSunken',afbSunken);
    AddConstant('afbRaised',afbRaised);
    AddConstant('mdNearest',mdNearest);
    AddConstant('mdNull',mdNull);
    AddConstant('mdPrimary',mdPrimary);
    AddConstant('tmShow',tmShow);
    AddConstant('tmHide',tmHide);
  end;
end;

class function TatFormsLibrary.LibraryName: string;
begin
  result := 'Forms';
end;

initialization
  RegisterScripterLibrary(TatFormsLibrary, True);

{$WARNINGS ON}

end.

