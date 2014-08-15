unit UTemplateEdit;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}

interface
  {$IFDEF FLX_CANDISABLEWARNINGS}  //Delphi 6 or above
    {$WARN UNIT_PLATFORM OFF}
  {$ENDIF}

uses
  SysUtils, Classes,
  {$IFDEF FLX_VCL}
  Forms, Dialogs, StdCtrls, ActnList, ImgList, ComCtrls, FileCtrl, ExtCtrls, Controls,
  {$ENDIF}
  {$IFDEF FLX_CLX}
  QForms, QDialogs, QStdCtrls, QActnList, QImgList, QComCtrls, QExtCtrls, QControls,
  {$ENDIF}

  {$IFDEF FLX_FPC}
  LResources,
  {$ENDIF}
  TemplateStore, UFlxMessages;

type
  TTemplateEdit = class(TForm)
    ToolBar1: TToolBar;
    btnOk: TToolButton;
    btnCancel: TToolButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ActionList1: TActionList;
    ActionOk: TAction;
    ActionSaveAs: TAction;
    ActionRefresh: TAction;
    ActionAdd: TAction;
    ActionDelete: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    Files: TListView;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    FormCaption: TPanel;
    procedure ActionOkExecute(Sender: TObject);
    procedure ActionAddExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure ActionDeleteUpdate(Sender: TObject);
    procedure ActionRefreshExecute(Sender: TObject);
    procedure ActionSaveAsUpdate(Sender: TObject);
    procedure ActionSaveAsExecute(Sender: TObject);
  private
    TStore: TXLSTemplateStore;

    procedure RefreshList;
    { Private declarations }
  public
    Modified: boolean;
    procedure LoadData(const aTStore: TXLSTemplateStore);
    constructor Create(AOwner: TComponent); override;

    { Public declarations }
  end;

  procedure InvokeTemplateEditor(const aTStore: TXLSTemplateStore; out Modified: boolean);
  procedure RefreshTemplateStore(const aTStore: TXLSTemplateStore; out Modified: boolean);

implementation
procedure InvokeTemplateEditor(const aTStore: TXLSTemplateStore; out Modified: boolean);
var
  TemplateEdit: TTemplateEdit;
  OldCursor: TCursor;
begin
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  try
    TemplateEdit:= TTemplateEdit.Create(nil);
    try
      TemplateEdit.LoadData(aTStore);
      TemplateEdit.ShowModal;
      Modified:= TemplateEdit.Modified;
    finally
      FreeAndNil(TemplateEdit);
    end;
  finally
    Screen.Cursor:=OldCursor;
  end; //finally
end;

procedure RefreshTemplateStore(const aTStore: TXLSTemplateStore; out Modified: boolean);
var
  i: integer;
    {$IFDEF ConditionalExpressions}
      {$IFDEF FLX_CLX}
        {$if CompilerVersion > 14}Directory: WideString;{$IFEND} //Kylix 3 or above
        {$if CompilerVersion <= 14}Directory: String;{$IFEND} //Kylix 2
      {$ELSE}
        Directory: string; //Delphi 6/7
      {$ENDIF}
    {$ELSE}
      Directory: string; //Delphi 5
    {$ENDIF}
begin
  Modified := false;
  if aTStore.Templates.Count<=0 then exit;

  Directory:=aTStore.RefreshPath;
  if (aTStore.RefreshPath='')or
  (not FileExists(IncludeTrailingPathDelimiter(Directory)+aTStore.Templates[0].FileName)) then
  begin
    if not SelectDirectory(TxtRefreshTemplate,'', Directory) then exit;
    aTStore.RefreshPath:=Directory;
  end;

  Directory:=IncludeTrailingPathDelimiter(Directory);

  for i:=0 to aTStore.Templates.Count-1 do
  begin
    aTStore.Templates[i].FileName:=Directory+aTStore.Templates[i].FileName;
  end;
  Modified:=true;
end;

