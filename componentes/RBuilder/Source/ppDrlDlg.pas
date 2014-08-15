{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDrlDlg;

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

const
  cSpacer = #1;

type

  {@TppDrillDownDialog }
  TppDrillDownDialog = class(TppCustomDrillDownDialog)
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
    function  GetSelectionList: TStrings; override;
    procedure SetSelectionList(aSelectionlist: TStrings); override;

  end; {class, TppDrillDownDialog}

var
  ppDrillDownDialog: TppDrillDownDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppDrillDownDialog.Activate }

procedure TppDrillDownDialog.Activate;
begin

  inherited Activate;

  Caption := ppLoadStr(261);
  lblDescription.Caption := ppLoadStr(263);

  cbxSelectionList.ItemIndex := FindSelectedComponent;

  cbxSelectionList.SetFocus;

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppDrillDownDialog.FindSelectedComponent }

function TppDrillDownDialog.FindSelectedComponent: Integer;
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
{ TppDrillDownDialog.btnOKClick }

procedure TppDrillDownDialog.btnOKClick(Sender: TObject);
var
  liPos: Integer;
  lsText: String;
begin
  lsText := cbxSelectionList.Items[cbxSelectionList.ItemIndex];

  {get the position of the spacer}
  liPos := Pos(':', lsText);

  {get component name}
  if (liPos > 0) then
    SelectedComponent := Copy(lsText, 1, liPos - 1)
  else
    SelectedComponent := lsText;

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppDrillDownDialog.LanguageChanged }

procedure TppDrillDownDialog.LanguageChanged;
begin

  Caption := ppLoadStr(261); {Drill Down Component}
  lblDescription.Caption := ppLoadStr(263); {Select Drill Down Component}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppDrillDownDialog.SetSelectionList }

function TppDrillDownDialog.GetSelectionList: TStrings;
begin
  Result := cbxSelectionList.Items;
end; {function, GetSelectionList}

{------------------------------------------------------------------------------}
{ TppDrillDownDialog.SetSelectionList }

procedure TppDrillDownDialog.SetSelectionList(aSelectionList: TStrings);
begin
  cbxSelectionList.Items.Assign(aSelectionList);
end; {procedure, SetSelectionList}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomDrillDownDialog, TppDrillDownDialog);
  
finalization

  ppUnRegisterForm(TppCustomDrillDownDialog);

end.
