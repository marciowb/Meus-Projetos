{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_StdCtrls;

interface

uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Menus,
  Graphics,
  CommCtrl,
  StdCtrls,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatStdCtrlsLibrary = class(TatScripterLibrary)
    procedure __TCustomGroupBoxCreate(AMachine: TatVirtualMachine);
    procedure __TCustomLabelCreate(AMachine: TatVirtualMachine);
    procedure __TCustomEditCreate(AMachine: TatVirtualMachine);
    procedure __TCustomEditClear(AMachine: TatVirtualMachine);
    procedure __TCustomEditClearSelection(AMachine: TatVirtualMachine);
    procedure __TCustomEditCopyToClipboard(AMachine: TatVirtualMachine);
    procedure __TCustomEditCutToClipboard(AMachine: TatVirtualMachine);
    procedure __TCustomEditDefaultHandler(AMachine: TatVirtualMachine);
    procedure __TCustomEditPasteFromClipboard(AMachine: TatVirtualMachine);
    procedure __TCustomEditUndo(AMachine: TatVirtualMachine);
    procedure __TCustomEditClearUndo(AMachine: TatVirtualMachine);
    procedure __TCustomEditGetSelTextBuf(AMachine: TatVirtualMachine);
    procedure __TCustomEditSelectAll(AMachine: TatVirtualMachine);
    procedure __TCustomEditSetSelTextBuf(AMachine: TatVirtualMachine);
    procedure __GetTCustomEditCanUndo(AMachine: TatVirtualMachine);
    procedure __GetTCustomEditModified(AMachine: TatVirtualMachine);
    procedure __SetTCustomEditModified(AMachine: TatVirtualMachine);
    procedure __GetTCustomEditReadOnly(AMachine: TatVirtualMachine);
    procedure __SetTCustomEditReadOnly(AMachine: TatVirtualMachine);
    procedure __GetTCustomEditSelLength(AMachine: TatVirtualMachine);
    procedure __SetTCustomEditSelLength(AMachine: TatVirtualMachine);
    procedure __GetTCustomEditSelStart(AMachine: TatVirtualMachine);
    procedure __SetTCustomEditSelStart(AMachine: TatVirtualMachine);
    procedure __GetTCustomEditSelText(AMachine: TatVirtualMachine);
    procedure __SetTCustomEditSelText(AMachine: TatVirtualMachine);
    procedure __TCustomMemoCreate(AMachine: TatVirtualMachine);
    procedure __TCustomMemoDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomMemoGetControlsAlignment(AMachine: TatVirtualMachine);
    procedure __GetTCustomMemoCaretPos(AMachine: TatVirtualMachine);
    procedure __SetTCustomMemoCaretPos(AMachine: TatVirtualMachine);
    procedure __GetTCustomMemoLines(AMachine: TatVirtualMachine);
    procedure __SetTCustomMemoLines(AMachine: TatVirtualMachine);
    procedure __TCustomComboBoxStringsClear(AMachine: TatVirtualMachine);
    procedure __TCustomComboBoxStringsDelete(AMachine: TatVirtualMachine);
    procedure __TCustomComboBoxStringsIndexOf(AMachine: TatVirtualMachine);
    procedure __TCustomComboCreate(AMachine: TatVirtualMachine);
    procedure __TCustomComboDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomComboAddItem(AMachine: TatVirtualMachine);
    procedure __TCustomComboClear(AMachine: TatVirtualMachine);
    procedure __TCustomComboClearSelection(AMachine: TatVirtualMachine);
    procedure __TCustomComboCopySelection(AMachine: TatVirtualMachine);
    procedure __TCustomComboDeleteSelected(AMachine: TatVirtualMachine);
    procedure __TCustomComboFocused(AMachine: TatVirtualMachine);
    procedure __TCustomComboSelectAll(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboCanvas(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboDroppedDown(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboDroppedDown(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboItems(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboItems(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboSelLength(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboSelLength(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboSelStart(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboSelStart(AMachine: TatVirtualMachine);
    procedure __TCustomComboBoxCreate(AMachine: TatVirtualMachine);
    procedure __TCustomComboBoxDestroy(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxAutoCompleteDelay(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxAutoCompleteDelay(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxAutoComplete(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxAutoComplete(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxAutoCloseUp(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxAutoCloseUp(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxAutoDropDown(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxAutoDropDown(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxCharCase(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxCharCase(AMachine: TatVirtualMachine);
    procedure __GetTCustomComboBoxSelText(AMachine: TatVirtualMachine);
    procedure __SetTCustomComboBoxSelText(AMachine: TatVirtualMachine);
    procedure __TButtonControlCreate(AMachine: TatVirtualMachine);
    procedure __TButtonCreate(AMachine: TatVirtualMachine);
    procedure __TButtonClick(AMachine: TatVirtualMachine);
    procedure __TButtonUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __TCustomCheckBoxCreate(AMachine: TatVirtualMachine);
    procedure __TCustomCheckBoxGetControlsAlignment(AMachine: TatVirtualMachine);
    procedure __TRadioButtonCreate(AMachine: TatVirtualMachine);
    procedure __TRadioButtonGetControlsAlignment(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxCreate(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxAddItem(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxClear(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxClearSelection(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxCopySelection(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxDeleteSelected(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxItemAtPos(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxItemRect(AMachine: TatVirtualMachine);
    procedure __TCustomListBoxSelectAll(AMachine: TatVirtualMachine);
    procedure __GetTCustomListBoxAutoCompleteDelay(AMachine: TatVirtualMachine);
    procedure __SetTCustomListBoxAutoCompleteDelay(AMachine: TatVirtualMachine);
    procedure __GetTCustomListBoxAutoComplete(AMachine: TatVirtualMachine);
    procedure __SetTCustomListBoxAutoComplete(AMachine: TatVirtualMachine);
    procedure __GetTCustomListBoxCanvas(AMachine: TatVirtualMachine);
    procedure __GetTCustomListBoxCount(AMachine: TatVirtualMachine);
    procedure __SetTCustomListBoxCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomListBoxItems(AMachine: TatVirtualMachine);
    procedure __SetTCustomListBoxItems(AMachine: TatVirtualMachine);
    procedure __GetTCustomListBoxSelected(AMachine: TatVirtualMachine);
    procedure __SetTCustomListBoxSelected(AMachine: TatVirtualMachine);
    procedure __GetTCustomListBoxScrollWidth(AMachine: TatVirtualMachine);
    procedure __SetTCustomListBoxScrollWidth(AMachine: TatVirtualMachine);
    procedure __GetTCustomListBoxTopIndex(AMachine: TatVirtualMachine);
    procedure __SetTCustomListBoxTopIndex(AMachine: TatVirtualMachine);
    procedure __TScrollBarCreate(AMachine: TatVirtualMachine);
    procedure __TScrollBarSetParams(AMachine: TatVirtualMachine);
    procedure __TCustomStaticTextCreate(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomGroupBoxClass = class of TCustomGroupBox;
  TGroupBoxClass = class of TGroupBox;
  TCustomLabelClass = class of TCustomLabel;
  TLabelClass = class of TLabel;
  TCustomEditClass = class of TCustomEdit;
  TEditClass = class of TEdit;
  TCustomMemoClass = class of TCustomMemo;
  TMemoClass = class of TMemo;
  TCustomComboBoxStringsClass = class of TCustomComboBoxStrings;
  TCustomComboClass = class of TCustomCombo;
  TCustomComboBoxClass = class of TCustomComboBox;
  TComboBoxClass = class of TComboBox;
  TButtonActionLinkClass = class of TButtonActionLink;
  TButtonControlClass = class of TButtonControl;
  TButtonClass = class of TButton;
  TCustomCheckBoxClass = class of TCustomCheckBox;
  TCheckBoxClass = class of TCheckBox;
  TRadioButtonClass = class of TRadioButton;
  TCustomListBoxClass = class of TCustomListBox;
  TListBoxClass = class of TListBox;
  TScrollBarClass = class of TScrollBar;
  TCustomStaticTextClass = class of TCustomStaticText;
  TStaticTextClass = class of TStaticText;

  TatStdCtrlsDispatcher = class(TatEventDispatcher)
  private
    procedure __TMeasureItemEvent( Control: TWinControl;  Index: Integer; var Height: Integer);
    procedure __TLBGetDataEvent( Control: TWinControl;  Index: Integer; var Data: string);
    procedure __TLBGetDataObjectEvent( Control: TWinControl;  Index: Integer; var DataObject: TObject);
    function __TLBFindDataEvent( Control: TWinControl;  FindString: string): Integer;
    procedure __TScrollEvent( Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
  end;

  TSelectionWrapper = class(TatRecordWrapper)
  private
    FStartPos: Integer;
    FEndPos: Integer;
  public
    constructor Create(ARecord: TSelection);
    function ObjToRec: TSelection;
  published
    property StartPos: Integer read FStartPos write FStartPos;
    property EndPos: Integer read FEndPos write FEndPos;
  end;
  

implementation

constructor TSelectionWrapper.Create(ARecord: TSelection);
begin
  inherited Create;
  FStartPos := ARecord.StartPos;
  FEndPos := ARecord.EndPos;
end;

function TSelectionWrapper.ObjToRec: TSelection;
begin
  result.StartPos := FStartPos;
  result.EndPos := FEndPos;
end;



procedure TatStdCtrlsLibrary.__TCustomGroupBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomGroupBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomLabelCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomLabelClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).Clear;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditClearSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).ClearSelection;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditCopyToClipboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).CopyToClipboard;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditCutToClipboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).CutToClipboard;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TCustomEdit(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditPasteFromClipboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).PasteFromClipboard;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditUndo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).Undo;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditClearUndo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).ClearUndo;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditGetSelTextBuf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomEdit(CurrentObject).GetSelTextBuf(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditSelectAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).SelectAll;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomEditSetSelTextBuf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).SetSelTextBuf(PChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomEditCanUndo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomEdit(CurrentObject).CanUndo);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomEditModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomEdit(CurrentObject).Modified);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomEditModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).Modified:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomEditReadOnly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomEdit(CurrentObject).ReadOnly);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomEditReadOnly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).ReadOnly:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomEditSelLength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomEdit(CurrentObject).SelLength));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomEditSelLength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).SelLength:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomEditSelStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomEdit(CurrentObject).SelStart));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomEditSelStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).SelStart:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomEditSelText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomEdit(CurrentObject).SelText);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomEditSelText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomEdit(CurrentObject).SelText:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomMemoCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomMemoClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomMemoDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMemo(CurrentObject).Destroy;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomMemoGetControlsAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomMemo(CurrentObject).GetControlsAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomMemoCaretPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TCustomMemo(CurrentObject).CaretPos)));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomMemoCaretPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMemo(CurrentObject).CaretPos:=TPointWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomMemoLines(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomMemo(CurrentObject).Lines));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomMemoLines(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMemo(CurrentObject).Lines:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboBoxStringsClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBoxStrings(CurrentObject).Clear;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboBoxStringsDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBoxStrings(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboBoxStringsIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomComboBoxStrings(CurrentObject).IndexOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomComboClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).Destroy;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboAddItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).AddItem(GetInputArg(0),TObject(Integer(GetInputArg(1))));
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).Clear;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboClearSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).ClearSelection;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboCopySelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).CopySelection(TCustomListControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboDeleteSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).DeleteSelected;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboFocused(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomCombo(CurrentObject).Focused;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboSelectAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).SelectAll;
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomCombo(CurrentObject).Canvas));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboDroppedDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomCombo(CurrentObject).DroppedDown);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboDroppedDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).DroppedDown:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomCombo(CurrentObject).Items));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).Items:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboSelLength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomCombo(CurrentObject).SelLength));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboSelLength(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).SelLength:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboSelStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomCombo(CurrentObject).SelStart));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboSelStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomCombo(CurrentObject).SelStart:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomComboBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomComboBoxDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBox(CurrentObject).Destroy;
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboBoxAutoCompleteDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomComboBox(CurrentObject).AutoCompleteDelay));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboBoxAutoCompleteDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBox(CurrentObject).AutoCompleteDelay:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboBoxAutoComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomComboBox(CurrentObject).AutoComplete);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboBoxAutoComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBox(CurrentObject).AutoComplete:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboBoxAutoCloseUp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomComboBox(CurrentObject).AutoCloseUp);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboBoxAutoCloseUp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBox(CurrentObject).AutoCloseUp:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboBoxAutoDropDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomComboBox(CurrentObject).AutoDropDown);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboBoxAutoDropDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBox(CurrentObject).AutoDropDown:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboBoxCharCase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomComboBox(CurrentObject).CharCase);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboBoxCharCase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBox(CurrentObject).CharCase:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomComboBoxSelText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomComboBox(CurrentObject).SelText);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomComboBoxSelText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomComboBox(CurrentObject).SelText:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__TButtonControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TButtonCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButton(CurrentObject).Click;
  end;
