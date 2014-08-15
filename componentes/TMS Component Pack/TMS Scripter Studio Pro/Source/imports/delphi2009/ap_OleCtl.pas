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
unit ap_OleCtl;

interface

uses
  Windows,
  Messages,
  Ole2,
  OleCtl,
  Variants,
  ap_Types,
  ap_Ole2,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatOleCtlLibrary = class(TatScripterLibrary)
    procedure __IOleControlGetControlInfo(AMachine: TatVirtualMachine);
    procedure __IOleControlOnAmbientPropertyChange(AMachine: TatVirtualMachine);
    procedure __IOleControlFreezeEvents(AMachine: TatVirtualMachine);
    procedure __IOleControlSiteOnControlInfoChanged(AMachine: TatVirtualMachine);
    procedure __IOleControlSiteLockInPlaceActive(AMachine: TatVirtualMachine);
    procedure __IOleControlSiteGetExtendedControl(AMachine: TatVirtualMachine);
    procedure __IOleControlSiteTransformCoords(AMachine: TatVirtualMachine);
    procedure __IOleControlSiteOnFocus(AMachine: TatVirtualMachine);
    procedure __IOleControlSiteShowPropertyFrame(AMachine: TatVirtualMachine);
    procedure __ISimpleFrameSitePreMessageFilter(AMachine: TatVirtualMachine);
    procedure __ISimpleFrameSitePostMessageFilter(AMachine: TatVirtualMachine);
    procedure __IPersistStreamInitIsDirty(AMachine: TatVirtualMachine);
    procedure __IPersistStreamInitLoad(AMachine: TatVirtualMachine);
    procedure __IPersistStreamInitSave(AMachine: TatVirtualMachine);
    procedure __IPersistStreamInitGetSizeMax(AMachine: TatVirtualMachine);
    procedure __IPersistStreamInitInitNew(AMachine: TatVirtualMachine);
    procedure __IPropertyNotifySinkOnChanged(AMachine: TatVirtualMachine);
    procedure __IPropertyNotifySinkOnRequestEdit(AMachine: TatVirtualMachine);
    procedure __IProvideClassInfoGetClassInfo(AMachine: TatVirtualMachine);
    procedure __IConnectionPointContainerEnumConnectionPoints(AMachine: TatVirtualMachine);
    procedure __IConnectionPointContainerFindConnectionPoint(AMachine: TatVirtualMachine);
    procedure __IEnumConnectionPointsSkip(AMachine: TatVirtualMachine);
    procedure __IEnumConnectionPointsReset(AMachine: TatVirtualMachine);
    procedure __IEnumConnectionPointsClone(AMachine: TatVirtualMachine);
    procedure __IConnectionPointGetConnectionInterface(AMachine: TatVirtualMachine);
    procedure __IConnectionPointGetConnectionPointContainer(AMachine: TatVirtualMachine);
    procedure __IConnectionPointAdvise(AMachine: TatVirtualMachine);
    procedure __IConnectionPointUnadvise(AMachine: TatVirtualMachine);
    procedure __IConnectionPointEnumConnections(AMachine: TatVirtualMachine);
    procedure __IEnumConnectionsSkip(AMachine: TatVirtualMachine);
    procedure __IEnumConnectionsReset(AMachine: TatVirtualMachine);
    procedure __IEnumConnectionsClone(AMachine: TatVirtualMachine);
    procedure __IClassFactory2GetLicInfo(AMachine: TatVirtualMachine);
    procedure __IClassFactory2RequestLicKey(AMachine: TatVirtualMachine);
    procedure __IClassFactory2CreateInstanceLic(AMachine: TatVirtualMachine);
    procedure __ISpecifyPropertyPagesGetPages(AMachine: TatVirtualMachine);
    procedure __IPerPropertyBrowsingGetDisplayString(AMachine: TatVirtualMachine);
    procedure __IPerPropertyBrowsingMapPropertyToPage(AMachine: TatVirtualMachine);
    procedure __IPerPropertyBrowsingGetPredefinedStrings(AMachine: TatVirtualMachine);
    procedure __IPerPropertyBrowsingGetPredefinedValue(AMachine: TatVirtualMachine);
    procedure __IPropertyPageSiteOnStatusChange(AMachine: TatVirtualMachine);
    procedure __IPropertyPageSiteGetLocaleID(AMachine: TatVirtualMachine);
    procedure __IPropertyPageSiteGetPageContainer(AMachine: TatVirtualMachine);
    procedure __IPropertyPageSetPageSite(AMachine: TatVirtualMachine);
    procedure __IPropertyPageActivate(AMachine: TatVirtualMachine);
    procedure __IPropertyPageDeactivate(AMachine: TatVirtualMachine);
    procedure __IPropertyPageGetPageInfo(AMachine: TatVirtualMachine);
    procedure __IPropertyPageSetObjects(AMachine: TatVirtualMachine);
    procedure __IPropertyPageShow(AMachine: TatVirtualMachine);
    procedure __IPropertyPageMove(AMachine: TatVirtualMachine);
    procedure __IPropertyPageIsPageDirty(AMachine: TatVirtualMachine);
    procedure __IPropertyPageApply(AMachine: TatVirtualMachine);
    procedure __IPropertyPageHelp(AMachine: TatVirtualMachine);
    procedure __IPropertyPage2EditProperty(AMachine: TatVirtualMachine);
    procedure __IFontget_Name(AMachine: TatVirtualMachine);
    procedure __IFontput_Name(AMachine: TatVirtualMachine);
    procedure __IFontget_Size(AMachine: TatVirtualMachine);
    procedure __IFontput_Size(AMachine: TatVirtualMachine);
    procedure __IFontget_Bold(AMachine: TatVirtualMachine);
    procedure __IFontput_Bold(AMachine: TatVirtualMachine);
    procedure __IFontget_Italic(AMachine: TatVirtualMachine);
    procedure __IFontput_Italic(AMachine: TatVirtualMachine);
    procedure __IFontget_Underline(AMachine: TatVirtualMachine);
    procedure __IFontput_Underline(AMachine: TatVirtualMachine);
    procedure __IFontget_Strikethrough(AMachine: TatVirtualMachine);
    procedure __IFontput_Strikethrough(AMachine: TatVirtualMachine);
    procedure __IFontget_Weight(AMachine: TatVirtualMachine);
    procedure __IFontput_Weight(AMachine: TatVirtualMachine);
    procedure __IFontget_Charset(AMachine: TatVirtualMachine);
    procedure __IFontput_Charset(AMachine: TatVirtualMachine);
    procedure __IFontget_hFont(AMachine: TatVirtualMachine);
    procedure __IFontClone(AMachine: TatVirtualMachine);
    procedure __IFontIsEqual(AMachine: TatVirtualMachine);
    procedure __IFontSetRatio(AMachine: TatVirtualMachine);
    procedure __IFontQueryTextMetrics(AMachine: TatVirtualMachine);
    procedure __IFontAddRefHfont(AMachine: TatVirtualMachine);
    procedure __IFontReleaseHfont(AMachine: TatVirtualMachine);
    procedure __IPictureget_Handle(AMachine: TatVirtualMachine);
    procedure __IPictureget_hPal(AMachine: TatVirtualMachine);
    procedure __IPictureget_Type(AMachine: TatVirtualMachine);
    procedure __IPictureget_Width(AMachine: TatVirtualMachine);
    procedure __IPictureget_Height(AMachine: TatVirtualMachine);
    procedure __IPictureRender(AMachine: TatVirtualMachine);
    procedure __IPictureset_hPal(AMachine: TatVirtualMachine);
    procedure __IPictureget_CurDC(AMachine: TatVirtualMachine);
    procedure __IPictureSelectPicture(AMachine: TatVirtualMachine);
    procedure __IPictureget_KeepOriginalFormat(AMachine: TatVirtualMachine);
    procedure __IPictureput_KeepOriginalFormat(AMachine: TatVirtualMachine);
    procedure __IPicturePictureChanged(AMachine: TatVirtualMachine);
    procedure __IPictureSaveAsFile(AMachine: TatVirtualMachine);
    procedure __IPictureget_Attributes(AMachine: TatVirtualMachine);
    procedure __OleCreatePropertyFrameIndirect(AMachine: TatVirtualMachine);
    procedure __OleTranslateColor(AMachine: TatVirtualMachine);
    procedure __OleCreateFontIndirect(AMachine: TatVirtualMachine);
    procedure __OleCreatePictureIndirect(AMachine: TatVirtualMachine);
    procedure __OleLoadPicture(AMachine: TatVirtualMachine);
    procedure __OleIconToCursor(AMachine: TatVirtualMachine);
    procedure __GetIID_IPropertyNotifySink(AMachine: TatVirtualMachine);
    procedure __GetIID_IClassFactory2(AMachine: TatVirtualMachine);
    procedure __GetIID_IProvideClassInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IConnectionPointContainer(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumConnectionPoints(AMachine: TatVirtualMachine);
    procedure __GetIID_IConnectionPoint(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumConnections(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleControl(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleControlSite(AMachine: TatVirtualMachine);
    procedure __GetIID_ISimpleFrameSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistStreamInit(AMachine: TatVirtualMachine);
    procedure __GetIID_IPropertyFrame(AMachine: TatVirtualMachine);
    procedure __GetIID_ISpecifyPropertyPages(AMachine: TatVirtualMachine);
    procedure __GetIID_IPerPropertyBrowsing(AMachine: TatVirtualMachine);
    procedure __GetIID_IPropertyPageSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IPropertyPage(AMachine: TatVirtualMachine);
    procedure __GetIID_IPropertyPage2(AMachine: TatVirtualMachine);
    procedure __GetIID_IFont(AMachine: TatVirtualMachine);
    procedure __GetIID_IFontDisp(AMachine: TatVirtualMachine);
    procedure __GetIID_IPicture(AMachine: TatVirtualMachine);
    procedure __GetIID_IPictureDisp(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CFontPropPage(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CColorPropPage(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CPicturePropPage(AMachine: TatVirtualMachine);
    procedure __GetCLSID_PersistPropset(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ConvertVBX(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StdFont(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StdPicture(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  IOleControlClass = class of IOleControl;
  IOleControlSiteClass = class of IOleControlSite;
  ISimpleFrameSiteClass = class of ISimpleFrameSite;
  IPersistStreamInitClass = class of IPersistStreamInit;
  IPropertyNotifySinkClass = class of IPropertyNotifySink;
  IProvideClassInfoClass = class of IProvideClassInfo;
  IConnectionPointContainerClass = class of IConnectionPointContainer;
  IEnumConnectionPointsClass = class of IEnumConnectionPoints;
  IConnectionPointClass = class of IConnectionPoint;
  IEnumConnectionsClass = class of IEnumConnections;
  IClassFactory2Class = class of IClassFactory2;
  ISpecifyPropertyPagesClass = class of ISpecifyPropertyPages;
  IPerPropertyBrowsingClass = class of IPerPropertyBrowsing;
  IPropertyPageSiteClass = class of IPropertyPageSite;
  IPropertyPageClass = class of IPropertyPage;
  IPropertyPage2Class = class of IPropertyPage2;
  IFontClass = class of IFont;
  IFontDispClass = class of IFontDisp;
  IPictureClass = class of IPicture;
  IPictureDispClass = class of IPictureDisp;


  tagPOINTFXWrapper = class(TatRecordWrapper)
  private
    Fx: Single;
    Fy: Single;
  public
    constructor Create(ARecord: tagPOINTFX);
    function ObjToRec: tagPOINTFX;
  published
    property x: Single read Fx write Fx;
    property y: Single read Fy write Fy;
  end;
  
  tagCONTROLINFOWrapper = class(TatRecordWrapper)
  private
    Fcb: Longint;
    FhAccel: HAccel;
    FcAccel: Word;
    FdwFlags: Longint;
  public
    constructor Create(ARecord: tagCONTROLINFO);
    function ObjToRec: tagCONTROLINFO;
  published
    property cb: Longint read Fcb write Fcb;
    property hAccel: HAccel read FhAccel write FhAccel;
    property cAccel: Word read FcAccel write FcAccel;
    property dwFlags: Longint read FdwFlags write FdwFlags;
  end;
  
  tagCONNECTDATAWrapper = class(TatRecordWrapper)
  private
    FpUnk: IUnknown;
    FdwCookie: Longint;
  public
    constructor Create(ARecord: tagCONNECTDATA);
    function ObjToRec: tagCONNECTDATA;
  published
    property pUnk: IUnknown read FpUnk write FpUnk;
    property dwCookie: Longint read FdwCookie write FdwCookie;
  end;
  
  tagLICINFOWrapper = class(TatRecordWrapper)
  private
    FcbLicInfo: Longint;
    FfRuntimeKeyAvail: BOOL;
    FfLicVerified: BOOL;
  public
    constructor Create(ARecord: tagLICINFO);
    function ObjToRec: tagLICINFO;
  published
    property cbLicInfo: Longint read FcbLicInfo write FcbLicInfo;
    property fRuntimeKeyAvail: BOOL read FfRuntimeKeyAvail write FfRuntimeKeyAvail;
    property fLicVerified: BOOL read FfLicVerified write FfLicVerified;
  end;
  
  TCAGUIDWrapper = class(TatRecordWrapper)
  private
    FcElems: Longint;
  public
    constructor Create(ARecord: TCAGUID);
    function ObjToRec: TCAGUID;
  published
    property cElems: Longint read FcElems write FcElems;
  end;
  
  TCAPOleStrWrapper = class(TatRecordWrapper)
  private
    FcElems: Longint;
  public
    constructor Create(ARecord: TCAPOleStr);
    function ObjToRec: TCAPOleStr;
  published
    property cElems: Longint read FcElems write FcElems;
  end;
  
  TCALongintWrapper = class(TatRecordWrapper)
  private
    FcElems: Longint;
  public
    constructor Create(ARecord: TCALongint);
    function ObjToRec: TCALongint;
  published
    property cElems: Longint read FcElems write FcElems;
  end;
  
  tagOCPFIPARAMSWrapper = class(TatRecordWrapper)
  private
    FcbStructSize: Longint;
    FhWndOwner: HWnd;
    Fx: Integer;
    Fy: Integer;
    FcObjects: Longint;
    FcPages: Longint;
    Flcid: TLCID;
    FdispidInitialProperty: TDispID;
  public
    constructor Create(ARecord: tagOCPFIPARAMS);
    function ObjToRec: tagOCPFIPARAMS;
  published
    property cbStructSize: Longint read FcbStructSize write FcbStructSize;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property cObjects: Longint read FcObjects write FcObjects;
    property cPages: Longint read FcPages write FcPages;
    property lcid: TLCID read Flcid write Flcid;
    property dispidInitialProperty: TDispID read FdispidInitialProperty write FdispidInitialProperty;
  end;
  
  tagPROPPAGEINFOWrapper = class(TatRecordWrapper)
  private
    Fcb: Longint;
    FdwHelpContext: Longint;
  public
    constructor Create(ARecord: tagPROPPAGEINFO);
    function ObjToRec: tagPROPPAGEINFO;
  published
    property cb: Longint read Fcb write Fcb;
    property dwHelpContext: Longint read FdwHelpContext write FdwHelpContext;
  end;
  
  tagFONTDESCWrapper = class(TatRecordWrapper)
  private
    FcbSizeofstruct: Integer;
    FcySize: Comp;
    FsWeight: Smallint;
    FsCharset: Smallint;
    FfItalic: BOOL;
    FfUnderline: BOOL;
    FfStrikethrough: BOOL;
  public
    constructor Create(ARecord: tagFONTDESC);
    function ObjToRec: tagFONTDESC;
  published
    property cbSizeofstruct: Integer read FcbSizeofstruct write FcbSizeofstruct;
    property cySize: Comp read FcySize write FcySize;
    property sWeight: Smallint read FsWeight write FsWeight;
    property sCharset: Smallint read FsCharset write FsCharset;
    property fItalic: BOOL read FfItalic write FfItalic;
    property fUnderline: BOOL read FfUnderline write FfUnderline;
    property fStrikethrough: BOOL read FfStrikethrough write FfStrikethrough;
  end;
  
  tagPICTDESCWrapper = class(TatRecordWrapper)
  private
    FcbSizeofstruct: Integer;
    FpicType: Integer;
    Fhbitmap: THandle;
    Fhpal: THandle;
    FhMeta: THandle;
    FxExt: Integer;
    FyExt: Integer;
    FhIcon: THandle;
  public
    constructor Create(ARecord: tagPICTDESC);
    function ObjToRec: tagPICTDESC;
  published
    property cbSizeofstruct: Integer read FcbSizeofstruct write FcbSizeofstruct;
    property picType: Integer read FpicType write FpicType;
    property hbitmap: THandle read Fhbitmap write Fhbitmap;
    property hpal: THandle read Fhpal write Fhpal;
    property hMeta: THandle read FhMeta write FhMeta;
    property xExt: Integer read FxExt write FxExt;
    property yExt: Integer read FyExt write FyExt;
    property hIcon: THandle read FhIcon write FhIcon;
  end;
  

implementation

constructor tagPOINTFXWrapper.Create(ARecord: tagPOINTFX);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
end;

function tagPOINTFXWrapper.ObjToRec: tagPOINTFX;
begin
  result.x := Fx;
  result.y := Fy;
end;

constructor tagCONTROLINFOWrapper.Create(ARecord: tagCONTROLINFO);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FhAccel := ARecord.hAccel;
  FcAccel := ARecord.cAccel;
  FdwFlags := ARecord.dwFlags;
end;

function tagCONTROLINFOWrapper.ObjToRec: tagCONTROLINFO;
begin
  result.cb := Fcb;
  result.hAccel := FhAccel;
  result.cAccel := FcAccel;
  result.dwFlags := FdwFlags;
end;

constructor tagCONNECTDATAWrapper.Create(ARecord: tagCONNECTDATA);
begin
  inherited Create;
  FpUnk := ARecord.pUnk;
  FdwCookie := ARecord.dwCookie;
end;

function tagCONNECTDATAWrapper.ObjToRec: tagCONNECTDATA;
begin
  result.pUnk := FpUnk;
  result.dwCookie := FdwCookie;
end;

constructor tagLICINFOWrapper.Create(ARecord: tagLICINFO);
begin
  inherited Create;
  FcbLicInfo := ARecord.cbLicInfo;
  FfRuntimeKeyAvail := ARecord.fRuntimeKeyAvail;
  FfLicVerified := ARecord.fLicVerified;
end;

function tagLICINFOWrapper.ObjToRec: tagLICINFO;
begin
  result.cbLicInfo := FcbLicInfo;
  result.fRuntimeKeyAvail := FfRuntimeKeyAvail;
  result.fLicVerified := FfLicVerified;
end;

constructor TCAGUIDWrapper.Create(ARecord: TCAGUID);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function TCAGUIDWrapper.ObjToRec: TCAGUID;
begin
  result.cElems := FcElems;
end;

constructor TCAPOleStrWrapper.Create(ARecord: TCAPOleStr);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function TCAPOleStrWrapper.ObjToRec: TCAPOleStr;
begin
  result.cElems := FcElems;
end;

constructor TCALongintWrapper.Create(ARecord: TCALongint);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function TCALongintWrapper.ObjToRec: TCALongint;
begin
  result.cElems := FcElems;
end;

constructor tagOCPFIPARAMSWrapper.Create(ARecord: tagOCPFIPARAMS);
begin
  inherited Create;
  FcbStructSize := ARecord.cbStructSize;
  FhWndOwner := ARecord.hWndOwner;
  Fx := ARecord.x;
  Fy := ARecord.y;
  FcObjects := ARecord.cObjects;
  FcPages := ARecord.cPages;
  Flcid := ARecord.lcid;
  FdispidInitialProperty := ARecord.dispidInitialProperty;
end;

function tagOCPFIPARAMSWrapper.ObjToRec: tagOCPFIPARAMS;
begin
  result.cbStructSize := FcbStructSize;
  result.hWndOwner := FhWndOwner;
  result.x := Fx;
  result.y := Fy;
  result.cObjects := FcObjects;
  result.cPages := FcPages;
  result.lcid := Flcid;
  result.dispidInitialProperty := FdispidInitialProperty;
end;

constructor tagPROPPAGEINFOWrapper.Create(ARecord: tagPROPPAGEINFO);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FdwHelpContext := ARecord.dwHelpContext;
end;

function tagPROPPAGEINFOWrapper.ObjToRec: tagPROPPAGEINFO;
begin
  result.cb := Fcb;
  result.dwHelpContext := FdwHelpContext;
end;

constructor tagFONTDESCWrapper.Create(ARecord: tagFONTDESC);
begin
  inherited Create;
  FcbSizeofstruct := ARecord.cbSizeofstruct;
  FcySize := ARecord.cySize;
  FsWeight := ARecord.sWeight;
  FsCharset := ARecord.sCharset;
  FfItalic := ARecord.fItalic;
  FfUnderline := ARecord.fUnderline;
  FfStrikethrough := ARecord.fStrikethrough;
end;

function tagFONTDESCWrapper.ObjToRec: tagFONTDESC;
begin
  result.cbSizeofstruct := FcbSizeofstruct;
  result.cySize := FcySize;
  result.sWeight := FsWeight;
  result.sCharset := FsCharset;
  result.fItalic := FfItalic;
  result.fUnderline := FfUnderline;
  result.fStrikethrough := FfStrikethrough;
end;

constructor tagPICTDESCWrapper.Create(ARecord: tagPICTDESC);
begin
  inherited Create;
  FcbSizeofstruct := ARecord.cbSizeofstruct;
  FpicType := ARecord.picType;
  Fhbitmap := ARecord.hbitmap;
  Fhpal := ARecord.hpal;
  FhMeta := ARecord.hMeta;
  FxExt := ARecord.xExt;
  FyExt := ARecord.yExt;
  FhIcon := ARecord.hIcon;
end;

function tagPICTDESCWrapper.ObjToRec: tagPICTDESC;
begin
  result.cbSizeofstruct := FcbSizeofstruct;
  result.picType := FpicType;
  result.hbitmap := Fhbitmap;
  result.hpal := Fhpal;
  result.hMeta := FhMeta;
  result.xExt := FxExt;
  result.yExt := FyExt;
  result.hIcon := FhIcon;
end;



procedure TatOleCtlLibrary.__IOleControlGetControlInfo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TControlInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCONTROLINFOWrapper) then 
  Param0Rec := tagCONTROLINFOWrapper.Create(Param0);
Param0 := tagCONTROLINFOWrapper(Param0Rec).ObjToRec;
AResult := Integer(IOleControl(CurrentObject).GetControlInfo(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCONTROLINFOWrapper.Create(Param0)));
  end;
end;

procedure TatOleCtlLibrary.__IOleControlOnAmbientPropertyChange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleControl(CurrentObject).OnAmbientPropertyChange(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IOleControlFreezeEvents(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleControl(CurrentObject).FreezeEvents(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IOleControlSiteOnControlInfoChanged(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleControlSite(CurrentObject).OnControlInfoChanged);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IOleControlSiteLockInPlaceActive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleControlSite(CurrentObject).LockInPlaceActive(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IOleControlSiteGetExtendedControl(AMachine: TatVirtualMachine);
  var
  Param0: IDispatch;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IDispatch(Integer(GetInputArg(0)));
AResult := Integer(IOleControlSite(CurrentObject).GetExtendedControl(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IOleControlSiteTransformCoords(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPoint;
  Param1Rec: TObject;
  Param1: TPointF;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TPointWrapper) then 
  Param0Rec := TPointWrapper.Create(Param0);
Param0 := TPointWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagPOINTFXWrapper) then 
  Param1Rec := tagPOINTFXWrapper.Create(Param1);
Param1 := tagPOINTFXWrapper(Param1Rec).ObjToRec;
AResult := Integer(IOleControlSite(CurrentObject).TransformCoords(Param0,Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TPointWrapper.Create(Param0)));
    SetInputArg(1,integer(tagPOINTFXWrapper.Create(Param1)));
  end;
end;

procedure TatOleCtlLibrary.__IOleControlSiteOnFocus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleControlSite(CurrentObject).OnFocus(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IOleControlSiteShowPropertyFrame(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IOleControlSite(CurrentObject).ShowPropertyFrame);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__ISimpleFrameSitePreMessageFilter(AMachine: TatVirtualMachine);
  var
  Param4: Integer;
  Param5: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(ISimpleFrameSite(CurrentObject).PreMessageFilter(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatOleCtlLibrary.__ISimpleFrameSitePostMessageFilter(AMachine: TatVirtualMachine);
  var
  Param4: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(ISimpleFrameSite(CurrentObject).PostMessageFilter(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4,VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatOleCtlLibrary.__IPersistStreamInitIsDirty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStreamInit(CurrentObject).IsDirty);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPersistStreamInitLoad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStreamInit(CurrentObject).Load(IStream(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPersistStreamInitSave(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStreamInit(CurrentObject).Save(IStream(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPersistStreamInitGetSizeMax(AMachine: TatVirtualMachine);
  var
  Param0: Largeint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IPersistStreamInit(CurrentObject).GetSizeMax(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOleCtlLibrary.__IPersistStreamInitInitNew(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPersistStreamInit(CurrentObject).InitNew);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyNotifySinkOnChanged(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyNotifySink(CurrentObject).OnChanged(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyNotifySinkOnRequestEdit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyNotifySink(CurrentObject).OnRequestEdit(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IProvideClassInfoGetClassInfo(AMachine: TatVirtualMachine);
  var
  Param0: ITypeInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := ITypeInfo(Integer(GetInputArg(0)));
AResult := Integer(IProvideClassInfo(CurrentObject).GetClassInfo(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IConnectionPointContainerEnumConnectionPoints(AMachine: TatVirtualMachine);
  var
  Param0: IEnumConnectionPoints;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumConnectionPoints(Integer(GetInputArg(0)));
AResult := Integer(IConnectionPointContainer(CurrentObject).EnumConnectionPoints(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IConnectionPointContainerFindConnectionPoint(AMachine: TatVirtualMachine);
  var
  Param1: IConnectionPoint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := IConnectionPoint(Integer(GetInputArg(1)));
AResult := Integer(IConnectionPointContainer(CurrentObject).FindConnectionPoint(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOleCtlLibrary.__IEnumConnectionPointsSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumConnectionPoints(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IEnumConnectionPointsReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumConnectionPoints(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IEnumConnectionPointsClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumConnectionPoints;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumConnectionPoints(Integer(GetInputArg(0)));
AResult := Integer(IEnumConnectionPoints(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IConnectionPointGetConnectionInterface(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TIID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TGUIDWrapper) then 
  Param0Rec := TGUIDWrapper.Create(Param0);
Param0 := TGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(IConnectionPoint(CurrentObject).GetConnectionInterface(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatOleCtlLibrary.__IConnectionPointGetConnectionPointContainer(AMachine: TatVirtualMachine);
  var
  Param0: IConnectionPointContainer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IConnectionPointContainer(Integer(GetInputArg(0)));
AResult := Integer(IConnectionPoint(CurrentObject).GetConnectionPointContainer(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IConnectionPointAdvise(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(IConnectionPoint(CurrentObject).Advise(IUnknown(Integer(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatOleCtlLibrary.__IConnectionPointUnadvise(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IConnectionPoint(CurrentObject).Unadvise(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IConnectionPointEnumConnections(AMachine: TatVirtualMachine);
  var
  Param0: IEnumConnections;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumConnections(Integer(GetInputArg(0)));
AResult := Integer(IConnectionPoint(CurrentObject).EnumConnections(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IEnumConnectionsSkip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumConnections(CurrentObject).Skip(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IEnumConnectionsReset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IEnumConnections(CurrentObject).Reset);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IEnumConnectionsClone(AMachine: TatVirtualMachine);
  var
  Param0: IEnumConnections;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IEnumConnections(Integer(GetInputArg(0)));
AResult := Integer(IEnumConnections(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IClassFactory2GetLicInfo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TLicInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagLICINFOWrapper) then 
  Param0Rec := tagLICINFOWrapper.Create(Param0);
Param0 := tagLICINFOWrapper(Param0Rec).ObjToRec;
AResult := Integer(IClassFactory2(CurrentObject).GetLicInfo(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagLICINFOWrapper.Create(Param0)));
  end;
end;

procedure TatOleCtlLibrary.__IClassFactory2RequestLicKey(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: TBStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(IClassFactory2(CurrentObject).RequestLicKey(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatOleCtlLibrary.__IClassFactory2CreateInstanceLic(AMachine: TatVirtualMachine);
  var
  Param3Buf: array[0..127] of WideChar;
  Param4: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := Integer(IClassFactory2(CurrentObject).CreateInstanceLic(IUnknown(Integer(GetInputArg(0))),IUnknown(Integer(GetInputArg(1))),TGUIDWrapper(integer(GetInputArg(2))).ObjToRec,StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatOleCtlLibrary.__ISpecifyPropertyPagesGetPages(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TCAGUID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TCAGUIDWrapper) then 
  Param0Rec := TCAGUIDWrapper.Create(Param0);
Param0 := TCAGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(ISpecifyPropertyPages(CurrentObject).GetPages(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TCAGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatOleCtlLibrary.__IPerPropertyBrowsingGetDisplayString(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: TBStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(IPerPropertyBrowsing(CurrentObject).GetDisplayString(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatOleCtlLibrary.__IPerPropertyBrowsingMapPropertyToPage(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(IPerPropertyBrowsing(CurrentObject).MapPropertyToPage(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatOleCtlLibrary.__IPerPropertyBrowsingGetPredefinedStrings(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCAPOleStr;
  Param2Rec: TObject;
  Param2: TCALongint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TCAPOleStrWrapper) then 
  Param1Rec := TCAPOleStrWrapper.Create(Param1);
Param1 := TCAPOleStrWrapper(Param1Rec).ObjToRec;
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TCALongintWrapper) then 
  Param2Rec := TCALongintWrapper.Create(Param2);
Param2 := TCALongintWrapper(Param2Rec).ObjToRec;
AResult := Integer(IPerPropertyBrowsing(CurrentObject).GetPredefinedStrings(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TCAPOleStrWrapper.Create(Param1)));
    SetInputArg(2,integer(TCALongintWrapper.Create(Param2)));
  end;
end;

procedure TatOleCtlLibrary.__IPerPropertyBrowsingGetPredefinedValue(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(IPerPropertyBrowsing(CurrentObject).GetPredefinedValue(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageSiteOnStatusChange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPageSite(CurrentObject).OnStatusChange(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageSiteGetLocaleID(AMachine: TatVirtualMachine);
  var
  Param0: TLCID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IPropertyPageSite(CurrentObject).GetLocaleID(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageSiteGetPageContainer(AMachine: TatVirtualMachine);
  var
  Param0: IUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IUnknown(Integer(GetInputArg(0)));
AResult := Integer(IPropertyPageSite(CurrentObject).GetPageContainer(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageSetPageSite(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).SetPageSite(IPropertyPageSite(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageActivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).Activate(VarToInteger(GetInputArg(0)),TRectWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageDeactivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).Deactivate);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageGetPageInfo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPropPageInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagPROPPAGEINFOWrapper) then 
  Param0Rec := tagPROPPAGEINFOWrapper.Create(Param0);
Param0 := tagPROPPAGEINFOWrapper(Param0Rec).ObjToRec;
AResult := Integer(IPropertyPage(CurrentObject).GetPageInfo(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagPROPPAGEINFOWrapper.Create(Param0)));
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageSetObjects(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).SetObjects(VarToInteger(GetInputArg(0)),IUnknown(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageShow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).Show(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageMove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).Move(TRectWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageIsPageDirty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).IsPageDirty);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageApply(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).Apply);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPageHelp(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage(CurrentObject).Help(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPropertyPage2EditProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPropertyPage2(CurrentObject).EditProperty(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_Name(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: TBStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(IFont(CurrentObject).get_Name(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IFontput_Name(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).put_Name(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_Size(AMachine: TatVirtualMachine);
  var
  Param0: TCurrency;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IFont(CurrentObject).get_Size(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOleCtlLibrary.__IFontput_Size(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).put_Size(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_Bold(AMachine: TatVirtualMachine);
  var
  Param0: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IFont(CurrentObject).get_Bold(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOleCtlLibrary.__IFontput_Bold(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).put_Bold(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_Italic(AMachine: TatVirtualMachine);
  var
  Param0: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IFont(CurrentObject).get_Italic(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOleCtlLibrary.__IFontput_Italic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).put_Italic(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_Underline(AMachine: TatVirtualMachine);
  var
  Param0: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IFont(CurrentObject).get_Underline(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOleCtlLibrary.__IFontput_Underline(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).put_Underline(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_Strikethrough(AMachine: TatVirtualMachine);
  var
  Param0: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IFont(CurrentObject).get_Strikethrough(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOleCtlLibrary.__IFontput_Strikethrough(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).put_Strikethrough(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_Weight(AMachine: TatVirtualMachine);
  var
  Param0: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IFont(CurrentObject).get_Weight(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IFontput_Weight(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).put_Weight(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_Charset(AMachine: TatVirtualMachine);
  var
  Param0: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IFont(CurrentObject).get_Charset(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IFontput_Charset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).put_Charset(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontget_hFont(AMachine: TatVirtualMachine);
  var
  Param0: HFont;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IFont(CurrentObject).get_hFont(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IFontClone(AMachine: TatVirtualMachine);
  var
  Param0: IFont;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := IFont(Integer(GetInputArg(0)));
AResult := Integer(IFont(CurrentObject).Clone(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IFontIsEqual(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).IsEqual(IFont(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontSetRatio(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).SetRatio(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontQueryTextMetrics(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TTextMetricOle;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagTEXTMETRICWWrapper) then 
  Param0Rec := tagTEXTMETRICWWrapper.Create(Param0);
Param0 := tagTEXTMETRICWWrapper(Param0Rec).ObjToRec;
AResult := Integer(IFont(CurrentObject).QueryTextMetrics(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagTEXTMETRICWWrapper.Create(Param0)));
  end;
end;

procedure TatOleCtlLibrary.__IFontAddRefHfont(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).AddRefHfont(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IFontReleaseHfont(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IFont(CurrentObject).ReleaseHfont(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPictureget_Handle(AMachine: TatVirtualMachine);
  var
  Param0: OLE_HANDLE;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IPicture(CurrentObject).get_Handle(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IPictureget_hPal(AMachine: TatVirtualMachine);
  var
  Param0: OLE_HANDLE;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IPicture(CurrentObject).get_hPal(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IPictureget_Type(AMachine: TatVirtualMachine);
  var
  Param0: Smallint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IPicture(CurrentObject).get_Type(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IPictureget_Width(AMachine: TatVirtualMachine);
  var
  Param0: OLE_XSIZE_HIMETRIC;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IPicture(CurrentObject).get_Width(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IPictureget_Height(AMachine: TatVirtualMachine);
  var
  Param0: OLE_YSIZE_HIMETRIC;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IPicture(CurrentObject).get_Height(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IPictureRender(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPicture(CurrentObject).Render(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),VarToInteger(GetInputArg(7)),VarToInteger(GetInputArg(8)),TRectWrapper(integer(GetInputArg(9))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPictureset_hPal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPicture(CurrentObject).set_hPal(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPictureget_CurDC(AMachine: TatVirtualMachine);
  var
  Param0: HDC;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(IPicture(CurrentObject).get_CurDC(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatOleCtlLibrary.__IPictureSelectPicture(AMachine: TatVirtualMachine);
  var
  Param1: HDC;
  Param2: OLE_HANDLE;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(IPicture(CurrentObject).SelectPicture(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOleCtlLibrary.__IPictureget_KeepOriginalFormat(AMachine: TatVirtualMachine);
  var
  Param0: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(IPicture(CurrentObject).get_KeepOriginalFormat(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatOleCtlLibrary.__IPictureput_KeepOriginalFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPicture(CurrentObject).put_KeepOriginalFormat(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPicturePictureChanged(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPicture(CurrentObject).PictureChanged);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__IPictureSaveAsFile(AMachine: TatVirtualMachine);
  var
  Param2: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(IPicture(CurrentObject).SaveAsFile(IStream(Integer(GetInputArg(0))),GetInputArg(1),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOleCtlLibrary.__IPictureget_Attributes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(IPicture(CurrentObject).get_Attributes(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__OleCreatePropertyFrameIndirect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOCPFIParams;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOCPFIPARAMSWrapper) then 
  Param0Rec := tagOCPFIPARAMSWrapper.Create(Param0);
Param0 := tagOCPFIPARAMSWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleCtl.OleCreatePropertyFrameIndirect(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOCPFIPARAMSWrapper.Create(Param0)));
  end;
end;

procedure TatOleCtlLibrary.__OleTranslateColor(AMachine: TatVirtualMachine);
  var
  Param2: TColorRef;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(OleCtl.OleTranslateColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatOleCtlLibrary.__OleCreateFontIndirect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFontDesc;
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFONTDESCWrapper) then 
  Param0Rec := tagFONTDESCWrapper.Create(Param0);
Param0 := tagFONTDESCWrapper(Param0Rec).ObjToRec;
Param2 := GetInputArg(2);
AResult := Integer(OleCtl.OleCreateFontIndirect(Param0,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFONTDESCWrapper.Create(Param0)));
    SetInputArg(2,Param2);
  end;
end;

procedure TatOleCtlLibrary.__OleCreatePictureIndirect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPictDesc;
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagPICTDESCWrapper) then 
  Param0Rec := tagPICTDESCWrapper.Create(Param0);
Param0 := tagPICTDESCWrapper(Param0Rec).ObjToRec;
Param3 := GetInputArg(3);
AResult := Integer(OleCtl.OleCreatePictureIndirect(Param0,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagPICTDESCWrapper.Create(Param0)));
    SetInputArg(3,Param3);
  end;
end;

procedure TatOleCtlLibrary.__OleLoadPicture(AMachine: TatVirtualMachine);
  var
  Param4: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := Integer(OleCtl.OleLoadPicture(IStream(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),GetInputArg(2),TGUIDWrapper(integer(GetInputArg(3))).ObjToRec,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatOleCtlLibrary.__OleIconToCursor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(OleCtl.OleIconToCursor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPropertyNotifySink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPropertyNotifySink)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IClassFactory2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IClassFactory2)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IProvideClassInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IProvideClassInfo)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IConnectionPointContainer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IConnectionPointContainer)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IEnumConnectionPoints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IEnumConnectionPoints)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IConnectionPoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IConnectionPoint)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IEnumConnections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IEnumConnections)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IOleControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IOleControl)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IOleControlSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IOleControlSite)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_ISimpleFrameSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_ISimpleFrameSite)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPersistStreamInit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPersistStreamInit)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPropertyFrame(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPropertyFrame)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_ISpecifyPropertyPages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_ISpecifyPropertyPages)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPerPropertyBrowsing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPerPropertyBrowsing)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPropertyPageSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPropertyPageSite)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPropertyPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPropertyPage)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPropertyPage2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPropertyPage2)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IFont)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IFontDisp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IFontDisp)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPicture)));
  end;
end;

procedure TatOleCtlLibrary.__GetIID_IPictureDisp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.IID_IPictureDisp)));
  end;
end;

procedure TatOleCtlLibrary.__GetCLSID_CFontPropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.CLSID_CFontPropPage)));
  end;
end;

procedure TatOleCtlLibrary.__GetCLSID_CColorPropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.CLSID_CColorPropPage)));
  end;
end;

procedure TatOleCtlLibrary.__GetCLSID_CPicturePropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.CLSID_CPicturePropPage)));
  end;
end;

procedure TatOleCtlLibrary.__GetCLSID_PersistPropset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.CLSID_PersistPropset)));
  end;
end;

procedure TatOleCtlLibrary.__GetCLSID_ConvertVBX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.CLSID_ConvertVBX)));
  end;
end;

procedure TatOleCtlLibrary.__GetCLSID_StdFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.CLSID_StdFont)));
  end;
end;

procedure TatOleCtlLibrary.__GetCLSID_StdPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleCtl.CLSID_StdPicture)));
  end;
end;

procedure TatOleCtlLibrary.Init;
begin
  With Scripter.DefineClass(IOleControl) do
  begin
    DefineMethod('GetControlInfo',1,tkInteger,nil,__IOleControlGetControlInfo,false,0).SetVarArgs([0]);
    DefineMethod('OnAmbientPropertyChange',1,tkInteger,nil,__IOleControlOnAmbientPropertyChange,false,0);
    DefineMethod('FreezeEvents',1,tkInteger,nil,__IOleControlFreezeEvents,false,0);
  end;
  With Scripter.DefineClass(IOleControlSite) do
  begin
    DefineMethod('OnControlInfoChanged',0,tkInteger,nil,__IOleControlSiteOnControlInfoChanged,false,0);
    DefineMethod('LockInPlaceActive',1,tkInteger,nil,__IOleControlSiteLockInPlaceActive,false,0);
    DefineMethod('GetExtendedControl',1,tkInteger,nil,__IOleControlSiteGetExtendedControl,false,0).SetVarArgs([0]);
    DefineMethod('TransformCoords',3,tkInteger,nil,__IOleControlSiteTransformCoords,false,0).SetVarArgs([0,1]);
    DefineMethod('OnFocus',1,tkInteger,nil,__IOleControlSiteOnFocus,false,0);
    DefineMethod('ShowPropertyFrame',0,tkInteger,nil,__IOleControlSiteShowPropertyFrame,false,0);
  end;
  With Scripter.DefineClass(ISimpleFrameSite) do
  begin
    DefineMethod('PreMessageFilter',6,tkInteger,nil,__ISimpleFrameSitePreMessageFilter,false,0).SetVarArgs([4,5]);
    DefineMethod('PostMessageFilter',6,tkInteger,nil,__ISimpleFrameSitePostMessageFilter,false,0).SetVarArgs([4]);
  end;
  With Scripter.DefineClass(IPersistStreamInit) do
  begin
    DefineMethod('IsDirty',0,tkInteger,nil,__IPersistStreamInitIsDirty,false,0);
    DefineMethod('Load',1,tkInteger,nil,__IPersistStreamInitLoad,false,0);
    DefineMethod('Save',2,tkInteger,nil,__IPersistStreamInitSave,false,0);
    DefineMethod('GetSizeMax',1,tkInteger,nil,__IPersistStreamInitGetSizeMax,false,0).SetVarArgs([0]);
    DefineMethod('InitNew',0,tkInteger,nil,__IPersistStreamInitInitNew,false,0);
  end;
  With Scripter.DefineClass(IPropertyNotifySink) do
  begin
    DefineMethod('OnChanged',1,tkInteger,nil,__IPropertyNotifySinkOnChanged,false,0);
    DefineMethod('OnRequestEdit',1,tkInteger,nil,__IPropertyNotifySinkOnRequestEdit,false,0);
  end;
  With Scripter.DefineClass(IProvideClassInfo) do
  begin
    DefineMethod('GetClassInfo',1,tkInteger,nil,__IProvideClassInfoGetClassInfo,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IConnectionPointContainer) do
  begin
    DefineMethod('EnumConnectionPoints',1,tkInteger,nil,__IConnectionPointContainerEnumConnectionPoints,false,0).SetVarArgs([0]);
    DefineMethod('FindConnectionPoint',2,tkInteger,nil,__IConnectionPointContainerFindConnectionPoint,false,0).SetVarArgs([1]);
  end;
  With Scripter.DefineClass(IEnumConnectionPoints) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumConnectionPointsSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumConnectionPointsReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumConnectionPointsClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IConnectionPoint) do
  begin
    DefineMethod('GetConnectionInterface',1,tkInteger,nil,__IConnectionPointGetConnectionInterface,false,0).SetVarArgs([0]);
    DefineMethod('GetConnectionPointContainer',1,tkInteger,nil,__IConnectionPointGetConnectionPointContainer,false,0).SetVarArgs([0]);
    DefineMethod('Advise',2,tkInteger,nil,__IConnectionPointAdvise,false,0).SetVarArgs([1]);
    DefineMethod('Unadvise',1,tkInteger,nil,__IConnectionPointUnadvise,false,0);
    DefineMethod('EnumConnections',1,tkInteger,nil,__IConnectionPointEnumConnections,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IEnumConnections) do
  begin
    DefineMethod('Skip',1,tkInteger,nil,__IEnumConnectionsSkip,false,0);
    DefineMethod('Reset',0,tkInteger,nil,__IEnumConnectionsReset,false,0);
    DefineMethod('Clone',1,tkInteger,nil,__IEnumConnectionsClone,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IClassFactory2) do
  begin
    DefineMethod('GetLicInfo',1,tkInteger,nil,__IClassFactory2GetLicInfo,false,0).SetVarArgs([0]);
    DefineMethod('RequestLicKey',2,tkInteger,nil,__IClassFactory2RequestLicKey,false,0).SetVarArgs([1]);
    DefineMethod('CreateInstanceLic',5,tkInteger,nil,__IClassFactory2CreateInstanceLic,false,0).SetVarArgs([4]);
  end;
  With Scripter.DefineClass(ISpecifyPropertyPages) do
  begin
    DefineMethod('GetPages',1,tkInteger,nil,__ISpecifyPropertyPagesGetPages,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IPerPropertyBrowsing) do
  begin
    DefineMethod('GetDisplayString',2,tkInteger,nil,__IPerPropertyBrowsingGetDisplayString,false,0).SetVarArgs([1]);
    DefineMethod('MapPropertyToPage',2,tkInteger,nil,__IPerPropertyBrowsingMapPropertyToPage,false,0).SetVarArgs([1]);
    DefineMethod('GetPredefinedStrings',3,tkInteger,nil,__IPerPropertyBrowsingGetPredefinedStrings,false,0).SetVarArgs([1,2]);
    DefineMethod('GetPredefinedValue',3,tkInteger,nil,__IPerPropertyBrowsingGetPredefinedValue,false,0).SetVarArgs([2]);
  end;
  With Scripter.DefineClass(IPropertyPageSite) do
  begin
    DefineMethod('OnStatusChange',1,tkInteger,nil,__IPropertyPageSiteOnStatusChange,false,0);
    DefineMethod('GetLocaleID',1,tkInteger,nil,__IPropertyPageSiteGetLocaleID,false,0).SetVarArgs([0]);
    DefineMethod('GetPageContainer',1,tkInteger,nil,__IPropertyPageSiteGetPageContainer,false,0).SetVarArgs([0]);
  end;
  With Scripter.DefineClass(IPropertyPage) do
  begin
    DefineMethod('SetPageSite',1,tkInteger,nil,__IPropertyPageSetPageSite,false,0);
    DefineMethod('Activate',3,tkInteger,nil,__IPropertyPageActivate,false,0);
    DefineMethod('Deactivate',0,tkInteger,nil,__IPropertyPageDeactivate,false,0);
    DefineMethod('GetPageInfo',1,tkInteger,nil,__IPropertyPageGetPageInfo,false,0).SetVarArgs([0]);
    DefineMethod('SetObjects',2,tkInteger,nil,__IPropertyPageSetObjects,false,0);
    DefineMethod('Show',1,tkInteger,nil,__IPropertyPageShow,false,0);
    DefineMethod('Move',1,tkInteger,nil,__IPropertyPageMove,false,0);
    DefineMethod('IsPageDirty',0,tkInteger,nil,__IPropertyPageIsPageDirty,false,0);
    DefineMethod('Apply',0,tkInteger,nil,__IPropertyPageApply,false,0);
    DefineMethod('Help',1,tkInteger,nil,__IPropertyPageHelp,false,0);
  end;
  With Scripter.DefineClass(IPropertyPage2) do
  begin
    DefineMethod('EditProperty',1,tkInteger,nil,__IPropertyPage2EditProperty,false,0);
  end;
  With Scripter.DefineClass(IFont) do
  begin
    DefineMethod('get_Name',1,tkInteger,nil,__IFontget_Name,false,0).SetVarArgs([0]);
    DefineMethod('put_Name',1,tkInteger,nil,__IFontput_Name,false,0);
    DefineMethod('get_Size',1,tkInteger,nil,__IFontget_Size,false,0).SetVarArgs([0]);
    DefineMethod('put_Size',1,tkInteger,nil,__IFontput_Size,false,0);
    DefineMethod('get_Bold',1,tkInteger,nil,__IFontget_Bold,false,0).SetVarArgs([0]);
    DefineMethod('put_Bold',1,tkInteger,nil,__IFontput_Bold,false,0);
    DefineMethod('get_Italic',1,tkInteger,nil,__IFontget_Italic,false,0).SetVarArgs([0]);
    DefineMethod('put_Italic',1,tkInteger,nil,__IFontput_Italic,false,0);
    DefineMethod('get_Underline',1,tkInteger,nil,__IFontget_Underline,false,0).SetVarArgs([0]);
    DefineMethod('put_Underline',1,tkInteger,nil,__IFontput_Underline,false,0);
    DefineMethod('get_Strikethrough',1,tkInteger,nil,__IFontget_Strikethrough,false,0).SetVarArgs([0]);
    DefineMethod('put_Strikethrough',1,tkInteger,nil,__IFontput_Strikethrough,false,0);
    DefineMethod('get_Weight',1,tkInteger,nil,__IFontget_Weight,false,0).SetVarArgs([0]);
    DefineMethod('put_Weight',1,tkInteger,nil,__IFontput_Weight,false,0);
    DefineMethod('get_Charset',1,tkInteger,nil,__IFontget_Charset,false,0).SetVarArgs([0]);
    DefineMethod('put_Charset',1,tkInteger,nil,__IFontput_Charset,false,0);
    DefineMethod('get_hFont',1,tkInteger,nil,__IFontget_hFont,false,0).SetVarArgs([0]);
    DefineMethod('Clone',1,tkInteger,nil,__IFontClone,false,0).SetVarArgs([0]);
    DefineMethod('IsEqual',1,tkInteger,nil,__IFontIsEqual,false,0);
    DefineMethod('SetRatio',2,tkInteger,nil,__IFontSetRatio,false,0);
    DefineMethod('QueryTextMetrics',1,tkInteger,nil,__IFontQueryTextMetrics,false,0).SetVarArgs([0]);
    DefineMethod('AddRefHfont',1,tkInteger,nil,__IFontAddRefHfont,false,0);
    DefineMethod('ReleaseHfont',1,tkInteger,nil,__IFontReleaseHfont,false,0);
  end;
  With Scripter.DefineClass(IFontDisp) do
  begin
  end;
  With Scripter.DefineClass(IPicture) do
  begin
    DefineMethod('get_Handle',1,tkInteger,nil,__IPictureget_Handle,false,0).SetVarArgs([0]);
    DefineMethod('get_hPal',1,tkInteger,nil,__IPictureget_hPal,false,0).SetVarArgs([0]);
    DefineMethod('get_Type',1,tkInteger,nil,__IPictureget_Type,false,0).SetVarArgs([0]);
    DefineMethod('get_Width',1,tkInteger,nil,__IPictureget_Width,false,0).SetVarArgs([0]);
    DefineMethod('get_Height',1,tkInteger,nil,__IPictureget_Height,false,0).SetVarArgs([0]);
    DefineMethod('Render',10,tkInteger,nil,__IPictureRender,false,0);
    DefineMethod('set_hPal',1,tkInteger,nil,__IPictureset_hPal,false,0);
    DefineMethod('get_CurDC',1,tkInteger,nil,__IPictureget_CurDC,false,0).SetVarArgs([0]);
    DefineMethod('SelectPicture',3,tkInteger,nil,__IPictureSelectPicture,false,0).SetVarArgs([1,2]);
    DefineMethod('get_KeepOriginalFormat',1,tkInteger,nil,__IPictureget_KeepOriginalFormat,false,0).SetVarArgs([0]);
    DefineMethod('put_KeepOriginalFormat',1,tkInteger,nil,__IPictureput_KeepOriginalFormat,false,0);
    DefineMethod('PictureChanged',0,tkInteger,nil,__IPicturePictureChanged,false,0);
    DefineMethod('SaveAsFile',3,tkInteger,nil,__IPictureSaveAsFile,false,0).SetVarArgs([2]);
    DefineMethod('get_Attributes',1,tkInteger,nil,__IPictureget_Attributes,false,0);
  end;
  With Scripter.DefineClass(IPictureDisp) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('OleCreatePropertyFrameIndirect',1,tkInteger,nil,__OleCreatePropertyFrameIndirect,false,0).SetVarArgs([0]);
    DefineMethod('OleTranslateColor',3,tkInteger,nil,__OleTranslateColor,false,0).SetVarArgs([2]);
    DefineMethod('OleCreateFontIndirect',3,tkInteger,nil,__OleCreateFontIndirect,false,0).SetVarArgs([0,2]);
    DefineMethod('OleCreatePictureIndirect',4,tkInteger,nil,__OleCreatePictureIndirect,false,0).SetVarArgs([0,3]);
    DefineMethod('OleLoadPicture',5,tkInteger,nil,__OleLoadPicture,false,0).SetVarArgs([4]);
    DefineMethod('OleIconToCursor',2,tkInteger,nil,__OleIconToCursor,false,0);
    DefineProp('IID_IPropertyNotifySink',tkVariant,__GetIID_IPropertyNotifySink,nil,nil,false,0);
    DefineProp('IID_IClassFactory2',tkVariant,__GetIID_IClassFactory2,nil,nil,false,0);
    DefineProp('IID_IProvideClassInfo',tkVariant,__GetIID_IProvideClassInfo,nil,nil,false,0);
    DefineProp('IID_IConnectionPointContainer',tkVariant,__GetIID_IConnectionPointContainer,nil,nil,false,0);
    DefineProp('IID_IEnumConnectionPoints',tkVariant,__GetIID_IEnumConnectionPoints,nil,nil,false,0);
    DefineProp('IID_IConnectionPoint',tkVariant,__GetIID_IConnectionPoint,nil,nil,false,0);
    DefineProp('IID_IEnumConnections',tkVariant,__GetIID_IEnumConnections,nil,nil,false,0);
    DefineProp('IID_IOleControl',tkVariant,__GetIID_IOleControl,nil,nil,false,0);
    DefineProp('IID_IOleControlSite',tkVariant,__GetIID_IOleControlSite,nil,nil,false,0);
    DefineProp('IID_ISimpleFrameSite',tkVariant,__GetIID_ISimpleFrameSite,nil,nil,false,0);
    DefineProp('IID_IPersistStreamInit',tkVariant,__GetIID_IPersistStreamInit,nil,nil,false,0);
    DefineProp('IID_IPropertyFrame',tkVariant,__GetIID_IPropertyFrame,nil,nil,false,0);
    DefineProp('IID_ISpecifyPropertyPages',tkVariant,__GetIID_ISpecifyPropertyPages,nil,nil,false,0);
    DefineProp('IID_IPerPropertyBrowsing',tkVariant,__GetIID_IPerPropertyBrowsing,nil,nil,false,0);
    DefineProp('IID_IPropertyPageSite',tkVariant,__GetIID_IPropertyPageSite,nil,nil,false,0);
    DefineProp('IID_IPropertyPage',tkVariant,__GetIID_IPropertyPage,nil,nil,false,0);
    DefineProp('IID_IPropertyPage2',tkVariant,__GetIID_IPropertyPage2,nil,nil,false,0);
    DefineProp('IID_IFont',tkVariant,__GetIID_IFont,nil,nil,false,0);
    DefineProp('IID_IFontDisp',tkVariant,__GetIID_IFontDisp,nil,nil,false,0);
    DefineProp('IID_IPicture',tkVariant,__GetIID_IPicture,nil,nil,false,0);
    DefineProp('IID_IPictureDisp',tkVariant,__GetIID_IPictureDisp,nil,nil,false,0);
    DefineProp('CLSID_CFontPropPage',tkVariant,__GetCLSID_CFontPropPage,nil,nil,false,0);
    DefineProp('CLSID_CColorPropPage',tkVariant,__GetCLSID_CColorPropPage,nil,nil,false,0);
    DefineProp('CLSID_CPicturePropPage',tkVariant,__GetCLSID_CPicturePropPage,nil,nil,false,0);
    DefineProp('CLSID_PersistPropset',tkVariant,__GetCLSID_PersistPropset,nil,nil,false,0);
    DefineProp('CLSID_ConvertVBX',tkVariant,__GetCLSID_ConvertVBX,nil,nil,false,0);
    DefineProp('CLSID_StdFont',tkVariant,__GetCLSID_StdFont,nil,nil,false,0);
    DefineProp('CLSID_StdPicture',tkVariant,__GetCLSID_StdPicture,nil,nil,false,0);
    AddConstant('triUnchecked',triUnchecked);
    AddConstant('triChecked',triChecked);
    AddConstant('triGray',triGray);
    AddConstant('CTL_E_ILLEGALFUNCTIONCALL',CTL_E_ILLEGALFUNCTIONCALL);
    AddConstant('CTL_E_OVERFLOW',CTL_E_OVERFLOW);
    AddConstant('CTL_E_OUTOFMEMORY',CTL_E_OUTOFMEMORY);
    AddConstant('CTL_E_DIVISIONBYZERO',CTL_E_DIVISIONBYZERO);
    AddConstant('CTL_E_OUTOFSTRINGSPACE',CTL_E_OUTOFSTRINGSPACE);
    AddConstant('CTL_E_OUTOFSTACKSPACE',CTL_E_OUTOFSTACKSPACE);
    AddConstant('CTL_E_BADFILENAMEORNUMBER',CTL_E_BADFILENAMEORNUMBER);
    AddConstant('CTL_E_FILENOTFOUND',CTL_E_FILENOTFOUND);
    AddConstant('CTL_E_BADFILEMODE',CTL_E_BADFILEMODE);
    AddConstant('CTL_E_FILEALREADYOPEN',CTL_E_FILEALREADYOPEN);
    AddConstant('CTL_E_DEVICEIOERROR',CTL_E_DEVICEIOERROR);
    AddConstant('CTL_E_FILEALREADYEXISTS',CTL_E_FILEALREADYEXISTS);
    AddConstant('CTL_E_BADRECORDLENGTH',CTL_E_BADRECORDLENGTH);
    AddConstant('CTL_E_DISKFULL',CTL_E_DISKFULL);
    AddConstant('CTL_E_BADRECORDNUMBER',CTL_E_BADRECORDNUMBER);
    AddConstant('CTL_E_BADFILENAME',CTL_E_BADFILENAME);
    AddConstant('CTL_E_TOOMANYFILES',CTL_E_TOOMANYFILES);
    AddConstant('CTL_E_DEVICEUNAVAILABLE',CTL_E_DEVICEUNAVAILABLE);
    AddConstant('CTL_E_PERMISSIONDENIED',CTL_E_PERMISSIONDENIED);
    AddConstant('CTL_E_DISKNOTREADY',CTL_E_DISKNOTREADY);
    AddConstant('CTL_E_PATHFILEACCESSERROR',CTL_E_PATHFILEACCESSERROR);
    AddConstant('CTL_E_PATHNOTFOUND',CTL_E_PATHNOTFOUND);
    AddConstant('CTL_E_INVALIDPATTERNSTRING',CTL_E_INVALIDPATTERNSTRING);
    AddConstant('CTL_E_INVALIDUSEOFNULL',CTL_E_INVALIDUSEOFNULL);
    AddConstant('CTL_E_INVALIDFILEFORMAT',CTL_E_INVALIDFILEFORMAT);
    AddConstant('CTL_E_INVALIDPROPERTYVALUE',CTL_E_INVALIDPROPERTYVALUE);
    AddConstant('CTL_E_INVALIDPROPERTYARRAYINDEX',CTL_E_INVALIDPROPERTYARRAYINDEX);
    AddConstant('CTL_E_SETNOTSUPPORTEDATRUNTIME',CTL_E_SETNOTSUPPORTEDATRUNTIME);
    AddConstant('CTL_E_SETNOTSUPPORTED',CTL_E_SETNOTSUPPORTED);
    AddConstant('CTL_E_NEEDPROPERTYARRAYINDEX',CTL_E_NEEDPROPERTYARRAYINDEX);
    AddConstant('CTL_E_SETNOTPERMITTED',CTL_E_SETNOTPERMITTED);
    AddConstant('CTL_E_GETNOTSUPPORTEDATRUNTIME',CTL_E_GETNOTSUPPORTEDATRUNTIME);
    AddConstant('CTL_E_GETNOTSUPPORTED',CTL_E_GETNOTSUPPORTED);
    AddConstant('CTL_E_PROPERTYNOTFOUND',CTL_E_PROPERTYNOTFOUND);
    AddConstant('CTL_E_INVALIDCLIPBOARDFORMAT',CTL_E_INVALIDCLIPBOARDFORMAT);
    AddConstant('CTL_E_INVALIDPICTURE',CTL_E_INVALIDPICTURE);
    AddConstant('CTL_E_PRINTERERROR',CTL_E_PRINTERERROR);
    AddConstant('CTL_E_CANTSAVEFILETOTEMP',CTL_E_CANTSAVEFILETOTEMP);
    AddConstant('CTL_E_SEARCHTEXTNOTFOUND',CTL_E_SEARCHTEXTNOTFOUND);
    AddConstant('CTL_E_REPLACEMENTSTOOLONG',CTL_E_REPLACEMENTSTOOLONG);
    AddConstant('CTL_E_CUSTOM_FIRST',CTL_E_CUSTOM_FIRST);
    AddConstant('CLASS_E_NOTLICENSED',CLASS_E_NOTLICENSED);
    AddConstant('CONNECT_E_FIRST',CONNECT_E_FIRST);
    AddConstant('CONNECT_E_LAST',CONNECT_E_LAST);
    AddConstant('CONNECT_S_FIRST',CONNECT_S_FIRST);
    AddConstant('CONNECT_S_LAST',CONNECT_S_LAST);
    AddConstant('CONNECT_E_NOCONNECTION',CONNECT_E_NOCONNECTION);
    AddConstant('CONNECT_E_ADVISELIMIT',CONNECT_E_ADVISELIMIT);
    AddConstant('CONNECT_E_CANNOTCONNECT',CONNECT_E_CANNOTCONNECT);
    AddConstant('CONNECT_E_OVERRIDDEN',CONNECT_E_OVERRIDDEN);
    AddConstant('SELFREG_E_FIRST',SELFREG_E_FIRST);
    AddConstant('SELFREG_E_LAST',SELFREG_E_LAST);
    AddConstant('SELFREG_S_FIRST',SELFREG_S_FIRST);
    AddConstant('SELFREG_S_LAST',SELFREG_S_LAST);
    AddConstant('SELFREG_E_TYPELIB',SELFREG_E_TYPELIB);
    AddConstant('SELFREG_E_CLASS',SELFREG_E_CLASS);
    AddConstant('PERPROP_E_FIRST',PERPROP_E_FIRST);
    AddConstant('PERPROP_E_LAST',PERPROP_E_LAST);
    AddConstant('PERPROP_S_FIRST',PERPROP_S_FIRST);
    AddConstant('PERPROP_S_LAST',PERPROP_S_LAST);
    AddConstant('PERPROP_E_NOPAGEAVAILABLE',PERPROP_E_NOPAGEAVAILABLE);
    AddConstant('OLEMISC_INVISIBLEATRUNTIME',OLEMISC_INVISIBLEATRUNTIME);
    AddConstant('OLEMISC_ALWAYSRUN',OLEMISC_ALWAYSRUN);
    AddConstant('OLEMISC_ACTSLIKEBUTTON',OLEMISC_ACTSLIKEBUTTON);
    AddConstant('OLEMISC_ACTSLIKELABEL',OLEMISC_ACTSLIKELABEL);
    AddConstant('OLEMISC_NOUIACTIVATE',OLEMISC_NOUIACTIVATE);
    AddConstant('OLEMISC_ALIGNABLE',OLEMISC_ALIGNABLE);
    AddConstant('OLEMISC_SIMPLEFRAME',OLEMISC_SIMPLEFRAME);
    AddConstant('OLEMISC_SETCLIENTSITEFIRST',OLEMISC_SETCLIENTSITEFIRST);
    AddConstant('OLEMISC_IMEMODE',OLEMISC_IMEMODE);
    AddConstant('OLEIVERB_PROPERTIES',OLEIVERB_PROPERTIES);
    AddConstant('VT_STREAMED_PROPSET',VT_STREAMED_PROPSET);
    AddConstant('VT_STORED_PROPSET',VT_STORED_PROPSET);
    AddConstant('VT_BLOB_PROPSET',VT_BLOB_PROPSET);
    AddConstant('VT_COLOR',VT_COLOR);
    AddConstant('VT_XPOS_PIXELS',VT_XPOS_PIXELS);
    AddConstant('VT_YPOS_PIXELS',VT_YPOS_PIXELS);
    AddConstant('VT_XSIZE_PIXELS',VT_XSIZE_PIXELS);
    AddConstant('VT_YSIZE_PIXELS',VT_YSIZE_PIXELS);
    AddConstant('VT_XPOS_HIMETRIC',VT_XPOS_HIMETRIC);
    AddConstant('VT_YPOS_HIMETRIC',VT_YPOS_HIMETRIC);
    AddConstant('VT_XSIZE_HIMETRIC',VT_XSIZE_HIMETRIC);
    AddConstant('VT_YSIZE_HIMETRIC',VT_YSIZE_HIMETRIC);
    AddConstant('VT_TRISTATE',VT_TRISTATE);
    AddConstant('VT_OPTEXCLUSIVE',VT_OPTEXCLUSIVE);
    AddConstant('VT_FONT',VT_FONT);
    AddConstant('VT_PICTURE',VT_PICTURE);
    AddConstant('VT_HANDLE',VT_HANDLE);
    AddConstant('OCM__BASE',OCM__BASE);
    AddConstant('OCM_COMMAND',OCM_COMMAND);
    AddConstant('OCM_CTLCOLORBTN',OCM_CTLCOLORBTN);
    AddConstant('OCM_CTLCOLOREDIT',OCM_CTLCOLOREDIT);
    AddConstant('OCM_CTLCOLORDLG',OCM_CTLCOLORDLG);
    AddConstant('OCM_CTLCOLORLISTBOX',OCM_CTLCOLORLISTBOX);
    AddConstant('OCM_CTLCOLORMSGBOX',OCM_CTLCOLORMSGBOX);
    AddConstant('OCM_CTLCOLORSCROLLBAR',OCM_CTLCOLORSCROLLBAR);
    AddConstant('OCM_CTLCOLORSTATIC',OCM_CTLCOLORSTATIC);
    AddConstant('OCM_DRAWITEM',OCM_DRAWITEM);
    AddConstant('OCM_MEASUREITEM',OCM_MEASUREITEM);
    AddConstant('OCM_DELETEITEM',OCM_DELETEITEM);
    AddConstant('OCM_VKEYTOITEM',OCM_VKEYTOITEM);
    AddConstant('OCM_CHARTOITEM',OCM_CHARTOITEM);
    AddConstant('OCM_COMPAREITEM',OCM_COMPAREITEM);
    AddConstant('OCM_HSCROLL',OCM_HSCROLL);
    AddConstant('OCM_VSCROLL',OCM_VSCROLL);
    AddConstant('OCM_PARENTNOTIFY',OCM_PARENTNOTIFY);
    AddConstant('CTRLINFO_EATS_RETURN',CTRLINFO_EATS_RETURN);
    AddConstant('CTRLINFO_EATS_ESCAPE',CTRLINFO_EATS_ESCAPE);
    AddConstant('XFORMCOORDS_POSITION',XFORMCOORDS_POSITION);
    AddConstant('XFORMCOORDS_SIZE',XFORMCOORDS_SIZE);
    AddConstant('XFORMCOORDS_HIMETRICTOCONTAINER',XFORMCOORDS_HIMETRICTOCONTAINER);
    AddConstant('XFORMCOORDS_CONTAINERTOHIMETRIC',XFORMCOORDS_CONTAINERTOHIMETRIC);
    AddConstant('PROPPAGESTATUS_DIRTY',PROPPAGESTATUS_DIRTY);
    AddConstant('PROPPAGESTATUS_VALIDATE',PROPPAGESTATUS_VALIDATE);
    AddConstant('PICTURE_SCALABLE',PICTURE_SCALABLE);
    AddConstant('PICTURE_TRANSPARENT',PICTURE_TRANSPARENT);
    AddConstant('PICTYPE_UNINITIALIZED',PICTYPE_UNINITIALIZED);
    AddConstant('PICTYPE_NONE',PICTYPE_NONE);
    AddConstant('PICTYPE_BITMAP',PICTYPE_BITMAP);
    AddConstant('PICTYPE_METAFILE',PICTYPE_METAFILE);
    AddConstant('PICTYPE_ICON',PICTYPE_ICON);
    AddConstant('PICTYPE_ENHMETAFILE',PICTYPE_ENHMETAFILE);
    AddConstant('DISPID_AUTOSIZE',DISPID_AUTOSIZE);
    AddConstant('DISPID_BACKCOLOR',DISPID_BACKCOLOR);
    AddConstant('DISPID_BACKSTYLE',DISPID_BACKSTYLE);
    AddConstant('DISPID_BORDERCOLOR',DISPID_BORDERCOLOR);
    AddConstant('DISPID_BORDERSTYLE',DISPID_BORDERSTYLE);
    AddConstant('DISPID_BORDERWIDTH',DISPID_BORDERWIDTH);
    AddConstant('DISPID_DRAWMODE',DISPID_DRAWMODE);
    AddConstant('DISPID_DRAWSTYLE',DISPID_DRAWSTYLE);
    AddConstant('DISPID_DRAWWIDTH',DISPID_DRAWWIDTH);
    AddConstant('DISPID_FILLCOLOR',DISPID_FILLCOLOR);
    AddConstant('DISPID_FILLSTYLE',DISPID_FILLSTYLE);
    AddConstant('DISPID_FONT',DISPID_FONT);
    AddConstant('DISPID_FORECOLOR',DISPID_FORECOLOR);
    AddConstant('DISPID_ENABLED',DISPID_ENABLED);
    AddConstant('DISPID_HWND',DISPID_HWND);
    AddConstant('DISPID_TABSTOP',DISPID_TABSTOP);
    AddConstant('DISPID_TEXT',DISPID_TEXT);
    AddConstant('DISPID_CAPTION',DISPID_CAPTION);
    AddConstant('DISPID_BORDERVISIBLE',DISPID_BORDERVISIBLE);
    AddConstant('DISPID_REFRESH',DISPID_REFRESH);
    AddConstant('DISPID_DOCLICK',DISPID_DOCLICK);
    AddConstant('DISPID_ABOUTBOX',DISPID_ABOUTBOX);
    AddConstant('DISPID_CLICK',DISPID_CLICK);
    AddConstant('DISPID_DBLCLICK',DISPID_DBLCLICK);
    AddConstant('DISPID_KEYDOWN',DISPID_KEYDOWN);
    AddConstant('DISPID_KEYPRESS',DISPID_KEYPRESS);
    AddConstant('DISPID_KEYUP',DISPID_KEYUP);
    AddConstant('DISPID_MOUSEDOWN',DISPID_MOUSEDOWN);
    AddConstant('DISPID_MOUSEMOVE',DISPID_MOUSEMOVE);
    AddConstant('DISPID_MOUSEUP',DISPID_MOUSEUP);
    AddConstant('DISPID_ERROREVENT',DISPID_ERROREVENT);
    AddConstant('DISPID_AMBIENT_BACKCOLOR',DISPID_AMBIENT_BACKCOLOR);
    AddConstant('DISPID_AMBIENT_DISPLAYNAME',DISPID_AMBIENT_DISPLAYNAME);
    AddConstant('DISPID_AMBIENT_FONT',DISPID_AMBIENT_FONT);
    AddConstant('DISPID_AMBIENT_FORECOLOR',DISPID_AMBIENT_FORECOLOR);
    AddConstant('DISPID_AMBIENT_LOCALEID',DISPID_AMBIENT_LOCALEID);
    AddConstant('DISPID_AMBIENT_MESSAGEREFLECT',DISPID_AMBIENT_MESSAGEREFLECT);
    AddConstant('DISPID_AMBIENT_SCALEUNITS',DISPID_AMBIENT_SCALEUNITS);
    AddConstant('DISPID_AMBIENT_TEXTALIGN',DISPID_AMBIENT_TEXTALIGN);
    AddConstant('DISPID_AMBIENT_USERMODE',DISPID_AMBIENT_USERMODE);
    AddConstant('DISPID_AMBIENT_UIDEAD',DISPID_AMBIENT_UIDEAD);
    AddConstant('DISPID_AMBIENT_SHOWGRABHANDLES',DISPID_AMBIENT_SHOWGRABHANDLES);
    AddConstant('DISPID_AMBIENT_SHOWHATCHING',DISPID_AMBIENT_SHOWHATCHING);
    AddConstant('DISPID_AMBIENT_DISPLAYASDEFAULT',DISPID_AMBIENT_DISPLAYASDEFAULT);
    AddConstant('DISPID_AMBIENT_SUPPORTSMNEMONICS',DISPID_AMBIENT_SUPPORTSMNEMONICS);
    AddConstant('DISPID_AMBIENT_AUTOCLIP',DISPID_AMBIENT_AUTOCLIP);
    AddConstant('DISPID_FONT_NAME',DISPID_FONT_NAME);
    AddConstant('DISPID_FONT_SIZE',DISPID_FONT_SIZE);
    AddConstant('DISPID_FONT_BOLD',DISPID_FONT_BOLD);
    AddConstant('DISPID_FONT_ITALIC',DISPID_FONT_ITALIC);
    AddConstant('DISPID_FONT_UNDER',DISPID_FONT_UNDER);
    AddConstant('DISPID_FONT_STRIKE',DISPID_FONT_STRIKE);
    AddConstant('DISPID_FONT_WEIGHT',DISPID_FONT_WEIGHT);
    AddConstant('DISPID_FONT_CHARSET',DISPID_FONT_CHARSET);
    AddConstant('DISPID_PICT_HANDLE',DISPID_PICT_HANDLE);
    AddConstant('DISPID_PICT_HPAL',DISPID_PICT_HPAL);
    AddConstant('DISPID_PICT_TYPE',DISPID_PICT_TYPE);
    AddConstant('DISPID_PICT_WIDTH',DISPID_PICT_WIDTH);
    AddConstant('DISPID_PICT_HEIGHT',DISPID_PICT_HEIGHT);
    AddConstant('DISPID_PICT_RENDER',DISPID_PICT_RENDER);
  end;
end;

class function TatOleCtlLibrary.LibraryName: string;
begin
  result := 'OleCtl';
end;

initialization
  RegisterScripterLibrary(TatOleCtlLibrary, True);

{$WARNINGS ON}

end.

