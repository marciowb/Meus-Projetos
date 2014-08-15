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

unit dxPSReg;

interface

{$I cxVer.inc}

uses
   {$IFDEF DELPHI6} 
    DesignIntf, DesignEditors,
   {$ELSE}
    DsgnIntf, 
   {$ENDIF}  
   PicEdit,  
  Classes, dxPSCore;
 
type  
  TdxReportLinkComponentPropertyEditor = class(TComponentProperty)
  private
    FComponents: TStringList;
    function GetReportLink: TBasedxReportLink;
  protected
    procedure AddComponent(const AName: string);
    procedure GetComponents; virtual;
    function IsComponentValid(AComponent: TComponent): Boolean; virtual;
  public
    destructor Destroy; override;
    procedure Initialize; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    property ReportLink: TBasedxReportLink read GetReportLink;
  end;

procedure Register;

implementation

{$R dxPSDsgImgs.res}

{$IFNDEF DELPHI6}
  {Delphi6 and up versions don't support Bitmaps in MenuItem}
  {$IFDEF DELPHI5}
    {$DEFINE IDE_MENUBITMAPS}
  {$ENDIF}
{$ENDIF}

{.$DEFINE LIMITED_EDITION}

uses                                                              
  {$IFDEF DELPHI6} 
   DesignConst, DesignMenus, VCLEditors, RTLConsts, 
  {$ELSE}
   Consts, 
  {$ENDIF}
  ToolsAPI,
  Windows, SysUtils, ShellAPI, FileCtrl, Graphics, Dialogs, Controls, ExtCtrls, 
  TabNotBk, ImgList, Forms, TypInfo, 
 {$IFDEF IDE_MENUBITMAPS} Menus, {$ENDIF} 
 {$IFNDEF LIMITED_EDITION} dxRegEd, {$ENDIF} 
  dxPSGlbl, dxPSUtl, dxWrap, dxBase, dxPSEngn, dxPreVw, dxPrnPg, dxBkgnd, 
  dxPrnDev, dxPgsDlg, dxPrnDlg, dxPPAttr, dxPSfmTtl, dxPSFileBasedXplorer, 
  dxPSGraphicLnk, dxPSContainerLnk, dxPSTextLnk, dxBrhDlg, dxPSfmEditDesc, 
  dxPSPrVwDsg, dxPSfmStlAdd, dxPSfmLnkDsg, dxPSfmLnkAdd, dxPSfmLnkAddE,
  dxPSDsgProxies, dxPSfmStlDsg, cxDrawTextUtils;

const
  sdxDefault = 'Default';
  sdxRestoreDefaultIcon = 'Type "default" to restore original Icon';
  sdxRestoreDefaultGlyph = 'Type "default" to restore original Glyph';
  sdxCreateNewStyleManager = '<Create a new StyleManager>';
  
  sdxReportLinks = 'ReportLinks...';
  sdxPrintStyles = 'PrintStyles...';
  sdxAddNewStyle = '&Add...';
  sdxAddNewLink = '&Add...';
  sdxAddNewEmtpyLink = 'Add E&mpty...';
  sdxPageBackground = 'Page Bac&kground...';
  sdxClearBackground = 'Clea&r Background';
  sdxRestoreDefaults = 'Rest&ore Defaults';  
  sdxRestoreOriginal = 'Restore Or&iginal';  
  sdxMakeCurrent = '&Make Current';
  sdxPageSetupDialog = 'PageSetup Dialog...';
  sdxPageSetup = 'Page Set&up...';  
  sdxPrintDialog = 'Print Dialog...';
  sdxPrint = '&Print...';
  sdxPrintPreview = 'Print Pre&view...';
  sdxShowReportDesigner = 'Show D&esigner...';
  sdxCreateFolders = 'Create &Folders';
  sdxDesignerNoAvailable = 'Designer not available';
  sdxClickForPageSetup = 'Click for Page Setup...';
  sdxCustomPaperSize = 'CustomSize - DMPAPER_USER #';
  sdxCustomBin = 'CustomBin - DMBIN_USER #';
  sdxInThousandths = '(in thousandths)';
  sdxWEBPage = 'http://www.devexpress.com';
  sdxDevex = 'Developer Express Inc.';
  sdxPrintingSystem: string = 'ExpressPrinting System ';

  IDB_DXPSDESIGN_BIN_AUTOTRAY = 'IDB_DXPSDESIGN_BIN_AUTOTRAY';
  IDB_DXPSDESIGN_BIN_MANUALTRAY = 'IDB_DXPSDESIGN_BIN_MANUALTRAY';
  IDB_DXPSDESIGN_PAPERORIENTATION_LANDSCAPE = 'IDB_DXPSDESIGN_PAPERORIENTATION_LANDSCAPE';
  IDB_DXPSDESIGN_PAPERORIENTATION_PORTRAIT = 'IDB_DXPSDESIGN_PAPERORIENTATION_PORTRAIT';
  IDB_DXPSDESIGN_PAPER_ENVELOPE = 'IDB_DXPSDESIGN_PAPER_ENVELOPE';
  IDB_DXPSDESIGN_PAPER_STANDARD = 'IDB_DXPSDESIGN_PAPER_STANDARD';
  IDB_DXPSDESIGN_PRINTORDER_OVERTHENDOWN = 'IDB_DXPSDESIGN_PRINTORDER_OVERTHENDOWN';
  IDB_DXPSDESIGN_PRINTORDER_DOWNTHENOVER = 'IDB_DXPSDESIGN_PRINTORDER_DOWNTHENOVER';

  IDB_DXPSDESIGN_DOADD = 'IDB_DXPSDESIGN_DOADD';
  IDB_DXPSDESIGN_DOADDEMPTY = 'IDB_DXPSDESIGN_DOADDEMPTY';
  IDB_DXPSDESIGN_DODESIGNER = 'IDB_DXPSDESIGN_DODESIGNER';
  IDB_DXPSDESIGN_DOPAGEBACKGROUND = 'IDB_DXPSDESIGN_DOPAGEBACKGROUND';
  IDB_DXPSDESIGN_DOPAGESETUP = 'IDB_DXPSDESIGN_DOPAGESETUP';
  IDB_DXPSDESIGN_DOPREVIEW = 'IDB_DXPSDESIGN_DOPREVIEW';
  IDB_DXPSDESIGN_DOPRINT = 'IDB_DXPSDESIGN_DOPRINT';
  IDB_DXPSDESIGN_DOPROPERTIES = 'IDB_DXPSDESIGN_DOPROPERTIES';
  IDB_DXPSDESIGN_DOWEB = 'IDB_DXPSDESIGN_DOWEB';
    
{$IFDEF IDE_MENUBITMAPS}
var
  FBmpWEB: TBitmap;
  FBmpItems: TBitmap;
  FBmpPrint: TBitmap;
  FBmpPageSetup: TBitmap;
  FBmpPageBackground: TBitmap;
  FBmpDesigner: TBitmap;
  FBmpPrintPreview: TBitmap;
  FBmpNewEmpty: TBitmap;
  FBmpNew: TBitmap;
{$ENDIF}  

{$IFDEF DELPHI5}  
var
  ilPapers: TImageList;
  ilBins: TImageList;  
  ilPrintOrders: TImageList;
  ilPaperOrientations: TImageList;
{$ENDIF}

type
  TdxComponentPrinterEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
   {$IFDEF IDE_MENUBITMAPS}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
   {$ENDIF}
  end;

  TdxReportLinkEditor = class(TComponentEditor)
  private
    function ReportLink: TBasedxReportLink;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
   {$IFDEF DELPHI5}
    procedure PrepareItem(Index: Integer; 
      const AItem: {$IFDEF DELPHI6} IMenuItem {$ELSE} TMenuItem {$ENDIF}); override;    
   {$ENDIF}  
  end;

  TdxPrintStyleManagerEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
   {$IFDEF IDE_MENUBITMAPS}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
   {$ENDIF}
  end;
  
  TdxPrintStyleEditor = class(TComponentEditor)
  private
    function PrintStyle: TBasedxPrintStyle;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
   {$IFDEF DELPHI5}
    procedure PrepareItem(Index: Integer; 
      const AItem: {$IFDEF DELPHI6} IMenuItem {$ELSE} TMenuItem{$ENDIF}); override;    
   {$ENDIF}  
  end;

  TdxPageSetupDialogEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  {$IFDEF DELPHI5}  
    procedure PrepareItem(Index: Integer; 
      const AItem: {$IFDEF DELPHI6} IMenuItem {$ELSE} TMenuItem{$ENDIF}); override;
  {$ENDIF}
  end;

  TdxPrintDialogEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
   {$IFDEF IDE_MENUBITMAPS}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
   {$ENDIF}
  end;

  TCustomdxPSExplorerEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
   {$IFDEF IDE_MENUBITMAPS}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
   {$ENDIF}
  end;
  
  TdxEngineControllerEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
   {$IFDEF IDE_MENUBITMAPS}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
   {$ENDIF}
  end;
  
  TdxCompositionReportLinkPropertyEditor = class(TComponentProperty)
  private
    FComponents: TStringList;
    function GetItems: TdxCompositionLinkItems;
    procedure CheckProc(const S: string);
    function IsComponentValid(AComponent: TComponent): Boolean;
  protected
  public
    destructor Destroy; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure Initialize; override;
    property Items: TdxCompositionLinkItems read GetItems;
  end;
  
  TdxIndexPropertyEditor = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;
  
  TdxReportLinkDesignerPropertyEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;
  
  TdxPSExplorerFilterPropertyEditor = class(TStringProperty
   {$IFDEF DELPHI6}, ICustomPropertyListDrawing {$ENDIF})
  protected
   {$IFDEF DELPHI5}
    function GetImageIndex(const Value: string): Integer;
    function GetImageList: TCustomImageList;
   {$ENDIF} 
    function IsAcceptableComponentClass(AComponentClass: TClass): Boolean; virtual;
  public
    function GetAttributes: TPropertyAttributes; override;  
    procedure GetValues(Proc: TGetStrProc); override;
   {$IFDEF DELPHI5}
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer); {$IFNDEF DELPHI6} override; {$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF DELPHI6} override; {$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6} override; {$ENDIF}

    property ImageIndexes[const Value: string]: Integer read GetImageIndex;
    property ImageList: TCustomImageList read GetImageList;
   {$ENDIF}
  end;    

