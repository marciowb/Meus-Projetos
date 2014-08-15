{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPgNDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppUtils;

type

  {@TppPageSettingDialog }
  TppPageSettingDialog = class(TppCustomPageSettingDialog)
    lblPageRange: TLabel;
    rdbAll: TRadioButton;
    rdbFirstPage: TRadioButton;
    rdbPages: TRadioButton;
    edtPages: TEdit;
    lblDescription: TLabel;
    bvlPageRange: TBevel;
    rdbLastPage: TRadioButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure edtPagesClick(Sender: TObject);
    procedure edtPagesEnter(Sender: TObject);
    procedure rdbAllClick(Sender: TObject);
    procedure rdbFirstPageClick(Sender: TObject);
    procedure rdbLastPageClick(Sender: TObject);
    procedure rdbPagesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AdjustPositions;
  protected
    procedure Activate; override;
    procedure LanguageChanged; override;
  public
  end; {class, TppPageSettingDialog}

var
  ppPageSettingDialog: TppPageSettingDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.Activate }

procedure TppPageSettingDialog.Activate;
begin

  inherited Activate;

  rdbAll.Checked := False;
  rdbFirstPage.Checked := False;
  rdbLastPage.Checked := False;
  rdbPages.Checked := False;

  case PageSetting of
    psAll:
      rdbAll.Checked := True;

    psFirstPage:
      rdbFirstPage.Checked := True;

    psLastPage:
      rdbLastPage.Checked := True;

    psPageList:
      begin
        rdbPages.Checked := True;
        edtPages.Text := ValidPages;
      end;
  end;

  ClientHeight := bvlPageRange.Top + bvlPageRange.Height + Round(0.0625 * Screen.PixelsPerInch);

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppPageSetting.btnOKClick }

procedure TppPageSettingDialog.btnOKClick(Sender: TObject);
begin
  {set page list}
  if rdbPages.Checked then
    begin
      ppTextToPageList(edtPages.Text, PageList, False);
      
      if (PageList.Count > 0) then
        begin
          ModalResult := mrOK;

          PageSetting := psPageList;

          ValidPages := edtPages.Text;
        end

      else
        {message: 'No pages entered.'}
        ShowMessage(ppLoadStr(32));

    end

  else
    begin

      if rdbFirstPage.Checked then
        PageSetting := psFirstPage

      else if rdbLastPage.Checked then
        PageSetting := psLastPage

      else
        PageSetting := psAll;

      ModalResult := mrOK;
    end;

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.LanguageChanged }

procedure TppPageSettingDialog.LanguageChanged;
begin

  Caption := ppLoadStr(1117); {'Page Setting'}

  lblPageRange.Caption := ppLoadStr(19); {'Page Range'}

  rdbAll.Caption :=  ppLoadStr(3); {'All'}
  rdbFirstPage.Caption :=  '&' + ppLoadStr(13); {'First Page'}
  rdbLastPage.Caption := '&' + ppLoadStr(14); {'Last Page'}
  rdbPages.Caption := ppLoadStr(20); {'Pages'}

  lblDescription.Caption := ppLoadStr(11); {'Enter page numbers and/or page ranges...'}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

  AdjustPositions;

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.AdjustPositions }

procedure TppPageSettingDialog.AdjustPositions;
var
  liBottomSpacer: Integer;
begin

  liBottomSpacer := Trunc(ppFromMMThousandths(2381, utScreenPixels, pprtVertical, nil));

  bvlPageRange.Height := (lblDescription.Top + lblDescription.Height + liBottomSpacer) - bvlPageRange.Top;

end; {procedure, AdjustPositions}

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.edtPagesClick }

procedure TppPageSettingDialog.edtPagesClick(Sender: TObject);
begin
  rdbAll.Checked := False;
  rdbFirstPage.Checked := False;
  rdbLastPage.Checked := False;
  rdbPages.Checked := True;
end;

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.edtPagesEnter }

procedure TppPageSettingDialog.edtPagesEnter(Sender: TObject);
begin
  rdbAll.Checked := False;
  rdbFirstPage.Checked := False;
  rdbLastPage.Checked := False;
  rdbPages.Checked := True;
end;

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.rdbAllClick }

procedure TppPageSettingDialog.rdbAllClick(Sender: TObject);
begin
  rdbAll.Checked := True;
  rdbFirstPage.Checked := False;
  rdbLastPage.Checked := False;
  rdbPages.Checked := False;
  edtPages.Text := '';
end;

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.rdbFirstPageClick }

procedure TppPageSettingDialog.rdbFirstPageClick(Sender: TObject);
begin
  rdbAll.Checked := False;
  rdbFirstPage.Checked := True;
  rdbLastPage.Checked := False;
  rdbPages.Checked := False;
  edtPages.Text := '';
end;

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.rdbLastPageClick }

procedure TppPageSettingDialog.rdbLastPageClick(Sender: TObject);
begin
  rdbAll.Checked := False;
  rdbFirstPage.Checked := False;
  rdbLastPage.Checked := True;
  rdbPages.Checked := False;
  edtPages.Text := '';
end;

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.rdbPagesClick }

procedure TppPageSettingDialog.rdbPagesClick(Sender: TObject);
begin
  rdbAll.Checked := False;
  rdbFirstPage.Checked := False;
  rdbLastPage.Checked := False;
  edtPages.SetFocus;
end;

{------------------------------------------------------------------------------}
{ TppPageSettingDialog.rdbPagesClick }

procedure TppPageSettingDialog.FormCreate(Sender: TObject);
begin
  lblPageRange.Transparent := False;
end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomPageSettingDialog, TppPageSettingDialog);

finalization

  ppUnRegisterForm(TppCustomPageSettingDialog);

end.
