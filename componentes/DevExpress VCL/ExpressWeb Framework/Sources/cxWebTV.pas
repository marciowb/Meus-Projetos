{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Controls Library                                 }
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
unit cxWebTV;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, TypInfo,
  cxWebRender, cxWebClasses, cxWebControls, cxWebImgList,
  cxWebMenus, cxWebTypes, cxWebIntf;

type
  TcxWebTreeView = class;

  TcxWebTreeItem = class(TPersistent)
  private
    FData: Pointer;
    FExpanded: Boolean;
    FHint: string;
    FImageIndex: Integer;
    FList: TList;
    FName: string;
    FOwner: TcxWebTreeView;
    FParent: TcxWebTreeItem;
    FText: string;
    FURL: TcxURL;

    function GetCount: Integer;
    function GetHasChildren: Boolean;
    function GetIndex: Integer;
    function GetItem(Index: Integer): TcxWebTreeItem;
    function GetLevel: Integer;
    function GetText: string;
    procedure SetExpanded(Value: Boolean);
    procedure SetName(const Value: string);
    procedure SetText(const Value: string);
    procedure SetURL(Value: TcxURL);

    function DoCanExpand(Expand: Boolean): Boolean;
    procedure DoExpand(Expand: Boolean);
    procedure ExpandItem(Expand: Boolean; Recurse: Boolean);
    function GenerateName(Unique: Boolean): string;
  protected
    procedure ApplySorting(SortChildren: Boolean); virtual;
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  public
    constructor Create(AOwner: TcxWebTreeView);
    destructor Destroy; override;

    function AddChild: TcxWebTreeItem;
    procedure Collapse(ARecurse: Boolean);
    procedure DeleteChildren;
    procedure Expand(ARecurse: Boolean);
    function IndexOf(Value: TcxWebTreeItem): Integer;
    function InsertChild(BeforeItem: TcxWebTreeItem): TcxWebTreeItem;

    property Count: Integer read GetCount;
    property Data: Pointer read FData write FData;
    property HasChildren: Boolean read GetHasChildren;
    property Index: Integer read GetIndex;
    property Items[Index: Integer]: TcxWebTreeItem read GetItem; default;
    property Level: Integer read GetLevel;
    property Owner: TcxWebTreeView read FOwner;
    property Parent: TcxWebTreeItem read FParent;
  published
    property Expanded: Boolean read FExpanded write SetExpanded;
    property Hint: string read FHint write FHint;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property Name: string read FName write SetName;
    property Text: string read GetText write SetText;
    property URL: TcxURL read FURL write SetURL;
  end;


  TcxWebTVCollapsingEvent = procedure(Sender: TObject; Item: TcxWebTreeItem;
    var AllowCollapse: Boolean) of object;
  TcxWebTVExpandingEvent = procedure(Sender: TObject; Item: TcxWebTreeItem;
    var AllowExpansion: Boolean) of object;
  TcxWebTVItemEvent = procedure(Sender: TObject; Item: TcxWebTreeItem) of object;


  TcxWebTreeViewEvent = (teOnTreeItemClick, teOnTreeItemCollapse, teOnTreeItemExpand);

  TcxWebTreeViewEventsHelper = class(TcxWebScriptEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
    function ScriptObject: string; override;
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxWebTreeView = class(TcxWebControl)
  private
    FAutoSort: Boolean;
    FExpandedImageIndex: Integer;
    FCollapsedImageIndex: Integer;
    FForcePostBack: Boolean;
    FImages: TcxWebImageList;
    FIndent: Integer;
    FItems: TcxWebTreeItem;
    FShowButtons: Boolean;
    FShowImages: Boolean;
    FVertIndent: Integer;
    FOnClick: TcxWebTVItemEvent;
    FOnCollapsed: TcxWebTVItemEvent;
    FOnCollapsing: TcxWebTVCollapsingEvent;
    FOnExpanded: TcxWebTVItemEvent;
    FOnExpanding: TcxWebTVExpandingEvent;

    function GetForcePostBack: Boolean;
    procedure SetImages(Value: TcxWebImageList);
    procedure SetAutoSort(Value: Boolean);
    function IsValidIndex(AIndex: Integer): Boolean;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadItems(Stream: TStream);
    procedure WriteItems(Stream: TStream);

    function CanCollapse(AItem: TcxWebTreeItem): Boolean; dynamic;
    function CanExpand(AItem: TcxWebTreeItem): Boolean; dynamic;
    procedure Click(AItem: TcxWebTreeItem); dynamic;
    procedure Collapse(AItem: TcxWebTreeItem); dynamic;
    procedure Expand(AItem: TcxWebTreeItem); dynamic;
    procedure DoClick(const Parameters: TcxActionParameters);
    procedure DoToggle(const Parameters: TcxActionParameters);
    procedure ValidateItemName(const Value: string);
    { actions }
    procedure RegisterActions; override;
    { events }
    function GetWebEventsHelper: TcxWebTreeViewEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebTreeViewEventsHelper read GetWebEventsHelper;
    { renderers}
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
    procedure RestoreState(const AState: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AddItem: TcxWebTreeItem;
    procedure AssignItems(Source: TcxWebTreeView);
    procedure Clear;
    procedure FullCollapse;
    procedure FullExpand;
    function ItemByName(const AName: string): TcxWebTreeItem;
    procedure Sort;

    property Items: TcxWebTreeItem read FItems;    
  published
    property AutoSort: Boolean read FAutoSort write SetAutoSort default False;
    property CollapsedImageIndex: Integer read FCollapsedImageIndex write FCollapsedImageIndex
      default -1;
    property ExpandedImageIndex: Integer read FExpandedImageIndex write FExpandedImageIndex
      default -1;
    property ForcePostBack: Boolean read GetForcePostBack write FForcePostBack
      default False;
    property Height;
    property Images: TcxWebImageList read FImages write SetImages;
    property Indent: Integer read FIndent write FIndent default 20;
    property PopupMenu;
    property PopupShowingType;
    property ShowButtons: Boolean read FShowButtons write FShowButtons
      default True;
    property ShowImages: Boolean read FShowImages write FShowImages
      default True;
    property Styles;
    property VertIndent: Integer read FVertIndent write FVertIndent default 0;
    property Width;

    property OnClick: TcxWebTVItemEvent read FOnClick write FOnClick;
    property OnCollapsed: TcxWebTVItemEvent read FOnCollapsed write FOnCollapsed;
    property OnCollapsing: TcxWebTVCollapsingEvent read FOnCollapsing write FOnCollapsing;
    property OnExpanded: TcxWebTVItemEvent read FOnExpanded write FOnExpanded;
    property OnExpanding: TcxWebTVExpandingEvent read FOnExpanding write FOnExpanding;
  end;

  TcxWebTreeViewRenderer = class(TcxWebControlRenderer)
  private
    function GetWebTreeView: TcxWebTreeView;
    function GetExpandImageHint: string;
    function GetExpandImagePath: string;
    function GetCollapseImageHint: string;
    function GetCollapseImagePath: string;
  protected
    procedure SetDefaultStyleProc(const Style: TcxWebStyleItem; var AScript: string);
    procedure SetHoverStyleProc(const Style: TcxWebStyleItem; var AScript: string);
    procedure WriteNodeEvents(const Style: TcxWebStyleItem);

    procedure WriteBlockStyle(AItem: TcxWebTreeItem); virtual;
    procedure WriteItem(AItem: TcxWebTreeItem); virtual;
    procedure WriteItems(AItem: TcxWebTreeItem); virtual;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHiddenFormElements; override;
    procedure WriteHTML; override;
    procedure WriteScripts; override;

    property WebTreeView: TcxWebTreeView read GetWebTreeView;
  end;

  TcxWebTreeViewNS4Renderer = class(TcxWebTreeViewRenderer)
  protected
    procedure WriteItem(AItem: TcxWebTreeItem); override;
    procedure WriteItems(AItem: TcxWebTreeItem); override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHiddenFormElements; override;
    procedure WriteHTML; override;
    procedure WriteScripts; override;
  end;

  TcxWebTreeViewNS6Renderer = class(TcxWebTreeViewRenderer)
  protected
    procedure WriteItem(AItem: TcxWebTreeItem); override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    procedure WriteHTML; override;
  end;

  TcxWebTreeViewOperaRenderer = class(TcxWebTreeViewNS4Renderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

implementation

uses
  RTLConsts,
  cxWebConsts, cxWebScriptFactory, cxWebColors, cxWebGraphics, cxWebUtils;

type
  PcxWebTreeItemInfo = ^TcxWebTreeItemInfo;
  TcxWebTreeItemInfo = packed record
    Count: Integer;
    Data: Pointer;
    Expanded: Boolean;
    ImageIndex: Integer;
  end;

{ TcxWebTreeItem }

constructor TcxWebTreeItem.Create(AOwner: TcxWebTreeView);
begin
  FOwner := AOwner;
  FURL := TcxURL.Create(FOwner);
  FImageIndex := -1;
end;

destructor TcxWebTreeItem.Destroy;
begin
  DeleteChildren;
  if Parent <> nil then
    if Parent.FList <> nil then
    begin
      Parent.FList.Remove(Self);
      if Parent.Count = 0 then
      begin
        Parent.FList.Free;
        Parent.FList := nil;
        Parent.FExpanded := False;
      end;
    end;
  FURL.Free;
  inherited Destroy;
end;

function TcxWebTreeItem.DoCanExpand(Expand: Boolean): Boolean;
begin
  Result := False;
  if HasChildren then
    if Expand then
      Result := Owner.CanExpand(Self)
    else
      Result := Owner.CanCollapse(Self);
end;

procedure TcxWebTreeItem.DoExpand(Expand: Boolean);
begin
  if HasChildren then
    if Expand then
      Owner.Expand(Self)
    else
      Owner.Collapse(Self);
end;

procedure TcxWebTreeItem.ExpandItem(Expand: Boolean; Recurse: Boolean);
var
  I: Integer;
begin
  if DoCanExpand(Expand) then
  begin
    DoExpand(Expand);
    FExpanded := Expand;
  end;
  if Recurse then
    for I := 0 to Count - 1 do
      Items[I].ExpandItem(Expand, True);
  Owner.UpdateDesignerContext;      
end;

function TcxWebTreeItem.GenerateName(Unique: Boolean): string;
var
  NewName: string;
  I: Integer;
begin
  if (Level > 0) and (Parent <> nil) then
    NewName := Parent.GenerateName(False)
  else
    NewName := Owner.Name + 'Item';
  I := Index;
  repeat
    Inc(I);
    Result := NewName + '_' + IntToStr(I);
  until ((not Unique) or (Owner.ItemByName(Result) = nil));
end;

function TcxWebTreeItem.AddChild: TcxWebTreeItem;
begin
  Result := InsertChild(nil);
end;

procedure TcxWebTreeItem.Expand(ARecurse: Boolean);
begin
  ExpandItem(True, ARecurse);
end;

procedure TcxWebTreeItem.Collapse(ARecurse: Boolean);
begin
  ExpandItem(False, ARecurse);
end;

function TcxWebTreeItem.InsertChild(BeforeItem: TcxWebTreeItem) : TcxWebTreeItem;
begin
  Result := TcxWebTreeItem.Create(FOwner);;
  Result.FParent := Self;
  if FList = nil then
  begin
    FList := TList.Create;
    FList.Add(Result);
  end
  else
    if BeforeItem = nil then
      FList.Add(Result)
    else
      FList.Insert(BeforeItem.Index, Result);
  Result.Name := Result.GenerateName(True);
  if Owner.AutoSort then ApplySorting(False);
  Owner.UpdateDesignerContext;
end;

procedure TcxWebTreeItem.DeleteChildren;
begin
  while Count > 0 do
    Items[Count - 1].Free;
end;

function CompareItems(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(TcxWebTreeItem(Item1).Text, TcxWebTreeItem(Item2).Text);
end;

procedure TcxWebTreeItem.ApplySorting(SortChildren: Boolean);
var
  I: Integer;
begin
  if Owner.IsLoading then exit;
  
  if (FList <> nil) then
  begin
    FList.Sort(@CompareItems);
    if SortChildren then
      for I := 0 to Count - 1 do
        Items[I].ApplySorting(True);
  end;
end;

procedure TcxWebTreeItem.ReadData(Stream: TStream);
var
  ItemSize, I, L, ItemCount: Integer;
  Info: PcxWebTreeItemInfo;
  S: string;
begin
  Stream.ReadBuffer(ItemSize, SizeOf(ItemSize));
  GetMem(Info, ItemSize);
  try
    Stream.ReadBuffer(Info^, ItemSize);
    ItemCount := Info^.Count;
    FData := Info^.Data;
    FExpanded := Info^.Expanded;
    FImageIndex := Info^.ImageIndex;
    
    Stream.ReadBuffer(L, SizeOf(L));
    SetLength(FHint, L);
    Stream.ReadBuffer(FHint[1], L);
    
    Stream.ReadBuffer(L, SizeOf(L));
    SetLength(FName, L);
    Stream.ReadBuffer(FName[1], L);

    Stream.ReadBuffer(L, SizeOf(L));
    SetLength(FText, L);
    Stream.ReadBuffer(FText[1], L);

    Stream.ReadBuffer(L, SizeOf(L));
    SetLength(S, L);
    Stream.ReadBuffer(S[1], L);
    FURL.Href := S;

    Stream.ReadBuffer(L, SizeOf(L));
    SetLength(S, L);
    Stream.ReadBuffer(S[1], L);
    FURL.Target := S;
  finally
    FreeMem(Info, ItemSize);
  end;
  for I := 0 to ItemCount - 1 do
    with AddChild do ReadData(Stream);
end;

procedure TcxWebTreeItem.WriteData(Stream: TStream);
var
  ItemSize, I, L: Integer;
  Info: PcxWebTreeItemInfo;
  S: string;
begin
  ItemSize := SizeOf(TcxWebTreeItemInfo);
  GetMem(Info, ItemSize);
  try
    Info^.Count := Count;
    Info^.Data := Data;
    Info^.Expanded := Expanded;
    Info^.ImageIndex := ImageIndex;
    Stream.WriteBuffer(ItemSize, SizeOf(ItemSize));
    Stream.WriteBuffer(Info^, ItemSize);
    
    L := Length(FHint);
    Stream.WriteBuffer(L, SizeOf(L));
    Stream.WriteBuffer(FHint[1], L);
    
    L := Length(FName);
    Stream.WriteBuffer(L, SizeOf(L));
    Stream.WriteBuffer(FName[1], L);

    L := Length(FText);
    Stream.WriteBuffer(L, SizeOf(L));
    Stream.WriteBuffer(FText[1], L);

    S := FURL.Href;
    L := Length(S);
    Stream.WriteBuffer(L, SizeOf(L));
    Stream.WriteBuffer(S[1], L);

    S := FURL.Target;
    L := Length(S);
    Stream.WriteBuffer(L, SizeOf(L));
    Stream.WriteBuffer(S[1], L);
  finally
    FreeMem(Info, ItemSize);
  end;
  for I := 0 to Count - 1 do
    Items[I].WriteData(Stream);
end;

function TcxWebTreeItem.IndexOf(Value: TcxWebTreeItem): Integer;
begin
  Result := -1;
  if Count > 0 then
    Result := FList.IndexOf(Value);
end;

procedure TcxWebTreeItem.SetExpanded(Value: Boolean);
begin
  if Value then Expand(False)
  else Collapse(False);
  Owner.UpdateDesignerContext;
end;

function TcxWebTreeItem.GetHasChildren: Boolean;
begin
  Result := Count > 0;
end;

procedure TcxWebTreeItem.SetName(const Value: string);
begin
  if Value = FName then Exit;
  if not IsValidIdent(Value) then
      raise EComponentError.CreateResFmt(@SInvalidName, [Value]);
  if Owner <> nil then
    Owner.ValidateItemName(Value);
  FName := Value;
  if Owner.AutoSort then Parent.ApplySorting(False);
  Owner.UpdateDesignerContext;
end;

procedure TcxWebTreeItem.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    if Owner.AutoSort then Parent.ApplySorting(False);
    Owner.UpdateDesignerContext;    
  end;
end;

procedure TcxWebTreeItem.SetURL(Value: TcxURL);
begin
  FURL.Assign(Value);
end;

function TcxWebTreeItem.GetCount: Integer;
begin
  if FList = nil then
    Result := 0
  else
    Result := FList.Count;
end;

function TcxWebTreeItem.GetIndex: Integer;
begin
  if Parent = nil then
    Result := 0
  else
    Result := Parent.IndexOf(Self);
end;

function TcxWebTreeItem.GetItem(Index: Integer): TcxWebTreeItem;
begin
  Result := nil;
  if (Index > -1) and (Index < Count) then
    Result := FList.List^[Index];
end;

function TcxWebTreeItem.GetLevel: Integer;
begin
  if Parent = nil then
    Result := -1
  else
    Result := Parent.Level + 1;
end;

function TcxWebTreeItem.GetText: string;
begin
  if FText = '' then
    Result := Name
  else
    Result := FText;
end;

{ TcxWebTreeViewEventsHelper }

function TcxWebTreeViewEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebTreeViewEvent] of string = ('OnTreeItemClick',
      'OnTreeItemCollapse', 'OnTreeItemExpand');
begin
  Result := cxHTMLEvent[TcxWebTreeViewEvent(AEvent)];
end;

function TcxWebTreeViewEventsHelper.EventProcParams(const AEvent: Integer): string;
begin
  Result := '(Sender, ItemName)';
end;

function TcxWebTreeViewEventsHelper.ScriptObject: string;
begin
  Result := '_TreeView';
end;

function TcxWebTreeViewEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebTreeViewEvent);
end;

{ TcxWebTreeView }

constructor TcxWebTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TcxWebTreeItem.Create(Self);
  FItems.FExpanded := True;
  FCollapsedImageIndex := -1;
  FExpandedImageIndex := -1;
  FShowButtons := True;
  FShowImages := True;
  FForcePostBack := False;
  FIndent := 20;
  FVertIndent := 0;

  Height := 100;
  Width := 100;
end;

destructor TcxWebTreeView.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TcxWebTreeView.ItemByName(const AName: string): TcxWebTreeItem;

  function FindItem(AItem: TcxWebTreeItem; const AName: string): TcxWebTreeItem;
  var
    I: Integer;
  begin
    Result := nil;
    if AItem <> nil then
      if CompareText(AItem.Name, AName) = 0 then
        Result := AItem
      else
        for I := 0 to AItem.Count - 1 do
        begin
          Result := FindItem(AItem.Items[I], AName);
          if Result <> nil then
            Break;
        end;
  end;

begin
  Result := FindItem(Items, AName);
end;

procedure TcxWebTreeView.Sort;
begin
  FItems.ApplySorting(True);
  UpdateDesignerContext;
end;

procedure TcxWebTreeView.ValidateItemName(const Value: string);
begin
  if ItemByName(Value) <> nil then
    raise EComponentError.CreateResFmt(@SDuplicateName, [Value]);
end;

procedure TcxWebTreeView.Expand(AItem: TcxWebTreeItem);
begin
  if Assigned(FOnExpanded) then FOnExpanded(Self, AItem);
end;

function TcxWebTreeView.CanExpand(AItem: TcxWebTreeItem): Boolean;
begin
  Result := True;
  if Assigned(FOnExpanding) then FOnExpanding(Self, AItem, Result);
end;

procedure TcxWebTreeView.Click(AItem: TcxWebTreeItem);
begin
  if Assigned(FOnClick) and (AItem <> nil) then
    FOnClick(Self, AItem);
end;

procedure TcxWebTreeView.Collapse(AItem: TcxWebTreeItem);
begin
  if Assigned(FOnCollapsed) then FOnCollapsed(Self, AItem);
end;

function TcxWebTreeView.CanCollapse(AItem: TcxWebTreeItem): Boolean;
begin
  Result := True;
  if Assigned(FOnCollapsing) then FOnCollapsing(Self, AItem, Result);
end;

procedure TcxWebTreeView.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Items', ReadItems, WriteItems, Items.Count > 0);
end;

procedure TcxWebTreeView.ReadItems(Stream: TStream);
begin
  Items.DeleteChildren;
  Items.ReadData(Stream);
end;

procedure TcxWebTreeView.WriteItems(Stream: TStream);
begin
  Items.WriteData(Stream);
end;

procedure TcxWebTreeView.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
  WebScriptsHelper.ScriptSubscription(TcxWebChangeStyleScript);
end;

procedure TcxWebTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

procedure TcxWebTreeView.RegisterActions;
begin
  WebActionsHelper.RegisterAction('TOGGLE', DoToggle);
  WebActionsHelper.RegisterAction('CLICK', DoClick);
end;

function TcxWebTreeView.GetWebEventsHelper: TcxWebTreeViewEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebTreeViewEventsHelper;
end;

class function TcxWebTreeView.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebTreeViewEventsHelper;
end;

procedure TcxWebTreeView.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebTreeViewRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebTreeViewNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebTreeViewNS6Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebTreeViewOperaRenderer);
end;

procedure TcxWebTreeView.RegisterValues;
begin
  WebValuesHelper.RegisterValue(Name + '_EXPANDSTATE', '');
end;

procedure TcxWebTreeView.RestoreState(const AState: string);
var
  I: Integer;
begin
  with TStringList.Create do
    try
      CommaText := AState;
      for I := 0 to Count - 2 do
        try
          ItemByName(Names[I]).Expanded := Boolean(StrToInt(Values[Names[I]]));
        except
        end;
    finally
      Free;
    end;
end;

function TcxWebTreeView.AddItem: TcxWebTreeItem;
begin
  Result := Items.AddChild;
end;

procedure TcxWebTreeView.AssignItems(Source: TcxWebTreeView);
var
  MemStream: TMemoryStream;
begin
  if Source = nil then 
    Clear
  else
  begin
    MemStream := TMemoryStream.Create;
    try
      TcxWebTreeView(Source).WriteItems(MemStream);
      MemStream.Position := 0;
      ReadItems(MemStream);
      UpdateDesignerContext;
    finally
      MemStream.Free;
    end;
  end;  
end;

procedure TcxWebTreeView.Clear;
begin
  Items.DeleteChildren;
end;

procedure TcxWebTreeView.FullCollapse;
begin
  Items.Collapse(True);
end;

procedure TcxWebTreeView.FullExpand;
begin
  Items.Expand(True);
end;

procedure TcxWebTreeView.DoClick(const Parameters: TcxActionParameters);
var
  Item: TcxWebTreeItem;
begin
  Item := ItemByName(Parameters.ParamString);
  Click(Item);
end;

procedure TcxWebTreeView.DoToggle(const Parameters: TcxActionParameters);
var
  Item: TcxWebTreeItem;
begin
  Item := ItemByName(Parameters.ParamString);
  if Item <> nil then
    if Item.Expanded then
      Item.Collapse(False)
    else
      Item.Expand(False);
end;

procedure TcxWebTreeView.DoSetValues;
begin
  RestoreState(WebValuesHelper.Values.Values[Name + '_EXPANDSTATE']);
end;

function TcxWebTreeView.GetForcePostBack: Boolean;
begin
  Result := FForcePostBack or 
    Assigned(FOnCollapsed) or Assigned(FOnCollapsing) or 
    Assigned(FOnExpanded) or Assigned(FOnExpanding);
end;

procedure TcxWebTreeView.SetImages(Value: TcxWebImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then
    begin
      FImages.RemoveFreeNotification(Self);
      FImages.UnregisterClient(Self);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterClient(Self);
      FImages.FreeNotification(Self);
    end;
  end;
end;

procedure TcxWebTreeView.SetAutoSort(Value: Boolean);
begin
  if FAutoSort <> Value then
  begin
    FAutoSort := Value;
    if Value then FItems.ApplySorting(True);
  end;
end;

function TcxWebTreeView.IsValidIndex(AIndex: Integer): Boolean;
begin
  Result := (FImages <> nil) and (AIndex > -1) and (AIndex < FImages.Images.Count);
end;

{ TcxWebTreeViewRenderer }

function TcxWebTreeViewRenderer.GetWebTreeView: TcxWebTreeView;
begin
  Result := Component as TcxWebTreeView;
end;

function TcxWebTreeViewRenderer.GetExpandImageHint: string;
var
  ImgIndex: Integer;
begin
  ImgIndex := WebTreeView.ExpandedImageIndex;
  if WebTreeView.IsValidIndex(ImgIndex) then
    Result := WebTreeView.FImages.Images[ImgIndex].Hint
  else Result := 'Collapse';
end;

function TcxWebTreeViewRenderer.GetExpandImagePath: string;
var
  ImgIndex: Integer;
begin
  ImgIndex := WebTreeView.ExpandedImageIndex;
  if WebTreeView.IsValidIndex(ImgIndex) then
    Result := WebTreeView.FImages.Images[ImgIndex].FullFilePath
  else Result := QualifyImageFileName(scxtvExpandImageName);
end;

function TcxWebTreeViewRenderer.GetCollapseImageHint: string;
var
  ImgIndex: Integer;
begin
  ImgIndex := WebTreeView.CollapsedImageIndex;
  if WebTreeView.IsValidIndex(ImgIndex) then
    Result := WebTreeView.FImages.Images[ImgIndex].Hint
  else Result := 'Expand';
end;

function TcxWebTreeViewRenderer.GetCollapseImagePath: string;
var
  ImgIndex: Integer;
begin
  ImgIndex := WebTreeView.CollapsedImageIndex;
  if WebTreeView.IsValidIndex(ImgIndex) then
    Result := WebTreeView.FImages.Images[ImgIndex].FullFilePath
  else Result := QualifyImageFileName(scxtvCollapseImageName);
end;

procedure TcxWebTreeViewRenderer.SetDefaultStyleProc(const Style: TcxWebStyleItem; var AScript: string);
begin
  AScript := '__ChangeStyle(event, this);';
end;

procedure TcxWebTreeViewRenderer.SetHoverStyleProc(const Style: TcxWebStyleItem; var AScript: string);
begin
  if Style <> nil then
    AScript := Format('__ChangeStyle(event, this, ''%s'');', [Style.FullName])
  else AScript := '';
end;

procedure TcxWebTreeViewRenderer.WriteNodeEvents(const Style: TcxWebStyleItem);
var
  MouseOutString, MouseOverString: string;
begin
  if Style <> nil then
  begin
    SetHoverStyleProc(Style, MouseOverString);
    SetDefaultStyleProc(Style, MouseOutString);

    HTMLTextBuilder.WriteEventAttribute(eOnMouseOver, MouseOverString);
    HTMLTextBuilder.WriteEventAttribute(eOnMouseOut, MouseOutString);
  end;
end;

procedure TcxWebTreeViewRenderer.WriteBlockStyle(AItem: TcxWebTreeItem);
begin
  if AItem.HasChildren and not AItem.Expanded then
    HTMLTextBuilder.WriteStyleAttribute(saDisplay, 'none');
  if AItem.Level >= 0 then
    HTMLTextBuilder.WriteStyleAttribute(saMarginLeft, AItem.Owner.Indent);
end;

procedure TcxWebTreeViewRenderer.WriteItem(AItem: TcxWebTreeItem);
var
  LeftMargin: Integer;
  ImagePath: string;
begin
  LeftMargin := WebTreeView.Indent;
  if WebTreeView.ShowButtons and AItem.HasChildren then
    LeftMargin := WebTreeView.Indent - 13;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv, True, False);
  HTMLTextBuilder.WriteAttribute(aId, AItem.Name);
  HTMLTextBuilder.WriteStyleAttribute(saMarginLeft, LeftMargin);
  HTMLTextBuilder.WriteStyleAttribute(saMarginTop, WebTreeView.VertIndent);

  if WebTreeView.ShowButtons and AItem.HasChildren then
  begin
    if AItem.Expanded then
      ImagePath := GetExpandImagePath
    else ImagePath := GetCollapseImagePath;

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aId, AItem.Name + '_Img');
    HTMLTextBuilder.WriteAttribute(aSrc, ImagePath);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aHspace, 0);
    HTMLTextBuilder.WriteAttribute(aVspace, 0);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  end;
  if WebTreeView.ShowImages and WebTreeView.IsValidIndex(AItem.ImageIndex) then
    WebTreeView.Images.Images[AItem.ImageIndex].WriteHTML(HTMLTextBuilder);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  AItem.URL.Write(HTMLTextBuilder);
  HTMLTextBuilder.WriteStyleAttribute(saCursor, 'hand');
  HTMLTextBuilder.WriteAttribute(aTitle, AItem.Hint);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSpan, False, False);
  WriteDefaultStyle;
  WriteNodeEvents(WebTreeView.Styles.Hover);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, '0px');
  HTMLTextBuilder.WriteText(AItem.Text, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagSpan, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv, False, True);