{$IFDEF DELPHI5}

  TdxPrintStyleImageIndexPropertyEditor = class(TIntegerProperty
 {$IFDEF DELPHI6}
   ,ICustomPropertyDrawing, ICustomPropertyListDrawing
 {$ENDIF})
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF DELPHI6} override;{$ENDIF}
    procedure ListMeasureWidth(const Value: string;
      ACanvas: TCanvas; var AWidth: Integer); {$IFNDEF DELPHI6} override;{$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6} override;{$ENDIF}
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean); {$IFNDEF DELPHI6} override;{$ENDIF}
   {$IFDEF DELPHI6}  
    { ICustomPropertyDrawing }
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
   {$ENDIF}
  end;

  TdxCustomDrawListPropertyEditor = class(TEnumProperty
   {$IFDEF DELPHI6}, ICustomPropertyListDrawing {$ENDIF})
  protected
    function GetImageIndex(const Value: string): Integer; virtual; abstract;
    function GetImageList: TImageList; virtual; abstract;
  public
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer); {$IFNDEF DELPHI6} override; {$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF DELPHI6} override; {$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6} override; {$ENDIF}

    property ImageIndexes[const Value: string]: Integer read GetImageIndex;
    property ImageList: TImageList read GetImageList;
  end;    

  TdxPaperOrientationPropertyEditor = class(TdxCustomDrawListPropertyEditor)
  protected
    function GetImageIndex(const Value: string): Integer; override;
    function GetImageList: TImageList; override;
  end;

  TdxPrintOrderPropertyEditor = class(TdxCustomDrawListPropertyEditor)
  protected
    function GetImageIndex(const Value: string): Integer; override;
    function GetImageList: TImageList; override;
  end;

{$ENDIF}

  TdxPathPropertyEditor = class(TStringProperty)
  private
    function GetExplorer(Index: Integer): TdxPSFileBasedExplorer;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    property Explorers[Index: Integer]: TdxPSFileBasedExplorer read GetExplorer;
  end;
  
  TdxRegistryPathPropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;
  
  TdxExplorerStubLinkPropertyEditor = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;
  
  TdxCustomContainerReportLinkComponentPropertyEditor = class(TdxReportLinkComponentPropertyEditor
  {$IFDEF DELPHI6}, ICustomPropertyListDrawing {$ENDIF})
 {$IFDEF DELPHI5}  
  private
    function GetImageIndex(const Value: string): Integer;
    function GetImages: TCustomImageList;
 {$ENDIF}
  protected
    procedure GetComponents; override;
    function GetProject: IOTAProject;
    function IsComponentValid(AComponent: TComponent): Boolean; override;
    function IsSupportedModuleType(const AModuleType: TOTAModuleType): Boolean;
 {$IFDEF DELPHI5}  
  public
    procedure Initialize; override;
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer); {$IFNDEF DELPHI6} override; {$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF DELPHI6} override; {$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6} override; {$ENDIF}

    property ImageIndexes[const Value: string]: Integer read GetImageIndex;
    property Images: TCustomImageList read GetImages;
 {$ENDIF}
  end;
 
  TdxMeasurementUnitsPropertyEditor = class(TEnumProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
  end;

  TdxPrinterPagePropertyEditor = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TdxReportTitlePropertyEditor = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TdxReportTitleTextAlignXPropertyEditor = class(TEnumProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TdxReportTitleTextAlignYPropertyEditor = class(TEnumProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TdxHeaderFooterTextAlignYPropertyEditor = class(TEnumProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;
  
  TdxPrinterPagePropertyEditor2 = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TdxPointWrapperEditor = class(TClassProperty)
  private
    function PointWrapper: TdxPointWrapper;
  public
    function GetValue: string; override;
  end;

  TdxRectWrapperEditor = class(TClassProperty)
  private
    function RectWrapper: TdxRectWrapper;
  public
    function GetValue: string; override;
  end;

  TdxBackgroundPropertyEditor = class(TClassProperty)
  private
    function GetBackground: TdxBackground;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    property Background: TdxBackground read GetBackground;
  end;
  
  TdxBrushPropertyEditor = class(TClassProperty)
  private
    function GetBrush: TBrush;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    property Brush: TBrush read GetBrush;
  end;

  TTTFontPropertyEditor = class(TFontProperty)
  public
    procedure Edit; override;
  end;

  TdxShowPgsDlgPropertyEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;
  
  TdxStyleGlyphPropertyEditor = class(TGraphicProperty)
  private
    function GetPrintStyle: TBasedxPrintStyle;
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    property PrintStyle: TBasedxPrintStyle read GetPrintStyle;
  end;
  
  TdxCustomListDrawingIntegerPropertyEditor = class(TIntegerProperty
   {$IFDEF DELPHI6}, ICustomPropertyListDrawing {$ENDIF})
 {$IFDEF DELPHI5}  
  protected
    function GetImageIndex(const Value: string): Integer; virtual; abstract;
    function GetImageList: TImageList; virtual; abstract;
  public
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer); {$IFNDEF DELPHI6} override; {$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF DELPHI6} override; {$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6} override; {$ENDIF}
            
    property ImageIndexes[const Value: string]: Integer read GetImageIndex;
    property ImageList: TImageList read GetImageList;    
 {$ENDIF}
  end;
  
  TdxDMPaperPropertyEditor = class(TdxCustomListDrawingIntegerPropertyEditor)
 {$IFDEF DELPHI5}  
  protected
    function GetImageIndex(const Value: string): Integer; override;
    function GetImageList: TImageList; override;
 {$ENDIF}
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TdxPaperSourcePropertyEditor = class(TdxCustomListDrawingIntegerPropertyEditor)
 {$IFDEF DELPHI5}  
  protected
    function GetImageIndex(const Value: string): Integer; override;
    function GetImageList: TImageList; override;
 {$ENDIF}
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TdxPageNumberFormatsPropertyEditor = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TdxReportLinkStyleManagerPropertyEditor = class(TComponentProperty)
  private
   function GetRoot: TComponent;
   function GetUniqueName: string;
  protected
    function CanCreateStyleManager: Boolean;
    function CreateNewStyleManager: TdxPrintStyleManager;
    property Root: TComponent read GetRoot;
    property UniqueName: string read GetUniqueName;
  public
   {$IFDEF DELPHI5}
    function AutoFill: Boolean; override;
   {$ELSE}  
    procedure Edit; override;
   {$ENDIF}
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;
  
  TdxReportDocumentDescriptionPropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;
  
  TdxDateFormatsPropertyEditor = class(TIntegerProperty)
  private
    FStrings: TStrings;
  protected
  public
    destructor Destroy; override;
    procedure Initialize; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TdxTimeFormatsPropertyEditor = class(TIntegerProperty)
  private
    FStrings: TStrings;
  protected
  public
    destructor Destroy; override;
    procedure Initialize; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TdxAutoHFTextEntriesPropertyEditor = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;    
  end;
  
  TdxPreviewIconPropertyEditor = class(TGraphicProperty)
  private
    function GetPreviewOptions: TdxPreviewOptions;
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;  
    property PreviewOptions: TdxPreviewOptions read GetPreviewOptions;
  end;

  TdxTextReportLinkAlignmentPropertyEditor = class(TEnumProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;
  
{$IFDEF DELPHI6}

  TdxComponentPrinterSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TdxPrintStyleManagerSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TdxPageSetupDialogSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TdxPrintDialogSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
  
{$ENDIF}

function TryStartWEBPage(const APage: string): Boolean;
begin
  Result := ShellExecute(0, nil, PChar(APage), nil, nil, SW_SHOWNORMAL) >= 32;
end;
 
{ TdxComponentPrinterEditor }

procedure TdxComponentPrinterEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: dxShowReportLinkDesigner(TCustomdxComponentPrinter(Component), Designer);
    3: TryStartWEBPage(sdxWEBPage);
  end;  
end;

function TdxComponentPrinterEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := sdxReportLinks;
    1: Result := '-';
    2: Result := sdxPrintingSystem;
    3: Result := sdxWEBPage;
    4: Result := sdxDevex;
  end
end;

function TdxComponentPrinterEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 5;
end;

{$IFDEF IDE_MENUBITMAPS}
procedure TdxComponentPrinterEditor.PrepareItem(Index: Integer; const AItem: TMenuItem);
begin
  case Index of
    0: AItem.Bitmap := FBmpItems;
    3: AItem.Bitmap := FBmpWEB;
  end
end;
{$ENDIF}

{ TdxReportLinkEditor }

function TdxReportLinkEditor.ReportLink: TBasedxReportLink;
begin
  Result := TBasedxReportLink(Component);
end;

procedure TdxReportLinkEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: 
      if ReportLink.ComponentPrinter.DesignReport(ReportLink) then Designer.Modified;
    1: 
      begin
        ReportLink.IsCurrentLink := True;
        Designer.Modified;
      end;
    3: 
      begin 
        ReportLink.RestoreFromOriginal;
        Designer.Modified;
      end;  
    4: 
      begin
        ReportLink.RestoreDefaults;
        ReportLink.PrinterPage.RestoreDefaults;
        Designer.Modified;
      end;
    6:       
      if ReportLink.PrinterPage.Background.SetupEffects then 
        Designer.Modified;
    7: 
      begin
        ReportLink.PrinterPage.Background.Mode := bmNone;
        ReportLink.PrinterPage.Background.Picture := nil;
        Designer.Modified;
      end;
    9: 
      if ReportLink.PageSetup then Designer.Modified;
    10: 
      dxShowPreviewWindow(ReportLink.ComponentPrinter, Designer);
    11:                    
      if ReportLink.Print(True, nil) then Designer.Modified;
  end;
end;

function TdxReportLinkEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := sdxShowReportDesigner;
    1: Result := sdxMakeCurrent;
    2: Result := '-';  
    3: Result := sdxRestoreOriginal;
    4: Result := sdxRestoreDefaults;
    5: Result := '-';
    6: Result := sdxPageBackground;
    7: Result := sdxClearBackground;
    8: Result := '-';
    9: Result := sdxPageSetup;
    10: Result := sdxPrintPreview;
    11: Result := sdxPrint;    
  end;
end;

function TdxReportLinkEditor.GetVerbCount: Integer;
begin
  Result := 12;
end;

{$IFDEF DELPHI5}
procedure TdxReportLinkEditor.PrepareItem(Index: Integer; 
  const AItem: {$IFDEF DELPHI6} IMenuItem {$ELSE} TMenuItem{$ENDIF});
begin
  case Index of
    0:
      begin
        AItem.Enabled := TBasedxReportLink(Component).CheckToDesign;
       {$IFDEF IDE_MENUBITMAPS}
        AItem.Bitmap := FBmpDesigner;
       {$ENDIF}
      end;  
    1: AItem.Enabled := not TBasedxReportLink(Component).IsCurrentLink;
   {$IFDEF IDE_MENUBITMAPS}    
    6: AItem.Bitmap := FBmpPageBackground;
    9: AItem.Bitmap := FBmpPageSetup;
   {$ENDIF}
    10: 
      begin
        AItem.Enabled := TBasedxReportLink(Component).DataProviderPresent;
       {$IFDEF IDE_MENUBITMAPS}        
        AItem.Bitmap := FBmpPrintPreview;
       {$ENDIF} 
      end;  
    11: 
      begin
        AItem.Enabled := TBasedxReportLink(Component).DataProviderPresent;
       {$IFDEF IDE_MENUBITMAPS}
        AItem.Bitmap := FBmpPrint;
       {$ENDIF}
      end;  
  end;
end;
{$ENDIF}

{ TdxReportLinkComponentPropertyEditor }

destructor TdxReportLinkComponentPropertyEditor.Destroy;
begin
  FComponents.Free;
  inherited Destroy;
end;

procedure TdxReportLinkComponentPropertyEditor.Initialize;
begin
  inherited Initialize;
  FComponents := TStringList.Create;
end;

function TdxReportLinkComponentPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paMultiSelect];
end;
                                    
procedure TdxReportLinkComponentPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  GetComponents;
  for I := 0 to FComponents.Count - 1 do
    Proc(FComponents[I]);
end;

function TdxReportLinkComponentPropertyEditor.GetReportLink: TBasedxReportLink;
begin
  Result := TBasedxReportLink(GetComponent(0));
end;

procedure TdxReportLinkComponentPropertyEditor.AddComponent(const AName: string);
begin
  if IsComponentValid(Designer.GetComponent(AName)) then FComponents.Add(AName);
end;

procedure TdxReportLinkComponentPropertyEditor.GetComponents;
begin
  FComponents.Clear;
  Designer.GetComponentNames(GetTypeData(PTypeInfo(TComponent.ClassInfo)), AddComponent);
end;

function TdxReportLinkComponentPropertyEditor.IsComponentValid(AComponent: TComponent): Boolean;
begin
  Result := (AComponent <> nil) and not (AComponent is TBasedxReportLink) and 
    not (AComponent is TCustomdxComponentPrinter) and ReportLink.Supports(AComponent);
end;

{ TdxCompositionReportLinkPropertyEditor }

destructor TdxCompositionReportLinkPropertyEditor.Destroy;
begin
  FComponents.Free;
  inherited Destroy;
end;

function TdxCompositionReportLinkPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paMultiSelect];
end;

procedure TdxCompositionReportLinkPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  FComponents.Clear;
  Designer.GetComponentNames(GetTypeData(PTypeInfo(TComponent.ClassInfo)), CheckProc);
  for I := 0 to FComponents.Count - 1 do
    Proc(FComponents[I]);
end; 

procedure TdxCompositionReportLinkPropertyEditor.Initialize;
begin
  inherited Initialize;
  FComponents := TStringList.Create;
end;

function TdxCompositionReportLinkPropertyEditor.GetItems: TdxCompositionLinkItems;
begin
  Result := TdxCompositionLinkItems(TdxCompositionLinkItem(GetComponent(0)).Collection);
end;

procedure TdxCompositionReportLinkPropertyEditor.CheckProc(const S: string);
begin
  if IsComponentValid(Designer.GetComponent(S)) then
    FComponents.Add(S);
end;

function TdxCompositionReportLinkPropertyEditor.IsComponentValid(AComponent: TComponent): Boolean;
begin
  Result := (AComponent is TBasedxReportLink) and Items.IsLinkComposable(TBasedxReportLink(AComponent));
end;

{ TdxIndexPropertyEditor }

function TdxIndexPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paMultiSelect];
end;

{ TdxReportLinkDesignerPropertyEditor }

function TdxReportLinkDesignerPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly];
  if TBasedxReportLink(GetComponent(0)).CheckToDesign then 
    Result := Result + [paDialog];
