unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  atScript, atPascal, atBasic, AtWebScripter, AtHTMLParse, AdvMemo,
  Advmps, StdCtrls, ComCtrls, ExtCtrls, ShellAPI, DB, DBTables,
  {$IFNDEF VER130}
  StrUtils,
  {$ENDIF}
  advmbs;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PC: TPageControl;
    TSSource: TTabSheet;
    TSPreCompiled: TTabSheet;
    TSResult: TTabSheet;             
    Button2: TButton;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    EditSource: TAdvMemo;
    EditPre: TAdvMemo;
    EditResult: TAdvMemo;
    TabSheet1: TTabSheet;
    Table1: TTable;
    Table1CustNo: TFloatField;
    Table1Company: TStringField;
    Table1Addr1: TStringField;
    Table1Addr2: TStringField;
    Table1City: TStringField;
    Table1State: TStringField;
    Table1Zip: TStringField;
    Table1Country: TStringField;
    Table1Phone: TStringField;
    Table1FAX: TStringField;
    Table1TaxRate: TFloatField;
    Table1Contact: TStringField;
    Table1LastInvoiceDate: TDateTimeField;
    WebScript: TatWebScripter;
    Memo2: TMemo;
    ChkShowBasic: TCheckBox;
    EditVB: TAdvMemo;
    AdvBasicMemoStyler1: TAdvBasicMemoStyler;
    procedure FormCreate(Sender: TObject);
    procedure WebScriptDirective(Sender: TObject; const ADirective: String;
      var AReplace: String);
    procedure Button2Click(Sender: TObject);
    procedure WebScriptAfterPreCompile(Sender: TObject;
      ALanguage: TatLanguage; PreCompiledCode: TStrings);
    procedure WebScriptInitScripter(Sender: TObject;
      AScripter: TatCustomScripter);
    procedure ChkShowBasicClick(Sender: TObject);
  private
    { Private declarations }
    FTCStart: Cardinal;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ap_System, ap_Classes, ap_DB;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  PC.ActivePageIndex := 0;
  PC.Align := alClient;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FTCStart := GetTickCount;
  if ChkShowBasic.Checked then
    EditResult.Lines.Text := WebScript.ContentFromString(EditVB.Lines.Text)
  else
    EditResult.Lines.Text := WebScript.ContentFromString(EditSource.Lines.Text);
  PC.ActivePageIndex := 2;
  EditResult.Lines.SaveToFile('scripter.htm');
  ShellExecute(0,'open','scripter.htm',nil,nil,SW_NORMAL);
end;

procedure TForm1.WebScriptDirective(Sender: TObject; const ADirective: String;
  var AReplace: String);
begin
  if SameText(ADirective, 'I metablock.inc') then
  begin
    if ChkShowBasic.Checked then
      {$IFNDEF VER130}
      AReplace :=  AnsiReplaceText(Memo2.Lines.Text, '"', '''')
      {$ELSE}
      AReplace :=  StringReplace(Memo2.Lines.Text, '"', '''', [rfReplaceAll]) 
      {$ENDIF}
    else
      AReplace :=  Memo2.Lines.Text;
  end;
end;

procedure TForm1.WebScriptAfterPreCompile(Sender: TObject; ALanguage: TatLanguage; PreCompiledCode: TStrings);
var
  TCEnd: Cardinal;
begin
  TCEnd := GetTickCount;
  EditPre.Lines.Assign(PreCompiledCode);
  EditPre.Lines.Insert(0, '{ PreCompile Duration: ' + IntToStr(TCEnd - FTCStart) + ' msecs.}');
end;

procedure TForm1.WebScriptInitScripter(Sender: TObject; AScripter: TatCustomScripter);
begin
  // Initialize your scripter here !!
  AScripter.LoadLibrary('System', True);
  AScripter.LoadLibrary('Classes', True);
  AScripter.LoadLibrary('DB', True);

  AScripter.AddObject('Table1',Table1);
end;

procedure TForm1.ChkShowBasicClick(Sender: TObject);
begin
  EditSource.Visible := not ChkShowBasic.Checked;
  EditVB.Visible := ChkShowBasic.Checked;
  pc.ActivePage := TSSource;
end;

end.
