{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Controls Library                                 }
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
unit cxWebNavBar;

{$I cxVer.inc}

interface

uses
  Classes, TypInfo,
  cxWebIntf, cxWebTypes, cxWebClasses, cxWebControls, cxWebImgList, cxWebRender;

type
  TcxWebNavBar = class;

  TcxWebNavBarGroupItem = class(TCollectionItem)
  private
    FHint: string;
    FImageIndex: Integer;
    FText: string;
    FURL: TcxURL;

    procedure SetHint(Value: string);
    procedure SetImageIndex(Value: Integer);
    procedure SetText(Value: string);
    procedure SetURL(Value: TcxURL);
  protected
    function WebNavBar: TcxWebNavBar;
    procedure UpdateWebNavBar;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Hint: string read FHint write SetHint;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Text: string read FText write SetText;
    property URL: TcxURL read FURL write SetURL;
  end;

  TcxWebNavBarGroup = class;
  TcxWebNavBarGroupItems = class(TCollection)
  private
    FWebNavBarGroup: TcxWebNavBarGroup;

    function GetItem(Index: Integer): TcxWebNavBarGroupItem;
    procedure SetItem(Index: Integer; Value: TcxWebNavBarGroupItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AWebNavBarGroup: TcxWebNavBarGroup);
    function Add: TcxWebNavBarGroupItem;

    property WebNavBarGroup: TcxWebNavBarGroup read FWebNavBarGroup;
    property Items[Index: Integer]: TcxWebNavBarGroupItem read GetItem write SetItem; default;
  end;

  TcxWebNavBarGroup = class(TCollectionItem)
  private
    FExpanded: Boolean;
    FItems: TcxWebNavBarGroupItems;
    FText: string;

    procedure SetExpanded(Value: Boolean);
    procedure SetItems(Value: TcxWebNavBarGroupItems);
    procedure SetText(Value: string);
  protected
    function WebNavBar: TcxWebNavBar;
    procedure UpdateWebNavBar;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Expanded: Boolean read FExpanded write SetExpanded;
    property Items: TcxWebNavBarGroupItems read FItems write SetItems;
    property Text: string read FText write SetText;
  end;

  TcxWebNavBarGroups = class(TCollection)
  private
    FWebNavBar: TcxWebNavBar;

    function GetItem(Index: Integer): TcxWebNavBarGroup;
    procedure SetItem(Index: Integer; Value: TcxWebNavBarGroup);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AWebNavBar: TcxWebNavBar);
    function Add: TcxWebNavBarGroup;

    property WebNavBar: TcxWebNavBar read FWebNavBar;
    property Items[Index: Integer]: TcxWebNavBarGroup read GetItem write SetItem; default;
  end;

  TcxWebNavBar = class(TcxWebControl)
  private
    FGroups: TcxWebNavBarGroups;
    FHeaderStyles: TcxWebStyles;
    FHeaderCollapsedStyles: TcxWebStyles;
    FImages: TcxWebImageList;
    FLeftExpandedImageIndex: Integer;
    FLeftCollapsedImageIndex: Integer;
    FRightExpandedImageIndex: Integer;
    FRightCollapsedImageIndex: Integer;
    FSeparatorWidth: Integer;

    procedure SetGroups(Value: TcxWebNavBarGroups);
    procedure SetHeaderStyles(Value: TcxWebStyles);
    procedure SetHeaderCollapsedStyles(Value: TcxWebStyles);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { renderers}
    procedure RegisterRenderers; override;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Groups: TcxWebNavBarGroups read FGroups write SetGroups;
    property HeaderStyles: TcxWebStyles read FHeaderStyles write SetHeaderStyles;
    property HeaderCollapsedStyles: TcxWebStyles read FHeaderCollapsedStyles write SetHeaderCollapsedStyles;
    property Images: TcxWebImageList read FImages write FImages;
    property LeftExpandedImageIndex: Integer read FLeftExpandedImageIndex write FLeftExpandedImageIndex;
    property LeftCollapsedImageIndex: Integer read FLeftCollapsedImageIndex write FLeftCollapsedImageIndex;
    property PopupMenu;
    property PopupShowingType;
    property RightExpandedImageIndex: Integer read FRightExpandedImageIndex write FRightExpandedImageIndex;
    property RightCollapsedImageIndex: Integer read FRightCollapsedImageIndex write FRightCollapsedImageIndex;
    property SeparatorWidth: Integer read FSeparatorWidth write FSeparatorWidth;
    property Styles;    
  end;

  TcxWebNavBarDragWindowStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebNavBarPartItemStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebNavBarHeadRightStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebNavBarHeadTextStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebNavBarHeadTextClpStyle = class(TcxWebNavBarHeadTextStyle)
    class function GetName: string; override;
  end;

  TcxWebNavBarHeadStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebNavBarHeadClpStyle = class(TcxWebNavBarHeadStyle)
    class function GetName: string; override;
  end;

  TcxWebNavBarRenderer = class(TcxWebControlRenderer)
  private
    function GetWebNavBar: TcxWebNavBar;

    function LeftExpandedImageSrc: string;
    function LeftCollapsedImageSrc: string;
    function RightExpandedImageSrc: string;
    function RightCollapsedImageSrc: string;
    function BackColor: TcxWebColor;
    function BorderColor: TcxWebColor;
    function BorderWidth: TcxWebColor;
    function ForeColor: TcxWebColor;
    function HeaderBackColor: TcxWebColor;
    function HeaderBorderColor: TcxWebColor;
    function HeaderForeColor: TcxWebColor;
    function HeaderCollapsedBackColor: TcxWebColor;
    function HeaderCollapsedBorderColor: TcxWebColor;
    function HeaderCollapsedForeColor: TcxWebColor;
  protected
    function IsExpanded(GroupIndex: Integer): Boolean; virtual;
    procedure WriteHeaderStyle(GroupIndex: Integer); virtual;
    procedure WriteHeaderTextStyle(GroupIndex: Integer); virtual;
    procedure WriteHeaderRightStyle(GroupIndex: Integer); virtual;
    procedure WriteHeaderBorderStyle(GroupIndex: Integer); virtual;

    procedure WriteGroup(Index: Integer); virtual;
    procedure WriteGroupTitle(Index: Integer); virtual;
    procedure WriteGroupBody(Index: Integer); virtual;
    procedure WriteItem(GroupIndex, Index: Integer); virtual;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHiddenFormElements; override;
    procedure WriteHTML; override;
    class procedure WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
    procedure WriteScripts; override;
    class procedure WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder); override;

    property WebNavBar: TcxWebNavBar read GetWebNavBar;
  end;

  TcxWebNavBarNS4Renderer = class(TcxWebNavBarRenderer)
  protected
    function IsExpanded(GroupIndex: Integer): Boolean; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxWebNavBarOperaRenderer = class(TcxWebNavBarNS4Renderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

implementation

uses
  SysUtils, StrUtils,
  cxWebConsts, cxWebColors, cxWebGraphics, cxWebUtils, cxWebScriptFactory;

{ TcxWebNavBarGroupItem }

constructor TcxWebNavBarGroupItem.Create(Collection: TCollection);
begin
  inherited;
  FURL := TcxURL.Create(WebNavBar);
  FImageIndex := -1;
  Text := 'Item';
end;

destructor TcxWebNavBarGroupItem.Destroy;
begin
  FURL.Free;
  inherited;
end;

function TcxWebNavBarGroupItem.WebNavBar: TcxWebNavBar;
begin
  Result := (Collection as TcxWebNavBarGroupItems).WebNavBarGroup.WebNavBar;
end;

procedure TcxWebNavBarGroupItem.UpdateWebNavBar;
begin
  if WebNavBar <> nil then
    WebNavBar.UpdateDesignerContext;
end;

procedure TcxWebNavBarGroupItem.SetHint(Value: string);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    UpdateWebNavBar;
  end;
end;

procedure TcxWebNavBarGroupItem.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    UpdateWebNavBar;
  end;
end;

procedure TcxWebNavBarGroupItem.SetText(Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    UpdateWebNavBar;
  end;
end;

procedure TcxWebNavBarGroupItem.SetURL(Value: TcxURL);
begin
  FURL.Assign(Value);
  UpdateWebNavBar;  
end;

{ TcxWebNavBarGroupItems }

function TcxWebNavBarGroupItems.Add: TcxWebNavBarGroupItem;
begin
  Result := TcxWebNavBarGroupItem(inherited Add);
end;

constructor TcxWebNavBarGroupItems.Create(AWebNavBarGroup: TcxWebNavBarGroup);
begin
  FWebNavBarGroup := AWebNavBarGroup;
  inherited Create(TcxWebNavBarGroupItem);
end;

function TcxWebNavBarGroupItems.GetItem(Index: Integer): TcxWebNavBarGroupItem;
begin
  Result := TcxWebNavBarGroupItem(inherited Items[Index]);
end;

function TcxWebNavBarGroupItems.GetOwner: TPersistent;
begin
  Result := FWebNavBarGroup;
end;

procedure TcxWebNavBarGroupItems.Update(Item: TCollectionItem);
begin
  WebNavBarGroup.UpdateWebNavBar;
end;

procedure TcxWebNavBarGroupItems.SetItem(Index: Integer; Value: TcxWebNavBarGroupItem);
begin
  Items[Index].Assign(Value);
end;

{ TcxWebNavBarGroup }

constructor TcxWebNavBarGroup.Create(Collection: TCollection);
begin
  inherited;
  FItems := TcxWebNavBarGroupItems.Create(Self);
  Expanded := True;
  Text := 'Group';
end;

destructor TcxWebNavBarGroup.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TcxWebNavBarGroup.WebNavBar: TcxWebNavBar;
begin
  Result := (Collection as TcxWebNavBarGroups).WebNavBar;
end;

procedure TcxWebNavBarGroup.UpdateWebNavBar;
begin
  if WebNavBar <> nil then
    WebNavBar.UpdateDesignerContext;
end;

procedure TcxWebNavBarGroup.SetExpanded(Value: Boolean);
begin
  if FExpanded <> Value then
  begin
    FExpanded := Value;
    UpdateWebNavBar;
  end;
end;

procedure TcxWebNavBarGroup.SetItems(Value: TcxWebNavBarGroupItems);
begin
  FItems.Assign(Value);
end;

procedure TcxWebNavBarGroup.SetText(Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    UpdateWebNavBar;
  end;
end;

{ TcxWebNavBarGroups }

function TcxWebNavBarGroups.Add: TcxWebNavBarGroup;
begin
  Result := TcxWebNavBarGroup(inherited Add);
end;

constructor TcxWebNavBarGroups.Create(AWebNavBar: TcxWebNavBar);
begin
  FWebNavBar := AWebNavBar;
  inherited Create(TcxWebNavBarGroup);
end;

function TcxWebNavBarGroups.GetItem(Index: Integer): TcxWebNavBarGroup;
begin
  Result := TcxWebNavBarGroup(inherited Items[Index]);
end;

function TcxWebNavBarGroups.GetOwner: TPersistent;
begin
  Result := FWebNavBar;
end;

procedure TcxWebNavBarGroups.Update(Item: TCollectionItem);
begin
  WebNavBar.UpdateDesignerContext;
end;

procedure TcxWebNavBarGroups.SetItem(Index: Integer; Value: TcxWebNavBarGroup);
begin
  Items[Index].Assign(Value);
end;

{ TcxWebNavBar }

constructor TcxWebNavBar.Create(AOwner: TComponent);
begin
  inherited;
  FGroups := TcxWebNavBarGroups.Create(Self);
  FHeaderStyles := TcxWebStyles.Create(Self);
  FHeaderCollapsedStyles := TcxWebStyles.Create(Self);
  FSeparatorWidth := 1;
  FLeftExpandedImageIndex := -1;
  FLeftCollapsedImageIndex := -1;
  FRightExpandedImageIndex := -1;
  FRightCollapsedImageIndex := -1;
  Height := 200;
  Width := 200;
end;

destructor TcxWebNavBar.Destroy;
begin
  FHeaderStyles.Free;
  FHeaderCollapsedStyles.Free;
  FGroups.Free;
  inherited;
end;

procedure TcxWebNavBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
  if not IsDestroying and (AComponent is TcxWebStyleItem) then
  begin
    if HeaderStyles <> nil then
      HeaderStyles.Notification(AComponent, Operation);
    if HeaderCollapsedStyles <> nil then
      HeaderCollapsedStyles.Notification(AComponent, Operation);
  end;
end;

procedure TcxWebNavBar.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebNavBarRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebNavBarNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebNavBarOperaRenderer);
end;

procedure TcxWebNavBar.DoSetValues;
var
  I: Integer;
  S: string;
  GroupList: TList;

  procedure AssignGroupProperties(Index: Integer);
  var
    APos, AGroupCount: Integer;
    AStr, AGroupStr: string;
  begin
    AStr := S;
    AGroupCount := 0;
    while True do
    begin
      APos := Pos(';', Astr);
      if APos < 1 then break;
      AGroupStr := LeftStr(AStr, APos);
      if Pos(Format('Group%d', [Index]), AGroupStr) > 0 then
      begin
        TcxWebNavBarGroup(GroupList.Items[Index]).Expanded := Pos('open', AGroupStr) > 0;
        TcxWebNavBarGroup(GroupList.Items[Index]).Index := AGroupCount;
        break
      end;
      Inc(AGroupCount);
      AStr := RightStr(AStr, Length(AStr) - APos);
    end;
  end;
begin
  S := WebValuesHelper.Values.Values[Name + 'State'];
  GroupList := TList.Create;
  try
    for I := 0 to Groups.Count - 1 do
      GroupList.Add(Groups[I]);
    for I := 0 to GroupList.Count - 1 do
      AssignGroupProperties(I);
  finally
    GroupList.Free;
  end;
end;

procedure TcxWebNavBar.RegisterValues;
begin
  WebValuesHelper.RegisterValue(Name + 'State', '');
end;

procedure TcxWebNavBar.SetGroups(Value: TcxWebNavBarGroups);
begin
  FGroups.Assign(Value);
end;

procedure TcxWebNavBar.SetHeaderStyles(Value: TcxWebStyles);
begin
  FHeaderStyles.Assign(Value);
end;

procedure TcxWebNavBar.SetHeaderCollapsedStyles(Value: TcxWebStyles);
begin
  FHeaderCollapsedStyles.Assign(Value);
end;

{ TcxWebNavBarDragWindowStyle }

class function TcxWebNavBarDragWindowStyle.GetName: string;
begin
  Result := 'clsDragWindow'
end;

class procedure TcxWebNavBarDragWindowStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderColor, '#000000');
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#666666');
  HTMLTextBuilder.WriteUnknownStyleAttribute('filter:alpha( opacity=20 );');
  HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  HTMLTextBuilder.WriteStyleAttribute(saDisplay, 'none');
end;

{ TcxWebNavBarPartItemStyle }

class function TcxWebNavBarPartItemStyle.GetName: string;
begin
  Result := 'clsPartItem';
end;

class procedure TcxWebNavBarPartItemStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saMarginTop, 0);
  HTMLTextBuilder.WriteStyleAttribute(saMarginBottom, 0);
  HTMLTextBuilder.WriteStyleAttribute(saPaddingTop, 0);
  HTMLTextBuilder.WriteStyleAttribute(saPaddingBottom, 0);
