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

unit dxFEFDlg;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ExtDlgs, Registry, 
  StdCtrls, ExtCtrls, ComCtrls, Grids, Forms, Menus, Consts, ImgList, dxPSForm, 
  dxBkgnd;

type
  TdxFillAs = (faNone, faTexture, faPattern, faPicture);

  TdxFEFDialog = class(TCustomdxPSForm)
    PageControl1: TPageControl;
    tshTexture: TTabSheet;
    tshPattern: TTabSheet;
    tshPicture: TTabSheet;
    dgTexture: TDrawGrid;
    pnlTextureName: TPanel;
    lblForeground: TLabel;
    lblBackground: TLabel;
    dgPattern: TDrawGrid;
    pnlPatternName: TPanel;
    btnOtherTexture: TButton;
    sbxPicture: TScrollBox;
    pnlPictureName: TPanel;
    btnSelectPicture: TButton;
    cbxPaintMode: TComboBox;
    lblPaintMode: TLabel;
    Bevel4: TBevel;
    pnlPicture: TPanel;
    pbxPicture: TPaintBox;
    btnPreview: TButton;
    btnInvert: TButton;
    bvlForeColorHolder: TBevel;
    bvlBackColorHolder: TBevel;
    pnlPreview: TPanel;
    pbxPreview: TPaintBox;
    lblSample: TLabel;
    btnHelp: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pmPicture: TPopupMenu;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miDelete: TMenuItem;
    miPreview: TMenuItem;
    miLoad: TMenuItem;
    ilMenu: TImageList;
    N2: TMenuItem;
    N3: TMenuItem;
    pnlNoPicture: TPanel;
    procedure dgTextureDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure dgPatternDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SelectPictureClick(Sender: TObject);
    procedure btnOtherTextureClick(Sender: TObject);
    procedure dgTextureClick(Sender: TObject);
    procedure dgPatternClick(Sender: TObject);
    procedure pbxPreviewPaint(Sender: TObject);
    procedure pbxPicturePaint(Sender: TObject);
    procedure cbxColorChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PicturePreviewClick(Sender: TObject);
    procedure cbxPaintModeChange(Sender: TObject);
    procedure lblPaintModeClick(Sender: TObject);
    procedure lblForegroundClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure dgTextureDblClick(Sender: TObject);
    procedure dgPatternDblClick(Sender: TObject);
    procedure dgTextureMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dgPatternMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnInvertClick(Sender: TObject);
    procedure pmPicturePopup(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure miCutClick(Sender: TObject);
  private
    cbxBackColor: TCustomComboBox;
    cbxForeColor: TCustomComboBox;
    FActivePage: Integer;
    FApplied: Boolean;
    FBackground: TdxBackground;
    FbmpPattern: TBitmap;
    FbmpCurrentPattern: TBitmap;
    FbmpTexture: TBitmap;
    FControlsUpdating: Boolean;
    FFirstApplied: Boolean;
    FInitialDir: string;
    FModified: Boolean;
    FOriginalBackground: TdxBackground;
    FOtherPicture: TGraphic;
    FOtherPictureName: string;
    FOtherTexture: TBitmap;
    FOtherTextureName: string;
    FPatternNames: TStringList;
    FPatternWasSelected: Boolean;
    FPicture: TGraphic;
    FPictureExists: Boolean;
    FPreviewWhat: TdxFillAs;
    FTextureWasSelected: Boolean;
    FTextureNames: TStringList;
    FOnApply: TNotifyEvent;

    function GetBackColor: TColor;
    function GetForeColor: TColor;
    function GetOtherPicture(AGraphicClass: TGraphicClass): TGraphic;
    function GetOtherTexture: TBitmap;
    function GetPaintMode: TdxPicturePaintMode;
    function GetPicture: TGraphic;
    function GetSelectWhat: TdxFillAs;
    procedure SetBackColor(Value: TColor);
    procedure SetBackground(Value: TdxBackground);
    procedure SetForeColor(Value: TColor);
    procedure SetOtherTexture(Value: TBitmap);
    procedure SetPaintMode(Value: TdxPicturePaintMode);
    procedure SetPicture(Value: TGraphic);
    procedure SetSelectWhat(Value: TdxFillAs);

    procedure AssignPicture(AImage: TGraphic);
    procedure CheckModified;
    function CopyPattern(I, J: Integer): TBitmap;
    function CopyTexture(I, J: Integer): TBitmap;
    procedure CreateControls;
    procedure DrawSelectedFrame(ADrawGrid: TDrawGrid; Rect: TRect);
    procedure DoApply;
    procedure DoInvertColors;
    procedure FreeAndNilResources;
    function InternalLoadImage(var AImage: TGraphic; const AFileName: string): Boolean;
    procedure LoadImage(var AImage: TGraphic; AWhat: Integer);
    procedure LoadResources;
    procedure MapPatternColors;
    procedure PaintPicture;
    procedure PaintPreview;
    procedure StartSetting;
    procedure SetupDialog;
    procedure UpdateControlsState;

    procedure CMDialogChar(var Msg: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;

    property BackColor: TColor read GetBackColor write SetBackColor;
    property ForeColor: TColor read GetForeColor write SetForeColor;
    property OtherTexture: TBitmap read GetOtherTexture write SetOtherTexture;
    property PaintMode: TdxPicturePaintMode read GetPaintMode write SetPaintMode;
    property Picture: TGraphic read GetPicture write SetPicture;
    property SelectWhat: TdxFillAs read GetSelectWhat write SetSelectWhat;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;

    procedure LoadFromRegistry(const APath: string); override;
    procedure SaveToRegistry(const APath: string); override;

    property Background: TdxBackground read FBackground write SetBackground;
    property OnApply: TNotifyEvent read FOnApply write FOnApply;
  end;

function dxFEFDialog(ABackground: TdxBackground): Boolean;
function StandardGetGraphicClassProc(const AFileName: string): TGraphicClass;

type
  TdxGetGraphicClassProc = function(const AFileName: string): TGraphicClass;

var
  GetGraphicClassProc: TdxGetGraphicClassProc = StandardGetGraphicClassProc;

implementation

{$R *.DFM}

uses
 {$IFDEF USEJPEGIMAGE} 
  Jpeg,
 {$ENDIF}
  ClipBrd, cxClasses, cxGraphics, dxPSGlbl, dxExtCtrls, dxPcPrVw, dxPSPopupMan,
  dxPSImgs, dxPSRes, dxPSUtl;

type
  TdxBackgroundAccess = class(TdxBackground); 
    
const
  PatternCount: TPoint = (X: 8; Y: 6);
  PatternSize: TPoint = (X: 8; Y: 8);
  TextureCount: TPoint = (X: 4; Y: 6);
  TextureSize: TPoint = (X: 64; Y: 64);

  sdxInitialDir = 'InitialDir';                //Don't Localize
  sdxActivePage = 'ActivePage';                //Don't Localize
    
function dxCreateMappedBmp(ASource: TBitmap; const OldColors, NewColors: array of TColor): TBitmap;
var
  I, J, K: Integer;
begin
  Result := TBitmap.Create;
  try
    Result.Width := ASource.Width;
    Result.Height := ASource.Height;
    for I := 0 to ASource.Width - 1 do
      for J := 0 to ASource.Height - 1 do
        for K := Low(OldColors) to High(OldColors) do
          if ASource.Canvas.Pixels[I, J] = OldColors[K] then
          begin
            Result.Canvas.Pixels[I, J] := NewColors[K];
            Break;
          end
          else
            Result.Canvas.Pixels[I, J] := ASource.Canvas.Pixels[I, J];
  except
    Result.Free;
    raise;
  end;
end;

function dxFEFDialog(ABackground: TdxBackground): Boolean;
var
  Dialog: TdxFEFDialog;
  B: TBitmap;
begin
  Result := False;
  if ABackground = nil then Exit;

  Dialog := TdxFEFDialog.Create(nil);
  try
    Dialog.Background := ABackground;
    Dialog.FOriginalBackground := ABackground;
    Dialog.OnApply := TdxBackgroundAccess(ABackground).OnApply;
    Result := Dialog.Execute or not Dialog.FFirstApplied; {at least one time button "Apply" was pressed}
    if Dialog.ModalResult <> mrOK then Exit;
    if Result then
    begin
      ABackground.BkColor := Dialog.BackColor;
      ABackground.Brush.Color := Dialog.ForeColor;
      ABackground.Picture := Dialog.Picture;
      case Dialog.SelectWhat of
        faTexture:
          ABackground.Mode := bmBrushBitmap;
        faPattern:
          begin
            B := TBitmap(ABackground.Picture);
            B.Width := PatternSize.X;
            B.Height := PatternSize.Y;
            B.Canvas.Draw(-Dialog.dgPattern.Col * PatternSize.X, -Dialog.dgPattern.Row * PatternSize.Y, Dialog.FbmpCurrentPattern);
            ABackground.Mode := bmBrushBitmap;
          end;
        faPicture:
          begin
            ABackground.Mode := bmPicture;
            ABackground.PictureMode := Dialog.PaintMode;
          end;
      end;
    end;
  finally
    Dialog.Free;
  end;
end;

function StandardGetGraphicClassProc(const AFileName: string): TGraphicClass;
var
  Extention: string;
begin
  Result := nil;
  Extention := ExtractFileExt(AFileName);
  if CompareText(Extention, '.' + GraphicExtension(TBitmap)) = 0 then
    Result := TBitmap
  else
   {$IFDEF USEJPEGIMAGE}
    if CompareText(Extention, '.' + GraphicExtension(TJpegImage)) = 0 then
      Result := TJpegImage
    else  
   {$ENDIF}
      if CompareText(Extention, '.' + GraphicExtension(TMetafile)) = 0 then
        Result := TMetafile
      else
        if CompareText(Extention, '.wmf') = 0 then
          Result := TMetafile;
end;

{ TdxFEFDialog }

constructor TdxFEFDialog.Create(AOwner: TComponent);
begin
  inherited;
  HelpContext := dxhcFEFDlg;

  FFirstApplied := True;
  CreateControls;
  LoadResources;
  FPreviewWhat := faNone;
  FPatternWasSelected := False;
  FTextureWasSelected := False;
  FPictureExists := False;

  pmPicture.Images := ilMenu;
  miLoad.ImageIndex := 0;
  miPreview.ImageIndex := 1;
  miCut.ImageIndex := 2;
  miCopy.ImageIndex := 3;
  miPaste.ImageIndex := 4;
  miDelete.ImageIndex := 5;

  dxPSPopupMenuController.RegisterControl(sbxPicture);
end;

destructor TdxFEFDialog.Destroy;
begin
  dxPSPopupMenuController.UnregisterControl(sbxPicture);
  FreeAndNil(FPatternNames);
  FreeAndNil(FTextureNames);
  FreeAndNil(FBackground);
  FreeAndNil(FPicture);
  FreeAndNil(FOtherTexture);
  FreeAndNil(FOtherPicture);
  FreeAndNilResources;
  inherited;
end;

procedure TdxFEFDialog.CreateControls;

  function CreateColorCombo(AParent: TWinControl; ASite: TControl; ALabel: TLabel;
    ATabOrder: Integer): TdxPSColorCombo;
  begin
    Result := TdxPSColorCombo.Create(Self);
    with Result do
    begin
      Parent := AParent;
      BoundsRect := ASite.BoundsRect;
      TabOrder := ATabOrder;
      ColorTypes := [ctPure];
      ShowColorName := True;
      ShowCustomColor := False;
      OnChange := cbxColorChange;
    end;
    ALabel.FocusControl := Result;
    ASite.Visible := False;
  end;
  
begin
  cbxForeColor := CreateColorCombo(tshPattern, bvlForeColorHolder, lblForeground, 1);
  cbxBackColor := CreateColorCombo(tshPattern, bvlBackColorHolder, lblBackground, 2);  

  FBackground := TdxBackground.Create;
  FPicture := TBitmap.Create;
  FPatternNames := TStringList.Create;
  FTextureNames := TStringList.Create;
end;

procedure TdxFEFDialog.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.Style := Params.WindowClass.Style or CS_SAVEBITS;
end;

procedure TdxFEFDialog.Loaded;
begin
  inherited Loaded;
  if Screen.PixelsPerInch > 96 then
  begin
    dgTexture.DefaultColWidth := (dgTexture.Width - GetSystemMetrics(SM_CXHSCROLL) - 1) div 4 - 1;
    dgTexture.Width := dgTexture.Width - 1;
    dgTexture.DefaultRowHeight := dgTexture.DefaultColWidth;
    dgTexture.Height := dgTexture.Height - 2;
    dgPattern.Width := dgPattern.Width - dgPattern.Width mod dgPattern.ColCount + 7;
    dgPattern.DefaultColWidth := (dgPattern.Width - 1) div dgPattern.ColCount;
    dgPattern.Height := dgPattern.Height - dgPattern.Height mod dgPattern.RowCount + 11;
    dgPattern.DefaultRowHeight := dgPattern.Height div dgPattern.RowCount;
  end;
  with dgTexture do
    pnlTextureName.SetBounds(Left, BoundsRect.Bottom + 3, Width, pnlTextureName.Height);
  with dgPattern do
    pnlPatternName.SetBounds(Left, BoundsRect.Bottom + 3, Width, pnlPatternName.Height);
  btnInvert.SetBounds(dgPattern.Left, btnInvert.Top, dgPattern.Width, btnInvert.Height);
end;

procedure TdxFEFDialog.CMDialogChar(var Msg: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with PageControl1 do
    for I := 0 to PageCount - 1 do
      if IsAccel(Msg.CharCode, Pages[I].Caption) then
      begin
        Msg.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

procedure TdxFEFDialog.WMCancelMode(var Msg: TWMCancelMode);
begin
  inherited;
  dgPattern.Invalidate;
  dgTexture.Invalidate;
end;

function TdxFEFDialog.Execute: Boolean;
begin
  StartSetting;
  Result := (ShowModal = mrOk) and FModified;
end;

procedure TdxFEFDialog.SetBackground(Value: TdxBackground);
begin
  FBackground.Assign(Value);
  SetupDialog;
  UpdateControlsState;
end;

procedure TdxFEFDialog.SetupDialog;
var
  bmp: TBitmap;
  I, J: Integer;
begin
  FControlsUpdating := True;
  try
    cbxPaintMode.ItemIndex := Integer(Background.PictureMode);
    ForeColor := FBackground.Brush.Color;
    BackColor := FBackground.BkColor;
    if (BackColor = ForeColor) and (ForeColor = clWhite) then 
      ForeColor := clBlack;
    MapPatternColors;
    if FBackground.Picture <> nil then
    begin
      case FBackground.Mode of
        bmNone: ;
        bmBrush: ;
        bmBrushBitmap:
          begin
            PageControl1.ActivePage := tshPattern;
            for I := 0 to PatternCount.X - 1 do
              for J := 0 to PatternCount.Y - 1 do
              begin
                bmp := CopyPattern(I, J);
                try
                  if dxAreGraphicsEqual(Bmp, FBackground.Picture) then
                  begin
                    FPatternWasSelected := True;
                    dgPattern.Col := I;
                    dgPattern.Row := J;
                    FPicture.Assign(TBitmap(FBackground.Picture));
                    FPreviewWhat := faPattern;
                    dgPatternClick(dgPattern);
                  end;
                finally
                  bmp.Free;
                end;
              end;

            PageControl1.ActivePage := tshTexture;
            for I := 0 to TextureCount.X - 1 do
              for J := 0 to TextureCount.Y - 1 do
              begin
                bmp := CopyTexture(I, J);
                try
                  if dxAreBitmapsEqual(bmp, TBitmap(FBackground.Picture)) then
                  begin
                    FTextureWasSelected := True;
                    dgTexture.Col := I;
                    dgTexture.Row := J;
                    if (dgTexture.Row > 2) then dgTexture.TopRow := dgTexture.Row - 2;
                    FPicture.Assign(TBitmap(FBackground.Picture));
                    FPreviewWhat := faTexture;
                    dgTextureClick(dgTexture);
                  end;
                finally
                  bmp.Free;
                end;
              end;
          end;

        bmPicture:
          begin
            FPicture.Assign(TBitmap(FBackground.Picture));
            GetOtherPicture(TGraphicClass(FBackground.Picture.ClassType)).Assign(FBackground.Picture);
            FPictureExists := True;
            FPreviewWhat := faPicture;
            PageControl1.ActivePage := tshPicture;
            PaintPicture;
          end;
      end;
    end;
  finally
    FControlsUpdating := False;
  end;
  pbxPreview.Invalidate;
end;

procedure TdxFEFDialog.UpdateControlsState;
var
  b: Boolean;
begin
  b := FModified and (FPicture <> nil) and not FPicture.Empty;
  
  btnApply.Visible := Assigned(OnApply);
  btnApply.Enabled := b and not FApplied;
 // btnOK.Enabled := b;
  btnInvert.Enabled := BackColor <> ForeColor;
  pnlNoPicture.Visible := FOtherPicture = nil;
  btnPreview.Enabled := (FOtherPicture <> nil) and
    ((FOtherPicture.Width > sbxPicture.ClientWidth) or
    (FOtherPicture.Height > sbxPicture.ClientHeight));
  cbxPaintMode.Enabled := FOtherPicture <> nil;
  lblPaintMode.Enabled := FOtherPicture <> nil;
end;

procedure TdxFEFDialog.CheckModified;
begin
  if not FModified then FModified := True;
  FApplied := False;
  UpdateControlsState;
end;

procedure TdxFEFDialog.StartSetting;
begin
  FModified := False;
  FControlsUpdating := True;
  try
    with PageControl1 do
      ActivePage := Pages[FActivePage];
    btnHelp.Visible := HelpContext <> 0;
  finally
    UpdateControlsState;
    FControlsUpdating := False;
  end;
end;

procedure TdxFEFDialog.LoadResources;
var
  Index: Integer;
begin
  FbmpPattern := TBitmap.Create;
  FbmpPattern.Width := PatternCount.X * PatternSize.X;
  FbmpPattern.Height := PatternCount.Y * PatternSize.Y;
  Bitmap_LoadFromResourceName(FbmpPattern, IDB_DXPSBKPATTERNS);

  FbmpTexture := TBitmap.Create;
  FbmpTexture.Width := TextureCount.X * TextureSize.X;
  FbmpTexture.Height := TextureCount.Y * TextureSize.Y;
  Bitmap_LoadFromResourceName(FbmpTexture, IDB_DXPSBKTEXTURES);

  miLoad.Caption := cxGetResourceString(@sdxMenuLoad);
  miPreview.Caption := cxGetResourceString(@sdxMenuPreview);
  miCut.Caption := cxGetResourceString(@sdxMenuEditCut);
  miCopy.Caption := cxGetResourceString(@sdxMenuEditCopy);
  miPaste.Caption := cxGetResourceString(@sdxMenuEditPaste);
  miDelete.Caption := cxGetResourceString(@sdxMenuEditDelete);

  tshTexture.Caption := cxGetResourceString(@sdxTexture);
  tshPattern.Caption := cxGetResourceString(@sdxPattern);
  tshPicture.Caption := cxGetResourceString(@sdxPicture);

  btnOtherTexture.Caption := cxGetResourceString(@sdxBtnOtherTexture);
  lblForeground.Caption := cxGetResourceString(@sdxForeground);
  lblBackground.Caption := cxGetResourceString(@sdxBackground);
  btnInvert.Caption := cxGetResourceString(@sdxBtnInvertColors);
  pnlNoPicture.Caption := cxGetResourceString(@sdxThereIsNoPictureToDisplay);
  btnPreview.Caption := cxGetResourceString(@sdxBtnPreview);
  btnSelectPicture.Caption := cxGetResourceString(@sdxBtnSelectPicture);
  lblPaintMode.Caption := cxGetResourceString(@sdxPaintMode);
  lblSample.Caption := cxGetResourceString(@sdxSample);
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnApply.Caption := cxGetResourceString(@sdxBtnApply);
  Caption := cxGetResourceString(@sdxFEFCaption);

  Index := cbxPaintMode.ItemIndex;
  with cbxPaintMode do
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      Items.Add(cxGetResourceString(@sdxPaintModeCenter));
      Items.Add(cxGetResourceString(@sdxPaintModeStretch));
      Items.Add(cxGetResourceString(@sdxPaintModeTile));
      Items.Add(cxGetResourceString(@sdxPaintModeProportional));
    finally
      Items.EndUpdate;
    end;
  end;
  cbxPaintMode.ItemIndex := Index;

  with FPatternNames do
  begin
    BeginUpdate;
    try
      Clear;
      Add(cxGetResourceString(@sdxPatternGray5));
      Add(cxGetResourceString(@sdxPatternGray10));
      Add(cxGetResourceString(@sdxPatternGray20));
      Add(cxGetResourceString(@sdxPatternGray25));
      Add(cxGetResourceString(@sdxPatternGray30));
      Add(cxGetResourceString(@sdxPatternGray40));
      Add(cxGetResourceString(@sdxPatternGray50));
      Add(cxGetResourceString(@sdxPatternGray60));
      Add(cxGetResourceString(@sdxPatternGray70));
      Add(cxGetResourceString(@sdxPatternGray75));
      Add(cxGetResourceString(@sdxPatternGray80));
      Add(cxGetResourceString(@sdxPatternGray90));
      Add(cxGetResourceString(@sdxPatternLightDownwardDiagonal));
      Add(cxGetResourceString(@sdxPatternLightUpwardDiagonal));
      Add(cxGetResourceString(@sdxPatternDarkDownwardDiagonal));
      Add(cxGetResourceString(@sdxPatternDarkUpwardDiagonal));
      Add(cxGetResourceString(@sdxPatternWideDownwardDiagonal));
      Add(cxGetResourceString(@sdxPatternWideUpwardDiagonal));
      Add(cxGetResourceString(@sdxPatternLightVertical));
      Add(cxGetResourceString(@sdxPatternLightHorizontal));
      Add(cxGetResourceString(@sdxPatternNarrowVertical));
      Add(cxGetResourceString(@sdxPatternNarrowHorizontal));
      Add(cxGetResourceString(@sdxPatternDarkVertical));
      Add(cxGetResourceString(@sdxPatternDarkHorizontal));
      Add(cxGetResourceString(@sdxPatternDashedDownward));
      Add(cxGetResourceString(@sdxPatternDashedUpward));
      Add(cxGetResourceString(@sdxPatternDashedHorizontal));
      Add(cxGetResourceString(@sdxPatternDashedVertical));
      Add(cxGetResourceString(@sdxPatternSmallConfetti));
      Add(cxGetResourceString(@sdxPatternLargeConfetti));
      Add(cxGetResourceString(@sdxPatternZigZag));
      Add(cxGetResourceString(@sdxPatternWave));
      Add(cxGetResourceString(@sdxPatternDiagonalBrick));
      Add(cxGetResourceString(@sdxPatternHorizantalBrick));
      Add(cxGetResourceString(@sdxPatternWeave));
      Add(cxGetResourceString(@sdxPatternPlaid));
      Add(cxGetResourceString(@sdxPatternDivot));
      Add(cxGetResourceString(@sdxPatternDottedGrid));
      Add(cxGetResourceString(@sdxPatternDottedDiamond));
      Add(cxGetResourceString(@sdxPatternShingle));
      Add(cxGetResourceString(@sdxPatternTrellis));
      Add(cxGetResourceString(@sdxPatternSphere));
      Add(cxGetResourceString(@sdxPatternSmallGrid));
      Add(cxGetResourceString(@sdxPatternLargeGrid));
      Add(cxGetResourceString(@sdxPatternSmallCheckedBoard));
      Add(cxGetResourceString(@sdxPatternLargeCheckedBoard));
      Add(cxGetResourceString(@sdxPatternOutlinedDiamond));
      Add(cxGetResourceString(@sdxPatternSolidDiamond));
    finally
      EndUpdate;
    end;
  end;
  
  with FTextureNames do
  begin
    BeginUpdate;
    try
      Clear;
      Add(cxGetResourceString(@sdxTextureNewSprint));
      Add(cxGetResourceString(@sdxTextureGreenMarble));
      Add(cxGetResourceString(@sdxTextureBlueTissuePaper));
      Add(cxGetResourceString(@sdxTexturePapyrus));
      Add(cxGetResourceString(@sdxTextureWaterDroplets));
      Add(cxGetResourceString(@sdxTextureCork));
      Add(cxGetResourceString(@sdxTextureRecycledPaper));
      Add(cxGetResourceString(@sdxTextureWhiteMarble));
      Add(cxGetResourceString(@sdxTexturePinkMarble));
      Add(cxGetResourceString(@sdxTextureCanvas));
      Add(cxGetResourceString(@sdxTexturePaperBag));
      Add(cxGetResourceString(@sdxTextureWalnut));
      Add(cxGetResourceString(@sdxTextureParchment));
      Add(cxGetResourceString(@sdxTextureBrownMarble));
      Add(cxGetResourceString(@sdxTexturePurpleMesh));
      Add(cxGetResourceString(@sdxTextureDenim));
      Add(cxGetResourceString(@sdxTextureFishFossil));
      Add(cxGetResourceString(@sdxTextureOak));
      Add(cxGetResourceString(@sdxTextureStationary));
      Add(cxGetResourceString(@sdxTextureGranite));
      Add(cxGetResourceString(@sdxTextureBouquet));
      Add(cxGetResourceString(@sdxTextureWonenMat));
      Add(cxGetResourceString(@sdxTextureSand));
      Add(cxGetResourceString(@sdxTextureMediumWood));
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxFEFDialog.FreeAndNilResources;
begin
  FreeAndNil(FbmpPattern);
  FreeAndNil(FbmpCurrentPattern);
  FreeAndNil(FbmpTexture);
end;

procedure TdxFEFDialog.dgTextureDrawCell(Sender: TObject;
  Col, Row: Integer; Rect: TRect; State: TGridDrawState);
var
  DrawGrid: TDrawGrid;
  R: TRect;
  DC: HDC;
  BPP: Integer;
  DoHalftone: Boolean;
  Pt: TPoint;
  ABitmap: Windows.TBitmap;
  BltMode: Integer;
begin
  DrawGrid := TDrawGrid(Sender);
  DC := DrawGrid.Canvas.Handle;
  R := Rect;
  if not ((gdSelected in State) and FTextureWasSelected) then
    if (FOtherTexture = nil) or ((Row < DrawGrid.RowCount - 1) or (Col = 0)) then
    begin
      DrawEdge(DC, R, EDGE_SUNKEN, BF_RECT);
      InflateRect(R, -2, -2);
    end
    else
  else
    InflateRect(R, -2, -2);

  BltMode := GetStretchBltMode(DC);
  if (FOtherTexture = nil) or (Row < DrawGrid.RowCount - 1) then
  begin
    BPP := GetDeviceCaps(DC, BITSPIXEL) * GetDeviceCaps(DC, PLANES);
    cxGetBitmapData(FbmpTexture.Handle, ABitmap);
    DoHalftone := (BPP <= 8) and (BPP < (ABitmap.bmBitsPixel * ABitmap.bmPlanes));
    if DoHalftone then
    begin
      GetBrushOrgEx(DC, Pt);
      SetStretchBltMode(DC, HALFTONE);
      SetBrushOrgEx(DC, Pt.x, Pt.y, @Pt);
    end
    else 
      if not FbmpTexture.Monochrome then
        SetStretchBltMode(DC, STRETCH_DELETESCANS);
  end;
  
  if FOtherTexture = nil then
    Windows.StretchBlt(DC, R.Left, R.Top, R.Right - R.Left,
      R.Bottom - R.Top, FbmpTexture.Canvas.Handle, Col * TextureSize.X,
      Row * TextureSize.Y, TextureSize.X, TextureSize.Y, SRCCOPY)
  else 
    if Row < DrawGrid.RowCount - 1 then
      Windows.StretchBlt(DC, R.Left, R.Top, R.Right - R.Left,
        R.Bottom - R.Top, FbmpTexture.Canvas.Handle, Col * TextureSize.X,
        Row * TextureSize.Y, TextureSize.X, TextureSize.Y, SRCCOPY)
     else 
       if Col = 0 then
         DrawGrid.Canvas.StretchDraw(R, FOtherTexture)
       else
         Windows.FillRect(DC, Rect, hBrush(COLOR_BTNFACE + 1));

  SetStretchBltMode(DC, BltMode);

  if gdSelected in State then
    if (FTextureWasSelected and (FOtherTexture = nil)) or
      ((FOtherTexture <> nil) and ((Row < DrawGrid.RowCount - 1) or (DrawGrid.Col = 0))) then
      DrawSelectedFrame(DrawGrid, Rect);
end;

procedure TdxFEFDialog.dgPatternDrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
var
  APrevBrush: TBrush;
  ABrushBitmap: TBitmap;
  Pt: TPoint;
  DC: hDC;
begin
  DC := TDrawGrid(Sender).Canvas.Handle;
  if not ((gdSelected in State) and FPatternWasSelected) then
    DrawEdge(DC, Rect, EDGE_SUNKEN, BF_RECT);
  InflateRect(Rect, -2, -2);
  
  APrevBrush := TBrush.Create;
  try
    APrevBrush.Assign(TDrawGrid(Sender).Canvas.Brush);
    ABrushBitmap := CopyPattern(Col, Row);
    try
      SetBrushOrgEx(DC, Rect.Left, Rect.Top, @Pt);
      with TDrawGrid(Sender).Canvas do
      begin
        Brush.Bitmap := ABrushBitmap;
        FillRect(Rect);
        Brush.Bitmap := nil;
        Brush := APrevBrush;
      end;
      SetBrushOrgEx(DC, Pt.X, Pt.Y, nil);
    finally
      ABrushBitmap.Free;
    end;
  finally
    APrevBrush.Free;
  end;
  
  if (gdSelected in State) and FPatternWasSelected then
  begin
    InflateRect(Rect, 2, 2);
    DrawSelectedFrame(TDrawGrid(Sender), Rect);
  end;
end;

procedure TdxFEFDialog.DrawSelectedFrame(ADrawGrid: TDrawGrid; Rect: TRect);
var
  DC: HDC;
  PrevColor: TColor;
  PrevMode: Integer;
  Points: array of TPoint;
begin
  with ADrawGrid do                   
  begin
    DC := Canvas.Handle;
    if (ActiveControl = ADrawGrid) and Focused then
    begin
      //InflateRect(Rect, 2, 2);
      PrevMode := SetBkMode(DC, TRANSPARENT);
      PrevColor := Canvas.Pen.Color;
      Canvas.Pen.Color := clWindowText;
      Canvas.Pen.Style := psDot;
      with Rect do
      begin
        SetLength(Points, 5);
        Points[0] := TopLeft;
        Points[1] := MakePoint(Right - 1, Top);
        Points[2] := MakePoint(Right - 1, Bottom - 1);
        Points[3] := MakePoint(Left, Bottom - 1);
        Points[4] := TopLeft;
        Canvas.Polyline(Points);
      end;
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Color := PrevColor;
      SetBkMode(DC, PrevMode);
      InflateRect(Rect, -1, -1);
    end;
    DrawEdge(DC, Rect, BDR_SUNKENOUTER, BF_RECT or BF_MONO);
    InflateRect(Rect, -1, -1);
    FrameRect(DC, Rect, GetSysColorBrush(COLOR_BTNHIGHLIGHT));
  end;
end;

procedure TdxFEFDialog.LoadFromRegistry(const APath: string);
begin
  inherited LoadFromRegistry(APath);
  with TRegistry.Create do
  try
    if OpenKey(APath, False) then
    try
      if ValueExists(sdxInitialDir) then
        FInitialDir := ReadString(sdxInitialDir);
      if ValueExists(sdxActivePage) then
        FActivePage := ReadInteger(sdxActivePage);
    except
      on ERegistryException do
        { ignore }
      else
        raise;
    end;
  finally
    Free;
  end;
end;

procedure TdxFEFDialog.SaveToRegistry(const APath: string);
begin
  inherited SaveToRegistry(APath);
  with TRegistry.Create do
  try
    if OpenKey(APath, True) then
    try
      WriteString(sdxInitialDir, FInitialDir);
      WriteInteger(sdxActivePage, PageControl1.ActivePage.PageIndex);
    except
      on ERegistryException do
        { ignore }
      else
        raise;
    end;
  finally
    Free;
  end;
end;

procedure TdxFEFDialog.SelectPictureClick(Sender: TObject);
var
  Graphic: TGraphic;
begin
  Graphic := nil;
  try
    LoadImage(Graphic, 1);
    if Graphic <> nil then AssignPicture(Graphic);
  finally
    if Graphic <> nil then Graphic.Free;
  end;
end;

procedure TdxFEFDialog.AssignPicture(AImage: TGraphic);
begin
  if AImage is TMetafile then
  begin
    FPicture.Free;
    FPicture := TBitmap.Create;
    FPicture.Width := AImage.Width;
    FPicture.Height := AImage.Height;
    TBitmap(FPicture).Palette := AImage.Palette;
    TBitmap(FPicture).Canvas.Draw(0, 0, AImage);
  end
  else
    SetPicture(AImage);
    
  GetOtherPicture(TGraphicClass(FPicture.ClassType)).Assign(FPicture);
  PaintPicture;
  CheckModified;
  FPreviewWhat := faPicture;
  pbxPreview.Invalidate;
  FPictureExists := True;
end;

procedure TdxFEFDialog.PaintPicture;
begin
  if FPicture <> nil then
  begin
    pnlPicture.SetBounds(0, 0, FPicture.Width, FPicture.Height);
    pbxPicture.Invalidate;
  end;
end;

procedure TdxFEFDialog.pbxPicturePaint(Sender: TObject);
begin
  if FOtherPicture <> nil then
    TPaintBox(Sender).Canvas.Draw(0, 0, FOtherPicture);
end;

procedure TdxFEFDialog.btnOtherTextureClick(Sender: TObject);
var
  APicture: TGraphic;
begin
  APicture := nil;
  try
    LoadImage(APicture, 0);
    if APicture <> nil then
    begin
      if APicture is TMetafile then
      begin
        FPicture.Free;
        FPicture := TBitmap.Create;
        FPicture.Width := TextureSize.X;
        FPicture.Height := TextureSize.Y;
        TBitmap(FPicture).Palette := APicture.Palette;
        TBitmap(FPicture).Canvas.Draw(0, 0, APicture);
      end
      else
        SetPicture(APicture);
        
      if FOtherTexture = nil then
        dgTexture.RowCount := dgTexture.RowCount + 1;
      OtherTexture.Assign(FPicture);
      dgTexture.Col := 0;
      dgTexture.Row := dgTexture.RowCount - 1;
      if not FTextureWasSelected then
        FTextureWasSelected := True;
      dgTexture.Invalidate;
      CheckModified;
      FPreviewWhat := faTexture;
      pbxPreview.Refresh;
    end;
  finally
    if APicture <> nil then APicture.Free;
  end;
end;

procedure TdxFEFDialog.LoadImage(var AImage: TGraphic; AWhat: Integer);
var
  Registered: Boolean;

  procedure UnregisterIcon;
  begin
    Registered := Pos('ico', GraphicFilter(TGraphic)) > 0;
    if Registered then TPicture.UnregisterGraphicClass(TIcon);
  end;

  procedure RegisterIcon;
  begin
    if Registered then 
      TPicture.RegisterFileFormat('ico', SVIcons, TIcon);
  end;
  
var
  Dialog: TOpenPictureDialog;
  FileName: string;
  B: TBitmap;
begin
  UnregisterIcon;
  try
    Dialog := TOpenPictureDialog.Create(nil);
    try
      Dialog.InitialDir := FInitialDir;
      Dialog.Filter := GraphicFilter(TGraphic);
      if Dialog.Execute then
      begin
        if InternalLoadImage(AImage, Dialog.Filename) then
        begin
          FInitialDir := ExtractFileDir(Dialog.Filename);
          FileName := {Dialog.FileName;//}ChangeFileExt(ExtractFileName(Dialog.Filename), '');

          case AWhat of
            0: // textures
              begin
                FOtherTextureName := FileName;
                pnlTextureName.Caption := FileName;//ChangeFileExt(ExtractFileName(Filename), '');
                if AImage is TMetafile then
                //
                else 
                  if AImage is TBitmap then
                  begin
                    AImage.Width := TextureSize.X;
                    AImage.Height := TextureSize.Y;
                  end
                  else
                  begin
                    B := TBitmap.Create;
                    try
                      B.Assign(AImage);
                      B.Width := TextureSize.X;
                      B.Height := TextureSize.Y;
                      AImage.Assign(B);
                    finally
                      B.Free;
                    end;
                  end;
              end;

            1: // pictures
              begin
                FOtherPictureName := FileName;
                pnlPictureName.Caption := FileName;//ChangeFileExt(ExtractFileName(FileName), '');
              end;
          end;
          CheckModified;
        end;  
      end;
    finally
      Dialog.Free;
    end;
  finally
    RegisterIcon;
  end;
end;

function TdxFEFDialog.InternalLoadImage(var AImage: TGraphic; const AFileName: string): Boolean;
var
  Picture: TPicture;
begin
  AImage := nil;
  Picture := TPicture.Create;
  try
    try
      Picture.LoadFromFile(AFileName);
      AImage := dxPSUtl.CreateGraphic(TGraphicClass(Picture.Graphic.ClassType));
      AImage.Assign(Picture.Graphic); 
      Result := True;
    except
      FreeAndNil(AImage);
      Result := False;
    end;
  finally
    Picture.Free;
  end;
end;

function TdxFEFDialog.GetPicture: TGraphic;
begin
  Result := FPicture;
end;

function TdxFEFDialog.GetPaintMode: TdxPicturePaintMode;
begin
  if cbxPaintMode.ItemIndex > -1 then
    Result := TdxPicturePaintMode(cbxPaintMode.ItemIndex)
  else
    Result := ppmCenter;
end;

procedure TdxFEFDialog.SetPicture(Value: TGraphic);
begin
  if FPicture = nil then FPicture := TBitmap.Create;
  FPicture.Assign(Value);
end;

procedure TdxFEFDialog.SetPaintMode(Value: TdxPicturePaintMode);
begin
  if PaintMode <> Value then
    cbxPaintMode.ItemIndex := Integer(Value);
end;

procedure TdxFEFDialog.PaintPreview;
var
  APrevBrush: TBrush;
  ABrushBitmap: TBitmap;
  R: TRect;
  AWidth, AHeight: Integer;
  I, J: Integer;
begin
  case FPreviewWhat of
    faTexture:
      if FTextureWasSelected then
      begin
        AWidth := Picture.Width;
        AHeight := Picture.Height;
        for i := 0 to pbxPreview.Width div AWidth do
          for j := 0 to pbxPreview.Height div AHeight do
            pbxPreview.Canvas.Draw(i * AWidth, j * AHeight, Picture);
      end;

    faPattern:
      if FPatternWasSelected then
      begin
        APrevBrush := TBrush.Create;
        try
          APrevBrush.Assign(pbxPreview.Canvas.Brush);
          ABrushBitmap := CopyPattern(dgPattern.Col, dgPattern.Row);
          try
            R := pbxPreview.ClientRect;
            InflateRect(R, 2, 2);
            pbxPreview.Canvas.Brush.Bitmap := ABrushBitmap;
            pbxPreview.Canvas.FillRect(R);
            pbxPreview.Canvas.Brush.Bitmap := nil;
            pbxPreview.Canvas.Brush := APrevBrush;
          finally
            ABrushBitmap.Free;
          end;
        finally
          APrevBrush.Free;
        end;
      end;

    faPicture:
      if FOtherPicture <> nil then
      begin
        R := pbxPreview.ClientRect;
        InflateRect(R, 2, 2);
        pbxPreview.Canvas.StretchDraw(R, FOtherPicture);
      end;
  end;
end;

procedure TdxFEFDialog.dgTextureClick(Sender: TObject);
var
  DrawGrid: TDrawGrid;
begin
  DrawGrid := TDrawGrid(Sender);
  if FPicture <> nil then FPicture.Free;
  FPicture := nil;
  
  if FOtherTexture <> nil then
  begin
    if (DrawGrid.Row = DrawGrid.RowCount - 1) and (DrawGrid.Col > 0) then
      Exit
    else 
      if DrawGrid.Row < DrawGrid.RowCount - 1 then
        FPicture := CopyTexture(DrawGrid.Col, DrawGrid.Row)
      else 
        if DrawGrid.Col = 0 then
          SetPicture(OtherTexture);
  end
  else
    FPicture := CopyTexture(DrawGrid.Col, DrawGrid.Row);
  if not FTextureWasSelected then
  begin
    FTextureWasSelected := True;
    DrawGrid.Invalidate;
  end;
  FPreviewWhat := faTexture;
  pbxPreview.Invalidate;
  if (FOtherTexture <> nil) and (DrawGrid.Col = 0) and (DrawGrid.Row = DrawGrid.RowCount - 1) then
    pnlTextureName.Caption := FOtherTextureName
  else
    pnlTextureName.Caption := FTextureNames[DrawGrid.Col * TextureCount.Y + DrawGrid.Row];
  CheckModified;
end;

procedure TdxFEFDialog.dgPatternClick(Sender: TObject);
var
  DrawGrid: TDrawGrid;
begin
  DrawGrid := TDrawGrid(Sender);
  if not FPatternWasSelected then
  begin
    FPatternWasSelected := True;
    DrawGrid.Invalidate;
  end;
  FreeAndNil(FPicture);

  FPicture := CopyPattern(DrawGrid.Col, DrawGrid.Row);
  FPreviewWhat := faPattern;
  pbxPreview.Refresh;
  pnlPatternName.Caption := FPatternNames[DrawGrid.Col * TextureCount.Y + DrawGrid.Row];
  CheckModified;
end;

procedure TdxFEFDialog.pbxPreviewPaint(Sender: TObject);
begin
  PaintPreview;
end;

procedure TdxFEFDialog.MapPatternColors;
begin
  FreeAndNil(FbmpCurrentPattern);
  FbmpCurrentPattern := dxCreateMappedBmp(FbmpPattern, [clWhite, clBlack], [BackColor, ForeColor]);
end;

procedure TdxFEFDialog.cbxColorChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  FPreviewWhat := faPattern;
  MapPatternColors;
  pbxPreview.Invalidate;
  dgPattern.Invalidate;
  if (dgPattern.Col > -1) and (dgPattern.Row > -1) then 
    CheckModified;
end;

function TdxFEFDialog.CopyTexture(I, J: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  with Result do
  try
    Width := TextureSize.X;
    Height := TextureSize.Y;
    Canvas.Draw(-I * TextureSize.X, -J * TextureSize.Y, FbmpTexture);
  except
    Free;
    raise;
  end;
end;

function TdxFEFDialog.CopyPattern(I, J: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  with Result do
  try
    Width := PatternSize.X;
    Height := PatternSize.Y;
    Canvas.Draw(-I * PatternSize.X, -J * PatternSize.Y, FbmpCurrentPattern);
  except
    Result.Free;
    raise;
  end;
end;

procedure TdxFEFDialog.PageControl1Change(Sender: TObject);
begin
  FApplied := False;
  FPreviewWhat := TdxFillAs(TPageControl(Sender).ActivePage.PageIndex + 1);
  FreeAndNil(FPicture);

  case FPreviewWhat of
    faTexture:
      if FTextureWasSelected then
        if FOtherTexture <> nil then
        begin
          if dgTexture.Row < dgTexture.RowCount - 1 then
            FPicture := CopyTexture(dgTexture.Col, dgTexture.Row)
          else
            if dgTexture.Col = 0 then
              SetPicture(OtherTexture);
        end
        else
          FPicture := CopyTexture(dgTexture.Col, dgTexture.Row);
    faPattern:
      if FPatternWasSelected then
        FPicture := CopyPattern(dgPattern.Col, dgPattern.Row);
    faPicture:
      if FOtherPicture <> nil then SetPicture(FOtherPicture);
  end;
  pbxPreview.Invalidate;
  UpdateControlsState;
end;

procedure TdxFEFDialog.PicturePreviewClick(Sender: TObject);
begin
  dxShowPicturePreview(Picture);
end;

procedure TdxFEFDialog.cbxPaintModeChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  CheckModified;
end;

function TdxFEFDialog.GetSelectWhat: TdxFillAs;
begin
  Result := faNone;
  if FTextureWasSelected and (PageControl1.ActivePage.PageIndex = 0) then
    Result := faTexture
  else
    if FPatternWasSelected and (PageControl1.ActivePage.PageIndex = 1) then
      Result := faPattern
    else
      if FPictureExists and (PageControl1.ActivePage.PageIndex = 2) then
        Result := faPicture;
end;

procedure TdxFEFDialog.SetSelectWhat(Value: TdxFillAs);
begin
  case Value of
    faNone: ;
    faTexture:
      begin
        FTextureWasSelected := True;
        PageControl1.ActivePage := PageControl1.Pages[0];
      end;
    faPattern:
      begin
        FPatternWasSelected := True;
        PageControl1.ActivePage := PageControl1.Pages[1];
      end;
    faPicture:
      begin
        FPictureExists := True;
        PageControl1.ActivePage := PageControl1.Pages[2];
      end;
  end;
end;

function TdxFEFDialog.GetOtherTexture: TBitmap;
begin
  if FOtherTexture = nil then FOtherTexture := TBitmap.Create;
  Result := FOtherTexture;
end;

procedure TdxFEFDialog.SetOtherTexture(Value: TBitmap);
begin
  if Value <> nil then
    GetOtherTexture.Assign(Value)
  else 
    if FOtherTexture <> nil then
    begin
      FOtherTexture.Free;
      FOtherTexture := nil;
    end;
end;

function TdxFEFDialog.GetOtherPicture(AGraphicClass: TGraphicClass): TGraphic;
begin
  FreeAndNil(FOtherPicture);

  if AGraphicClass <> nil then
    FOtherPicture := dxPSUtl.CreateGraphic(AGraphicClass);
  Result := FOtherPicture;
end;

function TdxFEFDialog.GetForeColor: TColor;
begin
  Result := TColor(cbxForeColor.Items.Objects[cbxForeColor.ItemIndex]);
end;

procedure TdxFEFDialog.SetForeColor(Value: TColor);
begin
  TdxPSColorCombo(cbxForeColor).ColorValue := Value;
  cbxColorChange(cbxForeColor); {???}
end;

function TdxFEFDialog.GetBackColor: TColor;
begin
  Result := TColor(cbxBackColor.Items.Objects[cbxBackColor.ItemIndex]);
end;

procedure TdxFEFDialog.SetBackColor(Value: TColor);
begin
  TdxPSColorCombo(cbxBackColor).ColorValue := Value;
  cbxColorChange(cbxBackColor); {???}
end;

procedure TdxFEFDialog.lblPaintModeClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxFEFDialog.lblForegroundClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TdxPSColorCombo(ActiveControl).DroppedDown := True;
end;

procedure TdxFEFDialog.DoApply;
var
  B: TBitmap;
begin
  if Assigned(FOnApply) then
  begin
    Background.BeginUpdate;
    try
      Background.BkColor := BackColor;
      Background.Brush.Color := ForeColor;
      Background.Picture := Picture;
      case SelectWhat of
        faTexture:
          begin
            Background.Picture := Picture;
            Background.Mode := bmBrushBitmap;
          end;

        faPattern:
          begin
            B := TBitmap(Background.Picture);
            B.Width := PatternSize.X;
            B.Height := PatternSize.Y;
            B.Canvas.Draw(-dgPattern.Col * PatternSize.X, -dgPattern.Row * PatternSize.Y, FbmpCurrentPattern);
            Background.Mode := bmBrushBitmap;
          end;

        faPicture:
          begin
            Background.Mode := bmPicture;
            Background.PictureMode := PaintMode;
          end;
      end;
      if FOriginalBackground <> nil then FOriginalBackground.Assign(Background);
      FOnApply(Background);
    finally
      Background.EndUpdate;
    end;
  end;
end;

procedure TdxFEFDialog.btnApplyClick(Sender: TObject);
begin
  DoApply;
  FApplied := True;
  if FFirstApplied then
  begin
    btnCancel.Caption := cxGetResourceString(@sdxBtnClose);
    FFirstApplied := False;
  end;
  UpdateControlsState;
end;

procedure TdxFEFDialog.dgTextureDblClick(Sender: TObject);
begin
  if FPicture <> nil then btnOK.Click;
end;

procedure TdxFEFDialog.dgPatternDblClick(Sender: TObject);
begin
  if FPicture <> nil then btnOK.Click;
end;

procedure TdxFEFDialog.dgTextureMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
const
  ATextureLastCol: Longint = -2;
  ATextureLastRow: Longint = -2;
var
  Col, Row: Longint;
  S: string;
begin
  TDrawGrid(Sender).MouseToCell(X, Y, Col, Row);

  if (Col <> ATextureLastCol) or (Row <> ATextureLastRow) then
  begin
    Application.CancelHint;
    S := '';
    if (Col > -1) and (Row > -1) then
      if FOtherTexture = nil then
        S := FTextureNames[Col * TextureCount.Y + Row]
      else 
        if (FOtherTexture <> nil) and (Col = 0) and (Row = TDrawGrid(Sender).RowCount - 1) then
          S := FOtherTextureName
        else 
          if Row < TDrawGrid(Sender).RowCount - 1 then
            S := FTextureNames[Col * TextureCount.Y + Row];

    TDrawGrid(Sender).Hint := S;      
  end;
  
  ATextureLastCol := Col;
  ATextureLastRow := Row;
end;

procedure TdxFEFDialog.dgPatternMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
const
  APatternLastCol: Longint = -2;
  APatternLastRow: Longint = -2;
var
  Col, Row: Longint;
begin
  TDrawGrid(Sender).MouseToCell(X, Y, Col, Row);
  if (Col <> APatternLastCol) or (Row <> APatternLastRow) then
  begin
    Application.CancelHint;
    if (Col > -1) and (Row > -1) then
      TDrawGrid(Sender).Hint := FPatternNames[Col * PatternCount.Y + Row];
  end;
  
  APatternLastCol := Col;
  APatternLastRow := Row;
end;

procedure TdxFEFDialog.btnInvertClick(Sender: TObject);
begin
  DoInvertColors;
  with dgPattern do
    if (Col > -1) and (Row > -1) then CheckModified;
end;

procedure TdxFEFDialog.DoInvertColors;
var
  ASaveColor: TColor;
begin
  dgPattern.Perform(WM_SETREDRAW, WPARAM(False), 0);
  btnInvert.Perform(WM_SETREDRAW, WPARAM(False), 0);
  ASaveColor := ForeColor;
  ForeColor := BackColor;
  BackColor := ASaveColor;
  dgPattern.Perform(WM_SETREDRAW, WPARAM(True), 0);
  dgPattern.Invalidate;
  btnInvert.Perform(WM_SETREDRAW, WPARAM(True), 0);
  btnInvert.Invalidate;
end;

procedure TdxFEFDialog.pmPicturePopup(Sender: TObject);
begin
  miPreview.Enabled := btnPreview.Enabled;
  miCut.Enabled := FOtherPicture <> nil;
  miCopy.Enabled := FOtherPicture <> nil;
  miPaste.Enabled := ClipBoard.HasFormat(CF_PICTURE);
  miDelete.Enabled := FOtherPicture <> nil;
end;

procedure TdxFEFDialog.miCopyClick(Sender: TObject);
begin
  ClipBoard.Assign(FOtherPicture);
end;

procedure TdxFEFDialog.miPasteClick(Sender: TObject);
var
  P: TPicture;
begin
  P := TPicture.Create;
  try
    P.Assign(Clipboard);
    if (P.Graphic <> nil) and not P.Graphic.Empty then
      AssignPicture(P.Graphic);
  finally
    P.Free;
  end;
end;

procedure TdxFEFDialog.miDeleteClick(Sender: TObject);
begin
  GetOtherPicture(nil);
  pbxPicture.Invalidate;
  pbxPreview.Invalidate;
end;

procedure TdxFEFDialog.miCutClick(Sender: TObject);
begin
  miCopy.Click;
  miDelete.Click;
end;

end.
