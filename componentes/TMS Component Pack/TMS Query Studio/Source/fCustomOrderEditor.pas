unit fCustomOrderEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls,
  fCustomEditor;

type
  TfmCustomOrderEditor = class(TfmCustomEditor)
    pnFieldName: TPanel;
    Label2: TLabel;
    edFieldExpr: TComboBox;
    pnAggregation: TPanel;
    Label4: TLabel;
    edAggregation: TComboBox;
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmCustomOrderEditor: TfmCustomOrderEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmCustomOrderEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmCustomOrderEditor.Localize;
begin
  Self.Caption := _str('fmCustomOrderEditor.Self.Caption');
  Label2.Caption := _str('fmCustomOrderEditor.Label2.Caption');
  Label4.Caption := _str('fmCustomOrderEditor.Label4.Caption');
  edAggregation.Items.Clear;
  edAggregation.Items.Add(_str('fmCustomOrderEditor.edAggregation.Items0'));
  edAggregation.Items.Add(_str('fmCustomOrderEditor.edAggregation.Items1'));
  lbInfo.Caption := _str('fmCustomOrderEditor.lbInfo.Caption');
end;

end.
