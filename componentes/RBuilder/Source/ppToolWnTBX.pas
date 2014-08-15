{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppToolWnTBX;

interface

{$I ppIfDef.pas}

uses
   Windows, SysUtils, Controls, ComCtrls, Classes, Graphics, ExtCtrls, Menus,
   Forms, StdCtrls, Messages,
   Buttons,
   ppComm, ppClass, ppCmpReg, ppTypes, ppUtils, ppSubRpt, ppReport,
   ppRegion, ppCtrls, ppDB, ppRptWiz, Dialogs, ppMetaAL, ppTreeVw,
   ppClasUt, ppIniStorage,
   ppInspector,
   ppDesignEventHub,
   ppDesignControllers,
   ppDesignWorkspaceController,
   ppDesignControls,
   ppToolResources,
   ppDesignToolWindow,
   ppTabbedNotebook,
   ppPrintr,
   ppParameter,

   ppTBX,
   ppToolbarTBX,

   ppJvTabBar,
   ppTBXPanel;

type


  {@TppAutoLayoutManager}
  TppAutoLayoutManager = class(TObject)
    private
      FBitmap: TBitmap;
      FMetaBitmap: TppAutoLayoutBitmap;
      FBevelCreate: TGroupBox;
      FBevelImage: TPanel;
      FCheckboxFieldGrid: TCheckbox;
      FCheckboxLabelGrid: TCheckbox;
      FImage: TImage;
      FLabelLabelFont: TLabel;
      FLabelFieldFont: TLabel;
      FFontButtonLabel: TSpeedButton;
      FFontButtonField: TSpeedButton;
      FComboLayout: TComboBox;
      FRadioFields: TRadioButton;
      FRadioLabels: TRadioButton;
      FRadioFieldsNLabels: TRadioButton;
      FOnChange: TNotifyEvent;

      procedure DoOnChange;

      function GetCreateFields: Boolean;
      function GetCreateLabels: Boolean;
      function GetFieldFont: TFont;
      function GetFieldGrid: Boolean;
      function GetLabelFont: TFont;
      function GetLabelGrid: Boolean;
      function GetLayoutType: TppReportLayoutType;

      procedure SetCreateFields(aValue: Boolean);
      procedure SetCreateLabels(aValue: Boolean);
      procedure SetFieldFont(aFont: TFont);
      procedure SetFieldGrid(aValue: Boolean);
      procedure SetLabelFont(aFont: TFont);
      procedure SetLabelGrid(aValue: Boolean);
      procedure SetLayoutType(aLayoutType: TppReportLayoutType);

      procedure CheckboxLabelGridClickEvent(Sender: TObject);
      procedure CheckboxFieldGridClickEvent(Sender: TObject);
      procedure FontButtonLabelClickEvent(Sender: TObject);
      procedure FontButtonFieldClickEvent(Sender: TObject);
      procedure ComboLayoutChangeEvent(Sender: TObject);
      procedure RadioFieldsNLabelsClickEvent(Sender: TObject);
      procedure RadioLabelsClickEvent(Sender: TObject);
      procedure RadioFieldsClickEvent(Sender: TObject);
      procedure UpdateBitmap;

      procedure LabelLabelFontClickEvent(Sender: TObject);
      procedure LabelFieldFontClickEvent(Sender: TObject);

    public
      constructor Create(aOwner: TComponent; aParent: TWinControl);
      destructor Destroy; override;

      procedure EnableControls;
      procedure LanguageChanged;

      property LabelFont: TFont read GetLabelFont write SetLabelFont;
      property FieldFont: TFont read GetFieldFont write SetFieldFont;
      property LayoutType: TppReportLayoutType read GetLayoutType write SetLayoutType;
      property CreateFields: Boolean read GetCreateFields write SetCreateFields;
      property CreateLabels: Boolean read GetCreateLabels write SetCreateLabels;
      property LabelGrid: Boolean read GetLabelGrid write SetLabelGrid;
      property FieldGrid: Boolean read GetFieldGrid write SetFieldGrid;

      property OnChange: TNotifyEvent read FOnChange write FOnChange;

    end; {class, TppAutoLayoutManager}



  {@TppAutoLayout}
  TppAutoLayout = class(TObject)
    private
      FFieldComponents: TList;
      FFieldGrid: TList;
      FLabelComponents: TList;
      FLabelGrid: TList;
      FStartingPos: TPoint;
      FLabelPos: TPoint;
      FFieldPos: TPoint;

    protected
      function CalcStartingLabelPos: TPoint;  virtual; abstract;
      function CalcStartingFieldPos: TPoint;  virtual; abstract;

      function IncludeFields: Boolean;
      function IncludeLabels: Boolean;
      function IncludeFieldGrid: Boolean;
      function IncludeLabelGrid: Boolean;
      function GetComponentCount: Integer;

      property LabelPos: TPoint read FLabelPos write FLabelPos;
      property FieldPos: TPoint read FFieldPos write FFieldPos;

    public
      constructor Create;
      destructor Destroy; override;

      procedure CreateLayout; virtual; abstract;

      property FieldComponents: TList read FFieldComponents;
      property FieldGrid: TList read FFieldGrid;
      property LabelComponents: TList read FLabelComponents;
      property LabelGrid: TList read FLabelGrid;
      property StartingPos: TPoint read FStartingPos write FStartingPos;

    end; {class, TppAutoLayout}


  {@TppAutoLayoutTabular}
  TppAutoLayoutTabular = class(TppAutoLayout)
    private
      FLabelBandWidth: Integer;
      FFieldBandWidth: Integer;

   protected
      function CalcStartingLabelPos: TPoint; override;
      function CalcStartingFieldPos: TPoint;  override;

       function CalcNextLabelPos(aIndex: Integer): TPoint;
       function CalcNextFieldPos(aIndex: Integer): TPoint;
       function CalcLineHeight: Integer;


    public
      procedure CreateLayout; override;

    end; {class, TppAutoLayoutTabular}


  {@TppAutoLayoutVertical}
  TppAutoLayoutVertical = class(TppAutoLayout)
  private

   protected
     function CalcStartingLabelPos: TPoint; override;
     function CalcStartingFieldPos: TPoint;  override;

     function CalcNextLabelPos(aIndex: Integer): TPoint;
     function CalcNextFieldPos(aIndex: Integer): TPoint;

     function CalcFieldColWidth: Integer;
     function CalcLineHeight(aIndex: Integer): Integer;


    public
      procedure CreateLayout; override;

    end; {class, TppAutoLayoutVertical}


  {@TppDataExplorer }
  TppDataExplorer = class(TppCustomReportExplorer)
    private
      FChangeItemSelected: Boolean;
      FLanguageIndex: Longint;
      FSelection: TList;

      procedure SetLanguageIndex(aLanguageIndex: Longint);

      procedure ListViewChangingEvent(Sender: TObject; Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
      procedure ListViewChangeEvent(Sender: TObject; Item: TListItem; Change: TItemChange);

    protected
      procedure ListViewBeforeBuildListEvent(Sender: TObject);
    public
      constructor Create(aParent: TWinControl; aOrientation: TppExplorerOrientation); override;
      destructor Destroy; override;

      procedure GetSelectedFields(aFieldList: TList);

      property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;

  end; {class, TppDataExplorer}


  {@TppDataTreeWindow }
  TppDataTreeWindow = class(TppDesignToolWindow)
    private
      FNoteBook: TNoteBook;
      FLayoutManager: TppAutoLayoutManager;
      FTreeMenu: TppTBXPopupMenu;
      FLabelFont: TFont;
      FFieldFont: TFont;
      FLabelGrid: Boolean;
      FFieldGrid: Boolean;
      FLayoutType: TppReportLayoutType;
      FCreateFields: Boolean;
      FCreateLabels: Boolean;
      FChangeItemSelected: Boolean;
      FDockChanging: Boolean;
      FDataExplorer: TppDataExplorer;
      FListView: TppReportListView;
      FTabSet: TppTabSet;
      FTreeView: TppReportTreeView;

      procedure BuildPopupMenu;

      procedure CreateLayoutManager;

      procedure SetLabelFont(aFont: TFont);
      procedure SetFieldFont(aFont: TFont);

      procedure LayoutManagerChangeEvent(Sender: TObject);

      procedure CMVisibleChanged (var Message: TMessage); message CM_VISIBLECHANGED;
      procedure ehReport_LoadEnd(Sender, aParameters: TObject);
//      procedure ehTabSet_Change(Sender: TObject; aNewTab: Integer; var aAllowChange: Boolean);
      procedure ehTabSet_Change(Sender: TObject; Item: TppJvTabBarItem);
      procedure ehWorkspace_DragDrop(Sender, aParameters: TObject);
      procedure TreeMenuItemClickEvent(Sender: TObject);
    protected
      procedure CreateControls; override;
      procedure SetEventHub(aEventHub: TppDesignEventHub); override;
      procedure SetReport(aReport: TppCustomReport); override;
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure LanguageChanged; override;
      procedure LoadPreferences(aIniStorage: TppIniStorage); override;
      procedure SavePreferences(aIniStorage: TppIniStorage); override;
      procedure ShowingChanged(aVisible: Boolean); override;

      procedure CreateComponentsForFields(aBand: TppBand; X, Y: Integer; var aComponents: TList);
      procedure Refresh;

      property ListView: TppReportListView read FListView;
      property TreeView: TppReportTreeView read FTreeView;
      property DataExplorer: TppDataExplorer read FDataExplorer;

      property CreateFields: Boolean read FCreateFields write FCreateFields;
      property CreateLabels: Boolean read FCreateLabels write FCreateLabels;
      property LabelFont: TFont read FLabelFont write SetLabelFont;
      property LabelGrid: Boolean read FLabelGrid write FLabelGrid;
      property FieldFont: TFont read FFieldFont write SetFieldFont;
      property FieldGrid: Boolean read FFieldGrid write FFieldGrid;
      property LayoutType: TppReportLayoutType read FLayoutType write FLayoutType;

    end; {class, TppDataTreeWindow}


  
  {TppReportTreeWindow}
  TppReportTreeWindow = class(TppDesignToolWindow)
  private
    FActive: Boolean;
    FClientPanel: TPanel;
    FInpectorTitleBar: TPanel;
    FInspector: TppInspector;
    FInspectorPanel: TPanel;
    FInspectorSplitter: TSplitter;
    FObjectTree: TppReportTreeView;
    FObjectTreeBuilder: TppReportObjectTreeBuilder;
    FReportPanel: TPanel;
    FReportTree: TppReportTreeView;
    FReportTreeBuilder: TppReportOutlineTreeBuilder;
    FPopupMenu: TppTBXPopupMenu;
    FReportTreeSplitter: TSplitter;
    FSaveInspectorPanelHeight: Integer;
    FTreeStates: TppTreeStates;

    function AllowTreeNodeEditText(aNode: TTreeNode): Boolean;
    procedure ehObjectTree_Change(Sender: TObject; Node: TTreeNode);
    procedure ehReportTree_Change(Sender: TObject; Node: TTreeNode);
    procedure SetSelectedComponent(const Value: TComponent);

    procedure ehTreeView_Edited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure ehTreeView_Editing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
    procedure ehComponent_Add(Sender, aParameters: TObject);
    procedure ehComponent_AfterPropertyChange(Sender, aParameters: TObject);
    procedure ehComponent_Remove(Sender, aParameters: TObject);
    procedure ehComponent_Update(Sender, aParameters: TObject);
    procedure ehInspectorSelectComponent(Sender: TObject);
    procedure ehPopupMenu_ItemClick(Sender: TObject);
    procedure ehPopupMenu_Popup(Sender: TObject);
    procedure ehReport_AddSubreport(Sender, aParameters: TObject);
    procedure ehReport_RemoveSubreport(Sender, aParameters: TObject);
    procedure ehReport_CaptionChange(Sender, aParameters: TObject);
    procedure ehReport_LoadEnd(Sender, aParams: TObject);
    procedure ehSelection_AfterChange(Sender, aParameters: TObject);
    procedure ehSelection_SelectComponent(Sender, aParameters: TObject);
    procedure ehSelection_SelectReport(Sender, aParameters: TObject);

  protected
    procedure BuildPopupMenu; virtual;
    procedure CreateControls; override;
    function GetSelectedComponent: TComponent;
    function GetSelectedReport: TComponent;
    procedure SetEventHub(aEventHub: TppDesignEventHub); override;
    procedure SetReport(aReport: TppCustomReport); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ShowingChanged(aVisible: Boolean); override;
    procedure AddChildReport(const aCaption: String; aChildReport: TComponent);
    procedure LanguageChanged; override;
    procedure LoadPreferences(aIniStorage: TppIniStorage); override;
    procedure Refresh;
    procedure RemoveChildReport(aChildReport: TComponent);
    procedure SavePreferences(aIniStorage: TppIniStorage); override;
    procedure SetInspectorVisible(aVisible: Boolean);
    procedure SetReportTreeVisible(aVisible: Boolean);

    property SelectedComponent: TComponent read GetSelectedComponent write SetSelectedComponent;

  end;

  {@TppFontButton }
  TppFontButton = class(TSpeedButton)
  private
    FCurrentFont: TFont;
    FFontAttributeType: TppFontAttributeType;


    procedure SetCurrentFont(aFont: TFont);
    procedure SetFontAttributeType(aValue: TppFontAttributeType);

  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    property FontAttributeType: TppFontAttributeType read FFontAttributeType write SetFontAttributeType;
    procedure Click; override;

    property CurrentFont: TFont read FCurrentFont write SetCurrentFont;

  end; {class, TppFontButton}

  procedure ppSaveFontState(aStateStorag: TppIniStorage; aSection, aIdent: String; aFont: TFont);

  procedure ppLoadFontState(aStateStorag: TppIniStorage; aSection, aIdent: String; aFont: TFont);



implementation

{------------------------------------------------------------------------------}
{ ppSaveFontState}

procedure ppSaveFontState(aStateStorag: TppIniStorage; aSection, aIdent: String; aFont: TFont);
begin

  aStateStorag.WriteString(aSection, aIdent + 'Name', aFont.Name);
  aStateStorag.WriteInteger(aSection, aIdent + 'Size', aFont.Size);
  aStateStorag.WriteInteger(aSection, aIdent + 'Color', aFont.Color);
  aStateStorag.WriteInteger(aSection, aIdent + 'Charset', aFont.Charset);
  aStateStorag.WriteBool(aSection, aIdent + 'Bold', (fsBold in aFont.Style));
  aStateStorag.WriteBool(aSection, aIdent + 'Italic', (fsItalic in aFont.Style));
  aStateStorag.WriteBool(aSection, aIdent + 'Underline', (fsUnderline in aFont.Style));
  aStateStorag.WriteBool(aSection, aIdent + 'StrikeOut', (fsStrikeOut in aFont.Style));

end; {procedure, ppSaveFontState}

{------------------------------------------------------------------------------}
{ ppLoadFontState}

procedure ppLoadFontState(aStateStorag: TppIniStorage; aSection, aIdent: String; aFont: TFont);
var
  lFontStyle: TFontStyles;

begin

  aFont.Color := aStateStorag.ReadInteger(aSection,aIdent + 'Color', clWindowText);
  aFont.Charset := aStateStorag.ReadInteger(aSection, aIdent + 'Charset', DEFAULT_CHARSET);
  aFont.Name := aStateStorag.ReadString(aSection, aIdent + 'Name', 'Arial');
  aFont.Size := aStateStorag.ReadInteger(aSection, aIdent + 'Size', 12);

  lFontStyle := [];

  if aStateStorag.ReadBool(aSection, aIdent + 'Bold', False) then
    Include(lFontStyle, fsBold);

  if aStateStorag.ReadBool(aSection, aIdent + 'Italic', False) then
    Include(lFontStyle, fsItalic);

  if aStateStorag.ReadBool(aSection, aIdent + 'Underline', False) then
    Include(lFontStyle, fsUnderline);

   if aStateStorag.ReadBool(aSection, aIdent + 'StrikeOut', False) then
     Include(lFontStyle, fsStrikeOut);

   aFont.Style := lFontStyle;

end; {procedure, ppLoadFontState}

//uses
//  ppDesignerTools;



{******************************************************************************
 *
 ** L A Y O U T M A N A G E R
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.Create }

constructor TppAutoLayoutManager.Create(aOwner: TComponent; aParent: TWinControl);
var
  lFont: TFont;
begin

  inherited Create;

  FOnChange := nil;

  lFont := TFont.Create;
  lFont.Size := 8;

  FBitmap := TBitmap.Create;
  FMetaBitmap := TppAutoLayoutBitmap.Create;

  {create bevel frame for top half of window}
  FBevelCreate := TGroupBox.Create(aOwner);
  FBevelCreate.Parent := aParent;
  FBevelCreate.SetBounds(2, 5, aParent.Width-4, 116);
  FBevelCreate.Anchors := [akLeft, akRight];

  {create bevel for image at bottom half of window}
  FBevelImage := TPanel.Create(aOwner);
  FBevelImage.Parent := aParent;
  FBevelImage.BevelOuter := bvLowered;
  FBevelImage.SetBounds(1,124,167,150);

  FImage := TImage.Create(aOwner);
  FImage.Parent := FBevelImage;
  FImage.Align := alClient;

  FLabelLabelFont := TLabel.Create(aOwner);
  FLabelLabelFont.Parent := FBevelCreate;
  FLabelLabelFont.Font.Assign(lFont);
  FLabelLabelFont.AutoSize := True;
  FLabelLabelFont.SetBounds(112,60,21,13);
  FLabelLabelFont.OnClick := LabelLabelFontClickEvent;
  FLabelLabelFont.Alignment := taRightJustify;

  FLabelFieldFont := TLabel.Create(aOwner);
  FLabelFieldFont.Parent := FBevelCreate;
  FLabelFieldFont.Font.Assign(lFont);
  FLabelFieldFont.SetBounds(112,96,21,13);
  FLabelFieldFont.AutoSize := True;
  FLabelFieldFont.OnClick := LabelFieldFontClickEvent;
  FLabelFieldFont.Alignment := taRightJustify;

  FFontButtonLabel := TppFontButton.Create(aOwner);
  FFontButtonLabel.Parent := FBevelCreate;
  TppFontButton(FFontButtonLabel).FontAttributeType := faFontName;
  FFontButtonLabel.Left := 139;
  FFontButtonLabel.Top := 57;
  TppFontButton(FFontButtonLabel).CurrentFont.Name  := 'Times New Roman';
  TppFontButton(FFontButtonLabel).CurrentFont.Size  := 12;
  TppFontButton(FFontButtonLabel).CurrentFont.Style := [fsBold];
  FFontButtonLabel.OnClick := FontButtonLabelClickEvent;

  FFontButtonField := TppFontButton.Create(aOwner);
  FFontButtonField.Parent  := FBevelCreate;
  TppFontButton(FFontButtonField).FontAttributeType := faFontName;

  FFontButtonField.Left := 139;
  FFontButtonField.Top := 92;
  TppFontButton(FFontButtonLabel).CurrentFont.Name := 'Times New Roman';
  TppFontButton(FFontButtonLabel).CurrentFont.Size := 12;
  FFontButtonField.OnClick := FontButtonFieldClickEvent;

  FComboLayout := TComboBox.Create(aOwner);
  FComboLayout.Parent := FBevelCreate;
  FComboLayout.Font.Assign(lFont);
  FComboLayout.SetBounds(82,17, FBevelCreate.Width-86,21);
  FComboLayout.OnChange := ComboLayoutChangeEvent;
  FComboLayout.Anchors := [akLeft, akRight];

  FRadioFieldsNLabels := TRadioButton.Create(aOwner);
  FRadioFieldsNLabels.Parent := FBevelCreate;
  FRadioFieldsNLabels.Font.Assign(lFont);
  FRadioFieldsNLabels.SetBounds(10,18, 55, 17);
  FRadioFieldsNLabels.Checked := True;
  FRadioFieldsNLabels.OnClick := RadioFieldsNLabelsClickEvent;

  FRadioLabels := TRadioButton.Create(aOwner);
  FRadioLabels.Parent := FBevelCreate;
  FRadioLabels.Font.Assign(lFont);
  FRadioLabels.SetBounds(10,44, 55, 17);
  FRadioLabels.OnClick := RadioLabelsClickEvent;


  FRadioFields := TRadioButton.Create(aOwner);
  FRadioFields.Parent := FBevelCreate;
  FRadioFields.Font.Assign(lFont);
  FRadioFields.SetBounds(10,78, 55, 17);
  FRadioFields.OnClick := RadioFieldsClickEvent;

  FCheckboxLabelGrid := TCheckbox.Create(aOwner);
  FCheckboxLabelGrid.Parent := FBevelCreate;
  FCheckboxLabelGrid.Font.Assign(lFont);
  FCheckboxLabelGrid.SetBounds(49,59, 50, 17);
  FCheckboxLabelGrid.OnClick := CheckboxLabelGridClickEvent;

  FCheckboxFieldGrid := TCheckbox.Create(aOwner);
  FCheckboxFieldGrid.Parent := FBevelCreate;
  FCheckboxFieldGrid.Font.Assign(lFont);
  FCheckboxFieldGrid.SetBounds(49,95, 50, 17);
  FCheckboxFieldGrid.OnClick := CheckboxFieldGridClickEvent;

  LanguageChanged;

  FComboLayout.ItemIndex := 0;
  UpdateBitmap;

  lFont.Free;


end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.Destroy }

destructor TppAutoLayoutManager.Destroy;
begin

  FBitmap.Free;
  FMetaBitmap.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.DoOnChange }

