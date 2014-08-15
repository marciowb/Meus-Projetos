{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppRichEd;

interface

{$I ppIfDef.pas}

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  ImgList,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ExtCtrls,
  Menus,
  ComCtrls,
  ClipBrd,
  ToolWin,
  ppForms,
  ppDesignerForms,
  ppTypes,
  ppDB,
  ppUtils,
  ppDrwCmd,
  ppPrintr,
  ppRichTx,
  ppRichTxDrwCmd,
  ppTreeVw,
  ppToolWnTBX,
  ppPopupMenus,
  ppDesignToolItemsTBX,
  ppTB2Dock,
  ppTB2Item,
  ppTBX,
  ppTBXExtItems,
  ppToolbarTBX,
  ppPopupMenuBase, ppTBXStatusBars;

const
  cSpacer = #1;

type

  TppRTFMenu = class;
  TppRTFToolbar = class;

  {@TppRTFEditorController }
  TppRTFEditorController = class
    class procedure Edit(aRichText: TppRichText);
  end;


  {@TppRTFEditor }
  TppRTFEditor = class(TppCustomRTFEditor)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    FontDialog1: TFontDialog;
    ToolbarImages: TImageList;
    pnlBase: TPanel;
    pnlEditorPanel: TPanel;
    Ruler: TPanel;
    FirstInd: TLabel;
    LeftInd: TLabel;
    RulerLine: TBevel;
    RightInd: TLabel;
    ToolBar: TToolBar;
    MergeSplitter: TSplitter;
    pnlMerge: TPanel;
    pnlFormat: TPanel;
    pnlFormatText: TPanel;
    lbxDisplayFormats: TListBox;
    FormatSplitter: TSplitter;
    pnlAddField: TPanel;
    btnAddField: TButton;
    pnlDisplayFormatTitle: TPanel;
    edtDisplayFormatText: TEdit;
    lblDisplayFormat: TLabel;
    pnlMergeTitle: TPanel;
    cbxMailMerge: TCheckBox;

    procedure SelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure ehFileNew(Sender: TObject);
    procedure ehFileOpen(Sender: TObject);
    procedure ehFileSaveAs(Sender: TObject);
    procedure ehFilePrint(Sender: TObject);
    procedure ehFileExit(Sender: TObject);
    procedure ehEditUndo(Sender: TObject);
    procedure ehEditCut(Sender: TObject);
    procedure ehEditCopy(Sender: TObject);
    procedure ehEditPaste(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure RulerResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ehBoldButtonClick(Sender: TObject);
    procedure ehItalicButtonClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure ehAlignButtonClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure ehUnderlineButtonClick(Sender: TObject);
    procedure ehBulletsButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure lbxDisplayFormatsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure lbxDisplayFormatsClick(Sender: TObject);
    procedure btnAddFieldClick(Sender: TObject);
    procedure cbxMailMergeClick(Sender: TObject);
    procedure MergeSplitterMoved(Sender: TObject);

  private
    FClipboardOwner: HWnd;
    FDragOfs: Integer;
    FDragging: Boolean;
    FFileName: String;
    FMenu: TppRTFMenu;
    FMenuDock: TppTBXDock;
    FToolBar: TppRTFToolbar;
    FToolBarDock: TppTBXDock;
    FStatusString: String;
    FUpdating: Boolean;
    FEditor: TCustomRichEdit;
    FDataExplorer: TppDataExplorer;
    FField: TppField;
    FParaAttributes: TppParaAttributes;
    FStatusBar: TppTBXStatusBar;

    function  CurrText: TTextAttributes;
    procedure SetFileName(const FileName: String);
    procedure CheckFileSave;
    procedure SetupRuler;
    procedure SetEditRect;
    procedure SetMailMergeEnabled(aEnabled: Boolean);
    procedure UpdateCaretPos;
    procedure ClipboardChanged;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure WMChangeCBChain(var Msg: TWMChangeCBChain); message WM_CHANGECBCHAIN;
    procedure WMDrawClipboard(var Msg: TWMDrawClipboard); message WM_DRAWCLIPBOARD;
    procedure PerformFileOpen(const AFileName: string);
    procedure SetModified(Value: Boolean);
    procedure CreateEditControl;
    procedure CreateMenus;
    procedure CreateMailMergeControl;

    {merge field support}
    procedure ehSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure ehDblClickItem(Sender: TObject);
    function  GenerateFieldCode: String;
    property StatusBar: TppTBXStatusBar read FStatusBar;

    protected
    procedure CreateStatusBar;
      {implment GetLines method inherited from ancestor TppCustomRTFEditor}
      function  GetLines: TStrings; override;
      procedure LanguageChanged; override;

    public
      destructor Destroy; override;

      property Editor: TCustomRichEdit read FEditor;


    published

  end; {class, TppRTFEditor}

  {TppRTFFileMenu}
  TppRTFFileMenu = class(TppSubMenuItem)
  private
    FNew: TppTBXItem;
    FOpen: TppTBXitem;
    FSaveAs: TppTBXItem;
    FPrint: TppTBXItem;
    FExit: TppTBXItem;
    FOnItemClick: TNotifyEvent;
    FRTFEditor: TppRTFEditor;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public
    constructor CreateMenu(aOwner: TComponent; aRTFEditor: TppRTFEditor); virtual;

    procedure LanguageChanged; override;

    property New:  TppTBXitem read FNew;
    property Open: TppTBXitem read FOpen;
    property SaveAs: TppTBXItem read FSaveAs;
    property Print: TppTBXItem read FPrint;
    property Exit: TppTBXItem read FExit;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end; {class, TppRTFFileMenu}

  {TppRTFEditMenu}
  TppRTFEditMenu = class(TppSubMenuItem)
  private
    FUndo: TppTBXItem;
    FCut: TppTBXitem;
    FCopy: TppTBXItem;
    FPaste: TppTBXItem;
    FFont: TppTBXItem;
    FOnItemClick: TNotifyEvent;
    FRTFEditor: TppRTFEditor;

  protected
    procedure CreateControls; override;
    procedure ehItem_Click(Sender: TObject); virtual;

  public
    constructor CreateMenu(aOwner: TComponent; aRTFEditor: TppRTFEditor); virtual;

    procedure LanguageChanged; override;

    property Undo:  TppTBXitem read FUndo;
    property Cut: TppTBXitem read FCut;
    property Copy: TppTBXItem read FCopy;
    property Paste: TppTBXItem read FPaste;
    property Font: TppTBXItem read FFont;

  published
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;

  end; {class, TppRTFEditMenu}

  {TppRTFMenu }
  TppRTFMenu = class(TppToolbar)
    private
      FFileMenu: TppRTFFileMenu;
      FEditMenu: TppRTFEditMenu;
      FRTFEditor: TppRTFEditor;

    protected
      procedure CreateItems; override;

    public
      constructor Create(Owner: TComponent); override;
      constructor CreateMenu(aOwner: TComponent; aRTFEditor: TppRTFEditor); virtual;

      procedure LanguageChanged; override;

      property FileMenu: TppRTFFileMenu read FFileMenu;
      property EditMenu: TppRTFEditMenu read FEditMenu;

  end; {class, TppRTFMenu}

  {TppFontNameComboBox}
  TppRTFFontComboBox = class(TppFontNameToolItem)
  private
    FFontList: TppFontList;

    function GetFontList: Boolean;
    function GetCurrentFont: TFont;

  protected
    procedure InitializeFontList; override;

    property CurrentFont: TFont read GetCurrentFont;

  public
    destructor Destroy; override;

  end;

  {TppRTFToolbar}
  TppRTFToolbar = class(TppToolbar)
  private
    FOpen: TppTBXItem;
    FSave: TppTBXItem;
    FPrint: TppTBXItem;
    FUndo: TppTBXItem;
    FCut: TppTBXItem;
    FCopy: TppTBXItem;
    FPaste: TppTBXItem;
    FFontName: TppRTFFontComboBox;
    FFontSize: TppTBXSpinEditItem;
    FBold: TppTBXItem;
    FItalic: TppTBXItem;
    FUnderline: TppTBXItem;
    FAlignLeft: TppTBXItem;
    FCenter: TppTBXItem;
    FAlignRight: TppTBXItem;
    FBullets: TppTBXItem;
    FFullJustify: TppTBXItem;
    FRTFEditor: TppRTFEditor;
  protected
    procedure CreateItems; override;
    procedure ehItem_Click(Sender: TObject);
    procedure ehFontSizeChange(Sender: TppTBXCustomSpinEditItem; const AValue: Extended);
    procedure ehFontNameChange (Sender: TObject; const Text: string);
  public
    constructor Create(aOwner: TComponent); override;
    constructor CreateMenu(aOwner: TComponent; aRTFEditor: TppRTFEditor); virtual;
    procedure LanguageChanged; override;

    property Open: TppTBXItem read FOpen;
    property Save: TppTBXItem read FSave;
    property Print: TppTBXItem read FPrint;
    property Undo: TppTBXItem read FUndo;
    property Cut: TppTBXItem read FCut;
    property Copy: TppTBXItem read FCopy;
    property Paste: TppTBXItem read FPaste;
    property FontName: TppRTFFontComboBox read FFontName;
    property FontSize: TppTBXSpinEditItem read FFontSize;
    property Bold: TppTBXItem read FBold;
    property Italic: TppTBXItem read FItalic;
    property Underline: TppTBXItem read FUnderline;
    property AlignLeft: TppTBXItem read FAlignLeft;
    property Center: TppTBXItem read FCenter;
    property AlignRight: TppTBXItem read FAlignRight;
    property Bullets: TppTBXItem read FBullets;
    property FullJustify: TppTBXItem read FFullJustify;

  end; {class, TppRTFToolbar}

var
  ppRTFEditor: TppRTFEditor;

implementation

uses RichEdit, ShellAPI, ppClass, ppDisplayFormat, ppToolResources;

const
  RulerAdj = 4/3;
  GutterWid = 6;

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TppRTFEditor.FormCreate}

procedure TppRTFEditor.FormCreate(Sender: TObject);
begin
  CreateEditControl;
  CreateMenus;

  CreateStatusBar;


  Application.OnHint := ShowHint;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  SetFileName('Untitled');
  SetupRuler;
  SelectionChange(Self);
  FClipboardOwner := SetClipboardViewer(Handle);

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppRTFEditor.Destroy}

