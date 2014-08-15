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

{$I cxGridUtils.inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Classes, cxGridCustomView, cxGridTableView, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxGridUIHelper;

{$R cxGridMenuOperations.res}

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
    FHandler: TNotifyEvent;
    FImageName: string;
    FIsSubMenu: Boolean;
    FMenuItem: TComponent;
    FParams: TList;
    FResCaption: Pointer;
    FTag: Integer;
    FVisibleState: TcxGridPopupMenuOperationState;
    function GetGridOperationHelper: TcxGridOperationHelper;
    function GetGridPopupMenu: TcxGridPopupMenu;
    function GetState(AState: TcxGridPopupMenuOperationState;
      AGetFunc: TcxGetStateFunc): boolean;
  protected
    procedure DoExecute (Sender: TObject);
    procedure SetProperties(const AMenuItem: TComponent; AHandler: TNotifyEvent ;
      ABeginGroup: Boolean = False;
        AIsSubMenu: Boolean = False);

    function GetCaption: string; virtual;

    function GetDown: Boolean; virtual;
    function GetCheckedState: Boolean; virtual;

    function GetEnabled: Boolean; virtual;
    function GetEnabledState: Boolean; virtual;

    function GetVisible: Boolean; virtual;
    function GetVisibleState: Boolean; virtual;

    property BeginGroup: Boolean read FBeginGroup;
    property Caption: string read GetCaption;
    property Down: Boolean read GetCheckedState;
    property Enabled: Boolean read GetEnabledState;
    property Visible: Boolean read GetVisibleState;
    property GridOperationHelper: TcxGridOperationHelper read GetGridOperationHelper;

    property Params: TList read FParams write FParams;
    property ResCaption: Pointer read FResCaption write FResCaption;
    property Tag: Integer read FTag write FTag;

    property ImageName: String read FImageName;

  public
    constructor Create(const AMenuItem: TComponent); virtual;
    class function GetPopupMenuClass: TcxPopupMenuClass; virtual;
    class function GetSubOperationClass: TcxGridPopupMenuOperationClass; virtual;
    property DownState: TcxGridPopupMenuOperationState read FDownState write FDownState default pmoDefault;
    property EnabledState: TcxGridPopupMenuOperationState read FEnabledState write FEnabledState default pmoDefault;
    property VisibleState: TcxGridPopupMenuOperationState read FVisibleState write FVisibleState default pmoDefault;
    property GridPopupMenu: TcxGridPopupMenu read GetGridPopupMenu;
    property Handler: TNotifyEvent read FHandler Write FHandler;
    property IsSubMenu: Boolean read FIsSubMenu;
    property MenuItem: TComponent read FMenuItem;
  end;

  TcxGridPopupMenuOperationsInfo = record
    OperationClass: TcxGridPopupMenuOperationClass;
    ImageIndex: Integer;
  end;

  PcxGridPopupMenuOperationsInfo = ^TcxGridPopupMenuOperationsInfo;

  TcxGridPopupMenuOperations = class
  private
    FOperationList: TList;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): PcxGridPopupMenuOperationsInfo;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure RegisterOperation(AOperationClass: TcxGridPopupMenuOperationClass;
      AResGlyphName: string);
    function IndexOf(AItem: TcxGridPopupMenuOperationClass): Integer;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: PcxGridPopupMenuOperationsInfo read GetItem; default;
  end;

  TcxGridTablePopupMenuOperation = class(TcxGridPopupMenuOperation)
  private
    function GetHitColumn: TcxGridColumn;
  public
    property HitColumn: TcxGridColumn read GetHitColumn;
  end;

function cxGridPopupMenuOperations: TcxGridPopupMenuOperations;
function cxGetGridPopupMenuOperation(AMenuItem: TComponent):
  TcxGridPopupMenuOperation;

implementation

uses
  SysUtils, Dialogs, Graphics, Controls, ImgList, cxClasses,
  cxGridPopupMenuConsts;

var
  FcxGridPopupMenuOperations: TcxGridPopupMenuOperations;

function cxGridPopupMenuOperations: TcxGridPopupMenuOperations;
begin
  if FcxGridPopupMenuOperations = nil then
    FcxGridPopupMenuOperations := TcxGridPopupMenuOperations.Create;
  Result := FcxGridPopupMenuOperations;
end;

{ TcxGridPopupMenuOperation }

