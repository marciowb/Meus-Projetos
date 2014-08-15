unit fObjectInspector;

{$I ASCRIPT.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, InspectorControls, ComponentInspector, IDEMain, ComCtrls,
  {$IFDEF DELPHI7_LVL}
  Themes,
  {$ENDIF}
  {$IFDEF THEMED_IDE}
  AdvOfficeTabSetStylers, AdvOfficeTabSet, AdvToolbar, AdvGlowButton,
  AdvToolBarStylers, AdvAppStyler, AdvStyleIF, 
  {$ENDIF}
  ExtCtrls;

type
  {$IFDEF THEMED_IDE}
  TfmObjectInspector = class(TForm, ITMSStyle)
  {$ELSE}
  TfmObjectInspector = class(TForm)
  {$ENDIF}
    TabControl1: TTabControl;
    IDEInspector: TIDEInspector;
    TopPanel: TPanel;
    IDEComponentCombo: TIDEComponentComboBox;
    procedure TopPanelResize(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IDEInspectorUpdate(Sender: TObject);
  private
    FUpdatingTab: boolean;
    {$IFDEF THEMED_IDE}
    FTMSFormStyler: TAdvFormStyler;
    FTMSTabStyler: TAdvOfficeTabSetOfficeStyler;
    FTMSTabSet: TAdvOfficeTabSet;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    {$ENDIF}
    function GetEngine: TIDEEngine;
    procedure SetEngine(const Value: TIDEEngine);
    { Private declarations }
  public
    property Engine: TIDEEngine read GetEngine write SetEngine;
  end;

implementation

{$R *.DFM}

procedure TfmObjectInspector.TopPanelResize(Sender: TObject);
begin
  IDEComponentCombo.Width := TopPanel.Width - 4;
end;

procedure TfmObjectInspector.TabControl1Change(Sender: TObject);
begin
  FUpdatingTab := true;
  try
    {$IFDEF THEMED_IDE}
    IDEInspector.Mode := TCompInspMode(FTMSTabSet.ActiveTabIndex);
    {$ELSE}
    IDEInspector.Mode := TCompInspMode(TabControl1.TabIndex);
    {$ENDIF}
  finally
    FUpdatingTab := false;
  end;
end;

procedure TfmObjectInspector.FormCreate(Sender: TObject);
begin
  {$IFDEF DELPHI7_LVL}
  if ThemeServices.ThemesEnabled then
    IDEInspector.Color := clWhite;
  {$ENDIF}

  {$IFDEF THEMED_IDE}
  FTMSFormStyler := TAdvFormStyler.Create(Self);

  FTMSTabStyler := TAdvOfficeTabSetOfficeStyler.Create(Self);
  FTMSTabSet := TAdvOfficeTabSet.Create(Self);
  FTMSTabSet.Parent := Self;
  FTMSTabSet.Align := alTop;
  FTMSTabSet.Height := 26;
  FTMSTabSet.AdvOfficeTabSetStyler := FTMSTabStyler;
  while TabControl1.ControlCount > 0 do
    TabControl1.Controls[0].Parent := Self;
  TabControl1.Visible := false;
  FTMSTabSet.AdvOfficeTabs.Clear;
  FTMSTabSet.AdvOfficeTabs.Add.Caption := TabControl1.Tabs[0];
  FTMSTabSet.AdvOfficeTabs.Add.Caption := TabControl1.Tabs[1];
  FTMSTabSet.ActiveTabIndex := 0;
  FTMSTabSet.OnChange := TabControl1Change;

  IDEInspector.ParentColor := true;
  {$ENDIF}
end;

function TfmObjectInspector.GetEngine: TIDEEngine;
begin
  result := IDEInspector.Engine;
end;

procedure TfmObjectInspector.IDEInspectorUpdate(Sender: TObject);
begin
  if not FUpdatingTab then
  begin
    {$IFDEF THEMED_IDE}
    if FTMSTabSet.ActiveTabIndex <> Ord(IDEInspector.Mode) then
      FTMSTabSet.ActiveTabIndex := ord(IDEInspector.Mode);
    {$ELSE}
    if TabControl1.TabIndex <> Ord(IDEInspector.Mode) then
      TabControl1.TabIndex := ord(IDEInspector.Mode);
    {$ENDIF}
  end;
end;

{$IFDEF THEMED_IDE}
procedure TfmObjectInspector.SetComponentStyle(AStyle: TTMSStyle);
begin
  FTMSFormStyler.Style := AStyle;
  case AStyle of
    tsOffice2003Blue:
      begin
        Color := $00FDEADA;
      end;
    tsOffice2003Silver:
      begin
        Color := $00ECE2E1;
      end;
    tsOffice2003Olive:
      begin
        Color := $00CFF0EA;
      end;
    tsOffice2003Classic:
      begin
        Color := clWhite;
      end;
    tsOffice2007Luna:
      begin
        Color := $00FAF1E9;
      end;
    tsOffice2007Obsidian:
      begin
        Color := $00ECECE5;
      end;
    tsWindowsXP:
      begin
        Color := clBtnFace;
      end;
    tsWhidbey:
      begin
        Color := clWhite;
      end;
    tsOffice2007Silver:
      begin
        Color := $00F9F5F3;
      end;
  end;
end;
{$ENDIF}

procedure TfmObjectInspector.SetEngine(const Value: TIDEEngine);
begin
  IDEInspector.Engine := Value;
  IDEComponentCombo.Engine := Value;
end;

end.
