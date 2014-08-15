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
unit ap_IBBlob;

interface

uses
  SysUtils,
  Classes,
  IBHeader,
  IBErrorCodes,
  IBExternals,
  DB,
  IB,
  IBDatabase,
  IBUtils,
  IBBlob,
  ap_IBHeader,
  atScript;

{$WARNINGS OFF}

type
  TatIBBlobLibrary = class(TatScripterLibrary)
    procedure __TIBBlobStreamCreate(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamCall(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamCancel(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamCheckReadable(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamCheckWritable(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamFinalize(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamRead(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamSaveToFile(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamSaveToStream(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamSeek(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamSetSize(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamTruncate(AMachine: TatVirtualMachine);
    procedure __TIBBlobStreamWrite(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamBlobID(AMachine: TatVirtualMachine);
    procedure __SetTIBBlobStreamBlobID(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamBlobMaxSegmentSize(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamBlobNumSegments(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamBlobSize(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamBlobType(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamDatabase(AMachine: TatVirtualMachine);
    procedure __SetTIBBlobStreamDatabase(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamMode(AMachine: TatVirtualMachine);
    procedure __SetTIBBlobStreamMode(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamModified(AMachine: TatVirtualMachine);
    procedure __GetTIBBlobStreamTransaction(AMachine: TatVirtualMachine);
    procedure __SetTIBBlobStreamTransaction(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBBlobStreamClass = class of TIBBlobStream;



implementation



procedure TatIBBlobLibrary.__TIBBlobStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBBlobStreamClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).Destroy;
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBBlobStream(CurrentObject).Call(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamCancel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).Cancel;
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamCheckReadable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).CheckReadable;
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamCheckWritable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).CheckWritable;
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamFinalize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).Finalize;
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TIBBlobStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBBlobStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamSetSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).SetSize(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamTruncate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).Truncate;
  end;
end;

procedure TatIBBlobLibrary.__TIBBlobStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TIBBlobStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamBlobID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGDS_QUADWrapper.Create(TIBBlobStream(CurrentObject).BlobID)));
  end;
end;

procedure TatIBBlobLibrary.__SetTIBBlobStreamBlobID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).BlobID:=TGDS_QUADWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamBlobMaxSegmentSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBlobStream(CurrentObject).BlobMaxSegmentSize));
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamBlobNumSegments(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBlobStream(CurrentObject).BlobNumSegments));
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamBlobSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBlobStream(CurrentObject).BlobSize));
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamBlobType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBlobStream(CurrentObject).BlobType));
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBlobStream(CurrentObject).Database));
  end;
end;

procedure TatIBBlobLibrary.__SetTIBBlobStreamDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).Database:=TIBDatabase(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBBlobStream(CurrentObject).Mode);
  end;
end;

procedure TatIBBlobLibrary.__SetTIBBlobStreamMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).Mode:=GetInputArg(0);
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBBlobStream(CurrentObject).Modified);
  end;
end;

procedure TatIBBlobLibrary.__GetTIBBlobStreamTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBlobStream(CurrentObject).Transaction));
  end;
end;

procedure TatIBBlobLibrary.__SetTIBBlobStreamTransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBlobStream(CurrentObject).Transaction:=TIBTransaction(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBBlobLibrary.Init;
begin
  With Scripter.DefineClass(TIBBlobStream) do
  begin
    DefineMethod('Create',0,tkClass,TIBBlobStream,__TIBBlobStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBBlobStreamDestroy,false,0);
    DefineMethod('Call',2,tkInteger,nil,__TIBBlobStreamCall,false,0);
    DefineMethod('Cancel',0,tkNone,nil,__TIBBlobStreamCancel,false,0);
    DefineMethod('CheckReadable',0,tkNone,nil,__TIBBlobStreamCheckReadable,false,0);
    DefineMethod('CheckWritable',0,tkNone,nil,__TIBBlobStreamCheckWritable,false,0);
    DefineMethod('Finalize',0,tkNone,nil,__TIBBlobStreamFinalize,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TIBBlobStreamLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TIBBlobStreamLoadFromStream,false,0);
    DefineMethod('Read',2,tkInteger,nil,__TIBBlobStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('SaveToFile',1,tkNone,nil,__TIBBlobStreamSaveToFile,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TIBBlobStreamSaveToStream,false,0);
    DefineMethod('Seek',2,tkInteger,nil,__TIBBlobStreamSeek,false,0);
    DefineMethod('SetSize',1,tkNone,nil,__TIBBlobStreamSetSize,false,0);
    DefineMethod('Truncate',0,tkNone,nil,__TIBBlobStreamTruncate,false,0);
    DefineMethod('Write',2,tkInteger,nil,__TIBBlobStreamWrite,false,0);
    DefineProp('BlobID',tkVariant,__GetTIBBlobStreamBlobID,__SetTIBBlobStreamBlobID,nil,false,0);
    DefineProp('BlobMaxSegmentSize',tkInteger,__GetTIBBlobStreamBlobMaxSegmentSize,nil,nil,false,0);
    DefineProp('BlobNumSegments',tkInteger,__GetTIBBlobStreamBlobNumSegments,nil,nil,false,0);
    DefineProp('BlobSize',tkInteger,__GetTIBBlobStreamBlobSize,nil,nil,false,0);
    DefineProp('BlobType',tkInteger,__GetTIBBlobStreamBlobType,nil,nil,false,0);
    DefineProp('Database',tkClass,__GetTIBBlobStreamDatabase,__SetTIBBlobStreamDatabase,TIBDatabase,false,0);
    DefineProp('Mode',tkEnumeration,__GetTIBBlobStreamMode,__SetTIBBlobStreamMode,nil,false,0);
    DefineProp('Modified',tkVariant,__GetTIBBlobStreamModified,nil,nil,false,0);
    DefineProp('Transaction',tkClass,__GetTIBBlobStreamTransaction,__SetTIBBlobStreamTransaction,TIBTransaction,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('DefaultBlobSegmentSize',DefaultBlobSegmentSize);
  end;
end;

class function TatIBBlobLibrary.LibraryName: string;
begin
  result := 'IBBlob';
end;

initialization
  RegisterScripterLibrary(TatIBBlobLibrary, True);

{$WARNINGS ON}

end.

