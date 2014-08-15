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
unit cxWebDataNavigator;

{$I cxVer.inc}

interface

uses
  Classes, TypInfo, Contnrs, SysUtils,
  cxWebIntf, cxWebClasses, cxWebControls, cxWebTypes, cxWebMenus, cxWebImgList,
  cxWebRender;

const
  cxWebDataNavigatorBitmapHeight = 24;
  cxWebDataNavigatorBitmapWidth = 24;

type
  TcxWebDataNavigatorButtons = class;
  TcxCustomWebDataNavigator = class;

  TcxWebNavigatorButtonType = (nbFirst, nbPrevPage, nbPrev, nbPageSize, nbApplyPageSize,
    nbNext, nbNextPage, nbLast, nbInsert, nbEdit, nbDelete, nbPost, nbCancel, nbRefresh, nbCustom);

  TcxWebDataNavigatorButton = class(TCollectionItem)
  private
    FButtonType: TcxWebNavigatorButtonType;
    FHint: string;
    FImageIndex: Integer;
    FVisible: Boolean;
    FOnClick: TNotifyEvent;

    function GetButtons: TcxWebDataNavigatorButtons;
    function GetNavigator: TcxCustomWebDataNavigator;
    procedure SetButtonType(Value: TcxWebNavigatorButtonType);
    procedure SetHint(Value: string);
    procedure SetImageIndex(Value: Integer);
    procedure SetVisible(Value: Boolean);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;

    property Buttons: TcxWebDataNavigatorButtons read GetButtons;
    property Navigator: TcxCustomWebDataNavigator read GetNavigator;
  published
    property ButtonType: TcxWebNavigatorButtonType read FButtonType write SetButtonType;
    property Hint: string read FHint write SetHint;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property Visible: Boolean read FVisible write SetVisible default True;

    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TcxWebDataNavigatorButtons = class(TCollection)
  private
    FNavigator: TcxCustomWebDataNavigator;
    FUpdateLock: Integer;

    function GetItem(Index: Integer): TcxWebDataNavigatorButton;
    procedure SetItem(Index: Integer; Value: TcxWebDataNavigatorButton);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;

    procedure CreateButton(AType: TcxWebNavigatorButtonType; AHint: string;
        AImageIndex: Integer; AVisible: Boolean);

    procedure BeginUpdateNavigator;
    procedure EndUpdateNavigator;
    procedure UpdateNavigatorContext; virtual;
    procedure UpdateNavigatorWidth; virtual;
  public
    constructor Create(ANavigator: TcxCustomWebDataNavigator);
    function Add: TcxWebDataNavigatorButton;
    procedure CreateDefaultButtons; virtual;

    property Navigator: TcxCustomWebDataNavigator read FNavigator;
    property Items[Index: Integer]: TcxWebDataNavigatorButton read GetItem write SetItem; default;
  end;

  TcxWebNavigatorEvent = (neOnButtonClick, neOnChangePageSize);

  TcxWebNavigatorEventsHelper = class(TcxWebScriptEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
    function ScriptObject: string; override;
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxChangePageSizeEvent = procedure (Sender: TObject; PageSize: Integer) of object;

  TcxCustomWebDataNavigator = class(TcxWebControl)
  private
    FButtons: TcxWebDataNavigatorButtons;
    FButtonWidth: Integer;
    FImages: TcxWebImageList;
    FPageSize: Integer;
    FOnChangePageSize: TcxChangePageSizeEvent;

    function GetButtonCount: Integer;
    procedure SetButtons(Value: TcxWebDataNavigatorButtons);
    procedure SetImages(Value: TcxWebImageList);
    procedure SetPageSize(Value: Integer);

    procedure WebClick(const AParameters: TcxActionParameters);
    procedure WebChangePageSize(const AParameters: TcxActionParameters);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Size Correction }
    procedure CheckNewSize(var ALeft, ATop, ANewWidth, ANewHeight: Integer); override;
    function GetMinHeight: Integer; override;
    function GetMinWidth: Integer; override;
    procedure UpdateButtonWidth(AWidth: Integer); virtual;
    procedure UpdateWidth; virtual;
    { actions }
    procedure RegisterActions; override;
    { events }
    function GetWebEventsHelper: TcxWebNavigatorEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebNavigatorEventsHelper read GetWebEventsHelper;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
    { renderers }
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ButtonCount: Integer read GetButtonCount;
    property ButtonWidth: Integer read FButtonWidth;
  published
    property Buttons: TcxWebDataNavigatorButtons read FButtons write SetButtons;
    property Height;
    property Images: TcxWebImageList read FImages write SetImages;
    property PageSize: Integer read FPageSize write SetPageSize;
    property PopupMenu;
    property PopupShowingType;
    property Styles;
    property Width;

    property OnChangePageSize: TcxChangePageSizeEvent read FOnChangePageSize write FOnChangePageSize;
  end;

  TcxNavigatorButtonStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxCustomWebDataNavigatorRenderer = class(TcxWebControlRenderer)
  private
    function GetWebDataNavigator: TcxCustomWebDataNavigator;
  protected
    procedure SetDefaultStyleProc(const Index: Integer; var AScript: string);
    procedure SetHoverStyleProc(const Index: Integer; var AScript: string);
    procedure WriteButtonEvents(const Index: Integer);

    procedure WriteButtonAction(Index: Integer); virtual;
    procedure WriteButtonHint(Index: Integer); virtual;
    procedure WriteButton(Index: Integer); virtual;
    procedure WriteEdit; virtual;

    function GetDefaultStyleName: string;
    property DefaultStyleName: string read GetDefaultStyleName;
  public
    procedure WriteHTML; override;
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteScripts; override;
    class procedure WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder); override;

    property WebDataNavigator: TcxCustomWebDataNavigator read GetWebDataNavigator;
  end;

  TcxCustomWebDataNavigatorNS4Renderer = class(TcxCustomWebDataNavigatorRenderer)
  protected
    procedure WriteButtonAction(Index: Integer); override;
    procedure WriteButton(Index: Integer); override;
    procedure WriteEdit; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxCustomWebDataNavigatorNS6Renderer = class(TcxCustomWebDataNavigatorRenderer)
  protected
    procedure WriteButtonAction(Index: Integer); override;
    procedure WriteButton(Index: Integer); override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

