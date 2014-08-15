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

unit dxPScxMCListBoxLnk;

interface

{$I cxVer.inc}

uses
  Windows, Messages, Classes, Graphics, Controls, ImgList, Dialogs, StdCtrls, 
  ExtCtrls, ComCtrls, cxMCListBox, cxHeader, dxPSGlbl, dxPSCore, dxPSForm, 
  dxPSBaseGridLnk, dxExtCtrls, cxDrawTextUtils;

type
  TcxMCListBoxPaintOption = (mclbpoBorder, mclbpoHorzLines, mclbpoVertLines, mclbpoColumnHeaders);
  TcxMCListBoxPaintOptions = set of TcxMCListBoxPaintOption;
  
  TcxMCListBoxReportLink = class;
  
  TcxMCListBoxCustomDrawItemEvent = procedure(Sender: TcxMCListBoxReportLink; 
    ACanvas: TCanvas; ACol, ARow: Integer; AnItem: TdxReportCellString; 
    var ADone: Boolean) of object;
                                                               
  TcxMCListBoxReportLink = class(TAbstractdxGridReportLink)
  private
    FOptions: TcxMCListBoxPaintOptions;
    FOnCustomDrawItem: TcxMCListBoxCustomDrawItemEvent;
    
    function GetColumn(Index: Integer): TcxHeaderSection;
    function GetcxMCListBox: TcxMCListBox;
    function GetHeaderColor: TColor;
    function GetHeaderFont: TFont;
    function GetHeaderTransparent: Boolean;
    function GetIncludeHeaders: Boolean;
    function GetOptions: TcxMCListBoxPaintOptions;
    function GetText(Column, Row: Integer): string;
    procedure SetOnCustomDrawItem(Value: TcxMCListBoxCustomDrawItemEvent);
    procedure SetHeaderColor(Value: TColor);
    procedure SetHeaderFont(Value: TFont);
    procedure SetHeaderTransparent(Value: Boolean);
    procedure SetIncludeHeaders(Value: Boolean);
    procedure SetOptions(Value: TcxMCListBoxPaintOptions);

    function AreColumnHeadersShown: Boolean;
    function HasHeaderSections: Boolean;
  protected
    procedure CustomDraw(AItem: TAbstractdxReportCellData; ACanvas: TCanvas; 
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); override;
    procedure DoCustomDrawItem(ACanvas: TCanvas; AnItem: TdxReportCellString; 
      var ADone: Boolean); dynamic;
    procedure GetImageLists(AProc: TdxPSGetImageListProc); override;  
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;

    function GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass; override;

    function GetColCount: Integer; override;
    function GetFixedRowCount: Integer; override;
    function GetRowCount: Integer; override;
    
    function GetCellImageIndex(ACol, ARow: Integer): Integer; override;
    function GetCellImageList(ACol, ARow: Integer): TCustomImageList; override;
    function GetCellMultiline(ACol, ARow: Integer): Boolean; override;
    function GetCellText(ACol, ARow: Integer): string; override;
    function GetCellTextAlignX(ACol, ARow: Integer): TcxTextAlignX; override;
    function GetColSortOrder(ACol: Integer): TdxCellSortOrder; override;
    function GetSelectedColCount: Integer; override;
    function GetSelectedRowCount: Integer; override;
    function GetSourceColWidth(ACol: Integer): Integer; override;
    function GetSourceRowHeight(ARow: Integer): Integer; override;
    function HasColumnHeaderImage(ACol: Integer): Boolean; override;
    function HasSelection: Boolean; override;
    function HasSelectionInCol(ACol: Integer): Boolean; override;
    function HasSelectionInRow(ARow: Integer): Boolean; override;
    function IsDrawBorder: Boolean; override;
    function IsDrawFixedHorzLines: Boolean; override;
    function IsDrawHorzLines: Boolean; override;
    function IsDrawVertLines: Boolean; override;
    function IsSelectedCell(ACol, ARow: Integer): Boolean; override;
    function IsSelectedRow(ARow: Integer): Boolean; override;
    procedure SetDrawMode(Value: TdxGridDrawMode); override;

    property Columns[Index: Integer]: TcxHeaderSection read GetColumn;
    property Texts[Column, Row: Integer]: string read GetText;
  public
    procedure Assign(Source: TPersistent); override;

    property cxMCListBox: TcxMCListBox read GetcxMCListBox;
  published                                               
    property AutoWidth;
    property DrawMode write SetDrawMode;
    property Effects3D;
    property EndEllipsis;
    property EvenColor;
    property EvenFont;
    property HeaderColor: TColor read GetHeaderColor write SetHeaderColor default clBtnFace;
    property HeaderFont: TFont read GetHeaderFont write SetHeaderFont stored IsFixedFontStored;
    property HeaderTransparent: Boolean read GetHeaderTransparent write SetHeaderTransparent default False;
    property IncludeHeaders: Boolean read GetIncludeHeaders write SetIncludeHeaders default True;
    property GridLineColor;
    property OnlySelected;
    property Options: TcxMCListBoxPaintOptions read GetOptions write SetOptions 
      default [Low(TcxMCListBoxPaintOption)..High(TcxMCListBoxPaintOption)];
    property RowAutoHeight;
    property Soft3D;
    property SupportedCustomDraw;
    property Transparent;
    property UseCustomPageBreaks;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    
    property OnCustomDrawItem: TcxMCListBoxCustomDrawItemEvent read FOnCustomDrawItem write SetOnCustomDrawItem;
    property OnGetCustomPageBreaks;
    property OnInitializeItem;
  end;
  
  TcxfmMCListBoxDesignWindow = class(TStandarddxReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshOptions: TTabSheet;
    pnlOptions: TPanel;
    lblShow: TLabel;
    Bevel11: TBevel;
    imgGrid: TImage;
    chbxShowVertLines: TCheckBox;
    chbxShowBorders: TCheckBox;
    chbxShowHorzLines: TCheckBox;
    tshColor: TTabSheet;
    pnlColor: TPanel;
    lblGridLinesColor: TLabel;
    bvlGridLineColorHost: TBevel;
    gbxTransparentHeaders: TGroupBox;
    lblHeadersColor: TLabel;
    bvlHeadersColorHost: TBevel;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    bvlColorHost: TBevel;
    lblEvenColor: TLabel;
    bvlEvenColorHost: TBevel;
    chbxTransparent: TCheckBox;
    chbxTransparentHeaders: TCheckBox;
    tshFont: TTabSheet;
    pnlFont: TPanel;
    btnFont: TButton;
    edFont: TEdit;
    btnHeadersFont: TButton;
    edFixedFont: TEdit;
    btnEvenFont: TButton;
    edEvenFont: TEdit;
    tshBehaviors: TTabSheet;
    Panel1: TPanel;
    Image3: TImage;
    lblSelection: TLabel;
    Bevel3: TBevel;
    lblLookAndFeel: TLabel;
    Bevel15: TBevel;
    Image8: TImage;
    chbxIncludeFixed: TCheckBox;
    chbxOnlySelected: TCheckBox;
    chbxUse3DEffects: TCheckBox;
    chbxUseSoft3D: TCheckBox;
    pnlPreview: TPanel;
    chbxShowColumnHeaders: TCheckBox;
    lblDrawMode: TLabel;
    cbxDrawMode: TComboBox;
    lblMiscellaneous: TLabel;
    Bevel4: TBevel;
    Image5: TImage;
    chbxRowAutoHeight: TCheckBox;
    lblOnEveryPage: TLabel;
    Image1: TImage;
    Bevel10: TBevel;
    chbxHeadersOnEveryPage: TCheckBox;
    lblPreview: TStaticText;
    chbxAutoWidth: TCheckBox;
    stTransparent: TStaticText;
    stTransparentHeaders: TStaticText;
    procedure DrawModeClick(Sender: TObject);
    procedure ShowClick(Sender: TObject);
    procedure RowAutoHeightClick(Sender: TObject);
    procedure TransparentClick(Sender: TObject);
    procedure FontClick(Sender: TObject);
    procedure HeadersOnEveryPageClick(Sender: TObject);
    procedure OnlySelectedClick(Sender: TObject);
    procedure IncludeFixedClick(Sender: TObject);
    procedure Use3DEffectsClick(Sender: TObject);
    procedure UseSoft3DClick(Sender: TObject);
    procedure ColorChange(Sender: TObject);
    procedure PreviewPaint(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cbxDrawModeDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure chbxAutoWidthClick(Sender: TObject);
    procedure stTransparentClick(Sender: TObject);
    procedure stTransparentHeadersClick(Sender: TObject);
  private
    FccbxColor: TdxPSColorCombo;
    FccbxEvenColor: TdxPSColorCombo;
    FccbxFixedColor: TdxPSColorCombo;
    FccbxGridLineColor: TdxPSColorCombo;
    FPreviewBox: TdxPSPaintPanel;
    function GetReportLink: TcxMCListBoxReportLink;

    procedure CreateControls;
    procedure CMDialogChar(var message: TCMDialogChar); message CM_DIALOGCHAR;
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
    property ReportLink: TcxMCListBoxReportLink read GetReportLink;
  end;

const
  dxDefaultMCListBoxOptions = [Low(TcxMCListBoxPaintOption)..High(TcxMCListBoxPaintOption)];    
  
implementation

{$R *.dfm}

uses
  SysUtils, Forms, cxClasses, cxLookAndFeels, dxPSRes, dxPSUtl, dxPrnDev;
  
const
  SortOrderMap: array[TcxHeaderSortOrder] of TdxCellSortOrder = (csoNone, csoUp, csoDown);
  
{ TcxMCListBoxReportLink }

procedure TcxMCListBoxReportLink.Assign(Source: TPersistent);
begin
  if Source is TcxMCListBoxReportLink then
    with TcxMCListBoxReportLink(Source) do 
    begin
      Self.Options := Options;
    end;  
  inherited;
end;

procedure TcxMCListBoxReportLink.CustomDraw(AItem: TAbstractdxReportCellData;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var ADone: Boolean);
begin
//  if AItem.Data <> 0 then 
    DoCustomDrawItem(ACanvas, TdxReportCellString(AItem), ADone);
end;

procedure TcxMCListBoxReportLink.DoCustomDrawItem(ACanvas: TCanvas; 
  AnItem: TdxReportCellString; var ADone: Boolean);
var
  Col, Row: Integer;  
begin
  if Assigned(FOnCustomDrawItem) then 
  begin
    GetCellColRow(AnItem, Col, Row);
    FOnCustomDrawItem(Self, ACanvas, Col, Row, AnItem, ADone);
  end;  
end;

procedure TcxMCListBoxReportLink.GetImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited;
  AProc(cxMCListBox.Images);
end;

procedure TcxMCListBoxReportLink.InternalRestoreDefaults;
begin
  inherited;
  Options := dxDefaultMCListBoxOptions;
end;

procedure TcxMCListBoxReportLink.InternalRestoreFromOriginal;
begin
  inherited;
  EndEllipsis := cxMCListBox.ShowEndEllipsis;
  Multiline := cxMCListBox.MultiLines;  
  Options := [mclbpoBorder]; 
  if cxMCListBox.ShowColumnLines then 
    Options := Options + [mclbpoVertLines];
  with cxMCListBox.Style.LookAndFeel do 
  begin
    Effects3D := (lfvKind in AssignedValues) and (Kind <> lfUltraFlat);
    Soft3D := (lfvKind in AssignedValues) and (Kind = lfFlat);
  end;  
end;

function TcxMCListBoxReportLink.GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass;
const
  ItemClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellString, TdxReportCellImage);
begin
  Result := ItemClasses[IsFixedRow(ARow)];
end;

function TcxMCListBoxReportLink.GetColCount: Integer;
begin
  Result := cxMCListBox.HeaderSections.Count;
  if Result = 0 then Result := 1;
end;

function TcxMCListBoxReportLink.GetFixedRowCount: Integer;
begin
  Result := Ord(AreColumnHeadersShown);
end;

function TcxMCListBoxReportLink.GetRowCount: Integer;
begin
  Result := cxMCListBox.Items.Count + Ord(AreColumnHeadersShown);
end;

function TcxMCListBoxReportLink.GetCellImageIndex(ACol, ARow: Integer): Integer;
begin
  if HasHeaderSections and IsFixedRow(ARow) then 
    Result := Columns[ACol].ImageIndex
  else
    Result := inherited GetCellImageIndex(ACol, ARow);
end;

function TcxMCListBoxReportLink.GetCellImageList(ACol, ARow: Integer): TCustomImageList;
begin
  if HasHeaderSections and IsFixedRow(ARow) then 
    Result := cxMCListBox.Images
  else
    Result := inherited GetCellImageList(ACol, ARow);
end;

function TcxMCListBoxReportLink.GetCellMultiline(ACol, ARow: Integer): Boolean;
begin
  Result := cxMCListBox.MultiLines;
end;

function TcxMCListBoxReportLink.GetCellText(ACol, ARow: Integer): string;
begin
  if IsFixedRow(ARow) then 
    if HasHeaderSections then
      Result := Columns[ACol].Text
    else
      Result := ''
  else                                     
    Result := Texts[ACol, ARow - Ord(AreColumnHeadersShown)];
end;

function TcxMCListBoxReportLink.GetCellTextAlignX(ACol, ARow: Integer): TcxTextAlignX;
begin
  if HasHeaderSections then
    Result := dxTextAlignX[Columns[ACol].Alignment]
  else
    Result := dxTextAlignX[cxMCListBox.Alignment];      
end;

function TcxMCListBoxReportLink.GetColSortOrder(ACol: Integer): TdxCellSortOrder;
begin
  if HasHeaderSections then 
    Result := SortOrderMap[Columns[ACol].SortOrder]
  else
    Result := inherited GetColSortOrder(ACol);
end;

function TcxMCListBoxReportLink.GetSelectedColCount: Integer;
begin
  if HasHeaderSections then
    Result := cxMCListBox.HeaderSections.Count
  else
    Result := 1;  
end;

function TcxMCListBoxReportLink.GetSelectedRowCount: Integer;
begin
  Result := cxMCListBox.SelCount;
end;

function TcxMCListBoxReportLink.GetSourceColWidth(ACol: Integer): Integer;
begin
  if HasHeaderSections then
    Result := Columns[ACol].Width
  else
    Result := cxMCListBox.Width;
end;

function TcxMCListBoxReportLink.GetSourceRowHeight(ARow: Integer): Integer; 
begin
  Result := inherited GetSourceRowHeight(ARow);
  if Result = 0 then
    Result := GetMinRowHeight(ScreenDC, Font);
end;

function TcxMCListBoxReportLink.HasColumnHeaderImage(ACol: Integer): Boolean; 
begin
  Result := HasHeaderSections and (cxMCListBox.Images <> nil) and (Columns[ACol].ImageIndex > -1) and
    (Columns[ACol].ImageIndex < cxMCListBox.Images.Count);
end;

function TcxMCListBoxReportLink.HasSelection: Boolean;
begin
  Result := inherited HasSelection and (cxMCListBox.SelCount > 0);
end;

function TcxMCListBoxReportLink.HasSelectionInCol(ACol: Integer): Boolean;
begin
  Result := True;
end;

function TcxMCListBoxReportLink.HasSelectionInRow(ARow: Integer): Boolean;
begin
  Result := IsSelectedRow(ARow);
end;

function TcxMCListBoxReportLink.IsDrawBorder: Boolean;
begin
  Result := mclbpoBorder in Options;
end;

function TcxMCListBoxReportLink.IsDrawHorzLines: Boolean;
begin
  Result := mclbpoHorzLines in Options;
end;

function TcxMCListBoxReportLink.IsDrawVertLines: Boolean;
begin
  Result := mclbpoVertLines in Options;
end;

function TcxMCListBoxReportLink.IsDrawFixedHorzLines: Boolean;
begin
  Result := mclbpoBorder in Options;
end;

function TcxMCListBoxReportLink.IsSelectedCell(ACol, ARow: Integer): Boolean;
begin
  Result := IsSelectedRow(ARow);
end;

function TcxMCListBoxReportLink.IsSelectedRow(ARow: Integer): Boolean;
begin
  if IsFixedRow(ARow) then
    Result := IncludeHeaders
  else  
    Result := cxMCListBox.Selected[ARow - Ord(AreColumnHeadersShown)];
end;

procedure TcxMCListBoxReportLink.SetDrawMode(Value: TdxGridDrawMode);
begin
  if Value = gdmBorrowSource then Value := gdmStrict;
  inherited;
end;

function TcxMCListBoxReportLink.GetColumn(Index: Integer): TcxHeaderSection;
begin
  Result := cxMCListBox.HeaderSections[Index];
end;

function TcxMCListBoxReportLink.GetcxMCListBox: TcxMCListBox;
begin
  Result := TcxMCListBox(Component);
end;

function TcxMCListBoxReportLink.GetHeaderColor: TColor;
begin
  Result := FixedColor;
end;

function TcxMCListBoxReportLink.GetHeaderFont: TFont;
begin
  Result := FixedFont;
end;

function TcxMCListBoxReportLink.GetHeaderTransparent: Boolean;
begin
  Result := FixedTransparent;
end;

function TcxMCListBoxReportLink.GetIncludeHeaders: Boolean;
begin
  Result := IncludeFixed;
end;

function TcxMCListBoxReportLink.GetOptions: TcxMCListBoxPaintOptions;
begin
  Result := FOptions;
end;

function TcxMCListBoxReportLink.GetText(Column, Row: Integer): string;
var
  TextLine: string;
  P, I: Integer;
begin
  TextLine := cxMCListBox.Items[Row];
  if cxMCListBox.Delimiter <> #0 then
  begin
    I := -1;
    repeat
      P := Pos(cxMCListBox.Delimiter, TextLine);
      if P <> 0 then 
      begin
        Result := Copy(TextLine, 1, P - 1);
        Delete(TextLine, 1, P);
      end  
      else
        Result := TextLine;
      Inc(I);  
    until (I = Column) or (P = 0);
  end
  else
    Result := TextLine;
end;

procedure TcxMCListBoxReportLink.SetOnCustomDrawItem(Value: TcxMCListBoxCustomDrawItemEvent);
begin
  if @FOnCustomDrawItem <> @Value then
  begin
    FOnCustomDrawItem := Value;
    if SupportedCustomDraw then LinkModified(True);
  end;
end;

procedure TcxMCListBoxReportLink.SetHeaderColor(Value: TColor);
begin
  FixedColor := Value;
end;

procedure TcxMCListBoxReportLink.SetHeaderFont(Value: TFont);
begin
  FixedFont := Value;
end;

procedure TcxMCListBoxReportLink.SetHeaderTransparent(Value: Boolean);
begin
  FixedTransparent := Value;
end;

procedure TcxMCListBoxReportLink.SetIncludeHeaders(Value: Boolean);
begin
  IncludeFixed := Value;
end;

procedure TcxMCListBoxReportLink.SetOptions(Value: TcxMCListBoxPaintOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    LinkModified(True);
  end;
end;

function TcxMCListBoxReportLink.AreColumnHeadersShown: Boolean;
begin
  Result := mclbpoColumnHeaders in Options;
end;

function TcxMCListBoxReportLink.HasHeaderSections: Boolean;
begin
  Result := cxMCListBox.HeaderSections.Count <> 0;
end;

{ TcxfmMCListBoxDesignWindow }

constructor TcxfmMCListBoxDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxPSGlbl.dxhccxMCListBoxReportLinkDesigner;
  inherited;
  CreateControls;
  PageControl1.ActivePage := PageControl1.Pages[0];
end;

procedure TcxfmMCListBoxDesignWindow.DoInitialize;
begin
  inherited;

  chbxShowBorders.Checked := mclbpoBorder in ReportLink.Options;
  chbxShowHorzLines.Checked := mclbpoHorzLines in ReportLink.Options;
  chbxShowVertLines.Checked := mclbpoVertLines in ReportLink.Options;
  chbxShowColumnHeaders.Checked := mclbpoColumnHeaders in ReportLink.Options;

  chbxAutoWidth.Checked := ReportLink.AutoWidth;
  chbxRowAutoHeight.Checked := ReportLink.RowAutoHeight;
  
  with cbxDrawMode do 
    ItemIndex := Items.IndexOfObject(TObject(ReportLink.DrawMode));

  chbxTransparent.Checked := ReportLink.Transparent;
  TdxPSColorCombo(FccbxColor).ColorValue := ColorToRGB(ReportLink.Color);
  TdxPSColorCombo(FccbxEvenColor).ColorValue := ColorToRGB(ReportLink.EvenColor);
  chbxTransparentHeaders.Checked := ReportLink.HeaderTransparent;
  TdxPSColorCombo(FccbxFixedColor).ColorValue := ColorToRGB(ReportLink.HeaderColor);
  TdxPSColorCombo(FccbxGridLineColor).ColorValue := ColorToRGB(ReportLink.GridLineColor);

  FontInfoToText(ReportLink.Font, edFont);
  FontInfoToText(ReportLink.EvenFont, edEvenFont);
  FontInfoToText(ReportLink.HeaderFont, edFixedFont);          
  
  chbxHeadersOnEveryPage.Checked := ReportLink.HeadersOnEveryPage;
  chbxOnlySelected.Checked := ReportLink.OnlySelected;
  chbxIncludeFixed.Checked := ReportLink.IncludeFixed;

  chbxUse3DEffects.Checked := ReportLink.Effects3D;
  chbxUseSoft3D.Checked := ReportLink.Soft3D;
end;

{$IFDEF DELPHI7}
function TcxfmMCListBoxDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TcxfmMCListBoxDesignWindow.LoadStrings;
begin
  inherited;
  
  tshOptions.Caption := cxGetResourceString(@sdxOptions);
  tshFont.Caption := cxGetResourceString(@sdxFonts);
  tshColor.Caption := cxGetResourceString(@sdxColors);
  tshBehaviors.Caption := cxGetResourceString(@sdxBehaviors);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  lblShow.Caption := cxGetResourceString(@sdxShow);
  chbxShowBorders.Caption := cxGetResourceString(@sdxBorderLines);
  chbxShowHorzLines.Caption := cxGetResourceString(@sdxHorzLines);
  chbxShowVertLines.Caption := cxGetResourceString(@sdxVertLines);
  chbxShowColumnHeaders.Caption := cxGetResourceString(@sdxColumnHeaders);

  lblMiscellaneous.Caption := cxGetResourceString(@sdxMiscellaneous);
  chbxRowAutoHeight.Caption := cxGetResourceString(@sdxRowAutoHeight);
  lblDrawMode.Caption := cxGetResourceString(@sdxDrawMode);

  with cbxDrawMode.Items do 
  begin
    BeginUpdate;
    try
      Clear;
      AddObject(cxGetResourceString(@sdxDrawModeStrict), TObject(gdmStrict));
      AddObject(cxGetResourceString(@sdxDrawModeOddEven), TObject(gdmOddEven));
      AddObject(cxGetResourceString(@sdxDrawModeChess), TObject(gdmChess));
    finally
      EndUpdate;
    end;
  end;  

  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  lblColor.Caption := cxGetResourceString(@sdxColor);
  lblEvenColor.Caption := cxGetResourceString(@sdxEvenColor);
  stTransparentHeaders.Caption := ' ' + cxGetResourceString(@sdxHeadersTransparent) + ' ';
  lblHeadersColor.Caption := cxGetResourceString(@sdxHeaderColor);
  lblGridLinesColor.Caption := cxGetResourceString(@sdxGridLinesColor);

  btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  btnEvenFont.Caption := cxGetResourceString(@sdxBtnEvenFont);
  btnHeadersFont.Caption := cxGetResourceString(@sdxBtnHeadersFont);

  lblOnEveryPage.Caption := cxGetResourceString(@sdxOnEveryPage);
  chbxHeadersOnEveryPage.Caption := cxGetResourceString(@sdxColumnHeadersOnEveryPage);

  lblSelection.Caption := cxGetResourceString(@sdxSelection);
  chbxOnlySelected.Caption := cxGetResourceString(@sdxOnlySelected);
  chbxIncludeFixed.Caption := cxGetResourceString(@sdxIncludeFixed);

  lblLookAndFeel.Caption := cxGetResourceString(@sdxLookAndFeel);
  chbxUse3DEffects.Caption := cxGetResourceString(@sdxUse3DEffects);
  chbxUseSoft3D.Caption := cxGetResourceString(@sdxSoft3D);
end;

procedure TcxfmMCListBoxDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
begin
  inherited;
  dxPSDrawGridPreview(ACanvas, R, ReportLink, False, ReportLink.AreColumnHeadersShown);
end;

procedure TcxfmMCListBoxDesignWindow.UpdateControlsState;
begin
  inherited;
  
  FccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := FccbxColor.Enabled;
  FccbxEvenColor.Enabled := not chbxTransparent.Checked and 
    (ReportLink.DrawMode in [gdmOddEven, gdmChess]);
  lblEvenColor.Enabled := FccbxEvenColor.Enabled;
  FccbxFixedColor.Enabled := not chbxTransparentHeaders.Checked;
  lblHeadersColor.Enabled := FccbxFixedColor.Enabled;

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
  chbxHeadersOnEveryPage.Enabled := not ReportLink.IsAggregated;
  chbxIncludeFixed.Enabled := chbxOnlySelected.Enabled and chbxOnlySelected.Checked;
  chbxUseSoft3D.Enabled := chbxUse3DEffects.Checked;
end;

procedure TcxfmMCListBoxDesignWindow.UpdatePreview;
begin
  FPreviewBox.Invalidate;
end;

function TcxfmMCListBoxDesignWindow.GetReportLink: TcxMCListBoxReportLink;
begin
  Result := inherited ReportLink as TcxMCListBoxReportLink;
end;

procedure TcxfmMCListBoxDesignWindow.CreateControls;

  function CreateColorCombo(AParent: TWinControl; AHost: TControl;
    ATag: Integer; AAutoColor: TColor; ALabel: TLabel): TdxPSColorCombo;
  begin
    Result := TdxPSColorCombo.Create(Self);
    with Result do
    begin
      BoundsRect := AHost.BoundsRect;
      Tag := MakeTTag(ATag);
      Parent := AParent;
      ColorTypes := [ctPure];
      ShowColorName := True;
      ShowAutoColor := True;
      AutoColor := AAutoColor;
      OnChange := ColorChange;
    end;
    ALabel.FocusControl := Result;
    AHost.Visible := False;
  end;

  procedure CreatePreviewBox;
  var
    R: TRect;
  begin
    FPreviewBox := TdxPSPaintPanel.Create(Self);
    with FPreviewBox do
    begin
      Parent := pnlPreview;
      R := pnlPreview.BoundsRect;
      OffsetRect(R, -R.Left, -R.Top);
      InflateRect(R, -1, -1);
      BoundsRect := R;
      EdgeInner := esNone;
      EdgeOuter := esNone;
      OnPaint := PreviewPaint;
    end;
  end;
  
begin
  CreatePreviewBox;
  
  FccbxColor := 
    CreateColorCombo(gbxTransparent, bvlColorHost, 0, dxDefaultColor, lblColor);
  FccbxEvenColor := 
    CreateColorCombo(gbxTransparent, bvlEvenColorHost, 1, dxDefaultColor, lblEvenColor);
  FccbxFixedColor := 
    CreateColorCombo(gbxTransparentHeaders, bvlHeadersColorHost, 2, dxDefaultFixedColor, lblHeadersColor);
  FccbxGridLineColor := 
    CreateColorCombo(pnlColor, bvlGridLineColorHost, 3, dxDefaultGridLineColor, lblGridLinesColor);
end;

procedure TcxfmMCListBoxDesignWindow.CMDialogChar(var message: TCMDialogChar);
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

procedure TcxfmMCListBoxDesignWindow.DrawModeClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TComboBox(Sender) do 
    ReportLink.DrawMode := TdxGridDrawMode(Items.Objects[ItemIndex]);
  Modified := True;
  UpdatePreview;  
end;

procedure TcxfmMCListBoxDesignWindow.cbxDrawModeDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  dxPSBaseGridLnk.dxPSDrawComboDrawModeItem(Control, Index, Rect, State);
end;

procedure TcxfmMCListBoxDesignWindow.ShowClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TCheckBox(Sender) do
    if Checked then
      ReportLink.Options := ReportLink.Options + [TcxMCListBoxPaintOption(Tag)]
    else
      ReportLink.Options := ReportLink.Options - [TcxMCListBoxPaintOption(Tag)];
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmMCListBoxDesignWindow.chbxAutoWidthClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.AutoWidth := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmMCListBoxDesignWindow.RowAutoHeightClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.RowAutoHeight := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmMCListBoxDesignWindow.TransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  case TTagToInt(TCheckBox(Sender).Tag) of
    0: ReportLink.Transparent := TCheckBox(Sender).Checked;
    1: ReportLink.HeaderTransparent := TCheckBox(Sender).Checked;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmMCListBoxDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TcxfmMCListBoxDesignWindow.stTransparentHeadersClick(Sender: TObject);
begin
  if chbxTransparentHeaders.CanFocus then ActiveControl := chbxTransparentHeaders;
  chbxTransparentHeaders.Checked := not chbxTransparentHeaders.Checked;
end;

procedure TcxfmMCListBoxDesignWindow.FontClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;

  with dxPSGlbl.FontDialog do 
  begin
    case TTagToInt(TButton(Sender).Tag) of
      0: Font := ReportLink.Font;
      1: Font := ReportLink.EvenFont;
      2: Font := ReportLink.HeaderFont;
    end;
    if Execute then
    begin
      case TTagToInt(TButton(Sender).Tag) of
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
        2:
          begin
            ReportLink.FixedFont := Font;
            FontInfoToText(ReportLink.HeaderFont, edFixedFont);          
          end;
      end;
      Modified := True;
      UpdatePreview;
    end;
  end;  
end;

procedure TcxfmMCListBoxDesignWindow.HeadersOnEveryPageClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.HeadersOnEveryPage := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmMCListBoxDesignWindow.OnlySelectedClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.OnlySelected := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmMCListBoxDesignWindow.IncludeFixedClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.IncludeFixed := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmMCListBoxDesignWindow.Use3DEffectsClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Effects3D := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmMCListBoxDesignWindow.UseSoft3DClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Soft3D := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmMCListBoxDesignWindow.ColorChange(Sender: TObject);
var
  AColor: TColor;
begin
  if LockControlsUpdate then Exit;
  AColor := TdxPSColorCombo(Sender).ColorValue;
  case TTagToInt(TdxPSColorCombo(Sender).Tag) of
    0: ReportLink.Color := AColor;
    1: ReportLink.EvenColor := AColor;
    2: ReportLink.FixedColor := AColor;
    3: ReportLink.GridLineColor := AColor;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmMCListBoxDesignWindow.PreviewPaint(Sender: TObject);
begin
  with FPreviewBox do
    PaintPreview(Canvas, ClientRect);
end;

procedure TcxfmMCListBoxDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreview.Parent := TPageControl(Sender).ActivePage;
end;

initialization
  dxPSRegisterReportLink(TcxMCListBoxReportLink, TcxMCListBox, TcxfmMCListBoxDesignWindow);
  
finalization
  dxPSUnregisterReportLink(TcxMCListBoxReportLink, TcxMCListBox, TcxfmMCListBoxDesignWindow);

end.
 
