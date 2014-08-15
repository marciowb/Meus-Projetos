{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl main components                     }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit dxLayoutImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cxClasses, dxLayoutControl, cxControls, cxStyles,
  cxGraphics, ExtCtrls, cxContainer, cxLabel, cxLookAndFeelPainters, cxGroupBox,
  Types, cxLookAndFeels, cxSplitter, Menus, cxDropDownEdit, cxCheckBox, cxButtons,
  cxRadioGroup, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, ComCtrls, cxPC,
  dxLayoutcxEditAdapters, dxLayoutLookAndFeels;

type
  TdxAutoLayout = class;

  { TdxAutoLayoutItem }

  TdxAutoLayoutItem = class
  private
    FAlign: TAlign;
    FAutoLayout: TdxAutoLayout;
    FBoundsRect: TRect;
    FCaption: string;
    FCaptionLayout: TdxCaptionLayout;
    FControl: TControl;
    FLabeled: Boolean;
    FLabeledBoundsRect: TRect;
    FLayoutControlItem: TdxCustomLayoutItem;
    procedure ProcessAnchors;
  public
    constructor Create(AAutoLayout: TdxAutoLayout; AControl: TControl);
    procedure Apply(AProcessAnchors: Boolean = True);
    procedure Assign(Source: TdxAutoLayoutItem);
    procedure CreateLayoutControlItem(AGroup: TdxLayoutGroup);
    function CanResize: Boolean;

    function CreateGroup(AGroup: TdxLayoutGroup): TdxLayoutGroup;
    function CreateItem(AGroup: TdxLayoutGroup): TdxCustomLayoutItem;
    function CreateSeparator(AGroup: TdxLayoutGroup): TdxCustomLayoutItem;
    function CreateSplitter(AGroup: TdxLayoutGroup): TdxCustomLayoutItem;
    function CreateTabbedGroup(AGroup: TdxLayoutGroup): TdxCustomLayoutItem;

    function GetGroupCaption: string;
    function GetLabelCaption: string;
    function IsAligned: Boolean;
    function IsButton: Boolean;
    function IsGroup: Boolean;
    function IsHiddenGroup: Boolean;
    function IsLabel: Boolean;
    function IsSeparator: Boolean;
    function IsSplitter: Boolean;
    function IsPageControl: Boolean;
    function IsStandaloneLabel: Boolean;
    function GetFocusControl: TWinControl;
    procedure SetLabelInfo(ALabel: TControl);

    property Align: TAlign read FAlign;
    property BoundsRect: TRect read FBoundsRect;
    property Caption: string read FCaption;
    property CaptionLayout: TdxCaptionLayout read FCaptionLayout;
    property Control: TControl read FControl;
    property Labeled: Boolean read FLabeled;
    property LayoutControlItem: TdxCustomLayoutItem read FLayoutControlItem;
  end;

  { TdxAutoLayoutItemList }

  TdxAutoLayoutItemList = class(TList)
  private
    function GetItem(Index: Integer): TdxAutoLayoutItem;
  public
    function CanConvert(ASide: TcxBorder): Boolean;
    function First: TdxAutoLayoutItem;
    procedure FreeItems;
    function IsButtons: Boolean;
    function Last: TdxAutoLayoutItem;

    property Items[Index: Integer]: TdxAutoLayoutItem read GetItem; default;
  end;

  { TdxAutoLayoutOwnedItemList }

  TdxAutoLayoutOwnedItemList = class(TcxObjectList)
  private
    FAutoLayout: TdxAutoLayout;
    function GetItem(Index: Integer): TdxAutoLayoutItem;
  public
    constructor Create(AAutoLayout: TdxAutoLayout);
    function Add(AControl: TControl): TdxAutoLayoutItem;
    procedure DeleteItems(AItems: TdxAutoLayoutItemList);
    procedure Extract(AIndex: Integer);
    function Find(AControl: TControl): TdxAutoLayoutItem;
    function Remove(AControl: TControl): Boolean;
    procedure RemoveItems(AItems: TdxAutoLayoutItemList);

    property Items[Index: Integer]: TdxAutoLayoutItem read GetItem; default;
  end;

  { TdxAutoLayoutHelper }

  TdxAutoLayoutHelper = class
  private
    FAlignedItems: TdxAutoLayoutOwnedItemList;
    FAligns: set of TAlign;
    FBottommostItem: TdxAutoLayoutItem;
    FContainer: TWinControl;
    FItems: TdxAutoLayoutOwnedItemList;
    FLeftmostItem: TdxAutoLayoutItem;
    FNonAlignedBoundsRect: TRect;
    FOwner: TdxAutoLayout;
    FRightmostItem: TdxAutoLayoutItem;
    FRoot: TdxLayoutGroup;
    FTopmostItem: TdxAutoLayoutItem;
    function CanExport(AControl: TControl): Boolean;
    function FindBottommostItem: TdxAutoLayoutItem;
    function FindLeftmostItem: TdxAutoLayoutItem;
    function FindRightmostItem: TdxAutoLayoutItem;
    function FindTopmostItem: TdxAutoLayoutItem;
    function GetControlAtPos(X, Y: Integer): TControl;
    function GetFocusControl(AItem: TdxAutoLayoutItem): TWinControl;
    function GetItemCount: Integer;
    function HasItemsAtRect(const R: TRect): Boolean;
    procedure MakeNewRoot;
    procedure PopulateItems;
    procedure PopulateItemsAtRect(AItems: TdxAutoLayoutItemList; const R: TRect);
    procedure ProcessLabels;
    function UpdateUtmostItems: TRect;
  protected
    procedure CheckRootDirection(ADirection: TdxLayoutDirection);
    procedure ConvertGroup(AItems: TdxAutoLayoutItemList; ASide: TcxBorder);
    procedure DoAlignedControls;
    procedure DoNonAlignedControls;
    procedure DoExecute; virtual;
    procedure GenerateAligned(AAlign: TAlign);
    procedure GenerateAlignedLayout; virtual;
    procedure GenerateNonAlignedLayout; virtual;
    procedure GetSideItemGroup(AItems: TdxAutoLayoutItemList; ASide: TcxBorder);
    procedure Initialize(AContainer: TWinControl; ARoot: TdxLayoutGroup); virtual;

    property Owner: TdxAutoLayout read FOwner;
    property Root: TdxLayoutGroup read FRoot;
  public
    constructor Create(AOwner: TdxAutoLayout);
    destructor Destroy; override;
    procedure Execute(AContainer: TWinControl; ARoot: TdxLayoutGroup);

    property Container: TWinControl read FContainer;
    property ItemCount: Integer read GetItemCount;
    property Items: TdxAutoLayoutOwnedItemList read FItems;
  end;

  { TdxAutoLayout }

  TdxAutoLayout = class
  private
    FFocusControlDistanceX: Byte;
    FFocusControlDistanceY: Byte;
    FControl: TdxCustomLayoutControl;
    FConvertPageControls: Boolean;
    FRecursive: Boolean;
    FSmartFindFocusControl: Boolean;
    FUseLabeledItems: Boolean;
  protected
    procedure CorrectAlign(AGroup: TdxLayoutGroup);
    procedure DoExecute(AContainer: TWinControl; ARecursive: Boolean = True); virtual;

    property Control: TdxCustomLayoutControl read FControl;
    property Recursive: Boolean read FRecursive;
  public
    constructor Create(AControl: TdxCustomLayoutControl);
    procedure Execute(AContainer: TWinControl; ARecursive: Boolean = True);

    property ConvertPageControls: Boolean read FConvertPageControls write FConvertPageControls default True;
    property FocusControlDistanceX: Byte read FFocusControlDistanceX write FFocusControlDistanceX default 48;
    property FocusControlDistanceY: Byte read FFocusControlDistanceY write FFocusControlDistanceY default 16;
    property SmartFindFocusControl: Boolean read FSmartFindFocusControl write FSmartFindFocusControl default True;
    property UseLabeledItems: Boolean read FUseLabeledItems write FUseLabeledItems default True;
  end;

  { TfmImport }

  TfmImport = class(TForm)
    seDeltaX: TcxSpinEdit;
    seDeltaY: TcxSpinEdit;
    btnImport: TcxButton;
    btnCancel: TcxButton;
    cbContainers: TcxComboBox;
    cbUseLabeledItems: TcxCheckBox;
    cbAssociate: TcxCheckBox;
    cbConvertPageControls: TcxCheckBox;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    dxLayoutControl1Item1: TdxLayoutItem;
    dxLayoutControl1Item2: TdxLayoutItem;
    dxLayoutControl1Item3: TdxLayoutItem;
    dxLayoutControl1Group2: TdxLayoutGroup;
    dxLayoutControl1Item4: TdxLayoutItem;
    dxLayoutControl1Item5: TdxLayoutItem;
    dxLayoutControl1Group4: TdxLayoutGroup;
    dxLayoutControl1Item6: TdxLayoutItem;
    dxLayoutControl1Item7: TdxLayoutItem;
    dxLayoutControl1Item8: TdxLayoutItem;
    dxLayoutControl1LabeledItem1: TdxLayoutLabeledItem;
    dxLayoutControl1LabeledItem2: TdxLayoutLabeledItem;
    dxLayoutControl1Group5: TdxLayoutGroup;
    dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList;
    dxLayoutCxLookAndFeel2: TdxLayoutCxLookAndFeel;
    procedure cbAssociateClick(Sender: TObject);
  public
  end;

