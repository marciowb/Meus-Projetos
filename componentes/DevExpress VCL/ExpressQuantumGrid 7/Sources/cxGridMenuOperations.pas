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

unit cxGridMenuOperations;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Classes, ImgList, cxClasses, cxCustomData, cxGridCustomView, cxGridTableView,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxGridUIHelper;

type
  TcxGridPopupMenuOperation = class;

  TcxGridPopupMenuOperationClass = class of TcxGridPopupMenuOperation;

  TcxGridPopupMenuOperationState = (pmoDefault, pmoTrue, pmoFalse);

  TcxGetStateFunc = function : Boolean of object;

  TcxGridPopupMenuOperation = class
  private
    FBeginGroup: Boolean;
    FDownState: TcxGridPopupMenuOperationState;
    FEnabledState: TcxGridPopupMenuOperationState;
    FImageIndex: Integer;
    FParams: TList;
    FResCaption: TcxResourceStringID;
    FTag: Integer;
    FVisibleState: TcxGridPopupMenuOperationState;
    function GetGridOperationHelper: TcxGridOperationHelper;
    function GetGridPopupMenu: TcxGridPopupMenu;
    function GetHitGridView: TcxCustomGridView;
    function GetState(AState: TcxGridPopupMenuOperationState;
      AGetFunc: TcxGetStateFunc): boolean;
  protected
    procedure Execute(Sender: TObject); virtual;
    function GetInstance: Cardinal; virtual;
    function GetImageIndex: Integer; virtual;
    function GetImageResourceName: string; virtual;
    procedure UpdateImage;

    function GetCaption: string; virtual;

    function GetDown: Boolean; virtual;
    function GetCheckedState: Boolean; virtual;

    function GetEnabled: Boolean; virtual;
    function GetEnabledState: Boolean; virtual;

    function GetVisible: Boolean; virtual;
    function GetVisibleState: Boolean; virtual;

    property GridOperationHelper: TcxGridOperationHelper read GetGridOperationHelper;

    property Params: TList read FParams;
    property ResCaption: TcxResourceStringID read FResCaption write FResCaption;
    property Tag: Integer read FTag write FTag;
  public
    constructor Create; virtual;
    procedure DoExecute(Sender: TObject);
    class function GetParentOperationClass: TcxGridPopupMenuOperationClass; virtual;

    property BeginGroup: Boolean read FBeginGroup write FBeginGroup;
    property Caption: string read GetCaption;
    property Down: Boolean read GetCheckedState;
    property Enabled: Boolean read GetEnabledState;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property Visible: Boolean read GetVisibleState;

    property DownState: TcxGridPopupMenuOperationState read FDownState write FDownState default pmoDefault;
    property EnabledState: TcxGridPopupMenuOperationState read FEnabledState write FEnabledState default pmoDefault;
    property HitGridView: TcxCustomGridView read GetHitGridView;
    property GridPopupMenu: TcxGridPopupMenu read GetGridPopupMenu;
    property VisibleState: TcxGridPopupMenuOperationState read FVisibleState write FVisibleState default pmoDefault;
  end;

  TcxGridTablePopupMenuOperation = class(TcxGridPopupMenuOperation)
  private
    function GetHitGridView: TcxGridTableView;
  public
    property HitGridView: TcxGridTableView read GetHitGridView;
  end;

  TcxGridTableColumnMenuOperation = class(TcxGridTablePopupMenuOperation)
  private
    function GetHitColumn: TcxGridColumn;
  public
    property HitColumn: TcxGridColumn read GetHitColumn;
  end;

  TcxGridPopupMenuOperationsClass = class of TcxGridPopupMenuOperations;

  TcxGridPopupMenuOperations = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxGridPopupMenuOperation;
  protected
    function AddItem(AItemClass: TcxGridPopupMenuOperationClass): TcxGridPopupMenuOperation;
    procedure AddItems; virtual; abstract;
    procedure ClearItems;
    procedure RecreateItems;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function CanProcess(AHitTest: TcxCustomGridHitTest): Boolean; virtual;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxGridPopupMenuOperation read GetItem; default;
  end;

var
  cxGridPopupMenuImages: TCustomImageList;

function GetSummaryImageResourceName(ASummaryKind: TcxSummaryKind): string;

implementation

{$R cxGridMenuOperations.res}

uses
  SysUtils, Graphics, cxGridPopupMenuConsts;

type
  TcxGridPopupMenuAccess = class(TcxGridPopupMenu);

var
  FOperationImageResourceNames: TStringList;

function OperationImageResourceNames: TStringList;
begin
  if FOperationImageResourceNames = nil then
    FOperationImageResourceNames := TStringList.Create;
  Result := FOperationImageResourceNames;
end;

function GetSummaryImageResourceName(ASummaryKind: TcxSummaryKind): string;
begin
  if ASummaryKind = skNone then
    Result := ''
  else
    Result := 'FtrImg' + IntToStr(Ord(ASummaryKind));
end;

{ TcxGridPopupMenuOperation }

constructor TcxGridPopupMenuOperation.Create;
begin
  inherited;
  FDownState := pmoDefault;
  FEnabledState := pmoDefault;
  UpdateImage;
  FVisibleState := pmoDefault;
  FResCaption := @cxSGridNone;
end;

procedure TcxGridPopupMenuOperation.DoExecute(Sender: TObject);
var
  AHandled: Boolean;
  AHandler: TNotifyEvent;
