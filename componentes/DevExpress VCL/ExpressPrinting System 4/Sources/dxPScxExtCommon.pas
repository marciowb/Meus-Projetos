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

unit dxPScxExtCommon;

interface

{$I cxVer.inc}

uses
  Windows, Classes, Graphics, ImgList, cxEdit, cxColorComboBox, cxLookAndFeelPainters,
  cxCheckBox, cxCheckGroup,  dxPSCore, dxPScxCommon,
 dxPSReportRenderCanvas, cxGeometry;
  
type
  TdxReportCellColorBoxAlignment = (ccbaLeft, ccbaRight);
  
  TdxReportCellColorBox = class(TdxReportCellImageContainer)
  private
    FColorBoxFrameColor: TColor;
    FColorBoxWidth: Integer;                   
    FColorValue: TColor;
    function GetColorBoxAlignment: TdxReportCellColorBoxAlignment;
    function GetShowDescription: Boolean;
    procedure SetColorBoxAlignment(Value: TdxReportCellColorBoxAlignment);
    procedure SetShowDescription(Value: Boolean);
  protected
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override;

    function GetImageAreaBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect; override;
    function GetImageBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect; override;
    procedure GetImageSizes(var AImageWidth, AImageHeight: Integer); override;
    function GetTextBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect; override;
    function HasImage: Boolean; override;
    function IsImageBackgroundDrawn: Boolean; override;
    function IsImageDrawn: Boolean; override;

    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    procedure DrawColorBox(ACanvas: TdxPSReportRenderCustomCanvas); virtual;
    function GetColorBoxFrameBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect; virtual;
    function GetColorBoxIntreriorBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect; virtual;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;

    function ActualColorBoxWidth(ACanvas: TdxPSReportRenderCustomCanvas): Integer; virtual;
    procedure DrawImage(ACanvas: TdxPSReportRenderCustomCanvas); override;
    function MeasureContentHeight(ACanvas: TdxPSReportRenderCustomCanvas): Integer; override;

    property ColorBoxAlignment: TdxReportCellColorBoxAlignment read GetColorBoxAlignment write SetColorBoxAlignment;
    property ColorBoxFrameColor: TColor read FColorBoxFrameColor write FColorBoxFrameColor;
    property ColorBoxWidth: Integer read FColorBoxWidth write FColorBoxWidth;
    property ColorValue: TColor read FColorValue write FColorValue;
    property ShowDescription: Boolean read GetShowDescription write SetShowDescription;
  end;

  TdxReportCellProgressBarOrientation = (pboHorizontal, pboVertical);
  
  TdxReportCellProgressBar = class(TdxReportCellText)
  private
    FMaxValue: Double;
    FMinValue: Double;
    FProgressColor: TColor;
    FText: string; 
    FValue: Double;
    function GetOrientation: TdxReportCellProgressBarOrientation;
    function GetShowPercentSymbol: Boolean;
    function GetShowText: Boolean;
    procedure SetOrientation(Value: TdxReportCellProgressBarOrientation);
    procedure SetMaxValue(Value: Double);
    procedure SetMinValue(Value: Double);
    procedure SetShowPercentSymbol(Value: Boolean);
    procedure SetShowText(Value: Boolean);
    procedure SetValue(Value: Double);
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
    
    function GetProgressBarProgressBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect; virtual;
    function GetProgressBarProgressRestBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect; virtual;
    function IsProgressBarDrawn(ACanvas: TdxPSReportRenderCustomCanvas): Boolean; virtual;

    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;
    
    procedure DrawContent(ACanvas: TdxPSReportRenderCustomCanvas; AStage: TdxPSRenderStages); override;
    procedure DrawProgressBar(ACanvas: TdxPSReportRenderCustomCanvas); virtual;
    procedure DrawText(ACanvas: TdxPSReportRenderCustomCanvas); override;
    
    property MaxValue: Double read FMaxValue write SetMaxValue;
    property MinValue: Double read FMinValue write SetMinValue;
    property Orientation: TdxReportCellProgressBarOrientation read GetOrientation write SetOrientation;
    property ProgressColor: TColor read FProgressColor write FProgressColor;
    property ShowPercentSymbol: Boolean read GetShowPercentSymbol write SetShowPercentSymbol;
    property ShowText: Boolean read GetShowText write SetShowText;
    property Value: Double read FValue write SetValue;
  end;

  TdxReportCellRichEditGraphic = class(TdxReportCellGraphic)
  protected
    function IsBackgroundBitmapDrawn: Boolean; override;
  end;
  
  { Data Maps }
  
  TdxPSColorComboBoxDataMap = class(TdxPSTextDataMap)
  protected
    class function DoesItemParticipateInBestFitCalculation(AProperties: TcxCustomEditProperties): Boolean; override;
    class function GetText(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): string; override;
    class procedure InitializeItem(AnItem: TAbstractdxReportCellData; AProperties: TcxCustomEditProperties;
      const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
      AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil); override;
    class function ItemClass(AProperties: TcxCustomEditProperties; AnIsPreview: Boolean = False): TdxReportCellDataClass; override;
    class function MeasureWidth(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
      const ACellParams: IdxPSCellParams; AFont: TFont; ARecordIndex: Integer = 0): Integer; override;
    class function PropertiesClass: TcxCustomEditPropertiesClass; override;
  end;

  TdxPSFontNameComboBoxDataMap = class(TdxPSTextDataMap)
  protected
    class procedure GetImageLists(AProperties: TcxCustomEditProperties; AProc: TdxPSGetImageListProc); override;
    class function GetImages(AProperties: TcxCustomEditProperties): TCustomImageList; virtual;
    class procedure InitializeItem(AnItem: TAbstractdxReportCellData; AProperties: TcxCustomEditProperties;
      const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
      AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil); override;
    class function ItemClass(AProperties: TcxCustomEditProperties; AnIsPreview: Boolean = False): TdxReportCellDataClass; override;
    class function MeasureWidth(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
      const ACellParams: IdxPSCellParams; AFont: TFont; ARecordIndex: Integer = 0): Integer; override;
    class function PropertiesClass: TcxCustomEditPropertiesClass; override;
  end;
  
 {$IFDEF REGISTERCXSHELLCTRLS}
  
  TdxPSShellComboBoxDataMap = class(TdxPSTextDataMap)
  protected
    class function GetImageIndex(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): Integer;
    class procedure GetImageLists(AProperties: TcxCustomEditProperties; AProc: TdxPSGetImageListProc); override;
    class function GetImages(AProperties: TcxCustomEditProperties): TCustomImageList;
    class function HasImages(AProperties: TcxCustomEditProperties): Boolean; 
    class procedure InitializeItem(AnItem: TAbstractdxReportCellData; AProperties: TcxCustomEditProperties;
      const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
      AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil); override;
    class function ItemClass(AProperties: TcxCustomEditProperties; AnIsPreview: Boolean = False): TdxReportCellDataClass; override;
    class function PropertiesClass: TcxCustomEditPropertiesClass; override;
    class function MeasureWidth(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
      const ACellParams: IdxPSCellParams; AFont: TFont; ARecordIndex: Integer = 0): Integer; override;
  end;

 {$ENDIF}
 
  TdxPSLabelDataMap = class(TdxPSTextDataMap)
  protected
    class function DoesItemParticipateInAutoWidthCalculation(AProperties: TcxCustomEditProperties): Boolean; override;
    class function DoesItemParticipateInBestFitCalculation(AProperties: TcxCustomEditProperties): Boolean; override;
    class procedure InitializeItem(AnItem: TAbstractdxReportCellData; AProperties: TcxCustomEditProperties;
      const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
      AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil); override;
    class function PropertiesClass: TcxCustomEditPropertiesClass; override;
  end;

  TdxPSProgressBarDataMap = class(TdxPSCustomDataMap)
  protected
    class function GetValue(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): Double;
    class function HasText(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): Boolean; override;
    class procedure InitializeItem(AnItem: TAbstractdxReportCellData; AProperties: TcxCustomEditProperties;
      const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
      AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil); override;
    class function ItemClass(AProperties: TcxCustomEditProperties; AnIsPreview: Boolean = False): TdxReportCellDataClass; override;
    class function PropertiesClass: TcxCustomEditPropertiesClass; override;
  end;

  TdxPSTrackBarDataMap = class(TdxPSCustomDataMap)
  protected
    class procedure InitializeItem(AnItem: TAbstractdxReportCellData; AProperties: TcxCustomEditProperties;
      const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
      AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil); override;
    class function ItemClass(AProperties: TcxCustomEditProperties; AnIsPreview: Boolean = False): TdxReportCellDataClass; override;
    class function PropertiesClass: TcxCustomEditPropertiesClass; override;
  end;

  
  TdxPSCheckButtonGroupDataMap = class(TdxPSCustomButtonGroupDataMap)
  protected
    class function ButtonGroupClass(AProperties: TcxCustomEditProperties): TdxCustomReportButtonGroupClass; override;
    class procedure InitializeGroupButton(AProperties: TcxCustomEditProperties; 
      const AValue: TcxEditValue; AButton: TdxCustomReportCellCheck; AnIndex: Integer); override;
    class procedure InitializeItem(AnItem: TAbstractdxReportCellData; AProperties: TcxCustomEditProperties; 
      const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams; 
      AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil); override;
    class function PropertiesClass: TcxCustomEditPropertiesClass; override;
  end;
  
  TdxPSRichEditDataMap = class(TdxPSDelegateDataMap)
  protected
    class function DataMapClass(AProperties: TcxCustomEditProperties): TdxPSDataMapClass; override;
    class function PropertiesClass: TcxCustomEditPropertiesClass; override;
  end;
  
  TdxPSRichTextDataMap = class(TdxPSCustomDataMap)
  protected
    class function DoesItemParticipateInBestFitCalculation(AProperties: TcxCustomEditProperties): Boolean; override;
    class procedure InitializeItem(AnItem: TAbstractdxReportCellData; AProperties: TcxCustomEditProperties;
      const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
      AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil); override;
    class function ItemClass(AProperties: TcxCustomEditProperties; AnIsPreview: Boolean = False): TdxReportCellDataClass; override;
  end;
  

