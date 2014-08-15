{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppCDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  Messages, SysUtils, ppTypes, ppForms, ExtCtrls, ppUtils;

type

  {@TppCancelDialog }
  TppCancelDialog = class(TppCustomCancelDialog)
    btnCancel: TButton;
    memMessage: TMemo;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    
  protected
    procedure Activate; override;
    procedure LanguageChanged; override;
    procedure PrintProgressChanged; override;
    
  end; {class, TppCancelDialog}

var
  ppCancelDialog: TppCancelDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppCancelDialog.FormCreate }

procedure TppCancelDialog.FormCreate(Sender: TObject);
begin
  memMessage.Text := '';
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppCancelDialog.Activate }

procedure TppCancelDialog.Activate;
begin

  btnCancel.Enabled := AllowPrintCancel;

  inherited Activate;

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppCancelDialog.FormClose }

procedure TppCancelDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin

end; {procedure, FormClose}

{------------------------------------------------------------------------------}
{ TppCancelDialog.btnCancelClick }

procedure TppCancelDialog.btnCancelClick(Sender: TObject);
begin
  DoOnCancel;

  Close;
end; {procedure, btnCancelClick}

{------------------------------------------------------------------------------}
{ TppCancelDialog.PrintProgressChanged }

procedure TppCancelDialog.PrintProgressChanged;
begin
  memMessage.Text := PrintProgress;
end; {procedure, PrintProgressChanged}

{------------------------------------------------------------------------------}
{ TppCancelDialog.LanguageChanged }

procedure TppCancelDialog.LanguageChanged;
var
  lBitMap: TBitMap;
begin

  Caption := ppLoadStr(24);

  btnCancel.Caption := ppLoadStr(ppMsgCancel);

  {size and center the button based on the caption}
  lBitMap := TBitMap.Create;
  btnCancel.Width := lBitMap.Canvas.TextWidth(btnCancel.Caption) + 30;
  btnCancel.Left := (Width - btnCancel.Width) div 2;
  lBitMap.Free;

end; {procedure, LanguageChanged}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomCancelDialog, TppCancelDialog);

finalization

  ppUnRegisterForm(TppCustomCancelDialog);

end. 