implementation

uses StrUtils,
  {$IFDEF VCL}
  Graphics,
  {$ENDIF}
  cxWebScriptFactory, cxWebConsts, cxWebUtils, cxWebColors, cxWebGraphics;

const
  cxWebNavigatorImgs: array[TcxWebNavigatorButtonType] of string = (scxnbFirstImageName,
      scxnbPriorPageImageName, scxnbPriorImageName, '', scxnbPgSizeImageName,
      scxnbNextImageName, scxnbNextPageImageName, scxnbLastImageName, scxnbInsertImageName,
      scxnbEditImageName, scxnbDeleteImageName, scxnbPostImageName, scxnbCancelImageName,
      scxnbRefreshImageName, '');

{ TcxWebDataNavigatorButton }

constructor TcxWebDataNavigatorButton.Create(Collection: TCollection);
begin
  inherited;

  FButtonType := nbCustom;
  FImageIndex := -1;
  FVisible := True;
end;

function TcxWebDataNavigatorButton.GetDisplayName: string;
begin
  Result := GetEnumName(TypeInfo(TcxWebNavigatorButtonType), Integer(ButtonType));
end;

function TcxWebDataNavigatorButton.GetButtons: TcxWebDataNavigatorButtons;
begin
  Result := TcxWebDataNavigatorButtons(Collection);
end;

function TcxWebDataNavigatorButton.GetNavigator: TcxCustomWebDataNavigator;
begin
  if Collection <> nil then
    Result := TcxWebDataNavigatorButtons(Collection).Navigator
  else Result := nil;
end;

