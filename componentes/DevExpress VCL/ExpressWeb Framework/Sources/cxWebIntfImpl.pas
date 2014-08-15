{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Basic interface implementation by Developer Express         }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebIntfImpl;

interface

{$I cxVer.inc}

uses Classes, SysUtils, 
  {$IFDEF VCL}
  Windows,
  {$ELSE}
   Types,
  {$ENDIF}
  cxWebIntf;

type
  TcxCustomWebContainerControlHelper = class(TObject)
  private
    FOwner: TComponent;
    FTabOrders: TList;
    FControlContainers: IInterfaceList;
    FControls: IInterfaceList;
    FUpdateControlsPositionLock: Boolean;
    FControlLayout: TcxWebControlLayout;

    procedure InsertWebControl(AControl: IcxWebControl);
    procedure InsertContainerControl(AControl: IcxWebContainerControl);
    procedure RemoveWebControl(AControl: IcxWebControl);
    procedure RemoveContainerControl(AControl: IcxWebContainerControl);
    procedure ClearControls;
  protected
    {IcxWebContainerControl}
    function GetControl(Index: Integer): IcxWebControl;
    function GetControlContainer(Index: Integer): IcxWebContainerControl;
    function GetControlContainerCount: Integer;
    function GetControlCount: Integer;
    function GetParent: IcxWebContainerControl;

    function GetClientLeft: Integer; virtual;
    function GetClientTop: Integer; virtual;

    function CanAcceptsControls: Boolean; virtual;
    function ContainsControl(const AControl: IcxWebControl): Boolean;
    function IndexOf(const AControl: IcxWebControl): Integer;
    procedure InsertControl(const AControl: IInterface);
    procedure RemoveControl(const AControl: IInterface);

    function GetLineTabOrder(const AControl: IcxWebControl; var AFounded: Boolean): Integer;
    procedure GetTabOrderList(const AList: TList);
    procedure SetTabOrderList(const AList: TList);
    function TabOrderOf(const AControl: IcxWebControl): Integer;
    procedure UpdateTabOrder(ACurIndex, ANewIndex: TcxWebTabOrder);
    procedure UpdateControlsPosition;

    function GetControlLayout: TcxWebControlLayout;
    procedure SetControlLayout(Value: TcxWebControlLayout);

    function WebPageModule: IcxWebPageModule;

    property Owner: TComponent read FOwner;

  public
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure FixupTabList;

    property ControlContainerCount: Integer read GetControlContainerCount;
    property ControlContainers[Index: Integer]: IcxWebContainerControl read GetControlContainer;
    property ControlCount: Integer read GetControlCount;
    property Controls[Index: Integer]: IcxWebControl read GetControl;
    property Parent: IcxWebContainerControl read GetParent;
  end;

{ helpers }
function IsWebTabOrderable(const AControl: TObject): Boolean; overload;
function IsWebTabOrderable(const AControl: IInterface): Boolean; overload;

implementation

uses cxWebUtils, cxWebUpdateControlPosition, cxWebRender;

{ Helpers }
function IsWebTabOrderable(const AControl: TObject): Boolean;
begin
  Result := (AControl <> nil) and Supports(AControl, IcxWebTabOrderable)
    and Supports(AControl, IcxWebControl);
end;

function IsWebTabOrderable(const AControl: IInterface): Boolean;
begin
  Result := (AControl <> nil) and Supports(AControl, IcxWebTabOrderable)
    and Supports(AControl, IcxWebControl);
end;

{ TcxCustomWebContainerControlHelper }
constructor TcxCustomWebContainerControlHelper.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
  FTabOrders := TList.Create;
  FControlContainers :=  TInterfaceList.Create;
  FControls :=  TInterfaceList.Create;
  FUpdateControlsPositionLock := False;
  FControlLayout := wclInheritable;
end;

destructor TcxCustomWebContainerControlHelper.Destroy;
begin
  ClearControls;
  FTabOrders.Free;
  inherited Destroy;
end;


function TabOrderCompare(Item1, Item2: Pointer): Integer;
var
  ATabOrder1, ATabOrder2: IcxWebControl;
begin
  if Supports(TComponent(Item1), IcxWebControl, ATabOrder1) and
    Supports(TComponent(Item2), IcxWebControl, ATabOrder2) then
    Result := ATabOrder1.GetInternalTabOrder - ATabOrder2.GetInternalTabOrder
  else Result := 0;  
end;

procedure TcxCustomWebContainerControlHelper.FixupTabList;
begin
  FTabOrders.Sort(TabOrderCompare);
end;

procedure TcxCustomWebContainerControlHelper.InsertWebControl(AControl: IcxWebControl);
var
  AOwnerContainer: IcxWebContainerControl;
