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

unit dxPSfmTtl;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, dxPSForm, ImgList, cxControls;

type
  TdxfmReportTitleProperties = class(TCustomdxPSForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    pctlMain: TPageControl;
    tshText: TTabSheet;
    memText: TMemo;
    tshProperties: TTabSheet;
    lblMode: TLabel;
    cbxMode: TComboBox;
    bvlFont: TBevel;
    lblAlignment: TLabel;
    lblTextAlignY: TLabel;
    bvlTransparent: TBevel;
    bvlAlignment: TBevel;
    lblColor: TLabel;
    bvlColorHolder: TBevel;
    lblTextAlignX: TLabel;
    imgFont: TImage;
    cbxTextAlignX: TComboBox;          
    cbxTextAlignY: TComboBox;
    chbxAdjustOnScale: TCheckBox;
    edFont: TEdit;
    btnFont: TButton;
    btnRestoreDefaults: TButton;
    Bevel2: TBevel;
    chbxTransparent: TCheckBox;
    ilAlignments: TImageList;
    lblTransparent: TLabel;
    procedure TitleChanged(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRestoreDefaultsClick(Sender: TObject);
    procedure cbxTextAlignYDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure tshPropertiesResize(Sender: TObject);
    procedure lblTransparentClick(Sender: TObject);
  private
    FActivePage: Integer;  
    FccbxColor: TCustomComboBox;
    FModified: Boolean;
    FReportTitle: TPersistent; {TdxReportTitle}
    procedure SetReportTitle(Value: TPersistent{TdxReportTitle});

    procedure CreateControls;  
    procedure InitializeControls;
    procedure LoadStrings;
    procedure SaveUserInput;
    procedure SetModified(Value: Boolean);
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;

    property Modified: Boolean read FModified write SetModified;
  protected
    procedure BeforeConstruction; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromRegistry(const APath: string); override;
    procedure SaveToRegistry(const APath: string); override;
    
    function Execute: Boolean;
    property ReportTitle: TPersistent{TdxReportTitle} read FReportTitle write SetReportTitle;
  end;
  
function dxShowReportTitlePropertiesDlg(AReportTitle: TPersistent{TdxReportTitle}): Boolean;
  
implementation

{$R *.DFM}

uses
  Registry, cxClasses, dxPSCore, dxPrnDev, dxPSRes, dxPSUtl, dxPSGlbl, 
  dxExtCtrls, cxDrawTextUtils;
  
const 
  sdxActivePage = 'ActivePage'; //Don't Localize

function dxShowReportTitlePropertiesDlg(AReportTitle: TPersistent{TdxReportTitle}): Boolean;
var
  Dialog: TdxfmReportTitleProperties;
begin
  Result := False;
  if AReportTitle = nil then Exit;

  Dialog := TdxfmReportTitleProperties.Create(nil);
  try
    Dialog.ReportTitle := TdxReportTitle(AReportTitle);
    Result := Dialog.Execute;
    if Result then
      AReportTitle.Assign(Dialog.ReportTitle);
  finally
    Dialog.Free;
  end;
end;

procedure PlaceBevel(ABevel: TBevel; AControl: TControl);
var
  RightBound: Integer;
begin
  RightBound := ABevel.BoundsRect.Right;
  ABevel.Left := AControl.Left + AControl.Width + 10;
  ABevel.Width := RightBound - ABevel.Left;
end;

{ TdxfmReportTitleProperties }

constructor TdxfmReportTitleProperties.Create(AOwner: TComponent);
begin
  HelpContext := dxhcTitlePropertiesDlg;
  inherited;
  if HelpContext = 0 then 
  begin
    btnOK.BoundsRect := btnCancel.BoundsRect;
    btnCancel.BoundsRect := btnHelp.BoundsRect;
    btnHelp.Visible := False;
    BorderIcons := BorderIcons - [biHelp];
  end;
  FReportTitle := TdxReportTitle.Create(nil);
  CreateControls;
  LoadStrings;
end;

destructor TdxfmReportTitleProperties.Destroy;
begin
  FreeAndNil(FReportTitle);
  inherited;
end;

function TdxfmReportTitleProperties.Execute: Boolean;
begin
  InitializeControls;
  with pctlMain do 
    ActivePage := Pages[FActivePage];
  Modified := False;
  Result := (ShowModal = mrOK) and Modified;
end;

procedure TdxfmReportTitleProperties.BeforeConstruction;
begin
  inherited;
  Options := Options + [foSizeableDialog];
end;

procedure TdxfmReportTitleProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOK then SaveUserInput;
end;

procedure TdxfmReportTitleProperties.InitializeControls;
begin
  with TdxReportTitle(ReportTitle) do 
  begin
    chbxAdjustOnScale.Checked := AdjustOnReportScale;
    TdxPSColorCombo(FccbxColor).ColorValue := Color;
    FontInfoToText(Font, edFont);
    cbxMode.ItemIndex := Integer(Mode);
    memText.Text := Text;
    cbxTextAlignX.ItemIndex := Integer(TextAlignX);
    cbxTextAlignY.ItemIndex := Integer(TextAlignY);
    chbxTransparent.Checked := Transparent;
    FccbxColor.Enabled := not chbxTransparent.Checked;
  end;
end;

procedure TdxfmReportTitleProperties.SetModified(Value: Boolean);
begin
  if FModified <> Value then 
  begin
    FModified := Value;
    //btnOK.Enabled := Value;
  end;
  FccbxColor.Enabled := not chbxTransparent.Checked;
end;

procedure TdxfmReportTitleProperties.TitleChanged(Sender: TObject);
begin
  FccbxColor.Enabled := not chbxTransparent.Checked;
  Modified := True;    
end;

procedure TdxfmReportTitleProperties.lblTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxfmReportTitleProperties.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ActiveControl = memText) and (Key = VK_ESCAPE) and cxShiftStateMoveOnly(Shift) then
    ModalResult := mrCancel;
end;

procedure TdxfmReportTitleProperties.SetReportTitle(Value: TPersistent{TdxReportTitle});
begin
  FReportTitle.Assign(Value);
end;

procedure TdxfmReportTitleProperties.CreateControls;
begin
  FccbxColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(FccbxColor) do
  begin
    Anchors := bvlColorHolder.Anchors;
    BoundsRect := bvlColorHolder.BoundsRect;
    Parent := tshProperties;
    ColorTypes := [ctPure];
    AutoColor := dxDefaultColor;
    ShowAutoColor := True;
    TabOrder := chbxTransparent.TabOrder + 1;
    OnChange := TitleChanged;
  end;  
  lblColor.FocusControl := FccbxColor;
end;

procedure TdxfmReportTitleProperties.LoadStrings;
begin
  Caption := cxGetResourceString(@sdxReportTitleDlgCaption);
  btnOK.Caption := cxGetResourceString(@sdxBtnOkAccelerated);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
  btnRestoreDefaults.Caption := cxGetResourceString(@sdxBtnRestoreDefaults);
  
  lblMode.Caption := cxGetResourceString(@sdxMode);
  cbxMode.Clear;
  cbxMode.Items.Add(cxGetResourceString(@sdxTitleModeNone));
  cbxMode.Items.Add(cxGetResourceString(@sdxTitleModeOnFirstPage));
  cbxMode.Items.Add(cxGetResourceString(@sdxTitleModeOnEveryTopPage));
    
  tshText.Caption := cxGetResourceString(@sdxText);
  tshProperties.Caption := cxGetResourceString(@sdxProperties);
  lblColor.Caption := cxGetResourceString(@sdxColor);
  PlaceBevel(bvlFont, imgFont);
  btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  chbxAdjustOnScale.Caption := cxGetResourceString(@sdxAdjustOnScale);
  
  lblAlignment.Caption := DropAmpersand(cxGetResourceString(@sdxAlignment));
  PlaceBevel(bvlAlignment, lblAlignment);
  
  lblTextAlignX.Caption := cxGetResourceString(@sdxTextAlignHorz) + ':';
  cbxTextAlignX.Clear;
  cbxTextAlignX.Items.Add(cxGetResourceString(@sdxTextAlignLeft));
  cbxTextAlignX.Items.Add(cxGetResourceString(@sdxTextAlignCenter));
  cbxTextAlignX.Items.Add(cxGetResourceString(@sdxTextAlignRight));    
  
  lblTextAlignY.Caption := cxGetResourceString(@sdxTextAlignVert) + ':'; 
  cbxTextAlignY.Clear;
  cbxTextAlignY.Items.Add(cxGetResourceString(@sdxTextAlignTop));
  cbxTextAlignY.Items.Add(cxGetResourceString(@sdxTextAlignVCenter));
  cbxTextAlignY.Items.Add(cxGetResourceString(@sdxTextAlignBottom));    

  lblTransparent.Caption := cxGetResourceString(@sdxTransparent);
  PlaceBevel(bvlTransparent, lblTransparent);
end;

procedure TdxfmReportTitleProperties.SaveUserInput;
begin
  with TdxReportTitle(FReportTitle) do 
  begin
    AdjustOnReportScale := chbxAdjustOnScale.Checked;
    Color := TdxPSColorCombo(FccbxColor).ColorValue;
    Mode := TdxReportTitleMode(cbxMode.ItemIndex);
    Text := memText.Text;
    TextAlignX := TcxTextAlignX(cbxTextAlignX.ItemIndex);
    TextAlignY := TcxTextAlignY(cbxTextAlignY.ItemIndex);  
    Transparent := chbxTransparent.Checked;
  end;  
end;

procedure TdxfmReportTitleProperties.CMDialogChar(var message: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with pctlMain do
    for I := 0 to PageCount - 1 do
      if IsAccel(message.CharCode, Pages[I].Caption) then
      begin
        message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

procedure TdxfmReportTitleProperties.btnFontClick(Sender: TObject);
begin
  FontDialog.Font := TdxReportTitle(ReportTitle).Font;
  if FontDialog.Execute then
  begin
    TdxReportTitle(ReportTitle).Font := FontDialog.Font;
    FontInfoToText(TdxReportTitle(ReportTitle).Font, edFont);
    TitleChanged(nil);
  end;
end;
  
procedure TdxfmReportTitleProperties.LoadFromRegistry(const APath: string);
begin
  inherited LoadFromRegistry(APath);
  with TRegistry.Create do
  try
    if OpenKey(APath, False) then
    try
      if ValueExists(sdxActivePage) then 
        FActivePage := ReadInteger(sdxActivePage);
    except
      on ERegistryException do
        // ignore
      else
        raise;
    end;  
  finally
    Free;
  end;  
end;

procedure TdxfmReportTitleProperties.SaveToRegistry(const APath: string);
begin
  inherited SaveToRegistry(APath);
  with TRegistry.Create do
  try
    if OpenKey(APath, True) then
    try
      WriteInteger(sdxActivePage, pctlMain.ActivePage.PageIndex);
    except
      on ERegistryException do
        // ignore
      else
        raise;
    end;  
  finally
    Free;
  end;  
end;

procedure TdxfmReportTitleProperties.btnRestoreDefaultsClick(Sender: TObject);
begin
  TdxReportTitle(ReportTitle).RestoreDefaults;
  InitializeControls;
  TitleChanged(nil);
end;

procedure TdxfmReportTitleProperties.cbxTextAlignYDrawItem(Control: TWinControl; 
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  X, Y: Integer;
begin
  with TComboBox(Control) do
  begin
    Canvas.FillRect(Rect);

    ilAlignments.Draw(Canvas, Rect.Left + 1, Rect.Top + 1, 3 * TTagToInt(Tag) + Index, True);

    Inc(Rect.Left, 1 + ilAlignments.Width + 2);
    with Rect do 
    begin
      X := Left;
      Y := Top + (Bottom - Top - Canvas.TextHeight(Items[Index])) div 2;
    end;  
    Canvas.TextRect(Rect, X, Y, Items[Index]);
  end;
end;

procedure TdxfmReportTitleProperties.tshPropertiesResize(Sender: TObject);
const
  MinRightBound = 7;
var
  W: Integer;
begin
  W := TControl(Sender).Width div 2 - cbxTextAlignX.Left;
  cbxTextAlignX.Width := W;

  lblTextAlignY.Left := cbxTextAlignX.Left + W + 12;
  cbxTextAlignY.Left := lblTextAlignY.Left + lblTextAlignY.Width + 
    (cbxTextAlignX.Left - lblTextAlignX.Left - lblTextAlignX.Width);
  if (TControl(Sender).Width - cbxTextAlignY.BoundsRect.Right) < MinRightBound then
    cbxTextAlignY.Left := TControl(Sender).Width - MinRightBound - cbxTextAlignY.Width;
    
  cbxTextAlignY.Width := W;
end;

end.
