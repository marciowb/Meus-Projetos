unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IDEMain;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    IDEEngine1: TIDEEngine;
    Button1: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    FDesigner: TIDEFormDesigner;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses fInspector, fDelphiForm, fPalette, FormDEsigner;

{$R *.DFM}

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form2.Show;
  Form3.Show;
  Form4.Show;
  FDesigner := TIDEFormDesigner.Create(Form2);
  FDesigner.Active := true;
  IDEEngine1.FormDesigner := FDesigner;
  IDEEngine1.Inspector := Form3.IDEInspector1;
  IDEEngine1.PaletteToolbar := Form4.IDEPaletteToolbar1;
  Form4.IDEPaletteToolbar1.Update;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FDesigner.Free;
  FDesigner := nil;
  Form3.Close;
  Form4.Close;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if FDesigner <> nil then
  begin
    if SaveDialog1.Execute then
      FDesigner.SaveToDFM(SaveDialog1.FileName, dfmText);
  end else
    ShowMessage('Form must be in editing mode.');

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if FDesigner <> nil then
  begin
    if OpenDialog1.Execute then
      FDesigner.LoadFromDFM(OpenDialog1.FileName, dfmText);
  end else
    ShowMessage('Form must be in editing mode.');
end;

end.
