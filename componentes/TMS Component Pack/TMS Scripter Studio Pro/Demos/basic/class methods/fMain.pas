unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, Menus,
  atScript, ShellApi, Db, DBTables, atPascal, atBasic, AdvMemo, advmbs;

type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    Script1: TMenuItem;
    Run1: TMenuItem;
    Scripter: TatBasicScripter;
    AdvMemo1: TAdvMemo;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    procedure Run1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  end;

var
  fmMain: TfmMain;

implementation
uses fAuxForm;

{$R *.DFM}

{TMyFormLibrary}

type
  TMyFormLibrary = class(TatScripterLibrary)
  protected
    procedure MyFormCreateAndShowProc(AMachine: TatVirtualMachine);
    procedure Init; override;
  end;

{ TMyFormLibrary }

procedure TMyFormLibrary.Init;
begin
   With Scripter do
      With AddDelphiClass(TMyForm) do
         DefineMethod('CreateAndShow',1,tkClass,TMyForm,MyFormCreateAndShowProc,true); { <-- the true indicates it is a class method }
end;

procedure TMyFormLibrary.MyFormCreateAndShowProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
    TMyForm.CreateAndShow(GetInputArgAsString(0));
end;

{TfmMain}

procedure TfmMain.Run1Click(Sender: TObject);
begin
   with Scripter do
   begin
      SourceCode.Assign(AdvMemo1.Lines);
      Compile;
      Execute( 0 );
   end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Scripter.AddLibrary(TMyFormLibrary);
end;

end.