end;

function TdxReportLinkDesignerPropertyEditor.GetValue: string;
begin
  if TBasedxReportLink(GetComponent(0)).CheckToDesign then
    Result := DropAmpersand(sdxShowReportDesigner)
  else
    Result := sdxDesignerNoAvailable;
end;

procedure TdxReportLinkDesignerPropertyEditor.Edit;
begin
  if TBasedxReportLink(GetComponent(0)).DesignReport then
    Designer.Modified;
end;

{ TdxPSExplorerFilterPropertyEditor }

function TdxPSExplorerFilterPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [{$IFNDEF DELPHI6}paReadOnly, {$ENDIF} paValueList, paSortList];
end;

procedure TdxPSExplorerFilterPropertyEditor.GetValues(Proc: TGetStrProc);
var
  List: TdxClassList;
  I: Integer;
  ComponentClass: TClass;
begin
  List := TdxClassList.Create;
  try
    dxIdeImagesProvider.Refresh;
    dxPSGetSupportedComponentsList(List);
    for I := 0 to List.Count - 1 do    
    begin
      ComponentClass := List[I];
      if IsAcceptableComponentClass(ComponentClass) then Proc(ComponentClass.ClassName);
    end;  
  finally
    List.Free;
  end;
end;

{$IFDEF DELPHI5}

procedure TdxPSExplorerFilterPropertyEditor.ListMeasureWidth(const Value: string; 
  ACanvas: TCanvas; var AWidth: Integer);
begin
  Inc(AWidth, 1 + ImageList.Height + 2);
end;
  