destructor TppRTFEditor.Destroy;
begin

  Destroying;

  //FFontComboBox.Free;
  FDataExplorer.Free;

  {unhook from show hints - NAM 08/12/97}
  Application.OnHint := nil;

  {remove ourselves from the viewer chain}
  ChangeClipboardChain(Handle, FClipboardOwner);

  FParaAttributes.Free;
  FParaAttributes := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FormCloseQuery}

procedure TppRTFEditor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  liResponse: Integer;
  lsMessage: String;

begin

  if not Editor.Modified then Exit;

   {string is 'Save changes?'}
   lsMessage := ppLoadStr(355);

   liResponse := MessageDlg(Format(lsMessage, [FFileName]), mtConfirmation, mbYesNoCancel, 0);

   {default response}
   CanClose    := True;
   ModalResult := mrIgnore;

   case liResponse of

    idYes: ModalResult := mrOK;      {close, changes will be saved }

    idNo: {nothing};                 {close without saving}

    idCancel: CanClose    := False;  {do not close}

  end;

end; {procedure, FormCloseQuery}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FormClose}

procedure TppRTFEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Application.OnHint := nil;

  Action := caHide;

end; {procedure, FormClose}

{------------------------------------------------------------------------------}
{ TppRTFEditor.CreateEditControl}

procedure TppRTFEditor.CreateEditControl;
var
  lFont: TFont;
  lRichEditClass: TppCustomRichEditClass;

begin

  lRichEditClass := ppGetRichEditClass;

 if lRichEditClass = nil then
   lRichEditClass := TRichEdit;

  FEditor := lRichEditClass.Create(Self);

  // TppParaAttributes is used to support fully jusitified rich text via
  // its TextAlignment property
  FParaAttributes := TppParaAttributes.Create(FEditor);

  FEditor.Parent := pnlEditorPanel;


  FEditor.HandleNeeded;

  FEditor.Align := alClient;
  TRichEdit(FEditor).WantTabs := True;
  TRichEdit(FEditor).MaxLength := MaxInt;


  lFont := TFont.Create;
  lFont.Name := 'Arial';
  lFont.Size := 12;

  ppSetOrdPropValue(FEditor, 'Font', Longint(lFont));

  lFont.Free;

  FEditor.TabOrder := 1;

  {note: the following events are protected}
  ppSetOrdPropValue(FEditor,    'ScrollBars', Ord(ssVertical));
  ppSetMethodPropValue(FEditor, 'OnChange', ppFindMethod(Self, 'RichEditChange'));
  ppSetMethodPropValue(FEditor, 'OnSelectionChange', ppFindMethod(Self, 'SelectionChange'));

end; {procedure, CreateEditControl}

{------------------------------------------------------------------------------}
{ TppRTFEditor.CreateMenus}