procedure ImportLayout(ALayoutControl: TdxLayoutControl);

implementation

uses
  cxGeometry, Math;

{$R *.dfm}

type
  TControlAccess = class(TControl);
  TWinControlAccess = class(TWinControl);
  TLabelAccess = class(TCustomLabel);
  TcxLabelAccess = class(TcxCustomLabel);
  TdxLayoutGroupAcsess = class(TdxLayoutGroup);
  TdxLayoutControlAccess = class(TdxLayoutControl);
  TdxCustomLayoutItemAccess = class(TdxCustomLayoutItem);
  TdxLayoutItemAccess = class(TdxLayoutItem);
  TStaticTextAccess = class(TCustomStaticText);
  TcxGroupBoxAccess = class(TcxCustomGroupBox);
  TGroupBoxAccess = class(TCustomGroupBox);
  TPanelAccess = class(TCustomPanel);

  { TdxSideItem }

  TdxSideItem = class
  private
    FItems: TdxAutoLayoutItemList;
    FSide: TcxBorder;
    function GetDirection: TdxLayoutDirection;
  protected
    FOrder: Integer;
  public
    constructor Create(AItems: TdxAutoLayoutItemList; ASide: TcxBorder);
    destructor Destroy; override;

    property Direction: TdxLayoutDirection read GetDirection;
    property Items: TdxAutoLayoutItemList read FItems write FItems;
    property Side: TcxBorder read FSide write FSide;
  end;

  { TdxSideItem }

  TdxSideItemList = class(TcxObjectList)
  private
    FCurrentOrder: Integer;
    FHelper: TdxAutoLayoutHelper;
    function GetItem(Index: Integer): TdxSideItem;
  protected
    procedure SetCreationOrder(AFirst, ALast: Integer);
    property Helper: TdxAutoLayoutHelper read FHelper;
  public
    constructor Create(AHelper: TdxAutoLayoutHelper);
    function Add(AItems: TdxAutoLayoutItemList; ASide: TcxBorder): TdxSideItem;
    procedure SortCreationOrder;
    procedure Build;

    property Items[Index: Integer]: TdxSideItem read GetItem; default;
  end;

function CompareTop(Item1, Item2: Pointer): Integer;
begin
  Result := TdxAutoLayoutItem(Item1).BoundsRect.Top - TdxAutoLayoutItem(Item2).BoundsRect.Top;
end;

function CompareBottom(Item1, Item2: Pointer): Integer;
begin
  Result := TdxAutoLayoutItem(Item2).BoundsRect.Bottom - TdxAutoLayoutItem(Item1).BoundsRect.Bottom;
end;

function CompareLeft(Item1, Item2: Pointer): Integer;
begin
  Result := TdxAutoLayoutItem(Item1).BoundsRect.Left - TdxAutoLayoutItem(Item2).BoundsRect.Left;
end;

function CompareRight(Item1, Item2: Pointer): Integer;
begin
  Result := TdxAutoLayoutItem(Item2).BoundsRect.Right - TdxAutoLayoutItem(Item1).BoundsRect.Right;
end;

{ TdxSideItem }

constructor TdxSideItem.Create(AItems: TdxAutoLayoutItemList; ASide: TcxBorder);
var
  I: Integer;
begin
  FSide := ASide;
  FItems := TdxAutoLayoutItemList.Create;
  for I := 0 to AItems.Count - 1 do
    FItems.Add(AItems[I]);
end;

destructor TdxSideItem.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TdxSideItem.GetDirection: TdxLayoutDirection;
begin
  if FSide in [bTop, bBottom] then
    Result := ldHorizontal
  else
    Result := ldVertical;
end;

{ TdxSideItemList }