procedure TdxPSExplorerFilterPropertyEditor.ListMeasureHeight(const Value: string; 
  ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := 1 + ImageList.Height + 1;
end;

procedure TdxPSExplorerFilterPropertyEditor.ListDrawValue(const Value: string; 
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  R: TRect;
begin
  R := ARect;
  ACanvas.FillRect(R);
  ImageList.Draw(ACanvas, R.Left + 1, R.Top + 1, ImageIndexes[Value]);
  Inc(R.Left, 1 + ImageList.Width + 2);
  InflateRect(R, 0, -(R.Bottom - R.Top - ACanvas.TextHeight(Value)) div 2);

 {$IFDEF DELPHI6} 
  DefaultPropertyListDrawValue(Value, ACanvas, R, ASelected);
 {$ELSE}  
  inherited ListDrawValue(Value, ACanvas, R, ASelected);
 {$ENDIF}  
end;  

function TdxPSExplorerFilterPropertyEditor.GetImageIndex(const Value: string): Integer;
begin
  Result := dxIdeImagesProvider.ImageIndexes[TComponentClass(GetClass(Value))];
end;

function TdxPSExplorerFilterPropertyEditor.GetImageList: TCustomImageList;
begin
  Result := dxIdeImagesProvider.Images;
end;    
{$ENDIF}
  
function TdxPSExplorerFilterPropertyEditor.IsAcceptableComponentClass(AComponentClass: TClass): Boolean;
begin
  Result := (AComponentClass <> nil) and 
    not AComponentClass.InheritsFrom(ExtCtrls.TPage) and 
    not AComponentClass.InheritsFrom(TabNotBk.TTabPage);
end;

{$IFDEF DELPHI5}

{ TdxPrintStyleImageIndexPropertyEditor }

function TdxPrintStyleImageIndexPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList, paRevertable];
end;

procedure TdxPrintStyleImageIndexPropertyEditor.GetValues(Proc: TGetStrProc);
var
  PrintStyle: TBasedxPrintStyle;
  I: Integer;
begin
  PrintStyle := TBasedxPrintStyle(GetComponent(0));
  if PrintStyle.StyleManager.Images <> nil then 
    for I := 0 to PrintStyle.StyleManager.Images.Count - 1 do 
      Proc(IntToStr(I));
end;

procedure TdxPrintStyleImageIndexPropertyEditor.ListMeasureHeight(const Value: string; 
  ACanvas: TCanvas; var AHeight: Integer);
var
  Images: TCustomImageList;  
begin
  Images := TBasedxPrintStyle(GetComponent(0)).StyleManager.Images;
  if Images <> nil then 
    AHeight := Images.Height + 2 + 2;
end;  

procedure TdxPrintStyleImageIndexPropertyEditor.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
  Images: TCustomImageList;  
begin
  Images := TBasedxPrintStyle(GetComponent(0)).StyleManager.Images;
  if Images <> nil then 
    AWidth := AWidth + Images.Width + 2 + 2;
end;

procedure TdxPrintStyleImageIndexPropertyEditor.ListDrawValue(const Value: string; 
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  R: TRect;
  Images: TCustomImageList;  
  I: Integer;
begin
  R := ARect;
  ACanvas.FillRect(R);
  Images := TBasedxPrintStyle(GetComponent(0)).StyleManager.Images;
  if Images <> nil then 
  try
    I := StrToInt(Value);
    if (I > -1) and (I < Images.Count) then 
    begin
      Images.Draw(ACanvas, R.Left + 2, R.Top + 2, I);
      Inc(R.Left, Images.Width + 2);
    end;  
  except
  end;
 {$IFDEF DELPHI6} 
  DefaultPropertyListDrawValue(Value, ACanvas, R, ASelected);
 {$ELSE}  
  inherited ListDrawValue(Value, ACanvas, R, ASelected);
 {$ENDIF}  
end;  

procedure TdxPrintStyleImageIndexPropertyEditor.PropDrawValue(ACanvas: TCanvas; 
  const ARect: TRect; ASelected: Boolean);
var
  S: string;
begin
  S := GetVisualValue;
  if (S <> '') and ASelected then 
    ListDrawValue(S, ACanvas, ARect, ASelected)
  else  
 {$IFDEF DELPHI6} 
  DefaultPropertyDrawValue(Self, ACanvas, ARect);
 {$ELSE}  
  inherited PropDrawValue(ACanvas, ARect, ASelected);
 {$ENDIF}  
end;  

{$IFDEF DELPHI6}  

{ ICustomPropertyDrawing }

procedure TdxPrintStyleImageIndexPropertyEditor.PropDrawName(ACanvas: TCanvas; 
  const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;  

{$ENDIF}

{ TdxCustomDrawListPropertyEditor }

procedure TdxCustomDrawListPropertyEditor.ListMeasureWidth(const Value: string; 
  ACanvas: TCanvas; var AWidth: Integer);
var
  W: Integer;  
begin
  W := 1 + ImageList.Width + 1 + 2 + ACanvas.TextWidth(Value) + 2;
  if W > AWidth then AWidth := W;
end;
  
procedure TdxCustomDrawListPropertyEditor.ListMeasureHeight(const Value: string; 
  ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := ImageList.Height + 2;
end;
  
procedure TdxCustomDrawListPropertyEditor.ListDrawValue(const Value: string; 
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  R: TRect;  
begin  
  ACanvas.FillRect(ARect);
  ImageList.Draw(ACanvas, ARect.Left + 1, ARect.Top + 1, ImageIndexes[Value]);
  R := ARect;
  Inc(R.Left, 1 + ImageList.Width + 1);
  ACanvas.TextRect(R, R.Left + 1, R.Top + (R.Bottom - R.Top - ACanvas.TextHeight(Value)) div 2, Value);
end;    

{ TdxPaperOrientationPropertyEditor }

function TdxPaperOrientationPropertyEditor.GetImageIndex(const Value: string): Integer;
begin
  Result := GetEnumValue(TypeInfo(TdxPrinterOrientation), Value);  
end;

function TdxPaperOrientationPropertyEditor.GetImageList: TImageList;
begin
  Result := ilPaperOrientations;
end;

{ TdxPrintOrderPropertyEditor }

function TdxPrintOrderPropertyEditor.GetImageIndex(const Value: string): Integer;
begin
  Result := GetEnumValue(TypeInfo(TdxPageOrder), Value);  
end;

function TdxPrintOrderPropertyEditor.GetImageList: TImageList;
begin
  Result := ilPrintOrders;
end;

{$ENDIF}

{ TdxPathPropertyEditor }

procedure TdxPathPropertyEditor.Edit;
var
  I: Integer;
begin
  if Explorers[0].ShowChangeRootPathDlg then 
    for I := 1 to PropCount - 1 do
      Explorers[I].RootPath := Explorers[0].RootPath;
end;

function TdxPathPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paMultiSelect, paDialog];
end;

function TdxPathPropertyEditor.GetExplorer(Index: Integer): TdxPSFileBasedExplorer;
begin
   Result := TdxPSFileBasedExplorer(GetComponent(Index));
end;

{ TdxRegistryPathPropertyEditor }

procedure TdxRegistryPathPropertyEditor.Edit;
var
  S: string;
begin
  S := Value;
{$IFNDEF LIMITED_EDITION}
  if dxGetRegistryPath(S) then
  begin
    Value := S;
    Designer.Modified;
  end;
 {$ENDIF}
end;

function TdxRegistryPathPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes {$IFNDEF LIMITED_EDITION}+ [paDialog]{$ENDIF};
end;

{ TdxExplorerStubLinkPropertyEditor }
    
procedure TdxExplorerStubLinkPropertyEditor.GetValues(Proc: TGetStrProc);
var
  Links: TList;
  I: Integer;
  Link: TBasedxReportLink;
begin
  Links := TList.Create;
  try
    TdxComponentPrinter(GetComponent(0)).GetLinks(Links);
    for I := 0 to Links.Count - 1 do 
    begin
      Link := TBasedxReportLink(Links[I]);
      if Link.CanBeUsedAsStub then Proc(Link.Name);
    end;  
  finally
    Links.Free;
  end;
end;

{ TdxCustomContainerReportLinkComponentPropertyEditor }

{$IFDEF DELPHI5}

procedure TdxCustomContainerReportLinkComponentPropertyEditor.Initialize;
begin
  inherited;
  dxPSDsgProxies.dxIdeImagesProvider.Refresh;
end;

procedure TdxCustomContainerReportLinkComponentPropertyEditor.ListMeasureWidth(const Value: string; 
  ACanvas: TCanvas; var AWidth: Integer);
var
  W: Integer;  
begin
  W := 1 + Images.Width + 1 + 2 + ACanvas.TextWidth(Value) + 2;
  if W > AWidth then AWidth := W;
end;

procedure TdxCustomContainerReportLinkComponentPropertyEditor.ListMeasureHeight(const Value: string; 
  ACanvas: TCanvas; var AHeight: Integer);
begin
  Aheight := 1 + Images.Height + 1;
end;

procedure TdxCustomContainerReportLinkComponentPropertyEditor.ListDrawValue(const Value: string; 
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  X, Y: Integer;
begin
  ACanvas.FillRect(ARect);
  Images.Draw(ACanvas, ARect.Left + 1, ARect.Top + 1, ImageIndexes[Value]);
  with ARect do 
  begin
    X := Left + 1 + Images.Width + 1 + 2;
    Y := Top + (Bottom - Top - ACanvas.TextHeight(Value)) div 2;
  end;
  ACanvas.Brush.Style := bsClear;
  ACanvas.TextRect(ARect, X, Y, Value);
  ACanvas.Brush.Style := bsSolid;
end;

{$ENDIF}

procedure TdxCustomContainerReportLinkComponentPropertyEditor.GetComponents;
var
  Project: IOTAProject;
  I: Integer;
  ModuleInfo: IOTAModuleInfo;
begin
  inherited GetComponents;
  
  Project := GetProject;
  if Project <> nil then 
    for I := 0 to Project.GetModuleCount - 1 do 
    begin
      ModuleInfo := Project.GetModule(I);
      if IsSupportedModuleType(ModuleInfo.ModuleType) then 
        AddComponent(ModuleInfo.FormName);
    end;
end;

function TdxCustomContainerReportLinkComponentPropertyEditor.GetProject: IOTAProject;
var
  Module: IOTAModule;
  HasMultipleProjects: Boolean;
  I: Integer;
  ProjectGroup: IOTAProjectGroup;
  Project: IOTAProject;
begin
  Result := nil;
  HasMultipleProjects := False;
  with BorlandIDEServices as IOTAModuleServices do 
    for I := 0 to GetModuleCount - 1 do
    begin
      Module := GetModule(I);
      if Supports(Module, IOTAProjectGroup, ProjectGroup) then
      begin
        Result := ProjectGroup.ActiveProject;
        Exit;
      end
      else 
        if Supports(Module, IOTAProject, Project) then
          if Result = nil then
            Result := Project
          else
            HasMultipleProjects := True;
    end;
  if HasMultipleProjects then Result := nil;
end;

function TdxCustomContainerReportLinkComponentPropertyEditor.IsComponentValid(AComponent: TComponent): Boolean;
begin
  Result := inherited IsComponentValid(AComponent) and 
    ((AComponent = nil) or (AComponent = Designer.GetRoot) or (AComponent.Owner = Designer.GetRoot));
end;

function TdxCustomContainerReportLinkComponentPropertyEditor.IsSupportedModuleType(
  const AModuleType: TOTAModuleType): Boolean;
{$IFNDEF DELPHI6}
const
  omtForm = 0;
{$ENDIF}
begin
  Result := AModuleType = omtForm;
end;

{$IFDEF DELPHI5}

function TdxCustomContainerReportLinkComponentPropertyEditor.GetImageIndex(const Value: string): Integer;
begin
  Result := dxPSDsgProxies.dxIdeImagesProvider.ImageIndexesByObject[Designer.GetObject(Value)];
end;

function TdxCustomContainerReportLinkComponentPropertyEditor.GetImages: TCustomImageList;
begin
  Result := dxPSDsgProxies.dxIdeImagesProvider.Images;
end;

{$ENDIF}

{ TdxMeasurementUnitsPropertyEditor }

procedure TdxMeasurementUnitsPropertyEditor.GetValues(Proc: TGetStrProc);

  function DropPrefix(const Source: string): string;
  const
    Prefix: string = 'mu';
  var
    P: Integer;
  begin
    Result := Source;
    P := Pos(Result, Prefix);
    if P <> 0 then
      Delete(Result, P, Length(Prefix));
  end;

const
  Default: string = 'muDefault';
var
  EnumType: PTypeInfo;
  I: Integer;
  EnumName, S: string;
begin
  EnumType := GetPropType;
  with GetTypeData(EnumType)^ do
    for I := MinValue to MaxValue do
    begin
      EnumName := GetEnumName(EnumType, I);
      if CompareStr(EnumName, Default) = 0 then
      begin 
        S := GetEnumName(TypeInfo(TdxMeasurementUnits), Integer(GetDefaultMeasurementUnits));
        EnumName := EnumName + ' (' + DropPrefix(S) + ')';
      end;
      Proc(EnumName);
    end;
end;
                                        
function TdxMeasurementUnitsPropertyEditor.GetValue: string;
begin
  Result := inherited GetValue + ' ' + sdxInThousandths;
end;

procedure TdxMeasurementUnitsPropertyEditor.SetValue(const Value: string);

  function IsDefaultMeasurementUnitsValue: Boolean;
  var
    DefaultEnumName: string;
  begin
    DefaultEnumName := GetEnumName(TypeInfo(TdxMeasurementUnits), Integer(muDefault));
    Result := Pos(DefaultEnumName, Value) <> 0;
  end;
  
begin
  if IsDefaultMeasurementUnitsValue then
    SetOrdValue(Integer(muDefault))
  else
    inherited;
end;

{ TdxPrinterPagePropertyEditor }

procedure TdxPrinterPagePropertyEditor.Edit;
var
  ReportLink: TBasedxReportLink;
  I: Integer;
begin
  ReportLink := TBasedxReportLink(GetComponent(0));
  if ReportLink.PageSetup then
  begin
    if PropCount > 1 then
      for I := 1 to PropCount - 1 do
        TBasedxReportLink(GetComponent(I)).PrinterPage.Assign(ReportLink.PrinterPage);
    Designer.Modified;
  end;
end;

function TdxPrinterPagePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TdxReportTitlePropertyEditor }

procedure TdxReportTitlePropertyEditor.Edit; 
var
  ReportLink: TBasedxReportLink;
  I: Integer;
begin
  ReportLink := TBasedxReportLink(GetComponent(0));
  if ReportLink.ShowTitlePropertiesDlg then
  begin
    if PropCount > 1 then
      for I := 1 to PropCount - 1 do
        TBasedxReportLink(GetComponent(I)).ReportTitle.Assign(ReportLink.ReportTitle);
    Designer.Modified;
  end;
end;

function TdxReportTitlePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TdxReportTitleTextAlignXPropertyEditor }

procedure TdxReportTitleTextAlignXPropertyEditor.GetValues(Proc: TGetStrProc);
var
  EnumType: PTypeInfo;
  I: Integer;
begin
  EnumType := GetPropType;
  for I := Integer(taLeft) to Integer(taRight) do 
    Proc(GetEnumName(EnumType, I));
end;

procedure TdxReportTitleTextAlignXPropertyEditor.SetValue(const Value: string);
var
  I: Integer;
begin
  I := GetEnumValue(GetPropType, Value);
  if not (TcxTextAlignX(I) in [taLeft, taCenterX, taRight]) then
    {$IFDEF DELPHI5}
      raise EPropertyError.CreateRes(@SInvalidPropertyValue);
    {$ELSE}
      raise EPropertyError.Create(SInvalidPropertyValue);
    {$ENDIF} 
  SetOrdValue(I);
end;

{ TdxReportTitleTextAlignYPropertyEditor }

procedure TdxReportTitleTextAlignYPropertyEditor.GetValues(Proc: TGetStrProc);
var
  EnumType: PTypeInfo;
  I: Integer;
begin
  EnumType := GetPropType;
  for I := Integer(taTop) to Integer(taBottom) do
    Proc(GetEnumName(EnumType, I));
end;

procedure TdxReportTitleTextAlignYPropertyEditor.SetValue(const Value: string);
var
  I: Integer;
begin
  I := GetEnumValue(GetPropType, Value);
  if not (TcxTextAlignY(I) in [taTop, taCenterY, taBottom]) then
    {$IFDEF DELPHI5}
      raise EPropertyError.CreateRes(@SInvalidPropertyValue);
    {$ELSE}
      raise EPropertyError.Create(SInvalidPropertyValue);
    {$ENDIF} 
  SetOrdValue(I);
end;

{ TdxHeaderFooterTextAlignYPropertyEditor }

procedure TdxHeaderFooterTextAlignYPropertyEditor.GetValues(Proc: TGetStrProc);
var
  EnumType: PTypeInfo;
  I: Integer;
begin
  EnumType := GetPropType;
  for I := Integer(taTop) to Integer(taBottom) do
    Proc(GetEnumName(EnumType, I));
end;

procedure TdxHeaderFooterTextAlignYPropertyEditor.SetValue(const Value: string);
var
  I: Integer;
begin
  I := GetEnumValue(GetPropType, Value);
  if not (TcxTextAlignY(I) in [taTop, taCenterY, taBottom]) then
    {$IFDEF DELPHI5}
      raise EPropertyError.CreateRes(@SInvalidPropertyValue);
    {$ELSE}
      raise EPropertyError.Create(SInvalidPropertyValue);
    {$ENDIF} 
  SetOrdValue(I);
end;

{ TdxPrinterPagePropertyEditor2 }

procedure TdxPrinterPagePropertyEditor2.Edit;
var
  I: Integer;
  PrintStyle: TBasedxPrintStyle;
begin
  PrintStyle := TBasedxPrintStyle(GetComponent(0));
  if PrintStyle.PageSetup then
  begin
    if PropCount > 1 then
      for I := 1 to PropCount - 1 do
        TBasedxPrintStyle(GetComponent(I)).PrinterPage.Assign(PrintStyle.PrinterPage);
    Designer.Modified;
  end;
end;

function TdxPrinterPagePropertyEditor2.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TdxPointWrapperEditor }

function TdxPointWrapperEditor.PointWrapper: TdxPointWrapper;
begin
  Result := TdxPointWrapper(GetOrdValue);
end;

function TdxPointWrapperEditor.GetValue: string;
var
  Pt: TdxPointWrapper;
begin
  Pt := PointWrapper;
  if Pt <> nil then
    with Pt do 
      Result := Format('(X: %d; Y: %d)', [X, Y])
  else
    Result := inherited GetValue;
end;

{ TdxRectWrapperEditor }
                                 
function TdxRectWrapperEditor.RectWrapper: TdxRectWrapper;
begin
  Result := TdxRectWrapper(GetOrdValue);
end;

function TdxRectWrapperEditor.GetValue: string;
var
  R: TdxRectWrapper;
begin
  R := RectWrapper;
  if R <> nil then
    with R do
      Result := Format('(Bottom: %d; Left: %d; Right: %d; Top: %d)', [Bottom, Left, Right, Top])
  else
    Result := inherited GetValue;
end;

{ TdxBackgroundPropertyEditor }

procedure TdxBackgroundPropertyEditor.Edit;
var
  I: Integer;
begin
  if Background.SetupEffects then 
  begin
    for I := 1 to PropCount - 1 do
      TdxBackground(GetOrdValueAt(I)).Assign(Background);
    Designer.Modified;
  end;    
end;

function TdxBackgroundPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

function TdxBackgroundPropertyEditor.GetBackground: TdxBackground;
begin
  Result := TdxBackground(GetOrdValueAt(0));
end;

{ TdxBrushPropertyEditor }

procedure TdxBrushPropertyEditor.Edit;
var
  I: Integer;
begin
  if ChooseBrush(Brush) then
  begin
    for I := 1 to PropCount - 1 do
      TBrush(GetOrdValueAt(I)).Assign(Brush);
    Designer.Modified;
  end;
end;

function TdxBrushPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

function TdxBrushPropertyEditor.GetBrush: TBrush;
begin
  Result := TBrush(GetOrdValue);
end;

{ TTTFontPropertyEditor }

procedure TTTFontPropertyEditor.Edit;
const
  hcDFontEditor = 25000;
var
  FontDialog: TFontDialog;
begin
  FontDialog := TFontDialog.Create(Application);
  try
    FontDialog.Font := TFont(GetOrdValue);
    FontDialog.Device := dxPSGlbl.FontDialogDevice;
    FontDialog.HelpContext := hcDFontEditor;
    FontDialog.Options := [fdEffects, fdScalableOnly, fdTrueTypeOnly];
    if FontDialog.Execute then
      SetOrdValue(Longint(FontDialog.Font));
  finally
    FontDialog.Free;
  end;
end;

{ TdxPrintStyleManagerEditor  }

procedure TdxPrintStyleManagerEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: dxShowPrintStylesDesigner(TdxPrintStyleManager(Component), Designer);
    3: TryStartWEBPage(sdxWEBPage);
  end;     
end;

function TdxPrintStyleManagerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := sdxPrintStyles;
    1: Result := '-';
    2: Result := sdxPrintingSystem;
    3: Result := sdxWEBPage;
    4: Result := sdxDevex;
  end
end;

function TdxPrintStyleManagerEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 5;
end;

{$IFDEF IDE_MENUBITMAPS}
procedure TdxPrintStyleManagerEditor.PrepareItem(Index: Integer; const AItem: TMenuItem);
begin
  case Index of
    0: AItem.Bitmap := FBmpItems;
    3: AItem.Bitmap := FBmpWEB;
  end
end;
{$ENDIF}

{ TdxPrintStyleEditor }

function TdxPrintStyleEditor.PrintStyle: TBasedxPrintStyle;
begin
  Result := TBasedxPrintStyle(Component);
end;

procedure TdxPrintStyleEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: 
      if PrintStyle.PageSetup then Designer.Modified;    
    1:
      begin 
        PrintStyle.IsCurrentStyle := True;
        Designer.Modified;
      end;  
    3:begin 
        PrintStyle.RestoreDefaults;
        Designer.Modified;
      end;  
    5: 
       if PrintStyle.PrinterPage.Background.SetupEffects then 
         Designer.Modified;        
    6: 
      begin
        PrintStyle.PrinterPage.Background.Mode := bmNone;
        PrintStyle.PrinterPage.Background.Picture := nil;        
        Designer.Modified;
      end;  
  end;
end;

function TdxPrintStyleEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := sdxPageSetup;
    1: Result := sdxMakeCurrent;
    2: Result := '-';
    3: Result := sdxRestoreDefaults;
    4: Result := '-';
    5: Result := sdxPageBackground;    
    6: Result := sdxClearBackground;
  end;
end;

function TdxPrintStyleEditor.GetVerbCount: Integer;
begin
  Result := 7;
end;

{$IFDEF DELPHI5}
procedure TdxPrintStyleEditor.PrepareItem(Index: Integer; 
  const AItem: {$IFDEF DELPHI6} IMenuItem {$ELSE} TMenuItem{$ENDIF});
begin
  case Index of
   {$IFDEF IDE_MENUBITMAPS}  
    0: AItem.Bitmap := FBmpPageSetup;
   {$ENDIF}
    1: AItem.Enabled := not TBasedxPrintStyle(Component).IsCurrentStyle;
   {$IFDEF IDE_MENUBITMAPS}  
    5: AItem.Bitmap := FBmpPageBackground;      
   {$ENDIF}    
  end;
end;
{$ENDIF}

{ TdxPageSetupDialogEditor }

procedure TdxPageSetupDialogEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: TdxPageSetupDialog(Component).Execute;
    3: TryStartWEBPage(sdxWEBPage);
  end;
end;

function TdxPageSetupDialogEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := sdxPageSetupDialog;
    1: Result := '-';
    2: Result := sdxPrintingSystem;
    3: Result := sdxWEBPage;
    4: Result := sdxDevex;
  end;
end;

function TdxPageSetupDialogEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 5;
end;

{$IFDEF DELPHI5}  
procedure TdxPageSetupDialogEditor.PrepareItem(Index: Integer; 
  const AItem: {$IFDEF DELPHI6} IMenuItem {$ELSE} TMenuItem{$ENDIF});
begin
  case Index of
    0:
      begin
       {$IFDEF IDE_MENUBITMAPS}      
        AItem.Bitmap := FBmpPageSetup;
       {$ENDIF}
        AItem.Enabled := TdxPageSetupDialog(Component).PrintStyle <> nil;
      end;
    3: 
     {$IFDEF IDE_MENUBITMAPS} 
      AItem.Bitmap := FBmpWEB; 
     {$ENDIF}
  end;
end;
{$ENDIF}

{ TdxPrintDialogEditor }

procedure TdxPrintDialogEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: TdxPrintDialog(Component).Execute;
    3: TryStartWEBPage(sdxWEBPage);
  end;
end;

function TdxPrintDialogEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := sdxPrintDialog;
    1: Result := '-';
    2: Result := sdxPrintingSystem;
    3: Result := sdxWEBPage;
    4: Result := sdxDevex;
  end;
end;

function TdxPrintDialogEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 5;
end;

{$IFDEF IDE_MENUBITMAPS}
procedure TdxPrintDialogEditor.PrepareItem(Index: Integer; const AItem: TMenuItem);
begin
  case Index of
    0: AItem.Bitmap := FBmpPrint;
    3: AItem.Bitmap := FBmpWEB;
  end;
end;
{$ENDIF}

{ TCustomdxPSExplorerEditor }

procedure TCustomdxPSExplorerEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 1 then TryStartWEBPage(sdxWEBPage);
end;

function TCustomdxPSExplorerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := sdxPrintingSystem;
    1: Result := sdxWEBPage;
    2: Result := sdxDevex;
  end;
end;

function TCustomdxPSExplorerEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 3;
end;

{$IFDEF IDE_MENUBITMAPS}
procedure TCustomdxPSExplorerEditor.PrepareItem(Index: Integer; const AItem: TMenuItem);
begin
  if Index = 1 then
    AItem.Bitmap := FBmpWEB;
end;
{$ENDIF}

{ TdxEngineControllerEditor }

procedure TdxEngineControllerEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 1 then TryStartWEBPage(sdxWEBPage);
end;

function TdxEngineControllerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := sdxPrintingSystem;
    1: Result := sdxWEBPage;
    2: Result := sdxDevex;
  end;
end;

function TdxEngineControllerEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 3;
end;

{$IFDEF IDE_MENUBITMAPS}
procedure TdxEngineControllerEditor.PrepareItem(Index: Integer; const AItem: TMenuItem); 
begin
  if Index = 1 then AItem.Bitmap := FBmpWEB;
end;
{$ENDIF}
  
{ TdxShowPgsDlgPropertyEditor }

procedure TdxShowPgsDlgPropertyEditor.Edit;
begin
  if TBasedxPrintStyle(GetComponent(0)).PageSetup then
    Designer.Modified;
end;

function TdxShowPgsDlgPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TdxShowPgsDlgPropertyEditor.GetValue: string;
begin
  Result := sdxClickForPageSetup;
end;

{ TdxStyleGlyphPropertyEditor }

function TdxStyleGlyphPropertyEditor.GetValue: string;
begin
  Result := inherited GetValue;
  if PrintStyle.IsStyleGlyphAssigned then
    Result := Result + ' - ' + sdxRestoreDefaultGlyph;
end;

procedure TdxStyleGlyphPropertyEditor.SetValue(const Value: string);
begin
  if CompareText(Value, sdxDefault) = 0 then
    PrintStyle.RestoreDefaultGlyph
  else
    inherited;
end;

function TdxStyleGlyphPropertyEditor.GetPrintStyle: TBasedxPrintStyle;
begin
  Result := TBasedxPrintStyle(GetComponent(0));
end;

{ TdxCustomListDrawingIntegerPropertyEditor }

{$IFDEF DELPHI5}

procedure TdxCustomListDrawingIntegerPropertyEditor.ListMeasureWidth(const Value: string; 
  ACanvas: TCanvas; var AWidth: Integer);
var
  W: Integer;  
begin
  W := 1 + ImageList.Width + 1 + 2 + ACanvas.TextWidth(Value) + 2;
  if W > AWidth then AWidth := W;
end;
  
procedure TdxCustomListDrawingIntegerPropertyEditor.ListMeasureHeight(const Value: string; 
  ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := ImageList.Height + 2;
end;
  
procedure TdxCustomListDrawingIntegerPropertyEditor.ListDrawValue(const Value: string; 
  ACanvas: TCanvas;  const ARect: TRect; ASelected: Boolean);
var
  R: TRect;  
begin  
  ACanvas.FillRect(ARect);
  ImageList.Draw(ACanvas, ARect.Left + 1, ARect.Top + 1, ImageIndexes[Value]);
  R := ARect;
  Inc(R.Left, 1 + ImageList.Width + 1);
  ACanvas.TextRect(R, R.Left + 1, R.Top + (R.Bottom - R.Top - ACanvas.TextHeight(Value)) div 2, Value);
end;    

{$ENDIF}

{ TdxDMPaperPropertyEditor }

function TdxDMPaperPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [{$IFNDEF DELPHI6}paReadOnly,{$ENDIF} paDialog, paValueList];
end;

function TdxDMPaperPropertyEditor.GetValue: string;
var
  Index: Integer;
begin
  Index := dxPPAttr.Papers.FindByDMPaper(GetOrdValue);
  if Index <> -1 then
    Result := dxPPAttr.Papers[Index].Name
  else
    Result := sdxCustomPaperSize + IntToStr(GetOrdValue);
end;

procedure TdxDMPaperPropertyEditor.SetValue(const Value: string);
var
  Index: Integer;
begin
  Index := dxPPAttr.Papers.FindByName(Value);
  if Index <> -1 then
    SetOrdValue(dxPPAttr.Papers[Index].DMPaper)
  else
    inherited SetValue(Value);
end;

procedure TdxDMPaperPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to dxPPAttr.Papers.Count - 1 do
    Proc(dxPPAttr.Papers[I].Name);
end;

{$IFDEF DELPHI5}  

function TdxDMPaperPropertyEditor.GetImageIndex(const Value: string): Integer;
begin
  Result := Integer(dxIsEnvelopePaper(Value));
end;

function TdxDMPaperPropertyEditor.GetImageList: TImageList;
begin
  Result := ilPapers;
end;

{$ENDIF}

{ TdxPaperSourcePropertyEditor }

function TdxPaperSourcePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [{$IFNDEF DELPHI6}paReadOnly,{$ENDIF} paDialog, paValueList];
end;

function TdxPaperSourcePropertyEditor.GetValue: string;
var
  Index: Integer;
begin
  Index := dxPPAttr.Bins.FindByValue(GetOrdValue);
  if Index <> -1 then
    Result := dxPPAttr.Bins[Index].Name
  else
    Result := sdxCustomBin + IntToStr(GetOrdValue);
end;

procedure TdxPaperSourcePropertyEditor.SetValue(const Value: string);
var
  Index: Integer;
begin
  Index := dxPPAttr.Bins.FindByName(Value);
  if Index <> -1 then
    SetOrdValue(dxPPAttr.Bins[Index].Value)
  else
    inherited SetValue(Value);
end;

procedure TdxPaperSourcePropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to dxPPAttr.Bins.Count - 1 do
    Proc(dxPPAttr.Bins[I].Name);
end;

{$IFDEF DELPHI5}  

function TdxPaperSourcePropertyEditor.GetImageIndex(const Value: string): Integer;
begin
  Result := Integer(not dxIsAutoSelectBin(Value));
end;

function TdxPaperSourcePropertyEditor.GetImageList: TImageList;
begin
  Result := ilBins;
end;

{$ENDIF}

{ TdxPageNumberFormatEditor }

function TdxPageNumberFormatsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [{$IFNDEF DELPHI6}paReadOnly, {$ENDIF} paDialog, paValueList];
end;

function TdxPageNumberFormatsPropertyEditor.GetValue: string;
begin
  Result := PageNumberFormats[GetOrdValue];
end;

procedure TdxPageNumberFormatsPropertyEditor.SetValue(const Value: string);
var
  I: Integer;
begin
  // case insensitive - PageNumberFormats.IndexOf(Value);
  for I := 0 to PageNumberFormats.Count - 1 do
    if dxSameStr(PageNumberFormats[I], Value) then
    begin
      SetOrdValue(I);
      Exit;
    end;
  inherited SetValue(Value);
end;

procedure TdxPageNumberFormatsPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to PageNumberFormats.Count - 1 do
    Proc(PageNumberFormats[I]);
end;

{ TdxReportLinkStyleManagerPropertyEditor }

{$IFDEF DELPHI5}
function TdxReportLinkStyleManagerPropertyEditor.AutoFill: Boolean;
begin
  Result := False;
end;
{$ELSE}
procedure TdxReportLinkStyleManagerPropertyEditor.Edit;
begin
end;
{$ENDIF}

procedure TdxReportLinkStyleManagerPropertyEditor.GetValues(Proc: TGetStrProc);
begin
  if CanCreateStyleManager then Proc(sdxCreateNewStyleManager);
  inherited;
end;

procedure TdxReportLinkStyleManagerPropertyEditor.SetValue(const Value: string);
begin
  if Value = sdxCreateNewStyleManager then
    SetOrdValue(Integer(CreateNewStyleManager))
  else
    inherited;
end;

function TdxReportLinkStyleManagerPropertyEditor.CanCreateStyleManager: Boolean;
begin
 {$IFDEF DELPHI5}
  Result := (Root <> nil) and not Designer.IsSourceReadOnly and not (csInline in Root.ComponentState);
 {$ELSE}
  Result := True;
 {$ENDIF}
end;

function TdxReportLinkStyleManagerPropertyEditor.CreateNewStyleManager: TdxPrintStyleManager;
begin
  Result := TdxPrintStyleManager.Create(Root);
  Result.Name := UniqueName;
end;

function TdxReportLinkStyleManagerPropertyEditor.GetUniqueName: string;
var
  S: string;
begin
  S := TdxPrintStyleManager.ClassName;
  S := Copy(S, 2, Length(S) - 1);
  Result := Designer.UniqueName(S);
end;

function TdxReportLinkStyleManagerPropertyEditor.GetRoot: TComponent;
begin
  Result := Designer.{$IFDEF DELPHI6}Root{$ELSE}GetRoot{$ENDIF};
end;

{ TdxReportDocumentDescriptionPropertyEditor }
                                                          
procedure TdxReportDocumentDescriptionPropertyEditor.Edit;
var
  S: string;
begin
  S := Value;
  if dxPSfmEditDesc.dxEditDescriptionDlg(S) then
  begin
    Value := S;
    Designer.Modified;
  end;  
end;

function TdxReportDocumentDescriptionPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{ TdxDateFormatEditor }

procedure TdxDateFormatsPropertyEditor.Initialize;
begin
  inherited Initialize;
  FStrings := TStringList.Create;
  GetFormatedDateStrings(Now, DateFormats, FStrings);
end;

destructor TdxDateFormatsPropertyEditor.Destroy;
begin
  FStrings.Free;
  inherited Destroy;
end;

function TdxDateFormatsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [{$IFNDEF DELPHI6}paReadOnly, {$ENDIF} paDialog, paValueList];
end;

function TdxDateFormatsPropertyEditor.GetValue: string;
begin
  Result := FStrings[GetOrdValue];
end;

procedure TdxDateFormatsPropertyEditor.SetValue(const Value: string);
var
  Index: Integer;
begin
  Index := FStrings.IndexOf(Value);
  if Index <> -1 then
    SetOrdValue(Index)
  else
    inherited SetValue(Value);
end;

procedure TdxDateFormatsPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to FStrings.Count - 1 do
    Proc(FStrings[I]);
end;

{ TdxTimeFormatEditor }

procedure TdxTimeFormatsPropertyEditor.Initialize;
begin
  inherited Initialize;
  FStrings := TStringList.Create;
  GetFormatedTimeStrings(Now, TimeFormats, FStrings);
end;

destructor TdxTimeFormatsPropertyEditor.Destroy;
begin
  FStrings.Free;
  inherited Destroy;
end;

function TdxTimeFormatsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [{$IFNDEF DELPHI6}paReadOnly, {$ENDIF} paDialog, paValueList];
end;

function TdxTimeFormatsPropertyEditor.GetValue: string;
begin
  Result := FStrings[GetOrdValue];
end;

procedure TdxTimeFormatsPropertyEditor.SetValue(const Value: string);
var
  Index: Integer;
begin
  Index := FStrings.IndexOf(Value);
  if Index <> -1 then
    SetOrdValue(Index)
  else
    inherited SetValue(Value);
end;

procedure TdxTimeFormatsPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to FStrings.Count - 1 do
    Proc(FStrings[I]);
end;

{ TdxAutoHFTextEntriesPropertyEditor }

procedure TdxAutoHFTextEntriesPropertyEditor.Edit;
begin
  TdxPrintStyleManager(GetComponent(0)).ShowAutoHFTextEntriesDlg;
end;

function TdxAutoHFTextEntriesPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly, paDialog];
end;

{ TdxPreviewIconPropertyEditor }

function TdxPreviewIconPropertyEditor.GetValue: string;
begin
  Result := inherited GetValue;
  if PreviewOptions.IsIconAssigned then 
    Result := Result + ' - ' + sdxRestoreDefaultIcon;
end;

procedure TdxPreviewIconPropertyEditor.SetValue(const Value: string);
begin
  if CompareText(Value, sdxDefault) = 0 then
    PreviewOptions.RestoreOriginalIcon
  else
    inherited;
end;

function TdxPreviewIconPropertyEditor.GetPreviewOptions: TdxPreviewOptions;
begin
  Result := TdxPreviewOptions(GetComponent(0));
end;

{ TdxTextReportLinkAlignmentPropertyEditor }

procedure TdxTextReportLinkAlignmentPropertyEditor.GetValues(Proc: TGetStrProc);
var
  EnumType: PTypeInfo;
begin
  EnumType := GetPropType;
  Proc(GetEnumName(EnumType, Integer(taLeft)));
  Proc(GetEnumName(EnumType, Integer(taCenterX)));
  Proc(GetEnumName(EnumType, Integer(taRight)));
  Proc(GetEnumName(EnumType, Integer(taDistributeX)));
end;

{$IFDEF DELPHI6}

{ TdxComponentPrinterSelectionEditor }

procedure TdxComponentPrinterSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('dxPSGlbl');
  Proc('dxPSUtl');
  Proc('dxPSEngn');
  Proc('dxPrnPg'); 
  Proc('dxBkgnd');
  Proc('dxWrap');
  Proc('dxPrnDev');
  Proc('dxPSCompsProvider');
  Proc('dxPSFillPatterns');
  Proc('dxPSEdgePatterns');
end;  

{ TdxPrintStyleManagerSelectionEditor }

procedure TdxPrintStyleManagerSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('dxPSGlbl');
  Proc('dxPSUtl');
  Proc('dxPrnPg');
  Proc('dxBkgnd');
  Proc('dxWrap');  
  Proc('dxPrnDev');
end;  

{ TdxPageSetupDialogSelectionEditor }

procedure TdxPageSetupDialogSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('dxPSGlbl');
  Proc('dxPSUtl');
  Proc('dxPrnPg');  
  Proc('dxBkgnd');
  Proc('dxWrap');
end;  

{ TdxPrintDialogSelectionEditor }

procedure TdxPrintDialogSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('dxPrnDev');
end;  

{$ENDIF}

procedure HideProperty(PropertyType: PTypeInfo;
  ComponentClass: TClass; const PropertyName: string);
begin
  RegisterPropertyEditor(PropertyType, ComponentClass, PropertyName, nil);  
end;

procedure Register;
begin
  dxPSGlbl.IsDesignTime := True;
  
  RegisterComponents(sdxPSComponentPage, 
    [TdxComponentPrinter, TdxPrintStyleManager, 
     TdxPrintDialog, TdxPageSetupDialog, 
     TdxPSEngineController, TdxPSFileBasedExplorer]);
    
  RegisterNoIcon([TBasedxReportLink, TdxCompositionReportLink, TdxCustomContainerReportLink]);
  RegisterNoIcon([TdxPictureReportLink, TdxTextReportLink]);
  RegisterNoIcon([TBasedxPrintStyle, TdxPSPrintStyle]);

  RegisterComponentEditor(TdxComponentPrinter, TdxComponentPrinterEditor);
  RegisterComponentEditor(TdxPrintStyleManager, TdxPrintStyleManagerEditor);
  RegisterComponentEditor(TBasedxReportLink, TdxReportLinkEditor);
  RegisterComponentEditor(TBasedxPrintStyle, TdxPrintStyleEditor);  
  RegisterComponentEditor(TdxPageSetupDialog, TdxPageSetupDialogEditor);
  RegisterComponentEditor(TdxPrintDialog, TdxPrintDialogEditor);
  RegisterComponentEditor(TCustomdxPSExplorer, TCustomdxPSExplorerEditor);
  RegisterComponentEditor(TdxPSEngineController, TdxEngineControllerEditor);

  RegisterPropertyEditor(TypeInfo(string), TdxPSFileBasedExplorer, 'RootPath', TdxPathPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TdxComponentPrinter, 'DateFormat', TdxDateFormatsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TdxComponentPrinter, 'TimeFormat', TdxTimeFormatsPropertyEditor);  
  RegisterPropertyEditor(TypeInfo(TIcon), TdxPreviewOptions, 'Icon', TdxPreviewIconPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxPageNumberFormat), TdxComponentPrinter, 'PageNumberFormat', TdxPageNumberFormatsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TdxComponentPrinter, 'RegistryPath', TdxRegistryPathPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TBasedxReportLink), TdxComponentPrinter, 'ExplorerStubLink', TdxExplorerStubLinkPropertyEditor);
  
  RegisterPropertyEditor(TypeInfo(TComponent), TBasedxReportLink, 'Component', TdxReportLinkComponentPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TComponent), TdxCustomContainerReportLink, 'Component', TdxCustomContainerReportLinkComponentPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TBasedxReportLink, 'Index', TdxIndexPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Boolean), TBasedxReportLink, 'ShowDesigner', TdxReportLinkDesignerPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxPrinterPage), TBasedxReportLink, 'PrinterPage', TdxPrinterPagePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxReportTitle), TBasedxReportLink, 'ReportTitle', TdxReportTitlePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TFont), TBasedxReportLink, '', TTTFontPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TBasedxReportLink, 'DateFormat', TdxDateFormatsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TBasedxReportLink, 'TimeFormat', TdxTimeFormatsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxPageNumberFormat), TBasedxReportLink, 'PageNumberFormat', TdxPageNumberFormatsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxPrintStyleManager), TBasedxReportLink, 'StyleManager', TdxReportLinkStyleManagerPropertyEditor);

  RegisterPropertyEditor(TypeInfo(string), TdxPSReportDocument, 'Description', TdxReportDocumentDescriptionPropertyEditor);

 {$IFDEF DELPHI5}
  RegisterPropertyEditor(TypeInfo(Integer), TBasedxPrintStyle, 'ImageIndex',  TdxPrintStyleImageIndexPropertyEditor);
 {$ENDIF}  
  RegisterPropertyEditor(TypeInfo(string), TCustomdxPSExplorer, 'FilterLink',  TdxPSExplorerFilterPropertyEditor);
 
 {$IFDEF DELPHI5}  
  RegisterPropertyEditor(TypeInfo(TdxPrinterOrientation), nil, '', TdxPaperOrientationPropertyEditor);  
  RegisterPropertyEditor(TypeInfo(TdxPageOrder), nil, '', TdxPrintOrderPropertyEditor);
 {$ENDIF}

  RegisterPropertyEditor(TypeInfo(TComponent), TdxCompositionLinkItem, 'ReportLink', TdxCompositionReportLinkPropertyEditor);

  RegisterPropertyEditor(TypeInfo(TStrings), TdxPrintStyleManager, 'AutoHFTextEntries', TdxAutoHFTextEntriesPropertyEditor);

  RegisterPropertyEditor(TypeInfo(Boolean), TBasedxPrintStyle, 'ShowPageSetupDlg', TdxShowPgsDlgPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxPrinterPage), TBasedxPrintStyle, 'PrinterPage', TdxPrinterPagePropertyEditor2);
  RegisterPropertyEditor(TypeInfo(Integer), TBasedxPrintStyle, 'Index', TdxIndexPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TBitmap), TBasedxPrintStyle, 'StyleGlyph', TdxStyleGlyphPropertyEditor);

  RegisterPropertyEditor(TypeInfo(Integer), TdxPrinterPage, 'DMPaper', TdxDMPaperPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TdxPrinterPage, 'PaperSource', TdxPaperSourcePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxMeasurementUnits), TdxPrinterPage, 'MeasurementUnits', TdxMeasurementUnitsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TcxTextAlignY), TCustomdxPageObject, '', TdxHeaderFooterTextAlignYPropertyEditor);

  RegisterPropertyEditor(TypeInfo(TcxTextAlignX), TdxReportTitle, 'TextAlignX', TdxReportTitleTextAlignXPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TcxTextAlignY), TdxReportTitle, 'TextAlignY', TdxReportTitleTextAlignYPropertyEditor);

  RegisterPropertyEditor(TypeInfo(TdxBackground), nil, '', TdxBackgroundPropertyEditor);    
    
  RegisterPropertyEditor(TypeInfo(TdxPointWrapper), nil, '', TdxPointWrapperEditor);
  RegisterPropertyEditor(TypeInfo(TdxRectWrapper), nil, '', TdxRectWrapperEditor);
  
  RegisterPropertyEditor(TypeInfo(string), TdxPSEngineController, 'RegistryPath', TdxRegistryPathPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TdxPageSetupDialog, 'RegistryPath', TdxRegistryPathPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TdxPrintDialog, 'RegistryPath', TdxRegistryPathPropertyEditor);
  
  RegisterPropertyEditor(TypeInfo(TBrush), nil, '', TdxBrushPropertyEditor);
  
  RegisterPropertyEditor(TypeInfo(TcxTextAlignX), TdxCustomTextReportLink, 'Alignment', TdxTextReportLinkAlignmentPropertyEditor);
  
 {$IFDEF DELPHI6}
  RegisterSelectionEditor(TCustomdxComponentPrinter, TdxComponentPrinterSelectionEditor); 
  RegisterSelectionEditor(TdxPrintStyleManager, TdxPrintStyleManagerSelectionEditor);
  RegisterSelectionEditor(TdxPageSetupDialog, TdxPageSetupDialogSelectionEditor);
  RegisterSelectionEditor(TdxPrintDialog, TdxPrintDialogSelectionEditor);
 {$ENDIF}                      

  // hide unneeded property editors
  HideProperty(TypeInfo(string), TdxPreviewOptions, 'HelpFile');
  HideProperty(TypeInfo(string), TdxPreviewOptions, 'RegistryPath');
  HideProperty(TypeInfo(Boolean), TdxPreviewOptions, 'SavePosition');
  HideProperty(TypeInfo(string), TBasedxReportLink, 'ReportTitleText');
  HideProperty(TypeInfo(string), TBasedxReportLink, 'Caption');  
  HideProperty(TypeInfo(TDateTime), TBasedxReportLink, 'DateTime');
  HideProperty(TypeInfo(string), TBasedxReportLink, 'Description');
  HideProperty(TypeInfo(TdxReportTitleMode), TBasedxReportLink, 'ReportTitleMode');
  
  HideProperty(TypeInfo(TComponent), TdxCompositionReportLink, 'Component');
  HideProperty(TypeInfo(TdxReportTitle), TdxCompositionReportLink, 'ReportTitle');  
  HideProperty(TypeInfo(TNotifyEvent), TdxCompositionReportLink, 'OnChangeComponent');
  HideProperty(TypeInfo(TdxCustomDrawReportLinkHFEvent), TdxCompositionReportLink, 'OnCustomDrawPageFooter');
  HideProperty(TypeInfo(TdxCustomDrawReportLinkHFEvent), TdxCompositionReportLink, 'OnCustomDrawPageHeader');  
  HideProperty(TypeInfo(TdxCustomDrawReportLinkTitleEvent), TdxCompositionReportLink, 'OnCustomDrawReportLinkTitle');
  HideProperty(TypeInfo(TdxMeasureReportLinkTitleEvent), TdxCompositionReportLink, 'OnMeasureReportLinkTitle');  
  
