{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppCTDsgn;

interface

{$I ppIfDef.pas}

uses
  Classes,
  StdCtrls,
  ExtCtrls,
  SysUtils,
  Menus,
  Controls,
  ComCtrls,
  Graphics,
  Forms,
  Dialogs,
  Windows,

  ppTypes,
  ppUtils,
  ppForms,
  ppDesignerForms,
  ppDB,
  ppPrintr,
  ppTreeVw,
  ppCTCtrl,
  ppCtMain,
  ppTBX,
  ppTBXExtItems,
  ppTBXPanel,
  ppTB2Item,
  ppDesignToolbarsTBX,
  ppToolBarTBX,
  ppDesignToolItemsTBX,
  ppDesignToolActions,
  ppRTTI;

type

  TppCTFormatToolbar = class;
  TppCTDesignPopupMenu = class;

  {@TppCrossTabDesigner

    View looks like this...

          ------------ TipsPanel ------------------

          Treewindow |  FormatBar  |   FieldPanel
           treeview  |  Control    |
           inspector     selection

          ----------- StatusBar --------------------


    Crosstab is the model


    when element selection changes - update the formatbar and treewindow
    when elements added/removed - update treewindow
    when element prop changes - update formatbar and treewindow

  }

  {@TppCrossTabDesigner }
  TppCrossTabDesigner = class(TPanel)
    private
      FImageList: TImageList;
      FPopupMenu: TppCTDesignPopupMenu;
      FCrossTab: TppCrossTab;
      FDock: TppTBXDock;
      FFormatBar: TppCTFormatToolbar;
      FTipsPanel: TppTBXPanel;
      FImage: TImage;
      FTipsLabel1: TLabel;
      FTipsLabel2: TLabel;
      FTipsLabel3: TLabel;
      FTipsLabel4: TLabel;
      FFieldPanel: TPanel;
      FFieldHeaderPanel: TppBevel;
      FFieldsLabel: TLabel;
      FSplitter: TSplitter;
      FLayoutBackgroundPanel: TPanel;
      FLayoutPanel: TPanel;
      FControl: TppCrossTabControl;
      FListView: TppReportListView;
      FStatusBar: TStatusbar;
      FDisplayTips: Boolean;

      {create and configure controls}
      procedure CreateControls;
      procedure CreateFieldPanel;
      procedure CreateLayoutPanel;
      procedure CreateListView;
      procedure CreateTipsPanel;
      procedure CrossTabToControls;

      procedure FieldsToListView;
      function GetDisplayTips: Boolean;
      function GetSelection: TppCrossTabSelection;

      {event-handlers}
      procedure DimensionChangeEvent(Sender: TObject);
      procedure FieldsDragOverEvent(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
      procedure FieldsDragDropEvent(Sender, Source: TObject; X, Y: Integer);
      procedure FieldsMouseDownEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      procedure GetFieldEvent(Sender: TObject; var aField: TppField);
      procedure SelectionChangeEvent(Sender: TObject);
      procedure StatusChangeEvent(Sender: TObject);
      procedure SplitterMovedEvent(Sender: TObject);

      procedure SetCrossTab(aCrossTab: TppCrossTab);
      procedure SetDisplayTips(aValue: Boolean);

      procedure ShowFontDialog;
      procedure ShowDisplayFormatDialog;
      procedure ShowColorDialog;

   protected
     procedure SetParent(aParent: TWinControl); override;


    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Initialize;

      property CrossTab: TppCrossTab read FCrossTab write SetCrossTab;
      property StatusBar: TStatusbar read FStatusBar write FStatusBar;

      property DisplayTips: Boolean read GetDisplayTips write SetDisplayTips;

      property Selection: TppCrossTabSelection read GetSelection;
      property FieldPanel: TPanel read FFieldPanel;
      property Control: TppCrossTabControl read FControl;


    end; {class, TppCrossTabDesigner}


  {TppCTFontNameComboBox}
  TppCTFontNameComboBox = class(TppFontNameToolItem)
  private
    FFontList: TppFontList;

    function GetFontList: Boolean;

  protected
    procedure InitializeFontList; override;

  public
    destructor Destroy; override;
  end;


  {TppCTFormatToolbar}
  TppCTFormatToolbar = class(TppToolbar)
  private
    FCalcType: TppTBXComboBoxItem;
    FDisplayFormat: TppTBXItem;
    FSortAsc: TppTBXItem;
    FSortDesc: TppTBXItem;
    FFontName: TppCTFontNameComboBox;
    FFontSize: TppTBXComboBoxItem;
    FBold: TppTBXItem;
    FItalic: TppTBXItem;
    FUnderline: TppTBXItem;
    FLeftJustify: TppTBXItem;
    FCenter: TppTBXItem;
    FRightJustify: TppTBXItem;
    FFontColor: TppColorPaletteButton;
    FHighlightColor: TppColorPaletteButton;
    FFontColorAction: TppColorAction;
    FHighlightColorAction: TppColorAction;
    FCrossTabDesigner: TppCrossTabDesigner;
    FCrossTabControl: TppCrossTabControl;
    FSortNone: TppTBXItem;
    FUpdating: Boolean;

    procedure SetAlignment(aAlignment: TAlignment);
    procedure SetFont(aFont: TFont);
    procedure ShowDisplayFormatDialog;
    procedure ShowColorDialog;
    procedure ShowFontDialog;
    procedure SortButtonClickEvent(Sender: TObject);
    procedure AlignmentButtonClickEvent(Sender: TObject);
    procedure BeginUpdate;
    procedure HighlightColorChangeEvent(Sender: TObject);
    procedure FontColorChangeEvent(Sender: TObject);
    procedure CalcTypeChangeEvent(Sender: TObject; const Text: string);
    procedure EndUpdate;
    procedure FontSizeChangeEvent(Sender: TObject; const Text: string);
    procedure FontNameChangeEvent(Sender: TObject; const Text: string);
    procedure FontStyleChangeEvent(Sender: TObject);

  protected
    procedure CreateItems; override;
    procedure ehItem_Click(Sender: TObject);

  public
    constructor Create(aOwner: TComponent); override;
    constructor CreateToolbar(aOwner: TComponent; aCrossTabDesigner: TppCrossTabDesigner); virtual;
    procedure LanguageChanged; override;

    procedure EnableFontControls(aValue: Boolean);
    procedure EnableCalcTypeControls(aValue: Boolean);
    procedure EnableDisplayFormatControls(aValue: Boolean);
    procedure EnableSortControls(aValue: Boolean);

    property CalcType: TppTBXComboBoxItem read FCalcType;
    property DisplayFormat: TppTBXItem read FDisplayFormat;
    property SortAsc: TppTBXItem read FSortAsc;
    property SortDesc: TppTBXItem read FSortDesc;
    property FontName: TppCTFontNameComboBox read FFontName;
    property FontSize: TppTBXComboBoxItem read FFontSize;
    property Bold: TppTBXItem read FBold;
    property Italic: TppTBXItem read FItalic;
    property Underline: TppTBXItem read FUnderline;
    property LeftJustify: TppTBXItem read FLeftJustify;
    property Center: TppTBXItem read FCenter;
    property RightJustify: TppTBXItem read FRightJustify;
    property FontColor: TppColorPaletteButton read FFontColor;
    property HighlightColor: TppColorPaletteButton read FHighlightColor;
    property CrossTabControl: TppCrossTabControl read FCrossTabControl write FCrossTabControl;
    property SortNone: TppTBXItem read FSortNone;

  end;


  {TppCTDesignPopupMenu}
  TppCTDesignPopupMenu = class(TppTBXPopupMenu)
  private
    FItemOrder: TStringList;
    FLanguageIndex: Longint;
    FCrossTabDesigner: TppCrossTabDesigner;
    FCrossTabControl: TppCrossTabControl;
    FTips: TppTBXItem;
    FFont: TppTBXItem;
    FColor: TppTBXItem;
    FDisplayFormat: TppTBXItem;
    FSkipNulls: TppTBXItem;
    FNullOrder: TppTBXSubMenuItem;
    FFirst: TppTBXItem;
    FLast: TppTBXItem;
    FVisible: TppTBXItem;
    FGridlines: TppTBXItem;

    procedure NullOrderClickEvent(Sender: TObject);
    procedure MenuPopupEvent(Sender: TObject);

  protected
    procedure CreateMenuItems; virtual;
    procedure ehItem_Click(Sender: TObject);
    procedure SetLanguageIndex(aLanguageIndex: Integer); virtual;

  public
    constructor Create(aOwner: TComponent); override;
    constructor CreateMenu(aOwner: TComponent; aCrossTabDesigner: TppCrossTabDesigner); virtual;
    destructor Destroy; override;

    function AddItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXItem;
    function AddSeparator(aGroupIndex: Integer; aItemName: string): TppTBXSeparatorItem;
    function AddSubMenuItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Longint): TppTBXSubMenuItem;

    property Tips: TppTBXItem read FTips;
    property Font: TppTBXItem read FFont;
    property Color: TppTBXItem read FColor;
    property DisplayFormat: TppTBXItem read FDisplayFormat;
    property SkipNulls: TppTBXItem read FSkipNulls;
    property NullOrder: TppTBXSubMenuItem read FNullOrder;
    property First: TppTBXItem read FFirst;
    property Last: TppTBXItem read FLast;
    property Visible: TppTBXItem read FVisible;
    property Gridlines: TppTBXItem read FGridlines;
    property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;
    property CrossTabControl: TppCrossTabControl read FCrossTabControl write FCrossTabControl;

  end;


implementation

uses

{$IFDEF Delphi6}
  Types,
{$ELSE}
  Windows,
{$ENDIF}

  ppCTDlg,
  ppCWzDlg,
  ppCTWiz,
  ppTB2Dock,
  ppToolResources;


type
    TppCrossTabMenuCommandType   = (cmTips, cmFont, cmColor, cmDisplayFormat, cmSkipNulls, cmNullOrder, cmVisible, cmGridlines);

const

  cCrossTabMenuCaptions: array[Low(TppCrossTabMenuCommandType)..High(TppCrossTabMenuCommandType)] of Integer =
    (669, {'&Tips'}
     670, {'&Font'}
     671, {'&Color'}
     672,{'&Display Format'}
     1102, {'&Skip Nulls'}
     1108, {'Null Order'}
     673, {'&Visible'}
     674); {'&Gridlines'}


{******************************************************************************
 *
 ** C R O S S T A B   D E S I G N E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.Create }

constructor TppCrossTabDesigner.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  BevelOuter := bvNone;
  ShowHint   := True;

  FCrossTab  := TppCrossTab.Create(Self);

  FPopupMenu := TppCTDesignPopupMenu.CreateMenu(Self, Self);

  {4.11}
  {PopupMenu := FPopupMenu;}


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.Destroy }