end;

procedure TatStdCtrlsLibrary.__TButtonUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TButton(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomCheckBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomCheckBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomCheckBoxGetControlsAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomCheckBox(CurrentObject).GetControlsAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TRadioButtonCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRadioButtonClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TRadioButtonGetControlsAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRadioButton(CurrentObject).GetControlsAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).Destroy;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxAddItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).AddItem(GetInputArg(0),TObject(Integer(GetInputArg(1))));
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).Clear;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxClearSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).ClearSelection;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxCopySelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).CopySelection(TCustomListControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxDeleteSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).DeleteSelected;
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxItemAtPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListBox(CurrentObject).ItemAtPos(TPointWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxItemRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TCustomListBox(CurrentObject).ItemRect(VarToInteger(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomListBoxSelectAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).SelectAll;
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomListBoxAutoCompleteDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListBox(CurrentObject).AutoCompleteDelay));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomListBoxAutoCompleteDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).AutoCompleteDelay:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomListBoxAutoComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListBox(CurrentObject).AutoComplete);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomListBoxAutoComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).AutoComplete:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomListBoxCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListBox(CurrentObject).Canvas));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomListBoxCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListBox(CurrentObject).Count));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomListBoxCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).Count:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomListBoxItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListBox(CurrentObject).Items));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomListBoxItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).Items:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomListBoxSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListBox(CurrentObject).Selected[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomListBoxSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).Selected[VarToInteger(GetArrayIndex(0))]:=GetInputArg(0);
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomListBoxScrollWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListBox(CurrentObject).ScrollWidth));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomListBoxScrollWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).ScrollWidth:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__GetTCustomListBoxTopIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListBox(CurrentObject).TopIndex));
  end;