end;

{ TcxWebNavBarHeadRightStyle }

class function TcxWebNavBarHeadRightStyle.GetName: string;
begin
  Result := 'clsHeadRight';
end;

class procedure TcxWebNavBarHeadRightStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saCursor, 'hand');
end;

{ TcxWebNavBarHeadTextStyle }

class function TcxWebNavBarHeadTextStyle.GetName: string;
begin
  Result := 'clsHeadText';
end;

class procedure TcxWebNavBarHeadTextStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saCursor, 'move');
end;

{ TcxWebNavBarHeadTextClpStyle }

class function TcxWebNavBarHeadTextClpStyle.GetName: string;
begin
  Result := 'clsHeadTextClp';
end;

{ TcxWebNavBarHeadStyle }

class function TcxWebNavBarHeadStyle.GetName: string;
begin
  Result := 'clsHead';
end;

class procedure TcxWebNavBarHeadStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saCursor, 'move');
end;

{ TcxWebNavBarHeadClpStyle }

class function TcxWebNavBarHeadClpStyle.GetName: string;
begin
  Result := 'clsHeadClp';
end;

{ TcxWebNavBarRenderer }

function TcxWebNavBarRenderer.GetWebNavBar: TcxWebNavBar;
begin
  Result := WebControl as TcxWebNavBar;
