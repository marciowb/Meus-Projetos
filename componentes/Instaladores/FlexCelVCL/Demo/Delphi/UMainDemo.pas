unit UMainDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$I AllUnits.inc}
  Dialogs, ActnList, ImgList, Menus, ComCtrls, ToolWin, StdCtrls,
  {$IFDEF FPC} LResources,{$ENDIF}
  ExtCtrls, ShellAPI, XlsAdapter;

type
  ClassTForm = class of TForm;

  //Data to be stored in the nodes of the left treeview.
  TModuleData = class
    public
      Path: string;
      constructor Create(const aPath: string);
  end;

  TMainDemoForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    exit1: TMenuItem;
    MenuCommands: TActionList;
    ToolbarImages: TImageList;
    ActionExit: TAction;
    MainToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ActionRun: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ActionViewTemplate: TAction;
    ToolButton5: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    PanelModules: TPanel;
    ModulesList: TTreeView;
    DescriptionText: TRichEdit;
    StatusBar: TStatusBar;
    ActionOpenProject: TAction;
    Demo1: TMenuItem;
    RunSelected1: TMenuItem;
    N1: TMenuItem;
    ViewTemplate1: TMenuItem;
    OpenProject1: TMenuItem;
    ToolButton6: TToolButton;
    ToolbarImagesH: TImageList;
    ToolbarImagesD: TImageList;
    procedure ActionExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ModulesListDeletion(Sender: TObject; Node: TTreeNode);
    procedure ModulesListChange(Sender: TObject; Node: TTreeNode);
    procedure ActionRunExecute(Sender: TObject);
    procedure ActionViewTemplateExecute(Sender: TObject);
    procedure ActionOpenProjectExecute(Sender: TObject);
  private
    procedure LoadModules;
    procedure ScanFolder(MainNode: TTreeNode; const MainPath, ModulePath: string);
    procedure LoadModule(const MainPath, ModulePath, ModuleName: string;
      const Node: TTreeNode);
    function GetNodeData(const Path: string): TModuleData;
    function GetModuleForm: ClassTForm;
    function HasFileToLaunch(const extension: string): string;
    function HasModuleForm: boolean;
    function GetLinkedFile(const LinkFile: string): string;
    function HasProjectToLaunch: boolean;
    procedure SetBasePath(const f: TForm);
    { Private declarations }
  public
    { Public declarations }
  end;
var
  MainDemoForm: TMainDemoForm;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

const
  ExtLaunch = '.xls';
  ExtTemplate = '.template.xls';
  ExtProj: array[0..3] of string = ('.dproj', '.cbproj', '.dpr', '.bpr');
  ExtLocation = '.location.txt';


procedure TMainDemoForm.ActionExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainDemoForm.ActionOpenProjectExecute(Sender: TObject);
var
  f: string;
  i: integer;
begin
  for i:= Low(ExtProj) to High(ExtProj) do
  begin
    f := HasFileToLaunch(ExtProj[i]);
    if f <> '' then
    begin
      ShellExecute(0, nil, PChar(f), nil, nil, SW_SHOWNORMAL);
      exit;
    end;
  end;

end;

procedure TMainDemoForm.SetBasePath(const f: TForm);
var
  i: Integer;
  ModulePath: string;
begin
  if (ModulesList.Selected = nil) or (ModulesList.Selected.Data = nil) then exit;
  ModulePath := ExtractFilePath(TModuleData(ModulesList.Selected.Data).Path);

  for i := 0 to f.ComponentCount - 1 do
  begin
    if f.Components[i] is TXlsAdapter then
      (f.Components[i] as TXlsAdapter).BasePathToOpen := ModulePath;
  end;
end;

procedure TMainDemoForm.ActionRunExecute(Sender: TObject);
var
  Module : ClassTForm;
  f: TForm;
begin
  Module := GetModuleForm;
  if (Module = nil) then raise Exception.Create('Can''t create module');
  
  f := Module.Create(nil);
  try
    SetBasePath(f);
    f.SetBounds(Left + (Width - f.Width) div 2, Top + (Height - f.Height) div 2, f.Width, f.Height);
    f.ShowModal;
  finally
    FreeAndNil(f);
  end;
end;

procedure TMainDemoForm.ActionViewTemplateExecute(Sender: TObject);
var
  f: string;
