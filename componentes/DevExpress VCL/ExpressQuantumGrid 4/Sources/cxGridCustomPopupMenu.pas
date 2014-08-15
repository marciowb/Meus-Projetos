{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid Utils                                     }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxGridCustomPopupMenu;

{$I cxGridUtils.inc}

interface

uses
  Windows, Messages,
{$IFNDEF DELPHI5}
  cxClasses,
{$ENDIF}
  Classes, SysUtils, Controls, cxGridCustomView, ImgList, Menus;

const
  cxhtGridBase = 1000;

type
  EcxGridPopupMenu = class(Exception);

  TcxGridViewHitType = (gvhtGridNone, gvhtGridTab, gvhtNone, gvhtTab, gvhtCell,
    gvhtExpandButton, gvhtRecord, gvhtNavigator, gvhtPreview, gvhtColumnHeader,
    gvhtColumnHeaderFilterButton, gvhtFilter, gvhtFooter, gvhtFooterCell,
    gvhtGroupFooter, gvhtGroupFooterCell, gvhtGroupByBox, gvhtIndicator,
    gvhtRowIndicator, gvhtRowLevelIndent, gvhtBand, gvhtBandHeader,
  	gvhtRowCaption, gvhtSeparator);

  TcxGridViewHitTypes = Set of TcxGridViewHitType;

  TcxGridBeforePopupProc = procedure (ASenderMenu: TComponent;
      AHitTest: TcxCustomGridHitTest; X,Y: Integer; var AllowPopup: Boolean) of object;

  TcxGridOnPopupProc = procedure (ASenderMenu: TComponent;
      AHitTest: TcxCustomGridHitTest; X,Y: Integer) of object;

  TcxGridPopupMenuItemClickProc = procedure(ASender: TObject;
   AHitTest: TcxCustomGridHitTest; var AHandler: TNotifyEvent;
   AParams: TList; var AHandled: Boolean) of object;

  TcxPopupMenuClass = class of TComponent;

  TcxPopupMenuClassInfoRec = record
    FMenuClass: TcxPopupMenuClass;
    FHitTypes: TcxGridViewHitTypes;
    FViewClass: TcxCustomGridViewClass;
  end;

  PcxPopupMenuClassInfoRec = ^TcxPopupMenuClassInfoRec;

  PWMKeyDown = ^TWMKeyDown;

  IDoPopup = interface
    ['{41999EDE-B9D9-4808-9D01-61B09DF700FA}']
    function GetPopupHandler: TcxGridOnPopupProc;
  end;

  TcxPopupMenuInfo = Class(TCollectionItem)
  private
    FPopupMenu: TComponent;
    FPopupProc: TcxGridOnPopupProc;
    FHitTypes: TcxGridViewHitTypes;
    FLocked: Boolean;
    FView: TcxCustomGridView;
    FViewClass: TcxCustomGridViewClass;
    function FindCorrectComponent(const AComponent: TComponent): TComponent;
    procedure SetPopupMenu(const AValue: TComponent);
    procedure SetView(const AValue: TcxCustomGridView);
    procedure SetViewClass(const Value: TcxCustomGridViewClass);
  protected
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    procedure DoChanged(const APopupMenu: TComponent; const AView: TcxCustomGridView;
      AViewClass: TcxCustomGridViewClass); virtual;
    property GridViewClass: TcxCustomGridViewClass read FViewClass write SetViewClass;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property GridView: TcxCustomGridView read FView write SetView;
    property HitTypes: TcxGridViewHitTypes read FHitTypes write FHitTypes;
    property Index;
    property OnPopup: TcxGridOnPopupProc read FPopupProc write FPopupProc;
    property PopupMenu: TComponent read FPopupMenu write SetPopupMenu;
  end;

  TcxPopupMenuInfos = class(TCollection)
  private
    FOwner: TComponent;
    function GetItem(AIndex: Integer): TcxPopupMenuInfo;
    procedure SetItem(AIndex: Integer; const AValue: TcxPopupMenuInfo);
  protected
    function  GetOwner: TPersistent; override;
    {$IFDEF DELPHI6}
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); virtual;
    function GetSameMenuCount(const AMenu: TComponent): Integer;
    property Items[AIndex: Integer]: TcxPopupMenuInfo read GetItem write SetItem; default;
  end;

  TcxCustomGridPopupMenu = class(TComponent)
  private
    FPopupMenuInfos: TcxPopupMenuInfos;
    function GetMenuInfo(AIndex: Integer): TcxPopupMenuInfo;
    function GetMenuInfoCount: Integer;
    procedure SetPopupMenuInfos(const AValue: TcxPopupMenuInfos);
  protected
    procedure AddMenuInfo(const AMenu: TComponent; AHitTypes: TcxGridViewHitTypes;
          ADoPopupProc: TcxGridOnPopupProc; AViewClass: TcxCustomGridViewClass = nil;
          const AView: TcxCustomGridView = nil);
    procedure ClearMenuInfosGridView(const AView: TcxCustomGridView = nil);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetPopupMenuInfo(const AMenu: TComponent; const AView: TcxCustomGridView;
                  ASearchDefault: Boolean = True): TcxPopupMenuInfo; virtual;
    property PopupMenuInfos: TcxPopupMenuInfos read FPopupMenuInfos write SetPopupMenuInfos;
    property MenuInfos[AIndex: Integer]: TcxPopupMenuInfo read GetMenuInfo; default;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CheckShortCuts(Message: PWMKeyDown): Boolean; virtual;
    property Count: Integer read GetMenuInfoCount;
  end;

  TcxGridDefaultPopupMenu = class(TcxCustomGridPopupMenu)
  public
    function GetPopupMenuInfo(const AMenu: TComponent; const AView: TcxCustomGridView;
                  ASearchDefault: Boolean = True): TcxPopupMenuInfo;overload; override;
    function GetPopupMenuInfo(const AMenu: TComponent; AViewClass: TcxCustomGridViewClass;
          ASearchDefault: Boolean = True): TcxPopupMenuInfo; reintroduce; overload;
    procedure RegisterPopupMenu(const AMenu: TComponent; AHitTypes: TcxGridViewHitTypes;
        ADoPopupProc: TcxGridOnPopupProc; AViewClass: TcxCustomGridViewClass); virtual;
    procedure UnRegisterPopupMenu(const AMenu: TComponent; AViewClass: TcxCustomGridViewClass;
              AHitTypes: TcxGridViewHitTypes = []); virtual;
    property MenuInfos;
  end;

  function GetHitTypeByHitCode(AHitCode: Integer): TcxGridViewHitType;

  procedure RegisterPopupMenuClass(APopupMenuClass: TcxPopupMenuClass;
    AHitTypes: TcxGridViewHitTypes; AViewClass: TcxCustomGridViewClass);

