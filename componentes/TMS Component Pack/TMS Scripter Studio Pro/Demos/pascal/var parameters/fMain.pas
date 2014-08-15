unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, Menus,
  atScript, ShellApi, Db, DBTables, atPascal,
  {$IFNDEF VER130}
  variants,
  {$ENDIF}
  AdvMemo, Advmps;

type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    Script1: TMenuItem;
    Run1: TMenuItem;
    Scripter: TatPascalScripter;
    AdvMemo1: TAdvMemo;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    procedure Run1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

type
   TSomeLibrary = class(TatScripterLibrary)
   protected
      procedure DecodeDateAndTimeProc(AMachine: TatVirtualMachine); 
      procedure Init; override;
   end;

procedure TSomeLibrary.DecodeDateAndTimeProc(AMachine: TatVirtualMachine);
Var Y,M,D,H,Min,S,MS: word;
begin
  {DecodeDateAndTime(Date, var Y, var M, var D, Time, var H, var M, var S);}
  With AMachine do
  begin
    DecodeDate(GetInputArgAsDateTime(0) {Date parameter}, Y,M,D);
    DecodeTime(GetInputArgAsDateTime(4) {Time parameter}, H,Min,S,MS);
    SetInputArg(1,Y);
    SetInputArg(2,M);
    SetInputArg(3,D);
    SetInputArg(5,H);
    SetInputArg(6,Min);
    SetInputArg(7,S);
  end;
end;

procedure TSomeLibrary.Init;
begin
   With Scripter, SystemLibrary do
      DefineMethod('DecodeDateAndTime', { method name }
                8, { number of arguments }
                tkNone, {Return type}
                nil, {Result class}
                DecodeDateAndTimeProc, {procedure wrapper}
                false).SetVarArgs([1,2,3,5,6,7]); { <---- }
      {Use SetVarArgs method to tell scripter which parameters are passed by reference (var).
       In this case, procedure declaration is:
       DecodeDateAndTime(Date, var Y, var M, var D, Time, var H, var M, var S);
                           0      1      2     3     4      5      6      7
       So, parameters indexed 1,2,3,5,6,7 and var type parameters.}
end;

{TfmMain}

procedure TfmMain.Run1Click(Sender: TObject);
begin
   with Scripter do
   begin
      SourceCode.Assign(AdvMemo1.Lines);
      Compile;
      Execute( null );
   end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Scripter.AddLibrary(TSomeLibrary);
end;

end.