procedure TppAutoLayoutManager.DoOnChange;
begin

  if Assigned(FOnChange) then FOnChange(Self);

end; {procedure, DoOnChange}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.GetCreateFields }

function TppAutoLayoutManager.GetCreateFields: Boolean;
begin
  Result := FRadioFieldsNLabels.Checked or FRadioFields.Checked;

end; {function, GetCreateFields}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.GetCreateLabels }

function TppAutoLayoutManager.GetCreateLabels: Boolean;
begin
  Result := FRadioFieldsNLabels.Checked or FRadioLabels.Checked;

end; {function, GetCreateLabels}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.GetLabelGrid }

function TppAutoLayoutManager.GetLabelGrid: Boolean;
begin
  Result := FCheckboxLabelGrid.Checked;
end; {function, GetLabelGrid}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.GetFieldGrid }

function TppAutoLayoutManager.GetFieldGrid: Boolean;
begin
  Result := FCheckboxFieldGrid.Checked;
end; {function, GetFieldGrid}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.GetCreateLabels }

function TppAutoLayoutManager.GetLabelFont: TFont;
begin
  Result := TppFontButton(FFontButtonLabel).CurrentFont;
end; {function, GetCreateLabels}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.GetFieldFont }

function TppAutoLayoutManager.GetFieldFont: TFont;
begin
  Result := TppFontButton(FFontButtonField).CurrentFont;
end; {function, GetFieldFont}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.GetLayoutType }

function TppAutoLayoutManager.GetLayoutType: TppReportLayoutType;
begin
  if FComboLayout.ItemIndex = 0 then
    Result := rlTabular
  else
    Result := rlVertical;

end; {function, GetLayoutType}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.SetCreateFields }

procedure TppAutoLayoutManager.SetCreateFields(aValue: Boolean);
var
  lbCreateLabels: Boolean;

begin

  lbCreateLabels := GetCreateLabels;

  FRadioLabels.Checked := not aValue;
  FRadioFields.Checked := aValue and not lbCreateLabels;
  FRadioFieldsNLabels.Checked := aValue and lbCreateLabels;

end; {function, SetCreateFields}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.SetCreateLabels }

procedure TppAutoLayoutManager.SetCreateLabels(aValue: Boolean);
var
  lbCreateFields: Boolean;

begin

  lbCreateFields := GetCreateFields;

  FRadioFields.Checked := not aValue;
  FRadioLabels.Checked := aValue and not lbCreateFields;
  FRadioFieldsNLabels.Checked := aValue and lbCreateFields;

end; {procedure, SetCreateLabels}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.SetLabelGrid }

procedure TppAutoLayoutManager.SetLabelGrid(aValue: Boolean);
begin
  FCheckboxLabelGrid.Checked := aValue;
end; {procedure, SetLabelGrid}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.SetFieldGrid }

procedure TppAutoLayoutManager.SetFieldGrid(aValue: Boolean);
begin
  FCheckboxFieldGrid.Checked := aValue;
end; {procedure, SetFieldGrid}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.SetLabelFont }

procedure TppAutoLayoutManager.SetLabelFont(aFont: TFont);
begin
  TppFontButton(FFontButtonLabel).CurrentFont.Assign(aFont);
