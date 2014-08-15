
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars converter component                             }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxBarConverter;

{$I cxVer.inc}

interface

uses
  Classes, Menus,{$IFDEF DELPHI6} DesignIntf, DesignEditors,{$ELSE} DsgnIntf,{$ENDIF} dxBar;

procedure dxBarConvert(AMenu: TMenu; ABarManager: TdxBarManager; ADesigner: IDesigner);

implementation

uses
  SysUtils, Controls, Forms, dxBarCustomCustomizationForm;

procedure dxBarConvert(AMenu: TMenu; ABarManager: TdxBarManager; ADesigner: IDesigner);

  function FindItem(const ACaption: string; AOnClick: Pointer): TdxBarItem;
  var
    I: Integer;
    AItem: TdxBarItem;
  begin
    Result := nil;
    for I := 0 to ABarManager.ItemCount - 1 do
    begin
      AItem := ABarManager.Items[I];
      if (AItem is TdxBarButton) and (AItem.Caption = ACaption) and (@AItem.OnClick = AOnClick) then
      begin
        Result := AItem;
        Break;
      end;
    end;
  end;

  function AddCategory(AName: string): Integer;
  var
    ACategoryName: string;
  begin
    with ABarManager.Categories do
    begin
      ACategoryName := AName;
      Result := IndexOf(ACategoryName);
      if Result < 0 then
        Result := Add(ACategoryName);
    end;
  end;

  function ConvertItem(AItemLinks: TdxBarItemLinks; AMenuItem: TMenuItem; ACategory: Integer; ANeedCreateCategory: Boolean): TdxBarItem;
  var
    ABarItem, AChildItem: TdxBarItem;
    AItemLink: TdxBarItemLink;
    ABeginGroup: Boolean;
    AMenuItemName: string;
  begin
    if AMenuItem.Parent = nil then
      ABarItem := nil
    else
    begin
      if AMenuItem.Count > 0 then
        ABarItem := TdxBarSubItem.Create(ABarManager.Owner)
      else
      begin
        ABarItem := FindItem(AMenuItem.Caption, @AMenuItem.OnClick);
        if ABarItem <> nil then
        begin
          AMenuItem.Free;
          Result := ABarItem;
          Exit;
        end
        else
          ABarItem := TdxBarButton.Create(ABarManager.Owner);
      end;
      ABarItem.Category := ACategory;
    end;

    with AMenuItem do
    begin
      if ABarItem <> nil then
      begin
      {$IFDEF DELPHI4}
        ABarItem.Action := Action;
        ABarItem.ImageIndex := ImageIndex;
      {$ENDIF}
        ABarItem.Caption := Caption;
        ABarItem.Enabled := Enabled;
        ABarItem.HelpContext := HelpContext;
        ABarItem.Hint := Hint;
        ABarItem.ShortCut := ShortCut;
        ABarItem.Tag := Tag;
        ABarItem.OnClick := OnClick;
        if ABarItem is TdxBarButton then
          with TdxBarButton(ABarItem) do
          begin
            if Checked or RadioItem then ButtonStyle := bsChecked;
            if RadioItem then GroupIndex := AMenuItem.GroupIndex;
            Down := Checked;
          end;

        if (Count > 0) and ANeedCreateCategory then
          ACategory := AddCategory(GetTextOf(Caption));
      end;

      ABeginGroup := False;
      while Count > 0 do
        if Items[0].Caption = '-' then
        begin
          ABeginGroup := True;
          Items[0].Free;
        end
        else
        begin
          AChildItem := ConvertItem(AItemLinks, Items[0], ACategory, (Parent = nil) and (AMenu is TMainMenu));
          if Parent = nil then
            AItemLink := AItemLinks.Add
          else
            AItemLink := TdxBarSubItem(ABarItem).ItemLinks.Add;
          AItemLink.Item := AChildItem;
          if ABeginGroup then
          begin
            AItemLink.BeginGroup := True;
            ABeginGroup := False;
          end;
        end;
    end;

    AMenuItemName := AMenuItem.Name;
    if AMenuItem.Parent <> nil then
      AMenuItem.Free;
    if ABarItem <> nil then
      ABarItem.Name := AMenuItemName;

    Result := ABarItem;
  end;

var
  ACategoryName, APopupMenuName: string;
  ACategory: Integer;
  ABarPopupMenu: TdxBarPopupMenu;
  AItemLinks: TdxBarItemLinks;
begin
  Screen.Cursor := crHourGlass;
  try
    if AMenu is TMainMenu then
    begin
      ACategoryName := 'Menus';
      ABarPopupMenu := nil;
      if ABarManager.MainMenuBar = nil then
        with ABarManager.Bars.Add do
        begin
          Caption := 'Main Menu';
          DockingStyle := dsTop;
          IsMainMenu := True;
          Visible := True;
        end;
      AItemLinks := ABarManager.MainMenuBar.ItemLinks;
    end
    else
    begin
      APopupMenuName := AMenu.Name;
      ACategoryName := APopupMenuName;
      with LongRec(AMenu.DesignInfo) do
        ABarPopupMenu := TdxBarPopupMenu(ADesigner.CreateComponent(TdxBarPopupMenu, ABarManager.Owner, Lo, Hi, 1, 1));
      ABarPopupMenu.OnPopup := (AMenu as TPopupMenu).OnPopup;
      AItemLinks := ABarPopupMenu.ItemLinks;
    end;
    if ABarManager.Images = nil then
      ABarManager.Images := AMenu.Images;

    ACategory := AddCategory(ACategoryName);

    ABarManager.BeginUpdate;
    try
      ConvertItem(AItemLinks, AMenu.Items, ACategory, False);
    finally
      ABarManager.EndUpdate;
    end;

    AMenu.Free;
    ABarManager.Categories.Move(ACategory, ABarManager.Categories.Count - 1);
    if ABarPopupMenu <> nil then
      ABarPopupMenu.Name := APopupMenuName;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