procedure TppRTFEditor.CreateMenus;
begin
  FMenuDock := TppTBXDock.Create(Self);
  FMenuDock.Parent := Self;
  FMenuDock.Align := alTop;
  FMenuDock.Height := 100;

  FMenu := TppRTFMenu.CreateMenu(Parent, Self);
  FMenu.Initialize(nil);
  FMenu.FreeNotification(Self);
  FMenu.CurrentDock := FMenuDock;

  FToolbarDock := TppTBXDock.Create(Self);
  FToolbarDock.Parent := pnlEditorPanel;
  FToolbarDock.Align := alTop;
  FToolbarDock.Height := 100;

  FToolbar := TppRTFToolbar.CreateMenu(Parent, Self);
  FToolbar.Initialize(nil);
  FToolbar.FreeNotification(Self);
  FToolbar.CurrentDock := FToolbarDock;
  FToolbar.LanguageChanged();

end; {procedure, CreateMenus}


{------------------------------------------------------------------------------}
{ TppRTFEditor.CreateMailMergeControl}

procedure TppRTFEditor.CreateMailMergeControl;
begin

  {Enable the Merge Panel}
  ClientWidth := ClientWidth + 200;
  cbxMailMerge.Left := 7;
  pnlMerge.Visible := True;
  MergeSplitter.Visible := True;

  {Create Data Explorer}
  FDataExplorer := TppDataExplorer.Create(pnlMerge, ppeoVertical);
  FDataExplorer.Report := TppCustomReport(Report);
  FDataExplorer.ListView.MultiSelect := False;
  FDataExplorer.ListView.RowSelect := True;
  FDataExplorer.ListView.OnSelectItem := ehSelectItem;
  FDataExplorer.ListView.OnDblClick := ehDblClickItem;

  pnlMergeTitle.Top := 0;

  SetMailMergeEnabled(MailMerge);

end; {procedure, CreateMailMergeControl}

{------------------------------------------------------------------------------}
{ TppRTFEditor.SetMailMergeEnabled}

procedure TppRTFEditor.SetMailMergeEnabled(aEnabled: Boolean);
begin
  MailMerge := aEnabled;

  cbxMailMerge.Checked := aEnabled;

  FDataExplorer.ListView.Enabled := aEnabled;
  FDataExplorer.ListView.ShowColumnHeaders := aEnabled;

  {Change text color}
  if aEnabled then
    begin
      FDataExplorer.ListView.Font.Color := clBlack;
      lbxDisplayFormats.Font.Color := clBlack;
      edtDisplayFormatText.Font.Color := clBlack;
    end
  else
    begin
      FDataExplorer.ListView.Font.Color := clGrayText;
      lbxDisplayFormats.Font.Color := clGrayText;
      edtDisplayFormatText.Font.Color := clGrayText;
    end;

  FDataExplorer.ListTitleBar.Visible := aEnabled;

  FDataExplorer.TreeView.Enabled := aEnabled;
  
  pnlFormat.Enabled := aEnabled;
  lblDisplayFormat.Enabled := aEnabled;
  btnAddField.Enabled := aEnabled;

end; {procedure, SetMailMergeEnabled}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehSelectItem}

procedure TppRTFEditor.ehSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  lDataType: TppDataType;
begin

  if Selected then
    begin
      btnAddField.Enabled := True;
      FField := TppField(FDataExplorer.ListView.SelectedComponent);
    end;

  if FField = nil then Exit;

  if FField.DataType in [dtBLOB, dtGraphic] then
    btnAddField.Enabled := False;

  lDataType := FField.DataType;

  ppGetDisplayFormats(lDataType, lbxDisplayFormats.Items);

end; {procedure, ehSelectItem}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehDblClickItem}

procedure TppRTFEditor.ehDblClickItem(Sender: TObject);
begin
  if (FField = nil) or (FField.DataType in [dtBLOB, dtGraphic]) then Exit;

  Editor.SetSelTextBuf(PChar(GenerateFieldCode));
end; {procedure, ehDblClickItem}


{------------------------------------------------------------------------------}
{ TppRTFEditor.GetLines}

function TppRTFEditor.GetLines: TStrings;
begin
  Result := ppGetRichEditLines(Editor);
end; {procedure, GetLines}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FormShow}

procedure TppRTFEditor.FormShow(Sender: TObject);
begin

  UpdateCaretPos;
  DragAcceptFiles(Handle, True);
  Editor.SetFocus;
  ClipboardChanged;

  Editor.Modified := False; {NAM 08/12/97}
  RichEditChange(Self);

end; {procedure, FormShow}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ShowHint}

procedure TppRTFEditor.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    StatusBar.SimplePanel := True;
    StatusBar.SimpleText := Application.Hint;
  end
  else StatusBar.SimplePanel := False;
end; {procedure, ShowHint}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehFileNew}

procedure TppRTFEditor.ehFileNew(Sender: TObject);
begin

  SetFileName('Untitled');

  GetLines.Clear;

  Editor.Modified := True;
  SetModified(True);

end; {procedure, ehFileNew}

{------------------------------------------------------------------------------}
{ TppRTFEditor.PerformFileOpen}

procedure TppRTFEditor.PerformFileOpen(const AFileName: string);
begin

  GetLines.LoadFromFile(AFileName);

  SetFileName(AFileName);

  Editor.SetFocus;

  Editor.Modified := True;
  SetModified(True);

end; {procedure, PerformFileOpen}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehFileOpen}

procedure TppRTFEditor.ehFileOpen(Sender: TObject);
var
  lbReadOnly: Boolean;
begin

  CheckFileSave;

  if OpenDialog.Execute then
    begin
      PerformFileOpen(OpenDialog.FileName);

      lbReadOnly :=  (ofReadOnly in OpenDialog.Options);

      ppSetOrdPropValue(Editor, 'ReadOnly', Ord(lbReadOnly));
    end;

end; {procedure, ehFileOpen}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehFileSaveAs}

procedure TppRTFEditor.ehFileSaveAs(Sender: TObject);
var
  lsMessage: String;
begin

  if SaveDialog.Execute then
    begin

      if FileExists(SaveDialog.FileName) then
        begin
          {string is 'OK to overwrite <filename>?'}
          lsMessage := ppLoadStr(356);
          lsMessage := ppSetMessageParameters(lsMessage);
          lsMessage := Format(lsMessage, [SaveDialog.FileName]);

          if MessageDlg(lsMessage, mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;
        end;

      GetLines.SaveToFile(SaveDialog.FileName);

      SetFileName(SaveDialog.FileName);
    end;

end; {procedure, ehFileSaveAs}

{------------------------------------------------------------------------------}
{ TppRTFEditor.CheckFileSave}

procedure TppRTFEditor.CheckFileSave;
var
  liResponse: Integer;
  lsMessage: String;
begin

  if not Editor.Modified then Exit;

  {string is 'Save changes to <filename>?'}
  lsMessage := ppLoadStr(357);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [FFileName]);

  liResponse := MessageDlg(lsMessage, mtConfirmation, mbYesNoCancel, 0);

  case liResponse of
    idYes: ehFileSaveAs(Self);
    idNo: {Nothing};
    idCancel: Abort;
  end;