end;

function TcxWebNavBarRenderer.IsExpanded(GroupIndex: Integer): Boolean;
begin
  Result := WebNavBar.Groups[GroupIndex].Expanded;
end;

function TcxWebNavBarRenderer.LeftExpandedImageSrc: string;
begin
  if (WebNavBar.Images <> nil) and (WebNavBar.Images.ValidIndex(WebNavBar.LeftExpandedImageIndex)) then
    Result := WebNavBar.Images.Images[WebNavBar.LeftExpandedImageIndex].FullFilePath
  else Result := QualifyImageFileName(scxnbLeftExpandedImageName);
end;

function TcxWebNavBarRenderer.LeftCollapsedImageSrc: string;
begin
  if (WebNavBar.Images <> nil) and (WebNavBar.Images.ValidIndex(WebNavBar.LeftCollapsedImageIndex)) then
    Result := WebNavBar.Images.Images[WebNavBar.LeftCollapsedImageIndex].FullFilePath
  else Result := QualifyImageFileName(scxnbLeftCollapsedImageName);
end;

function TcxWebNavBarRenderer.RightExpandedImageSrc: string;
begin
  if (WebNavBar.Images <> nil) and (WebNavBar.Images.ValidIndex(WebNavBar.RightExpandedImageIndex)) then
    Result := WebNavBar.Images.Images[WebNavBar.RightExpandedImageIndex].FullFilePath
  else Result := QualifyImageFileName(scxnbRightExpandedImageName);
