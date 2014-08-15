{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppCTDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  SysUtils,
  Classes,
  Controls,
  Forms,
  ComCtrls,
  StdCtrls,
  Buttons,
  ExtCtrls,

  ppTB2Item,
  ppTBX,

  ppClass,
  ppTypes,
  ppUtils,
  ppForms,
  ppDesignerForms,
  ppCtMain,
  ppCTRend,
  ppCTDsgn,
  ppIniStorage,
  ppPopupMenus,
  ppDesignControls,
  ppDesignControlsEx;

type

  {@TppCrossTabDesignerForm }
  TppCrossTabDesignerForm = class(TppCustomCrossTabDesignerForm)
    pnlButtons: TPanel;
    pnlOKCancel: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    sbrStatus: TStatusBar;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

  private
    FCancelClicked: Boolean;
    FCrossTab: TppCrossTab;
    FDesigner: TppCrossTabDesigner;

    procedure LoadStateInfo;
    procedure SaveStateInfo;

  protected
    procedure LanguageChanged; override;

  public
    procedure Initialize; override;

  end; {class, TppCrossTabDesignerForm }


  {@TppCrossTabPopupMenu}
  TppCrossTabPopupMenu = class(TppStretchablePopupMenu)
    private
      procedure RendererMenuClick(Sender: TObject);
      procedure ConfigureMenuClick(Sender: TObject);
      procedure AcrossThenDownMenuClick(Sender: TObject);
      procedure DownThenAcrossMenuClick(Sender: TObject);

    protected
      procedure CreateMenuItems; override;
      procedure DoPopup(Sender: TObject); override;

    public
      procedure Edit;
  end;

  {@TppCrossTabDesignControl}
  TppCrossTabDesignControl = class(TppCustomComponentControl)
  end;



implementation

uses
  Menus;

{$R *.DFM}


{******************************************************************************
 *
 ** C R O S S T A B   D E S I G N E R   F OR M
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.FormCreate }

procedure TppCrossTabDesignerForm.FormCreate(Sender: TObject);
begin

  FCancelClicked := False;

  FDesigner := nil;

end; {procedure, FormCreate}



{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.Initialize }

procedure TppCrossTabDesignerForm.Initialize;
begin
  FDesigner := TppCrossTabDesigner.Create(Self);
  FDesigner.Parent := Self;
  FDesigner.Align := alClient;
  FDesigner.Initialize;

  LoadStateInfo;
end;

{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.FormDestroy }

procedure TppCrossTabDesignerForm.FormDestroy(Sender: TObject);
begin

  FDesigner.Free;

end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.FormClose }

procedure TppCrossTabDesignerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  SaveStateInfo;

  if FCancelClicked then Exit;

  ModalResult := mrOK;

  {transfer new configuration to crosstab}
  if FDesigner.CrossTab.Modified then
    FCrossTab.Assign(FDesigner.CrossTab);

end; {procedure, FormClose}

{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.FormActivate }

procedure TppCrossTabDesignerForm.FormActivate(Sender: TObject);
begin

  if (CrossTab = nil) or not(CrossTab is TppCrossTab) then Exit;

  FCrossTab := TppCrossTab(CrossTab);

  FDesigner.CrossTab := FCrossTab;

end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.btnCancelClick }

procedure TppCrossTabDesignerForm.btnCancelClick(Sender: TObject);
begin
  FCancelClicked := True;
end; {procedure, btnCancelClick}

{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.LoadStateInfo }

procedure TppCrossTabDesignerForm.LoadStateInfo;
var
  lIniStorage: TppIniStorage;
  lScreenRes: TPoint;
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
  liWindowState: Integer;

begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  {calc default screen size }
  lScreenRes := ppGetScreenRes;

  liWidth  := 790;
  liHeight := 600;

  if lScreenRes.X <> 1024 then
    begin
      liWidth  := (liWidth  * lScreenRes.X)  div 1024;
      liHeight := (liHeight * lScreenRes.Y) div 768;
    end;

  {default to center of screen}
  liLeft := (Screen.Width  - liWidth)  div 2;
  liTop  := (Screen.Height - liHeight) div 2;

  liWindowState := lIniStorage.ReadInteger('Crosstab Dialog', 'WindowState', Ord(wsNormal));

  if TWindowState(liWindowState) = wsNormal then
    begin
      liLeft   := lIniStorage.ReadInteger('Crosstab Dialog', 'Left', liLeft);
      liTop    := lIniStorage.ReadInteger('Crosstab Dialog', 'Top', liTop);
      liWidth  := lIniStorage.ReadInteger('Crosstab Dialog', 'Width', liWidth);
      liHeight := lIniStorage.ReadInteger('Crosstab Dialog', 'Height', liHeight);
    end;

  SetBounds(liLeft, liTop, liWidth, liHeight);

  if TWindowState(liWindowState) <> wsMinimized then
    WindowState :=  TWindowState(liWindowState);

  FDesigner.FieldPanel.Width := lIniStorage.ReadInteger('Crosstab Dialog', 'Field List Width', 185);
  FDesigner.DisplayTips := lIniStorage.ReadBool('Crosstab Dialog', 'Tips Visible', True);

  lIniStorage.Free;

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.SaveStateInfo }

procedure TppCrossTabDesignerForm.SaveStateInfo;
var
  lIniStorage: TppIniStorage;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  lIniStorage.WriteInteger('Crosstab Dialog', 'WindowState', Ord(WindowState));

  lIniStorage.WriteInteger('Crosstab Dialog', 'Left', Left);
  lIniStorage.WriteInteger('Crosstab Dialog', 'Top', Top);
  lIniStorage.WriteInteger('Crosstab Dialog', 'Width', Width);
  lIniStorage.WriteInteger('Crosstab Dialog', 'Height', Height);

  lIniStorage.WriteInteger('Crosstab Dialog', 'Field List Width', FDesigner.FieldPanel.Width);
  lIniStorage.WriteBool('Crosstab Dialog', 'Tips Visible', FDesigner.DisplayTips);

  lIniStorage.Free;

end; {procedure, SaveStateInfo}

{------------------------------------------------------------------------------}
{ TppCrossTabDesignerForm.LanguageChanged}

procedure TppCrossTabDesignerForm.LanguageChanged;
begin

  Caption := ppLoadStr(662); {'Configure Crosstab'}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}