begin
  FControls.Add(AControl);
  if IsWebTabOrderable(AControl) then
    FTabOrders.Add(GetComponentByInterface(AControl));
  if Supports(FOwner, IcxWebContainerControl, AOwnerContainer) then
    AControl.InternalSetParent(AOwnerContainer);
end;

procedure TcxCustomWebContainerControlHelper.InsertContainerControl(AControl: IcxWebContainerControl);
begin
  FControlContainers.Add(AControl);
end;

procedure TcxCustomWebContainerControlHelper.RemoveWebControl(AControl: IcxWebControl);
begin
  AControl.InternalSetParent(nil);
  FControls.Remove(AControl);
  if IsWebTabOrderable(AControl) then
    FTabOrders.Remove(GetComponentByInterface(AControl));
end;

procedure TcxCustomWebContainerControlHelper.RemoveContainerControl(AControl: IcxWebContainerControl);
begin
  FControlContainers.Remove(AControl);
end;

procedure TcxCustomWebContainerControlHelper.ClearControls;
var
  AComponent: TComponent;
  AWebControl: IcxWebControl;
begin
  while ControlCount > 0 do
  begin
    AWebControl := Controls[0];
    AComponent := GetComponentByInterface(AWebControl);
    AWebControl := nil;
    AComponent.Free;
  end;
end;

function TcxCustomWebContainerControlHelper.GetControl(Index: Integer): IcxWebControl;
begin
  Result :=IcxWebControl(FControls[Index]);
end;

function TcxCustomWebContainerControlHelper.GetControlContainer(Index: Integer): IcxWebContainerControl;
begin
  Result := IcxWebContainerControl(FControls[Index]);
end;

function TcxCustomWebContainerControlHelper.GetControlContainerCount: Integer;
begin
  Result := FControlContainers.Count;
end;

function TcxCustomWebContainerControlHelper.GetControlCount: Integer;
begin
  if FControls <> nil then
    Result := FControls.Count
  else Result := 0;  
end;

function TcxCustomWebContainerControlHelper.GetParent: IcxWebContainerControl;
var
  AWebControl: IcxWebControl;
begin
  if Supports(FOwner, IcxWebControl, AWebControl) then
    Result := AWebControl.Parent
  else Result := nil;
end;         

function TcxCustomWebContainerControlHelper.GetClientLeft: Integer;
begin
  Result := 0;
end;

function TcxCustomWebContainerControlHelper.GetClientTop: Integer;
begin
  Result := 0;
end;

function TcxCustomWebContainerControlHelper.CanAcceptsControls: Boolean;
begin
  Result := True;
end;

function TcxCustomWebContainerControlHelper.ContainsControl(const AControl: IcxWebControl): Boolean;
var
  AContainer: IcxWebContainerControl;
begin
  AContainer := AControl.Parent;
  while AContainer <> nil do
  begin
    if Supports(AContainer, IcxWebPageModule, Result) then
      break;
    AContainer := AContainer.Parent;
  end;

  AContainer := AControl.Parent;
  while (AContainer <> nil) and (AContainer.IndexOf(AControl) = -1) do
    AContainer := AContainer.Parent;
  Result := AContainer <> nil;
end;

function TcxCustomWebContainerControlHelper.IndexOf(const AControl: IcxWebControl): Integer;
begin
  Result := FControls.IndexOf(AControl);
end;

procedure TcxCustomWebContainerControlHelper.InsertControl(const AControl: IInterface);
var
  AWebControl: IcxWebControl;
  AContainerControl: IcxWebContainerControl;
begin
  if Supports(AControl, IcxWebControl, AWebControl) and
    (IndexOf(AWebControl) = -1) then
    InsertWebControl(AWebControl);
  if Supports(AControl, IcxWebContainerControl, AContainerControl) and
    (FControlContainers.IndexOf(AContainerControl) = -1) then
    InsertContainerControl(AContainerControl);
end;

procedure TcxCustomWebContainerControlHelper.RemoveControl(const AControl: IInterface);
var
  AWebControl: IcxWebControl;
  AContainerControl: IcxWebContainerControl;
begin
  if Supports(AControl, IcxWebControl, AWebControl) and
    (IndexOf(AWebControl) > -1) then
    RemoveWebControl(AWebControl);
  if Supports(AControl, IcxWebContainerControl, AContainerControl) and
    (FControlContainers.IndexOf(AContainerControl) > -1) then
    RemoveContainerControl(AContainerControl);
end;

function TcxCustomWebContainerControlHelper.GetLineTabOrder(const AControl: IcxWebControl; var AFounded: Boolean): Integer;
var
  I: Integer;
  AParent: IcxWebContainerControl;
  ATabItem: IcxWebControl;
