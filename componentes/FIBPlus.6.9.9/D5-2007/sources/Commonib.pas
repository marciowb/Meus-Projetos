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

unit Commonib;

interface

{$I FIBPlus.inc}
uses
 {$IFDEF WINDOWS}
   Windows, Classes, SysUtils, FIBQuery,FIBDatabase,pFIBQuery;
 {$ENDIF}
 {$IFDEF LINUX}
   Types, Classes, SysUtils, FIBQuery,FIBDatabase,pFIBQuery,ibase;
 {$ENDIF}

const
  ibftSmallInt  = 7;
  ibftInteger   = 8;
  ibftQuad      = 9;
  ibftFloat     = 10;
  ibftD_Float   = 11;
  ibftDate      = 12;  // IB 6.0
  ibftTime      = 13;  // IB 6.0
  ibftChar      = 14;
  ibftInt64     = 16;  // IB 6.0
  ibftDouble    = 27;
  ibftDateTime  = 35;
  ibftTimeStamp = 35;
  ibftVarChar   = 37;
  ibftCString   = 40;
  ibftBlob      = 261;

{---- Please!!!! Dont write in Russian!!! Функция преобразования значения поля типа BLOB в строку ------}

function IBBlobToStr(BlobField : TFIBXSQLVAR) : string;
{---- Функция преобразования типа поля в строку ------}
{$IFDEF VER130}
function FieldTypeToStr(FieldType, FieldSubType, FieldLen, FieldScale, FieldSegmentLen, FieldCharacterLen : integer;
                        SQLDialect : integer = 1; FullInfo : boolean = FALSE) : string;
{$ENDIF}





procedure ExecSQL(aTransaction:TFIBTransaction; const SQLText:string;
 ParamValues:array of variant
);

function RecordCountInQuery(FQuery:TFIBQuery):integer;

implementation
 uses SQLTxtRtns;



function RecordCountInQuery(FQuery:TFIBQuery):integer;
var QueryCount:TFIBQuery;
    i:integer;
begin
 Result:=0;
 if (FQuery=nil) or (FQuery.Transaction=nil) or
  (not FQuery.Transaction.Active)
 then Exit;
 QueryCount:=TFIBQuery.Create(nil);
 with QueryCount do
 try
   QueryCount.ParamCheck:=true;
   Database   :=FQuery.Database;
   Transaction:=FQuery.Transaction;
   SQL.Text   :=CountSelect(FQuery.SQL.Text);
   if SQL.Text='' then Exit;
   for i:=0 to Pred(Params.Count) do
    Params[i].Value:=FQuery.Params.ByName[Params[i].Name].Value;
   ExecQuery;
   Result:=Fields[0].asInteger
 finally                                
  QueryCount.Free
 end
end;

function IBBlobToStr(BlobField : TFIBXSQLVAR) : string;
var
  Strm : TMemoryStream;
begin
  Result := '';
  if BlobField.IsNull then
    Exit;
  Strm := TMemoryStream.Create;
  try
    BlobField.SaveToStream(Strm);
    Strm.Position := 0;
    SetLength(Result,Strm.Size);
    Strm.Read(Result[1],Strm.Size);
  finally
    Strm.Free;
  end;
end;
{$IFDEF VER130}
function FieldTypeToStr(FieldType, FieldSubType, FieldLen, FieldScale, FieldSegmentLen, FieldCharacterLen : integer;
                        SQLDialect : integer = 1; FullInfo : boolean = FALSE) : string;

  function LengthInChars : string;
  begin
    if FieldLen < FieldCharacterLen then
      Result := IntToStr(FieldCharacterLen)
    else
      Result := IntToStr(FieldLen);
  end;

begin
  Result := '';
  case FieldType of
    ibftBlob     : begin
                     Result := 'BLOB';
                     if FullInfo then
                       Result := Result + ' sub_type '+ IntToStr(FieldSubType)+ ' segment size '+IntToStr(FieldSegmentLen);
                   end;
    ibftChar     : begin
                     Result := 'CHAR';
                     if FullInfo then
                       Result := Result + '('+ LengthInChars +')';
                   end;
    ibftVarChar  : begin
                     Result := 'VARCHAR';
                     if FullInfo then
                       Result := Result + '('+ LengthInChars +')';
                   end;
    ibftCString  : begin
                     Result := 'CSTRING';
                     if FullInfo then
                       Result := Result + '('+IntToStr(FieldLen)+')';
                   end;
    ibftDate     : Result := 'DATE';
    ibftTime     : Result := 'TIME';
    ibftDateTime : if SQLDialect = 3 then
                     Result := 'TIMESTAMP'
                   else
                     Result := 'DATE';
    ibftSmallInt : Result := 'SMALLINT';
    ibftInteger  : if FieldScale < 0 then
                   begin
                     Result := 'NUMERIC';
                     if FullInfo then
                       Result := Result + '(9,' + IntToStr(-1 * FieldScale) + ')';
                   end
                   else
                     Result := 'INTEGER';
    ibftInt64    : begin
                     Result := 'NUMERIC';
                     if FullInfo then
                       Result :=  Result + '(18,' + IntToStr(-1 * FieldScale) + ')';
                   end;
    ibftDouble   : if FieldScale < 0 then
                   begin
                     Result := 'NUMERIC';
                     if FullInfo then
                       Result := Result + '(15,' + IntToStr(-1 * FieldScale) + ')';
                   end
                   else
                     Result := 'DOUBLE PRECISION';
     ibftFloat    : Result := 'FLOAT';
  end;
end;

{$ENDIF}
var vQueryList:TList;

function FindQuery(aTransaction:TFIBTransaction; const SQLText:string):TFIBQuery;
var i:integer;
begin
 Result:=nil;
 for i:=0 to Pred(vQueryList.Count) do
  with TFIBQuery(vQueryList[i])do
   if SQL.Text=SQLText then
   begin
    if (Transaction=nil) then Transaction:=aTransaction;
    if (Transaction=aTransaction) then
    begin
     Result:=TFIBQuery(vQueryList[i]); Break;
    end
   end;
 // end for
 if Result=nil then
 begin
  Result:=TpFIBQuery.Create(nil);
  Result.ParamCheck:=True;
  Result.Transaction:=aTransaction;
  Result.SQL.Text:=SQLText;
  vQueryList.Add(Result);
 end;
end;

procedure ExecSQL(aTransaction:TFIBTransaction; const SQLText:string;
 ParamValues:array of variant
);
var i:integer;
begin
 with FindQuery(aTransaction,SQLText) do
 begin
   if not Prepared then Prepare;
   for i:=0 to Pred(Params.Count) do
    Params[i].asVariant:=ParamValues[i];
   ExecQuery;
 end;
end;

initialization
 vQueryList:=TList.Create;

finalization
 vQueryList.Free
end.