end;

procedure TcxWebTreeViewRenderer.WriteItems(AItem: TcxWebTreeItem);
var
  I: Integer;
begin
  WriteItem(AItem);
  if AItem.HasChildren and (not WebTreeView.IsDesigning or AItem.Expanded) then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, 'Sub_' + AItem.Name);
    WriteBlockStyle(AItem);
    for I := 0 to AItem.Count - 1 do
      WriteItems(AItem.Items[I]);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  end;
end;

class procedure TcxWebTreeViewRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxTreeViewScriptName);
end;

procedure TcxWebTreeViewRenderer.WriteHiddenFormElements;
begin
  WriteHiddenField(WebTreeView.Name + '_EXPANDSTATE', '');
end;

procedure TcxWebTreeViewRenderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  WriteID;
  WritePopupMenu;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteAttribute(aHeight, WebTreeView.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebTreeView.Width);
  if WebTreeView.Styles.Default <> nil then
    WriteDefaultStyle
  else
  begin
    HTMLTextBuilder.WriteStyleAttribute(saBorderColor, 'black');
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, '1px');
  end;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteEventAttribute(eOnClick, Format('TreeNodeClick(''%s'', event, %s)',
    [WebTreeView.Name, cxWebUtils.BoolToStr(Assigned(WebTreeView.OnClick))]));
  for I := 0 to WebTreeView.Items.Count - 1 do
    WriteItems(WebTreeView.Items[I]);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxWebTreeViewRenderer.WriteScripts;
