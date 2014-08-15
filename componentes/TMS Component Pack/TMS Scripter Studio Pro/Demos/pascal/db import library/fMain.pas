unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, Menus,
  atScript, ShellApi, Db, DBTables, atPascal, AdvMemo, Advmps;

type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    Script1: TMenuItem;
    Run1: TMenuItem;
    Scripter: TatPascalScripter;
    Table1: TTable;
    AdvMemo1: TAdvMemo;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    procedure Run1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  end;

var
  fmMain: TfmMain;

implementation

uses
  ap_DB;

{$R *.DFM}

procedure TfmMain.Run1Click(Sender: TObject);
begin
   with Scripter do
   begin
      SourceCode.Assign(AdvMemo1.Lines);
      Compile;
      Execute(0 );
   end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Scripter.AddObject('Table1',Table1);
end;

initialization
  RegisterScripterLibrary(TatDBLibrary);
end.