end; {procedure, CheckFileSave}

{------------------------------------------------------------------------------}
{ TppRTFEditor.SetFileName}

procedure TppRTFEditor.SetFileName(const FileName: String);
begin

  FFileName := FileName;

  {string is 'Rich Text Editor'}
  Caption := ppLoadStr(353) + ': ' + ExtractFileName(FileName);

end; {procedure, SetFileName}

{------------------------------------------------------------------------------}
{ TppRTFEditor.SelectionChange}

procedure TppRTFEditor.SelectionChange(Sender: TObject);
begin

  FUpdating := True;

  try
    // paragraph attributes
    FirstInd.Left := Trunc(FParaAttributes.FirstIndent*RulerAdj)-4+GutterWid;
    LeftInd.Left := Trunc((FParaAttributes.LeftIndent+FParaAttributes.FirstIndent)*RulerAdj)-4+GutterWid;
    RightInd.Left := Ruler.ClientWidth-6-Trunc((FParaAttributes.RightIndent+GutterWid)*RulerAdj);

    FToolbar.Bullets.Checked := Boolean(FParaAttributes.Numbering);

    case Ord(FParaAttributes.Alignment) of
      0: FToolbar.AlignLeft.Checked := True;
      1: FToolbar.AlignRight.Checked := True;
      2: FToolbar.Center.Checked := True;
      3: FToolbar.FullJustify.Checked := True;
    end;

    // text attributes
    if (caBold in Editor.SelAttributes.ConsistentAttributes) then
      FToolbar.Bold.Checked := fsBold in Editor.SelAttributes.Style
    else
      FToolbar.Bold.Checked := False;

    if (caItalic in Editor.SelAttributes.ConsistentAttributes) then
      FToolbar.Italic.Checked := fsItalic in Editor.SelAttributes.Style
    else
      FToolbar.Italic.Checked := False;

    if (caUnderline in Editor.SelAttributes.ConsistentAttributes) then
      FToolbar.Underline.Checked := fsUnderline in Editor.SelAttributes.Style
    else
      FToolbar.Underline.Checked := False;

    if (caSize in Editor.SelAttributes.ConsistentAttributes) then
      FToolbar.FontSize.Text := IntToStr(Editor.SelAttributes.Size)
    else
      FToolbar.FontSize.Text := '';

    if (caFace in Editor.SelAttributes.ConsistentAttributes)	 then
      FToolbar.FontName.FontName := Editor.SelAttributes.Name
    else
      FToolbar.FontName.FontName := '';

    UpdateCaretPos;
  finally
    FUpdating := False;
  end;

end; {procedure, SelectionChange}

{------------------------------------------------------------------------------}
{ TppRTFEditor.CurrText}

function TppRTFEditor.CurrText: TTextAttributes;
begin
  Result := nil;

  if (Editor <> nil) then
    Result := Editor.SelAttributes;

end; {procedure, CurrText}

{------------------------------------------------------------------------------}
{ TppRTFEditor.SetupRuler}

procedure TppRTFEditor.SetupRuler;
var
  I: Integer;
  S: String;
begin

  SetLength(S, 201);

  I := 1;

  while I < 200 do
    begin
      S[I] := #9;
      S[I+1] := '|';

      Inc(I, 2);
    end;

  Ruler.Caption := S;

end; {procedure, SetupRuler}

{------------------------------------------------------------------------------}
{ TppRTFEditor.SetEditRect}

procedure TppRTFEditor.SetEditRect;
var
  R: TRect;
begin

  with Editor do
  begin
    R := Rect(GutterWid, 0, ClientWidth-GutterWid, ClientHeight);
    SendMessage(Handle, EM_SETRECT, 0, Longint(@R));
  end;

end; {procedure, SetEditRect}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehFilePrint}

procedure TppRTFEditor.ehFilePrint(Sender: TObject);
begin

  if PrintDialog.Execute then
    Editor.Print(FFileName);

end; {procedure, ehFilePrint}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehFileExit}

procedure TppRTFEditor.ehFileExit(Sender: TObject);
begin
  Close;
end; {procedure, ehFileExit}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehEditUndo}

procedure TppRTFEditor.ehEditUndo(Sender: TObject);
begin
  with Editor do
    if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);
end; {procedure, ehEditUndo}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehEditCut}

procedure TppRTFEditor.ehEditCut(Sender: TObject);
begin
  Editor.CutToClipboard;
end; {procedure, ehEditCut}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehEditCopy}

procedure TppRTFEditor.ehEditCopy(Sender: TObject);
begin
  Editor.CopyToClipboard;
end; {procedure, ehEditCopy}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehEditPaste}

procedure TppRTFEditor.ehEditPaste(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end; {procedure, ehEditPaste}

{------------------------------------------------------------------------------}
{ TppRTFEditor.SelectFont}

procedure TppRTFEditor.SelectFont(Sender: TObject);
begin

  FontDialog1.Font.Assign(Editor.SelAttributes);

  if FontDialog1.Execute then
    CurrText.Assign(FontDialog1.Font);

  Editor.SetFocus;

end; {procedure, SelectFont}

{------------------------------------------------------------------------------}
{ TppRTFEditor.RulerResize}

procedure TppRTFEditor.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left*2);
end; {procedure, RulerResize}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FormResize}

procedure TppRTFEditor.FormResize(Sender: TObject);
begin
  if (csDestroying in ComponentState) then Exit;

  SetEditRect;

  SelectionChange(Sender);

end; {procedure, FormResize}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FormPaint}

procedure TppRTFEditor.FormPaint(Sender: TObject);
begin
  SetEditRect;
end; {procedure, FormPaint}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehBoldButtonClick}

procedure TppRTFEditor.ehBoldButtonClick(Sender: TObject);
begin

  if FUpdating then Exit;

  FToolbar.Bold.Checked := not(FToolbar.Bold.Checked);

  if FToolbar.Bold.Checked then
    CurrText.Style := CurrText.Style + [fsBold]
  else
    CurrText.Style := CurrText.Style - [fsBold];

end; {procedure, ehBoldButtonClick}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehItalicButtonClick}

procedure TppRTFEditor.ehItalicButtonClick(Sender: TObject);
begin

  if FUpdating then Exit;

  FToolbar.Italic.Checked := not(FToolbar.Italic.Checked);

  if FToolbar.Italic.Checked then
    CurrText.Style := CurrText.Style + [fsItalic]
  else
    CurrText.Style := CurrText.Style - [fsItalic];

end; {procedure, ehItalicButtonClick}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FontSizeChange}

procedure TppRTFEditor.FontSizeChange(Sender: TObject);
begin

  if FUpdating then Exit;

  CurrText.Size := StrToInt(FToolbar.FontSize.Text);

