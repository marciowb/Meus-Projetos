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


unit pFIBInterfaces;

interface

uses Classes;

type

  ISQLObject  = interface
   ['{DEA9627C-E35F-40A2-A2F6-3959782CE4AD}']
   function  ParamCount:integer;
   function  ParamName(ParamIndex:integer):string;
   function  FieldsCount:integer;
   function  FieldExist(const FieldName:string; var FieldIndex:integer):boolean;
   function  ParamExist(const ParamName:string; var ParamIndex:integer):boolean;
   function  FieldValue(const FieldName:string; Old:boolean):variant;   overload;
   function  FieldValue(const FieldIndex:integer;Old:boolean):variant; overload;
   function  ParamValue(const ParamName:string):variant;   overload;
   function  ParamValue(const ParamIndex:integer):variant; overload;
   procedure SetParamValue(const ParamIndex:integer; aValue:Variant);
   function  FieldName(FieldIndex:integer):string;
   function  IEof:boolean;
   procedure INext;
  end;


  type
  ISQLStatMaker = interface
  ['{39477B70-12C9-4F70-993E-0E1067A8D649}']
// For Statistics
   function    FixStartTime(const ObjName,VarName:string):Integer;
   function    FixEndTime(const ObjName,VarName:string):Integer;
   function    GetVarInt(const ObjName,VarName:string):Integer;
   function    GetVarStr(const ObjName,VarName:string):string;
   function    IncCounter(const ObjName,VarName:string):Integer;
   procedure   SetNull(const ObjName,VarName:string);
   procedure   SetStringValue(const ObjName,VarName,Value:string);
   function    AddIntValue(const ObjName,VarName:string;Value:integer):integer;
   procedure   SetIntValue(const ObjName,VarName:string;Value:integer);
//
   procedure   AddToStrings(const ObjName,VarName,Value:string);
   procedure   ClearStrings(const ObjName,VarName:string);
   function    GetVarStrings(const ObjName,VarName:string):TStrings;
   procedure   Clear;

   procedure   SetActiveStatistics(const Value:boolean);
   function    GetActiveStatistics:boolean;

   property  ActiveStatistics:boolean read GetActiveStatistics write SetActiveStatistics;
  end;

  TLogFlag = (lfQPrepare, lfQExecute, lfQFetch,
   lfConnect, lfTransact,lfService,lfMisc
  );
  TLogFlags = set of TLogFlag;

  ISQLLogger = interface
  ['{2CB9280F-2324-40CD-BFB4-42C0FD36107F}']
   procedure   SetActiveLogging(const Value:boolean);
   function    GetActiveLogging:boolean;
   function    GetLogFlags :TLogFlags;
   function    GetInstance:TObject;
   procedure   SetLogFlags(Value:TLogFlags);
   procedure   SetDatabase(aDatabase:TObject);
   procedure   WriteData(const ObjectName,OperationName,EventText: String;
    DataType: TLogFlag
   );
   property    ActiveLogging:boolean read GetActiveLogging write SetActiveLogging;
   property    LogFlags:TLogFlags read GetLogFlags write SetLogFlags;
  end;

implementation

end.
