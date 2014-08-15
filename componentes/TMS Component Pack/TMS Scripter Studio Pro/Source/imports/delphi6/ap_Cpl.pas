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
unit ap_Cpl;

interface

uses
  Messages,
  Windows,
  Cpl,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatCplLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagCPLINFOWrapper = class(TatRecordWrapper)
  private
    FidIcon: Integer;
    FidName: Integer;
    FidInfo: Integer;
    FlData: Longint;
  public
    constructor Create(ARecord: tagCPLINFO);
    function ObjToRec: tagCPLINFO;
  published
    property idIcon: Integer read FidIcon write FidIcon;
    property idName: Integer read FidName write FidName;
    property idInfo: Integer read FidInfo write FidInfo;
    property lData: Longint read FlData write FlData;
  end;
  
  tagNEWCPLINFOAWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwFlags: DWORD;
    FdwHelpContext: DWORD;
    FlData: Longint;
    FhIcon: HICON;
  public
    constructor Create(ARecord: tagNEWCPLINFOA);
    function ObjToRec: tagNEWCPLINFOA;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwHelpContext: DWORD read FdwHelpContext write FdwHelpContext;
    property lData: Longint read FlData write FlData;
    property hIcon: HICON read FhIcon write FhIcon;
  end;
  
  tagNEWCPLINFOWWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwFlags: DWORD;
    FdwHelpContext: DWORD;
    FlData: Longint;
    FhIcon: HICON;
  public
    constructor Create(ARecord: tagNEWCPLINFOW);
    function ObjToRec: tagNEWCPLINFOW;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwHelpContext: DWORD read FdwHelpContext write FdwHelpContext;
    property lData: Longint read FlData write FlData;
    property hIcon: HICON read FhIcon write FhIcon;
  end;
  

implementation

constructor tagCPLINFOWrapper.Create(ARecord: tagCPLINFO);
begin
  inherited Create;
  FidIcon := ARecord.idIcon;
  FidName := ARecord.idName;
  FidInfo := ARecord.idInfo;
  FlData := ARecord.lData;
end;

function tagCPLINFOWrapper.ObjToRec: tagCPLINFO;
begin
  result.idIcon := FidIcon;
  result.idName := FidName;
  result.idInfo := FidInfo;
  result.lData := FlData;
end;

constructor tagNEWCPLINFOAWrapper.Create(ARecord: tagNEWCPLINFOA);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
  FdwHelpContext := ARecord.dwHelpContext;
  FlData := ARecord.lData;
  FhIcon := ARecord.hIcon;
end;

function tagNEWCPLINFOAWrapper.ObjToRec: tagNEWCPLINFOA;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
  result.dwHelpContext := FdwHelpContext;
  result.lData := FlData;
  result.hIcon := FhIcon;
end;

constructor tagNEWCPLINFOWWrapper.Create(ARecord: tagNEWCPLINFOW);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwFlags := ARecord.dwFlags;
  FdwHelpContext := ARecord.dwHelpContext;
  FlData := ARecord.lData;
  FhIcon := ARecord.hIcon;
end;

function tagNEWCPLINFOWWrapper.ObjToRec: tagNEWCPLINFOW;
begin
  result.dwSize := FdwSize;
  result.dwFlags := FdwFlags;
  result.dwHelpContext := FdwHelpContext;
  result.lData := FlData;
  result.hIcon := FhIcon;
end;



procedure TatCplLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('WM_CPL_LAUNCH',WM_CPL_LAUNCH);
    AddConstant('WM_CPL_LAUNCHED',WM_CPL_LAUNCHED);
    AddConstant('CPL_DYNAMIC_RES',CPL_DYNAMIC_RES);
    AddConstant('CPL_INIT',CPL_INIT);
    AddConstant('CPL_GETCOUNT',CPL_GETCOUNT);
    AddConstant('CPL_INQUIRE',CPL_INQUIRE);
    AddConstant('CPL_SELECT',CPL_SELECT);
    AddConstant('CPL_DBLCLK',CPL_DBLCLK);
    AddConstant('CPL_STOP',CPL_STOP);
    AddConstant('CPL_EXIT',CPL_EXIT);
    AddConstant('CPL_NEWINQUIRE',CPL_NEWINQUIRE);
    AddConstant('CPL_STARTWPARMS',CPL_STARTWPARMS);
    AddConstant('CPL_SETUP',CPL_SETUP);
  end;
end;

class function TatCplLibrary.LibraryName: string;
begin
  result := 'Cpl';
end;

initialization
  RegisterScripterLibrary(TatCplLibrary, True);

{$WARNINGS ON}

end.

