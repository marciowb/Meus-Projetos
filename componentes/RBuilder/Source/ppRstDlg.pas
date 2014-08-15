{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppRstDlg;

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

  {@TppDBTextDialog }
  TppDBTextDialog = class(TppCustomDBTextDialog)
    btnOK: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    cbxResetGroup: TComboBox;
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

  end; {class, TppDBTextDialog}

var
  ppDBTextDialog: TppDBTextDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppDBTextDialog.Activate }

procedure TppDBTextDialog.Activate;
begin

  inherited Activate;

   cbxResetGroup.ItemIndex := ResetGroupIndex;

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppDBTextDialog.btnOKClick }

procedure TppDBTextDialog.btnOKClick(Sender: TObject);
begin

   ResetGroupIndex := cbxResetGroup.ItemIndex;

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppDBTextDialog.SetGroupDescriptions }

procedure TppDBTextDialog.SetGroupDescriptions(aDescriptions: TStrings);
begin
  cbxResetGroup.Items.Assign(aDescriptions);
end; {procedure, SetGroupDescriptions}

{------------------------------------------------------------------------------}
{ TppDBTextDialog.GetGroupDescriptions }

function TppDBTextDialog.GetGroupDescriptions: TStrings;
begin
  Result := cbxResetGroup.Items;
end; {procedure, GetGroupDescriptions}

{------------------------------------------------------------------------------}
{ TppDBTextDialog.cbxResetGroupKeyPress }

procedure TppDBTextDialog.cbxResetGroupKeyPress(Sender: TObject; var Key: Char);
begin

  {user entered a group, check validity}
  if (Key = chEnterKey) then
    IsValidGroup;

end; {procedure, cbxResetGroupKeyPress}

{------------------------------------------------------------------------------}
{ TppDBTextDialog.IsValidGroup }

function TppDBTextDialog.IsValidGroup: Boolean;
var
  liGroup: Integer;
begin

  Result := True;

  if cbxResetGroup.Text = '' then
    cbxResetGroup.ItemIndex := -1

  else
    begin
      liGroup := cbxResetGroup.Items.IndexOf(cbxResetGroup.Text);
      
      if (liGroup < 0) then
        begin
          MessageDlg(ppLoadStr(333), mtError, [mbOK], 0);

          Result := False;
        end;

    end;

end; {procedure, IsValidGroup}

{------------------------------------------------------------------------------}
{ TppDBTextDialog.cbxResetGroupExit }

procedure TppDBTextDialog.cbxResetGroupExit(Sender: TObject);
begin
  IsValidGroup;
end; {procedure, cbxResetGroupExit}

{------------------------------------------------------------------------------}
{ TppDBTextDialog.LanguageChanged }

procedure TppDBTextDialog.LanguageChanged;
begin

  Caption := ppLoadStr(198); {'Reset Group'}
  lblResetGroup.Caption := ppLoadStr(198);

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomDBTextDialog, TppDBTextDialog);

finalization

  ppUnRegisterForm(TppCustomDBTextDialog);

end.
