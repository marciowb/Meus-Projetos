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
unit ap_System;

interface

uses
  atScript;

{$WARNINGS OFF}

type
  TatDelphiSystemLibrary = class(TatScripterLibrary)
    procedure __TObjectCreate(AMachine: TatVirtualMachine);
    procedure __TObjectFree(AMachine: TatVirtualMachine);
    procedure __TObjectCleanupInstance(AMachine: TatVirtualMachine);
    procedure __TObjectClassName(AMachine: TatVirtualMachine);
    procedure __TObjectClassNameIs(AMachine: TatVirtualMachine);
    procedure __TObjectInstanceSize(AMachine: TatVirtualMachine);
    procedure __TObjectGetInterface(AMachine: TatVirtualMachine);
    procedure __TObjectAfterConstruction(AMachine: TatVirtualMachine);
    procedure __TObjectBeforeDestruction(AMachine: TatVirtualMachine);
    procedure __TObjectDispatch(AMachine: TatVirtualMachine);
    procedure __TObjectDefaultHandler(AMachine: TatVirtualMachine);
    procedure __TObjectNewInstance(AMachine: TatVirtualMachine);
    procedure __TObjectFreeInstance(AMachine: TatVirtualMachine);
    procedure __TObjectDestroy(AMachine: TatVirtualMachine);
    procedure __TInterfacedObjectAfterConstruction(AMachine: TatVirtualMachine);
    procedure __TInterfacedObjectBeforeDestruction(AMachine: TatVirtualMachine);
    procedure __TInterfacedObjectNewInstance(AMachine: TatVirtualMachine);
    procedure __GetTInterfacedObjectRefCount(AMachine: TatVirtualMachine);
    procedure __SetInOutRes(AMachine: TatVirtualMachine);
    procedure __GetMemoryManager(AMachine: TatVirtualMachine);
    procedure __SetMemoryManager(AMachine: TatVirtualMachine);
    procedure __IsMemoryManagerSet(AMachine: TatVirtualMachine);
    procedure __GetHeapStatus(AMachine: TatVirtualMachine);
    procedure __EndThread(AMachine: TatVirtualMachine);
    procedure __IOResult(AMachine: TatVirtualMachine);
    procedure __Move(AMachine: TatVirtualMachine);
    procedure __ParamCount(AMachine: TatVirtualMachine);
    procedure __ParamStr(AMachine: TatVirtualMachine);
    procedure __Randomize(AMachine: TatVirtualMachine);
    procedure __UpCase(AMachine: TatVirtualMachine);
    procedure __Set8087CW(AMachine: TatVirtualMachine);
    procedure __WideCharToString(AMachine: TatVirtualMachine);
    procedure __WideCharLenToString(AMachine: TatVirtualMachine);
    procedure __WideCharToStrVar(AMachine: TatVirtualMachine);
    procedure __WideCharLenToStrVar(AMachine: TatVirtualMachine);
    procedure __StringToWideChar(AMachine: TatVirtualMachine);
    procedure __OleStrToString(AMachine: TatVirtualMachine);
    procedure __OleStrToStrVar(AMachine: TatVirtualMachine);
    procedure __StringToOleStr(AMachine: TatVirtualMachine);
    procedure __VarCopyNoInd(AMachine: TatVirtualMachine);
    procedure __VarType(AMachine: TatVirtualMachine);
    procedure __VarAsType(AMachine: TatVirtualMachine);
    procedure __VarIsEmpty(AMachine: TatVirtualMachine);
    procedure __VarIsNull(AMachine: TatVirtualMachine);
    procedure __VarToStr(AMachine: TatVirtualMachine);
    procedure __VarFromDateTime(AMachine: TatVirtualMachine);
    procedure __VarToDateTime(AMachine: TatVirtualMachine);
    procedure __VarArrayDimCount(AMachine: TatVirtualMachine);
    procedure __VarArrayLowBound(AMachine: TatVirtualMachine);
    procedure __VarArrayHighBound(AMachine: TatVirtualMachine);
    procedure __VarArrayUnlock(AMachine: TatVirtualMachine);
    procedure __VarArrayRef(AMachine: TatVirtualMachine);
    procedure __VarIsArray(AMachine: TatVirtualMachine);
    procedure __FindResourceHInstance(AMachine: TatVirtualMachine);
    procedure __LoadResourceModule(AMachine: TatVirtualMachine);
    procedure __UniqueString(AMachine: TatVirtualMachine);
    procedure __FPower10(AMachine: TatVirtualMachine);
    procedure __TextStart(AMachine: TatVirtualMachine);
    procedure __CompToDouble(AMachine: TatVirtualMachine);
    procedure __DoubleToComp(AMachine: TatVirtualMachine);
    procedure __CompToCurrency(AMachine: TatVirtualMachine);
    procedure __CurrencyToComp(AMachine: TatVirtualMachine);
    procedure __GetHPrevInst(AMachine: TatVirtualMachine);
    procedure __SetHPrevInst(AMachine: TatVirtualMachine);
    procedure __GetMainInstance(AMachine: TatVirtualMachine);
    procedure __SetMainInstance(AMachine: TatVirtualMachine);
    procedure __GetMainThreadID(AMachine: TatVirtualMachine);
    procedure __SetMainThreadID(AMachine: TatVirtualMachine);
    procedure __GetIsLibrary(AMachine: TatVirtualMachine);
    procedure __SetIsLibrary(AMachine: TatVirtualMachine);
    procedure __GetCmdShow(AMachine: TatVirtualMachine);
    procedure __SetCmdShow(AMachine: TatVirtualMachine);
    procedure __GetCmdLine(AMachine: TatVirtualMachine);
    procedure __SetCmdLine(AMachine: TatVirtualMachine);
    procedure __GetExitCode(AMachine: TatVirtualMachine);
    procedure __SetExitCode(AMachine: TatVirtualMachine);
    procedure __GetRandSeed(AMachine: TatVirtualMachine);
    procedure __SetRandSeed(AMachine: TatVirtualMachine);
    procedure __GetIsConsole(AMachine: TatVirtualMachine);
    procedure __SetIsConsole(AMachine: TatVirtualMachine);
    procedure __GetIsMultiThread(AMachine: TatVirtualMachine);
    procedure __SetIsMultiThread(AMachine: TatVirtualMachine);
    procedure __GetFileMode(AMachine: TatVirtualMachine);
    procedure __SetFileMode(AMachine: TatVirtualMachine);
    procedure __GetTest8086(AMachine: TatVirtualMachine);
    procedure __SetTest8086(AMachine: TatVirtualMachine);
    procedure __GetTest8087(AMachine: TatVirtualMachine);
    procedure __SetTest8087(AMachine: TatVirtualMachine);
    procedure __GetTestFDIV(AMachine: TatVirtualMachine);
    procedure __SetTestFDIV(AMachine: TatVirtualMachine);
    procedure __GetDefault8087CW(AMachine: TatVirtualMachine);
    procedure __SetDefault8087CW(AMachine: TatVirtualMachine);
    procedure __GetHeapAllocFlags(AMachine: TatVirtualMachine);
    procedure __SetHeapAllocFlags(AMachine: TatVirtualMachine);
    procedure __GetDebugHook(AMachine: TatVirtualMachine);
    procedure __SetDebugHook(AMachine: TatVirtualMachine);
    procedure __GetJITEnable(AMachine: TatVirtualMachine);
    procedure __SetJITEnable(AMachine: TatVirtualMachine);
    procedure __GetNoErrMsg(AMachine: TatVirtualMachine);
    procedure __SetNoErrMsg(AMachine: TatVirtualMachine);
    procedure __GetEmptyParam(AMachine: TatVirtualMachine);
    procedure __SetEmptyParam(AMachine: TatVirtualMachine);
    procedure __GetAllocMemCount(AMachine: TatVirtualMachine);
    procedure __SetAllocMemCount(AMachine: TatVirtualMachine);
    procedure __GetAllocMemSize(AMachine: TatVirtualMachine);
    procedure __SetAllocMemSize(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TObjectClass = class of TObject;
  TInterfacedObjectClass = class of TInterfacedObject;


  TGUIDWrapper = class(TatRecordWrapper)
  private
    FD1: LongWord;
    FD2: Word;
    FD3: Word;
  public
    constructor Create(ARecord: TGUID);
    function ObjToRec: TGUID;
  published
    property D1: LongWord read FD1 write FD1;
    property D2: Word read FD2 write FD2;
    property D3: Word read FD3 write FD3;
  end;
  
  TInterfaceEntryWrapper = class(TatRecordWrapper)
  private
    FIOffset: Integer;
    FImplGetter: Integer;
  public
    constructor Create(ARecord: TInterfaceEntry);
    function ObjToRec: TInterfaceEntry;
  published
    property IOffset: Integer read FIOffset write FIOffset;
    property ImplGetter: Integer read FImplGetter write FImplGetter;
  end;
  
  TInterfaceTableWrapper = class(TatRecordWrapper)
  private
    FEntryCount: Integer;
  public
    constructor Create(ARecord: TInterfaceTable);
    function ObjToRec: TInterfaceTable;
  published
    property EntryCount: Integer read FEntryCount write FEntryCount;
  end;
  
  TVarArrayBoundWrapper = class(TatRecordWrapper)
  private
    FElementCount: Integer;
    FLowBound: Integer;
  public
    constructor Create(ARecord: TVarArrayBound);
    function ObjToRec: TVarArrayBound;
  published
    property ElementCount: Integer read FElementCount write FElementCount;
    property LowBound: Integer read FLowBound write FLowBound;
  end;
  
  TVarArrayWrapper = class(TatRecordWrapper)
  private
    FDimCount: Word;
    FFlags: Word;
    FElementSize: Integer;
    FLockCount: Integer;
  public
    constructor Create(ARecord: TVarArray);
    function ObjToRec: TVarArray;
  published
    property DimCount: Word read FDimCount write FDimCount;
    property Flags: Word read FFlags write FFlags;
    property ElementSize: Integer read FElementSize write FElementSize;
    property LockCount: Integer read FLockCount write FLockCount;
  end;
  
  TVarDataWrapper = class(TatRecordWrapper)
  private
    FVType: Word;
    FReserved1: Word;
    FReserved2: Word;
    FReserved3: Word;
    FVSmallint: Smallint;
    FVInteger: Integer;
    FVSingle: Single;
    FVDouble: Double;
    FVCurrency: Currency;
    FVDate: Double;
    FVError: LongWord;
    FVBoolean: WordBool;
    FVByte: Byte;
  public
    constructor Create(ARecord: TVarData);
    function ObjToRec: TVarData;
  published
    property VType: Word read FVType write FVType;
    property Reserved1: Word read FReserved1 write FReserved1;
    property Reserved2: Word read FReserved2 write FReserved2;
    property Reserved3: Word read FReserved3 write FReserved3;
    property VSmallint: Smallint read FVSmallint write FVSmallint;
    property VInteger: Integer read FVInteger write FVInteger;
    property VSingle: Single read FVSingle write FVSingle;
    property VDouble: Double read FVDouble write FVDouble;
    property VCurrency: Currency read FVCurrency write FVCurrency;
    property VDate: Double read FVDate write FVDate;
    property VError: LongWord read FVError write FVError;
    property VBoolean: WordBool read FVBoolean write FVBoolean;
    property VByte: Byte read FVByte write FVByte;
  end;
  
  TVarRecWrapper = class(TatRecordWrapper)
  private
    FVInteger: Integer;
    FVType: Byte;
    FVBoolean: Boolean;
    FVChar: Char;
    FVObject: TObject;
  public
    constructor Create(ARecord: TVarRec);
    function ObjToRec: TVarRec;
  published
    property VInteger: Integer read FVInteger write FVInteger;
    property VType: Byte read FVType write FVType;
    property VBoolean: Boolean read FVBoolean write FVBoolean;
    property VChar: Char read FVChar write FVChar;
    property VObject: TObject read FVObject write FVObject;
  end;
  
  TMemoryManagerWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TMemoryManager);
    function ObjToRec: TMemoryManager;
  published
  end;
  
  THeapStatusWrapper = class(TatRecordWrapper)
  private
    FTotalAddrSpace: Cardinal;
    FTotalUncommitted: Cardinal;
    FTotalCommitted: Cardinal;
    FTotalAllocated: Cardinal;
    FTotalFree: Cardinal;
    FFreeSmall: Cardinal;
    FFreeBig: Cardinal;
    FUnused: Cardinal;
    FOverhead: Cardinal;
    FHeapErrorCode: Cardinal;
  public
    constructor Create(ARecord: THeapStatus);
    function ObjToRec: THeapStatus;
  published
    property TotalAddrSpace: Cardinal read FTotalAddrSpace write FTotalAddrSpace;
    property TotalUncommitted: Cardinal read FTotalUncommitted write FTotalUncommitted;
    property TotalCommitted: Cardinal read FTotalCommitted write FTotalCommitted;
    property TotalAllocated: Cardinal read FTotalAllocated write FTotalAllocated;
    property TotalFree: Cardinal read FTotalFree write FTotalFree;
    property FreeSmall: Cardinal read FFreeSmall write FFreeSmall;
    property FreeBig: Cardinal read FFreeBig write FFreeBig;
    property Unused: Cardinal read FUnused write FUnused;
    property Overhead: Cardinal read FOverhead write FOverhead;
    property HeapErrorCode: Cardinal read FHeapErrorCode write FHeapErrorCode;
  end;
  
  PackageUnitEntryWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: PackageUnitEntry);
    function ObjToRec: PackageUnitEntry;
  published
  end;
  
  PackageInfoTableWrapper = class(TatRecordWrapper)
  private
    FUnitCount: Integer;
  public
    constructor Create(ARecord: PackageInfoTable);
    function ObjToRec: PackageInfoTable;
  published
    property UnitCount: Integer read FUnitCount write FUnitCount;
  end;
  
  TLibModuleWrapper = class(TatRecordWrapper)
  private
    FInstance: LongWord;
    FCodeInstance: LongWord;
    FDataInstance: LongWord;
    FResInstance: LongWord;
    FReserved: Integer;
  public
    constructor Create(ARecord: TLibModule);
    function ObjToRec: TLibModule;
  published
    property Instance: LongWord read FInstance write FInstance;
    property CodeInstance: LongWord read FCodeInstance write FCodeInstance;
    property DataInstance: LongWord read FDataInstance write FDataInstance;
    property ResInstance: LongWord read FResInstance write FResInstance;
    property Reserved: Integer read FReserved write FReserved;
  end;
  
  TModuleUnloadRecWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TModuleUnloadRec);
    function ObjToRec: TModuleUnloadRec;
  published
  end;
  
  TResStringRecWrapper = class(TatRecordWrapper)
  private
    FIdentifier: Integer;
  public
    constructor Create(ARecord: TResStringRec);
    function ObjToRec: TResStringRec;
  published
    property Identifier: Integer read FIdentifier write FIdentifier;
  end;
  

