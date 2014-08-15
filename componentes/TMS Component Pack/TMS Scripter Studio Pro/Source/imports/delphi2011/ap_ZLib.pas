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
unit ap_ZLib;

interface

uses
  Sysutils,
  Classes,
  ZLib,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatZLibLibrary = class(TatScripterLibrary)
    procedure __TZCompressionStreamCreate(AMachine: TatVirtualMachine);
    procedure __TZCompressionStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TZCompressionStreamRead(AMachine: TatVirtualMachine);
    procedure __TZCompressionStreamWrite(AMachine: TatVirtualMachine);
    procedure __TZCompressionStreamSeek(AMachine: TatVirtualMachine);
    procedure __GetTZCompressionStreamCompressionRate(AMachine: TatVirtualMachine);
    procedure __TZDecompressionStreamCreate(AMachine: TatVirtualMachine);
    procedure __TZDecompressionStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TZDecompressionStreamRead(AMachine: TatVirtualMachine);
    procedure __TZDecompressionStreamWrite(AMachine: TatVirtualMachine);
    procedure __TZDecompressionStreamSeek(AMachine: TatVirtualMachine);
    procedure __ZDecompressStr(AMachine: TatVirtualMachine);
    procedure __ZDecompressStream(AMachine: TatVirtualMachine);
    procedure __adler32(AMachine: TatVirtualMachine);
    procedure __MoveI32(AMachine: TatVirtualMachine);
    procedure __ZSendToBrowser(AMachine: TatVirtualMachine);
    procedure __deflateInit_(AMachine: TatVirtualMachine);
    procedure __DeflateInit2_(AMachine: TatVirtualMachine);
    procedure __deflate(AMachine: TatVirtualMachine);
    procedure __deflateEnd(AMachine: TatVirtualMachine);
    procedure __inflateInit_(AMachine: TatVirtualMachine);
    procedure __inflateInit2_(AMachine: TatVirtualMachine);
    procedure __inflate(AMachine: TatVirtualMachine);
    procedure __inflateEnd(AMachine: TatVirtualMachine);
    procedure __inflateReset(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomZStreamClass = class of TCustomZStream;
  TCustomZLibStreamClass = class of TCustomZLibStream;
  TZCompressionStreamClass = class of TZCompressionStream;
  TCompressionStreamClass = class of TCompressionStream;
  TZDecompressionStreamClass = class of TZDecompressionStream;
  TDecompressionStreamClass = class of TDecompressionStream;
  EZLibErrorClass = class of EZLibError;
  EZCompressionErrorClass = class of EZCompressionError;
  EZDecompressionErrorClass = class of EZDecompressionError;


  TZStreamRecWrapper = class(TatRecordWrapper)
  private
    Favail_in: Longint;
    Ftotal_in: Longint;
    Favail_out: Longint;
    Ftotal_out: Longint;
    Fdata_type: Integer;
    Fadler: Longint;
    Freserved: Longint;
  public
    constructor Create(ARecord: TZStreamRec);
    function ObjToRec: TZStreamRec;
  published
    property avail_in: Longint read Favail_in write Favail_in;
    property total_in: Longint read Ftotal_in write Ftotal_in;
    property avail_out: Longint read Favail_out write Favail_out;
    property total_out: Longint read Ftotal_out write Ftotal_out;
    property data_type: Integer read Fdata_type write Fdata_type;
    property adler: Longint read Fadler write Fadler;
    property reserved: Longint read Freserved write Freserved;
  end;
  

implementation

constructor TZStreamRecWrapper.Create(ARecord: TZStreamRec);
begin
  inherited Create;
  Favail_in := ARecord.avail_in;
  Ftotal_in := ARecord.total_in;
  Favail_out := ARecord.avail_out;
  Ftotal_out := ARecord.total_out;
  Fdata_type := ARecord.data_type;
  Fadler := ARecord.adler;
  Freserved := ARecord.reserved;
end;

function TZStreamRecWrapper.ObjToRec: TZStreamRec;
begin
  result.avail_in := Favail_in;
  result.total_in := Ftotal_in;
  result.avail_out := Favail_out;
  result.total_out := Ftotal_out;
  result.data_type := Fdata_type;
  result.adler := Fadler;
  result.reserved := Freserved;
end;



procedure TatZLibLibrary.__TZCompressionStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TZCompressionStreamClass(CurrentClass.ClassRef).Create(TStream(Integer(GetInputArg(0)))));
2: AResult := Integer(TZCompressionStreamClass(CurrentClass.ClassRef).Create(TStream(Integer(GetInputArg(0))),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__TZCompressionStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TZCompressionStream(CurrentObject).Destroy;
  end;
end;

procedure TatZLibLibrary.__TZCompressionStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TZCompressionStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatZLibLibrary.__TZCompressionStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TZCompressionStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__TZCompressionStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TZCompressionStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__GetTZCompressionStreamCompressionRate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TZCompressionStream(CurrentObject).CompressionRate);
  end;
end;

procedure TatZLibLibrary.__TZDecompressionStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TZDecompressionStreamClass(CurrentClass.ClassRef).Create(TStream(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__TZDecompressionStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TZDecompressionStream(CurrentObject).Destroy;
  end;
end;

procedure TatZLibLibrary.__TZDecompressionStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TZDecompressionStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatZLibLibrary.__TZDecompressionStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TZDecompressionStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__TZDecompressionStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TZDecompressionStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__ZDecompressStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ZLib.ZDecompressStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__ZDecompressStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ZLib.ZDecompressStream(TStream(Integer(GetInputArg(0))),TStream(Integer(GetInputArg(1))));
  end;
end;

procedure TatZLibLibrary.__adler32(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ZLib.adler32(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__MoveI32(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  Param1: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param1 := GetInputArg(1);
    ZLib.MoveI32(Param0,Param1,VarToInteger(GetInputArg(2)));
    SetInputArg(1,Param1);
  end;
end;

procedure TatZLibLibrary.__ZSendToBrowser(AMachine: TatVirtualMachine);
  var
  Param0: string;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    ZLib.ZSendToBrowser(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatZLibLibrary.__deflateInit_(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.deflateInit_(Param0,VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.__DeflateInit2_(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.DeflateInit2_(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),PChar(VarToStr(GetInputArg(6))),VarToInteger(GetInputArg(7))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.__deflate(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.deflate(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.__deflateEnd(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.deflateEnd(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.__inflateInit_(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.inflateInit_(Param0,PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.__inflateInit2_(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.inflateInit2_(Param0,VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.__inflate(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.inflate(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.__inflateEnd(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.inflateEnd(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.__inflateReset(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TZStreamRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TZStreamRecWrapper) then 
  Param0Rec := TZStreamRecWrapper.Create(Param0);
Param0 := TZStreamRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(ZLib.inflateReset(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TZStreamRecWrapper.Create(Param0)));
  end;
end;

procedure TatZLibLibrary.Init;
begin
  With Scripter.DefineClass(TCustomZStream) do
  begin
  end;
  With Scripter.DefineClass(TCustomZLibStream) do
  begin
  end;
  With Scripter.DefineClass(TZCompressionStream) do
  begin
    DefineMethod('Create',2,tkClass,TZCompressionStream,__TZCompressionStreamCreate,true,1);
    DefineMethod('Destroy',0,tkNone,nil,__TZCompressionStreamDestroy,false,0);
    DefineMethod('Read',2,tkInteger,nil,__TZCompressionStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('Write',2,tkInteger,nil,__TZCompressionStreamWrite,false,0);
    DefineMethod('Seek',2,tkInteger,nil,__TZCompressionStreamSeek,false,0);
    DefineProp('CompressionRate',tkVariant,__GetTZCompressionStreamCompressionRate,nil,nil,false,0);
    DefineProp('OnProgress',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCompressionStream) do
  begin
  end;
  With Scripter.DefineClass(TZDecompressionStream) do
  begin
    DefineMethod('Create',1,tkClass,TZDecompressionStream,__TZDecompressionStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TZDecompressionStreamDestroy,false,0);
    DefineMethod('Read',2,tkInteger,nil,__TZDecompressionStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('Write',2,tkInteger,nil,__TZDecompressionStreamWrite,false,0);
    DefineMethod('Seek',2,tkInteger,nil,__TZDecompressionStreamSeek,false,0);
    DefineProp('OnProgress',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDecompressionStream) do
  begin
  end;
  With Scripter.DefineClass(EZLibError) do
  begin
  end;
  With Scripter.DefineClass(EZCompressionError) do
  begin
  end;
  With Scripter.DefineClass(EZDecompressionError) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ZDecompressStr',1,tkVariant,nil,__ZDecompressStr,false,0);
    DefineMethod('ZDecompressStream',2,tkNone,nil,__ZDecompressStream,false,0);
    DefineMethod('adler32',3,tkInteger,nil,__adler32,false,0);
    DefineMethod('MoveI32',3,tkNone,nil,__MoveI32,false,0).SetVarArgs([1]);
    DefineMethod('ZSendToBrowser',1,tkNone,nil,__ZSendToBrowser,false,0).SetVarArgs([0]);
    DefineMethod('deflateInit_',4,tkInteger,nil,__deflateInit_,false,0).SetVarArgs([0]);
    DefineMethod('DeflateInit2_',8,tkInteger,nil,__DeflateInit2_,false,0).SetVarArgs([0]);
    DefineMethod('deflate',2,tkInteger,nil,__deflate,false,0).SetVarArgs([0]);
    DefineMethod('deflateEnd',1,tkInteger,nil,__deflateEnd,false,0).SetVarArgs([0]);
    DefineMethod('inflateInit_',3,tkInteger,nil,__inflateInit_,false,0).SetVarArgs([0]);
    DefineMethod('inflateInit2_',4,tkInteger,nil,__inflateInit2_,false,0).SetVarArgs([0]);
    DefineMethod('inflate',2,tkInteger,nil,__inflate,false,0).SetVarArgs([0]);
    DefineMethod('inflateEnd',1,tkInteger,nil,__inflateEnd,false,0).SetVarArgs([0]);
    DefineMethod('inflateReset',1,tkInteger,nil,__inflateReset,false,0).SetVarArgs([0]);
    AddConstant('zcNone',zcNone);
    AddConstant('zcFastest',zcFastest);
    AddConstant('zcDefault',zcDefault);
    AddConstant('zcMax',zcMax);
    AddConstant('clNone',clNone);
    AddConstant('clFastest',clFastest);
    AddConstant('clDefault',clDefault);
    AddConstant('clMax',clMax);
    AddConstant('ZLIB_VERSION',ZLIB_VERSION);
    AddConstant('Z_NO_FLUSH',Z_NO_FLUSH);
    AddConstant('Z_PARTIAL_FLUSH',Z_PARTIAL_FLUSH);
    AddConstant('Z_SYNC_FLUSH',Z_SYNC_FLUSH);
    AddConstant('Z_FULL_FLUSH',Z_FULL_FLUSH);
    AddConstant('Z_FINISH',Z_FINISH);
    AddConstant('Z_OK',Z_OK);
    AddConstant('Z_STREAM_END',Z_STREAM_END);
    AddConstant('Z_NEED_DICT',Z_NEED_DICT);
    AddConstant('Z_ERRNO',Z_ERRNO);
    AddConstant('Z_STREAM_ERROR',Z_STREAM_ERROR);
    AddConstant('Z_DATA_ERROR',Z_DATA_ERROR);
    AddConstant('Z_MEM_ERROR',Z_MEM_ERROR);
    AddConstant('Z_BUF_ERROR',Z_BUF_ERROR);
    AddConstant('Z_VERSION_ERROR',Z_VERSION_ERROR);
    AddConstant('Z_NO_COMPRESSION',Z_NO_COMPRESSION);
    AddConstant('Z_BEST_SPEED',Z_BEST_SPEED);
    AddConstant('Z_BEST_COMPRESSION',Z_BEST_COMPRESSION);
    AddConstant('Z_DEFAULT_COMPRESSION',Z_DEFAULT_COMPRESSION);
    AddConstant('Z_FILTERED',Z_FILTERED);
    AddConstant('Z_HUFFMAN_ONLY',Z_HUFFMAN_ONLY);
    AddConstant('Z_DEFAULT_STRATEGY',Z_DEFAULT_STRATEGY);
    AddConstant('Z_BINARY',Z_BINARY);
    AddConstant('Z_ASCII',Z_ASCII);
    AddConstant('Z_UNKNOWN',Z_UNKNOWN);
    AddConstant('Z_DEFLATED',Z_DEFLATED);
    AddConstant('SZInvalid',SZInvalid);
  end;
end;

class function TatZLibLibrary.LibraryName: string;
begin
  result := 'ZLib';
end;

initialization
  RegisterScripterLibrary(TatZLibLibrary, True);

{$WARNINGS ON}

end.

