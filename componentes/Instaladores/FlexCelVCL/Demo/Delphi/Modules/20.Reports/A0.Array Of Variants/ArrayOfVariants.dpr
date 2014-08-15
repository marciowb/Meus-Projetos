program ArrayOfVariants;

uses
  Forms,
  UArrayOfVariants in 'UArrayOfVariants.pas' {FArrayOfVariants};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFArrayOfVariants, FArrayOfVariants);
  Application.Run;
end.
