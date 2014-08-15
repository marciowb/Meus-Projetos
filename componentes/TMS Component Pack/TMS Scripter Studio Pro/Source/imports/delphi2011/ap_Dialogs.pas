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
unit ap_Dialogs;

interface

uses
  Windows,
  Messages,
  SysUtils,
  CommDlg,
  Printers,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  ShlObj,
  CommCtrl,
  ComCtrls,
  Dialogs,
  Variants,
  ap_CommDlg,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatDialogsLibrary = class(TatScripterLibrary)
    procedure __TCommonDialogCreate(AMachine: TatVirtualMachine);
    procedure __TCommonDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TCommonDialogExecute(AMachine: TatVirtualMachine);
    procedure __TCommonDialogDefaultHandler(AMachine: TatVirtualMachine);
    procedure __GetTCommonDialogHandle(AMachine: TatVirtualMachine);
    procedure __TOpenDialogCreate(AMachine: TatVirtualMachine);
    procedure __TOpenDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TOpenDialogExecute(AMachine: TatVirtualMachine);
    procedure __GetTOpenDialogFileEditStyle(AMachine: TatVirtualMachine);
    procedure __SetTOpenDialogFileEditStyle(AMachine: TatVirtualMachine);
    procedure __GetTOpenDialogFiles(AMachine: TatVirtualMachine);
    procedure __GetTOpenDialogHistoryList(AMachine: TatVirtualMachine);
    procedure __SetTOpenDialogHistoryList(AMachine: TatVirtualMachine);
    procedure __TSaveDialogExecute(AMachine: TatVirtualMachine);
    procedure __TColorDialogCreate(AMachine: TatVirtualMachine);
    procedure __TColorDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TColorDialogExecute(AMachine: TatVirtualMachine);
    procedure __TFontDialogCreate(AMachine: TatVirtualMachine);
    procedure __TFontDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TFontDialogExecute(AMachine: TatVirtualMachine);
    procedure __TPrinterSetupDialogExecute(AMachine: TatVirtualMachine);
    procedure __TPrintDialogExecute(AMachine: TatVirtualMachine);
    procedure __TPageSetupDialogCreate(AMachine: TatVirtualMachine);
    procedure __TPageSetupDialogExecute(AMachine: TatVirtualMachine);
    procedure __TPageSetupDialogGetDefaults(AMachine: TatVirtualMachine);
    procedure __GetTPageSetupDialogPageSetupDlgRec(AMachine: TatVirtualMachine);
    procedure __TFindDialogCreate(AMachine: TatVirtualMachine);
    procedure __TFindDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TFindDialogCloseDialog(AMachine: TatVirtualMachine);
    procedure __TFindDialogExecute(AMachine: TatVirtualMachine);
    procedure __GetTFindDialogLeft(AMachine: TatVirtualMachine);
    procedure __SetTFindDialogLeft(AMachine: TatVirtualMachine);
    procedure __GetTFindDialogPosition(AMachine: TatVirtualMachine);
    procedure __SetTFindDialogPosition(AMachine: TatVirtualMachine);
    procedure __GetTFindDialogTop(AMachine: TatVirtualMachine);
    procedure __SetTFindDialogTop(AMachine: TatVirtualMachine);
    procedure __TReplaceDialogCreate(AMachine: TatVirtualMachine);
    procedure __TFileTypeItemCreate(AMachine: TatVirtualMachine);
    procedure __TFileTypeItemDestroy(AMachine: TatVirtualMachine);
    procedure __GetTFileTypeItemDisplayNameWStr(AMachine: TatVirtualMachine);
    procedure __GetTFileTypeItemFileMaskWStr(AMachine: TatVirtualMachine);
    procedure __TFileTypeItemsAdd(AMachine: TatVirtualMachine);
    procedure __GetTFileTypeItemsItems(AMachine: TatVirtualMachine);
    procedure __SetTFileTypeItemsItems(AMachine: TatVirtualMachine);
    procedure __TFavoriteLinkItemsEnumeratorCreate(AMachine: TatVirtualMachine);
    procedure __TFavoriteLinkItemsEnumeratorGetCurrent(AMachine: TatVirtualMachine);
    procedure __TFavoriteLinkItemsEnumeratorMoveNext(AMachine: TatVirtualMachine);
    procedure __GetTFavoriteLinkItemsEnumeratorCurrent(AMachine: TatVirtualMachine);
    procedure __TFavoriteLinkItemsAdd(AMachine: TatVirtualMachine);
    procedure __TFavoriteLinkItemsGetEnumerator(AMachine: TatVirtualMachine);
    procedure __GetTFavoriteLinkItemsItems(AMachine: TatVirtualMachine);
    procedure __SetTFavoriteLinkItemsItems(AMachine: TatVirtualMachine);
    procedure __TCustomFileDialogCreate(AMachine: TatVirtualMachine);
    procedure __TCustomFileDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomFileDialogExecute(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogClientGuid(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogClientGuid(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogDefaultExtension(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogDefaultExtension(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogDefaultFolder(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogDefaultFolder(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogFavoriteLinks(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogFavoriteLinks(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogFileName(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogFileName(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogFileNameLabel(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogFileNameLabel(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogFiles(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogFileTypes(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogFileTypes(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogFileTypeIndex(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogFileTypeIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogHandle(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogOkButtonLabel(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogOkButtonLabel(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogOptions(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogOptions(AMachine: TatVirtualMachine);
    procedure __GetTCustomFileDialogTitle(AMachine: TatVirtualMachine);
    procedure __SetTCustomFileDialogTitle(AMachine: TatVirtualMachine);
    procedure __TTaskDialogProgressBarCreate(AMachine: TatVirtualMachine);
    procedure __TTaskDialogProgressBarInitialize(AMachine: TatVirtualMachine);
    procedure __TTaskDialogBaseButtonItemCreate(AMachine: TatVirtualMachine);
    procedure __TTaskDialogBaseButtonItemDestroy(AMachine: TatVirtualMachine);
    procedure __TTaskDialogBaseButtonItemClick(AMachine: TatVirtualMachine);
    procedure __TTaskDialogBaseButtonItemSetInitialState(AMachine: TatVirtualMachine);
    procedure __GetTTaskDialogBaseButtonItemModalResult(AMachine: TatVirtualMachine);
    procedure __SetTTaskDialogBaseButtonItemModalResult(AMachine: TatVirtualMachine);
    procedure __GetTTaskDialogBaseButtonItemTextWStr(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonItemCreate(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonItemSetInitialState(AMachine: TatVirtualMachine);
    procedure __TTaskDialogRadioButtonItemCreate(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonsEnumeratorCreate(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonsEnumeratorGetCurrent(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonsEnumeratorMoveNext(AMachine: TatVirtualMachine);
    procedure __GetTTaskDialogButtonsEnumeratorCurrent(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonsDestroy(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonsAdd(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonsFindButton(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonsGetEnumerator(AMachine: TatVirtualMachine);
    procedure __TTaskDialogButtonsSetInitialState(AMachine: TatVirtualMachine);
    procedure __GetTTaskDialogButtonsDefaultButton(AMachine: TatVirtualMachine);
    procedure __SetTTaskDialogButtonsDefaultButton(AMachine: TatVirtualMachine);
    procedure __GetTTaskDialogButtonsItems(AMachine: TatVirtualMachine);
    procedure __SetTTaskDialogButtonsItems(AMachine: TatVirtualMachine);
    procedure __TCustomTaskDialogCreate(AMachine: TatVirtualMachine);
    procedure __TCustomTaskDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomTaskDialogExecute(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogButton(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogButton(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogButtons(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogButtons(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogCaption(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogCaption(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogCommonButtons(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogCommonButtons(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogCustomFooterIcon(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogCustomFooterIcon(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogCustomMainIcon(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogCustomMainIcon(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogDefaultButton(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogDefaultButton(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogExpandButtonCaption(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogExpandButtonCaption(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogExpanded(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogExpandedText(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogExpandedText(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogFlags(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogFlags(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogFooterIcon(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogFooterIcon(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogFooterText(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogFooterText(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogHandle(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogHelpContext(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogHelpContext(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogMainIcon(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogMainIcon(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogModalResult(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogModalResult(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogProgressBar(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogProgressBar(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogRadioButton(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogRadioButtons(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogRadioButtons(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogText(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogText(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogTitle(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogTitle(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogURL(AMachine: TatVirtualMachine);
    procedure __GetTCustomTaskDialogVerificationText(AMachine: TatVirtualMachine);
    procedure __SetTCustomTaskDialogVerificationText(AMachine: TatVirtualMachine);
    procedure __CreateMessageDialog(AMachine: TatVirtualMachine);
    procedure __MessageDlg(AMachine: TatVirtualMachine);
    procedure __MessageDlgPos(AMachine: TatVirtualMachine);
    procedure __MessageDlgPosHelp(AMachine: TatVirtualMachine);
    procedure __TaskMessageDlg(AMachine: TatVirtualMachine);
    procedure __TaskMessageDlgPos(AMachine: TatVirtualMachine);
    procedure __TaskMessageDlgPosHelp(AMachine: TatVirtualMachine);
    procedure __ShowMessage(AMachine: TatVirtualMachine);
    procedure __ShowMessagePos(AMachine: TatVirtualMachine);
    procedure __InputBox(AMachine: TatVirtualMachine);
    procedure __InputQuery(AMachine: TatVirtualMachine);
    procedure __PromptForFileName(AMachine: TatVirtualMachine);
    procedure __GetForceCurrentDirectory(AMachine: TatVirtualMachine);
    procedure __SetForceCurrentDirectory(AMachine: TatVirtualMachine);
    procedure __GetUseLatestCommonDialogs(AMachine: TatVirtualMachine);
    procedure __SetUseLatestCommonDialogs(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCommonDialogClass = class of TCommonDialog;
  TOpenDialogClass = class of TOpenDialog;
  TSaveDialogClass = class of TSaveDialog;
  TColorDialogClass = class of TColorDialog;
  TFontDialogClass = class of TFontDialog;
  TPrinterSetupDialogClass = class of TPrinterSetupDialog;
  TPrintDialogClass = class of TPrintDialog;
  TPageSetupDialogClass = class of TPageSetupDialog;
  TFindDialogClass = class of TFindDialog;
  TReplaceDialogClass = class of TReplaceDialog;
  EPlatformVersionExceptionClass = class of EPlatformVersionException;
  TFileTypeItemClass = class of TFileTypeItem;
  TFileTypeItemsClass = class of TFileTypeItems;
  TFavoriteLinkItemClass = class of TFavoriteLinkItem;
  TFavoriteLinkItemsEnumeratorClass = class of TFavoriteLinkItemsEnumerator;
  TFavoriteLinkItemsClass = class of TFavoriteLinkItems;
  TCustomFileDialogClass = class of TCustomFileDialog;
  TCustomFileOpenDialogClass = class of TCustomFileOpenDialog;
  TFileOpenDialogClass = class of TFileOpenDialog;
  TCustomFileSaveDialogClass = class of TCustomFileSaveDialog;
  TFileSaveDialogClass = class of TFileSaveDialog;
  TTaskDialogProgressBarClass = class of TTaskDialogProgressBar;
  TTaskDialogBaseButtonItemClass = class of TTaskDialogBaseButtonItem;
  TTaskDialogButtonItemClass = class of TTaskDialogButtonItem;
  TTaskDialogRadioButtonItemClass = class of TTaskDialogRadioButtonItem;
  TTaskDialogButtonsEnumeratorClass = class of TTaskDialogButtonsEnumerator;
  TTaskDialogButtonsClass = class of TTaskDialogButtons;
  TCustomTaskDialogClass = class of TCustomTaskDialog;
  TTaskDialogClass = class of TTaskDialog;

  TatDialogsDispatcher = class(TatEventDispatcher)
  private
    procedure __TFDApplyEvent( Sender: TObject;  Wnd: HWND);
    procedure __TPageSetupBeforePaintEvent( Sender: TObject; const PaperSize: SmallInt; const Orientation: TPrinterOrientation; const PageType: TPageType; var DoneDrawing: Boolean);
    procedure __TFileDialogCloseEvent( Sender: TObject; var CanClose: Boolean);
    procedure __TFileDialogFolderChangingEvent( Sender: TObject; var CanChange: Boolean);
    procedure __TFileDialogOverwriteEvent( Sender: TObject; var Response: TFileDialogOverwriteResponse);
    procedure __TFileDialogShareViolationEvent( Sender: TObject; var Response: TFileDialogShareViolationResponse);
    procedure __TTaskDlgClickEvent( Sender: TObject;  ModalResult: TModalResult; var CanClose: Boolean);
    procedure __TTaskDlgTimerEvent( Sender: TObject;  TickCount: Cardinal; var Reset: Boolean);
  end;


implementation



procedure TatDialogsLibrary.__TCommonDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCommonDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TCommonDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCommonDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TCommonDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCommonDialog(CurrentObject).Execute;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TCommonDialogDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TCommonDialog(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDialogsLibrary.__GetTCommonDialogHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCommonDialog(CurrentObject).Handle));
  end;
end;

procedure TatDialogsLibrary.__TOpenDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOpenDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TOpenDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOpenDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TOpenDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOpenDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTOpenDialogFileEditStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TOpenDialog(CurrentObject).FileEditStyle);
  end;
end;

procedure TatDialogsLibrary.__SetTOpenDialogFileEditStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOpenDialog(CurrentObject).FileEditStyle:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTOpenDialogFiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOpenDialog(CurrentObject).Files));
  end;
end;

procedure TatDialogsLibrary.__GetTOpenDialogHistoryList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TOpenDialog(CurrentObject).HistoryList));
  end;
end;

procedure TatDialogsLibrary.__SetTOpenDialogHistoryList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOpenDialog(CurrentObject).HistoryList:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__TSaveDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSaveDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TColorDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TColorDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TColorDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TColorDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TColorDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TColorDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFontDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFontDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFontDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFontDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TFontDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFontDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPrinterSetupDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPrinterSetupDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPrintDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPrintDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPageSetupDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPageSetupDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPageSetupDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPageSetupDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TPageSetupDialogGetDefaults(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPageSetupDialog(CurrentObject).GetDefaults;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTPageSetupDialogPageSetupDlgRec(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(tagPSDWWrapper.Create(TPageSetupDialog(CurrentObject).PageSetupDlgRec)));
  end;
end;

procedure TatDialogsLibrary.__TFindDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFindDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFindDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TFindDialogCloseDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).CloseDialog;
  end;
end;

procedure TatDialogsLibrary.__TFindDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFindDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTFindDialogLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFindDialog(CurrentObject).Left));
  end;
end;

procedure TatDialogsLibrary.__SetTFindDialogLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).Left:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDialogsLibrary.__GetTFindDialogPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TFindDialog(CurrentObject).Position)));
  end;
end;

procedure TatDialogsLibrary.__SetTFindDialogPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).Position:=TPointWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDialogsLibrary.__GetTFindDialogTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFindDialog(CurrentObject).Top));
  end;
end;

procedure TatDialogsLibrary.__SetTFindDialogTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFindDialog(CurrentObject).Top:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDialogsLibrary.__TReplaceDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TReplaceDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFileTypeItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFileTypeItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFileTypeItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFileTypeItem(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__GetTFileTypeItemDisplayNameWStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(WideCharToString(TFileTypeItem(CurrentObject).DisplayNameWStr));
  end;
end;

procedure TatDialogsLibrary.__GetTFileTypeItemFileMaskWStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(WideCharToString(TFileTypeItem(CurrentObject).FileMaskWStr));
  end;
end;

procedure TatDialogsLibrary.__TFileTypeItemsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFileTypeItems(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTFileTypeItemsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFileTypeItems(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDialogsLibrary.__SetTFileTypeItemsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFileTypeItems(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TFileTypeItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__TFavoriteLinkItemsEnumeratorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFavoriteLinkItemsEnumeratorClass(CurrentClass.ClassRef).Create(TFavoriteLinkItems(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFavoriteLinkItemsEnumeratorGetCurrent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFavoriteLinkItemsEnumerator(CurrentObject).GetCurrent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFavoriteLinkItemsEnumeratorMoveNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFavoriteLinkItemsEnumerator(CurrentObject).MoveNext;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTFavoriteLinkItemsEnumeratorCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFavoriteLinkItemsEnumerator(CurrentObject).Current));
  end;
end;

procedure TatDialogsLibrary.__TFavoriteLinkItemsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFavoriteLinkItems(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TFavoriteLinkItemsGetEnumerator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFavoriteLinkItems(CurrentObject).GetEnumerator);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTFavoriteLinkItemsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFavoriteLinkItems(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDialogsLibrary.__SetTFavoriteLinkItemsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFavoriteLinkItems(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TFavoriteLinkItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__TCustomFileDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomFileDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TCustomFileDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TCustomFileDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomFileDialog(CurrentObject).Execute;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogClientGuid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileDialog(CurrentObject).ClientGuid);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogClientGuid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).ClientGuid:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogDefaultExtension(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileDialog(CurrentObject).DefaultExtension);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogDefaultExtension(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).DefaultExtension:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogDefaultFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileDialog(CurrentObject).DefaultFolder);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogDefaultFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).DefaultFolder:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogFavoriteLinks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomFileDialog(CurrentObject).FavoriteLinks));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogFavoriteLinks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).FavoriteLinks:=TFavoriteLinkItems(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileDialog(CurrentObject).FileName);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).FileName:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogFileNameLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileDialog(CurrentObject).FileNameLabel);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogFileNameLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).FileNameLabel:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogFiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomFileDialog(CurrentObject).Files));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogFileTypes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomFileDialog(CurrentObject).FileTypes));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogFileTypes(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).FileTypes:=TFileTypeItems(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogFileTypeIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomFileDialog(CurrentObject).FileTypeIndex));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogFileTypeIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).FileTypeIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomFileDialog(CurrentObject).Handle));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogOkButtonLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileDialog(CurrentObject).OkButtonLabel);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogOkButtonLabel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).OkButtonLabel:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogOptions(AMachine: TatVirtualMachine);
var
PropValueSet: TFileDialogOptions;
begin
  with AMachine do
  begin
    PropValueSet := TCustomFileDialog(CurrentObject).Options;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogOptions(AMachine: TatVirtualMachine);
  var
  TempVar: TFileDialogOptions;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomFileDialog(CurrentObject).Options:=TempVar;
  end;
end;

procedure TatDialogsLibrary.__GetTCustomFileDialogTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomFileDialog(CurrentObject).Title);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomFileDialogTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomFileDialog(CurrentObject).Title:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogProgressBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogProgressBarClass(CurrentClass.ClassRef).Create(TCustomTaskDialog(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogProgressBarInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogProgressBar(CurrentObject).Initialize;
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogBaseButtonItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogBaseButtonItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogBaseButtonItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogBaseButtonItem(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogBaseButtonItemClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogBaseButtonItem(CurrentObject).Click;
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogBaseButtonItemSetInitialState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogBaseButtonItem(CurrentObject).SetInitialState;
  end;
end;

procedure TatDialogsLibrary.__GetTTaskDialogBaseButtonItemModalResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTaskDialogBaseButtonItem(CurrentObject).ModalResult);
  end;
end;

procedure TatDialogsLibrary.__SetTTaskDialogBaseButtonItemModalResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogBaseButtonItem(CurrentObject).ModalResult:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTTaskDialogBaseButtonItemTextWStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(WideCharToString(TTaskDialogBaseButtonItem(CurrentObject).TextWStr));
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogButtonItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonItemSetInitialState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogButtonItem(CurrentObject).SetInitialState;
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogRadioButtonItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogRadioButtonItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonsEnumeratorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogButtonsEnumeratorClass(CurrentClass.ClassRef).Create(TTaskDialogButtons(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonsEnumeratorGetCurrent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogButtonsEnumerator(CurrentObject).GetCurrent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonsEnumeratorMoveNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TTaskDialogButtonsEnumerator(CurrentObject).MoveNext;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTTaskDialogButtonsEnumeratorCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTaskDialogButtonsEnumerator(CurrentObject).Current));
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogButtons(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogButtons(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonsFindButton(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogButtons(CurrentObject).FindButton(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonsGetEnumerator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTaskDialogButtons(CurrentObject).GetEnumerator);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TTaskDialogButtonsSetInitialState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogButtons(CurrentObject).SetInitialState;
  end;
end;

procedure TatDialogsLibrary.__GetTTaskDialogButtonsDefaultButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTaskDialogButtons(CurrentObject).DefaultButton));
  end;
end;

procedure TatDialogsLibrary.__SetTTaskDialogButtonsDefaultButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogButtons(CurrentObject).DefaultButton:=TTaskDialogBaseButtonItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTTaskDialogButtonsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTaskDialogButtons(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDialogsLibrary.__SetTTaskDialogButtonsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTaskDialogButtons(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TTaskDialogBaseButtonItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__TCustomTaskDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomTaskDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TCustomTaskDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).Destroy;
  end;
end;

procedure TatDialogsLibrary.__TCustomTaskDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomTaskDialog(CurrentObject).Execute;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).Button));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).Button:=TTaskDialogButtonItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).Buttons));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).Buttons:=TTaskDialogButtons(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogCaption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).Caption);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogCaption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).Caption:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogCommonButtons(AMachine: TatVirtualMachine);
var
PropValueSet: TTaskDialogCommonButtons;
begin
  with AMachine do
  begin
    PropValueSet := TCustomTaskDialog(CurrentObject).CommonButtons;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogCommonButtons(AMachine: TatVirtualMachine);
  var
  TempVar: TTaskDialogCommonButtons;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomTaskDialog(CurrentObject).CommonButtons:=TempVar;
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogCustomFooterIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).CustomFooterIcon));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogCustomFooterIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).CustomFooterIcon:=TIcon(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogCustomMainIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).CustomMainIcon));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogCustomMainIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).CustomMainIcon:=TIcon(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogDefaultButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).DefaultButton);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogDefaultButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).DefaultButton:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogExpandButtonCaption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).ExpandButtonCaption);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogExpandButtonCaption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).ExpandButtonCaption:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogExpanded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).Expanded);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogExpandedText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).ExpandedText);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogExpandedText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).ExpandedText:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogFlags(AMachine: TatVirtualMachine);
var
PropValueSet: TTaskDialogFlags;
begin
  with AMachine do
  begin
    PropValueSet := TCustomTaskDialog(CurrentObject).Flags;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogFlags(AMachine: TatVirtualMachine);
  var
  TempVar: TTaskDialogFlags;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomTaskDialog(CurrentObject).Flags:=TempVar;
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogFooterIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).FooterIcon);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogFooterIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).FooterIcon:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogFooterText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).FooterText);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogFooterText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).FooterText:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).Handle));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogHelpContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).HelpContext));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogHelpContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).HelpContext:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogMainIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).MainIcon);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogMainIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).MainIcon:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogModalResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).ModalResult);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogModalResult(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).ModalResult:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogProgressBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).ProgressBar));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogProgressBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).ProgressBar:=TTaskDialogProgressBar(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogRadioButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).RadioButton));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogRadioButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomTaskDialog(CurrentObject).RadioButtons));
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogRadioButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).RadioButtons:=TTaskDialogButtons(Integer(GetInputArg(0)));
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).Text);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).Text:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).Title);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).Title:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogURL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).URL);
  end;