end;

function TcxWebNavBarRenderer.RightCollapsedImageSrc: string;
begin
  if (WebNavBar.Images <> nil) and (WebNavBar.Images.ValidIndex(WebNavBar.RightCollapsedImageIndex)) then
    Result := WebNavBar.Images.Images[WebNavBar.RightCollapsedImageIndex].FullFilePath
  else Result := QualifyImageFileName(scxnbRightCollapsedImageName);
end;

function TcxWebNavBarRenderer.BackColor: TcxWebColor;
begin
  if (WebNavBar.Styles.Default <> nil) and
    (wsavColor in WebNavBar.Styles.Default.Style.Shading.AssignedValues) then
    Result := WebNavBar.Styles.Default.Style.Shading.Color
  else Result := clWebWhite;
end;

function TcxWebNavBarRenderer.BorderColor: TcxWebColor;
begin
  Result := HeaderBorderColor;
end;

function TcxWebNavBarRenderer.BorderWidth: TcxWebColor;
begin
  if (WebNavBar.Styles.Default <> nil) and
    (wbavWidth in WebNavBar.Styles.Default.Style.Borders.Bottom.AssignedValues) and
    (WebNavBar.Styles.Default.Style.Borders.Bottom.Width =
    WebNavBar.Styles.Default.Style.Borders.Width) then
    Result := WebNavBar.Styles.Default.Style.Borders.Width
  else Result := 1;