{ Helpers }

function ColorComboBoxProperties_GetColor(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): TColor;
function ColorComboBoxProperties_GetColorBoxAlignment(AProperties: TcxCustomEditProperties): TdxReportCellColorBoxAlignment;
function ColorComboBoxProperties_GetColorBoxFrameColor(AProperties: TcxCustomEditProperties): TColor;
function ColorComboBoxProperties_GetColorBoxWidth(AProperties: TcxCustomEditProperties): Integer;
function ColorComboBoxProperties_GetShowDescriptions(AProperties: TcxCustomEditProperties): Boolean;
function ColorComboBoxProperties_GetText(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): string;
function FontNameComboBox_GetShowTypeIcon(AProperties: TcxCustomEditProperties): Boolean;
function FontNameComboBox_GetTypeIconImageIndex(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): Integer;
function ProgressBarProperties_GetMaxValue(AProperties: TcxCustomEditProperties): Double;
function ProgressBarProperties_GetMinValue(AProperties: TcxCustomEditProperties): Double;
function ProgressBarProperties_GetOrientation(AProperties: TcxCustomEditProperties): TdxReportCellProgressBarOrientation;
function ProgressBarProperties_GetProgressBarColor(AProperties: TcxCustomEditProperties): TColor;
function ProgressBarProperties_GetShowPercentSymbol(AProperties: TcxCustomEditProperties): Boolean;
function ProgressBarProperties_GetShowText(AProperties: TcxCustomEditProperties): Boolean;
function ProgressBarProperties_GetText(AProperties: TcxCustomEditProperties): string;
function CheckGroupProperties_GetGlyph(AProperties: TcxCustomEditProperties): TBitmap;
function CheckGroupProperties_GetGlyphCount(AProperties: TcxCustomEditProperties): Integer;
function CheckGroupProperties_GetCheckPos(AProperties: TcxCustomEditProperties): TdxCellCheckPos;
function CheckGroupProperties_GetCheckStates(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue; out ACheckStates: TcxCheckStates): Boolean;
function CheckGroupProperties_GetIsItemEnabled(AProperties: TcxCustomEditProperties; AnIndex: Integer): Boolean;
function RichEditProperties_GetIsMemoMode(AProperties: TcxCustomEditProperties): Boolean;
  
{ Utilities }
  
function FontImages: TCustomImageList;
  
const
  dxDefaultColorBoxWidth = 30;
  dxDefaultColorBoxColorValue: TColor = clWhite;
  
  ColorBoxAlignmentMap: array[TcxColorBoxAlign] of TdxReportCellColorBoxAlignment = (ccbaLeft, ccbaRight);
  LeftRightMap: array[TLeftRight] of TdxCellCheckPos = (ccpLeft, ccpRight);
    
implementation

uses
  SysUtils, Controls, cxLabel, cxProgressBar, cxTrackBar, cxFontNameComboBox, 
  cxExtEditUtils, {$IFDEF REGISTERCXSHELLCTRLS} cxShellComboBox, {$ENDIF}
  ComCtrls, Forms, cxRichEdit, dxPSRELnk,  dxPSGlbl, 
  dxPSUtl, cxDrawTextUtils;

