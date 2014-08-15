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
unit ap_Imm;

interface

uses
  Windows,
  Imm,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatImmLibrary = class(TatScripterLibrary)
    procedure __ImmInstallIME(AMachine: TatVirtualMachine);
    procedure __ImmInstallIMEA(AMachine: TatVirtualMachine);
    procedure __ImmInstallIMEW(AMachine: TatVirtualMachine);
    procedure __ImmGetDefaultIMEWnd(AMachine: TatVirtualMachine);
    procedure __ImmGetDescription(AMachine: TatVirtualMachine);
    procedure __ImmGetDescriptionA(AMachine: TatVirtualMachine);
    procedure __ImmGetDescriptionW(AMachine: TatVirtualMachine);
    procedure __ImmGetIMEFileName(AMachine: TatVirtualMachine);
    procedure __ImmGetIMEFileNameA(AMachine: TatVirtualMachine);
    procedure __ImmGetIMEFileNameW(AMachine: TatVirtualMachine);
    procedure __ImmGetProperty(AMachine: TatVirtualMachine);
    procedure __ImmIsIME(AMachine: TatVirtualMachine);
    procedure __ImmSimulateHotKey(AMachine: TatVirtualMachine);
    procedure __ImmCreateContext(AMachine: TatVirtualMachine);
    procedure __ImmDestroyContext(AMachine: TatVirtualMachine);
    procedure __ImmGetContext(AMachine: TatVirtualMachine);
    procedure __ImmReleaseContext(AMachine: TatVirtualMachine);
    procedure __ImmAssociateContext(AMachine: TatVirtualMachine);
    procedure __ImmGetCandidateListCount(AMachine: TatVirtualMachine);
    procedure __ImmGetCandidateListCountA(AMachine: TatVirtualMachine);
    procedure __ImmGetCandidateListCountW(AMachine: TatVirtualMachine);
    procedure __ImmGetGuideLine(AMachine: TatVirtualMachine);
    procedure __ImmGetGuideLineA(AMachine: TatVirtualMachine);
    procedure __ImmGetGuideLineW(AMachine: TatVirtualMachine);
    procedure __ImmGetConversionStatus(AMachine: TatVirtualMachine);
    procedure __ImmSetConversionStatus(AMachine: TatVirtualMachine);
    procedure __ImmGetOpenStatus(AMachine: TatVirtualMachine);
    procedure __ImmSetOpenStatus(AMachine: TatVirtualMachine);
    procedure __ImmNotifyIME(AMachine: TatVirtualMachine);
    procedure __ImmGetStatusWindowPos(AMachine: TatVirtualMachine);
    procedure __ImmIsUIMessage(AMachine: TatVirtualMachine);
    procedure __ImmIsUIMessageA(AMachine: TatVirtualMachine);
    procedure __ImmIsUIMessageW(AMachine: TatVirtualMachine);
    procedure __ImmGetVirtualKey(AMachine: TatVirtualMachine);
    procedure __ImmRegisterWord(AMachine: TatVirtualMachine);
    procedure __ImmRegisterWordA(AMachine: TatVirtualMachine);
    procedure __ImmRegisterWordW(AMachine: TatVirtualMachine);
    procedure __ImmUnregisterWord(AMachine: TatVirtualMachine);
    procedure __ImmUnregisterWordA(AMachine: TatVirtualMachine);
    procedure __ImmUnregisterWordW(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagCOMPOSITIONFORMWrapper = class(TatRecordWrapper)
  private
    FdwStyle: DWORD;
  public
    constructor Create(ARecord: tagCOMPOSITIONFORM);
    function ObjToRec: tagCOMPOSITIONFORM;
  published
    property dwStyle: DWORD read FdwStyle write FdwStyle;
  end;
  
  tagCANDIDATEFORMWrapper = class(TatRecordWrapper)
  private
    FdwIndex: DWORD;
    FdwStyle: DWORD;
  public
    constructor Create(ARecord: tagCANDIDATEFORM);
    function ObjToRec: tagCANDIDATEFORM;
  published
    property dwIndex: DWORD read FdwIndex write FdwIndex;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
  end;
  
  tagCANDIDATELISTWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwStyle: DWORD;
    FdwCount: DWORD;
    FdwSelection: DWORD;
    FdwPageStart: DWORD;
    FdwPageSize: DWORD;
  public
    constructor Create(ARecord: tagCANDIDATELIST);
    function ObjToRec: tagCANDIDATELIST;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property dwCount: DWORD read FdwCount write FdwCount;
    property dwSelection: DWORD read FdwSelection write FdwSelection;
    property dwPageStart: DWORD read FdwPageStart write FdwPageStart;
    property dwPageSize: DWORD read FdwPageSize write FdwPageSize;
  end;
  
  tagREGISTERWORDAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagREGISTERWORDA);
    function ObjToRec: tagREGISTERWORDA;
  published
  end;
  
  tagREGISTERWORDWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagREGISTERWORDW);
    function ObjToRec: tagREGISTERWORDW;
  published
  end;
  
  tagSTYLEBUFAWrapper = class(TatRecordWrapper)
  private
    FdwStyle: DWORD;
  public
    constructor Create(ARecord: tagSTYLEBUFA);
    function ObjToRec: tagSTYLEBUFA;
  published
    property dwStyle: DWORD read FdwStyle write FdwStyle;
  end;
  
  tagSTYLEBUFWWrapper = class(TatRecordWrapper)
  private
    FdwStyle: DWORD;
  public
    constructor Create(ARecord: tagSTYLEBUFW);
    function ObjToRec: tagSTYLEBUFW;
  published
    property dwStyle: DWORD read FdwStyle write FdwStyle;
  end;
  

