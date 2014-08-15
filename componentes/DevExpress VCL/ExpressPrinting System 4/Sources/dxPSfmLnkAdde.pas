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

unit dxPSfmLnkAddE;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, Registry,
  Menus, Forms, ComCtrls, ExtCtrls, ImgList, dxPSCore, dxPSForm, IniFiles,
  cxLookAndFeelPainters, cxButtons, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxLabel, cxGroupBox, cxPC, cxListView, cxGraphics, cxLookAndFeels;

type
  TSortOrder = (soNone, soUp, soDown);

  TdxfmAddReportLinkClass = class(TCustomdxPSForm)
    pmLinks: TPopupMenu;
    miSelect: TMenuItem;
    miDesign: TMenuItem;
    miLine1: TMenuItem;
    ilColumns: TImageList;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    btnHelp: TcxButton;
    btnDesign: TcxButton;
    pnlHost: TcxGroupBox;
    pnlNameHost: TcxGroupBox;
    edName: TcxTextEdit;
    lblName: TcxLabel;
    pnlCaptionHost: TcxGroupBox;
    edCaption: TcxTextEdit;
    lblCaption: TcxLabel;
    pnlCreatorHost: TcxGroupBox;
    btnDescription: TcxButton;
    edCreator: TcxTextEdit;
    lblCreator: TcxLabel;
    bvlSeparator: TcxLabel;
    pgctrlItems: TcxPageControl;
    tbsItems: TcxTabSheet;
    lvItems: TcxListView;
    ilLinks: TcxImageList;
    procedure btnHelpClick(Sender: TObject);
    procedure lvItemsDblClick(Sender: TObject);
    procedure lvItemsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvItemsCompare(Sender: TObject; Item1, Item2: TListItem; 
      Data: Integer; var Compare: Integer);
    procedure FormResize(Sender: TObject);
    procedure btnDesignClick(Sender: TObject);
    procedure pmLinksPopup(Sender: TObject);
    procedure lvItemsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btnDescriptionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvItemsCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    FDesignBtnPressed: Boolean;
   {$IFDEF DELPHI5}
    FPrevListViewWndProc: TWndMethod;
   {$ENDIF}
    FReportLinkDescription: string;
    FSortedColumnIndex: Integer;
    FSortOrder: TSortOrder;
    function GetListViewHeader: HWND;
    function GetReportLinkCaption: string;
    function GetReportLinkCreator: string;
    function GetReportLinkName: string;
    function GetSelectedReportLinkClass: TdxReportLinkClass;
    procedure SetReportLinkCaption(const Value: string);
    procedure SetReportLinkCreator(Value: string);
    procedure SetReportLinkName(const Value: string);

    function CanEditCaption: Boolean;
    function CanEditCreator: Boolean;
    function CanEditDescription: Boolean;    
    function CanEditName: Boolean;    
    function CanDesign: Boolean;
    function CanSelect: Boolean;
    procedure Initialize;
    procedure RefreshList;
    procedure SetActiveControl;
   {$IFDEF DELPHI5} 
    procedure SetColumnSortMark(AIndex: Integer; ASortOrder: TSortOrder);
   {$ENDIF}
    procedure SortColumn(Column: TListColumn; ASortOrder: TSortOrder);
    procedure RefreshSorting;
    procedure UpdateControlsState;
    
   {$IFDEF DELPHI5} 
    procedure AssignListViewHeaderImages;
    procedure ListViewWndProc(var Message: TMessage);
    procedure RestoreListViewWndProc;
    procedure SubstituteListViewWndProc;
   {$ENDIF}
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure CreateWnd; override;
    procedure BeforeConstruction; override;
    
    procedure LoadSorting(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure SaveSorting(AIniFile: TCustomIniFile; const ASectionName: string);

    property ListViewHeader: HWND read GetListViewHeader;
  public
    function Execute: Boolean;
    procedure LoadFromIniFile(AIniFile: TCustomIniFile; const ASectionName: string); override;
    procedure SaveToIniFile(AIniFile: TCustomIniFile; const ASectionName: string); override;

    property ReportLinkCaption: string read GetReportLinkCaption write SetReportLinkCaption;
    property ReportLinkCreator: string read GetReportLinkCreator write SetReportLinkCreator;
    property ReportLinkDescription: string read FReportLinkDescription write FReportLinkDescription;
    property ReportLinkName: string read GetReportLinkName write SetReportLinkName;
    property SelectedReportLinkClass: TdxReportLinkClass read GetSelectedReportLinkClass;
  end;

  PdxAddReportLinkClassDlgData = ^TdxAddReportLinkClassDlgData;
  TdxAddReportLinkClassDlgData = record
    ReportLinkClass: TdxReportLinkClass;
    ReportLinkName: string;
    ReportLinkCaption: string;
    ReportLinkCreator: string;
    ReportLinkDescription: string;        
    DesignBtnPressed: Boolean;
    HelpContext: THelpContext;
  end;
  
function dxShowAddReportLinkClassDlg(var AData: TdxAddReportLinkClassDlgData): Boolean;

implementation

{$R *.DFM}

uses
  Dialogs, CommCtrl, dxBase, dxPSGlbl, dxPSUtl, dxPSDsgProxies, dxPSPopupMan, 
  dxPSfmEditDesc;

const
  sdxSortedColumnIndex = 'SortedColumnIndex'; // Don't Localize
  sdxSortOrder = 'SortOrder';                 // Don't Localize
  
type
  TCustomListViewAccess = class(TCustomListView);

function dxShowAddReportLinkClassDlg(var AData: TdxAddReportLinkClassDlgData): Boolean;
var
  Dialog: TdxfmAddReportLinkClass; 
begin
  Dialog := TdxfmAddReportLinkClass.Create(nil);
  try
    Dialog.ReportLinkName := AData.ReportLinkName;
    Dialog.ReportLinkCaption := AData.ReportLinkCaption;
    Dialog.ReportLinkCreator := AData.ReportLinkCreator;
    Dialog.ReportLinkDescription := AData.ReportLinkDescription;
    if AData.HelpContext <> 0 then 
      Dialog.HelpContext := AData.HelpContext;
    Result := Dialog.Execute;
    if Result then 
    begin
      AData.ReportLinkClass := Dialog.SelectedReportLinkClass;
      AData.ReportLinkName := Dialog.ReportLinkName;
      AData.ReportLinkCaption := Dialog.ReportLinkCaption;
      AData.ReportLinkCreator := Dialog.ReportLinkCreator;
      AData.ReportLinkDescription := Dialog.ReportLinkDescription;
      AData.DesignBtnPressed := Dialog.FDesignBtnPressed;
    end;  
  finally
    Dialog.Free;
  end;
end;

{ TfmAddEmptyReportLink }

procedure TdxfmAddReportLinkClass.FormCreate(Sender: TObject);
begin
  FSortedColumnIndex := -1;
  HelpContext := dxPSGlbl.dxhcAddEmptyLinkDlg;
  dxPSDsgProxies.dxIdeImagesProvider.Refresh;
  lvItems.SmallImages := dxPSDsgProxies.dxIdeImagesProvider.Images;  
 {$IFDEF DELPHI5}
  SubstituteListViewWndProc;
  AssignListViewHeaderImages;
 {$ENDIF} 
  dxPSPopupMenuController.RegisterControl(lvItems);
end;

procedure TdxfmAddReportLinkClass.FormDestroy(Sender: TObject);
begin
  dxPSPopupMenuController.UnregisterControl(lvItems);  
 {$IFDEF DELPHI5}
  RestoreListViewWndProc;
 {$ENDIF} 
end;

function TdxfmAddReportLinkClass.Execute: Boolean;
begin
  Initialize;
  Result := (ShowModal = mrOk) and (lvItems.Selected <> nil);
end;

procedure TdxfmAddReportLinkClass.LoadFromIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  inherited LoadFromIniFile(AIniFile, ASectionName);
  dxLoadListViewColumns(AIniFile, ASectionName, lvItems.InnerListView);
  LoadSorting(AIniFile, dxValidatePath(ASectionName) + lvItems.Name);
end;

procedure TdxfmAddReportLinkClass.SaveToIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  inherited SaveToIniFile(AIniFile, ASectionName);
  dxSaveListViewColumns(AIniFile, ASectionName, lvItems.InnerListView);
  SaveSorting(AIniFile, dxValidatePath(ASectionName) + lvItems.Name);
end;

procedure TdxfmAddReportLinkClass.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, WM_SETICON, 1, Icon.Handle);
end;