procedure TcxWebDataNavigatorButton.SetButtonType(Value: TcxWebNavigatorButtonType);
begin
  if FButtonType <> Value then
  begin
    FButtonType := Value;
    Buttons.UpdateNavigatorContext;
  end;
end;

procedure TcxWebDataNavigatorButton.SetHint(Value: string);
begin
  if FHint <> Value then
  begin
    FHint := Value;
  end;
end;

procedure TcxWebDataNavigatorButton.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Buttons.UpdateNavigatorContext;
  end;
end;

procedure TcxWebDataNavigatorButton.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Buttons.UpdateNavigatorWidth;
  end;
end;

{ TcxWebDataNavigatorButtons }

constructor TcxWebDataNavigatorButtons.Create(ANavigator: TcxCustomWebDataNavigator);
begin
  inherited Create(TcxWebDataNavigatorButton);
  FUpdateLock := 0;
  FNavigator := ANavigator;
  CreateDefaultButtons;
end;

function TcxWebDataNavigatorButtons.Add: TcxWebDataNavigatorButton;
begin
  Result := TcxWebDataNavigatorButton(inherited Add);
end;

function TcxWebDataNavigatorButtons.GetOwner: TPersistent;
begin
  Result := Navigator;
end;

procedure TcxWebDataNavigatorButtons.Update(Item: TCollectionItem);
begin
  inherited;
  UpdateNavigatorWidth;
end;

procedure TcxWebDataNavigatorButtons.CreateButton(AType: TcxWebNavigatorButtonType; AHint: string;
  AImageIndex: Integer; AVisible: Boolean);
begin
  with Add do
  begin
    ButtonType := AType;
    Hint := AHint;
    ImageIndex := AImageIndex;
    Visible := AVisible;
  end;
end;

procedure TcxWebDataNavigatorButtons.CreateDefaultButtons;
begin
  BeginUpdateNavigator;
  try
    Clear;
    CreateButton(nbFirst, 'First record', -1, True);
    CreateButton(nbPrevPage, 'Prior page', -1, True);
    CreateButton(nbPrev, 'Prior record', -1, True);
    CreateButton(nbPageSize, 'Page size', -1, True);
    CreateButton(nbApplyPageSize, 'Apply page size', -1, True);
    CreateButton(nbNext, 'Next record', -1, True);
    CreateButton(nbNextPage, 'Next page', -1, True);
    CreateButton(nbLast, 'Last record', -1, True);
    CreateButton(nbInsert, 'Insert record', -1, True);
    CreateButton(nbEdit, 'Edit record', -1, True);
    CreateButton(nbDelete, 'Delete record', -1, True);
    CreateButton(nbPost, 'Post changes', -1, True);
    CreateButton(nbCancel, 'Cancel changes', -1, True);
    CreateButton(nbRefresh, 'Refresh', -1, True);
  finally
    EndUpdateNavigator;
  end;
end;

procedure TcxWebDataNavigatorButtons.BeginUpdateNavigator;
begin
  Inc(FUpdateLock);
end;

procedure TcxWebDataNavigatorButtons.EndUpdateNavigator;
begin
  Dec(FUpdateLock);
  if FUpdateLock = 0 then UpdateNavigatorWidth;
end;

procedure TcxWebDataNavigatorButtons.UpdateNavigatorContext;
begin
  if (FUpdateLock = 0) and (Navigator <> nil) then
    Navigator.UpdateDesignerContext;
end;

procedure TcxWebDataNavigatorButtons.UpdateNavigatorWidth;
begin
  if (FUpdateLock = 0) and (Navigator <> nil) then
    Navigator.UpdateWidth;
end;

function TcxWebDataNavigatorButtons.GetItem(Index: Integer): TcxWebDataNavigatorButton;
begin
  Result := TcxWebDataNavigatorButton(inherited Items[Index]);
end;

procedure TcxWebDataNavigatorButtons.SetItem(Index: Integer; Value: TcxWebDataNavigatorButton);
begin
  Items[Index].Assign(Value);
