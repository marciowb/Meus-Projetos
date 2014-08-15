{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppClcDlg;

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

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppUtils;

type
  TppDBCalcDialog = class(TppCustomDBCalcDialog)
    btnOK: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    cbxCalcType: TComboBox;
    cbxResetGroup: TComboBox;
    lblCalcType: TLabel;
    lblResetGroup: TLabel;
    procedure cbxResetGroupKeyPress(Sender: TObject; var Key: Char);
    procedure cbxResetGroupExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);

  private

    function  IsValidGroup: Boolean;

  protected
    procedure Activate; override;
    procedure LanguageChanged; override;

    procedure SetGroupDescriptions(aDescriptions: TStrings); override;
    function GetGroupDescriptions: TStrings; override;

  end;

var
  ppDBCalcDialog: TppDBCalcDialog;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TppDBCalcDialog.Activate }

procedure TppDBCalcDialog.Activate;
begin

  inherited Activate;

   cbxCalcType.ItemIndex   := DBCalcType;
   cbxResetGroup.ItemIndex := ResetGroupIndex;
   cbxCalcType.SetFocus;

end;

{------------------------------------------------------------------------------}
{ TppDBCalcDialog.btnOKClick }

procedure TppDBCalcDialog.btnOKClick(Sender: TObject);
begin
   DBCalcType      := cbxCalcType.ItemIndex;
   ResetGroupIndex := cbxResetGroup.ItemIndex;

end;


{------------------------------------------------------------------------------}
{ TppDBCalcDialog.SetGroupDescriptions }

procedure TppDBCalcDialog.SetGroupDescriptions(aDescriptions: TStrings);
begin

  cbxResetGroup.Items.Assign(aDescriptions);

end; {procedure, SetGroupDescriptions}


{------------------------------------------------------------------------------}
{ TppDBCalcDialog.GetGroupDescriptions }

function TppDBCalcDialog.GetGroupDescriptions: TStrings;
begin

  Result := cbxResetGroup.Items;

end; {procedure, GetGroupDescriptions}


{------------------------------------------------------------------------------}
{ TppDBCalcDialog.cbxResetGroupKeyPress }

procedure TppDBCalcDialog.cbxResetGroupKeyPress(Sender: TObject; var Key: Char);
begin

  {user entered a group, check validity}
  if (Key = chEnterKey) then
    IsValidGroup;

end;

{------------------------------------------------------------------------------}
{ TppDBCalcDialog.IsValidGroup }

function TppDBCalcDialog.IsValidGroup: Boolean;
var
  liGroup: Integer;

begin

  Result := True;

  if cbxResetGroup.Text = '' then
    cbxResetGroup.ItemIndex := -1
  else
    begin
      liGroup := cbxResetGroup.Items.IndexOf(cbxResetGroup.Text);
      
      if liGroup < 0 then
        MessageDlg(ppLoadStr(333), mtError, [mbOK], 0);
        Result := False;
    end;

end;

{------------------------------------------------------------------------------}
{ TppDBCalcDialog.cbxResetGroupExit }

procedure TppDBCalcDialog.cbxResetGroupExit(Sender: TObject);
begin
  IsValidGroup;
end;

{------------------------------------------------------------------------------}
{ TppDBCalcDialog.LanguageChanged }

procedure TppDBCalcDialog.LanguageChanged;
begin

  Caption               := ppLoadStr(197);
  lblCalcType.Caption   := ppLoadStr(196);
  lblResetGroup.Caption := ppLoadStr(198);
  
  btnOK.Caption         := ppLoadStr(ppMsgOK);
  btnCancel.Caption     := ppLoadStr(ppMsgCancel);

  cbxCalcType.Items.Clear;
  cbxCalcType.Items.Add(ppLoadStr(1028)); {'Count'}
  cbxCalcType.Items.Add(ppLoadStr(1029)); {'Sum'}
  cbxCalcType.Items.Add(ppLoadStr(1030)); {'Minimum'}
  cbxCalcType.Items.Add(ppLoadStr(1031)); {'Maximum'}
  cbxCalcType.Items.Add(ppLoadStr(1032)); {'Average'}

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomDBCalcDialog, TppDBCalcDialog);

finalization

  ppUnRegisterForm(TppCustomDBCalcDialog);

end.
