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

unit dxPSfmLnkAdd;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Registry,
  ExtCtrls, StdCtrls, ComCtrls, Menus, ImgList, dxPSForm, dxPSCompsProvider, 
  dxPSCore, cxControls, cxContainer, cxEdit, cxLabel, cxCheckBox, IniFiles,
  cxLookAndFeelPainters, cxButtons, cxTextEdit, cxListView, cxPC,
  cxGroupBox, cxGraphics, cxLookAndFeels;

type
  TSortOrder = (soNone, soUp, soDown);

  TdxAddReportLinkDlgDataOption = (adoShowDesignButton, adoShowDescriptionColumn, 
     adoShowOnlyComponentsWOLinks, adoShowOnlyComponentsInActiveForm, 
     adoAllowMultiSelect, adoShowNameEdit, adoShowCaptionEdit, 
     adoShowHideCustomContainers, adoShowCreatorEdit);
  TdxAddReportLinkDlgDataOptions = set of TdxAddReportLinkDlgDataOption;

  TdxfmAddComponent = class(TCustomdxPSForm)
    pmItems: TPopupMenu;
    miAdd: TMenuItem;
    miLine1: TMenuItem;
    miDesign: TMenuItem;
    pnlHost: TPanel;
    ilColumns: TImageList;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    btnHelp: TcxButton;
    btnDesign: TcxButton;
    pgctrlItems: TcxPageControl;
    tbsItems: TcxTabSheet;
    pnlNoItems: TcxLabel;
    lvItems: TcxListView;
    bvlSeparator: TcxLabel;
    pnlBottomHost: TcxGroupBox;
    bvlOnlyUnLinked: TBevel;
    bvlHideCustomContainers: TBevel;
    bvlOnlyInCurrentModule: TBevel;
    chbxOnlyUnLinked: TcxCheckBox;
    chbxOnlyInCurrentModule: TcxCheckBox;
    chbxHideCustomContainers: TcxCheckBox;
    pnlNameHost: TPanel;
    lblName: TcxLabel;
    edName: TcxTextEdit;
    pnlCreatorHost: TPanel;
    lblCreator: TcxLabel;
    btnDescription: TcxButton;
    edCreator: TcxTextEdit;
    pnlCaptionHost: TPanel;
    lblCaption: TcxLabel;
    edCaption: TcxTextEdit;
    ilItems: TcxImageList;
    procedure chbxClick(Sender: TObject);
    procedure btnDesignClick(Sender: TObject);
    procedure lvItemsDblClick(Sender: TObject);
    procedure pmItemsPopup(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lvItemsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btnDescriptionClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lvItemsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvItemsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FComponentPrinter: TdxComponentPrinter;
    FDesignBtnPressed: Boolean;
    FOptions: TdxAddReportLinkDlgDataOptions; 
    FOriginalReportLinkName: string;
    FReportLink: TBasedxReportLink;
    FPrevListViewWndProc: TWndMethod;
    FReportLinkDescription: string;
    FSortedColumnIndex: Integer;
    FSortOrder: TSortOrder;
    function GetItemCount: Integer;
    function GetListViewHeader: HWND;
    function GetReportLinkCaption: string;
    function GetReportLinkCreator: string;
    function GetReportLinkName: string;
    function GetSelectedComponent: TComponent;
    procedure GetSelection(AList: TList);
    procedure SetReportLinkCaption(const Value: string);
    procedure SetReportLinkCreator(const Value: string);
    procedure SetReportLinkName(const Value: string);
        
    procedure AssignListViewHeaderImages;
    procedure ListViewWndProc(var Message: TMessage);
    procedure RestoreListViewWndProc;
    procedure SubstituteListViewWndProc;
            
    function CanEditName: Boolean;    
    function CanDesign: Boolean;
    function CanSelect: Boolean;
    function CheckUserInput: Boolean;
    procedure ClearList;
    procedure Initialize;
    procedure LoadStrings;
    function PreparedOptions: TdxPSGetComponentOptions;
    procedure RefreshColumns;
    procedure RefreshList;
    procedure RefreshSorting;
    procedure SetActiveControl;
    procedure SetColumnSortMark(AIndex: Integer; ASortOrder: TSortOrder);
    procedure SortColumn(Column: TListColumn; ASortOrder: TSortOrder);
    procedure UpdateControlsState;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure CreateWnd; override;
    procedure BeforeConstruction; override;

    procedure LoadComponentState(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure LoadListViewSorting(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure SaveComponentState(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure SaveListViewSorting(AIniFile: TCustomIniFile; const ASectionName: string);

    property ListViewHeader: HWND read GetListViewHeader;
  public
    function Execute: Boolean;    
    procedure LoadFromIniFile(AIniFile: TCustomIniFile; const ASectionName: string); override;
    procedure SaveToIniFile(AIniFile: TCustomIniFile; const ASectionName: string); override;

    property ItemCount: Integer read GetItemCount;
    property OriginalReportLinkName: string read FOriginalReportLinkName write FOriginalReportLinkName;
    property ReportLinkCaption: string read GetReportLinkCaption write SetReportLinkCaption;
    property ReportLinkCreator: string read GetReportLinkCreator write SetReportLinkCreator;
    property ReportLinkDescription: string read FReportLinkDescription write FReportLinkDescription;
    property ReportLinkName: string read GetReportLinkName write SetReportLinkName;
    property SelectedComponent: TComponent read GetSelectedComponent;
  end;
  
  PdxAddReportLinkDlgData = ^TdxAddReportLinkDlgData;
  TdxAddReportLinkDlgData = record
    Components: TList;
    ComponentPrinter: TdxComponentPrinter;
    ReportLink: TBasedxReportLink;
    ReportLinkName: string;
    ReportLinkCaption: string;
    ReportLinkCreator: string;
    ReportLinkDescription: string;
    Options: TdxAddReportLinkDlgDataOptions;
    DesignBtnPressed: Boolean;
    Title: string;
  end;

function dxShowAddComponentsDlg(var AData: TdxAddReportLinkDlgData): Boolean;

implementation

{$R *.DFM}

uses
  CommCtrl, cxClasses, dxPSRes, dxPSUtl, dxPSGlbl, dxPSPopupMan, dxPSfmEditDesc;

const
  sdxOnlyWithoutLinks = 'OnlyWithoutLinks';             // Don't Localize
  sdxOnlyInCurrentModule = 'OnlyInCurrentModule';       // Don't Localize
  sdxHideCustomContainers_ = 'HideCustomContainers';    // Don't Localize
  sdxSortedColumnIndex = 'SortedColumnIndex';           // Don't Localize
  sdxSortOrder = 'SortOrder';                           // Don't Localize
  
function dxShowAddComponentsDlg(var AData: TdxAddReportLinkDlgData): Boolean;
var
  Dialog: TdxfmAddComponent;
begin
  Result := False;
  if AData.Components = nil then  Exit;
  
  Dialog := TdxfmAddComponent.Create(nil);
  try
    Dialog.FOptions := AData.Options;
    Dialog.FComponentPrinter := AData.ComponentPrinter;
    Dialog.FReportLink := AData.ReportLink;
    Dialog.ReportLinkName := AData.ReportLinkName;
    Dialog.OriginalReportLinkName := Dialog.ReportLinkName;
    Dialog.ReportLinkCaption := AData.ReportLinkCaption;
    Dialog.ReportLinkCreator := AData.ReportLinkCreator;
    Dialog.ReportLinkDescription := AData.ReportLinkDescription;
    if AData.Title <> '' then       
      Dialog.Caption := AData.Title;
  
    Result := Dialog.Execute;
    
    if Result then
    begin
      Dialog.GetSelection(AData.Components);
      AData.DesignBtnPressed := Dialog.FDesignBtnPressed;
      if Dialog.SelectedComponent <> nil then 
        AData.ReportLinkName := Dialog.ReportLinkName;
      AData.ReportLinkCaption := Dialog.ReportLinkCaption;
      AData.ReportLinkCreator := Dialog.ReportLinkCreator;
      AData.ReportLinkDescription := Dialog.ReportLinkDescription;
    end;  
  finally
    Dialog.Free;
  end;
end;

{ TdxfmAddComponent }

procedure TdxfmAddComponent.FormCreate(Sender: TObject);
begin
  FSortedColumnIndex := -1;
  HelpContext := dxPSGlbl.dxhcAddLinkDlg;
  Application.MainForm.Caption := Caption;
  SubstituteListViewWndProc;
  AssignListViewHeaderImages;
  dxPSPopupMenuController.RegisterControl(lvItems);
end;

procedure TdxfmAddComponent.FormDestroy(Sender: TObject);
begin
  dxPSPopupMenuController.UnregisterControl(lvItems);  
  RestoreListViewWndProc;
  ClearList;
end;

procedure TdxfmAddComponent.FormResize(Sender: TObject);
const
  BtnOffsetY = 12;
  BtnOffsetX = 6;
  Offset = 3;
var
  RightOrigin, TopOrigin: Integer;
begin
  RightOrigin := pnlHost.Left + pnlHost.Width;
  TopOrigin := pnlHost.Top + pnlHost.Height + BtnOffsetY;

  dxPSUtl.PlaceButtons([btnHelp, btnDesign, btnCancel, btnOK], BtnOffsetX, RightOrigin, TopOrigin);
  with pnlNoItems do
  begin
    Left := Offset;
    Top := (lvItems.ClientHeight - Height) div 2;
    Width := lvItems.ClientWidth - 2 * Offset;
  end;  
end;

procedure TdxfmAddComponent.chbxClick(Sender: TObject);
begin
  RefreshList;
  RefreshSorting;
end;

procedure TdxfmAddComponent.btnDesignClick(Sender: TObject);
begin
  FDesignBtnPressed := True;
  ModalResult := mrOk;
end;

procedure TdxfmAddComponent.lvItemsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if Change = ctState then UpdateControlsState;
end;

procedure TdxfmAddComponent.btnDescriptionClick(Sender: TObject);
var
  S: string;
begin
  S := ReportLinkDescription;
  if dxEditDescriptionDlg(S) then 
    ReportLinkDescription := S;
end;

procedure TdxfmAddComponent.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOK then 
    CanClose := CheckUserInput;
end;

procedure TdxfmAddComponent.lvItemsColumnClick(Sender: TObject;
  Column: TListColumn);
const
  SortOrderToggleMap: array[TSortOrder] of TSortOrder = (soUp, soDown, soUp);
var
  KeyboardState: TKeyboardState;
begin
  Windows.GetKeyboardState(KeyboardState);
  if KeyboardState[VK_CONTROL] and $80 <> 0 then
    if FSortedColumnIndex <> -1 then
    begin
      RefreshList;
      SetColumnSortMark(FSortedColumnIndex, soNone);
      FSortOrder := soNone;
      FSortedColumnIndex := -1;
    end
    else  
  else
  begin
    FSortOrder := SortOrderToggleMap[FSortOrder];  
    SortColumn(Column, FSortOrder);
  end;  
end;

procedure TdxfmAddComponent.lvItemsCompare(Sender: TObject; Item1, Item2: TListItem; 
  Data: Integer; var Compare: Integer);
begin
  if Data = 0 then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else
    Compare := CompareText(Item1.SubItems[Data - 1], Item2.SubItems[Data - 1]);

  if FSortOrder = soUp then 
    Compare := -Compare;
end;

procedure TdxfmAddComponent.lvItemsDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TdxfmAddComponent.pmItemsPopup(Sender: TObject);
begin
  miAdd.Enabled := CanSelect;
  miDesign.Enabled := CanDesign;
  miDesign.Visible := adoShowDesignButton in FOptions;
  miLine1.Visible := miDesign.Visible;
end;

function TdxfmAddComponent.Execute: Boolean;      
begin
  Initialize;
  Result := ShowModal = mrOk;
end;

procedure TdxfmAddComponent.LoadFromIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  inherited LoadFromIniFile(AIniFile, ASectionName);
  dxLoadListViewColumns(AIniFile, ASectionName, lvItems.InnerListView);
  LoadComponentState(AIniFile, ASectionName);
  LoadListViewSorting(AIniFile, dxValidatePath(ASectionName) + lvItems.Name);
end;

procedure TdxfmAddComponent.SaveToIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  inherited SaveToIniFile(AIniFile, ASectionName);
  dxSaveListViewColumns(AIniFile, ASectionName, lvItems.InnerListView);
  SaveComponentState(AIniFile, ASectionName);
  SaveListViewSorting(AIniFile, dxValidatePath(ASectionName) + lvItems.Name);
end;

procedure TdxfmAddComponent.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, WM_SETICON, 1, Icon.Handle);
end;

procedure TdxfmAddComponent.BeforeConstruction;
begin
  inherited;
  Options := Options + [foSizeableDialog];
end;

procedure TdxfmAddComponent.LoadComponentState(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  chbxOnlyUnLinked.Checked := AIniFile.ReadBool(
    ASectionName, sdxOnlyWithoutLinks, chbxOnlyUnLinked.Checked);
  chbxOnlyInCurrentModule.Checked := AIniFile.ReadBool(
    ASectionName, sdxOnlyInCurrentModule, chbxOnlyInCurrentModule.Checked);
  chbxHideCustomContainers.Checked := AIniFile.ReadBool(
    ASectionName, sdxHideCustomContainers_, chbxHideCustomContainers.Checked);
end;  
  
procedure TdxfmAddComponent.LoadListViewSorting(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  FSortedColumnIndex := AIniFile.ReadInteger(
    ASectionName, sdxSortedColumnIndex, FSortedColumnIndex);
  FSortOrder := TSortOrder(AIniFile.ReadInteger(
    ASectionName, sdxSortOrder, Integer(FSortOrder)));
end;

procedure TdxfmAddComponent.SaveListViewSorting(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  AIniFile.WriteInteger(ASectionName, sdxSortedColumnIndex, FSortedColumnIndex);
  AIniFile.WriteInteger(ASectionName, sdxSortOrder, Integer(FSortOrder));
end;

procedure TdxfmAddComponent.SaveComponentState(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin  
  AIniFile.WriteBool(ASectionName, sdxOnlyWithoutLinks, chbxOnlyUnLinked.Checked);
  AIniFile.WriteBool(ASectionName, sdxOnlyInCurrentModule, chbxOnlyInCurrentModule.Checked);
  AIniFile.WriteBool(ASectionName, sdxHideCustomContainers_, chbxHideCustomContainers.Checked);
end;
  
function TdxfmAddComponent.GetItemCount: Integer;
begin
  Result := lvItems.Items.Count;
end;

function TdxfmAddComponent.GetListViewHeader: HWND;
begin
  lvItems.HandleNeeded;
  if lvItems.HandleAllocated then
    Result := ListView_GetHeader(lvItems.Handle)
  else
    Result := 0;
end;

function TdxfmAddComponent.GetReportLinkCaption: string;
begin
  Result := edCaption.Text;
end;

function TdxfmAddComponent.GetReportLinkCreator: string;
begin
  Result := edCreator.Text;
end;

function TdxfmAddComponent.GetReportLinkName: string;
begin
  Result := edName.Text;
end;

function TdxfmAddComponent.GetSelectedComponent: TComponent;
begin
  if lvItems.SelCount = 1 then 
    Result := TdxComponentItem(lvItems.Selected.Data).Component
  else  
    Result := nil;
end;

procedure TdxfmAddComponent.GetSelection(AList: TList);
var
  I: Integer;
begin
  with lvItems do 
  begin
    for I := 0 to Items.Count - 1 do
      if Items[I].Selected then 
        AList.Add(TdxComponentItem(Items[I].Data).Component);
  end;      
end;

procedure TdxfmAddComponent.SetReportLinkCaption(const Value: string);
begin
  edCaption.Text := Value;
end;

procedure TdxfmAddComponent.SetReportLinkCreator(const Value: string);
begin
  edCreator.Text := Value;
end;

procedure TdxfmAddComponent.SetReportLinkName(const Value: string);
begin
  edName.Text := Value;
end;

procedure TdxfmAddComponent.AssignListViewHeaderImages;
var
  Header: HWND;
begin
  Header := ListViewHeader;
  if IsWindow(Header) and not IsWindow(Header_GetImageList(Header)) then 
    Header_SetImageList(Header, ilColumns.Handle);
end;

procedure TdxfmAddComponent.ListViewWndProc(var Message: TMessage);
begin
  FPrevListViewWndProc(Message);

  if (FSortedColumnIndex <> -1) and (Message.Msg = WM_NOTIFY) then
    if (TWMNotify(Message).NMHdr^.hWndFrom = ListViewHeader) and 
       (TWMNotify(Message).NMHdr^.Code = HDN_ENDTRACK) then
      SetColumnSortMark(FSortedColumnIndex, FSortOrder);
end;

procedure TdxfmAddComponent.RestoreListViewWndProc;
begin
  lvItems.WindowProc := FPrevListViewWndProc;
end;

procedure TdxfmAddComponent.SubstituteListViewWndProc;
begin
  FPrevListViewWndProc := lvItems.WindowProc;
  lvItems.WindowProc := ListViewWndProc;
end;

function TdxfmAddComponent.CanDesign: Boolean;
begin
  Result := (SelectedComponent <> nil) and 
    FComponentPrinter.DesignerExistsByComponent(SelectedComponent);
end;

function TdxfmAddComponent.CanEditName: Boolean;    
begin
  Result := SelectedComponent <> nil;
end;

function TdxfmAddComponent.CanSelect: Boolean;
begin
  Result := lvItems.Selected <> nil;
end;

function TdxfmAddComponent.CheckUserInput: Boolean;
begin
  if adoShowNameEdit in FOptions then 
  begin
    Result := IsValidIdent(ReportLinkName);
    if Result then   
    begin
      Result := FComponentPrinter.Owner.FindComponent(ReportLinkName) = nil;
      if not Result then 
        MessageError(Format(cxGetResourceString(@sdxComponentAlreadyExists), [ReportLinkName]));    
    end  
    else  
      MessageError(Format(cxGetResourceString(@sdxInvalidComponentName), [ReportLinkName]));
    
    if not Result and edName.CanFocus then 
    begin
      edName.Text := FOriginalReportLinkName;
      edName.SelectAll;
      ActiveControl := edName;
    end;  
  end
  else
    Result := True;
end;

procedure TdxfmAddComponent.ClearList;
var
  I: Integer;
begin
  for I := 0 to lvItems.Items.Count - 1 do 
    TObject(lvItems.Items[I].Data).Free;
  lvItems.Items.Clear;
end;

procedure TdxfmAddComponent.Initialize;
begin
  pnlNameHost.Visible := adoShowNameEdit in FOptions;
  pnlCaptionHost.Visible := adoShowCaptionEdit in FOptions;  
  pnlCreatorHost.Visible := adoShowCreatorEdit in FOptions;
  bvlSeparator.Visible := pnlNameHost.Visible or pnlCaptionHost.Visible or pnlCreatorHost.Visible;
  btnDesign.Visible := adoShowDesignButton in FOptions;

  btnHelp.Visible := HelpContext <> 0;
  if HelpContext <> 0 then 
    BorderIcons := BorderIcons + [biHelp];

  lvItems.MultiSelect := adoAllowMultiSelect in FOptions;
  
  chbxOnlyInCurrentModule.Visible := adoShowOnlyComponentsInActiveForm in FOptions;
  chbxOnlyUnLinked.Visible := adoShowOnlyComponentsWOLinks in FOptions;
  chbxHideCustomContainers.Visible := adoShowHideCustomContainers in FOptions;

  pnlBottomHost.Visible := chbxOnlyInCurrentModule.Visible or chbxOnlyUnLinked.Visible or chbxHideCustomContainers.Visible;
  if pnlBottomHost.Visible then 
  begin
    if not chbxHideCustomContainers.Visible then 
      pnlBottomHost.Height := pnlBottomHost.Height - bvlHideCustomContainers.Height;
    if not chbxOnlyInCurrentModule.Visible then 
      pnlBottomHost.Height := pnlBottomHost.Height - bvlOnlyInCurrentModule.Height;
    if not chbxOnlyUnLinked.Visible then 
      pnlBottomHost.Height := pnlBottomHost.Height - bvlOnlyUnLinked.Height;

    if not chbxHideCustomContainers.Visible then 
    begin
      chbxOnlyUnLinked.BoundsRect := chbxOnlyInCurrentModule.BoundsRect;
      chbxOnlyInCurrentModule.BoundsRect := chbxHideCustomContainers.BoundsRect;
    end;
    if not chbxOnlyInCurrentModule.Visible then 
      chbxOnlyUnLinked.BoundsRect := chbxOnlyInCurrentModule.BoundsRect;
  end;  

  pnlNoItems.Parent := lvItems;
    
  RefreshColumns;
  RefreshList;
  LoadStrings;
  
  FormResize(nil); 
  SetActiveControl;
end;

procedure TdxfmAddComponent.LoadStrings;
begin
  if (FComponentPrinter = nil) or not (csDesigning in FComponentPrinter.ComponentState) then 
    Caption := cxGetResourceString(@sdxAddReport);

  lblName.Caption := cxGetResourceString(@sdxName);
  lblCaption.Caption := cxGetResourceString(@sdxCaption);  
  lblCreator.Caption := cxGetResourceString(@sdxCreator);
  btnDescription.Caption := cxGetResourceString(@sdxBtnDescription);

  tbsItems.Caption := cxGetResourceString(@sdxAvailableSources);

  chbxHideCustomContainers.Caption := cxGetResourceString(@sdxHideCustomContainers);
  chbxOnlyInCurrentModule.Caption := cxGetResourceString(@sdxOnlyComponentsInActiveForm);
  chbxOnlyUnLinked.Caption := cxGetResourceString(@sdxOnlyComponentsWithoutLinks);

  pnlNoItems.Caption := cxGetResourceString(@sdxThereAreNowItemsForShow);
  miAdd.Caption := cxGetResourceString(@sdxAddReport);
  miDesign.Caption := cxGetResourceString(@sdxAddAndDesignReport);
  
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnDesign.Caption := cxGetResourceString(@sdxBtnDesign);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
end;

function TdxfmAddComponent.PreparedOptions: TdxPSGetComponentOptions;
begin
  Result := [];
  if (adoShowOnlyComponentsWOLinks in FOptions) and chbxOnlyUnLinked.Checked then
    Include(Result, gcoExcludeExisting);
  if (adoShowOnlyComponentsInActiveForm in FOptions) and chbxOnlyInCurrentModule.Checked then
    Include(Result, gcoExcludeOutOfActiveForm);
  if (adoShowHideCustomContainers in FOptions) and chbxHideCustomContainers.Checked then
    Include(Result, gcoHideCustomContainers);
end;

procedure TdxfmAddComponent.RefreshColumns;
var
  ColumnWidths: array of Integer;
  I: Integer;
begin
  lvItems.Columns.BeginUpdate;
  try
    SetLength(ColumnWidths, lvItems.Columns.Count);
    for I := 0 to lvItems.Columns.Count - 1 do 
      ColumnWidths[I] := lvItems.Columns[I].Width;
        
    lvItems.Columns.Clear;
    with lvItems.Columns.Add do 
    begin
      Width := 2 * (lvItems.Width - GetSystemMetrics(SM_CXHSCROLL) - 6) div 3;
      Caption := cxGetResourceString(@sdxItemName);
    end;  
      
    if adoShowDescriptionColumn in FOptions then 
      with lvItems.Columns.Add do
      begin
        Width := (lvItems.Width - GetSystemMetrics(SM_CXHSCROLL) - 6) div 3;
        Caption := cxGetResourceString(@sdxItemDescription);
      end;  
        
    for I := 0 to Min(lvItems.Columns.Count - 1, Length(ColumnWidths) - 1) do
      lvItems.Columns[I].Width := ColumnWidths[I];
  finally
    lvItems.ColumnClick := True;
    lvItems.Columns.EndUpdate;
  end;   
end;

procedure TdxfmAddComponent.RefreshList;

  procedure LoadStrings(AStrings: TStrings; AnOptions: TdxPSGetComponentOptions);
  begin
    dxPSComponentProvidersFactory.GetComponents(FComponentPrinter, FReportLink, AStrings, AnOptions);
  end;

  procedure FillList(AStrings: TStrings);
  var
    I: Integer;
  begin
    for I := 0 to AStrings.Count - 1 do 
      with lvItems.Items.Add do
      begin
        Caption := AStrings[I];
        Data := AStrings.Objects[I];
        SubItems.Add(TdxComponentItem(Data).Description);
      end;
  end;

  procedure RestoreSelection(ASelection: TList);
  var
    I, J: Integer;
    Item: TListItem;
  begin
    for I := 0 to ASelection.Count - 1 do
      for J := 0 to lvItems.Items.Count - 1 do 
      begin
        Item := TListItem(lvItems.Items[J]);
        if TdxComponentItem(Item.Data).Component = ASelection[I] then 
        begin
          Item.Selected := True;
          Item.MakeVisible(True);
          Break;
        end;  
      end;  
  end;

  procedure UpdateListViewState;
  const 
    Styles: array[Boolean] of TViewStyle = (vsReport, vsList);
  begin
    lvItems.ViewStyle := Styles[ItemCount = 0];
    lvItems.ColumnClick := True;
    lvItems.Enabled := ItemCount <> 0;
    lvItems.HideSelection := ItemCount = 0;
    if (lvItems.SelCount = 0) and (ItemCount <> 0) then
      lvItems.Selected := lvItems.Items[0];
  end;

var
  Selection: TList;
  Strings: TStrings;
begin
  lvItems.Items.BeginUpdate;
  try
    Selection := TList.Create;
    try
      GetSelection(Selection);

      Strings := TStringList.Create;
      try
        ClearList;
        LoadStrings(Strings, PreparedOptions);
        FillList(Strings);
      finally
        Strings.Free;
      end;  
        
      RestoreSelection(Selection);

      UpdateListViewState;
    finally
      Selection.Free;
    end;
  finally
    lvItems.Items.EndUpdate;
  end;  
  UpdateControlsState;
end;

procedure TdxfmAddComponent.RefreshSorting;
begin
  if (FSortedColumnIndex > -1) and (FSortedColumnIndex < lvItems.Columns.Count) and 
    (FSortOrder <> soNone) then
    SortColumn(lvItems.Columns[FSortedColumnIndex], FSortOrder);
end;

procedure TdxfmAddComponent.SetActiveControl;
begin
  if lvItems.CanFocus then 
    ActiveControl := lvItems
  else
    if edName.CanFocus then 
    begin
      ActiveControl := edName;
      edName.SelectAll;
    end  
    else
      if edCaption.CanFocus then 
      begin
        ActiveControl := edCaption;
        edCaption.SelectAll;
      end  
      else
        if edCreator.CanFocus then 
         begin
           ActiveControl := edCreator;
           edCreator.SelectAll;
         end;
end;

procedure TdxfmAddComponent.SetColumnSortMark(AIndex: Integer; ASortOrder: TSortOrder);
const
  Format: Integer = HDF_IMAGE or HDF_BITMAP_ON_RIGHT;
  ImageIndexes: array[TSortOrder] of Integer = (-1, 0, 1);
var
  Header: HWND;
  HDItem: THDItem;
begin
  AssignListViewHeaderImages;
  Header := ListViewHeader;
  if IsWindow(Header) then 
  begin
    FillChar(HDItem, SizeOf(HDItem), 0);
    HDItem.Mask := HDI_FORMAT or HDI_IMAGE;
    Header_GetItem(Header, AIndex, HDItem);
    if ASortOrder <> soNone then
      HDItem.fmt := HDItem.fmt or Format
    else
      HDItem.fmt := HDItem.fmt and not Format;
    HDItem.iImage := ImageIndexes[ASortOrder];
    Header_SetItem(Header, AIndex, HDItem);
  end;
end;

procedure TdxfmAddComponent.SortColumn(Column: TListColumn; ASortOrder: TSortOrder);
var
  Item: TListItem;
begin
  dxPSCore.dxPSStartWait;
  try
    if (FSortedColumnIndex <> Column.Index) and (FSortedColumnIndex <> -1) then
      SetColumnSortMark(FSortedColumnIndex, soNone);
    FSortedColumnIndex := Column.Index;
    if ASortOrder <> soNone then
    begin
      lvItems.CustomSort(nil, MakeTTag(FSortedColumnIndex));
      SetColumnSortMark(FSortedColumnIndex, ASortOrder);
    end;  
    Item := lvItems.Selected;
    if Item <> nil then
      Item.MakeVisible(True);
  finally
    dxPSCore.dxPSStopWait;
  end;
  lvItems.Invalidate;
end;

procedure TdxfmAddComponent.UpdateControlsState;
begin
  edName.Enabled := CanEditName;  
  edCaption.Enabled := ItemCount <> 0;
  edCreator.Enabled := ItemCount <> 0;
  btnDescription.Enabled := ItemCount <> 0;
  pnlNoItems.Visible := ItemCount = 0;
  btnDesign.Enabled := CanDesign;
end;

procedure TdxfmAddComponent.CMDialogChar(var Message: TCMDialogChar);
begin
  inherited;
  if IsAccel(Message.CharCode, tbsItems.Caption) then
  begin
    Message.Result := 1;
    if lvItems.Enabled then ActiveControl := lvItems;
  end;
end;

end.