end;

{ TcxWebNavigatorEventsHelper }

function TcxWebNavigatorEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebNavigatorEvent] of string = ('OnButtonClick',
      'OnChangePageSize');
begin
  Result := cxHTMLEvent[TcxWebNavigatorEvent(AEvent)];
end;

function TcxWebNavigatorEventsHelper.EventProcParams(const AEvent: Integer): string;
const
  cxHTMLEventProcParams: array[TcxWebNavigatorEvent] of string = ('(Sender, Button)',
    '(Sender, PageSize)');
begin
  Result := cxHTMLEventProcParams[TcxWebNavigatorEvent(AEvent)];
end;

function TcxWebNavigatorEventsHelper.ScriptObject: string;
begin
  Result := '_DataNavigator';
end;

function TcxWebNavigatorEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebNavigatorEvent);
end;

{ TcxCustomWebDataNavigator }

constructor TcxCustomWebDataNavigator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TcxWebDataNavigatorButtons.Create(Self);

  Height := 24;
  FPageSize := 5;
  Width := 336;
  Width := ButtonWidth * ButtonCount;
end;

destructor TcxCustomWebDataNavigator.Destroy;
begin
  FButtons.Free;
  inherited Destroy;
end;

function TcxCustomWebDataNavigator.GetButtonCount: Integer;
begin
  if Buttons <> nil then
    Result := Buttons.Count
  else Result := 0;
end;

procedure TcxCustomWebDataNavigator.SetButtons(Value: TcxWebDataNavigatorButtons);
begin
  Assign(Value);
end;

procedure TcxCustomWebDataNavigator.SetImages(Value: TcxWebImageList);
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

procedure TcxCustomWebDataNavigator.SetPageSize(Value: Integer);
begin
  if FPageSize <> Value then
  begin
    FPageSize := Value;
    if not IsLoading and Assigned(FOnChangePageSize) then
      FOnChangePageSize(Self, FPageSize);
  end;
end;

procedure TcxCustomWebDataNavigator.WebClick(const AParameters: TcxActionParameters);
var
  ButtonIndex: Integer;
begin
  ButtonIndex := StrToInt(GetActionParameter(AParameters.ParamString, 0));
  if Assigned(Buttons[ButtonIndex].OnClick) then
    Buttons[ButtonIndex].OnClick(Self);
end;

procedure TcxCustomWebDataNavigator.WebChangePageSize(const AParameters: TcxActionParameters);
begin
  PageSize := StrToInt(GetActionParameter(AParameters.ParamString, 0));
  if Assigned(FOnChangePageSize) then FOnChangePageSize(Self, FPageSize);
end;

procedure TcxCustomWebDataNavigator.DoSetValues;
begin
  FPageSize := StrToInt(WebValuesHelper.Values.Values[Name + 'PageSizeEdit']);
end;

procedure TcxCustomWebDataNavigator.RegisterValues;
begin
  inherited;
  WebValuesHelper.RegisterValue(Name + 'PageSizeEdit', IntToStr(PageSize));
end;

procedure TcxCustomWebDataNavigator.Loaded;
begin
  inherited;
  UpdateButtonWidth(Width);
end;

procedure TcxCustomWebDataNavigator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

procedure TcxCustomWebDataNavigator.CheckNewSize(var ALeft, ATop, ANewWidth, ANewHeight: Integer);
var
  I, NavigatorWidth: Integer;
begin
  inherited CheckNewSize(ALeft, ATop, ANewWidth, ANewHeight);
  UpdateButtonWidth(ANewWidth);
  if not IsLoading and (ButtonCount > 0) then
  begin
    NavigatorWidth := 0;
    for I := 0 to ButtonCount - 1 do
    begin
      if not Buttons[I].Visible then continue;
      if Buttons[I].ButtonType = nbPageSize then
        Inc(NavigatorWidth, ButtonWidth);
      Inc(NavigatorWidth, ButtonWidth);
    end;
    if NavigatorWidth > 0 then ANewWidth := NavigatorWidth;
  end;
