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
unit ap_MultiMon;

interface

uses
  Windows,
  MultiMon,
  atScript;

{$WARNINGS OFF}

type
  TatMultiMonLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagMONITORINFOAWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagMONITORINFOA);
    function ObjToRec: tagMONITORINFOA;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagMONITORINFOWWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagMONITORINFOW);
    function ObjToRec: tagMONITORINFOW;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagMONITORINFOEXAWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagMONITORINFOEXA);
    function ObjToRec: tagMONITORINFOEXA;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagMONITORINFOEXWWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagMONITORINFOEXW);
    function ObjToRec: tagMONITORINFOEXW;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  

implementation

constructor tagMONITORINFOAWrapper.Create(ARecord: tagMONITORINFOA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function tagMONITORINFOAWrapper.ObjToRec: tagMONITORINFOA;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;

constructor tagMONITORINFOWWrapper.Create(ARecord: tagMONITORINFOW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function tagMONITORINFOWWrapper.ObjToRec: tagMONITORINFOW;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;

constructor tagMONITORINFOEXAWrapper.Create(ARecord: tagMONITORINFOEXA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function tagMONITORINFOEXAWrapper.ObjToRec: tagMONITORINFOEXA;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;

constructor tagMONITORINFOEXWWrapper.Create(ARecord: tagMONITORINFOEXW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function tagMONITORINFOEXWWrapper.ObjToRec: tagMONITORINFOEXW;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;



procedure TatMultiMonLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SM_XVIRTUALSCREEN',SM_XVIRTUALSCREEN);
    AddConstant('SM_YVIRTUALSCREEN',SM_YVIRTUALSCREEN);
    AddConstant('SM_CXVIRTUALSCREEN',SM_CXVIRTUALSCREEN);
    AddConstant('SM_CYVIRTUALSCREEN',SM_CYVIRTUALSCREEN);
    AddConstant('SM_CMONITORS',SM_CMONITORS);
    AddConstant('SM_SAMEDISPLAYFORMAT',SM_SAMEDISPLAYFORMAT);
    AddConstant('SM_CMETRICS',SM_CMETRICS);
    AddConstant('MONITOR_DEFAULTTONULL',MONITOR_DEFAULTTONULL);
    AddConstant('MONITOR_DEFAULTTOPRIMARY',MONITOR_DEFAULTTOPRIMARY);
    AddConstant('MONITOR_DEFAULTTONEAREST',MONITOR_DEFAULTTONEAREST);
    AddConstant('MONITORINFOF_PRIMARY',MONITORINFOF_PRIMARY);
    AddConstant('CCHDEVICENAME',CCHDEVICENAME);
  end;
end;

class function TatMultiMonLibrary.LibraryName: string;
begin
  result := 'MultiMon';
end;

initialization
  RegisterScripterLibrary(TatMultiMonLibrary, True);

{$WARNINGS ON}

end.