constructor TcxGridPopupMenuOperation.Create(const AMenuItem: TComponent);
begin
  inherited Create;
  FDownState := pmoDefault;
  FEnabledState := pmoDefault;
  FVisibleState := pmoDefault;
  FResCaption := @cxSGridNone;
end;

procedure TcxGridPopupMenuOperation.DoExecute(Sender: TObject);
var
  AHandled: Boolean;
begin
  AHandled := True;
  FParams := TList.Create;
  try
    if Assigned(GridPopupMenu.OnMenuItemClick) then
      GridPopupMenu.OnMenuItemClick(Sender, GridPopupMenu.HitTest, FHandler,
        FParams, AHandled);
  finally
    if AHandled then FHandler(Sender); 
    FreeAndNil(FParams);
  end;
end;

procedure TcxGridPopupMenuOperation.SetProperties(const AMenuItem: TComponent;
  AHandler: TNotifyEvent ; ABeginGroup: Boolean = False; AIsSubMenu: Boolean = False);
begin
  FMenuItem := AMenuItem;
  FBeginGroup := ABeginGroup;
  FHandler := AHandler;
  FIsSubMenu := AIsSubMenu;
end;

class function TcxGridPopupMenuOperation.GetPopupMenuClass: TcxPopupMenuClass;
begin
  Result := TComponent;
end;

class function TcxGridPopupMenuOperation.GetSubOperationClass: TcxGridPopupMenuOperationClass;
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

type
  TcxGridPopupMenuAccess = class(TcxGridPopupMenu);

function TcxGridPopupMenuOperation.GetGridOperationHelper: TcxGridOperationHelper;
begin
  Result := TcxGridPopupMenuAccess(GridPopupMenu).GridOperationHelper;
end;

function TcxGridPopupMenuOperation.GetGridPopupMenu: TcxGridPopupMenu;
begin
  Result := TcxGridPopupMenu(MenuItem.Owner);
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

{ TcxGridPopupMenuOperations }

constructor TcxGridPopupMenuOperations.Create;
begin
  inherited Create;
  FOperationList := TList.Create;
end;

procedure TcxGridPopupMenuOperations.RegisterOperation(
  AOperationClass: TcxGridPopupMenuOperationClass; AResGlyphName: string);
var
  APoint: PcxGridPopupMenuOperationsInfo;
  Bmp: TBitmap;
begin
  New(APoint);
  with APoint^ do
  begin
    ImageIndex := -1;
    if AResGlyphName <> '' then
    begin
      Bmp := TBitmap.Create;
      try
        Bmp.LoadFromResourceName(HInstance, AResGlyphName);
        if cxGridPopupMenuImages = nil then
          cxGridPopupMenuImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
          cxGridPopupMenuImages.AddMasked(Bmp, clDefault);
        ImageIndex := cxGridPopupMenuImages.Count - 1;
      finally
        Bmp.Free;
      end;
    end;
    OperationClass := AOperationClass;
  end;
  FOperationList.Add(APoint);
end;

function TcxGridPopupMenuOperations.IndexOf(
  AItem: TcxGridPopupMenuOperationClass): Integer;
begin
  Result := FOperationList.IndexOf(AItem);
end;

function TcxGridPopupMenuOperations.GetCount: Integer;
begin
  Result := FOperationList.Count;
end;

function TcxGridPopupMenuOperations.GetItem(
  AIndex: Integer): PcxGridPopupMenuOperationsInfo;
begin
  Result := PcxGridPopupMenuOperationsInfo(FOperationList[AIndex]);
end;

destructor TcxGridPopupMenuOperations.Destroy;
var
  I: Integer;
begin
  for I := 0 to FOperationList.Count - 1 do
    Dispose(PcxGridPopupMenuOperationsInfo(FOperationList.Items[I]));
  FreeAndNil(FOperationList);
  inherited Destroy;
end;

{ TcxGridTablePopupMenuOperation }

function TcxGridTablePopupMenuOperation.GetHitColumn: TcxGridColumn;
begin
  Result := nil;
  if GridPopupMenu.HitTest is TcxCustomGridColumnHitTest then
    Result := TcxCustomGridColumnHitTest(GridPopupMenu.HitTest).Column;
end;

function cxGetGridPopupMenuOperation(AMenuItem: TComponent):
  TcxGridPopupMenuOperation;
begin
  Result := TcxGridPopupMenuOperation(AMenuItem.Tag);
end;

initialization

finalization
  FreeAndNil(FcxGridPopupMenuOperations);

end.