type
  TcxCustomColorComboBoxPropertiesAccess = class(TcxCustomColorComboBoxProperties);  
  TcxCustomFontNameComboBoxPropertiesAccess = class(TcxCustomFontNameComboBoxProperties);
  TcxCustomProgressBarPropertiesAccess = class(TcxCustomProgressBarProperties);
 {$IFDEF REGISTERCXSHELLCTRLS}
  TcxCustomShellComboBoxPropertiesAccess = class(TcxCustomShellComboBoxProperties);
 {$ENDIF}
  TcxCustomCheckGroupPropertiesAccess = class(TcxCustomCheckGroupProperties);
  TcxCustomRichEditPropertiesAccess = class(TcxCustomRichEditProperties);

const
  Eps: Double = 0.001;
  ProgressBarOrientationMap: array[TcxProgressBarOrientation] of TdxReportCellProgressBarOrientation = (pboHorizontal, pboVertical);

  dxFormatColorBoxShowDescription          = dxPSGlbl.dxFormatCheckBold;
  dxFormatColorBoxAlignmentOffset          = dxPSGlbl.dxFormatSortOrderOffset;
  dxFormatColorBoxAlignmentLeft            = dxPSGlbl.dxFormatSortNo;
  dxFormatColorBoxAlignmentRight           = dxPSGlbl.dxFormatSortUp;
  dxFormatColorBoxAlignmentMask            = dxFormatColorBoxAlignmentLeft or dxFormatColorBoxAlignmentRight;

  dxFormatProgressBarShowPercentSymbol     = dxPSGlbl.dxFormatMakeSpaceForEmptyImage;
  dxFormatProgressBarShowText              = dxPSGlbl.dxFormatCheckFlat;
  dxFormatProgressBarOrientationOffset     = dxPSGlbl.dxFormatSortOrderOffset;
  dxFormatProgressBarOrientationHorizontal = dxPSGlbl.dxFormatSortNo;
  dxFormatProgressBarOrientationVertical   = dxPSGlbl.dxFormatSortUp;
  dxFormatProgressBarOrientationMask       = dxFormatProgressBarOrientationHorizontal or dxFormatProgressBarOrientationVertical;

var
  FFontImages: TCustomImageList;
  FRichEdit: TRichEdit;
  FRichEditSite: TForm;

{ Helpers }

{ ColorComboBoxProperties Helpers }
 
function ColorComboBoxProperties_GetColor(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): TColor;
var
 ItemIndex: Integer;
 S: string;
begin
  with TcxCustomColorComboBoxPropertiesAccess(AProperties) do 
  begin
    ItemIndex := IndexByValue(AValue);
    if ItemIndex <> -1 then 
      Result := GetColorByIndex(ItemIndex)
    else
      if (ColorComboStyle = cxccsComboList) and not IsVarEmpty(AValue) then
        Result := DefaultColor
      else
        TranslateValues(AValue, Result, S);
  end;    
end;

function ColorComboBoxProperties_GetColorBoxAlignment(AProperties: TcxCustomEditProperties): TdxReportCellColorBoxAlignment;
begin
  Result := ColorBoxAlignmentMap[TcxCustomColorComboBoxPropertiesAccess(AProperties).ColorBoxAlign];
end;

function ColorComboBoxProperties_GetColorBoxFrameColor(AProperties: TcxCustomEditProperties): TColor;
begin
  Result := TcxCustomColorComboBoxPropertiesAccess(AProperties).ColorBoxFrameColor;
end;

function ColorComboBoxProperties_GetColorBoxWidth(AProperties: TcxCustomEditProperties): Integer;
begin
  Result := TcxCustomColorComboBoxPropertiesAccess(AProperties).ColorBoxWidth;
end;
 
function ColorComboBoxProperties_GetShowDescriptions(AProperties: TcxCustomEditProperties): Boolean;
begin
 Result := TcxCustomColorComboBoxPropertiesAccess(AProperties).ShowDescriptions;
end;

function ColorComboBoxProperties_GetText(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): string;
var
  ItemIndex: Integer;
  Color: TColor;
  S: string;
begin
  with TcxCustomColorComboBoxPropertiesAccess(AProperties) do 
  begin
    ItemIndex := IndexByValue(AValue);
    if (ItemIndex = -1) and ((ColorComboStyle <> cxccsComboList) or IsVarEmpty(AValue)) then
    begin
      TranslateValues(AValue, Color, S);
      Result := S;
    end
    else
      Result := GetDescriptionByIndex(ItemIndex);    
  end;
end;  

{ FontNameComboBoxProperties Helpers }