destructor TppCrossTabDesigner.Destroy;
begin

  FPopupMenu.Free;
  FFormatBar.Free;
  FControl.Free;
  FCrossTab.Free;

  inherited Destroy;

end;  {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.SetParent }

procedure TppCrossTabDesigner.SetParent(aParent: TWinControl);
begin

  inherited SetParent(aParent);

  if (aParent <> nil) then
    CreateControls;

end; {procedure, SetParent}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.CreateControls }

procedure TppCrossTabDesigner.CreateControls;
begin

  {create tips panel and associated child panels}
  CreateTipsPanel;

  {create fields panel and associated child panels}
  CreateFieldPanel;

  {create layout background panel and associated child panels}
  CreateLayoutPanel;

  {4.11}
  FLayoutPanel.PopupMenu := FPopupMenu;

  {create top dock}
  FDock := TppTBXDock.Create(Owner);
  FDock.Parent := FLayoutPanel;
  FDock.Align := alTop;

  {create format toolbar and dock it to top}
  FFormatBar := TppCTFormatToolbar.CreateToolbar(Owner, Self);
  FFormatBar.Initialize(nil);
  FFormatBar.FreeNotification(Self);
  FFormatBar.CurrentDock := FDock;

  FFormatBar.EnableFontControls(False);
  FFormatBar.EnableCalcTypeControls(False);
  FFormatBar.EnableDisplayFormatControls(False);
  FFormatBar.EnableSortControls(False);
  FFormatBar.LanguageChanged;

  FDock.Height := FFormatBar.Height + 4;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.CreateTipsPanel }

procedure TppCrossTabDesigner.CreateTipsPanel;
begin

  {create tips panel and it children}
  FTipsPanel := TppTBXPanel.Create(Self);
  FTipsPanel.Parent := Self;
  FTipsPanel.Height := 83;
  FTipsPanel.Align  := alTop;

  FImage := TImage.Create(Self);
  FImage.Parent := FTipsPanel;
  FImage.Left := 6;
  FImage.Top  := 3;
  FImage.AutoSize := True;
  FImage.Picture.Bitmap.Handle := ppBitmapFromResource('PPCROSSTABTIPS');
  FImage.Transparent := True;

  FTipsLabel1 := TLabel.Create(Self);
  FTipsLabel1.Parent := FTipsPanel;
  FTipsLabel1.Left := 209;
  FTipsLabel1.Top  := 8;
  FTipsLabel1.Transparent := True;
  FTipsLabel1.Caption := ppLoadStr(663); {'1. Construct your crosstab by dragging fields from the field list into the shaded cells.'}

  FTipsLabel2 := TLabel.Create(Self);
  FTipsLabel2.Parent := FTipsPanel;
  FTipsLabel2.Left := 209;
  FTipsLabel2.Top  := 26;
  FTipsLabel2.Transparent := True;
  FTipsLabel2.Caption := ppLoadStr(664); {'2. Remove columns, rows or values by dragging from the diagram back to the field list.'}

  FTipsLabel3 := TLabel.Create(Self);
  FTipsLabel3.Parent := FTipsPanel;
  FTipsLabel3.Left := 209;
  FTipsLabel3.Top  := 44;
  FTipsLabel3.Transparent := True;
  FTipsLabel3.Caption := ppLoadStr(665); {'3. Reorder columns, rows or values by dragging within the diagram.'}

  FTipsLabel4 := TLabel.Create(Self);
  FTipsLabel4.Parent := FTipsPanel;
  FTipsLabel4.Left := 209;
  FTipsLabel4.Top  := 62;
  FTipsLabel4.Transparent := True;
  FTipsLabel4.Caption := ppLoadStr(666); {'4. Format crosstab by selecting a row, column or value and then using the toolbar or popup menu.'}

