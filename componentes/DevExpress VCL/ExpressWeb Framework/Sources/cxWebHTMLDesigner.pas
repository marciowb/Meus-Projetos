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

unit cxWebHTMLDesigner;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, ToolsAPI, Forms, Graphics,
  ImgList, ExtCtrls, Menus, DesignIntf, DesignEditors, VCLEditors, VCLMenus,
  DesignMenus, cxWebCustomDesigner, cxWebIntf, cxWebClasses, cxWebDsgnEnvOpt,
  cxWebDsgnIntf, cxWebDsgnTypes, cxWebDsgnHTMLSource,
  cxWebDsgnDelphiManager, MSHTML_TLB, cxWebDsgnHTMLConverter, cxWebRender,
  cxWebDsgnHTMLCtrls, cxWebHTMLEditor, cxWebHTMLEdBar, cxWebHTMLEdIntf;

type

  TcxWebHTMLDesigner = class;

  TcxWebHTMLControl = class(TcxHTMLEditor)
  private
    FDesigner: TcxWebHTMLDesigner;
    function GetMainParentElement: IHTMLElement;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    function ShowBorders: Boolean; override;
    function ShowDetails: Boolean; override;
    function ShowGrid: Boolean; override;
    function SnapToGrid: Boolean; override;
    function GridXSize: Integer; override;
    function GridYSize: Integer; override;
    function IsToolSelected: Boolean; override;
    procedure GetViewLinkContent(const AElement: IHTMLElement; var AContent, ACSSContent, AInlineStyle: string); override;
    function IsElementContainer(const AElement: IHTMLElement): Boolean; override;
    function CanHaveBehavior(const AElement: IHTMLElement): Boolean; override;
    function ContainerLayout(const AElement: IHTMLElement): TcxHTMLContainerLayout; override;
    function CanElementSelect(const AElement: IHTMLElement): Boolean; override;

    procedure DoOnKeyDown(const AEventObj: IHTMLEventObj); override;
    function DoOnDblClick(const AEventObj: IHTMLEventObj): WordBool; override;
    function DoOnDrop(const AEventObj: IHTMLEventObj): WordBool; override;

    procedure GetHTMLElementsList(const AList: IInterfaceList); override;
  public
    procedure DeactivateInnerHMTLElement;
    procedure RegisterEWFTags;
    property MainParentElement: IHTMLElement read GetMainParentElement;
  end;

  TcxWebHTMLSourceEditorNotifier = class(TNotifierObject, IOTANotifier, IOTAEditorNotifier)
  private
    FDesigner: TcxWebHTMLDesigner;
    FID: Integer;
    FIsModified: Boolean;
  protected
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    procedure ViewNotification(const View: IOTAEditView; Operation: TOperation);
    procedure ViewActivated(const View: IOTAEditView);
  public
    constructor Create(ADesigner: TcxWebHTMLDesigner);
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property IsModified: Boolean read FIsModified write FIsModified;
  end;

  TcxWebFormNotifier = class(TNotifierObject, IOTANotifier, IOTAFormNotifier)
  private
    FID: Integer;
    FDesigner: TcxWebHTMLDesigner;
    FEditor: IOTAEditor;
  protected
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    procedure FormActivated;
    procedure FormSaving;
    procedure ComponentRenamed(ComponentHandle: TOTAHandle;
      const OldName, NewName: string);
  public
    constructor Create(ADesigner: TcxWebHTMLDesigner);
    destructor Destroy; override;
  end;

  TcxWebIDENotifier = class(TNotifierObject, IOTANotifier, IOTAIDENotifier)
  private
    FID: Integer;
    FDesigner: TcxWebHTMLDesigner;

  protected
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    procedure FileNotification(NotifyCode: TOTAFileNotification;
      const FileName: string; var Cancel: Boolean);
    procedure BeforeCompile(const Project: IOTAProject; var Cancel: Boolean);
    procedure AfterCompile(Succeeded: Boolean);
  public
    constructor Create(ADesigner: TcxWebHTMLDesigner);
    destructor Destroy; override;
  end;

  TcxWebDesignerControlNotify = class(TInterfacedObject, IcxWebDesignerControlNotify)
  private
    FComponent: TComponent;
    FDesigner: TcxWebHTMLDesigner;
    FOldWidth, FOldHeight: Integer;

    function GetWebControl: IcxWebControl;
  public
    constructor Create(ADesigner: TcxWebHTMLDesigner; AComponent: TComponent);

    procedure BoundsChanged;
    procedure ParentChanged;
    procedure UpdateContext;

    property WebControl: IcxWebControl read GetWebControl;
  end;

  TcxWebHTMLUndoItem = class
  private
    FStream: TMemoryStream;
    FComponentClass: TComponentClass;
    FName: string;
  public
    constructor Create(AComponentClass: TComponentClass; AName: string; AStream: TStream);
    destructor Destroy; override;

    property Name: string read FName;
    property ComponentClass: TComponentClass read FComponentClass;
  end;

  TcxWebHTMLUndoItems = class
  private
    FDesigner: TcxWebHTMLDesigner;
    FItems: TList;
  public
    constructor Create(ADesigner: TcxWebHTMLDesigner);
    destructor Destroy; override;
    procedure AddItem(AComponentClass: TComponentClass; AName: string; AStream: TStream);
    function LastItem: TcxWebHTMLUndoItem;
    procedure RestoreItem;
  end;

  TcxWebHTMLUndo = class
  private
    FDesigner: TcxWebHTMLDesigner;
    FList: TList;
  protected
    function DesignerControl: TcxWebHTMLControl;
    function LastItem: TcxWebHTMLUndoItems;
  public
    constructor Create(ADesigner: TcxWebHTMLDesigner);
    destructor Destroy; override;
    procedure Clear;
    procedure Undo;
    function CanUndo: Boolean;
    function LastGroup: TcxWebHTMLUndoItems;
    function CreateNewGroup: TcxWebHTMLUndoItems;
    procedure AddDeletedComponent(AItem: TcxWebHTMLUndoItems; AComponent: TComponent);
  end;

  TcxWebHTMLDesigner = class(TcxWebCustomDesigner, IcxBaseHTMLElementCreatorNotify)
  private
    FDesignerControl: TcxWebHTMLControl;
    FDesignerBar: TcxHTMLEditorBar;
    FUndo: TcxWebHTMLUndo;
    FHTMLSource: TcxWebDsgnHTMLSource;
    FHTMLSourceEditorNotifier: TcxWebHTMLSourceEditorNotifier;
    FEditorManagerListener: TcxWebDelphiEditorManagerListener;
    FFormNotifier: IOTAFormNotifier;
    FIDeNotifier: IOTAIDENotifier;
    FHTMLSelectedControls: TList;
    FHasHTMLLoaded: Boolean;
    FHTMLSaving: Boolean;
    FIsComponentInserting: Boolean;
    FInsertingComponent: TComponent;
    FInsertingComponentName: string;
    FClipboardSelection: TList;
    FStoredTags: TcxEWFStoredTags;
    FChangedNames: TStringList;
    FOldPositioningType: TcxWebPositioningType;
    FHTMLBefore, FHTMLAfter: string;
    //  HTML Editor events
    procedure DHTMLControlInsertControl(Sender: TObject; R: TRect; var HTML, InnerHTML: string;
        var ParentElement: IHTMLElement);
    procedure DHTMLControlInsertedControl(Sender: TObject; Element: IHTMLElement);
    procedure DHTMLControlGetContext(AElement: IHTMLElement;
        var AContent, ACSSContent, AInlineStyle: string);
    procedure DHTMLControlParentChanged(ASender: TObject; ANewParent: IHTMLElement);
    procedure DHTMLControlSelectionChanged(Sender: TObject);
    procedure DHTMLControlMoved(Sender: TObject);
    procedure DHTMLControlResized(Sender: TObject);
    procedure DHTMLControlContextMenu(ASender: TObject; APos: TPoint;
      AElement: IHTMLElement);

    procedure DoEditorFormActivated(Sender: TObject);

    // HTML & designer synchronization
    procedure UpdateHTMLSource;
    procedure UpdateDesignerHTML(ADeleteComponents: Boolean);
    procedure UpdateHTMLControlContext(AComponent: TComponent);
    procedure InsertWebDesignControl(AWebControl: IcxWebControl);
    procedure DHTMLControlBoundsRectChanged(AIsMoved: Boolean);
    procedure DoMapperElementChanged(Sender: TObject);
    procedure HTMLChangeNotify(Sender: TObject);

    procedure FreeComponents(AList: TList; ADelete: Boolean);
    procedure CheckForDeletedControls;
    procedure UpdateSelectedEWFBehaviors;
    procedure InternalInsertHTMLControl(AComponent: TComponent;
        ANewName: string; ANeedOffSet: Boolean);

    //Selection
    procedure ClearHTMLSelectedControls;
    procedure ClearSelection;
    procedure CreateHTMLSelectedControls;
    function SelectionCount: Integer;
    function IsComponentSelected: Boolean;
    procedure InternalDHTMLControlSelectionChanged;

    procedure ReadComponent(AComponent: TComponent);
    procedure DoPaste;
    procedure DoCopy;
  protected
    procedure IDEDesignerOptionsChagned; override;

    function GetHTMLTemplateModified(var AFileName, AText: string): Boolean; override;
    { IcxBaseHTMLElementCreatorNotify }
    procedure HTMLElementCreated(ABaseHTMLElement: TcxBaseHTMLElement);
    function GetHTMLElementFileName: string;
    procedure ReaderSetName(AReader: TReader; AComponent: TComponent; var AName: string); override;
  public
    constructor Create(AForm: TCustomForm; ADelphiDesigner: IDesigner); override;
    destructor Destroy; override;

    procedure Modified; override;
    procedure ComponentCreated(AnItem: TComponent); override;
    procedure ComponentDestroyed(AnItem: TComponent); override;
    procedure ComponentChangedName(AComponent: TComponent; const AOldName, ANewName: string); override;

    procedure CreateDesignerControl(AParentControl: TWinControl); override;
    procedure DestroyDesignerControl; override;
    function GetDesignerControl: TWinControl; override;
    procedure RefreshDesignControls; override;
    procedure UpdateDesignerControl; override;
    procedure DesignerIdChanging; override;
    procedure DesignerPositioningTypeChanged; override;
    procedure DesignerActivated; override;
    procedure DesignerDeactivated; override;
    procedure PreviewShowing; override;
    function GetControlPositioningType: TcxWebPositioningType; override;

    class function GetID: Integer; override;
    class function GetName: String; override;

    function CanAlign: Boolean; override;
    function CanAlignToGrid: Boolean; override;
    function CanCopy: Boolean; override;
    function CanCut: Boolean; override;
    function CanDelete: Boolean; override;
    function CanPaste: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanTabOrder: Boolean; override;
    function CanUndo: Boolean; override;

    procedure ScaleSelection(AScaleFactor: Integer); override;
    procedure AlignSelection(AHorzAlign: TcxHorzAlign; AVertAlign: TcxVertAlign); override;
    procedure SizeSelection(AHorzAffect: TcxSizeAffect; AVertAffect: TcxSizeAffect;
      AHorzAbsolute: Integer; AVertAbsolute: Integer); override;
    function ShowTabOrderSelectionDlg: Boolean; override;

    { IcxWebDesigner }
    procedure AlignToGrid; override;
    function CanSelect(const AControl: TComponent): Boolean; override;
    procedure CopySelection; override;
    procedure CutSelection; override;
    procedure DeleteSelection; override;
    procedure Edit(AComponent: TComponent); override;
    procedure GetSelections(const AList: TList); override;
    procedure PasteSelection; override;
    procedure SelectAll; override;
    procedure SelectionChanged(const AList: TList); override;
    procedure Undo; override;
  end;


implementation

uses
  ComponentDesigner, cxWebDsgnFactory, cxWebStrs, StrUtils,
  cxWebUtils, cxWebHTMLElementMapper, HTTPProd,
  cxWebHTMLProd, cxWebDsgnUtils, Clipbrd, Variants, cxWebFileCacheManager,
  cxWebPathConst, cxfmTabOrder, cxWebDsgnStrs;

{ TcxWebHTMLControl }

procedure TcxWebHTMLControl.GetHTMLElementsList(const AList: IInterfaceList);
begin
  GetHTMLElements(Document, AList);
end;

procedure TcxWebHTMLControl.RegisterEWFTags;
var
  I: Integer;
  AStrings: TStringList;
begin
  AStrings := TStringList.Create;
  GetRegisterEWFTags(AStrings);
  try
    for I := 0 to AStrings.Count - 1 do
      RegisterTags(scxEWF, [AStrings[I]]);
  finally
    AStrings.Free;
  end;
