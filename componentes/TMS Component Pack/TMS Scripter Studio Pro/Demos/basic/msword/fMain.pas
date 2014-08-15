unit fMain;

interface

{$I Ascript.inc}

uses
  Windows, Messages, SysUtils,
  {$IFDEF DELPHI6_LVL}Variants,{$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, atScript, comobj, FormScript, Mask, DBCtrls, ExtCtrls,
  DB, DBTables, Grids, DBGrids, atPascal, AdvMemo, advmbs, atBasic;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    Table1: TTable;
    DBNavigator1: TDBNavigator;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ShowWord: TCheckBox;
    AdvMemo1: TAdvMemo;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    atBasicFormScripter1: TatBasicFormScripter;
    procedure Button1Click(Sender: TObject);
    procedure StAdd;
    procedure StGetValue;
    procedure StGetCurrentDir;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  wdGotoBookmark = -1;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with atBasicFormScripter1.AddDelphiClass(TStrings) do
    AddMethod('Add',1,tkNone,nil,StAdd);

  with atBasicFormScripter1.AddDelphiClass(TDBEdit) do
    AddMethod('GetValue',0,tkString,nil,StGetValue);

  atBasicFormScripter1.SystemLibrary.AddMethod('GetCurrentDir',0,tkString,nil,stGetCurrentDir);
  atBasicFormScripter1.SystemLibrary.AddConstant('wdGotoBookMark',wdGotoBookmark);

  atBasicFormScripter1.SourceCode.Assign(AdvMemo1.Lines);
  atBasicFormScripter1.Execute(null);
end;

procedure TForm1.StAdd;
begin
  TStrings(atBasicFormScripter1.CurrentObject).Add(atBasicFormScripter1.GetInputArgAsString(0));
end;

procedure TForm1.StGetCurrentDir;
begin
  atBasicFormScripter1.ReturnOutputArg(GetCurrentDir);
end;

procedure TForm1.StGetValue;
begin
  atBasicFormScripter1.ReturnOutputArg(TDBEdit(atBasicFormScripter1.CurrentObject).EditText);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Table1.Open;
end;

end.
