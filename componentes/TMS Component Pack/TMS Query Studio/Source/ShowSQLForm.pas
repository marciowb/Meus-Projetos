unit ShowSQLForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmShowSQL = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

procedure ShowSQL(const ASQL: string);

implementation

uses
  qsRes;

{$R *.DFM}

procedure ShowSQL(const ASQL: string);
begin
   With TfmShowSQL.Create(Application) do
   try
      Memo1.Lines.Text:=ASQL;
      ShowModal;
   finally
      Free;
   end;
end;

procedure TfmShowSQL.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TfmShowSQL.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmShowSQL.Localize;
begin
  Self.Caption := _str('fmShowSQL.Self.Caption');
  Button1.Caption := _str('fmShowSQL.Button1.Caption');
end;

end.