implementation

constructor TGUIDWrapper.Create(ARecord: TGUID);
begin
  inherited Create;
  FD1 := ARecord.D1;
  FD2 := ARecord.D2;
  FD3 := ARecord.D3;
end;

function TGUIDWrapper.ObjToRec: TGUID;
begin
  result.D1 := FD1;
  result.D2 := FD2;
  result.D3 := FD3;
end;

constructor TInterfaceEntryWrapper.Create(ARecord: TInterfaceEntry);
begin
  inherited Create;
  FIOffset := ARecord.IOffset;
  FImplGetter := ARecord.ImplGetter;
end;

function TInterfaceEntryWrapper.ObjToRec: TInterfaceEntry;
begin
  result.IOffset := FIOffset;
  result.ImplGetter := FImplGetter;
end;

constructor TInterfaceTableWrapper.Create(ARecord: TInterfaceTable);
begin
  inherited Create;
  FEntryCount := ARecord.EntryCount;
end;

function TInterfaceTableWrapper.ObjToRec: TInterfaceTable;
begin
  result.EntryCount := FEntryCount;
end;

constructor TVarArrayBoundWrapper.Create(ARecord: TVarArrayBound);
begin
  inherited Create;
  FElementCount := ARecord.ElementCount;
  FLowBound := ARecord.LowBound;
