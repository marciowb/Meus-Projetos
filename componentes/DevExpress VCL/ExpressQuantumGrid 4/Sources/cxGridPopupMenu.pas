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

unit cxGridPopupMenu;

{$I cxGridUtils.inc}

interface

uses
  Windows, Messages,
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
{$IFNDEF DELPHI5}
  cxClasses,
{$ENDIF}
  SysUtils, Classes, Controls, cxGrid, cxGridCustomView,
  cxGridUIHelper, cxGridUICustomTableHelper, cxGridUITableHelper,
  cxGridUIBandedTableHelper, cxGridUICardHelper, cxGridCustomPopupMenu;

type
TcxGridPopupMenu = class(TcxCustomGridPopupMenu)
  private
    FAlwaysFireOnPopup: Boolean;
    FGrid: TcxGrid;
    FGridDefaultPopupMenu: TcxGridDefaultPopupMenu;
    FGridOperationHelper: TcxGridOperationHelper;
    FHitGridView: TcxCustomGridView;
    FHitPoint: TPoint;
    FHitTest: TcxCustomGridHitTest;
    FHitType: TcxGridViewHitType;
    FMouseupNotification: TcxCustomGridNotification;
    FOnClick: TcxGridPopupMenuItemClickProc;
    FOnPopup: TcxGridBeforePopupProc;
    FUseBuiltInPopupMenus: Boolean;
    function GetPopupMenus: TcxPopupMenuInfos;
    procedure CreateBuiltInPopupMenus;
    procedure FreeBuiltInPopupMenus;
    procedure SetUseBuiltInPopupMenus(const Value: Boolean);
    procedure SetGrid(const AValue: TcxGrid);
    procedure SetPopupMenus(const AValue: TcxPopupMenuInfos);
  protected
    function DoOnPopup(ASenderMenu: TComponent;
      AHitTest: TcxCustomGridHitTest; X,Y: Integer): Boolean; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function DoPopup(AAPPSKeyPressed: Boolean): Boolean; virtual;
    function GetPopupMenuInfo(const AMenu: TComponent; const AView: TcxCustomGridView;
                  SearchDefault: Boolean = True): TcxPopupMenuInfo; override;
    property GridOperationHelper: TcxGridOperationHelper read FGridOperationHelper;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CheckShortCuts(Message: PWMKeyDown): Boolean; override;
    function GetBuiltInPopupMenuByClass(const AMenuClass: TcxPopupMenuClass): TComponent;
    procedure RegisterPopupMenu(const AMenu: TComponent; AHitTypes: TcxGridViewHitTypes;
      ADoPopupProc: TcxGridOnPopupProc; const AView: TcxCustomGridView); overload; virtual;
    procedure RegisterPopupMenu(const AMenu: TComponent; AHitTypes: TcxGridViewHitTypes;
        ADoPopupProc: TcxGridOnPopupProc; AViewClass: TcxCustomGridViewClass); overload; virtual;
    procedure UnregisterPopupMenu(const AMenu: TComponent; const AGridView: TcxCustomGridView;
                AHitTypes: TcxGridViewHitTypes = []); overload; virtual;
    procedure UnregisterPopupMenu(const AMenu: TComponent; AGridViewClass: TcxCustomGridViewClass;
                AHitTypes: TcxGridViewHitTypes = []); overload; virtual;
    property BuiltInPopupMenus: TcxGridDefaultPopupMenu read FGridDefaultPopupMenu;
    property HitGridView: TcxCustomGridView read FHitGridView;
    property HitPoint: TPoint read FHitPoint;
    property HitTest: TcxCustomGridHitTest read FHitTest;
    property HitType: TcxGridViewHitType read FHitType;
  published
    property Grid: TcxGrid read FGrid write SetGrid;
    property PopupMenus: TcxPopupMenuInfos read GetPopupMenus write SetPopupMenus;
    property UseBuiltInPopupMenus: Boolean read FUseBuiltInPopupMenus write
      SetUseBuiltInPopupMenus default True;
    property OnMenuItemClick: TcxGridPopupMenuItemClickProc read FOnClick write FOnClick;
    property OnPopup: TcxGridBeforePopupProc read FOnPopup write FOnPopup;
    property AlwaysFireOnPopup: Boolean read FAlwaysFireOnPopup write FAlwaysFireOnPopup default False;
  end;