end; {procedure, SetLabelFont}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.SetFieldFont }

procedure TppAutoLayoutManager.SetFieldFont(aFont: TFont);
begin
  TppFontButton(FFontButtonField).CurrentFont.Assign(aFont);
end; {procedure, SetFieldFont}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.SetLayoutType }

procedure TppAutoLayoutManager.SetLayoutType(aLayoutType: TppReportLayoutType);
begin
  if aLayoutType = rlTabular then
    FComboLayout.ItemIndex := 0
  else
    FComboLayout.ItemIndex := 1;

end; {procedure, SetLayoutType}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.SetLanguageIndex }

procedure TppAutoLayoutManager.LanguageChanged;
var
  lCanvas: TCanvas;
begin

  FBevelCreate.Caption := ppLoadStr(633); {Create}
  FLabelLabelFont.Caption := ppLoadStr(168); {Font}
  FLabelFieldFont.Caption := ppLoadStr(168);  {Font}
  FCheckboxLabelGrid.Caption := ppLoadStr(635); {Grid}
  FCheckboxFieldGrid.Caption := ppLoadStr(635); {Grid}

  FComboLayout.Clear;
  FComboLayout.Items.Add(ppLoadStr(624)); {Tabular}
  FComboLayout.Items.Add(ppLoadStr(626)); {Vertical}

  FRadioFieldsNLabels.Caption := ppLoadStr(3) {All};
  FRadioLabels.Caption := ppLoadStr(636) {Labels};
  FRadioFields.Caption := ppLoadStr(637); {Fields}

  lCanvas := FLabelLabelFont.Canvas;

  // size radio buttons
  FRadioFieldsNLabels.Width := lCanvas.TextWidth(FRadioFieldsNLabels.Caption) + 20; // 20 = radio button margin;
  FRadioLabels.Width := lCanvas.TextWidth(FRadioLabels.Caption) + 20;
  FRadioFields.Width := lCanvas.TextWidth(FRadioFields.Caption) + 20;

  // position and size the layout combo box
  FComboLayout.Left := FRadioFieldsNLabels.Left + FRadioFieldsNLabels.Width + 10;  // 10 = margin from radio button caption
  FComboLayout.Width := FBevelCreate.Width - FComboLayout.Left;

  // size grid checkboxes
  FCheckboxLabelGrid.Width := lCanvas.TextWidth(FCheckboxLabelGrid.Caption) + 20; // 20 = checkbox button margin
  FCheckboxFieldGrid.Width := FCheckboxLabelGrid.Width;

  // position font labels (they have autosize, therefore no need to calc width)
  FLabelLabelFont.Left := FCheckboxLabelGrid.Left + FCheckboxLabelGrid.Width + 5;
  FLabelFieldFont.Left := FLabelLabelFont.Left;

  // position font buttons
  FFontButtonLabel.Left := FLabelLabelFont.Left+ FLabelLabelFont.Width + 2;
  FFontButtonField.Left := FFontButtonLabel.Left;


end;  {procedure, SetLanguageIndex}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.CheckboxLabelGridClickEvent }

procedure TppAutoLayoutManager.CheckboxLabelGridClickEvent(Sender: TObject);
begin
  UpdateBitmap;

end; {procedure, CheckboxLabelGridClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.CheckboxFieldGridClickEvent }

procedure TppAutoLayoutManager.CheckboxFieldGridClickEvent(Sender: TObject);
begin
  UpdateBitmap;

end; {procedure, CheckboxFieldGridClickEvent}



{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.FontButtonLabelClickEvent }

procedure TppAutoLayoutManager.FontButtonLabelClickEvent(Sender: TObject);
begin
  UpdateBitmap;

end; {procedure, FontButtonLabelClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.LabelLabelFontClickEvent }

procedure TppAutoLayoutManager.LabelLabelFontClickEvent(Sender: TObject);
begin
  FFontButtonLabel.Click;

end;  {procedure, LabelLabelFontClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.FieldFieldFontClickEvent }

procedure TppAutoLayoutManager.LabelFieldFontClickEvent(Sender: TObject);
begin
  FFontButtonField.Click;

end;  {procedure, FieldFieldFontClickEvent}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.FontButtonFieldClickEvent }

procedure TppAutoLayoutManager.FontButtonFieldClickEvent(Sender: TObject);
begin
  UpdateBitmap;
end; {procedure, FontButtonFieldClickEvent}


{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.ComboLayoutChangeEvent }

procedure TppAutoLayoutManager.ComboLayoutChangeEvent(Sender: TObject);
begin
  UpdateBitmap;

end; {procedure, ComboLayoutChangeEvent}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.RadioFieldsNLabelsClickEvent }
procedure TppAutoLayoutManager.RadioFieldsNLabelsClickEvent(Sender: TObject);
begin
  EnableControls;

end; {procedure, RadioFieldsNLabelsClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.RadioLabelsClickEvent }

procedure TppAutoLayoutManager.RadioLabelsClickEvent(Sender: TObject);
begin
  EnableControls;

end; {procedure, RadioLabelsClickEvent}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.RadioFieldsClickEvent }

procedure TppAutoLayoutManager.RadioFieldsClickEvent(Sender: TObject);
begin
  EnableControls;

end; {procedure, RadioFieldsClickEvent}



{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.EnableControls }

procedure TppAutoLayoutManager.EnableControls;
begin

  FLabelLabelFont.Enabled := GetCreateLabels;
  FLabelFieldFont.Enabled := GetCreateFields;

  FFontButtonLabel.Enabled := FLabelLabelFont.Enabled;
  FFontButtonField.Enabled := FLabelFieldFont.Enabled;

  FCheckboxLabelGrid.Enabled  := FLabelLabelFont.Enabled;
  FCheckboxFieldGrid.Enabled  := FLabelFieldFont.Enabled;

  UpdateBitmap;

end; {procedure, EnableControls}

{------------------------------------------------------------------------------}
{ TppAutoLayoutManager.UpdateBitmap }

procedure TppAutoLayoutManager.UpdateBitmap;
begin

  FMetaBitmap.Labels := GetCreateLabels;
  FMetaBitmap.Fields := GetCreateFields;

  FMetaBitmap.LabelGrid := GetLabelGrid;
  FMetaBitmap.FieldGrid := GetFieldGrid;

  FMetaBitmap.LabelFont := TppFontButton(FFontButtonLabel).CurrentFont;
  FMetaBitmap.FieldFont := TppFontButton(FFontButtonField).CurrentFont;

  FMetaBitmap.Tabular := (FComboLayout.ItemIndex = 0);

  FMetaBitmap.RenderBitmap(FBitmap);
  FImage.Picture.Bitmap := FBitmap;
  FImage.Parent.Invalidate;

  DoOnChange;

end; {procedure, UpdateBitmap}


{******************************************************************************
 *
 **  A U T O L A Y O U T S  - U S E D   B Y   D A T A T R E E
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppAutoLayout.Create }

constructor TppAutoLayout.Create;
begin

  inherited Create;

  FFieldComponents := TList.Create;
  FLabelComponents := TList.Create;
  FFieldGrid  := TList.Create;
  FLabelGrid  := TList.Create;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppAutoLayout.Destroy }

destructor TppAutoLayout.Destroy;
begin
  FFieldComponents.Free;
  FLabelComponents.Free;
  FFieldGrid.Free;
  FLabelGrid.Free;

  inherited Destroy;

end; {destructor, Create}

{------------------------------------------------------------------------------}
{ TppAutoLayout.IncludeLabels }

function TppAutoLayout.IncludeLabels: Boolean;
begin
  Result := (FLabelComponents.Count > 0);
end; {function, IncludeLabels}

{------------------------------------------------------------------------------}
{ TppAutoLayout.IncludeFields }

function TppAutoLayout.IncludeFields: Boolean;
begin
  Result := (FFieldComponents.Count > 0);
end; {function, IncludeFields}

{------------------------------------------------------------------------------}
{ TppAutoLayout.IncludeLabelGrid }

function TppAutoLayout.IncludeLabelGrid: Boolean;
begin
  Result := (FLabelGrid.Count > 0);
end; {function, IncludeLabelGrid}


{------------------------------------------------------------------------------}
{ TppAutoLayout.IncludeFieldGrid }

function TppAutoLayout.IncludeFieldGrid: Boolean;
begin
  Result := (FFieldGrid.Count > 0);
end; {function, IncludeFieldGrid}



{------------------------------------------------------------------------------}
{ TppAutoLayout.GetComponentCount }

function TppAutoLayout.GetComponentCount: Integer;
begin
  if IncludeFields then
    Result := FFieldComponents.Count
  else
    Result := FLabelComponents.Count;

end; {function, GetComponentCount}

{------------------------------------------------------------------------------}
{ TppAutoLayoutTabular.CreateLayout }

procedure TppAutoLayoutTabular.CreateLayout;
var
  lLabel: TppLabel;
  lComponent: TppComponent;
  liComponentCount: Integer;
  liIndex: Integer;
  lFrame: TppShape;


begin

  LabelPos := CalcStartingLabelPos;
  FieldPos := CalcStartingFieldPos;

  lLabel := nil;

  if IncludeLabels then
    FLabelBandWidth := TppLabel(FLabelComponents[0]).Band.spWidth;

  if IncludeFields then
    FFieldBandWidth := TppComponent(FFieldComponents[0]).Band.spWidth;

  liComponentCount := GetComponentCount;


  for liIndex := 0 to liComponentCount-1 do
    begin

      if IncludeLabels then
        begin
          lLabel := TppLabel(FLabelComponents[liIndex]);
          lLabel.spLeft := LabelPos.X;
          lLabel.spTop  := LabelPos.Y;

          if IncludeLabelGrid then
            begin
              lFrame := TppShape(FLabelGrid[liIndex]);
              lFrame.Band     := lLabel.Band;
              lFrame.SendToBack;
              lFrame.spLeft   := LabelPos.X - 2;
              lFrame.spTop    := LabelPos.Y - 2;
              lFrame.spWidth  := lLabel.spWidth  + 4;
              lFrame.spHeight := lLabel.spHeight + 4;

            end;

          LabelPos := CalcNextLabelPos(liIndex);

       end;

      if IncludeFields then
        begin
          lComponent := TppComponent(FFieldComponents[liIndex]);
          lComponent.spLeft := FieldPos.X;
          lComponent.spTop  := FieldPos.Y;

          if IncludeFieldGrid then
            begin
              lFrame := TppShape(FFieldGrid[liIndex]);
              lFrame.Band     := lComponent.Band;
              lFrame.SendToBack;
              lFrame.spLeft   := FieldPos.X - 2;
              lFrame.spTop    := FieldPos.Y - 2;
              lFrame.spWidth  := lComponent.spWidth + 4;
              lFrame.ParentHeight := (lLabel = nil) or (lLabel.Band <> lComponent.Band);

              if not lFrame.ParentHeight then
                lFrame.spHeight := lComponent.spHeight + 4;


            end;

          FieldPos := CalcNextFieldPos(liIndex);

        end;

    end;


end; {procedure, CreateLayout}

{------------------------------------------------------------------------------}
{ TppAutoLayoutTabular.CalcStartingLabelPos }

function TppAutoLayoutTabular.CalcStartingLabelPos: TPoint;
var
  lLabel: TppLabel;
  liMaxY: Integer;
  lComponent: TppComponent;
  liIndex: Integer;

begin

  Result := StartingPos;

  if not IncludeLabels then Exit;

  lLabel := TppLabel(FLabelComponents[0]);
  liMaxY := lLabel.Band.spHeight - lLabel.spHeight;
  {liMaxY := lLabel.Band.spHeight - Abs(lLabel.Font.Height) - 3;}

  {leave additional room at bottom of band for the grid line}
  if IncludeLabelGrid then
    liMaxY := liMaxY - 2;

  if (Result.Y > liMaxY) then
    Result.Y := liMaxY;

  lLabel.spLeft := Result.X;
  lLabel.spTop  := Result.Y;

  if IncludeFields then
    for liIndex := 0 to FLabelComponents.Count-1 do
      begin
        lLabel := TppLabel(FLabelComponents[liIndex]);
        lComponent :=  TppComponent(FFieldComponents[liIndex]);

        if lLabel.spWidth < lComponent.spWidth then
          lLabel.spWidth := lComponent.spWidth
        else
          lComponent.spWidth := lLabel.spWidth;

      end;


end; {procedure, CalcStartingLabelPos}

