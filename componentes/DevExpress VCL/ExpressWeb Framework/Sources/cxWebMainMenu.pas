{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visiul Web Control Library                                  }
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
unit cxWebMainMenu;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,
  cxWebRender, cxWebClasses, cxWebControls, cxWebGraphics, cxWebUtils, cxWebTypes,
  cxWebImgList, cxWebColors, cxWebMenus, cxWebIntf;

type
  TcxWebMainMenuHelper = class(TcxWebMenuHelper)
  end;

  TcxWebMainMenu = class(TcxWebControl, IcxWebMenu, IcxWebMenuControl)
  private
    FMenuHelper: TcxWebMainMenuHelper;
    FUpdateLock: Integer;

    function GetDesigner: TAbstractcxWebMenuDesigner;
    function GetDisabledStyles: TcxWebStyles;
    function GetHorizontal: Boolean;
    function GetImages: TcxWebImageList;
    function GetImagesBackgroundColor: TcxWebColor;
    function GetItemHeight: Integer;
    function GetItems: TcxWebMenuItem;
    function GetSeparatorColor: TcxWebColor;
    function GetSeparatorWidth: Integer;
    procedure SetDisabledStyles(const Value: TcxWebStyles);
    procedure SetHorizontal(Value: Boolean);
    procedure SetItemHeight(const Value: Integer);
    procedure SetImages(const Value: TcxWebImageList);
    procedure SetImagesBackgroundColor(const Value: TcxWebColor);
    procedure SetSeparatorColor(Value: TcxWebColor);
    procedure SetSeparatorWidth(Value: Integer);

    procedure WebClick(const AParameters: TcxActionParameters);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    { items }
    function IsSeparator(Item: TcxWebMenuItem): Boolean; virtual;
    function SeparatorCount: Integer;
    function ItemCount: Integer;
    { sizes }
    procedure CheckNewSize(var ANewLeft, ANewTop, ANewWidth, ANewHeight: Integer); override;
    function GetItemsHeight: Integer; virtual;
    function GetItemsWidth: Integer; virtual;
    function GetMinHeight: Integer; override;
    function GetMinWidth: Integer; override;
    { action }
    procedure RegisterActions; override;
    { events }
    function GetWebEventsHelper: TcxWebMenuEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebMenuEventsHelper read GetWebEventsHelper;
    { renderers }
    procedure RegisterRenderers; override;
    { scripts }
    procedure ScriptsSubscription; override;

    function GetMenuZIndex: Integer;
    function GetMenuHelper: TcxWebMenuHelper;
    property MenuHelper: TcxWebMainMenuHelper read FMenuHelper;

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure UpdateMenu; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ItemByName(const AName: string): TcxWebMenuItem;

    property Designer: TAbstractcxWebMenuDesigner read GetDesigner;
  published
    property DisabledStyles: TcxWebStyles read GetDisabledStyles write SetDisabledStyles;
    property Horizontal: Boolean read GetHorizontal write SetHorizontal;
    property Images: TcxWebImageList read GetImages write SetImages;
    property ImagesBackgroundColor: TcxWebColor read GetImagesBackgroundColor write SetImagesBackgroundColor;    
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    property Items: TcxWebMenuItem read GetItems;
    property SeparatorColor: TcxWebColor read GetSeparatorColor write SetSeparatorColor;
    property SeparatorWidth: Integer read GetSeparatorWidth write SetSeparatorWidth;
    property Styles;
  end;

  TcxWebMainMenuRenderer = class(TcxWebControlRenderer)
  private
    function GetMainMenu: TcxWebMainMenu;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteScripts; override;
    procedure WriteOutOfFormHTML; override;
    procedure WriteHTML; override;
    class procedure WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder); override;

    function MenuHelper: TcxWebMainMenuHelper;
    property MainMenu: TcxWebMainMenu read GetMainMenu;
  end;

implementation

uses
  cxWebConsts, cxWebScriptFactory;

{ TcxWebMainMenu }

constructor TcxWebMainMenu.Create(AOwner: TComponent);
begin
  inherited;
  FMenuHelper := TcxWebMainMenuHelper.Create(Self);
  FUpdateLock := 0;
  Width := 150;
  Height := 22;
  Horizontal := true;
end;

destructor TcxWebMainMenu.Destroy;
begin
  FreeAndNil(FMenuHelper);
  inherited;
end;

function TcxWebMainMenu.ItemByName(const AName: string): TcxWebMenuItem;
begin
  Result := MenuHelper.ItemByName(AName);
end;

function TcxWebMainMenu.GetDesigner: TAbstractcxWebMenuDesigner;
begin
  Result := MenuHelper.Designer;
end;

function TcxWebMainMenu.GetHorizontal: Boolean;
begin
  Result := MenuHelper.Horizontal;