var
  FBuiltInPopupMenuList: TList;
  cxGridPopupMenuImages: TImageList;

implementation

uses
  cxGridCustomTableView, cxGridTableView, Graphics, Dialogs, cxGridDetailsSite,
  cxGridRows, cxGridBandedTableView, cxGridCardView, Forms;

function GetHitTypeByHitCode(AHitCode: Integer): TcxGridViewHitType;
const
  cxGridViewHitCodes: array[TcxGridViewHitType] of integer = (htNone + cxhtGridBase,
    htTab + cxhtGridBase, htNone, htTab, htCell, htExpandButton, htRecord, htNavigator,
    htPreview, htColumnHeader, htColumnHeaderFilterButton, htFilter, htFooter, htFooterCell, 
    htGroupFooter, htGroupFooterCell, htGroupByBox, htIndicator, htRowIndicator, 
    htRowLevelIndent, htBand, htBandHeader, htRowCaption, htSeparator);
var
  i: integer;
begin
  Result := TcxGridViewHitType(-1);
  For i := Ord(Low(cxGridViewHitCodes)) to Ord(High(cxGridViewHitCodes)) do
    If (cxGridViewHitCodes[TcxGridViewHitType(i)] = AHitCode) then
    begin
      Result := TcxGridViewHitType(i);
      Break;
    end;
end;

{ TcxPopupMenuInfo }

procedure TcxPopupMenuInfo.BeginUpdate;
begin
  FLocked := True;
end;

procedure TcxPopupMenuInfo.EndUpdate;
begin
  FLocked := False;
end;

