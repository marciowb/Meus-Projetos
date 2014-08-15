unit fCheckListParamEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, fCustomListParamEditor;

type
  TfmCheckListParamEditor = class(TfmCustomListParamEditor)
    procedure btOkClick(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmCheckListParamEditor: TfmCheckListParamEditor;

implementation

uses
  atVisualQuery, qsRes;

{$R *.DFM}

procedure TfmCheckListParamEditor.btOkClick(Sender: TObject);
begin
  ParamType := ptCheckList;
  inherited;
end;

procedure TfmCheckListParamEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmCheckListParamEditor.Localize;
begin
  Self.Caption := _str('fmCheckListParamEditor.Self.Caption');
  lbInfo.Caption := _str('fmCheckListParamEditor.lbInfo.Caption');
end;

end.