{$IFNDEF FLX_FPC}
  {$IFDEF FLX_VCL}
    {$R *.dfm}
  {$ENDIF}
  {$IFDEF FLX_CLX}
    {$R *.xfm}
  {$ENDIF}
{$ENDIF}

{ TTemplateEdit }

procedure TTemplateEdit.RefreshList;
var
  i: integer;
  Li: TListItem;
begin
{$IFNDEF FLX_FPC}
  Files.Items.BeginUpdate;
{$ENDIF}
  try
    Files.Items.Clear;
    for i:=0 to TStore.Templates.Count-1 do
    begin
      Li:=Files.Items.Add;
      Li.Caption:=IntToStr(TStore.Templates[i].Index)+' - '+TStore.Templates[i].FileName;
      Li.Data:=TStore.Templates[i];
      Li.ImageIndex:=1;
    end;
  finally
{$IFNDEF FLX_FPC}
    Files.Items.EndUpdate;
{$ENDIF}
  end; //finally
end;

procedure TTemplateEdit.LoadData(const aTStore: TXLSTemplateStore);
begin
  Modified:=false;
  TStore:=aTStore;
  FormCaption.Caption:=Format(TxtEditing,[TStore.Name]);
  RefreshList;
end;

procedure TTemplateEdit.ActionOkExecute(Sender: TObject);
begin
  Close;
end;

procedure TTemplateEdit.ActionAddExecute(Sender: TObject);
var
  NewTemplate: TXlsTemplate;
  idx, i: integer;
begin
  if OpenDialog.Execute then
  begin
    if Files.Selected<>nil then idx:= Files.Selected.Index else idx:=Files.Items.Count;
    for i:=OpenDialog.Files.Count-1 downto 0 do
    begin
      NewTemplate:=(TStore.Templates.Insert(idx) as TXlsTemplate);
      try
        NewTemplate.FileName:= OpenDialog.Files[i];
      except
        TStore.Templates.Delete(idx);
        raise;
      end; //Except
    end;
    Modified:=true;
    RefreshList;
    Files.Selected:=Files.Items[idx];
  end;
end;


procedure TTemplateEdit.ActionDeleteExecute(Sender: TObject);
var
  idx: integer;
begin
  if Files.Selected<>nil then
  begin
    idx:=Files.Selected.Index;
    TStore.Templates.Delete(TXlsTemplate(Files.Selected.Data).Index);
    Modified:=true;
    RefreshList;
    if Files.Items.Count>idx then
    begin
      Files.Selected:=Files.Items[idx];
      Files.Items[idx].Focused:=true;
    end;
  end;
end;

procedure TTemplateEdit.ActionDeleteUpdate(Sender: TObject);
begin
  ActionDelete.Enabled:=Files.Selected<>nil;
end;

procedure TTemplateEdit.ActionRefreshExecute(Sender: TObject);
begin
  RefreshTemplateStore(TStore, Modified);
end;

procedure TTemplateEdit.ActionSaveAsUpdate(Sender: TObject);
begin
  ActionSaveAs.Enabled:=Files.Selected<>nil;
end;


constructor TTemplateEdit.Create(AOwner: TComponent);
begin
  inherited;
  {$IFDEF FLX_FIX_PARENTBACKGROUND}
  FormCaption.ParentBackground := false; //workarounds a bug in delphi.
  {$ENDIF}
end;

procedure TTemplateEdit.ActionSaveAsExecute(Sender: TObject);
begin
  if Files.Selected=nil then exit;
  SaveDialog.FileName:=TXlsTemplate(Files.Selected.Data).FileName;
  if not SaveDialog.Execute then exit;
  if FileExists(SaveDialog.FileName) then DeleteFile(SaveDialog.FileName);
  TXlsTemplate(Files.Selected.Data).SaveAs(SaveDialog.FileName);
end;

{$IFDEF FLX_FPC}
initialization
{$I UTemplateEdit.lrs}
{$ENDIF}
end.

