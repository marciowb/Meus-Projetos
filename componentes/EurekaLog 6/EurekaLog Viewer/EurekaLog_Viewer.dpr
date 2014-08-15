program EurekaLog_Viewer;

uses
  ExceptionLog,
  Windows,
  ComServ,
  SysUtils,
  ActiveX,
  Forms,
  Variants,
  EViewer in 'EViewer.pas' {ELViewerMainForm},
  EurekaLog_Viewer_TLB in 'EurekaLog_Viewer_TLB.pas',
  ComLinkUnit in 'ComLinkUnit.pas' {Link: CoClass};

{$R *.TLB}

{$R *.res}

var
  MutexHandle: THandle;

procedure PassFilesToMainInstance;
var
  Link: ILink;
  FilesArray: OleVariant;

  function IsOLECommand: boolean;
  var
    Param: string;
  begin
    Result := False;
    if (ParamCount = 0) then Exit;

    Param := UpperCase(Trim(ParamStr(1)));
    if (Param[1] in ['/', '-']) then System.Delete(Param, 1, 1);

    Result := ((Param = 'REGSERVER') or (Param = 'UNREGSERVER') or
      (Param = 'AUTOMATION') or (Param = 'EMBEDDING'));
  end;

  function CreateILinkObject(var Intf: ILink): boolean;
  begin
    Result := False;

    if Succeeded(CoCreateInstance(CLASS_Link, nil, CLSCTX_INPROC_SERVER or
      CLSCTX_LOCAL_SERVER, ILink, Intf)) then Result := True;
  end;

begin
  if (ParamCount > 0) and (not IsOLECommand) then
  begin
    if (not CreateILinkObject(Link)) then
    begin
      MessageBox(0, 'You cannot open more EurekaLog Viewer instances.',
        'Error', MB_OK or MB_ICONERROR or MB_TASKMODAL);
      Exit;
    end;

    FilesArray := VarArrayCreate([0, 0], varOleStr);
    FilesArray[0] := ParamStr(1);
    Link.AddFiles(FilesArray);
  end;
end;

begin
  MutexHandle := CreateMutex(nil, True, 'EurekaLogViewer');
  try
   	if ((MutexHandle <> 0) and (GetLastError = ERROR_ALREADY_EXISTS)) then
    begin
      PassFilesToMainInstance;
      Exit;
    end;

    StartComServer;
    ShowEurekaLogUnits := True;
    try
      Application.Initialize;
    except
      // A workaround for EOleSysError exception.
    end;

    if (not (ComServer.StartMode in [smRegServer, smUnregServer])) then
      Application.CreateForm(TELViewerMainForm, ELViewerMainForm);

    Application.Run;
  finally
    CloseHandle(MutexHandle);
  end;
end.
