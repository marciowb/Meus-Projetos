{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxWebHTMLEdBar;

interface

uses
  Classes, Controls, Windows, SysUtils, Graphics, Menus,
  StdCtrls, ExtCtrls, ComCtrls, ImgList, ActiveX, Dialogs, cxWebHTMLEdIntf;

type
  TcxHTMLEditorActionType = (eatButton, eatCheck, eatColor, eatDropDown, eatCombo, eatDevider, eatSpacer);
  TActionMethod = procedure(ASender: TObject) of object;

  PcxHTMLEditorBarAction = ^TcxHTMLEditorBarAction;
  TcxHTMLEditorBarAction = record
    Name: string;
    ActType: TcxHTMLEditorActionType;
    Hint: string;
    ImgIndex: Integer;
    Command: Integer;
    Method: TActionMethod;
  end;

  PcxHTMLEditorComboItem = ^TcxHTMLEditorComboItem;
  TcxHTMLEditorComboItem = record
    Caption: string;
    Command: string;
  end;
  PcxHTMLEditorComboItems = ^TcxHTMLEditorComboItems;
  TcxHTMLEditorComboItems = array[0..MaxInt div SizeOf(TcxHTMLEditorComboItem) - 1] of TcxHTMLEditorComboItem;

  TcxHTMLEditorBar = class(TCoolBar, IInterface, IcxHTMLEditorBar)
  private
    FColorPopup: TPopupMenu;
    FColorDialog: TColorDialog;
    FFormatToolBar: TToolBar;
    FTableToolBar: TToolBar;
    FFramesToolBar: TToolBar;
    FImageList: TImageList;
    FButtonList: TList;
    FComboList: TList;
    FontNameComboItems: array of TcxHTMLEditorComboItem;
    FCommandTarget: IcxOleCommandTarget;
    FUIDisabled: Boolean;
    FDisableLocked: Boolean;
    procedure InitCombo(ACombo: TCustomCombo; const AItems: array of TcxHTMLEditorComboItem);
    procedure InitFontNameCombo(ASender: TObject);
    procedure InitFontSizeCombo(ASender: TObject);
    procedure InitFormatCombo(ASender: TObject);
    procedure AddStdColor(const S: string);
    procedure AddWebColor(const S: string);
    procedure AddColorItem(AParent: TMenuItem; Color: Integer);
    procedure PopulateColorPopup;
    procedure Lock(ASender: TObject);
    procedure UnLock(ASender: TObject);
    procedure MeasureColorPopupItem(Sender: TObject; ACanvas: TCanvas;
      var Width, Height: Integer);
  protected
    procedure AddButton(AToolBar: TToolBar; AAction: TcxHTMLEditorBarAction);
    procedure AddCombo(AToolBar: TToolBar; AAction: TcxHTMLEditorBarAction);
    procedure AddDevider(AToolBar: TToolBar);
    procedure AddColorDropDown(AToolBar: TToolBar; AAction: TcxHTMLEditorBarAction);
    procedure AddDropDown(AToolBar: TToolBar; AAction: TcxHTMLEditorBarAction);
    procedure AddSpacer(AToolBar: TToolBar);
    function AddToolBar(const AName: string): TToolBar;
    procedure ComboBoxChange(ASender: TObject);
    procedure ToolButtonClick(ASender: TObject);
    procedure DropDownClick(ASender: TObject);
    procedure ColorPopupClick(ASender: TObject);
    procedure CustomColorClick(ASender: TObject);
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IcxHTMLEditor }
    procedure SetCommandTarget(const ACommandTarget: IcxOleCommandTarget);
    procedure DisableUI(const ADisabled: Boolean);
    procedure UpdateActionControls;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateActionControls;
    property CommandTarget: IcxOleCommandTarget read FCommandTarget write SetCommandTarget;
    property UIDisabled: Boolean read FUIDisabled write DisableUI;
  end;

implementation

{$R *.res}

uses
  Forms, Messages, Variants, ToolWin, Types,
  cxWebHTMLConsts, cxWebTypes, cxWebGraphics, cxWebDsgnStrs;

