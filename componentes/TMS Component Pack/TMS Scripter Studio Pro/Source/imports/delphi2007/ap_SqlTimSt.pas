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
unit ap_SqlTimSt;

interface

uses
  Variants,
  Windows,
  SqlTimSt,
  atScript;

{$WARNINGS OFF}

type
  TatSqlTimStLibrary = class(TatScripterLibrary)
    procedure __VarSQLTimeStampCreate(AMachine: TatVirtualMachine);
    procedure __VarSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __VarIsSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __LocalToUTC(AMachine: TatVirtualMachine);
    procedure __UTCToLocal(AMachine: TatVirtualMachine);
    procedure __VarToSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __SQLTimeStampToStr(AMachine: TatVirtualMachine);
    procedure __SQLDayOfWeek(AMachine: TatVirtualMachine);
    procedure __DateTimeToSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __SQLTimeStampToDateTime(AMachine: TatVirtualMachine);
    procedure __TryStrToSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __StrToSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __CheckSqlTimeStamp(AMachine: TatVirtualMachine);
    procedure __GetNullSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TSQLTimeStampWrapper = class(TatRecordWrapper)
  private
    FYear: SmallInt;
    FMonth: Word;
    FDay: Word;
    FHour: Word;
    FMinute: Word;
    FSecond: Word;
    FFractions: LongWord;
  public
    constructor Create(ARecord: TSQLTimeStamp);
    function ObjToRec: TSQLTimeStamp;
  published
    property Year: SmallInt read FYear write FYear;
    property Month: Word read FMonth write FMonth;
    property Day: Word read FDay write FDay;
    property Hour: Word read FHour write FHour;
    property Minute: Word read FMinute write FMinute;
    property Second: Word read FSecond write FSecond;
    property Fractions: LongWord read FFractions write FFractions;
  end;
  
  TTimeZoneWrapper = class(TatRecordWrapper)
  private
    FFUsesDayligtSavings: Boolean;
  public
    constructor Create(ARecord: TTimeZone);
    function ObjToRec: TTimeZone;
  published
    property FUsesDayligtSavings: Boolean read FFUsesDayligtSavings write FFUsesDayligtSavings;
  end;
  

implementation

constructor TSQLTimeStampWrapper.Create(ARecord: TSQLTimeStamp);
begin
  inherited Create;
  FYear := ARecord.Year;
  FMonth := ARecord.Month;
  FDay := ARecord.Day;
  FHour := ARecord.Hour;
  FMinute := ARecord.Minute;
  FSecond := ARecord.Second;
  FFractions := ARecord.Fractions;
end;

function TSQLTimeStampWrapper.ObjToRec: TSQLTimeStamp;
begin
  result.Year := FYear;
  result.Month := FMonth;
  result.Day := FDay;
  result.Hour := FHour;
  result.Minute := FMinute;
  result.Second := FSecond;
  result.Fractions := FFractions;
end;

constructor TTimeZoneWrapper.Create(ARecord: TTimeZone);
begin
  inherited Create;
  FFUsesDayligtSavings := ARecord.FUsesDayligtSavings;
end;

function TTimeZoneWrapper.ObjToRec: TTimeZone;
begin
  result.FUsesDayligtSavings := FFUsesDayligtSavings;
end;



procedure TatSqlTimStLibrary.__VarSQLTimeStampCreate(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    SqlTimSt.VarSQLTimeStampCreate(Param0,TSQLTimeStampWrapper(integer(GetInputArg(1))).ObjToRec);
    SetInputArg(0,Param0);
  end;
end;

procedure TatSqlTimStLibrary.__VarSQLTimeStamp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SqlTimSt.VarSQLTimeStamp);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlTimStLibrary.__VarIsSQLTimeStamp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SqlTimSt.VarIsSQLTimeStamp(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlTimStLibrary.__LocalToUTC(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TTimeZone;
  Param1Rec: TObject;
  Param1: TSQLTimeStamp;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TTimeZoneWrapper) then 
  Param0Rec := TTimeZoneWrapper.Create(Param0);
Param0 := TTimeZoneWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TSQLTimeStampWrapper) then 
  Param1Rec := TSQLTimeStampWrapper.Create(Param1);
Param1 := TSQLTimeStampWrapper(Param1Rec).ObjToRec;
AResult := integer(TSQLTimeStampWrapper.Create(SqlTimSt.LocalToUTC(Param0,Param1)));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TTimeZoneWrapper.Create(Param0)));
    SetInputArg(1,integer(TSQLTimeStampWrapper.Create(Param1)));
  end;
end;

