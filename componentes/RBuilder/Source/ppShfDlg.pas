{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppShfDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Controls,
  Buttons,
  StdCtrls,
  ExtCtrls,
  Dialogs,

  ppTypes,
  ppForms,
  ppDesignerForms,
  ppUtils;

type

  {@TppShiftDialog }
  
  TppShiftDialog = class(TppCustomShiftDialog)
    bvlBorder: TBevel;
    lblDescription: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    cbxSelectionList: TComboBox;
    procedure btnOKClick(Sender: TObject);

  private
    function FindSelectedComponent: Integer;

  protected
    procedure Activate; override;
    procedure LanguageChanged; override;
    procedure SetSelectionList(aSelectionlist: TStrings); override;
    function  GetSelectionList: TStrings; override;

  end; {class, TppShiftDialog}

var
  ppShiftDialog: TppShiftDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppShiftDialog.Activate }

procedure TppShiftDialog.Activate;
begin
  inherited Activate;

  cbxSelectionList.ItemIndex := FindSelectedComponent;

  Caption                    := ppLoadStr(338);
  lblDescription.Caption     := ppLoadStr(340);

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppShiftDialog.FindSelectedComponent }

function TppShiftDialog.FindSelectedComponent: Integer;
var
  lItems: TStrings;
  liItem: Integer;
  lsItem: String;
  lbItemFound: Boolean;
  liPos: Integer;
begin

  Result := -1;

  lItems := cbxSelectionList.Items;
  liItem := 0;
  lbItemFound := False;

  while not(lbItemFound) and (liItem < lItems.Count) do
    begin
      lsItem := lItems[liItem];

      {get the position of the spacer}
      liPos := Pos(':', lsItem);

      {get component name}
      if (liPos > 0) then
        lsItem := Copy(lsItem, 1, liPos - 1);

      lbItemFound := (SelectedComponent = lsItem);

      if not(lbItemFound) then
        Inc(liItem);
    end;

  if lbItemFound then
    Result := liItem;

end; {function, FindSelectedComponent}

{------------------------------------------------------------------------------}
{ TppShiftDialog.btnOKClick }

procedure TppShiftDialog.btnOKClick(Sender: TObject);
var
  lsComponentName: String;
  liPos: Integer;
  liIndex: Integer;
begin

  liIndex := cbxSelectionList.ItemIndex;

  lsComponentName := cbxSelectionList.Items[liIndex];

  {get the position of the spacer}
  liPos := Pos(':', lsComponentName);

  {get the component name}
  if (liPos > 0) then
    lsComponentName := Copy(lsComponentName, 1, liPos - 1);

  SelectedComponent := lsComponentName;

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppShiftDialog.LanguageChanged }

procedure TppShiftDialog.LanguageChanged;
begin

  Caption := ppLoadStr(338); {Shift Relative To}

  lblDescription.Caption := ppLoadStr(340); {Set object position based on}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppShiftDialog.GetSelectionList }

function TppShiftDialog.GetSelectionList:TStrings;
begin
  Result := cbxSelectionList.Items;
end; {function, GetSelectionList}

{------------------------------------------------------------------------------}
{ TppShiftDialog.SetSelectionList }

procedure TppShiftDialog.SetSelectionList(aSelectionList: TStrings);
begin
  cbxSelectionList.Items.Assign(aSelectionList);
end; {function, SetSelectionList}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomShiftDialog, TppShiftDialog);

finalization

  ppUnRegisterForm(TppCustomShiftDialog);

end.