{$WRITEABLECONST ON}
const
  FormatBarActions: array[0..31] of TcxHTMLEditorBarAction = (
    (Name: 'Format'; ActType: eatCombo; Hint: scxBarButtonHintFormat; Command: IDM_BLOCKFMT),
    (ActType: eatSpacer),
    (Name: 'FontName'; ActType: eatCombo; Hint: scxBarButtonHintFontName; Command: IDM_FONTNAME),
    (ActType: eatSpacer),
    (Name: 'FontSize'; ActType: eatCombo; Hint: scxBarButtonHintFontSize; Command: IDM_FONTSIZE),
    (ActType: eatDevider),
    (Name: 'Bold'; ActType: eatCheck; Hint: scxBarButtonHintBold; ImgIndex: 0; Command: IDM_BOLD),
    (Name: 'Italic'; ActType: eatCheck; Hint: scxBarButtonHintItalic; ImgIndex: 1; Command: IDM_ITALIC),
    (Name: 'Underline'; ActType: eatCheck; Hint: scxBarButtonHintUnderline; ImgIndex: 2; Command: IDM_UNDERLINE),
    (Name: 'Subscript'; ActType: eatCheck; Hint: scxBarButtonHintSubscript; ImgIndex: 8; Command: IDM_SUBSCRIPT),
    (Name: 'Superscript'; ActType: eatCheck; Hint: scxBarButtonHintSuperscript; ImgIndex: 9; Command: IDM_SUPERSCRIPT),
    (ActType: eatDevider),
    (Name: 'JustifyLeft'; ActType: eatCheck; Hint: scxBarButtonHintAlignLeft; ImgIndex: 3; Command: IDM_JUSTIFYLEFT),
    (Name: 'JustifyCenter'; ActType: eatCheck; Hint: scxBarButtonHintAlignCenter; ImgIndex: 4; Command: IDM_JUSTIFYCENTER),
    (Name: 'JustifyRight'; ActType: eatCheck; Hint: scxBarButtonHintAlignRight; ImgIndex: 5; Command: IDM_JUSTIFYRIGHT),
    (Name: 'JustifyFull'; ActType: eatCheck; Hint: scxBarButtonHintJustify; ImgIndex: 6; Command: IDM_JUSTIFYFULL),
    (Name: 'JustifyNone'; ActType: eatCheck; Hint: scxBarButtonHintAlignNone; ImgIndex: 7; Command: IDM_JUSTIFYNONE),
    (ActType: eatDevider),
    (Name: 'ForeColor'; ActType: eatColor; Hint: scxBarButtonHintForeColor; ImgIndex: 10; Command: IDM_FORECOLOR),
    (Name: 'BackgroundColor'; ActType: eatColor; Hint: scxBarButtonHintBGColor; ImgIndex: 11; Command: IDM_BACKCOLOR),
    (ActType: eatDevider),
    (Name: 'Numbering'; ActType: eatCheck; Hint: scxBarButtonHintNumbering; ImgIndex: 12; Command: IDM_ORDERLIST),
    (Name: 'Bullets'; ActType: eatCheck; Hint: scxBarButtonHintBullets; ImgIndex: 13; Command: IDM_UNORDERLIST),
    (Name: 'Outdent'; ActType: eatButton; Hint: scxBarButtonHintOutdent; ImgIndex: 14; Command: IDM_OUTDENT),
    (Name: 'Indent'; ActType: eatButton; Hint: scxBarButtonHintIndent; ImgIndex: 15; Command: IDM_INDENT),
    (ActType: eatDevider),
    (Name: 'Link'; ActType: eatButton; Hint: scxBarButtonHintLink; ImgIndex: 16; Command: IDM_HYPERLINK),
    (Name: 'Unlink'; ActType: eatButton; Hint: scxBarButtonHintUnlink; ImgIndex: 17; Command: IDM_UNLINK),
    (ActType: eatDevider),
    (Name: 'Undo'; ActType: eatDropDown; Hint: ''; ImgIndex: 42; Command: IDM_UNDO),
    (Name: 'Dedo'; ActType: eatDropDown; Hint: ''; ImgIndex: 43; Command: IDM_REDO),
    (Name: 'RemoveFmt'; ActType: eatButton; Hint: scxBarButtonHintRemoveFmt; ImgIndex: 41; Command: IDM_REMOVEFORMAT));

  TableBarActions: array[0..14] of TcxHTMLEditorBarAction = (
    (Name: 'InsertTable'; ActType: eatButton; Hint: scxBarButtonHintInsTable; ImgIndex: 29; Command: IDM_TABLEINSERT),
    (Name: 'DeleteTable'; ActType: eatButton; Hint: scxBarButtonHintDelTable; ImgIndex: 30; Command: IDM_TABLEDELETE),
    (ActType: eatDevider),
    (Name: 'InsertRowAbove'; ActType: eatButton; Hint: scxBarButtonHintInsRowA; ImgIndex: 18; Command: IDM_ROWINSERT),
    (Name: 'InsertRowBelow'; ActType: eatButton; Hint: scxBarButtonHintInsRowB; ImgIndex: 25; Command: IDM_ROWINSERTBELOW),
    (Name: 'InsertColLeft'; ActType: eatButton; Hint: scxBarButtonHintInsColL; ImgIndex: 26; Command: IDM_COLUMNINSERT),
    (Name: 'InsertColRight'; ActType: eatButton; Hint: scxBarButtonHintInsColR; ImgIndex: 19; Command: IDM_COLUMNINSERTRIGHT),
    (Name: 'InsertCell'; ActType: eatButton; Hint: scxBarButtonHintInsCell; ImgIndex: 20; Command: IDM_CELLINSERT),
    (ActType: eatDevider),
    (Name: 'DeleteRow'; ActType: eatButton; Hint: scxBarButtonHintDelRow; ImgIndex: 21; Command: IDM_ROWDELETE),
    (Name: 'DeleteCol'; ActType: eatButton; Hint: scxBarButtonHintDelCol; ImgIndex: 22; Command: IDM_COLUMNDELETE),
    (Name: 'DeleteCells'; ActType: eatButton; Hint: scxBarButtonHintDelCells; ImgIndex: 23; Command: IDM_CELLDELETE),
    (ActType: eatDevider),
    (Name: 'SplitCell'; ActType: eatButton; Hint: scxBarButtonHintSplitCell; ImgIndex: 27; Command: IDM_CELLSPLIT),
    (Name: 'MergeCells'; ActType: eatButton; Hint: scxBarButtonHintMergeCells; ImgIndex: 28; Command: IDM_CELLMERGE)
{// TODO: implement
    (ActType: eatDevider),
    (Name: 'SelectTable'; ActType: eatButton; Hint: scxBarButtonHintSelTable; ImgIndex: 31; Command: IDM_TABLESELECT),
    (Name: 'SelectCol'; ActType: eatButton; Hint: scxBarButtonHintSelCol; ImgIndex: 32; Command: IDM_COLUMNSELECT),
    (Name: 'SelectRow'; ActType: eatButton; Hint: scxBarButtonHintSelRow; ImgIndex: 33; Command: IDM_ROWSELECT),
    (Name: 'SelectCell'; ActType: eatButton; Hint: scxBarButtonHintSelCell; ImgIndex: 34; Command: IDM_CELLSELECT)} );

    FramesBarActions: array[0..5] of TcxHTMLEditorBarAction = (
    (Name: 'NewWholeFrame'; ActType: eatButton; Hint: scxBarButtonHintNewWholeFrame; ImgIndex: 40; Command: IDM_FRAMEINSERT),
    (Name: 'NewLeftFrame'; ActType: eatButton; Hint: scxBarButtonHintNewLFrame; ImgIndex: 35; Command: IDM_FRAMEINSLEFT),
    (Name: 'NewRightFrame'; ActType: eatButton; Hint: scxBarButtonHintNewRFrame; ImgIndex: 36; Command: IDM_FRAMEINSRIGHT),
    (Name: 'NewTopFrame'; ActType: eatButton; Hint: scxBarButtonHintNewTFrame; ImgIndex: 37; Command: IDM_FRAMEINSTOP),
    (Name: 'NewBottomFrame'; ActType: eatButton; Hint: scxBarButtonHintNewBFrame; ImgIndex: 38; Command: IDM_FRAMEINSBOTTOM),
    (Name: 'DeleteFrame'; ActType: eatButton; Hint: scxBarButtonHintDelFrame; ImgIndex: 39; Command: IDM_FRAMEDELETE) );
{$WRITEABLECONST OFF}

   FormatComboItems: array[0..16] of TcxHTMLEditorComboItem = (
    (Caption: scxBarFormatComboNone; Command: ''),
    (Caption: scxBarFormatComboNormal; Command: 'normal'),
    (Caption: scxBarFormatComboFormat; Command: 'formatted'),
    (Caption: scxBarFormatComboAdress; Command: 'address'),
    (Caption: scxBarFormatComboH1; Command: 'heading 1'),
    (Caption: scxBarFormatComboH2; Command: 'heading 2'),
    (Caption: scxBarFormatComboH3; Command: 'heading 3'),
    (Caption: scxBarFormatComboH4; Command: 'heading 4'),
    (Caption: scxBarFormatComboH5; Command: 'heading 5'),
    (Caption: scxBarFormatComboH6; Command: 'heading 6'),
    (Caption: scxBarFormatComboNumList; Command: 'numbered list'),
    (Caption: scxBarFormatComboBulList; Command: 'bulleted list'),
    (Caption: scxBarFormatComboDirList; Command: 'directory list'),
    (Caption: scxBarFormatComboMenuList; Command: 'menu list'),
    (Caption: scxBarFormatComboDefTerm; Command: 'definition term'),
    (Caption: scxBarFormatComboDef; Command: 'definition'),
    (Caption: scxBarFormatComboPara; Command: 'paragraph'));

   FontSizeComboItems: array[0..7] of TcxHTMLEditorComboItem = (
    (Caption: scxBarFontSizeComboNormal; Command: ''),
    (Caption: '1 ( 8 pt)'; Command: '1'),
    (Caption: '2 (10 pt)'; Command: '2'),
    (Caption: '3 (12 pt)'; Command: '3'),
    (Caption: '4 (14 pt)'; Command: '4'),
    (Caption: '5 (18 pt)'; Command: '5'),
    (Caption: '6 (24 pt)'; Command: '6'),
    (Caption: '7 (36 pt)'; Command: '7'));