//  HideProperty(TypeInfo(TComponent), TdxCustomReportLink, 'Component');
//  HideProperty(TypeInfo(TNotifyEvent), TdxCustomReportLink, 'OnChangeComponent');
  
  HideProperty(TypeInfo(TComponent), TdxPictureReportLink, 'Component');
  HideProperty(TypeInfo(TNotifyEvent), TdxPictureReportLink, 'OnChangeComponent');

  HideProperty(TypeInfo(TComponent), TdxTextReportLink, 'Component');
  HideProperty(TypeInfo(TNotifyEvent), TdxTextReportLink, 'OnChangeComponent');
end;

const 
  ResFileName: string = 'dxPSDsgImgs';

{$IFDEF IDE_MENUBITMAPS}

function LoadBitmap(const AResName: string): TBitmap;
begin
  Result := TBitmap.Create;
  Result.LoadFromResourceName(HInstance, AResName);
  //Bitmap_LoadFromResourceName(Result, AResName, ResFileName);
  Result.Transparent := True;
end;

{$ENDIF}

{$IFDEF DELPHI5}

function CreateImageList(AnAllocBy: Integer): TImageList;
begin
  Result := TImageList.Create(nil);
  Result.AllocBy := AnAllocBy;
end;

procedure LoadImage(AImageList: TImageList; const AResName: string; AMasked: Boolean);
var
  Bitmap: TBitmap;
