unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, atVisualQuery, Db, DBTables, StdCtrls,
  atDatabase, atBdeDatabase;

type
  TForm1 = class(TForm)
    Query1: TQuery;
    DataSource1: TDataSource;
    atVisualQuery1: TatVisualQuery;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    rbAdvanced: TRadioButton;
    rbParams: TRadioButton;
    rbFilter: TRadioButton;
    rbReadOnly: TRadioButton;
    rbQuerySelect: TRadioButton;
    Splitter1: TSplitter;
    btLeft: TButton;
    btTop: TButton;
    btSmall: TButton;
    btColored: TButton;
    btSave: TButton;
    btLoad: TButton;
    atBdeDatabase1: TatBdeDatabase;
    Button1: TButton;
    procedure btTopClick(Sender: TObject);
    procedure btLeftClick(Sender: TObject);
    procedure btSmallClick(Sender: TObject);
    procedure btColoredClick(Sender: TObject);
    procedure rbAdvancedClick(Sender: TObject);
    procedure rbFilterClick(Sender: TObject);
    procedure rbParamsClick(Sender: TObject);
    procedure rbReadOnlyClick(Sender: TObject);
    procedure rbQuerySelectClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

 {$R *.DFM}

procedure TForm1.btTopClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    Align := alTop;
    Top := DBGrid1.Top - 1;
    Height := 300;
  end;
  with Splitter1 do
  begin
    Align := alTop;
    Top := DBGrid1.Top - 1;
  end;
end;

procedure TForm1.btLeftClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    Align := alLeft;
    Left := DBGrid1.Left - 1;
    Width := 300;
  end;
  with Splitter1 do
  begin
    Align := alLeft;
    Left := DBGrid1.Left - 1;
  end;
end;

procedure TForm1.btSmallClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    Font.Name := 'Small Fonts';
    Font.Size := 7;
  end;
end;

procedure TForm1.btColoredClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    BorderStyle := bsSingle;
    Color := $ffe0e0; // light blue
    EditorColor := $e0ffff; // light yellow
  end;
end;

procedure TForm1.rbAdvancedClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    BeginUpdate;
    ShowQueryTitle             := True;
    EditQueryTitle             := True;
    OptionsForSourceTables     := coDefaultClauseOptions;
    OptionsForDataFields       := coDefaultClauseOptions;
    OptionsForFilterConditions := coDefaultClauseOptions;
    OptionsForGroupingFields   := coDefaultClauseOptions;
    OptionsForOrderingFields   := coDefaultClauseOptions;
    OptionsForParameterEditors := coDefaultClauseOptions;
    ParamEditorsReadOnly       := False;
    ShowParamEditors           := True;
    EndUpdate;
  end;
end;

procedure TForm1.rbFilterClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    BeginUpdate;
    ShowQueryTitle             := False;
    EditQueryTitle             := False;
    OptionsForSourceTables     := coDefaultClauseOptions - [coVisible];
    OptionsForDataFields       := coDefaultClauseOptions - [coVisible];
    OptionsForFilterConditions := coDefaultClauseOptions;
    OptionsForGroupingFields   := coDefaultClauseOptions - [coVisible];
    OptionsForOrderingFields   := coDefaultClauseOptions - [coVisible];
    OptionsForParameterEditors := coDefaultClauseOptions - [coVisible];
    ParamEditorsReadOnly       := False;
    ShowParamEditors           := False;
    EndUpdate;
  end;
end;

procedure TForm1.rbParamsClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    BeginUpdate;
    ShowQueryTitle             := False;
    EditQueryTitle             := False;
    OptionsForSourceTables     := coDefaultClauseOptions - [coVisible];
    OptionsForDataFields       := coDefaultClauseOptions - [coVisible];
    OptionsForFilterConditions := coDefaultClauseOptions - [coVisible];
    OptionsForGroupingFields   := coDefaultClauseOptions - [coVisible];
    OptionsForOrderingFields   := coDefaultClauseOptions - [coVisible];
    OptionsForParameterEditors := coDefaultClauseOptions - [coVisible];
    ParamEditorsReadOnly       := False;
    ShowParamEditors           := True;
    EndUpdate;
  end;
end;

procedure TForm1.rbReadOnlyClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    BeginUpdate;
    ShowQueryTitle             := True;
    EditQueryTitle             := False;
    OptionsForSourceTables     := [coVisible];
    OptionsForDataFields       := [coVisible];
    OptionsForFilterConditions := [coVisible];
    OptionsForGroupingFields   := [coVisible];
    OptionsForOrderingFields   := [coVisible];
    OptionsForParameterEditors := [coVisible];
    ParamEditorsReadOnly       := True;
    ShowParamEditors           := True;
    EndUpdate;
  end;
end;

procedure TForm1.rbQuerySelectClick(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    BeginUpdate;
    ShowQueryTitle             := True;
    EditQueryTitle             := False;
    OptionsForSourceTables     := coDefaultClauseOptions - [coVisible];
    OptionsForDataFields       := coDefaultClauseOptions - [coVisible];
    OptionsForFilterConditions := coDefaultClauseOptions - [coVisible];
    OptionsForGroupingFields   := coDefaultClauseOptions - [coVisible];
    OptionsForOrderingFields   := coDefaultClauseOptions - [coVisible];
    OptionsForParameterEditors := coDefaultClauseOptions - [coVisible];
    ParamEditorsReadOnly       := False;
    ShowParamEditors           := False;
    EndUpdate;
  end;
end;

procedure TForm1.btSaveClick(Sender: TObject);
//var fileName : string;
begin
//fileName := ExtractFilePath(Application.ExeName)+'Queries.qdf';
//atVisualQuery1.SaveQueriesToFile( fileName );
  atVisualQuery1.ExportQueriesToFile;
end;

procedure TForm1.btLoadClick(Sender: TObject);
//var fileName : string;
begin
//fileName := ExtractFilePath(Application.ExeName)+'Queries.qdf';
//if FileExists(fileName) then
//  atVisualQuery1.LoadQueriesFromFile( fileName );
  atVisualQuery1.ImportQueriesFromFile;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with atVisualQuery1 do
  begin
    Font.Name := 'MS Sans Serif';
    Font.Size := 8;
  end;
end;

end.
