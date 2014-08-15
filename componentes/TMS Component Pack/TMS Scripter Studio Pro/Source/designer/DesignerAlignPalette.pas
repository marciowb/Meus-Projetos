{***************************************************************************}
{ Scripter Studio Pro Components for Delphi & C++Builder                    }
{ version 1.6.0.1                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit DesignerAlignPalette;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Menus;

{$I ASCRIPT.INC}

type
  TfrmAlignmentPalette = class(TForm)
    sbtLeft: TSpeedButton;
    sbtHorCenter: TSpeedButton;
    sbtHorWinCenter: TSpeedButton;
    sbtHorSpace: TSpeedButton;
    sbtRight: TSpeedButton;
    sbtTop: TSpeedButton;
    sbtVerCenter: TSpeedButton;
    sbtVerSpace: TSpeedButton;
    sbtVerWinCenter: TSpeedButton;
    sbtBottom: TSpeedButton;
    pmnMain: TPopupMenu;
    mniStayOnTop: TMenuItem;
    mniShowHints: TMenuItem;
    mniHide: TMenuItem;
    procedure pmnMainPopup(Sender: TObject);
    procedure mniStayOnTopClick(Sender: TObject);
    procedure mniShowHintsClick(Sender: TObject);
    procedure mniHideClick(Sender: TObject);
    procedure sbtHorClick(Sender: TObject);
    procedure sbtVerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetFlatButtons(AFlat: Boolean);
  end;

implementation

{BJF} {$IFNDEF UseGreatisUnits} {$R *.DFM} {$ENDIF}

uses
  FormDesigner;

procedure TfrmAlignmentPalette.SetFlatButtons(AFlat: Boolean);
var
  i: Integer;
begin
  for i:=0 to Pred(ControlCount) do
    if Controls[i] is TSpeedButton then
      TSpeedButton(Controls[i]).Flat:=AFlat;
end;

procedure TfrmAlignmentPalette.pmnMainPopup(Sender: TObject);
begin
  mniStayOnTop.Checked:=FormStyle=fsStayOnTop;
  mniShowHints.Checked:=ShowHint;
end;

procedure TfrmAlignmentPalette.mniStayOnTopClick(Sender: TObject);
begin
  with mniStayOnTop do
  begin
    Checked:=not Checked;
    if Checked then
    begin
      FormStyle:=fsStayOnTop;
      if Assigned(Self.Owner) then
        with Self.Owner as TAdvCustomFormDesigner do
          AlignmentPalette:=AlignmentPalette+[apStayOnTop];
    end
    else
    begin
      FormStyle:=fsNormal;
      if Assigned(Self.Owner) then
        with Self.Owner as TAdvCustomFormDesigner do
          AlignmentPalette:=AlignmentPalette-[apStayOnTop];
    end;
  end;
end;

procedure TfrmAlignmentPalette.mniShowHintsClick(Sender: TObject);
begin
  with mniShowHints do
  begin
    Checked:=not Checked;
    ShowHint:=Checked;
    if Checked then
    begin
      if Assigned(Self.Owner) then
        with Self.Owner as TAdvCustomFormDesigner do
          AlignmentPalette:=AlignmentPalette+[apShowHints];
    end
    else
    begin
      if Assigned(Self.Owner) then
        with Self.Owner as TAdvCustomFormDesigner do
          AlignmentPalette:=AlignmentPalette-[apShowHints];
    end;
  end;
end;

procedure TfrmAlignmentPalette.mniHideClick(Sender: TObject);
begin
  Hide;
end;

procedure TfrmAlignmentPalette.sbtHorClick(Sender: TObject);
begin
  if Assigned(Owner) then
    (Owner as TAdvCustomFormDesigner).AlignControls(TAlignMode((Sender as TSpeedButton).Tag),amNoChange);
end;

procedure TfrmAlignmentPalette.sbtVerClick(Sender: TObject);
begin
  if Assigned(Owner) then
    (Owner as TAdvCustomFormDesigner).AlignControls(amNoChange,TAlignMode((Sender as TSpeedButton).Tag));
end;

end.
