unit fMain;

{$I ASCRIPT.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus,
  IDEMain, atScript, atScripter, IDEDialog,


  ap_Sysutils, ap_Classes, ap_Graphics, ap_Controls, ap_Forms, ap_Dialogs,

  ap_StdCtrls, ap_Windows, ap_System,
  ap_ExtCtrls, ap_ComCtrls, ap_Menus, ap_Buttons,
  ap_ImgList,
    
  {$IFDEF DELPHI9_LVL}
  XPMan,
  {$ENDIF}
  StdCtrls;

type
  TForm1 = class(TForm)
    IDEDialog1: TIDEDialog;
    IDEScripter1: TIDEScripter;
    IDEEngine1: TIDEEngine;
    PopupMenu1: TPopupMenu;
    TMSScripterStudioProWebSite1: TMenuItem;
    TMSScripterStudioPro1: TMenuItem;
    TMSSoftwareWebSite1: TMenuItem;
    TMSScripterStudioProSupport1: TMenuItem;
    N1: TMenuItem;
    About1: TMenuItem;
    ContactUsemail1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TMSScripterStudioProWebSite1Click(Sender: TObject);
    procedure TMSSoftwareWebSite1Click(Sender: TObject);
    procedure TMSScripterStudioProSupport1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ContactUsemail1Click(Sender: TObject);
  private
    procedure OnCreateEditor(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses imglist, ShellApi, fIDEEditor,
  IDERegDBPalette, IDERegAdoPalette;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ForceCurrentDirectory := true;

  IDERegisterDataAccessTab(IDEEngine1);
  IDERegisterDataControlsTab(IDEEngine1);
  IDERegisterADOTab(IDEEngine1);
  Application.ShowMainForm := false;
  IDEDialog1.OnCreateIDEForm := OnCreateEditor;
  IDEDialog1.Execute;
  Application.Terminate;
end;

procedure TForm1.OnCreateEditor(Sender: TObject);
var
  AMenu: TMainMenu;
  AItem: TMenuItem;                                                        
  ASubItem: TMenuItem;
  c: integer;
  AOldImages: TCustomImageList;
begin
  {This callback event is only used to add an About options in the menu}
  if Sender is TForm then
  begin
    {Create about menu and "migrate" all items from popup to the about}
    AMenu := TIDEEditorForm(Sender).MainMenu1;

    AOldImages := AMenu.Images; //visual workaround
    AMenu.Images := nil;
    AItem := TMenuItem.Create(AMenu.Owner);
    AItem.Caption := 'About';
    AMenu.Items.Add(AItem);
    for c := 0 to PopupMenu1.Items.Count - 1 do
    begin
      ASubItem := TMenuItem.Create(AMenu.Owner);
      ASubItem.Caption := PopupMenu1.Items[c].Caption;
      ASubItem.OnClick := PopupMenu1.Items[c].OnClick;
      AItem.Add(ASuBItem);
    end;
    AMenu.Images := AOldImages;
  end;
end;

procedure TForm1.TMSScripterStudioProWebSite1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('http://www.tmssoftware.com/go?scriptstudiopro'), nil, nil, SW_NORMAL);
end;

procedure TForm1.TMSSoftwareWebSite1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('http://www.tmssoftware.com'), nil, nil, SW_NORMAL);
end;

procedure TForm1.TMSScripterStudioProSupport1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('http://www.tmssoftware.com/site/support.asp'), nil, nil, SW_NORMAL);
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  ShowMessage(
    'TMS Scripter Studio Pro'#13#10#13#10+
    'http://www.tmssoftware.com/go?scriptstudiopro'#13#10+
    'E-mail: info@tmssoftware.com'#13#10+
    '(c) 1997-2008 tmssoftware.com');
end;

procedure TForm1.ContactUsemail1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('mailto:info@tmssoftware.com?subject=Scripter Studio Pro Question'), nil, nil, SW_NORMAL);
end;

end.
