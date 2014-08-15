unit fCustomGroupEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, atMetaSql,
  fCustomEditor;

type
  TfmCustomGroupEditor = class(TfmCustomEditor)
    pnFieldName: TPanel;
    Label2: TLabel;
    edFieldExpr: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmCustomGroupEditor: TfmCustomGroupEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmCustomGroupEditor.FormShow(Sender: TObject);
var c: integer;
begin
   inherited;
   { carrega a lista de campos disponíveis }
   edFieldExpr.Items.BeginUpDate;
   try
      edFieldExpr.Items.Clear;
      with MetaSqlDef.MetaSql.SqlFields do
         for c:=0 to Count-1 do
            with Items[c] do
               edFieldExpr.Items.AddObject(Displaylabel,Items[c]);
   finally
      edFieldExpr.Items.EndUpdate;
   end;
   AdjustDefaultItems;
end;

procedure TfmCustomGroupEditor.btOkClick(Sender: TObject);
var c: integer;
begin
   inherited;
   with MetaSqlDef.MetaSql do
   begin
      { verifica se o campo foi informado }
      ValidationError(
         edFieldExpr.Text='',
         _str(SFieldNotIndicated),
         [edFieldExpr.Text],
         edFieldExpr );

      EditedObject := MetaSqlDef.MetaSql.GroupFields.Add;
      with TatSqlGroupField(EditedObject) do
      begin
         { se escolheu algum dos campos existentes então o inclui no agrupamento }
         if edFieldExpr.ItemIndex>-1 then
            FieldAlias := TatSqlField(edFieldExpr.Items.Objects[edFieldExpr.ItemIndex]).FieldAlias
         else
         begin
            { senão procura por uma expressão equivalente }
            for c:=0 to SqlFields.Count-1 do
               with SqlFields[c] do
                  if SameText(edFieldExpr.Text,FieldExpression) then
                  begin
                     TatSqlGroupField(EditedObject).FieldAlias := FieldAlias;
                     Exit;
                  end;

            { se não encontrou uma expressão equivalente então cria uma agora }
            // *** não implementado
            ShowMessage(_str(SNotImplemented));
            FieldAlias:='';
         end;
      end;
   end;
end;

procedure TfmCustomGroupEditor.Localize;
begin
  Self.Caption := _str('fmCustomGroupEditor.Self.Caption');
  Label2.Caption := _str('fmCustomGroupEditor.Label2.Caption');
  lbInfo.Caption := _str('fmCustomGroupEditor.lbInfo.Caption');
end;

procedure TfmCustomGroupEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
