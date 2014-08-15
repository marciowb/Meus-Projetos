unit fQueryEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, atVisualQuery, StdCtrls;

type
  TfmQueryEditor = class(TForm)
    VisualQuery: TatVisualQuery;
    pnBottom: TPanel;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    procedure VisualQueryResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmQueryEditor: TfmQueryEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmQueryEditor.VisualQueryResize(Sender: TObject);
begin
  ClientHeight := VisualQuery.Height + pnBottom.Height;
end;

procedure TfmQueryEditor.FormShow(Sender: TObject);
begin
  { if form do not fit well on the screen, then realign it to the center }
  if (Top+Height>Screen.Height) or
     (Left+Width>Screen.Width) then
  begin
    Left := (Screen.Width-Width) div 2;
    Top := (Screen.Height-Height) div 2;
  end;
end;

procedure TfmQueryEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmQueryEditor.Localize;
begin
  Self.Caption := _str('fmQueryEditor.Self.Caption');
  VisualQuery.MetaSqlDefs[0].Title := _str('fmQueryEditor.VisualQuery.MetaSqlDefs0.Title');
  Button1.Caption := _str('fmQueryEditor.Button1.Caption');
  Button2.Caption := _str('fmQueryEditor.Button2.Caption');
end;

end.