end; {procedure, CreateTipsPanel}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.CreateControls }

procedure TppCrossTabDesigner.CreateFieldPanel;
begin

  {create fields panel and associated child panels}
  FFieldPanel := TPanel.Create(Self);
  FFieldPanel.Parent := Self;
  FFieldPanel.Align := alLeft;
  FFieldPanel.BevelOuter := bvNone;
  FFieldPanel.Width := 164;

  FFieldHeaderPanel := TppBevel.Create(Self);
  FFieldHeaderPanel.Parent := FFieldPanel;
  FFieldHeaderPanel.Align := alTop;
  FFieldHeaderPanel.BevelOuter := bvNone;
  FFieldHeaderPanel.Height := 21;

  FFieldsLabel := TLabel.Create(Self);
  FFieldsLabel.Parent  := FFieldHeaderPanel;
  FFieldsLabel.Left    := 7;
  FFieldsLabel.Top     := 3;
  FFieldsLabel.Height  := 13;
  FFieldsLabel.Transparent := True;
  FFieldsLabel.Caption := ppLoadStr(637); {'Fields'}

  FSplitter := TSplitter.Create(Self);
  FSplitter.Parent := Self;
  FSplitter.Left := 164;
  FSplitter.Align := alLeft;
  FSplitter.Beveled := False;
  FSplitter.Width := 3;
  FSplitter.Cursor := crHSplit;
  FSplitter.OnMoved := SplitterMovedEvent;

end; {procedure, CreateFieldPanel}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.CreateLayoutPanel }

procedure TppCrossTabDesigner.CreateLayoutPanel;
begin

  {create view background panel and associated child panels}
  FLayoutBackgroundPanel := TPanel.Create(Self);
  FLayoutBackgroundPanel.Parent := Self;
  FLayoutBackgroundPanel.Left := FSplitter.Left + FSplitter.Width + 1;;
  FLayoutBackgroundPanel.Align := alClient;
  FLayoutBackgroundPanel.BevelOuter := bvNone;

  FLayoutPanel := TPanel.Create(Self);
  FLayoutPanel.Parent := FLayoutBackgroundPanel;
  FLayoutPanel.Align      := alClient;
  FLayoutPanel.BevelOuter := bvNone;

end; {procedure, CreateLayoutPanel}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.Initialize }

procedure TppCrossTabDesigner.Initialize;
begin
  CrossTabToControls;
end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.SetCrossTab }

procedure TppCrossTabDesigner.SetCrossTab(aCrossTab: TppCrossTab);
begin
  FCrossTab.Assign(aCrossTab);

  CrossTabToControls;
end; {procedure, SetCrossTab}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.GetDisplayTips }

function TppCrossTabDesigner.GetDisplayTips: Boolean;
begin
  Result := FTipsPanel.Visible;
end; {function, GetDisplayTips}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.SetDisplayTips }

procedure TppCrossTabDesigner.SetDisplayTips(aValue: Boolean);
begin
  FDisplayTips := aValue;
  FTipsPanel.Visible := FDisplayTips;
end; {procedure, SetDisplayTips}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.CrossTabToControls }

procedure TppCrossTabDesigner.CrossTabToControls;
begin

  FControl.Free;
  FListView.Free;
  FImageList.Free;

  CreateListView;

  FControl := TppCrossTabControl.CreateControl(FCrossTab, FLayoutPanel);

  FControl.FieldSource := FListView;
  FControl.OnGetField := GetFieldEvent;
  FControl.OnSelectionChange := SelectionChangeEvent;
  FControl.OnStatusChange := StatusChangeEvent;

  FListView.OnDragOver := FieldsDragOverEvent;
  FListView.OnDragDrop := FieldsDragDropEvent;
  FListView.OnMouseDown := FieldsMouseDownEvent;

  FCrossTab.OnDimensionChange2 := DimensionChangeEvent;

  FCrossTab.InitAvailableDimensions;

  FieldsToListView;

  FControl.Visible := True;

  FFormatBar.CrossTabControl := FControl;

  FPopupMenu.CrossTabControl := FControl;


end; {procedure, CrossTabToControls}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.CreateListView }

procedure TppCrossTabDesigner.CreateListView;
var
  lColumn: TListColumn;
  lBitmap: Graphics.TBitmap;
begin

  FListView := TppReportListView.Create(Self);
  FListView.Parent := FFieldPanel;
  FListView.Align := alClient;
  FListView.OwnerDraw := True;
  FListview.DoubleBuffered := True;
  FListView.AllowDrag := True;
  FListView.ReadOnly := True;
  FListView.ViewStyle := vsReport;
  FListView.ColumnClick := False;
  FListView.RowSelect := True;
  FListView.SortType := stNone;
//  FListView.Color := clBtnFace;
  FListView.ShowColumnHeaders := False;

  {create dummy image list to fix drawing error}
  FImageList := TImageList.Create(Self);

  lBitmap := Graphics.TBitmap.Create;
  lBitmap.Handle := ppBitmapFromResource('TPPCROSSTAB');
//  ResourceUtils.LoadBitmap(lBitmap, 'TPPCROSSTAB');
  FImageList.AddMasked(lBitmap, clSilver);
  lBitmap.Free;

  FListView.SmallImages := FImageList;

  lColumn := FListView.Columns.Add;
  lColumn.Width := FFieldPanel.Width - 6;

end; {procedure, CreateListView}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.FieldsToListView }

procedure TppCrossTabDesigner.FieldsToListView;
var
  lFields: TStringList;
  liIndex: Integer;
  lItem: TListItem;
