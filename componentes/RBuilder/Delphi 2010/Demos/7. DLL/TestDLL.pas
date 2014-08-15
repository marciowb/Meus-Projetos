{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit TestDLL;

interface

uses
{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DB, ExtCtrls, DBTables;

type
  { First, define a procedural data-type, this should reflect the
    procedure that is exported from the DLL. }
  TShowForm = function(aApplicationHandle: THandle): Bool; StdCall;

  { Create a new exception class to refect a failed DLL load }
  EDLLLoadError = class(Exception);

  TfrmCallDLL = class(TForm)
    Database1: TDatabase;
    btnCallDLL: TButton;
    btnClose: TButton;
    memDLL: TMemo;
    Shape4: TShape;
    Label4: TLabel;
    Shape9: TShape;
    Label6: TLabel;
    procedure btnCallDLLClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

var
  frmCallDLL: TfrmCallDLL;

implementation


{$R *.DFM}

procedure TfrmCallDLL.FormCreate(Sender: TObject);
begin
  {move memo field up}
  memDLL.Left := 8;
  memDLL.Top := 32;
  Height := 150;

  {scale, if large fonts}
  if Screen.PixelsPerInch = 120 then
    begin
      Height := Trunc(Height * 1.25);
      Width  := Trunc(Width  * 1.25);
      memDLL.Left :=  Trunc(memDLL.Left  * 1.25);
      memDLL.Top  :=  Trunc(memDLL.Top   * 1.25);

    end;

end;




procedure TfrmCallDLL.btnCallDLLClick(Sender: TObject);
var
  LibHandle: THandle;
  ShowForm: TShowForm;
begin

  { attempt to load the DLL }
  LibHandle := LoadLibrary('RptDLL.DLL');

  try
    { if the load failed, LibHandle will be less than the HINSTANCE_ERROR
      constant. if this is the case, raise an exception. }
    if LibHandle = HINSTANCE_ERROR then
      raise EDLLLoadError.Create('Unable to Load DLL');

    { If the code makes it here, the DLL loaded successfully, now obtain
      the link to the DLL's exported function so that it can be called. }
    @ShowForm := GetProcAddress(LibHandle, 'ShowForm');

    { If the function is imported successfully, then call the Shorform function.}
    if not (@ShowForm = nil) then
      ShowForm(Application.Handle);

  finally
    {unload the DLL}
    FreeLibrary(LibHandle);
  end;
end;

procedure TfrmCallDLL.btnCloseClick(Sender: TObject);
begin
  Close;
end;


end.
