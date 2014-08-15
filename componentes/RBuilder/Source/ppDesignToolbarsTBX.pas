{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignToolbarsTBX;

{x$Define CodeSite}

{$I ppIfDef.pas}

interface

uses
  {$IFDEF CodeSite} rsCodeSite,{$ENDIF}
  TypInfo,
  Classes,
  SysUtils,
  Graphics,
  Controls,

  ppTypes,
  ppUtils,
  ppRTTI,
  ppIniStorage,

  ppTB2Item,
  ppTB2Toolbar,

  ppTBX,
  ppTBXExtItems,

  ppToolbarTBX,

  ppDesignToolbar,
  ppDesignToolActions,
  ppToolResources,
  ppDesignToolItemsTBX;

type


  {@TppAlignToolbar}
  TppAlignToolbar = class(TppDesignToolbar)
  private
  
  protected
    procedure CreateItems; override;

  public
    constructor Create(aOwner: TComponent); override;

    procedure LanguageChanged; override;

  end; {class, TppAlignToolbar}


  {TppSizeToolbar}
  TppSizeToolbar = class(TppDesignToolbar)
  private
  protected
    procedure CreateItems; override;

  public
    constructor Create(aOwner: TComponent); override;

    procedure LanguageChanged; override;

  end;


  {@TppNudgeToolbar}
  TppNudgeToolbar = class(TppDesignToolbar)
  private
  protected
    procedure CreateItems; override;

  public
    constructor Create(aOwner: TComponent); override;

    procedure LanguageChanged; override;

  end; {class, TppNudgeToolbar}


  {TppDrawToolbar}
  TppDrawToolbar = class(TppDesignToolbar)
  private
    FFillColorButton: TppColorPaletteButton;
    FGradientButton: TppGradientPaletteButton;
    FLineColorButton: TppColorPaletteButton;
    FLineStyleButton: TppLineStylePaletteButton;
    FLineThicknessButton: TppLineThicknessPaletteButton;

  protected
    procedure CreateItems; override;

  public
    constructor Create(aOwner: TComponent); override;
    procedure LanguageChanged; override;
    property FillColorButton: TppColorPaletteButton read FFillColorButton;
    property LineColorButton: TppColorPaletteButton read FLineColorButton;
    property LineStyleButton: TppLineStylePaletteButton read FLineStyleButton;
    property LineThicknessButton: TppLineThicknessPaletteButton read FLineThicknessButton;

  published
    property GradientButton: TppGradientPaletteButton read FGradientButton;
  end;

  {TppEditToolbar}
  TppEditToolbar = class(TppDesignToolbar)
  private
    FComboBox: TppDesignComboBoxToolItem;
    FComboBox2: TppDesignComboBoxToolItem;
    FEditBox: TppDesignEditToolItem;
    FEnabledControl: TObject;

  protected
    procedure CreateItems; override;
    procedure ehEditBox_Change(Sender: TObject; const aText: String);

  public
    constructor Create(aOwner: TComponent); override;
    procedure EnableControl(aItem: TObject);

    procedure LanguageChanged; override;

    property ComboBox: TppDesignComboBoxToolItem read FComboBox;
    property ComboBox2: TppDesignComboBoxToolItem read FComboBox2;
    property EditBox: TppDesignEditToolItem read FEditBox;


  end;

  {TppStandardToolbar}
  TppStandardToolbar = class(TppDesignToolbar)
  private
    FCopyButton: TppTBXItem;
    FCutButton: TppTBXItem;
    FFileNewButton: TppTBXItem;
    FFileOpenButton: TppTBXItem;
    FFileSaveButton: TppTBXItem;
    FPageSetupButton: TppTBXItem;
    FPasteButton: TppTBXItem;
    FPrintButton: TppTBXItem;
    FPrintPreviewButton: TppTBXItem;
    FSeparator1: TppTBXSeparatorItem;
    FSeparator2: TppTBXSeparatorItem;

  protected
    procedure CreateItems; override;

  public

    constructor Create(aOwner: TComponent); override;
    procedure LanguageChanged; override;

    property CopyButton: TppTBXItem read FCopyButton;
    property CutButton: TppTBXItem read FCutButton;
    property FileNewButton: TppTBXItem read FFileNewButton;
    property FileOpenButton: TppTBXItem read FFileOpenButton;
    property FileSaveButton: TppTBXItem read FFileSaveButton;
    property Separator1: TppTBXSeparatorItem read FSeparator1;
    property PageSetupButton: TppTBXItem read FPageSetupButton;
    property PasteButton: TppTBXItem read FPasteButton;
    property PrintButton: TppTBXItem read FPrintButton;
    property PrintPreviewButton: TppTBXItem read FPrintPreviewButton;
    property Separator2: TppTBXSeparatorItem read FSeparator2;

  end;

  {TppCustomFormatToolbar}
  TppCustomFormatToolbar = class(TppDesignToolbar)
  private
    FAlignLeftButton: TppTBXItem;
    FAlignRightButton: TppTBXItem;
    FBoldButton: TppTBXItem;
    FCenterButton: TppTBXItem;
    FFontColorButton: TppColorPaletteButton;
    FFontComboBox: TppFontNameToolItem;
    FFontSizeComboBox: TppTBXComboBoxItem;
    FFullJustifyButton: TppTBXItem;
    FHighlightColorButton: TppColorPaletteButton;
    FItalicButton: TppTBXItem;
    FUnderlineButton: TppTBXItem;
    
    function GetAlignment: TAlignment;
    procedure SetAlignment(aAlignment: TAlignment);

  protected
    procedure CreateItems; override;

  public
    procedure LanguageChanged; override;

    property AlignLeftButton: TppTBXItem read FAlignLeftButton;
    property Alignment: TAlignment read GetAlignment write SetAlignment;
    property AlignRightButton: TppTBXItem read FAlignRightButton;
    property BoldButton: TppTBXItem read FBoldButton;
    property CenterButton: TppTBXItem read FCenterButton;
    property FontColorButton: TppColorPaletteButton read FFontColorButton;
    property FontComboBox: TppFontNameToolItem read FFontComboBox;
    property FontSizeComboBox: TppTBXComboBoxItem read FFontSizeComboBox;
    property FullJustifyButton: TppTBXItem read FFullJustifyButton;
    property HighlightColorButton: TppColorPaletteButton read FHighlightColorButton;
    property ItalicButton: TppTBXItem read FItalicButton;
    property UnderlineButton: TppTBXItem read FUnderlineButton;

  end;

  {TppFormatToolbar}
  TppFormatToolbar = class(TppCustomFormatToolbar)
  private
    FAnchorsButton: TppAnchorsPaletteButton;
    FBringToFrontButton: TppTBXItem;
    FBorderButton: TppBorderPaletteButton;
    FBringForwardButton: TppTBXItem;
    FSendToBackButton: TppTBXItem;
    FSendBackwardButton: TppTBXItem;

  protected
    procedure CreateItems; override;

  public
    constructor Create(aOwner: TComponent); override;

    procedure LanguageChanged; override;
    property AnchorsButton: TppAnchorsPaletteButton read FAnchorsButton;
    property BringToFrontButton: TppTBXItem read FBringToFrontButton;
    property BorderButton: TppBorderPaletteButton read FBorderButton;
    property BringForwardButton: TppTBXItem read FBringForwardButton;
    property SendToBackButton: TppTBXItem read FSendToBackButton;
    property SendBackwardButton: TppTBXItem read FSendBackwardButton;

  end;




implementation


{******************************************************************************
 *
 **  A l i g n  T o o l b a r
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAlignToolbar.Create}

constructor TppAlignToolbar.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  Name := 'Align';  // do not localize

  Images := ToolImageList;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppAlignToolbar.CreateControls}