end;

procedure TatStdCtrlsLibrary.__SetTCustomListBoxTopIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListBox(CurrentObject).TopIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatStdCtrlsLibrary.__TScrollBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScrollBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsLibrary.__TScrollBarSetParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScrollBar(CurrentObject).SetParams(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatStdCtrlsLibrary.__TCustomStaticTextCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomStaticTextClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatStdCtrlsDispatcher.__TMeasureItemEvent( Control: TWinControl;  Index: Integer; var Height: Integer);
var
  HeightTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMeasureItemEvent(BeforeCall)(Control,Index,Height);
    HeightTemp := Integer(Height);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Control,Index,HeightTemp]);
    Height := VarToInteger(HeightTemp);
    if AssignedMethod(AfterCall) then
      TMeasureItemEvent(AfterCall)(Control,Index,Height);
  end;
end;

procedure TatStdCtrlsDispatcher.__TLBGetDataEvent( Control: TWinControl;  Index: Integer; var Data: string);
var
  DataTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLBGetDataEvent(BeforeCall)(Control,Index,Data);
    DataTemp := Data;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Control,Index,DataTemp]);
    Data := DataTemp;
    if AssignedMethod(AfterCall) then
      TLBGetDataEvent(AfterCall)(Control,Index,Data);
  end;