{------------------------------------------------------------------------------}
{ TppAutoLayoutTabular.CalcStartingFieldPos }

function TppAutoLayoutTabular.CalcStartingFieldPos: TPoint;
var
  lComponent: TppComponent;
  liMaxY: Integer;
  lLabel: TppLabel;
  liLabelBottom: Integer;
  liIndex: Integer;
  lFieldBand: TppBand;
  lReport: TppCustomReport;

begin

  Result := StartingPos;

  if not IncludeFields then Exit;

  lComponent := TppComponent(FFieldComponents[0]);
  liMaxY := lComponent.Band.spHeight - Abs(lComponent.Font.Height) - 3;

  if not Includelabels then
    begin

      if (Result.Y > liMaxY) then
        Result.Y := liMaxY;

    end
  else {layout includes labels and fields }
    begin
      lLabel := TppLabel(FLabelComponents[0]);
      liLabelBottom := lLabel.spTop + lLabel.spHeight;
      lReport := lLabel.Band.Report;
      lFieldBand := lComponent.Band;

      {check whether there is room in the band for the fields}
      if (liLabelBottom > liMaxY) then
        begin
          liIndex := lReport.FindBand(lLabel.Band);
          if liIndex < lReport.BandCount-1 then
            lFieldBand := lReport.Bands[liIndex+1]
        end;

      {position fields below labels}
      if lLabel.Band = lFieldBand then
        begin
          Result.Y := liLabelBottom + 5;
          if Result.Y > lFieldBand.spHeight then
            Result.Y := lFieldBand.spHeight - 4;
        end

      else {position fields at top of next band }
        begin
          for liIndex := 0 to FFieldComponents.Count-1 do
            TppComponent(FFieldComponents[liIndex]).Band := lFieldBand;

          Result.Y := 2;
        end;


    end;

  lComponent.spLeft := Result.X;
  lComponent.spTop  := Result.Y;

end; {procedure, CalcStartingFieldPos}

{------------------------------------------------------------------------------}
{ TppAutoLayoutTabular.CalcLineHeight }

function TppAutoLayoutTabular.CalcLineHeight: Integer;
var
  liIndex: Integer;
  liHeight: Integer;

begin

  Result := 0;

  if IncludeFields then
    for liIndex := 0 to FFieldComponents.Count-1 do
      begin
        liHeight := TppComponent(FFieldComponents[liIndex]).spHeight;
        if liHeight > Result then
          Result := liHeight;
      end
  else if IncludeLabels then
    Result := TppComponent(FLabelComponents[0]).spHeight;


end; {procedure, CalcLineHeight}

{------------------------------------------------------------------------------}
{ TppAutoLayoutTabular.CalcNextLabelPos }

function TppAutoLayoutTabular.CalcNextLabelPos(aIndex: Integer): TPoint;
var
  lLabel: TppLabel;

begin

  Result := LabelPos;

  if not IncludeLabels or (aIndex > FLabelComponents.Count-2) then Exit;

  lLabel := TppLabel(FLabelComponents[aIndex]);


  Result.X := LabelPos.X + lLabel.spWidth + 4;

  if Result.X > FLabelBandWidth then
    Result.X := FLabelBandWidth - 10;


end; {procedure, CalcNextLabelPos}


{------------------------------------------------------------------------------}
{ TppAutoLayoutTabular.CalcNextFieldPos }

function TppAutoLayoutTabular.CalcNextFieldPos(aIndex: Integer): TPoint;
var
  lComponent: TppComponent;

begin

  Result := FieldPos;

  if not IncludeFields or (aIndex > FFieldComponents.Count-2) then Exit;

  lComponent :=  TppComponent(FFieldComponents[aIndex]);

  Result.X := FieldPos.X + lComponent.spWidth + 4;

  if Result.X > FFieldBandWidth then
    Result.X := FFieldBandWidth - 10;

end; {procedure, CalcNextFieldPos}


{------------------------------------------------------------------------------}
{ TppAutoLayoutVertical.CreateLayout }

procedure TppAutoLayoutVertical.CreateLayout;
var
  lLabel: TppLabel;
  lComponent: TppComponent;
  liComponentCount: Integer;
  liIndex: Integer;
  lFrame: TppShape;
  liLineHeight: Integer;
  liFieldColWidth: Integer;

begin

  LabelPos := CalcStartingLabelPos;
  FieldPos := CalcStartingFieldPos;

  liComponentCount := GetComponentCount;

  liFieldColWidth := CalcFieldColWidth;


  for liIndex := 0 to liComponentCount-1 do
    begin

      liLineHeight := CalcLineHeight(liIndex);

      if IncludeLabels then
        begin
          lLabel := TppLabel(FLabelComponents[liIndex]);
          lLabel.spLeft := LabelPos.X;
          lLabel.spTop  := LabelPos.Y;
          lLabel.Alignment := taLeftJustify;

         if IncludeLabelGrid then
            begin
              lFrame := TppShape(FLabelGrid[liIndex]);
              lFrame.Band     := lLabel.Band;
              lFrame.spLeft   := LabelPos.X - 2;
              lFrame.spWidth  := lLabel.spWidth + 4;
              lFrame.spHeight := liLineHeight + 4;
              lFrame.spTop := (LabelPos.Y + lLabel.spHeight) - lFrame.spHeight;
            end;
            
         LabelPos := CalcNextLabelPos(liIndex);

       end;

      if IncludeFields then
        begin
          lComponent := TppComponent(FFieldComponents[liIndex]);
          lComponent.spLeft := FieldPos.X;
          lComponent.spTop  := FieldPos.Y;
          lComponent.Alignment := taLeftJustify;

          if IncludeFieldGrid then
            begin
              lFrame := TppShape(FFieldGrid[liIndex]);
              lFrame.Band     := lComponent.Band;
              lFrame.spLeft   := FieldPos.X - 2;
              lFrame.spWidth  := liFieldColWidth + 4;
              lFrame.spHeight := liLineHeight + 4;
              lFrame.spTop := (FieldPos.Y + lComponent.spHeight) - lFrame.spHeight;
            end;

          FieldPos := CalcNextFieldPos(liIndex);

        end;

    end;


end; {procedure, CreateLayout}


{------------------------------------------------------------------------------}
{ TppAutoLayoutVertical.CalcStartingLabelPos }

function TppAutoLayoutVertical.CalcStartingLabelPos: TPoint;
var
  lLabel: TppLabel;
  liIndex: Integer;
  liComponentCount: Integer;
  liMaxWidth: Integer;

begin

  Result := StartingPos;

  if not IncludeLabels then Exit;


  lLabel := TppLabel(FLabelComponents[0]);

  liMaxWidth := 0;

  liComponentCount := GetComponentCount;

  {determine max label width}
  for liIndex := 0 to liComponentCount-1 do
    if liMaxWidth < TppLabel(FLabelComponents[liIndex]).spWidth then
      liMaxWidth := TppLabel(FLabelComponents[liIndex]).spWidth;

  for liIndex := 0 to liComponentCount-1 do
    TppLabel(FLabelComponents[liIndex]).spWidth := liMaxWidth;

  {adjust Y such that Field aligns with bottom of Label}
  Result.Y := StartingPos.Y + (CalcLineHeight(0) - lLabel.spHeight);

 { liMaxY := lLabel.Band.spHeight - Abs(lLabel.Font.Height) - 3;

  if (Result.Y > liMaxY) then
    Result.Y := liMaxY; }

  lLabel.spLeft := Result.X;
  lLabel.spTop  := Result.Y;

end; {procedure, CalcStartingLabelPos}

{------------------------------------------------------------------------------}
{ TppAutoLayoutVertical.CalcStartingFieldPos }

function TppAutoLayoutVertical.CalcStartingFieldPos: TPoint;
var
  lComponent: TppComponent;

begin

  Result := StartingPos;

  if not IncludeFields then Exit;

  lComponent := TppComponent(FFieldComponents[0]);

  if IncludeLabels then
    begin

      Result.X := StartingPos.X + TppLabel(FLabelComponents[0]).spWidth + 4;

      {adjust Y such that Field aligns with bottom of Label}
      Result.Y := StartingPos.Y + (CalcLineHeight(0) - lComponent.spHeight);

    end;

  lComponent.spLeft := Result.X;
  lComponent.spTop  := Result.Y;

end; {procedure, CalcStartingFieldPos}

{------------------------------------------------------------------------------}
{ TppAutoLayoutVertical.CalcNextLabelPos }

function TppAutoLayoutVertical.CalcNextLabelPos(aIndex: Integer): TPoint;
begin

  Result := LabelPos;

  if not IncludeLabels or (aIndex > FLabelComponents.Count-2) then Exit;

  {bottom of current line}
  Result.Y := LabelPos.Y + TppLabel(FLabelComponents[aIndex]).spHeight + 4;

  {adjust top to align with bottom next line}
  Result.Y := Result.Y + CalcLineHeight(aIndex+1) -
                         TppLabel(FLabelComponents[aIndex+1]).spHeight;


  {if Result.X > FLabelBandWidth then
    Result.X := FLabelBandWidth - 10;}


end; {procedure, CalcNextLabelPos}

{------------------------------------------------------------------------------}
{ TppAutoLayoutVertical.CalcNextFieldPos }

function TppAutoLayoutVertical.CalcNextFieldPos(aIndex: Integer): TPoint;
begin

  Result := FieldPos;

  if not IncludeFields or (aIndex > FFieldComponents.Count-2) then Exit;

  {bottom of current line}
  Result.Y := FieldPos.Y + TppComponent(FFieldComponents[aIndex]).spHeight + 4;

  {adjust top to align with bottom next line}
  Result.Y := Result.Y + CalcLineHeight(aIndex+1) -
                         TppComponent(FFieldComponents[aIndex+1]).spHeight;

  {if Result.X > FFieldBandWidth then
    Result.X := FFieldBandWidth - 10;}

end; {procedure, CalcNextFieldPos}

{------------------------------------------------------------------------------}
{ TppAutoLayoutVertical.CalcLineHeight }

function TppAutoLayoutVertical.CalcLineHeight(aIndex: Integer): Integer;
var
  liLabelHeight: Integer;
  liFieldHeight: Integer;

begin


  if IncludeLabels then
    liLabelHeight := TppLabel(FLabelComponents[aIndex]).spHeight
  else
    liLabelHeight := 0;

  if IncludeFields then
    liFieldHeight := TppComponent(FFieldComponents[aIndex]).spHeight
  else
    liFieldHeight := 0;

  if liLabelHeight > liFieldHeight then
    Result := liLabelHeight
  else
    Result := liFieldHeight;

end; {function, CalcLineHeight}


{------------------------------------------------------------------------------}
{ TppAutoLayoutVertical.CalcFieldColWidth }

function TppAutoLayoutVertical.CalcFieldColWidth: Integer;
var
  liIndex: Integer;
  liWidth: Integer;

begin

  Result := 0;

  if not IncludeFields then Exit;

  for liIndex := 0 to FFieldComponents.Count-1 do
    begin
      liWidth := TppComponent(FFieldComponents[liIndex]).spWidth;
      if liWidth > Result then
        Result := liWidth;
    end;

end; {procedure, CalcFieldColWidth}


{******************************************************************************
 *
 **  D A T A  E X P L O R E R
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppDataExplorer.Create }

constructor TppDataExplorer.Create(aParent: TWinControl; aOrientation: TppExplorerOrientation);
begin

  inherited Create(aParent, aOrientation);

  ShowTitlebar := False;

  ListTitleBar.Visible := True;

  TreeView.ShowRoot  := True;
  TreePanel.Height   := 71;


  TreeBuilder := TppDataTreeBuilder.Create(TreeView);

  ListView.OnChange       := ListViewChangeEvent;
  ListView.OnChanging     := ListViewChangingEvent;
  ListView.OnBeforeBuildList := ListViewBeforeBuildListEvent;
{  ListView.OnAfterBuildList  := BuildFieldListEvent;}
  ListView.ReadOnly     := True;
  ListView.MultiSelect  := True;
  ListView.Height := 300;

  Splitter.Top := TreePanel.Height + 1;

  ListBuilder := TppFieldListBuilder.Create(ListView);

  ListView.ClassImages :=  TreeView.ClassImages;

  FSelection  := TList.Create;
  FChangeItemSelected := False;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDataExplorer.Destroy }