implementation

uses
  cxGridLevel, Dialogs, cxGridStdPopupMenu, Menus, cxGridCustomTableView;

type
  TcxGridContextPopupNotification = class(TcxCustomGridNotification)
  private
    FGridPopupMenu: TcxGridPopupMenu;
  protected
    procedure Notify(AKind: TcxGridNotificationKind; AData: Pointer = nil); override;
    function NotificationKinds: TcxGridNotificationKinds; override;
  end;

  TcxPopupMenuInfoAccess = class(TcxPopupMenuInfo);
  TcxCustomGridViewInfoAccess = class(TcxCustomGridViewInfo);

procedure TcxGridContextPopupNotification.Notify(AKind: TcxGridNotificationKind;
  AData: Pointer = nil);
begin
  case (AKind) of
    gnkContextMenu:
      FGridPopupMenu.DoPopup(Boolean(AData));
    gnkKeyDown:
      FGridPopupMenu.CheckShortCuts(PWMKeyDown(AData));
  end;
end;

function TcxGridContextPopupNotification.NotificationKinds: TcxGridNotificationKinds;
begin
  Result := [gnkContextMenu, gnkKeyDown];
end;

{TcxGridPopupMenu}

constructor TcxGridPopupMenu.Create (AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlwaysFireOnPopup := False;
  FGridDefaultPopupMenu := TcxGridDefaultPopupMenu.Create(Self);
  FUseBuiltInPopupMenus := True;
  CreateBuiltInPopupMenus;
  FGridOperationHelper := TcxGridOperationHelper.Create(Self);
  FMouseupNotification := TcxGridContextPopupNotification.Create;
  TcxGridContextPopupNotification(FMouseupNotification).FGridPopupMenu := self;
end;

destructor TcxGridPopupMenu.Destroy;
begin
  FreeBuiltInPopupMenus;
  FreeAndNil(FGridOperationHelper);
  FreeAndNil(FGridDefaultPopupMenu);
  if Grid <> nil then
    Grid.UnregisterNotification(FMouseupNotification);
  FreeAndNil(FMouseupNotification);
  inherited Destroy;
end;

function TcxGridPopupMenu.CheckShortCuts(Message: PWMKeyDown): Boolean;
begin
  Result := inherited CheckShortCuts(Message);
  if not Result then
    Result := FGridDefaultPopupMenu.CheckShortCuts(Message);
end;

function TcxGridPopupMenu.GetBuiltInPopupMenuByClass(
  const AMenuClass: TcxPopupMenuClass): TComponent;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FGridDefaultPopupMenu.Count - 1 do
    if Assigned(FGridDefaultPopupMenu[i].PopupMenu) and
      (FGridDefaultPopupMenu[i].PopupMenu.ClassType = AMenuClass) then
    begin
      Result := FGridDefaultPopupMenu[i].PopupMenu;
      break;
    end;
end;

function TcxGridPopupMenu.GetPopupMenuInfo(const AMenu: TComponent;
  const AView: TcxCustomGridView; SearchDefault: Boolean = True): TcxPopupMenuInfo;
var
  I : Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    If (AMenu = MenuInfos[I].PopupMenu) and (AView = MenuInfos[I].GridView) then
    begin
      Result := MenuInfos[I];
      Result.Index := I;
      break;
    end;
  if SearchDefault and not Assigned(Result) then
    Result := FGridDefaultPopupMenu.GetPopupMenuInfo(AMenu,
      TcxCustomGridViewClass(AView.ClassType));
end;

procedure TcxGridPopupMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Grid) then
    FGrid := nil;
end;

procedure TcxGridPopupMenu.RegisterPopupMenu(const AMenu: TComponent;
  AHitTypes: TcxGridViewHitTypes; ADoPopupProc: TcxGridOnPopupProc;
  const AView: TcxCustomGridView);
var
  AMenuInfo: TcxPopupMenuInfo;