begin                       
  Bitmap := TBitmap.Create;
  try
    Bitmap.LoadFromResourceName(FindResourceHInstance(hInstance), AResName);
    //Bitmap_LoadFromResourceName(Bitmap, AResName, ResFileName);
    AImageList.Height := Bitmap.Height;
    AImageList.Width := Bitmap.Width;    
    if AMasked then 
      AImageList.AddMasked(Bitmap, clDefault)
    else  
      AImageList.Add(Bitmap, nil);
  finally
    Bitmap.Free;
  end;  
end;

function CreatePaperImages: TImageList;
begin
  Result := CreateImageList(2);
  LoadImage(Result, 'IDB_DXPSDESIGN_PAPER_STANDARD', True);
  LoadImage(Result, 'IDB_DXPSDESIGN_PAPER_ENVELOPE', True);    
end;

function CreateBinImages: TImageList;
begin
  Result := CreateImageList(2);
  LoadImage(Result, 'IDB_DXPSDESIGN_BIN_AUTOTRAY', True); 
  LoadImage(Result, 'IDB_DXPSDESIGN_BIN_MANUALTRAY', True);
end;

function CreatePrintOrderImages: TImageList;
begin
  Result := CreateImageList(2);
  LoadImage(Result, 'IDB_DXPSDESIGN_PRINTORDER_OVERTHENDOWN', False);
  LoadImage(Result, 'IDB_DXPSDESIGN_PRINTORDER_DOWNTHENOVER', False);