procedure TcxPopupMenuInfo.DoChanged(const APopupMenu: TComponent;
  const AView: TcxCustomGridView; AViewClass: TcxCustomGridViewClass);
var
  AMenuInfo: TcxPopupMenuInfo;
  MenuInfos: TcxPopupMenuInfos;
begin
  AMenuInfo := nil;
  if FLocked then exit;
  MenuInfos := TcxPopupMenuInfos(Collection);
  if Assigned(AView) then
    AMenuInfo :=
        TcxCustomGridPopupMenu(MenuInfos.GetOwner).GetPopupMenuInfo(APopupMenu, AView)
  else
  begin
    if Assigned(AViewClass) and (MenuInfos.GetOwner is TcxGridDefaultPopupMenu) then
    AMenuInfo :=
        TcxGridDefaultPopupMenu(MenuInfos.GetOwner).GetPopupMenuInfo(APopupMenu, AViewClass);
  end;
  if (AMenuInfo <> nil) and (MenuInfos.GetOwner <> nil) and
    not (csLoading in (MenuInfos.GetOwner as TComponent).ComponentState) then
    Raise EcxGridPopupMenu.Create(
      Format('This PopupMenuInfo is already registered. Index: %d',[AMenuInfo.Index]));
end;

function TcxPopupMenuInfo.FindCorrectComponent(const AComponent: TComponent): TComponent;
var
  AOwner: TComponent;
begin
  Result := AComponent;
  if not Assigned(AComponent) then
    Exit;
  AOwner := TComponent(TcxPopupMenuInfos(Collection).GetOwner);
  while AOwner.InheritsFrom(TcxCustomGridPopupMenu) do
    AOwner := TcxCustomGridPopupMenu(AOwner).Owner;
  with AOwner do
    if (csUpdating in ComponentState) then
    begin
      Result := FindComponent(AComponent.Name);
      if not Assigned(Result) or (Result.ClassType <> AComponent.ClassType) then
        Result := AComponent;
    end;
end;

procedure TcxPopupMenuInfo.SetPopupMenu(const AValue: TComponent);
begin
  if FPopupMenu <> AValue then
  begin
    {$IFDEF DELPHI5}
    if (TcxPopupMenuInfos(Collection).GetSameMenuCount(FPopupMenu) > 1) and
      (FPopupMenu <> nil) and not (csDestroying in FPopupMenu.ComponentState) then
          FPopupMenu.RemoveFreeNotification(TComponent(TcxPopupMenuInfos(Collection).GetOwner));
    {$ENDIF}
    DoChanged(AValue, FView, FViewClass);
    FPopupMenu := AValue;
    if FPopupMenu <> nil then
      FPopupMenu.FreeNotification(TComponent(TcxPopupMenuInfos(Collection).GetOwner));
  end;
end;

procedure TcxPopupMenuInfo.SetView(const AValue: TcxCustomGridView);
begin
  if FView <> AValue then
  begin
    {$IFDEF DELPHI5}
    if Assigned(FView) and not (csDestroying in FView.ComponentState) then
      FView.RemoveFreeNotification(TComponent(TcxPopupMenuInfos(Collection).GetOwner));
    {$ENDIF}
    DoChanged(FPopupMenu, AValue, FViewClass);
    FView := AValue;
    if Assigned(FView) then
      FView.FreeNotification(TComponent(TcxPopupMenuInfos(Collection).GetOwner));
  end;
end;

procedure TcxPopupMenuInfo.SetViewClass(
  const Value: TcxCustomGridViewClass);
begin
  DoChanged(FPopupMenu, FView, Value);
  FViewClass := Value;
end;

procedure TcxPopupMenuInfo.Assign(Source: TPersistent);
var
  AMenuInfo: TcxPopupMenuInfo;
begin
  if Source is TcxPopupMenuInfo then
  begin
    if Collection <> nil then
      Collection.BeginUpdate;
    try
      BeginUpdate;
      try
        AMenuInfo := TcxPopupMenuInfo(Source);
        Index := AMenuInfo.Index;
        PopupMenu := FindCorrectComponent(AMenuInfo.PopupMenu);
        OnPopup := AMenuInfo.OnPopup;
        HitTypes := AMenuInfo.HitTypes;
        GridView := TcxCustomGridView(FindCorrectComponent(AMenuInfo.GridView));
        GridViewClass := AMenuInfo.GridViewClass;
      finally
        EndUpdate;
      end;
    finally
      if Collection <> nil then
        Collection.EndUpdate;
    end;
  end
  else
    inherited;