begin

  FListView.Items.BeginUpdate;

  FListView.Items.Clear;

  lFields := TStringList.Create;

  FCrossTab.CopyAvailableDimensions(lFields);

  for liIndex := 0 to lFields.Count - 1 do
    begin
      lItem := FListView.Items.Add;

      lItem.Caption := lFields[liIndex];
      lItem.Data := lFields.Objects[liIndex];
    end;

  lFields.Free;

  FListView.Columns[0].Width := FFieldPanel.Width - 20;

  FListView.Items.EndUpdate;

end; {procedure, FieldsToListView}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.GetSelection }

function TppCrossTabDesigner.GetSelection: TppCrossTabSelection;
begin
  if (FControl <> nil) then
    Result := FControl.Selection
  else
    Result := nil;

end; {procedure, GetSelection}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.DimensionChangeEvent }

procedure TppCrossTabDesigner.DimensionChangeEvent(Sender: TObject);
begin
  FieldsToListView;
end; {procedure, DimensionChangeEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.GetFieldEvent }

procedure TppCrossTabDesigner.GetFieldEvent(Sender: TObject; var aField: TppField);
begin
  if (FListView.Selected <> nil) then
    aField := TppField(FListView.Selected.Data);
end; {procedure, GetFieldEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.SelectionChangeEvent }

procedure TppCrossTabDesigner.SelectionChangeEvent(Sender: TObject);
begin

  FFormatBar.EnableFontControls(FControl.Selection.HasProperty('Font'));
  FFormatBar.EnableCalcTypeControls(FControl.Selection.HasProperty('CalcType'));
  FFormatBar.EnableDisplayFormatControls(FControl.Selection.HasProperty('DisplayFormat'));
  FFormatBar.EnableSortControls(FControl.Selection.HasProperty('SortType'));


end; {procedure, SelectionChangeEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.StatusChangeEvent }

procedure TppCrossTabDesigner.StatusChangeEvent(Sender: TObject);
begin
  if (FStatusBar <> nil) then
    FStatusBar.SimpleText := FControl.Status;

end; {procedure, TppCrossTabDesigner}


{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.FieldsDragOverEvent }

procedure TppCrossTabDesigner.FieldsDragOverEvent(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin

  if (Source <> Self) then
    begin
      if FControl.Selection.ContainsDimensions then
        Accept := True
      else
        Accept := False;
    end
  else
    Accept := False;

end; {procedure, FieldsDragOverEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.FieldsDragDropEvent }

procedure TppCrossTabDesigner.FieldsDragDropEvent(Sender, Source: TObject; X, Y: Integer);
var
  liIndex: Integer;
  lElement: TppElement;
  lDimensions: TList;
begin

  if (Source = Self) then Exit;

  if not(FControl.Selection.ContainsDimensions) then Exit;

  FControl.BeginUpdate;

  lDimensions := TList.Create;

  for liIndex := 0 to FControl.Selection.ElementCount - 1 do
    begin
      lElement := FControl.Selection.Elements[liIndex];

      if (lElement is TppDimension) or (lElement is TppValueCaptionDef) then
        lDimensions.Add(lElement);
    end;

  for liIndex := 0 to lDimensions.Count - 1 do
    begin
      lElement := TppElement(lDimensions[liIndex]);

      if (lElement is TppColumnDef) then
        FCrossTab.DeselectColumnDef(FCrossTab.IndexOfChild(lElement))

      else if (lElement is TppRowDef) then
        FCrossTab.DeselectRowDef(FCrossTab.IndexOfChild(lElement))

      else if (lElement is TppValueCaptionDef) then
        FCrossTab.DeselectValueDef(FCrossTab.IndexOfChild(TppValueDef(lElement.Parent)))

      else if (lElement is TppValueDef) then
        FCrossTab.DeselectValueDef(FCrossTab.IndexOfChild(lElement));
    end;

  lDimensions.Free;

  FControl.EndUpdate;

//TODO  ExceptionUtils.IgnoreExceptions(False);

end; {procedure, FieldsDragDropEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.FieldsMouseDownEvent }

procedure TppCrossTabDesigner.FieldsMouseDownEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//TODO  ExceptionUtils.IgnoreExceptions(True);
end;  {procedure, FieldsMouseDownEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.SplitterMovedEvent }

procedure TppCrossTabDesigner.SplitterMovedEvent(Sender: TObject);
begin
  FListView.Columns[0].Width := FFieldPanel.Width - 6;
end; {procedure, SplitterMovedEvent}


{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.ShowFontDialog }

procedure TppCrossTabDesigner.ShowFontDialog;
begin

  FFormatBar.ShowFontDialog;

end; {procedure, ShowFontDialog}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.ShowColorDialog }

procedure TppCrossTabDesigner.ShowColorDialog;
begin

  FFormatBar.ShowColorDialog;

end; {procedure, ShowColorDialog}

{------------------------------------------------------------------------------}
{ TppCrossTabDesigner.ShowDisplayFormatDialog }

procedure TppCrossTabDesigner.ShowDisplayFormatDialog;
begin
  FFormatBar.ShowDisplayFormatDialog;

end; {procedure, ShowDisplayFormatDialog}


