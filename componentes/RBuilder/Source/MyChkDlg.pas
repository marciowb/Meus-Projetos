{******************************************************************************}
{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit myChkDlg;

interface

uses

  Windows,
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, myChkBox, ExtCtrls;

type
  TfrmChkDlg = class(TForm)
    btnOK: TButton;
    cbxCheckStyle: TComboBox;
    Label1: TLabel;
    btnCancel: TButton;
    edtBooleanTrue: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtBooleanFalse: TEdit;
    Bevel1: TBevel;

    procedure FormCreate(Sender: TObject);

  private
    function  GetCheckStyle: TmyCheckStyleType;
    function  GetBooleanTrue: String;
    function  GetBooleanFalse: String;
    procedure SetBooleanTrue(Value: String);
    procedure SetBooleanFalse(Value: String);
    procedure SetCheckStyle(aStyle: TmyCheckStyleType);

  public
    property CheckStyle: TmyCheckStyleType read GetCheckStyle write SetCheckStyle;
    property BooleanFalse: String read GetBooleanFalse write SetBooleanFalse;
    property BooleanTrue: String read GetBooleanTrue write SetBooleanTrue;

  end;

var
  frmChkDlg: TfrmChkDlg;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmChkDlg.FormCreate }

procedure TfrmChkDlg.FormCreate(Sender: TObject);
begin
  cbxCheckStyle.ItemIndex := 0;
  edtBooleanTrue.Text  := 'True';
  edtBooleanFalse.Text := 'False';
end;

{------------------------------------------------------------------------------}
{ TfrmChkDlg.GetCheckStyle }

function TfrmChkDlg.GetCheckStyle: TmyCheckStyleType;
begin
  Result := TmyCheckStyleType(cbxCheckStyle.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TfrmChkDlg.GetBooleanTrue }

function TfrmChkDlg.GetBooleanTrue: String;
begin
  Result := edtBooleanTrue.Text;
end;

{------------------------------------------------------------------------------}
{ TfrmChkDlg.GetBooleanFalse }

function TfrmChkDlg.GetBooleanFalse: String;
begin
  Result := edtBooleanFalse.Text;
end;

{------------------------------------------------------------------------------}
{ TfrmChkDlg.SetBooleanTrue }

procedure TfrmChkDlg.SetBooleanTrue(Value: String);
begin
  edtBooleanTrue.Text := Value;
end;

{------------------------------------------------------------------------------}
{ TfrmChkDlg.SetBooleanFalse }

procedure TfrmChkDlg.SetBooleanFalse(Value: String);
begin
  edtBooleanFalse.Text := Value;
end;

{------------------------------------------------------------------------------}
{ TfrmChkDlg.SetCheckStyle }

procedure TfrmChkDlg.SetCheckStyle(aStyle: TmyCheckStyleType);
begin
  cbxCheckStyle.ItemIndex := Integer(aStyle);
end; {procedure, SetStyle}


end.
