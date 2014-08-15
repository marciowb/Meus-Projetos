unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atScript, atPascal, AdvMemo, Advmps, Menus, FormScript;

type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    mmSource: TAdvMemo;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    Scripter: TatPascalScripter;
    Arquivo1: TMenuItem;
    Run1: TMenuItem;
    miCustomMenu: TMenuItem;
    miOption1: TMenuItem;
    miOption2: TMenuItem;
    miOption3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Run1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation
uses ap_classes;

{$R *.DFM}               

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Scripter.AddComponents(Self);
  { Add support for TNotifyEvent }
  Scripter.AddLibrary(TatClassesLibrary);
end;                             

procedure TfmMain.Run1Click(Sender: TObject);
begin
   Scripter.SourceCode:=mmSource.Lines;
   Scripter.ExecuteSubRoutine('SetEvents'); 
end;

end.