end;

function TVarArrayBoundWrapper.ObjToRec: TVarArrayBound;
begin
  result.ElementCount := FElementCount;
  result.LowBound := FLowBound;
end;

constructor TVarArrayWrapper.Create(ARecord: TVarArray);
begin
  inherited Create;
  FDimCount := ARecord.DimCount;
  FFlags := ARecord.Flags;
  FElementSize := ARecord.ElementSize;
  FLockCount := ARecord.LockCount;
end;

function TVarArrayWrapper.ObjToRec: TVarArray;
begin
  result.DimCount := FDimCount;
  result.Flags := FFlags;
  result.ElementSize := FElementSize;
  result.LockCount := FLockCount;
end;

constructor TVarDataWrapper.Create(ARecord: TVarData);
begin
  inherited Create;
  FVType := ARecord.VType;
  FReserved1 := ARecord.Reserved1;
  FReserved2 := ARecord.Reserved2;
  FReserved3 := ARecord.Reserved3;
  FVSmallint := ARecord.VSmallint;
  FVInteger := ARecord.VInteger;
  FVSingle := ARecord.VSingle;
  FVDouble := ARecord.VDouble;
  FVCurrency := ARecord.VCurrency;
  FVDate := ARecord.VDate;
  FVError := ARecord.VError;
  FVBoolean := ARecord.VBoolean;
  FVByte := ARecord.VByte;