{******************************************************************************
 *
 **  F O N T N A M E  C O M B O B O X
 *
{******************************************************************************}

destructor TppCTFontNameComboBox.Destroy;
begin

  FFontList.Free;
  FFontList := nil;
  
  inherited;

end;


function TppCTFontNameComboBox.GetFontList: Boolean;
var
  lPrinter: TppPrinter;
  lbValidPrinter: Boolean;
  lDC: HDC;
begin

  lDC := 0;

  if (ppPrinter <> nil) then
    lPrinter := ppPrinter
  else
    lPrinter := nil;

  lbValidPrinter := (lPrinter.DC <> 0);

  if lbValidPrinter then
    lDC := lPrinter.DC;

  {free the old font list}
  if (FFontList <> nil) then
    FFontList.Free;

  {create new font list}
  FFontList := TppFontList.CreateList(lDC);

  Result := FFontList.Count > 0;

end;

procedure TppCTFontNameComboBox.InitializeFontList;
begin
  GetFontList();

  Strings.Assign(FFontList);

end;

{******************************************************************************
 *
 **  F O R M A T   T O O L B A R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.CreateItems }

procedure TppCTFormatToolbar.CreateItems;
var
  liIndex: Integer;
begin

  FCalcType := TppTBXComboBoxItem.Create(Owner);
  FCalcType.Strings.Add(ppLoadStr(1028)); {'Count'}
  FCalcType.Strings.Add(ppLoadStr(1029)); {'Sum'}
  FCalcType.Strings.Add(ppLoadStr(1030)); {'Minimum'}
  FCalcType.Strings.Add(ppLoadStr(1031)); {'Maximum'}
  FCalcType.Strings.Add(ppLoadStr(1032)); {'Average'}
  FCalcType.OnChange := CalcTypeChangeEvent;
  FCalcType.Loaded();
  Items.Add(FCalcType);

  FDisplayFormat :=  AddButton();
  FDisplayFormat.ImageIndex := ToolImageList.AddIcon('PPDISPLAYFORMAT');
  FDisplayFormat.OnClick := ehItem_Click;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FSortAsc := AddButton();
  FSortAsc.GroupIndex := 10;
  FSortAsc.ImageIndex := ToolImageList.AddIcon('PPSORTASC');
  FSortAsc.Tag := 0;
  FSortAsc.OnClick := SortButtonClickEvent;

  FSortDesc := AddButton();
  FSortDesc.GroupIndex := 10;
  FSortDesc.ImageIndex := ToolImageList.AddIcon('PPSORTDESC');
  FsortDesc.Tag := 1;
  FSortDesc.OnClick := SortButtonClickEvent;

  FSortNone := AddButton();
  FSortNone.GroupIndex := 10;
  FSortNone.GroupIndex := 10;
  FSortNone.ImageIndex := ToolImageList.AddIcon('PPSORTNONE');
  FSortNone.Tag := 2;
  FSortNone.OnClick := SortButtonClickEvent;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FFontName := TppCTFontNameComboBox.Create(Owner);
  FFontName.EditWidth := 150;
  FFontName.OnChange := FontNameChangeEvent;
  FFontName.Loaded();
  Items.Add(FFontName);

  FFontSize := TppTBXComboBoxItem.Create(Owner);
  FFontSize.EditWidth := 56;
  //FFontSize.Text := '10';

  //Populate list
  for liIndex := 0 to High(cFontSizes) do
    FFontSize.Strings.Add(IntToStr(cFontSizes[liIndex]));

  FFontSize.OnChange := FontSizeChangeEvent;
  FFontSize.Loaded();
  Items.Add(FFontSize);

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FBold := AddButton();
  FBold.ImageIndex := ToolImageList.AddIcon('PPBOLD');
  FBold.OnClick := FontStyleChangeEvent;

  FItalic := AddButton();
  FItalic.ImageIndex := ToolImageList.AddIcon('PPITALIC');
  FItalic.OnClick := FontStyleChangeEvent;

  FUnderline := AddButton();
  FUnderline.ImageIndex := ToolImageList.AddIcon('PPUNDERLINE');
  FUnderline.OnClick := FontStyleChangeEvent;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FLeftJustify := AddButton();
  FLeftJustify.Tag := Ord(taLeftJustify);
  FLeftJustify.GroupIndex := 20;
  FLeftJustify.ImageIndex := ToolImageList.AddIcon('PPALIGNLEFT');
  FLeftJustify.OnClick := AlignmentButtonClickEvent;

  FCenter := AddButton();
  FCenter.Tag := Ord(taCenter);
  FCenter.GroupIndex := 20;
  FCenter.ImageIndex := ToolImageList.AddIcon('PPALIGNCENTER');
  FCenter.OnClick := AlignmentButtonClickEvent;

  FRightJustify := AddButton();
  FRightJustify.Tag := Ord(taRightJustify);
  FRightJustify.GroupIndex := 20;
  FRightJustify.ImageIndex := ToolImageList.AddIcon('PPALIGNRIGHT');
  FRightJustify.OnClick := AlignmentButtonClickEvent;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FFontColorAction := TppColorAction.Create(Self);
  FFontColorAction.OnExecuteAction := FontColorChangeEvent;
  FFontColorAction.ColorType := ctFont;

  FFontColor := TppColorPaletteButton.Create(Owner);
  FFontColor.PaletteAction := FFontColorAction;
  FFontColor.ImageIndex := FFontColorAction.ImageIndex;
  Items.Add(FFontColor);

  FHighlightColorAction := TppColorAction.Create(Self);
  FHighlightColorAction.OnExecuteAction := HighlightColorChangeEvent;
  FHighlightColorAction.ColorType := ctHighlight;

  FHighlightColor := TppColorPaletteButton.Create(Owner);
  FHighlightColor.PaletteAction := FHighlightColorAction;
  FHighlightColor.ImageIndex := FHighlightColorAction.ImageIndex;
  Items.Add(FHighlightColor);

end; {procedure, CreateItems}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.Create }

constructor TppCTFormatToolbar.Create(aOwner: TComponent);
begin
  inherited;

  DockMode := dmCannotFloatOrChangeDocks;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.CreateToolbar }

constructor TppCTFormatToolbar.CreateToolbar(aOwner: TComponent; aCrossTabDesigner: TppCrossTabDesigner);
begin
  FCrossTabDesigner := aCrossTabDesigner;

  Create(Owner);

end; {constructor, CreateToolbar}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.ehItem_Click }

procedure TppCTFormatToolbar.ehItem_Click(Sender: TObject);
begin
  if (Sender = FDisplayFormat) then
    ShowDisplayFormatDialog;

end; {procedure, ehItem_Click}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.ShowDisplayFormatDialog }

procedure TppCTFormatToolbar.ShowDisplayFormatDialog;
var
  lFormatDlg: TppCustomFormatDialog;
  lFormClass: TFormClass;
  lFormats: TStrings;
  lDisplayFormat: String;
  lDataType: TppDataType;
begin

  if FUpdating then Exit;

  BeginUpdate;

  lFormClass := ppGetFormClass(TppCustomFormatDialog);

  lFormatDlg := TppCustomFormatDialog(lFormClass.Create(Application));


  try

    //lFormatDlg.LanguageIndex := LanguageIndex;
    FCrossTabControl.Selection.GetPropertyValue('DisplayFormat', lDisplayFormat);
    lFormatDlg.DisplayFormat := lDisplayFormat;

    {get standard display formats}
    lFormats := lFormatDlg.DisplayFormats;
    lFormats.Clear;
    FCrossTabControl.Selection.GetPropertyValue('DataType', lDataType);
    ppGetDisplayFormats(lDataType, lFormats);

    {set format property}
    if (lFormatDlg.ShowModal = mrOK) then
      begin
        lDisplayFormat := lFormatDlg.DisplayFormat;

        FCrossTabControl.Selection.SetPropertyValue('DisplayFormat', lDisplayFormat);
      end;

  finally
    lFormatDlg.Free;
    EndUpdate;

  end;

end; {procedure, ShowDisplayFormatDialog}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.ShowColorDialog }

procedure TppCTFormatToolbar.ShowColorDialog;
var
  lColorDialog: TColorDialog;
  lColor: TColor;
begin
  if FUpdating then Exit;

  BeginUpdate;
  lColorDialog := TColorDialog.Create(Self);

  try
    FCrossTabControl.Selection.GetPropertyValue('Color', lColor);
    lColorDialog.Color := lColor;

    if (lColorDialog.Execute) then
      begin
        lColor := lColorDialog.Color;

        FCrossTabControl.Selection.SetPropertyValue('Color', lColor);
      end;

  finally
    lColorDialog.Free;
    EndUpdate;

  end;

