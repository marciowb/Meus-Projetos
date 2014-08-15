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

unit dxPScxPivotGrid2Lnk;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, {$IFDEF DELPHI6} Variants, {$ENDIF} Classes, Graphics, 
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, ImgList, Menus, cxStyles, 
  cxControls, dxPSUtl, cxLookAndFeels, cxLookAndFeelPainters, cxCustomPivotGrid, 
  cxDBPivotGrid, dxPSCore, dxPSGlbl, dxPScxCommon, cxGraphics, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxClasses, cxPivotGrid, cxCustomData;

const

  // visual print style indexes
  vspsPGridFirst            = 0;
  vspsPGridColumnHeader     = vspsPGridFirst + 0;
  vspsPGridContent          = vspsPGridFirst + 1;
  vspsPGridFieldHeader      = vspsPGridFirst + 2;
  vspsPGridHeaderBackground = vspsPGridFirst + 3;
  vspsPGridPrefilter        = vspsPGridFirst + 4;
  vspsPGridRowHeader        = vspsPGridFirst + 5;
  vspsPGridLast = vspsPGridRowHeader;
  
  //
  cxPivotGridAttributeIDBase    = 0;
  cxPivotGridDataCellID         = cxPivotGridAttributeIDBase + 1;
  cxPivotGridFieldHeaderCellID  = cxPivotGridAttributeIDBase + 2;
  cxPivotGridGroupHeaderCellID  = cxPivotGridAttributeIDBase + 3;
  cxPivotGridPrefilterID        = cxPivotGridAttributeIDBase + 4;
  cxPivotGridHeaderBackgroundID = cxPivotGridAttributeIDBase + 5;

