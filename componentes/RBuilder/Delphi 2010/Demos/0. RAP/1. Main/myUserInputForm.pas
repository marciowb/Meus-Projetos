{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit myUserInputForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmMyUserInput = class(TForm)
    pgCtlMain: TPageControl;
    tabStartup: TTabSheet;
    tabMasterRecord: TTabSheet;
    Label1: TLabel;
    ebHeading: TEdit;
    rgDestination: TRadioGroup;
    bnOK: TButton;
    bnCancel: TButton;
    Label2: TLabel;
    lblCompanyName: TLabel;
    cbIncludeAddress: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitDialog(aStartupPage: Boolean; const aDefaultHeading, aCompanyName: String); 
  end;

var
  frmMyUserInput: TfrmMyUserInput;

implementation

{$R *.DFM}

procedure TfrmMyUserInput.FormCreate(Sender: TObject);
begin
  tabStartup.TabVisible := False;
  tabMasterRecord.TabVisible := False;
end;

procedure TfrmMyUserInput.InitDialog(aStartupPage: Boolean;
  const aDefaultHeading, aCompanyName: String);
begin

  if aStartupPage then
    pgCtlMain.ActivePage := tabStartup
  else
    pgCtlMain.ActivePage := tabMasterRecord;

  ebHeading.Text := aDefaultHeading;
  lblCompanyName.Caption := aCompanyName;
  
end;

end.
