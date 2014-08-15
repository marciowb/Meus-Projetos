program Threads;

uses
  Forms,
  UThreads in 'UThreads.pas' {FThreads},
  UFlxRepThread in 'UFlxRepThread.pas',
  UBDEThreadData in 'UBDEThreadData.pas' {BDEThreadData: TDataModule},
  UAbout in 'UAbout.pas' {About},
  UThreadData in 'UThreadData.pas' {ThreadData: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.Title := 'FlexCel Threaded Demo';
  Application.CreateForm(TFThreads, FThreads);
  Application.Run;
end.
