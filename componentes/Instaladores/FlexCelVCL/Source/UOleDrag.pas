unit UOleDrag;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
// This unit is based on the works of Graham Wideman
//          graham@wideman-one.com
//          www.wideman-one.com
// Thanks!


interface
{$IFDEF FLX_FPC}
implementation
{$ELSE}
uses Windows, Activex, SysUtils;
type
  TFlxDropSource= class(TInterfacedObject, IDropSource)
    function QueryContinueDrag(fEscapePressed: BOOL; grfKeyState: Longint): HResult; stdcall;
    function GiveFeedback(dwEffect: Longint): HResult; stdcall;
  end;

  TFlxEnumformatEtc=class(TInterfacedObject, IEnumFORMATETC)
  private
    FIndex: integer;
  public
    function Next(celt: Longint; out elt; pceltFetched: PLongint): HResult; stdcall;
    function Skip(celt: Longint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumFormatEtc): HResult; stdcall;

    constructor Create;
  end;

  TFlxDataObject= class(TInterfacedObject, IDataObject)
  private
    FText: string;
  public
    function GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function QueryGetData(const formatetc: TFormatEtc): HResult; stdcall;
    function GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult; stdcall;
    function SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult; stdcall;
    function EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult; stdcall;
    function DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function DUnadvise(dwConnection: Longint): HResult; stdcall; function EnumDAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;

    constructor Create(const aText: string);
  end;
implementation

{ TFlxDropSource }

function TFlxDropSource.GiveFeedback(dwEffect: Integer): HResult;
begin
  Result := DRAGDROP_S_USEDEFAULTCURSORS;
end;

function TFlxDropSource.QueryContinueDrag(fEscapePressed: BOOL; grfKeyState: Integer): HResult;
begin
  Result := S_OK;
  If fEscapePressed then Result := DRAGDROP_S_CANCEL else
    if ((grfKeyState and MK_LBUTTON) = 0) then // mouse-up
      Result := DRAGDROP_S_DROP;
end;

{ TFlxDataObject }

constructor TFlxDataObject.Create(const aText: string);
begin
  inherited Create;
  FText:=aText;
end;

function TFlxDataObject.DAdvise(const formatetc: TFormatEtc; advf: Integer;
  const advSink: IAdviseSink; out dwConnection: Integer): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TFlxDataObject.DUnadvise(dwConnection: Integer): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TFlxDataObject.EnumDAdvise(
  out enumAdvise: IEnumStatData): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TFlxDataObject.EnumFormatEtc(dwDirection: Integer;
  out enumFormatEtc: IEnumFormatEtc): HResult;
begin
  if dwDirection <> DATADIR_GET then
  Begin
    enumFormatEtc := nil;
    Result := E_NOTIMPL;
    exit;
  end;
  //--------------------------------------------------------------------
  // Finer OLE point: assigning to enumFormatEtc will auto increment the
  // RefCount to 1, since enumFormatEtc is an IEnumFormatEtc.
  // ie: no need to _AddRef, in fact that will lead to enumFormatEtc
  // never getting deleted.
  // Note, this conflicts with Cantu 1998 Delphi Developer Handbook P465
  //--------------------------------------------------------------------
  enumFormatEtc := TFlxEnumFormatEtc.Create;
  Result := S_OK;
end;

function TFlxDataObject.GetCanonicalFormatEtc(const formatetc: TFormatEtc;
  out formatetcOut: TFormatEtc): HResult;
begin
  formatetcOut.ptd := nil;
  Result := E_NOTIMPL;
end;

function TFlxDataObject.GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult;
var
  HGlobalData: HGlobal;
  PGlobalData: PChar;

  OutString: string;
  OutStringLen: integer;
  AllocLen: integer;