begin
  WriteEventsScript;
  HTMLTextBuilder.WriteText('_TreeView = CreateTreeView();');
  HTMLTextBuilder.WriteText(Format('  _TreeView.Name="%s";', [WebTreeView.Name]));
  if WebTreeView.ForcePostBack then
    HTMLTextBuilder.WriteText('  _TreeView.ForcePostBack = true;');
  if WebTreeView.ShowButtons then
  begin
    HTMLTextBuilder.WriteText(Format('  _TreeView.ColImg="%s";', [GetCollapseImagePath]));
    HTMLTextBuilder.WriteText(Format('  _TreeView.ExpImg="%s";', [GetExpandImagePath]));
    HTMLTextBuilder.WriteText(Format('  _TreeView.ColTitle="%s";', [GetCollapseImageHint]));
    HTMLTextBuilder.WriteText(Format('  _TreeView.ExpTitle="%s";', [GetExpandImageHint]));
  end;
  WriteEvents;
end;

{ TcxWebTreeViewNS4Renderer }

procedure TcxWebTreeViewNS4Renderer.WriteItem(AItem: TcxWebTreeItem);
var
  LeftMargin: Integer;
  ImagePath: string;
begin
  LeftMargin := WebTreeView.Indent;
  if WebTreeView.ShowButtons and AItem.HasChildren then
    LeftMargin := WebTreeView.Indent - 13;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv, True, False);
  HTMLTextBuilder.WriteStyleAttribute(saMarginLeft, LeftMargin);
  HTMLTextBuilder.WriteStyleAttribute(saMarginTop, WebTreeView.VertIndent);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable, False, False);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, False, False);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  if WebTreeView.ShowButtons and AItem.HasChildren then
  begin
    if AItem.Expanded then
      ImagePath := GetExpandImagePath
    else ImagePath := GetCollapseImagePath;

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''TOGGLE:%s'');',
        [WebTreeView.Name, AItem.Name]));
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aId, AItem.Name + '_Img');
    HTMLTextBuilder.WriteAttribute(aSrc, ImagePath);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aHspace, 0);
    HTMLTextBuilder.WriteAttribute(aVspace, 0);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  if WebTreeView.ShowImages and WebTreeView.IsValidIndex(AItem.ImageIndex) then
    WebTreeView.Images.Images[AItem.ImageIndex].WriteHTML(HTMLTextBuilder);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  if AItem.URL.Href <> '' then
    AItem.URL.Write(HTMLTextBuilder)
  else HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''CLICK:%s'')',
    [WebTreeView.Name, AItem.Name]));
  HTMLTextBuilder.WriteAttribute(aTitle, AItem.Hint);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSpan, False, False);
  WriteDefaultStyle;
  WriteNodeEvents(WebTreeView.Styles.Hover);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, '0px');
  HTMLTextBuilder.WriteText(AItem.Text, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagSpan, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable, False, False);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv, False, True);
