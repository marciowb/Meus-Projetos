{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppTmDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ppDB, ppTypes, ppUtils, ppForms;

type


  {@TppTemplateDialog }
  TppTemplateDialog = class(TppCustomTemplateDialog)
    hdrList: THeader;
    lbxTemplates: TListBox;
    btnCancel: TButton;
    btnOK: TButton;
    edtTemplateName: TEdit;
    lblTemplateName: TLabel;
    procedure lbxTemplatesClick(Sender: TObject);
    procedure lbxTemplatesDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    function InitializeTemplateList: Boolean;
    function LocateRecord: Boolean;
    
  protected
    FDataPipeline: TppDataPipeline;

    procedure Activate; override;

    function  GetTemplateName: String; override;
    function  GetTemplateNames: TStrings; override;
    procedure SetDataPipeline(aComponent: TComponent); override;
    procedure SetTemplateName(aTemplateName: String); override;
    procedure SetTemplateNames(aTemplateNames: TStrings); override;

  end;  {class, TppTemplateDialog }

var
  ppTemplateDialog: TppTemplateDialog;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.SetDataPipeline }

procedure TppTemplateDialog.SetDataPipeline(aComponent: TComponent);
begin
  inherited SetDataPipeline(aComponent);

  FDataPipeline := TppDataPipeline(aComponent);
end; {function, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.LocateRecord }

function TppTemplateDialog.LocateRecord: Boolean;
begin
  if (DataPipeline <> nil) then
    Result := FDataPipeline.Locate(NameField, TemplateName,  [pploCaseInsensitive])
  else
    Result := False;
end; {function, LocateRecord}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.GetTemplateName }

function TppTemplateDialog.GetTemplateName: String;
begin
  Result := edtTemplateName.Text;

end; {procedure, GetTemplateName}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.GetTemplateNames }

function TppTemplateDialog.GetTemplateNames: TStrings;
begin
  Result := lbxTemplates.Items;
end; {procedure, GetTemplateNames}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.SetTemplateName }

procedure TppTemplateDialog.SetTemplateName(aTemplateName: String);
begin
  edtTemplateName.Text := aTemplateName;
end; {procedure, SetTemplateName}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.SetTemplateNames }

procedure TppTemplateDialog.SetTemplateNames(aTemplateNames: TStrings);
begin
  lbxTemplates.Items.Assign(aTemplateNames);
end; {procedure, SetTemplateNames}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.Activate }

procedure TppTemplateDialog.Activate;
begin  

  inherited Activate;

  InitializeTemplateList;

  edtTemplateName.SelectAll;

  if DialogType = ppdtOpen then
    begin
      Caption := ppLoadStr(361); {Open}
      btnOK.Caption := ppLoadStr(134); {&Open}
      btnCancel.Caption := ppLoadStr(ppMsgCancel);
    end

  else if DialogType = ppdtSave then
    begin
      Caption := ppLoadStr(362) + ' ' + TemplateName + ' ' +
                 ppLoadStr(38); {Save...As}
      btnOK.Caption := ppLoadStr(138); {&Save}
      btnCancel.Caption := ppLoadStr(ppMsgCancel);
    end;

  hdrList.Sections[0] := ppLoadStr(39); {Name}
  lblTemplateName.Caption := ppLoadStr(39); {Name}

  ActiveControl := edtTemplateName;

end;  {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.lbxTemplatesClick }

procedure TppTemplateDialog.lbxTemplatesClick(Sender: TObject);
begin
  edtTemplateName.Text := lbxTemplates.Items[lbxTemplates.ItemIndex];
end; {procedure, lbxTemplatesClick}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.lbxTemplatesDblClick }

procedure TppTemplateDialog.lbxTemplatesDblClick(Sender: TObject);
begin
  lbxTemplatesClick(Sender);
  btnOK.Click;

end;  {procedure, lbxTemplatesDblClick}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.FormCloseQuery }

procedure TppTemplateDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  lsMessage: String;
  lsMessage1: String;
  lsMessage2: String;
begin

  if (ModalResult = mrCancel) then Exit;


  if TemplateName = '' then
    CanClose := False
  else
    begin
      if (DialogType = ppdtOpen) then
        CanClose := LocateRecord
      else
        CanClose := not(LocateRecord);
    end;

  if not(CanClose) then
    begin
      if (DialogType = ppdtOpen) then
        begin
          {message: Record not found:}
          lsMessage := ppLoadStr(45) + ' ' + TemplateName;

          MessageDlg(lsMessage, mtWarning, [mbOK], 0);
        end
      else
        begin
          {message: <name> already exists.}
          lsMessage1 := ppLoadStr(523);
          lsMessage1 := ppSetMessageParameters(lsMessage1);
          lsMessage1 := Format(lsMessage1, [TemplateName]);

          {message: Replace existing report?}
          lsMessage2 := ppLoadStr(494);

          lsMessage := lsMessage1 + #13#10 + #13#10 + lsMessage2;

          if (MessageDlg(lsMessage, mtWarning, [mbYes, mbNo], 0) = mrNo) then
            CanClose := False
          else
            CanClose := True;
        end;
    end;
end; {procedure, CloseQuery}

{------------------------------------------------------------------------------}
{ TppTemplateDialog.InitializeTemplateList }

function TppTemplateDialog.InitializeTemplateList: Boolean;
var
  liRecords: Longint;
  lList: TStrings;
begin

  liRecords := 0;

  lList := TemplateNames;

  if not FDataPipeline.Active then
    FDataPipeline.Open;
  FDataPipeline.First;

  while not FDataPipeline.EOF do
    begin
      lList.Add(FDataPipeline.GetFieldAsString(NameField));
      Inc(liRecords);
      FDataPipeline.Next;
    end;

  Result := (liRecords > 0);

end; {function, InitializeTemplateList}






end.