end;

function TcxWebNavBarRenderer.ForeColor: TcxWebColor;
begin
  if WebNavBar.Styles.Default <> nil then
    Result := WebNavBar.Styles.Default.Style.Font.Color
  else Result := clWebDarkSlateGray;
end;

function TcxWebNavBarRenderer.HeaderBackColor: TcxWebColor;
begin
  if (WebNavBar.HeaderStyles.Default <> nil) and
    (wsavColor in WebNavBar.HeaderStyles.Default.Style.Shading.AssignedValues) then
    Result := WebNavBar.HeaderStyles.Default.Style.Shading.Color
  else Result := clWebSteelBlue;
end;

function TcxWebNavBarRenderer.HeaderBorderColor: TcxWebColor;
begin
  Result := HeaderBackColor;
end;

function TcxWebNavBarRenderer.HeaderForeColor: TcxWebColor;
begin
  if WebNavBar.HeaderStyles.Default <> nil then
    Result := WebNavBar.HeaderStyles.Default.Style.Font.Color
  else Result := clWebWhite;
end;

function TcxWebNavBarRenderer.HeaderCollapsedBackColor: TcxWebColor;
begin
  if (WebNavBar.HeaderCollapsedStyles.Default <> nil) and
    (wsavColor in WebNavBar.HeaderCollapsedStyles.Default.Style.Shading.AssignedValues) then
    Result := WebNavBar.HeaderCollapsedStyles.Default.Style.Shading.Color
  else Result := clWebSilver;
