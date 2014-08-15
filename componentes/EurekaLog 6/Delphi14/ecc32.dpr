program ecc32;

{$APPTYPE CONSOLE}

{$I Exceptions.inc}

uses
{$IFNDEF EUREKALOG_DEMO}
  ExceptionLog,
{$ENDIF}
  ECmdLine;

begin
  ExitCode := Execute;
end.

