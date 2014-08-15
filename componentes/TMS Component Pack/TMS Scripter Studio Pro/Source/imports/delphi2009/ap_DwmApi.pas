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
unit ap_DwmApi;

interface

uses
  Windows,
  Uxtheme,
  DwmApi,
  Variants,
  ap_UxTheme,
  atScript;

{$WARNINGS OFF}

type
  TatDwmApiLibrary = class(TatScripterLibrary)
    procedure __DwmDefWindowProc(AMachine: TatVirtualMachine);
    procedure __DwmEnableBlurBehindWindow(AMachine: TatVirtualMachine);
    procedure __DwmEnableComposition(AMachine: TatVirtualMachine);
    procedure __DwmEnableMMCSS(AMachine: TatVirtualMachine);
    procedure __DwmExtendFrameIntoClientArea(AMachine: TatVirtualMachine);
    procedure __DwmGetColorizationColor(AMachine: TatVirtualMachine);
    procedure __DwmGetCompositionTimingInfo(AMachine: TatVirtualMachine);
    procedure __DwmIsCompositionEnabled(AMachine: TatVirtualMachine);
    procedure __DwmModifyPreviousDxFrameDuration(AMachine: TatVirtualMachine);
    procedure __DwmRegisterThumbnail(AMachine: TatVirtualMachine);
    procedure __DwmSetDxFrameDuration(AMachine: TatVirtualMachine);
    procedure __DwmSetPresentParameters(AMachine: TatVirtualMachine);
    procedure __DwmUnregisterThumbnail(AMachine: TatVirtualMachine);
    procedure __DwmUpdateThumbnailProperties(AMachine: TatVirtualMachine);
    procedure __DwmCompositionEnabled(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  DWM_BLURBEHINDWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FfEnable: BOOL;
    FhRgnBlur: HRGN;
    FfTransitionOnMaximized: BOOL;
  public
    constructor Create(ARecord: DWM_BLURBEHIND);
    function ObjToRec: DWM_BLURBEHIND;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property fEnable: BOOL read FfEnable write FfEnable;
    property hRgnBlur: HRGN read FhRgnBlur write FhRgnBlur;
    property fTransitionOnMaximized: BOOL read FfTransitionOnMaximized write FfTransitionOnMaximized;
  end;
  
  DWM_THUMBNAIL_PROPERTIESWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    Fopacity: Byte;
    FfVisible: BOOL;
    FfSourceClientAreaOnly: BOOL;
  public
    constructor Create(ARecord: DWM_THUMBNAIL_PROPERTIES);
    function ObjToRec: DWM_THUMBNAIL_PROPERTIES;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property opacity: Byte read Fopacity write Fopacity;
    property fVisible: BOOL read FfVisible write FfVisible;
    property fSourceClientAreaOnly: BOOL read FfSourceClientAreaOnly write FfSourceClientAreaOnly;
  end;
  
  UNSIGNED_RATIOWrapper = class(TatRecordWrapper)
  private
    FuiNumerator: Cardinal;
    FuiDenominator: Cardinal;
  public
    constructor Create(ARecord: UNSIGNED_RATIO);
    function ObjToRec: UNSIGNED_RATIO;
  published
    property uiNumerator: Cardinal read FuiNumerator write FuiNumerator;
    property uiDenominator: Cardinal read FuiDenominator write FuiDenominator;
  end;
  
  DWM_TIMING_INFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: Cardinal;
    FqpcRefreshPeriod: QPC_TIME;
    FqpcVBlank: QPC_TIME;
    FcRefresh: DWM_FRAME_COUNT;
    FcDXRefresh: UINT;
    FqpcCompose: QPC_TIME;
    FcFrame: DWM_FRAME_COUNT;
    FcDXPresent: UINT;
    FcRefreshFrame: DWM_FRAME_COUNT;
    FcFrameSubmitted: DWM_FRAME_COUNT;
    FcDXPresentSubmitted: UINT;
    FcFrameConfirmed: DWM_FRAME_COUNT;
    FcDXPresentConfirmed: UINT;
    FcRefreshConfirmed: DWM_FRAME_COUNT;
    FcDXRefreshConfirmed: UINT;
    FcFramesLate: DWM_FRAME_COUNT;
    FcFramesOutstanding: UINT;
    FcFrameDisplayed: DWM_FRAME_COUNT;
    FqpcFrameDisplayed: QPC_TIME;
    FcRefreshFrameDisplayed: DWM_FRAME_COUNT;
    FcFrameComplete: DWM_FRAME_COUNT;
    FqpcFrameComplete: QPC_TIME;
    FcFramePending: DWM_FRAME_COUNT;
    FqpcFramePending: QPC_TIME;
    FcFramesDisplayed: DWM_FRAME_COUNT;
    FcFramesComplete: DWM_FRAME_COUNT;
    FcFramesPending: DWM_FRAME_COUNT;
    FcFramesAvailable: DWM_FRAME_COUNT;
    FcFramesDropped: DWM_FRAME_COUNT;
    FcFramesMissed: DWM_FRAME_COUNT;
    FcRefreshNextDisplayed: DWM_FRAME_COUNT;
    FcRefreshNextPresented: DWM_FRAME_COUNT;
    FcRefreshesDisplayed: DWM_FRAME_COUNT;
    FcRefreshesPresented: DWM_FRAME_COUNT;
    FcRefreshStarted: DWM_FRAME_COUNT;
    FcPixelsReceived: ULONGLONG;
    FcPixelsDrawn: ULONGLONG;
    FcBuffersEmpty: DWM_FRAME_COUNT;
  public
    constructor Create(ARecord: DWM_TIMING_INFO);
    function ObjToRec: DWM_TIMING_INFO;
  published
    property cbSize: Cardinal read FcbSize write FcbSize;
    property qpcRefreshPeriod: QPC_TIME read FqpcRefreshPeriod write FqpcRefreshPeriod;
    property qpcVBlank: QPC_TIME read FqpcVBlank write FqpcVBlank;
    property cRefresh: DWM_FRAME_COUNT read FcRefresh write FcRefresh;
    property cDXRefresh: UINT read FcDXRefresh write FcDXRefresh;
    property qpcCompose: QPC_TIME read FqpcCompose write FqpcCompose;
    property cFrame: DWM_FRAME_COUNT read FcFrame write FcFrame;
    property cDXPresent: UINT read FcDXPresent write FcDXPresent;
    property cRefreshFrame: DWM_FRAME_COUNT read FcRefreshFrame write FcRefreshFrame;
    property cFrameSubmitted: DWM_FRAME_COUNT read FcFrameSubmitted write FcFrameSubmitted;
    property cDXPresentSubmitted: UINT read FcDXPresentSubmitted write FcDXPresentSubmitted;
    property cFrameConfirmed: DWM_FRAME_COUNT read FcFrameConfirmed write FcFrameConfirmed;
    property cDXPresentConfirmed: UINT read FcDXPresentConfirmed write FcDXPresentConfirmed;
    property cRefreshConfirmed: DWM_FRAME_COUNT read FcRefreshConfirmed write FcRefreshConfirmed;
    property cDXRefreshConfirmed: UINT read FcDXRefreshConfirmed write FcDXRefreshConfirmed;
    property cFramesLate: DWM_FRAME_COUNT read FcFramesLate write FcFramesLate;
    property cFramesOutstanding: UINT read FcFramesOutstanding write FcFramesOutstanding;
    property cFrameDisplayed: DWM_FRAME_COUNT read FcFrameDisplayed write FcFrameDisplayed;
    property qpcFrameDisplayed: QPC_TIME read FqpcFrameDisplayed write FqpcFrameDisplayed;
    property cRefreshFrameDisplayed: DWM_FRAME_COUNT read FcRefreshFrameDisplayed write FcRefreshFrameDisplayed;
    property cFrameComplete: DWM_FRAME_COUNT read FcFrameComplete write FcFrameComplete;
    property qpcFrameComplete: QPC_TIME read FqpcFrameComplete write FqpcFrameComplete;
    property cFramePending: DWM_FRAME_COUNT read FcFramePending write FcFramePending;
    property qpcFramePending: QPC_TIME read FqpcFramePending write FqpcFramePending;
    property cFramesDisplayed: DWM_FRAME_COUNT read FcFramesDisplayed write FcFramesDisplayed;
    property cFramesComplete: DWM_FRAME_COUNT read FcFramesComplete write FcFramesComplete;
    property cFramesPending: DWM_FRAME_COUNT read FcFramesPending write FcFramesPending;
    property cFramesAvailable: DWM_FRAME_COUNT read FcFramesAvailable write FcFramesAvailable;
    property cFramesDropped: DWM_FRAME_COUNT read FcFramesDropped write FcFramesDropped;
    property cFramesMissed: DWM_FRAME_COUNT read FcFramesMissed write FcFramesMissed;
    property cRefreshNextDisplayed: DWM_FRAME_COUNT read FcRefreshNextDisplayed write FcRefreshNextDisplayed;
    property cRefreshNextPresented: DWM_FRAME_COUNT read FcRefreshNextPresented write FcRefreshNextPresented;
    property cRefreshesDisplayed: DWM_FRAME_COUNT read FcRefreshesDisplayed write FcRefreshesDisplayed;
    property cRefreshesPresented: DWM_FRAME_COUNT read FcRefreshesPresented write FcRefreshesPresented;
    property cRefreshStarted: DWM_FRAME_COUNT read FcRefreshStarted write FcRefreshStarted;
    property cPixelsReceived: ULONGLONG read FcPixelsReceived write FcPixelsReceived;
    property cPixelsDrawn: ULONGLONG read FcPixelsDrawn write FcPixelsDrawn;
    property cBuffersEmpty: DWM_FRAME_COUNT read FcBuffersEmpty write FcBuffersEmpty;
  end;
  
  DWM_PRESENT_PARAMETERSWrapper = class(TatRecordWrapper)
  private
    FcbSize: Cardinal;
    FfQueue: BOOL;
    FcRefreshStart: DWM_FRAME_COUNT;
    FcBuffer: UINT;
    FfUseSourceRate: BOOL;
    FcRefreshesPerFrame: UINT;
    FeSampling: UINT;
  public
    constructor Create(ARecord: DWM_PRESENT_PARAMETERS);
    function ObjToRec: DWM_PRESENT_PARAMETERS;
  published
    property cbSize: Cardinal read FcbSize write FcbSize;
    property fQueue: BOOL read FfQueue write FfQueue;
    property cRefreshStart: DWM_FRAME_COUNT read FcRefreshStart write FcRefreshStart;
    property cBuffer: UINT read FcBuffer write FcBuffer;
    property fUseSourceRate: BOOL read FfUseSourceRate write FfUseSourceRate;
    property cRefreshesPerFrame: UINT read FcRefreshesPerFrame write FcRefreshesPerFrame;
    property eSampling: UINT read FeSampling write FeSampling;
  end;
  

implementation

constructor DWM_BLURBEHINDWrapper.Create(ARecord: DWM_BLURBEHIND);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FfEnable := ARecord.fEnable;
  FhRgnBlur := ARecord.hRgnBlur;
  FfTransitionOnMaximized := ARecord.fTransitionOnMaximized;
end;

function DWM_BLURBEHINDWrapper.ObjToRec: DWM_BLURBEHIND;
begin
  result.dwFlags := FdwFlags;
  result.fEnable := FfEnable;
  result.hRgnBlur := FhRgnBlur;
  result.fTransitionOnMaximized := FfTransitionOnMaximized;
end;

constructor DWM_THUMBNAIL_PROPERTIESWrapper.Create(ARecord: DWM_THUMBNAIL_PROPERTIES);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  Fopacity := ARecord.opacity;
  FfVisible := ARecord.fVisible;
  FfSourceClientAreaOnly := ARecord.fSourceClientAreaOnly;
end;

function DWM_THUMBNAIL_PROPERTIESWrapper.ObjToRec: DWM_THUMBNAIL_PROPERTIES;
begin
  result.dwFlags := FdwFlags;
  result.opacity := Fopacity;
  result.fVisible := FfVisible;
  result.fSourceClientAreaOnly := FfSourceClientAreaOnly;
end;

constructor UNSIGNED_RATIOWrapper.Create(ARecord: UNSIGNED_RATIO);
begin
  inherited Create;
  FuiNumerator := ARecord.uiNumerator;
  FuiDenominator := ARecord.uiDenominator;
end;

function UNSIGNED_RATIOWrapper.ObjToRec: UNSIGNED_RATIO;
begin
  result.uiNumerator := FuiNumerator;
  result.uiDenominator := FuiDenominator;
end;

constructor DWM_TIMING_INFOWrapper.Create(ARecord: DWM_TIMING_INFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FqpcRefreshPeriod := ARecord.qpcRefreshPeriod;
  FqpcVBlank := ARecord.qpcVBlank;
  FcRefresh := ARecord.cRefresh;
  FcDXRefresh := ARecord.cDXRefresh;
  FqpcCompose := ARecord.qpcCompose;
  FcFrame := ARecord.cFrame;
  FcDXPresent := ARecord.cDXPresent;
  FcRefreshFrame := ARecord.cRefreshFrame;
  FcFrameSubmitted := ARecord.cFrameSubmitted;
  FcDXPresentSubmitted := ARecord.cDXPresentSubmitted;
  FcFrameConfirmed := ARecord.cFrameConfirmed;
  FcDXPresentConfirmed := ARecord.cDXPresentConfirmed;
  FcRefreshConfirmed := ARecord.cRefreshConfirmed;
  FcDXRefreshConfirmed := ARecord.cDXRefreshConfirmed;
  FcFramesLate := ARecord.cFramesLate;
  FcFramesOutstanding := ARecord.cFramesOutstanding;
  FcFrameDisplayed := ARecord.cFrameDisplayed;
  FqpcFrameDisplayed := ARecord.qpcFrameDisplayed;
  FcRefreshFrameDisplayed := ARecord.cRefreshFrameDisplayed;
  FcFrameComplete := ARecord.cFrameComplete;
  FqpcFrameComplete := ARecord.qpcFrameComplete;
  FcFramePending := ARecord.cFramePending;
  FqpcFramePending := ARecord.qpcFramePending;
  FcFramesDisplayed := ARecord.cFramesDisplayed;
  FcFramesComplete := ARecord.cFramesComplete;
  FcFramesPending := ARecord.cFramesPending;
  FcFramesAvailable := ARecord.cFramesAvailable;
  FcFramesDropped := ARecord.cFramesDropped;
  FcFramesMissed := ARecord.cFramesMissed;
  FcRefreshNextDisplayed := ARecord.cRefreshNextDisplayed;
  FcRefreshNextPresented := ARecord.cRefreshNextPresented;
  FcRefreshesDisplayed := ARecord.cRefreshesDisplayed;
  FcRefreshesPresented := ARecord.cRefreshesPresented;
  FcRefreshStarted := ARecord.cRefreshStarted;
  FcPixelsReceived := ARecord.cPixelsReceived;
  FcPixelsDrawn := ARecord.cPixelsDrawn;
  FcBuffersEmpty := ARecord.cBuffersEmpty;
end;

function DWM_TIMING_INFOWrapper.ObjToRec: DWM_TIMING_INFO;
begin
  result.cbSize := FcbSize;
  result.qpcRefreshPeriod := FqpcRefreshPeriod;
  result.qpcVBlank := FqpcVBlank;
  result.cRefresh := FcRefresh;
  result.cDXRefresh := FcDXRefresh;
  result.qpcCompose := FqpcCompose;
  result.cFrame := FcFrame;
  result.cDXPresent := FcDXPresent;
  result.cRefreshFrame := FcRefreshFrame;
  result.cFrameSubmitted := FcFrameSubmitted;
  result.cDXPresentSubmitted := FcDXPresentSubmitted;
  result.cFrameConfirmed := FcFrameConfirmed;
  result.cDXPresentConfirmed := FcDXPresentConfirmed;
  result.cRefreshConfirmed := FcRefreshConfirmed;
  result.cDXRefreshConfirmed := FcDXRefreshConfirmed;
  result.cFramesLate := FcFramesLate;
  result.cFramesOutstanding := FcFramesOutstanding;
  result.cFrameDisplayed := FcFrameDisplayed;
  result.qpcFrameDisplayed := FqpcFrameDisplayed;
  result.cRefreshFrameDisplayed := FcRefreshFrameDisplayed;
  result.cFrameComplete := FcFrameComplete;
  result.qpcFrameComplete := FqpcFrameComplete;
  result.cFramePending := FcFramePending;
  result.qpcFramePending := FqpcFramePending;
  result.cFramesDisplayed := FcFramesDisplayed;
  result.cFramesComplete := FcFramesComplete;
  result.cFramesPending := FcFramesPending;
  result.cFramesAvailable := FcFramesAvailable;
  result.cFramesDropped := FcFramesDropped;
  result.cFramesMissed := FcFramesMissed;
  result.cRefreshNextDisplayed := FcRefreshNextDisplayed;
  result.cRefreshNextPresented := FcRefreshNextPresented;
  result.cRefreshesDisplayed := FcRefreshesDisplayed;
  result.cRefreshesPresented := FcRefreshesPresented;
  result.cRefreshStarted := FcRefreshStarted;
  result.cPixelsReceived := FcPixelsReceived;
  result.cPixelsDrawn := FcPixelsDrawn;
  result.cBuffersEmpty := FcBuffersEmpty;
end;

constructor DWM_PRESENT_PARAMETERSWrapper.Create(ARecord: DWM_PRESENT_PARAMETERS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfQueue := ARecord.fQueue;
  FcRefreshStart := ARecord.cRefreshStart;
  FcBuffer := ARecord.cBuffer;
  FfUseSourceRate := ARecord.fUseSourceRate;
  FcRefreshesPerFrame := ARecord.cRefreshesPerFrame;
  FeSampling := ARecord.eSampling;
end;

function DWM_PRESENT_PARAMETERSWrapper.ObjToRec: DWM_PRESENT_PARAMETERS;
begin
  result.cbSize := FcbSize;
  result.fQueue := FfQueue;
  result.cRefreshStart := FcRefreshStart;
  result.cBuffer := FcBuffer;
  result.fUseSourceRate := FfUseSourceRate;
  result.cRefreshesPerFrame := FcRefreshesPerFrame;
  result.eSampling := FeSampling;
end;



procedure TatDwmApiLibrary.__DwmDefWindowProc(AMachine: TatVirtualMachine);
  var
  Param4: LRESULT;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
AResult := DwmApi.DwmDefWindowProc(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4);
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatDwmApiLibrary.__DwmEnableBlurBehindWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DwmApi.DwmEnableBlurBehindWindow(VarToInteger(GetInputArg(0)),DWM_BLURBEHINDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.__DwmEnableComposition(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DwmApi.DwmEnableComposition(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.__DwmEnableMMCSS(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DwmApi.DwmEnableMMCSS(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.__DwmExtendFrameIntoClientArea(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DwmApi.DwmExtendFrameIntoClientArea(VarToInteger(GetInputArg(0)),_MARGINSWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.__DwmGetColorizationColor(AMachine: TatVirtualMachine);
  var
  Param0: DWORD;
  Param1: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param1 := GetInputArg(1);
AResult := Integer(DwmApi.DwmGetColorizationColor(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Param1);
  end;
end;

procedure TatDwmApiLibrary.__DwmGetCompositionTimingInfo(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TDWMTimingInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is DWM_TIMING_INFOWrapper) then 
  Param1Rec := DWM_TIMING_INFOWrapper.Create(Param1);
Param1 := DWM_TIMING_INFOWrapper(Param1Rec).ObjToRec;
AResult := Integer(DwmApi.DwmGetCompositionTimingInfo(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(DWM_TIMING_INFOWrapper.Create(Param1)));
  end;
end;

procedure TatDwmApiLibrary.__DwmIsCompositionEnabled(AMachine: TatVirtualMachine);
  var
  Param0: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(DwmApi.DwmIsCompositionEnabled(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDwmApiLibrary.__DwmModifyPreviousDxFrameDuration(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DwmApi.DwmModifyPreviousDxFrameDuration(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.__DwmRegisterThumbnail(AMachine: TatVirtualMachine);
  var
  Param2: HTHUMBNAIL;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(DwmApi.DwmRegisterThumbnail(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatDwmApiLibrary.__DwmSetDxFrameDuration(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DwmApi.DwmSetDxFrameDuration(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.__DwmSetPresentParameters(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TDWMPresentParameters;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is DWM_PRESENT_PARAMETERSWrapper) then 
  Param1Rec := DWM_PRESENT_PARAMETERSWrapper.Create(Param1);
Param1 := DWM_PRESENT_PARAMETERSWrapper(Param1Rec).ObjToRec;
AResult := Integer(DwmApi.DwmSetPresentParameters(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(DWM_PRESENT_PARAMETERSWrapper.Create(Param1)));
  end;
end;

procedure TatDwmApiLibrary.__DwmUnregisterThumbnail(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DwmApi.DwmUnregisterThumbnail(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.__DwmUpdateThumbnailProperties(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DwmApi.DwmUpdateThumbnailProperties(VarToInteger(GetInputArg(0)),DWM_THUMBNAIL_PROPERTIESWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.__DwmCompositionEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DwmApi.DwmCompositionEnabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDwmApiLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DwmDefWindowProc',5,tkVariant,nil,__DwmDefWindowProc,false,0).SetVarArgs([4]);
    DefineMethod('DwmEnableBlurBehindWindow',2,tkInteger,nil,__DwmEnableBlurBehindWindow,false,0);
    DefineMethod('DwmEnableComposition',1,tkInteger,nil,__DwmEnableComposition,false,0);
    DefineMethod('DwmEnableMMCSS',1,tkInteger,nil,__DwmEnableMMCSS,false,0);
    DefineMethod('DwmExtendFrameIntoClientArea',2,tkInteger,nil,__DwmExtendFrameIntoClientArea,false,0);
    DefineMethod('DwmGetColorizationColor',2,tkInteger,nil,__DwmGetColorizationColor,false,0).SetVarArgs([0,1]);
    DefineMethod('DwmGetCompositionTimingInfo',2,tkInteger,nil,__DwmGetCompositionTimingInfo,false,0).SetVarArgs([1]);
    DefineMethod('DwmIsCompositionEnabled',1,tkInteger,nil,__DwmIsCompositionEnabled,false,0).SetVarArgs([0]);
    DefineMethod('DwmModifyPreviousDxFrameDuration',3,tkInteger,nil,__DwmModifyPreviousDxFrameDuration,false,0);
    DefineMethod('DwmRegisterThumbnail',3,tkInteger,nil,__DwmRegisterThumbnail,false,0).SetVarArgs([2]);
    DefineMethod('DwmSetDxFrameDuration',2,tkInteger,nil,__DwmSetDxFrameDuration,false,0);
    DefineMethod('DwmSetPresentParameters',2,tkInteger,nil,__DwmSetPresentParameters,false,0).SetVarArgs([1]);
    DefineMethod('DwmUnregisterThumbnail',1,tkInteger,nil,__DwmUnregisterThumbnail,false,0);
    DefineMethod('DwmUpdateThumbnailProperties',2,tkInteger,nil,__DwmUpdateThumbnailProperties,false,0);
    DefineMethod('DwmCompositionEnabled',0,tkVariant,nil,__DwmCompositionEnabled,false,0);
    AddConstant('DWM_BB_ENABLE',DWM_BB_ENABLE);
    AddConstant('DWM_BB_BLURREGION',DWM_BB_BLURREGION);
    AddConstant('DWM_BB_TRANSITIONONMAXIMIZED',DWM_BB_TRANSITIONONMAXIMIZED);
    AddConstant('DWMWA_NCRENDERING_ENABLED',DWMWA_NCRENDERING_ENABLED);
    AddConstant('DWMWA_NCRENDERING_POLICY',DWMWA_NCRENDERING_POLICY);
    AddConstant('DWMWA_TRANSITIONS_FORCEDISABLED',DWMWA_TRANSITIONS_FORCEDISABLED);
    AddConstant('DWMWA_ALLOW_NCPAINT',DWMWA_ALLOW_NCPAINT);
    AddConstant('DWMWA_CAPTION_BUTTON_BOUNDS',DWMWA_CAPTION_BUTTON_BOUNDS);
    AddConstant('DWMWA_NONCLIENT_RTL_LAYOUT',DWMWA_NONCLIENT_RTL_LAYOUT);
    AddConstant('DWMWA_FORCE_ICONIC_REPRESENTATION',DWMWA_FORCE_ICONIC_REPRESENTATION);
    AddConstant('DWMWA_FLIP3D_POLICY',DWMWA_FLIP3D_POLICY);
    AddConstant('DWMWA_EXTENDED_FRAME_BOUNDS',DWMWA_EXTENDED_FRAME_BOUNDS);
    AddConstant('DWMWA_LAST',DWMWA_LAST);
    AddConstant('DWMNCRP_USEWINDOWSTYLE',DWMNCRP_USEWINDOWSTYLE);
    AddConstant('DWMNCRP_DISABLED',DWMNCRP_DISABLED);
    AddConstant('DWMNCRP_ENABLED',DWMNCRP_ENABLED);
    AddConstant('DWMNCRP_LAST',DWMNCRP_LAST);
    AddConstant('DWMFLIP3D_DEFAULT',DWMFLIP3D_DEFAULT);
    AddConstant('DWMFLIP3D_EXCLUDEBELOW',DWMFLIP3D_EXCLUDEBELOW);
    AddConstant('DWMFLIP3D_EXCLUDEABOVE',DWMFLIP3D_EXCLUDEABOVE);
    AddConstant('DWMFLIP3D_LAST',DWMFLIP3D_LAST);
    AddConstant('DWM_TNP_RECTDESTINATION',DWM_TNP_RECTDESTINATION);
    AddConstant('DWM_TNP_RECTSOURCE',DWM_TNP_RECTSOURCE);
    AddConstant('DWM_TNP_OPACITY',DWM_TNP_OPACITY);
    AddConstant('DWM_TNP_VISIBLE',DWM_TNP_VISIBLE);
    AddConstant('DWM_TNP_SOURCECLIENTAREAONLY',DWM_TNP_SOURCECLIENTAREAONLY);
    AddConstant('DWM_SOURCE_FRAME_SAMPLING_POINT',DWM_SOURCE_FRAME_SAMPLING_POINT);
    AddConstant('DWM_SOURCE_FRAME_SAMPLING_COVERAGE',DWM_SOURCE_FRAME_SAMPLING_COVERAGE);
    AddConstant('DWM_SOURCE_FRAME_SAMPLING_LAST',DWM_SOURCE_FRAME_SAMPLING_LAST);
    AddConstant('c_DwmMaxQueuedBuffers',c_DwmMaxQueuedBuffers);
    AddConstant('c_DwmMaxMonitors',c_DwmMaxMonitors);
    AddConstant('c_DwmMaxAdapters',c_DwmMaxAdapters);
    AddConstant('DWM_FRAME_DURATION_DEFAULT',DWM_FRAME_DURATION_DEFAULT);
    AddConstant('DWM_EC_DISABLECOMPOSITION',DWM_EC_DISABLECOMPOSITION);
    AddConstant('DWM_EC_ENABLECOMPOSITION',DWM_EC_ENABLECOMPOSITION);
  end;
end;

class function TatDwmApiLibrary.LibraryName: string;
begin
  result := 'DwmApi';
end;

initialization
  RegisterScripterLibrary(TatDwmApiLibrary, True);

{$WARNINGS ON}

end.

