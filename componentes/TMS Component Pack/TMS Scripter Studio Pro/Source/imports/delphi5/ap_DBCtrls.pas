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
unit ap_DBCtrls;

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Controls,
  Forms,
  Graphics,
  Menus,
  StdCtrls,
  ExtCtrls,
  Mask,
  Buttons,
  ComCtrls,
  Db,
  DBCtrls,
  atScript;

{$WARNINGS OFF}

type
  TatDBCtrlsLibrary = class(TatScripterLibrary)
    procedure __TFieldDataLinkCreate(AMachine: TatVirtualMachine);
    procedure __TFieldDataLinkEdit(AMachine: TatVirtualMachine);
    procedure __TFieldDataLinkModified(AMachine: TatVirtualMachine);
    procedure __TFieldDataLinkReset(AMachine: TatVirtualMachine);
    procedure __GetTFieldDataLinkCanModify(AMachine: TatVirtualMachine);
    procedure __GetTFieldDataLinkControl(AMachine: TatVirtualMachine);
    procedure __SetTFieldDataLinkControl(AMachine: TatVirtualMachine);
    procedure __GetTFieldDataLinkEditing(AMachine: TatVirtualMachine);
    procedure __GetTFieldDataLinkField(AMachine: TatVirtualMachine);
    procedure __GetTFieldDataLinkFieldName(AMachine: TatVirtualMachine);
    procedure __SetTFieldDataLinkFieldName(AMachine: TatVirtualMachine);
    procedure __TPaintControlCreate(AMachine: TatVirtualMachine);
    procedure __TPaintControlDestroy(AMachine: TatVirtualMachine);
    procedure __TPaintControlDestroyHandle(AMachine: TatVirtualMachine);
    procedure __GetTPaintControlCtl3DButton(AMachine: TatVirtualMachine);
    procedure __SetTPaintControlCtl3DButton(AMachine: TatVirtualMachine);
    procedure __GetTPaintControlHandle(AMachine: TatVirtualMachine);
    procedure __TDBEditCreate(AMachine: TatVirtualMachine);
    procedure __TDBEditDestroy(AMachine: TatVirtualMachine);
    procedure __TDBEditExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBEditUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBEditUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBEditField(AMachine: TatVirtualMachine);
    procedure __TDBTextCreate(AMachine: TatVirtualMachine);
    procedure __TDBTextDestroy(AMachine: TatVirtualMachine);
    procedure __TDBTextExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBTextUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBTextUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBTextField(AMachine: TatVirtualMachine);
    procedure __TDBCheckBoxCreate(AMachine: TatVirtualMachine);
    procedure __TDBCheckBoxDestroy(AMachine: TatVirtualMachine);
    procedure __TDBCheckBoxExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBCheckBoxUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBCheckBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBCheckBoxField(AMachine: TatVirtualMachine);
    procedure __TDBComboBoxCreate(AMachine: TatVirtualMachine);
    procedure __TDBComboBoxDestroy(AMachine: TatVirtualMachine);
    procedure __TDBComboBoxExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBComboBoxUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBComboBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBComboBoxField(AMachine: TatVirtualMachine);
    procedure __TDBListBoxCreate(AMachine: TatVirtualMachine);
    procedure __TDBListBoxDestroy(AMachine: TatVirtualMachine);
    procedure __TDBListBoxExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBListBoxUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBListBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBListBoxField(AMachine: TatVirtualMachine);
    procedure __TDBRadioGroupCreate(AMachine: TatVirtualMachine);
    procedure __TDBRadioGroupDestroy(AMachine: TatVirtualMachine);
    procedure __TDBRadioGroupExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBRadioGroupUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBRadioGroupUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBRadioGroupField(AMachine: TatVirtualMachine);
    procedure __GetTDBRadioGroupValue(AMachine: TatVirtualMachine);
    procedure __SetTDBRadioGroupValue(AMachine: TatVirtualMachine);
    procedure __TDBMemoCreate(AMachine: TatVirtualMachine);
    procedure __TDBMemoDestroy(AMachine: TatVirtualMachine);
    procedure __TDBMemoExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBMemoLoadMemo(AMachine: TatVirtualMachine);
    procedure __TDBMemoUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBMemoUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBMemoField(AMachine: TatVirtualMachine);
    procedure __TDBImageCreate(AMachine: TatVirtualMachine);
    procedure __TDBImageDestroy(AMachine: TatVirtualMachine);
    procedure __TDBImageCopyToClipboard(AMachine: TatVirtualMachine);
    procedure __TDBImageCutToClipboard(AMachine: TatVirtualMachine);
    procedure __TDBImageExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBImageLoadPicture(AMachine: TatVirtualMachine);
    procedure __TDBImagePasteFromClipboard(AMachine: TatVirtualMachine);
    procedure __TDBImageUpdateAction(AMachine: TatVirtualMachine);
    procedure __GetTDBImageField(AMachine: TatVirtualMachine);
    procedure __GetTDBImagePicture(AMachine: TatVirtualMachine);
    procedure __SetTDBImagePicture(AMachine: TatVirtualMachine);
    procedure __TDBNavigatorCreate(AMachine: TatVirtualMachine);
    procedure __TDBNavigatorDestroy(AMachine: TatVirtualMachine);
    procedure __TDBNavigatorSetBounds(AMachine: TatVirtualMachine);
    procedure __TDBNavigatorBtnClick(AMachine: TatVirtualMachine);
    procedure __TNavButtonDestroy(AMachine: TatVirtualMachine);
    procedure __GetTNavButtonNavStyle(AMachine: TatVirtualMachine);
    procedure __SetTNavButtonNavStyle(AMachine: TatVirtualMachine);
    procedure __GetTNavButtonIndex(AMachine: TatVirtualMachine);
    procedure __SetTNavButtonIndex(AMachine: TatVirtualMachine);
    procedure __TNavDataLinkCreate(AMachine: TatVirtualMachine);
    procedure __TNavDataLinkDestroy(AMachine: TatVirtualMachine);
    procedure __TDataSourceLinkCreate(AMachine: TatVirtualMachine);
    procedure __TListSourceLinkCreate(AMachine: TatVirtualMachine);
    procedure __TDBLookupControlCreate(AMachine: TatVirtualMachine);
    procedure __TDBLookupControlDestroy(AMachine: TatVirtualMachine);
    procedure __TDBLookupControlExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBLookupControlUpdateAction(AMachine: TatVirtualMachine);
    procedure __GetTDBLookupControlField(AMachine: TatVirtualMachine);
    procedure __TDBLookupListBoxCreate(AMachine: TatVirtualMachine);
    procedure __TDBLookupListBoxExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBLookupListBoxUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBLookupListBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __TDBLookupListBoxSetBounds(AMachine: TatVirtualMachine);
    procedure __GetTDBLookupListBoxSelectedItem(AMachine: TatVirtualMachine);
    procedure __TPopupDataListCreate(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboBoxCreate(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboBoxCloseUp(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboBoxDropDown(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboBoxExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboBoxSetBounds(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboBoxUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBLookupComboBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBLookupComboBoxListVisible(AMachine: TatVirtualMachine);
    procedure __GetTDBLookupComboBoxText(AMachine: TatVirtualMachine);
    procedure __TDBRichEditCreate(AMachine: TatVirtualMachine);
    procedure __TDBRichEditDestroy(AMachine: TatVirtualMachine);
    procedure __TDBRichEditExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBRichEditLoadMemo(AMachine: TatVirtualMachine);
    procedure __TDBRichEditUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDBRichEditUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __GetTDBRichEditField(AMachine: TatVirtualMachine);
    procedure __OkToChangeFieldAlignment(AMachine: TatVirtualMachine);
    procedure __DBUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TFieldDataLinkClass = class of TFieldDataLink;
  TPaintControlClass = class of TPaintControl;
  TDBEditClass = class of TDBEdit;
  TDBTextClass = class of TDBText;
  TDBCheckBoxClass = class of TDBCheckBox;
  TDBComboBoxClass = class of TDBComboBox;
  TDBListBoxClass = class of TDBListBox;
  TDBRadioGroupClass = class of TDBRadioGroup;
  TDBMemoClass = class of TDBMemo;
  TDBImageClass = class of TDBImage;
  TDBNavigatorClass = class of TDBNavigator;
  TNavButtonClass = class of TNavButton;
  TNavDataLinkClass = class of TNavDataLink;
  TDataSourceLinkClass = class of TDataSourceLink;
  TListSourceLinkClass = class of TListSourceLink;
  TDBLookupControlClass = class of TDBLookupControl;
  TDBLookupListBoxClass = class of TDBLookupListBox;
  TPopupDataListClass = class of TPopupDataList;
  TDBLookupComboBoxClass = class of TDBLookupComboBox;
  TDBRichEditClass = class of TDBRichEdit;

  TatDBCtrlsDispatcher = class(TatEventDispatcher)
  private
    procedure __ENavClick( Sender: TObject;  Button: TNavigateBtn);
  end;


implementation



procedure TatDBCtrlsLibrary.__TFieldDataLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldDataLinkClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TFieldDataLinkEdit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFieldDataLink(CurrentObject).Edit;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TFieldDataLinkModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDataLink(CurrentObject).Modified;
  end;
end;

procedure TatDBCtrlsLibrary.__TFieldDataLinkReset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDataLink(CurrentObject).Reset;
  end;
end;

procedure TatDBCtrlsLibrary.__GetTFieldDataLinkCanModify(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFieldDataLink(CurrentObject).CanModify);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTFieldDataLinkControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFieldDataLink(CurrentObject).Control));
  end;
end;

procedure TatDBCtrlsLibrary.__SetTFieldDataLinkControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDataLink(CurrentObject).Control:=TComponent(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBCtrlsLibrary.__GetTFieldDataLinkEditing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFieldDataLink(CurrentObject).Editing);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTFieldDataLinkField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFieldDataLink(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__GetTFieldDataLinkFieldName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFieldDataLink(CurrentObject).FieldName);
  end;
end;

procedure TatDBCtrlsLibrary.__SetTFieldDataLinkFieldName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDataLink(CurrentObject).FieldName:=GetInputArg(0);
  end;
end;

procedure TatDBCtrlsLibrary.__TPaintControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPaintControlClass(CurrentClass.ClassRef).Create(TWinControl(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TPaintControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPaintControl(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TPaintControlDestroyHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPaintControl(CurrentObject).DestroyHandle;
  end;
end;

procedure TatDBCtrlsLibrary.__GetTPaintControlCtl3DButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPaintControl(CurrentObject).Ctl3DButton);
  end;
end;

procedure TatDBCtrlsLibrary.__SetTPaintControlCtl3DButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPaintControl(CurrentObject).Ctl3DButton:=GetInputArg(0);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTPaintControlHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPaintControl(CurrentObject).Handle));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBEditDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBEdit(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBEditExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBEdit(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBEditUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBEdit(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBEditUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBEdit(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBEditField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBEdit(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBTextCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBTextClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBTextDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBText(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBTextExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBText(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBTextUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBText(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBTextUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBText(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBTextField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBText(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBCheckBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBCheckBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBCheckBoxDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBCheckBox(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBCheckBoxExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBCheckBox(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBCheckBoxUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBCheckBox(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBCheckBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBCheckBox(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBCheckBoxField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBCheckBox(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBComboBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBComboBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBComboBoxDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBComboBox(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBComboBoxExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBComboBox(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBComboBoxUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBComboBox(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBComboBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBComboBox(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBComboBoxField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBComboBox(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBListBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBListBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBListBoxDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBListBox(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBListBoxExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBListBox(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBListBoxUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBListBox(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBListBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBListBox(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBListBoxField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBListBox(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRadioGroupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBRadioGroupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRadioGroupDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBRadioGroup(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRadioGroupExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBRadioGroup(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRadioGroupUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBRadioGroup(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRadioGroupUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBRadioGroup(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBRadioGroupField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBRadioGroup(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBRadioGroupValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBRadioGroup(CurrentObject).Value);
  end;
end;

procedure TatDBCtrlsLibrary.__SetTDBRadioGroupValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBRadioGroup(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBMemoCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBMemoClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBMemoDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBMemo(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBMemoExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBMemo(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBMemoLoadMemo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBMemo(CurrentObject).LoadMemo;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBMemoUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBMemo(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBMemoUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBMemo(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBMemoField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBMemo(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBImageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBImageClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBImageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBImage(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBImageCopyToClipboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBImage(CurrentObject).CopyToClipboard;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBImageCutToClipboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBImage(CurrentObject).CutToClipboard;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBImageExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBImage(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBImageLoadPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBImage(CurrentObject).LoadPicture;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBImagePasteFromClipboard(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBImage(CurrentObject).PasteFromClipboard;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBImageUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBImage(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBImageField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBImage(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBImagePicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBImage(CurrentObject).Picture));
  end;
end;

procedure TatDBCtrlsLibrary.__SetTDBImagePicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBImage(CurrentObject).Picture:=TPicture(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBNavigatorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBNavigatorClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBNavigatorDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBNavigator(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBNavigatorSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBNavigator(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBNavigatorBtnClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBNavigator(CurrentObject).BtnClick(GetInputArg(0));
  end;
end;

procedure TatDBCtrlsLibrary.__TNavButtonDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TNavButton(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__GetTNavButtonNavStyle(AMachine: TatVirtualMachine);
var
PropValueSet: TNavButtonStyle;
begin
  with AMachine do
  begin
    PropValueSet := TNavButton(CurrentObject).NavStyle;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBCtrlsLibrary.__SetTNavButtonNavStyle(AMachine: TatVirtualMachine);
  var
  TempVar: TNavButtonStyle;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TNavButton(CurrentObject).NavStyle:=TempVar;
  end;
end;

procedure TatDBCtrlsLibrary.__GetTNavButtonIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TNavButton(CurrentObject).Index);
  end;
end;

procedure TatDBCtrlsLibrary.__SetTNavButtonIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TNavButton(CurrentObject).Index:=GetInputArg(0);
  end;
end;

procedure TatDBCtrlsLibrary.__TNavDataLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TNavDataLinkClass(CurrentClass.ClassRef).Create(TDBNavigator(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TNavDataLinkDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TNavDataLink(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDataSourceLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSourceLinkClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TListSourceLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListSourceLinkClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBLookupControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupControl(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupControlExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBLookupControl(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupControlUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBLookupControl(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBLookupControlField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBLookupControl(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupListBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBLookupListBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupListBoxExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBLookupListBox(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupListBoxUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBLookupListBox(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupListBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBLookupListBox(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupListBoxSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupListBox(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBLookupListBoxSelectedItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBLookupListBox(CurrentObject).SelectedItem);
  end;
end;

procedure TatDBCtrlsLibrary.__TPopupDataListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPopupDataListClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupComboBoxCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBLookupComboBoxClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupComboBoxCloseUp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupComboBox(CurrentObject).CloseUp(GetInputArg(0));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupComboBoxDropDown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupComboBox(CurrentObject).DropDown;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupComboBoxExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBLookupComboBox(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupComboBoxSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBLookupComboBox(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupComboBoxUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBLookupComboBox(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBLookupComboBoxUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBLookupComboBox(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBLookupComboBoxListVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBLookupComboBox(CurrentObject).ListVisible);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBLookupComboBoxText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBLookupComboBox(CurrentObject).Text);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRichEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBRichEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRichEditDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBRichEdit(CurrentObject).Destroy;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRichEditExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBRichEdit(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRichEditLoadMemo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBRichEdit(CurrentObject).LoadMemo;
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRichEditUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBRichEdit(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__TDBRichEditUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBRichEdit(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__GetTDBRichEditField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBRichEdit(CurrentObject).Field));
  end;
end;

procedure TatDBCtrlsDispatcher.__ENavClick( Sender: TObject;  Button: TNavigateBtn);
var
  ButtonTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      ENavClick(BeforeCall)(Sender,Button);
    ButtonTemp := Button;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ButtonTemp]);
    if AssignedMethod(AfterCall) then
      ENavClick(AfterCall)(Sender,Button);
  end;
end;

procedure TatDBCtrlsLibrary.__OkToChangeFieldAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DBCtrls.OkToChangeFieldAlignment(TField(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.__DBUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DBCtrls.DBUseRightToLeftAlignment(TControl(Integer(GetInputArg(0))),TField(Integer(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCtrlsLibrary.Init;
begin
  With Scripter.DefineClass(TFieldDataLink) do
  begin
    DefineMethod('Create',0,tkClass,TFieldDataLink,__TFieldDataLinkCreate,true,0);
    DefineMethod('Edit',0,tkVariant,nil,__TFieldDataLinkEdit,false,0);
    DefineMethod('Modified',0,tkNone,nil,__TFieldDataLinkModified,false,0);
    DefineMethod('Reset',0,tkNone,nil,__TFieldDataLinkReset,false,0);
    DefineProp('CanModify',tkVariant,__GetTFieldDataLinkCanModify,nil,nil,false,0);
    DefineProp('Control',tkClass,__GetTFieldDataLinkControl,__SetTFieldDataLinkControl,TComponent,false,0);
    DefineProp('Editing',tkVariant,__GetTFieldDataLinkEditing,nil,nil,false,0);
    DefineProp('Field',tkClass,__GetTFieldDataLinkField,nil,TField,false,0);
    DefineProp('FieldName',tkVariant,__GetTFieldDataLinkFieldName,__SetTFieldDataLinkFieldName,nil,false,0);
  end;
  With Scripter.DefineClass(TPaintControl) do
  begin
    DefineMethod('Create',2,tkClass,TPaintControl,__TPaintControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TPaintControlDestroy,false,0);
    DefineMethod('DestroyHandle',0,tkNone,nil,__TPaintControlDestroyHandle,false,0);
    DefineProp('Ctl3DButton',tkVariant,__GetTPaintControlCtl3DButton,__SetTPaintControlCtl3DButton,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTPaintControlHandle,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDBEdit) do
  begin
    DefineMethod('Create',1,tkClass,TDBEdit,__TDBEditCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBEditDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBEditExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBEditUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBEditUseRightToLeftAlignment,false,0);
    DefineProp('Field',tkClass,__GetTDBEditField,nil,TField,false,0);
  end;
  With Scripter.DefineClass(TDBText) do
  begin
    DefineMethod('Create',1,tkClass,TDBText,__TDBTextCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBTextDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBTextExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBTextUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBTextUseRightToLeftAlignment,false,0);
    DefineProp('Field',tkClass,__GetTDBTextField,nil,TField,false,0);
  end;
  With Scripter.DefineClass(TDBCheckBox) do
  begin
    DefineMethod('Create',1,tkClass,TDBCheckBox,__TDBCheckBoxCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBCheckBoxDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBCheckBoxExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBCheckBoxUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBCheckBoxUseRightToLeftAlignment,false,0);
    DefineProp('Checked',tkVariant,nil,nil,nil,false,0);
    DefineProp('Field',tkClass,__GetTDBCheckBoxField,nil,TField,false,0);
    DefineProp('State',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDBComboBox) do
  begin
    DefineMethod('Create',1,tkClass,TDBComboBox,__TDBComboBoxCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBComboBoxDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBComboBoxExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBComboBoxUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBComboBoxUseRightToLeftAlignment,false,0);
    DefineProp('Field',tkClass,__GetTDBComboBoxField,nil,TField,false,0);
    DefineProp('Text',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDBListBox) do
  begin
    DefineMethod('Create',1,tkClass,TDBListBox,__TDBListBoxCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBListBoxDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBListBoxExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBListBoxUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBListBoxUseRightToLeftAlignment,false,0);
    DefineProp('Field',tkClass,__GetTDBListBoxField,nil,TField,false,0);
  end;
  With Scripter.DefineClass(TDBRadioGroup) do
  begin
    DefineMethod('Create',1,tkClass,TDBRadioGroup,__TDBRadioGroupCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBRadioGroupDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBRadioGroupExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBRadioGroupUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBRadioGroupUseRightToLeftAlignment,false,0);
    DefineProp('Field',tkClass,__GetTDBRadioGroupField,nil,TField,false,0);
    DefineProp('ItemIndex',tkVariant,nil,nil,nil,false,0);
    DefineProp('Value',tkVariant,__GetTDBRadioGroupValue,__SetTDBRadioGroupValue,nil,false,0);
  end;
  With Scripter.DefineClass(TDBMemo) do
  begin
    DefineMethod('Create',1,tkClass,TDBMemo,__TDBMemoCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBMemoDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBMemoExecuteAction,false,0);
    DefineMethod('LoadMemo',0,tkNone,nil,__TDBMemoLoadMemo,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBMemoUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBMemoUseRightToLeftAlignment,false,0);
    DefineProp('Field',tkClass,__GetTDBMemoField,nil,TField,false,0);
  end;
  With Scripter.DefineClass(TDBImage) do
  begin
    DefineMethod('Create',1,tkClass,TDBImage,__TDBImageCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBImageDestroy,false,0);
    DefineMethod('CopyToClipboard',0,tkNone,nil,__TDBImageCopyToClipboard,false,0);
    DefineMethod('CutToClipboard',0,tkNone,nil,__TDBImageCutToClipboard,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBImageExecuteAction,false,0);
    DefineMethod('LoadPicture',0,tkNone,nil,__TDBImageLoadPicture,false,0);
    DefineMethod('PasteFromClipboard',0,tkNone,nil,__TDBImagePasteFromClipboard,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBImageUpdateAction,false,0);
    DefineProp('Field',tkClass,__GetTDBImageField,nil,TField,false,0);
    DefineProp('Picture',tkClass,__GetTDBImagePicture,__SetTDBImagePicture,TPicture,false,0);
  end;
  With Scripter.DefineClass(TDBNavigator) do
  begin
    DefineMethod('Create',1,tkClass,TDBNavigator,__TDBNavigatorCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBNavigatorDestroy,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TDBNavigatorSetBounds,false,0);
    DefineMethod('BtnClick',1,tkNone,nil,__TDBNavigatorBtnClick,false,0);
  end;
  With Scripter.DefineClass(TNavButton) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TNavButtonDestroy,false,0);
    DefineProp('NavStyle',tkInteger,__GetTNavButtonNavStyle,__SetTNavButtonNavStyle,nil,false,0);
    DefineProp('Index',tkEnumeration,__GetTNavButtonIndex,__SetTNavButtonIndex,nil,false,0);
  end;
  With Scripter.DefineClass(TNavDataLink) do
  begin
    DefineMethod('Create',1,tkClass,TNavDataLink,__TNavDataLinkCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TNavDataLinkDestroy,false,0);
  end;
  With Scripter.DefineClass(TDataSourceLink) do
  begin
    DefineMethod('Create',0,tkClass,TDataSourceLink,__TDataSourceLinkCreate,true,0);
  end;
  With Scripter.DefineClass(TListSourceLink) do
  begin
    DefineMethod('Create',0,tkClass,TListSourceLink,__TListSourceLinkCreate,true,0);
  end;
  With Scripter.DefineClass(TDBLookupControl) do
  begin
    DefineMethod('Create',1,tkClass,TDBLookupControl,__TDBLookupControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBLookupControlDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBLookupControlExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBLookupControlUpdateAction,false,0);
    DefineProp('Field',tkClass,__GetTDBLookupControlField,nil,TField,false,0);
  end;
  With Scripter.DefineClass(TDBLookupListBox) do
  begin
    DefineMethod('Create',1,tkClass,TDBLookupListBox,__TDBLookupListBoxCreate,true,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBLookupListBoxExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBLookupListBoxUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBLookupListBoxUseRightToLeftAlignment,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TDBLookupListBoxSetBounds,false,0);
    DefineProp('KeyValue',tkVariant,nil,nil,nil,false,0);
    DefineProp('SelectedItem',tkVariant,__GetTDBLookupListBoxSelectedItem,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPopupDataList) do
  begin
    DefineMethod('Create',1,tkClass,TPopupDataList,__TPopupDataListCreate,true,0);
  end;
  With Scripter.DefineClass(TDBLookupComboBox) do
  begin
    DefineMethod('Create',1,tkClass,TDBLookupComboBox,__TDBLookupComboBoxCreate,true,0);
    DefineMethod('CloseUp',1,tkNone,nil,__TDBLookupComboBoxCloseUp,false,0);
    DefineMethod('DropDown',0,tkNone,nil,__TDBLookupComboBoxDropDown,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBLookupComboBoxExecuteAction,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TDBLookupComboBoxSetBounds,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBLookupComboBoxUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBLookupComboBoxUseRightToLeftAlignment,false,0);
    DefineProp('KeyValue',tkVariant,nil,nil,nil,false,0);
    DefineProp('ListVisible',tkVariant,__GetTDBLookupComboBoxListVisible,nil,nil,false,0);
    DefineProp('Text',tkVariant,__GetTDBLookupComboBoxText,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDBRichEdit) do
  begin
    DefineMethod('Create',1,tkClass,TDBRichEdit,__TDBRichEditCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBRichEditDestroy,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBRichEditExecuteAction,false,0);
    DefineMethod('LoadMemo',0,tkNone,nil,__TDBRichEditLoadMemo,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBRichEditUpdateAction,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TDBRichEditUseRightToLeftAlignment,false,0);
    DefineProp('Field',tkClass,__GetTDBRichEditField,nil,TField,false,0);
  end;
  DefineEventAdapter(TypeInfo(ENavClick), TatDBCtrlsDispatcher, @TatDBCtrlsDispatcher.__ENavClick);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('OkToChangeFieldAlignment',2,tkVariant,nil,__OkToChangeFieldAlignment,false,0);
    DefineMethod('DBUseRightToLeftAlignment',2,tkVariant,nil,__DBUseRightToLeftAlignment,false,0);
    AddConstant('ngEnabled',ngEnabled);
    AddConstant('ngDisabled',ngDisabled);
    AddConstant('nbFirst',nbFirst);
    AddConstant('nbPrior',nbPrior);
    AddConstant('nbNext',nbNext);
    AddConstant('nbLast',nbLast);
    AddConstant('nbInsert',nbInsert);
    AddConstant('nbDelete',nbDelete);
    AddConstant('nbEdit',nbEdit);
    AddConstant('nbPost',nbPost);
    AddConstant('nbCancel',nbCancel);
    AddConstant('nbRefresh',nbRefresh);
    AddConstant('daLeft',daLeft);
    AddConstant('daRight',daRight);
    AddConstant('daCenter',daCenter);
    AddConstant('InitRepeatPause',InitRepeatPause);
    AddConstant('RepeatPause',RepeatPause);
    AddConstant('SpaceSize',SpaceSize);
  end;
end;

class function TatDBCtrlsLibrary.LibraryName: string;
begin
  result := 'DBCtrls';
end;

initialization
  RegisterScripterLibrary(TatDBCtrlsLibrary, True);

{$WARNINGS ON}

end.

