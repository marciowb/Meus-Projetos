program CustomAutoSearchDialog;

uses
  Forms,
  AutoSearchFieldsToSQLWhereClause in 'AutoSearchFieldsToSQLWhereClause.pas' {Form1},
  myASDlg in 'myASDlg.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