destructor TppDataExplorer.Destroy;
begin

  {note: must set these events to nil to avoid access violations}
  ListView.OnChange    := nil;
  ListView.OnChanging  := nil;

  FSelection.Free;

  inherited Destroy;

end; {destructor, Destroy}



{------------------------------------------------------------------------------}
{ TppDataExplorer.ListViewChangeEvent }

procedure TppDataExplorer.ListViewChangingEvent(Sender: TObject; Item: TListItem;
                                                  Change: TItemChange; var AllowChange: Boolean);
begin

  {save Selected state of item that is changing - this value is checked in the Change event}
  FChangeItemSelected := Item.Selected;

end; {procedure, ListViewChangingEvent}

{------------------------------------------------------------------------------}
{ TppDataExplorer.ListViewChangeEvent }

procedure TppDataExplorer.ListViewChangeEvent(Sender: TObject; Item: TListItem; Change: TItemChange);
begin

  if not (Change = ctState) then Exit;

  if (Item.Selected = FChangeItemSelected) then Exit;

  {add/remove item from selection, as needed}
  if Item.Selected and (FSelection.IndexOf(Item) < 0) then
    FSelection.Add(Item)

  else if not Item.Selected then
    FSelection.Remove(Item);

end; {procedure, ListViewChangeEvent}


{------------------------------------------------------------------------------}
{ TppDataExplorer.GetSelectedFields }

procedure TppDataExplorer.GetSelectedFields(aFieldList: TList);
var
  liItem: Integer;
  lItem: TListItem;

begin

  aFieldList.Clear;

  for liItem := 0 to FSelection.Count-1 do
    begin
      lItem := FSelection[liItem];

      {make sure the item is still selected}
      if lItem.Selected then
        aFieldList.Add(TObject(lItem.Data));
    end;

end;  {procedure, GetSelectedFields}

{------------------------------------------------------------------------------}
{ TppDataExplorer.ListViewBeforeBuildListEvent }

procedure TppDataExplorer.ListViewBeforeBuildListEvent(Sender: TObject);
begin
  FSelection.Clear;

end;

{------------------------------------------------------------------------------}
{ TppDataExplorer.SetLanguageIndex }

procedure TppDataExplorer.SetLanguageIndex(aLanguageIndex: Longint);
begin
  ListPanel.Caption :=  ppLoadStr(116); {Data Fields}
end; {procedure, SetLanguageIndex}

{******************************************************************************
 *
 **  D A T A  T R E E   W I N D O W
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppDataTreeWindow.Create }

constructor TppDataTreeWindow.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  Name := 'DataTreeWindow'; // do not localize

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.Destroy }

destructor TppDataTreeWindow.Destroy;
begin

  FDataExplorer.Free;

  FLabelFont.Free;
  FFieldFont.Free;

  FLayoutManager.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.CMVisibleChanged}

procedure TppDataTreeWindow.CMVisibleChanged (var Message: TMessage);
begin

  if (Message.wParam > 0) and not FDockChanging then
    Refresh;

  inherited;

end; {end, CMVisibleChanged}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.CreateControls}

procedure TppDataTreeWindow.CreateControls;
var
  lPage: TPage;
begin

  {$IFDEF Delphi7}
  ParentBackground := False;
  {$ENDIF}

  FTabSet := TppTabSet.Create(Self);
  FTabSet.Parent := Self;
  FTabSet.Align := alBottom;
  FTabSet.Orientation := toBottom;
  FTabSet.CloseButton := False;

  FNoteBook := TNoteBook.Create(Self);
  FNoteBook.Parent := Self;
  FNoteBook.Align := alClient;
  FNoteBook.Pages.Clear;
  FNoteBook.Pages.Add('Data');
  FNoteBook.Pages.Add('Layout');
  FNoteBook.PageIndex := 0;

  FTabSet.AddTab(ppLoadStr(141) {Data});
  FTabSet.AddTab(ppLoadStr(612) {Layout});
  FTabSet.SelectedTab := FTabset.Tabs[0];

  FTabSet.OnTabSelected := ehTabSet_Change;

  lPage := TPage(FNoteBook.Pages.Objects[0]);

  {Note: this object is created when Layout tab first accessec}
  FLayoutManager := nil;

  FDataExplorer := TppDataExplorer.Create(lPage, ppeoVertical);

  FTreeView := FDataExplorer.TreeView;
  FListView := FDataExplorer.ListView;

  FTreeView.BorderStyle := bsNone;
  FListview.BorderStyle := bsNone;

  FListView.OnHelp := DoOnHelp;
  FTreeView.OnHelp := DoOnHelp;

  FListView.Sortable := True;
  FListView.AllowDrag := True;

  {auto layout settings}
  FLabelFont  := TFont.Create;
  FLabelFont.Name  := 'Arial';
  FLabelFont.Style := [fsBold];
  FLabelFont.Size  := 10;

  FFieldFont  := TFont.Create;
  FFieldFont.Assign(FLabelFont);
  FFieldFont.Style := [];

  FLayoutType   := rlTabular;
  FCreateFields := True;
  FCreateLabels := True;
  FLabelGrid    := False;
  FFieldGrid    := False;

  FChangeItemSelected := False;
  FDockChanging := False;

  BuildPopupMenu;

  {set default size and position}
  Left   := 3;
  Top    := 107;
  Width  := 180;
  Height := 305;

  LanguageChanged;


end;

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.BuildPopupMenu }

procedure TppDataTreeWindow.BuildPopupMenu;
var
  lMenuItem: TppTBXItem;
begin

  if FTreeMenu <> nil then
    FTreeMenu.Free;


  FTreeMenu := TppTBXPopupMenu.Create(Self);
  FTreeMenu.Images := ToolImageList;

  lMenuItem := TppTBXItem.Create(FTreeMenu);
  lMenuItem.Caption :=  ppLoadStr(638); {Refresh}
  lMenuItem.Name    := 'mniRefresh';
  lMenuItem.OnClick := TreeMenuItemClickEvent;
  lMenuItem.ImageIndex := ToolImageList.AddIcon('PPREFRESH');

  FTreeMenu.Items.Add(lMenuItem);

  FTreeView.PopupMenu := FTreeMenu;
  FListView.PopupMenu := FTreeMenu;

end; {procedure, BuildPopupMenu}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.LoadPreferences}

procedure TppDataTreeWindow.LoadPreferences(aIniStorage: TppIniStorage);
begin

  if (aIniStorage = nil) then Exit;

  inherited;

  ppLoadFontState(aIniStorage, 'AutoLayout', 'LabelFont', FLabelFont);
  ppLoadFontState(aIniStorage, 'AutoLayout', 'FieldFont', FFieldFont);

  FLayoutType   := TppReportLayoutType(aIniStorage.ReadInteger('AutoLayout', 'LayoutType', 0));
  FCreateLabels := aIniStorage.ReadBool('AutoLayout', 'CreateLabels', True);
  FCreateFields := aIniStorage.ReadBool('AutoLayout', 'CreateFields', True);
  FLabelGrid    := aIniStorage.ReadBool('AutoLayout', 'LabelGrid', False);
  FFieldGrid    := aIniStorage.ReadBool('AutoLayout', 'FieldGrid', False);

end; {procedure, LoadPreferences}


{------------------------------------------------------------------------------}
{ TppDataTreeWindow.SavePreferences}

procedure TppDataTreeWindow.SavePreferences(aIniStorage: TppIniStorage);
begin

  if (aIniStorage = nil) then Exit;

  inherited;

  ppSaveFontState(aIniStorage, 'AutoLayout', 'LabelFont', FLabelFont);
  ppSaveFontState(aIniStorage, 'AutoLayout', 'FieldFont', FFieldFont);

  aIniStorage.WriteInteger('AutoLayout', 'LayoutType', Ord(FLayoutType));
  aIniStorage.WriteBool('AutoLayout', 'CreateLabels', FCreateLabels);
  aIniStorage.WriteBool('AutoLayout', 'CreateFields', FCreateFields);
  aIniStorage.WriteBool('AutoLayout', 'LabelGrid', FLabelGrid);
  aIniStorage.WriteBool('AutoLayout', 'FieldGrid', FFieldGrid);

end; {procedure, SavePreferences}


{------------------------------------------------------------------------------}
{ TppDataTreeWindow.SetLabelFont }

procedure TppDataTreeWindow.SetLabelFont(aFont: TFont);
begin
  FLabelFont.Assign(aFont);
  
end; {procedure, TreeMenuItemClickEvent}


{------------------------------------------------------------------------------}
{ TppDataTreeWindow.SetFieldFont }

procedure TppDataTreeWindow.SetFieldFont(aFont: TFont);
begin
  FFieldFont.Assign(aFont);

end; {procedure, SetFieldFont}


{------------------------------------------------------------------------------}
{ TppDataTreeWindow.SetReport }

procedure TppDataTreeWindow.SetReport(aReport: TppCustomReport);
begin

  inherited;

  FDataExplorer.Report := aReport;


end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.TreeMenuItemClickEvent }

procedure TppDataTreeWindow.TreeMenuItemClickEvent(Sender: TObject);
begin

  if (FTreeMenu.Items[0] = Sender) then
    begin
      Refresh;
    end

end; {procedure, TreeMenuItemClickEvent}


{------------------------------------------------------------------------------}
{ TppDataTreeWindow.Refresh }

procedure TppDataTreeWindow.Refresh;
begin

  FListView.CurrentObject := nil;

  FTreeView.Rebuild;

  if FTreeView.Items.Count > 0 then
    begin
      FTreeView.Selected := FTreeView.Items[0];

      if (FTreeView.Selected.Data <> nil) then
        FListView.CurrentObject := TObject(FTreeView.Selected.Data);
        
    end
  else
    FListView.CurrentObject := nil;

end; {procedure, Refresh}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.PageControlChangingEvent }

procedure TppDataTreeWindow.CreateLayoutManager;
var
  lPage: TPage;
begin

  {create LayoutManager, if needed}
  if (FLayoutManager = nil) then
    begin
      lPage := TPage(FNoteBook.Pages.Objects[1]);

      FLayoutManager := TppAutoLayoutManager.Create(Self, lPage);
      FLayoutManager.LanguageChanged;

      FLayoutManager.LabelFont    := FLabelFont;
      FLayoutManager.FieldFont    := FFieldFont;
      FLayoutManager.LayoutType   := FLayoutType;
      FlayoutManager.CreateLabels := FCreateLabels;
      FLayoutManager.CreateFields := FCreateFields;
      FLayoutManager.LabelGrid    := FLabelGrid;
      FLayoutManager.FieldGrid    := FFieldGrid;

      FLayoutManager.EnableControls;
      FLayoutManager.OnChange := LayoutManagerChangeEvent;
    end;

end; {procedure, PageControlChangingEvent}



{------------------------------------------------------------------------------}
{ TppDataTreeWindow.LayoutManagerChangeEvent }

procedure TppDataTreeWindow.LayoutManagerChangeEvent(Sender: TObject);
begin

  FLabelFont.Assign(FLayoutManager.LabelFont);
  FFieldFont.Assign(FLayoutManager.FieldFont);
  FLayoutType   := FLayoutManager.LayoutType;
  FCreateLabels := FlayoutManager.CreateLabels;
  FCreateFields := FLayoutManager.CreateFields;
  FLabelGrid    := FLayoutManager.LabelGrid;
  FFieldGrid    := FLayoutManager.FieldGrid;

end; {procedure, LayoutManagerChangeEvent}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.CreateComponentsForFields }

procedure TppDataTreeWindow.CreateComponentsForFields(aBand: TppBand; X, Y: Integer; var aComponents: TList);
var
  liField: Integer;
  lFields: TList;
  lField: TppField;
  lLayout: TppAutoLayout;
  lLabel: TppLabel;
  lComponent: TppComponent;
  lFrame: TppShape;