end;

procedure TatStdCtrlsDispatcher.__TLBGetDataObjectEvent( Control: TWinControl;  Index: Integer; var DataObject: TObject);
var
  DataObjectTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLBGetDataObjectEvent(BeforeCall)(Control,Index,DataObject);
    DataObjectTemp := Integer(DataObject);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Control,Index,DataObjectTemp]);
    DataObject := TObject(Integer(DataObjectTemp));
    if AssignedMethod(AfterCall) then
      TLBGetDataObjectEvent(AfterCall)(Control,Index,DataObject);
  end;
end;

function TatStdCtrlsDispatcher.__TLBFindDataEvent( Control: TWinControl;  FindString: string): Integer;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLBFindDataEvent(BeforeCall)(Control,FindString);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Control,FindString]);
    if AssignedMethod(AfterCall) then
      TLBFindDataEvent(AfterCall)(Control,FindString);
  end;
end;

procedure TatStdCtrlsDispatcher.__TScrollEvent( Sender: TObject;  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  ScrollCodeTemp: variant;
  ScrollPosTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TScrollEvent(BeforeCall)(Sender,ScrollCode,ScrollPos);
    ScrollCodeTemp := ScrollCode;
    ScrollPosTemp := Integer(ScrollPos);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ScrollCodeTemp,ScrollPosTemp]);
    ScrollPos := VarToInteger(ScrollPosTemp);
    if AssignedMethod(AfterCall) then
      TScrollEvent(AfterCall)(Sender,ScrollCode,ScrollPos);
  end;