constructor TdxSideItemList.Create(AHelper: TdxAutoLayoutHelper);
begin
  FHelper := AHelper;
end;

function TdxSideItemList.Add(AItems: TdxAutoLayoutItemList;
  ASide: TcxBorder): TdxSideItem;
begin
  Result := TdxSideItem.Create(AItems, ASide);
  inherited Add(Result);
  Helper.Items.DeleteItems(AItems);
end;

procedure TdxSideItemList.Build;
var
  I: Integer;
  ADirection: TdxLayoutDirection;
begin
  if Count = 0 then Exit;
  SortCreationOrder;
  ADirection := Items[0].Direction;
  Helper.CheckRootDirection(ADirection);
  for I := 0 to Count - 1 do
  begin
    if ADirection <> Items[I].Direction then
    begin
      ADirection := Items[I].Direction;
      Helper.CheckRootDirection(ADirection);
    end;
    Helper.ConvertGroup(Items[I].Items, Items[I].Side);
    Application.ProcessMessages;
  end;
end;

procedure TdxSideItemList.SetCreationOrder(AFirst, ALast: Integer);
var
  I: Integer;
begin
  for I := AFirst to ALast do
    if Items[I].Side in [bTop, bLeft] then
    begin
      Items[I].FOrder := FCurrentOrder;
      Inc(FCurrentOrder);
    end;
  for I := ALast downto AFirst do
    if Items[I].Side in [bRight, bBottom] then
    begin
      Items[I].FOrder := FCurrentOrder;
      Inc(FCurrentOrder);
    end;
end;

function CompareOrder(Item1, Item2: Pointer): Integer;
begin
  Result := TdxSideItem(Item1).FOrder - TdxSideItem(Item2).FOrder;
end;

procedure TdxSideItemList.SortCreationOrder;
var
  ADirection: TdxLayoutDirection;
  AIndex, AFirst: Integer;
begin
  if Count < 2 then
  begin
    SetCreationOrder(0, Count - 1);
    Exit;
  end;
  FCurrentOrder := 0;
  AIndex := 0;
  repeat
     AFirst := AIndex;
     ADirection := Items[AFirst].Direction;
     while (AIndex < Count) and (ADirection = Items[AIndex].Direction) do
       Inc(AIndex);
     SetCreationOrder(AFirst, AIndex - 1);
  until AIndex = Count;
  Sort(CompareOrder);
end;

function TdxSideItemList.GetItem(Index: Integer): TdxSideItem;
begin
  Result := TdxSideItem(inherited Items[Index]);
end;

{ TdxAutoLayoutControl }

constructor TdxAutoLayoutItem.Create(AAutoLayout: TdxAutoLayout; AControl: TControl);
begin
  FAutoLayout := AAutoLayout;
  FControl := AControl;
  FBoundsRect := Control.BoundsRect;
  FLabeledBoundsRect := FBoundsRect;
  FAlign := Control.Align;
end;

procedure TdxAutoLayoutItem.Assign(Source: TdxAutoLayoutItem);
begin
  FControl := Source.Control;
  FBoundsRect := Source.BoundsRect;
  FLabeledBoundsRect := Source.FLabeledBoundsRect;
  FAlign := Source.Align;
end;

procedure TdxAutoLayoutItem.CreateLayoutControlItem(AGroup: TdxLayoutGroup);
begin
  if IsPageControl then
    FLayoutControlItem := CreateTabbedGroup(AGroup)
  else if IsGroup then
    FLayoutControlItem := CreateGroup(AGroup)
  else if IsSplitter then
    FLayoutControlItem := CreateSplitter(AGroup)
  else if IsSeparator then
    FLayoutControlItem := CreateSeparator(AGroup)
  else
    FLayoutControlItem := CreateItem(AGroup);
end;

function TdxAutoLayoutItem.CanResize: Boolean;
begin
  Result := not IsButton;
end;

function TdxAutoLayoutItem.CreateGroup(AGroup: TdxLayoutGroup): TdxLayoutGroup;
begin
  Result := AGroup.CreateGroup;
  if AGroup.LayoutDirection = ldVertical then
    Result.AlignHorz := ahClient
  else
    Result.AlignVert := avClient;
  Result.Caption := GetGroupCaption;
  Result.Hidden := IsHiddenGroup;
  if FAutoLayout.Recursive and (TWinControl(Control).ControlCount > 0) then
  begin
    with TdxAutoLayoutHelper.Create(FAutoLayout) do
    try
      Execute(TWinControl(Control), Result);
    finally
      Free;
    end;
  end;
end;

function TdxAutoLayoutItem.CreateItem(AGroup: TdxLayoutGroup): TdxCustomLayoutItem;
begin
  if FAutoLayout.UseLabeledItems and IsStandaloneLabel then
  begin
    Result := AGroup.CreateItem(TdxLayoutLabeledItem);
    Result.Caption := GetLabelCaption;
  end
  else
    Result := AGroup.CreateItemForControl(Control);
end;

function TdxAutoLayoutItem.CreateSeparator(AGroup: TdxLayoutGroup): TdxCustomLayoutItem;
begin
  Result := AGroup.CreateItem(TdxLayoutSeparatorItem);
end;

function TdxAutoLayoutItem.CreateSplitter(AGroup: TdxLayoutGroup): TdxCustomLayoutItem;
begin
  Result := AGroup.CreateItem(TdxLayoutSplitterItem);
end;

function TdxAutoLayoutItem.CreateTabbedGroup(AGroup: TdxLayoutGroup): TdxCustomLayoutItem;
var
  AControlGroup: TdxLayoutGroup;
  AcxPageControl: TcxPageControl;
  APageControl: TPageControl;
  I, APageIndex: Integer;