end; {procedure, ShowColorDialog}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.ShowFontDialog }

procedure TppCTFormatToolbar.ShowFontDialog;
var
  lFontDialog: TppPrinterFontDialog;
  lFont: TFont;
begin

  lFontDialog := TppPrinterFontDialog.Create(Self);
  FCrossTabControl.Selection.GetPropertyValue('Font', lFont);
  lFontDialog.Font := lFont;
  lFontDialog.Printer := ppPrinter;

  if lFontDialog.Execute then
    begin
      lFont := lFontDialog.Font;

      FCrossTabControl.Selection.SetPropertyValue('Font', lFont);
    end;

  lFontDialog.Free;

end; {procedure, ShowFontDialog}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.SortButtonClickEvent }

procedure TppCTFormatToolbar.SortButtonClickEvent(Sender: TObject);
var
  lSortType: TppSortOrderType;
begin

  if FUpdating then Exit;

  BeginUpdate;

  try
    TppTBXItem(Sender).Checked := True;

    lSortType := TppSortOrderType(TControl(Sender).Tag);

    {set crosstab SortType property}
    FCrossTabControl.Selection.SetPropertyValue('SortType', lSortType);

  finally
    EndUpdate;

  end;

end; {procedure, SortButtonClickEvent}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.AlignmentButtonClickEvent }

procedure TppCTFormatToolbar.AlignmentButtonClickEvent(Sender: TObject);
var
  lAlignment: TAlignment;
begin

  TppTBXItem(Sender).Checked := True;

  lAlignment := TAlignment(TppTBXItem(Sender).Tag);

  {set crosstab alignment property}
  FCrossTabControl.Selection.SetPropertyValue('Alignment', lAlignment);

end; {procedure, AlignmentButtonClickEvent}

procedure TppCTFormatToolbar.BeginUpdate;
begin
  FUpdating := True;
end;

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.HighlightColorChangeEvent }

procedure TppCTFormatToolbar.HighlightColorChangeEvent(Sender: TObject);
var
  lColor: TColor;
begin

  if FUpdating then Exit;

  BeginUpdate();

  try

    lColor := TppColorAction(Sender).Color;

    {set crosstab color property}
    FCrossTabControl.Selection.SetPropertyValue('Color', lColor);
  finally
    EndUpdate();

  end;

end; {procedure, HighlightColorChangeEvent}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.FontColorChangeEvent }

procedure TppCTFormatToolbar.FontColorChangeEvent(Sender: TObject);
var
  lFont: TFont;
begin

  if FUpdating then Exit;

  BeginUpdate();
  lFont := TFont.Create;

  try
    Font.Color := TppColorAction(Sender).Color;

    lFont.Assign(Font);

    {assign the font to the selection}
    FCrossTabControl.Selection.SetPropertyValue('Font', lFont);

  finally
    lFont.Free;
    EndUpdate();
  end;

end; {procedure, FontColorChangeEvent}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.CalcTypeChangeEvent }

procedure TppCTFormatToolbar.CalcTypeChangeEvent(Sender: TObject; const Text: string);
var
  lCalcType: TppDBCalcType;
  liIndex: Integer;
begin

  if FUpdating then Exit;

  BeginUpdate();

  try
    liIndex := FCalcType.ItemIndex;

    lCalcType := TppDBCalcType(liIndex);

    {set calctype for the selection}
    FCrossTabControl.Selection.SetPropertyValue('CalcType', lCalcType);

    {disallow change if property value didn't change}
    FCrossTabControl.Selection.GetPropertyValue('CalcType', lCalcType);

    liIndex := Ord(lCalcType);

    {update combo box with the current selection}
    if (liIndex >= 0) and (liIndex < FCalcType.Strings.Count-1) then
      FCalcType.ItemIndex := liIndex;
  finally
    EndUpdate();

  end;

end; {procedure, CalcTypeChangeEvent}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.FontSizeChangeEvent }

procedure TppCTFormatToolbar.FontSizeChangeEvent(Sender: TObject; const Text: string);
var
  lFont: TFont;
begin

  if FUpdating then Exit;

  BeginUpdate();
  lFont := TFont.Create;

  try
    Font.Size := StrToInt(Text);

    lFont.Assign(Font);

    {assign the font to the selection}
    FCrossTabControl.Selection.SetPropertyValue('Font', lFont);

  finally
    lFont.Free;
    EndUpdate();
  end;

end; {procedure, FontSizeChangeEvent}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.FontNameChangeEvent }

procedure TppCTFormatToolbar.FontNameChangeEvent(Sender: TObject; const Text: string);
var
  lFont: TFont;
begin

  if FUpdating then Exit;

  BeginUpdate();

  lFont := TFont.Create;

  try
    Font.Name := Text;

    lFont.Assign(Font);

    FCrossTabControl.Selection.SetPropertyValue('Font', lFont);

  finally
    lFont.Free;
    EndUpdate();
  end;

end; {procedure, FontNameChangeEvent}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.SetAlignment }

procedure TppCTFormatToolbar.SetAlignment(aAlignment: TAlignment);
begin

  if FUpdating then Exit;

  BeginUpdate();

  try
    FRightJustify.Checked := (aAlignment = taRightJustify);
    FLeftJustify.Checked := (aAlignment = taLeftJustify);
    FCenter.Checked := (aAlignment = taCenter);

  finally
    EndUpdate();

  end;

end; {procedure, SetAlignment}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.SetFont }

procedure TppCTFormatToolbar.SetFont(aFont: TFont);
begin
  if FUpdating then Exit;

  BeginUpdate();

  try

    Font.Assign(aFont);

    FBold.Checked := (fsBold in aFont.Style);
    FItalic.Checked := (fsItalic in aFont.Style);
    FUnderline.Checked := (fsUnderline in aFont.Style);

    FFontSize.Text := IntToStr(aFont.Size);
    FFontName.Text := aFont.Name;
  finally
    EndUpdate();

  end;


end; {procedure, SetFont}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.EnableCalcTypeControls }

procedure TppCTFormatToolbar.EnableCalcTypeControls(aValue: Boolean);
var
  liIndex: Integer;
  lCalcType: TppDBCalcType;
begin

  FCalcType.Enabled := aValue;

  if not aValue then Exit;

  FCrossTabControl.Selection.GetPropertyValue('CalcType', lCalcType);

  liIndex := Ord(lCalcType);

  {update combo box with the current selection}
  if (liIndex >= 0) and (liIndex < FCalcType.Strings.Count) then
    FCalcType.ItemIndex := liIndex;

end; {procedure, EnableCalcTypeControls}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.EnableDisplayFormatControls }

procedure TppCTFormatToolbar.EnableDisplayFormatControls(aValue: Boolean);
begin
  FDisplayFormat.Enabled := aValue;