procedure TdxfmAddReportLinkClass.BeforeConstruction;
begin
  inherited BeforeConstruction;
  Options := Options + [foSizeableDialog];
end;

procedure TdxfmAddReportLinkClass.LoadSorting(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  FSortedColumnIndex := AIniFile.ReadInteger(
    ASectionName, sdxSortedColumnIndex, FSortedColumnIndex);
  FSortOrder := TSortOrder(AIniFile.ReadInteger(
    ASectionName, sdxSortOrder, Integer(FSortOrder)));
end;

procedure TdxfmAddReportLinkClass.SaveSorting(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  AIniFile.WriteInteger(ASectionName, sdxSortedColumnIndex, FSortedColumnIndex);
  AIniFile.WriteInteger(ASectionName, sdxSortOrder, Integer(FSortOrder));
end;

procedure TdxfmAddReportLinkClass.pmLinksPopup(Sender: TObject);
begin
  miSelect.Enabled := CanSelect;
  miDesign.Enabled := CanDesign;
end;

procedure TdxfmAddReportLinkClass.lvItemsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if Change = ctState then
    UpdateControlsState;
end;

procedure TdxfmAddReportLinkClass.btnDescriptionClick(Sender: TObject);
var
  S: string;
begin
  S := ReportLinkDescription;
  if dxEditDescriptionDlg(S) then 
    ReportLinkDescription := S;
end;

procedure TdxfmAddReportLinkClass.btnDesignClick(Sender: TObject);
begin
  FDesignBtnPressed := True;
  ModalResult := mrOk;
end;
                                         
procedure TdxfmAddReportLinkClass.btnHelpClick(Sender: TObject);
begin
  if HelpContext <> 0 then
    Application.HelpContext(HelpContext);
end;

procedure TdxfmAddReportLinkClass.lvItemsDblClick(Sender: TObject);
begin
  if lvItems.Selected <> nil then
    ModalResult := mrOk;
end;

procedure TdxfmAddReportLinkClass.lvItemsColumnClick(Sender: TObject; Column: TListColumn);
const
  SortOrderToggleMap: array[TSortOrder] of TSortOrder = (soUp, soDown, soUp);
var
  KeyboardState: TKeyboardState;
begin
  Windows.GetKeyboardState(KeyboardState);
  if KeyboardState[VK_CONTROL] and $80 = 0 then
  begin
    FSortOrder := SortOrderToggleMap[FSortOrder];
    SortColumn(Column, FSortOrder);
  end
  else
    if FSortedColumnIndex <> -1 then
    begin
      RefreshList;
     {$IFDEF DELPHI5}
      SetColumnSortMark(FSortedColumnIndex, soNone);
     {$ENDIF}
      FSortOrder := soNone;
      FSortedColumnIndex := -1;
    end;
end;

procedure TdxfmAddReportLinkClass.FormResize(Sender: TObject);
const
  BtnOffsetX = 6;
  BtnOffsetY = 12;
var
  RightOrigin, TopOrigin: Integer;
begin
  with pnlHost do
    SetBounds(Left, Top, Self.ClientWidth - 2 * Left,
      Self.ClientHeight - Top - btnOK.Height - 2 * BtnOffsetY);
      
  RightOrigin := pnlHost.Left + pnlHost.Width;
  TopOrigin := pnlHost.Top + pnlHost.Height + BtnOffsetY;

  PlaceButtons([btnHelp, btnDesign, btnCancel, btnOK], BtnOffsetX, RightOrigin, TopOrigin);
end;

procedure TdxfmAddReportLinkClass.lvItemsCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
  if Data = 0 then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else
    Compare := CompareText(Item1.SubItems[Data - 1], Item2.SubItems[Data - 1]);

  if FSortOrder = soUp then 
    Compare := -Compare;
end;
      
procedure TdxfmAddReportLinkClass.lvItemsCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  R: TRect;
  DC: HDC;
  BkColor, TextColor: COLORREF;
  X, Y: Integer;
begin
  if [cdsSelected, cdsFocused] * State = [cdsSelected, cdsFocused] then
  begin
    R := Item.DisplayRect(drIcon);
    if Item.ImageIndex = -1 then
    begin
      Sender.Canvas.Brush.Color := clWindow;
      Sender.Canvas.FillRect(R);
    end
    else
      TCustomListViewAccess(Sender).SmallImages.Draw(Sender.Canvas, R.Left, R.Top, Item.ImageIndex);
        
    DC := Sender.Canvas.Handle;
    BkColor := SetBkColor(DC, ColorToRGB(clHighLight));
    TextColor := SetTextColor(DC, ColorToRGB(clHighLightText));

    R := Item.DisplayRect(drLabel);
    with R do
    begin
      X := R.Left + 2;
      Y := Top + (Bottom - Top - Canvas.TextHeight(Item.Caption)) div 2;
    end;
    Sender.Canvas.TextRect(R, X, Y, Item.Caption);
                 
    ListView_GetSubItemRect(Sender.Handle, Item.Index, 1, LVIR_LABEL, @R);
    with R do 
    begin
      X := R.Left + 6;
      Y := Top + (Bottom - Top - Sender.Canvas.TextHeight(Item.SubItems[0])) div 2;
    end;
    Sender.Canvas.TextRect(R, X, Y, Item.SubItems[0]);
      
    SetTextColor(DC, TextColor);
    SetBkColor(DC, BkColor);

    if cdsFocused in State then
    begin
      UnionRect(R, R, Item.DisplayRect(drLabel));
      Sender.Canvas.DrawFocusRect(R);
    end;
    DefaultDraw := False;
  end;
end;

function TdxfmAddReportLinkClass.GetListViewHeader: HWND;
begin
  lvItems.HandleNeeded;
  if lvItems.HandleAllocated then
    Result := ListView_GetHeader(lvItems.Handle)
  else
    Result := 0;
end;

function TdxfmAddReportLinkClass.GetReportLinkCaption: string;
begin
  Result := edCaption.Text;
end;

function TdxfmAddReportLinkClass.GetReportLinkCreator: string;
begin
  Result := edCreator.Text;
end;

function TdxfmAddReportLinkClass.GetReportLinkName: string;
begin
  Result := edName.Text;
end;

function TdxfmAddReportLinkClass.GetSelectedReportLinkClass: TdxReportLinkClass;
begin
  if lvItems.Selected <> nil then 
    Result := TdxReportLinkClass(lvItems.Selected.Data)
  else  
    Result := nil;
end;

procedure TdxfmAddReportLinkClass.SetReportLinkCaption(const Value: string);
begin
  edCaption.Text := Value;
end;

procedure TdxfmAddReportLinkClass.SetReportLinkCreator(Value: string);
begin
  edCreator.Text := Value;
end;

procedure TdxfmAddReportLinkClass.SetReportLinkName(const Value: string);
begin
  edName.Text := Value;
end;

function TdxfmAddReportLinkClass.CanDesign: Boolean;
begin
  Result := dxPSDesignerClassByLinkClass(SelectedReportLinkClass) <> nil;
end;

function TdxfmAddReportLinkClass.CanEditCaption: Boolean;
begin
  Result := SelectedReportLinkClass <> nil;
end;

function TdxfmAddReportLinkClass.CanEditCreator: Boolean;
begin
  Result := SelectedReportLinkClass <> nil;
end;

function TdxfmAddReportLinkClass.CanEditDescription: Boolean;    
begin
  Result := SelectedReportLinkClass <> nil;
end;

function TdxfmAddReportLinkClass.CanEditName: Boolean;    
begin
  Result := SelectedReportLinkClass <> nil;
end;

function TdxfmAddReportLinkClass.CanSelect: Boolean;
begin
  Result := lvItems.Selected <> nil;
end;

procedure TdxfmAddReportLinkClass.Initialize;
begin
  btnHelp.Visible := HelpContext <> 0;
  RefreshList;
  with lvItems do
  begin
    btnOK.Enabled := Items.Count > 0;
    if Items.Count > 0 then
    begin
      Selected := Items[0];
      ItemFocused := Selected;
    end;
  end;

  pmLinks.Images := ilLinks;
  miDesign.ImageIndex := 0;
  
  FormResize(nil);
  SetActiveControl;
  RefreshSorting;
end;  

procedure TdxfmAddReportLinkClass.RefreshList;
var
  Selection: TList;
  I, J: Integer;
  LinkClasses: TdxClassList;
  ComponentClasses: TdxClassList;
  LinkClass: TdxReportLinkClass;
  ComponentClass: TComponentClass;
begin
  lvItems.Items.BeginUpdate;
  try
    Selection := TList.Create;
    try
      dxPSUtl.dxSaveListViewSelection(lvItems.InnerListView, Selection);
      try
        lvItems.Items.Clear;
        LinkClasses := TdxClassList.Create;
        try
          ComponentClasses := TdxClassList.Create;
          try
            dxPSGetActiveReportLinksList(LinkClasses);
            for I := 0 to LinkClasses.Count - 1 do
            begin
              ComponentClasses.Clear;

              LinkClass := TdxReportLinkClass(LinkClasses[I]);
              with lvItems.Items.Add do             
              begin
                LinkClass.GetSupportedComponentList(ComponentClasses);
                for J := 0 to ComponentClasses.Count - 1 do
                begin
                  ComponentClass := TComponentClass(ComponentClasses[J]);
                  if J = 0 then
                    ImageIndex := dxPSDsgProxies.dxIdeImagesProvider.ImageIndexes[ComponentClass];
                  if Caption <> '' then 
                    Caption := Caption + ', ';
                  if ComponentClass <> nil then 
                    Caption := Caption + ComponentClass.ClassName;
                end;
                Data := (LinkClass);
                StateIndex := -1;
          
                SubItems.Add(LinkClass.ClassName);
              end;
            end;
          finally
            ComponentClasses.Free;
          end;
        finally
          LinkClasses.Free;
        end;
      finally
        dxPSUtl.dxRestoreListViewSelection(lvItems.InnerListView, Selection);
      end;  
    finally
      Selection.Free;
    end;  
  finally
    lvItems.Items.EndUpdate;
  end;  
end;

procedure TdxfmAddReportLinkClass.SetActiveControl;
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

{$IFDEF DELPHI5}
procedure TdxfmAddReportLinkClass.SetColumnSortMark(AIndex: Integer; ASortOrder: TSortOrder);
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
{$ENDIF}

procedure TdxfmAddReportLinkClass.SortColumn(Column: TListColumn; ASortOrder: TSortOrder);
var
  Item: TListItem;
begin
  dxPSCore.dxPSStartWait;
  try
   {$IFDEF DELPHI5}
    if (FSortedColumnIndex <> Column.Index) and (FSortedColumnIndex <> -1) then
      SetColumnSortMark(FSortedColumnIndex, soNone);
   {$ENDIF}
    FSortedColumnIndex := Column.Index;
    if ASortOrder <> soNone then
    begin
      lvItems.CustomSort(nil, MakeTTag(FSortedColumnIndex));
     {$IFDEF DELPHI5}
      SetColumnSortMark(FSortedColumnIndex, ASortOrder);
     {$ENDIF} 
    end;  
    Item := lvItems.Selected;
    if Item <> nil then
      Item.MakeVisible(True);
  finally
    dxPSCore.dxPSStopWait;
  end;
  lvItems.Invalidate;
end;

procedure TdxfmAddReportLinkClass.RefreshSorting;
begin
  if (FSortedColumnIndex <> -1) and (FSortOrder <> soNone) then
    SortColumn(lvItems.Columns[FSortedColumnIndex], FSortOrder);
end;

procedure TdxfmAddReportLinkClass.UpdateControlsState;
begin
  btnDesign.Enabled := CanDesign;
  edCaption.Enabled := CanEditCaption;
  edCreator.Enabled := CanEditCreator;
  btnDescription.Enabled := CanEditDescription;
  edName.Enabled := CanEditName;
end;

{$IFDEF DELPHI5} 
procedure TdxfmAddReportLinkClass.AssignListViewHeaderImages;
var
  Header: HWND;
begin                                              
  Header := ListViewHeader;
  if IsWindow(Header) and not IsWindow(Header_GetImageList(Header)) then 
    Header_SetImageList(Header, ilColumns.Handle);
end;

procedure TdxfmAddReportLinkClass.ListViewWndProc(var Message: TMessage);
begin
  FPrevListViewWndProc(Message);

  if (FSortedColumnIndex <> -1) and (Message.Msg = WM_NOTIFY) then
    with TWMNotify(Message).NMHdr^ do
      if (hWndFrom = ListViewHeader) and (Code = HDN_ENDTRACK) then
        SetColumnSortMark(FSortedColumnIndex, FSortOrder);
end;

procedure TdxfmAddReportLinkClass.RestoreListViewWndProc;
begin
  lvItems.WindowProc := FPrevListViewWndProc;
end;

procedure TdxfmAddReportLinkClass.SubstituteListViewWndProc;
begin
  FPrevListViewWndProc := lvItems.WindowProc;
  lvItems.WindowProc := ListViewWndProc;
end;
{$ENDIF}

procedure TdxfmAddReportLinkClass.CMDialogChar(var Message: TCMDialogChar);
begin
  inherited;
  if IsAccel(Message.CharCode, tbsItems.Caption) then
  begin
    Message.Result := 1;
    ActiveControl := lvItems;
  end;
end;

end.