begin

  lFields := TList.Create;

  FDataExplorer.GetSelectedFields(lFields);

  if (FLayoutType = rlVertical) then
    lLayout := TppAutoLayoutVertical.Create
  else
    lLayout := TppAutoLayoutTabular.Create;

  lLayout.StartingPos := Point(X,Y);

  {create the field and label components}
  for liField := 0 to lFields.Count-1 do
    begin
      lField := TppField(lFields[liField]);

      if FCreateLabels then
        begin
          lLabel := gcLayoutFactory.CreateLabelForField(Report, aBand, lField, FLabelFont);
          lLayout.LabelComponents.Add(lLabel);
          aComponents.Add(lLabel);

          if FLabelGrid then
            begin
              lFrame := gcLayoutFactory.CreateFrameForComponent(Report, lLabel);
              lLayout.LabelGrid.Add(lFrame);
              aComponents.Add(lFrame);
            end;
        end;


      if FCreateFields then
        begin
          lComponent := gcLayoutFactory.CreateComponentForField(Report, aBand, lField, FFieldFont);
          lLayout.FieldComponents.Add(lComponent);
          aComponents.Add(lComponent);

          if FFieldGrid then
            begin
              lFrame := gcLayoutFactory.CreateFrameForComponent(Report, lComponent);
              lLayout.FieldGrid.Add(lFrame);
              aComponents.Add(lFrame);
            end;
       end;

    end;

  lLayout.CreateLayout;

  lLayout.Free;  

  lFields.Free;

end;   {procedure, CreateComponentsForFields}

procedure TppDataTreeWindow.ehReport_LoadEnd(Sender, aParameters: TObject);
begin
  if Visible then
    Refresh;
end;

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.ehTabSet_Change }

procedure TppDataTreeWindow.ehTabSet_Change(Sender: TObject; Item: TppJvTabBarItem);
//procedure TppDataTreeWindow.ehTabSet_Change(Sender: TObject; aNewTab: Integer; var aAllowChange: Boolean);
begin

//  FNoteBook.PageIndex := aNewTab;

  FNoteBook.PageIndex := Item.Index;

  if (FLayoutManager = nil) then
    CreateLayoutManager;

end;

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.ehWorkspace_DragDrop }

procedure TppDataTreeWindow.ehWorkspace_DragDrop(Sender, aParameters: TObject);
var
  lDragDropParams: TppDragDropEventParams;
  lBand: TppBand;
  lComponents: TList;
  liIndex: Integer;
  lPoint : TPoint;
  lComponent: TppComponent;
  lDesignControl: TppDesignControl;
  lWorkspaceController: TppDesignWorkspaceController;

begin

  lDragDropParams := TppDragDropEventParams(aParameters);

   {did we drag a component from the data tree to the workspace?}
  if (FListView <> lDragDropParams.Source) then Exit;

  lWorkspaceController := DesignControllers.WorkspaceController;

  if not lWorkspaceController.CheckComponentAdd then Exit;

  {convert X,Y coordinates from Sender to Workspace}
  lPoint := lWorkspaceController.WorkSpace.ScreenToClient( (Sender as TControl).ClientToScreen(lDragDropParams.CursorPos));

  lBand := lWorkspaceController.GetBandForPos(lPoint.Y);

  {adjust value of Y for the band.top}
  lPoint.Y := lPoint.Y - lBand.spTop;

  BeginUpdate;
  lWorkspaceController.UndoManager.Active := False;
  lComponents := TList.Create;

  {select the newly created components }
  lWorkspaceController.Selection.BeginUpdate;

  try

    CreateComponentsForFields(lBand, lPoint.X, lPoint.Y, lComponents);

    lWorkspaceController.Selection.Clear;

    for liIndex := 0 to lComponents.Count-1 do
      begin
        lComponent := TppComponent(lComponents[liIndex]);
        lDesignControl := lWorkspaceController.DesignControlManager.DesignControls[lComponent];
        lComponent.DSInclude([pppcCreating]);
        lComponent.Region := lWorkspaceController.GetRegionForPos(Point(lDesignControl.Left, lDesignControl.Top));

        {allow component to perform any design time intitializations}
        lComponent.AfterDesignerCreate;

        {fire event}
         EventHub.EndUserEvents.mcCreateComponent.Notify(Self, lComponent);

        lWorkspaceController.Selection.Add(lComponent);
        lComponent.DSExclude([pppcCreating]);
     end;

  finally
    lWorkspaceController.Selection.EndUpdate;
    lWorkspaceController.UndoManager.Active := True;
    lWorkspaceController.UndoManager.BeginTask;

    for liIndex := 0 to lComponents.Count-1 do
      begin
        lComponent := TppComponent(lComponents[liIndex]);
        lWorkspaceController.UndoManager.AddOperation('CreateComponent', lComponent);
      end;

    lWorkspaceController.UndoManager.EndTask;

    EndUpdate;

    lComponents.Free;

  end;

end;

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.SetLanguageIndex }

procedure TppDataTreeWindow.LanguageChanged;
begin

  inherited;

  Caption := ppLoadStr(639); {Data Tree};

//  FTabSet.Tabs[0] := ppLoadStr(141); {Data};
//  FTabSet.Tabs[1] := ppLoadStr(612); {Layout};
  FTabSet.Tabs[0].Caption := ppLoadStr(141); {Data};
  FTabSet.Tabs[1].Caption := ppLoadStr(612); {Layout};

  FDataExplorer.ListTitleBar.Caption := ppLoadStr(116); {Data Fields};

  FTreeMenu.Items[0].Caption := ppLoadStr(638); {Refresh}


  if (FLayoutManager <> nil) then
    FLayoutManager.LanguageChanged;

end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{TppReportTreeWindow.SetEventHub}

procedure TppDataTreeWindow.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (EventHub <> aEventHub) then
    begin
      if (EventHub <> nil) and not(csDestroying in EventHub.ComponentState) then
        begin
          EventHub.ReportEvents.mcLoadEnd.RemoveNotify(ehReport_LoadEnd);
          EventHub.WorkspaceEvents.mcDragDrop.RemoveNotify(ehWorkspace_DragDrop);
         end;

      inherited;

      if (EventHub <> nil) then
        begin
          EventHub.ReportEvents.mcLoadEnd.AddNotify(ehReport_LoadEnd);
          EventHub.WorkspaceEvents.mcDragDrop.AddNotify(ehWorkspace_DragDrop);
         end;

    end;
  
end;

procedure TppDataTreeWindow.ShowingChanged(aVisible: Boolean);
begin

  if Showing then
    Refresh();

end;


{******************************************************************************
 *
 **  R E P O R T   T R E E   W I N D O W
 *
{******************************************************************************}

const
  itReportTree = 0;
  itInspector = 1;
  itReportOutline = 2;
  itNewItem = 3;
  itRenameItem = 4;
  itDeleteItem = 6;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.Create}

constructor TppReportTreeWindow.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  Name := 'NewReportTreeWindow'; // do not localize

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.Destroy}

destructor TppReportTreeWindow.Destroy;
begin

  FTreeStates.Free;
  FReportTreeBuilder.Free;
  FObjectTreeBuilder.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.AddChildReport                                           }

procedure TppReportTreeWindow.AddChildReport(const aCaption: String; aChildReport: TComponent);
begin

  FActive := False;

  FReportTree.AddComponent(aChildReport);
  FActive := True;

  {set report tree to visible, if this is the first child report added}
  if (FReportTree.Items.Count = 2) then
    SetReportTreeVisible(True);


end; {procedure, AddChildReport}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.AllowTreeNodeEditText }

function TppReportTreeWindow.AllowTreeNodeEditText(aNode: TTreeNode): Boolean;
var
  lNodeObject: TObject;
begin

  lNodeObject := TObject(aNode.Data);

  Result := (lNodeObject is TppComponent) or (lNodeObject is TppChildReport) or (lNodeObject is TppParameter);

end; {procedure, AllowTreeNodeEditText}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.TreeViewEditingEvent }

procedure TppReportTreeWindow.ehTreeView_Editing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
begin

  AllowEdit := AllowTreeNodeEditText(Node);

end; {procedure, TreeViewEditingEvent}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehTreeView_Edited }

procedure TppReportTreeWindow.ehTreeView_Edited(Sender: TObject; Node: TTreeNode; var S: string);
var
  lNodeObject: TppCommunicator;
  liStringId: Integer;
  lsMessage: String;
begin

  lNodeObject := TppComponent(Node.Data);

  if (lNodeObject = nil) then Exit;

  if (lNodeObject is TppChildReport) then
    lNodeObject := TppChildReport(lNodeObject).Parent;

  {try to set user name}
  lNodeObject.UserName := S;

  {reassign the user name in case it was not valid}
  if lNodeObject.UserName <> S then
    begin
      if not IsValidIdent(S) then

       {<name> is not a valid identifier'}
       liStringId := 640
      else
       {<name> is not a unique identifier'}
        liStringId := 641;

      {format the message}
      lsMessage := ppLoadStr(liStringId);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [S]);

//TODO      DoOnMessage(lsMessage);

      S := lNodeObject.UserName;
    end;


end; {procedure, TreeViewEditedEvent}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.SetSelectedComponent }

procedure TppReportTreeWindow.SetSelectedComponent(const Value: TComponent);
begin

  if (Value <> nil) and (csDestroying in Value.ComponentState) then Exit;


  if not(FObjectTree.SelectedComponent = Value) then
    if (Value = Report) then
      FObjectTree.SelectComponent(nil)
    else
      FObjectTree.SelectComponent(Value);

  FInspector.SelectObject(Value);

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.BuildPopupMenu }

procedure TppReportTreeWindow.BuildPopupMenu;
var
  lMenuItem: TppTBXItem;
  lSeparator: TppTBXSeparatorItem;
begin

  if FPopupMenu <> nil then
    FPopupMenu.Free;

  FPopupMenu := TppTBXPopupMenu.Create(Self);
  FPopupMenu.OnPopup := ehPopupMenu_Popup;

  lMenuItem := TppTBXItem.Create(FPopupMenu);
  lMenuItem.Caption := ppLoadStr(390); {Report Outline}
  lMenuItem.Name    := 'mniReportOutline';
  lMenuItem.OnClick := ehPopupMenu_ItemClick;

  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TppTBXItem.Create(FPopupMenu);
  lMenuItem.Caption := ppLoadStr(1157); {Object Inspector}
  lMenuItem.Name    := 'mniObjectInspector';
  lMenuItem.OnClick := ehPopupMenu_ItemClick;

  FPopupMenu.Items.Add(lMenuItem);

  lSeparator := TppTBXSeparatorItem.Create(FPopupMenu);
  lSeparator.Name    := 'mniLine1';

  FPopupMenu.Items.Add(lSeparator);

  FPopupMenu.Items[itReportOutline].Checked := False;
  FPopupMenu.Items[itInspector].Checked := True ;

  lMenuItem := TppTBXItem.Create(FPopupMenu);
  lMenuItem.Caption :=  ppLoadStr(156);
  lMenuItem.Name    := 'mniNew';
  lMenuItem.OnClick := ehPopupMenu_ItemClick;

  FPopupMenu.Items.Add(lMenuItem);

  lMenuItem := TppTBXItem.Create(FPopupMenu);
  lMenuItem.Caption :=  ppLoadStr(542); {Rena&me}
  lMenuItem.Name    := 'mniRename';
  lMenuItem.OnClick := ehPopupMenu_ItemClick;

  FPopupMenu.Items.Add(lMenuItem);

  lSeparator := TppTBXSeparatorItem.Create(FPopupMenu);
  lSeparator.Name    := 'mniLine2';

  FPopupMenu.Items.Add(lSeparator);

  lMenuItem := TppTBXItem.Create(FPopupMenu);
  lMenuItem.Caption :=  ppLoadStr(547);
  lMenuItem.Name    := 'mniDelete';
  lMenuItem.OnClick := ehPopupMenu_ItemClick;

  FPopupMenu.Items.Add(lMenuItem);

  FReportTree.PopupMenu := FPopupMenu;
  FObjectTree.PopupMenu := FPopupMenu;
  FInspector.PopupMenu := FPopupMenu;

  PopupMenu := FPopupMenu;


end; {procedure, BuildPopupMenu}


{------------------------------------------------------------------------------}
{ TppReportTreeWindow.CreateControls

  ClientPanel (alClient)
    ReportPanel (alTop)
      ReportTree (alTop)
      ReportTreeSplitter (alTop)
      ObjectTree (alClient)
    InspectorSplitter (alTop)
    Inspector Panel (alClient)
      Inspector TitleBar (alTop)
      Inspector (alClient) }

