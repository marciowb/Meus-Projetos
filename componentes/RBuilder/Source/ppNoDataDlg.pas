{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppNoDataDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  Messages, SysUtils, ppTypes, ppForms, ExtCtrls, ppUtils;

type

  {@TppNoDataDialog }
  TppNoDataDialog = class(TppCustomCancelDialog)
    btnOK: TButton;
    memMessage: TMemo;

  protected
    procedure LanguageChanged; override;

  end; {class, TppNoDataDialog}

var
  ppNoDataDialog: TppNoDataDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppNoDataDialog.LanguageChanged }

procedure TppNoDataDialog.LanguageChanged;
begin

  Caption := ppLoadStr(1034); {'No Data Found'}

  memMessage.Lines.Text := ppLoadStr(1035); {'No data found for this report.'} 

  btnOK.Caption := ppLoadStr(ppMsgOK);

end; {procedure, LanguageChanged}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomNoDataDialog, TppNoDataDialog);

finalization

  ppUnRegisterForm(TppCustomNoDataDialog);

end. 