procedure TppAlignToolbar.CreateItems;
var
  liIndex: Integer;
  lButton: TppTBXItem;
begin

  if (ActionList = nil) then
    raise EDesignError.Create('TppAlignToolbar.CreateItems: ActionList must be assigned');

  BeginUpdate;

  Caption := ppLoadStr(484); {'Align or Space'}

  for liIndex := 0 to ActionList.ActionCount-1 do
    begin

      lButton := AddButton();
      lButton.Name := cAlignNames[liIndex];
      lButton.Action := ActionList.Actions[liIndex];

      // add separator, if needed
      if (liIndex = 2) or (liIndex = 5) or (liIndex = 7) then
        AddSeparator();


    end;

  EndUpdate;


end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TppAlignToolbar.LanguageChanged}

procedure TppAlignToolbar.LanguageChanged;
begin

  Caption := ppLoadStr(484); {'Align or Space'}


end;

{******************************************************************************
 *
 **  S i z e  T o o l b a r
 *
{******************************************************************************}

{ TppSizeToolbar }


constructor TppSizeToolbar.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Size';  // do not localize

  Images := ToolImageList;

end;


procedure TppSizeToolbar.CreateItems;
var
  liIndex: Integer;
  lButton: TppTBXItem;
begin

  if (ActionList = nil) then
    raise EDesignError.Create('TppSizeToolbar.CreateItems: ActionList must be assigned');

  BeginUpdate;

  Caption := ppLoadStr(485); {'Size'}

  for liIndex := 0 to ActionList.ActionCount-1 do
    begin

      lButton := AddButton();
      lButton.Action := ActionList.Actions[liIndex];
      lButton.Name := cSizeNames[liIndex];


      // add a separator after the second button
      if (liIndex = 1) then
        AddSeparator();

    end;

  EndUpdate;


end;

procedure TppSizeToolbar.LanguageChanged;
begin

  inherited;

  Caption := ppLoadStr(485); {'Size'}

end;

{******************************************************************************
 *
 **  N u d g e   T o o l b a r
 *
{******************************************************************************}

constructor TppNudgeToolbar.Create(aOwner: TComponent);
begin
  inherited;

  Name := 'Nudge';  // do not localize

  Images := ToolImageList;

end;


procedure TppNudgeToolbar.CreateItems;
var
  liIndex: Integer;
  lButton: TppTBXItem;
begin

  if (ActionList = nil) then
    raise EDesignError.Create('TppNudgeToolbar.CreateItems: ActionList must be assigned');

  BeginUpdate;

  Caption := ppLoadStr(486); {'Nudge'}

  for liIndex := 0 to ActionList.ActionCount-1 do
    begin

      lButton := AddButton();
      lButton.Name := cNudgeItemNames[liIndex];
      lButton.Action := ActionList.Actions[liIndex];

      {add a separator after the second button}
      if (liIndex = 1) then
        AddSeparator();

    end;

  EndUpdate;

end;

procedure TppNudgeToolbar.LanguageChanged;
begin

  inherited;

  Caption := ppLoadStr(486); {'Nudge'}

end;

{******************************************************************************
 *
 **  D r a w  T o o l b a r
 *
{******************************************************************************}


{ TppDrawToolbar }

constructor TppDrawToolbar.Create(aOwner: TComponent);
begin
  inherited;

  Name := 'Draw';  // do not localize

  Images := ToolImageList;

end;

procedure TppDrawToolbar.CreateItems;
begin

  BeginUpdate;

  FFillColorButton := TppColorPaletteButton.Create(nil);
  Items.Add(FFillColorButton);
  FFillColorButton.PaletteAction := ActionList[0];

  FLineColorButton := TppColorPaletteButton.Create(nil);
  Items.Add(FLineColorButton);
  FLineColorButton.PaletteAction := ActionList[1];

  FGradientButton := TppGradientPaletteButton.Create(nil);
  Items.Add(FGradientButton);
  FGradientButton.PaletteAction := ActionList.GetActionForName('Gradient');
  FGradientButton.ImageIndex := ToolImageList.AddTool('PPGRADIENT', clCream);

  FLineThicknessButton := TppLineThicknessPaletteButton.Create(nil);
  FLineThicknessButton.PaletteAction := ActionList.GetActionForName('LineThickness');
  FLineThicknessButton.ImageIndex := ToolImageList.AddTool('PPLINETHICKNESS');

  Items.Add(FLineThicknessButton);

  FLineStyleButton := TppLineStylePaletteButton.Create(nil);
  FLineStyleButton.PaletteAction := ActionList.GetActionForName('LineStyle');
  FLineStyleButton.ImageIndex := ToolImageList.AddTool('PPLINESTYLE');
  Items.Add(FLineStyleButton);

  {this will load the hint strings}
  LanguageChanged;

  EndUpdate;

end;

procedure TppDrawToolbar.LanguageChanged;
begin
  inherited;

  Caption :=  ppLoadStr(487); {'Draw'}

  FGradientButton.Hint := 'Gradient'; //TODO Lang ppLoadStr(???); {Gradient}
  FLineStyleButton.Hint := ppLoadStr(489); {Line Style}
  FLineThicknessButton.Hint := ppLoadStr(488);  {Line Thickness}


  FFillColorButton.LanguageChanged;
  FLineColorButton.LanguageChanged;
  FGradientButton.LanguageChanged;
  FLineThicknessButton.LanguageChanged;
  FLineStyleButton.LanguageChanged;

end;



{******************************************************************************
 *
 **  Edit Toolbar TBX
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppEditToolbar.Create}

constructor TppEditToolbar.Create(aOwner: TComponent);
begin
  inherited;

  Name := 'Edit';  // do not localize

end;

{------------------------------------------------------------------------------}
{ TppEditToolbar.CreateControls}

procedure TppEditToolbar.CreateItems;
begin

  FEditBox := TppDesignEditToolItem.Create(Owner);
  FEditBox.EditWidth   := 200;
  FEditBox.Visible := True;
  FEditBox.Action := ActionList.GetActionForName('EditText');
  FEditBox.OnChange := ehEditBox_Change;

  Items.Add(FEditBox);

  FComboBox2 := TppDesignComboBoxToolItem.Create(Owner);
  FComboBox2.EditWidth := 150;
  FComboBox2.MaxVisibleItems := 10;
  FComboBox2.MinListWidth := FComboBox2.EditWidth;
  FComboBox2.Loaded;

  FComboBox2.Action := ActionList.GetActionForName('ComboBox2');
  Items.Add(FComboBox2);

  FComboBox := TppDesignComboBoxToolItem.Create(Owner);
  FComboBox.EditWidth   := 200;
  FComboBox.MaxVisibleItems := 10;
  FComboBox.MinListWidth := FComboBox.EditWidth;
  FComboBox.Loaded;
  FComboBox.Action := ActionList.GetActionForName('ComboBox');
  Items.Add(FComboBox);


  LanguageChanged;

end;

{------------------------------------------------------------------------------}
{ TppEditToolbar.ehEditBox_Change}

procedure TppEditToolbar.ehEditBox_Change(Sender: TObject; const aText: String);
begin

  if (FEditBox.Action is TppEditTextAction) then
    begin
      TppEditTextAction(FEditBox.Action).Text := aText;
      TppEditTextAction(FEditBox.Action).Execute;
    end;

end;

{------------------------------------------------------------------------------}
{ TppEditToolbar.EnableControl}

procedure TppEditToolbar.EnableControl(aItem: TObject);
begin

//  BeginUpdate;

  if (FEnabledControl = aItem) then Exit;

  FEnabledControl := aItem;

  if (aItem = nil) then
    begin
      FComboBox.Visible := False;
      FComboBox2.Visible := False;

      FEditBox.Clear;
      FEditBox.Enabled  := False;
      FEditBox.Visible  := True;

    end
  else if (aItem = FEditBox) then
    begin
      FComboBox.Visible := False;
      FComboBox2.Visible := False;

      FEditBox.Enabled  := True;
      FEditBox.Visible  := True;

    end
  else if (aItem = FComboBox) then
    begin
      FEditBox.Visible   := False;
      FComboBox.Visible  := True;
      FComboBox2.Visible := False;

    end
  else if (aItem = FComboBox2) then
    begin
      FEditBox.Visible   := False;
      FComboBox2.Visible := True;
      FComboBox.Visible  := True;


    end;


//  EndUpdate;

end; {procedure, EnableControl}


{------------------------------------------------------------------------------}
{ TppEditToolbar.LanguageChanged}

procedure TppEditToolbar.LanguageChanged;
begin
  inherited;

  Caption :=  ppLoadStr(264); {'Edit'}

end;

{******************************************************************************
 *
 **  Standard Toolbar TBX
 *
{******************************************************************************}

{ TppStandardToolbar }

constructor TppStandardToolbar.Create(aOwner: TComponent);
begin
  inherited;

  Name := 'Standard';  // do not localize

end;

procedure TppStandardToolbar.CreateItems;
begin

  if (ActionList = nil) then
    raise EDesignError.Create('TppStandardToolbar.CreateItems: ActionList must be assigned');

  BeginUpdate;

  Caption := ppLoadStr(490); {'Standard'}

  // new, open, save
  FFileNewButton := AddButton();
  FFileNewButton.Action := ActionList.GetActionForName('New');

  FFileOpenButton := AddButton();
  FFileOpenButton.Action := ActionList.GetActionForName('Open');

  FFileSaveButton := AddButton();
  FFileSaveButton.Action := ActionList.GetActionForName('Save');

  // separator
  FSeparator1 := AddSeparator();

  // page setup, print, print preview
  FPageSetupButton := AddButton();
  FPageSetupButton.Action := ActionList.GetActionForName('PageSetup');

  FPrintButton := AddButton();
  FPrintButton.Action := ActionList.GetActionForName('Print');

  FPrintPreviewButton := AddButton();
  FPrintPreviewButton.Action := ActionList.GetActionForName('PrintPreview');

  // separator
  FSeparator2 := AddSeparator();

  // cut, copy, paste
  FCutButton := AddButton();
  FCutButton.Action := ActionList.GetActionForName('Cut');

  FCopyButton := AddButton();
  FCopyButton.Action := ActionList.GetActionForName('Copy');

  FPasteButton := AddButton();
  FPasteButton.Action := ActionList.GetActionForName('Paste');

  {this will load the hint strings}
  LanguageChanged();

  EndUpdate;


end;



procedure TppStandardToolbar.LanguageChanged;
begin

  inherited;

  Caption :=  ppLoadStr(490); {'Standard'}

end;

{******************************************************************************
 *
 **  C u s t o m   F o r m a t   T o o l b a r   T B X
 *
{******************************************************************************}


procedure TppCustomFormatToolbar.CreateItems;
begin

  View.BeginUpdate;

  FFontComboBox := TppFontNameToolItem.Create(nil);
  Items.Add(FFontComboBox);
  FFontComboBox.EditWidth := 148;
  FFontComboBox.FontName := 'Arial';
  FFontComboBox.Loaded;
  FFontComboBox.Action := ActionList.GetActionForName('FontName');

  FFontSizeComboBox := TppFontSizeToolItem.Create(nil);
  Items.Add(FFontSizeComboBox);
  FFontSizeComboBox.EditWidth  := 51;
  FFontSizeComboBox.Text := '10';
  FFontSizeComboBox.AutoComplete := False;  // turn off auto-completion
  FFontSizeComboBox.Loaded;
  FFontSizeComboBox.Action := ActionList.GetActionForName('FontSize');

  AddSeparator();

  FBoldButton := AddButton();
  FBoldButton.Action := ActionList.GetActionForName('Bold');
  FBoldButton.AutoCheck := True;

  FItalicButton := AddButton();
  FItalicButton.Action := ActionList.GetActionForName('Italic');

  FUnderlineButton := AddButton();
  FUnderlineButton.Action := ActionList.GetActionForName('Underline');

  AddSeparator();

  FAlignLeftButton := AddButton();
  FAlignLeftButton.Action :=  ActionList.GetActionForName('LeftJustify');

  FCenterButton := AddButton();
  FCenterButton.Action :=  ActionList.GetActionForName('Center');

  FAlignRightButton :=AddButton();
  FAlignRightButton.Action :=  ActionList.GetActionForName('RightJustify');

  FFullJustifyButton :=AddButton();
  FFullJustifyButton.Action :=  ActionList.GetActionForName('FullJustify');

  AddSeparator();

  FFontColorButton := TppColorPaletteButton.Create(nil);
  FFontColorButton.PaletteAction := ActionList.GetActionForName('FontColor');
  Items.Add(FFontColorButton);

  FHighlightColorButton := TppColorPaletteButton.Create(nil);
  FHighlightColorButton.PaletteAction := ActionList.GetActionForName('HighlightColor');
  Items.Add(FHighlightColorButton);

  {this will load the hint strings}
  LanguageChanged();

  View.EndUpdate;

end;

{------------------------------------------------------------------------------}
{ TppCustomFormatToolbar.GetAlignment}

function TppCustomFormatToolbar.GetAlignment: TAlignment;
begin

  if FAlignRightButton.Checked then
    Result := taRightJustify

  else if FCenterButton.Checked then
     Result := taCenter

  else
    Result := taLeftJustify;

end; {function, GetAlignment}

procedure TppCustomFormatToolbar.LanguageChanged;
begin

  inherited;

  Caption :=  ppLoadStr(200); {'Format'}

  FFontColorButton.LanguageChanged;
  FHighlightColorButton.LanguageChanged;

end;

{------------------------------------------------------------------------------}
{ TppCustomFormatToolbar.SetAlignment}

procedure TppCustomFormatToolbar.SetAlignment(aAlignment: TAlignment);
begin

  FAlignLeftButton.Checked  := (aAlignment = taLeftJustify);
  FAlignRightButton.Checked := (aAlignment = taRightJustify);
  FCenterButton.Checked     := (aAlignment = taCenter);

end; 


{******************************************************************************
 *
 **  F o r m a t   T o o l b a r   T B X
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppFormatToolbar.Create}

constructor TppFormatToolbar.Create(aOwner: TComponent);
begin

  inherited;

  Name := 'Format';  // do not localize

end;

{------------------------------------------------------------------------------}
{ TppFormatToolbar.CreateControls}

procedure TppFormatToolbar.CreateItems;
begin

  View.BeginUpdate;

  inherited CreateItems;

  AddSeparator();

  FAnchorsButton := TppAnchorsPaletteButton.Create(nil);
  FAnchorsButton.PaletteAction := ActionList.GetActionForName('Anchors');
  FAnchorsButton.ImageIndex := ToolImageList.AddTool('PPANCHORS');
  Items.Add(FAnchorsButton);

  FBorderButton := TppBorderPaletteButton.Create(nil);
  FBorderButton.PaletteAction := ActionList.GetActionForName('Borders');
  Items.Add(FBorderButton);
  FBorderButton.ImageIndex := ToolImageList.AddTool('PPBORDER');

  AddSeparator();

  FBringForwardButton := AddButton();
  FBringForwardButton.Action := ActionList.GetActionForName('BringForward');

  FBringToFrontButton := AddButton();
  FBringToFrontButton.Action := ActionList.GetActionForName('BringToFront');

  FSendBackwardButton := AddButton();
  FSendBackwardButton.Action := ActionList.GetActionForName('SendBackward');

  FSendToBackButton := AddButton();
  FSendToBackButton.Action := ActionList.GetActionForName('SendToBack');


  {this will load the hint strings}
  LanguageChanged();

  View.EndUpdate;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TppFormatToolbar.SetLanguageIndex}

procedure TppFormatToolbar.LanguageChanged;
begin

  inherited LanguageChanged;

  if (FAnchorsButton = nil) then Exit;

  FAnchorsButton.Hint := ppLoadStr(1152); {Anchors}
  FBorderButton.Hint := ppLoadStr(1153); {Border}
  
  FAnchorsButton.LanguageChanged();
  FBorderButton.LanguageChanged();

end; {procedure, SetLanguageIndex}







initialization

  TppToolbarFactory.Register(TppAlignToolbar);
  TppToolbarFactory.Register(TppSizeToolbar);
  TppToolbarFactory.Register(TppNudgeToolbar);
  TppToolbarFactory.Register(TppDrawToolbar);
  TppToolbarFactory.Register(TppEditToolbar);
  TppToolbarFactory.Register(TppStandardToolbar);
  TppToolbarFactory.Register(TppFormatToolbar);

finalization

  TppToolbarFactory.UnRegister(TppAlignToolbar);
  TppToolbarFactory.UnRegister(TppSizeToolbar);
  TppToolbarFactory.UnRegister(TppNudgeToolbar);
  TppToolbarFactory.UnRegister(TppDrawToolbar);
  TppToolbarFactory.UnRegister(TppEditToolbar);
  TppToolbarFactory.UnRegister(TppStandardToolbar);
  TppToolbarFactory.UnRegister(TppFormatToolbar);

end.