{******************************************************************************
 *
 ** C R O S S T A B  P O P U P  M E N U
 *
{******************************************************************************}

procedure TppCrossTabPopupMenu.CreateMenuItems;
var
  lMenuItem: TppTBCustomItem;
  lMenuSubItem: TppTBXItem;
  lRenderers: TStringList;
  liIndex: Integer;
begin

  inherited;

  {paramters: GroupIndex, Name, Caption, StringId}
  AddItem(25, 'Configure', '',  443); {'Configure...'}

  AddSeparator(26, 'ConfigureLine');
  
  AddItem(27, 'Draw', '',  487); {'Draw'}
  AddSubMenuItem(28, 'Pagination', '',  675); {'Pagination'}
  AddItem(30, 'ParentWidth', '',  371);

  lMenuItem := ItemByName('Pagination');

  lMenuSubItem := TppTBXItem.Create(Self);
  lMenuSubItem.Caption := ppLoadStr(676); {'Across then Down'}
  lMenuSubItem.GroupIndex := 1;
  lMenuItem.Add(lMenuSubItem);

  lMenuSubItem := TppTBXItem.Create(self);
  lMenuSubItem.Caption := ppLoadStr(677); {'Down then Across'}
  lMenuSubItem.GroupIndex := 1;
  lMenuItem.Add(lMenuSubItem);

  if (ppRegisteredRendererCount > 1) then
    begin
      lMenuItem := AddSubMenuItem(30, 'Style', '',  634); {'Style'}

      lRenderers := TStringList.Create;

      ppGetRendererClasses(lRenderers);

      for liIndex := 0 to lRenderers.Count - 1 do
        begin
          lMenuSubItem := TppTBXItem.Create(lMenuItem);
          lMenuSubItem.Caption := TppCrossTabRendererClass(lRenderers.Objects[liIndex]).LocalizedDescription;
          lMenuSubItem.GroupIndex := 3;
          {store the class reference in the Tag}
          lMenuSubItem.Tag := Integer(lRenderers.Objects[liIndex]);

          lMenuItem.Add(lMenuSubItem);
        end;

      lRenderers.Free;
    end;

end;

procedure TppCrossTabPopupMenu.DoPopup(Sender: TObject);
var
  lMenuItem: TppTBXItem;
  lRenderers: TStringList;
  liIndex: Integer;
  lPagination: TppCrossTabPaginationType;
  lsStyle: String;
begin

  inherited;

  {assign menu item event handlers, hide configure menu option if no designer registered}
  if ppGetFormClass(TppCustomCrossTabDesignerForm) <> nil then
    ItemByName('Configure').OnClick := ConfigureMenuClick
  else
   ItemByName('Configure').Visible := False;

  lMenuItem := ItemByName('Pagination');

  lMenuItem.Checked := False;

  lMenuItem.Items[0].OnClick := AcrossThenDownMenuClick;
  lMenuItem.Items[1].OnClick := DownThenAcrossMenuClick;

  GetPropValue('Pagination', lPagination);

  if (lPagination = ctptAcrossThenDown) then
    lMenuItem.Items[0].Checked := True
  else
    lMenuItem.Items[1].Checked := True;


  if (ppRegisteredRendererCount > 1) then
    begin
      lMenuItem := ItemByName('Style');

      lRenderers := TStringList.Create;

      ppGetRendererClasses(lRenderers);

      for liIndex := 0 to lRenderers.Count - 1 do
        begin
          lMenuItem.Items[liIndex].OnClick := RendererMenuClick;

          GetPropValue('Style', lsStyle);

          if (TppCrossTabRendererClass(lRenderers.Objects[liIndex]).Description = lsStyle) then
            lMenuItem.Items[liIndex].Checked := True;

        end;

      lRenderers.Free;
    end;

end;

{------------------------------------------------------------------------------}
{ TppCrossTabPopupMenu.ConfigureMenuClick }

procedure TppCrossTabPopupMenu.ConfigureMenuClick(Sender: TObject);
begin
  Edit;

end;

{------------------------------------------------------------------------------}
{ TppCrossTabPopupMenu.Edit }

procedure TppCrossTabPopupMenu.Edit;
var
  lDialogClass: TFormClass;
  lDialog: TppCustomCrossTabDesignerForm;
begin

  lDialogClass := ppGetFormClass(TppCustomCrossTabDesignerForm);

  lDialog := TppCustomCrossTabDesignerForm(lDialogClass.Create(Application));
  lDialog.Initialize;

  lDialog.CrossTab := Component;
  lDialog.Report := Component.Report;
  lDialog.LanguageIndex := LanguageIndex;

  if (Component <> nil) and (Component.Report <> nil) and not(Component.Report.MainReport.Icon.Empty) then
    lDialog.Icon := Component.Report.MainReport.Icon;

  lDialog.ShowModal;

  lDialog.Free;

end; {procedure, Edit}

{------------------------------------------------------------------------------}
{ TppCrossTabPopupMenu.RendererMenuClick }

procedure TppCrossTabPopupMenu.RendererMenuClick(Sender: TObject);
var
  lClass: TppCrossTabRendererClass;
  lsDescription: String;
begin

  lClass :=  TppCrossTabRendererClass(TMenuItem(Sender).Tag);
  lsDescription := lClass.Description;

  SetPropValue('Style', lsDescription);

end;

{------------------------------------------------------------------------------}
{ TppCrossTabPopupMenu.AcrossThenDownMenuClick }

procedure TppCrossTabPopupMenu.AcrossThenDownMenuClick(Sender: TObject);
var
  lPagination: TppCrossTabPaginationType;
begin

  lPagination := ctptAcrossThenDown;

  SetPropValue('Pagination', lPagination);

end;

{------------------------------------------------------------------------------}
{ TppCrossTabPopupMenu.DownThenAcrossMenuClick }

procedure TppCrossTabPopupMenu.DownThenAcrossMenuClick(Sender: TObject);
var
  lPagination: TppCrossTabPaginationType;
begin

  lPagination := ctptDownThenAcross;

  SetPropValue('Pagination', lPagination);

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  TppDesignControlFactory.RegisterDesignControlClass(TppCrossTab, TppCrossTabDesignControl);
  TppPopupMenuManager.RegisterMenuClass(TppCrossTab, TppCrossTabPopupMenu);

  ppRegisterForm(TppCustomCrossTabDesignerForm, TppCrossTabDesignerForm);

finalization

  TppDesignControlFactory.UnRegisterDesignControlClass(TppCrossTab);
  TppPopupMenuManager.UnRegisterMenuClass(TppCrossTab);
  ppUnRegisterForm(TppCustomCrossTabDesignerForm);

end.
