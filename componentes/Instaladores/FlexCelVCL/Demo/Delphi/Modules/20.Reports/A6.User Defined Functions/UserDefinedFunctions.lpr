program UserDefinedFunctions;

uses
  Forms,
  Interfaces,
  UUserDefinedFunctions in 'UUserDefinedFunctions.pas' {FUserDefinedFunctions};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFUserDefinedFunctions, FUserDefinedFunctions);
  Application.Run;
end.