begin
  AControlGroup := AGroup.CreateGroup;
  if AGroup.LayoutDirection = ldVertical then
    AControlGroup.AlignHorz := ahClient
  else
    AControlGroup.AlignVert := avClient;
  if not FAutoLayout.ConvertPageControls then
  begin
    Result := CreateItem(AControlGroup);
    Exit;
  end;
  AControlGroup.LayoutDirection := ldTabbed;
  if FAutoLayout.Recursive then
  begin
    if Control is TPageControl then
    begin
      APageControl := TPageControl(Control);
      APageIndex := APageControl.ActivePageIndex;
      for I := 0 to APageControl.PageCount - 1 do
      begin
        APageControl.ActivePageIndex := I;
        Application.ProcessMessages;
        AGroup := AControlGroup.CreateGroup;
        AGroup.Caption := APageControl.Pages[I].Caption;
        with TdxAutoLayoutHelper.Create(FAutoLayout) do
        try
          Execute(APageControl.Pages[I], AGroup);
        finally
          Free;
        end;
      end;
      AControlGroup.ItemIndex := APageIndex;
    end
    else
      if Control is TcxPageControl then
      begin
        AcxPageControl := TcxPageControl(Control);
        APageIndex := AcxPageControl.ActivePageIndex;
        for I := 0 to AcxPageControl.PageCount - 1 do
        begin
          AcxPageControl.ActivePageIndex := I;
          Application.ProcessMessages;
          AGroup := AControlGroup.CreateGroup;
          AGroup.Caption := AcxPageControl.Pages[I].Caption;
          with TdxAutoLayoutHelper.Create(FAutoLayout) do
          try
            Execute(AcxPageControl.Pages[I], AGroup);
          finally
            Free;
          end;
        end;
        AControlGroup.ItemIndex := APageIndex;
      end
  end;
  Result := AControlGroup;
end;

function TdxAutoLayoutItem.GetGroupCaption: string;
begin
  if Control is TCustomGroupBox then
    Result := TGroupBoxAccess(Control).Caption
  else if Control is TcxCustomGroupBox then
    Result := TcxGroupBox(Control).Caption
  else if Control is TCustomPanel then
    Result := TPanelAccess(Control).Caption
  else
    Result := '';
end;

function TdxAutoLayoutItem.GetLabelCaption: string;
begin
  if Control is TCustomLabel then
    Result := TLabelAccess(Control).Caption
  else if Control is TCustomStaticText then
    Result := TStaticTextAccess(Control).Caption
  else if Control is TcxCustomLabel then
    Result := TcxCustomLabel(Control).Caption
  else
    Result := '';
end;

function TdxAutoLayoutItem.IsAligned: Boolean;
begin
  Result := Align in [alLeft, alTop, alRight, alBottom];
end;

function TdxAutoLayoutItem.IsButton: Boolean;
begin
  Result := (Control is TcxCustomButton) or (Control is TButton);
end;

function TdxAutoLayoutItem.IsGroup: Boolean;
begin
  Result := ((Control is TCustomGroupBox) or (Control is TCustomPanel) or
    (Control is TcxCustomGroupBox)) //and (TWinControl(Control).ControlCount > 0);
end;

function TdxAutoLayoutItem.IsHiddenGroup: Boolean;
begin
  if Control is TCustomGroupBox then
    Result := False
  else if Control is TCustomPanel then
    with TPanelAccess(Control) do
      Result := (BorderStyle = bsNone) and (BevelInner = bvNone) and
        (BevelOuter = bvNone) {$IFDEF DELPHI9} and (BevelKind = bkNone){$ENDIF}
  else if Control is TcxCustomGroupBox then
    Result := TcxGroupBoxAccess(Control).Style.BorderStyle = ebsNone
  else
    Result := True;
end;

function TdxAutoLayoutItem.IsLabel: Boolean;
begin
  Result := (Control is TCustomLabel) or (Control is TCustomStaticText) or
    (Control is TcxCustomLabel);
end;

function TdxAutoLayoutItem.IsSeparator: Boolean;
begin
  Result := Control is TBevel;
  if Result then
    Result := TBevel(Control).Shape in [bsTopLine, bsBottomLine, bsLeftLine, bsRightLine];
end;

function TdxAutoLayoutItem.IsSplitter: Boolean;
begin
  Result := Control is TSplitter;
  if not Result then
    Result := Control is TcxSplitter;
end;

function TdxAutoLayoutItem.IsPageControl: Boolean;
begin
  Result := (Control is TPageControl) or (Control is TcxPageControl);
end;

function TdxAutoLayoutItem.IsStandaloneLabel: Boolean;
begin
  Result := IsLabel and not FLabeled;
end;

procedure TdxAutoLayoutItem.SetLabelInfo(ALabel: TControl);

  function GetCaptionLayout(ALabel: TControl): TdxCaptionLayout;
  begin
    if ALabel.BoundsRect.Right <= Control.BoundsRect.Left then
      Result := clLeft
    else
      if ALabel.BoundsRect.Left >= Control.BoundsRect.Right then
        Result := clRight
      else
        if ALabel.BoundsRect.Bottom <= Control.BoundsRect.Top then
          Result := clTop
        else
          Result := clBottom;
  end;

  procedure CorrectBounds;
  begin
    FLabeledBoundsRect.Left := Min(FBoundsRect.Left, ALabel.BoundsRect.Left);
    FLabeledBoundsRect.Top := Min(FBoundsRect.Top, ALabel.BoundsRect.Top);
    FLabeledBoundsRect.Right := Max(FBoundsRect.Right, ALabel.BoundsRect.Right);
    FLabeledBoundsRect.Bottom := Max(FBoundsRect.Bottom, ALabel.BoundsRect.Bottom);
  end;

begin
  FCaption := TControlAccess(ALabel).Caption;
  FCaptionLayout := GetCaptionLayout(ALabel);
  FLabeled := True;
  CorrectBounds;
end;

function TdxAutoLayoutItem.GetFocusControl: TWinControl;
begin
  if Control is TcxCustomLabel then
    Result := TcxLabelAccess(Control).FocusControl
  else
    if Control is TCustomLabel then
      Result := TLabelAccess(Control).FocusControl
    else
      if Control is TCustomStaticText then
        Result := TStaticTextAccess(Control).FocusControl
      else
        Result := nil;
end;

procedure TdxAutoLayoutItem.Apply(AProcessAnchors: Boolean = True);
begin
  if Labeled and (LayoutControlItem is TdxLayoutItem) then
  begin
    TdxLayoutItem(LayoutControlItem).Caption := Caption;
    TdxLayoutItem(LayoutControlItem).CaptionOptions.Layout := CaptionLayout;
  end;
  Control.Width := cxRectWidth(BoundsRect);
  Control.Height := cxRectHeight(BoundsRect);
  if AProcessAnchors then
    ProcessAnchors;
end;

procedure TdxAutoLayoutItem.ProcessAnchors;
const
  AlignHorzs: array[Boolean, Boolean] of TdxLayoutAlignHorz =
    ((ahLeft, ahRight), (ahLeft, ahClient));
  AlignVerts: array[Boolean, Boolean] of TdxLayoutAlignVert =
    ((avTop, avBottom), (avTop, avClient));
begin
  if LayoutControlItem.IsRoot then Exit;
  with Control do
  begin
    LayoutControlItem.AlignHorz := AlignHorzs[akLeft in Anchors, akRight in Anchors];
    LayoutControlItem.AlignVert := AlignVerts[akTop in Anchors, akBottom in Anchors];
  end;
