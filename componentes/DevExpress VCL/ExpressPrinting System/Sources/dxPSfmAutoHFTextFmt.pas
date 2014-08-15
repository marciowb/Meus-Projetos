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

unit dxPSfmAutoHFTextFmt;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ToolWin, dxPSForm;

type                             
  TdxfmAutoText = class(TCustomdxPSForm)
    gbxEnterAutoTextEntriesHere: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    ToolBar: TToolBar;
    lblPreview: TLabel;
    btnAdd: TButton;
    btnDelete: TButton;
    cbxAutoEntries: TComboBox;
    Panel1: TPanel;
    pbxPreview: TPaintBox;
    procedure pbxPreviewPaint(Sender: TObject);
    procedure AutoEntriesClick(Sender: TObject);
    procedure NewAutoTextChange(Sender: TObject);
    procedure NewAutoTextKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cbxAutoEntriesExit(Sender: TObject);
    procedure cbxAutoEntriesEnter(Sender: TObject);
  private
    FHFFunctionList: TStringList;
    FilToolBar: TImageList;
    function GetEntries: TStrings;
    procedure SetEntries(Value: TStrings);
    
    procedure EnableToolbar(Value: Boolean);    
    procedure LoadStrings;
    procedure ToolButtonClick(Sender: TObject);
    procedure UpdateControlsState;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    property Entries: TStrings read GetEntries write SetEntries;
  end;

function dxShowAutoTextDlg(AStrings: TStrings): Boolean;

implementation

{$R *.DFM}

uses
  {$IFDEF DELPHI7} UxTheme, Themes, {$ENDIF} Registry, cxClasses, dxPSCore, 
  dxPSRes, dxPSUtl, dxPsGlbl, dxPgSDlg, dxPSESys, dxPSEvnt, dxPSHFToolBarBld;
    
function dxShowAutoTextDlg(AStrings: TStrings): Boolean;
var
  Dialog: TdxfmAutoText;
begin
  Result := False;
  if AStrings = nil then Exit;
  
  Dialog := TdxfmAutoText.Create(nil);
  with Dialog do 
  try
    Entries := AStrings;
    Result := Execute;
    if Result then
      AStrings.Assign(Entries);
  finally
    Free;
  end;
end;

{ TdxfmAutoText }

constructor TdxfmAutoText.Create(AOwner: TComponent);
begin
  HelpContext := dxhcAutoHFTextEntriesDlg;
  inherited;
  btnHelp.Visible := HelpContext <> 0;
  if not btnHelp.Visible then
  begin
    btnOK.BoundsRect := btnCancel.BoundsRect;
    btnCancel.BoundsRect := btnHelp.BoundsRect;
  end;

  FHFFunctionList := TStringList.Create;
  dxGetHFFunctionsList(FHFFunctionList);

  FilToolBar := TImageList.Create(Self);
  FilToolBar.AllocBy := FHFFunctionList.Count;
  TdxPSHFToolBarBuilder.Build(ToolBar, FilToolBar, False, FHFFunctionList, nil, ToolButtonClick, nil, False);
  ToolBar.Top := ((cbxAutoEntries.Top + cbxAutoEntries.Height) +
    lblPreview.Top - ToolBar.Height) div 2;
  ToolBar.Left := cbxAutoEntries.Left; 
  LoadStrings;
end;

destructor TdxfmAutoText.Destroy;
begin
  FreeAndNil(FHFFunctionList);
  inherited;
end;

function TdxfmAutoText.Execute: Boolean;
begin
  UpdateControlsState;
  Result := ShowModal = mrOK;
end;

procedure TdxfmAutoText.pbxPreviewPaint(Sender: TObject);

  procedure PaintPart(ACanvas: TCanvas; const S: string; var ARect: TRect; AFormat: UINT);
  begin
    DrawText(ACanvas.Handle, PChar(S), Length(S), ARect, 
      DT_TOP or DT_NOPREFIX or AFormat);
  end;

  function GetBorderColor: TColor;
 {$IFDEF DELPHI7} 
  var
    Theme: HTHEME;
    C: COLORREF;
 {$ENDIF}
  begin
   {$IFDEF DELPHI7} 
    if ThemeServices.ThemesEnabled then
    begin
      Theme := ThemeServices.Theme[teEdit];
      if Failed(UxTheme.GetThemeColor(Theme, 0, 0, TMT_BORDERCOLOR, C)) then
        Result := clWindowText
      else
        Result := C;
    end
    else
      Result := C;  
   {$ELSE}
     Result := clWindowText;
   {$ENDIF}
  end;
  
var
  R, R2: TRect;
  S, Part1, Part2, Part3: string;
  Index: Integer;
