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
unit ap_UxTheme;

interface

uses
  Windows,
  CommCtrl,
  UxTheme,
  Variants,
  Types,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatUxThemeLibrary = class(TatScripterLibrary)
    procedure __FreeThemeLibrary(AMachine: TatVirtualMachine);
    procedure __InitThemeLibrary(AMachine: TatVirtualMachine);
    procedure __UseThemes(AMachine: TatVirtualMachine);
    procedure __OpenThemeDataEx(AMachine: TatVirtualMachine);
    procedure __DrawThemeTextEx(AMachine: TatVirtualMachine);
    procedure __SetWindowThemeNonClientAttributes(AMachine: TatVirtualMachine);
    procedure __GetThemeBitmap(AMachine: TatVirtualMachine);
    procedure __BufferedPaintInit(AMachine: TatVirtualMachine);
    procedure __BufferedPaintUnInit(AMachine: TatVirtualMachine);
    procedure __EndBufferedPaint(AMachine: TatVirtualMachine);
    procedure __GetBufferedPaintTargetRect(AMachine: TatVirtualMachine);
    procedure __GetBufferedPaintTargetDC(AMachine: TatVirtualMachine);
    procedure __GetBufferedPaintDC(AMachine: TatVirtualMachine);
    procedure __BufferedPaintMakeOpaque(AMachine: TatVirtualMachine);
    procedure __BufferedPaintStopAllAnimations(AMachine: TatVirtualMachine);
    procedure __EndBufferedAnimation(AMachine: TatVirtualMachine);
    procedure __BufferedPaintRenderAnimation(AMachine: TatVirtualMachine);
    procedure __IsCompositionActive(AMachine: TatVirtualMachine);
    procedure __GetThemeTransitionDuration(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _MARGINSWrapper = class(TatRecordWrapper)
  private
    FcxLeftWidth: Integer;
    FcxRightWidth: Integer;
    FcyTopHeight: Integer;
    FcyBottomHeight: Integer;
  public
    constructor Create(ARecord: _MARGINS);
    function ObjToRec: _MARGINS;
  published
    property cxLeftWidth: Integer read FcxLeftWidth write FcxLeftWidth;
    property cxRightWidth: Integer read FcxRightWidth write FcxRightWidth;
    property cyTopHeight: Integer read FcyTopHeight write FcyTopHeight;
    property cyBottomHeight: Integer read FcyBottomHeight write FcyBottomHeight;
  end;
  
  _INTLISTWrapper = class(TatRecordWrapper)
  private
    FiValueCount: Integer;
  public
    constructor Create(ARecord: _INTLIST);
    function ObjToRec: _INTLIST;
  published
    property iValueCount: Integer read FiValueCount write FiValueCount;
  end;
  
  DTBGOPTSWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: DTBGOPTS);
    function ObjToRec: DTBGOPTS;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  DTTOPTSWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwFlags: DWORD;
    FcrText: COLORREF;
    FcrBorder: COLORREF;
    FcrShadow: COLORREF;
    FiTextShadowType: Integer;
    FiBorderSize: Integer;
    FiFontPropId: Integer;
    FiColorPropId: Integer;
    FiStateId: Integer;
    FfApplyOverlay: BOOL;
    FiGlowSize: Integer;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: DTTOPTS);
    function ObjToRec: DTTOPTS;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property crText: COLORREF read FcrText write FcrText;
    property crBorder: COLORREF read FcrBorder write FcrBorder;
    property crShadow: COLORREF read FcrShadow write FcrShadow;
    property iTextShadowType: Integer read FiTextShadowType write FiTextShadowType;
    property iBorderSize: Integer read FiBorderSize write FiBorderSize;
    property iFontPropId: Integer read FiFontPropId write FiFontPropId;
    property iColorPropId: Integer read FiColorPropId write FiColorPropId;
    property iStateId: Integer read FiStateId write FiStateId;
    property fApplyOverlay: BOOL read FfApplyOverlay write FfApplyOverlay;
    property iGlowSize: Integer read FiGlowSize write FiGlowSize;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  WTA_OPTIONSWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FdwMask: DWORD;
  public
    constructor Create(ARecord: WTA_OPTIONS);
    function ObjToRec: WTA_OPTIONS;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwMask: DWORD read FdwMask write FdwMask;
  end;
  
  BP_ANIMATIONPARAMSWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
    Fstyle: Cardinal;
    FdwDuration: DWORD;
  public
    constructor Create(ARecord: BP_ANIMATIONPARAMS);
    function ObjToRec: BP_ANIMATIONPARAMS;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property style: Cardinal read Fstyle write Fstyle;
    property dwDuration: DWORD read FdwDuration write FdwDuration;
  end;
  
  BP_PAINTPARAMSWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: BP_PAINTPARAMS);
    function ObjToRec: BP_PAINTPARAMS;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  

implementation

constructor _MARGINSWrapper.Create(ARecord: _MARGINS);
begin
  inherited Create;
  FcxLeftWidth := ARecord.cxLeftWidth;
  FcxRightWidth := ARecord.cxRightWidth;
  FcyTopHeight := ARecord.cyTopHeight;
  FcyBottomHeight := ARecord.cyBottomHeight;
end;

function _MARGINSWrapper.ObjToRec: _MARGINS;
begin
  result.cxLeftWidth := FcxLeftWidth;
  result.cxRightWidth := FcxRightWidth;
  result.cyTopHeight := FcyTopHeight;
  result.cyBottomHeight := FcyBottomHeight;
end;

constructor _INTLISTWrapper.Create(ARecord: _INTLIST);
begin
  inherited Create;
  FiValueCount := ARecord.iValueCount;
end;

function _INTLISTWrapper.ObjToRec: _INTLIST;
begin
  result.iValueCount := FiValueCount;
end;

constructor DTBGOPTSWrapper.Create(ARecord: DTBGOPTS);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
end;

function DTBGOPTSWrapper.ObjToRec: DTBGOPTS;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
end;

constructor DTTOPTSWrapper.Create(ARecord: DTTOPTS);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
  FcrText := ARecord.crText;
  FcrBorder := ARecord.crBorder;
  FcrShadow := ARecord.crShadow;
  FiTextShadowType := ARecord.iTextShadowType;
  FiBorderSize := ARecord.iBorderSize;
  FiFontPropId := ARecord.iFontPropId;
  FiColorPropId := ARecord.iColorPropId;
  FiStateId := ARecord.iStateId;
  FfApplyOverlay := ARecord.fApplyOverlay;
  FiGlowSize := ARecord.iGlowSize;
  FlParam := ARecord.lParam;
end;

function DTTOPTSWrapper.ObjToRec: DTTOPTS;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
  result.crText := FcrText;
  result.crBorder := FcrBorder;
  result.crShadow := FcrShadow;
  result.iTextShadowType := FiTextShadowType;
  result.iBorderSize := FiBorderSize;
  result.iFontPropId := FiFontPropId;
  result.iColorPropId := FiColorPropId;
  result.iStateId := FiStateId;
  result.fApplyOverlay := FfApplyOverlay;
  result.iGlowSize := FiGlowSize;
  result.lParam := FlParam;
end;

constructor WTA_OPTIONSWrapper.Create(ARecord: WTA_OPTIONS);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FdwMask := ARecord.dwMask;
end;

function WTA_OPTIONSWrapper.ObjToRec: WTA_OPTIONS;
begin
  result.dwFlags := FdwFlags;
  result.dwMask := FdwMask;
end;