end; {procedure, EnableDisplayFormatControls}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.EnableFontControls }

procedure TppCTFormatToolbar.EnableFontControls(aValue: Boolean);
var
  lFont: TFont;
  lAlignment: TAlignment;
begin

  FFontName.Enabled := aValue;
  FFontSize.Enabled := aValue;

  FBold.Enabled := aValue;
  FItalic.Enabled := aValue;
  FUnderline.Enabled := aValue;

  FLeftJustify.Enabled := aValue;
  FCenter.Enabled := aValue;
  FRightJustify.Enabled := aValue;

  FFontColor.Enabled := aValue;
  FHighlightColor.Enabled := aValue;

  FFontColor.PaletteEnabled      := aValue;
  FHighlightColor.PaletteEnabled := aValue;

  {update toolbar with current font and alignment}
  if aValue then
    begin
      FCrossTabControl.Selection.GetPropertyValue('Font', lFont);
      FCrossTabControl.Selection.GetPropertyValue('Alignment', lAlignment);
      SetFont(lFont);
      SetAlignment(lAlignment);

    end;

end; {procedure, EnableFontControls}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.EnableSortControls }

procedure TppCTFormatToolbar.EnableSortControls(aValue: Boolean);
var
  lSortType: TppSortOrderType;
begin

  FSortAsc.Enabled  := aValue;
  FSortDesc.Enabled := aValue;
  FSortNone.Enabled := aValue;

  if not aValue then Exit;


  FCrossTabControl.Selection.GetPropertyValue('SortType', lSortType);

  FSortAsc.Checked  := (TppSortOrderType(FSortAsc.Tag) = lSortType);
  FSortDesc.Checked := (TppSortOrderType(FSortDesc.Tag) = lSortType);
  FSortNone.Checked := (TppSortOrderType(FSortNone.Tag) = lSortType);

end; {procedure, EnableSortControls}

procedure TppCTFormatToolbar.EndUpdate;
begin
  FUpdating := False;
end;

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.FontStyleChangeEvent }

procedure TppCTFormatToolbar.FontStyleChangeEvent(Sender: TObject);
var
  lFont: TFont;
  lbChecked: Boolean;
begin

  if FUpdating then Exit;

  BeginUpdate;
  lFont := TFont.Create;

  try
    TppTBXItem(Sender).Checked := not(TppTBXItem(Sender).Checked);

    lbChecked := TppTBXItem(Sender).Checked;

    if (Sender = FBold) then
      if lbChecked then
        Font.Style := Font.Style + [fsBold]
      else
        Font.Style := Font.Style - [fsBold]

    else if (Sender = FItalic) then
      if lbChecked then
        Font.Style := Font.Style + [fsItalic]
      else
        Font.Style := Font.Style - [fsItalic]

    else if (Sender = FUnderline) then
      if lbChecked then
        Font.Style := Font.Style + [fsUnderline]
      else
        Font.Style := Font.Style - [fsUnderline];


    lFont.Assign(Font);

    {assign the font to the selection}
    FCrossTabControl.Selection.SetPropertyValue('Font', lFont);

  finally
    lFont.Free;
    EndUpdate();
  end;

end; {procedure, FontStyleChangeEvent}

{------------------------------------------------------------------------------}
{ TppCTFormatToolbar.LanguageChanged }

procedure TppCTFormatToolbar.LanguageChanged;
begin
  FCalcType.Hint :=       ppLoadStr(196);
  FDisplayFormat.Hint :=  ppLoadStr(199);
  FSortAsc.Hint :=        ppLoadStr(667);
  FSortDesc.Hint :=       ppLoadStr(668);
  FSortNone.Hint :=       ppLoadStr(1165);
  FFontName.Hint :=       ppLoadStr(168);
  FFontSize.Hint :=       ppLoadStr(169);
  FBold.Hint :=           ppLoadStr(160);
  FItalic.Hint :=         ppLoadStr(171);
  FUnderline.Hint :=      ppLoadStr(179);
  FLeftJustify.Hint :=    ppLoadStr(173);
  FCenter.Hint :=         ppLoadStr(163);
  FRightJustify.Hint :=   ppLoadStr(176);
  FFontColor.Hint :=      ppLoadStr(480);
  FHighlightColor.Hint := ppLoadStr(481);

end; {procedure, LanguageChanged}

{******************************************************************************
 *
 **  P O P U P   M E N U
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.AddItem }

function TppCTDesignPopupMenu.AddItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Integer): TppTBXItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result          := TppTBXItem.Create(Self);
  Result.Name     := aItemName;
  Result.Tag      := aStringId;
  Result.ImageIndex := ToolImageList.AddIcon('PP' + UpperCase(aItemName));

  if (aCaption = '') and (aStringId <> 0) then
    Result.Caption := ppLoadStr(aStringId)
  else
    Result.Caption  := aCaption;

  Items.Insert(liIndex, Result);

end; {function, AddItem}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.AddSeparator }

function TppCTDesignPopupMenu.AddSeparator(aGroupIndex: Integer; aItemName: string): TppTBXSeparatorItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result := TppTBXSeparatorItem.Create(Self);
  Result.Name     := aItemName;

  Items.Insert(liIndex, Result);

end; {function, AddSeparator}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.AddSubMenuItem }

function TppCTDesignPopupMenu.AddSubMenuItem(aGroupIndex: Integer; const aItemName, aCaption: String; aStringId: Integer): TppTBXSubMenuItem;
var
  liIndex: Integer;
  lsSortID: String;
begin

  Result := nil;

  if (FindComponent(aItemName) <> nil) then Exit;

  lsSortID := Format('%8d',[aGroupIndex]) + aItemName;

  liIndex := FItemOrder.Add(lsSortID);

  Result          := TppTBXSubMenuItem.Create(Self);
  Result.Name     := aItemName;
  Result.Tag      := aStringId;
  Result.ImageIndex := ToolImageList.AddIcon('PP' + UpperCase(aItemName));

  if (aCaption = '') and (aStringId <> 0) then
    Result.Caption := ppLoadStr(aStringId)
  else
    Result.Caption  := aCaption;

  Items.Insert(liIndex, Result);

end; {function, AddSubMenuItem}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.Create }

constructor TppCTDesignPopupMenu.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  OnPopup := MenuPopupEvent;

  Images := ToolImageList;
  FItemOrder := TStringList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.CreateMenu }

constructor TppCTDesignPopupMenu.CreateMenu(aOwner: TComponent; aCrossTabDesigner: TppCrossTabDesigner);
begin
  FCrossTabDesigner := aCrossTabDesigner;

  Create(aOwner);

  CreateMenuItems();

end; {constructor, CreateMenu}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.CreateMenuItems }

