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

unit dxPScxCheckListBoxLnk;

interface

{$I cxVer.inc}

uses
  Classes, Windows, Messages, Controls, Graphics, StdCtrls, ExtCtrls, ComCtrls, 
  Dialogs, dxPSCore, dxPSForm, dxExtCtrls, dxPSBaseGridLnk, dxPSGrLnks, 
  cxCheckListBox, cxLookAndFeelPainters, cxPC, cxControls, cxContainer,
  cxEdit, cxCheckBox, cxLabel, Menus, cxTextEdit, cxButtons, cxGraphics,
  cxMaskEdit, cxDropDownEdit, cxColorComboBox, cxLookAndFeels, cxImageComboBox;

type
  TcxCheckListBoxReportLinkOption = (chlbxoBorder, chlbxoHorzLines, chlbxoFlatCheckMarks);
  TcxCheckListBoxReportLinkOptions = set of TcxCheckListBoxReportLinkOption;
 
  TcxCustomCheckListBoxReportLink = class(TdxCustomListBoxReportLink)
  private
    FOptions: TcxCheckListBoxReportLinkOptions;
    function GetcxCustomCheckListBox: TcxCustomCheckListBox;
    procedure SetOptions(Value: TcxCheckListBoxReportLinkOptions);

    function IsFlatCheckMarks: Boolean;
  protected
    procedure AssignData(ACol, ARow: Integer; ADataItem: TAbstractdxReportCellData); override;
    //function GetCellColor(ACol, ARow: Integer): TColor; override;
    function GetCellFontIndex(ACol, ARow: Integer): Integer; override;
    function GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass; override;
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;
    function IsDrawBorder: Boolean; override;
    function IsDrawHorzLines: Boolean; override;
    procedure SetDrawMode(Value: TdxGridDrawMode); override;

    function GetCustomListBox: TCustomListBox; override;

    property cxCustomCheckListBox: TcxCustomCheckListBox read GetcxCustomCheckListBox;
  public
    procedure Assign(Source: TPersistent); override;
    property Options: TcxCheckListBoxReportLinkOptions read FOptions write SetOptions
      default [chlbxoBorder..chlbxoFlatCheckMarks];
  end;
  
  TcxCheckListBoxReportLink = class(TcxCustomCheckListBoxReportLink)
  private
    function GetCheckListBox: TcxCheckListBox;
  public
    property CheckListBox: TcxCheckListBox read GetCheckListBox;
  published
    property AutoWidth;
    property Color;
    property EndEllipsis;
    property EvenColor;
    property EvenFont;
    property Font;
    property Multiline;
    property OddColor;
    property OddFont;
    property Options;
    property RowAutoHeight;
    property ScaleFonts;
    property SupportedCustomDraw;
    property Transparent;
    property UseCustomPageBreaks;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    property Width;
    
    property OnCustomDrawItem;
    property OnGetCustomPageBreaks;
    property OnInitializeItem;
  end;

  TcxfmCheckListBoxDesignWindow = class(TStandarddxReportLinkDesignWindow)
    PageControl1: TcxPageControl;
    tshOptions: TcxTabSheet;
    tshColor: TcxTabSheet;
    tshFont: TcxTabSheet;
    pnlPreview: TPanel;
    stTransparent: TcxLabel;
    lblGridLinesColor: TcxLabel;
    lblEvenColor: TcxLabel;
    lblDrawMode: TcxLabel;
    lblColor: TcxLabel;
    cxLabel1: TcxLabel;
    chbxTransparent: TcxCheckBox;
    ccbxGridLineColor: TcxColorComboBox;
    ccbxEvenColor: TcxColorComboBox;
    ccbxColor: TcxColorComboBox;
    chbxAutoWidth: TcxCheckBox;
    chbxFlatCheckMarks: TcxCheckBox;
    chbxRowAutoHeight: TcxCheckBox;
    chbxShowBorders: TcxCheckBox;
    chbxShowHorzLines: TcxCheckBox;
    Image5: TImage;
    imgGrid: TImage;
    lblMiscellaneous: TcxLabel;
    lblPreview: TcxLabel;
    lblShow: TcxLabel;
    edFont: TcxTextEdit;
    edEvenFont: TcxTextEdit;
    btnFont: TcxButton;
    btnEvenFont: TcxButton;
    cbxDrawMode: TcxImageComboBox;
    procedure ccbxColorChange(Sender: TObject);
    procedure pbxPreviewPaint(Sender: TObject);
    procedure cbxDrawModeClick(Sender: TObject);
    procedure chbxOptionsClick(Sender: TObject);
    procedure chbxRowAutoHeightClick(Sender: TObject);
    procedure chbxTransparentClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure chbxAutoWidthClick(Sender: TObject);
    procedure stTransparentClick(Sender: TObject);
  private
    FItemCount: Integer;
    FPaintWidth: Integer;
    FPaintHeight: Integer;
    FPreviewBox: TCustomPanel;
    FRectWidth: Integer;
    FRectHeight: Integer;
    procedure CreateControls;
    function GetReportLink: TcxCustomCheckListBoxReportLink;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure DoInitialize; override;
   {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
   {$ENDIF}
    procedure LoadStrings; override;
    procedure PaintPreview(ACanvas: TCanvas; R: TRect); override;
    procedure UpdateControlsState; override;
    procedure UpdatePreview; override;
  public
    constructor Create(AOwner: TComponent); override;
    property ReportLink: TcxCustomCheckListBoxReportLink read GetReportLink;
  end;

const
  cxDefaultCheckListBoxOptions = [chlbxoBorder, chlbxoHorzLines, chlbxoFlatCheckMarks];

  cxCheckListBoxStrings: array[0..4] of string =
    ('Sample Text Row #1', 'Sample Text Row #2', 'Sample Text Row #3', 
     'Sample Text Row #4', 'Sample Text Row #5');
    
implementation

{$R *.dfm}

uses
  SysUtils, Forms, cxClasses, dxPSRes, dxPSGlbl, dxPSUtl, dxPrnDev, dxPScxEditorLnks;

type
  TcxCustomCheckListBoxAccess = class(TcxCustomCheckListBox);
  
{ TdxCheckListBoxReportLink }

procedure TcxCustomCheckListBoxReportLink.Assign(Source: TPersistent);
begin
  if Source is TcxCustomCheckListBoxReportLink then
    Options := TcxCustomCheckListBoxReportLink(Source).Options;
  inherited Assign(Source);  
end;

procedure TcxCustomCheckListBoxReportLink.InternalRestoreDefaults;
begin
  inherited InternalRestoreDefaults; 
  Options := cxDefaultCheckListBoxOptions;
end;

procedure TcxCustomCheckListBoxReportLink.InternalRestoreFromOriginal;
begin
  inherited InternalRestoreFromOriginal;
  if TcxCustomCheckListBoxAccess(cxCustomCheckListBox).LookAndFeel.Kind = lfUltraFlat then
    Options := Options + [chlbxoFlatCheckMarks]
  else
    Options := Options - [chlbxoFlatCheckMarks];
end;

function TcxCustomCheckListBoxReportLink.IsDrawBorder: Boolean;
begin
  Result := chlbxoBorder in Options;
end;

function TcxCustomCheckListBoxReportLink.IsDrawHorzLines: Boolean;
begin
  Result := chlbxoHorzLines in Options;
end;

procedure TcxCustomCheckListBoxReportLink.SetDrawMode(Value: TdxGridDrawMode);
begin
  if Value > gdmOddEven then Value := gdmOddEven;
  inherited;
end;

function TcxCustomCheckListBoxReportLink.GetCustomListBox: TCustomListBox;
begin
  if cxCustomCheckListBox <> nil then
    Result := cxContainer_GetInnerControl(cxCustomCheckListBox) as TCustomListBox
  else
    Result := nil;
end;

procedure TcxCustomCheckListBoxReportLink.AssignData(ACol, ARow: Integer; ADataItem: TAbstractdxReportCellData);
begin
  inherited;
  with TdxReportCellCheckImage(ADataItem) do
  begin
    CheckPos := ccpLeft;
    Checked := TcxCustomCheckListBoxAccess(cxCustomCheckListBox).Items[ARow].State > cbsUnchecked;
    Enabled := (TcxCustomCheckListBoxAccess(cxCustomCheckListBox).Items[ARow].State < cbsGrayed) and 
      TcxCustomCheckListBoxAccess(cxCustomCheckListBox).Items[ARow].Enabled;
    FlatBorder := IsFlatCheckMarks;
    Glyph := TcxCustomCheckListBoxAccess(cxCustomCheckListBox).Glyph;
  end;  
end;

function TcxCustomCheckListBoxReportLink.GetCellFontIndex(ACol, ARow: Integer): Integer;
begin
  Result := inherited GetCellFontIndex(ACol, ARow);
end;

function TcxCustomCheckListBoxReportLink.GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass;
begin
  Result := TdxReportCellCheckImage;
end;

function TcxCustomCheckListBoxReportLink.GetcxCustomCheckListBox: TcxCustomCheckListBox;
begin
  Result := TcxCustomCheckListBox(Component);
end;

procedure TcxCustomCheckListBoxReportLink.SetOptions(Value: TcxCheckListBoxReportLinkOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    LinkModified(True);
  end;
end;

function TcxCustomCheckListBoxReportLink.IsFlatCheckMarks: Boolean;
begin
  Result := chlbxoFlatCheckMarks in Options;
end;

{ TcxCheckListBoxReportLink }

function TcxCheckListBoxReportLink.GetCheckListBox: TcxCheckListBox;
begin
  Result := TcxCheckListBox(Component);
end;

{ TcxfmCheckListBoxDesignWindow }  

constructor TcxfmCheckListBoxDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhcCheckListBoxReportLinkDesigner;
  inherited Create(AOwner);
  CreateControls;
  FItemCount := 5;
  FRectWidth := FPreviewBox.Width - 15;
  FRectHeight := (FPreviewBox.Height - 15) div FItemCount;
  FPaintWidth := FRectWidth + 1;
  FPaintHeight := FItemCount * (FRectHeight + 1);
  PageControl1.ActivePage := PageControl1.Pages[0];
end;

procedure TcxfmCheckListBoxDesignWindow.CreateControls;

  function CreatePreviewPane(AHost: TWinControl; AnOnPaint: TNotifyEvent): TdxPSPaintPanel;
  var
    R: TRect;
  begin
    Result := TdxPSPaintPanel.Create(Self);
    with Result do
    begin
      Parent := AHost;
      R := AHost.BoundsRect;
      OffsetRect(R, -R.Left, -R.Top);
      InflateRect(R, -1, -1);
      BoundsRect := R;
      EdgeInner := esNone;
      EdgeOuter := esNone;
      OnPaint := AnOnPaint
    end;
  end;
  
begin
  FPreviewBox := CreatePreviewPane(pnlPreview, pbxPreviewPaint);
end;

procedure TcxfmCheckListBoxDesignWindow.DoInitialize;
begin
  inherited DoInitialize;

  dxPSSyncDrawModeComboItemIndex(cbxDrawMode, ReportLink.DrawMode);
  chbxShowBorders.Checked := chlbxoBorder in ReportLink.Options;
  chbxShowHorzLines.Checked := chlbxoHorzLines in ReportLink.Options;
  chbxFlatCheckMarks.Checked := chlbxoFlatCheckMarks in ReportLink.Options;
  chbxAutoWidth.Checked := ReportLink.AutoWidth;
  chbxRowAutoHeight.Checked := ReportLink.RowAutoHeight;

  chbxTransparent.Checked := ReportLink.Transparent;
  ccbxColor.ColorValue := ReportLink.Color;
  ccbxEvenColor.ColorValue := ReportLink.EvenColor;
  ccbxGridLineColor.ColorValue := ReportLink.GridLineColor;

  FontInfoToText(ReportLink.Font, edFont);
  FontInfoToText(ReportLink.EvenFont, edEvenFont);
end;

{$IFDEF DELPHI7}
function TcxfmCheckListBoxDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TcxfmCheckListBoxDesignWindow.LoadStrings;
begin
  inherited LoadStrings;
  tshOptions.Caption := cxGetResourceString(@sdxOptions);
  tshFont.Caption := cxGetResourceString(@sdxFonts);
  tshColor.Caption := cxGetResourceString(@sdxColors);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  lblShow.Caption := cxGetResourceString(@sdxShow);
  chbxShowBorders.Caption := cxGetResourceString(@sdxBorderLines);
  chbxShowHorzLines.Caption := cxGetResourceString(@sdxHorzLines);
  
  lblMiscellaneous.Caption := cxGetResourceString(@sdxMiscellaneous);
  chbxFlatCheckMarks.Caption := cxGetResourceString(@sdxFlatCheckMarks);
  chbxAutoWidth.Caption := cxGetResourceSTring(@sdxAutoWidth);
  chbxRowAutoHeight.Caption := cxGetResourceString(@sdxRowAutoHeight);

  lblDrawMode.Caption := cxGetResourceString(@sdxDrawMode);
  dxPSInitalizeDrawModeCombo(cbxDrawMode, [gdmStrict, gdmOddEven]);

  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  lblColor.Caption := cxGetResourceString(@sdxColor);
  lblEvenColor.Caption := cxGetResourceString(@sdxEvenColor);
  lblGridLinesColor.Caption := cxGetResourceString(@sdxGridLinesColor);

  btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  btnEvenFont.Caption := cxGetResourceString(@sdxBtnEvenFont);
end;

procedure TcxfmCheckListBoxDesignWindow.UpdateControlsState;
begin
  inherited UpdateControlsState;
  ccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := ccbxColor.Enabled;
  ccbxEvenColor.Enabled := not chbxTransparent.Checked and
    (ReportLink.DrawMode in [gdmOddEven, gdmChess]);
  lblEvenColor.Enabled := ccbxEvenColor.Enabled;
  
  btnEvenFont.Enabled := ReportLink.DrawMode in [gdmOddEven, gdmChess];
  if ReportLink.DrawMode in [gdmOddEven, gdmChess] then
  begin
    lblColor.Caption := cxGetResourceString(@sdxOddColor);
    btnFont.Caption := cxGetResourceString(@sdxBtnOddFont);
  end
  else
  begin
    lblColor.Caption := cxGetResourceString(@sdxColor);
    btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  end;
end;

procedure TcxfmCheckListBoxDesignWindow.UpdatePreview;
begin
  FPreviewBox.Invalidate;
end;

procedure TcxfmCheckListBoxDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
const
  RowCount = 5;
type
  TdxCheckRowViewInfo = record
    State: TCheckBoxState;
    Text: string;
    Color: TColor;
    Font: TFont;
    Sides: TdxCellSides;
    Rect: TRect;
    BackgroundRect: TRect;
    CheckRect: TRect;
    TextRect: TRect;
  end;
  TdxCheckRowViewInfos = array of TdxCheckRowViewInfo;
  
  procedure CalculateViewInfos(out AViewInfos: TdxCheckRowViewInfos);
  
    procedure CalculateViewInfo(AnIndex: Integer; var AViewInfo: TdxCheckRowViewInfo);
    const
      States: array[0..RowCount - 1] of TCheckBoxState = (
        cbUnchecked, cbChecked, cbGrayed, cbUnchecked, cbChecked
      );
    var
      V: Integer;
    begin
      with AViewInfo do
      begin
        State := States[AnIndex];
        Text := cxCheckListBoxStrings[AnIndex];
        Color := ReportLink.GetCellColor(0, AnIndex);

        Font := TFont.Create;
        Font.Assign(ReportLink.GetCellFont(0, AnIndex));
        Font.Size := 8;

        Sides := csAll;
        if not ReportLink.IsDrawBorder then
        begin
          Sides := Sides - csLeftRight;
          if AnIndex = 0 then Exclude(Sides, csTop);
          if AnIndex >= RowCount - 1 then Exclude(Sides, csBottom);
        end;
        if not ReportLink.IsDrawHorzLines then
        begin
          if AnIndex > 0 then Exclude(Sides, csTop);
          if AnIndex < RowCount - 1 then Exclude(Sides, csBottom);
        end;
        
        Rect := R;
        InflateRect(Rect, -4, -4);
        V := (Rect.Bottom - R.Top) div RowCount;
        Inc(Rect.Top, (V - 1) * AnIndex);
        if AnIndex <> RowCount - 1 then
          Rect.Bottom := Rect.Top + V;
          
        BackgroundRect := Rect;
        InflateRect(BackgroundRect, -1, -1);
        
        CheckRect := BackgroundRect;
        InflateRect(CheckRect, 0, -(CheckRect.Bottom - CheckRect.Top - dxPSGlbl.CheckHeight) div 2);
        Inc(CheckRect.Left, 2);
        CheckRect.Right := CheckRect.Left + dxPSGlbl.CheckWidth;
        
        TextRect := BackgroundRect;
        ACanvas.Font := Font;
        V := ACanvas.TextHeight('Wq');
        InflateRect(TextRect, 0, -(TextRect.Bottom - TextRect.Top - V) div 2);
        TextRect.Left := CheckRect.Right + 4;
      end;  
    end;
    
  var
    I: Integer;
  begin
    SetLength(AViewInfos, RowCount);
    for I := 0 to RowCount - 1 do 
      CalculateViewInfo(I, AViewInfos[I]);
  end;

  procedure DrawCheckRows(const AViewInfos: TdxCheckRowViewInfos);
  
    procedure DrawCheckRow(const AViewInfo: TdxCheckRowViewInfo);

      function GetSideRect(ASide: TdxCellSide): TRect;
      begin
        Result := AViewInfo.Rect;
        with Result do
          case ASide of
            csLeft: 
              Right := Left + 1;
            csTop:
              Bottom := Top + 1;
            csRight:
              Left := Right - 1;
            csBottom:
              Top := Bottom - 1;    
          end;
      end;
      
      procedure DrawSides;
      var
        Side: TdxCellSide;
      begin
        ACanvas.Brush.Style := bsSolid;
        ACanvas.Brush.Color := ReportLink.GridLineColor;

        for Side := Low(TdxCellSide) to High(TdxCellSide) do
        begin
          if Side in AViewInfo.Sides then
            ACanvas.FillRect(GetSideRect(Side));
        end;
      end;

      procedure DrawBackground;
      begin
        ACanvas.Brush.Style := bsSolid;
        ACanvas.Brush.Color := AViewInfo.Color;
        ACanvas.FillRect(AViewInfo.BackgroundRect);
      end;
      
      procedure DrawCheck;
      const
        CheckStateMap: array[TCheckBoxState] of UINT = 
         (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED, DFCS_BUTTON3STATE or DFCS_CHECKED);
        FlatBorderMap: array[Boolean] of UINT = (0, DFCS_FLAT);
      var
        uState: UINT;
      begin
        uState := DFCS_TRANSPARENT or CheckStateMap[AViewInfo.State] or
          FlatBorderMap[ReportLink.IsFlatCheckMarks];
        DrawFrameControl(ACanvas.Handle, AViewInfo.CheckRect, DFC_BUTTON, uState);
      end;

      procedure DrawText;
      var
        R: TRect;
      begin
        ACanvas.Brush.Style := bsClear;
        ACanvas.Font := AViewInfo.Font;
        R := AViewInfo.TextRect;
        ACanvas.TextRect(R, R.Left, R.Top, AViewInfo.Text);
      end;
      
    begin
      DrawSides;
      if not ReportLink.Transparent then
        DrawBackground;
      DrawCheck;
      DrawText;
    end;

  var
    I: Integer;
  begin
    for I := 0 to RowCount - 1 do 
      DrawCheckRow(AViewInfos[I]);
  end;

  procedure FreeViewInfos(var AViewInfos: TdxCheckRowViewInfos);
  
    procedure FreeViewInfo(var AViewInfo: TdxCheckRowViewInfo);
    begin
      FreeAndNil(AViewInfo.Font);
    end;
    
  var
    I: Integer;
  begin
    for I := 0 to RowCount - 1 do 
      FreeViewInfo(AViewInfos[I]);
    SetLength(AViewInfos, 0);
  end;

var
  ViewInfos: TdxCheckRowViewInfos;
begin
  inherited;
  ACanvas.Brush.Color := clWindow;
  
  CalculateViewInfos(ViewInfos);
  try
    DrawCheckRows(ViewInfos);
  finally
    FreeViewInfos(ViewInfos);
  end;
end;
  
procedure TcxfmCheckListBoxDesignWindow.ccbxColorChange(Sender: TObject);
var
  Color: TColor;
begin
  if LockControlsUpdate then Exit;

  Color := TcxColorComboBox(Sender).ColorValue;
  case TTagToInt(TcxColorComboBox(Sender).Tag) of
    0: ReportLink.Color := Color;
    1: ReportLink.EvenColor := Color;
    2: ReportLink.GridLineColor := Color;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmCheckListBoxDesignWindow.pbxPreviewPaint(Sender: TObject);
begin
  with TdxPSPaintPanel(Sender) do
    PaintPreview(Canvas, ClientRect);
end;

procedure TcxfmCheckListBoxDesignWindow.cbxDrawModeClick(Sender: TObject);
begin
  if not LockControlsUpdate then
  begin
    ReportLink.DrawMode := dxPSGetSelectedDrawMode(cbxDrawMode);
    Modified := True;
    UpdatePreview;
  end;
end;

procedure TcxfmCheckListBoxDesignWindow.chbxOptionsClick(Sender: TObject);
var
  Option: TcxCheckListBoxReportLinkOption;
begin
  if LockControlsUpdate then Exit;

  Option := TcxCheckListBoxReportLinkOption(TTagToInt(TcxCheckBox(Sender).Tag));

  with ReportLink do
    if TcxCheckBox(Sender).Checked then 
      Options := Options + [Option]
    else  
      Options := Options - [Option];

  Modified := True;
  UpdatePreview;
end;

procedure TcxfmCheckListBoxDesignWindow.chbxAutoWidthClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.AutoWidth := TcxCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmCheckListBoxDesignWindow.chbxRowAutoHeightClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.RowAutoHeight := TcxCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmCheckListBoxDesignWindow.chbxTransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Transparent := TcxCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmCheckListBoxDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TcxfmCheckListBoxDesignWindow.btnFontClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with dxPSGlbl.FontDialog do 
  begin
    case TTagToInt(TComponent(Sender).Tag) of
      0: Font := ReportLink.Font;
      1: Font := ReportLink.EvenFont;
    end;
    
    if Execute then
    begin
      case TTagToInt(TComponent(Sender).Tag) of
        0:
          begin
            ReportLink.Font := Font;
            FontInfoToText(ReportLink.Font, edFont);
          end;
        1:
          begin
            ReportLink.EvenFont := Font;
            FontInfoToText(ReportLink.EvenFont, edEvenFont);          
          end;
      end;
      Modified := True;
      UpdatePreview;
    end;
  end;  
end;

function TcxfmCheckListBoxDesignWindow.GetReportLink: TcxCustomCheckListBoxReportLink;
begin
  Result := inherited ReportLink as TcxCustomCheckListBoxReportLink;
end;

procedure TcxfmCheckListBoxDesignWindow.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  with PageControl1 do
    for I := 0 to PageControl1.PageCount - 1 do
      if IsAccel(Message.CharCode, Pages[I].Caption) then
      begin
        Message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;
  
procedure TcxfmCheckListBoxDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreview.Parent := TcxPageControl(Sender).ActivePage;
end;

initialization
  dxPSRegisterReportLink(TcxCheckListBoxReportLink, TcxCheckListBox, TcxfmCheckListBoxDesignWindow);
  
finalization
  dxPSUnregisterReportLink(TcxCheckListBoxReportLink, TcxCheckListBox, TcxfmCheckListBoxDesignWindow);

end.
