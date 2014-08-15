{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
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
unit cxWebCustomDesigner;

interface

{$I cxVer.inc}

uses SysUtils, Classes, DesignIntf, DesignEditors, DesignMenus, ToolsAPI,
  {$IFDEF VCL}
  Windows, Messages, ActiveX, Controls, Forms, VCLMenus, VCLEditors, OleCtrls,
  Menus, Graphics, ComObj, AxCtrls,
  {$ELSE}
  Qt, Types, QTypes, QControls, QForms, QMenus, QGraphics, CLXEditors,
  {$ENDIF}
  cxWebDsgnIntf, cxWebClasses, cxWebControls, cxWebDsgnTypes, cxWebIntf,
  cxWebRender;

type

TcxWebCustomDesigner = class;

TcxWebDebuggerNotifier = class(TNotifierObject, IOTANotifier, IOTADebuggerNotifier)
private
  FID: Integer;
  FDesigner: TcxWebCustomDesigner;

  procedure SaveHTMLText(AHTMLFileName, AText: string);
protected
  procedure AfterSave;
  procedure BeforeSave;
  procedure Destroyed;
  procedure Modified;
  procedure ProcessCreated({$IFDEF DELPHI9}const {$ENDIF}Process: IOTAProcess);
  procedure ProcessDestroyed({$IFDEF DELPHI9}const {$ENDIF}Process: IOTAProcess);
  procedure BreakpointAdded({$IFDEF DELPHI9}const {$ENDIF}Breakpoint: IOTABreakpoint);
  procedure BreakpointDeleted({$IFDEF DELPHI9}const {$ENDIF}Breakpoint: IOTABreakpoint);
public
  constructor Create(ADesigner: TcxWebCustomDesigner);
  destructor Destroy; override;
end;

TcxWebCustomDesigner = class(TcxAbstractWebDesigner)
private
  FForm: TCustomForm;
  FDelphiDesigner: IDesigner;
  FDebuggerNotifier: IOTADebuggerNotifier;
  FUpdateCount: Integer;
  FGridSizeX, FGridSizeY: Integer;
  FDisplayGrid: Boolean;
  FSnapToGrid: Boolean;
  FShowDesignerHints, FShowExtendedControlHints: Boolean;

  FClients: TList;

  FLocalPopup: TPopupMenu;


  function GetClientCount: Integer;
  function GetClient(Index: Integer): IcxDesignNotification;
  function ClientExists(const ADesignNotification: IcxDesignNotification): Boolean;

  function GetPositioningType: TcxWebPositioningType;

  procedure CheckCreateSizes(var AWidth, AHeight: Integer);
protected
  FCreateRect: TRect;

  function GetRoot: TComponent; override;
  function GetForm: TCustomForm; override;

  procedure AddNotifier(const ADesignNotification: IcxDesignNotification); override;
  procedure RemoveNotifier(const ADesignNotification: IcxDesignNotification); override;
  procedure GetIDEDesignerOptions(AChanged: Boolean); virtual;
  procedure IDEDesignerOptionsChagned; virtual;
protected
  function GetCurrComponentClass: TComponentClass;
  function CreateComponent(ALeft, ATop, AWidth, AHeight: Integer): TComponent;
  function CreateControlList: IInterfaceList;
  procedure UpdateControlsPosition;

  procedure BeginUpdate;
  procedure CancelUpdate;
  procedure EndUpdate;

  procedure DoSelectAll;

  procedure ReaderSetName(AReader: TReader; AComponent: TComponent; var AName: string); virtual;
  procedure ReaderFindMethod(Reader: TReader; const MethodName: string;
          var Address: Pointer; var Error: Boolean); virtual;

  { local menus event handlers }
  function ShowDesignDialog(ADesignDialog: TcxDesignDialog): Boolean;


  procedure AlignCommand(Sender: TObject);
  procedure AlignToGridCommand(Sender: TObject);
  procedure CopyCommand(Sender: TObject);
  procedure CutCommand(Sender: TObject);
  procedure DeleteCommand(Sender: TObject);
  procedure EnvironmentOptionsCommand(Sender: TObject);
  procedure PasteCommand(Sender: TObject);
  procedure ScaleCommand(Sender: TObject);
  procedure SelectAllCommand(Sender: TObject);
  procedure SizeCommand(Sender: TObject);
  procedure TabOrderCommand(Sender: TObject);
  procedure UndoCommand(Sender: TObject);
  { local menus building/showing/actions }
  function CreateMenuItem(AParent: TMenuItem; const ACaption: string;
    AShortCut: TShortCut; AChecked, AEnabled: Boolean; AImageIndex: Integer;
    AHelpContext: THelpContext; const AOnClick: TNotifyEvent): TMenuItem;
  function CreateMenuLine(AParent: TMenuItem): TMenuItem;
  procedure BuildComponentMenu; virtual;
  procedure BuildModuleMenu; virtual;
  procedure BuildStandardMenu(const AOnlyEditItems: Boolean);
  procedure ComponentClickItem(Sender: TObject);
  function CreateComponentEditor: IComponentEditor;
  procedure SelectRoot;
  function ShowAlignSelectionDlg: Boolean;
  function ShowScaleSelectionDlg: Boolean;
  function ShowSizeSelectionDlg: Boolean;

  function ShowTabOrderSelectionDlg: Boolean; virtual;
  procedure AlignSelection(AHorzAlign: TcxHorzAlign; AVertAlign: TcxVertAlign); virtual;
  procedure ScaleSelection(AScaleFactor: Integer); virtual;
  procedure SizeSelection(AHorzAffect: TcxSizeAffect; AVertAffect: TcxSizeAffect;
      AHorzAbsolute: Integer; AVertAbsolute: Integer); virtual;

  function GetHTMLTemplateModified(var AFileName, AText: string): Boolean; virtual;

  function GetShowingType: TcxWebDesignerShowingType;
  procedure ShowDesignerPage;

  property Form: TCustomForm read FForm;
  property DelphiDesigner: IDesigner read FDelphiDesigner;
  property ClientCount: Integer read GetClientCount;
  property Clients[Index: Integer]: IcxDesignNotification read GetClient;
  property UpdateCount: Integer read FUpdateCount;

public
  constructor Create(AForm: TCustomForm; ADelphiDesigner: IDesigner); override;
  destructor Destroy; override;

  function BuildLocalMenu(const ABaseMenu: TPopupMenu; const AFilter: TcxLocalMenuFilters): TPopupMenu; override;
  procedure InvokeLocalMenuAt(const ABaseMenu: TPopupMenu; const AFilter: TcxLocalMenuFilters; const Pt: TPoint); override;
  procedure InvokeLocalMenuAtCursor(const ABaseMenu: TPopupMenu; const AFilter: TcxLocalMenuFilters); override;

  procedure Modified; override;

  function CanDelete: Boolean; override;
  
  procedure BeforeDestruction; override;
  procedure DesignerActivated; override;
  procedure DesignerDeactivated; override;
  procedure PreviewShowing; override;
  procedure DesignerIdChanging; override;
  procedure DesignerPositioningTypeChanged; override;
  procedure RefreshDesignControls; override;
  procedure SelectComponent(const AnItem: TPersistent); override;
  procedure SetSelections(const AList: TList); override;
  function IsSupportPositioningTypeChanged(APositioningType: TcxWebPositioningType): Boolean; override;
  function GetControlPositioningType: TcxWebPositioningType; override;

  property DisplayGrid: Boolean read FDisplayGrid;
  property GridSizeX: Integer read FGridSizeX;
  property GridSizeY: Integer read FGridSizeY;
  property ShowDesignerHints: Boolean read FShowDesignerHints;
  property ShowExtendedControlHints: Boolean read FShowExtendedControlHints;
  property SnapToGrid: Boolean read FSnapToGrid;
  property PositioningType: TcxWebPositioningType read GetPositioningType;
end;

implementation

uses ComponentDesigner, IniFiles,
  {$IFDEF DELPHI9}
    PaletteAPI,
  {$ENDIF}
  {$IFDEF VCL}
  ImgList,
  {$ELSE}
  Libc, QImgList,
  {$ENDIF}
  cxWebDsgnConsts, cxWebDsgnStrs, cxWebDsgnUtils, cxfmAlign,
  cxfmScale, cxWebStrs, cxfmSize, cxWebDsgnEnvOpt;

{ TcxWebDebuggerNotifier }
constructor TcxWebDebuggerNotifier.Create(ADesigner: TcxWebCustomDesigner);
begin
  FDesigner := ADesigner;
  FID := (BorlandIDEServices as IOTADebuggerServices).AddNotifier(self);
end;

destructor TcxWebDebuggerNotifier.Destroy;
begin
  (BorlandIDEServices as IOTADebuggerServices).RemoveNotifier(FID);
  inherited Destroy;
end;

procedure TcxWebDebuggerNotifier.SaveHTMLText(AHTMLFileName, AText: string);

  function GetTempDir: string;
  begin
    {$IFDEF MSWINDOWS}
    SetLength(Result, 255);
    SetLength(Result, GetTempPath(255, PChar(Result)));
    {$ENDIF}
    {$IFDEF LINUX}
    Result := '/tmp';
    {$ENDIF}
    if (Result <> '') and (Result[Length(Result)] <> PathDelim) then
      Result := Result + PathDelim;
  end;

var
  AFileName: string;
  AFileStream: TFileStream;
  AWriter: TWriter;
begin
  AFileName := GetTempDir + scxDebugHTMLFileName;
  AFileStream := TFileStream.Create(AFileName, fmCreate);
  AFileStream.Position := AFileStream.Size;
  AWriter := TWriter.Create(AFileStream, 1024);
  try
    AWriter.WriteString(AHTMLFileName);
    AWriter.WriteString(AText);
  finally
    AWriter.Free;
    AFileStream.Free;
  end;
end;

procedure TcxWebDebuggerNotifier.AfterSave;
begin
end;

procedure TcxWebDebuggerNotifier.BeforeSave;
begin
end;

procedure TcxWebDebuggerNotifier.Destroyed;
begin
end;

procedure TcxWebDebuggerNotifier.Modified;
begin
end;

procedure TcxWebDebuggerNotifier.ProcessCreated({$IFDEF DELPHI9}const {$ENDIF}Process: IOTAProcess);
var
  AFileName, AText: string;
begin
  if FDesigner.GetHTMLTemplateModified(AFileName, AText) then
     SaveHTMLText(AFileName, AText)
  else
end;

procedure TcxWebDebuggerNotifier.ProcessDestroyed({$IFDEF DELPHI9}const {$ENDIF}Process: IOTAProcess);
begin
end;

procedure TcxWebDebuggerNotifier.BreakpointAdded({$IFDEF DELPHI9}const {$ENDIF}Breakpoint: IOTABreakpoint);
begin
end;

procedure TcxWebDebuggerNotifier.BreakpointDeleted({$IFDEF DELPHI9}const {$ENDIF}Breakpoint: IOTABreakpoint);
begin
end;

var
  FLocalPopupImages: TCustomImageList;

{ TcxWebCustomDesigner }

constructor TcxWebCustomDesigner.Create(AForm: TCustomForm; ADelphiDesigner: IDesigner);
begin
  _AddRef;
  FForm := AForm;
  FDelphiDesigner := ADelphiDesigner;
  GetIDEDesignerOptions(False);
  FClients := TList.Create;
  FCreateRect := Rect(-1, -1, -1, -1);
  FDebuggerNotifier := TcxWebDebuggerNotifier.Create(self);
end;

destructor TcxWebCustomDesigner.Destroy;
begin
  FDebuggerNotifier._Release;
  FDebuggerNotifier := nil;
  FClients.Free;
  FLocalPopup.Free;
  inherited Destroy;
end;

procedure TcxWebCustomDesigner.BeforeDestruction;
begin
  FRefCount := 0;
  inherited BeforeDestruction;
end;

procedure TcxWebCustomDesigner.DesignerActivated;
begin
  GetIDEDesignerOptions(True);
end;

procedure TcxWebCustomDesigner.DesignerDeactivated;
begin
end;

procedure TcxWebCustomDesigner.PreviewShowing;
begin
end;

procedure TcxWebCustomDesigner.DesignerIdChanging;
begin
end;

procedure TcxWebCustomDesigner.DesignerPositioningTypeChanged;
begin
end;

function TcxWebCustomDesigner.GetRoot: TComponent;
begin
  Result := DelphiDesigner.GetRoot
end;

function TcxWebCustomDesigner.BuildLocalMenu(const ABaseMenu: TPopupMenu;
  const AFilter: TcxLocalMenuFilters): TPopupMenu;
var
  Owner: TComponent;
begin
  if ABaseMenu <> nil then
  begin
    Owner := ABaseMenu.Owner;
    if Owner <> nil then
      Owner.RemoveComponent(ABaseMenu);
  end;

  if FLocalPopup <> nil then
    FLocalPopup.Free;
  FLocalPopup := ABaseMenu;
  if FLocalPopup = nil then
    FLocalPopup := TPopupMenu.Create(nil)
  else
  {$IFDEF VCL}
    FLocalPopup.Items.NewBottomLine;
  {$ELSE}
    if FLocalPopup.Items.Count > 0 then
      FLocalPopup.Items.InsertNewLineAfter(FLocalPopup.Items[FLocalPopup.Items.Count - 1]);
  {$ENDIF}
  FLocalPopup.Images := FLocalPopupImages;
  if not (cxlmComponent in AFilter) then
    BuildComponentMenu;
  if not (cxlmModule in AFilter) then
    BuildModuleMenu;
  BuildStandardMenu(cxlmDesigner in AFilter);
  Result := FLocalPopup;
end;

procedure TcxWebCustomDesigner.InvokeLocalMenuAt(const ABaseMenu: TPopupMenu;
  const AFilter: TcxLocalMenuFilters; const Pt: TPoint);
var
  PopupMenu: TPopupMenu;
begin
  PopupMenu := BuildLocalMenu(ABaseMenu, AFilter);
  if PopupMenu <> nil then
    PopupMenu.Popup(Pt.X, Pt.Y);
end;

procedure TcxWebCustomDesigner.InvokeLocalMenuAtCursor(const ABaseMenu: TPopupMenu;
  const AFilter: TcxLocalMenuFilters);
begin
  InvokeLocalMenuAt(ABaseMenu, AFilter, Mouse.CursorPos);
end;

function TcxWebCustomDesigner.GetForm: TCustomForm;
begin
  Result := FForm;
end;

procedure TcxWebCustomDesigner.RefreshDesignControls;
var
  AList: IInterfaceList;
  I: Integer;
begin
  AList := CreateControlList;
  for I := 0 to AList.Count - 1 do
    if IcxWebControl(AList[I]).DesignerControl <> nil then
      IcxWebControl(AList[I]).DesignerControl.UpdateContext;
  SelectComponent(Root);
end;


procedure TcxWebCustomDesigner.SelectComponent(const AnItem: TPersistent);
begin
  DelphiDesigner.SelectComponent(AnItem);
end;

procedure TcxWebCustomDesigner.SetSelections(const AList: TList);
var
  DesignerSelections: IDesignerSelections;
begin
  DesignerSelections := ListToDesignerSelections(AList);
  DelphiDesigner.SetSelections(DesignerSelections);
end;

function TcxWebCustomDesigner.IsSupportPositioningTypeChanged(APositioningType: TcxWebPositioningType): Boolean;
begin
  Result := True;
end;

function TcxWebCustomDesigner.GetControlPositioningType: TcxWebPositioningType;
var
  AWebModule: IcxWebPageModule;
begin
  if Supports(Root, IcxWebPageModule, AWebModule) then
    Result := AWebModule.GetPositioningType
  else Result := cxptGrid;  
end;


function TcxWebCustomDesigner.GetCurrComponentClass: TComponentClass;
var
  PaletteItem: {$IFDEF DELPHI9}IInternalPaletteItem{$ELSE}IPaletteItem {$ENDIF};
  ComponentPaletteItem: {$IFDEF DELPHI9}IOTAComponentPaletteItem{$ELSE}IComponentPaletteItem{$ENDIF};
begin
  Result := nil;
  if ActiveDesigner.Environment <> nil then
  begin
    PaletteItem := ActiveDesigner.Environment.GetCurCompClass;
    if PaletteItem <> nil then
    begin
    {$IFNDEF DELPHI9}
      PaletteItem.QueryInterface(IComponentPaletteItem, ComponentPaletteItem);
      if ComponentPaletteItem <> nil then
        Result := ComponentPaletteItem.GetComponentClass;
    {$ELSE}
      PaletteItem.QueryInterface(IOTAComponentPaletteItem, ComponentPaletteItem);
      if ComponentPaletteItem <> nil then
        Result := ActiveDesigner.Environment.GetComponentClass(ComponentPaletteItem.ClassName);
    {$ENDIF}
    end;
  end;
end;

function TcxWebCustomDesigner.CreateComponent(ALeft, ATop, AWidth, AHeight: Integer): TComponent;
begin
  Result := nil;
  if (ActiveDesigner.Environment <> nil) and ActiveDesigner.Environment.GetToolSelected then
  try
    CheckCreateSizes(AWidth, AHeight);
    FCreateRect := Bounds(ALeft, ATop, AWidth, AHeight);
    if (AWidth <> 0) and (AHeight <> 0) then
      Result := DelphiDesigner.CreateComponent(GetCurrComponentClass, nil, ALeft, ATop, AWidth, AHeight)
    else
    begin
      Result := GetCurrComponentClass.Create(Root);
      Result.Name := DelphiDesigner.UniqueName(DropT(Result.ClassName));
    end;  
  finally
    if ActiveDesigner.Environment <> nil then
      ActiveDesigner.Environment.ResetCompClass;
  end;
end;

function TcxWebCustomDesigner.CreateControlList: IInterfaceList;

  procedure AddControlsToList(var AContainer: IcxWebContainerControl);
  var
    i: Integer;
    AChildContainer: IcxWebContainerControl;
  begin
    for i := 0 to AContainer.ControlCount - 1 do
    begin
      Result.Add(AContainer.Controls[i]);
      if Supports(AContainer.Controls[i], IcxWebContainerControl, AChildContainer) then
        AddControlsToList(AChildContainer);
    end;
  end;

var
  AContainer: IcxWebContainerControl;
begin
  Result := TInterfaceList.Create;
  if Supports(Root, IcxWebContainerControl, AContainer) then
    AddControlsToList(AContainer);
end;

procedure TcxWebCustomDesigner.UpdateControlsPosition;
var
  AList: IInterfaceList;
  I: Integer;
begin
  AList := CreateControlList;
  for I := 0 to AList.Count - 1 do
    IcxWebControl(AList[I]).UpdateControlPosition;
end;

procedure TcxWebCustomDesigner.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxWebCustomDesigner.CancelUpdate;
begin
  if FUpdateCount <> 0 then Dec(FUpdateCount);
end;

procedure TcxWebCustomDesigner.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then Modified;
  end;
end;

procedure TcxWebCustomDesigner.Modified;
var
  I: Integer;
  AList: IDesignerSelections;
  AWebControl: IcxWebControl;
begin
  if UpdateCount = 0 then
  begin
    AList := TDesignerSelections.Create;
    DelphiDesigner.GetSelections(AList);
    for I := 0 to AList.Count - 1 do
      if Supports(AList[I], IcxWebControl, AWebControl) and
        (AWebControl.DesignerControl <> nil) then
        AWebControl.DesignerControl.UpdateContext;
    for I := 0 to ClientCount - 1 do
      Clients[I].ItemsModified;
  end;
end;

procedure TcxWebCustomDesigner.DoSelectAll;
var
  List: TList;
  I: Integer;
begin
  List := TList.Create;
  try
    for I := 0 to Root.ComponentCount - 1 do
      List.Add(Root.Components[I]);
    SetSelections(List);
  finally
    List.Free;
  end;
end;

procedure TcxWebCustomDesigner.ReaderSetName(AReader: TReader; AComponent: TComponent;
  var AName: string);
begin
  if (AReader.Root = Root) and (Root.FindComponent(AName) <> nil) then
  begin
    if (AName = '') or (Root.FindComponent(AName) <> nil) then
      AName := DelphiDesigner.UniqueName(DropT(AComponent.ClassName));
  end;  
end;

procedure TcxWebCustomDesigner.ReaderFindMethod(Reader: TReader; const MethodName: string;
        var Address: Pointer; var Error: Boolean);
begin
  if Root.MethodAddress(MethodName) = nil then
     Address := nil;
  Error := False;
end;

procedure TcxWebCustomDesigner.CheckCreateSizes(var AWidth, AHeight: Integer);
begin
  if (AWidth < cxNewComponentMinSize) and (AHeight < cxNewComponentMinSize) then
  begin
    AWidth := 0;
    AHeight := 0;
  end;
end;

procedure TcxWebCustomDesigner.AddNotifier(const ADesignNotification: IcxDesignNotification);
begin
  if not ClientExists(ADesignNotification) then
    FClients.Add(Pointer(ADesignNotification));
end;

procedure TcxWebCustomDesigner.RemoveNotifier(const ADesignNotification: IcxDesignNotification);
begin
  if ClientExists(ADesignNotification) then
    FClients.Remove(Pointer(ADesignNotification));
end;

{$IFDEF DELPHI6}
const
  DelphiVersion = 'Delphi\6.0';
{$ELSE}
const
  DelphiVersion = 'Delphi\6.0'; //TODO
{$ENDIF}


procedure TcxWebCustomDesigner.GetIDEDesignerOptions(AChanged: Boolean);
var
  AGridSizeX, AGridSizeY: Integer;
  ADisplayGrid, ASnapToGrid: Boolean;
  AShowDesignerHints, AShowExtendedControlHints: Boolean;
begin
  AGridSizeX := TcxWebDesignerEnvironmentOptions.GetGridSizeX(DelphiDesigner);
  AGridSizeY := TcxWebDesignerEnvironmentOptions.GetGridSizeY(DelphiDesigner);
  ASnapToGrid := TcxWebDesignerEnvironmentOptions.GetSnapControlsToGrid(DelphiDesigner);
  ADisplayGrid := TcxWebDesignerEnvironmentOptions.GetShowGrid(DelphiDesigner);
  AShowDesignerHints := TcxWebDesignerEnvironmentOptions.GetShowHints(DelphiDesigner);
  AShowExtendedControlHints := TcxWebDesignerEnvironmentOptions.GetShowExtendedHints(DelphiDesigner);

  AChanged := AChanged and ((FGridSizeX <> AGridSizeX) or (FGridSizeY <> AGridSizeY) or
                (FDisplayGrid <> ADisplayGrid) or (FSnapToGrid <> ASnapToGrid) or
                (FShowDesignerHints <> AShowDesignerHints) or
                (FShowExtendedControlHints <> AShowExtendedControlHints));
  FGridSizeX := AGridSizeX;
  FGridSizeY := AGridSizeY;
  FSnapToGrid := ASnapToGrid;
  FDisplayGrid := ADisplayGrid;
  FShowDesignerHints := AShowDesignerHints;
  FShowExtendedControlHints := AShowExtendedControlHints;
  if AChanged then
    IDEDesignerOptionsChagned;
end;

procedure TcxWebCustomDesigner.IDEDesignerOptionsChagned;
begin
end;


function TcxWebCustomDesigner.GetClientCount: Integer;
begin
  Result := FClients.Count;
end;

function TcxWebCustomDesigner.GetClient(Index: Integer): IcxDesignNotification;
begin
  Result := IcxDesignNotification(FClients[Index]);
end;

function TcxWebCustomDesigner.ClientExists(const ADesignNotification: IcxDesignNotification): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to ClientCount - 1 do
    if Clients[I] = ADesignNotification then
      Exit;
  Result := False;
end;

function TcxWebCustomDesigner.GetPositioningType: TcxWebPositioningType;
var
  AWebModule: IcxWebPageModule;
begin
  if Supports(Root, IcxWebPageModule, AWebModule) then
    Result := AWebModule.GetPositioningType
  else Result := cxptAbsolute;
end;

function TcxWebCustomDesigner.ShowDesignDialog(ADesignDialog: TcxDesignDialog): Boolean;
begin
  case ADesignDialog of
    cxWebDsgnTypes.ddAlign:
      Result := ShowAlignSelectionDlg;
    cxWebDsgnTypes.ddSize:
      Result := ShowSizeSelectionDlg;
    cxWebDsgnTypes.ddScale:
      Result := ShowScaleSelectionDlg;
    cxWebDsgnTypes.ddTabOrder:
      Result := ShowTabOrderSelectionDlg;
    else Result := False;
  end;
  if ActiveDesigner.Environment <> nil then
    ActiveDesigner.ModalEditDone(Form  as IActivatable);
end;

function TcxWebCustomDesigner.CanDelete: Boolean;
var
  AList: IDesignerSelections;
  I: Integer;
begin
  AList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(AList);
  Result := AList.Count > 0;
  if Result then
    for I := 0 to AList.Count - 1 do
      if not (AList.Items[I] is TComponent) then
      begin
        Result := False;
        break;
      end;
end;



procedure TcxWebCustomDesigner.AlignCommand(Sender: TObject);
begin
  ShowDesignDialog(cxWebDsgnTypes.ddAlign);
end;

procedure TcxWebCustomDesigner.AlignToGridCommand(Sender: TObject);
begin
  AlignToGrid;
end;

procedure TcxWebCustomDesigner.CopyCommand(Sender: TObject);
begin
  CopySelection;
end;

procedure TcxWebCustomDesigner.CutCommand(Sender: TObject);
begin
  CutSelection;
end;

procedure TcxWebCustomDesigner.DeleteCommand(Sender: TObject);
begin
  DeleteSelection;
end;

procedure TcxWebCustomDesigner.EnvironmentOptionsCommand(Sender: TObject);
begin
  ShowDesignDialog(ddEnvironmentOptions);
end;

procedure TcxWebCustomDesigner.PasteCommand(Sender: TObject);
begin
  PasteSelection;
end;

procedure TcxWebCustomDesigner.ScaleCommand(Sender: TObject);
begin
  ShowDesignDialog(cxWebDsgnTypes.ddScale);
end;

procedure TcxWebCustomDesigner.SelectAllCommand(Sender: TObject);
begin
  SelectAll;
end;

procedure TcxWebCustomDesigner.SizeCommand(Sender: TObject);
begin
  ShowDesignDialog(cxWebDsgnTypes.ddSize);
end;

procedure TcxWebCustomDesigner.TabOrderCommand(Sender: TObject);
begin
  ShowDesignDialog(cxWebDsgnTypes.ddTabOrder);
end;

procedure TcxWebCustomDesigner.UndoCommand(Sender: TObject);
begin
  Undo;
end;

function TcxWebCustomDesigner.CreateMenuItem(AParent: TMenuItem; const ACaption: string;
  AShortCut: TShortCut; AChecked, AEnabled: Boolean; AImageIndex: Integer;
  AHelpContext: THelpContext; const AOnClick: TNotifyEvent): TMenuItem;
begin
  Result := TMenuItem.Create(FLocalPopup);
  with Result do
  begin
    Caption := ACaption;
    Checked := AChecked;
    Enabled := AEnabled;
    ImageIndex := AImageIndex;
    ShortCut := AShortCut;
    HelpContext := AHelpContext;
    OnClick := AOnClick;
  end;
  if AParent <> nil then AParent.Add(Result);
end;

function TcxWebCustomDesigner.CreateMenuLine(AParent: TMenuItem): TMenuItem;
begin
  Result := CreateMenuItem(AParent, '-', 0, False, True, -1, 0, nil);
end;

procedure TcxWebCustomDesigner.BuildComponentMenu;
var
  ComponentEditor: IComponentEditor;
  I: Integer;
  MenuItem: TMenuItem;
  MenuItemIntf: IMenuItem;
begin
  ComponentEditor := CreateComponentEditor;
  if (ComponentEditor <> nil) and (ComponentEditor.GetVerbCount > 0) then
  begin
    CreateMenuLine(FLocalPopup.Items);
    for I := 0 to ComponentEditor.GetVerbCount - 1 do
    begin
      MenuItem :=
        CreateMenuItem(FLocalPopup.Items, ComponentEditor.GetVerb(I), 0, False, True, -1, 0, ComponentClickItem);
      {$IFDEF VCL}
      MenuItemIntf := IMenuItemFor(MenuItem);
      ComponentEditor.PrepareItem(I, MenuItemIntf);
      {$ELSE}
      if Supports(MenuItem, IMenuItem, MenuItemIntf) then
        ComponentEditor.PrepareItem(I, MenuItemIntf);
      {$ENDIF}
      MenuItem.Tag := I;
    end;
  end;
end;

procedure TcxWebCustomDesigner.BuildModuleMenu;
begin
end;


procedure TcxWebCustomDesigner.BuildStandardMenu(const AOnlyEditItems: Boolean);
var
  MenuItem: TMenuItem;
begin
  MenuItem := CreateMenuItem(FLocalPopup.Items, scxEdit, 0, False, True, -1,
    hccxEditCommand, nil);
  CreateMenuItem(MenuItem, scxUndo, ShortCut(Ord('Z'), [ssCtrl]), False,
    CanUndo, 7, hccxUndoCommand, UndoCommand);
  CreateMenuLine(MenuItem);
  CreateMenuItem(MenuItem, scxCut, ShortCut(Ord('X'), [ssCtrl]), False,
    CanCut, 9, hccxCutCommand, CutCommand);
  CreateMenuItem(MenuItem, scxCopy, ShortCut(Ord('C'), [ssCtrl]), False,
    CanCopy, 10, hccxCopyCommand, CopyCommand);
  CreateMenuItem(MenuItem, scxPaste, ShortCut(Ord('V'), [ssCtrl]), False,
    CanPaste, 11, hccxPasteCommand, PasteCommand);
  CreateMenuItem(MenuItem, scxDelete,
    ShortCut({$IFDEF VCL}VK_DELETE{$ELSE}KEY_DELETE{$ENDIF}, [ssShift]), False,
    CanDelete, 12, hccxDeleteCommand, DeleteCommand);
  CreateMenuLine(MenuItem);
  CreateMenuItem(MenuItem, scxSelectAll, ShortCut(Ord('A'), [ssCtrl]), False,
    CanSelectAll, -1, hccxSelectAllCommand, SelectAllCommand);

  if not AOnlyEditItems then
  begin
    CreateMenuLine(FLocalPopup.Items);
    MenuItem := CreateMenuItem(FLocalPopup.Items, scxPosition, 0, False, True, -1, 0, nil);
    CreateMenuItem(MenuItem, scxAlignToGrid, 0, False,
      CanAlignToGrid, -1, hccxAlignToGrid, AlignToGridCommand);
    CreateMenuItem(MenuItem, scxAlign, 0, False, CanAlign, 0, hccxfmAlign, AlignCommand);
    CreateMenuItem(MenuItem, scxSize, 0, False, True, 1, hccxfmSize, SizeCommand);
    CreateMenuItem(MenuItem, scxScale, 0, False, True, 2, hccxfmScale, ScaleCommand);
    CreateMenuItem(FLocalPopup.Items, scxTabOrder, 0, False, CanTabOrder, 3,
      hccxfmTabOrder, TabOrderCommand);
  end;
end;

procedure TcxWebCustomDesigner.ComponentClickItem(Sender: TObject);
var
  ComponentEditor: IComponentEditor;
begin
  ComponentEditor := CreateComponentEditor;
  if ComponentEditor <> nil then
    ComponentEditor.ExecuteVerb(TMenuItem(Sender).Tag);
end;

function TcxWebCustomDesigner.CreateComponentEditor: IComponentEditor;
var
  AList: IDesignerSelections;
  AComponent: TComponent;
  I: Integer;
begin
  AList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(AList);
  if AList.Count > 0 then
  begin
    AComponent := nil;
    for I := 0 to AList.Count - 1 do
      if AList.Items[I] is TComponent then
      begin
        AComponent := TComponent(AList.Items[I]);
        break;
      end;
    if AComponent <> nil then
      Result := GetComponentEditor(AComponent, DelphiDesigner)
  end else
    Result := nil;
end;

procedure TcxWebCustomDesigner.SelectRoot;
begin
  DelphiDesigner.SelectComponent(Root);
end;

function TcxWebCustomDesigner.ShowAlignSelectionDlg: Boolean;
var
  Data: TcxAlignDlgData;
begin
  FillChar(Data, SizeOf(TcxAlignDlgData), 0);
  Result := cxShowAlignDialog(@Data);
  if Result then
    AlignSelection(Data.HorzAlign, Data.VertAlign);
end;

function TcxWebCustomDesigner.ShowScaleSelectionDlg: Boolean;
var
  Data: TcxScaleDlgData;
begin
  FillChar(Data, SizeOf(TcxScaleDlgData), 0);
  Result := cxShowScaleDialog(@Data);
  if Result then
    ScaleSelection(Data.ScaleFactor);
end;

function TcxWebCustomDesigner.ShowSizeSelectionDlg: Boolean;
var
  Data: TcxSizeDlgData;
begin
  FillChar(Data, SizeOf(TcxSizeDlgData), 0);
  Result := cxShowSizeDialog(@Data);
  if Result then
    SizeSelection(Data.HorzAffect, Data.VertAffect, Data.HorzAbsolute, Data.VertAbsolute);
end;

function TcxWebCustomDesigner.ShowTabOrderSelectionDlg: Boolean;
begin
  Result := False;
end;

procedure TcxWebCustomDesigner.AlignSelection(AHorzAlign: TcxHorzAlign; AVertAlign: TcxVertAlign);
begin
end;

procedure TcxWebCustomDesigner.ScaleSelection(AScaleFactor: Integer);
begin
end;

procedure TcxWebCustomDesigner.SizeSelection(AHorzAffect: TcxSizeAffect; AVertAffect: TcxSizeAffect;
    AHorzAbsolute: Integer; AVertAbsolute: Integer); 
begin
end;

function TcxWebCustomDesigner.GetHTMLTemplateModified(var AFileName, AText: string): Boolean;
begin
  Result := False;
end;

function TcxWebCustomDesigner.GetShowingType: TcxWebDesignerShowingType;
var
  ADesignerWindow: IcxDesignerWindow;
begin
  if Supports(FForm, IcxDesignerWindow, ADesignerWindow) then
    Result := ADesignerWindow.GetShowingType
  else raise Exception.Create('IcxDesignerWindow interface is not supported');
end;

procedure TcxWebCustomDesigner.ShowDesignerPage;
var
  ADesignerWindow: IcxDesignerWindow;
begin
  if Supports(FForm, IcxDesignerWindow, ADesignerWindow) then
    ADesignerWindow.ShowDesigner;
end;

initialization
  FLocalPopupImages := TImageList.Create(nil);
  {$IFDEF VCL}
  FLocalPopupImages.ResInstLoad(HInstance, rtBitmap, 'Images', clFuchsia);
  {$ELSE}
  ImageListResourceLoad(HInstance, FLocalPopupImages, 'Images', clFuchsia);
  {$ENDIF}

finalization
  FreeAndNil(FLocalPopupImages);


end.