begin
  Result := DV_E_FORMATETC;
  if QueryGetData(formatetcIn) <> S_OK then exit;

  // most medium fields are already initialized by this point
  medium.tymed := TYMED_HGLOBAL;

  OutString     := FText;
  OutStringLen  := Length(OutString);

  case formatetcIn.cfFormat of
    CF_TEXT:        AllocLen := OutStringLen + 1;
    CF_UNICODETEXT: AllocLen := OutStringLen * 2 + 2;
    else exit;
  end; //case

  HGlobalData := GlobalAlloc((GMEM_SHARE or GMEM_MOVEABLE or GMEM_ZEROINIT), AllocLen);
  if (HGlobalData <> 0) then
  begin
    PGlobalData := GlobalLock (HGlobalData); // lock while we are using it
    try
      case formatetcIn.cfFormat of
        CF_TEXT:        StrCopy(PGlobalData, PChar(OutString));
        CF_UNICODETEXT: StringToWideChar(OutString, PWideChar(PGlobalData), OutStringLen+1);
      end; //case
    finally
      GlobalUnlock (HGlobalData);
    end; //finally
    medium.hGlobal := HGlobalData;
    Result := S_OK;
  end;
end;

function TFlxDataObject.GetDataHere(const formatetc: TFormatEtc;
  out medium: TStgMedium): HResult;
begin
  Result := DV_E_FORMATETC;
end;

function TFlxDataObject.QueryGetData(const formatetc: TFormatEtc): HResult;
begin
  Result := DV_E_FORMATETC;
  if (formatetc.dwAspect = DVASPECT_CONTENT) and
     ((formatetc.cfFormat = CF_TEXT) or (formatetc.cfFormat = CF_UNICODETEXT)) and
     (formatetc.tymed = TYMED_HGLOBAL) then Result := S_OK;
end;

function TFlxDataObject.SetData(const formatetc: TFormatEtc;
  var medium: TStgMedium; fRelease: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

//-----------------------
{ TFlxEnumformat }
type
  TFormatEtcArray = array[0..19] of TFormatEtc;
  PFormatEtcArray = ^TFormatEtcArray;

function TFlxEnumformatEtc.Clone(out Enum: IEnumFormatEtc): HResult;
begin
  Result := S_FALSE;
end;

constructor TFlxEnumformatEtc.create;
begin
  inherited;
  FIndex:=0;
end;

function TFlxEnumformatEtc.Next(celt: Integer; out elt;
  pceltFetched: PLongint): HResult;
var
  N: integer;
  FormatEtcArrayOut: TFormatEtcArray absolute elt;
begin
  Result := S_FALSE;
  N := 0;
  while (N < celt) and (FIndex < 2) do
  begin
    case FIndex of
      1: begin
        FormatEtcArrayOut[N].cfFormat := CF_UNICODETEXT;
        FormatEtcArrayOut[N].ptd      := nil;
        FormatEtcArrayOut[N].dwAspect := DVASPECT_CONTENT;
        FormatEtcArrayOut[N].lindex   := -1;
        FormatEtcArrayOut[N].tymed    := TYMED_HGLOBAL;
      end;
      else Begin
        FormatEtcArrayOut[N].cfFormat := CF_TEXT;
        FormatEtcArrayOut[N].ptd      := nil;
        FormatEtcArrayOut[N].dwAspect := DVASPECT_CONTENT;
        FormatEtcArrayOut[N].lindex   := -1;
        FormatEtcArrayOut[N].tymed    := TYMED_HGLOBAL;
      end;
    end; //case

    Inc(FIndex);
    Inc(N);
  end;
  If PceltFetched <> nil then PceltFetched^ := N;
  if N = celt then Result := S_OK;
end;

function TFlxEnumformatEtc.Reset: HResult;
begin
  FIndex := 0;
  Result := S_OK;
end;

function TFlxEnumformatEtc.Skip(celt: Integer): HResult;
begin
  FIndex := FIndex + celt;
  if FIndex > 2 then
  begin
    FIndex := 2;
    Result := S_FALSE;
  end
  else Result := S_OK;
end;

initialization
//-----------------------
  OleInitialize (Nil);

//-----------------------
finalization
//-----------------------
  OleUninitialize;

{$ENDIF}
end.
