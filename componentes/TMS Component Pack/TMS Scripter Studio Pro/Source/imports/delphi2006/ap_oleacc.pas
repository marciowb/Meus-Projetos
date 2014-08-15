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
unit ap_oleacc;

interface

uses
  Windows,
  ActiveX,
  oleacc,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatoleaccLibrary = class(TatScripterLibrary)
    procedure __ObjectFromLresult(AMachine: TatVirtualMachine);
    procedure __AccessibleObjectFromWindow(AMachine: TatVirtualMachine);
    procedure __CreateStdAccessibleProxy(AMachine: TatVirtualMachine);
    procedure __GetLIBID_Accessibility(AMachine: TatVirtualMachine);
    procedure __GetIID_IAccessible(AMachine: TatVirtualMachine);
    procedure __GetIID_IAccessibleHandler(AMachine: TatVirtualMachine);
    procedure __GetIID_IAccIdentity(AMachine: TatVirtualMachine);
    procedure __GetIID_IAccPropServer(AMachine: TatVirtualMachine);
    procedure __GetIID_IAccPropServices(AMachine: TatVirtualMachine);
    procedure __GetCLASS_CAccPropServices(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  CoCAccPropServicesClass = class of CoCAccPropServices;


  __MIDL_IWinTypes_0009Wrapper = class(TatRecordWrapper)
  private
    FhInproc: Integer;
    FhRemote: Integer;
  public
    constructor Create(ARecord: __MIDL_IWinTypes_0009);
    function ObjToRec: __MIDL_IWinTypes_0009;
  published
    property hInproc: Integer read FhInproc write FhInproc;
    property hRemote: Integer read FhRemote write FhRemote;
  end;
  
  _RemotableHandleWrapper = class(TatRecordWrapper)
  private
    FfContext: Integer;
  public
    constructor Create(ARecord: _RemotableHandle);
    function ObjToRec: _RemotableHandle;
  published
    property fContext: Integer read FfContext write FfContext;
  end;
  

implementation

constructor __MIDL_IWinTypes_0009Wrapper.Create(ARecord: __MIDL_IWinTypes_0009);
begin
  inherited Create;
  FhInproc := ARecord.hInproc;
  FhRemote := ARecord.hRemote;
end;

function __MIDL_IWinTypes_0009Wrapper.ObjToRec: __MIDL_IWinTypes_0009;
begin
  result.hInproc := FhInproc;
  result.hRemote := FhRemote;
end;

constructor _RemotableHandleWrapper.Create(ARecord: _RemotableHandle);
begin
  inherited Create;
  FfContext := ARecord.fContext;
end;

function _RemotableHandleWrapper.ObjToRec: _RemotableHandle;
begin
  result.fContext := FfContext;
end;



procedure TatoleaccLibrary.__ObjectFromLresult(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(oleacc.ObjectFromLresult(VarToInteger(GetInputArg(0)),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatoleaccLibrary.__AccessibleObjectFromWindow(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(oleacc.AccessibleObjectFromWindow(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),TGUIDWrapper(integer(GetInputArg(2))).ObjToRec,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatoleaccLibrary.__CreateStdAccessibleProxy(AMachine: TatVirtualMachine);
  var
  Param4: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := Integer(oleacc.CreateStdAccessibleProxy(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),TGUIDWrapper(integer(GetInputArg(3))).ObjToRec,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatoleaccLibrary.__GetLIBID_Accessibility(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(oleacc.LIBID_Accessibility)));
  end;
end;

procedure TatoleaccLibrary.__GetIID_IAccessible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(oleacc.IID_IAccessible)));
  end;
end;

procedure TatoleaccLibrary.__GetIID_IAccessibleHandler(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(oleacc.IID_IAccessibleHandler)));
  end;
end;

procedure TatoleaccLibrary.__GetIID_IAccIdentity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(oleacc.IID_IAccIdentity)));
  end;
end;

procedure TatoleaccLibrary.__GetIID_IAccPropServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(oleacc.IID_IAccPropServer)));
  end;
end;

procedure TatoleaccLibrary.__GetIID_IAccPropServices(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(oleacc.IID_IAccPropServices)));
  end;
end;