type
  TComponentAccess = class(TComponent);

  TcxHTMLEditorCombo = class(TCustomComboBoxEx)
  private
    FCmdId: Integer;
    FItemCount: Integer;
    FItemsInfo: PcxHTMLEditorComboItems;
  public
    function GetItemCommand: string;
    procedure SetValue(const AValue: string);
    property CmdId: Integer read FCmdId write FCmdId;
    property ItemCount: Integer read FItemCount write FItemCount;
    property ItemsInfo: PcxHTMLEditorComboItems read FItemsInfo write FItemsInfo;
  end;

  TcxHTMLEditorColorButton = class(TToolButton)
  private
    FColor: TcxWebColor;
    procedure SetColor(const Value: TcxWebColor);
  protected
    procedure ChangeBitmap(const Value: TColor);
  public
    function CheckMenuDropdown: Boolean; override;
    property Color: TcxWebColor read FColor write SetColor;
  end;

  TcxHTMLEditorUndoRedoButton = class(TToolButton)
  public
    constructor Create(AOwner: TComponent); override;
    function CheckMenuDropdown: Boolean; override;
  end;

  TcxPopupMenuHintFactory = class(TObject)
  private
    FDefaultPopupWndProc: Pointer;
    FPopupHintWindow: THintWindow;
    FRefCount: Integer;
  protected
    procedure PopupWndProc(var Message: TMessage);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddRef;
    procedure Release;
    property RefCount: Integer read FRefCount;
  end;

  TcxPopupMenu = class(TPopupMenu)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  cxPopupMenuHintFactory: TcxPopupMenuHintFactory = nil;