end;

function TVarDataWrapper.ObjToRec: TVarData;
begin
  result.VType := FVType;
  result.Reserved1 := FReserved1;
  result.Reserved2 := FReserved2;
  result.Reserved3 := FReserved3;
  result.VSmallint := FVSmallint;
  result.VInteger := FVInteger;
  result.VSingle := FVSingle;
  result.VDouble := FVDouble;
  result.VCurrency := FVCurrency;
  result.VDate := FVDate;
  result.VError := FVError;
  result.VBoolean := FVBoolean;
  result.VByte := FVByte;
end;

constructor TVarRecWrapper.Create(ARecord: TVarRec);
begin
  inherited Create;
  FVInteger := ARecord.VInteger;
  FVType := ARecord.VType;
  FVBoolean := ARecord.VBoolean;
  FVChar := ARecord.VChar;
  FVObject := ARecord.VObject;
end;

function TVarRecWrapper.ObjToRec: TVarRec;
begin
  result.VInteger := FVInteger;
  result.VType := FVType;
  result.VBoolean := FVBoolean;
  result.VChar := FVChar;
  result.VObject := FVObject;
end;

constructor TMemoryManagerWrapper.Create(ARecord: TMemoryManager);
begin
  inherited Create;
end;

function TMemoryManagerWrapper.ObjToRec: TMemoryManager;
begin
end;

constructor THeapStatusWrapper.Create(ARecord: THeapStatus);
begin
  inherited Create;
  FTotalAddrSpace := ARecord.TotalAddrSpace;
  FTotalUncommitted := ARecord.TotalUncommitted;
  FTotalCommitted := ARecord.TotalCommitted;
  FTotalAllocated := ARecord.TotalAllocated;
  FTotalFree := ARecord.TotalFree;
  FFreeSmall := ARecord.FreeSmall;
  FFreeBig := ARecord.FreeBig;
  FUnused := ARecord.Unused;
  FOverhead := ARecord.Overhead;
  FHeapErrorCode := ARecord.HeapErrorCode;
end;

function THeapStatusWrapper.ObjToRec: THeapStatus;
begin
  result.TotalAddrSpace := FTotalAddrSpace;
  result.TotalUncommitted := FTotalUncommitted;
  result.TotalCommitted := FTotalCommitted;
  result.TotalAllocated := FTotalAllocated;
  result.TotalFree := FTotalFree;
  result.FreeSmall := FFreeSmall;
  result.FreeBig := FFreeBig;
  result.Unused := FUnused;
  result.Overhead := FOverhead;
  result.HeapErrorCode := FHeapErrorCode;
end;

constructor PackageUnitEntryWrapper.Create(ARecord: PackageUnitEntry);
begin
  inherited Create;
end;

function PackageUnitEntryWrapper.ObjToRec: PackageUnitEntry;
begin
end;

constructor PackageInfoTableWrapper.Create(ARecord: PackageInfoTable);
begin
  inherited Create;
  FUnitCount := ARecord.UnitCount;
end;

function PackageInfoTableWrapper.ObjToRec: PackageInfoTable;
begin
  result.UnitCount := FUnitCount;
end;

constructor TLibModuleWrapper.Create(ARecord: TLibModule);
begin
  inherited Create;
  FInstance := ARecord.Instance;
  FCodeInstance := ARecord.CodeInstance;
  FDataInstance := ARecord.DataInstance;
  FResInstance := ARecord.ResInstance;
  FReserved := ARecord.Reserved;
end;

function TLibModuleWrapper.ObjToRec: TLibModule;
begin
  result.Instance := FInstance;
  result.CodeInstance := FCodeInstance;
  result.DataInstance := FDataInstance;
  result.ResInstance := FResInstance;
  result.Reserved := FReserved;
end;

constructor TModuleUnloadRecWrapper.Create(ARecord: TModuleUnloadRec);
begin
  inherited Create;
end;

function TModuleUnloadRecWrapper.ObjToRec: TModuleUnloadRec;
begin
end;

constructor TResStringRecWrapper.Create(ARecord: TResStringRec);
begin
  inherited Create;
  FIdentifier := ARecord.Identifier;
end;

function TResStringRecWrapper.ObjToRec: TResStringRec;
begin
  result.Identifier := FIdentifier;