end;

procedure TcxWebTreeViewNS4Renderer.WriteItems(AItem: TcxWebTreeItem);
var
  I: Integer;
begin
  WriteItem(AItem);
  if AItem.HasChildren then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    WriteBlockStyle(AItem);
    for I := 0 to AItem.Count - 1 do
      WriteItems(AItem.Items[I]);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  end;
end;

class function TcxWebTreeViewNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

class procedure TcxWebTreeViewNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxTreeViewScriptName);
end;

procedure TcxWebTreeViewNS4Renderer.WriteHiddenFormElements;
begin
end;

procedure TcxWebTreeViewNS4Renderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  WriteID;
  WritePopupMenu;
  WriteAttributes;
  WriteStyleAttributes;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteAttribute(aHeight, WebTreeView.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebTreeView.Width);
  if WebTreeView.Styles.Default <> nil then
    WriteDefaultStyle
  else
  begin
    HTMLTextBuilder.WriteStyleAttribute(saBorderColor, 'black');
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, '1px');
  end;

  for I := 0 to WebTreeView.Items.Count - 1 do
    WriteItems(WebTreeView.Items[I]);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxWebTreeViewNS4Renderer.WriteScripts;
begin
end;

{ TcxWebTreeViewNS6Renderer }
class function TcxWebTreeViewNS6Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS6;
end;

