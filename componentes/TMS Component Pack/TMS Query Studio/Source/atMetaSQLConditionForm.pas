unit atMetaSQLConditionForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQL, atMetaSQLConditionEditor;

type
  TfmMetaSQLConditionForm = class(TForm)
    procedure FormActivate(Sender: TObject);
  private
    FConditionEditor: TfmMetaSQLConditionEditor;
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

procedure EditSQLConditions(AMetaSQL: TatMetaSQL; AConds: TatSQLConditions; DBName: string);

implementation

uses
  qsRes;

{$R *.DFM}

procedure EditSQLConditions(AMetaSQL: TatMetaSQL; AConds: TatSQLConditions; DBName: string);
var NewForm: TfmMetaSQLConditionForm;
begin
   NewForm:=TfmMetaSQLConditionForm.Create(Application);
   With NewForm do
   try
      FConditionEditor:=TfmMetaSQLConditionEditor.Create(NewForm);
      With FConditionEditor do
      begin
         Align:=alClient;
         RootConditions:=AConds;
         MetaSQL:=AMetaSQL;
         Enabled:=true;
         DatabaseName:=DBName;
      end;
      ShowModal;
   finally
      Free;
   end;
end;

procedure TfmMetaSQLConditionForm.FormActivate(Sender: TObject);
begin
   FConditionEditor.Parent:=Self;
   FConditionEditor.ActivateEditor;
end;

procedure TfmMetaSQLConditionForm.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmMetaSQLConditionForm.Localize;
begin
  Self.Caption := _str('fmMetaSQLConditionForm.Self.Caption');
end;

end.