constructor BP_ANIMATIONPARAMSWrapper.Create(ARecord: BP_ANIMATIONPARAMS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  Fstyle := ARecord.style;
  FdwDuration := ARecord.dwDuration;
end;

function BP_ANIMATIONPARAMSWrapper.ObjToRec: BP_ANIMATIONPARAMS;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.style := Fstyle;
  result.dwDuration := FdwDuration;
end;

constructor BP_PAINTPARAMSWrapper.Create(ARecord: BP_PAINTPARAMS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function BP_PAINTPARAMSWrapper.ObjToRec: BP_PAINTPARAMS;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;



procedure TatUxThemeLibrary.__FreeThemeLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    UxTheme.FreeThemeLibrary;
  end;
end;

procedure TatUxThemeLibrary.__InitThemeLibrary(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := UxTheme.InitThemeLibrary;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__UseThemes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := UxTheme.UseThemes;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__OpenThemeDataEx(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.OpenThemeDataEx(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__DrawThemeTextEx(AMachine: TatVirtualMachine);
  var
  Param7Rec: TObject;
  Param7: TRect;
  Param8Rec: TObject;
  Param8: TDTTOpts;
  AResult: variant;
begin
  with AMachine do
  begin
Param7Rec := TObject(integer(GetInputArg(7)));
if not Assigned(Param7Rec) or not (Param7Rec is TRectWrapper) then 
  Param7Rec := TRectWrapper.Create(Param7);
Param7 := TRectWrapper(Param7Rec).ObjToRec;
Param8Rec := TObject(integer(GetInputArg(8)));
if not Assigned(Param8Rec) or not (Param8Rec is DTTOPTSWrapper) then 
  Param8Rec := DTTOPTSWrapper.Create(Param8);
Param8 := DTTOPTSWrapper(Param8Rec).ObjToRec;
AResult := Integer(UxTheme.DrawThemeTextEx(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),GetInputArg(4),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),Param7,Param8));
    ReturnOutputArg(AResult);
    SetInputArg(7,integer(TRectWrapper.Create(Param7)));
    SetInputArg(8,integer(DTTOPTSWrapper.Create(Param8)));
  end;
end;

procedure TatUxThemeLibrary.__SetWindowThemeNonClientAttributes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.SetWindowThemeNonClientAttributes(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__GetThemeBitmap(AMachine: TatVirtualMachine);
  var
  Param5: HBITMAP;
  AResult: variant;
begin
  with AMachine do
  begin
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(UxTheme.GetThemeBitmap(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),Param5));
    ReturnOutputArg(AResult);
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatUxThemeLibrary.__BufferedPaintInit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.BufferedPaintInit);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__BufferedPaintUnInit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.BufferedPaintUnInit);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__EndBufferedPaint(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.EndBufferedPaint(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__GetBufferedPaintTargetRect(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TRectWrapper) then 
  Param1Rec := TRectWrapper.Create(Param1);
Param1 := TRectWrapper(Param1Rec).ObjToRec;
AResult := Integer(UxTheme.GetBufferedPaintTargetRect(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TRectWrapper.Create(Param1)));
  end;
end;

procedure TatUxThemeLibrary.__GetBufferedPaintTargetDC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.GetBufferedPaintTargetDC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__GetBufferedPaintDC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.GetBufferedPaintDC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__BufferedPaintMakeOpaque(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.BufferedPaintMakeOpaque(VarToInteger(GetInputArg(0)),TRectWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__BufferedPaintStopAllAnimations(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.BufferedPaintStopAllAnimations(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__EndBufferedAnimation(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(UxTheme.EndBufferedAnimation(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__BufferedPaintRenderAnimation(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := UxTheme.BufferedPaintRenderAnimation(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__IsCompositionActive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := UxTheme.IsCompositionActive;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatUxThemeLibrary.__GetThemeTransitionDuration(AMachine: TatVirtualMachine);
  var
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(UxTheme.GetThemeTransitionDuration(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),Param5));
    ReturnOutputArg(AResult);
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatUxThemeLibrary.Init;

  procedure AddConsts1;
  begin
    with Scripter.DefineClass(ClassType) do
    begin
      AddConstant('TS_MIN',TS_MIN);
      AddConstant('TS_TRUE',TS_TRUE);
      AddConstant('TS_DRAW',TS_DRAW);
      AddConstant('PO_STATE',PO_STATE);
      AddConstant('PO_PART',PO_PART);
      AddConstant('PO_CLASS',PO_CLASS);
      AddConstant('PO_GLOBAL',PO_GLOBAL);
      AddConstant('PO_NOTFOUND',PO_NOTFOUND);
      AddConstant('DTT_GRAYED',DTT_GRAYED);
      AddConstant('DTT_FLAGS2VALIDBITS',DTT_FLAGS2VALIDBITS);
      AddConstant('HTTB_BACKGROUNDSEG',HTTB_BACKGROUNDSEG);
      AddConstant('HTTB_FIXEDBORDER',HTTB_FIXEDBORDER);
      AddConstant('HTTB_CAPTION',HTTB_CAPTION);
      AddConstant('HTTB_RESIZINGBORDER_LEFT',HTTB_RESIZINGBORDER_LEFT);
      AddConstant('HTTB_RESIZINGBORDER_TOP',HTTB_RESIZINGBORDER_TOP);
      AddConstant('HTTB_RESIZINGBORDER_RIGHT',HTTB_RESIZINGBORDER_RIGHT);
      AddConstant('HTTB_RESIZINGBORDER_BOTTOM',HTTB_RESIZINGBORDER_BOTTOM);
      AddConstant('HTTB_RESIZINGBORDER',HTTB_RESIZINGBORDER);
      AddConstant('HTTB_SIZINGTEMPLATE',HTTB_SIZINGTEMPLATE);
      AddConstant('HTTB_SYSTEMSIZINGMARGINS',HTTB_SYSTEMSIZINGMARGINS);
      AddConstant('MAX_INTLIST_COUNT',MAX_INTLIST_COUNT);
      AddConstant('MAX_INTLIST_COUNT_600',MAX_INTLIST_COUNT_600);
      AddConstant('ETDT_DISABLE',ETDT_DISABLE);
      AddConstant('ETDT_ENABLE',ETDT_ENABLE);
      AddConstant('ETDT_USETABTEXTURE',ETDT_USETABTEXTURE);
      AddConstant('ETDT_USEAEROWIZARDTABTEXTURE',ETDT_USEAEROWIZARDTABTEXTURE);
      AddConstant('ETDT_ENABLETAB',ETDT_ENABLETAB);
      AddConstant('ETDT_ENABLEAEROWIZARDTAB',ETDT_ENABLEAEROWIZARDTAB);
      AddConstant('ETDT_VALIDBITS',ETDT_VALIDBITS);
      AddConstant('STAP_ALLOW_NONCLIENT',STAP_ALLOW_NONCLIENT);
      AddConstant('STAP_ALLOW_CONTROLS',STAP_ALLOW_CONTROLS);
      AddConstant('STAP_ALLOW_WEBCONTENT',STAP_ALLOW_WEBCONTENT);
      AddConstant('STAP_VALIDBITS',STAP_VALIDBITS);
      AddConstant('SZ_THDOCPROP_DISPLAYNAME',SZ_THDOCPROP_DISPLAYNAME);
      AddConstant('SZ_THDOCPROP_CANONICALNAME',SZ_THDOCPROP_CANONICALNAME);
      AddConstant('SZ_THDOCPROP_TOOLTIP',SZ_THDOCPROP_TOOLTIP);
      AddConstant('SZ_THDOCPROP_AUTHOR',SZ_THDOCPROP_AUTHOR);
      AddConstant('BT_IMAGEFILE',BT_IMAGEFILE);
      AddConstant('BT_BORDERFILL',BT_BORDERFILL);
      AddConstant('BT_NONE',BT_NONE);
      AddConstant('IL_VERTICAL',IL_VERTICAL);
      AddConstant('IL_HORIZONTAL',IL_HORIZONTAL);
      AddConstant('BT_RECT',BT_RECT);
      AddConstant('BT_ROUNDRECT',BT_ROUNDRECT);
      AddConstant('BT_ELLIPSE',BT_ELLIPSE);
      AddConstant('FT_SOLID',FT_SOLID);
      AddConstant('FT_VERTGRADIENT',FT_VERTGRADIENT);
      AddConstant('FT_HORZGRADIENT',FT_HORZGRADIENT);
      AddConstant('FT_RADIALGRADIENT',FT_RADIALGRADIENT);
      AddConstant('FT_TILEIMAGE',FT_TILEIMAGE);
      AddConstant('ST_TRUESIZE',ST_TRUESIZE);
      AddConstant('ST_STRETCH',ST_STRETCH);
      AddConstant('ST_TILE',ST_TILE);
      AddConstant('HA_LEFT',HA_LEFT);
      AddConstant('HA_CENTER',HA_CENTER);
      AddConstant('HA_RIGHT',HA_RIGHT);
      AddConstant('CA_LEFT',CA_LEFT);
      AddConstant('CA_CENTER',CA_CENTER);
      AddConstant('CA_RIGHT',CA_RIGHT);
      AddConstant('VA_TOP',VA_TOP);
      AddConstant('VA_CENTER',VA_CENTER);
      AddConstant('VA_BOTTOM',VA_BOTTOM);
      AddConstant('OT_TOPLEFT',OT_TOPLEFT);
      AddConstant('OT_TOPRIGHT',OT_TOPRIGHT);
      AddConstant('OT_TOPMIDDLE',OT_TOPMIDDLE);
      AddConstant('OT_BOTTOMLEFT',OT_BOTTOMLEFT);
      AddConstant('OT_BOTTOMRIGHT',OT_BOTTOMRIGHT);
      AddConstant('OT_BOTTOMMIDDLE',OT_BOTTOMMIDDLE);
      AddConstant('OT_MIDDLELEFT',OT_MIDDLELEFT);
      AddConstant('OT_MIDDLERIGHT',OT_MIDDLERIGHT);
      AddConstant('OT_LEFTOFCAPTION',OT_LEFTOFCAPTION);
      AddConstant('OT_RIGHTOFCAPTION',OT_RIGHTOFCAPTION);
      AddConstant('OT_LEFTOFLASTBUTTON',OT_LEFTOFLASTBUTTON);
      AddConstant('OT_RIGHTOFLASTBUTTON',OT_RIGHTOFLASTBUTTON);
      AddConstant('OT_ABOVELASTBUTTON',OT_ABOVELASTBUTTON);
      AddConstant('OT_BELOWLASTBUTTON',OT_BELOWLASTBUTTON);
      AddConstant('ICE_NONE',ICE_NONE);
      AddConstant('ICE_GLOW',ICE_GLOW);
      AddConstant('ICE_SHADOW',ICE_SHADOW);
      AddConstant('ICE_PULSE',ICE_PULSE);
      AddConstant('ICE_ALPHA',ICE_ALPHA);
      AddConstant('TST_NONE',TST_NONE);
      AddConstant('TST_SINGLE',TST_SINGLE);
      AddConstant('TST_CONTINUOUS',TST_CONTINUOUS);
      AddConstant('GT_NONE',GT_NONE);
      AddConstant('GT_IMAGEGLYPH',GT_IMAGEGLYPH);
      AddConstant('GT_FONTGLYPH',GT_FONTGLYPH);
      AddConstant('IST_NONE',IST_NONE);
      AddConstant('IST_SIZE',IST_SIZE);
      AddConstant('IST_DPI',IST_DPI);
      AddConstant('TSST_NONE',TSST_NONE);
      AddConstant('TSST_SIZE',TSST_SIZE);
      AddConstant('TSST_DPI',TSST_DPI);
      AddConstant('GFST_NONE',GFST_NONE);
      AddConstant('GFST_SIZE',GFST_SIZE);
      AddConstant('GFST_DPI',GFST_DPI);
      AddConstant('DummyProp',DummyProp);
      AddConstant('TMT_RESERVEDLOW',TMT_RESERVEDLOW);
      AddConstant('TMT_RESERVEDHIGH',TMT_RESERVEDHIGH);
      AddConstant('TMT_DIBDATA',TMT_DIBDATA);
      AddConstant('TMT_GLYPHDIBDATA',TMT_GLYPHDIBDATA);
      AddConstant('TMT_ENUM',TMT_ENUM);
      AddConstant('TMT_STRING',TMT_STRING);
      AddConstant('TMT_INT',TMT_INT);
      AddConstant('TMT_BOOL',TMT_BOOL);
      AddConstant('TMT_COLOR',TMT_COLOR);
      AddConstant('TMT_MARGINS',TMT_MARGINS);
      AddConstant('TMT_FILENAME',TMT_FILENAME);
      AddConstant('TMT_SIZE',TMT_SIZE);
      AddConstant('TMT_POSITION',TMT_POSITION);
      AddConstant('TMT_RECT',TMT_RECT);
      AddConstant('TMT_FONT',TMT_FONT);
      AddConstant('TMT_INTLIST',TMT_INTLIST);
      AddConstant('TMT_HBITMAP',TMT_HBITMAP);
      AddConstant('TMT_DISKSTREAM',TMT_DISKSTREAM);
      AddConstant('TMT_STREAM',TMT_STREAM);
      AddConstant('TMT_BITMAPREF',TMT_BITMAPREF);
      AddConstant('TMT_COLORSCHEMES',TMT_COLORSCHEMES);
      AddConstant('TMT_SIZES',TMT_SIZES);
      AddConstant('TMT_CHARSET',TMT_CHARSET);
      AddConstant('TMT_NAME',TMT_NAME);
      AddConstant('TMT_DISPLAYNAME',TMT_DISPLAYNAME);
      AddConstant('TMT_TOOLTIP',TMT_TOOLTIP);
      AddConstant('TMT_COMPANY',TMT_COMPANY);
      AddConstant('TMT_AUTHOR',TMT_AUTHOR);
      AddConstant('TMT_COPYRIGHT',TMT_COPYRIGHT);
      AddConstant('TMT_URL',TMT_URL);
      AddConstant('TMT_VERSION',TMT_VERSION);
      AddConstant('TMT_DESCRIPTION',TMT_DESCRIPTION);
      AddConstant('TMT_FIRST_RCSTRING_NAME',TMT_FIRST_RCSTRING_NAME);
      AddConstant('TMT_LAST_RCSTRING_NAME',TMT_LAST_RCSTRING_NAME);
      AddConstant('TMT_CAPTIONFONT',TMT_CAPTIONFONT);
      AddConstant('TMT_SMALLCAPTIONFONT',TMT_SMALLCAPTIONFONT);
      AddConstant('TMT_MENUFONT',TMT_MENUFONT);
      AddConstant('TMT_STATUSFONT',TMT_STATUSFONT);
      AddConstant('TMT_MSGBOXFONT',TMT_MSGBOXFONT);
      AddConstant('TMT_ICONTITLEFONT',TMT_ICONTITLEFONT);
      AddConstant('TMT_HEADING1FONT',TMT_HEADING1FONT);
      AddConstant('TMT_HEADING2FONT',TMT_HEADING2FONT);
      AddConstant('TMT_BODYFONT',TMT_BODYFONT);
      AddConstant('TMT_FIRSTFONT',TMT_FIRSTFONT);
      AddConstant('TMT_LASTFONT',TMT_LASTFONT);
      AddConstant('TMT_FLATMENUS',TMT_FLATMENUS);
      AddConstant('TMT_FIRSTBOOL',TMT_FIRSTBOOL);
      AddConstant('TMT_LASTBOOL',TMT_LASTBOOL);
      AddConstant('TMT_SIZINGBORDERWIDTH',TMT_SIZINGBORDERWIDTH);
      AddConstant('TMT_SCROLLBARWIDTH',TMT_SCROLLBARWIDTH);
      AddConstant('TMT_SCROLLBARHEIGHT',TMT_SCROLLBARHEIGHT);
      AddConstant('TMT_CAPTIONBARWIDTH',TMT_CAPTIONBARWIDTH);
      AddConstant('TMT_CAPTIONBARHEIGHT',TMT_CAPTIONBARHEIGHT);
      AddConstant('TMT_SMCAPTIONBARWIDTH',TMT_SMCAPTIONBARWIDTH);
      AddConstant('TMT_SMCAPTIONBARHEIGHT',TMT_SMCAPTIONBARHEIGHT);
      AddConstant('TMT_MENUBARWIDTH',TMT_MENUBARWIDTH);
      AddConstant('TMT_MENUBARHEIGHT',TMT_MENUBARHEIGHT);
      AddConstant('TMT_PADDEDBORDERWIDTH',TMT_PADDEDBORDERWIDTH);
      AddConstant('TMT_FIRSTSIZE',TMT_FIRSTSIZE);
      AddConstant('TMT_LASTSIZE',TMT_LASTSIZE);
      AddConstant('TMT_MINCOLORDEPTH',TMT_MINCOLORDEPTH);
      AddConstant('TMT_FIRSTINT',TMT_FIRSTINT);
      AddConstant('TMT_LASTINT',TMT_LASTINT);
      AddConstant('TMT_CSSNAME',TMT_CSSNAME);
      AddConstant('TMT_XMLNAME',TMT_XMLNAME);
      AddConstant('TMT_LASTUPDATED',TMT_LASTUPDATED);
      AddConstant('TMT_ALIAS',TMT_ALIAS);
      AddConstant('TMT_FIRSTSTRING',TMT_FIRSTSTRING);
      AddConstant('TMT_LASTSTRING',TMT_LASTSTRING);
      AddConstant('TMT_SCROLLBAR',TMT_SCROLLBAR);
      AddConstant('TMT_BACKGROUND',TMT_BACKGROUND);
      AddConstant('TMT_ACTIVECAPTION',TMT_ACTIVECAPTION);
      AddConstant('TMT_INACTIVECAPTION',TMT_INACTIVECAPTION);
      AddConstant('TMT_MENU',TMT_MENU);
      AddConstant('TMT_WINDOW',TMT_WINDOW);
      AddConstant('TMT_WINDOWFRAME',TMT_WINDOWFRAME);
      AddConstant('TMT_MENUTEXT',TMT_MENUTEXT);
      AddConstant('TMT_WINDOWTEXT',TMT_WINDOWTEXT);
      AddConstant('TMT_CAPTIONTEXT',TMT_CAPTIONTEXT);
      AddConstant('TMT_ACTIVEBORDER',TMT_ACTIVEBORDER);
      AddConstant('TMT_INACTIVEBORDER',TMT_INACTIVEBORDER);
      AddConstant('TMT_APPWORKSPACE',TMT_APPWORKSPACE);
      AddConstant('TMT_HIGHLIGHT',TMT_HIGHLIGHT);
      AddConstant('TMT_HIGHLIGHTTEXT',TMT_HIGHLIGHTTEXT);
      AddConstant('TMT_BTNFACE',TMT_BTNFACE);
      AddConstant('TMT_BTNSHADOW',TMT_BTNSHADOW);
      AddConstant('TMT_GRAYTEXT',TMT_GRAYTEXT);
      AddConstant('TMT_BTNTEXT',TMT_BTNTEXT);
      AddConstant('TMT_INACTIVECAPTIONTEXT',TMT_INACTIVECAPTIONTEXT);
      AddConstant('TMT_BTNHIGHLIGHT',TMT_BTNHIGHLIGHT);
      AddConstant('TMT_DKSHADOW3D',TMT_DKSHADOW3D);
      AddConstant('TMT_LIGHT3D',TMT_LIGHT3D);
      AddConstant('TMT_INFOTEXT',TMT_INFOTEXT);
      AddConstant('TMT_INFOBK',TMT_INFOBK);
      AddConstant('TMT_BUTTONALTERNATEFACE',TMT_BUTTONALTERNATEFACE);
      AddConstant('TMT_HOTTRACKING',TMT_HOTTRACKING);
      AddConstant('TMT_GRADIENTACTIVECAPTION',TMT_GRADIENTACTIVECAPTION);
      AddConstant('TMT_GRADIENTINACTIVECAPTION',TMT_GRADIENTINACTIVECAPTION);
      AddConstant('TMT_MENUHILIGHT',TMT_MENUHILIGHT);
      AddConstant('TMT_MENUBAR',TMT_MENUBAR);
      AddConstant('TMT_FIRSTCOLOR',TMT_FIRSTCOLOR);
      AddConstant('TMT_LASTCOLOR',TMT_LASTCOLOR);
      AddConstant('TMT_FROMHUE1',TMT_FROMHUE1);
      AddConstant('TMT_FROMHUE2',TMT_FROMHUE2);
      AddConstant('TMT_FROMHUE3',TMT_FROMHUE3);
      AddConstant('TMT_FROMHUE4',TMT_FROMHUE4);
      AddConstant('TMT_FROMHUE5',TMT_FROMHUE5);
      AddConstant('TMT_TOHUE1',TMT_TOHUE1);
      AddConstant('TMT_TOHUE2',TMT_TOHUE2);
      AddConstant('TMT_TOHUE3',TMT_TOHUE3);
      AddConstant('TMT_TOHUE4',TMT_TOHUE4);
      AddConstant('TMT_TOHUE5',TMT_TOHUE5);
      AddConstant('TMT_FROMCOLOR1',TMT_FROMCOLOR1);
      AddConstant('TMT_FROMCOLOR2',TMT_FROMCOLOR2);
      AddConstant('TMT_FROMCOLOR3',TMT_FROMCOLOR3);
      AddConstant('TMT_FROMCOLOR4',TMT_FROMCOLOR4);
      AddConstant('TMT_FROMCOLOR5',TMT_FROMCOLOR5);
      AddConstant('TMT_TOCOLOR1',TMT_TOCOLOR1);
      AddConstant('TMT_TOCOLOR2',TMT_TOCOLOR2);
      AddConstant('TMT_TOCOLOR3',TMT_TOCOLOR3);
      AddConstant('TMT_TOCOLOR4',TMT_TOCOLOR4);
      AddConstant('TMT_TOCOLOR5',TMT_TOCOLOR5);
      AddConstant('TMT_TRANSPARENT',TMT_TRANSPARENT);
      AddConstant('TMT_AUTOSIZE',TMT_AUTOSIZE);
      AddConstant('TMT_BORDERONLY',TMT_BORDERONLY);
      AddConstant('TMT_COMPOSITED',TMT_COMPOSITED);
      AddConstant('TMT_BGFILL',TMT_BGFILL);
      AddConstant('TMT_GLYPHTRANSPARENT',TMT_GLYPHTRANSPARENT);
      AddConstant('TMT_GLYPHONLY',TMT_GLYPHONLY);
      AddConstant('TMT_ALWAYSSHOWSIZINGBAR',TMT_ALWAYSSHOWSIZINGBAR);
      AddConstant('TMT_MIRRORIMAGE',TMT_MIRRORIMAGE);
      AddConstant('TMT_UNIFORMSIZING',TMT_UNIFORMSIZING);
      AddConstant('TMT_INTEGRALSIZING',TMT_INTEGRALSIZING);
      AddConstant('TMT_SOURCEGROW',TMT_SOURCEGROW);
      AddConstant('TMT_SOURCESHRINK',TMT_SOURCESHRINK);
      AddConstant('TMT_DRAWBORDERS',TMT_DRAWBORDERS);
      AddConstant('TMT_NOETCHEDEFFECT',TMT_NOETCHEDEFFECT);
      AddConstant('TMT_TEXTAPPLYOVERLAY',TMT_TEXTAPPLYOVERLAY);
      AddConstant('TMT_TEXTGLOW',TMT_TEXTGLOW);
      AddConstant('TMT_TEXTITALIC',TMT_TEXTITALIC);
      AddConstant('TMT_COMPOSITEDOPAQUE',TMT_COMPOSITEDOPAQUE);
      AddConstant('TMT_LOCALIZEDMIRRORIMAGE',TMT_LOCALIZEDMIRRORIMAGE);
      AddConstant('TMT_IMAGECOUNT',TMT_IMAGECOUNT);
      AddConstant('TMT_ALPHALEVEL',TMT_ALPHALEVEL);
      AddConstant('TMT_BORDERSIZE',TMT_BORDERSIZE);
      AddConstant('TMT_ROUNDCORNERWIDTH',TMT_ROUNDCORNERWIDTH);
      AddConstant('TMT_ROUNDCORNERHEIGHT',TMT_ROUNDCORNERHEIGHT);
      AddConstant('TMT_GRADIENTRATIO1',TMT_GRADIENTRATIO1);
      AddConstant('TMT_GRADIENTRATIO2',TMT_GRADIENTRATIO2);
      AddConstant('TMT_GRADIENTRATIO3',TMT_GRADIENTRATIO3);
      AddConstant('TMT_GRADIENTRATIO4',TMT_GRADIENTRATIO4);
      AddConstant('TMT_GRADIENTRATIO5',TMT_GRADIENTRATIO5);
      AddConstant('TMT_PROGRESSCHUNKSIZE',TMT_PROGRESSCHUNKSIZE);
      AddConstant('TMT_PROGRESSSPACESIZE',TMT_PROGRESSSPACESIZE);
      AddConstant('TMT_SATURATION',TMT_SATURATION);
      AddConstant('TMT_TEXTBORDERSIZE',TMT_TEXTBORDERSIZE);
      AddConstant('TMT_ALPHATHRESHOLD',TMT_ALPHATHRESHOLD);
      AddConstant('TMT_WIDTH',TMT_WIDTH);
      AddConstant('TMT_HEIGHT',TMT_HEIGHT);
      AddConstant('TMT_GLYPHINDEX',TMT_GLYPHINDEX);
      AddConstant('TMT_TRUESIZESTRETCHMARK',TMT_TRUESIZESTRETCHMARK);
      AddConstant('TMT_MINDPI1',TMT_MINDPI1);
      AddConstant('TMT_MINDPI2',TMT_MINDPI2);
      AddConstant('TMT_MINDPI3',TMT_MINDPI3);
      AddConstant('TMT_MINDPI4',TMT_MINDPI4);
      AddConstant('TMT_MINDPI5',TMT_MINDPI5);
      AddConstant('TMT_TEXTGLOWSIZE',TMT_TEXTGLOWSIZE);
      AddConstant('TMT_FRAMESPERSECOND',TMT_FRAMESPERSECOND);
      AddConstant('TMT_PIXELSPERFRAME',TMT_PIXELSPERFRAME);
      AddConstant('TMT_ANIMATIONDELAY',TMT_ANIMATIONDELAY);
      AddConstant('TMT_GLOWINTENSITY',TMT_GLOWINTENSITY);
      AddConstant('TMT_OPACITY',TMT_OPACITY);
      AddConstant('TMT_COLORIZATIONCOLOR',TMT_COLORIZATIONCOLOR);
      AddConstant('TMT_COLORIZATIONOPACITY',TMT_COLORIZATIONOPACITY);
      AddConstant('TMT_GLYPHFONT',TMT_GLYPHFONT);
      AddConstant('TMT_IMAGEFILE',TMT_IMAGEFILE);
      AddConstant('TMT_IMAGEFILE1',TMT_IMAGEFILE1);
      AddConstant('TMT_IMAGEFILE2',TMT_IMAGEFILE2);
      AddConstant('TMT_IMAGEFILE3',TMT_IMAGEFILE3);
      AddConstant('TMT_IMAGEFILE4',TMT_IMAGEFILE4);
      AddConstant('TMT_IMAGEFILE5',TMT_IMAGEFILE5);
      AddConstant('TMT_GLYPHIMAGEFILE',TMT_GLYPHIMAGEFILE);
      AddConstant('TMT_TEXT',TMT_TEXT);
      AddConstant('TMT_CLASSICVALUE',TMT_CLASSICVALUE);
      AddConstant('TMT_OFFSET',TMT_OFFSET);
      AddConstant('TMT_TEXTSHADOWOFFSET',TMT_TEXTSHADOWOFFSET);
      AddConstant('TMT_MINSIZE',TMT_MINSIZE);
      AddConstant('TMT_MINSIZE1',TMT_MINSIZE1);
      AddConstant('TMT_MINSIZE2',TMT_MINSIZE2);
      AddConstant('TMT_MINSIZE3',TMT_MINSIZE3);
      AddConstant('TMT_MINSIZE4',TMT_MINSIZE4);
      AddConstant('TMT_MINSIZE5',TMT_MINSIZE5);
      AddConstant('TMT_NORMALSIZE',TMT_NORMALSIZE);
      AddConstant('TMT_SIZINGMARGINS',TMT_SIZINGMARGINS);
      AddConstant('TMT_CONTENTMARGINS',TMT_CONTENTMARGINS);
      AddConstant('TMT_CAPTIONMARGINS',TMT_CAPTIONMARGINS);
      AddConstant('TMT_BORDERCOLOR',TMT_BORDERCOLOR);
      AddConstant('TMT_FILLCOLOR',TMT_FILLCOLOR);
      AddConstant('TMT_TEXTCOLOR',TMT_TEXTCOLOR);
      AddConstant('TMT_EDGELIGHTCOLOR',TMT_EDGELIGHTCOLOR);
      AddConstant('TMT_EDGEHIGHLIGHTCOLOR',TMT_EDGEHIGHLIGHTCOLOR);
      AddConstant('TMT_EDGESHADOWCOLOR',TMT_EDGESHADOWCOLOR);
      AddConstant('TMT_EDGEDKSHADOWCOLOR',TMT_EDGEDKSHADOWCOLOR);
      AddConstant('TMT_EDGEFILLCOLOR',TMT_EDGEFILLCOLOR);
      AddConstant('TMT_TRANSPARENTCOLOR',TMT_TRANSPARENTCOLOR);
      AddConstant('TMT_GRADIENTCOLOR1',TMT_GRADIENTCOLOR1);
      AddConstant('TMT_GRADIENTCOLOR2',TMT_GRADIENTCOLOR2);
      AddConstant('TMT_GRADIENTCOLOR3',TMT_GRADIENTCOLOR3);
      AddConstant('TMT_GRADIENTCOLOR4',TMT_GRADIENTCOLOR4);
      AddConstant('TMT_GRADIENTCOLOR5',TMT_GRADIENTCOLOR5);
      AddConstant('TMT_SHADOWCOLOR',TMT_SHADOWCOLOR);
      AddConstant('TMT_GLOWCOLOR',TMT_GLOWCOLOR);
      AddConstant('TMT_TEXTBORDERCOLOR',TMT_TEXTBORDERCOLOR);
      AddConstant('TMT_TEXTSHADOWCOLOR',TMT_TEXTSHADOWCOLOR);
      AddConstant('TMT_GLYPHTEXTCOLOR',TMT_GLYPHTEXTCOLOR);
      AddConstant('TMT_GLYPHTRANSPARENTCOLOR',TMT_GLYPHTRANSPARENTCOLOR);
      AddConstant('TMT_FILLCOLORHINT',TMT_FILLCOLORHINT);
      AddConstant('TMT_BORDERCOLORHINT',TMT_BORDERCOLORHINT);
      AddConstant('TMT_ACCENTCOLORHINT',TMT_ACCENTCOLORHINT);
      AddConstant('TMT_TEXTCOLORHINT',TMT_TEXTCOLORHINT);
      AddConstant('TMT_HEADING1TEXTCOLOR',TMT_HEADING1TEXTCOLOR);
      AddConstant('TMT_HEADING2TEXTCOLOR',TMT_HEADING2TEXTCOLOR);
      AddConstant('TMT_BODYTEXTCOLOR',TMT_BODYTEXTCOLOR);
      AddConstant('TMT_BGTYPE',TMT_BGTYPE);
      AddConstant('TMT_BORDERTYPE',TMT_BORDERTYPE);
      AddConstant('TMT_FILLTYPE',TMT_FILLTYPE);
      AddConstant('TMT_SIZINGTYPE',TMT_SIZINGTYPE);
      AddConstant('TMT_HALIGN',TMT_HALIGN);
      AddConstant('TMT_CONTENTALIGNMENT',TMT_CONTENTALIGNMENT);
      AddConstant('TMT_VALIGN',TMT_VALIGN);
      AddConstant('TMT_OFFSETTYPE',TMT_OFFSETTYPE);
      AddConstant('TMT_ICONEFFECT',TMT_ICONEFFECT);
      AddConstant('TMT_TEXTSHADOWTYPE',TMT_TEXTSHADOWTYPE);
      AddConstant('TMT_IMAGELAYOUT',TMT_IMAGELAYOUT);
      AddConstant('TMT_GLYPHTYPE',TMT_GLYPHTYPE);
      AddConstant('TMT_IMAGESELECTTYPE',TMT_IMAGESELECTTYPE);
      AddConstant('TMT_GLYPHFONTSIZINGTYPE',TMT_GLYPHFONTSIZINGTYPE);
      AddConstant('TMT_TRUESIZESCALINGTYPE',TMT_TRUESIZESCALINGTYPE);
      AddConstant('TMT_USERPICTURE',TMT_USERPICTURE);
      AddConstant('TMT_DEFAULTPANESIZE',TMT_DEFAULTPANESIZE);
      AddConstant('TMT_BLENDCOLOR',TMT_BLENDCOLOR);
      AddConstant('TMT_CUSTOMSPLITRECT',TMT_CUSTOMSPLITRECT);
      AddConstant('TMT_ANIMATIONBUTTONRECT',TMT_ANIMATIONBUTTONRECT);
      AddConstant('TMT_ANIMATIONDURATION',TMT_ANIMATIONDURATION);
      AddConstant('TMT_TRANSITIONDURATIONS',TMT_TRANSITIONDURATIONS);
      AddConstant('TMT_SCALEDBACKGROUND',TMT_SCALEDBACKGROUND);
      AddConstant('TMT_ATLASIMAGE',TMT_ATLASIMAGE);
      AddConstant('TMT_ATLASINPUTIMAGE',TMT_ATLASINPUTIMAGE);
      AddConstant('TMT_ATLASRECT',TMT_ATLASRECT);
      AddConstant('TMTVS_RESERVEDLOW',TMTVS_RESERVEDLOW);
      AddConstant('TMTVS_RESERVEDHIGH',TMTVS_RESERVEDHIGH);
      AddConstant('VSCLASS_WINDOWSTYLE',VSCLASS_WINDOWSTYLE);
      AddConstant('VSCLASS_WINDOW',VSCLASS_WINDOW);
      AddConstant('WINDOWPartFiller0',WINDOWPartFiller0);
      AddConstant('WP_CAPTION',WP_CAPTION);
      AddConstant('WP_SMALLCAPTION',WP_SMALLCAPTION);
      AddConstant('WP_MINCAPTION',WP_MINCAPTION);
      AddConstant('WP_SMALLMINCAPTION',WP_SMALLMINCAPTION);
      AddConstant('WP_MAXCAPTION',WP_MAXCAPTION);
      AddConstant('WP_SMALLMAXCAPTION',WP_SMALLMAXCAPTION);
      AddConstant('WP_FRAMELEFT',WP_FRAMELEFT);
      AddConstant('WP_FRAMERIGHT',WP_FRAMERIGHT);
      AddConstant('WP_FRAMEBOTTOM',WP_FRAMEBOTTOM);
      AddConstant('WP_SMALLFRAMELEFT',WP_SMALLFRAMELEFT);
      AddConstant('WP_SMALLFRAMERIGHT',WP_SMALLFRAMERIGHT);
      AddConstant('WP_SMALLFRAMEBOTTOM',WP_SMALLFRAMEBOTTOM);
      AddConstant('WP_SYSBUTTON',WP_SYSBUTTON);
      AddConstant('WP_MDISYSBUTTON',WP_MDISYSBUTTON);
      AddConstant('WP_MINBUTTON',WP_MINBUTTON);
      AddConstant('WP_MDIMINBUTTON',WP_MDIMINBUTTON);
      AddConstant('WP_MAXBUTTON',WP_MAXBUTTON);
      AddConstant('WP_CLOSEBUTTON',WP_CLOSEBUTTON);
      AddConstant('WP_SMALLCLOSEBUTTON',WP_SMALLCLOSEBUTTON);
      AddConstant('WP_MDICLOSEBUTTON',WP_MDICLOSEBUTTON);
      AddConstant('WP_RESTOREBUTTON',WP_RESTOREBUTTON);
      AddConstant('WP_MDIRESTOREBUTTON',WP_MDIRESTOREBUTTON);
      AddConstant('WP_HELPBUTTON',WP_HELPBUTTON);
      AddConstant('WP_MDIHELPBUTTON',WP_MDIHELPBUTTON);
      AddConstant('WP_HORZSCROLL',WP_HORZSCROLL);
      AddConstant('WP_HORZTHUMB',WP_HORZTHUMB);
      AddConstant('WP_VERTSCROLL',WP_VERTSCROLL);
      AddConstant('WP_VERTTHUMB',WP_VERTTHUMB);
      AddConstant('WP_DIALOG',WP_DIALOG);
      AddConstant('WP_CAPTIONSIZINGTEMPLATE',WP_CAPTIONSIZINGTEMPLATE);
      AddConstant('WP_SMALLCAPTIONSIZINGTEMPLATE',WP_SMALLCAPTIONSIZINGTEMPLATE);
      AddConstant('WP_FRAMELEFTSIZINGTEMPLATE',WP_FRAMELEFTSIZINGTEMPLATE);
      AddConstant('WP_SMALLFRAMELEFTSIZINGTEMPLATE',WP_SMALLFRAMELEFTSIZINGTEMPLATE);
      AddConstant('WP_FRAMERIGHTSIZINGTEMPLATE',WP_FRAMERIGHTSIZINGTEMPLATE);
      AddConstant('WP_SMALLFRAMERIGHTSIZINGTEMPLATE',WP_SMALLFRAMERIGHTSIZINGTEMPLATE);
      AddConstant('WP_FRAMEBOTTOMSIZINGTEMPLATE',WP_FRAMEBOTTOMSIZINGTEMPLATE);
      AddConstant('WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE',WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE);
      AddConstant('WP_FRAME',WP_FRAME);
      AddConstant('FRAMEStateFiller0',FRAMEStateFiller0);
      AddConstant('FS_ACTIVE',FS_ACTIVE);
      AddConstant('FS_INACTIVE',FS_INACTIVE);
      AddConstant('CAPTIONStateFiller0',CAPTIONStateFiller0);
      AddConstant('CS_ACTIVE',CS_ACTIVE);
      AddConstant('CS_INACTIVE',CS_INACTIVE);
      AddConstant('CS_DISABLED',CS_DISABLED);
      AddConstant('MAXCAPTIONStateFiller0',MAXCAPTIONStateFiller0);
      AddConstant('MXCS_ACTIVE',MXCS_ACTIVE);
      AddConstant('MXCS_INACTIVE',MXCS_INACTIVE);
      AddConstant('MXCS_DISABLED',MXCS_DISABLED);
      AddConstant('MINCAPTIONStateFiller0',MINCAPTIONStateFiller0);
      AddConstant('MNCS_ACTIVE',MNCS_ACTIVE);
      AddConstant('MNCS_INACTIVE',MNCS_INACTIVE);
      AddConstant('MNCS_DISABLED',MNCS_DISABLED);
      AddConstant('HORZSCROLLStateFiller0',HORZSCROLLStateFiller0);
      AddConstant('HSS_NORMAL',HSS_NORMAL);
      AddConstant('HSS_HOT',HSS_HOT);
      AddConstant('HSS_PUSHED',HSS_PUSHED);
      AddConstant('HSS_DISABLED',HSS_DISABLED);
      AddConstant('HORZTHUMBStateFiller0',HORZTHUMBStateFiller0);
      AddConstant('HTS_NORMAL',HTS_NORMAL);
      AddConstant('HTS_HOT',HTS_HOT);
      AddConstant('HTS_PUSHED',HTS_PUSHED);
      AddConstant('HTS_DISABLED',HTS_DISABLED);
      AddConstant('VERTSCROLLStateFiller0',VERTSCROLLStateFiller0);
      AddConstant('VSS_NORMAL',VSS_NORMAL);
      AddConstant('VSS_HOT',VSS_HOT);
      AddConstant('VSS_PUSHED',VSS_PUSHED);
      AddConstant('VSS_DISABLED',VSS_DISABLED);
      AddConstant('VERTTHUMBStateFiller0',VERTTHUMBStateFiller0);
      AddConstant('VTS_NORMAL',VTS_NORMAL);
      AddConstant('VTS_HOT',VTS_HOT);
      AddConstant('VTS_PUSHED',VTS_PUSHED);
      AddConstant('VTS_DISABLED',VTS_DISABLED);
      AddConstant('SYSBUTTONStateFiller0',SYSBUTTONStateFiller0);
      AddConstant('SBS_NORMAL',SBS_NORMAL);
      AddConstant('SBS_HOT',SBS_HOT);
      AddConstant('SBS_PUSHED',SBS_PUSHED);
      AddConstant('SBS_DISABLED',SBS_DISABLED);
      AddConstant('MINBUTTONStateFiller0',MINBUTTONStateFiller0);
      AddConstant('MINBS_NORMAL',MINBS_NORMAL);
      AddConstant('MINBS_HOT',MINBS_HOT);
      AddConstant('MINBS_PUSHED',MINBS_PUSHED);
      AddConstant('MINBS_DISABLED',MINBS_DISABLED);
      AddConstant('MAXBUTTONStateFiller0',MAXBUTTONStateFiller0);
      AddConstant('MAXBS_NORMAL',MAXBS_NORMAL);
      AddConstant('MAXBS_HOT',MAXBS_HOT);
      AddConstant('MAXBS_PUSHED',MAXBS_PUSHED);
      AddConstant('MAXBS_DISABLED',MAXBS_DISABLED);
      AddConstant('RESTOREBUTTONStateFiller0',RESTOREBUTTONStateFiller0);
      AddConstant('RBS_NORMAL',RBS_NORMAL);
      AddConstant('RBS_HOT',RBS_HOT);
      AddConstant('RBS_PUSHED',RBS_PUSHED);
      AddConstant('RBS_DISABLED',RBS_DISABLED);
      AddConstant('HELPBUTTONStateFiller0',HELPBUTTONStateFiller0);
      AddConstant('HBS_NORMAL',HBS_NORMAL);
      AddConstant('HBS_HOT',HBS_HOT);
      AddConstant('HBS_PUSHED',HBS_PUSHED);
      AddConstant('HBS_DISABLED',HBS_DISABLED);
      AddConstant('CLOSEBUTTONStateFiller0',CLOSEBUTTONStateFiller0);
      AddConstant('CBS_NORMAL',CBS_NORMAL);
      AddConstant('CBS_HOT',CBS_HOT);
      AddConstant('CBS_PUSHED',CBS_PUSHED);
      AddConstant('CBS_DISABLED',CBS_DISABLED);
      AddConstant('VSCLASS_BUTTONSTYLE',VSCLASS_BUTTONSTYLE);
      AddConstant('VSCLASS_BUTTON',VSCLASS_BUTTON);
      AddConstant('BUTTONPartFiller0',BUTTONPartFiller0);
      AddConstant('BP_PUSHBUTTON',BP_PUSHBUTTON);
      AddConstant('BP_RADIOBUTTON',BP_RADIOBUTTON);
      AddConstant('BP_CHECKBOX',BP_CHECKBOX);
      AddConstant('BP_GROUPBOX',BP_GROUPBOX);
      AddConstant('BP_USERBUTTON',BP_USERBUTTON);
      AddConstant('BP_COMMANDLINK',BP_COMMANDLINK);
      AddConstant('BP_COMMANDLINKGLYPH',BP_COMMANDLINKGLYPH);
      AddConstant('PUSHBUTTONStateFiller0',PUSHBUTTONStateFiller0);
      AddConstant('PBS_NORMAL',PBS_NORMAL);
      AddConstant('PBS_HOT',PBS_HOT);
      AddConstant('PBS_PRESSED',PBS_PRESSED);
      AddConstant('PBS_DISABLED',PBS_DISABLED);
      AddConstant('PBS_DEFAULTED',PBS_DEFAULTED);
      AddConstant('PBS_DEFAULTED_ANIMATING',PBS_DEFAULTED_ANIMATING);
      AddConstant('RADIOBUTTONStateFiller0',RADIOBUTTONStateFiller0);
      AddConstant('RBS_UNCHECKEDNORMAL',RBS_UNCHECKEDNORMAL);
      AddConstant('RBS_UNCHECKEDHOT',RBS_UNCHECKEDHOT);
      AddConstant('RBS_UNCHECKEDPRESSED',RBS_UNCHECKEDPRESSED);
      AddConstant('RBS_UNCHECKEDDISABLED',RBS_UNCHECKEDDISABLED);
      AddConstant('RBS_CHECKEDNORMAL',RBS_CHECKEDNORMAL);
      AddConstant('RBS_CHECKEDHOT',RBS_CHECKEDHOT);
      AddConstant('RBS_CHECKEDPRESSED',RBS_CHECKEDPRESSED);
      AddConstant('RBS_CHECKEDDISABLED',RBS_CHECKEDDISABLED);
      AddConstant('CHECKBOXStateFiller0',CHECKBOXStateFiller0);
      AddConstant('CBS_UNCHECKEDNORMAL',CBS_UNCHECKEDNORMAL);
      AddConstant('CBS_UNCHECKEDHOT',CBS_UNCHECKEDHOT);
      AddConstant('CBS_UNCHECKEDPRESSED',CBS_UNCHECKEDPRESSED);
      AddConstant('CBS_UNCHECKEDDISABLED',CBS_UNCHECKEDDISABLED);
      AddConstant('CBS_CHECKEDNORMAL',CBS_CHECKEDNORMAL);
      AddConstant('CBS_CHECKEDHOT',CBS_CHECKEDHOT);
      AddConstant('CBS_CHECKEDPRESSED',CBS_CHECKEDPRESSED);
      AddConstant('CBS_CHECKEDDISABLED',CBS_CHECKEDDISABLED);
      AddConstant('CBS_MIXEDNORMAL',CBS_MIXEDNORMAL);
      AddConstant('CBS_MIXEDHOT',CBS_MIXEDHOT);
      AddConstant('CBS_MIXEDPRESSED',CBS_MIXEDPRESSED);
      AddConstant('CBS_MIXEDDISABLED',CBS_MIXEDDISABLED);
      AddConstant('CBS_IMPLICITNORMAL',CBS_IMPLICITNORMAL);
      AddConstant('CBS_IMPLICITHOT',CBS_IMPLICITHOT);
      AddConstant('CBS_IMPLICITPRESSED',CBS_IMPLICITPRESSED);
      AddConstant('CBS_IMPLICITDISABLED',CBS_IMPLICITDISABLED);
      AddConstant('CBS_EXCLUDEDNORMAL',CBS_EXCLUDEDNORMAL);
      AddConstant('CBS_EXCLUDEDHOT',CBS_EXCLUDEDHOT);
      AddConstant('CBS_EXCLUDEDPRESSED',CBS_EXCLUDEDPRESSED);
      AddConstant('CBS_EXCLUDEDDISABLED',CBS_EXCLUDEDDISABLED);
      AddConstant('GROUPBOXStateFiller0',GROUPBOXStateFiller0);
      AddConstant('GBS_NORMAL',GBS_NORMAL);
      AddConstant('GBS_DISABLED',GBS_DISABLED);
      AddConstant('CMDLS_NORMAL',CMDLS_NORMAL);
      AddConstant('CMDLS_HOT',CMDLS_HOT);
      AddConstant('CMDLS_PRESSED',CMDLS_PRESSED);
      AddConstant('CMDLS_DISABLED',CMDLS_DISABLED);
      AddConstant('CMDLS_DEFAULTED',CMDLS_DEFAULTED);
      AddConstant('CMDLS_DEFAULTED_ANIMATING',CMDLS_DEFAULTED_ANIMATING);
      AddConstant('CMDLGS_NORMAL',CMDLGS_NORMAL);
      AddConstant('CMDLGS_HOT',CMDLGS_HOT);
      AddConstant('CMDLGS_PRESSED',CMDLGS_PRESSED);
      AddConstant('CMDLGS_DISABLED',CMDLGS_DISABLED);
      AddConstant('CMDLGS_DEFAULTED',CMDLGS_DEFAULTED);
      AddConstant('VSCLASS_REBARSTYLE',VSCLASS_REBARSTYLE);
      AddConstant('VSCLASS_REBAR',VSCLASS_REBAR);
      AddConstant('REBARPartFiller0',REBARPartFiller0);
      AddConstant('RP_GRIPPER',RP_GRIPPER);
      AddConstant('RP_GRIPPERVERT',RP_GRIPPERVERT);
      AddConstant('RP_BAND',RP_BAND);
      AddConstant('RP_CHEVRON',RP_CHEVRON);
      AddConstant('RP_CHEVRONVERT',RP_CHEVRONVERT);
      AddConstant('RP_BACKGROUND',RP_BACKGROUND);
      AddConstant('RP_SPLITTER',RP_SPLITTER);
      AddConstant('RP_SPLITTERVERT',RP_SPLITTERVERT);
      AddConstant('CHEVRONStateFiller0',CHEVRONStateFiller0);
      AddConstant('CHEVS_NORMAL',CHEVS_NORMAL);
      AddConstant('CHEVS_HOT',CHEVS_HOT);
      AddConstant('CHEVS_PRESSED',CHEVS_PRESSED);
      AddConstant('CHEVSV_NORMAL',CHEVSV_NORMAL);
      AddConstant('CHEVSV_HOT',CHEVSV_HOT);
      AddConstant('CHEVSV_PRESSED',CHEVSV_PRESSED);
      AddConstant('SPLITS_NORMAL',SPLITS_NORMAL);
      AddConstant('SPLITS_HOT',SPLITS_HOT);
      AddConstant('SPLITS_PRESSED',SPLITS_PRESSED);
      AddConstant('SPLITSV_NORMAL',SPLITSV_NORMAL);
      AddConstant('SPLITSV_HOT',SPLITSV_HOT);
      AddConstant('SPLITSV_PRESSED',SPLITSV_PRESSED);
      AddConstant('VSCLASS_TOOLBARSTYLE',VSCLASS_TOOLBARSTYLE);
      AddConstant('VSCLASS_TOOLBAR',VSCLASS_TOOLBAR);
      AddConstant('TOOLBARPartFiller0',TOOLBARPartFiller0);
      AddConstant('TP_BUTTON',TP_BUTTON);
      AddConstant('TP_DROPDOWNBUTTON',TP_DROPDOWNBUTTON);
      AddConstant('TP_SPLITBUTTON',TP_SPLITBUTTON);
      AddConstant('TP_SPLITBUTTONDROPDOWN',TP_SPLITBUTTONDROPDOWN);
      AddConstant('TP_SEPARATOR',TP_SEPARATOR);
      AddConstant('TP_SEPARATORVERT',TP_SEPARATORVERT);
      AddConstant('TOOLBARStateFiller0',TOOLBARStateFiller0);
      AddConstant('TS_NORMAL',TS_NORMAL);
      AddConstant('TS_HOT',TS_HOT);
      AddConstant('TS_PRESSED',TS_PRESSED);
      AddConstant('TS_DISABLED',TS_DISABLED);
      AddConstant('TS_CHECKED',TS_CHECKED);
      AddConstant('TS_HOTCHECKED',TS_HOTCHECKED);
      AddConstant('TS_NEARHOT',TS_NEARHOT);
      AddConstant('TS_OTHERSIDEHOT',TS_OTHERSIDEHOT);
      AddConstant('VSCLASS_STATUSSTYLE',VSCLASS_STATUSSTYLE);
      AddConstant('VSCLASS_STATUS',VSCLASS_STATUS);
      AddConstant('STATUSPartFiller0',STATUSPartFiller0);
      AddConstant('SP_PANE',SP_PANE);
      AddConstant('SP_GRIPPERPANE',SP_GRIPPERPANE);
      AddConstant('SP_GRIPPER',SP_GRIPPER);
      AddConstant('VSCLASS_MENUSTYLE',VSCLASS_MENUSTYLE);
      AddConstant('VSCLASS_MENU',VSCLASS_MENU);
      AddConstant('MENUPartFiller0',MENUPartFiller0);
      AddConstant('MP_MENUITEM',MP_MENUITEM);
      AddConstant('MP_MENUDROPDOWN',MP_MENUDROPDOWN);
      AddConstant('MP_MENUBARITEM',MP_MENUBARITEM);
      AddConstant('MP_MENUBARDROPDOWN',MP_MENUBARDROPDOWN);
      AddConstant('MP_CHEVRON',MP_CHEVRON);
      AddConstant('MP_SEPARATOR',MP_SEPARATOR);
      AddConstant('MENU_MENUITEM_TMSCHEMA',MENU_MENUITEM_TMSCHEMA);
      AddConstant('MENU_MENUDROPDOWN_TMSCHEMA',MENU_MENUDROPDOWN_TMSCHEMA);
      AddConstant('MENU_MENUBARITEM_TMSCHEMA',MENU_MENUBARITEM_TMSCHEMA);
      AddConstant('MENU_MENUBARDROPDOWN_TMSCHEMA',MENU_MENUBARDROPDOWN_TMSCHEMA);
      AddConstant('MENU_CHEVRON_TMSCHEMA',MENU_CHEVRON_TMSCHEMA);
      AddConstant('MENU_SEPARATOR_TMSCHEMA',MENU_SEPARATOR_TMSCHEMA);
      AddConstant('MENU_BARBACKGROUND',MENU_BARBACKGROUND);
      AddConstant('MENU_BARITEM',MENU_BARITEM);
      AddConstant('MENU_POPUPBACKGROUND',MENU_POPUPBACKGROUND);
      AddConstant('MENU_POPUPBORDERS',MENU_POPUPBORDERS);
      AddConstant('MENU_POPUPCHECK',MENU_POPUPCHECK);
      AddConstant('MENU_POPUPCHECKBACKGROUND',MENU_POPUPCHECKBACKGROUND);
      AddConstant('MENU_POPUPGUTTER',MENU_POPUPGUTTER);
      AddConstant('MENU_POPUPITEM',MENU_POPUPITEM);
      AddConstant('MENU_POPUPSEPARATOR',MENU_POPUPSEPARATOR);
      AddConstant('MENU_POPUPSUBMENU',MENU_POPUPSUBMENU);
      AddConstant('MENU_SYSTEMCLOSE',MENU_SYSTEMCLOSE);
      AddConstant('MENU_SYSTEMMAXIMIZE',MENU_SYSTEMMAXIMIZE);
      AddConstant('MENU_SYSTEMMINIMIZE',MENU_SYSTEMMINIMIZE);
      AddConstant('MENU_SYSTEMRESTORE',MENU_SYSTEMRESTORE);
      AddConstant('MENUStateFiller0',MENUStateFiller0);
      AddConstant('MS_NORMAL',MS_NORMAL);
      AddConstant('MS_SELECTED',MS_SELECTED);
      AddConstant('MS_DEMOTED',MS_DEMOTED);
      AddConstant('MB_ACTIVE',MB_ACTIVE);
      AddConstant('MB_INACTIVE',MB_INACTIVE);
      AddConstant('MBI_NORMAL',MBI_NORMAL);
      AddConstant('MBI_HOT',MBI_HOT);
      AddConstant('MBI_PUSHED',MBI_PUSHED);
      AddConstant('MBI_DISABLED',MBI_DISABLED);
      AddConstant('MBI_DISABLEDHOT',MBI_DISABLEDHOT);
      AddConstant('MBI_DISABLEDPUSHED',MBI_DISABLEDPUSHED);
      AddConstant('MC_CHECKMARKNORMAL',MC_CHECKMARKNORMAL);
      AddConstant('MC_CHECKMARKDISABLED',MC_CHECKMARKDISABLED);
      AddConstant('MC_BULLETNORMAL',MC_BULLETNORMAL);
      AddConstant('MC_BULLETDISABLED',MC_BULLETDISABLED);
      AddConstant('MCB_DISABLED',MCB_DISABLED);
      AddConstant('MCB_NORMAL',MCB_NORMAL);
      AddConstant('MCB_BITMAP',MCB_BITMAP);
      AddConstant('MPI_NORMAL',MPI_NORMAL);
      AddConstant('MPI_HOT',MPI_HOT);
      AddConstant('MPI_DISABLED',MPI_DISABLED);
      AddConstant('MPI_DISABLEDHOT',MPI_DISABLEDHOT);
      AddConstant('MSM_NORMAL',MSM_NORMAL);
      AddConstant('MSM_DISABLED',MSM_DISABLED);
      AddConstant('MSYSC_NORMAL',MSYSC_NORMAL);
      AddConstant('MSYSC_DISABLED',MSYSC_DISABLED);
      AddConstant('MSYSMX_NORMAL',MSYSMX_NORMAL);
      AddConstant('MSYSMX_DISABLED',MSYSMX_DISABLED);
      AddConstant('MSYSMN_NORMAL',MSYSMN_NORMAL);
      AddConstant('MSYSMN_DISABLED',MSYSMN_DISABLED);
      AddConstant('MSYSR_NORMAL',MSYSR_NORMAL);
      AddConstant('MSYSR_DISABLED',MSYSR_DISABLED);
      AddConstant('VSCLASS_LISTVIEWSTYLE',VSCLASS_LISTVIEWSTYLE);
      AddConstant('VSCLASS_LISTVIEW',VSCLASS_LISTVIEW);
      AddConstant('LISTVIEWPartFiller0',LISTVIEWPartFiller0);
      AddConstant('LVP_LISTITEM',LVP_LISTITEM);
      AddConstant('LVP_LISTGROUP',LVP_LISTGROUP);
      AddConstant('LVP_LISTDETAIL',LVP_LISTDETAIL);
      AddConstant('LVP_LISTSORTEDDETAIL',LVP_LISTSORTEDDETAIL);
      AddConstant('LVP_EMPTYTEXT',LVP_EMPTYTEXT);
      AddConstant('LVP_GROUPHEADER',LVP_GROUPHEADER);
      AddConstant('LVP_GROUPHEADERLINE',LVP_GROUPHEADERLINE);
      AddConstant('LVP_EXPANDBUTTON',LVP_EXPANDBUTTON);
      AddConstant('LVP_COLLAPSEBUTTON',LVP_COLLAPSEBUTTON);
      AddConstant('LVP_COLUMNDETAIL',LVP_COLUMNDETAIL);
      AddConstant('LISTITEMStateFiller0',LISTITEMStateFiller0);
      AddConstant('LIS_NORMAL',LIS_NORMAL);
      AddConstant('LIS_HOT',LIS_HOT);
      AddConstant('LIS_SELECTED',LIS_SELECTED);
      AddConstant('LIS_DISABLED',LIS_DISABLED);
      AddConstant('LIS_SELECTEDNOTFOCUS',LIS_SELECTEDNOTFOCUS);
      AddConstant('LISS_HOTSELECTED',LISS_HOTSELECTED);
      AddConstant('LVGH_OPEN',LVGH_OPEN);
      AddConstant('LVGH_OPENHOT',LVGH_OPENHOT);
      AddConstant('LVGH_OPENSELECTED',LVGH_OPENSELECTED);
      AddConstant('LVGH_OPENSELECTEDHOT',LVGH_OPENSELECTEDHOT);
      AddConstant('LVGH_OPENSELECTEDNOTFOCUSED',LVGH_OPENSELECTEDNOTFOCUSED);
      AddConstant('LVGH_OPENSELECTEDNOTFOCUSEDHOT',LVGH_OPENSELECTEDNOTFOCUSEDHOT);
      AddConstant('LVGH_OPENMIXEDSELECTION',LVGH_OPENMIXEDSELECTION);
      AddConstant('LVGH_OPENMIXEDSELECTIONHOT',LVGH_OPENMIXEDSELECTIONHOT);
      AddConstant('LVGH_CLOSE',LVGH_CLOSE);
      AddConstant('LVGH_CLOSEHOT',LVGH_CLOSEHOT);
      AddConstant('LVGH_CLOSESELECTED',LVGH_CLOSESELECTED);
      AddConstant('LVGH_CLOSESELECTEDHOT',LVGH_CLOSESELECTEDHOT);
      AddConstant('LVGH_CLOSESELECTEDNOTFOCUSED',LVGH_CLOSESELECTEDNOTFOCUSED);
      AddConstant('LVGH_CLOSESELECTEDNOTFOCUSEDHOT',LVGH_CLOSESELECTEDNOTFOCUSEDHOT);
      AddConstant('LVGH_CLOSEMIXEDSELECTION',LVGH_CLOSEMIXEDSELECTION);
      AddConstant('LVGH_CLOSEMIXEDSELECTIONHOT',LVGH_CLOSEMIXEDSELECTIONHOT);
      AddConstant('LVGHL_OPEN',LVGHL_OPEN);
      AddConstant('LVGHL_OPENHOT',LVGHL_OPENHOT);
      AddConstant('LVGHL_OPENSELECTED',LVGHL_OPENSELECTED);
      AddConstant('LVGHL_OPENSELECTEDHOT',LVGHL_OPENSELECTEDHOT);
      AddConstant('LVGHL_OPENSELECTEDNOTFOCUSED',LVGHL_OPENSELECTEDNOTFOCUSED);
      AddConstant('LVGHL_OPENSELECTEDNOTFOCUSEDHOT',LVGHL_OPENSELECTEDNOTFOCUSEDHOT);
      AddConstant('LVGHL_OPENMIXEDSELECTION',LVGHL_OPENMIXEDSELECTION);
      AddConstant('LVGHL_OPENMIXEDSELECTIONHOT',LVGHL_OPENMIXEDSELECTIONHOT);
      AddConstant('LVGHL_CLOSE',LVGHL_CLOSE);
      AddConstant('LVGHL_CLOSEHOT',LVGHL_CLOSEHOT);
      AddConstant('LVGHL_CLOSESELECTED',LVGHL_CLOSESELECTED);
      AddConstant('LVGHL_CLOSESELECTEDHOT',LVGHL_CLOSESELECTEDHOT);
      AddConstant('LVGHL_CLOSESELECTEDNOTFOCUSED',LVGHL_CLOSESELECTEDNOTFOCUSED);
      AddConstant('LVGHL_CLOSESELECTEDNOTFOCUSEDHOT',LVGHL_CLOSESELECTEDNOTFOCUSEDHOT);
      AddConstant('LVGHL_CLOSEMIXEDSELECTION',LVGHL_CLOSEMIXEDSELECTION);
      AddConstant('LVGHL_CLOSEMIXEDSELECTIONHOT',LVGHL_CLOSEMIXEDSELECTIONHOT);
      AddConstant('LVEB_NORMAL',LVEB_NORMAL);
      AddConstant('LVEB_HOVER',LVEB_HOVER);
      AddConstant('LVEB_PUSHED',LVEB_PUSHED);
      AddConstant('LVCB_NORMAL',LVCB_NORMAL);
      AddConstant('LVCB_HOVER',LVCB_HOVER);
      AddConstant('LVCB_PUSHED',LVCB_PUSHED);
      AddConstant('VSCLASS_HEADERSTYLE',VSCLASS_HEADERSTYLE);
      AddConstant('VSCLASS_HEADER',VSCLASS_HEADER);
      AddConstant('HEADERPartFiller0',HEADERPartFiller0);
      AddConstant('HP_HEADERITEM',HP_HEADERITEM);
      AddConstant('HP_HEADERITEMLEFT',HP_HEADERITEMLEFT);
      AddConstant('HP_HEADERITEMRIGHT',HP_HEADERITEMRIGHT);
      AddConstant('HP_HEADERSORTARROW',HP_HEADERSORTARROW);
      AddConstant('HP_HEADERDROPDOWN',HP_HEADERDROPDOWN);
      AddConstant('HP_HEADERDROPDOWNFILTER',HP_HEADERDROPDOWNFILTER);
      AddConstant('HP_HEADEROVERFLOW',HP_HEADEROVERFLOW);
      AddConstant('HBG_DETAILS',HBG_DETAILS);
      AddConstant('HBG_ICON',HBG_ICON);
      AddConstant('HEADERITEMStateFiller0',HEADERITEMStateFiller0);
      AddConstant('HIS_NORMAL',HIS_NORMAL);
      AddConstant('HIS_HOT',HIS_HOT);
      AddConstant('HIS_PRESSED',HIS_PRESSED);
      AddConstant('HIS_SORTEDNORMAL',HIS_SORTEDNORMAL);
      AddConstant('HIS_SORTEDHOT',HIS_SORTEDHOT);
      AddConstant('HIS_SORTEDPRESSED',HIS_SORTEDPRESSED);
      AddConstant('HIS_ICONNORMAL',HIS_ICONNORMAL);
      AddConstant('HIS_ICONHOT',HIS_ICONHOT);
      AddConstant('HIS_ICONPRESSED',HIS_ICONPRESSED);
      AddConstant('HIS_ICONSORTEDNORMAL',HIS_ICONSORTEDNORMAL);
      AddConstant('HIS_ICONSORTEDHOT',HIS_ICONSORTEDHOT);
      AddConstant('HIS_ICONSORTEDPRESSED',HIS_ICONSORTEDPRESSED);
      AddConstant('HEADERITEMLEFTStateFiller0',HEADERITEMLEFTStateFiller0);
      AddConstant('HILS_NORMAL',HILS_NORMAL);
      AddConstant('HILS_HOT',HILS_HOT);
      AddConstant('HILS_PRESSED',HILS_PRESSED);
      AddConstant('HEADERITEMRIGHTStateFiller0',HEADERITEMRIGHTStateFiller0);
      AddConstant('HIRS_NORMAL',HIRS_NORMAL);
      AddConstant('HIRS_HOT',HIRS_HOT);
      AddConstant('HIRS_PRESSED',HIRS_PRESSED);
      AddConstant('HEADERSORTARROWStateFiller0',HEADERSORTARROWStateFiller0);
      AddConstant('HSAS_SORTEDUP',HSAS_SORTEDUP);
      AddConstant('HSAS_SORTEDDOWN',HSAS_SORTEDDOWN);
      AddConstant('HDDS_NORMAL',HDDS_NORMAL);
      AddConstant('HDDS_SOFTHOT',HDDS_SOFTHOT);
      AddConstant('HDDS_HOT',HDDS_HOT);
      AddConstant('HDDFS_NORMAL',HDDFS_NORMAL);
      AddConstant('HDDFS_SOFTHOT',HDDFS_SOFTHOT);
      AddConstant('HDDFS_HOT',HDDFS_HOT);
      AddConstant('HOFS_NORMAL',HOFS_NORMAL);
      AddConstant('HOFS_HOT',HOFS_HOT);
      AddConstant('VSCLASS_PROGRESSSTYLE',VSCLASS_PROGRESSSTYLE);
      AddConstant('VSCLASS_PROGRESS',VSCLASS_PROGRESS);
      AddConstant('PROGRESSPartFiller0',PROGRESSPartFiller0);
      AddConstant('PP_BAR',PP_BAR);
      AddConstant('PP_BARVERT',PP_BARVERT);
      AddConstant('PP_CHUNK',PP_CHUNK);
      AddConstant('PP_CHUNKVERT',PP_CHUNKVERT);
      AddConstant('PP_FILL',PP_FILL);
      AddConstant('PP_FILLVERT',PP_FILLVERT);
      AddConstant('PP_PULSEOVERLAY',PP_PULSEOVERLAY);
      AddConstant('PP_MOVEOVERLAY',PP_MOVEOVERLAY);
      AddConstant('PP_PULSEOVERLAYVERT',PP_PULSEOVERLAYVERT);
      AddConstant('PP_MOVEOVERLAYVERT',PP_MOVEOVERLAYVERT);
      AddConstant('PP_TRANSPARENTBAR',PP_TRANSPARENTBAR);
      AddConstant('PP_TRANSPARENTBARVERT',PP_TRANSPARENTBARVERT);
      AddConstant('PBBS_NORMAL',PBBS_NORMAL);
      AddConstant('PBBS_PARTIAL',PBBS_PARTIAL);
      AddConstant('PBBVS_NORMAL',PBBVS_NORMAL);
      AddConstant('PBBVS_PARTIAL',PBBVS_PARTIAL);
      AddConstant('PBFS_NORMAL',PBFS_NORMAL);
      AddConstant('PBFS_ERROR',PBFS_ERROR);
      AddConstant('PBFS_PAUSED',PBFS_PAUSED);
      AddConstant('PBFS_PARTIAL',PBFS_PARTIAL);
      AddConstant('PBFVS_NORMAL',PBFVS_NORMAL);
      AddConstant('PBFVS_ERROR',PBFVS_ERROR);
      AddConstant('PBFVS_PAUSED',PBFVS_PAUSED);
      AddConstant('PBFVS_PARTIAL',PBFVS_PARTIAL);
      AddConstant('VSCLASS_TABSTYLE',VSCLASS_TABSTYLE);
      AddConstant('VSCLASS_TAB',VSCLASS_TAB);
      AddConstant('TABPartFiller0',TABPartFiller0);
      AddConstant('TABP_TABITEM',TABP_TABITEM);
      AddConstant('TABP_TABITEMLEFTEDGE',TABP_TABITEMLEFTEDGE);
      AddConstant('TABP_TABITEMRIGHTEDGE',TABP_TABITEMRIGHTEDGE);
      AddConstant('TABP_TABITEMBOTHEDGE',TABP_TABITEMBOTHEDGE);
      AddConstant('TABP_TOPTABITEM',TABP_TOPTABITEM);
      AddConstant('TABP_TOPTABITEMLEFTEDGE',TABP_TOPTABITEMLEFTEDGE);
      AddConstant('TABP_TOPTABITEMRIGHTEDGE',TABP_TOPTABITEMRIGHTEDGE);
      AddConstant('TABP_TOPTABITEMBOTHEDGE',TABP_TOPTABITEMBOTHEDGE);
      AddConstant('TABP_PANE',TABP_PANE);
      AddConstant('TABP_BODY',TABP_BODY);
      AddConstant('TABP_AEROWIZARDBODY',TABP_AEROWIZARDBODY);
      AddConstant('TABITEMStateFiller0',TABITEMStateFiller0);
      AddConstant('TIS_NORMAL',TIS_NORMAL);
      AddConstant('TIS_HOT',TIS_HOT);
      AddConstant('TIS_SELECTED',TIS_SELECTED);
      AddConstant('TIS_DISABLED',TIS_DISABLED);
      AddConstant('TIS_FOCUSED',TIS_FOCUSED);
      AddConstant('TABITEMLEFTEDGEStateFiller0',TABITEMLEFTEDGEStateFiller0);
      AddConstant('TILES_NORMAL',TILES_NORMAL);
      AddConstant('TILES_HOT',TILES_HOT);
      AddConstant('TILES_SELECTED',TILES_SELECTED);
      AddConstant('TILES_DISABLED',TILES_DISABLED);
      AddConstant('TILES_FOCUSED',TILES_FOCUSED);
      AddConstant('TABITEMRIGHTEDGEStateFiller0',TABITEMRIGHTEDGEStateFiller0);
      AddConstant('TIRES_NORMAL',TIRES_NORMAL);
      AddConstant('TIRES_HOT',TIRES_HOT);
      AddConstant('TIRES_SELECTED',TIRES_SELECTED);
      AddConstant('TIRES_DISABLED',TIRES_DISABLED);
      AddConstant('TIRES_FOCUSED',TIRES_FOCUSED);
      AddConstant('TABITEMBOTHEDGESStateFiller0',TABITEMBOTHEDGESStateFiller0);
      AddConstant('TIBES_NORMAL',TIBES_NORMAL);
      AddConstant('TIBES_HOT',TIBES_HOT);
      AddConstant('TIBES_SELECTED',TIBES_SELECTED);
      AddConstant('TIBES_DISABLED',TIBES_DISABLED);
      AddConstant('TIBES_FOCUSED',TIBES_FOCUSED);
      AddConstant('TOPTABITEMStateFiller0',TOPTABITEMStateFiller0);
      AddConstant('TTIS_NORMAL',TTIS_NORMAL);
      AddConstant('TTIS_HOT',TTIS_HOT);
      AddConstant('TTIS_SELECTED',TTIS_SELECTED);
      AddConstant('TTIS_DISABLED',TTIS_DISABLED);
      AddConstant('TTIS_FOCUSED',TTIS_FOCUSED);
      AddConstant('TOPTABITEMLEFTEDGEStateFiller0',TOPTABITEMLEFTEDGEStateFiller0);
      AddConstant('TTILES_NORMAL',TTILES_NORMAL);
      AddConstant('TTILES_HOT',TTILES_HOT);
      AddConstant('TTILES_SELECTED',TTILES_SELECTED);
      AddConstant('TTILES_DISABLED',TTILES_DISABLED);
      AddConstant('TTILES_FOCUSED',TTILES_FOCUSED);
      AddConstant('TOPTABITEMRIGHTEDGEStateFiller0',TOPTABITEMRIGHTEDGEStateFiller0);
      AddConstant('TTIRES_NORMAL',TTIRES_NORMAL);
      AddConstant('TTIRES_HOT',TTIRES_HOT);
      AddConstant('TTIRES_SELECTED',TTIRES_SELECTED);
      AddConstant('TTIRES_DISABLED',TTIRES_DISABLED);
      AddConstant('TTIRES_FOCUSED',TTIRES_FOCUSED);
    end;
  end;

begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('FreeThemeLibrary',0,tkNone,nil,__FreeThemeLibrary,false,0);
    DefineMethod('InitThemeLibrary',0,tkVariant,nil,__InitThemeLibrary,false,0);
    DefineMethod('UseThemes',0,tkVariant,nil,__UseThemes,false,0);
    DefineMethod('OpenThemeDataEx',3,tkInteger,nil,__OpenThemeDataEx,false,0);
    DefineMethod('DrawThemeTextEx',9,tkInteger,nil,__DrawThemeTextEx,false,0).SetVarArgs([7,8]);
    DefineMethod('SetWindowThemeNonClientAttributes',3,tkInteger,nil,__SetWindowThemeNonClientAttributes,false,0);
    DefineMethod('GetThemeBitmap',6,tkInteger,nil,__GetThemeBitmap,false,0).SetVarArgs([5]);
    DefineMethod('BufferedPaintInit',0,tkInteger,nil,__BufferedPaintInit,false,0);
    DefineMethod('BufferedPaintUnInit',0,tkInteger,nil,__BufferedPaintUnInit,false,0);
    DefineMethod('EndBufferedPaint',2,tkInteger,nil,__EndBufferedPaint,false,0);
    DefineMethod('GetBufferedPaintTargetRect',2,tkInteger,nil,__GetBufferedPaintTargetRect,false,0).SetVarArgs([1]);
    DefineMethod('GetBufferedPaintTargetDC',1,tkInteger,nil,__GetBufferedPaintTargetDC,false,0);
    DefineMethod('GetBufferedPaintDC',1,tkInteger,nil,__GetBufferedPaintDC,false,0);
    DefineMethod('BufferedPaintMakeOpaque',2,tkInteger,nil,__BufferedPaintMakeOpaque,false,0);
    DefineMethod('BufferedPaintStopAllAnimations',1,tkInteger,nil,__BufferedPaintStopAllAnimations,false,0);
    DefineMethod('EndBufferedAnimation',2,tkInteger,nil,__EndBufferedAnimation,false,0);
    DefineMethod('BufferedPaintRenderAnimation',2,tkVariant,nil,__BufferedPaintRenderAnimation,false,0);
    DefineMethod('IsCompositionActive',0,tkVariant,nil,__IsCompositionActive,false,0);
    DefineMethod('GetThemeTransitionDuration',6,tkInteger,nil,__GetThemeTransitionDuration,false,0).SetVarArgs([5]);
    AddConsts1;
    AddConstant('TOPTABITEMBOTHEDGESStateFiller0',TOPTABITEMBOTHEDGESStateFiller0);
    AddConstant('TTIBES_NORMAL',TTIBES_NORMAL);
    AddConstant('TTIBES_HOT',TTIBES_HOT);
    AddConstant('TTIBES_SELECTED',TTIBES_SELECTED);
    AddConstant('TTIBES_DISABLED',TTIBES_DISABLED);
    AddConstant('TTIBES_FOCUSED',TTIBES_FOCUSED);
    AddConstant('VSCLASS_TRACKBARSTYLE',VSCLASS_TRACKBARSTYLE);
    AddConstant('VSCLASS_TRACKBAR',VSCLASS_TRACKBAR);
    AddConstant('TRACKBARPartFiller0',TRACKBARPartFiller0);
    AddConstant('TKP_TRACK',TKP_TRACK);
    AddConstant('TKP_TRACKVERT',TKP_TRACKVERT);
    AddConstant('TKP_THUMB',TKP_THUMB);
    AddConstant('TKP_THUMBBOTTOM',TKP_THUMBBOTTOM);
    AddConstant('TKP_THUMBTOP',TKP_THUMBTOP);
    AddConstant('TKP_THUMBVERT',TKP_THUMBVERT);
    AddConstant('TKP_THUMBLEFT',TKP_THUMBLEFT);
    AddConstant('TKP_THUMBRIGHT',TKP_THUMBRIGHT);
    AddConstant('TKP_TICS',TKP_TICS);
    AddConstant('TKP_TICSVERT',TKP_TICSVERT);
    AddConstant('TRACKBARStateFiller0',TRACKBARStateFiller0);
    AddConstant('TKS_NORMAL',TKS_NORMAL);
    AddConstant('TRACKStateFiller0',TRACKStateFiller0);
    AddConstant('TRS_NORMAL',TRS_NORMAL);
    AddConstant('TRACKVERTStateFiller0',TRACKVERTStateFiller0);
    AddConstant('TRVS_NORMAL',TRVS_NORMAL);
    AddConstant('THUMBStateFiller0',THUMBStateFiller0);
    AddConstant('TUS_NORMAL',TUS_NORMAL);
    AddConstant('TUS_HOT',TUS_HOT);
    AddConstant('TUS_PRESSED',TUS_PRESSED);
    AddConstant('TUS_FOCUSED',TUS_FOCUSED);
    AddConstant('TUS_DISABLED',TUS_DISABLED);
    AddConstant('THUMBBOTTOMStateFiller0',THUMBBOTTOMStateFiller0);
    AddConstant('TUBS_NORMAL',TUBS_NORMAL);
    AddConstant('TUBS_HOT',TUBS_HOT);
    AddConstant('TUBS_PRESSED',TUBS_PRESSED);
    AddConstant('TUBS_FOCUSED',TUBS_FOCUSED);
    AddConstant('TUBS_DISABLED',TUBS_DISABLED);
    AddConstant('THUMBTOPStateFiller0',THUMBTOPStateFiller0);
    AddConstant('TUTS_NORMAL',TUTS_NORMAL);
    AddConstant('TUTS_HOT',TUTS_HOT);
    AddConstant('TUTS_PRESSED',TUTS_PRESSED);
    AddConstant('TUTS_FOCUSED',TUTS_FOCUSED);
    AddConstant('TUTS_DISABLED',TUTS_DISABLED);
    AddConstant('THUMBVERTStateFiller0',THUMBVERTStateFiller0);
    AddConstant('TUVS_NORMAL',TUVS_NORMAL);
    AddConstant('TUVS_HOT',TUVS_HOT);
    AddConstant('TUVS_PRESSED',TUVS_PRESSED);
    AddConstant('TUVS_FOCUSED',TUVS_FOCUSED);
    AddConstant('TUVS_DISABLED',TUVS_DISABLED);
    AddConstant('THUMBLEFTStateFiller0',THUMBLEFTStateFiller0);
    AddConstant('TUVLS_NORMAL',TUVLS_NORMAL);
    AddConstant('TUVLS_HOT',TUVLS_HOT);
    AddConstant('TUVLS_PRESSED',TUVLS_PRESSED);
    AddConstant('TUVLS_FOCUSED',TUVLS_FOCUSED);
    AddConstant('TUVLS_DISABLED',TUVLS_DISABLED);
    AddConstant('THUMBRIGHTStateFiller0',THUMBRIGHTStateFiller0);
    AddConstant('TUVRS_NORMAL',TUVRS_NORMAL);
    AddConstant('TUVRS_HOT',TUVRS_HOT);
    AddConstant('TUVRS_PRESSED',TUVRS_PRESSED);
    AddConstant('TUVRS_FOCUSED',TUVRS_FOCUSED);
    AddConstant('TUVRS_DISABLED',TUVRS_DISABLED);
    AddConstant('TICSStateFiller0',TICSStateFiller0);
    AddConstant('TSS_NORMAL',TSS_NORMAL);
    AddConstant('TICSVERTStateFiller0',TICSVERTStateFiller0);
    AddConstant('TSVS_NORMAL',TSVS_NORMAL);
    AddConstant('VSCLASS_TOOLTIPSTYLE',VSCLASS_TOOLTIPSTYLE);
    AddConstant('VSCLASS_TOOLTIP',VSCLASS_TOOLTIP);
    AddConstant('TOOLTIPPartFiller0',TOOLTIPPartFiller0);
    AddConstant('TTP_STANDARD',TTP_STANDARD);
    AddConstant('TTP_STANDARDTITLE',TTP_STANDARDTITLE);
    AddConstant('TTP_BALLOON',TTP_BALLOON);
    AddConstant('TTP_BALLOONTITLE',TTP_BALLOONTITLE);
    AddConstant('TTP_CLOSE',TTP_CLOSE);
    AddConstant('TTP_BALLOONSTEM',TTP_BALLOONSTEM);
    AddConstant('CLOSEStateFiller0',CLOSEStateFiller0);
    AddConstant('TTCS_NORMAL',TTCS_NORMAL);
    AddConstant('TTCS_HOT',TTCS_HOT);
    AddConstant('TTCS_PRESSED',TTCS_PRESSED);
    AddConstant('STANDARDStateFiller0',STANDARDStateFiller0);
    AddConstant('TTSS_NORMAL',TTSS_NORMAL);
    AddConstant('TTSS_LINK',TTSS_LINK);
    AddConstant('BALLOONStateFiller0',BALLOONStateFiller0);
    AddConstant('TTBS_NORMAL',TTBS_NORMAL);
    AddConstant('TTBS_LINK',TTBS_LINK);
    AddConstant('TTBSS_POINTINGUPLEFTWALL',TTBSS_POINTINGUPLEFTWALL);
    AddConstant('TTBSS_POINTINGUPCENTERED',TTBSS_POINTINGUPCENTERED);
    AddConstant('TTBSS_POINTINGUPRIGHTWALL',TTBSS_POINTINGUPRIGHTWALL);
    AddConstant('TTBSS_POINTINGDOWNRIGHTWALL',TTBSS_POINTINGDOWNRIGHTWALL);
    AddConstant('TTBSS_POINTINGDOWNCENTERED',TTBSS_POINTINGDOWNCENTERED);
    AddConstant('TTBSS_POINTINGDOWNLEFTWALL',TTBSS_POINTINGDOWNLEFTWALL);
    AddConstant('VSCLASS_TREEVIEWSTYLE',VSCLASS_TREEVIEWSTYLE);
    AddConstant('VSCLASS_TREEVIEW',VSCLASS_TREEVIEW);
    AddConstant('TREEVIEWPartFiller0',TREEVIEWPartFiller0);
    AddConstant('TVP_TREEITEM',TVP_TREEITEM);
    AddConstant('TVP_GLYPH',TVP_GLYPH);
    AddConstant('TVP_BRANCH',TVP_BRANCH);
    AddConstant('TVP_HOTGLYPH',TVP_HOTGLYPH);
    AddConstant('TREEITEMStateFiller0',TREEITEMStateFiller0);
    AddConstant('TREIS_NORMAL',TREIS_NORMAL);
    AddConstant('TREIS_HOT',TREIS_HOT);
    AddConstant('TREIS_SELECTED',TREIS_SELECTED);
    AddConstant('TREIS_DISABLED',TREIS_DISABLED);
    AddConstant('TREIS_SELECTEDNOTFOCUS',TREIS_SELECTEDNOTFOCUS);
    AddConstant('TREIS_HOTSELECTED',TREIS_HOTSELECTED);
    AddConstant('GLYPHStateFiller0',GLYPHStateFiller0);
    AddConstant('GLPS_CLOSED',GLPS_CLOSED);
    AddConstant('GLPS_OPENED',GLPS_OPENED);
    AddConstant('HGLPS_CLOSED',HGLPS_CLOSED);
    AddConstant('HGLPS_OPENED',HGLPS_OPENED);
    AddConstant('VSCLASS_SPINSTYLE',VSCLASS_SPINSTYLE);
    AddConstant('VSCLASS_SPIN',VSCLASS_SPIN);
    AddConstant('SPINPartFiller0',SPINPartFiller0);
    AddConstant('SPNP_UP',SPNP_UP);
    AddConstant('SPNP_DOWN',SPNP_DOWN);
    AddConstant('SPNP_UPHORZ',SPNP_UPHORZ);
    AddConstant('SPNP_DOWNHORZ',SPNP_DOWNHORZ);
    AddConstant('UPStateFiller0',UPStateFiller0);
    AddConstant('UPS_NORMAL',UPS_NORMAL);
    AddConstant('UPS_HOT',UPS_HOT);
    AddConstant('UPS_PRESSED',UPS_PRESSED);
    AddConstant('UPS_DISABLED',UPS_DISABLED);
    AddConstant('DOWNStateFiller0',DOWNStateFiller0);
    AddConstant('DNS_NORMAL',DNS_NORMAL);
    AddConstant('DNS_HOT',DNS_HOT);
    AddConstant('DNS_PRESSED',DNS_PRESSED);
    AddConstant('DNS_DISABLED',DNS_DISABLED);
    AddConstant('UPHORZStateFiller0',UPHORZStateFiller0);
    AddConstant('UPHZS_NORMAL',UPHZS_NORMAL);
    AddConstant('UPHZS_HOT',UPHZS_HOT);
    AddConstant('UPHZS_PRESSED',UPHZS_PRESSED);
    AddConstant('UPHZS_DISABLED',UPHZS_DISABLED);
    AddConstant('DOWNHORZStateFiller0',DOWNHORZStateFiller0);
    AddConstant('DNHZS_NORMAL',DNHZS_NORMAL);
    AddConstant('DNHZS_HOT',DNHZS_HOT);
    AddConstant('DNHZS_PRESSED',DNHZS_PRESSED);
    AddConstant('DNHZS_DISABLED',DNHZS_DISABLED);
    AddConstant('VSCLASS_PAGE',VSCLASS_PAGE);
    AddConstant('PAGEPartFiller0',PAGEPartFiller0);
    AddConstant('PGRP_UP',PGRP_UP);
    AddConstant('PGRP_DOWN',PGRP_DOWN);
    AddConstant('PGRP_UPHORZ',PGRP_UPHORZ);
    AddConstant('PGRP_DOWNHORZ',PGRP_DOWNHORZ);
    AddConstant('VSCLASS_SCROLLBARSTYLE',VSCLASS_SCROLLBARSTYLE);
    AddConstant('VSCLASS_SCROLLBAR',VSCLASS_SCROLLBAR);
    AddConstant('SCROLLBARPartFiller0',SCROLLBARPartFiller0);
    AddConstant('SBP_ARROWBTN',SBP_ARROWBTN);
    AddConstant('SBP_THUMBBTNHORZ',SBP_THUMBBTNHORZ);
    AddConstant('SBP_THUMBBTNVERT',SBP_THUMBBTNVERT);
    AddConstant('SBP_LOWERTRACKHORZ',SBP_LOWERTRACKHORZ);
    AddConstant('SBP_UPPERTRACKHORZ',SBP_UPPERTRACKHORZ);
    AddConstant('SBP_LOWERTRACKVERT',SBP_LOWERTRACKVERT);
    AddConstant('SBP_UPPERTRACKVERT',SBP_UPPERTRACKVERT);
    AddConstant('SBP_GRIPPERHORZ',SBP_GRIPPERHORZ);
    AddConstant('SBP_GRIPPERVERT',SBP_GRIPPERVERT);
    AddConstant('SBP_SIZEBOX',SBP_SIZEBOX);
    AddConstant('ARROWBTNStateFiller0',ARROWBTNStateFiller0);
    AddConstant('ABS_UPNORMAL',ABS_UPNORMAL);
    AddConstant('ABS_UPHOT',ABS_UPHOT);
    AddConstant('ABS_UPPRESSED',ABS_UPPRESSED);
    AddConstant('ABS_UPDISABLED',ABS_UPDISABLED);
    AddConstant('ABS_DOWNNORMAL',ABS_DOWNNORMAL);
    AddConstant('ABS_DOWNHOT',ABS_DOWNHOT);
    AddConstant('ABS_DOWNPRESSED',ABS_DOWNPRESSED);
    AddConstant('ABS_DOWNDISABLED',ABS_DOWNDISABLED);
    AddConstant('ABS_LEFTNORMAL',ABS_LEFTNORMAL);
    AddConstant('ABS_LEFTHOT',ABS_LEFTHOT);
    AddConstant('ABS_LEFTPRESSED',ABS_LEFTPRESSED);
    AddConstant('ABS_LEFTDISABLED',ABS_LEFTDISABLED);
    AddConstant('ABS_RIGHTNORMAL',ABS_RIGHTNORMAL);
    AddConstant('ABS_RIGHTHOT',ABS_RIGHTHOT);
    AddConstant('ABS_RIGHTPRESSED',ABS_RIGHTPRESSED);
    AddConstant('ABS_RIGHTDISABLED',ABS_RIGHTDISABLED);
    AddConstant('ABS_UPHOVER',ABS_UPHOVER);
    AddConstant('ABS_DOWNHOVER',ABS_DOWNHOVER);
    AddConstant('ABS_LEFTHOVER',ABS_LEFTHOVER);
    AddConstant('ABS_RIGHTHOVER',ABS_RIGHTHOVER);
    AddConstant('SCROLLBARStateFiller0',SCROLLBARStateFiller0);
    AddConstant('SCRBS_NORMAL',SCRBS_NORMAL);
    AddConstant('SCRBS_HOT',SCRBS_HOT);
    AddConstant('SCRBS_PRESSED',SCRBS_PRESSED);
    AddConstant('SCRBS_DISABLED',SCRBS_DISABLED);
    AddConstant('SCRBS_HOVER',SCRBS_HOVER);
    AddConstant('SIZEBOXStateFiller0',SIZEBOXStateFiller0);
    AddConstant('SZB_RIGHTALIGN',SZB_RIGHTALIGN);
    AddConstant('SZB_LEFTALIGN',SZB_LEFTALIGN);
    AddConstant('SZB_TOPRIGHTALIGN',SZB_TOPRIGHTALIGN);
    AddConstant('SZB_TOPLEFTALIGN',SZB_TOPLEFTALIGN);
    AddConstant('SZB_HALFBOTTOMRIGHTALIGN',SZB_HALFBOTTOMRIGHTALIGN);
    AddConstant('SZB_HALFBOTTOMLEFTALIGN',SZB_HALFBOTTOMLEFTALIGN);
    AddConstant('SZB_HALFTOPRIGHTALIGN',SZB_HALFTOPRIGHTALIGN);
    AddConstant('SZB_HALFTOPLEFTALIGN',SZB_HALFTOPLEFTALIGN);
    AddConstant('VSCLASS_EDITSTYLE',VSCLASS_EDITSTYLE);
    AddConstant('VSCLASS_EDIT',VSCLASS_EDIT);
    AddConstant('EDITPartFiller0',EDITPartFiller0);
    AddConstant('EP_EDITTEXT',EP_EDITTEXT);
    AddConstant('EP_CARET',EP_CARET);
    AddConstant('EP_BACKGROUND',EP_BACKGROUND);
    AddConstant('EP_PASSWORD',EP_PASSWORD);
    AddConstant('EP_BACKGROUNDWITHBORDER',EP_BACKGROUNDWITHBORDER);
    AddConstant('EP_EDITBORDER_NOSCROLL',EP_EDITBORDER_NOSCROLL);
    AddConstant('EP_EDITBORDER_HSCROLL',EP_EDITBORDER_HSCROLL);
    AddConstant('EP_EDITBORDER_VSCROLL',EP_EDITBORDER_VSCROLL);
    AddConstant('EP_EDITBORDER_HVSCROLL',EP_EDITBORDER_HVSCROLL);
    AddConstant('EDITTEXTStateFiller0',EDITTEXTStateFiller0);
    AddConstant('ETS_NORMAL',ETS_NORMAL);
    AddConstant('ETS_HOT',ETS_HOT);
    AddConstant('ETS_SELECTED',ETS_SELECTED);
    AddConstant('ETS_DISABLED',ETS_DISABLED);
    AddConstant('ETS_FOCUSED',ETS_FOCUSED);
    AddConstant('ETS_READONLY',ETS_READONLY);
    AddConstant('ETS_ASSIST',ETS_ASSIST);
    AddConstant('ETS_CUEBANNER',ETS_CUEBANNER);
    AddConstant('EBS_NORMAL',EBS_NORMAL);
    AddConstant('EBS_HOT',EBS_HOT);
    AddConstant('EBS_DISABLED',EBS_DISABLED);
    AddConstant('EBS_FOCUSED',EBS_FOCUSED);
    AddConstant('EBS_READONLY',EBS_READONLY);
    AddConstant('EBS_ASSIST',EBS_ASSIST);
    AddConstant('EBWBS_NORMAL',EBWBS_NORMAL);
    AddConstant('EBWBS_HOT',EBWBS_HOT);
    AddConstant('EBWBS_DISABLED',EBWBS_DISABLED);
    AddConstant('EBWBS_FOCUSED',EBWBS_FOCUSED);
    AddConstant('EPSN_NORMAL',EPSN_NORMAL);
    AddConstant('EPSN_HOT',EPSN_HOT);
    AddConstant('EPSN_FOCUSED',EPSN_FOCUSED);
    AddConstant('EPSN_DISABLED',EPSN_DISABLED);
    AddConstant('EPSH_NORMAL',EPSH_NORMAL);
    AddConstant('EPSH_HOT',EPSH_HOT);
    AddConstant('EPSH_FOCUSED',EPSH_FOCUSED);
    AddConstant('EPSH_DISABLED',EPSH_DISABLED);
    AddConstant('EPSV_NORMAL',EPSV_NORMAL);
    AddConstant('EPSV_HOT',EPSV_HOT);
    AddConstant('EPSV_FOCUSED',EPSV_FOCUSED);
    AddConstant('EPSV_DISABLED',EPSV_DISABLED);
    AddConstant('EPSHV_NORMAL',EPSHV_NORMAL);
    AddConstant('EPSHV_HOT',EPSHV_HOT);
    AddConstant('EPSHV_FOCUSED',EPSHV_FOCUSED);
    AddConstant('EPSHV_DISABLED',EPSHV_DISABLED);
    AddConstant('VSCLASS_COMBOBOXSTYLE',VSCLASS_COMBOBOXSTYLE);
    AddConstant('VSCLASS_COMBOBOX',VSCLASS_COMBOBOX);
    AddConstant('COMBOBOXPartFiller0',COMBOBOXPartFiller0);
    AddConstant('CP_DROPDOWNBUTTON',CP_DROPDOWNBUTTON);
    AddConstant('CP_BACKGROUND',CP_BACKGROUND);
    AddConstant('CP_TRANSPARENTBACKGROUND',CP_TRANSPARENTBACKGROUND);
    AddConstant('CP_BORDER',CP_BORDER);
    AddConstant('CP_READONLY',CP_READONLY);
    AddConstant('CP_DROPDOWNBUTTONRIGHT',CP_DROPDOWNBUTTONRIGHT);
    AddConstant('CP_DROPDOWNBUTTONLEFT',CP_DROPDOWNBUTTONLEFT);
    AddConstant('CP_CUEBANNER',CP_CUEBANNER);
    AddConstant('COMBOBOXStateFiller0',COMBOBOXStateFiller0);
    AddConstant('CBXS_NORMAL',CBXS_NORMAL);
    AddConstant('CBXS_HOT',CBXS_HOT);
    AddConstant('CBXS_PRESSED',CBXS_PRESSED);
    AddConstant('CBXS_DISABLED',CBXS_DISABLED);
    AddConstant('CBXSR_NORMAL',CBXSR_NORMAL);
    AddConstant('CBXSR_HOT',CBXSR_HOT);
    AddConstant('CBXSR_PRESSED',CBXSR_PRESSED);
    AddConstant('CBXSR_DISABLED',CBXSR_DISABLED);
    AddConstant('CBXSL_NORMAL',CBXSL_NORMAL);
    AddConstant('CBXSL_HOT',CBXSL_HOT);
    AddConstant('CBXSL_PRESSED',CBXSL_PRESSED);
    AddConstant('CBXSL_DISABLED',CBXSL_DISABLED);
    AddConstant('CBTBS_NORMAL',CBTBS_NORMAL);
    AddConstant('CBTBS_HOT',CBTBS_HOT);
    AddConstant('CBTBS_DISABLED',CBTBS_DISABLED);
    AddConstant('CBTBS_FOCUSED',CBTBS_FOCUSED);
    AddConstant('CBB_NORMAL',CBB_NORMAL);
    AddConstant('CBB_HOT',CBB_HOT);
    AddConstant('CBB_FOCUSED',CBB_FOCUSED);
    AddConstant('CBB_DISABLED',CBB_DISABLED);
    AddConstant('CBRO_NORMAL',CBRO_NORMAL);
    AddConstant('CBRO_HOT',CBRO_HOT);
    AddConstant('CBRO_PRESSED',CBRO_PRESSED);
    AddConstant('CBRO_DISABLED',CBRO_DISABLED);
    AddConstant('CBCB_NORMAL',CBCB_NORMAL);
    AddConstant('CBCB_HOT',CBCB_HOT);
    AddConstant('CBCB_PRESSED',CBCB_PRESSED);
    AddConstant('CBCB_DISABLED',CBCB_DISABLED);
    AddConstant('VSCLASS_CLOCK',VSCLASS_CLOCK);
    AddConstant('CLOCKPartFiller0',CLOCKPartFiller0);
    AddConstant('CLP_TIME',CLP_TIME);
    AddConstant('CLOCKStateFiller0',CLOCKStateFiller0);
    AddConstant('CLS_NORMAL',CLS_NORMAL);
    AddConstant('VSCLASS_TRAYNOTIFY',VSCLASS_TRAYNOTIFY);
    AddConstant('TRAYNOTIFYPartFiller0',TRAYNOTIFYPartFiller0);
    AddConstant('TNP_BACKGROUND',TNP_BACKGROUND);
    AddConstant('TNP_ANIMBACKGROUND',TNP_ANIMBACKGROUND);
    AddConstant('VSCLASS_TASKBAR',VSCLASS_TASKBAR);
    AddConstant('TASKBARPartFiller0',TASKBARPartFiller0);
    AddConstant('TBP_BACKGROUNDBOTTOM',TBP_BACKGROUNDBOTTOM);
    AddConstant('TBP_BACKGROUNDRIGHT',TBP_BACKGROUNDRIGHT);
    AddConstant('TBP_BACKGROUNDTOP',TBP_BACKGROUNDTOP);
    AddConstant('TBP_BACKGROUNDLEFT',TBP_BACKGROUNDLEFT);
    AddConstant('TBP_SIZINGBARBOTTOM',TBP_SIZINGBARBOTTOM);
    AddConstant('TBP_SIZINGBARRIGHT',TBP_SIZINGBARRIGHT);
    AddConstant('TBP_SIZINGBARTOP',TBP_SIZINGBARTOP);
    AddConstant('TBP_SIZINGBARLEFT',TBP_SIZINGBARLEFT);
    AddConstant('VSCLASS_TASKBAND',VSCLASS_TASKBAND);
    AddConstant('TASKBANDPartFiller0',TASKBANDPartFiller0);
    AddConstant('TDP_GROUPCOUNT',TDP_GROUPCOUNT);
    AddConstant('TDP_FLASHBUTTON',TDP_FLASHBUTTON);
    AddConstant('TDP_FLASHBUTTONGROUPMENU',TDP_FLASHBUTTONGROUPMENU);
    AddConstant('VSCLASS_STARTPANEL',VSCLASS_STARTPANEL);
    AddConstant('STARTPANELPartFiller0',STARTPANELPartFiller0);
    AddConstant('SPP_USERPANE',SPP_USERPANE);
    AddConstant('SPP_MOREPROGRAMS',SPP_MOREPROGRAMS);
    AddConstant('SPP_MOREPROGRAMSARROW',SPP_MOREPROGRAMSARROW);
    AddConstant('SPP_PROGLIST',SPP_PROGLIST);
    AddConstant('SPP_PROGLISTSEPARATOR',SPP_PROGLISTSEPARATOR);
    AddConstant('SPP_PLACESLIST',SPP_PLACESLIST);
    AddConstant('SPP_PLACESLISTSEPARATOR',SPP_PLACESLISTSEPARATOR);
    AddConstant('SPP_LOGOFF',SPP_LOGOFF);
    AddConstant('SPP_LOGOFFBUTTONS',SPP_LOGOFFBUTTONS);
    AddConstant('SPP_USERPICTURE',SPP_USERPICTURE);
    AddConstant('SPP_PREVIEW',SPP_PREVIEW);
    AddConstant('SPP_MOREPROGRAMSTAB',SPP_MOREPROGRAMSTAB);
    AddConstant('SPP_NSCHOST',SPP_NSCHOST);
    AddConstant('SPP_SOFTWAREEXPLORER',SPP_SOFTWAREEXPLORER);
    AddConstant('SPP_OPENBOX',SPP_OPENBOX);
    AddConstant('SPP_SEARCHVIEW',SPP_SEARCHVIEW);
    AddConstant('SPP_MOREPROGRAMSARROWBACK',SPP_MOREPROGRAMSARROWBACK);
    AddConstant('SPP_TOPMATCH',SPP_TOPMATCH);
    AddConstant('SPP_LOGOFFSPLITBUTTONDROPDOWN',SPP_LOGOFFSPLITBUTTONDROPDOWN);
    AddConstant('SPMPT_NORMAL',SPMPT_NORMAL);
    AddConstant('SPMPT_HOT',SPMPT_HOT);
    AddConstant('SPMPT_SELECTED',SPMPT_SELECTED);
    AddConstant('SPMPT_DISABLED',SPMPT_DISABLED);
    AddConstant('SPMPT_FOCUSED',SPMPT_FOCUSED);
    AddConstant('MOREPROGRAMSARROWStateFiller0',MOREPROGRAMSARROWStateFiller0);
    AddConstant('SPS_NORMAL',SPS_NORMAL);
    AddConstant('SPS_HOT',SPS_HOT);
    AddConstant('SPS_PRESSED',SPS_PRESSED);
    AddConstant('SPSE_NORMAL',SPSE_NORMAL);
    AddConstant('SPSE_HOT',SPSE_HOT);
    AddConstant('SPSE_SELECTED',SPSE_SELECTED);
    AddConstant('SPSE_DISABLED',SPSE_DISABLED);
    AddConstant('SPSE_FOCUSED',SPSE_FOCUSED);
    AddConstant('SPOB_NORMAL',SPOB_NORMAL);
    AddConstant('SPOB_HOT',SPOB_HOT);
    AddConstant('SPOB_SELECTED',SPOB_SELECTED);
    AddConstant('SPOB_DISABLED',SPOB_DISABLED);
    AddConstant('SPOB_FOCUSED',SPOB_FOCUSED);
    AddConstant('SPSB_NORMAL',SPSB_NORMAL);
    AddConstant('SPSB_HOT',SPSB_HOT);
    AddConstant('SPSB_PRESSED',SPSB_PRESSED);
    AddConstant('LOGOFFBUTTONSStateFiller0',LOGOFFBUTTONSStateFiller0);
    AddConstant('SPLS_NORMAL',SPLS_NORMAL);
    AddConstant('SPLS_HOT',SPLS_HOT);
    AddConstant('SPLS_PRESSED',SPLS_PRESSED);
    AddConstant('VSCLASS_EXPLORERBARSTYLE',VSCLASS_EXPLORERBARSTYLE);
    AddConstant('VSCLASS_EXPLORERBAR',VSCLASS_EXPLORERBAR);
    AddConstant('EXPLORERBARPartFiller0',EXPLORERBARPartFiller0);
    AddConstant('EBP_HEADERBACKGROUND',EBP_HEADERBACKGROUND);
    AddConstant('EBP_HEADERCLOSE',EBP_HEADERCLOSE);
    AddConstant('EBP_HEADERPIN',EBP_HEADERPIN);
    AddConstant('EBP_IEBARMENU',EBP_IEBARMENU);
    AddConstant('EBP_NORMALGROUPBACKGROUND',EBP_NORMALGROUPBACKGROUND);
    AddConstant('EBP_NORMALGROUPCOLLAPSE',EBP_NORMALGROUPCOLLAPSE);
    AddConstant('EBP_NORMALGROUPEXPAND',EBP_NORMALGROUPEXPAND);
    AddConstant('EBP_NORMALGROUPHEAD',EBP_NORMALGROUPHEAD);
    AddConstant('EBP_SPECIALGROUPBACKGROUND',EBP_SPECIALGROUPBACKGROUND);
    AddConstant('EBP_SPECIALGROUPCOLLAPSE',EBP_SPECIALGROUPCOLLAPSE);
    AddConstant('EBP_SPECIALGROUPEXPAND',EBP_SPECIALGROUPEXPAND);
    AddConstant('EBP_SPECIALGROUPHEAD',EBP_SPECIALGROUPHEAD);
    AddConstant('HEADERCLOSEStateFiller0',HEADERCLOSEStateFiller0);
    AddConstant('EBHC_NORMAL',EBHC_NORMAL);
    AddConstant('EBHC_HOT',EBHC_HOT);
    AddConstant('EBHC_PRESSED',EBHC_PRESSED);
    AddConstant('HEADERPINStateFiller0',HEADERPINStateFiller0);
    AddConstant('EBHP_NORMAL',EBHP_NORMAL);
    AddConstant('EBHP_HOT',EBHP_HOT);
    AddConstant('EBHP_PRESSED',EBHP_PRESSED);
    AddConstant('EBHP_SELECTEDNORMAL',EBHP_SELECTEDNORMAL);
    AddConstant('EBHP_SELECTEDHOT',EBHP_SELECTEDHOT);
    AddConstant('EBHP_SELECTEDPRESSED',EBHP_SELECTEDPRESSED);
    AddConstant('IEBARMENUStateFiller0',IEBARMENUStateFiller0);
    AddConstant('EBM_NORMAL',EBM_NORMAL);
    AddConstant('EBM_HOT',EBM_HOT);
    AddConstant('EBM_PRESSED',EBM_PRESSED);
    AddConstant('NORMALGROUPCOLLAPSEStateFiller0',NORMALGROUPCOLLAPSEStateFiller0);
    AddConstant('EBNGC_NORMAL',EBNGC_NORMAL);
    AddConstant('EBNGC_HOT',EBNGC_HOT);
    AddConstant('EBNGC_PRESSED',EBNGC_PRESSED);
    AddConstant('NORMALGROUPEXPANDStateFiller0',NORMALGROUPEXPANDStateFiller0);
    AddConstant('EBNGE_NORMAL',EBNGE_NORMAL);
    AddConstant('EBNGE_HOT',EBNGE_HOT);
    AddConstant('EBNGE_PRESSED',EBNGE_PRESSED);
    AddConstant('SPECIALGROUPCOLLAPSEStateFiller0',SPECIALGROUPCOLLAPSEStateFiller0);
    AddConstant('EBSGC_NORMAL',EBSGC_NORMAL);
    AddConstant('EBSGC_HOT',EBSGC_HOT);
    AddConstant('EBSGC_PRESSED',EBSGC_PRESSED);
    AddConstant('SPECIALGROUPEXPANDStateFiller0',SPECIALGROUPEXPANDStateFiller0);
    AddConstant('EBSGE_NORMAL',EBSGE_NORMAL);
    AddConstant('EBSGE_HOT',EBSGE_HOT);
    AddConstant('EBSGE_PRESSED',EBSGE_PRESSED);
    AddConstant('VSCLASS_MENUBAND',VSCLASS_MENUBAND);
    AddConstant('MENUBANDPartFiller0',MENUBANDPartFiller0);
    AddConstant('MDP_NEWAPPBUTTON',MDP_NEWAPPBUTTON);
    AddConstant('MDP_SEPERATOR',MDP_SEPERATOR);
    AddConstant('MENUBANDStateFiller0',MENUBANDStateFiller0);
    AddConstant('MDS_NORMAL',MDS_NORMAL);
    AddConstant('MDS_HOT',MDS_HOT);
    AddConstant('MDS_PRESSED',MDS_PRESSED);
    AddConstant('MDS_DISABLED',MDS_DISABLED);
    AddConstant('MDS_CHECKED',MDS_CHECKED);
    AddConstant('MDS_HOTCHECKED',MDS_HOTCHECKED);
    AddConstant('VSCLASS_AEROWIZARDSTYLE',VSCLASS_AEROWIZARDSTYLE);
    AddConstant('VSCLASS_AEROWIZARD',VSCLASS_AEROWIZARD);
    AddConstant('AW_TITLEBAR',AW_TITLEBAR);
    AddConstant('AW_HEADERAREA',AW_HEADERAREA);
    AddConstant('AW_CONTENTAREA',AW_CONTENTAREA);
    AddConstant('AW_COMMANDAREA',AW_COMMANDAREA);
    AddConstant('AW_BUTTON',AW_BUTTON);
    AddConstant('AW_S_TITLEBAR_ACTIVE',AW_S_TITLEBAR_ACTIVE);
    AddConstant('AW_S_TITLEBAR_INACTIVE',AW_S_TITLEBAR_INACTIVE);
    AddConstant('AW_S_HEADERAREA_NOMARGIN',AW_S_HEADERAREA_NOMARGIN);
    AddConstant('AW_S_CONTENTAREA_NOMARGIN',AW_S_CONTENTAREA_NOMARGIN);
    AddConstant('VSCLASS_COMMUNICATIONSSTYLE',VSCLASS_COMMUNICATIONSSTYLE);
    AddConstant('VSCLASS_COMMUNICATIONS',VSCLASS_COMMUNICATIONS);
    AddConstant('CSST_TAB',CSST_TAB);
    AddConstant('CSTB_NORMAL',CSTB_NORMAL);
    AddConstant('CSTB_HOT',CSTB_HOT);
    AddConstant('CSTB_SELECTED',CSTB_SELECTED);
    AddConstant('VSCLASS_CONTROLPANELSTYLE',VSCLASS_CONTROLPANELSTYLE);
    AddConstant('VSCLASS_CONTROLPANEL',VSCLASS_CONTROLPANEL);
    AddConstant('CPANEL_NAVIGATIONPANE',CPANEL_NAVIGATIONPANE);
    AddConstant('CPANEL_CONTENTPANE',CPANEL_CONTENTPANE);
    AddConstant('CPANEL_NAVIGATIONPANELABEL',CPANEL_NAVIGATIONPANELABEL);
    AddConstant('CPANEL_CONTENTPANELABEL',CPANEL_CONTENTPANELABEL);
    AddConstant('CPANEL_TITLE',CPANEL_TITLE);
    AddConstant('CPANEL_BODYTEXT',CPANEL_BODYTEXT);
    AddConstant('CPANEL_HELPLINK',CPANEL_HELPLINK);
    AddConstant('CPANEL_TASKLINK',CPANEL_TASKLINK);
    AddConstant('CPANEL_GROUPTEXT',CPANEL_GROUPTEXT);
    AddConstant('CPANEL_CONTENTLINK',CPANEL_CONTENTLINK);
    AddConstant('CPANEL_SECTIONTITLELINK',CPANEL_SECTIONTITLELINK);
    AddConstant('CPANEL_LARGECOMMANDAREA',CPANEL_LARGECOMMANDAREA);
    AddConstant('CPANEL_SMALLCOMMANDAREA',CPANEL_SMALLCOMMANDAREA);
    AddConstant('CPANEL_BUTTON',CPANEL_BUTTON);
    AddConstant('CPANEL_MESSAGETEXT',CPANEL_MESSAGETEXT);
    AddConstant('CPANEL_NAVIGATIONPANELINE',CPANEL_NAVIGATIONPANELINE);
    AddConstant('CPANEL_CONTENTPANELINE',CPANEL_CONTENTPANELINE);
    AddConstant('CPANEL_BANNERAREA',CPANEL_BANNERAREA);
    AddConstant('CPANEL_BODYTITLE',CPANEL_BODYTITLE);
    AddConstant('CPHL_NORMAL',CPHL_NORMAL);
    AddConstant('CPHL_HOT',CPHL_HOT);
    AddConstant('CPHL_PRESSED',CPHL_PRESSED);
    AddConstant('CPHL_DISABLED',CPHL_DISABLED);
    AddConstant('CPTL_NORMAL',CPTL_NORMAL);
    AddConstant('CPTL_HOT',CPTL_HOT);
    AddConstant('CPTL_PRESSED',CPTL_PRESSED);
    AddConstant('CPTL_DISABLED',CPTL_DISABLED);
    AddConstant('CPTL_PAGE',CPTL_PAGE);
    AddConstant('CPCL_NORMAL',CPCL_NORMAL);
    AddConstant('CPCL_HOT',CPCL_HOT);
    AddConstant('CPCL_PRESSED',CPCL_PRESSED);
    AddConstant('CPCL_DISABLED',CPCL_DISABLED);
    AddConstant('CPSTL_NORMAL',CPSTL_NORMAL);
    AddConstant('CPSTL_HOT',CPSTL_HOT);
    AddConstant('VSCLASS_DATEPICKERSTYLE',VSCLASS_DATEPICKERSTYLE);
    AddConstant('VSCLASS_DATEPICKER',VSCLASS_DATEPICKER);
    AddConstant('DP_DATETEXT',DP_DATETEXT);
    AddConstant('DP_DATEBORDER',DP_DATEBORDER);
    AddConstant('DP_SHOWCALENDARBUTTONRIGHT',DP_SHOWCALENDARBUTTONRIGHT);
    AddConstant('DPDT_NORMAL',DPDT_NORMAL);
    AddConstant('DPDT_DISABLED',DPDT_DISABLED);
    AddConstant('DPDT_SELECTED',DPDT_SELECTED);
    AddConstant('DPDB_NORMAL',DPDB_NORMAL);
    AddConstant('DPDB_HOT',DPDB_HOT);
    AddConstant('DPDB_FOCUSED',DPDB_FOCUSED);
    AddConstant('DPDB_DISABLED',DPDB_DISABLED);
    AddConstant('DPSCBR_NORMAL',DPSCBR_NORMAL);
    AddConstant('DPSCBR_HOT',DPSCBR_HOT);
    AddConstant('DPSCBR_PRESSED',DPSCBR_PRESSED);
    AddConstant('DPSCBR_DISABLED',DPSCBR_DISABLED);
    AddConstant('VSCLASS_DRAGDROPSTYLE',VSCLASS_DRAGDROPSTYLE);
    AddConstant('VSCLASS_DRAGDROP',VSCLASS_DRAGDROP);
    AddConstant('DD_COPY',DD_COPY);
    AddConstant('DD_MOVE',DD_MOVE);
    AddConstant('DD_UPDATEMETADATA',DD_UPDATEMETADATA);
    AddConstant('DD_CREATELINK',DD_CREATELINK);
    AddConstant('DD_WARNING',DD_WARNING);
    AddConstant('DD_NONE',DD_NONE);
    AddConstant('DD_IMAGEBG',DD_IMAGEBG);
    AddConstant('DD_TEXTBG',DD_TEXTBG);
    AddConstant('DDCOPY_HIGHLIGHT',DDCOPY_HIGHLIGHT);
    AddConstant('DDCOPY_NOHIGHLIGHT',DDCOPY_NOHIGHLIGHT);
    AddConstant('DDMOVE_HIGHLIGHT',DDMOVE_HIGHLIGHT);
    AddConstant('DDMOVE_NOHIGHLIGHT',DDMOVE_NOHIGHLIGHT);
    AddConstant('DDUPDATEMETADATA_HIGHLIGHT',DDUPDATEMETADATA_HIGHLIGHT);
    AddConstant('DDUPDATEMETADATA_NOHIGHLIGHT',DDUPDATEMETADATA_NOHIGHLIGHT);
    AddConstant('DDCREATELINK_HIGHLIGHT',DDCREATELINK_HIGHLIGHT);
    AddConstant('DDCREATELINK_NOHIGHLIGHT',DDCREATELINK_NOHIGHLIGHT);
    AddConstant('DDWARNING_HIGHLIGHT',DDWARNING_HIGHLIGHT);
    AddConstant('DDWARNING_NOHIGHLIGHT',DDWARNING_NOHIGHLIGHT);
    AddConstant('DDNONE_HIGHLIGHT',DDNONE_HIGHLIGHT);
    AddConstant('DDNONE_NOHIGHLIGHT',DDNONE_NOHIGHLIGHT);
    AddConstant('VSCLASS_FLYOUTSTYLE',VSCLASS_FLYOUTSTYLE);
    AddConstant('VSCLASS_FLYOUT',VSCLASS_FLYOUT);
    AddConstant('FLYOUT_HEADER',FLYOUT_HEADER);
    AddConstant('FLYOUT_BODY',FLYOUT_BODY);
    AddConstant('FLYOUT_LABEL',FLYOUT_LABEL);
    AddConstant('FLYOUT_LINK',FLYOUT_LINK);
    AddConstant('FLYOUT_DIVIDER',FLYOUT_DIVIDER);
    AddConstant('FLYOUT_WINDOW',FLYOUT_WINDOW);
    AddConstant('FLYOUT_LINKAREA',FLYOUT_LINKAREA);
    AddConstant('FLYOUT_LINKHEADER',FLYOUT_LINKHEADER);
    AddConstant('FLS_NORMAL',FLS_NORMAL);
    AddConstant('FLS_SELECTED',FLS_SELECTED);
    AddConstant('FLS_EMPHASIZED',FLS_EMPHASIZED);
    AddConstant('FLS_DISABLED',FLS_DISABLED);
    AddConstant('FLYOUTLINK_NORMAL',FLYOUTLINK_NORMAL);
    AddConstant('FLYOUTLINK_HOVER',FLYOUTLINK_HOVER);
    AddConstant('FBS_NORMAL',FBS_NORMAL);
    AddConstant('FBS_EMPHASIZED',FBS_EMPHASIZED);
    AddConstant('FLH_NORMAL',FLH_NORMAL);
    AddConstant('FLH_HOVER',FLH_HOVER);
    AddConstant('VSCLASS_LISTBOXSTYLE',VSCLASS_LISTBOXSTYLE);
    AddConstant('VSCLASS_LISTBOX',VSCLASS_LISTBOX);
    AddConstant('LBCP_BORDER_HSCROLL',LBCP_BORDER_HSCROLL);
    AddConstant('LBCP_BORDER_HVSCROLL',LBCP_BORDER_HVSCROLL);
    AddConstant('LBCP_BORDER_NOSCROLL',LBCP_BORDER_NOSCROLL);
    AddConstant('LBCP_BORDER_VSCROLL',LBCP_BORDER_VSCROLL);
    AddConstant('LBCP_ITEM',LBCP_ITEM);
    AddConstant('LBPSH_NORMAL',LBPSH_NORMAL);
    AddConstant('LBPSH_FOCUSED',LBPSH_FOCUSED);
    AddConstant('LBPSH_HOT',LBPSH_HOT);
    AddConstant('LBPSH_DISABLED',LBPSH_DISABLED);
    AddConstant('LBPSHV_NORMAL',LBPSHV_NORMAL);
    AddConstant('LBPSHV_FOCUSED',LBPSHV_FOCUSED);
    AddConstant('LBPSHV_HOT',LBPSHV_HOT);
    AddConstant('LBPSHV_DISABLED',LBPSHV_DISABLED);
    AddConstant('LBPSN_NORMAL',LBPSN_NORMAL);
    AddConstant('LBPSN_FOCUSED',LBPSN_FOCUSED);
    AddConstant('LBPSN_HOT',LBPSN_HOT);
    AddConstant('LBPSN_DISABLED',LBPSN_DISABLED);
    AddConstant('LBPSV_NORMAL',LBPSV_NORMAL);
    AddConstant('LBPSV_FOCUSED',LBPSV_FOCUSED);
    AddConstant('LBPSV_HOT',LBPSV_HOT);
    AddConstant('LBPSV_DISABLED',LBPSV_DISABLED);
    AddConstant('LBPSI_HOT',LBPSI_HOT);
    AddConstant('LBPSI_HOTSELECTED',LBPSI_HOTSELECTED);
    AddConstant('LBPSI_SELECTED',LBPSI_SELECTED);
    AddConstant('LBPSI_SELECTEDNOTFOCUS',LBPSI_SELECTEDNOTFOCUS);
    AddConstant('VSCLASS_NAVIGATION',VSCLASS_NAVIGATION);
    AddConstant('NAV_BACKBUTTON',NAV_BACKBUTTON);
    AddConstant('NAV_FORWARDBUTTON',NAV_FORWARDBUTTON);
    AddConstant('NAV_MENUBUTTON',NAV_MENUBUTTON);
    AddConstant('NAV_BB_NORMAL',NAV_BB_NORMAL);
    AddConstant('NAV_BB_HOT',NAV_BB_HOT);
    AddConstant('NAV_BB_PRESSED',NAV_BB_PRESSED);
    AddConstant('NAV_BB_DISABLED',NAV_BB_DISABLED);
    AddConstant('NAV_FB_NORMAL',NAV_FB_NORMAL);
    AddConstant('NAV_FB_HOT',NAV_FB_HOT);
    AddConstant('NAV_FB_PRESSED',NAV_FB_PRESSED);
    AddConstant('NAV_FB_DISABLED',NAV_FB_DISABLED);
    AddConstant('NAV_MB_NORMAL',NAV_MB_NORMAL);
    AddConstant('NAV_MB_HOT',NAV_MB_HOT);
    AddConstant('NAV_MB_PRESSED',NAV_MB_PRESSED);
    AddConstant('NAV_MB_DISABLED',NAV_MB_DISABLED);
    AddConstant('VSCLASS_TASKDIALOGSTYLE',VSCLASS_TASKDIALOGSTYLE);
    AddConstant('VSCLASS_TASKDIALOG',VSCLASS_TASKDIALOG);
    AddConstant('TDLG_PRIMARYPANEL',TDLG_PRIMARYPANEL);
    AddConstant('TDLG_MAININSTRUCTIONPANE',TDLG_MAININSTRUCTIONPANE);
    AddConstant('TDLG_MAINICON',TDLG_MAINICON);
    AddConstant('TDLG_CONTENTPANE',TDLG_CONTENTPANE);
    AddConstant('TDLG_CONTENTICON',TDLG_CONTENTICON);
    AddConstant('TDLG_EXPANDEDCONTENT',TDLG_EXPANDEDCONTENT);
    AddConstant('TDLG_COMMANDLINKPANE',TDLG_COMMANDLINKPANE);
    AddConstant('TDLG_SECONDARYPANEL',TDLG_SECONDARYPANEL);
    AddConstant('TDLG_CONTROLPANE',TDLG_CONTROLPANE);
    AddConstant('TDLG_BUTTONSECTION',TDLG_BUTTONSECTION);
    AddConstant('TDLG_BUTTONWRAPPER',TDLG_BUTTONWRAPPER);
    AddConstant('TDLG_EXPANDOTEXT',TDLG_EXPANDOTEXT);
    AddConstant('TDLG_EXPANDOBUTTON',TDLG_EXPANDOBUTTON);
    AddConstant('TDLG_VERIFICATIONTEXT',TDLG_VERIFICATIONTEXT);
    AddConstant('TDLG_FOOTNOTEPANE',TDLG_FOOTNOTEPANE);
    AddConstant('TDLG_FOOTNOTEAREA',TDLG_FOOTNOTEAREA);
    AddConstant('TDLG_FOOTNOTESEPARATOR',TDLG_FOOTNOTESEPARATOR);
    AddConstant('TDLG_EXPANDEDFOOTERAREA',TDLG_EXPANDEDFOOTERAREA);
    AddConstant('TDLG_PROGRESSBAR',TDLG_PROGRESSBAR);
    AddConstant('TDLG_IMAGEALIGNMENT',TDLG_IMAGEALIGNMENT);
    AddConstant('TDLG_RADIOBUTTONPANE',TDLG_RADIOBUTTONPANE);
    AddConstant('TDLGCPS_STANDALONE',TDLGCPS_STANDALONE);
    AddConstant('TDLGEBS_NORMAL',TDLGEBS_NORMAL);
    AddConstant('TDLGEBS_HOVER',TDLGEBS_HOVER);
    AddConstant('TDLGEBS_PRESSED',TDLGEBS_PRESSED);
    AddConstant('TDLGEBS_EXPANDEDNORMAL',TDLGEBS_EXPANDEDNORMAL);
    AddConstant('TDLGEBS_EXPANDEDHOVER',TDLGEBS_EXPANDEDHOVER);
    AddConstant('TDLGEBS_EXPANDEDPRESSED',TDLGEBS_EXPANDEDPRESSED);
    AddConstant('VSCLASS_TEXTSTYLE',VSCLASS_TEXTSTYLE);
    AddConstant('TEXT_MAININSTRUCTION',TEXT_MAININSTRUCTION);
    AddConstant('TEXT_INSTRUCTION',TEXT_INSTRUCTION);
    AddConstant('TEXT_BODYTITLE',TEXT_BODYTITLE);
    AddConstant('TEXT_BODYTEXT',TEXT_BODYTEXT);
    AddConstant('TEXT_SECONDARYTEXT',TEXT_SECONDARYTEXT);
    AddConstant('TEXT_HYPERLINKTEXT',TEXT_HYPERLINKTEXT);
    AddConstant('TEXT_EXPANDED',TEXT_EXPANDED);
    AddConstant('TEXT_LABEL',TEXT_LABEL);
    AddConstant('TEXT_CONTROLLABEL',TEXT_CONTROLLABEL);
    AddConstant('TS_HYPERLINK_NORMAL',TS_HYPERLINK_NORMAL);
    AddConstant('TS_HYPERLINK_HOT',TS_HYPERLINK_HOT);
    AddConstant('TS_HYPERLINK_PRESSED',TS_HYPERLINK_PRESSED);
    AddConstant('TS_HYPERLINK_DISABLED',TS_HYPERLINK_DISABLED);
    AddConstant('TS_CONTROLLABEL_NORMAL',TS_CONTROLLABEL_NORMAL);
    AddConstant('TS_CONTROLLABEL_DISABLED',TS_CONTROLLABEL_DISABLED);
    AddConstant('VSCLASS_LINK',VSCLASS_LINK);
    AddConstant('LP_HYPERLINK',LP_HYPERLINK);
    AddConstant('HLS_NORMALTEXT',HLS_NORMALTEXT);
    AddConstant('HLS_LINKTEXT',HLS_LINKTEXT);
    AddConstant('VSCLASS_EMPTYMARKUP',VSCLASS_EMPTYMARKUP);
    AddConstant('EMP_MARKUPTEXT',EMP_MARKUPTEXT);
    AddConstant('EMT_NORMALTEXT',EMT_NORMALTEXT);
    AddConstant('EMT_LINKTEXT',EMT_LINKTEXT);
    AddConstant('VSCLASS_STATIC',VSCLASS_STATIC);
    AddConstant('STAT_TEXT',STAT_TEXT);
    AddConstant('VSCLASS_MONTHCAL',VSCLASS_MONTHCAL);
    AddConstant('MC_BACKGROUND',MC_BACKGROUND);
    AddConstant('MC_BORDERS',MC_BORDERS);
    AddConstant('MC_GRIDBACKGROUND',MC_GRIDBACKGROUND);
    AddConstant('MC_COLHEADERSPLITTER',MC_COLHEADERSPLITTER);
    AddConstant('MC_GRIDCELLBACKGROUND',MC_GRIDCELLBACKGROUND);
    AddConstant('MC_GRIDCELL',MC_GRIDCELL);
    AddConstant('MC_GRIDCELLUPPER',MC_GRIDCELLUPPER);
    AddConstant('MC_TRAILINGGRIDCELL',MC_TRAILINGGRIDCELL);
    AddConstant('MC_TRAILINGGRIDCELLUPPER',MC_TRAILINGGRIDCELLUPPER);
    AddConstant('MC_NAVNEXT',MC_NAVNEXT);
    AddConstant('MC_NAVPREV',MC_NAVPREV);
    AddConstant('MCGCB_SELECTED',MCGCB_SELECTED);
    AddConstant('MCGCB_HOT',MCGCB_HOT);
    AddConstant('MCGCB_SELECTEDHOT',MCGCB_SELECTEDHOT);
    AddConstant('MCGCB_SELECTEDNOTFOCUSED',MCGCB_SELECTEDNOTFOCUSED);
    AddConstant('MCGCB_TODAY',MCGCB_TODAY);
    AddConstant('MCGC_HOT',MCGC_HOT);
    AddConstant('MCGC_HASSTATE',MCGC_HASSTATE);
    AddConstant('MCGC_HASSTATEHOT',MCGC_HASSTATEHOT);
    AddConstant('MCGC_TODAY',MCGC_TODAY);
    AddConstant('MCGCU_HOT',MCGCU_HOT);
    AddConstant('MCGCU_HASSTATE',MCGCU_HASSTATE);
    AddConstant('MCGCU_HASSTATEHOT',MCGCU_HASSTATEHOT);
    AddConstant('MCTGC_HOT',MCTGC_HOT);
    AddConstant('MCTGC_HASSTATE',MCTGC_HASSTATE);
    AddConstant('MCTGC_HASSTATEHOT',MCTGC_HASSTATEHOT);
    AddConstant('MCTGC_TODAY',MCTGC_TODAY);
    AddConstant('MCTGCU_HOT',MCTGCU_HOT);
    AddConstant('MCTGCU_HASSTATE',MCTGCU_HASSTATE);
    AddConstant('MCTGCU_HASSTATEHOT',MCTGCU_HASSTATEHOT);
    AddConstant('MCNN_NORMAL',MCNN_NORMAL);
    AddConstant('MCNN_HOT',MCNN_HOT);
    AddConstant('MCNN_PRESSED',MCNN_PRESSED);
    AddConstant('MCNN_DISABLED',MCNN_DISABLED);
    AddConstant('MCNP_NORMAL',MCNP_NORMAL);
    AddConstant('MCNP_HOT',MCNP_HOT);
    AddConstant('MCNP_PRESSED',MCNP_PRESSED);
    AddConstant('MCNP_DISABLED',MCNP_DISABLED);
    AddConstant('OTD_FORCE_RECT_SIZING',OTD_FORCE_RECT_SIZING);
    AddConstant('OTD_NONCLIENT',OTD_NONCLIENT);
    AddConstant('OTD_VALIDBITS',OTD_VALIDBITS);
    AddConstant('DTBG_CLIPRECT',DTBG_CLIPRECT);
    AddConstant('DTBG_DRAWSOLID',DTBG_DRAWSOLID);
    AddConstant('DTBG_OMITBORDER',DTBG_OMITBORDER);
    AddConstant('DTBG_OMITCONTENT',DTBG_OMITCONTENT);
    AddConstant('DTBG_COMPUTINGREGION',DTBG_COMPUTINGREGION);
    AddConstant('DTBG_MIRRORDC',DTBG_MIRRORDC);
    AddConstant('DTBG_NOMIRROR',DTBG_NOMIRROR);
    AddConstant('DTBG_VALIDBITS',DTBG_VALIDBITS);
    AddConstant('DTT_TEXTCOLOR',DTT_TEXTCOLOR);
    AddConstant('DTT_BORDERCOLOR',DTT_BORDERCOLOR);
    AddConstant('DTT_SHADOWCOLOR',DTT_SHADOWCOLOR);
    AddConstant('DTT_SHADOWTYPE',DTT_SHADOWTYPE);
    AddConstant('DTT_SHADOWOFFSET',DTT_SHADOWOFFSET);
    AddConstant('DTT_BORDERSIZE',DTT_BORDERSIZE);
    AddConstant('DTT_FONTPROP',DTT_FONTPROP);
    AddConstant('DTT_COLORPROP',DTT_COLORPROP);
    AddConstant('DTT_STATEID',DTT_STATEID);
    AddConstant('DTT_CALCRECT',DTT_CALCRECT);
    AddConstant('DTT_APPLYOVERLAY',DTT_APPLYOVERLAY);
    AddConstant('DTT_GLOWSIZE',DTT_GLOWSIZE);
    AddConstant('DTT_CALLBACK',DTT_CALLBACK);
    AddConstant('DTT_COMPOSITED',DTT_COMPOSITED);
    AddConstant('DTT_VALIDBITS',DTT_VALIDBITS);
    AddConstant('WTA_NONCLIENT',WTA_NONCLIENT);
    AddConstant('WTNCA_NODRAWCAPTION',WTNCA_NODRAWCAPTION);
    AddConstant('WTNCA_NODRAWICON',WTNCA_NODRAWICON);
    AddConstant('WTNCA_NOSYSMENU',WTNCA_NOSYSMENU);
    AddConstant('WTNCA_NOMIRRORHELP',WTNCA_NOMIRRORHELP);
    AddConstant('WTNCA_VALIDBITS',WTNCA_VALIDBITS);
    AddConstant('DTPB_WINDOWDC',DTPB_WINDOWDC);
    AddConstant('DTPB_USECTLCOLORSTATIC',DTPB_USECTLCOLORSTATIC);
    AddConstant('DTPB_USEERASEBKGND',DTPB_USEERASEBKGND);
    AddConstant('GBF_DIRECT',GBF_DIRECT);
    AddConstant('GBF_COPY',GBF_COPY);
    AddConstant('GBF_VALIDBITS',GBF_VALIDBITS);
    AddConstant('BPBF_COMPATIBLEBITMAP',BPBF_COMPATIBLEBITMAP);
    AddConstant('BPBF_DIB',BPBF_DIB);
    AddConstant('BPBF_TOPDOWNDIB',BPBF_TOPDOWNDIB);
    AddConstant('BPBF_TOPDOWNMONODIB',BPBF_TOPDOWNMONODIB);
    AddConstant('BPBF_COMPOSITED',BPBF_COMPOSITED);
    AddConstant('BPAS_NONE',BPAS_NONE);
    AddConstant('BPAS_LINEAR',BPAS_LINEAR);
    AddConstant('BPAS_CUBIC',BPAS_CUBIC);
    AddConstant('BPAS_SINE',BPAS_SINE);
    AddConstant('BPPF_ERASE',BPPF_ERASE);
    AddConstant('BPPF_NOCLIP',BPPF_NOCLIP);
    AddConstant('BPPF_NONCLIENT',BPPF_NONCLIENT);
  end;
end;

class function TatUxThemeLibrary.LibraryName: string;
begin
  result := 'UxTheme';
end;

initialization
  RegisterScripterLibrary(TatUxThemeLibrary, True);

{$WARNINGS ON}

end.