end;

function TcxWebHTMLControl.GetMainParentElement: IHTMLElement;
begin
  Result := GetDesignerHTMLMainParentElement(Document, FDesigner.Root);
end;

procedure TcxWebHTMLControl.WMKeyDown(var Message: TWMKeyDown);
begin
  if Message.CharCode = VK_TAB then
    Message.Result := 1
  else inherited;
end;

procedure TcxWebHTMLControl.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTTAB;
end;

function TcxWebHTMLControl.ShowBorders: Boolean;
begin
  Result := inherited ShowBorders;
end;

function TcxWebHTMLControl.ShowDetails: Boolean;
begin
  Result := inherited ShowDetails;
end;

function TcxWebHTMLControl.ShowGrid: Boolean;
begin
  Result := FDesigner.DisplayGrid;
end;

function TcxWebHTMLControl.SnapToGrid: Boolean;
begin
  Result := FDesigner.SnapToGrid;
end;

function TcxWebHTMLControl.GridXSize: Integer;
begin
  Result := FDesigner.GridSizeX;
end;

function TcxWebHTMLControl.GridYSize: Integer;
begin
  Result := FDesigner.GridSizeY;
end;

function TcxWebHTMLControl.IsToolSelected: Boolean;
begin
  Result := FDesigner.GetCurrComponentClass <> nil;
end;

type
 TWinControlAccess = class(TWinControl);

procedure TcxWebHTMLControl.DoOnKeyDown(const AEventObj: IHTMLEventObj);
begin
  if AEventObj <> nil then
    case AEventObj.keyCode of
      Integer('Z'):
         //TODO
         if AEventObj.ctrlKey then
         begin
           AEventObj.returnValue := False;
           FDesigner.Undo;
         end;
      Integer('X'):
         if AEventObj.ctrlKey then
         begin
           AEventObj.returnValue := False;
           FDesigner.CutSelection;
         end;
      Integer('V'):
         if AEventObj.ctrlKey then
         begin
           AEventObj.returnValue := False;
           FDesigner.PasteSelection;
         end;
      Integer('C'):
         if AEventObj.ctrlKey then
         begin
           AEventObj.returnValue := False;
           FDesigner.CopySelection;
         end;
      VK_INSERT:
         begin
           if AEventObj.ctrlKey then
           begin
             AEventObj.returnValue := False;
             FDesigner.CopySelection;
           end
           else
             if AEventObj.shiftKey then
             begin
               AEventObj.returnValue := False;
               FDesigner.PasteSelection;
             end;
         end;
      VK_DELETE:
        begin
          if FDesigner.IsComponentSelected then
          begin
            AEventObj.returnValue := False;
            FDesigner.DeleteSelection;
          end;
        end;
      VK_F9, VK_F12:
        begin
          AEventObj.returnValue := False;
          AEventObj.cancelBubble := True;
          if (GetParentForm(self) <> nil) then
          begin
            try
              Enabled := False;
            finally
              Enabled := True;
            end;
            PostMessage(GetParentForm(self).Handle, WM_KEYDOWN, AEventObj.keyCode, 0);
            PostMessage(GetParentForm(self).Handle, WM_KEYUP, AEventObj.keyCode, 0);
          end;
          exit;
        end;
    end;
  inherited DoOnKeyDown(AEventObj);
end;

function TcxWebHTMLControl.DoOnDblClick(const AEventObj: IHTMLEventObj): WordBool;
var
  AComponent: TComponent;
begin
  Result := inherited DoOnDblClick(AEventObj);
  if (AEventObj.srcElement <> nil) then
  begin
    AComponent := GetComponentByHTMLElement(FDesigner.Root, AEventObj.srcElement);
    if (AComponent <> nil) and not Supports(AComponent, IcxWebContainerControl) then
      FDesigner.DelphiDesigner.Edit(AComponent);
  end;
end;

procedure TcxWebHTMLControl.GetViewLinkContent(const AElement: IHTMLElement;
  var AContent, ACSSContent, AInlineStyle: string);
begin
  inherited;
  FDesigner.DHTMLControlGetContext(AElement, AContent, ACSSContent, AInlineStyle);
end;

function TcxWebHTMLControl.IsElementContainer(const AElement: IHTMLElement): Boolean;
var
  AComponent: TComponent;
begin
  AComponent := GetComponentByHTMLElement(FDesigner.Root, AElement);
  Result := (AComponent <> nil) and Supports(AComponent, IcxWebContainerControl);
end;

function TcxWebHTMLControl.CanHaveBehavior(const AElement: IHTMLElement): Boolean;
begin
  Result := not Supports(AElement, IHTMLFormElement) and
    not SameText(AElement.tagName, 'form') ;
end;

function TcxWebHTMLControl.ContainerLayout(const AElement: IHTMLElement): TcxHTMLContainerLayout;
begin
  Result := inherited ContainerLayout(AElement);
  if Supports(AElement, IHTMLBodyElement) then
    if FDesigner.PositioningType = cxptFlow then
      Result := hclFlow
    else
      Result := hclGrid;
end;

function TcxWebHTMLControl.CanElementSelect(const AElement: IHTMLElement): Boolean;
begin
  if AElement <> nil then
    Result := not Supports(AElement, IHTMLBodyElement) and
      not Supports(AElement, IHTMLFormElement) and
      not SameText(AElement.tagName, 'form')
  else
    Result := False;
end;

procedure TcxWebHTMLControl.DeactivateInnerHMTLElement;
var
  AElement: IHTMLElement;
begin
  if not FDesigner.FHasHTMLLoaded then exit;
  if (Selection.Count = 1) then
  begin
    AElement := Selection[0];
    if (AElement <> nil) and not (AElement as IHTMLElement3).isDisabled and
      (GetComponentByHTMLElement(FDesigner.Root, AElement) = nil) then
    begin
      try
        FDesigner.BeginUpdate;
        (AElement as IHTMLElement3).disabled := true;
        (AElement as IHTMLElement3).disabled := false;
        if AElement.ParentElement <> nil then
          Selection.Add(AElement);
      finally
        FDesigner.CancelUpdate;
      end;
    end;
  end;
end;

function TcxWebHTMLControl.DoOnDrop(const AEventObj: IHTMLEventObj): WordBool;
begin
  if AEventObj.ctrlKey and IsHTMLCustomElement(self.DraggingElement) then
  begin
    AEventObj.returnValue := False;
    Result := False;
  end else Result := inherited DoOnDrop(AEventObj);
end;

procedure UpdateHTMLElementStylePositions(AHTMLElement: IHTMLElement; AWebControl: IcxWebControl);
begin
  with AWebControl.BoundsRect do
  begin
    AHTMLElement.style.pixelLeft := Left;
    AHTMLElement.style.pixelTop := Top;
    AHTMLElement.style.pixelWidth := Right - Left;
    AHTMLElement.style.pixelHeight := Bottom - Top;
  end;
end;

{ TcxWebDesignerControlNotify }
constructor TcxWebDesignerControlNotify.Create(ADesigner: TcxWebHTMLDesigner;  AComponent: TComponent);
begin
  FDesigner := ADesigner;
  FComponent := AComponent;
end;

function TcxWebDesignerControlNotify.GetWebControl: IcxWebControl;
begin
  Supports(FComponent, IcxWebControl, Result);
end;

procedure TcxWebDesignerControlNotify.BoundsChanged;
var
  AHTMLElement: IHTMLElement;
  AComponentName: string;
begin
  if not FDesigner.FHasHTMLLoaded or FDesigner.FHTMLSaving then exit;
  if FComponent.Name <> '' then
    AComponentName := FComponent.Name
  else AComponentName := FDesigner.FInsertingComponentName;
  if AComponentName = '' then exit;
  AHTMLElement := GetHTMLElementByComponentName(FDesigner.FDesignerControl.Document3, AComponentName);
  if AHTMLElement <> nil then
    UpdateHTMLElementStylePositions(AHTMLElement, WebControl);
  with WebControl.BoundsRect do
  begin
    if (FOldWidth  <> Right - Left) or
      (FOldHeight <> Bottom - Top) then
      UpdateContext;
    FOldWidth  := Right - Left;
    FOldHeight := Bottom - Top;
    if (FDesigner.UpdateCount = 0) then
    begin
      if not (FDesigner.FDesignerControl.State = esMoving) then
        WebControl.UpdateControlPosition;
      FDesigner.BeginUpdate;
      try
        FDesigner.DelphiDesigner.Modified;
      finally
        FDesigner.CancelUpdate;
      end;
    end;
  end;
end;

procedure TcxWebDesignerControlNotify.ParentChanged;
var
  AWebParent: IcxWebContainerControl;
  AParentElement, AElement: IHTMLElement;
  AParentComponent: TComponent;
  AParentNode, AElementNode: IHTMLDOMNode;
begin
  if not FDesigner.FHasHTMLLoaded or (csDestroying in FComponent.ComponentState) then exit;
  AWebParent := WebControl.Parent;
  AElement := GetHTMLElementByComponentName(FDesigner.FDesignerControl.Document3, FComponent.Name);
  AParentComponent := GetComponentByInterface(AWebParent);
  if AParentComponent = nil then
    AParentComponent := FDesigner.DelphiDesigner.Root;
  AParentElement := GetHTMLElementByComponentName(FDesigner.FDesignerControl.Document3, AParentComponent.Name);
  if AParentElement = nil then
    AParentElement := FDesigner.FDesignerControl.Document.body;
  if Supports(AElement, IHTMLDOMNode, AElementNode) and
    Supports(AParentElement, IHTMLDOMNode, AParentNode) then
  begin
//    if not AParentElement.contains(AElement) then
    if not IsEqualElement(AElement.parentElement, AParentElement) then
      AParentNode.appendChild(AElementNode);
    if FDesigner.PositioningType <> cxptFlow then
    begin
      if Supports(AParentComponent, IcxWebPage) then
        AElement.style.setAttribute('position', 'absolute', 0)
      else AElement.style.removeAttribute('position', 0);
    end;
  end;
  WebControl.UpdateControlPosition;
end;

procedure TcxWebDesignerControlNotify.UpdateContext;
begin
  if not (csDestroying in FDesigner.Root.ComponentState) and
    FDesigner.FHasHTMLLoaded then
    FDesigner.UpdateHTMLControlContext(FComponent);
end;

{ TcxWebHTMLUndoItem }
constructor TcxWebHTMLUndoItem.Create(AComponentClass: TComponentClass; AName: string; AStream: TStream);
begin
  FStream := TMemoryStream.Create;
  FStream.LoadFromStream(AStream);
  FComponentClass := AComponentClass;
  FName := AName;
end;

destructor TcxWebHTMLUndoItem.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

{ TcxWebHTMLUndoItems }
constructor TcxWebHTMLUndoItems.Create(ADesigner: TcxWebHTMLDesigner);
begin
  FDesigner := ADesigner;
  FItems := TList.Create;
end;

destructor TcxWebHTMLUndoItems.Destroy;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    TcxWebHTMLUndoItem(FItems[I]).Free;
  FItems.Free;
  inherited Destroy;
end;

procedure TcxWebHTMLUndoItems.AddItem(AComponentClass: TComponentClass; AName: string; AStream: TStream);
begin
  FItems.Add(TcxWebHTMLUndoItem.Create(AComponentClass, AName, AStream));
end;

function TcxWebHTMLUndoItems.LastItem: TcxWebHTMLUndoItem;
begin
  if FItems.Count > 0 then
    Result := TcxWebHTMLUndoItem(FItems.Last)
  else Result := nil;
end;

procedure TcxWebHTMLUndoItems.RestoreItem;
var
  AComponent: TComponent;
  AName: string;
  AWebControl: IcxWebControl;
begin
  AComponent := LastItem.ComponentClass.Create(FDesigner.Root);
  if FDesigner.Root.FindComponent(LastItem.Name) = nil then
    AName := LastItem.Name
  else
    AName := FDesigner.DelphiDesigner.UniqueName(DropT(LastItem.ComponentClass.ClassName));
  AComponent.Name := AName;
  LastItem.FStream.ReadComponent(AComponent);
  if Supports(AComponent, IcxWebControl, AWebControl) then
  begin
    AWebControl.UpdateControlPosition;
    if (AWebControl.DesignerControl <> nil) then
      AWebControl.DesignerControl.UpdateContext;
  end;
  FItems.Delete(FItems.Count - 1);
end;


{ TcxWebHTMLUndo }
constructor TcxWebHTMLUndo.Create(ADesigner: TcxWebHTMLDesigner);
begin
  FDesigner := ADesigner;
  FList := TList.Create;
end;