end;

function TcxCustomWebDataNavigator.GetMinHeight: Integer;
begin
  Result := cxWebDataNavigatorBitmapHeight + 2;
end;

function TcxCustomWebDataNavigator.GetMinWidth: Integer;
var
  I, Count: Integer;
begin
  if (ButtonCount <> 0) and not IsLoading then
  begin
    Count := 0;
    for I := 0 to Buttons.Count - 1 do
    begin
      if not Buttons[I].Visible then continue;
      if Buttons[I].ButtonType = nbPageSize then
        Inc(Count);
      Inc(Count);
    end;
    Result := (cxWebDataNavigatorBitmapWidth + 2) * Count;
  end
  else Result := 0;
end;

procedure TcxCustomWebDataNavigator.UpdateButtonWidth(AWidth: Integer);
var
  I, Count: Integer;
begin
  FButtonWidth := AWidth;
  if ButtonCount <> 0 then
  begin
    Count := 0;
    for I := 0 to Buttons.Count - 1 do
    begin
      if not Buttons[I].Visible then continue;
      if Buttons[I].ButtonType = nbPageSize then
        Inc(Count);
      Inc(Count);
    end;
    if Count <> 0 then FButtonWidth := AWidth div Count;
  end;
end;

procedure TcxCustomWebDataNavigator.UpdateWidth;
begin
  if not IsLoading then
  begin
    AdjustBounds;
    UpdateDesignerContext;
  end;
end;

{ actions }
procedure TcxCustomWebDataNavigator.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', WebClick);
  WebActionsHelper.RegisterAction('CLICK', WebClick);
  WebActionsHelper.RegisterAction('CHANGEPAGESIZE', WebChangePageSize);
end;

{ Events }
function TcxCustomWebDataNavigator.GetWebEventsHelper: TcxWebNavigatorEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebNavigatorEventsHelper;
end;

class function TcxCustomWebDataNavigator.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebNavigatorEventsHelper;
end;

{ renderers }
procedure TcxCustomWebDataNavigator.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebDataNavigatorRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebDataNavigatorNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebDataNavigatorNS6Renderer);
end;

{ scripts }
procedure TcxCustomWebDataNavigator.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxNavigatorButtonStyle }

class function TcxNavigatorButtonStyle.GetName: string;
begin
  Result := 'DNBtnStyle';
end;

class procedure TcxNavigatorButtonStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 1, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  HTMLTextBuilder.WriteStyleAttribute(saBorderTopColor, 'white');
  HTMLTextBuilder.WriteStyleAttribute(saBorderLeftColor, 'white');
  HTMLTextBuilder.WriteStyleAttribute(saBorderBottomColor, 'black');
  HTMLTextBuilder.WriteStyleAttribute(saBorderRightColor, 'black');
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#D4D0C8');
end;

{ TcxCustomWebDataNavigatorRenderer }
function TcxCustomWebDataNavigatorRenderer.GetWebDataNavigator: TcxCustomWebDataNavigator;
begin
  Result := Component as TcxCustomWebDataNavigator;
end;

function TcxCustomWebDataNavigatorRenderer.GetDefaultStyleName: string;
begin
  if WebDataNavigator.Styles.Default <> nil then
    Result := WebDataNavigator.Styles.Default.FullName
  else Result := TcxNavigatorButtonStyle.GetName;
end;

procedure TcxCustomWebDataNavigatorRenderer.SetDefaultStyleProc(const Index: Integer; var AScript: string);
begin
  AScript := '__ChangeStyle(event, this);';
end;

procedure TcxCustomWebDataNavigatorRenderer.SetHoverStyleProc(const Index: Integer; var AScript: string);
begin
  if WebDataNavigator.Styles.Hover <> nil then
    AScript := Format('__ChangeStyle(event, this, ''%s'');', [WebDataNavigator.Styles.Hover.FullName])
  else AScript := '';