begin
  AFounded := False;
  Result := 0;
  for I := 0 to FTabOrders.Count - 1 do
  begin
    if not Supports(TComponent(FTabOrders.Items[I]), IcxWebControl, ATabItem) then continue;
    if Supports(ATabItem, IcxWebContainerControl, AParent) and (Pointer(AControl) <> Pointer(ATabItem)) then
    begin
      Result := Result + AParent.GetLineTabOrder(AControl, AFounded);
      if AFounded then
      begin
        Inc(Result);
        break;
      end;
    end
    else if Pointer(AControl) = Pointer(ATabItem) then
    begin
      AFounded := True;
      break;
    end;
    Inc(Result);
  end;
end;

procedure TcxCustomWebContainerControlHelper.GetTabOrderList(const AList: TList);
begin
  AList.Count := FTabOrders.Count;
  Move(FTabOrders.List^, AList.List^, SizeOf(Pointer) * FTabOrders.Count);
end;

procedure TcxCustomWebContainerControlHelper.SetTabOrderList(const AList: TList);
begin
  if AList = nil then
    Exit;
  FTabOrders.Count := AList.Count;
  Move(AList.List^, FTabOrders.List^, SizeOf(Pointer) * AList.Count);
end;

function TcxCustomWebContainerControlHelper.TabOrderOf(const AControl: IcxWebControl): Integer;
begin
  Result := FTabOrders.IndexOf(GetComponentByInterface(AControl));
end;

procedure TcxCustomWebContainerControlHelper.UpdateTabOrder(ACurIndex, ANewIndex: TcxWebTabOrder);
begin
  if ANewIndex < 0 then
    ANewIndex := 0;
  if ANewIndex > ControlCount - 1 then
    ANewIndex := ControlCount - 1;
  if ACurIndex <> ANewIndex then
    FTabOrders.Move(ACurIndex, ANewIndex);
end;

type
TcxWebUpdateControlPositionItem = class(TcxCustomWebUpdateControlPositionItem)
private
  FWebControl: IcxWebControl;
protected
  function GetBoundsRect: TRect; override;
  procedure SetBoundsRect(const Value: TRect); override;
public
  constructor Create(AWebControl: IcxWebControl);

  property WebControl: IcxWebControl read FWebControl;
end;

{ TcxWebUpdateControlPositionItem }

constructor TcxWebUpdateControlPositionItem.Create(AWebControl: IcxWebControl);
begin
  FWebControl := AWebControl;
end;

function TcxWebUpdateControlPositionItem.GetBoundsRect: TRect;
begin
  Result := WebControl.BoundsRect;
end;

procedure TcxWebUpdateControlPositionItem.SetBoundsRect(const Value: TRect);
begin
  WebControl.BoundsRect := Value;
end;

function TcxCustomWebContainerControlHelper.WebPageModule: IcxWebPageModule;
var
  AParent: IcxWebContainerControl;
begin
  Result := nil;
  if not Owner.GetInterface(IcxWebContainerControl, AParent) then exit;
  while (AParent <> nil)  and not Supports(AParent, IcxWebPageModule, Result) do
    AParent := AParent.Parent;
end;


procedure TcxCustomWebContainerControlHelper.UpdateControlsPosition;
var
  AList: TList;
  I: Integer;
  AWebPageModule: IcxWebPageModule;
begin
  AWebPageModule := WebPageModule;
  if (AWebPageModule = nil) or (AWebPageModule.GetPositioningType <> cxptGrid) then exit;
  AList := TList.Create;
  for I := 0 to ControlCount - 1 do
    AList.Add(TcxWebUpdateControlPositionItem.Create(Controls[I]));
  UpdateWebControlsPosition(AList);
  for I := 0 to ControlCount - 1 do
    TcxWebUpdateControlPositionItem(AList[I]).Free;
  AList.Free;
end;

function TcxCustomWebContainerControlHelper.GetControlLayout: TcxWebControlLayout;
var
  APageModule: IcxWebPageModule;
  AParent: IcxWebContainerControl;
begin
  if Supports(Owner, IcxWebPageModule, APageModule) then
    Result := TcxWebControlLayout(APageModule.GetPositioningType)
  else
  begin
    Result := FControlLayout;
    if (Result = wclInheritable) and
      Supports(Owner, IcxWebContainerControl, AParent) then
    begin
      AParent := AParent.Parent;
      while (AParent <> nil) do
      begin
        Result := AParent.ControlLayout;
        if (Result <> wclInheritable) then
          break
        else AParent := AParent.Parent;
      end;
    end;
  end;  
end;

procedure TcxCustomWebContainerControlHelper.SetControlLayout(Value: TcxWebControlLayout);
begin
  FControlLayout := Value;
end;

end.