end; {procedure, FontSizeChange}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehAlignButtonClick}

procedure TppRTFEditor.ehAlignButtonClick(Sender: TObject);
begin

  if FUpdating then Exit;

  TppTBXItem(Sender).Checked := True;

  FParaAttributes.TextAlignment := TppTextAlignment(TControl(Sender).Tag);
  
end; {procedure, ehAlignButtonClick}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FontNameChange}

procedure TppRTFEditor.FontNameChange(Sender: TObject);
var
  lFont: TFont;
begin

  if FUpdating then Exit;

  lFont := TFont.Create;
  lFont.Assign(CurrText);

  //lFont.CharSet :=  TppRTFFontComboBox(Sender).CurrentFont.CharSet;
  lFont.Name    := TppRTFFontComboBox(Sender).FontName;

  CurrText.Assign(lFont);

  lFont.Free;

end; {procedure, FontNameChange}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehUnderlineButtonClick}

procedure TppRTFEditor.ehUnderlineButtonClick(Sender: TObject);
begin

  if FUpdating then Exit;

  FToolbar.Underline.Checked := not(FToolbar.Underline.Checked);

  if FToolbar.Underline.Checked then
    CurrText.Style := CurrText.Style + [fsUnderline]
  else
    CurrText.Style := CurrText.Style - [fsUnderline];

end; {procedure, ehUnderlineButtonClick}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ehBulletsButtonClick}

procedure TppRTFEditor.ehBulletsButtonClick(Sender: TObject);
begin

  if FUpdating then Exit;

  FToolbar.Bullets.Checked := not(FToolbar.Bullets.Checked);

  Editor.Paragraph.Numbering := TNumberingStyle(FToolbar.Bullets.Checked);

end; {procedure, ehBulletsButtonClick}

{------------------------------------------------------------------------------}
{ TppRTFEditor.RulerItemMouseDown}

procedure TppRTFEditor.RulerItemMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  FDragOfs := (TLabel(Sender).Width div 2);

  TLabel(Sender).Left := TLabel(Sender).Left+X-FDragOfs;

  FDragging := True;

end; {procedure, RulerItemMouseDown}

{------------------------------------------------------------------------------}
{ TppRTFEditor.RulerItemMouseMove}

procedure TppRTFEditor.RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin

  if FDragging then
    TLabel(Sender).Left :=  TLabel(Sender).Left+X-FDragOfs;

end; {procedure, RulerItemMouseMove}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FirstIndMouseUp}

procedure TppRTFEditor.FirstIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  FDragging := False;

  Editor.Paragraph.FirstIndent := Trunc((FirstInd.Left+FDragOfs-GutterWid) / RulerAdj);

  LeftIndMouseUp(Sender, Button, Shift, X, Y);

end; {procedure, FirstIndMouseUp}

{------------------------------------------------------------------------------}
{ TppRTFEditor.LeftIndMouseUp}

procedure TppRTFEditor.LeftIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  FDragging := False;

  Editor.Paragraph.LeftIndent := Trunc((LeftInd.Left+FDragOfs-GutterWid) / RulerAdj)-Editor.Paragraph.FirstIndent;

  SelectionChange(Sender);

end; {procedure, LeftIndMouseUp}

{------------------------------------------------------------------------------}
{ TppRTFEditor.RightIndMouseUp}

procedure TppRTFEditor.RightIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  FDragging := False;

  Editor.Paragraph.RightIndent := Trunc((Ruler.ClientWidth-RightInd.Left+FDragOfs-2) / RulerAdj)-2*GutterWid;

  SelectionChange(Sender);

end; {procedure, RightIndMouseUp}

{------------------------------------------------------------------------------}
{ TppRTFEditor.UpdateCaretPos}

procedure TppRTFEditor.UpdateCaretPos;
var
  CharPos: TPoint;
begin

  CharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0, Editor.SelStart);
  CharPos.X := (Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  StatusBar.Panels[0].Text := Format(FStatusString, [CharPos.Y, CharPos.X]);

  // update the status of the cut and copy command
  FToolBar.Copy.Enabled := Editor.SelLength > 0;
  FMenu.EditMenu.Copy.Enabled := FToolBar.Copy.Enabled;
  FToolBar.Cut.Enabled := FToolBar.Copy.Enabled;
  FMenu.EditMenu.Cut.Enabled := FToolBar.Copy.Enabled;

end; {procedure, UpdateCaretPos}

{------------------------------------------------------------------------------}
{ TppRTFEditor.WMDropFiles}

procedure TppRTFEditor.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of Char;
begin

  try

    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
      begin
        CheckFileSave;

        PerformFileOpen(CFileName);

        Msg.Result := 0;
      end;

  finally
    DragFinish(Msg.Drop);
  end;

end; {procedure, WMDropFiles}

{------------------------------------------------------------------------------}
{ TppRTFEditor.RichEditChange}

procedure TppRTFEditor.RichEditChange(Sender: TObject);
begin

  SetModified(Editor.Modified);

  FToolBar.Undo.Enabled   := SendMessage(Editor.Handle, EM_CANUNDO, 0, 0) <> 0;

  FMenu.EditMenu.Undo.Enabled := FToolBar.Undo.Enabled;

end; {procedure, RichEditChange}

{------------------------------------------------------------------------------}
{ TppRTFEditor.SetModified}

procedure TppRTFEditor.SetModified(Value: Boolean);
begin

  {string is 'Modified'}
  if Value then
    StatusBar.Panels[1].Text := ppLoadStr(360)
  else
    StatusBar.Panels[1].Text := '';

end; {procedure, SetModified}

{------------------------------------------------------------------------------}
{ TppRTFEditor.WMChangeCBChain}

procedure TppRTFEditor.WMChangeCBChain(var Msg: TWMChangeCBChain);
begin

  if Msg.Remove = FClipboardOwner then
    FClipboardOwner := Msg.Next
  else
    SendMessage(FClipboardOwner, WM_CHANGECBCHAIN, Msg.Remove, Msg.Next);

  Msg.Result := 0;

end; {procedure, WMChangeCBChain}

{------------------------------------------------------------------------------}
{ TppRTFEditor.ClipboardChanged}

procedure TppRTFEditor.ClipboardChanged;
var
  I: Integer;
  Format: Word;
  E: Boolean;
begin

  // check to see if we can paste what's on the clipboard
  E := False;

  for I := 0 to Clipboard.FormatCount - 1 do
    begin
      Format := Clipboard.Formats[I];
      if SendMessage(Editor.Handle, EM_CANPASTE, Format, 0) <> 0 then
        begin
          E := True;
          Break;
        end;
    end;

  FToolbar.Paste.Enabled := E;
  FMenu.EditMenu.Paste.Enabled := E;

end; {procedure, ClipboardChanged}

{------------------------------------------------------------------------------}
{ TppRTFEditor.WMDrawClipboard}

procedure TppRTFEditor.WMDrawClipboard(var Msg: TWMDrawClipboard);
begin

  SendMessage(FClipboardOwner, WM_DRAWCLIPBOARD, 0, 0);

  Msg.Result := 0;

  ClipboardChanged;

end; {procedure, WMDrawClipboard}

{------------------------------------------------------------------------------}
{ TppRTFEditor.LanguageChanged }

procedure TppRTFEditor.LanguageChanged;
var
  lsLine: String;
  lsCol: String;
begin

  Caption := ppLoadStr(353);

  lsLine := ppLoadStr(358);
  lsCol := ppLoadStr(359);
  FStatusString := lsLine + ': %3d   ' + lsCol + ': %3d';

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppRTFEditor.GenerateFieldCode}