end;

{ TdxAutoLayoutItemList }

function TdxAutoLayoutItemList.CanConvert(ASide: TcxBorder): Boolean;
var
  I, J: Integer;
begin
  Result := Count > 0;
  if Result then
  begin
    if ASide in [bTop, bBottom] then
    begin
      for I := 0 to Count - 1 do
        for J := I + 1 to Count - 1 do
          if (Items[I].BoundsRect.Top > Items[J].BoundsRect.Bottom) or
            (Items[J].BoundsRect.Top > Items[I].BoundsRect.Bottom) then
          begin
            Result := False;
            Break;
          end;
    end
    else
    begin
      for I := 0 to Count - 1 do
        for J := I + 1 to Count - 1 do
          if (Items[I].BoundsRect.Left > Items[J].BoundsRect.Right) or
            (Items[J].BoundsRect.Left > Items[I].BoundsRect.Right) then
          begin
            Result := False;
            Break;
          end;
    end;
  end;
end;

function TdxAutoLayoutItemList.First: TdxAutoLayoutItem;
begin
  Result := Items[0];
end;

procedure TdxAutoLayoutItemList.FreeItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  Clear;
end;

function TdxAutoLayoutItemList.GetItem(Index: Integer): TdxAutoLayoutItem;
begin
  Result := TdxAutoLayoutItem(inherited Items[Index]);
end;

function TdxAutoLayoutItemList.IsButtons: Boolean;
var
  I: Integer;
begin
  Result := Count > 0;
  if Result then
    for I := 0 to Count - 1 do
      if not Items[I].IsButton then
      begin
        Result := False;
        Break;
      end;
end;

function TdxAutoLayoutItemList.Last: TdxAutoLayoutItem;
begin
  Result := Items[Count - 1];
end;

{ TdxAutoLayoutOwnedItemList }

constructor TdxAutoLayoutOwnedItemList.Create(AAutoLayout: TdxAutoLayout);
begin
  inherited Create;
  FAutoLayout := AAutoLayout;
end;

function TdxAutoLayoutOwnedItemList.Add(AControl: TControl): TdxAutoLayoutItem;
begin
  Result := TdxAutoLayoutItem.Create(FAutoLayout, AControl);
  inherited Add(Result);
end;

procedure TdxAutoLayoutOwnedItemList.DeleteItems(AItems: TdxAutoLayoutItemList);
var
  I, AIndex: Integer;
begin
  for I := 0 to AItems.Count - 1 do
  begin
    AIndex := IndexOf(AItems[I]);
    if AIndex >= 0 then
      Delete(AIndex);
  end;
end;

function TdxAutoLayoutOwnedItemList.Remove(AControl: TControl): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if AControl = Items[I].Control then
    begin
      Items[I].Free;
      Delete(I);
      Result := True;
      Break;
    end;
end;

procedure TdxAutoLayoutOwnedItemList.RemoveItems(AItems: TdxAutoLayoutItemList);
var
  I, AIndex: Integer;
begin
  for I := 0 to AItems.Count - 1 do
  begin
    AIndex := IndexOf(AItems[I]);
    if AIndex >= 0 then
      Extract(AIndex);
  end;
end;

procedure TdxAutoLayoutOwnedItemList.Extract(AIndex: Integer);
begin
  Items[AIndex].Free;
  Delete(AIndex);
end;

function TdxAutoLayoutOwnedItemList.Find(AControl: TControl): TdxAutoLayoutItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if AControl = Items[I].Control then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TdxAutoLayoutOwnedItemList.GetItem(Index: Integer): TdxAutoLayoutItem;
begin
  Result := TdxAutoLayoutItem(inherited Items[Index]);
end;

{ TdxAutoLayoutHelper }

constructor TdxAutoLayoutHelper.Create(AOwner: TdxAutoLayout);
begin
  inherited Create;
  FOwner := AOwner;
  FAlignedItems := TdxAutoLayoutOwnedItemList.Create(Owner);
  FItems := TdxAutoLayoutOwnedItemList.Create(Owner);
end;

destructor TdxAutoLayoutHelper.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FAlignedItems);
  inherited Destroy;
end;

procedure TdxAutoLayoutHelper.Execute(AContainer: TWinControl;
  ARoot: TdxLayoutGroup);
begin
  Initialize(AContainer, ARoot);
  PopulateItems;
  ProcessLabels;
  DoExecute;
end;

procedure TdxAutoLayoutHelper.CheckRootDirection(ADirection: TdxLayoutDirection);

  function GetRootDirection: TdxLayoutDirection;
  begin
    if ADirection = ldHorizontal then
      Result := ldVertical
    else
      Result := ldHorizontal;
  end;

begin
  if Root.Count > 0 then
    MakeNewRoot;
  Root.LayoutDirection := GetRootDirection
end;

procedure TdxAutoLayoutHelper.ConvertGroup(AItems: TdxAutoLayoutItemList;
  ASide: TcxBorder);
const
  HAlign: array[TcxBorder] of TdxLayoutAlignHorz = (ahLeft, ahClient, ahRight, ahClient);
  VAlign: array[TcxBorder] of TdxLayoutAlignVert = (avClient, avTop, avClient, avBottom);

  function NewGroup: TdxLayoutGroup;
  const
    Directions: array[TcxBorder] of TdxLayoutDirection =
      (ldVertical, ldHorizontal, ldVertical, ldHorizontal);
    HAlign: array[TcxBorder] of TdxLayoutAlignHorz = (ahLeft, ahClient, ahRight, ahClient);
    VAlign: array[TcxBorder] of TdxLayoutAlignVert = (avClient, avTop, avClient, avBottom);
  begin
    Result := Root.CreateGroup;
    with Result do
    begin
      AlignHorz := HAlign[ASide];
      AlignVert := VAlign[ASide];
      Hidden := True;
      LayoutDirection := Directions[ASide];
    end;
  end;

  procedure AddItems(AGroup: TdxLayoutGroup);
  var
    I: Integer;
    ACanProcessAnchors: Boolean;
  begin
    if (AItems.Count > 1) or not AItems[0].CanResize then
      AGroup := NewGroup;
    for I := 0 to AItems.Count - 1 do
      AItems[I].CreateLayoutControlItem(AGroup);
    ACanProcessAnchors := AItems.CanConvert(ASide);
    for I := 0 to AItems.Count - 1 do
      AItems[I].Apply(ACanProcessAnchors and not AItems[I].IsSeparator);
    if (AItems.Count = 1) and (AItems[0].CanResize) then
    begin
      AItems[0].LayoutControlItem.AlignHorz := HAlign[ASide];
      AItems[0].LayoutControlItem.AlignVert := VAlign[ASide];
    end;
  end;