type
  TcxPivotGridReportLink = class;
  TcxfmPivotGridReportLinkDesignWindow = class;

  { TcxPivotGridReportLinkOptionsExpanding }

  TcxPivotGridReportLinkOptionsExpanding = class(TdxCustomReportLinkOptionsExpanding)
  private
    FAutoExpandColumns: Boolean;
    FAutoExpandRows: Boolean;
    procedure SetAutoExpandColumns(AValue: Boolean);
    procedure SetAutoExpandRows(AValue: Boolean);
  protected
    procedure AssignToPivot(APivotGrid: TcxCustomPivotGrid); virtual;
    function DesignerTabIndex: Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property AutoExpandColumns: Boolean read FAutoExpandColumns write SetAutoExpandColumns default False;
    property AutoExpandRows: Boolean read FAutoExpandRows write SetAutoExpandRows default False;
  end;

  { TcxPivotGridReportLinkOptionsView }

  TcxPivotGridReportLinkOptionsView = class(TdxCustomReportLinkOptionsView)
  private
    FBorders: Boolean;
    FColumnFields: Boolean;
    FDataFields: Boolean;
    FExpandButtons: Boolean;
    FFilterFields: Boolean;
    FGridLines: TcxPivotGridLines;
    FPrefilter: TcxPivotGridPrefilterVisible;
    FRowFields: Boolean;
    procedure SetBorders(AValue: Boolean);
    procedure SetColumnFields(AValue: Boolean);
    procedure SetDataFields(AValue: Boolean);
    procedure SetExpandButtons(AValue: Boolean);
    procedure SetFilterFields(AValue: Boolean);
    procedure SetGridLines(AValue: TcxPivotGridLines);
    procedure SetPrefilter(AValue: TcxPivotGridPrefilterVisible);
    procedure SetRowFields(AValue: Boolean);
  protected
    procedure AssignToPivot(APivotGrid: TcxCustomPivotGrid); virtual;
    procedure SetBoolValue(var AField: Boolean; ANewValue: Boolean);
    function DesignerTabIndex: Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property Borders: Boolean read FBorders write SetBorders default True;
    property ColumnFields: Boolean read FColumnFields write SetColumnFields default True;
    property DataFields: Boolean read FDataFields write SetDataFields default True;
    property ExpandButtons: Boolean read FExpandButtons write SetExpandButtons default True;
    property FilterFields: Boolean read FFilterFields write SetFilterFields default False;
    property GridLines: TcxPivotGridLines read FGridLines write SetGridLines default pglBoth;
    property Prefilter: TcxPivotGridPrefilterVisible read FPrefilter write SetPrefilter default pfvAlways;
    property RowFields: Boolean read FRowFields write SetRowFields default True;
  end;

  { TcxPivotGridReportLinkOptionsFormatting }
  
  TcxPivotGridReportLinkOptionsFormatting = class(TdxCustomReportLinkOptionsFormatting)
  private
    FSuppressContentColoration: Boolean;
    procedure SetSuppressContentColoration(AValue: Boolean);
  protected
    procedure AssignToPivot(APivotGrid: TcxCustomPivotGrid); virtual;
    function DesignerTabIndex: Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property SuppressContentColoration: Boolean read FSuppressContentColoration write SetSuppressContentColoration default False;
    property UseLookAndFeelColors;
  end;

  { TcxPivotGridReportLinkStyles }

  TcxPivotGridReportLinkStyles = class(TdxCustomReportLinkStyles, IcxPivotGridBaseStyles)
  private
    function GetReportLink: TcxPivotGridReportLink;
  protected
    procedure AssignToPivot(AFromGrid, ADestGrid: TcxCustomPivotGrid; AUsePivotStyles: Boolean); virtual;
    function DesignerTabIndex: Integer; override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    class function GetStyleCaption(AnIndex: Integer): string; override;
    function GetStyleIndexByCaption(const Caption: string): Integer; override;
    function UsePivotStyles: Boolean;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    function GetColumnHeaderParams(AColumn: TcxPivotGridViewDataItem): TcxViewParams;
    function GetContentParams(ACell: TcxPivotGridDataCellViewInfo): TcxViewParams;
    function GetFieldHeaderParams(AField: TcxPivotGridField): TcxViewParams;
    function GetHeaderBackgroundParams(AArea: TcxPivotGridFieldArea): TcxViewParams;
    function GetPrefilterParams: TcxViewParams;
    function GetRowHeaderParams(ARow: TcxPivotGridViewDataItem): TcxViewParams;

    property ReportLink: TcxPivotGridReportLink read GetReportLink;
  published
    property ColumnHeader: TcxStyle index vspsPGridColumnHeader read GetValue write SetValue;
    property Content: TcxStyle index vspsPGridContent read GetValue write SetValue;
    property FieldHeader: TcxStyle index vspsPGridFieldHeader read GetValue write SetValue;
    property HeaderBackground: TcxStyle index vspsPGridHeaderBackground read GetValue write SetValue;
    property Prefilter: TcxStyle index vspsPGridPrefilter read GetValue write SetValue; 
    property RowHeader: TcxStyle index vspsPGridRowHeader read GetValue write SetValue;
    property StyleSheet;
  end;

  TcxPivotGridReportLinkStylesClass = class of TcxPivotGridReportLinkStyles;

  { TcxPivotGridReportLinkStyleSheet }

  TcxPivotGridReportLinkStyleSheet = class(TdxCustomReportLinkStyleSheet)
  private
    function GetStylesValue: TcxPivotGridReportLinkStyles;
    procedure SetStylesValue(AValue: TcxPivotGridReportLinkStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxPivotGridReportLinkStyles read GetStylesValue write SetStylesValue;
  end;

  { TcxPivotGridReportLink }

  TcxPivotGridReportLinkCustomDrawDataCellEventEvent = procedure(Sender: TcxPivotGridReportLink;
    ACanvas: TCanvas; AnItem: TAbstractdxReportCellData; var ADone: Boolean) of object;

  TcxPivotGridReportLinkCustomDrawFieldHeaderCellEvent = procedure(Sender: TcxPivotGridReportLink;
    ACanvas: TCanvas; AnItem: TdxReportCell; var ADone: Boolean) of object;

  TcxPivotGridReportLinkCustomDrawGroupHeaderCellEvent = procedure(Sender: TcxPivotGridReportLink;
    ACanvas: TCanvas; AnItem: TdxReportCell; var ADone: Boolean) of object;

  TcxPivotGridReportLinkCustomDrawHeaderBackgroundEvent = procedure(Sender: TcxPivotGridReportLink;
    ACanvas: TCanvas; AnItem: TdxReportCell; var ADone: Boolean) of object;

  TcxPivotGridReportLinkCustomDrawPrefilterEvent = procedure(Sender: TcxPivotGridReportLink;
    ACanvas: TCanvas; AnItem: TdxReportCellText; var ADone: Boolean) of object;

  TcxPivotGridReportLinkInitializeDataCellEvent = procedure(Sender: TcxPivotGridReportLink;
    ACell: TcxPivotGridDataCellViewInfo; AnItem: TAbstractdxReportCellData) of object;

  TcxPivotGridReportLinkInitializeFieldHeaderCellEvent = procedure(Sender: TcxPivotGridReportLink;
    ACell: TcxPivotGridFieldHeaderCellViewInfo; AnItem: TdxReportCell) of object;

  TcxPivotGridReportLinkInitializeGroupHeaderCellEvent = procedure(Sender: TcxPivotGridReportLink;
    ACell: TcxPivotGridHeaderCellViewInfo; AnItem: TdxReportCell) of object;

  TcxPivotGridReportLinkInitializeHeaderBackgroundEvent = procedure(Sender: TcxPivotGridReportLink;
    ACell: TcxPivotGridHeaderBackgroundCellViewInfo; AnItem: TdxReportCell) of object;

  TcxPivotGridReportLinkInitializePrefilterEvent = procedure(Sender: TcxPivotGridReportLink;
    ACell: TcxPivotGridPrefilterViewInfo; AnItem: TdxReportCellText) of object;

  TcxPivotGridReportLink = class(TdxCustomcxControlReportLink, IdxPSCellParams)
  private
    FHostCell: TdxReportCell;
    FLookAndFeelItems: TList;
    FOnCustomDrawDataCell: TcxPivotGridReportLinkCustomDrawDataCellEventEvent;
    FOnCustomDrawFieldHeaderCell: TcxPivotGridReportLinkCustomDrawFieldHeaderCellEvent;
    FOnCustomDrawGroupHeaderCell: TcxPivotGridReportLinkCustomDrawGroupHeaderCellEvent;
    FOnCustomDrawHeaderBackground: TcxPivotGridReportLinkCustomDrawHeaderBackgroundEvent;
    FOnCustomDrawPrefilter: TcxPivotGridReportLinkCustomDrawPrefilterEvent;
    FOnInitializeDataCell: TcxPivotGridReportLinkInitializeDataCellEvent;
    FOnInitializeFieldHeaderCell: TcxPivotGridReportLinkInitializeFieldHeaderCellEvent;
    FOnInitializeGroupHeaderCell: TcxPivotGridReportLinkInitializeGroupHeaderCellEvent;
    FOnInitializeHeaderBackground: TcxPivotGridReportLinkInitializeHeaderBackgroundEvent;
    FOnInitializePrefilter: TcxPivotGridReportLinkInitializePrefilterEvent;
    function GetActiveStyles: TcxPivotGridReportLinkStyles;
    function GetDesignWindow: TcxfmPivotGridReportLinkDesignWindow;
    function GetGridLineColor: TColor;
    function GetOptionsExpanding: TcxPivotGridReportLinkOptionsExpanding;
    function GetOptionsFormatting: TcxPivotGridReportLinkOptionsFormatting; 
    function GetOptionsView: TcxPivotGridReportLinkOptionsView;

    function GetStyles: TcxPivotGridReportLinkStyles;
    function GetPivotGrid: TcxCustomPivotGrid;
    procedure SetOptionsExpanding(AValue: TcxPivotGridReportLinkOptionsExpanding);
    procedure SetOptionsFormatting(AValue: TcxPivotGridReportLinkOptionsFormatting);
    procedure SetOptionsView(AValue: TcxPivotGridReportLinkOptionsView);
    procedure SetStyles(AValue: TcxPivotGridReportLinkStyles);
  protected
    procedure BuildReport; virtual;
    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure ConvertCoords; override;
    procedure CustomDraw(AItem: TAbstractdxReportCellData; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); override;

    procedure DoCustomDrawDataCell(ACanvas: TCanvas; AItem: TAbstractdxReportCellData; var ADone: Boolean); virtual;
    procedure DoCustomDrawFieldHeaderCell(ACanvas: TCanvas; AItem: TdxReportCell; var ADone: Boolean); virtual;
    procedure DoCustomDrawGroupHeaderCell(ACanvas: TCanvas; AItem: TdxReportCell; var ADone: Boolean); virtual;
    procedure DoCustomDrawHeaderBackground(ACanvas: TCanvas; AItem: TdxReportCell; var ADone: Boolean); virtual;
    procedure DoCustomDrawPrefilter(ACanvas: TCanvas; AItem: TdxReportCellString; var ADone: Boolean); virtual;
    procedure DoInitializeDataCell(AItem: TAbstractdxReportCellData; ACell: TcxPivotGridDataCellViewInfo); virtual;
    procedure DoInitializeFieldHeaderCell(AItem: TdxReportCell; ACell: TcxPivotGridFieldHeaderCellViewInfo); virtual;
    procedure DoInitializeGroupHeaderCell(AItem: TdxReportCell; ACell: TcxPivotGridHeaderCellViewInfo); virtual;
    procedure DoInitializeHeaderBackground(AItem: TdxReportCell; ACell: TcxPivotGridHeaderBackgroundCellViewInfo); virtual;
    procedure DoInitializePrefilter(AItem: TdxReportCellString; ACell: TcxPivotGridPrefilterViewInfo); virtual;

    { IdxPSCellParams }
    function IdxPSCellParams.GetAutoHeight = IdxPSCellParams_GetAutoHeight;
    function IdxPSCellParams.GetDC = IdxPSCellParams_GetDC;
    function IdxPSCellParams.GetDisplayGraphicsAsText = IdxPSCellParams_GetDisplayGraphicsAsText;
    function IdxPSCellParams.GetEndEllipsis = IdxPSCellParams_GetEndEllipsis;
    function IdxPSCellParams.GetFlatCheckMarks = IdxPSCellParams_GetFlatCheckMarks;
    function IdxPSCellParams.GetGraphicsText = IdxPSCellParams_GetGraphicsText;
    function IdxPSCellParams.GetMultiline = IdxPSCellParams_GetMultiline;
    function IdxPSCellParams.GetTransparentGraphics = IdxPSCellParams_GetTransparentGraphics;
    function IdxPSCellParams_GetAutoHeight: Boolean; virtual;
    function IdxPSCellParams_GetDC: HDC; virtual;
    function IdxPSCellParams_GetDisplayGraphicsAsText: Boolean; virtual;
    function IdxPSCellParams_GetEndEllipsis: Boolean; virtual;
    function IdxPSCellParams_GetFlatCheckMarks: Boolean; virtual;
    function IdxPSCellParams_GetGraphicsText: string; virtual;
    function IdxPSCellParams_GetMultiline: Boolean; virtual;
    function IdxPSCellParams_GetTransparentGraphics: Boolean; virtual;

    procedure GetImageLists(AProc: TdxPSGetImageListProc); override;
    procedure InternalRestoreFromOriginal; override;
    function IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean; override;
    procedure FormatLookAndFeelItems;
    function GetEdgeMode: TdxCellEdgeMode;
    function GetOptionsExpandingClass: TdxCustomReportLinkOptionsExpandingClass; override;
    function GetOptionsFormattingClass: TdxCustomReportLinkOptionsFormattingClass; override;
    function GetOptionsViewClass: TdxCustomReportLinkOptionsViewClass; override;

    function GetAreNativeStylesAvailable: Boolean; override;
    function GetStylesClass: TdxCustomReportLinkStylesClass; override;
    function GetStyleSheetClass: TdxCustomReportLinkStyleSheetClass; override;
    function GetStyleSheetPrototype: TdxCustomReportLinkStyleSheet; override;
    procedure PrepareConstruct; override;
    procedure UnprepareConstruct; override;
    //
    procedure AddDataCell(ACell: TcxPivotGridDataCellViewInfo);
    procedure AddFieldHeaderCell(ACell: TcxPivotGridFieldHeaderCellViewInfo);
    procedure AddHeaderBackground(ACell: TcxPivotGridHeaderBackgroundCellViewInfo);
    procedure AddHeaderCell(ACell: TcxPivotGridHeaderCellViewInfo);
    procedure AddPrefilter(ACell: TcxPivotGridPrefilterViewInfo);
    function CreateHeaderCell(ACell: TcxPivotGridHeaderCellViewInfo; AttributeID: Integer): TdxReportCell;

    procedure InitializeOptionsBeforeBuildReport(AController: TcxPivotGridExportController); virtual;
    procedure ProcessCreateReportItems(AViewInfo: TcxPivotGridViewInfo); virtual;
    procedure RegisterLookAndFeelItem(AItem: TdxReportVisualItem; AEdgeStyle: TdxCellEdgeStyle);
    procedure SetCellViewParams(ACell: TdxReportVisualItem; const AParams: TcxViewParams);
    procedure SetCellViewParamsEx(ACell: TdxReportVisualItem;
      const AParams: TdxReportItemViewParams);

    property ActiveStyles: TcxPivotGridReportLinkStyles read GetActiveStyles;
    property GridLineColor: TColor read GetGridLineColor;
    property HostCell: TdxReportCell read FHostCell;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property DesignWindow: TcxfmPivotGridReportLinkDesignWindow read GetDesignWindow;
    property LookAndFeelItems: TList read FLookAndFeelItems;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  published
    property Color;
    property Font;
    property OptionsExpanding: TcxPivotGridReportLinkOptionsExpanding read GetOptionsExpanding write SetOptionsExpanding;
    property OptionsFormatting: TcxPivotGridReportLinkOptionsFormatting read GetOptionsFormatting write SetOptionsFormatting;
    property OptionsView: TcxPivotGridReportLinkOptionsView read GetOptionsView write SetOptionsView;
    property ScaleFonts;
    property StyleRepository;
    property Styles: TcxPivotGridReportLinkStyles read GetStyles write SetStyles;
    property SupportedCustomDraw;
    property OnCustomDrawDataCell: TcxPivotGridReportLinkCustomDrawDataCellEventEvent read FOnCustomDrawDataCell write FOnCustomDrawDataCell;
    property OnCustomDrawFieldHeaderCell: TcxPivotGridReportLinkCustomDrawFieldHeaderCellEvent read FOnCustomDrawFieldHeaderCell write FOnCustomDrawFieldHeaderCell;
    property OnCustomDrawGroupHeaderCell: TcxPivotGridReportLinkCustomDrawGroupHeaderCellEvent read FOnCustomDrawGroupHeaderCell write FOnCustomDrawGroupHeaderCell;
    property OnCustomDrawHeaderBackground: TcxPivotGridReportLinkCustomDrawHeaderBackgroundEvent read FOnCustomDrawHeaderBackground write FOnCustomDrawHeaderBackground;
    property OnCustomDrawPrefilter: TcxPivotGridReportLinkCustomDrawPrefilterEvent read FOnCustomDrawPrefilter write FOnCustomDrawPrefilter;
    property OnInitializeDataCell: TcxPivotGridReportLinkInitializeDataCellEvent read FOnInitializeDataCell write FOnInitializeDataCell;
    property OnInitializeFieldHeaderCell: TcxPivotGridReportLinkInitializeFieldHeaderCellEvent read FOnInitializeFieldHeaderCell write FOnInitializeFieldHeaderCell;
    property OnInitializeGroupHeaderCell: TcxPivotGridReportLinkInitializeGroupHeaderCellEvent read FOnInitializeGroupHeaderCell write FOnInitializeGroupHeaderCell;
    property OnInitializeHeaderBackground: TcxPivotGridReportLinkInitializeHeaderBackgroundEvent read FOnInitializeHeaderBackground write FOnInitializeHeaderBackground;
    property OnInitializePrefilter: TcxPivotGridReportLinkInitializePrefilterEvent read FOnInitializePrefilter write FOnInitializePrefilter;
  end;

  TcxfmPivotGridReportLinkDesignWindow = class(TdxfmCustomcxControlReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshView: TTabSheet;
    lblShow: TLabel;
    bvlShow: TBevel;
    chbxColumnFields: TCheckBox;
    chbxShowExpandButtons: TCheckBox;
    chbxHorizontalLines: TCheckBox;
    chbxVerticalLines: TCheckBox;
    tshBehaviors: TTabSheet;
    lblExpanding: TLabel;
    bvlExpanding: TBevel;
    chbxExpandRows: TCheckBox;
    tshFormatting: TTabSheet;
    lblLookAndFeel: TLabel;
    bvlLookAndFeel: TBevel;
    imgLookAndFeel: TImage;
    imgRefinements: TImage;
    lblRefinements: TLabel;
    bvlRefinements: TBevel;
    cbxLookAndFeel: TComboBox;
    chbxSuppressBackgroundBitmaps: TCheckBox;
    tshStyles: TTabSheet;
    bvlStyles: TBevel;
    bvlStyleSheets: TBevel;
    lblStyleSheets: TLabel;
    bvlStylesHost: TBevel;
    Label1: TLabel;
    btnStyleColor: TButton;
    btnStyleFont: TButton;
    btnStyleBackgroundBitmap: TButton;
    chbxUseNativeStyles: TCheckBox;
    btnStyleSheetNew: TButton;
    btnStyleSheetCopy: TButton;
    btnStyleSheetDelete: TButton;
    btnStylesSaveAs: TButton;
    btnStyleSheetRename: TButton;
    btnStyleBackgroundBitmapClear: TButton;
    btnStyleRestoreDefaults: TButton;
    pnlPreview: TPanel;
    cxStyleRepository1: TcxStyleRepository;
    styleCategory: TcxStyle;
    styleHeader: TcxStyle;
    styleContent: TcxStyle;
    pmStyles: TPopupMenu;
    miStyleFont: TMenuItem;
    miStyleColor: TMenuItem;
    miLine3: TMenuItem;
    miStyleBackgroundBitmap: TMenuItem;
    miStyleBackgroundBitmapClear: TMenuItem;
    milLine: TMenuItem;
    miStylesSelectAll: TMenuItem;
    miLine2: TMenuItem;
    miStyleRestoreDefaults: TMenuItem;
    miLine4: TMenuItem;
    miStylesSaveAs: TMenuItem;
    ilStylesPopup: TImageList;
    chbxExpandColumns: TCheckBox;
    chbxSuppressContentColoration: TCheckBox;
    lblUseNativeStyles: TLabel;
    cbxStyleSheets: TComboBox;
    chbxBorders: TCheckBox;
    chbxDataFields: TCheckBox;
    chbxFilterFields: TCheckBox;
    chbxRowFields: TCheckBox;
    Bevel1: TBevel;
    imgExpanding: TImage;
    Image1: TImage;
    imgCardFraming: TImage;
    lblCardFraming: TLabel;
    PreviewPivotGrid: TcxPivotGrid;
    pgfPurchaseQuarter: TcxPivotGridField;
    pgfPurchaseMonth: TcxPivotGridField;
    pgfPaymentType: TcxPivotGridField;
    pgfQuantity: TcxPivotGridField;
    pgfCarName: TcxPivotGridField;
    pgfUnitPrice: TcxPivotGridField;
    pgfCompanyName: TcxPivotGridField;
    pgfPaymentAmount: TcxPivotGridField;
    lblPreviewWindow: TStaticText;
    chbxPrefilter: TCheckBox;
    chbxTransparentGraphics: TCheckBox;
    chbxDisplayGraphicsAsText: TCheckBox;
    chbxFlatCheckMarks: TCheckBox;
    bvlRefinementsSeparator: TBevel;
    procedure OptionsFormattingChanged(Sender: TObject);
    procedure btnStyleFontClick(Sender: TObject);
    procedure btnStyleColorClick(Sender: TObject);
    procedure btnStyleBackgroundBitmapClick(Sender: TObject);
    procedure btnStyleClearClick(Sender: TObject);
    procedure lblUseNativeStylesClick(Sender: TObject);
    procedure pmStylesPopup(Sender: TObject);
    procedure miStylesSelectAllClick(Sender: TObject);
    procedure btnStyleRestoreDefaultsClick(Sender: TObject);
    procedure btnStylesSaveAsClick(Sender: TObject);
    procedure btnStyleSheetNewClick(Sender: TObject);
    procedure btnStyleSheetCopyClick(Sender: TObject);
    procedure btnStyleSheetDeleteClick(Sender: TObject);
    procedure btnStyleSheetRenameClick(Sender: TObject);
    procedure cbxStyleSheetsClick(Sender: TObject);
    procedure cbxStyleSheetsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxStyleSheetsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbxLookAndFeelChange(Sender: TObject);
    procedure chbxExpandOptionsClick(Sender: TObject);
    procedure chbxOptionsViewClick(Sender: TObject);
  private
    function GetActiveStyle: TcxStyle;
    function GetHasSelectedStyles: Boolean;
    function GetHasSelectedStylesWithAssignedBitmap: Boolean;
    function GetReportLink: TcxPivotGridReportLink;
    procedure lbxStylesClick(Sender: TObject);
  protected
    lbxStyles: TdxStylesListBox;
    procedure CreateControls; virtual;
    function CanSelectAllStyles: Boolean;
    procedure DoInitialize; override;
    //
    procedure DoActiveStyleSheetChanged; override;
    procedure DoFormActivated(AnActive: Boolean); override;
    procedure DoRefreshStylesList; override;
    procedure DoStyleChanged(const ACaption: string; AStyle: TcxStyle); override;
    procedure DoStylesChanged(AStrings: TStrings; ARecreate: Boolean); override;

    procedure GetSelectedStyleNames(AStrings: TStrings); override;
    procedure GetStyleNames(out AStrings: TStrings); override;
    procedure GetStyleSheetNames(out AStrings: TStrings); override;
    procedure LoadCaption(AControl: TControl; StrPtr: Pointer); overload;
    procedure LoadCaption(AItem: TMenuItem; StrPtr: Pointer); overload;
    procedure LoadPreviewData;
    procedure LoadStrings; override;
    procedure LoadStringsCombo(ACombo: TComboBox; ACaptions: array of Pointer);

    procedure RecreateStylesListBox;
    procedure RestoreSelectedStyles(AList: TList);
    procedure SaveSelectedStyles(AList: TList);
    //
    procedure UpdateControlsState; override;
    procedure UpdateEnabled(AControl: TControl; AEnabled: Boolean); overload;
    procedure UpdateEnabled(AItem: TMenuItem; AEnabled: Boolean); overload;
    procedure UpdateEnabledControls(AControls: array of TControl; AEnabled: Boolean);
    procedure UpdatePreview; override;

    property ActiveStyle: TcxStyle read GetActiveStyle;
    property HasSelectedStyles: Boolean read GetHasSelectedStyles;
    property HasSelectedStylesWithAssignedBitmap: Boolean read GetHasSelectedStylesWithAssignedBitmap;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ReportLink: TcxPivotGridReportLink read GetReportLink;
  end;

implementation

uses Math, dxPSRes, dxPSPopupMan;

{$R *.dfm}
{$R dxPScxPivotGrid2Lnk.res}

type
  TControlAccess = class(TControl);
  TcxPivotGridAccess = class(TcxCustomPivotGrid);
  TcxPivotGridViewDataAccess = class(TcxPivotGridViewData);
  TcxPivotGridStylesAccess = class(TcxPivotGridStyles);
  
var
  FDefaultdxPScxPivotGridLinkStyleSheet: TcxPivotGridReportLinkStyleSheet;

//  
function DefaultdxPScxPivotGridLinkStyleSheet: TcxPivotGridReportLinkStyleSheet;

  function CreateStyle(AColor: TColor; AFontColor: TColor): TcxStyle;
  begin
    Result := TcxStyle.Create(DefaultdxPScxPivotGridLinkStyleSheet);
    with Result do
    begin
      Color := AColor;
      Font.Name := dxPSCore.dxPSDefaultFontName;
      Font.Color := AFontColor;
    end;
  end;

begin
  if FDefaultdxPScxPivotGridLinkStyleSheet = nil then
  begin
    FDefaultdxPScxPivotGridLinkStyleSheet := TcxPivotGridReportLinkStyleSheet.Create(nil);
    with FDefaultdxPScxPivotGridLinkStyleSheet.Styles as TcxPivotGridReportLinkStyles do
    begin
      ColumnHeader := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      FieldHeader := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      RowHeader := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      Content := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      HeaderBackground := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      Prefilter := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
    end;
  end;
  Result := FDefaultdxPScxPivotGridLinkStyleSheet;
end;

{  TcxPivotGridReportLinkOptionsExpanding }

procedure TcxPivotGridReportLinkOptionsExpanding.AssignToPivot(
  APivotGrid: TcxCustomPivotGrid);
begin
  TcxPivotGridViewDataAccess(APivotGrid.ViewData).
    ExpandColumns := AutoExpandColumns;
  TcxPivotGridViewDataAccess(APivotGrid.ViewData).
    ExpandRows := AutoExpandRows;
end;

function TcxPivotGridReportLinkOptionsExpanding.DesignerTabIndex: Integer;
begin
  Result := 1;
end;

procedure TcxPivotGridReportLinkOptionsExpanding.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridReportLinkOptionsExpanding then
    with TcxPivotGridReportLinkOptionsExpanding(Source) do
    begin
      Self.FAutoExpandColumns := FAutoExpandColumns;
      Self.FAutoExpandRows := FAutoExpandRows;
    end;
  inherited Assign(Source);
end;

procedure TcxPivotGridReportLinkOptionsExpanding.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAutoExpandColumns := False;
  FAutoExpandRows := False;
end;

procedure TcxPivotGridReportLinkOptionsExpanding.SetAutoExpandColumns(
  AValue: Boolean);
begin
  if FAutoExpandColumns <> AValue then
  begin
    FAutoExpandColumns := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridReportLinkOptionsExpanding.SetAutoExpandRows(
  AValue: Boolean);
begin
  if FAutoExpandRows <> AValue then
  begin
    FAutoExpandRows := AValue;
    Changed;
  end;
end;

{ TcxPivotGridReportLinkOptionsView }

procedure TcxPivotGridReportLinkOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridReportLinkOptionsView then
    with TcxPivotGridReportLinkOptionsView(Source) do
    begin
      Self.FColumnFields := FColumnFields;
      Self.FDataFields := FDataFields;
      self.FBorders := FBorders;
      Self.FExpandButtons := FExpandButtons;
      Self.FFilterFields := FFilterFields;
      Self.FGridLines := FGridLines;
      Self.FPrefilter := FPrefilter;
      Self.FRowFields := FRowFields;
    end;
  inherited Assign(Source);
end;

procedure TcxPivotGridReportLinkOptionsView.RestoreDefaults;
begin
  FColumnFields := True;
  FDataFields := True;
  FBorders := True;
  FExpandButtons := True;
  FFilterFields := False;
  FGridLines := pglBoth;
  FPrefilter := pfvAlways;
  FRowFields := True;
end;

procedure TcxPivotGridReportLinkOptionsView.AssignToPivot(
  APivotGrid: TcxCustomPivotGrid);
begin
  APivotGrid.OptionsView.ColumnFields := ColumnFields;
  APivotGrid.OptionsView.DataFields := DataFields;
  APivotGrid.OptionsView.FilterFields := FilterFields;
  APivotGrid.OptionsView.RowFields := RowFields;
  APivotGrid.OptionsView.GridLines := GridLines;
  APivotGrid.OptionsPrefilter.Visible := Prefilter;
  TcxPivotGridAccess(APivotGrid).ViewInfo.DrawBorders := Borders;
  TcxPivotGridAccess(APivotGrid).ViewInfo.DrawExpandButtons := ExpandButtons;
end;

procedure TcxPivotGridReportLinkOptionsView.SetBoolValue(
  var AField: Boolean; ANewValue: Boolean);
begin
  if AField <> ANewValue then
  begin
    AField := ANewValue;
    Changed;
  end;
end;

function TcxPivotGridReportLinkOptionsView.DesignerTabIndex: Integer;
begin
  Result := 0;
end;

procedure TcxPivotGridReportLinkOptionsView.SetBorders(AValue: Boolean);
begin
  if FBorders <> AValue then
  begin
    FBorders := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridReportLinkOptionsView.SetColumnFields(AValue: Boolean);
begin
  SetBoolValue(FColumnFields, AValue);
end;

procedure TcxPivotGridReportLinkOptionsView.SetDataFields(AValue: Boolean);
begin
  SetBoolValue(FDataFields, AValue);
end;

procedure TcxPivotGridReportLinkOptionsView.SetExpandButtons(AValue: Boolean);
begin
  SetBoolValue(FExpandButtons, AValue);
end;

procedure TcxPivotGridReportLinkOptionsView.SetFilterFields(AValue: Boolean);
begin
  SetBoolValue(FFilterFields, AValue);
end;

procedure TcxPivotGridReportLinkOptionsView.SetGridLines(
  AValue: TcxPivotGridLines);
begin
  if FGridLines <> AValue then
  begin
    FGridLines := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridReportLinkOptionsView.SetPrefilter(AValue: TcxPivotGridPrefilterVisible);
begin
  if FPrefilter <> AValue then
  begin
    FPrefilter := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridReportLinkOptionsView.SetRowFields(AValue: Boolean);
begin
  SetBoolValue(FRowFields, AValue);
end;

{ TcxPivotGridReportLinkStyles }

constructor TcxPivotGridReportLinkStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  BitmapInViewParams := True;
end;

procedure TcxPivotGridReportLinkStyles.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxPivotGridReportLinkStyles then
    with TcxPivotGridReportLinkStyles(Source) do
    begin
      Self.ColumnHeader := ColumnHeader;
      Self.Content := Content;
      Self.FieldHeader := FieldHeader;
      Self.HeaderBackground := HeaderBackground;
      Self.Prefilter := Prefilter;
      Self.RowHeader := RowHeader;
    end;
end;

function TcxPivotGridReportLinkStyles.GetColumnHeaderParams(
  AColumn: TcxPivotGridViewDataItem): TcxViewParams;
begin
  if UsePivotStyles then
  else
  GetViewParams(vspsPGridColumnHeader, AColumn, nil, Result);
end;

function TcxPivotGridReportLinkStyles.GetContentParams(
  ACell: TcxPivotGridDataCellViewInfo): TcxViewParams;
begin
  GetViewParams(vspsPGridContent, ACell, nil, Result);
end;

function TcxPivotGridReportLinkStyles.GetFieldHeaderParams(
  AField: TcxPivotGridField): TcxViewParams;
begin
  GetViewParams(vspsPGridFieldHeader, AField, nil, Result);
end;

function TcxPivotGridReportLinkStyles.GetHeaderBackgroundParams(
  AArea: TcxPivotGridFieldArea): TcxViewParams;
begin
  GetViewParams(vspsPGridHeaderBackground, nil, nil, Result);
end;

function TcxPivotGridReportLinkStyles.GetPrefilterParams: TcxViewParams;
begin
  GetViewParams(vspsPGridPrefilter, nil, nil, Result);
end;

function TcxPivotGridReportLinkStyles.GetRowHeaderParams(
  ARow: TcxPivotGridViewDataItem): TcxViewParams;
begin
  GetViewParams(vspsPGridRowHeader, ARow, nil, Result);
end;

procedure TcxPivotGridReportLinkStyles.AssignToPivot(
  AFromGrid, ADestGrid: TcxCustomPivotGrid; AUsePivotStyles: Boolean);
begin
  if (ADestGrid = nil) or (AFromGrid = nil) then Exit; 
  if AUsePivotStyles then
    ADestGrid.Styles.Assign(AFromGrid.Styles)
  else
  begin
    ADestGrid.Styles.ColumnHeader := ColumnHeader;
    ADestGrid.Styles.Content := Content;
    ADestGrid.Styles.FieldHeader := FieldHeader;
    ADestGrid.Styles.HeaderBackground := HeaderBackground;
    ADestGrid.Styles.Prefilter := Prefilter;
    ADestGrid.Styles.RowHeader := RowHeader;
  end;
end;

function TcxPivotGridReportLinkStyles.DesignerTabIndex: Integer;
begin
  Result := 3;
end;

procedure TcxPivotGridReportLinkStyles.GetDefaultViewParams(
  Index: Integer; AData: TObject; out AParams: TcxViewParams);
begin
  inherited GetDefaultViewParams(Index, AData, AParams);
  if ReportLink <> nil then
  begin
    if Index in [vspsPGridColumnHeader, vspsPGridFieldHeader, vspsPGridRowHeader] then
      AParams.Color := dxPSCore.dxDefaultFixedColor
    else
      AParams.Color := dxDefaultContentColor;
    AParams.Font := ReportLink.Font;
    AParams.TextColor := AParams.Font.Color;
  end;
end;

class function TcxPivotGridReportLinkStyles.GetStyleCaption(
  AnIndex: Integer): string;
begin
  case AnIndex of
    vspsPGridColumnHeader:
      Result := cxGetResourceString(@sdxPivotGridColumnHeader);
    vspsPGridContent:
      Result := cxGetResourceString(@sdxPivotGridContent);
    vspsPGridFieldHeader:
      Result := cxGetResourceString(@sdxPivotGridFieldHeader);
    vspsPGridHeaderBackground:
      Result := cxGetResourceString(@sdxPivotGridHeaderBackground);
    vspsPGridPrefilter:
      Result := cxGetResourceString(@sdxPivotGridPrefilter);
  else
    Result := cxGetResourceString(@sdxPivotGridRowHeader);
  end; 
end;

function TcxPivotGridReportLinkStyles.GetStyleIndexByCaption(
  const Caption: string): Integer;
begin
  for Result := vspsPGridFirst to vspsPGridLast do
    if dxPSUtl.dxSameText(Caption, GetStyleCaption(Result)) then
      Exit;
  Result := -1;
end;

function TcxPivotGridReportLinkStyles.UsePivotStyles: Boolean;
begin
  if ReportLink = nil then
  begin
    Result := False;
    Exit;
  end;
  Result := not ReportLink.OptionsFormatting.UseNativeStyles;
  if not Result then
    Result := (ReportLink = nil) or (ReportLink.PivotGrid = nil);
end;

function TcxPivotGridReportLinkStyles.GetReportLink: TcxPivotGridReportLink;
begin
  if Owner is TcxPivotGridReportLink then
    Result := Owner as TcxPivotGridReportLink
  else
    Result := nil;
end;

{ TcxPivotGridReportLinkOptionsFormatting }

procedure TcxPivotGridReportLinkOptionsFormatting.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridReportLinkOptionsFormatting then
    SuppressContentColoration := TcxPivotGridReportLinkOptionsFormatting(Source).SuppressContentColoration;
  inherited Assign(Source);
end;

procedure TcxPivotGridReportLinkOptionsFormatting.RestoreDefaults;
begin
  inherited RestoreDefaults;
  SuppressContentColoration := False; 
end;

procedure TcxPivotGridReportLinkOptionsFormatting.AssignToPivot(
  APivotGrid: TcxCustomPivotGrid);
begin
  APivotGrid.LookAndFeel.Kind := LookAndFeelKind;
  APivotGrid.LookAndFeel.NativeStyle := False;
  with TcxPivotGridStylesAccess(APivotGrid.Styles) do
  begin
    SuppressContentColoration := Self.SuppressContentColoration;
    SuppressBackgroundBitmaps := Self.SuppressBackgroundBitmaps;
  end;
end;

function TcxPivotGridReportLinkOptionsFormatting.DesignerTabIndex: Integer;
begin
  Result := 2;
end;

procedure TcxPivotGridReportLinkOptionsFormatting.SetSuppressContentColoration(
  AValue: Boolean);
begin
  if FSuppressContentColoration <> AValue then
  begin
    FSuppressContentColoration := AValue;
    Changed;
  end;
end;

{ TcxPivotGridReportLinkStyleSheet }
  
class function TcxPivotGridReportLinkStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxPivotGridReportLinkStyles;
end;

function TcxPivotGridReportLinkStyleSheet.GetStylesValue: TcxPivotGridReportLinkStyles;
begin
  Result := TcxPivotGridReportLinkStyles(GetStyles);
end;

procedure TcxPivotGridReportLinkStyleSheet.SetStylesValue(
  AValue: TcxPivotGridReportLinkStyles);
begin
  Styles.Assign(AValue);
end;

{ TcxPivotGridReportLink }

constructor TcxPivotGridReportLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLookAndFeelItems := TList.Create;
end;

destructor TcxPivotGridReportLink.Destroy;
begin
  FreeAndNil(FLookAndFeelItems);
  inherited Destroy;
end;

procedure TcxPivotGridReportLink.BuildReport;
var
  AController: TcxPivotGridExportController;
begin
  LookAndFeelItems.Clear;
  FHostCell := TdxReportCell.Create(ReportCells.Cells);
  FHostCell.BoundsRect := MakeBounds(0, 0, PageWidth, PageHeight);
  FHostCell.CellSides := [];
  FHostCell.Transparent := True;
  FHostCell.Visible := True;
  AController := TcxPivotGridExportController.Create(PivotGrid);
  try
    AController.ViewInfo.DrawBorders := OptionsView.Borders;
    AController.ViewInfo.DrawExpandButtons := OptionsView.ExpandButtons;
    InitializeOptionsBeforeBuildReport(AController);
    ProcessCreateReportItems(AController.CalculateViewInfo);
  finally
    AController.Free;
  end;
end;

procedure TcxPivotGridReportLink.ConstructReport(AReportCells: TdxReportCells);

  procedure CalculateSizes;

    procedure CalculateReportPartSizes(ACell: TdxReportCell);
    var
      ARight, ABottom, I: Integer;
    begin
      if ACell.CellCount > 0 then
      begin
        ARight := 0;
        ABottom := 0; 
        for I := 0 to ACell.CellCount - 1 do
          with ACell.Cells[I] do
          begin
            ARight := Max(ARight,  Left + Width);
            ABottom := Max(ABottom, Top + Height);
          end;
        ACell.BoundsRect := Rect(0, 0, ARight, ABottom);
      end;
    end;

  begin
    with AReportCells do
    begin
      CalculateReportPartSizes(HostCell);
      if AreFooterCellsAllocated then
        CalculateReportPartSizes(FooterCells);
      if AreHeaderCellsAllocated then
        CalculateReportPartSizes(HeaderCells);
      CalculateReportPartSizes(Cells);
    end;
  end;

begin
  if PivotGrid = nil then Exit;
  inherited ConstructReport(AReportCells) ;
  PrepareConstruct;
  try
    BuildReport;
    if not AbortBuilding then CalculateSizes;
  finally
    UnprepareConstruct;
  end;
end;

procedure TcxPivotGridReportLink.ConvertCoords;
begin
  inherited ConvertCoords;
end;

procedure TcxPivotGridReportLink.CustomDraw(AItem: TAbstractdxReportCellData;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var ADone: Boolean);
begin
  case AItem.Data of
    cxPivotGridDataCellID:
     if AItem.ClassType = TdxReportCellString then
        DoCustomDrawDataCell(ACanvas, TdxReportCellString(AItem), ADone);
    cxPivotGridFieldHeaderCellID:
      DoCustomDrawFieldHeaderCell(ACanvas, AItem.Parent, ADone);
    cxPivotGridGroupHeaderCellID:
      DoCustomDrawGroupHeaderCell(ACanvas, AItem.Parent, ADone);
    cxPivotGridHeaderBackgroundID:
      DoCustomDrawHeaderBackground(ACanvas, AItem.Parent, ADone);
    cxPivotGridPrefilterID:
      DoCustomDrawPrefilter(ACanvas, TdxReportCellString(AItem), ADone);
  end;
end;

procedure TcxPivotGridReportLink.DoCustomDrawDataCell(ACanvas: TCanvas;
  AItem: TAbstractdxReportCellData; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawDataCell) then
    FOnCustomDrawDataCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxPivotGridReportLink.DoCustomDrawFieldHeaderCell(ACanvas: TCanvas;
  AItem: TdxReportCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawFieldHeaderCell) then
    FOnCustomDrawFieldHeaderCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxPivotGridReportLink.DoCustomDrawGroupHeaderCell(ACanvas: TCanvas;
  AItem: TdxReportCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawGroupHeaderCell) then
    FOnCustomDrawGroupHeaderCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxPivotGridReportLink.DoCustomDrawHeaderBackground(ACanvas: TCanvas;
  AItem: TdxReportCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawHeaderBackground) then
    FOnCustomDrawHeaderBackground(Self, ACanvas, AItem, ADone);
end;

procedure TcxPivotGridReportLink.DoCustomDrawPrefilter(ACanvas: TCanvas; AItem: TdxReportCellString; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawPrefilter) then
    FOnCustomDrawPrefilter(Self, ACanvas, AItem, ADone);
end;

procedure TcxPivotGridReportLink.DoInitializeDataCell(
  AItem: TAbstractdxReportCellData; ACell: TcxPivotGridDataCellViewInfo);
begin
  if Assigned(FOnInitializeDataCell) then
    FOnInitializeDataCell(Self, ACell, AItem);
end;

procedure TcxPivotGridReportLink.DoInitializeFieldHeaderCell(
  AItem: TdxReportCell; ACell: TcxPivotGridFieldHeaderCellViewInfo);
begin
  if Assigned(FOnInitializeFieldHeaderCell) then
    FOnInitializeFieldHeaderCell(Self, ACell, AItem);
end;

procedure TcxPivotGridReportLink.DoInitializeGroupHeaderCell(
  AItem: TdxReportCell; ACell: TcxPivotGridHeaderCellViewInfo);
begin
  if Assigned(FOnInitializeGroupHeaderCell) then
    FOnInitializeGroupHeaderCell(Self, ACell, AItem);
end;

procedure TcxPivotGridReportLink.DoInitializeHeaderBackground(AItem: TdxReportCell; ACell: TcxPivotGridHeaderBackgroundCellViewInfo);
begin
  if Assigned(FOnInitializeHeaderBackground) then
    FOnInitializeHeaderBackground(Self, ACell, AItem);
end;

procedure TcxPivotGridReportLink.DoInitializePrefilter(AItem: TdxReportCellString;
  ACell: TcxPivotGridPrefilterViewInfo);
begin
  if Assigned(FOnInitializePrefilter) then
    FOnInitializePrefilter(Self, ACell, AItem);
end;

function TcxPivotGridReportLink.IdxPSCellParams_GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxPivotGridReportLink.IdxPSCellParams_GetDC: HDC;
begin
  Result := ScreenDC;
end;

function TcxPivotGridReportLink.IdxPSCellParams_GetDisplayGraphicsAsText: Boolean;
begin
  Result := OptionsRefinements.DisplayGraphicsAsText;
end;

function TcxPivotGridReportLink.IdxPSCellParams_GetEndEllipsis: Boolean;
begin
  Result := False;
end;

function TcxPivotGridReportLink.IdxPSCellParams_GetFlatCheckMarks: Boolean;
begin
  Result := OptionsRefinements.FlatCheckMarks;
end;

function TcxPivotGridReportLink.IdxPSCellParams_GetGraphicsText: string;
begin
  Result := OptionsRefinements.GraphicsText;
end;

function TcxPivotGridReportLink.IdxPSCellParams_GetMultiline: Boolean;
begin
  Result := False;
end;

function TcxPivotGridReportLink.IdxPSCellParams_GetTransparentGraphics: Boolean; 
begin
  Result := OptionsRefinements.TransparentGraphics;
end;

procedure TcxPivotGridReportLink.GetImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited GetImageLists(AProc);
  AProc(PivotGrid.FieldHeaderImages);
  AProc(PivotGrid.GroupHeaderImages);
end;

procedure TcxPivotGridReportLink.AddDataCell(
  ACell: TcxPivotGridDataCellViewInfo);
var
  APSCell: TAbstractdxReportCellData;
  AViewParams: TdxReportItemViewParams;
begin
  if ACell.Properties <> nil then
  begin
    APSCell := HostCell.AddDataItem(dxPSDataMaps.ItemClass(ACell.Properties, False));
    dxPScxCommon.dxPSDataMaps.InitializeItem(APSCell, ACell.Properties,
      ACell.Value, Self, AViewParams);
  end
  else
  begin
    APSCell := HostCell.AddDataItem(TdxReportCellString);
    TdxReportCellString(APSCell).TextAlignX := TextAlignXMap[ACell.Align];
    TdxReportCellString(APSCell).Text := ACell.DisplayText;
    APSCell.Color := ACell.Color;
    APSCell.CellSides := TdxCellSides(ACell.Borders);
  end;
  APSCell.BoundsRect := ACell.Bounds;
  SetCellViewParams(APSCell, ACell.ViewParams);
  APSCell.Data := cxPivotGridDataCellID;
  DoInitializeDataCell(APSCell, ACell);
end;

procedure TcxPivotGridReportLink.AddFieldHeaderCell(
  ACell: TcxPivotGridFieldHeaderCellViewInfo);
begin
  DoInitializeFieldHeaderCell(CreateHeaderCell(
    ACell, cxPivotGridFieldHeaderCellID), ACell);
end;

procedure TcxPivotGridReportLink.AddHeaderBackground(ACell: TcxPivotGridHeaderBackgroundCellViewInfo);
var
  ABackgroundCell: TdxReportCell;
begin
  ABackgroundCell := HostCell.AddCell;
  ABackgroundCell.BoundsRect := ACell.Bounds;
  ABackgroundCell.CellSides := [];
  ABackgroundCell.Color := ACell.Color;
  SetCellViewParams(ABackgroundCell, ACell.ViewParams);
  ABackgroundCell.Data := cxPivotGridHeaderBackgroundID;
  DoInitializeHeaderBackground(ABackgroundCell, ACell);
end;

procedure TcxPivotGridReportLink.AddHeaderCell(
  ACell: TcxPivotGridHeaderCellViewInfo);
var
  AItem: TdxReportCell;
begin
  AItem := CreateHeaderCell(ACell, cxPivotGridGroupHeaderCellID);
  AddHorizontalDelimiter(AItem);
  AddVerticalDelimiter(AItem);
  DoInitializeGroupHeaderCell(AItem, ACell);
end;

procedure TcxPivotGridReportLink.AddPrefilter(ACell: TcxPivotGridPrefilterViewInfo);
const
  APSCellClass: array [Boolean] of TdxReportCellStringClass =
    (TdxReportCellCheck, TdxReportCellString);
var
  APrefilterCell: TdxReportCell;
  APSCell: TdxReportCellString;
begin
  APrefilterCell := HostCell.AddCell;
  APrefilterCell.BoundsRect := ACell.Bounds;
  APrefilterCell.CellSides := [];
  APSCell := APrefilterCell.AddDataItem(APSCellClass[ACell.Prefilter.Filter.IsEmpty]) as APSCellClass[ACell.Prefilter.Filter.IsEmpty];
  APSCell.BoundsRect := MakeRect(0, 0, APrefilterCell.Width, APrefilterCell.Height);
  APSCell.Text := ACell.DisplayText;
  APSCell.Color := ACell.Color;
  APSCell.CellSides := [];
  SetCellViewParams(APSCell, ACell.ViewParams);
  APSCell.Data := cxPivotGridPrefilterID;
  APSCell.EndEllipsis := True;
  if APSCell is TdxReportCellCheck then
  begin
    TdxReportCellCheck(APSCell).Checked := ACell.Prefilter.Filter.Active;
    TdxReportCellCheck(APSCell).CheckPos := ccpLeft;
  end;
  DoInitializePrefilter(APSCell, ACell);
end;

function TcxPivotGridReportLink.CreateHeaderCell(
  ACell: TcxPivotGridHeaderCellViewInfo; AttributeID: Integer): TdxReportCell;
var
  R: TRect;
  APSCell: TAbstractdxReportCellData;
  AIndent: TdxReportCellString;
  AButton: TdxReportCellExpandButton;
  AViewParams: TdxReportItemViewParams;
const
  AImageLayout: array[TcxAlignmentVert, TAlignment] of TdxImageLayout =
  ((ilImageTopLeft, ilImageTopRight, ilImageTopCenter),
   (ilImageBottomLeft, ilImageBottomRight, ilImageBottomCenter),
   (ilImageCenterLeft, ilImageCenterRight, ilImageCenterCenter));

begin
  Result := HostCell.AddCell;
  Result.BoundsRect := ACell.Bounds;
  Result.CellSides := [];
  if ACell.Properties <> nil then
  begin
    APSCell := Result.AddDataItem(dxPSDataMaps.ItemClass(ACell.Properties, False));
    dxPScxCommon.dxPSDataMaps.InitializeItem(APSCell, ACell.Properties,
      ACell.Value, Self, AViewParams);
  end
  else
  begin
    APSCell := Result.AddDataItem(TdxReportCellImage);
    with TdxReportCellImage(APSCell) do
    begin
      TextAlignX := TextAlignXMap[ACell.AlignHorz];
      TextAlignY := TextAlignYMap[ACell.AlignVert];
      Text := ACell.DisplayText;
      Color := ACell.Color;
      SortOrder := TdxCellSortOrder(ACell.SortOrder);
      EndEllipsis := ACell.ShowEndEllipsis;
      Multiline := ACell.MultiLine;
      ImageIndex := ACell.ImageIndex;
      if ImageIndex <> -1 then
        ImageList := ACell.Images;
      ImageLayout := AImageLayout[ACell.ImageAlignVert, ACell.ImageAlignHorz];
      IsTextDrawnForCenteredImage := True;
      CellSides := csAll;
    end
  end;
  APSCell.BoundsRect := MakeRect(0, 0, Result.Width, Result.Height);
  if ACell.HasButton and OptionsView.ExpandButtons and (ACell.Bounds.Right > ACell.ButtonRect.Right) then
  begin
    AButton := Result.AddDataItem(TdxReportCellExpandButton) as TdxReportCellExpandButton;
    R := ACell.ButtonRect;
    OffsetRect(R, -ACell.Bounds.Left, -ACell.Bounds.Top);
    AButton.BoundsRect := R;
    AButton.CellSides := [];
    AIndent := Result.AddDataItem(TdxReportCellString) as TdxReportCellString;
    AIndent.BoundsRect := MakeRect(0, 0, AButton.Left + AButton.Width + cxTextOffset,
      Result.Height);
    AIndent.CellSides := [csLeft, csTop, csBottom];
    APSCell.CellSides := APSCell.CellSides - [csLeft];
    AButton.ButtonExpanded := ACell.Expanded;
    AButton.ShowButtonBorder := True;
    AButton.ShowButton := True;
    AButton.ButtonBorder3D := Effects3D;
    AButton.ButtonBorder3DSoft := Soft3D;
    APSCell.Left := AIndent.Left + AIndent.Width;
    APSCell.Width := APSCell.Width - APSCell.Left;
    SetCellViewParams(AButton, ACell.ViewParams);
    SetCellViewParams(AIndent, ACell.ViewParams);
    RegisterLookAndFeelItem(AIndent, cesRaised);
  end;
  APSCell.Data := AttributeID;
  SetCellViewParams(APSCell, ACell.ViewParams);
  RegisterLookAndFeelItem(APSCell, cesRaised);
end;

procedure TcxPivotGridReportLink.InitializeOptionsBeforeBuildReport(
  AController: TcxPivotGridExportController);
begin
  AController.ExpandColumns := OptionsExpanding.AutoExpandColumns;
  AController.ExpandRows := OptionsExpanding.AutoExpandRows;
  if OptionsFormatting.UseNativeStyles then
    AController.ReplaceStyles(ActiveStyles);
  with AController.OptionsView do
  begin
    ColumnFields := Self.OptionsView.ColumnFields;
    DataFields := Self.OptionsView.DataFields;
    FilterFields := Self.OptionsView.FilterFields;
    GridLines := Self.OptionsView.GridLines;
    RowFields := Self.OptionsView.RowFields;
  end;
  AController.PivotGrid.OptionsPrefilter.Visible := Self.OptionsView.Prefilter;
end;

procedure TcxPivotGridReportLink.ProcessCreateReportItems(
  AViewInfo: TcxPivotGridViewInfo);
var
  I, AStart, ACount: Integer;
begin
  with AViewInfo do
  begin
    AStart := 0;
    ACount := RowHeaders.Count + ColumnHeaders.Count +
      FieldHeaders.Count + DataCells.Count;
    for I := 0 to CommonCells.Count - 1 do
      if (CommonCells[I] is TcxPivotGridHeaderBackgroundCellViewInfo) then
        AddHeaderBackground(TcxPivotGridHeaderBackgroundCellViewInfo(CommonCells[I]));
    for I := 0 to RowHeaders.Count - 1 do
    begin
      AddHeaderCell(TcxPivotGridHeaderCellViewInfo(RowHeaders[I]));
      DoProgress(100 * (AStart + I + 1) / ACount);
    end;
    Inc(AStart, RowHeaders.Count);
    for I := 0 to ColumnHeaders.Count - 1 do
    begin
      AddHeaderCell(TcxPivotGridHeaderCellViewInfo(ColumnHeaders[I]));
      DoProgress(100 * (AStart + I + 1) / ACount);
    end;
    Inc(AStart, ColumnHeaders.Count);
    for I := 0 to FieldHeaders.Count - 1 do
    begin
      AddFieldHeaderCell(TcxPivotGridFieldHeaderCellViewInfo(FieldHeaders[I]));
      DoProgress(100 * (AStart + I + 1) / ACount);
    end;
    Inc(AStart, FieldHeaders.Count);
    for I := 0 to DataCells.Count - 1 do
    begin
      AddDataCell(TcxPivotGridDataCellViewInfo(DataCells[I]));
      DoProgress(100 * (AStart + I + 1) / ACount);
    end;
    if Prefilter.Visible then
      AddPrefilter(Prefilter.ViewInfo);
  end;
end;

procedure TcxPivotGridReportLink.RegisterLookAndFeelItem(
  AItem: TdxReportVisualItem; AEdgeStyle: TdxCellEdgeStyle);
begin
  AItem.EdgeMode := GetEdgeMode;
  AItem.Edge3DStyle := AEdgeStyle;
  FLookAndFeelItems.Add(AItem);
end;

procedure TcxPivotGridReportLink.SetCellViewParams(
  ACell: TdxReportVisualItem; const AParams: TcxViewParams);
var
  AdxPSViewParams: TdxReportItemViewParams;
begin
  if not Assigned(ACell) then Exit;
  FillChar(AdxPSViewParams, SizeOf(AdxPSViewParams), 0);
  AdxPSViewParams.NativeParams := AParams;
  SetCellViewParamsEx(ACell, AdxPSViewParams);
end;

procedure TcxPivotGridReportLink.SetCellViewParamsEx(
  ACell: TdxReportVisualItem; const AParams: TdxReportItemViewParams);
var
  AFont: TFont;
  AHasBitmap: Boolean;
begin
  if not Assigned(ACell) then Exit;
  AFont := TFont.Create;
  try
    AFont.Assign(AParams.NativeParams.Font);
    if not dxPSUtl.dxIsTrueTypeFont(AFont) then
      AFont.Name := Font.Name;
    AFont.Color := ColorToRGB(AParams.NativeParams.TextColor);
    if AParams.FontSize <> 0 then
      AFont.Size := AParams.FontSize;
    AFont.Style := AFont.Style + AParams.FontStyle;
    ACell.FontIndex := AddFontToPool(AFont);
    ACell.Transparent := OptionsFormatting.SuppressContentColoration or AParams.Transparent;
    with AParams.NativeParams do
    begin
      AHasBitmap := not OptionsFormatting.SuppressBackgroundBitmaps and
        (Bitmap <> nil) and not Bitmap.Empty;
      if AHasBitmap then
        ACell.BackgroundBitmapIndex := AddBackgroundBitmapToPool(Bitmap);
    end;
    ACell.Color := ColorToRGB(AParams.NativeParams.Color);
  finally
    AFont.Free;
  end;
end;

procedure TcxPivotGridReportLink.InternalRestoreFromOriginal;
begin
  inherited InternalRestoreFromOriginal;
  if PivotGrid <> nil then
  begin
    OptionsFormatting.LookAndFeelKind := PivotGrid.LookAndFeel.Kind;
    // optionsview todo:
  end;
end;

function TcxPivotGridReportLink.IsSupportedCustomDraw(
  Item: TAbstractdxReportCellData): Boolean;
begin
  Result := (Item <> nil) and inherited IsSupportedCustomDraw(Item);
end;

function TcxPivotGridReportLink.GetEdgeMode: TdxCellEdgeMode;
const
  EdgeModeMap: array[Boolean] of TdxCellEdgeMode = (cemPattern, cem3DEffects);
begin
  Result := EdgeModeMap[OptionsFormatting.LookAndFeelKind <> lfUltraFlat];
end;

function TcxPivotGridReportLink.GetOptionsExpandingClass: TdxCustomReportLinkOptionsExpandingClass;
begin
  Result := TcxPivotGridReportLinkOptionsExpanding;
end;

function TcxPivotGridReportLink.GetOptionsFormattingClass: TdxCustomReportLinkOptionsFormattingClass; 
begin
  Result := TcxPivotGridReportLinkOptionsFormatting;
end;

function TcxPivotGridReportLink.GetOptionsViewClass: TdxCustomReportLinkOptionsViewClass;
begin
  Result := TcxPivotGridReportLinkOptionsView;
end;

function TcxPivotGridReportLink.GetAreNativeStylesAvailable: Boolean; 
begin
  Result := OptionsFormatting.UseNativeStyles;
end;

function TcxPivotGridReportLink.GetStylesClass: TdxCustomReportLinkStylesClass; 
begin
  Result := TcxPivotGridReportLinkStyles;
end;

function TcxPivotGridReportLink.GetStyleSheetClass: TdxCustomReportLinkStyleSheetClass;
begin
  Result := TcxPivotGridReportLinkStyleSheet;
end;

function TcxPivotGridReportLink.GetStyleSheetPrototype: TdxCustomReportLinkStyleSheet; 
begin
  Result := DefaultdxPScxPivotGridLinkStyleSheet;
end;

procedure TcxPivotGridReportLink.PrepareConstruct;
begin
  inherited;
  ReportCells.LookAndFeel := nil;
end;

procedure TcxPivotGridReportLink.UnprepareConstruct;
begin
  ReportCells.BorderColor := GridLineColor;
  FormatLookAndFeelItems;
  inherited UnprepareConstruct;
end;

procedure TcxPivotGridReportLink.FormatLookAndFeelItems;
const
  Borders3D: array[TdxCellEdgeStyle, Boolean] of TdxPSCellBorderClass = 
   ((TdxPSCellRaisedBorder, TdxPSCellRaisedSoftBorder), 
    (TdxPSCellSunkenBorder, TdxPSCellSunkenSoftBorder));
var
  I: Integer;
begin
  for I := 0 to LookAndFeelItems.Count - 1 do
    with TdxReportVisualItem(LookAndFeelItems[I]) do
      if Effects3D then
        BorderClass := Borders3D[Edge3DStyle, Soft3D]
      else
        BorderClass := TdxPSCellUltraFlatBorder;
end;

function TcxPivotGridReportLink.GetActiveStyles: TcxPivotGridReportLinkStyles;
begin
  Result := inherited ActiveStyles as TcxPivotGridReportLinkStyles;
end;

function TcxPivotGridReportLink.GetDesignWindow: TcxfmPivotGridReportLinkDesignWindow;
begin
  Result := inherited DesignWindow as TcxfmPivotGridReportLinkDesignWindow;
end;

function TcxPivotGridReportLink.GetGridLineColor: TColor;
begin
  Result := OptionsFormatting.GridLineColor;
  if (Result = clDefault) and (PivotGrid <> nil) then
    Result := PivotGrid.LookAndFeelPainter.DefaultGridLineColor;
end;

function TcxPivotGridReportLink.GetOptionsExpanding: TcxPivotGridReportLinkOptionsExpanding;
begin
  Result := inherited OptionsExpanding as TcxPivotGridReportLinkOptionsExpanding;
end;

function TcxPivotGridReportLink.GetOptionsFormatting: TcxPivotGridReportLinkOptionsFormatting;
begin
  Result := inherited OptionsFormatting as TcxPivotGridReportLinkOptionsFormatting; 
end;

function TcxPivotGridReportLink.GetOptionsView: TcxPivotGridReportLinkOptionsView;
begin
  Result := inherited OptionsView as TcxPivotGridReportLinkOptionsView;
end;

function TcxPivotGridReportLink.GetStyles: TcxPivotGridReportLinkStyles;
begin
  Result := inherited Styles as TcxPivotGridReportLinkStyles;
end;

function TcxPivotGridReportLink.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := TcxCustomPivotGrid(Component);
end;

procedure TcxPivotGridReportLink.SetOptionsExpanding(
  AValue: TcxPivotGridReportLinkOptionsExpanding);
begin
  OptionsExpanding.Assign(AValue);
end;

procedure TcxPivotGridReportLink.SetOptionsFormatting(
  AValue: TcxPivotGridReportLinkOptionsFormatting);
begin
  OptionsFormatting.Assign(AValue);
end;

procedure TcxPivotGridReportLink.SetOptionsView(
  AValue: TcxPivotGridReportLinkOptionsView);
begin
  OptionsView.Assign(AValue)
end;

procedure TcxPivotGridReportLink.SetStyles(
  AValue: TcxPivotGridReportLinkStyles);
begin
  Styles.Assign(AValue)
end;

{ TcxfmPivotGridReportLinkDesignWindow }

constructor TcxfmPivotGridReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhccxPivotGridReportLinkDesigner;
  inherited Create(AOwner);
  CreateControls;
  LoadPreviewData;
end;

destructor TcxfmPivotGridReportLinkDesignWindow.Destroy;
begin
  dxPSPopupMan.dxPSPopupMenuController.UnregisterControl(lbxStyles);
  inherited Destroy;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.CreateControls;

  procedure CreateStylesListBox;
  begin
    lbxStyles := TdxStylesListBox.Create(Self);
    lbxStyles.Parent := tshStyles;
    lbxStyles.BoundsRect := bvlStylesHost.BoundsRect;
    lbxStyles.PopupMenu := pmStyles;
    lbxStyles.TabOrder := chbxUseNativeStyles.TabOrder + 1;
    lbxStyles.OnClick := lbxStylesClick;
    bvlStylesHost.Visible := False;

    dxPSPopupMan.dxPSPopupMenuController.RegisterControl(lbxStyles);
  end;

begin
  CreateStylesListBox;
end;

function TcxfmPivotGridReportLinkDesignWindow.CanSelectAllStyles: Boolean;
var
  I: Integer;
begin
  Result := AreNativeStylesAvailable;
  if Result then
  begin
    for I := 0 to lbxStyles.Items.Count - 1 do
      if not lbxStyles.Selected[I] then Exit;
    Result := False;
  end;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.DoInitialize;
begin
  lbxStyles.ReportLinkStyles := ReportLink.ActiveStyles;
  inherited DoInitialize;
  BeginUpdateControls;
  // view
  with ReportLink.OptionsView do
  begin
    chbxColumnFields.Checked := ColumnFields;
    chbxDataFields.Checked := DataFields;
    chbxFilterFields.Checked := FilterFields;
    chbxPrefilter.Checked := Prefilter = pfvAlways;
    chbxRowFields.Checked := RowFields;
    chbxBorders.Checked := Borders;
    chbxShowExpandButtons.Checked := ExpandButtons;
    chbxHorizontalLines.Checked := GridLines in [pglBoth, pglHorz];
    chbxVerticalLines.Checked := GridLines in [pglBoth, pglVert];;
  end;
  // behavior
  chbxExpandColumns.Checked := ReportLink.OptionsExpanding.AutoExpandColumns;
  chbxExpandRows.Checked := ReportLink.OptionsExpanding.AutoExpandRows;
  // formatting
  with ReportLink.OptionsFormatting do
  begin
    chbxSuppressBackgroundBitmaps.Checked := SuppressBackgroundBitmaps;
    chbxSuppressContentColoration.Checked := SuppressContentColoration;
    chbxUseNativeStyles.Checked := UseNativeStyles;
  end;
  with ReportLink.OptionsRefinements do
  begin
    chbxTransparentGraphics.Checked := TransparentGraphics;
    chbxDisplayGraphicsAsText.Checked := DisplayGraphicsAsText;
    chbxFlatCheckMarks.Checked := FlatCheckMarks;
  end;
  EndUpdateControls;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.RecreateStylesListBox;
var
  List: TList;
begin
  List := TList.Create;
  try
    SaveSelectedStyles(List);
    dxPSUtl.dxRecreateWnd(lbxStyles);
    RestoreSelectedStyles(List);
  finally
    List.Free;
  end;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.RestoreSelectedStyles(
  AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    lbxStyles.Selected[Integer(AList[I])] := True;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.SaveSelectedStyles(
  AList: TList);
var
  I: Integer;
begin
  AList.Clear;
  for I := 0 to lbxStyles.Items.Count - 1 do
    if lbxStyles.Selected[I] then AList.Add(TObject(I));
end;

procedure TcxfmPivotGridReportLinkDesignWindow.UpdateControlsState;
begin
  inherited UpdateControlsState;

  UpdateEnabled(lbxStyles, AreNativeStylesAvailable);
  UpdateEnabled(btnStyleColor, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(btnStyleFont,  AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(btnStyleBackgroundBitmap, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(btnStyleBackgroundBitmapClear, AreNativeStylesAvailable and HasSelectedStylesWithAssignedBitmap);
  UpdateEnabled(btnStyleRestoreDefaults, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(btnStylesSaveAs, CanSaveStyles);

  UpdateEnabled(lblStyleSheets, AreNativeStylesAvailable);
  UpdateEnabled(cbxStyleSheets, AreNativeStylesAvailable);
  UpdateEnabled(btnStyleSheetNew, CanCreateStyleSheet);
  UpdateEnabled(btnStyleSheetCopy, CanCopyStyleSheet);
  UpdateEnabled(btnStyleSheetDelete, CanDeleteStyleSheet);
  UpdateEnabled(btnStyleSheetRename, CanRenameStyleSheet);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.UpdateEnabled(
  AControl: TControl; AEnabled: Boolean);
begin
  TControlAccess(AControl).Enabled := AEnabled;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.UpdateEnabled(
  AItem: TMenuItem; AEnabled: Boolean);
begin
  AItem.Enabled := AEnabled;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.UpdateEnabledControls(
  AControls: array of TControl; AEnabled: Boolean);
var
  I: Integer;
begin
  for I := 0 to High(AControls) do
    UpdateEnabled(AControls[I], AEnabled);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.UpdatePreview;
begin
  inherited UpdatePreview;
  PreviewPivotGrid.BeginUpdate;
  try
    ReportLink.OptionsView.AssignToPivot(PreviewPivotGrid);
    ReportLink.OptionsExpanding.AssignToPivot(PreviewPivotGrid);
    ReportLink.ActiveStyles.AssignToPivot(ReportLink.PivotGrid,
      PreviewPivotGrid, not ReportLink.OptionsFormatting.UseNativeStyles);
    ReportLink.OptionsFormatting.AssignToPivot(PreviewPivotGrid);
    PreviewPivotGrid.FullRefresh;
  finally
    PreviewPivotGrid.EndUpdate;
  end;
end;

//

procedure TcxfmPivotGridReportLinkDesignWindow.DoActiveStyleSheetChanged;
begin
  lbxStyles.ReportLinkStyles := ReportLink.ActiveStyles;
  inherited DoActiveStyleSheetChanged;
  with cbxStyleSheets do
    ItemIndex := Items.IndexOfObject(ActiveStyleSheet);
  if not LockControlsUpdate then
  begin
    Modified := True;
    UpdatePreview;
  end;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.DoFormActivated(AnActive: Boolean);
begin
  inherited;
  if not AnActive then lbxStyles.HideToolTips;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.DoRefreshStylesList;
var
  Styles: TcxPivotGridReportLinkStyles;
  List: TList;
begin
  Styles := ReportLink.ActiveStyles;
  with lbxStyles.Items do
  begin
    BeginUpdate;
    try
      List := TList.Create;
      try
        SaveSelectedStyles(List);
        try
          Clear;
          AddObject(cxGetResourceString(@sdxPivotGridColumnHeader), Styles.ColumnHeader);
          AddObject(cxGetResourceString(@sdxPivotGridContent), Styles.Content);
          AddObject(cxGetResourceString(@sdxPivotGridFieldHeader), Styles.FieldHeader);
          AddObject(cxGetResourceString(@sdxPivotGridHeaderBackground), Styles.HeaderBackground);
          AddObject(cxGetResourceString(@sdxPivotGridPrefilter), Styles.Prefilter);
          AddObject(cxGetResourceString(@sdxPivotGridRowHeader), Styles.RowHeader);
        finally
          RestoreSelectedStyles(List);
        end;  
      finally
        List.Free;
      end;
    finally
      EndUpdate;
    end;  
  end;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.DoStyleChanged(const ACaption: string;
  AStyle: TcxStyle);
begin
  inherited;
  Modified := True;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.DoStylesChanged(AStrings: TStrings;
  ARecreate: Boolean);
begin
  if ARecreate then 
    RecreateStylesListBox
  else
    lbxStyles.Invalidate;  
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.GetSelectedStyleNames(AStrings: TStrings);
var
  I: Integer;
begin
  AStrings.Clear;
  with lbxStyles do
    for I := 0 to Items.Count - 1 do
      if Selected[I] then
        AStrings.AddObject(Items[I], Items.Objects[I]);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.GetStyleNames(out AStrings: TStrings);
begin
  AStrings := lbxStyles.Items;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.GetStyleSheetNames(out AStrings: TStrings);
begin
  AStrings := cbxStyleSheets.Items;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.LoadCaption(
  AControl: TControl; StrPtr: Pointer);
begin
  TControlAccess(AControl).Caption := cxGetResourceString(StrPtr);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.LoadCaption(
  AItem: TMenuItem; StrPtr: Pointer);
begin
  AItem.Caption := cxGetResourceString(StrPtr);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.LoadPreviewData;
var
  AStream: TStream;
begin
  AStream := TResourceStream.Create(hInstance, 'PIVOTPREVIEWDATA', 'PIVOTDATA');
  try
    AStream.Position := 0;
    PreviewPivotGrid.DataController.LoadFromStream(AStream);
    PreviewPivotGrid.FullRefresh;
  finally
    AStream.Free;
  end;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.LoadStrings;

  procedure AdjustBevelSize(ABevel: TBevel; AControl: TControl);
  var
    Right: Integer;
  begin
    Right := ABevel.BoundsRect.Right;
    ABevel.Left := AControl.Left + AControl.Width + 10;
    ABevel.Width := Right - ABevel.Left;
  end;

begin
  inherited LoadStrings;

  LoadCaption(tshView, @sdxViewTab);
  LoadCaption(tshBehaviors, @sdxBehaviorsTab);
  LoadCaption(tshFormatting, @sdxFormatting);
  LoadCaption(tshStyles, @sdxStyles);
  LoadCaption(lblPreviewWindow, @sdxPreview);
  LoadCaption(lblShow, @sdxShow);
  LoadCaption(lblCardFraming, @sdxFraming);
  
  // pivot preview
  pgfPurchaseQuarter.Caption := cxGetResourceString(@sdxPurchaseQuarter);
  pgfPurchaseMonth.Caption := cxGetResourceString(@sdxPurchaseMonth);
  pgfPaymentType.Caption := cxGetResourceString(@sdxPaymentType);
  pgfQuantity.Caption := cxGetResourceString(@sdxQuantity);
  pgfCarName.Caption := cxGetResourceString(@sdxCarName);
  pgfUnitPrice.Caption := cxGetResourceString(@sdxUnitPrice);
  pgfCompanyName.Caption := cxGetResourceString(@sdxCompanyName);
  pgfPaymentAmount.Caption := cxGetResourceString(@sdxPaymentAmount);
  // view
  LoadCaption(chbxColumnFields, @sdxColumnFields);
  LoadCaption(chbxDataFields, @sdxDataFields);
  LoadCaption(chbxFilterFields, @sdxFiterFields);
  LoadCaption(chbxPrefilter, @sdxPrefilter);
  LoadCaption(chbxRowFields, @sdxRowFields);
  LoadCaption(chbxShowExpandButtons, @sdxExpandButtons);
  LoadCaption(chbxHorizontalLines, @sdxHorzLines);
  LoadCaption(chbxVerticalLines, @sdxVertLines);
  LoadCaption(chbxBorders, @sdxBorderLines);
  //Behaviors
  LoadCaption(lblExpanding, @sdxExpanding);
  LoadCaption(chbxExpandColumns, @sdxAutoColumnsExpand);
  LoadCaption(chbxExpandRows, @sdxAutoRowsExpand);
  // Formatting
  LoadCaption(lblLookAndFeel, @sdxLookAndFeel);
  AdjustBevelSize(bvlLookAndFeel, lblLookAndFeel);
  LoadStringsCombo(cbxLookAndFeel, [@sdxLookAndFeelFlat,
   @sdxLookAndFeelStandard, @sdxLookAndFeelUltraFlat]);
  cbxLookAndFeel.ItemIndex := Integer(ReportLink.OptionsFormatting.LookAndFeelKind);
  LoadCaption(lblRefinements, @sdxRefinements);
  LoadCaption(chbxTransparentGraphics, @sdxTransparentGraphics);
  LoadCaption(chbxDisplayGraphicsAsText, @sdxDisplayGraphicsAsText);
  LoadCaption(chbxFlatCheckMarks, @sdxFlatCheckMarks);
  LoadCaption(chbxSuppressBackgroundBitmaps, @ sdxSuppressBackgroundBitmaps);
  LoadCaption(chbxSuppressContentColoration, @ sdxSuppressContentColoration);
  //styles
  LoadCaption(lblUseNativeStyles, @sdxUseNativeStyles);
  AdjustBevelSize(bvlStyles, lblUseNativeStyles);
  LoadCaption(btnStyleColor, @sdxBtnColor);
  LoadCaption(btnStyleFont, @sdxBtnFont);
  LoadCaption(btnStyleBackgroundBitmap, @sdxBtnTexture);
  LoadCaption(btnStyleBackgroundBitmapClear, @sdxBtnTextureClear);
  LoadCaption(btnStyleRestoreDefaults, @sdxBtnRestoreDefaults);
  LoadCaption(btnStylesSaveAs, @sdxBtnSaveAs);
  LoadCaption(miStyleColor, @sdxBtnColor);
  LoadCaption(miStyleFont, @sdxBtnFont);
  LoadCaption(miStyleBackgroundBitmap, @sdxBtnTexture);
  LoadCaption(miStyleBackgroundBitmapClear, @sdxBtnTextureClear);
  LoadCaption(miStyleRestoreDefaults, @sdxBtnRestoreDefaults);
  LoadCaption(miStylesSelectAll, @sdxSelectAll);
  LoadCaption(miStylesSaveAs, @sdxBtnSaveAs);
  LoadCaption(lblStyleSheets, @sdxStyleSheets);
  AdjustBevelSize(bvlStyleSheets, lblStyleSheets);
  LoadCaption(btnStyleSheetNew, @sdxBtnNew);
  LoadCaption(btnStyleSheetCopy, @sdxBtnCopy);
  LoadCaption(btnStyleSheetDelete, @sdxBtnDelete);
  LoadCaption(btnStyleSheetRename, @sdxBtnRename);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.LoadStringsCombo(
  ACombo: TComboBox; ACaptions: array of Pointer);
var
  I: Integer;
begin
  with ACombo.Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to High(ACaptions) do
        if ACaptions[I] <> nil then Add(cxGetResourceString(ACaptions[I]));
    finally
      EndUpdate;
    end;
  end;
end;

function TcxfmPivotGridReportLinkDesignWindow.GetActiveStyle: TcxStyle;
begin
  with lbxStyles do
  begin
    if ItemIndex <> -1 then
      Result := TcxStyle(Items.Objects[ItemIndex])
    else
      Result := nil;
  end;
end;

function TcxfmPivotGridReportLinkDesignWindow.GetHasSelectedStyles: Boolean;
begin
  Result := lbxStyles.SelCount <> 0;
end;

function TcxfmPivotGridReportLinkDesignWindow.GetHasSelectedStylesWithAssignedBitmap: Boolean;
var
  Strings: TStrings;
  I: Integer;
  cxStyle: TcxStyle;
begin
  Result := True;
  Strings := TStringList.Create;
  try
    GetSelectedStyleNames(Strings);
    for I := 0 to Strings.Count - 1 do
    begin
      cxStyle := TcxStyle(Strings.Objects[I]);
      if (cxStyle <> nil) and (cxStyle.Bitmap <> nil) and not cxStyle.Bitmap.Empty then
        Exit;
    end;
  finally
    Strings.Free;
  end;
  Result := False;
end;

function TcxfmPivotGridReportLinkDesignWindow.GetReportLink: TcxPivotGridReportLink;
begin
  Result := TcxPivotGridReportLink(inherited ReportLink);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.lbxStylesClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  UpdateControlsState;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.OptionsFormattingChanged(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  case TControl(Sender).Tag of
    0:
      begin
        ReportLink.OptionsFormatting.UseNativeStyles := chbxUseNativeStyles.Checked;
        RecreateStylesListBox;
      end;
    1:
      ReportLink.OptionsFormatting.SuppressBackgroundBitmaps := chbxSuppressBackgroundBitmaps.Checked;
    2:
      ReportLink.OptionsFormatting.SuppressContentColoration := chbxSuppressContentColoration.Checked;
    3:
      ReportLink.OptionsRefinements.TransparentGraphics := chbxTransparentGraphics.Checked;
    4:
      ReportLink.OptionsRefinements.DisplayGraphicsAsText := chbxDisplayGraphicsAsText.Checked;
    5:
      ReportLink.OptionsRefinements.FlatCheckMarks := chbxFlatCheckMarks.Checked;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleFontClick(Sender: TObject);
begin
  PerformStylesChangeFont;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleColorClick(Sender: TObject);
begin
  PerformStylesChangeColor;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleBackgroundBitmapClick(Sender: TObject);
begin
  PerformStylesChangeBitmap;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleClearClick(Sender: TObject);
begin
  PerformStylesClearBitmap;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleRestoreDefaultsClick(
  Sender: TObject);
begin
  PerformStylesRestoreDefaults;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStylesSaveAsClick(
  Sender: TObject);
begin
  PerformStylesSaveAsStyleSheet;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleSheetNewClick(Sender: TObject);
begin
  PerformStyleSheetNew;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleSheetCopyClick(Sender: TObject);
begin
  PerformStyleSheetCopy;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleSheetDeleteClick(Sender: TObject);
begin
  PerformStyleSheetDelete;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.btnStyleSheetRenameClick(Sender: TObject);
begin
  PerformStyleSheetRename;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.lblUseNativeStylesClick(
  Sender: TObject);
begin
  if chbxUseNativeStyles.CanFocus then
    ActiveControl := chbxUseNativeStyles;
  chbxUseNativeStyles.Checked := not chbxUseNativeStyles.Checked;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.pmStylesPopup(
  Sender: TObject);
begin
  lbxStyles.HideToolTips;
  UpdateEnabled(miStyleColor, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(miStyleFont, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(miStyleBackgroundBitmap, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(miStyleBackgroundBitmapClear, AreNativeStylesAvailable and HasSelectedStylesWithAssignedBitmap);
  UpdateEnabled(miStyleRestoreDefaults, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(miStylesSelectAll, CanSelectAllStyles);
  UpdateEnabled(miStylesSaveAs, CanSaveStyles);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.miStylesSelectAllClick(
  Sender: TObject);
{$IFNDEF DELPHI6}
var
  I: Integer;
{$ENDIF}
begin
  with lbxStyles do
  begin
   {$IFDEF DELPHI6}
    SelectAll;
   {$ELSE}
    Items.BeginUpdate;
    try
      for I := 0 to Items.Count - 1 do
        Selected[I] := True;
    finally
      Items.EndUpdate;
    end;
   {$ENDIF}
  end;
  UpdateControlsState;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.cbxStyleSheetsClick(
  Sender: TObject);
begin
  with TComboBox(Sender) do
    ActiveStyleSheet := TcxCustomStyleSheet(Items.Objects[ItemIndex])
end;

procedure TcxfmPivotGridReportLinkDesignWindow.cbxStyleSheetsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  PerformStyleSheetKeyDown(Sender, Key, Shift);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.cbxStyleSheetsDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  PerformStyleSheetDrawItem(TComboBox(Control).Canvas, Index, Rect, State, Control.Enabled);
end;

procedure TcxfmPivotGridReportLinkDesignWindow.cbxLookAndFeelChange(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.OptionsFormatting.LookAndFeelKind :=
    TcxLookAndFeelKind(cbxLookAndFeel.ItemIndex);
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.chbxExpandOptionsClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit; 
  with TCheckBox(Sender) do
  begin
    case Tag of
      0:
        ReportLink.OptionsExpanding.AutoExpandColumns := Checked;
      1:
        ReportLink.OptionsExpanding.AutoExpandRows := Checked;
    end;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmPivotGridReportLinkDesignWindow.chbxOptionsViewClick(
  Sender: TObject);
const
  AVisible: array [Boolean] of TcxPivotGridPrefilterVisible = (pfvNever, pfvAlways);
begin
  if LockControlsUpdate then Exit; 
  with ReportLink.OptionsView do
  begin
    case TCheckBox(Sender).Tag of
      0:
      begin
        ColumnFields := chbxColumnFields.Checked;
        DataFields := chbxDataFields.Checked;
        FilterFields := chbxFilterFields.Checked;
        RowFields := chbxRowFields.Checked;
      end;
      1, 2:
      begin
        if chbxHorizontalLines.Checked and chbxVerticalLines.Checked then
          GridLines := pglBoth
        else
          if chbxHorizontalLines.Checked then
            GridLines := pglHorz
          else
            if chbxVerticalLines.Checked then
              GridLines := pglVert
            else
              GridLines := pglNone;
      end;
      3:
        Borders := TCheckBox(Sender).Checked;
      4:
        ExpandButtons := TCheckBox(Sender).Checked;
      5:
        Prefilter := AVisible[TCheckBox(Sender).Checked];
    end;
  end;
  Modified := True;
  UpdatePreview;
end;

// common

procedure RegisterAssistants;
begin
  dxPSRegisterReportLink(TcxPivotGridReportLink,
    TcxCustomPivotGrid, TcxfmPivotGridReportLinkDesignWindow);
end;

procedure UnregisterAssistants;
begin
  dxPSUnregisterReportLink(TcxPivotGridReportLink,
    TcxCustomPivotGrid, TcxfmPivotGridReportLinkDesignWindow);
end;

initialization
  RegisterAssistants;

finalization
  UnregisterAssistants;

end.
//1. --borders--
//2. --gridlines--
//3. --expandbuttons--
//4. --sorting mark--
//5. --Images--
//6. styles in pivot (font height, etc)