{ TcxHTMLEditorCombo }

function TcxHTMLEditorCombo.GetItemCommand: string;
begin
  if ItemsInfo <> nil then
    Result := ItemsInfo^[ItemIndex].Command
  else
    Result := '';
end;

procedure TcxHTMLEditorCombo.SetValue(const AValue: string);
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
    if SameText(AValue, ItemsInfo^[I].Command) then
    begin
      ItemIndex := I;
      break;
    end;
end;

{ TcxHTMLEditorColorButton }

type
  TCustomImageListAccess = class(TCustomImageList);

function cxWebColorToWebStringEx(AColor: TcxWebColor; AsHex: Boolean): string;
begin
  if AsHex or not cxWebColorToIdent(AColor, Result) then
    with TcxWebColorTriple(AColor) do
      Result := Format('#%.2x%.2x%.2x', [Red, Green, Blue]);
  if Pos('clWeb', Result) = 1 then
    Result := Copy(Result, 6, Length(Result) - 5);
end;

procedure TcxHTMLEditorColorButton.ChangeBitmap(const Value: TColor);
var
  Image, Mask: TBitmap;
  R: TRect;
begin
  Image := TBitmap.Create;
  Mask := TBitmap.Create;
  with R do
  begin
    Left := 1;
    Top := 12;
    Right := 15;
    Bottom := 16;
  end;
  try
    Image.Width := FToolBar.Images.Width;
    Image.Height := FToolBar.Images.Height;
    Mask.Width := Image.Width;
    Mask.Height := Image.Height;
    TCustomImageListAccess(FToolBar.Images).GetImages(ImageIndex, Image, Mask);
    Image.Canvas.Brush.Style := bsSolid;
    Image.Canvas.Brush.Color := Value;
    Image.Canvas.FillRect(R);
    FToolBar.Images.Replace(ImageIndex, Image, Mask);
  finally
    Image.Free;
    Mask.Free;
  end;
end;

function TcxHTMLEditorColorButton.CheckMenuDropdown: Boolean;
begin
  if DropdownMenu <> nil then
    DropdownMenu.Tag := Integer(Self);
  Result := inherited CheckMenuDropdown;
end;

procedure TcxHTMLEditorColorButton.SetColor(const Value: TcxWebColor);

  function GetHint: string;
  var
    BPos: Integer;
  begin
    BPos := Pos('(', Hint) - 2;
    Result := Format('%s (%s)', [Copy(Hint, 1, BPos),
      cxWebColorToWebStringEx(Value, False)]);
  end;

begin
  if FColor = Value then Exit;
  FColor := Value;
  ChangeBitmap(Value);
  Hint := GetHint;
end;

{ TcxHTMLEditorUndoRedoButton }

function TcxHTMLEditorUndoRedoButton.CheckMenuDropdown: Boolean;
begin
  Result := inherited CheckMenuDropdown;
end;

constructor TcxHTMLEditorUndoRedoButton.Create(AOwner: TComponent);
begin
  inherited;
end;

{ TcxPopupMenuHintFactory }

constructor TcxPopupMenuHintFactory.Create;
begin
  inherited;
  FRefCount := 0;
  FDefaultPopupWndProc := Pointer(GetWindowLong(PopupList.Window, GWL_WNDPROC));
  SetWindowLong(PopupList.Window, GWL_WNDPROC, LongInt(Classes.MakeObjectInstance(PopupWndProc)));
end;

destructor TcxPopupMenuHintFactory.Destroy;
begin
  SetWindowLong(PopupList.Window, GWL_WNDPROC, Longint(FDefaultPopupWndProc));
  FreeAndNil(FPopupHintWindow);
  inherited;
end;

procedure TcxPopupMenuHintFactory.AddRef;
begin
  Inc(FRefCount);
end;

procedure TcxPopupMenuHintFactory.Release;
begin
  Dec(FRefCount);
end;