end;



procedure TatDelphiSystemLibrary.__TObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectFree(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObject(CurrentObject).Free;
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectCleanupInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObject(CurrentObject).CleanupInstance;
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectClassName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TObjectClass(CurrentClass.ClassRef).ClassName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectClassNameIs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TObjectClass(CurrentClass.ClassRef).ClassNameIs(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectInstanceSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectClass(CurrentClass.ClassRef).InstanceSize);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectGetInterface(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := TObject(CurrentObject).GetInterface(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectAfterConstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObject(CurrentObject).AfterConstruction;
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectBeforeDestruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObject(CurrentObject).BeforeDestruction;
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectDispatch(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TObject(CurrentObject).Dispatch(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TObject(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectNewInstance(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectClass(CurrentClass.ClassRef).NewInstance);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectFreeInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObject(CurrentObject).FreeInstance;
  end;
end;

procedure TatDelphiSystemLibrary.__TObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObject(CurrentObject).Destroy;
  end;
end;

procedure TatDelphiSystemLibrary.__TInterfacedObjectAfterConstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInterfacedObject(CurrentObject).AfterConstruction;
  end;
end;

procedure TatDelphiSystemLibrary.__TInterfacedObjectBeforeDestruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInterfacedObject(CurrentObject).BeforeDestruction;
  end;
end;

procedure TatDelphiSystemLibrary.__TInterfacedObjectNewInstance(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TInterfacedObjectClass(CurrentClass.ClassRef).NewInstance);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__GetTInterfacedObjectRefCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TInterfacedObject(CurrentObject).RefCount));
  end;
end;

procedure TatDelphiSystemLibrary.__SetInOutRes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.SetInOutRes(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatDelphiSystemLibrary.__GetMemoryManager(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMemoryManager;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TMemoryManagerWrapper) then 
  Param0Rec := TMemoryManagerWrapper.Create(Param0);
Param0 := TMemoryManagerWrapper(Param0Rec).ObjToRec;
    System.GetMemoryManager(Param0);
    SetInputArg(0,integer(TMemoryManagerWrapper.Create(Param0)));
  end;
end;

procedure TatDelphiSystemLibrary.__SetMemoryManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.SetMemoryManager(TMemoryManagerWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatDelphiSystemLibrary.__IsMemoryManagerSet(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.IsMemoryManagerSet;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__GetHeapStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(THeapStatusWrapper.Create(System.GetHeapStatus));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__EndThread(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.EndThread(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatDelphiSystemLibrary.__IOResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(System.IOResult);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__Move(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  Param1: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    System.Move(Param0,Param1,VarToInteger(GetInputArg(2)));
    SetInputArg(1,Param1);
  end;
end;

procedure TatDelphiSystemLibrary.__ParamCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(System.ParamCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__ParamStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.ParamStr(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__Randomize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.Randomize;
  end;
end;

procedure TatDelphiSystemLibrary.__UpCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.UpCase(VarToStr(GetInputArg(0))[1]);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__Set8087CW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.Set8087CW(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatDelphiSystemLibrary.__WideCharToString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.WideCharToString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__WideCharLenToString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.WideCharLenToString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__WideCharToStrVar(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: string;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    System.WideCharToStrVar(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatDelphiSystemLibrary.__WideCharLenToStrVar(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: string;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
    System.WideCharLenToStrVar(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2);
    SetInputArg(2,Param2);
  end;
end;

procedure TatDelphiSystemLibrary.__StringToWideChar(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(System.StringToWideChar(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__OleStrToString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.OleStrToString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__OleStrToStrVar(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: string;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    System.OleStrToStrVar(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatDelphiSystemLibrary.__StringToOleStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(System.StringToOleStr(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarCopyNoInd(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    System.VarCopyNoInd(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatDelphiSystemLibrary.__VarType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(System.VarType(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarAsType(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := System.VarAsType(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatDelphiSystemLibrary.__VarIsEmpty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.VarIsEmpty(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarIsNull(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.VarIsNull(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.VarToStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarFromDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.VarFromDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.VarToDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarArrayDimCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(System.VarArrayDimCount(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarArrayLowBound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(System.VarArrayLowBound(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarArrayHighBound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(System.VarArrayHighBound(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarArrayUnlock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.VarArrayUnlock(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__VarArrayRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.VarArrayRef(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__VarIsArray(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.VarIsArray(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__FindResourceHInstance(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(System.FindResourceHInstance(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__LoadResourceModule(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(System.LoadResourceModule(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__UniqueString(AMachine: TatVirtualMachine);
  var
  Param0: string;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    System.UniqueString(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDelphiSystemLibrary.__FPower10(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.FPower10;
  end;
end;

procedure TatDelphiSystemLibrary.__TextStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.TextStart;
  end;
end;

procedure TatDelphiSystemLibrary.__CompToDouble(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.CompToDouble(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__DoubleToComp(AMachine: TatVirtualMachine);
  var
  Param1: Comp;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    System.DoubleToComp(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatDelphiSystemLibrary.__CompToCurrency(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := System.CompToCurrency(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDelphiSystemLibrary.__CurrencyToComp(AMachine: TatVirtualMachine);
  var
  Param1: Comp;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    System.CurrencyToComp(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatDelphiSystemLibrary.__GetHPrevInst(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.HPrevInst));
  end;
end;

procedure TatDelphiSystemLibrary.__SetHPrevInst(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.HPrevInst:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetMainInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.MainInstance));
  end;
end;

procedure TatDelphiSystemLibrary.__SetMainInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.MainInstance:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetMainThreadID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.MainThreadID));
  end;
end;

procedure TatDelphiSystemLibrary.__SetMainThreadID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.MainThreadID:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetIsLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(System.IsLibrary);
  end;
end;

procedure TatDelphiSystemLibrary.__SetIsLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.IsLibrary:=GetInputArg(0);
  end;
end;

procedure TatDelphiSystemLibrary.__GetCmdShow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.CmdShow));
  end;
end;

procedure TatDelphiSystemLibrary.__SetCmdShow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.CmdShow:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetCmdLine(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(string(System.CmdLine));
  end;
end;

procedure TatDelphiSystemLibrary.__SetCmdLine(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.CmdLine:=PChar(VarToStr(GetInputArg(0)));
  end;
end;

procedure TatDelphiSystemLibrary.__GetExitCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.ExitCode));
  end;
end;

procedure TatDelphiSystemLibrary.__SetExitCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.ExitCode:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetRandSeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.RandSeed));
  end;
end;

procedure TatDelphiSystemLibrary.__SetRandSeed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.RandSeed:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetIsConsole(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(System.IsConsole);
  end;
end;

procedure TatDelphiSystemLibrary.__SetIsConsole(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.IsConsole:=GetInputArg(0);
  end;
end;

procedure TatDelphiSystemLibrary.__GetIsMultiThread(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(System.IsMultiThread);
  end;
end;

procedure TatDelphiSystemLibrary.__SetIsMultiThread(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.IsMultiThread:=GetInputArg(0);
  end;
end;

procedure TatDelphiSystemLibrary.__GetFileMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.FileMode));
  end;
end;

procedure TatDelphiSystemLibrary.__SetFileMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.FileMode:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetTest8086(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.Test8086));
  end;
end;

procedure TatDelphiSystemLibrary.__SetTest8086(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.Test8086:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetTest8087(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.Test8087));
  end;
end;

procedure TatDelphiSystemLibrary.__SetTest8087(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.Test8087:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetTestFDIV(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.TestFDIV));
  end;
end;

procedure TatDelphiSystemLibrary.__SetTestFDIV(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.TestFDIV:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetDefault8087CW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.Default8087CW));
  end;
end;

procedure TatDelphiSystemLibrary.__SetDefault8087CW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.Default8087CW:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetHeapAllocFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.HeapAllocFlags));
  end;
end;

procedure TatDelphiSystemLibrary.__SetHeapAllocFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.HeapAllocFlags:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetDebugHook(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.DebugHook));
  end;
end;

procedure TatDelphiSystemLibrary.__SetDebugHook(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.DebugHook:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetJITEnable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.JITEnable));
  end;
end;

procedure TatDelphiSystemLibrary.__SetJITEnable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.JITEnable:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetNoErrMsg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(System.NoErrMsg);
  end;
end;

procedure TatDelphiSystemLibrary.__SetNoErrMsg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.NoErrMsg:=GetInputArg(0);
  end;
end;

procedure TatDelphiSystemLibrary.__GetEmptyParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(System.EmptyParam);
  end;
end;

procedure TatDelphiSystemLibrary.__SetEmptyParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.EmptyParam:=GetInputArg(0);
  end;
end;

procedure TatDelphiSystemLibrary.__GetAllocMemCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.AllocMemCount));
  end;
end;

procedure TatDelphiSystemLibrary.__SetAllocMemCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.AllocMemCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.__GetAllocMemSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(System.AllocMemSize));
  end;
end;

procedure TatDelphiSystemLibrary.__SetAllocMemSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    System.AllocMemSize:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDelphiSystemLibrary.Init;
begin
  With Scripter.DefineClass(TObject) do
  begin
    DefineMethod('Create',0,tkClass,TObject,__TObjectCreate,true,0);
    DefineMethod('Free',0,tkNone,nil,__TObjectFree,false,0);
    DefineMethod('CleanupInstance',0,tkNone,nil,__TObjectCleanupInstance,false,0);
    DefineMethod('ClassName',0,tkVariant,nil,__TObjectClassName,true,0);
    DefineMethod('ClassNameIs',1,tkVariant,nil,__TObjectClassNameIs,true,0);
    DefineMethod('InstanceSize',0,tkInteger,nil,__TObjectInstanceSize,true,0);
    DefineMethod('GetInterface',2,tkVariant,nil,__TObjectGetInterface,false,0).SetVarArgs([1]);
    DefineMethod('AfterConstruction',0,tkNone,nil,__TObjectAfterConstruction,false,0);
    DefineMethod('BeforeDestruction',0,tkNone,nil,__TObjectBeforeDestruction,false,0);
    DefineMethod('Dispatch',1,tkNone,nil,__TObjectDispatch,false,0).SetVarArgs([0]);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TObjectDefaultHandler,false,0).SetVarArgs([0]);
    DefineMethod('NewInstance',0,tkClass,TObject,__TObjectNewInstance,true,0);
    DefineMethod('FreeInstance',0,tkNone,nil,__TObjectFreeInstance,false,0);
    DefineMethod('Destroy',0,tkNone,nil,__TObjectDestroy,false,0);
  end;
  With Scripter.DefineClass(TInterfacedObject) do
  begin
    DefineMethod('AfterConstruction',0,tkNone,nil,__TInterfacedObjectAfterConstruction,false,0);
    DefineMethod('BeforeDestruction',0,tkNone,nil,__TInterfacedObjectBeforeDestruction,false,0);
    DefineMethod('NewInstance',0,tkClass,TObject,__TInterfacedObjectNewInstance,true,0);
    DefineProp('RefCount',tkInteger,__GetTInterfacedObjectRefCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('SetInOutRes',1,tkNone,nil,__SetInOutRes,false,0);
    DefineMethod('GetMemoryManager',1,tkNone,nil,__GetMemoryManager,false,0).SetVarArgs([0]);
    DefineMethod('SetMemoryManager',1,tkNone,nil,__SetMemoryManager,false,0);
    DefineMethod('IsMemoryManagerSet',0,tkVariant,nil,__IsMemoryManagerSet,false,0);
    DefineMethod('GetHeapStatus',0,tkVariant,nil,__GetHeapStatus,false,0);
    DefineMethod('EndThread',1,tkNone,nil,__EndThread,false,0);
    DefineMethod('IOResult',0,tkInteger,nil,__IOResult,false,0);
    DefineMethod('Move',3,tkNone,nil,__Move,false,0).SetVarArgs([1]);
    DefineMethod('ParamCount',0,tkInteger,nil,__ParamCount,false,0);
    DefineMethod('ParamStr',1,tkVariant,nil,__ParamStr,false,0);
    DefineMethod('Randomize',0,tkNone,nil,__Randomize,false,0);
    DefineMethod('UpCase',1,tkVariant,nil,__UpCase,false,0);
    DefineMethod('Set8087CW',1,tkNone,nil,__Set8087CW,false,0);
    DefineMethod('WideCharToString',1,tkVariant,nil,__WideCharToString,false,0);
    DefineMethod('WideCharLenToString',2,tkVariant,nil,__WideCharLenToString,false,0);
    DefineMethod('WideCharToStrVar',2,tkNone,nil,__WideCharToStrVar,false,0).SetVarArgs([1]);
    DefineMethod('WideCharLenToStrVar',3,tkNone,nil,__WideCharLenToStrVar,false,0).SetVarArgs([2]);
    DefineMethod('StringToWideChar',3,tkVariant,nil,__StringToWideChar,false,0);
    DefineMethod('OleStrToString',1,tkVariant,nil,__OleStrToString,false,0);
    DefineMethod('OleStrToStrVar',2,tkNone,nil,__OleStrToStrVar,false,0).SetVarArgs([1]);
    DefineMethod('StringToOleStr',1,tkVariant,nil,__StringToOleStr,false,0);
    DefineMethod('VarCopyNoInd',2,tkNone,nil,__VarCopyNoInd,false,0).SetVarArgs([0]);
    DefineMethod('VarType',1,tkInteger,nil,__VarType,false,0);
    DefineMethod('VarAsType',2,tkVariant,nil,__VarAsType,false,0).SetVarArgs([1]);
    DefineMethod('VarIsEmpty',1,tkVariant,nil,__VarIsEmpty,false,0);
    DefineMethod('VarIsNull',1,tkVariant,nil,__VarIsNull,false,0);
    DefineMethod('VarToStr',1,tkVariant,nil,__VarToStr,false,0);
    DefineMethod('VarFromDateTime',1,tkVariant,nil,__VarFromDateTime,false,0);
    DefineMethod('VarToDateTime',1,tkVariant,nil,__VarToDateTime,false,0);
    DefineMethod('VarArrayDimCount',1,tkInteger,nil,__VarArrayDimCount,false,0);
    DefineMethod('VarArrayLowBound',2,tkInteger,nil,__VarArrayLowBound,false,0);
    DefineMethod('VarArrayHighBound',2,tkInteger,nil,__VarArrayHighBound,false,0);
    DefineMethod('VarArrayUnlock',1,tkNone,nil,__VarArrayUnlock,false,0);
    DefineMethod('VarArrayRef',1,tkVariant,nil,__VarArrayRef,false,0);
    DefineMethod('VarIsArray',1,tkVariant,nil,__VarIsArray,false,0);
    DefineMethod('FindResourceHInstance',1,tkInteger,nil,__FindResourceHInstance,false,0);
    DefineMethod('LoadResourceModule',1,tkInteger,nil,__LoadResourceModule,false,0);
    DefineMethod('UniqueString',1,tkNone,nil,__UniqueString,false,0).SetVarArgs([0]);
    DefineMethod('FPower10',0,tkNone,nil,__FPower10,false,0);
    DefineMethod('TextStart',0,tkNone,nil,__TextStart,false,0);
    DefineMethod('CompToDouble',1,tkVariant,nil,__CompToDouble,false,0);
    DefineMethod('DoubleToComp',2,tkNone,nil,__DoubleToComp,false,0).SetVarArgs([1]);
    DefineMethod('CompToCurrency',1,tkVariant,nil,__CompToCurrency,false,0);
    DefineMethod('CurrencyToComp',2,tkNone,nil,__CurrencyToComp,false,0).SetVarArgs([1]);
    DefineProp('HPrevInst',tkInteger,__GetHPrevInst,__SetHPrevInst,nil,false,0);
    DefineProp('MainInstance',tkInteger,__GetMainInstance,__SetMainInstance,nil,false,0);
    DefineProp('MainThreadID',tkInteger,__GetMainThreadID,__SetMainThreadID,nil,false,0);
    DefineProp('IsLibrary',tkVariant,__GetIsLibrary,__SetIsLibrary,nil,false,0);
    DefineProp('CmdShow',tkInteger,__GetCmdShow,__SetCmdShow,nil,false,0);
    DefineProp('CmdLine',tkVariant,__GetCmdLine,__SetCmdLine,nil,false,0);
    DefineProp('ExitCode',tkInteger,__GetExitCode,__SetExitCode,nil,false,0);
    DefineProp('RandSeed',tkInteger,__GetRandSeed,__SetRandSeed,nil,false,0);
    DefineProp('IsConsole',tkVariant,__GetIsConsole,__SetIsConsole,nil,false,0);
    DefineProp('IsMultiThread',tkVariant,__GetIsMultiThread,__SetIsMultiThread,nil,false,0);
    DefineProp('FileMode',tkInteger,__GetFileMode,__SetFileMode,nil,false,0);
    DefineProp('Test8086',tkInteger,__GetTest8086,__SetTest8086,nil,false,0);
    DefineProp('Test8087',tkInteger,__GetTest8087,__SetTest8087,nil,false,0);
    DefineProp('TestFDIV',tkInteger,__GetTestFDIV,__SetTestFDIV,nil,false,0);
    DefineProp('Default8087CW',tkInteger,__GetDefault8087CW,__SetDefault8087CW,nil,false,0);
    DefineProp('HeapAllocFlags',tkInteger,__GetHeapAllocFlags,__SetHeapAllocFlags,nil,false,0);
    DefineProp('DebugHook',tkInteger,__GetDebugHook,__SetDebugHook,nil,false,0);
    DefineProp('JITEnable',tkInteger,__GetJITEnable,__SetJITEnable,nil,false,0);
    DefineProp('NoErrMsg',tkVariant,__GetNoErrMsg,__SetNoErrMsg,nil,false,0);
    DefineProp('EmptyParam',tkVariant,__GetEmptyParam,__SetEmptyParam,nil,false,0);
    DefineProp('AllocMemCount',tkInteger,__GetAllocMemCount,__SetAllocMemCount,nil,false,0);
    DefineProp('AllocMemSize',tkInteger,__GetAllocMemSize,__SetAllocMemSize,nil,false,0);
    AddConstant('varEmpty',varEmpty);
    AddConstant('varNull',varNull);
    AddConstant('varSmallint',varSmallint);
    AddConstant('varInteger',varInteger);
    AddConstant('varSingle',varSingle);
    AddConstant('varDouble',varDouble);
    AddConstant('varCurrency',varCurrency);
    AddConstant('varDate',varDate);
    AddConstant('varOleStr',varOleStr);
    AddConstant('varDispatch',varDispatch);
    AddConstant('varError',varError);
    AddConstant('varBoolean',varBoolean);
    AddConstant('varVariant',varVariant);
    AddConstant('varUnknown',varUnknown);
    AddConstant('varByte',varByte);
    AddConstant('varStrArg',varStrArg);
    AddConstant('varString',varString);
    AddConstant('varAny',varAny);
    AddConstant('varTypeMask',varTypeMask);
    AddConstant('varArray',varArray);
    AddConstant('varByRef',varByRef);
    AddConstant('vtInteger',vtInteger);
    AddConstant('vtBoolean',vtBoolean);
    AddConstant('vtChar',vtChar);
    AddConstant('vtExtended',vtExtended);
    AddConstant('vtString',vtString);
    AddConstant('vtPointer',vtPointer);
    AddConstant('vtPChar',vtPChar);
    AddConstant('vtObject',vtObject);
    AddConstant('vtClass',vtClass);
    AddConstant('vtWideChar',vtWideChar);
    AddConstant('vtPWideChar',vtPWideChar);
    AddConstant('vtAnsiString',vtAnsiString);
    AddConstant('vtCurrency',vtCurrency);
    AddConstant('vtVariant',vtVariant);
    AddConstant('vtInterface',vtInterface);
    AddConstant('vtWideString',vtWideString);
    AddConstant('vtInt64',vtInt64);
    AddConstant('vmtSelfPtr',vmtSelfPtr);
    AddConstant('vmtIntfTable',vmtIntfTable);
    AddConstant('vmtAutoTable',vmtAutoTable);
    AddConstant('vmtInitTable',vmtInitTable);
    AddConstant('vmtTypeInfo',vmtTypeInfo);
    AddConstant('vmtFieldTable',vmtFieldTable);
    AddConstant('vmtMethodTable',vmtMethodTable);
    AddConstant('vmtDynamicTable',vmtDynamicTable);
    AddConstant('vmtClassName',vmtClassName);
    AddConstant('vmtInstanceSize',vmtInstanceSize);
    AddConstant('vmtParent',vmtParent);
    AddConstant('vmtSafeCallException',vmtSafeCallException);
    AddConstant('vmtAfterConstruction',vmtAfterConstruction);
    AddConstant('vmtBeforeDestruction',vmtBeforeDestruction);
    AddConstant('vmtDispatch',vmtDispatch);
    AddConstant('vmtDefaultHandler',vmtDefaultHandler);
    AddConstant('vmtNewInstance',vmtNewInstance);
    AddConstant('vmtFreeInstance',vmtFreeInstance);
    AddConstant('vmtDestroy',vmtDestroy);
    AddConstant('vmtQueryInterface',vmtQueryInterface);
    AddConstant('vmtAddRef',vmtAddRef);
    AddConstant('vmtRelease',vmtRelease);
    AddConstant('vmtCreateObject',vmtCreateObject);
  end;
end;

class function TatDelphiSystemLibrary.LibraryName: string;
begin
  result := 'System';
end;

initialization
  RegisterScripterLibrary(TatDelphiSystemLibrary, True);

{$WARNINGS ON}

end.

