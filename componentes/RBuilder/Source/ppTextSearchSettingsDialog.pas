{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppTextSearchSettingsDialog;

interface

{$I ppIfDef.pas}

uses

  Classes, Controls, Forms, Graphics, StdCtrls, ComCtrls,
  ExtCtrls, Buttons,
  ppProd,
  ppForms,
  ppDesignerForms,
  ppTextSearchSettings;

type

  {@TppTextSearchSettingsDialog }

  TppTextSearchSettingsDialog = class(TppCustomTextSearchSettingsDialog)
      cbxShowSearchToolbar: TCheckBox;
      rdgStartingPage: TRadioGroup;
      edtSearchString: TEdit;
      Bevel1: TBevel;
      lblSearchString: TLabel;
      cbxCaseSensitive: TCheckBox;
      cbxShowAll: TCheckBox;
      cbxEnabled: TCheckBox;
      btnOK: TButton;
      btnCancel: TButton;
      cbxWholeWord: TCheckBox;
    lblEnabled: TLabel;

      procedure FormCreate(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure btnOKClick(Sender: TObject);
      procedure btnCancelClick(Sender: TObject);
      procedure cbxEnabledClick(Sender: TObject);

    private
      FTextSearchSettings: TppTextSearchSettings;
      FCommitChanges: Boolean;
      FEnabled: Boolean;

      procedure ApplyChanges;
      procedure LoadStateInfo;
      procedure SaveStateInfo;
      procedure ToggleEnable(aValue: Boolean);
      procedure SettingsToControls;
      procedure InternationalizeTheDialog;

    protected

      procedure ReportAssigned; override;
      procedure LanguageChanged; override;

    end;

implementation

{$R *.dfm}

uses
  ppClass, ppTypes, ppUtils, ppIniStorage;
   
{ TppTextSearchSettingsDialog.FormCreate }

procedure TppTextSearchSettingsDialog.FormCreate(Sender: TObject);
begin
  FTextSearchSettings := nil;

  InternationalizeTheDialog;
end;

{ TppTextSearchSettingsDialog.FormClose }

procedure TppTextSearchSettingsDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  SaveStateInfo;

  if FCommitChanges then
    ApplyChanges;

end;

{ TppTextSearchSettingsDialog.btnOKClick }

procedure TppTextSearchSettingsDialog.btnOKClick(Sender: TObject);
begin

  TppCustomReport(Report).Modified := True;

  FCommitChanges := True;

  Close;
end;

{ TppTextSearchSettingsDialog.btnCancelClick }

procedure TppTextSearchSettingsDialog.btnCancelClick(Sender: TObject);
begin
  FCommitChanges := False;

  Close;
end;

{ TppTextSearchSettingsDialog.LoadStateInfo }

procedure TppTextSearchSettingsDialog.LoadStateInfo;
var
  liDefaultLeft: Integer;
  liDefaultTop: Integer;
  lIniStorage: TppIniStorage;
begin

  CalcScreenCenter(liDefaultLeft, liDefaultTop);

  Width := ToCurrentPixelsPerInch(Width);
  Height := ToCurrentPixelsPerInch(Height);

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  try

    Left :=  lIniStorage.ReadInteger('TextSearchSettingsDialog', 'FormLeft', liDefaultLeft);
    Top :=  lIniStorage.ReadInteger('TextSearchSettingsDialog', 'FormTop', liDefaultTop);
    Width := lIniStorage.ReadInteger('TextSearchSettingsDialog', 'FormWidth', Width);
    Height := lIniStorage.ReadInteger('TextSearchSettingsDialog', 'FormHeight', Height);

  finally
    lIniStorage.Free;

  end;

  Width := ToCurrentPixelsPerInch(Width);
  Height := ToCurrentPixelsPerInch(Height);

  SettingsToControls;

  ToggleEnable(FEnabled);

end;

{ TppTextSearchSettingsDialog.SettingsToControls }

procedure TppTextSearchSettingsDialog.SettingsToControls;
begin

  edtSearchString.Text := FTextSearchSettings.DefaultString;
  cbxCaseSensitive.Checked := FTextSearchSettings.CaseSensitive;
  FEnabled := FTextSearchSettings.Enabled;
  cbxShowAll.Checked := FTextSearchSettings.ShowAll;
  cbxWholeWord.Checked := FTextSearchSettings.WholeWord;
  cbxShowSearchToolbar.Checked := FTextSearchSettings.Visible;

  if FTextSearchSettings.SearchFromCurrentPage then
    rdgStartingPage.ItemIndex := 1
  else
    rdgStartingPage.ItemIndex := 0;

end;

{ TppTextSearchSettingsDialog.SaveStateInfo }

procedure TppTextSearchSettingsDialog.SaveStateInfo;
var
  liWidth: Integer;
  liHeight: Integer;
  lIniStorage: TppIniStorage;
begin

  liWidth := FromCurrentPixelsPerInch(Width);
  liHeight := FromCurrentPixelsPerInch(Height);

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  try
    lIniStorage.WriteInteger('TextSearchSettingsDialog', 'FormTop', Top);
    lIniStorage.WriteInteger('TextSearchSettingsDialog', 'FormLeft', Left);
    lIniStorage.WriteInteger('TextSearchSettingsDialog', 'FormWidth', liWidth);
    lIniStorage.WriteInteger('TextSearchSettingsDialog', 'FormHeight', liHeight);

  finally
    lIniStorage.Free;

  end;

end;

{ TppTextSearchSettingsDialog.ReportAssigned }

procedure TppTextSearchSettingsDialog.ReportAssigned;
begin
  FTextSearchSettings := TppProducer(Report).TextSearchSettings;

  FCommitChanges := False;
  FEnabled := FTextSearchSettings.Enabled;
  cbxEnabled.Checked := FEnabled;
  ToggleEnable(FEnabled);

  LoadStateInfo;
end;

{ TppTextSearchSettingsDialog.LanguageChanged }

procedure TppTextSearchSettingsDialog.LanguageChanged;
begin
  InternationalizeTheDialog;
end;
       
{ TppTextSearchSettingsDialog.InternationalizeTheDialog }

procedure TppTextSearchSettingsDialog.InternationalizeTheDialog;
begin

  Caption := ppLoadStr(1150);

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

  cbxShowSearchToolbar.Caption := ppLoadStr(1054);
  rdgStartingPage.Caption := ppLoadStr(1065);
  lblSearchString.Caption := ppLoadStr(1068);
  cbxCaseSensitive.Caption := ppLoadStr(1063);
  cbxShowAll.Caption := ppLoadStr(1062);
  lblEnabled.Caption := ppLoadStr(1066);
  cbxWholeWord.Caption := ppLoadStr(1064);
  rdgStartingPage.Items[0] := ppLoadStr(1057); {'Search From First Page'}
  rdgStartingPage.Items[1] := ppLoadStr(1056); {'Search From Current Page'}
  edtSearchString.Text := ppLoadStr(1069); {<Find Text>}

end;

{TppTextSearchSettingsDialog.ApplyChanges }

procedure TppTextSearchSettingsDialog.ApplyChanges;
begin
  FTextSearchSettings.DefaultString := edtSearchString.Text;
  FTextSearchSettings.CaseSensitive := cbxCaseSensitive.Checked;
  FTextSearchSettings.Enabled := FEnabled;
  FTextSearchSettings.SearchWhenPreview := False;
  FTextSearchSettings.ShowAll := cbxShowAll.Checked;
  FTextSearchSettings.WholeWord := cbxWholeWord.Checked;
  FTextSearchSettings.Visible := cbxShowSearchToolbar.Checked;
  FTextSearchSettings.SearchFromCurrentPage := (rdgStartingPage.ItemIndex = 1);

  TppProducer(Report).TextSearchSettings := FTextSearchSettings;
end;

{TppTextSearchSettingsDialog.ToggleEnable }

procedure TppTextSearchSettingsDialog.ToggleEnable(aValue: Boolean);
begin
  edtSearchString.Enabled := aValue;
  cbxCaseSensitive.Enabled := aValue;
  cbxShowAll.Enabled := aValue;
  cbxWholeWord.Enabled := aValue;
  cbxShowSearchToolbar.Enabled := aValue;
  rdgStartingPage.Enabled := aValue;
  lblSearchString.Enabled := aValue;
end;

{TppTextSearchSettingsDialog.cbxEnabledClick }

procedure TppTextSearchSettingsDialog.cbxEnabledClick(Sender: TObject);
begin

  FEnabled := not(FEnabled);

  ToggleEnable(FEnabled);

end;

initialization
  ppRegisterForm(TppCustomTextSearchSettingsDialog, TppTextSearchSettingsDialog);

finalization
  ppUnRegisterForm(TppCustomTextSearchSettingsDialog);

end.