end;

procedure TatDialogsLibrary.__GetTCustomTaskDialogVerificationText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomTaskDialog(CurrentObject).VerificationText);
  end;
end;

procedure TatDialogsLibrary.__SetTCustomTaskDialogVerificationText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomTaskDialog(CurrentObject).VerificationText:=GetInputArg(0);
  end;
end;

procedure TatDialogsDispatcher.__TFDApplyEvent( Sender: TObject;  Wnd: HWND);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFDApplyEvent(BeforeCall)(Sender,Wnd);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Wnd]);
    if AssignedMethod(AfterCall) then
      TFDApplyEvent(AfterCall)(Sender,Wnd);
  end;
end;

procedure TatDialogsDispatcher.__TPageSetupBeforePaintEvent( Sender: TObject; const PaperSize: SmallInt; const Orientation: TPrinterOrientation; const PageType: TPageType; var DoneDrawing: Boolean);
var
  OrientationTemp: variant;
  PageTypeTemp: variant;
  DoneDrawingTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TPageSetupBeforePaintEvent(BeforeCall)(Sender,PaperSize,Orientation,PageType,DoneDrawing);
    OrientationTemp := Orientation;
    PageTypeTemp := PageType;
    DoneDrawingTemp := DoneDrawing;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,PaperSize,OrientationTemp,PageTypeTemp,DoneDrawingTemp]);
    DoneDrawing := DoneDrawingTemp;
    if AssignedMethod(AfterCall) then
      TPageSetupBeforePaintEvent(AfterCall)(Sender,PaperSize,Orientation,PageType,DoneDrawing);
  end;
