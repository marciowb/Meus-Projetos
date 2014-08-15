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
  private
  end;

var
  fmMain: TfmMain;

implementation 

{$R *.DFM}

procedure TfmMain.Run1Click(Sender: TObject);
begin
   with Scripter do
   begin
      SourceCode.Assign(AdvMemo1.Lines);
      Compile;
      Execute( 0 );
   end;
end;

end.