procedure TppReportTreeWindow.CreateControls;
begin

  FActive := True;


  {set default size and position}
  Left   := 3;
  Top    := 107;
  Width  := 180;
  Height := 305;

  FClientPanel := TPanel.Create(Self);
  FClientPanel.Parent := Self;
  FClientPanel.BevelOuter := bvNone;
  FClientPanel.Align := alClient;

  {$IFDEF Delphi7}
  FClientPanel.ParentColor := True;
  FClientPanel.ParentBackground := True;
  {$ENDIF}

  FReportPanel := TPanel.Create(Self);
  FReportPanel.Parent := FClientPanel;
  FReportPanel.BevelOuter := bvNone;
  FReportPanel.Width  := 250;
  FReportPanel.Height := 100;
  FReportPanel.Align  := alTop;

  {$IFDEF Delphi7}
  FReportPanel.ParentColor := True;
  FReportPanel.ParentBackground := True;
  {$ENDIF}


  {create horizontal splitter}
  FInspectorSplitter := TSplitter.Create(Self);
  FInspectorSplitter.Parent  := FClientPanel;
  FInspectorSplitter.Width   := 3;
  FInspectorSplitter.Cursor  := crVSplit;
  FInspectorSplitter.Beveled := False;
  FInspectorSplitter.MinSize := 20;
  FInspectorSplitter.AutoSnap := False; // enforce the min size
  FInspectorSplitter.Align   := alTop;
  FInspectorSplitter.Top := FReportPanel.Top + FReportPanel.Height + 1;
 // FInspectorSplitter.ResizeStyle := rsUpdate;
  FInspectorSplitter.ParentColor := True;


  FInspectorPanel := TPanel.Create(Self);
  FInspectorPanel.Parent := FClientPanel;
  FInspectorPanel.Top := FClientPanel.Height-200;
  FInspectorPanel.Height := 200;
  FInspectorPanel.BevelOuter := bvNone;
  FInspectorPanel.Align := alClient;

  {$IFDEF Delphi7}
  FInspectorPanel.ParentColor := True;
  FInspectorPanel.ParentBackground := True;
  {$ENDIF}


  FReportTree := TppReportTreeView.Create(Self);
  FReportTree.Parent      := FReportPanel;
  FReportTree.BevelOuter  := bvNone;
  FReportTree.Height      := 71;
  FReportTree.Align       := alTop;
  FReportTree.ShowRoot    := True;
  FReportTree.OnChange    := ehReportTree_Change;
  FReportTree.OnEditing   := ehTreeView_Editing;
  FReportTree.OnEdited    := ehTreeView_Edited;
  FReportTree.BorderStyle := bsNone;

  FReportTreeBuilder := TppReportOutlineTreeBuilder.Create(FReportTree);
  FReportTree.OnHelp := DoOnHelp;

//  FReportTree.MultiSelect := True;
//  FReportTree.MultiSelectStyle := [msControlSelect];

  {create horizontal splitter}
  FReportTreeSplitter := TSplitter.Create(Self);
  FReportTreeSplitter.Parent  := FReportPanel;
  FReportTreeSplitter.Width   := 3;
  FReportTreeSplitter.Cursor  := crVSplit;
  FReportTreeSplitter.Beveled := False;
  FReportTreeSplitter.Top := FReportTree.Top + FReportTree.Height+1;
  FReportTreeSplitter.Align   := alTop;
  FReportTreeSplitter.MinSize := 40;
  FReportTreeSplitter.ParentColor := True;
  FReportTreeSplitter.AutoSnap := False; // enforce the min size

  FObjectTree := TppReportTreeView.Create(Self);
  FObjectTree.Parent      := FReportPanel;
  FObjectTree.BevelOuter  := bvNone;
  FObjectTree.Align       := alClient;
//TODO  FObjectTree.ShowRoot    := False;
  FObjectTree.ShowRoot    := True;
  FObjectTree.OnChange    := ehObjectTree_Change;
  FObjectTree.OnEditing   := ehTreeView_Editing;
  FObjectTree.OnEdited    := ehTreeView_Edited;
  FObjectTree.OnHelp      := DoOnHelp;
  FObjectTree.BorderStyle := bsNone;

  FObjectTree.ClassImages := TppClassImageList.Create(Self);

  FObjectTreeBuilder := TppReportObjectTreeBuilder.Create(FObjectTree);
  FObjectTreeBuilder.Localize := True;
  FObjectTreeBuilder.ShowParameters := True;
  FObjectTreeBuilder.ShowGroups := True;

  FTreeStates := TppTreeStates.Create(nil);

  FInpectorTitleBar := TppBevel.Create(Self);
  FInpectorTitleBar.Parent := FInspectorPanel;
  FInpectorTitleBar.BevelOuter := bvLowered;
  FInpectorTitleBar.Align  := alTop;
  FInpectorTitleBar.Height := 21;
  FInpectorTitleBar.Caption := 'Properties ';
  FInpectorTitleBar.Alignment := taLeftJustify;

  {$IFDEF Delpih9}
  FInpectorTitleBar.ParentBackground := False;
  {$ENDIF}

  FInspector := TppInspector.Create(Self);
  FInspector.Parent := FInspectorPanel;
  FInspector.Align := alClient;
  FInspector.OnSelectComponent := ehInspectorSelectComponent;
  FInspector.BevelOuter := bvNone;
  FInspector.DesignControllers := DesignControllers;

  BuildPopupMenu;

  LanguageChanged;

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehComponent_Add}

procedure TppReportTreeWindow.ehComponent_Add(Sender, aParameters: TObject);
var
  lNode: TTreeNode;
begin

  FActive := False;

  try

    if (aParameters is TComponent) then
      if not(FObjectTree.FindComponentNode(TComponent(aParameters), lNode)) then
        FObjectTree.AddComponent(TComponent(aParameters));

  finally
    FActive := True;
  end;

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehComponent_AfterPropertyChange}

procedure TppReportTreeWindow.ehComponent_AfterPropertyChange(Sender, aParameters: TObject);
begin

  if (Sender = FInspector.SelectedComponent) then
    FInspector.Invalidate;

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehComponent_Remove}

procedure TppReportTreeWindow.ehComponent_Remove(Sender, aParameters: TObject);
begin

  FActive := False;

  try
  
    if (aParameters is TComponent) then
      FObjectTree.RemoveComponent(TComponent(aParameters));

  finally
    FActive := True;
  end;

//  FInspector.SelectObject(FObjectTree.SelectedComponent);

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehComponent_Update}

procedure TppReportTreeWindow.ehComponent_Update(Sender, aParameters: TObject);
begin

  FActive := False;

  try

    if (aParameters is TComponent) then
      FObjectTree.UpdateComponent(TComponent(aParameters));

  finally
    FActive := True;
  end;



end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehInspectorSelectComponent}

procedure TppReportTreeWindow.ehInspectorSelectComponent(Sender: TObject);
var
  lsMessage: String;
begin

    if (FInspector.SelectedComponent is TppCommunicator) then
      begin
        lsMessage := ppLoadStr(963); {'Properties for <name>'}
        lsMessage := ppSetMessageParameters(lsMessage);
        lsMessage := Format(lsMessage, [TppCommunicator(FInspector.SelectedComponent).UserName]);

        FInpectorTitleBar.Caption := lsMessage;
      end;

end;


{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehPopupMenu_ItemClick}

procedure TppReportTreeWindow.ehPopupMenu_ItemClick(Sender: TObject);
var
  lParamList: TppParameterList;
  lParameter: TppParameter;
begin

  if (FPopupMenu.Items[itReportTree] = Sender) then
    SetReportTreeVisible(not(FReportTree.Visible))

  else if (FPopupMenu.Items[itInspector] = Sender) then
    SetInspectorVisible(not(FInspectorPanel.Visible))

  else if (FPopupMenu.Items[itRenameItem] = Sender) then
    begin

      if FObjectTree.Focused and (FObjectTree.Selected <> nil) then
        FObjectTree.Selected.EditText
      else if FReportTree.Focused and (FReportTree.Selected <> nil) then
        FReportTree.Selected.EditText;

    end
  else if (FPopupMenu.Items[itNewItem] = Sender) then
    begin
      // add a parameter
      lParamList := TppReport(FObjectTree.Report).Parameters;
      lParameter := lParamList.Add();

      // update the treeview, select the node, and put it into edit state
      FObjectTree.AddComponent(lParameter);
      FObjectTree.SelectComponent(lParameter);
      FObjectTree.Selected.EditText;


    end
  else if (FPopupMenu.Items[itDeleteItem] = Sender) then
    begin
      lParameter := TppParameter(FObjectTree.SelectedComponent);

      FObjectTree.RemoveComponent(lParameter);

      lParameter.Free;

    end;

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehPopupMenu_Popup}

procedure TppReportTreeWindow.ehPopupMenu_Popup(Sender: TObject);
begin

  FPopupMenu.Items[itReportTree].Checked := FReportTree.Visible;
  FPopupMenu.Items[itInspector].Checked := FInspectorPanel.Visible;

  {enable Rename option as needed}
  FPopupMenu.Items[itRenameItem].Enabled := False;
  FPopupMenu.Items[itNewItem].Enabled := False;
  FPopupMenu.Items[itDeleteItem].Enabled := False;

  if FObjectTree.Focused then
    begin
      FPopupMenu.Items[itRenameItem].Enabled :=  (FObjectTree.Selected <> nil) and
                                    AllowTreeNodeEditText(FObjectTree.Selected);

      FPopupMenu.Items[itNewItem].Enabled := (FObjectTree.SelectedComponent is TppParameterList) or
                                             (FObjectTree.SelectedComponent is TppParameter);
      FPopupMenu.Items[itDeleteItem].Enabled :=  (FObjectTree.SelectedComponent is TppParameter);
    end
  else if FReportTree.Focused then
    FPopupMenu.Items[itRenameItem].Enabled :=  (FReportTree.Selected <> nil) and
                                    AllowTreeNodeEditText(FReportTree.Selected);

  // hide report tree and inspector items when paramlist/param selected
  if (FObjectTree.SelectedComponent is TppParameterList) or (FObjectTree.SelectedComponent is TppParameter) then
    FPopupMenu.Items[itReportTree].Visible := False
  else
    FPopupMenu.Items[itReportTree].Visible := True;

  FPopupMenu.Items[itInspector].Visible := FPopupMenu.Items[itReportTree].Visible;

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehSelection_SelectComponent}

procedure TppReportTreeWindow.ehSelection_SelectComponent(Sender, aParameters: TObject);
begin

  if (aParameters is TComponent) then
    SelectedComponent := TComponent(aParameters);

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.GetSelectedComponent}

function TppReportTreeWindow.GetSelectedComponent: TComponent;
begin

  if (FObjectTree.Selected = nil) then
    Result := nil
  else
    Result := TComponent(FObjectTree.Selected.Data);

end; {procedure, GetSelectedComponent}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.GetSelectedReport}

function TppReportTreeWindow.GetSelectedReport: TComponent;
begin

  if (FReportTree.Selected = nil) then
    Result := nil
  else
    Result := TComponent(FReportTree.Selected.Data);

end; {procedure, GetSelectedComponent}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ObjectTreeChangeEvent }

procedure TppReportTreeWindow.ehObjectTree_Change(Sender: TObject; Node: TTreeNode);
begin

  if not FActive then Exit;

  if FObjectTree.Building then Exit;

  if DesignControllers.WorkspaceView.Selection.GetSelectedComponent = FObjectTree.SelectedComponent then Exit;

  FActive := False;

  try
//    FInspector.SelectObject(FObjectTree.SelectedComponent);

    if (FObjectTree.SelectedComponent is TppGroup) then
      DesignControllers.WorkspaceView.Selection.SetSelection(TppGroup(FObjectTree.SelectedComponent))
    else if (FObjectTree.SelectedComponent is TppBand) then
      DesignControllers.WorkspaceView.Selection.SetSelection(TppBand(FObjectTree.SelectedComponent))
    else if (FObjectTree.SelectedComponent is TppComponent) then
      DesignControllers.WorkspaceView.Selection.SetSelection(TppComponent(FObjectTree.SelectedComponent))
    else if (FObjectTree.SelectedComponent is TppParameter) then
      DesignControllers.WorkspaceView.Selection.SetSelection(TppParameter(FObjectTree.SelectedComponent))
    else //if (FObjectTree.SelectedComponent is TppReport) then
      DesignControllers.WorkspaceView.Selection.Clear;

  finally
    FActive := True;

  end; {try, finally}

end; {procedure, ObjectTreeChangeEvent}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ReportTreeChangeEvent }

procedure TppReportTreeWindow.ehReportTree_Change(Sender: TObject; Node: TTreeNode);
var
  lReport: TppCustomReport;
begin

  if not FActive then Exit;

  if FReportTree.Building then Exit;

  FActive := False;

  try
    lReport := TppCustomReport(GetSelectedReport);
    DesignControllers.WorkspaceView.Selection.SelectReport(lReport);

  finally
    FActive := True;

  end; {try, finally}

