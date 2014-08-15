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

unit dxfmPNFmt;

interface

{$I cxVer.inc}

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, 
  dxPSForm, dxPSGlbl, dxCore, Menus, cxLookAndFeelPainters, cxGraphics,
  cxSpinEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxButtons,
  cxRadioGroup, cxControls, cxContainer, cxEdit, cxLabel, dxExtCtrls;

type
  TdxfmPageNumberFormat = class(TCustomdxPSForm)
    btnOK: TcxButton;
    btnCancel: TcxButton;
    btnHelp: TcxButton;
    lblPageNumberFormat: TcxLabel;
    Bevel2: TcxLabel;
    cbxPageNumberingFormat: TcxComboBox;
    btnDefault: TcxButton;
    rbtnContinueFromPrevSection: TcxRadioButton;
    rbtnStartAt: TcxRadioButton;
    lblPageNumbering: TcxLabel;
    bvlStartAtHolder: TBevel;
    procedure cbxPageNumberingFormatChange(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure lblPageNumberFormatClick(Sender: TObject);
    procedure rbtnStartAtClick(Sender: TObject);
    procedure rbtnContinueFromPrevSectionClick(Sender: TObject);
  private
    FseStartAt: TdxPSValueEdit;
    FAllowContinueFromPrevSection: Boolean;
    FControlsUpdating: Boolean;
    FContinueFromPrevSection: Boolean;
    FModified: Boolean;    
    FPageNumberFormats: TStrings;
    FPageNumberFormat: TdxPageNumberFormat;
    FStartPageIndex: Integer;
    FSetPageNumberingFormatAsDefault: Boolean;
    procedure CheckModified;
    procedure CreateControls;
    procedure Initialize;
    procedure LoadStrings;
    procedure SetContinueFromPrevSection(Value: Boolean);
    procedure SetPageNumberFormats(Value: TStrings);
    procedure StartAtChanged(Sender: TObject);
    procedure StartatExit(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    property AllowContinueFromPrevSection: Boolean read FAllowContinueFromPrevSection write FAllowContinueFromPrevSection;
    property ContinueFromPrevSection: Boolean read FContinueFromPrevSection write SetContinueFromPrevSection;
    property PageNumberFormats: TStrings read FPageNumberFormats write SetPageNumberFormats;
    property PageNumberFormat: TdxPageNumberFormat read FPageNumberFormat write FPageNumberFormat;
    property SetPageNumberingFormatAsDefault: Boolean read FSetPageNumberingFormatAsDefault write FSetPageNumberingFormatAsDefault;
    property StartPageIndex: Integer read FStartPageIndex write FStartPageIndex;
  end;
  
  PdxPageNumberFormatDlgData = ^TdxPageNumberFormatDlgData;
  TdxPageNumberFormatDlgData = record
    PageNumberFormats: TStrings;
    PageNumberFormat: TdxPageNumberFormat;
    ContinueFromPrevSection: Boolean;
    StartPageIndex: Integer;
    AllowContinueFromPrevSection: Boolean;
    ShowAsDefaultButton: Boolean;
    SetPageNumberFormatAsDefault: Boolean;
    HelpContext: THelpContext;
  end;

function dxShowPageNumberFormatDlg(var AFormatsDlgData: TdxPageNumberFormatDlgData): Boolean;

implementation

{$R *.DFM}

uses
  Registry, cxClasses, dxPSRes, dxPSUtl;

function dxShowPageNumberFormatDlg(var AFormatsDlgData: TdxPageNumberFormatDlgData): Boolean;
var
  Dialog: TdxfmPageNumberFormat;
begin
  Result := False;
  if AFormatsDlgData.PageNumberFormats = nil then Exit;
  
  Dialog := TdxfmPageNumberFormat.Create(nil);
  try
    with AFormatsDlgData do
    begin
      Dialog.AllowContinueFromPrevSection := AllowContinueFromPrevSection;
      Dialog.FContinueFromPrevSection := ContinueFromPrevSection;      
      Dialog.PageNumberFormats := PageNumberFormats;
      Dialog.FPageNumberFormat := PageNumberFormat;
      Dialog.FStartPageIndex := StartPageIndex;
      Dialog.btnDefault.Visible := ShowAsDefaultButton;
      if HelpContext <> 0 then 
        Dialog.HelpContext := HelpContext;
    end;
    Result := Dialog.Execute;
    if Result then
      with AFormatsDlgData do
      begin
        PageNumberFormat := TdxPageNumberFormat(Dialog.PageNumberFormat);
        ContinueFromPrevSection := Dialog.ContinueFromPrevSection;
        StartPageIndex := Dialog.StartPageIndex;
        SetPageNumberFormatAsDefault := Dialog.SetPageNumberingFormatAsDefault;
      end;
  finally
    Dialog.Free;
  end;
end;

{ TdxfmPageNumberFormat }

constructor TdxfmPageNumberFormat.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HelpContext := dxhcPageNumberFormatDlg;
  CheckDialogFormHelpContext(Self, btnHelp, btnCancel, btnOK);

  FPageNumberFormats := TStringList.Create;  
  CreateControls;
  LoadStrings;
end;

destructor TdxfmPageNumberFormat.Destroy;
begin
  FreeAndNil(FPageNumberFormats);
  inherited;
end;

function TdxfmPageNumberFormat.Execute: Boolean;
begin
  Initialize;
  FModified := False;
  Result := (ShowModal = mrOK) and FModified;
end;

procedure TdxfmPageNumberFormat.CheckModified;
begin
  FModified := True;
end;

procedure TdxfmPageNumberFormat.CreateControls;
begin
  FseStartAt := TdxPSValueEdit.Create(Self);
  with FseStartAt do
  begin
    Parent := Self;
    TabOrder := rbtnStartAt.TabOrder + 1;
    BoundsRect := bvlStartAtHolder.BoundsRect;
    Properties.MinValue := 1;
    Properties.MaxValue := 10000;
    Properties.OnChange := StartAtChanged;
    OnExit := StartAtExit;
    Value := 1; 
  end;
end;

procedure TdxfmPageNumberFormat.Initialize;
begin
  FControlsUpdating := True;
  try
    with cbxPageNumberingFormat.Properties do
    begin
      Items.BeginUpdate;
      try
        Items.Clear;
        Items := FPageNumberFormats;
        cbxPageNumberingFormat.ItemIndex := Integer(PageNumberFormat);
      finally
        Items.EndUpdate;
      end;
    end;  
    rbtnContinueFromPrevSection.Enabled := AllowContinueFromPrevSection;
    //rbtnStartAt.Enabled := AllowContinueFromPrevSection;
    rbtnContinueFromPrevSection.Checked := ContinueFromPrevSection;
    rbtnStartAt.Checked := not ContinueFromPrevSection;
    
    FseStartAt.ValueType := TdxPSValueType(PageNumberFormat);
    if AllowContinueFromPrevSection and ContinueFromPrevSection then
      FseStartAt.Text := ''
    else
      FseStartAt.Value := StartPageIndex;
  finally
    FControlsUpdating := False;
  end;
end;

procedure TdxfmPageNumberFormat.SetContinueFromPrevSection(Value: Boolean);
begin
  if FContinueFromPrevSection <> Value then 
  begin
    FContinueFromPrevSection := Value;
    FControlsUpdating := True;
    try
      rbtnContinueFromPrevSection.Checked := FContinueFromPrevSection;
      rbtnStartAt.Checked := not FContinueFromPrevSection;    
      if FContinueFromPrevSection then 
        FseStartAt.Text := ''
      else
        FseStartAt.Value := 1;  
    finally
      FControlsUpdating := False;
    end;    
  end;
end;

procedure TdxfmPageNumberFormat.SetPageNumberFormats(Value: TStrings);
begin
  FPageNumberFormats.Assign(Value);
end;

procedure TdxfmPageNumberFormat.LoadStrings;
begin
  Caption := cxGetResourceString(@sdxPNFormatsCaption);
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
  btnDefault.Caption := cxGetResourceString(@sdxBtnDefault);
  lblPageNumberFormat.Caption := cxGetResourceString(@sdxPNFormatsNumberFormat);
  lblPageNumbering.Caption := cxGetResourceString(@sdxPageNumbering);
  rbtnContinueFromPrevSection.Caption := cxGetResourceString(@sdxPNFormatsContinueFromPrevious);
  rbtnStartAt.Caption := cxGetResourceString(@sdxPNFormatsStartAt);
end;

procedure TdxfmPageNumberFormat.cbxPageNumberingFormatChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  FseStartAt.ValueType := TdxPSValueType(TcxComboBox(Sender).ItemIndex);
  FPageNumberFormat := TdxPageNumberFormat(TcxComboBox(Sender).ItemIndex);
  CheckModified;
end;

procedure TdxfmPageNumberFormat.StartAtChanged(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  rbtnStartAt.Checked := True;
  CheckModified;
end;

procedure TdxfmPageNumberFormat.StartAtExit(Sender: TObject);
begin
  FStartPageIndex := TdxPSValueEdit(Sender).Value;
end;

procedure TdxfmPageNumberFormat.btnDefaultClick(Sender: TObject);
var
  S : string;
begin
  S := Format(cxGetResourceString(@sdxPNFormatsChangeDefaultFormat),
    [cbxPageNumberingFormat.Properties.Items[cbxPageNumberingFormat.ItemIndex]]);
  if MessageQuestion(S) then
  begin
    FSetPageNumberingFormatAsDefault := True;
    CheckModified;
  end;  
end;

procedure TdxfmPageNumberFormat.lblPageNumberFormatClick(Sender: TObject);
begin
  ActivateComboBoxControl(Self, TcxLabel(Sender).FocusControl);
end;

procedure TdxfmPageNumberFormat.rbtnStartAtClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  ContinueFromPrevSection := False;
  ActiveControl := FseStartAt;
  CheckModified;
end;

procedure TdxfmPageNumberFormat.rbtnContinueFromPrevSectionClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  ContinueFromPrevSection := True;
  CheckModified;
end;

end.
