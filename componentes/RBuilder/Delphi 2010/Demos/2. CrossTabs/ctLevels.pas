{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit ctLevels;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TctLevelDirectory = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
  private
    FOnButtonClick: TNotifyEvent;
    FButtonIndex: Integer;

    procedure DoOnButtonClick;

  public
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
    property ButtonIndex: Integer read FButtonIndex;

  end;

var
  ctLevelDirectory: TctLevelDirectory;

implementation

{$R *.DFM}

procedure TctLevelDirectory.FormCreate(Sender: TObject);
begin
  FButtonIndex := 0;
  FOnButtonClick := nil;
end;

procedure TctLevelDirectory.DoOnButtonClick;
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;

procedure TctLevelDirectory.SpeedButton14Click(Sender: TObject);
begin
  FButtonIndex := TSpeedButton(Sender).Tag;

  DoOnButtonClick;
end;





end.