procedure TcxPopupMenuHintFactory.PopupWndProc(var Message: TMessage);

  procedure ValidateHintWindow(HintClass: THintWindowClass);
  begin
    if (FPopupHintWindow = nil) or (FPopupHintWindow.ClassType <> HintClass) then
    begin
      FPopupHintWindow.Free;
      FPopupHintWindow := HintClass.Create(nil);
    end;
  end;

  procedure DeactivateHint;
  begin
    if FPopupHintWindow <> nil then
      FPopupHintWindow.ReleaseHandle;
  end;

  procedure ActivateHint;
  var
    MousePos: TPoint;
    HintRect: TRect;
  begin
    if Application.Hint <> '' then
    begin
      GetCursorPos(MousePos);
      ValidateHintWindow(HintWindowClass);
      FPopupHintWindow.Color := Application.HintColor;
      HintRect := FPopupHintWindow.CalcHintRect(Screen.Width, Application.Hint, nil);
      OffsetRect(HintRect, MousePos.X, MousePos.Y);
      OffsetRect(HintRect, 0, GetSystemMetrics(SM_CYCURSOR) div 2 + 1);
      FPopupHintWindow.ActivateHint(HintRect, Application.Hint);
    end
    else
      DeactivateHint;
  end;

  function FindPopupByHandle(AHandle: HMENU): TPopupMenu;
  var
    I: Integer;
    FoundMenu: TPopupMenu;
  begin
    Result := nil;
    for I := 0 to PopupList.Count - 1 do
    begin
      FoundMenu := TPopupMenu(PopupList.Items[I]);
      if FoundMenu.Handle = AHandle then
      begin
        Result := FoundMenu;
        break;
      end
      else
        if FoundMenu.FindItem(AHandle, fkHandle) <> nil then
        begin
          Result := FoundMenu;
          break;
        end;
    end;
  end;

begin
  with Message do
    Result := CallWindowProc(FDefaultPopupWndProc, PopupList.Window,
      Msg, WParam, LParam);
  if Application <> nil then
    try
      if (Message.Msg = WM_MENUSELECT) and
      (FindPopupByHandle(Message.LParam) is TcxPopupMenu) then
        ActivateHint;
      if (Message.Msg = WM_UNINITMENUPOPUP) and
      (FindPopupByHandle(Message.WParam) is TcxPopupMenu) then
        DeactivateHint;
    except
      Application.HandleException(Application);
    end;
end;

{ TcxPopupMenu }

constructor TcxPopupMenu.Create(AOwner: TComponent);
begin
  inherited;
  if cxPopupMenuHintFactory = nil then
    cxPopupMenuHintFactory := TcxPopupMenuHintFactory.Create;
  cxPopupMenuHintFactory.AddRef;
end;

destructor TcxPopupMenu.Destroy;
begin
  cxPopupMenuHintFactory.Release;
  if cxPopupMenuHintFactory.RefCount = 0 then
    FreeAndNil(cxPopupMenuHintFactory); 
  inherited;
end;

{ TcxHTMLEditorBar }

constructor TcxHTMLEditorBar.Create(AOwner: TComponent);
begin
  inherited;
  FButtonList := TList.Create;
  FComboList := TList.Create;
  FImageList := TImageList.Create(Self);
  FImageList.ResourceLoad(rtBitmap, 'CXWEBHTMLEDITORBARIMAGES', clFuchsia);
  FColorPopup := TcxPopupMenu.Create(Self);
  FColorPopup.AutoHotkeys := maManual;
  FColorPopup.MenuAnimation := [maLeftToRight, maTopToBottom];
  TComponentAccess(FColorPopup).SetDesigning(False);
  PopulateColorPopup;
  FColorDialog := TColorDialog.Create(Self);
  FColorDialog.Options := [cdFullOpen];
  AutoSize := True;
  BandMaximize := bmDblClick;
  Images := FImageList;
  ShowHint := True;
  FUIDisabled := True;
  FormatBarActions[0].Method := InitFormatCombo;
  FormatBarActions[2].Method := InitFontNameCombo;
  FormatBarActions[4].Method := InitFontSizeCombo;
end;

destructor TcxHTMLEditorBar.Destroy;
begin
  FButtonList.Free;
  FComboList.Free;
  inherited;
end;

procedure TcxHTMLEditorBar.CreateActionControls;

  procedure AddToolBarControls(AToolBar: TToolBar; AActions: array of TcxHTMLEditorBarAction);
  var
    I: Integer;
  begin
    for I := High(AActions) downto Low(AActions) do
      case AActions[I].ActType of
        eatCombo: AddCombo(AToolBar, AActions[I]);
        eatButton, eatCheck: AddButton(AToolBar, AActions[I]);
        eatColor: AddColorDropDown(AToolBar, AActions[I]);
        eatDropDown: AddDropDown(AToolBar, AActions[I]);
        eatDevider: AddDevider(AToolBar);
        eatSpacer: AddSpacer(AToolBar);
      end;
  end;
var
  TBWidth: Integer;