end;

procedure TatDialogsDispatcher.__TFileDialogCloseEvent( Sender: TObject; var CanClose: Boolean);
var
  CanCloseTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFileDialogCloseEvent(BeforeCall)(Sender,CanClose);
    CanCloseTemp := CanClose;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,CanCloseTemp]);
    CanClose := CanCloseTemp;
    if AssignedMethod(AfterCall) then
      TFileDialogCloseEvent(AfterCall)(Sender,CanClose);
  end;
end;

procedure TatDialogsDispatcher.__TFileDialogFolderChangingEvent( Sender: TObject; var CanChange: Boolean);
var
  CanChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFileDialogFolderChangingEvent(BeforeCall)(Sender,CanChange);
    CanChangeTemp := CanChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,CanChangeTemp]);
    CanChange := CanChangeTemp;
    if AssignedMethod(AfterCall) then
      TFileDialogFolderChangingEvent(AfterCall)(Sender,CanChange);
  end;
end;

procedure TatDialogsDispatcher.__TFileDialogOverwriteEvent( Sender: TObject; var Response: TFileDialogOverwriteResponse);
var
  ResponseTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFileDialogOverwriteEvent(BeforeCall)(Sender,Response);
    ResponseTemp := Response;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ResponseTemp]);
    Response := ResponseTemp;
    if AssignedMethod(AfterCall) then
      TFileDialogOverwriteEvent(AfterCall)(Sender,Response);
  end;
