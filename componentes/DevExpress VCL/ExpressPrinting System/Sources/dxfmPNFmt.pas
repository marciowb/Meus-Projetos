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
  dxPSForm, dxPSGlbl, dxCore;

type
  TdxfmPageNumberFormat = class(TCustomdxPSForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    lblPageNumberFormat: TLabel;
    bvlStartAtHolder: TBevel;
    bvlPageNumbering: TBevel;
    Bevel2: TBevel;
    cbxPageNumberingFormat: TComboBox;
    btnDefault: TButton;
    rbtnContinueFromPrevSection: TRadioButton;
    rbtnStartAt: TRadioButton;
    lblPageNumbering: TLabel;
    Bevel3: TBevel;
    procedure cbxPageNumberingFormatChange(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure lblPageNumberFormatClick(Sender: TObject);
    procedure rbtnStartAtClick(Sender: TObject);
    procedure rbtnContinueFromPrevSectionClick(Sender: TObject);
  private
    FseStartAt: TCustomEdit;
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
  Registry, cxClasses, dxExtCtrls, dxPSRes, dxPSUtl;

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

procedure PlaceBavel(ABevel: TBevel; AControl: TControl);
var
  RightBound: Integer;
begin
  RightBound := ABevel.BoundsRect.Right;
  ABevel.Left := AControl.Left + AControl.Width + 10;
  ABevel.Width := RightBound - ABevel.Left;
end;

type
  TdxIntValueType = (ivtDecimal, ivtLiteral, ivtCapitalLiteral, ivtRoman, ivtCapitalRoman);

  TdxPSValueEdit = class(TdxPSSpinEdit)
  private
    FIntValueType: TdxIntValueType;
    procedure SetIntValueType(Value: TdxIntValueType);
  protected
    function IsValidChar(Key: Char): Boolean; override;
    function GetValue: Extended; override;
    procedure SetValue(NewValue: Extended); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property IntValueType: TdxIntValueType read FIntValueType write SetIntValueType default ivtDecimal;
  end;

constructor TdxPSValueEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIntValueType := ivtDecimal;
  MinValue := 1;
  DefaultValue := 1;
end;

procedure TdxPSValueEdit.SetIntValueType(Value: TdxIntValueType);
var
  V: Integer;
begin
  if FIntValueType <> Value then
  begin
    V := AsInteger;
    FIntValueType := Value;
    AsInteger := V;
  end;
end;

function TdxPSValueEdit.IsValidChar(Key: Char): Boolean;
const 
  RomanChars: string = 'cdilmxv';
  CapitalRomanChars: string = 'CDILMXV';
begin
  if ValueType = svtFloat then 
    Result := inherited IsValidChar(Key)
  else 
    case IntValueType of
      ivtDecimal:
        Result := (Key <> '-') and inherited IsValidChar(Key);
      ivtLiteral:
        Result := dxCharInSet(Key, ['a'..'z']);
      ivtCapitalLiteral:
        Result := dxCharInSet(Key, ['A'..'Z']);
      ivtRoman:
        Result := Pos(Key, RomanChars) <> 0;
      else //ivtCapitalRoman
        Result := Pos(Key, CapitalRomanChars) <> 0;
    end;
end;

function TdxPSValueEdit.GetValue: Extended;
var  
  S: string;
begin
  if (ValueType = svtFloat) or (IntValueType = ivtDecimal) then
    Result := inherited GetValue
  else
    try
      S := Trim(GetValueText);
      if S <> '' then 
        case IntValueType of
          ivtLiteral:
            Result := Chars2Int(S, False);
          ivtCapitalLiteral:
            Result := Chars2Int(S, True);
          ivtRoman:
            Result := Roman2Int(S, False);
          else //ivtCapitalRomans
            Result := Roman2Int(S, True);
        end
      else 
        Result := 1;
      Result := CheckValue(Result);
    except
      Result := Trunc(DefaultValue);
    end;  
end;

procedure TdxPSValueEdit.SetValue(NewValue: Extended);
begin
  if (ValueType = svtFloat) or (IntValueType = ivtDecimal) then
    inherited SetValue(NewValue)
  else
    case IntValueType of
      ivtLiteral:
        Text := Int2Chars(Round(CheckValue(NewValue)), False);
      ivtCapitalLiteral:
        Text := Int2Chars(Round(CheckValue(NewValue)), True);
      ivtRoman:
        Text := Int2Roman(Round(CheckValue(NewValue)), False);
    else //ivtCapitalRoman
      Text := Int2Roman(Round(CheckValue(NewValue)), True);
    end;
end;

{ TdxfmPageNumberFormat }

constructor TdxfmPageNumberFormat.Create(AOwner: TComponent);
begin
  inherited;

  HelpContext := dxhcPageNumberFormatDlg;
  btnHelp.Visible := HelpContext <> 0;
  if HelpContext = 0 then 
  begin
    btnOK.BoundsRect := btnCancel.BoundsRect;
    btnCancel.BoundsRect := btnHelp.BoundsRect;
  end
  else
    BorderIcons := BorderIcons + [biHelp];

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
  with TdxPSValueEdit(FseStartAt) do
  begin
    Parent := Self;
    TabOrder := rbtnStartAt.TabOrder + 1;
    BoundsRect := bvlStartAtHolder.BoundsRect;
    ValueType := svtInteger;
    MinValue := 1;
    MaxValue := 10000;
    Value := 1;
    OnChange := StartAtChanged;
    OnExit := StartAtExit;
  end;
end;

procedure TdxfmPageNumberFormat.Initialize;
begin
  FControlsUpdating := True;
  try
    with cbxPageNumberingFormat do 
    begin                                     
      Items.BeginUpdate;
      try
        Items.Clear;
        Items := FPageNumberFormats;
        ItemIndex := Integer(PageNumberFormat);
      finally
        Items.EndUpdate;
      end;
    end;  
    rbtnContinueFromPrevSection.Enabled := AllowContinueFromPrevSection;
    //rbtnStartAt.Enabled := AllowContinueFromPrevSection;
    rbtnContinueFromPrevSection.Checked := ContinueFromPrevSection;
    rbtnStartAt.Checked := not ContinueFromPrevSection;
    
    TdxPSValueEdit(FseStartAt).IntValueType := TdxIntValueType(PageNumberFormat);
    if AllowContinueFromPrevSection and ContinueFromPrevSection then
      TdxPSValueEdit(FseStartAt).Text := ''
    else
      TdxPSValueEdit(FseStartAt).AsInteger := StartPageIndex;
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
        TdxPSValueEdit(FseStartAt).Text := ''
      else  
        TdxPSValueEdit(FseStartAt).AsInteger := 1;  
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
  PlaceBavel(bvlPageNumbering, lblPageNumbering);
  rbtnContinueFromPrevSection.Caption := cxGetResourceString(@sdxPNFormatsContinueFromPrevious);
  rbtnStartAt.Caption := cxGetResourceString(@sdxPNFormatsStartAt);
end;

procedure TdxfmPageNumberFormat.cbxPageNumberingFormatChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  TdxPSValueEdit(FseStartAt).IntValueType := TdxIntValueType(TComboBox(Sender).ItemIndex);
  FPageNumberFormat := TdxPageNumberFormat(TComboBox(Sender).ItemIndex);
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
  FStartPageIndex := TdxPSSpinEdit(Sender).AsInteger;
end;

procedure TdxfmPageNumberFormat.btnDefaultClick(Sender: TObject);
var
  S : string;
begin
  S := Format(cxGetResourceString(@sdxPNFormatsChangeDefaultFormat),
    [cbxPageNumberingFormat.Items[cbxPageNumberingFormat.ItemIndex]]);
  if MessageQuestion(S) then
  begin
    FSetPageNumberingFormatAsDefault := True;
    CheckModified;
  end;  
end;

procedure TdxfmPageNumberFormat.lblPageNumberFormatClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TComboBox(ActiveControl).DroppedDown := True;
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
