unit fChooseListParamEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, fCustomListParamEditor;

type
  TfmChooseListParamEditor = class(TfmCustomListParamEditor)
    procedure btOkClick(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmChooseListParamEditor: TfmChooseListParamEditor;

implementation

uses
  atVisualQuery, qsRes;

{$R *.DFM}

procedure TfmChooseListParamEditor.btOkClick(Sender: TObject);
begin
  ParamType := ptChooseList;
  inherited;
end;

procedure TfmChooseListParamEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmChooseListParamEditor.Localize;
begin
  Self.Caption := _str('fmChooseListParamEditor.Self.Caption');
  lbInfo.Caption := _str('fmChooseListParamEditor.lbInfo.Caption');
end;

end.