implementation

constructor tagCOMPOSITIONFORMWrapper.Create(ARecord: tagCOMPOSITIONFORM);
begin
  inherited Create;
  FdwStyle := ARecord.dwStyle;
end;

function tagCOMPOSITIONFORMWrapper.ObjToRec: tagCOMPOSITIONFORM;
begin
  result.dwStyle := FdwStyle;
end;

constructor tagCANDIDATEFORMWrapper.Create(ARecord: tagCANDIDATEFORM);
begin
  inherited Create;
  FdwIndex := ARecord.dwIndex;
  FdwStyle := ARecord.dwStyle;
end;

function tagCANDIDATEFORMWrapper.ObjToRec: tagCANDIDATEFORM;
begin
  result.dwIndex := FdwIndex;
  result.dwStyle := FdwStyle;
end;

constructor tagCANDIDATELISTWrapper.Create(ARecord: tagCANDIDATELIST);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwStyle := ARecord.dwStyle;
  FdwCount := ARecord.dwCount;
  FdwSelection := ARecord.dwSelection;
  FdwPageStart := ARecord.dwPageStart;
  FdwPageSize := ARecord.dwPageSize;
end;

function tagCANDIDATELISTWrapper.ObjToRec: tagCANDIDATELIST;
begin
  result.dwSize := FdwSize;
  result.dwStyle := FdwStyle;
  result.dwCount := FdwCount;
  result.dwSelection := FdwSelection;
  result.dwPageStart := FdwPageStart;
  result.dwPageSize := FdwPageSize;
end;

constructor tagREGISTERWORDAWrapper.Create(ARecord: tagREGISTERWORDA);
begin
  inherited Create;
end;

function tagREGISTERWORDAWrapper.ObjToRec: tagREGISTERWORDA;
begin
end;

constructor tagREGISTERWORDWWrapper.Create(ARecord: tagREGISTERWORDW);
begin
  inherited Create;
end;

function tagREGISTERWORDWWrapper.ObjToRec: tagREGISTERWORDW;
begin
end;

constructor tagSTYLEBUFAWrapper.Create(ARecord: tagSTYLEBUFA);
begin
  inherited Create;
  FdwStyle := ARecord.dwStyle;
end;

function tagSTYLEBUFAWrapper.ObjToRec: tagSTYLEBUFA;
begin
  result.dwStyle := FdwStyle;
end;

constructor tagSTYLEBUFWWrapper.Create(ARecord: tagSTYLEBUFW);
begin
  inherited Create;
  FdwStyle := ARecord.dwStyle;
end;

function tagSTYLEBUFWWrapper.ObjToRec: tagSTYLEBUFW;
begin
  result.dwStyle := FdwStyle;
end;