begin
  FFormatToolBar := AddToolBar('tbTextFormating');
  AddToolBarControls(FFormatToolBar, FormatBarActions);
  FTableToolBar := AddToolBar('tbTable');
  AddToolBarControls(FTableToolBar, TableBarActions);
  with FTableToolBar.Buttons[FTableToolBar.ButtonCount - 1] do
    TBWidth := Left + Width;
  TBWidth := TBWidth + FTableToolBar.Left * 2;
  FFramesToolBar := AddToolBar('tbFrames');
  Bands.FindBand(FTableToolBar).Width := TBWidth;
  Bands.FindBand(FFramesToolBar).Break := False;
  AddToolBarControls(FFramesToolBar, FramesBarActions);
end;

procedure TcxHTMLEditorBar.AddButton(AToolBar: TToolBar;
  AAction: TcxHTMLEditorBarAction);
var
  Button: TToolButton;
begin
  Button := TToolButton.Create(AToolBar);
  with Button do
  begin
    Name := 'tbb' + AAction.Name;
    Parent := AToolBar;
    if AAction.ActType = eatCheck then
      Style := tbsCheck
    else
      Style := tbsButton;
    Hint := AAction.Hint;
    ImageIndex := AAction.ImgIndex;
    Enabled := False;
    Tag := AAction.Command;
    OnClick := ToolButtonClick;
  end;
  FButtonList.Add(Button);
end;

procedure TcxHTMLEditorBar.AddCombo(AToolBar: TToolBar;
  AAction: TcxHTMLEditorBarAction);
var
  Combo: TcxHTMLEditorCombo;
begin
  Combo := TcxHTMLEditorCombo.Create(AToolBar);
  with Combo do
  begin
    Name := 'tbc' + AAction.Name;
    Parent := AToolBar;
    TabStop := False;
    Enabled := False;
    Hint := AAction.Hint;
    CmdId := AAction.Command;
    OnChange := ComboBoxChange;
    OnEnter := Lock;
    OnExit := UnLock;
    if Assigned(AAction.Method) then
      AAction.Method(Combo);
  end;
  TComponentAccess(Combo).SetDesigning(False);
  FComboList.Add(Combo);
end;

procedure TcxHTMLEditorBar.AddDevider(AToolBar: TToolBar);
begin
  with TToolButton.Create(AToolBar) do
  begin
    Parent := AToolBar;
    Style := tbsSeparator;
    Width := 8;
  end;
end;

procedure TcxHTMLEditorBar.PopulateColorPopup;
var
  Item: TMenuItem;
begin
  Item := TMenuItem.Create(FColorPopup);
  Item.Caption := scxBarStdColors;
  Item.Tag := 2;
  FColorPopup.Items.Add(Item);
  GetColorValues(AddStdColor);

  Item := TMenuItem.Create(FColorPopup);
  Item.Caption := scxBarWebColors;
  Item.Tag := 10;
  FColorPopup.Items.Add(Item) ;

  Item := TMenuItem.Create(FColorPopup);
  Item.Caption := scxBarSystemColors;
  Item.Tag := 4;
  FColorPopup.Items.Add(Item);
  cxGetWebColorPalette(AddWebColor);

  Item := TMenuItem.Create(FColorPopup);
  Item.Caption := scxBarCustomColor + cDialogSuffix;
  Item.OnClick := CustomColorClick;
  FColorPopup.Items.Add(Item);
end;

procedure TcxHTMLEditorBar.AddStdColor(const S: string);
begin
  if FColorPopup.Items[0].Count < StandardColorsCount then
    AddColorItem(FColorPopup.Items[0], StringToColor(S)); // standard palette
end;

procedure TcxHTMLEditorBar.AddWebColor(const S: string);
begin
  if FColorPopup.Items[1].Count < 140 then
    AddColorItem(FColorPopup.Items[1], cxStringToWebColor(S)) // web palette
  else
    AddColorItem(FColorPopup.Items[2], cxStringToWebColor(S)); // system palette
end;

procedure TcxHTMLEditorBar.AddColorItem(AParent: TMenuItem; Color: Integer);
var
  Item: TMenuItem;
  R: TRect;
begin
  Item := TMenuItem.Create(AParent);
  Item.Tag := Color;
  Item.Hint := cxWebColorToWebStringEx(Item.Tag, False);
  with R do
  begin
    Left := 0;
    Top := 0;
    Right := 16;
    Bottom := 16;
  end;
  with Item.Bitmap do
  begin
    Transparent := False;
    TransparentColor := clNone;
    Width := R.Right - R.Left;
    Height := R.Bottom - R.Top;
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clBtnShadow;
    Canvas.FrameRect(R);
    Canvas.Brush.Color := Color;
    InflateRect(R, -1, -1);
    Canvas.FillRect(R);
  end;
  Item.OnClick := ColorPopupClick;
  Item.OnMeasureItem := MeasureColorPopupItem;
  AParent.Add(Item);
  if Item.MenuIndex mod AParent.Tag = 0 then
    Item.Break := mbBreak;
end;

procedure TcxHTMLEditorBar.Lock(ASender: TObject);
begin
  FDisableLocked := True;
end;

procedure TcxHTMLEditorBar.UnLock(ASender: TObject);
begin
  FDisableLocked := False;
end;