end;

procedure TatStdCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TCustomGroupBox) do
  begin
    DefineMethod('Create',1,tkClass,TCustomGroupBox,__TCustomGroupBoxCreate,true,0);
  end;
  With Scripter.DefineClass(TGroupBox) do
  begin
  end;
  With Scripter.DefineClass(TCustomLabel) do
  begin
    DefineMethod('Create',1,tkClass,TCustomLabel,__TCustomLabelCreate,true,0);
    DefineProp('Caption',tkVariant,nil,nil,nil,false,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TLabel) do
  begin
  end;
  With Scripter.DefineClass(TCustomEdit) do
  begin
    DefineMethod('Create',1,tkClass,TCustomEdit,__TCustomEditCreate,true,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomEditClear,false,0);
    DefineMethod('ClearSelection',0,tkNone,nil,__TCustomEditClearSelection,false,0);
    DefineMethod('CopyToClipboard',0,tkNone,nil,__TCustomEditCopyToClipboard,false,0);
    DefineMethod('CutToClipboard',0,tkNone,nil,__TCustomEditCutToClipboard,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TCustomEditDefaultHandler,false,0).SetVarArgs([0]);
    DefineMethod('PasteFromClipboard',0,tkNone,nil,__TCustomEditPasteFromClipboard,false,0);
    DefineMethod('Undo',0,tkNone,nil,__TCustomEditUndo,false,0);
    DefineMethod('ClearUndo',0,tkNone,nil,__TCustomEditClearUndo,false,0);
    DefineMethod('GetSelTextBuf',2,tkInteger,nil,__TCustomEditGetSelTextBuf,false,0);
    DefineMethod('SelectAll',0,tkNone,nil,__TCustomEditSelectAll,false,0);
    DefineMethod('SetSelTextBuf',1,tkNone,nil,__TCustomEditSetSelTextBuf,false,0);
    DefineProp('CanUndo',tkVariant,__GetTCustomEditCanUndo,nil,nil,false,0);
    DefineProp('Modified',tkVariant,__GetTCustomEditModified,__SetTCustomEditModified,nil,false,0);
    DefineProp('ReadOnly',tkVariant,__GetTCustomEditReadOnly,__SetTCustomEditReadOnly,nil,false,0);
    DefineProp('SelLength',tkInteger,__GetTCustomEditSelLength,__SetTCustomEditSelLength,nil,false,0);
    DefineProp('SelStart',tkInteger,__GetTCustomEditSelStart,__SetTCustomEditSelStart,nil,false,0);
    DefineProp('SelText',tkVariant,__GetTCustomEditSelText,__SetTCustomEditSelText,nil,false,0);
    DefineProp('Text',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TEdit) do
  begin
  end;
  With Scripter.DefineClass(TCustomMemo) do
  begin
    DefineMethod('Create',1,tkClass,TCustomMemo,__TCustomMemoCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomMemoDestroy,false,0);
    DefineMethod('GetControlsAlignment',0,tkEnumeration,nil,__TCustomMemoGetControlsAlignment,false,0);
    DefineProp('CaretPos',tkVariant,__GetTCustomMemoCaretPos,__SetTCustomMemoCaretPos,nil,false,0);
    DefineProp('Lines',tkClass,__GetTCustomMemoLines,__SetTCustomMemoLines,TStrings,false,0);
  end;
  With Scripter.DefineClass(TMemo) do
  begin
  end;
  With Scripter.DefineClass(TCustomComboBoxStrings) do
  begin
    DefineMethod('Clear',0,tkNone,nil,__TCustomComboBoxStringsClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TCustomComboBoxStringsDelete,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TCustomComboBoxStringsIndexOf,false,0);
  end;
  With Scripter.DefineClass(TCustomCombo) do
  begin
    DefineMethod('Create',1,tkClass,TCustomCombo,__TCustomComboCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomComboDestroy,false,0);
    DefineMethod('AddItem',2,tkNone,nil,__TCustomComboAddItem,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomComboClear,false,0);
    DefineMethod('ClearSelection',0,tkNone,nil,__TCustomComboClearSelection,false,0);
    DefineMethod('CopySelection',1,tkNone,nil,__TCustomComboCopySelection,false,0);
    DefineMethod('DeleteSelected',0,tkNone,nil,__TCustomComboDeleteSelected,false,0);
    DefineMethod('Focused',0,tkVariant,nil,__TCustomComboFocused,false,0);
    DefineMethod('SelectAll',0,tkNone,nil,__TCustomComboSelectAll,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomComboCanvas,nil,TCanvas,false,0);
    DefineProp('DroppedDown',tkVariant,__GetTCustomComboDroppedDown,__SetTCustomComboDroppedDown,nil,false,0);
    DefineProp('Items',tkClass,__GetTCustomComboItems,__SetTCustomComboItems,TStrings,false,0);
    DefineProp('SelLength',tkInteger,__GetTCustomComboSelLength,__SetTCustomComboSelLength,nil,false,0);
    DefineProp('SelStart',tkInteger,__GetTCustomComboSelStart,__SetTCustomComboSelStart,nil,false,0);
    DefineProp('TabStop',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomComboBox) do
  begin
    DefineMethod('Create',1,tkClass,TCustomComboBox,__TCustomComboBoxCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomComboBoxDestroy,false,0);
    DefineProp('AutoCompleteDelay',tkInteger,__GetTCustomComboBoxAutoCompleteDelay,__SetTCustomComboBoxAutoCompleteDelay,nil,false,0);
    DefineProp('AutoComplete',tkVariant,__GetTCustomComboBoxAutoComplete,__SetTCustomComboBoxAutoComplete,nil,false,0);
    DefineProp('AutoCloseUp',tkVariant,__GetTCustomComboBoxAutoCloseUp,__SetTCustomComboBoxAutoCloseUp,nil,false,0);
    DefineProp('AutoDropDown',tkVariant,__GetTCustomComboBoxAutoDropDown,__SetTCustomComboBoxAutoDropDown,nil,false,0);
    DefineProp('CharCase',tkEnumeration,__GetTCustomComboBoxCharCase,__SetTCustomComboBoxCharCase,nil,false,0);
    DefineProp('SelText',tkVariant,__GetTCustomComboBoxSelText,__SetTCustomComboBoxSelText,nil,false,0);
  end;
  With Scripter.DefineClass(TComboBox) do
  begin
  end;
  With Scripter.DefineClass(TButtonActionLink) do
  begin
  end;
  With Scripter.DefineClass(TButtonControl) do
  begin
    DefineMethod('Create',1,tkClass,TButtonControl,__TButtonControlCreate,true,0);
  end;
  With Scripter.DefineClass(TButton) do
  begin
    DefineMethod('Create',1,tkClass,TButton,__TButtonCreate,true,0);
    DefineMethod('Click',0,tkNone,nil,__TButtonClick,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TButtonUseRightToLeftAlignment,false,0);
  end;
  With Scripter.DefineClass(TCustomCheckBox) do
  begin
    DefineMethod('Create',1,tkClass,TCustomCheckBox,__TCustomCheckBoxCreate,true,0);
    DefineMethod('GetControlsAlignment',0,tkEnumeration,nil,__TCustomCheckBoxGetControlsAlignment,false,0);
  end;
  With Scripter.DefineClass(TCheckBox) do
  begin
  end;
  With Scripter.DefineClass(TRadioButton) do
  begin
    DefineMethod('Create',1,tkClass,TRadioButton,__TRadioButtonCreate,true,0);
    DefineMethod('GetControlsAlignment',0,tkEnumeration,nil,__TRadioButtonGetControlsAlignment,false,0);
  end;
  With Scripter.DefineClass(TCustomListBox) do
  begin
    DefineMethod('Create',1,tkClass,TCustomListBox,__TCustomListBoxCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomListBoxDestroy,false,0);
    DefineMethod('AddItem',2,tkNone,nil,__TCustomListBoxAddItem,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomListBoxClear,false,0);
    DefineMethod('ClearSelection',0,tkNone,nil,__TCustomListBoxClearSelection,false,0);
    DefineMethod('CopySelection',1,tkNone,nil,__TCustomListBoxCopySelection,false,0);
    DefineMethod('DeleteSelected',0,tkNone,nil,__TCustomListBoxDeleteSelected,false,0);
    DefineMethod('ItemAtPos',2,tkInteger,nil,__TCustomListBoxItemAtPos,false,0);
    DefineMethod('ItemRect',1,tkVariant,nil,__TCustomListBoxItemRect,false,0);
    DefineMethod('SelectAll',0,tkNone,nil,__TCustomListBoxSelectAll,false,0);
    DefineProp('AutoCompleteDelay',tkInteger,__GetTCustomListBoxAutoCompleteDelay,__SetTCustomListBoxAutoCompleteDelay,nil,false,0);
    DefineProp('AutoComplete',tkVariant,__GetTCustomListBoxAutoComplete,__SetTCustomListBoxAutoComplete,nil,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomListBoxCanvas,nil,TCanvas,false,0);
    DefineProp('Count',tkInteger,__GetTCustomListBoxCount,__SetTCustomListBoxCount,nil,false,0);
    DefineProp('Items',tkClass,__GetTCustomListBoxItems,__SetTCustomListBoxItems,TStrings,false,0);
    DefineProp('Selected',tkVariant,__GetTCustomListBoxSelected,__SetTCustomListBoxSelected,nil,false,1);
    DefineProp('ScrollWidth',tkInteger,__GetTCustomListBoxScrollWidth,__SetTCustomListBoxScrollWidth,nil,false,0);
    DefineProp('TopIndex',tkInteger,__GetTCustomListBoxTopIndex,__SetTCustomListBoxTopIndex,nil,false,0);
  end;
  With Scripter.DefineClass(TListBox) do
  begin
  end;
  With Scripter.DefineClass(TScrollBar) do
  begin
    DefineMethod('Create',1,tkClass,TScrollBar,__TScrollBarCreate,true,0);
    DefineMethod('SetParams',3,tkNone,nil,__TScrollBarSetParams,false,0);
  end;
  With Scripter.DefineClass(TCustomStaticText) do
  begin
    DefineMethod('Create',1,tkClass,TCustomStaticText,__TCustomStaticTextCreate,true,0);
  end;
  With Scripter.DefineClass(TStaticText) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TMeasureItemEvent), TatStdCtrlsDispatcher, @TatStdCtrlsDispatcher.__TMeasureItemEvent);
  DefineEventAdapter(TypeInfo(TLBGetDataEvent), TatStdCtrlsDispatcher, @TatStdCtrlsDispatcher.__TLBGetDataEvent);
  DefineEventAdapter(TypeInfo(TLBGetDataObjectEvent), TatStdCtrlsDispatcher, @TatStdCtrlsDispatcher.__TLBGetDataObjectEvent);
  DefineEventAdapter(TypeInfo(TLBFindDataEvent), TatStdCtrlsDispatcher, @TatStdCtrlsDispatcher.__TLBFindDataEvent);
  DefineEventAdapter(TypeInfo(TScrollEvent), TatStdCtrlsDispatcher, @TatStdCtrlsDispatcher.__TScrollEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('tlTop',tlTop);
    AddConstant('tlCenter',tlCenter);
    AddConstant('tlBottom',tlBottom);
    AddConstant('epNone',epNone);
    AddConstant('epPathEllipsis',epPathEllipsis);
    AddConstant('epEndEllipsis',epEndEllipsis);
    AddConstant('epWordEllipsis',epWordEllipsis);
    AddConstant('ecNormal',ecNormal);
    AddConstant('ecUpperCase',ecUpperCase);
    AddConstant('ecLowerCase',ecLowerCase);
    AddConstant('ssNone',ssNone);
    AddConstant('ssHorizontal',ssHorizontal);
    AddConstant('ssVertical',ssVertical);
    AddConstant('ssBoth',ssBoth);
    AddConstant('csDropDown',csDropDown);
    AddConstant('csSimple',csSimple);
    AddConstant('csDropDownList',csDropDownList);
    AddConstant('csOwnerDrawFixed',csOwnerDrawFixed);
    AddConstant('csOwnerDrawVariable',csOwnerDrawVariable);
    AddConstant('cbUnchecked',cbUnchecked);
    AddConstant('cbChecked',cbChecked);
    AddConstant('cbGrayed',cbGrayed);
    AddConstant('lbStandard',lbStandard);
    AddConstant('lbOwnerDrawFixed',lbOwnerDrawFixed);
    AddConstant('lbOwnerDrawVariable',lbOwnerDrawVariable);
    AddConstant('lbVirtual',lbVirtual);
    AddConstant('lbVirtualOwnerDraw',lbVirtualOwnerDraw);
    AddConstant('scLineUp',scLineUp);
    AddConstant('scLineDown',scLineDown);
    AddConstant('scPageUp',scPageUp);
    AddConstant('scPageDown',scPageDown);
    AddConstant('scPosition',scPosition);
    AddConstant('scTrack',scTrack);
    AddConstant('scTop',scTop);
    AddConstant('scBottom',scBottom);
    AddConstant('scEndScroll',scEndScroll);
    AddConstant('sbsNone',sbsNone);
    AddConstant('sbsSingle',sbsSingle);
    AddConstant('sbsSunken',sbsSunken);
  end;
end;

class function TatStdCtrlsLibrary.LibraryName: string;
begin
  result := 'StdCtrls';
end;

initialization
  RegisterScripterLibrary(TatStdCtrlsLibrary, True);

{$WARNINGS ON}

end.