end;

{ TcxCustomGridPopupMenu }
constructor TcxCustomGridPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPopupMenuInfos := TcxPopupMenuInfos.Create(Self);
end;

destructor TcxCustomGridPopupMenu.Destroy;
begin
  FreeAndNil(FPopupMenuInfos);
  inherited Destroy;
end;

function TcxCustomGridPopupMenu.CheckShortCuts(Message: PWMKeyDown): Boolean;
var
  I: Integer;
begin
  Result := False;
  if not (csDesigning in ComponentState) then
  begin
    for I := 0 to FPopupMenuInfos.Count - 1 do
      with FPopupMenuInfos[I] do
        if Assigned(PopupMenu) and (PopupMenu is TPopupMenu) and
          (PopupMenu as TPopupMenu).IsShortCut(Message^) then
        begin
          Result := True;
          Break;
        end;
  end;
  Message^.Result := Message^.Result or Integer(Result);
end;

procedure TcxCustomGridPopupMenu.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: Integer;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent.InheritsFrom(TcxCustomGridView) then
       ClearMenuInfosGridView(TcxCustomGridView(AComponent))
    else
      if Assigned(FPopupMenuInfos) then
      begin
        i := FPopupMenuInfos.Count - 1;
        while i >= 0 do
          with FPopupMenuInfos[i] do
          begin
            if PopupMenu = AComponent then
              FPopupMenu := nil;
            i := i - 1;
          end;
      end;
  end;
end;

function TcxCustomGridPopupMenu.GetPopupMenuInfo(const AMenu: TComponent;
  const AView: TcxCustomGridView; ASearchDefault: Boolean): TcxPopupMenuInfo;
begin
  Result := Nil;
end;

procedure TcxCustomGridPopupMenu.AddMenuInfo(const AMenu: TComponent;
  AHitTypes: TcxGridViewHitTypes; ADoPopupProc: TcxGridOnPopupProc;
  AViewClass: TcxCustomGridViewClass; const AView: TcxCustomGridView);
begin
  with TcxPopupMenuInfo(FPopupMenuInfos.Add) do
  begin
    BeginUpdate;
    try
      PopupMenu := AMenu;
      OnPopup := ADoPopupProc;
      GridView := AView;
      GridViewClass := AViewClass;
      HitTypes := AHitTypes;
    finally
      EndUpdate;
    end;  
  end;
end;

procedure TcxCustomGridPopupMenu.ClearMenuInfosGridView(
  const AView: TcxCustomGridView = nil);
var
  I: Integer;
begin
  for I := 0 to PopupMenuInfos.Count - 1 do
    with PopupMenuInfos[I] do
    begin
      if Assigned(AView) and (GridView <> AView) then
        Continue;
      BeginUpdate;
      try
        GridView := nil;
      finally
        EndUpdate;
      end;
    end;
end;

function TcxCustomGridPopupMenu.GetMenuInfo(AIndex: Integer): TcxPopupMenuInfo;
begin
  Result := FPopupMenuInfos[AIndex];
end;

function TcxCustomGridPopupMenu.GetMenuInfoCount: Integer;
begin
  Result := FPopupMenuInfos.Count;
end;

procedure TcxCustomGridPopupMenu.SetPopupMenuInfos(const AValue: TcxPopupMenuInfos);
begin
  FPopupMenuInfos := AValue;
end;

{ TcxGridDefaultPopupMenu }

function TcxGridDefaultPopupMenu.GetPopupMenuInfo(const AMenu: TComponent;
  const AView: TcxCustomGridView; ASearchDefault: Boolean): TcxPopupMenuInfo;
begin
  Result := GetPopupMenuInfo(AMenu,TcxCustomGridViewClass(AView.ClassType),
    ASearchDefault);
end;

function TcxGridDefaultPopupMenu.GetPopupMenuInfo(const AMenu: TComponent;
  AViewClass: TcxCustomGridViewClass; ASearchDefault: Boolean): TcxPopupMenuInfo;