procedure TatoleaccLibrary.__GetCLASS_CAccPropServices(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(oleacc.CLASS_CAccPropServices)));
  end;
end;

procedure TatoleaccLibrary.Init;
begin
  With Scripter.DefineClass(CoCAccPropServices) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ObjectFromLresult',4,tkInteger,nil,__ObjectFromLresult,false,0).SetVarArgs([3]);
    DefineMethod('AccessibleObjectFromWindow',4,tkInteger,nil,__AccessibleObjectFromWindow,false,0).SetVarArgs([3]);
    DefineMethod('CreateStdAccessibleProxy',5,tkInteger,nil,__CreateStdAccessibleProxy,false,0).SetVarArgs([4]);
    DefineProp('LIBID_Accessibility',tkVariant,__GetLIBID_Accessibility,nil,nil,false,0);
    DefineProp('IID_IAccessible',tkVariant,__GetIID_IAccessible,nil,nil,false,0);
    DefineProp('IID_IAccessibleHandler',tkVariant,__GetIID_IAccessibleHandler,nil,nil,false,0);
    DefineProp('IID_IAccIdentity',tkVariant,__GetIID_IAccIdentity,nil,nil,false,0);
    DefineProp('IID_IAccPropServer',tkVariant,__GetIID_IAccPropServer,nil,nil,false,0);
    DefineProp('IID_IAccPropServices',tkVariant,__GetIID_IAccPropServices,nil,nil,false,0);
    DefineProp('CLASS_CAccPropServices',tkVariant,__GetCLASS_CAccPropServices,nil,nil,false,0);
    AddConstant('AccessibilityMajorVersion',AccessibilityMajorVersion);
    AddConstant('AccessibilityMinorVersion',AccessibilityMinorVersion);
    AddConstant('ANNO_THIS',ANNO_THIS);
    AddConstant('ANNO_CONTAINER',ANNO_CONTAINER);
    AddConstant('DISPID_ACC_PARENT',DISPID_ACC_PARENT);
    AddConstant('DISPID_ACC_CHILDCOUNT',DISPID_ACC_CHILDCOUNT);
    AddConstant('DISPID_ACC_CHILD',DISPID_ACC_CHILD);
    AddConstant('DISPID_ACC_NAME',DISPID_ACC_NAME);
    AddConstant('DISPID_ACC_VALUE',DISPID_ACC_VALUE);
    AddConstant('DISPID_ACC_DESCRIPTION',DISPID_ACC_DESCRIPTION);
    AddConstant('DISPID_ACC_ROLE',DISPID_ACC_ROLE);
    AddConstant('DISPID_ACC_STATE',DISPID_ACC_STATE);
    AddConstant('DISPID_ACC_HELP',DISPID_ACC_HELP);
    AddConstant('DISPID_ACC_HELPTOPIC',DISPID_ACC_HELPTOPIC);
    AddConstant('DISPID_ACC_KEYBOARDSHORTCUT',DISPID_ACC_KEYBOARDSHORTCUT);
    AddConstant('DISPID_ACC_FOCUS',DISPID_ACC_FOCUS);
    AddConstant('DISPID_ACC_SELECTION',DISPID_ACC_SELECTION);
    AddConstant('DISPID_ACC_DEFAULTACTION',DISPID_ACC_DEFAULTACTION);
    AddConstant('DISPID_ACC_SELECT',DISPID_ACC_SELECT);
    AddConstant('DISPID_ACC_LOCATION',DISPID_ACC_LOCATION);
    AddConstant('DISPID_ACC_NAVIGATE',DISPID_ACC_NAVIGATE);
    AddConstant('DISPID_ACC_HITTEST',DISPID_ACC_HITTEST);
    AddConstant('DISPID_ACC_DODEFAULTACTION',DISPID_ACC_DODEFAULTACTION);
    AddConstant('NAVDIR_MIN',NAVDIR_MIN);
    AddConstant('NAVDIR_UP',NAVDIR_UP);
    AddConstant('NAVDIR_DOWN',NAVDIR_DOWN);
    AddConstant('NAVDIR_LEFT',NAVDIR_LEFT);
    AddConstant('NAVDIR_RIGHT',NAVDIR_RIGHT);
    AddConstant('NAVDIR_NEXT',NAVDIR_NEXT);
    AddConstant('NAVDIR_PREVIOUS',NAVDIR_PREVIOUS);
    AddConstant('NAVDIR_FIRSTCHILD',NAVDIR_FIRSTCHILD);
    AddConstant('NAVDIR_LASTCHILD',NAVDIR_LASTCHILD);
    AddConstant('NAVDIR_MAX',NAVDIR_MAX);
    AddConstant('SELFLAG_NONE',SELFLAG_NONE);
    AddConstant('SELFLAG_TAKEFOCUS',SELFLAG_TAKEFOCUS);
    AddConstant('SELFLAG_TAKESELECTION',SELFLAG_TAKESELECTION);
    AddConstant('SELFLAG_EXTENDSELECTION',SELFLAG_EXTENDSELECTION);
    AddConstant('SELFLAG_ADDSELECTION',SELFLAG_ADDSELECTION);
    AddConstant('SELFLAG_REMOVESELECTION',SELFLAG_REMOVESELECTION);
    AddConstant('SELFLAG_VALID',SELFLAG_VALID);
    AddConstant('STATE_SYSTEM_NORMAL',STATE_SYSTEM_NORMAL);
    AddConstant('STATE_SYSTEM_UNAVAILABLE',STATE_SYSTEM_UNAVAILABLE);
    AddConstant('STATE_SYSTEM_SELECTED',STATE_SYSTEM_SELECTED);
    AddConstant('STATE_SYSTEM_FOCUSED',STATE_SYSTEM_FOCUSED);
    AddConstant('STATE_SYSTEM_PRESSED',STATE_SYSTEM_PRESSED);
    AddConstant('STATE_SYSTEM_CHECKED',STATE_SYSTEM_CHECKED);
    AddConstant('STATE_SYSTEM_MIXED',STATE_SYSTEM_MIXED);
    AddConstant('STATE_SYSTEM_INDETERMINATE',STATE_SYSTEM_INDETERMINATE);
    AddConstant('STATE_SYSTEM_READONLY',STATE_SYSTEM_READONLY);
    AddConstant('STATE_SYSTEM_HOTTRACKED',STATE_SYSTEM_HOTTRACKED);
    AddConstant('STATE_SYSTEM_DEFAULT',STATE_SYSTEM_DEFAULT);
    AddConstant('STATE_SYSTEM_EXPANDED',STATE_SYSTEM_EXPANDED);
    AddConstant('STATE_SYSTEM_COLLAPSED',STATE_SYSTEM_COLLAPSED);
    AddConstant('STATE_SYSTEM_BUSY',STATE_SYSTEM_BUSY);
    AddConstant('STATE_SYSTEM_FLOATING',STATE_SYSTEM_FLOATING);
    AddConstant('STATE_SYSTEM_MARQUEED',STATE_SYSTEM_MARQUEED);
    AddConstant('STATE_SYSTEM_ANIMATED',STATE_SYSTEM_ANIMATED);
    AddConstant('STATE_SYSTEM_INVISIBLE',STATE_SYSTEM_INVISIBLE);
    AddConstant('STATE_SYSTEM_OFFSCREEN',STATE_SYSTEM_OFFSCREEN);
    AddConstant('STATE_SYSTEM_SIZEABLE',STATE_SYSTEM_SIZEABLE);
    AddConstant('STATE_SYSTEM_MOVEABLE',STATE_SYSTEM_MOVEABLE);
    AddConstant('STATE_SYSTEM_SELFVOICING',STATE_SYSTEM_SELFVOICING);
    AddConstant('STATE_SYSTEM_FOCUSABLE',STATE_SYSTEM_FOCUSABLE);
    AddConstant('STATE_SYSTEM_SELECTABLE',STATE_SYSTEM_SELECTABLE);
    AddConstant('STATE_SYSTEM_LINKED',STATE_SYSTEM_LINKED);
    AddConstant('STATE_SYSTEM_TRAVERSED',STATE_SYSTEM_TRAVERSED);
    AddConstant('STATE_SYSTEM_MULTISELECTABLE',STATE_SYSTEM_MULTISELECTABLE);
    AddConstant('STATE_SYSTEM_EXTSELECTABLE',STATE_SYSTEM_EXTSELECTABLE);
    AddConstant('STATE_SYSTEM_ALERT_LOW',STATE_SYSTEM_ALERT_LOW);
    AddConstant('STATE_SYSTEM_ALERT_MEDIUM',STATE_SYSTEM_ALERT_MEDIUM);
    AddConstant('STATE_SYSTEM_ALERT_HIGH',STATE_SYSTEM_ALERT_HIGH);
    AddConstant('STATE_SYSTEM_PROTECTED',STATE_SYSTEM_PROTECTED);
    AddConstant('STATE_SYSTEM_HASPOPUP',STATE_SYSTEM_HASPOPUP);
    AddConstant('STATE_SYSTEM_VALID',STATE_SYSTEM_VALID);
    AddConstant('ROLE_SYSTEM_TITLEBAR',ROLE_SYSTEM_TITLEBAR);
    AddConstant('ROLE_SYSTEM_MENUBAR',ROLE_SYSTEM_MENUBAR);
    AddConstant('ROLE_SYSTEM_SCROLLBAR',ROLE_SYSTEM_SCROLLBAR);
    AddConstant('ROLE_SYSTEM_GRIP',ROLE_SYSTEM_GRIP);
    AddConstant('ROLE_SYSTEM_SOUND',ROLE_SYSTEM_SOUND);
    AddConstant('ROLE_SYSTEM_CURSOR',ROLE_SYSTEM_CURSOR);
    AddConstant('ROLE_SYSTEM_CARET',ROLE_SYSTEM_CARET);
    AddConstant('ROLE_SYSTEM_ALERT',ROLE_SYSTEM_ALERT);
    AddConstant('ROLE_SYSTEM_WINDOW',ROLE_SYSTEM_WINDOW);
    AddConstant('ROLE_SYSTEM_CLIENT',ROLE_SYSTEM_CLIENT);
    AddConstant('ROLE_SYSTEM_MENUPOPUP',ROLE_SYSTEM_MENUPOPUP);
    AddConstant('ROLE_SYSTEM_MENUITEM',ROLE_SYSTEM_MENUITEM);
    AddConstant('ROLE_SYSTEM_TOOLTIP',ROLE_SYSTEM_TOOLTIP);
    AddConstant('ROLE_SYSTEM_APPLICATION',ROLE_SYSTEM_APPLICATION);
    AddConstant('ROLE_SYSTEM_DOCUMENT',ROLE_SYSTEM_DOCUMENT);
    AddConstant('ROLE_SYSTEM_PANE',ROLE_SYSTEM_PANE);
    AddConstant('ROLE_SYSTEM_CHART',ROLE_SYSTEM_CHART);
    AddConstant('ROLE_SYSTEM_DIALOG',ROLE_SYSTEM_DIALOG);
    AddConstant('ROLE_SYSTEM_BORDER',ROLE_SYSTEM_BORDER);
    AddConstant('ROLE_SYSTEM_GROUPING',ROLE_SYSTEM_GROUPING);
    AddConstant('ROLE_SYSTEM_SEPARATOR',ROLE_SYSTEM_SEPARATOR);
    AddConstant('ROLE_SYSTEM_TOOLBAR',ROLE_SYSTEM_TOOLBAR);
    AddConstant('ROLE_SYSTEM_STATUSBAR',ROLE_SYSTEM_STATUSBAR);
    AddConstant('ROLE_SYSTEM_TABLE',ROLE_SYSTEM_TABLE);
    AddConstant('ROLE_SYSTEM_COLUMNHEADER',ROLE_SYSTEM_COLUMNHEADER);
    AddConstant('ROLE_SYSTEM_ROWHEADER',ROLE_SYSTEM_ROWHEADER);
    AddConstant('ROLE_SYSTEM_COLUMN',ROLE_SYSTEM_COLUMN);
    AddConstant('ROLE_SYSTEM_ROW',ROLE_SYSTEM_ROW);
    AddConstant('ROLE_SYSTEM_CELL',ROLE_SYSTEM_CELL);
    AddConstant('ROLE_SYSTEM_LINK',ROLE_SYSTEM_LINK);
    AddConstant('ROLE_SYSTEM_HELPBALLOON',ROLE_SYSTEM_HELPBALLOON);
    AddConstant('ROLE_SYSTEM_CHARACTER',ROLE_SYSTEM_CHARACTER);
    AddConstant('ROLE_SYSTEM_LIST',ROLE_SYSTEM_LIST);
    AddConstant('ROLE_SYSTEM_LISTITEM',ROLE_SYSTEM_LISTITEM);
    AddConstant('ROLE_SYSTEM_OUTLINE',ROLE_SYSTEM_OUTLINE);
    AddConstant('ROLE_SYSTEM_OUTLINEITEM',ROLE_SYSTEM_OUTLINEITEM);
    AddConstant('ROLE_SYSTEM_PAGETAB',ROLE_SYSTEM_PAGETAB);
    AddConstant('ROLE_SYSTEM_PROPERTYPAGE',ROLE_SYSTEM_PROPERTYPAGE);
    AddConstant('ROLE_SYSTEM_INDICATOR',ROLE_SYSTEM_INDICATOR);
    AddConstant('ROLE_SYSTEM_GRAPHIC',ROLE_SYSTEM_GRAPHIC);
    AddConstant('ROLE_SYSTEM_STATICTEXT',ROLE_SYSTEM_STATICTEXT);
    AddConstant('ROLE_SYSTEM_TEXT',ROLE_SYSTEM_TEXT);
    AddConstant('ROLE_SYSTEM_PUSHBUTTON',ROLE_SYSTEM_PUSHBUTTON);
    AddConstant('ROLE_SYSTEM_CHECKBUTTON',ROLE_SYSTEM_CHECKBUTTON);
    AddConstant('ROLE_SYSTEM_RADIOBUTTON',ROLE_SYSTEM_RADIOBUTTON);
    AddConstant('ROLE_SYSTEM_COMBOBOX',ROLE_SYSTEM_COMBOBOX);
    AddConstant('ROLE_SYSTEM_DROPLIST',ROLE_SYSTEM_DROPLIST);
    AddConstant('ROLE_SYSTEM_PROGRESSBAR',ROLE_SYSTEM_PROGRESSBAR);
    AddConstant('ROLE_SYSTEM_DIAL',ROLE_SYSTEM_DIAL);
    AddConstant('ROLE_SYSTEM_HOTKEYFIELD',ROLE_SYSTEM_HOTKEYFIELD);
    AddConstant('ROLE_SYSTEM_SLIDER',ROLE_SYSTEM_SLIDER);
    AddConstant('ROLE_SYSTEM_SPINBUTTON',ROLE_SYSTEM_SPINBUTTON);
    AddConstant('ROLE_SYSTEM_DIAGRAM',ROLE_SYSTEM_DIAGRAM);
    AddConstant('ROLE_SYSTEM_ANIMATION',ROLE_SYSTEM_ANIMATION);
    AddConstant('ROLE_SYSTEM_EQUATION',ROLE_SYSTEM_EQUATION);
    AddConstant('ROLE_SYSTEM_BUTTONDROPDOWN',ROLE_SYSTEM_BUTTONDROPDOWN);
    AddConstant('ROLE_SYSTEM_BUTTONMENU',ROLE_SYSTEM_BUTTONMENU);
    AddConstant('ROLE_SYSTEM_BUTTONDROPDOWNGRID',ROLE_SYSTEM_BUTTONDROPDOWNGRID);
    AddConstant('ROLE_SYSTEM_WHITESPACE',ROLE_SYSTEM_WHITESPACE);
    AddConstant('ROLE_SYSTEM_PAGETABLIST',ROLE_SYSTEM_PAGETABLIST);
    AddConstant('ROLE_SYSTEM_CLOCK',ROLE_SYSTEM_CLOCK);
    AddConstant('CHILDID_SELF',CHILDID_SELF);
  end;
end;

class function TatoleaccLibrary.LibraryName: string;
begin
  result := 'oleacc';
end;

initialization
  RegisterScripterLibrary(TatoleaccLibrary, True);

{$WARNINGS ON}

end.