end;

procedure TcxCustomWebDataNavigatorRenderer.WriteButtonEvents(const Index: Integer);
var
  MouseOutString, MouseOverString: string;
begin
  if WebDataNavigator.Styles.Hover <> nil then
  begin
    SetHoverStyleProc(Index, MouseOverString);
    SetDefaultStyleProc(Index, MouseOutString);

    HTMLTextBuilder.WriteEventAttribute(eOnMouseOver, MouseOverString);
    HTMLTextBuilder.WriteEventAttribute(eOnMouseOut, MouseOutString);
  end;
end;

const
  NavigatorButtonIDs: array[TcxWebNavigatorButtonType] of string = // Do not localize
      ('_NBFirst_', '_NBPgUp_', '_NBPrev_', '', '_NBChPS_',
       '_NBNext_', '_NBPgDn_', '_NBLast_', '_NBIns_', '_NBEdit_',
       '_NBDel_', '_NBOk_', '_NBCancel_', '_NBRefresh_', '_NB_');

  NavigatorButtonActionString: array[TcxWebNavigatorButtonType] of string = // Do not localize
      ('OnNBFirstClick(''%s'')', 'OnNBPriorPageClick(''%s'')', 'OnNBPriorClick(''%s'')', '',
       'OnNBChangePageSizeClick(''%s'')', 'OnNBNextClick(''%s'')', 'OnNBNextPageClick(''%s'')',
       'OnNBLastClick(''%s'')', 'OnNBInsertClick(''%s'')', 'OnNBEditClick(''%s'')',
       'OnNBDeleteClick(''%s'')', 'OnNBPostClick(''%s'')', 'OnNBCancelClick(''%s'')',
       'OnNBRefreshClick(''%s'')', '');

procedure TcxCustomWebDataNavigatorRenderer.WriteButtonAction(Index: Integer);
var
  AType: TcxWebNavigatorButtonType;
begin
  AType := WebDataNavigator.Buttons[Index].ButtonType;
  if not Assigned(WebDataNavigator.Buttons[Index].OnClick) then
    HTMLTextBuilder.WriteEventAttribute(eOnClick, Format(NavigatorButtonActionString[AType],
        [WebDataNavigator.Name]))
  else
    HTMLTextBuilder.WriteEventAttribute(eOnClick, Format('__doPostBack(''%s'', ''%s:%d'');',
        [WebDataNavigator.Name, 'CLICK', Index]));
end;

procedure TcxCustomWebDataNavigatorRenderer.WriteButtonHint(Index: Integer);
begin
  if WebDataNavigator.ShowHint and (WebDataNavigator.Buttons[Index].Hint <> '') then
    HTMLTextBuilder.WriteAttribute(aTitle, WebDataNavigator.Buttons[Index].Hint);
end;