procedure TcxWebTreeViewNS6Renderer.WriteItem(AItem: TcxWebTreeItem);
var
  LeftMargin: Integer;
  ImagePath: string;
begin
  LeftMargin := WebTreeView.Indent;
  if WebTreeView.ShowButtons and AItem.HasChildren then
    LeftMargin := WebTreeView.Indent - 13;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv, True, False);
  HTMLTextBuilder.WriteAttribute(aId, AItem.Name);
  HTMLTextBuilder.WriteStyleAttribute(saMarginLeft, LeftMargin);
  HTMLTextBuilder.WriteStyleAttribute(saMarginTop, WebTreeView.VertIndent);

  if WebTreeView.ShowButtons and AItem.HasChildren then
  begin
    if AItem.Expanded then
      ImagePath := GetExpandImagePath
    else ImagePath := GetCollapseImagePath;

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:TreeNodeToggle(''%s'', ''%s'')',
        [WebTreeView.Name, AItem.Name]));
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aId, AItem.Name + '_Img');
    HTMLTextBuilder.WriteAttribute(aSrc, ImagePath);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aHspace, 0);
    HTMLTextBuilder.WriteAttribute(aVspace, 0);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  end;
  if WebTreeView.ShowImages and WebTreeView.IsValidIndex(AItem.ImageIndex) then
    WebTreeView.Images.Images[AItem.ImageIndex].WriteHTML(HTMLTextBuilder);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  AItem.URL.Write(HTMLTextBuilder);
  HTMLTextBuilder.WriteStyleAttribute(saCursor, 'hand');  
  HTMLTextBuilder.WriteAttribute(aTitle, AItem.Hint);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSpan, False, False);
  WriteDefaultStyle;
  WriteNodeEvents(WebTreeView.Styles.Hover);
  HTMLTextBuilder.WriteEventAttribute(eOnClick, Format('TreeNodeClick(''%s'', event, %s)',
    [WebTreeView.Name, cxWebUtils.BoolToStr(Assigned(WebTreeView.OnClick))]));
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, '0px');
  HTMLTextBuilder.WriteText(AItem.Text, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagSpan, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv, False, True);
end;

procedure TcxWebTreeViewNS6Renderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  WriteID;
  WritePopupMenu;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteAttribute(aHeight, WebTreeView.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebTreeView.Width);
  if WebTreeView.Styles.Default <> nil then
    WriteDefaultStyle
  else
  begin
    HTMLTextBuilder.WriteStyleAttribute(saBorderColor, 'black');
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, '1px');
  end;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  for I := 0 to WebTreeView.Items.Count - 1 do
    WriteItems(WebTreeView.Items[I]);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

{ TcxWebTreeViewOperaRenderer }

class function TcxWebTreeViewOperaRenderer.IsBrowserSupported(
  AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

initialization
  RegisterClasses([TcxWebTreeItem, TcxWebTreeView]);

end.