end;

function TcxWebMainMenu.GetItems: TcxWebMenuItem;
begin
  Result := MenuHelper.Items;
end;

function TcxWebMainMenu.GetSeparatorColor: TcxWebColor;
begin
  Result := MenuHelper.SeparatorColor;
end;

function TcxWebMainMenu.GetSeparatorWidth: Integer;
begin
  Result := MenuHelper.SeparatorWidth;
end;

procedure TcxWebMainMenu.SetHorizontal(Value: Boolean);
var
  AHeight, AWidth: Integer;
begin
  if MenuHelper.Horizontal <> Value then
  begin
    MenuHelper.Horizontal := Value;
    if not IsLoading and (Items.Count > 0) then
    begin
      if Value then
      begin
        AWidth := GetItemsWidth;
        AHeight := MenuHelper.ItemHeight;
      end
      else
      begin
        AWidth := Items.Items[0].Width;
        AHeight := GetItemsHeight;
      end;
      SetBounds(Left, Top, AWidth + MenuHelper.BorderLeftWidth(nil) + MenuHelper.BorderRightWidth(nil),
          AHeight + MenuHelper.BorderBottomWidth(nil) + MenuHelper.BorderTopWidth(nil));
    end;
  end;
end;

procedure TcxWebMainMenu.SetSeparatorColor(Value: TcxWebColor);
begin
  MenuHelper.SeparatorColor := Value;
end;

procedure TcxWebMainMenu.SetSeparatorWidth(Value: Integer);
var
  AHeight, AWidth: Integer;
begin
  if MenuHelper.SeparatorWidth <> Value then
  begin
    MenuHelper.SeparatorWidth := Value;
    if not IsLoading and (Items.Count > 1) then
    begin
      if Horizontal then
      begin
        AWidth := GetItemsWidth;
        AHeight := MenuHelper.ItemHeight;
      end
      else
      begin
        AWidth := Items.Items[0].Width;
        AHeight := GetItemsHeight;
      end;
      SetBounds(Left, Top, AWidth + MenuHelper.BorderLeftWidth(nil) + MenuHelper.BorderRightWidth(nil),
          AHeight + MenuHelper.BorderBottomWidth(nil) + MenuHelper.BorderTopWidth(nil));
    end;
  end;
end;

procedure TcxWebMainMenu.WebClick(const AParameters: TcxActionParameters);
begin
  MenuHelper.DoClick(ItemByName(AParameters.ParamString));
end;

procedure TcxWebMainMenu.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TcxWebMainMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if FMenuHelper <> nil then MenuHelper.Notification(AComponent, Operation);
end;

procedure TcxWebMainMenu.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  MenuHelper.Items.GetChildren(Proc, Root);
end;

procedure TcxWebMainMenu.SetChildOrder(Child: TComponent; Order: Integer);
begin
  MenuHelper.Items.SetChildOrder(Child, Order);
end;

function TcxWebMainMenu.IsSeparator(Item: TcxWebMenuItem): Boolean;
begin
  Result := Item.Break = mbBreak;
end;

function TcxWebMainMenu.SeparatorCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do
    if Items.Items[I].Visible then
      if IsSeparator(Items.Items[I]) then Inc(Result);
end;

function TcxWebMainMenu.ItemCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do
    if Items.Items[I].Visible then
      if not IsSeparator(Items.Items[I]) then Inc(Result);
end;

procedure TcxWebMainMenu.CheckNewSize(var ANewLeft, ANewTop, ANewWidth, ANewHeight: Integer);
var
  I: Integer;
begin
  inherited CheckNewSize(ANewLeft, ANewTop, ANewWidth, ANewHeight);
  if (ANewWidth <> Width) or (ANewHeight <> Height) then
    if FUpdateLock = 0 then
      if not IsLoading and (Items.Count > 0) then
      begin
        Dec(ANewWidth, MenuHelper.BorderLeftWidth(nil) + MenuHelper.BorderRightWidth(nil));
        Dec(ANewHeight, MenuHelper.BorderBottomWidth(nil) + MenuHelper.BorderTopWidth(nil));
        if Horizontal then
        begin
          MenuHelper.ItemHeight := ANewHeight;
          for I := 0 to Items.Count - 1 do
            if Items.Items[I].Visible then
              if not IsSeparator(Items.Items[I]) then
                Items.Items[I].Width := (ANewWidth - SeparatorCount * SeparatorWidth) div ItemCount;
          ANewWidth := GetItemsWidth;
        end
        else
        begin
          MenuHelper.ItemHeight := (ANewHeight - SeparatorCount * SeparatorWidth) div ItemCount;
          for I := 0 to Items.Count - 1 do
            if Items.Items[I].Visible then
              Items.Items[I].Width := ANewWidth;
          ANewHeight := GetItemsHeight;
        end;
        Inc(ANewWidth, MenuHelper.BorderLeftWidth(nil) + MenuHelper.BorderRightWidth(nil));
        Inc(ANewHeight, MenuHelper.BorderBottomWidth(nil) + MenuHelper.BorderTopWidth(nil));
      end;
