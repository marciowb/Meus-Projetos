
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressPageControl                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPAGECONTROL AND ALL            }
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

unit cxPCGoDialog;

{$I cxVer.inc}

interface

uses
  Windows, Menus;

type
  TcxPCGoDialogClickEvent = procedure(ATabControlItemIndex: Integer) of object;

  { TcxPCGoDialog }

  TcxPCGoDialog = class(TPopupMenu)
  private
    FOnClick: TcxPCGoDialogClickEvent;
    procedure DoClick(ATabControlItemIndex: Integer);
    function GetDialogPosition: TPoint;
    procedure InitializeItems(ASortItems: Boolean);
    procedure ItemClick(Sender: TObject);
  public
    procedure Popup(ASortItems: Boolean); reintroduce;
    property OnClick: TcxPCGoDialogClickEvent read FOnClick write FOnClick;
  end;

implementation

uses
  Classes, Controls, SysUtils, cxPC, cxControls;

type
  TcxCustomTabControlAccess = class(TcxCustomTabControl);

{ TcxPCGoDialog }

procedure TcxPCGoDialog.Popup(ASortItems: Boolean);
var
  P: TPoint;
begin
  InitializeItems(ASortItems);
  P := GetDialogPosition;
  inherited Popup(P.X, P.Y);
end;

procedure TcxPCGoDialog.DoClick(ATabControlItemIndex: Integer);
begin
  if Assigned(FOnClick) then
    FOnClick(ATabControlItemIndex);
end;

function TcxPCGoDialog.GetDialogPosition: TPoint;
var
  R: TRect;
begin
  R := TcxCustomTabControl(Owner).Painter.GetGoDialogButtonBounds;
  Result := TcxCustomTabControl(Owner).ClientToScreen(Point(R.Left, R.Bottom));
end;

procedure TcxPCGoDialog.InitializeItems(ASortItems: Boolean);

  procedure PrepareItemCaptionList(ATabControl: TcxCustomTabControl; AList: TStringList; ASortItems: Boolean);
  var
    ATab: TcxTab;
    I: Integer;
  begin
    for I := 0 to ATabControl.Tabs.VisibleTabsCount - 1 do
    begin
      ATab := ATabControl.Tabs.VisibleTabs[I];
      if ATab.RealEnabled then
        AList.AddObject(RemoveAccelChars(ATab.Caption, False), ATab);
    end;
    AList.Sorted := ASortItems;
  end;

var
  AItemCaptionList: TStringList;
  AMenuItem: TMenuItem;
  I: Integer;
  ATabControl: TcxCustomTabControlAccess;
  ATab: TcxTab;
begin
  AItemCaptionList := TStringList.Create;
  try
    ATabControl := TcxCustomTabControlAccess(Owner);
    PrepareItemCaptionList(ATabControl, AItemCaptionList, ASortItems);
    Images := ATabControl.Images;
    Items.Clear;
    for I := 0 to AItemCaptionList.Count - 1 do
    begin
      AMenuItem := TMenuItem.Create(Self);
      ATab := TcxTab(AItemCaptionList.Objects[I]);
      AMenuItem.Caption := ATab.Caption;
      AMenuItem.Tag := ATab.Index;
      AMenuItem.Checked := ATab.Index = ATabControl.TabIndex;
      AMenuItem.Default := ATab.Index = ATabControl.TabIndex;
      AMenuItem.ImageIndex := ATab.ImageIndex;
      AMenuItem.OnClick := ItemClick;
      Items.Add(AMenuItem);
    end;
  finally
    FreeAndNil(AItemCaptionList);
  end;
end;

procedure TcxPCGoDialog.ItemClick(Sender: TObject);
begin
  DoClick(TMenuItem(Sender).Tag);
end;

end.

