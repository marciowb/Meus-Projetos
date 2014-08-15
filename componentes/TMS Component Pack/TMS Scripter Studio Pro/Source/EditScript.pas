unit EditScript;

interface

{$I ASCRIPT.INC}

uses
  Windows, Messages, SysUtils, {$IFDEF DELPHI6_LVL}Variants, {$ENDIF}Classes, Graphics, Controls, Forms,
  Dialogs, AdvMemo, advmbs, Advmps, StdCtrls, Buttons, ExtCtrls;

type
  TScriptEditForm = class(TForm)
    AdvMemo1: TAdvMemo;
    Panel1: TPanel;
    spbCut: TSpeedButton;
    spbPaste: TSpeedButton;
    spbSave: TSpeedButton;
    spbOpen: TSpeedButton;
    spbCopy: TSpeedButton;
    spbUndo: TSpeedButton;
    spbRedo: TSpeedButton;
    spbNew: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Func: TLabel;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    SaveDialog2: TSaveDialog;
    OpenDialog2: TOpenDialog;
    OpenDialog3: TOpenDialog;
    SaveDialog3: TSaveDialog;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    procedure spbNewClick(Sender: TObject);
    procedure spbUndoClick(Sender: TObject);
    procedure spbRedoClick(Sender: TObject);
    procedure spbCutClick(Sender: TObject);
    procedure spbCopyClick(Sender: TObject);
    procedure spbPasteClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure spbOpenClick(Sender: TObject);
    procedure spbSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScriptEditForm: TScriptEditForm;

implementation

{$R *.dfm}

procedure TScriptEditForm.spbNewClick(Sender: TObject);
begin
  AdvMemo1.Clear;
end;

procedure TScriptEditForm.spbUndoClick(Sender: TObject);
begin
  AdvMemo1.Undo;
end;

procedure TScriptEditForm.spbRedoClick(Sender: TObject);
begin
   AdvMemo1.Redo;
end;

procedure TScriptEditForm.spbCutClick(Sender: TObject);
begin
  AdvMemo1.CutToClipBoard;
end;

procedure TScriptEditForm.spbCopyClick(Sender: TObject);
begin
 AdvMemo1.CopyToClipBoard;
end;

procedure TScriptEditForm.spbPasteClick(Sender: TObject);
begin
  AdvMemo1.PasteFromClipBoard;
end;

procedure TScriptEditForm.SpeedButton1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TScriptEditForm.SpeedButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TScriptEditForm.spbOpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
     AdvMemo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TScriptEditForm.spbSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    AdvMemo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

end.
