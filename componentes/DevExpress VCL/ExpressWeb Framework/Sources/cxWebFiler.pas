{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Persistent Module                                       }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxWebFiler;

{$I cxVer.inc}

interface

uses
  Classes,
  cxWebIntf;

type
  TcxCompItems = class;

  TcxCompItem = class
  private
    FDeleting: Boolean;
    FItems: TcxCompItems;
    FName: string;
    FOwner: TcxCompItems;
    FValue: Integer;
    FSize: Integer;
    function GetIndex: Integer;
    function GetItem(Index: Integer): TcxCompItem;
  public
    constructor Create(AOwner: TcxCompItems);
    destructor Destroy; override;
    function Add(Name: string; Value: Integer): TcxCompItem;
    procedure Clear;
    function Count: Integer;
    function First: TcxCompItem;
    function GetItemByName(Name: string): TcxCompItem;
    function IndexOf(Name: string): integer;
    property Deleting: Boolean read FDeleting;
    property Index: Integer read GetIndex;
    property Items[Index: Integer]: TcxCompItem read GetItem;
    function Last: TcxCompItem;
    property Name: string read FName write FName;
    property Value: Integer read FValue write FValue;
    property Size: Integer read FSize write FSize;
  end;

  TcxCompItems = class
  private
    FItems: TList;
    function GetItem(Index: Integer): TcxCompItem;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(Name: string; Value: Integer): TcxCompItem;
    procedure Clear;
    function Count: Integer;
    procedure Delete(Index: Integer);
    function First: TcxCompItem;
    function GetItemByName(Name: string): TcxCompItem;
    function IndexOf(Item: TcxCompItem): Integer;
    function IndexOfName(Name: string): Integer;
    function Last: TcxCompItem;
    property Items[Index: Integer]: TcxCompItem read GetItem;
  end;

  TcxComparator = class(TObject)
  private
    FSamplePropPos: Integer;
    FCorrection: Integer;
    FInput: TReader;
    FSample: TReader;
    FPatch: TStream;
    FObjList: TcxCompItems;
    FCurrentObj: TcxCompItem;
    FRoot: TComponent;
    FRootPersistent: IcxWebModuleComponentPersistent;

    function IsObjectPersistent(const AObjID: string): Boolean;
    procedure WriteAddCommand(Offset: Integer; Count: Integer; Data: PChar);
    procedure WriteDiscardCommand(Offset: Integer; Count: Integer);
    procedure WriteReplaceCommand(Offset1, Offset2: Integer; Count: Integer; Data: PChar);
  protected
    procedure AddProperty(const Name: string);
    procedure AddObject(const HeaderSize: Integer);
    procedure CompareBinary(const BytesPerUnit: Integer);
    procedure CompareBytes(const Count: Integer);
    procedure CompareCollection;
    procedure CompareList;
    procedure CompareObject;
    procedure CompareSetBody;
    procedure CompareStrs;
    procedure CompareValue;
    procedure DiscardObject(Obj: TcxCompItem);
    procedure DiscardProperty(Prop: TcxCompItem);
    procedure PrepareObject;
    function ReadObjectHeader(AReader: TReader; var Header: string): Integer;
  public
    constructor Create(ARoot: TComponent);
    destructor Destroy; override;
    procedure ApplyStreamPatch(Patch, Sample, Output: TStream);
    procedure CreateStreamPatch(Input, Sample, Patch: TStream);
  end;

  TcxWebFilerClass = class of TcxWebFiler;
  TcxWebFiler = class
  private
    class function BinaryStreamToString(BinStream: TStream): string; virtual;
    class function LoadFromResource(ARoot: TComponent): TResourceStream; virtual;
    class procedure StringToBinaryStream(const Str: string; BinStream: TStream); virtual;
  public
    class function ComponentToString(const ARoot: TComponent): string; virtual;
    class procedure StringToComponent(const Source: string; ARoot: TComponent); virtual;
  end;

