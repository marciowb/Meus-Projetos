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
    AdvMemo1: TAdvMemo;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    procedure Run1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CreateComponentProc(AMachine: TatVirtualMachine);
    procedure CreateNewProc(AMachine: TatVirtualMachine);
    procedure ShowModalFormProc(AMachine: TatVirtualMachine);
    procedure GetParentProc(AMachine: TatVirtualMachine);
    procedure SetParentProc(AMachine: TatVirtualMachine);
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

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
  { register a default constructor for TComponent descendants }
  with Scripter.AddDelphiClass(TComponent) do
      DefineMethod('Create',1,tkClass,nil,CreateComponentProc,true);

  { Publish TControl Parent property }
  with Scripter.AddDelphiClass(TControl) do
      DefineProp('Parent',tkClass,GetParentProc,SetParentProc,TWinControl);

  { register a special constructor for TForm descendants }
  with Scripter.AddDelphiClass(TForm) do
  begin
      DefineMethod('CreateNew',1,tkClass,nil,CreateNewProc,true);
      DefineMethod('ShowModal',0,tkNone,nil,ShowModalFormProc);
  end;

  { register some component classes to be used by the script }
  Scripter.AddDelphiClass(TLabel);
  Scripter.AddDelphiClass(TEdit);
  Scripter.AddDelphiClass(TBitBtn);

  { register Scripter as the Self variable }
  Scripter.AddObject('Self',Scripter);

  { register Usefull constants }
  Scripter.AddEnumeration( TypeInfo(TFormBorderStyle) );
  Scripter.AddEnumeration( TypeInfo(TBitBtnKind) );
  Scripter.AddConstant( 'mrOk', mrOk );
  Scripter.AddConstant( 'mrCancel', mrCancel );
end;

procedure TfmMain.CreateNewProc(AMachine: TatVirtualMachine);
type TFormClass = class of TForm;
var form : TForm;
begin
  With AMachine do
  begin
    form := TFormClass(CurrentClass.ClassRef).CreateNew( TComponent(GetInputArgAsInteger(0)) );
    ReturnOutputArg( integer( form ));
  end;
end;

procedure TfmMain.ShowModalFormProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
  begin
    ReturnOutputArg( integer((CurrentObject as TForm).ShowModal) );
  end;
end;

procedure TfmMain.CreateComponentProc(AMachine: TatVirtualMachine);
type TCompClass = class of TComponent;
begin
  With AMachine do
    { get the first argument (a Owner component),
      call class constructor Create
      and return the created instance }
    ReturnOutputArg( integer(
       TCompClass(CurrentClass.ClassRef).Create( TComponent(GetInputArgAsInteger(0)) )));
end;

procedure TfmMain.GetParentProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
    ReturnOutputArg( integer( (CurrentObject as TControl).Parent ) );
end;

procedure TfmMain.SetParentProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
    (CurrentObject as TControl).Parent := TObject(GetInputArgAsInteger(0)) as TWinControl;
end;

end.

