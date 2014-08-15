program MultipleMasterDetail;

uses
  Forms,
  UMultipleMasterDetail in 'UMultipleMasterDetail.pas' {FMultipleMasterDetail};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ConditionalExpressions}{$IF CompilerVersion >= 18}Application.MainFormOnTaskbar := True;{$IFEND}{$ENDIF}
  Application.CreateForm(TFMultipleMasterDetail, FMultipleMasterDetail);
  Application.Run;
end.
