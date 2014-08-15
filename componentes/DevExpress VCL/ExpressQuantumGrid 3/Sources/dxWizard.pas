
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid Wizard                                   }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxWizard;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, dxDBGrid, Menus, ComCtrls, dxTL,
  dxTLClms, dxCntner, dxExEdtr, dxDBCtrl{$IFDEF DELPHI4}, ImgList{$ENDIF}
  {$IFNDEF DELPHI6}, DsgnIntf{$ELSE},  DesignIntf, DesignEditors{$ENDIF};

const
  PanelCount = 13{***};
  FormWidth  = 480;
  FormHeight = 340;

type
  TFGrWizard = class(TForm)
    pnButtons: TPanel;
    BBack: TButton;
    Bevel1: TBevel;
    pnDesktop: TPanel;
    BNext: TButton;
    BCancel: TButton;
    BPopup: TSpeedButton;
    pnStart: TPanel;
    LinkLabel: TLabel;
    Label1: TLabel;
    pnDataSource: TPanel;
    pnImage: TPanel;
    pnBody: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    CDataSource: TComboBox;
    Panel2: TPanel;
    Image5: TImage;
    pnKeyField: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Label3: TLabel;
    Panel8: TPanel;
    CKeyField: TComboBox;
    pnHint: TPanel;
    imHint2: TImage;
    Label4: TLabel;
    Panel9: TPanel;
    imHint1: TImage;
    Label5: TLabel;
    pnGridMode: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Image8: TImage;
    Label7: TLabel;
    rbGridMode: TRadioButton;
    rbLoadAllRecords: TRadioButton;
    pmGroups: TPopupMenu;
    miDataSet: TMenuItem;
    miBindSummaryGroups: TMenuItem;
    miDesign: TMenuItem;
    miPreview: TMenuItem;
    Panel1: TPanel;
    imAbout: TImage;
    RadioGroup1: TRadioGroup;
    cbSmartReload: TCheckBox;
    cbSmartRefresh: TCheckBox;
    pnGridStyle: TPanel;
    Panel11: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    imgGrids: TImageList;
    TL_Style: TdxTreeList;
    Label6: TLabel;
    pnBands: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    TL_Bands: TdxTreeList;
    imgSmall: TImageList;
    sbBandAdd: TSpeedButton;
    sbBandDelete: TSpeedButton;
    sbBandUp: TSpeedButton;
    sbBandDown: TSpeedButton;
    pmBands: TPopupMenu;
    miBandAdd: TMenuItem;
    miBandDelete: TMenuItem;
    miBandMoveUp: TMenuItem;
    miBandMoveDown: TMenuItem;
    colBandCaption: TdxTreeListColumn;
    colBandAlignment: TdxTreeListImageColumn;
    colBandVisible: TdxTreeListCheckColumn;
    colBandFixed: TdxTreeListImageColumn;
    miGoBands: TMenuItem;
    pnColumns: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    sbColumnDelete: TSpeedButton;
    sbColumnUp: TSpeedButton;
    sbColumnDown: TSpeedButton;
    Panel22: TPanel;
    TL_Columns: TdxTreeList;
    colFieldName: TdxTreeListColumn;
    colColumnClass: TdxTreeListPickColumn;
    colVisible: TdxTreeListCheckColumn;
    pmColumns: TPopupMenu;
    miColumnAdd: TMenuItem;
    miColumnUp: TMenuItem;
    miColumnDown: TMenuItem;
    pnOrder: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    KeyField1: TMenuItem;
    GridMode1: TMenuItem;
    GridStyle1: TMenuItem;
    Columns1: TMenuItem;
    ColumnsOrder1: TMenuItem;
    sbColumnAll: TSpeedButton;
    pnPreview: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    cbShowPreview: TCheckBox;
    Label9: TLabel;
    CPreviewField: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    cbAutoCalcPreviewLines: TCheckBox;
    BPreviewFont: TButton;
    Label12: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    EPreviewFont: TEdit;
    EPreviewLines: TEdit;
    EPreviewMaxLen: TEdit;
    EIndentDesc: TEdit;
    UDPreviewLines: TUpDown;
    UDPreviewMaxLen: TUpDown;
    UDIndentDesc: TUpDown;
    Image1: TImage;
    Image6: TImage;
    FontDialog: TFontDialog;
    pnSummaryFooter: TPanel;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    cbShowSummaryFooter: TCheckBox;
    TL_SummaryFooter: TdxTreeList;
    colSFColumnName: TdxTreeListColumn;
    colSFFieldName: TdxTreeListPickColumn;
    colSFFormat: TdxTreeListPickColumn;
    colSFType: TdxTreeListImageColumn;
    miSummaryFooter: TMenuItem;
    pnSummaryGroups: TPanel;
    Panel32: TPanel;
    Panel33: TPanel;
    Panel34: TPanel;
    cbShowRowFooter: TCheckBox;
    TL_SummaryGroups: TdxTreeList;
    sbAddSummaryGroup: TSpeedButton;
    Panel4: TPanel;
    Panel35: TPanel;
    GroupBox2: TGroupBox;
    TL_OrphanedColumns: TdxTreeList;
    TL_HiddenColumnsColumn: TdxTreeListColumn;
    Label8: TLabel;
    Panel36: TPanel;
    Panel37: TPanel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel40: TPanel;
    Splitter: TSplitter;
    Panel42: TPanel;
    TL_Visible: TdxTreeList;
    TL_VisibleColumn: TdxTreeListColumn;
    Panel43: TPanel;
    Panel44: TPanel;
    miSummaryGroups: TMenuItem;
    sbDeleteSummatyGroup: TSpeedButton;
    colSGColumnName: TdxTreeListPickColumn;
    colSGSummaryField: TdxTreeListPickColumn;
    colSGSummaryFormat: TdxTreeListPickColumn;
    colSGSummaryType: TdxTreeListImageColumn;
    pnBindSummary: TPanel;
    Panel45: TPanel;
    Panel46: TPanel;
    Panel47: TPanel;
    TL_BindSummaryGroups: TdxTreeList;
    Label13: TLabel;
    colBindColumnName: TdxTreeListPickColumn;
    colBindSummaryGroup: TdxTreeListPickColumn;
    Image7: TImage;
    pnDesign: TPanel;
    Panel49: TPanel;
    Panel50: TPanel;
    box1: TGroupBox;
    cbShowBands: TCheckBox;
    BFontBand: TButton;
    BColorBand: TButton;
    box2: TGroupBox;
    cbShowHeader: TCheckBox;
    BFontHeader: TButton;
    BColorHeader: TButton;
    box3: TGroupBox;
    box5: TGroupBox;
    cbShowPreviewGrid: TCheckBox;
    cbShowGrid: TCheckBox;
    cbShowGroupPanel: TCheckBox;
    box4: TGroupBox;
    Image14: TImage;
    Image16: TImage;
    Image9: TImage;
    Image19: TImage;
    Image17: TImage;
    Image18: TImage;
    box6: TGroupBox;
    cbShowNewItemRow: TCheckBox;
    cbSummaryFooter: TCheckBox;
    cbPreview: TCheckBox;
    cbIndicator: TCheckBox;
    Image13: TImage;
    Image12: TImage;
    Image10: TImage;
    Image11: TImage;
    BTextGroupPanel: TButton;
    BColorGroupPanel: TButton;
    BTextRowFooter: TButton;
    BColorRowFooter: TButton;
    sbShowRowFooter: TCheckBox;
    BColorGrid: TButton;
    Shape1: TShape;
    SPColorGrid: TShape;
    PFontBand: TPanel;
    PFontHeader: TPanel;
    PTextGroupPanel: TPanel;
    PTextRowFooter: TPanel;
    Panel41: TPanel;
    Panel48: TPanel;
    Panel51: TPanel;
    Panel52: TPanel;
    ColorDialog: TColorDialog;
    LinkLabel1: TLabel;
    colGridStyle: TdxTreeListMemoColumn;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image15: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    rbPartialLoad: TRadioButton;
    pnFilter: TPanel;
    Panel54: TPanel;
    Image26: TImage;
    Panel55: TPanel;
    Panel56: TPanel;
    cbFilterActive: TCheckBox;
    cbFilterAutoDataSetFilter: TCheckBox;
    cbFilterCaseInsensitive: TCheckBox;
    Label15: TLabel;
    cbFilterStatus: TComboBox;
    edFilterDropDownCount: TEdit;
    udFilterDropDownCount: TUpDown;
    Label16: TLabel;
    edFilterMaxDropDownCount: TEdit;
    udFilterMaxDropDownCount: TUpDown;
    Label17: TLabel;
    Bevel4: TBevel;
    Label14: TLabel;
    Label18: TLabel;
    Bevel5: TBevel;
    miFilter: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure CDataSourceChange(Sender: TObject);
    procedure BBackClick(Sender: TObject);
    procedure CKeyFieldChange(Sender: TObject);
    procedure CKeyFieldExit(Sender: TObject);
    procedure rbGridModeClick(Sender: TObject);
    procedure BPopupClick(Sender: TObject);
    procedure cbSmartReloadClick(Sender: TObject);
    procedure cbSmartRefreshClick(Sender: TObject);
    procedure TL_StyleDblClick(Sender: TObject);
    procedure TL_BandsEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure colBandAlignmentCloseUp(Sender: TObject; var Value: String;
      var Accept: Boolean);
    procedure colBandVisibleToggleClick(Sender: TObject;
      const Text: String; State: TdxCheckBoxState);
    procedure sbBandUpClick(Sender: TObject);
    procedure sbBandDownClick(Sender: TObject);
    procedure sbBandAddClick(Sender: TObject);
    procedure sbBandDeleteClick(Sender: TObject);
    procedure colBandFixedCloseUp(Sender: TObject; var Value: String;
      var Accept: Boolean);
    procedure miGoBandsClick(Sender: TObject);
    procedure sbColumnUpClick(Sender: TObject);
    procedure sbColumnDownClick(Sender: TObject);
    procedure sbColumnDeleteClick(Sender: TObject);
    procedure TL_VisibleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TL_OrphanedColumnsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure TL_OrphanedColumnsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure TL_VisibleBeginDragNode(Sender: TObject;
      Node: TdxTreeListNode);
    procedure TL_VisibleDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TL_VisibleDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure sbColumnAllClick(Sender: TObject);
    procedure TL_VisibleGetStateIndex(Sender: TObject;
      Node: TdxTreeListNode; var Index: Integer);
    procedure CPreviewFieldExit(Sender: TObject);
    procedure CPreviewFieldChange(Sender: TObject);
    procedure cbShowPreviewClick(Sender: TObject);
    procedure BPreviewFontClick(Sender: TObject);
    procedure cbAutoCalcPreviewLinesClick(Sender: TObject);
    procedure EPreviewMaxLenExit(Sender: TObject);
    procedure EIndentDescExit(Sender: TObject);
    procedure EPreviewLinesExit(Sender: TObject);
    procedure UDPreviewLinesClick(Sender: TObject; Button: TUDBtnType);
    procedure UDIndentDescClick(Sender: TObject; Button: TUDBtnType);
    procedure EPreviewMaxLenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EIndentDescKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EPreviewLinesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UDPreviewMaxLenClick(Sender: TObject; Button: TUDBtnType);
    procedure cbShowSummaryFooterClick(Sender: TObject);
    procedure cbShowRowFooterClick(Sender: TObject);
    procedure TL_SummaryGroupsEditing(Sender: TObject;
      Node: TdxTreeListNode; var Allow: Boolean);
    procedure TL_SummaryGroupsCustomDrawCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; ASelected, AFocused,
      ANewItemRow: Boolean; var AText: String; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure colBandCaptionCustomDrawCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; ASelected, AFocused,
      ANewItemRow: Boolean; var AText: String; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure colFieldNameCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure colSFColumnNameCustomDrawCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; ASelected, AFocused,
      ANewItemRow: Boolean; var AText: String; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure sbAddSummaryGroupClick(Sender: TObject);
    procedure TL_SummaryGroupsCollapsing(Sender: TObject;
      Node: TdxTreeListNode; var Allow: Boolean);
    procedure sbDeleteSummatyGroupClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BFontBandClick(Sender: TObject);
    procedure BFontHeaderClick(Sender: TObject);
    procedure BColorBandClick(Sender: TObject);
    procedure cbShowBandsClick(Sender: TObject);
    procedure cbShowHeaderClick(Sender: TObject);
    procedure cbShowGroupPanelClick(Sender: TObject);
    procedure sbShowRowFooterClick(Sender: TObject);
    procedure cbShowGridClick(Sender: TObject);
    procedure cbShowPreviewGridClick(Sender: TObject);
    procedure cbShowNewItemRowClick(Sender: TObject);
    procedure cbSummaryFooterClick(Sender: TObject);
    procedure cbPreviewClick(Sender: TObject);
    procedure cbIndicatorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbFilterActiveClick(Sender: TObject);
    procedure cbFilterAutoDataSetFilterClick(Sender: TObject);
    procedure cbFilterCaseInsensitiveClick(Sender: TObject);
    procedure cbFilterStatusChange(Sender: TObject);
    procedure edFilterDropDownCountExit(Sender: TObject);
    procedure edFilterDropDownCountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure udFilterDropDownCountClick(Sender: TObject;
      Button: TUDBtnType);
    procedure edFilterMaxDropDownCountExit(Sender: TObject);
    procedure edFilterMaxDropDownCountKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure udFilterMaxDropDownCountClick(Sender: TObject;
      Button: TUDBtnType);
  private
    Panels: array [0..PanelCount - 1] of TPanel;
    CurrentPanel: TPanel;
    procedure SetButtons;
    procedure SetDefaultButton(Button: TButton);
    procedure PostPanel(Panel: TPanel);
    procedure ShowPanel(Panel: TPanel);
    procedure UpdateDesigner;

    procedure LoadDataSource(const S: string);
    procedure LoadBandInfo(TopBand, Band: TdxTreeListBand);
    procedure LoadAllColumns(Reload: Boolean);
    procedure LoadOrderInfo;
    procedure LoadSummaryGroups;
    procedure LoadDesignInfo;
    procedure DoColorDialog(Id: Integer);
  public
    {$IFDEF DELPHI6}
    PDesigner: IDesigner;
    {$ELSE}
    PDesigner: {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF};
    {$ENDIF}
    ColumnOwner: TComponent;
    DBGrid: TdxDBGrid;
  end;


