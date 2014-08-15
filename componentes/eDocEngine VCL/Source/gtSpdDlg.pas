{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}
unit gtSpdDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtDlgs, ExtCtrls,
  gtCstSpdEng, gtDocDlg, gtDocResStrs, gtUtils;

type

  TgtSpreadSheetDlg = class(TgtDocumentDlg)
    tsFormatting: TTabSheet;
    gbFormattingOptions: TGroupBox;
    lblColumnSpacing: TLabel;
    lblRowSpacing: TLabel;
    lblScaleX: TLabel;
    lblScaleY: TLabel;
    edColumnSpacing: TEdit;
    edRowSpacing: TEdit;
    edScaleX: TEdit;
    edScaleY: TEdit;
    chkAutoFormatCells: TCheckBox;
    procedure edColumnSpacingKeyPress(Sender: TObject; var Key: Char);
    procedure edKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edRowSpacingKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    procedure Localize; override;
    
  public
    { Public declarations }
  end;

implementation

uses gtCstDocEng;

{$R *.dfm}

{ TgtSpreadSheetDlg }

procedure TgtSpreadSheetDlg.Localize;
begin
  inherited;
  tsFormatting.Caption := StsFormatting;
  chkAutoFormatCells.Caption := SchkAutoFormatCells;
  lblColumnSpacing.Caption := SlblColumnSpacing;
  lblRowSpacing.Caption := SlblRowSpacing;
  lblScaleX.Caption := SlblScaleX;
  lblScaleY.Caption := SlblScaleY;
end;

procedure TgtSpreadSheetDlg.edKeyPress(Sender: TObject; var Key: Char);
begin
  inherited edKeyPress(Sender, Key);
  if (Key = '.') and (Pos('.', TEdit(Sender).Text) <> 0) then
    Key := #0;
end;

procedure TgtSpreadSheetDlg.edColumnSpacingKeyPress(Sender: TObject;
  var Key: Char);
begin
{$IFDEF gtDelphi2009Up}
	if not(SysUtils.CharInSet(Key,['0'..'9', #8, '-'])) then
{$ELSE}
	if not(Key in ['0'..'9', #8, '-']) then
{$ENDIF}

		Key := #0;
end;

procedure TgtSpreadSheetDlg.FormCreate(Sender: TObject);
begin
  inherited;
  {$IFDEF EMailSupport}
  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1 , SlblFormatting);
  {$ELSE}
  lbDocumentDlg.Items.Append(SlblFormatting);
  {$ENDIF}
end;

procedure TgtSpreadSheetDlg.btnOKClick(Sender: TObject);
begin
  with TgtCustomSpreadSheetEngine(Engine) do
  begin
    Preferences.AutoFormatCells := chkAutoFormatCells.Checked;
    Formatting.ColumnSpacing := TgtColumnSpacingRange(StrToInt(
      edColumnSpacing.Text));
    Formatting.RowSpacing := TgtRowSpacingRange(StrToInt(edRowSpacing.Text));
    Formatting.ScaleX := StrToFloat(edScaleX.Text);
    Formatting.ScaleY := StrToFloat(edScaleY.Text);
  end;
	inherited btnOKClick(Sender);
end;

procedure TgtSpreadSheetDlg.FormShow(Sender: TObject);
begin
  inherited;
  with TgtCustomSpreadSheetEngine(Engine) do
  begin
    chkAutoFormatCells.Checked := Preferences.AutoFormatCells;
    chkText.Checked := irText in ItemsToRender;
    chkShape.Checked := irShape in ItemsToRender;
    with Formatting do
    begin
      edColumnSpacing.Text := IntToStr(ColumnSpacing);
      edRowSpacing.Text := IntToStr(RowSpacing);
      edScaleX.Text := FloatToStr(ScaleX);
      edScaleY.Text := FloatToStr(ScaleY);
    end;
  end;
end;

procedure TgtSpreadSheetDlg.edRowSpacingKeyPress(Sender: TObject;
  var Key: Char);
begin
{$IFDEF gtDelphi2009Up}
	if not(SysUtils.CharInSet(Key,['0'..'9', #8, '-'])) then
{$ELSE}
	if not(Key in ['0'..'9', #8, '-']) then
{$ENDIF}


		Key := #0;
end;

end.