procedure TcxHTMLEditorBar.AddColorDropDown(AToolBar: TToolBar;
  AAction: TcxHTMLEditorBarAction);
var
  Button: TToolButton;
begin
  Button := TcxHTMLEditorColorButton.Create(AToolBar);
  with Button do
  begin
    Name := 'tbb' + AAction.Name;
    Parent := AToolBar;
    Style := tbsDropDown;
    Hint := AAction.Hint + ' ('+ scxBarColorHintDef +')';
    ImageIndex := AAction.ImgIndex;
    DropdownMenu := FColorPopup;
    Enabled := False;
    Tag := AAction.Command;
    OnClick := DropDownClick;
  end;
  FButtonList.Add(Button);
end;

procedure TcxHTMLEditorBar.AddDropDown(AToolBar: TToolBar;
  AAction: TcxHTMLEditorBarAction);
var
  Button: TToolButton;
begin
  Button := TcxHTMLEditorUndoRedoButton.Create(AToolBar);
  with Button do
  begin
    Name := 'tbb' + AAction.Name;
    Parent := AToolBar;
    Style := tbsDropDown;
    Hint := AAction.Hint;
    ImageIndex := AAction.ImgIndex;
    Enabled := False;
    Tag := AAction.Command;
    OnClick := ToolButtonClick;
  end;
  FButtonList.Add(Button);
end;

procedure TcxHTMLEditorBar.AddSpacer(AToolBar: TToolBar);
begin
  with TLabel.Create(AToolBar) do
  begin
    Parent := AToolBar;
    AutoSize := False;
    Caption := '';
    Width := 4;
  end;
end;

function TcxHTMLEditorBar.AddToolBar(const AName: string): TToolBar;
begin
  Result := TToolBar.Create(Self);
  with Result do
  begin
    Parent := Self;
    Name := AName;
    Images := FImageList;
    AutoSize := True;
    BorderWidth := 1;
    EdgeInner := esNone;
    EdgeOuter := esNone;
    Flat := True;
    Height := 26;
  end;
  TComponentAccess(Result).SetDesigning(False);
end;

procedure TcxHTMLEditorBar.ComboBoxChange(ASender: TObject);
var
  VIn: OleVariant;
  Combo: TcxHTMLEditorCombo;
begin
  if FUIDisabled or (CommandTarget = nil) or
    not (ASender is TcxHTMLEditorCombo) then Exit;
  Combo := TcxHTMLEditorCombo(ASender);
  VIn := Combo.GetItemCommand;
  CommandTarget.Exec(@CGID_MSHTML, Combo.CmdId, OLECMDEXECOPT_DONTPROMPTUSER, @VIn, nil);
end;

procedure TcxHTMLEditorBar.ToolButtonClick(ASender: TObject);
begin
  if FUIDisabled or (CommandTarget = nil) then Exit;
  CommandTarget.Exec(@CGID_MSHTML, TComponent(ASender).Tag, OLECMDEXECOPT_DODEFAULT, nil, nil)
end;

procedure TcxHTMLEditorBar.DropDownClick(ASender: TObject);
var
  VIn: OleVariant;
  Color: TcxWebColor;
begin
  if FUIDisabled or (CommandTarget = nil) then Exit;
  if not (ASender is TcxHTMLEditorColorButton) then Exit;
  Color := TcxHTMLEditorColorButton(ASender).Color;
  VIn := cxWebColorToWebStringEx(Color, False);
  CommandTarget.Exec(@CGID_MSHTML, TComponent(ASender).Tag, OLECMDEXECOPT_DODEFAULT, @VIn, nil)
end;

procedure TcxHTMLEditorBar.ColorPopupClick(ASender: TObject);
var
  Item: TMenuItem;
  Menu: TComponent;
begin
  Item := TMenuItem(ASender);
  Menu := Item.Owner;
  while not (Menu is TcxPopupMenu) do
    Menu := Menu.Owner;
  if TObject(Menu.Tag) is TcxHTMLEditorColorButton then
  begin
    TcxHTMLEditorColorButton(Menu.Tag).Color := Item.Tag;
    TToolButton(Menu.Tag).Click;
  end;
  Menu.Tag := 0;
end;

procedure TcxHTMLEditorBar.CustomColorClick(ASender: TObject);
var
  Button: TcxHTMLEditorColorButton;
begin
  Button := TcxHTMLEditorColorButton(TComponent(ASender).Owner.Tag);
  if Button = nil then Exit;
  FColorDialog.Color := Button.Color;
  if FColorDialog.Execute then
  begin
    Button.Color := FColorDialog.Color;
    Button.Click;
    TComponent(ASender).Owner.Tag := 0;
  end;
end;

function TcxHTMLEditorBar._AddRef: Integer;
begin
  Result := -1;
end;

function TcxHTMLEditorBar._Release: Integer;
begin
  Result := -1;
end;

function TcxHTMLEditorBar.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;


procedure TcxHTMLEditorBar.SetCommandTarget(const ACommandTarget: IcxOleCommandTarget);
begin
  FCommandTarget := ACommandTarget;
end;