procedure TcxCustomWebDataNavigatorRenderer.WriteButton(Index: Integer);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, WebDataNavigator.ButtonWidth);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aClass, DefaultStyleName);
  HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebDataNavigator.Height - 1, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebDataNavigator.ButtonWidth, 'px');
  WriteButtonEvents(Index);
  WriteButtonAction(Index);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, '100%');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  if (WebDataNavigator.Images <> nil) and
    (WebDataNavigator.Images.ValidIndex(WebDataNavigator.Buttons[Index].ImageIndex)) then
    WebDataNavigator.Images.Images[WebDataNavigator.Buttons[Index].ImageIndex].WriteHTML(HTMLTextBuilder)
  else if WebDataNavigator.Buttons[Index].ButtonType <> nbCustom then
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(cxWebNavigatorImgs[WebDataNavigator.Buttons[Index].ButtonType]));
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    WriteButtonHint(Index);
  end;
  HTMLTextBuilder.WriteAttribute(aId, WebDataNavigator.Name + NavigatorButtonIDs[WebDataNavigator.Buttons[Index].ButtonType]);
  HTMLTextBuilder.WriteAttribute(aName, WebDataNavigator.Name + NavigatorButtonIDs[WebDataNavigator.Buttons[Index].ButtonType]);
  HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebDataNavigatorRenderer.WriteEdit;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, 2 * WebDataNavigator.ButtonWidth);
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aName, WebDataNavigator.Name + 'PageSizeEdit');
  HTMLTextBuilder.WriteAttribute(aId, WebDataNavigator.Name + 'PageSizeEdit');
  HTMLTextBuilder.WriteAttribute(aType, 'text');
  HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
  HTMLTextBuilder.WriteAttribute(aValue, WebDataNavigator.PageSize);
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebDataNavigator.Height, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, 2 * WebDataNavigator.ButtonWidth, 'px');
  HTMLTextBuilder.WriteEventAttribute(eOnFocus, Format('OnNEFocus(''%s'')', [WebDataNavigator.Name]));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebDataNavigatorRenderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  WriteID;
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  WriteHint;
  WritePopupMenu;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteAttribute(aHeight, WebDataNavigator.Height);
  for I := 0 to WebDataNavigator.Buttons.Count - 1 do
  begin
    if WebDataNavigator.Buttons[I].Visible then
    begin
      if WebDataNavigator.Buttons[I].ButtonType = nbPageSize then WriteEdit
      else WriteButton(I);
    end;
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebDataNavigatorRenderer.WriteScripts;
begin
  WriteEventsScript;
  HTMLTextBuilder.WriteText('_DataNavigator = CreateDataNavigator();');
  HTMLTextBuilder.WriteText(Format('  _DataNavigator.Name = "%s";', [WebDataNavigator.Name]));
  HTMLTextBuilder.WriteText(Format('  _DataNavigator.PageSize = %d;', [WebDataNavigator.PageSize]));
  HTMLTextBuilder.WriteText(Format('  _DataNavigator.ProcessPageSizeSrc = "%s";', [QualifyImageFileName(cxWebNavigatorImgs[nbApplyPageSize])]));
  HTMLTextBuilder.WriteText(Format('  _DataNavigator.ApplyPageSizeSrc = "%s";', [QualifyImageFileName(cxWebNavigatorImgs[nbPost])]));
  WriteEvents;
  if(Assigned(WebDataNavigator.OnChangePageSize)) then
    HTMLTextBuilder.WriteText('  _DataNavigator.AssignOnChangePageSize = true;');
end;

class procedure TcxCustomWebDataNavigatorRenderer.WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  TcxNavigatorButtonStyle.WriteStyle(AHTMLTextBuilder);
end;

class procedure TcxCustomWebDataNavigatorRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxDataNavigatorScriptName);
end;

{ TcxCustomWebDataNavigatorNS4Renderer }

procedure TcxCustomWebDataNavigatorNS4Renderer.WriteButtonAction(Index: Integer);
var
  AType: TcxWebNavigatorButtonType;
begin
  AType := WebDataNavigator.Buttons[Index].ButtonType;
  if not Assigned(WebDataNavigator.Buttons[Index].OnClick) then
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:' + NavigatorButtonActionString[AType],
        [WebDataNavigator.Name]))
  else
    HTMLTextBuilder.WriteAttribute(aHref, Format('javascript:__doPostBack(''%s'', ''%s:%d'');',
        [WebDataNavigator.Name, 'CLICK', Index]));

end;

procedure TcxCustomWebDataNavigatorNS4Renderer.WriteButton(Index: Integer);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, WebDataNavigator.ButtonWidth);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, WebDataNavigator.Height);
  HTMLTextBuilder.WriteAttribute(aWidth, WebDataNavigator.ButtonWidth);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aHeight, WebDataNavigator.Height - 2);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);
  HTMLTextBuilder.WriteAttribute(aBgcolor, '#D4D0C8');
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, True, False);
  WriteButtonAction(Index);

  if (WebDataNavigator.Images <> nil) and
    (WebDataNavigator.Images.ValidIndex(WebDataNavigator.Buttons[Index].ImageIndex)) then
    WebDataNavigator.Images.Images[WebDataNavigator.Buttons[Index].ImageIndex].WriteHTML(HTMLTextBuilder)
  else if WebDataNavigator.Buttons[Index].ButtonType <> nbCustom then
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(cxWebNavigatorImgs[WebDataNavigator.Buttons[Index].ButtonType]));
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    WriteButtonHint(Index);
  end;
