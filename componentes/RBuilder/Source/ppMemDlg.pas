{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppMemDlg;

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

  {@TppMemoDialog }
  TppMemoDialog = class(TppCustomMemoDialog)
    memMemo: TMemo;
    btnOK: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    btnLoad: TButton;
    btnSave: TButton;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    FFileName: String;
  protected
    function GetLines: TStrings; override;
    procedure LanguageChanged; override;
    procedure SetLines(aLines: TStrings); override;
  end; {class, TppMemoDialog}

var
  ppMemoDialog: TppMemoDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppMemoDialog.GetLines}

function TppMemoDialog.GetLines: TStrings;
begin
  Result := memMemo.Lines;
end;

{------------------------------------------------------------------------------}
{ TppMemoDialog.SetLines}

procedure TppMemoDialog.SetLines(aLines: TStrings);
begin
  memMemo.Lines.Assign(aLines);

end;

{------------------------------------------------------------------------------}
{ TppMemoDialog.btnLoadClick}

procedure TppMemoDialog.btnLoadClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    begin
      FFileName := dlgOpen.FileName;
      memMemo.Lines.LoadFromFile(dlgOpen.FileName);
    end;

end;

{------------------------------------------------------------------------------}
{ TppMemoDialog.btnSaveClick}

procedure TppMemoDialog.btnSaveClick(Sender: TObject);
begin
  dlgSave.FileName := '*.TXT';

  if dlgSave.Execute then
    begin
       FFileName := dlgSave.FileName;
       memMemo.Lines.SaveToFile(FFileName);
    end;

end;

{------------------------------------------------------------------------------}
{ TppMemoDialog.LanguageChanged}

procedure TppMemoDialog.LanguageChanged;
begin

  Caption := ppLoadStr(211);
  btnLoad.Caption := ppLoadStr(266);
  btnSave.Caption := ppLoadStr(268);
  
  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomMemoDialog, TppMemoDialog);

finalization

  ppUnRegisterForm(TppCustomMemoDialog);

end.
