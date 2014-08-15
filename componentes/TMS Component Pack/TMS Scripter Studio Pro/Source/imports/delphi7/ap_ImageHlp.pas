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
unit ap_ImageHlp;

interface

uses
  Windows,
  ImageHlp,
  Variants,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatImageHlpLibrary = class(TatScripterLibrary)
    procedure __MapFileAndCheckSum(AMachine: TatVirtualMachine);
    procedure __MapFileAndCheckSumA(AMachine: TatVirtualMachine);
    procedure __MapFileAndCheckSumW(AMachine: TatVirtualMachine);
    procedure __TouchFileTimes(AMachine: TatVirtualMachine);
    procedure __SplitSymbols(AMachine: TatVirtualMachine);
    procedure __FindDebugInfoFile(AMachine: TatVirtualMachine);
    procedure __FindExecutableImage(AMachine: TatVirtualMachine);
    procedure __BindImage(AMachine: TatVirtualMachine);
    procedure __BindImageEx(AMachine: TatVirtualMachine);
    procedure __ReBaseImage(AMachine: TatVirtualMachine);
    procedure __SearchTreeForFile(AMachine: TatVirtualMachine);
    procedure __MakeSureDirectoryPathExists(AMachine: TatVirtualMachine);
    procedure __UnDecorateSymbolName(AMachine: TatVirtualMachine);
    procedure __GetTimestampForLoadedLibrary(AMachine: TatVirtualMachine);
    procedure __RemovePrivateCvSymbolic(AMachine: TatVirtualMachine);
    procedure __RemoveRelocations(AMachine: TatVirtualMachine);
    procedure __SymSetOptions(AMachine: TatVirtualMachine);
    procedure __SymGetOptions(AMachine: TatVirtualMachine);
    procedure __SymCleanup(AMachine: TatVirtualMachine);
    procedure __SymGetModuleInfo(AMachine: TatVirtualMachine);
    procedure __SymGetModuleBase(AMachine: TatVirtualMachine);
    procedure __SymInitialize(AMachine: TatVirtualMachine);
    procedure __SymGetSearchPath(AMachine: TatVirtualMachine);
    procedure __SymSetSearchPath(AMachine: TatVirtualMachine);
    procedure __SymLoadModule(AMachine: TatVirtualMachine);
    procedure __SymUnloadModule(AMachine: TatVirtualMachine);
    procedure __ImageRemoveCertificate(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _LOADED_IMAGEWrapper = class(TatRecordWrapper)
  private
    FhFile: THandle;
    FNumberOfSections: ULONG;
    FCharacteristics: ULONG;
    FfSystemImage: ByteBool;
    FfDOSImage: ByteBool;
    FSizeOfImage: ULONG;
  public
    constructor Create(ARecord: _LOADED_IMAGE);
    function ObjToRec: _LOADED_IMAGE;
  published
    property hFile: THandle read FhFile write FhFile;
    property NumberOfSections: ULONG read FNumberOfSections write FNumberOfSections;
    property Characteristics: ULONG read FCharacteristics write FCharacteristics;
    property fSystemImage: ByteBool read FfSystemImage write FfSystemImage;
    property fDOSImage: ByteBool read FfDOSImage write FfDOSImage;
    property SizeOfImage: ULONG read FSizeOfImage write FSizeOfImage;
  end;
  
  _IMAGE_DEBUG_INFORMATIONWrapper = class(TatRecordWrapper)
  private
    FSize: DWORD;
    FMachine: Word;
    FCharacteristics: Word;
    FCheckSum: DWORD;
    FImageBase: DWORD;
    FSizeOfImage: DWORD;
    FNumberOfSections: DWORD;
    FExportedNamesSize: DWORD;
    FNumberOfFunctionTableEntries: DWORD;
    FLowestFunctionStartingAddress: DWORD;
    FHighestFunctionEndingAddress: DWORD;
    FNumberOfFpoTableEntries: DWORD;
    FSizeOfCoffSymbols: DWORD;
    FSizeOfCodeViewSymbols: DWORD;
    FTimeDateStamp: DWORD;
    FRomImage: Bool;
    FNumberOfDebugDirectories: DWORD;
  public
    constructor Create(ARecord: _IMAGE_DEBUG_INFORMATION);
    function ObjToRec: _IMAGE_DEBUG_INFORMATION;
  published
    property Size: DWORD read FSize write FSize;
    property Machine: Word read FMachine write FMachine;
    property Characteristics: Word read FCharacteristics write FCharacteristics;
    property CheckSum: DWORD read FCheckSum write FCheckSum;
    property ImageBase: DWORD read FImageBase write FImageBase;
    property SizeOfImage: DWORD read FSizeOfImage write FSizeOfImage;
    property NumberOfSections: DWORD read FNumberOfSections write FNumberOfSections;
    property ExportedNamesSize: DWORD read FExportedNamesSize write FExportedNamesSize;
    property NumberOfFunctionTableEntries: DWORD read FNumberOfFunctionTableEntries write FNumberOfFunctionTableEntries;
    property LowestFunctionStartingAddress: DWORD read FLowestFunctionStartingAddress write FLowestFunctionStartingAddress;
    property HighestFunctionEndingAddress: DWORD read FHighestFunctionEndingAddress write FHighestFunctionEndingAddress;
    property NumberOfFpoTableEntries: DWORD read FNumberOfFpoTableEntries write FNumberOfFpoTableEntries;
    property SizeOfCoffSymbols: DWORD read FSizeOfCoffSymbols write FSizeOfCoffSymbols;
    property SizeOfCodeViewSymbols: DWORD read FSizeOfCodeViewSymbols write FSizeOfCodeViewSymbols;
    property TimeDateStamp: DWORD read FTimeDateStamp write FTimeDateStamp;
    property RomImage: Bool read FRomImage write FRomImage;
    property NumberOfDebugDirectories: DWORD read FNumberOfDebugDirectories write FNumberOfDebugDirectories;
  end;
  
  _tagADDRESSWrapper = class(TatRecordWrapper)
  private
    FOffset: DWORD;
    FSegment: Word;
    FMode: TAddressMode;
  public
    constructor Create(ARecord: _tagADDRESS);
    function ObjToRec: _tagADDRESS;
  published
    property Offset: DWORD read FOffset write FOffset;
    property Segment: Word read FSegment write FSegment;
    property Mode: TAddressMode read FMode write FMode;
  end;
  
  _KDHELPWrapper = class(TatRecordWrapper)
  private
    FThread: DWORD;
    FThCallbackStack: DWORD;
    FNextCallback: DWORD;
    FFramePointer: DWORD;
    FKiCallUserMode: DWORD;
    FKeUserCallbackDispatcher: DWORD;
  public
    constructor Create(ARecord: _KDHELP);
    function ObjToRec: _KDHELP;
  published
    property Thread: DWORD read FThread write FThread;
    property ThCallbackStack: DWORD read FThCallbackStack write FThCallbackStack;
    property NextCallback: DWORD read FNextCallback write FNextCallback;
    property FramePointer: DWORD read FFramePointer write FFramePointer;
    property KiCallUserMode: DWORD read FKiCallUserMode write FKiCallUserMode;
    property KeUserCallbackDispatcher: DWORD read FKeUserCallbackDispatcher write FKeUserCallbackDispatcher;
  end;
  
  _tagSTACKFRAMEWrapper = class(TatRecordWrapper)
  private
    F_Far: Bool;
    F_Virtual: Bool;
  public
    constructor Create(ARecord: _tagSTACKFRAME);
    function ObjToRec: _tagSTACKFRAME;
  published
    property _Far: Bool read F_Far write F_Far;
    property _Virtual: Bool read F_Virtual write F_Virtual;
  end;
  
  API_VERSIONWrapper = class(TatRecordWrapper)
  private
    FMajorVersion: Word;
    FMinorVersion: Word;
    FRevision: Word;
    FReserved: Word;
  public
    constructor Create(ARecord: API_VERSION);
    function ObjToRec: API_VERSION;
  published
    property MajorVersion: Word read FMajorVersion write FMajorVersion;
    property MinorVersion: Word read FMinorVersion write FMinorVersion;
    property Revision: Word read FRevision write FRevision;
    property Reserved: Word read FReserved write FReserved;
  end;
  
  _IMAGEHLP_SYMBOLWrapper = class(TatRecordWrapper)
  private
    FSizeOfStruct: DWORD;
    FAddress: DWORD;
    FSize: DWORD;
    FFlags: DWORD;
    FMaxNameLength: DWORD;
  public
    constructor Create(ARecord: _IMAGEHLP_SYMBOL);
    function ObjToRec: _IMAGEHLP_SYMBOL;
  published
    property SizeOfStruct: DWORD read FSizeOfStruct write FSizeOfStruct;
    property Address: DWORD read FAddress write FAddress;
    property Size: DWORD read FSize write FSize;
    property Flags: DWORD read FFlags write FFlags;
    property MaxNameLength: DWORD read FMaxNameLength write FMaxNameLength;
  end;
  
  _IMAGEHLP_MODULEWrapper = class(TatRecordWrapper)
  private
    FSizeOfStruct: DWORD;
    FBaseOfImage: DWORD;
    FImageSize: DWORD;
    FTimeDateStamp: DWORD;
    FCheckSum: DWORD;
    FNumSyms: DWORD;
    FSymType: TSymType;
  public
    constructor Create(ARecord: _IMAGEHLP_MODULE);
    function ObjToRec: _IMAGEHLP_MODULE;
  published
    property SizeOfStruct: DWORD read FSizeOfStruct write FSizeOfStruct;
    property BaseOfImage: DWORD read FBaseOfImage write FBaseOfImage;
    property ImageSize: DWORD read FImageSize write FImageSize;
    property TimeDateStamp: DWORD read FTimeDateStamp write FTimeDateStamp;
    property CheckSum: DWORD read FCheckSum write FCheckSum;
    property NumSyms: DWORD read FNumSyms write FNumSyms;
    property SymType: TSymType read FSymType write FSymType;
  end;
  
  _IMAGEHLP_DEFERRED_SYMBOL_LOADWrapper = class(TatRecordWrapper)
  private
    FSizeOfStruct: DWORD;
    FBaseOfImage: DWORD;
    FCheckSum: DWORD;
    FTimeDateStamp: DWORD;
  public
    constructor Create(ARecord: _IMAGEHLP_DEFERRED_SYMBOL_LOAD);
    function ObjToRec: _IMAGEHLP_DEFERRED_SYMBOL_LOAD;
  published
    property SizeOfStruct: DWORD read FSizeOfStruct write FSizeOfStruct;
    property BaseOfImage: DWORD read FBaseOfImage write FBaseOfImage;
    property CheckSum: DWORD read FCheckSum write FCheckSum;
    property TimeDateStamp: DWORD read FTimeDateStamp write FTimeDateStamp;
  end;
  
  _IMAGEHLP_DUPLICATE_SYMBOLWrapper = class(TatRecordWrapper)
  private
    FSizeOfStruct: DWORD;
    FNumberOfDups: DWORD;
    FSelectedSymbol: ULONG;
  public
    constructor Create(ARecord: _IMAGEHLP_DUPLICATE_SYMBOL);
    function ObjToRec: _IMAGEHLP_DUPLICATE_SYMBOL;
  published
    property SizeOfStruct: DWORD read FSizeOfStruct write FSizeOfStruct;
    property NumberOfDups: DWORD read FNumberOfDups write FNumberOfDups;
    property SelectedSymbol: ULONG read FSelectedSymbol write FSelectedSymbol;
  end;
  

implementation

constructor _LOADED_IMAGEWrapper.Create(ARecord: _LOADED_IMAGE);
begin
  inherited Create;
  FhFile := ARecord.hFile;
  FNumberOfSections := ARecord.NumberOfSections;
  FCharacteristics := ARecord.Characteristics;
  FfSystemImage := ARecord.fSystemImage;
  FfDOSImage := ARecord.fDOSImage;
  FSizeOfImage := ARecord.SizeOfImage;
end;

function _LOADED_IMAGEWrapper.ObjToRec: _LOADED_IMAGE;
begin
  result.hFile := FhFile;
  result.NumberOfSections := FNumberOfSections;
  result.Characteristics := FCharacteristics;
  result.fSystemImage := FfSystemImage;
  result.fDOSImage := FfDOSImage;
  result.SizeOfImage := FSizeOfImage;
end;

constructor _IMAGE_DEBUG_INFORMATIONWrapper.Create(ARecord: _IMAGE_DEBUG_INFORMATION);
begin
  inherited Create;
  FSize := ARecord.Size;
  FMachine := ARecord.Machine;
  FCharacteristics := ARecord.Characteristics;
  FCheckSum := ARecord.CheckSum;
  FImageBase := ARecord.ImageBase;
  FSizeOfImage := ARecord.SizeOfImage;
  FNumberOfSections := ARecord.NumberOfSections;
  FExportedNamesSize := ARecord.ExportedNamesSize;
  FNumberOfFunctionTableEntries := ARecord.NumberOfFunctionTableEntries;
  FLowestFunctionStartingAddress := ARecord.LowestFunctionStartingAddress;
  FHighestFunctionEndingAddress := ARecord.HighestFunctionEndingAddress;
  FNumberOfFpoTableEntries := ARecord.NumberOfFpoTableEntries;
  FSizeOfCoffSymbols := ARecord.SizeOfCoffSymbols;
  FSizeOfCodeViewSymbols := ARecord.SizeOfCodeViewSymbols;
  FTimeDateStamp := ARecord.TimeDateStamp;
  FRomImage := ARecord.RomImage;
  FNumberOfDebugDirectories := ARecord.NumberOfDebugDirectories;
end;

function _IMAGE_DEBUG_INFORMATIONWrapper.ObjToRec: _IMAGE_DEBUG_INFORMATION;
begin
  result.Size := FSize;
  result.Machine := FMachine;
  result.Characteristics := FCharacteristics;
  result.CheckSum := FCheckSum;
  result.ImageBase := FImageBase;
  result.SizeOfImage := FSizeOfImage;
  result.NumberOfSections := FNumberOfSections;
  result.ExportedNamesSize := FExportedNamesSize;
  result.NumberOfFunctionTableEntries := FNumberOfFunctionTableEntries;
  result.LowestFunctionStartingAddress := FLowestFunctionStartingAddress;
  result.HighestFunctionEndingAddress := FHighestFunctionEndingAddress;
  result.NumberOfFpoTableEntries := FNumberOfFpoTableEntries;
  result.SizeOfCoffSymbols := FSizeOfCoffSymbols;
  result.SizeOfCodeViewSymbols := FSizeOfCodeViewSymbols;
  result.TimeDateStamp := FTimeDateStamp;
  result.RomImage := FRomImage;
  result.NumberOfDebugDirectories := FNumberOfDebugDirectories;
end;

constructor _tagADDRESSWrapper.Create(ARecord: _tagADDRESS);
begin
  inherited Create;
  FOffset := ARecord.Offset;
  FSegment := ARecord.Segment;
  FMode := ARecord.Mode;
end;

function _tagADDRESSWrapper.ObjToRec: _tagADDRESS;
begin
  result.Offset := FOffset;
  result.Segment := FSegment;
  result.Mode := FMode;
end;

constructor _KDHELPWrapper.Create(ARecord: _KDHELP);
begin
  inherited Create;
  FThread := ARecord.Thread;
  FThCallbackStack := ARecord.ThCallbackStack;
  FNextCallback := ARecord.NextCallback;
  FFramePointer := ARecord.FramePointer;
  FKiCallUserMode := ARecord.KiCallUserMode;
  FKeUserCallbackDispatcher := ARecord.KeUserCallbackDispatcher;
end;

function _KDHELPWrapper.ObjToRec: _KDHELP;
begin
  result.Thread := FThread;
  result.ThCallbackStack := FThCallbackStack;
  result.NextCallback := FNextCallback;
  result.FramePointer := FFramePointer;
  result.KiCallUserMode := FKiCallUserMode;
  result.KeUserCallbackDispatcher := FKeUserCallbackDispatcher;
end;

constructor _tagSTACKFRAMEWrapper.Create(ARecord: _tagSTACKFRAME);
begin
  inherited Create;
  F_Far := ARecord._Far;
  F_Virtual := ARecord._Virtual;
end;

function _tagSTACKFRAMEWrapper.ObjToRec: _tagSTACKFRAME;
begin
  result._Far := F_Far;
  result._Virtual := F_Virtual;
end;

constructor API_VERSIONWrapper.Create(ARecord: API_VERSION);
begin
  inherited Create;
  FMajorVersion := ARecord.MajorVersion;
  FMinorVersion := ARecord.MinorVersion;
  FRevision := ARecord.Revision;
  FReserved := ARecord.Reserved;
end;

function API_VERSIONWrapper.ObjToRec: API_VERSION;
begin
  result.MajorVersion := FMajorVersion;
  result.MinorVersion := FMinorVersion;
  result.Revision := FRevision;
  result.Reserved := FReserved;
end;

constructor _IMAGEHLP_SYMBOLWrapper.Create(ARecord: _IMAGEHLP_SYMBOL);
begin
  inherited Create;
  FSizeOfStruct := ARecord.SizeOfStruct;
  FAddress := ARecord.Address;
  FSize := ARecord.Size;
  FFlags := ARecord.Flags;
  FMaxNameLength := ARecord.MaxNameLength;
end;

function _IMAGEHLP_SYMBOLWrapper.ObjToRec: _IMAGEHLP_SYMBOL;
begin
  result.SizeOfStruct := FSizeOfStruct;
  result.Address := FAddress;
  result.Size := FSize;
  result.Flags := FFlags;
  result.MaxNameLength := FMaxNameLength;
end;

constructor _IMAGEHLP_MODULEWrapper.Create(ARecord: _IMAGEHLP_MODULE);
begin
  inherited Create;
  FSizeOfStruct := ARecord.SizeOfStruct;
  FBaseOfImage := ARecord.BaseOfImage;
  FImageSize := ARecord.ImageSize;
  FTimeDateStamp := ARecord.TimeDateStamp;
  FCheckSum := ARecord.CheckSum;
  FNumSyms := ARecord.NumSyms;
  FSymType := ARecord.SymType;
end;

function _IMAGEHLP_MODULEWrapper.ObjToRec: _IMAGEHLP_MODULE;
begin
  result.SizeOfStruct := FSizeOfStruct;
  result.BaseOfImage := FBaseOfImage;
  result.ImageSize := FImageSize;
  result.TimeDateStamp := FTimeDateStamp;
  result.CheckSum := FCheckSum;
  result.NumSyms := FNumSyms;
  result.SymType := FSymType;
end;

constructor _IMAGEHLP_DEFERRED_SYMBOL_LOADWrapper.Create(ARecord: _IMAGEHLP_DEFERRED_SYMBOL_LOAD);
begin
  inherited Create;
  FSizeOfStruct := ARecord.SizeOfStruct;
  FBaseOfImage := ARecord.BaseOfImage;
  FCheckSum := ARecord.CheckSum;
  FTimeDateStamp := ARecord.TimeDateStamp;
end;

function _IMAGEHLP_DEFERRED_SYMBOL_LOADWrapper.ObjToRec: _IMAGEHLP_DEFERRED_SYMBOL_LOAD;
begin
  result.SizeOfStruct := FSizeOfStruct;
  result.BaseOfImage := FBaseOfImage;
  result.CheckSum := FCheckSum;
  result.TimeDateStamp := FTimeDateStamp;
end;

constructor _IMAGEHLP_DUPLICATE_SYMBOLWrapper.Create(ARecord: _IMAGEHLP_DUPLICATE_SYMBOL);
begin
  inherited Create;
  FSizeOfStruct := ARecord.SizeOfStruct;
  FNumberOfDups := ARecord.NumberOfDups;
  FSelectedSymbol := ARecord.SelectedSymbol;
end;

function _IMAGEHLP_DUPLICATE_SYMBOLWrapper.ObjToRec: _IMAGEHLP_DUPLICATE_SYMBOL;
begin
  result.SizeOfStruct := FSizeOfStruct;
  result.NumberOfDups := FNumberOfDups;
  result.SelectedSymbol := FSelectedSymbol;
end;



procedure TatImageHlpLibrary.__MapFileAndCheckSum(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ImageHlp.MapFileAndCheckSum(PChar(VarToStr(GetInputArg(0))),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatImageHlpLibrary.__MapFileAndCheckSumA(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ImageHlp.MapFileAndCheckSumA(PChar(VarToStr(GetInputArg(0))),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatImageHlpLibrary.__MapFileAndCheckSumW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: DWORD;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ImageHlp.MapFileAndCheckSumW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatImageHlpLibrary.__TouchFileTimes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.TouchFileTimes(VarToInteger(GetInputArg(0)),_SYSTEMTIMEWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SplitSymbols(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.SplitSymbols(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__FindDebugInfoFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ImageHlp.FindDebugInfoFile(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__FindExecutableImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ImageHlp.FindExecutableImage(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__BindImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.BindImage(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__BindImageEx(AMachine: TatVirtualMachine);
  var
  Param4: TImagehlpStatusReason;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := ImageHlp.BindImageEx(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),PChar(VarToStr(GetInputArg(3))),Param4);
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatImageHlpLibrary.__ReBaseImage(AMachine: TatVirtualMachine);
  var
  Param6: ULONG;
  Param7: ULONG;
  Param8: ULONG;
  Param9: ULONG;
  AResult: variant;
begin
  with AMachine do
  begin
Param6 := VarToInteger(GetInputArg(6));
Param7 := VarToInteger(GetInputArg(7));
Param8 := VarToInteger(GetInputArg(8));
Param9 := VarToInteger(GetInputArg(9));
AResult := ImageHlp.ReBaseImage(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),GetInputArg(2),GetInputArg(3),GetInputArg(4),VarToInteger(GetInputArg(5)),Param6,Param7,Param8,Param9,VarToInteger(GetInputArg(10)));
    ReturnOutputArg(AResult);
    SetInputArg(6,Integer(Param6));
    SetInputArg(7,Integer(Param7));
    SetInputArg(8,Integer(Param8));
    SetInputArg(9,Integer(Param9));
  end;
end;

procedure TatImageHlpLibrary.__SearchTreeForFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.SearchTreeForFile(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__MakeSureDirectoryPathExists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.MakeSureDirectoryPathExists(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__UnDecorateSymbolName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ImageHlp.UnDecorateSymbolName(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__GetTimestampForLoadedLibrary(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ImageHlp.GetTimestampForLoadedLibrary(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__RemovePrivateCvSymbolic(AMachine: TatVirtualMachine);
  var
  Param1: PChar;
  Param2: ULONG;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := PChar(VarToStr(GetInputArg(1)));
Param2 := VarToInteger(GetInputArg(2));
AResult := ImageHlp.RemovePrivateCvSymbolic(PChar(VarToStr(GetInputArg(0))),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,string(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatImageHlpLibrary.__RemoveRelocations(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ImageHlp.RemoveRelocations(PChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatImageHlpLibrary.__SymSetOptions(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ImageHlp.SymSetOptions(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SymGetOptions(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ImageHlp.SymGetOptions);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SymCleanup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.SymCleanup(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SymGetModuleInfo(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TImagehlpModule;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _IMAGEHLP_MODULEWrapper) then 
  Param2Rec := _IMAGEHLP_MODULEWrapper.Create(Param2);
Param2 := _IMAGEHLP_MODULEWrapper(Param2Rec).ObjToRec;
AResult := ImageHlp.SymGetModuleInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_IMAGEHLP_MODULEWrapper.Create(Param2)));
  end;
end;

procedure TatImageHlpLibrary.__SymGetModuleBase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ImageHlp.SymGetModuleBase(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SymInitialize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.SymInitialize(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SymGetSearchPath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.SymGetSearchPath(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SymSetSearchPath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.SymSetSearchPath(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SymLoadModule(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.SymLoadModule(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),PChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__SymUnloadModule(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.SymUnloadModule(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.__ImageRemoveCertificate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ImageHlp.ImageRemoveCertificate(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatImageHlpLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('MapFileAndCheckSum',3,tkInteger,nil,__MapFileAndCheckSum,false,0).SetVarArgs([1,2]);
    DefineMethod('MapFileAndCheckSumA',3,tkInteger,nil,__MapFileAndCheckSumA,false,0).SetVarArgs([1,2]);
    DefineMethod('MapFileAndCheckSumW',3,tkInteger,nil,__MapFileAndCheckSumW,false,0).SetVarArgs([1,2]);
    DefineMethod('TouchFileTimes',2,tkVariant,nil,__TouchFileTimes,false,0);
    DefineMethod('SplitSymbols',4,tkVariant,nil,__SplitSymbols,false,0);
    DefineMethod('FindDebugInfoFile',3,tkInteger,nil,__FindDebugInfoFile,false,0);
    DefineMethod('FindExecutableImage',3,tkInteger,nil,__FindExecutableImage,false,0);
    DefineMethod('BindImage',3,tkVariant,nil,__BindImage,false,0);
    DefineMethod('BindImageEx',5,tkVariant,nil,__BindImageEx,false,0).SetVarArgs([4]);
    DefineMethod('ReBaseImage',11,tkVariant,nil,__ReBaseImage,false,0).SetVarArgs([6,7,8,9]);
    DefineMethod('SearchTreeForFile',3,tkVariant,nil,__SearchTreeForFile,false,0);
    DefineMethod('MakeSureDirectoryPathExists',1,tkVariant,nil,__MakeSureDirectoryPathExists,false,0);
    DefineMethod('UnDecorateSymbolName',4,tkInteger,nil,__UnDecorateSymbolName,false,0);
    DefineMethod('GetTimestampForLoadedLibrary',1,tkInteger,nil,__GetTimestampForLoadedLibrary,false,0);
    DefineMethod('RemovePrivateCvSymbolic',3,tkVariant,nil,__RemovePrivateCvSymbolic,false,0).SetVarArgs([1,2]);
    DefineMethod('RemoveRelocations',1,tkNone,nil,__RemoveRelocations,false,0);
    DefineMethod('SymSetOptions',1,tkInteger,nil,__SymSetOptions,false,0);
    DefineMethod('SymGetOptions',0,tkInteger,nil,__SymGetOptions,false,0);
    DefineMethod('SymCleanup',1,tkVariant,nil,__SymCleanup,false,0);
    DefineMethod('SymGetModuleInfo',3,tkVariant,nil,__SymGetModuleInfo,false,0).SetVarArgs([2]);
    DefineMethod('SymGetModuleBase',2,tkInteger,nil,__SymGetModuleBase,false,0);
    DefineMethod('SymInitialize',3,tkVariant,nil,__SymInitialize,false,0);
    DefineMethod('SymGetSearchPath',3,tkVariant,nil,__SymGetSearchPath,false,0);
    DefineMethod('SymSetSearchPath',2,tkVariant,nil,__SymSetSearchPath,false,0);
    DefineMethod('SymLoadModule',6,tkVariant,nil,__SymLoadModule,false,0);
    DefineMethod('SymUnloadModule',2,tkVariant,nil,__SymUnloadModule,false,0);
    DefineMethod('ImageRemoveCertificate',2,tkVariant,nil,__ImageRemoveCertificate,false,0);
    AddConstant('BindOutOfMemory',BindOutOfMemory);
    AddConstant('BindRvaToVaFailed',BindRvaToVaFailed);
    AddConstant('BindNoRoomInImage',BindNoRoomInImage);
    AddConstant('BindImportModuleFailed',BindImportModuleFailed);
    AddConstant('BindImportProcedureFailed',BindImportProcedureFailed);
    AddConstant('BindImportModule',BindImportModule);
    AddConstant('BindImportProcedure',BindImportProcedure);
    AddConstant('BindForwarder',BindForwarder);
    AddConstant('BindForwarderNOT',BindForwarderNOT);
    AddConstant('BindImageModified',BindImageModified);
    AddConstant('BindExpandFileHeaders',BindExpandFileHeaders);
    AddConstant('BindImageComplete',BindImageComplete);
    AddConstant('BindMismatchedSymbols',BindMismatchedSymbols);
    AddConstant('BindSymbolsNotUpdated',BindSymbolsNotUpdated);
    AddConstant('AddrMode1616',AddrMode1616);
    AddConstant('AddrMode1632',AddrMode1632);
    AddConstant('AddrModeReal',AddrModeReal);
    AddConstant('AddrModeFlat',AddrModeFlat);
    AddConstant('SymNone',SymNone);
    AddConstant('SymCoff',SymCoff);
    AddConstant('SymCv',SymCv);
    AddConstant('SymPdb',SymPdb);
    AddConstant('SymExport',SymExport);
    AddConstant('SymDeferred',SymDeferred);
    AddConstant('SymSym',SymSym);
    AddConstant('CHECKSUM_SUCCESS',CHECKSUM_SUCCESS);
    AddConstant('CHECKSUM_OPEN_FAILURE',CHECKSUM_OPEN_FAILURE);
    AddConstant('CHECKSUM_MAP_FAILURE',CHECKSUM_MAP_FAILURE);
    AddConstant('CHECKSUM_MAPVIEW_FAILURE',CHECKSUM_MAPVIEW_FAILURE);
    AddConstant('CHECKSUM_UNICODE_FAILURE',CHECKSUM_UNICODE_FAILURE);
    AddConstant('SPLITSYM_REMOVE_PRIVATE',SPLITSYM_REMOVE_PRIVATE);
    AddConstant('SPLITSYM_EXTRACT_ALL',SPLITSYM_EXTRACT_ALL);
    AddConstant('BIND_NO_BOUND_IMPORTS',BIND_NO_BOUND_IMPORTS);
    AddConstant('BIND_NO_UPDATE',BIND_NO_UPDATE);
    AddConstant('BIND_ALL_IMAGES',BIND_ALL_IMAGES);
    AddConstant('IMAGE_SEPARATION',IMAGE_SEPARATION);
    AddConstant('UNDNAME_COMPLETE',UNDNAME_COMPLETE);
    AddConstant('UNDNAME_NO_LEADING_UNDERSCORES',UNDNAME_NO_LEADING_UNDERSCORES);
    AddConstant('UNDNAME_NO_MS_KEYWORDS',UNDNAME_NO_MS_KEYWORDS);
    AddConstant('UNDNAME_NO_FUNCTION_RETURNS',UNDNAME_NO_FUNCTION_RETURNS);
    AddConstant('UNDNAME_NO_ALLOCATION_MODEL',UNDNAME_NO_ALLOCATION_MODEL);
    AddConstant('UNDNAME_NO_ALLOCATION_LANGUAGE',UNDNAME_NO_ALLOCATION_LANGUAGE);
    AddConstant('UNDNAME_NO_MS_THISTYPE',UNDNAME_NO_MS_THISTYPE);
    AddConstant('UNDNAME_NO_CV_THISTYPE',UNDNAME_NO_CV_THISTYPE);
    AddConstant('UNDNAME_NO_THISTYPE',UNDNAME_NO_THISTYPE);
    AddConstant('UNDNAME_NO_ACCESS_SPECIFIERS',UNDNAME_NO_ACCESS_SPECIFIERS);
    AddConstant('UNDNAME_NO_THROW_SIGNATURES',UNDNAME_NO_THROW_SIGNATURES);
    AddConstant('UNDNAME_NO_MEMBER_TYPE',UNDNAME_NO_MEMBER_TYPE);
    AddConstant('UNDNAME_NO_RETURN_UDT_MODEL',UNDNAME_NO_RETURN_UDT_MODEL);
    AddConstant('UNDNAME_32_BIT_DECODE',UNDNAME_32_BIT_DECODE);
    AddConstant('UNDNAME_NAME_ONLY',UNDNAME_NAME_ONLY);
    AddConstant('UNDNAME_NO_ARGUMENTS',UNDNAME_NO_ARGUMENTS);
    AddConstant('UNDNAME_NO_SPECIAL_SYMS',UNDNAME_NO_SPECIAL_SYMS);
    AddConstant('API_VERSION_NUMBER',API_VERSION_NUMBER);
    AddConstant('SYMF_OMAP_GENERATED',SYMF_OMAP_GENERATED);
    AddConstant('SYMF_OMAP_MODIFIED',SYMF_OMAP_MODIFIED);
    AddConstant('CBA_DEFERRED_SYMBOL_LOAD_START',CBA_DEFERRED_SYMBOL_LOAD_START);
    AddConstant('CBA_DEFERRED_SYMBOL_LOAD_COMPLETE',CBA_DEFERRED_SYMBOL_LOAD_COMPLETE);
    AddConstant('CBA_DEFERRED_SYMBOL_LOAD_FAILURE',CBA_DEFERRED_SYMBOL_LOAD_FAILURE);
    AddConstant('CBA_SYMBOLS_UNLOADED',CBA_SYMBOLS_UNLOADED);
    AddConstant('CBA_DUPLICATE_SYMBOL',CBA_DUPLICATE_SYMBOL);
    AddConstant('SYMOPT_CASE_INSENSITIVE',SYMOPT_CASE_INSENSITIVE);
    AddConstant('SYMOPT_UNDNAME',SYMOPT_UNDNAME);
    AddConstant('SYMOPT_DEFERRED_LOADS',SYMOPT_DEFERRED_LOADS);
    AddConstant('SYMOPT_NO_CPP',SYMOPT_NO_CPP);
    AddConstant('CERT_PE_IMAGE_DIGEST_DEBUG_INFO',CERT_PE_IMAGE_DIGEST_DEBUG_INFO);
    AddConstant('CERT_PE_IMAGE_DIGEST_RESOURCES',CERT_PE_IMAGE_DIGEST_RESOURCES);
    AddConstant('CERT_PE_IMAGE_DIGEST_ALL_IMPORT_INFO',CERT_PE_IMAGE_DIGEST_ALL_IMPORT_INFO);
    AddConstant('CERT_SECTION_TYPE_ANY',CERT_SECTION_TYPE_ANY);
  end;
end;

class function TatImageHlpLibrary.LibraryName: string;
begin
  result := 'ImageHlp';
end;

initialization
  RegisterScripterLibrary(TatImageHlpLibrary, True);

{$WARNINGS ON}

end.