procedure TatImmLibrary.__ImmInstallIME(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmInstallIME(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmInstallIMEA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmInstallIMEA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmInstallIMEW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmInstallIMEW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetDefaultIMEWnd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetDefaultIMEWnd(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetDescription(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetDescription(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetDescriptionA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetDescriptionA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetDescriptionW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetDescriptionW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetIMEFileName(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetIMEFileName(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetIMEFileNameA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetIMEFileNameA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetIMEFileNameW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetIMEFileNameW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetProperty(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmIsIME(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmIsIME(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmSimulateHotKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmSimulateHotKey(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmCreateContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmCreateContext);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmDestroyContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmDestroyContext(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetContext(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmReleaseContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmReleaseContext(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmAssociateContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmAssociateContext(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetCandidateListCount(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Imm.ImmGetCandidateListCount(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatImmLibrary.__ImmGetCandidateListCountA(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Imm.ImmGetCandidateListCountA(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatImmLibrary.__ImmGetCandidateListCountW(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Imm.ImmGetCandidateListCountW(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatImmLibrary.__ImmGetGuideLine(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetGuideLine(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetGuideLineA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetGuideLineA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetGuideLineW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetGuideLineW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetConversionStatus(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Imm.ImmGetConversionStatus(VarToInteger(GetInputArg(0)),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatImmLibrary.__ImmSetConversionStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmSetConversionStatus(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetOpenStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmGetOpenStatus(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmSetOpenStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmSetOpenStatus(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmNotifyIME(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmNotifyIME(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetStatusWindowPos(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TPoint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TPointWrapper) then 
  Param1Rec := TPointWrapper.Create(Param1);
Param1 := TPointWrapper(Param1Rec).ObjToRec;
AResult := Imm.ImmGetStatusWindowPos(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TPointWrapper.Create(Param1)));
  end;
end;

procedure TatImmLibrary.__ImmIsUIMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmIsUIMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmIsUIMessageA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmIsUIMessageA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmIsUIMessageW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmIsUIMessageW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmGetVirtualKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Imm.ImmGetVirtualKey(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmRegisterWord(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmRegisterWord(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmRegisterWordA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmRegisterWordA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),PAnsiChar(VarToStr(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmRegisterWordW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmRegisterWordW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmUnregisterWord(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmUnregisterWord(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmUnregisterWordA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmUnregisterWordA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),PAnsiChar(VarToStr(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.__ImmUnregisterWordW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Imm.ImmUnregisterWordW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImmLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ImmInstallIME',2,tkInteger,nil,__ImmInstallIME,false,0);
    DefineMethod('ImmInstallIMEA',2,tkInteger,nil,__ImmInstallIMEA,false,0);
    DefineMethod('ImmInstallIMEW',2,tkInteger,nil,__ImmInstallIMEW,false,0);
    DefineMethod('ImmGetDefaultIMEWnd',1,tkInteger,nil,__ImmGetDefaultIMEWnd,false,0);
    DefineMethod('ImmGetDescription',3,tkInteger,nil,__ImmGetDescription,false,0);
    DefineMethod('ImmGetDescriptionA',3,tkInteger,nil,__ImmGetDescriptionA,false,0);
    DefineMethod('ImmGetDescriptionW',3,tkInteger,nil,__ImmGetDescriptionW,false,0);
    DefineMethod('ImmGetIMEFileName',3,tkInteger,nil,__ImmGetIMEFileName,false,0);
    DefineMethod('ImmGetIMEFileNameA',3,tkInteger,nil,__ImmGetIMEFileNameA,false,0);
    DefineMethod('ImmGetIMEFileNameW',3,tkInteger,nil,__ImmGetIMEFileNameW,false,0);
    DefineMethod('ImmGetProperty',2,tkInteger,nil,__ImmGetProperty,false,0);
    DefineMethod('ImmIsIME',1,tkVariant,nil,__ImmIsIME,false,0);
    DefineMethod('ImmSimulateHotKey',2,tkVariant,nil,__ImmSimulateHotKey,false,0);
    DefineMethod('ImmCreateContext',0,tkInteger,nil,__ImmCreateContext,false,0);
    DefineMethod('ImmDestroyContext',1,tkVariant,nil,__ImmDestroyContext,false,0);
    DefineMethod('ImmGetContext',1,tkInteger,nil,__ImmGetContext,false,0);
    DefineMethod('ImmReleaseContext',2,tkVariant,nil,__ImmReleaseContext,false,0);
    DefineMethod('ImmAssociateContext',2,tkInteger,nil,__ImmAssociateContext,false,0);
    DefineMethod('ImmGetCandidateListCount',2,tkInteger,nil,__ImmGetCandidateListCount,false,0).SetVarArgs([1]);
    DefineMethod('ImmGetCandidateListCountA',2,tkInteger,nil,__ImmGetCandidateListCountA,false,0).SetVarArgs([1]);
    DefineMethod('ImmGetCandidateListCountW',2,tkInteger,nil,__ImmGetCandidateListCountW,false,0).SetVarArgs([1]);
    DefineMethod('ImmGetGuideLine',4,tkInteger,nil,__ImmGetGuideLine,false,0);
    DefineMethod('ImmGetGuideLineA',4,tkInteger,nil,__ImmGetGuideLineA,false,0);
    DefineMethod('ImmGetGuideLineW',4,tkInteger,nil,__ImmGetGuideLineW,false,0);
    DefineMethod('ImmGetConversionStatus',3,tkVariant,nil,__ImmGetConversionStatus,false,0).SetVarArgs([1,2]);
    DefineMethod('ImmSetConversionStatus',3,tkVariant,nil,__ImmSetConversionStatus,false,0);
    DefineMethod('ImmGetOpenStatus',1,tkVariant,nil,__ImmGetOpenStatus,false,0);
    DefineMethod('ImmSetOpenStatus',2,tkVariant,nil,__ImmSetOpenStatus,false,0);
    DefineMethod('ImmNotifyIME',4,tkVariant,nil,__ImmNotifyIME,false,0);
    DefineMethod('ImmGetStatusWindowPos',2,tkVariant,nil,__ImmGetStatusWindowPos,false,0).SetVarArgs([1]);
    DefineMethod('ImmIsUIMessage',4,tkVariant,nil,__ImmIsUIMessage,false,0);
    DefineMethod('ImmIsUIMessageA',4,tkVariant,nil,__ImmIsUIMessageA,false,0);
    DefineMethod('ImmIsUIMessageW',4,tkVariant,nil,__ImmIsUIMessageW,false,0);
    DefineMethod('ImmGetVirtualKey',1,tkInteger,nil,__ImmGetVirtualKey,false,0);
    DefineMethod('ImmRegisterWord',4,tkVariant,nil,__ImmRegisterWord,false,0);
    DefineMethod('ImmRegisterWordA',4,tkVariant,nil,__ImmRegisterWordA,false,0);
    DefineMethod('ImmRegisterWordW',4,tkVariant,nil,__ImmRegisterWordW,false,0);
    DefineMethod('ImmUnregisterWord',4,tkVariant,nil,__ImmUnregisterWord,false,0);
    DefineMethod('ImmUnregisterWordA',4,tkVariant,nil,__ImmUnregisterWordA,false,0);
    DefineMethod('ImmUnregisterWordW',4,tkVariant,nil,__ImmUnregisterWordW,false,0);
    AddConstant('VK_PROCESSKEY',VK_PROCESSKEY);
    AddConstant('STYLE_DESCRIPTION_SIZE',STYLE_DESCRIPTION_SIZE);
    AddConstant('WM_CONVERTREQUESTEX',WM_CONVERTREQUESTEX);
    AddConstant('WM_IME_STARTCOMPOSITION',WM_IME_STARTCOMPOSITION);
    AddConstant('WM_IME_ENDCOMPOSITION',WM_IME_ENDCOMPOSITION);
    AddConstant('WM_IME_COMPOSITION',WM_IME_COMPOSITION);
    AddConstant('WM_IME_KEYLAST',WM_IME_KEYLAST);
    AddConstant('WM_IME_SETCONTEXT',WM_IME_SETCONTEXT);
    AddConstant('WM_IME_NOTIFY',WM_IME_NOTIFY);
    AddConstant('WM_IME_CONTROL',WM_IME_CONTROL);
    AddConstant('WM_IME_COMPOSITIONFULL',WM_IME_COMPOSITIONFULL);
    AddConstant('WM_IME_SELECT',WM_IME_SELECT);
    AddConstant('WM_IME_CHAR',WM_IME_CHAR);
    AddConstant('WM_IME_KEYDOWN',WM_IME_KEYDOWN);
    AddConstant('WM_IME_KEYUP',WM_IME_KEYUP);
    AddConstant('IMC_GETCANDIDATEPOS',IMC_GETCANDIDATEPOS);
    AddConstant('IMC_SETCANDIDATEPOS',IMC_SETCANDIDATEPOS);
    AddConstant('IMC_GETCOMPOSITIONFONT',IMC_GETCOMPOSITIONFONT);
    AddConstant('IMC_SETCOMPOSITIONFONT',IMC_SETCOMPOSITIONFONT);
    AddConstant('IMC_GETCOMPOSITIONWINDOW',IMC_GETCOMPOSITIONWINDOW);
    AddConstant('IMC_SETCOMPOSITIONWINDOW',IMC_SETCOMPOSITIONWINDOW);
    AddConstant('IMC_GETSTATUSWINDOWPOS',IMC_GETSTATUSWINDOWPOS);
    AddConstant('IMC_SETSTATUSWINDOWPOS',IMC_SETSTATUSWINDOWPOS);
    AddConstant('IMC_CLOSESTATUSWINDOW',IMC_CLOSESTATUSWINDOW);
    AddConstant('IMC_OPENSTATUSWINDOW',IMC_OPENSTATUSWINDOW);
    AddConstant('NI_OPENCANDIDATE',NI_OPENCANDIDATE);
    AddConstant('NI_CLOSECANDIDATE',NI_CLOSECANDIDATE);
    AddConstant('NI_SELECTCANDIDATESTR',NI_SELECTCANDIDATESTR);
    AddConstant('NI_CHANGECANDIDATELIST',NI_CHANGECANDIDATELIST);
    AddConstant('NI_FINALIZECONVERSIONRESULT',NI_FINALIZECONVERSIONRESULT);
    AddConstant('NI_COMPOSITIONSTR',NI_COMPOSITIONSTR);
    AddConstant('NI_SETCANDIDATE_PAGESTART',NI_SETCANDIDATE_PAGESTART);
    AddConstant('NI_SETCANDIDATE_PAGESIZE',NI_SETCANDIDATE_PAGESIZE);
    AddConstant('ISC_SHOWUICANDIDATEWINDOW',ISC_SHOWUICANDIDATEWINDOW);
    AddConstant('ISC_SHOWUICOMPOSITIONWINDOW',ISC_SHOWUICOMPOSITIONWINDOW);
    AddConstant('ISC_SHOWUIGUIDELINE',ISC_SHOWUIGUIDELINE);
    AddConstant('ISC_SHOWUIALLCANDIDATEWINDOW',ISC_SHOWUIALLCANDIDATEWINDOW);
    AddConstant('ISC_SHOWUIALL',ISC_SHOWUIALL);
    AddConstant('CPS_COMPLETE',CPS_COMPLETE);
    AddConstant('CPS_CONVERT',CPS_CONVERT);
    AddConstant('CPS_REVERT',CPS_REVERT);
    AddConstant('CPS_CANCEL',CPS_CANCEL);
    AddConstant('MOD_ALT',MOD_ALT);
    AddConstant('MOD_CONTROL',MOD_CONTROL);
    AddConstant('MOD_SHIFT',MOD_SHIFT);
    AddConstant('MOD_LEFT',MOD_LEFT);
    AddConstant('MOD_RIGHT',MOD_RIGHT);
    AddConstant('MOD_ON_KEYUP',MOD_ON_KEYUP);
    AddConstant('MOD_IGNORE_ALL_MODIFIER',MOD_IGNORE_ALL_MODIFIER);
    AddConstant('IME_CHOTKEY_IME_NONIME_TOGGLE',IME_CHOTKEY_IME_NONIME_TOGGLE);
    AddConstant('IME_CHOTKEY_SHAPE_TOGGLE',IME_CHOTKEY_SHAPE_TOGGLE);
    AddConstant('IME_CHOTKEY_SYMBOL_TOGGLE',IME_CHOTKEY_SYMBOL_TOGGLE);
    AddConstant('IME_JHOTKEY_CLOSE_OPEN',IME_JHOTKEY_CLOSE_OPEN);
    AddConstant('IME_KHOTKEY_SHAPE_TOGGLE',IME_KHOTKEY_SHAPE_TOGGLE);
    AddConstant('IME_KHOTKEY_HANJACONVERT',IME_KHOTKEY_HANJACONVERT);
    AddConstant('IME_KHOTKEY_ENGLISH',IME_KHOTKEY_ENGLISH);
    AddConstant('IME_THOTKEY_IME_NONIME_TOGGLE',IME_THOTKEY_IME_NONIME_TOGGLE);
    AddConstant('IME_THOTKEY_SHAPE_TOGGLE',IME_THOTKEY_SHAPE_TOGGLE);
    AddConstant('IME_THOTKEY_SYMBOL_TOGGLE',IME_THOTKEY_SYMBOL_TOGGLE);
    AddConstant('IME_HOTKEY_DSWITCH_FIRST',IME_HOTKEY_DSWITCH_FIRST);
    AddConstant('IME_HOTKEY_DSWITCH_LAST',IME_HOTKEY_DSWITCH_LAST);
    AddConstant('IME_HOTKEY_PRIVATE_FIRST',IME_HOTKEY_PRIVATE_FIRST);
    AddConstant('IME_ITHOTKEY_RESEND_RESULTSTR',IME_ITHOTKEY_RESEND_RESULTSTR);
    AddConstant('IME_ITHOTKEY_PREVIOUS_COMPOSITION',IME_ITHOTKEY_PREVIOUS_COMPOSITION);
    AddConstant('IME_ITHOTKEY_UISTYLE_TOGGLE',IME_ITHOTKEY_UISTYLE_TOGGLE);
    AddConstant('IME_HOTKEY_PRIVATE_LAST',IME_HOTKEY_PRIVATE_LAST);
    AddConstant('GCS_COMPREADSTR',GCS_COMPREADSTR);
    AddConstant('GCS_COMPREADATTR',GCS_COMPREADATTR);
    AddConstant('GCS_COMPREADCLAUSE',GCS_COMPREADCLAUSE);
    AddConstant('GCS_COMPSTR',GCS_COMPSTR);
    AddConstant('GCS_COMPATTR',GCS_COMPATTR);
    AddConstant('GCS_COMPCLAUSE',GCS_COMPCLAUSE);
    AddConstant('GCS_CURSORPOS',GCS_CURSORPOS);
    AddConstant('GCS_DELTASTART',GCS_DELTASTART);
    AddConstant('GCS_RESULTREADSTR',GCS_RESULTREADSTR);
    AddConstant('GCS_RESULTREADCLAUSE',GCS_RESULTREADCLAUSE);
    AddConstant('GCS_RESULTSTR',GCS_RESULTSTR);
    AddConstant('GCS_RESULTCLAUSE',GCS_RESULTCLAUSE);
    AddConstant('CS_INSERTCHAR',CS_INSERTCHAR);
    AddConstant('CS_NOMOVECARET',CS_NOMOVECARET);
    AddConstant('IMEVER_0310',IMEVER_0310);
    AddConstant('IMEVER_0400',IMEVER_0400);
    AddConstant('IME_PROP_AT_CARET',IME_PROP_AT_CARET);
    AddConstant('IME_PROP_SPECIAL_UI',IME_PROP_SPECIAL_UI);
    AddConstant('IME_PROP_CANDLIST_START_FROM_1',IME_PROP_CANDLIST_START_FROM_1);
    AddConstant('IME_PROP_UNICODE',IME_PROP_UNICODE);
    AddConstant('UI_CAP_2700',UI_CAP_2700);
    AddConstant('UI_CAP_ROT90',UI_CAP_ROT90);
    AddConstant('UI_CAP_ROTANY',UI_CAP_ROTANY);
    AddConstant('SCS_CAP_COMPSTR',SCS_CAP_COMPSTR);
    AddConstant('SCS_CAP_MAKEREAD',SCS_CAP_MAKEREAD);
    AddConstant('SELECT_CAP_CONVERSION',SELECT_CAP_CONVERSION);
    AddConstant('SELECT_CAP_SENTENCE',SELECT_CAP_SENTENCE);
    AddConstant('GGL_LEVEL',GGL_LEVEL);
    AddConstant('GGL_INDEX',GGL_INDEX);
    AddConstant('GGL_STRING',GGL_STRING);
    AddConstant('GGL_PRIVATE',GGL_PRIVATE);
    AddConstant('GL_LEVEL_NOGUIDELINE',GL_LEVEL_NOGUIDELINE);
    AddConstant('GL_LEVEL_FATAL',GL_LEVEL_FATAL);
    AddConstant('GL_LEVEL_ERROR',GL_LEVEL_ERROR);
    AddConstant('GL_LEVEL_WARNING',GL_LEVEL_WARNING);
    AddConstant('GL_LEVEL_INFORMATION',GL_LEVEL_INFORMATION);
    AddConstant('GL_ID_UNKNOWN',GL_ID_UNKNOWN);
    AddConstant('GL_ID_NOMODULE',GL_ID_NOMODULE);
    AddConstant('GL_ID_NODICTIONARY',GL_ID_NODICTIONARY);
    AddConstant('GL_ID_CANNOTSAVE',GL_ID_CANNOTSAVE);
    AddConstant('GL_ID_NOCONVERT',GL_ID_NOCONVERT);
    AddConstant('GL_ID_TYPINGERROR',GL_ID_TYPINGERROR);
    AddConstant('GL_ID_TOOMANYSTROKE',GL_ID_TOOMANYSTROKE);
    AddConstant('GL_ID_READINGCONFLICT',GL_ID_READINGCONFLICT);
    AddConstant('GL_ID_INPUTREADING',GL_ID_INPUTREADING);
    AddConstant('GL_ID_INPUTRADICAL',GL_ID_INPUTRADICAL);
    AddConstant('GL_ID_INPUTCODE',GL_ID_INPUTCODE);
    AddConstant('GL_ID_INPUTSYMBOL',GL_ID_INPUTSYMBOL);
    AddConstant('GL_ID_CHOOSECANDIDATE',GL_ID_CHOOSECANDIDATE);
    AddConstant('GL_ID_REVERSECONVERSION',GL_ID_REVERSECONVERSION);
    AddConstant('GL_ID_PRIVATE_FIRST',GL_ID_PRIVATE_FIRST);
    AddConstant('GL_ID_PRIVATE_LAST',GL_ID_PRIVATE_LAST);
    AddConstant('IGP_GETIMEVERSION',IGP_GETIMEVERSION);
    AddConstant('IGP_PROPERTY',IGP_PROPERTY);
    AddConstant('IGP_CONVERSION',IGP_CONVERSION);
    AddConstant('IGP_SENTENCE',IGP_SENTENCE);
    AddConstant('IGP_UI',IGP_UI);
    AddConstant('IGP_SETCOMPSTR',IGP_SETCOMPSTR);
    AddConstant('IGP_SELECT',IGP_SELECT);
    AddConstant('SCS_SETSTR',SCS_SETSTR);
    AddConstant('SCS_CHANGEATTR',SCS_CHANGEATTR);
    AddConstant('SCS_CHANGECLAUSE',SCS_CHANGECLAUSE);
    AddConstant('ATTR_INPUT',ATTR_INPUT);
    AddConstant('ATTR_TARGET_CONVERTED',ATTR_TARGET_CONVERTED);
    AddConstant('ATTR_CONVERTED',ATTR_CONVERTED);
    AddConstant('ATTR_TARGET_NOTCONVERTED',ATTR_TARGET_NOTCONVERTED);
    AddConstant('ATTR_INPUT_ERROR',ATTR_INPUT_ERROR);
    AddConstant('CFS_DEFAULT',CFS_DEFAULT);
    AddConstant('CFS_RECT',CFS_RECT);
    AddConstant('CFS_POINT',CFS_POINT);
    AddConstant('CFS_SCREEN',CFS_SCREEN);
    AddConstant('CFS_FORCE_POSITION',CFS_FORCE_POSITION);
    AddConstant('CFS_CANDIDATEPOS',CFS_CANDIDATEPOS);
    AddConstant('CFS_EXCLUDE',CFS_EXCLUDE);
    AddConstant('GCL_CONVERSION',GCL_CONVERSION);
    AddConstant('GCL_REVERSECONVERSION',GCL_REVERSECONVERSION);
    AddConstant('GCL_REVERSE_LENGTH',GCL_REVERSE_LENGTH);
    AddConstant('IME_CMODE_ALPHANUMERIC',IME_CMODE_ALPHANUMERIC);
    AddConstant('IME_CMODE_NATIVE',IME_CMODE_NATIVE);
    AddConstant('IME_CMODE_CHINESE',IME_CMODE_CHINESE);
    AddConstant('IME_CMODE_HANGEUL',IME_CMODE_HANGEUL);
    AddConstant('IME_CMODE_HANGUL',IME_CMODE_HANGUL);
    AddConstant('IME_CMODE_JAPANESE',IME_CMODE_JAPANESE);
    AddConstant('IME_CMODE_KATAKANA',IME_CMODE_KATAKANA);
    AddConstant('IME_CMODE_LANGUAGE',IME_CMODE_LANGUAGE);
    AddConstant('IME_CMODE_FULLSHAPE',IME_CMODE_FULLSHAPE);
    AddConstant('IME_CMODE_ROMAN',IME_CMODE_ROMAN);
    AddConstant('IME_CMODE_CHARCODE',IME_CMODE_CHARCODE);
    AddConstant('IME_CMODE_HANJACONVERT',IME_CMODE_HANJACONVERT);
    AddConstant('IME_CMODE_SOFTKBD',IME_CMODE_SOFTKBD);
    AddConstant('IME_CMODE_NOCONVERSION',IME_CMODE_NOCONVERSION);
    AddConstant('IME_CMODE_EUDC',IME_CMODE_EUDC);
    AddConstant('IME_CMODE_SYMBOL',IME_CMODE_SYMBOL);
    AddConstant('IME_SMODE_NONE',IME_SMODE_NONE);
    AddConstant('IME_SMODE_PLAURALCLAUSE',IME_SMODE_PLAURALCLAUSE);
    AddConstant('IME_SMODE_SINGLECONVERT',IME_SMODE_SINGLECONVERT);
    AddConstant('IME_SMODE_AUTOMATIC',IME_SMODE_AUTOMATIC);
    AddConstant('IME_SMODE_PHRASEPREDICT',IME_SMODE_PHRASEPREDICT);
    AddConstant('IME_CAND_UNKNOWN',IME_CAND_UNKNOWN);
    AddConstant('IME_CAND_READ',IME_CAND_READ);
    AddConstant('IME_CAND_CODE',IME_CAND_CODE);
    AddConstant('IME_CAND_MEANING',IME_CAND_MEANING);
    AddConstant('IME_CAND_RADICAL',IME_CAND_RADICAL);
    AddConstant('IME_CAND_STROKE',IME_CAND_STROKE);
    AddConstant('IMN_CLOSESTATUSWINDOW',IMN_CLOSESTATUSWINDOW);
    AddConstant('IMN_OPENSTATUSWINDOW',IMN_OPENSTATUSWINDOW);
    AddConstant('IMN_CHANGECANDIDATE',IMN_CHANGECANDIDATE);
    AddConstant('IMN_CLOSECANDIDATE',IMN_CLOSECANDIDATE);
    AddConstant('IMN_OPENCANDIDATE',IMN_OPENCANDIDATE);
    AddConstant('IMN_SETCONVERSIONMODE',IMN_SETCONVERSIONMODE);
    AddConstant('IMN_SETSENTENCEMODE',IMN_SETSENTENCEMODE);
    AddConstant('IMN_SETOPENSTATUS',IMN_SETOPENSTATUS);
    AddConstant('IMN_SETCANDIDATEPOS',IMN_SETCANDIDATEPOS);
    AddConstant('IMN_SETCOMPOSITIONFONT',IMN_SETCOMPOSITIONFONT);
    AddConstant('IMN_SETCOMPOSITIONWINDOW',IMN_SETCOMPOSITIONWINDOW);
    AddConstant('IMN_SETSTATUSWINDOWPOS',IMN_SETSTATUSWINDOWPOS);
    AddConstant('IMN_GUIDELINE',IMN_GUIDELINE);
    AddConstant('IMN_PRIVATE',IMN_PRIVATE);
    AddConstant('IMM_ERROR_NODATA',IMM_ERROR_NODATA);
    AddConstant('IMM_ERROR_GENERAL',IMM_ERROR_GENERAL);
    AddConstant('IME_CONFIG_GENERAL',IME_CONFIG_GENERAL);
    AddConstant('IME_CONFIG_REGISTERWORD',IME_CONFIG_REGISTERWORD);
    AddConstant('IME_CONFIG_SELECTDICTIONARY',IME_CONFIG_SELECTDICTIONARY);
    AddConstant('IME_ESC_QUERY_SUPPORT',IME_ESC_QUERY_SUPPORT);
    AddConstant('IME_ESC_RESERVED_FIRST',IME_ESC_RESERVED_FIRST);
    AddConstant('IME_ESC_RESERVED_LAST',IME_ESC_RESERVED_LAST);
    AddConstant('IME_ESC_PRIVATE_FIRST',IME_ESC_PRIVATE_FIRST);
    AddConstant('IME_ESC_PRIVATE_LAST',IME_ESC_PRIVATE_LAST);
    AddConstant('IME_ESC_SEQUENCE_TO_INTERNAL',IME_ESC_SEQUENCE_TO_INTERNAL);
    AddConstant('IME_ESC_GET_EUDC_DICTIONARY',IME_ESC_GET_EUDC_DICTIONARY);
    AddConstant('IME_ESC_SET_EUDC_DICTIONARY',IME_ESC_SET_EUDC_DICTIONARY);
    AddConstant('IME_ESC_MAX_KEY',IME_ESC_MAX_KEY);
    AddConstant('IME_ESC_IME_NAME',IME_ESC_IME_NAME);
    AddConstant('IME_ESC_SYNC_HOTKEY',IME_ESC_SYNC_HOTKEY);
    AddConstant('IME_ESC_HANJA_MODE',IME_ESC_HANJA_MODE);
    AddConstant('IME_ESC_AUTOMATA',IME_ESC_AUTOMATA);
    AddConstant('IME_ESC_PRIVATE_HOTKEY',IME_ESC_PRIVATE_HOTKEY);
    AddConstant('IME_REGWORD_STYLE_EUDC',IME_REGWORD_STYLE_EUDC);
    AddConstant('IME_REGWORD_STYLE_USER_FIRST',IME_REGWORD_STYLE_USER_FIRST);
    AddConstant('IME_REGWORD_STYLE_USER_LAST',IME_REGWORD_STYLE_USER_LAST);
    AddConstant('SOFTKEYBOARD_TYPE_T1',SOFTKEYBOARD_TYPE_T1);
    AddConstant('SOFTKEYBOARD_TYPE_C1',SOFTKEYBOARD_TYPE_C1);
    AddConstant('imm32',imm32);
  end;
end;

class function TatImmLibrary.LibraryName: string;
begin
  result := 'Imm';
end;

initialization
  RegisterScripterLibrary(TatImmLibrary, True);

{$WARNINGS ON}

end.