end;

function TcxWebNavBarRenderer.HeaderCollapsedBorderColor: TcxWebColor;
begin
  if (WebNavBar.HeaderCollapsedStyles.Default <> nil) and
    (wbavColor in WebNavBar.HeaderCollapsedStyles.Default.Style.Borders.Bottom.AssignedValues) and
    (WebNavBar.HeaderCollapsedStyles.Default.Style.Borders.Bottom.Color =
    WebNavBar.HeaderCollapsedStyles.Default.Style.Borders.Color) then
    Result := WebNavBar.HeaderCollapsedStyles.Default.Style.Borders.Color
  else Result := clWebDarkGray;
end;

function TcxWebNavBarRenderer.HeaderCollapsedForeColor: TcxWebColor;
begin
  if WebNavBar.HeaderCollapsedStyles.Default <> nil then
    Result := WebNavBar.HeaderCollapsedStyles.Default.Style.Font.Color
  else Result := clWebDarkBlue;
end;

class procedure TcxWebNavBarRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxNavBarScriptName);
end;

procedure TcxWebNavBarRenderer.WriteHiddenFormElements;
var
  I: Integer;
  S: string;
begin
  for I := 0 to WebNavBar.Groups.Count - 1 do
    if WebNavBar.Groups[I].Expanded then
      S := S + Format('Group%d:open;', [I])
    else S := S + Format('Group%d:close;', [I]);
  WriteHiddenField(WebNavBar.Name + 'State', S);
end;

procedure TcxWebNavBarRenderer.WriteHeaderStyle(GroupIndex: Integer);
begin
  if IsExpanded(GroupIndex) then
  begin
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(HeaderBackColor));
    HTMLTextBuilder.WriteAttribute(aClass, TcxWebNavBarHeadStyle.GetName);
  end
  else
  begin
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(HeaderCollapsedBackColor));
    HTMLTextBuilder.WriteAttribute(aClass, TcxWebNavBarHeadClpStyle.GetName);
  end;
end;

procedure TcxWebNavBarRenderer.WriteHeaderTextStyle(GroupIndex: Integer);
begin
  if IsExpanded(GroupIndex) then
  begin
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(HeaderBackColor));
    HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(HeaderForeColor));
    HTMLTextBuilder.WriteAttribute(aClass, TcxWebNavBarHeadTextStyle.GetName);
  end
  else
  begin
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(HeaderCollapsedBackColor));
    HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(HeaderCollapsedForeColor));
    HTMLTextBuilder.WriteAttribute(aClass, TcxWebNavBarHeadTextClpStyle.GetName);
  end;
end;

procedure TcxWebNavBarRenderer.WriteHeaderRightStyle(GroupIndex: Integer);
begin
  if IsExpanded(GroupIndex) then
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(HeaderBackColor))
  else HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(HeaderCollapsedBackColor));
  HTMLTextBuilder.WriteAttribute(aClass, TcxWebNavBarHeadRightStyle.GetName);
end;

procedure TcxWebNavBarRenderer.WriteHeaderBorderStyle(GroupIndex: Integer);
begin
  if IsExpanded(GroupIndex) then
    HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(HeaderBorderColor))
  else HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(HeaderCollapsedBorderColor));
  HTMLTextBuilder.WriteAttribute(aClass, 'clsBorder');
end;