end;

procedure TatDialogsDispatcher.__TFileDialogShareViolationEvent( Sender: TObject; var Response: TFileDialogShareViolationResponse);
var
  ResponseTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFileDialogShareViolationEvent(BeforeCall)(Sender,Response);
    ResponseTemp := Response;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ResponseTemp]);
    Response := ResponseTemp;
    if AssignedMethod(AfterCall) then
      TFileDialogShareViolationEvent(AfterCall)(Sender,Response);
  end;
end;

procedure TatDialogsDispatcher.__TTaskDlgClickEvent( Sender: TObject;  ModalResult: TModalResult; var CanClose: Boolean);
var
  ModalResultTemp: variant;
  CanCloseTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTaskDlgClickEvent(BeforeCall)(Sender,ModalResult,CanClose);
    ModalResultTemp := ModalResult;
    CanCloseTemp := CanClose;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ModalResultTemp,CanCloseTemp]);
    CanClose := CanCloseTemp;
    if AssignedMethod(AfterCall) then
      TTaskDlgClickEvent(AfterCall)(Sender,ModalResult,CanClose);
  end;
end;

procedure TatDialogsDispatcher.__TTaskDlgTimerEvent( Sender: TObject;  TickCount: Cardinal; var Reset: Boolean);
var
  ResetTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTaskDlgTimerEvent(BeforeCall)(Sender,TickCount,Reset);
    ResetTemp := Reset;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,TickCount,ResetTemp]);
    Reset := ResetTemp;
    if AssignedMethod(AfterCall) then
      TTaskDlgTimerEvent(AfterCall)(Sender,TickCount,Reset);
  end;
end;