procedure TatSqlTimStLibrary.__UTCToLocal(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TTimeZone;
  Param1Rec: TObject;
  Param1: TSQLTimeStamp;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TTimeZoneWrapper) then 
  Param0Rec := TTimeZoneWrapper.Create(Param0);
Param0 := TTimeZoneWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TSQLTimeStampWrapper) then 
  Param1Rec := TSQLTimeStampWrapper.Create(Param1);
Param1 := TSQLTimeStampWrapper(Param1Rec).ObjToRec;
AResult := integer(TSQLTimeStampWrapper.Create(SqlTimSt.UTCToLocal(Param0,Param1)));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TTimeZoneWrapper.Create(Param0)));
    SetInputArg(1,integer(TSQLTimeStampWrapper.Create(Param1)));
  end;
end;

procedure TatSqlTimStLibrary.__VarToSQLTimeStamp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TSQLTimeStampWrapper.Create(SqlTimSt.VarToSQLTimeStamp(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlTimStLibrary.__SQLTimeStampToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SqlTimSt.SQLTimeStampToStr(GetInputArg(0),TSQLTimeStampWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlTimStLibrary.__SQLDayOfWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SqlTimSt.SQLDayOfWeek(TSQLTimeStampWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlTimStLibrary.__DateTimeToSQLTimeStamp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TSQLTimeStampWrapper.Create(SqlTimSt.DateTimeToSQLTimeStamp(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlTimStLibrary.__SQLTimeStampToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SqlTimSt.SQLTimeStampToDateTime(TSQLTimeStampWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlTimStLibrary.__TryStrToSQLTimeStamp(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSQLTimeStamp;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TSQLTimeStampWrapper) then 
  Param1Rec := TSQLTimeStampWrapper.Create(Param1);
Param1 := TSQLTimeStampWrapper(Param1Rec).ObjToRec;
AResult := SqlTimSt.TryStrToSQLTimeStamp(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TSQLTimeStampWrapper.Create(Param1)));
  end;
end;

procedure TatSqlTimStLibrary.__StrToSQLTimeStamp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TSQLTimeStampWrapper.Create(SqlTimSt.StrToSQLTimeStamp(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSqlTimStLibrary.__CheckSqlTimeStamp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SqlTimSt.CheckSqlTimeStamp(TSQLTimeStampWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatSqlTimStLibrary.__GetNullSQLTimeStamp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TSQLTimeStampWrapper.Create(SqlTimSt.NullSQLTimeStamp)));
  end;
end;

procedure TatSqlTimStLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('VarSQLTimeStampCreate',2,tkNone,nil,__VarSQLTimeStampCreate,false,0).SetVarArgs([0]);
    DefineMethod('VarSQLTimeStamp',0,tkInteger,nil,__VarSQLTimeStamp,false,0);
    DefineMethod('VarIsSQLTimeStamp',1,tkVariant,nil,__VarIsSQLTimeStamp,false,0);
    DefineMethod('LocalToUTC',2,tkVariant,nil,__LocalToUTC,false,0).SetVarArgs([0,1]);
    DefineMethod('UTCToLocal',2,tkVariant,nil,__UTCToLocal,false,0).SetVarArgs([0,1]);
    DefineMethod('VarToSQLTimeStamp',1,tkVariant,nil,__VarToSQLTimeStamp,false,0);
    DefineMethod('SQLTimeStampToStr',2,tkVariant,nil,__SQLTimeStampToStr,false,0);
    DefineMethod('SQLDayOfWeek',1,tkInteger,nil,__SQLDayOfWeek,false,0);
    DefineMethod('DateTimeToSQLTimeStamp',1,tkVariant,nil,__DateTimeToSQLTimeStamp,false,0);
    DefineMethod('SQLTimeStampToDateTime',1,tkVariant,nil,__SQLTimeStampToDateTime,false,0);
    DefineMethod('TryStrToSQLTimeStamp',2,tkVariant,nil,__TryStrToSQLTimeStamp,false,0).SetVarArgs([1]);
    DefineMethod('StrToSQLTimeStamp',1,tkVariant,nil,__StrToSQLTimeStamp,false,0);
    DefineMethod('CheckSqlTimeStamp',1,tkNone,nil,__CheckSqlTimeStamp,false,0);
    DefineProp('NullSQLTimeStamp',tkVariant,__GetNullSQLTimeStamp,nil,nil,false,0);
  end;
end;

class function TatSqlTimStLibrary.LibraryName: string;
begin
  result := 'SqlTimSt';
end;

initialization
  RegisterScripterLibrary(TatSqlTimStLibrary, True);

{$WARNINGS ON}

end.