begin
  if not Assigned(AView) then exit;
  AMenuInfo := GetPopupMenuInfo(AMenu, AView);
  if AMenuInfo <> nil then
    AMenuInfo.HitTypes := AMenuInfo.HitTypes + AHitTypes
  else
    AddMenuInfo(AMenu, AHitTypes, ADoPopupProc, nil, AView);
end;

procedure TcxGridPopupMenu.RegisterPopupMenu(const AMenu: TComponent;
  AHitTypes: TcxGridViewHitTypes; ADoPopupProc: TcxGridOnPopupProc;
  AViewClass: TcxCustomGridViewClass);
begin
  FGridDefaultPopupMenu.RegisterPopupMenu(AMenu, AHitTypes, ADoPopupProc, AViewClass);
end;

procedure TcxGridPopupMenu.UnregisterPopupMenu(const AMenu: TComponent;
          const AGridView: TcxCustomGridView; AHitTypes: TcxGridViewHitTypes);
var
  AMenuInfo: TcxPopupMenuInfo;
begin
  AMenuInfo := GetPopupMenuInfo(AMenu, AGridView, false);
  If (AMenuInfo <> nil) then
    If AMenuInfo.HitTypes = AHitTypes then
      AMenuInfo.Free
    else
      AMenuInfo.HitTypes := AMenuInfo.HitTypes - AHitTypes;
end;

procedure TcxGridPopupMenu.UnregisterPopupMenu(const AMenu: TComponent;
  AGridViewClass: TcxCustomGridViewClass; AHitTypes: TcxGridViewHitTypes = []);
begin
  FGridDefaultPopupMenu.UnRegisterPopupMenu(AMenu, AGridViewClass, AHitTypes);
end;

function TcxGridPopupMenu.DoOnPopup(ASenderMenu: TComponent;
  AHitTest: TcxCustomGridHitTest; X,
  Y: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnPopup) then
    FOnPopup(ASenderMenu, AHitTest, X, Y, Result);
end;

type
  TcxCustomGridCellViewInfoAccess = class(TcxCustomGridCellViewInfo);