//  HTMLTextBuilder.WriteAttribute(aId, WebDataNavigator.Name + NavigatorButtonIDs[WebDataNavigator.Buttons[Index].ButtonType]);
  HTMLTextBuilder.WriteAttribute(aName, WebDataNavigator.Name + NavigatorButtonIDs[WebDataNavigator.Buttons[Index].ButtonType]);  
  HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);


  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebDataNavigatorNS4Renderer.WriteEdit;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, 2 * WebDataNavigator.ButtonWidth);
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
  HTMLTextBuilder.WriteAttribute(aName, WebDataNavigator.Name + 'PageSizeEdit');
  HTMLTextBuilder.WriteAttribute(aType, 'text');
  HTMLTextBuilder.WriteAttribute(aDisabled);
  HTMLTextBuilder.WriteAttribute(aSize, 2 * WebDataNavigator.ButtonWidth div 5);
  HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
  HTMLTextBuilder.WriteAttribute(aValue, WebDataNavigator.PageSize);
  HTMLTextBuilder.WriteStyleAttribute(saFontSize, WebDataNavigator.Height - 2);
  HTMLTextBuilder.WriteStyleAttribute(saWidth, 2 * WebDataNavigator.ButtonWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebDataNavigator.Height, 'px');
  HTMLTextBuilder.WriteEventAttribute(eOnFocus, Format('OnNEFocus(''%s'')', [WebDataNavigator.Name]));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

class function TcxCustomWebDataNavigatorNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

{ TcxCustomWebDataNavigatorNS6Renderer }

procedure TcxCustomWebDataNavigatorNS6Renderer.WriteButtonAction(Index: Integer);
begin
  if Assigned(WebDataNavigator.Buttons[Index].OnClick) then
    HTMLTextBuilder.WriteEventAttribute(eOnClick, Format('__doPostBack(''%s'', ''%s:%d'');',
        [WebDataNavigator.Name, 'CLICK', Index]));
end;

procedure TcxCustomWebDataNavigatorNS6Renderer.WriteButton(Index: Integer);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, WebDataNavigator.ButtonWidth);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aClass, DefaultStyleName);
  HTMLTextBuilder.WriteStyleAttribute(saHeight, WebDataNavigator.Height - 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebDataNavigator.ButtonWidth - 2, 'px');
  WriteButtonEvents(Index);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, '100%');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  if (WebDataNavigator.Images <> nil) and
    (WebDataNavigator.Images.ValidIndex(WebDataNavigator.Buttons[Index].ImageIndex)) then
    WebDataNavigator.Images.Images[WebDataNavigator.Buttons[Index].ImageIndex].WriteHTML(HTMLTextBuilder)
  else if WebDataNavigator.Buttons[Index].ButtonType <> nbCustom then
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
    HTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(cxWebNavigatorImgs[WebDataNavigator.Buttons[Index].ButtonType]));
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    WriteButtonHint(Index);
  end;
  HTMLTextBuilder.WriteAttribute(aId, WebDataNavigator.Name + NavigatorButtonIDs[WebDataNavigator.Buttons[Index].ButtonType]);
  HTMLTextBuilder.WriteAttribute(aName, WebDataNavigator.Name + NavigatorButtonIDs[WebDataNavigator.Buttons[Index].ButtonType]);
  HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
  WriteButtonAction(Index);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

class function TcxCustomWebDataNavigatorNS6Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS6;
end;

initialization
  RegisterClasses([TcxWebDataNavigatorButton, TcxCustomWebDataNavigator]);

end.