function TppRTFEditor.GenerateFieldCode: String;
var
  lsDataPipeline: String;
  lsFieldName: String;
  lsDisplayFormat: String;
  lsCode: String;
begin

  if FDataExplorer.ListView.SelectedComponent = nil then Exit;

  lsDataPipeline := TppDataPipeline(FDataExplorer.TreeView.SelectedComponent).Name;
  lsFieldName := FDataExplorer.ListView.Selected.Caption;
  lsDisplayFormat := edtDisplayFormatText.Text;

  lsCode := '<dbtext';

  if (TppCustomReport(Report).DataPipeline = nil) or (lsDataPipeline <> TppCustomReport(Report).DataPipeline.Name) then
    lsCode := lsCode + ' datapipeline=''' + lsDataPipeline + '''';

  if lsDisplayFormat <> '' then
    lsCode := lsCode + ' displayformat=''' + lsDisplayFormat + '''';

  Result := lsCode + '>' + lsFieldName + '</dbtext>';

end; {procedure, GenerateFieldCode}

{------------------------------------------------------------------------------}
{ TppRTFEditor.lbxDisplayFormatsDrawItem}

procedure TppRTFEditor.lbxDisplayFormatsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  lsDesc: String;
  lsFormat: String;
  liPos: Integer;
  lStringBuf: array[0..255] of Char;
begin

  {get the position of the spacer}
  liPos := Pos(cSpacer, lbxDisplayFormats.Items[Index]);

  {get the format description}
  lsDesc := Copy(lbxDisplayFormats.Items[Index], 1, liPos - 1);

  {get the format}
  lsFormat := Copy(lbxDisplayFormats.Items[Index], liPos + 1, Length(lbxDisplayFormats.Items[Index]));

  {clear out Rect}
  lbxDisplayFormats.Canvas.FillRect(Rect);

  {draw format description in first column}
  DrawText(lbxDisplayFormats.Canvas.Handle, StrPCopy(lStringBuf, lsDesc), -1, Rect, dt_SingleLine
           or dt_Left or dt_VCenter);

  {goto next column}
  Rect.Left := 110;

  {draw format in second column }
  DrawText(lbxDisplayFormats.Canvas.Handle, StrPCopy(lStringBuf, lsFormat), -1, Rect, dt_SingleLine
           or dt_Left or dt_VCenter);

end; {procedure, lbxDisplayFormatsDrawItem}

{------------------------------------------------------------------------------}
{ TppRTFEditor.lbxDisplayFormatsClick}

procedure TppRTFEditor.lbxDisplayFormatsClick(Sender: TObject);
var
  lsDesc: String;
  lsFormat: String;
  liPos: Integer;
  liIndex: Integer;
begin

  liIndex := lbxDisplayFormats.ItemIndex;

  {get the position of the spacer}
  liPos := Pos(cSpacer, lbxDisplayFormats.Items[liIndex]);

  {get the format description}
  lsDesc := Copy(lbxDisplayFormats.Items[liIndex], 1, liPos - 1);

  {get the format}
  lsFormat := Copy(lbxDisplayFormats.Items[liIndex], liPos + 1, Length(lbxDisplayFormats.Items[liIndex]));

  edtDisplayFormatText.Text := lsFormat;

end; {procedure, lbxDisplayFormatsClick}

{------------------------------------------------------------------------------}
{ TppRTFEditor.btnAddFieldClick}

procedure TppRTFEditor.btnAddFieldClick(Sender: TObject);
begin
  Editor.SetSelTextBuf(PChar(GenerateFieldCode));

end; {procedure, btnAddFieldClick}

{------------------------------------------------------------------------------}
{ TppRTFEditor.cbxMailMergeClick}

procedure TppRTFEditor.cbxMailMergeClick(Sender: TObject);
begin

  if cbxMailMerge.Checked then
    SetMailMergeEnabled(True)
  else
    SetMailMergeEnabled(False);

end; {procedure, cbxMailMergeClick}

procedure TppRTFEditor.CreateStatusBar;
begin
  FStatusBar := TppTBXStatusBar.Create(Self);
  FStatusBar.Parent := Self;
  FStatusBar.Panels.Add;
  FStatusBar.Panels.Add;
  FStatusBar.Panels.Add;
  FStatusBar.Panels[0].Width := 120;
  FStatusBar.Panels[1].Width := 60;
  FStatusBar.Panels[2].Width := 50;
end;

{------------------------------------------------------------------------------}
{ TppRTFEditor.MergeSplitterMoved}

procedure TppRTFEditor.MergeSplitterMoved(Sender: TObject);
begin
  btnAddField.Left :=  (pnlMerge.Width div 2) - (btnAddField.Width div 2);
  //cbxMailMerge.Left :=  (pnlMerge.Width div 2) - (cbxMailMerge.Width div 2);

end; {procedure, MergeSplitterMoved}

{------------------------------------------------------------------------------}
{ TppRTFEditor.FormActivate}

procedure TppRTFEditor.FormActivate(Sender: TObject);
begin
  CreateMailMergeControl;

end; {procedure, FormActivate}


{******************************************************************************
 *
 ** R T F   E D I T O R   C O N T R O L L E R
 *
{******************************************************************************}

{ TppRTFEditorController }

class procedure TppRTFEditorController.Edit(aRichText: TppRichText);
var
  lRichTextPopupMenu: TppRichTextPopupMenu;
begin
  lRichTextPopupMenu := TppRichTextPopupMenu.Create(nil);

  try
    lRichTextPopupMenu.Component := aRichText;

    lRichTextPopupMenu.Edit;

  finally
    lRichTextPopupMenu.Free;
  end;



end;

{******************************************************************************
 *
 **  R T F   M A I N   M E N U
 *
{******************************************************************************}

constructor TppRTFMenu.Create(Owner: TComponent);
begin
  inherited;

  Name := 'Menu'; // do not localize
  MenuBar := True;

  DockMode := dmCannotFloatOrChangeDocks;

end;

procedure TppRTFMenu.CreateItems;
begin
  FFileMenu := TppRTFFileMenu.CreateMenu(nil, FRTFEditor);
  Items.Add(FFileMenu);

  FEditMenu := TppRTFEditMenu.CreateMenu(nil, FRTFEditor);
  Items.Add(FEditMenu);

  LanguageChanged();

end;

constructor TppRTFMenu.CreateMenu(aOwner: TComponent; aRTFEditor: TppRTFEditor);
begin
  FRTFEditor := aRTFEditor;

  Create(aOwner);

end;

procedure TppRTFMenu.LanguageChanged;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Items.Count-1 do
    if (Items[liIndex] is TppSubMenuItem) then
      TppSubMenuItem(Items[liIndex]).LanguageChanged();

end;

{******************************************************************************
 *
 **  R T F   F I L E   M E N U
 *
{******************************************************************************}

procedure TppRTFFileMenu.CreateControls;
begin
  FNew := AddChildItem();
  FNew.ShortCut := Menus.ShortCut(Ord('N'), [ssCtrl]); // Ctrl+N
  FNew.ImageIndex := ToolImageList.AddTool('PPNEW');
  FNew.OnClick := ehItem_Click;

  FOpen := AddChildItem();
  FOpen.ShortCut := Menus.ShortCut(Ord('O'), [ssCtrl]); // Ctrl+O
  FOpen.ImageIndex := ToolImageList.AddTool('PPOPEN');
  FOpen.OnClick := ehItem_Click;

  FSaveAs := AddChildItem();
  FSaveAs.ImageIndex := ToolImageList.AddTool('PPSAVE');
  FSaveAs.OnClick := ehItem_Click;

  AddSeparator();

  FPrint := AddChildItem();
  FPrint.ShortCut := Menus.ShortCut(Ord('P'), [ssCtrl]); // Ctrl+P
  FPrint.ImageIndex := ToolImageList.AddTool('PPPRINT');
  FPrint.OnClick := ehItem_Click;

  AddSeparator();

  FExit := AddChildItem();
  FExit.ShortCut := Menus.ShortCut(Ord('X'), [ssAlt]); // Alt+X
  FExit.OnClick := ehItem_Click;

end;

constructor TppRTFFileMenu.CreateMenu(aOwner: TComponent; aRTFEditor: TppRTFEditor);
begin
  FRTFEditor := aRTFEditor;

  Create(aOwner);

end;

procedure TppRTFFileMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FNew) then
    FRTFEditor.ehFileNew(Sender)

  else if (Sender = FOpen) then
    FRTFEditor.ehFileOpen(Sender)

  else if (Sender = FSaveAs) then
    FRTFEditor.ehFileSaveAs(Sender)

  else if (Sender = FPrint) then
    FRTFEditor.ehFilePrint(Sender)

  else if (Sender = FExit) then
    FRTFEditor.ehFileExit(Sender);

end;

procedure TppRTFFileMenu.LanguageChanged;
begin

  Caption := ppLoadStr(131);

  FNew.Caption :=  ppLoadStr(133);
  FOpen.Caption := ppLoadStr(134);
  FSaveAs.Caption := ppLoadStr(139);
  FPrint.Caption := ppLoadStr(136);
  FExit.Caption := ppLoadStr(132);

end;

{******************************************************************************
 *
 **  R T F   E D I T   M E N U
 *
{******************************************************************************}

procedure TppRTFEditMenu.CreateControls;
begin

  FUndo := AddChildItem();
  FUndo.ShortCut := Menus.ShortCut(Ord('Z'), [ssCtrl]); // Ctrl+Z
  FUndo.ImageIndex := ToolImageList.AddTool('PPUNDO');
  FUndo.OnClick := ehItem_Click;

  AddSeparator();

  FCut := AddChildItem();
  FCut.ShortCut := Menus.ShortCut(Ord('X'), [ssCtrl]); // Ctrl+X
  FCut.ImageIndex := ToolImageList.AddTool('PPCUT');
  FCut.OnClick := ehItem_Click;

  FCopy := AddChildItem();
  FCopy.ShortCut := Menus.ShortCut(Ord('C'), [ssCtrl]); // Ctrl+C
  FCopy.ImageIndex := ToolImageList.AddTool('PPCOPY');
  FCopy.OnClick := ehItem_Click;

  FPaste := AddChildItem();
  FPaste.ShortCut := Menus.ShortCut(Ord('V'), [ssCtrl]); // Ctrl+V 
  FPaste.ImageIndex := ToolImageList.AddTool('PPPASTE');
  FPaste.OnClick := ehItem_Click;

  AddSeparator();

  FFont := AddChildItem();
  FFont.ImageIndex := ToolImageList.AddTool('PPFONTNAME');
  FFont.OnClick := ehItem_Click;

end;

constructor TppRTFEditMenu.CreateMenu(aOwner: TComponent; aRTFEditor: TppRTFEditor);
begin
  FRTFEditor := aRTFEditor;

  Create(aOwner);
end;

procedure TppRTFEditMenu.ehItem_Click(Sender: TObject);
begin
  if (Sender = FUndo) then
    FRTFEditor.ehEditUndo(Sender)

  else if (Sender = FCut) then
    FRTFEditor.ehEditCut(Sender)

  else if (Sender = FCopy) then
    FRTFEditor.ehEditCopy(Sender)

  else if (Sender = FPaste) then
    FRTFEditor.ehEditPaste(Sender)

  else if (Sender = FFont) then
    FRTFEditor.SelectFont(Sender);

end;

procedure TppRTFEditMenu.LanguageChanged;
begin
  Caption := ppLoadStr(120);

  FUndo.Caption :=  ppLoadStr(130);
  FCut.Caption := ppLoadStr(123);
  FCopy.Caption := ppLoadStr(122);
  FPaste.Caption := ppLoadStr(125);
  FFont.Caption := ppLoadStr(505);

end;

{******************************************************************************
 *
 **  R T F   T O O L B A R
 *
{******************************************************************************}

constructor TppRTFToolbar.Create(aOwner: TComponent);
begin
  inherited;

  DockMode := dmCannotFloatOrChangeDocks;

end;

procedure TppRTFToolbar.CreateItems;
begin
  FOpen := AddButton();
  FOpen.ImageIndex := ToolImageList.AddIcon('PPOPEN');
  FOpen.OnClick := ehItem_Click;

  FSave := AddButton();
  FSave.ImageIndex := ToolImageList.AddIcon('PPSAVE');
  FSave.OnClick := ehItem_Click;

  FPrint := AddButton();
  FPrint.ImageIndex := ToolImageList.AddIcon('PPPRINT');
  FPrint.OnClick := ehItem_Click;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FUndo := AddButton();
  FUndo.ImageIndex := ToolImageList.AddIcon('PPUNDO');
  FUndo.OnClick := ehItem_Click;

  FCut := AddButton();
  FCut.ImageIndex := ToolImageList.AddIcon('PPCUT');
  FCut.OnClick := ehItem_Click;

  FCopy := AddButton();
  FCopy.ImageIndex := ToolImageList.AddIcon('PPCOPY');
  FCopy.OnClick := ehItem_Click;

  FPaste := AddButton();
  FPaste.ImageIndex := ToolImageList.AddIcon('PPPASTE');
  FPaste.OnClick := ehItem_Click;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FFontName := TppRTFFontComboBox.Create(Owner);
  FFontName.OnChange := ehFontNameChange;
  FFontName.Loaded();
  Items.Add(FFontName);

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FFontSize := TppTBXSpinEditItem.Create(Owner);
  FFontSize.MaxValue := 1000;
  FFontSize.OnValueChange := ehFontSizeChange;
  Items.Add(FFontSize);

  FBold := AddButton();
  FBold.ImageIndex := ToolImageList.AddIcon('PPBOLD');
  FBold.OnClick := ehItem_Click;

  FItalic := AddButton();
  FItalic.ImageIndex := ToolImageList.AddIcon('PPITALIC');
  FItalic.OnClick := ehItem_Click;

  FUnderline := AddButton();
  FUnderline.ImageIndex := ToolImageList.AddIcon('PPUNDERLINE');
  FUnderline.OnClick := ehItem_Click;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FAlignLeft := AddButton();
  FAlignLeft.GroupIndex := 20;
  FAlignLeft.Tag := 0;
  FAlignLeft.ImageIndex := ToolImageList.AddIcon('PPALIGNLEFT');
  FAlignLeft.OnClick := ehItem_Click;

  FCenter := AddButton();
  FCenter.GroupIndex := 20;
  FCenter.Tag := 2;
  FCenter.ImageIndex := ToolImageList.AddIcon('PPALIGNCENTER');
  FCenter.OnClick := ehItem_Click;

  FAlignRight := AddButton();
  FAlignRight.GroupIndex := 20;
  FAlignRight.Tag := 1;
  FAlignRight.ImageIndex := ToolImageList.AddIcon('PPALIGNRIGHT');
  FAlignRight.OnClick := ehItem_Click;

  FFullJustify := AddButton();
  FFullJustify.GroupIndex := 20;
  FFullJustify.Tag := 3;
  FFullJustify.ImageIndex := ToolImageList.AddIcon('PPJUSTIFY');
  FFullJustify.OnClick := ehItem_Click;

  AddSpacer(9);
  AddSeparator();
  AddSpacer(9);

  FBullets := AddButton();
  FBullets.ImageIndex := ToolImageList.AddIcon('PPBULLETS');
  FBullets.OnClick := ehItem_Click;

end;

constructor TppRTFToolbar.CreateMenu(aOwner: TComponent; aRTFEditor: TppRTFEditor);
begin
  FRTFEditor := aRTFEditor;

  Create(aOwner);
end;

procedure TppRTFToolbar.ehFontNameChange(Sender: TObject; const Text: string);
begin
  FRTFEditor.FontNameChange(Sender);

end;

procedure TppRTFToolbar.ehFontSizeChange(Sender: TppTBXCustomSpinEditItem; const AValue: Extended);
begin
  FRTFEditor.FontSizeChange(Sender);

end;

procedure TppRTFToolbar.ehItem_Click(Sender: TObject);
begin
  if (Sender = FOpen) then
    FRTFEditor.ehFileOpen(Sender)

  else if (Sender = FSave) then
    FRTFEditor.ehFileSaveAs(Sender)

  else if (Sender = FPrint) then
    FRTFEditor.ehFilePrint(Sender)

  else if (Sender = FUndo) then
    FRTFEditor.ehEditUndo(Sender)

  else if (Sender = FCut) then
    FRTFEditor.ehEditCut(Sender)

  else if (Sender = FCopy) then
    FRTFEditor.ehEditCopy(Sender)

  else if (Sender = FPaste) then
    FRTFEditor.ehEditPaste(Sender)

  else if (Sender = FBold) then
    FRTFEditor.ehBoldButtonClick(Sender)

  else if (Sender = FItalic) then
    FRTFEditor.ehItalicButtonClick(Sender)

  else if (Sender = FUnderline) then
    FRTFEditor.ehUnderlineButtonClick(Sender)

  else if (Sender = FAlignLeft) then
    FRTFEditor.ehAlignButtonClick(Sender)

  else if (Sender = FCenter) then
    FRTFEditor.ehAlignButtonClick(Sender)

  else if (Sender = FAlignRight) then
    FRTFEditor.ehAlignButtonClick(Sender)

  else if (Sender = FFullJustify) then
    FRTFEditor.ehAlignButtonClick(Sender)

  else if (Sender = FBullets) then
    FRTFEditor.ehBulletsButtonClick(Sender);

end;

procedure TppRTFToolbar.LanguageChanged;
begin

  FOpen.Hint       := ppLoadStr(361);
  FSave.Hint       := ppLoadStr(362);
  FPrint.Hint      := ppLoadStr(22); {Print}
  FUndo.Hint       := ppLoadStr(364);
  FCut.Hint        := ppLoadStr(365);
  FCopy.Hint       := ppLoadStr(366);
  FPaste.Hint      := ppLoadStr(367);

  FFontName.Hint   := ppLoadStr(168);
  FFontSize.Hint   := ppLoadStr(169);
  FBold.Hint       := ppLoadStr(160);
  FItalic.Hint     := ppLoadStr(171);
  FUnderline.Hint  := ppLoadStr(179);
  FAlignLeft.Hint  := ppLoadStr(173);
  FCenter.Hint     := ppLoadStr(163);
  FAlignRight.Hint := ppLoadStr(176);
  FFullJustify.Hint := ppLoadStr(1125);
  FBullets.Hint    := ppLoadStr(354);

end;

{******************************************************************************
 *
 **  R T F   F O N T   C O M B O B O X
 *
{******************************************************************************}

destructor TppRTFFontComboBox.Destroy;
begin
  FFontList.Free;
  inherited;
end;

function TppRTFFontComboBox.GetCurrentFont: TFont;
var
  liIndex: Integer;
begin

  liIndex := FFontList.IndexOf(FontName);

  Result := TFont(FFontList[liIndex]);

end;

function TppRTFFontComboBox.GetFontList: Boolean;
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

procedure TppRTFFontComboBox.InitializeFontList;
begin
  GetFontList;

  Strings.Assign(FFontList);

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  ppRegisterForm(TppCustomRTFEditor, TppRTFEditor);

finalization

  ppUnRegisterForm(TppCustomRTFEditor);

end.
 