function TcxGridPopupMenu.DoPopup(AAPPSKeyPressed: Boolean): Boolean;

  function DoAutoPopup(AMenuInfo:TcxPopupMenuInfo; AHitTest: TcxCustomGridHitTest;
    APoint: TPoint): Boolean;
  var
    Intf: IUnknown;
    AProc: TcxGridOnPopupProc;
  begin
    Result := False;
    if Assigned(AMenuInfo.PopupMenu) then
    begin
      {$IFDEF DELPHI5}
      if Supports(TObject(AMenuInfo.PopupMenu), IDoPopup, Intf) then
      {$ELSE}
      if TObject(AMenuInfo.PopupMenu).GetInterface(IDoPopup, Intf) and
        (Intf <> nil) then
      {$ENDIF}
      begin
        if DoOnPopup(AMenuInfo.PopupMenu, AHitTest, APoint.X, APoint.Y) then
        begin
          AProc := IDoPopup(Intf).GetPopupHandler;
          AProc(AMenuInfo.PopupMenu, AHitTest, APoint.X, APoint.Y);
        end;
        Result := True;
      end
      else if (AMenuInfo.PopupMenu is TPopupMenu) or
        (AMenuInfo.PopupMenu.InheritsFrom(TPopupMenu)) then
        begin
          if DoOnPopup(AMenuInfo.PopupMenu, AHitTest, APoint.X, APoint.Y) then
            TPopupMenu(AMenuInfo.PopupMenu).Popup(APoint.X, APoint.Y);
          Result := True;
        end;
    end;
  end;

  function DoPopupLocal(AHitType: TcxGridViewHitType; APoint: TPoint;
    AHitTest: TcxCustomGridHitTest): Boolean;
  var
    J: Integer;
    AView: TcxCustomGridView;
  begin
    Result := False;
    AView := Grid.FocusedView.PatternGridView;
    if (AView = nil) then
     AView := Grid.FocusedView;
    for J := 0 to Count - 1 do
    begin
      if (AHitType in MenuInfos[J].HitTypes) and
      ((MenuInfos[J].GridView = AView) or (AHitType in [gvhtGridNone,gvhtGridTab]))
         then
        if Assigned(MenuInfos[J].OnPopup) then
        begin
          if (Assigned(MenuInfos[J].PopupMenu) or FAlwaysFireOnPopup) then
          begin
            if DoOnPopup(MenuInfos[J].PopupMenu, AHitTest, APoint.X, APoint.Y) then
              MenuInfos[J].OnPopup(
                MenuInfos[J].PopupMenu, AHitTest, APoint.X, APoint.Y);
            Result := True;
            Break;
          end;
        end
        else
          Result := DoAutoPopup(MenuInfos[J], AHitTest, APoint);
    end;
  end;

  function DoPopupDefault(AHitType: TcxGridViewHitType; APoint: TPoint;
    AHitTest: TcxCustomGridHitTest): Boolean;
  var
    I,J: Integer;
    AInfo: TcxPopupMenuInfoAccess;
    AView: TcxCustomGridView;
  begin
    Result := False;
    I := -1;
    AView := Grid.FocusedView;
    for J := 0 to FGridDefaultPopupMenu.Count - 1 do
    begin
      AInfo := TcxPopupMenuInfoAccess(FGridDefaultPopupMenu[J]);
      If (AHitType in AInfo.HitTypes) and Assigned(AInfo.OnPopup) and
       Assigned(AInfo.PopupMenu) then
      begin
        if ((AInfo.GridViewClass = TcxCustomGridViewClass(AView.ClassType)) or
          (AHitType in [gvhtGridNone,gvhtGridTab])) then 
        begin
          I := J;
          Break;
        end
        else if AView.InheritsFrom(AInfo.GridViewClass) and ((I = -1) or
          AInfo.GridViewClass.InheritsFrom(
            TcxPopupMenuInfoAccess(FGridDefaultPopupMenu[I]).GridViewClass)) then
            I := J;
      end;
    end;
    if I <> -1 then
    begin
      if DoOnPopup(FGridDefaultPopupMenu[I].PopupMenu, AHitTest, APoint.X, APoint.Y) and
        Assigned((FGridDefaultPopupMenu[I]).OnPopup) then
        (FGridDefaultPopupMenu[I]).OnPopup(
          FGridDefaultPopupMenu[I].PopupMenu, AHitTest, APoint.X, APoint.Y);
      Result := True;
    end;
  end;

  function DoPopupByAPPSKey(var AHitCode: Integer; var APoint: TPoint): Boolean;
  var
    AViewInfo: TcxCustomGridCellViewInfoAccess;
    ABounds: TRect;
  begin
    Result := FHitGridView is TcxCustomGridTableView;
    if not Result then Exit;
    with TcxCustomGridTableView(FHitGridView).Controller do
    begin
      if (FocusedRecord <> nil) then
      begin
        if not FocusedRecord.Visible then
          MakeFocusedRecordVisible;
        if (FocusedItem <> nil) and (FocusedItem.FocusedCellViewInfo <> nil) then
        begin
          ABounds := FocusedItem.FocusedCellViewInfo.ContentBounds;
          AViewInfo :=
            TcxCustomGridCellViewInfoAccess(FocusedItem.FocusedCellViewInfo);
        end
        else
        begin
          ABounds := FocusedRecord.ViewInfo.ContentBounds;
          if ABounds.Left < 0 then
             ABounds.Left := 0;
          AViewInfo :=
            TcxCustomGridCellViewInfoAccess(FocusedRecord.ViewInfo);
        end;
        with ABounds do
          APoint := Point(Left, Bottom);
        FHitTest := AViewInfo.GetHitTestClass.Instance(APoint);
        AViewInfo.InitHitTest(FHitTest);
      end
      else
      begin
        APoint := Point(0,0);
        FHitTest := TcxGridViewNoneHitTest.Instance(APoint);
        TcxCustomGridViewInfoAccess(FHitGridView.Site.ViewInfo).InitHitTest(FHitTest);
      end;
      AHitCode := FHitTest.HitTestCode;
      FHitPoint := APoint;
      APoint := FHitGridView.Site.ClientToScreen(APoint);
    end;
  end;