var
  I : Integer;
  AClass: TcxCustomGridViewClass;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if AMenu = MenuInfos[I].PopupMenu then
    begin
      AClass := MenuInfos[I].GridViewClass;
      if (AViewClass = AClass) then
      begin
        Result := MenuInfos[I];
        exit;
      end;
      if AViewClass.InheritsFrom(AClass) and ASearchDefault then
        if (Result = nil) or AClass.InheritsFrom(Result.GridViewClass) then
        begin
          Result := MenuInfos[I];
        end;
    end;
end;

procedure TcxGridDefaultPopupMenu.RegisterPopupMenu(const AMenu: TComponent;
  AHitTypes: TcxGridViewHitTypes; ADoPopupProc: TcxGridOnPopupProc;
  AViewClass: TcxCustomGridViewClass);
var
  AMenuInfo: TcxPopupMenuInfo;
begin
  if not Assigned(AViewClass) then exit;
  AMenuInfo := GetPopupMenuInfo(AMenu, AViewClass);
  if AMenuInfo <> nil then
    AMenuInfo.HitTypes := AMenuInfo.HitTypes + AHitTypes
  else
    AddMenuInfo(AMenu, AHitTypes, ADoPopupProc, AViewClass);
end;

procedure TcxGridDefaultPopupMenu.UnRegisterPopupMenu(const AMenu: TComponent;
  AViewClass: TcxCustomGridViewClass; AHitTypes: TcxGridViewHitTypes);
var
  AMenuInfo: TcxPopupMenuInfo;
begin
  AMenuInfo := GetPopupMenuInfo(AMenu, AViewClass, false);
  If AMenuInfo <> nil then
    If AMenuInfo.HitTypes = AHitTypes then
      AMenuInfo.Free
    else
      AMenuInfo.HitTypes := AMenuInfo.HitTypes - AHitTypes;
end;

{ TcxPopupMenuInfos }

constructor TcxPopupMenuInfos.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
  inherited Create(TcxPopupMenuInfo);
end;

function TcxPopupMenuInfos.GetSameMenuCount(
  const AMenu: TComponent): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].PopupMenu = AMenu then
      Inc(Result);
end;

function TcxPopupMenuInfos.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{$IFDEF DELPHI6}
procedure TcxPopupMenuInfos.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  If Action = cnDeleting then TcxPopupMenuInfo(Item).PopupMenu := nil;
  inherited;
end;
{$ENDIF}

function TcxPopupMenuInfos.GetItem(AIndex: Integer): TcxPopupMenuInfo;
begin
  Result := TcxPopupMenuInfo(inherited GetItem(AIndex));
end;

procedure TcxPopupMenuInfos.SetItem(AIndex: Integer;
  const AValue: TcxPopupMenuInfo);
begin
  inherited SetItem(AIndex , AValue);
end;

procedure RegisterPopupMenuClass(APopupMenuClass: TcxPopupMenuClass;
  AHitTypes: TcxGridViewHitTypes; AViewClass: TcxCustomGridViewClass);
var
  AMenuClassInfoRec: PcxPopupMenuClassInfoRec;
begin
  AMenuClassInfoRec := New(PcxPopupMenuClassInfoRec);
  AMenuClassInfoRec.FMenuClass := APopupMenuClass;
  AMenuClassInfoRec.FHitTypes := AHitTypes;
  AMenuClassInfoRec.FViewClass := AViewClass;
  FBuiltInPopupMenuList.Add(AMenuClassInfoRec);
end;

initialization
  FBuiltInPopupMenuList := TList.Create;
{$IFDEF DELPHI6}
  StartClassGroup(TControl);
  GroupDescendentsWith(TcxCustomGridPopupMenu, TControl);
{$ENDIF}

finalization
  while FBuiltInPopupMenuList.Count > 0 do
  begin
    Dispose(PcxPopupMenuClassInfoRec(FBuiltInPopupMenuList[0]));
    FBuiltInPopupMenuList.Delete(0);
  end;
  FreeAndNil(FBuiltInPopupMenuList);
  FreeAndNil(cxGridPopupMenuImages);
end.