begin
  if AItems.Count = 0 then Exit;
  if ASide in [bTop, bBottom] then
    AItems.Sort(CompareLeft)
  else
    AItems.Sort(CompareTop);
  AddItems(Root);
  Items.RemoveItems(AItems);
end;

procedure TdxAutoLayoutHelper.DoAlignedControls;
var
  I: Integer;
  AItem: TdxAutoLayoutItem;
begin
  for I := ItemCount - 1 downto 0 do
  begin
    AItem := Items[I];
    if AItem.IsAligned then
    begin
      FAlignedItems.Add(AItem.Control);
      Items.Remove(AItem.Control);
    end;
  end;
  GenerateAlignedLayout;
end;

procedure TdxAutoLayoutHelper.DoExecute;
begin
  DoAlignedControls;
  DoNonAlignedControls;
end;

procedure TdxAutoLayoutHelper.DoNonAlignedControls;
var
  I: Integer;
begin
  if ItemCount = 0 then Exit;
  GenerateNonAlignedLayout;
  for I := 0 to FAlignedItems.Count - 1 do
    FAlignedItems[I].Apply;
end;

procedure TdxAutoLayoutHelper.Initialize(AContainer: TWinControl;
  ARoot: TdxLayoutGroup);
begin
  FRoot := ARoot;
  FContainer := AContainer;
  FAlignedItems.Clear;
  FItems.Clear;
  FAligns := [];
  FNonAlignedBoundsRect := Container.ClientRect;
end;

procedure TdxAutoLayoutHelper.PopulateItems;
var
  I: Integer;
begin
  for I := 0 to Container.ControlCount - 1 do
    if CanExport(Container.Controls[I]) then
      Items.Add(Container.Controls[I]);
end;

procedure TdxAutoLayoutHelper.PopulateItemsAtRect(AItems: TdxAutoLayoutItemList;
  const R: TRect);
var
  I: Integer;
begin
  AItems.Clear;
  for I := 0 to ItemCount - 1 do
    if cxRectIntersect(R, Items[I].BoundsRect) then
      AItems.Add(Items[I]);
end;

procedure TdxAutoLayoutHelper.GenerateAligned(AAlign: TAlign);
var
  L: TdxAutoLayoutItemList;
  I: Integer;
  ALastBounds: TRect;
begin
  L := TdxAutoLayoutItemList.Create;
  try
    for I := 0 to FAlignedItems.Count - 1 do
      if FAlignedItems[I].Align = AAlign then
        L.Add(FAlignedItems[I]);
    if L.Count > 1 then
      case AAlign of
        alTop: L.Sort(CompareTop);
        alBottom: L.Sort(CompareBottom);
        alLeft: L.Sort(CompareLeft);
        alRight: L.Sort(CompareRight);
      end;
    if L.Count > 0 then
    begin
      Include(FAligns, AAlign);
      ALastBounds := L.Last.BoundsRect;
      case AAlign of
        alTop: FNonAlignedBoundsRect.Top := ALastBounds.Bottom;
        alBottom: FNonAlignedBoundsRect.Bottom := ALastBounds.Top;
        alLeft: FNonAlignedBoundsRect.Left := ALastBounds.Right;
        alRight: FNonAlignedBoundsRect.Right := ALastBounds.Bottom;
      end;
    end;
    for I := 0 to L.Count - 1 do
      L[I].CreateLayoutControlItem(Root);
  finally
    L.Free;
  end;
end;

procedure TdxAutoLayoutHelper.GenerateAlignedLayout;
var
  I: Integer;
begin
  if FAlignedItems.Count = 0 then Exit;
  GenerateAligned(alTop);
  GenerateAligned(alBottom);
  if FAligns * [alTop, alBottom] <> [] then
    MakeNewRoot;
  Root.LayoutDirection := ldHorizontal;
  GenerateAligned(alLeft);
  GenerateAligned(alRight);
  if FAligns * [alLeft, alRight] <> [] then
    MakeNewRoot;
  Root.LayoutDirection := ldVertical;
  GenerateAligned(alClient);
  for I := 0 to FAlignedItems.Count - 1 do
    FAlignedItems[I].Apply;
end;

procedure TdxAutoLayoutHelper.GenerateNonAlignedLayout;
var
  ASides: array[TcxBorder] of TdxAutoLayoutItemList;
  I, AMostSuitableSide: TcxBorder;
  ATestSides: TcxBorders;
  ASideOrder: TdxSideItemList;

  function GetSideWeight(ASide: TcxBorder): Integer;
  begin
    Result := 0;
    if not (ASide in ATestSides) then Exit;
    Result := Result or (Ord(ASides[ASide].CanConvert(ASide)) shl 11);
    Result := Result or ((ASides[ASide].Count and $FF) shl 3);
    Result := Result or (Ord(ASides[ASide].IsButtons) shl 2);
    Result := Result or (Ord(ASide) and $3);
  end;

  function GetMostSuitableSide: TcxBorder;
  var
    I: TcxBorder;
    AWeight: Integer;
  begin
    Result := bLeft;
    AWeight := GetSideWeight(Result);
    for I := Succ(Low(TcxBorder)) to High(TcxBorder) do
      if GetSideWeight(I) > AWeight then
      begin
        Result := I;
        AWeight := GetSideWeight(Result);
      end;
  end;

  procedure ProcessUngroupedItems(ASide: TcxBorder);
  var
    AUnroupedItems: TdxAutoLayoutItemList;
    I: Integer;
  begin
    AUnroupedItems := TdxAutoLayoutItemList.Create;
    try
      for I := 0 to ItemCount - 1 do
        AUnroupedItems.Add(Items[I]);
      ConvertGroup(AUnroupedItems, ASide);
    finally
      AUnroupedItems.Free;
    end;
  end;

