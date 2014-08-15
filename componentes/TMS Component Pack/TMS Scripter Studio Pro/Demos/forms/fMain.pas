unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvMemo, ComCtrls, StdCtrls, ExtCtrls, atScript, atPascal,
  atBasic, AdvmBS, AdvmPS, atScripter, Buttons;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    mmPascal: TAdvMemo;
    AdvMemo1: TAdvMemo;
    Panel1: TPanel;
    btRunScript: TButton;
    TabSheet3: TTabSheet;
    mmBasic: TAdvMemo;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    atScripter1: TatScripter;
    procedure FormCreate(Sender: TObject);
    procedure btRunScriptClick(Sender: TObject);
  private
    { Private declarations }
    FRunScript: TatScript;
    procedure AddFormsToScripter;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses ap_Classes, ap_Forms;

{$R *.dfm}


procedure TForm1.AddFormsToScripter;
begin
  with atScripter1.AddScript(slPascal) do
  begin
    SourceCode := mmPascal.Lines;
    UnitName := 'PascalFormUnit';
  end;
  with atScripter1.AddScript(slBasic) do
  begin
    SourceCode := mmBasic.Lines;
    UnitName := 'BasicFormUnit';
  end;

  {add the application directory as a search path so that the
   dfm files can be found}
  with atScripter1.LibOptions do
  begin
    SearchPath.Add('$(APPDIR)');
    FormFileExt := '.dfm';
  end;

  {You MUST register the classes that are present in the dfm file, otherwise
   a "Class XXXX not registered" error will be raised}
  RegisterClasses([TButton, TBitBtn, TRadioGroup, TEdit]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FRunScript := atScripter1.Scripts.Add;
  AddFormsToScripter;
end;

procedure TForm1.btRunScriptClick(Sender: TObject);
begin
  FRunScript.SourceCode := AdvMemo1.Lines;
  FRunScript.VirtualMachine.Execute;
end;

end.
