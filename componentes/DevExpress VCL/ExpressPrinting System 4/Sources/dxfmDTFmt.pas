{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxfmDTFmt;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, dxPSForm, cxControls, cxContainer, cxEdit,
  cxLabel, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxListBox,
  cxGroupBox;

type
  TdxfmDateTimeFormats = class(TCustomdxPSForm)
    btnOK: TcxButton;
    btnCancel: TcxButton;
    btnHelp: TcxButton;
    GroupBox1: TcxGroupBox;
    lblAvailableDateFormats: TcxLabel;
    lblAvailableTimeFormats: TcxLabel;
    btnDefault: TcxButton;
    chbxAutoUpdate: TcxCheckBox;
    lbxDateFormats: TcxListBox;
    lbxTimeFormats: TcxListBox;
    procedure btnDefaultClick(Sender: TObject);
    procedure TimeFormatsChanged(Sender: TObject);
    procedure lblAvailableDateFormatsClick(Sender: TObject);
    procedure lbxDateFormatsClick(Sender: TObject);
    procedure chbxAutoUpdateClick(Sender: TObject);
    procedure lbxDTFormatsDblClick(Sender: TObject);
  private
    FAutoUpdateDateTime: Boolean;
    FControlsUpdating: Boolean;
    FDateFormatIndex: Integer;
    FDateFormats: TStrings;
    FDTFormatIndexChanged: Boolean;
    FModified: Boolean;                      
    FSetDateTimeFormatAsDefault: Boolean;
    FTimeFormatIndex: Integer;
    FTimeFormats: TStrings;

    procedure CheckModified;
    procedure LoadStrings;
    procedure SetDateFormats(Value: TStrings);
    procedure SetTimeFormats(Value: TStrings);
    procedure StartSettings;
    procedure UpdateControlsState;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;

    property AutoUpdateDateTime: Boolean read FAutoUpdateDateTime write FAutoUpdateDateTime;
    property DateFormatIndex: Integer read FDateFormatIndex write FDateFormatIndex;
    property DateFormats: TStrings read FDateFormats write SetDateFormats;
    property SetDateTimeFormatAsDefault: Boolean read FSetDateTimeFormatAsDefault
      write FSetDateTimeFormatAsDefault;
    property TimeFormatIndex: Integer read FTimeFormatIndex write FTimeFormatIndex;
    property TimeFormats: TStrings read FTimeFormats write SetTimeFormats;
  end;

   PdxDateTimeFormatDlgData = ^TdxDateTimeFormatDlgData;
  TdxDateTimeFormatDlgData = record
    AutoUpdateDateTime: Boolean;
    DateFormatIndex: Integer;
    DateFormats: TStrings;
    ShowAsDefaultButton: Boolean;
    SetDateTimeFormatAsDefault: Boolean;
    TimeFormatIndex: Integer;
    TimeFormats: TStrings;
    HelpContext: THelpContext;
  end;

function dxShowDateTimeFormatDlg(var AFormatsDlgData: TdxDateTimeFormatDlgData): Boolean;

implementation

{$R *.DFM}

uses
  Registry, cxClasses, dxExtCtrls, dxPSRes, dxPSGlbl, dxPSUtl, dxPgsDlg;

function dxShowDateTimeFormatDlg(var AFormatsDlgData: TdxDateTimeFormatDlgData): Boolean;

  function CheckFormats: Boolean;
  begin
    with AFormatsDlgData do
      Result := (DateFormats <> nil) and (TimeFormats <> nil) and
        (DateFormatIndex > -1) and (DateFormatIndex < DateFormats.Count) and
        (TimeFormatIndex > -1) and (TimeFormatIndex < TimeFormats.Count - 1);
  end;
  
var
  Dialog: TdxfmDateTimeFormats;
begin
  Result := False;
  if not CheckFormats then Exit;
  
  Dialog := TdxfmDateTimeFormats.Create(nil);
  try
    with AFormatsDlgData do
    begin
      Dialog.AutoUpdateDateTime := AutoUpdateDateTime;
      Dialog.DateFormats := DateFormats;
      Dialog.FDateFormatIndex := DateFormatIndex;
      Dialog.TimeFormats := TimeFormats;
      Dialog.FTimeFormatIndex := TimeFormatIndex;
      Dialog.AutoUpdateDateTime := AutoUpdateDateTime;
      Dialog.btnDefault.Visible := ShowAsDefaultButton;
      if HelpContext <> 0 then 
        Dialog.HelpContext := HelpContext;
    end;
    Result := Dialog.Execute;
    if Result then
      with AFormatsDlgData do
      begin
        DateFormatIndex := Dialog.DateFormatIndex;
        TimeFormatIndex := Dialog.TimeFormatIndex;
        AutoUpdateDateTime := Dialog.AutoUpdateDateTime;
        SetDateTimeFormatAsDefault := Dialog.SetDateTimeFormatAsDefault;
      end;
  finally
    Dialog.Free;
  end;
end;

{ TdxfmDateTimeFormats }

constructor TdxfmDateTimeFormats.Create(AOwner: TComponent);
begin
  inherited;
  HelpContext := dxhcDateTimeFormatDlg;
  btnHelp.Visible := HelpContext <> 0;
  if HelpContext <> 0 then
    BorderIcons := BorderIcons + [biHelp]
  else
  begin
    btnOK.BoundsRect := btnCancel.BoundsRect;
    btnCancel.BoundsRect := btnHelp.BoundsRect;
  end;
  FDateFormats := TStringList.Create;
  FTimeFormats := TStringList.Create;
  LoadStrings;
end;

destructor TdxfmDateTimeFormats.Destroy;
begin
  FreeAndNil(FTimeFormats);
  FreeAndNil(FDateFormats);
  inherited;
end;

procedure TdxfmDateTimeFormats.SetDateFormats(Value: TStrings);
begin
  DateFormats.Assign(Value);
end;

procedure TdxfmDateTimeFormats.SetTimeFormats(Value: TStrings);
begin
  TimeFormats.Assign(Value);
end;

procedure TdxfmDateTimeFormats.UpdateControlsState;
begin
  btnDefault.Enabled := (lbxDateFormats.ItemIndex > -1) and (lbxTimeFormats.ItemIndex > -1);
 // btnOK.Enabled := FModified;
end;

procedure TdxfmDateTimeFormats.CheckModified;
begin
  FModified := True;
  UpdateControlsState;
end;

procedure TdxfmDateTimeFormats.StartSettings;
begin
  FControlsUpdating := True;
  try
    with lbxDateFormats do
    begin
      Items.Clear;
      GetFormatedDateStrings(Date, DateFormats, Items);
      if Items.Count > 0 then ItemIndex := FDateFormatIndex;
    end;
    with lbxTimeFormats do
    begin
      Items.Clear;
      GetFormatedTimeStrings(Time, TimeFormats, Items);
      if (Items.Count > 0) then ItemIndex := FTimeFormatIndex;
    end;
    chbxAutoUpdate.Checked := AutoUpdateDateTime;
  finally
    FControlsUpdating := false;
  end;
  UpdateControlsState;
end;

procedure TdxfmDateTimeFormats.LoadStrings;
begin
  Caption := cxGetResourceString(@sdxDTFormatsCaption);
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
  btnDefault.Caption := cxGetResourceString(@sdxBtnDefault);
  lblAvailableDateFormats.Caption := cxGetResourceString(@sdxDTFormatsAvailableDateFormats);
  lblAvailableTimeFormats.Caption := cxGetResourceString(@sdxDTFormatsAvailableTimeFormats);
  chbxAutoUpdate.Caption := cxGetResourceString(@sdxDTFormatsAutoUpdate);
end;

function TdxfmDateTimeFormats.Execute: Boolean;
begin
  StartSettings;
  FModified := False;
  Result := (ShowModal = mrOK) and FModified;
end;

procedure TdxfmDateTimeFormats.btnDefaultClick(Sender: TObject);
var
  S: string;
begin                
  try
    S := Format(cxGetResourceString(@sdxDTFormatsChangeDefaultFormat), 
      [lbxDateFormats.Items[lbxDateFormats.ItemIndex], 
       lbxTimeFormats.Items[lbxTimeFormats.ItemIndex]]);
    if MessageQuestion(S) then
    begin
      FSetDateTimeFormatAsDefault := True;
      CheckModified;
    end;
  except
    Application.HandleException(Self);
  end;    
end;

procedure TdxfmDateTimeFormats.lbxDateFormatsClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  DateFormatIndex := TcxListBox(Sender).ItemIndex;
  FDTFormatIndexChanged := True;
  CheckModified;
end;

procedure TdxfmDateTimeFormats.TimeFormatsChanged(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  TimeFormatIndex := TcxListBox(Sender).ItemIndex;
  FDTFormatIndexChanged := True;
  CheckModified;
end;

procedure TdxfmDateTimeFormats.chbxAutoUpdateClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  AutoUpdateDateTime := TcxCheckBox(Sender).Checked;
  CheckModified;
end;

procedure TdxfmDateTimeFormats.lblAvailableDateFormatsClick(Sender: TObject);
begin
  ActiveControl := TcxLabel(Sender).FocusControl;
end;

procedure TdxfmDateTimeFormats.lbxDTFormatsDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