begin
  AMostSuitableSide := bTop;
  ASideOrder := TdxSideItemList.Create(Self);
  try
    for I := Low(TcxBorder) to High(TcxBorder) do
      ASides[I] := TdxAutoLayoutItemList.Create;
    try
      while ItemCount > 0 do
      begin
        ATestSides := [];
        for I := Low(TcxBorder) to High(TcxBorder) do
        begin
          GetSideItemGroup(ASides[I], I);
          if ASides[I].CanConvert(I) then
            Include(ATestSides, I);
        end;
        if ATestSides = [] then Break;
        AMostSuitableSide := GetMostSuitableSide;
        ASideOrder.Add(ASides[AMostSuitableSide], AMostSuitableSide);
        if ItemCount = 1 then
        begin
          ASides[AMostSuitableSide].Clear;
          ASides[AMostSuitableSide].Add(Items[0]);
          ASideOrder.Add(ASides[AMostSuitableSide], AMostSuitableSide);
        end;
      end;
    finally
      for I := Low(TcxBorder) to High(TcxBorder) do
        ASides[I].Free;
    end;
    ASideOrder.Build;
  finally
    ASideOrder.Free;
  end;
  ProcessUngroupedItems(AMostSuitableSide);
end;

procedure TdxAutoLayoutHelper.GetSideItemGroup(AItems: TdxAutoLayoutItemList;
  ASide: TcxBorder);

  procedure InitParams(out AIncX, AIncY, AEdge: Integer; out R: TRect);
  const
    DeltaX: array[TcxBorder] of Integer = (1, 0, -1, 0);
    DeltaY: array[TcxBorder] of Integer = (0, 1, 0, -1);
  var
    APos: Integer;
  begin
    R := UpdateUtmostItems;
    AIncX := DeltaX[ASide];
    AIncY := DeltaY[ASide];
    case ASide of
      bTop:
        begin
          APos := FTopmostItem.BoundsRect.Bottom;
          AEdge := R.Bottom;
          R := cxRect(R.Left, APos, R.Right, APos + 1);
        end;
      bBottom:
        begin
          APos := FBottommostItem.BoundsRect.Top;
          AEdge := R.Top;
          R := cxRect(R.Left, APos, R.Right, APos + 1);
        end;
      bLeft:
        begin
          APos := FLeftmostItem.BoundsRect.Right;
          AEdge := R.Right;
          R := cxRect(APos, R.Top, APos + 1, R.Bottom);
        end;
      bRight:
        begin
          APos := FRightmostItem.BoundsRect.Left;
          AEdge := R.Left;
          R := cxRect(APos, R.Top, APos + 1, R.Bottom);
        end;
    end;
  end;

  function GetItemsBounds(const ANonItemsBounds: TRect): TRect;
  begin
    with ANonItemsBounds do
    begin
      case ASide of
        bTop:
          Result := cxRect(Left, FTopmostItem.BoundsRect.Top, Right, Top);
        bBottom:
          Result := cxRect(Left, Top, Right, FBottommostItem.BoundsRect.Bottom);
        bLeft:
          Result := cxRect(FLeftmostItem.BoundsRect.Left, Top, Left, Bottom);
        else //bRight:
          Result := cxRect(Left + 1, Top, FRightmostItem.BoundsRect.Right, Bottom);
      end;
    end;
  end;

  function Done(const R: TRect; AEdge: Integer): Boolean;
  begin
    case ASide of
      bTop:
        Result := R.Top > AEdge;
      bBottom:
        Result := R.Top < AEdge;
      bLeft:
        Result := R.Left > AEdge;
      else //bRight:
        Result := R.Left < AEdge;
    end;
  end;
  
var
  AIncX, AIncY, AEdge: Integer;
  R: TRect;
begin
  AItems.Clear;
  if ItemCount = 0 then Exit;
  InitParams(AIncX, AIncY, AEdge, R);
  repeat
    OffsetRect(R, AIncX, AIncY);
    if not HasItemsAtRect(R) then
    begin
      PopulateItemsAtRect(AItems, GetItemsBounds(R));
      if AItems.Count > 0 then
        Exit;
    end;
  until Done(R, AEdge);
end;

function TdxAutoLayoutHelper.GetFocusControl(
  AItem: TdxAutoLayoutItem): TWinControl;
var
  I, X, Y, DX, DY: Integer;
  AControlX, AControlY: TControl;
begin
  Result := AItem.GetFocusControl;
  if (Result = nil) and Owner.SmartFindFocusControl then
  begin
    AControlX := nil;
    DX := MaxInt;
    Y := (AItem.BoundsRect.Top + AItem.BoundsRect.Bottom) div 2;
    for I := AItem.BoundsRect.Right + 1 to Container.ClientWidth do
    begin
      AControlX := GetControlAtPos(I, Y);
      if AControlX <> nil  then
      begin
        if not (AControlX is TWinControl) then
          AControlX := nil
        else
          DX := AControlX.Left - AItem.BoundsRect.Right;
        Break;
      end;
    end;
    if (AControlX <> nil) and (DX < Owner.FocusControlDistanceX) then
    begin
      Result := TWinControl(AControlX);
      Exit;
    end;
    AControlY := nil;
    DY := MaxInt;
    X := (AItem.BoundsRect.Right + AItem.BoundsRect.Left) div 2;
    for I := AItem.BoundsRect.Bottom + 1 to Container.ClientHeight do
    begin
      AControlY := GetControlAtPos(X, I);
      if AControlY <> nil  then
      begin
        if not (AControlY is TWinControl) then
          AControlY := nil
        else
          DY := AControlY.Top - AItem.BoundsRect.Bottom;
        Break;
      end;
    end;
    if (AControlY <> nil) and (DY < Owner.FocusControlDistanceY) then
      Result := TWinControl(AControlY);
  end;
end;

function TdxAutoLayoutHelper.CanExport(AControl: TControl): Boolean;
begin
  Result := (AControl <> Owner.Control) and (AControl <> Container) and 
    not (csNoDesignVisible in AControl.ControlStyle) and
    not (csSubComponent in AControl.ComponentStyle);
end;

function TdxAutoLayoutHelper.FindBottommostItem: TdxAutoLayoutItem;
var
  I: Integer;
begin
  Result := Items[0];
  for I := 1 to ItemCount - 1 do
    if Items[I].BoundsRect.Bottom > Result.BoundsRect.Bottom then
      Result := Items[I];
end;

function TdxAutoLayoutHelper.FindLeftmostItem: TdxAutoLayoutItem;
var
  I: Integer;
begin
  Result := Items[0];
  for I := 1 to ItemCount - 1 do
    if Items[I].BoundsRect.Left < Result.BoundsRect.Left then
      Result := Items[I];
end;

function TdxAutoLayoutHelper.FindRightmostItem: TdxAutoLayoutItem;
var
  I: Integer;
begin
  Result := Items[0];
  for I := 1 to ItemCount - 1 do
    if Items[I].BoundsRect.Right > Result.BoundsRect.Right then
      Result := Items[I];
end;

function TdxAutoLayoutHelper.FindTopmostItem: TdxAutoLayoutItem;
var
  I: Integer;