end; {procedure, ReportTreeChangeEvent}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehReport_AddSubreport }

procedure TppReportTreeWindow.ehReport_AddSubreport(Sender, aParameters: TObject);
var
  lChildReport: TppChildReport;
begin

  lChildReport := TppChildReport(aParameters);

   AddChildReport(lChildReport.Caption, lChildReport);

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehReport_RemoveSubreport }

procedure TppReportTreeWindow.ehReport_RemoveSubreport(Sender, aParameters: TObject);
begin

  RemoveChildReport(TppChildReport(aParameters));

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehReport_CaptionChange }

procedure TppReportTreeWindow.ehReport_CaptionChange(Sender, aParameters: TObject);
begin

  FActive := False;

  try

    if (aParameters is TComponent) then
      FReportTree.UpdateComponent(TComponent(aParameters));

  finally
    FActive := True;
  end;



end;

procedure TppReportTreeWindow.ehReport_LoadEnd(Sender, aParams: TObject);
begin
  Refresh;
end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehSelection_AfterChange }

procedure TppReportTreeWindow.ehSelection_AfterChange(Sender, aParameters: TObject);
begin

  SetSelectedComponent(DesignControllers.WorkspaceView.Selection.GetSelectedComponent);

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.ehSelection_SelectReport }

procedure TppReportTreeWindow.ehSelection_SelectReport(Sender, aParameters: TObject);
begin

  SetReport(TppCustomReport(aParameters));

end;



{------------------------------------------------------------------------------}
{ TppReportTreeWindow.LanguageChanged }

procedure TppReportTreeWindow.LanguageChanged;
begin

  inherited;

  Caption := ppLoadStr(391); {Report Tree}

  FPopupMenu.Items[itReportTree].Caption := ppLoadStr(390);  {Report Outline}
  FPopupMenu.Items[itInspector].Caption := ppLoadStr(1157); {Object Inspector}
  FPopupMenu.Items[itRenameItem].Caption := ppLoadStr(542); {Rename}

  Refresh;

end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.LoadPreferences}

procedure TppReportTreeWindow.LoadPreferences(aIniStorage: TppIniStorage);
var
  lbVisible: Boolean;
begin

  if (aIniStorage = nil) then Exit;

  inherited;

  // panel heights
  FReportPanel.Height    := aIniStorage.ReadInteger('ReportOutline', 'ReportOutlineHeight', FReportPanel.Height);
  FObjectTree.Height    := aIniStorage.ReadInteger('ReportOutline', 'ObjectOutlineHeight', FObjectTree.Height);
  FInspectorPanel.Height := aIniStorage.ReadInteger('ReportOutline', 'ObjectInspectorHeight', FInspectorPanel.Height);
  FSaveInspectorPanelHeight := FInspectorPanel.Height;

  // panel visibility
  lbVisible := aIniStorage.ReadBool('ReportOutline', 'ObjectInspectorVisible', FInspectorPanel.Visible);
  SetInspectorVisible(lbVisible);

  lbVisible :=  aIniStorage.ReadBool('ReportOutline', 'ReportOutlineVisible', FReportTree.Visible);
  SetReportTreeVisible(lbVisible);

  FInspector.Divider := aIniStorage.ReadInteger('ReportOutline', 'ObjectInspectorDivider', FInspector.Divider);

end; {procedure, LoadPreferences}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.Refresh}

procedure TppReportTreeWindow.Refresh;
var
  lSelectedComponent: TComponent;
begin

  lSelectedComponent := FReportTree.SelectedComponent;
  FReportTree.BeginUpdate;
  FReportTree.Rebuild;
  FReportTree.EndUpdate;
  FReportTree.SelectComponent(lSelectedComponent);

  SetReportTreeVisible(FReportTree.Items.Count > 1);


  FObjectTree.BeginUpdate;
  FObjectTree.Rebuild;
  FObjectTree.EndUpdate;



end; {procedure, Refresh}

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.RemoveChildReport                                        }

procedure TppReportTreeWindow.RemoveChildReport(aChildReport: TComponent);
begin

  FActive := False;

  FReportTree.RemoveComponent(aChildReport);
  FActive := True;

  {set report tree to invisible, if only the main report is left }
  if (FReportTree.Items.Count = 1) then
    SetReportTreeVisible(False);

end; {procedure, RemoveChildReport}

{------------------------------------------------------------------------------}
{ TppDataTreeWindow.SavePreferences}

procedure TppReportTreeWindow.SavePreferences(aIniStorage: TppIniStorage);
begin

  if (aIniStorage = nil) then Exit;

  inherited;

  // panel heights
  aIniStorage.WriteInteger('ReportOutline', 'ReportOutlineHeight', FReportPanel.Height);
  aIniStorage.WriteInteger('ReportOutline', 'ObjectOutlineHeight', FObjectTree.Height);
  aIniStorage.WriteInteger('ReportOutline', 'ObjectInspectorHeight', FInspectorPanel.Height);

  // panel visibility
  aIniStorage.WriteBool('ReportOutline', 'ReportOutlineVisible', FReportTree.Visible);
  aIniStorage.WriteBool('ReportOutline', 'ObjectInspectorVisible', FInspectorPanel.Visible);

  aIniStorage.WriteInteger('ReportOutline', 'ObjectInspectorDivider', FInspector.Divider);

end; {procedure, SavePreferences}

{------------------------------------------------------------------------------}
{TppReportTreeWindow.SetEventHub}

procedure TppReportTreeWindow.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (EventHub <> aEventHub) then
    begin
      if (EventHub <> nil) and not(csDestroying in EventHub.ComponentState) then
        begin
          EventHub.SelectionEvents.mcAfterChange.RemoveNotify(ehSelection_AfterChange);
          EventHub.SelectionEvents.mcSelectReport.RemoveNotify(ehSelection_SelectReport);
          EventHub.SelectionEvents.mcSelectBand.RemoveNotify(ehSelection_SelectComponent);
          EventHub.SelectionEvents.mcSelectComponent.RemoveNotify(ehSelection_SelectComponent);

          EventHub.ComponentEvents.mcAdd.RemoveNotify(ehComponent_Add);
          EventHub.ComponentEvents.mcAfterPropertyChange.RemoveNotify(ehComponent_AfterPropertyChange);
          EventHub.ComponentEvents.mcRemove.RemoveNotify(ehComponent_Remove);
          EventHub.ComponentEvents.mcUpdate.RemoveNotify(ehComponent_Update);
          EventHub.ComponentEvents.mcNameChange.RemoveNotify(ehComponent_Update);

          EventHub.BandEvents.mcAdd.RemoveNotify(ehComponent_Add);
          EventHub.BandEvents.mcRemove.RemoveNotify(ehComponent_Remove);

          EventHub.ReportEvents.mcAddSubreport.RemoveNotify(ehReport_AddSubreport);
          EventHub.ReportEvents.mcRemoveSubreport.RemoveNotify(ehReport_RemoveSubreport);
          EventHub.ReportEvents.mcCaptionChange.RemoveNotify(ehReport_CaptionChange);
          EventHub.ReportEvents.mcLoadEnd.RemoveNotify(ehReport_LoadEnd);

        end;

      inherited;

      if (EventHub <> nil) then
        begin
          EventHub.SelectionEvents.mcAfterChange.PrependNotify(ehSelection_AfterChange);
          EventHub.SelectionEvents.mcSelectReport.AddNotify(ehSelection_SelectReport);
          EventHub.SelectionEvents.mcSelectReport.PrependNotify(ehSelection_SelectReport);
          EventHub.SelectionEvents.mcSelectBand.PrependNotify(ehSelection_SelectComponent);
          EventHub.SelectionEvents.mcSelectComponent.PrependNotify(ehSelection_SelectComponent);

          EventHub.ComponentEvents.mcAdd.AddNotify(ehComponent_Add);
          EventHub.ComponentEvents.mcAfterPropertyChange.AddNotify(ehComponent_AfterPropertyChange);
          EventHub.ComponentEvents.mcRemove.AddNotify(ehComponent_Remove);
          EventHub.ComponentEvents.mcUpdate.AddNotify(ehComponent_Update);
          EventHub.ComponentEvents.mcNameChange.AddNotify(ehComponent_Update);

          EventHub.BandEvents.mcAdd.AddNotify(ehComponent_Add);
          EventHub.BandEvents.mcRemove.AddNotify(ehComponent_Remove);

          EventHub.ReportEvents.mcAddSubreport.AddNotify(ehReport_AddSubreport);
          EventHub.ReportEvents.mcRemoveSubreport.AddNotify(ehReport_RemoveSubreport);
          EventHub.ReportEvents.mcCaptionChange.AddNotify(ehReport_CaptionChange);
          EventHub.ReportEvents.mcLoadEnd.AddNotify(ehReport_LoadEnd);

        end;

    end;
  
end;

procedure TppReportTreeWindow.SetInspectorVisible(aVisible: Boolean);
begin

  if (FInspectorPanel.Visible) then
    FSaveInspectorPanelHeight := FInspectorPanel.Height;

  {toggle inspector visibility}
  FInspectorPanel.Visible := aVisible;
  FInspectorSplitter.Visible := aVisible;

  if not(aVisible) then
    FReportPanel.Align := alClient
  else
    begin
      FReportPanel.Align := alTop;
      FReportPanel.Height := FReportPanel.Parent.Height - FSaveInspectorPanelHeight;

      FInspectorSplitter.Top := FReportPanel.Height;
      FInspectorPanel.Top := FInspectorSplitter.Top + FInspectorSplitter.Height;
      FInspectorPanel.Height := FSaveInspectorPanelHeight;
      FInspectorPanel.Align := alClient;

    end;

end;

{------------------------------------------------------------------------------}
{ TppReportTreeWindow.SetReport}

procedure TppReportTreeWindow.SetReport(aReport: TppCustomReport);
begin

  inherited;

  if (FReportTree.Report = aReport) then Exit;

  if (csDestroying in ComponentState) then Exit;

  {build object tree for the report}
  FObjectTree.Report := aReport;
  FInspector.SelectObject(aReport);

  {initialize the report tree or select a report}
  FReportTree.Report := aReport;

  if (FReportTree.Items.Count > 1) then
    SetReportTreeVisible(True)
  else
    SetReportTreeVisible(False);
    
  FReportTree.SelectComponent(aReport);

end; {procedure, SetReport}

procedure TppReportTreeWindow.SetReportTreeVisible(aVisible: Boolean);
begin

  FReportTreeSplitter.Visible := aVisible;
  FReportTree.Visible := aVisible

end;

procedure TppReportTreeWindow.ShowingChanged(aVisible: Boolean);
begin

  if Showing then
   Refresh();

end;

{******************************************************************************
 *
 ** F o n t B u t t o n
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFontButton.Create}

constructor TppFontButton.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FCurrentFont := TFont.Create;
  Flat := True;

  FFontAttributeType := faFontName;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFontButton.Destroy}

destructor TppFontButton.Destroy;
begin

  FCurrentFont.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppFontButton.Click}

procedure TppFontButton.Click;
var
  lFontDialog: TppPrinterFontDialog;
begin

  lFontDialog := TppPrinterFontDialog.Create(Self);
  lFontDialog.Font := FCurrentFont;
  lFontDialog.Printer := ppPrinter;

  if lFontDialog.Execute then
    SetCurrentFont(lFontDialog.Font);

  lFontDialog.Free;

  inherited Click;

end; {procedure, Click}

{------------------------------------------------------------------------------}
{ TppFontButton.SetCurrentFont}

procedure TppFontButton.SetCurrentFont(aFont: TFont);
begin
  FCurrentFont.Assign(aFont);

end; {procedure, SetFont}

{------------------------------------------------------------------------------}
{ TppFontButton.SetFontAttributeType}

procedure TppFontButton.SetFontAttributeType(aValue: TppFontAttributeType);
{var
  liImageIndex: Integer; }
begin

  FFontAttributeType := aValue;

  if FFontAttributeType = faFontName then

    Glyph.Handle := ppBitmapFromResource('PPFONTNAME')
  else
    Glyph.Handle := ppBitmapFromResource('PPFONTSIZE');

end; {procedure, SetFontAttributeType}



initialization
  TppToolWindowFactory.Register(TppReportTreeWindow);
  TppToolWindowFactory.Register(TppDataTreeWindow);


finalization







end.
