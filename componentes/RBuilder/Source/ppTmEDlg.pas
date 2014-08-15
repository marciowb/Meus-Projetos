{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppTmEDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ppForms, ppTypes, ppUtils;

type

  {@TppTemplateErrorDialog }
  TppTemplateErrorDialog = class(TppCustomTemplateErrorDialog)
    Bevel1: TBevel;
    lblMessage: TLabel;
    btnIgnore: TButton;
    btnCancel: TButton;
    btnIgnoreAll: TButton;
  protected
    function  GetErrorMessage: String; override;
    procedure SetErrorMessage(aMessage: String); override;
    procedure LanguageChanged; override;

  end; {class, TppTemplateErrorDialog }

var
  ppTemplateErrorDialog: TppTemplateErrorDialog;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TppTemplateErrorDialog.GetErrorMessage }

function  TppTemplateErrorDialog.GetErrorMessage: String;
begin
  Result := lblMessage.Caption;
end;

{------------------------------------------------------------------------------}
{ TppTemplateErrorDialog.SetErrorMessage }

procedure TppTemplateErrorDialog.SetErrorMessage(aMessage: String);
begin
  lblMessage.Caption := aMessage;
end;

{------------------------------------------------------------------------------}
{ TppTemplateErrorDialog.LanguageChanged }

procedure TppTemplateErrorDialog.LanguageChanged;
begin

  Caption := ppLoadStr(418); {Error Reading Template}

  btnIgnore.Caption := ppLoadStr(416);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);
  btnIgnoreAll.Caption := ppLoadStr(417);

end; {procedure, LanguageChanged}



end.