begin
  Result := Items[0];
  for I := 1 to ItemCount - 1 do
    if Items[I].BoundsRect.Top < Result.BoundsRect.Top then
      Result := Items[I];
end;

function TdxAutoLayoutHelper.GetControlAtPos(X, Y: Integer): TControl;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Container.ControlCount - 1 do
    if (Owner.Control <> Container.Controls[I]) and
      cxRectPtIn(Container.Controls[I].BoundsRect, X, Y) then
    begin
      Result := Container.Controls[I];
      Break;
    end;
end;

function TdxAutoLayoutHelper.GetItemCount: Integer;
begin
  Result := Items.Count;
end;

function TdxAutoLayoutHelper.HasItemsAtRect(const R: TRect): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ItemCount - 1 do
    if cxRectIntersect(R, Items[I].BoundsRect) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TdxAutoLayoutHelper.MakeNewRoot;
begin
  FRoot := FRoot.CreateGroup;
  FRoot.AlignHorz := ahClient;
  FRoot.AlignVert := avClient;
  FRoot.Hidden := True;
end;

procedure TdxAutoLayoutHelper.ProcessLabels;
var
  I: Integer;
  AControl: TWinControl;
  AItem: TdxAutoLayoutItem;
begin
  for I := ItemCount - 1 downto 0 do
    if Items[I].IsLabel then
    begin
      AControl := GetFocusControl(Items[I]);
      if AControl <> nil then
      begin
        AItem := Items.Find(AControl);
        if AItem <> nil then
        begin
          AItem.SetLabelInfo(Items[I].Control);
          Items.Extract(I);
        end;
      end;
    end;
end;

function TdxAutoLayoutHelper.UpdateUtmostItems: TRect;
begin
  FTopmostItem := FindTopmostItem;
  FBottommostItem := FindBottommostItem;
  FLeftmostItem := FindLeftmostItem;
  FRightmostItem := FindRightmostItem;
  Result := cxRect(FLeftmostItem.BoundsRect.Left, FTopmostItem.BoundsRect.Top,
    FRightmostItem.BoundsRect.Right, FBottommostItem.BoundsRect.Bottom);
end;

{ TdxAutoLayout }

constructor TdxAutoLayout.Create(AControl: TdxCustomLayoutControl);
begin
  inherited Create;
  FControl := AControl;
  FConvertPageControls := True;
  FSmartFindFocusControl := True;
  FFocusControlDistanceX := 48;
  FFocusControlDistanceY := 16;
  FUseLabeledItems := True;
end;

procedure TdxAutoLayout.DoExecute(AContainer: TWinControl; ARecursive: Boolean = True);
begin
  FRecursive := ARecursive;
  with TdxAutoLayoutHelper.Create(Self) do
  try
    Control.BeginUpdate;
    try
      Execute(AContainer, Control.Items);
      CorrectAlign(Control.Items);
    finally
      Control.EndUpdate;
    end;
  finally
    Free;
  end;
end;

procedure TdxAutoLayout.Execute(AContainer: TWinControl; ARecursive: Boolean = True);
begin
  if AContainer = nil then
    Exit;
  AContainer.DisableAlign;
  try
    DoExecute(AContainer, ARecursive);
  finally
    AContainer.EnableAlign;
  end;
end;

procedure TdxAutoLayout.CorrectAlign(AGroup: TdxLayoutGroup);

  procedure DoCorrectAlign(AItem: TdxCustomLayoutItem);
  begin
    if AItem.AlignHorz = TdxCustomLayoutItemAccess(AItem).GetParentManagedAlignHorz then
      AItem.AlignHorz := ahParentManaged;
    if AItem.AlignVert = TdxCustomLayoutItemAccess(AItem).GetParentManagedAlignVert then
      AItem.AlignVert := avParentManaged;
  end;

var
  I: Integer;
begin
  for I := 0 to AGroup.Count -1 do
  begin
    if AGroup[I] is TdxLayoutGroup then
      CorrectAlign(TdxLayoutGroup(AGroup[I]));
    DoCorrectAlign(AGroup[I]);
  end;
end;

procedure ImportLayout(ALayoutControl: TdxLayoutControl);

  function GetRoot: TWinControl;
  begin
    Result := ALayoutControl.Owner as TWinControl;
  end;

  function CanExport(AControl: TControl): Boolean;
  begin
    Result := (AControl <> ALayoutControl) and
      not (csNoDesignVisible in AControl.ControlStyle) and not (csSubComponent in AControl.ComponentStyle);
  end;

  function AddItems(AControl: TWinControl; AStrings: TStrings;
    AInsertionIndex: Integer): Boolean;
  var
    I: Integer;
  begin
    with AControl do
    begin
      Result := CanExport(AControl) and (csAcceptsControls in ControlStyle);
      if Result then
      begin
        AStrings.InsertObject(AInsertionIndex, Name, AControl);
        AInsertionIndex := AStrings.Count;
        for I := 0 to ControlCount - 1 do
          if Controls[I] is TWinControl then
            if AddItems(TWinControl(Controls[I]), AStrings, AInsertionIndex) then
              Inc(AInsertionIndex);
      end;
    end;
  end;

var
  ASaveCursor: TCursor;
begin
  if ALayoutControl = nil then Exit;
  with TfmImport.Create(nil) do
  try
    AddItems(GetRoot, cbContainers.Properties.Items, 0);
    if cbContainers.Properties.Items.Count <> 0 then
      cbContainers.ItemIndex := 0
    else
      btnImport.Enabled := False;
    seDeltaX.Value := 48;
    seDeltaY.Value := 16;
    if ShowModal = mrOk then
    begin
      with TdxAutoLayout.Create(ALayoutControl) do
      try
        ConvertPageControls := cbConvertPageControls.Checked;
        SmartFindFocusControl := cbAssociate.Checked;
        UseLabeledItems := cbUseLabeledItems.Checked;
        FocusControlDistanceX := seDeltaX.Value;
        FocusControlDistanceY := seDeltaY.Value;
        ASaveCursor := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        try
          Execute(TWinControl(cbContainers.Properties.Items.Objects[cbContainers.ItemIndex]), True);
        finally
          Screen.Cursor := ASaveCursor;
        end;
      finally
        Free;
      end;
      ALayoutControl.AutoSize := True
    end;
  finally
    Free;
  end;
end;

procedure TfmImport.cbAssociateClick(Sender: TObject);
begin
  seDeltaX.Enabled := cbAssociate.Checked;
  seDeltaY.Enabled := cbAssociate.Checked;
end;

end.