destructor TcxWebHTMLUndo.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TcxWebHTMLUndo.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    TcxWebHTMLUndoItem(FList[I]).Free;
  FList.Clear;  
end;

function TcxWebHTMLUndo.DesignerControl: TcxWebHTMLControl;
begin
  Result := FDesigner.FDesignerControl;
end;

function TcxWebHTMLUndo.LastItem: TcxWebHTMLUndoItems;
begin
  if FList.Count > 0 then
    Result := TcxWebHTMLUndoItems(FList.Last)
  else Result := nil;  
end;

procedure TcxWebHTMLUndo.Undo;
begin
  if not CanUndo then exit;
  begin
    while (LastGroup.LastItem <> nil) do
      LastGroup.RestoreItem;
    LastGroup.Free;
    FList.Delete(FList.Count - 1);
  end;
end;

function TcxWebHTMLUndo.CanUndo: Boolean;
begin
  Result := LastGroup <> nil;
end;

function TcxWebHTMLUndo.LastGroup: TcxWebHTMLUndoItems;
begin
  if FList.Count > 0 then
    Result := TcxWebHTMLUndoItems(FList.Last)
  else Result := nil;
end;

function TcxWebHTMLUndo.CreateNewGroup: TcxWebHTMLUndoItems;
begin
  Result := TcxWebHTMLUndoItems.Create(FDesigner);
  FList.Add(Result);
end;

procedure TcxWebHTMLUndo.AddDeletedComponent(AItem: TcxWebHTMLUndoItems; AComponent: TComponent);
var
  AStream: TMemoryStream;
begin
  if not Supports(AComponent, IcxWebControl) or
    (csDestroying in FDesigner.Root.ComponentState) then exit;
  AStream := TMemoryStream.Create;
  try
    AStream.WriteComponent(AComponent);
    AItem.AddItem(TComponentClass(AComponent.ClassType),
                  AComponent.Name, AStream);
  finally
    AStream.Free;
  end;
end;


{TcxWebHTMLSourceEditorNotifier}
constructor TcxWebHTMLSourceEditorNotifier.Create(ADesigner: TcxWebHTMLDesigner);
begin
  FDesigner := ADesigner;
end;

destructor TcxWebHTMLSourceEditorNotifier.Destroy;
begin
  inherited Destroy;
end;

procedure TcxWebHTMLSourceEditorNotifier.AfterSave;
begin
end;

procedure TcxWebHTMLSourceEditorNotifier.BeforeSave;
begin
end;

procedure TcxWebHTMLSourceEditorNotifier.Destroyed;
begin
end;

procedure TcxWebHTMLSourceEditorNotifier.Modified;
begin
  FIsModified := True;
end;

procedure TcxWebHTMLSourceEditorNotifier.ViewNotification(const View: IOTAEditView; Operation: TOperation);
begin
end;

procedure TcxWebHTMLSourceEditorNotifier.ViewActivated(const View: IOTAEditView);
begin

end;

{ TcxWebFormNotifier  }
constructor TcxWebFormNotifier.Create(ADesigner: TcxWebHTMLDesigner);
begin
  FDesigner := ADesigner;
  FEditor := (BorlandIDEServices as IOTAModuleServices).CurrentModule.CurrentEditor;
  if FEditor <> nil then
    FID := FEditor.AddNotifier(self);
end;

destructor TcxWebFormNotifier.Destroy;
begin
  if FEditor <> nil then
    FEditor.RemoveNotifier(FID);
  FEditor := nil;  
  inherited Destroy;
end;

procedure TcxWebFormNotifier.AfterSave;
begin
end;

procedure TcxWebFormNotifier.BeforeSave;
begin
  FDesigner.UpdateHTMLSource;
end;

procedure TcxWebFormNotifier.Destroyed;
begin
end;

procedure TcxWebFormNotifier.Modified;
begin
end;

procedure TcxWebFormNotifier.FormActivated;
begin
end;

procedure TcxWebFormNotifier.FormSaving;
begin
  FDesigner.UpdateHTMLSource;
end;

procedure TcxWebFormNotifier.ComponentRenamed(ComponentHandle: TOTAHandle; const OldName, NewName: string);
begin
end;

{ TcxWebIDENotifier }
constructor TcxWebIDENotifier.Create(ADesigner: TcxWebHTMLDesigner);
begin
  FDesigner := ADesigner;
  FID := (BorlandIDEServices as IOTAServices50).AddNotifier(self);
end;

destructor TcxWebIDENotifier.Destroy;
begin
  (BorlandIDEServices as IOTAServices50).RemoveNotifier(FID);
  inherited Destroy;
end;

procedure TcxWebIDENotifier.AfterSave;
begin
end;

procedure TcxWebIDENotifier.BeforeSave;
begin
end;

procedure TcxWebIDENotifier.Destroyed;
begin
end;

procedure TcxWebIDENotifier.Modified;
begin
end;

procedure TcxWebIDENotifier.FileNotification(NotifyCode: TOTAFileNotification;
  const FileName: string; var Cancel: Boolean);
var
  AImplFileName, AIntfFileName, AFormFileName: string;
begin
  if (NotifyCode = ofnFileOpened) and not (FDesigner.FHasHTMLLoaded) and
    (FDesigner.FHTMLSource.SourceEditor = nil) then
  begin
    FDesigner.DelphiDesigner.ModuleFileNames(AImplFileName, AIntfFileName, AFormFileName);
    if FileName = AImplFileName then
      with FDesigner do
      begin
        FHTMLSource.ReRequestSourceEditor(FileName, nil);
        if FHTMLSource.SourceEditor <> nil then
        begin
          FHTMLSourceEditorNotifier.ID := FHTMLSource.SourceEditor.AddNotifier(FHTMLSourceEditorNotifier);
          UpdateDesignerHTML(False);
        end;
      end;
  end;
  if (NotifyCode = ofnFileOpening) then
  begin
    FDesigner.DelphiDesigner.ModuleFileNames(AImplFileName, AIntfFileName, AFormFileName);
    if FileName = AFormFileName then
      FDesigner.UpdateHTMLSource;
  end;
end;

procedure TcxWebIDENotifier.BeforeCompile(const Project: IOTAProject; var Cancel: Boolean);
begin
  FDesigner.UpdateHTMLSource;
end;

procedure TcxWebIDENotifier.AfterCompile(Succeeded: Boolean);
begin
end;


type
TcxWebDesignerFileManager = class(TInterfacedObject, IDesignerFileManager)
private
  function GetGlobalPath: string;
  function GetJSScriptPath: string;
  function GetImagePath: string;
protected
  function QualifyFileName(const AFileName: string): string;
  function GetStream(const AFileName: string; var AOwned: Boolean): TStream;
end;

function TcxWebDesignerFileManager.GetGlobalPath: string;
begin
  Result := ExcludeTrailingPathDelimiter(ExtractFilePath(cxGetDesignerApplicationFileName));
  if ExtractFileName(Result) = 'Lib' then
    Result := ExtractFilePath(Result)  // old installation
  else
    Result := ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(Result)));  // new installation
end;

function TcxWebDesignerFileManager.GetJSScriptPath: string;
begin
  Result := GetGlobalPath + cxWebJScriptDTPath + PathDelim;
end;

function TcxWebDesignerFileManager.GetImagePath: string;
begin
  Result := GetGlobalPath + cxWebImageDTPath + PathDelim;
end;

function TcxWebDesignerFileManager.QualifyFileName(const AFileName: string): string;
var
  AExt: string;