procedure TcxWebNavBarRenderer.WriteGroup(Index: Integer);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aId, Format('Group%d', [Index]));
  HTMLTextBuilder.WriteAttribute(aClass, 'clsPart');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteEventAttribute(eOnMouseDown, 'OnMouseDown(event)');
  HTMLTextBuilder.WriteEventAttribute(eOnClick, 'OnPartClick(event)');
  HTMLTextBuilder.WriteEventAttribute(eOnDragStart, 'OnDragStart(event)');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 7);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  WriteGroupTitle(Index);
  if IsExpanded(Index) or not WebNavBar.IsDesigning then
    WriteGroupBody(Index);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 7);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxWebNavBarRenderer.WriteGroupTitle(Index: Integer);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 2);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  WriteHeaderBorderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 2);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderBorderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  WriteHeaderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderBorderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderBorderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderStyle(Index);
  HTMLTextBuilder.WriteAttribute(aId, 'LeftImageCell');
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
  HTMLTextBuilder.WriteAttribute(aId, 'LeftImage');
  WriteHeaderStyle(Index);
  if IsExpanded(Index) then
    HTMLTextBuilder.WriteAttribute(aSrc, LeftExpandedImageSrc)
  else HTMLTextBuilder.WriteAttribute(aSrc, LeftCollapsedImageSrc);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderTextStyle(Index);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);
  HTMLTextBuilder.WriteAttribute(aId, 'TextContent');
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'middle');
  if WebNavBar.HeaderStyles.Default <> nil then
    WebNavBar.HeaderStyles.Default.Style.Font.WriteHTML(HTMLTextBuilder);
  HTMLTextBuilder.WriteText(WebNavBar.Groups[Index].Text, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderRightStyle(Index);
  HTMLTextBuilder.WriteAttribute(aId, 'RightImageCell');
  HTMLTextBuilder.WriteAttribute(aAlign, 'right');
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
  HTMLTextBuilder.WriteAttribute(aId, 'RightImage');
  if IsExpanded(Index) then
    HTMLTextBuilder.WriteAttribute(aSrc, RightExpandedImageSrc)
  else HTMLTextBuilder.WriteAttribute(aSrc, RightCollapsedImageSrc);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteHeaderBorderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 7);
  WriteHeaderBorderStyle(Index);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxWebNavBarRenderer.WriteGroupBody(Index: Integer);
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aId, 'ContentCell');
  HTMLTextBuilder.WriteAttribute(aColspan, 7);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aId, 'ContentTable');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  if (HTMLTextBuilder.Browser = TcxWebBrowserIE4) or (HTMLTextBuilder.Browser = TcxWebBrowserIE) then
    HTMLTextBuilder.WriteStyleAttribute(saDisplay, 'inline');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BorderColor));
  WriteInvisibleImage(BorderWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BackColor));
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  for I := 0 to WebNavBar.Groups[Index].Items.Count - 1 do
    WriteItem(Index, I);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  WriteInvisibleImage(1, WebNavBar.SeparatorWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BorderColor));
  WriteInvisibleImage(BorderWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(BorderColor));
  WriteInvisibleImage(1, BorderWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxWebNavBarRenderer.WriteItem(GroupIndex, Index: Integer);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  WriteInvisibleImage(1, WebNavBar.SeparatorWidth);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aId, Format('GroupItem%d', [Index]));
  HTMLTextBuilder.WriteAttribute(aValign, 'middle');
  if WebNavBar.Styles.Default <> nil then
    WebNavBar.Styles.Default.Style.Font.WriteHTML(HTMLTextBuilder);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagUl, True, False);
  HTMLTextBuilder.WriteAttribute(aClass, TcxWebNavBarPartItemStyle.GetName);
  HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(ForeColor));
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagLi, False, False);
  HTMLTextBuilder.WriteAttribute(aClass, TcxWebNavBarPartItemStyle.GetName);
  HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(ForeColor));
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  if WebNavBar.ShowHint then
    HTMLTextBuilder.WriteAttribute(aTitle, WebNavBar.Groups[GroupIndex].Items[Index].Hint);
  if WebNavBar.Groups[GroupIndex].Items[Index].URL <> nil then
    WebNavBar.Groups[GroupIndex].Items[Index].URL.Write(HTMLTextBuilder);
  if (WebNavBar.Images <> nil) and (WebNavBar.Images.ValidIndex(WebNavBar.Groups[GroupIndex].Items[Index].ImageIndex)) then
  begin
    WebNavBar.Images.Images[WebNavBar.Groups[GroupIndex].Items[Index].ImageIndex].WriteHTML(HTMLTextBuilder);
    HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  HTMLTextBuilder.WriteText('&nbsp;&nbsp;', False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  if WebNavBar.ShowHint then
    HTMLTextBuilder.WriteAttribute(aTitle, WebNavBar.Groups[GroupIndex].Items[Index].Hint);
  if WebNavBar.Groups[GroupIndex].Items[Index].URL <> nil then
    WebNavBar.Groups[GroupIndex].Items[Index].URL.Write(HTMLTextBuilder);
  HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(ForeColor));
  if WebNavBar.Styles.Default <> nil then
    WebNavBar.Styles.Default.Style.Font.WriteHTML(HTMLTextBuilder);
  HTMLTextBuilder.WriteText(WebNavBar.Groups[GroupIndex].Items[Index].Text, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagLi, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagUl, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxWebNavBarRenderer.WriteHTML;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  WriteID;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;
  HTMLTextBuilder.WriteAttribute(aClass, 'clsPartContainer');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, WebNavBar.Width);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteAttribute(aValign, 'top');
  for I := 0 to WebNavBar.Groups.Count - 1 do
    WriteGroup(I);
