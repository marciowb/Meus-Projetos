{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppFmtDlg;

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
  TppFormatDialog = class(TppCustomFormatDialog)
    bvlBorder: TBevel;
    lblDisplayFormat: TLabel;
    edtDisplayFormat: TEdit;
    lbxDisplayFormats: TListBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormActivate(Sender: TObject);
    procedure lbxDisplayFormatsClick(Sender: TObject);
    procedure lbxDisplayFormatsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);

  private

  protected
    function GetDisplayFormat: String; override;
    function GetDisplayFormats: TStrings; override;

    procedure SetDisplayFormat(const aDisplayFormat: String); override;
    procedure SetDisplayFormats(aDisplayFormats: TStrings); override;

  protected
    procedure LanguageChanged; override;

  end;

var
  ppFormatDialog: TppFormatDialog;

implementation


{$R *.DFM}


{------------------------------------------------------------------------------}
{ TppFormatDialog.FormActivate }

procedure TppFormatDialog.FormActivate(Sender: TObject);
begin
  edtDisplayFormat.SetFocus;
end;             

{------------------------------------------------------------------------------}
{ TppFormatDialog.GetDisplayFormat }

function TppFormatDialog.GetDisplayFormat: String;
begin
  Result :=  edtDisplayFormat.Text;

end;

{------------------------------------------------------------------------------}
{ TppFormatDialog.GetDisplayFormats }

function TppFormatDialog.GetDisplayFormats: TStrings;
begin
  Result := lbxDisplayFormats.Items;

end;

{------------------------------------------------------------------------------}
{ TppFormatDialog.SetDisplayFormats }

procedure TppFormatDialog.SetDisplayFormats(aDisplayFormats: TStrings);
begin

  lbxDisplayFormats.Items := aDisplayFormats;

  if (aDisplayFormats.Count = 0) then
    begin
      Height := Height - 123;
      btnOK.Top := btnOK.Top - 123;
      btnCancel.Top := btnCancel.Top - 123;
      bvlBorder.Height := bvlBorder.Height - 128;
      lbxDisplayFormats.Visible := False;
    end;
end;

{------------------------------------------------------------------------------}
{ TppFormatDialog.SetDisplayFormat }

procedure TppFormatDialog.SetDisplayFormat(const aDisplayFormat: String);
begin
  edtDisplayFormat.Text := aDisplayFormat;

end; {procedure, SetDisplayFormat}



{------------------------------------------------------------------------------}
{ TppFormatDialog.lbxDisplayFormatsClick }

procedure TppFormatDialog.lbxDisplayFormatsClick(Sender: TObject);
var
  lsDesc: String;
  lsFormat: String;
  liPos: Integer;
  liIndex: Integer;
begin
  liIndex := lbxDisplayFormats.ItemIndex;

  {get the position of the spacer}
  liPos := Pos(cSpacer, lbxDisplayFormats.Items[liIndex]);

  {get the format description}
  lsDesc := Copy(lbxDisplayFormats.Items[liIndex], 1, liPos - 1);

  {get the format}
  lsFormat := Copy(lbxDisplayFormats.Items[liIndex], liPos + 1, Length(lbxDisplayFormats.Items[liIndex]));

  edtDisplayFormat.Text := lsFormat;
end;

{------------------------------------------------------------------------------}
{ TppFormatDialog.DrawItem }

procedure TppFormatDialog.lbxDisplayFormatsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  lsDesc: String;
  lsFormat: String;
  liPos: Integer;
  lStringBuf: array[0..255] of Char;
begin
  {get the position of the spacer}
  liPos := Pos(cSpacer, lbxDisplayFormats.Items[Index]);

  {get the format description}
  lsDesc := Copy(lbxDisplayFormats.Items[Index], 1, liPos - 1);

  {get the format}
  lsFormat := Copy(lbxDisplayFormats.Items[Index], liPos + 1, Length(lbxDisplayFormats.Items[Index]));

  {clear out Rect}
  lbxDisplayFormats.Canvas.FillRect(Rect);

  {draw format description in first column}
  DrawText(lbxDisplayFormats.Canvas.Handle, StrPCopy(lStringBuf, lsDesc), -1, Rect, dt_SingleLine
           or dt_Left or dt_VCenter);

  {goto next column}
  Rect.Left := 110;

  {draw format in second column }
  DrawText(lbxDisplayFormats.Canvas.Handle, StrPCopy(lStringBuf, lsFormat), -1, Rect, dt_SingleLine
           or dt_Left or dt_VCenter);

end; {procedure, DrawItem}


{------------------------------------------------------------------------------}
{ TppFormatDialog.LanguageChanged }

procedure TppFormatDialog.LanguageChanged;
begin

  Caption := ppLoadStr(200); {'Format'}
  lblDisplayFormat.Caption := ppLoadStr(199); {'Display Format'}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomFormatDialog, TppFormatDialog);

finalization

  ppUnRegisterForm(TppCustomFormatDialog);

end.