begin
  AExt := UpperCase(ExtractFileExt(AFileName));
  if (AExt <> '') and (AExt[1] = '.') then
    AExt := Copy(AExt, 2, Length(AExt));
  if AExt = 'JS' then
    Result := GetJSScriptPath  + AFileName
  else
    if (AExt = 'GIF') or (AExt = 'JPEG') or (AExt = 'BMP') or
      (AExt =  'JPG') then
      Result := GetImagePath  + AFileName
    else  Result := AFileName;
  Result := StringReplace(Result, '\', '/', [rfReplaceAll, rfIgnoreCase]);
end;

function TcxWebDesignerFileManager.GetStream(const AFileName: string; var AOwned: Boolean): TStream;
begin
  Result := nil;
end;

var
  FWebDesignerFileManager: TcxWebDesignerFileManager = nil;
  FWebDesignerFileManagerCount: Integer = 0;

procedure AddDesignerFileManager;
begin
  if FWebDesignerFileManager = nil then
  begin
    FWebDesignerFileManager := TcxWebDesignerFileManager.Create;
    DesignerFileManager := FWebDesignerFileManager;
  end;
  Inc(FWebDesignerFileManagerCount);
end;

procedure ReleaseDesignerFileManager;
begin
  Dec(FWebDesignerFileManagerCount);
  if FWebDesignerFileManagerCount = 0 then
  begin
    FWebDesignerFileManager := nil;
    DesignerFileManager := nil;
  end;
end;

{ TcxWebHTMLDesigner }
constructor TcxWebHTMLDesigner.Create(AForm: TCustomForm; ADelphiDesigner: IDesigner);
begin
  inherited Create(AForm, ADelphiDesigner);
  FHTMLSelectedControls := TList.Create;
  TcxWebFileCacheManager.Instance.IncDesignerCount;
  AddDesignerFileManager;
  FStoredTags := TcxEWFStoredTags.Create(Root);
end;

destructor TcxWebHTMLDesigner.Destroy;
begin
  FStoredTags.Free;
  ReleaseDesignerFileManager;
  TcxWebFileCacheManager.Instance.DecDesignerCount;
  FHTMLSelectedControls.Free;
  inherited Destroy;
end;

procedure TcxWebHTMLDesigner.Modified;
begin
  inherited;
  if FDesignerControl <> nil then
    FDesignerControl.Modified := True;
end;

procedure TcxWebHTMLDesigner.ComponentCreated(AnItem: TComponent);
var
  AWebControl: IcxWebControl;
begin
  if FHasHTMLLoaded and not (csLoading in AnItem.ComponentState) and
  Supports(AnItem, IcxWebControl, AWebControl) then
  begin
    InsertWebDesignControl(AWebControl);
  end;
end;

procedure TcxWebHTMLDesigner.ComponentDestroyed(AnItem: TComponent);
var
  AHTMLElement: IHTMLElement;
begin
  FStoredTags.Remove(AnItem);
  AHTMLElement := GetHTMLElementByComponentName(FDesignerControl.Document3, AnItem.Name);
  if AHTMLElement <> nil then
    AHTMLElement.outerHTML := '';
end;

procedure TcxWebHTMLDesigner.ComponentChangedName(AComponent: TComponent; const AOldName, ANewName: string);
var
  AHTMLElement: IHTMLElement;
  AWebControl: IcxWebControl;
begin
  if not FHasHTMLLoaded then exit;
  AHTMLElement := GetHTMLElementByComponentName(FDesignerControl.Document3, AOldName);
  if AHTMLElement <> nil then
    AHTMLElement.id := ANewName
  else
  begin
    if FHasHTMLLoaded and Supports(AComponent, IcxWebControl, AWebControl) and
      (AOldName = '') and (ANewName <> '') and
      not FIsComponentInserting then
    begin
      BeginUpdate;
      try
        InternalInsertHTMLControl(AComponent, ANewName, True);
      finally
        CancelUpdate;
      end;
    end;
  end;
end;

procedure TcxWebHTMLDesigner.CreateDesignerControl(AParentControl: TWinControl);

  procedure CreateDesignerBar;
  begin
    try
      SendMessage(AParentControl.Handle, WM_SETREDRAW, Integer(False), 0);
      FDesignerBar := TcxHTMLEditorBar.Create(nil);
      FDesignerBar.Parent := AParentControl;
      FDesignerBar.Align := alTop;
      FDesignerBar.CreateActionControls;
      FDesignerControl.Bar := FDesignerBar;
    finally
      SendMessage(AParentControl.Handle, WM_SETREDRAW, Integer(True), 0);
      RedrawWindow(AParentControl.Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
      AParentControl.Update;
    end;
  end;

begin
  FDesignerControl := TcxWebHTMLControl.Create(nil);
  FDesignerControl.FDesigner := self;
  FDesignerControl.Parent := AParentControl;
  FDesignerControl.RegisterEWFTags;
  FDesignerControl.Align := alClient;
  FDesignerControl.SetDesigning(False);
  FDesignerControl.OnControlInsert := DHTMLControlInsertControl;
  FDesignerControl.OnControlInserted := DHTMLControlInsertedControl;
  FDesignerControl.OnSelectionChanged := DHTMLControlSelectionChanged;
  FDesignerControl.OnMoved := DHTMLControlMoved;
  FDesignerControl.OnResized := DHTMLControlResized;
  FDesignerControl.OnShowContextMenu := DHTMLControlContextMenu;
  FDesignerControl.OnParentChanged := DHTMLControlParentChanged;

  CreateDesignerBar;
  if GetParentForm(AParentControl) <> nil then
    GetParentForm(AParentControl).ActiveControl := FDesignerControl;

  FUndo := TcxWebHTMLUndo.Create(self);

  FHTMLSource := TcxWebDsgnHTMLSource.Create('', DelphiDesigner);

  FHTMLSourceEditorNotifier := TcxWebHTMLSourceEditorNotifier.Create(self);
  if FHTMLSource.SourceEditor <> nil then
    FHTMLSourceEditorNotifier.ID := FHTMLSource.SourceEditor.AddNotifier(FHTMLSourceEditorNotifier);

  FEditorManagerListener := TcxWebDelphiEditorManagerListener.Create;
  FEditorManagerListener.OnEditorFormActivated := DoEditorFormActivated;
  FFormNotifier := TcxWebFormNotifier.Create(self);
  FIDeNotifier := TcxWebIDENotifier.Create(self);

  AddBaseHTMLElementCreatorNotify(self);
end;

procedure TcxWebHTMLDesigner.DestroyDesignerControl;
begin
  FDesignerControl.OnDocumentChange := nil;
  RemoveBaseHTMLElementCreatorNotify(self);

  FHasHTMLLoaded := False;
  FEditorManagerListener.Free;

  if FHTMLSource.SourceEditor <> nil then
    FHTMLSource.SourceEditor.RemoveNotifier(FHTMLSourceEditorNotifier.ID);
  FHTMLSourceEditorNotifier := nil;
  FFormNotifier._Release;
  FFormNotifier := nil;
  FIDENotifier._Release;
  FIDENotifier := nil;
  FHTMLSource.Free;
  ClearHTMLSelectedControls;

  FUndo.Free;

  FDesignerControl.Bar := nil;
  FDesignerBar.Free;
  FDesignerBar := nil;
  FDesignerControl.Free;
  FDesignerControl := nil;
end;

function TcxWebHTMLDesigner.GetDesignerControl: TWinControl;
begin
  Result := FDesignerControl;
end;

procedure TcxWebHTMLDesigner.RefreshDesignControls;
begin
  FOldPositioningType := PositioningType;
  if FHTMLSource.SourceEditor <> nil then
    UpdateDesignerHTML(False);
end;

procedure TcxWebHTMLDesigner.UpdateDesignerControl;
var
  AList: IInterfaceList;
  I: Integer;
begin
  AList := CreateControlList;
  for I := 0 to AList.Count - 1 do
  begin
    InsertWebDesignControl(IcxWebControl(AList[I]));
    if (IcxWebControl(AList[I]).DesignerControl <> nil) and FHasHTMLLoaded then
      with IcxWebControl(AList[I]).DesignerControl do
      begin
       ParentChanged;
       BoundsChanged;
       UpdateContext;
      end;
  end;
end;

procedure TcxWebHTMLDesigner.DesignerIdChanging;
begin
  if (Root <> nil) and not (csLoading in Root.ComponentState) then
    UpdateHTMLSource;
end;


procedure TcxWebHTMLDesigner.DesignerPositioningTypeChanged;

  procedure UpdatePositions(AAbsolute: Boolean);
  var
    AList: IInterfaceList;
    I: Integer;
    AStyle2: IHTMLStyle2;
  begin
    AList := TInterfaceList.Create;
    GetHTMLElements(FDesignerControl.Document, AList);
    for I := 0 to AList.Count - 1 do
      if Supports(IHTMLElement(AList[I]).style, IHTMLStyle2, AStyle2) then
      begin
        if AAbsolute then
          AStyle2.position := 'absolute' //TODO check the parent.
        else AStyle2.position := '';
      end;
    if AAbsolute then
      UpdateWebDesignerControlsPosition(Root, FDesignerControl.Document);
  end;

begin
  if not FHasHTMLLoaded then exit;
  FDesignerControl.Wait;
  if (FOldPositioningType = cxptFlow) then
    UpdatePositions(True)
  else
    if (PositioningType = cxptFlow) then
      UpdatePositions(False);
  FDesignerControl.SetupControl;

  FOldPositioningType := PositioningType;
  if PositioningType = cxptGrid then
    UpdateControlsPosition;
  FDesignerControl.UndoManager.Clear;  
  FDesignerControl.Modified := True;
end;

class function TcxWebHTMLDesigner.GetID: Integer;
begin
  Result := 2;
end;

class function TcxWebHTMLDesigner.GetName: String;
begin
  Result := 'HTML'
end;

function TcxWebHTMLDesigner.CanAlign: Boolean;
begin
  Result := PositioningType <> cxptFlow;
end;

function TcxWebHTMLDesigner.CanAlignToGrid: Boolean;
begin
  Result := (PositioningType <> cxptFlow) and FDesignerControl.SnapToGrid;
end;

function TcxWebHTMLDesigner.CanCopy: Boolean;
begin
  Result := (SelectionCount > 0) or FDesignerControl.Selection.CanCopy;
end;

function TcxWebHTMLDesigner.CanCut: Boolean;
begin
  Result := CanCopy and CanDelete;
end;

function TcxWebHTMLDesigner.CanDelete: Boolean;
begin
  Result := (inherited CanDelete);
  if not Result and (SelectionCount = 0) then
    Result := FDesignerControl.Selection.CanDelete;
end;

function TcxWebHTMLDesigner.CanPaste: Boolean;
begin
  Result := (PositioningType <> cxptFlow) or FDesignerControl.Selection.CanPaste;
end;

function TcxWebHTMLDesigner.CanSelectAll: Boolean;
begin
  Result := (Root.ComponentCount > 0);
end;

function TcxWebHTMLDesigner.CanTabOrder: Boolean;
begin
  Result := True;
end;

function TcxWebHTMLDesigner.CanUndo: Boolean;
begin
  Result := FUndo.CanUndo;
end;

procedure TcxWebHTMLDesigner.ScaleSelection(AScaleFactor: Integer);

  procedure ScaleControl(AControl: IHTMLElement);
  begin
    if not SameText((AControl as IHTMLElement2).currentStyle.position, 'static') then // Do not localize
    begin
      AControl.style.setAttribute('width', MulDiv(AControl.offsetWidth, AScaleFactor, 100), 0);
      AControl.style.setAttribute('height', MulDiv(AControl.offsetHeight, AScaleFactor, 100), 0);
    end;
  end;

var
  I: Integer;
begin
  with FDesignerControl do
  begin
    UndoManager.BeginUndoBlock(scxCmdResize);
    try
      for I := 0 to Selection.Count - 1 do
        ScaleControl(Selection[I]);
      DHTMLControlBoundsRectChanged(False);
    finally
      UndoManager.EndUndoBlock;
    end;
  end;
end;

function HorzCompareFunc(AItem1, AItem2: Pointer): Integer;
begin
  Result := IHTMLElement(AItem1).offsetLeft - IHTMLElement(AItem2).offsetLeft;
end;

function VertCompareFunc(AItem1, AItem2: Pointer): Integer;
begin
  Result := IHTMLElement(AItem1).offsetTop - IHTMLElement(AItem2).offsetTop;
end;

procedure TcxWebHTMLDesigner.AlignSelection(AHorzAlign: TcxHorzAlign; AVertAlign: TcxVertAlign);
type
  PcxAlignData = ^TcxAlignData;
  TcxAlignData = record
    CenterWidth: Integer;
    CenterHeight: Integer;
    MostLeft: Integer;
    MostTop: Integer;
    ParentWidth: Integer;
    ParentHeight: Integer;
    HorzDistance: Integer;
    VertDistance: Integer;
    HorzSortedList: TList;
    VertSortedList: TList;
  end;
var
  AlignData: TcxAlignData;
  Selections: IInterfaceList;

  procedure CalcAlignData;
  var
    I: Integer;
    Control: IHTMLElement;
    LeftMost, RightMost,
    TopMost, BottomMost: IHTMLElement;
  begin
    LeftMost := nil;
    RightMost := nil;
    TopMost := nil;
    BottomMost := nil;
    for I := 0 to FDesignerControl.Selection.Count - 1 do
    begin
      Control := FDesignerControl.Selection[I];
      if not SameText((Control as IHTMLElement2).currentStyle.position, 'static') and // Do not localize
        ((Selections.Count = 0) or IsEqualElement(IHTMLElement(Selections[0]).offsetParent, Control.offsetParent)) then
      begin
        Selections.Add(Control);
        if (LeftMost = nil) or (LeftMost.offsetLeft > Control.offsetLeft) then
          LeftMost := Control;
        if (RightMost = nil) or (RightMost.offsetLeft + RightMost.offsetWidth < Control.offsetLeft + Control.offsetWidth) then
          RightMost := Control;
        if (TopMost = nil) or (TopMost.offsetTop > Control.offsetTop) then
          TopMost := Control;
        if (BottomMost = nil) or (BottomMost.offsetTop + BottomMost.offsetHeight < Control.offsetTop + Control.offsetHeight) then
          BottomMost := Control;
      end;
    end;
    with AlignData do
    begin
      Control := IHTMLElement(Selections[0]);
      if Control <> nil then
      begin
        CenterWidth := Control.offsetWidth;
        CenterHeight := Control.offsetHeight;
        Control := Control.offsetParent;
      end;
      if Control = nil then
        Control := FDesignerControl.Document.body;
      ParentWidth := (Control as IHTMLElement2).clientWidth;
      ParentHeight := (Control as IHTMLElement2).clientHeight;

      if Selections.Count > 1 then
      begin
        HorzDistance := (RightMost.offsetLeft - LeftMost.offsetLeft) div (Selections.Count - 1);
        VertDistance := (BottomMost.offsetTop - TopMost.offsetTop) div (Selections.Count - 1);
      end;

      HorzSortedList := nil;
      if AHorzAlign = haSpace then
      begin
        HorzSortedList := CloneList(Selections);
        HorzSortedList.Sort(HorzCompareFunc);
      end;

      VertSortedList := nil;
      if AVertAlign = vaSpace then
      begin
        VertSortedList := CloneList(Selections);
        VertSortedList.Sort(VertCompareFunc);
      end;
      MostLeft := LeftMost.offsetLeft;
      MostTop := TopMost.offsetTop;
    end;
  end;

  function IndexOfElement(AList: TList; AElement: IHTMLElement): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    if (AList = nil) or (AElement = nil) then Exit;
    for I := 0 to AList.Count - 1 do
      if IsEqualElement(IHTMLElement(AList.Items[I]), AElement) then
      begin
        Result := I;
        break;
      end;
  end;

  procedure PlaceControls;
  var
    I, Index: Integer;
    Control, FirstControl: IHTMLElement;
    ALeft, ATop, AWidth, AHeight: Integer;
  begin
    FirstControl := IHTMLElement(Selections[0]);
    with AlignData do
      for I := 0 to Selections.Count - 1 do
      begin
        Control := IHTMLElement(Selections[I]);
        ALeft := Control.offsetLeft;
        ATop := Control.offsetTop;
        AWidth := Control.offsetWidth;
        AHeight := Control.offsetHeight;
        case AHorzAlign of
          cxWebDsgnTypes.haLeft:
            ALeft := FirstControl.offsetLeft;
          cxWebDsgnTypes.haCenter:
            ALeft := FirstControl.offsetLeft - (AWidth - CenterWidth) div 2;
          cxWebDsgnTypes.haRight:
            ALeft := (FirstControl.offsetLeft + FirstControl.offsetWidth) - AWidth;
          cxWebDsgnTypes.haSpace:
          begin
            Index := IndexOfElement(HorzSortedList, Control);
            if (Index > 0) and (Index <> HorzSortedList.Count - 1) then
              ALeft := MostLeft + HorzDistance * Index;
          end;
          cxWebDsgnTypes.haWinCenter:
            ALeft := (ParentWidth - AWidth) div 2;
          end;
        case AVertAlign of
          cxWebDsgnTypes.vaTop:
            ATop := FirstControl.offsetTop;
          cxWebDsgnTypes.vaCenter:
            ATop := FirstControl.offsetTop - (AHeight - CenterHeight) div 2;
          cxWebDsgnTypes.vaBottom:
            ATop := (FirstControl.offsetTop + FirstControl.offsetHeight) - AHeight;
          cxWebDsgnTypes.vaSpace:
          begin
            Index := IndexOfElement(VertSortedList, Control);
            if (Index > 0) and (Index <> VertSortedList.Count - 1) then
              ATop := MostTop + VertDistance * Index;
          end;
          cxWebDsgnTypes.vaWinCenter:
            ATop := (ParentHeight - AHeight) div 2;
          end;
        Control.style.setAttribute('left', ALeft, 0);
        Control.style.setAttribute('top', ATop, 0);
      end;
  end;

  procedure FreeList(AList: TList);
  var
    I: Integer;
  begin
    if AList = nil then Exit;
    for I := 0 to AList.Count - 1 do
      IInterface(AList[I])._Release;
    AList.Free;
  end;

begin
  if PositioningType = cxptFlow then Exit;
  if (AHorzAlign = haNothing) and (AVertAlign = vaNothing) or
    (SelectionCount = 0) then Exit;
  with FDesignerControl do
  begin
    UndoManager.BeginUndoBlock(scxCmdAlign);
    Selections := TInterfaceList.Create;
    FillChar(AlignData, SizeOf(TcxAlignData), 0);
    try
      CalcAlignData;
      PlaceControls;
      DHTMLControlBoundsRectChanged(True);
    finally
      FreeList(AlignData.HorzSortedList);
      FreeList(AlignData.VertSortedList);
      UndoManager.EndUndoBlock;
    end;
  end;
end;

procedure TcxWebHTMLDesigner.SizeSelection(AHorzAffect: TcxSizeAffect; AVertAffect: TcxSizeAffect;
    AHorzAbsolute: Integer; AVertAbsolute: Integer);
var
  I, AWidth, AHeight: Integer;
  ACurrentWidth, ACurrentHeight: Integer;
begin
  if (AHorzAffect = saNothing) and (AVertAffect = saNothing) then
    Exit;
  with FDesignerControl do
  begin
    UndoManager.BeginUndoBlock(scxCmdResize);
    try
      AWidth := -1;
      AHeight := -1;
      if (AHorzAffect in [saShrink, saGrow]) or (AVertAffect in [saShrink, saGrow]) then
        for I := 0 to Selection.Count - 1 do
        begin
          if AHorzAffect in [saGrow, saShrink] then
          begin
            ACurrentWidth := Selection[I].offsetWidth;
            case AHorzAffect of
              saShrink:
                if (ACurrentWidth < AWidth) or (AWidth = -1) then AWidth := ACurrentWidth;
              saGrow:
                if ACurrentWidth > AWidth then AWidth := ACurrentWidth;
            end;
          end;
          if AVertAffect in [saGrow, saShrink] then
          begin
            ACurrentHeight :=  Selection[I].offsetHeight;
            case AVertAffect of
              saShrink:
                if (ACurrentHeight < AHeight) or (AHeight = -1) then AHeight := ACurrentHeight;
              saGrow:
                if ACurrentHeight > AHeight then AHeight := ACurrentHeight;
            end;
          end;
        end;
      if AHorzAffect = saAbsolute then AWidth := AHorzAbsolute;
      if AVertAffect = saAbsolute then AHeight := AVertAbsolute;
      for I := 0 to Selection.Count - 1 do
      begin
        Selection[I].style.setAttribute('width', AWidth, 0);
        Selection[I].style.setAttribute('height', AHeight, 0);
      end;
      DHTMLControlBoundsRectChanged(False);
    finally
      UndoManager.EndUndoBlock;
    end;
  end;
end;

procedure TcxWebHTMLDesigner.AlignToGrid;

  procedure AlignControlToGrid(AControl: IHTMLElement);
  var
    C: Integer;
  begin
    if not SameText((AControl as IHTMLElement2).currentStyle.position, 'static') then // Do not localize
    begin
      C := AControl.offsetTop + GridSizeY div 2;
      AControl.style.setAttribute('top', GridSizeY * (C div GridSizeY), 0);
      C := AControl.offsetLeft + GridSizeX div 2;
      AControl.style.setAttribute('left', GridSizeX * (C div GridSizeX), 0);
    end;
  end;

var
  I: Integer;
begin
  with FDesignerControl do
  begin
    UndoManager.BeginUndoBlock(scxCmdAlign);
    try
      for I := 0 to Selection.Count - 1 do
        AlignControlToGrid(Selection[I]);
      DHTMLControlBoundsRectChanged(True);
    finally
      UndoManager.EndUndoBlock;
    end;
  end;
end;

function TcxWebHTMLDesigner.ShowTabOrderSelectionDlg: Boolean;
var
  Container: IcxWebContainerControl;
  Data: TcxTabOrderDlgData;
begin
  if FDesignerControl.Selection.Count = 1 then
    Supports(GetComponentByHTMLElement(Root, FDesignerControl.Selection[0]),
      IcxWebContainerControl, Container);
  if Container = nil then
    Supports(Root, IcxWebContainerControl, Container);
  if Container <> nil then
  begin
    FillChar(Data, SizeOf(TcxTabOrderDlgData), 0);
    Data.Controls := TList.Create;
    try
      Container.GetTabOrderList(Data.Controls);
      Result := cxShowTabOrderDialog(@Data);
      if Result then
      begin
        Container.SetTabOrderList(Data.Controls);
        DelphiDesigner.Modified;
      end;
    finally
      Data.Controls.Free;
    end;
  end
  else
    Result := False; 
end;

function TcxWebHTMLDesigner.CanSelect(const AControl: TComponent): Boolean;
begin
  Result := True;
end;

procedure TcxWebHTMLDesigner.CopySelection;
begin
  if CanCopy then
    DoCopy;
end;

procedure TcxWebHTMLDesigner.CutSelection;
begin
  if CanCut then
  begin
    CopySelection;
    DeleteSelection;
  end;
end;

procedure TcxWebHTMLDesigner.DeleteSelection;
var
  I: Integer;
  AList: IDesignerSelections;
  AComponentList: TList;
  Element: IHTMLElement;
begin
  if SelectionCount = 0 then
  begin
    FDesignerControl.Selection.Delete;
    exit;
  end;

  AList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(AList);

  if AList.Count > 0 then
  begin
    BeginUpdate;
    AComponentList := TList.Create;
    try
      for I := 0 to AList.Count - 1 do
        if AList[I] is TcxWebHTMLElementMapper then
        begin
          Element := TcxWebHTMLElementMapper(AList[I]).Element;
          if Element <> nil then
            (Element as IHTMLDOMNode).removeNode(True);
        end
        else
          if AList[I] is TComponent then
            AComponentList.Add(AList[I]);
      FreeComponents(AComponentList, False);
      DelphiDesigner.DeleteSelection(True);
      ClearSelection;
    finally
      AComponentList.Free;
      EndUpdate;
    end;
  end;
end;

procedure TcxWebHTMLDesigner.Edit(AComponent: TComponent);
begin
end;

procedure TcxWebHTMLDesigner.GetSelections(const AList: TList);
var
  ASelList: IDesignerSelections;
  I: Integer;
begin
  ASelList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(ASelList);
  for I := 0 to ASelList.Count - 1 do
    AList.Add(ASelList.Items[I]);
end;

procedure TcxWebHTMLDesigner.PasteSelection;
begin
  BeginUpdate;
  try
    DoPaste;
  finally
    EndUpdate;
  end;
end;

procedure TcxWebHTMLDesigner.SelectAll;
begin
  if CanSelectAll then DoSelectAll;
end;

procedure TcxWebHTMLDesigner.SelectionChanged(const AList: TList);

  procedure RemoveHTMLSelectedControls;
  var
    I: Integer;
  begin
    I := 0;
    while I < FHTMLSelectedControls.Count do
    begin
      if AList.IndexOf(FHTMLSelectedControls[I]) > -1 then
        Inc(I)
      else
      begin
       TcxWebHTMLElementMapper(FHTMLSelectedControls[I]).Free;
       FHTMLSelectedControls.Delete(I);
      end;
    end;
  end;

  procedure RemoveElementsFromSelection;

    function HasElement(AElement: IHTMLElement): Boolean;
    var
      I: Integer;
    begin
      Result := False;
      for I := 0 to AList.Count - 1 do
        if (TPersistent(AList[I]) is TComponent) and
          Supports(TPersistent(AList[I]), IcxWebControl) then
        begin
          if  AElement = GetHTMLElementByComponentName(FDesignerControl.Document3, TComponent(AList[I]).Name) then
          begin
            Result := True;
            break;
          end;
        end else
          if (TPersistent(AList[I]) is TcxWebHTMLElementMapper) and
            (AElement = TcxWebHTMLElementMapper(AList[I]).Element) then
          begin
            Result := True;
            break;
          end;
    end;

  var
    I: Integer;
    AElementList: IInterfaceList;
    AElement: IHTMLElement;
  begin
    AElementList := TInterfaceList.Create;
    for I := 0 to FDesignerControl.Selection.Count - 1 do
    begin
      AElement := FDesignerControl.Selection[I];
      if (AElement <> nil) and not HasElement(AElement) then
        AElementList.Add(AElement);
    end;
    for I := 0 to AElementList.Count - 1 do
      FDesignerControl.Selection.Remove(AElementList[I] as IHTMLElement);
  end;

  procedure SelectWebControls;
  var
    I: Integer;
    AHTMLElement: IHTMLElement;
  begin
    for I := 0 to AList.Count - 1 do
      if (TPersistent(AList[I]) is TComponent) and
        Supports(TPersistent(AList[I]), IcxWebControl) then
      begin
        AHTMLElement := GetHTMLElementByComponentName(FDesignerControl.Document3, TComponent(AList[I]).Name);
        if AHTMLElement <> nil then
          FDesignerControl.Selection.Add(AHTMLElement);
      end;
  end;

  procedure SelectHTMLElements;
  var
    I: Integer;
  begin
    for I := 0 to FHTMLSelectedControls.Count - 1 do
    begin
      if Supports(TcxWebHTMLElementMapper(FHTMLSelectedControls[I]).Element, IHTMLControlElement) then
        FDesignerControl.Selection.Add(TcxWebHTMLElementMapper(FHTMLSelectedControls[I]).Element);
    end;
  end;

begin
  if not FHasHTMLLoaded then exit;
  if UpdateCount <> 0 then exit;
  BeginUpdate;
  try
    FDesignerControl.Wait;
    RemoveHTMLSelectedControls;
    RemoveElementsFromSelection;
    SelectWebControls;
    SelectHTMLElements;
  finally
    CancelUpdate;
  end;    
end;

procedure TcxWebHTMLDesigner.Undo;
begin
  FUndo.Undo;
end;

procedure TcxWebHTMLDesigner.IDEDesignerOptionsChagned;
begin
  FDesignerControl.SetupControl;
end;

function TcxWebHTMLDesigner.GetHTMLTemplateModified(var AFileName, AText: string): Boolean;
begin
  if (FHTMLSource <> nil) and
    (FHTMLSource.FSourceEditor <> nil) and
    (FHTMLSource.FSourceEditor.Modified
     or not FileExists(FHTMLSource.FSourceEditor.FileName)) then
  begin
    Result := True;
    AFileName := FHTMLSource.FSourceEditor.FileName;
    AText := FHTMLSource.HTML;
  end
  else Result := inherited GetHTMLTemplateModified(AFileName, AText);
end;

procedure TcxWebHTMLDesigner.HTMLElementCreated(ABaseHTMLElement: TcxBaseHTMLElement);
var
  R: TRect;
begin
  FInsertingComponent := ABaseHTMLElement;
  try
    R.Left :=  FDesignerControl.ClientWidth  div 2;
    R.Right := R.Left;
    R.Top := FDesignerControl.ClientHeight div 2;
    R.Bottom := R.Top;
    FDesignerControl.DoInsert(nil, R);
  finally
    FInsertingComponent := nil;
  end;
end;

function TcxWebHTMLDesigner.GetHTMLElementFileName: string;
var
  AIntfFileName, AFormFileName: string;
begin
  DelphiDesigner.ModuleFileNames(Result, AIntfFileName, AFormFileName);
end;

procedure TcxWebHTMLDesigner.ReaderSetName(AReader: TReader;
  AComponent: TComponent; var AName: string);
var
  OldName: string;
begin
  OldName := AName;
  inherited;
  if (FChangedNames <> nil) and not SameText(OldName, AName) then
    FChangedNames.AddObject(OldName, AComponent);
end;

procedure TcxWebHTMLDesigner.DesignerActivated;
begin
  inherited DesignerActivated;
  if (FHTMLSourceEditorNotifier <> nil) and (FHTMLSourceEditorNotifier.IsModified) then
  begin
    try
      BeginUpdate;
      ShowDesignerPage;
    finally
      CancelUpdate;
    end;
    UpdateDesignerHTML(True);
  end;  
end;

procedure TcxWebHTMLDesigner.DesignerDeactivated;
begin
  FDesignerControl.DeactivateInnerHMTLElement;
end;

procedure TcxWebHTMLDesigner.PreviewShowing;
begin
  FDesignerControl.DeactivateInnerHMTLElement;
  ClearSelection;
  UpdateHTMLSource;
end;

function TcxWebHTMLDesigner.GetControlPositioningType: TcxWebPositioningType;
begin
  if GetShowingType = stDesigner then
    Result := cxptFlow
  else Result := PositioningType;  
end;

{DHTML Control events}
procedure TcxWebHTMLDesigner.DHTMLControlInsertControl(Sender: TObject; R: TRect;
        var HTML, InnerHTML: string; var ParentElement: IHTMLElement);
var
  AComponentClass: TComponentClass;

  function GetHTMLControlContext: string;
  var
    IsAbsolutePos: Boolean;
  begin
    IsAbsolutePos := PositioningType <> cxptFlow;
    if IsAbsolutePos and
      Supports(GetComponentByHTMLElement(Root, ParentElement), IcxWebControl) then
      IsAbsolutePos := False;
    Result := TcxBaseHTMLElementClass(AComponentClass).GetHTML(IsAbsolutePos, R);
    InnerHTML := TcxBaseHTMLElementClass(AComponentClass).GetInnerHTML;
  end;

  function GetEWFControlContext: string;
  var
    AComponent: TComponent;
    AWebControl: IcxWebControl;
    AContainerControl: IcxWebContainerControl;
    AParentComponent: TComponent;
    AComponentName: string;
  begin
    if FInsertingComponent = nil then
    begin
      AComponent := CreateComponent(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
      if Supports(AComponent, IcxWebControl, AWebControl) and
        ((R.Right = R.Left) or (R.Bottom = R.Top)) then
        with AWebControl.BoundsRect do
        begin
          R.Right := R.Left + Right - Left;
          R.Bottom := R.Top + Bottom - Top;
        end;
    end else AComponent := FInsertingComponent;
    if AComponent <> nil then
    begin
      if Supports(AComponent, IcxWebControl, AWebControl) then
      begin
        AWebControl.BoundsRect := R;
        if (ParentElement <> nil) then
          AParentComponent := GetComponentByHTMLElement(Root, ParentElement)
        else AParentComponent := nil;
        if AParentComponent = nil then
          AParentComponent := Root;
        if not Supports(AParentComponent, IcxWebContainerControl, AContainerControl) then
        begin
          if Supports(AParentComponent, IcxWebControl, AWebControl) then
            AContainerControl := AWebControl.Parent;
        end;
        if AContainerControl = nil then
          Supports(Root, IcxWebContainerControl, AContainerControl);
        AWebControl.Parent := AContainerControl;
      end;
      if AComponent.Name <> '' then
        AComponentName := AComponent.Name
      else AComponentName := FInsertingComponentName;
      Result := Format('<%0:s:%1:s id="%2:s"> </%0:s:%1:s>',
        [scxEWF, GetDesignerHTMLClassName(AComponent.ClassName), AComponentName]);
      InnerHTML := '';
    end;
  end;

begin
  FDesignerControl.Wait;
  if FInsertingComponent = nil then
    AComponentClass := GetCurrComponentClass
  else AComponentClass := TComponentClass(FInsertingComponent.ClassType);

  if not AComponentClass.InheritsFrom(TcxBaseHTMLElement) and
    not Supports(AComponentClass, IcxWebControl) then
  begin
    CreateComponent(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  end
  else
  begin
    if (ParentElement = nil) or not IsHTMLCustomElement(ParentElement) then
      ParentElement := FDesignerControl.MainParentElement;
    try
      FIsComponentInserting := True;
      if AComponentClass.InheritsFrom(TcxBaseHTMLElement) then
        HTML := GetHTMLControlContext
      else begin
        HTML := GetEWFControlContext;
      end;
    finally
      FIsComponentInserting := False;
    end;
  end;
end;

procedure TcxWebHTMLDesigner.DHTMLControlInsertedControl(Sender: TObject; Element: IHTMLElement);
var
  AComponentClass: TComponentClass;
  AComponent: TComponent;
  AStyle2: IHTMLStyle2;
  AWebControl: IcxWebControl;
begin
  if Element = nil then exit;
  if FInsertingComponent <> nil then
    AComponent := FInsertingComponent
  else AComponent := GetComponentByHTMLElement(Root, Element);
  if (AComponent <> nil) and Supports(AComponent, IcxWebControl, AWebControl) then
  begin
    if PositioningType <> cxptFlow then
    begin
      if (GetComponentByInterface(AWebControl.Parent) = Root) and
        Supports(Element.style, IHTMLStyle2, AStyle2) then
        AStyle2.position := 'absolute';
    end;
    if (AWebControl.DesignerControl <> nil) then
      AWebControl.DesignerControl.BoundsChanged;
  end;
  if FInsertingComponent = nil then
    AComponentClass := GetCurrComponentClass
  else AComponentClass := TComponentClass(FInsertingComponent.ClassType);
  if (AComponentClass <> nil) and AComponentClass.InheritsFrom(TcxBaseHTMLElement) then
    TcxBaseHTMLElementClass(AComponentClass).AfterElementCreated(Element);
  if (AComponentClass <> nil) and (ActiveDesigner.Environment <> nil) then
    ActiveDesigner.Environment.ResetCompClass;
  FDesignerControl.Selection.Clear;
  FDesignerControl.Selection.Add(Element);
  InternalDHTMLControlSelectionChanged;
end;

procedure TcxWebHTMLDesigner.DHTMLControlGetContext(AElement: IHTMLElement;
  var AContent, ACSSContent, AInlineStyle: string);
var
  AComponent: TComponent;
  AWebControl: IcxWebControl;
begin
  AComponent := GetComponentByHTMLElement(Root, AElement);
  if (AComponent <> nil) and Supports(AComponent, IcxWebControl, AWebControl) then
  begin
    InsertWebDesignControl(AWebControl);
    AContent := GetDesignInnerHTMLByWebControl(AComponent);
    ACSSContent := GetDesignStyleByWebControl(AComponent);
    AInlineStyle := GetDesignInlineStyleByWebControl(AComponent);
  end else
  begin
    AContent := '';
    ACSSContent := '';
    AInlineStyle := '';
  end;
end;

procedure TcxWebHTMLDesigner.DHTMLControlParentChanged(ASender: TObject; ANewParent: IHTMLElement);
var
  AParentControl: IcxWebContainerControl;
  AParentComponent, AComponent: TComponent;
  AWebControl: IcxWebControl;
  I: Integer;
  AElements: IInterfaceList;
begin
  AParentComponent := nil;
  while (AParentComponent = nil) and (ANewParent <> nil) do
  begin
    AParentComponent := GetComponentByHTMLElement(Root, ANewParent);
    ANewParent := ANewParent.parentElement;
  end;
  AParentControl := nil;
  if (AParentComponent <> nil) and Supports(AParentComponent, IcxWebControl, AWebControl) then
    if not Supports(AParentComponent, IcxWebContainerControl, AParentControl) then
      AParentControl := AWebControl.Parent;
  if AParentControl = nil then
    AParentControl := Root as IcxWebContainerControl;

  AElements := TInterfaceList.Create;
  for I := 0 to FDesignerControl.Selection.Count - 1 do
    if FDesignerControl.Selection[I] <> nil then
      AElements.Add(FDesignerControl.Selection[I]);

  for I := 0 to AElements.Count - 1 do
  begin
    AComponent  := GetComponentByHTMLElement(Root, AElements[I] as IHTMLElement);
    if (PositioningType = cxptFlow) or  Supports(AParentControl, IcxWebControl) then
      (AElements[I] as IHTMLElement).style.removeAttribute('position', 0)
    else (AElements[I] as IHTMLElement).style.setAttribute('position', 'absolute', 0);
    if Supports(AComponent, IcxWebControl) then
      (AComponent as IcxWebControl).Parent := AParentControl;
  end;
end;

procedure TcxWebHTMLDesigner.ClearHTMLSelectedControls;
var
  I: Integer;
begin
  if FHTMLSelectedControls.Count = 0 then exit;
  for I := 0 to FHTMLSelectedControls.Count - 1 do
    TcxWebHTMLElementMapper(FHTMLSelectedControls[I]).Free;
  FHTMLSelectedControls.Clear;
end;

procedure TcxWebHTMLDesigner.ClearSelection;
var
  AList: IDesignerSelections;
begin
  BeginUpdate;
  try
    AList := TDesignerSelections.Create;
    AList.Add(Root);
    DelphiDesigner.SetSelections(AList);
    ClearHTMLSelectedControls;
    FDesignerControl.Selection.Clear;
  finally
    EndUpdate;
  end;
end;

procedure TcxWebHTMLDesigner.CreateHTMLSelectedControls;
var
  I: Integer;
  AList: IDesignerSelections;
  AHTMLElement: IHTMLElement;
  AComponent: TComponent;
begin
  FDesignerControl.Wait;
  AList := TDesignerSelections.Create;
  for I := 0 to FDesignerControl.Selection.Count - 1 do
  begin
    AHTMLElement := FDesignerControl.Selection[I];
    AComponent := GetComponentByHTMLElement(Root, AHTMLElement);
    if (AComponent = nil) and (AHTMLElement <> nil) then
    begin
      FHTMLSelectedControls.Add(WebHTMLElementMapperManager.CreateElementMapper(AHTMLElement));
      TcxWebHTMLElementMapper(FHTMLSelectedControls.Last).onElementChanged := DoMapperElementChanged;
      AList.Add(TPersistent(FHTMLSelectedControls.Last));
    end else AList.Add(AComponent);
  end;
  if AList.Count > 0 then
    DelphiDesigner.NoSelection;
  DelphiDesigner.SetSelections(AList);
end;

function TcxWebHTMLDesigner.SelectionCount: Integer;
var
  AList: IDesignerSelections;
begin
  AList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(AList);
  if (AList.Count = 1) and (AList.Items[0] = Root) then
    Result := 0
  else
    Result := AList.Count;
end;

function TcxWebHTMLDesigner.IsComponentSelected: Boolean;
var
  AList: IDesignerSelections;
  I: Integer;
begin
  Result := False;
  AList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(AList);
  for I := 0 to AList.Count - 1 do
    if (AList.Items[I] is TComponent) and
      not Supports(AList.Items[I], IcxWebControl) then
    begin
      Result := True;
      break;
    end
end;

procedure TcxWebHTMLDesigner.InternalDHTMLControlSelectionChanged;

  function IsSelectionTheSame: Boolean;
  var
    I: Integer;
    AList: IDesignerSelections;
    AHTMLElement: IHTMLElement;
  begin
    AList := TDesignerSelections.Create;
    DelphiDesigner.GetSelections(AList);
    Result := FDesignerControl.Selection.Count = AList.Count;
    if (FDesignerControl.Selection.Count = 0) and (AList.Count = 1) and (AList.Items[0] = Root) then
    begin
      Result := True;
      exit;
    end; 
    if not Result then exit;
    if (FDesignerControl.Selection.Count = 1) and (FDesignerControl.Selection[0] = nil)
    and (AList.Items[0] = Root) then exit;
    for I := 0 to AList.Count - 1 do
    begin
      if (AList.Items[I] is TcxWebHTMLElementMapper) then
        AHTMLElement := TcxWebHTMLElementMapper(AList.Items[I]).Element
      else
        if (AList.Items[I] is TComponent) then
          AHTMLElement := GetHTMLElementByComponentName(FDesignerControl.Document3,
                                        TComponent(AList.Items[I]).Name)
        else AHTMLElement := nil;
      Result := FDesignerControl.Selection.IndexOf(AHTMLElement) <> -1;
      if not Result then
        break;
    end;
  end;

begin
  if (UpdateCount <> 0) or IsSelectionTheSame then exit;
  BeginUpdate;
  try
    ClearHTMLSelectedControls;
    CreateHTMLSelectedControls;
  finally
    CancelUpdate;
  end;
end;

procedure TcxWebHTMLDesigner.DHTMLControlSelectionChanged(Sender: TObject);
begin
  InternalDHTMLControlSelectionChanged;
end;

procedure TcxWebHTMLDesigner.DHTMLControlMoved(Sender: TObject);
begin
  DHTMLControlBoundsRectChanged(True);
end;

procedure TcxWebHTMLDesigner.DHTMLControlResized(Sender: TObject);
begin
  DHTMLControlBoundsRectChanged(False);
end;

procedure TcxWebHTMLDesigner.DoEditorFormActivated(Sender: TObject);
begin
  if not FHasHTMLLoaded then exit;
  UpdateHTMLSource;
end;

procedure TcxWebHTMLDesigner.DHTMLControlContextMenu(ASender: TObject; APos: TPoint;
  AElement: IHTMLElement);
const
  Filters: array[Boolean] of TcxLocalMenuFilters = ([], [cxlmComponent]);
var
  AList: IDesignerSelections;
begin
  AList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(AList);
  InvokeLocalMenuAtCursor(nil, Filters[AList.Count > 1]);
end;


procedure TcxWebHTMLDesigner.UpdateHTMLSource;
begin
  try
    FHTMLSaving := True;
    FDesignerControl.Wait;
    if FDesignerControl.Modified then
    begin
      FHTMLSource.HTML := FHTMLBefore +
        GetTempateHTMLFromDesigner(Root, FDesignerControl.DocumentHTML,
        FStoredTags, PositioningType) +
        FHTMLAfter;
      FHTMLSourceEditorNotifier.IsModified := False;
      FDesignerControl.Modified := False;
    end;
  finally
    FHTMLSaving := False;
  end;
end;

var
  FUpdateDesignerFailed: Boolean = False;

procedure TcxWebHTMLDesigner.UpdateDesignerHTML(ADeleteComponents: Boolean);

  function PrepareHTMLSource(const AHTML: string): string;
  var
    P: PChar;
  begin
    Result := AHTML;
    P := SearchBuf(PChar(Result), Length(Result), 0, 0, '<HTML');
    if P <> nil then
    begin
      SetString(FHTMLBefore, PChar(Result), P - PChar(Result));
      SetString(Result, P, PChar(Result) + Length(Result) - P);
    end
    else
      FHTMLBefore := '';
    P := SearchBuf(PChar(Result), Length(Result), Length(Result), 0, '</HTML>', []);
    if P <> nil then
    begin
      P := P + 7;
      SetString(FHTMLAfter, P, PChar(Result) + Length(Result) - P);
      SetString(Result, PChar(Result), P - PChar(Result));
    end
    else
      FHTMLAfter := '';
  end;

begin
  if FUpdateDesignerFailed then
  begin
    FUpdateDesignerFailed := False;
    FHTMLSource.SourceEditor.Show;
    exit;
  end;
  FUpdateDesignerFailed := True;
  FDesignerControl.OnDocumentChange := nil;
  if FHasHTMLLoaded then
    ClearSelection;
  FUndo.Clear;
  try
    FHasHTMLLoaded := False;
    FDesignerControl.DocumentHTML := GetDesignHTMLContextFromTemplate(Root,
          PrepareHTMLSource(FHTMLSource.HTML), FStoredTags, ADeleteComponents, PositioningType);
    FUpdateDesignerFailed := False;
  except
    on E: EcxWebHTMLParserException do
      FHTMLSource.ShowParserError(E.ParserError, E.ErrorStr, E.Message);
    else raise;
  end;
  if FHTMLSource.FSourceEditor <> nil then
    FDesignerControl.BaseURL := ExtractFilePath(FHTMLSource.FSourceEditor.FileName);
  IDEDesignerOptionsChagned;
  FDesignerControl.OnDocumentChange := HTMLChangeNotify;
  FHasHTMLLoaded := True;
  FHTMLSourceEditorNotifier.IsModified := False;
end;

procedure TcxWebHTMLDesigner.UpdateHTMLControlContext(AComponent: TComponent);
var
  AHTMLElement: IHTMLElement;
begin
  if not FHasHTMLLoaded or Supports(AComponent, IcxWebContainerControl) then exit;
  AHTMLElement := GetHTMLElementByComponentName(FDesignerControl.Document3, AComponent.Name);
  if AHTMLElement <> nil then
    FDesignerControl.UpdateViewLinkContent(AHTMLElement);
end;

procedure TcxWebHTMLDesigner.InsertWebDesignControl(AWebControl: IcxWebControl);
begin
  if AWebControl.DesignerControl = nil then
    AWebControl.DesignerControl := TcxWebDesignerControlNotify.Create(self, GetComponentByInterface(AWebControl));
end;

procedure TcxWebHTMLDesigner.DHTMLControlBoundsRectChanged(AIsMoved: Boolean);
var
  I: Integer;
  AComponent: TComponent;
  AWebControl: IcxWebControl;
  AHTMLElement: IHTMLElement;
  R: TRect;
  ASelectedList: IInterfaceList;
begin
  ASelectedList := TInterfaceList.Create;
  for I := 0 to FDesignerControl.Selection.Count - 1 do
    if FDesignerControl.Selection[I] <> nil then
      ASelectedList.Add(FDesignerControl.Selection[I]);
  BeginUpdate;
  try
    for I := 0 to ASelectedList.Count - 1 do
    begin
      AHTMLElement := ASelectedList[I] as IHTMLElement;
      AComponent := GetComponentByHTMLElement(Root, AHTMLElement);
      if (AComponent <> nil) and Supports(AComponent, IcxWebControl, AWebControl) then
      begin
        with AHTMLElement.style do
          if not AIsMoved then
            SetRect(R, pixelLeft, pixelTop, pixelLeft + pixelWidth, pixelTop + pixelHeight)
          else
          begin
            R := AWebControl.BoundsRect;
            OffsetRect(R, pixelLeft - R.Left, pixelTop - R.Top);
          end;
        AWebControl.BoundsRect := R;
      end;
    end;
  finally
    CancelUpdate;
  end;
  for I := 0 to ASelectedList.Count - 1 do
  begin
    AHTMLElement := ASelectedList[I] as IHTMLElement;
    AComponent := GetComponentByHTMLElement(Root, AHTMLElement);
    if (AComponent <> nil) and Supports(AComponent, IcxWebControl, AWebControl) then
    begin
      AWebControl.UpdateControlPosition;
      UpdateHTMLElementStylePositions(AHTMLElement, AWebControl);
    end;
  end;
  DelphiDesigner.Modified;
  BeginUpdate;
  try
    FDesignerControl.Selection.Empty;
    for I := 0 to ASelectedList.Count - 1 do
      if FDesignerControl.Selection.IndexOf(ASelectedList[I] as IHTMLElement) < 0 then
        FDesignerControl.Selection.Add(ASelectedList[I] as IHTMLElement);
  finally
    CancelUpdate;
  end;
end;

procedure TcxWebHTMLDesigner.DoMapperElementChanged(Sender: TObject);
begin
  if (BorlandIDEServices as IOTAModuleServices).CurrentModule <> nil then
    (BorlandIDEServices as IOTAModuleServices).CurrentModule.MarkModified;
  BeginUpdate;
  DelphiDesigner.Modified;
  EndUpdate;
end;

procedure TcxWebHTMLDesigner.HTMLChangeNotify(Sender: TObject);
begin
  if (BorlandIDEServices as IOTAModuleServices).CurrentModule <> nil then
    (BorlandIDEServices as IOTAModuleServices).CurrentModule.MarkModified;
  BeginUpdate;
  DelphiDesigner.Modified;
  EndUpdate;
  CheckForDeletedControls;
  UpdateSelectedEWFBehaviors;
end;

procedure TcxWebHTMLDesigner.FreeComponents(AList: TList; ADelete: Boolean);

  function HasParentInList(AComponent: TComponent): Boolean;
  var
    I: Integer;
    AParent: TComponent;
  begin
    Result := False;
    AParent := AComponent.GetParentComponent;
    while AParent <> nil do
    begin
      for I := 0 to AList.Count - 1 do
      begin
        if AParent = TComponent(AList[I]) then
        begin
          Result := True;
          break;
        end;
      end;
      AParent := AParent.GetParentComponent;
    end;
  end;

  procedure RemoveChildren;
  var
    I: Integer;
    AChildren: TList;
  begin
    AChildren := TList.Create;
    try
      for I := 0 to AList.Count - 1 do
        if HasParentInList(TComponent(AList[I])) then
          AChildren.Add(AList[I]);
      for I := 0 to AChildren.Count - 1 do
        AList.Remove(AChildren[I]);
    finally
      AChildren.Free;
    end;
  end;

var
  I: Integer;
  AItems: TcxWebHTMLUndoItems;
  AComponent: TComponent;
begin
  RemoveChildren;
  if AList.Count > 0 then
  begin
    AItems := FUndo.CreateNewGroup;
    for I := 0 to AList.Count - 1 do
    begin
      AComponent := TComponent(AList[I]);
      FUndo.AddDeletedComponent(AItems, AComponent);
      if ADelete or Supports(AComponent, IcxWebControl) then
        FreeAndNil(AComponent);
   end;
  end;
end;

procedure TcxWebHTMLDesigner.CheckForDeletedControls;
var
  AList: TList;
  I: Integer;
begin
  AList := TList.Create;
  for I := 0 to Root.ComponentCount - 1 do
    if Supports(Root.Components[I], IcxWebControl) and
      (GetHTMLElementByComponentName(FDesignerControl.Document3, Root.Components[I].Name) = nil) then
      AList.Add(Root.Components[I]);
  FreeComponents(AList, True);
  if AList.Count > 0 then
   try
     BeginUpdate;
     FDesignerControl.Selection.Clear;
   finally
     CancelUpdate;
   end;
  AList.Free;
end;

procedure TcxWebHTMLDesigner.UpdateSelectedEWFBehaviors;
var
  AList: IDesignerSelections;
  AElement: IHTMLElement;
  I: Integer;
begin
  AList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(AList);
  for I := 0 to AList.Count - 1 do
    if Supports(AList.Items[I], IcxWebControl) and
      (AList.Items[I] is TComponent) then
      AElement := GetHTMLElementByComponentName(FDesignerCOntrol.Document3, TComponent(AList.Items[I]).Name);
end;

procedure TcxWebHTMLDesigner.InternalInsertHTMLControl(AComponent: TComponent;
        ANewName: string; ANeedOffSet: Boolean);
var
  AWebControl: IcxWebControl;
  AParentElement: IHTMLElement;
  R: TRect;
  AParent: TComponent;
begin
  if not Supports(AComponent, IcxWebControl, AWebControl) then exit;
  try
    if ANewName = '' then
      ANewName := AComponent.Name;
    FInsertingComponentName := ANewName;
    FInsertingComponent := AComponent;
    AParentElement := nil;
    AParent := AComponent.GetParentComponent;
    if AParent <> nil then
      AParentElement := GetHTMLElementByComponentName(FDesignerCOntrol.Document3, AParent.Name);
    if AParentElement = nil then
      AParentElement := FDesignerControl.MainParentElement;
    R := AWebControl.BoundsRect;
    if ANeedOffSet then
      OffsetRect(R, (FDesignerControl.ClientWidth + R.Left -  R.Right)  div 2,
         (FDesignerControl.ClientHeight + R.Top - R.Bottom) div 2);
    FDesignerControl.DoInsert(AParentElement, R);
  finally
    FInsertingComponent := nil;
    FInsertingComponentName := '';
  end;
end;

{ Clipboard routines }
procedure EWFCopyStreamToClipboard(AComponentStream: TMemoryStream; const AHTML: string);

  procedure CopyToClipboard(Format: Word; AStream: TMemoryStream);
  var
    Handle: THandle;
    Mem: Pointer;
  begin
    Handle := GlobalAlloc(GMEM_MOVEABLE, AStream.Size);
    Mem := GlobalLock(Handle);
    Move(AStream.Memory^, Mem^, AStream.Size);
    GlobalUnlock(Handle);
    Clipboard.SetAsHandle(Format, Handle);
  end;

var
  AStream: TMemoryStream;
  I: TValueType;
  V: Integer;
begin
  Clipboard.Open;
  try
    AStream := TMemoryStream.Create;
    try
      if AComponentStream <> nil then
      begin
        AComponentStream.Position := 0;
        repeat
          AComponentStream.Read(I, SizeOf(I));
          AComponentStream.Seek(-SizeOf(I), 1);
          if I = vaNull then Break;
          ObjectBinaryToText(AComponentStream, AStream);
        until False;
      end;
      if AHTML <> '' then
        AStream.WriteBuffer(PChar(AHTML)^, Length(AHTML));
      V := 0;
      AStream.Write(V, 1);
      CopyToClipboard(CF_TEXT, AStream);
    finally
      AStream.Free;
    end;
  finally
    Clipboard.Close;
  end;
end;

function EWFGetClipboardStream(var AHTML: string): TMemoryStream;
var
  S, T: TMemoryStream;
  Handle: THandle;
  Mem: Pointer;
  Format: Word;
  V: TValueType;
  ALength: Integer;

  function AnotherObject(S: TStream): Boolean;
  var
    Buffer: array[0..255] of Char;
    Position: Integer;
  begin
    Position := S.Position;
    Buffer[S.Read(Buffer, SizeOf(Buffer))-1] := #0;
    S.Position := Position;
    Result := PossibleStream(Buffer);
  end;

begin
  AHTML := '';
  Result := TMemoryStream.Create;
  try
    if Clipboard.HasFormat(CF_COMPONENTS) then
      Format := CF_COMPONENTS else
      Format := CF_TEXT;
    Clipboard.Open;
    try
      Handle := Clipboard.GetAsHandle(Format);
      Mem := GlobalLock(Handle);
      try
        Result.Write(Mem^, GlobalSize(Handle));
      finally
        GlobalUnlock(Handle);
      end;
    finally
      Clipboard.Close;
    end;
    Result.Position := 0;
    if Format = CF_TEXT then
    begin
      S := TMemoryStream.Create;
      try
        while AnotherObject(Result) do ObjectTextToBinary(Result, S);
        if Result.Position < Result.Size - 1 then
        begin
          ALength :=  Result.Size - Result.Position;
          SetLength(AHTML, ALength);
          Result.ReadBuffer(AHTML[1], ALength);
        end;
        V := vaNull;
        S.Write(V, SizeOf(V));
        T := Result;
        Result := nil;
        T.Free;
      except
        S.Free;
        raise;
      end;
      Result := S;
      Result.Position := 0;
    end;
  except
    Result.Free;
    raise;
  end;
end;

const
  EWFHTMLSign = 'EWF_HTML';

procedure TcxWebHTMLDesigner.ReadComponent(AComponent: TComponent);
begin
  FClipboardSelection.Add(AComponent);
end;

procedure TcxWebHTMLDesigner.DoPaste;
var
  SaveElements: IInterfaceList;

  procedure UpdateSelection;
  var
    I: Integer;
    AList: IDesignerSelections;
    AWebControl: IcxWebControl;
  begin
    if FClipboardSelection.Count = 0 then exit;
    AList := TDesignerSelections.Create;
    for I := 0 to FClipboardSelection.Count - 1 do
    begin
      AList.Add(TComponent(FClipboardSelection[I]));
      if Supports(TComponent(FClipboardSelection[I]), IcxWebControl, AWebControl) and
        (AWebControl.DesignerControl <> nil) then
        AWebControl.DesignerControl.UpdateContext;
      FDesignerControl.Selection.Add(GetHTMLElementByComponentName(FDesignerControl.Document3,
        TComponent(FClipboardSelection[I]).Name));
    end;
    DelphiDesigner.SetSelections(AList);
  end;

  function FindNewElementByName(const AName: string): IHTMLElement;

    function IsElementInList(AList: IInterfaceList; AElement: IHTMLElement): Boolean;
    var
      I: Integer;
    begin
      Result := False;
      for I := 0 to AList.Count - 1 do
        if IsEqualElement(AList[I] as IHTMLElement, AElement) then
        begin
          Result := True;
          break;
        end;
    end;

  var
    Elements: IHTMLElementCollection;
    I: Integer;
  begin
    Result := nil;
    Elements := FDesignerControl.Document3.getElementsByName(AName);
    for I := 0 to Elements.length - 1 do
      if not IsElementInList(SaveElements, Elements.item(I, 0) as IHTMLElement) then
        begin
          Result := Elements.item(I, 0) as IHTMLElement;
          break;
        end;
  end;

  procedure CreateDesignerControls;
  var
    I, Idx: Integer;
    AList: IInterfaceList;
    AFoundElement: IHTMLElement;
    ASelectedList: IDesignerSelections;
    AComponent: TComponent;
    AParentControl: IcxWebContainerControl;
  begin
    AParentControl := nil;
    if (SelectionCount > 0) then
    begin
      ASelectedList := TDesignerSelections.Create;
      DelphiDesigner.GetSelections(ASelectedList);
      if (ASelectedList.Count = 1) and (ASelectedList.Items[0] <> Root) then
        Supports(ASelectedList.Items[0], IcxWebContainerControl, AParentControl);
    end;
    AList := CreateControlList;
    for I := 0 to AList.Count - 1 do
    begin
      AComponent := GetComponentByInterface(AList[I]);
      if (AComponent <> nil) and
        (GetHTMLElementByComponentName(FDesignerControl.Document3, AComponent.Name) = nil) then
      begin
        Idx := FChangedNames.IndexOfObject(AComponent);
        if Idx >= 0 then
        begin
          AFoundElement := FindNewElementByName(FChangedNames.Strings[Idx]);
          if AFoundElement <> nil then
            AFoundElement.id := AComponent.Name
          else
            InternalInsertHTMLControl(AComponent, '', False);
          FChangedNames.Delete(Idx);
        end
        else
          InternalInsertHTMLControl(AComponent, '', False);
        if AParentControl <> nil then
          IcxWebControl(AList[I]).Parent := AParentControl;
      end;
    end;
  end;

var
  AStream: TStream;
  AReader: TReader;
  AHTML: string;
  ParentElement, Element: IHTMLElement;
  I: Integer;
begin
  AStream := EWFGetClipboardStream(AHTML);
  SaveElements := TInterfaceList.Create;
  for I := 0 to Root.ComponentCount - 1 do
  begin
    Element := GetHTMLElementByComponentName(FDesignerControl.Document3, Root.Components[I].Name);
    if Element <> nil then
      SaveElements.Add(Element);
  end;
  if AHTML <> '' then
  begin
    if Pos(EWFHTMLSign, AHTML) = 1 then
    begin
      AHTML := Copy(AHTML, Length(EWFHTMLSign) + 1, Length(AHTML));
      ParentElement := nil;
      if (FDesignerControl.Selection.Count = 1) and
        Supports(FDesignerControl.Selection[0], IHTMLTextContainer) then
        ParentElement := FDesignerControl.Selection[0];
      if ParentElement = nil then
        ParentElement := FDesignerControl.MainParentElement;
      ParentElement.insertAdjacentHTML('beforeEnd', AHTML);
    end
    else
      FDesignerControl.Selection.Paste;
    FDesignerControl.Wait;
  end;
  if AStream.Size > 1 then
    try
      AReader := TReader.Create(AStream, 1024);
      FClipboardSelection := TList.Create;
      try
        FChangedNames := TStringList.Create;
        AReader.OnSetName := ReaderSetName;
        AReader.OnFindMethod := ReaderFindMethod;
        AReader.Parent := Root;
        AReader.ReadComponents(Root, Root, ReadComponent);
        CreateDesignerControls;
        if PositioningType = cxptGrid then
          UpdateControlsPosition;
        UpdateSelection;
      finally
        AReader.Free;
        FClipboardSelection.Free;
        FreeAndNil(FChangedNames);
      end;
    finally
      AStream.Free;
    end;
end;

procedure TcxWebHTMLDesigner.DoCopy;
var
  AStream: TMemoryStream;
  AHTML: String;

  procedure WriteSelectedComponents;
  var
    AList: IDesignerSelections;

    function IsNotChild(AComponent: TComponent): Boolean;
    var
      I: Integer;
    begin
      Result := True;
      for I := 0 to AList.Count - 1 do
        if (AList.Items[I] is TComponent) and (AList.Items[I] <> AComponent) and
          (TComponent(AList.Items[I]) = AComponent.GetParentComponent) then
        begin
          Result := False;
          break;
        end;
    end;

    function NotInList(AComponent: TComponent): Boolean;
    var
      I: Integer;
    begin
      Result := True;
      for I := 0 to AList.Count - 1 do
        if (AList[I] is TComponent) and (TComponent(AList[I]) = AComponent) then
        begin
          Result := False;
          break;
        end;
    end;

  var
    V: Integer;
    AWriter: TWriter;
    I, J: Integer;
    Elements: IHTMLElementCollection;
    WebComp: TComponent;
  begin
    AList := TDesignerSelections.Create;
    DelphiDesigner.GetSelections(AList);
    if AList.Count > 0 then
    begin
      for I := 0 to FDesignerControl.Selection.Count - 1 do
      begin
        Elements := FDesignerControl.Selection[I].all as IHTMLElementCollection;
        for J := 0 to Elements.length - 1 do
        begin
          WebComp := GetComponentByHTMLElement(Root, Elements.item(J, 0) as IHTMLElement);
          if (WebComp <> nil) and NotInList(WebComp) then
            AList.Add(WebComp);
        end;
      end;
      AWriter := TWriter.Create(AStream, 4096);
      try
        AWriter.Root := DelphiDesigner.Root;
        for I := 0 to AList.Count - 1 do
          if (AList.Items[I] is TComponent) and
            (AList.Items[I] <> Root) and IsNotChild(TComponent(AList.Items[I])) then
          begin
            AWriter.WriteSignature;
            AWriter.WriteComponent(TComponent(AList.Items[I]));
          end;
      finally
        AWriter.WriteListEnd;
        AWriter.Free;
      end;
      if AStream.Size > 0 then
      begin
        V := 0;
        AStream.Write(V, 1);
      end;
    end;
  end;

  procedure GetHTMLText;
  var
    AList: IDesignerSelections;
    I: Integer;
  begin
    AHTML := '';
    AList := TDesignerSelections.Create;
    DelphiDesigner.GetSelections(AList);
    for I := 0 to AList.Count - 1 do
      if (AList.Items[I] is TcxWebHTMLElementMapper) then
        AHTML := AHTML + TcxWebHTMLElementMapper(AList.Items[I]).Element.outerHTML;
    if AHTML <> '' then
      AHTML := EWFHTMLSign + AHTML;
  end;

begin
  if SelectionCount = 0 then
    FDesignerControl.Selection.Copy
  else
  begin
    AStream := TMemoryStream.Create;
    try
      WriteSelectedComponents;
      GetHTMLText;
      if AStream.Size > 0 then
        EWFCopyStreamToClipboard(AStream, AHTML)
      else
        EWFCopyStreamToClipboard(nil, AHTML);
    finally
      AStream.Free;
    end;
  end;
end;


type
 PTransBuffer = ^TTransBuffer;
 TTransBuffer = array[0..1] of SmallInt;

function GetIEVerInfo: string;
const
  AFileName = 'mshtml';
  AProductName = 'ProductVersion';
var
  i:        integer;
  AInfoSize, AVerSize, dummy: DWORD;
  ptrans:   PTransBuffer;
  typeStr:  string;
  value:    PChar;
  AVerBuf:   pointer;
begin
  Result := '';
  AInfoSize := GetFileVersioninfoSize(AFileName, dummy);
  if AInfoSize <> 0 then
  begin
    GetMem(AVerBuf, AInfoSize);
    try
      if GetFileVersionInfo(AFileName, 0, AInfoSize, AVerBuf) then
      begin
        VerQueryvalue(AVerBuf, '\VarFileInfo\Translation',
                      Pointer(ptrans), AInfoSize);

        for I := 0 to AInfoSize div SizeOf(TTransBuffer) do
        begin
          typeStr := 'StringFileInfo\' + IntToHex(ptrans^[0], 4) + IntToHex(ptrans^[1], 4) + '\' + AProductName;
          if VerQueryvalue(AVerBuf, PChar(typeStr),  Pointer(value), AVerSize) then
          begin
            Result := Value;
            break;
          end;
          ptrans := PTransBuffer(Integer(ptrans) + SizeOf(TTransBuffer));
        end;
      end;
    finally
      FreeMem(AVerBuf);
    end;
  end;
end;

function IsIE5_5: Boolean;
var
  AVerInfo: string;

  function GetNextDigit: Integer;
  var
    ASt: string;
    I: Integer;
  begin
    Result := 0;
    if Pos('.', AVerInfo) > 0 then
    begin
      ASt := Copy(AVerInfo, 1, Pos('.', AVerInfo) - 1);
      AVerInfo := Copy(AVerInfo, Pos('.', AVerInfo) + 1, Length(AVerInfo));
    end else
    begin
      ASt := AVerInfo;
      AVerInfo := '';
    end;
    if (ASt <> '') then
    begin
      for I := 1 to Length(ASt) do
        if not (ASt[I] in ['0'..'9']) then
          exit;
      Result := StrToInt(ASt);    
    end;
  end;
var
  AVerNumber: Integer;
begin
  Result := False;
  AVerInfo := GetIEVerInfo;
  if AVerInfo <> '' then
  begin
    AVerNumber := GetNextDigit;
    cxWebHTMLDesignerMajorVersion := AVerNumber;
    Result := AVerNumber > 4;
    if Result and (AVerNumber = 5) then
      Result :=GetNextDigit > 4;
  end;
end;

initialization
  if IsIE5_5 then
    WebDesignerFactory.RegisterDesigner(TcxWebHTMLDesigner, True);

finalization
  WebDesignerFactory.UnregisterDesigner(TcxWebHTMLDesigner);

end.
