{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire coVisntents of this file is protected by U.S. and    }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSHFToolBarBld;

interface

{$I cxVer.inc}
                           
uses
  Classes, ComCtrls, Controls, ImgList;
  
type
  TdxPSHFToolBarBuilder = class
  public
    class procedure Build(AToolBar: TToolBar; 
      AImageList: TCustomImageList;
      AIncludeAutoTextEntries: Boolean; AFunctionList, AAutoHFTextEntries: TStrings;
      AOnButtonClick, AOnAutoTextEntriesClick: TNotifyEvent; ACenteringToolbar: Boolean);
    class procedure ShowAutoHFTextEntriesPopup(Sender: TObject); 
  end;  

implementation

uses
  Windows, ExtCtrls, Buttons, Menus, Graphics, SysUtils, cxClasses, dxPSGlBl, 
  dxPSUtl, dxPgSDlg, dxPSRes, dxPSPopupMan;

var
  FDropDownGlyph: TBitmap;
  
class procedure TdxPSHFToolBarBuilder.Build(AToolBar: TToolBar;
  AImageList: TCustomImageList; AIncludeAutoTextEntries: Boolean; 
  AFunctionList, AAutoHFTextEntries: TStrings; AOnButtonClick, 
  AOnAutoTextEntriesClick: TNotifyEvent; ACenteringToolbar: Boolean);
var
  S: string;
  DC: HDC;
  TextSize: TSize;
  MenuButton: TSpeedButton;
  AutoHFTextEntriesPopup: TPopupMenu;
  MenuItem: TMenuItem;
  I, SummaryWidth, MaxButtonCount, MenuButtonWidth: Integer;  
begin
  while AToolBar.ButtonCount > 0 do 
    AToolBar.Buttons[0].Free;

  S := cxGetResourceString(@sdxMenuInsertAutoTextEntriesSubItem);
    
  MenuButtonWidth := 0;
  if AIncludeAutoTextEntries then 
  begin
    DC := GetDC(0);
    GetTextExtentPoint32(DC, PChar(S), Length(S), TextSize); 
    ReleaseDC(0, DC);
    MenuButtonWidth := 3 * 2 + TextSize.cX + 16;
  end;
      
  if AFunctionList.Count > 0 then
  begin
    AImageList.AllocBy := AFunctionList.Count;
    for I := 0 to AFunctionList.Count - 1 do
      with TdxHFCustomFunction(AFunctionList.Objects[I]) do
        if (Glyph <> nil) and not Glyph.Empty then
          AImageList.AddMasked(Glyph, Glyph.Canvas.Pixels[0, Glyph.Height - 1]);
    AToolBar.Images := AImageList;
    
    SummaryWidth := MenuButtonWidth + AToolBar.ButtonWidth * AFunctionList.Count + 4;
    if SummaryWidth > AToolBar.Parent.Width - 4 then
    begin
      SummaryWidth := AToolBar.Parent.Width - 4;
      MaxButtonCount := (SummaryWidth - 4 - MenuButtonWidth) div AToolBar.ButtonWidth;
      SummaryWidth := MenuButtonWidth + MaxButtonCount * AToolBar.ButtonWidth + 4;
    end
    else
      MaxButtonCount := AFunctionList.Count;
      
    AToolBar.Width := SummaryWidth;
    if ACenteringToolbar then 
      AToolBar.Left := (AToolBar.Parent.Width - AToolBar.Width) div 2;      
      
    for I := 0 to MaxButtonCount - 1 do
      with TToolButton.Create(AToolBar) do
      begin
        Parent := AToolBar;
        Tag := MakeTTag(I);
        ImageIndex := Integer(Tag);
        Hint := TdxHFCustomFunction(AFunctionList.Objects[I]).Hint;
        OnClick := AOnButtonClick;
      end;
  end;
  
  if AIncludeAutoTextEntries then 
  begin
    MenuButton := TSpeedButton.Create(AToolBar); 
    MenuButton.Parent := AToolBar;
    MenuButton.SetBounds(0, 0, MenuButtonWidth, AToolBar.Height);
    MenuButton.Caption := S;
    MenuButton.Layout := blGlyphRight;
    MenuButton.Glyph := FDropDownGlyph;
    
    AutoHFTextEntriesPopup := TPopupMenu.Create(AToolBar);
   {$IFDEF DELPHI5} 
    AutoHFTextEntriesPopup.AutoHotkeys := maManual;
   {$ENDIF} 
    if AAutoHFTextEntries <> nil then
      for I := 0 to AAutoHFTextEntries.Count - 1 do 
      begin
        MenuItem := TMenuItem.Create(AToolBar);
        MenuItem.Caption := AAutoHFTextEntries[I];
        MenuItem.Tag := MakeTTag(I); 
        MenuItem.OnClick := AOnAutoTextEntriesClick;
        AutoHFTextEntriesPopup.Items.Add(MenuItem);
      end;
    
    MenuButton.Tag := MakeTTag(AutoHFTextEntriesPopup);    
    MenuButton.OnClick := ShowAutoHFTextEntriesPopup;
  end;
  
  AToolBar.Visible := AToolBar.ButtonCount > 0;
end;

class procedure TdxPSHFToolBarBuilder.ShowAutoHFTextEntriesPopup(Sender: TObject);
var
  Button: TControl;
begin
  Button := TControl(Sender);
  if TTagToObj(Button.Tag) is TPopupMenu then 
    dxPSPopupMenuController.ShowPopup(Button.ClientOrigin.X, Button.ClientOrigin.Y + Button.Height, 
      nil, TPopupMenu(TTagToObj(Button.Tag)));
end;

initialization
  FDropDownGlyph := CreateArrowBitmap(udgDown, 12);
  
finalization
  FreeAndNil(FDropDownGlyph);
  
end.
    
 

 
