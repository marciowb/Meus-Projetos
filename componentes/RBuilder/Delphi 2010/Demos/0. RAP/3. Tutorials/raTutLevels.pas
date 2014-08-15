{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit raTutLevels;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  { TfrmRapTutorLevelDirectory }
  TfrmRapTutorLevelDirectory = class (TForm)
    btnLevel00: TSpeedButton;
    procedure btnLevel00Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FButtonIndex: Integer;
    FOnButtonClick: TNotifyEvent;
    procedure DoOnButtonClick;
    function GetLevelDescription: string;
  public
    property ButtonIndex: Integer read FButtonIndex;
    property LevelDescription: string read GetLevelDescription;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  end;

var
  frmRapTutorLevelDirectory: TfrmRapTutorLevelDirectory;

implementation

{$R *.DFM}

{ TfrmRapTutorLevelDirectory }

{------------------------------------------------------------------------------}
{ TfrmRapTutorLevelDirectory.btnLevel00Click}
procedure TfrmRapTutorLevelDirectory.btnLevel00Click(Sender: TObject);
begin
  FButtonIndex := TSpeedButton(Sender).Tag;
  
  DoOnButtonClick;
end;{ procedure btnLevel00Click() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorLevelDirectory.DoOnButtonClick}
procedure TfrmRapTutorLevelDirectory.DoOnButtonClick;
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;{ procedure DoOnButtonClick() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorLevelDirectory.FormCreate}
procedure TfrmRapTutorLevelDirectory.FormCreate(Sender: TObject);
begin
  FButtonIndex := 0;
  FOnButtonClick := nil;
end;{ procedure FormCreate() }

{------------------------------------------------------------------------------}
{ TfrmRapTutorLevelDirectory.GetLevelDescription}
function TfrmRapTutorLevelDirectory.GetLevelDescription: string;
var
  lsName: string;
  lLabel: TLabel;
begin
  
  lsName := 'lblLevel' + IntToStr(FButtonIndex);
  lLabel := TLabel(FindComponent(lsName));
  
  Result := lLabel.Caption;
  
end;{ function GetLevelDescription() }

end.