var
  AHitCode: Integer;
  APoint: TPoint;
begin
  Result := True;
  FHitGridView := Grid.FocusedView;
  AHitCode := 0;
  if AAPPSKeyPressed then
    Result := DoPopupByAPPSKey(AHitCode, APoint)
  else
  begin
    GetCursorPos(APoint);
    FHitPoint := Grid.ScreenToClient(APoint);
    FHitTest := Grid.ViewInfo.GetHitTest(FHitPoint.X, FHitPoint.Y);
    AHitCode := FHitTest.HitTestCode;
    if not PtInRect(FHitGridView.Site.ClientRect,
      FHitGridView.Site.ScreenToClient(APoint)) then
      AHitCode := AHitCode + cxhtGridBase;
  end;
  if Result then
  begin
    FHitType := GetHitTypeByHitCode(AHitCode);
    Result := DoPopupLocal(FHitType, APoint, FHitTest) or
      DoPopupDefault(FHitType, APoint, FHitTest);
  end;
end;

function TcxGridPopupMenu.GetPopupMenus: TcxPopupMenuInfos;
begin
  Result := PopupMenuInfos;
end;

procedure TcxGridPopupMenu.CreateBuiltInPopupMenus;
var
  I: Integer;
  AMenu: TComponent;
  APopupMenuClassInfoRec: PcxPopupMenuClassInfoRec;
  AInterface: IDoPopup;
begin
  for I := 0 to FBuiltInPopupMenuList.Count - 1 do
  begin
    APopupMenuClassInfoRec :=
      PcxPopupMenuClassInfoRec(FBuiltInPopupMenuList[i]);
    AMenu := APopupMenuClassInfoRec.FMenuClass.Create(Self);
    AMenu.GetInterface(IDoPopup, AInterface);
    FGridDefaultPopupMenu.RegisterPopupMenu(AMenu,
    APopupMenuClassInfoRec.FHitTypes, AInterface.GetPopupHandler,
    APopupMenuClassInfoRec.FViewClass);
  end;
end;

procedure TcxGridPopupMenu.FreeBuiltInPopupMenus;
var
  I: Integer;
  AMenuClass: TcxPopupMenuClass;
  AMenu: TComponent;
begin
  for I := 0 to FBuiltInPopupMenuList.Count - 1 do
  begin
    AMenuClass := PcxPopupMenuClassInfoRec(FBuiltInPopupMenuList[I]).FMenuClass;
    AMenu := GetBuiltInPopupMenuByClass(AMenuClass);
    FreeAndNil(AMenu);
  end;
end;

procedure TcxGridPopupMenu.SetUseBuiltInPopupMenus(const Value: Boolean);
begin
  if FUseBuiltInPopupMenus <> Value then
    if Value then
      CreateBuiltInPopupMenus
    else
      FreeBuiltInPopupMenus;
  FUseBuiltInPopupMenus := Value;
end;

procedure TcxGridPopupMenu.SetGrid(const AValue: TcxGrid);
begin
  if FGrid <> AValue then
  begin
    FGridOperationHelper.Grid := AValue;
    if (FGrid <> nil) and not (csDestroying in FGrid.ComponentState) then
    begin
      FGrid.UnregisterNotification(FMouseupNotification);
      {$IFDEF DELPHI5}
      FGrid.RemoveFreeNotification(self);
      {$ENDIF}
      ClearMenuInfosGridView;
    end;
    FGrid := AValue;
    if FGrid <> nil then
    begin
      FGrid.FreeNotification(self);
      FGrid.RegisterNotification(FMouseupNotification);
    end;
  end;
end;

procedure TcxGridPopupMenu.SetPopupMenus(const AValue: TcxPopupMenuInfos);
var
  I: Integer;
begin
  PopupMenus.Clear;
  for I := 0 to AValue.Count do
  with TcxPopupMenuInfoAccess(AValue[I]) do
    if GridView <> nil then
      RegisterPopupMenu(PopupMenu, HitTypes, OnPopup, GridView)
    else
      RegisterPopupMenu(PopupMenu, HitTypes, OnPopup, GridViewClass);
end;

end.