procedure TppCTDesignPopupMenu.CreateMenuItems;
begin
  FTips := AddItem(30, 'Tips', '', 669);
  FTips.OnClick := ehItem_Click;

  AddSeparator(30, '');

  FFont := AddItem(30, 'Font', '', 670);
  FFont.OnClick := ehItem_Click;

  FColor := AddItem(30, 'Color', '', 671);
  FColor.OnClick := ehItem_Click;

  FDisplayFormat := AddItem(30, 'DisplayFormat', '', 672);
  FDisplayFormat.OnClick := ehItem_Click;

  FSkipNulls := AddItem(30, 'SkipNulls', '', 1102);
  FSkipNulls.OnClick := ehItem_Click;

  FNullOrder := AddSubMenuItem(30, 'NullOrder', '', 1108);

  FFirst := TppTBXItem.Create(self);
  FFirst.GroupIndex := 31;
  FFirst.Caption := ppLoadStr(1109);
  FFirst.ImageIndex := ToolImageList.AddIcon('PPFIRST');
  FFirst.Tag := 0;
  FFirst.OnClick := ehItem_Click;

  FLast := TppTBXItem.Create(self);
  FLast.GroupIndex := 31;
  FLast.Caption := ppLoadStr(1110);
  FLast.ImageIndex := ToolImageList.AddIcon('PPLAST');
  FLast.Tag := 1;
  FLast.OnClick := ehItem_Click;

  FNullOrder.Add(FFirst);
  FNullOrder.Add(FLast);

  FVisible := AddItem(30, 'Visible', '', 673);
  FVisible.OnClick := ehItem_Click;

  AddSeparator(30, '');

  FGridLines := AddItem(30, 'Gridlines', '', 674);
  FGridlines.OnClick := ehItem_Click;

end; {procedure, CreateMenuItems}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.Destroy }

destructor TppCTDesignPopupMenu.Destroy;
begin
  FItemOrder.Free;

  inherited Destroy;
  
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.ehItem_Click }

procedure TppCTDesignPopupMenu.ehItem_Click(Sender: TObject);
var
  lbSkipNulls: Boolean;
  lbVisible: Boolean;
begin

  if (Sender = FTips) then
    FCrossTabDesigner.DisplayTips := not FCrossTabDesigner.DisplayTips

  else if (Sender = FFont) then
    FCrossTabDesigner.ShowFontDialog

  else if (Sender = FColor) then
    FCrossTabDesigner.ShowColorDialog

  else if (Sender = FDisplayFormat) then
    FCrossTabDesigner.ShowDisplayFormatDialog

  else if (Sender = FSkipNulls) then
    begin
      lbSkipNulls := not TppTBXItem(Sender).Checked;
      FCrossTabDesigner.Selection.SetPropertyValue('SkipNulls', lbSkipNulls);
    end

  else if (Sender = FFirst) then
    NullOrderClickEvent(Sender)

  else if (Sender = FLast) then
    NullOrderClickEvent(Sender)

  else if (Sender = FVisible) then
    begin
      lbVisible := not TppTBXItem(Sender).Checked;
      FCrossTabDesigner.Selection.SetPropertyValue('Visible', lbVisible);
    end

  else if (Sender = FGridLines) then
    begin
      FCrossTabDesigner.CrossTab.Gridlines := not FCrossTabDesigner.CrossTab.Gridlines;
      FCrossTabControl.Refresh;
    end;

end; {procedure, ehItem_Click}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.MenuPopupEvent }

procedure TppCTDesignPopupMenu.MenuPopupEvent(Sender: TObject);
var
  lbVisible: Boolean;
  lbSkipNulls: Boolean;
  lNullOrder: TppNullOrderType;
  lSelection: TppCrossTabSelection;
  liIndex: Integer;
begin

  lSelection := FCrossTabDesigner.Selection;

  for liIndex := 0 to Items.Count - 1 do
    begin

      if (Items[liIndex] = FTips) then
        Items[liIndex].Checked := FCrossTabDesigner.DisplayTips

      else if (Items[liIndex] = FFont) then
        Items[liIndex].Enabled := lSelection.HasProperty('Font')

      else if (Items[liIndex] = FColor) then
        Items[liIndex].Enabled := lSelection.HasProperty('Color')

      else if (Items[liIndex] = FDisplayFormat) then
        Items[liIndex].Enabled := lSelection.HasProperty('DisplayFormat')

      else if (Items[liIndex] = FSkipNulls) then
        begin
          Items[liIndex].Enabled := lSelection.HasProperty('SkipNulls');

          lbSkipNulls := True;

          lSelection.GetPropertyValue('SkipNulls', lbSkipNulls);

          Items[liIndex].Checked := lbSkipNulls;
        end

      else if (Items[liIndex] = FNullOrder) then
        begin

          if lbSkipNulls then
            Items[liIndex].Enabled := False
          else
            Items[liIndex].Enabled := lSelection.HasProperty('NullOrder');

          lSelection.GetPropertyValue('NullOrder', lNullOrder);

          Items[liIndex].Items[0].Checked := (lNullOrder = ctnoFirst);
          Items[liIndex].Items[1].Checked := (lNullOrder = ctnoLast);
        end

      else if (Items[liIndex] = FVisible) then
        begin
          Items[liIndex].Enabled := lSelection.ContainsTotals;

          lbVisible := True;

          lSelection.GetPropertyValue('Visible', lbVisible);

          Items[liIndex].Checked := lbVisible;
        end

      else if (Items[liIndex] = FGridLines) then
        Items[liIndex].Checked := FCrossTabDesigner.CrossTab.GridLines;

    end;

end; {procedure, MenuPopupEvent}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.NullOrderClickEvent }

procedure TppCTDesignPopupMenu.NullOrderClickEvent(Sender: TObject);
var
  lNullOrder: TppNullOrderType;
  liEnumValue: Integer;
begin

  liEnumValue := TppTBXItem(Sender).Tag;

  lNullOrder := TppNullOrderType(liEnumValue);

  FCrossTabDesigner.Selection.SetPropertyValue('NullOrder', lNullOrder);

end; {procedure, NullOrderClickEvent}

{------------------------------------------------------------------------------}
{ TppCTDesignPopupMenu.SetLanguageIndex }

procedure TppCTDesignPopupMenu.SetLanguageIndex(aLanguageIndex: Integer);
begin
  if (FLanguageIndex <> aLanguageIndex) or (Items.Count = 0) then
    begin

      FLanguageIndex := aLanguageIndex;

      {clear menu items and recreate}
      Items.Clear;

      FItemOrder.Clear;

      CreateMenuItems;
    end;

end; {procedure, SetLanguageIndex}


initialization
  ppRegisterForm(TppCustomCrossTabDesignerForm, TppCrossTabDesignerForm);

finalization
  ppUnRegisterForm(TppCustomCrossTabDesignerForm);

end.

