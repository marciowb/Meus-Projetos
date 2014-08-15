unit atMetaSQLMemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQLAbstractEditor, StdCtrls;

type
  TfmMetaSQLMemo = class(TfmMetaSQLAbstractEditor)
    mmSQL: TMemo;
  private
  protected
    { Private declarations }
  public
    procedure ActivateEditor; override;
    { Public declarations }
  end;

implementation

{$R *.DFM}


{ TfmMetaSQLMemo }

procedure TfmMetaSQLMemo.ActivateEditor;
begin
  inherited;
  mmSQL.Text:=MetaSQL.SQL;
end;

end.
