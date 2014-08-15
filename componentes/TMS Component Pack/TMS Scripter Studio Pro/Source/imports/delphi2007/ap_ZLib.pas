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
  SysUtils,
  Classes,
  ZLib,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatZLibLibrary = class(TatScripterLibrary)
    procedure __TCompressionStreamCreate(AMachine: TatVirtualMachine);
    procedure __TCompressionStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TCompressionStreamRead(AMachine: TatVirtualMachine);
    procedure __TCompressionStreamWrite(AMachine: TatVirtualMachine);
    procedure __TCompressionStreamSeek(AMachine: TatVirtualMachine);
    procedure __GetTCompressionStreamCompressionRate(AMachine: TatVirtualMachine);
    procedure __TDecompressionStreamCreate(AMachine: TatVirtualMachine);
    procedure __TDecompressionStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TDecompressionStreamRead(AMachine: TatVirtualMachine);
    procedure __TDecompressionStreamWrite(AMachine: TatVirtualMachine);
    procedure __TDecompressionStreamSeek(AMachine: TatVirtualMachine);
    procedure __deflateInit_(AMachine: TatVirtualMachine);
    procedure __deflate(AMachine: TatVirtualMachine);
    procedure __deflateEnd(AMachine: TatVirtualMachine);
    procedure __inflateInit_(AMachine: TatVirtualMachine);
    procedure __inflate(AMachine: TatVirtualMachine);
    procedure __inflateEnd(AMachine: TatVirtualMachine);
    procedure __inflateReset(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomZlibStreamClass = class of TCustomZlibStream;
  TCompressionStreamClass = class of TCompressionStream;
  TDecompressionStreamClass = class of TDecompressionStream;
  EZlibErrorClass = class of EZlibError;
  ECompressionErrorClass = class of ECompressionError;
  EDecompressionErrorClass = class of EDecompressionError;


  TZStreamRecWrapper = class(TatRecordWrapper)
  private
    Favail_in: Integer;
    Ftotal_in: Integer;
    Favail_out: Integer;
    Ftotal_out: Integer;
    Fdata_type: Integer;
    Fadler: Integer;
    Freserved: Integer;
  public
    constructor Create(ARecord: TZStreamRec);
    function ObjToRec: TZStreamRec;
  published
    property avail_in: Integer read Favail_in write Favail_in;
    property total_in: Integer read Ftotal_in write Ftotal_in;
    property avail_out: Integer read Favail_out write Favail_out;
    property total_out: Integer read Ftotal_out write Ftotal_out;
    property data_type: Integer read Fdata_type write Fdata_type;
    property adler: Integer read Fadler write Fadler;
    property reserved: Integer read Freserved write Freserved;
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



procedure TatZLibLibrary.__TCompressionStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCompressionStreamClass(CurrentClass.ClassRef).Create(GetInputArg(0),TStream(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__TCompressionStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCompressionStream(CurrentObject).Destroy;
  end;
end;

procedure TatZLibLibrary.__TCompressionStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TCompressionStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatZLibLibrary.__TCompressionStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TCompressionStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__TCompressionStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCompressionStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__GetTCompressionStreamCompressionRate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCompressionStream(CurrentObject).CompressionRate);
  end;
end;

procedure TatZLibLibrary.__TDecompressionStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDecompressionStreamClass(CurrentClass.ClassRef).Create(TStream(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__TDecompressionStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDecompressionStream(CurrentObject).Destroy;
  end;
end;

procedure TatZLibLibrary.__TDecompressionStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TDecompressionStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatZLibLibrary.__TDecompressionStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TDecompressionStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatZLibLibrary.__TDecompressionStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDecompressionStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
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
  With Scripter.DefineClass(TCustomZlibStream) do
  begin
  end;
  With Scripter.DefineClass(TCompressionStream) do
  begin
    DefineMethod('Create',2,tkClass,TCompressionStream,__TCompressionStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCompressionStreamDestroy,false,0);
    DefineMethod('Read',2,tkInteger,nil,__TCompressionStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('Write',2,tkInteger,nil,__TCompressionStreamWrite,false,0);
    DefineMethod('Seek',2,tkInteger,nil,__TCompressionStreamSeek,false,0);
    DefineProp('CompressionRate',tkVariant,__GetTCompressionStreamCompressionRate,nil,nil,false,0);
    DefineProp('OnProgress',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDecompressionStream) do
  begin
    DefineMethod('Create',1,tkClass,TDecompressionStream,__TDecompressionStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDecompressionStreamDestroy,false,0);
    DefineMethod('Read',2,tkInteger,nil,__TDecompressionStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('Write',2,tkInteger,nil,__TDecompressionStreamWrite,false,0);
    DefineMethod('Seek',2,tkInteger,nil,__TDecompressionStreamSeek,false,0);
    DefineProp('OnProgress',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(EZlibError) do
  begin
  end;
  With Scripter.DefineClass(ECompressionError) do
  begin
  end;
  With Scripter.DefineClass(EDecompressionError) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('deflateInit_',4,tkInteger,nil,__deflateInit_,false,0).SetVarArgs([0]);
    DefineMethod('deflate',2,tkInteger,nil,__deflate,false,0).SetVarArgs([0]);
    DefineMethod('deflateEnd',1,tkInteger,nil,__deflateEnd,false,0).SetVarArgs([0]);
    DefineMethod('inflateInit_',3,tkInteger,nil,__inflateInit_,false,0).SetVarArgs([0]);
    DefineMethod('inflate',2,tkInteger,nil,__inflate,false,0).SetVarArgs([0]);
    DefineMethod('inflateEnd',1,tkInteger,nil,__inflateEnd,false,0).SetVarArgs([0]);
    DefineMethod('inflateReset',1,tkInteger,nil,__inflateReset,false,0).SetVarArgs([0]);
    AddConstant('clNone',clNone);
    AddConstant('clFastest',clFastest);
    AddConstant('clDefault',clDefault);
    AddConstant('clMax',clMax);
    AddConstant('zlib_Version',zlib_Version);
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

