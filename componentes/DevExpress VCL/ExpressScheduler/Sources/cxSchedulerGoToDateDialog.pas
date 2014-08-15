{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressScheduler                                 }
{                                                                    }
{       Copyright (c) 2003-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxSchedulerGoToDateDialog;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, {$IFDEF DELPHI6} Variants, {$ENDIF} Classes, Graphics,
  Controls, Forms, Dialogs, cxLookAndFeelPainters, StdCtrls, cxButtons, cxDropDownEdit,
  cxTextEdit, cxMaskEdit, cxCalendar, cxControls, cxContainer, cxEdit,
  cxGroupBox, cxSchedulerCustomControls;

type
  TfmGoToDateForm = class(TForm)
    cxGroupBox1: TcxGroupBox;
    lbDate: TLabel;
    lbShowIn: TLabel;
    deDate: TcxDateEdit;
    cbShowIn: TcxComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  protected
    procedure FillCombo(AScheduler: TcxCustomScheduler);
    procedure SetCaptions;
  public
    constructor CreateEx(AScheduler: TcxCustomScheduler; ADate: TDateTime); virtual;
    function GetViewMode: TcxSchedulerViewMode;
  end;

var
  fmGoToDateForm: TfmGoToDateForm;

implementation

uses
  cxSchedulerStrs, cxDateUtils, cxClasses, cxScheduler;

{$R *.dfm}

{ TfmGoToDateForm }

constructor TfmGoToDateForm.CreateEx(AScheduler: TcxCustomScheduler; ADate: TDateTime);
begin
  Create(Application);
  if ADate = NullDate then ADate := Date;
  deDate.Date := ADate;
  SetCaptions;
  FillCombo(AScheduler);
end;

function TfmGoToDateForm.GetViewMode: TcxSchedulerViewMode;
begin
  if cbShowIn.ItemIndex < 0 then
    Result := vmDay
  else
    Result :=
      TcxSchedulerViewMode(cbShowIn.Properties.Items.Objects[cbShowIn.ItemIndex]);
end;

procedure TfmGoToDateForm.FillCombo(AScheduler: TcxCustomScheduler);
begin
  with cbShowIn, Properties.Items do
  begin
    BeginUpdate;
    try
      if AScheduler is TcxScheduler then
        with TcxScheduler(AScheduler) do
        begin
          if ViewDay.CanShow then
            AddObject(cxGetResourceString(@scxDayCalendar), Pointer(0));
          if ViewWeek.CanShow then
            AddObject(cxGetResourceString(@scxWeekCalendar), Pointer(1));
          if ViewWeeks.CanShow then
            AddObject(cxGetResourceString(@scxMonthCalendar), Pointer(2));
          if ViewDay.CanShow then
            AddObject(cxGetResourceString(@scxWorkWeekCalendar), Pointer(3));
        end
      else
      begin
        AddObject(cxGetResourceString(@scxDayCalendar), Pointer(0));
        AddObject(cxGetResourceString(@scxWeekCalendar), Pointer(1));
        AddObject(cxGetResourceString(@scxMonthCalendar), Pointer(2));
        AddObject(cxGetResourceString(@scxWorkWeekCalendar), Pointer(3));
      end;
    finally
      EndUpdate;
      if Count > 0 then ItemIndex := 0 else Enabled := False;
    end;
  end;
end;

procedure TfmGoToDateForm.SetCaptions;
begin
  Caption := cxGetResourceString(@scxGoToDateDialogCaption);
  // time
  lbDate.Caption := cxGetResourceString(@scxDate);
  lbShowIn.Caption := cxGetResourceString(@scxShowIn);
  // buttons
  btnOk.Caption := cxGetResourceString(@scxOk);
  btnCancel.Caption := cxGetResourceString(@scxCancel);
end;

end.