begin
  AHandled := True;
  AHandler := Execute;
  FParams := TList.Create;
  try
    if Assigned(GridPopupMenu.OnMenuItemClick) then
      GridPopupMenu.OnMenuItemClick(Sender, GridPopupMenu.HitTest, AHandler,
        FParams, AHandled);
    if AHandled then AHandler(Sender);
  finally
    FreeAndNil(FParams);
  end;
end;

procedure TcxGridPopupMenuOperation.Execute(Sender: TObject);
begin
end;

function TcxGridPopupMenuOperation.GetInstance: Cardinal;
begin
  Result := HInstance;
end;

function TcxGridPopupMenuOperation.GetImageIndex: Integer;
var
  B: TBitmap;
begin
  Result := -1;
  if GetImageResourceName = '' then Exit;
  Result := OperationImageResourceNames.IndexOf(GetImageResourceName);
  if Result = -1 then
  begin
    B := TBitmap.Create;
    try
      B.LoadFromResourceName(GetInstance, GetImageResourceName);
      if cxGridPopupMenuImages = nil then
        cxGridPopupMenuImages := TCustomImageList.CreateSize(B.Width, B.Height);
      cxGridPopupMenuImages.AddMasked(B, clDefault);
    finally
      B.Free;
    end;
    Result := cxGridPopupMenuImages.Count - 1;

    while OperationImageResourceNames.Count < Result + 1 do
      OperationImageResourceNames.Add('');
    OperationImageResourceNames[Result] := GetImageResourceName;
  end;
end;

function TcxGridPopupMenuOperation.GetImageResourceName: string;
begin
  Result := '';
end;

procedure TcxGridPopupMenuOperation.UpdateImage;
begin
  FImageIndex := GetImageIndex;
end;

class function TcxGridPopupMenuOperation.GetParentOperationClass: TcxGridPopupMenuOperationClass;
begin
  Result := nil;
end;

function TcxGridPopupMenuOperation.GetDown: Boolean;
begin
  Result := False;
end;

function TcxGridPopupMenuOperation.GetCheckedState: Boolean;
begin
  Result := GetState(FDownState, GetDown);
end;

function TcxGridPopupMenuOperation.GetEnabled: Boolean;
begin
  Result := True;
end;

function TcxGridPopupMenuOperation.GetEnabledState: Boolean;
begin
  Result := GetState(FEnabledState, GetEnabled);
end;

function TcxGridPopupMenuOperation.GetVisible: Boolean;
begin
  Result := True;
end;

function TcxGridPopupMenuOperation.GetVisibleState: Boolean;
begin
  Result := GetState(FVisibleState, GetVisible);
end;

function TcxGridPopupMenuOperation.GetCaption: string;
begin
  Result := cxGetResourceString(FResCaption);
end;

function TcxGridPopupMenuOperation.GetGridOperationHelper: TcxGridOperationHelper;
begin
  Result := TcxGridPopupMenuAccess(GridPopupMenu).GridOperationHelper;
end;

function TcxGridPopupMenuOperation.GetGridPopupMenu: TcxGridPopupMenu;
begin
  Result := TcxGridPopupMenu(ActiveGridPopupMenu);
end;

function TcxGridPopupMenuOperation.GetHitGridView: TcxCustomGridView;
begin
  Result := GridPopupMenu.HitGridView;
end;

function TcxGridPopupMenuOperation.GetState(AState: TcxGridPopupMenuOperationState;
  AGetFunc: TcxGetStateFunc): boolean;
begin
  case AState of
    pmoTrue:
      Result := True;
    pmoFalse:
      Result := False;
    else
      Result := AGetFunc;
  end;
end;

{ TcxGridTablePopupMenuOperation }

function TcxGridTablePopupMenuOperation.GetHitGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited HitGridView);
end;

{ TcxGridTableColumnMenuOperation }

function TcxGridTableColumnMenuOperation.GetHitColumn: TcxGridColumn;
begin
  if GridPopupMenu.HitTest is TcxCustomGridColumnHitTest then
    Result := TcxCustomGridColumnHitTest(GridPopupMenu.HitTest).Column
  else
    Result := nil;
end;

{ TcxGridPopupMenuOperations }

constructor TcxGridPopupMenuOperations.Create;
begin
  inherited;
  FItems := TList.Create;
  AddItems;
end;

destructor TcxGridPopupMenuOperations.Destroy;
begin
  ClearItems;
  FItems.Free;
  inherited;
end;

function TcxGridPopupMenuOperations.GetItem(Index: Integer): TcxGridPopupMenuOperation;
begin
  Result := TcxGridPopupMenuOperation(FItems[Index]);
end;

function TcxGridPopupMenuOperations.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridPopupMenuOperations.AddItem(AItemClass: TcxGridPopupMenuOperationClass): TcxGridPopupMenuOperation;
begin
  Result := AItemClass.Create;
  FItems.Add(Result);
end;

procedure TcxGridPopupMenuOperations.ClearItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Clear;
end;

procedure TcxGridPopupMenuOperations.RecreateItems;
begin
  ClearItems;
  AddItems;
end;

function TcxGridPopupMenuOperations.CanProcess(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := True;
end;

initialization

finalization
  FreeAndNil(FOperationImageResourceNames);
  FreeAndNil(cxGridPopupMenuImages);

end.