procedure ShowdxDBGridWizard(ADBGrid: TdxDBGrid; ADesigner: Pointer; AColumnOwner: TComponent);
function GetColumnCaption(C: TdxTreeListColumn): string;

implementation

{$R *.DFM}

uses
  TypInfo, DB, dxGrWzrd, dxGrReg, dxWzSmGr;

const
  indBand             = 3;
  indColumn           = 4;
  indUnCheck          = 5;
  indCheck            = 6;
  indUnCheckGrayed    = 7;
  indCheckGrayed      = 8;

procedure ShowdxDBGridWizard(ADBGrid: TdxDBGrid; ADesigner: Pointer; AColumnOwner: TComponent);
var
  AForm: TFGrWizard;
begin
  AForm := TFGrWizard.Create(nil);
  AForm.DBGrid := ADBGrid;
  with AForm do
  begin
    ColumnOwner := AColumnOwner;
    {$IFDEF DELPHI6}
    PDesigner := IDesigner(ADesigner);
    {$ELSE}
    PDesigner := {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(ADesigner);
    {$ENDIF}
    PDesigner.SelectComponent(AColumnOwner{GetParentForm(DBGrid)});
    ShowModal;
    Free;
  end;
end;

procedure TFGrWizard.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  Caption := 'QuantumWizard';
//  Width := FormWidth;
//  Height := FormHeight;

  ClientWidth := pnDesign.Width;
  ClientHeight := pnDesign.Height + pnButtons.Height + Bevel1.Height;

//  LinkLabel.Cursor := crdxHandPointCursor;
//  LinkLabel1.Cursor := crdxHandPointCursor;
  // Load Panels
//  Panels[0] := pnStart;
  Panels[0] := pnDataSource;
  Panels[1] := pnKeyField;
  Panels[2] := pnGridMode;
  Panels[3] := pnGridStyle;
  Panels[4] := pnBands;
  Panels[5] := pnColumns;
  Panels[6] := pnOrder;
  Panels[7] := pnFilter;
  Panels[8] := pnPreview;
  Panels[9] := pnSummaryFooter;
  Panels[10] := pnSummaryGroups;
  Panels[11] := pnBindSummary;
  Panels[12] := pnDesign;
  for I := 0 to PanelCount - 1 do
    Panels[I].Align := alClient;
end;

procedure TFGrWizard.FormShow(Sender: TObject);
begin
  // Start
  ShowPanel(Panels[0]{pnStart});
end;

procedure TFGrWizard.SetButtons;
begin
  BBack.Enabled := CurrentPanel.Tag <> 0;
  BNext.Enabled := CurrentPanel.Tag <> (PanelCount - 1);
  if not BNext.Enabled then
    SetDefaultButton(BBack)
  else
  if not BBack.Enabled then
    SetDefaultButton(BNext);
  BCancel.Cancel := True;
end;

procedure TFGrWizard.SetDefaultButton(Button: TButton);
begin
  Button.Default := True;
  if Button <> BNext then
    BNext.Default := False
  else BBack.Default := False;
end;

procedure TFGrWizard.PostPanel(Panel: TPanel);
var
  Flag: Boolean;
  I, J: Integer;
  C: TdxDBTreeListColumnClass;
  Band: TdxTreeListBand;
  Column: TdxDBTreeListColumn;
begin
  case Panel.Tag of
  5: begin
       // changed ?
       Flag := (DBGrid.ColumnCount <> TL_Columns.Count);
       if not Flag then
       begin
         for I := 0 to DBGrid.ColumnCount - 1 do
         begin
           Flag := (DBGrid.Columns[I].FieldName <> TL_Columns.Items[I].Values[colFieldName.Index]) or
             (DBGrid.Columns[I].ClassName <> TL_Columns.Items[I].Values[colColumnClass.Index]) or
             (DBGrid.Columns[I].Visible <> (TL_Columns.Items[I].Values[colVisible.Index] = 'True'));
           if Flag then Break;
         end;
       end;
       // if changed then ReCreate
       if Flag then
       begin
         with DBGrid do
         begin
           BeginUpdate;
           BeginGrouping;
           try
             DestroyColumns;
             for I := 0 to TL_Columns.Count - 1 do
             begin
               C := TdxDBTreeListColumnClass(GetClass(TL_Columns.Items[I].Values[colColumnClass.Index]));
               if C <> nil then
               begin
                 Column := CreateColumnEx(C, ColumnOwner);
                 Column.FieldName := TL_Columns.Items[I].Values[colFieldName.Index];
                 Column.Visible := TL_Columns.Items[I].Values[colVisible.Index] = 'True';
                 // generate column name
                 GenerateColumnName(Column);
               end;
             end;
           finally
             EndGrouping;
             EndUpdate;
           end;
         end;
         UpdateDesigner;
       end;
     end;
  6: begin
       with DBGrid do
       begin
         BeginUpdate;
         try
           // Orphaned Columns
           for I := 0 to TL_OrphanedColumns.Count - 1 do
           begin
             TdxTreeListColumn(TL_OrphanedColumns.Items[I].Data).BandIndex := -1;
           end;
           // Set Band Order and Visible
           for I := 0 to TL_Visible.Count - 1 do
           begin
             Band := TdxTreeListBand(TL_Visible.Items[I].Data);
             Band.Index := I;
             Band.Visible := TL_Visible.Items[I].StateIndex = indCheck;
           end;
           // Set Column Order and Visible
           for I := 0 to TL_Visible.Count - 1 do
           begin
             Band := TdxTreeListBand(TL_Visible.Items[I].Data);
             for J := 0 to TL_Visible.Items[I].Count - 1 do
             begin
               TdxTreeListColumn(TL_Visible.Items[I][J].Data).BandIndex := Band.Index;
               TdxTreeListColumn(TL_Visible.Items[I][J].Data).Visible :=
                 TL_Visible.Items[I][J].StateIndex in [indCheck, indCheckGrayed];
             end;
           end;
         finally
           EndUpdate;
         end;
         UpdateDesigner;
       end;
     end;
  9: begin
       with DBGrid do
       begin
         BeginUpdate;
         try
           for I := 0 to TL_SummaryFooter.Count - 1 do
           begin
             TdxDBGridColumn(DBGrid.Columns[I]).SummaryFooterField := TL_SummaryFooter.Items[I].Values[colSFFieldName.Index];
             TdxDBGridColumn(DBGrid.Columns[I]).SummaryFooterFormat := TL_SummaryFooter.Items[I].Values[colSFFormat.Index];
             TdxDBGridColumn(DBGrid.Columns[I]).SummaryFooterType := TL_SummaryFooter.Items[I].Values[colSFType.Index];
           end;
         finally
           EndUpdate;
         end;
         UpdateDesigner;
       end;
     end;
  11:begin
       with DBGrid do
       begin
         BeginUpdate;
         try
           for I := 0 to TL_BindSummaryGroups.Count - 1 do
           begin
             TdxDBGridColumn(DBGrid.Columns[I]).SummaryGroupName :=
               TL_BindSummaryGroups.Items[I].Values[colBindSummaryGroup.Index];
           end;
         finally
           EndUpdate;
         end;
         UpdateDesigner;
       end;
     end;
  end;
end;

procedure TFGrWizard.ShowPanel(Panel: TPanel);
var
  I: Integer;
  Node: TdxTreeListNode;
begin
  // Post
  if (CurrentPanel <> nil) and (CurrentPanel <> Panel) then
    PostPanel(CurrentPanel);
  // check popup item
  with pmGroups do
  begin
    for I := 0 to Items.Count - 1 do
      Items[I].Checked := False;
    if (Panel.Tag >= 0) and (Panel.Tag <= (Items.Count - 1)) then
    Items[Panel.Tag].Checked := True;
  end;
  case Panel.Tag of
    0: begin {DataSource}
         // Load Combo Box List
         with CDataSource do
         begin
           Items.BeginUpdate;
           try
             Items.Clear;
             Items.Add('(no DataSource)');
             PDesigner.GetComponentNames(GetTypeData(PtypeInfo(TDataSource.ClassInfo)), LoadDataSource);
  //           if Assigned(DBGrid.DataSource) then
  //             ItemIndex := Items.IndexOf(DBGrid.DataSource.Name);
             if Assigned(DBGrid.DataSource) then
               ItemIndex := Items.IndexOfObject(DBGrid.DataSource);
           finally
             Items.EndUpdate;
           end;
         end;
       end;
    1: begin {KeyField}
         // Load Combo Box List
         with CKeyField do
         begin
           Items.BeginUpdate;
           try
             Items.Clear;
             Items.Add('');
             if Assigned(DBGrid.DataSource) and Assigned(DBGrid.DataSource.DataSet) then
               DBGrid.DataSource.DataSet.GetFieldNames(Items);
             Text := DBGrid.KeyField;
           finally
             Items.EndUpdate;
           end;
         end;
       end;
    2: begin {GridMode}
         if egoLoadAllRecords in DBGrid.Options then
           rbLoadAllRecords.Checked := True
         else
         if DBGrid.PartialLoad then
           rbPartialLoad.Checked := True
         else
           rbGridMode.Checked := True;
         cbSmartReload.Checked := egoSmartReload in DBGrid.Options;
         cbSmartRefresh.Checked := egoSmartRefresh in DBGrid.Options;
       end;
    3: begin {GridStyle}
       end;
    4: begin {Bands}
         LoadBandInfo(nil, nil);
       end;
    5: begin {Columns}
         if (DBGrid <> nil) then
         begin
           LoadAllColumns(DBGrid.ColumnCount = 0{reload});
         end;
       end;
    6: begin
         LoadOrderInfo;
       end;
    7:
      begin
        cbFilterActive.Checked := DBGrid.Filter.Active;
        cbFilterAutoDataSetFilter.Checked := DBGrid.Filter.AutoDataSetFilter;
        cbFilterCaseInsensitive.Checked := DBGrid.Filter.CaseInsensitive;
        cbFilterStatus.ItemIndex := Integer(DBGrid.Filter.FilterStatus);
        udFilterDropDownCount.Position := DBGrid.Filter.DropDownCount;
        udFilterMaxDropDownCount.Position := DBGrid.Filter.MaxDropDownCount;
      end;
    8: begin
         cbShowPreview.Checked := egoPreview in DBGrid.Options;
         with CPreviewField do
         begin
           Items.BeginUpdate;
           try
             Items.Clear;
             Items.Add('');
             if Assigned(DBGrid.DataSource) and Assigned(DBGrid.DataSource.DataSet) then
               DBGrid.DataSource.DataSet.GetFieldNames(Items);
             Text := DBGrid.PreviewFieldName;
           finally
             Items.EndUpdate;
           end;
         end;
         UDPreviewMaxLen.Position := DBGrid.PreviewMaxLength;
         EPreviewFont.Font.Assign(DBGrid.PreviewFont);
         EPreviewFont.Font.Size := BPreviewFont.Font.Size;
         EPreviewFont.Text := ' ' + IntToStr(DBGrid.PreviewFont.Size) + ' ps ' +DBGrid.PreviewFont.Name;
         UDIndentDesc.Position := DBGrid.IndentDesc;
         UDPreviewLines.Position := DBGrid.PreviewLines;
         cbAutoCalcPreviewLines.Checked := egoAutoCalcPreviewLines in DBGrid.OptionsEx;
       end;
    9: begin
         cbShowSummaryFooter.Checked := DBGrid.ShowSummaryFooter;
         // load items
         with TL_SummaryFooter do
         begin
           ClearNodes;
           for I := 0 to DBGrid.ColumnCount - 1 do
           begin
             Node := Add;
             Node.Values[colSFColumnName.Index] := DBGrid.Columns[I].Name;
             Node.Values[colSFFieldName.Index] := TdxDBGridColumn(DBGrid.Columns[I]).SummaryFooterField;
             Node.Values[colSFFormat.Index] := TdxDBGridColumn(DBGrid.Columns[I]).SummaryFooterFormat;
             Node.Values[colSFType.Index] := TdxDBGridColumn(DBGrid.Columns[I]).SummaryFooterType;
           end;
         end;
         // load fields
         with colSFFieldName.Items do
         begin
           Clear;
           if Assigned(DBGrid.Datalink.DataSet) then
           begin
             for I := 0 to DBGrid.Datalink.DataSet.FieldCount - 1 do
               if (DBGrid.Datalink.DataSet.Fields[I] is TNumericField) or
                 (DBGrid.Datalink.DataSet.Fields[I].DataType in [ftDate, ftTime, ftDateTime]) then
                 Add(DBGrid.Datalink.DataSet.Fields[I].FieldName);
           end;
         end;
       end;
    10: begin
         LoadSummaryGroups;
       end;
    11:begin
         // load summary groups
         with colBindSummaryGroup.Items do
         begin
           Clear;
           for I := 0 to DBGrid.SummaryGroups.Count - 1 do
             Add(DBGrid.SummaryGroups[I].Name);
         end;
         // load items
         with TL_BindSummaryGroups do
         begin
           ClearNodes;
           for I := 0 to DBGrid.ColumnCount - 1 do
           begin
             Node := Add;
             Node.Values[colBindColumnName.Index] := DBGrid.Columns[I].Name;
             Node.Values[colBindSummaryGroup.Index] := TdxDBGridColumn(DBGrid.Columns[I]).SummaryGroupName;
           end;
         end;
       end;
    12:begin
         LoadDesignInfo;
       end;
  end;
  CurrentPanel := Panel;
  SetButtons;
  if Panel.Tag in [4, 5, 8, 9, 10, 11] then
  begin
    BNext.Default := False;
    BBack.Default := False;
    BCancel.Cancel := False;
  end;
  Panel.Visible := True;
  // hide other panels
  for I := 0 to PanelCount - 1 do
  begin
    if Panels[I] <> Panel then
      Panels[I].Visible := False;
  end;
end;

procedure TFGrWizard.UpdateDesigner;
begin
  if PDesigner <> nil then PDesigner.Modified;
end;

// Popup Menu
procedure TFGrWizard.BPopupClick(Sender: TObject);
var
  P: TPoint;
begin
  with BPopup do
    P := Parent.ClientToScreen(Point(Left + Width, Top));
  pmGroups.Popup(P.X, P.Y);
end;

// Popup Menu

// PM - miGoBands
procedure TFGrWizard.miGoBandsClick(Sender: TObject);
begin
  ShowPanel(Panels[TMenuItem(Sender).Tag]);
end;

// Back
procedure TFGrWizard.BBackClick(Sender: TObject);
begin
  SetDefaultButton(BBack);
  if CurrentPanel.Tag > 0 then
    ShowPanel(Panels[CurrentPanel.Tag - 1]);
end;

// Next
procedure TFGrWizard.BNextClick(Sender: TObject);
begin
  SetDefaultButton(BNext);
  if CurrentPanel.Tag - 1 < PanelCount then
    ShowPanel(Panels[CurrentPanel.Tag + 1]);
end;

// BCancel - before Close do Post 
procedure TFGrWizard.BCancelClick(Sender: TObject);
begin
  // Post
  if (CurrentPanel <> nil) then PostPanel(CurrentPanel);
end;

// Other Events

// DataSource
procedure TFGrWizard.LoadDataSource(const S: string);
begin
//  CDataSource.Items.Add(S);
  CDataSource.Items.AddObject(S, PDesigner.GetComponent(S));
end;

procedure TFGrWizard.CDataSourceChange(Sender: TObject);
begin
  if DBGrid <> nil then
  with Sender as TComboBox do
  begin
    if (0 <= ItemIndex) and (ItemIndex < Items.Count) then
    begin
      DBGrid.DataSource := TDataSource(PDesigner.GetComponent(Items[ItemIndex]));
      UpdateDesigner;
    end;
  end;
end;

// KeyField
procedure TFGrWizard.CKeyFieldChange(Sender: TObject);
begin
  if DBGrid <> nil then
  with Sender as TComboBox do
  begin
    if (0 <= ItemIndex) and (ItemIndex < Items.Count) then
    begin
      DBGrid.KeyField := Items[ItemIndex];
      UpdateDesigner;
    end;
  end;
end;

procedure TFGrWizard.CKeyFieldExit(Sender: TObject);
begin
  if DBGrid <> nil then
  begin
    with Sender as TComboBox do
      DBGrid.KeyField := Text;
    UpdateDesigner;
  end;
end;

// Grid mode
procedure TFGrWizard.rbGridModeClick(Sender: TObject);
begin
  with Sender as TRadioButton do
  begin
    case Tag of
    0: begin
         DBGrid.Options := DBGrid.Options - [egoLoadAllRecords];
         DBGrid.PartialLoad := False;
       end;
    1: begin
         DBGrid.Options := DBGrid.Options + [egoLoadAllRecords];
         DBGrid.PartialLoad := False;
       end;
    2: begin
         DBGrid.Options := DBGrid.Options - [egoLoadAllRecords];
         DBGrid.PartialLoad := True;
       end;
    end;
{
    if rbGridMode.Checked then
      DBGrid.Options := DBGrid.Options - [egoLoadAllRecords]
    else DBGrid.Options := DBGrid.Options + [egoLoadAllRecords];
}
  end;
  UpdateDesigner;
end;

procedure TFGrWizard.cbSmartReloadClick(Sender: TObject);
begin
  if cbSmartReload.Checked then
    DBGrid.Options := DBGrid.Options + [egoSmartReload]
  else DBGrid.Options := DBGrid.Options - [egoSmartReload];
  UpdateDesigner;
end;

procedure TFGrWizard.cbSmartRefreshClick(Sender: TObject);
begin
  if cbSmartRefresh.Checked then
    DBGrid.Options := DBGrid.Options + [egoSmartRefresh]
  else DBGrid.Options := DBGrid.Options - [egoSmartRefresh];
  UpdateDesigner;
end;

// select Grid Style
procedure TFGrWizard.TL_StyleDblClick(Sender: TObject);
begin
  with DBGrid do
  begin
    BeginUpdate;
    BeginGrouping;
    try
      case TL_Style.FocusedNumber of
      0: begin // Input Data
           ShowNewItemRow := True;
           ShowGroupPanel := False;
           ShowSummaryFooter := False;
           ShowBands := False;
           Options := Options + [egoEditing, egoTabs, egoTabThrough,
             egoCanDelete, egoCanAppend, egoCanInsert, egoImmediateEditor,
             egoIndicator, egoResetColumnFocus, egoCanNavigation];
           Options := Options - [egoPreview];
           OptionsEx := OptionsEx + [egoInvertSelect, egoHorzThrough,
             egoVertThrough, egoBandHeaderWidth,
             egoEnterShowEditor, egoEnterThrough, egoShowButtonAlways];
         end;
      1: begin // Grouping Mode
           ShowNewItemRow := False;
           ShowGroupPanel := True;
           ShowSummaryFooter := False;
           ShowBands := False;
           Options := Options + [egoPreview];
           Options := Options - [egoTabs, egoIndicator];
           OptionsEx := OptionsEx + [egoBandHeaderWidth, egoNotHideColumn];
           if egoLoadAllRecords in Options then
             OptionsEx := OptionsEx + [egoAutoCalcPreviewLines]
           else OptionsEx := OptionsEx - [egoAutoCalcPreviewLines];
         end;
      2: begin // Multi Band Style
           ShowNewItemRow := False;
           ShowGroupPanel := False;
           ShowSummaryFooter := False;
           ShowBands := True;
           Options := Options + [egoEditing, egoTabs, egoTabThrough,
             egoCanDelete, egoCanAppend, egoCanInsert, egoImmediateEditor,
             egoIndicator, egoResetColumnFocus, egoCanNavigation];
           Options := Options - [egoPreview];
           OptionsEx := OptionsEx + [egoInvertSelect, egoHorzThrough,
             egoVertThrough, egoFullSizing];
           OptionsEx := OptionsEx - [egoBandHeaderWidth];
           HeaderMinRowCount := 2;
         end;
      3: begin // Fixed Band, Footer
           ShowNewItemRow := False;
           ShowGroupPanel := False;
           ShowSummaryFooter := True;
           ShowBands := True;
           Options := Options + [egoEditing, egoTabs, egoTabThrough,
             egoCanDelete, egoCanAppend, egoCanInsert, egoImmediateEditor,
             egoIndicator, egoResetColumnFocus, egoCanNavigation];
           Options := Options - [egoPreview];
           OptionsEx := OptionsEx + [egoInvertSelect, egoHorzThrough,
             egoVertThrough, egoFullSizing];
           OptionsEx := OptionsEx - [egoBandHeaderWidth];
           // create bands
           if Bands.Count <= 1 then
           begin
             Bands.Add.Fixed := bfLeft;
             Bands.Add.Fixed := bfRight;
           end;
           // move columns
           if ColumnCount > 3 then
           begin
             if Columns[0].Visible then
               Columns[0].BandIndex := 0;
             if Columns[ColumnCount - 1].Visible then
               Columns[ColumnCount - 1].BandIndex := Bands.VisibleCount - 1;
           end;
         end;
      end;
    finally
      EndGrouping;
      EndUpdate;
    end;
  end;
  BNext.Click;
end;

// Bands
procedure TFGrWizard.LoadBandInfo(TopBand, Band: TdxTreeListBand);
var
  I: Integer;
begin
  with TL_Bands do
  begin
    BeginUpdate;
    try
      HideEditor;
      ClearNodes;
      for I := 0 to DBGrid.Bands.Count - 1 do
      begin
        Add;
        Items[Count - 1].Values[colBandCaption.Index] := DBGrid.Bands[I].Caption;
        Items[Count - 1].Values[colBandAlignment.Index] := IntToStr(Integer(DBGrid.Bands[I].Alignment));
        if DBGrid.Bands[I].Visible then
          Items[Count - 1].Values[colBandVisible.Index] := 'True'
        else Items[Count - 1].Values[colBandVisible.Index] := 'False';
        Items[Count - 1].Values[colBandFixed.Index] := IntToStr(Integer(DBGrid.Bands[I].Fixed));
      end;
      if (Band <> nil) and (TopBand <> nil) then
        for I := 0 to DBGrid.Bands.Count - 1 do
        begin
          if DBGrid.Bands[I] = TopBand then
            TopIndex := I;
          if DBGrid.Bands[I] = Band then
          begin
            Items[I].Focused := True;
            Items[I].MakeVisible;
            Break;
          end;
        end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TFGrWizard.colBandCaptionCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if ANode.Values[colBandVisible.Index] <> 'True' then
    AFont.Color := clBtnFace;
end;

procedure TFGrWizard.TL_BandsEdited(Sender: TObject; Node: TdxTreeListNode);
var
  B: TdxTreeListBand;
  Flag: Boolean;
begin
  with DBGrid do
  begin
    Flag := False;
    B := Bands[Node.Index];
    if B.Caption <> Node.Values[colBandCaption.Index] then
    begin
      B.Caption := Node.Values[colBandCaption.Index];
      Flag := True;
    end;
    if B.Alignment <> TAlignment(StrToInt(Node.Values[colBandAlignment.Index])) then
    begin
      B.Alignment := TAlignment(StrToInt(Node.Values[colBandAlignment.Index]));
      Flag := True;
    end;
    if B.Visible <> (Node.Values[colBandVisible.Index] = 'True') then
    begin
      B.Visible := (Node.Values[colBandVisible.Index] = 'True');
      Flag := True;
    end;
    if B.Fixed <> TdxGridBandFixed(StrToInt(Node.Values[colBandFixed.Index])) then
    begin
      B.Fixed := TdxGridBandFixed(StrToInt(Node.Values[colBandFixed.Index]));
      Flag := True;
    end;
    if Flag then
    begin
      UpdateDesigner;
      LoadBandInfo(B, B);
    end;
  end;
end;

procedure TFGrWizard.colBandAlignmentCloseUp(Sender: TObject;
  var Value: String; var Accept: Boolean);
var
  B, BTop: TdxTreeListBand;
begin
  if Accept and (TL_Bands.FocusedNode <> nil) then
  with DBGrid do
  begin
    if TL_Bands.TopVisibleNode <> nil then
      BTop := Bands[TL_Bands.TopVisibleNode.Index]
    else BTop := nil;
    B := Bands[TL_Bands.FocusedNode.Index];
    B.Alignment := TAlignment(StrToInt(Value));
    UpdateDesigner;
    LoadBandInfo(BTop, B);
  end;
end;

procedure TFGrWizard.colBandVisibleToggleClick(Sender: TObject;
  const Text: String; State: TdxCheckBoxState);
var
  B, BTop: TdxTreeListBand;
begin
  if TL_Bands.FocusedNode <> nil then
  with DBGrid do
  begin
    if TL_Bands.TopVisibleNode <> nil then
      BTop := Bands[TL_Bands.TopVisibleNode.Index]
    else BTop := nil;
    B := Bands[TL_Bands.FocusedNode.Index];
    B.Visible := (Text = 'True');
    UpdateDesigner;
    LoadBandInfo(BTop, B);
  end;
end;

procedure TFGrWizard.colBandFixedCloseUp(Sender: TObject;
  var Value: String; var Accept: Boolean);
var
  B, BTop: TdxTreeListBand;
begin
  if Accept and (TL_Bands.FocusedNode <> nil) then
  with DBGrid do
  begin
    if TL_Bands.TopVisibleNode <> nil then
      BTop := Bands[TL_Bands.TopVisibleNode.Index]
    else BTop := nil;
    B := Bands[TL_Bands.FocusedNode.Index];
    B.Fixed := TdxGridBandFixed(StrToInt(Value));
    UpdateDesigner;
    LoadBandInfo(BTop, B);
  end;
end;

procedure TFGrWizard.sbBandUpClick(Sender: TObject);
var
  B, BTop: TdxTreeListBand;
begin
  if TL_Bands.FocusedNode <> nil then
  with DBGrid do
  begin
    if TL_Bands.TopVisibleNode <> nil then
      BTop := Bands[TL_Bands.TopVisibleNode.Index]
    else BTop := nil;
    B := Bands[TL_Bands.FocusedNode.Index];
    B.Index := B.Index - 1;
    UpdateDesigner;
    LoadBandInfo(BTop, B);
  end;
end;

procedure TFGrWizard.sbBandDownClick(Sender: TObject);
var
  B, BTop: TdxTreeListBand;
begin
  if TL_Bands.FocusedNode <> nil then
  with DBGrid do
  begin
    if TL_Bands.TopVisibleNode <> nil then
      BTop := Bands[TL_Bands.TopVisibleNode.Index]
    else BTop := nil;
    B := Bands[TL_Bands.FocusedNode.Index];
    B.Index := B.Index + 1;
    UpdateDesigner;
    LoadBandInfo(BTop, B);
  end;
end;

procedure TFGrWizard.sbBandAddClick(Sender: TObject);
begin
  TL_Bands.BeginUpdate;
  try
    TL_Bands.HideEditor;
    DBGrid.Bands.Add;
    UpdateDesigner;
    LoadBandInfo(nil, nil);
    TL_Bands.FocusedNumber := TL_Bands.Count - 1;
    TL_Bands.FocusedNode.MakeVisible;
  finally
    TL_Bands.EndUpdate;
  end;
end;

procedure TFGrWizard.sbBandDeleteClick(Sender: TObject);
var
  I: Integer;
begin
  if TL_Bands.FocusedNode <> nil then
  begin
    TL_Bands.BeginUpdate;
    try
      TL_Bands.HideEditor;
      I := TL_Bands.FocusedNode.Index;
      DBGrid.Bands[I].Free;
      UpdateDesigner;
      LoadBandInfo(nil, nil);
      if TL_Bands.Count > 0 then
      begin
        if I > (TL_Bands.Count - 1) then
          I := TL_Bands.Count - 1;
        TL_Bands.FocusedNumber := I;
        TL_Bands.FocusedNode.MakeVisible;
      end;
    finally
      TL_Bands.EndUpdate;
    end;
  end;
end;

// Columns
procedure TFGrWizard.LoadAllColumns(Reload: Boolean);
var
  I: Integer;
begin
  if (DBGrid <> nil) then
  with DBGrid do
  begin
    TL_Columns.BeginUpdate;
    try
      // load columns classes
      with colColumnClass.Items do
      begin
        Clear;
        for I := 0 to ADBGroupListColumns.Count - 1 do
          Add(ADBGroupListColumns[I]);
        colColumnClass.DropDownRows := colColumnClass.Items.Count;
      end;
      TL_Columns.ClearNodes;
      if Reload then
      begin
        if Assigned(DataLink.DataSet) then
          for I := 0 to DataLink.DataSet.FieldCount - 1 do
          begin
            TL_Columns.Add;
            TL_Columns.Items[I].Values[colFieldName.Index] := DataLink.DataSet.Fields[I].FieldName;
            TL_Columns.Items[I].Values[colColumnClass.Index] :=
              DBGrid.GetDefaultFieldColumnClass(DataLink.DataSet.Fields[I]).ClassName;
            if DataLink.DataSet.Fields[I].Visible then
              TL_Columns.Items[I].Values[colVisible.Index] := 'True'
            else TL_Columns.Items[I].Values[2] := 'False';
          end;
      end
      else
      begin
        for I := 0 to DBGrid.ColumnCount - 1 do
        begin
          TL_Columns.Add;
          TL_Columns.Items[I].Values[colFieldName.Index] := DBGrid.Columns[I].FieldName;
          TL_Columns.Items[I].Values[colColumnClass.Index] := DBGrid.Columns[I].ClassName;
          if DBGrid.Columns[I].Visible then
            TL_Columns.Items[I].Values[colVisible.Index] := 'True'
          else TL_Columns.Items[I].Values[2] := 'False';
        end;
      end;
    finally
      TL_Columns.EndUpdate;
    end;
  end;
end;

procedure TFGrWizard.colFieldNameCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if ANode.Values[colVisible.Index] <> 'True' then
    AFont.Color := clBtnFace;
end;

procedure TFGrWizard.sbColumnUpClick(Sender: TObject);
begin
  with TL_Columns do
    if (FocusedNode <> nil) and (FocusedNode.Index > 0) then
      FocusedNode.MoveTo(FocusedNode.GetPriorNode, natlInsert);
end;

procedure TFGrWizard.sbColumnDownClick(Sender: TObject);
var
  I: Integer;
begin
  with TL_Columns do
    if (FocusedNode <> nil) and (FocusedNode.Index < (Count - 1)) then
    begin
      I := TopIndex;
      if FocusedNode.Index = (Count - 2) then
        FocusedNode.MoveTo(FocusedNode.GetNextNode, natlAdd)
      else FocusedNode.MoveTo(FocusedNode.GetNextNode.GetNextNode, natlInsert);
      TopIndex := I;
      FocusedNode.MakeVisible;
    end;
end;

procedure TFGrWizard.sbColumnDeleteClick(Sender: TObject);
var
  Node: TdxTreeListNode;
begin
  with TL_Columns do
    if (FocusedNode <> nil) then
    begin
      Node := FocusedNode.GetNextNode;
      if Node = nil then Node := FocusedNode.GetPriorNode;
      FocusedNode.Free;
      if Node <> nil then
      begin
        Node.Focused := True;
        Node.MakeVisible;
      end;
    end;
end;

procedure TFGrWizard.sbColumnAllClick(Sender: TObject);
begin
  LoadAllColumns(True{reload});
end;

// Order
function GetBandCaption(B: TdxTreeListBand): string;
begin
  if B.Caption <> '' then
    Result := B.Caption
  else Result := '(Band '+IntToStr(B.Index)+')';
end;

function GetColumnCaption(C: TdxTreeListColumn): string;
begin
  if C.Caption <> '' then
    Result := C.Caption
  else Result := '(' + C.Name + ')';
end;

procedure TFGrWizard.LoadOrderInfo;
var
  I, J: Integer;
  Node, NodeChild: TdxTreeListNode;
begin
  with TL_Visible do
  begin
    BeginUpdate;
    try
      ClearNodes;
      // Bands
      for I := 0 to DBGrid.Bands.Count - 1 do
      begin
        Node := Add;
        Node.ImageIndex := indBand;
        Node.SelectedIndex := indBand;
        Node.StateIndex := indUnCheck + Byte(DBGrid.Bands[I].Visible);
        Node.Values[0] := GetBandCaption(DBGrid.Bands[I]);
        Node.Data := DBGrid.Bands[I];
        // Columns
        for J := 0 to DBGrid.ColumnCount - 1 do
        begin
          if DBGrid.Columns[J].BandIndex = I then
          begin
            NodeChild := Node.AddChild;
            NodeChild.ImageIndex := indColumn;
            NodeChild.SelectedIndex := indColumn;
            NodeChild.StateIndex := indUnCheck + Byte(DBGrid.Columns[J].Visible);
            NodeChild.Values[0] := GetColumnCaption(DBGrid.Columns[J]);
            NodeChild.Data := DBGrid.Columns[J];
          end;
        end;
      end;
      FullExpand;
    finally
      EndUpdate;
    end;
  end;
  with TL_OrphanedColumns do
  begin
    ClearNodes;
    BeginUpdate;
    try
      for I := 0 to DBGrid.ColumnCount - 1 do
        if DBGrid.Columns[I].BandIndex = -1 then
        begin
          Node := Add;
          Node.ImageIndex := indColumn;
          Node.SelectedIndex := indColumn;
          Node.StateIndex := indUnCheck + Byte(DBGrid.Columns[I].Visible);
          Node.Values[0] := GetColumnCaption(DBGrid.Columns[I]);
          Node.Data := DBGrid.Columns[I];
        end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TFGrWizard.TL_VisibleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  HitInfo: TdxTreeListHitInfo;
begin
  with Sender as TdxTreeList do
  begin
    HitInfo := GetHitInfo(Point(X, Y));
    if HitInfo.hitType = htStateIcon then
    begin
      if HitInfo.Node.StateIndex in [indUnCheck, indUnCheckGrayed] then
        HitInfo.Node.StateIndex := indUnCheck + 1
      else HitInfo.Node.StateIndex := indUnCheck;
      if HitInfo.Node.HasChildren and HitInfo.Node.Expanded then
        Invalidate;
    end;
  end;
end;

procedure TFGrWizard.TL_VisibleGetStateIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
begin
  if Node.Parent <> nil then
    if Node.Parent.StateIndex = indUnCheck then
       Index := Index + 2;
end;

procedure TFGrWizard.TL_OrphanedColumnsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = TL_Visible then Accept := True;
end;

procedure TFGrWizard.TL_OrphanedColumnsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  I: Integer;
  Node: TdxTreeListNode;
begin
  if Source = TL_Visible then
  with TL_Visible do
  begin
    if DragNode <> nil then
    begin
      for I := SelectedCount - 1 downto 0 do
        if SelectedNodes[I].Level = 1 then
        begin
          Node := TL_OrphanedColumns.Add;
          Node.Data := SelectedNodes[I].Data;
          Node.Values[0] := SelectedNodes[I].Values[0];
          Node.ImageIndex := SelectedNodes[I].ImageIndex;
          Node.SelectedIndex := SelectedNodes[I].SelectedIndex;
          Node.StateIndex := SelectedNodes[I].StateIndex;
          if Node.StateIndex > indCheck then{grayed}
            Node.StateIndex := Node.StateIndex - 2;
          SelectedNodes[I].Free;
        end;
    end;
  end;
end;

procedure TFGrWizard.TL_VisibleBeginDragNode(Sender: TObject;
  Node: TdxTreeListNode);
var
  I, J: Integer;
  List: TList;
  ANode: TdxTreeListNode;
begin
  with TL_Visible do
  begin
    List := TList.Create;
    try
      for I := 0 to SelectedCount - 1 do
        List.Add(SelectedNodes[I]);
      for I := 0 to List.Count - 1 do
      begin
        ANode := TdxTreeListNode(List[I]);
        if ANode.HasChildren then
        begin
          for J := 0 to ANode.Count - 1 do
            ANode[J].Selected := True;
        end;
      end;
    finally
      List.Free;
    end;
  end;
end;

procedure TFGrWizard.TL_VisibleDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TFGrWizard.TL_VisibleDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  HitInfo: TdxTreeListHitInfo;
  Node, NewNode: tdxTreeListNode;
  I: Integer;
  AttachMode: TdxTreeListNodeAttachMode;
begin
  with TL_Visible do
  begin
    BeginUpdate;
    try
      HitInfo := GetHitInfo(Point(X, Y));
      if HitInfo.Node <> nil then
      begin
        Node := HitInfo.Node;
        if Node.Level = 0 then
          AttachMode := natlAddChild
        else AttachMode := natlInsert;
        if Source = TL_Visible then
        begin
          for I := SelectedCount - 1 downto 0 do
            if SelectedNodes[I].Level = 1 then
              SelectedNodes[I].MoveTo(Node, AttachMode);
        end
        else
        begin
          for I := TL_OrphanedColumns.SelectedCount - 1 downto 0 do
          begin
            NewNode := Add;
            NewNode.Data := TL_OrphanedColumns.SelectedNodes[I].Data;
            NewNode.Values[0] := TL_OrphanedColumns.SelectedNodes[I].Values[0];
            NewNode.ImageIndex := TL_OrphanedColumns.SelectedNodes[I].ImageIndex;
            NewNode.SelectedIndex := TL_OrphanedColumns.SelectedNodes[I].SelectedIndex;
            NewNode.StateIndex := TL_OrphanedColumns.SelectedNodes[I].StateIndex;
            TL_OrphanedColumns.SelectedNodes[I].Free;
            NewNode.MoveTo(Node, AttachMode);
          end;
        end;
        if Node.Level = 0 then Node.Expanded := True;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

// Preview
procedure TFGrWizard.CPreviewFieldChange(Sender: TObject);
begin
  if DBGrid <> nil then
  with Sender as TComboBox do
  begin
    if (0 <= ItemIndex) and (ItemIndex < Items.Count) then
    begin
      DBGrid.PreviewFieldName := Items[ItemIndex];
      UpdateDesigner;
    end;
  end;
end;

procedure TFGrWizard.CPreviewFieldExit(Sender: TObject);
begin
  if DBGrid <> nil then
  begin
    with Sender as TComboBox do
      DBGrid.PreviewFieldName := Text;
    UpdateDesigner;
  end;
end;

procedure TFGrWizard.cbShowPreviewClick(Sender: TObject);
begin
  with Sender as TCheckBox do
  begin
    if Checked then
      DBGrid.Options := DBGrid.Options + [egoPreview]
    else DBGrid.Options := DBGrid.Options - [egoPreview];
    UpdateDesigner;
  end;
end;

procedure TFGrWizard.BPreviewFontClick(Sender: TObject);
begin
  with FontDialog do
  begin
    Font.Assign(DBGrid.PreviewFont);
    if Execute then
      DBGrid.PreviewFont.Assign(Font);
    EPreviewFont.Font.Assign(DBGrid.PreviewFont);
    EPreviewFont.Font.Size := BPreviewFont.Font.Size;
    EPreviewFont.Text := ' ' + IntToStr(DBGrid.PreviewFont.Size) + ' ps ' +DBGrid.PreviewFont.Name;
    UpdateDesigner;
  end;
end;

procedure TFGrWizard.cbAutoCalcPreviewLinesClick(Sender: TObject);
begin
  with Sender as TCheckBox do
  begin
    if Checked then
      DBGrid.OptionsEx := DBGrid.OptionsEx + [egoAutoCalcPreviewLines]
    else DBGrid.OptionsEx := DBGrid.OptionsEx - [egoAutoCalcPreviewLines];
    UpdateDesigner;
  end;
end;

procedure TFGrWizard.EPreviewMaxLenExit(Sender: TObject);
begin
  DBGrid.PreviewMaxLength := StrToInt(EPreviewMaxLen.Text);
  UDPreviewMaxLen.Position := DBGrid.PreviewMaxLength;
end;

procedure TFGrWizard.EIndentDescExit(Sender: TObject);
begin
  DBGrid.IndentDesc := StrToInt(EIndentDesc.Text);
  UDIndentDesc.Position := DBGrid.IndentDesc;
end;

procedure TFGrWizard.EPreviewLinesExit(Sender: TObject);
begin
  DBGrid.PreviewLines := StrToInt(EPreviewLines.Text);
  UDPreviewLines.Position := DBGrid.PreviewLines;
end;

procedure TFGrWizard.UDPreviewMaxLenClick(Sender: TObject;
  Button: TUDBtnType);
begin
  with Sender as TUpDown do
  begin
    DBGrid.PreviewMaxLength := Position;
    Position := DBGrid.PreviewMaxLength;
  end;
end;

procedure TFGrWizard.UDIndentDescClick(Sender: TObject;
  Button: TUDBtnType);
begin
  with Sender as TUpDown do
  begin
    DBGrid.IndentDesc := Position;
    Position := DBGrid.IndentDesc;
  end;
end;

procedure TFGrWizard.UDPreviewLinesClick(Sender: TObject;
  Button: TUDBtnType);
begin
  with Sender as TUpDown do
  begin
    DBGrid.PreviewLines := Position;
    Position := DBGrid.PreviewLines;
  end;
end;

procedure TFGrWizard.EPreviewMaxLenKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then EPreviewMaxLenExit(nil);
end;

procedure TFGrWizard.EIndentDescKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then EIndentDescExit(nil);
end;

procedure TFGrWizard.EPreviewLinesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then EPreviewLinesExit(nil);
end;

// ShowSummaryFooter
procedure TFGrWizard.cbShowSummaryFooterClick(Sender: TObject);
begin
  with Sender as TCheckBox do
  begin
    DBGrid.ShowSummaryFooter := Checked;
    cbShowSummaryFooter.Checked := DBGrid.ShowSummaryFooter;
  end;
end;

procedure TFGrWizard.colSFColumnNameCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if not DBGrid.Columns[ANode.Index].Visible then
    AFont.Color := clBtnFace;
end;

// SummaryGroups
procedure TFGrWizard.LoadSummaryGroups;
var
  I, J: Integer;
  Node, NodeChild: TdxTreeListNode;
  Item: TdxDBGridSummaryItem;
begin
  // load groups
  with TL_SummaryGroups do
  begin
    ClearNodes;
    for I := 0 to DBGrid.SummaryGroups.Count - 1 do
    begin
      Node := Add;
      Node.Data := DBGrid.SummaryGroups[I];
      Node.Values[colSGColumnName.Index] := DBGrid.SummaryGroups[I].Name;
      if DBGrid.SummaryGroups[I].DefaultGroup then J := 16
      else J := 14;
      Node.ImageIndex := J;
      Node.SelectedIndex := J;
      // load items
      for J := 0 to DBGrid.SummaryGroups[I].SummaryItems.Count - 1 do
      begin
        Item := DBGrid.SummaryGroups[I].SummaryItems[J];
        NodeChild := Node.AddChild;
        NodeChild.Data :=Item;
        NodeChild.ImageIndex := 15;
        NodeChild.SelectedIndex := 15;
        NodeChild.Values[colSGColumnName.Index] := Item.ColumnName;
        NodeChild.Values[colSGSummaryField.Index] := Item.SummaryField;
        NodeChild.Values[colSGSummaryFormat.Index] := Item.SummaryFormat;
        NodeChild.Values[colSGSummaryType.Index] := IntToStr(Integer(Item.SummaryType));
      end;
    end;
    FullExpand;
  end;
end;

procedure TFGrWizard.cbShowRowFooterClick(Sender: TObject);
begin
  with Sender as TCheckBox do
  begin
    DBGrid.ShowRowFooter := Checked;
    cbShowRowFooter.Checked := DBGrid.ShowRowFooter;
  end;
end;

procedure TFGrWizard.TL_SummaryGroupsEditing(Sender: TObject;
  Node: TdxTreeListNode; var Allow: Boolean);
begin
  if Node.Level = 0 then Allow := False;
end;

type
  TdxTreeListCrack = class(TdxTreeList);

procedure TFGrWizard.TL_SummaryGroupsCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
var
  R: TRect;
  AIndent, AImageIndent: Integer;
begin
  if (ANode.Level = 0) then
  with ACanvas do
  begin
    R := ARect;
    TdxTreeListCrack(TL_SummaryGroups).GetNodeIndent(ANode, AIndent, AImageIndent);
    R.Left := AImageIndent;
    R.Right := ClientRect.Right - 1;
    if ANode.Selected then
    begin
      Brush.Color := clHighlight;
      Font.Color := clHighlightText;
    end
    else
    begin
      Brush.Color := cl3DLight{clBtnFace};
      if TdxDBGridSummaryGroup(ANode.Data).DefaultGroup then
        Font.Style := [fsBold{fsItalic}];
{        Font.Color := clHighlight
      else }Font.Color := clBtnText;
    end;
    FillRect(R);
    ARect := R;
    InflateRect(ARect, -2, -1);
//    Font.Style := [fsBold{fsItalic}];
    SetBkMode(Handle, TRANSPARENT);
    AText := ANode.Values[colSGColumnName.Index];
    DrawText(Handle, PChar(AText), Length(AText), ARect,
      DT_EXPANDTABS or DT_NOPREFIX or DT_END_ELLIPSIS or DT_VCENTER or DT_SINGLELINE);
    ADone := True;
  end;
end;

procedure TFGrWizard.sbAddSummaryGroupClick(Sender: TObject);
var
  Node: TdxTreeListNode;
begin
  if ShowSummaryGroupWizard(Self) then
    with TdxTreeListCrack(TL_SummaryGroups) do
    begin
      LoadSummaryGroups;
      if Count > 0 then
      begin
        Node := Items[Count - 1];
        if Node.Count > 0 then
          Node := Node[Node.Count - 1];
        Node.Focused := True;
        Node.MakeVisible;
      end;
    end;
end;

procedure TFGrWizard.TL_SummaryGroupsCollapsing(Sender: TObject;
  Node: TdxTreeListNode; var Allow: Boolean);
begin
  Allow := False;
end;

procedure TFGrWizard.sbDeleteSummatyGroupClick(Sender: TObject);
var
  PrevTopIndex, PrevIndex: Integer;
begin
  with TdxTreeListCrack(TL_SummaryGroups) do
  if FocusedNode <> nil then
  begin
    PrevTopIndex := TopIndex;
    PrevIndex := FocusedNumber;
    // delete
    TObject(FocusedNode.Data).Free;
    // refresh nodes
    LoadSummaryGroups;
    if Count > 0 then
    begin
      TopIndex := PrevTopIndex;
      FocusedNumber := PrevIndex;
      FocusedNode.MakeVisible;
    end;
  end;
end;

// Design
procedure SetFontColor(APanel: TPanel; AFont: TFont; AColor: TColor);
var
  PrevSize: Integer;
begin
  PrevSize := APanel.Font.Size;
  APanel.Font.Assign(AFont);
  APanel.Font.Size := PrevSize;
  APanel.Caption := ' ' + IntToStr(AFont.Size) + ' ps ' + AFont.Name;
  APanel.Color := AColor;
end;

procedure SetBkTextColor(APanel: TPanel; AFont: TFont; ABkColor, ATextColor: TColor);
begin
  APanel.Color := ABkColor;
  APanel.Font.Color := ATextColor;
  APanel.Caption := ' ' + IntToStr(AFont.Size) + ' ps ' + AFont.Name;
end;

procedure TFGrWizard.LoadDesignInfo;
begin
  with DBGrid do
  begin
    cbShowBands.Checked := ShowBands;
    cbShowHeader.Checked := ShowHeader;
    cbShowGroupPanel.Checked := ShowGroupPanel;
    sbShowRowFooter.Checked := ShowRowFooter;
    cbShowGrid.Checked := ShowGrid;
    cbShowPreviewGrid.Checked := ShowPreviewGrid;
    cbShowNewItemRow.Checked := ShowNewItemRow;
    cbSummaryFooter.Checked := ShowSummaryFooter;
    cbPreview.Checked := egoPreview in Options;
    cbIndicator.Checked := egoIndicator in Options;
    SPColorGrid.Pen.Color := GridLineColor;
    SetFontColor(PFontBand, BandFont, BandColor);
    SetFontColor(PFontHeader, HeaderFont, HeaderColor);
    SetBkTextColor(PTextGroupPanel, DBGrid.Font, GroupPanelColor, GroupPanelFontColor);
    SetBkTextColor(PTextRowFooter, DBGrid.Font, RowFooterColor, RowFooterTextColor);
  end;
end;

procedure TFGrWizard.BFontBandClick(Sender: TObject);
begin
  with FontDialog do
  begin
    Font.Assign(DBGrid.BandFont);
    if Execute then
      DBGrid.BandFont.Assign(Font);
    LoadDesignInfo;
    UpdateDesigner;
  end;
end;

procedure TFGrWizard.BFontHeaderClick(Sender: TObject);
begin
  with FontDialog do
  begin
    Font.Assign(DBGrid.HeaderFont);
    if Execute then
      DBGrid.HeaderFont.Assign(Font);
    LoadDesignInfo;
    UpdateDesigner;
  end;
end;

procedure TFGrWizard.DoColorDialog(Id: Integer);
begin
  with ColorDialog do
  begin
    case Id of
    0: Color := DBGrid.BandColor;
    1: Color := DBGrid.HeaderColor;
    2: Color := DBGrid.GroupPanelFontColor;
    3: Color := DBGrid.GroupPanelColor;
    4: Color := DBGrid.RowFooterTextColor;
    5: Color := DBGrid.RowFooterColor;
    6: Color := DBGrid.GridLineColor;
    end;
    if Execute then
    case Id of
      0: DBGrid.BandColor := Color;
      1: DBGrid.HeaderColor := Color;
      2: DBGrid.GroupPanelFontColor := Color;
      3: DBGrid.GroupPanelColor := Color;
      4: DBGrid.RowFooterTextColor := Color;
      5: DBGrid.RowFooterColor := Color;
      6: DBGrid.GridLineColor := Color;
    end;
    LoadDesignInfo;
    UpdateDesigner;
  end;
end;

procedure TFGrWizard.BColorBandClick(Sender: TObject);
begin
  DoColorDialog(TComponent(Sender).Tag);
end;

procedure TFGrWizard.cbShowBandsClick(Sender: TObject);
begin
  DBGrid.ShowBands := cbShowBands.Checked;
  LoadDesignInfo;
  UpdateDesigner;
end;

procedure TFGrWizard.cbShowHeaderClick(Sender: TObject);
begin
  DBGrid.ShowHeader := cbShowHeader.Checked;
  LoadDesignInfo;
  UpdateDesigner;
end;

procedure TFGrWizard.cbShowGroupPanelClick(Sender: TObject);
begin
  DBGrid.ShowGroupPanel := cbShowGroupPanel.Checked;
  LoadDesignInfo;
  UpdateDesigner;
end;

procedure TFGrWizard.sbShowRowFooterClick(Sender: TObject);
begin
  DBGrid.ShowRowFooter := sbShowRowFooter.Checked;
  LoadDesignInfo;
  UpdateDesigner;
end;

procedure TFGrWizard.cbShowGridClick(Sender: TObject);
begin
  DBGrid.ShowGrid := cbShowGrid.Checked;
  LoadDesignInfo;
  UpdateDesigner;
end;

procedure TFGrWizard.cbShowPreviewGridClick(Sender: TObject);
begin
  DBGrid.ShowPreviewGrid := cbShowPreviewGrid.Checked;
  LoadDesignInfo;
  UpdateDesigner;
end;

procedure TFGrWizard.cbShowNewItemRowClick(Sender: TObject);
begin
  DBGrid.ShowNewItemRow := cbShowNewItemRow.Checked;
  LoadDesignInfo;
  UpdateDesigner;
end;

procedure TFGrWizard.cbSummaryFooterClick(Sender: TObject);
begin
  DBGrid.ShowSummaryFooter := cbSummaryFooter.Checked;
  LoadDesignInfo;
  UpdateDesigner;
end;

procedure TFGrWizard.cbPreviewClick(Sender: TObject);
begin
  cbShowPreviewClick(Sender);
  LoadDesignInfo;
end;

procedure TFGrWizard.cbIndicatorClick(Sender: TObject);
begin
  if cbIndicator.Checked then
    DBGrid.Options := DBGrid.Options + [egoIndicator]
  else DBGrid.Options := DBGrid.Options - [egoIndicator];
  LoadDesignInfo;
  UpdateDesigner;
end;

// Filter

procedure TFGrWizard.cbFilterActiveClick(Sender: TObject);
begin
  DBGrid.Filter.Active := cbFilterActive.Checked;
end;

procedure TFGrWizard.cbFilterAutoDataSetFilterClick(Sender: TObject);
begin
  DBGrid.Filter.AutoDataSetFilter := cbFilterAutoDataSetFilter.Checked;
end;

procedure TFGrWizard.cbFilterCaseInsensitiveClick(Sender: TObject);
begin
  DBGrid.Filter.CaseInsensitive := cbFilterCaseInsensitive.Checked;
end;

procedure TFGrWizard.cbFilterStatusChange(Sender: TObject);
begin
  DBGrid.Filter.FilterStatus := TdxDBGridFilterStatus(cbFilterStatus.ItemIndex);
end;

procedure TFGrWizard.edFilterDropDownCountExit(Sender: TObject);
begin
  DBGrid.Filter.DropDownCount := StrToInt(edFilterDropDownCount.Text);
  udFilterDropDownCount.Position := DBGrid.Filter.DropDownCount;
end;

procedure TFGrWizard.edFilterDropDownCountKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then edFilterDropDownCountExit(nil);
end;

procedure TFGrWizard.udFilterDropDownCountClick(Sender: TObject;
  Button: TUDBtnType);
begin
  with Sender as TUpDown do
  begin
    DBGrid.Filter.DropDownCount := Position;
    Position := DBGrid.Filter.DropDownCount;
  end;
end;

procedure TFGrWizard.edFilterMaxDropDownCountExit(Sender: TObject);
begin
  DBGrid.Filter.MaxDropDownCount := StrToInt(edFilterMaxDropDownCount.Text);
  udFilterMaxDropDownCount.Position := DBGrid.Filter.MaxDropDownCount;
end;

procedure TFGrWizard.edFilterMaxDropDownCountKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then edFilterMaxDropDownCountExit(nil);
end;

procedure TFGrWizard.udFilterMaxDropDownCountClick(Sender: TObject;
  Button: TUDBtnType);
begin
  with Sender as TUpDown do
  begin
    DBGrid.Filter.MaxDropDownCount := Position;
    Position := DBGrid.Filter.MaxDropDownCount;
  end;
end;

end.
