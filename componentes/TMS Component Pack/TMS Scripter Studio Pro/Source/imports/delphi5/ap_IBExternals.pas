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
unit ap_IBExternals;

interface

uses
  Windows,
  IBUtils,
  IBExternals,
  atScript;

{$WARNINGS OFF}

type
  TatIBExternalsLibrary = class(TatScripterLibrary)
    procedure __InitializeTCTimeStructure(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TCTimeStructureWrapper = class(TatRecordWrapper)
  private
    Ftm_sec: integer;
    Ftm_min: integer;
    Ftm_hour: integer;
    Ftm_mday: integer;
    Ftm_mon: integer;
    Ftm_year: integer;
    Ftm_wday: integer;
    Ftm_yday: integer;
    Ftm_isdst: integer;
  public
    constructor Create(ARecord: TCTimeStructure);
    function ObjToRec: TCTimeStructure;
  published
    property tm_sec: integer read Ftm_sec write Ftm_sec;
    property tm_min: integer read Ftm_min write Ftm_min;
    property tm_hour: integer read Ftm_hour write Ftm_hour;
    property tm_mday: integer read Ftm_mday write Ftm_mday;
    property tm_mon: integer read Ftm_mon write Ftm_mon;
    property tm_year: integer read Ftm_year write Ftm_year;
    property tm_wday: integer read Ftm_wday write Ftm_wday;
    property tm_yday: integer read Ftm_yday write Ftm_yday;
    property tm_isdst: integer read Ftm_isdst write Ftm_isdst;
  end;
  
  TISC_VARYINGWrapper = class(TatRecordWrapper)
  private
    Fstrlen: Short;
  public
    constructor Create(ARecord: TISC_VARYING);
    function ObjToRec: TISC_VARYING;
  published
    property strlen: Short read Fstrlen write Fstrlen;
  end;
  
  TBlobWrapper = class(TatRecordWrapper)
  private
    FSegmentCount: Long;
    FMaxSegmentLength: Long;
    FTotalSize: Long;
  public
    constructor Create(ARecord: TBlob);
    function ObjToRec: TBlob;
  published
    property SegmentCount: Long read FSegmentCount write FSegmentCount;
    property MaxSegmentLength: Long read FMaxSegmentLength write FMaxSegmentLength;
    property TotalSize: Long read FTotalSize write FTotalSize;
  end;
  

implementation

constructor TCTimeStructureWrapper.Create(ARecord: TCTimeStructure);
begin
  inherited Create;
  Ftm_sec := ARecord.tm_sec;
  Ftm_min := ARecord.tm_min;
  Ftm_hour := ARecord.tm_hour;
  Ftm_mday := ARecord.tm_mday;
  Ftm_mon := ARecord.tm_mon;
  Ftm_year := ARecord.tm_year;
  Ftm_wday := ARecord.tm_wday;
  Ftm_yday := ARecord.tm_yday;
  Ftm_isdst := ARecord.tm_isdst;
end;

function TCTimeStructureWrapper.ObjToRec: TCTimeStructure;
begin
  result.tm_sec := Ftm_sec;
  result.tm_min := Ftm_min;
  result.tm_hour := Ftm_hour;
  result.tm_mday := Ftm_mday;
  result.tm_mon := Ftm_mon;
  result.tm_year := Ftm_year;
  result.tm_wday := Ftm_wday;
  result.tm_yday := Ftm_yday;
  result.tm_isdst := Ftm_isdst;
end;

constructor TISC_VARYINGWrapper.Create(ARecord: TISC_VARYING);
begin
  inherited Create;
  Fstrlen := ARecord.strlen;
end;

function TISC_VARYINGWrapper.ObjToRec: TISC_VARYING;
begin
  result.strlen := Fstrlen;
end;

constructor TBlobWrapper.Create(ARecord: TBlob);
begin
  inherited Create;
  FSegmentCount := ARecord.SegmentCount;
  FMaxSegmentLength := ARecord.MaxSegmentLength;
  FTotalSize := ARecord.TotalSize;
end;

function TBlobWrapper.ObjToRec: TBlob;
begin
  result.SegmentCount := FSegmentCount;
  result.MaxSegmentLength := FMaxSegmentLength;
  result.TotalSize := FTotalSize;
end;



procedure TatIBExternalsLibrary.__InitializeTCTimeStructure(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TCTimeStructure;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TCTimeStructureWrapper) then 
  Param0Rec := TCTimeStructureWrapper.Create(Param0);
Param0 := TCTimeStructureWrapper(Param0Rec).ObjToRec;
    IBExternals.InitializeTCTimeStructure(Param0);
    SetInputArg(0,integer(TCTimeStructureWrapper.Create(Param0)));
  end;
end;

procedure TatIBExternalsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('InitializeTCTimeStructure',1,tkNone,nil,__InitializeTCTimeStructure,false,0).SetVarArgs([0]);
    AddConstant('dSun',dSun);
    AddConstant('dMon',dMon);
    AddConstant('dTue',dTue);
    AddConstant('dWed',dWed);
    AddConstant('dThu',dThu);
    AddConstant('dFri',dFri);
    AddConstant('dSat',dSat);
    AddConstant('dJan',dJan);
    AddConstant('dFeb',dFeb);
    AddConstant('dMar',dMar);
    AddConstant('dApr',dApr);
    AddConstant('dMay',dMay);
    AddConstant('dJun',dJun);
    AddConstant('dJul',dJul);
    AddConstant('dAug',dAug);
    AddConstant('dSep',dSep);
    AddConstant('dOct',dOct);
    AddConstant('dNov',dNov);
    AddConstant('dDec',dDec);
    AddConstant('cYearOffset',cYearOffset);
    AddConstant('cSun',cSun);
    AddConstant('cMon',cMon);
    AddConstant('cTue',cTue);
    AddConstant('cWed',cWed);
    AddConstant('cThu',cThu);
    AddConstant('cFri',cFri);
    AddConstant('cSat',cSat);
    AddConstant('cJan',cJan);
    AddConstant('cFeb',cFeb);
    AddConstant('cMar',cMar);
    AddConstant('cApr',cApr);
    AddConstant('cMay',cMay);
    AddConstant('cJun',cJun);
    AddConstant('cJul',cJul);
    AddConstant('cAug',cAug);
    AddConstant('cSep',cSep);
    AddConstant('cOct',cOct);
    AddConstant('cNov',cNov);
    AddConstant('cDec',cDec);
  end;
end;

class function TatIBExternalsLibrary.LibraryName: string;
begin
  result := 'IBExternals';
end;

initialization
  RegisterScripterLibrary(TatIBExternalsLibrary, True);

{$WARNINGS ON}

end.