begin
  with TPaintBox(Sender) do 
  begin
    R := ClientRect;
    Canvas.Brush.Color := GetBorderColor;
    Canvas.FrameRect(R);

    InflateRect(R, -1, -1);
    Canvas.Brush.Color := clWindow;   
    Canvas.FillRect(R);
      
    Canvas.Brush.Style := bsClear;
    Index := cbxAutoEntries.ItemIndex;
    if Index > -1 then
    begin
      InflateRect(R, -2, -2);
      
      S := cbxAutoEntries.Items[Index];
      dxPgsDlg.dxPSSplitAutoHFTextEntry(S, Part1, Part2, Part3);
      R2 := R;
      if Part1 <> '' then 
        PaintPart(Canvas, dxProcessHFString(Part1), R2, DT_LEFT);
      Inc(R2.Left, (R.Right - R.Left) div 3);
      Dec(R2.Right, (R.Right - R.Left) div 3);
      if Part2 <> '' then 
        PaintPart(Canvas, dxProcessHFString(Part2), R2, DT_CENTER);
      OffsetRect(R2, (R.Right - R.Left) div 3, 0);
      if Part3 <> '' then 
        PaintPart(Canvas, dxProcessHFString(Part3), R2, DT_RIGHT);
    end;
  end;  
end;

procedure TdxfmAutoText.AutoEntriesClick(Sender: TObject);
begin
  UpdateControlState;
  pbxPreview.Invalidate;
end;

procedure TdxfmAutoText.NewAutoTextChange(Sender: TObject);
var
  Index: Integer;
begin
  UpdateControlsState;
  Index := cbxAutoEntries.Items.IndexOf(cbxAutoEntries.Text);
  if Index <> -1 then 
    cbxAutoEntries.ItemIndex := Index;
end;

procedure TdxfmAutoText.NewAutoTextKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of 
    VK_RETURN:
      begin
        btnAdd.Click;
        Key := 0;
      end;
    VK_ESCAPE:
      ModalResult := mrCancel;
  end;  
end;

procedure TdxfmAutoText.btnAddClick(Sender: TObject);
begin
  with cbxAutoEntries do 
    Items.Add(Text);
  cbxAutoEntries.Text := '';
  UpdateControlsState;
  ActiveControl := cbxAutoEntries;
end;

procedure TdxfmAutoText.btnDeleteClick(Sender: TObject);
var
  Index: Integer;
begin
  with cbxAutoEntries do
  begin
    Index := ItemIndex;
    if Index > -1 then
    begin
      Items.Delete(Index);
      if Index > Items.Count - 1 then 
        Index := Items.Count - 1;
      if Index > -1 then 
        ItemIndex := Index;
      UpdateControlsState;  
    end;
  end;
end;

procedure TdxfmAutoText.cbxAutoEntriesEnter(Sender: TObject);
begin
  EnableToolbar(True);
end;

procedure TdxfmAutoText.cbxAutoEntriesExit(Sender: TObject);
begin
  EnableToolbar(False);
end;

procedure TdxfmAutoText.ToolButtonClick(Sender: TObject);
begin
  if ActiveControl = cbxAutoEntries then
    cbxAutoEntries.SelText := FHFFunctionList[TTagToInt(TComponent(Sender).Tag)];
end;

function TdxfmAutoText.GetEntries: TStrings;
begin
  Result := cbxAutoEntries.Items;
end;

procedure TdxfmAutoText.SetEntries(Value: TStrings);
begin
  cbxAutoEntries.Items := Value;
end;

procedure TdxfmAutoText.EnableToolbar(Value: Boolean);
var
  I: Integer;
begin
  for I := 0 to ToolBar.ButtonCount - 1 do 
    ToolBar.Buttons[I].Enabled := Value;
  ToolBar.Enabled := Value;
end;

procedure TdxfmAutoText.LoadStrings;
begin
  Caption := cxGetResourceString(@sdxAutoTextDialogCaption);
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
  btnAdd.Caption := cxGetResourceString(@sdxBtnAdd);
  btnDelete.Caption := cxGetResourceString(@sdxBtnDelete);
  gbxEnterAutoTextEntriesHere.Caption := cxGetResourceString(@sdxEnterAutoTextEntriesHere);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));
end;

procedure TdxfmAutoText.UpdateControlsState;
var
  S: string;
  Index: Integer;
begin
  S := cbxAutoEntries.Text;
  Index := cbxAutoEntries.Items.IndexOf(S);
  btnAdd.Enabled := (S <> '') and (Index = -1);
  btnDelete.Enabled := Index > -1;
end;

end.