end;

function TcxWebMainMenu.GetItemsHeight: Integer;
var
  I: Integer;
begin
  if not Horizontal then
  begin
    Result := 0;
    for I := 0 to Items.Count - 1 do
      if Items.Items[I].Visible then
        if IsSeparator(Items.Items[I]) then
          Inc(Result, SeparatorWidth)
        else Inc(Result, ItemHeight);
  end
  else Result := Height;
end;

function TcxWebMainMenu.GetItemsWidth: Integer;
var
  I: Integer;
begin
  if Horizontal then
  begin
    Result := 0;
    for I := 0 to Items.Count - 1 do
      if Items.Items[I].Visible then
        if IsSeparator(Items.Items[I]) then
          Inc(Result, SeparatorWidth)
        else Inc(Result, Items.Items[I].Width);
  end
  else Result := Width;
end;

function TcxWebMainMenu.GetMinHeight: Integer;
begin
  Result := 0; // TODO
end;

function TcxWebMainMenu.GetMinWidth: Integer;
begin
  Result := 0; // TODO
end;

{ actions }
procedure TcxWebMainMenu.RegisterActions;
begin
  WebActionsHelper.RegisterAction('', WebClick);
  WebActionsHelper.RegisterAction('CLICK', WebClick);
end;

{ events }
function TcxWebMainMenu.GetWebEventsHelper: TcxWebMenuEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebMenuEventsHelper;
end;

class function TcxWebMainMenu.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebMenuEventsHelper;
end;

{ renderers }
procedure TcxWebMainMenu.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebMainMenuRenderer);
//  WebRenderHelper.RegisterRenderer(TcxWebMainMenuIE4Renderer);
//  WebRenderHelper.RegisterRenderer(TcxWebMainMenuNS4Renderer);
end;

{ scripts }
procedure TcxWebMainMenu.ScriptsSubscription;
begin
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
  WebScriptsHelper.ScriptSubscription(TcxWebInitScript);
end;

function TcxWebMainMenu.GetMenuZIndex: Integer;
begin
  Result := ZIndex;
end;

function TcxWebMainMenu.GetMenuHelper: TcxWebMenuHelper;
begin
  Result := FMenuHelper;
end;

procedure TcxWebMainMenu.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TcxWebMainMenu.EndUpdate;
begin
  Dec(FUpdateLock);
end;

procedure TcxWebMainMenu.UpdateMenu;
var
  AHeight, AWidth: Integer;
begin
  BeginUpdate;
  try
    if not IsLoading and (Items.Count > 0) then
    begin
      if Horizontal then
      begin
        AWidth := GetItemsWidth;
        AHeight := MenuHelper.ItemHeight;
      end
      else
      begin
        AWidth := Items.Items[0].Width;
        AHeight := GetItemsHeight;
      end;
      SetBounds(Left, Top, AWidth + MenuHelper.BorderLeftWidth(nil) + MenuHelper.BorderRightWidth(nil),
          AHeight + MenuHelper.BorderBottomWidth(nil) + MenuHelper.BorderTopWidth(nil));
    end;
  finally
    EndUpdate;
    UpdateDesignerContext;
  end;
end;

function TcxWebMainMenu.GetImages: TcxWebImageList;
begin
  Result := MenuHelper.Images;
end;

procedure TcxWebMainMenu.SetImages(const Value: TcxWebImageList);
begin
  MenuHelper.Images := Value;
end;

function TcxWebMainMenu.GetItemHeight: Integer;
begin
  Result := MenuHelper.ItemHeight;
end;

procedure TcxWebMainMenu.SetItemHeight(const Value: Integer);
var
  AHeight: Integer;
begin
  if MenuHelper.ItemHeight <> Value then
  begin
    MenuHelper.ItemHeight := Value;
    if not IsLoading and (Items.Count > 0) then
    begin
      if Horizontal then
        AHeight := Value
      else AHeight := GetItemsHeight;
      SetBounds(Left, Top, Width, AHeight + MenuHelper.BorderBottomWidth(nil) + MenuHelper.BorderTopWidth(nil));
    end;
  end;
end;

function TcxWebMainMenu.GetDisabledStyles: TcxWebStyles;
begin
  Result := MenuHelper.DisabledStyles;
end;

procedure TcxWebMainMenu.SetDisabledStyles(const Value: TcxWebStyles);
begin
  MenuHelper.DisabledStyles := Value;
end;

