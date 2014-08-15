unit fToolPalette;

interface

{$I ASCRIPT.INC}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, CategoryButtons, IDEMain, ActnList, ComCtrls, ToolWin,
  {$IFDEF THEMED_IDE}
  AdvToolbar, AdvGlowButton, AdvToolBarStylers, AdvStyleIF, AdvAppStyler,  
  {$ENDIF}
  ImgList, Menus;

type
  {$IFDEF THEMED_IDE}
  TfmToolPalette = class(TForm, ITMSStyle)
  {$ELSE}
  TfmToolPalette = class(TForm)
  {$ENDIF}
    FPaletteButtons: TIDEPaletteButtons;
    PopupMenu1: TPopupMenu;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ActionList1: TActionList;
    acCancelPlacing: TAction;
    ToolButton4: TToolButton;
    acFilter: TAction;
    procedure acCancelPlacingExecute(Sender: TObject);
    procedure acCancelPlacingUpdate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure acFilterExecute(Sender: TObject);
    procedure acFilterUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolBar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    {$IFDEF THEMED_IDE}
    FTMSBar: TAdvToolBar;
    FTMSToolbarStyler: TAdvToolBarOfficeStyler;
    FTMSFormStyler: TAdvFormStyler;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    {$ENDIF}
    procedure SetEngine(const Value: TIDEEngine);
    function GetEngine: TIDEEngine;
    procedure MenuItemClick(Sender: TObject);
  protected
  public
    { Public declarations }
    property Engine: TIDEEngine read GetEngine write SetEngine;
  end;

var
  fmToolPalette: TfmToolPalette;

implementation

{$R *.dfm}

{ TfmToolPalette }

procedure TfmToolPalette.acCancelPlacingExecute(Sender: TObject);
begin
  Engine.Designer.CancelPlacing;
end;

procedure TfmToolPalette.acCancelPlacingUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (Engine <> nil) and (Engine.Designer <> nil);
  TAction(Sender).Checked := TAction(Sender).Enabled and
    (Engine.Designer.PlacedComponentClass = nil);
end;

procedure TfmToolPalette.acFilterExecute(Sender: TObject);
begin
  FPaletteButtons.Filter := '';
  FPaletteButtons.Filtered := not FPaletteButtons.Filtered;
  if FPaletteButtons.Filtered and FPaletteButtons.CanFocus then
    FPaletteButtons.SetFocus;
end;

procedure TfmToolPalette.acFilterUpdate(Sender: TObject);
begin
  acFilter.Checked := FPaletteButtons.Filtered;
end;

procedure TfmToolPalette.FormCreate(Sender: TObject);
{$IFDEF THEMED_IDE}
var
  TMSButton: TAdvGlowButton;
{$ENDIF}
begin
  {$IFDEF THEMED_IDE}
  {Create toolbar}
  FTMSFormStyler := TAdvFormStyler.Create(Self);

  FTMSToolbarStyler := TAdvToolBarOfficeStyler.Create(Self);

  FTMSBar := TAdvToolBar.Create(Self);
  FTMSBar.Images := ImageList1;
  FTMSBar.Parent := Self;
  FTMSBar.Align := alTop;
  FTMSBar.ShowOptionIndicator := false;
  FTMSBar.ShowRightHandle := false;
  FTMSBar.ToolBarStyler := FTMSToolbarStyler;
  FTMSBar.FullSize := true;

  {Create filter button}
  TMSButton := TAdvGlowButton.Create(FTMSBar);
  TMSButton.ImageIndex := 0;
  TMSButton.OnClick := ToolButton1Click;
  TMSButton.DropDownMenu := PopupMenu1;
  TMSButton.AutoSize := true;
  TMSButton.ShowCaption := false;
  TMSButton.Transparent := true;
  TMSButton.DropDownButton := true;
  TMSButton.Images := ImageList1;
  FTMSBar.AddToolBarControl(TMSButton);

  {Create cancel placement button}
  TMSButton := TAdvGlowButton.Create(FTMSBar);
  TMSButton.Action := acCancelPlacing;
  TMSButton.AutoSize := true;
  TMSButton.ShowCaption := false;
  TMSButton.Transparent := true;
  FTMSBar.AddToolBarControl(TMSButton);

  FTMSBar.AddToolBarControl(TAdvToolBarSeparator.Create(FTMSBar));

  {Create filter button}
  TMSButton := TAdvGlowButton.Create(FTMSBar);
  TMSButton.Action := acFilter;
  TMSButton.AutoSize := true;
  TMSButton.ShowCaption := false;
  TMSButton.Transparent := true;
  FTMSBar.AddToolBarControl(TMSButton);

  Toolbar1.Visible := false;
  {$ENDIF}
end;

procedure TfmToolPalette.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    Ord('a')..Ord('z'), Ord('A')..Ord('Z'):
      begin
        if not FPaletteButtons.Filtered then
        begin
          FPaletteButtons.Filter := '';
          FPaletteButtons.Filtered := true;
        end;
        FPaletteButtons.Filter := FPaletteButtons.Filter + chr(Key);
      end;
    VK_BACK:
      begin
        if FPaletteButtons.Filtered then
          FPaletteButtons.Filter := Copy(FPaletteButtons.Filter, 1, Length(FPaletteButtons.Filter) - 1);
      end;
    VK_ESCAPE:
      begin
        FPaletteButtons.Filtered := false;
        FPaletteButtons.Filter := '';
      end;
    VK_RETURN:
      begin
        if (Engine <> nil) and (Engine.Designer <> nil) then
          Engine.Designer.AutoPlaceComponent;
      end;
  end;
end;

function TfmToolPalette.GetEngine: TIDEEngine;
begin
  result := FPaletteButtons.Engine;
end;

{$IFDEF THEMED_IDE}
procedure TfmToolPalette.SetComponentStyle(AStyle: TTMSStyle);
begin
  FTMSFormStyler.Style := AStyle;
  FTMSToolbarStyler.DragGripStyle := dsNone;
end;
{$ENDIF}

procedure TfmToolPalette.SetEngine(const Value: TIDEEngine);

  procedure AddMenuItem(ACaption: string; AIndex: integer);
  var
    MI: TMenuItem;
  begin
    MI := TMenuItem.Create(PopupMenu1);
    MI.Caption := ACaption;
    MI.OnClick := MenuItemClick;
    MI.Tag := AIndex;
    PopupMenu1.Items.Add(MI);
  end;

var
  c: integer;
begin
  FPaletteButtons.Engine := Value; 

  {Populate menu items}
  PopupMenu1.Items.Clear;
  for c := 0 to FPaletteButtons.Categories.Count - 1 do
    AddMenuItem(FPaletteButtons.Categories[c].Caption, c);
end;

procedure TfmToolPalette.ToolBar1Click(Sender: TObject);
begin
  if FPaletteButtons.CanFocus then
    FPaletteButtons.SetFocus;
end;

procedure TfmToolPalette.ToolButton1Click(Sender: TObject);
begin
  PopupMenu1.Popup(ToolButton1.ClientToScreen(Point(0, 0)).X,
    ToolButton1.ClientToScreen(Point(0, ToolButton1.Height)).Y);
end;

procedure TfmToolPalette.MenuItemClick(Sender: TObject);
begin
  FPaletteButtons.ScrollIntoView(FPaletteButtons.Categories[TMenuItem(Sender).Tag]);
end;

end.