(*
  IcxWebStreamCoder = interface
  ['{20FD9453-66A3-447C-9552-81ABA11FB0BD}']
    procedure DecodeStream(InStream, OutStream: TStream);
    procedure EncodeStream(InStream, OutStream: TStream);
  end;

  IcxWebFiler = interface
  ['{25CB2124-7CD1-4744-B751-8520F728FDBF}']
    function ComponentToString(const AComponent: TComponent): string;
    procedure StringToComponent(const Source: string; AComponent: TComponent);
  end;

{ filer }
function cxActiveWebFiler: IcxWebFiler;
procedure cxRegisterWebFiler(const AFiler: IcxWebFiler);
procedure cxUnregisterWebFiler(const AFiler: IcxWebFiler);

{ coder }
function cxActiveWebStreamCoder: IcxWebStreamCoder;
procedure cxRegisterWebStreamCoder(const ACoder: IcxWebStreamCoder);
procedure cxUnregisterWebStreamCoder(const ACoder: IcxWebStreamCoder);
*)

implementation

uses SysUtils, RTLConsts,
  {$IFDEF VCL}
  Windows;
  {$ELSE}
   Types;
  {$ENDIF}

const
  BASE = 64;
  NULL_CHAR = '=';
  EncodeTable: array[0..BASE - 1] of Char =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
    'abcdefghijklmnopqrstuvwxyz' +
    '0123456789+/';

type
  PPacket = ^TPacket;
  TPacket = packed record
    case Integer of
      0: (b0, b1, b2, b3: Byte);
      1: (i: Integer);
      2: (a: array[0..3] of Byte);
  end;

  TcxCompOp = (coAdd, coDiscard, coReplace);
  TcxCompCmdHeader = packed record
    Op: TcxCompOp;
    Offset: Integer;
    Count: Word;
  end;

const
  MAX_COUNT = $FFFF; // Word

procedure EncodeStream(Input, Output: TStream);
type
  PInteger = ^Integer;
const
  CRLF = #$0D#$0A;
var
  InBuf: array[0..767] of Byte;
  OutBuf: array[0..1023] of Char;
  BufPtr: PChar;
  NumChars, BytesRead: Integer;
  I, Len: Integer;
  Packet: TPacket;

  procedure EncodePacket;
  var
    J: Integer;
  begin
    for J := 0 to 3 do
    begin
      if NumChars < J then
        BufPtr[J] := NULL_CHAR
      else
        BufPtr[J] := EncodeTable[Packet.i mod BASE];
      Packet.i := Packet.i div BASE;
    end;
  end;

begin
  repeat
    BytesRead := Input.Read(InBuf, SizeOf(InBuf));
    I := 0;
    BufPtr := OutBuf;
    while I < BytesRead do
    begin
      if BytesRead - I < 3 then
        NumChars := BytesRead - I
      else NumChars := 3;
      Packet.i := 0;
      Packet.b0 := InBuf[I];
      if NumChars > 1 then
        Packet.b1 := InBuf[I + 1];
      if NumChars > 2 then
        Packet.b2 := InBuf[I + 2];
      EncodePacket;
      Inc(I, 3);
      Inc(BufPtr, 4);
    end;
    Len := BufPtr - PChar(@OutBuf);
    Output.Write(Outbuf, Len);
    if Len = SizeOf(OutBuf) then
      Output.Write(CRLF, 2);
  until BytesRead = 0;
end;