function TcxWebMainMenu.GetImagesBackgroundColor: TcxWebColor;
begin
  Result := MenuHelper.ImagesBackgroundColor;
end;

procedure TcxWebMainMenu.SetImagesBackgroundColor(const Value: TcxWebColor);
begin
  MenuHelper.ImagesBackgroundColor := Value;
end;

{ TcxWebMainMenuRenderer }

function TcxWebMainMenuRenderer.GetMainMenu: TcxWebMainMenu;
begin
  Result := Component as TcxWebMainMenu;
end;

function TcxWebMainMenuRenderer.MenuHelper: TcxWebMainMenuHelper;
begin
  Result := MainMenu.MenuHelper;
end;

class procedure TcxWebMainMenuRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxMenuScriptName);
  AList.Add(scxMenuGlobalScriptName);
end;

procedure TcxWebMainMenuRenderer.WriteScripts;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteText('var menu = CreateMainMenu();');
  HTMLTextBuilder.WriteText(Format('menu.id = "%s";', [MainMenu.Name]));
  if MainMenu.Horizontal then
    HTMLTextBuilder.WriteText('menu.horizontal = 1;')
  else HTMLTextBuilder.WriteText('menu.horizontal = 0;');
  HTMLTextBuilder.WriteText(Format('menu.width = %d;', [MainMenu.Width]));  
  HTMLTextBuilder.WriteText(Format('menu.itemHeight = %d;', [MainMenu.ItemHeight]));
  if MainMenu.Items.VisibleItemCount > 0 then
    for I := 0 to MainMenu.Items.Count - 1 do
    begin
      if not MainMenu.Items[I].Visible then continue;
      if MainMenu.Items[I].Break = mbBreak then continue;
      MenuHelper.WriteItemScript(HTMLTextBuilder, MainMenu.Items[I]);
    end;
end;

procedure TcxWebMainMenuRenderer.WriteOutOfFormHTML;
var
  I: Integer;
begin
  if HTMLTextBuilder.Browser = TcxWebBrowserNS4 then
    for I := 0 to MainMenu.Items.Count - 1 do
      MenuHelper.WriteItemSelected(HTMLTextBuilder, MainMenu.Items.Items[I], MainMenu.Horizontal);

  for I := 0 to MainMenu.Items.Count - 1 do
    MenuHelper.WriteItemSubMenu(HTMLTextBuilder, MainMenu.Items.Items[I]);
end;

procedure TcxWebMainMenuRenderer.WriteHTML;
var
  I: Integer;
begin
  if (MainMenu.Items.Count = 0) and not MainMenu.IsDesigning then exit;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  WriteID;
  WriteAttributes;
  WritePosition;
  WriteSize;
  WriteZIndex;
  WriteStyleAttributes;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, MainMenu.Width);
  HTMLTextBuilder.WriteEventAttribute(eOnSelectStart, 'return false;');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(MenuHelper.BorderTopColor(nil)));
  WriteInvisibleImage(1, MenuHelper.BorderTopWidth(nil));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(MenuHelper.BorderLeftColor(nil)));
  WriteInvisibleImage(MenuHelper.BorderLeftWidth(nil), 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, MainMenu.Width - MenuHelper.BorderLeftWidth(nil) - MenuHelper.BorderRightWidth(nil));

  if MainMenu.Items.Count > 0 then
  begin
    for I := 0 to MainMenu.Items.Count - 1 do
      if MainMenu.Items.Items[I].Visible then
        MenuHelper.WriteItem(HTMLTextBuilder, MainMenu.Items.Items[I], MainMenu.Horizontal);
  end
  else
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
    HTMLTextBuilder.WriteAttribute(aWidth, MainMenu.Width - MenuHelper.BorderLeftWidth(nil) - MenuHelper.BorderRightWidth(nil));
    HTMLTextBuilder.WriteAttribute(aHeight, MainMenu.Height - MenuHelper.BorderTopWidth(nil) - MenuHelper.BorderBottomWidth(nil));
    HTMLTextBuilder.WriteText('&nbsp;Menu is empty', False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);
  end;

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(MenuHelper.BorderRightColor(nil)));
  WriteInvisibleImage(MenuHelper.BorderRightWidth(nil), 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aColspan, 3);
  HTMLTextBuilder.WriteAttribute(aBgcolor, cxWebColorToWebString(MenuHelper.BorderBottomColor(nil)));
  WriteInvisibleImage(1, MenuHelper.BorderBottomWidth(nil));
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

class procedure TcxWebMainMenuRenderer.WriteStyles(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  TcxMenuSelectedStyle.WriteStyle(HTMLTextBuilder);
  TcxMenuLinkStyle.WriteStyle(HTMLTextBuilder);
end;

initialization
  RegisterClasses([TcxWebMainMenu]);

end.
