unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, Menus,
  atScript, atPascal, ShellApi, Db, DBTables, AdvMemo, Advmps;


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
  TMathExecuter = class
  private
    FX: double;
    FY: double;
    FSumResult: double;
  public
    procedure ExecuteSum;
    function IsValueNegative(AValue: double): boolean;
    property X: double read FX write FX;
    property Y: double read FY write FY;
    property SumResult: double read FSumResult;
  end;

{ TMathExecuter }

procedure TMathExecuter.ExecuteSum;
begin
   FSumResult:=FX+FY;
end;

function TMathExecuter.IsValueNegative(AValue: double): boolean;
begin
   result:=(AValue<0);
end;

{ TMathExecuterLibrary }

type
   TMathExecuterLibrary = class(TatScripterLibrary)
   protected
      procedure TMathExecuterIsValueNegativeProc(AMachine: TatVirtualMachine);
      procedure TMathExecuterExecuteSumProc(AMachine: TatVirtualMachine);
      procedure TMathExecuterGetXProc(AMachine: TatVirtualMachine);
      procedure TMathExecuterSetXProc(AMachine: TatVirtualMachine);
      procedure TMathExecuterGetYProc(AMachine: TatVirtualMachine);
      procedure TMathExecuterSetYProc(AMachine: TatVirtualMachine);
      procedure TMathExecuterGetSumResultProc(AMachine: TatVirtualMachine);
      procedure Init; override;
   end;

{ TMathExecuterLibrary }

procedure TMathExecuterLibrary.Init;
begin
   With Scripter.AddDelphiClass(TMathExecuter) do
   begin
      DefineMethod('ExecuteSum',0,tkNone,nil,TMathExecuterExecuteSumProc);
      DefineMethod('IsValueNegative',1,tkEnumeration {boolean type}, nil, TMathExecuterIsValueNegativeProc);
      DefineProp('X',tkFloat,TMathExecuterGetXProc,TMathExecuterSetXProc);
      DefineProp('Y',tkFloat,TMathExecuterGetYProc,TMathExecuterSetYProc);
      DefineProp('SumResult',tkFloat,TMathExecuterGetSumResultProc,nil);
   end;
end;

procedure TMathExecuterLibrary.TMathExecuterExecuteSumProc(AMachine: TatVirtualMachine);
begin
   With AMachine do
      TMathExecuter(CurrentObject).ExecuteSum;
end;

procedure TMathExecuterLibrary.TMathExecuterGetSumResultProc(AMachine: TatVirtualMachine);
begin
   With AMachine do
      ReturnOutputArg(TMathExecuter(CurrentObject).SumResult);
end;

procedure TMathExecuterLibrary.TMathExecuterGetXProc(AMachine: TatVirtualMachine);
begin
   With AMachine do
      ReturnOutputArg(TMathExecuter(CurrentObject).X);
end;

procedure TMathExecuterLibrary.TMathExecuterGetYProc(AMachine: TatVirtualMachine);
begin
   With AMachine do
      ReturnOutputArg(TMathExecuter(CurrentObject).Y);
end;

procedure TMathExecuterLibrary.TMathExecuterIsValueNegativeProc(AMachine: TatVirtualMachine);
begin
   With AMachine do
      ReturnOutputArg(TMathExecuter(CurrentObject).IsValueNegative(GetInputArgAsFloat(0)));
end;

procedure TMathExecuterLibrary.TMathExecuterSetXProc(AMachine: TatVirtualMachine);
begin
   With AMachine do
      TMathExecuter(CurrentObject).X:=GetInputArgAsFloat(0);
end;

procedure TMathExecuterLibrary.TMathExecuterSetYProc(AMachine: TatVirtualMachine);
begin
   With AMachine do
      TMathExecuter(CurrentObject).Y:=GetInputArgAsFloat(0);
end;

{TfmMain}

procedure TfmMain.Run1Click(Sender: TObject);
begin
   with Scripter do
   begin
      SourceCode:=AdvMemo1.Lines;
      Compile;
      Execute( 0 );
   end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   Scripter.AddLibrary(TMathExecuterLibrary);
end;

end.