procedure DecodeStream(Input, Output: TStream);
var
  DecodeTable: array[#0..#127] of Byte;
  InBuf: array[0..1023] of Char;
  OutBuf: array[0..767] of Byte;
  InBufPtr, OutBufPtr: PChar;
  I, J, nChars, BytesRead: Integer;
  Packet: TPacket;

  function DecodePacket: TPacket;
  var
    Weight: Integer;
  begin
    Result.i := 0;
    nChars := 0;
    Weight := 1;
    repeat
      Result.i := Result.i + DecodeTable[InBufPtr[nChars]] * Weight;
      Inc(nChars);
      Weight := Weight * BASE;
    until (nChars > 3) or (InBufPtr[nChars] = NULL_CHAR);
    Dec(nChars);
  end;

begin
  FillChar(DecodeTable, SizeOf(DecodeTable), BASE);
  for I := Low(EncodeTable) to High(EncodeTable) do
    DecodeTable[EncodeTable[I]] := I;
  repeat
    BytesRead := Input.Read(InBuf, SizeOf(InBuf));
    InBufPtr := InBuf;
    OutBufPtr := @OutBuf;
    I := 0;
    while I < BytesRead do
    begin
      Packet := DecodePacket;
      J := 0;
      while nChars > 0 do
      begin
        OutBufPtr^ := Char(Packet.a[J]);
        Inc(OutBufPtr);
        Dec(nChars);
        Inc(J);
      end;
      Inc(InBufPtr, 4);
      Inc(I, 4);
    end;
    Output.Write(OutBuf, OutBufPtr - PChar(@OutBuf));
    if BytesRead = SizeOf(InBuf) then
      Input.Read(InBuf, 2);
  until BytesRead = 0;
end;

{ TcxWebFiler }

class function TcxWebFiler.BinaryStreamToString(BinStream: TStream): string;
var
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create('');
  try
    EncodeStream(BinStream, StrStream);
    Result := StrStream.DataString;
  finally
    StrStream.Free;
  end;
end;

class function TcxWebFiler.LoadFromResource(ARoot: TComponent): TResourceStream;
var
  HInst: THandle;
  ResName: string;
begin
  HInst := FindResourceHInstance(FindClassHInstance(ARoot.ClassType));
  ResName := ARoot.ClassType.ClassName;
  if FindResource(HInst, PChar(ResName), RT_RCDATA) = 0 then
    raise EResNotFound.CreateFmt('%s', [ResName]);
  Result := TResourceStream.Create(HInst, ResName, RT_RCDATA);
end;

class procedure TcxWebFiler.StringToBinaryStream(const Str: string; BinStream: TStream);
var
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create('');
  try
    StrStream.WriteString(Str);
    StrStream.Position := 0;
    DecodeStream(StrStream, BinStream);
  finally
    StrStream.Free;
  end;
end;

class function TcxWebFiler.ComponentToString(const ARoot: TComponent): string;
var
  Resource: TResourceStream;
  Component, Patch: TMemoryStream;
begin
  Component := TMemoryStream.Create;
  try
    Resource:= LoadFromResource(ARoot);
    try
      Component.WriteComponent(ARoot);
      Component.Position := 0;
      Patch :=  TMemoryStream.Create;
      try
        with TcxComparator.Create(ARoot) do
        try
          CreateStreamPatch(Component, Resource, Patch);
        finally
          Free;
        end;
        Patch.Position := 0;
        Result := BinaryStreamToString(Patch);
      finally
        Patch.Free;
      end;
    finally
      Resource.Free;
    end;
  finally
    Component.Free;
  end;
end;

class procedure TcxWebFiler.StringToComponent(const Source: string; ARoot: TComponent);
var
  Resource: TResourceStream;
  Component, Patch: TMemoryStream;
  LocalizeLoading: Boolean;
begin
  GlobalNameSpace.BeginWrite;  // hold lock across all ancestor loads (performance)
  try
    LocalizeLoading := (ARoot.ComponentState * [csInline, csLoading]) = [];
    if LocalizeLoading then BeginGlobalLoading;  // push new loadlist onto stack
    try
      Resource := LoadFromResource(ARoot);
      try
        Component := TMemoryStream.Create;
        try
          Patch := TMemoryStream.Create;
          try
            StringToBinaryStream(Source, Patch);
            Patch.Position := 0;
            with TcxComparator.Create(ARoot) do
            try
              ApplyStreamPatch(Patch, Resource, Component);
            finally
              Free;
            end;
            Component.Position := 0;
          finally
            Patch.Free;
          end;
          Component.ReadComponent(ARoot);
        finally
          Component.Free;
        end;
      finally
        Resource.Free;
      end;
      if LocalizeLoading then NotifyGlobalLoading;  // call Loaded
    finally
      if LocalizeLoading then EndGlobalLoading;  // pop loadlist off stack
    end;
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

type
  TReaderWrapper = class(TReader);

constructor TcxComparator.Create(ARoot: TComponent);
begin
  FObjList := TcxCompItems.Create;
  FRoot := ARoot;
  Supports(FRoot, IcxWebModuleComponentPersistent, FRootPersistent);
end;

destructor TcxComparator.Destroy;
begin
  if FObjList <> nil then FObjList.Free;
end;

procedure TcxComparator.ApplyStreamPatch(Patch, Sample, Output: TStream);
var
  BytesRead, SamplePos: Integer;
  CmdHeader: TcxCompCmdHeader;
begin
  BytesRead := Patch.Read(CmdHeader, SizeOf(CmdHeader));
  while BytesRead > 0 do
  begin
    case CmdHeader.Op of
      coAdd:
      begin
        if CmdHeader.Offset > Output.Position then
          Output.CopyFrom(Sample, CmdHeader.Offset - Output.Position);
        Output.CopyFrom(Patch, CmdHeader.Count);
      end;
      coDiscard:
      begin
        if CmdHeader.Offset > Sample.Position then
          Output.CopyFrom(Sample, CmdHeader.Offset - Sample.Position);
        Sample.Seek(CmdHeader.Count, soFromCurrent);
      end;
      coReplace:
      begin
        if CmdHeader.Offset > Output.Position then
          Output.CopyFrom(Sample, CmdHeader.Offset - Output.Position);
        Patch.Read(SamplePos, SizeOf(SamplePos));
        if SamplePos > Sample.Position then
          Output.CopyFrom(Sample, SamplePos - Sample.Position);
        Output.CopyFrom(Patch, CmdHeader.Count);
        Sample.Seek(CmdHeader.Count, soFromCurrent);
      end;
    end;
    BytesRead := Patch.Read(CmdHeader, SizeOf(CmdHeader));
  end;
  if Sample.Position < Sample.Size then
    Output.CopyFrom(Sample, Sample.Size - Sample.Position);
end;

procedure TcxComparator.CreateStreamPatch(Input, Sample, Patch: TStream);
begin
  FPatch := Patch;
  FSample := TReader.Create(Sample, 4096);
  try
    FObjList.Clear;
    FSample.ReadSignature;
    PrepareObject;
    FInput := TReader.Create(Input, 4096);
    try
      FInput.ReadSignature;
      FCorrection := 0;
      CompareObject;
      while FObjList.Count > 0 do
        DiscardObject(FObjList.First);
    finally
      FInput.Free;
    end;
  finally
    FSample.Free;
  end;
end;

procedure TcxComparator.AddProperty(const Name: string);
var
  Count: Integer;
  StartPos: Integer;
  Buf: PChar;
begin
  StartPos := FInput.Position - Length(Name) - 1;
  FInput.SkipValue;
  Count := FInput.Position - StartPos;
  FInput.Position := StartPos;
  GetMem(Buf, Count);
  try
    FInput.Read(Buf^, Count);
    WriteAddCommand(StartPos, Count, Buf);
  finally
    if Buf <> nil then FreeMem(Buf);
  end;
end;

procedure TcxComparator.AddObject(const HeaderSize: Integer);
var
  Count: Integer;
  StartPos: Integer;
  Buf: PChar;
begin
  StartPos := FInput.Position - HeaderSize;
  TReaderWrapper(FInput).SkipComponent(False);
  Count := FInput.Position - StartPos;
  FInput.Position := StartPos;
  GetMem(Buf, Count);
  try
    FInput.Read(Buf^, Count);
    FInput.Position := FInput.Position - SizeOf(vaNull);
    WriteAddCommand(StartPos, Count, Buf);
  finally
    if Buf <> nil then FreeMem(Buf);
  end;
end;

procedure TcxComparator.CompareBinary(const BytesPerUnit: Integer);
var
  Len1, Len2: Longint;
  Buf: PChar;
begin
  FInput.Read(Len1, SizeOf(Len1));
  FSample.Position := FSamplePropPos;
  FSample.Read(Len2, SizeOf(Len2));
  if Len1 = Len2 then
  begin
    Inc(FSamplePropPos, SizeOf(Len2));
    CompareBytes(Len1 * BytesPerUnit);
  end
  else
  begin
    Len1 := Len1 * BytesPerUnit + SizeOf(Len1);
    Len2 := Len2 * BytesPerUnit + SizeOf(Len2);
    FInput.Position := FInput.Position - SizeOf(Len1);
    FSample.Position := FSample.Position - SizeOf(Len2);
    WriteDiscardCommand(FSample.Position, Len2);
    FSample.Position := FSample.Position + Len2;
    GetMem(Buf, Len1);
    try
      FInput.Read(Buf^, Len1);
      WriteAddCommand(FInput.Position - Len1, Len1, Buf);
    finally
      if Buf <> nil then FreeMem(Buf);
    end;
  end;
end;

procedure TcxComparator.CompareBytes(const Count: Integer);
var
  Buf1, Buf2: PChar;
begin
  GetMem(Buf1, Count);
  GetMem(Buf2, Count);
  try
    FInput.Read(Buf1^, Count);
    FSample.Position := FSamplePropPos;
    FSample.Read(Buf2^, Count);
    if not CompareMem(Buf1, Buf2, Count) then
      WriteReplaceCommand(FInput.Position - Count, FSample.Position - Count, Count, Buf1);
  finally
    if Buf1 <> nil then FreeMem(Buf1);
    if Buf2 <> nil then FreeMem(Buf2);
  end;
end;

procedure TcxComparator.CompareCollection;
var
  StartPos: Integer;
  Len1, Len2: Integer;
  Buf: PChar;
begin
  StartPos := FInput.Position;
  FInput.Position := FInput.Position - SizeOf(TValueType);
  FInput.SkipValue;
  Len1 := FInput.Position - StartPos;
  FInput.Position := StartPos;
  FSample.Position := FSamplePropPos - SizeOf(TValueType);
  FSample.SkipValue;
  Len2 := FSample.Position - FSamplePropPos;
  if Len1 = Len2 then
    CompareBytes(Len1)
  else
  begin
    WriteDiscardCommand(FSamplePropPos, Len2);
    FSample.Position := FSamplePropPos + Len2;
    GetMem(Buf, Len1);
    try
      FInput.Read(Buf^, Len1);
      WriteAddCommand(StartPos, Len1, Buf);
    finally
      if Buf <> nil then FreeMem(Buf);
    end;
  end;
end;

procedure TcxComparator.CompareList;
var
  StartPos, Count: Integer;
  Buf: PChar;
begin
  while not FInput.EndOfList do
  begin
    if FSample.NextValue <> vaNull then
    begin
      CompareValue;
      FSamplePropPos := FSample.Position;
    end
    else
    begin
      StartPos := FInput.Position;
      FInput.SkipValue;
      Count := FInput.Position - StartPos;
      GetMem(Buf, Count);
      try
        FInput.Position := StartPos;
        FInput.Read(Buf^, Count);
        WriteAddCommand(StartPos, Count, Buf);
      finally
        if Buf <> nil then FreeMem(Buf);
      end;
    end;
  end;
  FInput.ReadListEnd;
  StartPos := FSample.Position;
  while not FSample.EndOfList do
    FSample.SkipValue;
  if FSample.Position > StartPos then
    WriteDiscardCommand(StartPos, FSample.Position - StartPos);
  FSample.ReadListEnd;
end;

procedure TcxComparator.CompareObject;
var
  ObjID: string;
  HeaderSize, StartPos: Integer;
  Obj, Prop: TcxCompItem;
  PropName: string;
  SkipProperties: Boolean;
begin
  HeaderSize := ReadObjectHeader(FInput, ObjID);
  Obj := FObjList.GetItemByName(ObjID);
  FCurrentObj := Obj;
  if Obj <> nil then
  begin
    while Obj <> FObjList.First do
      DiscardObject(FObjList.First);
    SkipProperties := not IsObjectPersistent(ObjID);
    StartPos := FInput.Position - HeaderSize;
    while not FInput.EndOfList do
    begin
      if not SkipProperties then
      begin
        PropName := FInput.ReadStr;
        Prop := Obj.GetItemByName(PropName);
        if Prop <> nil then
        begin
          while Prop <> Obj.First do DiscardProperty(Obj.First);
          FSamplePropPos := Prop.Value;
          CompareValue;
          Prop.Free;
        end
        else
          AddProperty(PropName);
      end
      else
        TReaderWrapper(FInput).SkipProperty;
    end;
    FInput.ReadListEnd;
    if SkipProperties then
      FCorrection := FCorrection + Obj.Size - (FInput.Position - StartPos);
    while Obj.Count > 0 do DiscardProperty(Obj.First);
    Obj.Free;
  end
  else
    if IsObjectPersistent(ObjID) then
      AddObject(HeaderSize)
    else
    begin
      StartPos := FInput.Position - HeaderSize;
      TReaderWrapper(FInput).SkipComponent(False);
      FCorrection := FCorrection - (FInput.Position - StartPos);
      FInput.Position := FInput.Position - SizeOf(vaNull);
    end;
  while not FInput.EndOfList do
    CompareObject;
  FInput.ReadListEnd;
end;

procedure TcxComparator.PrepareObject;
var
  HeaderSize: Integer;
  ObjID: string;
  Obj: TcxCompItem;
  SkipProperies: Boolean;
begin
  HeaderSize := ReadObjectHeader(FSample, ObjID);
  Obj := FObjList.Add(ObjID, FSample.Position - HeaderSize);
  SkipProperies := not IsObjectPersistent(ObjID);
  while not FSample.EndOfList do
    if not SkipProperies then
    begin
      Obj.Add(FSample.ReadStr, FSample.Position);
      FSample.SkipValue;
    end
    else
      TReaderWrapper(FSample).SkipProperty;
  FSample.ReadListEnd;
  Obj.Size := FSample.Position - Obj.Value;
  while not FSample.EndOfList
    do PrepareObject;
  FSample.ReadListEnd;
end;

procedure TcxComparator.CompareSetBody;
var
  S: string;
  Index: Integer;
  List: TcxCompItems;
  Buf: PChar;
  Count: Integer;
begin
  FSample.Position := FSamplePropPos;
  List := TcxCompItems.Create;
  try
    repeat
      S := FSample.ReadStr;
      List.Add(S, FSamplePropPos);
      FSamplePropPos := FSample.Position;
    until S = '';
    repeat
      S := FInput.ReadStr;
      Index := List.IndexOfName(S);
      while Index > 0 do
      begin
        WriteDiscardCommand(List.First.Value, Length(List.First.Name) + 1);
        List.First.Free;
        Dec(Index);
      end;
      if Index = -1 then
      begin
        Count := Length(S) + 1;
        FInput.Position := FInput.Position - Count;
        GetMem(Buf, Count);
        try
          FInput.Read(Buf^, Count);
          WriteAddCommand(FInput.Position - Count, Count, Buf);
        finally
          if Buf <> nil then FreeMem(Buf);
        end;
      end
      else
        List.First.Free;
    until S = '';
    while List.Count > 0 do
    begin
      WriteDiscardCommand(List.First.Value, Length(List.First.Name) + 1);
      List.First.Free;
    end;
  finally
    List.Free;
  end;
end;

procedure TcxComparator.CompareStrs;
var
  Len1, Len2: Byte;
  StartPos: Integer;
  Buf: PChar;
begin
  FInput.Read(Len1, 1);
  FSample.Position := FSamplePropPos;
  FSample.Read(Len2, 1);
  Inc(FSamplePropPos);
  if Len1 = Len2 then
    CompareBytes(Len1)
  else
  begin
    WriteDiscardCommand(FSample.Position - 1, Len2 + 1);
    FSample.Position := FSample.Position + Len2;
    GetMem(Buf, Len1 + 1);
    try
      StartPos := FInput.Position - 1;
      FInput.Position := StartPos;
      FInput.Read(Buf^, Len1 + 1);
      WriteAddCommand(StartPos, Len1 + 1, Buf);
    finally
      if Buf <> nil then FreeMem(Buf);
    end;
  end;
end;

procedure TcxComparator.CompareValue;
var
  StartPos: Integer;
  Count: Integer;
  Buf: PChar;
begin
  if not (FInput.NextValue in [{vaNull, vaNil,} vaFalse, vaTrue]) then
  begin
    FSample.Position := FSamplePropPos;
    if FInput.NextValue <> FSample.NextValue then
    begin
      FSample.SkipValue;
      WriteDiscardCommand(FSamplePropPos, FSample.Position - FSamplePropPos);
      StartPos := FInput.Position;
      FInput.SkipValue;
      Count := FInput.Position - StartPos;
      GetMem(Buf, Count);
      try
        FInput.Position := StartPos;
        FInput.Read(Buf^, Count);
        WriteAddCommand(StartPos, Count, Buf);
      finally
        if Buf <> nil then FreeMem(Buf);
      end;
      exit;
    end
    else
      FSample.Position := FSample.Position + SizeOf(TValueType);
    FSamplePropPos := FSample.Position;
  end;
  case FInput.ReadValue of
    vaNull, vaNil, vaFalse, vaTrue:
    begin
      FInput.Position := FInput.Position - SizeOf(TValueType);
      CompareBytes(SizeOf(TValueType));
    end;
    vaList: CompareList;
    vaInt8: CompareBytes(SizeOf(Byte));
    vaInt16: CompareBytes(SizeOf(Word));
    vaInt32: CompareBytes(SizeOf(LongInt));
    vaExtended: CompareBytes(SizeOf(Extended));
    vaString, vaIdent: CompareStrs;
    vaBinary: CompareBinary(1);
    vaSet: CompareSetBody;
    vaLString: CompareBinary(1);
    vaCollection: CompareCollection;
    vaSingle: CompareBytes(Sizeof(Single));
    vaCurrency: CompareBytes(SizeOf(Currency));
    vaDate: CompareBytes(Sizeof(TDateTime));
    vaWString: CompareBinary(Sizeof(WideChar));
    vaInt64: CompareBytes(Sizeof(Int64));
    vaUTF8String: CompareBinary(1);
  end;
end;

procedure TcxComparator.DiscardObject(Obj: TcxCompItem);
var
  Count: Integer;
begin
  if IsObjectPersistent('') then
  begin
    FSample.Position := Obj.Value;
    TReaderWrapper(FSample).SkipComponent(True);
    Count := FSample.Position - Obj.Value;
    WriteDiscardCommand(Obj.Value, Count);
  end;  
  Obj.Free;
end;

procedure TcxComparator.DiscardProperty(Prop: TcxCompItem);
var
  Count, StartPos: Integer;
begin
  StartPos := Prop.Value - Length(Prop.Name) - 1;
  FSample.Position := Prop.Value;
  FSample.SkipValue;
  Count := FSample.Position - StartPos;
  WriteDiscardCommand(StartPos, Count);
  Prop.Free;
end;

function TcxComparator.ReadObjectHeader(AReader: TReader; var Header: string): Integer;
var
  ClassName, ObjectName: string;
  Flags: TFilerFlags;
  StartPos, Position: Integer;
begin
  Header := '';
  StartPos := AReader.Position;
  AReader.ReadPrefix(Flags, Position);
  ClassName := AReader.ReadStr;
  ObjectName := AReader.ReadStr;
  if ObjectName <> '' then
    Header := ObjectName + ':';
  Header := Header + ClassName;
  Result := AReader.Position - StartPos;
end;

function TcxComparator.IsObjectPersistent(const AObjID: string): Boolean;
var
  ObjName: string;
  P: Integer;
begin
  if (FRootPersistent = nil) then
  begin
    Result := False;
    Exit;
  end;
  ObjName := '';
  P := Pos(':', AObjID) - 1;
  if P > 0 then
  begin
    SetLength(ObjName, P);
    StrLCopy(PChar(ObjName), PChar(AObjID), P);
  end;
  if SameText(ObjName, FRoot.Name) then
    Result := FRootPersistent.IsComponentPersistent(FRoot)
  else
    Result := FRootPersistent.IsComponentPersistent(FRoot.FindComponent(ObjName));
end;

procedure TcxComparator.WriteAddCommand(Offset: Integer; Count: Integer; Data: PChar);
var
  CmdHeader: TcxCompCmdHeader;
  N, Off: Integer;
begin
  Off := 0;
  while Count > 0 do
  begin
    if Count > MAX_COUNT then
      N := MAX_COUNT
    else
      N := Count;
    CmdHeader.Op := coAdd;
    CmdHeader.Offset := Offset + FCorrection;
    CmdHeader.Count := N;
    FPatch.WriteBuffer(CmdHeader, SizeOf(CmdHeader));
    FPatch.WriteBuffer((Data + Off)^, N);
    Dec(Count, N);
    Inc(Offset, N);
    Inc(Off, N);
  end;
end;

procedure TcxComparator.WriteDiscardCommand(Offset: Integer; Count: Integer);
var
  CmdHeader: TcxCompCmdHeader;
  N: Integer;
begin
  while Count > 0 do
  begin
    if Count > MAX_COUNT then
      N := MAX_COUNT
    else
      N := Count;
    CmdHeader.Op := coDiscard;
    CmdHeader.Offset := Offset;
    CmdHeader.Count := N;
    FPatch.WriteBuffer(CmdHeader, SizeOf(CmdHeader));
    Dec(Count, N);
    Inc(Offset, N);
  end;
end;

procedure TcxComparator.WriteReplaceCommand(Offset1, Offset2: Integer; Count: Integer; Data: PChar);
var
  CmdHeader: TcxCompCmdHeader;
  N, Off: Integer;
begin
  Off := 0;
  while Count > 0 do
  begin
    if Count > MAX_COUNT then
      N := MAX_COUNT
    else
      N := Count;
    CmdHeader.Op := coReplace;
    CmdHeader.Offset := Offset1 + FCorrection;
    CmdHeader.Count := N;
    FPatch.WriteBuffer(CmdHeader, SizeOf(CmdHeader));
    FPatch.WriteBuffer(Offset2, SizeOf(Offset2));
    FPatch.WriteBuffer((Data + Off)^, N);
    Dec(Count, N);
    Inc(Offset1, N);
    Inc(Offset2, N);
    Inc(Off, N);
  end;
end;

{ TcxCompItems }

constructor TcxCompItems.Create;
begin
  FItems := nil;
end;

destructor TcxCompItems.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TcxCompItems.Add(Name: string; Value: Integer): TcxCompItem;
var
  Item: TcxCompItem;
begin
  if FItems = nil then
    FItems := TList.Create;
  Item := TcxCompItem.Create(Self);
  FItems.Add(Item);
  Item.Name := Name;
  Item.Value := Value;
  Result := Item;
end;

procedure TcxCompItems.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

function TcxCompItems.Count: Integer;
begin
  Result := 0;
  if FItems <> nil then
    Result := FItems.Count;
end;

procedure TcxCompItems.Delete(Index: Integer);
begin
  if FItems <> nil then
  begin
    if Items[Index].Deleting then
      FItems.Delete(Index)
    else
      Items[Index].Free;
    if Count = 0 then
    begin
      FItems.Free;
      FItems := nil;
    end;
  end
  else
    raise EListError.CreateResFmt(@SListIndexError, [Index]);
end;

function TcxCompItems.First: TcxCompItem;
begin
  Result := nil;
  if FItems <> nil then Result := TcxCompItem(FItems.First);
end;

function TcxCompItems.GetItemByName(Name: string): TcxCompItem;
var
  Index: Integer;
begin
  Result := nil;
  Index := IndexOfName(Name);
  if Index <> -1 then
    Result := Items[Index];
end;

function TcxCompItems.IndexOf(Item: TcxCompItem): Integer;
begin
  Result := -1;
  if FItems <> nil then
    Result := FItems.IndexOf(Item);
end;

function TcxCompItems.IndexOfName(Name: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  I := 0;
  while (I < Count) and (Result < 0) do
  begin
    if Items[I].Name = Name then
      Result := I;
    Inc(I);
  end;
end;

function TcxCompItems.Last: TcxCompItem;
begin
  Result := nil;
  if FItems <> nil then Result := TcxCompItem(FItems.Last);
end;

function TcxCompItems.GetItem(Index: Integer): TcxCompItem;
begin
  Result := nil;
  if FItems <> nil then
    Result := TcxCompItem(FItems.Items[Index]);
end;

{ TcxCompItem }

constructor TcxCompItem.Create(AOwner: TcxCompItems);
begin
  FOwner := AOwner;
  FItems := nil;
end;

destructor TcxCompItem.Destroy;
begin
  FDeleting := True;
  Clear;
  if FOwner <> nil then
    FOwner.Delete(Index);
  inherited Destroy;
end;

function TcxCompItem.Add(Name: string; Value: Integer): TcxCompItem;
begin
  if FItems = nil then
    FItems := TcxCompItems.Create;
  Result := FItems.Add(Name, Value);
end;

function TcxCompItem.First: TcxCompItem;
begin
  Result := nil;
  if FItems <> nil then Result := FItems.First;
end;

function TcxCompItem.GetItemByName(Name: string): TcxCompItem;
begin
  Result := nil;
  if FItems <> nil then
    Result := FItems.GetItemByName(Name);
end;

function TcxCompItem.IndexOf(Name: string): Integer;
begin
  Result := -1;
  if FItems <> nil then
    Result := FItems.IndexOfName(Name);
end;

function TcxCompItem.Count: Integer;
begin
  Result := 0;
  if FItems <> nil then
    Result := FItems.Count;
end;

function TcxCompItem.Last: TcxCompItem;
begin
  Result := nil;
  if FItems <> nil then Result := FItems.Last;
end;

function TcxCompItem.GetIndex: Integer;
begin
  Result := FOwner.IndexOf(Self);
end;

function TcxCompItem.GetItem(Index: Integer): TcxCompItem;
begin
  Result := nil;
  if FItems <> nil then
    Result := FItems.GetItem(Index);
end;

procedure TcxCompItem.Clear;
begin
  if FItems <> nil then
  begin
    FItems.Free;
    FItems := nil;
  end;
end;

end.