end;

function CreatePaperOrientationImages: TImageList;
begin
  Result := CreateImageList(2);
  LoadImage(Result, 'IDB_DXPSDESIGN_PAPERORIENTATION_PORTRAIT', True);
  LoadImage(Result, 'IDB_DXPSDESIGN_PAPERORIENTATION_LANDSCAPE', True);
end;

{$ENDIF}

initialization                           
  sdxPrintingSystem := sdxPrintingSystem + ' ' + dxPSGlbl.dxPSVersionString;

 {$IFDEF DELPHI5}
  ilPapers := CreatePaperImages;
  ilBins := CreateBinImages;
  ilPrintOrders := CreatePrintOrderImages;
  ilPaperOrientations := CreatePaperOrientationImages;
 {$ENDIF}

 {$IFDEF IDE_MENUBITMAPS}
  FBmpDesigner := LoadBitmap('IDB_DXPSDESIGN_DODESIGNER');
  FBmpNewEmpty := LoadBitmap('IDB_DXPSDESIGN_DOADDEMPTY');
  FBmpNew := LoadBitmap('IDB_DXPSDESIGN_DOADD');
  FBmpPrintPreview := LoadBitmap('IDB_DXPSDESIGN_DOPREVIEW');
  FBmpPageBackground := LoadBitmap('IDB_DXPSDESIGN_DOPAGEBACKGROUND');
  FBmpPrint := LoadBitmap('IDB_DXPSDESIGN_DOPRINT');
  FBmpPageSetup := LoadBitmap('IDB_DXPSDESIGN_DOPAGESETUP');
  FBmpItems := LoadBitmap('IDB_DXPSDESIGN_DOPROPERTIES');
  FBmpWEB := LoadBitmap('IDB_DXPSDESIGN_DOWEB');
 {$ENDIF}

finalization
 {$IFDEF DELPHI5}
  FreeAndNil(ilPapers);
  FreeAndNil(ilBins);
  FreeAndNil(ilPrintOrders);
  FreeAndNil(ilPaperOrientations);
 {$ENDIF}

 {$IFDEF IDE_MENUBITMAPS}
  FreeAndNil(FBmpWEB);
  FreeAndNil(FBmpItems);
  FreeAndNil(FBmpPageSetup);
  FreeAndNil(FBmpPrint);
  FreeAndNil(FBmpPageBackground);
  FreeAndNil(FBmpPrintPreview);
  FreeAndNil(FBmpNew);
  FreeAndNil(FBmpNewEmpty);
  FreeAndNil(FBmpDesigner);
 {$ENDIF}

end.

