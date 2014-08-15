unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, Menus,
  atScript, atPascal, ShellApi, Db, DBTables, AdvMemo, Advmps, AdvmBS,
  atBasic;


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
    procedure SumNumbersProc(AMachine: TatVirtualMachine);
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

{TfmMain}

function SumNumbers(A, B: double; C: double = 0; D: double = 0; E: double = 0): double;
begin
  result := A + B + C + D + E;
end;

procedure TfmMain.SumNumbersProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
  begin
    Case InputArgCount of
      2: ReturnOutputArg(SumNumbers(GetInputArgAsFloat(0), GetInputArgAsFloat(1)));
      3: ReturnOutputArg(SumNumbers(GetInputArgAsFloat(0), GetInputArgAsFloat(1), GetInputArgAsFloat(2)));
      4: ReturnOutputArg(SumNumbers(GetInputArgAsFloat(0), GetInputArgAsFloat(1), GetInputArgAsFloat(2), GetInputArgAsFloat(3)));
      5: ReturnOutputArg(SumNumbers(GetInputArgAsFloat(0), GetInputArgAsFloat(1), GetInputArgAsFloat(2), GetInputArgAsFloat(3), GetInputArgAsFloat(4)));
    end;
  end;
end;

procedure TfmMain.Run1Click(Sender: TObject);
begin
   with Scripter do
   begin
      SourceCode:=AdvMemo1.Lines;
      Compile;
      Execute;
   end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Scripter.DefineMethod('SumNumbers', 5, tkFloat, nil, SumNumbersProc, false, 3);
end;

end.

