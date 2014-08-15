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
unit ap_IBXMLHeader;

interface

uses
  IBExternals,
  IBHeader,
  IBSQL,
  IBXMLHeader,
  atScript;

{$WARNINGS OFF}

type
  TatIBXMLHeaderLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TVaryWrapper = class(TatRecordWrapper)
  private
    Fvary_length: Short;
    Fvary_string: Char;
  public
    constructor Create(ARecord: TVary);
    function ObjToRec: TVary;
  published
    property vary_length: Short read Fvary_length write Fvary_length;
    property vary_string: Char read Fvary_string write Fvary_string;
  end;
  
  Tib_xmldaWrapper = class(TatRecordWrapper)
  private
    Fxmlda_fetch_stata: ISC_STATUS;
    Fxmlda_flags: ULong;
    Fxmlda_more_data: ULong;
    Fxmlda_temp_size: ULong;
    Fxmlda_status: Short;
    Fxmlda_more: Short;
    Fxmlda_version: UShort;
    Fxmlda_array_size: UShort;
    Fxmlda_reserved: ULong;
  public
    constructor Create(ARecord: Tib_xmlda);
    function ObjToRec: Tib_xmlda;
  published
    property xmlda_fetch_stata: ISC_STATUS read Fxmlda_fetch_stata write Fxmlda_fetch_stata;
    property xmlda_flags: ULong read Fxmlda_flags write Fxmlda_flags;
    property xmlda_more_data: ULong read Fxmlda_more_data write Fxmlda_more_data;
    property xmlda_temp_size: ULong read Fxmlda_temp_size write Fxmlda_temp_size;
    property xmlda_status: Short read Fxmlda_status write Fxmlda_status;
    property xmlda_more: Short read Fxmlda_more write Fxmlda_more;
    property xmlda_version: UShort read Fxmlda_version write Fxmlda_version;
    property xmlda_array_size: UShort read Fxmlda_array_size write Fxmlda_array_size;
    property xmlda_reserved: ULong read Fxmlda_reserved write Fxmlda_reserved;
  end;
  

implementation

constructor TVaryWrapper.Create(ARecord: TVary);
begin
  inherited Create;
  Fvary_length := ARecord.vary_length;
  Fvary_string := ARecord.vary_string;
end;

function TVaryWrapper.ObjToRec: TVary;
begin
  result.vary_length := Fvary_length;
  result.vary_string := Fvary_string;
end;

constructor Tib_xmldaWrapper.Create(ARecord: Tib_xmlda);
begin
  inherited Create;
  Fxmlda_fetch_stata := ARecord.xmlda_fetch_stata;
  Fxmlda_flags := ARecord.xmlda_flags;
  Fxmlda_more_data := ARecord.xmlda_more_data;
  Fxmlda_temp_size := ARecord.xmlda_temp_size;
  Fxmlda_status := ARecord.xmlda_status;
  Fxmlda_more := ARecord.xmlda_more;
  Fxmlda_version := ARecord.xmlda_version;
  Fxmlda_array_size := ARecord.xmlda_array_size;
  Fxmlda_reserved := ARecord.xmlda_reserved;
end;

function Tib_xmldaWrapper.ObjToRec: Tib_xmlda;
begin
  result.xmlda_fetch_stata := Fxmlda_fetch_stata;
  result.xmlda_flags := Fxmlda_flags;
  result.xmlda_more_data := Fxmlda_more_data;
  result.xmlda_temp_size := Fxmlda_temp_size;
  result.xmlda_status := Fxmlda_status;
  result.xmlda_more := Fxmlda_more;
  result.xmlda_version := Fxmlda_version;
  result.xmlda_array_size := Fxmlda_array_size;
  result.xmlda_reserved := Fxmlda_reserved;
end;



procedure TatIBXMLHeaderLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('XMLDA_ATTRIBUTE_FLAG',XMLDA_ATTRIBUTE_FLAG);
    AddConstant('XMLDA_DISPLAY_NULL_FLAG',XMLDA_DISPLAY_NULL_FLAG);
    AddConstant('XMLDA_NO_HEADER_FLAG',XMLDA_NO_HEADER_FLAG);
    AddConstant('MAXCHARSET_LENGTH',MAXCHARSET_LENGTH);
    AddConstant('SHORT_LEN',SHORT_LEN);
    AddConstant('LONG_LEN',LONG_LEN);
    AddConstant('INT64_LEN',INT64_LEN);
    AddConstant('QUAD_LEN',QUAD_LEN);
    AddConstant('FLOAT_LEN',FLOAT_LEN);
    AddConstant('DOUBLE_LEN',DOUBLE_LEN);
    AddConstant('DATE_LEN',DATE_LEN);
    AddConstant('DATETIME_LEN',DATETIME_LEN);
    AddConstant('TIME_ONLY_LEN',TIME_ONLY_LEN);
    AddConstant('DATE_ONLY_LEN',DATE_ONLY_LEN);
    AddConstant('UNKNOWN_LEN',UNKNOWN_LEN);
    AddConstant('ERR_NOT_ENOUGH_MEMORY',ERR_NOT_ENOUGH_MEMORY);
    AddConstant('ERR_BUFFERSIZE_NOT_ENOUGH',ERR_BUFFERSIZE_NOT_ENOUGH);
  end;
end;

class function TatIBXMLHeaderLibrary.LibraryName: string;
begin
  result := 'IBXMLHeader';
end;

initialization
  RegisterScripterLibrary(TatIBXMLHeaderLibrary, True);

{$WARNINGS ON}

end.

