{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ InterBase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2007 Devrace Ltd.                       }
{    Written by Serge Buzadzhy (buzz@devrace.com)               }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page: http://www.fibplus.com/                 }
{    FIBPlus support  : http://www.devrace.com/support/         }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}


unit pFIBFieldsDescr;

interface
{$I FIBPlus.inc}
uses
  Classes,IB_Externals;

type


  TAddedTypeFields=(atfStandard,atfGuidField,atfWideStringField);

  TFIBFieldDescr=record
    fdDataType        : Short;
    fdDataScale       : Short;
    fdNullable        : Boolean;
    fdDataSize        : Short;
    fdDataOfs         : Integer;
    fdIsDBKey         : boolean;
    fdIsSeparateString:boolean;
    fdStrIndex    : integer;
    fdAddedFields : TAddedTypeFields;
    fdSubType     : Short;    
  end;

  PFIBFieldDescr= ^TFIBFieldDescr;

  TFIBFieldDescrList=class
   private
    vFieldInfoList:TList;
    function GetFieldInfo(Index:integer):PFIBFieldDescr;
    function GetCapacity:integer;
    procedure SetCapacity(aCapacity: Integer);
   public
    constructor Create;
    destructor  Destroy; override;
    procedure   Assign(Source:TFIBFieldDescrList);
    procedure   Clear;
    function Add( afdDataType,afdDataScale,afdDataSize: Short;
     afdNullable,afdIsDBKey : Boolean;     IsSeparateString:boolean;
     aAddedType:TAddedTypeFields
    ):integer;
    procedure SaveToStream(Stream:TStream);
    procedure LoadFromStream(Stream:TStream; StreamVersion:byte);

    property FieldInfo[Index:integer]:PFIBFieldDescr read GetFieldInfo ;default;
    property Capacity:integer read GetCapacity write SetCapacity;
    property List:TList read vFieldInfoList;
   end;

implementation

{ TFIBFieldDescrList }

function TFIBFieldDescrList.Add(
 afdDataType, afdDataScale, afdDataSize: Short; afdNullable,afdIsDBKey : Boolean;
 IsSeparateString:boolean ;  aAddedType:TAddedTypeFields
):integer;
var p:PFIBFieldDescr;
begin
 New(p);
 with p^ do
 begin
    fdDataType :=afdDataType;
    fdDataScale:=afdDataScale;
    fdNullable :=afdNullable;
    fdDataSize :=afdDataSize;
    fdIsDBKey  :=afdIsDBKey ;
    fdIsSeparateString:=IsSeparateString;
    fdAddedFields:=aAddedType ;
 end;
 Result:=vFieldInfoList.Add(p)
end;

procedure TFIBFieldDescrList.Assign(Source:TFIBFieldDescrList);
var i:integer;
begin
 if Source=Self then exit;
 Clear;
 vFieldInfoList.Capacity:=Source.vFieldInfoList.Capacity;
 for i:=0 to Pred(Source.vFieldInfoList.Count) do
 with Source.FieldInfo[i]^ do
 begin
  Add( fdDataType,fdDataScale,fdDataSize,  fdNullable,fdIsDBKey,fdIsSeparateString,fdAddedFields );
  PFIBFieldDescr(vFieldInfoList[i])^.fdDataOfs :=fdDataOfs;
  PFIBFieldDescr(vFieldInfoList[i])^.fdStrIndex :=fdStrIndex
 end;
end;

procedure TFIBFieldDescrList.Clear;
var i:integer;
begin
 with vFieldInfoList do
  for i:=0 to Pred(Count) do
    FreeMem(vFieldInfoList[i],SizeOf(TFIBFieldDescr));
 vFieldInfoList.Clear;
end;

constructor TFIBFieldDescrList.Create;
begin
 inherited Create;
 vFieldInfoList:=TList.Create;
end;

destructor TFIBFieldDescrList.Destroy;
begin
  Clear;
  vFieldInfoList.Free;
  inherited;
end;

function TFIBFieldDescrList.GetCapacity: integer;
begin
 Result:=vFieldInfoList.Capacity
end;

function TFIBFieldDescrList.GetFieldInfo(Index: integer): PFIBFieldDescr;
begin
 Result:=PFIBFieldDescr(vFieldInfoList.List[Index])
end;

procedure TFIBFieldDescrList.LoadFromStream(Stream: TStream; StreamVersion:byte);
var i,c:integer;
    p:PFIBFieldDescr;
begin
 Clear;
 Stream.ReadBuffer(c,SizeOf(integer));
 Capacity := c;
 New(p);
 try
  for i:=0 to Pred(c) do
  begin
   if StreamVersion <6 then
    Stream.ReadBuffer(p^,SizeOf(TFIBFieldDescr)-SizeOf(boolean))
   else
    Stream.ReadBuffer(p^,SizeOf(TFIBFieldDescr));
   Add( p^.fdDataType, p^.fdDataScale, p^.fdDataSize, p^.fdNullable,p^.fdIsDBKey,p^.fdIsSeparateString,p^.fdAddedFields);
   FieldInfo[i]^.fdStrIndex:=p^.fdStrIndex;
   FieldInfo[i]^.fdDataOfs:=p^.fdDataOfs;
  end;
 finally
  FreeMem(p,SizeOf(TFIBFieldDescr))
 end;
end;

procedure TFIBFieldDescrList.SaveToStream(Stream: TStream);
var
   i:integer;
begin
 Stream.WriteBuffer(vFieldInfoList.Count,SizeOf(integer));
 for i:=0 to Pred(vFieldInfoList.Count) do
  Stream.WriteBuffer(PFIBFieldDescr(vFieldInfoList[i])^,SizeOf(TFIBFieldDescr));
end;

procedure TFIBFieldDescrList.SetCapacity(aCapacity: Integer);
begin
 vFieldInfoList.Capacity:=aCapacity
end;

end.