begin
  f := HasFileToLaunch(ExtTemplate);
  if f <> '' then ShellExecute(0, nil, PChar(f), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainDemoForm.FormCreate(Sender: TObject);
begin
  {$if CompilerVersion >= 18}  //Delphi 2006 or newer, this is fixed there.
  PanelModules.ParentBackground := false; //workarounds a bug in delphi.
  {$IFEND}
  LoadModules;
end;

procedure TMainDemoForm.LoadModules;
var
  MainPath: String;
  MainNode: TTreeNode;
begin
  MainPath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  ModulesList.Items.BeginUpdate;
  try
    MainNode := ModulesList.Items.AddObject(nil, Caption, TModuleData.Create(MainPath + 'MainDemo'));
    ScanFolder(MainNode, IncludeTrailingPathDelimiter(MainPath + 'Modules'), IncludeTrailingPathDelimiter(MainPath + 'Modules'));

    ModulesList.FullExpand;
    if ModulesList.Items.Count > 0 then
    begin
      ModulesList.Select(ModulesList.Items[0]);
      ModulesList.Selected.MakeVisible;
    end;
  finally
    ModulesList.Items.EndUpdate;
  end;

end;

procedure TMainDemoForm.ModulesListChange(Sender: TObject; Node: TTreeNode);
begin
  if (Node.Data = nil) then DescriptionText.Clear
  else DescriptionText.Lines.LoadFromFile(TModuleData(Node.Data).Path + '.rtf');

  if (Node.Data <> nil) then StatusBar.SimpleText := TModuleData(Node.Data).Path;

  ActionRun.Enabled := HasModuleForm or (HasFileToLaunch(ExtLaunch) <> '');
  ActionViewTemplate.Enabled := HasFileToLaunch(ExtTemplate) <> '';
  ActionOpenProject.Enabled := HasProjectToLaunch;
end;

function TMainDemoForm.HasProjectToLaunch: boolean;
var
  i: Integer;
begin
  Result := true;
  for i := Low(ExtProj) to High(ExtProj) do if HasFileToLaunch(ExtProj[i])<> '' then exit;
  Result:= false;
end;

function TMainDemoForm.HasModuleForm: boolean;
begin
  Result := GetModuleForm <> nil;
end;

function TMainDemoForm.GetModuleForm: ClassTForm;
var
  aPath, mPath, mName: string;
begin
  Result := nil;
  if (ModulesList.Selected = nil) or (ModulesList.Selected.Data = nil) then exit;
  aPath := TModuleData(ModulesList.Selected.Data).Path;
  mName := ExtractFileName(aPath);
  mPath := IncludeTrailingPathDelimiter(ExtractFilePath(aPath));
  mName := StringReplace(mName,' ', '', [rfReplaceAll]);

  {$I AllForms.inc}
end;

function TMainDemoForm.GetLinkedFile(const LinkFile: string): string;
var
  LinkedFile: TStringList;
begin
  LinkedFile := TStringList.Create;
  try
    LinkedFile.LoadFromFile(LinkFile);
    if LinkedFile.Count > 0 then
    begin
      Result := LinkedFile[0];
      exit;
    end;
  finally
    FreeAndNil(LinkedFile);
  end;

  Result:='';
end;

function TMainDemoForm.HasFileToLaunch(const extension: string): string;
var
  aPath, mPath, mName: string;
  fName: string;
begin
  Result := '';
  if (ModulesList.Selected = nil) or (ModulesList.Selected.Data = nil) then exit;
  aPath := TModuleData(ModulesList.Selected.Data).Path;
  mName := ExtractFileName(aPath);
  mPath := IncludeTrailingPathDelimiter(ExtractFilePath(aPath));
  mName := StringReplace(mName,' ', '', [rfReplaceAll]);

  fName := mPath + copy(extension, 2, Length(extension)) + ExtLocation;
  if FileExists(fName) then
  begin
    Result := mPath + GetLinkedFile(fName);
    exit;
  end;

  fName := mPath + mName + extension;
  if FileExists(fName) then
  begin
    Result := fName;
    exit;
  end;

  fName := aPath + extension;
  if FileExists(fName) then
  begin
    Result := fName;
    exit;
  end;

end;

procedure TMainDemoForm.ModulesListDeletion(Sender: TObject; Node: TTreeNode);
begin
  if (Node <> nil) then TObject(Node.Data).Free;
end;

procedure TMainDemoForm.ScanFolder(MainNode: TTreeNode;const MainPath, ModulePath: string);
var
  ChildFolders: TSearchRec;
begin
  if FindFirst(ModulePath + '*', faDirectory, ChildFolders) = 0 then
  begin
    try
      repeat
        if ((ChildFolders.attr and faDirectory) <> 0) and (ChildFolders.Name<>'.') and (ChildFolders.Name <> '..') then
          LoadModule(MainPath, ModulePath, ChildFolders.Name, MainNode);
      until FindNext(ChildFolders) <> 0;
    finally
      FindClose(ChildFolders);
    end;
  end;
end;


procedure TMainDemoForm.LoadModule(const MainPath, ModulePath, ModuleName: string; const Node: TTreeNode);
var
  LinkFile, RelPath, NewPath: string;
  ShortModule: string;
  NewNode: TTreeNode;
begin
  LinkFile := IncludeTrailingPathDelimiter(ModulePath + ModuleName) + 'link.txt';
	if (FileExists(LinkFile)) then
  begin
		RelPath := StringReplace(GetLinkedFile(LinkFile), '\', PathDelim, [rfReplaceAll]);
    NewPath := ExpandFileName(IncludeTrailingPathDelimiter(MainPath) + RelPath);
    if RelPath <> '' then LoadModule(MainPath, ExtractFilePath(NewPath), ExtractFileName(NewPath), Node);
    exit;
  end;

  ShortModule := Copy(ModuleName, pos('.', ModuleName) + 1, Length(ModuleName));
  if (Length(ModuleName) < 1) or (ModuleName[1]='.') then exit; //Do not process hidden folders.
  if (Pos('.',ModuleName) <= 0) then exit; //Do not process folders without the convention xx.name

  NewNode := ModulesList.Items.AddChildObject(Node, ShortModule, GetNodeData(IncludeTrailingPathDelimiter(ModulePath + ModuleName) + ShortModule));

  ScanFolder(NewNode, MainPath, IncludeTrailingPathDelimiter(ModulePath + ModuleName));
end;

function TMainDemoForm.GetNodeData(const Path: string): TModuleData;
begin
  Result := nil;
  if FileExists(Path + '.rtf') then Result := TModuleData.Create(Path);
end;

{ TModuleData }


constructor TModuleData.Create(const aPath: string);
begin
  Path := aPath;
end;

{$IFDEF FPC}
initialization
{$I UMainDemo.lrs}
{$ENDIF}
end.