function FontNameComboBox_GetShowTypeIcon(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := ftiShowInCombo in TcxCustomFontNameComboBoxPropertiesAccess(AProperties).ShowFontTypeIcon;
end; 

function FontNameComboBox_GetTypeIconImageIndex(AProperties: TcxCustomEditProperties; const AValue: TcxEditValue): Integer;
const
  ImageIndexes: array[Boolean] of Integer = (0, 1);
var
  Index: Integer;  
begin
  Result := -1;
  if FontNameComboBox_GetShowTypeIcon(AProperties) then
    with TcxCustomFontNameComboBoxPropertiesAccess(AProperties) do 
    begin
      Index := Items.IndexOf(GetDisplayText(AValue, False));
      if Index <> -1 then 
        Result := ImageIndexes[Integer(Items.Objects[Index]) and TRUETYPE_FONTTYPE = 0];
    end;
end;

{ ProgressBarProperties Helpers }

function ProgressBarProperties_GetMaxValue(AProperties: TcxCustomEditProperties): Double;
begin
  Result := TcxCustomProgressBarPropertiesAccess(AProperties).Max;
end;

function ProgressBarProperties_GetMinValue(AProperties: TcxCustomEditProperties): Double;
begin
  Result := TcxCustomProgressBarPropertiesAccess(AProperties).Min;
end;

function ProgressBarProperties_GetOrientation(AProperties: TcxCustomEditProperties): TdxReportCellProgressBarOrientation;
begin
  Result := ProgressBarOrientationMap[TcxCustomProgressBarPropertiesAccess(AProperties).Orientation];
end;

function ProgressBarProperties_GetProgressBarColor(AProperties: TcxCustomEditProperties): TColor;
begin
  Result := TcxCustomProgressBarPropertiesAccess(AProperties).BeginColor;
end;

function ProgressBarProperties_GetShowPercentSymbol(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := TcxCustomProgressBarPropertiesAccess(AProperties).ShowTextStyle = cxtsPercent;
end;

function ProgressBarProperties_GetShowText(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := TcxCustomProgressBarPropertiesAccess(AProperties).ShowText;
end;

function ProgressBarProperties_GetText(AProperties: TcxCustomEditProperties): string;
begin
  Result := TcxCustomProgressBarPropertiesAccess(AProperties).Text;
end;


{ CheckGroupProperties Helpers }

function CheckGroupProperties_GetGlyph(AProperties: TcxCustomEditProperties): TBitmap;
begin
  Result := TcxCustomCheckGroupPropertiesAccess(AProperties).Glyph;
end;

function CheckGroupProperties_GetGlyphCount(AProperties: TcxCustomEditProperties): Integer;
begin
  Result := TcxCustomCheckGroupPropertiesAccess(AProperties).GlyphCount;
end;

function CheckGroupProperties_GetCheckPos(AProperties: TcxCustomEditProperties): TdxCellCheckPos;
begin
  Result := LeftRightMap[TcxCustomCheckGroupPropertiesAccess(AProperties).ItemAlignment];
end;

function CheckGroupProperties_GetCheckStates(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue; out ACheckStates: TcxCheckStates): Boolean;
begin
  with TcxCustomCheckGroupPropertiesAccess(AProperties) do
    Result := cxCheckBox.CalculateCheckStates(AValue, Items, EditValueFormat, ACheckStates)
end;
  
function CheckGroupProperties_GetIsItemEnabled(AProperties: TcxCustomEditProperties; AnIndex: Integer): Boolean;
begin
  Result := TcxCustomCheckGroupPropertiesAccess(AProperties).Items[AnIndex].Enabled;
end;

{ RichEditProperties Helpers }

function RichEditProperties_GetIsMemoMode(AProperties: TcxCustomEditProperties): Boolean;
begin
  with TcxCustomRichEditPropertiesAccess(AProperties) do 
   Result :=  MemoMode or PlainText;
end;  

    
 { Utilities }
  
function FontImages: TCustomImageList;

  procedure AddImage(AnImage: TBitmap);
  begin
    FFontImages.AddMasked(AnImage, clDefault);
  end;
  
begin
  if FFontImages = nil then
  begin
    FFontImages := TImageList.Create(nil);
    FFontImages.Width := cxFontNameComboBox.FTrueTypeFontBitmap.Width;
    FFontImages.Height := cxFontNameComboBox.FTrueTypeFontBitmap.Height;
    FFontImages.AllocBy := 2;

    AddImage(cxFontNameComboBox.FTrueTypeFontBitmap);
    AddImage(cxFontNameComboBox.FNonTrueTypeFontBitmap);
  end;
  Result := FFontImages;
end;
  
function RichEdit: TRichEdit;
begin
  if FRichEdit = nil then
  begin
    FRichEditSite := TForm.Create(nil);
    FRichEdit := TRichEdit.Create(nil);
    FRichEdit.Parent := FRichEditSite;
  end;
  Result := FRichEdit;
end;
  
{ TdxReportCellColorBox }
    
constructor TdxReportCellColorBox.Create(AParent: TdxReportCell);
begin
  inherited;
  FColorBoxFrameColor := clBtnShadow;
  FColorBoxWidth := dxDefaultColorBoxWidth;
  FColorValue := clBlack;
end;

procedure TdxReportCellColorBox.Assign(Source: TPersistent);
begin
  if Source is TdxReportCellColorBox then
    with TdxReportCellColorBox(Source) do 
    begin
      Self.ColorBoxFrameColor := ColorBoxFrameColor;
      Self.ColorBoxWidth := ColorBoxWidth;
      Self.ColorValue := ColorValue;
    end;
  inherited;
end;

function TdxReportCellColorBox.ActualColorBoxWidth(
  ACanvas: TdxPSReportRenderCustomCanvas): Integer;
var
  W: Integer;
begin
  Result := ColorBoxWidth;
  with GetInnerBounds(ACanvas) do 
    W := Right - Left;
  if Result > W - 2 * LineThickness then
    Result := W - 2 * LineThickness;
  if Result < 0 then
    Result := 0;  
end;

procedure TdxReportCellColorBox.DrawImage(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  DrawColorBox(ACanvas);
end;

function TdxReportCellColorBox.MeasureContentHeight(
  ACanvas: TdxPSReportRenderCustomCanvas): Integer;
begin
  if ShowDescription then
    Result := inherited MeasureContentHeight(ACanvas)
  else
    Result := Height;  
end;

procedure TdxReportCellColorBox.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
begin
  inherited;
  ColorBoxWidth := MulDiv(ColorBoxWidth, APixelsNumerator, APixelsDenominator);
end;

function TdxReportCellColorBox.GetImageAreaBounds(
  ACanvas: TdxPSReportRenderCustomCanvas): TRect;
begin
  Result := GetInnerBounds(ACanvas);
  if ShowDescription then
    if ColorBoxAlignment = ccbaLeft then
      Result.Right := Result.Left + ActualColorBoxWidth(ACanvas) + 2 * LineThickness
    else
      Result.Left := Result.Right - ActualColorBoxWidth(ACanvas) + 2 * LineThickness;
end;

function TdxReportCellColorBox.GetImageBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect;
begin
  Result := GetImageAreaBounds(ACanvas);
  if not IsRectEmpty(Result) then
    InflateRect(Result, -LineThickness, -LineThickness);
  if IsRectEmpty(Result) then 
    Result := cxNullRect;
end;

procedure TdxReportCellColorBox.GetImageSizes(var AImageWidth, AImageHeight: Integer);
begin
  AImageWidth := ActualColorBoxWidth(nil) + 2;
  AImageHeight := Height;
end;

function TdxReportCellColorBox.GetTextBounds(ACanvas: TdxPSReportRenderCustomCanvas): TRect;
begin
  if ShowDescription then
  begin
    Result := GetInnerBounds(ACanvas);
    if ColorBoxAlignment = ccbaLeft then
      Inc(Result.Left, ActualColorBoxWidth(ACanvas) + 2 * LineThickness)
    else
      Dec(Result.Right, ActualColorBoxWidth(ACanvas) + 2 * LineThickness);
    if IsRectEmpty(Result) then
      Result := cxNullRect;
  end
  else
    Result := cxNullRect;
end;

function TdxReportCellColorBox.HasImage: Boolean;
begin
  Result := True;
end;

function TdxReportCellColorBox.IsImageBackgroundDrawn: Boolean;
begin
  Result := False;
end;

function TdxReportCellColorBox.IsImageDrawn: Boolean;
begin
  Result := True;
end;

procedure TdxReportCellColorBox.ReadData(AReader: TdxPSDataReader);
begin
  inherited;
  ColorBoxFrameColor := AReader.ReadInteger;
  ColorBoxWidth := AReader.ReadInteger;
  ColorValue := AReader.ReadInteger;
end;

procedure TdxReportCellColorBox.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited;
  AWriter.WriteInteger(ColorBoxFrameColor);
  AWriter.WriteInteger(ColorBoxWidth);
  AWriter.WriteInteger(ColorValue);
end;

procedure TdxReportCellColorBox.DrawColorBox(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  Renderer.FrameRect(ACanvas, GetImageAreaBounds(ACanvas), Color);
  Renderer.FrameRect(ACanvas, GetColorBoxFrameBounds(ACanvas), ColorBoxFrameColor);
  Renderer.FillRect(ACanvas, GetColorBoxIntreriorBounds(ACanvas), ColorValue);
end;

function TdxReportCellColorBox.GetColorBoxFrameBounds(
  ACanvas: TdxPSReportRenderCustomCanvas): TRect;
begin
  Result := GetImageBounds(ACanvas);
end;

function TdxReportCellColorBox.GetColorBoxIntreriorBounds(
  ACanvas: TdxPSReportRenderCustomCanvas): TRect;
begin
  Result := GetColorBoxFrameBounds(ACanvas);
  if not IsRectEmpty(Result) then
    InflateRect(Result, -LineThickness, -LineThickness);
  if IsRectEmpty(Result) then 
    Result := cxNullRect;  
end;

function TdxReportCellColorBox.GetColorBoxAlignment: TdxReportCellColorBoxAlignment;
begin
  Result := TdxReportCellColorBoxAlignment(
    (Format and dxFormatColorBoxAlignmentMask) shr dxFormatColorBoxAlignmentOffset);
end;

function TdxReportCellColorBox.GetShowDescription: Boolean;
begin
  Result := GetFormatBit(dxFormatColorBoxShowDescription);
end;

procedure TdxReportCellColorBox.SetColorBoxAlignment(Value: TdxReportCellColorBoxAlignment);
begin
  Format := Format and not dxFormatColorBoxAlignmentMask or
    (Byte(Value) shl dxFormatColorBoxAlignmentOffset);
end;

procedure TdxReportCellColorBox.SetShowDescription(Value: Boolean);
begin
  SetFormatBit(dxFormatColorBoxShowDescription, Value);
end;

{ TdxReportCellProgressBar }

constructor TdxReportCellProgressBar.Create(AParent: TdxReportCell);
begin
  inherited;
  MaxValue := 100;
  MinValue := 0;
  Orientation := pboHorizontal;
  ProgressColor := clNavy;
  Value := 0;
  
  TextAlignX := taCenterX;
  TextAlignY := taCenterY;
end;

procedure TdxReportCellProgressBar.Assign(Source: TPersistent);
begin
  if Source is TdxReportCellProgressBar then
    with TdxReportCellProgressBar(Source) do
    begin
      Self.MaxValue := MaxValue;
      Self.MinValue := MinValue;
      Self.ProgressColor := ProgressColor;
      Self.Value := Value;
  end;
  inherited;
end;
    
procedure TdxReportCellProgressBar.DrawContent(
  ACanvas: TdxPSReportRenderCustomCanvas; AStage: TdxPSRenderStages);
begin
  DrawBackground(ACanvas);
  if IsProgressBarDrawn(ACanvas) then
    DrawProgressBar(ACanvas);
  if IsTextDrawn then
    DrawText(ACanvas);
  if IsBordersDrawn then
    DrawBorders(ACanvas);
end;

procedure TdxReportCellProgressBar.DrawProgressBar(
  ACanvas: TdxPSReportRenderCustomCanvas);
var
  R: TRect;
begin
  R := GetProgressBarProgressBounds(ACanvas);
  if ACanvas.IsRectVisible(R) then
    Renderer.FillRect(ACanvas, R, ProgressColor);
end;

procedure TdxReportCellProgressBar.DrawText(ACanvas: TdxPSReportRenderCustomCanvas);

  procedure DrawClippedText(var ATextRect, AClipRect: TRect; ATextColor: TColor);
  begin
    ACanvas.SaveClipRgn;
    try
      ACanvas.Font.Color := ATextColor;
      ACanvas.IntersectClipRgn(AClipRect);
      Renderer.DrawTextEx(ACanvas, ATextRect, 0, 0, 0, Text, nil, DTFormat and not CXTO_AUTOINDENTS);
    finally
      ACanvas.RestoreClipRgn;
    end;
  end;
  
var
  Size: TSize;
  TextRect, ClipRect: TRect;
begin
  ACanvas.SaveState;
  try
    ACanvas.Font := Font;
    Size := ACanvas.TextSize(Text);
    TextRect := GetInnerBounds(ACanvas);
    InflateRect(TextRect, -(TextRect.Right - TextRect.Left - Size.cX) div 2, 0);
    if IntersectRect(ClipRect, TextRect, GetProgressBarProgressBounds(ACanvas)) then
      DrawClippedText(TextRect, ClipRect, dxPSUtl.InvertColor(ProgressColor));
    if IntersectRect(ClipRect, TextRect, GetProgressBarProgressRestBounds(ACanvas)) then 
      DrawClippedText(TextRect, ClipRect, ColorToRGB(Font.Color));
  finally
    ACanvas.RestoreState;
  end;
end;

function TdxReportCellProgressBar.GetText: string;
begin
  if ShowText then 
  begin
    if FText = '' then
    begin
      Result := FloatToStr(Value);
      if ShowPercentSymbol then
        Result := Result + ' ' + PercentSymbol;
    end
    else
      Result := FText; 
  end
  else
    Result := '';
end;

procedure TdxReportCellProgressBar.SetText(const Value: string);
begin
  FText := Value;
end;
    
function TdxReportCellProgressBar.GetProgressBarProgressBounds(
  ACanvas: TdxPSReportRenderCustomCanvas): TRect;
begin
  Result := GetInnerBounds(ACanvas);
  InflateRect(Result, -LineThickness, -LineThickness);
  if IsRectEmpty(Result) then
    Result := cxNullRect;

  if not IsRectEmpty(Result) and (Abs(Value - MaxValue) > Eps) then 
  begin
    with Result do 
      if Orientation = pboHorizontal then 
        Right := Left + Round((Right - Left) * (Value - MinValue) / (MaxValue - MinValue))
      else
        Top := Bottom - Round((Bottom - Top) * (Value - MinValue) / (MaxValue - MinValue));

    if IsRectEmpty(Result) then 
      Result := cxNullRect;
  end;
  
  if not IsRectEmpty(Result) then
    ACanvas.FixupRect(Result);
end;

function TdxReportCellProgressBar.GetProgressBarProgressRestBounds(
  ACanvas: TdxPSReportRenderCustomCanvas): TRect;
begin
  Result := GetInnerBounds(ACanvas);
  InflateRect(Result, -LineThickness, -LineThickness);
  if IsRectEmpty(Result) then 
    Result := cxNullRect;

  if not IsRectEmpty(Result) and (Abs(Value - MinValue) > Eps) then 
  begin
    with Result do 
      if Orientation = pboHorizontal then 
        Left := Right - Round((Right - Left) * (MaxValue - Value) / (MaxValue - MinValue))
      else
        Bottom := Top + Round((Bottom - Top) * (MaxValue - Value) / (MaxValue - MinValue));

    if IsRectEmpty(Result) then 
      Result := cxNullRect;
  end;
  
  if not IsRectEmpty(Result) then 
    ACanvas.FixupRect(Result);
end;

function TdxReportCellProgressBar.IsProgressBarDrawn(
  ACanvas: TdxPSReportRenderCustomCanvas): Boolean;
begin
  Result := not IsRectEmpty(GetProgressBarProgressBounds(ACanvas)) or ShowText;
end;

procedure TdxReportCellProgressBar.ReadData(AReader: TdxPSDataReader);
begin
  inherited;
  MaxValue := AReader.ReadFloat;
  MinValue := AReader.ReadFloat;
  ProgressColor := AReader.ReadInteger;
  Value := AReader.ReadFloat;
end;

procedure TdxReportCellProgressBar.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited;
  AWriter.WriteFloat(MaxValue);
  AWriter.WriteFloat(MinValue);
  AWriter.WriteInteger(ProgressColor);
  AWriter.WriteFloat(Value);
end;

function TdxReportCellProgressBar.GetOrientation: TdxReportCellProgressBarOrientation;
begin
  Result := TdxReportCellProgressBarOrientation((Format and dxFormatProgressBarOrientationMask) shr dxFormatProgressBarOrientationOffset);
end;

function TdxReportCellProgressBar.GetShowPercentSymbol: Boolean;
begin
  Result := GetFormatBit(dxFormatProgressBarShowPercentSymbol);
end;

function TdxReportCellProgressBar.GetShowText: Boolean;
begin
  Result := GetFormatBit(dxFormatProgressBarShowText);
end;

procedure TdxReportCellProgressBar.SetOrientation(Value: TdxReportCellProgressBarOrientation);
begin
  Format := Format and not dxFormatProgressBarOrientationMask or (Byte(Value) shl dxFormatProgressBarOrientationOffset);
end;

procedure TdxReportCellProgressBar.SetMaxValue(Value: Double);
begin 
  if Value < MinValue then 
    Value := MinValue;
  FMaxValue := Value;
  SetValue(Self.Value);
end;

procedure TdxReportCellProgressBar.SetMinValue(Value: Double);
begin 
  if Value > MaxValue then 
    Value := MaxValue;
  FMinValue := Value;
  SetValue(Self.Value);
end;

procedure TdxReportCellProgressBar.SetShowPercentSymbol(Value: Boolean);
begin
  SetFormatBit(dxFormatProgressBarShowPercentSymbol, Value);
end;

procedure TdxReportCellProgressBar.SetShowText(Value: Boolean);
begin
  SetFormatBit(dxFormatProgressBarShowText, Value);
end;

procedure TdxReportCellProgressBar.SetValue(Value: Double);
begin
  if Value < MinValue then Value := MinValue;
  if Value > MaxValue then Value := MaxValue;
  FValue := Value;
end;

{ TdxReportCellRichEditGraphic }

function TdxReportCellRichEditGraphic.IsBackgroundBitmapDrawn: Boolean;
begin
  Result := inherited IsBackgroundBitmapDrawn and ImageTransparent;
end;

{ TdxPSColorComboBoxDataMap }

class function TdxPSColorComboBoxDataMap.DoesItemParticipateInBestFitCalculation(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := ColorComboBoxProperties_GetShowDescriptions(AProperties);
end;

class function TdxPSColorComboBoxDataMap.GetText(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue): string;
begin
  Result := ColorComboBoxProperties_GetText(AProperties, AValue);
end;

class procedure TdxPSColorComboBoxDataMap.InitializeItem(AnItem: TAbstractdxReportCellData; 
  AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
  const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams; 
  AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil);
begin
  inherited;
  with TdxReportCellColorBox(AnItem) do
  begin
    ColorBoxAlignment := ColorComboBoxProperties_GetColorBoxAlignment(AProperties);
    ColorBoxFrameColor := ColorComboBoxProperties_GetColorBoxFrameColor(AProperties);
    ColorBoxWidth := ColorComboBoxProperties_GetColorBoxWidth(AProperties); 
    ColorValue := ColorComboBoxProperties_GetColor(AProperties, AValue);
    //EndEllipsis := True;
    ShowDescription := ColorComboBoxProperties_GetShowDescriptions(AProperties);
  end;  
end;

class function TdxPSColorComboBoxDataMap.ItemClass(AProperties: TcxCustomEditProperties; 
  AnIsPreview: Boolean = False): TdxReportCellDataClass;
begin
  Result := TdxReportCellColorBox;
end;

class function TdxPSColorComboBoxDataMap.MeasureWidth(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; AFont: TFont;
  ARecordIndex: Integer = 0): Integer;
begin
  Result := inherited MeasureWidth(AProperties, AValue, ACellParams, AFont, ARecordIndex);
  Inc(Result, 2 + dxDefaultColorBoxWidth + 2);  
end;  

class function TdxPSColorComboBoxDataMap.PropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomColorComboBoxProperties;
end;

{ TdxPSFontNameComboBoxDataMap }

class procedure TdxPSFontNameComboBoxDataMap.GetImageLists(AProperties: TcxCustomEditProperties; 
  AProc: TdxPSGetImageListProc);
begin
  AProc(GetImages(AProperties));
end;  

class function TdxPSFontNameComboBoxDataMap.GetImages(AProperties: TcxCustomEditProperties): TCustomImageList;
begin
  Result := FontImages;
end;

class procedure TdxPSFontNameComboBoxDataMap.InitializeItem(AnItem: TAbstractdxReportCellData; 
  AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
  const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
  AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil);
begin
  inherited;
  with TdxReportCellImage(AnItem) do
  begin
    if FontNameComboBox_GetShowTypeIcon(AProperties) then 
    begin
      ImageIndex := FontNameComboBox_GetTypeIconImageIndex(AProperties, AValue);
      ImageList := GetImages(AProperties);
    end;
    MakeSpaceForEmptyImage := True;
  end;  
end;

class function TdxPSFontNameComboBoxDataMap.ItemClass(AProperties: TcxCustomEditProperties; 
  AnIsPreview: Boolean = False): TdxReportCellDataClass;
begin
  Result := TdxReportCellImage;
end;

class function TdxPSFontNameComboBoxDataMap.MeasureWidth(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; AFont: TFont;
  ARecordIndex: Integer = 0): Integer;
begin
  Result := inherited MeasureWidth(AProperties, AValue, ACellParams, AFont, ARecordIndex);
  if FontNameComboBox_GetShowTypeIcon(AProperties) then 
    Inc(Result, 1 + GetImages(AProperties).Width + 1);
end;   

class function TdxPSFontNameComboBoxDataMap.PropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomFontNameComboBoxProperties;
end;
  
{$IFDEF REGISTERCXSHELLCTRLS}
 
{ TdxPSShellComboBoxDataMap }

class function TdxPSShellComboBoxDataMap.GetImageIndex(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue): Integer;
var
  Text: string;  
  Stub: Integer;
begin
  TcxCustomShellComboBoxPropertiesAccess(AProperties).GetShellDisplayValue(AValue, False, Text, Result, Stub);
end;

class procedure TdxPSShellComboBoxDataMap.GetImageLists(AProperties: TcxCustomEditProperties; 
  AProc: TdxPSGetImageListProc);
begin
  AProc(GetImages(AProperties));
end;  
  
class function TdxPSShellComboBoxDataMap.GetImages(AProperties: TcxCustomEditProperties): TCustomImageList;
begin
  Result := dxPSUtl.ShellSmallImages; //cxShellComboBox.cxShellComboBoxImageList
end;

class function TdxPSShellComboBoxDataMap.HasImages(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := GetImages(AProperties) <> nil;
end;

class procedure TdxPSShellComboBoxDataMap.InitializeItem(AnItem: TAbstractdxReportCellData; 
  AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
  const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams; 
  AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil);
begin
  inherited;
  with TdxReportCellImage(AnItem) do
  begin
    if not TcxCustomShellComboBoxPropertiesAccess(AProperties).FastSearch then
    begin
      ImageList := GetImages(AProperties);
      ImageIndex := GetImageIndex(AProperties, AValue);
    end;
    EndEllipsis := True;
    MakeSpaceForEmptyImage := True;
  end;
end;

class function TdxPSShellComboBoxDataMap.ItemClass(AProperties: TcxCustomEditProperties; 
  AnIsPreview: Boolean = False): TdxReportCellDataClass;
begin
  Result := TdxReportCellImage;
end;
  
class function TdxPSShellComboBoxDataMap.PropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomShellComboBoxProperties;
end;

class function TdxPSShellComboBoxDataMap.MeasureWidth(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue; const ACellParams: IdxPSCellParams; AFont: TFont;
  ARecordIndex: Integer = 0): Integer;
begin
  Result := inherited MeasureWidth(AProperties, AValue, ACellParams, AFont, ARecordIndex);
  if not TcxCustomShellComboBoxPropertiesAccess(AProperties).FastSearch then
    Inc(Result, 1 + GetImages(AProperties).Width + 1);
end; 

{$ENDIF}

{ TdxPSLabelDataMap }

class function TdxPSLabelDataMap.DoesItemParticipateInAutoWidthCalculation(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := True;
end;

class function TdxPSLabelDataMap.DoesItemParticipateInBestFitCalculation(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := True;
end;

class procedure TdxPSLabelDataMap.InitializeItem(AnItem: TAbstractdxReportCellData; 
  AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
  const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams; 
  AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil);
begin
  inherited;
end;

class function TdxPSLabelDataMap.PropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomLabelProperties;
end;

{ TdxPSProgressBarDataMap }

class function TdxPSProgressBarDataMap.GetValue(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue): Double;
  
  function DropPercentSymbol(const AText: string): string;
  var
    P: Integer;
  begin
    Result := AText;
    P := Pos(PercentSymbol, Result);
    if P <> 0 then
    begin
      Delete(Result, P, Length(PercentSymbol));
      if Result[Length(Result)] = ' ' then
        Delete(Result, Length(Result), 1);
    end;  
  end;
  
var
  Text: string;
  Code: Integer;
begin
  Text := GetText(AProperties, AValue);
  Text := DropPercentSymbol(Text);
  Val(Text, Result, Code);
  if Code <> 0 then Result := 0;
end;
  
class function TdxPSProgressBarDataMap.HasText(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue): Boolean;
begin
  Result := inherited HasText(AProperties, AValue) and ProgressBarProperties_GetShowText(AProperties);
end;
  
class procedure TdxPSProgressBarDataMap.InitializeItem(AnItem: TAbstractdxReportCellData; 
  AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
  const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams; 
  AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil);
begin
  with TdxReportCellProgressBar(AnItem) do
  begin
    MaxValue := ProgressBarProperties_GetMaxValue(AProperties);
    MinValue := ProgressBarProperties_GetMinValue(AProperties);
    Multiline := False;
    Orientation := ProgressBarProperties_GetOrientation(AProperties);
    ProgressColor := ProgressBarProperties_GetProgressBarColor(AProperties);
    ShowPercentSymbol := ProgressBarProperties_GetShowPercentSymbol(AProperties);
    ShowText := ProgressBarProperties_GetShowText(AProperties);
    if ShowText then
      Text := ProgressBarProperties_GetText(AProperties);
    Value := GetValue(AProperties, AValue);
  end;  
end;

class function TdxPSProgressBarDataMap.ItemClass(AProperties: TcxCustomEditProperties; 
  AnIsPreview: Boolean = False): TdxReportCellDataClass;
begin
  Result := TdxReportCellProgressBar;
end;

class function TdxPSProgressBarDataMap.PropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomProgressBarProperties;
end;

{ TdxPSTrackBarDataMap }

class procedure TdxPSTrackBarDataMap.InitializeItem(AnItem: TAbstractdxReportCellData;
  AProperties: TcxCustomEditProperties; const AValue: TcxEditValue;
  const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams;
  AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil);
begin
  inherited;
  with TdxReportCellString(AnItem) do
  begin
    Multiline := False;
    TextAlignX := taLeft;
    TextAlignY := taCenterY;
  end;  
end;

class function TdxPSTrackBarDataMap.ItemClass(AProperties: TcxCustomEditProperties; 
  AnIsPreview: Boolean = False): TdxReportCellDataClass;
begin
  Result := TdxReportCellString;
end;

class function TdxPSTrackBarDataMap.PropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomTrackBarProperties;
end;


{ TdxPSCheckButtonGroupDataMap }

class function TdxPSCheckButtonGroupDataMap.ButtonGroupClass(AProperties: TcxCustomEditProperties): TdxCustomReportButtonGroupClass;
begin
  Result := TdxReportCheckGroup;
end;

class procedure TdxPSCheckButtonGroupDataMap.InitializeGroupButton(AProperties: TcxCustomEditProperties; 
  const AValue: TcxEditValue; AButton: TdxCustomReportCellCheck; AnIndex: Integer);
var
  CheckStates: TcxCheckStates; 
begin
  inherited;
  AButton.CheckPos := CheckGroupProperties_GetCheckPos(AProperties);
  if CheckGroupProperties_GetCheckStates(AProperties, AValue, CheckStates) then
  begin
    AButton.Checked := CheckStates[AnIndex] in [cbsChecked, cbsGrayed];
    AButton.Enabled := (CheckStates[AnIndex] <> cbsGrayed) and CheckGroupProperties_GetIsItemEnabled(AProperties, AnIndex);
  end
  else
  begin
    AButton.Checked := False;
    AButton.Enabled := True;
  end;  
end;
  
class procedure TdxPSCheckButtonGroupDataMap.InitializeItem(AnItem: TAbstractdxReportCellData; 
  AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
  const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams; 
  AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil);
var
  CheckGlyph: TBitmap;
begin
  inherited;
  with TdxReportCheckGroup(AnItem) do
  begin
    CheckGlyph := CheckGroupProperties_GetGlyph(AProperties);
    if not CheckGlyph.Empty then
    begin
      Glyph := CheckGlyph;
      GlyphCount := CheckGroupProperties_GetGlyphCount(AProperties);
    end;  
  end;  
end;          

class function TdxPSCheckButtonGroupDataMap.PropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomCheckGroupProperties;
end;

{ TdxPSRichEditDataMap }

class function TdxPSRichEditDataMap.DataMapClass(AProperties: TcxCustomEditProperties): TdxPSDataMapClass;
const
  DataMapClasses: array[Boolean] of TdxPSDataMapClass = (TdxPSRichTextDataMap, TdxPSMemoDataMap);
begin
  Result := DataMapClasses[RichEditProperties_GetIsMemoMode(AProperties)];
end;

class function TdxPSRichEditDataMap.PropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomRichEditProperties;
end;

{ TdxPSRichEditDataMap }

class function TdxPSRichTextDataMap.DoesItemParticipateInBestFitCalculation(AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := False;
end;

class procedure TdxPSRichTextDataMap.InitializeItem(AnItem: TAbstractdxReportCellData; 
  AProperties: TcxCustomEditProperties; const AValue: TcxEditValue; 
  const ACellParams: IdxPSCellParams; var AViewParams: TdxReportItemViewParams; 
  AnIsPreview: Boolean = False; ARecordIndex: Integer = -1; AOwner: TObject = nil);

  function GetGraphicClass: TGraphicClass;
  var
    CellParams2: IdxPSCellParams2;
  begin       
    if Supports(ACellParams, IdxPSCellParams2, CellParams2) then
      Result := CellParams2.RichEditGraphicClass
    else
      Result := TMetafile;
  end;

  function GetImageTransparent: Boolean;
  var
    CellParams2: IdxPSCellParams2;
  begin       
    Result := Supports(ACellParams, IdxPSCellParams2, CellParams2) and CellParams2.GetRichEditTransparent;
  end;

  function GetMargins: TRect;
  var
    CellParams2: IdxPSCellParams2;
  begin   
    if AnIsPreview and Supports(ACellParams, IdxPSCellParams2, CellParams2) then
      with Result do 
      begin
        Left := CellParams2.PreviewMarginLeft;
        Top := dxTextSpace;
        Right := CellParams2.PreviewMarginRight;
        Bottom := dxTextSpace;
      end
    else
      Result := Rect(dxTextSpace, dxTextSpace, dxTextSpace, dxTextSpace);
  end;

  function GetMaxHeight: Integer;
  var
    CellParams2: IdxPSCellParams2;
  begin       
    if Supports(ACellParams, IdxPSCellParams2, CellParams2) then
      Result := CellParams2.PreviewMaxHeight
    else
      Result := -1;  
  end;
  
var
  Graphic: TGraphic;
begin
  RichEdit.Clear;
  inherited;
  cxRichEdit.SetRichEditText(RichEdit, AValue);
  try
    RichEdit.Color := AViewParams.NativeParams.Color;
    Graphic := dxPSRELnk.GetRichEditAsGraphic(RichEdit.Handle,
      AViewParams.NativeParams.Color, GetMargins, GetGraphicClass,
      AnItem.Width, -1, GetMaxHeight, 0, dxDefaultRichEditVersion);
    try
      TdxReportCellRichEditGraphic(AnItem).Image := Graphic;
      TdxReportCellRichEditGraphic(AnItem).ImageTransparent := GetImageTransparent;
      TdxReportCellRichEditGraphic(AnItem).Transparent := GetImageTransparent;
    finally
      Graphic.Free;
    end;
  finally
    cxRichEdit.SetRichEditText(RichEdit, '');
  end;
end;

class function TdxPSRichTextDataMap.ItemClass(AProperties: TcxCustomEditProperties; 
  AnIsPreview: Boolean = False): TdxReportCellDataClass;
begin
  Result := TdxReportCellRichEditGraphic;//TdxReportCellGraphic;
end;


procedure RegisterAssistants;  
begin
  TdxPSColorComboBoxDataMap.Register;
  TdxPSFontNameComboBoxDataMap.Register;
 {$IFDEF REGISTERCXSHELLCTRLS}
  TdxPSShellComboBoxDataMap.Register;
 {$ENDIF}
  TdxPSLabelDataMap.Register;
  TdxPSProgressBarDataMap.Register;
  TdxPSTrackBarDataMap.Register;
  TdxPSCheckButtonGroupDataMap.Register;
  TdxPSRichEditDataMap.Register;
end;

procedure RegisterItems;
begin
  TdxReportCellColorBox.Register;
  TdxReportCellProgressBar.Register;
end;

procedure UnregisterAssistants;
begin
  TdxPSRichEditDataMap.Unregister;
  TdxPSCheckButtonGroupDataMap.Unregister;
  TdxPSTrackBarDataMap.Unregister;
  TdxPSProgressBarDataMap.Unregister;
  TdxPSLabelDataMap.Unregister;
 {$IFDEF REGISTERCXSHELLCTRLS}
  TdxPSShellComboBoxDataMap.Unregister;
 {$ENDIF} 
  TdxPSFontNameComboBoxDataMap.Unregister;
  TdxPSColorComboBoxDataMap.Unregister;
end;

procedure UnregisterItems;
begin
  TdxReportCellProgressBar.Unregister;
  TdxReportCellColorBox.Unregister;
end;

initialization
  RegisterAssistants;
  RegisterItems;

finalization
  UnregisterItems;
  UnregisterAssistants;

  FreeAndNil(FFontImages);
  FreeAndNil(FRichEdit);
  FreeAndNil(FRichEditSite);

end.
  