procedure TatDialogsLibrary.__CreateMessageDialog(AMachine: TatVirtualMachine);
  var
  Param2: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(Dialogs.CreateMessageDialog(GetInputArg(0),GetInputArg(1),Param2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__MessageDlg(AMachine: TatVirtualMachine);
  var
  Param2: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(Dialogs.MessageDlg(GetInputArg(0),GetInputArg(1),Param2,VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__MessageDlgPos(AMachine: TatVirtualMachine);
  var
  Param2: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(Dialogs.MessageDlgPos(GetInputArg(0),GetInputArg(1),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__MessageDlgPosHelp(AMachine: TatVirtualMachine);
  var
  Param2: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := Integer(Dialogs.MessageDlgPosHelp(GetInputArg(0),GetInputArg(1),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),GetInputArg(6)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TaskMessageDlg(AMachine: TatVirtualMachine);
  var
  Param3: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
AResult := Integer(Dialogs.TaskMessageDlg(GetInputArg(0),GetInputArg(1),GetInputArg(2),Param3,VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TaskMessageDlgPos(AMachine: TatVirtualMachine);
  var
  Param3: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
AResult := Integer(Dialogs.TaskMessageDlgPos(GetInputArg(0),GetInputArg(1),GetInputArg(2),Param3,VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__TaskMessageDlgPosHelp(AMachine: TatVirtualMachine);
  var
  Param3: TMsgDlgButtons;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
AResult := Integer(Dialogs.TaskMessageDlgPosHelp(GetInputArg(0),GetInputArg(1),GetInputArg(2),Param3,VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5)),VarToInteger(GetInputArg(6)),GetInputArg(7)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__ShowMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Dialogs.ShowMessage(GetInputArg(0));
  end;
end;

procedure TatDialogsLibrary.__ShowMessagePos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Dialogs.ShowMessagePos(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatDialogsLibrary.__InputBox(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Dialogs.InputBox(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDialogsLibrary.__InputQuery(AMachine: TatVirtualMachine);
  var
  Param2: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Dialogs.InputQuery(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatDialogsLibrary.__PromptForFileName(AMachine: TatVirtualMachine);
  var
  Param0: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
case InputArgCount of
1: AResult := Dialogs.PromptForFileName(Param0);
2: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1));
3: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1),GetInputArg(2));
4: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1),GetInputArg(2),GetInputArg(3));
5: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4));
6: AResult := Dialogs.PromptForFileName(Param0,GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4),GetInputArg(5));
end;
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatDialogsLibrary.__GetForceCurrentDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Dialogs.ForceCurrentDirectory);
  end;
end;

procedure TatDialogsLibrary.__SetForceCurrentDirectory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Dialogs.ForceCurrentDirectory:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.__GetUseLatestCommonDialogs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Dialogs.UseLatestCommonDialogs);
  end;
end;

procedure TatDialogsLibrary.__SetUseLatestCommonDialogs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Dialogs.UseLatestCommonDialogs:=GetInputArg(0);
  end;
end;

procedure TatDialogsLibrary.Init;
begin
  With Scripter.DefineClass(TCommonDialog) do
  begin
    DefineMethod('Create',1,tkClass,TCommonDialog,__TCommonDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCommonDialogDestroy,false,0);
    DefineMethod('Execute',0,tkVariant,nil,__TCommonDialogExecute,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TCommonDialogDefaultHandler,false,0).SetVarArgs([0]);
    DefineProp('Handle',tkInteger,__GetTCommonDialogHandle,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TOpenDialog) do
  begin
    DefineMethod('Create',1,tkClass,TOpenDialog,__TOpenDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOpenDialogDestroy,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TOpenDialogExecute,false,0);
    DefineProp('FileEditStyle',tkEnumeration,__GetTOpenDialogFileEditStyle,__SetTOpenDialogFileEditStyle,nil,false,0);
    DefineProp('Files',tkClass,__GetTOpenDialogFiles,nil,TStrings,false,0);
    DefineProp('HistoryList',tkClass,__GetTOpenDialogHistoryList,__SetTOpenDialogHistoryList,TStrings,false,0);
  end;
  With Scripter.DefineClass(TSaveDialog) do
  begin
    DefineMethod('Execute',1,tkVariant,nil,__TSaveDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TColorDialog) do
  begin
    DefineMethod('Create',1,tkClass,TColorDialog,__TColorDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TColorDialogDestroy,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TColorDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TFontDialog) do
  begin
    DefineMethod('Create',1,tkClass,TFontDialog,__TFontDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFontDialogDestroy,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TFontDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TPrinterSetupDialog) do
  begin
    DefineMethod('Execute',1,tkVariant,nil,__TPrinterSetupDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TPrintDialog) do
  begin
    DefineMethod('Execute',1,tkVariant,nil,__TPrintDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TPageSetupDialog) do
  begin
    DefineMethod('Create',1,tkClass,TPageSetupDialog,__TPageSetupDialogCreate,true,0);
    DefineMethod('Execute',1,tkVariant,nil,__TPageSetupDialogExecute,false,0);
    DefineMethod('GetDefaults',0,tkVariant,nil,__TPageSetupDialogGetDefaults,false,0);
    DefineProp('PageSetupDlgRec',tkVariant,__GetTPageSetupDialogPageSetupDlgRec,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TFindDialog) do
  begin
    DefineMethod('Create',1,tkClass,TFindDialog,__TFindDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFindDialogDestroy,false,0);
    DefineMethod('CloseDialog',0,tkNone,nil,__TFindDialogCloseDialog,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TFindDialogExecute,false,0);
    DefineProp('Left',tkInteger,__GetTFindDialogLeft,__SetTFindDialogLeft,nil,false,0);
    DefineProp('Position',tkVariant,__GetTFindDialogPosition,__SetTFindDialogPosition,nil,false,0);
    DefineProp('Top',tkInteger,__GetTFindDialogTop,__SetTFindDialogTop,nil,false,0);
  end;
  With Scripter.DefineClass(TReplaceDialog) do
  begin
    DefineMethod('Create',1,tkClass,TReplaceDialog,__TReplaceDialogCreate,true,0);
  end;
  With Scripter.DefineClass(EPlatformVersionException) do
  begin
  end;
  With Scripter.DefineClass(TFileTypeItem) do
  begin
    DefineMethod('Create',1,tkClass,TFileTypeItem,__TFileTypeItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFileTypeItemDestroy,false,0);
    DefineProp('DisplayNameWStr',tkVariant,__GetTFileTypeItemDisplayNameWStr,nil,nil,false,0);
    DefineProp('FileMaskWStr',tkVariant,__GetTFileTypeItemFileMaskWStr,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TFileTypeItems) do
  begin
    DefineMethod('Add',0,tkClass,TFileTypeItem,__TFileTypeItemsAdd,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTFileTypeItemsItems,__SetTFileTypeItemsItems,TFileTypeItem,false,1);
  end;
  With Scripter.DefineClass(TFavoriteLinkItem) do
  begin
  end;
  With Scripter.DefineClass(TFavoriteLinkItemsEnumerator) do
  begin
    DefineMethod('Create',1,tkClass,TFavoriteLinkItemsEnumerator,__TFavoriteLinkItemsEnumeratorCreate,true,0);
    DefineMethod('GetCurrent',0,tkClass,TFavoriteLinkItem,__TFavoriteLinkItemsEnumeratorGetCurrent,false,0);
    DefineMethod('MoveNext',0,tkVariant,nil,__TFavoriteLinkItemsEnumeratorMoveNext,false,0);
    DefineProp('Current',tkClass,__GetTFavoriteLinkItemsEnumeratorCurrent,nil,TFavoriteLinkItem,false,0);
  end;
  With Scripter.DefineClass(TFavoriteLinkItems) do
  begin
    DefineMethod('Add',0,tkClass,TFavoriteLinkItem,__TFavoriteLinkItemsAdd,false,0);
    DefineMethod('GetEnumerator',0,tkClass,TFavoriteLinkItemsEnumerator,__TFavoriteLinkItemsGetEnumerator,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTFavoriteLinkItemsItems,__SetTFavoriteLinkItemsItems,TFavoriteLinkItem,false,1);
  end;
  With Scripter.DefineClass(TCustomFileDialog) do
  begin
    DefineMethod('Create',1,tkClass,TCustomFileDialog,__TCustomFileDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomFileDialogDestroy,false,0);
    DefineMethod('Execute',0,tkVariant,nil,__TCustomFileDialogExecute,false,0);
    DefineProp('ClientGuid',tkVariant,__GetTCustomFileDialogClientGuid,__SetTCustomFileDialogClientGuid,nil,false,0);
    DefineProp('DefaultExtension',tkVariant,__GetTCustomFileDialogDefaultExtension,__SetTCustomFileDialogDefaultExtension,nil,false,0);
    DefineProp('DefaultFolder',tkVariant,__GetTCustomFileDialogDefaultFolder,__SetTCustomFileDialogDefaultFolder,nil,false,0);
    DefineProp('FavoriteLinks',tkClass,__GetTCustomFileDialogFavoriteLinks,__SetTCustomFileDialogFavoriteLinks,TFavoriteLinkItems,false,0);
    DefineProp('FileName',tkVariant,__GetTCustomFileDialogFileName,__SetTCustomFileDialogFileName,nil,false,0);
    DefineProp('FileNameLabel',tkVariant,__GetTCustomFileDialogFileNameLabel,__SetTCustomFileDialogFileNameLabel,nil,false,0);
    DefineProp('Files',tkClass,__GetTCustomFileDialogFiles,nil,TStrings,false,0);
    DefineProp('FileTypes',tkClass,__GetTCustomFileDialogFileTypes,__SetTCustomFileDialogFileTypes,TFileTypeItems,false,0);
    DefineProp('FileTypeIndex',tkInteger,__GetTCustomFileDialogFileTypeIndex,__SetTCustomFileDialogFileTypeIndex,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTCustomFileDialogHandle,nil,nil,false,0);
    DefineProp('OkButtonLabel',tkVariant,__GetTCustomFileDialogOkButtonLabel,__SetTCustomFileDialogOkButtonLabel,nil,false,0);
    DefineProp('Options',tkInteger,__GetTCustomFileDialogOptions,__SetTCustomFileDialogOptions,nil,false,0);
    DefineProp('Title',tkVariant,__GetTCustomFileDialogTitle,__SetTCustomFileDialogTitle,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomFileOpenDialog) do
  begin
  end;
  With Scripter.DefineClass(TFileOpenDialog) do
  begin
  end;
  With Scripter.DefineClass(TCustomFileSaveDialog) do
  begin
  end;
  With Scripter.DefineClass(TFileSaveDialog) do
  begin
  end;
  With Scripter.DefineClass(TTaskDialogProgressBar) do
  begin
    DefineMethod('Create',1,tkClass,TTaskDialogProgressBar,__TTaskDialogProgressBarCreate,true,0);
    DefineMethod('Initialize',0,tkNone,nil,__TTaskDialogProgressBarInitialize,false,0);
  end;
  With Scripter.DefineClass(TTaskDialogBaseButtonItem) do
  begin
    DefineMethod('Create',1,tkClass,TTaskDialogBaseButtonItem,__TTaskDialogBaseButtonItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTaskDialogBaseButtonItemDestroy,false,0);
    DefineMethod('Click',0,tkNone,nil,__TTaskDialogBaseButtonItemClick,false,0);
    DefineMethod('SetInitialState',0,tkNone,nil,__TTaskDialogBaseButtonItemSetInitialState,false,0);
    DefineProp('ModalResult',tkEnumeration,__GetTTaskDialogBaseButtonItemModalResult,__SetTTaskDialogBaseButtonItemModalResult,nil,false,0);
    DefineProp('TextWStr',tkVariant,__GetTTaskDialogBaseButtonItemTextWStr,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TTaskDialogButtonItem) do
  begin
    DefineMethod('Create',1,tkClass,TTaskDialogButtonItem,__TTaskDialogButtonItemCreate,true,0);
    DefineMethod('SetInitialState',0,tkNone,nil,__TTaskDialogButtonItemSetInitialState,false,0);
  end;
  With Scripter.DefineClass(TTaskDialogRadioButtonItem) do
  begin
    DefineMethod('Create',1,tkClass,TTaskDialogRadioButtonItem,__TTaskDialogRadioButtonItemCreate,true,0);
  end;
  With Scripter.DefineClass(TTaskDialogButtonsEnumerator) do
  begin
    DefineMethod('Create',1,tkClass,TTaskDialogButtonsEnumerator,__TTaskDialogButtonsEnumeratorCreate,true,0);
    DefineMethod('GetCurrent',0,tkClass,TTaskDialogBaseButtonItem,__TTaskDialogButtonsEnumeratorGetCurrent,false,0);
    DefineMethod('MoveNext',0,tkVariant,nil,__TTaskDialogButtonsEnumeratorMoveNext,false,0);
    DefineProp('Current',tkClass,__GetTTaskDialogButtonsEnumeratorCurrent,nil,TTaskDialogBaseButtonItem,false,0);
  end;
  With Scripter.DefineClass(TTaskDialogButtons) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TTaskDialogButtonsDestroy,false,0);
    DefineMethod('Add',0,tkClass,TTaskDialogBaseButtonItem,__TTaskDialogButtonsAdd,false,0);
    DefineMethod('FindButton',1,tkClass,TTaskDialogBaseButtonItem,__TTaskDialogButtonsFindButton,false,0);
    DefineMethod('GetEnumerator',0,tkClass,TTaskDialogButtonsEnumerator,__TTaskDialogButtonsGetEnumerator,false,0);
    DefineMethod('SetInitialState',0,tkNone,nil,__TTaskDialogButtonsSetInitialState,false,0);
    DefineProp('DefaultButton',tkClass,__GetTTaskDialogButtonsDefaultButton,__SetTTaskDialogButtonsDefaultButton,TTaskDialogBaseButtonItem,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTTaskDialogButtonsItems,__SetTTaskDialogButtonsItems,TTaskDialogBaseButtonItem,false,1);
  end;
  With Scripter.DefineClass(TCustomTaskDialog) do
  begin
    DefineMethod('Create',1,tkClass,TCustomTaskDialog,__TCustomTaskDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomTaskDialogDestroy,false,0);
    DefineMethod('Execute',0,tkVariant,nil,__TCustomTaskDialogExecute,false,0);
    DefineProp('Button',tkClass,__GetTCustomTaskDialogButton,__SetTCustomTaskDialogButton,TTaskDialogButtonItem,false,0);
    DefineProp('Buttons',tkClass,__GetTCustomTaskDialogButtons,__SetTCustomTaskDialogButtons,TTaskDialogButtons,false,0);
    DefineProp('Caption',tkVariant,__GetTCustomTaskDialogCaption,__SetTCustomTaskDialogCaption,nil,false,0);
    DefineProp('CommonButtons',tkInteger,__GetTCustomTaskDialogCommonButtons,__SetTCustomTaskDialogCommonButtons,nil,false,0);
    DefineProp('CustomFooterIcon',tkClass,__GetTCustomTaskDialogCustomFooterIcon,__SetTCustomTaskDialogCustomFooterIcon,TIcon,false,0);
    DefineProp('CustomMainIcon',tkClass,__GetTCustomTaskDialogCustomMainIcon,__SetTCustomTaskDialogCustomMainIcon,TIcon,false,0);
    DefineProp('DefaultButton',tkEnumeration,__GetTCustomTaskDialogDefaultButton,__SetTCustomTaskDialogDefaultButton,nil,false,0);
    DefineProp('ExpandButtonCaption',tkVariant,__GetTCustomTaskDialogExpandButtonCaption,__SetTCustomTaskDialogExpandButtonCaption,nil,false,0);
    DefineProp('Expanded',tkVariant,__GetTCustomTaskDialogExpanded,nil,nil,false,0);
    DefineProp('ExpandedText',tkVariant,__GetTCustomTaskDialogExpandedText,__SetTCustomTaskDialogExpandedText,nil,false,0);
    DefineProp('Flags',tkInteger,__GetTCustomTaskDialogFlags,__SetTCustomTaskDialogFlags,nil,false,0);
    DefineProp('FooterIcon',tkEnumeration,__GetTCustomTaskDialogFooterIcon,__SetTCustomTaskDialogFooterIcon,nil,false,0);
    DefineProp('FooterText',tkVariant,__GetTCustomTaskDialogFooterText,__SetTCustomTaskDialogFooterText,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTCustomTaskDialogHandle,nil,nil,false,0);
    DefineProp('HelpContext',tkInteger,__GetTCustomTaskDialogHelpContext,__SetTCustomTaskDialogHelpContext,nil,false,0);
    DefineProp('MainIcon',tkEnumeration,__GetTCustomTaskDialogMainIcon,__SetTCustomTaskDialogMainIcon,nil,false,0);
    DefineProp('ModalResult',tkEnumeration,__GetTCustomTaskDialogModalResult,__SetTCustomTaskDialogModalResult,nil,false,0);
    DefineProp('ProgressBar',tkClass,__GetTCustomTaskDialogProgressBar,__SetTCustomTaskDialogProgressBar,TTaskDialogProgressBar,false,0);
    DefineProp('RadioButton',tkClass,__GetTCustomTaskDialogRadioButton,nil,TTaskDialogRadioButtonItem,false,0);
    DefineProp('RadioButtons',tkClass,__GetTCustomTaskDialogRadioButtons,__SetTCustomTaskDialogRadioButtons,TTaskDialogButtons,false,0);
    DefineProp('Text',tkVariant,__GetTCustomTaskDialogText,__SetTCustomTaskDialogText,nil,false,0);
    DefineProp('Title',tkVariant,__GetTCustomTaskDialogTitle,__SetTCustomTaskDialogTitle,nil,false,0);
    DefineProp('URL',tkVariant,__GetTCustomTaskDialogURL,nil,nil,false,0);
    DefineProp('VerificationText',tkVariant,__GetTCustomTaskDialogVerificationText,__SetTCustomTaskDialogVerificationText,nil,false,0);
  end;
  With Scripter.DefineClass(TTaskDialog) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TFDApplyEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TFDApplyEvent);
  DefineEventAdapter(TypeInfo(TPageSetupBeforePaintEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TPageSetupBeforePaintEvent);
  DefineEventAdapter(TypeInfo(TFileDialogCloseEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TFileDialogCloseEvent);
  DefineEventAdapter(TypeInfo(TFileDialogFolderChangingEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TFileDialogFolderChangingEvent);
  DefineEventAdapter(TypeInfo(TFileDialogOverwriteEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TFileDialogOverwriteEvent);
  DefineEventAdapter(TypeInfo(TFileDialogShareViolationEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TFileDialogShareViolationEvent);
  DefineEventAdapter(TypeInfo(TTaskDlgClickEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TTaskDlgClickEvent);
  DefineEventAdapter(TypeInfo(TTaskDlgTimerEvent), TatDialogsDispatcher, @TatDialogsDispatcher.__TTaskDlgTimerEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CreateMessageDialog',3,tkClass,TForm,__CreateMessageDialog,false,0);
    DefineMethod('MessageDlg',4,tkInteger,nil,__MessageDlg,false,0);
    DefineMethod('MessageDlgPos',6,tkInteger,nil,__MessageDlgPos,false,0);
    DefineMethod('MessageDlgPosHelp',7,tkInteger,nil,__MessageDlgPosHelp,false,0);
    DefineMethod('TaskMessageDlg',5,tkInteger,nil,__TaskMessageDlg,false,0);
    DefineMethod('TaskMessageDlgPos',7,tkInteger,nil,__TaskMessageDlgPos,false,0);
    DefineMethod('TaskMessageDlgPosHelp',8,tkInteger,nil,__TaskMessageDlgPosHelp,false,0);
    DefineMethod('ShowMessage',1,tkNone,nil,__ShowMessage,false,0);
    DefineMethod('ShowMessagePos',3,tkNone,nil,__ShowMessagePos,false,0);
    DefineMethod('InputBox',3,tkVariant,nil,__InputBox,false,0);
    DefineMethod('InputQuery',3,tkVariant,nil,__InputQuery,false,0).SetVarArgs([2]);
    DefineMethod('PromptForFileName',6,tkVariant,nil,__PromptForFileName,false,5).SetVarArgs([0]);
    DefineProp('ForceCurrentDirectory',tkVariant,__GetForceCurrentDirectory,__SetForceCurrentDirectory,nil,false,0);
    DefineProp('UseLatestCommonDialogs',tkVariant,__GetUseLatestCommonDialogs,__SetUseLatestCommonDialogs,nil,false,0);
    AddConstant('ofReadOnly',ofReadOnly);
    AddConstant('ofOverwritePrompt',ofOverwritePrompt);
    AddConstant('ofHideReadOnly',ofHideReadOnly);
    AddConstant('ofNoChangeDir',ofNoChangeDir);
    AddConstant('ofShowHelp',ofShowHelp);
    AddConstant('ofNoValidate',ofNoValidate);
    AddConstant('ofAllowMultiSelect',ofAllowMultiSelect);
    AddConstant('ofExtensionDifferent',ofExtensionDifferent);
    AddConstant('ofPathMustExist',ofPathMustExist);
    AddConstant('ofFileMustExist',ofFileMustExist);
    AddConstant('ofCreatePrompt',ofCreatePrompt);
    AddConstant('ofShareAware',ofShareAware);
    AddConstant('ofNoReadOnlyReturn',ofNoReadOnlyReturn);
    AddConstant('ofNoTestFileCreate',ofNoTestFileCreate);
    AddConstant('ofNoNetworkButton',ofNoNetworkButton);
    AddConstant('ofNoLongNames',ofNoLongNames);
    AddConstant('ofOldStyleDialog',ofOldStyleDialog);
    AddConstant('ofNoDereferenceLinks',ofNoDereferenceLinks);
    AddConstant('ofEnableIncludeNotify',ofEnableIncludeNotify);
    AddConstant('ofEnableSizing',ofEnableSizing);
    AddConstant('ofDontAddToRecent',ofDontAddToRecent);
    AddConstant('ofForceShowHidden',ofForceShowHidden);
    AddConstant('ofExNoPlacesBar',ofExNoPlacesBar);
    AddConstant('fsEdit',fsEdit);
    AddConstant('fsComboBox',fsComboBox);
    AddConstant('cdFullOpen',cdFullOpen);
    AddConstant('cdPreventFullOpen',cdPreventFullOpen);
    AddConstant('cdShowHelp',cdShowHelp);
    AddConstant('cdSolidColor',cdSolidColor);
    AddConstant('cdAnyColor',cdAnyColor);
    AddConstant('fdAnsiOnly',fdAnsiOnly);
    AddConstant('fdTrueTypeOnly',fdTrueTypeOnly);
    AddConstant('fdEffects',fdEffects);
    AddConstant('fdFixedPitchOnly',fdFixedPitchOnly);
    AddConstant('fdForceFontExist',fdForceFontExist);
    AddConstant('fdNoFaceSel',fdNoFaceSel);
    AddConstant('fdNoOEMFonts',fdNoOEMFonts);
    AddConstant('fdNoSimulations',fdNoSimulations);
    AddConstant('fdNoSizeSel',fdNoSizeSel);
    AddConstant('fdNoStyleSel',fdNoStyleSel);
    AddConstant('fdNoVectorFonts',fdNoVectorFonts);
    AddConstant('fdShowHelp',fdShowHelp);
    AddConstant('fdWysiwyg',fdWysiwyg);
    AddConstant('fdLimitSize',fdLimitSize);
    AddConstant('fdScalableOnly',fdScalableOnly);
    AddConstant('fdApplyButton',fdApplyButton);
    AddConstant('fdScreen',fdScreen);
    AddConstant('fdPrinter',fdPrinter);
    AddConstant('fdBoth',fdBoth);
    AddConstant('prAllPages',prAllPages);
    AddConstant('prSelection',prSelection);
    AddConstant('prPageNums',prPageNums);
    AddConstant('poPrintToFile',poPrintToFile);
    AddConstant('poPageNums',poPageNums);
    AddConstant('poSelection',poSelection);
    AddConstant('poWarning',poWarning);
    AddConstant('poHelp',poHelp);
    AddConstant('poDisablePrintToFile',poDisablePrintToFile);
    AddConstant('psoDefaultMinMargins',psoDefaultMinMargins);
    AddConstant('psoDisableMargins',psoDisableMargins);
    AddConstant('psoDisableOrientation',psoDisableOrientation);
    AddConstant('psoDisablePagePainting',psoDisablePagePainting);
    AddConstant('psoDisablePaper',psoDisablePaper);
    AddConstant('psoDisablePrinter',psoDisablePrinter);
    AddConstant('psoMargins',psoMargins);
    AddConstant('psoMinMargins',psoMinMargins);
    AddConstant('psoShowHelp',psoShowHelp);
    AddConstant('psoWarning',psoWarning);
    AddConstant('psoNoNetworkButton',psoNoNetworkButton);
    AddConstant('pkDotMatrix',pkDotMatrix);
    AddConstant('pkHPPCL',pkHPPCL);
    AddConstant('ptEnvelope',ptEnvelope);
    AddConstant('ptPaper',ptPaper);
    AddConstant('pmDefault',pmDefault);
    AddConstant('pmMillimeters',pmMillimeters);
    AddConstant('pmInches',pmInches);
    AddConstant('frDown',frDown);
    AddConstant('frFindNext',frFindNext);
    AddConstant('frHideMatchCase',frHideMatchCase);
    AddConstant('frHideWholeWord',frHideWholeWord);
    AddConstant('frHideUpDown',frHideUpDown);
    AddConstant('frMatchCase',frMatchCase);
    AddConstant('frDisableMatchCase',frDisableMatchCase);
    AddConstant('frDisableUpDown',frDisableUpDown);
    AddConstant('frDisableWholeWord',frDisableWholeWord);
    AddConstant('frReplace',frReplace);
    AddConstant('frReplaceAll',frReplaceAll);
    AddConstant('frWholeWord',frWholeWord);
    AddConstant('frShowHelp',frShowHelp);
    AddConstant('fdoOverWritePrompt',fdoOverWritePrompt);
    AddConstant('fdoStrictFileTypes',fdoStrictFileTypes);
    AddConstant('fdoNoChangeDir',fdoNoChangeDir);
    AddConstant('fdoPickFolders',fdoPickFolders);
    AddConstant('fdoForceFileSystem',fdoForceFileSystem);
    AddConstant('fdoAllNonStorageItems',fdoAllNonStorageItems);
    AddConstant('fdoNoValidate',fdoNoValidate);
    AddConstant('fdoAllowMultiSelect',fdoAllowMultiSelect);
    AddConstant('fdoPathMustExist',fdoPathMustExist);
    AddConstant('fdoFileMustExist',fdoFileMustExist);
    AddConstant('fdoCreatePrompt',fdoCreatePrompt);
    AddConstant('fdoShareAware',fdoShareAware);
    AddConstant('fdoNoReadOnlyReturn',fdoNoReadOnlyReturn);
    AddConstant('fdoNoTestFileCreate',fdoNoTestFileCreate);
    AddConstant('fdoHideMRUPlaces',fdoHideMRUPlaces);
    AddConstant('fdoHidePinnedPlaces',fdoHidePinnedPlaces);
    AddConstant('fdoNoDereferenceLinks',fdoNoDereferenceLinks);
    AddConstant('fdoDontAddToRecent',fdoDontAddToRecent);
    AddConstant('fdoForceShowHidden',fdoForceShowHidden);
    AddConstant('fdoDefaultNoMiniMode',fdoDefaultNoMiniMode);
    AddConstant('fdoForcePreviewPaneOn',fdoForcePreviewPaneOn);
    AddConstant('forDefault',forDefault);
    AddConstant('forAccept',forAccept);
    AddConstant('forRefuse',forRefuse);
    AddConstant('fsrDefault',fsrDefault);
    AddConstant('fsrAccept',fsrAccept);
    AddConstant('fsrRefuse',fsrRefuse);
    AddConstant('tfEnableHyperlinks',tfEnableHyperlinks);
    AddConstant('tfUseHiconMain',tfUseHiconMain);
    AddConstant('tfUseHiconFooter',tfUseHiconFooter);
    AddConstant('tfAllowDialogCancellation',tfAllowDialogCancellation);
    AddConstant('tfUseCommandLinks',tfUseCommandLinks);
    AddConstant('tfUseCommandLinksNoIcon',tfUseCommandLinksNoIcon);
    AddConstant('tfExpandFooterArea',tfExpandFooterArea);
    AddConstant('tfExpandedByDefault',tfExpandedByDefault);
    AddConstant('tfVerificationFlagChecked',tfVerificationFlagChecked);
    AddConstant('tfShowProgressBar',tfShowProgressBar);
    AddConstant('tfShowMarqueeProgressBar',tfShowMarqueeProgressBar);
    AddConstant('tfCallbackTimer',tfCallbackTimer);
    AddConstant('tfPositionRelativeToWindow',tfPositionRelativeToWindow);
    AddConstant('tfRtlLayout',tfRtlLayout);
    AddConstant('tfNoDefaultRadioButton',tfNoDefaultRadioButton);
    AddConstant('tfCanBeMinimized',tfCanBeMinimized);
    AddConstant('tcbOk',tcbOk);
    AddConstant('tcbYes',tcbYes);
    AddConstant('tcbNo',tcbNo);
    AddConstant('tcbCancel',tcbCancel);
    AddConstant('tcbRetry',tcbRetry);
    AddConstant('tcbClose',tcbClose);
    AddConstant('mtWarning',mtWarning);
    AddConstant('mtError',mtError);
    AddConstant('mtInformation',mtInformation);
    AddConstant('mtConfirmation',mtConfirmation);
    AddConstant('mtCustom',mtCustom);
    AddConstant('mbYes',mbYes);
    AddConstant('mbNo',mbNo);
    AddConstant('mbOK',mbOK);
    AddConstant('mbCancel',mbCancel);
    AddConstant('mbAbort',mbAbort);
    AddConstant('mbRetry',mbRetry);
    AddConstant('mbIgnore',mbIgnore);
    AddConstant('mbAll',mbAll);
    AddConstant('mbNoToAll',mbNoToAll);
    AddConstant('mbYesToAll',mbYesToAll);
    AddConstant('mbHelp',mbHelp);
    AddConstant('mbClose',mbClose);
    AddConstant('MaxCustomColors',MaxCustomColors);
    AddConstant('tdiNone',tdiNone);
    AddConstant('tdiWarning',tdiWarning);
    AddConstant('tdiError',tdiError);
    AddConstant('tdiInformation',tdiInformation);
    AddConstant('tdiShield',tdiShield);
    AddConstant('mbYesNo',IntFromConstSet(mbYesNo));
    AddConstant('mbYesNoCancel',IntFromConstSet(mbYesNoCancel));
    AddConstant('mbYesAllNoAllCancel',IntFromConstSet(mbYesAllNoAllCancel));
    AddConstant('mbOKCancel',IntFromConstSet(mbOKCancel));
    AddConstant('mbAbortRetryIgnore',IntFromConstSet(mbAbortRetryIgnore));
    AddConstant('mbAbortIgnore',IntFromConstSet(mbAbortIgnore));
  end;
end;

class function TatDialogsLibrary.LibraryName: string;
begin
  result := 'Dialogs';
end;

initialization
  RegisterScripterLibrary(TatDialogsLibrary, True);

{$WARNINGS ON}

end.