//  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
//  HTMLTextBuilder.WriteAttribute(aID, 'Layout');
//  HTMLTextBuilder.WriteUnknownStyleAttribute('behavior:url(#default#userData)');
//  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

class procedure TcxWebNavBarRenderer.WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  AHTMLTextBuilder.WriteBeginTag(TcxHTMLTagSpan);
  AHTMLTextBuilder.WriteAttribute(aId, 'DragWindow');
  AHTMLTextBuilder.WriteAttribute(aClass, TcxWebNavBarDragWindowStyle.GetName);
  AHTMLTextBuilder.WriteEndTag(TcxHTMLTagSpan);
end;

procedure TcxWebNavBarRenderer.WriteScripts;
begin
  HTMLTextBuilder.WriteText('var ' + WebNavBar.Name + ' = "', True, False);
  HTMLTextBuilder.WriteText(Format('  leftExpandedImage: ''%s'';',
    [StringReplace(LeftExpandedImageSrc, '\', '/', [rfReplaceAll])]), False, False);
  HTMLTextBuilder.WriteText(Format('  leftCollapsedImage: ''%s'';',
    [StringReplace(LeftCollapsedImageSrc, '\', '/', [rfReplaceAll])]), False, False);
  HTMLTextBuilder.WriteText(Format('  rightExpandedImage: ''%s'';',
    [StringReplace(RightExpandedImageSrc, '\', '/', [rfReplaceAll])]), False, False);
  HTMLTextBuilder.WriteText(Format('  rightCollapsedImage: ''%s'';',
    [StringReplace(RightCollapsedImageSrc, '\', '/', [rfReplaceAll])]), False, False);
  HTMLTextBuilder.WriteText(Format('  collapsedForeColor: ''%s'';', [cxWebColorToWebString(HeaderCollapsedForeColor)]), False, False);
  HTMLTextBuilder.WriteText(Format('  collapsedBackColor: ''%s'';', [cxWebColorToWebString(HeaderCollapsedBackColor)]), False, False);
  HTMLTextBuilder.WriteText(Format('  collapsedBorderColor: ''%s'';', [cxWebColorToWebString(HeaderCollapsedBorderColor)]), False, False);
  HTMLTextBuilder.WriteText(Format('  foreColor: ''%s'';', [cxWebColorToWebString(HeaderForeColor)]), False, False);
  HTMLTextBuilder.WriteText(Format('  backColor: ''%s'';', [cxWebColorToWebString(HeaderBackColor)]), False, False);
  HTMLTextBuilder.WriteText('  enableReadState: true;', False, False);
  HTMLTextBuilder.WriteText('  enableWriteState: true;', False, False);
  HTMLTextBuilder.WriteText('  action: ''None''"' + #13#10, False, True);
end;

class procedure TcxWebNavBarRenderer.WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  TcxWebNavBarDragWindowStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebNavBarPartItemStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebNavBarHeadRightStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebNavBarHeadTextStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebNavBarHeadTextClpStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebNavBarHeadStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebNavBarHeadClpStyle.WriteStyle(AHTMLTextBuilder);
end;

{ TcxWebNavBarNS4Renderer }

class function TcxWebNavBarNS4Renderer.IsBrowserSupported(
  AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

function TcxWebNavBarNS4Renderer.IsExpanded(GroupIndex: Integer): Boolean;
begin
  Result := True;
end;

{ TcxWebNavBarOperaRenderer }

class function TcxWebNavBarOperaRenderer.IsBrowserSupported(
  AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

initialization
  RegisterClasses([TcxWebNavBar, TcxWebNavBarGroup, TcxWebNavBarGroupItem]);

end.

