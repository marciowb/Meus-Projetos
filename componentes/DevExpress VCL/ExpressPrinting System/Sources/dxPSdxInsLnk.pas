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

unit dxPSdxInsLnk;

interface

{$I cxVer.inc}

uses
  Classes, Windows, Graphics, ExtCtrls, StdCtrls, Controls, ComCtrls, Dialogs, 
  ImgList, Forms, dxInspct, dxExEdtr, dxInspRw, dxCntner, dxPSGlbl, dxPSCore, 
  dxBase, cxDrawTextUtils;

type
  TdxInspectorPaintOption = (ipoBorder, ipoHorzLines, ipoVertLines,
    ipoFlatCheckMarks, ipoCheckMarksAsText,
    ipoImages, ipoTransparentRowGraphic, ipoGraphicAsText, 
    ipoExpandButtons);
  TdxInspectorPaintOptions = set of TdxInspectorPaintOption;

  TdxInspectorRowHelperClass = class of TdxInspectorRowHelper;
  
  TdxInspectorRowHelper = class(TdxCustomClassMapItem)
  protected
    class procedure GetImageLists(ARow: TdxInspectorRow; AProc: TdxPSGetImageListProc); virtual;
  public
    class function PairClass: TClass; override;
    class procedure Register;
    class function RowClass: TdxInspectorRowClass; virtual;
  end;

  TdxInspectorImageRowHelper = class(TdxInspectorRowHelper)
  protected
    class procedure GetImageLists(ARow: TdxInspectorRow; AProc: TdxPSGetImageListProc); override;
  public
    class function RowClass: TdxInspectorRowClass; override;
  end;
  
  TdxInspectorReportLinkCustomEvent = procedure(Sender: TBasedxReportLink; 
    ARow: TdxInspectorRow; ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; 
    var AText: string; var AColor: TColor; AFont: TFont; 
    var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
    var ADone: Boolean) of object;

  TCustomdxInspectorReportLink = class(TBasedxReportLink)
  private
    FAutoNodesExpand: Boolean;
    FAutoWidth: Boolean;
    FDefaultGroupFont: TFont;
    FFixedTransparent: Boolean;
    FFixedColor: TColor;
    FFixedFont: TFont;
    FGraphicAsTextText: string;
    FGridLineColor: TColor;
    FGroupColor: TColor;
    FGroupFont: TFont;
    FGroupTransparent: Boolean;
    FIsGraphicAsTextAssigned: Boolean;
    FOddFont: TFont;
    FOptions: TdxInspectorPaintOptions;
    FSupportedCustomDraw: Boolean;
    FOnCustomDrawCaption: TdxInspectorReportLinkCustomEvent;
    FOnCustomDrawValue: TdxInspectorReportLinkCustomEvent;
    FOnCustomDrawCaptionSeparator: TdxInspectorReportLinkCustomEvent;
    FOnCustomDrawValueSeparator: TdxInspectorReportLinkCustomEvent;
    FCustomDrawFontChanged: Boolean;
    FFixedFontIndex: Integer;
    FGroupFontIndex: Integer;
    FSaveFont: TFont;
    // Layout fields
    FCaptionWidth: Integer;    
    FBandCount: Integer;
    FBands: TList;
    FBandWidth: Integer;
    FFullWidth: Integer;
    FIndent: Integer;
    FMaxBandHeight: Integer;
    FRowHeight: Integer;
    FRowHeights: TList;
    FRows: TList;
    FValueWidth: Integer;
    function GetCustomInspector: TCustomdxInspectorControl;
    function GetGraphicAsTextText: string;
    function GetOddColor: TColor;
    function GetOptions: TdxInspectorPaintOptions;
    function IsGraphicAsTextTextStored: Boolean;
    function IsGroupFontStored: Boolean;
    procedure SetAutoNodesExpand(Value: Boolean);
    procedure SetAutoWidth(Value: Boolean);
    procedure SetFixedColor(Value: TColor);
    procedure SetFixedFont(Value: TFont);
    procedure SetFixedTransparent(Value: Boolean);
    procedure SetGraphicAsTextText(const Value: string);
    procedure SetGridLineColor(Value: TColor);
    procedure SetGroupFont(Value: TFont);
    procedure SetGroupNodeColor(Value: TColor);
    procedure SetGroupTransparent(Value: Boolean);    
    procedure SetOddFont(Value: TFont);
    procedure SetOddColor(Value: TColor);
    procedure SetOnCustomDrawCaption(Value: TdxInspectorReportLinkCustomEvent);
    procedure SetOnCustomDrawValue(Value: TdxInspectorReportLinkCustomEvent);
    procedure SetOnCustomDrawCaptionSeparator(Value: TdxInspectorReportLinkCustomEvent);
    procedure SetOnCustomDrawValueSeparator(Value: TdxInspectorReportLinkCustomEvent);
    procedure SetOptions(Value: TdxInspectorPaintOptions);
    procedure SetSupportCustomDraw(Value: Boolean);

    procedure CalcAutoWidths;
    procedure CalcLayout;
    procedure CalcMaxBandHeight;
    procedure CalcRowHeights;
    procedure CalcStandardRowHeight;
    procedure CustomDrawFontChanged(Sender: TObject);
    function GetRow(AIndex: Integer): TdxInspectorRow;
    function GetRowCellSides(ARow: TdxInspectorRow): TdxCellSides;
    function GetRowCaptionColor(ARow: TdxInspectorRow): TColor;
    function GetRowCaptionCellSides(ARow: TdxInspectorRow): TdxCellSides;
    function GetRowCaptionTransparency(ARow: TdxInspectorRow): Boolean;
    function GetRowHeight(ARowIndex: Integer): Integer;
    function GetRowIndentCellSides(ARow: TdxInspectorRow; ALevelIndex: Integer): TdxCellSides;
    function GetRowIndentColor(ARow: TdxInspectorRow; ALevelIndex: Integer): TColor;
    function GetRowIndentCount(ARow: TdxInspectorRow): Integer;
    function GetRowIndentTransparency(ARow: TdxInspectorRow; ALevelIndex: Integer): Boolean;
    function GetRowSeparatorCellSides(ARow: TdxInspectorRow): TdxCellSides;
    function GetRowTextIndent(ARow: TdxInspectorRow; AIncludeImageWidth: Boolean): Integer;    
    function GetRowValueCellSides(ARow: TdxInspectorRow): TdxCellSides;
    function GetRowValueText(ARow: TdxInspectorRow): string;    
    procedure PlaceRow(ARow: TdxInspectorRow; ARowIndex: Integer; ACell: TdxReportCell);

    function IsCheckMarksAsText: Boolean;
    function IsDisplayGraphicsAsText: Boolean;
    function IsDrawAnyLines: Boolean;
    function IsDrawBorder: Boolean;                           
    function IsDrawEndEllipsis: Boolean;
    function IsDrawExpandButtons: Boolean;    
    function IsDrawHorzLines: Boolean;
    function IsDrawVertLines: Boolean;
    function IsFlatCheckMarks: Boolean;
    function IsShowExpandButtons: Boolean;
    function IsShowImages: Boolean;
    function IsTransparentColumnGraphics: Boolean;
    
    function IsAutoBandCount: Boolean;    
    function IsBottomRow(ARow: TdxInspectorRow): Boolean;
    function IsRowAutoHeight: Boolean;
    function IsRowCaptionMultilined(ARow: TdxInspectorRow): Boolean;
    function IsRowValueMultilined(ARow: TdxInspectorRow): Boolean;    
    function IsTopRow(ARow: TdxInspectorRow): Boolean;

    procedure InsertRowCaption(ACell: TdxReportCell; ARow: TdxInspectorRow; ARowIndex: Integer);
    procedure InsertRowImage(ACell: TdxReportCell; ARow: TdxInspectorRow);
    procedure InsertRowIndent(ACell: TdxReportCell; ARow: TdxInspectorRow);
    procedure InsertRowValue(ACell: TdxReportCell; ARow: TdxInspectorRow; ARowIndex: Integer);    
        
    procedure CalcComplexRowItemsWidths;
    function CanDrawRowImage(ARow: TdxInspectorRow): Boolean;    
    function ComplexRowByRow(ARow: TdxInspectorRow): TdxInspectorComplexRow;
    function GetComplexRowSeparatorText(ARow: TdxInspectorRow): string;
    function GetRowImageCellSides(ARow: TdxInspectorRow): TdxCellSides;    
    function GetRowItemByRow(ARow: TdxInspectorRow): Pointer;
    function GetUltimateParentRow(ARow: TdxInspectorRow): TdxInspectorRow;
    function IsComplexRowSeparator(ARow: TdxInspectorComplexRow; AIndex: Integer): Boolean;
    function IsNetCategoryRow(ARow: TdxInspectorRow): Boolean;
    function IsNetMode: Boolean;    
    function IsNetUltimateLastRowInParent(ARow: TdxInspectorRow): Boolean;

    procedure AddRows;
    procedure ClearRows;
    procedure DistributeRowsByBands;
    procedure FreeAndNilRows;

    procedure ClearBands;
    procedure FreeAndNilBands;
    
    procedure ReadIsGraphicAsTextValueAssigned(AReader: TReader);
    procedure WriteIsGraphicAsTextValueAssigned(AWriter: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure GetImageLists(AProc: TdxPSGetImageListProc); override;
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;
    procedure MakeDelimiters(AReportCells: TdxReportCells; AHorzDelimiters,
      AVertDelimiters: TList); override;

    procedure AssignValues(ADataItem: TAbstractdxReportCellData;
      ARow: TdxInspectorRow); virtual;
    function GetDataClass(ARow: TdxInspectorRow): TdxReportCellDataClass; virtual;
    procedure GetImageListsFromRows(AProc: TdxPSGetImageListProc); virtual;
    function GetRowFontIndex(ARow: TdxInspectorRow): Integer; virtual;
    procedure PrepareConstruct(AReportCells: TdxReportCells); virtual;
    procedure UnprepareConstruct(AReportCells: TdxReportCells); virtual;

    procedure CustomDraw(AItem: TAbstractdxReportCellData; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); override;
    procedure DoCustomDrawCaption(ARow: TdxInspectorRow; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var AText: string; var AColor: TColor; 
      AFont: TFont; var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
      var ADone: Boolean); virtual;
    procedure DoCustomDrawValue(ARow: TdxInspectorRow; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var AText: string; var AColor: TColor; 
      AFont: TFont;  var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
      var ADone: Boolean); virtual;
    procedure DoCustomDrawCaptionSeparator(ARow: TdxInspectorRow; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var AText: string; var AColor: TColor; 
      AFont: TFont; var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
      var ADone: Boolean); virtual;
    procedure DoCustomDrawValueSeparator(ARow: TdxInspectorRow; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var AText: string; var AColor: TColor; 
      AFont: TFont;  var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
      var ADone: Boolean); virtual;      
    function IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean; override;

    procedure InitializeDefaultGroupFont(AFont: TFont);
    
    property CustomInspector: TCustomdxInspectorControl read GetCustomInspector;
  published
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultGraphicAsTextText: string; virtual;
    function DefaultGroupFont: TFont; virtual;

    property AutoNodesExpand: Boolean read FAutoNodesExpand write SetAutoNodesExpand default False;
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth default False;
    property Color;
    property FixedTransparent: Boolean read FFixedTransparent write SetFixedTransparent default False;
    property FixedColor: TColor read FFixedColor write SetFixedColor default clBtnFace; {dxDefaultFixedColor}
    property FixedFont: TFont read FFixedFont write SetFixedFont stored IsFontStored;
    property Font;
    property GraphicAsTextText: string read GetGraphicAsTextText write SetGraphicAsTextText stored IsGraphicAsTextTextStored;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor default clBlack; {dxDefaultGridLineColor}
    property GroupColor: TColor read FGroupColor write SetGroupNodeColor default clBtnFace; {dxDefaultFixedColor}
    property GroupFont: TFont read FGroupFont write SetGroupFont stored IsGroupFontStored;
    property GroupTransparent: Boolean read FGroupTransparent write SetGroupTransparent default False;    
    property OddColor: TColor read GetOddColor write SetOddColor default clWhite; {clDefaultColor}
    property OddFont: TFont read FOddFont write SetOddFont stored IsFontStored;
    property Options: TdxInspectorPaintOptions read GetOptions write SetOptions
      default [ipoBorder..ipoFlatCheckMarks , 
               ipoImages , ipoExpandButtons]; {dxDefaultInspectorPaintOptions}
    property ScaleFonts;
    property SupportedCustomDraw: Boolean read FSupportedCustomDraw write SetSupportCustomDraw  default False;
    property Transparent;
    property UseHorzDelimiters;    
    property UseVertDelimiters;
    
    property OnCustomDrawCaption: TdxInspectorReportLinkCustomEvent read FOnCustomDrawCaption write SetOnCustomDrawCaption;
    property OnCustomDrawValue: TdxInspectorReportLinkCustomEvent read FOnCustomDrawValue write SetOnCustomDrawValue;
    property OnCustomDrawCaptionSeparator: TdxInspectorReportLinkCustomEvent read FOnCustomDrawCaptionSeparator write SetOnCustomDrawCaptionSeparator;
    property OnCustomDrawValueSeparator: TdxInspectorReportLinkCustomEvent read FOnCustomDrawValueSeparator write SetOnCustomDrawValueSeparator;
  end;

  TdxInspectorReportLink = class(TCustomdxInspectorReportLink)
  private
    function GetInspector: TdxInspector;
  public
    property Inspector: TdxInspector read GetInspector;
  end;

  TdxInspectorDesignWindow = class(TStandarddxReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshOptions: TTabSheet;
    tshColors: TTabSheet;
    tshFonts: TTabSheet;
    pnlPreview: TPanel;
    chbxTransparent: TCheckBox;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    bvlColorHolder: TBevel;
    chbxCaptionTransparent: TCheckBox;
    gbxCaptionTransparent: TGroupBox;
    lblCaptionColor: TLabel;
    bvlFixedColorHolder: TBevel;
    lblGridLinesColor: TLabel;
    bvlGridLineColorHolder: TBevel;
    lblShow: TLabel;
    bvlShow: TBevel;
    chbxShowBorders: TCheckBox;
    chbxShowHorzLines: TCheckBox;
    chbxShowVertLines: TCheckBox;
    btnFont: TButton;
    edFont: TEdit;
    btnGroupFont: TButton;
    edGroupFont: TEdit;
    btnFixedFont: TButton;
    edFixedFont: TEdit;
    chbxShowImages: TCheckBox;
    gbxGroupTransparent: TGroupBox;
    chbxGroupTransparent: TCheckBox;
    lblGroupColor: TLabel;
    bvlGroupColorHolder: TBevel;
    imgGrid: TImage;
    chbxShowExpandButtons: TCheckBox;
    ilVendorLogos: TImageList;
    ilCarPhotos: TImageList;
    tshFormatting: TTabSheet;
    lblRefinements: TLabel;
    bvlAppearance: TBevel;
    chbxFlatCheckMarks: TCheckBox;
    chbxCheckMarksAsText: TCheckBox;
    imgGraphics: TImage;
    chbxDisplayGraphicsAsText: TCheckBox;
    chbxTransparentColumnGraphics: TCheckBox;
    lblBehaviors: TLabel;
    chbxAutoNodesExpand: TCheckBox;
    chbxAutoWidth: TCheckBox;
    bvlBehaviors: TBevel;
    Image4: TImage;
    lblPreview: TStaticText;
    pnlPreviewHost: TPanel;
    insPreview: TdxInspector;
    irMersedesBenz: TdxInspectorTextRow;
    irMBPhoto: TdxInspectorTextGraphicRow;
    irMBSUV: TdxInspectorTextCheckRow;
    irMBModel: TdxInspectorTextRow;
    irBMW: TdxInspectorTextRow;
    irBMWModel: TdxInspectorTextRow;
    irBMWSUV: TdxInspectorTextCheckRow;
    irBMWPhoto: TdxInspectorTextGraphicRow;
    stTransparent: TStaticText;
    stCaptionTransparent: TStaticText;
    stGroupTransparent: TStaticText;
    procedure chbxAutoNodesExpandClick(Sender: TObject);
    procedure chbxTransparentClick(Sender: TObject);
    procedure chbxAutoWidthClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure chbxOptionsClick(Sender: TObject);
    procedure irMBSUVDrawValue(Sender: TdxInspectorRow;
      ACanvas: TCanvas; ARect: TRect; var AText: String; AFont: TFont;
      var AColor: TColor; var ADone: Boolean);
    procedure InspectorDrawValue(Sender: TdxInspectorRow; ACanvas: TCanvas;
      ARect: TRect; var AText: String; AFont: TFont; var AColor: TColor;
      var ADone: Boolean);
    procedure irMBPhotoDrawValue(Sender: TdxInspectorRow; ACanvas: TCanvas;
      ARect: TRect; var AText: String; AFont: TFont; var AColor: TColor;
      var ADone: Boolean);
    procedure InspectorDrawCaption(Sender: TdxInspectorRow;
      ACanvas: TCanvas; ARect: TRect; var AText: String; AFont: TFont;
      var AColor: TColor; var ADone: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure stTransparentClick(Sender: TObject);
    procedure stCaptionTransparentClick(Sender: TObject);
    procedure stGroupTransparentClick(Sender: TObject);
  private
    FccbxColor: TCustomComboBox;
    FccbxCaptionColor: TCustomComboBox;
    FccbxGroupColor: TCustomComboBox;
    FccbxGridLineColor: TCustomComboBox;

    procedure ccbxColorChange(Sender: TObject);    
    procedure CreateControls;
    function GetReportLink: TCustomdxInspectorReportLink;
    procedure LoadDataToInspector;
    function CaptionColor: TColor;
    function GroupColor: TColor;
    function ValueColor: TColor;
    
    procedure CMDialogChar(var message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure DoInitialize; override;  
    {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
    {$ENDIF}
    procedure LoadStrings; override;
    procedure UpdateControlsState; override;  
    procedure UpdatePreview; override;  
  public
    constructor Create(AOwner: TComponent); override;
    property ReportLink: TCustomdxInspectorReportLink read GetReportLink;
  end;

  TdxInspectorColumnMapperProc = function(ARow: TdxInspectorRow;
    AReportLink: TCustomdxInspectorReportLink): TdxReportCellDataClass;
  TdxInspectorAssignDataProc = procedure(AReportLink: TCustomdxInspectorReportLink;
    ADataItem: TAbstractdxReportCellData; AInspector: TCustomdxInspector; 
    ARow: TdxInspectorRow);

function DefaultdxInspectorMapperProc(ARow: TdxInspectorRow;
  AReportLink: TCustomdxInspectorReportLink): TdxReportCellDataClass;
procedure DefaultdxInspectorAssignDataProc(AReportLink: TCustomdxInspectorReportLink;
  ADataItem: TAbstractdxReportCellData; AInspector: TCustomdxInspector;
  ARow: TdxInspectorRow);

const
  FdxInspectorAssignDataProc: TdxInspectorAssignDataProc = DefaultdxInspectorAssignDataProc;
  FdxInspectorColumnMapperProc: TdxInspectorColumnMapperProc = DefaultdxInspectorMapperProc;

  dxDefaultInspectorPaintOptions: TdxInspectorPaintOptions = 
    [ipoBorder..ipoFlatCheckMarks , ipoImages , 
     ipoExpandButtons];
  
implementation

{$R *.DFM}

uses
  SysUtils, Math, cxClasses, dxExtCtrls, dxPSRes, dxPrnDev, dxPSUtl;

var 
  FPicture: TPicture;
  
type
  TCustomdxInspectorControlAccess = class(TCustomdxInspectorControl);
  TdxInspectorRowAccess = class(TdxInspectorRow);
  TdxInspectorGraphicRowAccess = class(TdxInspectorGraphicRow);
  TdxInspectorMemoRowAccess = class(TdxInspectorMemoRow);
  
  TdxInspectorCellType = (ictNone, ictCaption, ictValue, ictCaptionSeparator, ictValueSeparator);

  PdxRowItem = ^TdxRowItem;
  TdxRowItem = record
    Row: TdxInspectorRow;
    CaptionWidths: TList;
    ValueWidths: TList;
  end;

  PdxBandItem = ^TdxBandItem;
  TdxBandItem = record
    Rows: TList;
  end;

function GetTextWidth(ADC: HDC; AFont: HFONT; const S: string): Integer;
var
  TextSize: TSize;
begin
  if S <> '' then
  begin
    SelectObject(ADC, AFont);
    GetTextExtentPoint32(ADC, PChar(S), Length(S), TextSize);
    Result := 3 + TextSize.cX + 3;
  end
  else
    Result := 0;
end;
  
 {TdxInspectorRow, TdxInspectorMaskRow, TdxInspectorMemoRow,
  TdxInspectorDateRow, TdxInspectorButtonRow,TdxInspectorCheckRow,
  TdxInspectorImageRow, TdxInspectorSpinRow, TdxInspectorPickRow, 
  TdxInspectorHyperLinkRow, TdxInspectorTimeRow, TdxInspectorCurrencyRow, 
  TdxInspectorGraphicRow, TdxInspectorBlobRow, TdxInspectorMRURow,   
  TdxInspectorPopupRow, TdxInspectorLookupRow, TdxInspectorCalcRow, 
  TdxInspectorExtLookupRow}

function DefaultdxInspectorMapperProc(ARow: TdxInspectorRow;
  AReportLink: TCustomdxInspectorReportLink): TdxReportCellDataClass;
const
  CheckClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellCheckImage, TdxReportCellString);
  ImageClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellGraphic, TdxReportCellImage);  
  GraphicClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellString, TdxReportCellGraphic);    
begin
  if ARow is TdxInspectorCheckRow then
    Result := CheckClasses[ipoCheckMarksAsText in AReportLink.Options]
  else 
    if ARow is TdxInspectorImageRow then
      Result := ImageClasses[TdxInspectorImageRow(ARow).ShowDescription]
    else
      Result := GraphicClasses[(ARow is TdxInspectorGraphicRow) and not (ipoGraphicAsText in AReportLink.Options)];
end;

procedure DefaultdxInspectorAssignDataProc(AReportLink: TCustomdxInspectorReportLink;
  ADataItem: TAbstractdxReportCellData; AInspector: TCustomdxInspector;
  ARow: TdxInspectorRow);
var
  AState: TCheckBoxState;
  ANullStyle: TdxShowNullFieldStyle;
  AImageIndex, ATextIndex: Integer;
  S: string;
  GraphicClass: TGraphicClass;
  BaseRow: TdxInspectorRow;
  ComplexRow: TdxInspectorComplexRow;
begin
  case TdxInspectorCellType(ADataItem.Data) of 
    ictCaptionSeparator: 
      with TdxReportCellString(ADataItem) do 
      begin
        CellSides := AReportLink.GetRowSeparatorCellSides(ARow);
        EndEllipsis := AReportLink.IsDrawEndEllipsis;
        FontIndex := AReportLink.GetRowFontIndex(ARow);
        Indent := 0;
        Text := AReportLink.GetComplexRowSeparatorText(ARow);
        TextAlignX := taCenterX;
        TextAlignY := taCenterY;
        Transparent := AReportLink.GetRowCaptionTransparency(ARow);
        if not Transparent then 
          Color := AReportLink.GetRowCaptionColor(ARow);
      end;
    ictValueSeparator:   
      with TdxReportCellString(ADataItem) do 
      begin
        CellSides := AReportLink.GetRowSeparatorCellSides(ARow);
        EndEllipsis := AReportLink.IsDrawEndEllipsis;
        FontIndex := 0;
        Indent := 0;
        Text := AReportLink.GetComplexRowSeparatorText(ARow);
        TextAlignX := taCenterX;
        TextAlignY := taCenterY;
        Transparent := AReportLink.Transparent;
        if not Transparent then 
          Color := AReportLink.Color;
      end;
    ictCaption:
      with TdxReportCellString(ADataItem) do 
      begin
        CellSides := AReportLink.GetRowCaptionCellSides(ARow);
        EndEllipsis := AReportLink.IsDrawEndEllipsis;
        FontIndex := AReportLink.GetRowFontIndex(ARow);
        Indent := 2;
        BaseRow := ARow;
        ComplexRow :=  AReportLink.ComplexRowByRow(ARow);
        if ComplexRow <> nil then BaseRow := ComplexRow;
        Multiline := AReportLink.IsRowCaptionMultilined(BaseRow);
        Text := ARow.Caption;
        TextAlignY := dxMultilineTextAlignY[Multiline];
        Transparent := AReportLink.GetRowCaptionTransparency(ARow);
        if not Transparent then 
          Color := AReportLink.GetRowCaptionColor(ARow);
      end;
    ictValue:
      if TdxInspectorCellType(ADataItem.Data) = ictValue then
      begin
        TdxReportVisualItem(ADataItem).CellSides := AReportLink.GetRowValueCellSides(ARow);
        TdxReportVisualItem(ADataItem).Transparent := AReportLink.Transparent;
        if not TdxReportVisualItem(ADataItem).Transparent then
          TdxReportVisualItem(ADataItem).Color := AReportLink.Color;
        if ADataItem is TdxReportCellCheck then
          with TdxReportCellCheck(ADataItem) do
          
          begin
            AState := TCheckBoxState(TdxInspectorCheckRow(ARow).GetCheckBoxState(AReportLink.GetRowValueText(ARow)));
            ANullStyle := TdxInspectorCheckRow(ARow).ShowNullFieldStyle;
            Enabled := not ((AState = cbGrayed) and (ANullStyle > nsUnchecked));
            Checked := (AState = cbChecked) or 
              ((AState = cbGrayed) and (ANullStyle = nsGrayedChecked));
            FlatBorder := AReportLink.IsFlatCheckMarks;
          end
        else 
          if ADataItem is TdxReportCellImage then
            with TdxReportCellImage(ADataItem) do
            begin
              S := AReportLink.GetRowValueText(ARow);
              TdxInspectorImageRow(ARow).GetIndexes(S, AImageIndex, ATextIndex);
              if ATextIndex <> -1 then 
                Text := TdxInspectorImageRow(ARow).Descriptions[ATextIndex];
              ImageList := TdxInspectorImageRow(ARow).Images;
              ImageIndex := AImageIndex;
              MakeSpaceForEmptyImage := True;
              EndEllipsis := True;
              Multiline := TdxInspectorImageRow(ARow).MultilineText;
              TextAlignX := dxTextAlignX[ARow.Alignment];
              TextAlignY := dxMultilineTextAlignY[Multiline];
            end
          else 
            if ADataItem is TdxReportCellGraphic then
              if ARow is TdxInspectorGraphicRow then 
              begin
                GraphicClass := TdxInspectorGraphicRowAccess(ARow).GetGraphicClass;
                LoadPicture(FPicture, GraphicClass, TdxInspectorGraphicRowAccess(ARow).GetGraphicValue);
                if GraphicClass = nil then GraphicClass := TBitmap;
                with TdxReportCellGraphic(ADataItem) do
                begin
                  Image := FPicture.Graphic;
                  ImageTransparent := 
                    (ipoTransparentRowGraphic in AReportLink.Options) or GraphicClass.InheritsFrom(TIcon);
                  if not GraphicClass.InheritsFrom(TIcon) and TdxInspectorGraphicRow(ARow).Stretch then
                    DrawMode := gdmStretchProportional
                  else 
                    if TdxInspectorGraphicRow(ARow).Center then 
                      DrawMode := gdmCenter
                    else  
                      DrawMode := gdmNone;
                end
              end
              else
                with TdxReportCellGraphic(ADataItem) do
                begin
                  S := AReportLink.GetRowValueText(ARow);
                  TdxInspectorImageRow(ARow).GetIndexes(S, AImageIndex, ATextIndex);
                  ImageList := TdxInspectorImageRow(ARow).Images;
                  ImageIndex := AImageIndex;
                  DrawMode := gdmCenter;
                end
            else
             { TdxInspectorTextRow, TdxInspectorMaskRow, TdxInspectorDateRow
               TdxInspectorCalcRow, TdxInspectorButtonRow, TdxInspectorSpinRow,
               TdxInspectorPickRow, TdxInspectorTimeRow, TdxInspectorCurrencyRow,
               TdxInspectorHyperLinkRow }
              with TdxReportCellString(ADataItem) do
              begin
                Text := AReportLink.GetRowValueText(ARow);
                EndEllipsis := ioDrawEndEllipsis in TCustomdxInspectorControlAccess(AInspector).Options;
                Multiline := AReportLink.IsRowValueMultilined(ARow);
                TextAlignX := dxTextAlignX[ARow.Alignment];
                TextAlignY := dxMultilineTextAlignY[Multiline];
              end;
      end;
   end;   
end;

{ TdxRowHelpersFactory }

type
  TdxRowHelpersFactory = class(TdxCustomClassMaps)
  private
    function GetHelperClass(Row: TdxInspectorRow): TdxInspectorRowHelperClass;
  public
    class function Instance: TdxRowHelpersFactory; reintroduce; overload; 
    property HelperClasses[Row: TdxInspectorRow]: TdxInspectorRowHelperClass read GetHelperClass; default;
  end;

function dxRowHelpersFactory: TdxRowHelpersFactory;  
begin
  Result := TdxRowHelpersFactory.Instance;
end;

class function TdxRowHelpersFactory.Instance: TdxRowHelpersFactory;
begin
  Result := inherited Instance as TdxRowHelpersFactory;
end;

function TdxRowHelpersFactory.GetHelperClass(Row: TdxInspectorRow): TdxInspectorRowHelperClass;
begin
  Result := TdxInspectorRowHelperClass(PairClasses[Row.ClassType]);
end;
  
{ TdxInspectorRowHelper }

class function TdxInspectorRowHelper.PairClass: TClass;
begin
  Result := RowClass;
end;

class procedure TdxInspectorRowHelper.Register;
begin
  dxRowHelpersFactory.Register(Self);
end;

class function TdxInspectorRowHelper.RowClass: TdxInspectorRowClass;
begin
  Result := TdxInspectorRow;
end;

class procedure TdxInspectorRowHelper.GetImageLists(ARow: TdxInspectorRow; 
  AProc: TdxPSGetImageListProc);
begin
end;

{ TdxInspectorImageRowHelper }

class function TdxInspectorImageRowHelper.RowClass: TdxInspectorRowClass;
begin
  Result := TdxInspectorImageRow;
end;

class procedure TdxInspectorImageRowHelper.GetImageLists(ARow: TdxInspectorRow; 
  AProc: TdxPSGetImageListProc);
begin
  AProc(TdxInspectorImageRow(ARow).Images);
end;

{ TCustomdxInspectorReportLink }

constructor TCustomdxInspectorReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FFixedFont := TFont.Create;
  FOddFont := TFont.Create;
  FGroupFont := TFont.Create;
  
  InternalRestoreDefaults;
  LinkModified(False);
  
  FFixedFont.OnChange := FontChanged;
  FOddFont.OnChange := FontChanged;
  FGroupFont.OnChange := FontChanged;
  FSaveFont := TFont.Create;
  FSaveFont.OnChange := CustomDrawFontChanged;
  
  FRows := TList.Create;
  FBands := TList.Create;
  FRowHeights := TList.Create;  
end;

destructor TCustomdxInspectorReportLink.Destroy;
begin
  FreeAndNil(FDefaultGroupFont);
  FreeAndNil(FRowHeights);
  FreeAndNilRows;
  FreeAndNilBands;
  FreeAndNil(FSaveFont);
  FreeAndNil(FGroupFont);
  FreeAndNil(FOddFont);
  FreeAndNil(FFixedFont);
  inherited;
end;

procedure TCustomdxInspectorReportLink.Assign(Source: TPersistent);
begin
  if Source is TCustomdxInspectorReportLink then
    with TCustomdxInspectorReportLink(Source) do 
    begin
      Self.FIsGraphicAsTextAssigned := FIsGraphicAsTextAssigned;
      Self.AutoNodesExpand := AutoNodesExpand;
      Self.AutoWidth := AutoWidth;
      Self.FixedTransparent := FixedTransparent;
      Self.GroupTransparent := GroupTransparent;
      Self.FixedColor := FixedColor;
      Self.FixedFont := FixedFont;
      Self.GridLineColor := GridLineColor;
      Self.GroupFont := GroupFont;
      Self.GroupColor := GroupColor;
      Self.OddFont := OddFont;
      Self.Options := Options;
      Self.SupportedCustomDraw := SupportedCustomDraw;
    end;
  inherited;
end;

function  TCustomdxInspectorReportLink.DefaultGraphicAsTextText: string;
begin
  Result := cxGetResourceString(@sdxGraphicAsTextValue);
end;

function TCustomdxInspectorReportLink.DefaultGroupFont: TFont;
begin
  if FDefaultGroupFont = nil then
  begin
    FDefaultGroupFont := TFont.Create;
    InitializeDefaultGroupFont(FDefaultGroupFont);
  end;
  Result := FDefaultGroupFont;
end;

procedure TCustomdxInspectorReportLink.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('IsGraphicAsTextValueAssigned', ReadIsGraphicAsTextValueAssigned, 
    WriteIsGraphicAsTextValueAssigned,
    FIsGraphicAsTextAssigned and (GraphicAsTextText = ''));
end;

procedure TCustomdxInspectorReportLink.ConstructReport(AReportCells: TdxReportCells);
var
  I: Integer;
  ParentCell, Cell: TdxReportCell;
  CurrentRow: TdxInspectorRow;
begin
  if CustomInspector = nil then Exit;
  inherited;
  if CustomInspector.TotalRowCount = 0 then Exit;
  
  PrepareConstruct(AReportCells);
  try
    AReportCells.BorderColor := GridLineColor;
    AReportCells.Cells.FontIndex := FFontIndex;
    AReportCells.Cells.Color := Color;

    if IsAutoBandCount then 
    begin
      ParentCell := TdxReportCell.Create(AReportCells.Cells);
      ParentCell.CellSides := [];
      ParentCell.Transparent := True;
    end  
    else  
      ParentCell := AReportCells.Cells;
      
    for I := 0 to FRows.Count - 1 do
    begin
      CurrentRow := GetRow(I);
      
      Cell := TdxReportCell.Create(ParentCell);
      Cell.CellSides := GetRowCellSides(CurrentRow);
      Cell.Data := Integer(CurrentRow);
      PlaceRow(CurrentRow, I, Cell);

      InsertRowIndent(Cell, CurrentRow);
      if CanDrawRowImage(CurrentRow) then 
        InsertRowImage(Cell, CurrentRow);
      InsertRowCaption(Cell, CurrentRow, I);
      if not CurrentRow.IsCategory then 
        InsertRowValue(Cell, CurrentRow, I);
      
      AReportCells.DoProgress(MulDiv(I, 100, FRows.Count));
      if AbortBuilding then Break;
    end;

    if not AbortBuilding then 
    begin
      ParentCell.BoundsRect := Rect(0, 0, FBandCount * FBandWidth, FMaxBandHeight);
      AReportCells.Cells.BoundsRect := ParentCell.BoundsRect;
    end;  
  finally
    UnprepareConstruct(AReportCells);
  end;
end;

procedure TCustomdxInspectorReportLink.GetImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited;
  AProc(TCustomdxInspectorControlAccess(CustomInspector).Images);
  GetImageListsFromRows(AProc);
end;

procedure TCustomdxInspectorReportLink.InternalRestoreDefaults;
begin
  inherited;
  FAutoNodesExpand := False;
  FAutoWidth := False;
  FFixedTransparent := False;
  FGroupTransparent := False;  
  FFixedColor := dxDefaultFixedColor;
  GridLineColor := dxDefaultGridLineColor;
  FGroupColor := FixedColor;
  FOptions := dxDefaultInspectorPaintOptions;
  SupportedCustomDraw := False;

  FixedFont := DefaultFont;
  GroupFont := DefaultGroupFont;
  OddFont := DefaultFont;
  
  FIsGraphicAsTextAssigned := False;
end;

procedure TCustomdxInspectorReportLink.InternalRestoreFromOriginal;
begin
  inherited;
  FixedTransparent := 
    TCustomdxInspectorControlAccess(CustomInspector).PaintStyle = ipsSimple;
  FixedTransparent := 
    FixedTransparent or (TCustomdxInspectorControlAccess(CustomInspector).PaintStyle = ipsNET);
  if TCustomdxInspectorControlAccess(CustomInspector).PaintStyle = ipsCategorized then
  begin
    GroupColor := clBtnShadow;
    GridLineColor := dxDefaultFixedColor;
  end;
end;

procedure TCustomdxInspectorReportLink.MakeDelimiters(AReportCells: TdxReportCells;
  AHorzDelimiters, AVertDelimiters: TList);
var
  I, RowIndex: Integer;
  Cell: TdxReportCell;
begin
  inherited;
  if IsAutoBandCount then 
    Cell := AReportCells.Cells[0]
  else  
    Cell := AReportCells.Cells;
  
  { horz. }
  if Cell.CellCount > 0 then
  begin
    RowIndex := 0;
    while (RowIndex < Cell.CellCount) and GetRow(RowIndex).IsCategory do 
      Inc(RowIndex);
    if RowIndex = Cell.CellCount then RowIndex := 0;
    for I := 0 to Cell[RowIndex].DataItemCount - 1 do
      AHorzDelimiters.Add(Pointer(Cell[RowIndex].DataItems[I].BoundsRect.Right));
  end;
        
  { vert. }
  if UseVertDelimiters then
    for I := 0 to Cell.CellCount - 1 do
      AVertDelimiters.Add(Pointer(Cell[I].BoundsRect.Bottom));
end;
 
procedure TCustomdxInspectorReportLink.CalcLayout;
begin
  case TCustomdxInspectorControlAccess(CustomInspector).PaintStyle of
    ipsSimple , ipsNET :
      FIndent := dxInspectorButtonSize + 6;
    ipsCategorized:
      FIndent := dxInspectorButtonSize + 5       
  else
    FIndent := dxInspectorButtonExSize + 4;    
  end;    

  with TCustomdxInspectorControlAccess(CustomInspector) do 
  begin
    FBandCount := GetBandIndexByNode(LastNode) + 1;
    if FBandCount = 0 then FBandCount := 1;
    if IsAutoBandCount then 
      FBandWidth := BandWidth
    else
      FBandWidth := ClientWidth;
  end;    
  FCaptionWidth := TCustomdxInspectorControlAccess(CustomInspector).DividerPos;
  FValueWidth := FBandWidth - FCaptionWidth;
  CalcStandardRowHeight;
  CalcComplexRowItemsWidths;
  if AutoWidth then CalcAutoWidths;
  FFullWidth := FBandWidth * FBandCount;
  CalcRowHeights;
  DistributeRowsByBands;
  CalcMaxBandHeight;
end;

procedure TCustomdxInspectorReportLink.CalcMaxBandHeight;
var
  I, J, V: Integer;
  Rows: TList;  
begin
  FMaxBandHeight := 0;
  for I := 0 to FBands.Count - 1 do 
  begin
    Rows := PdxBandItem(FBands.List[I])^.Rows;
    V := 0;
    for J := 0 to Rows.Count - 1 do
      Inc(V, GetRowHeight(J));
    if FMaxBandHeight < V then 
      FMaxBandHeight := V;
  end;
end;
  
procedure TCustomdxInspectorReportLink.PrepareConstruct(AReportCells: TdxReportCells);
begin
  AddRows;
  CalcLayout;
  FFixedFontIndex := AddFontToPool(FixedFont);    
  FGroupFontIndex := AddFontToPool(GroupFont);
end;

procedure TCustomdxInspectorReportLink.UnprepareConstruct(AReportCells: TdxReportCells);
begin
end;

procedure TCustomdxInspectorReportLink.AssignValues(ADataItem: TAbstractdxReportCellData;
  ARow: TdxInspectorRow);
begin
  if Assigned(FdxInspectorAssignDataProc) then
    FdxInspectorAssignDataProc(Self, ADataItem, CustomInspector, ARow);
end;

function TCustomdxInspectorReportLink.GetDataClass(ARow: TdxInspectorRow): TdxReportCellDataClass;
begin
  if Assigned(FdxInspectorColumnMapperProc) then
    Result := FdxInspectorColumnMapperProc(ARow, Self)
  else
    Result := nil;
end;

procedure TCustomdxInspectorReportLink.GetImageListsFromRows(AProc: TdxPSGetImageListProc);
var
  I: Integer;
  Row: TdxInspectorRow;
begin
  for I := 0 to CustomInspector.Count - 1 do
  begin
    Row := CustomInspector.Rows[I];
    dxRowHelpersFactory[Row].GetImageLists(Row, AProc);
  end;  
end;

function TCustomdxInspectorReportLink.GetRowFontIndex(ARow: TdxInspectorRow): Integer;       
begin
  if ARow.IsCategory then
    Result := FGroupFontIndex
  else
    Result := FFixedFontIndex;
end;

procedure TCustomdxInspectorReportLink.CustomDraw(AItem: TAbstractdxReportCellData;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var ADone: Boolean);
var
  AColor: TColor;
  AText: string;
  ATextAlignX: TcxTextAlignX;
  ATextAlignY: TcxTextAlignY;
  ARow: TdxInspectorRow;
begin
  if AItem.Data = 0 then Exit;
  with TdxReportCellString(AItem) do
  begin
    //!!!
    //ParentColor := False;
    AColor := ColorToRGB(Color);
    if Transparent then AColor := clNone;
    FSaveFont.Assign(Font);
    FCustomDrawFontChanged := False;
    AText := Text;
    ATextAlignX := TextAlignX;
    ATextAlignY := TextAlignY;
    ARow := TdxInspectorRow(AItem.Parent.Data);
    case TdxInspectorCellType(AItem.Data) of
      ictCaption:
        DoCustomDrawCaption(ARow, ACanvas, ABoundsRect, AClientRect, AText, AColor,
          FSaveFont, ATextAlignX, ATextAlignY, ADone);
      ictValue:
        DoCustomDrawValue(ARow, ACanvas, ABoundsRect, AClientRect, AText, AColor,
          FSaveFont, ATextAlignX, ATextAlignY, ADone);
      ictCaptionSeparator:
        DoCustomDrawCaptionSeparator(ARow, ACanvas, ABoundsRect, AClientRect, AText, AColor,
          FSaveFont, ATextAlignX, ATextAlignY, ADone);
      ictValueSeparator:
        DoCustomDrawValueSeparator(ARow, ACanvas, ABoundsRect, AClientRect, AText, AColor,
          FSaveFont, ATextAlignX, ATextAlignY, ADone);
    end;
    if not ADone then
    begin
      if FCustomDrawFontChanged then
      begin
        SelectObject(ACanvas.Handle, FSaveFont.Handle);
        SetTextColor(ACanvas.Handle, ColorToRGB(FSaveFont.Color));
        FontIndex := -1;
      end;
      if (AColor <> clNone) then
      begin
        Color := AColor;
        Transparent := False;
      end;
      Text := AText;
      TextAlignX := ATextAlignX;
      TextAlignY := ATextAlignY;
    end;
  end;
end;

procedure TCustomdxInspectorReportLink.DoCustomDrawCaption(ARow: TdxInspectorRow;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var AText: string;
  var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX;
  var ATextAlignY: TcxTextAlignY; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawCaption) then
    FOnCustomDrawCaption(Self, ARow, ACanvas, ABoundsRect, AClientRect, AText, 
      AColor, AFont, ATextAlignX, ATextAlignY, ADone)
end;

procedure TCustomdxInspectorReportLink.DoCustomDrawValue(ARow: TdxInspectorRow;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var AText: string;
  var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX;
  var ATextAlignY: TcxTextAlignY; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawValue) then
    FOnCustomDrawValue(Self, ARow, ACanvas, ABoundsRect, AClientRect, AText, 
      AColor, AFont, ATextAlignX, ATextAlignY, ADone)
end;

procedure TCustomdxInspectorReportLink.DoCustomDrawCaptionSeparator(ARow: TdxInspectorRow; 
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var AText: string; 
  var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX; 
  var ATextAlignY: TcxTextAlignY; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawCaptionSeparator) then
    FOnCustomDrawCaptionSeparator(Self, ARow, ACanvas, ABoundsRect, AClientRect, 
      AText, AColor, AFont, ATextAlignX, ATextAlignY, ADone)
end;
procedure TCustomdxInspectorReportLink.DoCustomDrawValueSeparator(ARow: TdxInspectorRow;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var AText: string;
  var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX;
  var ATextAlignY: TcxTextAlignY; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawValueSeparator) then
    FOnCustomDrawValueSeparator(Self, ARow, ACanvas, ABoundsRect, AClientRect, 
      AText, AColor, AFont, ATextAlignX, ATextAlignY, ADone)
end;

function TCustomdxInspectorReportLink.IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean;
begin
  Result := SupportedCustomDraw;
  if Result and (Item <> nil) then
    case TdxInspectorCellType(Item.Data) of 
      ictCaption: 
        Result := Assigned(FOnCustomDrawCaption);
      ictValue:
        Result := Assigned(FOnCustomDrawValue);
      ictCaptionSeparator:
        Result := Assigned(FOnCustomDrawCaptionSeparator);
      ictValueSeparator:
        Result := Assigned(FOnCustomDrawValueSeparator);
     else
       Result := False;
     end;    
end;

procedure TCustomdxInspectorReportLink.InitializeDefaultGroupFont(AFont: TFont);
begin
  AFont.Assign(DefaultFont);
  AFont.Style := AFont.Style + [fsBold];
end;

function TCustomdxInspectorReportLink.GetCustomInspector: TCustomdxInspectorControl;
begin
  Result := TCustomdxInspectorControl(Component);
end;

function TCustomdxInspectorReportLink.GetGraphicAsTextText: string;
begin
  if FIsGraphicAsTextAssigned then
    Result := FGraphicAsTextText
  else
    Result := DefaultGraphicAsTextText;
end;
    
function TCustomdxInspectorReportLink.GetOddColor: TColor;
begin
  Result := inherited Color;
end;

function TCustomdxInspectorReportLink.GetOptions: TdxInspectorPaintOptions;
begin
  Result := FOptions;
end;

function TCustomdxInspectorReportLink.IsGraphicAsTextTextStored: Boolean;
begin
  Result := FIsGraphicAsTextAssigned and (FGraphicAsTextText <> DefaultGraphicAsTextText);
end;

function TCustomdxInspectorReportLink.IsGroupFontStored: Boolean;
begin
  Result := not dxPSUtl.dxAreFontsEqual(GroupFont, DefaultGroupFont);
end;

procedure TCustomdxInspectorReportLink.SetAutoNodesExpand(Value: Boolean);
begin
  if FAutoNodesExpand <> Value then
  begin
    FAutoNodesExpand := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetAutoWidth(Value: Boolean);
begin
  if FAutoWidth <> Value then
  begin
    FAutoWidth := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetFixedColor(Value: TColor);
begin
  if FFixedColor <> Value then
  begin
    FFixedColor := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetFixedFont(Value: TFont);
begin
  FFixedFont.Assign(Value);
  LinkModified(True);
end;

procedure TCustomdxInspectorReportLink.SetFixedTransparent(Value: Boolean);
begin
  if FFixedTransparent <> Value then
  begin
    FFixedTransparent := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetGraphicAsTextText(const Value: string);
begin
  if GraphicAsTextText <> Value then
  begin
    FGraphicAsTextText := Value;
    FIsGraphicAsTextAssigned := True;
    if ipoGraphicAsText in Options then LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetGridLineColor(Value: TColor);
begin
  if FGridLineColor <> Value then
  begin
    FGridLineColor := Value;
    if IsDrawAnyLines then LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetGroupFont(Value: TFont);
begin
  GroupFont.Assign(Value);
end;

procedure TCustomdxInspectorReportLink.SetGroupNodeColor(Value: TColor);
begin
  if FGroupColor <> Value then
  begin
    FGroupColor := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetGroupTransparent(Value: Boolean);
begin
  if FGroupTransparent <> Value then
  begin
    FGroupTransparent := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetOddColor(Value: TColor);
begin
  inherited Color := Value;
end;

procedure TCustomdxInspectorReportLink.SetOddFont(Value: TFont);
begin
  OddFont.Assign(Value);
end;

procedure TCustomdxInspectorReportLink.SetOnCustomDrawCaption(Value: TdxInspectorReportLinkCustomEvent);
begin
  if @FOnCustomDrawCaption <> @Value then
  begin
    FOnCustomDrawCaption := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetOnCustomDrawValue(Value: TdxInspectorReportLinkCustomEvent);
begin
  if @FOnCustomDrawValue <> @Value then
  begin
    FOnCustomDrawValue := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetOnCustomDrawCaptionSeparator(Value: TdxInspectorReportLinkCustomEvent);
begin
  if @FOnCustomDrawCaptionSeparator <> @Value then
  begin
    FOnCustomDrawCaptionSeparator := Value;
    LinkModified(True);
  end;
end;
procedure TCustomdxInspectorReportLink.SetOnCustomDrawValueSeparator(Value: TdxInspectorReportLinkCustomEvent);
begin
  if @FOnCustomDrawValueSeparator <> @Value then
  begin
    FOnCustomDrawValueSeparator := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetOptions(Value: TdxInspectorPaintOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.SetSupportCustomDraw(Value: Boolean);
begin
  if FSupportedCustomDraw <> Value then
  begin
    FSupportedCustomDraw := Value;
    if Assigned(FOnCustomDrawCaption) or Assigned(FOnCustomDrawValue) then
      LinkModified(True);
  end;
end;

procedure TCustomdxInspectorReportLink.CalcAutoWidths;

  function CalcSum(AData: TList): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to AData.Count - 1 do 
      Inc(Result, Integer(AData.List^[I]));
  end;

  function GetFont(ARow: TdxInspectorRow; AIsCaption: Boolean): HFONT;
  begin
    if ARow.IsCategory then 
      Result := GroupFont.Handle
    else  
      if AIsCaption then 
        Result := FixedFont.Handle
      else
        Result := Font.Handle;
  end;

  procedure GetRowWidths(ADC: HDC; ARow: TdxInspectorRow; ARowIndex: Integer;
    var ACaptionWidth, AValueWidth: Integer);
  var
    I, V: Integer;
    RowItem: PdxRowItem;
    ChildRow: TdxInspectorRowAccess;
    Separator: Boolean;
    S: string;
  begin
    if ARow is TdxInspectorComplexRow then 
    begin
      RowItem := PdxRowItem(FRows.List^[ARowIndex]);
      for I := 0 to RowItem.CaptionWidths.Count - 1 do
      begin
        Separator := IsComplexRowSeparator(TdxInspectorComplexRow(ARow), I);
        ChildRow := TdxInspectorRowAccess(TdxInspectorComplexRow(ARow).Items[I div 2].Row);
        if not IsRowCaptionMultilined(ARow) then     
        begin
          if Separator then 
            S := GetComplexRowSeparatorText(ARow)
          else  
            S := ChildRow.Caption;
          V := GetTextWidth(ADC, GetFont(ChildRow, True), S);
          if Integer(RowItem^.CaptionWidths.List^[I]) < V  then 
            RowItem^.CaptionWidths[I] := Pointer(V);
        end;
        if not IsRowValueMultilined(ChildRow) then           
        begin
          if Separator then 
            S := GetComplexRowSeparatorText(ARow)
          else  
            S := GetRowValueText(ChildRow);
          V := GetTextWidth(ADC, GetFont(ChildRow, False), S);
          if Integer(RowItem^.ValueWidths.List^[I]) < V  then 
            RowItem^.ValueWidths[I] := Pointer(V);
        end;  
      end;
      ACaptionWidth := CalcSum(RowItem^.CaptionWidths);
      AValueWidth := CalcSum(RowItem^.ValueWidths);
      Exit;
    end
    else
    begin
      if not IsRowCaptionMultilined(ARow) then
        ACaptionWidth := GetTextWidth(ADC, GetFont(ARow, True), ARow.Caption);
      if not IsRowValueMultilined(ARow) and not ARow.IsCategory then
        AValueWidth := GetTextWidth(ADC, GetFont(ARow, False), GetRowValueText(ARow));
    end;
  end;
  
var
  DC: HDC;
  PrevFont: HFONT;
  I: Integer;
  Row: TdxInspectorRow;
  CW, VW: Integer;
begin
  DC := GetDC(0);
  try
    PrevFont := GetCurrentObject(DC, OBJ_FONT);
    for I := 0 to FRows.Count - 1 do
    begin
      CW := FCaptionWidth;
      VW := FValueWidth;
      Row := GetRow(I);
      GetRowWidths(DC, Row, I, CW, VW);
      Inc(CW, GetRowTextIndent(Row, True));
      if FCaptionWidth < CW then FCaptionWidth := CW;
      if FValueWidth < VW then FValueWidth := VW;
    end;
    SelectObject(DC, PrevFont);
    FBandWidth := FCaptionWidth + FValueWidth;
  finally
    ReleaseDC(0, DC)
  end;
end;

procedure TCustomdxInspectorReportLink.CalcRowHeights;

  function CalcHeight(ADC: HDC; AFont: TFont; const S: string; AMultiline: Boolean;
    ABaseWidth: Integer): Integer;
  var
    R: TRect;
    Size: TSize;
  begin
    SelectObject(ADC, AFont.Handle);
    if AMultiline and IsRowAutoHeight then
      if S <> '' then
      begin
        R := Rect(0, 0, ABaseWidth - 4, 0);
        if R.Right < R.Left then R.Right := R.Left;
        Result := Windows.DrawText(ADC, PChar(S), Length(S), R,
          DT_CALCRECT or DT_EDITCONTROL or DT_LEFT or DT_WORDBREAK) + 2;
      end
      else
        Result := 0
    else
    begin
      GetTextExtentPoint32(ADC, 'Wg', 2, Size);
      Result := Size.cY;
    end;
  end;

var
  DC: HDC;
  PrevFont: HFONT;
  I, V, RowHeight, OriginalRowHeight: Integer;
  RowItem: PdxRowItem;
  Row: TdxInspectorRow;
  J: Integer;
  ChildRow: TdxInspectorRow;
begin
  FRowHeights.Clear;
  DC := GetDC(0);
  try
    PrevFont := GetCurrentObject(DC, OBJ_FONT);
    for I := 0 to FRows.Count - 1 do
    begin
      RowItem := PdxRowItem(FRows.List^[I]);
      Row := RowItem^.Row;
      RowHeight := FRowHeight;
      if Row.IsCategory then
        RowHeight := CalcHeight(DC, GroupFont, Row.Caption, False, FBandWidth)
      else
      begin
        if Row is TdxInspectorComplexRow then
          for J := 0 to TdxInspectorComplexRow(Row).Items.Count - 1 do
          begin 
            ChildRow := TdxInspectorComplexRow(Row).Items[J].Row;
            V := CalcHeight(DC, FixedFont, ChildRow.Caption, IsRowCaptionMultilined(Row), Integer(RowItem^.CaptionWidths.List^[2 * J]));
            if RowHeight < V then RowHeight := V;
            V := CalcHeight(DC, Font, GetRowValueText(ChildRow), IsRowValueMultilined(Row), Integer(RowItem^.ValueWidths.List^[2 * J]));
            if RowHeight < V then
              RowHeight := V;
          end
        else 
        begin
          V := CalcHeight(DC, FixedFont, Row.Caption, IsRowCaptionMultilined(Row), FCaptionWidth);
          if RowHeight < V then RowHeight := V;
          V := CalcHeight(DC, Font, GetRowValueText(Row), IsRowValueMultilined(Row), FValueWidth);
          if RowHeight < V then
            RowHeight := V;
        end;
      end;
      OriginalRowHeight := TCustomdxInspectorControlAccess(CustomInspector).GetRowHeight(Row);
      if RowHeight < OriginalRowHeight then
        RowHeight := OriginalRowHeight;

      Inc(RowHeight, 1 + 1);
      if IsRowCaptionMultilined(Row) then
        Inc(RowHeight, 1 + 1);

      FRowHeights.Add(Pointer(RowHeight));
    end; 
    SelectObject(DC, PrevFont);
  finally  
    ReleaseDC(0, DC);
  end;  
end;

procedure TCustomdxInspectorReportLink.CalcStandardRowHeight;
  
  function GetHeight(ADC: HDC; AFont: TFont): Integer;
  var
    TextSize: TSize;  
  begin
    SelectObject(ADC, AFont.Handle);
    GetTextExtentPoint32(ADC, 'Wg', 2, TextSize);
    Result := TextSize.cy;
  end;
  
var
  DC: HDC;
  PrevFont: HFONT;
begin
  DC := GetDC(0);
  try
    PrevFont := GetCurrentObject(DC, OBJ_FONT);
    FRowHeight := MaxIntValue([GetHeight(DC, Font), GetHeight(DC, GroupFont), GetHeight(DC, FixedFont)]);
    SelectObject(DC, PrevFont);
  finally  
    ReleaseDC(0, DC);
  end;  
end;

procedure TCustomdxInspectorReportLink.CustomDrawFontChanged(Sender: TObject);
begin
  FCustomDrawFontChanged := True;
end;

function TCustomdxInspectorReportLink.GetRow(AIndex: Integer): TdxInspectorRow;
begin
  Result := PdxRowItem(FRows.List^[AIndex])^.Row;
end;

function TCustomdxInspectorReportLink.GetRowCellSides(ARow: TdxInspectorRow): TdxCellSides;
begin
  if IsDrawBorder then         
  begin
    Result := [csLeft, csRight];
    if IsTopRow(ARow) then Result := Result + [csTop];         
    if IsBottomRow(ARow) then Result := Result + [csBottom];
  end    
  else  
    Result := [];
end;    

function TCustomdxInspectorReportLink.GetRowIndentCellSides(ARow: TdxInspectorRow; 
  ALevelIndex: Integer): TdxCellSides;
begin
  if (ALevelIndex = 0) and IsNetMode then 
  begin
    Result := [csLeft];
    if not IsNetCategoryRow(ARow) or (ARow.Node.Level > 0) then 
      Include(Result, csRight);
//      if (ARow.Node.Level = 0) and (ARow.Node.Count > 0) then 
    if IsNetCategoryRow(ARow) then 
      Include(Result, csTop);
    {ver. 2.31  
    if ARow.Node <> nil then 
    begin 
      if (ARow.Node.Level = 0) and (ARow.Node.Count > 0) and not ARow.Node.Expanded and not AutoNodesExpand then 
        Include(Result, csBottom);
    end;}
    if IsNetUltimateLastRowInParent(ARow) then
      Include(Result, csBottom);
  end    
  else    
    Result := [csTop, csBottom];
  
  if (ALevelIndex = 1) and (ARow.Node <> nil) and (ARow.Node.Level = 0) and ARow.IsCategory then
    Include(Result, csLeft);
    
  if not IsDrawBorder then 
  begin
    if IsTopRow(ARow) then Exclude(Result, csTop);      
    if IsBottomRow(ARow) then Exclude(Result, csBottom);
    if ALevelIndex = 0 then
    begin 
      Exclude(Result, csLeft);
      Exclude(Result, csRight);
    end;  
    
    if ALevelIndex = 1 then 
      Exclude(Result,  csRight);
      
    if IsNetMode then
    begin 
      if IsNetCategoryRow(ARow) then
      begin
        Exclude(Result, csTop);
        Exclude(Result, csBottom);
      end;
      if IsNetUltimateLastRowInParent(ARow) then 
        Exclude(Result, csBottom);
      if (ARow.Node <> nil) and (ARow.Node.Level = 1) and (ARow.Node.Index = 0) and 
        TdxInspectorRowNode(ARow.Node.Parent).Row.IsCategory then 
        Exclude(Result, csTop);
    end;
  end;
  
  if not IsDrawHorzLines then
  begin 
     if IsNetMode then
     begin
       case ALevelIndex of
         0: if IsNetCategoryRow(ARow) then Exclude(Result, csTop);      
         1: if not ((ARow.Node <> nil) and (ARow.Node.Level = 1) and (ARow.Node.Index = 0) and 
              TdxInspectorRowNode(ARow.Node.Parent).Row.IsCategory) then 
              Exclude(Result, csTop);
       else
         Exclude(Result, csTop);
       end;      
       if not IsNetUltimateLastRowInParent(ARow) then 
         Exclude(Result, csBottom);
     end    
     else
     begin
       if not IsTopRow(ARow) then Exclude(Result, csTop);      
       if not IsBottomRow(ARow) then Exclude(Result, csBottom);          
     end;
  end;
     
  if not IsDrawVertLines and IsNetMode then
    if not GetUltimateParentRow(ARow).IsCategory then
    begin
      if ALevelIndex = 0 then Exclude(Result, csRight);
      if ALevelIndex = 1 then Exclude(Result, csLeft);
    end;
end;

function TCustomdxInspectorReportLink.GetRowIndentColor(ARow: TdxInspectorRow; 
  ALevelIndex: Integer): TColor;
begin
  if IsNetMode and (ALevelIndex = 0) and GetUltimateParentRow(ARow).IsCategory then
    Result := GroupColor
  else
    Result := GetRowCaptionColor(ARow);
end;  

function TCustomdxInspectorReportLink.GetRowIndentCount(ARow: TdxInspectorRow): Integer;
begin
  Result := ARow.Node.Level;
  with TCustomdxInspectorControlAccess(CustomInspector) do
    if PaintStyle in [ipsStandard, ipsSimple, ipsExtended, ipsNet] then 
      Inc(Result);
end;
  
function TCustomdxInspectorReportLink.GetRowIndentTransparency(ARow: TdxInspectorRow; 
  ALevelIndex: Integer): Boolean;
begin
  if IsNetMode and (ALevelIndex = 0) and GetUltimateParentRow(ARow).IsCategory then
    Result := GroupTransparent
  else
    Result := GetRowCaptionTransparency(ARow);
end;  

function TCustomdxInspectorReportLink.GetRowSeparatorCellSides(ARow: TdxInspectorRow): TdxCellSides;
begin
  Result := [csTop, csBottom];
  if not IsDrawBorder then 
  begin
    if IsTopRow(ARow) then Exclude(Result, csTop);
    if IsBottomRow(ARow) then Exclude(Result, csBottom);
  end;
  if not IsDrawHorzLines then 
  begin
    if not IsTopRow(ARow) then Exclude(Result, csTop);
    if not IsBottomRow(ARow) then Exclude(Result, csBottom);
  end;
end;

function TCustomdxInspectorReportLink.GetRowTextIndent(ARow: TdxInspectorRow; 
  AIncludeImageWidth: Boolean): Integer;
begin
  Result := FIndent * GetRowIndentCount(ARow);
  if AIncludeImageWidth and CanDrawRowImage(ARow) then 
    Inc(Result, TCustomdxInspectorControlAccess(CustomInspector).Images.Width);
end;

function TCustomdxInspectorReportLink.GetRowCaptionColor(ARow: TdxInspectorRow): TColor;
begin
  if ARow.IsCategory then
    Result := GroupColor
  else
    Result := FixedColor;
end;

function TCustomdxInspectorReportLink.GetRowCaptionCellSides(ARow: TdxInspectorRow): TdxCellSides;
var
  ComplexRow: TdxInspectorComplexRow;
  Index: Integer;
begin
  Result := csAll;
  ComplexRow := ComplexRowByRow(ARow);
  Index := 0;
  if ComplexRow <> nil then 
    Index := ComplexRow.Items.IndexOfRow(ARow);
  if (ComplexRow = nil) or (Index = 0) then 
    Exclude(Result, csLeft);
  if (ComplexRow <> nil) and (GetComplexRowSeparatorText(ARow) <> '') then
  begin
    Exclude(Result, csLeft);
    if Index < ComplexRow.Items.Count - 1 then
      Exclude(Result, csRight);
  end;
  if ComplexRow <> nil then ARow := ComplexRow;

  if not IsDrawBorder then 
  begin
    if ARow.IsCategory then Exclude(Result, csRight);
    if IsTopRow(ARow) then Exclude(Result, csTop);      
    if IsBottomRow(ARow) then Exclude(Result, csBottom);
    if IsNetMode then
    begin 
      if IsNetCategoryRow(ARow) then 
      begin
        Exclude(Result, csTop);
        Exclude(Result, csBottom);
      end;
      if IsNetUltimateLastRowInParent(ARow) then 
        Exclude(Result, csBottom);
    end;          
  end;  
  
//  not IsNetCategoryRow(ARow) and not (IsNetUltimateLastRowInParent(ARow)
  if not IsDrawHorzLines then 
    if not IsNetMode or not IsNetCategoryRow(ARow) then
    begin
      if not IsTopRow(ARow) then Exclude(Result, csTop);      
      if not IsBottomRow(ARow) and not IsNetUltimateLastRowInParent(ARow) then
        Exclude(Result, csBottom);
    end;
     
  if not IsDrawVertLines then 
  begin
    if not ARow.IsCategory then Exclude(Result, csRight);
    if ComplexRow <> nil then 
    begin 
      if Index < ComplexRow.Items.Count - 1 then Exclude(Result, csRight);    
      if Index > 0 then Exclude(Result, csLeft);    
    end;    
  end;  
end;
    
function TCustomdxInspectorReportLink.GetRowCaptionTransparency(ARow: TdxInspectorRow): Boolean;
begin
  if IsNetMode then 
    if IsNetCategoryRow(ARow) then
      Result := GroupTransparent
    else  
      Result := FixedTransparent
  else  
    if ARow.IsCategory then 
      Result := GroupTransparent
    else  
      Result := FixedTransparent
end;

function TCustomdxInspectorReportLink.GetRowHeight(ARowIndex: Integer): Integer;
begin
  Result := Integer(FRowHeights.List^[ARowIndex]);
end;

function TCustomdxInspectorReportLink.GetRowValueCellSides(ARow: TdxInspectorRow): TdxCellSides;
var
  ComplexRow: TdxInspectorComplexRow;
  Index: Integer;
begin
  Result := csAll;
  ComplexRow := ComplexRowByRow(ARow);
  Index := 0;
  if ComplexRow <> nil then 
    Index := ComplexRow.Items.IndexOfRow(ARow);
  if (ComplexRow = nil) or (Index = 0) then 
    Exclude(Result, csLeft);
  if (ComplexRow <> nil) and (GetComplexRowSeparatorText(ARow) <> '') then
  begin
    Exclude(Result, csLeft);
    if Index < ComplexRow.Items.Count - 1 then
      Exclude(Result, csRight);
  end;

  if not IsDrawBorder then 
  begin
    if ComplexRow = nil then 
      Exclude(Result, csRight)
    else  
      if Index = ComplexRow.Items.Count - 1 then 
        Exclude(Result, csRight);
    Exclude(Result, csRight);
    if IsTopRow(ARow) then Exclude(Result, csTop);      
    if IsBottomRow(ARow) then Exclude(Result, csBottom);          
    if IsNetMode and IsNetUltimateLastRowInParent(ARow) then 
      Exclude(Result, csBottom);
  end;  
  
  if not IsDrawHorzLines then 
  begin
    if not IsTopRow(ARow) then Exclude(Result, csTop);      
    if not IsBottomRow(ARow) and not IsNetUltimateLastRowInParent(ARow) then
      Exclude(Result, csBottom);
  end;  
  
  if not IsDrawVertLines then 
  begin
    if not ARow.IsCategory then Exclude(Result, csLeft);
    if ComplexRow <> nil then 
    begin 
      if Index < ComplexRow.Items.Count - 1 then Exclude(Result, csRight);    
      if Index > 0 then Exclude(Result, csLeft);    
    end;    
  end;  
end;

function TCustomdxInspectorReportLink.GetRowValueText(ARow: TdxInspectorRow): string;
begin
  if ARow is TdxInspectorMemoRow then 
    Result := TdxInspectorMemoRowAccess(ARow).GetMemoText
  else
    if (ARow is TdxInspectorTextRow) and (TdxInspectorTextRow(ARow).PasswordChar <> #0) then 
      Result := ReplicateChar(TdxInspectorTextRow(ARow).PasswordChar, Length(TdxInspectorRowAccess(ARow).GetDisplayText))
    else
      if ARow is TdxInspectorGraphicRow then
        Result := GraphicAsTextText
      else
        Result := TdxInspectorRowAccess(ARow).GetDisplayText;
end;

procedure TCustomdxInspectorReportLink.PlaceRow(ARow: TdxInspectorRow; 
  ARowIndex: Integer; ACell: TdxReportCell);
var
  PrevSibl: TdxReportItem;
  BandIndex, PrevBandIndex: Integer;
begin
  ACell.BoundsRect := Rect(0, 0, FBandWidth, GetRowHeight(ARowIndex));
  BandIndex := 0;
  PrevSibl := ACell.GetPrevSibling;
  if PrevSibl <> nil then
  begin
    if IsAutoBandCount then 
    begin
      BandIndex := 
        TCustomdxInspectorControlAccess(CustomInspector).GetBandIndexByNode(ARow.Node);
      PrevBandIndex := 
        TCustomdxInspectorControlAccess(CustomInspector).GetBandIndexByNode(TdxInspectorRow(PrevSibl.Data).Node);
    end
    else 
      PrevBandIndex := 0;
    if BandIndex <> PrevBandIndex then 
      ACell.Left := TdxReportVisualItem(PrevSibl).BoundsRect.Right
    else
    begin
      ACell.Top := TdxReportVisualItem(PrevSibl).BoundsRect.Bottom;
      ACell.Left := TdxReportVisualItem(PrevSibl).Left;
    end;  
  end;
end;

function TCustomdxInspectorReportLink.IsDisplayGraphicsAsText: Boolean;
begin
  Result := ipoGraphicAsText in Options;
end;

function TCustomdxInspectorReportLink.IsCheckMarksAsText: Boolean;
begin
  Result := ipoCheckMarksAsText in Options;
end;

function TCustomdxInspectorReportLink.IsDrawAnyLines: Boolean;
begin
  Result := Options * [ipoBorder..ipoVertLines] <> [];
end;

function TCustomdxInspectorReportLink.IsDrawBorder: Boolean;
begin
  Result := ipoBorder in Options;
end;

function TCustomdxInspectorReportLink.IsDrawEndEllipsis: Boolean;
begin
  Result := ioDrawEndEllipsis in TCustomdxInspectorControlAccess(CustomInspector).Options;
end;

function TCustomdxInspectorReportLink.IsDrawExpandButtons: Boolean;    
begin
  Result := ipoExpandButtons in Options;
end;

function TCustomdxInspectorReportLink.IsDrawHorzLines: Boolean;
begin
  Result := ipoHorzLines in Options;
end;

function TCustomdxInspectorReportLink.IsDrawVertLines: Boolean;
begin
  Result := ipoVertLines in Options;
end;

function TCustomdxInspectorReportLink.IsFlatCheckMarks: Boolean;
begin
  Result := ipoFlatCheckMarks in Options;
end;

function TCustomdxInspectorReportLink.IsShowExpandButtons: Boolean;    
begin
  Result := ipoExpandButtons in Options;  
end;

function TCustomdxInspectorReportLink.IsShowImages: Boolean;
begin
  Result := ipoImages in Options;
end;

function TCustomdxInspectorReportLink.IsTransparentColumnGraphics: Boolean;
begin
  Result := ipoTransparentRowGraphic in Options;
end;

function TCustomdxInspectorReportLink.IsAutoBandCount: Boolean;    
begin
  Result := (CustomInspector <> nil) and 
    (ioAutoBandCount in TCustomdxInspectorControlAccess(CustomInspector).Options);
end;

function TCustomdxInspectorReportLink.IsRowAutoHeight: Boolean;
begin
  Result := (CustomInspector <> nil) and 
    (ioRowAutoHeight in TCustomdxInspectorControlAccess(CustomInspector).Options);
end;

function TCustomdxInspectorReportLink.IsRowCaptionMultilined(ARow: TdxInspectorRow): Boolean;
begin
  Result := (rvRowHeight in ARow.AssignedValues) or IsRowValueMultilined(ARow);
end;

function TCustomdxInspectorReportLink.IsRowValueMultilined(ARow: TdxInspectorRow): Boolean;
begin
  Result := (ARow is TdxInspectorMemoRow) or ((ARow is TdxInspectorCustomBlobRow) and (TdxInspectorCustomBlobRow(ARow).BlobPaintStyle = bpsText));
end;

function TCustomdxInspectorReportLink.IsBottomRow(ARow: TdxInspectorRow): Boolean;
var
  I: Integer;
begin
  for I := 0 to FBands.Count - 1 do
  begin
    Result := PdxBandItem(FBands.List^[I]).Rows.Last = ARow;
    if Result then Exit;
  end;
  Result := False;
end;

function TCustomdxInspectorReportLink.IsTopRow(ARow: TdxInspectorRow): Boolean;
var
  I: Integer;
begin
  for I := 0 to FBands.Count - 1 do
  begin
    Result := PdxBandItem(FBands.List^[I]).Rows.First = ARow;
    if Result then Exit;
  end;
  Result := False;
end;

procedure TCustomdxInspectorReportLink.InsertRowCaption(ACell: TdxReportCell; 
  ARow: TdxInspectorRow; ARowIndex: Integer);

  procedure PlaceRowCaptionPart(ADataItem: TdxReportVisualItem; 
    ARow: TdxInspectorRow; AItemIndex: Integer);
  var
    PrevSibl: TdxReportItem;
    V: Integer;
    ComplexRow: TdxInspectorComplexRow;
    W: Integer;
  begin
    V := 0;
    PrevSibl := ADataItem.GetPrevSibling;
    if PrevSibl <> nil then
      V := TdxReportVisualItem(PrevSibl).BoundsRect.Right;
    ComplexRow := ComplexRowByRow(ARow);
    if ComplexRow <> nil then 
    begin
      if ARow = ComplexRow.Items[ComplexRow.Items.Count - 1].Row then
        W := FCaptionWidth - V
      else
        W := Integer(PdxRowItem(GetRowItemByRow(ComplexRow)).CaptionWidths.List^[AItemIndex]);
      ADataItem.BoundsRect := Rect(V, 0, V + W, ADataItem.Parent.Height);
    end  
    else
      if ARow.IsCategory then
        ADataItem.BoundsRect := Rect(V, 0, ADataItem.Parent.Width, ADataItem.Parent.Height)
      else  
        ADataItem.BoundsRect := Rect(V, 0, FCaptionWidth, ADataItem.Parent.Height);
  end;
  
  procedure InsertRowCaptionPart(ARow: TdxInspectorRow; AItemIndex: Integer; 
    AIsRowSeparator: Boolean);
  var
    DataItem: TdxReportCellString;
    Separator: Boolean;
    I: Integer;
    ChildRow: TdxInspectorRow;
  begin
    if not AIsRowSeparator and (ARow is TdxInspectorComplexRow) and not ARow.IsCategory then 
    begin
      for I := 0 to PdxRowItem(FRows.List^[ARowIndex]).CaptionWidths.Count - 1 do
      begin
        if (GetComplexRowSeparatorText(ARow) = '') and Odd(I) then 
          Continue;
        Separator := IsComplexRowSeparator(TdxInspectorComplexRow(ARow), I);
        ChildRow := TdxInspectorComplexRow(ARow).Items[I div 2].Row;
        InsertRowCaptionPart(ChildRow, I, Separator);
      end;
      Exit;
    end  
    else
    begin
      DataItem := TdxReportCellString.Create(ACell);
      if AIsRowSeparator then 
        DataItem.Data := Integer(ictCaptionSeparator)
      else
        DataItem.Data := Integer(ictCaption);
        
      PlaceRowCaptionPart(DataItem, ARow, AItemIndex);
      AssignValues(DataItem, ARow);
    end;      
  end;
        
begin
  InsertRowCaptionPart(ARow, 0, False);
end;

procedure TCustomdxInspectorReportLink.InsertRowIndent(ACell: TdxReportCell; ARow: TdxInspectorRow);

  function GetButtonSize: Integer;
  begin
    with TCustomdxInspectorControlAccess(CustomInspector) do 
      if PaintStyle in [ipsSimple , ipsNET, ipsCategorized ] then 
        Result := dxInspectorButtonSize
      else
        Result := dxInspectorButtonExSize + 1;
  end;
  
  procedure InsertRowIndentPart(ALevelIndex, AMaxLevel: Integer);
  var
    IndentBox: TdxReportCellExpandButton;
    V: Integer;
    PrevSibl: TdxReportItem;
  begin
    IndentBox := TdxReportCellExpandButton.Create(ACell);
    with IndentBox do 
    begin
      V := 0;
      PrevSibl := GetPrevSibling;
      if PrevSibl <> nil then 
        V := TdxReportVisualItem(PrevSibl).BoundsRect.Right;
      BoundsRect := Rect(V, 0, V + FIndent, ACell.Height);
      Transparent := GetRowIndentTransparency(ARow, ALevelIndex);
      if not Transparent then 
        Color := GetRowIndentColor(ARow, ALevelIndex);
      CellSides := GetRowIndentCellSides(ARow, ALevelIndex);
      
      { 2.3 }
      ShowButton := IsShowExpandButtons and (ALevelIndex = AMaxLevel) and 
        (ARow.Node <> nil) and (ARow.Node.Count <> 0);
      if ShowButton then 
      begin
        ButtonExpanded := (ARow.Node <> nil) and ARow.Node.Expanded or AutoNodesExpand;
        ShowButtonBorder := TCustomdxInspectorControlAccess(CustomInspector).PaintStyle <> ipsStandard;              
        if ShowButtonBorder then 
        begin
          ButtonBorder3D := TCustomdxInspectorControlAccess(CustomInspector).PaintStyle = ipsExtended;
          ButtonSize := GetButtonSize;
        end;  
      end;
    end;
  end;

  function IndentExists(ARow: TdxInspectorRow): Boolean;
  begin
     Result := (ComplexRowByRow(ARow) = nil) and
       not ((TCustomdxInspectorControlAccess(CustomInspector).PaintStyle = ipsCategorized) and 
       ARow.IsCategory and (ARow.Node.Level = 0));
  end;

var
  I, MaxLevel: Integer;  
begin
  if IndentExists(ARow) then
  begin
    MaxLevel := GetRowIndentCount(ARow) - 1;
    for I := 0 to MaxLevel do 
      InsertRowIndentPart(I, MaxLevel);
  end;    
end;  

procedure TCustomdxInspectorReportLink.InsertRowValue(ACell: TdxReportCell; ARow: TdxInspectorRow; 
  ARowIndex: Integer);

  procedure PlaceRowValuePart(ADataItem: TdxReportVisualItem; ARow: TdxInspectorRow; 
    AItemIndex: Integer);
  var
    PrevSibl: TdxReportItem;
    V: Integer;
    ComplexRow: TdxInspectorComplexRow;
    W: Integer;
  begin
    V := 0;
    PrevSibl := ADataItem.GetPrevSibling;
    if PrevSibl <> nil then
      V := TdxReportVisualItem(PrevSibl).BoundsRect.Right;
    ComplexRow := ComplexRowByRow(ARow);
    if ComplexRow <> nil then 
    begin
      if ARow = ComplexRow.Items[ComplexRow.Items.Count - 1].Row then
        W := FBandWidth - V
      else
        W := Integer(PdxRowItem(GetRowItemByRow(ComplexRow)).ValueWidths.List^[AItemIndex]);
      ADataItem.BoundsRect := Rect(V, 0, V + W, ADataItem.Parent.Height);
    end  
    else
      ADataItem.BoundsRect := Rect(V, 0, V + FValueWidth, ADataItem.Parent.Height);
  end;

  procedure InsertRowValuePart(ARow: TdxInspectorRow; AItemIndex: Integer; 
    AIsRowSeparator: Boolean);
  var
    DataClass: TdxReportCellDataClass;
    DataItem: TAbstractdxReportCellData;
    Separator: Boolean;
    I: Integer;
    ChildRow: TdxInspectorRow;
  begin
    if ARow is TdxInspectorComplexRow then 
    begin
      for I := 0 to PdxRowItem(FRows.List^[ARowIndex]).CaptionWidths.Count - 1 do
      begin
        if (GetComplexRowSeparatorText(ARow) = '') and Odd(I) then 
          Continue;
        Separator := IsComplexRowSeparator(TdxInspectorComplexRow(ARow), I);
        ChildRow := TdxInspectorComplexRow(ARow).Items[I div 2].Row;
        InsertRowValuePart(ChildRow, I, Separator);
      end;
      Exit;
    end    
    else
    begin
      if AIsRowSeparator then 
      begin
        DataItem := TdxReportCellString.Create(ACell);
        DataItem.Data := Integer(ictValueSeparator)
      end  
      else
      begin
        DataClass := GetDataClass(ARow);
        DataItem := DataClass.Create(ACell);
        DataItem.Data := Integer(ictValue);
      end;  
      PlaceRowValuePart(DataItem, ARow, AItemIndex);
      AssignValues(DataItem, ARow);
    end;      
  end;
  
begin
  InsertRowValuePart(ARow, 0, False);
end;

procedure TCustomdxInspectorReportLink.CalcComplexRowItemsWidths;
var  
  DC: HDC;
  I, J: Integer;
  RowItem: PdxRowItem;
  Row: TdxInspectorRow;
  S: string;
  CaptionSeparatorWidth, ValueSeparatorWidth: Integer;
  CaptionViewInfo, ValueViewInfo: TdxInspectorComplexRowViewInfo;
begin
  DC := GetDC(0);
  try
    for I := 0 to FRows.Count - 1 do
    begin
      RowItem := PdxRowItem(FRows.List^[I]);
      Row := RowItem^.Row;
      if (Row is TdxInspectorComplexRow) and not Row.IsCategory then
      begin
        if GetComplexRowSeparatorText(Row) <> '' then 
        begin
          S := GetComplexRowSeparatorText(Row) + '_';
          CaptionSeparatorWidth := GetTextWidth(DC, FixedFont.Handle, S);
          if TCustomdxInspectorControlAccess(CustomInspector).PaintStyle = ipsCategorized then
            ValueSeparatorWidth := 4
          else
            ValueSeparatorWidth := GetTextWidth(DC, Font.Handle, S);
        end
        else
        begin
          ValueSeparatorWidth := 4;
          CaptionSeparatorWidth := 4;
        end;
        CaptionViewInfo := TdxInspectorComplexRowViewInfo.Create(TdxInspectorComplexRow(Row), CaptionSeparatorWidth);
        ValueViewInfo := TdxInspectorComplexRowViewInfo.Create(TdxInspectorComplexRow(Row), ValueSeparatorWidth);
        try
          RowItem^.CaptionWidths := TList.Create;
          RowItem^.ValueWidths := TList.Create;
          CaptionViewInfo.Calculate(Rect(0, 0, FCaptionWidth - GetRowTextIndent(Row, True), 0));
          ValueViewInfo.Calculate(Rect(0, 0, FValueWidth, 0));
          RowItem^.CaptionWidths.Count := ValueViewInfo.Count;
          RowItem^.ValueWidths.Count := ValueViewInfo.Count;
          for J := 0 to RowItem^.CaptionWidths.Count - 1 do
          begin
            with CaptionViewInfo[J].Bounds do 
              RowItem^.CaptionWidths[J] := Pointer(Right - Left);
            with ValueViewInfo[J].Bounds do 
              RowItem^.ValueWidths[J] := Pointer(Right - Left);
          end;    
        finally
          ValueViewInfo.Free;
          CaptionViewInfo.Free;
        end;
      end;
    end;
  finally
    ReleaseDC(0, DC);
  end;  
end;   
function TCustomdxInspectorReportLink.CanDrawRowImage(ARow: TdxInspectorRow): Boolean;
begin
  Result := IsShowImages and (TCustomdxInspectorControlAccess(CustomInspector).Images <> nil) and 
    (ComplexRowByRow(ARow) = nil) and 
    (ARow.ImageIndex > -1) and (ARow.ImageIndex < TCustomdxInspectorControlAccess(CustomInspector).Images.Count);
end;
function TCustomdxInspectorReportLink.ComplexRowByRow(ARow: TdxInspectorRow): TdxInspectorComplexRow;
begin
  Result := TCustomdxInspectorControl(CustomInspector).ComplexRowByRow(ARow);
end;
function TCustomdxInspectorReportLink.GetComplexRowSeparatorText(ARow: TdxInspectorRow): string;
begin
  Result := TCustomdxInspectorControlAccess(CustomInspector).ComplexRowSeparator;
end;
function TCustomdxInspectorReportLink.GetRowImageCellSides(ARow: TdxInspectorRow): TdxCellSides;
begin
  Result := [];
  if IsDrawHorzLines then 
    Result := Result + [csTop, csBottom];
end;
function TCustomdxInspectorReportLink.GetRowItemByRow(ARow: TdxInspectorRow): Pointer;
var
  I: Integer;
begin
  for I := 0 to FRows.Count - 1 do 
  begin
    Result := FRows[I];
    if PdxRowItem(Result)^.Row = ARow then Exit;
  end;  
  Result := nil;
end;
function TCustomdxInspectorReportLink.GetUltimateParentRow(ARow: TdxInspectorRow): TdxInspectorRow;
var
  Node: TdxInspectorNode;
begin
  Node := ARow.Node;
  while Node.Level <> 0 do Node := Node.Parent;
  Result := TdxInspectorRowNode(Node).Row;
end;
function TCustomdxInspectorReportLink.IsComplexRowSeparator(ARow: TdxInspectorComplexRow; 
  AIndex: Integer): Boolean;
begin
  Result := (GetComplexRowSeparatorText(ARow) <> '') and Odd(AIndex);
end;
procedure TCustomdxInspectorReportLink.InsertRowImage(ACell: TdxReportCell; ARow: TdxInspectorRow);
var
  PrevSibl: TdxReportItem;
  DataItem: TdxReportCellImage;
begin
  DataItem := TdxReportCellImage.Create(ACell);
  with DataItem do 
  begin
    BoundsRect := 
      Bounds(1, 0, TCustomdxInspectorControlAccess(CustomInspector).Images.Width + 1, DataItem.Parent.Height);
    PrevSibl := DataItem.GetPrevSibling;
    if PrevSibl <> nil then
      Left := TdxReportVisualItem(PrevSibl).BoundsRect.Right;
    ImageList := TCustomdxInspectorControlAccess(CustomInspector).Images;
    ImageIndex := ARow.ImageIndex;
    CellSides := GetRowImageCellSides(ARow);
    ImageTransparent := True;
    Transparent := FixedTransparent;
    Color := GetRowCaptionColor(ARow);
  end;  
end;  

function TCustomdxInspectorReportLink.IsNetCategoryRow(ARow: TdxInspectorRow): Boolean;
begin
  Result := IsNetMode and (ARow.Node <> nil) and (ARow.Node.Level = 0) and ARow.IsCategory;
end;

function TCustomdxInspectorReportLink.IsNetMode: Boolean;
begin
  Result := TCustomdxInspectorControlAccess(CustomInspector).PaintStyle = ipsNET;
end;

function TCustomdxInspectorReportLink.IsNetUltimateLastRowInParent(ARow: TdxInspectorRow): Boolean;
var
  Node: TdxInspectorRowNode;
begin
  Node := ARow.Node;
  if Node <> nil then 
  begin
    while (Node.Level <> 0) and Node.IsLast do
      Node := TdxInspectorRowNode(Node.Parent);
    Result := 
      (Node.Level = 0) and ((ARow.Node.Count = 0) or (not ARow.Node.Expanded and not AutoNodesExpand)) and 
      (Node.Row.IsCategory or IsBottomRow(ARow));
  end
  else    
    Result := IsBottomRow(ARow);    
end;

procedure TCustomdxInspectorReportLink.AddRows;

  procedure AddRow(ANode: TdxInspectorRowNode);
  var
    I: Integer;
    RowItem: PdxRowItem;
  begin
    New(RowItem);
    FillChar(RowItem^, SizeOf(TdxRowItem), 0);
    RowItem^.Row := ANode.Row;
    FRows.Add(RowItem);
    
    if ANode.Expanded or AutoNodesExpand then
      for I := 0 to ANode.Count - 1 do
        AddRow(TdxInspectorRowNode(ANode[I]));
  end;
  
var
  I: Integer;
begin
  ClearRows;
  if CustomInspector.TotalRowCount > 0 then
  begin
    if not AutoNodesExpand then
      FRows.Capacity := TCustomdxInspectorControlAccess(CustomInspector).GetAbsoluteCount;
    for I := 0 to CustomInspector.Count - 1 do
      AddRow(TdxInspectorRowNode(CustomInspector.Items[I]));
  end;
end;

procedure TCustomdxInspectorReportLink.ClearRows;
var
  I: Integer;
  RowItem: PdxRowItem;
begin
  for I := 0 to FRows.Count - 1 do 
  begin
    RowItem := FRows.List^[I];
    if RowItem^.CaptionWidths <> nil then RowItem^.CaptionWidths.Free;
    if RowItem^.ValueWidths <> nil then RowItem^.ValueWidths.Free;
    Dispose(PdxRowItem(RowItem));
  end;
  FRows.Clear;
end;

procedure TCustomdxInspectorReportLink.DistributeRowsByBands;
var
  I, BandIndex: Integer;
  BandItem: PdxBandItem;
begin
  ClearBands;
  if TCustomdxInspectorControlAccess(CustomInspector).IsAutoBandCount then
  begin 
    CustomInspector.HandleNeeded;
    for I := 0 to FRows.Count - 1 do 
    begin
      BandIndex := TCustomdxInspectorControlAccess(CustomInspector).GetBandIndexByNode(GetRow(I).Node);
      if BandIndex > FBands.Count - 1 then
        FBands.Count := 1 + BandIndex;
      if FBands.List^[BandIndex] = nil then 
      begin
        New(BandItem);
        FillChar(BandItem^, SizeOf(TdxBandItem), 0);
        BandItem^.Rows := TList.Create;
        FBands[BandIndex] := BandItem;
      end;  
      PdxBandItem(FBands.List^[BandIndex])^.Rows.Add(GetRow(I));
    end;
    Exit;
  end  
  else   
  begin
    New(BandItem);
    FillChar(BandItem^, SizeOf(TdxBandItem), 0);
    BandItem^.Rows := TList.Create;
    FBands.Add(BandItem);
    for I := 0 to FRows.Count - 1 do 
      BandItem^.Rows.Add(GetRow(I));
  end;
end;

procedure TCustomdxInspectorReportLink.FreeAndNilRows;
begin
  ClearRows;
  FreeAndNil(FRows);
end;

procedure TCustomdxInspectorReportLink.ClearBands;
var
  I: Integer;
  BandItem: PdxBandItem;
begin
  for I := 0 to FBands.Count - 1 do 
  begin
    BandItem := FBands.List^[I];
    BandItem^.Rows.Free;
    Dispose(PdxBandItem(BandItem));
  end;
  FBands.Clear;
end;
   
procedure TCustomdxInspectorReportLink.FreeAndNilBands;
begin
  ClearBands;
  FreeAndNil(FBands);
end;

procedure TCustomdxInspectorReportLink.ReadIsGraphicAsTextValueAssigned(AReader: TReader);
begin
  FIsGraphicAsTextAssigned := AReader.ReadBoolean;
end;
procedure TCustomdxInspectorReportLink.WriteIsGraphicAsTextValueAssigned(AWriter: TWriter);
begin
  AWriter.WriteBoolean(FIsGraphicAsTextAssigned);
end;

{ TdxInspectorReportLink }

function TdxInspectorReportLink.GetInspector: TdxInspector;
begin
  Result := TdxInspector(Component);
end;

{ TdxInspectorDesignWindow }

constructor TdxInspectorDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhcInspectorGridReportLinkDesigner;
  inherited;
  CreateControls;
  PageControl1.ActivePage := PageControl1.Pages[0];
end;

function TdxInspectorDesignWindow.GetReportLink: TCustomdxInspectorReportLink;
begin
  Result := inherited ReportLink as TCustomdxInspectorReportLink;
end;

procedure TdxInspectorDesignWindow.LoadDataToInspector;

  function BitmapToText(AImageIndex: Integer): string;
  var
    Picture: TPicture;
  begin
    Picture := TPicture.Create;
    try
      Picture.Bitmap.Width := ilCarPhotos.Width;
      Picture.Bitmap.Height := ilCarPhotos.Height;
      ilCarPhotos.Draw(Picture.Bitmap.Canvas, 0, 0, AImageIndex);
      dxExEdtr.SavePicture(Picture, Result);
    finally
      Picture.Free;
    end;
  end;
  
begin
  irMBPhoto.Text := BitmapToText(0);
  irBMWPhoto.Text := BitmapToText(1);  
end;

procedure TdxInspectorDesignWindow.CMDialogChar(var message: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with PageControl1 do
    for I := 0 to PageCount - 1 do
      if IsAccel(message.CharCode, Pages[I].Caption) then
      begin
        message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

procedure TdxInspectorDesignWindow.CreateControls;

  function CreateColorCombo(AParent: TWinControl; AHost: TControl;
    ATag: Integer; AAutoColor: TColor; ALabel: TLabel): TdxPSColorCombo;
  begin
    Result := TdxPSColorCombo.Create(Self);
    with TdxPSColorCombo(Result) do
    begin
      BoundsRect := AHost.BoundsRect;
      Tag := ATag;
      Parent := AParent;
      ColorTypes := [ctPure];
      ShowColorName := True;
      ShowAutoColor := True;
      AutoColor := AAutoColor;
      OnChange := ccbxColorChange;
    end;
    ALabel.FocusControl := Result;
    AHost.Visible := False;
  end;

begin
  FccbxColor := 
    CreateColorCombo(gbxTransparent, bvlColorHolder, 0, dxDefaultColor, lblColor);
  FccbxCaptionColor := 
    CreateColorCombo(gbxCaptionTransparent, bvlFixedColorHolder, 1, dxDefaultFixedColor, lblCaptionColor);
  FccbxGroupColor := 
    CreateColorCombo(gbxGroupTransparent, bvlGroupColorHolder, 2, dxDefaultFixedColor, lblGroupColor);
  FccbxGridLineColor := 
    CreateColorCombo(tshColors, bvlGridLineColorHolder, 3, dxDefaultGridLineColor, lblGridLinesColor);
end;  

procedure TdxInspectorDesignWindow.DoInitialize;
begin
  inherited DoInitialize;
  LoadDataToInspector;
  TCustomdxInspectorControlAccess(insPreview).SetFocusedNode(nil);
  
  chbxShowBorders.Checked := ReportLink.IsDrawBorder;
  chbxShowHorzLines.Checked := ReportLink.IsDrawHorzLines;
  chbxShowVertLines.Checked := ReportLink.IsDrawVertLines;
  chbxShowExpandButtons.Checked := ReportLink.IsShowExpandButtons;  
  chbxFlatCheckMarks.Checked := ReportLink.IsFlatCheckMarks;
  chbxShowImages.Checked := ReportLink.IsShowImages;
  chbxCheckMarksAsText.Checked := ReportLink.IsCheckMarksAsText;
  chbxDisplayGraphicsAsText.Checked := ReportLink.IsDisplayGraphicsAsText;
  chbxTransparentColumnGraphics.Checked := ReportLink.IsTransparentColumnGraphics;
  chbxAutoWidth.Checked := ReportLink.AutoWidth;

  chbxTransparent.Checked := ReportLink.Transparent;
  TdxPSColorCombo(FccbxColor).ColorValue := ColorToRGB(ReportLink.Color);
  chbxCaptionTransparent.Checked := ReportLink.FixedTransparent;
  chbxGroupTransparent.Checked := ReportLink.GroupTransparent; 
  
  TdxPSColorCombo(FccbxCaptionColor).ColorValue := ReportLink.FixedColor;
  TdxPSColorCombo(FccbxGroupColor).ColorValue := ReportLink.GroupColor;  
  TdxPSColorCombo(FccbxGridLineColor).ColorValue := ReportLink.GridLineColor;

  FontInfoToText(ReportLink.Font, edFont);
  FontInfoToText(ReportLink.FixedFont, edFixedFont);          
  FontInfoToText(ReportLink.GroupFont, edGroupFont);                    
    
  chbxAutoNodesExpand.Checked := ReportLink.AutoNodesExpand;
end;

procedure TdxInspectorDesignWindow.UpdateControlsState;
begin
  inherited UpdateControlsState;
  FccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := FccbxColor.Enabled;
  FccbxCaptionColor.Enabled := not chbxCaptionTransparent.Checked;
  lblCaptionColor.Enabled := FccbxCaptionColor.Enabled;
  FccbxGroupColor.Enabled := not chbxGroupTransparent.Checked;
  lblGroupColor.Enabled := FccbxGroupColor.Enabled;

  UpdatePreview;
end;

{$IFDEF DELPHI7}
function TdxInspectorDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TdxInspectorDesignWindow.LoadStrings;

  procedure AdjustBevelSize(ABevel: TBevel; ALabel: TLabel);
  var
    Right: Integer;
  begin
    Right := ABevel.BoundsRect.Right;
    ABevel.Left := ALabel.Left + ALabel.Width + 10;
    ABevel.Width := Right - ABevel.Left;
  end;

begin
  inherited;
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));
  
  irMBModel.Caption := cxGetResourceString(@sdxCarModelColumnCaption);
  irMBSUV.Caption := cxGetResourceString(@sdxCarIsSUVColumnCaption);
  irMBPhoto.Caption := cxGetResourceString(@sdxCarPhotoColumnCaption);

  irBMWModel.Caption := cxGetResourceString(@sdxCarModelColumnCaption);
  irBMWSUV.Caption := cxGetResourceString(@sdxCarIsSUVColumnCaption);
  irBMWPhoto.Caption := cxGetResourceString(@sdxCarPhotoColumnCaption);
  
  tshOptions.Caption := cxGetResourceString(@sdxOptions);
  lblShow.Caption := cxGetResourceString(@sdxShow);
  AdjustBevelSize(bvlShow, lblShow);
  chbxShowBorders.Caption := cxGetResourceString(@sdxBorderLines);
  chbxShowHorzLines.Caption := cxGetResourceString(@sdxHorzLines);
  chbxShowVertLines.Caption := cxGetResourceString(@sdxVertLines);
  chbxShowExpandButtons.Caption := cxGetResourceString(@sdxExpandButtons);
  chbxShowImages.Caption := cxGetResourceString(@sdxImages);
  
  lblBehaviors.Caption := cxGetResourceString(@sdxBehaviors);
  AdjustBevelSize(bvlBehaviors, lblBehaviors);  
  chbxAutoNodesExpand.Caption := cxGetResourceString(@sdxAutoNodesExpand);
  chbxAutoWidth.Caption := cxGetResourceString(@sdxAutoWidth);
    
  tshColors.Caption := cxGetResourceString(@sdxColors);
  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  lblColor.Caption := cxGetResourceString(@sdxColor);
  stCaptionTransparent.Caption := ' ' + cxGetResourceString(@sdxCaptionTransparent) + ' ';
  lblCaptionColor.Caption := cxGetResourceString(@sdxCaptionColor);
  stGroupTransparent.Caption := ' ' + cxGetResourceString(@sdxGroupTransparent) + ' ';
  lblGroupColor.Caption := cxGetResourceString(@sdxGroupColor);
  lblGridLinesColor.Caption := cxGetResourceString(@sdxGridLinesColor);
        
  tshFonts.Caption := cxGetResourceString(@sdxFonts);
  btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  btnFixedFont.Caption := cxGetResourceString(@sdxBtnFixedFont);
  btnGroupFont.Caption := cxGetResourceString(@sdxBtnGroupFont);

  tshFormatting.Caption := cxGetResourceString(@sdxFormatting);
  lblRefinements.Caption := cxGetResourceString(@sdxRefinements);
  AdjustBevelSize(bvlAppearance, lblRefinements);
  chbxFlatCheckMarks.Caption := cxGetResourceString(@sdxFlatCheckMarks);
  chbxCheckMarksAsText.Caption := cxGetResourceString(@sdxCheckMarksAsText);
  chbxDisplayGraphicsAsText.Caption := cxGetResourceString(@sdxDisplayGraphicsAsText);
  chbxTransparentColumnGraphics.Caption := cxGetResourceString(@sdxTransparentColumnGraphics);
end;

procedure TdxInspectorDesignWindow.ccbxColorChange(Sender: TObject);
var
  AColor: TColor;
begin
  if LockControlsUpdate then Exit;
  AColor := TdxPSColorCombo(Sender).ColorValue;
  case TdxPSColorCombo(Sender).Tag of
    0: ReportLink.Color := AColor;
    1: ReportLink.FixedColor := AColor;
    2: ReportLink.GroupColor := AColor;
    3: ReportLink.GridLineColor := AColor;
  end;
  Modified := True;
end;

procedure TdxInspectorDesignWindow.chbxAutoNodesExpandClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.AutoNodesExpand := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxInspectorDesignWindow.UpdatePreview;
const
  BorderStyleMap: array[Boolean] of TBorderStyle = (bsNone, bsSingle);
  MBImageIndexes: array[Boolean] of Integer = (-1, 0);
  BMWImageIndexes: array[Boolean] of Integer = (-1, 1);
begin
  if ReportLink.CustomInspector <> nil then 
    insPreview.PaintStyle := TCustomdxInspectorControlAccess(ReportLink.CustomInspector).PaintStyle;
  insPreview.GridColor := ReportLink.GridLineColor;
  irMersedesBenz.ImageIndex := MBImageIndexes[ReportLink.IsShowImages];
  irBMW.ImageIndex := BMWImageIndexes[ReportLink.IsShowImages];  
  irMBSUV.Border3D := not ReportLink.IsFlatCheckMarks;
  irBMWSUV.Border3D := not ReportLink.IsFlatCheckMarks;  

  insPreview.Invalidate;
  pnlPreviewHost.BorderStyle := BorderStyleMap[ReportLink.IsDrawBorder];
  //shPreviewFrame.Pen.Color := ReportLink.GridLineColor;
end;

procedure TdxInspectorDesignWindow.chbxTransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  case TCheckBox(Sender).Tag of
    0: ReportLink.Transparent := TCheckBox(Sender).Checked;
    1: ReportLink.FixedTransparent := TCheckBox(Sender).Checked;
    2: ReportLink.GroupTransparent := TCheckBox(Sender).Checked;
  end;
  Modified := True;
end;

procedure TdxInspectorDesignWindow.stCaptionTransparentClick(Sender: TObject);
begin
  if chbxCaptionTransparent.CanFocus then ActiveControl := chbxCaptionTransparent;
  chbxCaptionTransparent.Checked := not chbxCaptionTransparent.Checked;
end;

procedure TdxInspectorDesignWindow.stGroupTransparentClick(Sender: TObject);
begin
  if chbxGroupTransparent.CanFocus then ActiveControl := chbxGroupTransparent;
  chbxGroupTransparent.Checked := not chbxGroupTransparent.Checked;
end;

procedure TdxInspectorDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxInspectorDesignWindow.chbxAutoWidthClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.AutoWidth := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxInspectorDesignWindow.btnFontClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with dxPSGlbl.FontDialog do 
  begin
    case TButton(Sender).Tag of
      0: Font := ReportLink.Font;
      1: Font := ReportLink.FixedFont;
      2: Font := ReportLink.GroupFont;
    end;
    
    if Execute then
    begin
      case TButton(Sender).Tag of
        0:
          begin
            ReportLink.Font := Font;
            FontInfoToText(ReportLink.Font, edFont);
          end;
        1:
          begin
            ReportLink.FixedFont := Font;
            FontInfoToText(ReportLink.FixedFont, edFixedFont);          
          end;
        2:
          begin
            ReportLink.GroupFont := Font;
            FontInfoToText(ReportLink.GroupFont, edGroupFont);
          end;
      end;
      Modified := True;
    end;
  end;  
end;

procedure TdxInspectorDesignWindow.chbxOptionsClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TCheckBox(Sender) do 
    if Checked then
      ReportLink.Options := ReportLink.Options + [TdxInspectorPaintOption(Tag)]
    else  
      ReportLink.Options := ReportLink.Options - [TdxInspectorPaintOption(Tag)];
  Modified := True;
end;

function TdxInspectorDesignWindow.CaptionColor: TColor;
begin
  if ReportLink.FixedTransparent then
    Result := clWindow
  else
    Result := ReportLink.FixedColor;
end;

function TdxInspectorDesignWindow.GroupColor: TColor;
begin
  if ReportLink.GroupTransparent then
    Result := clWindow
  else
    Result := ReportLink.GroupColor;
end;

function TdxInspectorDesignWindow.ValueColor: TColor;
begin
  if ReportLink.Transparent then
    Result := clWindow
  else
    Result := ReportLink.Color;
end;

{ custom draw helpers }

procedure FillRectColor(ACanvas: TCanvas; const R: TRect; AColor: TColor);
begin
  ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(R);
end;

procedure DrawTextRect(ACanvas: TCanvas; R: TRect; const AText: string; 
  AFont: TFont; AColor: TColor; ATextAlignY: TcxTextAlignY);
var  
  X, Y: Integer;
begin
  FillRectColor(ACanvas, R, AColor);
  InflateRect(R, -2, 0);  
  ACanvas.Font := AFont;
  ACanvas.Brush.Style := bsClear;
  X := R.Left + 2;
  if ATextAlignY = taTop then 
    Y := R.Top + 2
  else
    Y := R.Top + (R.Bottom - R.Top - ACanvas.TextHeight(AText)) div 2;
  ACanvas.TextRect(R, X, Y, AText);
end;  

procedure DrawExpandButton(ACanvas: TCanvas; R: TRect; AColor: TColor; 
  APaintStyle: TdxInspectorPaintStyle);
const
  AreDrawBorders: array[TdxInspectorPaintStyle] of Boolean = 
    (False, True, True, True, False);
  IsDrawSign: array[TdxInspectorPaintStyle] of Boolean = 
    (True, True, True, True, False);
  Borders3D: array[TdxInspectorPaintStyle] of Boolean = 
    (False, False, True, False, False);
  ButtonSizes: array[TdxInspectorPaintStyle] of Integer =
    (dxInspectorButtonSize, dxInspectorButtonSize, dxInspectorButtonExSize, 
     dxInspectorButtonSize, dxInspectorButtonSize);    
var
  ButtonSize: Integer;   
begin
  ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(R);

  ButtonSize := ButtonSizes[APaintStyle];
  with R do 
    R := Bounds(Left + (Right - Left - ButtonSize) div 2, 
      Top + (Bottom - Top - ButtonSize) div 2, ButtonSize, ButtonSize);
  if AreDrawBorders[APaintStyle] then
  begin
    if Borders3D[APaintStyle] then
    begin
      DrawEdge(ACanvas.Handle, R, EDGE_RAISED, BF_RECT or BF_SOFT);
      InflateRect(R, -1, -1);
      Dec(R.Right);
      Dec(R.Bottom);      
    end
    else
    begin
      ACanvas.Brush.Color := clWindowText;
      ACanvas.FrameRect(R);
      InflateRect(R, -1, -1);
    end;  
  end  
  else
  begin
    InflateRect(R, -1, -2);
    OffsetRect(R, 1, 0);
  end;  
    
  if IsDrawSign[APaintStyle] then
  begin
    with R do 
      R := Rect(Left + 1, Top + (Bottom - Top) div 2, Right - 1, Top + (Bottom - Top) div 2 + 1);
    ACanvas.Brush.Color := clWindowText;
    ACanvas.FillRect(R);
  end;  
end;

procedure TdxInspectorDesignWindow.irMBSUVDrawValue(
  Sender: TdxInspectorRow; ACanvas: TCanvas; ARect: TRect;
  var AText: String; AFont: TFont; var AColor: TColor; var ADone: Boolean);
begin
  AFont := ReportLink.Font;
  AColor := ValueColor; 
  if ReportLink.IsCheckMarksAsText then 
  begin
    DrawTextRect(ACanvas, ARect, AText, AFont, AColor, taCenterY);
    ADone := True;
  end;
end;

procedure TdxInspectorDesignWindow.InspectorDrawValue(
  Sender: TdxInspectorRow; ACanvas: TCanvas; ARect: TRect;
  var AText: String; AFont: TFont; var AColor: TColor; var ADone: Boolean);
begin
  DrawTextRect(ACanvas, ARect, AText, ReportLink.Font, ValueColor, taCenterY);
  ADone := True;
end;

procedure TdxInspectorDesignWindow.irMBPhotoDrawValue(
  Sender: TdxInspectorRow; ACanvas: TCanvas; ARect: TRect;
  var AText: String; AFont: TFont; var AColor: TColor; var ADone: Boolean);
begin
  AFont := ReportLink.Font;
  AColor := ValueColor; 
  if ReportLink.IsDisplayGraphicsAsText then 
  begin
    DrawTextRect(ACanvas, ARect, ReportLink.GraphicAsTextText, AFont, AColor, taTop);
    ADone := True;
  end;
end;

procedure TdxInspectorDesignWindow.InspectorDrawCaption(
  Sender: TdxInspectorRow; ACanvas: TCanvas; ARect: TRect;
  var AText: string; AFont: TFont; var AColor: TColor; var ADone: Boolean);
type
  TdxInspectorCaptionIndentDrawInfo = record
    CategoryIndentRect: TRect;
    ImageRect: TRect;
    IndentRect: TRect;
  end;
  
  procedure CalcDrawInfo(var ADrawInfo: TdxInspectorCaptionIndentDrawInfo);
  const
    IndentWidth = 14;
  begin
    FillChar(ADrawInfo, SizeOf(TdxInspectorCaptionIndentDrawInfo), 0);
    
    with ADrawInfo do 
    begin
      ImageRect := ARect;
      CategoryIndentRect := ARect;
      IndentRect := ARect;

      ImageRect.Right := ImageRect.Left;
      IndentRect.Right := IndentRect.Left;
      CategoryIndentRect.Right := CategoryIndentRect.Left;              
          
      if Sender.IsCategory then
      begin
        if Sender.ImageIndex <> -1 then
          Dec(ImageRect.Left, ilVendorLogos.Width);
        CategoryIndentRect.Right := ImageRect.Left;    
        CategoryIndentRect.Left := 0;
      end
      else
      begin
        IndentRect.Left := IndentRect.Right - IndentWidth;
        if insPreview.PaintStyle = ipsNet then
        begin
          CategoryIndentRect.Right := IndentRect.Left;    
          CategoryIndentRect.Left := 0;
        end  
        else
          IndentRect.Left := 0;
      end;
      if (insPreview.PaintStyle = ipsNet) and ((Sender <> irMBPhoto) and (Sender <> irBMWPhoto)) then
        Inc(CategoryIndentRect.Bottom);
    end;  
  end;
  
  procedure DrawImage(const R: TRect);
  begin
    FillRectColor(ACanvas, R, GroupColor);
    ilVendorLogos.Draw(ACanvas, R.Left, R.Top, Sender.ImageIndex);
  end;
  
const
  TextAligns: array[Boolean] of TcxTextAlignY = (taCenterY, taTop);
var
  DrawInfo: TdxInspectorCaptionIndentDrawInfo;
begin
  if Sender.IsCategory then
  begin
    AColor := GroupColor;
    AFont := ReportLink.GroupFont;
  end
  else
  begin
    AColor := CaptionColor;
    AFont := ReportLink.FixedFont;      
  end;  

  DrawTextRect(ACanvas, ARect, AText, AFont, AColor, TextAligns[Sender is TdxInspectorTextGraphicRow]);
  CalcDrawInfo(DrawInfo);
  with DrawInfo do 
  begin
    if not IsRectEmpty(ImageRect) then 
      DrawImage(ImageRect);
    if not IsRectEmpty(IndentRect) then 
      FillRectColor(ACanvas, IndentRect, AColor);
    if not IsRectEmpty(CategoryIndentRect) then
    begin 
      if Sender.IsCategory and ReportLink.IsDrawExpandButtons then 
        DrawExpandButton(ACanvas, CategoryIndentRect, GroupColor, insPreview.PaintStyle)
      else                
        FillRectColor(ACanvas, CategoryIndentRect, GroupColor);
      if not Sender.IsCategory then 
      begin
        CategoryIndentRect.Left := CategoryIndentRect.Right - 1;
        FillRectColor(ACanvas, CategoryIndentRect, ReportLink.GridLineColor);
      end;
    end;  
  end;
  ADone := True;
end;

procedure TdxInspectorDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreview.Parent := TPageControl(Sender).ActivePage;
end;

procedure RegisterHelpers;
begin
  TdxInspectorRowHelper.Register;
  TdxInspectorImageRowHelper.Register;
end;

procedure UnregisterHelpers;
begin
  TdxRowHelpersFactory.ReleaseInstance;
end;

initialization
  RegisterHelpers;
  
  dxPSRegisterReportLink(TdxInspectorReportLink, TdxInspector, TdxInspectorDesignWindow);
  FPicture := TPicture.Create;
  
finalization
  FPicture.Free;
  dxPSUnregisterReportLink(TdxInspectorReportLink, TdxInspector, TdxInspectorDesignWindow);
  UnregisterHelpers;

end.