procedure TcxHTMLEditorBar.DisableUI(const ADisabled: Boolean);
begin
  FUIDisabled := ADisabled and not FDisableLocked;
end;

procedure TcxHTMLEditorBar.UpdateActionControls;
const
  BuffLen = 255;
var
  I: Integer;
  Button: TToolButton;
  Combo: TcxHTMLEditorCombo;
  Cmd: TOleCmd;
  VOut: OleVariant;
  Text: POleCmdText;
begin
  if FUIDisabled or (CommandTarget = nil) then
    for I := 0 to FButtonList.Count - 1 do
      TToolButton(FButtonList[I]).Enabled := False
  else
  begin
    // Update Buttons
    for I := 0 to FButtonList.Count - 1 do
    begin
      Button := TToolButton(FButtonList[I]);
      Cmd.cmdID := Button.Tag;
      Cmd.cmdf := 0;
      GetMem(Text, SizeOf(TOleCmdText) + BuffLen * SizeOf(WideChar));
      try
        Text^.cmdtextf := OLECMDTEXTF_STATUS;
        Text^.cwBuf := BuffLen;
        Text^.cwActual := 0;
        if CommandTarget.QueryStatus(@CGID_MSHTML, 1, @Cmd, Text) = S_OK then
        begin
          Button.Enabled := (Cmd.cmdf and OLECMDF_ENABLED) = OLECMDF_ENABLED;
          Button.Down := (Cmd.cmdf and OLECMDF_LATCHED) = OLECMDF_LATCHED;
          if Text^.cwActual > 0 then
            Button.Hint := WideCharToString(Text^.rgwz);
        end;
      finally
        FreeMem(Text);
      end;
    end;
    // Update Combos
    for I := 0 to FComboList.Count - 1 do
    begin
      Combo := TcxHTMLEditorCombo(FComboList[I]);
      Cmd.cmdID := Combo.CmdId;
      Cmd.cmdf := 0;
      if CommandTarget.QueryStatus(@CGID_MSHTML, 1, @Cmd, @Text) = S_OK then
        Combo.Enabled := (Cmd.cmdf and OLECMDF_ENABLED) = OLECMDF_ENABLED;
      VarClear(VOut);
      if (CommandTarget.Exec(@CGID_MSHTML, Cmd.cmdID, OLECMDEXECOPT_DONTPROMPTUSER, nil, @VOut) = S_OK) then
        try
          Combo.SetValue(VarToStr(VOut));
        except
        end;
    end;
  end;
end;

procedure TcxHTMLEditorBar.InitCombo(ACombo: TCustomCombo;
    const AItems: array of TcxHTMLEditorComboItem);
var
  I: Integer;
begin
  for I := Low(AItems) to High(AItems) do
    ACombo.Items.Add(AItems[I].Caption);
  TcxHTMLEditorCombo(ACombo).ItemsInfo := @AItems;
  TcxHTMLEditorCombo(ACombo).ItemCount := High(AItems) - Low(AItems) + 1;
end;

procedure TcxHTMLEditorBar.InitFontNameCombo(ASender: TObject);
var
  I: Integer;
begin
  if not (ASender is TcxHTMLEditorCombo) then Exit;
  SetLength(FontNameComboItems, Screen.Fonts.Count + 1);
  FontNameComboItems[0].Caption := '(' + scxBarFontComboDef + ')';
  FontNameComboItems[0].Command := '';
  for I := 0 to Screen.Fonts.Count - 1do
  begin
    FontNameComboItems[I + 1].Caption := Screen.Fonts.Strings[I];
    FontNameComboItems[I + 1].Command := Screen.Fonts.Strings[I];
  end;
  InitCombo(TcxHTMLEditorCombo(ASender), FontNameComboItems);
  with TcxHTMLEditorCombo(ASender) do
  begin
    ItemIndex := 0;
    Width := 140;
    Style := csExDropDownList;
  end;
end;

procedure TcxHTMLEditorBar.InitFontSizeCombo(ASender: TObject);
begin
  if not (ASender is TcxHTMLEditorCombo) then Exit;
  InitCombo(TcxHTMLEditorCombo(ASender), FontSizeComboItems);
  with TcxHTMLEditorCombo(ASender) do
  begin
    Style := csExDropDownList;
    ItemIndex := 0;
    Width := 65;
  end;
end;

procedure TcxHTMLEditorBar.InitFormatCombo(ASender: TObject);
begin
  if not (ASender is TCustomCombo) then Exit;
  InitCombo(TcxHTMLEditorCombo(ASender), FormatComboItems);
  with TComboBoxEx(ASender) do
  begin
    Style := csExDropDownList;
    ItemIndex := 0;
    Width := 100;
  end;
end;

procedure TcxHTMLEditorBar.MeasureColorPopupItem(Sender: TObject;
  ACanvas: TCanvas; var Width, Height: Integer);
var
  NonClientMetrics: TNonClientMetrics;
begin
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
  begin
    Width := Height + NonClientMetrics.lfMenuFont.lfHeight;
    Height := NonClientMetrics.iMenuHeight + 2;
  end;
end;

end.


